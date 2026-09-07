Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3357DC79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 08:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6E210E6FC;
	Mon,  7 Sep 2026 08:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iRz5J12y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C4410E6F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 08:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKzizbcIW6ITvuVMgfotA+BX8xbe9kt68xQd9xhIS1moykvmyc8bYOwlxgE2mDSXMtJQxFIXOyiBfsbsa+UXq4pIdueJyZJz4c7n6klKQbYO7gp6+K+kizucSRB4htRN1GJFw7YX9ie72WdBYAmBBIqYCmgDFeQspR1cPEcUqaa0cCgYAIFPQAZ88JT6uFXCPgKIKeSiTPtEE/RnYIo9Njr3NBBqeHQVjqgGder2F6jU4ppm9aSy81RGw5ScQX3IflrXo/+mWWLwTe2H1DppeHKO6wImufkb4NrRClgDA2wklwAy4QbqPQop8FJubVrWdueNQuErcYuOE1AEo/uEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXsMQd+YvxmPw936jMOcTtfFlshSA19LTq52Dc5gupk=;
 b=fdbi9UXT+MjDWQ6QpF8GPTuus+JuZDfxDLrIzgSMfqcFKJeZ5YjuweLLUdLq8fNtXR2jbiu/aLIfIWRr6Ql36UkgX80G2f893MYHHxZgWwRzibYcy2tkFntUcj9ujzc9cD6fNjmaebvwTxeoCqM7EdOG0lQ/7N7ZqlKnk0BfrQj+gKsu1Z7Pp0TRhjpgXZj8UoJZN53GQZ9azCmwUIEIXKi5Vk2Nt7Jprb6//RbnN8+tuuQXQ9MhcmzhHadiC6GvOK8IWA6Tu3TakGAXMnwkg50ivBralBmkCdjKboo/R9vMB1U+rpp6OHF5cN9LBr7LlRErK/RloElpD94k6z9qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXsMQd+YvxmPw936jMOcTtfFlshSA19LTq52Dc5gupk=;
 b=iRz5J12ywLeEUmbIK8YuU74YPqZF3QoFOIAmNwdBRqDNhbEVJNrcYsK0LNIBtScnDOozL+XZdQgwnJC1cn86moGlZZv9zz8Ggroz53QDetF4dbjET3IdiIkaqD3wJhlWHULv+prGfNs30o5TW390nnjrwkmRIso9Gfk2nQyHbO0=
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:47:41 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::33) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 08:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:47:41 +0000
Received: from amd-X570.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 03:47:37 -0500
From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <sukhatri@amd.com>, Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix userq_signal_ioctl stuck in
 drm_exec_until_all_locked()
Date: Mon, 7 Sep 2026 14:17:19 +0530
Message-ID: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 52975d6a-baf9-427e-a1a4-08df0cbcad56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|6133799003|56012099006|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: eo09R8t66+H+a9w8VP2c/Yn5kuK7lcWPNiiR90iNet9amd+Tb/KCDAJaNl3SWEbwwa5/YHkduZusw8Uwn8n2g7l0uaRmF0KgOep0ppNNTP5uj5Zs4T7W9JpTLiQlDqhbFPbswC69zKLU37d47dL+qJsr4LuWfQNcpXZA7cLkJd4LsQrtYJm53CgOfHz528OM8rR0MuiHS+41U+D9ZKci//SdpjyyGdFOm1STKC0RWwT4665QmLJDssGnmo3jIW7PD7n9/qp4Kc8oDjKRMQ5W0L3Emib9eGRRo3Cu88FUq71Jl5So0QCGyFKkXJ9QjqLamZ9fmzYr+O9ztPP7jWxke1Gka41fVroWTKZVqrW5sn5vu7MS+RykqAWq7ly1SIK/L0R//B/mZrcee8HtWk6n7SdDmYw6Q1WTzAMaFj7CfNQjIWy2pgkKwbmjaRWo9Q+NKsLe8kcpMrFVm4QV4rWPEk1GQfhqNTCwezmNel6aNFgWV9su/BvYEnIqKja67WO5KlEuoF2Tb7nAVqSBbrPinnDMZdypGV8cAYvm2guyKSEPuOJJNG7MTNlPSQdwbSVC47KKrB6dnBF+27uWXaDK/EPozl++SUNehji6pgxWK6QdYO7wa4HpbM86wF+eiEPdP5bD3qUYkZOHUsnV21vWnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(6133799003)(56012099006)(18002099003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m5MuhfoiVSMDC0qxkOYKqRe4ax4V8rw34lPgs8dNOV4ST9iinXnxApfhsJtOWKTWH5IXzMbs30dpxsoVR04A4Hxn3vVWuWZJf7kU3mUieh3VIRsbzBtEtu/G/t6u7sITcZ3p6G2LRkZ5RjGYvw9HpchBBmAMRaKM/IwsdYjqToG9r9QKCYF327GXrVkHsCVBu7c/zRr+zFk7ycGMYE0dMVsLwb2kBJZURJZ21Duav0dC66CaHM60PG+IT3cI/YQpeAQy22B5UTpr3MDFfOqq+UmpXmgy194LjyMm/quXLCpPTWeoiv8ROJK2euq/OCkrj8HQCdqonioLUOEdX9XFJ49yRInYllLDhuX6VuF5XduS5YM7+HpPluJ/NjTTWwPg2ztM5GyVj2mBGDt6Uy5JUirT/ste8xSsAUv4TfOTHlaIu7fue9YF9w2bEqulXD92
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:47:41.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52975d6a-baf9-427e-a1a4-08df0cbcad56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

If in userq_signal_ioctl only bo_write_handles is passed and
num_bo_read_handles is zero then if there is contention the code is stuck
in drm_exec_until_all_locked()

This happens because read bo's are handled first and then write bo's in
drm_exec_until_all_locked loop. When there is contention in one of the
write bo, exec->contended bo is set and the loop is retried, but
read bo is zero, still drm_exec_retry_on_contention() macro for read bo
is executed without drm_exec_lock_contended() getting executed.
drm_exec_retry_on_contention will keep going to beginning of the loop
causing infinite loop.

Fix this by only locking and reserving fence for bo only if there are
bo passed userq_signal_ioctl.

Observed this issue when testing with MR
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c270635c9..135e77837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		      (num_read_bo_handles + num_write_bo_handles));
 
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read,
-					   num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r)
-			goto exec_fini;
+		if (num_read_bo_handles) {
+			r = drm_exec_prepare_array(&exec, gobj_read,
+						   num_read_bo_handles, 1);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto exec_fini;
+		}
 
-		r = drm_exec_prepare_array(&exec, gobj_write,
-					   num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r)
-			goto exec_fini;
+		if (num_write_bo_handles) {
+			r = drm_exec_prepare_array(&exec, gobj_write,
+						   num_write_bo_handles, 1);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto exec_fini;
+		}
 	}
 
 	/* And publish the new fence in the BOs and syncobj */
-- 
2.43.0

