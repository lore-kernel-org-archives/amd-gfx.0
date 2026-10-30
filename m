Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9377C606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ijQKP+Bn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2B5112650;
	Fri, 30 Oct 2026 06:31:43 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6175112650
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8WWaJKTmROTfrHzMoLo05MlTpm2JLbFygk9WSdAun7ApOPDpAUSxl8x7FIGmsKeBjYw0N8GJV1H39z8TWdIFVISvLnetEQiRJJPCDjD4lZOvuaYzRXFip0VXhwpLWK842GpSzHnBWhkKyRnGz9wWPdkbJ8qzeQ+2/vka4hWOOsoX/s62DLShBDmRpePKlMTR6e2DlpXDqsR13JslQZ54eAY0W0eu8dMHSmx/bjlqeWwKkKLdIJ+fAHWc5y1ya8WYIz5XvpgTFgEeKLb6+qTbq9jGcT2BFcv22/eSl0Mf58M4q1xDiybcWwtmoN69xEmeLrK+zKU37nudw9TE/bevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YcIAlqX4zGz5CDL+8+yLlwPDmggAmkML911jsgWkko=;
 b=rtSChgrX2t+tDyJXPl1l2HTpee1Y8BQ49PGRvuT/EaGmKYBhwOc9r3RVGe9wZDHfw0QrnRCO9Y2DDkg9rwxLnMUJYxm1ixV/byQDH7lJm1l7BcOSpWqBx72xAXwz60Dq861LHVgrVujB+y8p7PtWcEzj60jacDXugAceErNiyPvpGbLqe7ljIbgaciv8U0iqjvRdX72YNXxivIe2ii4ajyZNNYRJ5OzeSssaiOGL1Hh2Z+cMdme6GzQgVrPKcl5qM7IZzOTsI3WPgVkVwd/eQ61L7pTWaOfitrL2b7FNhHqP6cOlk6Y10wHm7pVFe3UMdzFN5EexHe/c31XyJzZcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YcIAlqX4zGz5CDL+8+yLlwPDmggAmkML911jsgWkko=;
 b=ijQKP+BnbrZCMiQIdUeORq/OJTUGl/ohBhUfe0ZdMCGaB8x7o/EqJ+AuzK2j45Y3L8OzJmXpQX095u5cRXHQgQEfRRkPAJMpT0b82bwCa9qTZxfe9RV2Oyswb4v86dTx3DSMRvQ1b8n4dqjRp/MKyQJJ4jIV97WRJ0OUoXleHyE=
Received: from MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:31:29 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::43) by MW4PR04CA0123.outlook.office365.com
 (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 06:31:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:28 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:26 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 13/13] drm/amdgpu: set userq perf state before
 publish it
Date: Fri, 30 Oct 2026 14:31:41 +0800
Message-ID: <20261030063141.2773032-14-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 43628500-e6ec-4a9b-1004-08df364f6e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ktoMF5f6EfKxxDvmQkdY7a/hQpgXSKcoJ3/XSpQ9m2GzeWz+yJwt3Ra9/6eXTHy3P6s2eCOmZD1Gx1WOgl1pna64HLRNcBt7TC808Qb/gyh0jFV40IAZhMYXUMNIJ1mdjg1P2k3CLluqXOev8vWo0mlHZ7d4Dfm2wKhAd3bOvwNW/K3zacfrunE8HCe0TzjkFbOTln566Nf0DorO4UuFWbc8IFPtkHRVhBdZN2EMe2oRkggX8gQWaREg5POT0/oSmBbq8BMQCpl65Ih01OBiBqP24U2PihYwTGTeLsGyqQRWeE2/MNLX08gd7ZgUzMTQHRNelCfyRbYEeT1ZR6xQvfmVaoOyER0vfSKcEQHLqSlXHcUmn/mf9JJfx0nvIrfmOaFM4fkXikwZwYzBSoBt6DX/p4s3C5CTA2N+D+YH2YyHr1o7+nxErr+HB9FY/qvRLOykbfb862Lcm02HpHYW8i2kq26HSGPib7tPgID+r4tNvzhD0D2ZxH7wY5YKryUwXHDTl5ByKiV52re0X9ydI3JBUgbUWq7qJpnaD4NWkE4rFC81S/USH9+MhTXsNVUV6l1NYiLaFs31V+kQka5tpU1OjRCd48p+VfZ+vJruEUx8fFr/dpXBWR1wng5U8v2Ma/wtinVgDhCd06uRK37ISYOLGumCZl+xR43OPlhXr1iEEp4Vr5EUUjl1Pq9IAnALHrY/NJOh7GmyfmmlBqN1Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VI7nFwQUZV0Sst2ZsdrnBgYxUlSDvWorKlFZznNZkQ7t0HWxV5sOr4Hl690/hOd1m50xBIfPicvIUJUcxb2Ak7/e9uAD+VoIPjqveV8la6hhmEpKdyvlmgMNU1bMRuvPeRpfU5k51JsVWGM4Z07eyKML2u6l+jEkJtie5MUw3hYFMsV5FwTO8aNjGC+4JZND14t1GTqiKPw/GsEavhDrLmluREfECpznxE1xp95T3oqvfCtqWOZ4dOpK3W//0QvCM0C8W/2thO+56NkFe9WDUdBi/nwBFamfXNttLOCv1sBb7x46eXbeYbG3qafqzqeWoeC4/9pwZraE7Gmi5QFjSjtq0Rs3SGGN8yZM85kfbTlG4nxdnFiLKTkI2+k68+ql+pvR1zeQbBRPIVzfmy1b8tHUnfUYdgHVT13TYKBXM+t7Yd+5bc+pG4weR2XcLGA0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:28.7373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43628500-e6ec-4a9b-1004-08df364f6e25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit sets the perf state of a user queue
before publish it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b4a2164068e3..140f1bbbc39f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -686,6 +686,33 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+static int amdgpu_userq_attach(struct amdgpu_device *adev,
+			       struct amdgpu_usermode_queue *queue,
+			       u64 index)
+{
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r = 0;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.enable &&
+	    queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		queue->userq_prop->perfcount_enable = true;
+		r = mqd_funcs->init_mqd(adev, queue->mqd.cpu_ptr,
+					queue->userq_prop);
+	}
+
+	if (r)
+		drm_dbg_driver(adev_to_drm(adev), "Failed to init mqd for user queue %llu\n", index);
+	else
+		r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
+				  GFP_KERNEL);
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return r;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -785,8 +812,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	/* Update VM owner at userq submit-time for page-fault attribution. */
 	amdgpu_vm_set_task_info(&fpriv->vm);
 
-	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
-			  GFP_KERNEL);
+	r = amdgpu_userq_attach(adev, queue, index);
 	if (r)
 		goto clean_mqd;
 
-- 
2.53.0

