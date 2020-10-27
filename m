Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF448C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 06:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEF92080A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 06:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BLDvci+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEF92080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A6E6EB0D;
	Tue, 27 Oct 2020 06:36:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674346EB0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 06:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzLRuaho9eDkCobmt8tiWauKoBpJot/kvz+YMyqFpkgvlVk+B/CGfaRUUlSCwqM0daxholL8prQz68AnMfeRk5chYjUAwmRzvvST5onODHX4gw/nNQyty3L0RLH4vTk1jd3NKLdXeXfuOgI4G5coEU/itEFJ06iPxbKFOiue1ieltL5j5+4HAsRGeh48bodHZaDKTL5frbHJ7jbJ0FjWm8rpY3zoy/DivaX3FgyuEgJkOQlS3sucYG0KAQqMz5pQ/18LD0RExd2DTR9aVglWDZTv1w/ZQd2OeQqgzT7XoAFQ4AHVJecIgfZF9ip7BRr9cAZPaPcmlYFgSjE2FAQ5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu6O6tk4Oqf6po7RRDAOhIwEgvcSu9P8sQjEbvojj2s=;
 b=dqvv4YKVZ6q99btwWhNJZOJlPv4ltxtQu/cYXdm0KqeQsBFtF02FqIJXjd6uoMVzGp7p6/ieIy0pWkLzTRhBrAXqcJOWSOqNIBUepMfKO0zCtGDBADKpS/ryfcdaGk5FnxLyLPx35K1nHgDPhIDpTDXVWAimVI5jM8S+hd/bcMsdyfcfLiRi/UVfcMHQZssuQIFxTP9dawHgn2cmAQ0n/ZNVhQpfV6w8WvmciIcIHXOmL4D6Pt9Lg75zdzhxFOlF09oPho3b6B2uFzImMhsK/L4tCnPGebnSF0FAodHq5+ZWkSRf1IkvujbiJMOKPNRe8+tS/Gt8sqDEolNJH50Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu6O6tk4Oqf6po7RRDAOhIwEgvcSu9P8sQjEbvojj2s=;
 b=BLDvci+5F+JL2c+z54KYs6RzE9MqjNGLAxaAdtlmFOwVM+2puy8sitcj2zpspC4T0Z0epkYwFGU6pKdeBEy+JfnY7syMqDijLy9Ege/70FIZfFyRnfXTZfIXPL8hoiCcgFcBcGUMTahykGiIsbe+BqzfJho+CSrUFKsmntoStxU=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by BYAPR12MB3175.namprd12.prod.outlook.com (2603:10b6:a03:13a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 06:36:08 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::3013:68d7:e3f5:c204%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 06:36:08 +0000
From: "Li, Xin (Justin)" <Xin2.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li, Xin
 (Justin)" <Xin2.Li@amd.com>, "Zhou, Tiecheng" <Tiecheng.Zhou@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Thread-Topic: [PATCH] drm/amd/amdgpu: Add checksun check for pf2vf message
Thread-Index: AQHWrCsueVY0ZPCZo0OSKyuyQ2YrDQ==
Date: Tue, 27 Oct 2020 06:36:08 +0000
Message-ID: <BYAPR12MB4759F149D775C3389A59001EBB160@BYAPR12MB4759.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T06:34:12.2999462Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fedd84ed-3f39-4786-e82f-08d87a429688
x-ms-traffictypediagnostic: BYAPR12MB3175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB317531FBAE846E02E14A7994BB160@BYAPR12MB3175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zn6X5H3yMQ2tqdlJLt6Bk6F0zdSXOb0vmKT0+a4s+ipAeMhammcd0ClmZ6wPNxZThGKF6gUrq814B2ff7ZyJAfIwUYfjFNO4lbxmRZqs0ZraAixsSbguWW68YlED3LyJPDQD4OYnvTLetI0MRuU2bl5cAKnjBSoA8u1eIAh94gd/qdPKZUaNn3/2reW7Q8FDLCvCKy4gd8GokWUZ7x2ye7y49t5bxEC31oPWE25CJGWF3Ose6NA5yOAw52NBLSecO3D59T+i9MYwCfJEMzHmhCnU2nfbs6+KJI4yaSSHHt0W/xkgk0QWyJNJgU1jNUo4LfStprvnwhzjr9VGierNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(186003)(71200400001)(478600001)(8936002)(9686003)(6506007)(52536014)(64756008)(66446008)(66946007)(66476007)(76116006)(66556008)(26005)(110136005)(91956017)(33656002)(7696005)(316002)(5660300002)(15650500001)(6636002)(83380400001)(2906002)(86362001)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DM8i+8pj5+IQvGrKAABpz/mS2v97yrm27GHNtI3O7N+lKM0nUvZiCBpo60EGxdpRCrWDsEwn1933bWArc8VhnOHVCtQozyeVLG9BTQGUTsd1VqLNbh3pdTQ0UuE3sWBik/oVgXhRDFbfqJdy2tb+kuupCVZyNbKt6IdiLEhaIq29frgcDOkkEIfTe69yparhwk9m4Z6VWhMJPjZ7GOxyrJEC+SiYWVjf5eRtRN+aaObRcd0LhPx5kO338Q9qYdEskFUOyGKYYIXj9ukg50VcsedeLzqMqNEx4hwOJivx2R51qB+mpTZa0yJNWzCPjW2ePvLwMepya+R957wrsvHJV61H3goORlqiqNatuUZb3SAd2GDboVO6PJh1r22uS7VMz74/KyhWGO8VEF2crF0agCl6tGB9bdijXACuGR6B2CGBPcKKGlNtf/1W+2TUnHHjcapVeejaM0+YLPROXKSl0KDcZH9XP45jME8BmzciQyV5eSC1ZE6OhPVkHQ0BgZMjoznvEG49IBOECtmxZCBk2m1xV9m5DgjjS2UXDqgGXchuoQM/uitvldVxcul92PpxqbrLa+YK6Y9N+MbWLcDigSvgE0rJ4qoH7jzhhj1fLY0JmaVxbB9Hlt3wId3BShFas2g8sKEjrw2uFrKgN5/hEA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedd84ed-3f39-4786-e82f-08d87a429688
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 06:36:08.3800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwCFL0nvvd61w+HVuoqq0pgpvTKLl111yAF/65DswekVicN8rFdergktNsx6l81N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
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
Content-Type: multipart/mixed; boundary="===============0751035045=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0751035045==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB4759F149D775C3389A59001EBB160BYAPR12MB4759namp_"

--_000_BYAPR12MB4759F149D775C3389A59001EBB160BYAPR12MB4759namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Add checksum checking for pf2vf message

Signed-off-by: Li, Xin (Justin) <Xin2.Li@amd.com<mailto:Xin2.Li@amd.com>>
Signed-off-by: Zhou, Tiecheng <Tiecheng.Zhou@amd.com<mailto:Tiecheng.Zhou@a=
md.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 836d784456e5..bfc74533b5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -450,12 +450,11 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
                         ((struct amdgim_pf2vf_info_v1 *)pf2vf_info)->featu=
re_flags;
                 break;
         case 2:
-               /* TODO: missing key, need to add it later */
                 checksum =3D ((struct amd_sriov_msg_pf2vf_info *)pf2vf_inf=
o)->checksum;
                 checkval =3D amd_sriov_msg_checksum(
                         adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
-                       0, checksum);
-               if (checksum !=3D checkval) {
+                       adev->virt.fw_reserve.checksum_key, checksum);
+               if (checksum !=3D 0 && checksum !=3D checkval) {
                         DRM_ERROR("invalid pf2vf message\n");
                         return -EINVAL;
                 }
--
2.24.3 (Apple Git-128)


--_000_BYAPR12MB4759F149D775C3389A59001EBB160BYAPR12MB4759namp_
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:-webkit-standard;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;-webkit-standard&qu=
ot;,serif;color:black">Add checksum checking for pf2vf message<br>
<br>
Signed-off-by: Li, Xin (Justin) &lt;</span><a href=3D"mailto:Xin2.Li@amd.co=
m"><span style=3D"font-family:&quot;-webkit-standard&quot;,serif;color:#000=
064">Xin2.Li@amd.com</span></a><span style=3D"font-family:&quot;-webkit-sta=
ndard&quot;,serif;color:black">&gt;<br>
Signed-off-by: Zhou, Tiecheng &lt;</span><a href=3D"mailto:Tiecheng.Zhou@am=
d.com"><span style=3D"font-family:&quot;-webkit-standard&quot;,serif;color:=
#000064">Tiecheng.Zhou@amd.com</span></a><span style=3D"font-family:&quot;-=
webkit-standard&quot;,serif;color:black">&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 ++---<br>
&nbsp;1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 836d784456e5..bfc74533b5ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -450,12 +450,11 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((str=
uct amdgim_pf2vf_info_v1 *)pf2vf_info)-&gt;feature_flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* TODO: missing key, need to add it later */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; checksum =3D ((struct amd_sriov_msg_pf2vf_info *)pf2v=
f_info)-&gt;checksum;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; checkval =3D amd_sriov_msg_checksum(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;virt.fw_reserve.p_pf2vf, pf2vf_info-&gt;size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, checksum);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (checksum !=3D checkval) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.fw=
_reserve.checksum_key, checksum);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (checksum !=3D 0 &amp;&amp; checksum !=3D checkval) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;invalid pf2vf message\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
--<span class=3D"apple-converted-space">&nbsp;</span><br>
2.24.3 (Apple Git-128)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB4759F149D775C3389A59001EBB160BYAPR12MB4759namp_--

--===============0751035045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0751035045==--
