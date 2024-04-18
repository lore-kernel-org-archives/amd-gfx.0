Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4906EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 16:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17D4113DB3;
	Thu, 18 Apr 2024 16:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqPDrW+l";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77870113DB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 16:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj7PXtMUanXQ9Yr4RfQS5xHgnBRleZFpNXJsgnyK5+qENkk5764hulvEZRAhb3WP9ZBYEJuqe9ThWZFuK2h4xsA3dmiRHEYBQU+pQy+r8zVkJMKSQrvLqnuVMV/M+y4l+SG2RfPpHCEeCDBkkkjxRyJpz7qoPmH+2rRjRXYSDBAO/9THltv1YCLjo8BLnR+3b0G2+u6G4kBbBNNlhtyTJUJP8lmnuvUSTXnHOp24y/eoPkRKe3Xp7pvs2KiO7DFVnxOErbPFehv5GuF4316qEBh0So4jcjT/zYvH6ATbhtU27CzisSODVUHpDhLMSXzVcLydwGfDZuRLXM3ZlI2NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn/JdmyIh1o/48ES68a44y33R/d15se3tye+aC61gDY=;
 b=DsbKJz97Juq/o41OQihohKNOzM0jarwEzwMnR5/LK/LOLJkCp8ohr6sebWYoYbQGV3riYPVZyHTYB4oP4pIEkw6lqUPMxmf0DlB0CO3oUECA3OPJPWC974hlKA3PvvoW3bNaR1QoeOCQGgsgqMDWztxa14di7RojiYyTxtXRZOlijbVEfjIfDKn29XmaWR1o44kpnDKmQto9IZnM+D8s7X0yMhdyY0s8IYlVSEcr5JlQ9zHpK873bkoivxm5M4N4bxVzwQC8l/Af6k0jVCHrYUH5H4XnNBKoweCNw4dRqhugbMYaW6hOnBeXYyV052zsp+MCWrW5rEj7n+/uLTxixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn/JdmyIh1o/48ES68a44y33R/d15se3tye+aC61gDY=;
 b=SqPDrW+lhl+RvYreQ1xK30ruQNZMdxQUk1qBdcnWiJbHBvVQdkVZhDFD4+b4aw3zN5EEepVMBmnGjPYfNk8Xc7lwn1KvGPmn01GV6apt20KpqHguKQCmgzhUoEbkfF+mE6KWEn1MKyoY4iN61rQh7NbgBbbXKxxhJI7062KH0vw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 16:23:24 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:23:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix leak when GPU memory allocation fails
Thread-Topic: [PATCH] drm/amdgpu: Fix leak when GPU memory allocation fails
Thread-Index: AQHakav1AccJbBjbpUGEVFfaroFS2bFuNgsJ
Date: Thu, 18 Apr 2024 16:23:24 +0000
Message-ID: <BL1PR12MB5144115E3EF2B8AE6FC2363DF70E2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240418161724.1214480-1-mukul.joshi@amd.com>
In-Reply-To: <20240418161724.1214480-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-18T16:23:24.390Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB7758:EE_
x-ms-office365-filtering-correlation-id: 61e5aec9-8c98-42b1-bfe6-08dc5fc3df30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 05J/uDps6SZ+nkI/22lZkfERhiB8RSyKa2ec72xDgsnaQPJ9X6GE+btOAuWH+D9Wpa14m59+VSZ+UnJtAA2AwVuoIhRHDGnTi5vmvpvq2WmSHZqJGDPKLypUKdUOMVtRukVUUQtOLeJzVehy9RfOTk54XsD0sMl89zyM4KUj09hg0oBvH25AwkEE3AC2CmVu2f/3Ia3uAqKGJlP6t9ZGiAOcXKEsxidsvWntCi74ebma5muz07eOGv4Lqm4dOd7CqrhOwwl0IIBUHgmmW6PR8guICLtrVCdJNyFhEX9hXJP2TjiVnrIKhX1B7jRQRtOH5F+uTBdGEbmOkfR5Hoctmrc5vy3PYRrZE/I06xXsLoWNZ0XRLFcACUSo2us2DfM9j+JIDV8f93i/YwNEX7xGB7C/fuOR/k+DssVXcAjpxsmY5/YHjGMFC26CHFyRjNbgfr/baYjEYFJ+ahliAXLC+EekUbDQ/XxqhIu/FbgOZo+8GGFM3O6JynE2lTgTYmkjT9Jjc+GwF8Duhh5/UN5/RF6Wh6E+i91u25AWgG+stH/+OpoeP5uhzpPaQ8uFLQQYkuKVVDrq0hmcGW2ai9EquTB9a7yUjWUXl79lRaXwdwwHhi+UaSIkvkPeamaTKH26imUtG9ouTFUH5Q+38JCbuXBXZLcAJ23CTQJQ7DyTDJOouBioorMWbQ6lq6MdAovi/ojzfs/UG9V6d0erXkyLVZ7e95wodDSY+d9GvscSdck=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PNTbbuSzlDGczDQWZNALVd7gu/EIEraCgC7RcnE8gfVxl7UfqYZaoUhC2tjQ?=
 =?us-ascii?Q?c6PQRtadF5Hg8Cl3zbuo4GUg01zt0TfLwSwAub20I04Cful8zOO85ePncasw?=
 =?us-ascii?Q?Ul0tsRcHl2fPaHojubVMarBN9WxgjvVEdPLOLZjga77HXvZ/D7rzW1mkLNXu?=
 =?us-ascii?Q?KGRn0DJU3RN1zND/LoWMMrS6uI5imcDI3xuhPGjoBqtgo9XpiQOyYgLyAu90?=
 =?us-ascii?Q?fsXGgwk4LWuEDfSA9F/EB2tLWApyfzq1enhQSQogcJLomsjWnqj4vNNViV6y?=
 =?us-ascii?Q?1rHLuVjTP+PpJ/WRNkE/GKSdJU+PlmpaVSii1v+ueYdop9wFcSkoWXnJxsPk?=
 =?us-ascii?Q?3BUblY5q7GQhgBGgVnF3QBFNJp1k9kwhKIxNfqZv9oFPbwHCgOaaIkD7UnEz?=
 =?us-ascii?Q?EuwF2IpHPKffG6GfYchOdX96Aibc4eKTwCQ/UsDLX/sReZUXAMfxoQPsPtSE?=
 =?us-ascii?Q?kOLmzGDlsoZQn+Or2rWbbiT9wZhlK97DQsbAQy8dtLX2yfk4myZBRdYe1fnm?=
 =?us-ascii?Q?vhywzzo1VsZaDO/gQwO4XN7hu8rZiCcE3urjZSz00d6cWD7hR5EDi13sVoUV?=
 =?us-ascii?Q?opuVSzVBo479XeqE6JVwd4OQ3Vul61jWknVERaD1pk4RJrhft8XW6ovljatP?=
 =?us-ascii?Q?7AqGX/EEJ8udX0OmZBjudmUJFEv5Dx8KqGC3Qjks1cGKsrUVpWL+tmUfO4Fm?=
 =?us-ascii?Q?Sd9SjQ/43J5Mlzby4LXyaPR7rdSWJUyCKnZPPUjPXaWPM9oJ+HdDVq6wxZxV?=
 =?us-ascii?Q?/WOZf5fUVo5lPKqg975Bx086GDeFSTNNpd5L9iX/IT4om9pinCDYhcmAkLBT?=
 =?us-ascii?Q?kFZVbK9XP908AN2wimutOfRyHoLwgwtwq9mejKznc0m3We6FsEAgJW0e6vpo?=
 =?us-ascii?Q?vFo9PRUT+agi1I8LEfeR5w8P9IqwtdwDEg29b6hVD4NlQ5xo757dtuLXeWoB?=
 =?us-ascii?Q?jYuWHuBAEVcrNWkVcHMT2v6ppg2jkvX4ZQTb2MVy7R43B40oCIInrJaj7Fle?=
 =?us-ascii?Q?i29TkTzPX9j5CmrWOcC17l2YRDubyTlZRBAHNfLGLgPv63o5iyt0l54sfxbH?=
 =?us-ascii?Q?j2NYWfnh727LFgzwCWF8NsQfvb5tvTVKS0FieDgIQXjf+Bt2IuXCRnLLbQsi?=
 =?us-ascii?Q?gZeddU11Sdea8xzD/qCIzBXHe7DMfDxzaWup68RGFgIhkn1NBuD1Iy+eVaOG?=
 =?us-ascii?Q?y4SfS3YFT3Bm3z60uBz8tn36nKAfnmNp8SRzxBajjr1/MAMPQC/qTUIf1ILe?=
 =?us-ascii?Q?fCgKbnQ1ERABjLFySGneK94NuDpFgFjVjlrAidf2ylmHdQ/5K2WH8u9f34kM?=
 =?us-ascii?Q?Ulyj0Egtbv2guXwZ6zxkFZVTU/FdPfQh4ET7lAIQrgy5XRI9di47dmWWWla4?=
 =?us-ascii?Q?M5wSMSghswE837o4f0RM2wTTW7hS0qbw5TotLHlbh7T0KaFfgKV7y3pv1w8e?=
 =?us-ascii?Q?Ucpd781Sm78ygjcLvTGISelhYg/iLj17/x5/uTDQokupb2vf+bi8bCJ/UCcV?=
 =?us-ascii?Q?K4TnnL6WA0cwLxfE4sO58DzindZT8CJq+6eQVjQcuCAXfv8WPSUhcZxe2LIJ?=
 =?us-ascii?Q?xrjx/PZTwzXj+pRV1po=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144115E3EF2B8AE6FC2363DF70E2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5aec9-8c98-42b1-bfe6-08dc5fc3df30
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 16:23:24.7192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbD5fe0Q3fvU4NPJSc44ucoSNBcs0zWoVxbGT7D+cbetJPQ/AKrSCoOO8qPT8Ao1gffHu6lRB6vSTJi7LgvSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

--_000_BL1PR12MB5144115E3EF2B8AE6FC2363DF70E2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mukul Jo=
shi <mukul.joshi@amd.com>
Sent: Thursday, April 18, 2024 12:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd=
.com>
Subject: [PATCH] drm/amdgpu: Fix leak when GPU memory allocation fails

Free the sync object if the memory allocation fails for any
reason.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..bcf4a9e82075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1854,6 +1854,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_bo_create:
         amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags, xcp_i=
d);
 err_reserve_limit:
+       amdgpu_sync_free(&(*mem)->sync);
         mutex_destroy(&(*mem)->lock);
         if (gobj)
                 drm_gem_object_put(gobj);
--
2.35.1


--_000_BL1PR12MB5144115E3EF2B8AE6FC2363DF70E2BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mukul Joshi &lt;mukul.joshi@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, April 18, 2024 12:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Joshi, Mukul &lt=
;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix leak when GPU memory allocation fai=
ls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Free the sync object if the memory allocation fail=
s for any<br>
reason.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 0ae9fd844623..bcf4a9e82075 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -1854,6 +1854,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(<br>
&nbsp;err_bo_create:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_unreserve_me=
m_limit(adev, aligned_size, flags, xcp_id);<br>
&nbsp;err_reserve_limit:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(&amp;(*mem)-&gt;sync=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;(*mem)-=
&gt;lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gobj)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_gem_object_put(gobj);<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144115E3EF2B8AE6FC2363DF70E2BL1PR12MB5144namp_--
