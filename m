Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A6C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEDA61053
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FEDA61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403326E52F;
	Thu, 26 Aug 2021 07:29:50 +0000 (UTC)
X-Greylist: delayed 957 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 07:29:49 UTC
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B22D6E52F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSI0Zzk0XHY0O2jVBh/B2+05cX8HtNpS80T4z582c0urNauVzL3cH0YCak4Tj9DJ7qD+HO7UW/JD/t97Mx7xtUHH2QMxxjonl0IGusqPZah+zpTEzmIfotc/0MiditWI2cNzJTeYNOKt1Eu+4lQqxuZi9hnR3mNeHr5uq6CxxLG/iQOL9KrJRFlHD3AVqpdpDW6j9GUgKFAYPIqoZP3r4MXp2T5oKotbB63lJpuQzYlbTDnMDTINbebTSJfCAh80m6F/Vgo5RmYcG8KBg1kej7dQW2gdhwIQBI4IipVsF7XfDRWwDswDDP7wAXgVhjMx+0p/SJ+BRKJMqIUK+Ksnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPgqM7GNdEWAfDiZ9XmPRc8TI8Ghc7CwvNHVa8d8zW0=;
 b=B9j5zJrUYkdVsKAjMD1sk4FVfKOWtGHzS+RWzTx0GgXaw/0KKG+prew/9VEprFlBbhG16ErplAUV0gthljnE3GWBb+yu1uaBMLczvYUUYYGidwYiGwk6+a88Lf5I7x0MkAFVvp9pGkKx2LF4ATK87fGzhA9xjgCwl/6IJC0AK6cCgSJvL9+xVkh5+Sk0Imifg1123tiwCL/IeFD1iO4N0zzR1xjw/tceqhltt8pb/C3fIwFzcEWdOc7TDn4XweNPIWh33UcylBxQsZppWc4sjZYVCu9w2Cglfzq42AfjhEkbHQwBigwiowVTC34z7zL5UQJ/tmP1epYtQgyZiSVDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPgqM7GNdEWAfDiZ9XmPRc8TI8Ghc7CwvNHVa8d8zW0=;
 b=UhWfqYCYGwQxwbOEWDIBK3Ke4j83bZlHZahJOwDQ86qpXcHfldigP/1z8Rn23rUY7KN1SCaiTt4CSG7PaPH0RD6DEOIEiDaymUu7fOyiXEiidwT+7zVrK6lF5yUxhXFhpApx2BEH6jhP48mSDO4QoCpmSw4BBPA2LhX/+wbZaG4=
Received: from CO2PR04CA0192.namprd04.prod.outlook.com (2603:10b6:104:5::22)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 07:13:49 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::b) by CO2PR04CA0192.outlook.office365.com
 (2603:10b6:104:5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Thu, 26 Aug 2021 07:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:13:49 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:13:45 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
Date: Thu, 26 Aug 2021 12:43:07 +0530
Message-ID: <20210826071307.136010-5-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826071307.136010-1-satyajit.sahu@amd.com>
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 774fd2ec-5d89-4592-94a3-08d968610d3c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3816:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3816EBB3289518436EFE72B6F5C79@CH2PR12MB3816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNZqy4U4eywVwvT4eIyl/rZoWCKSvwS0GbC/kPHrZWJngoHgNPVpe7fnIZ9C1Ul1H3lYvHRX7/b73f+MZenobVFFiSHni3ObasAD/HZqE9zIp5Tnk59SRktC6hG8BVG8K+CaF/R7Mws9JgFM8f+vaiO0a0V9yrxV4WuxRb9LU+DD8V0MmRNXFhg4sVfIp3iFnSR8PEg4BDxdbHiAk238wRHRJjPTVmU2zdzLwtIY541DEvoDBgMbvkA4NdcUwA6dsbJlrGTcVmqqNk2fLoUxq8pIj+rjCQHlicmXeVjZDzKssB04UPBOKm6SFkCXOCdSNdU4UX4M6RBQuZ2w0Dt/s39VpY29kgqKK23hkfX6XDpGvNNdbjET1azd08BcYgjQ+kISUwChmOIE1d0ppsadn1Qh7bKWTjKg/Y/anbzrcVjwe/5p0U8kTOC+jsDF9Bx7sl/sf2EEYtwwCJNJhpDEDZ4YyvBa0/14WBcKfF0Pt1XtN5unOQXKOtkuWFaoG9jGMpaw4Yd/MB/dC+1Fqioz4qcCjzaup3YMZv0Q3ZUcSv7GnxWKFatOpuiwrgT3Labrv4oWzRvxY+zhT08Rld5E0HGxtyNAsHq91H2VVVhNR4jY7c5aXhT2RmlvmW9LYezKpaM9lv79na+Q8jsBOe0PqYr3wI0L748Q9Ik3KDu5DcTM83i+bkPsAjYgiy/fFFFatfAlE1SKPTijdjT31QXRaWwnsV4caFoWY0fTgyAqjbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(82310400003)(36860700001)(478600001)(47076005)(1076003)(44832011)(2616005)(2906002)(336012)(36756003)(86362001)(426003)(8936002)(82740400003)(70586007)(186003)(7696005)(70206006)(5660300002)(6666004)(26005)(356005)(54906003)(6916009)(16526019)(8676002)(316002)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:13:49.1147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 774fd2ec-5d89-4592-94a3-08d968610d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
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

Schedule the encode job in VCE/VCN encode ring
based on the priority set by UMD.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c88c5c6c54a2..4e6e4b6ea471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -120,6 +120,30 @@ static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
 	}
 }
 
+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
+{
+	switch (prio) {
+	case AMDGPU_CTX_PRIORITY_HIGH:
+		return AMDGPU_VCE_ENC_PRIO_HIGH;
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
+		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCE_ENC_PRIO_NORMAL;
+	}
+}
+
+static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
+{
+	switch (prio) {
+	case AMDGPU_CTX_PRIORITY_HIGH:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
+		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	}
+}
+
 static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 {
 	struct amdgpu_device *adev = ctx->adev;
@@ -133,6 +157,12 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 	case AMDGPU_HW_IP_COMPUTE:
 		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
 		break;
+	case AMDGPU_HW_IP_VCE:
+		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
+		break;
+	case AMDGPU_HW_IP_VCN_ENC:
+		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
+		break;
 	default:
 		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
 		break;
-- 
2.25.1

