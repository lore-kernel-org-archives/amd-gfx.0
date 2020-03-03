Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EBC3F2D2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 03:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680AA21739
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 03:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E29SyMtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680AA21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4436E968;
	Tue,  3 Mar 2020 03:05:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360FA6E968
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 03:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrC5HRT9pQDH1CJtxwluRLYiDnMPHnE/WiXEbHg5Zb1QMnODklWuZkDPhC/mOCeDPyE2PsSi9y5to5gmRiRsbM6SjIn5mnCiNoiZigfgYTPqNAyChiTZN4dHrm7ozqMetNZjOi8TW/dbPysVj1rEM+RyIrmEUCQC1FSs5p4THWTj65ODncPsBzA4nbSlVuicHxeXiM9nbGVT+R/PsrzJE6s70LLcs83q8D9ycVetI1k1ENVnipiYdtQmtpk3uFkpCvoSted2Z2PTWyjv0QeT1bvarNnqVdhrpq723fzPTcwXAvoMBLPOyuwXvalDyZJbKjVFwgNGaMzUcIPGbv/Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BpiKWb1mjOHltw/Y54jM6bpNiwOnozv9NTdn7oriGo=;
 b=FnqTzX3fGO9wv4RCQe7P9XPlhWfwpTcyxG0cUNePNJGc1TeLwIVvZTXuTfCr6Mhb1ddzInLn28Nt5CkGwfw3qfbJ3iSUQG/YflL9jsjTLsX2UyvJhl2OU/u2MWqBvBZc2tvHcoLW1Thblb8LxtxXumQ+gNoiIgc0XuaQCHsUMdZBTBO7pofasgimyKy8TOR/W3XFxUWpp08kC/LVHgxlZcXIimPn41z2JSoAoALghHEPmnManC64kPgVYlS2xN0tN8rI0SKbEdLiNAae6+QYpEGfC8Py3Mjn+Dnc/3Zp88f8snDvtDwNq7KPzG3u0b864LISwj9/nmyEEKqGT9mcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BpiKWb1mjOHltw/Y54jM6bpNiwOnozv9NTdn7oriGo=;
 b=E29SyMtm4vi2UHxvvJVYVIOkJp24hntK4eu8ko7bnGapMBUr5P03vvHgayBWxQNOP6uSnYxkS7bWofDUH7U41cqDy1Kdx1EeEX3bZz8yDPfTprM86Cpgu4Es3SdpLt0SmqaatEBKSeCluat41QFsA8bF8dWxBgIJ31OY1noUDs8=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 03:05:08 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 03:05:08 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Topic: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Index: AQHV8FRyok5cRxATf0SYBiJ9i8QZh6g2MFGq
Date: Tue, 3 Mar 2020 03:05:08 +0000
Message-ID: <MN2PR12MB33763713725FCEDF5E4B82C19BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200302053529.5736-1-jacob.he@amd.com>
In-Reply-To: <20200302053529.5736-1-jacob.he@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T03:04:43.4736649Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9cff641-7dfc-4397-ae74-08d7bf1fae4f
x-ms-traffictypediagnostic: MN2PR12MB4549:
x-microsoft-antispam-prvs: <MN2PR12MB4549D5534A52F849BE7681B19BE40@MN2PR12MB4549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(26005)(9686003)(81166006)(81156014)(186003)(478600001)(52536014)(5660300002)(316002)(71200400001)(55016002)(8676002)(64756008)(2906002)(6916009)(66446008)(53546011)(76116006)(91956017)(66476007)(6506007)(8936002)(66946007)(66556008)(86362001)(15650500001)(7696005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4549;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvqPTd62fCZcr8wSH1DgM/XSaFOFiYDM5YQKg8PikqmsQORPGYWK+0L7FKsz0AmmAWmnR2EAFgvM/J879Dyz6UORA+WAy/BWJ2Haf0FpjI513IK3pLOaVNNbPFJl5YIe0n5oKbtNwFLAxnchqz3u7VPE6ZjmEyNiW+8mftNgf745jJ6A4WJnKCUyjPlvB0fmrJXDP1U+e/WXlXiS08zyN9tDAikhr5COu6Nvfw5UIzUYtF7d0PC3VKO6ZPUjA/4rO2q9J+2/KGQMc6kZDskL2kGuVL+53FN5fUjWhP9RKNq+MX5N5nyU+4Dy4LKk/2tgdJ2qLayerC3wRbEWgW5rwFiy++pMn4lYDE7zXkpVtqMX1c3Z5SY+qp5ZM7iLXgyjsP9Kct6Ods7bOKDgO+G+UD72fvLvgcnmi9cV27lOXVTL/AKAjEhOPoW2M8b+TrGJ
x-ms-exchange-antispam-messagedata: zZDLEsmu6DX+cINU1vW0X6lk7zHPekdt/CvNJ5mccgDIFBMKCYFUMg9g2ldprWAK3UsbwW4PfVCuwW0jwyH15+fbuxocJdTF8pRISMurbpMoAb9MCBsGzuTPe8QsLcKrcqLUh5kGwjYywLpvrs8pSA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cff641-7dfc-4397-ae74-08d7bf1fae4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 03:05:08.5173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nu6VOWfa/7Rq3ojvVbpsA12vdHzSV3HSlfLTU+txEjXIZcqhWZ8TEkmqrVQtx5l2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Content-Type: multipart/mixed; boundary="===============1527433101=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1527433101==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB33763713725FCEDF5E4B82C19BE40MN2PR12MB3376namp_"

--_000_MN2PR12MB33763713725FCEDF5E4B82C19BE40MN2PR12MB3376namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Could anyone help to review the patch?

Thanks
Jacob

________________________________
From: He, Jacob <Jacob.He@amd.com>
Sent: Monday, March 2, 2020 1:35:29 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: He, Jacob <Jacob.He@amd.com>
Subject: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when appli=
cation reserves the vmid

SPM access the video memory according to SPM_VMID. It should be updated
with the job's vmid right before the job is scheduled. SPM_VMID is a
global resource

Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
Signed-off-by: Jacob He <jacob.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index c00696f3017e..c761d3a0b6e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
         struct dma_fence *fence =3D NULL;
         bool pasid_mapping_needed =3D false;
         unsigned patch_offset =3D 0;
+       bool update_spm_vmid_needed =3D (job->vm && (job->vm->reserved_vmid=
[vmhub] !=3D NULL));
         int r;

+       if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+
         if (amdgpu_vmid_had_gpu_reset(adev, id)) {
                 gds_switch_needed =3D true;
                 vm_flush_needed =3D true;
--
2.17.1


--_000_MN2PR12MB33763713725FCEDF5E4B82C19BE40MN2PR12MB3376namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Could anyone help to review the patch?</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> He, Jacob &lt;Jacob.H=
e@amd.com&gt;<br>
<b>Sent:</b> Monday, March 2, 2020 1:35:29 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> He, Jacob &lt;Jacob.He@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid whe=
n application reserves the vmid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SPM access the video memory according to SPM_VMID.=
 It should be updated<br>
with the job's vmid right before the job is scheduled. SPM_VMID is a<br>
global resource<br>
<br>
Change-Id: Id3881908960398f87e7c95026a54ff83ff826700<br>
Signed-off-by: Jacob He &lt;jacob.he@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index c00696f3017e..c761d3a0b6e8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -1080,8 &#43;1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, st=
ruct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pasid_mapping_needed =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned patch_offset =3D =
0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid_needed =3D (=
job-&gt;vm &amp;&amp; (job-&gt;vm-&gt;reserved_vmid[vmhub] !=3D NULL));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (update_spm_vmid_needed &amp;&=
amp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, job-&gt;vmi=
d);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_had_gpu_re=
set(adev, id)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gds_switch_needed =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vm_flush_needed =3D true;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB33763713725FCEDF5E4B82C19BE40MN2PR12MB3376namp_--

--===============1527433101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1527433101==--
