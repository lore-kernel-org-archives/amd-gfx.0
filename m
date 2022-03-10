Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C159CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D19C10E948;
	Thu, 10 Mar 2022 22:22:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E29010E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1mxBcL4Ahs+rx3gGGN7tJtEppXrqM8bsx61IP5OR47m+J8QVCDIwP9HhPVc/T0JtWDSS+g+zOX/r8lzcFYg/DvKtccXNe7DhFuSAHu922nFzPY7a1IS26CIyECKSlWBsXXennLFxCQSh/3vgBvMEnsJzWxjjfVYdt2ZmTOI36p7wV9NNElJiYiaNRomc3gcpqMzZpJlQhKhSqqWnckW8a0ls/BR3B9eMT3wr70c4BsxmfxTSnc8TiYz42/Jee0GrikbCH2cpcmmzI5nCWD1RKfIvCm5YBToz00CWNaCopaoE2X7jpj+Fu9lwqhbFxNODhR70M+11KMGSG0sF82aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdZpOKOWy87rvo7jVfaooDfvf94EmwYP/rNxDtGQ0LI=;
 b=M5fCrZOdCLisyuRFFMUCLKkRfasaiW5OBqG7jsq8XpFQH/2LsGy4KzaQ5Rof48HXRy2IR5apJQnw4ZZuFVO+UbHxCqKpDyJtKLkDqc/dTVO4GV9yMDo9cy3sxPmfg+WZLkYMknIesPwh+FSGDHxCLLRngowPyq/MzGTuSanf3DgyRCgCvy2BuovEyzJmC5jGjJILgCrT2peRJcvDRMA1w2uBc0ow8H42bdH4/hdAwGPhR673GWvLrPQUmP281EBtzjBMuhVrfwhnPUXl+CfnfbeOEtspk8eHj+JcZb8h3WlRgBey7g3u+5rJ0D8L/kAOAqH8REJWtxgaY8uR1ieK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdZpOKOWy87rvo7jVfaooDfvf94EmwYP/rNxDtGQ0LI=;
 b=vTSdnTTxEDrp9xccN1feZiPVBoY+1+9GRMHd6f0DsMzYMSvygEJAVP5XRRR/1XUCB+Ept2npxo18GeQr2uglq8L1DAJ7nl9it0iPWC0RqHjixAph0qwtCCqVQNCAaQkIUq3v67Uu84f5Hl9cpFbBQFuzOUZr4kUJV1JMt03oG8g=
Received: from DM5PR12CA0014.namprd12.prod.outlook.com (2603:10b6:4:1::24) by
 MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 10 Mar
 2022 22:21:56 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::65) by DM5PR12CA0014.outlook.office365.com
 (2603:10b6:4:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:55 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:52 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: [FW Promotion] Release 0.0.108.0
Date: Thu, 10 Mar 2022 17:20:44 -0500
Message-ID: <20220310222045.664867-12-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce3673f8-4ef9-409b-bb96-08da02e462a8
X-MS-TrafficTypeDiagnostic: MW5PR12MB5684:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB56840B095B7FD5C15AEA35E0F50B9@MW5PR12MB5684.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98fIilcMH+D/WyIvr+qNdwciR1VO6pZnDGjtd5v+KUHtjV6JEcD+YKTFQLvbfP4tsaSdUUhs/2AQgdHKmjtnfdO+M8H2lyvqUYuwgS/S5BKgxWT5nSJqyEsNXyZ/XmLIu5n8je4u83ImNeIioaEcvWvbyxp7BmUrrO4wDNkKGNNYGjsfqRs/0apmm0tAFQjo0EekMfk+kF/2FUnwlYDBlinkyGa4z9ymT+po2Nd1i/3W/L8RhAVfu5+WAw2XZiY18EALhsAA8mIYGmxHfZdfAYeK7HgRLaroP1VYAgo+QMpJ12p9qx5IbeQql93o8nIo4WXiZVAmPB1Zn1qsndoxHtd5vJ06+N1KZKOWdrahNg5tsNADkwWJBmcIW5fMXS9tB6f4OZz8jyQ8vHUL5cqhYl1jzblSP85FH4g12inZiYJHVnIN6owJInwZ2MfVzbUk9dY5pW8k9wybhI7QgOjgskFKZbtSEAowLXQ+PpIHj0bx87xMrMrZNgxONog4nh/1fMUYtFNQYkugBuWfkfH9m0komopqflrfgEIVEisGxMtynMZFs4fSLtHXL46/Vi7Yk+PkQG2ZZ00slLBMl10+PfwekZlCSd8stULr69ah6JE7AZldsZ/ePNAqC5gfKHfkQTgTtD1D65+mzvVLRgYTrZC/5xSQnPv1eLpBHuPaRKDdR3AjhmCHIMsS6bqHCsdT+hFL4+M3IcxH9cyvs/EmcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(82310400004)(4326008)(70206006)(70586007)(7696005)(8676002)(6666004)(36860700001)(44832011)(1076003)(4744005)(40460700003)(47076005)(2616005)(16526019)(36756003)(2906002)(8936002)(86362001)(26005)(83380400001)(6916009)(316002)(54906003)(81166007)(508600001)(336012)(426003)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:55.6277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3673f8-4ef9-409b-bb96-08da02e462a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 294717e09abf..71214c7a60fc 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -46,10 +46,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xb6b77696
+#define DMUB_FW_VERSION_GIT_HASH 0x929554ba
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 107
+#define DMUB_FW_VERSION_REVISION 108
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.35.1

