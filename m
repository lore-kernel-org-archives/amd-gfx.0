Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D1C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924D010E393;
	Mon, 15 Jul 2024 12:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvk2cQHX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3A710E393
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/Cu+atr7tMiK0j8fqJ5QCmumg7JnFzxF8Q0T9jEIU59/a2koKD3MPOPeno/RcbUfUpVKJ0B2ywC+X+u+6UstxX1lRkyu4WNKhO2jjZry2QBsHptyLL4zgUW9fB5sLkYkfiT4S0KTiqnfgVhVWfCKl/yi4DwZjLqoqLe/yUBbd+qfzZoljUHp8qYysKaQ//4MK7e9EpolihiRjt1jTOiN/r7+icd1syM9ET3BaT2if5LUgzsDb/MoGK5y3NI+xqWYPJTk2QzcLk+8HN3gBZnSVnc2XWgRt/rYj55GYTjrXMBih0QpOnyoI3pN2Xa1AjopftgoOgahhwODcEOk5yXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC1qRYBUtbM58lYszDZ+vYhrWp1URgMNSBz6Tqlng4c=;
 b=BLVjO1zXKfHvhJGs66omG3+qCA8xTK7qIkGmhX/kd9hLsr6vOecTLr3bzyzTD2Fyo1oj09SuWsGiwQ969R9vJRDSw3uHvMYLuUUPJQ/OrR8rFasNfLrIulzlcWGaSJDEtig/FA15dc4WLoiHgQrVrUBa5PzHF4Qjuv6MP1eLCE2Hfma/CE0bP8ojlb985pP3fug1okSBlbGPccYHLZfPaSeMEt4jtp7MkAVC3M6K56OXOuiDF2S6XX8DNt5cISX9a0sQrXuSgKQubN6FTkY1zyVGvGw+4byDiOL1wSNP+y5XFOrUq72j4od1mY+aLj2MjbOU1YPpB1ECkHnO+bgt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC1qRYBUtbM58lYszDZ+vYhrWp1URgMNSBz6Tqlng4c=;
 b=uvk2cQHX+HPVR/SPmmQsTZ5GpadhJEtECzaUe3aAKDH+uUWWt9jt/aa+HJQY9PQ0xf4APegHill/G8NRWr6f6wBLItn/dfTlbWL2jXxV+Fzn+tUZutByB3LgVXSrryMqYsOwxuMe92p+hdTmL0kDVdiD8EK9ve4WN8+w9wgJgDk=
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:36:31 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::f) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 7/9] drm/amdkfd: Validate user queue update
Date: Mon, 15 Jul 2024 08:35:00 -0400
Message-ID: <20240715123502.7013-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ddf629-5664-4011-d544-08dca4cac123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNX4Wnpvu+9uIKQsGnz/y2jPS5shrJX/mVQ+ejppj4ki+ASHsf1f5yomtzKV?=
 =?us-ascii?Q?gxhbJ6Ys3vJ2pZLWhLbq5IFCy20cvsaKyEKbNEjqFw1aEuVvPa7o/2lW/uCM?=
 =?us-ascii?Q?LgV7gZVVY0XZM+TLo17K1Go0WfmNGQQJKEYxQ2KVBlw/mHqGVT5MW9kY5uo7?=
 =?us-ascii?Q?BpDPLhEntoQtNFxzKR9eO5b8alwSR+7qx6P5MOB0Qk5vgp06tbZ5Dw4fsnw+?=
 =?us-ascii?Q?qAYyB+e99gKWN/0PjDYAQQRAEutgnCzICmPjlVr0YM+e3sTP+xqkZPMnond+?=
 =?us-ascii?Q?tFGrJSDF+fOZpr6ywAaVUsMU5wN6/o00d40MffVD/I0sRa68rxEFV9huzsv6?=
 =?us-ascii?Q?kjTQYv8J5iJMC8gMCnc40iOrpz+7pBOXN7894wQLvtW2rh0Y1diTLCwTNrzF?=
 =?us-ascii?Q?Y0ljtmPGueC3syscRYG/2dlUEQjyapbslOgyOKY1XXB+e6W3TQwMwwAoczTf?=
 =?us-ascii?Q?ZKI0LfrlLzgzXv6ROk4YIOzx3l5Gku/RhbIDFt192I5iTC5eb0j3mfGiMSDD?=
 =?us-ascii?Q?2H4xWs7dTCUjGJELhw4uMSQ5B8eZiX4BUUBC6XZNOZ5uXc75Yx3XUgRgZHDW?=
 =?us-ascii?Q?LLz+5wgIu6EmI/POhSvC0ntQt2QYAxseFk8fBvqPO/nSaTDG8d3huHvGBwRc?=
 =?us-ascii?Q?GAQTGsUH0U77r1bTlhGoUIzXwSZcGKXLipPTinb3pgEZhT8oVw3jNPi8f/yY?=
 =?us-ascii?Q?Pk7Xe0VqtOKpFjiVFUdu9mKKckgm0T+GWg3XWSEaZio4/oHkhRecKstfUf1d?=
 =?us-ascii?Q?b+EcU+FmPsvt0zK4f8nJ+bxgfYfg214XvKD1l1cloWIykICNKhSlV0ng16E4?=
 =?us-ascii?Q?8hVgesDuK1NsfI34mIdon8/+Sh85s0CZeXCt5J2JzopOOSIKNL5OXGbYS78V?=
 =?us-ascii?Q?ibV16oB5ymTPCBqmao98pZ9mW1fsLr054zjAqbj9+GGOQ5zRc7gPA7N3c6fU?=
 =?us-ascii?Q?mKI4P7zdkB4xxIBU8T/enmGfvQuCjjYIJuUTq37utUcY33t++Pu/Wpo+mMHV?=
 =?us-ascii?Q?7KcBpYV5GdLwZSiznDgrDD0KAv9I0qqvTkf1fRbx3Rx0usUTrUBvhWdH523B?=
 =?us-ascii?Q?X2R6QNgjCgauZMxIsc+he/B0SIiDzn5rECgHvCyG/+WyYndqoX0mSAhAl08E?=
 =?us-ascii?Q?o56uFayqV9HxoDkkVpVlmukDNUYpvscyOYGbAJVXS9Pu3NPRM08vjuLv4nTX?=
 =?us-ascii?Q?RK4Q1GbslB7Elb3NLGVEaT9KhBdbyobky74L/p4KcrGSX07d9oVPP9PBTwpx?=
 =?us-ascii?Q?kEcyLTC3BGw5eboOpU+cMX5WxwXZ2OgDbsUoNFWPpwRljVLCGtLV2lg4gKxJ?=
 =?us-ascii?Q?c5rcaEL4LRKLxJxbJUaHjgrPDzfIIz8yM9Dm5gAvRef4FtRCzlWyva7fZ6V/?=
 =?us-ascii?Q?33fK3fJDuGfOhfqAFg6YtXUowToYd4+kUMzjTu1gDuUDoN55knfAOvWT8TWq?=
 =?us-ascii?Q?in/yRE9lz6zI/ypi1UmZHomhufW5vIlX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:30.9217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ddf629-5664-4011-d544-08dca4cac123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Ensure update queue new ring buffer is mapped on GPU with correct size.

Decrease queue old ring_bo queue_refcount and increase new ring_bo
queue_refcount.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8552400d6d47..dda26a7e3c37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -549,11 +549,41 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 	struct process_queue_node *pqn;
 
 	pqn = get_queue_by_qid(pqm, qid);
-	if (!pqn) {
+	if (!pqn || !pqn->q) {
 		pr_debug("No queue %d exists for update operation\n", qid);
 		return -EFAULT;
 	}
 
+	/*
+	 * Update with NULL ring address is used to disable the queue
+	 */
+	if (p->queue_address && p->queue_size) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_vm *vm;
+		struct queue *q = pqn->q;
+		int err;
+
+		pdd = kfd_get_process_device_data(q->device, q->process);
+		if (!pdd)
+			return -ENODEV;
+		vm = drm_priv_to_vm(pdd->drm_priv);
+		err = amdgpu_bo_reserve(vm->root.bo, false);
+		if (err)
+			return err;
+
+		if (kfd_queue_buffer_get(vm, (void *)p->queue_address, &p->ring_bo,
+					 p->queue_size)) {
+			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
+				 p->queue_address, p->queue_size);
+			return -EFAULT;
+		}
+
+		kfd_queue_buffer_put(vm, &pqn->q->properties.ring_bo);
+		amdgpu_bo_unreserve(vm->root.bo);
+
+		pqn->q->properties.ring_bo = p->ring_bo;
+	}
+
 	pqn->q->properties.queue_address = p->queue_address;
 	pqn->q->properties.queue_size = p->queue_size;
 	pqn->q->properties.queue_percent = p->queue_percent;
-- 
2.43.2

