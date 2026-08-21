Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BB3C5DF8F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 06:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AB210F21F;
	Fri, 21 Aug 2026 06:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wzrsm+G5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1B710F21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh7fkwFpw3jP+zvBjMJlxm1AAqopsBiAl7D2NwHTALWLMUo5CXnZXDsL7n3K2VMM1t9hChPUv04B4kX+YOR+Kg+KP1YhNNSl/B3G6RiKQJJml5ACofzuOVDd6TLvScTS00tbP0L28KE2IT845pxI1FNU/weFx2jjm8r+kb38HU8+eY47B8gPtZehZg+ekS5MRHigBAM6WCTXSNtwrUYR4qo7lPncPkeru3OU7yV7rxYthkCBw10aFkhvpddTUUH6C6KYEo6Hj7S7LFtnDhFI54FG1IuWtoYQJpddn8VkjWMVm9EC/4d9nn+h1YfsRaZHt2EhVh6/LJyfDH6QGVYglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUo6AGHjRhMWTP8WCdx+kWvVAtImluzndcPj7fkjd90=;
 b=BqHRa9wzcM1oMJGzoLghvNrDW+eBIiU/008iXinyNC/MNpQqfQck9kcuMfjj77OFQXOqEzQmDB14u8/1z85IECH8vbyhmw3EWB5JVrl0sohgIiT1sH4enkcj/gjjEdc0+8zVFSwXJQERcFTx48K1Vcww6WA7phzFsKN0K2EE+S5IeRVnjjaqI6O2swAXQsFG894DPQ0UjafQUHoWYJtljub7RTXhKzBRGYetd3tW81baDJgt6ZPTKjh9pvnFtsqFhcMFnRiC3vN6jIHfcZdYf+/Kf9THLfUhokiMz7HwChPV3zKfbNHEfjbagiuUgX74Im9JDOxjgtbYPB0Qb6AXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUo6AGHjRhMWTP8WCdx+kWvVAtImluzndcPj7fkjd90=;
 b=Wzrsm+G5xrznYB9lTsEJGkrZYRjkXalIOQ8FPjNusk0KE5NPACZaI5K6l6GxFKpz3uskKrSuGXuLyNz9KwujnMLAqaNhuzc83hwRkT01SmUb0p8x5B9Utsk/WbvH9hdkMmQobPOiDPwhAZ8Dl0ZBRfbk5v7wfMnbVVnFv0EFptk=
Received: from CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11)
 by DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:03:46 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7d) by CH2PR19CA0001.outlook.office365.com
 (2603:10b6:610:4d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 06:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 06:03:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:46 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:44 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/userq: Add userq invalid VA status report
Date: Fri, 21 Aug 2026 14:03:28 +0800
Message-ID: <20260821060328.461383-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821060328.461383-1-Prike.Liang@amd.com>
References: <20260821060328.461383-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DSVPR12MB999171:EE_
X-MS-Office365-Filtering-Correlation-Id: b77325d3-470d-471f-10a0-08deff49f654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zZ67w063rwC7dBJ4kp6z9qP7NcS1t95lmKrvuDzEF0UMtKhRu1+TyoMs6VLyuOSqFBDzNz6ae00G9uR7PfDQ8HbQJIafTloPTCfWPSxoTGsH5Wq00vaZEItM8sudSExTbNW5Nr0/2vu+LPs3h315EjObUPuVSWhVZPqbTUSh0RR6BCi3VEav8cXjNAuEz2eXZMH07TX16aYaXoxW94CUieZ/4dFjjv5qQBhbr9BKG/w4nloCRUyupkhjV1g1uJsY3Phg3eLCEmPFY91ZHY4HW7Ve52/04Xy1ketFp/d1BbP1NiIUfwu8xKkBJ+LuJYISbvJVA4C6jn8ITa3jHGB1esEJ6+3G4u1dOI23Ef3HnfVw3wpA2Cs3GSvj6U+1GUgZYOBLUvzvOKJyjK/cMqMpV5Uqd8rrVf3njTDhJQ59ti+3hdJ+z3yHfTytzCZjUdFHXJ6QFhRgCYQlZnJa6tlqIpVVvKL8vaWM637V9EtfvmvkjRUa3wdnjl5k4WxUbvg7hKUShqn7HcNJpq1afna5GqUmaS8CfYL1Tqdvn8nsoWG2klXRRCv04dxCgGMj3v00MP141+sbZVFYtaUlChj0P3Cp7Tg7XUeWzR+EHTJoRZMWf1YUK3v42qjX0z3CjuscBzXtXW20mMIDSqkUp3IkNZswyTV5ZmfW0Nbk7usYWOL8vw2wWxQXZlw1C/nRPxNF6zc7HyaLlXJ+z8vsbRokYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +bYiBiBlOL/4lNAXDOqvuh09sKk2B5eIpHElXNpkc1QnUY+YBs2C6XeBAdmg4xUtEAMz9kvzTDi0lxxlJoOarVKnszjmmGkstU+VsBY2ZRJ5pXx2CFeyC6D9XauHcf6fYUyT6MdNEV43bXNUa6NhrIuEsx2k6eQmxkP4iSU45op8J8ht17TuS0CFn6Bm071ZE9k6+JE0OONfM3f3cwG6gWcAF3yGoqzttuvK/OFEk6uoj6yGCpNsOStnwHa4Q+2AONq1f2Ncl1zphbbEQYdE4eF/zIj6B+3Q4iKKh0xruOTwAO4auZEBz3g5K81opBO3RyUb6Y2h2GQjT4w8BN7r8OpVOSNs0is/BGcthzbE3ODERZjwsFc+NNkHMsr/jLjiMHp/Ax2+RVpI02Js4KdfMT9h6yy6G69ZqNCP2Tt42zPzfl/39hmbBPBS1j9QVQcT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:03:46.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77325d3-470d-471f-10a0-08deff49f654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999171
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

Report the userq invalid VA status to the user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 911b4abfd126..82ceb2a0cc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -821,6 +821,8 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	return 0;
-- 
2.34.1

