Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DF5CD129B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82A8112E84;
	Wed,  3 Apr 2024 19:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="moRM/FOg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8FC112E80
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbtuEVVJOgQLiU9oynSb0lQ6l8iDJrrthiivaWlbPWb3r2uSIlxHVOgoaE74pLsCRT2A7x1wvCgvdAm4jnkFy6vDMXYyyFlGW0pWCQCLMPn/sO3rCt9E3vo1DxKU+1kznJwO9oCAzVKC4HK0rL4vYB2uYUWtpHRLAB0gp8WSajkVDJhjoU0fEubDozvfXCRWL4KpXifrWXXDvKxkfGG2HDPMppMRJlat6+Qd/N8dgrbSzdAoQt+QSYdm8n6guw+Dm0Rfxgmi0aPVx2DqA5eTj4q1E8KN3bvOXJzFqCaH6qbnP7O+eJRa3GNvIOniv7eI5EGl1s4IuZwXv3MyPnwZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlOo9cy5ckUMDiJVsFImVJgzXC8g9UUFgXyr9IZBqaQ=;
 b=HLPuBh+njPE3AmnSYSMTp9eEKim9Mkqka6bJ4w90Y3gK95RRh9KViGgEJc9YDcMYfQ5li4qORRk8nTDgNZqq5qoA+RNbQ68J0jYmeugKpr0i+N6DuPjOos/x7d2OwhWMK9jqTj4BErBG7BHyINLwGre94TL1cynORQBG6VHXCwWdOE16hM6OB70NShle8OEMr5oL4B5VYK7bi/3udZnde4LxuF9kKbkdYeEVPwMWd5kqnBb9pbP6q2O6GO8ByZRSxJ+mpEEg8R+vx9vCROyAa0G1CpKuftaXSaWjyLuN3nvNd41gNCtTcjfbKzNAH4J5LSdlV0KYRC8M/pW0llRRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlOo9cy5ckUMDiJVsFImVJgzXC8g9UUFgXyr9IZBqaQ=;
 b=moRM/FOgBnHbgALVLCxlMM3FxdViWtZg1nlJYq6Ar763CEsM+ns7jVothPqlR/1mW2zH4G3vOuu+bN2cMp+7s10E4lUt42/RdOvfDW1vpUSK3SHGmtsxvzMsVSRLO9PXVXvG462/oG6wwvPKCjb3xRSKUmYHWgPw5nlyz33rw/A=
Received: from CH0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:610:74::35)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:52 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::2c) by CH0PR04CA0090.outlook.office365.com
 (2603:10b6:610:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:45 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 17/28] drm/amd/display: Add V_TOTAL_REGS to dcn10
Date: Wed, 3 Apr 2024 15:49:07 -0400
Message-ID: <20240403195116.25221-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: dc591664-4d11-4115-6f9d-08dc54178225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rI3CHu7dHudq+S46KplTqBChYbZt3DK6GdGmEi6LiiHn3taoCggoaYxNhQV0af67bMCn0Ttp9+KgOT8M4pqjEdqOFmfPxRVdMyzC5Q0/Sflxls9So+SQ5IapMDySYVnHD7AOvmKcK/u8uEoSQEmBOeNAtUxBKV1kbvMsoIpVr76Prr30sjf1PmXQXMNERtUQIhKn4FVxaxMQSSvRAdH7pfzqDCHeMlviJKGK9d81HvvY6HlGQhv7NtQ8xy5V7X4yLIyFHTqe+zNdtZNjB4qT3SgINllwXlSSYbvJvwIg+YbO1belY05C7bxHN6iN6mUzlIzQx6z47k/fmk3A1WXADvH/jxU653nu27zyTs7qrDj9FbvAwf9dkobvxsq1hHIxgB3X60Q2zsZuyIgQc+c7vbB6atywp3i8lnwJNb+x7RHuW9+RZXPc6s1IYb4NHIeFMJHzfsWOX9IvPc+a2Q5AUg0f4+a2/r5d/yH3bBcU1B/BNqEckGzmcT5ecXcRybFd6t+IF2O2Sve3gl7DO/W6X1tlEYYh36SKksslJQGz2OkYS16v/RuGcxYHIcdwAhO0ZQBlkQ/BuakPTUzN9PMw1ONRFIxLDRwvD4u3GYEDnjNQQGx38QRV7KLxl2EdxzV7h6+f6kam0Zj7K8AVADB6y81BPQ2IOjXcUdt3+epj+D6ox+s4+E1rERh1ZTcsz0iW21FfOSPCU88YdwnlsLncn2YFrm3IYwukTzl3nD9XBr00ZZIcm9dNhK7302wpgXXm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:52.3615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc591664-4d11-4115-6f9d-08dc54178225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

DCN10 OPTC is used by other DCNs, and in some cases it might be useful
to have V_TOTAL_REGS available. This commit add V_TOTAL_REGS as part of
the TG field.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 8a45d26b7531..2f3bd7648ba7 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -517,12 +517,15 @@ struct dcn_optc_registers {
 	type MANUAL_FLOW_CONTROL;\
 	type MANUAL_FLOW_CONTROL_SEL;
 
+#define V_TOTAL_REGS(type)
+
 #define TG_REG_FIELD_LIST(type) \
 	TG_REG_FIELD_LIST_DCN1_0(type)\
 	type OTG_V_SYNC_MODE;\
 	type OTG_DRR_TRIGGER_WINDOW_START_X;\
 	type OTG_DRR_TRIGGER_WINDOW_END_X;\
 	type OTG_DRR_V_TOTAL_CHANGE_LIMIT;\
+	V_TOTAL_REGS(type)\
 	type OTG_OUT_MUX;\
 	type OTG_M_CONST_DTO_PHASE;\
 	type OTG_M_CONST_DTO_MODULO;\
-- 
2.44.0

