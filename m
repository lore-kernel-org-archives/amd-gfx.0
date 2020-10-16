Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E5C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50CB2078A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wnKq9ceD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50CB2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507B96E9B4;
	Fri, 16 Oct 2020 03:27:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130116E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOiV6s7ERclI/5yinW3WPvMKGf5tF/WwRiv9pvwyerFXYqWGBkrDRpLVwrMSEwvoN31IWtWmyqpEjm+t4JfcvEXz5y+o8Fc/Ete6XFmmAX+iV2fZrfdKtV+CoPS2c9idxrvUDU5CvJqfrh1PVVV/zKJyJT2DtaRF5whipviScb66SYeQBmW6s3rqeJDfvVIFgXn11gmw29Rpabht0nmNVMK9h/DTSvxcKvMHsPsSZLpZnzTI6wmKeZFwYbaXN18dLSaq0BAb8ZwnjSD5YTaFo564IbAgcZvYXBfElHwLagRAxZYixKP/D3AK2HMhP8jKqHx9sTnUQqM1L/VkUxN6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA0Jhq5bA7I8r/W2aoVUawfiryd4Ib6qMwCmeWa5t6I=;
 b=LaX2/oTvTlvow3fYumthS8WWZXp62kZcy5EVAPafVMtkmCOpSBv5xl2tOnjJQurMEQbv1ExfdSPq04DQFvvBnGx66shrzyuToGgx+BgTGbnQ0mmnSmM1yhpPqHdvaoU5UD4rUB7E6S+QKgSSkGLh7XEm3ufNJxWjpciTuY6AYt7+ML/geaTHo77k08VhTlJq8LFUVaFtRZJUjQGUBRaMraL6utuc+PgP+MQ/aSE4Mtyq9IcnEFjDBG2tJZ305qHfkBJuS/STA8pRPrFEFM1ayrNn4IrHfwo7PQZjtqVUaWvcp5uXyM9d1GTDtb1Ydi6M3dlAjOa+qIOQ3QIvHe+iUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA0Jhq5bA7I8r/W2aoVUawfiryd4Ib6qMwCmeWa5t6I=;
 b=wnKq9ceD3OVjWJ+P2vNpTgoLFZKESw8KytfLXNfhwuL+25oF6j3nracOmB4e/WxYJQZb+4Ph/tNbxxUUIGeX4wSPW/WPdNi4UkA6jlyjzFAHcR2tY6fSI/n4iMCP8uSs/4/fC96H8ghDfPUq3xpPagl/eAi7cHD0Ym3TcvFcDyc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/40] drm/amd/pm: correct the ACPI table setup V2
Date: Fri, 16 Oct 2020 11:26:19 +0800
Message-Id: <20201016032652.507-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57aa6028-faaf-4f15-0e21-08d871837223
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB468037221D2FD15C4ACA8F06E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH/wdGZ0lhnbB/aghQv9ZpXwIJfKD/PPTImimll4UG1oaSI7uBTCIeNR2Qpbh9izJmRxONYwqPnYJfLw+51qVKo6uzQxzUV2/2oPUqbJ+YVR2N9AmOPOy9VHPz8e3EZOJ7rskeEXuYB2/TRGLkcEeWiRmYOFmCg93qjsDUim6+yM0eUboTNyOVixuZ5ugwJdkvoY133wgmLv3sup5rsqqyYqKVBL/L7UK6LjbittXU7flJvmDEH4RSNJhn/Vfx2j0cXiPa+ohVlgdprW7KclE70FIr9ul6052QvpmVklMHk/iEt60jh/MZ6jiEaWILgi69TF+LEM/swLEq7GWPJsArDnMJ0TSAv2WXK44MzQXWHq3W+tVlxM7R33BLnl6iEp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9XcUjSFelT6hHokdqZgo+28rdIJ8O/f+tYX3KTZRLyYLyDEBdiKeu4ms8KpEPexdfNmoMUJeF0eoTUg9i6Yjbdox+b0pUMUcffzuMq6AFPms3MGAx5cf4lJ6CnE91AdBtr+vwcRNrW6LqLA4ZG1Mryd2pu3ZaXnwYnuSFYQJEyp2DyOnzTLIdxHTWQk+WIM67QoKINnfv3g4h4dOlXhRSezMXrW5di/DqQZhiaJpKEc60O5lYLfqby0Wh0QniMucdI4dGoiJeDr6avOLmgqPBF1fpjzzBCqIvnbWkj0PkfCDGThWw/k1Fou6bOu3jSkUNJ7I0eZ3WPI7Z1jvZ/kgIonhlw/kPYG4Qj/hn+UqrPBe7nF7MnuD8R4AQ1rhbwXw9cUlnAOrSy6jKthEM4gZyY98Q3dwRFyYjQSuXljiIQu6iPErIJkdwhj5LELfwBNxSsfpRsQWzFHcYeB93RSoFswZhHg0+cZzqSM8GAKFNQQ6VJ6v1J06HNieJQLmjMidzWZeLxW1yxmIe/HYIUBn2vHGqJGueE656ItXvUIKM6CQyINNEu/fuaz2zJVIerZxvoblFQMueD026080s7/5bwDQFpFzXzFZdqdoLdvrRE9bytV3IhpGPUsC95BklNqgwWNBMhq9yN7FJLFdZ0/Paw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aa6028-faaf-4f15-0e21-08d871837223
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:44.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkTQC7Gzq2YCgGIExvrWMYPFD3M7aqWTsaEqk2B9YyRYYRh3cdWTJ5e4LsOpMpuY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the setting for "ActivityLevel".

V2: rich the comment

Change-Id: I4a166dbabdb41938705fe24801aeced6d892e985
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 260c95cae3ec..a6c8f121f41c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1316,8 +1316,9 @@ static int polaris10_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
 	table->MemoryACPILevel.UpHyst = 0;
 	table->MemoryACPILevel.DownHyst = 100;
 	table->MemoryACPILevel.VoltageDownHyst = 0;
+	/* To align with the settings from other OSes */
 	table->MemoryACPILevel.ActivityLevel =
-			PP_HOST_TO_SMC_US(data->current_profile_setting.mclk_activity);
+			PP_HOST_TO_SMC_US(data->current_profile_setting.sclk_activity);
 
 	CONVERT_FROM_HOST_TO_SMC_UL(table->MemoryACPILevel.MclkFrequency);
 	CONVERT_FROM_HOST_TO_SMC_UL(table->MemoryACPILevel.MinVoltage);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
