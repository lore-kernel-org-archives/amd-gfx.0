Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC38606A5A7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sUEs9Yhj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A8D10E044;
	Mon,  2 Nov 2026 16:02:04 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E1610E044
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLMQMOqzmhxnroGSckbfNd/7CKJ8M+s0BJabYlq36cwhzinIiD5NKKfYCd0bcTpxsWqzc6NcA66JfbF+TD7mDuGCpfsuOnvWBxKyRvgMnpZlH9Kgw59fgi+wH2ZPgGgNn+brKYxa0X5sl8baI/ZveUUJQ2yD0ZQzRh/ieMSPh40jvIojn3lFNxvZrq3kCbAoNDMnzJvA7H/9Iqzo8b/8M7fHI/Yyz5AqEqPMxI+knSo+OlcQQ9m8uglckMPnk5x15ZyHB5qy6UARy8gDt934AUhPurOZLKrNiAMJLjbX9BcnkNRIzQe70y1qZM4xk4HZPcfBhl031H5oU7ixHn2Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDy6jdpiSif+p2eohzsGgyewVwkgfrNOTT9AjfZBW0Y=;
 b=yIjq8gpEV2Md/aCJoHM4SzJ1L3ffEDvMdPs4U9GCcfACMJA2Ot4X3VxzEJ+Y74uFTEr+f63C+kAmEXp8HkxYbpPWgeUA+Itd4Rcpz7WFNKSYMHRigJ8PaBpki8HkU4b+tfXGKbX0cEduJrlVkNA1e/tTGX5+MQuB4UCTQLZlt9nBUcgov51x4509dKJk+rlJHUdNmFwecOUjlxqEQTG3EUpwRpNih0J95dKwjelblZpCG/avjnji0FKU9BmCtH2vPvjgDWih5i9B/TMdiZ6bko89lXZl5im4+/kdgHKWtOAKrMWrfs54iRy4p1CkJ30t5dbWUNOqwTyvRKJ+93Qtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDy6jdpiSif+p2eohzsGgyewVwkgfrNOTT9AjfZBW0Y=;
 b=sUEs9Yhj1SkkDZosLbT/wT8MRYT6VL079SvPmpBrh273vwIt6WL6LdwpX8GWXjAZIWHATKFgD+4fvBA8vqRNBq35FF/RVb39eLHCGDOTIdO5JDs3GArJNZ+3lJWYjFomuiF5hpK3zILImhpxAh3FCyibmdROGsqT/zD4a/zkymY=
Received: from BY1P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::11)
 by IA4PR12MB456107.namprd12.prod.outlook.com (2603:10b6:207:128::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:01:55 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::55) by BY1P220CA0043.outlook.office365.com
 (2603:10b6:a03:59e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 16:01:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:01:55 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:01:54 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 0/8] Add UALink Loopback support
Date: Mon, 2 Nov 2026 10:47:46 -0500
Message-ID: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|IA4PR12MB456107:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e12b9c-ff04-4bd3-f574-08df38fa9df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|261102123227099003|18002099003|261102130727099003|56012099006|11063799006|261021123027099003|261026121527099003|261022075727099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: vvXNMDr4oDp6AkwvCXFMrp0QjzKG+dTu2wf1sSSyqMs46yBWDMgPp8z5RThQvhfm++sI/QQJVu6Fdd52AUm/H6uFi/WYIpeTtGAfuck/9yfC9Id5FSOEoimm1USGS86P4ch1DDZH+B276FLFqLvK/60zk+uwBNYzdDjZIBgiqldYXGf8uwWyY9VJUmzw8OfkXjIozGEQaYPWdw2IbAUj9eLMZRtZufkeYVa+7+GI1izkVNSWqLHRJAEfgZfi7xm/6aHLuI6/uukbvo8Di6u2yVqroZhOaDM5JV2d/UvcVgY5RDE3G6Xo+QLEBW3X/zrC2S/FcKbISTs4jlarlFOQ0s/aRJzmMwxb1iFYO34Hk7R0Rl1pJT9+5UeuLn0+6/G0r6LrN4oe/+IZCZO3Su3kKU+viUX8aFFy+TsHkh6kMhZjmmcMBb6tcXDl3jppl9AMKpzpDxMdhiWI6D+03UxNgeNbesx/g+LdblY7mLven9za1B8ov2KKEuIyC31n5HNu0b8FIr45QgDWZ3V/tO/qo9WkHm561CzqCJOAO51AY16UkcvxaQXLfi1ZrUU+QnqtbzO7NeSydSA4BbaQL9xnXN1/sNTV+aS7xN4rrHtG9uED/P7ZZyqYDj5ecMKLJDbK8oGY4fpTzvkC7frlt3C0SAGrtBW3jOGKHVarZjlTY8k+P6JDAfNOIOhz3IgsWH4BNZzpQvpPmWPbaZmu2iQ75w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261022075727099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ElgygjdbSspVZeCnorSCwGMI5px+L2+ZUd+sp9t6HZ6BryzSItMtYUGvA3sK+m1li7KfzSLtj4445vBkolzlSYJv05wp5+MytvukVQzLJtvhl7LNlfURbOtuC6pdmMHgxPEt+5KTVxutU9K9f4AoFVtUnXlsfYlY7mz/6eVdeg5h8KdMi6FOdVXw9qka+5Dvl2RLV3TWLPPL32BWjdA9CTn8qpAwzK3IrFVLpQNvHQ1CxZAqWESoTc0cR0G03P7002bDP9bq60BwqcFLZTo6x07bajCYYzVb675LJkKtQIPHte/bNuLP7dYxLmGFNlcSY4QiBCtz5ObKJKtby6dSG2eurIJIvzAjEVEIxP578/WMclrxeyorQj01k66n3Kfx0S9518IHPyPLYhY/PSqVIxSO7+ZnDmRJP0ExIrHXEppMpyPjk67nNmGoZp1CSZAW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:01:55.1991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e12b9c-ff04-4bd3-f574-08df38fa9df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB456107
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series of patches adds UALink loopback support. This will be
used for validating UALink HW path in manufacturing.

Mukul Joshi (8):
  drm/amdgpu: Add UALink loopback infrastructure
  drm/amdgpu: Support VMID 0 GPUVA completion WB address for UALink
  drm/amdgpu: Emulate exporter->importer UALink messages in loopback
  drm/amdgpu: Attribute UALink loopback messages to the correct sender
  drm/amdgpu: Set up UALink rings and metadata for loopback
  drm/amdgpu: Enable UALink loopback mode
  drm/amdgpu: Reject config updates in UALink loopback mode
  drm/amdgpu: Temporarily enable UALink loopback via module parameter

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 548 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 ++
 4 files changed, 506 insertions(+), 85 deletions(-)

-- 
2.56.0

