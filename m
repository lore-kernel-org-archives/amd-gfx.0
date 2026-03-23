Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C7F483E1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 18:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8510E45C;
	Mon, 23 Mar 2026 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlMamTZa";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D12E10E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 18:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFyavqkAJf/05cLN25udLwJWcJ+pmveWRm9f9TmtzMun+Gw8l9ofXDmVEFp/vspocf7MFmlr1B2ZF39xmRhJBApwyT0dA7sMtX4mREmTvah3HgX22XPp6l+bkRlONzfOUiqUiiLNF9DY70FWQ/y1dlFAzFd0SlrhD4fUnSUsheOrhT/4HWe3hw+x+GXIIw/jjJaiK6JMJhpgJL2ex9bPW+ZdX1J0wpJ6++zyHFmp2hHBqCptGII+yhm2GW73d8Brcp03BaIUYVFcS8vMJAqct01eZykwSeNfjLnWYGRNkINjVJsH4YRz836oRP0TMIazXti3JnsTTwZDmFHME72sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWWD2v7VcmhIIfXn8gN3Pr4lbr3DgyiBXQhZaOLFUBA=;
 b=oKJrrJPEPFfevwIB6Zhm3+6/uej7rdSjAXsWturVakxzPIk5qWKF+FeyfSGp6s/Llq+SM9yVFkBtRca0yYXtfid+Fcvks7btEFRCsq1rBUDDJvwJDj93Zqp0Yfh7195aHEWqZgUtkM1ssekH7sPAI3HY7HXbvBecinz1Nv1CBak/i78ioxoJEssJLXSEnncy7uyZYsoHm6bicwzOgpumsbKrh8EdQYdUXeQagME74W/d96wkURFoJ5oRUJDmqwczWOZE8hfZ/8vZ6kKNh5Oq3TYk3x4SUt8ck5kBd4NjzJQgcOx/hAHpDUmfsh79OMPl/Wh6VB2CYGU1KUwe+4N51g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWWD2v7VcmhIIfXn8gN3Pr4lbr3DgyiBXQhZaOLFUBA=;
 b=qlMamTZa2gmjXhRLWpwNXQcj4jJMGfD53MwPbDDw/I5Z77HJZWb45+n9KEqSoLQOpUY8Bag6LPuJM+o9K1rqCNoVy7+108DiAHbqUUe5KN7uasaNdqs8GTL0/XJl9VkvHt5IAky37uEJOFaCYbicC4kHwPqEyGOmM3zTof2YdY4=
Received: from SJ2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:a03:505::14)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 18:45:15 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::fa) by SJ2PR07CA0024.outlook.office365.com
 (2603:10b6:a03:505::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 18:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 18:45:15 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 13:45:11 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Amber Lin
 <Amber.Lin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Enable SDMA queue reset on gfx v12.1
Date: Mon, 23 Mar 2026 14:44:57 -0400
Message-ID: <20260323184457.1244422-3-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323184457.1244422-1-Amber.Lin@amd.com>
References: <20260323184457.1244422-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a1dbf5-368b-4b72-2414-08de890c52f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LczCAJa91i7yId4TDv5vNAV8rJpuYCfzmErGs3xnk8ZUPLMqoUZDifW56/PTX8aVs6idJEAXxmQIsppsmwirPYUwj0Ph0kqp7fjUfknAOLCXkku9HRdH9VrA+JgDktIkCD3C0sKu258Do91xZSsMwTm2v8go8vhAQXWc6YfIu08ksuV6HbnMaD3HDbeBl6KP4jKvEOoW83iG/UC2SImzg/txy18bxpei5TLTORFRLd2yaoKEG5G3+sg4ytKAB9j+qj4YfFnPT26+w+UjAuzQKT2UuKNYHKceohIb1aCQBwqEV9b+Cse0eCy++W25/3r26zK9xbWeHdPL5VgfNnptQiGPMBNutzxz5Qia9j35zraatBbM48JOPhuMdhv4cVrgemrajzt08fFLlmwc28/ST8Ei4sPjTdYbsyxMUzEfC3+OaKc2fMzsSiNApUcDuMPGm95UW+io4GNbfRGI3SCvTVkvJimBqEVH1pjNi1ay07E3/klmhvoDKYwjncNQ3j3joyo42wLOVnSYeGMRHyEQNj/h9KxxSb0lclG85F3uQOqgfu2+7hTw1WA+YDauFCKhlI7l1lLaf0L1WTH5YejqJhyBRKfYIJEuOx7s1l1KqxrxwV2HAAEBSZOVhkQWoRewaG2YArgqGUhr8QqLFJLm/JPEs4Y4HdyoQrQceeKYPBNi34o6EfF3D7o+4E1cGdGfLIh6HF1CKLC3s/TnGBBbjML3yU7irW3/Mchwl45HxCCpnRO4SYFN6w/ZDf1LYySiV/i+Ac8dWheiUk+VwUAAgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v4vMXovmbaN8Bqynh0pqAt3Tid/lbPdU1MFokhLVywpKXYRlEJW3uWc3enux3qqPICvXppsv5qocx+LHGRpn2NiIYclLnygR2UaTaG3KO0JC3VJ/wgPhYQB48ieGtOUrh/k+D8mICkeLDogP4nCux5gB0u+1wUSZ3GgW+Adf1MWTnQx60Qp4wmvZt3ZOfIr7XH/06FeRHth85KO14xfX9Ih8uSyDiUeDQAd5sGd2Huhwng2EfPC1TKJ3UTwa8JGR+Sr4UCHxAlXVOR+Df1Nlm7Gz3zVd5yVreX+KG25qIbJrzV7WI5e3fLoLVOAG0iSLHkQ/H0ASYol2PPM3jvu1RvC/tuWJrGuqHgj18zmvXP1h3iZUhLq+eZh7R9c5z6oDfg95B2P59UQ9sTEicQf8FfsfFZ2fSUrwy5Sk4G54rv5zI6Z72M8sFdTlEKlgrTdf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:45:15.5955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a1dbf5-368b-4b72-2414-08de890c52f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

After suspend/resume sdma_gang is supported on MES 12.1, SDMA queue reset
is supported too.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4c52819aef9e..42d52c1f5109 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -514,7 +514,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			dev->node_props.capability |=
 					HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
 
-		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) &&
+		if ((KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) ||
+			KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 1, 0)) &&
 			(dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 				dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
 
-- 
2.43.0

