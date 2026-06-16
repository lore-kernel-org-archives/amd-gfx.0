Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A99CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1973310E83E;
	Tue, 16 Jun 2026 21:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5i8Z04lE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF2310E85D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd7HPQ97WkOQnIrgfEdiZYiSr1C5eiqANhHkAHZfVgwDa/t/fAvsv2wITekRJho5Jmy1pw2OMG23rpNgVPFzer2GVoWEteO+ihkjYhcCxzGC283pdGcxarlDW7Pzf2v3wNQZVV5XThSUQtpj1MI1V6GYJT4+9sd35LS88A0rddHRixg9TS7r0bHQMRV52ZxbDcYBYyI/ZbwHJjbtdFED5VEbWDni3vGRSgXos4H9Av7nT/W5KYOujN8DSKL6ycRx932JJQf+z3vjkDAMJBRDrmmYnOAqZGBFoPwjyS3i3VqXR6+P5pC72cFMPNfjTO3UVcwByBJMIA0wKSxQhe43rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAmLkY7LBAb4tZAyebbsny/JPoGW4flo3QPMfJn0qDE=;
 b=ERItRQfbsWptZCRbX1zchiuQiW4JZCVL6cQctraFVKWODKQnm7KWFKLMiplnWU5EXzsw11ve1L9nqUc+rFD83+JZFJ0wYdnWN8hFx7dAJ3Ii4lO5w1WR75VpWlJM/F0G85uoDhvGnM1D7YGNnZowRgbPwkGxjpASDgI4wZJEt+5g7B4ETHzr0dCInVq6qmlTMwXIu+gfSMvKMxT/WoFBaiYeufuoEpSFfE14g2nFiOLV/sYs73feg38buh2kIBJ2f/IkodshFdDsUVO6oWEVCH7UoNbWVCJUjS/1+EqCHNPCArZRDcKjg43GaN1MiHbI+1612c9sPUeuirm5zGavtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAmLkY7LBAb4tZAyebbsny/JPoGW4flo3QPMfJn0qDE=;
 b=5i8Z04lEC9577X3S0VnQ2xtpIeQlY40Qanq2mPZNOdVMGi57ry/AGXob4wBm7tXyfcX6EV0qe7PRqrw+FNjzTB/SnULZkNX1wnmCDCACrr4fsbz8GasZxJM6DZC7iP3CNYn1gVWYYmZCOWYXp5oso8ZIYyrqtfHrIqCUoHbE4NU=
Received: from BL1PR13CA0139.namprd13.prod.outlook.com (2603:10b6:208:2bb::24)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 21:17:22 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ab) by BL1PR13CA0139.outlook.office365.com
 (2603:10b6:208:2bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 21:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 21:17:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:17:21 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 0/2] drm/amdkfd: Unmap SVM range when all GPUs set to no-access
Date: Tue, 16 Jun 2026 17:16:50 -0400
Message-ID: <20260616211652.1962285-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: e3acd036-2344-4b84-a22a-08decbeca7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: g8R9Zfah6hsOTCPeBBsHT2Jhgls1PHnhTPKUB2ZWdWuzOxF22nZU1T17slpI6FEyxf452JWqGHP3fr4eUGkap4vJzUjLsPugBo+5qLcqz4+dzqNk7WEiAY0tO/+veiRb5C2n4rUbL+aZrjERUwnfk2luJOK2E3TrIub5sFC8q8pMttPFtdoLp1qMDY6urUJZu8MeDis4JQE388rHTQ1k7uZvlFgnu0rCtIuus+NbRlPcOw0Ed5UWWh1FDW5V0WIqxvH65mvfDQH+Iq1ndFYFEOfINgpmBng5dNX4+lClACJz1C+BWaty25G+Q9Uv72jXeQClEGQy18NTBiJKf9fLj8Y80NXTrsWRjTBXT+b+oVieZx9eBorCV98g7BZ+0c5qw3VOLrwgMOhAtCWrUGFxlUxleerIRn7EA9GyWKSLok+YJ8/8xaCZLnETZpFetcNuDOEvW2xWUDPkv1psOsyRS3IvhBUdvdkK1eVingby24UUh7d+ZWrS9fCURJHWrjwRvsX+Yl29L4EcCvKkAabe0gfUrCANtqBggenZGSrlTdjsMCEJHKZPE449S8EcLql7+VoqhMlvBusbw9AHeL0TZ0RScO1WOzJTNQDLpgvuhq8sPWpoaIYjIn0pwOGU8KeRnrzj0aZcNjEUKXayljYnninbi56J9FGh/Z2Iy9Bh8W1iVPkNM7/p8j11klHWisD4+CNJI8Xgu9VzwQfSi8zzpdDjCm/5bV/GVih/P0GnWdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SWLBSGlObCKZf1hjPdeqwvj7T4uI5lt7MaYHEsLwUBVCck1VayyflxH0zlhq/q95/VJyn785Q2fOENv5NNJdMHKK+ZIG6yke2ltXsXpcQGT8oC28psSL930hG/QI1ggY8gezCIAFGlm2FzxkN5oT1PiK1zY144pMGwBQ5J+Q6sdA9Khhgk/8agwy5e4Dgy3ssgHQeL2rxmEjvdK3KmAtIhTle34S8p3UdbYjbwccrGU4KbwEX9WrLS/BNc/pvOowaqT7XXB7/8wD7kLTnDzxIz1Im2w5D1rfG+GvHCI3lOy9Y6cytso6lJ9v6l2UrjCGaGps96auwxzGN19CYRJIyix9pFCEf42l8H2wdbsLzOP3vfU9D8kGCOgpjhKe1CvCc0B7+aJf9Dm55TauIbwz0/kxDume+8evJhfkGmPOjMrQ1FczO/hJLZ0i/A6ILNSg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:17:22.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3acd036-2344-4b84-a22a-08decbeca7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

When an application sets KFD_IOCTL_SVM_ATTR_NO_ACCESS on a range, the
previous code did nothing — it did not unmap the range from GPUs. As a
result, the MMU notifier still evicted GPU queues on CPU page faults for
that range, even though the app already indicated no GPU access is needed.

Patch 1 unmaps the range from all GPUs once all mapped GPUs are set to
no-access, so the MMU notifier skips queue eviction for it.

Patch 2 drains retry faults that were already queued in the IH ring
before the no-access unmap, so they do not generate page fault.

Philip Yang (2):
  drm/amdkfd: Unmap svm range when all GPUs set to no-access
  drm/amdkfd: Drain retry faults before SVM range no-access unmap

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 188 +++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 4 files changed, 123 insertions(+), 79 deletions(-)

-- 
2.50.1

