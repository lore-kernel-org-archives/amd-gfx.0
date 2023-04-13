Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BECC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 18:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A84010E393;
	Thu, 13 Apr 2023 18:02:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5777710E393
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 18:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdxbXiqkn7MwWY0QZaJ31fNWuSfIafpumfrfIsgm/dcUY3w8tVnMVHkZCNKsfc5Aaz55XVeDTAl7r/mk6dZD6vkyfoIP/rwkbVd34Rzh6kYKrHHMXEPPzxRtbVDf5HCoZ0ke49qWGaBBd31dpfKh3mXFE25+v0s1s9LXy6xeC4EcmMeXJJJ3MkBmdaH69BLKcq99OGZCFZnG3sW+qOto4AIoyuVMukr+WpdkkPVuX3/ymT6CSBvSi0W5jJCkdP5Z+uS9Eiu0azGjmzva3Mgb5dPW0eY52SArhk/RzzcwhNSVYBXAENzTYk3eqleb/KONV1KdKGQObX+ncaH1PiaaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0YWOOHzIstzeXCa3G2v8AmjNJyU/IJfsMdXbG+PCfk=;
 b=Sp2PcqkMst1BK3g1GaPyM1Z1Yr5/APTR1niMfg04lSAIkoZybbwCNk5bZIA2rOxGtLOl4xI0kGs6xQ00jSd7Cy1PC2FgEwmJMH2HkjYD2cQHD1bjl6Bsl9qzLETT9Hf5aGEHeSYXAQPdzquVMlvuogf47cuXRINrrfGNu/3FrUrEW6C4ZxkpavOnIwjldEMfqbXeja3kVvuVhATQYw+7JiLEJHuR8vn6Ikm0BZNNjDcWAySNjObTGDJZx6nRizCNXXEPjo7AQhsio7Cn9UItb6Hz/jKXCx36ARidonwcQRft16bX9T7bbM3KQFw8ijc9dikKSNcwZU72CTFP19aYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0YWOOHzIstzeXCa3G2v8AmjNJyU/IJfsMdXbG+PCfk=;
 b=xN979TSZVUrA/fzGUKvT3KkMIshvXOcBekivcTGUk+K+mjL2ZtqXNgvTRH50LXTmxa6tED1OoPqLq730Wtzgl4G9O5S4I+myPqxjsCl+gEox8jFQSB4HW5zOUQ+8GfSP2uIPvdJdQ7MJ53C/vDyebmbUxQYhsf2QOVc7vFKIljA=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 18:02:46 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::18) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 18:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 18:02:46 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 13:02:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH v2] drm/amd/display: Improvise error handling for DP sink
 power states
Date: Thu, 13 Apr 2023 23:32:30 +0530
Message-ID: <20230413180230.2303096-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a101e5-2e6e-4ca0-fb81-08db3c494988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEo9dO+uU0DK4jGLTlPHUJEUkPEA3VyxxM18611fcQsZepPrFIGN5sUtZ5i0ZHiCZmy4/VJTZfnaTmqXSscw+Lx5wtXliBYBIiTbkk93OoGLPxhlcj/PG7dbvAf+Y2Q/tSxY0E2VRiMNChGFcwtM2Ie/K5uSa8pSc4S8tiD2hUSjafphuD6i8K95h0fgA2mABt7hUNDjGy7RYLrun/+WoXqoalMi2MmIUyw51Pvaj/cKv64SeRvCG1WQFHRFIelcHdZv2236rzc9jrOlQNpnQm0U1gzPAaiOKrE8i9tYhMqbPqw0XksEqXRQZg/TuQ9wLHoN1J2oYXQ5G5Z7T14CVJDi7pYMMfEEAVrBeTq6w5lSQxqt18iazEHwX+N0x3UuwgZKSdXNAi9DVCUQ4UJvjAfrgYGgCdJCyMTDkL20/FVsMXlfy9r0K8O8faRQ/csfs1EANV92eo299NbQdM+n0hFIWYXyC+DexN8c6YKtuYvz925s2DPIFYSDzyNVXxsY/iDzfBcewAcJLELQYJTkrb2tMxct8q8NsUBmnOcSjrMO5Foz2Lx52B0EEzAw48ULa5VrrvAYeWnU3yvfy27BshlzF3yDHlFq607DgHXndD/fEI+Cd/EBOUrY1TYRmCh1aQmaOocQqI+sucrfpblumHCuRjiJYerBZJLt4xcbY5SjIBVEVg9dUY1ycFuix0MR8hxiJpP5NFkaKwKMBFr82E7ZCLZY1j8KA/hY4NW3bSA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(41300700001)(356005)(4326008)(70586007)(70206006)(2906002)(40480700001)(8676002)(8936002)(40460700003)(44832011)(5660300002)(1076003)(26005)(186003)(16526019)(7696005)(86362001)(2616005)(47076005)(426003)(82310400005)(336012)(36756003)(36860700001)(478600001)(6636002)(54906003)(316002)(6666004)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 18:02:46.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a101e5-2e6e-4ca0-fb81-08db3c494988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log if we fail to setup sink power states.

Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:

- Change DC_LOG_HW_LINK_TRAINING to DC_LOG_DC, as link training related
  code moved to drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c (Aurabindo)


 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c840ef17802e..ba98013fecd0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1043,6 +1043,9 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
 				DP_SET_POWER,
 				&dpcd_power_state,
 				sizeof(dpcd_power_state));
+		if (status < 0)
+			DC_LOG_DC("%s: Failed to power up sink: %s\n", __func__,
+				  dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");
 		return DC_ERROR_UNEXPECTED;
 	}
 
-- 
2.25.1

