Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33AC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797D6208C3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Us7snre5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797D6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F222B6E08A;
	Thu, 22 Oct 2020 03:04:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B826E08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkw/sRwwAbdVJL5dnCSADV58ytSt22Bt994zdZjIl78vx5dIbyFq7zFI2PKSnePptbHV/gN3iMPKEP4ffCfnLcA4TKlvIe2F/aX/fI4j5jSIw1190Trswh3t9sKzH0Yc+4tA9vXhBTnITWFqCOOASE74vk38dhxxYb05vEYbDlscxaQa8oopl7/tAu4pqkImWa2uvcLy5Ek3WrmVVZBkvN9DIWVFY4F9CkFB/7/QrTjYlihtJQ3uP2wtniSA6qSpqh3+A8+MjxUioEMdupZslH8r640xUymAae9vQcqJkvK01ekQW3mEjrpEyJq3EFitpB+jtnzCK74XnZFn4QmiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvtZEsI+vpndefqNKyoeyPDaQNYHaZl/2PMsmdFqzIA=;
 b=YQLd8WlapNOXr74b4Cao4ajt5Jgqf32zjr5qNWhTe5mSynXEDxT3bTp43Rjdh0MbRJcwx4PLnTdycYyQbiIZYB6JR4CDxlzg01lxDaMDwgMIrDyoRq2YYqi6zJ8yvpdD/cDbSujuIbRJuSV4zxUK0UUGxZN5s/9o1Iiz11lQUNNTSBDUWRaEp27lYqRpSSa/h2jRfq1+SugdtM2mBSdVC/F87XxwHH9OM9Rn2q4kkyXcDwjDuHKuWGI6evXFlUQztrQnkaqlvxA/vTc//RaNwuxatdbeSZQxtJSe6MTLKhZjVy+f5WkZ3wMCZU0mywvtaerYHy2xLLYR/nb0I3GjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvtZEsI+vpndefqNKyoeyPDaQNYHaZl/2PMsmdFqzIA=;
 b=Us7snre5Lc4DgIBFxG9mx1zDQyh2TMKawYyHtZGSoOpY95yCiiHEbgPFt3q5wu7KWZTKlttoX7qJRADwfEBD8bmlJK/OwpJILtlHr/mQ3IO43GybGjnbVo8E587x8UwJqTgGcIGyaHdQcWigigZyJNyAXcuXMhtFku5Yy0S6rx0=
Received: from CO2PR04CA0194.namprd04.prod.outlook.com (2603:10b6:104:5::24)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 03:04:44 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::b3) by CO2PR04CA0194.outlook.office365.com
 (2603:10b6:104:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 03:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 03:04:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 22:04:42 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 22:04:40 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: disable VCN for navi10 blockchain SKU
Date: Thu, 22 Oct 2020 11:04:32 +0800
Message-ID: <20201022030432.4011-3-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022030432.4011-1-tianci.yin@amd.com>
References: <20201022030432.4011-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec15fb91-5850-488e-b930-08d8763739a8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4269:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42695778F673A942840AA5A7951D0@MN2PR12MB4269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSojkGHuOiXWSekqYoOupueeYApD4amPJR2hK2EkU82bFz2vk3waFW/vuzXbFvzUB5Wqi0jEr+0YnoSTWUC1x3O/YRW+A7VqlqUZlnPLq+uwJDgNlI/Qb1t9i8sTIppbMjkFtHNz6aufg4QcgTSEK4rTih0xrpI8DgmwkW4KEwXYvD+dtySI2sNZp6Bh1VPJdbIRIJ2BdjYJfgsqVit9Al1TeFJKK69+ZZMV3hBAIpvCDEa4ugYblv8AOoMQaf1lzmFD4iJqjPLygTyh5GNZxAFUT5H1m/q7Yvx23S0a943XZ5VxrNsUz3ohLlRb1TcUGjRZErE8xLkxoaOzmjrtGtEiVFHPErT2c5d82ZFNmcohJUn4gVbz7zU2HcRSphADYZAg06I/MjJulBjU3uPcVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(82310400003)(4326008)(2616005)(70586007)(86362001)(44832011)(6666004)(81166007)(356005)(336012)(426003)(8676002)(54906003)(8936002)(7696005)(1076003)(316002)(2906002)(70206006)(82740400003)(36756003)(478600001)(83380400001)(47076004)(5660300002)(26005)(6916009)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 03:04:43.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec15fb91-5850-488e-b930-08d8763739a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The blockchain SKU has no VCN support, remove it.

Change-Id: I26fbdabdf67aada24c5aebef999ee8b5f9c0bfe2
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ce787489aaeb..bf28d7547237 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -538,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		if (!amdgpu_device_asic_is_blockchain_sku(adev->pdev))
+			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
