Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F25AEB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B18810E0AD;
	Tue, 10 Feb 2026 21:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1FxBpOI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FD310E0AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCdgTOwI2yseFNOB5YcYLlSwaGq56pAcD7jDQpdqeSIrR3AzeccTZZEV6OW40tC+4JBbRw1bz4mJ+JBBd/K2Clao/bz5uUpKWzNTk35vO4+kkHjQgTRtjeSfJOXk1JgJLPfHdTwama60rUOGFzX+nCb+4QubTKoe+8sBvk8yuKjd6UgE6n3/j3WNOjKG4B+mLg8PaQJhf+yslruTSfWtsYNVh+Ppj8M1rL12l+VcGSBfrRt2pup3AlNyebiQw6WCQcpVQ3itAKxD8uKI1t+oBwBNPBz+yHHTF4ATKi9pLdG7byn3kuOL2I+XgTmia29snyfchuyoqzjjKkQcR7xlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKqbU/4e+nDn9B9ainoTp1yAgc5dLQEZTzWBePaSjdk=;
 b=fX1Ltx65as8bgehXCqYLK02Uv+/tmdqyNNVvk1srNMuj5U2xShJ0aoFi4hAuXMFCv4gypq9ATNj4QIssMQk2NDm95NdDX8t9MSAa8MWH0U2I9T/VT9I9wK5QwFBbL+AxWBTI6QaZx2eNso7ElPZzAZBzLFS0RFaxmbTEDXPsIjrAhUB/SHbvHOwKyHgZdCb8mijnuZG5muUQxMBTDU4p7oMwK65gT2tOpTv/RzsxgmvssOZunRLGmGjy3hTDLailnp3K1Z8hflK2sF1h3YheXMF7O1OLuM2YCqCZC9WsGk6gkzsg9fKT1MlLITL7EP6PB2FUKSeIQKeNxmdpZxcpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKqbU/4e+nDn9B9ainoTp1yAgc5dLQEZTzWBePaSjdk=;
 b=D1FxBpOIQFJy6xMd7qNMLlLYaiV4USOzcPbG0+Srkqtcd0/7NmJ45Uu7SbmQMy5P6rR7Fe4PKrrwRFDUejmHLlIQXxG7vurxaerNuDkLk75mpACPfZQDsJlXhV7qhZRo03lPzmn9D/j0Fx2Li01Netfn1Wb2oFXcxWe2IKdRmkA=
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 21:48:03 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::32) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:00 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:57 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 02/14] drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
Date: Tue, 10 Feb 2026 16:47:17 -0500
Message-ID: <20260210214729.80964-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 923571d3-4834-42dd-b92e-08de68ee0f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmNGUjg0R3hrYVNtQkFoMEZKVzRqR0JOd2cvYUVXRHp3bTBSOS9DeXpwcXh5?=
 =?utf-8?B?SEtJcW8vaGl0MGJBL2RJS2ZxNFZtd21xNUE4b3pZVnlyaU5LRGpTd2tFYVNN?=
 =?utf-8?B?Nm8wVU1ROFlmOW51d3RQbTFrRlZyZW1PdmJNemNGY1N6TkFZVEhZcUJyc0RC?=
 =?utf-8?B?R1VWcDJuaGtwRnMraUVRRGptS2hKMXBTL1orV1BFU1ZFRGhJS1kwRjlXVUp1?=
 =?utf-8?B?UU5QbGNxMWxvbXFFS3plRmx5RnQrbnh4K3VUcjVjOUxibWpxVHRiYjcyamI5?=
 =?utf-8?B?a0I4RkNmc2VhME4waEhJR3UzSk1aMTYyWWhWWEJtZDBSWmsyaTlWKzF2OENT?=
 =?utf-8?B?SUpyTUhwUm1rOHEwWnJlSGZOejBHWXI2V1IyWmlLb0o5T1hZdlJLSUYzOHdX?=
 =?utf-8?B?ejZNbVZxcnlpcEFtZ0s0MFRiUGtpaTN6Y3ZCR3orZ3p6VEl6Qko0Ylpnajk2?=
 =?utf-8?B?N05BcmpqbFRSRWZSWE5vSGI3ZkFCcTNSbjRkd3JKandrRVVBbkFKUXFWTnRl?=
 =?utf-8?B?MWI4NGlDNHZjdnJUemcza1VKaW13U0dNWVdMNWxEdHhtaUJaR3hRbml3NFJ6?=
 =?utf-8?B?UTh6NlpXQUlwazR0VjN6MHFNZ2RKMGJCUHpabk02NEkwSVBRRG1KUFpicThE?=
 =?utf-8?B?ZEx1WkI2TS92dVdrekZaV3JJTDllVGpNVkdEQXUyZ1VhajFUQzB3R1QrYjlJ?=
 =?utf-8?B?VmFPRjdaaHprWm01OWx5cHU5UStGZUFOWjJVaWY1UkhhVGRPMWN6Nmw0dU12?=
 =?utf-8?B?dXZMMTg0Ui9CVDRJb1RUeFprMGhzcEFMSzhzLzVIRlBiN3NkY3BDWWtWcTdG?=
 =?utf-8?B?QmNneUJHeU1tWkRpS3RkSklUQnlIZkI3WmdxYUhadHZ4dU9mdzJWbXgyamZh?=
 =?utf-8?B?MXNOSm5SRy82OGlYaWxwZGorWUNzeUFJSElxaVlmaXJrUU90N29rc3ZiV0VS?=
 =?utf-8?B?eUVqbXJ6NnVZL2t5aHNOOExPU0hXb2ZyUllibUN6SkNVT2ZLNFVYWno4OURN?=
 =?utf-8?B?VElXYXZneFUzZEZ2TXIrY05QdlpKYktyUTRtSGFjMVNuL1Z2Z2Y1bVQ4emoy?=
 =?utf-8?B?MnhUVkRIeDVVcmhHVXIzQ1NNbTl6bndDeHloL1Q4bTVXckdTSmV4SnZUencr?=
 =?utf-8?B?YzdTeTZoMDUvaFRwSThzWnRpWHlvcVRIWFVJQTFTYTN1U3FVWXU3UkpGb0pT?=
 =?utf-8?B?VjZ6YmRwR29GcWMxbkVjWmY4WWE3bjBPb3FxWXU4MWRpUlUxL3JqNTVHR21I?=
 =?utf-8?B?QUFhcmlVUHV2ZkhSZHdUb0NsNEJLRmY3ZGFLaVkwM2JaTnd0MmdEUnVwbHJ0?=
 =?utf-8?B?TFlpMkhYWHJzSk00eXJLTE40T1g1VHpyZmVKTkZsVDMybVV0b0x1OUFWQTZK?=
 =?utf-8?B?YzdpMjhZRm5ITTNlK0ZPODFsQXdrOGF4eVo4MURzMWNiM3VvSkhjWjQ3NGp0?=
 =?utf-8?B?MHU0MHo4K3JoV2xpdjZSWE96M1F3NGh3azVqSGZGMHU3Qk84SDJaR05XSFNE?=
 =?utf-8?B?WkVMTE1ScTJHQXVPL3MwMW9idGZNUmdKY0VEK1Z3am5DT2toMmtFdnQzNzhy?=
 =?utf-8?B?dUJzV1lyUGRzei9BT0F5bjFFOFh5TXc3cHFXZHYwdXFKN2Y2NHMwbjB0L3BY?=
 =?utf-8?B?SzlSRWE4Qmc2SDg4TDg3N2JodzN2bitzUHJmcTg2aVpKa0Z6OURFUEV2c0Ro?=
 =?utf-8?B?K01MTzNabEcrSjR1aU9BU1dFcE5hN2JKQnF2cnV5K0FWWldoaDNYazZxaWxP?=
 =?utf-8?B?U3lyaVlWenRKSE1KWFlyZnVjSGo3Nkw5YkdDcGVDSmY4NnVoTDg3dk01S2dw?=
 =?utf-8?B?eUFKVm5mOUZFWEp2VlUzbzZCcUdYYjRoa2xkOWw4a1lGQXBQTEtpTmpxMEx6?=
 =?utf-8?B?MEF6UW5TNDdjRU44ejNmcUtLWXAxZkJiQVRucTBOZHowazVGSHcwYTdXZDZ0?=
 =?utf-8?B?Zk14VldIQW4yNk95b2s5czZQRGJXK1JMekJqQTlWdy82Uk4yK21rWHpQUUdR?=
 =?utf-8?B?MUNtOGxYSDZla3lUUktFZHJlVmZoYTVieWNUKy9nTlB3cnJrSGZYTEpJQ3hZ?=
 =?utf-8?B?ZkNXZDlkbzkxUldXTmFDUm50Tzc5cXlDRlJvNGgrNzdFNkNzaFJDaWtmSnFG?=
 =?utf-8?B?SzV4YkdqZ3NNcG1kUEN0VG1IcGx0VHJlWFR1RmRNSHdjR0h2YmlXMTRvSTl1?=
 =?utf-8?B?N1RiakxzUGlWNHpKY1F3ZC9IekVoU1lNd0JmeUxrckZRc0VxVCtjemZDcVRL?=
 =?utf-8?B?RFI5T0F3WmRmMUtEYnZkRVZ0UWt3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o7LFii1tV1fkuvL7fPg4jZEPOWCHN47Fh+6isa8IoPQ3Pfh6lL1UiQUMx7BFxOIPorfl0hc+kvDojcydYMnX/WLzexF2iZ7N7WHbYODDShPPJ0fi8GAMeDOj7LuGRtyN0yvTqMT8rXZ3iUzhaRGtwRmjgfYvhYDyW4xZwGVR/B07rwocz06fP27ZNji2cdHgad1vd9Ae88x1xKHLakcKvli7pG/uUT7Gypnr/lgzsmzG3n122Afkm/wJR+U4I/eSbV5PMG/pptXu6ij+ydi2J6hMdwWyWQs4pg7zIYvVAVCmj7KDt+8XAWkeLwRDoJSG4mtbJeS4KY4WZODoxr2/Do3AmtE9o/K0IS2PyyPU1BQ43CAll9mTZTUC4KzaYBdF3hIHMX29eoIv33eWDUaWUKDo7sZ6MWIldrsRjbTK5efKK22fPw1UUt+KRJULhLLv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:00.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923571d3-4834-42dd-b92e-08de68ee0f80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

get a global GEM bo info and aggregated doorbell handle

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 include/uapi/drm/amdgpu_drm.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e5b7f3e34e40..b96e5b85b315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1007,6 +1007,8 @@ amdgpu_get_global_bo(struct amdgpu_device *adev, u32 id)
 	switch (id) {
 	case AMDGPU_GEM_GLOBAL_MMIO_REMAP:
 		return adev->rmmio_remap.bo;
+	case AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL:
+		return adev->agdb_bo;
 	default:
 		return NULL;
 	}
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9e4692c270fe..3e7c12d5987f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -806,6 +806,7 @@ union drm_amdgpu_wait_fences {
 #define AMDGPU_GEM_OP_OPEN_GLOBAL		3
 
 #define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
+#define AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL   1
 
 struct drm_amdgpu_gem_vm_entry {
 	/* Start of mapping (in bytes) */
-- 
2.43.0

