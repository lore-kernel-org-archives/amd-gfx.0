Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D9EC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EAF20663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JI8kJiv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EAF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CDA6E2A0;
	Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999376E25A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geXKh87sexnCs1VKDUFcpFzpY46jmxGNcHgucywDmkvCK5A+LWcROthMhO2Ntd6p3cLxjWRtAt35az9vm2CV29UVs8bPq5I0IRMVWlET8Qe3Azz0bs+xc50RC4RfsgsZPRPJ69kls7DbDH6d2CHd4jkSbB9DqZX8yttoNROk/1ETu/XA3u3LIiYxCGH8/4UT7TNlbnV072fa7GVESBwp5T+MFAB563HnId2T2F33QW+XgvfIBxc9sLly13W4U5sOk2fHjuC/NHoYR0uSmVEXKEIZPTAZM0YOyelhPQ9Q1vziGlhIZtaM7PzQHudjlvXIDI5KGDtZNAnE0UHRznYyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ee77bBHvq4fgUj7INap3b4HzkWiKFBYqJ6Id1rMRo=;
 b=niWz1Gq7Uo6j8SECfajKwgo8j924pxnQ25NvyobVNEOHHwav9JmUJDunSIKiYAuSsxCzZycb+TB9OxKwBKNNAg+7WEEsaehRCHFidfOx7vrI17uMfBASc+u6tIpdHu1kn8IOd+Nc+vIGndDxecPqI+fe/BoPleCV5/cj4gc7u9CHFCv7B1bk+ZtmoykWdMJEJDzKw8iCCxpY2Lyji9EZFVfMX8Zp0oxKLeWs+cWPUeQ4ah41AjgX23gr1wzy0XwaI8DyYW8TFyJAgFErRDOXhKUmICWhrNJ6hvy/wrObbyyIOQb09A+7zcfXcmg3PN/s51hNVqh0/Oo3A3w7/Z1wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ee77bBHvq4fgUj7INap3b4HzkWiKFBYqJ6Id1rMRo=;
 b=JI8kJiv1efRG0gGGcCx+F33KPD2XhSntuAP0AljZQSF0e4BKvOASyhVx5S+PlFbkBQA/uCPGIPwNFrbASy+5jDLYKgav2k1iZR5Ja2RHS9bP67cIaE9vvG2YE+MYXW3aocbdqnpfGx2MgKLkMTkNyikgx5wcvlaCCj4pMFuw1cQ=
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by BYAPR12MB3078.namprd12.prod.outlook.com
 (2603:10b6:a03:a8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Thu, 16 Jan
 2020 20:14:25 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:23 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:22 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:22 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Do not send training pattern if VS
 Different
Date: Thu, 16 Jan 2020 15:13:58 -0500
Message-ID: <20200116201418.2254-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(428003)(199004)(189003)(6916009)(6666004)(356004)(316002)(81166006)(8936002)(81156014)(8676002)(4326008)(7696005)(86362001)(478600001)(36756003)(336012)(1076003)(2906002)(2616005)(426003)(5660300002)(70206006)(54906003)(26005)(70586007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3078; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df387850-bc29-4440-3f31-08d79ac0ae4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3078:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3078849C066B6C1E2D350061F9360@BYAPR12MB3078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i55i7t7tS2KmBbZGJI3XBzzo8BpWnz1J680cSiCLxkdgUKbQlze6yq7qQM+4nCVR9vRQeetf5zv6WBTzQkgm0kYxvmMB+xC/WfIp2J244O81Wt73NbWwzzradweFY+CkPICiNN4HOIhSLQ8Y00rr3/OHuIjdKT2Pa1iwC0iLuxwm4GFYUPD3GKTg8EHbh9WmaEu5cbReQ2vKSbs8mTmgZW3ZpJbnKS1MswJIe0HtXpkjZVMAyMv3J/23RIBtkTdT2E1dyWeZ2VmLnTg0WQTtgPGde2CSc8rBLPf3vieLyBIsSXPm2rJVA/k7ZaIGfpbgO7RsGJuzsW5fHO3WOnoFjNrXPGWFy1NrBMIWP0dmPvvKh9kL5C+cbzBtV9mlR50TVpv3YbbT5/cdSO2j4vf6fWeVm4IB8HxG6wsgoCE857y/RvPLDBTa8yMeoXdeSbp8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:24.3319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df387850-bc29-4440-3f31-08d79ac0ae4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Sung Lee <sung.lee@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
The DP 1.4a Spec requires that training pattern only under certain
specific conditions. Currently driver will re-send
training pattern every time voltage swing value changes,
but that should not be the case.

[How]
Do not re-send training pattern every time VS values
are different. Only send it on the first iteration.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1bd0946829e3..3bb1b481451b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -983,7 +983,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 				offset);
 
 		/* 2. update DPCD of the receiver*/
-		if (!retries_cr)
+		if (!retry_count)
 			/* EPR #361076 - write as a 5-byte burst,
 			 * but only for the 1-st iteration.*/
 			dpcd_set_lt_pattern_and_lane_settings(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
