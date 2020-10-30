Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA879C5517A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0F122202
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aufvJAzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0F122202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A666E02C;
	Fri, 30 Oct 2020 06:55:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF916E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 06:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPabN0EdMT/JNzg5MbGwjcWkkOWUEg1hYyuy1SQOEKvHeyhCOF9l+DZT7gkGdYaHYsApdDy52e55CRyNi7kaOT3Od+P1jGEzWRZHOEzL6VXnPgTBWZrJrnTHDfqaIz3fj8j18VwEZcBRbrEg99qniE6JlP8/3c5za4XsPcBEMGAARHjIv2yDdFjHRFQ47eqArva9NIoUxQSBZ9R6sd4q5XteSU+Kf6f+RZp+wOZDoA7bh3WuQJpb20AjZa88t2+IZDBO2/9KPaK2NZXBiy93gncql7VmJeVKB9RXRwksAXdy795quSOoGqstSFRh5yttSJB7XcCcBMUfeFeP5knj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qde823424jTQhWFd06einMR5j3SKpsiAAlIn3v6goD8=;
 b=bIHtzW5adKlRZenjG9LDQjcJfKNXJpYI98550GT1Wx8pnzp2fVaQxGlTnAIEyCwLRFenfp9JFHHBZHvdAJip5AIwVDXiCK1ndLFzalgG36msZd+Bx2E7ToMtyaU1glr3TMcNQUq9DAmd6BMC9ud/Xn+00nQ/8FEp45gIbVcLgq2NFaXCmxaY1kBaxwwfFVmuxYaXdFdEue3GFpFv9UY9Ky/4OmQOTozzolk0gDhCya8qUuM73hnIXuazHMlNc+/nrNUlz57kjx+HUO87v7uZg3DxM53LYm4sbPWf9c8r9NRhQykt2Xw4azDzURKsO7PMUwuhEFiE5IMP3DKfYwJ3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qde823424jTQhWFd06einMR5j3SKpsiAAlIn3v6goD8=;
 b=aufvJAzCcnimEzkR2hVnGSn8bftCCPGi8syneDYWQxS3liONyro0eMRitJiy38pxJlq0IPQXzUkJWk8MRtGN/ulXXUSBF1ZnoyfBBpuWdeUZJXIAm/x6dF4jn6HCk7VBlvLohDQXRUENPIhjaE8waWjcCApj9fLNNhFu1MV2New=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 06:55:28 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::1c41:4a16:298b:6345%7]) with mapi id 15.20.3477.028; Fri, 30 Oct 2020
 06:55:28 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: nicholas.kazlauskas@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Tune min clk values for MPO for RV
Date: Fri, 30 Oct 2020 12:25:05 +0530
Message-Id: <20201030065505.4033189-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 30 Oct 2020 06:55:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89a4d449-97fa-432d-e949-08d87ca0c8ec
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB28779B1E610D3CEE597F1A1380150@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/2ZG8vgX0NVDQyv95hFHCBZpq5zCq8BQIplWvijYkVF3EukF5Z8p8TSC9cg0xtddZN4LBVALCEFI09VAPhGJxMuIlA9/r7Gz4w0Wylm21EEg7Am6SbZ+8zvt+fGrqCN9Tdk21/mg8VMG7rb8xQ0LsLXUpUVVOznGp9OQ3uLFpm2suKRoC9DOEmD/xFfZazyezjk5fLVJiQwEwRL44ZeS3cjUHT+sto0x46SdELYGGL7kbAC8M6zqZZ5rQbi9033BdDIfMrlZbEk7amUUx5GP9XtNWpnyYnO+2ac0HRSiGTeH/oaxzXgHbfw/6MViFm/I1mMji8f+TUeukFiihQ0Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(66556008)(316002)(2616005)(7696005)(66946007)(52116002)(8936002)(4326008)(2906002)(66476007)(1076003)(26005)(86362001)(6486002)(956004)(36756003)(8676002)(478600001)(6666004)(83380400001)(186003)(16526019)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: it3pf/HJ0iKu/c44LHRuohh7hmnaB/ltunvCoeDkDM0/TZMfXWwugAHC/Tx1W0rowOtzLhYeJBZ/vUMjpK5Y+0HQyzTDWBCzAfb/EpmQ+z64K0ZVQ8a3sMDyGbI6zRHAnjbAMegg0XHo5pkak69GYgUdEIMSsWKH14ihfX18lxmFQKNz7Yc+8MC+otu5EMEmN2o3hg9sE7vNvpat/2LOBzSN4I6SiK2vAzjWRFMKIyxjd+ZXFRyD40RVUwK9kp2waM9R/sZgyAawQoVDEmllicm72WzSrkYCKc0Mizx8gPR0yC21WwlKgGmkEw3qUNmkxpMaePYgcSMqOSEzKEV/g9A6HZkOxAR/KdLs4N+YUzn/HAS2LWP3HoNJanjilmv9cAdGuYGYTmTDq/MFNwjkLwxbvzex6Q7PkpOiZnuMMUyNW1aMFCMEhqRzvNKagstK5mzaC64BXrwMNKS5NVb4aScI3pWW4GCF1A183pREHyHJIiFGXKUFG87FImlRE+e3YnfczU7M30RSqaYwN6leOhHcH3Se2Nm7pcfPYoSzoIItdQAaQLfP3r0Abq7zHY2EibHsttAXqWR4b2vUHKiGXTRJEqO4i/WUW+k1VI/7OuwaKUKMWKyzrTERbNa0eU1tz0JRpL2CWmgMty61m1oqKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a4d449-97fa-432d-e949-08d87ca0c8ec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:55:28.2445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9USfD1YBFSvQK3nKVVoaLEi+7OkP+jl0Qk/5qmC2J1jB97PrvOxhUzdk/5NSNVAhZzx2n822lMN3ZaGT3i/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Incorrect values were resulting in flash lines
when MPO was enabled and system was left idle.

[How]
Increase min clk values only when MPO is enabled
and display is active to not affect S3 power.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index e133edc587d3..75b8240ed059 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -187,6 +187,17 @@ static void ramp_up_dispclk_with_dpp(
 	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
 }
 
+static bool is_mpo_enabled(struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->stream_status[i].plane_count > 1)
+			return true;
+	}
+	return false;
+}
+
 static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -284,9 +295,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (pp_smu->set_hard_min_fclk_by_freq &&
 				pp_smu->set_hard_min_dcfclk_by_freq &&
 				pp_smu->set_min_deep_sleep_dcfclk) {
-			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
-			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
-			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			// Only increase clocks when display is active and MPO is enabled
+			if (display_count && is_mpo_enabled(context)) {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->fclk_khz / 1000) *  101) / 100);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			} else {
+				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->fclk_khz / 1000);
+				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
+						new_clocks->dcfclk_khz / 1000);
+				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
+						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
+			}
 		}
 	}
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
