Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A767BC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 20:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AF710EDBC;
	Wed, 20 Mar 2024 20:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVfRVXs4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9F110F1C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 20:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZOGjJp8AuQXyWIPSEEtDAK8DJ2bVly9SVBmUKPBrUmLxXsHQbJ884kbmoEnlhIX2XhPXzR2cm7MFHUP16LUjgN6m2voJoBSp+DB/ov2eMf3zigkQo5SfUC3r9+hkw12lsDTJl1cjjh5AvwfPLv4jCEf8ECJnLZP7sVTmM9MVlh9mpj1HEFBKWqnM71Pvk7NvozFU4QMTsUL1DkmDkgUSzuB7Wc5QzoFR8ZFUdgAj0vOcaDqjE9Jr02+NzGyi3ItciEHwt9cf21Z48T+zQ848V7ElR2N8wz2dTTg/xjvPizr2CuykuwceTkcqXnpkWZEky5y3yHu5DLiV+lnBqFNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRMi0dSU0FduUKVrHmD4kF8YC/KhW01mMn6EOahMzqY=;
 b=mn2uap/06cehfCHsY9mPnVn1AKTefeRVaBvWJwwEx/qHPDMCCjFqZFANjUvZ8SRgL1TToyhdxH3VN1Ests6segJYkU7pV4Srk9F5/E7RuWv6xIs5PpI3KYIPP4Gq6JNMCRxIOkhN0hsNlbmyPu7EIkysHFD3iXg9BqrpwQm88gg2KhGLTXqyY798Xruq4Gw22P/hIc/0SCiviuMszjizZbCEvxBZLc8bEdvoPp0JiJcD4vDqKmSswMPmzRDUsUY/TnDONE/oA59+yZORj25BGvdXe6Ab8bROYPAzcGS9ZwsDg0JRm2eNIY3t714n6BiZm6GhCnatOZid/UkfKXNRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRMi0dSU0FduUKVrHmD4kF8YC/KhW01mMn6EOahMzqY=;
 b=NVfRVXs4kaoI8xumCFfZeRVrrsaK+d+8liuNlEYmlHVzhy2/w1WduGaTmDffyyMN7unp6hUkDpojIbqBEJgaT82uodGkkxMPxXVXNQCq6u7nCPiqn99gPy1Zqie9plcYALBwdVEt6obU0n3BBxoSAQ7AZmF2AgXa6Kcrb7SPXXE=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 20:25:17 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::90) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 20:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 20:25:16 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 15:25:15 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix TLB flush after unmap for GFX9.4.2
Date: Wed, 20 Mar 2024 16:24:59 -0400
Message-ID: <20240320202459.188554-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1756fefa-20cd-4db1-ee84-08dc491bdb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwDnBVg4KzPZs2MTMDftQajlu8/UdsHdYyF718DHLP8Hia+HY7hdC8ixgfFkc4Sg2DJ33lROYhAYcgBfeOH6TwUDrW2iFZRRJhMl00JJJjHDLUH4tcD1Tz9mAehEuDFmnrCnu24U8IktjN+SoXa4uwEekmTvCnZ8AJ1wcy1258TmMTWJMswoIenoiPFVGUY64tvqkGE0bjzM4W8DbUXuA2wqT6FYe68krzsnl9Eg+G82bCFuCOlBRIMpRpP6ZOO4SMimAHxm/SQPYWkeEGDLDjCc6fVJMRQIlxsoOiteiTJID/YZZ1y4LiWQ2Hj2EMltA1ZdPnopOw0uv0z7gUssIWriF+ZM10C10A3DDDJ/g4FVuVQfBx2Tw/z27pIXK6UdXwFu3ycjFICotjHxXxucd8XIi3RNcq5sXcad1B2mBieQ45DVhC138Umh32D26k2E06doWmsw0KGGN6dobxewHJyFz/nZRhgCrpnfNBNgq6vAJhNSi/oMeY1w6qagoZCz+Kl5IN9h5w8wJBH7zRqH9CZpwaRw+pXd8Wt1lmzCzApdYsptzltEFyyEMnL1jm+Ar8FVvnl8LjyOYreCDGB1jEpXfr0ExfJP3xxkUQ0GUhno27Jmqzk1O+Cw9YJbnDP5a2almmPoqko+BSsuX3InGatOTl2GKYTQ5HKBlCbugGHX4s6R53QwsvA5qrY9IYOelGV5lGD8QK/gFGX2ES1DT1ZbDPnxQxWbNe5JqEZWVm2fU8X4XeuvvdjePyLSQWeQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 20:25:16.9746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1756fefa-20cd-4db1-ee84-08dc491bdb42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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

TLB flush after unmap accidentially was removed on
gfx9.4.2. It is to add it back.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 42d40560cd30..a81ef232fdef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1473,7 +1473,7 @@ static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 {
-	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
+	return KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
-- 
2.34.1

