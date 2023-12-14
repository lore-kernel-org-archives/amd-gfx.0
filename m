Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2121C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 22:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77EE89220;
	Thu, 14 Dec 2023 22:30:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F02310E98F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 22:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhlPSTcC4n6cQawwQB0GRHl+Hj5W9tB4o0gqSNcMOtw0mAo58meknAiwIM/lb1pS1wB3TDpFqWBC6fqyqqApSL+ubgjNSmuhN6KLGyN85GGgqIZ1g9w4NSBWuOfFw8Hwar98slJTFu1tYSJQw28Bt+wdWHBj8JlP1YxvP64jXZYSoeYABDSDxuXxYiNxnQ2HRt0N1FXYnVfx8rjkvI/6wEo9hYCKCudkF62mb0lg2UBFy6+Mgfcxv6h9sies2IYELkZH9oyOloMKjyWs9jQXeAKlElCrxaq1UGb+f031FTXKnyQn8j6/93Js7Au4d+5D/M0lJTThLIoa5FENmYTZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=i51JjBvrKHK7UVG5PI0rIrUcMzEI+6gm4RoR805YMAdd6lgFfSvQWr5rTeTv7oW2p6GsxPydxAKsE0ypdMYMvE4WcoGfc3Dv980pBQXQ+n+RvKK9RVx/tKYuZxNPmlW7VchB/EGQpWJmMc4a57eLpRjFlveRC00mWLgiMmhOX5gHsNHPtRUwrYQVJziDOrQSqftLggLZGQv+qkFgB2jvXva3DZ99cMbeB4rpfqWBblZgcp5cJUR2XrzUJ3UtIabwAP4Lr8Tzze1AahlgtJJ4saMLv7Q5UKEa12WspvxgDJuZb/efAJZqT1Mg3g8oybpujxqgtT+a2SiSPp5FeBbdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=prWcz8jnDdAIcoG/E10BF65AOkiwSyfWuqcdLwamsdjUIiR4y0jmt+MdzXBHSImfQxsGqbsfTaBSgZKUGH/SBrxVTPWGAFgBCvFQD+nFZxEADxw8JeAF2WMNMYa3MMZHQqEFoqGtYsyRH1uzh4AtpbevIdgapzCM9o0bSmZEdGE=
Received: from BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::30)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:30:36 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::a9) by BL1P221CA0018.outlook.office365.com
 (2603:10b6:208:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 22:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 22:30:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 16:30:33 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdkfd: Bump KFD ioctl version
Date: Thu, 14 Dec 2023 17:30:01 -0500
Message-ID: <20231214223001.218746-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214223001.218746-1-Felix.Kuehling@amd.com>
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 384efc67-0f0d-46b7-c3bb-08dbfcf44a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AI/HB1A1JPRM8siFMChhQCmmA0CCPbvxCgDMGGNwneu+TN4K5e9LmJW3Wk3iwfG9wHw0R4Kjq9D47Py8Nm8rFkB+UI4lGKvQ89QNZbIFaDZxYV5s5y/YihHbJL+brAFVaBeopAr0NFIc7yK++rdv3eNeNKTHe40MM27tENhJXYfyK93zo/mQTpat1IYB4/YquBRMvnKiZTKF1iDrbR3a75P3qPp3vSGS/1cp9hSHx90bDYshKrJ6S39UM839KtNOkDxOjfP5khaG+EmjlSRt1arS2gn/Or/QwiyZHa1/PNlU3wSNDj1I+PUTw+kFWKUIKesXJFtzrOl/v6fagmjaUrGAT9RjkIk7pm93zZJGKLPtNdFpuWgZW0QCjB9ubtyRWkiOzUQpva7khcu9t1k/qBhqzHJMBMxRn++QJXGE2H8S5ZPf5aqDQJKRqmzaWQGQX++EkagE81IiB2EN63ORhvse+7nMcNQGBk7jQBwrWEYyh2NHjAWpR+fEKLuLcPVdtEU8R3YzeAshRiu7V0GVWt76o3sMnjQ1KZ5S211+2LM33RY++aP+f8yGHfswwQzS4Of5WLDTYGaweaB0n4xQ8f9vAIla7IqfQmrdeyIeGbFj6R9rjJbkFB60y/NSBQ2tzyi91G+ZcF2ROtpS+pauqorrijJMpPQZfRnhQNpWVnOc+TPZoyx2fXf9L3RHXVhVrQAEaOJIGOVE7vYxLrS13jjQH4+tagH3y00sQnZkCSoBCNQk2tKaV4d04DX9Fo4EONvQaYeMGCBzjEDr+t++ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(70586007)(81166007)(41300700001)(6916009)(54906003)(70206006)(36860700001)(40480700001)(1076003)(16526019)(2616005)(426003)(336012)(26005)(86362001)(40460700003)(356005)(6666004)(7696005)(478600001)(4744005)(2906002)(82740400003)(316002)(36756003)(8936002)(8676002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:30:35.5244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384efc67-0f0d-46b7-c3bb-08dbfcf44a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not strictly a change in the IOCTL API. This version bump is meant
to indicate to user mode the presence of a number of changes and fixes
that enable the management of VA mappings in compute VMs using the GEM_VA
ioctl for DMABufs exported from KFD.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f0ed68974c54..9ce46edc62a5 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -40,9 +40,10 @@
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
  * - 1.14 - Update kfd_event_data
+ * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 14
+#define KFD_IOCTL_MINOR_VERSION 15
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

