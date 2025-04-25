Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED19C369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2831810E97F;
	Fri, 25 Apr 2025 18:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L0NPpAWp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9FA10E33C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6rOysxn45/7hFxaVGIM3BQVAwe6d1elLMqOmqALk2HsggWG2vSJGDYA4MkSRoIDt9P0q7gjRwyZBuY2TbLJIripMexIIgSIUFHLU8LpJHfNRqGvMus/zH1XdFW9XAWiEXTQblsuIljimEnSHLdASF8JsqNoWjq6sxLWIs7hDF3jE/0MblSjyP5/QcFRTpoR+HdwFeTcSppNgzKeNFi+1fTai/TnTzD8O4mN63MfjKXh/5FRA8DT1iCs+PLk4sWDfP9+snQ2U/fityKd9M9/ne//5GU5uZpPslVjDJLQpEXCFV/I/aS18PJJLEKsSFcWmZa8PTDk2OwybHyPLEMlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjLc/Ga3IaM3UctuJmLoZ13O6j4ZVMq/uRX0jBl0LG0=;
 b=X/Ipq9d5tnPDWu3M8ztLMTa2eMDngpZ1tNdli/7M7fRa6J8ptWUN9wGOuWK5/nHCb5foVh5pwdwcL3f5Aes9dcHnwVbXdwtWSnq4nD3FnGi84faace/0g/tuvsiT7rNdgeqGQEomqe95NyerHGH/CaZ7UIub3fOm0m3YzVQ6Ktdq0ARawS4wj707OBPq5j64qoAS4LSCsIQZ6L/WWbB5UEZ9HFdPL3QY+vOlh6J+hSAWkI6hOldANGeB3l0N3CgVYEQi7wsYJp2+cd8Q+3LmELKLYve4C6ytICpfcLOEfLkk6LF1H6TWY15csQ1Wh338HUMpcUalFFDKj4gU7fOs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjLc/Ga3IaM3UctuJmLoZ13O6j4ZVMq/uRX0jBl0LG0=;
 b=L0NPpAWpjhlZfcaZox6a+eXxwECr+7YQy21ynjNlaXHhm+sinms6GHVUbvOo2TjmiQoGgFFd9H989wSrZnZrdfw2kx5UTdcvoG3tGcbw2XfcpInTPnGUiQVThbFev9V3kelya0FMIhvZN3BQTX4S4ZwDyPhgCXDvPckvH46Wq3Q=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 CH1PPF93AB4E694.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:39:10 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::70) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu/userq: add callback for reset
Date: Fri, 25 Apr 2025 14:38:50 -0400
Message-ID: <20250425183855.165199-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f5391b-74eb-4aed-36f5-08dd842877de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DeRl4l+iOgmH/UkCLSdCMa1Ga/jpcqQmuxPOFTx8dn1VceBpfpglZOF7nl36?=
 =?us-ascii?Q?afemMNs5Gk/UJ+zkhH0MR5rwCGPCtnN5uwiZ5ot6DOwjzQC2DKzbWa3WstmP?=
 =?us-ascii?Q?bEUuOmF8acnOwySNqOV2RMFURx/JE0hPmX5a1p8qLWDMnd4iJ19T9utYyOQ9?=
 =?us-ascii?Q?SfXfsFpWvHu+TrmX60Ifu/nClkNViensW5B3iXqChRNoTopKTUvWDeBftf/I?=
 =?us-ascii?Q?767jIvX5Mmu2vfpaaaJb/z/fhFoCWy19gRrCxu+InplX5EsTYlpZZWyngi9s?=
 =?us-ascii?Q?dx9bGfzIwgqz02k9cP7tgWskytLhaZe7bce35RgtmfcKz3j9FE7vf5AVXYDa?=
 =?us-ascii?Q?ldOoIpaNF1ZeW/erN9tF22KFzdsLr1VqMOidgIGzJ9Pv+CX6uaHMJig0sVr4?=
 =?us-ascii?Q?JsbhKWe4ovVp/PFIopyxtQ/DCFKoQxCQxAJgWlCRjNbPtivCjFLepUUsDgfY?=
 =?us-ascii?Q?7MxIG9Wx/vj/rYpc8KmWaiisU6zCD4eRk7glKnTBTJuGIqMs+YO5cHtsSZDF?=
 =?us-ascii?Q?5RE5vg39cbMFsIL7NgBe008qu8hRnnYq4wPCFdefcGTPrpXrVCrE1sIdiG2L?=
 =?us-ascii?Q?5s0KRwrI+Y5frdfWsSIRrf8WZP9A7nE6CIDqv4cf8P8LiMp4BgyC4i0i535C?=
 =?us-ascii?Q?66+6pfLNpDrxGz6tEV5N/4rzZc/S9jvUZMdGJCDLOCN5XRvgoHGJeWu2fTM9?=
 =?us-ascii?Q?Rtt7k+qQ8f+bda4y1vd7vg8+UlJGuY/qnkH+mBhY+xNHi4RUwY15jLBxq2GF?=
 =?us-ascii?Q?KTRjFRBf2+MjW9eE2X4Lccm5oaj5rKbzL8Bot3BDpDQ7RPNIxPQJY5RPo1CD?=
 =?us-ascii?Q?LIfBZqsTsTyNe7AYFu0qJb6lCP5YIgiOlVg1HbSFsoDKdefr0nAVvhBGftYd?=
 =?us-ascii?Q?T5GsFciVg3ckzAh1wBv41W2o9nEVj3DfVEexY9z5xLi1wXEgQRQg6oBZ7AAx?=
 =?us-ascii?Q?JDzIrNijQ4PyPX218poTc5WiC/ZG4sS0m41/mYaum2NThlI+Ds0TiV9vJe0P?=
 =?us-ascii?Q?7h9c2n6hvVZPMAShd2+W4gOp64L5wHhQqgTvl5eKoopzWht5T1IVbj/6MMQV?=
 =?us-ascii?Q?mvfNr+TXqDf3kOp3jGeHJ4Ratq5/pSWH9/dpXZy2Eq4WON2J3IWs5GtHMXfi?=
 =?us-ascii?Q?FTQEfV2T1OHKpLzDgedQ/WR5axe9ZgMBtGLngdMVfDczn1PVEpnaxT9yiimT?=
 =?us-ascii?Q?bpAMvWO/awl+IpWKyhPgzpDkucHGGOk+6kaHahzAXBNBllCk7mOHoBLi9VLO?=
 =?us-ascii?Q?GaaGnSmTkb/vLpwQks1XDuCAFpjuw2vZZBPjEboP5PCIm2BOk/Kv+S45pad2?=
 =?us-ascii?Q?pd5gq5Lk3BTz5zOkUT5yc6Yr8DVtQcQMFHo8h9vfEYgG9GUAHTKtN+vgxO9l?=
 =?us-ascii?Q?qxmqrobDrPkxI53r9Ia4bCngTlhsqnNkCyvP2Y7tO52HmJX+D5nsCiZbeYvG?=
 =?us-ascii?Q?C0C50kgEZTJaAi+HNoldGZZ46tS9lSoEfqSHcK+Ot7t79bbh0wOSDOILRQrF?=
 =?us-ascii?Q?if9rQNUEg08ACyYI2CDM6IRC8S3Lcum4y8ne?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:10.0307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f5391b-74eb-4aed-36f5-08dd842877de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694
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

This is used to reset a queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4d3eb651acf1a..24d201cdc9887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,8 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
+		     struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

