Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FB0CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 14:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5781210E462;
	Mon, 18 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1mFH6WUD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF4110E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYnZcWEd/47UtotE+qUQMhTdZJJk8CcXw0V0pC0RBh4CA/mloHatW5dO4L+V3hW7Xvm6uEfbeaLWpZEsgG6rS5hPykUbi0zFDz/TqKrQ9MYWptazEL1yu4oRXKN2oUyve8xbrIaQsDTAO+CZdQDpbfj6u+fUpKXYJ4rlkIPfUDsbxZFweWRouN91I9righi74rQPl6KE0FzLWVARII9zdJ0QUTq7T2q43aZ4OIKuHVsaub99PP/G1aLpxjEbgPLdyOoQRJdu1CMPyAFNGO4s1LT3zgwxinccVB6/Rbvnd0i92ofVsw8Tj/ZZpj+WSrXMyafCkTE5LdcMLdztRP7gPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isHopolhHpl9N59Mi1/Sv28Z/AB950ob0tQlwsQNAKk=;
 b=L1y4fy2qWcpoqsUp3t38FIniWrfTRgGa5VJNRcqEAmhUyqyeZ0mwzlxshsoTyLCWYUB8nu8n9zetRObxVOjN0V5fyv5+3s0by1/G/qfbxCbudwxlc0eY8Drn14Q4DgmnNdbTZSaIu8zfUczhqQ73+SeMpO2v09sFmBhasONvXQmj2kxcvHVxUXgTWEe7vvUS2O96jqvcWFQF51jmLD1yRaw0rPYN2qUSKPDRvWSdnNEOLFMBZEjlsiwJ92gzHqtoLeq4TjbQ0Y5Ajlr+VP+C5FAwUn/RqizR1FRlkNggGPgKhJyvsd9vbFSaz1X7vdMMJcMkNqmBGk53XFudRG9JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isHopolhHpl9N59Mi1/Sv28Z/AB950ob0tQlwsQNAKk=;
 b=1mFH6WUDpQQuibg4vHHW4x0a9iCG+t0lXepXlfSKvv1JHa+QaGkeFmEe6Um4pX4R/2MiYFc7G2Ui+q+Xpj/UxUoi2w94GYdLNX3iw8EHh19Q2OXktnyhL3HWSJ7NL+oR10Yd2O80IZePkWy7Tnm50jbnm7Eqh5opibBnGejphtI=
Received: from BLAPR03CA0085.namprd03.prod.outlook.com (2603:10b6:208:329::30)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:57:54 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::7a) by BLAPR03CA0085.outlook.office365.com
 (2603:10b6:208:329::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 14:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:57:54 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:57:51 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 3/4 v5] drm/amdgpu: Add a mutex lock to protect poison
 injection
Date: Mon, 18 Aug 2025 22:57:37 +0800
Message-ID: <20250818145737.318621-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: ad19b7f4-92e9-433c-f6a9-08ddde679c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oTmEpCX9Xepc8FHQGVi2W1wpRXQDQoWukm2W8Y7uIxKb17f7HHf+RQHDKQD2?=
 =?us-ascii?Q?bH/UtbCnf49upOGD5Jej2tVpPBPl6Tt9l42SUEXYOWHXA8GtuW/Zel6rMsm0?=
 =?us-ascii?Q?ukZ3nioiEPvxbNbMXpLwqohpZoSVxVYMMPskjlHe0ZMV8TIp/Ojl6wCD7Xlp?=
 =?us-ascii?Q?UtX7Fyb+ESnmBCUoAItF1YnJC2wKTIc9NXz/e7hqejb+BRRN+mopXW/jcEF8?=
 =?us-ascii?Q?owLQ1ljLmyrF6FoNXL1SkbrOaMthwfbehrfEbTjlxjy/LBKcg4Uo39K/pofz?=
 =?us-ascii?Q?scnWKaP6Zz8gvdjNMyUrb58ZRxNX67nR+uLTnCSh/RWE85FP5HbVwT4kISfC?=
 =?us-ascii?Q?qNckhtwx5HeOf0acT4misxO7SAfEtbL0KwaY/J4iXbhm0nEfzLACfoWws9oF?=
 =?us-ascii?Q?8chEGCHrra7v7YlH9pfju9GIh/mMNjLE0BMzpgBhtZTCV9w3p/jqbs3AV6S0?=
 =?us-ascii?Q?PVwZ1pCZ+ET4H+Vpm2R6VWcafW2O7ZKkOONSJUANCrBrfwFcbr4w3T1RfI3t?=
 =?us-ascii?Q?QbfwnINycQ1G6hFcecywRhzhRZf4rSyIFGlCDwNJynC3Dt1iviLnoIqD1Ihj?=
 =?us-ascii?Q?bgNco+AmS/SZP0Fl/DnNYVo8En39a2EhqUX4hDzGveB87gc5hUKhLYiuAatc?=
 =?us-ascii?Q?DO2JT5mey+nE/jIw7csgxjgWzcKiH46fdGibFrxJge+Zpf/8KVxgLBDV8y/C?=
 =?us-ascii?Q?kFZBscvUB+bM1EP1lvk6RyHnsAJQyramfIP5vcZvTgKrJIJWL2EsQ12RtQ4x?=
 =?us-ascii?Q?Icu5VBoSAB/0QdExtaBFQGSSjHOCeQMrFVPnwZKDsZHhIwvXd6NoHJhGtyXn?=
 =?us-ascii?Q?yRkUh+I7SprGZycym13rCEaGANmKIQN2SwawsU/oAVkiMvHEXy03hi7RhSnX?=
 =?us-ascii?Q?EpB/bbbpbSF2WN+4NkPBhM++/OkkdNp+xbyeTH0v/u5JUf+5EXnrGYIoHxYr?=
 =?us-ascii?Q?Rk8BXzpL8DA277gLcEjgf8o9RjyUi3k4qHPRnmXcMPzC0Bkr9ylly/5kSNjQ?=
 =?us-ascii?Q?11XLbFsvSz9vOgWlDay+q625gxHYcOekecnLfi1cUjgS3AAQRfxfTsmgiqpj?=
 =?us-ascii?Q?OsLX56Cpj0r+OzxuwlOOA+iU2vHaloVZTLCz+q0MNgHkIAGOHid02uQSeZw6?=
 =?us-ascii?Q?WKHH3Q6SO+D/QaRHk07a7IeUdlDPtZE1aIrjo9bJMj9u7arl/W+2eXjEbiJL?=
 =?us-ascii?Q?V528tyb9MmaCVEEUdRQAV45RrQzmgWaNpVlQrvOHo10JEiv3jsbfq4fep7bW?=
 =?us-ascii?Q?eSwaG+F6b0O0isqkjrMNoaBE4i+L6aejqZsG+P8JHIH3dfonyX95mfwxBDm6?=
 =?us-ascii?Q?tKnoYLtPaW24QDKW8EfZvMXVVVufyMSgp7gDs0SdF3C9jFBv52Euhzh5t7Y5?=
 =?us-ascii?Q?2YSAbafZ4eVlZfu52CQ/BxxpjsywqI4eI/fD0lmdcVY4QTHFTp0lx/tCCmcj?=
 =?us-ascii?Q?kfh/pB7F9qvD4VpgBx76CXRaaw6wUzeCIWLxe4mpfMcwnlEHV+O/ztnxZEHh?=
 =?us-ascii?Q?vIy9xzzNUA8niRjqDcn81+odzkzL9/+E5NDJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:57:54.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad19b7f4-92e9-433c-f6a9-08ddde679c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

When poison is triggered multiple times, competition will occur.
Add a mutex lock to protect poison injection

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 185b9e538f98..31850a47a41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3503,6 +3503,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
+		mutex_lock(&con->poison_lock);
 		gpu_reset = 0;
 
 		do {
@@ -3560,6 +3561,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			/* Wake up work to save bad pages to eeprom */
 			schedule_delayed_work(&con->page_retirement_dwork, 0);
 		}
+		mutex_unlock(&con->poison_lock);
 #endif
 	}
 
@@ -3657,6 +3659,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	mutex_init(&con->page_rsv_lock);
 	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
+	mutex_init(&con->poison_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7f10a7402160..6265dac0e1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -573,6 +573,9 @@ struct amdgpu_ras {
 
 	pid_t init_task_pid;
 	char init_task_comm[TASK_COMM_LEN];
+
+	/* Protect poison injection */
+	struct mutex poison_lock;
 };
 
 struct ras_fs_data {
-- 
2.34.1

