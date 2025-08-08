Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D93CC87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290E410E4C8;
	Fri,  8 Aug 2025 06:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcU+dNbN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC1310E4C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRfv8VA+w8y7KHggimCG2REMeuNxQAFRWX24YmlFoZyLOipIwmR5jkYPF0OnbqNfTdptmwyrI5ivFco3wokD1mx4QzjBAw2EGZXk4zl+qsJSqGKR/CmRvSCLbegzNkNT+iVuUVGR2NTBc8yHSN70L1Pc70R1mCgPQx7KmdpSTCW2ux4RteBvTHMdGWc4+6qOPqUCA6Fc7wdKQCF92ksoiIQBeKsjQNM/DeQfoLRHD0DrxR2ObbKm/nb94gxpYHZUJfTzO8HlfUpnMmExKExY3t+OtjEpkJYh07IovOHrsrQUi3EH4ivxzzIw3MEeQlZDoO7HmsluJyhGJL67Bu4yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dgpEyD4ckuGtKG5fxwx10L+Lh5K4EmvPBH4HnBytqQ=;
 b=yg1OcEQ467ySe90Zfwlcr2KZpbhnZfNCh6rJYywMdwp13Z71U9k3tDI7fDXu4uFc7m9lAJlLEu3wqhTme7mK+ZT3BJ4ODJOM6o5L9PC/kNghTbnlKSwcR0M5Ac6mqsdG/t9m/ajf4mtFirc6EPypZvyVDzOWpLB0v27O87QPeAtnrGy0CkuA53VKZsGdVC+3j2peJVauGLbhf15SwklzTMytR8IYQSnbpEMWUi2E389GgTc+r7aEkPslrK8ZlLnGM5TIBlcR15JqsEjYEyWcIsTf1rNDALKL0XFwYId8k3R3M1ogUpp95yM2/GXk/YnPwdPSuAu6Mq2xvh5ilhOArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dgpEyD4ckuGtKG5fxwx10L+Lh5K4EmvPBH4HnBytqQ=;
 b=IcU+dNbNbtGKU97Rziw2MmOJ+CeMfpjOHKZA/HzjTScNFba/2FZfysowCQb6U1tD/YblwDzy/irs6n3vXT0i6jkxZ8h/h/2g9mDaokbW8qvMKyRLniPz+O8fRAgBvBZZsooQvFWj4ipcBwbYnhxluxMkqT/eRsnBxi+WySBVj74=
Received: from SJ0PR03CA0154.namprd03.prod.outlook.com (2603:10b6:a03:338::9)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 06:29:49 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::e1) by SJ0PR03CA0154.outlook.office365.com
 (2603:10b6:a03:338::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Fri,
 8 Aug 2025 06:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v8 13/14] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Fri, 8 Aug 2025 14:29:09 +0800
Message-ID: <20250808062910.1613453-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e2ec0f-e70f-41aa-ac9b-08ddd644f9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVkyWTVPaWVZcmhlRG91UUVjZHczUHg5d3VGNVJCSkRmQk8vb0kwVFZRV3hm?=
 =?utf-8?B?ZlNrdS9BdUpVV1FVcmNuY1YrTkMyWjFRNG9EVVZVQXZxazg5NkQyTHhYU3lk?=
 =?utf-8?B?Z3JLZnB4N0k5UmhZNXR5NVQ0ZDhjWkJ2K2dmdEJUWE9QSjBFbjVsYlE5TzZG?=
 =?utf-8?B?WFZiS08yc0lZaTlXNmJkMlI4eFNPYU51MmFQZGU1RGJGY3ZONFZYb2NDYTB0?=
 =?utf-8?B?TVBBdXRGbkdxTjhuWEY5M1MvNklEU0F5TmhTcUtOdEVCOUt4VkNweFphTnlZ?=
 =?utf-8?B?ZDh6NnlzaHljN3hxNkVPUEZxM2dmbXpMb3k4blZSNk5tZjBpM2FEczdwODQx?=
 =?utf-8?B?dEtncExtanRjWDlEVWgzY0FxeFBVRHU5ZVcvVXlsSWVVcVhSSGhINld4NTFl?=
 =?utf-8?B?a0FmVmEwcWxrL1cyemZoZSt2M3d0Zmt3cytoL2ZrdUkwT2U3a2JBb3ZXb2lu?=
 =?utf-8?B?dlFaR1QydktJQUU2Y0oxRndBVTUxZW10eVBBaktWN2R3TmUrNjZkUzRFMGJk?=
 =?utf-8?B?clo4QmZQKzF4U1ZqUFBkRkROejF5aGxoc09MdWFIdDZLVXYyYlBpMGZQVUVx?=
 =?utf-8?B?b2VCVnoyaTdzekNORFk1dUF0d3M0UTRBSHhBNTVLQ1hYNHZrTGdzSGJnNmd0?=
 =?utf-8?B?V0FETHNpY3Mrd2xPS2FnWitxTmlMLzc2WkdiaEh3VUU3MGY4MFM4eCtKUUVS?=
 =?utf-8?B?UXU1ZXlPb3B5RXRPMGRoemdIc3A3UDhmcXVvZ2NQbzFqTGU2d0NyMkl2Nk5C?=
 =?utf-8?B?NGJXZnhHeGxvQ1VlUXhDN0c4YU0zVFNiTFg2MmhMbzhRT1Y2ZGhHaHUyTFl6?=
 =?utf-8?B?Q0tWQVMzSWpQcVRNM2prVWMvN2dWZ0NqaVhBa0ZiTElOeVFiY3Y3MHIvL0pT?=
 =?utf-8?B?YlZQZDQ2MFhvZTJtMGo2V0hnemJqMVdjNFVsL0VoODYzYVJKcTh6aVhVZ3NP?=
 =?utf-8?B?VFVaV292a0tocFJTb3QzSHNkUFVaVUFDQlRIbjNJcXFCbEs5RkZUa0FPai9X?=
 =?utf-8?B?cTV0aTN5SlJiN3E1UTVZaklaZ1ptSmRKUTJZamRZMGVTWFQ0eGlPSkZQbGpQ?=
 =?utf-8?B?RTMyMFBNRnVRZXVuc3FLdVN3Ry8wSkN0d0oxUjFRTms4NFM4ZTV5NlRhOFdH?=
 =?utf-8?B?WFFKVkladDE0VXJ3UllJQ00vekM1SFMzUVN1WVUzbVlVUFRacUN3eHNGSE9I?=
 =?utf-8?B?OUxhV1VOYkFISFpMM29qeE44MlltSisveE5hZ3NiNE5zeEN2amlWeUwwRWxo?=
 =?utf-8?B?YkhGUm91YlRtSTBsb3BvVGxOSkhKRXZqYWZaN01JUTJVQU5qQWVwbDlkd2J1?=
 =?utf-8?B?blllLzhEZllOdjlkZEliWjNMTnNzaFhhRlFzSUc3cERWTktqQktoYVdBRzRu?=
 =?utf-8?B?TURBQUtzWDlEQnV1WDJHMis4cjFCcVFxdjhBZmFQcTMwRS8vRkxZKzdTam04?=
 =?utf-8?B?bmtiU3RxdWVDUlY0NEFFRGxvRzNGeTFPSzdDdk43eTFRc0E1eUlFQ08rczNJ?=
 =?utf-8?B?MjkyTk5YU1l3d0dMMUR5MUw2Q28xNm9rWTZEMThnUkdSNnNZTEJrMkRmTzNa?=
 =?utf-8?B?bmhGVVlaRTdRWS9sRVI4RjhYeDhyQ3RkbVMxemlhNVZpcUloRzBTNnR3enRJ?=
 =?utf-8?B?bTF1SmdQcGNueGd3M1hpUkpyOFBoNFU2eTY2SVlPRURWY0FTRE41WEtrSTBG?=
 =?utf-8?B?dXdYVkNGUjBjL0t2d0dyRERyOFhDSUZSdEIrVzBqSDYzbUlQRW1xWmdTRVlR?=
 =?utf-8?B?aDVJNWtaQzEzOEZhRVhjMnA4RnpmaXdjS2N3NC9pUXB0b2JLQVJvdWhVWlJG?=
 =?utf-8?B?V2FuMEpqeTBiMjY2WURnbURxcVNUcFJ6NTJZTEF1UzdreWRwSUplNFdaV3Zw?=
 =?utf-8?B?MFlJUVBqVm9tTHpxaUlFY2gvVlU3a0NQYVJDcVpmRkN4Q21mc3EySlJ4TDRn?=
 =?utf-8?B?WVgvN0wrSitxM1dDUjkyZEhtbm9NL2M1aFNCU29PSGlPREJ1QlRtS0VBbmgv?=
 =?utf-8?B?S0E3a0tMSGFUVXNHZEdvTFBzVXZXZHE4UGY3cnFEelBnSEp1ZndxRVNxRHhS?=
 =?utf-8?Q?JT6JzN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:49.1933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e2ec0f-e70f-41aa-ac9b-08ddd644f9c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3f8343599deb..771f57d09060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -816,11 +816,18 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
-- 
2.34.1

