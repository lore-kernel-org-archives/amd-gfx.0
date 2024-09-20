Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A806CF9C59
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 16:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B5210E103;
	Fri, 20 Sep 2024 16:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QcqCkx5I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7BE10E103
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 16:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud2e7NdT8HnMRoV0DB5NJcdbeOYmu+iSfjrZsy0Xvrax6D0O5vvxfuCgnZZWJ6Bs5jA/8WaRxNgfnEGF+MWl5iKE61/BVJT/WkiK3l+uaziJdFwvysxDkLajXdXdE9p1KBrLDcEPCvnA6kRic8EW69mfMcpoRE9hJXpOj6Su24+flJ950fGHTMAYAny6KcUymskJnQQxW8K/l/h6mprQINj0TtYwVfSXZxPehmqixJMrERa0etJnNK3pjr3oX8l3f+uFTfLZ3Jb06E9jSykiWTgbUEhcD7HEMAAwMsdB+z2lY6suV4aTWctjUVXdDZoVMX459midTgxQAwYpH2hmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj2hbcdgRYd5J2rrTNM3GhAgk3fiey34yqoRbFUyshw=;
 b=PicSBnkFqlzclx+hX9Ll6hEyzrB2U7YFfNxTJOACYGhi9pBOLD3XesSlojAcXAv7SAK4Am7tZ6631TxGyJcHIO+3Tv7Dg6demcV/POpKzucmq4pFq6t5qpIw9IYYmLKnq18jUilGokPq6v4FlrOWzDFQ6d4s7K7Ltz/nV6QAP+hFVtOUixloEZ4204rupjBVgIhj4Zs/S6ivOuCWWOWi7PjZSWy3iWb101BoM405PLihsetdjs5D9UfNinJSWjK8OPMpQr3Kl7IDzv75kSG6PddfNjNIbd6q/3KtSd2ahJuQl0mzs4DwN1hB4CwgDvnk3ocuPTqIsjoc3XWAz+y0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj2hbcdgRYd5J2rrTNM3GhAgk3fiey34yqoRbFUyshw=;
 b=QcqCkx5ISR0ig+/Mcd1mChdxkf+m5joM6EDwfl6GkEJFjQHXg3X9vNDeGVKvuAlr4sDdgl/e36OU7EjBZRu2eDfi4pfe97jrC6iEbcjkWk6EpC7ZgX6lisKAGaGe4PT4L+h1uPojGKcg9wxg8IO+dk3dg/d6sYkVWafwyEVBkLw=
Received: from SN7PR04CA0237.namprd04.prod.outlook.com (2603:10b6:806:127::32)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 16:14:36 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::28) by SN7PR04CA0237.outlook.office365.com
 (2603:10b6:806:127::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Fri, 20 Sep 2024 16:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 16:14:35 +0000
Received: from ssomasek-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 11:14:34 -0500
From: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sreekant.somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: Add SDMA queue quantum support for GFX12
Date: Fri, 20 Sep 2024 12:14:06 -0400
Message-ID: <20240920161406.877600-1-sreekant.somasekharan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: e57af2cf-c294-4640-0514-08dcd98f51d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?73ayCpOPjkbWvEhjnNaDjbweZ+/qhkvziuEzcz/TiMnSCcVaoLWPDgmBZsmm?=
 =?us-ascii?Q?HUzQpLMnsgeGuCGyCcS5YQYhKHiHtK5AayZBAzHxKcJ6L8t/jtytJhsCZNdN?=
 =?us-ascii?Q?xOKpH9dHnLsSg/0VIEk361oFmTrD27+MSoBvwC66RuNQie0KaMzJn+ZIl9Fp?=
 =?us-ascii?Q?KhlM8bRhdj9616fhO06b145fKBKT9wXQHtue8N58u1Qe/K9dKWsvU57hgAyv?=
 =?us-ascii?Q?Edz8RQp8pY0orUlPVI3ZSzRfcojrxKfhyecobd59x1g1grWDH8hT1a5i6vMO?=
 =?us-ascii?Q?XvCBXB8x+j33jyTMihzW7K+ML5ldA5W9PgPC+bNMqniN9tvdCRlVUhvJ26Z4?=
 =?us-ascii?Q?3tqZ57jxYVA9f6h4C2qhXawknT0Pi8NSTSPbUgsIkDVislHgmr+wV2yoNviu?=
 =?us-ascii?Q?8HUIVqXGeyB5mJb7KnOWO8CkqMmDakAHmRCNNbnWTORRU+0dd05CTrqpls1R?=
 =?us-ascii?Q?sLfDnIjL4N2tp56MoKUqJbHKRGfoLF42gQAdFIJKpo4dEQuZGNSBQ11KMK0E?=
 =?us-ascii?Q?jPmyZJShuH62CnG3Ag8H9sycIgPOvAGy2mhcIpsT1/oeomvNGoanEipyJqlK?=
 =?us-ascii?Q?L9LzTVWZOY/2VLokZoFoYVS0liZKR9hxFZ/3xMiNA2vn2WvCDC+jqT3iIhKT?=
 =?us-ascii?Q?o/CfT/K0I3abSnYt34FI79FCsZ7IeksDXK47gLb9qHRflZBO8Q9XGFSCZsm2?=
 =?us-ascii?Q?0MPKNvFcGK9KRwZ9g2OP6+z/i9vNfzj8/VsHVOq+8Pf882NfDpNgVyHmbDx0?=
 =?us-ascii?Q?iZTcAhVug0jeSO9jGg927GMfNA/CdIMc8WYVmEZkE4TlaP9SFTKGidTuqJ8r?=
 =?us-ascii?Q?u2/ZcVf47BynEbHW9SjblBCGqUm7+TW25Tiyj1Vs8VYpVHKiniINHmgHLdz6?=
 =?us-ascii?Q?YE1qadMHxXRGZTCAaSPFrB+Qxi9vNgg+Q9+XLSFtzKw3IAPZQCZ5Rzil4U6J?=
 =?us-ascii?Q?CGkTcv6KY/Iqa06LwZJwPe5dj4fBKFc9tIA9R9bwffjSZ4eELDvfGXIm+CRm?=
 =?us-ascii?Q?4K9CntXZwy07RGkMB1H5AuORKBfs2uHDRuTNQVmyFEO/dmH6vqqa6xgC9WZz?=
 =?us-ascii?Q?RdR/3gYBRksknznarAD2oKSgrCgqEKJa1J/mLJV4atxtG6AXr4EEtcv3YUyc?=
 =?us-ascii?Q?BvnDx8ed2SW44612sC2z3dTevA+58wImWJNYMTkgu59YO6EGtbAQfrHMPwIk?=
 =?us-ascii?Q?flgc6Rqp+9tVvnWbDVOOBew0QJktELPf0mSzMqTO3FdXAHWCd2B3meaGZr1e?=
 =?us-ascii?Q?R1oDnlSiGcGuEmmhFeyUQC/xgweboFbYZCt+M8gPDKYb73pJzsutqRx81Mmh?=
 =?us-ascii?Q?BZNobA7SRMUTjyW6dEVdIuVhVvCdTWvevxB0fCYZvsOyjxYTaRumDQID7vSh?=
 =?us-ascii?Q?+mdXyn0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 16:14:35.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57af2cf-c294-4640-0514-08dcd98f51d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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

program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
quantum in KFD for GFX12.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index d163d92a692f..2b72d5b4949b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -341,6 +341,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdmax_rlcx_doorbell_offset =
 		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
 
+	m->sdmax_rlcx_sched_cntl = (amdgpu_sdma_phase_quantum
+		<< SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+		 & SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 
-- 
2.34.1

