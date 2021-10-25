Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25DC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB7F60EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DB7F60EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BEB89A4B;
	Mon, 25 Oct 2021 16:02:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB6689A4B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 16:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXxPlCyUWt7yfmVPshaTk9dzp0Mju95A7vgnuW0quciTfdbg0Qyh07fvKfQ9Mey2lqvlkz/rlRmZ6NLLyRyDDCVUTUeW+9u0jpsmOVUQGwruBP+ULwcn5FIi1GhsnaYoLMRqBkdsQl4pB8f9raWY/xPvKKAgbNpnI3yKtYmjh5bzRUOJE6bjiK7U8xeKKXgyqHr2SclXoVA3oBYQwv0cTnW5d8+s1yCKDXZzl08LSij2dN64AK6cGPX7LS8V2d2JtShQKsGEX2D+BUUBusncyecaF1/ALCoTy/eZRKQs+v+VEJ07q7gtrILxtVRubX4TXHEvDYxI7u2OJTEknJJH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+47ynF3Ds9ZF6G+UBguXqqlTDgYTKSU5U95wWAmGiGM=;
 b=Mi1UEqawl9t5ME+fmftVt+rcoaeQC7syAjSTtmiCaBvZolN4BUEc+GaXP8zCKjaxsvwe2rVqp02bFA3m5ym72THrn9ro4Oq4HQ6fI3rpVzIlQUy89u+5t9UKGmYmgr30gyg/sPECFzZGBirIY1m9mmK0+rDawOOUATlwmXhn+6/TbbRt4JMyoDFjAGfMVOX6ye2ZwfmL8hdASH6oB3ipTAlsqb22vrlxP/Zrg0Qq1p1hcu6SB81MK8yGlPAK6RVCb5mfhA04YZoJ/xew9Hdi8d+riACWZAEhktagsAftafFKXI4xOZfMi5Vt855LqPUaUzvB8886z0534+3hPkKpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+47ynF3Ds9ZF6G+UBguXqqlTDgYTKSU5U95wWAmGiGM=;
 b=MaK9NgExZDbxfReK2qj0OBTnOpBYj7jKNyc/FcMtgO6OKiMMJ9pRvz+WRopli3v5XdZ7cNo2tOL1CyZvYL5/UUY83ovEpQPdnJb9WvvcYhydrC1OP42XVp+jPFCTyeH9skdTWKZSwzn1zCEa3BWrYuFvIBH9B1ttpcnYEp/7BDM=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:02:34 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::36) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 16:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 16:02:34 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 11:02:33 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>, 
 Alex Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Restore information reporting in RAS
Date: Mon, 25 Oct 2021 12:02:20 -0400
Message-ID: <20211025160220.51401-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129212de-bb64-4739-b3b3-08d997d0dbb6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5124FCA1AAD16F74C6D7302D99839@CH0PR12MB5124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1iYAm/P2YxGN+xypaRQh29hdBQVHr7hoPS/3Js9QUfDsqkmeRBPbmS68Gae8iecv7ADDKqQuEEWVWKRVnZJjTIzK3a9Bse3mAntDnpQYHwyMbqxUmea8KYpwU6pPYGwMUWxKn6PsUFnR4SBgtWrcbP7G7LZl8yQZaaUwD4wnXkcFfqfAOfPqTTrGW2ETzF17iaTNNMNB/GMe9lO43nAFfAxUuHc+9QZnZOTiif5CnigvIuWCk6yXSwxguh9dlb58VcKqXDNAGCJR9ThAXc1hD4siPPMS5jVTRjZS9y9LSV7z3AQmABwC3GQWpEM3GCM7fsvkHe1IPR5xVJTsjsyM5BUzhGEZhIYoCzZU6CamgfFHoab05pMcRFcGw8onmvw1VJ2e1ecqp5na5Xmfl6295O1k9OtwYdCfEgmb8WYYJe/8wjdcPpbAQjcL0maJIHmRwz7a/M0xrE67enEGBe+YV4ZqalXpO6ZqxgmE3vdtL0R8hWWkNO0UkNfHCsChF5ONYH5glDh1FwvfenAwAKDsRgBr3KzoBa/Ar6S1+G69jHeea4dgwaCiwb7geR5xCUc7GMEqfvzmlI0IafNWVAQ1TqdRvARoZTvJe48ZxOEoGRGlV0aTur4H1je0wttnuABGy+GGotjmixfIWCKEmGpUv7NwjpW2HZDsRfUG9MGu0gZTXZYbkRdo4EKK0Y3cL5QwpjM6eX1Lfd22nj54kBifBZkzbzWGO2IuwSxN4rovKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(26005)(81166007)(54906003)(356005)(82310400003)(83380400001)(86362001)(7696005)(6916009)(36756003)(44832011)(316002)(186003)(2906002)(16526019)(5660300002)(8676002)(2616005)(336012)(4326008)(1076003)(508600001)(70206006)(8936002)(36860700001)(70586007)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:02:34.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129212de-bb64-4739-b3b3-08d997d0dbb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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

A recent patch took away the reporting of number of RAS records and
the threshold due to the way it was edited/spliced on top of the code.
This patch restores this reporting.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 07df2fb092d09e ("drm/amdgpu: Add kernel parameter support for ignoring bad page threshold")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index ae64ca02ccc4f8..05117eda105b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1112,7 +1112,10 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 				res = 0;
 			} else {
 				*exceed_err_limit = true;
-				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
+				dev_err(adev->dev,
+					"RAS records:%d exceed threshold:%d, "
+					"GPU will not be initialized. Replace this GPU or increase the threshold",
+					control->ras_num_recs, ras->bad_page_cnt_threshold);
 			}
 		}
 	} else {

base-commit: b60bccb408c831c685b2a257eff575bcda2cbe9d
-- 
2.33.1.558.g2bd2f258f4

