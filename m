Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0632BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F5E10F275;
	Tue,  3 May 2022 20:26:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD10610F275
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL/n036JtXHz7zmPAICiogTzP2PT5GeSfyE5ehfltbB6yXT6GWN7KMk3qZVOFQuVmtdvi7XRFEuwl9+2ZW2U2pSxYhZrDYXTxLrj0QdVW4UxNw1End+7CzhXJeiVDYh/wG3t8jAYNeM2YZQ8SGPFphrhBehnmWKpeedT1F5iXEwR2j9GczYBKZarNPr73nRJJ1DN7azl9yQZ6y0TaRopylT2kx7OrJ6KsLaYGiY4soCQqMd5GCm1pMn2OqMOb0D8weWEryCFiedICU/0PhVCw9plIqdhpT5gu9eZ/IhTeHqOr6EqZpQS5OrorqMk92F2te9Zm51i4TeF4AEKRTdjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu46pRlc7LkKGuTjvPB/dSq+ytHks4kgvMoiuUxfQaY=;
 b=F8XoCzGZqq60lProoG3T5EqOH/raOvB+3aYl5CKfDkhCdZW75R4sjXba8FeRm5kv+bcCY1u0DthWEkAXpnQeQdId4YrXluRdc47kZQ+xINcnfYi1BwNFIkW4rOAQGFt87VQ99SlVsW78WcNdkNuBIOiPV4VqxnyGreEGDAhx6BWedtohvXozcFBB0uGKJ6qiIUQdDZaEvKGD5ejwZZMTKtb4v3pyN6h3GNrOonqac44wEmcvU3Jtr+GGEcA7csmZtVu+Hv+Rx1Wg07S6Q3saGfl/O09G17593B3NYMHh7YnwWVSYlCezFmxgVPFx789egzmtsodMBQctKJrRCcoYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu46pRlc7LkKGuTjvPB/dSq+ytHks4kgvMoiuUxfQaY=;
 b=2blf8DiDcCnuuKkmhvmOfC9rlT2kv2NcGdgwmbqkhgH9Mc0XygOhdoM1jeKCkBQ1yOhf/6rbUE9+i058qHG9KK+KcmfVi6jRo7r3zCWEDaz9rmmMPC4fwe/Wpo2FhZ+4/6WTdVWKi/f/cRR8zNM3vDuh+cuH+dyx0PFgYQ4ip+E=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:26:39 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::b5) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:26:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:26:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add MMHUB 3.0.2 support
Date: Tue, 3 May 2022 16:26:25 -0400
Message-ID: <20220503202627.1210404-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f88de51-fc7c-43b9-1cce-08da2d433a92
X-MS-TrafficTypeDiagnostic: DS7PR12MB6120:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB612055ED1AED10A4EF830718F7C09@DS7PR12MB6120.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVIDqfWSJiLOEbeaWA1ADCYmJe0yGU4/5EM1zrvxaGchvuM5mku7Rsj3kbqhgN3WYfrZ2jYMO3eswT0EVxHK1XA9eidLZfF6IjNXXju3n6In1HbdPE1RyXnZo0pY+t2UrceNWBTnKbN+OEjQ1H6bvjTSV9eLKTx+trKk7ULbcr3aLThyXBE/UwxKrHvChHa1HWJMsgbx6z/Wa66U3Yas8sALsObVSyIPWeYaKKKGobF2F9nb04BMg4G9mu7TfYwFExvk4P7aY6MLflgtqhl05DwMwG3O2OGfLbmN6cYtEiX4CmaHPt0TzFrJa+7uKXFM9P43Zd1cnd2IPoYiW3DFmVLg8DvvFeZidOlL8r6Pb7IUxErHnsbtN8Ls81xsasWso3nzZ9uSVMf9lAzcb+LaZMYKRdjflG7rHRYbsYDR/WeNLOLJ+OIgzFso3NAC1vq5PEzZNMX/6Gh78Teer6jVOsvv4gZvUwgz0psLz049FDAIWP+44PpbKPctbbJU8Bj+Z93UJofAmvn4JITAUKte0Nl8SoVDAORlTsIKp2rf2QsrYKHiWEQGuo5b2ksyM4x8KqqRm7uIpEeNxHYucKUQaWy+Tr34fI+qBYROnnSSMrcAMvoKIC2CxpGwJVKAvMIibYydoIMKecPlVLyBp3SQWl4Y1a3gGakaz5FmfRtsyjQ//OZTLQmCAH/HFijV+Q8oBCu18cWRinakwnmIVwuxkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(2906002)(26005)(508600001)(8936002)(356005)(36756003)(6666004)(4744005)(5660300002)(7696005)(82310400005)(8676002)(70586007)(83380400001)(4326008)(81166007)(70206006)(336012)(426003)(47076005)(40460700003)(186003)(316002)(1076003)(16526019)(6916009)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:26:39.4434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88de51-fc7c-43b9-1cce-08da2d433a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds support for MultiMedia HUB (MMHUB) version 3.0.2.
The first patch adds register headers and is too large to
send out.

Hawking Zhang (3):
  drm/amdgpu: add mmhub v3_0_2 ip headers
  drm/amdgpu: add mmhub v3_0_2 ip callback functions
  drm/amdgpu: split mmhub v3_0_2 callbacks from mmhub v3_0

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c     |  571 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h     |   28 +
 .../asic_reg/mmhub/mmhub_3_0_2_offset.h       | 1425 ++++
 .../asic_reg/mmhub/mmhub_3_0_2_sh_mask.h      | 7228 +++++++++++++++++
 6 files changed, 9262 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_0_2_sh_mask.h

-- 
2.35.1

