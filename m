Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766AFCA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 14:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1316310E9B5;
	Thu, 21 Aug 2025 14:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Luvjr81v";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF29A10E9B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 14:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgmHwDQivMaam/ehtEj9MWzQmUwPN6rxipZ3b7G2z3IzuAcnomOUITXDNd664yUk9CuxuaxczmrtuLk1qt/cNayyXUVFZphlIOx0Pwj+BRNPc8br2NW5yOCoWKD7HL3/lc21xJQHi9JmuiMO7ZkSvrirVaxj4QOsNpi1FN/nuC2VQWguyg5UpjTX2FYH33kJIKu+aOoHVsxCBKJ/5RlhqJCc3ppJRB41fBwKV/d9++nYDmMuHMtCut9W+ttrh1hust5QRKGj/OGBMhxa2dlWRMZSbwCzYf9eFrttjG9FRUTYjDhMtqZ9/uvrEw1sJQh3fUQct9xofe8VZppgnOdWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee60u4ZQm4wqeRtmKMBvTbfhPz4EJVER4HN5MMZZzfE=;
 b=wFv4OrYSFp08paYPbyLNGfRi85/cXSbihEUB54pFeBqB/8Era/SvBoHN4UnnKMBLPhdaBrYBw3LjqFq2Z3JXxSzAOycWPv91qTfKUFalIAiSlrD35bssfYWb10cPCxuE0247Z4C7yjF7dw2vd334KExLsF/bylqYYWKKCqSjBUxpm1AFZlRFr5u0YuN9tFDXdHVVW2vg9nOx+qnDJhZEAuO+jg47o20f06wDPYZ1zazvYs38c6OV6RqEad8eJ7CDb16MO6budDRNA8lM1hiR5yDTSbSnPNDs1++DVqX9uqhlrlFptpUmcg1sbLV91IfS+VdowuGg6IXp1RXIc+OtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee60u4ZQm4wqeRtmKMBvTbfhPz4EJVER4HN5MMZZzfE=;
 b=Luvjr81v+0ipT77HDczmOK7b/F8pPExI3btlcRDPMouhlbsoTvBT8q+Xon2Z6z/55Vnc8478ndGFdR1i9PHaV98kmUs9pjE1Icof0OQ7dsxt9GoylzQz/iHVKZbvLT6oVOwe//N0kuJYqv9qPBwd7upiFGVH1IRc4ew/hLcnO98=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 21 Aug
 2025 14:29:10 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.9031.021; Thu, 21 Aug 2025
 14:29:10 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix vram allocation failure for a special case
Thread-Topic: [PATCH] drm/amdkfd: fix vram allocation failure for a special
 case
Thread-Index: AQHcEG9bNNXw2/icbkG5BC+hM/ndgrRtLvZA
Date: Thu, 21 Aug 2025 14:29:10 +0000
Message-ID: <CY8PR12MB7099363E76DB3618627DC6058C32A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250818183829.176628-1-jinhuieric.huang@amd.com>
In-Reply-To: <20250818183829.176628-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T14:28:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|BL3PR12MB6572:EE_
x-ms-office365-filtering-correlation-id: ba9c3f68-1572-4ba9-4d8b-08dde0bf1811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LGli4SeBpVA9Gote2VJ0ETVRxPS3zZhLht3EZEMEZZc0P63t1g21CGKQp4UP?=
 =?us-ascii?Q?xO5acoFY3PXVnFK0ERfTN9LO4TmHDMewNcMggsJWyrznJcfF6KlvUEloaypm?=
 =?us-ascii?Q?/rPDa0rCUQ6d8/JY9wdqkQRGNDCzWHE/YV2p4DxEQD5Qa6bQs38XJFI6bCOR?=
 =?us-ascii?Q?cd2AC3ollj09Pn32ly9bUq6RYaT0AwS/WhKv8i+NdN4/VAh8dTKy1pTKpLUe?=
 =?us-ascii?Q?bz/txBtTxRpm0P9TxOa/m1SlsjOHxoObwGDHsOrFXJLyaic7OBbjetdLP65P?=
 =?us-ascii?Q?RzE0fBxs6VgwKG+nLsEmuyuiddtsH6EO8uMueqVEccboXeJGgpdCvrRm4hgz?=
 =?us-ascii?Q?ybvKq6XDbf4GCUy1Jnwa3m8fMN4k7PhEWJUANjAc/r4tLCxwNNoz6MaM0Shn?=
 =?us-ascii?Q?Syll0yDeSsgqAlFlsiPgBtRnmWM/9wDNGJuzWYOanyyq2xgwbGrZhfbCbzOa?=
 =?us-ascii?Q?mJ2cBjjOr/mO77/D6Nbb1yA15oI6Cm9EMvI4IW6LS5xqWzK9cXYQm7EDAQM8?=
 =?us-ascii?Q?YauFYbxQ8cajeSVYyS1X/uItgA+GGSbouM4mvtr7T+Rd7l5YJ7N6ajSqo3JL?=
 =?us-ascii?Q?xeBpTIvx272O8hX3AN7WXU220NeDMBtwh/jrHFT5IL379q1/5trsxaDeO0PD?=
 =?us-ascii?Q?dO6OQDs72qcnBXJsArklbfVKfuXEvuKnrA+iVNpXb8ADmqyQXbL4B6MHnP7M?=
 =?us-ascii?Q?i08KF8WhytvsLXFRFQMMq/1FsNr4Upvh/E8eaKrAPd8ustZpDR4CoXvQAaBB?=
 =?us-ascii?Q?86xTTiqRgwH2Lev3SY7oIAKhfwupYiDaLx2B0DehRjepHCxM1IM9ZZtg7y3X?=
 =?us-ascii?Q?ae26dfRrIeJdju62fdhXiLB67GyopndGiNERFQde8xAbdZFGVUYf/iFfPngS?=
 =?us-ascii?Q?HZChRtmLGPr77ZG0AeB0dOpxZj8v4xpdaw6p1IjSa97oid12adtljcdJ7t0M?=
 =?us-ascii?Q?eeTtqME8FfEm/2gLG9Zb4kbk2SnXBOCIYiiqHOrP9TJ2eD3PY+hQ+7YEnq6N?=
 =?us-ascii?Q?JMiFZxLWlB7MMeHl0BW+l9b8s6QLuRA7+f6uuuE4VG84NpRzUMXlmykQXn47?=
 =?us-ascii?Q?qB5mtmbWPyoYt9wx/HXO/0hBNpiu/qScU4MxWIzkqtHyUdO5KZuCACM0FfQS?=
 =?us-ascii?Q?WuFFr9qEeTJ3I/BhIbkxtSAwyDiM092PRYn4jlfmk9twc3mfkXAX/JOqiJYx?=
 =?us-ascii?Q?I/dV57VrSfxjyfA6c15i/+k+1XWsfqogkoMh78GTLR0jm7UwqrtGygY+Q44k?=
 =?us-ascii?Q?2n0q/gswvDZkTO227y34Mh3ap4ITXJMSlWeDQLA6Ej8Kkya2zCr1BX/Kdugb?=
 =?us-ascii?Q?735zvzNVhWvpeeUI9jPmEWyRJvSz0RemPOhm1pziw6JYubO8kX1Y8v5mJDC0?=
 =?us-ascii?Q?4WR85XPuY09+usRM0hFyYFFnEoUpXS3eFesIDH/cU/NeipVbe7l57zUW1GQ/?=
 =?us-ascii?Q?pTTXRcfzSmuo5Rg/22uCqYmT0a/0qGePvXQ6oiu5ksiSjYelXE+B7jDzcL7/?=
 =?us-ascii?Q?iXxAF2Uwfd3HhZc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mwRhx7jmkKa6DU9gZrTi+OaWPWYevGZzPLc9FOZ2p+3M0bX8aDZb2T8k/VB7?=
 =?us-ascii?Q?q6LHEi9eM5jmsm2mUWIhq+RLODupc3jD3j00gtsBmNc3cypep28iOWl1DmLo?=
 =?us-ascii?Q?8NNZiDK0xuBzlGyAjTw7YQRMnMCUQ+TOJF3TZpPlABqXfeBvoWHxiEuZICAv?=
 =?us-ascii?Q?QmCn7TRtd7tQnl4FtWvrO7FBGboZEo9iDTisloGl4/O3kyowcuuKUV+ucCWJ?=
 =?us-ascii?Q?k1qRHnM94MxR7Jwz7e2V3WhdZ0SolNyBR1qzMkYsftsTu00jF3muWBLjSfsS?=
 =?us-ascii?Q?AyeI/uix6iJ8v1sVLtDj2AJc3jTlak48Ca8Yeeyexn9fbZU+rFFIp8Yiw37D?=
 =?us-ascii?Q?0BiJn25x9uU41YhTy9zV84Z2Q5ATGhzktO8m+d2m2uhMPeUCt2/gGaj66qkC?=
 =?us-ascii?Q?hG+H1OMRtrRQfzVT1hmCij+oeWnxWINTpEVkvLuTEPYqxcu6XWSB8SXayyLa?=
 =?us-ascii?Q?3KcRbvyFlCsj4dLTBMK3MF68YCy19Cvz8A4k4DqoFj0hHF0tVdUCPDeDpwwJ?=
 =?us-ascii?Q?cCPAdASyY82Z6VSntZRXQqDH4aueaqOXAeBSsB8y3bpy+a16JS0jck0seG91?=
 =?us-ascii?Q?/DWQ581/QGj2ugX2t22Am3fHMSjrotT4WP6y86iaeuyYz/1IwGAJhs0+31Vy?=
 =?us-ascii?Q?kK+eTjg9ElhPeLEds0bdMb4w3r+kblVTSILvp6wUu0TFWLMHiaiCXImhIWQ/?=
 =?us-ascii?Q?ziIO2LH/lmZ/XhW1lHHSADt0so1/X8pP0HdZK7VJKAJlMnaSAdPWd4/q/YOR?=
 =?us-ascii?Q?WI6tcsQ7/qUNVrZD8nybO3MJMnnuEfJR4os/CG8LBlX/VKGBjhi/pToV3k6q?=
 =?us-ascii?Q?pGDGu6/UQ/3bf0BslsdBYtyo40C8QeCcCZO1YGjdAIqnhYXp956RfaHhVE5z?=
 =?us-ascii?Q?WAesRYB2JyqvUzx9PB7ZTbEbg1rvhj9mEa222/RlXcR1f0rp8tfamrOqi8Bw?=
 =?us-ascii?Q?r77bYRebOHucprdbNcW06dC4Tkpr6QEg8wSLDI7oRyaQZr0bY1fWkHgvvtlr?=
 =?us-ascii?Q?Tf9o0IwouDtFubSrKq8W9rrPhkY5/CVaqEsDnEGUEN68jginEpZDDj3ITO8o?=
 =?us-ascii?Q?Df4NobkkWdV6E9DW0lRxZgC7WG7UZPAi0mpWtao2hlEETBw9p1eqGoMHEpC1?=
 =?us-ascii?Q?ZkSJXvzlMGVN0kxgqwsDb9pYgvGax5tOudOEBe8//U0Pwo69q2pmPsgZZfVC?=
 =?us-ascii?Q?4gfvWo72UYA4/BD5lR8esUNZkhLuaqnO80iQXzUhiWRDE261XXIVM6RHP/6L?=
 =?us-ascii?Q?SmCcw8yGUQj8qkl7eQcwNw/hs7RDT/CcHkhfnwauuSKP/4m41AqKgNGH3PFJ?=
 =?us-ascii?Q?OKOwBMY1k/kIyszqp79UkCZjzH7QXxSycVF1yLme/wj7jAWet7+ghGngkrDc?=
 =?us-ascii?Q?hICKDoocZeiM8Hr4bO9HmHFvUVzjbFJy/hfw8544ucMws5busT6CTfugpYru?=
 =?us-ascii?Q?8kKNFERrmkAw1596rMCNT03rqiy/IFlQ04fHGvtZ3focAWdmwIaFNtiUGITn?=
 =?us-ascii?Q?7UaL9S39LKX6ZcUhG7sjs7bv30oKdTXHjY0tqkGodlQgJmGLBKztJqs7K+++?=
 =?us-ascii?Q?xZMv6NPvyox90i8Q3Dw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9c3f68-1572-4ba9-4d8b-08dde0bf1811
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 14:29:10.3458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZN3304+do2UaBAITB0pC+Xj0TcjLhxoSLtieiSjsIytLCLwsy83IPv7LlsSCk4HO/XERyVd8zsKh9DJ6ESVKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Hua=
ng
Sent: Monday, August 18, 2025 2:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix vram allocation failure for a special case

When it only allocates vram without va, which is 0, and a
SVM range allocated stays in this range, the vram allocation
returns failure. It should be skipped for this case from
SVM usage check.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 79ed3be63d0d..43115a374469 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1070,7 +1070,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file=
 *filep,
        svm_range_list_lock_and_flush_work(&p->svms, current->mm);
        mutex_lock(&p->svms.lock);
        mmap_write_unlock(current->mm);
-       if (interval_tree_iter_first(&p->svms.objects,
+
+       /* Skip a special case that allocates VRAM without VA,
+        * VA will be invalid of 0.
+        */
+       if (!(!args->va_addr && (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) &&
+           interval_tree_iter_first(&p->svms.objects,
                                     args->va_addr >> PAGE_SHIFT,
                                     (args->va_addr + args->size - 1) >> PA=
GE_SHIFT)) {
                pr_err("Address: 0x%llx already allocated by SVM\n",
--
2.34.1

