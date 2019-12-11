Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914C92077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HOnbbdXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914C92077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4899C6EB9E;
	Wed, 11 Dec 2019 15:34:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760078.outbound.protection.outlook.com [40.107.76.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51F26EB74
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1RQv3JZC+RoOIdAXNElkFF/pSLRyHwdenG2jjKK0fb/VPVU6xL3OHQiVrCEx1B190Hu7Cq0LKk2HRQGQs6/GAy4jZTEHfaKarXkyPDn/62NPtJnk5QAacob+Ot15AWzWnZYbbZ5ekTOhZDWZWjp1eVBWkNVYESw8LeVcZdSQ0cCxn5wxr4DGYosRRZ4i4itkk0/a9MPQCPuUrbHk9/v1LFAkp9ww68xM1rCxvUTlw65EE3fFRUCLJzVTEOYtyx6+An7tFDRPPDWsTmy5jYOZgjZshxh4fkenU7JpuMF2W3/6zlQxTHZHd0OE5TOS1MZN8fWnZ1TiygmMM6O1wmIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzjbK+zNG1QpEqnVsY9e3zB8DYzKJQPrOrComsQco60=;
 b=ejzilwCZCGiysXnMHXXRhTey1ujQYBTfS5g+YmJOhObnPk2ap7l9EpEtry16LxrXcdmAbKQ8xLICqv9W6TAluXqxXVIitxR9ufPDb7Soso2IND2nh4DsDzBeU2IBDm1Zpo+t4gWvye7c8cC9a8D2nCqKM4jPXlcfT1oKW+FKpaG3T8n7TQehmyZfo4CfucKUP/F222QE0nyR5z8ib//vbIE3Z+WG/t/VeW39WzyVHUU1d85zI45+kCJ/UoOFB0FZiO6YGEpDn8K5HgYAUFKvN5oDXLNRILjWQd3O73pttP6rKjiO/1WPXMbex3glXNoOhAR1d/o9qlht/yDUyLjjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzjbK+zNG1QpEqnVsY9e3zB8DYzKJQPrOrComsQco60=;
 b=HOnbbdXYnMbHnSgLsTzIBQm7P+JKMS9Wq2+5134cd3T2wpEu0XEerRsHhmxPjQnTrogtrHrayhQtJJVqvLiuUZGfg5PnwUNaTb/d0+UxC3o6FjRnHVIbfGlqaU0eL7xiIsCSbMv+514WQESRjEwigbtqoUWp+gPaiytaDSqTurg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/39] drm/amd/display: Use absolute time stamp to follow the
 eDP T7 spec requirement
Date: Wed, 11 Dec 2019 10:32:44 -0500
Message-Id: <20191211153253.2291112-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dece02c-7483-426f-ef8c-08d77e4f813f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491940BF3627B3F9127A2E5985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nCOTRMDFqeplw6oynJ2WP/SQkrzcQodnTSyi6XScwqcD+efG5rAzfZwb9RMyq9g3xEJ9HftfUANz5oZaiOa3x+KbZyjTmHnyZg9j1VHff/2y0O3/Ho/mrdmyO7dXLN3pGfPexOPOCfguN3vLK9EbmuhcWjUbqluh+xLowrDOLtLad5IxQTPYGZnVP3G0Wfug3nl1BG9O6EIDLFWH+mI3TeoFLOMfIEzNUfE1FObg08mMG0VElse8dlb5apPpQHYOhpBb20jTNg6j24jOWFf6HxFOocgN6DPj/dauCV8p+iZQ6jfL1kcuHvneRCcyDrg55LdjzeYAzCRbcQO6aV3IgPntbKgVC295cuXHwu4xFUAg5hFkor5CZOXaN+TY/Fkk+SSA2qNnt798yRMjelk1wKuPYAsBOdjtIWKjR+X90Er9Cy7Jkwxm9jA5VFYXK43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dece02c-7483-426f-ef8c-08d77e4f813f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:43.4160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkkR8HisapdKTRfgwxMG6IRPYlmi++4GONvPpHkxs+J6rGsVUkbqwYpsDDmXjYf9mSdbtj98Ls27q/fyeW6tyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Dale Zhao <dale.zhao@amd.com>, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]:
According to eDP spec, max T7 delay should be 50 ms. Current code uses 300
retry counters may not be accurate enough for different panels.

[How]:
Use absolute time stamp to achive accurate delay.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 548aac02ca11..d1df0541e10a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -173,15 +173,20 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 }
 bool edp_receiver_ready_T7(struct dc_link *link)
 {
-	unsigned int tries = 0;
 	unsigned char sinkstatus = 0;
 	unsigned char edpRev = 0;
 	enum dc_status result = DC_OK;
 
+	/* use absolute time stamp to constrain max T7*/
+	unsigned long long enter_timestamp = 0;
+	unsigned long long finish_timestamp = 0;
+	unsigned long long time_taken_in_ns = 0;
+
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
 	if (result == DC_OK && edpRev < DP_EDP_12)
 		return true;
 	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+	enter_timestamp = dm_get_timestamp(link->ctx);
 	do {
 		sinkstatus = 0;
 		result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
@@ -189,8 +194,10 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 			break;
 		if (result != DC_OK)
 			break;
-		udelay(25); //MAx T7 is 50ms
-	} while (++tries < 300);
+		udelay(25);
+		finish_timestamp = dm_get_timestamp(link->ctx);
+		time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
+	} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
 
 	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
