Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E16C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 14:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E501221FC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 14:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E501221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6CD89907;
	Tue, 22 Dec 2020 14:38:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100F489907
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 14:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUyyR+MbLZ5o7tUd7L+nT5EyWLK1tQUqRo+ElEnC3+lRWH/IopgzFrH0F0ez9wn6JMYBB2gI/KcJKnE1SqP8vZ6xtIRZkD0Y4HSHBnm1dxVecWUfhEr+lQMcmtPSNEmu53WpVjN/aGxadfo0DQL59eW0AfgNzT5K8VgBGWQ+toCoZDK33CwxsdIEk5SfS49wXPatYn4+X46LORJVplr5bGv8Qp0d25iA3EE/CulUL63Dfi5Cegjh1Rod2o086JyXs5xXgSHDM5pbJbzuIOF4JLefTNkcANAVQxh7MJWFH3r/M6HKSuJ9SjiRTkS+P9549ywef3917LBcUoSReVs9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en8grVgmnsMdw03drZaUswLlZ5Z9ygj69Uhp6hmHaWU=;
 b=RWN43PYV2JvkCpsK4WixkOL3C+yCVUern0kQUI60ifR3JG7rtMQnx3A7HsuSZo4xIWksOOtqTkn4CJyUE9WSFlwnA8eN6iqzlzPg0F4j86BVi2mWJhQN3tH/tyH95WAWf6wry/RQ2yaMHbIHpRGwWMyTeVeqOaUzICjtFV7CPD7paj+LROY48Czjl4+/bxfYfc1H6AoJzZHXq2b+aXv1fbdjnWQ/y115s8kAtBMaXr5+jglbzg2u2PudMmOD4Wo5lJWDCiU0kLefaaIi2jOx8wWr4niqQyYn8zf7s9T9azIZSb2V2AZV//i4FS3fSROpRibBwZSDOlMXHGzCxdwQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en8grVgmnsMdw03drZaUswLlZ5Z9ygj69Uhp6hmHaWU=;
 b=vri6J6ZQOuE13gVI7NkPkXErP/4rS4nqOUmcaPQpkSt8jcnYWpaX7kJdS1b8Q6WTbl/G/feSgXGXANBz3iBHkEQKoSrOqpjNkamSBeugDq3vtZJfFEYEEVLkyM3CfUL3fE5fDAPHV/RQLdES0JDI87bxdS3Stpzy/wzzE1FYbFY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 14:38:54 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 14:38:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: Re: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on
 navi
Thread-Topic: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on
 navi
Thread-Index: AQHW2FMdngExjw6HMkWBocKKkpJIzKoDL6B2
Date: Tue, 22 Dec 2020 14:38:54 +0000
Message-ID: <MN2PR12MB4488582D4BFC79BCB3AF1AC8F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201222111037.31281-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201222111037.31281-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-22T14:38:53.803Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88531464-fc9c-4f8c-a7d3-08d8a6874ed4
x-ms-traffictypediagnostic: MN2PR12MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36636FDA5E939C13FBE47FE7F7DF0@MN2PR12MB3663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHaj7EZVHqrPmk67H880RnDz8dkV8Ci9jmuGkvbVOtojxdH5U/t97jh8DRBARb7DOLGmnX5PmjHD15x8iRans9R/e3Bm9h7EpiqNqLDBqK2kE1sR7livhPBy4qO19Ho+01CdwYhlNVfmc54PLajJC7QBi/D3hueF8MCFVN/+ObBICpbjJI8qFr+rYyIDG4nnqES9IIxXU1MHFuZQh8+qYNFr+dbgKj6dwF9DMihzqPbKr6ky3Q2gqIZPhpTIYB9zfUwjU48F0JWvH0h3SCDgUzpUXIIQOaSn3SlJX+dJ+yPnnIFvHUw8oaUs+ZWYTh5XCZlz/bksP4yh92EyXxwOd0u+XQ8/SndPJgxKImebkRr7goSjnEOIZ1f0Wdgdpt9E+CbiYhCwQ9m7+MkUUOKvbQ7kHqpsRR1xXy7l7BlSOHc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(396003)(366004)(346002)(316002)(86362001)(7696005)(9686003)(33656002)(53546011)(110136005)(478600001)(966005)(71200400001)(66476007)(2906002)(64756008)(66946007)(6506007)(66556008)(8676002)(45080400002)(66446008)(76116006)(55016002)(83380400001)(8936002)(52536014)(5660300002)(166002)(26005)(186003)(19627405001)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jUgamJkVhyPT+9CJhdsFBJ+vh5N8h+SlKGTvd6DmkMQ5jSAikmCHZZvFAeP8?=
 =?us-ascii?Q?ZvjPc9gQ4geZT4eBIQvGevnMROsMNEQ+Bvq9ti/6flcstQ+SsOqeyoqdexN5?=
 =?us-ascii?Q?u3EZzzrDXEZkDSsoYcQmVzZhjwZnwCQoHWAEi2yEiKW9mp/kQ25KdwPUpXgH?=
 =?us-ascii?Q?V3EqkJaLLAquNp4DVZJ/AkB9p5MX19iJLlng9oTZ09t2KFolTcn/CMWXe1em?=
 =?us-ascii?Q?9RAdQcXKdQ7YA38xEH6WbmrKEVk1vQzWlEtUp7AJUvn1NgpNn45iuv8VhDvX?=
 =?us-ascii?Q?PIyYvSG7HpxebCzXy3mHqmkJfp4t4Z+a71Dutm3imXdCJPRVCm20k5IS7UHv?=
 =?us-ascii?Q?OcICfAwiNCpJVocGxs1Oqdz4y5s3tu2qHV2uv9M1vdqejcjjwF+8d298D+An?=
 =?us-ascii?Q?9gmGPAYgRjw6dMoxbJPARo4Af4oLu8MUq0vEcOGEQuA+NPsiymqzeAr8cBFJ?=
 =?us-ascii?Q?UfwqBaTHu9ZcgJcpliVjMeDZvDPjHzTXoyRaBY8nhSJpYO/ksOEvyB5WLQwS?=
 =?us-ascii?Q?ouozk2yHSlN4IVgVf0ivsjhy65c2an59JMplTLcOLWBJJJkAJ3WXawxfx/i5?=
 =?us-ascii?Q?Xiwgq7zfQBwToxKEpbA1PVArwjilkzA0PSo70FgI3VwKkTRS0IiR8CtxLTQP?=
 =?us-ascii?Q?3J1/knFmV4llhoqXmuXPaI1640KovJNL8NCPSwfPWV/UnHiFvpbU6j/tMcBP?=
 =?us-ascii?Q?vr6/mEYxiDvTUkwCk7zVfQCHVUidy7OHUUtTCJ3KlcRkNUtki6CWxAXmkPGY?=
 =?us-ascii?Q?6DKpo4cyXMoB/Z+sxNGt9NlWwK7feqQ1ic8f0Bs+yt+Z/j5u0qjcGtiluV8G?=
 =?us-ascii?Q?nKrvUzabbak8QZK+Z8Lo5ChyB6e3+yOgJpLpqmmlNxNzERDC+OP0LfgtoFTt?=
 =?us-ascii?Q?F5a60HR8hqrgdpO3iqqQ7gO4qzB5X9EPZ/V5W1L4LA5JB8b8ROJCaPPNefkT?=
 =?us-ascii?Q?QvRQ/kc81xI3T2IMAFEFfkFANBWKn8X0aQJbwSy07I4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88531464-fc9c-4f8c-a7d3-08d8a6874ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 14:38:54.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrmwG4l01yXh2I1zxGhPpNrNyyjlKSYHiOewc9YdpB6vk5sfMlmbpgaXAH9SXrJoUg2wxWgLdLfHMzM7xkrpzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
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
Content-Type: multipart/mixed; boundary="===============1513637529=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1513637529==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488582D4BFC79BCB3AF1AC8F7DF0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488582D4BFC79BCB3AF1AC8F7DF0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, December 22, 2020 6:10 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Sierra G=
uiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Jian, Jane <Jane.Jian@amd.com=
>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on nav=
i

the psp access ih path is not needed in navi

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ib68bfb1b13e1cec03ec27bc9a867e2b37fc2fc8a
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c
index 060357625504..f4e4040bbd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,14 +151,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,
         /* enable_intr field is only valid in ring0 */
         if (ih =3D=3D &adev->irq.ih)
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enabl=
e ? 1 : 0));
-       if (amdgpu_sriov_vf(adev)) {
-               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
-                       dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\=
n");
-                       return -ETIMEDOUT;
-               }
-       } else {
-               WREG32(ih_regs->ih_rb_cntl, tmp);
-       }
+       WREG32(ih_regs->ih_rb_cntl, tmp);

         if (enable) {
                 ih->enabled =3D true;
@@ -268,14 +261,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABL=
E, 0);
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABL=
E, 1);
         }
-       if (amdgpu_sriov_vf(adev)) {
-               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
-                       dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\=
n");
-                       return -ETIMEDOUT;
-               }
-       } else {
-               WREG32(ih_regs->ih_rb_cntl, tmp);
-       }
+       WREG32(ih_regs->ih_rb_cntl, tmp);

         if (ih =3D=3D &adev->irq.ih) {
                 /* set the ih ring 0 writeback address whether it's enable=
d or not */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C5cf4dad458df44a5212e08d8a66a3f36%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637442322548665184%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DsadpoKT2ULD1eTcp8%2Bd3UCklVDIEji07YXGokQAlkaM%3D&amp;reserved=3D0

--_000_MN2PR12MB4488582D4BFC79BCB3AF1AC8F7DF0MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 22, 2020 6:10 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;; Jian, Jane=
 &lt;Jane.Jian@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: drop psp ih programming for sriov guest=
 on navi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">the psp access ih path is not needed in navi<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Change-Id: Ib68bfb1b13e1cec03ec27bc9a867e2b37fc2fc8a<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 ++----------------<br>
&nbsp;1 file changed, 2 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c<br>
index 060357625504..f4e4040bbd25 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
@@ -151,14 +151,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable_intr field is on=
ly valid in ring0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (=
enable ? 1 : 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;PSP program IH_RB_CNTL failed!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih-&gt;enabled =3D true;<br>
@@ -268,14 +261,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_=
ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_=
ENABLE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;PSP program IH_RB_CNTL failed!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* set the ih ring 0 writeback address whether it's e=
nabled or not */<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C5cf4dad458df44a5212e08d8a66a3f36%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637442322548665184%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DsadpoKT2ULD1eTcp8%2Bd3UCklVDIEji07YXGokQAlkaM%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C5cf4dad458df44a5212e08d8a66a3f=
36%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637442322548665184%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DsadpoKT2ULD1eTcp8%2Bd3UCklVDIEji07YXGokQAlka=
M%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488582D4BFC79BCB3AF1AC8F7DF0MN2PR12MB4488namp_--

--===============1513637529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1513637529==--
