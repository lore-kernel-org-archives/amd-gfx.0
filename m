Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D380C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E19061445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E19061445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557D26EC84;
	Thu, 29 Apr 2021 06:25:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129F46EC84
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFJvL5+dJ7eKoCUJfJRNhPit/eqmMnhF0GpEEwQDdqyYxvtEJOvdIIJcknYPhkkUOhgiexb8EP3OEM/geIEvC0Mu9ez2pZFdq6zz2p5mSoo3j0rYlyt5UULnFrsx2PGQisIBpL0Gm3zmtvBbkWGksnLGoaX6HfqCSNkww0+lzZDYdnekO09xXl10KMFXddX+GUOxreXCLnPPLRCCgnStGIdy2nQlPC4gmQuxoiBRGrOgiUrO8KHREzO9/Mu1r78C4QPN55SnyV2IRv2bpJupSXidn3CzcpuQt6KDYXuCT6M6dYRWxG5XRN7NzydfxXf/ASeGYKpmtEE2gM52icgsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBhFLlO2yzeUBI8QSHf6v5wuEabrI3ApDOIdt6emz6A=;
 b=GldUxiUFav5wWBqeNIXNXRaVY5SWOrZ4eawxHJAMM5pnhMxWL26o+ZOEzt4PItuhQuhvj/unlqWVptPEn81ULs3hCEWW1BmPuks14OkaaSUtN7qtKkCNnoDFJvcqKg2UySxYGlQuo1okenr6UU83J0BY8IHWsfdGnj/VwDklXDUgjL6u8l/GQ6UxCGRZvwO5VzboX7vkaMkHgAyIGAJyo6SHor5Onpg2JNvRm0evwk+Ea90+O1SlQI4lItxKeSqUFHBFrEH2AKZ2uxVXfqtc9Obx9+kbHH9lJF3RFdujp1KSI0n5UpGyBoaF/FLdcVz3jpybknLWSOlAmKserVBcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBhFLlO2yzeUBI8QSHf6v5wuEabrI3ApDOIdt6emz6A=;
 b=bAyEXrTpsxZomPPQRCZUcu7onOtqnZUI89FQvLFjYxvbnog5pV6x+FTp708MOoyzVYm/GJzo8XU9+/H9LnmJJ8E7Q6jEy0yLhu0+a4fCvyIi5pVJKID/BcDm2IVe5Nteq+Yp9tWRxC+cYLvb0X5xTPJ/pnk8V1lLfiSFG9188VU=
Received: from BN6PR12CA0048.namprd12.prod.outlook.com (2603:10b6:405:70::34)
 by BYAPR12MB3110.namprd12.prod.outlook.com (2603:10b6:a03:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:25:53 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::ee) by BN6PR12CA0048.outlook.office365.com
 (2603:10b6:405:70::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 06:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:25:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:25:53 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:25:51 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: add hdp ras structures
Date: Thu, 29 Apr 2021 14:25:40 +0800
Message-ID: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52c1add5-20fc-49c4-ea36-08d90ad7a40a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3110:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3110BB14894640BA0A3B85ADFC5F9@BYAPR12MB3110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDeturSIu+wkRLeCXR6e+7Qw/dJW8nqU9FsassJu0z5ZSn+Sbo+TOVH3NSBiiBGxORL8CSHyKYxDKpAOgls69FLYYQPHampk1brKI5tGYYIE58ToI16MfhaMdNywNFjSvQm33Fbtd+eDOhp+7CyVZQEIyBb1tBezxVM/0LJgAXFIwZskpsgefB2a04oa4iGjwno8GNJlVdUqNYbRuSBKOKkBRRGSR5/2HyqScmhcTNWebjqncTm2lZ+C2C64NakX47Ml4uZakZ6epb3FR7sE/xmPuT72/BoUBW2ZxsfA4HSDMcq1KWN2XqhS6KmHZcsT1Xg+54dapseMjR22OONCkgTZne9UAV9QTQcCND4372EuFt891bVWlVceZNKi5Q5ilZfq0x1HJp1lYk0oUkW/wwAbxJTSyjzzihJk9tdA1cE3n2hMeoGIUp1KcyUxWxK7lWY9wUcMvAD5bAFH6S9gDFu/ZTbV9UylMRbKJmX/8jH7GQOnA8MdkaIWuAJaYjE80cGA0OwWiildljkbV9rq6zvWdfKpyH1hDBpbsnNHpeod4Bm2NnJ+Rzgd7lrAoshyF1TTGfPaE/v4KrDSFK+fT212/3Cgw7EA3aW1bjgOS0BAmvA/s3HNGSl4X8aZ8bUYSY8zdboI5IxWcN2XQ0o6s/f8l5UwzUAix+XzcV84dWNE5WN4v7//oxo8MZ/bFTbF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(6666004)(26005)(70206006)(356005)(86362001)(7696005)(8676002)(2906002)(110136005)(5660300002)(83380400001)(336012)(8936002)(70586007)(82310400003)(36756003)(426003)(36860700001)(4326008)(2616005)(316002)(82740400003)(81166007)(186003)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:25:53.5631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c1add5-20fc-49c4-ea36-08d90ad7a40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3110
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

centralize all hdp ras operation to ras_funcs

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 43caf9f..c89cf8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -23,6 +23,14 @@
 #ifndef __AMDGPU_HDP_H__
 #define __AMDGPU_HDP_H__
 
+struct amdgpu_hdp_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	void (*query_ras_error_count)(struct amdgpu_device *adev,
+				      void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+};
+
 struct amdgpu_hdp_funcs {
 	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
@@ -34,7 +42,9 @@ struct amdgpu_hdp_funcs {
 };
 
 struct amdgpu_hdp {
+	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
+	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
 };
 
 #endif /* __AMDGPU_HDP_H__ */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
