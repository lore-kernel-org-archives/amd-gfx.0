Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C27C6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5A610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5A610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05DC6E91F;
	Thu, 22 Jul 2021 17:14:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABCE6E91F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 17:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3pu8v6attidMOpKlCrUTvPcNsQuYNZ43VEjTfTPzTHHycBNBYD8YHas/6N70YpYbDShXKSVFGmmOv9MEzc+1q2h3jUE5LJawjprO47zoaPRL6cqoWg/9oi1EEC3W3kR5VczU4A9YGE9XqK+jnD8/x4SMr2U9X8fhuUG0plCo729uvaf8fO3EY/LXruQMBAtSZFotFAP4nEiXm4BiM4coSehbUBSgH3n8nYlZ3KoJqGsOvb/ziKJEgzCMrejJHN+ju3U0xfKaS8vsFmHwJlDAaysbDKj7LzIZWqlWFUgUhv3wHTvmqOhloYA8rJDcNO0fRUZDPJqJTgo5FQYj1ZiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQBz43kDkLHQDRlB90B3kwBslmevc+MPjhZRh0E0WHE=;
 b=nLncMbk56tZDQlgTBrUOt2E/i+oeFnFa5EGXN+EcE5wi8RnJoD46HTeSEVNUjSw26IiYXSdHflkgJwd21Wd7b9/wJljSodXAMLp09jR/e6JtFUjXe8HnmfZ2dUu0yqTyaFh0B/HGOEdbluziTDMhmOR4tt0w7SDoo1KgPrHQyYuiFfWmsDucGbAZdQ3GSq0IWVpMSlG6rmEvpgzcJB+Sp9/NlOLQ4/EppZGQ/ML+TESNec9y0wBM82PBMnkxDiKSey+AW60MiwX1Dp2mmk5o98s3qYd52Xd+Cp2GN0xCAoKaTEE0KoV4WNUAqmbahv7kXLf1tSd0pOaJwjUCBMBKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQBz43kDkLHQDRlB90B3kwBslmevc+MPjhZRh0E0WHE=;
 b=c/ihUjdYVlxIR7q2RWF/mJe6/dKyR+tlKY6d6wOXus4Pol2aikCqBGJ3DETTiaA+36OY1TN754VI8irEQVPkChFWQJ19RTQMdeXOqX2nzJaqUIEs4gvakshLiBLPXSVtrLk2HkaiezF0EtEO/+Qfhm/nSXL/NTFo0PckqZjsIjA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Thu, 22 Jul
 2021 17:13:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.028; Thu, 22 Jul 2021
 17:13:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add msix restore for pass-through mode
Thread-Topic: [PATCH] drm/amdgpu: Add msix restore for pass-through mode
Thread-Index: AQHXfr1NHlp8viPSY0mx8XoExxYHs6tPPFaA
Date: Thu, 22 Jul 2021 17:13:57 +0000
Message-ID: <BL1PR12MB514452ED5B3012152F2BCFFBF7E49@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210722054905.1790482-1-ChengZhe.Liu@amd.com>
In-Reply-To: <20210722054905.1790482-1-ChengZhe.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-22T17:13:56.644Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56d952d7-3a3f-45ac-2d9a-08d94d341750
x-ms-traffictypediagnostic: BL1PR12MB5237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5237DF51006BC7CFF1907976F7E49@BL1PR12MB5237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7g9lFyq7cz74cIZEZxZk5Mih9vLcMAFJ4QUTfEOvMgTo3vsY6rB0wnWXEm7Q7UAbr0g3VLkdzNox8wE2sW8PVDiFDsEZx/jvbOi6GGFkc3F+1yvBzZK8ZjTxSHCBWbXzlNTC8ugXcLvUciWI1qZ9h1PCigC6Lm+qfVZz+BpzAwhm5wX5cUcwz8A+O/poX6MszRkr7nRzvpdReI7uOIc8rZVg3htSJZ4vdmJ+e9RTNcrLbYSaD8ATBTLXdL1rcrHs6G5eZKmuwLi17HsITRmj1laIvCAqLB4wcuY+W8y8lCzlMEh0g4rlABkeoGw56YVhpRdurHFpiri9PY/SlmnAvY8uSW0UB5qA2R5rr0kJlwsdN87zQnEWkV2X6XHkx2fzZjVuArz5abg87IC1qH4F5aLMsWIWBi8RnGl3XdSnP8hkbFGGeS9e7BaIAPaT6Nc/fQB7UjSwTa+mGB6QkRUXuKtXNJ4WFLc7nzRzVsx5mTMY6Gb33lYogZ5aOp7uUEHWGIw6rQxc/e9/Pi17nx5ucW5oEPbBtGz20DEmTME3lmd2LImYWXuzeObsCK+1O8ffj0iSdVT23zz4FUP87NwZ3ldZYQpwAaqtDJtlnUFzwpfPhhVCD2D4v0qLAos1rCjcT9OTm3d8scpQCP7g/4g7gbtujsYR25vDZuXyuefyfwZHodWDbvd1S4ueiZYDvur4b1W0PkzFc55NIhNEgDd4eg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39850400004)(52536014)(110136005)(76116006)(122000001)(2906002)(53546011)(4326008)(71200400001)(6506007)(9686003)(66556008)(66946007)(66476007)(64756008)(66446008)(316002)(54906003)(38100700002)(86362001)(7696005)(186003)(478600001)(33656002)(83380400001)(5660300002)(55016002)(19627405001)(8676002)(26005)(8936002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FW9BK3VaTocmuYt4sYRaiZ9LzMK/a/FPq4zwty7PA3U1OiAodvgCsm8FpGoF?=
 =?us-ascii?Q?/YoeBfcqtVlDIBhdR2i9QIdDn0UypOzikeFiV15Z9+DDbprwiLMNTroK6Php?=
 =?us-ascii?Q?scAGgxs7r4zT9pXZdadMHfhih2kuXV8GT1y8YZAcSRY4R9WYEAwnjyBicjff?=
 =?us-ascii?Q?pJqsQd6OB46414jjrbjVJqLmAyeppWC69CBXui3PPd647F4REkrImGYah+qC?=
 =?us-ascii?Q?yPtejB/u98QxPQydZT2UwcmRTGavAglDiQMnYk2YMgkgY/7gr5h+yJYyy6Ff?=
 =?us-ascii?Q?CY8vf4cnN+l8DaHuMtGPdMenuGuaP/a2DU0R2aOY1cybayeO1T3QhDrLPGg+?=
 =?us-ascii?Q?Xkqva/2N4IAkjYmPxAeqHBA55Seg72VLIOMd2eJ3bStX3pCmbv4H9IhRhhlL?=
 =?us-ascii?Q?W7txfpFBczV8PgpttUU+mGjXAYzOSV5VsDJIO06mkcYyca9ta8EVMNqhkimh?=
 =?us-ascii?Q?GIA7hHUwMnwLfvuT8TTX2kkFd+h82NY3F5/0nPCB4hQ9obJyQgKv/0UYs5KC?=
 =?us-ascii?Q?sIGgf9IHJyWR/rDR4fNOx4J/7MLOT+Ox+6On1pOlG/BxqXPwg3kX1sA0buEk?=
 =?us-ascii?Q?k5p+SJnNsqdGbFn5THe+0LacM/1x1uvnjNuqMEHnZt8Ouii8iDrMDBzyc516?=
 =?us-ascii?Q?CLnGjRdnQlq86/+PxhNGTupULoWJH1JKPvb9Yk7+7eunvEKRx8U5K8IZWVeU?=
 =?us-ascii?Q?RbXfFo1YYQ7RaML5nWT3kbZ4GEp5q8M7zlcnez052cm/7EAAteZyj7r093ID?=
 =?us-ascii?Q?IGpepDklO01yXmijP7Ri2PByXdVBlncxktNLtwkJW0yd/Wxzb/6s8qBKQMr9?=
 =?us-ascii?Q?yl7GrzCRYBEd3PJ+0I4A2LJFoRWUmB1/hyqBcLHI7uoLIZizwMCcQybBOHTS?=
 =?us-ascii?Q?cVDUiwr4CHzwb3eG0m+ZTAwCsNBKVpBpDb2hu3gVXj8uERN3Ycg1WMYnF53R?=
 =?us-ascii?Q?Z3qmj1UdeNk++JroUVD2At8G5Qnb+cTjfIjbPF/2l+ApQERgtuVzipV49WUX?=
 =?us-ascii?Q?RSbWi+n0e2I32Tig+gHh9Gi6fCp7pB/Ijm0DF7Gq1N6mJxunp5juQBokJMcX?=
 =?us-ascii?Q?jXStw+UgDWYIJZC6J8EpQ/nbmOUkAfpM74qvON7LixeVl/bAKLjpgII3cvbl?=
 =?us-ascii?Q?8RsxrbnV6J/RomzkYCGVT8SRr3voV4f/x0isqMKcTy7o4BkzOjh07yHTINp2?=
 =?us-ascii?Q?u3YPSttianojOyZYf8hGnUPsMST26aU/m3CqTFX3eGlfKcyrJPrLeQfVS0yd?=
 =?us-ascii?Q?P9y2qUzUUJEJN5B+TTAlFG+DTJgWW3m0kBs/2NFkJSH0iNKnCZU0AoYTvgS0?=
 =?us-ascii?Q?tj3jQqFN21TAWQWIcrPQwstn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d952d7-3a3f-45ac-2d9a-08d94d341750
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 17:13:57.1955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGMCQeVOVa+qOIjHI1S8w/6YqpmcK0EX6ILnT0RYooHuJeNhpOEfS70wzQdtB5hakDNZtllmp+WatTc0shEXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1023486099=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1023486099==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514452ED5B3012152F2BCFFBF7E49BL1PR12MB5144namp_"

--_000_BL1PR12MB514452ED5B3012152F2BCFFBF7E49BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
Sent: Thursday, July 22, 2021 1:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Ja=
ck.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feife=
i.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Liu, Cheng Zhe <Che=
ngZhe.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add msix restore for pass-through mode

In pass-through mode, after mode 1 reset, msix enablement status would
lost and never receives interrupt again. So, we should restore msix
status after mode 1 reset.

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c
index 83af307e97cd..e1aa4a5e6a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -584,7 +584,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_d=
evice *adev)
 {
         int i, j, k;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
                 amdgpu_restore_msix(adev);

         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
--
2.25.1


--_000_BL1PR12MB514452ED5B3012152F2BCFFBF7E49BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chengzhe Liu &lt;Chen=
gZhe.Liu@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 22, 2021 1:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;; Liu, Cheng Zhe &lt;ChengZhe.Liu@amd.com&gt;<b=
r>
<b>Subject:</b> [PATCH] drm/amdgpu: Add msix restore for pass-through mode<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In pass-through mode, after mode 1 reset, msix ena=
blement status would<br>
lost and never receives interrupt again. So, we should restore msix<br>
status after mode 1 reset.<br>
<br>
Signed-off-by: Chengzhe Liu &lt;ChengZhe.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c<br>
index 83af307e97cd..e1aa4a5e6a98 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
@@ -584,7 +584,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_d=
evice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, k;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || amdgpu_p=
assthrough(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_restore_msix(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_IRQ_CLIENTID_MAX; ++i) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514452ED5B3012152F2BCFFBF7E49BL1PR12MB5144namp_--

--===============1023486099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1023486099==--
