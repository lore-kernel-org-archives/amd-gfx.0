Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B871C2D0E0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271B821D90
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bvaIVAGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271B821D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A764F6E933;
	Thu, 10 Sep 2020 13:48:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14F96E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mscg/C8YDaoPlon46VnoVnQGkeAcDsN5i7DGiU1cPigPv6jXiDwPGJOnqApHw3GuRZBPyQnf/IGGwtNzQkze8hlGlH5cHjnAwIZLukTBPRqm+6FeMa69NZZInOBVVLi9rcbavDAvzfeybpNvnFySRQ6kf4ydXb0UbKJlBnKTYBuz3D9dwQ5K9itHFaskC039WR+qQWCTazkasoLPUZ98y9AhQT3H3T5Uj/P8E6Py1RZfnqOIHAcE8hTOVEigyzsX6w2R9mLiY+Lt7SrI5bhWj4epiW+90OMRSlr/OCN7IUvZ0pOKea9bheKrjbJClwGf85qawUYn3vkVRQB1nidlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkPm+1uX/+GnKVy3qAnoe8ZzMaUU1+ebdU6yF/Gl6io=;
 b=cwJxNILz3ACTYiGDPkiRJzkeICta278DFVLxpEb1w3aUa2RAa4NwtPZYXTSLajDqGdPdmH9iVRDzyKhCHsyH8f2hJFuRkGbCcWU94vt/O1P1hxt/AKcdkleuze1C4BVHIcADBuJXcReKLMdYDwlhI827m2sWBIYOnYCElc7Y1BPgm4pH1idNaZuj+sLA1iOrhgym8p3SP8b0L8iQ6kzB1qS5wX2RjnoXp9ZcftRIDeb2u/1kqIOin33QVVcVi2h3R2ioSJibsKyAZRYvw1pPVa4nvUdFAdhZZEqjV5YZOg1f4Sjy9a62j4v8m0B3G7VcaYbxODXDFZ09OR6hQ0b5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkPm+1uX/+GnKVy3qAnoe8ZzMaUU1+ebdU6yF/Gl6io=;
 b=bvaIVAGeRPVzyTVkCkWAyIFvMfgATgrlwbG6Z16SpwFRTgQptWF+fTiP9Muk8DXIc1VUCiG7f2sqHl39u/Au/ngmtJIsuFnKdvmB2Y43YdmAzqL00cD6l1fBEkiyVYvpaQUGYnSGe/XHccdCW2kc/mFY3M5pn0W2dOvYF22vidM=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by BN8PR12MB3332.namprd12.prod.outlook.com (2603:10b6:408:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:16 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::85) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:15 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/42] drm/amd/display: update nv1x stutter latencies
Date: Thu, 10 Sep 2020 09:47:19 -0400
Message-ID: <20200910134723.27410-39-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e625018-fc82-4cb3-e388-08d855902b38
X-MS-TrafficTypeDiagnostic: BN8PR12MB3332:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33320799C1005A960BBFCBBF8B270@BN8PR12MB3332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wmFv9+mLmexbWMrUJ/JZYrWS5IixxmBwVc9rJhr6OlWDvUDR98E9WulDEL2flnjZ+OK/OfggqKN4M/QEp+GQaihBaSmkQCgWr0J4f739L9LQj3VDLxb8GCSlC0HhkF8tSnl0s9h4yW85rolYq8IKe3TQPzJxpmy7mPLjzYwQpcwa3Wr7oQIVF9GnDntKPuLbxmTznhHS5OWZzLWIret0zmfUDHU5Khp3eSE5/Xu4lJGW62cwPXSgXRiBQ1uWqeugOGEnoKzl1BMyYXpexmdWJ9/wyoF+ofb+P3EaPjqE0HtViG0cabXXsPZdt6uCgURHmGTDG4aEjTY23V94026D5STSMvneqHHusy0zoAPLIy/dMks9pX/nPeuQSMake087KK/PQ5cxWhRwLmq4ytYzuiTawcqg9LLBYNrHWYKiuDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(7696005)(316002)(8676002)(356005)(81166007)(1076003)(54906003)(5660300002)(36756003)(6916009)(86362001)(26005)(44832011)(2616005)(82740400003)(83380400001)(186003)(82310400003)(15650500001)(70206006)(2906002)(336012)(70586007)(426003)(8936002)(478600001)(47076004)(4326008)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:16.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e625018-fc82-4cb3-e388-08d855902b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3332
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
Recent characterization shows increased stutter latencies on some SKUs,
leading to underflow.

[how]
Update SOC params to account for this worst case latency.

Signed-off-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 55ce2c7df84e..18b9465057ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -409,8 +409,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 			},
 		},
 	.num_states = 5,
-	.sr_exit_time_us = 8.6,
-	.sr_enter_plus_exit_time_us = 10.9,
+	.sr_exit_time_us = 11.6,
+	.sr_enter_plus_exit_time_us = 13.9,
 	.urgent_latency_us = 4.0,
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
