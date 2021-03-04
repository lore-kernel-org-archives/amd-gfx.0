Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BFFC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A764EEE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A764EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748BE6E466;
	Thu,  4 Mar 2021 03:58:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731ED6E466
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 03:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8S0NuKfwY2eLzEgFIU7P8uj5ltDWSlJA/ZJUe3jRf9Pk++YT6uKdQEPCPOmH9nYaH7ZfFmqlW001nmhERLoM0GhGzE2SUwcw5CmydwnKWJAnKw3oXGIyEouPgvZsRQ6xvao/M07hOfL/7e9z8giC/9gFabrQrKBkNzE0R24jJisTiNoGh/hvLsUPJB0YjuFFzXOr1LF2HqpGCu5HicRdfw3hAysbbUygDlI2F9emremu52xPCkfpKyYxNH8raMccJ95v9E0rEpaqW+M7rCtYjH4hmcBuQ2AtCoN4nSiBRmIqZ+uureg4fZIZdu/QGnhfvZ5Difxpk3R1DAHc3FQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iawKDt6n7TNeuE3vgVZI5hAu4c2M4lRdkLT7VMiQRsg=;
 b=iAV2LGXu3I2GgGPCZBcYbGZmPwg5tVy+LkiJvCPdCLX0YRRuto0KSalqVp3MXUlfGcNKobmHgHqmA5QWlkTRv5Sw54hdCo6gIvgtCwXP3Gn/KwgsYz4vKjZCnqLYolGcSLH8R5gsvZuhfmdL/ui0SNhY7UED5VRMM0gGAU/ThRRoEVMykGOusgvdD2lEdqF0STdUQH6egYW6Y0h8i+NlkkEAdecbsT36wCXxRn1cUjLuPbi0rGfd1+T7LL14KhsJObDMcEtJAPO7IOx08ELC6J88BJCd3s+U2QWeePx4QCVt3wfd5uWZrN9NK8lujmsMNnT7nJmM5wsjRMQjnAX63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iawKDt6n7TNeuE3vgVZI5hAu4c2M4lRdkLT7VMiQRsg=;
 b=jjHQNzKAHn1g2cohB/FA7rrCJ07OuRkOtvDDUTTFfhBK8mLJ7dMTX2XOBqHuK2rt4x6H6IXSl+SBED9b+CONSUxKS+JLdw9sAZuHENQyA0JOW0hVf9uevG0zezNkikQkg85n7cikINn/4nqi4tQObgCOMpqbwBG9U4cLDQLaIlc=
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.29; Thu, 4 Mar
 2021 03:58:29 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::4b) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 03:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 03:58:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 21:58:28 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Mar 2021 21:58:27 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Date: Thu, 4 Mar 2021 11:58:24 +0800
Message-ID: <20210304035824.37796-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99cc07f-6998-4547-1bed-08d8dec1c501
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:
X-Microsoft-Antispam-PRVS: <BYAPR12MB279076A0EEF24D9E840E5001FE979@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t53+wsPkHaTl8Hh5716zBGawC8Pb+nYRTc/djTq+pdAEMXlSoTfBD1W7WGzO3+j6xm7QSEQFU/iML5dCm0zaqb445fx+CB9hXc015gVKsy8VGhbYDUS2jnHDzozz7/0yw+Fb2doH56rl4ASeKOUwRxCEc8ZdMNCIghSjDR2rv7+3EBEcLrNYg9kWf5FJmuP0MH5iQKtxRjSXtOR8yD5ShvtzyD42sYA0KtvudkQXSieUppliVpLcjQx/Hkm4xXAK48YODOFS07cD5SrYf68miKkiX+OInSyA9XlR2iVYXg3MewlxkyatGQGyc/0vT79jg6oqf4sBD1SYhXL9pKF6FX2u1FR9fvZ0hOqXaNoABe5la/F2mJNepDdpDsUzXmQcZRdi6Q94elffEYBp8261xAz3+FTcg5fz7LlMD1fXKEpClx7zJo6qLYgw1+R2Ry1NG18rgKb1dnQFZgJAsZgCbZkUfeUmh4AUTrlw84dxlVc61Rag9E21nZx0LCWzvlkDsCQrEVJlUFkPb2qT9joXJBirlDWyC62EpmSav719YrBXGWvFLIguEcEOhxAOmRms17/rY4pZHwTyWW2DurI/0we84V1JDFEPK2tDDtUOO6meD3pihm8+mb69qHTYDtDdtHWO4QJxmtpvUUhquFw7aArqVDit2+2CGKLIUSKTq6Oloel0lZYpMeC7cX6VDQ2D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(36860700001)(4326008)(70206006)(70586007)(7696005)(86362001)(4744005)(2616005)(478600001)(8676002)(336012)(36756003)(426003)(5660300002)(82310400003)(82740400003)(2906002)(47076005)(83380400001)(316002)(186003)(8936002)(6916009)(1076003)(26005)(81166007)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 03:58:28.5675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cc07f-6998-4547-1bed-08d8dec1c501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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
Cc: Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..f46169c048fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,21 +2271,11 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
+	if (adev->asic_type >= CHIP_VEGA10){
 		sdma_v4_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v4_0_update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		break;
-	default:
-		break;
 	}
 	return 0;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
