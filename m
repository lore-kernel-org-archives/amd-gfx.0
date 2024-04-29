Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1024C19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C69F112C79;
	Mon, 29 Apr 2024 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3cPlhK6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8BE10EE8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw47hcrm/fieBVI0UPqlUHftT3UY5AqXifRrrbQ7qBjZf7Zyrfc+sjelIVPndKPP/PKqYl/bFwArLiADmJS0kzT2MsTOxS9pAXhA4xnW3eMbpdhduB7n9LbY0C5qjZqdM/9eNPwu35XMqb1FoEOKfAYaxG5bjCKlRLceNF1oULQaa7029y67Z36WAA00nn999XvqpUPNF8thi+wW8fzflQsm046DHmYUylh50j2OchZjEh98E/8ieKm5l+oCFlbtF+steXo8GJyIP4SGPtaqQitb3DK+bg5FUQcXFF9+z9Ox+GEQ0Dm7l0AhG4s8Douv1pkjGoSTJx5NuivKAoS8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3fDUB1SzMyCikKv2+4OY+fKmssxf29wdrb3zwfrw8o=;
 b=iqigEAaQl8Q49cnKnZ81xUw2iQdLxX3wa5Yk9aDLlnZULfICU7vR0g2zS8JydIx0RRsxrNIRsgocdRkfYIAI7A/LUN6szXTo9+cLdppKv/V1mg5eYn9vSDRTsY/PQnnG9LqZ5MdpWf9GJD8bEO6t1AbKHawsH6MKVd1/urGGeB0PcqiNH+RxEbHZt0Mzs01GjVm4Y4T4xkfoMgE6a7tUyoArrOq+3VyKNf/CpmXf44ZNRArBHaeK3Y1nqHyKLtlbUQinEzG8iDVx85UYeP+3BJrvu6D5tYJt1slqh7DalvcVcxemxQusHi6pDMwABWyeJROViKCa6Prz7RcSLf6vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3fDUB1SzMyCikKv2+4OY+fKmssxf29wdrb3zwfrw8o=;
 b=v3cPlhK6Z/1DuQxe6gN/VaXeDLubqh5zhQKON9zxHVzhSSOM4WnWl4V4LV/SmaoSKY2rH9k2oylu/ZUZUYbF+91mhu6RTrDfyPdVmZVyFAm1mYGfbd/x3SY1HfzOmEyVtxxU9OnKXOobfFH0VneQUXzb4hM99TT4ulwWZlTrdmY=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:11 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/31] drm/amdgpu: set mes fw address for mes v12
Date: Mon, 29 Apr 2024 10:33:17 -0400
Message-ID: <20240429143339.3450256-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e027f3-3700-47ce-5c6c-08dc68596fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9lje7u7MCo9KeuUec9zEp8rQ8XDCNb4YYAyCT8AGGSGx22fc3ZMXGBCNDGz?=
 =?us-ascii?Q?kxq13WuKDHmtAHRe5TLKRIgNkhROMaD27hqghFy1VVfZuodnGfIClNF3/cPm?=
 =?us-ascii?Q?W1n75m31DN9hnPK5AZzj2A7sQMai5fVBEqgvdMpQjYNXZ3VL/raHZ2tEMBGU?=
 =?us-ascii?Q?RNtHxTCnZjFGPf3Gi/InFTNWPx2022/9G9fTDj/lpP973JFZ+EC63k5D2+5y?=
 =?us-ascii?Q?fhZjI5AoQA9LbC1YDSua6EDxKqxqP+rTW3B6iF2nD+0cnl3UILNARmURBPGF?=
 =?us-ascii?Q?JJgg2HX0T6gDhg7vUxy8xDKAi/MmsR0DSGrY7a0KYVMsAGtZe8QwVpI8/Cs5?=
 =?us-ascii?Q?70wF5RalhYd6iHUMM/98bd6JJCpYGnw6fyBAM+mSRQx1Y/h7spy2Wdyks846?=
 =?us-ascii?Q?fBZmDbUIh8WMKlvWCj/1aQeIoKYi9WyA4gZ44xY+c8F5PlbekycRtYUC0OFt?=
 =?us-ascii?Q?edi3a2Z3KAW0DLDHz1rfD63UC91VlGs8tuKFWxcdCkDpi8E8SxUGGblnVl7M?=
 =?us-ascii?Q?1BFwZ+c4E5/v2+YB4BDgTuD14eRF1Z0Gzh6DMWh+fG02i/jPwMrWBT24XOe5?=
 =?us-ascii?Q?bZE81T7NTInVpr2EgG4AY+xr8m7HmrYE/mRW/1Klbsn3pMgN0TnQqOct3/9C?=
 =?us-ascii?Q?SMtskiiKLgd7JCrqBvk/GhTorxqmoAcep4ZfR1XBPfhmHcGYMUotEPwF5vj8?=
 =?us-ascii?Q?g6Bd9ZsXk4RWuKr5FwaqWaTd554mGEMi/vqW7k78YBpEGoB6YEpLZNukv8k0?=
 =?us-ascii?Q?anp4wccqKg81So838FXScBUitwOoeBVCSnN9g+4DBdSSUL0LOR0uSkcDAAg5?=
 =?us-ascii?Q?e/QE90myKTFIfvn26L4xsImGC1DdHsPP46UgXwx6yg9DI0YWfuWF0lNJ4xI7?=
 =?us-ascii?Q?igNtvn+DOsTEcvA+5Zdo0PdVOI4dUEb2FENOdICKc45xd829uypArhu5J6jg?=
 =?us-ascii?Q?jg81cJgjjzIcYmSucpunHAaWBH9VlPQaQew6OPM5fXkx1Eqmt9EvPiIoiKAX?=
 =?us-ascii?Q?/P1Z0wJ44uB2MRgU6Nn0/YmgLS5dCeOiaRe+73ICiajxtf1Ot7AYcsuZJUAb?=
 =?us-ascii?Q?cUqkeE3ZXHpM8MgilfXovnWYqWqBL7PTAMk0TZ5FVsNpIUG/A7i5VO6xzPOv?=
 =?us-ascii?Q?quN8BNmMKFSBYUTpxTnysDsqj5gY2hfV4zYuVMAuAK//oeLmbENtacebxoZI?=
 =?us-ascii?Q?UG/GwcCx5f70KF8f6S6Rz9tzmC/iY0RAhiCbRkL1RKUaV2ZqrKY5tIxuj1CK?=
 =?us-ascii?Q?/iU00LN9FItu0FWjm5AVHovE19RQvWnZKHT84b7cnGudkEd1UOPehnDrmcZX?=
 =?us-ascii?Q?lLPrTZPq5jOTSVZ7LGkVdhHRMU5X07o2t5JqVNxE3l4EEhU/fTQ+/Mea1GBo?=
 =?us-ascii?Q?76xWHPAF7TLmaDaQu1zc8ORFX4Cp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:11.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e027f3-3700-47ce-5c6c-08dc68596fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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

From: Likun Gao <Likun.Gao@amd.com>

Split the function of mes fimrware address setting
from mes firmware load for mes v12, as it's also
needed for rlc autoload.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 37 +++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 1bf12fc1f72e5..a9bf06ad0202b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -596,13 +596,36 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	}
 }
 
+static void mes_v12_0_set_ucode_start_addr(struct amdgpu_device *adev)
+{
+	uint64_t ucode_addr;
+	int pipe;
+
+	mes_v12_0_enable(adev, false);
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		/* me=3, queue=0 */
+		soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+		/* set ucode start address */
+		ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
+		WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
+				lower_32_bits(ucode_addr));
+		WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
+				upper_32_bits(ucode_addr));
+
+		soc21_grbm_select(adev, 0, 0, 0, 0);
+	}
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 /* This function is for backdoor MES firmware */
 static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 				    enum admgpu_mes_pipe pipe, bool prime_icache)
 {
 	int r;
 	uint32_t data;
-	uint64_t ucode_addr;
 
 	mes_v12_0_enable(adev, false);
 
@@ -625,13 +648,6 @@ static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_CNTL, 0);
 
-	/* set ucode start address */
-	ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
-	WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
-		     lower_32_bits(ucode_addr));
-	WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
-		     upper_32_bits(ucode_addr));
-
 	/* set ucode fimrware address */
 	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_LO,
 		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
@@ -1158,7 +1174,10 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 			return r;
 		}
 
-	}
+		mes_v12_0_set_ucode_start_addr(adev);
+
+	} else if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)
+		mes_v12_0_set_ucode_start_addr(adev);
 
 	mes_v12_0_enable(adev, true);
 
-- 
2.44.0

