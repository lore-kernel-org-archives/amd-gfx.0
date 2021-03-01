Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65837C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2320465167
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2320465167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94D26E843;
	Mon,  1 Mar 2021 17:07:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A84E6E843
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 17:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHRlqNBCsrqAZCMz3qfFkLkeB1pierYpB69bWAZmtejCgbRjzM/KlB74K6CG+d/EoKbYxttW6WDTiFWZ3EaFSQ5+ZaHID56kcYoSlXsx+BZBqMrRLpPEAEliWm41Lq9Jat3lScVOQJ8LmIuo+OQ2edE7Okc927BjECRW5rfdeY411TIn/+ZNw11swtUEcGaKNac/hwk1aMDlxmX9vKyDYaqmYLtWLAQZTGB9mcMEMTmJGtl8egCDQo674tn1w0QFPWUCH3BgQlVEkkVAVkIQuIsL51HqZvWXZCty41Wy4lAE5DTWni8us9oBabnN07DpJmqLBBXy6YmdIN+OgCfF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nte3JkiwXwZGavp9vBuI8HbjW5N8UoeFMBufs42ylv0=;
 b=bjRNlq0yZEGxQHEdwrr67yjCGVycHBQyN4Ma3k7jkH33mcr19T9L4UNrwkGhsSAYEcy9zRM/xP9gjChGUyWM7Dddujl4qTfVZnB7JN/xA6KGAjiXBfW5v003N2KV2DfD+2aCk63tlkBTAblzRaNnf45f8tXMTaYYe8kiQrHBMVpVm2BLAR2DGej9ooGbcOBqJ5aVOAlV7KSbhj15fQV18O7XnX+cuR7AbmdzwnmTw2p0zHWMBsi+zttAFtKQKKNU2Nxy9juvfwAwLcdD6IS+sfXhTNElefvS1En1SuC2pN4VUZC59s3QjhkmtScD87DZbv20zfQrQoWetsLMwiCehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nte3JkiwXwZGavp9vBuI8HbjW5N8UoeFMBufs42ylv0=;
 b=Snj4LfoITpdu8I3wjEJp6OEGUMRpI5cmH/4PL9RHuPBnbSCTJpcfg8YADHqlpXXrc6NB8wQD/LcjNicVX/hEgQhjHky3jVzavZzHqKfSkk1IlDY4RQkBHGdMN2jqaCs7EDI08lTvrHsUtyQpxUnyrSr+E1ZDukWuseXtpGhXWXM=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Mon, 1 Mar
 2021 17:07:00 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::bb) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Mon, 1 Mar 2021 17:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 17:06:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 11:06:58 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Mar 2021
 11:06:58 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 1 Mar 2021 11:06:57 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] SWDEV-266369 - dc: Fix 64 bit modulus operation using
 div64 API
Date: Mon, 1 Mar 2021 12:06:31 -0500
Message-ID: <20210301170631.94988-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301170631.94988-1-bindu.r@amd.com>
References: <20210301170631.94988-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b87e4b71-429a-4f65-9520-08d8dcd46cc2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3375035F41731DDEDEAB185DF59A9@MN2PR12MB3375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 628OBQuTInF6qP/eHXcNig/JXvVaB8QifnKnhag3CUsjgvJeUGB9lAbAlFtY4LkRmCth3QEU6+bSZ8PE503Jp6HYwxvgKXorxLLfrPunwLZ0VQ5VY9mB0+rJQJiifL3Kg3haBUGTG1dx9CIiRMt0vZ/q8Yggo2PVWDW5vrPCtrh7+nJOSaNP3PHGdDQWu5oNcxzatvPkT8droY9hXI8XnQh2de9ce5z8HhRgSwisAsJUWBrPb5YPAT5glJupMQtiNxKsc324cdlHYunms+cvBOfHOgaRczMG14AAJTLqJKo2v8WttWdx6gjexqK7oKG73JCtHxbTjDWmXM4NDrSVZzdM07NJLKyOBmCrfxX26oeltFyzGwBGTo9Lh3Le/k89s9sQNg1BzfJ0z5Ny/R0G96c+Dk7D4LFuoJxN4tx9JRWgJ6lbiyo7VBMGhyfowsL41qrX/VHMZDgMUeCV820/PHNBObdVgP9Xw7CVtsZnIroqGcPAfKCps1P/lZ2aFkaEF/4U7tDGxVN0OF/lPGtwUoGMWMVywS2VLzntfoX95sDPg6AGfYvTMgKPkDk7k/oQY+fhs7O8YagNDaR643M8YkFaFDeAAHSo/XFPYlDEh1zyxMIfXcUnXPnbvTfGJT1oNohbbXqmLi3VkL98ABSPGfsJTxQobuxlCVZIMCS9+8m+AncgbtZ5HQoeQxxf4aGI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(426003)(8676002)(6916009)(6666004)(82310400003)(316002)(2616005)(8936002)(336012)(186003)(36860700001)(54906003)(26005)(47076005)(2906002)(7696005)(82740400003)(5660300002)(86362001)(70206006)(4326008)(478600001)(81166007)(36756003)(356005)(1076003)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 17:06:58.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e4b71-429a-4f65-9520-08d8dcd46cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3375
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
Cc: alexander.deucher@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Rodrigo.Siqueira@amd.com, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[why]
Synchronization displays with different timings feature uses
reminder of 64 bit division (modulus operator) , which is not
supported by 32 bit platforms

[how]
Use div64 API for 64 bit modulus

Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
Tested-by: Bindu Ramamurthy<bindu.r@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 45f4dbd886b9..190b10445e03 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1893,16 +1893,21 @@ uint64_t reduceSizeAndFraction(
 	num = *numerator;
 	denom = *denominator;
 	for (i = 0; i < count; i++) {
+		uint32_t num_reminder, denom_reminder;
+		uint64_t num_result, denom_result;
 		if (checkUint32Bounary &&
 			num <= max_int32 && denom <= max_int32) {
 			ret = true;
 			break;
 		}
-		while (num % prime_numbers[i] == 0 &&
-			   denom % prime_numbers[i] == 0) {
-			num = div_u64(num, prime_numbers[i]);
-			denom = div_u64(denom, prime_numbers[i]);
-		}
+		do {
+			num_result = div_u64_rem(num, prime_numbers[i], &num_reminder);
+			denom_result = div_u64_rem(denom, prime_numbers[i], &denom_reminder);
+			if (num_reminder == 0 && denom_reminder == 0) {
+				num = num_result;
+				denom = denom_result;
+			}
+		} while (num_reminder == 0 && denom_reminder == 0);
 	}
 	*numerator = num;
 	*denominator = denom;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
