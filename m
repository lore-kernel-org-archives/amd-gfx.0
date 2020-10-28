Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00323C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 13:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE492473F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 13:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S3UgqkFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE492473F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAB56E505;
	Wed, 28 Oct 2020 13:08:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20786E505
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 13:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCIpTJ8ji5a6/1JX9MPUd6sbh4F3W2Yyyjid7hXLGmp+45S0ujTw1DEftAacMEpIOUv8DgwU+OEdDetG2zm6Y3R4qOP6hhTs8BjKchy1atF34P3Erl0UH0jZ2PgwwOyxPEYzj7e44RZ3u27ISJSSBVcz9JOID1WOy2jV0insffn178hJmkgvhMF02X2LTLZAp8nldA3gNN4KGwVcFSHDgOgrWFZ3mMw24V2+Uqf//S/aj9lVwRzYrsU4I/3+CFDjvZ4m0wtuF5xKGVQGXWE3Lzc7I2oSyTuASJAa3wXfN3MOFEgJRLXxCVCmzKFWG9cbOgTMo2rKNLDoGVLE9/OyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj4S9V3ePjp3O7wCRbzcCgtd4EUSi8+ovt/2wS7zSF8=;
 b=KKpeXZSthHft3n30gRtbeQsm3VjMjwnmGUevRWFf9nt/uZn368mkkbxgkmm4NAYHRltS8WmzgfbS7rosVcFDx0vm99F+k4iex3Z9Rk+acsYK6OLVKAPMx64V34KzunucJ35BahLo+dTEwiNbmmZe33qzeGySA8RXmJ5nSqv8Jt6ZyFF6alBbDqC+oJ/jH2/TBYiDTGm1unFICRfkydP7G6l4cnUlvCKPeB2UmTRrmNwkTNfh2QNGLy8BNeSVrRubZuOk+z1m8AZ1QkjIxJid8ilB6kk+pI/XH9ygr2BGwuWe2gxVKCkMYoQbM2fcvFrBpeAY18Y2ZoXQAPAeRfgKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj4S9V3ePjp3O7wCRbzcCgtd4EUSi8+ovt/2wS7zSF8=;
 b=S3UgqkFAH23beAOBpVrST3n+P6hjUrHG9Szl1HvieKpSbOvMHRGr3ttpeBWAm3N9Brm91HtX0Skqr+QgjqtliC03tTPjRiWo/eX6IgckX5YLMJhgSDP+F67VwFSdm31C7P90ufFswm/eHn6QVNwocxgqU76WHDk35G/XZMj9eXU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:07:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 13:07:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] drm/amd/pm: do not use ixFEATURE_STATUS for checking
 smc running
Thread-Topic: [PATCH 5/5] drm/amd/pm: do not use ixFEATURE_STATUS for checking
 smc running
Thread-Index: AQHWrQStL4wptIMEb0G1axlUgxbKeqms/JFS
Date: Wed, 28 Oct 2020 13:07:59 +0000
Message-ID: <MN2PR12MB4488993B34BD776CC37C5A35F7170@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201028083031.1195496-1-evan.quan@amd.com>,
 <20201028083031.1195496-5-evan.quan@amd.com>
In-Reply-To: <20201028083031.1195496-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T13:07:58.383Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c742ec8f-7e82-4c6d-ee07-08d87b427e63
x-ms-traffictypediagnostic: BL0PR12MB4931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49319A5DF677B8D9ED23FE1CF7170@BL0PR12MB4931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b9kZNFT5deBiXJ0J+8kD9r+AmiF3togx2sjHVlx0I0j09QBeKb2aK957uNoudpI3/TydxwVxo9ZBx5zhu1aMHQW/hM6GN4sFbH+U/aQyX6F69if5NEd+FDMEDYn/u6QnAGNUooU8pR1coJi6NwHoZ/Mi2i98K0lK3Dl/xYA8879amNi/ZBQyVLL28F6NB4MtLSTHSWqOJVHk0bl4Gw2wOR5yS1PuttF9+X3PKkToWMKHn+frvpVnSj0FLQfefQksCFff5mRvMafLNTfq1IKNWd78NzT4Gel6mLQWyJ8uwaPS7TbS8d90E1ZFJOLvyCYxm36jnP0XM0pHT0aHDKBzFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(83380400001)(8936002)(33656002)(55016002)(2906002)(19627405001)(4326008)(53546011)(478600001)(52536014)(7696005)(6506007)(71200400001)(26005)(316002)(66946007)(110136005)(5660300002)(9686003)(66556008)(66446008)(186003)(8676002)(76116006)(86362001)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 58hX0i/OiW2NpwhaEhhm27mC77gaLyMZc1KZhk8icdHXS9a03oPxW3ghuCYqpE81UkVtuisNHAp3P5BTQ9eqO8AtTg4+cyjIYspGHZuvcm22+2xsRmE1Xct20Ufnv7quALPPRCuVjyCXFdOFsYfDbo8tepRtJiFsXCPRBWBur0Ft6K/VQLMwK3lxLCOz/FnQvOWMDAVnHIaCBtlB+oiJ7z7sSQMhlG6tlWU3ekIDYVRI+2cI5dthEYEzOyqlfPXGIq0nxzLVhivfMGKSJYg0jwqa3eTt5PXrWyfpwL8Psc7J6czvORkPYYT+Z5w9ng11IW/suEBIv1OG2XpsZfhbUYoN5rFQKWcXixV923gN8esVOKT29qM7D28BeRMswRrrr85eENYetWVplERmAvD8avCyaDhMXMDUEOPs7f4CHT7ed0FWz+XnflVC8A4Gh+5/q9l3yuIfqgh5ZohCQx6I8aKU+9ezwRJfe6Cy5MR9b8snKzEkzsXOuiVW3OfXimgi1KjY1AZ9xOMF7irs+6rCksBF6iSbArIxV8MGmXDR8h1Be1dcEv0nY7zreyYMJ6Xgk3l82Mu/1huJg7aRtOC/zquuLxblqcYXl9HWiO4UAGtY96oeaUwDn8aLUNsqUG5Hd6H5/r4Iv1//w5nGofxmBg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c742ec8f-7e82-4c6d-ee07-08d87b427e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 13:07:59.0515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Idkr3+Tl+kbKokciFMeJT66rBLE0/WEcqqs+3FUHZZ3ucB3amgIM7loW8pGFJv5aB0KW8EE+dM3jahk4UX614Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
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
Cc: "sandy.8925@gmail.com" <sandy.8925@gmail.com>
Content-Type: multipart/mixed; boundary="===============1367006311=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1367006311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488993B34BD776CC37C5A35F7170MN2PR12MB4488namp_"

--_000_MN2PR12MB4488993B34BD776CC37C5A35F7170MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Wednesday, October 28, 2020 4:30 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; sandy.8925@gmail.com <s=
andy.8925@gmail.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: do not use ixFEATURE_STATUS for checking s=
mc running

This reverts commit f87812284172a9809820d10143b573d833cd3f75 "drm/amdgpu:
Fix bug where DPM is not enabled after hibernate and resume".
It was intended to fix Hawaii S4(hibernation) issue but break S3. As
ixFEATURE_STATUS is filled with garbage data on resume which can be
only cleared by reloading smc firmware(but that will involve many
changes). So, we will revert this S4 fix and seek a new way.

Change-Id: If9eed2f5a9c1168fb20be92057b583d854ad779e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 09128122b493..329bf4d44bbc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2726,10 +2726,7 @@ static int ci_initialize_mc_reg_table(struct pp_hwmg=
r *hwmgr)

 static bool ci_is_dpm_running(struct pp_hwmgr *hwmgr)
 {
-       return (1 =3D=3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
-                                            CGS_IND_REG__SMC, FEATURE_STAT=
US,
-                                            VOLTAGE_CONTROLLER_ON))
-               ? true : false;
+       return ci_is_smc_ram_running(hwmgr);
 }

 static int ci_smu_init(struct pp_hwmgr *hwmgr)
--
2.29.0


--_000_MN2PR12MB4488993B34BD776CC37C5A35F7170MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 28, 2020 4:30 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; sandy.8925=
@gmail.com &lt;sandy.8925@gmail.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&g=
t;<br>
<b>Subject:</b> [PATCH 5/5] drm/amd/pm: do not use ixFEATURE_STATUS for che=
cking smc running</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit f87812284172a9809820d10143b573=
d833cd3f75 &quot;drm/amdgpu:<br>
Fix bug where DPM is not enabled after hibernate and resume&quot;.<br>
It was intended to fix Hawaii S4(hibernation) issue but break S3. As<br>
ixFEATURE_STATUS is filled with garbage data on resume which can be<br>
only cleared by reloading smc firmware(but that will involve many<br>
changes). So, we will revert this S4 fix and seek a new way.<br>
<br>
Change-Id: If9eed2f5a9c1168fb20be92057b583d854ad779e<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +----<br>
&nbsp;1 file changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
index 09128122b493..329bf4d44bbc 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c<br>
@@ -2726,10 +2726,7 @@ static int ci_initialize_mc_reg_table(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;<br>
&nbsp;static bool ci_is_dpm_running(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (1 =3D=3D PHM_READ_INDIRECT_FI=
ELD(hwmgr-&gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC, FEATURE_STATUS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VOLTAGE_CONTROLLER_ON))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ? true : false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ci_is_smc_ram_running(hwmgr);<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int ci_smu_init(struct pp_hwmgr *hwmgr)<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488993B34BD776CC37C5A35F7170MN2PR12MB4488namp_--

--===============1367006311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1367006311==--
