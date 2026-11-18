Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635F606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lj1icm4z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8769B10FF6B;
	Wed, 18 Nov 2026 18:52:59 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE17110FF68
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNG9RhkSdA2ehjs7pD63Uj2bA1dQg5TVlkBiAAcWV+Q3F1o2U1OnHE6IfawjDRtAiD31+MVYrenbBJT35sOFcrC5qtg7LbfC6LF6W0b9bXgG0yMfn0n4H3xcbNdHPR6Et0wr3zY9gcHVEhBNO/oqBecTnX262X+cSBVVhopaxAN4TrXw5nLgnr1/Gd6myclVDV7XQX+nckgs03GcAwzTnC6LmGwvvajUPNjDVZQTxs5QS9De/mJzXP2UEnivq5GymZiKfIAop1kfGGfJVwK0m9GS/zT9TcmWFrU2hzAGw5wxDoGrUjFg6ktt33+AFJYBJ7/VGug6aZPpKG2IfqJsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az9tSdOTM//dJrd0khcXm2wkE5IBq8Kvy73T11dA7q4=;
 b=sp08THCMV79HsIsRLoIBCg4ay75LT6TEj6+a2H9hdvI7RUJXdZFVjVTF3J1Uj22L0oKv8dt6RLRDZjdYBkyFBNqMc4Y5OHCPkr1dzJD6c5jV3XnviCEJvyJ5WGj7vo7UXgGllieRzsWEJ9W4YnR6xRQM2cwqBkKjWxNBbCRRCGr5KFMyb0crOXB/U38awf/GK2Rm0w3I/34gy2w4MNPyUb9Xa4ppltME2oml4rhg3GnjFhtEmnJvutBkUgIMOHt2gmyZniZqfDec0mzxFFK+KGZCyqM8yzMQSyf8Sp04fpwb2l8Kt3YU9O4j6yq/w9vEqlOd6qwXqkV17g/JETxZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az9tSdOTM//dJrd0khcXm2wkE5IBq8Kvy73T11dA7q4=;
 b=Lj1icm4zgBCB+/mFo8rW0UmxVgjAEl+NEgH+8rwzCS3ZzxxoiJh0CDSmx+qlEFpNxUbRomicciwPXknFFinvOehVs5rlctKby6vzroqaWHlSeYVI+YlHp8G603QA2Rq0pOMvjVXeUD4PEU5FUdQTuBn+mJZ1ccKXzZutMsAMM24=
Received: from CH2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:610:50::20)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:44 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:610:50:cafe::7a) by CH2PR16CA0010.outlook.office365.com
 (2603:10b6:610:50::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 18:52:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:42 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:42 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 6/8] drm/amdgpu/vm: stop using amdgpu_bo_fence
Date: Wed, 18 Nov 2026 13:52:23 -0500
Message-ID: <20261118185225.1857845-7-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 02270ecb-fa83-4d28-d6b9-08df45a5214e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|10067099003|261102123227099003|56012099006|11063799006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2MdmYfluSXk41cS3ac4VzXfC6qIe0vyk7rgVSicUB5SYK82G+dMifb5gr+gpOurW1dloKy386WcoCZq4xXPApAxaup4VoJCd4sdvrcED91BCJyOCWMPqceFNEPg1k5e4EU2KNnsODCeXkWa90GKQXern7581i5yQubJ9nRcY6otjPfI8EBMv4KhcP8TKGUwMCmZQJOgA3PldFCLpVUkhsBgbJoNlbE2s7/b1iZH0aoUpXVpLiL7ZZC9W1vBb2Z202ua7whr/FLSe8ZHehzvoA0Zh7yuwmcUTM0yCUfHGvFt7zEYDQf5mfLMQ+A1zr86l0dV2iwb1L0UhThLqcWaV42iIAkLX+FbbyBXt1dsQVsdee0+TfnrHkGShZ4PvngYjipVpD/QsHjQ4dulRUZG2fmK+zoAw3fJg8fdbo4c9uGhzeJg0Dl8bkn5YXs9uAOyeUY1UTw9PY0hJozmAnXzh+8NgSeK1jGVn/Kbj+xzpMDn6N9OV/OS8/+dx2kiBdK62N9JMSjyrJuXbkF3bKTIVKfFidoKbR1ARa75RihG6rZyPmgVqp7dSbN2wZhNScHTqRfKI/CvA4MrGtzny/VobYC3bRx4uNRhzcqd4500lQNzkh9Re20Fay7GNpctgdkOHHKmlX+jPmo0nCYtzTSsK5RD/jwYN4p8ivTfDgaC5+xOsAwXXjtVcLEquJDLHb/DKdP4MT0CRcjc8PgiAsMpBrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(10067099003)(261102123227099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RIoqih9c6ERwTx26tL4D+FCF8B7O946vO/Yf4Nh1K9Gns+7SE+XStRqZT4b3jFb/sLDq1VzFPqSHqiujHX9RWrNfDA32t+ko6ZOP51Ut/sN5Gkt6RvSkPhsUs9AYl2tO9DeuTDfJUHktjFUu0VNNuBYQH9a8vdjEW3137U6gnuxId+ENUX/jd/3vTs1pBHmX+eqafoCdwfpyDZZeganKi3oC0wGU6aUgoSrUjySzhjxuzeBriicPZSuHZ7giAwBt3PQyApFBJQEX7nAt2xrWgxlWMZhRLsCNJ3SfO6qAyEG9e3MgMw9bLmLta/QZkBgqYZcs2vLDkaZPMFsAOMmVBwQpLeOdU1YaGGk4UYKVwPX/4hbpzTq6U8VMP5iCxnbfIzqAvY30ZuK7wMGMdhUe+lZSlZAndc6AT5lvhH+8l7cOZu9bgt61oU+ov8vg7mFg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:43.9735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02270ecb-fa83-4d28-d6b9-08df45a5214e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

Switch to stop using this deprecated helper.

The original could be incorrect under certain circumstances, since the
amdgpu_bo_fence only reserves one slot, and at the time of calling the
SDMA commit and TLB flush fences were not added yet (the reserve_fences
is not additive). In addition this allows us to switch to use BOOKKEEP
usage.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index daf0e75d0bb1..2a8abc9684b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1216,7 +1216,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
-		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
+				   DMA_RESV_USAGE_BOOKKEEP);
 		swap(vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	}
-- 
2.56.1

