Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E8C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EDB613C8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 14:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EDB613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990446E0DD;
	Thu, 22 Apr 2021 14:06:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E945F6E0DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 14:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl3jf71o/xEnYUR0+Zy9I2l6QqIeH0KW28D603FIV1v9kKLJ5Op25MzY3r8d4jMKZrTP9SK5CZSp7teMdQP1fDCKhfRoe6NMx7p48AmK4JwPvqDWzo7Sjzve9Y6TjJlch0FgFwOuLif8zOQU/2EEZheV7gtE/IVf95dk+WC+caXg8LCmy/3VAKth9KQYCJn0vC7hHcBCjY/6RiYJ6zZbyBw32qpurGj8Qtm8MD3V9pALCTNTXEmtxf+0iF53UwYb+nwzaBpcIXi8gGCsATXl508oixWdeJFu8Idb3Yf0aCaAchXVoc+OUPxhgCalZ9b/rlKNd/OFkxL7RKoPN4ofQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEzSP1XnMXhJZ3j/6qdA+7LR7mvvQ/d4ppDdNPuF5B4=;
 b=MUcfxqM9744pwEjrkgGsTyXpYigSuF9mfJSieLuDVCCPgx0w6n6F8HPE4tfT4KzUp7KXIbTwlSj+3oBIQtKuTM7yVLMEpX4B+ZDVUYbfITDps5eKTKQQu7EREzyHu7fAGkUXwWFTPZSKCqK2AvUdgfaa1vgDcoIaTe4zxS3p/PwaqHXSDddyq4S2TM/fssT1I6sr8H9bAfS3CphbDynWrCChRAo1pDkVjb0BprQQQfXr4/I6/FKKBGE3Kpmt35EVUgChUvayP3hnXuebGwnfRmBdyqY3YtLHt/aV0qq3rHIuouzrfxfLJ7hVKT25EoBkpWyeuI5awNORU9WOfyEOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEzSP1XnMXhJZ3j/6qdA+7LR7mvvQ/d4ppDdNPuF5B4=;
 b=Hc8AhG9lDSoy+2b3CajrJFTs3PZp8N2H4JT25CWnF94RH/w7qLUjoBGB4e8k/9e/goIrEgCjms63+zuE1uSCLQZFZ9HItYiJxQs1kwEEgyfqAxDnet5N7fHCT0J9wJG81Dq1CpSUHnfKKskDUs+GRhTN5lQSp1NP/z+kkTnUllM=
Received: from BN6PR16CA0027.namprd16.prod.outlook.com (2603:10b6:405:14::13)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 14:06:26 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::a5) by BN6PR16CA0027.outlook.office365.com
 (2603:10b6:405:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 14:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 14:06:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 09:06:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 09:06:25 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 09:06:24 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: disable gfx ras by default in aldebaran
Date: Thu, 22 Apr 2021 22:06:22 +0800
Message-ID: <20210422140622.15260-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c28a5ea0-9b45-45cf-6ab4-08d90597d187
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-Microsoft-Antispam-PRVS: <DM4PR12MB537408D504F6C41261D10A01FC469@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdNKyKQt0KOHyvG6RikHbttEbrfaWqHztkDZ3WXvPDht/oyAH9clzpqHsDZWPs+0rEj5Q5Yq7NNKJ2QbDPuzpXu3I9LkNHmR1v+K4bDd8+S8mn4DlWFn/iEYKgQ5q3foV6z+SE8qc2GFQFokfZdeEyVoUFgRav9mHFhIRdvfrePZlgUOlHi0dqUQuO/j7FUkLDqu5l4ksDsjZlbpM+VFdjh9BarK9aXe3CtmbQtBF54ZijbApJSrDg1urGH9fos4hLsR5wXb6L86Rzp4705kZTXyM/aBf4I6GLEsoXvXJaKNPMvnTQsiiMXRn3xr4eLYTaus0QcLIj1qRMPMKtslHkgjP3v+TxsNReWjziwiPAqYPttsKcoETHB954p1PveBnNtR7YB0H0OOEnaK94LI7KRh/lrfTUntCiDcrpLqGoJi+JuDkwD/QkywOUBSttHL+MlWQMkWfKihsCbR2sywfd2DsAdsq4+rJBVJbEDhxfE/kvDWE/opNgwreAIH9uwrmx7Fp90yHTgMKaETI/vL2D/3xt537dNR37WNzJ06I8wp2qP73AI3MmtcQNq9Ri4N4AFd6t5iMV58h2QZoQNDuQAro/s7P8NgHI4/QD5kbVgj7sH2VNfxokwu9eLufol7Q0qKo+HxNTG4dH+RSnJnu/a40LcxfgeWbO/YQefBE15/RUwP/OVQNp3RA21tqhb8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(8676002)(356005)(8936002)(83380400001)(478600001)(70206006)(36756003)(7696005)(6636002)(186003)(81166007)(110136005)(2616005)(2906002)(70586007)(316002)(426003)(82740400003)(26005)(5660300002)(4326008)(36860700001)(336012)(86362001)(1076003)(4744005)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 14:06:26.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28a5ea0-9b45-45cf-6ab4-08d90597d187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

aldebaran gfx ras is still under development

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bb0d027..f62873f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2066,8 +2066,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
-				1 << AMDGPU_RAS_BLOCK__SDMA |
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__SDMA |
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
