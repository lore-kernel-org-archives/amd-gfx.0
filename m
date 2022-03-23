Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64917C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 18:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E0D89341;
	Wed, 23 Mar 2022 18:41:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B10189341
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 18:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFxKeewGR2Hq27YOx/qC/yIrY6p8db1FjfShJ/9zCbwooxYT3FAURGp1rHbEtEoacoK2ThG//N/Htxe62/luC6rHldC/W7Z/jQvChtAP6LCfV4+gZcOHiAdpImuu/2/EBrLgajHXf8dF4OMCYTDFmqcaXtmqZ8/8+Hf7apn9gfmVil6euYwrpmF5JiSwXm5EKZUSP6t/fllptAgLpe2QvOTiyEDTw+fYLKfItlbmjFdboGkEybnyOI7N38fwWdNXU7BI9p7Ya43ZUICYLrG02bK1Wf2Ty4bXaE5F3s23H0TAa200VMCyc/Du0lgdG8jAwaWhREi6eyFCLel4LIrNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph5yAWCwjBh+UTdrDNT52z9E1yn1hQj/SFbk2JVKYn0=;
 b=fZQHuVvylQJAOv/QiimNMhzJ19dujBEUlmBFQynVMaZfZ+mA4wrWmyy947u7psNNJ4rvivhGntdgPYd69gNGNitvycAW7QgJqJ+At5b2JePmZee00p4UmwyF51TLVaWqx7jXnMNtHIkRsDnXi8ZcGKhNIiTHsF/RMeGIvp6jJD/LK/08UEVOkOlr+wM2omiiYVjA6tasUgTaQFZ1YR8KXPIaonC6dhZLnJUVZnA9ugUaUdB2825o9mch5171PRs8IKL7o0f6b7Uysc1mc+ZfnCO7OQrFiY+WaDbl99VRiPGbjIAIyfywK379DvNO56NEV4Unz0INc/pkICr0dJifQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph5yAWCwjBh+UTdrDNT52z9E1yn1hQj/SFbk2JVKYn0=;
 b=FEu1BkGyefNFnhmtvfNK4p8yjKR4K5NNJ8x/b3dQWgVcLAuTV+iZ6MN3sDjMpf/aSI0H2l/eRUTL0OTUcPFYd2CC0HtfY5rB/d+hxe10tj8n6VSWOmp/sYfMl5XBNB4GlOzssXvFFLXlV/UaYeblZIaaxoe67qtCVM5gsoS2fPw=
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 18:41:37 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5081.024; Wed, 23 Mar
 2022 18:41:37 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/vcn: improve vcn dpg stop procedure
Thread-Topic: [PATCH] drm/amdgpu/vcn: improve vcn dpg stop procedure
Thread-Index: AQHYPs89AmkMLjARsE+rB7rTYXOtF6zNTXhS
Date: Wed, 23 Mar 2022 18:41:37 +0000
Message-ID: <DM5PR12MB1753E9548673607D5BFC5CA2E4189@DM5PR12MB1753.namprd12.prod.outlook.com>
References: <20220323160109.1327592-1-tianci.yin@amd.com>
In-Reply-To: <20220323160109.1327592-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-23T18:41:36.501Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 1b452eed-3ea0-0641-06c7-d5aa468e111f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba8ee01e-f527-4eea-5fad-08da0cfcc338
x-ms-traffictypediagnostic: DM6PR12MB2635:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2635D9E00B4057B60FE13D0BE4189@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYImJH2xvsqUhdUfVK8YSEFUAfHUyZUtQvsvBv/TKntJzlztgxIOJuGJkECr4fvIgeXGcpaDkzyCx46lFHxdBbn4/IR7/KQUdq1iVE/NXW4yxY4FZx1pmK9GKOyJys1VCzfHPeU/rkwu7JHTO3/LH2dQXCZOXwcy2l+hQpI8wTDXHI13rTbFi+G0ZBrryiAesEx1zwDD9/y2r/OyiclOfCfbEtAc6McAhg/DyN1rYEvoJJewph6tpTugqqsx0wObf6wjX+QWWZ8sRiYWes3jt2azZC6tgt1SIM0bEMMU9pBq3pdoyjBEo9ZichMa2O9FDAbkrb1d2Wh5xpYO9XVxWcGJ7q9buNIHbMhhV1RPU4jv2Pz0i4CASA2m1mQJf1fVuVna3D4nQxtjiCuLCPpZiA+dQuDU3OU3BitCyOkbdjzPmxGbWnnkh771vqrOr7V+6GMaNE/UO1CWuhdFPFaG3SET+CEMMjtCyip2vo5pFWpbcCFCi0xSMCNYVIer0R0ftjyRdyzJhpK/y6pJ6lB1pcmgQO/3qYnVMe1PhwADimElz1ofkrG3HWi7oTunTEds+oxtrO8FnW2TQnHVQCNbuCPgrT72BSYCxQgaUaO3RE0tunx+LM9UgQuldNsnw19qdzxogmRjtNwjHukafmymw4PAQkjWa1HJTAZeLWL6skdtKek1SlCuVWeBVqLwqiBGp8d0IvMGJF/95P4+XiEMxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(66946007)(66556008)(316002)(76116006)(66476007)(66446008)(64756008)(508600001)(8676002)(4326008)(91956017)(122000001)(52536014)(19627405001)(55016003)(2906002)(53546011)(186003)(5660300002)(6506007)(7696005)(33656002)(26005)(54906003)(110136005)(86362001)(71200400001)(9686003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gWsdcsczGWMS+tPD06QTQVTll9t3fsmYiVBWKNK8/i2SLIhlVQAYxaUzKiy5?=
 =?us-ascii?Q?VYHJjafSVp5fJ12IiQrUYg+lNjvWxoZ/zPmUJXZSOq2mFgYSuAr7b8uwygty?=
 =?us-ascii?Q?2yVb+lPFD8wyUWlPcFoti68jEX63zDLjvySL8YaacRWDIDaSCoESiv0reNJd?=
 =?us-ascii?Q?b5+oBHKolvX5G/iVKg1Rm8y9peuNGTUku0wJqH7aaqyne5/6GXAtwUp8905l?=
 =?us-ascii?Q?wC81QJsqXl9CGyLP2Pv37Q59/htmw65D275CiksJYO623i8IVTDu949OFTZ4?=
 =?us-ascii?Q?c46K3WQrIx9uvracjpMTUOEUwXlZq8LrpUkIZHtEPq9/Gu2vb1hZy3HHyjvV?=
 =?us-ascii?Q?KaiAJU3KIQFhdw4XXj/SQ7w17wEcZHu16ucCH2FtlJNJR/n+diAhGPuPulEe?=
 =?us-ascii?Q?Bb66TaEwt787xE6PnEm+uuEA3LPxFPnEZKZTWwPYeF3hYN+2d+WX69iKqXFU?=
 =?us-ascii?Q?z2cwrZPEQViQh3UyrmNxwo8UkzvZ9SNcM+icpn7VwUGcrm8MyWnxGjrFIS25?=
 =?us-ascii?Q?pEZfo19RKKbmITgW03qQJrC6XjZ0XSmXK9+ukSEK+vlP5dYan65GRsOyXkeD?=
 =?us-ascii?Q?YY0sORrLWj5D4fPVkMaDd/xOkSPYmcIJ51uQvS9Xd1iNnf2Bl4oding8DfYd?=
 =?us-ascii?Q?ffbllLdJR/QMKeHg7DTdDOBK8VGsqiYS3B2m1y/O80LiyvJhayv8xyrkqUNm?=
 =?us-ascii?Q?aSihqETqAg+p2qp7M7iQFzvypMpi85nWXmM/ZOk3kR/bQJE175kazGXSAmR7?=
 =?us-ascii?Q?f3LWNrZm8PdtCIKB24rq4tVICnSLCXYACUmfq8eawNzc5ClZ9Aogl0W9bS6P?=
 =?us-ascii?Q?CzzyaJpRG15a6XD4iUprMdDQrYwtcnkptZcXtCXCGSS/JBucjafIN6BzxG41?=
 =?us-ascii?Q?pa625OCZ+Lf90oy6y+JDmWivMCv/DTZRjoxImK2ExL+TPeRtp1sk2U1KadQ1?=
 =?us-ascii?Q?30fhIvY3hV46/vg68t0LWtfu4r+oJyIw7F9KYNHZEYQQLY3bnwsSuPCsCUtz?=
 =?us-ascii?Q?GrF1SPgV0zTX1aQfsXhyIgmmLleL4CZ8zlk98Ico1PGhrlsrycIwnZnN6F/1?=
 =?us-ascii?Q?e1TVNmTm7R6c9yt9OMjGR+6pY8DKxN7PFmAFM521lbtSs1VLZ/QRG5z2WqQH?=
 =?us-ascii?Q?u2nNTaCp7y+IDbmetuMQ7xR6NszmahIWvOKy5Aw67Lb7FzNzMSMRC7sbD2I8?=
 =?us-ascii?Q?0kjBGWBcruVsC5rg9a+1a7k56HIMYvcRmaacgaNECVVp3CHBLgb5NDtMOvGJ?=
 =?us-ascii?Q?LuVW6eWUHHK/AFsqH08DRaN1dBOvjaHjWSMhjI+mKwpJnJhm2vlY1psZskoD?=
 =?us-ascii?Q?Ma0S3nHimTO/Qh82w7kU1MaXXT+lUp0eeeLWBDtpwSqgjnQvzvvV5h2boFCB?=
 =?us-ascii?Q?SZ2bwgWt7HsYDUhQnhSbt621rZrQNEz1FthOKmq0QkZVC3hPIk6H+PjYinwY?=
 =?us-ascii?Q?Gni/H5/jWhM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1753E9548673607D5BFC5CA2E4189DM5PR12MB1753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ee01e-f527-4eea-5fad-08da0cfcc338
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 18:41:37.1483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKxf8NcGcD22P/wHa1TItn9VOC68swI5kdQMY89++GlB3otp67RpDcfUBiu7bvEY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB1753E9548673607D5BFC5CA2E4189DM5PR12MB1753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>


________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, March 23, 2022 12:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: improve vcn dpg stop procedure

Prior to disabling dpg, VCN need unpausing dpg mode, or VCN will hang in
S3 resuming.

Signed-off-by: Tianci Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index b16c56aa2d22..0d590183328f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1480,8 +1480,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device=
 *adev)

 static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx=
)
 {
+       struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPA=
USE};
         uint32_t tmp;

+       vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+
         /* Wait for power status to be 1 */
         SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
                 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
--
2.25.1


--_000_DM5PR12MB1753E9548673607D5BFC5CA2E4189DM5PR12MB1753namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
This<span style=3D"color:#c0c0c0"> </span>patch<span style=3D"color:#c0c0c0=
"> </span>
is<span style=3D"color:#c0c0c0"> </span>Reviewed-by:<span style=3D"color:#c=
0c0c0"> </span>
James<span style=3D"color:#c0c0c0"> </span>Zhu<span style=3D"color:#c0c0c0"=
> </span>&lt;James.Zhu@amd.com&gt;
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tianci Yin &lt;tianci=
.yin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 23, 2022 12:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhu, James &lt;James.Z=
hu@amd.com&gt;; Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Yin, Tianci (R=
ico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn: improve vcn dpg stop procedure</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Prior to disabling dpg, VCN need unpausing dpg mod=
e, or VCN will hang in<br>
S3 resuming.<br>
<br>
Signed-off-by: Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index b16c56aa2d22..0d590183328f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -1480,8 +1480,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int ins=
t_idx)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state state =3D {.fw=
_based =3D VCN_DPG_STATE__UNPAUSE};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, 0, &amp=
;state);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, in=
st_idx, mmUVD_POWER_STATUS, 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1753E9548673607D5BFC5CA2E4189DM5PR12MB1753namp_--
