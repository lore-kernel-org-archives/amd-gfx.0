Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B865CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D3410E485;
	Mon,  8 Sep 2025 08:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXPESSep";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2E910E485
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kExpzOsU2wkEjWb+gO2JLHwuMk8RZv0+B9Atjo6H5+bL1OZeZnDbtRh3KqxkVHRtKfZlIPkU9XHmYatdzpqfvKTfC/zaAMGb0wOcmAwVj5l1ak7MMNce8E5DXQklrjMrpIUxO70LQyaoNlt/8KEMpZI2ntiw4pziExEo2WmjwTdyV9vD3TDMcS1MFfgzNcRfPT9VX9e5akION0mwbZdfwo0H00DIp0DkAgj7zF1YyUcXUeA95lFEFdiQNo1yV1C3+X2iDH7fo9kznADPed0ROReqhvla6RY1XLo/KOj6jYPVkEAbCNqa6c++Fy3Nm1fWEay2GYo4moAgwXZR/oji7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=ixBtcfleZHszHuOgMYjwnTWMBdTsQ07Ggcnq9NNwdZkpKjnZrHKPXHT/xKy2YaS9gZV30GNL56KssQ/8RuRoDqa/Flnp9JvwmyNSb+7/Gsd6djk6d27T4V+RLnymwbSgB2wqf2kWEb15NHTlNjeGg5RC8ok1OkmpF7eYiGENynWi1f0e2YVeQTHygtNq60iwLB2GZFhxX+GABF1jtd8ZVuMuYSWm+REwPX7Ua7fZhwY2Q6D4Tq+tldiWneIxY3Ja3NAzpUAsubtPi8+C3ZeRnWRKNgr6ihoQ0OxuucedcZ6LuMpGO2/LyDaBkjqe5kBMbw9erYWWLJN5V5CgCvD/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fqXyZVQFX/ZBh/ML/luGKld4KvPRG9Mv56GshTOrbc=;
 b=SXPESSepHFS8QGm8ST5lwU7Xy2J1VYyFLb0QKNLBSFvNcP6wVmB5jXQBRnUKGwO9GS3KqGmtR6+/BlHG0NLbtdYW/T7LPW1DmTqcclu5u42LH0naBmnqzzUwJU6LY1QomvPLgn72D0ixREpIApvhDu2tGL/sZ8lvTGQTxqNA6GU=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:10 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:00 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v10 02/14] drm/amdgpu: validate userq hw unmap status for
 destroying userq
Date: Mon, 8 Sep 2025 16:48:34 +0800
Message-ID: <20250908084846.1873894-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0c5895-7010-4813-b02e-08ddeeb49413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?91sCJu4x645Odow9AbzRLJSqJzTxbaBmnzQw6ynhOcsqVA2R5Jyz8SnVi1eS?=
 =?us-ascii?Q?uel2f9gMMGuYbauuVmN6+DhSphqhYL8ycSlraP5A86dgsvlcXL9dOyr+RzG3?=
 =?us-ascii?Q?myYtyElUnD1VzlS1IVKO1vXbK0j5VOPMD8K/dxXP5OD1wdUrJVQ9Db5Pc5EY?=
 =?us-ascii?Q?aHnytiqXqpWS2N5XqT7ZcAWazZRi4DGWppCZCdjicKH5um2/dMq4IsCPgMU1?=
 =?us-ascii?Q?IOlkizcZVhh/BTzoJU8B/ddOWQHk7rgo92hI7/J1lVCoGPsrr11P33/pdckW?=
 =?us-ascii?Q?Ypze4m6JNVYFmNHZnq2qcmhU30l8WCzy4bHSnremBN5cVvhy6XqnqdSJ6OE2?=
 =?us-ascii?Q?0IBnNIeCPeX+aDi0vUeLsVI8bh5kTpNW/+AXubKGNTdCdxujDfkWjEW9gFuw?=
 =?us-ascii?Q?pWpg3OzQIRQYJD/X3lmYxYbwgz4ESY4DuofIW4Y9sqKhfiLZDOfoa6CRSkfe?=
 =?us-ascii?Q?oYTysuufcF3UoB7fnd1SV0i8UaCHQxh/zlwMjzd1IOle+IJd2224dFXIAMf1?=
 =?us-ascii?Q?wAA//8mm2RT6vFncEh0pqSQNPuIXljvX6UfHFtTIUhV9rjFUmuG4gba1C2RQ?=
 =?us-ascii?Q?VurbqBS8PvyzhJbwrQmr3VT3eWEIwd/hWAhNpof1gm7Z0XJWxtQlslgMgPjQ?=
 =?us-ascii?Q?abmBzVLO+zNAf8adonTf+tln5meNDrrtMXz7Fl1RaNnuGELZPFRce+t7SX3G?=
 =?us-ascii?Q?H4PJkB+OKaIwUSHCeuGyD9d3pCWBCx/kNtSlJaiWmeH950wGE52hR7uvLlrb?=
 =?us-ascii?Q?REnyJWHsDFIA3m2GQZdr5cDnVFLiJcxaq8ify4YuBeKzKAyh6XqOEF97d/f1?=
 =?us-ascii?Q?CcK4Z9MaIAPN2kZoCFTJXPYfLO+i3ItptQ65ScNZegaBr7QbisB1r04yope3?=
 =?us-ascii?Q?tPnDuSWX0j4W381pF/A8dhs1Eeb/5OIEGwP8wDIPhr1JO1MK57Uoe5w0qAjY?=
 =?us-ascii?Q?BYO+Ohs+YCs3HAFV0icm96ReXFN+MSnyXzYvthLXpvoBwbm/0AiwNkr1giVW?=
 =?us-ascii?Q?V/0jBgJN1BqP02zCwb92XE6eCYfWr/TCaTM94QoHINYbtslNPhTNnzSo5GTq?=
 =?us-ascii?Q?QEntcvCCvM8NbzpIAC+FmhtZKr4zvmbZJvXMoC2DJVpG2pqpyoFHDe44YuNO?=
 =?us-ascii?Q?CwJPuhshxqwAe6GmdczfOc8cU5knbt1i8OYX62qWjkx8tLhf+Zcyl4y355VN?=
 =?us-ascii?Q?pdZX5VXTsqlOTuhpjhC0yE4Bd1qaVpNSQVt5PEIdmaGad0FjN11iebSONwsR?=
 =?us-ascii?Q?bQIicHcKuDCPN62Bv15DF+qdieVjIO/McETiW+RfesfKJQBkebYP0l2OeYWz?=
 =?us-ascii?Q?dLhJlxlQlFaC/z5gtAs0O68eDawD3xc4YFkmx1AOY56Fu4kOpBM92dDgKtRm?=
 =?us-ascii?Q?ENt3R1ycxDbnAd/PhpYwK6DUo5QOOoPf1pj01P3gWwRZ3lka+l99TtNG2bpX?=
 =?us-ascii?Q?dKCHYtcg5o8/ZJEz7SstrLLgNYpZIsqBklJCO5sGsDCuGGtFvsiyFMoz28j7?=
 =?us-ascii?Q?GPpAdvKisRAPlfqPxwDvFEOz0f7BiQNZuCXS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:10.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0c5895-7010-4813-b02e-08ddeeb49413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567
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

Before destroying the userq buffer object, it requires validating
the userq HW unmap status and ensuring the userq is unmapped from
hardware. If the user HW unmap failed, then it needs to reset the
queue for reusing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7f9dfeae4322..2b35198608a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+	/*TODO: It requires a reset for userq hw unmap error*/
+	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+	}
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

