Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D61DC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ACC61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ACC61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FF76E200;
	Fri, 14 May 2021 04:50:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C576E203
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNrf7GsrFBL8aMhTNuf+nFFf4JepmakO8ndhx76Ycr4YI0ecXRUZV7vnrCJK8GGl0kVGOJlvDc3t8CRAiAz9fymothzDy+TPrm0qifX/HAelTvmiW/drgQXT7D13dm/mE0LbHy3nvu/rymlwJOoW8Ms0qfRX6W8jbwUZRhX2sDstbuS5e/tWY3eLXWSN1onb0zJlvvwvLLerqk29l9Aw2UbwGlsodR0uCDKzHYJpSgBvfuATfjPk4ZJz5zYMFORG16HQ4PTk0IT4v1e9sksPNDxvKm3+TTLD2iSdKtvd8Je4i+QQYeLxvXG7UaupqPYuXxvnGFcXEI7sJ4rgb9x4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqBB6t4Ez7vlklvilYpCO8R9iPcPFSsLoP0VkEmaPsw=;
 b=Zmu0JbjEQsT/MuarPUvp+PkWroum7XKNi3F7JJtL4vhuSh+5NsFo7/SMy5CxFxzS5EXK0jk2d4yl5LFAt1FweNRmvha7GmpGiNU0y4Fmj1hMXicftUpyFdDezdji5jWCHprisnNwANx2K94rXYoMedUWGgxrVy8P92IHRhakE5nVBgGkdzOZ+zDYjECbEhmEQAsRY7vElhUo630+kNz3hda38rB+byfpGC1IChmw6yufhdvyiJN9b6oCLIashuD1/ZJLo+Wb9O4NummpdZDLMYqSbWLmm34BQ/BNxGGAyxDgzGq9YjKZ4OgnF8kFXWjOFXyL+iQvkb1okvU7C+Y5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqBB6t4Ez7vlklvilYpCO8R9iPcPFSsLoP0VkEmaPsw=;
 b=4vodM1BZyYhLiV2bg9ZRVI9BxVTmr2YEoB1pgG7GYK+MOzr0pSYArfZ1hv6z5KucCOqvIIhtLpv3egt3t2PlCO48+6tc+jZY6XkgpBfi6VLOoB7WVZSvLIGXiFkJ0IxHk9GWZW5MaOSrstc4rTQpWcEdBGJoHAI8fXrWDD6MOCA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:45 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:45 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/20] drm/amd/display: Add kernel-doc to some hubp functions
Date: Fri, 14 May 2021 12:49:48 +0800
Message-Id: <20210514045003.3069681-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7810645a-e0af-472f-ac8c-08d91693d5ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129052CBA5F117B08A0B1F6FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZ91Sv+rIciCen4vzz7WHcb/fxU4+XuhBHofnUfGdx2FPfRzK+x05qswyAjj7Xr/9De2aCTshKbEtPRRW3pE90knIgwDY147hZrRzKE+WwHnXhdN+B0hVe6MBOw3hWi+VbhrI3R/vhJFIdiek6MWKv9OpBVqgX5XhlHUwypoHyyEnN6XUO7o3t1v3t5Azbc/Ku0CEwNYc+o+WZKpsft+3njTXE3u6uGydEakg4bU7yqblMXyNDbT6MK1aUiVffbfVGPa5+d4wA6YD2zWgRKfxtXPYesWg4WmBvpHmz8wRWn0jttDH/pljWMh6ohLkuZATOxOa4ro9CJIRay1zOdENaxzpOWZ6eOXE4jfoJzO4CzVoS0fbVfWVYL1CKIaQY2BVOeTUPp2EUnwrQslv+958VBmh6b+0mpj+JzO5sy00udhOWLBdxQTEUBF1eibOLY8eAs/6v9D1YfjjXG1fyd2YL2zwNrHgOnKkvpK1WfdWOGJ6mx9w3LD876W4XUF1xDHCgIWh+5iuuEBOE/UpUh7qWAn4szwE2fI42PmxsKpcPpmsx+09r5rcw2C5j8NyM6ruHwH0uz2Vw6FU1fVgeyYWNzDrVX150mIMllWcU3uS5PiCPybkE+bcGAmEQlMrivxHqTZrVQO17apO3Pf7z/OhzvjCJsyR/ZwafQdXh6NdX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PnUBxvasR06nCjA7V+4Y7UwueVDm8lnyEmSXVyCh+V3Kbj91mya2VLOFWEpq?=
 =?us-ascii?Q?OzrXyaIMngfP6hnfwauamPEnqDaFYPKfaWDxJts5J2mDwhPbSfcpCVKXhda3?=
 =?us-ascii?Q?wu6tvxLQMmFWpAgP+V4InFWCoUhWnDvX6vTSdW/4eNGSqWlYn47u+AkZKcNT?=
 =?us-ascii?Q?W8E5fqArL1xTr6mpJuSYna8cxfzytgMCWDF3tfqRStAVpVBW0vb7gsxd4bJH?=
 =?us-ascii?Q?HfKRkRsjs0RhO5L7Uy2RmDFfaODzyeQkDqLhCBCviq2LBHi8fY6PXL0wPdYa?=
 =?us-ascii?Q?DNvZlV+PV1iRF+yelzg5w+tXzcZ/0N9F8Ugyq3g7jRaSx0FZpX2PPi/SHq6C?=
 =?us-ascii?Q?kt6iQWV6HYL9X4R3Sb02QfaU/0HmMgqrP6aRwO3gol6aQHf0D6oDHKPC+hSp?=
 =?us-ascii?Q?l0rHFyvABtxm01m6eImCrwEasaAFjqjK9LqctTOR7gKzD5MwSY8Dotdzf/8Z?=
 =?us-ascii?Q?gk9B80m/KJBERwAEDHgzh7g/uJ/LYOUPgopbR9EU35j03McCUv6oP0ygnk8z?=
 =?us-ascii?Q?Ur9wvxXNg4pmXbGA5X+s/PiDws0IXXm5qiHSd7EQWkstMcJvLRNOr1Ap29K6?=
 =?us-ascii?Q?+ln0I+hCIuSEDC84B9tg8poB4Jr8kgzDmrU4zPX++kPG3tmWnOGOCY27usfy?=
 =?us-ascii?Q?TniKZgVappSIzHyiMLIDMRTgG73XKwR0biltpwxBzF6pImJdqh2BP+dKGoI7?=
 =?us-ascii?Q?DBWfHJhT0pLXkNU1fUWcGXjKTcloECmQp7aPB/KxV8Jo0wKulwuAIUtfZGL3?=
 =?us-ascii?Q?lTOH6vkWYnnMZ2ZI2uVxFw1TELLQCWqb4m4Jt0RB9BkePjRQ1eHfEOPLOPjc?=
 =?us-ascii?Q?aaphhaie83MtwGbypWNvGXMSKo6gvjTo6OZ1E3W7+cZ8qEgL53xA7VSQ0nbh?=
 =?us-ascii?Q?Q4DClxFSM3aTkI9VRapvTZdBhGQQyoZqtsMZmYJl/8xVcbrYWFa1bWPG46CV?=
 =?us-ascii?Q?WwUydTVbADuQmCsEOB0KlYHHa4EC15XVmN6p0ogbIU0VjyyBtniX+09FzG5b?=
 =?us-ascii?Q?KQve2aK+wxQSS1Kcxv8d30PJbrQP4lTJQnc7YuPT//dGyFQO+OIzTH3XKQ0n?=
 =?us-ascii?Q?luSk2HrYTc1zAKbgPEll2RwUUS6u3fD+ZqQIiCeyoXnUhhOlCaQFvJdPrHVW?=
 =?us-ascii?Q?GbA1XY+sm0PwHLdS5HTsNG89LtQInS8WnNESbdPyC/uy/SvMbmipFgeLPS/B?=
 =?us-ascii?Q?gKnFbmbYSuV+JDS/0ejvJ6fFScVK+KK9XYHvGLF6UFzKlnmCV3dzVJVmWDuV?=
 =?us-ascii?Q?XImR2NrR7G9JyvVlAIPYKErTblmmNo1PQLITdyueY0SCgvkIEaaGaDbImF7s?=
 =?us-ascii?Q?vXyzDR3wSMvo9OWbTkqgAo+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810645a-e0af-472f-ac8c-08d91693d5ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:45.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVXVpY6cyg0aLD6Tp1DDKsSScdSa0oHSWmPFzGeYt60RggPSXGnJLnSRbRFEY7N/JDBwDbsT5Jb7MRYH4gEEPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 714c71a5fbde..e39e8a2f715d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1226,6 +1226,14 @@ void hubp1_cursor_set_position(
 	/* TODO Handle surface pixel formats other than 4:4:4 */
 }
 
+/**
+ * hubp1_clk_cntl - Disable or enable clocks for DCHUBP
+ *
+ * @hubp: hubp struct reference.
+ * @enable: Set true for enabling gate clock.
+ *
+ * When enabling/disabling DCHUBP clock, we affect dcfclk/dppclk.
+ */
 void hubp1_clk_cntl(struct hubp *hubp, bool enable)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
@@ -1257,6 +1265,11 @@ void hubp1_soft_reset(struct hubp *hubp, bool reset)
 	REG_UPDATE(DCHUBP_CNTL, HUBP_DISABLE, reset ? 1 : 0);
 }
 
+/**
+ * hubp1_set_flip_int - Enable surface flip interrupt
+ *
+ * @hubp: hubp struct reference.
+ */
 void hubp1_set_flip_int(struct hubp *hubp)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
