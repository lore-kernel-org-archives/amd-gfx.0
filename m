Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAE6C4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 14:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315FE10EB1F;
	Fri, 12 Jan 2024 14:25:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCF810EB1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 14:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dECKUcRRuCd/2C2w8rwrHYUbtI3Jw8NY3lxmXhk/GXamfJ9KiYwe2Wftl97eIU2YA1n7axJpcOI7vbfjaMcBAtSIeqvDYI+YMFE7RQp0A3L4e28x47dFKeFgq0HEei12R71GffdhrLOon5KErgtmPsJhbgUVI6E5FHs2YeU+kGczprpSFDwdU7krknipbXWspVuRQ5TUUuPmaEaSuHudvwtpq1jBuIvwefW/isF7kTwJPsT1xrM08u6HLONXcHVOPRNVL7JV4iYL72FJrQD9iPHqajhKX1xJnLsvPm9PXeYoIeE/UbMaHXPw//Xbqon4iR21Df8Zk0ZW1VIJCQtfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM+pRCwFYF8gW3nsI6SwyC3yA9iHI0ogy3hqBzeDFjA=;
 b=CsgHYyaS9yGm9SazuMma+3Qd/2nVa8lKwwHY1O407WBajckmsLrS7o+bqAqPUKBj/AnzT4GrxqsQnpW6aN1GHBMRLFZ37rooaYzHPpMp2fbkbzIYINdrs3tAjY1NpHMu0t1O1Tig47dHmkz6ZVBWZMk/+EZzE2dRaYLQ9Mc6PPi+fVXMIJOEPji9IBmxsk9AGdr2vPNQ+UdrwqSDba2tq0b+OpV5+VtW5ZeLNxgxoEfFVkAly9STFWa73fEzAsOS5Qo17XFYzANXEEh8N/K0UTXbftBXVdLbbJ2dk3Az56F9VeedhrEvH+ZZs3mSLCWmAy65mhis498JABe5EACXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM+pRCwFYF8gW3nsI6SwyC3yA9iHI0ogy3hqBzeDFjA=;
 b=UHFMJ2VhuxnfevhjxsV9jSRTCltloCU9qqwx8kA1TWpDTkXPwKlrBme0FbULCXurYApbw0fjtsLsbAiH2hj1pt5ZzxRuMvubE3sKrB8g6IUNtpzvoqQIMye+VCe6yArDG/UheZBaR0sp6ZHeGBjuqKrxh1dHQsrJYPeooRtJsM0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 14:24:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 14:24:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the null pointer when load rlc firmware
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer when load rlc firmware
Thread-Index: AQHaRSBLq3sCt5p3n0SXuHqUd3NSkbDWO+A5
Date: Fri, 12 Jan 2024 14:24:55 +0000
Message-ID: <BL1PR12MB51449CCF4488FCF575CCA9F7F76F2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240112062608.778456-1-Jun.Ma2@amd.com>
In-Reply-To: <20240112062608.778456-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-12T14:24:55.075Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB7851:EE_
x-ms-office365-filtering-correlation-id: 945e3971-31b6-4895-b66c-08dc137a3fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1h2xpRuUl0RKsGlPTGkbdGUt5pUk8MEeZmmodkNS/Sn8LfIP0oCryov7Bbb9baKsf9PH4p3FiPinx2VC8QSFzYQV1VU0a8UaIKRwoGqW8WujEnXI+P7CiynEvsgNjmrJlM6+eaghNoJi5mBfg+4bjR/ra/Z3/nZ78/UlFY8SfIDZkfXU8I2VdvNqH+glcA/vhlJFnp9cOGPiTQ3jMfCmpj6FtWiDqQ8obLxzhYYAIEeHKvSmcS58bvMN3WiWEs89zkg6mHDy6AcVFqb/owsy5cRffmEqN860r+gIwWTIGGxw2UvuB7AadE5VdO6M0f4IwSFkwfFvI15LfJomfT30Ba9qB7+w3nSpjAGUOgijwZGuvXRFGMd5zOVYyVTzHTSOcE/KCQArAtejVGRCrZRNrr/iBiFy6THgYvqebbJPMch1bpU3ZqRz5E29ALvmkz7rQTc2rWrm1yT8JFSG9dFVWTf3Vm89tZo0PY23n5QvGZ7PX+G/BZMrNw+Cil+eECVGSafp/onLYC4dSWOzM5Juq+Jv/ASTJQ2UvWKWOV3BXtq5gWqcFDQnxRa3cIW+oFsv/aFjJsHFYi2WyLpnS0jzzq5dmWms4mNk4dhS3ydcNQxf22xZY0x/HWSqaCiTfuwQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(41300700001)(9686003)(19627405001)(2906002)(122000001)(478600001)(52536014)(71200400001)(76116006)(53546011)(6506007)(5660300002)(66556008)(64756008)(6636002)(66946007)(316002)(66476007)(110136005)(33656002)(7696005)(66446008)(26005)(8676002)(8936002)(83380400001)(38100700002)(86362001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUr+5yZLzpcXomUApnMJAtud+Jsf3Wyaap2g6dWHjru/4CPO2uQjw4OdYvQY?=
 =?us-ascii?Q?O/MQeoSMGFUyKxCVAsbxwHOFWW4Qjq3Q+va1mkqjmYpxHJDkmMpwk/jYTbT3?=
 =?us-ascii?Q?mM25Cepae8HnlaGEDdvb+IGmQcgjnBBta20H9i5lsi0mqgsF+fO/TWyLa6Xz?=
 =?us-ascii?Q?/bdUk8FnRhtZwMcwgmq6eY8858BWmxM2K6au2bh/xik0fpvZgVDmXI4lps74?=
 =?us-ascii?Q?ttD9epZOrcO+vJNKGD87dS1ai64zert0Xmdcvd14C37T4l8B/BkPaAJVUhHe?=
 =?us-ascii?Q?eUnZBZ6Jq34TeLTTnjjuI5PKV937weM+HTmd7IEVu3XfFmbMavwFdBG2PHQJ?=
 =?us-ascii?Q?a5vpPYWesMvnTOPz3oJYv2lb8YFIe7sUsUerEul8X48625IDSJuQTok8Lo7l?=
 =?us-ascii?Q?vTHsCjCVXcr9iO5Rhxqta1hx7/C7D1jzgJv4uW/bKUUpxmaQJ5UyL99YNwHU?=
 =?us-ascii?Q?/CxRaX2quVPNxC7hjAD//kbg+SXJr3fm1BJmRDWkhbckrQznTdafvmgUXZxl?=
 =?us-ascii?Q?FK2u+0wZLtc2XnrBZ76L/g2huqRSbXodkGi3kUwbNHM6pl3A6A5pl7p44WEA?=
 =?us-ascii?Q?AfstJrS8nL4l53IU10JdlAzLjdRz71c8fYzBxLyb896UpE1DTXhhv9p/zNWS?=
 =?us-ascii?Q?+VXyA9Vok4kE7SqdHTdjYMlUhrfZ1Qx9FO5MaTo2uaMcma2b6V9gRtRM3v2m?=
 =?us-ascii?Q?ESH2Nr+onEaYNhHA60XOR1uRmaNM2C7OhINWI9LKcs6JMCRJQmFsOv+fYIfg?=
 =?us-ascii?Q?eHZPInqs+lHdsxldPQvKYpWTU1Imm2/i/0aO49+gRUwx66NNeJHsjJnxUwrn?=
 =?us-ascii?Q?Xgyd2uo9ucalGTjNY4DtzzKNyM6BInMiTL2Bj80Drk0FU0MRhPaapgySagNH?=
 =?us-ascii?Q?94/apJpQHrlqz+eXmbTEA7EOhOEWsHNN7Ayzm9c5Fdn0ZTZ3YoKUzbMArKG0?=
 =?us-ascii?Q?dr7wlT5CHGqC0W+WgnrMZ2SNUQZKrdFVmPOzKRkm9Xy9YCYOblW02lA1J6bB?=
 =?us-ascii?Q?wspIf4p2+LUHxyrHcu1tW0TWwt8WYEhtBXOozgwAlOWr62UOk83DSfnQ3FVV?=
 =?us-ascii?Q?hFzT78mzRWDVtnY+P4OD6AT5tXvvdSFkfQVRGk6cUWdHTJPcEQKTSoKNAiKm?=
 =?us-ascii?Q?wQLn8mQBSH9Nf500UhxGZZ9bzXVqTzkh4Y9+samHJJxohqEk/1QnlFCSXcpr?=
 =?us-ascii?Q?dFYerj9hBnHAqXC7uQMMBaHJLT5gG4ESqzf4nx9zY29yLUPfXFiQUxLl1BG9?=
 =?us-ascii?Q?NuDjXaYxnJk6rRD884xzvXB7hboLi1LpqNW1/AhAXMgOCVBL6Z0cwabHrckH?=
 =?us-ascii?Q?xSC+e+JN+ENIYUEbzq4SJwm/DLxXOdu5oaBnkAbzlhWA2u7hATZv1luX9YDh?=
 =?us-ascii?Q?sSnP7VPpmkZLRwi1whNMo5QrAM5F0vvk+oMTEb68SFYLvtX9rf/HNxEMIAyQ?=
 =?us-ascii?Q?91tE5tV6uYGpJmnOnoD8DrCG8gEHnuCBSbCOhReJCTYjDb6mQMbagjleDdLO?=
 =?us-ascii?Q?w9IlzFr0n5MrplZhaQoetI+7IpWuk6t79Zq7FbcMdBgkppg43yHY8qxIzTS3?=
 =?us-ascii?Q?/Nzy6sRE0IJBo19EtGo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51449CCF4488FCF575CCA9F7F76F2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945e3971-31b6-4895-b66c-08dc137a3fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:24:55.4424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /G6kSu8lVDSlh9hb1lyIs3YfBqCgfy9IhlvgpuFZ78Qu4Sf0Qib9a2wH0idLmKr9OjhXe459UknnlyrNNd0WDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

--_000_BL1PR12MB51449CCF4488FCF575CCA9F7F76F2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Friday, January 12, 2024 1:26 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, =
Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the null pointer when load rlc firmware

If the RLC firmware is invalid because of wrong header size,
the pointer to the rlc firmware is released in function
amdgpu_ucode_request. There will be a null pointer error
in subsequent use. So skip validation to fix it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index d2c34436aefc..4d90e570b3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3996,16 +3996,13 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)

         if (!amdgpu_sriov_vf(adev)) {
                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", uc=
ode_prefix);
-               err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_na=
me);
-               /* don't check this.  There are apparently firmwares in the=
 wild with
-                * incorrect size in the header
-                */
-               if (err =3D=3D -ENODEV)
-                       goto out;
+               err =3D request_firmware(&adev->gfx.rlc_fw, fw_name, adev->=
dev);
                 if (err)
-                       dev_dbg(adev->dev,
-                               "gfx10: amdgpu_ucode_request() failed \"%s\=
"\n",
-                               fw_name);
+                       goto out;
+
+               /* don't validate this firmware.  There are apparently firm=
wares
+                * in the wild with incorrect size in the header
+                */
                 rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev-=
>gfx.rlc_fw->data;
                 version_major =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_major);
                 version_minor =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_minor);
--
2.34.1


--_000_BL1PR12MB51449CCF4488FCF575CCA9F7F76F2BL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ma, Jun &lt;Jun.Ma2@a=
md.com&gt;<br>
<b>Sent:</b> Friday, January 12, 2024 1:26 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix the null pointer when load rlc firm=
ware</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If the RLC firmware is invalid because of wrong he=
ader size,<br>
the pointer to the rlc firmware is released in function<br>
amdgpu_ucode_request. There will be a null pointer error<br>
in subsequent use. So skip validation to fix it.<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 ++++++---------<br>
&nbsp;1 file changed, 6 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index d2c34436aefc..4d90e570b3cd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3996,16 +3996,13 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_rl=
c.bin&quot;, ucode_prefix);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D amdgpu_ucode_request(adev, &amp;adev-&gt;gfx.rlc_fw, fw_=
name);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* don't check this.&nbsp; There are apparently firmwares in the=
 wild with<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * incorrect size in the header<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err =3D=3D -ENODEV)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D request_firmware(&amp;adev-&gt;gfx.rlc_fw, fw_name, adev=
-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt=
;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gfx10: amdgpu_ucode_request() failed =
\&quot;%s\&quot;\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* don't validate this firmware.&nbsp; There are apparently firm=
wares<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * in the wild with incorrect size in the header<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)=
adev-&gt;gfx.rlc_fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_major);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_minor);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51449CCF4488FCF575CCA9F7F76F2BL1PR12MB5144namp_--
