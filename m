Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F069CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001AF10E604;
	Tue, 26 May 2026 08:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TTsI4SwQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C00210E617
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEiYrOMnceN0VvM/FyV9Aj2QfRdoQPIAhG1xra/EuciIF51Zvi62qnViXOfHZKYhDXCWgLhrBSbwYjA0nGvWERK3ANNV8FL+nqork5ytAgMUFG2ZGb2TMsFjcpDC7XQB0ubCxygi5Jx/n9OIQMcu9u2rrC5vDHj8WMzWWWvng0xZDzWfAcCygPpr/m2NWk4ICWfpUiAYZlRntYac5zsue8ge7icMhb+PuLKeBSh8A7wVmEOrbK01WI035M1j2l2c0kB1mQcH6vrvEoBm7rMwud1f/LGV2cCTkZmH8D6Qbulq11TiXalnv2Uhbxnc2cUWPpP32DZlpnKe+yfNy6wSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrvODSgCxQvZcxZ0JVUscGNM8NIoTax9HSKA1MSEnxQ=;
 b=FfR1b9uyBaOzuGLfQFM1jui7pGEbduhMwzS7K8D/sPi62Nz/sgflxlhbGKr6ebchUwmJVPO252qZwJiNRkdW7FDKbJkS6T1+RSCZK6bzt9yXFQ8VfXDNRsGfikzxJj8VuT6AQ6CKgFpHS4ry6ZqxP2csltcFL2JxihACrwfuDuIkpUMdjSBJ+XNC/Clwy/7VR3sXexQYIgqetmV5ueTixc9m+Y9EbE4qZXIgCFMseRfM5PSw7ehLIgrpOQQc7H7kGQis+ObP124d8/h0ywSC3Tp6RclR1pT2Ljkubvl0Hvc9ZtRlH1fosdDW8WpTxaqHgEKHUlRAeD4gZZdaw9bvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrvODSgCxQvZcxZ0JVUscGNM8NIoTax9HSKA1MSEnxQ=;
 b=TTsI4SwQnmVOaeaxHlbemdvAoDFFBMF189k+3T8m2XzE+g9LImirfDBcYMpwzTqsKOxoAoWl7JDRNAbKTjSrI0qVtiYHnRqQNnGHZSIvt92P6XH2JQXbea6nasOBmj0TiMbXnnK8RlWP5q16iXKLsaoISCdwF+BRKUIFpaQjbIg=
Received: from PH7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::35)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 08:26:54 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::8a) by PH7P222CA0008.outlook.office365.com
 (2603:10b6:510:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 08:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 08:26:53 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 03:26:51 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2] drm/amdgpu: improve the userq seq BO free bit lookup
Date: Tue, 26 May 2026 16:26:42 +0800
Message-ID: <20260526082642.54856-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfee177-44ba-4141-7dd0-08debb008ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: J1YkB+jwPi7jW4MRnd0bP/mDxYlonNC3z6I1yoITSpe1R6HtDpig7YpDMf65y9mFErK4MbNw2Sjyjrf1TFR42PL/yriUXbepu7GnQ44HX2bCGSgL20G9laF5xX4VUXzJvoSvWRZb65zxkubjmRcldoEGYAKHVpzwg+fFvhjrQ36QYDbbKULFHsn90eTHkbJyhyVfzrZ1Ry37NhjNC4AFamjeuxMnTyiGuE3g5zjkjSeImGPm+7YmdthXwssmn2RtnJ0woBmkJsjnWdzwEEYyDf6/WrQl9Lz3yeZPUYpspREEoDKPMzT6+DYAL1CZQtC+AE1eu0TR/oiYS4D/b51RxOmClGTX4zPDDox7WroFcoi4AimWvXk88h5aoqkWbl4NmDgxJZjc53PFCVUZX6PR0AHGGty7qJG3/YXy8Oeb0OknI1fdO/jMdSd/PdB91Old1S4Eab6EFIX8JxRm6ZHIkZdqfi61Qp47ZE6gtCsuN9SiAhSpbyrLhkvgVH85pnnwu1bgf6VJGkiSqu+AHJ6FBdGJUb9dLcJ34rGnVdLJWo3phXth3+UqYkxIMeibnD/y+trIR/5VFkHHXxoJN2qbZHtQt9EYvu4tC62ht9QdfcSfiadIP7oEHV7AebmKygZUZp0wvgzxj2htXu+wr25qrortE5onOwDDs7BI2Q7LrC1NwzSda7dcV4eSR55MMAuAuTbM13oxOjXAQAc7AJZ7x51MOkjc496TEL2yQN7WSgk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1wdPbIGa+yixJROdzIwynSHJkiEwWQ2Qj/rxR+sgHUeb0Oh8wh5eQWAmH/PlAILQT4jk05x4w8NFJegs/iRU2FMOO3z+Go+L8dMBDS/5o6zqQhZ/9c/IlCdsjI6wNw6OiBkHvkr4qoftkOKzVPrO+/1cbMysGGQmc3ZUeZyQ6hMGkBL8iXWSNgn1CcWTrDmmRhk1DZYFxzlOmQWG9PSrusFsIyVfZ3SGpybeiLIF67QqdRNq9OHiNMl4Czvv5YYuH8Nc4H9IvDkf2Kvih3MLwaSMO2pN12J5c4ZNadWEliyNIOAMG/gsx2ggOtbVnjNs6fjNBUeuj/V3kuo7iZIrXO0uajTbKR1xbFd/AaKUNpQoSQTLE+MGV4ZfRkmmGuIfQnGcr58VoepDTXAtuq9ebApLX01SpVDlv9ioSh455od2/0JVLGtuEbQ3gv4SeTIh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:26:53.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfee177-44ba-4141-7dd0-08debb008ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
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

Use find_next_zero_bit() to locate the next free seq slot bit
instead of the current walk, for more efficient bitmap scanning.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index f4be19223588..21a225b0116a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -173,16 +173,17 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
 int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
 		       u64 *gpu_addr, u64 **cpu_addr)
 {
-	unsigned long bit_pos;
+	unsigned long bit_pos = 0;
 
-	for (;;) {
-		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
+	do {
+		bit_pos = find_next_zero_bit(adev->seq64.used,
+				     adev->seq64.num_sem, bit_pos);
 		if (bit_pos >= adev->seq64.num_sem)
 			return -ENOSPC;
-
 		if (!test_and_set_bit(bit_pos, adev->seq64.used))
 			break;
-	}
+		bit_pos++;
+	} while (1);
 
 	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
 
-- 
2.34.1

