Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D4AC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D181661DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D181661DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E26E837;
	Tue, 29 Jun 2021 10:01:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F3B6E837
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 10:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA+ytPmzLsnIIjTH+BfAhBPPLAFyJgoqvd4SpyRYUxihxMcFZNZPOeCgpF1r0w6vzY7S460pHmVM46N3WYty8dR8bCcvFwZ6RxVCYHnRZ7xCAGSO0Bslk/iuj18MmmM+o8cEd94nLLlbb7WZiUiexGBvi8B/5rOY3wzsTmuBuJDDMpsdm38/iHNO3FF8IzNWFKbA2tumwi90hZ6rZZL9zheBvUSezGt1lULIZB9LxA9ykNF6ogqZYgZI8HMQu50eTO70+pHooXQiESefuGnhGXOH6ec9F5cgULdzKdmd/zWio3jNKu1G2j2n6xir8clHLJxWLtAuixHE+7rWgN0Dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Twch2nxLhy5+LMVnfMulWv7ZHA0mJg4NY7n7upgdMcc=;
 b=GC03XKPxAkYS/Ugo05Cycv+CtAMyDXBqwNAw5Clm5nFvrToWnyJuhfLnOiLkj/KI//poB11zWIB9DOLR9lZqi3HOVKKVuGs43f7xbXEushAmj9U5qs0qeHiH0nJ5Q4eLwWmQcDWNFqQmu2Xjf7uhFoOfkxpyvk3JkbjI6t9zGYibu4lqtYoQ39RhKXbpfNTVobIL5t7IFtKmsY6mf/0HZR4/M1bTTYwp0w0GzrpL4C4Q09/hKLhm4xMGldzCbXsz2crPhI4k5ew93DUAY4nfaMSbB81BoOLlEWZXwG3jwbpgont04Y/NL9JZDIu2fYFcE+K/jzmkKypVgjGoMMSueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Twch2nxLhy5+LMVnfMulWv7ZHA0mJg4NY7n7upgdMcc=;
 b=T1AmAGs6GjwEhMIQAwACnUsc2iXjdd/C4gmU6qqBT0Au+s8/B/KpP90h6FjzUC80wg7yJ6e4bV/B2aHu+H4uBTvX1lzjGPnsDdvXQLyouNSA/HSJ+Jzli4whDlwlaJzvmkmXvzKSPFpm1RNqbY0zxWc7apsGFNgzilxaEFRhnEY=
Received: from BN8PR16CA0012.namprd16.prod.outlook.com (2603:10b6:408:4c::25)
 by DM5PR12MB1561.namprd12.prod.outlook.com (2603:10b6:4:b::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Tue, 29 Jun 2021 10:01:36 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::f5) by BN8PR16CA0012.outlook.office365.com
 (2603:10b6:408:4c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 10:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 10:01:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 05:01:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 03:01:35 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 05:01:32 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay
Date: Tue, 29 Jun 2021 18:01:29 +0800
Message-ID: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf95f47-2d59-48f5-5295-08d93ae4e1dd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1561:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15611D71E39CEDBF7054E6C9E5029@DM5PR12MB1561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9rDswB8NctRBpJcXAMLAnCKg3ScsZxOSem5zQCXI60sTxVHyuftyKHH+GB/VLXSbbjcSyw52fQb2SBmn1NHMYluO3T0rcpsoHAr/8VESLIqVwvZFD00GGuTEHKv3xf66UpMbwRTDVaq2wEtbgXf+ANmJK+3VXp2tYz3TEJ1DLzN8AC0eUDI8vkshqWRLXILZZejf62YyfqI3bXkecR35eOskbx0FwxNmxv06utjnQ46B6lMwcjxVZEwCdJjTIzWNMNxGQ8VBUKKAlVNln15sRDBZxCqgDg8aNfpFt7/kyQTzjK9pxhvDSVALzKAINIb4ADTNyWXN6BUiLtM2HsyU75i8EL0t8FlP9FwQMa5smDnJ9zJ4BstXbqV4zVAKgGIY+m9x12PA3I3PnOso8a1nlly01nOPmETY2B2eKeH+BDhw8naIxHRc18E+32WXEMogVRaDVhFnIQFPISpSflNPKG3h6gwr/O/IW+1XbTOrju88rgM7X0h0kDuI6O5u6S4cBTmgYc50gco5ZyDBdtbxYrqOfQ+HAbp4FPH0+cK5q/w+nvRBUyiiK7hX9GKqOtBoyXDJK6JM6FxrSn2l0pSv+cTZlSDL94QL5Gq9jqyqpYgcQwU5/deXdZ3KJ442jmDl/RU9TtUTQmdxwZgqF+J9pShNVdTswTWSREGY5NGL7KAZwV7Cdqp8FDVSCb3ib06HNvJf9cVKlaHKlcfIT4AL5Lc9XXIvu/MhNwoazSmF4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(36756003)(81166007)(356005)(6666004)(82310400003)(83380400001)(478600001)(47076005)(26005)(7696005)(8936002)(186003)(426003)(70586007)(6916009)(70206006)(5660300002)(336012)(1076003)(2906002)(8676002)(316002)(54906003)(82740400003)(4326008)(86362001)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 10:01:36.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf95f47-2d59-48f5-5295-08d93ae4e1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1561
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
GPU timing counters are read via KIQ under sriov, which will introduce
a delay.

[How]
It could be directly read by MMIO.

v2: Add additional check to prevent carryover issue.
v3: Only check for carryover for once to prevent performance issue.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..82a5b7ab8dc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7610,6 +7610,7 @@ static int gfx_v10_0_soft_reset(void *handle)
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
+	uint64_t clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7621,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		// If carryover happens, update lower count again.
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
+		}
+		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
 		break;
 	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
