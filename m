Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03911C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 14:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE59510E2E6;
	Wed, 31 Jan 2024 14:26:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C70F10E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 14:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPA7a0PG0NhrUWUEdw2UkC6vj3rOfp4T/q5bVDG+QeCNUgoILFgwR3re3sPW6kdMDAh9kt7VsK0+BMlmABbQfnPGSqFZ6tZEoAJUfo159gCK+C4A7uWFHemm051wU/GL4VuKUpEpKgMPpGtfJQtG/T97RyBUtQHqKl344B6kYaKi4y6x9eFH+uj9iY3MaX+DubTwHSHWKkCPrvxPStY/TEa7b49DQwMttAtVrvjvbvvY3vCd7uhCKlTN3SAKneSAzluAhDfIuoeX/O8ZWcWSwg+gwvZ1EF4o9H/zaMvETKz+UpSjMMkq8UbNktrwrUX0/xtPylolYsNdofq5eiHGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unhtpzV0gWzxPynJDSpyRSxjF6U9fmX+3lax7RoePNc=;
 b=iLEI74CrB8M+ys2/KbdGDReDeNkzpNvxk4HFnrNEVYidpMu0Br+8hBM632c6ZGsNfS/EHU8P3y0HjYAQyvKB3rY5ET8iDFJnim5+LswpZ9A0XqbKMv9NFppiUPBP693GkhlplDtZom9mM7jYQFz01gKVvkSprj85fJY5oSKkaz0sKnZwVGUy5y57weoD/H1bTZOAudFWEl9Q0U4tvNAYnAzWYspa9FWRvgWA4uWMWZdvh9M+klsFGY9eNsQegAmlk5aphHMFW2wmK1vTsTgtCq1gjq1NqjyBYfs4reEXCzRVyvBJx/Cp3fbUp97N/McFrbpIAK0b/ocX1L0KxDAGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unhtpzV0gWzxPynJDSpyRSxjF6U9fmX+3lax7RoePNc=;
 b=fsW3++/cWfbHY4/UElrLC1DEdA4XVPzxOhSM8qLMKwJK2fYp3R4YRJ0cs5vpgyc04yosyXYMcGeJVIpr+ErCNlxNYbQmsonde6SXEMgWUwPHv0krWcZj78QxupvIL9uafi7C103euh1K/z/kpIw7wSThLMAKiy70YopkzBPfjLg=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 14:26:18 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::8e) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 14:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 14:26:17 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 08:26:16 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes is
 enabled
Date: Wed, 31 Jan 2024 09:26:00 -0500
Message-ID: <20240131142600.679750-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: e67ba6a1-ffee-4cc7-745a-08dc2268969c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWp6DRk7RYDQPv4UJF+F0eeOcF+yOOz9rsEPyEuninZr9oHXYPUetfPQMr7UP9c+WMdhiXs8eXXiwRlFuBoyD/uMKuPNgacqQ+OltRTbJ1DDivlRZ0XJRS9mVuzrl6GYDBhDGrJcvRs8XCiueFhZWb4DVi7pWf0Fv10xrD6p51bxLM1h9Se0YGwMOPYeYYVxU6FLmN/dm0o425xDSY/TcyeaweEtkVSBrsfmu7d04WhtDHcdLxpiKnFP0ZTlzr9OQyLyjnTyJa5ru3mNayz8/b3Ww4GBg2JTxd5GRSPLfACNFblx420KXHsd32uK0tZT42ozk7WslJHT5XV+O1U2PTjtTR0QEnyrGgpBx82aLiKKoptOvwzY8FZxu810NT+HDG9lEkw0tVCKpXnAUcGLS+RUSAay+9YqdSiCP9x4f8KynAWsEgex8/+JYgLt/5WSrBu265wS6pdQB+052YgWAL09YXSGQ6U1sR6hj2BWhsBybehIuUbDck53HtwUd6TSRDFuVnUA0SzmmCjIoMoO2RFbLPXK63te8nLwFhXaFQ9yCdgvKjby487aHiG0cZLLiPw6CZxCv0lUq4HA9rObxY0e/GG/qfoWtE3zpXWgPSURclFtJZgfQxvHN7nXv2Zg7ubLWUaps4nxqNGnxjRPd3yurqpMgncFxXREoXVpZ0fbFNU2RjPFGtRXdn5xG0twkNqwvGSG8F9wiDyMsAzXPeL9jlGB/zTCovsQ6ZYEEGMqNQHYvWSB1ySLfikaqzKpMUobKmHN6rHv2hkcVdkyIXGpVp7Kjca2nDR9jMBtqgo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(41300700001)(86362001)(36756003)(82740400003)(81166007)(36860700001)(356005)(1076003)(47076005)(26005)(16526019)(426003)(336012)(2616005)(7696005)(478600001)(2906002)(6916009)(316002)(70206006)(70586007)(6666004)(4326008)(8676002)(8936002)(5660300002)(43062008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:26:17.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67ba6a1-ffee-4cc7-745a-08dc2268969c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Skip the debugfs file creation for mes event log if the GPU
doesn't use MES. This to prevent potential kernel oops when
user try to read the event log in debugfs on a GPU without MES

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0626ac0192a8..dd2b8f3fa2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1565,9 +1565,9 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-
-	debugfs_create_file("amdgpu_mes_event_log", 0444, root,
-			    adev, &amdgpu_debugfs_mes_event_log_fops);
+	if (adev->enable_mes)
+		debugfs_create_file("amdgpu_mes_event_log", 0444, root,
+				    adev, &amdgpu_debugfs_mes_event_log_fops);
 
 #endif
 }
-- 
2.34.1

