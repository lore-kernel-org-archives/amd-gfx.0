Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F115C3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582D410E380;
	Tue, 13 May 2025 11:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="076x/CM1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6500110E380
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNvpkK9Waz4v5vPiZvHmTqIKZHkMJL61YXnjDmXgmvFw4mh6XteeK8kaEWkkhw8ZrvV5syPCS+CZDAKVR+Y6XEf1DlnPfKQ8Qr0Gkrp3NJloGvaf29iZOhBAzU/H0lDyipUnwjUTHPDsBygXJmm+6uBidqdTO+1L9XSEgKX4wZ3z91TpEae3KW7EpYqo+xKg65xgLr1CRPvr6WRVDzUJSrRGEO58xK1v7tq0d4trVWLnzs/SKkdx0E7kJ1J6ylSYkSfQ7LPCVBfGTba9WBOLjrahD6wBuIem/YfPsLVBoWZIICRA53/zQfB8DCnR+xKMfztXSdktNvbLGhcJAYhHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l+l/O0PHq16CkTHgWduK57m4yYKH4yjE5xpzjU0i2o=;
 b=bw0hjLh6raviV5rpGiSDHRYbBqpr/IFghHsy9dAf7sd8nSjeTxth0h6Nh+6LOYlsK2rC0+TCIQLGXV6tOf2yKi9XftPxm2Su3MIGEjQt6vExGtXhRci0vG8QJKNK0hA0bl1ojKg/n88r5ncdhR8YCn8PqQlGxOuGRH7VjmZyO7gWeRQb1iqN4p2w6R+d4hL7BQzrW0/s8zi49QxjLv/JMQ++A1qlEDz1OTC6kIYGBcVqvQJ3zWufNvxQvkRKdJMbaQZa24kWj9v3eGXhtBdQJURbRn0oCl+DYIW8Q44WfqVSwy9KEWvul4dYfJxwmle9sETzbHzM4PHMwiDQ1Dp+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l+l/O0PHq16CkTHgWduK57m4yYKH4yjE5xpzjU0i2o=;
 b=076x/CM1uC4/Z8fbdYGa97fxx80Om+moulUc2Iv/aAbWv9OF/0aDcqjYiz08rmBNB8xN9/NyiNkbY8BFb9WhfFCqRsaFDXJT/AiwxhnyNVceYxqTnA3+AEvEgz0xq78GzX0OLjxi4WSlHiavk+/iFf8ucEg5JvzuFbYCBogoEVc=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 11:22:08 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6e) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Tue,
 13 May 2025 11:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:22:07 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:22:04 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Fill pldm version for SMU v13.0.6 SOCs
Date: Tue, 13 May 2025 19:21:39 +0800
Message-ID: <20250513112139.88355-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250513112139.88355-1-asad.kamal@amd.com>
References: <20250513112139.88355-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a36006-b233-4bee-c6b6-08dd92106575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Icjb0vtXjcwf/8ZCZdxDwIJtzMhViOtAWULd6kO0dW5ZvoOKIu4I8PSc0Evb?=
 =?us-ascii?Q?MOt2gdidsGAacpWNGC1BVmDZ/rTkcgRepazjNCs1hgXt8GH2QqZWjr3H0vLP?=
 =?us-ascii?Q?UbUawfAqhe4jW49Xokztm41cNHPLf/NN+XLLh8uof2WKjTVmqBRtPY55rvRn?=
 =?us-ascii?Q?FkvDLNT/oYwadAV3+QiB5CPsYL6BvNL5qGz5ddkXuKLFqTT+u0xbVhY1Ki5e?=
 =?us-ascii?Q?3bB7BeSX5vLc7TUAg7AcqFd3DhfLp6aF/UTtRDWhbpb6ZNQrIwMr+YutvSfF?=
 =?us-ascii?Q?cg4L5eCtGV5TIsG5JNdrTs8s+6pRICo6RVT95BDygn67UsFB16MFa8kMJS4o?=
 =?us-ascii?Q?4XZtgrHYmUq4zWN4oZuMVPg4H1N5oNKSmAZ4J7ZVCDRn1NJ8h1if5gmCQBfG?=
 =?us-ascii?Q?iDNA8nJdr+qTMGKm/ra1gCtcJ5MgGWz+M/qcxV6N4TVtCCZPbbwJTCl4ryjZ?=
 =?us-ascii?Q?K+rHZFzG7YVSqsczrphFHO9WOcnMg1INVbePecSMH/5Nr1FWBQmETYgkkPO1?=
 =?us-ascii?Q?m51oEfSrzpBDGcwS6jtr2BDXZAM8pmXbqGxkKdXkgUJoU4UNMBc0qZigVM39?=
 =?us-ascii?Q?75cy0SblzeSpCahxeOmAo9r7IFGrPvPv5EAbxDrMAPrE9HdICmmyMuWQZIGK?=
 =?us-ascii?Q?ZLGlguFPfR9LDlPJJCuMGh4sbzlCBWPwLcs1+GqrT1ZMf95zrPuLJQNGUtvz?=
 =?us-ascii?Q?vAe/IqQIJDA/7HN2nU6S11RBK5N7Zcyd1Bu95+PyyIUfpzhDXG8KC8FssQ5m?=
 =?us-ascii?Q?wu8+Dyxo5wYZ9tShye4+sSNoYWgQexfP7pzawh1J5kyrjmxPBqZvdqCnXakv?=
 =?us-ascii?Q?s2su/0pPhqVB+1oFnP264C0eNBvuZKd6xBJT2XPoaDb2qp2LLV90axEXn9hD?=
 =?us-ascii?Q?FkcIKEEjJr73QzSRZ0xbFvCl/y8ny+pdCBaOsGAdfxPzLOhUhfMFX0s4gxzP?=
 =?us-ascii?Q?vP7tVMWrhQqCIm2AYMuKnO7SyIlXvaCHwdMwtWPBEbBTDZBf0X+TX/vZrs2r?=
 =?us-ascii?Q?tIXkakATex3FUh5AQvO58/Ir3rpPfaDFCSD25srnu/ZrBUTLtTnFCnFBhIBt?=
 =?us-ascii?Q?ADgYGZuX/tvbZfsPBT1QXxhSDvOSAJ/Ih8cOgG8zYscscf97XkLXNMNRGSqe?=
 =?us-ascii?Q?/cplpspqLbBB8cYlGsPesbnGsn0IG0QZWeo6OUkQCNTRLPQ895YpcIhtjmvf?=
 =?us-ascii?Q?0YvNypMgXgKMLEaRK16/XrZA31jPLqlYSozwuOS15L6/CIKXSWRHH02NsG1s?=
 =?us-ascii?Q?CdHfKq6QP9t/yYgleTQunvETfFRCLGljxqOsN9XQpRRBmjF4UBmy34apdCqE?=
 =?us-ascii?Q?7MDN9URaFTjAqPlMACYFct1gGGB1ar2AU1cndRz0JfbsG5rMcg6uVPNOfdYD?=
 =?us-ascii?Q?YbjNwT9tvOP6/wWyEVX2ea5D359+QzIzbv80nIfRtpxEypF5YUDD3YMATJ0Y?=
 =?us-ascii?Q?BNofJIyfQHqV/P90yL7AKzhdrxyZPtV+HEIO2l+mk2tUOXBvNHZZCyzWZMRo?=
 =?us-ascii?Q?fmma99CVIOuVTtqVrJNg5lbrgZP9B7D2srH+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:22:07.4466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a36006-b233-4bee-c6b6-08dd92106575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

Fetch pldm version from static metrics table for SMU v13.0.6 SOCs

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7d4ff09be7e8..cd9ed3b5e9fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -396,6 +396,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
 		}
+		if (fw_ver >= 0x00558000)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
@@ -752,6 +754,11 @@ static void smu_v13_0_6_fill_static_metrics_table(struct smu_context *smu,
 	}
 
 	dpm_context->board_volt = static_metrics->InputTelemetryVoltageInmV;
+
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PLDM_VERSION)) &&
+	    static_metrics->pldmVersion[0] != 0xFFFFFFFF)
+		smu->adev->firmware.pldm_version =
+			static_metrics->pldmVersion[0];
 }
 
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 5313206ae4bb..6e7293d3f264 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -67,6 +67,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
+	SMU_CAP(PLDM_VERSION),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

