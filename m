Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36EC88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 04:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F9A10E03E;
	Wed, 16 Sep 2026 04:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gDiHChJx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A8810E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 04:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+a6+mVvgqOcXS8AAk0t1NAbA/23zDQgX3rrc7sxOU5jh0v6DjCmfpKJ9Ce7SZVz4ZI2Anp4bseexpaCF0xy7YvkOyjUqynydvFhezK7Sb7BMN5pX23ivPAkwFqjAXxKNqw/zCbdZtM3luNQepxeKIQAELGfw3IO1sNfH5sYF9EPx9W/Qm4VqcS19SAAeJfeWn6D69PtDlh2FQWsh/Ta1DCg/NkIT+zs/LM0Be9rd6W5lLx3/xbGwA7RSaHRj+vABE6+1xlejwRO2/gfhZmJJ4W0iDe1yYV1gY9uXyriZ3y0XPwF2YBpdd2JTiYIilGdXDWqJKHfzSRo2/Sty5Ahtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PJj0ig2bp1Z7/g6rxsBJ56wZjXg9ey08ekkncrid5A=;
 b=MBVajlRNFETeYYjbadziwM6XjD+Y+/4RLp3dLXuBYD8FPObgPPuQbzR1CT2DKpsa0jIVcvJBB0JQ4iEdrb5jhWyf3nSzfihsLRrf3UWLqnpoPcJ4pwe3g6ktyg2vQUHiKMmZhgh2rFl1pvVYzxzKWCARH6EH0glQ3ADhH8mOR45Ti1RMTH96xa7U4pUtyMgjgL1yIVicCQycBujn+Lh2k73F+FLCHTlXmCQDZLdZqpa79S8Uphq2baIo8FabcO7JLFjsIpe4sLUXdNaBM50NSLTXHAOXnBGSvuaqINioVe0Oqr5CJfNNTp/szHoheGRswWwRjDHEoIzNgUGuoUz8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PJj0ig2bp1Z7/g6rxsBJ56wZjXg9ey08ekkncrid5A=;
 b=gDiHChJxD6sF2omrOEQkuyjEhQ37DqTZxM2cvGFVD1TguBvyQIkXatu3+LtD3baHKrdHFGJRFGWIpLNjHpkgLn29lnVbZ25DyLF/xf9jXWLKkUgLZxvGo0wlH78j6vJDpCvxeno/TDq3Am2vQ+41gs33boFZaQV1Je/D+iGlFDM=
Received: from BN9PR03CA0100.namprd03.prod.outlook.com (2603:10b6:408:fd::15)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 04:41:32 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::92) by BN9PR03CA0100.outlook.office365.com
 (2603:10b6:408:fd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 04:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 04:41:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 23:41:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMUv14/15 power context allocation
Date: Wed, 16 Sep 2026 10:11:00 +0530
Message-ID: <20260916044100.1656293-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: ed98ce44-997b-4b0e-d0a3-08df13acc71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: qQRnafxt4s+GXDR1R7XtViscmUBG7Bmzo01wB5z36Gtfm9XaiLun+WrRvBq/JDuPex4cWKhcXZ1TL6RXttQl7aDrPeIKwswO7vTNXdxeN2a7RuVOetDtANDxqYMsZS3rrczUcvuOZXh/3tyslSn0Nl4LJesvWqazsn4fIX8dx7L3pqSXle0WiH+CHRcb1s3ZTET/k30QNBNiju2CPN/dScn6eJX0olpt30irV3Cr6oihZGvghe+R/8tIzshW2sxUTzeaTCO8xhyggWro6mTNeA79mnSqd4T7OAcUoPUnnrkG80jncVDE7ZaXcIXmMpLzJ4E3Nwk4RvTkJ39BB1PUsTRdfhlc/W4rIwWpxNRg6qszrv5p/7KWZesr3f8PJ3oMWfqy6dDhFZV1Ipb2HIFob1BznSloaLRXvyhQ7cQk8qMrk39oVE5W+xuk+4v35IOfOa/hF16mSCcR1tqykwx5XE8ljtw9/CRJue1fXgoheqNTXEZWqHnWZsToeXnqgAmwEM0Og3gSDSClok9kYWtlTGPBWADD7jgE2kNLJ9jPTvOF9HtA9TUO5PC8jiDt2H+grXws+S6ZoccYXJ1VBHnQZ+eSI8s/B3nIinPiwx10WIKe1OtRBFJkio1DPNm3bcbIDeC+UiCUZIZrZb8fSerKi2Pl5ssq56WlLQTobFQMcK06ovjUvCSMT/LcyX7SUQxlbDpFlLIKqDjmqtzbLsd8hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dm/Q6Kq9f/gH4lJnVP9IiDVEdIjKik0AAu8S3U7LBnetKiUduFVRyFs/TkeuSYCJdfBmUm3OSlGcMfI+W/E22AiB2loL2A+UzHNAkVkxZKIOhAAuftIVt1gSLFU8Ejxj2BTJ8lEmPJT96SFLnczk+bybhP+kCLkkfRmMANCXcXvlG78wR6LAZoVt1IVPI+JHT565qa2h6kaKdUxTrXp+DNwOcO3xQBJui0fqbEftYz02UHs56zTEhVKZnIuooNVEVtSt9xHDSh4YafQdb3c6Sfa2X9ak33TWbJ4o3qCMWOI/Or2Im0KleJDC3r5e1yhxygeD6/ed9lb/+joYDcfArvA7CaApf8KZPl8tBuWTw0s9gaf6dO3qaaKB+CkS08zusXRUYOZ6NM/EEidBPRf/B0UrtiQqaf4L5TitoQM4ZEiL3oBpehxl5ElVlZmdgR1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 04:41:30.5261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98ce44-997b-4b0e-d0a3-08df13acc71b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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

Allocate the right power context objects in smu v14 and smu v15

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 80dac277d1ae..f2e6105b0d79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -396,10 +396,10 @@ int smu_v14_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc_obj(struct smu_14_0_dpm_context);
+	smu_power->power_context = kzalloc_obj(struct smu_14_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_14_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_14_0_power_context);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 2269703869f9..dfc1022112d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -338,10 +338,10 @@ int smu_v15_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc_obj(struct smu_15_0_dpm_context);
+	smu_power->power_context = kzalloc_obj(struct smu_15_0_power_context);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_15_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_15_0_power_context);
 
 	return 0;
 }
-- 
2.49.0

