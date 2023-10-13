Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FADBCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 00:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C4610E50F;
	Fri, 13 Oct 2023 00:25:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387CD10E50F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 00:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQrvi97+mxJBtDefoLf1tE69FFIzpvXulS3Jiv8c2sZNCgoBezNoT4VZy5cnYVHMspd/2zm2TpMFpWS/2jYukvcEjT/yCgpdMiI38islmxH8LfGIMx4wFN68FdGifxdKrYvQqea3uSOygQ+OuzoMXlFpf+3gc9Z4TfZv7C2J6GGcsFu9H25kGCSmMHvnkkbFSrtSaIvvy1qB/WHJT7zjmUqijsZhkUPpu98gFE5r1wxsNyuP3QFxgMFZW7KasP4bPXL4XgPlyfSkJkbPEgRoDz+gpd/JRrdNRM5kFrsjNUrmnHeIwOnc90m7N/TP71TzLElb3mxbrfZAWbIqr6g8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt98WGAo3LGm6BlcTaDzcPRP7crqForv1oCBHkPNmrU=;
 b=MsY0B+lOtd5pcM0MLjnHV43VHqZ4HqjiF8Jc1XMXiQREg4jrN8caXoho7+x2/pi5PqOWQYRf2B9nKUUr2xSBR6nvVlJ50/CLisvjdu+POxIoeE+1tYj0zM8ussrMDCTlOwWoKhkstk0drRzb57CwfjtspZOLmwyeCAStgIVX5pP6eSFYyqpucdAkAjVSAhI7xOJ8+49NIM1mbnvsVNLERYlREp6+HlNvGjA8pCd4PqAe92KXusDu0t4rzxmaIaoCRi5cELUadKjP+3uFEhne7AzijaLEaXaPpw0EnzoxNexidotdfi0VqVPnn0lVnE4pOahq5zBEwgQ6h9TzDin0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt98WGAo3LGm6BlcTaDzcPRP7crqForv1oCBHkPNmrU=;
 b=aLDxEpVCNWE3++WZY9AevdDlU/SsqJefFEUXR9wJ7kbPSsaEN9YtX7wbFU0Ir5FDxvAY0uhJH1GOdQNYtt6PWsDglxruEPT6AKyAX7HAikA1rpFMI035PxMdFQF7vJE+jN1/xDGfF0nG9LCSHgPqqlD3AoQ9wK6L81LDVSNGyx0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 00:25:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 00:25:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: update SMU 13.0.0 PMFW version check
Thread-Topic: [PATCH] drm/amdgpu/pm: update SMU 13.0.0 PMFW version check
Thread-Index: AQHZ/UAmjKc4lWcuCU2JviE6uDWIRrBG3Md4
Date: Fri, 13 Oct 2023 00:25:18 +0000
Message-ID: <BN9PR12MB5257DE2A96565812007B52FFFCD2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231012191247.505567-1-alexander.deucher@amd.com>
In-Reply-To: <20231012191247.505567-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-13T00:24:33.3994330Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6574:EE_
x-ms-office365-filtering-correlation-id: 24378312-5d02-4266-3f28-08dbcb82e131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YO6wQB4KGHTWuviiLDBzKjrS/CM9HQ2w5AJaDBYS97SUa+iBAnftyalsVrIdGGxAkho83WGw4ZDigdbrNsWm3L99cL9VSWvLE5oj5O4I4v69iBk+HfdNLrQgSkIcQtdVwetF8w+XqgzD9AdZAPsBYvJ9IFqB1xIejHnBFN8Dk/+jIv87kvwyBRadv+7clPN19SG08l5zY0QVtBS8jsjE5oizhhNqTKkRkK4BtAIUoBJkuHn+PjQHdWOy2+VZ2DKB2r0oTOua0LdVOeysP5U/PtL1zV4QmJigPkiz08+lruoIoQqqoyh97DpZfODAP2KZCE/U4NoPMPhMy4uWqaZKcJA0JCUv6QhayzR5YtXQY6Sn76330hDyBFP0H5wMZCBvFHR85sIM7aNfnZNAIreDLtIJPfNcljv4hvONKyudQcaOgEUjj4pk4J7A7PzuOuYJ0GgVRaXl7dQw4jO9f3dUS8jzjwOeO7rg24IY1USRFtAXMvLMXAI7Krj8RbPdcZenaKNixlpr4i0tsne0VdW0IAWTpdCsBs1uHFGZq0S/TSlvLNCMB7NzN5px2UBDY5kNGxblRRWCuCeePSMti32F8O64hO6olR0+3W9YUGlR9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(122000001)(38100700002)(9686003)(166002)(55016003)(38070700005)(478600001)(5660300002)(8676002)(4326008)(8936002)(15650500001)(86362001)(2906002)(66476007)(316002)(66446008)(66946007)(41300700001)(6636002)(64756008)(66556008)(76116006)(45080400002)(71200400001)(33656002)(110136005)(52536014)(53546011)(6506007)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pIkMEd0x9AaErJ3NnpIA7rTAPY0RuWBon13DLlyVGqlf7O3PRz5ZN9zzSZ/q?=
 =?us-ascii?Q?kLSMp6W/vKg44LXEK275RyTlD6h8uG3O1Ib1RLLe6TxV3MxFRcrkdN3OgVs7?=
 =?us-ascii?Q?j9atAhCFc6I8UE7QcZiomZ0ThiJk7mdqwbVPbeqwCzOc9CYmJ1YjgDqPiPAA?=
 =?us-ascii?Q?SSMApqjUGAiIO4kK+phdwNYs9R5z4iV7mTwQV6KP+8ux+Y8gfzidlSFEOvqU?=
 =?us-ascii?Q?M1KwsGdWu+iTmJ6lv3EC75/yKTxjMCMNpaK8cH0VjpkloyqNygOCfVRWIogz?=
 =?us-ascii?Q?b6+GuXpoq/VZPh4en4FGawvAbsvdt/8YDe7Sg8rzudw9uTVHk0COEABuP3Ox?=
 =?us-ascii?Q?1OxFdQ7RRQ/BDOjps8qZ2xroeaZaI8JQBIsQnFOXMFgxh6z7o0iybViUZAPT?=
 =?us-ascii?Q?ybUZdmJ4ntOkatw+LSUdTKSe+Vm78l3ftOPPV0LAJbTmNgutFHdhHlzf0sXm?=
 =?us-ascii?Q?8f2gpP960BRTBGNjrlIMGDXVEFJQk5Bqf7/1pwxp54deyCu+011SuYHMyjnj?=
 =?us-ascii?Q?Pip1ZeTZY2zt+phxOWaB3hY4tSOvxzVCYUY8Hmx0Z4GNtqIkrggtmCLNtOrV?=
 =?us-ascii?Q?StsMOxi4cDBNiy4DgsL9ckuhXuEQOEfG7oIVYX8a4aOv+zUPtOngLHuqrYdu?=
 =?us-ascii?Q?aIJ4Px55e0hVPPVk7HLvhW3OwdIiCHhHBeF/RBUxTTlrsgeNOJ11ZxfPC4zp?=
 =?us-ascii?Q?rDYI4vVmP32Nc8tzt3alCPZ2nunf3lOOAKIo00nfp+Ar/nxn8aSSH+eYz3w+?=
 =?us-ascii?Q?PevRT+FPCq+wmbjZQMzrRYZLpiiTYwIgJkJBmfFqes723mWfiHAZj01U/mgz?=
 =?us-ascii?Q?+aSpZarj7d+dR285e0cPZqzGWYVx6D2N4p+vC0Nle01AJP3TxxxhIHz120x+?=
 =?us-ascii?Q?8845geZBtfSBfd0/nM87fpmesqZhN9pc6qq7E3ciLlxRfNRwXB+f/pBMaFBB?=
 =?us-ascii?Q?OFiE3y7qXgLIah6Dxh42UJ1WV8JDWL4lpEihEzTosoqA0dYiXjGahJBp+ceJ?=
 =?us-ascii?Q?inGlD/rgO0VE3ZnDbuW8zF8umMOIrRoYzcu3exFN3s9X29OC/i7nFFxwUtkj?=
 =?us-ascii?Q?ZOEvvt0fOG2ml36QuK5zSZoeQHJ8Xfp+E+ZEZNjkeVsB4fGCY5C3Gx5UnakA?=
 =?us-ascii?Q?KgT7fZdhN9QL80ZR7UunGFItvJdw/w3BNS9FCGdqleTXTmTfir6tbxQIE1yL?=
 =?us-ascii?Q?KQyR+rVSPoae2I3sEtU2Kj+BkyLg7XEyu9S2ro+RUAyNgGN9sHWpETA7sHQk?=
 =?us-ascii?Q?omnvfp9mU694gKaR76aqMzl2opD5XKs7K++pPOGeBlj8eTIRBaweoOfKroDW?=
 =?us-ascii?Q?TSE+8lX+z97fIQVp0ReSnhHhm0Mkwb/rVdOzLOGNLgtugNvmReSg8A7JlmFW?=
 =?us-ascii?Q?6WwhZkuJObVLKLao6IqA2usgawAqM3pLZwk+K9vH4sRkbA8PYMixSiisyRq1?=
 =?us-ascii?Q?MSOGYbTZAtAqWrCY6HuEUjajAnSb+A10+X1sjzWMYXe1h/9wQRRpuDQyDaYm?=
 =?us-ascii?Q?Q50VuO4aqWpZm0pf/V9Sj0JLlI4bmXGJCuDx40X9FQCxcx8d4rZRTlJo7qkv?=
 =?us-ascii?Q?agALXJJKHqWOCEXbasUmQfsF2glHK5db3SDjJN1OghhsjO7XwfT5dnyM/opM?=
 =?us-ascii?Q?jbA0oQMrCIARbAE0TCrORdBo0omQfLYgxNSP4aV/59WTbr4HxjXzSoToHXvM?=
 =?us-ascii?Q?DSKsYA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257DE2A96565812007B52FFFCD2ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24378312-5d02-4266-3f28-08dbcb82e131
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 00:25:18.6837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX8oOgU7KlXLF487F3W8a59FjmWsZWLhz8IEwzCqPD7PudKDs/xSa8nT7JupR/RhAzaZwYOHNwD3zcr8jZ7M5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257DE2A96565812007B52FFFCD2ABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, October 13, 2023 3:12:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: update SMU 13.0.0 PMFW version check

Update the PMFW version check the the ROCm optimizations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 56b11f6386df..cb7e1a22d7ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2562,7 +2562,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
         if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
             (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 0)) &&
             ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
-            (smu->adev->pm.fw_version >=3D 0x004e7300))) {
+            (smu->adev->pm.fw_version >=3D 0x004e7400))) {
                 workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                                CMN2ASIC_MA=
PPING_WORKLOAD,
                                                                PP_SMC_POWE=
R_PROFILE_POWERSAVING);
--
2.41.0


--_000_BN9PR12MB5257DE2A96565812007B52FFFCD2ABN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</=
div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, October 13, 2023 3:12:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/pm: update SMU 13.0.0 PMFW version check=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update the PMFW version check the the ROCm optimiz=
ations.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 56b11f6386df..cb7e1a22d7ef 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2562,7 +2562,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;power_profile_=
mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
mdgpu_ip_version(smu-&gt;adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 0)) &a=
mp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((=
smu-&gt;adev-&gt;pm.fw_version =3D=3D 0x004e6601) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&g=
t;adev-&gt;pm.fw_version &gt;=3D 0x004e7300))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&g=
t;adev-&gt;pm.fw_version &gt;=3D 0x004e7400))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; workload_type =3D smu_cmn_to_asic_specific_index(smu,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; CMN2ASIC_MAPPING_WORKLOAD,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PP_SMC_POWER_PROFILE_POWERSAVING);<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5257DE2A96565812007B52FFFCD2ABN9PR12MB5257namp_--
