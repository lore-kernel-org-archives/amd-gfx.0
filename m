Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223760A261D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E0tfuIem
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3136410FF99;
	Wed, 18 Nov 2026 19:07:57 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D481F10FF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1neQ876hTDHp7QqgwOPQA4kEzCFq7VOXNxySbiTBVJH8ZH6Fv/PWKWA2wFLGvA/ahRCa3qd1/JqNSAnvSj5L3tecDVzp6g3T80omcBguzsMojxsrjLW+cI1wmZignuDiOMIqwEy0+6xyazJtg+6mNtDEQeRsgmDMBz7IMzlcp9JbvD5ihncuND16/bPVPm6EfW2dkgD8tlp0b0fLj2wUI6upbdrEcRlfDXNp4t33xqgYj13vA7ESszKiYUTfXffgXv/BGYo9yTH5xeGb3+sgS/l6GhBvHgicNNOvz+v4xo4TAHtX8abQTytNkuMcrLnNOEoCkVLltE47kLSgpamIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7ip0jVdVsMHQbd2FmCwkCXgMzPJ7GYDjh+qg5/Tcls=;
 b=LOU6ovvODwp/yvekcsI7Cy6SbUru9sCzLWH6PeXncOqiJNAI0tOop4NneoNBSDwZMJb52QEYeZSsVXaXkfQcpYEvlAffxb9r+yrJ0F+QvrqnJWndgxBr7zv9TEwdmMwFWb4q+JD7m5n0ZpvNKUf+huz/SHETCue1SAQVuKNUJCTqNL+G6FWAX+rzlS2na/7uP+UYc/3fQcpI5vGUNT5UOJKhHZ8ttjDthAH8LtkUdov0akDJj/rYqJBn7VJ9ekJHUVlZWTIlYZpuvkGdRtGtTR1h9gOT6/yiQVRBs5QCWfT+07eb/cG3XrBr/uBuuhkm0NiUCCqoT3nDxj8q0QLqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7ip0jVdVsMHQbd2FmCwkCXgMzPJ7GYDjh+qg5/Tcls=;
 b=E0tfuIem/DUUHCwz7M6jvdyH1ugMWiJGVFfZRJ1ijmjDtaG+gnIkvyNOtNm5TSlBU6gyt1DV+FPIcujz7Xk0kv2FLbcA98d1j9eeMYc/XCaZrl4LaxzA0lWDgc8rhc8mzwWIwuhFXupiZFOgpVvHNzk625HjIkSQz1d8xc4YzRA=
Received: from PH8PR05CA0002.namprd05.prod.outlook.com (2603:10b6:510:2cc::20)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 19:07:40 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::80) by PH8PR05CA0002.outlook.office365.com
 (2603:10b6:510:2cc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Wed,
 18 Nov 2026 19:07:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:39 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:38 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 02/10] drm/amdgpu/gem: reserve fences on the VM root PD
Date: Wed, 18 Nov 2026 14:07:27 -0500
Message-ID: <20261118190735.1863676-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 173ed291-3e3f-46d6-83c0-08df45a73749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oDQzw6D1LlWp6/htjD+IeblfoFF0Xu9rZ/oWz1J/Usp4DF1MfArYAG1/8s454A6/f/rO3MC+uNQi61jU2arO0DW8g+tIVYa+434CmaYKwAIwL5hWms0RXgSIBVx4oK8Bij5WtjzNtBtHlnF5S7E8Ztr7joeuwMoFA8liuMkowDlY0nkDJclaaOLEpfzl6Z/elzRvTxc06rQUoRyMtkUCB/lWnyA8psxUNUCzhBc1zGBMtDQfWOczpca/iGCYnFWRCjiFRsQothEp2iqCnlfXfe7oI6RhZiGM7T/030Mh5y54a8vfO1d48xjNIq0CXx5ixr/nagRBJ9x6YImml9tK+kIGpjqBkT6p0lNhu+nZ6HzPW08d8KT5mZMdHQCcojEogJ5A7xklJXkDZP+vDf3m6sn0tqYlT+LZjJcSrOkShpUBzXFkrhnbbCjxFN5GDgT79I9vhMMA2NvMjcePsB5HLw4l5GYJpzBLjidyD3XbLNDWus3GyWSKAB0WHk/72yDW0rnwexgUtJ3TOwv6OiTEsQJC12KWV0pD9d+k+XoSLL+xnTylxiHziCxSLRenbb98g+PtAx4KgHJvfBRhEd0GC40DcNZ+yFKdY/i+sRiTUdhJR84y1HzSbaKih0tg0ixiUeYlZiSlWCM4Rss8Mxdzi0ymzea4RKbcNwOU8zh0RBqcxx7Edznmdmc8SLxFNthgB28HfPmkRvhZbYFbLTysFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sfy+ONVcNHeaP6DQ7WJKOiFwDJv3JNmiPu0bPli6Awa1r+CxZVWILRWdfbfHI7/7IvHOULXvwZ9g8doipg6STqDG1VDAoudum6vx+A++YEdH/T64hCdLBN4OzPgcoIXD8XK0YncDwxls5XCEmnfQI9cQZsCU0DriTRQaSzbyTAkgmhKNrQDTAbKHnUBzsYtol+IvEBO7MMQDNxBt2/L0NiBcXX6Yf2a0bgRk7cDB75f2y4rYZFX/p7sRJi7TB38qH0yhACNWEEygtP8K2AYg/WKFk7TJPXI/iot5GzBjg/Qi4hT7vz89lhbLW2s0oy0qkjIBkR9m+GNpoxG1SN2d6gY6YJab/QEuOA1taEvi0RhZ5VuKaij4udMERiIW9yAmHKq5nUfORvm7owVrIBKZNQOPh1Bffs5Yq7StffxKP6TldLisNkertvNAWiifMsw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:39.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ed291-3e3f-46d6-83c0-08df45a73749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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

When creating a BO that shares the VM root PD's resv, TTM eviction
fences are added to the resv, and there is another fence added for the
BO clear job.

Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9da7ae6b9ef3..eb7473ed9e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -504,6 +504,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			return r;
 
+		/* ttm_bo_init_reserved() + clear fence */
+		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv,
+					    TTM_NUM_MOVE_FENCES + 1);
+		if (r) {
+			amdgpu_bo_unreserve(vm->root.bo);
+			return r;
+		}
+
 		resv = vm->root.bo->tbo.base.resv;
 	}
 
-- 
2.56.1

