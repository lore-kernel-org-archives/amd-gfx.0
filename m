Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31ADCAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 20:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C5E10E06A;
	Wed, 17 Sep 2025 20:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lew2uciS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D3110E06A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 20:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOsIaEPKqKwXV197KYg6n7twBflJvPXl24+bwmDMoCEYPOZ+//7DSeqLN2Mx7yIeKmePJ9Q4a+DsRmEqRX2HPT73BQCe0S4cTtqYiinf41FGjCBr3nEGu6TLyBt8Qw3ulxhmGe5JrutgMvOQC/882X+1vxUvS7lEtYDZz+O5kx1AU2FTtriFRcJ00+vzhDy2ymf0hdi7ORjJoCAVvl+IB/BLiY/UrPxyYLVasu5qj8ON79vdN03BViYU6+gy7VYXXiEFGT4Vv8FR61eK+XicVYn3SPY9dpKwIvCPdmJ8Ka85vHCGalZip89jSe3z5RVD278/mv0QzB7EiWDtg3po9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7/R0U1Jsjc29XwsVWAriGmv7RKLlCLRptVmjiZpMLE=;
 b=hmbH/3mQGuIEm/i1uIaGjS3mHEJ5WA08grmgB1naEPER3sSnodiORYeBxDgZNGx2pJJggaduqe3RYvlweOXs21GLQVhpOZo+kZJGzluDO7MRn30Zkb1kA6Li/nCHAcnI0I6YW3svRGGcfvrUPgByYjGYz5ms+mqh2SYt55HJ0Vf3nfIvr1bPxkxvKZIhGxDvf6RV/3QAbUUz6YsnJOuk6EVAFemsNTHdHgvurmoPdpsa0IA+0XKh4ADoBnJ9QD3S6OVnXL8MTMMCSm2DtrchokUa9cM5RHkHx/Een43xAHgv3xMzygwMchlvbhS6QUueiR7NVgdCSnXPfEreztjRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7/R0U1Jsjc29XwsVWAriGmv7RKLlCLRptVmjiZpMLE=;
 b=Lew2uciSR/rx8MUj57Yr+wAIigo/qEoHVNR7ZkZufXm6Mp5avuQbYn1vNwdpZroY52ue7cQ6LOC6Nnjn0VqLtbIs7BrCebBTkL7kC7AYTOvPL83viB/Yaargj9FvZs8yyViK/sVpnCUlcly2XmonfKumXPWJczjO+2nQMCgsiZM=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 20:24:18 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd%4]) with mapi id 15.20.9073.032; Wed, 17 Sep 2025
 20:24:18 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix mmap write lock not release
Thread-Topic: [PATCH] drm/amdkfd: Fix mmap write lock not release
Thread-Index: AQHcJ1scHbhhabSPlESkwhu/IMSnarSX00yA
Date: Wed, 17 Sep 2025 20:24:17 +0000
Message-ID: <CY8PR12MB7099A00FD9E0B327579BB9DF8C17A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250916224125.29338-1-Philip.Yang@amd.com>
In-Reply-To: <20250916224125.29338-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-17T20:24:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH0PR12MB5631:EE_
x-ms-office365-filtering-correlation-id: 8dff0184-3b5d-446e-2d6f-08ddf6282d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?m4+BVhgiFWq/DEHrX73KJEbJKYhRWua58qMS7sydaP9JAINR/zTWelNziVFs?=
 =?us-ascii?Q?hsMxSZ9tPWuIlUuXGGmBJ+BHonYAPfpP5Rjm2yQe8Q+gi40Mzslv++8QOWAY?=
 =?us-ascii?Q?12qgczk9BhjZP6yS99ISEdRnvE25a1NbFgNuv842bVoq7p/AdB3/c6aEHQEU?=
 =?us-ascii?Q?UEDYbNM2xcJaPlW0YC/xUCkf1B9dxo/D4SSImnh/z9AKrbmDcZtThsk0CwPe?=
 =?us-ascii?Q?5/1999lKddXRB8DiJPa1f10nBOShhTwevqji99kNH+Q9bUnfnDpenU9aij+y?=
 =?us-ascii?Q?FZZaEVtpXxXaDtaTkouerlEN/HEVlUhQL++Q36rV+TRsnTCPkJoHqdTFKCjH?=
 =?us-ascii?Q?6XdRR4XfqBTqvPArP9NACLfgCs/GRFI/oYup88acEev+djb+7kna24W0rfmb?=
 =?us-ascii?Q?lqqnavsrvVsla4/hqEF7/G9ii2fjOD6S86ZNfi0TmPVH0OxSzCqdai6Ex3ns?=
 =?us-ascii?Q?Bf7zkCA5lbFjfemCMu7L3s1WgTobWgopqRZU3L9mGtF+zGM4ipX5uMySPIgj?=
 =?us-ascii?Q?ulnZkKLG0HLzZh+bLvCLzGbnSPdUsyQgp5RBvaLwwlIhAolCRm0XMjLOTH1d?=
 =?us-ascii?Q?h+lhnWr3MVKkzkMz90BHaOswuxRJA/bxgi4FUL0N9YcQV+XgVzKYpdd25Xae?=
 =?us-ascii?Q?P5zyRfJ+sEOEC3jJDQPgL4c/A4LM6Z8vffXaS6DALstIEHyhtKrL3L2WQMQH?=
 =?us-ascii?Q?4ybehBCDoyjljbR/HEG19tqSGMRi1JoMO8YANguqWAux+/Xp8GSHfXF+Bi+K?=
 =?us-ascii?Q?EkRnvNeR48Ew9kE6vzY0T+mLZR4wXm4SPnycYjoV5PL7wbIJXURUPI0W0Hht?=
 =?us-ascii?Q?Md0wXHSPfhYZnEP8Si4jZoVeXRxBAsOx1gZ5IdMqeVJ9S5e8789vkYWQqWUz?=
 =?us-ascii?Q?mmZeQ2cre12YIlX1jmMdl20NF35wXBfivW9WdETE7C2lT9PMG30J3Q2zZx6b?=
 =?us-ascii?Q?/Mz9Fytrb4WBMsUZaYPAwal3yDn9uJByuzfstaFYpCbIbBFLfehJWABYZqA/?=
 =?us-ascii?Q?yC7wGeHTGyhnqfnDCr12z/60DEUfPX+AC1S06hErEjbYQU53XFKyx2nw5OlF?=
 =?us-ascii?Q?+Tn4aXP8vm+8IV0CdmaA7nUxNoqWQ5cK9mecQ+cM973j5e8F/PJqx/gE66oG?=
 =?us-ascii?Q?oRbzy1ruDuVAVpJwfCA8VaLuxyjnOZXqezE3iA/Wb3wBV/WaDNYFN0rXiQDS?=
 =?us-ascii?Q?lGSDAUP2fOxV/mpgBXIEcXWxkKUZ+A/8BR6sbNKxQ57n1T2Vqi6UH62KHZ7w?=
 =?us-ascii?Q?r11y2H7NX7a9Rc67urrvdGx5VhoWwDyYLSmIWGlY2z6goh/Y14NvDcyyrtpf?=
 =?us-ascii?Q?R1/3+GOwvZYF35pbqx9jhXICT3Ajlllat0rBmCwFrfmWVgykUNxSeLER4fbe?=
 =?us-ascii?Q?sVl1DP1q/Zo3D0Dhvq46C9j9Z2aAykJBZZYTKfDnNVhCGVW7e0h1xzF1HOL8?=
 =?us-ascii?Q?AIsQnt9HaoLXhmZN1lBQw6tk5lrWMEjNtC12qy8U9BAXl+6Ie6dUDuRM/GaB?=
 =?us-ascii?Q?WL1L9dyGZ7FhfyA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8oDT6G8Xg7jwSZLubtxPANv2eBNWkSBVyh5hTsrRCha+vcgs8F41OdUqmNXt?=
 =?us-ascii?Q?THJvUDILmj6A0LRLR0zhxZnBYlV1CBi+a0NvJxbBiwaN35d9Bv4dgH6s7iVa?=
 =?us-ascii?Q?skRrSOKMKTPQEI0wecdY8+QdOvEH5KbUa4ENA+6tGpTIzVty8MbYBxo6xpgg?=
 =?us-ascii?Q?v74KJJcPrV+NFn0jFQIDN/NyR1/HjatGUq5/cX2JOwCD/drNxsopy2S6xGSD?=
 =?us-ascii?Q?rJY7xkW47UheqdfVwuIeweGeuW/ReNtSbZcg99andDS6IC6nXAIexh/yPf7E?=
 =?us-ascii?Q?36w+QOh9v9BvwdeR9iHfAOXUajofr9H8ISJ6UjM8THTAbd69jEvfoEYkQo4D?=
 =?us-ascii?Q?6Wt5p7Rj1DzpFUWrwVZpK515Fw1lFVmYUd4TQ9Q9NG1h5mI6w9jndm1WZ622?=
 =?us-ascii?Q?hPV1/PvqBD+UaESsmKdIw31Nu4fn4drEzeSnr+dgUz0BthYZATN8E04+sm9H?=
 =?us-ascii?Q?kpnmElZVtbMk1Mvi6zabIStbsrmraQZ6Hx/nUjlV+bpBm75fuMGH414xn+4i?=
 =?us-ascii?Q?cRrnePSiEocH2HfeGAqG6p3MrFWerXIU4omG7ISeqiPYkrA1qGijbWPr5DYc?=
 =?us-ascii?Q?H3q1lmZvBtvkhh2wQnD+As3gxT33PaaG/UBv5R/xk9Ibo3XlR0TF71opEU5t?=
 =?us-ascii?Q?u9o2Mn7sXmmgAEY3h5KcrgsRH3/+i7XnrDmkOc5O+6WChSAUFNZp3FDT7CI1?=
 =?us-ascii?Q?K04YwW/BOIym3akif3rJb1s/Lf2r4DDNDQe3Z5qH74YTKZ0JiaRtaxqYEkmR?=
 =?us-ascii?Q?qjpyErhX3ttAfrcBHvkd5bjS4yfS6ouOl/cA6a+o47UnJZGjWi3EDm4xXVF+?=
 =?us-ascii?Q?EvL4Rwotg138zgoFMxAnbgg9auDqHTO8SXvEcUkkrBUbIJhJS+2J6Mhopjkb?=
 =?us-ascii?Q?R9xiddFijhief8CmWp9f28LGI8koVRKVenUfAEwTQRqzSo9lJAnIzLBxHKg8?=
 =?us-ascii?Q?O3STm5z6OmFdfdYw+T6GMZPAQo0dphBuiS3Fr56wYmCTtG9v0HdmBQGrx5Re?=
 =?us-ascii?Q?e+uJ4mxD9LwrNJXOWNeFKclCvIFPUUsbNnpLNl6GhKkaqA1DbeHe7vUDvO/J?=
 =?us-ascii?Q?HBQGNJaZ24GPE2Rdg1YYgssSKeZumLmg99FoBoNYe69gHMss6ZAGL7IWL6da?=
 =?us-ascii?Q?PgRpCMrbccHBKw/zzHqb53H0351AO8yqae7qW8+Rkkvbeol4j80TB4N+Zp6V?=
 =?us-ascii?Q?0eRH+h0TZRH+0tgoLwjf8pDNR8gmzid/nz0334vEDIwFdmYLGFwKrMPJ4YD/?=
 =?us-ascii?Q?Ie6YfNbIkhBAHisVDr7ERSuH40elxXaidwBosxxBEBoPVg4TH07MsKy+hfIc?=
 =?us-ascii?Q?K85JGD+YlByYHeK+MJH/Qy9+ts5rzFGOJ4tDsX58yMkd1bcoeLqlph2WVhfl?=
 =?us-ascii?Q?qkSzJcosHFj0mpecpGPn31DaIZ2xxNKXI7q38PRUoNX5CYtnZ27EbgGhjP9i?=
 =?us-ascii?Q?zXxqOTJdmvIduSkTTRyLDa47x7hqvFcJsj2qL/Ydj2wtFSvE8ASfH+5J6Wi/?=
 =?us-ascii?Q?YbL77trWq8CkBhf6r4zExomP2GKzMszTqA3JXGjZVAWM1K5ZqvfWOnsWf+7c?=
 =?us-ascii?Q?kt6wE4rk8VhCAm0txj0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff0184-3b5d-446e-2d6f-08ddf6282d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 20:24:18.0142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgDpSAyN1zJ8ipA+Fl2gXKV4k54Z58QPYZ9s13CQZmQx9q843VhclTKRud3P6Jpo8V8vUvwoqRN6nrFnClH4mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Tuesday, September 16, 2025 6:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>
Subject: [PATCH] drm/amdkfd: Fix mmap write lock not release

If mmap write lock is taken while draining retry fault, mmap write lock
is not released because svm_range_restore_pages calls mmap_read_unlock
then returns. This causes deadlock and systen hang later because mmap
read or write lock cannot be taken.

Downgrade mmap write lock to read lock if draining retry fault fix this
bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 6604a37b304f..fb02ff9ae62a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3043,6 +3043,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, u=
nsigned int pasid,
        if (svms->checkpoint_ts[gpuidx] !=3D 0) {
                if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gp=
uidx])) {
                        pr_debug("draining retry fault, drop fault 0x%llx\n=
", addr);
+                       if (write_locked)
+                               mmap_write_downgrade(mm);
                        r =3D -EAGAIN;
                        goto out_unlock_svms;
                } else {
--
2.49.0

