Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B7DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 14:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821D1206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sP9/AYZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821D1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315DD6E915;
	Mon,  8 Jun 2020 14:51:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081AC6E914
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 14:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIbbP8gJkiN3WGzh8P7jQ8oR8/Syo9RtqBn8i3bkp0ZZpXA//iTHTZugcx94AQ5eqfpku1zbMNSnEYrWh9/7ZN4XFIeEbI9lSj5hbL9FhgdlKKbwPKbrqDPtrg0esTrDBs/Qv6+7OPuxVb0QGN+29r8NYVwrSkhgdjFbFRJIL1y09amSY8xPncXcGzHSgZUldb6Po/sF4JHwvC4rw60JCV6bwgCzNojRZiwAhTjKgw4TWCMXbPn8Cfep+rVlW+Q2w1hJemyGVFCIXdsuutSpx0/ryq8nMqCyyYSsjX+07LNyxntFSZAVz2kZOHPo9cx2DW1R7ZqX9pB4txLeohfUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq+2Uivu1AMcsSaHU5nHkuLZboFMY2Jef5iyBTl+pjY=;
 b=bY6c7a4ALb7cRmDpguirtKmyIp+KanPle4vrnzYKdXuEKbt+jj48tzBLQjP9aaRxLDyb5E1okwoNdM0gPazsr5exx6mHJRuZBqLvLbMBd+rDsuMVoDH8d1uH6fmfGMdjrA245FxxaxLEAqIvqIT0laBnRYxKBMQ3fNLexLcbegbCMlWTTsZa8G1qSW+PTeDTb5gw0w6EtYDs4Q0B7jKbadSserVKGPuYp55OkTwmcUw+aUc/5J7IPkfRMglL5A74LN2e2Ih++W2asFCMQRXBw00VfukCPktTFG3scSePAJJTPOsysGAOf4hWr9bkrSY6fy0O4t2lXDEI7aeoI8iAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq+2Uivu1AMcsSaHU5nHkuLZboFMY2Jef5iyBTl+pjY=;
 b=sP9/AYZm0w9xBXlfwP3Hb/HMoQFnFKxB6ur3q9v8Q9iCaP1/kl3KpJTJoP2rDKdQr8nqGeVKVdV2hPrkcWwkfYEjXr/uoaEhJdL+88OiKkpY3nOWs7K8dslVd/yHLOBJPFPmyHncbsi3/u0dInXSfRmcmHNVP6jNXevzaI+qAl4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3085.namprd12.prod.outlook.com (2603:10b6:208:c5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 14:51:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 14:51:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/soc15: fix nullptr issue in
 soc15_read_register() for reg base accessing
Thread-Topic: [PATCH] drm/amdgpu/soc15: fix nullptr issue in
 soc15_read_register() for reg base accessing
Thread-Index: AQHWPWc5SsNbQ+ERuEKTvQunKNQNFajOzX75
Date: Mon, 8 Jun 2020 14:51:07 +0000
Message-ID: <MN2PR12MB44881574050B35F14D404D8BF7850@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1591601648-32141-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1591601648-32141-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-08T14:51:07.486Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.222.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b54534f-7d79-48db-7981-08d80bbb60a8
x-ms-traffictypediagnostic: MN2PR12MB3085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3085317C1EB8F28745D2FA70F7850@MN2PR12MB3085.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUE7f89G5Azk4CWyMdL3UV3oDeYD1MGvZcTQKon+tUUXIJCbp3tj++9ZQARkSSnu59u/UOX1/5Sn6eQoNscK6rmDxm7zUuGVtdgl4X5zMilTe/3zSiCZKFvS7QsfFNrdCYgCiOhtXDFz32afXWl1+tJDQ1J3ZiQIax99xKS1DVdQW1K+MPJzGqVDNeJNMka91f99kT/fO4QA20fXbJtsaWeH5YNOMrrUy/nnPOPFg/e6qRI72vFMD1w8sHFJ9czRqRyfhkpFIHqz2xuIMkr57w0lGiwVIBKWLJid1I2ad8CZd0u+Tqan2iD0CR5qrktnWK9X4d4fSku3Y+YQEZFQuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(110136005)(478600001)(4326008)(55016002)(66446008)(2906002)(8676002)(8936002)(66946007)(76116006)(64756008)(66556008)(66476007)(9686003)(19627405001)(316002)(5660300002)(7696005)(83380400001)(33656002)(71200400001)(6506007)(186003)(53546011)(86362001)(52536014)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1zCT3ZQNiIQaO4VK4BFHFAXalJhHLqnToowXzNLEobxDtiFcRzUa0DhyCOVzdqlCIJTLS/oQVTxC1aw7iRJw7o8iQj/D4UZebjDprlG9EOFsmWsdsnFQSjIsrB7u4ZCPSW6F8ZdrRdW4x53upI0GrIRW80IxjBf4zgnlih40aMKv7t7e4Ck0Awm072utVbKH7Y4C5T19flNL8lgxMd4WtOpIJg58HS6IXJKLWi8Xt16ZBoT9aS2GGaOwtfp68wIeAKL3F9hfrjUeTFjCyBTQ92RFWVpBZM3gV87i9XywN6+W33mWE87/q6uA+2c9RAeVNn8+ahOecS5ULysQwuTy71xOk3jO1ZNDOadtNxfTqRxCOavTAvIVNwQAqRdaej6+jqgpkeChmPHQ4V2q6JFtKQVIOoqzrbdqshyUT8rA/Hl/JZ0kKcN2o2Ya84+0vc8ofz9z1LfznMlJYDg6+0+P4FXN4zlvAIL586OuAdw0rovfjbMG+p9h84iYcwmfNvja
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b54534f-7d79-48db-7981-08d80bbb60a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 14:51:07.9576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+cYliNu+F87ITSdufiJWVS7i4Tt6T2WMK/znzSRp0HbPQh33DHgzuAKmFfrO6R3RaC3nXAGMCADjL7DaWszZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3085
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1725272764=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1725272764==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881574050B35F14D404D8BF7850MN2PR12MB4488namp_"

--_000_MN2PR12MB44881574050B35F14D404D8BF7850MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Monday, June 8, 2020 3:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/soc15: fix nullptr issue in soc15_read_register=
() for reg base accessing

The failed case is no SDMA1 IP for Renoir discovery table while in accessin=
g SDMA1 reg base,
thus need have nullptr test for soc15_read_register invoked in MMR addres s=
pace inqure opt.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 623745b..3e406ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -415,7 +415,8 @@ static int soc15_read_register(struct amdgpu_device *ad=
ev, u32 se_num,
         *value =3D 0;
         for (i =3D 0; i < ARRAY_SIZE(soc15_allowed_read_registers); i++) {
                 en =3D &soc15_allowed_read_registers[i];
-               if (reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][e=
n->seg]
+               if (adev->reg_offset[en->hwip][en->inst] &&
+                       reg_offset !=3D (adev->reg_offset[en->hwip][en->ins=
t][en->seg]
                                         + en->reg_offset))
                         continue;

--
2.7.4


--_000_MN2PR12MB44881574050B35F14D404D8BF7850MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Monday, June 8, 2020 3:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/soc15: fix nullptr issue in soc15_read_r=
egister() for reg base accessing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The failed case is no SDMA1 IP for Renoir discover=
y table while in accessing SDMA1 reg base,<br>
thus need have nullptr test for soc15_read_register invoked in MMR addres s=
pace inqure opt.<br>
<br>
Signed-off-by: Prike.Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 623745b..3e406ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -415,7 &#43;415,8 @@ static int soc15_read_register(struct amdgpu_device=
 *adev, u32 se_num,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY=
_SIZE(soc15_allowed_read_registers); i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; en =3D &amp;soc15_allowed_read_registers[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (reg_offset !=3D (adev-&gt;reg_offset[en-&gt;hwip][en-&gt;ins=
t][en-&gt;seg]<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;reg_offset[en-&gt;hwip][en-&gt;inst] &amp;&amp;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_offset !=
=3D (adev-&gt;reg_offset[en-&gt;hwip][en-&gt;inst][en-&gt;seg]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &#43; en-&gt;reg_offset))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881574050B35F14D404D8BF7850MN2PR12MB4488namp_--

--===============1725272764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1725272764==--
