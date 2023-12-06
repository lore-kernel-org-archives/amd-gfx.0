Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CE3C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 21:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E5910E7B4;
	Wed,  6 Dec 2023 21:44:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3812310E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 21:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMQZ7IvQVfzV1kdeyQXm8b1tvLGsbXa9wXW1XG5aKqUOqzaSM+0G897ca118c0QpdQfNE9aOojvXT/5D0SGxP2ky2PF9afZw2VL6ACrDWcdGwUDRaU9eefxTsJA/gdWCn7G203SxC5MlqtEZTsUMOd4/1DT/uQrgS6Xd0O7Ne7fbdl36hELO5Guv5NbsspYHeBqRgndQhn5g37SzE61ZKtsJZaj61mgQ7s1DFnOIUW2dmbUMpKH9TveQ5avYEgOEH6adcXs1hisRAPYRkkJTY3zcBMxh7Fc7H83UqflaHzYit+QJI3TD/M45vzpXHCp1jhJ20tsL7+HG62xYYla6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=HJN/uBWXNpU5J7wYG9AVIKyRUXfFaqvLHlJm2qA8m+UGWbxUzct/0jyoU0SaOb7zBbA80Dc/U5ECKdgGRAu5TciURVdPIpm64ylpC9l+r7V2xGO52zQEz0UnbEL3hoB2hp/u05QF1pi7pl+HHHi9vnZ5HuqLhbEghfgzzg00G2sstVmz7wTpOwhKTf+R++xjK79FQJULyukasd9qeEIBUa4C9aQxF9U6726i5FsCECt8b0gGGWFtjWuHRWbH89U7fVoyQtxJreYIjyg8Vg51dTPw0gL05tNvCNWElqDQNLOqLs5qiukuRZQfscqCkPfgCL/flfXdBdiCX5NlgWTlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq1H8WCJuAL37SctBUPuPK3Kqv6ruPc+2YmbD5MHcdI=;
 b=r9S3A3jF/WAW1H0dDdlRgzCqX9P7Ia0pWHO2A3C6WKRorN2XCgudMJqLo0C3Ry8k8fV+kz4a5+IVk4T3mKibZcMuYdolgC8/OvojI9NvZCRuhVaDlec4LrC5tjAgDyNeLucjJL17LlG9RULNZrDcFgVyn4Z4RQjbr7IbU1uNa28=
Received: from DM6PR11CA0040.namprd11.prod.outlook.com (2603:10b6:5:14c::17)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 21:44:49 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::18) by DM6PR11CA0040.outlook.office365.com
 (2603:10b6:5:14c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 21:44:49 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 15:44:48 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: Bump KFD ioctl version
Date: Wed, 6 Dec 2023 16:44:13 -0500
Message-ID: <20231206214413.2440998-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
References: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 94edef38-bb60-4627-56dd-08dbf6a4926c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfOKLKK6k9Ai+VJcAauKL4OXdV/XFiYcPD6NDLbsFtCKhkDAQoHtHS63zT48Q3Dde7N7kpfCmeGAlbyUHz/nKjNutSSGZGEP5vy0abHDHZbBk0Kgz3jpZTAe2mMLNjy1idSSm42BDFlt17RoVPaBAi7IpipYcneWwS1jT1Ilaf0POmubKJ/UXD5AEIhwcovefpEahOVztLm1xHwcY6Z42KgK+ezA8Ly69iq/T7MLBjO7ArS/QJqhtYG9kVw+KS/qEbIsGTrCgE7pOaRVtkgfcMGWyZ2UZm6sqtA2v5RGVX1zPIjkhuZemQQL97KbbxJmvoVczrX14KlW1LZ/bSofMeOhFHcTAZAndXDjbVUXq2CNHOOeljItN0mctaqmnU0MtP5kQl3TUExLkEOAHujA8ycli7JSWc6edZKnT5Aka5ZRyNQVAIHAal7THBdmYrAVMEstbj7N9anwN/oixP3Ocg4fnPGLEVheSTd8qkZ84YPOMJkrfq8lPxJrewQdkkOfVL+irVw1IZf5F73PeO0VvvqIePt4Q5K4An1AwFREax6TQ+KKniWeEB9xXYV6A8GAHIUXkoHyF75Qj8uGsQAg/B7bxmGpL532W5qY/jtr0BU4mrSUnptGXhl0vm/oI1dVA2AMMDqnOVlZJJPPFBBElCsKUBJyDcRJa8sz5ixRWzORspwK4eFTA/k0WSOFfoXMLYDk72wZF0g2qTR3EfpkuWgD7BzEEWjcQ8G2ufdhAqC0mc9aUTWg6PYDoEyrhU7lEJDixpKT8fJtKtJC3mlN2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(8676002)(8936002)(4326008)(1076003)(5660300002)(36756003)(6666004)(7696005)(478600001)(70206006)(70586007)(54906003)(6916009)(316002)(2616005)(41300700001)(2906002)(4744005)(36860700001)(47076005)(40460700003)(86362001)(82740400003)(40480700001)(81166007)(356005)(83380400001)(426003)(336012)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:44:49.3919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94edef38-bb60-4627-56dd-08dbf6a4926c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

