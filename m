Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C241EC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7444D60E73
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7444D60E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D646E930;
	Fri, 27 Aug 2021 12:44:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4496E930
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 12:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSIG8zjSbp9H5jD1MlxIy4OGxibz3jd8mKgp8LVtkB8MALL5KioyZiR3JhWIcUo+ZHeuPsZUkyRlFLJ/tczRxDu2pqudDgEfGN1zlzblwIRaRdVnVmRyd0ZsCMHHs8rlhOfXjqp3n7K+DSz7KiwJYtH1SZSKe7RH000JbIWrhUJpQxv4sItyv637WcxSUuLgxWKg6ldp5KwOH9IUEG+yNYtVyvh5T9XzFBx/vBqb4wLQ5p+P2IoL+Q8O4Jp2JQkh9pe/K70XHxF7QvB0TZg5xpGdH7Z6JCokEd67vbQwtlBLMxJk6u49TxXl3L6OOlUXJx3BGoAOZsHu3Bgd8PhAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6CUkp6DTT5izGq5X/GSTKqDQ2BRWVfDY76GMobfHYU=;
 b=Fth0Az6HopK/VJvpRs4Yh1oSBuEwDdY+Lqiz3mQwziVBHib+1GZTh5K2RCjIR9mThfmw/5vplj9nhqRIkbL4J7GmS4h5RhERB3TdcS1lCpjRF0vC1l9lJQ6D05F/i9M5YQHgGkJwgw6A09hAHX07J0VoLsyzb292ggTwhBkrX4Qdv1JfcOdm5yrd7RQe5Lr5bUzAtuHCFeu0k2EgWZ0U7vPm/DtvZyO9i4uBwD4Sqrv3CQYtbvgNUz+CXc5w6WlPulzSvM4P8+NeXPAqclmRHIB2520vjwxb/HsQX93ouIJxsJq0Bb2CIs1np8tFMGRsaTutE+vR8mjxFUyI3TjSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6CUkp6DTT5izGq5X/GSTKqDQ2BRWVfDY76GMobfHYU=;
 b=d8Eo/7areMpWJCy3TEboeCxef1eobqiFHG1nyiFtwMyxBu300gtgEVzDATJURu1qzP5zxW+mSAPxhptkaHBLn5Jw3dAb/NbbEKggjs22nvwGtg7QpY07mqMzevbh17yudti5M+hJ/0WE4mwRLnmtx1V6VOddWbORXH2G75/3DSE=
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 MN2PR12MB3021.namprd12.prod.outlook.com (2603:10b6:208:c2::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Fri, 27 Aug 2021 12:44:02 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::6e) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 12:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 12:44:02 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 07:43:59 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 <lijo.lazar@amd.com>, Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu:schedule vce/vcn encode based on priority
Date: Fri, 27 Aug 2021 18:13:00 +0530
Message-ID: <20210827124300.14593-3-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827124300.14593-1-satyajit.sahu@amd.com>
References: <20210827124300.14593-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cae163b9-350a-44e3-d09d-08d969585922
X-MS-TrafficTypeDiagnostic: MN2PR12MB3021:
X-Microsoft-Antispam-PRVS: <MN2PR12MB302194609B0DA812205442B0F5C89@MN2PR12MB3021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ9HWUVxrj/LnP4wnsukysKSI2iV8ZYyX4UN62gHanneLj0E0nYph+z9FDpf7ozZ9bUfThkP2uzfrepdqB6wMbnlVj4RseCO/xu1wJc7se2XhgZPDWMslDK8+8yfsRcMRv3gkuCaWtSsVqSaFazFnN33Z+UjQmsjCVo6mkk7Atli5nVcnad/Y6/a0+M+MZ02iTxZdeBeuzQI2J1lTkXRqfjmDianwKW46mmhEvhF/Sy0QrazLc/0U0K6f6YpWk1GIEqwK7OjkPg7WBU1jxR56dMWRJNUOk9cCW5pvBLX3JF4q3CVOjkI/OS150cVdQrgxoVyssekATbaujKfLCVhm7jBgf3XG856GUkN6u8vl42Y42sAxB0T4DjEzt0wxvJKXdjqRFWc2sIQONfPHcGhuT7ACBb2a2nUYNFinxJDSDumVhPyGq2SEDm5sY1U8gnCtsmF/CnnQ1qHUBZNm1yPte3HbXav/X+A60ykDL8yo7v6njd1q6eXqe3LR/wF3Gh/lBgfht1BWLebmlceJ2zl8Sx1l6zYKvvXCCqZrAHbuXBhJqXDcs1qzqdOY1xWB9PlXYV9Vhl/ysB1fDr5pKLPA6eroqZSui9WAaEEtGoaWqf2uZ45r0Q/4P++fQwcz4eBbLGq9KPMT9nrDrfL9i4hnlHE0pWKXnTwSi7UAIiH/Tc942kFpn3QIF+NiR/ch864rtfdSWENbl9p7irEgY3Uj6xN2LbHf2RCyiXvT2SG0wY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(82740400003)(7696005)(6666004)(44832011)(36860700001)(5660300002)(86362001)(356005)(16526019)(4326008)(8936002)(478600001)(2906002)(336012)(426003)(47076005)(70206006)(26005)(186003)(81166007)(36756003)(1076003)(8676002)(316002)(6916009)(2616005)(54906003)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:44:02.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae163b9-350a-44e3-d09d-08d969585922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3021
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 0d1928260650..468003583b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -120,6 +120,18 @@ static enum amdgpu_gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t pri
 	}
 }
 
+static enum amdgpu_ring_priority_level amdgpu_ctx_sched_prio_to_ring_prio(int32_t prio)
+{
+	switch (prio) {
+	case AMDGPU_CTX_PRIORITY_HIGH:
+		return AMDGPU_RING_PRIO_1;
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
+		return AMDGPU_RING_PRIO_2;
+	default:
+		return AMDGPU_RING_PRIO_0;
+	}
+}
+
 static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 {
 	struct amdgpu_device *adev = ctx->adev;
@@ -133,6 +145,10 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 	case AMDGPU_HW_IP_COMPUTE:
 		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
 		break;
+	case AMDGPU_HW_IP_VCE:
+	case AMDGPU_HW_IP_VCN_ENC:
+		hw_prio = amdgpu_ctx_sched_prio_to_ring_prio(ctx_prio);
+		break;
 	default:
 		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
 		break;
-- 
2.25.1

