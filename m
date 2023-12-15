Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001A7C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 22:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE3810EAAF;
	Fri, 15 Dec 2023 22:29:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EA010EAAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 22:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqUSBWCHG163423xZA5giGbJubhlqIoHsUWTviSlzLfFLDv1eFK5gnwJoJ2ggcMLH0EqBQhc56PXPJ6MntVq5xY54NImOMDQOd5U9sWUwlttCH5iBsYYw+m/rN4vU2sjcjCM/SXrjq7qHRUs3bo+mtsn3nCiAGVD7hbN624OeGF7LFYnVnFp/On2hrFy+ok9UkSSY/LD0beIMZvX3Uem02GjaMftEy7Tlv+erZzVYbJJJmYYencZnbWjIEQgCyDAinlR2NZOFA1fXTh8G2oEeGOyghaGKwYAzSqQjUBe2LzdDTVGSqrzhDSh9jP2sMI0haNlZ6EUND2NcLTiqN9ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6TvncKln45OFNlirGghdStmeQx3WNqNT6M+yppf/aE=;
 b=hAaLRO3OI7V31TalF94Y9Z+JwId9bxieiDgqOLjFLjv0CAdAZj/jppBYtSOrPVxpX3GUc2Kn1JpgwaQivJbdM767j3N0LROzRuElaTChoqvlmGtVxQtZ7NwJ4NYykSxmQqiLDrW1D7csmIuCUzZnjt5PM6B6KVVuUvdo9hMfgbLo+NPmaM1f2v3R+C5AJE7zc6u9sG2XpBqm2y9o2zcWCYiTB/Rdn3q+16y+1+M4PVt/srZKGTyN3k0GPr1TuwhjPCKt8sdRXJ+i8BWSX/oVQ3CJ/Ou3GrirjogpgVsrYkhcPh2xbajViom/U3ArMp1Zyigny299YzXyKgs/YDGcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6TvncKln45OFNlirGghdStmeQx3WNqNT6M+yppf/aE=;
 b=0d1pJ5ptJcky+ycS+gSht8Prx7YBIjFbNB+V8J1Nlg/Mlkx+iIPqxJsSmX98+VTZ9+PzRFYI1iXpGfHpMQCZ6JNPAiCIdQKnuMRjWH45oNkCEK9CartWxg/VKHosnyzowGLTlwqboeyf0fYawB0EUCCHEhdX9CjRcIgunZJ3Fgo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 22:29:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 22:29:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd: Add missing definitions for
 `SMU_MAX_LEVELS_VDDGFX`
Thread-Topic: [PATCH v2] drm/amd: Add missing definitions for
 `SMU_MAX_LEVELS_VDDGFX`
Thread-Index: AQHaL5acvwNT6UA3z0mPWipqsqe77rCq62LA
Date: Fri, 15 Dec 2023 22:29:05 +0000
Message-ID: <BL1PR12MB514433655A659883729CAE79F793A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231215203745.21874-1-mario.limonciello@amd.com>
In-Reply-To: <20231215203745.21874-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-15T22:29:04.989Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ1PR12MB6099:EE_
x-ms-office365-filtering-correlation-id: 3647d7cc-e979-4671-0b34-08dbfdbd3f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkYKIZISyf7KQkPQEbn0QOZIe/P+N/xHhFGy1C2XccqbA87ZE8b8dBku9gKZoOIK0vfYcdpKwGVv9HeLJUW1r3frHNTPQ8zKWEIDc3g64pUlXVtrIwvShmMT8tFF58gCNSp6eP90E8bWK9YTYDaCIugjhugp9CktDHHrNHI//9Tw5xV0ReelgBc3pP2N7d6zXEjfCC0T5oJ++cszEzXpovSElFh/boXDgQ0odxXw8MEe4GmqrixjHI3eXD1y/pSFV8IhUuOQtw3ewS2xVi1+c+1G+8LZRWBcJT1yWVwZ8r7xMT7FBtONI33ykJxhrvV2Ps8KlZdFLNVAOF25o/dCZoT6BLmNh6XFP0dUgACjRgE/Q3K4z7cOYb8+fyCdDNZMzVNENenWw37Wu87rcD+7TvkzhEQfEcRKvL0sZoNJNagM7lCO5CfyOjxiPOQHyL/6WKU5GtDZmF/z96XYM4JkRcjmAVrAnR3d8I3TCj+as83YQUumFbu3cnMPYnvb60Z/+wAM4uTLknmHSChGZ6yHcHRBV3ukLWTfc0UUZ5MgDxP963c3xOhWi12SsRwlMMTzb3fRvRQE8KYLXrzRyIWqI7bU6YNvZK7kuN/HTcVP8pIWTYwc6idIZp3n4aP34JKC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(71200400001)(19627405001)(966005)(8936002)(478600001)(8676002)(52536014)(26005)(110136005)(91956017)(55016003)(76116006)(64756008)(66556008)(66476007)(66446008)(316002)(66946007)(7696005)(53546011)(6506007)(5660300002)(2906002)(122000001)(41300700001)(166002)(86362001)(38100700002)(33656002)(38070700009)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmkVqSsOK7TOOydnd5IOeyG7xbiMwlb8YB0GdKJJUCKYXgT3rHLWBt3YWtRZ?=
 =?us-ascii?Q?nrFP0UDgLEYP75OXjgS3nW3bfSxBHTkn62eEKDo+nbl9tlmk3xsVDyg21pfu?=
 =?us-ascii?Q?xbmWa86hgGKdiOgduWA/QPNKXGCfCgLX7v/Rdk3DNTFSkp5XX0823wRJ7IN1?=
 =?us-ascii?Q?dSvA5PIH6ZJib+5pxRKbwAzaUJEovvNfz1sML7Gg7IeoRqYvfgbOqkS4y6FG?=
 =?us-ascii?Q?CtMFmh7Vqc1cx3bj/DyyiH7rXn+TsWHsiYTfRw+l59vZjdGFO42yXbzZETPl?=
 =?us-ascii?Q?1Cq6gRVa1McT1w5sFsJY4Pcytgh0vFwB9uxTwNIBH1FR/SGKwaD9iJ9g1wZl?=
 =?us-ascii?Q?J0zwEly9k4yT8v9saFQuPLu/2LZkaKiewiAE6Lu/3e3VP654RdzHC1vQrXr6?=
 =?us-ascii?Q?CEQ8uY7u8M1HOeaQbDh+uVkFBj2rNucWj0uI/IFD/HWYLpeiaVTCusXXAA7c?=
 =?us-ascii?Q?EHs1MRVgtQSx5ZLWhM0dGt0vBqvPNpeQnThwiz5Pf2btDLSisxT+mZQ5bxds?=
 =?us-ascii?Q?y8X+p0Qa5A49ARidYJWuJF2hKRC1NIZCapFcW3WvACkPoHZodgNOcqI0ebIQ?=
 =?us-ascii?Q?ochfDOVrNvTC8Cxf1PY+eiRQv3P8pTjMpVi33fzA3wYSYgQK0whT26YZkCqA?=
 =?us-ascii?Q?E8EJF+Lz7SFZIdiAWGJwowq/4YCgILYN0tZznzEG/GYe69lCGbXiJzU2Wlif?=
 =?us-ascii?Q?sRBcEWoDR03cK8sKZv9puJV/wCjZG/5bYk7VYuiHQUIJECBnTQLeaswvlWOQ?=
 =?us-ascii?Q?sjiwV9fT74J5muLcdqTMoMT040MOXNckI/Tw1V184dHvAw0Fg2df5jymn4OQ?=
 =?us-ascii?Q?ejra3FOig4iSXCM8dIWd8tFgpdUgQzO5UbCMiEyqtP/UHRVBar0/VRhDwYE7?=
 =?us-ascii?Q?p6XZAnAorZU2H5vW4SGjMBfLwWO2cY6vkG99vNM10HWWOJKOMBid+K7UagKx?=
 =?us-ascii?Q?3YVaFShWfupVxPedBP6aheyddttAxjdXVI/vH8urjOtLYWtyZuj4LYEsrnXW?=
 =?us-ascii?Q?X3OBOdRtVE/HhJjYJDBSnn+eDRw7/S2KVniqdu/kHGhFssi/6jx9KGgxDbQ2?=
 =?us-ascii?Q?p/cIug04rQd9IkEH9rbnGTuzUKRHPOfn5nC3sv8cuCuGh4NLy5uWrMKEWyGC?=
 =?us-ascii?Q?W5x+XAYkkqAfPTQzzAOzDTFAMlLJ/6LHA1VZneplFsyYyVWA7gKXrahpLgyR?=
 =?us-ascii?Q?GRRcBmdfT1mbGu7UXtQTFcpk/NW5ix3FTTSGqn3jmm4ZnVlIWxUC0IxA33R0?=
 =?us-ascii?Q?4julSEKJELFOXDiGEd7yLfVLjoSYer/JQKdOlzDU6L4zj1U6ZNNhvDG7fGEU?=
 =?us-ascii?Q?huzNaZom9ye4Ba/xnn/TUD0dY20nS6AJvYiZMN9x5lIKGtIj4y6ZmjxsAQpZ?=
 =?us-ascii?Q?+Xuhah4zElRwkxVzw68rMM1fYG3FjwPtlf/gbJV0xxMVLADhVJthw/PhmdlR?=
 =?us-ascii?Q?aUDxbWc3kIy9bdN3z/nnUm7Tkfeb5fn7nRxoBE1pLANyypvda9G8A/8y38We?=
 =?us-ascii?Q?xjq6ZO9mRR/QTqRYM+OFXJOlU3twMABl+ilGkv9UPbQ5vVtWG0Emx0TN7hVM?=
 =?us-ascii?Q?KF6DeIuCqLCCgoh/YS0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514433655A659883729CAE79F793ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647d7cc-e979-4671-0b34-08dbfdbd3f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 22:29:05.3460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbWvwX+/f2dmnjyAEBPAgKdobOTIFmw+vhvVYiI1G8tCoE5x7MKr0PpA7Uj85J/0wwy6ExHeC399zvY5GEnGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

--_000_BL1PR12MB514433655A659883729CAE79F793ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Would be cleaner to just add to the SMU_MAX_LEVELS_VDDC case.  E.g.,

       case SMU_MAX_LEVELS_VDDC:
+       case SMU_MAX_LEVELS_VDDGFX:
               return SMU71_MAX_LEVELS_VDDC;

With that change, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, December 15, 2023 3:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v2] drm/amd: Add missing definitions for `SMU_MAX_LEVELS_VD=
DGFX`

It is reported that on a Topaz dGPU the kernel emits:
        amdgpu: can't get the mac of 5

This is because there is no definition for max levels of VDDGFX
declared for SMU71 or SMU7. The correct definition is VDDC so
use this.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3049
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * s/VDDGFX/VDDC/
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 9e4228232f02..afe5e18f28db 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)
                 return SMU7_MAX_LEVELS_VDDCI;
         case SMU_MAX_LEVELS_MVDD:
                 return SMU7_MAX_LEVELS_MVDD;
+       case SMU_MAX_LEVELS_VDDGFX:
+               return SMU7_MAX_LEVELS_VDDC;
         }

         pr_debug("can't get the mac of %x\n", value);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 97d9802fe673..b4b2a3c96679 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t v=
alue)
                 return SMU71_MAX_LEVELS_VDDCI;
         case SMU_MAX_LEVELS_MVDD:
                 return SMU71_MAX_LEVELS_MVDD;
+       case SMU_MAX_LEVELS_VDDGFX:
+               return SMU71_MAX_LEVELS_VDDC;
         }

         pr_warn("can't get the mac of %x\n", value);
--
2.34.1


--_000_BL1PR12MB514433655A659883729CAE79F793ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Would be cleaner to just add to the SMU_MAX_LEVELS_VDDC case.&nbsp; E.g.,</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
 case SMU_MAX_LEVELS_VDDC:</span></div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">+&nbsp;
 &nbsp; &nbsp; &nbsp;case SMU_MAX_LEVELS_VDDGFX:</span></div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 return SMU71_MAX_LEVELS_VDDC;</span></div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">With
 that change, the patch is:</span></div>
<div class=3D"elementToProof"><span style=3D"letter-spacing: normal; font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; font-weight: 400; color: rg=
b(36, 36, 36); background-color: rgb(255, 255, 255);">Reviewed-by:
 Alex Deucher &lt;alexander.deucher@amd.com&gt;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, December 15, 2023 3:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd: Add missing definitions for `SMU_MAX_LE=
VELS_VDDGFX`</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It is reported that on a Topaz dGPU the kernel emi=
ts:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu: can't get the mac of 5<b=
r>
<br>
This is because there is no definition for max levels of VDDGFX<br>
declared for SMU71 or SMU7. The correct definition is VDDC so<br>
use this.<br>
<br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/3049">http=
s://gitlab.freedesktop.org/drm/amd/-/issues/3049</a><br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
v1-&gt;v2:<br>
&nbsp;* s/VDDGFX/VDDC/<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++<br>
&nbsp;2 files changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
index 9e4228232f02..afe5e18f28db 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU7_MAX_LEVELS_VDDCI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_MVDD:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU7_MAX_LEVELS_MVDD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_VDDGFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return SMU7_MAX_LEVELS_VDDC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;can't get t=
he mac of %x\n&quot;, value);<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
index 97d9802fe673..b4b2a3c96679 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c<br>
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t v=
alue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU71_MAX_LEVELS_VDDCI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_MVDD:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return SMU71_MAX_LEVELS_MVDD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_MAX_LEVELS_VDDGFX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return SMU71_MAX_LEVELS_VDDC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;can't get th=
e mac of %x\n&quot;, value);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514433655A659883729CAE79F793ABL1PR12MB5144namp_--
