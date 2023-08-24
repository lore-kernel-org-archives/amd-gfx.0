Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26238C7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7343610E5CF;
	Thu, 24 Aug 2023 21:58:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2271C10E5CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrE5Irgo+00Fh3AkSAw6YzNlBri9ga2HF5oUngAqPkpfFbiRpcMv+piP3N3lxzHzHfEr/wHYbheGqV6L/x8VW1Mp3B88l1O4CpKkxY/rNQFNEwPSGkkOo/aAzKL0AB/8IqReCuFddVWjQe8SSLnes9tGq1F+ELX3oWQDXH39VHVyP5wLoie183ZE+nHM7STH26RwqAtzOchIta9A4CkTHRPSLwYVt/bUxGwC3FJk/sYbavZ/rdvEQNqeSPduvltCZvsH6znisfgzAzUG1oSI5ofHDIUrKGQ53thaWP4p8MOEWVaEb1wqTpIszvEhmh3XR7h7yhVon9vmIWR/e67/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkWAEBp2qT4gFMYmH99SoOAQflo2gCkbTNjrgkppawg=;
 b=oaMXqVGTWdXG1CkRcMhxAWZOUfBf2GD4Cbkxyn1FOuv/h2L3zSke0ik3nfoqg6EJY5YhVq8WcJrr3wz7+KnrypZLCHv0pnJIPa8VgYVA9wHkBsu2jZJMXt1YIYNRbP8KG2bAV3GtK2IbMPHFgKGkL1zaNB+hiRSZ3mGbBUezQDfxsu2a9Tx+J/XOyaFpy1/eID8uh4uHI1B1LfJDDoToACQKj6MwmBxN5nu/YAO4K4x2EJbHOm7KaK8qbnpqw8KAo77Oze0Lu4pMt9kVCu6+CtwMZZByrNTTv8U3ku1qVe37qRmS5NinM0dshfQThOQhkPnHazire0669TEJIm4kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkWAEBp2qT4gFMYmH99SoOAQflo2gCkbTNjrgkppawg=;
 b=Yvra5t5/Y0ZsvO9jrh51vx9qCUzNaoXW6RIjRN2vJmYWOlLPIatSUY8b5g9bB9Ie7m4+NophiHdDo60rD5d3fEzaG3gJoh/hXPZyaXQbbKaCXzS5CQB7J0qUk/ME5xtAeBgI23wzSOGA9Pim27Dwuk0pe/qSWMXQnZMxs0fmz3A=
Received: from DS0PR17CA0007.namprd17.prod.outlook.com (2603:10b6:8:191::14)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:50 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::96) by DS0PR17CA0007.outlook.office365.com
 (2603:10b6:8:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amdgpu: add UMSCH IP BLOCK TYPE definition
Date: Thu, 24 Aug 2023 17:58:23 -0400
Message-ID: <20230824215835.2740115-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: b56e45ff-b637-4af6-4e12-08dba4ed4cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVClv5dDMsflgPsZ96bgejxLbT6FuidMwZCJngSGe9FAheYHxT2U49MOPu64GSdqmJKp0wTNywvCsbZpqhikxpyP5ToCE5JeMUWGsGNymbkzyj1xvTTlxgkHPCCDuBNT3Hv0qWar3PYLljzijpsepOF5iJ6QrC2qRWhLSxFLF+O/5VOVPm4J7prjVvQyo6PAgRajrOU7VTESi14WB7iz/QYSznekqlFSWufDZcSM2wE9PS8oE1oKXX1xrcuTPDATs6/+Vo0cBpGynsLTeYNX+hnNVGf0v8y7Tws3mkM/fZ0L3nJE3nA/ULVmM7HXVKccOHn2p9sVV1AAjNtqUmt+Ez/Aas1JbR9Eov6o88V6rBqCvADI7x5mr53mgpu/jFJa1KXPsWyPGMOjhWyJ4VkxelAq4hSJ7rrKgaodRyzHR9joiyXQNRWlq9AFH+G9vInlYnjCojggKDrajVGPS88f6cBBaZ+waTNEUc2rpfjZIMjJGzWNzq4YPdlPylcyP1zR3iojWmLDUGfqTYck9NC+TMFhUsw3e7T08u5wd0iKiefKL+N+hGp1hgdNZjO0omBvSBzmsaXSVABVwpporOf0o5fid701JqntluVWdINSCATwihmdVXeld6SrZDrOYbUPjwmfFNdct7YLYH9XokpzWEQUuTOAFFjG3FV5Wn2Wq62W5PqYfOM3v8dj7VHyGRgOd1bBeSeKwtWxGcYer7Yl/FF0ALlUZrZGD2ze9ijgXEmQgLpmhtMlXN0jji7ylmHQbE5XkmbxV8KPDp0lgs+GeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(6666004)(7696005)(478600001)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(16526019)(2906002)(54906003)(6916009)(316002)(4326008)(70206006)(70586007)(8676002)(41300700001)(5660300002)(8936002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:50.5961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56e45ff-b637-4af6-4e12-08dba4ed4cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add IP BLOCK TYPE definition for Multimedia User Mode Scheduler
which is a hardware scheduler for VCN and VPE workload.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index bb49537237c2..63e2153c00c4 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -83,6 +83,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
 * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
+* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
@@ -101,6 +102,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_MES,
 	AMD_IP_BLOCK_TYPE_JPEG,
 	AMD_IP_BLOCK_TYPE_VPE,
+	AMD_IP_BLOCK_TYPE_UMSCH_MM,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
-- 
2.41.0

