Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D35CD98CE
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2026 03:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D77410EBFC;
	Sat, 13 Jun 2026 03:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sfOrQE+n";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDC510EBD9
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 03:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIi/nsIhgacCOOLBvbUXo3RB6yuS4zMv+YhK78wC63a31tSJAmIEMiFkrJwA8xr70hlqAp8QyHiRLL+hoP/oaSwqcBuoIlaYpCsSsN3FMuY3IDJcXNXTL6VNMpNXwkvhcEntiN/ZxPUglHMOIjARbyEvyDYd0MsfrxEMrFgwbLqzcoMy3qBTwfXmu5AYgWmWjOoiNk8RryvNiWaxe7DrQWFBwv/EFF54wwgYj36grpleYYS0P6wZhoLpI8sXfYogGxgjdPxyYot3prTkyHZqokh8kVIU03gO8XkpR4YgME1yvfO+HNROSEPniw4hVMeiIzeC67NYSRuqdxzHMRRRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUN26HUbe3ytvA2/OJuGw18ouPbgD2uToV8v4P856Ks=;
 b=pAGU0JRlSoPFsSqnOcqkP+9Jxsi6PWWH+YboUOdYURC5qUEo94n9Ltnxp/33yDGsDGAK5V6xtudevTD9cZfBvOsm32u42UA0IW6hdPLrLivnUBrA/fSb5a3iOpQ/qaDVJ7nwOkPpk5M4jWOyP9l70mOs9A180IVXkz3k2kt94+Fx9PORheA/gdTNCvT1AjjhHCJok7sDQ1NpaeaDhvWs9rX1JGDTCksnU/f9RrgE5deQfMoJmu8GTL2bp9iMLmOF9pHtZ6JPL0jBFqaikzxrzPQ2qrhRFiPXYKvFRG17W40ZQTaXD7soi4n2gc9iMtxxZjhWULlp3j3tL5JEbCexTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUN26HUbe3ytvA2/OJuGw18ouPbgD2uToV8v4P856Ks=;
 b=sfOrQE+nznPx3r7m78Tw6ZBcgzswxrYMexYUedRdNyFnMg6mWhmNG3u1uXqKQQuQZYXClLJQGR6z0DxfvhqTj6O1wQuId9qw4aaOPrFtPE5rEs91co1LIk2xdoTKnrNO+URaKn0ZPgKyaz07gy06wGzxgTeMKFgK/SdpU7geCZ4=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 03:02:33 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::6a) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Sat,
 13 Jun 2026 03:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sat, 13 Jun 2026 03:02:32 +0000
Received: from rocm-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 22:02:32 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jesse.zhang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Add queue reset support on gfx11 dGPU
Date: Fri, 12 Jun 2026 23:01:52 -0400
Message-ID: <20260613030152.945160-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260613030152.945160-1-Amber.Lin@amd.com>
References: <20260613030152.945160-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc67019-ae0c-4be1-3fbc-08dec8f836a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /66GxARO9EPIqp85hyWnUVESr5DXSxh8+Q4Nz7MOibLNDZ6cnkjPQKVG8GaJgXrxmbM6hcJvUYYN+YpaeLoEG7GBtmn2AdJbFzpPqWnszmY2Xm48/5JIuiJjYEbZzRz5GHTv9UVTDk0Q5GvZ+fbsxCEbzDzW/bEvSua1hBx+xlFle8a9627Qtq47SIo5L2/tera1J1pt64Jr3jhbZ9NCQHLiBVx6+wmu0/uBio/TEr+WWNu0zGyKheSA2UNMZbKpUhPXuobzJkbNBR2vXReiWcZ4dSIJodyZqlotBuL/OqJ0QiK4QWgR2tEVnhR8MLYfbdyl6osqvkECWEkGZunGRZ0/w4ILVCxSOxe8AgHpvTQvHXz0BKnoJiAo0oNseUBkTQ6Z9GFH7VY3ObZdjmKbRCtCpkTzniSBqY9EXukAFVfdKgkBPJ9nfOQmzqVrPWqnHcv7UwkGUyzst4aNXuw4ZsmYekh36EYC+F7L/Y0U2gtABZlMnx32QhX8dD97XQK7MMlaYVOH9DiBuxzEWSNbUJ7oVQ0Q1IseljoYWheHYgZ31GLp2Tq6s07BD8d76sJgqTpj19ySHisW1wIHibMg79tJfBD5aap1XxxXur8AUkfx8FJWJQ8XJcj+Q+Wc2f7o3nPrciFx8XLPc2m7aooOmcTmC3LXrZr2Bp/7nLySNzgyqMyQB3zPSbjzKxJrwfZQYSoxDAhQK7ABMj1pkVY6PLY7282TN3Af1iRY8VjHLsI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 48/iEk8c91BG4SQabxS+lUxrAbTBkrboouX7dAGzfcR5k5/DjkTB+ztYmjF5I+vRS5Jtoqbcc8fk1y8IUrLSueyQUZ2T97KqwrGcU+UBSYEbj1Xd81dBBWgVYWl25J3LUx2Tx5dtJJNRzFMxfjc0KauOHINAdfEWyRKGFj7837uuV7inwt/gVsHuhmb/nAKHA8KlQ82aQZx+WJZ9Tc7BLe4uCUQymj5BjNt8xEKQ22DGcvoNxisohFEBX820Td5hHCjlZsp2ypcOy1L+9NlYNh8VmGUemL8HQmLm8pBbzkDQ+UVwoqfn0/Nu9votFwRyfpkHvQTvgP9walzxh7iG2g+RMleMWHa2mmfA004kt5mOAc/o5oslkCgJvTZVeQ7DKeRoyKPxji030OUf+9byss7FND4/6zYDQEfWu7L8cS6agu1HZapsg9aqJglJT/hg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 03:02:32.6413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc67019-ae0c-4be1-3fbc-08dec8f836a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

This patch enable queue reset support to KFD topology for gfx11 dGPUs

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 0ff793a17857..01a8a2171f8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2019,6 +2019,11 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
+		/* gfx11 dGPU */
+		if ((KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 0)) ||
+			(KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 2)) ||
+			(KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3)))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
-- 
2.34.1

