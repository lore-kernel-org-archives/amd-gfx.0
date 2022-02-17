Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122CE10E87B;
	Thu, 17 Feb 2022 14:24:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 467A910E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDNFkuMv6sChN3hGn3pGI/63rGr3vRi5+F9ByoWkqe3xiV4FMe1CJK/sqRdGcFtuM9n6eN8nyeLRM7kSONwxW+lwVDJcMhsStFRy98tXNyDA2eXlK2iYUARrXGyZxRTYdKHtM8JuBpGstMKDWG65dqJlhMW02WYcMbX2ibnUzJs6T78EdhRsEa7K/Qd7we+X2crj1AmgximTqsH5gx5r2zOk9cpXSa+11Sig1SNOe87k3fxr8jtRVidZzeum5A6Ptbxb7O1Q/SQcuztiF3Jn79mnwNxFa2LQSy90X6RErbRVug6O7SYc+M7vqXhp3x3aZ1ZU79SK3HNU38fROj7qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkDN08pk52WIiSXgBhlMml3tx6VJocp/q+2lfctynr0=;
 b=IgFdLbcznLcNb1YKuvXsCpTeJG4V659T2GmNCAvqSOsyXDo3uRa+TwrNVyogjOLqeMmwO88CpVa5MoGl6cexf8s+/LFecysjA54BLi4mINrIsVH+mj2pUHUp5lsxG7hEZ38KkcluJZgx91qL9PajfHYt6avOheyaYl2kY3g5H+UE5nbiA/Km3BQrgztiTsHy4wqKze4hrmqOqeRVTCLDTKzFXNUIzi4lVo9GAiNNGzDKIGn6X6wNwRDJ9kaxQpF8LMH+M+geokMY/n64z3zu0rXOHG08XleYV2L3hDHmbVjdShI/WrLoW6r+QUBl28CyIRRWa1Rup/fSbkJdF62y0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkDN08pk52WIiSXgBhlMml3tx6VJocp/q+2lfctynr0=;
 b=DB7aOTIXMpBXQEy1raRN1eSO4VMamusbzQ5/hdrmOK2RAwjFCJ/cmexFZe8Q9VA3mM3xc0dgWXxoYhlF+3HMY2ydlgk5n5Q0hbHrs3otzhyCNmqxTTpoj63Nusj3X6qgBmF/8b4XIToVIbO8u68aaxI1ZHOQOoGtmGcwIU18kM8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4836.namprd12.prod.outlook.com (2603:10b6:a03:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 14:24:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%5]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 14:24:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: do not enable asic reset for raven2
Thread-Topic: [PATCH] drm/amdgpu: do not enable asic reset for raven2
Thread-Index: AQHYI93FM3vgYQrqy0K+2q+VzMjAI6yXzC8j
Date: Thu, 17 Feb 2022 14:24:06 +0000
Message-ID: <BL1PR12MB51445A299696F1C4EB9EBE18F7369@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220217090702.1573034-1-curry.gong@amd.com>
In-Reply-To: <20220217090702.1573034-1-curry.gong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T14:24:05.548Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 37cdf5cc-2dde-a41d-2dc4-301b9aaed835
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3a4bcd-cefd-4407-162c-08d9f22127a3
x-ms-traffictypediagnostic: BY5PR12MB4836:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4836A1767174307CAE62E554F7369@BY5PR12MB4836.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RrhSCI/7BjqOeQ40BTZvSHHfh8IDCB4ynixu/Vo+YzNRhi3k7bZxI6j1bbyck0t9rSvRTlCSlio54aec550hhsL4VAIR2d1B5M6kgjVSW7+v3MnhB1N5WV5X96YRI+yd8gOFQY9MRjzq2X1A81IRvygM0cHMkKwIvRBqtgljpniVNTn6i9s8Wfm1+kKsNlP7fcOQE0Igg7pnOcvExXNS0h+rM9raEwtOU6qzmTFsmrMi6VTCuSLDuhyytpB+xr2IIeTWkZfAKJWB5A9RRck8m2slUxKjZ7HiRDP5EXMyTHnIyqMfdsyRMHZvh6Sl/TMuHBqh7a8fQyy8VftGqKPQ2p/RIo+rYE8T6CCic4H6YsSojCfq8ptrC9Hjf14uQEIY/8Gr1ebqlmkqydXv88m7ZMVQkjfw0CbO49KU62uKAG4p9u56mN01cJ46MFC/MwL54RDbUHFk1luCRmwZn6YKg0a3WsorCD6gEjW2NlPRQmSfUyEnk1HSF+QyOZx069+AQQb6kOv+S0phrm6T4SmwjLaHHCvjQ3KP9GQdMzKyuI93Q57k/MMsg2yb6p4bl2gsOuqSWeEhy9VEmNzjDH0DnfHxWBHRQ5R+51ljy49gAb4mCzDHABiJDREa2AOnClR1qvzBU51Y3kjVDS7KX+fWFaKZgGiS/rLkh/HNJMGalvcCgjp3C/8iytHtm7b86gisuIeswz3AWV1dxI2SvL9QA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(19627405001)(122000001)(64756008)(38100700002)(8676002)(76116006)(66946007)(110136005)(66556008)(66476007)(66446008)(316002)(55016003)(5660300002)(86362001)(33656002)(2906002)(52536014)(8936002)(83380400001)(6506007)(7696005)(71200400001)(508600001)(53546011)(26005)(186003)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E7vY6WX2rH2KAv+Mki9QpboZJg+zZBxz3s8umR5EiXDKuwC0Tv9/0aquale4?=
 =?us-ascii?Q?oNkdaAHzDiykJ7WLFwvk2F1qzZTwqs5++24rVqri6lEEJ1GRAO+3MXiKpKgu?=
 =?us-ascii?Q?nRbg0oheGY6NNnF0Xd69GnrfRlwItdHjJbIZHY7eepL2WMGBY+Jh33ns9qiV?=
 =?us-ascii?Q?0KX/mOFsUw7JZ8GgR9NtE7YOomaDG5uJH0a4pGCizsmdeDzGVFCsd2Bj9dCr?=
 =?us-ascii?Q?/C44HdX/ccvgo0Q8GdnbbxJhZr31fI90iSO7Pe0JpzlGvIQFKy5jzX17h4nw?=
 =?us-ascii?Q?xDWkwcVBuEiQU+47axQBHqzIidyilzxAquv4SfRylnvc3jbFMblcX9C2nWUV?=
 =?us-ascii?Q?XbR+rP6AtVxLu30HpRvFwK4XdRqnWL8VDSTksBGN+u1L93FcLDqpRn+2sldr?=
 =?us-ascii?Q?2GOXVwp9a5z5tchoeNuoX1s4IkMvfJJqnk2IbsydnnZ7MyHtxLt/Q7WmfkpV?=
 =?us-ascii?Q?8YdgRvpKdFnpFOc5ZPzX3/jYtIefwgMlmhVYrun/zN0EOP5idyDmHY+G8R2V?=
 =?us-ascii?Q?67Uz0ieljhaaMCtj0IooOppM/ImxFxtRPfY6vwuLHOzTcSziNNqqDSIYkxD3?=
 =?us-ascii?Q?efTZuXdBfWa1jfe22KT7RlqUqbyh2GE0sFOoruFMrnuG55m0NRxVKIfltLsi?=
 =?us-ascii?Q?8FJCdxHfJeSYW1YriiBxkttU//EOBBJjbJ73TA/iy3KQTmT+xCQUt0lumcdj?=
 =?us-ascii?Q?nlY+GbzVMAB/4ebSZS0gaKZ+0wgHiGLzdtg+0PFG4fwjV+exlZm0kVVTaQdz?=
 =?us-ascii?Q?B+iiGoy2MDwGqCuiAIVpJgKjkrLbEOAwMYvL21mNppBjzCneESsheRsnmT9+?=
 =?us-ascii?Q?UF4cL8vg/Si7TLDhRi8OcWo/8npAuX0ZdaWytcd0gKojKQv9EubGsOPxi09h?=
 =?us-ascii?Q?PDR+g9Y5vO7hu/UfFA57cITgZs2mAlXlQaLZom6h0OAGxgkmebwC0vrakbav?=
 =?us-ascii?Q?4XNVRC7cj5YfdRvfxNRXSxTLdsmG3n+Gxa5ZwSel7BSlvfYQ5ojg0kccGuQ2?=
 =?us-ascii?Q?lIZByAb+ZnR9tgOLmERmIYLikU/tBrcrIRC2zeMRAEb1CmmN+qX+7qNw8HII?=
 =?us-ascii?Q?7kVRgM50UVGeOYAmK8Zg3+AAZ4WTgjQDNTB8yOqIfpKE7T+cb6y/oTte23im?=
 =?us-ascii?Q?zuGwkqHZ1xSNxle52bCF5DyHPGJ5TL+hGZ0IIx5rT7TAWeLoEofdPZyQU9N3?=
 =?us-ascii?Q?zGoG/RwE6/sWkJVE3BjmKsaNquOjWPW71dF8nrAZi6YFcXhXuz9KdTPpgFtu?=
 =?us-ascii?Q?hJaTWdlA1cl+gmuOcq3VHFtJhU4/oJ8XRtaBdNa5yqduD6UpAR8lvE3EGKB3?=
 =?us-ascii?Q?oZf5wltoDuFjFSvCJAbyd8jKYj9P08SDgB8yZs0yQFYTgqiPEbeeUZCqb0+g?=
 =?us-ascii?Q?jAxQRU55A/44+/PQ9yhT6LQHt2zKEbU+e5dG6rn7rHDgmcPqETDOME/PXp1N?=
 =?us-ascii?Q?yy8djIWApXPR8+VyTJMse8w7uy3bBoSbFiaNNsV7RzUZK2x79KCmQHFXDOMf?=
 =?us-ascii?Q?kdkk+Y0O2EB8/RnZ0E1TU8LdC1UmJ21Wf7YWjoBN3dM1fpO4ADyC2RHU+nWK?=
 =?us-ascii?Q?t+zJ0aJxibgsj82qKGdHwoQNe6KkV7haQSZL63MmaE7TIhRsF6vSEdEroTGD?=
 =?us-ascii?Q?yOzvdZjbDN3HW/Pjeu6I22Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445A299696F1C4EB9EBE18F7369BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3a4bcd-cefd-4407-162c-08d9f22127a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:24:06.0915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qc8P5wkqisXEPJmmXr7VRhDt3JL7dZki2M0Z1zmjudziKc8xrCp/nIpgsHhoQSh9WrWnKHte4CHHhNCHchC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4836
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

--_000_BL1PR12MB51445A299696F1C4EB9EBE18F7369BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Gong, Curry <Curry.Gong@amd.com>
Sent: Thursday, February 17, 2022 4:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gong, Curry <Curry.Gong=
@amd.com>
Subject: [PATCH] drm/amdgpu: do not enable asic reset for raven2

The GPU reset function of raven2 is not maintained or tested, so it should =
be
very unstable.

Now the amdgpu_asic_reset function is added to amdgpu_pmops_suspend, which
causes the S3 test of raven2 to fail, so the asic_reset of raven2 is ignore=
d
here.

Signed-off-by: Chen Gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 25e1ee2bd2f7..4c6775ff7619 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -586,8 +586,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
         /* original raven doesn't have full asic reset */
-       if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
-           !(adev->apu_flags & AMD_APU_IS_RAVEN2))
+       if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+           (adev->apu_flags & AMD_APU_IS_RAVEN2))
                 return 0;

         switch (soc15_asic_reset_method(adev)) {
--
2.25.1


--_000_BL1PR12MB51445A299696F1C4EB9EBE18F7369BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gong, Curry &lt;Curry=
.Gong@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 17, 2022 4:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Gong, Curr=
y &lt;Curry.Gong@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: do not enable asic reset for raven2</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The GPU reset function of raven2 is not maintained=
 or tested, so it should be<br>
very unstable.<br>
<br>
Now the amdgpu_asic_reset function is added to amdgpu_pmops_suspend, which<=
br>
causes the S3 test of raven2 to fail, so the asic_reset of raven2 is ignore=
d<br>
here.<br>
<br>
Signed-off-by: Chen Gong &lt;curry.gong@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 25e1ee2bd2f7..4c6775ff7619 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -586,8 +586,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* original raven doesn't =
have full asic reset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;apu_flags &amp; AMD_APU=
_IS_RAVEN) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;ap=
u_flags &amp; AMD_APU_IS_RAVEN2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;apu_flags &amp; AMD_APU=
_IS_RAVEN) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;apu=
_flags &amp; AMD_APU_IS_RAVEN2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (soc15_asic_reset_m=
ethod(adev)) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445A299696F1C4EB9EBE18F7369BL1PR12MB5144namp_--
