Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F447C10F1E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86FC10E222;
	Fri,  9 Dec 2022 03:49:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4DE10E222
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/tZo0xU/ZkhPOsnxVXFIuq6KwYR6ABHDdYZPZNgrg2PPs7nv8eIT7lJoeCeIJWanM/Qe2EBvU17UelYl3nnR51qYUjnytjqrWgtwcWTlbMqoWQEF03ADZYZ84gjlDD5738gYUzU01Hm3bqu8objqQKb5JCV+8MYLbsCUZHjPoBWoJ2c3mDZMt2ItSUwLsPs0HsfwJEpGgzgnixuDRyg1VUaB7zyQ8WJ55n4Y9VJuICW2RDXiB8Ua4cclI9eWrO85ZxQxXfl11kXTB2o8xoBxLCJvozVaTB/gD3iXHjX3GVd/DqNX7VGto5TxvMd6918dy9fDcN3wbFf9Ph7CVmCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrykFr7XHLqqvfiCFel3qyPctdPkS4Erp8JWS/tcWoc=;
 b=duPsFjrbP2qfHlczPkuKTCjSAkuZsVZ3ywukirmVWe7LUXvncXZPPAFmqsm2IN8mneUheq5xaKZK4vIRwsZkN3vOkoWbDnSCfkcqgR18ftJ7vZdoopj3jnIATgG6jlSTxfVp5kwNxU0iU9kGeax2HiSWwNPvEEwIW2KdRdp3Yshr2cqCkbZrxadGTP2akQJjvcLbvyPs0+Jj0q2YHef62w/3zGXwZkJrChyGY97/uhmxN2vTb4Xx6zO4eVo2pkw5A0JZJRDEKsvWnJeYkWoKBn9W3bsdrMNOnrAmjR7u/OmY3b6fnzSDCrO2cPsprvV6LIJ9bXcfjUwQsMhwpA+uyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrykFr7XHLqqvfiCFel3qyPctdPkS4Erp8JWS/tcWoc=;
 b=Kd83fsDReM6czU+6RjYuja4/gdSHFUuQrIOLr9zrsgQoHQ6akItZ1R78klvcIal1yGUT1pPvdDsGqMdxnL91m4iEXxR1/OMmN7R7RdYqGBKLHMSISEd3J//qw3AA59mw63R+O55agR9Rznv2yAViKC0bORFzYPuxaHenPg7IlAY=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:09 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::e3) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:09 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:48 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amd/pm: fulfill swsmu peak profiling mode
 shader/memory clock settings
Date: Fri, 9 Dec 2022 11:48:08 +0800
Message-ID: <20221209034813.2373727-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ccecc2-8684-4580-1c17-08dad99853e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVsj0XBppVF8HG0Ynwgc2zAI4DEql+4kL0SV1UDT2RjTIw8KBGyQjFcSHUYYjsyuL3D4GW703jqaoMmHkxeVChDrDOQcgbNxL6QowBoU3yrJ0vlA2qSW6TUejS1qGa7GMMY61IOHJQuNNWjXLeKkYc6emyFcPzzcvd9pH4ahpKzRDFVjFA5vdxim0rqzdGiqpkh+RKu5d2+KMOG+aFuyWUDudICW/ZxG/lfZsOeNdO5VVffSl/cg2gDiFBDmuRlHlo/XR3qvcMcgOTuXqX/pFK6iMKH5LymuNADSfcv7bVBGHBqFUuAoW1bz90pAeaEF7a4uKtRGDrX5TRc0rfUl916pR33SC2NW3zlbK1M5y5DTjZLeXyVennItfZpx7yTlt671KjAcU56FMY+hMQpGMOwglB42Ag3+AR5EU+nEe32RJGjLJUv+GW/d0nqW6xmG2whE1MHAD7JFoiZscHxjL52tMJdmJWqcuvlog/xT9d1VXjE5iItm5O3Zoh+JZawPGiugDbkAW08sjh1H+BiOjCY+Db+L0rSzHmAWYSKOB1bjw4IwQmXXnJ1i3fjLYuoZFJYnQAHo5FPfYicl9fefttm+fG/f4ZmQBAYxAOWstcMA5/+lwpekbqMa+sQzSzEXQuc9ybvyw6aM2hsCxiCXuIAn20B3MS35ClutzyECsSVX41baoY7hXgfnUutjGHVsvL1sMX6mv27xgK/F8vBAYwMFrFH9fAoQ261b/uSkitk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36756003)(86362001)(356005)(44832011)(40460700003)(2906002)(81166007)(41300700001)(8936002)(4326008)(83380400001)(36860700001)(478600001)(5660300002)(2616005)(316002)(70206006)(6916009)(54906003)(1076003)(70586007)(6666004)(40480700001)(82310400005)(8676002)(7696005)(426003)(336012)(26005)(16526019)(47076005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:09.1345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccecc2-8684-4580-1c17-08dad99853e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable peak profiling mode shader/memory clocks reporting for swsmu
framework.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iebefecc9addd7352a50baec571791edc8d968375
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 20e0272e46bb..d68bd7c1aa04 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -139,6 +139,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_MIN_FAN_RPM,
 	AMDGPU_PP_SENSOR_MAX_FAN_RPM,
 	AMDGPU_PP_SENSOR_VCN_POWER_STATE,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
+	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
 };
 
 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8650a1404e22..3421022bf707 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2473,6 +2473,14 @@ static int smu_read_sensor(void *handle,
 		*((uint32_t *)data) = pstate_table->uclk_pstate.standard * 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK:
+		*((uint32_t *)data) = pstate_table->gfxclk_pstate.peak * 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK:
+		*((uint32_t *)data) = pstate_table->uclk_pstate.peak * 100;
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
 		ret = smu_feature_get_enabled_mask(smu, (uint64_t *)data);
 		*size = 8;
-- 
2.34.1

