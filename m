Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1853FC624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B95810EAA0;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyRmEjPA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9E310EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0UM006J+3NqjHkPQx81heJb7/bAIYm18TO7VSPJAkrBNxbxYDVXJvvInbZsFVveqpGTZtYKxJZtFCm7DUH+AGInM6tYlyrEJBzvswX9L/dztF87eYunyBq488PycGh5X/fYB1gFJMIrpf40hGrTMH+uUoPCp/yocmG7u6YinlblrOb/NRVuEeQG35KXegyWk/W6+gi8P2le2WPp/o12Mr7Rx/xZdprNg5Z6QSmAdWk4mx2Sv7NKUEuk9bW4ZzgiUouXKkkOM8Is9xueN0I2WZ+kzvt2qr9EIEV7p0uaQinXihnFv54MR7lgHmYS89luNdXW7ztnabsq+1iZBcO8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A3CGlxZ6jkDatYiTwnocksZeQRMHr2I41UUOEUOrjI=;
 b=aK2ofbuw9aPVQTD0I1rW8hbR6Dg/CU42AQn1f2as8SZ2bxlPNKnVxhZeGmCBI/YvMSUJxR7keH+zC6/sjD3InCb6/oCpRTS3ESqwEm0oj6n1z3IFfVQRWg7DQ0br1rhBS4tpNIsTLL3s8mJWeDa6p+yZ6ppYuD2hYCxkIFaUOPeI1CqttehhO8JhQ73Psr/g/F1lnJY0/2QuGHJtJFIsgnorkvI/Pwipmq64DSrvgVKndE/Beiz3Sqc9oRvrJ/4sT+ZpFu3vw2DtCslK1ubmwQITIz3+IDX5TRNkU34p6c+GSKCefdeoFCrkHOLnbVX+6hTBN29NqIO+G+19Z62sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A3CGlxZ6jkDatYiTwnocksZeQRMHr2I41UUOEUOrjI=;
 b=eyRmEjPAM2CfRvSrGDk30otK4bIReh5e3zvVaTUHqCpb2dNFVaGho5YGWhmepvDovlu+YI2/6gHME8jz73AVyCmQisD9WM27F6raS5Rxt8iK+R3sQ8mNMg8VWCVmfMNcuZcAR2pOYTSZ0uIV/euMeJ8rLMUKNFloPkKlKiw9vVw=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:58 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::7d) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 64/95] drm/amdgpu: fix NPA-RELEASE race in UALink exporter
 cleanup
Date: Mon, 31 Aug 2026 14:27:23 -0400
Message-ID: <20260831182754.1089811-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 3611f298-5df6-4054-227b-08df078db892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sVkigv7FooRzBy0xzZxfUYERRwPjgKVJNdz7CV1bO5GsupEmlNMsqipxTlm4kRnfXd1AVFXQFzRiXVEPQF6oSYKvba529FiUUJ+jTfmp8Pk+yHsRzd+C0DkR5PcDXSo3zhyq+RBUzaBXDB2JjND0K+HmVv8H+ajQ00VJeBxkCHfWc1Hlu5ffxgcg8WzemrTzA6CsGK1iyc2Vi3ZAq6X/DOUgMABn9D0JHy4rYoaNmZg3CNbY3w4lTnMF0ElZORc5Gve2rextpywtT7KCtqfcpRk1lPaTeoXAK40jIoKmn70C43jv1vJYbztlT3sBjcKmhpLHEF1tFALx0JUXEaVB3XL/jL8+4y2M1aHrP3FoF4Vtnf8iQYT+/NKILvz8Kk4aVPDK8tEWfTxInXCyZ/ofsmjmXDjO3AbpO+yHUIMUv0FZkeW3paEboVy6Y/jtnw9PSG1NE3CWOOT08QJJ9IGYhlZpfXgA71c24k/LpN4BlSwd5Ex7tN7Nq4CqsJX0POuTYFktVZtqghNUbmE6+aTLsJ0SsXpCwsim3i/0AF/EA9jdEkl6f4ik7PgoefryLrotv5c76SzkCvOHAehJiWqlTJhW65VjMGSYxsV6K2hi6Q9opuXhzPGVCL0N6XZW1rJrJx8Y6JJhmj+0u8Py8vVx7kvo66k64VfKcFQ0LHM06zcfZ+pro3jC8ov4pDco2Jga6xjQa91BKF3RaC534FuG5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JTCkr0tHrdXpa3hSXmh6bEWyBJJ7qbHPaj0OhgvM0h/WtLF5vyAypA6oXZ3QrH+oOlQJN7nBdtpIZYQHWk8Hczm4leyEDTtYmU45FQiYUR5LH6UtVOWdQ0pS9nXh2T9lRbfDTwYm99AY6kaQHXGeWk5kBK/U227z5D88SzRfH6p8pXe00aG59CZhfnw95qIQcZ1MAPWDK+PTcI4m7BsO5xhBb2XT0tMYan8ZUkrzcCR6KZw6R0V53CovwadjpNz/BkGzVnLET7n8lJs669pXHgm/WJmt3HhAa5niOREfWA7qDPahURkMkrgQzORbVo/DnsdAkb1w2W2pe/cKouYPQWcxt1d46RHi4VgW1XWKpvMcKj74XtZgIXeXx+29wMVTaNj2nBgib0ZkaKmofOlKipjuusjHYV26/9mh9q5qqf5qpfjdNH/HkKaFGvpNlZR5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:57.7850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3611f298-5df6-4054-227b-08df078db892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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

From: Mukul Joshi <mukul.joshi@amd.com>

Processing of NPA-RELEASE messages can run concurrently with
sending of NPA-REVOKEs to all the importers. This can lead to
a race condition where the interrupt handler can signal npa_done
as soon as npa_release_bitmap becomes empty even though the cleanup
worker was still sending NPA-REVOKEs to all the importers. This would
prevent the cleanup worker thread to wait for all NPA-RELEASE messages
to come before freeing the NPA addresses.
Fix this by setting the importer_bitmap for all importers before sending
any NPA-REVOKE messages.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index c5fbc9776c3d0..ea89187750126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2315,7 +2315,7 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	amdgpu_bo_unref(&bo);
 	exp_xa_node->bo = NULL;
 
-	/* Send NPA-REVOKE to all importers which have imported this memory */
+	/* Build the full npa_release_bitmap before sending any NPA-REVOKE. */
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 				 AMDGPU_UALINK_ACCEL_MAX) {
 		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
@@ -2326,10 +2326,17 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 			continue;
 		}
 
+		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
+	}
+
+	/* Send NPA-REVOKE to all importers which have imported this memory.
+	 * On send failure clear the bit (no response will arrive).
+	 */
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+				 AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
 			remote_acc_id);
-		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
 		r = amdgpu_ualink_send_npa_revoke_msg(adev, remote_acc_id, handle);
 		if (r) {
 			dev_err(adev->dev,
@@ -2339,7 +2346,8 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 		}
 	}
 
-	if (!bitmap_empty(exp_xa_node->importers_bitmap,
+	/* Wait for the NPA_RELEASE to come back from all importers */
+	if (!bitmap_empty(exp_xa_node->npa_release_bitmap,
 			AMDGPU_UALINK_ACCEL_MAX)) {
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: handle:%llx:%llx NPA-RELEASE bitmap: %*pbl\n",
-- 
2.55.0

