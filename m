Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A775C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 00:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C66F10E140;
	Wed, 15 May 2024 00:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qBtPeWtI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5563010E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 00:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuaRSIKn0upo3vAL9/E6KvMWxtNWdMUFROinj5OokLFS7HgYcC+Dl7AqmNniB6inkMfP/CqT4oEVDGLFrz6HAgo8zPZ2B1nLw4Oo6T4M03XsOPl5RND2NZSOw8IOnS8Vv+asMGgCwk01TVUSHxprCjfTYI5bvFMTs5LX6RvQSbyDrVYYHNMsLY2A79g1zqF/mpxuKRXXvl2Q8515yTGeJIVQd1sh4YMLWncKrR8WMcyXsjqMtS0mmSKVnTQqf6khYur7AqvGbvdKpjsyyq2Xb2Lv1pDZIyObOryWwUW7IF+9uUfZcSeXB0xK44jOlraCFuHsgNovuPrl9FSxTYUv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2oonGv1xH2HS/kTGchRYfjmVO1tl+ws+18uwUtYg84=;
 b=K5LMSC7UW/iFMCk4QOXKu6sb6tAR/4Ut3D9nRnH5/+kPgUe4NKe+feUhpulopoJ90yJ4LGz/o/ggzn0GkKLfmH0EcsPmrU4qpJ5pUefgeuPXd/q15wnJ0+Baq9m5lixT4j5Nqz5RnJag0YYHc5l/dSilX18xvSu1Kw6FPXykO3WArTCQtCLQE8XeATCjbss+00lLsHa+xvkDGSV8GkeBdpJmRSYRZhuRvvMWafjQ1p2K8CXLTRgrjgBqhB0m8+gK9XmOcK95l4cY07bIgqXNRw9z+5w6ozs0IFmVCEgqwnfuG8EqN70P0Yv0UlmKVJguTY2Bq7yablxe0aY4x+x91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2oonGv1xH2HS/kTGchRYfjmVO1tl+ws+18uwUtYg84=;
 b=qBtPeWtInuVckzkpU5xD0ANn5zr2OSZ7YmRvWBXpiccHOek8b+c0P9hyc451QsWJGiDBWTEsGdfKZYYFarEq+gDCW/R5Z155xcnzj6iNNgnfvStEmhlQS7mnZbxAOxKqYu6aaReW9v+jOpMIg2U2YiwVk0y2uN3e6EWj1/yOo4o=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 00:30:15 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 00:30:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for
 RAS_EVENT_LOG()
Thread-Topic: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for
 RAS_EVENT_LOG()
Thread-Index: AQHapZJeVwaTA4S7IEmQ4dK4ZP+svbGXcsYw
Date: Wed, 15 May 2024 00:30:14 +0000
Message-ID: <PH7PR12MB59978E587FEDC20D2E29FD4782EC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240514000253.4028096-1-kevinyang.wang@amd.com>
In-Reply-To: <20240514000253.4028096-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d4c590f0-027f-47fb-aaec-10213947b5f0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T00:29:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: 44b32068-800e-4ee3-c5ec-08dc74763074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?gGAOxNaeg+DafODlK4wGp4Ls3u9XXC+aaSzjWmaRm/bwOwG5lzAXtBMUof7M?=
 =?us-ascii?Q?C1dYbuJksJTLC0rSbRbBLUfKo2Q4IEGnTNxShHIGMFiTvqQAJo3l9srm2WDl?=
 =?us-ascii?Q?aosxiE6ex9DhUP1KE5CYvB1+sufeZL7ZKg2QbCh4x9sDO9Jcv1kTqWvSfXRM?=
 =?us-ascii?Q?/4Ljv6flTrc7YHTN4i0LPFZ2DjEgVFDUOruRshZLIA7B/L4bacUkLNUuzlFC?=
 =?us-ascii?Q?Nk8UQV18Bsi2gHJhXC0TcrlMCAm0Mpta7FC8kCuYEFlPS7enAPE5hOcQz0LO?=
 =?us-ascii?Q?tU4irfzzZsPth22IDqHvbStT0XFxYKcrPCZUIMCb3+QnMT3a9Gr4xmaQpXK8?=
 =?us-ascii?Q?7bCdXp2yhSNS6oXFenTDJ3e4/ErhcvqZT21sc9+6HAJmRTSAvxELKRRmZLFy?=
 =?us-ascii?Q?Gw5s3OhpBDuG/c1UhyM81AK+nJPlk4P3Ph6KP4s/hvOTEnX3d6DR1ub2/eUH?=
 =?us-ascii?Q?0vJ5Hs4hXwVcpuqvDOyJ2gubmsvfz12XIGQ8IjGF+kxqH73WSBbnVBtRFVoj?=
 =?us-ascii?Q?ICqMsAh0NZZxuyGtp9V8dTdIfGXyXLWNkx/q7yTKDIQof+EPhQdSKDwut5Rm?=
 =?us-ascii?Q?ihbgiVVAPVU5QMOdrHZDxIrpASGfuWyIvEoaNjAgVBBlpCTK5o3sN0/f9O/w?=
 =?us-ascii?Q?ZlZKzZHC/iaJ+W8ZPdD+UV95+e9oOnzL9NcWd3fGGfFeDQ/Xq/SWichtzgKf?=
 =?us-ascii?Q?5FRTLwuwgzSxeA4GhPFayWXvFdt9uhreXc8FsDV5pQoh8OKtwSGtUugm/wSm?=
 =?us-ascii?Q?uYexjPoBAXmGJKiFi6wXfweXRyXYgU2ENU3vD62i+ZKfyTxFyj0B0KufbFoj?=
 =?us-ascii?Q?f783uhQSWc79esnwHKTs49tFL1LA0UITOn6+N7j6/uMsA5pwIliAeUz8oykn?=
 =?us-ascii?Q?vVVdRWo4MYtYkL3pM496d9I36chG1E9CPxs//AtJGTMOke5YPrHGHb3QEY7h?=
 =?us-ascii?Q?yh/alfhT1Z1SncoOKDqBBbNOVwtMkTR9F/uDATDee6tLxHse7rU37dqWk76/?=
 =?us-ascii?Q?TJqFTAZFT9KXSrbH+xlmy4Ri0Co9sbDEyqJpVR4ERMjxC2+XgXpUc7e0DP+T?=
 =?us-ascii?Q?50NLNZrJciBEQI9Xm56lqtdYwBlOQijyRhG5wn0SBiwsirm1r/Y1mQtJhh0u?=
 =?us-ascii?Q?HdCqR8UORJeqq6dJ8lrx8kjwz0ox9EM7wO+xc4BGHIBDCHa/xUwUsOEraFYM?=
 =?us-ascii?Q?vZvqnlx41hmCEPdzwJRdZ4by2Ruu+5ZS3aCLhBje+nGw4Ix3GaRygUjFcjek?=
 =?us-ascii?Q?+iGEj+VcMi0lzKkbY8kDN2ZV7z/fcXmCinfAtYHvwxyu9VwZhN12DidMEdhq?=
 =?us-ascii?Q?+5KsRbltNow0ETe7lSuvClVztZFPYMPKHqrUOK4b9wcEHQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wcW+gFO8Kadw9ofWYmxRHGS/DfOrG/ir5gYxNggYA/8HMfpUd5kCw5MGflCj?=
 =?us-ascii?Q?fubMgdm4sTmrBM2ZbLoELOcCjr9ouAvPmGVkKd6JljHlUmFNpXL/ec6GUM6Y?=
 =?us-ascii?Q?57SR3mnXb4XoiAWjYOM5V+SbitfalnIoclTpxvf9ZnRhgzZC3SswAR+xLf+3?=
 =?us-ascii?Q?FZPC8YlRjgpFckLdiYR0LsAoQK+GmaQw2GNYUiY4Oy9RV9RKm3GtW0QpqzMG?=
 =?us-ascii?Q?p8QgU4PziAz/vNjB7Iwf4Egwt3+IjVYq6WgXFxQ9IfJT+9/fm63Fa1onAX5B?=
 =?us-ascii?Q?cVFdjnmNE6BclFAWOkOGnuhM5FWdgSAomiWdn1+fJy5jmUVBeFU1vNXRgQBd?=
 =?us-ascii?Q?goXOu5DWnsj8G1iKfLt+vJv4IMDJui8lpu+ngweP7ybG/MBwbyOqjLoaJL6Y?=
 =?us-ascii?Q?8bpz3oO6sSMUt36WzxVCTuEmAW0yCbJSRfEKipOc++T99je5FRCLvquZ0QcQ?=
 =?us-ascii?Q?ofG6/+7xThRVxlJLfcYeUS3DDPcTAST4RvBpCFMc+GasWN5D8Kr5BHt/2Ggn?=
 =?us-ascii?Q?lku7TINSPX8OUp01zhEiefvwx2K1S5W0Slw4TcXAdGY29SK3OSEu6kH2CRQr?=
 =?us-ascii?Q?JrszKMTjJ49d5QiPoCZ1tgLV6OIWbklDvyTSlejciOzGgv4ThKCcilrmBUAG?=
 =?us-ascii?Q?hVYXgY6Um7VXxxBPYz9pE9pgUXwphqub/XMIc83hcTcO/ModqgjA0NIjPqJ2?=
 =?us-ascii?Q?PuVb/p4m77k6Rk33NQyMnHYV4vFtuJzzfW0/UEQyZM/nkIcbHFR5al6iVPcV?=
 =?us-ascii?Q?x6zUMOCbO/MmkzfgPadtxS+2LIxGx4jUVZxqFn3vISDc1BaJN/Xhvoo7Vmw8?=
 =?us-ascii?Q?OLCx0X0xCihuQfU792TiYFqofYNMe2epGnCoRDiVPJu9UFTMxSjb5tdJmwNy?=
 =?us-ascii?Q?ZRxMyu9poO3E0m8fQrCDJK5v4QUNzXz07vGjrdrJu/9mNveGxdsgzPb38Utx?=
 =?us-ascii?Q?7uSOCjQW2GVdS2JjMIJiSRefD705wb1dyVtMdgY+VRb+aumVwoYqJp3kEg6E?=
 =?us-ascii?Q?Refrxxmh26gpLQZNk2lkNkRIzCyCK7vFNPmOozNwQWxuwpwlTEuHLV+Y4XjH?=
 =?us-ascii?Q?H+o9qV2zzUvzUf8KUrd2qflyHW/XWqVMqXxpG5iXMHq6dES6t0P1gsvzZB2r?=
 =?us-ascii?Q?hEk29aWJ6ivhTw8NaBdrlt45EGsT0U0/qgtnHC6HVxT6pqTI3eZagMzyYdEu?=
 =?us-ascii?Q?WSdA6KmOXYR2lm59JHul1e2wMdfR7TcXwtbiN4cikFF/KM6ybr0yozKolGyf?=
 =?us-ascii?Q?IDGrrIspynAjUNdyzA1QJQXEN0kvl+RbC9+E48xDLMav1Ltyt6DfpMyqKrdV?=
 =?us-ascii?Q?UODSBXhTXfEHDT23kw9dTg9bXuytPpw+xvT+ljRExUb4Opedi3qS7co2UuLK?=
 =?us-ascii?Q?F0a5uvZPwO3dUXSfxQqSd/M6B0tNXPpbJetT039qrs1ljfixVB0ffE/fx5J1?=
 =?us-ascii?Q?/Mya3nzEJq78tpR9tkjf1QVB57W72jA8pgu65LMszfJDheFUYWCJKitNT1Ow?=
 =?us-ascii?Q?ahpRojy5Wpk7zI3TwFLMpHtszugIq9URLYageprl5ii0LZSBMauWCpsi3TBv?=
 =?us-ascii?Q?gQm4tU4vgyo4ZE53bh0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b32068-800e-4ee3-c5ec-08dc74763074
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 00:30:14.7578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D47NQC6yYjcMOI6GhoIGJqjBCydpBXWQw3HCSmbj2ATrMtkDR1S1FQXzZTPQsJHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Ping...

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, May 14, 2024 8:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for RAS=
_EVENT_LOG()

create a new helper function to avoid compiler 'side-effect'
check about RAS_EVENT_LOG() macro.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++++  drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.h | 13 ++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1dd13ed3b7b5..c04e6ced1af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4504,3 +4504,21 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *ad=
ev, uint64_t pfn)

        return ret;
 }
+
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+                               const char *fmt, ...)
+{
+       struct va_format vaf;
+       va_list args;
+
+       va_start(args, fmt);
+       vaf.fmt =3D fmt;
+       vaf.va =3D &args;
+
+       if (amdgpu_ras_event_id_is_valid(adev, event_id))
+               dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &va=
f);
+       else
+               dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
+
+       va_end(args);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index c8980d5f6540..6a8c7b1609df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -67,13 +67,8 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */  #define AMDGPU_RAS_GET_FEATU=
RES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)

-#define RAS_EVENT_LOG(_adev, _id, _fmt, ...)                           \
-do {                                                                   \
-       if (amdgpu_ras_event_id_is_valid((_adev), (_id)))                  =
     \
-           dev_info((_adev)->dev, "{%llu}" _fmt, (_id), ##__VA_ARGS__);   =
     \
-       else                                                            \
-           dev_info((_adev)->dev, _fmt, ##__VA_ARGS__);                   =
     \
-} while (0)
+#define RAS_EVENT_LOG(adev, id, fmt, ...)      \
+       amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);

 enum amdgpu_ras_block {
        AMDGPU_RAS_BLOCK__UMC =3D 0,
@@ -956,4 +951,8 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *ade=
v,
                enum amdgpu_ras_block block, uint16_t pasid,
                pasid_notify pasid_fn, void *data, uint32_t reset);

+__printf(3, 4)
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+                               const char *fmt, ...);
+
 #endif
--
2.34.1

