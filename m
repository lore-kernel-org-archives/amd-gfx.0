Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE30CD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 534BE10E773;
	Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RxJA7qj6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77710E775
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cego57YnmVnycfmBxV4x+zkjKOyh/Cg7TFowUFAAAEybroNdjrrDJrcgFCYtVyBfPaGE0UecKK2mHVEJR5YdfKWS07vzncBuZ+I7CprxzGJeJadQB9lbuZe8Va6Y/MFRdlt2GWeO1ukE4Coen5Qaohq1Ydwg7BEdhDW5Zrka942HC+XUNYbyGkVbN0hneHpGS69RO0eRuUvW2VqFFZZcb2cmlrqnhkwWFG9ul/1gHyAqKdwcm8HDyqV9LtlQLjcScTL66WNQXGWfzoy9S+UlABaxrTmrE57xTLGcKd9nNSAAvPFoCeIctNoaUwmUjm6wHJvqklGsthpLbR9Ge+uVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIhR5UiGQ5eI0qroRFV1p5mwbfPlzEWehvqnLELqpQY=;
 b=UHDrEn7kbp2F/wuLgQlHceojtxgTZfyAYO0fAPfkLaPMQV2tWOhbP5lk/LRl2gMMtcvatZCad03w+W6LZrB/joiTlBcBbqsq7u+5/OHYopLWFCAlahRZZ9nBsppVjIIGnwm3Zf8XG3pJ10ZslJ/9cAV/aS6jrRY8DrvVRvPEcq8r5AO8xXcze77kelrRnaBePkd6R0EvHzhdbOQYmAvHpWLdQJGgfhxDaFtH8Yut6vEuwTQwHkUtuDmQMtFWbAiVBqThSORVEjn29Xw4TvVlsyrUlQUJx62KnGOTRBmw5Yldgov6f4gdu9toduFV+jhgMINW6qma1DAXPIw4fPw68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIhR5UiGQ5eI0qroRFV1p5mwbfPlzEWehvqnLELqpQY=;
 b=RxJA7qj63vduk/0vhQ8g8qIoOUx9QBIn8Kc8VUiIgz3v45Ifhn9jUtySUzwhbcaeuQXJv1DAssxuhR3oLoLM6NOj3ovn+mRuot3F8L6DpSUjcJlz7LarqRHFFCIOK75N2SL1Z7DuuoAxrLXF3+i5I0CfHAyIPKKpAGAiwyCAPLA=
Received: from CH0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:610:cc::10)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:08 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::90) by CH0PR03CA0065.outlook.office365.com
 (2603:10b6:610:cc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:57:04 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/43] drm/amdgpu/sdma3.0: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:25 -0400
Message-ID: <20260615235645.737189-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b289a8b-f061-47d7-1a7b-08decb39ce9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aVVJTvWmuqyK3KamrNCE722ebElu/zsbYpTz+I82i2Ijj0xbopDp0qJZvJ5xLcdBwEqn6PxUoBvqRH7bABVCZ11trKLymHcFyvALZqZZ32sA4wNMe10MO9dLJAdJ/lJPoosOmbPRCuWZGm7h2QqJEBpzpsyKtculb5tDQWDELyX6XMHAe4xmihSAocw2xsJoYEPn48lsZahCijWMmwS2hxfgvn9FwvHNyqYD3iCorghTdhEd2SGeqsR8xwtXgYjmHBv6eelOzbBxtNkUB0/AwEjq3bq2eLLEH5s6cuZVHAFVAZc6IA9C0liKkr8fUisE5ZoTRts28LNmDXAnoqZcGlvIEYSWljnf7vcWRfqndIj6vs5AVhNfffLIhG4k7gBKoVnIH7lCqrl9Zld3Ad8NRet8acYgZO4QVEro+y7FaXmII79hgyYgfvGaY/mbhE8OIB82Us654qkb/yIFUHBWuQjN3feKKH2nQeWJu9PlOG68fMxiLNp7PBneFQ6SwoSnJB+/XRA9q8jAty3/G/hs0Dk/iJEf4DWXN60zbldKh0STSNQ65aWAjrG8iDFNb+Rq1IG4eSoNZqRDSftOD1ADWpngTVZVlsLtM1HE3lrQLWrAKvTe8smsrM5RQrHxw9xUrgLLHH9xhzBXwJfrIVDh4XQ1E3mO+FgaZj90O+DkkJ1WhyWPDfcquKn8BV6FNRllXh0knS4Vx9gIMxcpk0nnVtRAFl50HuZvZ0yxHrlUBW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nlu1ikYrTkx4iBr0VEUghfq299KR1lynOQkMCbthhBxIFV6TvMob3i0KVUnYl/myzDTZ2qvUpC3Zj3dnSVJV4TiFprfURDbfC3IDOommjpR+N/3BAqSrF6dz2/4iVId1nyOFxc9tZFzXY+47LAq98maowQgl4FYlJwZmR/JLg/FUSyLVlKUkQufYhxafS1VKwI+FA5T6VjRXuX6lWVWCo2dCnAWl4bXumJ3H42I6fseq72gUkI1OGJuyWlWKNUHDDUqSB73m8qKI/f2z5geU21dDkBZ4HCtyVqUwECBjVdCxDosBFum/PZ9dDkd5eiDp8UFfOIg6UrHvqk4L1Jh+gTXM5ppj25ONctkc3vhoFbNIYOLCCfzHgZxnvN1Z4VUSAUfSgSL+88Kd0woyc5p+8xiimArv0adBG043BHWAUoJRT3gpdSnreYij6zpr/tQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:07.2994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b289a8b-f061-47d7-1a7b-08decb39ce9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fde9be746900..a57378ebeac33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -298,7 +298,8 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_STONEY:
 		chip_name = "stoney";
 		break;
-	default: BUG();
+	default:
+		return -EINVAL;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-- 
2.54.0

