Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE0CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3106B10E9E1;
	Fri,  9 Oct 2026 15:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sukkahs3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3B610E9E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oya/NbfGqHISVBbdlgo3KWJD6TnyR+/H1e8NOsKfoNo2XTWHnx/+RFRJbvw4Ob8S3Psd20tSUrNCvGGn4/JyNEnjsm0KDZwr0gvbsdiCzgBCMUubrsf++pkrtbi1PH6GwDpC3+m9KqFviLgeO5p9etqi3mSHEhpLFOJZkPMqIxLgXsD2uoEpWby+De1AKwTiFRWTy2ygWaASby1ZaRvye50bi+HYusgbeVjKghZ1NdrkjY8iAc+EsFiSC9N3yhG72E1DrYcOsCb1WCIxR1uOmLsDB+H5bvOb0mPbLQ0KIeDDA1U2vTmWKA7zScESx84SEX7reWt9Q3yCQmr7VhPmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YKKEYcYhAS5pTJDy3IF+qJUYXfOJSEvXEv1pHpLv1E=;
 b=X1DCuZpgYMGvnXO0B14nBvVqo5O8eyLb1Oq+l4nPLQ355liRChuB0+gOyzJYCQfTkgHkKdZ6gNnNe6gT2Whujqn/faMh4C6U5fkR0Y6vsRgP9LE0ejRlpnlvILrXwOh9FSDWtTx7F+SFmMngUpWBUULaUzwyYMasMmNWILsTUVT12KbGIpE9FmX/XEBVGpQ/cTypH22OSdMmPCBDJ4Iw6qTBLxOHLZ89Z/KXDU9+BIt2KfJmgYkOL6roiQMOs64RHRXkqmwngTafrX8A1gOprk+jD3GfBFegpFvMVEIekN5th6gGAPeg99nuYmg4VIODyg262yn4qNGxyTBtViBaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YKKEYcYhAS5pTJDy3IF+qJUYXfOJSEvXEv1pHpLv1E=;
 b=Sukkahs3j1KUKNjANHMUgoJsUfE5MUKuECGH2P+RzgsGE4Hfi6nZlCm6a0paP8G1tH2LSb3ILk/JyTG8ZylFmfN0TwUhhVhpWV+TVC5+2RWYtpd6BGamKA1gwwzNFN86NZ8YmtfwTe7TtHTo40RfwBus0tAuusiQLaRRsYWf3uc=
Received: from PH0PR07CA0059.namprd07.prod.outlook.com (2603:10b6:510:e::34)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:03:12 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::4b) by PH0PR07CA0059.outlook.office365.com
 (2603:10b6:510:e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 15:03:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:03:11 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:03:06 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Allow VCE SEI command in IB
Date: Fri, 9 Oct 2026 17:02:37 +0200
Message-ID: <20261009150233.90598-8-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009150233.90598-2-david.rosca@amd.com>
References: <20261009150233.90598-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: de9036e6-008d-4f19-03bf-08df26166feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c2gyd4cxwE4MYOw41MaxDtEeSC/+za7Okl5+xNKJUZrYzbCiKV5WuSe7dbVl8Lh9V1NNEe8jEzmTjQE22CDUUPfcZ+obHX2TGICIuAnMckCExIv2FkhoPFIeUW7Fwohltq6HPQ46XnlzlR8QMJX9xzIXjqkcf2BxjXCN30Vag6MZ6GILnGmDkrBQq9zWvZrRaoyFdJobKz+54Ms7Es+d3KcsCDRwCUYfvnft+WGsZnvIFlhnMmnVZJ3phd6PhioYRJ50c35kLZ4Hq7n4mwTtX0b6PU6hredIPkxHmWHav1z5LgZJ8zqcxGtQU6WrsPbiYCol9dj4SsRDOQbNntirXqepGRRZI9gXoK/pT/Ug8FwkI41Oph7Ru+nt85enOFSe3WkLvA5/Bf3UEi2ZbiKcFH62AcUuebILRG7Y1qO+T8yZ25uuB9tUMvnpomKk9K3zpw5QEw6QpPlqSxSWTlIjo8fwiRpmpkPdrYwSkHwcaSSG0DDYv+bKgAiMf1eP/WFrvTtQEJ5dkKA5eWLSzUJQUiiDPGnUJVm8WE3EtMFoEoZkMcffp24jSDANu7MYipqsnKLop6RbRklGxan1qSsEl11yFtx3DOQlLw4VVioFeZmiWGTiHcymPziHSbPoQB0a6Duh51M60aL8wgNlm0e3eFvTZ61lAMqsKp6yoIrtkLFCndQY+1jJj6c28gITaEtsbrkMoMDHjrFkPdVGSKnzOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YtsfmsVAj80K6eLMz6ayEHUFqboKmpELIrudiQWBoi/uWPVsXyUeSg5KJZNFR2Olz4ocsfdw+fcqT/3PnzzUOaOMHT4aVUoSMUVbVlZRwXrjsW6fyA2UKEvXBmhLCHmWxHpBzlHp7VDmtR+eidstMev2zWIXpvwUS5uP3mE1LIv+/InU6RwZl+iX5URUNu1T4iopOCMnHUtlVpGGP4YdQDuXAmnB21UOpOe7U99zY4FwiJl+zNzIO4PtXqlYz5hSOy1pDZjVA3XSnStt0KDq2anb0q/zJqWhYc9VU+KxcdDL1WcuhVWS2zu2zYaV5VxMHvpsjSdLkKopQq3Mfc9qUFmnAnkkS619zedrLoM8bS6o6IIAMxs3ZdzOSi8OsE9e6L61JLgepgKye8FFjX9LRHoIZ+bzAd+pSD0N+dBB9Dtmoe9T4XfengBZ8qjt0mlw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:03:11.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9036e6-008d-4f19-03bf-08df26166feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
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

Mesa will use it to get the slice offset in bitstream from feedback,
which makes it possible to filter out SPS/PPS headers that VCE 1 and 2
FW always forces on IDR frames.

Bump driver version so that Mesa can use it.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..bb8e3e7b953c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,9 +128,10 @@
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
  * - 3.65.0 - Add userq syncobj timeline signaling support
+ * - 3.66.0 - VCE SEI command and fixes
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	65
+#define KMS_DRIVER_MINOR	66
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 2e1a48dafd21..c18741d16ad8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -925,6 +925,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 		case 0x04000007: /* motion estimation */
 		case 0x04000008: /* rdo */
 		case 0x04000009: /* vui */
+		case 0x0400000d: /* sei */
 		case 0x05000002: /* auxiliary buffer */
 		case 0x05000009: /* clock table */
 			break;
-- 
2.43.0

