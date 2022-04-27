Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CF2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 02:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB19010EF81;
	Wed, 27 Apr 2022 02:40:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411A510EF81
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 02:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHlZlt47yNvN+ajX0FssuxgnCb7Zg5qmE27EAUaJdDHxMyHaFOpoYGpfoNfZfRB60Jgh9bu9g9DzG8iy/4U3yq5tNH2KZ5uqTrOw2NUsR5X9axr/9/QYp0Z4hM3BMTS8d2aHZmIORpLUZz5HI5Px5I21Bh7+bprpm/x2CT7z2oOHYGS9ErE9vAJHiYSx6Rwse+Ew+zbQgGC9bHD2Fv+UGkhVaGLdIVUBdwJlAQKOpquG97J1V+kg+PIgmSuEprXewmq0lqyQYiXPbmU+Jw+ZteZzn6OvwTpWhPxBWQxiJ/fVjBv6fOQGome+bU44zlHwhtAW8o1D+f+MjMJch55d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoeqDKd8k8pGYFW3PeZB+jvuCk+JnqI4LcPo5C4WQ/Q=;
 b=O+YRYKMLZG3fvTW1P5ZXahzCqPpSgL0b8zFYYxj3BX7IlIK9DrNfQu7jC/luNV7xY7LTleVFte7hrmdRvd/34hZwuk6MC3EgFKgFCzrPKeUIQHlvqmc4Lks3vncacmBLFAnFK7w7/N3uxfoD65nL0XFdMUtWx+kQU06kQHTtylmlakCxOZCOBa4zB9IzAL6mkhicqIQaemWYIpVD60u2ANa2BbYvHS/opzKn9NVV4jjOrTJuh/vaXkCMxgufiTiHRW0oI0/37a0PSHJ9N1ki3kcOH26dwnTkIhz8z6Fsso1kznWFtb8rmDXYRLVHy0gJ2QXHb+dkdur/5VvxVUHRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoeqDKd8k8pGYFW3PeZB+jvuCk+JnqI4LcPo5C4WQ/Q=;
 b=VaIIBVT13UYqhDS/YI69XQJVQgl3K/yjONUl1Ji0izU/AU77P9s5/m7WZMRs6uMKdluGXa0clrD4SuwKxiAdLQEc8/vdxaKjWXSaHoadIxniT8qN6x/UYqEXUd7es9syRq25cqzhPGrqJQ7++vIWjl3H80eey53JOeRP12UjLHk=
Received: from MWH0EPF00056D08.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:8) by DM6PR12MB4893.namprd12.prod.outlook.com
 (2603:10b6:5:1bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 02:40:33 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by MWH0EPF00056D08.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.3 via Frontend
 Transport; Wed, 27 Apr 2022 02:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 02:40:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:40:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:40:31 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 21:40:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/display: Add Connection Manager boot option.
Date: Wed, 27 Apr 2022 10:39:53 +0800
Message-ID: <20220427023959.1241450-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427023959.1241450-1-Wayne.Lin@amd.com>
References: <20220427023959.1241450-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d44464-d7be-488a-01b2-08da27f74d0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4893CA09CC1AB507295D5EFAFCFA9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJSC0K1HdvSBSN8IQMn3+/uMY9tb4nNRnbGKGwF4xUcoZzfsPYBCaP8Q2G6FPmQNQowVvPfWCzt4XWivjuL4zJIdt13XSOCeEtK2Vvv86o0nDigaAySuSm2Kq9t1ZV0kJHze1unMmz+Ix6o7c+TGXiHNsL56mmS4Q8yBo36YUA4NIVeEnawaysfyumufkFZy/VvaAfWuFsXmp4diibzVB+nbbDQK0AvXVrrJpOQThmIO8edTx6aMWn4fG+7vbrDHrouZ+RFaujpilqsRGq1yMgyd22+yyTiGBtPDbUqzUnK56vCBTAXSY0VcULdigdPXxHiRwODGvYM1K1QqQbSmqyqNeN0ym+ytSYZOhJEZ6s9vXc04Cdcel6wUqSxmTpWk6H8F8PnYF7xf3NOUdOMGKptwxAG377NuBpospmvPz5NjECCKCgStPZfEj1lYd9Otx6YhLkaZh+PKmAtkOL+aKVHZhKzIfYNymPHRn5OTRdle1pUamxKwZTBVdm5DUiHImcX2/zmyQe6CuKTWYBYTllOIPTuU+NIJwSkx+XdsFLxspdB1q/wArLIQU7FLlL1Evovvx4UXGl3G9IlLj17V6RI/JwUPfpEqlonXyIPrC7r67MKbCLprVNAxoSQ7pL5KqYC6BdIW4MVI4RIviQBvB2rqKaN+TnfJWnwQ2MoGJa7czXfSP4j4BnMFwlx8KY95iu9teXFsHMNPCyaUK4NQIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(36860700001)(6916009)(81166007)(5660300002)(83380400001)(86362001)(8936002)(8676002)(508600001)(47076005)(54906003)(4326008)(336012)(70586007)(186003)(426003)(2616005)(70206006)(1076003)(356005)(40460700003)(36756003)(316002)(26005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:40:32.7640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d44464-d7be-488a-01b2-08da27f74d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Boot up behaviour may differ depending on the Connection Manager
handling USB4 tunneling.

[How]
Send boot option to firmware to indicate Connection Manager.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 56757a286a03..f5cb8932bd5c 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -243,6 +243,7 @@ struct dmub_srv_hw_params {
 	bool power_optimization;
 	bool dpia_supported;
 	bool disable_dpia;
+	bool usb4_cm_version;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 05c8d91ad4ab..e24f117e831e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -350,8 +350,9 @@ union dmub_fw_boot_options {
 		uint32_t power_optimization: 1;
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
+		uint32_t usb4_cm_version: 1; /**< USB4 CM Version */
 
-		uint32_t reserved : 18; /**< reserved */
+		uint32_t reserved : 17; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 82c651535628..7c9330a61ac1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -340,6 +340,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.dpia_supported = params->dpia_supported;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
+	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
 	boot_options.bits.power_optimization = params->power_optimization;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
-- 
2.36.0

