Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A2BC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD07610E398;
	Wed, 17 May 2023 04:14:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2946910E397
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgCSO8SfEkzAnZWxBqHuqAVqL/+EUja1TOYxJK70j4PQJp60siynh8WerZAAAFhTe0A30SkL+WdnfJbXAeTv5EmmG1Fye9cm7BiR5briaCzJ5KlYMdZdvPDpxMRnaJN4fzSvpO1j147zVAuvVKiKhnxW+5zapPE+UNv2jSfCov+OzFDt6DmZgJ8+j3anwP6EPHtp8+LBTefur+ciBnBqeFvqtmbXLsYw6x8P1uazfa+H6W4XI/sAlu8igyOGsyqM6MXAUjJx6dnK2PEnLPtuGBowgpqJSDjTzPHF/0EEdTWJAt63RebmtJECLQT4jzwDtOtqTVFNHydwWGvmjAMlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F97WKyFwa1OsdDWo4epHojqiIooW3lWRBHVraIvpoLo=;
 b=NHypKjHRyWWIgGxlbD/W/XaNd2HsDPHWIMnwafCWxSmV4QH1Bx4/vMEzUoJCTFJSKNyUris4vfTLkqs8pa0RXu7eXmiOAP9awfWpXwh4gxRpDGnh1AJBBAhrVvDCMfm1IukwDXYSpIUEanFlgLxZ5Q5m8esCueOkLGebmHImooj9KXv5fy/OQTdHhsZr2gXqPzhZvZ2OK/vlVz2aRMVlhjtyLQE3Ias627hHxqliPSdry3EQm2I53s6xpFKu5CspWjlXk2nfx3pBcNLPMV9sFsfVjRoVvpF/W6e9KAKy5gedyVfMINC5QVCNGv3IJGTTuzyviTIZLYkCMFUgmsJfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F97WKyFwa1OsdDWo4epHojqiIooW3lWRBHVraIvpoLo=;
 b=gKWmcCnGKMiqtgpD7EruE/xipzE/G93Hl1+QNEsqpzdPshVTRuBxfYdu0/R9X94RHR/0IVFivd5Y5jPGOTq5gkvi0j5hMiW/MpnwpwF4+MfDbdFD16WsJEA8Xq2uKXnP6G/bVp9dOvwGzaPtYfO6xdojxzkBCUIZnee80H+xXt4=
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:14:47 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::22) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 04:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 04:14:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 23:14:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and
 13.0.11
Date: Tue, 16 May 2023 18:34:20 -0500
Message-ID: <20230516233420.2087-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516233420.2087-1-mario.limonciello@amd.com>
References: <20230516233420.2087-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CH3PR12MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f19cc5-c036-467f-5af8-08db568d40a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWZ6mHvOFr60VBfK39aBej9rvK4OG/4mI98sIeKfmLUNrBHLQoskg6g3k7VXmBlEKdIv4gRrcIcxX632tmvdt1W75YSQ9NyxFLdkUoqlFYc3Dog1QVV0hq8hq/AAgDOLfxIBqouDpmAeft7rlvJQAZFLx7g174zmAOTTeMakSa306x1LtG3qcewUd2C2Q9M6uhhC7i6hGR/r1GqXndpyYeEHUe4K/3giWwuf0B1HgvblOUiXL6GC0jL0dxhccpOLu8+0W5b08lhqJAxpQToh/njFRe6kdteCQY13CglvRE1w7H4CZggctVQuKDtcPnnt9d1XvI7/DUgPzxZoq6rjSojQiLPowAFzoAnJoA5fHWOnovyr0Q7nF88eb4y0GyiNz+9qncRZACRdcKW4KC4INszcl10VQVOPEIyPbtYNo3Y3WNHz/1CnO2F4pTepy74ISSFu+6ESoaaRIEugqEyFdb0wIFf8U0ZZSShLmPtx/BJpTArIKLFxyyXHgavm07YPGHloaChxRX+64bKq1iH4aWxT1d/L93z6cF/z4xONcrapwKtKvDN1zNZlihAYqWleFo+LJmfBY9IhlcMgsdTEDDJXm/KoUJ+eb2V7JNcNcgi1oiuVqt9u+5BpUdpTKsTR55ed5OwOs/y6y9HoYPh1SWVdD6IzVPUefNrMaiH7U5se0GF5w2HdfAmjUsiMELTVEAsN6dLUgPzaKvzJ3QlLgoY4Cjj9vfbBAFCvNG0nO3YfLg/n5GAvTbth/1Ig5IE8qMOKNU4EvzBqKFl6jS/mtooqPOlkwa+Nh78tBVkpFsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(6916009)(4326008)(70586007)(70206006)(478600001)(316002)(7696005)(2906002)(6666004)(40480700001)(82310400005)(8936002)(8676002)(44832011)(5660300002)(82740400003)(26005)(1076003)(81166007)(356005)(41300700001)(86362001)(36756003)(336012)(426003)(83380400001)(2616005)(16526019)(186003)(40460700003)(47076005)(36860700001)(15650500001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:14:47.7478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f19cc5-c036-467f-5af8-08db568d40a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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
Cc: Tim Huang <tim.huang@amd.com>, richard.gong@amd.com, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, anson.tsao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RLC suspend in s0ix is unncessary as the SMU and IMU jointly
manages graphics power state.

Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Skip RLC all the time instead of adding safety to it
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4dea79a0c5b5..f8510ce1c4f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1549,9 +1549,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 
 	/*
 	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
-	 * for gpu reset case. Driver involvement is unnecessary.
+	 * for gpu reset and s0ix case. Driver involvement is unnecessary.
 	 */
-	if (amdgpu_in_reset(adev)) {
+	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):
-- 
2.34.1

