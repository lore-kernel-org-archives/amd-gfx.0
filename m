Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FE2C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 17:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB1C10E37A;
	Thu, 21 Dec 2023 17:40:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8000110E37A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 17:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlQBANP997c9yMxCobGvI39QziPyry+exCD0JVrBobQsgI/BXOTM0yi8/JeRE+h1vVBnlTFuDTAxjTnBJpypFj0o/suDM3HtNB0hxZhgMwxPBdYISVJiEylY/LRxeS+yXNQYlO18q7/PC1HR7jlLxyy2G3Levj1lUwZ0U7nh20OPKu1XWnsf4lvtsmrv2KBbnerHBH1zUDOj7c3ziYFhHR6W9barBm1fCcer5QdbStUwHixHHZ2/8rZ6mWUoi0X3XG6dy/oxw6UFqlhx8UZ8Q5sINQ0zlSvydvwwJ4tP5t2++UKgSTs+fB4qn45qiQPv5hoyS7QkTLWLLHPTwAIryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkxy6HZV3wIgfHG4fOG47zqICLQArbrSRqLgcBTEng8=;
 b=UDjB6B8j6MFmp4adwrGbuwoRBvLpabFjCESdyugG2yHni6Q7AYSWw21ckcIh/cWwr+viQs6mcV8tJhxdYmHNAIEQRYM1hY+VNIyCmZ2OWSr4AomSRhbcHiuxIwEQyohxh4moTJlq5BUMamQXatodnchzwlLI/ubUY5o8j3Qe1UV3ynJtOSSq7jU+RG8r2Uq9jxXg5vMKbD4boxejvro9Awf0AJvTp2x9JeabaXrw59gTUltLhIluUju6eZxhSLI8Y76akyevHtEH79UVcQDweUMK3+TzmF/jA2ZWtPH+snbqwn+N4wOvgS3jirCxa4YjS3T3YAHOApr0Wp0eJbaFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkxy6HZV3wIgfHG4fOG47zqICLQArbrSRqLgcBTEng8=;
 b=jLX3KyOgGnYsbr9UTlj8EtZ8yy7l5UAIgDWiQ+hI47T6ljvuTylcOuGeHgTXvA2+9RpLxaadbD0o+YZhKItD9QnySEHedyoNIDDFHgsx4R2Bt7mT3LIAy5Bj5iw6sarbDUk/3iqs+l+7fcO6iEEiHuxW3p3bdYonB72H/4xyfQY=
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 17:40:17 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::3e) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 17:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 17:40:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 11:40:10 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdkfd: Fix type of 'dbg_flags' in 'struct kfd_process'
Date: Thu, 21 Dec 2023 23:09:49 +0530
Message-ID: <20231221173949.1403999-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: df4e640f-8ea0-4ee9-03e4-08dc024be4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VY+ydWygxqY+yPivUTIun776XyuGL5alXg7Ivtv1VLYn/ZbjmFy5OZSLcUkHYlCdv1nR9lp5ri8FIyD8Knf6HCzLtKXv/XlHLroj8mLE4lndhKfnk8zYknPjZbqt0t6JlVP5gzvAUg+uBh9fY75NwAebMx3Wm8JtURpDyXW6UVTPb9IXqyPH7fAqbvLCu36WDW4PUZUi21T4fd5545Ly4wG/LG6ffJMTPF2VKTzikMKLv94I3G99FXmBlNI/u2ioX91a0QsPj32BuaGQ26Y+aXYPVxJ8fnlPicVGmaID0hzkXD6A8pgVHtGBp4ir8z09AroSxt07iHEsoJdbJUCfW025Zs/Stf+Q6WHnPt+n5gEJ1IgofKnHyCrwKPk1F6YfQAkvjoruuakmFbmX39brB8KPIcUJog9kAFemG0ZsUSYieDKr7q6PpsSvoeXBePwH5fbM6D9SYbafR6mLxmtsXNVLHVOD/Ey/impR1veF7Emsj+kAOLgxgbRWvWDmxFQf6qMrZ1AhxC9iPPUgVcCq94U6o8UMUSnShSVD/v1OWVSJ9iXplLimlbMXwHFoLJGbKLKv2AZToHbo3DwdhavjvKNFgrk+VKm1r3Ry8q1k2zAS1F8iMX2Vzsd2pBKwCyIlrOK2GfccdS0ks1I2DbhVUOwh1Vcd8WX0L+9Y3lJbI4IYFAlOTK7l4BmOZiYVzJHDCisjhJ2S8kL8+KzL4JI85epSPrJA0GfveX5xuBc9zZBwX0knGJT6j9cbT4plvbC+JGO5f3dtcdQejSXqSRroXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(66574015)(7696005)(2906002)(6666004)(86362001)(36756003)(356005)(478600001)(36860700001)(26005)(83380400001)(47076005)(16526019)(1076003)(82740400003)(2616005)(336012)(81166007)(426003)(41300700001)(5660300002)(54906003)(110136005)(70586007)(70206006)(40480700001)(8676002)(8936002)(6636002)(316002)(4326008)(40460700003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:40:16.1005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4e640f-8ea0-4ee9-03e4-08dc024be4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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

dbg_flags looks to be defined with incorrect data type; to process
multiple debug flag options, and hence defined dbg_flags as u32.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 pm_map_process_aldebaran() warn: maybe use && instead of &

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 45366b4ca976..745024b31340 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -970,7 +970,7 @@ struct kfd_process {
 	struct work_struct debug_event_workarea;
 
 	/* Tracks debug per-vmid request for debug flags */
-	bool dbg_flags;
+	u32 dbg_flags;
 
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
-- 
2.34.1

