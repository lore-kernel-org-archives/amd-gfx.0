Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CDAC71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 05:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669B10E2A3;
	Wed, 18 Jun 2025 05:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHgrLSHa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF70E10E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 05:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E66mc/bCBpdCA98BG1tzDvGj9sAmsYbl3ymH+QdvEIG2WrwiSNMoG8Zvu8fK091i4RDFUdbH37HzXVBArjPCqN2APWE1TwZtTAKnr0AshqSGzdWK+6tJKa2yAZ/aVBRJVF0UL3ZCvqVE77jkndXEAQmgN3Owqz0JwmiqjhqKJ1m7pfHpyotAVmejxI5IwRAy3nISOw6JBfLLtDB6LYbnPRnGKlrbErX+EyMW+i4buZQYz7La+2L7J294t8Jl6LONuGJ42IdFBoV6c899i1JsGrOlD+0caGjBSjAllbtF1cv6ltXPbXyPSvrZZfokG0R6yP+JOi5bbJgCRbYDg1em0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jJ9GsTP4/2inPRtztLnRJ8m3dP5CboD0MOaoVdSQKQ=;
 b=c1ijEicXqW+mVew25EgPsbDzBwR1D6FAgGm65iTd4UOxgD5uTqOUCCrLJLXvCU2XspjSewOsw2C1NTeJYJNmPKkVE6NV1M44txGSDBE3x4Cki6O8GIJvA6Gs9uGedd34XIQVmiiUCE3TTD950ps8BE6cZ/3KXI9ZzWAiPT9/ZUaxLSQiKbPzEitf/QVZbwO47f2LECivwxC2dzkfkJ30W8i67JBVpvsuJ7J2RtGVPqVcoQCrwM1W6C38b4pp+Rg/oxa37CtYFjshwwMLuULiuTrPqV5bu4pGbcjsZn1ArEnim8yEWTbakBpAG5i+71waE542GNl2OtgLeY1+yIgu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jJ9GsTP4/2inPRtztLnRJ8m3dP5CboD0MOaoVdSQKQ=;
 b=aHgrLSHaTe2Ikg9UhNhArVKcX5jSjXp+iyBcI6Xprki3ExUYWAHpQd6xIqWC54fQiKVXE9919n96Dh9XMzdD5souk5YkjwKfEyiawBN/JNF+s3owbiOEyDwJwcMKlVa3LiQue0Fu2oeDMjWohLEtHqA6vGl7H8t4H+fqxbzAdtE=
Received: from SN7PR04CA0195.namprd04.prod.outlook.com (2603:10b6:806:126::20)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 05:53:08 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::af) by SN7PR04CA0195.outlook.office365.com
 (2603:10b6:806:126::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 05:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 05:53:07 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 00:53:02 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, limeng12 <li.meng@amd.com>
Subject: [PATCH V2 0/1] Release xcp drm memory after unplug xcp device
Date: Wed, 18 Jun 2025 13:52:42 +0800
Message-ID: <20250618055243.1128889-1-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 44407c33-dc94-44df-f54c-08ddae2c6674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ptQ6Xd5/NiVFvOIUAEsGQV9BXGXFKXqUjB/0mnPVkoE+Lft6glIr9wqv0myH?=
 =?us-ascii?Q?fxo3BrYIuGT6Y21FRiPOQtJHG4XOzN8I6o4NckIV5nN2sf4OZG86tsoAYGbA?=
 =?us-ascii?Q?cr6iDvY99Y0JR/t1HDq2vuBFRdhx0G132qlrFAYRcQwg2dOH86tuxvjkx0iA?=
 =?us-ascii?Q?CIPSfc16cEdTG9sLnlZsZzAozh9T432lEW7B+WFyDWXvkMuXNVsOr3AuAh4k?=
 =?us-ascii?Q?O1AWcMATBOvdiAuMalcorprUGT7Ob8aMAL8prmfU59eFlEJGWKr/Df0jAUrb?=
 =?us-ascii?Q?Pdn/k3prLP3jY9mT8XjOJa/OKs51aPjTXYI5fzUyn39Vhi9EZhHstZRpEfXC?=
 =?us-ascii?Q?ohEALZevo1TZxzbApIE1pKD54qKHxZJpd8U+65r/rhLjxyRXp9+sJBuiFEvl?=
 =?us-ascii?Q?GqkQ7CkmxbTZlNvV13X8dNfV5P63D64wxyWPd4eLb/dPB8QgXzK1GptEQ5NN?=
 =?us-ascii?Q?QsgFVAZRD+HrjXUsy1zSnzYIvkLJ9y/DczvjJT0zi6OP3jhBfnWGCQPoTkw1?=
 =?us-ascii?Q?1HW6C6rUwGz5a2U8BNVb2buOUR8JvuSZPzwEvAkGvECpfQye2DqVObCtutYT?=
 =?us-ascii?Q?vLOoCbQlbNLOftE0uuHd+84UA9MLgtbbFIJVuwhuScDzGVGDCIDJ+s3i+RCv?=
 =?us-ascii?Q?s5skq2e9nr7+Us/CfGmGuAkDOHyeRKF0HUAx1rQ/rDpum7m/s7XeRUHWukZN?=
 =?us-ascii?Q?LZlf4HQWGR27cKhH/xAXxkHkXpVIUgebq8i8x+hAGqzEH8V6rTjiW3vkyRos?=
 =?us-ascii?Q?3QjQsm0VMn9jfnSO3782SyEpqRpKg0yjTGcI2hcfVhe9VuGB0/V5QlU1xqYW?=
 =?us-ascii?Q?ZkZMn8+qEm0hb/3f+x8jT0wOnSIY5Zo/m4w35BkhjUcNPs+ghnkvdVOOxXgS?=
 =?us-ascii?Q?nf7RAiLTYGntBA9YOl6iVzOm8KPplikFFXIWhREPSJiQ7W5mJCMP/RRM+FCv?=
 =?us-ascii?Q?FB5i9x8f4DllGzZgEWglEFwpdtC7BmRjEZe44fWlEKEE7S+YUVxF6vP5LPuB?=
 =?us-ascii?Q?BjLRU3nSQi+3ZVs31P4qPXQ3XL8uIHrm/x8HSIOz0BLNP+m44D5SkQ4GwPSO?=
 =?us-ascii?Q?cNxacixciAlRbp1CQEAexNEx2wscqD1unD9HuCakP3hED8RtjiIUfCIR6KNa?=
 =?us-ascii?Q?gNRXa6kaJ+pr7kKYvcjO+rvQLNtKDmYPTzhBAl0lDg2rycAiASHRf+Z859jp?=
 =?us-ascii?Q?6Gvq4IzBCZ6DFrAa69lAvxi/jyDdFyHLpN5Vswl/KHLpJXecfWlHp3T/EL8x?=
 =?us-ascii?Q?Ft2HWxWD7FfdMLJIJAo6X+fFsxj/QaKcCF349qXu/vEKBoDYQQlt79odEEO6?=
 =?us-ascii?Q?6SNjt/JKV1IsGuFth6kbuh3M872kLYl37TojL4twvEpD5H2cucue1JXO7qpr?=
 =?us-ascii?Q?UwVfQpv7XgqM++9KqtCGvUBIoI0+2r1FpGl2ZkJjPnBXj4scw7oLrAl/0Q42?=
 =?us-ascii?Q?vkEWm/Txz6OR1kAEfEzatke2JR6iKzu48tBrWnszewsBCVIDTwWx7BrxBCP0?=
 =?us-ascii?Q?jZXqUC/IheVElPDgJEgyHni1Fq9c2Uobaf6Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 05:53:07.6545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44407c33-dc94-44df-f54c-08ddae2c6674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

From: limeng12 <li.meng@amd.com>

Fix xcp drm memory release after executing PCIe remove.
Fix xcp drm memory alloc after executing PCIe insert.

limeng12 (1):
  drm/amd/amdgpu: Release xcp drm memory after unplug

 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 63 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 56 insertions(+), 9 deletions(-)

-- 
2.43.0

