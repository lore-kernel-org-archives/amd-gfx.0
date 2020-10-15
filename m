Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F07C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 13:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A165F2222B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YLOJw/4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A165F2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD77D6ED13;
	Thu, 15 Oct 2020 13:36:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBB96ED0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 13:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5MPTSg+kAIEyZ4zthnnquchMZOskOmNH7HI6MXs1bMEDWgyX2lGWyMIKjH+L7qfesAJeabALrxnAkMZSLCBe2ebg4fWjsUM/5HbIGvXwoSfRno38ZpIpMA4zfsjdbfsTCD+p73Sro11ZqfXqwQTok3PPvb8iaXlD/FZ1Vl5rKWCg4sY25wmsYB9cal3Su81QFoxR0jXVK4YzHncQe39G0zxLCUEJ/mxQxz6Nkx+z8SeIq7P+qgFmt/DXWD1z6aKRPw1m8dzOICzDr4FNtOff3v3nIAsM9l8899O6yf+jg//Kc6Wjd98nuD/74eqyQs2s+hNubuuQQ5C06aKQ7zLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpJYT5+YkMU3ybESaXkTEOOr/VtKayxvF/xg89u71Z8=;
 b=e+yF9nMLRNORkL/D9EgHMceHh615VJw80cbLiQ2JxPkrKRrGtp23huGdz+dW52VbS63Tfryy5qcd3mdc5cAnCsjrTkE8jeZdjbb4YyXNjOZCBKApE/B4yWGdwDa4WVh5SdYbMp7rQd4rGa2aEuQehC0xivSXrUNF0Bvp2VMpoIHyUYE9dEfBMC0bxHxYKIihVzr45/J/grL94EYdl33UG4VufvpNtEXRnc2SfGFwmxH+stPMTukJUpHNGcSxAiotE1xpJePkJlRWsm5lpG0dXYiMy9piRBoi9TN1CgzWjfEN4WpcC7KTU44KfyMIXQyEUhmNzEZPOX7cdJu3oPCd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpJYT5+YkMU3ybESaXkTEOOr/VtKayxvF/xg89u71Z8=;
 b=YLOJw/4kkl05e3yjIuropeoTmVr4GfuCScj7oTj1Yt4urzk3t1LLIy0kLj3UvkAdnAytXuvQ7x5f1eNDfEYiKinzukQVpwp/FdAC4Z39s5DhoyXEaOWvkMBYcRqNcJzrvB7YiPpTP6X+4meDDybXkNUO6CpY+R1rx2GOkfEQ4QY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2498.namprd12.prod.outlook.com (2603:10b6:207:40::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 15 Oct
 2020 13:36:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 13:36:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/display: enable display ip block for
 vangogh
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: enable display ip block for
 vangogh
Thread-Index: AQHWos1Rpa7i8vwoAEqCIfLfO+HWWKmYqqYy
Date: Thu, 15 Oct 2020 13:36:27 +0000
Message-ID: <MN2PR12MB4488ABA724C8221C947782FDF7020@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201015082856.215547-1-ray.huang@amd.com>,
 <20201015082856.215547-2-ray.huang@amd.com>
In-Reply-To: <20201015082856.215547-2-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-15T13:36:26.786Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6e17cdb-c319-42e8-19bb-08d8710f516c
x-ms-traffictypediagnostic: BL0PR12MB2498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2498069E23D0D7CECEF5CCD5F7020@BL0PR12MB2498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+0hUdOCQgJpRPpzvtnkvNM0zo515XJGoca+hy2BqHOQUhTNdriJwVeJn4LlBAFkYXUriNfdXbfWdDHx3/4ZK7zeQTSEnwQ/D+vrM2780WzX+LlKueMFyR+O3fAD60Wgj1PQCbQQFfYLrZ1wQQLJaA8nKS3d8Gu9+70m2nJCrawEzBJZSHnxznim4SvUxie8ip97o+q9xk7l0tc9blIRMkw9VDH+dvxpLA44H51FgKoADsRR+EZ1ycpdRx7rnGAtSyM1fwVFdBI+0rU8jSoapB26LZRLVGyWzfMmNbFmEvZS3sUal1TWSq+tVkhEavF/w0KE3I7wvYR+TdHxtaOeWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(76116006)(478600001)(64756008)(66476007)(66446008)(66556008)(66946007)(33656002)(5660300002)(19627405001)(8676002)(8936002)(52536014)(86362001)(83380400001)(4326008)(7696005)(6506007)(2906002)(316002)(26005)(110136005)(9686003)(54906003)(186003)(55016002)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Tm5eY6FSHkJJaHeLMKoZhQmSQ2Hxf7n33Z+oSLVkDWM7z/gr7lxt6jah6K882UmwBU8N0jAkQX4QBf6hCQvmjvL0M0s47zWZr3iXJsgSwn1HXaSMG72vBN18Bddz8WQBYYddYQ6A9fglyeXirL1dl6hz9LHy1RikPcBXT/npMrDzlcsL1J30JkyQ2h6GYjWJIqX4rBulltSld00T9dwVQT069wLyKZ9bTA3muATAhBprmBHyrcN0Ji9h+WM+doX7Lw3M9WsulO+iuGJFcdy7bzfViGnt+vUFLSivZHmG2efvEjizmlbJtLRCpzJkuKXHewCUiroXPSAtNpNnHkCS11leGb2X44berfn0wiezU8tFpVeUkesKdF2iRlPUk8VEPWpRmYLXfMhu6i4GMf31gp2JXTGgUWc2RXi8glB2oIINvM0FHQlIQFmoEpAwTsGRoZsK1vrJyXP2mKfjvR/HgqvUa3aFONcX3hTx/S2GLC/Kn3+shg+i00iu/PpV5+MIucCF1+6s/J+ATgF+/4PC7LxSNluw6e2TOngpF0uUFCyQoSz1CM1fAyDcilEztJP2x69o6o/9xu18h4UuSxhybVYOHtrEIK0DcNb5RR5yKVUXtIDxs7fujBEa3IlJawKWQgZG3oJ7yWSKTOnV6LfWzA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e17cdb-c319-42e8-19bb-08d8710f516c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 13:36:27.6575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSZqIjoh0vrGDfkcWNu3EAhd2w3KJkh5JCe9EsM97+zUPwNtW32VlfWkWrRPnnppvLkmv3ulycwoEyZBdIiGrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1165634338=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1165634338==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488ABA724C8221C947782FDF7020MN2PR12MB4488namp_"

--_000_MN2PR12MB4488ABA724C8221C947782FDF7020MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Thursday, October 15, 2020 4:28 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Roman <Roman.Li@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.=
com>
Subject: [PATCH 2/2] drm/amdgpu/display: enable display ip block for vangog=
h

This patch is to enable display IP block for vangogh platforms.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a2f0ce854160..15ffb47bd1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3014,6 +3014,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_=
type asic_type)
         case CHIP_SIENNA_CICHLID:
         case CHIP_NAVY_FLOUNDER:
         case CHIP_DIMGREY_CAVEFISH:
+       case CHIP_VANGOGH:
 #endif
                 return amdgpu_dc !=3D 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 47bd79c9e6ea..217533e2f181 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -621,6 +621,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_b=
lock);
+#if defined(CONFIG_DRM_AMD_DC)
+               else if (amdgpu_device_has_dc_support(adev))
+                       amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
                 amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
--
2.25.1


--_000_MN2PR12MB4488ABA724C8221C947782FDF7020MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 15, 2020 4:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Roman &lt;Ro=
man.Li@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; H=
uang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/display: enable display ip block for=
 vangogh</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to enable display IP block for vango=
gh platforms.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 ++++<br>
&nbsp;2 files changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a2f0ce854160..15ffb47bd1f0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3014,6 +3014,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_=
type asic_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 47bd79c9e6ea..217533e2f181 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -621,6 +621,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;smu_v11_0_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_v=
f(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;dce_virtual_ip_block);<br>
+#if defined(CONFIG_DRM_AMD_DC)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_device_has_dc_support(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;dm_ip_block);<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v10_0_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;sdma_v5_2_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_blo=
ck);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488ABA724C8221C947782FDF7020MN2PR12MB4488namp_--

--===============1165634338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1165634338==--
