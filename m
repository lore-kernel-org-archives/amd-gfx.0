Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F239DCD98D6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B14710F28C;
	Fri, 12 Jun 2026 06:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+vQHKWK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3007810F28C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GheIFtvocV8ieuEf4HQ/5HBvGKtrh6kKSjM3zdz0aN4HlY6iDlW2jRpyJHJsaKZ7rutUgt3Nw1+VHsFOEn31yOZ9QTPCN+34ip3hR3c/Npna2cbxWvAaV1oYQ0W+fqcAK8QYH7AJqc2EhrJoog6KTzxfQmefRqHWRuVcCV7/pyS9jRl15qkE61iSBczOUHLWVtA8bEPiG4sYkr699SR7K/qTO9LtgzswEdOg4cpNJUJfJ4AYb1RaYZbAksJ05xXQcd3sbAFV2AlcLhW2z1MHmbo56yHAgcH6C6EuIOr6ui+ctp6OWx5H+Ugs6A0NxmRcAl+/dgm/8dF4Qlx+ev4r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5b7J1Kl4QhGQb0Gvpyh5W7ArJkktXd14yxBPN39/8g=;
 b=QFWSp4Ya+/QwIK1ofUSZ8pcCK2JnNTDIty/fHl6A531prFw/QXauqmx2pBc4fer1B4+QHWNgsnwsEnIVTSojNKF2W9Bt58Cv3ilUx5JNCOs5kTz5+ne3/xNjXiFs5hxTXaKhMCbMElJoatuqXpq/LcCuiz1TnwTLpepJMRX58zIP7KyUnSdV+gzOT3C9NtbqGua5MqPPj7bhCJMx81ZSeAQsl3/EN/yNcegAaGPKhgVmhdMho8B5fZvXKtoNz74iyzGJThsvbT+7Ec/sBsjW6G56pk0xQ22ub1o9oY7QM3rSzc1jWZx8HTVrxltOEeUSTskqJUeI5nHoxT8v5WZdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5b7J1Kl4QhGQb0Gvpyh5W7ArJkktXd14yxBPN39/8g=;
 b=B+vQHKWKzGxRWbFcVN7pU3KrFFhci4v8G3FHFBW+wvdPT5cEzW8HDReV8iGJuGACBvgWuZqWvRHgDJFmgD9XtH1A8LaatGsG+f+PuROn5w3Ykh2I4jmu4aS26BWMuBueBNNpHY4kQCiV3rl+5LRVPfeURsEZL+NeJkmeG3Y4kgs=
Received: from CH0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:33::25)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 06:42:34 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::7d) by CH0PR08CA0020.outlook.office365.com
 (2603:10b6:610:33::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 06:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 06:42:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 01:42:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: set the userq xcp_id
Date: Fri, 12 Jun 2026 14:42:21 +0800
Message-ID: <20260612064223.196556-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e77af10-aa51-49ca-9bad-08dec84dc8dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: EJAMmjLPug6L4ShbsYENk/lNZthRRDokhP7m1Naxh91XkrFsBDcNsIOVi4n9msmfe+4T6Zi+CLklwzHfKm95qorBDA1+ywassPU44zVKSAg/5wc54a3r5jHclYCbfn/CBh6OuQOZYqYKRpkNzfZTlXaR+rS7Ry5A+Quaa9RgIOIRIbAC+J+YxHjyTE9EzMoumVMi5FKiYpAa+NfcW4OrmOP3ZOVJ5Sxpfl0AvQUZC3SRoMOaqpT8bJ3G5QJ3OzQlsk1UgaOm1R7pjg6SR2r/S6SdU2VaOzYQYvOlPURO5NgLVA4sPgjs6IcJbdCxIa9GL+DB1bWhdYcLuemOZpm3FmSIeX/o1TdGDAf05n3uWwBHHTFe1Dlnwvnf1rXo6afqF2F5MwJceJW6P8Eeshk0ZOtcfB545gxARoG5TsUuyZNtSZPpAKql1XIfua/tLxSo0L6+e9HJzQ6CaVxH3XWNCXouSu83y2mTUoHn6HPG+HdLFO44l4+eeRIsAOYN/x0Uq2ZB0vo7uE/wRfMUDvtEfud9JJG4tx+J9MqA+LcQR2cVySmCy3y+F+YoJOZC7BgrqXC9CbF4GOeImO5mKfp0bzOVxE+CrCAGh0vG1QVOkZw/t5fQC5+k44MDVAf2uPGX+anIh+NkmCZrdgltsezUrzQDCT3jJyT/oYlHq2ewuqcgtJosx2D+Nsjc+UMK4AJepsssLFJZiuo24y0NZQLPf6A4c9JZQoctkHtnz/hnaY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vWYh8akhVhPUFajZTod3VXxLrTCKIA/5pODNwABIX1dF97BOui/8Bv4Qo+l+E4q1k+AaWA+YG4QF68izuBhHUKMH6DnzpZHEes8p1EYZ1dltVdugJ7pQ8MxYF2onvfoOO+BYJYx/7xnYM4CbQCZvxDEkgHg9RHERlZSdO/ssIlum3shsZrBvbNYkrSOx7ME8XxOBiSJF+5AOb+oGOdXSeywhXXDdqxwLuUxGG/5hTQaUuXB1jTHsBxgqv13eniLbp5TIAmG+yPxz13G5AGPz+l2yNtRzQPzepG3VrJHPpNjcTlItdnl2Nf+mofoUK4OVKBIevHAlaV/u0Y0fZFk8qlKdZrYwiKrSrSPttsQFTIzgpRKEDSCkxdSuYj8PmsOyvinc7IBi4GbUM+f332Nw/Amveo5iksHqZ7vGrwCUodZZ2OBslBXgJWPBGBj73BQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:42:34.0824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e77af10-aa51-49ca-9bad-08dec84dc8dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
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

Initialize the userq xcp_id.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3d6b1cfeca24..e87a3d83dd3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -629,6 +629,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
+				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
-- 
2.34.1

