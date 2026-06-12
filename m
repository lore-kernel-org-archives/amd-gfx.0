Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CABCD98C7
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 00:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E5510E07B;
	Fri, 12 Jun 2026 00:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nfukqcCF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB17C10E07B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 00:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwPd7PDfX6oUFHMFCWTYtv+WYKTfbvHN6HuC8HQUlwYbw/p9nbo1T2PNzklWVK/jPO3KWZfIeSut+t3sQQh4fJJSnUWDICs+bqqf381ncPUAnXKQ2rpSpbmbxl2vJI/pMau+iKqAKhuwiwX7gawl+v2Km5kq1669FZnPJ00Fx6qZ/gYleO6KwcEp8j3JQDM1tC6T9MVLXD7fJ02E0DRsb7iMlnjp9HqkPO4KoutTQxcHo4RM51ZpFVoe4PKq7gIm72LtbD7VkabxDj9ycy5hq2WntpuDkJ10XV7ML5qTMo7ql7JyRb5DDKR4ypmSPjRVFuRoEFfnllDI4UKeqXQKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CVik5OFC10X5OBztE5Ww0RzUdQpB+UDRLQlWGtlQKE=;
 b=LecUcC9swgYd40K3tMRDAFgdvcpGw8bXmrK6sU7iIB8ngchWa2x4t8TlTmMpZsrPLSa/9A+R+NTFH3BXQ1xk/W5kr08pm9NFzTnmpTeChbYM7qIDaUnWj7NO0p726opWAJD9u19Uin950MX5gwE593/1a/xkfwOHDNlJ7sIpy8j9dcZOFDjGiVbVoinBSMhLOxBPoepIlUsDLPfpTFS/8l6MyrQgEXqD8C+Q1zcSiIDmp+4Ph2uVZruCuZDM7dHP26117WC3PR9aV8NMn/ngJqyOVAGZKN8NO62XTngntcqnH6aAwQvVNZlbM1oTORs/FVzF3oodY43taAXXKK3MeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CVik5OFC10X5OBztE5Ww0RzUdQpB+UDRLQlWGtlQKE=;
 b=nfukqcCFnsbjoMuo7daC0ImjhpZbC9a5jQPDWcwbVXDMmS8b5zrGtR0YbFkm7QdHClavBqGSjIt3CLBbCn5sd0ccxg5Hghow5FPZegN3vrSSdsklNrjX/WdvDpzQMx6pkGZrOHi2Z6NOPgHpOu4KVRUMBDl5Ug7Rr7N3wXbwEcE=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 00:04:50 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::51) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Fri,
 12 Jun 2026 00:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 00:04:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 19:04:49 -0500
Received: from amd.com (10.180.168.240) by satlexmb09.amd.com (10.181.42.218)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:04:46 -0700
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <Felix.Kuehling@amd.com>
CC: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2 0/1] drm/amdkfd: Fix NULL deref during sysfs teardown
Date: Fri, 12 Jun 2026 10:04:06 +1000
Message-ID: <20260612000407.3734265-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
References: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cba9f6-b3ce-44f3-49fd-08dec8163874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VLhwNWEr5kTbUrBhW0C/ncHsFy50dpQXTr4Urn3UePj7nNl0mXm7dsWy79x/MiWBobns5s7yjIlK5BX7Fr4CT7DsUL4yL4XetoIn+U2yV0q0YQuTjN53m68MQsxOOcj/fcC0JAbl66Hl7Pd9U8FgIdYhZk3XuwYPUTi9/HYGEk66C1TmrsmRHD4YHFS29rVzmnnah/rAsMX6ST7pYYECT0q2bcYF8C0UrX+RkPHgGgcRxGhxsVMOv0leVnOPelGYEdfT48OhIfw8DKwovOhINw2rG4iTw1I021RpPR6q+dTL/acz5hHOizZG2GUr+B33x+YUxmEdHgMcVkCrcp8w8q+I3bnczWsRzS4TjejPmgyJQuTIcV53pch+WT6uXF5rDaLb87YSdKB79lUeGjIL1j8dvicRLykEBGTEaaANy21npV7iRdmGhqwoI5Q58pBI9lsbgtjoQUb/YdPx/jUQaHaQpvHrOJaZOoKKcsa3sIhWYfd+4UuAi7HqAnNrcZxYdfpUpTRKtsRH4LHBdG3DWcZzxOzEecueSSnOgWFd2Pdt/787hD5YzTeRwa/cKegI8tct9WK6j4kMQLEASZlPI210vpxlwHp8DXcq4lAvQpkYqhXoewsbbExP8wKYq0ZjfvnhNlvtR108epOM1ybm9ipgWMGcVfciZzzp4aFvLh4SgRYoEgNlUFzfVxFEu6TdxdZa/MGOFcd+noBHcBx365sTHKLRPR2blba9OWJVknc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V7Af9I+llLC1IOq259LuD9oJ/jVdC/NZ1wgP5p5K2AWt1Tb3G9hqXPakwud82tp5ZNdJtGP7I7cy9Ll+CAFk+aw7znSmNngmHfzTGTh4/WF75s5ADtQER1GsJYQsczvzck+a1ColrBH0IQ+16631ZO4LuwmJ8sX9tbULaf/ADwzowIFZP0/bl5L+CfyGsT1LDB6jGhnQfXxJSGxwavF22Mg+vZ5A69IeqGnQydT/E3Om2hLRHzSA7HBA450CwFafDEgid7CNE4u7UMq/J34NO0qR6lMkiI+zvFe8XFKykuWDSR1K731zM8Br6lBJNwnhpg0t3U0P/3ddjjSP7YucKrS/v4Mn/UnOTIszJGeNoxF/hb7bCanedVMdgWhPRh5SrKdrDTcQBcQ12uvUWhGyYia+rRdZ5SEnU5lj1sF0Dq3jXpDkRlFDa682zSupI5lc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 00:04:49.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cba9f6-b3ce-44f3-49fd-08dec8163874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
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

Changes in v2:
  - Removed `pdd` null checks as per feedback
  - Updated comment and commit summary as per feedback

Geoffrey McRae (1):
  drm/amdkfd: Fix NULL deref during sysfs teardown

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 40 ++++++++++++++----------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.43.0

