Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CBFCD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 03:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5EE8994A;
	Wed, 13 May 2026 03:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qpeeup/z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 822E78994A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 03:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL4eP0TGiKaxyOk4Ypy2jKBrA8/jv40GJ05XCnyG7Fy9W8nl+Y+ZFNmRryz4czL0A07YCBuoxqBqMWqg5NUhMBn4sGspJeeeNpnxzZk7oapvqA12dLBfDJ4NqxIEde0/d6IfWRMpzHNQ/6yqjv7m6+Ar6yZnUBSqHrOh4xZLAIjG+/RTCcZfUDdfUe0Jaf4w41aAt+d0cGFRYSJz489JKAZnU21zXyJIFrDdczw9PL189cs/prpHeRd4/u2NiKO29XjBZbHSvo+0wfmcn3CzUITGC7QR0E7eZdJpYJHZh5Hynz51NXt5ScZ5L2cr3arNcjzTW1Ir74OU/XcuGoiuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHBrxJQDJzf/qCG/AJ5KTQCy67ZoXPDRNlb4Hgk8gcE=;
 b=bbXXEdLtN3wAlj7em1EDi5cdV654Azk9XV6R5uHN99RaStnq8iHhoYQAtjdJTAcaz6S1IJ/XAg8eJ5DoVOnTNW3qx2SI5znEZiywIccCWD3DVWNtzCqfld1DsHHsnH/ap4pyGzq9HhiwkLiajB5/lb1ZUXwJ0eh8cnY+nwhquXF05OODa6trT3UH8161U2ovHguFDSAUWNytGQdU4CTadDX6x5Ct2v0VhoWiI3MkGyUaa/R1nTyBYqXDEZ1C4zNsMDqYVJxYEHhkymlU1sCBtvQB5t8zGLKWZTyzmAvQwskRkKnydVtqff1B66ousYoVNqXNJAqL4Hb4y2iZGuvIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHBrxJQDJzf/qCG/AJ5KTQCy67ZoXPDRNlb4Hgk8gcE=;
 b=Qpeeup/zK5G/Odk2uvX18B5v37vQCS2jsL2stAWC5WzmfCS3+vzQkJl5hvK35aV1O/v1e4zXMOWe5IyL+zwF7vVnmqWQIZxj69w2LnjaxKfyhYt69SjwxxE/YAzHePQyRfuI78FCTp/JlfmpdDzOV7KvHALyrkqxcdZP26bGkUE=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:00:48 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::34) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 03:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 03:00:48 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 22:00:46 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>, Michael Chen
 <michael.chen@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Enable SDMA queue reset on gfx v12.1
Date: Tue, 12 May 2026 22:59:25 -0400
Message-ID: <20260513025926.259727-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513025926.259727-1-Amber.Lin@amd.com>
References: <20260513025926.259727-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c221c6-6591-4577-7ef1-08deb09bd5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: tLeNLJ8ej2FPhV+UaKl/k5Fxjl9COSHocXX/rcmQxKYU1tuZp57pFViUi44T0gxWlAjAv2TMBhwzQ7GtXJ7RFCG8T8a0pxhoA07Qjn5ZVCMpqTZF/GAQ5BkWLdO6QfgtpnbpVkZ/wbRbaNZRQzrdJM4UkugG3DEazc8732XC/AlTD1CzUyi1xz+WOd6zdPjgt/fJmBVMQl/rul2f0+3f6XzpbytCD2NB7oVSKd4bMahPBQSmJC7aSoQCAVM4DSxk7L6CFg0AjD7QeVJjSU4XRAfix9MTZsvCGJk44kpDHObTV80XnOS9AYMWMU0su3txKap4Eaip1ManBQtogrwLhr91y15OJuGluJO9iOvSdfgUTEbebZ/AbGGNoxUzb9eO3TYCxQqduxyfQmQXtG8sejJYTzUKOcQm5Wfr6PKH3AN+JNcU9/Tl/cfcvJZRByy0OARJ5FMdqN1IAwY8gJp+pejjHJE2qeA5Zpl0q/VZQ7GywrKcKVnVM2X8hv8MYacIFfSeq7QXLVKyHRROZQ2SGax+UllUlP10xDNG5DgRllIpgnBa+blomuN7x6LOsbzU0GjFcBj6H0Gnjuz4vUaHzqxIKxLXJcvCnvGw0pD5ewQmcImoLPXUS1NglAPyCABF0oExgor2cDUa8iWIuHfiQFI5rCDDIP1TRnPfbloGfB1RfdgD1BvjCR6nyTxv617P9a8LcAkmck1/lCaMSWYFGJGng0IYIR9Fh+91UK2MH8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 27tTFG4bKFTxRWh4vk617yFKVRmc8c2TuY9QqlAWHU0STA1rUY8qYAZDueJ+TO4K9rsZ03vYn6i65gdrjNKMMluQzhPYoDilIt/OEfGek+RHeTksSfmWy6/DCD+ha5vRkF74Tq+hgxHv8uMtPON6dXZcdagoeVemQVXlGAS5RBqJNe0RgJwiT/EoP7xA1Z1dlABL8378Gz853iQLCg31lTry09n9rg8h7Ke2ywbR1m/VAOkdoRmx1NSSU0JB13kvfNwB5qDL+j1bcGdIkvDQ3rrQibQZ26jmrKZRgP/QtXZS4qaw8g0KQHH+fg21BOfen/y8ZL5GsLjwIJui/N4FhbOS4bOFVdviFWnzxhJR+9Xefp5Iq1bvAxPz+wA0mIf3pQsQgVhnMtywKsYTyGel/2MxGMHEBBH9Q6QMGoVr6Lf5KomzbGKyjbsxNSJYOsXd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:00:48.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c221c6-6591-4577-7ef1-08deb09bd5d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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
Reviewed-by: Michael Chen<michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 397e916e11b6..f37c2d3c8416 100644
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

