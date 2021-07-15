Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D3C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DD86120A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DD86120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801DC6E598;
	Thu, 15 Jul 2021 08:25:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0781C6E595
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 08:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2wOmQwlAy8H4lCKc2L1FQOtJ6UzK3JC2DiyEQjVzRiVgA6ND0ZqyupHOcsm7lDZdlWLzi5WanHBMLPW8Es5pd5eKet07oADw9eiZ8tRE7ZzR3DWQWAU6vqx9iBVwSTezG4eqF/o4YbfFkgkB1pPFjIYqfQHTyhtB/I8FCnUhjtisVxlPL+vnCuFl+6YHZz6tYmMdD9IHnQOd9EDqT1Pm4TpNR278SLGHkJLwdWmFZAiRQ4D3QtieH6bsWuOANVFxKvX3XtCG8x6HvPy3NCcgY+wX1zoh/riLztgXB9x4Ed39A5egt2A9DXm3/VZ2uC59EFX0KTrZhP2sQWYI/LYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTMLeBrmP+QaoPIZM4jwAmmh+MV6NbcXuIOe5qK8gO4=;
 b=VtRbq18uMNl5cuYy4dDRFvEiqQGCM2QOz3R0XtslF1CYZ2rGyekQFKULp2QRvRJ7jTgIA+lSmdpmUv/GkmC1eL+YOF8VE1WJYbJN1eypsgqSzX8LXAwfquwMbDvEjq/zVGaVuwgxU/HTbbQgrHl0qkbYrNiE2D/GFSDLDIo5xlFeqBoy2m6j7LA+TGTMzuXwxKQPz8xFsUQwA23EBUWdmu1vvdkyAqCjwaeDUPrt/Esfs61+gLFYQxzOmeltPOxAfBhfC6ymhb4+jyo6U5noxfipMCY0R74RxhsiQ5nNnMJkgC628+KR5OJsPj+wukOnoOTfKgt09XYt/P8MRWi45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTMLeBrmP+QaoPIZM4jwAmmh+MV6NbcXuIOe5qK8gO4=;
 b=VmsGt58U5wQ+nNt8kXyWsRglXoTU20lT5iX7JoMSXN4NpWf4ahYSyKP4Rw1uKLnq9hq8R73ivWimRTVIXUuDyyU1pc1MzSY2StSOTreySTIihxyci3O3HnHBygAsAr6UbXYwPP8+WK5b+l8bflYPYKu0rR5r4goxflI3M86D654=
Received: from MW4PR03CA0261.namprd03.prod.outlook.com (2603:10b6:303:b4::26)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 08:25:00 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::6e) by MW4PR03CA0261.outlook.office365.com
 (2603:10b6:303:b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 08:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:24:59 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 03:24:56 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 2/3] drm/amdgpu/ttm: replace duplicate code with exiting
 function
Date: Thu, 15 Jul 2021 16:24:38 +0800
Message-ID: <20210715082439.678512-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715082439.678512-1-kevin1.wang@amd.com>
References: <20210715082439.678512-1-kevin1.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a01edb5d-104d-4bc3-5278-08d9476a0916
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44040E6DC46E14F1ED45FFE3A2129@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMNKEm9KvN0iZVekDt0lR0TTlfUmAxb1+O4smlSKZi8KQ/kLt0XDbh2Sv2qIJs9FHx8HuAetGzJ3MYuetjkkP7OIBjYA1Cls9va+GrAjolBSXHYI4SaT3zl29/gXCd++zZ+3CUNGxnl5My/MnqCaUyyxY1hWXrtRnHkas1qK2B2F+SWVmtApGh1A5IdtuNOpvQhKcn3/zhRgvFlRZkGhKo0UYXla0ZIeME4LHN867xPW9CBsJspM5u28i+TbcwrFjgJ5K2wtM6Y6SdfrsLZkZzLeGILw5eM4MRllwmhdaO+wVag3ndHvGhnBOht8PdkfRV8v1iz2iFvhcAj0IKjJjAngB3VkoP+be7as8I26SGOWW6hXUqFqscMv/HiVWHbqPj4bHNqATTPCku1bD8411SIuYPI/PXTcGc9nos/o76df4C7KSpt8cezxve3Pt0XKpIg21d3pZSLXkjLmWtOhAY8rQQk5gTAdUQ8qwJGvfZ06m8ZiUkvyipRiuRUAwdvrH8+RuIb182+1ZWzqJ98FyzGgeDOHQwlWk6/uHfS9YKRQRljy58Idgs7cim2rxnKfdWj7JLLhSfxkJejdP7kQEZNueXejyy0wMPukR13+H1wP2+vGd4zScXrsCwMlryCPBtvSVwohdZrpZ42FYahuPRCGmgg/bCLJHlyQW+EbCj652mknDNYoojxW4OHBda5kKzGhD083lBp7e1S08K6qWXdIfL9Qlj2Iq4zpF9mSLhE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(70206006)(70586007)(82740400003)(426003)(2616005)(36860700001)(336012)(6916009)(186003)(478600001)(54906003)(16526019)(86362001)(82310400003)(2906002)(26005)(316002)(4326008)(7696005)(8676002)(8936002)(356005)(83380400001)(81166007)(47076005)(6666004)(1076003)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:24:59.2530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01edb5d-104d-4bc3-5278-08d9476a0916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: Kevin
 Wang <kevin1.wang@amd.com>, lijo.lazar@amd.com, alexander.deucher@amd.com,
 frank.min@amd.com, christian.koenig@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

using exiting function to replace duplicate code blocks in
amdgpu_ttm_vram_write().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2aa2eb5de37a..2c98e4345ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2207,7 +2207,6 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		return -ENXIO;
 
 	while (size) {
-		unsigned long flags;
 		uint32_t value;
 
 		if (*pos >= adev->gmc.mc_vram_size)
@@ -2217,11 +2216,7 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 		if (r)
 			return r;
 
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
-		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
-		WREG32_NO_KIQ(mmMM_DATA, value);
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+		amdgpu_device_vram_access(adev, *pos, &value, 4, true);
 
 		result += 4;
 		buf += 4;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
