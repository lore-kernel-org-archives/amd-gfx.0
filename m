Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8043DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 07:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EC510E251;
	Mon, 14 Mar 2022 07:03:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E7C10E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilaCTXqSdiTGE4Fiw8hmBqHpu8+crpcByBsejkkRiSIa68SXv1A+dtaDHQ0tALassDhiM4at59jsCVu2Nbm9bD2PTsD02cFyd6tICs3fWnNrNKold9CMP9dv5KjmQo7rUlKxa3n33wt4rtg15eYxSQWm1/hkgEc/iPkAukR3ehHINS+UGchPeIBAa8olmPMLLeld9HoFOQmB9U4gHizwivEQIbqu/2+PHCPTCRXgnR9V2MRIJalsAcX8oP2fKRGT1vHXyCTDioEQ3ZVT63vRiBJyG/d7j+Ak6FgKXF4h3sTT6ZDhL9SA9cGq+l3nXkQkWPWcErO3Sn1XE4edLqADvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb4NDTGeAJWPq8+evWHY/nIHvzx5snQJ73Mzb52DFvM=;
 b=hGNs6x9QIKFuK/2UxXR+jaqCf4YSML3McqwXyu2Zc5kg5o9EcCii4/ZYCu7GFVqmUaxelF8zq2sbDUOQh9x3lkH6Tnadz9fsOzzmvp201mR8CTtVzn3bFKWvi+joVLWR2xFcfqkTcloa2RFtw5qJtyyC76XFhMuilarluyxthcV26Twhq47S96ITho3X8FwFbValmmrVj/7Wau+alF9bQFtrMHpJvT7xfC80p1Fo/I6FU+xQ25IXjPrhizPxiTctEDLH2GUtH3so8L88GresPDCR9tdnhDmjnnCqSr3I0wwaURfx1+qLWklNCaEVUl+RA4dp6G0ngmG3HWl+eib5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb4NDTGeAJWPq8+evWHY/nIHvzx5snQJ73Mzb52DFvM=;
 b=xGaNuY8giZp16W9G4MndXN9kUW1tNziohTLBapOBbRxqAYp+dMCCUyiePyT7e0VRqOn5oEtgtkwUf1zv0HilJLNOv9FqIG3RdHL+uvLC77QtN1/Bq5ovdwf3OMWjFOLGYrEeFrg9Lh0oiEg3k5aQcOXAVM8pUfEL2CECHaJi8oA=
Received: from BN6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:404:13e::22)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 07:03:45 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::f3) by BN6PR13CA0036.outlook.office365.com
 (2603:10b6:404:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 07:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 07:03:44 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 02:03:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: update parameter for
 event_interrupt_poison_consumption
Date: Mon, 14 Mar 2022 15:03:24 +0800
Message-ID: <20220314070326.21828-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c4b98e0-8614-4bb2-d24b-08da0588c7b1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5121E0391D87B2BFD52ED220B00F9@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThfE1S4PzxvWpK/v5UqL301gMKTdlVabG3xampiQbFm+1aSEyJo4LGEn+lpeWi4rrwrX9hVNpXv6bhzS1lRUQW3DnOkcG7OedwKCXz9+ddGPx8itg8vg9GAXlflLhnVA3rOYxEK8CFEdlBCrBK5uARiY+hlX2jQ2xoJij3OvZcUKG/oRelQ78KmPbKNF9fsdLZfhlnw0+fpbi6oHpfnK3Er5eddzx9pxG29v6CzH9rZSzSUaZyDJVR/IJUfqNkOA7m8jfLCBO8vVPZGJlSUkjKYYMw3vMr6/8F2NIajQdnV//Crv4bPEdXgSZ2UQiNNnC3hRp8jIlDrCldN2glg4IquWjAeOBPw/Lnklk5FCZl2YpduGDJW8PjsjhLOtv1u8rjM3IHOX9oTNWgcysM+UCotmdPF7KqMQrJFV06q14GpM5YmW9/Wg4AeOwee9a2bFDlwZeIxQr2T2AtLvJCbgxrHMLknjCAWEhAhEGmpBnwl2G1nAo9TlBwxbJ5o2FplyJYmvWf+I0jE6IfNu+w2rZgrGaTeheV0Ne81DDBi9jwkHMsRun/5qaRrSEdDz7Y7QPjSTEuUMyFb94kcEavDOMIwSOz5UN0sIf09sweuUfhlkaedUpSd0oZ9T+vLFwerW2aFJ6vaJ55/nQqnPA2p+2mSkrU2OH/OxlQ9On3isS/HpIgSbvGt1st33MLqOz3HBO4FRffr5w4zIyQg7s9LwSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(186003)(81166007)(426003)(336012)(16526019)(356005)(2616005)(82310400004)(86362001)(6666004)(7696005)(2906002)(1076003)(508600001)(47076005)(70206006)(4326008)(8676002)(70586007)(5660300002)(36756003)(36860700001)(8936002)(6636002)(83380400001)(110136005)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:03:44.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4b98e0-8614-4bb2-d24b-08da0588c7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Other parameters can be gotten from ih_ring_entry, so only inputting
ih_ring_entry is enough.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 7eedbcd14828..f7def0bf0730 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -91,11 +91,16 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
 static void event_interrupt_poison_consumption(struct kfd_dev *dev,
-				uint16_t pasid, uint16_t source_id)
+				const uint32_t *ih_ring_entry)
 {
+	uint16_t source_id, pasid;
 	int ret = -EINVAL;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p;
 
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+
+	p = kfd_lookup_process_by_pasid(pasid);
 	if (!p)
 		return;
 
@@ -270,7 +275,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					event_interrupt_poison_consumption(dev, pasid, source_id);
+					event_interrupt_poison_consumption(dev, ih_ring_entry);
 					return;
 				}
 				break;
@@ -291,7 +296,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			event_interrupt_poison_consumption(dev, pasid, source_id);
+			event_interrupt_poison_consumption(dev, ih_ring_entry);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
-- 
2.35.1

