Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E39FD374D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 12:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADD110E763;
	Wed, 25 Feb 2026 12:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEcWxTPE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF0710E763
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 12:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVs0XDegrY7vJvzusGcr4yy8AVi3jW+dEUtkW1J017FbAKt+FIqWThrgUJx65yZbXtsW3DLD7gJBrckMc0CtIaaKOQ59n6ZCexVAOTIqVNkrB3Y2PtK/y96ZSeHUcetvr5uzu0bRZCiu0FSm3XeDAsCNqhJvhheNJLxMvXgWNo9yU+5zKUX8wJaX0e4nn6D8S072oXm8RtzCbPOXLPbKdCFOISdx9mSFojJ94wLgrwgSvCGtvcYw4mMUdVY+bkssf/afFzOGUhTktlttOBmfQWywyo4xpIMP5315dHxa+LIVyd3ZtUPgD+71/9iImuBf+QhKCC/r/NRiewHn0KlMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVIs/RR6/hh1Cb/rEs2Th/7kPVsBwPSjmHcPlQ+oAEE=;
 b=bzZ91DQpvietQFA1Zfq5uwSfA5QoQuWDJ+DrAOK69EtAFmDKpSXwhb7oT5/v5sKklge/x+K2PhMu1xInmQteqpRqohLhWCCZyxPL5F3bAgXOq1qzcjLC3hsoKHrlTfb8FBgf29/PDwkFoSlw9ALl59CQjdznJxhLBTAvtePwElrYWETjDIieQNr9DONNYlJYJPiNB54WGAKByuGJTE5CHAibKVSDIpZnqpg2SBlRzaB5ZVQ3TX0B+3W1kInate/hh6DPirS3uq/4JJ3T2YiVecK5Ne1w2iGLxAOLP87u9hW93OqK2csrIAz1xKg3RMlzNuxWbpiYCUnV1eVhfk0v0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVIs/RR6/hh1Cb/rEs2Th/7kPVsBwPSjmHcPlQ+oAEE=;
 b=ZEcWxTPEjPXOHEGGbTBcOEjX6zwDlAk1b+zL0Us7zXjNoTZZLIRP3EGS1KJbnR20J/mK6cafBaLUftF47szMd4vM1LUrqfWvMb3Oog39Tmlg2nFggnbSigTCvwm0gCzALz6DXYHEyc0hLiqBwnpe36eDj3uHFoNx433C+qNdC4U=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:25:37 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::a0) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:25:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:25:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Mangesh.Gadre@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add pm firmware info to dmesg log
Date: Wed, 25 Feb 2026 17:55:07 +0530
Message-ID: <20260225122507.1956784-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d55fdc7-e331-4b62-c031-08de7468faf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: /6GVRofBq+THr2DKcNR7jEHBg7Ncy0+9NMt26TNlDpjfW8ZG2NPW3/eZAvFdh99Xhgwle7eoRRU0lWCIOKb65S651dpI+vr/+EzDyJIgijkx+iPU9k3MQ1Mv0Dr5lJN8cenS60vlU3nb23C+4AmrJmYXgfwlNPye0b3SIatrm/pVnmcVrh349VFOyo33GGOXQsvzS16VtSQHB7FioGnaoYsjI2cbgRdy7lwCN6DaQifqc3a4YtvG5PudGKp5WPdX0m+3wZVPyL/U4MHRiFIQwWWhtrqUB07HL/KlSoES9DjOX4qZIdhrX+gl2CcSHUAVP6dPLgiTX+qeP1L7bXwY/ewBWCYM9MiCK3r6gluGKrQfR1oUwpW5aIEs2sibV5Ccr9X+Qm6AwClMxfV8ee3wF7sSNYEQ7Mvj6C6n65xR4IxXea7wgN+u4ZJlvjHzZBbDmoYHYlhpOaCvheSJ6ijy/yASK0pWNj3A2EbCRKUWyNoJpTo/Tg2b4KiuI2mNYcjKIYKrOPQChiUdrRGdz6Um2iZe+ELLYLUschrCj0txVRqDnxiZxP4oFVYSwjjfxg+hwL5lsFZOL+y8V2H7ZoZwNCwOIuhdnVogRc6OgXsa9XRl/fNMJMldqmGlJO7UkUISES0pzZzVaQnGrOmT1lxEcIl4jtBTo/fwHeWGp+nFX3JZODkj8yhAgMh48w4z1+B4tFVuikMDSzcUJcwv8wpwDKYY0le93Qx/epRlGHKk/k1bTwTUE18QnevhbZOJYW202IwcaSWoaiZjS9yArXbmIRi9a2160hM38F6dKLO0mE3E+fv1I0i9ciIr/SATOKpW0ZT7nuIP5XYGRw1q+jFn1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fX1f/ffeSomLTQ0r2nB8o0S/k+atJ3blcbAZXiXZcYpog9O4H+lZTQ6TBOQFncdqb6z3Au0Tmy2YrY+KxVjsZS9wvSL0wgpuDYPlP4m0QjP8KxLlJ74EBqGiwX7cA4NzLbawBqR+ZYUGKaDhju+NHaEd4LIiED6RhdyhGvCu0dclEoJEkgGANIkR/ypuK7tb6xzRqrkkBny0t+kYuu13ewKl3RnrmNqNRUKXttM4AjuwFzByfjHiYuEfDWNABLBsZZQc19j6CcqvQU7HBNEWo0Uj0pW11CPdputX3aB0xlyXy9mcsous4M2b7B/EoP60wr5q6XBnnUqYpEmkLJUKV8PmsqAZ7J0FPx/uIdqUpowMbE339zcqDKdc+Z0Saawa42fmCR6SCw2UX3FuU/WOPuIfSZp8awsgAd7tBIR9y39beUAFe1z+4Crioz8AXAc3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:25:36.8414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d55fdc7-e331-4b62-c031-08de7468faf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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

Add PMFW info to dmesg log for SMUv13 SOCs. It's helpful as diagnostic
data for some driver load issues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 63a65ea802fd..1cff37d7f60d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,12 +288,13 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * Considering above, we just leave user a verbal message instead
 	 * of halt driver loading.
 	 */
-	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
-	    if_version != smu->smc_driver_if_version) {
-		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+	dev_info_once(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
+
+	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
+	    if_version != smu->smc_driver_if_version) {
 		dev_info(adev->dev, "SMU driver if version not matched\n");
 	}
 
-- 
2.49.0

