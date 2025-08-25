Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CDCA0FE1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 07:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F7E10E3F8;
	Mon, 25 Aug 2025 07:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRMBbuXK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AC710E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 07:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB1gE6rKEpozo/x/Jr9mXCDikW/3WsPSgZouF/gbaCiRV+axsZjsJC383WmInt+1rHIsylcOT+Ux/ImTbfDJyZb2KiigQa0i47ecw3BhutgpUY3LkkMm5ur3g3sZB8+1AKj0G1+fSbT/QIEtI+4tEjGgAEVevJGdf+FFjmZmChsR7HIJDcfXNyiM/P1yIRADx8VaJKSf0NOwQyz+/YePbIS/zAO5QpbWBAnDRK78MpWq7YwTU+2EJWhG1Z6Q7TOgpQjCNXNuEvTTo+YVBWExpf6w5gv1z9YB13nPe2YApI2nLi1takJLn5/bLpeTzOcuQRtT9zSE7jUJ24snL49PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyHiIPESK/LdlC4feHxn+LsLseGihw9zoBSCWoNM9tA=;
 b=IspYlywk/v6kpSQ4WIMO8sE9bzs3lD4SucczRBmCVnlyfFOLqC/6T3/8K8/GEsjbu/izVW590u6BtIVHeWRRyFtibdGAdaejAn5TXOoZAzdU5U600HahdTHrhnbLTA5JveTHdQ/tqSAPqFHt3bdFYcax6u1MRgev46Edsy4Yr/AlMsU9SSLzHM7o3GDnFEev4Va9/Iknv25j+av/LPiEZ2kVx1Tz1Pr9d1NHv+Rl2TAAZ8A7CLxH9tBEm4YHiDgfxb2i6weVX7j8osU8BW9IijTQs7Sx2azvC+Tib9nAKW6nw7XpPDHk7AL/Mn55OWLG1db2rGZSJHC+uMS3qMYycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyHiIPESK/LdlC4feHxn+LsLseGihw9zoBSCWoNM9tA=;
 b=zRMBbuXKSJkM63rGrd/wA8vkpuz0CJbKAg5qUeb0lQxQqUr4rRQeqplFUktak6R7APN78+9x0AlWOOauIMpF4JpBq7fTUvmZRPA0uFdX5g3Y8r9+BNXLUKe53LuTNyYFiHia9rjJGMCClIXSfQXn11kDEkhkEA9PwkwzV27W6VQ=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 07:44:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 07:44:57 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Thread-Topic: [PATCH] drm/amdgpu: fix shift-out-of-bounds in
 amdgpu_debugfs_jpeg_sched_mask_set
Thread-Index: AQHcFV6ao/HGqJpy+0OznCO+Z8CJubRy/UgA
Date: Mon, 25 Aug 2025 07:44:57 +0000
Message-ID: <DS0PR12MB7804B605E98E0D7DE452695F973EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250825012123.1383301-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250825012123.1383301-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-25T07:44:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|MN2PR12MB4238:EE_
x-ms-office365-filtering-correlation-id: 6cc0ba67-5c29-4c84-d8c3-08dde3ab49a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?10fNriibrHcfCkUfYjI0rcwLQOszwYsWvfMaFpP713vf+OFf6WAd/zN9Wz+C?=
 =?us-ascii?Q?lskWvKlGQ0q9YIfF8afY1/vdkyrJcOB/n9Gnzgn7T1UUqiK3DqRcBmBqSu7S?=
 =?us-ascii?Q?o2BKepUN1pVhQwJMNWhprXh1ihyxrDgIi7HvMxOV9IjhdfIsRhRU3b4ift6i?=
 =?us-ascii?Q?5oH+mbSlTbx9uT9dj6S/Fe0usdXoBpqFts4s3U5FFkDI2/3JFKvDCFhyAomA?=
 =?us-ascii?Q?ZAAM6E6n2IsOxMQSMW8E3/hi2zbyIGv9eQDB5a2Hie/mjOziyeWnbHixD7XS?=
 =?us-ascii?Q?MC4ie3WfBEd/cO/m69tIAD2hS1n7RujVU1JR/UzzJIidI4Fu4hCbWt4mdh7e?=
 =?us-ascii?Q?60ea4qcaWAeVcEV5S6UJ9elZjkKZEVXL3Ayu7z7HsV7H3VFYTabG22vJ2o00?=
 =?us-ascii?Q?ymcwI8ZWyeSEXLsjN6/p7KWXYPl+Iim1wCdZgos9eSq7XXdFbaw83ljm6nGE?=
 =?us-ascii?Q?f9fBc3btsZfQK/Ug/usMckiWfw2Du0V5P2tqUeTibyhRF8QetkGEyqfpWhpA?=
 =?us-ascii?Q?4x6CFmRQNQ8z14Rd+aJS4KYcVHOjOh9KcZQp0NRrOZcIzA7SIY8AxOLHmOsV?=
 =?us-ascii?Q?SAX7rfXQHhj8NCIqJ03pEAb9dU7Z/5lizUifrcH3mKcpkkIxfXPAxAjgNAeF?=
 =?us-ascii?Q?xD1SKDp70iNtoOYmYAUWzl0hq/TbrbDIMDNyGJElicUPP8XESmtExNBNPAtV?=
 =?us-ascii?Q?+w9c20rVxGHV29vY1undgLO0a9tZFlgSzj+8+rSUdH4HpNycYgrwHf5cZlrH?=
 =?us-ascii?Q?Eb9RTehH9R0yYlCQEVUTqzefYZ04ZdknzEAL4Xd7cb9zFgovaILguZHZ5We8?=
 =?us-ascii?Q?Vffulb0wciaHA8nzhSwVhzZaZ7uRm97v0P+X9uFzXtY4ZOPuz0YW9x7p2Uji?=
 =?us-ascii?Q?5jABXU9ruAADV1WtY3TXJ9U18q+yOZdfx0ZFpEkEpq1lGSpZ5/qFcjz619ob?=
 =?us-ascii?Q?f7eRck09iH7fCpEOAJgubnA7+mizlileZ7HtxsjkCZohL/Yjdm56bTq693f8?=
 =?us-ascii?Q?w7U9FAYgdbWGGZFiG2DGMNbvrvcxCOW/Fp/5N7ZCscFyHOvD6m0Xdf3Tq0B9?=
 =?us-ascii?Q?WXq3S1JgVMHFFvH7z4jrPiEUBi+cC/wxBe4hcd9knesLqQImLFtSlqZL78R2?=
 =?us-ascii?Q?py2Y8jHaumagDsr37m5VXQ3JH+WYcfz+qXQE4obUCi/EUpRs6pjFPyjSGhHE?=
 =?us-ascii?Q?9EjxGFktIl3x+LXyFc4AZYbPkGxqIK3yOA8nnW9nMLGN7L3WA0DUCOI8CeDY?=
 =?us-ascii?Q?Pga/fxCG+Aey5Vz8FwVl6Q/F13a9vom/5tF2n2FhPqfW53bTGVoFI2LbUl4L?=
 =?us-ascii?Q?Z5qGDvY4XC09vANm+xYkNbUaQLJBAFDZvXksVU8OHODOHzBET1WWRZ0dAr8w?=
 =?us-ascii?Q?MmF466SIeAqJxFg2MrHzF8oee0zNh+3kPjvjhvThch8tDwwMCHK318B92bMq?=
 =?us-ascii?Q?iWoXXh9oZOJ0JUS/36yjo5KU1XgeZIv1OOKRiOwfpJY7O1zoLEMz2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sf8yZBoXOUb9zEz3HkrtH3xNxPosxJbVxenQjecXYO5Qhn90qpyLSC1t40Eo?=
 =?us-ascii?Q?dAHaufYA9vdNYujuaPJlBQ7wHnmtpZWFLL6SKH6VShotsAzKoHwIVzTGV8YC?=
 =?us-ascii?Q?Ib/ZEUWgojlpQNMlBTO6YTxf54I93TjCeqV0VYhxwNwssIdSDjYt8K+DFmJB?=
 =?us-ascii?Q?q0D9uNES8uULTyEmKI0maHpzqgrJDvpVJfrRt3ng5eQN6YG+aJOOZfJZyvoE?=
 =?us-ascii?Q?O20dKvERKUrXYVzN9bXkR5dFxTRuSz4qmAIGh466rmB8rTwSQ7mF0wu1aTEP?=
 =?us-ascii?Q?orapeQyWXgivixIaSjpG7+A+PNJ8ya0dhhF69vNwBLevo/dFcp8CpTaZ23jm?=
 =?us-ascii?Q?6yn63M8gKN4tAZBgnrpZ1TrjgzQkK6H4Ckh29uosEgRGx6YafBQb59ElYu4B?=
 =?us-ascii?Q?evq1nqg7mqqO9ElDeJ8t6pYG/61OUAw3E5yE4o7U3bQa+KAnKSw+22lwXJp1?=
 =?us-ascii?Q?eeSFoHiHVZhWvoP4/MM2Wh0KD/xBgQEq43hgd65wCEmMDP8d6eOSk02A+4Q1?=
 =?us-ascii?Q?4hQwcNrmjTFXWCgTMB8IEDBvF95Xflj0pGpYbBnLdeYkOIg0oZgEsYGRj5pI?=
 =?us-ascii?Q?KmNZaN+eH9uDuaU3elmKhKzcspxEJb9JOb/ntHgbMolIDPbREPUoPgdffwNA?=
 =?us-ascii?Q?shpMLdx5hiiua8D5lC/SEx+FYH0Jr6bqyxGW9bK0AKbR5DV/Oe7O3+/CZ6fp?=
 =?us-ascii?Q?ka9WhkgaAFYqUQ/N1QK+RX8+NsZQp2Mo2PbJ75uoXOSLnkwzRn1y7F9DVts/?=
 =?us-ascii?Q?o/EU0xuLSeegpEG5VVvHj+P0HlHYvZ5Ii+VfBIC2DSuEexwX++ulb6vkmy2C?=
 =?us-ascii?Q?KknERflJa2mQWAfSt6QuX1ZmlHuuZATUgY/LoARJUq6YO1XauBDcxuiLvAOI?=
 =?us-ascii?Q?pylMTVEMTXUSt9FNBtt75KJNcX9+jsIvrU8Lmv4zCmajquYPQsrpSfGkmUVU?=
 =?us-ascii?Q?Qgpxj0D30gmWJprXneoZQw5C8Pt+k8i8BRugZnpNMRJ9xqbTLrXSzPXcDWRV?=
 =?us-ascii?Q?6WNjbpjdC3bingFCy/g8I5eFaSYi75LcvVaBFrptU2sdlHq53kE8fL6qZ80r?=
 =?us-ascii?Q?u8YTbg6JJTlx52EqmnHr1SLkomVMse8SZmn887coR6bp5Sw84YExfI+NtJ/5?=
 =?us-ascii?Q?kuqPH/8bZcwvw3+M3UT26SbRvIi39kqsBIRdS/AcySIBXl4lwWrj25Cg6v+e?=
 =?us-ascii?Q?zoMbEUf4czq2ZJHUJrKOk0AJG2T9rxm7HDGIMrhE+/QATCB+2nNlOTEdRInS?=
 =?us-ascii?Q?bFP69kv43Tg5RbJNZbPMH+q/Mob5TvaWhB2gRkJ5NRTegQYHxns+51kaMihH?=
 =?us-ascii?Q?ZR4xog4ha8QPtIWc7j9w7LI8tFLFHJUG/cxBKl0wcGAb0jlBCWtK/1NRkOow?=
 =?us-ascii?Q?aE1ecx8ZfQ5g7ch4vEKdGjLm0eeiHm+bhrv0zT4yacRecJtM6f05N7nbbBmm?=
 =?us-ascii?Q?ruKgtas21/u9EUCQo9qNekTkiDo6CMsSQpQ727l6ekmcOdiouXD4ButyNwEo?=
 =?us-ascii?Q?Gt3XxyFFaRqf423mHanhASLfU9+uQgpHizizMdTwN4JHrroMmvpr8PZ2CrZN?=
 =?us-ascii?Q?XGac2gsd0iUHLxR5uwU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc0ba67-5c29-4c84-d8c3-08dde3ab49a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 07:44:57.0835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJOjMBa8o+s8mzL3325x3nKJc7773pCUCezxocVBf/H8XPWJFiAMw4hdL2lY6lXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

[Public]

(For the updated patch)

You may use BIT_ULL. That aside,

        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse.Zh=
ang
Sent: Monday, August 25, 2025 6:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix shift-out-of-bounds in amdgpu_debugfs_jpeg=
_sched_mask_set

Fix a UBSAN shift-out-of-bounds warning in amdgpu_debugfs_jpeg_sched_mask_s=
et
when the shift exponent reaches or exceeds 32 bits. The issue occurred beca=
use a 32-bit integer '1' was being shifted by up to 32 bits, which is undef=
ined behavior.

Replace '1' with '1ULL' to ensure 64-bit arithmetic, matching the u64 type =
of 'val' and preventing the shift overflow. This is consistent with the exi=
sting mask calculation that already uses 1ULL.

The error manifested as:
UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c:373:=
17
shift exponent 32 is too large for 32-bit type 'int'
v2: remove debug log

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_jpeg.c
index 5d5e9ee83a5d..88090adcb24b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -370,7 +370,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *dat=
a, u64 val)
        for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
                for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
                        ring =3D &adev->jpeg.inst[i].ring_dec[j];
-                       if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + =
j)))
+                       if (val & (1ULL << ((i * adev->jpeg.num_jpeg_rings)=
 + j)))
                                ring->sched.ready =3D true;
                        else
                                ring->sched.ready =3D false;
--
2.49.0

