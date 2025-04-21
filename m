Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBC7C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 09:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E51310E049;
	Mon, 21 Apr 2025 09:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c7XZRizu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF0D10E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 09:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5s0uHi0MKyfeyv1emp6f0R/Cr2XgUuKbjK3jr1M+6ijeBpblIfTEQKmO35pzVAYkxnRWJMJKl7FWiQcKkQZ0CLEKQx5Mhkq0oj2UvKDkhJg0G4NQaJEqKpmYKSNvgGa+H/JMa70PPpjEbG4Lnfjk1LxyngXUZHP3NI5ANsc8QoXrEIr/JU4Lkm2ChcFodc2Lml4EWurVP+P99CFkJhiCwnFMEvg2Ko4jLspUeJI/hstPHjq3/KlYZ2u1uiHKe+qFRp0m2Bx/0quVn4tNp6FZhddGOZBvR0O7bqfqJhQVGuI3m8a8WhoBlD2tk605Ie5zmNwaYscwsaJB4mP40ffpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHBW1G9ozt15aa1kbYeBmPgB20/ouuBh6nR+gJhYa9s=;
 b=g9GAItKcsP+KXhQ2NSuoqRE9UkBg4CjSSez+DpcGKXdDr7nQRxBnpgdWfNoFqg3vnxSv9+wZjBEq53ls1rRz1sRsTUpsPxdimyM52zrbRcTlNeD839Hx5/ZR/r0uLGwcv43V9DKj9noU8nfkSEaNCmc2W3/fmDpWGR3rR7XcX3GAcIzrIkHWuykChJh3kZL5ZHfaH7q+c5R7A8B3GTPePamGykx/3enkjqcOjwzI1DTXihXSGk/M3Th/l7t5gys0Lh1+Dm2I4MNDcdlA1Ly112rof6W+RGZ1U5bjVR6M0sUOaH4QnFLY8TIlJBV/En+d7fD488M8pGxp9Cgs0OG6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHBW1G9ozt15aa1kbYeBmPgB20/ouuBh6nR+gJhYa9s=;
 b=c7XZRizuGbsYArXuEFJ2BGTJZX8KsPeAsDHFjKGoHN+c4JwMThI8AIGO/N/l1tlH1th2cDY2KMFADiF6YZ4frXuOD4nak4JNRlkLtaUQxTH5SbkwwdanVfZb/LRn7fnE1WlysW19boUY9bWQAKsR+cEuhWyQgPDil0OzyaCoCR8=
Received: from SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.32; Mon, 21 Apr
 2025 09:38:45 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5f) by SJ0PR03CA0239.outlook.office365.com
 (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Mon,
 21 Apr 2025 09:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 09:38:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 04:38:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix offset for HDP remap in nbio v7.11
Date: Mon, 21 Apr 2025 15:08:04 +0530
Message-ID: <20250421093804.880633-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: e969d2b0-4aa7-43f2-fb62-08dd80b84f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c54GoU2RDwjOMukAsPucghuGjIUGFTPPjsHC47Cz2Uhhk1DZ9VPIezPyQHqd?=
 =?us-ascii?Q?utBFvuhAoGKmbePfHD2ocziTEcOILaYrefv0iWnobI6qKYkDHPIKZHg3lOqX?=
 =?us-ascii?Q?skSsLiaChdU0Rx5wRFYlJgprDn51iIansje49zu9XsMvpFDVTc358CLHw0d5?=
 =?us-ascii?Q?Yv+F8tDVhJyO9P7nad3w3GvP/RBTasMfSau5rj9ymrpkcLsZqeytxnmsJ//G?=
 =?us-ascii?Q?8Y2UO9nlGqOEmqo6G/VGc6iROjr6YUeyZBM50LAvv+sZxZqgxpbMn0GFVrxM?=
 =?us-ascii?Q?myDSx6cckhCdxFwkQHNlc2KD7aeVAZS3YRdn+zdi9wzpIZc6rg70oLHiq/TB?=
 =?us-ascii?Q?xUHQYLPjtCKS55wtIaYmBeQ7oJLdwS3mCERR9HI3aAoGqZcm7W3v/zfTWSXh?=
 =?us-ascii?Q?cxMjoMf7qjYoEwyuFL032JNJQNQR72u9YKyAftMKfRsD/HFiuO4qOiNvHlrf?=
 =?us-ascii?Q?l1UPHtz/S/eTlEUUCM5lZwlzYyNV88LRgH2IKrqNVPZxyMFxauvypa7h72hK?=
 =?us-ascii?Q?cOXbxwWHbDv27uknxcbtTOmaZk0mClWST+wAWe6pCglN5LJYFjKReU6c4yi8?=
 =?us-ascii?Q?wiNKbXu9jPv2Ri/cPfKaKgxTef0EoTFhba1KmBqsplecUAey272VDKJcLjiR?=
 =?us-ascii?Q?SJ2bi4O5PrmfWrK86f+98Zuy1sl+7Y/hJTN3ayTQGyx51tFKblVYNJtd8eC9?=
 =?us-ascii?Q?Wuwfh1XBHqiwRX03LA3I5hIkAla1LPS4zZkbKckjF5C3rNwNIJwCjw0iTwHl?=
 =?us-ascii?Q?yC8Vt7OjfC0aSV/AIxPLiZ1xifJmQg6SGPOV0KSgkCJeTBIIIIA/5rl+pMld?=
 =?us-ascii?Q?n5NnXrXAGC/PC0eA0cUWe5tvGf4YUaNeZB4QwOeGpMvp1Balpu/ZTcOw5qbP?=
 =?us-ascii?Q?CjxfiAOFreX5oswnHBUXQICvlmS+wBLCQ9IGs7kiy+4Ozp341+69X3pp47Dg?=
 =?us-ascii?Q?Yo2fDKVm3k8Q78eHJ2yshpeUhUi6or6hlUArP06vOw23tN0wGV/RHYnVxra6?=
 =?us-ascii?Q?PcJC/QYhemofNS0Z21ndVld+csJXMAePo7wcHBO7xU5ycnfCxtkgKGn+oYc0?=
 =?us-ascii?Q?LjWDGpwc8nmwQjfBfzNPBdIQNqlTom/eMsvguZLZfmVWquiVw5c9opOx4XmH?=
 =?us-ascii?Q?g+joS+M+69uANRjrY1fibwQPI2GBuLM28Vi/1K8rkql5fUgtybcfY3CYAXX0?=
 =?us-ascii?Q?MhkHe7sIGMNWhljVIjbgHH7PNva2V3oAwzb4wMqJiVnniQO44FY8B6e/9/p+?=
 =?us-ascii?Q?3jI03grgkxBwr8dJayer/QkiH//zx1AROyqb+wc1NfBDNuJhMUFQtiYG0psV?=
 =?us-ascii?Q?n9+Ldikur/ZEw/bmSj8MeuUqVv4ELDisCqPcVcDsXIm9AbvH33PX2cWd203Z?=
 =?us-ascii?Q?laKszDIAI5OaR0YZndTDci3M6C6h/IU/Z3ENHCXuEyL/M51iRywqkXB7jLei?=
 =?us-ascii?Q?BbKpWbuxdodEZetI/ANoc7WZcs7dfKlRIouXpxrvjHK/rbo+aN3lGv8NEgN5?=
 =?us-ascii?Q?UYEVK18fbji4+3PDeBTHIMGFMbvZkmR2qFcx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 09:38:45.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e969d2b0-4aa7-43f2-fb62-08dd80b84f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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

APUs in passthrough mode use HDP flush. 0x7F000 offset used for
remapping HDP flush is mapped to VPE space which could get power gated.
Use another unused offset in BIF space.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 2ece3ae75ec1..bed5ef4d8788 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -360,7 +360,7 @@ static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
 		*flags |= AMD_CG_SUPPORT_BIF_LS;
 }
 
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+#define MMIO_REG_HOLE_OFFSET 0x44000
 
 static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
 {
-- 
2.25.1

