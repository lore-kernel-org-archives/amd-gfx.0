Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACC9C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 07:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401CE10E482;
	Wed, 15 May 2024 07:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8tF4tIQ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C93210E482
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 07:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV8BGWqZ2ma3oQxM8LNoCiX+29kVrb4ZN3o2SCh7R/sLoWPy1SLktE0yrHQDqxB47NC6IaVDDvn7ILNHXaNRU+Z2zDeGr9XmqH6QLmKrwe3gLy/KDFfRYxf8vgie3ZKkgUzuCvXyhgCPjU2DWxwT3G07GZkuIWBigv5U3KD2invUh4OrfvXUuiI1tNFpSZkme2FcLCmJUJ4r1J/gU6QoH+peDojQs1oIoiYkoPqXUF/HPEfxKrXAMzgZYJb8aAdyc8l981mte0ocn5wuCpMpRVosCFVjCcQLR7NSL9pf3n4fhCdb6VI8I7IW6jPrLE4fLMWNC9bo9MYnjXiHD/bsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf1aAE8ClHjB/dPjjq/fE+BJgGpw4aS0asYvhLZfRsU=;
 b=R/Q2s9dIMyvKVLexfmm4TXgo1GVMxByn0TYRP5qizRRAcbzC+HXR5OWkiLjAozofCdk5vy3CWcfOARFiCKILb5tAmIvUWhj5/LGB6TOQK2f1xWPoI4iO+tMlLIQzW+ES4EIPf5EnfIa14uEcjHZPMtxeQLW72fdxipHbh07w8DyMtnVwdMmcRAZglANLB5GpRfHHe2hsJmLMieW0DOZ+75q0owZXEOQhoPM4VwsPY4fAFZsl1wLOGU71JUsY4b2VnlsQSX+LdEi4HlnkiLzyWppnPsYzzehK/OBzRF9Km8+qtfo/QjggHUNNn1IKQLF1jM2mDLOMUs4VJbGwg4aSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf1aAE8ClHjB/dPjjq/fE+BJgGpw4aS0asYvhLZfRsU=;
 b=l8tF4tIQqRJuTQTAcPv41FmmZV8NL5wVf37By2oSfIfWP1xwh/8yTsP3GyJwhxbJ+dHxJIDbdvEsyIGUJvpS9WUiWuF5qFIQtoWQ9gQ0ORv5skF3Mr3PBhTWbztWZrwM/4vOqz/XRUtJ6zj3YQovvb1eiEGeoo8CBmCae2dIUbw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:57:18 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:57:18 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies
Thread-Topic: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies
Thread-Index: AQHape7EfqrAO7YsuU6S6fYx8qy3aLGX6m0AgAAEicA=
Date: Wed, 15 May 2024 07:57:18 +0000
Message-ID: <DS7PR12MB6071BEC0EF10988B11C047F18EEC2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
 <20240514110606.396234-2-lijo.lazar@amd.com>
 <PH7PR12MB599728DBD2B17E24E853639F82EC2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599728DBD2B17E24E853639F82EC2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=abb6a132-e9e1-475a-8534-3add8e2d3bba;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T07:35:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH8PR12MB6723:EE_
x-ms-office365-filtering-correlation-id: 5dd9dc3e-0981-4276-7393-08dc74b4a4c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?u711nPEaz5cArpQTUI+vlZEl54jxASv+LpKnxEZD42XzKJEGPaOdFSzZXgFj?=
 =?us-ascii?Q?k3GLhqyvfVoqbuFBrGAFpmruVrNfTIVRP45VSQWZxjlRTGS+hmOHcZ8GHlLl?=
 =?us-ascii?Q?VdCIAzbR2L0YIRxeif47HKshW/iwnRHQfAOyGDa7mbtNYhfIL7IwJWMi8J84?=
 =?us-ascii?Q?38I9d1cEeTbo6ljlicTLgGxruRDUZFFix06tElTyC+JUc2ubbH295CnQWVpF?=
 =?us-ascii?Q?AeFhCSEvVBwxM2+Vb13PTZXoqcSliGZv+BxZ/B6zmx1WgQv4o58wWkIT3BkI?=
 =?us-ascii?Q?DD+s7ZJTvoZcW5peIkRAvEUFF5toKSZu77gHs8mR98ia1Q+ofdtuHhM4rHuE?=
 =?us-ascii?Q?x2px01wpmjDVH21XWtNBa62QEK5sqvbbWRCGkGMsClcvEoMXvtZKkwN1Ndvi?=
 =?us-ascii?Q?GQUPUq4Pwj9gUxRizrY4W5ww14MEIC/O+sv32NDQ/5F730MUf50Ogai8s5tV?=
 =?us-ascii?Q?0mC77ej1jsSByRMl3DGQT1ziAmzSRWFv5DJtMjoVnQ03rd0qQWKWwo3tCB1H?=
 =?us-ascii?Q?GRuJDzywXS2lIMk1bFlHFw5/eggEFcVcKDhngJs8hwKBr9V5ssyVpywV09m1?=
 =?us-ascii?Q?X0nJQ8Ktjd4jTXpmVA/hd10qhFChe8uioPnr8+UhxIwFcctgeR5+MXQNKNEY?=
 =?us-ascii?Q?DeVApK7g+r50LOy2yEldU7lCIxuwRTQVCfb7Hfxw9+Jg0Uhq20+TJXs3cq0t?=
 =?us-ascii?Q?3+wi/08QnJ4vCIulfgNTvLSbcee3n/MQgFq1dWKPDrg2Y18rtJ0Cf/A3/PCX?=
 =?us-ascii?Q?Shh3XRtTgv5u8dVN9pdPBDw6N/hlg8tKTLeyEG+U8PPKXX2M+P8PJNO09K0x?=
 =?us-ascii?Q?v6gqU4n0y515K6f/DUj2Zdbdah5ebgeRthusGe4w3voWyUPKPb6rbdVMt3jt?=
 =?us-ascii?Q?0cykg4VFRzjn9B8ao7Jb3geiGI+ipGczUX3yiYRpf3cpxgca6Ioj/ZDvvUxF?=
 =?us-ascii?Q?IcGS6XDNG7WZtW/mDupyXjj6kJcf2feV5ypIdUjIoorW7osAqyAqKeVg88zn?=
 =?us-ascii?Q?Ud9xdWxket9hdr1qCtIUX04GffXUglg+Aba28gLhIoJYAP/8Gw1ZBYtWnrnU?=
 =?us-ascii?Q?PV+3cFNS6gK4Antz74l5+5SvT2Pg0VPs97FtG0DYH1+H2NBsF3dq3no69lQn?=
 =?us-ascii?Q?J1AnMxD9nOWYw+ZGrpo3vFp6lw8cGO54Pb49IBisQe3HtqTQXdqSzGVoG48N?=
 =?us-ascii?Q?o8yAyxlit1nvH09lY0G8Zh8JkrLWiTpNvEbuEbVjyTibApXTcaVE1zLbKcrn?=
 =?us-ascii?Q?Adoukm9MJEYU+Lwk+ZXtbaZIo4eYFzuHeqmrkQaXej22+nUEEbiv4vcNxVNU?=
 =?us-ascii?Q?ikzgOBk36qYDur9lqKH9hEONfGdAEf/2VmHT92ojF9M17Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bf/ki10snwnE8cdF26l5+q/etqjHdR73qMMxk1hZm5CIDP5qda0P8BYOBKzP?=
 =?us-ascii?Q?BN+Ut0C31ej8o+ERHu0uv9DDvX0kCppiHqVV+EAi9vwqrmNwzl53gf06Twn6?=
 =?us-ascii?Q?lzht3YdgNCfzu7+sbRsxZsBFBrNORtaV8GquZQHG7mR38A47I13z0D1HzRir?=
 =?us-ascii?Q?dTRJESvmnBCxE/bKRMrUUFULI1oY+kjZblVrTNxUCgVtwF+ys7AzxXSsqg95?=
 =?us-ascii?Q?UWXRF2PfsMB1mzte7pnaPzgrT9gKgRGyQ5E3XPSHMWNZNipi7X3VexMyCktS?=
 =?us-ascii?Q?8t8Md1N4I3QJ3FWosBuAl6rQ89cL9Pr1POhA2m3CEPkmSy4JdVIWe3H6By8B?=
 =?us-ascii?Q?ZPS5bGE/cx7S/PCo4fPkWIt0JQt67/JmPaZlBhsqSxMlE/cH/Ma21E2Nltbo?=
 =?us-ascii?Q?Rr7QxrdynuyFk+e6DhSlU78LK6LizzkPzsgFuwBwarXW097QrIb75MZJgb7x?=
 =?us-ascii?Q?ZCO/CQrHhZnzbGgreQn+ytdAL6n4LKseC0x9MR78/WJ1JhFDkvmAj5Vp61G9?=
 =?us-ascii?Q?vl2+FFcs41OUeUTqC9WqKv0x05XGoc2s3H4SltgrMUHEtZ/kNxs/46qqHV7L?=
 =?us-ascii?Q?MmKOd2dEDVkQCZntQoBNEX295F+sGV/eW4EAw/LLYSmlJulFj7dmIgUD9t5E?=
 =?us-ascii?Q?8qdM70ABg4J9eOOYt43/d7zGvThScJ3GYj8BziF2tj01Y34VjrMlXIL5WfUS?=
 =?us-ascii?Q?zTfznOCLh2YMyYSjrS06AcxDluo2ClI4rHuQmR9ED3aAzGIbzecX49ohhgXO?=
 =?us-ascii?Q?BtIUdwPE4Fc5VNc8eBvr7Fyj2JaD+oC4AeUaN75UIGPQuWyCn1cvDk25Suxm?=
 =?us-ascii?Q?55wAj7MhxxI3N2HLyeXzjYeI16FrG4EmFxDIzWdByBa4VZezuzTOh27laFd4?=
 =?us-ascii?Q?/flMjJaW0KpeiZDcwt9SByPRaHvBeLA+MHAEyiWF82g1TJJldxRVM9+GRL5E?=
 =?us-ascii?Q?t5NTrOu3nOhR9Je+4kIj9ZDnY+OBrhCeXawlchE6k2qHAAzn4gV9EionmKZY?=
 =?us-ascii?Q?YKYDAFJLxxUJ8mJYzS9DQDiWgB+Gpt2aSCbbpF80xf08ZFxWPaKRVMJsducp?=
 =?us-ascii?Q?LV7532vTvnHaEIMbtHvVrkZMPsZGJeDg6TpbC3f9eBOFIiJealnBpFYEpZmg?=
 =?us-ascii?Q?SMBDlEECKFNOatcYALbfP8Jp2pmfGl6crbp8n8ORM1DaO+u27P7ndTUJIu/Q?=
 =?us-ascii?Q?T2SJOrhu5+xcYbY9ot8zcwd46dLSD8Uf241Qwdf75ZPn/Dxf1EnMXD8UKNDf?=
 =?us-ascii?Q?l+q8tz7T8KBWxE6a03eJ2CUtj3wDnJendqzA6e1l5zudgSiVv4Dc0pNT+d9L?=
 =?us-ascii?Q?+nEYJ4nZUUNBkDfgeRCSQ6M2fJ+MvpuiVy1b076yvxFWBLS4oaT+3MkmPRIQ?=
 =?us-ascii?Q?MU46d2qMBKZiQfIw6E2wdNlC5WVxsPVtYn4qRzV2IC/100b0dK0cTzhk2102?=
 =?us-ascii?Q?EH1UT6HsJ+SvefK94qNoGzn51c3iCwLNFaQjOp6WKiA4BKHywOsYedqwQ4We?=
 =?us-ascii?Q?AyCXwbpSxrOq6W1Rdh/yiP22T3+1Ts608dJ3ceX+WMA14XJeqCCTsem6yzrM?=
 =?us-ascii?Q?wzxKFb6wJBSUqSfww08=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd9dc3e-0981-4276-7393-08dc74b4a4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:57:18.6789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bl5rR9gv0fQZQLhVyr+5yZjoIKIMIRwLcJPtBhnEOGb92QTacj3v8bCO5ROS/E232HfQF2QbNqTAQRl/UNKUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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

Series is
Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, May 15, 2024 1:10 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: RE: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, May 14, 2024 7:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH v4 01/10] drm/amd/pm: Add support for DPM policies

Add support to set/get information about different DPM policies. The suppor=
t is only available on SOCs which use swsmu architecture.

A DPM policy type may be defined with different levels. For example, a poli=
cy may be defined to select Pstate preference and then later a pstate prefe=
rence may be chosen.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2: Add NULL checks before accessing smu_dpm_policy_ctxt
v3: Rebase to add device_attr_id__pm_policy
v4: Use macro to define policy type for consistency.

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 94 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 98 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 31 ++++++
 7 files changed, 273 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 805c9d37a2b4..8ed9aa9a990d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -273,6 +273,22 @@ enum pp_xgmi_plpd_mode {
        XGMI_PLPD_COUNT,
 };

+enum pp_pm_policy {
+       PP_PM_POLICY_NONE =3D -1,
+       PP_PM_POLICY_SOC_PSTATE =3D 0,
+       PP_PM_POLICY_NUM,
+};
+
+enum pp_policy_soc_pstate {
+       SOC_PSTATE_DEFAULT =3D 0,
+       SOC_PSTATE_0,
+       SOC_PSTATE_1,
+       SOC_PSTATE_2,
+       SOC_PSTAT_COUNT,
+};
+
+#define PP_POLICY_MAX_LEVELS 5
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index eee919577b44..b443906484e7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device=
 *adev, int mode)
        return ret;
 }

+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
+*buf) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_get_pm_policy_info(smu, buf);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_set_pm_policy(smu, policy_type, policy_level);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)  {
        void *pp_handle =3D adev->powerplay.pp_handle; diff --git a/drivers=
/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 110f2fc31754..6dab0b085239 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2278,6 +2278,98 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct de=
vice *dev,
        return count;
 }

+static ssize_t amdgpu_get_pm_policy(struct device *dev,
+                                   struct device_attribute *attr, char *bu=
f) {
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       return amdgpu_dpm_get_pm_policy_info(adev, buf); }
+
+#define STR_SOC_PSTATE_POLICY "soc_pstate"
[Kevin]:

Better to move above macro to top of file.

Best Regards,
Kevin
+
+static ssize_t amdgpu_set_pm_policy(struct device *dev,
+                                   struct device_attribute *attr,
+                                   const char *buf, size_t count) {
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       int policy_type, ret, num_params =3D 0;
+       char delimiter[] =3D " \n\t";
+       char tmp_buf[128];
+       char *tmp, *param;
+       long val;
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       count =3D min(count, sizeof(tmp_buf));
+       memcpy(tmp_buf, buf, count);
+       tmp_buf[count - 1] =3D '\0';
+       tmp =3D tmp_buf;
+
+       tmp =3D skip_spaces(tmp);
+       if (strncmp(tmp, STR_SOC_PSTATE_POLICY, strlen(STR_SOC_PSTATE_POLIC=
Y)) =3D=3D 0) {
+               policy_type =3D PP_PM_POLICY_SOC_PSTATE;
+               tmp +=3D strlen(STR_SOC_PSTATE_POLICY);
+       } else {
+               return -EINVAL;
+       }
+
+       tmp =3D skip_spaces(tmp);
+       while ((param =3D strsep(&tmp, delimiter))) {
+               if (!strlen(param)) {
+                       tmp =3D skip_spaces(tmp);
+                       continue;
+               }
+               ret =3D kstrtol(param, 0, &val);
+               if (ret)
+                       return -EINVAL;
+               num_params++;
+               if (num_params > 1)
+                       return -EINVAL;
+       }
+
+       if (num_params !=3D 1)
+               return -EINVAL;
+
+       ret =3D pm_runtime_get_sync(ddev->dev);
+       if (ret < 0) {
+               pm_runtime_put_autosuspend(ddev->dev);
+               return ret;
+       }
+
+       ret =3D amdgpu_dpm_set_pm_policy(adev, policy_type, val);
+
+       pm_runtime_mark_last_busy(ddev->dev);
+       pm_runtime_put_autosuspend(ddev->dev);
+
+       if (ret)
+               return ret;
+
+       return count;
+}
+
+static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
+                                        struct amdgpu_device_attr *attr,
+                                        uint32_t mask,
+                                        enum amdgpu_device_attr_states *st=
ates) {
+       if (amdgpu_dpm_get_pm_policy_info(adev, NULL) =3D=3D -EOPNOTSUPP)
+               *states =3D ATTR_STATE_UNSUPPORTED;
+
+       return 0;
+}
+
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
        AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2326,6 +2418,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
        AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                          ATT=
R_FLAG_BASIC,
                              .attr_update =3D ss_bias_attr_update),
        AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                         ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pm_policy,                                ATT=
R_FLAG_BASIC,
+                             .attr_update =3D
+ amdgpu_pm_policy_attr_update),
        AMDGPU_DEVICE_ATTR_RO(pm_metrics,                               ATT=
R_FLAG_BASIC,
                              .attr_update =3D amdgpu_pm_metrics_attr_updat=
e),  }; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/=
drm/amd/pm/inc/amdgpu_dpm.h
index 501f8c726e8d..1455db9c3789 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -598,4 +598,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struc=
t amdgpu_device *adev,
                                                  unsigned int *num_states)=
;  int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
                                   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level); ssize_t
+amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char *buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/p=
m/inc/amdgpu_pm.h
index 448ba3a14584..6ec9fca045e0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,7 @@ enum amdgpu_device_attr_id {
        device_attr_id__smartshift_bias,
        device_attr_id__xgmi_plpd_policy,
        device_attr_id__pm_metrics,
+       device_attr_id__pm_policy,
        device_attr_id__count,
 };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e61aa4418d44..df9ff377ebfd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3498,6 +3498,104 @@ static int smu_get_prv_buffer_details(void *handle,=
 void **addr, size_t *size)
        return 0;
 }

+static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysb=
uf,
+                                size_t *size) {
+       size_t offset =3D *size;
+       int level;
+
+       offset +=3D sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->na=
me);
+       for_each_set_bit(level, &policy->level_mask, PP_POLICY_MAX_LEVELS) =
{
+               if (level =3D=3D policy->current_level)
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s*\n", level,
+                               policy->desc->get_desc(policy, level));
+               else
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s\n", level,
+                               policy->desc->get_desc(policy, level));
+       }
[Kevin]:

It is better to add 'offset' check to avoid buffer overflow.
After fixes, the patch Series is,

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
+
+       *size =3D offset;
+}
+
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf) {
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       struct smu_dpm_policy *dpm_policy;
+       size_t offset =3D 0;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return -EOPNOTSUPP;
+
+       if (!sysbuf)
+               return -EINVAL;
+
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               dpm_policy =3D &policy_ctxt->policies[i];
+               if (!dpm_policy->level_mask || !dpm_policy->desc)
+                       continue;
+               smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
+       }
+
+       return offset;
+}
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type) {
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!policy_ctxt)
+               return NULL;
+
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               if (policy_ctxt->policies[i].policy_type =3D=3D p_type)
+                       return &policy_ctxt->policies[i];
+       }
+
+       return NULL;
+}
+
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level)
+{
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy *dpm_policy =3D NULL;
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int ret =3D -EOPNOTSUPP;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return ret;
+
+       if (level < 0 || level >=3D PP_POLICY_MAX_LEVELS)
+               return -EINVAL;
+
+       dpm_policy =3D smu_get_pm_policy(smu, p_type);
+
+       if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->set_poli=
cy)
+               return ret;
+
+       if (dpm_policy->current_level =3D=3D level)
+               return 0;
+
+       ret =3D dpm_policy->set_policy(smu, level);
+
+       if (!ret)
+               dpm_policy->current_level =3D level;
+
+       return ret;
+}
+
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
                           enum pp_xgmi_plpd_mode mode)  { diff --git a/dri=
vers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/i=
nc/amdgpu_smu.h
index 0917dec8efe3..ee5b9701038c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -362,6 +362,27 @@ struct smu_table_context {
        void                            *gpu_metrics_table;
 };

+struct smu_context;
+struct smu_dpm_policy;
+
+struct smu_dpm_policy_desc {
+       const char *name;
+       char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level);
+};
+
+struct smu_dpm_policy {
+       struct smu_dpm_policy_desc *desc;
+       enum pp_pm_policy policy_type;
+       unsigned long level_mask;
+       int current_level;
+       int (*set_policy)(struct smu_context *ctxt, int level); };
+
+struct smu_dpm_policy_ctxt{
+       struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
+       unsigned long policy_mask;
+};
+
 struct smu_dpm_context {
        uint32_t dpm_context_size;
        void *dpm_context;
@@ -372,6 +393,7 @@ struct smu_dpm_context {
        struct smu_power_state *dpm_request_power_state;
        struct smu_power_state *dpm_current_power_state;
        struct mclock_latency_table *mclk_latency_table;
+       struct smu_dpm_policy_ctxt *dpm_policies;
 };

 struct smu_power_gate {
@@ -1551,6 +1573,11 @@ typedef struct {
        uint32_t                MmHubPadding[8];
 } WifiBandEntryTable_t;

+#define STR_SOC_PSTATE_POLICY "soc_pstate"
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !def=
ined(SWSMU_CODE_LAYER_L4)  int smu_get_power_limit(void *handle,
                        uint32_t *limit, @@ -1598,5 +1625,9 @@ void amdgpu_=
smu_stb_debug_fs_init(struct amdgpu_device *adev);  int smu_send_hbm_bad_pa=
ges_num(struct smu_context *smu, uint32_t size);  int smu_send_hbm_bad_chan=
nel_flag(struct smu_context *smu, uint32_t size);  int smu_send_rma_reason(=
struct smu_context *smu);
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level);
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
+
 #endif
 #endif
--
2.25.1


