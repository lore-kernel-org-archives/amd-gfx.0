Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FBDC64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 14:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4B320757
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 14:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1VhRJaiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4B320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5E76E519;
	Tue,  1 Dec 2020 14:42:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2749A6E519
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 14:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5nvqui8GMrfj59eUVK/24ixS+i3dpEoaylaV9H1aHEnahnFsYCQUWSR3/tDe/RMNIornJyngzClnu94DM0JdzJ3WvhDqLtuk7DHmKPhBVi1aDZIWvp02SADDLVATCdqYRdbB3o+O1KplegQXuZ3/G3U/pMC+RxhEtqkQucCBZ6YFN07uK8+mhwOCSfhuvO9FSDgpTN/jGG7tXRY3hqzPxq/OM0F7t/2dohLcviKCKEl5bK2nvrwHkdukcmm6yENI5QkHqqZZ9hzZYhJctCNxFeqJs00Cklm1OTYjLJxq36URw0RHjuQBJf6iT01g2LtfVOIm073Ri7gKlGtGZxJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJZR5gscbWMKVHV0mDVH6WmIACNWSSN9cvvWfGX6Ro=;
 b=mlioc+uUsJiYE6iVqR3SR71mGUKd2DQikfp6MSJUJOefFkBumWJ1oNB2h2i82Lkxyy55YImWMoU6AS5LOcIYe1TRNaQcbNagQmAEoSULnP9cbQ2dF1FULJmkDNVOIP/kLleg++1lqGMIPxkQRYqHYhZ6ieCbl0IXpi3UYLglfGFRqW2bwydkB3NxDtpzY66prjrVPnxyAysAf7SfQJj4Mue88b/gCcZw8Q4tGu+c9O+Ec0UtFZJTz68PM/GIbIiZO+O4NE9KIChyqIvnU1jodGSefzoYHKtmI2bRbPd80tLJ+aGznyPebFZpzXttC0VObKxNnZqv3uusAHFRCa+rJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhJZR5gscbWMKVHV0mDVH6WmIACNWSSN9cvvWfGX6Ro=;
 b=1VhRJaiuAt3dDNGrLfiTHEFsbloHPBFvPLu0ap3qhNdlM2k+AnPn0EZSd/jEmTVpPAMJi0YymUt2kAI9obaGvYkO0DvmidIL6Sq2jFpvhDsGejs9phXXzIwZqTnVrcfNhzpO9ZRYdoum+K7ozuqBdbUJNri/8RONXGBQPbqNmrU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4609.namprd12.prod.outlook.com (2603:10b6:208:8d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 1 Dec
 2020 14:42:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 14:42:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] tests/amdgpu: Fix a typo
Thread-Topic: [PATCH] tests/amdgpu: Fix a typo
Thread-Index: AQHWx2Xsb5rhNCqAl0mdXeYXqJNhfaniUR54
Date: Tue, 1 Dec 2020 14:42:04 +0000
Message-ID: <MN2PR12MB44887FBB23DE1AC09343331CF7F40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201130221227.84747-1-luben.tuikov@amd.com>
In-Reply-To: <20201130221227.84747-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-01T14:42:03.908Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce06bd74-0ad4-44bb-3ca0-08d896074590
x-ms-traffictypediagnostic: BL0PR12MB4609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB46092DFA82BDB4668F9C6DB4F7F40@BL0PR12MB4609.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4C/uRpKeGXD+07n515hGxW0wBVterxv9jKKXziZxNVPyTl//CH1p29kcrpPa8GkOoeQ8ZbefZsvkZHfO7/taEUhS5Xsx6rlsAxMKyfCRScsVVrquH9isQcXlFTwxrNAnMGK99rjgVuwsDYugAYp4iXGRqCF44JZu6PhH2Zy1lmw053bs61kq8RSwrDRIpjm74bBEF7rwRdQ8RpfeBkSVELdykV6//73x9/u2w7QBGi4mqT511iKJaO4LQd1okPWglzFqmUSVphYb35BCxIDzzwB2lDp/y+5H//DoYQoy3okZx+5Qh7SQrW3m5RBvvCMFW2S4vXQZ4KGoTIGhRF96fC4bJ6/cIYVAgiM/yD11OE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(52536014)(76116006)(64756008)(66446008)(66946007)(66556008)(66476007)(8936002)(2906002)(9686003)(5660300002)(8676002)(55016002)(71200400001)(26005)(33656002)(478600001)(19627405001)(186003)(166002)(6506007)(53546011)(83380400001)(966005)(7696005)(110136005)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EPvga2Bi3R1wNU6N1NPlZGzJZ7h5T9PrhVD3O1b1yeUfB94yAN7QSxY5OUPT?=
 =?us-ascii?Q?H8brTWLVgjNfs3uoUliaUa7ggkHh2FynDUY/UX5gxx3cfIaaEi/PmFOH1MRT?=
 =?us-ascii?Q?DZh3mxOETTpfD6FYwW8aY47y+erU9PyBuOIi/3GW7XAjojrUP8XEjSG+wODj?=
 =?us-ascii?Q?SKHkp90tkLTpIkfFU4OpTVTL1yqPiWyxxk0enPwdjMypEqSGZ0KXTCU8ZizJ?=
 =?us-ascii?Q?1UsjDT2aIw1ygUyzNxrcmEF7L32fh8sYAp3iJVH/vf2G839l+X4sZfKFxTJV?=
 =?us-ascii?Q?dEuBj0tBddvTwXZwpfeqeh6XFW8fwQv5bPuRdb0yJUV0tcKWvLiS1KVX1qwp?=
 =?us-ascii?Q?wrj1u37tM2hg7LXXe1xO1kAdVtZsNaAXfA32IVc4YUA1cWjBT7mshvIoLisq?=
 =?us-ascii?Q?lsFa3AV3/0GXIuEH+KgsRcyQkHvefhTAL2ODJMy31R1e6eiAAWyKPVftXyUA?=
 =?us-ascii?Q?c+xFhQvKyaGw7dh5zOyX2dX3+MPsNx+Oqn19lFSieeU/PyyIBdT2HqEjrsOa?=
 =?us-ascii?Q?8yMSTEfOGfIB1NVMhxDQMOG1J7tHlv/Rd8+Ee/vH/34ypI3AlG5e248cZeQE?=
 =?us-ascii?Q?0tGV1LN0JrLKGjiqt1xN+MgWo6GUZL+rcKqWOrwm1tHeW5ipOUHPcstmeKSr?=
 =?us-ascii?Q?6ldN16Jvjx1Ww+hMUaqaPjtritKrdx3grJQ1UzTVrGag0kRXytUFfotAiyIy?=
 =?us-ascii?Q?oavPNIteV+FS6DO2v1CGMlHz2YZ2CBzCWQ6gYspEeezDXfk6SxiwXPyJ+ihA?=
 =?us-ascii?Q?ABFcLkL5ezO9x+8JpzUJspguiEmsMQZS8cwfb7IU32JZ5tkSq/XJcmkZCnsy?=
 =?us-ascii?Q?bp4VyQh4o6L4B6SRhUNw/R/eEoSbGoSXDIQpEpXDtacWLV/ijtUraNJLpUXq?=
 =?us-ascii?Q?Z5ByR36kEuCLvkH6ji14gBHonocg4Zw0cAaIPIKcKR35wT/emcOQz4L1ov9L?=
 =?us-ascii?Q?m0XDOx1HBXuTUXyIOB8ixuVKEw2MGOQ5iwkujlZiK5k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce06bd74-0ad4-44bb-3ca0-08d896074590
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 14:42:04.6922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCst48H6BhFtKD9sfnJ1Sv6YVz50mJhsPmHPy+9Y6Ixh6ZabM6YSmeD9nskaDrmnWWXNqbeTWZ8NjKIypFir7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4609
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
Content-Type: multipart/mixed; boundary="===============0224041034=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0224041034==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887FBB23DE1AC09343331CF7F40MN2PR12MB4488namp_"

--_000_MN2PR12MB44887FBB23DE1AC09343331CF7F40MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

libdrm uses gitlab MRs now:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests

Alex

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Monday, November 30, 2020 5:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.Tu=
ikov@amd.com>
Subject: [PATCH] tests/amdgpu: Fix a typo

Fix a typo: "TZM" --> "TMZ"

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 tests/amdgpu/security_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/amdgpu/security_tests.c b/tests/amdgpu/security_tests.c
index 9b39e167..351eac82 100644
--- a/tests/amdgpu/security_tests.c
+++ b/tests/amdgpu/security_tests.c
@@ -172,7 +172,7 @@ static void amdgpu_sdma_nop(uint32_t *packet, uint32_t =
nop_count)
 }

 /**
- * amdgpu_bo_lcopy -- linear copy with TZM set, using sDMA
+ * amdgpu_bo_lcopy -- linear copy with TMZ set, using sDMA
  * @dev: AMDGPU device to which both buffer objects belong to
  * @dst: destination buffer object
  * @src: source buffer object
--
2.29.2.404.ge67fbf927d


--_000_MN2PR12MB44887FBB23DE1AC09343331CF7F40MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
libdrm uses gitlab MRs now:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/merge_requests" id=3D"=
LPlnk863672">https://gitlab.freedesktop.org/mesa/drm/-/merge_requests</a></=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Monday, November 30, 2020 5:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Tuikov, Lu=
ben &lt;Luben.Tuikov@amd.com&gt;<br>
<b>Subject:</b> [PATCH] tests/amdgpu: Fix a typo</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix a typo: &quot;TZM&quot; --&gt; &quot;TMZ&quot;=
<br>
<br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;tests/amdgpu/security_tests.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/security_tests.c b/tests/amdgpu/security_tests.c<=
br>
index 9b39e167..351eac82 100644<br>
--- a/tests/amdgpu/security_tests.c<br>
+++ b/tests/amdgpu/security_tests.c<br>
@@ -172,7 +172,7 @@ static void amdgpu_sdma_nop(uint32_t *packet, uint32_t =
nop_count)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_bo_lcopy -- linear copy with TZM set, using sDMA<br>
+ * amdgpu_bo_lcopy -- linear copy with TMZ set, using sDMA<br>
&nbsp; * @dev: AMDGPU device to which both buffer objects belong to<br>
&nbsp; * @dst: destination buffer object<br>
&nbsp; * @src: source buffer object<br>
-- <br>
2.29.2.404.ge67fbf927d<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887FBB23DE1AC09343331CF7F40MN2PR12MB4488namp_--

--===============0224041034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0224041034==--
