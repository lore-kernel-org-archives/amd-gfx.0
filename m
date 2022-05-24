Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3CBC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F90810F8AF;
	Tue, 24 May 2022 17:57:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845A110F8AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCyw/Gq2brA7C5JEvtZ0qZRKpFn/xjvmIamliAu4rnKutgHeIXg3rdkDbM50HdNNTv8UQsEZdaNBm4+0DPjkgamdxYDUW1pDvAIBHFKbQ1bG4a7AqaF63Lo8MqUud09MTAP4hAuWs7hQPN0Y0QKnnRyxFkAtOvQeA/pa76+EagS8v17NHgt35jI6yWvFGT8m5W/7VNe4pTt9xA9uc0flHtP0ub8Pd1IQEx/emJ7y2W08IoVl4e5LMcdjCRtH1tJyEHrdr2gqhnFc37ODn4q8F8QX8uVJqzTeCztlhckIv3/zZgPQJYOs6oGS7KIWOemnix3K7Ug4H51KrpJcqZQ7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0pQp2O9wuz5oI0GIlOqli7yfb9nkNddCPlJ2d0fAm4=;
 b=SALD/7Q/bShdWMli8yfNnWqIderiIGL4KClI+nirHfLVwMDdPDC+lUEshkGJNhkQa7rV9XJw1qQA0PoetkuzvvckkoM03kpIm4ZO6p6F1vmwELYwQR99dQYt4NC7Jv1EIHqXDpGbuv1qJf4N1dNwptnAA164DmczF/bOeHq6v9a0s8cEYCWcQPFFT2pFcmihbj6ToLEkxTH/lpO72bN4gI3BcGnpWEOt5KxyXYq4uT/3WEnQw4BMaGSCxQ3mWdMQniK/TOCCUNLE38L4g4AUWZlNRRkdW/sxt2iWCZksfdPk+ERtocuuq+CyUmsJ+Wrdu5cdl4T++s73XAw1P6Y/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0pQp2O9wuz5oI0GIlOqli7yfb9nkNddCPlJ2d0fAm4=;
 b=3gQsSwpxDluL0vCYr1cAiFm8k3vmWD6QBC0ViSHrc9Ix0k9OeR5THXLbKFfOXOnYmx8NQDd2YwWLMsqAC4pJGRAFOUCPTlj2C01AQ4LC6GioishjHZg7ZdgNAy0NWH3RfM7LJR3zieCG9MpxFK8yKE5j7lZLCUq70x0dGQZbefc=
Received: from BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::10)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 17:57:55 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::85) by BN9P220CA0005.outlook.office365.com
 (2603:10b6:408:13e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Tue, 24 May 2022 17:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:57:55 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:51 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/display: Wait DMCUB to idle state before reset.
Date: Tue, 24 May 2022 13:57:19 -0400
Message-ID: <20220524175724.126380-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b9d47aa-cf6d-45f8-d657-08da3daeee10
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279EF8897B14B45D60461CCFBD79@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEI87PwtzUu9+nj1FMzijnH20AiOlSMmoZMrEQmpwXsKve+FU9+7P/LMpRqa8KwR4dbAiWjiin2LEP4R8QTz+E9HTtPUCx+D/FWtjFtY99Vl3NJVS4mt9SsRlzAiKdiNyE/0KS6Qooi2lePubYfNk06Wh+qyPv5KGnvuJGtO97GGD/OnCrVxzBtZDK8tBh2ZVQaHH6j8f6IPmUT6fskc6Hf6aBThU8F59PDsKcq4TC/HLYNsdtyErF+uoT8Gu0miXz4u5QFsZwjVEWEDG1qfdD5ORRKR/KAWVO5OJXiATfib2CVpeJtaXUDjWufygtjh1tHEphcQqQPhJLc/olUovySLJF37LqTKCUnUYzwpMRTLryqHPz4Ig1Z3ztjkKd5Dv0FzWbybb7EDfv4A9FAPYVX8H0XmYcFqIY40XTwbEq72paew5v1GqCKrK27IJHn24WofYvunkVm6Qr+4JnbT7nR5Ty2k5BAmSvyvXlCa+Wifwdyb/mQ56cPH5uzy9cglN9Lm5PLjhItQlazJerxTaFr2hdWHK1++ZsSt0IQjPVrQ1S074xa8NJmU5djXPqGIK/IXhOo3qxsGpS5PSncZKhxkYHJEQ3A61uB4Ygnh/OxagoJa+IYp+fA3dv9bXxgzRrxpCcmq/cxLhhT5iGuHQJ09vKQ4TcBvoh+y09B44dBg1kLkL8v0EO1rEUiFErYu4eR5EeNjPGldrzw7f6Yt7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(316002)(186003)(336012)(1076003)(426003)(16526019)(2616005)(36756003)(36860700001)(6666004)(70586007)(26005)(82310400005)(54906003)(47076005)(8936002)(5660300002)(81166007)(356005)(83380400001)(2906002)(40460700003)(6916009)(4326008)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:57:55.3249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9d47aa-cf6d-45f8-d657-08da3daeee10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: stylon.wang@amd.com, hengzhou <Hengyong.Zhou@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hengzhou <Hengyong.Zhou@amd.com>

[WHY]
Very low rate to cause memory access issue while resetting
DMCUB after the halt command was sent to it.
The process of stopping fw of DMCUB may be timeout, that means
it is not in idle state, such as the window frames may still be
kept in cache, so reset by force will cause MMHUB hang.

[HOW]
After the halt command was sent, keep checking the DMCUB state until
it is idle.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: hengzhou <Hengyong.Zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h      | 2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 9 ++++++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 4c880b64f8ca..c7021915bac8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -62,7 +62,7 @@ struct dccg {
 	int ref_dppclk;
 	//int dtbclk_khz[MAX_PIPES];/* TODO needs to be removed */
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
-	//int ref_dtbclk_khz;/* TODO needs to be removed */
+	int ref_dtbclk_khz;/* TODO needs to be removed */
 };
 
 struct dtbclk_dto_params {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 7c9330a61ac1..8d4574895757 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -84,7 +84,7 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
 	const uint32_t timeout = 100;
-	uint32_t in_reset, scratch, i;
+	uint32_t in_reset, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -115,6 +115,13 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 			udelay(1);
 		}
 
+		for (i = 0; i < timeout; ++i) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(1);
+		}
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 59ddc81b5a0e..f6db6f89d45d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -151,7 +151,8 @@ struct dmub_srv;
 	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
 	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
 	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
-	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK)
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
 
 struct dmub_srv_dcn31_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.25.1

