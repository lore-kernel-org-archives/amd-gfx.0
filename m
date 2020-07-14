Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF00BC433EB
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AC5224B2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Y9rb99X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AC5224B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B7B6E40B;
	Tue, 14 Jul 2020 13:45:16 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0F96E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZqXvzFeNfwFfwyZCOiWCCqA2VzjcCNjOS70QVZjd9iVxHlFOUTVu/YqaFvGKiIPkmiGSdh5FiafgfgemTmdKTmK74VPnRxKkuENnSQcc7HRisdLYR7mcseMPqaCWSRwU9JMUkXaFD+N24RxSKUBr1leIIEplmrc0xZFo5aCJRh7v8dgRp9rGTchvwfdLgX+Sa3xWcGxB++Wqrr/dKD1C4xmQRCDPiZd9Z9GXgL73E3pzHD1dBmXRbGcT0UmiJEPsCAtfbeIsLCfFLwPPTVCA/6HK6zLCYmy0yzDGlRtTuYQjeh5aQHeKXns7XyM9ShZfG3TAqM6BQs7cBFcQN6BxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmqJN+fGryRens/oejJU3bMHwjoZMZaq9/20bIOJ0NU=;
 b=DK2iZEnl49U1cQSEOHLlIXV93us1/KeGsUkPbTCnOWidmAPZ1+XMszReq+G9PjYFs+TTsGiJ2iZFNZkdXvtHh+JXEhBDL//xVpr4Rb5TN/3bxpwQzKgU8mqE6nj6i4oNoQGfAasZ3kr09cpKT/k5gTxhDjcbj/JyZmKDcTZjY3mSodcW4hkQsTu6CvDPBOKMG76O6zebtvufVEg89qgORFFlVpUBJhFI7PpSATrkX3oiZ3rZTehmVzCMfHpctJ1EtnDHs4Yp+rBjqkagHzTa0vDbv4s7J4CzZmzJg/LR3uMeknp6LJWiqltnclefFz88Vjdpb7TXpxWH9RmsiCE0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmqJN+fGryRens/oejJU3bMHwjoZMZaq9/20bIOJ0NU=;
 b=1Y9rb99X46PbPISpSSDIVk9Y5ySbV9T0C2FFaTfma9pzX+6t/RYk/Wf3gi2iuUo9ysTR1KqHQgsDQqaVFTQKhNflz4dlpDvid0u8qgLjgE8dbx8XzYPbsd6/OpnaBQ8/X77CkL3vIpkP0BeA2WiTkxbwE/8l1pPw9RHDOrIHPC0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 13:45:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::c8b3:24f3:c561:97d9%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 13:45:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: optimize rlcg write for gfx_v10
Thread-Topic: [PATCH 2/5] drm/amdgpu: optimize rlcg write for gfx_v10
Thread-Index: AQHWWYkMuznvloPJqkahPfiJ1huzVKkHFuc3
Date: Tue, 14 Jul 2020 13:45:11 +0000
Message-ID: <MN2PR12MB4488CE890D721C266F775D4BF7610@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1594694793-7664-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1594694793-7664-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-14T13:45:10.724Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 785a33d6-366e-49cc-9b5a-08d827fc210d
x-ms-traffictypediagnostic: BL0PR12MB2339:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2339A99C0C72C0C349D08842F7610@BL0PR12MB2339.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5CAI1/73Ty+TmxGYlWv7BLc7WMX3SxMYpSJQ1bges7GXujHVkqQiHoxQL2eDMz9gsRPpeYJr3avaDk4QGiUj0hud2+KJ/gc9ifOfVa0TDPniHSP0klLt5oe1DwWJWgmkpq1COtNA1CGqgvnHsJCjnYKxN0s27fAPaQo+HLX7QeRmTN8KBhSofaPU0a1hJetEZJveuh1sKBB+QU9SvSjPCj8YYr85ITf5ULvDBbgQQoQlIHOKIyt+XFlrDLA1y/jzJOa9JeNHNWbmv5eRg3XL2gPuT2zt5kgOHZ79ldwl3y8P4Vu36+Bx8hP+Gpg5CU/qB9labJ/lrWFyW5iahigXy14Fip8ehQKeoFqsgtUl8U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(2906002)(71200400001)(33656002)(5660300002)(54906003)(26005)(19627405001)(55016002)(478600001)(9686003)(8676002)(316002)(45080400002)(53546011)(6506007)(76116006)(186003)(66946007)(66446008)(64756008)(66476007)(66556008)(52536014)(83380400001)(966005)(8936002)(4326008)(86362001)(7696005)(110136005)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2gXV0UlGYl5zeEZDJiC43TwMwt2oH1L+coCtcxWnSQr/IAfaL8zwQsjzOj8b1uNH2uoUuOmsl3f5yVKjuFcxLWiIqS31w1y8q+v8dS4eAWCAMbEQ5i3EOd20JGXyRSH5OkiaktCWJbQ5ysFRVmPZhatV4ln7C6bajuiAlXwNo0wzmHtpcuaWWKrHGxsbFPizSl8gVjQgwHbs61BqRz3qpe0o81LIefFVtAZVL7MKdHFQOqm/u4nOlDAhZz76eZLBubBS3rQCPCM1Uhowxxig/wvlM5+MLxkdDtLpJ7mFL+QOHz5hYbGPDi16lrX6MTWbuvpHtyFobfOefQcirbw3OHffvy6L9rhfWqKJnJrSeV/+v6RGYcyuGMt2nyAogPczFjoyZMF/ggW6z5vYORh26x1yN8U41hnIyUYcDZNycQ6GbN7wxS0WPXpHk95+DwbsnNaHLrVNvF93IDiPgQq4IAEj21X4zz901Ot02JETEKpt9fjtBzoP2vlSUjb5vBML
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785a33d6-366e-49cc-9b5a-08d827fc210d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:45:11.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXOJOopo8Q1196GH3daGfsre1Cn60Wws9yORLEVReOU1YzqPFjWTide8OMefm8gAYI7Mq+nBhdR3aRsi4R0XlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1997647243=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1997647243==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CE890D721C266F775D4BF7610MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CE890D721C266F775D4BF7610MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jack Zha=
ng <Jack.Zhang1@amd.com>
Sent: Monday, July 13, 2020 10:46 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: optimize rlcg write for gfx_v10

For gfx10 boards, except for nv12, other boards take mmio write
rather than rlcg write
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index c1f8c986380c..a78a6a1b593a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4728,12 +4728,19 @@ static int gfx_v10_0_init_csb(struct amdgpu_device =
*adev)
         adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);

         /* csib */
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
-                        adev->gfx.rlc.clear_state_gpu_addr >> 32);
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
-                        adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-       WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_stat=
e_size);
-
+       if (adev->asic_type =3D=3D CHIP_NAVI12) {
+               WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
+                               adev->gfx.rlc.clear_state_gpu_addr >> 32);
+               WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
+                               adev->gfx.rlc.clear_state_gpu_addr & 0xffff=
fffc);
+               WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.cl=
ear_state_size);
+       } else {
+               WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
+                               adev->gfx.rlc.clear_state_gpu_addr >> 32);
+               WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
+                               adev->gfx.rlc.clear_state_gpu_addr & 0xffff=
fffc);
+               WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_=
state_size);
+       }
         return 0;
 }

@@ -5341,7 +5348,12 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_dev=
ice *adev, bool enable)
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);
-       WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+
+       if (adev->asic_type =3D=3D CHIP_NAVI12) {
+               WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
+       } else {
+               WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
+       }

         for (i =3D 0; i < adev->usec_timeout; i++) {
                 if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ce334ea6c4d504943153c08d827a02c4b%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637302916203617712&amp;sdata=3Dzj8wkoVYWIyGZ8Y0Dtv=
8JQ7p6C3RzV%2B%2BnbKFhLYtHDg%3D&amp;reserved=3D0

--_000_MN2PR12MB4488CE890D721C266F775D4BF7610MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jack Zhang &lt;Jack.Zhang1@am=
d.com&gt;<br>
<b>Sent:</b> Monday, July 13, 2020 10:46 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; Liu, Leo &lt;Leo=
.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/5] drm/amdgpu: optimize rlcg write for gfx_v10</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For gfx10 boards, except for nv12, other boards ta=
ke mmio write<br>
rather than rlcg write<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 26 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----=
--<br>
&nbsp;1 file changed, 19 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index c1f8c986380c..a78a6a1b593a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4728,12 &#43;4728,19 @@ static int gfx_v10_0_init_csb(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;get_csb_buffer(adev, adev-&gt;gfx.rlc.cs_ptr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* csib */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_AD=
DR_HI,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
fx.rlc.clear_state_gpu_addr &gt;&gt; 32);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_AD=
DR_LO,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
fx.rlc.clear_state_gpu_addr &amp; 0xfffffffc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LE=
NGTH, adev-&gt;gfx.rlc.clear_state_size);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_NAVI12) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr &=
gt;&gt; 32);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr &=
amp; 0xfffffffc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev-&gt;gfx.rlc.=
clear_state_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr &=
gt;&gt; 32);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu_addr &=
amp; 0xfffffffc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev-&gt;gfx.rlc.clea=
r_state_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -5341,7 &#43;5348,12 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu=
_device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, ME_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, CE_HALT, enable ? 0 : 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL,=
 tmp);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_NAVI12) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(GC, 0, mmCP_STAT) =3D=3D 0)<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ce334ea6c4d504943153c08d827a02c4b%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637302916203617712&amp;amp;sdata=3D=
zj8wkoVYWIyGZ8Y0Dtv8JQ7p6C3RzV%2B%2BnbKFhLYtHDg%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ce334ea6c4d504943153c08d827a02c4b%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637302916203617712&amp;amp;sdata=3Dzj8wkoVYWIyGZ=
8Y0Dtv8JQ7p6C3RzV%2B%2BnbKFhLYtHDg%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CE890D721C266F775D4BF7610MN2PR12MB4488namp_--

--===============1997647243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1997647243==--
