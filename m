Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5C4C61DD3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 01:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DFD10E02D;
	Fri,  4 Sep 2026 01:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bAlrE3je";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEBA10E02D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 01:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1N5G46RTKuDIsRmufkEQfbZwxHRn3mq7vQ/NvvbIpIUJsOGQyDzAzDwJC8UKxwfCVDyQYwF1ft4K1m1yc5KXbFF1mXmi+DF1lwzulZIOtObH2C6E+iaR9UTLfXTr7+srYgaSuDTThzuShImvmclLT/E+Ms0X/aB5zv4yK7XV/AhtCLSaBP59JAJS+EKtpNDspdD3nBCVCKTs46Oz9F/BZ4PSqlEcgcs5THhFg/Z6vEOIUV/Dxm4BcK6GkFS32g7f9qaFH4U+6h/pgdcqd9xaWpEZMxZgJ4+Zj3raAKFtWLZG8chAMESaw+mG3pgmoD27dcdgmL0lpvUUynrQbtxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=RDA4lccgqts8OFvqJM1dLFGZq2Fo0yF1Ln3IiVtofMKVxlb1tWOJAf0RvT9W+SMXQj+wJmfIqbuzTCwq4W323/SJTB5C3GQRn1D54/TfJX0mot4qT8rcsgcR9nIxAeL1WYd+bwEuOBu34LE+t4q+J0kphHZ/Y6SNdJ5WuwcSLSFRqCaLjySYqVNruiNhYRS3HM1O1BHiWquGhKp8cL55omH+JCsM/dh33EZqIAAQMzmTJ3A8vI+x7CjVif4hw0n7dEdA2wM7TXm9vqMDJte4ABql8HhiR4UuNmsh+hsvNl5+uUDuRbAmynKVumLSY2SMiqyrz7JhHoi0v4SbCD1QCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfkT+iZFPy6SithgCekb1JWFrGbSvSt3fgjnLOdz16w=;
 b=bAlrE3jejHFeenhdxcQ55Dgqksxtn+L1/QjinsQBrzg/89SiPAvWLUtPJMztG6k5spQ8q+OT0VeO9ipYMdRToJSICE8grfuy+ExY839/yP5E1T39UHgNle0IVjvzj6ODEcs3xuPq5pW5ny7jArr01uXaSED2Hrr7Rg0j/TNL4OU=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 01:27:13 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::5e) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 01:27:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 01:27:13 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 20:27:11 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: reprogram MCA settings after reset
Date: Fri, 4 Sep 2026 09:26:46 +0800
Message-ID: <20260904012646.672538-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f6f2fe-004d-4f3d-8445-08df0a23a5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|11063799006|10086099003|10067099003|56012099006|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: MO7c/mrIztWob1bcmlOy4vYGXnpxhzS6GHrQxNNEWvvdMnXwuHCN70kBJh63dKxHKk09ZxDb6oZ2DHhpZM4wUXKvA52aHQq2sTwEUJG945POzQa6DoL3738XSn0y9zseOJDvoaFIiUXlv/WCiu+QXmYF6qTe5epFAsWOlmoW1RfyoHTw0M6wn0plzL6gwEEO/4Qb5Mge9Fbg2u90grzkKgTzLhrmYV8NjuHJVxuE7s52pziK03Gx+AfDeuW6yh+fPIPm33aCRFpTENGYSX9DxV6RBlURh061o2VTbPclUOo36Iu5luKr1c6FrY87tvmK7L2b/6p81BNiVu+aGrYOr8PJ+sOABEBDe9cShziPYL4wDFKsV5Dh2diK6Y6a7vRoh7WsbpTceGQh5Dg5qXuhCHm9YtYHbytiQjzUkd4E9VxlRIJPtu/N2sAET7RSw7CfZ7Z6cukjZBMSWH3a72McDTMPGFxgNNT0wh7kO77/A2m2DbCNyrPsZB7dfxXFCE3B89W5Q49tQe56TwnnfkDQEumPVuYScr+QjzZvUSFyGMEhlsFl7VKVG/1Oqe+518GPBr4Wnt51Kib8EuUZhYwqPVT0k3jp865yvKpTfY0YfWMA1aVLVxBRPF7VK6Qu/naUw6bNL7AOlVZppCn8OBcLBPtnYIdl62oVUmjUzhn7HDDTOnMxQ3i/9V8W30ii+mELcCToi5agoJ39Gjsf5spOlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(11063799006)(10086099003)(10067099003)(56012099006)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lflGBEF7Kn6hqfRaKhe3+lFQAPJAVsuFfugzHZSqOmXnuCsh0S2Zk9jDGHbfL8O1wK1XLHnmjJuW8LxhXgYGR3TEJPbs37apnRV+y6C5jvmhKKzIB0HTzDwJ6uicuI6d6tlZH5F1nLc4BXe+TVtV3LdmQPo8h0myedkHFVhqHTchEmhJbXnrWGdnVGctcEssZVaDKZ/rTSYqZpE3bsXxCckhVzzm+Nth54JqxzDwV75qhd89LGiGq7Y0J9PypUIeYo9DP4Uc0Xwse0jIqw3Gqlcb5w+M+qcUQCCoJPe8ojZdmznbAQzw8vVc6D36dxSXcI222+bOL+eB2CBPZ70McXs1JhboFYWhU01ouir+270wMzu5PB6/WJf9yYU7VAQu4ve5pPZLASZB91uTSoup/ibGJVeTa3fGqCaGgGBdTBaVMkJMZI4wew8L/NKrYvS0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 01:27:13.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f6f2fe-004d-4f3d-8445-08df0a23a5c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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

When the driver is loaded on a device that still needs a hive reset,
the RAS IP hw_init is deferred to amdgpu_ras_mgr_resume_after_reset().
The MCA configuration is sent to PMFW from amdgpu_ras_late_init(),
which runs during the reset while RAS is not ready yet, so the request
is dropped and CE polling stays disabled. Correctable errors are then
never harvested and only show up on the next driver load.

Re-apply the current debug mode once hw_init has completed.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..f550e83f2b96 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -483,6 +483,7 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
 	struct amdgpu_ip_block *ip_block;
+	int ret;
 
 	if (!con || !con->uniras_enabled)
 		return 0;
@@ -497,7 +498,12 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
 	if (!ip_block)
 		return -EINVAL;
 
-	return amdgpu_ras_mgr_hw_init(ip_block);
+	ret = amdgpu_ras_mgr_hw_init(ip_block);
+	if (ret)
+		return ret;
+
+	/* amdgpu_ras_late_init() runs before RAS is ready on this path */
+	return amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
 }
 
 struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
-- 
2.34.1

