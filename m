Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01EEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 16:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF55A10EB37;
	Thu, 29 Sep 2022 16:51:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8EF10EB37
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 16:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGlobBVbAS048elciQKoCydsdcYtMQtzQYFZUnGXFhjsow3wCE6EC6tbS/1VDIEXEVfHJ8GXd7xRuXZIOr0vojO13/EiQ1oVjr8DzhBRAvyLPtrExIewg3MRhU6V3TPjem/Gen/KmF7+5Pxo/3TD5ZhcXbdsIO3nHyvtjrrps4UtFweD5L0YUtZfeVZs61AeHI4gFwUL2o9u72yoM2oQ9Pv9j3AknTkc1yF06//n+L201u5dvGe1zgq9rX6+gmciwnjc6DjAPsE22Pib3B7LrjNU7xwkeWv6xBjgpYodIHrF5Yc8eRmCc4EK4XoI7SQ+HFgo8Oy8rmgzfdpVnmDSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MucQokt7XcCOcmFehsmngXsb96jIyjgeotVbmXFT6A=;
 b=R7t9J8wfkSOaSSrIBaMF719gN1+J1CXRnsR+quhbe60np9oggxqfJTyYPy4hmLkNtnXhKh3u7xCkqW2UeceuViKIP5d9XX6CGs7J8ATNo/kA6bKhce41HhJ3kAN7pTqCDo6sYtrxXYm+Qo6Fi1vqN+acBye/hiwTPcls20/ETmHLwG46je9qyvgw2dWUtbirMDpo6RU+Ipky7Y5KAPdo/QB45KpMynQO21tUdEhqXWEB7X3sm6E+GZd76VpQPVHKA6bZX2KQ1n74gXa3kRKR22g6iObeOlK0FcMcI4uRLukjRW6lzQRlSZP0JqAguZLMD4Of51iNXsiz4DiA/+2ljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MucQokt7XcCOcmFehsmngXsb96jIyjgeotVbmXFT6A=;
 b=La7sS9N4VWRo87TnPkc4sEEUKvAxLaiq3IC0/deiFfuQRuTfg55IvOAY6Qbja+4x3+wf0m0M7Wmk+ZyYb5+dC0fbSO1zWt7nDzU4qHlGHCb+qQUM7mJ89yxJ2rATeUTamcLRLJ03h60akcZyJSmF7dvg2g68FayYNqGnSIx8MNY=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 CH0PR12MB5252.namprd12.prod.outlook.com (2603:10b6:610:d3::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Thu, 29 Sep 2022 16:51:09 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d3) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 29 Sep 2022 16:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 16:51:08 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 11:51:07 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Enable sram on vcn_4_0_2
Date: Thu, 29 Sep 2022 12:50:23 -0400
Message-ID: <20220929165023.103134-2-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220929165023.103134-1-sonny.jiang@amd.com>
References: <20220929165023.103134-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CH0PR12MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 44349311-8e4c-490b-1649-08daa23acedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7S+Z4V7upBcIg1pqnLC2p7BKkWqtstpYtSRiFMNGQKlXn4I9xw2KOFtg0+QBFOojDKrml3yxLigexc8exEMfLbbQ6JGoSES8E16BT109qpNt1TefktohmREFZuN6p2g/+ACxSoI7Mhw4S4L1QkuYyHxEXhsUfqSbYMc+pE4HExZaKPveSzjN3cZhcrVh0QjPsNdKGvzguitIFIvvkwJFVjcNOywS7Q2rNiyglsvPkshZWz7utjeVysHQGPAuvS+6LxJaThoWtU908yUyReooGUhRKKIwg9ct/uGD5/ykQA5uB7nYRGt4FwXHur+zhQmP8SaA4yUUOaqJ8CWFU9ftWT8WE7sINpz6ef7/4v2W5mS5p/VO45+9+3pK5AU+EFjXOv8p6STeM1Gf2fV7highmk1tN4NvYWkgv4P97FRtptImmjdQRNgTg0YkCD0Ay4hhAakFMbLRvzCHIzIuTQB+oGQPWQ9pW1aUpvpOSk1hFfo5GAnYnFBsA7w+2cmzHvn4krXrJJpT+lzRcPuSgyqlEwCnHumi2m+5RO+VKG0lRwhclmCRYaTsNhgT9mvMc5B2L2eC/SkAH0odGeRHuSQH2gWs/GCFsqsVRPfPBVszzwgOe8elvfNxVm6czfoLDTjJk1UeSdtDy/EItwpMGNP17YWuor3JAc1DovxInFvLcqbN6gIvv65ruwLQcLcTLccdBToUkmqoRC/P5qGg+NilhwbJnj1w+geqtqT9Jtn5dR+gqGCXOsM3PioSDfbbvjBDk6UiDf6MNLANH+/dq9fzEL3TohUvNPVkG5aBCJhZUY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(70586007)(70206006)(40460700003)(356005)(8676002)(4326008)(40480700001)(82740400003)(316002)(81166007)(426003)(6666004)(47076005)(83380400001)(82310400005)(16526019)(186003)(2616005)(7696005)(1076003)(336012)(36860700001)(36756003)(86362001)(478600001)(26005)(44832011)(8936002)(4744005)(41300700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 16:51:08.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44349311-8e4c-490b-1649-08daa23acedb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5252
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable sram on vcn_4_0_2

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f36e4f08db6d..0b52af415b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -191,7 +191,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		fw_name = FIRMWARE_VCN4_0_2;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = false;
+			adev->vcn.indirect_sram = true;
 		break;
 	case IP_VERSION(4, 0, 4):
 		fw_name = FIRMWARE_VCN4_0_4;
-- 
2.36.1

