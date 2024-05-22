Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B3AC25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3FE10E6E2;
	Wed, 22 May 2024 06:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I4bex0VV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7513910E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+xjburTUN7k6fhQsA0SWxyBF0AG2t+jzDS4vozzFykloiCek3TuYxW5Tb3eUVXXN4mt6qC48bIOy/MhrWzXE59sRlsXbBgJsqH88gzoWuIjkNDkiDkYnLTVTlghmKNUXYHddWYAMdLFft1fQHe0gsqt26w1p21TaVeV2CR7zGzH8ZKwq8i/JCYcJjxM8127NExsmyghCTGftNYCS1vnIupn3t+kQZ4X6b4Bv9GL7mD64uY9+tRK7O2TnzfcjYh1yjnOQ2uWYMzu93FJlmJtd1qHDWPjlxs60ilycgr5jI1hz4H0WWJl9o1J9VZ2OnsC+UqkLzpWP+RbauyHfO+rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8oEAW5uIJSzdVXiTqjIHIbkkG/UNCq45GoaAb1MihU=;
 b=YiBO9uZkDqMFMtPhz/XgmUAUA4eyAr8mgqcSr2gR+pWdP9kvwZEOMxOn2cfCegnPYGRQEf5VZGJW3WKEHe06fQN8qW11lFRco4t9TKHEnQRIaUqUut/yQxypFuTd03uNEMj2juRoD7m4Y+qN6g435dBQtipfVToh65a2lFYKSqYIXeNT07X9o2N0SpF1a31TM8/PzfkhGwsx79X43QhuJrlsYWCc7liYOlA1U9iHXhOwCjtASOIUvYU44hNuvBH7QPMM1vALTZIuO57jcG702zPTqd2n/TtB1Ntb1a7/8zfqfdAIOKllF77pNGpEPP7TMCocMclD79spF3nXIlg7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8oEAW5uIJSzdVXiTqjIHIbkkG/UNCq45GoaAb1MihU=;
 b=I4bex0VVOg2EUR65T/growi8cd3bxsWls3gNOFO0zRLvdungtsoAXb0EWwTtE8lH0CgqBSn2MKFDtVSwPuU2FTubDwBYYrfAEgyxXhdIfswF/G5qCT4u+n3+9YH1FGOSvaZ7Vr6yu3GOt9Uwaw+o6jON8IEXip2JO1DnJWz6T40=
Received: from MN2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:208:fc::21)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 06:31:16 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::5) by MN2PR02CA0008.outlook.office365.com
 (2603:10b6:208:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Wed, 22 May 2024 06:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 06:31:16 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 01:31:12 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "Jiri
 Kosina" <jkosina@suse.com>
Subject: [PATCH 6/6] HID: amd_sfh: Set the AMD SFH driver to depend on x86
Date: Wed, 22 May 2024 14:29:17 +0800
Message-ID: <20240522062916.705147-6-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522062916.705147-1-li.ma@amd.com>
References: <20240522062916.705147-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dc3494-bf60-4932-1311-08dc7a28c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SUMshxitcZ6CJdMfYBf/BMEN9h0wnnM5EymX7duWMFFVC8rDIaAxmt9UMFPU?=
 =?us-ascii?Q?bh+6FyBB2/q7fi69/y1F0I9DY4B7zGsuLF90tRBjh/9tXy2hrqjZ3ql7Kf7T?=
 =?us-ascii?Q?HeDwZJsYU2YoCYBuzu+Gn4aAryb8dSgf88gxyz+zkl2fNsmCoSRc/8yd1dXx?=
 =?us-ascii?Q?7EeRk8f7HmQIQfS3vr6fQ8mx/OGvcgI+P6ZQaqEvMLsqwc/KUa6sjp48pp9k?=
 =?us-ascii?Q?eyWpm/KUNDuDNRjdv/9ho/jgO+sGsHdpLVbAcQ0OG+4xq6Wags96sk3HXv+1?=
 =?us-ascii?Q?Bjiai04lEZ34VFmaiG7tzz/yRIe2LAzBe5lNqf6F9/ttcktPpC8yCEE2OIdl?=
 =?us-ascii?Q?WH1aww81VJj5zUF22NPprJTrL6Lz9zcolbeZDFQLdPI5JFpcpSRdWYjvFP5V?=
 =?us-ascii?Q?ETEZKUbgHBH5E2ObURRB9GeOXuIPNywSUX1mRLZgwQthsJRAsU2u3L96InXo?=
 =?us-ascii?Q?0mwei57vdxR6ngClEmGprg8jsq3u3+OEgg85wWU2kN+E/nD4lRU+GJG6VHEO?=
 =?us-ascii?Q?LnZJDbysS44CUlBL6+dSJUzczugFowCKD5UP5K6tJcjS7kSa3zlxaMp5ZSsg?=
 =?us-ascii?Q?fL3Z7S2B82dVANl04iZt6d9M/W0mIa7DoWdm9D+8n7u5ZFHTjjdhGO351pte?=
 =?us-ascii?Q?MHohrKMM/mPC0rTua6LEmKELkpwdd8nVcZTM/WYP0ufjwUe10kNG80Aj53/a?=
 =?us-ascii?Q?Z87uz+y8hrixbrt8AhZCGYGV0UguQbha5LFzd+yObTprJ5+0ufcvg7IH9coj?=
 =?us-ascii?Q?Gs7T9RrMTDOHhdlo6KutxcfEE6kT/Jld7vWGAXOka6Nx9yZZ6u9l7vRgWFl7?=
 =?us-ascii?Q?b2hoYa1fyg0l9GDcUD5rk5w0Q6u6kf5Km4VSiZaWDHHpcgpflu6TZlU79P7H?=
 =?us-ascii?Q?km716VZpkhx7FDR4pylA3In+Flu8NtGBKsgm2kW6/+h6cXAZYgT2tFSjE1rg?=
 =?us-ascii?Q?Hxoif0XEUKpDsuOskt/vipry+ROUO6qbotEZjcMRbDroXYo2FRjIjSYhO2vz?=
 =?us-ascii?Q?vgRAgQg2hJU0oOLzCvaejC80JbVq+HM67z58QHfn9P1DIxSuoNruZmvq25p/?=
 =?us-ascii?Q?swDd7ynNeQ5ventOmWo9Ar7Aa75MylsjoXCQpWuz/kn13XSzknD8PJtJtCmI?=
 =?us-ascii?Q?bc/OAxoyPU5+P6vJhpSSaNWmwvopBj+5UdA4RqsG/3s2OuJwA3mjBqmDplTe?=
 =?us-ascii?Q?+p8G+gZcAyZ26lYlfh5mPnim9YNdLSl24hduD2ZTDD9j87LR/5gTe9NdpK/R?=
 =?us-ascii?Q?afuvmsjcKH/bIg6tyJsLZ6blxQ7ZvcZNOIFpFglO3Pg9UaDynKawmGy1njAf?=
 =?us-ascii?Q?QLEyZuL/95ttdIaWjnAu92yW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:31:16.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc3494-bf60-4932-1311-08dc7a28c87e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Considering that amd_sfh exists only on AMD platforms, set the AMD SFH
driver to depend on x86 to avoid build warnings or errors on other
architectures, as shown below.

drivers/hid/amd-sfh-hid/amd_sfh_pcie.c: In function 'amd_mp2_pci_probe':
drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:413:21: error: 'boot_cpu_data'
undeclared (first use in this function); did you mean 'boot_cpu_hwid'?
  413 |                 if (boot_cpu_data.x86 >= 0x1A)
      |                     ^~~~~~~~~~~~~
      |                     boot_cpu_hwid

Fixes: 6296562f30b1 ("HID: amd_sfh: Extend MP2 register access to SFH")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240228145648.41c493ec@canb.auug.org.au/
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
(cherry picked from commit 90184f90c9ac559062a04aca72e5d05730164de0)
---
 drivers/hid/amd-sfh-hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
index af752dd3a340..329de5e12c1a 100644
--- a/drivers/hid/amd-sfh-hid/Kconfig
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -6,6 +6,7 @@ menu "AMD SFH HID Support"
 config AMD_SFH_HID
 	tristate "AMD Sensor Fusion Hub"
 	depends on HID
+	depends on X86
 	help
 	  If you say yes to this option, support will be included for the
 	  AMD Sensor Fusion Hub.
-- 
2.25.1

