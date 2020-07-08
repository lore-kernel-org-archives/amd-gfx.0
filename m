Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA798C433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F2720774
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VqsiTzUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F2720774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5E26E857;
	Wed,  8 Jul 2020 05:29:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A536E857
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 05:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNtRx0ukyorFD2R1GQUBI+yhB/uiug49N2eai4M3w7eL+Qv/kqZJdtJjoC38aO1SOIJBAns5ecn+I41B7U9Tm1GshJsSTLaIndQAB3IZ45w59Wd7HOTdoeej2h7vDbeILwBlASNa4CQ2hcVAlwJBHpqy6+UE5kLSrbo8NkfmdN6qTExPDTgvAxFCMdnI+k+TATxq1ySccH1Y2W4RUJ6rthwVlPPAyuAmbua7vLz8T7HdKu1+QpRuPlVVVBtqgO9/Lm2iN99ZxYdxHJeXP+pqm4sAPt5EVXWbNL+yCu8+bvc/aGq/UxUFQwADRTUGQFZ49zzwFCwEzc5eMYiMTis6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCL9oD9P/hOQvGfEi0qkbVaT10h1cY09ihV0FeSItOA=;
 b=Fs2nchTW2rLwVXtjHBLd/bl1Wn6YrLTYLW2TQeDDpxoDJzKemuLuUTeD3a1DL5U1jXi6nApdfZH5ex2K4qeAhv4i0inYtM6H0JCijLEfefIPOAfW04ubVYdjuxEAhzefVRBMFz14A1Jp6iGdasR4XhAtcyD6zXcPAM9vEE7yRfr7V4nTBjQlV40/W90jNWRmmQcA3OhiYfVoESgsLSU9SxnH7DJdKw6aqChQbJOfWgx5YOQ/Wsky3h6JSRijRwrZ8NxWIWXZT+B+Mj4Z5teMnTcFALJg+LZtdZ1O3xgEWf/xXfy4pDTlktslZYWFysE2+OljkF8vLLRRo/R2APdmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCL9oD9P/hOQvGfEi0qkbVaT10h1cY09ihV0FeSItOA=;
 b=VqsiTzUYVCuNDuoYc5FlUznIe5MIlPsTTgwAw9sMdl4/5YLhQ/9H2zXOg5JqN6D6J6VgVInYpdayzKd5V5cGSOlV1dU7D4fqXD1ZxWQsZAF76teADnP02S+1WSPhKxbSax5afP1pbmIpupVt+39QnLcPm7KoqOEO6UKRi+4Hagk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Wed, 8 Jul 2020 05:29:37 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 05:29:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary logic of ASIC check
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary logic of ASIC check
Thread-Index: AQHWVOgHptaLvzRdLEmxg8TKGsyEuaj9J5mg
Date: Wed, 8 Jul 2020 05:29:37 +0000
Message-ID: <DM6PR12MB407597406312C889CBA9CC89FC670@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200708052354.3007296-1-likun.gao@amd.com>
In-Reply-To: <20200708052354.3007296-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-08T05:29:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=918b4b77-b95c-423c-b0e3-0000af58d92a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-08T05:29:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e09a54e7-ef0e-4553-b566-000076b86b1a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-08T05:29:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d523a2d6-f281-4629-ab7c-000093de049d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81280bd7-f8a3-404c-2447-08d822ffe7bb
x-ms-traffictypediagnostic: DM6PR12MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4516039BE7D672F60772E0D6FC670@DM6PR12MB4516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KQu23NK3611KQwv66qnnyJzB0ynGemnxSoyaW4iiZajDHego+xH0W2uGfzdXuiL3xGpLxjN14UA4P5nHXNRF3MhOPdy5/zSrl0NJXN63qeKdizs4B+0LwJv3tccIJBK0IBps84OnCviaB8EQk1Ew+EU7243Wf7CdWlhBd4fx7Jc25kK/i4zZGgx7VxeaLV0CApJIZY/Urxk2oDXLHSycy3lvMkoNO4uh/jpUCydxx+LYZ8WA2Cy10tzf0byABqU3gyEwrNpcgvTzO7UwF5Bfidq3w7LWHF++raguBNut9+IszOsUnnbRiZmxwKJCbHFD4QwPtiL6869/BmaWCTO8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(7696005)(8676002)(316002)(52536014)(55016002)(9686003)(8936002)(26005)(110136005)(71200400001)(186003)(53546011)(64756008)(66446008)(478600001)(5660300002)(66556008)(83380400001)(76116006)(86362001)(66476007)(66946007)(2906002)(33656002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ThkLNWNf0Dvp0YtGSKZ6/LSN0BoRq2n7pfxXCQmC1qX6DTpzOPjwacl8N2V6PkIJdvA4HPdEUDwn8YjWLKllwMLYPh3C7JjG+68ogFygXRLwtu+ZYuTJLkse9SjYRNqvE24d+TP8D7KA1qbyy1qufleajnhBmwTIbnzKzhTR/UWiXjEfCmynLV9GDLk81V/QMJLCDCg2G4vloIuCr+sAd3fQTlyV5BTa2hLzDL953YdEaS0rDk9+Aa5HWVqoDXZg+Q5ZxEhbbTjjwBxaHUCGcrAJQUf3QrOOih3rauW/G7nnSLPvP1sf2V9hBjBELZZKsfglTpxIYp5y/VY2kxhOcDfG/AhQ41ItMu9mbpV2mlYUQQxm/Ql44rsqivYtDpvMzMaIbvjyzY90Ct849SG0zVKeVSIY980SwnvLqt9mSix+BlnNOrkoyScL8wDNcoVs3DAK5U9IrFp8XV5xsgei25JEws90U79BDUZjgMHN/7jCwCgedoSq18VDuMSmEL5j
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81280bd7-f8a3-404c-2447-08d822ffe7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 05:29:37.1536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do+YNwY9HOm0bj4HZAU3EDow3PabQpVNnSYlQ0Sq657vHK9RWgS3uGqxrtJxlJXB41F6PcoumK5Z58uigFG1oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Wednesday, July 8, 2020 13:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary logic of ASIC check

From: Likun Gao <Likun.Gao@amd.com>

Remove some unused ASIC check logic.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ief8bcb77392294b180473754e669b9e460a04826
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ----  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 7 +------  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 +--
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b8b4cff20013..58221bea377a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7687,10 +7687,6 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if (adev->pdev->device == 0x50)
-		int_sel = false;
-
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ | diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1baeddf2f1e6..203a0e9c5999 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -508,8 +508,7 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
@@ -887,10 +886,6 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 		r = sdma_v5_0_load_microcode(adev);
 		if (r)
 			return r;
-
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1 && adev->pdev->device == 0x4d)
-			msleep(1000);
 	}
 
 	/* unhalt the MEs */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4dbc11907bc6..8142fc07f5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -440,8 +440,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
-	/* Interrupt not work fine on GFX10.1 model yet. Use fallback instead */
-	if ((flags & AMDGPU_FENCE_FLAG_INT) && adev->pdev->device != 0x50) {
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* generate an interrupt */
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
 		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
