Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A878F43848
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9A210E719;
	Wed, 15 Apr 2026 16:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8PsSoUV";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109E110E71F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlphAN7XU8mB1bi1Y9/TBAHvITo8PhKh1Ri1mgeUQiL1+hnJy9Qx4PtdfKzECdOYxjw8KMatzwpNma8vX2UFLgjS1RvhDkSLs4Dj+gwOQUvM1LZUXSHfYrpOsh36Az+5AOqVWqno8p41VUjqsrRUtruhan0/9Q7gaF3QOrbjOORttgad/P/7+0b/eE+1R5ls+X9YuFXQqqaQIs/FvcSXawNhGEj35ldSUwkymAaw9FJ8ZU+uRu9x39EjSqMwyA2IzH5tWXt0lPU7eX26f/NlSJTHtv0L7YYo6WdZL2ox6gX6r0m4AoPLxZ4p/1/RnGa+3VUgxVk5sMKgmsmlieAyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=TvD9wjQhw7wOF2NjQJ8QGJ9u2KSq7oA7rlb07y7bPBAmHj0bAOqxmkb/mtVdWlkrpfnpTCjHJ9IvQ+GhjGM7IAEA6V6dxbMqwkIowvHidz5oI132VgPyHxkFMWN8VApxO98IYX243i1fRGhZwTncrU2I8EK0o1n6KzJnNqpK+PVGXkV+WqvtN+o/cwTQN1twaCp3kBxPtTi7Isk3KZZJQc84DMiD4QNAEdcRMp8x5p0ViQh+4VQYE7/m4Jx/JS4AABMs4MmxQD5C6h1rJqM69fFzxmlKjLJR6518NNtxic4QIaAcdW3VpHqKVd4hOzSSZeJ+cNpFawU6+l3gKGv7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZfs99XjwTyM4ho/lPfmAuGiM2JTukKyUxbin3otUo=;
 b=g8PsSoUVLJgKmEtek7CPXAxf6IDcP6NBVDonP8DQkfBDuDTYGqau0mprKUEQGDgutWsTy6ybWJXd/WiBG3hApT4AgGrXc4S9jove2T3Bu3SgEyeUsl3lwfS5Br7qnQlFpcjsTI3+MBRMmogtD5XZaePYGVNn9hSwbXjaTycSGxU=
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:49 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::63) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 16:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:46 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 07/10] drm/amdgpu: document WAIT_EVENT condition
 semantics
Date: Wed, 15 Apr 2026 21:37:08 +0530
Message-ID: <20260415160711.261553-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3963488b-f580-4fa0-070f-08de9b09226e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 54M+3NYG5b/kvPmaOP3GsJp/435fSRW9ALL75v3f0BcKvF0TmpCYq3Du4qSLvPiDely941fjI9UfZmrRMN+N/XS6qBa89qNv49uCNPZ6hm9C4Rjj6qUHGkMIW+7kEpLNsn17F1Mw2yFa5PgTBfCVPN3TTetB7g/iOrrrbFhg6TxcE4uvfhUNQipQuVOmcYn4WzcFq+oSUJ28EfGAV1yulS9e0hFosOgfNX3QXrFf/zZhTJ0QpYLvsj+ceXTdcFujMz7plsb4w43owlg6+laO4DYuIOQqfC/xJ6yQFUrWxAd9aP4qeLPC3vvNOdeVkDUjq93iKcZyq+v52E8Vf59GNXKdq2CVv1RD5ZbP5UoXa3OAqVaWfd9d4cdlmTZ43bTb5Jrw7MK7eMOkIp20nbM5L5dJtRIdxeN3CeL7ESSWLNpRv99oGwJOeHUgds3ET6tXWGbq096AHo13Owmsmz7vGm4MAX4clgHSmjtI/6gwbCfemyL67NPWucCfqt4XwECqqyfdA8TWn+vcHjjniALruk6c8lu9ayf9dYBlf7RHq2O+t0vx+CjqCxhYBp+i3WXc98NRNCbuhoZ0ZZwxRxuHpRR6W4H5UNFGs/11jHE6Zgbxkdckz+SvXY4MvKNrHtks/ZlGlhy33mMct9gUo7pavoDCgw3BT3G2ke4BGoMGAZ97AYTfpj80cNWvH/mfShg489YEv09c/vJmJUv7ik3AqG/tISj3niQ8ivD15T4zw6DjRqTQFVeXaccWW9Nm835Yw9CbZNVhfTeiyxFhvoex5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TRuhHwmqJwcY3adKluyd7//BwfS5h3jIAnCgjSb73SWvVeI1GeTidQB2diCq3qrh4X5xkGATWFSVZdVEQCnDhb2kJOM7COLjDgoRh9dFCVouft0gPrark9EY1kxYSXhKHOuEg7UIkVvKbJIDnTl8rk4h4Er+uT48fmyegbBD/TjGLGTJQWcSBfPxsSBNevbSk2XY8utRdU0mhb7T3MPj1EVUDdzkg8oJ0e8shQKF2Ou6gsQeMNkOZZYrleG6tRpZySuTma/oKqApeeHKo4UOpClTgw69uknZduUxE0d5F6wBvEDS35tjVOu+djajTG19veWKpoU31RQIkMxtnvyhC5nXdFPpUCC0WjndgftwCgRrcATLCl7z8Hf1t/2jSpZwRjK1tLJOdJk2zsMkqbj0fu6xK3ONGzQmmlDKe/c1aiFH44qsQ+mjGeLWwP6b+CMU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:46.7423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3963488b-f580-4fa0-070f-08de9b09226e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
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

Document the optional condition semantics of WAIT_EVENT.

When condition fields are provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

Matching records are consumed only on successful completion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index 67de685647c7..3cccc652360f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -45,6 +45,16 @@ struct amdgpu_wait_event_mgr {
 	bool dead;
 };
 
+/*
+ * WAIT_EVENT semantics:
+ *
+ * - WAIT_EVENT matches pending records by event type and optional queue id.
+ * - If cond_op is DRM_AMDGPU_WAIT_COND_NONE, a matching record completes
+ *   the wait immediately.
+ * - If cond_op is set, WAIT_EVENT completes only when both the record
+ *   match and the userspace memory condition pass.
+ * - Matching records are consumed only on successful completion.
+ */
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
-- 
2.34.1

