Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043D2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8F31122BC;
	Thu,  6 Jan 2022 05:57:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58491122BC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELlpy6dP+NOxlNCGQoUtFHQLcj6puA5zG2yT+dmvaSNkl0PtXqKIZIEvg1Kts9FKC8JHCCHiKgWZtEgvoBgoQSws+NivM9Kgpl4Gy5i0eYPlYfLxXQSUHXp7js5D7jwFB7fFdIdnsjOgQIGeCFbdi3m2btKG3RcXPggv2mTKtX/OmgK7u6o5kfZPX+iLq0VzZfgiPu3m3AsAHkG1Z+FAPPfqoH86SoXnQGC90Ctng8XJRFRrgliz9tUrn6EozTff+rEBcxERGMDW196VYOhODR6Z4J1AoBaga0Mo8JoBoDquuPA1Y8D/oaiMHCqAF8+Dn8NtEbNgJSWspdzY5Q8sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbB1niqTIIRrPwgqSy46Q6RyFqYoJyUuZCVHQYRfJ0k=;
 b=ljvVxEGpXwVT5Oq/x4+FmjDAssQNXyIGwbMKFGukois+5doh+ibwhcx1s7hZoA8PlqSKx41IVtgGtC/pnV40ou/iiLpMaBYWU3LhCctD6PvvVtgnZVaGCMzg1zYWDDIGjAyIOogSeWGg/0FADqbYaMnTTkjKdts/5SnD8qgt5W9NO08aqQAKytI3wTsOaZYNrX73ePamsLS46h8xLFZgt/oIFyUbMmRZs70xa9M9ROzkfg9FncYsCTBWaJyXrKd7aNk1XQo/cMljrM4qYTSYlOAULtAwGGWQjWTHps033PpFJBsTDqTY6Bg/KCIEsxPtv76nFv4PGmFx8Y+5u6RECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbB1niqTIIRrPwgqSy46Q6RyFqYoJyUuZCVHQYRfJ0k=;
 b=YZP3kEcJc7i9I6LwA3iqWNQzoL8FevvtOPUUj4sfo6Aus8KDC9QCEuXFL7Jgcpd2eK8igYuASd81Z4I2hfveP4S96HRLa9FreiM+RT4mic5hk8K67Xb3g7Pfd0PbVThcYlLY4MQ+6VR0f7S31intiBD8/WyMUK4CdJhS5A/cYSg=
Received: from BN7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:408:34::26)
 by BN6PR1201MB2515.namprd12.prod.outlook.com (2603:10b6:404:a7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 05:57:51 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::bd) by BN7PR06CA0049.outlook.office365.com
 (2603:10b6:408:34::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15 via Frontend
 Transport; Thu, 6 Jan 2022 05:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 05:57:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:49 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Drop unnecessary power related lock protections
Date: Thu, 6 Jan 2022 13:57:25 +0800
Message-ID: <20220106055732.3073780-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d6643c9-366e-4201-dbe7-08d9d0d97923
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2515:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2515155C9C23B2BC30161521E44C9@BN6PR1201MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHQZZEiRVATf5Dyp7KN8pWfMO66oNbd41kAxtVGIypU1XHMJ+kKo3SHwXtAu3DQ2sHTGwpDQOz6F2oAVNQVY+9/f8m/4Z98K95qk/4CgLWgr2x1j7srmKaAQnju4jxNaPMA6qLfMf5XeNt4XkEGgyQd4vXDHaMYBXlqlYHvCYs3unnvG1b0UyGuL13EAd2atWrZcurwf9Is9vp8HhjCDMDB1Xjv792pzG5U1Vj4ahNMwD3RzwfzjkfgIoucPcGgg0CEABnHxo7kf5S9jh2SsBOMk/dXruavWZLbYUmURaFkhFKMdK5eXX0gOhMBsFI122ll6mw4tGX6/D5G6zydxO2rxRxujlGnhjbVbtOVrwKz/VRMaG2CJ+ovE7DAf6CRTxW5Z6KK9c0F8+EjOCM9Ka+cuI73F/WF+tHGwC5QEFAD4jUt7VhHBJKvSOlosA48X9F2wfZHChybtFZEOw/rLigEL52qUCxsI23Tdq6d0ukn4yJcCZChwZ0N9HOz5zvPdtu2NAlQEFiPEgkzNpVPWUtMil8TZ+lWOFKOjusxWcKJ1uEgysL9ub1n/ag1+duzuZI2abZqdagF439rwvhGkvU/67QVVcYejX0i9CRN2GuLs0kQ0fcAVMNemQLn+y2SkgPvsM+xidlADr5Ua9XmwKZpRQ5qhLj/580gs/E0b+/7LwaR07u4XlYE2ViZCW06bWvz+nlvVIILfcuhmr/9dhb4qVC5JhdP8RdRIS+MN44nlfw/upsj74XxPHBj5VwKAhNqxMy9NP2G6wGh/BVoen+TgwGn41c8sJINnSrsk5fI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(316002)(8936002)(82310400004)(40460700001)(8676002)(44832011)(426003)(2616005)(70206006)(70586007)(86362001)(186003)(4326008)(5660300002)(54906003)(336012)(356005)(26005)(16526019)(47076005)(2906002)(81166007)(36756003)(83380400001)(6666004)(1076003)(36860700001)(7696005)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:57:50.8040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6643c9-366e-4201-dbe7-08d9d0d97923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2515
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A unified lock protection mechanism was already enforced on those APIs
from amdgpu_dpm.c. Thus those extra internal lock protections will be
unnecessary and can be dropped.

Evan Quan (7):
  drm/amd/pm: drop unneeded lock protection smu->mutex
  drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
  drm/amd/pm: drop unneeded smu->metrics_lock
  drm/amd/pm: drop unneeded smu->sensor_lock
  drm/amd/pm: drop unneeded smu_baco->mutex
  drm/amd/pm: drop unneeded feature->mutex
  drm/amd/pm: drop unneeded hwmgr->smu_lock

 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 282 ++-----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 375 ++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   7 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  18 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  14 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 116 ++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  31 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  30 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  16 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  20 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  40 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
 16 files changed, 157 insertions(+), 855 deletions(-)

-- 
2.29.0

