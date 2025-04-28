Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD80C369D9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 17:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77E910E63B;
	Mon, 28 Apr 2025 17:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+IbLB1e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D56B10E636
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 17:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DImxBHbY0kfhzsBBQ/3S1qSRsus4p5qEErbkH+1p6XOG8aDJjvHB1zLfSBQ/dPJ3nm61iqclwvXhZ1PY7BtuQRSxQ1Bj/qvrV0CnUZBMJWwfHc754YfksERzaXwZbrDr/Y+ycSzTw2fU/17XQv0Rv3JYzWOoMZUj+ueXOsWFIXuf0JmvRqtKFZ72FKWepw4eM/D61/vx4sjUx/zhk4yDOi33kQo1k7s4GYRqcOvqq3RCGW+9gtuBzAVlz/hxMN+LhBqMEEbYkcz13nwtHEHqjkmVSNY+0d9lwxwUhoBhzDllM6zXPW9llxbeS+XtkgHILruvrT0DVMu/+oEA0lc5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ+tEBHBPCuIAF3oJOKBeRILXAqvboPvg2dQ2cod160=;
 b=I6a/jNig9EdwgC3ZZlYZ/Brw2nWLq94K5NQVaerrnaWHWNOjmU9uVG+Z/5HIz555HWtn/KfL/FreHCj3Owe2qaj+flYf/eExwn8jssKe2sl3gvw/lbFOJCWWrz66r/n5u1k/B/RTdP1/CAS4uq0+2V6zuJN3DBeJGDh8eXTkuxsiFjwLA0aESniRt9WloM8GJJmPVtJgGXxpN7nqScwhyvMUh74FMGiIp+6y+YURVwN0Zuwt7ot1K5nkiJ6Ccocp7ugGZz9fvezZBQ16+8IbOeGv1hpndSFRqVR5+XObZw1YqYf4ZGnAC4/URu6sKAt8OEQL9sqtSLcweMuaTFAqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ+tEBHBPCuIAF3oJOKBeRILXAqvboPvg2dQ2cod160=;
 b=d+IbLB1exZhIe3NYrL19GGTLh3cxuJePn1AgJoOHFaf9XzVaTpr1Mv4wOcgkC/KojbFPPJT9GLh8lqNvskJF+Iad5U3Y0nHR93ET7bvz7LJW+v+/YH6MWXIFy2cIlAKjHEXz0R8q3Cyy+ng9CKqSwWkUQr+SaCxyomcH6AguATc=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 17:26:50 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:26:50 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Print bootloader status for long waits
Thread-Topic: [PATCH] drm/amdgpu: Print bootloader status for long waits
Thread-Index: AQHbuCW3De8IpH3OV0qgOZDdD6loQbO5VRTw
Date: Mon, 28 Apr 2025 17:26:50 +0000
Message-ID: <DS7PR12MB60710787E4B899CCD58FB1D58E812@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250428100943.959357-1-lijo.lazar@amd.com>
In-Reply-To: <20250428100943.959357-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=83e612ce-5176-418c-a816-93e2b234c59f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T17:26:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SJ0PR12MB6806:EE_
x-ms-office365-filtering-correlation-id: 73b14637-8b8c-474b-6f58-08dd8679dca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ueG/CcpwMPyjG5SjJac4Pux7tk17My0rofbYrPZYCpo0aJwFouOzYOIzwAHU?=
 =?us-ascii?Q?kHLlS6JarpG+Os7Uxss9uVIZG4iGE37XdudB4CCJoxOPNJYpJhM90T8JkccD?=
 =?us-ascii?Q?mO0Ww7l8BcCtVV8xTnHa1R3bP/Zfe+mcxw27xzqGsL6XTDo5Dk1f6GSeGZc9?=
 =?us-ascii?Q?CvEe6LozCUMxHZKgkb7ShO4x10Tn0CgvGSV1qQDA612mmmES69veOUHj0NFK?=
 =?us-ascii?Q?AbsypRudlyUKW4ogwqAmCVnvVKUIcWKVYlSc5JOIH3zEKOb7/zecD7TTxsOO?=
 =?us-ascii?Q?e5FWXkxTNylOIFzOeewgi19a8ycMFnqeG9FDy/kGm867akB1sQ6VRGntvRZ+?=
 =?us-ascii?Q?ennDdjnDnTZb24eogdG58jPKp2Fgp8hVazAI9VWst0UqA9vMIhF2ezrEB9mc?=
 =?us-ascii?Q?6FSpbXLFD6MLYmo2YRYT7zIQ/JvZ1Pp2xkPkcJNgeDZ9J82VlN41pB3k+yo2?=
 =?us-ascii?Q?h73TSdgiVRA2O1pdhIJzA8d2FtN5Cc41jhWHjStpROasCDgL5fEVel37Y2B8?=
 =?us-ascii?Q?EnH6gKgACvZLollJ1ciGys2OKkIhQUN4Mzq9KCR+g/Q3lTC+Zc+J/z7sqBBR?=
 =?us-ascii?Q?Q5PIVXU4f2ijwb9Y92x2+EflkPur5pkebcgCBwiCjvEBEXMu/SClSs46McR3?=
 =?us-ascii?Q?oTOHnzrZvQtFL6rHKT9Wc+9NRXGhRhfS/6faYGxfPMyAQAI2+P6NOMv8vkVh?=
 =?us-ascii?Q?ruu43ETZaqDZrzTGnKkIWhXRxKcSgw/O0p3OSa771ylH3rKZLSKo3qllzto1?=
 =?us-ascii?Q?weBHZPK/gtY+MjWVJ0K/PuOzxFUfig0QYyQLuqHiAxaJHQ31lxMM+xMGt2Ul?=
 =?us-ascii?Q?wAR7kwWbZjkw3/nbYX6tHoryPUe7LqCYOy44w7G5CRTnawW5k+Dct/8Z2MXo?=
 =?us-ascii?Q?66s+8ejbCMW9ytomUBt72jvo/wFQlm6rDAibY+lyUPAp8wrFmZ/kubp6pwMn?=
 =?us-ascii?Q?dypR2a+f69hOWr2h92vKR72BvSo/GwYKbDJp223ePx3kuM7Hhs9jr9pAtMyY?=
 =?us-ascii?Q?gEZPrs4OrnTe2oomxfFyNJnjBT1YHEkD4Whf1oW8EEJX2O5sc+y5B0V7k/e4?=
 =?us-ascii?Q?pRZv3s/n1wrIz5mOdYpPQsKfCVCz8Tr1eJpwsaTqLfO94pRYj4wvpTdJiEzW?=
 =?us-ascii?Q?8XQUBYWLn2eFe8wH0wnHtxUh47RXfhDkRHFN4P/ExCHACuz4NPMJX7sgorYb?=
 =?us-ascii?Q?4ndQhv98fXkdvPWoCctVoVwWfltZE+4OeYGCab3MIYoIrealAmolRQ2tBPIn?=
 =?us-ascii?Q?voH0ETGY6PrJ3GhHMQ5Fno9TRQNGx/Ekbx5WulJKSC11/X+MCfxj5UqaH8l9?=
 =?us-ascii?Q?xA8CUEIJw5Kx3ZPXO8jHnVsLmgwSoJ/KrTBC3PVmiBrs+RuqdfOinG6GW6cR?=
 =?us-ascii?Q?uaYRax3NQjyRgUJ0qUQKIM0vps7OLVVBAYtFOn5GzAnRB+xRqVLjBSbWpVx/?=
 =?us-ascii?Q?D7/5Ztz6bkzIAa2UGNCWn/KyokWuWd8TfCWgbeCRReQXOeS4TqT6Cr85tkAB?=
 =?us-ascii?Q?V5d2uCYv+hA4P0g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1IzNE0H6n93J84BzNpybIAPCsINFqG6qzz78+dFgdNzrezBgEaPf2E+U5YOL?=
 =?us-ascii?Q?QME8pKWroV+CaagJR97zxSF3f0ENaC6iq+1UBcnO1VCXkBaJCxUGHuYaIXvI?=
 =?us-ascii?Q?biyppjf/7lkjf8/Id6QHOpwkE+G8ta5U3LPthDP99pLU+vxb4Vc5ncoB4Jux?=
 =?us-ascii?Q?TRdrOoLF7e+Ze0OjjIoFxnsgFk2ivPqmRpuIBulNA4VNWdef+jxZRgZOpfLn?=
 =?us-ascii?Q?8P2h76d65f3RTQZIH1ncuuv4LkqA9blA38PvlfMgNmGtAC40GFoJqmRnuAuQ?=
 =?us-ascii?Q?qjMJzlUGPz+H7/kkrUwJkDprbZI0LCmxZy8ISpX3ehmbKE49kauE8AXp71hU?=
 =?us-ascii?Q?QJvLVIYuHP3b62e2XcF7HGZVMWTe1ru/ztV/DrIOjlwoFBaCWrmmT3FF1AiS?=
 =?us-ascii?Q?XFIHMM7P/q+wrh2HJGB9fbf+Wh0iigkXfDwaVEpl5Seua0O1tz4ZnRVPcveq?=
 =?us-ascii?Q?9P8sqlnZLZfB6T3CJM/ERs70ROFMh0sgYAYhrUY9/wtsuE2Wn2sEUZ+rR0Xt?=
 =?us-ascii?Q?w2OFsW3XQ9sv5kBDS58XPUxMeNrZZ0SnMIDY95rHQfPTLTJP7Vv1SFNr4jf3?=
 =?us-ascii?Q?WeHxcBWbSUp+a13qY0GFSmz0L9yxACrNDFXXw1/S8ffBrVoYIfa5wxkWuwme?=
 =?us-ascii?Q?+fXoXKAaWsEK3RPm3MPwYeaXylIFLPZuPna4pJIB6M+m/Djfi8r7Vtlms9FT?=
 =?us-ascii?Q?H2WoPBvfvSSbLWUN7wdEyDx4aOqqXDFNDOnAgwWeYjOFWtg2U9vN0wu5qhCg?=
 =?us-ascii?Q?l9MYghUfknz+XsT8wbW5tp++7l1wBtjP8SWLpd1bB0CLROGIkdmCFt9sURCq?=
 =?us-ascii?Q?gWpco5rJ7NoLgzquEzEuOG6hFIRsH33dCI3gnHgYpLFBnNoHb6uoPj6lev6Z?=
 =?us-ascii?Q?E4aTOdFaF7dl4ZxHuEF0/a+I9F4+SI/Q7bpOgIAKRK0Lm+YmdDz/C3YUPnWx?=
 =?us-ascii?Q?8HGLuJ5jabkPQRkxlCRf1YleAL483E/7hSrpvpfB7/DU49bquzU3lzf1StWm?=
 =?us-ascii?Q?aguWrpNlLwdTE7NIAn7mSiNOg0qhxIomjPdXgO6wmLj8yXiMDKALV3xI0+/A?=
 =?us-ascii?Q?eDahJRB0GnA4DhT+/z8qJP1zuQErhxG685pXrjDLXrFLS/OoRL4l9PeYP45Q?=
 =?us-ascii?Q?pGZatULfMgIyVvA9y/OCr9ITEbWKEBE4cYcVg1ZBf/Xz8u0nm9flSfpTt2N/?=
 =?us-ascii?Q?tjoOKubu/rC5u4L2LiauHMta9WH6Axc0xTEhv7qJXb+vK3gatXei3/ttSfC9?=
 =?us-ascii?Q?drau6E/c/yDSlvoaC9jJ6sMZzqUa1WmagtGAIIKY+Ne7TMRFDz44IXITXTO1?=
 =?us-ascii?Q?nnG20zPeytIjcchEa2rDUkbzHpf3kMeqg/mf1lBeFfPKZoThFgWEdh5evHLk?=
 =?us-ascii?Q?bzpkGHGJMV6R34sfFE+c36yAq/eeUlc8VtJZc4W1BJUQDwZAzFS03mDZ51YB?=
 =?us-ascii?Q?pPKwd1VdIoXpcvy7fnAF/MIiP7g3mQ/ozwuNfz+0z+z+S1WiKaLmZfoazWZz?=
 =?us-ascii?Q?f8s7Yti8QUaU3b62Z1e6Kry6AXD4lrlzUUHWjO3QP1BbdstSYdS+dQfWTO5H?=
 =?us-ascii?Q?wq1SD+kAKGbPaJCeUlQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b14637-8b8c-474b-6f58-08dd8679dca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 17:26:50.6706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCHg7RuaJ3qQeOfQ3oVFZ/e68UGiu9pC001G7p8ZoGM5HES2B9J4r4gq8wepPfBLiTbUgrNJyCRIPM+YYGHbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, April 28, 2025 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: Print bootloader status for long waits

If it needs a long wait for completion of bootloader execution, report the =
status in between. That helps to know if there is some issue during bootloa=
der execution.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index f5f616ab20e7..f8af2cc63446 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -85,6 +85,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");

 #define regMP1_PUB_SCRATCH0    0x3b10090

+#define PSP13_BL_STATUS_SIZE 100
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; @@ -151,6 +153,32 @@ stat=
ic bool psp_v13_0_is_sos_alive(struct psp_context *psp)
        return sol_reg !=3D 0x0;
 }

+static void psp_v13_0_bootloader_print_status(struct psp_context *psp,
+                                             const char *msg)
+{
+       struct amdgpu_device *adev =3D psp->adev;
+       u32 bl_status_reg;
+       char bl_status_msg[PSP13_BL_STATUS_SIZE];
+       int i, at;
+
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4)) {
+               at =3D 0;
+               for_each_inst(i, adev->aid_mask) {
+                       bl_status_reg =3D
+                               (SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG=
_92)
+                                << 2) +
+                               adev->asic_funcs->encode_ext_smn_addressing=
(i);
+                       at +=3D snprintf(bl_status_msg + at,
+                                      PSP13_BL_STATUS_SIZE - at,
+                                      " status(%02i): 0x%08x", i,
+                                      RREG32_PCIE_EXT(bl_status_reg));
+               }
+               dev_info(adev->dev, "%s - %s", msg, bl_status_msg);
+       }
+}
+
 static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; @@ -196,6 +224,9 @@ stati=
c int psp_v13_0_wait_for_bootloader(struct psp_context *psp)

                if (ret =3D=3D 0)
                        return 0;
+               if (retry_loop && !(retry_loop % 10))
+                       psp_v13_0_bootloader_print_status(
+                               psp, "Waiting for bootloader completion");
        }

        return ret;
--
2.25.1

