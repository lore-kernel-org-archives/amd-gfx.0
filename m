Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36972C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 08:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D3F10E44A;
	Tue, 16 Jan 2024 08:21:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC9010E440
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 08:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePYqwUKF8aEXE7lsbkEH+S6aeayXigUOZbLTg7lGVSd7Zb8YK1t0rvwLWZ8Oo6AtHIYNl2atoT4j9FIKIuw4QAF0/ZTHF5TjbI7WmsyhVoqaRzFfdb8Wz2Jwgix9Gu4HdFzLrv5DrB2KAA6aQnJuz+OV8UTuydNVDZjx70frSoXygMFSsaF8OCkvHmd4PXNuSwcPmnEqAIvTS2QwGwg4TLvi+CWc+cfaic1qUbxVLofQIUeP80R/7Xn04HEjSOqK45PJr1pPS0w+rnewkd2y6bJiTFOg8YDq+Q+Qf3WycKsbVc9ZI1NTIeMfwnXXK4Dhu6R2KxMvXU6Cx7dwnSXZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNBADwe+HCM1sY9MTT9ShcxOnsjbcPLtWh5jixvRaNw=;
 b=oRtkDvBLjdkzeCVo0PgTaNdyUo2NwLHwRbZnRa3naUlp18eCQNdY1eieihwYUI4RsO0vs4AVC6DnZatswUg0KkGoGTCWFn734eK/DmrXI+MoIuzYD0bX++WQ4HiYnZVVG8suzWy4AbmxSnulkmOqOwtX1sRK+GAFch3VzSk+HRfeN4sPi6B3uFmXCmL2EPlFIxHU18gpOscJeOV3nDAGDt/oRTP7aYRkZqWvUKlwMjXDe+Pzz/qv3xrCwNYc2n0HxhRhkT/sQ0qydk9soao2MJ4Q7Va8GBHp4xmP+DEkt3t7VFhgsad0DZTdC6HhTB6s8kVlMsDLn1DuoIJyInf7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNBADwe+HCM1sY9MTT9ShcxOnsjbcPLtWh5jixvRaNw=;
 b=Fq8zvKdVDzp+VOphiqitwLTFVnC4dyHitE3c1VRCDZVsS5P0n//DcUBc4S+WaoC9rscwIxmgKSj0X1ml/95ty747EMOrFC0ct4IbJT8mkZ+eJ35lkAdMelATUaJOH9mHtiYm5nCC75fp54WO0rCzBzAPCrayTPYBANNCivBkzNE=
Received: from BL1P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::34)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 08:21:12 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d3) by BL1P223CA0029.outlook.office365.com
 (2603:10b6:208:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 08:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 08:21:11 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 02:21:09 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Date: Tue, 16 Jan 2024 16:20:30 +0800
Message-ID: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: d68b55f9-edba-486a-9e4a-08dc166c1952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWjl6eUP2rLWUUxF6ZU0NyOaJGXy5U04tNzVQ3Tw/7k9JMPjhXD8QKGqZrKcWvFUZXc+4qnSYkqgt95RCPZUxBLCoNrO+EGRE+xh/qvBoFz2tyCW3DgA+G1H0W5BLpcFCzMCSt3E32DtXHRKlftwbb7Bqot4qIH8FhJ1S+KAfeE5CzlA9Kacnq/be9Bd+/a2eClU1Q4DiCFO3fT/PxMkbn57B7lUv9yma+bAyHUv1EQYo9vNbOyhJTR+YsYrYR7MVK6k168Mb7Q8zZ4Kdpc+6+HzTyinPjCvPtRobJRoM4A12UFUOyBZz5w2OvzzHrGsTpttuF1V5viRj5SO3uePCR+pMYyKT+98hXqnDS/emIA6bdebX5dOtrgFTR7K7OBCgy3PQ62WQHbwOsk4Ysb0OUXhMiYXMTTGSF0lyHi4okGCDI1FfE5YewhT9gQlEO1S/Uc9QwVrQQJju9hXJzQWHsvt+eB1JO4Nd9Fm5qdGAEB7qUbgWK2usCVx/ofloiiYwj9ZeCKkY9uJCuLDMZp0NLJCP5XBd1beRYJwSnk39tovwvfxq+CitaZszAkvH7trrILqeQm7qFO2P5Hd81pGmd6HFypwbpIt/yftQIvaMvzzV/0dhKOnNax1fwkXtI1qhxW3qKd+AuYDJSjZq0ReaRd8F510sUpZiLMgRW12DwkuhPu2or37xSPGNzKR5mNEC8LJdgcMb3b3pc4rZ4/muJU5GVp4BD5VflmF5GM9J/8uOuxUjnNxS5LkVw9qFptgzOyLPdykbM/Y4pBVuHu0AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(83380400001)(36756003)(86362001)(81166007)(356005)(82740400003)(36860700001)(70586007)(7696005)(8676002)(6666004)(8936002)(4326008)(5660300002)(2616005)(16526019)(26005)(426003)(1076003)(336012)(70206006)(316002)(6916009)(54906003)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:21:11.6422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68b55f9-edba-486a-9e4a-08dc166c1952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
+	dev_info(adev->dev,
+		"MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%llu, PCC:%llu, UC:%llu, TCC:%llu\n",
+		mc_umc_status,
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC),
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC)
+	);
+
 	return (amdgpu_ras_is_poison_mode_supported(adev) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
 	int user_gpu_id;
 
-	if (!p)
+	if (!p) {
+		dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
 		return; /* Presumably process exited. */
+	}
 
 	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
@@ -1334,6 +1336,8 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 		}
 	}
 
+	dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+		p->lead_thread->comm, pasid);
 	rcu_read_unlock();
 
 	/* user application will handle SIGBUS signal */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum amdgpu_
 
 	ret = smu_cmn_send_smc_msg(smu, msg, count);
 	if (ret) {
+		dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA count, ret:%d\n",
+			(msg == SMU_MSG_QueryValidMcaCeCount) ?
+				"SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryValidMcaCount",
+			msg,
+			(msg == SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+			ret);
 		*count = 0;
 		return ret;
 	}
 
+	dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n",
+		(msg == SMU_MSG_QueryValidMcaCeCount) ?
+			"SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryValidMcaCount",
+		msg,
+		(msg == SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+		*count);
+
 	return 0;
 }
 
-- 
2.34.1

