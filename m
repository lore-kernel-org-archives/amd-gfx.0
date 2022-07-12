Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00888C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582E894BFB;
	Tue, 12 Jul 2022 14:32:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32F994BE0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lD1q6EwteeHv7sM+DfuHXZuVq0AijNaYat9Fy69MXfNUdoB+Qn1nWPy+6NOI1mhzY6QuOFfzaccc9SkJBm/UxxEy1u7B/dI47s8h/BI98JT0Y6Uj6F9/D13IDttspnqRWsIQ4SLKORm5TyWGrJuMtVQjgY6MLJajsAjSfayk1HED6sO+AKUYu0Jlpes82dqmxtF30SUnSlcefY+T4I25iwBssHENvDpTKH+r40ZOsjXktEN6+uNinx/eoxCD14ECTQfd2mihxnM90FaEqJH2U2QQ15b43DJnP/MNbQV+yu33wiYDU3+1WeeiwJ9NACo6Ock9bJaLMt9tuVLK8KS/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAM0aT6tZcVzYF0WjrdOBUnfk/l6uQMQG5evvXKI8hE=;
 b=NmK+4KA2y09UdcHWUCp7XYcfD8DiqT+3R8KFXT8J9F7jg9zln7YsIFsqRs/GrEEO0ys9UA+X2IppyJpWzJx8/06b2jS/6r6gTVVY9f59qZgC0OTucUTbyr076WIJnMEjVO/VrHpBrkQRjNoJiFu6O6aSqk1bkHtNBzkoQ2Dq7y8YSsNa7txL3GomoNTWQ75Nqxb0HVEFeLXtRxfezi/Rlu8uO2f06tuFceBJPnx2iE6vONmps3tVShnQioWGhsNpaK7fdqZD/nNhVMlvJyCvf+TzazYN59zCXNma1Al6dkA9lqdJuZpxsZ4bVE5HF53B/2MpYJsCBmxd0Wad/SSa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAM0aT6tZcVzYF0WjrdOBUnfk/l6uQMQG5evvXKI8hE=;
 b=RocZv3OMP9hOZ3GUXQnHk3DYe4n+CpTtymTX05ZqHWUBsU0QkFvcVv5QOhgDv45wVcTtCQNkpvTCEKgpGubaM+8a3zs3MDoxsfM0rhiKl4r+R3qNdwuSVccvBSySAzW3Kq/xZ+H1QbfjYcKVf7e/NOJpdmJ1vjXl8PhOGa1VS5g=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by CY4PR12MB1718.namprd12.prod.outlook.com (2603:10b6:903:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 14:32:12 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::be) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Tue, 12 Jul 2022 14:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Tue, 12 Jul 2022 14:32:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 09:32:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: make to_dal_irq_source_dcn314 static
Date: Tue, 12 Jul 2022 10:31:59 -0400
Message-ID: <20220712143159.2700970-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712143159.2700970-1-alexander.deucher@amd.com>
References: <20220712143159.2700970-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb828f0-95db-4173-e570-08da64134f37
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sDrlo/yr9pQKRvMu0PitwX2lnvitUR9Ayrha8wSCCoVYuHeEfWevAdIzTJXpjLjA7uN3e9R47pUjyvjuYXC9/sK222iaenT4YcBVLkX5DdNR0VlsTtP733AqnRQQsmWF6p/aze2GVwRw64WUihjlYV/1JWSF/GdwkSBuc+UoFV53Ktpn7MjWIRyyES9UjylmR9nq5LZJkFYcKV5h7nTcKh1tIgsqKftGfik8SneDVUKRJMwk+scv562pRhAtVCpxia7BhHmQXM833shSywhRUJ4HPRrTHj2uPtF/U2XcYIBDN5Mb3oLR4e6+YtcyhDI7Uy+0qoIByUE2Ua3p0qj+mdN1VPR8huXd2QR+xwdO/BWRgwQiuhYTpG3sUwH21YBJBEinV4GLCVdhW5cLRgMCFuiTU2Pe/1+8o3jO8pJ7yQd+11MJJVUpDgsHKJnEmatOZu3RmWJQP9vTy4yhYtLK9jGHlbqQUcC5kukpcgWQGVIXx/hytEAhAff/cXUygRG9dXkzmSDJbm3E5DFn/wAimWzwg9p9zzcK1GGeCvXgOy04t8wTA3j9X4jghIoDsnNtk0BXTNQ5xxVkp6fR73brT7KxuuCUB2czPBtWkVB5ZqwaxIWV0wipTQBx6o4Z3b7PaOzKy7QsOmgqPGnU6I++AacnPNrKI1SQ7yzhss93Y+T4FnuirOubBN6Jxe20HS+0jFDoAOCElES0eTccbcfn1EeyI32qSsEUUpCKe0Uamx/sYl2QrSJ/L/U5HhzOOKjIzA/+875GKS4+mDfq4DOUWGPr8Y50oEIRb/IkV/BYfEWt1kEwcqdDmI9CnZxgSsXiSbLxxNe3SBXeipQZsdun53kNlXq+njXGhEydBj71/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(2906002)(1076003)(26005)(86362001)(41300700001)(6666004)(478600001)(82310400005)(7696005)(40460700003)(4744005)(2616005)(5660300002)(8936002)(83380400001)(426003)(81166007)(8676002)(336012)(16526019)(70586007)(70206006)(4326008)(82740400003)(316002)(36860700001)(356005)(40480700001)(186003)(54906003)(36756003)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:32:12.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb828f0-95db-4173-e570-08da64134f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's not used outside of irq_service_dcn314.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index bea6f157cbb7..c923b2af8510 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -38,7 +38,7 @@
 
 #define DCN_BASE__INST0_SEG2                       0x000034C0
 
-enum dc_irq_source to_dal_irq_source_dcn314(
+static enum dc_irq_source to_dal_irq_source_dcn314(
 		struct irq_service *irq_service,
 		uint32_t src_id,
 		uint32_t ext_id)
-- 
2.35.3

