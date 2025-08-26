Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45517CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF1210E5F5;
	Tue, 26 Aug 2025 07:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsbMEe2F";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92BE10E5FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRQhBN6V/1McgaMTX2AzyJb6A5BKnrf2r6LSwgVARJnCCAbWi1Rvnu9Hax/NPPdCvHtPoe1lyPTiOFHU9tx8a/Gt93WAV9CSwsd8mp02tZlrN3XmiFuhaFQyjRNeXDRaTdjNa0eDyF+qSoFGgOs5naqkUUeiCjW0/dRZJ3zksoy5trwm/HdoBEzWzX7xQ4aihOf+35TCIOXr1SiTGlKeAwXpZb/WW7ZGxaRNRuhQNE5AltCjDnz78SQ1lvRUKV0ubtRmJSxjMg+AbGA4CzmML+mTcQTB66khxuJ5deQWBtwBnJmtARSj9Fd9ncrl4JqBa5SohdEE7L2QQKITMxhI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dgpEyD4ckuGtKG5fxwx10L+Lh5K4EmvPBH4HnBytqQ=;
 b=a9Rchpx2cvWJkEEB9cxXs6JwWrScWfRaGgy+HbEtt9vhnogGuTgBJ35+7sUh/TDhl8kb6ls/0pmxSwE9eZuRLk98Y4NnKp4MoZS0DiKqdzL+LUwqlx+1s/Mqw4cRQ6gdqg+KS+ui6WFBl20xB788OTGgqb0zwEytRXimyxdAfTtEFOyljR14TUUh5YqxrVvGQe6eezy5Oyi090pPFqoWz9UER9oMqi5ks6HToAq0ywBLVNKASsbQPGEDGMwaR74z8A52VHD+2D7Beyf5Wsbkk3929jen7oqcQTYaYQvn91okj3PX13X2Teb7zg/79tVWrsDMFvWtUQEDg5E4SZEjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dgpEyD4ckuGtKG5fxwx10L+Lh5K4EmvPBH4HnBytqQ=;
 b=nsbMEe2FcvI+RJYCnjiYApckN49/ssP6xLKAQMqocWfc+7/1utUAhRJ62HPbF03DMzs74gujc60Qst+ZrIKVl1Yzsnd2EoErQ2wagdj3IJ8T82YyR6K8J5f6k70i2gNjWrYsg5R21jy8hLlB/ZyxXTHi+jNTMtEas9GRoTbcEIs=
Received: from BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::24)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 07:47:19 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::f5) by BL1P222CA0019.outlook.office365.com
 (2603:10b6:208:2c7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v9 13/14] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Tue, 26 Aug 2025 15:46:45 +0800
Message-ID: <20250826074646.1775241-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2598dae3-9a41-4d05-9d7f-08dde474c86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWFBUS9QOGNwWXF4bFNlbElTclh6VGJ5NTNIamNLZk5LbDlpRGs3SjdoaFVs?=
 =?utf-8?B?Z0Z4OGVQajlnQkNmYlFIUm5icGgwU3VmNEJlRkgyTEJ4bGZyLzFSVGNrRjVo?=
 =?utf-8?B?U0Y5djVRSDZ0UXg2bnlaQjNUbFk0VzhFMHVaUUZwYTIxUDl3V0VvOThaVGlp?=
 =?utf-8?B?dUh6eHNCUnNMT2tBTnVrZDFHK0pDRXNDZnJrcEwrbS9IYmtObUZHbDkwQWtV?=
 =?utf-8?B?NHdha05yREVWcm9iK3czOWcrNkh2Zm9WUmp3S2MxYzkwYmVCM2E3c0tQVlFI?=
 =?utf-8?B?emRaV2hXN1MrZ0svS2FkeHlzaUpnc1VwczlMMkpmbGVvUWtxcHBNNDR1UkVq?=
 =?utf-8?B?WXFOcm1MVlBvenBXWk8zUzErS015OTVZYm1jYjcvV3Y0ekVDb3VUVEFLRzlu?=
 =?utf-8?B?ZEJFZkNxTW1vZGNuenJyeFlueC9wWGdwNlgxSGE1TGo3N2pQcFlZMkhWWndm?=
 =?utf-8?B?bUNNN2NvZUpBeFp6S0dUTGt2akVaaFhBUzlQUDJzWnF5Qml2cjIyVzJFNHJ5?=
 =?utf-8?B?UzRqS1FJTjV3cjZHTCtZV05ITjlXTFM3MnFaRmR3eldEL1l0Ylh1U25TLzVZ?=
 =?utf-8?B?ckhnYmZJemV4a0l6U3plZ0Z1S284b2JpRDBFYlgzTGVtb0F4NkFqckZtODFJ?=
 =?utf-8?B?V3I5UEdwdHBwek5saE1COUw3WXNraGxEdk45NzdHWi9TVC9BeFNVMU96WG0v?=
 =?utf-8?B?L3dZZHQxVVk0Q003N2FNZ3pCUmcrQUtQRGRhalVxaVF2WDJLUXBIV2VXeXpK?=
 =?utf-8?B?Z2JOdXdDYUV4a21mNTJZbWV0a3V5N3kvdktsZ01KWDdjanhic1R2aDk1Sy80?=
 =?utf-8?B?M2tmMi9XRHdSZE1ZYXFkZ2M1TGd0RTFUODhNbDhsMjA1a1I3TitIczFXZUYx?=
 =?utf-8?B?SEltTEMwQmZ2R3l1NE9POUlMbTQ5VmY5VW41czF6emNpQWloTzI2Nm1iUmdC?=
 =?utf-8?B?VEl1azFlOWgyU0kvT3dlejhZR0RDc3pFem4wNWpUWk11U0FxazR5MkIxMnli?=
 =?utf-8?B?aHV0Z0VvYzR0cDNSbGhwOG5EdFQvSzV3aHdHZGpHN3BNbUVYL2ZyRU5SOEJp?=
 =?utf-8?B?dnFhL1pPc0JOdldVS0piTFBUbmJFU0wyZWkxUm0rUzB4b2lSZk15QmUrZjhD?=
 =?utf-8?B?cENGQU5iY0pqbFJ4WkZ6TWhpWlpPbGFmcGNWeGJxVzhoQUxXenBBdkpjRzZM?=
 =?utf-8?B?cGYrSTg4R1NFOGsxNDZJbWdjajVBRWJoUVVtR1BJU3lxeFVWZFdjbUMxejFC?=
 =?utf-8?B?dDB2S2kwSHFNTldDQUpCTy85czg2c2VUR3JEYjVkcUg0OUFKalZ2KzVhZGI0?=
 =?utf-8?B?U3d3NWdoS0d6c1pRSFAycUpWclEwa2RoUGNJUnZvc1Y4L0MySFFwWGRSb3RZ?=
 =?utf-8?B?Zm01ajJvczhoS0JnbnV5Wi8yV0NHbWk4dys5YSt6a3dxWW1DYWY1RXpCanRW?=
 =?utf-8?B?eUJBeUhBQ01nZVBrWUVGSlBaTVljMXBwdjZpN3dKT1VwZ2dzeS9VR2duVkNI?=
 =?utf-8?B?Z2ZoWjhpb1dYbnJSRXllN04zd3Y5NUNYSnVzRUkvbU1nbEJreUhHQURBRHpQ?=
 =?utf-8?B?WXVtRXMyd2xBc2QxcmIycDdWdGFZZnZaQVdMTnJJWW1ob0Zrck1qOGFISks3?=
 =?utf-8?B?c1I1UjVGSGdNamxHQytzbi9nUE5mSlJlcGVmWjZ6aHcyUUgwbzJ1aFk4YnZH?=
 =?utf-8?B?VTdPdnJGUk1MT2tkZlEzNzVLUXBEUU1kcEcxMEdLVlR4MHZJNnEyVk1YMHM5?=
 =?utf-8?B?NHhPdnVpaVpreFZoWXRBREI4VC9iNjdWRnBoYW51ZkFubSs0M3hFMU1ka3Qv?=
 =?utf-8?B?QzVYTXBoOTdRUC9veVFyQ0E1L1dNQ2tuYTBxWFg4L0Z4c0Z0TzFWNC8ySVl0?=
 =?utf-8?B?bzBHY0dIWWhBN2lGZGk0SFlSdFVQb1FvZ08yaVpuRkJVYytQd3JGbEJnbzdG?=
 =?utf-8?B?MUhvNTFvUW1LbVlLWExTWldBaURjOVVtMnZjSkdUQTF0ME02dHlEN2JZS0Jq?=
 =?utf-8?B?ZTEwR2RKUlFuUHdqSDQ4NWo5OFVIa2xEeDVXZ2lKT1o1THg4czMwTUdjU2Rl?=
 =?utf-8?Q?MKrsqk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:18.5877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2598dae3-9a41-4d05-9d7f-08dde474c86b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

