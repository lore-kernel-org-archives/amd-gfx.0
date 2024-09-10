Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D92ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 13:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A34F10E7C6;
	Tue, 10 Sep 2024 13:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHkNn+Eh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5D910E7C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 13:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItAFlBIAOq2ATgH3E6llziTuB5b/zUdFguuFWNAT8clxI8At7LcJUPBELyJB+BiJcQGPXGSWwZ6HZ6d+NE6AP21nzEohY52V50DZPPfGSYNOVaFs1De3nDCAomVJHCDhhC0TSK3qnaDRJQvQ+QH6u8CGoKzv2QFW4GZEPI87emE6GPZOlFShCTle5iV0UeqHggH5svZ3+/73eauYAxPMQuXFlsSh1W3QF6+FnW1Bl1zFNDJe9ExmVIGaS9QGrFt1cAT27iDKhRwFx5fmiGO/AkZDs5Cv1Y0lgtasdS+ANMOYYHCNj4J5EjToXdGdQhUetw80WYmfeV2HK0YUcam9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOaX1u3fk0ybAvc+ZmE7uabqfXBTv2qLSrDYyGm0/Eo=;
 b=BfDwJNkD5epMmIydvguruHKGKskNzoughwDFNeK0IRLkZPBeuYHXhLEfjBpgk6xL8lqWKK5VwjeJXQ5MbH/8E5fqK9ZSD/K3KOZD42zPwFMo6FOVr4BzHTl1rc5DSqoFyEBjtTqnwoKVkeXjEj+ZMFnexn52Kz+alHDFv6icESGvmC+nb5t1KGqsgmof8Bxa+wdeqb5gR/0q1HOk9CgBsDu9HrZDNS7gt9Hm7a9VJwcyY/Dm7z6k8FcTvxmjWgaKSXVkepQmVmUbPjk80/NkomP1QprtwOPl/z6WNGQuxPfHs5aIs5IpWnKiqjnyuZRhEWmBGpCmMNRM1UKA9N3sRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOaX1u3fk0ybAvc+ZmE7uabqfXBTv2qLSrDYyGm0/Eo=;
 b=mHkNn+EhwvDb2Qhr6eFPP+Tl7PriAcozUZmp4QK1xrIqAzKUp3ktNrNQsU9/Rcc4Zl/xhVxrnaBd7N6Q0eqkyg+XvEqhIbdlkC1CvHM6IAqtFOEa2NXmqhljvl2rDQUgHiFE6PSmkeldrMnTTd+4Wc93qzIg9xoGx5hQEuaF17o=
Received: from BYAPR06CA0067.namprd06.prod.outlook.com (2603:10b6:a03:14b::44)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 13:37:15 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:14b:cafe::79) by BYAPR06CA0067.outlook.office365.com
 (2603:10b6:a03:14b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 13:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Tue, 10 Sep 2024 13:37:15 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:37:13 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Move queue fs deletion after destroy check
Date: Tue, 10 Sep 2024 09:37:02 -0400
Message-ID: <20240910133703.430803-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5ffc79-e641-4f20-664e-08dcd19daec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JoZ5I5v5KxpPFdxqphgJE9G+bNcoO31lcrdDxe0DgiEj70VcI/xifeK4+ni8?=
 =?us-ascii?Q?284tLQVOZa5nKaW3gZUxAtEWwxpO6/beuU/En2apYeu+qLWACtNhJgAsFfec?=
 =?us-ascii?Q?NsAluy+hrX7vX2qMLi7ekUdBth7tr7SLjhAGPhiILOo9xU1c1QKxDCx/WXEc?=
 =?us-ascii?Q?ekfqbJo7+oRuSUmhNhtgTEh9lGp+pNpcYZnYiyYCkLtPAET2VXSZYEX8qnZ/?=
 =?us-ascii?Q?bpHIoROj+8/4CV1DNSX0j9/CFOJYbmHp8Yyp0QLJ/xsmH45oFXzuNqPAN+Rw?=
 =?us-ascii?Q?DRHlNYxwpF6Q63NubuBr+MLvlCwOVb/9zIH3aeHZae7W9FqeKGPj4IsU+wKq?=
 =?us-ascii?Q?swPyP1zuvRb8BljiP+TxaOucaVnGYZ4BVT6VehI0B7oJmtOwllfybiCDMvv1?=
 =?us-ascii?Q?xcTAbM0GeIyPKmoxNkwKVkQh4jHL6xBoxapg2MuNmhskv5/U5uQTTHCBncZh?=
 =?us-ascii?Q?U5aWyxVa0LXpQrgr4DUKVXhGm7B1uL248BZ5CdP9YvywI7Jcl31jrRTr2Fha?=
 =?us-ascii?Q?EhB1zcLg/XGE9+d1ebN2yHK7f+y9ZjxSVL4o/9PzVWk9DxCNPkmO12ddpmRW?=
 =?us-ascii?Q?Q57DeBKNKJGjmIVMrI0KLX8NK41dYAIR0nMOYHuOVUoEm/wRrPafpsyE5wMM?=
 =?us-ascii?Q?LVpbJ14UAdMHIYTjb9h+S3ZxF8QdrhSk48fQWn6Trkkeu/b459zNXea5vX94?=
 =?us-ascii?Q?Aa2oQ4ffa4/1N4e1DtBwCt8CZ7ha4kGYeX/7ZHm/PqUU3vowEzNADCaAWOyI?=
 =?us-ascii?Q?S5J2Ru/kyKVd6CVBNd4kKdiHOkBO2coTN3Acyr+VAposZuZcWY5uKtTeGZTB?=
 =?us-ascii?Q?wqv4lajSJvD9HD1i8dlm5erv6CnrlDEeheLG+BHojxbxrNkRTzQ8KxI2O7a4?=
 =?us-ascii?Q?cIH4AuBI8DvmFbHfvguqMBpoGRfM32aCtGuPI7oVeKg87VVAtQOAS9bqvXeN?=
 =?us-ascii?Q?6BrT0E5cho2XD26oicrDIjgNkp6pBdLJaIUKpQiDmPohJlHg5j+E4IUUQbxs?=
 =?us-ascii?Q?Z9q93yR1Q8miBpH6wD64wOyaLZ0fASWhXSRcwfJQUVeTDLQu+/d76FG7AYkr?=
 =?us-ascii?Q?JaXUP1icBGL8FjL9S15Q3JpcHiBUV4YDxwtKdwQhVOPo6iJT+V6vmtliUzbd?=
 =?us-ascii?Q?Dh2G0tTJAsYgvdINNl0H9uZpiv1N9ydaqFJ7AwjbPenma+m9tdt2jEdzhbzU?=
 =?us-ascii?Q?HB/VsnN655UqKmkSZOoW04Zh+MY/AHxTrGPIxpqkY8yqLTMP12PUIKvAo+5X?=
 =?us-ascii?Q?ZRdfQlH9UPqqR0/HBYePmjOryMLMabCrmaPzJZCQ+kA0zvGEejBCD8PJuVgz?=
 =?us-ascii?Q?6JHFsVu3oP6DtW+raDQFPl18JTbH3s8sHqfW/ComrQQLwpEX8I4hyaDAqO2T?=
 =?us-ascii?Q?o5DwxMoyk2r21V5bl7YjOjjp2bQf7Fwxagk/g1apaU/wmQ3P2xdWJFzD3qVx?=
 =?us-ascii?Q?oOsRD4aIA/4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:37:15.0382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5ffc79-e641-4f20-664e-08dcd19daec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
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

We were removing the kernfs entry for queue info before checking if the
queue could be destroyed. If it failed to get destroyed (e.g. during
some GPU resets), then we would try to delete it later during pqm
teardown, but the file was already removed. This led to a kernel WARN
trying to remove size, gpuid and type. Move the remove to after the
destroy check.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b439d4d0bd84..01b960b15274 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -517,7 +517,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		if (retval)
 			goto err_destroy_queue;
 
-		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
@@ -527,6 +526,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 			if (retval != -ETIME)
 				goto err_destroy_queue;
 		}
+		kfd_procfs_del_queue(pqn->q);
 		kfd_queue_release_buffers(pdd, &pqn->q->properties);
 		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
-- 
2.34.1

