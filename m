Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405E5CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B519710EC8A;
	Tue, 29 Sep 2026 03:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D00AmssY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5F410EC8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8cCSeusCdHYNByb0fFRvBdp60evfUHXOJdsp7HDKxTzuoynSn9gqUeiT9qxaWBGyY4uBoxVS57lUeWAZ7VB3rxPVC8D6RCKwYKL+T03PadS6ovz98mHGkxH4B8SwmXIU9vAsoWUKt7TFCYY3kqrHPKGnBPPMYxFPfYFHH3IKwGhr99E3a6vTYP8MvYZX4eVBkb1TtVYFIEIAUX0x/j664Cg2+6Syk8gdgRh2u1Mc6vwYCeo143l9v3Gl2caKnWZDDk5LAl/ijo0+oepPhDXwXXCV7EDsVIoNMlNxvGH1x7VOaJB+OA0ItIsEyHZwKD9fteajzcpc/zAI1fEVALx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHCNvFLfZprm+M8+4AlYnpGgMfsbbIKMozVYDaVmRIg=;
 b=nPkiafUwDeEhrUDHks94XMdrWeg3VmosUXAKSoX0RTMcLx/sxJmSQeu9VceJDmC9og3RMooJTQ6tdYzk+Zfwlz34FEfttBFS4hO/MI0UFMm5/dm+UlCXcipJblZ649fGpTxGHSQPeVR1Gy7K847pKzXUYQLJSWh97KrXeZuk7ChYXa2x9WtlvpWmBiCbJOv5mH4OXQfv0VSUJzohhwtSb43VrBb2F32PZhlHzGZ0RVWgVgXdd2zhQW+lNml1rbRRGySDyiNS9V/ajSu+lkM1kwRVms/AKZqKyrxPHXghHLiqU4PMmezYYvO978ZnJTHFGDf5mMzNDANI77c+JOT/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHCNvFLfZprm+M8+4AlYnpGgMfsbbIKMozVYDaVmRIg=;
 b=D00AmssY8G86H4HSHFiXL7qwogA4+82x4OHROdVEkvpPGDTlmTtFFWBPa7Wjb41vsgJQuNJfnNtybAgA/cxzCz0Y0fGRxbT1FcEJT8Ub8MW/+nZGs9/7ZwTwrL/fBF1uig2A1BxTW4ZpLVcyRtuNaqZ/z2EL6Pa1H7v8WTnJSkQ=
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 29 Sep
 2026 03:47:14 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::62) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 03:47:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:05 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 05/14] drm/amdgpu/userq: complete hung queue fences after
 successful removal
Date: Tue, 29 Sep 2026 11:46:41 +0800
Message-ID: <20260929034650.2393125-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8be16e-9eb6-4c0d-489d-08df1ddc5967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: z6EykpNBQILsSt6c/LY0LHY3EgZqdcaycDGZ3znNncSfiE688DWes5ZvubLk7SfqQj+fMwhDs790ZhvWMOTwXflG8U8h9Let/NNvLexaAtd8RadYgmHdhSBk1in9pGcahm7SiM3U+RmevWZBbENWFjjctJRY8QEtuWe3JsG3Tv5PIAS/t0N+NPzJp7DH3TPaPS8KoG/mR9M/CTblwycrTjV5LBteruemIfCSv5AKqYo8q0Xd9IEsJTrFco1putCl9/ZpYToxo/74UmFM2yE7SbrfslsaOe9LWllLjpridp235dKEN8hOKG4FsxThn1r8NtqHxhKj3sWEy0YMgHB2SfyyUSC8rz/IG9YQRsdWtB8D2VbSnpRtisFTsP0JI0SRNyxwzrXTS1RzONCoWqu4LKN86vL7r2g4rjEY5gB2J/REWlfmaejH3EppnVKV+GoIVAGJFdtaMhKnBBII9pyK43wabna7ltxbHnds4lEAR0CmOFQpsF+ZjT0cjjgtXkDBgxBN5ILZLBSqK9yIcNg9rfeEhjNBJU+GNN+rOGlKXQwZX/24JPQ/r05TgmYvMcbipwKmrJdxbvPVGI058YoSjgAFDGtuttSpXIoAlHEYQzJdGgoQ3KtahlOVxBEgbbeJNwVKcWPQp5HZ/u8bSM35ozV9IJIWfr+ge9a56VtNBXwKOzXZP9AtM+BoYwHiycu03pJNewtHxfcWsl9Rxm6MqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KMg661mK9rwK8T1yaXplT6+V8ypu9ckqeyyXlFHzZJNJ5YX0PNywVvsUsBkp4UZLKu9N3UhdacsYDXnzgt/+ykHZdxm7KASv8vdQwNOFF0PwBZI44qSNbLjTgMKiQAQN9FV0OLTbX4ouf0plq9TSw+Lxv/lOUySgyBGW2xMc01kMXTiRJAYDJ6JTrn9ere91raGKht6PMCqCQldg7i7GOGmRIN4ExmO1Li/aMmNAHvOrIOvZ1tV0LRksdg+s6SHvWwg7MXIHeGLrT2UGygj5cuMQV/PMKAwIQD8//lC2hs6PXEGW/JaZ5DlHHwgtD/5cpulWjbv52I7Pivg6Tfx50lHMcS4IF91Vkv9rPDQBVlx1yKWcElsMiQe4VXqw4KB6+nd3NLXLgSBSjY7op1q6ggZUoaPgFB8iFTO/zrMPe86maKlBQ3lZWFOdZN6LOic/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:13.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8be16e-9eb6-4c0d-489d-08df1ddc5967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

Only mark an additional MES queue as hung and complete its fences after
both hardware reset and removal succeed. A failed operation leaves its
dependencies pending for device recovery; it does not prove DMA stopped.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index fe49aa4dc5ff..3b973ea0c24a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -282,7 +282,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 			if (uq == guilty_uq)
 				continue;
 			if (uq->doorbell_index == db) {
-				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				if (use_mmio)
 					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
 				else
@@ -292,8 +291,10 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 				r = mes_userq_unmap(uq);
 				if (r)
 					return r;
+				trace_amdgpu_userq_state_changed(uq, AMDGPU_USERQ_STATE_HUNG);
+				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				amdgpu_userq_fence_driver_force_completion(uq);
-				break;
+				return 0;
 			}
 		}
 	}
-- 
2.34.1

