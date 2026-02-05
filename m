Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E54EC1EAD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 12:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FCF10E881;
	Thu,  5 Feb 2026 12:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyQrAAGN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3056B10E87F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 12:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh60eeD3h8URPzw32tnGSok0Pyw+RNjbG7Pkq3OHFZY27g4lqMxzHuzMyxQjG62FuNZbJGKCA0BM9VSZOJ7IGJeiT1HWi4fvsZxphreQy1cwCjNZd0eJd1TynuZS/4LGg2Sss6HVU/17RmrIa3pxGLifxXiXHvWL0oY5HK0B7ViFj1aY691B2xlNIu0Rn8yHXM4DXYGaR9AlG0zs8OOaOsZxBAX1ZgKfxsmy5uw7OvLuFnJI4nhpc8qweZMppSoDoHOmmY+OVQii5B4d+y+VAPj+Sn7kp2esTUKndH1JeMrsbNhNecz/dqBj1p/yqHSi05/VHEl4tZs5NfRh4N6qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86c/4vpzPCL+36FpUUtcQHq81g7r4B7NRFfczT1uW18=;
 b=JujoJZ5f5Z+kR/0nSuj2RD+b4ni44BSuRpmSs4JWoNcI457GWMM8I9LtohBfbC3nhpIKu8ijZypj2c7rSSAu12YhmI9pxtoU2WLI/y26uuXgCMz4fU5NaTQcA06FaDC4CI4v3QiCZbS9Vp2Wc0fRvfcmfErL2lLIYLmHmpBMUXeUpbQvP9fY/XbgmQvYQNlhg92JrmZxtIVfpjavGMwQJqWZWGXc02fjvG41WfxS8R1pnleFHj6harTP1Wxn7Awd/+E020Srjg+zhUMGtG+Pf7Bjnc3BK1kajpphqx+Pip/WNDC/7a0NybPliVtuwGy0nJq8qRzqX8Lkr9VjcJ9Vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86c/4vpzPCL+36FpUUtcQHq81g7r4B7NRFfczT1uW18=;
 b=LyQrAAGNuOrm+8tS5uKe7k/qU1Zy1UjwJ8/aq2yCi24avSCPqXt1T0GhrRdD9XW1XxNbtQZt/jnVgGyJ3AUG3Nm49/v4Fd64sPJJ1zYWjg6+4fvF/wuxFC3taX54qBph0I9nFh/ODmBHM23b9rgZEjeSGQrr/sF+zLy55dtTQoU=
Received: from CH2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:610:53::38)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 12:27:19 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::36) by CH2PR17CA0028.outlook.office365.com
 (2603:10b6:610:53::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 12:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 12:27:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 06:27:17 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix parameter mismatch in
 amdgpu_userq_set_compute_mqd()
Date: Thu, 5 Feb 2026 17:56:56 +0530
Message-ID: <20260205122656.286831-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e073c29-b4ce-4aeb-fc9e-08de64b1e799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bURnYXBoaFlZcVFkaFFBaUI0MU4xdXBaQ2d0V0ZxWmQrYUpxSXBFSlRvTmtT?=
 =?utf-8?B?SE54MXc0QjIvSGU0eThqTFIvelRlNExnU3hrR05qMVJYZnNaQmNYaW1wcFlQ?=
 =?utf-8?B?U20zR0JRc1gzYmIyQlM4L1RYNjdZTGdxNTg1VjByRGpJUW1Rd1lhV0kwWVRh?=
 =?utf-8?B?VG9ubFdRemdrYlp0Skt3OUNWQk9aZGNzVFdua0NzbFNxNHBVVkR1U29GcXlY?=
 =?utf-8?B?UzFoWUhuV2czdVo0WHhVOXduY2E1SEF5Z2lMU3BzT0hNS1hTVHBLR3RweFow?=
 =?utf-8?B?U1N2WStBRHVSTDkwTFk1STluUGJObFhXNGNJc0tXMEhOSlp0a3RKT2NIcmhr?=
 =?utf-8?B?bG9BWjBBcHhMUEJaYjRmL0h2dEdHT3doOFBvZHFtNmVSUGNleDRUSU55N0Rm?=
 =?utf-8?B?V25PSk1DRkdFVWxSOWVEd3hyVFlwUjFMaWlNTVlSMTVJQUJEa2J3Q01zdWtE?=
 =?utf-8?B?dmd1eitiUG5oWU1KaTVqYm8vMkdyUGZkUFdFSW1uaVUzU1FyOHB2RlVMTnNW?=
 =?utf-8?B?M2dNTDg4RVlFMWhRbWJrRmVIZEN2c2NlUXpNOURQUUs5RmZlbk12bzRMYVpL?=
 =?utf-8?B?VWUwTUxyb2RyZUtLZml0SmF2ckxUY0dHRjFIcTVNWlRjTUl1ZzhTYmkyREt2?=
 =?utf-8?B?Y28zU1AvY2hYQ1dFZDd0anI2OFgvWUVlOUlPZGtDU25raFhUbjRBL2UrNFU1?=
 =?utf-8?B?aDVIV2h3UUZ4VkpkK2ZpVkxGMEVKT2xML3UwTXRHYTNaNlIxTWhuc0RQTDdu?=
 =?utf-8?B?blhoWTI2WUh0R1VvOXFvMnBnRVNPZkJxYnIyOWYzVWhncFR6Mm16bmlNQStW?=
 =?utf-8?B?Y3F2aGVHMVhXNWNEZktsbk5FRFlpK0tuNU02QWJNOHE4ZXh6QmRDK1IrQ1k5?=
 =?utf-8?B?bE1tc1VxSm1mbU9xSkdvRkxtc3NHQitSOWhsNGN4RlpJZlFmLzR2UVlRckM3?=
 =?utf-8?B?K0FEVzN1dS96L3JrbFBpcG1XUHhwNXloMmhnZHJqZ3BFMVJlQ1RJRFlxMjFZ?=
 =?utf-8?B?YjlVbXVBQlIyNUREbWlFZE0rdVE1R3JEak9keEdEdUFheUVPMFBtU2gvb2dt?=
 =?utf-8?B?TmMySGhkSkJNZDZYalpobFlnU2lFUnNhdEVpN3Nid21YQm9MVWlPVDBKMDQz?=
 =?utf-8?B?RzM0TmpiNnJTWDI3d0VpUDJ6MGlCek12bHpZOExqQlY4ZWRueWI4SlRvVFI4?=
 =?utf-8?B?dUdxM2lxMjY3bE0xNGpLY2t1LzI0WUttWno3K2dXTkpubTdEajIvaTZCMkhP?=
 =?utf-8?B?RW1CaEEwNFEyZ0ttYUg3YktuUjE3ZUFpdWpvcGtWVmpPTk5aT21NelZNQ01y?=
 =?utf-8?B?aHVPNVk5L2hod25QbVBNQWJBU1dCa1B5L1cySEQrYjV1dW5qSFFsUzBjeG9Q?=
 =?utf-8?B?dmQzNjZ4cTJyUXFlWXE4R2hkQmYwMUYxS00rSkp2dXFGZm5tK2FoenJaMVgw?=
 =?utf-8?B?MjJ0ODlrTWFJcmc1d1Vyc2VWeG4xRDdGanUreHg5aEtHMG9HUzl2ZU5YUmVm?=
 =?utf-8?B?cGdQUmUwL1gvQ012RWpPK2VYc1dWVW5iMVBjb3dKU1ZDZXgxYTBSelp3T2p1?=
 =?utf-8?B?eFlWRVNsU3dYaEk5QmQrZENtQkpRZ3hnYkxzWWgvZTVzUjNYQnVpcURkTVJI?=
 =?utf-8?B?c1lpeDI0WUFrUXkrcnc0ZzJ0bHdXMXBMUGhQb3JOM3E0aVppS1FabjNsWHJE?=
 =?utf-8?B?S1o4d09pVFdFNmlVRnk2NzJmcWNKbllVNDhlOU8zSG4reFBmREZ6SktlUS9x?=
 =?utf-8?B?VjcyU0tqdGJ1Q2xKaGJsZThkdC9Wd3F6Ykk2K3l2d2hyYm5FQjdXVjdHcGw0?=
 =?utf-8?B?aHRwcEJsMnpzK1FpNkVRUDdHem0xVEY3RHdxUEE1WmZ4d2RnOGhSSXoyQjhT?=
 =?utf-8?B?VVA1MUJKbXE0MkJyak8rZzhncWMyOUlqVWUzTG1wMWtkT1ZLcFlOQ2QrTDhV?=
 =?utf-8?B?NnI0clNZK05BRzk5SHRRVjFjNHo2bnFRVW04c3IwaFMzTENLdndzVm95Wkxq?=
 =?utf-8?B?Tkt4Y0tvVW8yVVkvSm56bW5pSGxEd3JQeHlTeUVkdWplZ2ZZa2lJYzN6YWVO?=
 =?utf-8?B?blY5cmZCYmxydXdSV3RBbTEvVFcxeFc0TGJJSkFieEJTbFgxMlMwV1E0YzNu?=
 =?utf-8?B?VmI1M2w0d2U1eVQxU2pGSXFFNmRpZnl2Q3V2WTUyd1RjSlZnd2MzdW56RGdD?=
 =?utf-8?B?NU9BOTArMnovdncwUTRHeWNlV2xLeS9KM2RJYzE5Zmx1TzdWV1RFT05FQnFP?=
 =?utf-8?B?TCtQZHBQVGd5SVBzWW1TQWhETkNnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MGDv/bR+kS6EilcM05y8Xf74PYYjnAmSRU3x2VmAbzjxTt8zrgwD+EQ/JkqXMGLRmxf/eRwVrHMhLTBCJ9QX0OSg/hq59xg07hIlhkEWsBqVhrLVnRyxLf/gWD7tBZK7Wp3WYIkrmHqYZ3gqcYMXee6ZVMO/zNy/PgJyld0ZHWr8kCOwXyL1Cvg4Xt9sBoaQLmFUrQjZ0+F4P8RenxhvfJ5kPf8jzEYRU36LwO/3CJYyzjnV3GD7+0F+3xTRQh0m9GLsFDU3MBZYUZJUhKhNTF+THq54jGsMzhmMaLpd4OYHYPsWv1U2ta9xkUBEWRRsHPMe9dKZxpHpgYr3jTkoKfmXrI1uOnMYVTx+v0SL1bYlEamLzgvGqBtkByjH/sD3aWrllVtkXui6nI9B2UVt6tylEcDHSRALecC81YsVfnpwlvbbGFvBgo0p9/0B0nUT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:27:19.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e073c29-b4ce-4aeb-fc9e-08de64b1e799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

Update the function documentation to match the current parameter list
and correctly describe compute_mqd.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/mes_userqueue.c:308 function parameter 'compute_mqd' not described in 'amdgpu_userq_set_compute_mqd'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I2f6efa8e9886106d6cdfcf0ff9ffb2576d8ba606
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f4b3073cf968..24d102cb1474 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -296,12 +296,12 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
  * amdgpu_userq_set_compute_mqd - Parse compute MQD and update queue props
  * @queue: Target user mode queue
  * @props: Queue property structure to be updated
- * @args: User queue input arguments
- * @uq_mgr: User queue manager (for logging)
+ * @compute_mqd: User-provided compute MQD payload (GFX11) to parse/validate
  *
  * This function only parses and validates user input, updating queue props
- * (no hardware MQD configuration - that's handled in MES layer)
- * Returns: 0 on success, negative error code on failure
+ * (no hardware MQD configuration - that's handled in MES layer).
+ *
+ * Return: 0 on success, negative error code on failure
  */
 static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *queue,
 					struct amdgpu_mqd_prop *props,
-- 
2.34.1

