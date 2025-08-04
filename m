Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C52C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08E010E429;
	Mon,  4 Aug 2025 08:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ugettRks";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F11F10E429
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbgbyemCMbBVMax3apIFrzWtxLXEl+56D0Nhn0fZE1e3uECS9oexnr4wPUsarKyESYj8fXRy5XyJxTKSagMyGgJN4btamZWbpcUitw6LfuaaP2EjVYGjl53/fajz1l2+5Kn7f1gt/5+jW8FwR4hg8F8N4LCIPdSEkLlWSAeRdABlLztNSxUpy1dGrk5Qlj7Vzea9969ks+s9CgvzJMCngwCDtn6/tS28unbsKhYK/IsuxBxeJ6BNvruyxTXSDUR1QPx6fDIBn7STiVYgMj4yAMvo6ckSTpCERsk/iEowJdvPUhaRPzZt0pGbXwRGpfY3oTpaG9rh43Jn9EiGgYqjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pej3UKJj10mWlPnGVla0XM2GxYhDp4qa+GrJDjEg/wg=;
 b=EFHx176WzPIQhrfeQlgtv+kKwNP6eo5hZIhGvp+HaLc2TFnt6eA4q86E+EgAbWqqxLCwaKp2eCFH2R3ZHB/89KeGpH0U4ci/pUzQ2b8IIExDFL3uwHI7ds3FN4bl5kj4M1Y5k5zoG+5v6d6NzJXnIUL1j8T/XS+6plso2QjBHzSjOVBi1yR5deXtpVDnfQMtfcoCFUSOWjOLdhUq7nEtPQuFeEmVJV+xQQT38a2oLoBgcCO9RgIWDWkuBwvgi71+mzQdtYLPIW53B2DYNZbNNfMHk+vSGzvpFDUg1DJNeL+pRkG3eTBAmkN8c+DBNTRiWt4T9u9A3IozSrKH3o6jJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pej3UKJj10mWlPnGVla0XM2GxYhDp4qa+GrJDjEg/wg=;
 b=ugettRksXXntbVw7vpBIxw6pgV9COLzd34qjGHp4nykg8vemKCM8C9ZZ65ktw5UTd8iAiAmTXU8PZYYaKv194hwiyAGgqXJsa5jI4D/FR8pKv7Lo59MLm41Auo/dXiZaGckJM+BB6XF6xHMaS9q8VliPhiEBPEZO7++qrdRECT0=
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:41:10 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::fc) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 08:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Mon, 4 Aug 2025 08:41:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:01 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 07/13] drm/amd: Add preempt and restore callbacks to userq funcs
Date: Mon, 4 Aug 2025 16:38:25 +0800
Message-ID: <20250804084029.863138-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7785145c-8c42-4325-221f-08ddd332a94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jmj/nwZQ5bAq1ZULWDblg44BzYHLhaYF3JP0ugXqxDWV7zv2kXq8VjPVfS09?=
 =?us-ascii?Q?XAt8aK2y4axm6RNfVDqY8ADv3Emh82VZjdkFXx9SmEbDaIfy9ko5EWiQOpz5?=
 =?us-ascii?Q?u3LDbxjWh1+lcTKmqD04QbZuBR35U57cl1taEE9s6LVfk2mXnaT9Qy58Ai/e?=
 =?us-ascii?Q?i62blEaVXj1CnaZKCqniXgyiqm0cf5DP7vm56rqtaYF7dQCvFgylS+OJAKjN?=
 =?us-ascii?Q?fdFtrfK5nPyDj0N6yss78ShyRTSV6f+2tOIW4d9x3BMG3hKuBpACC73HtQNJ?=
 =?us-ascii?Q?cFKu7Ee3w4MA4Tc0s+bT8Husftqi/1IA5oRjC5ldL/DD5O/+zA8+EXC05hXk?=
 =?us-ascii?Q?/ueMAOla82TGAXir+01qDDMSnKn7d42EcYCS8VQJVRlQq9kBNuEtAfW2MAqV?=
 =?us-ascii?Q?cVn+3BwntHBHMtfxKRmkxFoNZjpkQazZKIvSxi+OCKLc0k9jTu3ulGtnmwUV?=
 =?us-ascii?Q?Hh0mv6j2RJmXWsohCIWoaNWybkXqT9FI3sVEp1nLj7Y0nD3USB4TXbcD7iDl?=
 =?us-ascii?Q?5OQp9xiDFtIkILFG9JdA4MdZSlwQJikqakmVOggH8EN3S10spr7GoL87kmBy?=
 =?us-ascii?Q?5OhQgO2SLTukB0Bh3ueSmaQaNlvoYcUO4UYh3dWtYkWEbGDqM88hJTWVLcNp?=
 =?us-ascii?Q?P67I1vuPjOSBr1EXIYMpLl21vJH+q5J0z9MUofWasIMPKbIFFPuC5xllwD+2?=
 =?us-ascii?Q?FiSw8iWFeczNELlwtJimMeZaDvKKMlKvatK30uLYZKiM3v+yM1mDuAhB6D3+?=
 =?us-ascii?Q?N78FrglP6PSmp1qnw3xOKt2hlB91RgTwAW/icrAXYG+TA6VWC1ZmI74jVJwS?=
 =?us-ascii?Q?A0LfS3un+a5XMPT+vg9CUZnqN89kMVXXzLlnBdCawUXRkYGpPNsNRbT6kdcL?=
 =?us-ascii?Q?qqVeIHvnq9lZ3mfUABqNiD0I5Nqic3MuhBIsVJBkstEozhhyyNW8D2SJUuTb?=
 =?us-ascii?Q?2ej4S18/qhZqM8SPeFkSJ8eNnIuaLoPtubEsobIJbyLmbB2qTNqZndNrQPVC?=
 =?us-ascii?Q?g7SMRJ3iIr7sLvFa8onkswiJCyUwF78/+laesqrEaU+zT2Oe+DrEHA2Lhywj?=
 =?us-ascii?Q?p2AA0PIgHhyNY944a+umc9jih6qMXQKUGZqrjSTDB3lVi5249K8i5RFXGQVR?=
 =?us-ascii?Q?9pPVx5SLxQfNA8n5rMP2eHVpkKgI/3feZZx7c7bYEbxSJMmhm2cPldSNdf+V?=
 =?us-ascii?Q?+pMMv0JO1tupIjA13NTwQFio+1jL6ySF9F1HcPhosG9SWfUOUbQIhEKz3N7N?=
 =?us-ascii?Q?1rcIap6erDrgWiwcjRIrldZKEQDN1oJWIlHYNXJwS0vJ88xcMT8fwAHZijPL?=
 =?us-ascii?Q?/Y5zle6+6hFsRftAMRxmGzFWkC9a6C6RmFtOUWMhKOC+52PVLjFgToOxiCLJ?=
 =?us-ascii?Q?ZkEu9wDqwA/jsW3GLF0EAM84ic5O6M51qr8MFY90q+Mq5HdrSt+vFp5EwRYl?=
 =?us-ascii?Q?FLXLmOH8GPi9A2lHiaqzHO8CZ91gAFMA/kqfUFrRBhdgvjBBmjG9Rdwo5pO2?=
 =?us-ascii?Q?xfdR3Bov2VmIjfzEwcpwIewplR/LJg1T2ctI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:09.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7785145c-8c42-4325-221f-08ddd332a94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 0335ff03f65f..68e46d01bed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 	int (*detect_and_reset)(struct amdgpu_device *adev,
 				int queue_type);
 
-- 
2.49.0

