Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB442C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EEC891D9;
	Wed, 26 Mar 2025 08:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfljLL9G";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41A6891D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqRDkhJs2i4j080qFTDaBhGpqT833LFSdhs1vOrthUTx7dthdh7EDU/MwzH2UhrzY7Evf113xVYqITzxj/NMwT/t5ipX++LKnoaOPdYJQejckN7jV0By6gX+gpcmhe99SC8XDV7ePKHPhmgXLmfx6A7BYiZRBbDAa/cBRFncGBad4wP0ZlxHiPubz8/8MNvwxhOJI0CAofb8n1XYm2TMBvOKZUIg2gvJeG2VW969K3U4euZQeR2dF/RF6YEhfdDuYyD2/K+4ZeTYS2MGIUmsJ1N78xXdaUaqAx3v65IxqUFNJAJNkwv1TZNZGgDuyuDMtQrVBE+Mroh3/WjuB7XPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX1y9NEXgWmeT+/fz1Nkf8AntWKubFG7u45umOWIrhg=;
 b=BsiRnL1X45bdfrbs7vLaxJyZwLankoR1I83CkwTkAmdltFA8BCZf+hJxdI0zEwbwiET2rSVnpYnzORSc0wGr8jPjpjz2FKx/UW4jXj78eoR+SfJTrbjWs1gLYpDiK3LycpGKdf386LtcAT9i07OijNeTaB9R4rP8JYzSB5XRahiYe4r8YCGAYHLq/WvamufqpjmQesUl1yTSsJSbqdsjqeufnL4mWr7dUO+35Vj1a7MXL/QXdN7pB9pOpT8tm5JAUr3tbbgY1E/cuB4D7snpozY+xYrBx9qCDkbPbXhNByVCcoqxzKMFU649p5Q2Y1fQ9yvIxinUVbdOJs1AAZ+Dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX1y9NEXgWmeT+/fz1Nkf8AntWKubFG7u45umOWIrhg=;
 b=BfljLL9GRfef5uShZ1gvAGQbf1zeiAa/Y6kPIodsiPyOIVZj9tuslENITUI4DbHgIlq0481ehqm4qQOXm3+hmnjj8oeFt0sL8doVsm3onZndrjrjPizuc8pXI1GmJV3b70v9eXHEw7hkwZy0Jgbhs5T4woT572GSfB3ta5oBBTU=
Received: from CH3P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::8)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:03:47 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::18) by CH3P220CA0015.outlook.office365.com
 (2603:10b6:610:1e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 08:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:03:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:03:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Asad.Kamal@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Add basic validation for RAS header
Date: Wed, 26 Mar 2025 13:33:29 +0530
Message-ID: <20250326080329.410009-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0d4e94-f511-4bce-30ef-08dd6c3cbbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CF/ORwJ8sV5iyahKv6A8upFnCztxtrz+ckEK3vFnZLBjPYQZqn0XsSx0A60v?=
 =?us-ascii?Q?jDpRhXm6S7ZDGVLqPQDm41EVQtWJjvHOzKYZGzbd7rCRSAIbd/MS+A58ixb0?=
 =?us-ascii?Q?ZWBvz/i9qboTUNk2PSEfWGelC53AMupN9IMljhHZPMi9wP6hRaLU/a1qY/7q?=
 =?us-ascii?Q?cTQtFG0WfR93t6To8hG4zrlYPdaHQ3NAWAck3tLIRMsYK9u8gRCcQ1W0x1sq?=
 =?us-ascii?Q?JUnrHuetLXA440W9H+rWPJxQgnAlTnjJZS7/CR0egsgTW6hNapqMi/v9SXAY?=
 =?us-ascii?Q?jIBBvS3N/KPfB7P3LWRV0nc2ZiyB6gC4Emb8a6fYW9SLKvAuPvk77z0F01+T?=
 =?us-ascii?Q?+YLSNE64PKJD2myurkN0MPnTnW4MdXzo9SEuKKDCOsUocuaRSOCUMChM7gT3?=
 =?us-ascii?Q?v4N5VJnVQQN+TxJ2nzsrB0EKBEtWYOrAvni5+BSn3/lftqy4ji4nfkBVoFsL?=
 =?us-ascii?Q?Ai70WfPWqS3CTeEMr5WibMAAXYHVBZTfmt6+OcL9StL7CGr03PwHyLVlr/VT?=
 =?us-ascii?Q?i1EYO+zLGzwqmvB2aFSr36pfE5nOCJ2ydXoGpaKMrxc9gkusLEbMKlu7bE+w?=
 =?us-ascii?Q?3d2w9tph7xMkMVs2yKHmEOzAFoKqBZ1U8Aun1wR5+1UNaXlGy0bMOvs3wy8Z?=
 =?us-ascii?Q?qpY67/EHxXpUNVoNJL1blKAD/l5yp73hz/x1tg1XNTKpqSRrftM3OxgtO7fr?=
 =?us-ascii?Q?p0XKFzQq0gr9ikygwAs48ULmKODT3YvKapM9vUL4/ACHNyWztJYLv5lsc2fd?=
 =?us-ascii?Q?6p2LzQiH+xbI+Gj891tfjoa+okkWl0skq42ii4Cxs2p4DSEBonH8EH19wGnj?=
 =?us-ascii?Q?KOEA0ar9ULsODUYwGwqjY9BnsCt6EA47RFguOhbxumUB1k6/a6KyGYAVroeY?=
 =?us-ascii?Q?8Y3LXwVkA8I0gFJPlEErVLRd28N68jBCPZIUKifOKGzW1DDgxupR9JqvnhoL?=
 =?us-ascii?Q?ej705wXGkA7NP6a0FcdNTilB+DLsktOX5JDXBai4++pIyJVzjxRzevkjbiB6?=
 =?us-ascii?Q?oMA7/M0pYXjW+WemTtSqSfFjzu4IKNjWCIgT7uZIy5+jbdBIVKy6qbItS37W?=
 =?us-ascii?Q?YbUCKXxmHW+Ndhsy5p7ruGNTiHRBLHs/7ErTg+ImiX2SCCMvmyhU+YxTVhBt?=
 =?us-ascii?Q?T2G4It6BPPBrQ3STYKpM8iLE8e++bu0SxQuhRvjA4Ie7XfOK8Fzt/rXhIeKI?=
 =?us-ascii?Q?aUAyScfe/HowxhstXvZoGaw0ZG5jg8UZQ4Am63ZZSNSm8mGVLLGzg78Yj/Gk?=
 =?us-ascii?Q?S6F9uoT2C+uG7/6TMiJGaqNaaVQM7o3S587XY07rQeN+JYe9K37jedOaI9kV?=
 =?us-ascii?Q?nzg67TLgjGuhx7LdizZpRLINMjBiH1ZTkc7xhglbZcm8rEVYg00L2XwL4PxJ?=
 =?us-ascii?Q?bVyZYCOx4zPdE1JtVWSXmiLGW1XF5GROzdWlMUfoJ06NsLBeRpGXdx91rOeK?=
 =?us-ascii?Q?kW6AnkIeWHO4qldVJxLzdcrwcMf/0fkkenocrU98us6CN5OPHQSVmWm6sMJK?=
 =?us-ascii?Q?DITr1prfT3GhhfY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:03:46.3164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0d4e94-f511-4bce-30ef-08dd6c3cbbf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

If RAS header read from EEPROM is corrupted, it could result in trying
to allocate huge memory for reading the records. Add some validation to
header fields.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0ea7cfaf3587..e979a6086178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1392,17 +1392,33 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 
 	__decode_table_header_from_buf(hdr, buf);
 
-	if (hdr->version >= RAS_TABLE_VER_V2_1) {
+	switch (hdr->version) {
+	case RAS_TABLE_VER_V2_1:
+	case RAS_TABLE_VER_V3:
 		control->ras_num_recs = RAS_NUM_RECS_V2_1(hdr);
 		control->ras_record_offset = RAS_RECORD_START_V2_1;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-	} else {
+		break;
+	case RAS_TABLE_VER_V1:
 		control->ras_num_recs = RAS_NUM_RECS(hdr);
 		control->ras_record_offset = RAS_RECORD_START;
 		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
+		break;
+	default:
+		dev_err(adev->dev,
+			"RAS header invalid, unsupported version: %u",
+			hdr->version);
+		return -EINVAL;
 	}
-	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
+	if (control->ras_num_recs > control->ras_max_record_count) {
+		dev_err(adev->dev,
+			"RAS header invalid, records in header: %u max allowed :%u",
+			control->ras_num_recs, control->ras_max_record_count);
+		return -EINVAL;
+	}
+
+	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 	control->ras_num_mca_recs = 0;
 	control->ras_num_pa_recs = 0;
 	return 0;
-- 
2.25.1

