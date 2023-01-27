Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BBBC54EAA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jan 2023 18:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010C110E9C1;
	Fri, 27 Jan 2023 18:09:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B0510E9C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jan 2023 18:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gst+ZFQHaI/jKyuE9CzGJiFvoszUnRrogXrsUkmO6AyOzVHY3OMnCcB/DZ9H1+YN5iuxJsdLsYGovK+E9FZy5wvAXKVv88o9bnYBO0rEecJsoDxA/FKjsse2E911vm45rghspOtrVZKV1NVAR9U2WRY5uk4kBQXdIFY7BlQSRu+SgfFMjCFchhnB+/6bA3cv3oatP2pCDIK1J4P6GI3Tq40DWYxz5IE7AnFTjGRDkmLjGru2Y2UvqZuUwEvCE/PFI6JEZeB+QoiPvItB9Sw5D7C0djfCmi4gJW7xl+nQprDXjpDEM0LSlw+CTWksd5xRyzjtt+sYq7H4BV2f/vNqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kRoFdDVyJSHXcBpAkoHXXbH3NgFyyltUN7fH+8FTms=;
 b=Sn/27ob6nB8uJOegO/0Rkbwhbgc3hDHo8aGchKzQIblp8I+TaLqV6Wf+Yvcn7mbUrWmNhRxtyzTTzl7w6GQWQkmToOLjC6nJYn8rDiH8Hj2FyubngrJY1sh4tbRdvykYoyrovoWNc0Te/bYnJ6737p0Lx5Ju8ncQZEiAwuHaRzb3v/cG2gJ1UdyRqMfz884ilURPmuCYf+9224gFpNQuwLAFX9qV1QDOGoBHJbklc0OjAP3Zt/5k0c2Qj9Ug33ObyXvrMJeYT8dwpJ+sNTqbJfd7R/8nI6NweAOgTq0X/50eMzvwU32pXmDecebpNH/8KjRZKbW3ke/LxFnQ/xLWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kRoFdDVyJSHXcBpAkoHXXbH3NgFyyltUN7fH+8FTms=;
 b=xv7hUGDOoDlN14fvyv/q+zgPv+3UoRsdZbtgd1uf2L315nb8zot/IAFbpMG2JXSfzKSziJqHWnux6JJgYMjF7J4TGhCKvqnBHDZ4RSlcYxOn1y8hXlFckHKkpTpT6o5M3CWyNU+R37XobWoxcdWY5gW8+YVlZ/EMkXT6Hco6CTo=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Fri, 27 Jan
 2023 18:09:44 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6947:fb51:bf73:b72e]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6947:fb51:bf73:b72e%4]) with mapi id 15.20.6043.025; Fri, 27 Jan 2023
 18:09:44 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Properly handle additional cases where
 DCN is not supported
Thread-Topic: [PATCH] drm/amd/display: Properly handle additional cases where
 DCN is not supported
Thread-Index: AQHZMnoA/VW+ny4KGkCRBlMSYXnKN66yj8a8
Date: Fri, 27 Jan 2023 18:09:44 +0000
Message-ID: <CH0PR12MB52840E05A46FAB29A811D3908BCC9@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230127180538.2570445-1-alexander.deucher@amd.com>
In-Reply-To: <20230127180538.2570445-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-27T18:09:44.226Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: c6aa77be-b26a-425c-03f9-08db0091ab2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V9liN3vrCrLJwpF4MsuoC5kMd31PO6ZeiZ/yCKEr+6WynBr0fs1Oes3RVkQA3roAL1P9+5N6pNoahivrPiVdPdv70zKiWsgnyoEDDWgfyEJtL4WvNlpNtDsN1vMxYpHtzs1CpM3GpPEK+zmbYNG2MP7vP2CVGRENEfoQLUtb2UF8qSUnIh1ygvJR2wnTGT/zOh5HvFgBPAt980UaHy/FZ3mwREcfcGRLX54QwVxKepGHaQEadXn2OPO1mT/JPdB7yqujMsacNGJ1XlqFwPTESlDf4sskbndFJRRMWuxmHUay9FGKC+61NhvUAZrQFIsvKtxj41OyY0tlLDlBUSf+lmQATxaomYXfCOi6H6Q2xo429t4PqMUpePQjwQlSOSOKyhRj1bMrCRljpCEyFcOY23I//8ULSSzPjLnjFeXI9yKzxeL9JK5ANlqF0yJCeFhj41C6X/Z6LqCNW3OBzsIyGcV3nRT/0gATBWi6P0Cg3bX8QDCXDgRtBXJCYgnDgLwlHRhKQTmWTUSG3R6w4b0iTR93WRWJuhw8ywwZJ74imZ8YAUFPjEoqCTXqAlU4/eXwYUGN3Lb/MfuCP6tdUGIRSISV7eBq1/Kac229JxjlCwREF0A2Vd2ZG3Ki6RGWZga4fu3g3z2kCbRtG/2jHZr1JYDs9U1PUKA6B12lqE3vvVlGZqEPb4pYFvBGy6NFpGFa9TO2xk8kKfB16T3AD8SaIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38100700002)(122000001)(55016003)(33656002)(86362001)(38070700005)(110136005)(2906002)(66476007)(66946007)(8936002)(41300700001)(76116006)(66556008)(52536014)(186003)(8676002)(19627405001)(64756008)(91956017)(5660300002)(66446008)(9686003)(6506007)(53546011)(26005)(316002)(478600001)(83380400001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LpImyT3L5Dq5fWPWVzlv5qQwmjA/Ah6nstDZtr+wCCVL2UkPi82lDYxb+9HT?=
 =?us-ascii?Q?GJVveLS5D3LV2MOluV2wX++LhYbvoxtSR3r+QbZkU6UIJX66ZuyJIPUBpX+N?=
 =?us-ascii?Q?MpVWXPSRHKK10oyV7EDZW5Kbb89/hes/V+m3aNkHUPxXYiSelIuwtKaqTGKk?=
 =?us-ascii?Q?5UIV7e2Lxh3rEYw53EbggsH31lp0oD90dYsaff3F/6YoLDXvD8tt8fGWrUAO?=
 =?us-ascii?Q?OSSUx/uboL0dKceeNfL7bsYn1RtHZ73AWnPIbOWB3tr3fZ2KUuV7d9+wu4qr?=
 =?us-ascii?Q?T4oTwuEoD737oBqgIatZmLy0CAZ9ZfrmuuBohWfjJ+XRAFE1ZI2yP8/lNrfx?=
 =?us-ascii?Q?b3QzRO6zLdhDrnD8BmMwqnaUFT0ebaJiuuUOYxCdyu9G54Jf4TVJ2hQwQLKs?=
 =?us-ascii?Q?daOZqFGYpoSU8PbIJnKrdVuItW8LgK5RCdNyk5MtTYW/H8PuNQK+59xzVSsF?=
 =?us-ascii?Q?HHJHUxgvkpR8eFwROqMuR3Mv3oeep3Tp68Bvug1X0PpbMWh8NQtSj6bFk4DU?=
 =?us-ascii?Q?GNy3KSwcK07w9RI4brf9bZjPpaODfybkfgH8SG7wtp0NqyjHbQEeikZSLGBu?=
 =?us-ascii?Q?5t04UTQbm4tWQJGwQCH7QOitJ8iGEaQYNuZW+FfRjs5PM2uyYn2VjKhhm6nx?=
 =?us-ascii?Q?C4y6Z9yBVgZCJSx1kfoPIHP6YiiYrrURkMyM0w4y7rFZtVsiUiDzC2ZFgh3N?=
 =?us-ascii?Q?dfyRU8hLWd5EvcMk9BWb37A/IQIz1JIJpjeU6X4AuM4zUeKNgExiaqTcYTJh?=
 =?us-ascii?Q?y4/M+CtSzJn7ybAzBXKVybp4f2uoKjynpSePw64EsGeJF/bJWQFDMQ5wRbOu?=
 =?us-ascii?Q?fQ+zcFtQ1MqKm7lJDSJqxMtOkcfayCOnc+lha6UEAru4SC3l57eNze+A3+1C?=
 =?us-ascii?Q?kXJGIpJvG86LHiD2XBn4eX3iTgtSvWT4a/jO+OaShOpXzwM8Fvrpqd9aHBVM?=
 =?us-ascii?Q?5dvh6T6364fiozVMg5Kfs8pSKjHqBvse2G5ZuCrenOLFVApZSFeK+zP0Mrbc?=
 =?us-ascii?Q?ad5L/9TAqOLcTR9XusE1HeoIBieBszZAiFrp7m2VA4tCNuIcAjfxoQmmZsau?=
 =?us-ascii?Q?sGBVrf2t8DN+hnH+2cXk/wBfqUKwh4UMGzuyv2iPkqZmezDfvVuSF9d0ErLz?=
 =?us-ascii?Q?le65nfmKu7ows/7He7rFLbPSWLk2QW9WUy9oPUfxx9uSlvtERMjit+oTKuyQ?=
 =?us-ascii?Q?rBi5NT/TdBtEaeJ/8+TA9ve1uFyIvpsF5QtRoVq4G6HQlZKaXG7ajXJgLOii?=
 =?us-ascii?Q?vZm9A64xb+oUs/sanYw3xlVkfHFoY+pVA8lWkjtDZJrGFhLx0ob6PcIkiMwo?=
 =?us-ascii?Q?ha1RZMGxQh5oIgNFVvJP9Hya3W69lvAfiqidrmDIzM3+EOZuShD7y5QL1Rop?=
 =?us-ascii?Q?aDkjNfu2LEf5kcZ7cy72uho1+DmPZ+PGjnPijdi1MrFN9nYwqAv0VBFS3GMN?=
 =?us-ascii?Q?7g9PNP18SFzuJ86OPlgW6YngW5tFgtd7ztbkCog+u0IHH3NGXmnXp2Lp5YZP?=
 =?us-ascii?Q?gPTCj1iRvaHwXLo2W/sZLeGXz9l4aLacjXwaTN4WRJHEHVjTFSxtAj2qOXsg?=
 =?us-ascii?Q?+L0tKqpMngseZkFNzUc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52840E05A46FAB29A811D3908BCC9CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aa77be-b26a-425c-03f9-08db0091ab2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 18:09:44.4831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKEjhJKbDZbm/czSD/HEJ3OU5l93YR7KZLwU9nAKl8MBK9p8KuDKl8+naV7JTBITC5f2kMk5J/mO2f9HLH0bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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

--_000_CH0PR12MB52840E05A46FAB29A811D3908BCC9CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Aurabindo
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, January 27, 2023 1:05 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pillai, Aurabindo <Aura=
bindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display: Properly handle additional cases where DC=
N is not supported

There could be boards with DCN listed in IP discovery, but no
display hardware actually wired up.  In this case the vbios
display table will not be populated.  Detect this case and
skip loading DM when we detect it.

v2: Mark DCN as harvested as well so other display checks
elsewhere in the driver are handled properly.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42d99bf4bbc9..fe66b7aec248 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4563,6 +4563,17 @@ static int dm_init_microcode(struct amdgpu_device *a=
dev)
 static int dm_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       struct amdgpu_mode_info *mode_info =3D &adev->mode_info;
+       struct atom_context *ctx =3D mode_info->atom_context;
+       int index =3D GetIndexIntoMasterTable(DATA, Object_Header);
+       u16 data_offset;
+
+       /* if there is no object header, skip DM */
+       if (!amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &d=
ata_offset)) {
+               adev->harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;
+               dev_info(adev->dev, "No object header, skipping DM\n");
+               return -ENOENT;
+       }

         switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
--
2.39.1


--_000_CH0PR12MB52840E05A46FAB29A811D3908BCC9CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, January 27, 2023 1:05 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pillai, Au=
rabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Properly handle additional cases w=
here DCN is not supported</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">There could be boards with DCN listed in IP discov=
ery, but no<br>
display hardware actually wired up.&nbsp; In this case the vbios<br>
display table will not be populated.&nbsp; Detect this case and<br>
skip loading DM when we detect it.<br>
<br>
v2: Mark DCN as harvested as well so other display checks<br>
elsewhere in the driver are handled properly.<br>
<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++<br=
>
&nbsp;1 file changed, 11 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 42d99bf4bbc9..fe66b7aec248 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4563,6 +4563,17 @@ static int dm_init_microcode(struct amdgpu_device *a=
dev)<br>
&nbsp;static int dm_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mode_info *mode_info =
=3D &amp;adev-&gt;mode_info;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =3D mode_inf=
o-&gt;atom_context;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index =3D GetIndexIntoMasterTable=
(DATA, Object_Header);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 data_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if there is no object header, skip=
 DM */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_atom_parse_data_header(ct=
x, index, NULL, NULL, NULL, &amp;data_offset)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;No object header, skipping DM\n&quo=
t;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_SI)<br>
-- <br>
2.39.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52840E05A46FAB29A811D3908BCC9CH0PR12MB5284namp_--
