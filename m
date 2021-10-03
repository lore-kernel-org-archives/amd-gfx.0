Return-Path: <SRS0=HyUd=OX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90505C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC09611ED
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AC09611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3035D6F591;
	Sun,  3 Oct 2021 04:47:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3AF36F58F
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Oct 2021 04:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZILyAB6MSdF0DLumrVwAALCuIFhgZCvTThp2IrFNLY/ujTJzcrK1hTHNaDdEqRrjZ3FCwySL9x9nhTIunguaA198gnAirrTNmjBlF3tpzZgghUf7KO2FfoGAM8/iH3xZX7Qg/qVmZLpthzFobvOYRQRF0Hf8YK9ihdAZuhV5/3Goi/7sQ8Ax3zeCkCrS/EWcNFMmBFZGkhgpZE2UXuRqfDOUBAZxOEgYsGJbSVSI0HsB/eP4YYvosIkVEweIxYRLqmIDTfUkMQJOe98JCckIigYc7p4xXfIrWddT4wQDEQdShEUYTPCmzkk0Bbig6zYVJswnyrM+q2iz6mCySQ+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8qdolLZAnlWuR/YElFXMnE+ZeJ9xU4ZroeSlCSbiU8=;
 b=k5yIlYP525yRxWjUmDuYRMRKQ7MCj6303M1y4LtGHtrleUG5lgSabyDTmdlbgHIhRT2Khs2VJOatwu/ueCfHYwN1QYKWTZFCkPwEIFGskLLAiVejQ7r7wI59p4Y+FiBqasEGOZQYBRT/b3QB66NrLDzeMg2mJRuTnK6ILPqe5J5KrAneANLilVDRlu6umLpMALY8DVeKHyyqXXqNs3MW32UIW2hqWR/70zeEmWyCk++OlJ1YiKtX2YbVvmctJbiH+MCEvOynhkYm5dNJ4wAWm9inxeswGdLuWqHqzls15KfuyoynWolvX5QfFr7mt1Vx6nG2hBxcXCQuh6p1bUCy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8qdolLZAnlWuR/YElFXMnE+ZeJ9xU4ZroeSlCSbiU8=;
 b=22OhCe6XT0v6PM29XeLTLDUx3DS0DlsBJHbL+eOY/fr7aoQfNcCu9G/LVo2jTjG3L998yYJlk1AlEHieZ9xBlZBvvrQey9xJc9vVyuc+tNi5/NmduUZG9iJqYXbkqcB997Y/viz5282DimP4U/39Tvrb4lHHFPTgZdIN//w8rgk=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by BYAPR12MB3381.namprd12.prod.outlook.com (2603:10b6:a03:df::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Sun, 3 Oct
 2021 04:47:27 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::99) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Sun, 3 Oct 2021 04:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 04:47:27 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 2 Oct 2021 23:47:25 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 0/3] Add limit_type to (pptable_funcs)->set_power_limit
 signature
Date: Sun, 3 Oct 2021 00:46:55 -0400
Message-ID: <20211003044658.29238-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86fc1dd8-44d8-4160-4bcf-08d98628e658
X-MS-TrafficTypeDiagnostic: BYAPR12MB3381:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3381C8DDD31FC9D99E64D2D1F0AD9@BYAPR12MB3381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEwOvRkbPMITDUbN17ZP6DBhRJS7mjVmF8pCmYiCdKE3f/fjJIi+z8UyVohy5fUENJmamxtt7WhN7filxnyyhRQVtMWX/WY0F7aTfnNqDoGwD62gIWc31LLT3q5gOvv7ifTYNbSuCUGe0dLN9gpjipJruFnYsIYJGAG0wbaSaPKOzgnDcSGoHuNtyIyT+/Zy+1ca/jHT74oo89jla+ZfPRo24wayaXMja+C0jMftCrt4auK8Gh/rxKLZRDbyLH2UPv/tqLxLqkEr/uAAXoAydLJkx1Cx+RIrXXDiN/dSZiCQyJ4cyy5Sxhj2lFA9Yfy9SGPTEnW1s/kFfFBClR7qBigpcW7LI1mpXEaK8n6gJOde09qBWArwJG/SYya6TUfxHlONstvCevMyUNzpswfIQWKrCh6UQb/YuW3xB3cHy/XfxJAjDB352oIfzhnlnM0smzTgds46dLy4DkXvS+YSBSFuz/klLfY6jlH609AvrwruiMeATZ1nOYgGWDVwQyghrhTOGcDkyqpN7UMEqdEpOutRyOeP5iIBzK3s+WtXsZRDmrM0G+/UUsUmlfVD9jeWFt2iPzBvEXwlIf+0Tlwe/7CWcHTHiRzXiyJAZuVhFYaw0EEF42Cz32CCfhfQfBJRSgnW9qnZLRATyJ2OnBfdOqUHxihAnaJwnW8EkP2zVYQAvo4WRl7EaDiNpnN8dbRsCh4IFmslIp918S9tEujjigKt6sxjegier3uHZbuNdlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(2616005)(83380400001)(47076005)(86362001)(82310400003)(4326008)(16526019)(8676002)(316002)(26005)(5660300002)(356005)(1076003)(81166007)(36860700001)(36756003)(336012)(8936002)(6916009)(44832011)(70586007)(426003)(7696005)(508600001)(2906002)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 04:47:27.0566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fc1dd8-44d8-4160-4bcf-08d98628e658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3381
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



=== Description ===
Add limit_type to (pptable_funcs)->set_power_limit signature

plus two small patches
 Fix for incorrect power limit readback in smu11 if POWER_SOURCE_DC
 Explicit initialization of cached power limits in smu struct


=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.3 LTS)
 + Kernel(5.13.0-g9e50250d2084-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ d6119c68a46e
    + ca5057580168 amdgpu/pm: add limit_type to (pptable_funcs)->set_power_limit signature
    + 6e269294d363 drm/amd/pm: Fix incorrect power limit readback in smu11 if POWER_SOURCE_DC
    + 50715de0a584 drm/amd/pm: explicitly initialize cached power limits in smu struct


Darren Powell (3):
  amdgpu/pm: add limit_type to (pptable_funcs)->set_power_limit
    signature
  drm/amd/pm: Fix incorrect power limit readback in smu11 if
    POWER_SOURCE_DC
  drm/amd/pm: explicitly initialize cached power limits in smu struct

 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h           |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h            |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h            |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 15 +++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  8 +++++---
 8 files changed, 38 insertions(+), 19 deletions(-)


base-commit: d6119c68a46eae0b48c77353aa81e6e38b009d24
-- 
2.33.0

