Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602EBD3CCA5
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 02:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDED10E6A8;
	Thu, 15 Jan 2026 02:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4t93Tbz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A59410E6A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 02:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Vn+60ro0oRzo0UWRM52rZ4KhFuyXrDn5hrqZ9lO8kSDsB4Cn5Hq7Q3IVvRStjSi3wkZSRrygL4FO0F3hA5vszeiS50Ie16oYClTJ1UUNCfq8UdC1BdWEmnQTEl7sI4ROcf4Z24Xs4TVKyvbo5dVyxTY4N0pJgcoBt/JksKBlx3vpt0I25+56iRXDph98CaCcgSf0Y+rUtK+Lz2bv0YxmNSOXVGFPpDJOAaQMn0lu1CA6SZ+9EibYoW24EBQk9P+ljaedSXm4TdEr+HhCjP5oBrDYvssrCkKL4JsznooMFnUh87tLVGnsfqvzxOuPb8Tkx5RATeIk96pwcKNSrSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMOuFd7jAyuS8+xDOAavmQKu4Nqe4RjFwDziIUQKkBo=;
 b=ZkZSTDB4ZaDdpgnhd6Kgoach0xcCwNF/Bf7bLb9W3OxhQhr1bDq1QA57EMqW/BifPsiNAjKzUMfA9kMg93zpAUBULTIGRxRw3wuUADM6kTHDAG1gU2JalAQi7K7q9zkCudK/9romGAJ0LH+uH2Sy6wmx9Ki+Eo1IqCbC3xaXx376E95IjkNQiN1yujRvc/Rg9onYOCPWs/9UoEkoMzPBX2+JSBZaDJgY9A8jVKnRRh8mA0E86hSTwaDVaZJtFOc2aMdnrm/v+bXN6Ff2oBZu+romEbqiGJvjAshDJ4OGZ7afYBIrYu+ECKJndgWhoZZ/F3XgN1PPXP6jkOeIhKUA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMOuFd7jAyuS8+xDOAavmQKu4Nqe4RjFwDziIUQKkBo=;
 b=Z4t93Tbza+Cyo4eOQfrN6lyyOxDrD8hodp9241J6eqTE2PgC9Urjhycs4Ix9plAc999X271ebhm7GWqWP2TqjMUydNP0E7RS2HJe9gQzSZgLeaZ6Gci/p9/S4Nr6cBAqcjdX5s4klsquW7cUINUkTkjcfDXQjDFqixt9AJ9Epbc=
Received: from CY5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:930::17) by
 PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Thu, 15 Jan 2026 02:53:31 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::6c) by CY5PR13CA0018.outlook.office365.com
 (2603:10b6:930::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 02:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 02:53:30 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 20:53:29 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>
Subject: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Date: Thu, 15 Jan 2026 10:53:13 +0800
Message-ID: <20260115025313.620844-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dd90d7-83b2-4610-d1a1-08de53e1443b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CETaRhSOh1a3FsFGNSrXujfNq24UNfE5FK4s3yt6yTnwt/PxJxwONpTkkKMU?=
 =?us-ascii?Q?25PEZRmL1CkWUCizcAigmISvPKjk1IGx2QB1r0z8ydzRuIOaAqtplNgUInHO?=
 =?us-ascii?Q?+aDTO/7YAmxY7Kp/zAhHQPFLQzgdxTsDtsX4HKpRxF1SzUt7N9/q/YzF5Qmy?=
 =?us-ascii?Q?3KWKR+zVR5fYAmZfryXsBrzBxPg+V4MhsolJbCJvJ5mBsYIVtF7/0W2LfqML?=
 =?us-ascii?Q?4hQ9NmrHHug1+1A+11P8TkD4aehYbDfRfWGR+Nc3SgemikecZVZ+IBNRVach?=
 =?us-ascii?Q?MquwlnY8q3q0cdzaeKNpIS9CB0O1cN3/JrNGtvY76DQBS6I+Jtw9lfkFZQpl?=
 =?us-ascii?Q?h5rsMAQ2NKE+lFDv4sXzHCQDZlew6+COG+IEqV6BAxWeAbTCnblxD3A2lUfv?=
 =?us-ascii?Q?26TCbYCKbEjEENmCqXiinOWruC7ymQKcYuao1bWjSjomtidX2zNA5UbhEZWM?=
 =?us-ascii?Q?CPCYLHUUtO0Gv+HekFIOjgaspG5tdUhDJPEmhaEaxg6OszTc7keqO6gV0Zdi?=
 =?us-ascii?Q?aYrXmGzrcIQta1hwu6BkDq15R7MKdp5MpEUT2dEfybZRQJHTdkoWVCDqfWO2?=
 =?us-ascii?Q?bSfzn6yJeH9vfICGqhW+Ld6I4jVaXkx1jQ4bkFV/uKAGzpTrLmrgg6jmKsFC?=
 =?us-ascii?Q?L/yNYxpLziR8HJXyIx7iQR/ttTrSz+JLP0PYRTYWDsvi9NUJkeqNHFGYP/Q5?=
 =?us-ascii?Q?LlKZSg70uGLvddTeAVzDIglUz75x/kn4kbqq7ymj35VAe2YZib9eVkB59nKZ?=
 =?us-ascii?Q?eXLq80YloeJhVb7fEcj6PyFvVLtztaQ8t+qQuftk26mVdOlQMHiKnlLYgXiG?=
 =?us-ascii?Q?cxBYBoGzmn8X+CpFFO4XFTP5zhD6EUFpPYXwntImrQm1ewqpaxY53JYVK8Ki?=
 =?us-ascii?Q?I4HY/AzKxOJyXUqPyoDAGaWO/PWR1pCpO2HhOnYQnSZx5BvaVAQvpmkSPoup?=
 =?us-ascii?Q?vSVVXhQO/CqcA8mvqRmMeH0Ysm5aiBkulfrY93tvDgAmKDm/+bjjoNVYZ0TE?=
 =?us-ascii?Q?VxZKZ7DPdfl0wgbwekPuvVAh1kG79mEgOkz9xdXEv+hixCZ1C+YdTC8ERNJw?=
 =?us-ascii?Q?6VUxFu8bCyij0ZMhq3oFubLkGLTrkb9hbhPnsu8D8aoLjY6ttcFyl6B5perN?=
 =?us-ascii?Q?lIqeeWcjh7FyoBnkNJsCUmeF3OvOrpsLEQHTC6jlLDqytZJOT1i7t7xkOXx0?=
 =?us-ascii?Q?nfhOPKUxDxW5mlZa3aeUBMglbnMEDgqF+m5+ucthygRSa4ZUOvTfPskBZZsd?=
 =?us-ascii?Q?UiD/PpfYYaBtaKeXJ9JYzWKWIQXhYwp923towZWlJUAJMB2nm11zG25QpKKe?=
 =?us-ascii?Q?WkMjGHwWqRS5T//iLnKTEowTVsotdZSX11nkOUsDwh/qaqyVp7HIoNLKuunO?=
 =?us-ascii?Q?6HJYXeiRMjN4FiWxpqaCXmpQt47Py99L97Kp31axqkKDsAgZnmlsebEwy0h0?=
 =?us-ascii?Q?Vio3UGD1/uk+OV8NR4OEIkb9+UVvrlXr7+OMKPxO8oFbJcO57kyQjeYaphGm?=
 =?us-ascii?Q?G9SUx9JuwF+CXI5YmfHUsdUSqm7y01fdpdpf+VNtHyKniJVGOjzYOrUq89ni?=
 =?us-ascii?Q?3dz3gCTKw+2CPQ/kanpkLHaObEc3478YYu/59qZnKg/A92RMA4glowm5jxAw?=
 =?us-ascii?Q?3XHB2Ux0Xi+N5bMm0hc/oxsf0lGTvnadhS9EBILBdmiG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 02:53:30.9808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd90d7-83b2-4610-d1a1-08de53e1443b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

If drm_sched_job_init fails, hw_vm_fence is not freed currently,
then cause memory leak.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v1->v2 changes:
* assign the return code of drm_sched_job_init and check that instead.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7f5d01164897..72e1bfd3fe4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -219,8 +219,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!entity)
 		return 0;
 
-	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
-				  drm_client_id);
+	r = drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id);
+	if (!r) {
+		return 0;
+	}
+
+	kfree((*job)->hw_vm_fence);
 
 err_fence:
 	kfree((*job)->hw_fence);
-- 
2.34.1

