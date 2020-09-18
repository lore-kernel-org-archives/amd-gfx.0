Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67ADC43465
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5161B23772
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 02:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dAbPXAgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5161B23772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84E16EC8E;
	Fri, 18 Sep 2020 02:39:10 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80156EC8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 02:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYJ+kaQGDB1fPeKiq3Ft5SVQixi5HQJ+HkXIsdlCrpgy5wqsVv81h8feohoCJfqt4tcGtjjFUgd8ZMRWuRsJ76bGLpV27zTrxfGoxtMk5LkhYZ6Z5JzXA+vMYz+hELb8sUII4X9rbVbTlJBbOSxjQPktz02l7CliRfqalNX/uzC6Z1v9cs/qOadMsCZNyLsltmLxMp4dwnLVxDgnC5m0Pb40WlJ66c3aFWKNiQ6ALIyoiYQ52wXAL2pd36tjd6ZImOYqQXVlD3LQr3V0S1USEIys9nJZ5FgGQ4BsQHvF9XStcayWaJVirdJs9L37hkRO02hrsgWZXshNgFk7hr1pNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P6XjRZLNONLEzY1bqnnHZKeMssJEoMSnszuPIFrT8g=;
 b=Rc4yIbPaykMsC05W/NxvbyaWWfUIYAO6xmyBxEpryX1K7TVm+zyDvzkaV5UMs1nvLaKrbwbEa6EkGLMDMPmvjObnvIqp6xH+ApKYHdZ4/jkN6LhoqD3R8CvrM+4MfrLZhMcrXAcn9Fl+tfYipd4FVOprPmjVEw9po5XGrSR6PEufuju4vH23lsyONgha3nYYksggldvSwep8CzSk3hFQ8vztk/sHOJ4YoJrOfTqecvJfdH2G3mFDNzuR+GCE3kK6nEDQqpsLuLmvzyFIrVbWQS1PtO8QtGS4zqOuW5UXx5m6D5jS9q0RM9q9+26mhql08tqYF2A5qgxRK6oSneDUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P6XjRZLNONLEzY1bqnnHZKeMssJEoMSnszuPIFrT8g=;
 b=dAbPXAgYpcUSmZ7Cypk2q21pFg69XbjUMVUe1cOloMJBEf3k7XWsL5VG/nCsfy8GW7OlsKHbpdorXUU7eQbV9iMD1qNedWdRw8BzQ3vhue0AhgTH4Tr3SvuUVgQyB7Uf+TN54tcuDlupTshY7Qt73+DlE/dUg7NV4FV4smCS+Xc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 02:39:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 02:39:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: apply dummy reads workaround for CDR enabled
 only
Thread-Topic: [PATCH] drm/amd/pm: apply dummy reads workaround for CDR enabled
 only
Thread-Index: AQHWjWSH4VeDXbNUo0y1lNgz6PqyHKltruZ2
Date: Fri, 18 Sep 2020 02:39:06 +0000
Message-ID: <MN2PR12MB4488A8B6A3D313256DA67C01F73F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200918023613.456-1-evan.quan@amd.com>
In-Reply-To: <20200918023613.456-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-18T02:39:06.111Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c44b32d1-a82a-4656-e686-08d85b7c03ba
x-ms-traffictypediagnostic: MN2PR12MB3920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3920DFBDD1EAEBD3800BD4D8F73F0@MN2PR12MB3920.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYQhYudYCpAgezAoo6FW9pAsRno0AoPIT/oUwizitomJpaYPZGf2roTu60bHCyz6NRPAKUZDdhFl69rYMst84qUyPqvD4pps/7jzgxSyPeAv1Kk9hgF1bkzR3HmaEy+u/BiNMRX7bQccPATCJ/DB0km7FUpb7WCzsNFbtdXJIRr5MAM+1Y3RSG9P3KyQ/8tCrV4v//4AKBwR+tlZWe+JuhDIU1F6nFWK3i8ngtvZvPvKSczx3zGfuViiVHNSSEWdDRiuOc/sXxMHQ2uJI5l83BVnk47+gz/BNiD9iMwLs/HiOXFeTPWUfMV7JVdK8WRK7QhgKUX7ZUzqyr0asq/4Cg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(316002)(66946007)(86362001)(7696005)(5660300002)(55016002)(19627405001)(52536014)(110136005)(53546011)(76116006)(71200400001)(8676002)(66476007)(66556008)(66446008)(64756008)(8936002)(478600001)(83380400001)(26005)(186003)(2906002)(33656002)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kPwKQFxfeDnIFW/PliDGL8qh78fnQ94aRV+LFUwJqPEnIfu9dKjYN8iK535i6yIeK/fMxPXDU4zOvOl9rRlUctvidXDFp0Ri78F/fnO1Sz9BqY2eKY8e8XWr4oFjPeY5AOglTOVMclym9ldVxNOzDAKTuuTUJDJwx0RGE4Zq/miSWSvyRk+zfGUUi1Njvs7iUCWf+nDRQeokmWzPU/c8jCxgqHl1a1uJ6xaHM8bHf9YA9OZ6b6Dkextnejm45RklInrP3xVR5c1/ftGTgO0QzQUf0ZNSKSHV+2F8C62iX25dp8mkaWSazqurEnvps9Y6CTzh+iUaLky2qQ2zeV3uDcVSp7Ol2R5S8AFXctmFSU8px1F8sd+efhakVG7TwIQLNLLfkX7CgAVv42ykPUcAmSG5z5BePlVJXfJx4AqQQKEIAO1aLm/ojJPzwzPGSP4wh0VLN2IcyyuOtgOVuKkgu9Cuc9E+IbR/oIK/L3NIo1A6+d/gMTrl6WkcZzskkaSpJDQJ/4qoCafp83abDczMTADl1TpkpMt0T15XIY5JzYIwzSD03X7Uw7yer77jTxYNQkEDpj52XsVr5MCaLT/nVL0oLj1IJ9PjXzNulKSqboPCUuFI3ybjdGFQgcEZN8kG7geJY/mOVMbJoSgz5CvmhQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44b32d1-a82a-4656-e686-08d85b7c03ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:39:06.8452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AonuUXN7RAYgnWvAmT1e2JzfwlpOHYBy758clSdsodWjoA97HMJkHAU0bORdIloFQ5P3juZzlKSrpCyUoqIKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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
Content-Type: multipart/mixed; boundary="===============1008414798=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1008414798==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A8B6A3D313256DA67C01F73F0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A8B6A3D313256DA67C01F73F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, September 17, 2020 10:36 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: apply dummy reads workaround for CDR enabled o=
nly

For CDR disabled case, the dummy reads workaround is not needed.

Change-Id: I474619b3d82792151870811c289ab311028de211
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 338a9fdeef6e..5b87690c1e61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2303,10 +2303,12 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)
                 if (umc_fw_greater_than_v136)
                         return 0;

-               if (umc_fw_disable_cdr && adev->asic_type =3D=3D CHIP_NAVI1=
0)
-                       return navi10_umc_hybrid_cdr_workaround(smu);
-               else
+               if (umc_fw_disable_cdr) {
+                       if (adev->asic_type =3D=3D CHIP_NAVI10)
+                               return navi10_umc_hybrid_cdr_workaround(smu=
);
+               } else {
                         return navi10_set_dummy_pstates_table_location(smu=
);
+               }
         } else {
                 if (adev->asic_type =3D=3D CHIP_NAVI10)
                         return navi10_umc_hybrid_cdr_workaround(smu);
--
2.28.0


--_000_MN2PR12MB4488A8B6A3D313256DA67C01F73F0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 17, 2020 10:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: apply dummy reads workaround for CDR en=
abled only</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For CDR disabled case, the dummy reads workaround =
is not needed.<br>
<br>
Change-Id: I474619b3d82792151870811c289ab311028de211<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 +++++---<br>
&nbsp;1 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 338a9fdeef6e..5b87690c1e61 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -2303,10 +2303,12 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (umc_fw_greater_than_v136)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (umc_fw_disable_cdr &amp;&amp; adev-&gt;asic_type =3D=3D CHIP=
_NAVI10)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return navi10_um=
c_hybrid_cdr_workaround(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (umc_fw_disable_cdr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asi=
c_type =3D=3D CHIP_NAVI10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return navi10_umc_hybrid_cdr_workaround(smu=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n navi10_set_dummy_pstates_table_location(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n navi10_umc_hybrid_cdr_workaround(smu);<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488A8B6A3D313256DA67C01F73F0MN2PR12MB4488namp_--

--===============1008414798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1008414798==--
