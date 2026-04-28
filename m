Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9CFFF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353C510EAF5;
	Tue, 28 Apr 2026 10:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykckJ8zm";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15F310EAF6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1B1CBseLHgdQ4di1OFsLaLiLpY5l9LMkc7SaJtkWjcS4Uzpq/7JzVBBwU9iWQPwgkU04jJkvMtunajKZZKXd3AA0sYFLCvycqEnvgNTOPqc5q6gjpvY7GoJTZqy3H7010me/QRLOsyycVoriBR1Wpqf/veDEIivLnsHbqB5D1BShq1eB9NggBRXj7ckLviSkvfdLPguuRrjZGvo3mVfl/W9AwGMRvwB/jKc/UhrvUNosSDnpt5JCA67xEPv7YBPLu0/1y9wdDGvDhjMyq+QiCATzEK+W6qRNXKmSv6L8QnUkZ+uFTmPEaIHaGCk5OAmvW5VtM0icsU5kEUOKfHgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=od3+UzOZpZotccgXxQoMCNwn/V4FeTCVOTqsKRiRMHYWU/5pFn+hSaIPwn63PpkaAPLjmZeOvHnGS7E0HPbTZRF+EMLkGYbpsKY9nlhQ/FXuwvKmsUSp+zW7M+/UKd+MThtGAjyy1LWeabEcxv16LhkB4pYPCiSbAI8ZczGB1O+IaqHEXjC1nQXb+pZYSOYdJT8Y0hWryaF2FQ+V9k4YMeXdIaPkd3Zhf0pmNdS8cuIoOuszaUyMrc/5YlDl3tOBcD/gOuY7rpk4YvCOk9KpcYoO7+jpEFo7nFs9KlPxWmg/2A7OwHvTZK4Az0MH4fOsf6WJFn+SapG0Wnup08ZMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=ykckJ8zmueWR2yGw+lz5E5eJuaUm5oZOpPOl8a7wzJWC0WcjPfRyx4z3fn/DsWHJlqGry1rR/2yzbN0YdeJb284pi2HfVC1pHm2x7Hor4ZMV4XFwl+MzTS3gb8+OZnDFD2T3TthcW5GE5ASY2IORP2KQpnSJzkl9Ka//XyGRlN4=
Received: from CY8PR11CA0025.namprd11.prod.outlook.com (2603:10b6:930:4a::19)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 10:03:31 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:930:4a:cafe::7b) by CY8PR11CA0025.outlook.office365.com
 (2603:10b6:930:4a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.27 via Frontend Transport; Tue,
 28 Apr 2026 10:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 05:03:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:21 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 07/11] drm/amdgpu/mes11: plumb unmap_flag_addr +
 NOTIFY_WORK_ON_UNMAPPED_QUEUE
Date: Tue, 28 Apr 2026 17:58:48 +0800
Message-ID: <20260428100239.1609179-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 04083cbc-50e6-493f-05dd-08dea50d66f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XJq5gJHNczZUuFfsSm4RYXWVffe6esTAll61e40KZYrSd25GLAb39toTcH6SQAjeO3S+ayspI59u7lsbZIl0xra0AfckkCUrmC30kWo/EHH0r/F/JakM5tpxFom0tlhI7wP4+xPpZtiD6jvfxMG7ybbjy1yYdAo4WrHJ6fBBHBzoP6NV1laA4DohgoV/6sC1lzifc4OUXTlZcQ2vLJt9+qE/0UUpNeHI46wmCOqJlEuj0QOdJur5zz9tgIBP8Ra+wTr5sKHSnUn7YhYa74+5GxTiPiORrYWmCWsVrPFZ2xDbLiWpkTvRZCnFXSmmGkvOk19DRqHl/VIRTc8Wummak3RCUBjnDuLSWiZ4pd+UXNlrTpLmA+FzTSP13vJf6270Fo54HgpgBPxIwzKnnXCKqhl+0ANkNMNFijQm2YDPTAdPhq4dyVksSnn/dIxVFVNtIyb1QdAix30xMl8d+A4rW+LG8pnMlzkxaO2pNfrd5cvwpQOEF1rjvEucDdlrdoQwW/rlf6ahLx/KaUm5S2hBy4Jgj/zxXMq2xDJAx3Qu/MMBISB13nSJePPx69o9XImxuoXZ5PHElPfWy6I+QgDhVGSGu273Zl1Ao88cq0u1lcSwQMHwjHqYWkQsRbs2rfBNIUhIvEYIbXimWY4yVYPV7EXJBawkXXnLfOr0RUVKPZERgQMBBiSVk0tvMu4ax8gfqPxtF+goBLyM+8HiGOW+jXwNk8gKHjzkXRQpGMYNbLGwxH5uMVzyxVCQWSTow9DPiDbfgLfweOWZStv5nZKKdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r8/XnOD2nmhiU2/otgbwoovOwDSY95bntGFvCDn1sx1pT1zpVUPUw4Q8oenFOsjYXQqSZ48bnybKwWdTfGSWlMHIsP55FmEV9GoNGFDYy5Hmhcy+4OPsb/41PR+H4sxobwTvJnJowuC06ZG0bkELqObF0ZNz6vyQuthSo88eEhXN+m1C2KzY5M15coEKUm0d2VbkrBYBaTW1iVEADmfqWnjnxTlXQ314e+QBd8aEFpk9Fp2WzSV2/Gx3tewX0MJ4vmSoGGDqM5TAIgqMyT9hgJHNG5GGQ13Iz4+dTmu0ZBDbMRgQa7azYbtSVlm9goO7teGX81FTHkroKxfW8vI5QCmvZ/cUb+wp5OzA4H8Yy1CzoezOzCZgtbA1LdAJ/N+eknKFSV4Ht35vqNlRG3yxoYXG0KoJK+1Of8bPD2UxGWfUYxqRbicPuR4SRkwSpC4h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:31.3366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04083cbc-50e6-493f-05dd-08dea50d66f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Pass the new mes_add_queue_input.unmap_flag_addr through to the
MESAPI__ADD_QUEUE packet, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

Note: the MES v11 firmware spec does not (yet) carry a per-queue
is_user_mode_submission bit, so SDMA UMQs on chips with MES v11 may
still see PROTECTED_FENCE-as-queue-done behaviour after the first IB
until firmware adds the bit.  The wakeup mechanism (NOTIFY) is wired
up so that path is ready when firmware lands.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e..575cc4a684b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -362,6 +362,16 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 
 	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
 
+	/*
+	 * unmap_flag_addr is plumbed through but only honoured by MES when
+	 * the global use_add_queue_unmap_flag_addr flag is set in
+	 * SET_HW_RESOURCES.  MES v11 firmware spec does not carry a
+	 * per-queue is_user_mode_submission bit, so SDMA UMQs on chips with
+	 * MES v11 may still see PROTECTED_FENCE-as-queue-done behaviour
+	 * until firmware adds the bit.
+	 */
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
@@ -660,6 +670,10 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
-- 
2.49.0

