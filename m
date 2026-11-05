Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A7606A329
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CYUjJCxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7670910F908;
	Thu,  5 Nov 2026 21:00:47 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B506910F908
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 21:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBOlcTx1OnB4t/n+Dg72gFqAZbwQyxA5lLFqAjd4dxN2wN9JddJM9AXVkEksKaMOLayAt76P9dehlvLZrKYjzhoziL3aZwl0Gd+RdTpwoj2Jn+wZVEsAhtH1WaxgHOlJheTIyOpUlUxM5W6NRGu8X35kCfvykxJXHNspHsfEkhk4aegyvRDeyxOhgWzB8O4SDEXceJ9L9ezgqMIw81zn4FpftnBULHE3dZCXo+Nju1uaDnyPInJpkUi6qpoDSxFdIj4eQJ+OIY1TEcs2zxvgk8RydZ4oPYzxvfR14zYlHqWmePZba8Z6RIGsnlYic7YXsmvT25aK0AYdDyGdKE5RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiB1rCIKiNRXz6nVc3El8C3UYQaFH0M8ffL0OcfjbaM=;
 b=UFliEvWryKZ1PmST7auqwZPvzXuDHo47dCiaXpIppHwgYNdedRobCDHuZB1isIB62bR3gL8zAlt1dEzJPiNh8IBOSh30M89YrMUfOc6TNXdG3FoKrwYtqpmkWNIUukHTFLvNVPgBTqFXUS4WFkLShaPXnQUVuGfgrex+hiRZJNIZl35rShMFb+cILUosxsHZ8Xl/BN94zObYNxi4a6PaDGajqCMh95237tPPzdpXapyEsua/K1Z6zLI/amWPYgyHDfCuePrdB/0aCHxlSZKA+DqmcdivUmsySsMSkKUhkegAkauN9gOqis8B42nR8AeZ5P6Tf1Hl8UUzF3mOwZ/GlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiB1rCIKiNRXz6nVc3El8C3UYQaFH0M8ffL0OcfjbaM=;
 b=CYUjJCxGrX3fTkrfW9HuzJtpKNK+x5QZ7rLTShk/INpJzAft5QQSgiuIJsp5ZJdS+JqWwOhauXxhjBzuVQfMMK//qAgaPXvCq5WJMO+AaIMIgQivbABzbcRptvbxRtmv4YObHe5BklWLrHR0NRSUAX1ykANEIjP0lXoh8kGTwM4=
Received: from CH0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:610:cc::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Thu, 5 Nov
 2026 21:00:37 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::2c) by CH0PR03CA0072.outlook.office365.com
 (2603:10b6:610:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 21:00:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 21:00:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:00:36 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 15:00:36 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vm_pt: free PT on error
Date: Thu, 5 Nov 2026 16:00:20 -0500
Message-ID: <20261105210020.3852328-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105210020.3852328-1-benjamin.cheng@amd.com>
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: adc1425b-892e-47af-bcf4-08df3b7fd7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|11063799006|261028144727099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|56012099006|261022105027099003|261026140227099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: gE++BVrIaLHcsTH1ddzFcBeoSd9Mpy1U6MgxarYW7ixu9Nixh1OM7cs52NdAMBa6gnqNZw4oXy4zlfberjQoFmdeUsnhAsLkICHuH7JWCoPFLCLWQSxYtfMTaG1Nfn0tam4ApYL+KMPkReqy5nGouvB+ShfvCJw4TA8mNUWn7r75jEdDv3BC6xHDDSnZsz7/mwMiMcDtUaqt6F7omancegp3WivQdUJ+Q0pvYXdIIaPYmA+a9k2EYA4dVhQnqAi/uWHA3JJAzIA0A0Dn4e2tbNkI1f/g4TAA4mhGM2Q4VcfeTT05skLBzOU30H63dE2zIe7JTVYlAvarrc3mjKLTc/5kvvUC7qDuvqZg2u+tsUGoQ48NjucBRtcEu+9l4nlZ12rY12n3VlTfz8QTaauZP9hdToHak71fgyMUqunPkXhHu58t8P5JMxECJwNLkPPBE0lwNYh6cOXOisuTLYqeC9sHKbrovnpgEBycFc3xDW78gHOGUZv7KApi4AVsqFJOjE2lW1ZHHeAGXsI5oEMfjY5Ho27x8Nf3uB+hrKm6Y0urNzEn/sdrokUd083YSzkfn8aB7UMY8QaOXQCCTi6CI0PPtdcBaIe4mihasPkVOdgVWnvtXQ56oHRyq7YCXCEb4oaM/bE8cLYFXDwbUc/dIT7QOh4A+SMPAgtVi+5PH1wB1/NCTuFAt2Akyl10S5oKMeAkc5E+N7Sa59Abgy7mjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(11063799006)(261028144727099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(56012099006)(261022105027099003)(261026140227099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EREzD3fG+k5Fc9yBHLZ9Gxntov4bh/JRwAU193uqNNcEbsOnw7uJkiOMbn/17jnZE1kYU1Zwvd4UkBpCNyFTLIl2qqxdUBTGnJs/yKAkdpm5nYZ5WTNQo9YoFk0auSh7ROxoli6d2m8Hd9MfW5jC6ZiEYn/CTIL0bupylrqGzUPDYed6Hw0SJUQqXFc1vzOopiEQMacQLgh2wgY4xNb4kX1FW5US9iD1XaSdM1KY1u+mi/nughFJ7dVTOOk3Sah8oxV8OjDJgIw7kqh/n57Sbiu/nskEjz5lxqcknBiqt/gkHgWsLdqrZyLRONILl0e9YBXS9BiU7xV3Pa/ked+qJFwG1HxManrJMMtZ7+ywuX9J9bmVOhWy5X6LmxnoHZaA2diO6Jc6J32/aXRyY6bpsSp4nZPa4fN2Djcu9SZxM+gnFWGLcaxolv7pw3T+6CaU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:00:37.5738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc1425b-892e-47af-bcf4-08df3b7fd7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

On error the bo would still be attached to the entry, while the bo gets
unref'ed. Later when the VM is torn down the bo would be accessed again
in order to attempt a cleanup, resulting in a use-after-free.

Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..a66aac73e835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -502,6 +502,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 }
 
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -544,8 +546,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
-	if (r)
-		goto error_unpin;
+	if (r) {
+		amdgpu_vm_pt_free(entry);
+		return r;
+	}
 
 	return 0;
 
-- 
2.56.0

