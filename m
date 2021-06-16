Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC4BC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 13:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC23E61166
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 13:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC23E61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E04D6E135;
	Wed, 16 Jun 2021 13:29:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526A66E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 13:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob5P6FES4YboJojjXXYhtsBSVJZCNzuvyBkvo7e1yV1p6MetA4PVJAUTiJu+IV9pLy335m1g1fJUZzPqemDLb520CY4A6Tkdu+WUMh3vdlgfXztH4kXZmAL7q33/VEUDsWAo44HziNepJBsPH5UYvnXMZ+L8YGO0JSIk/4EcYDcLXTihpiaMOs54GAU/6RmvDc9qh16kPLEl99pZSai0zdOOZOqTGGPpJWpFPh28Ws28CbZxgtSJIHb2CUnTmTbwWcmhwdeOc7L0fKy4u/LvpS693xdY9s4ClB1NT2Nbocm5oHN95khoAom8aXkBKumzKnChR+CS7C14tcmXqWBBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3hhEeNOs4xgH/hEpHDc8krRWkYwpbw8ghNyfKgXr+Y=;
 b=d+r+rfotQQFWRFqkC8HbCyMxgXlk2iYYzG+yU/aSIfCcSNqPgK++y7Lgm3xKp/USFV7Mv2dFY2VfJywsFcxPRzAdsLGRa0/PsozjQAdNkHaKSmGAbjud4kwLSMpImUsMVHa8pHN/J6ggEOB01uX3Lk6I+/AIagCWGhy/hD00XCuagXGSlpuQ/aubwI/xj2ljSheaXm9yHuhstmtZaKv8x8QoggzYwm1bLD69CJe7jN/PzgAm8CCbBwFhxqzB/IbiCGFYXL0w6w0hD40DLWV1ZSOP6yBfObVdDfnXJc8rGXtbLdDt1ZUFpdIFG29j8DLpjR7WuXbJzL6i2t1nefIq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3hhEeNOs4xgH/hEpHDc8krRWkYwpbw8ghNyfKgXr+Y=;
 b=jYUd6kFJBikfviCi++e4yvE8Jj1Uu4h0kRsRDgUZJcx7hw4ggApe51HP3IY7eRCaYWu4fLpk0i7+Vw1tfOplDPPWqsew8eDOVaRwvukyUG7WyUmkLoiOpxxh2XRvq3i7zu4mtEZlViKqDeFbALNtmVvhLXLoALOAGb/79sSzUWA=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 13:29:22 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 13:29:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix bad address translation for
 sienna_cichlid
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix bad address translation for
 sienna_cichlid
Thread-Index: AQHXYrLEsY3aVJIsmk+7+Vbb0F3vWqsWobkg
Date: Wed, 16 Jun 2021 13:29:22 +0000
Message-ID: <BN9PR12MB5368C5F14E544980BF7A226BFC0F9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210616132309.14052-1-Stanley.Yang@amd.com>
In-Reply-To: <20210616132309.14052-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-16T13:29:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4f9983dc-2158-4e66-b6c8-4db3273c078c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5a604be-a699-436e-ef55-08d930cac0b7
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51616E38BD1024611175BB7EFC0F9@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AN9HzboFWoT+12TvW8kXW2+z9XBBHI+N0Weo+yBRS/wK+3jFL+cyUjDWMajnrDjcfv72515SdaX2wSI9+4DTtBHIGulSthbYRS51bbBDPL8e15ID6pRnkzaEKnKNpuoi/m2dpJdBqFRZk/aWpGPsG3oC2KaaL/m/vJfiS6594R6cNHqgkRfusrmMrhoy9y8khZ2MpQ5BHymjdimoW5vUaNk19kOmg2B2yLZKAjZFCAuba3GI2uQtxbLKJJ1OKafOtbrc3wwhcNyGjlEn+wqzGo/luLAq2ljHs/0Z4oO2rmize20powyAehurvRly9XE1yz7Yzo6MuUYk/u1TquPgqqHHP7B5x/0/v3LBcNH445GYBqAbPrwhPOtdIpk37/nRsWVBysrrTNSXEJet/Basu9A4VQyqbBJGx4WRZcWQsk+E0SGtHU5DS75x78JQPYRM9XnkrTDTH2dkFHZTo+eI5Z4HxlB7j4rhbsnPek0CRoAKqu4I82Uj8cDgW+IJs/vnJHtxZJnLcW5ZjkjBAhFMD2pILMtUqXoun/z2crTpxkI8Phas5bABrXfsZFMnzPpTnaE0XTsXCc3CUvbsB3G0aZnwWdWVsWTeN9F9XAX9N2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(8676002)(110136005)(8936002)(316002)(86362001)(83380400001)(186003)(26005)(38100700002)(122000001)(66476007)(55016002)(4326008)(76116006)(33656002)(6506007)(53546011)(5660300002)(66946007)(478600001)(2906002)(71200400001)(64756008)(9686003)(66446008)(52536014)(66556008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4+6KmT2kkZQ/ldc2QwqhtIjprPpljlDq+RztAh/5qV88ZYHieamILBJkQJgt?=
 =?us-ascii?Q?ZzeTjEeNXeY89lkX2sBXgft1Ax5RSYhSXptG5RoLG7SAcs5cGwxqhFWNdw4W?=
 =?us-ascii?Q?MDET2bz58DzrvjOW12WVHWPj97ouPAMia4QCpeeGA5vabI6fVr8ErwKqZY+w?=
 =?us-ascii?Q?fqaFv0p52C/cJlRk+OoKRgQqHknVeo2ljezRGnOuRQyhMUNGlfidwN/5L6Ih?=
 =?us-ascii?Q?3uYThuta1rE+9qa/lGStIm383fU3FRpuZf5J39zAOijQYbB8CHK8R5YbEuy9?=
 =?us-ascii?Q?/7bsy0vzHi7LSglvpzaFFnmfFCoKSr9h/sBRIgsC+rTeT1NDIYL4TAErG1gT?=
 =?us-ascii?Q?C8Iz3IzGw6ftjRHo1x5cZ2uwFUHtxhnMjMtbfNGSweBZ8p9+rX2rPseLOK/v?=
 =?us-ascii?Q?PscIzdP+JjDqakmsL23ZmRxVJoOy6b4+sqjDHgpfrdbZlXn2AzBYtY74SqCy?=
 =?us-ascii?Q?qLgKL78B0DHpUEIuyCt/DhNLoC7iib/ydUz2RTl/ckCOA4X3s8l+tAbTvYvn?=
 =?us-ascii?Q?2+wOD70+JEsRcvXWZDsJo9c1r8Jx5WuEv2HV1JRLN4FHIDqFhn2ILNrMNPEk?=
 =?us-ascii?Q?q8R2ueCRybt3z1HJ53JBB+PadVwJeNeCiFky3jVXbvNEvok7bJwKN+jsOZtY?=
 =?us-ascii?Q?KpHQv+39syeMbOGs7ZVSuVxQRql9Zd/iPCqfFZBLmGOd+BWaG51mrzoQXyZ8?=
 =?us-ascii?Q?vT524vZ5LhwAidAiwTpA0LKP/Zha78Cc7f1lgPSI/IIJsss/nge/X6kG6rvo?=
 =?us-ascii?Q?YTD/6yuZoepRYcj1ImnhPsrGPWMxW0H8PP7lOgxuvpq+UPfmT9I1IvOSXf5f?=
 =?us-ascii?Q?O7GgCFIabeRZqe6W5w6YR1z2AbQIc6sIcNQVeGgzJhTVH+kOmsDlgOrBXBb3?=
 =?us-ascii?Q?6LMY+0CSPjxLUOs5ly9MmOszmiG3ajvqMiJ6Q43tsEYC8xMeOXIklPEzBHls?=
 =?us-ascii?Q?udv1clPmXaYk4pbI8DSqR3PVmoSd4fwN2PN7rXHpgzxiCBFm09RqF8cSmZ/u?=
 =?us-ascii?Q?w4f4ivXFJrnDpRPlCz5xGkV8x5Akk5+cVnO/Bqndu8yMEEfv99bfHi1Qli3b?=
 =?us-ascii?Q?6KJ2Nzavdz8pmluGuYjGUtNm9eNZFb0QBqz2df0TbhkfgqaQHS6iVTno9kIn?=
 =?us-ascii?Q?a44ttv/FLaBYWqXXGCzvEZ5NjmMeLDEUlASUnCQzE6FBGq/sl7C3RQM2GaUQ?=
 =?us-ascii?Q?seppjBXDfpXAkUpiVYJqr8FQvzbjb8RJ/FlWCijFN+LhZQBXBE9ktDEMEk7r?=
 =?us-ascii?Q?6BpoIT4XDdJsFnWkElu46qqqnIikqndSBVakAsZNFmkdxfkZxOOEluOk9Eex?=
 =?us-ascii?Q?QaoNV+u9cnm79gg6JL8ew/Dh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a604be-a699-436e-ef55-08d930cac0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 13:29:22.3367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwTQfHQzBs2b5CF10xRLzS9UwX7BD0MqHi7xaVFQ9qFOExCOz3cdbP+9w4wjZEFO4l/q6mcz87wRXi7Z4qwGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Wednesday, June 16, 2021 21:23
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix bad address translation for sienna_cichlid

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index bbcccf53080d..e5a75fb788dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,6 +21,11 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 
+/*
+ * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
+ * is the index of 4KB block
+ */
+#define ADDR_OF_4KB_BLOCK(addr)			(((addr) & ~0xffULL) << 4)
 /*
  * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
  * is the index of 8KB block
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 89d20adfa001..af59a35788e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -234,7 +234,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		err_addr &= ~((0x1ULL << lsb) - 1);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
