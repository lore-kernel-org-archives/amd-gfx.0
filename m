Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F5606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gOEkONlW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5526D1124D3;
	Thu, 19 Nov 2026 14:41:20 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86891124D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+3k1SjaALao1fRJBUnMxDABSPuBPltfXfIXIINr4aPDZHDeXQ69/uLam6IEsG64dw2hbMPgGJhtCZl3Hl9YqsqBHcAqJe/CKozbp7XnvBAE8Rr2+W4G75MEL4nJel5fcoz9L/XRG1ofBMjwep1S7+QuZBsCvTgL2LavOZoMpoDNmn+2KlZetBtlHgof544loFFytUk7EvRWhG+l3UxD4iqT2BTUejwURvdovKUIHF5edt00e3YqOBPPQLCf6ldtLZMYOFgra9FmnBgbPu94Ze2IdlTntovdISMYviAKJxpv3mncQm0QtFejm+M7GC7+ijcZXb3H+IXX+qKql1uvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGpxUNzjMJSnwJjr8oXGLwxzUGlk7JoBUfyy3RwalOE=;
 b=r06618TnqOHXIr8yM+dEsBSnFaG1ybr0Vo0A3bS6eug6Tq35mhdpWrcVKqLpraegO3HYtidOx6fwL/uwbjFXMBUFvHZQoYbuMe+camrCiF5rDRWtmNRtwe3UhLLannpw9U1mRt1YuXFZWWyytjQ07XZnIt+dY7n79wmztroKfA6bu8YstmQDfcKL2BZIu2IphaWGgC3w2mEB+YjvNRLLAKDJdIdLySvYosZ8bWjIh6KFEP3FIpJ7Dw9JTL6LasGYBoh8pmXiS90ZTkaQSwmkrnVYSCehiMXbKBk40yofDfVqBQpky+GVKezaYlEbqTkILk8UpbI2zcTxpIQzmLV/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGpxUNzjMJSnwJjr8oXGLwxzUGlk7JoBUfyy3RwalOE=;
 b=gOEkONlWBDZ+5Xi+f1QNDhxGHA/MZzBp9+IX3hRgAKTE2+ucdq0PO88gb4jFdHv7b3Py+vf3sZeNSYAEu4LeAlK6wrvbGF2NcRgCugnqOSFRzxGnYuwfDeVyJBPvf/DTR+XBnKKhaAXgBOkRrZu6vMeBe33geEgSx1xmzJwi5VQ=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by DS6PR12MB626099.namprd12.prod.outlook.com (2603:10b6:8:4c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 14:41:06 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::87) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 14:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:41:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:41:01 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:41:01 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 3/7] drm/amdgpu/vm: reserve TTM_NUM_MOVE_FENCES in
 amdgpu_vm_lock_pd
Date: Thu, 19 Nov 2026 09:40:45 -0500
Message-ID: <20261119144049.2057674-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS6PR12MB626099:EE_
X-MS-Office365-Filtering-Correlation-Id: b97205c1-28bd-45f4-2e4b-08df464b23db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fLBq53i+1DpHsGg/s7CIeNffA8KexEEAW/qojs1tL9VX/jkGp92YS5iISAy13s6miXjjNk5ChzU8btKKkDWImAnwDRPtCZY67w7avUoxP/mBj5QJKZOBcpITPsXMdKCh+HdvaIFVfa9YN1Py3IdYfQ5v0MyKiJSMYthh67/uHX++DCLRqAR/IwWlMSChf9iX54VocdpWrQ+M13V87ac0duOXERKJb92K1bI+lHG1bdURko8bTWhqu5ngQ83s7R0xCJghTO4l4XuG9ffkUv1UR0yDfH0D19cG+8P8/vpvfmzvw+IT6LjaFcnOA8wimbAU5RTsA6kklQ4/G2/3fVD4Ayn5efAFYkaA/2CjFi68rc6PJ8zyaFV4xUkUDLdZ0VWfeVhQ/N3gsioyF0UtscK22q5ZsmQIonoKEWTgLdPWiFVYUcd1DQccbDWQX0u5d7Y7yblLu8SZBlU/WsIpSlOd0IQnbozArLwkjkohzkYZCR/4HjdAk2lOOkorE4IRkH8b7XL5q+IcGyyuKeg6gOqGtotbO2fsvEEkzUctkBVqp0rpSQ8nRREMrrvtjSs8CN1PHLsk2QJ7iYuypotwqO5aL6AD7t+3VxgXEzk7X6/XfYeIxjX1JBaMPDlWgohbVxEyhXQUMjQJrOkdI+f0L4NbFqMI+UskRuXKHUIFVthqa0ftaul0WSZA80ipgZIzV5I2YKkXsXB04cTa4HgVi/hHDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ilMbxirTECoVeo/ny86oMKAgKOSd5jlKnLdSr2QsHcFNpHzgFOFJZC9kesQge+/Ia8VxZ96AZk85SxuyfojFhugVIF/9FHVuz2bGKzQHuJWv9CTZsnLkF/FNGn+c7xSzrLqPgYgobSt727KdlZLibns5IEg1xOrhrABHaIGpBI1+KqPgiet7/rYk3egnQe8z3vY5S4IyAIi+NrEsLYdrROG2yfIt4DRTFJTgj0ZI2Vr37ZfRMWd/mmMr+kvuwpiHFXNSqYBD0TR2A8917D83AcA9Z42ZBW2NyihFe+6J03VY6CZCsbqkd7nVIcYM5VYNepKugPQ4oKb6NcamtJUQbchkeCrS9FYX8G2/QXkdYOS9k1miJ8tBtAS7LLy7eECwDe6tq107hrZabFuUBKBR+X3ImKCRqs2C1DKe7hWhnMkTLarZrPm/Wdkx8tds1c9t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:41:04.6671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97205c1-28bd-45f4-2e4b-08df464b23db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB626099
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

Page table updates may result in PT/PD allocation, which can add up to
TTM_NUM_MOVE_FENCES to the resv.

Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
v3:
(Christian)
- Don't introduce AMDGPU_VM_UPDATE_FENCES
- Use 2 instead of 3 here since last_unlocked and SDMA commit are from
  the same entity
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8cc5964f29c0..4d31c41fb684 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -464,7 +464,7 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 {
 	/* We need at least two fences for the VM PD/PT updates */
 	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
-				    2 + num_fences);
+				    2 + TTM_NUM_MOVE_FENCES + num_fences);
 }
 
 /**
-- 
2.56.1

