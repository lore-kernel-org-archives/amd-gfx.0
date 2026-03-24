Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CAEFEC0ED
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7902D10E615;
	Tue, 24 Mar 2026 17:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zi/4eMqo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD55110E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzwuDxQwd5ev+wV67Dqd+NSBBlgjAFARDu9hRP6flHcdwg1dZDjRhd/Koxd59+08IKRsUP4n+mzqZvDaibz5JdcKMU4vEROUrDXtmRD3OPixHDKQa2sS/or5j4k/Emvl+Y8B3+dNhrMiMicdmNGYJVqU+Gr7fWvVfLYjQEl97CQmVf5T2OMdw0BsAyu0ywq4zt59cw9N+WSy7TG7rBXR5DQF1HuZ2UPF9Y9tGaa1P7AynH9I8ZgxcLzY3KMtCZ3Lzi0UIlbaNIJIHR62jxCVpxk7Esrbo4vlgAAwSTMVwWamVQfhzCrsnfOf1Dx7sT4adoW0Uzaim4Yof3m7g9H82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3jShsSOba5mu851tpITJGnoGB84TY/Sy/cWmQFcrp8=;
 b=veO2MuchhIrxGmNref4OaIKe60MzYBtZMnO9GROUTCiuxeTufPF2duCmr4ZjhxY2Cm6DWNRlEhaY6FXe05kkaSky8Z8UqgYC48PWEfZ4ftysl+YVQjZ6AFtwrUYjSb9XV2HYwwcIt4COAtJI74ytlbqoRLTTvHQymZCR+jU8pf3jijo9mBdHogeJJnqL3sXewkl2JdEWJApCjmj/ZiOxsocn1j8dn6JnEjMvgB8khhoEslXK8TUqRnHSEomtbW7SAVbdvfa6NZop4T8pIds8zQvZW3969VQCEOCIONKNbMjrX6sGjnPH0NAFumgqftGVdAu9eCUfFnXdPjpWz7gmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3jShsSOba5mu851tpITJGnoGB84TY/Sy/cWmQFcrp8=;
 b=zi/4eMqo9S/MMqhp8Dij1iU//JwEf6Y2d92tOqgyBcMMSgoKr6pjkfknV06WqJWjEm0aqcecZTOrt3jlL4YNZZz8o95mSqylzFWc1kMRCYmxTYtk+4NCsEME8uhm6b+BbhfxYnJ/JxMUI0UtVwykvXOWYzp+3kcpx+bT10Mb9jU=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:54 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::59) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:53 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:43 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 10/10] drm/amdkfd: Queue reset support in KFD topology
Date: Tue, 24 Mar 2026 13:56:52 -0400
Message-ID: <20260324175653.1325754-11-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 025c2768-02f9-4622-cb0a-08de89cedf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zwRhlIq4htKQ36Vp2RWaUYl5TTgTICRjtucynb8scH0WKMVNV15qxqXVwMP8aaemux24s/53VIPebfdzMNn7YC2Oiri6awlQaVcqVbNzYJOvaRM8oXxSP/1G9wxdAJ9NWDAiTFAWI+N/2q6q4heXPPY9+QR2EO+u4TA/JK8uClC+CFmfiSLs8b8pCYe923U7OhalBE3DKzGUcpUFJmfrCSMkoPYpU8VFrzz2ItQfCKVuqTEgErrtfarpQKAJVOzYDq9e7CWwgy7X0Y8LqGle82NwstdK9o8SVQT/vQlIa7HYHATPSv4JM7YziWjx3geX9LMf6TrnylbjawrYgWLYv9HbD+SwY9hBaJP53Hw23de1SWNx5weOhHlflUz1lvak6dK8PdRhC4KFVzSGzUN2YV5xEQaJieBdoZQMbyAecAGCSIUVBXi2LqxxC9YL9PqNHwpB2oSdM8M8esfx7hud4ZdThfi2syhreq4nsKFQttlHnNEr6ut8LkLXzJXJfsBinzy12DYy22wAhtYaCMz0wWZNWEPkKihFDRc6Q/heHYj/2P1ZVeBGffY0uHD1cWwDWD4+RFmGt/3C+IGKMOrX7G6BdxVtcMJSzmBoQO7zwAOHD4Y0gCgO+kZelTdxiFMFR12joYkGxrn0ZhaxjDMppIgqnBCXQapC+2LTajJA+w0bsOdGPCe/eGbkX+8b5Fy0T+sh/M/HdyTNr9Dd++jtnJ4kJW51scyik/2GjLpHwC54WgdGujFy7A3mRYCSLiBXztAYqy6X1IBkahVk/R4jNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PtvJQqzgaDeqgyLKzeq8AURBICwky7fzq7BGPX78lJo9yt65toQdoAj0ptQ7PMx8qYcfUCA8O4yFXrMKKFb6b73YDPQv5eSc79diz7IhdnrjztdxBNaaOkNbkgmJ/8KAEj8xXQ+VNVAJBOmAjXjrwHenHNQ/zprlANZ0o//aAY+FgYESDZjzkVlnsAqvjqBrn6W6mma/NPwbzx2HnCUmh1EDqAQNLrJp3lJPHfoaK8KTGOAEae4pSFIj8SR6RFRirX31mPSSoCo9pupSWMSG7jTVbpB7HfHTnQLnCpyCeqzVNdYTu5PZjcUhdlzPpcPkapPpv1FYNMPndS3O0zq1tttbs3y8YzV90lSHAuwBTEKOoqFALYlgAsRnw2bIHDZrsQtXM09MyXvvdfC7xk4IfG4nGiwISRg2tlhljxpEJA1EJtJaNrCxeE5JHEXfBgDi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:53.2831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 025c2768-02f9-4622-cb0a-08de89cedf33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691
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

User mode compute queue/pipe reset was originally only supported in GC 9.
It is now also supported in GC 12.1. Report it in KFD topology.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1ccd4514d3ee..4c52819aef9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2027,6 +2027,7 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
-- 
2.43.0

