Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1847C54E5C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3564A113804;
	Fri,  8 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z2ahwZh5";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BA3113804
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgFHeoy0DlZLizCJ73O5W2KzC5qI21xBJlVyGuWAqE9IlnZerAf0H8lSA1HTswQGOySm5fVBWYfyqc1C1Ji2y3p+4cU27ts5WFLMqD/0lutax/l1BMFR8b0oHBi2zfQt5ZqOXqh6QgaeXhHpzZ0WC6VtDxwTo1fxx78ta4RMEpS40ft7pR5jj5YcKoxtpy3IMrQWPmHImCLRWGqne9teDNHyeQ6xSD06KSSforEbMfgBGfpdbDhAwCbZZRCdMR1rTXEjHVruHAlVUkbUKjAh0lOG9Mg40jkuufXLy+dz8niMluQRYSQY9NwjJJf0sWPjvq34SygCTNwnC3B5+DQJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCntJsl2aI+/GCYtp2rmrqfVCUTanBREIBJ0TUAYpHk=;
 b=mNh1ml6rrTlG/WCO/bruSK+hAi+nUhW0BiesaYNmfjsmtsR7D89exVj4Cqe26eFkpErSdOXiWHcGuDYzs3ygH5O/GgKZDD+69qOa8+CXQjA+7worG6bbVtdr7f6CkRQFKgsuGBsDX0kGjtgk0Jp5FX8FuYSbKCILnFwODhkL4ZiUM7RF6wBbUApYrnIfEOCgC5zsCcCmNJaXxC+GpoViwbLhMYta3aJ23esfatYE4za4CiVN321wwb8bQ5qb71ZqcP1sPodHRjdJ2gXBi7oxL/4r/6VyeSU+BkGSNPR8efn4hlpOl7ltWmMt/apjzYJwzaKln8n+X9I3EeLiPFIXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCntJsl2aI+/GCYtp2rmrqfVCUTanBREIBJ0TUAYpHk=;
 b=z2ahwZh5OqvBD1Jfxp9xP5hgkqyQvj2nB+7XAQjMkd2v9AYyF0RXmDg12V5xCDdIOTXBnvfOBZqdZ+JnDOM10Zqy2gIZNMMIo/GqsHOcjFFQN0ELVXH1jlRTzRDlfsongaBmhZXMg0LKFhNhVQt9ASBylguLXw8+qlI8yqADuRw=
Received: from MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::32)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 08:54:27 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::d) by MW4P222CA0027.outlook.office365.com
 (2603:10b6:303:114::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:27 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:26 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu: add VCN sensor value for SMU 14.0.0
Date: Fri, 8 Mar 2024 16:54:00 +0800
Message-ID: <20240308085400.385793-7-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085400.385793-1-Xiaojian.Du@amd.com>
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: bea03f67-2e10-4c4a-d1aa-08dc3f4d5ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUJNycdKCSqULHSHXtPgNKmEAUKQuCJJ9T70E4M4fgDXQuQuJJMcvIvS0WSvDaqHiIk1WCw9mFQE5x1d298XxnoldttaZzrO/VTG2U4+FiE9MUU8Wq4x9KuK2bWa0dUzmBZQjTiorVta4XqDLqkoD0BHdGFam6mTI4ZotQL6kQOcLdo9DzoEh3oDc4GIEpyOHBUtmt6ywTaa4qp9YIV/9+pUxcFspolt/BbnKkt8KJj2XjpejdPSE6nmbViqCbJD6xYVJP8uKBNRr+Gw0vo4T6aR5XJYwQ9RPeIuIZoWEvhaRzn7AAMwelRW4WSyH+Q5iFVMy5bMzGyxuwtswsf/9fZQKIJzsUgZdw/3wGA00UQUv8o/Is4DdW4C9ZzNNVXaaFSIrvUiB2GwcR9lD238Rm7jQr+Zx8NFxTQw0D6PPSYyDR5EaDugFOsw3foSPUohehF6PlAXqfdheHEcxJvbwF+kJl9/u8nBmxqyiLJpBgx1/2bNTjZE+MqeKKhNMMQa7N8CGr5fuZqqETHJui+/92vMtHHejjaa3MuXmgytdyse1j0FdkmYbwsRjPeAiXmESynkFhYDx3HLApEPDoS5pMRwfWsPifOd9rSkY04txBk9BP/HvuQglQfuqffVAZ6E7CiRbqlWDBPkQUwPfJ7BqfgmfD/sEn2XI+Y66/SSZUjdEBSENYSfTovngPrUEzY8AtW+Ite0vb25rEPB8U+eokbNCj+91wEDiaIG+roXbMQI44mrsAl8Zp8ERl34GV2z
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:27.7698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea03f67-2e10-4c4a-d1aa-08dc3f4d5ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

This will add VCN sensor value for SMU 14.0.0.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 47fdbae4adfc..1d6630d20402 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -352,6 +352,12 @@ static int smu_v14_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VCN_LOAD:
+		ret = smu_v14_0_0_get_smu_metrics_data(smu,
+							METRICS_AVERAGE_VCNACTIVITY,
+							(uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
 		ret = smu_v14_0_0_get_smu_metrics_data(smu,
 						       METRICS_AVERAGE_SOCKETPOWER,
-- 
2.34.1

