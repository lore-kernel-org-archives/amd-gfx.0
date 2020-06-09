Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76065C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372CB207ED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YPgtBGrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372CB207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C7E89949;
	Tue,  9 Jun 2020 10:20:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0A289949
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeoEAjodv5C+qRqzjm3ZYkiEQ4Z9qEOrsfBfnSGlVx/KnxgZW6EwReiK7KieDNC4Peg38OFFYfyumrzWnn4rCaLprxr6d/Na3pM+exodiY6u+tMBWrnabaq9xKUbICfBhzDJ/g3hWWUeytQlB8cpMwTQ1d9p9qPJ/M0nMl1llUYRwPUx8Ay/s13LbgiWdHAZx8b3Ag+IgYLSnoS7vntEqXb/YnNvlTkxRQt3Oh8C3yE+b8DV+Hmv3uT1rFXLkSDfKXRxGQwV12pbzfyy0EZQIDCQ2W7EDACZXOzsZjbmleDW1+fUDHJkzlwnqFs8+rD2T3vP1kaflunPO7Q92PQdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zwpACXx7cKNi7o2TmMKHvqE6j048oxYlfrDM3vpwnQ=;
 b=TzA+axMXcp0x9fuTSn5jdZPiUZFlkb3mDpT7D7feGirhSV3+tiboegNUfWqVRxucPMJ7LPSLKQQWIsgUkv0oQmGv2zUKM179bRCPJAu50FbkhPfOiLGOM9iM/tTIsrVy9YcMBpECISPMIu+4K2cHtbUv17q/ESBs9CBp+zmOK64UesFA5qg8W/OLfhvfzFhR0aaLlq4UeBtOSzGstaxUTWhXQsa0vPUaimJTQtQoeDsOxQe71k52NKoE40ZPbNAkCabAUMoL+wdWNP76pW49y7jCGFbc+1NtAdCzw9dV7sU4obbDGaDCbcoYYzwddps6g4oH4xBIOxQvhF+yZH7MxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zwpACXx7cKNi7o2TmMKHvqE6j048oxYlfrDM3vpwnQ=;
 b=YPgtBGrpALQmc3rYjbzDcBnMHpR//yeEgDNbUExQcBX1LTzPMbYp0iZi3sEmkDiKAlogzI8wKGrSYzEdevn4vjy/jVo94UteDrQKptGryeyz6N4idmwkfblycFa9VKRSznCSP2O12te1U1UadQDUysJKhTvOKdkyD+3eogttBUY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Tue, 9 Jun 2020 10:20:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:20:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/powerplay: drop unnecessary
 SMU_MSG_GetDpmClockFreq check
Date: Tue,  9 Jun 2020 18:20:15 +0800
Message-Id: <20200609102017.12478-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:20:51 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdbf4416-ac03-4d52-3ce2-08d80c5ec9ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3084B793055A9123139FB5D1E4820@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79veqjQ2KXMP9xuAeYuyS+ZWwxl4o36n4yhJ15Xr7+ZupJ1Rd3v8NGCqyNliHHuCWJIWiDGYXlRfBrF9bVnEWZmeoyCedXkNKDma5dcGkwxm+KnOyw6/ssgMKBNzyDqf3PssZjwnLM3hq+GA88XwEV5PwdaJFu5IZkdJH+shtzLowJXYttbAT93590E1xdQb4AKuEvJk6iNDNay0K1ml2H2d24zxpTxFdGM/NMEKftG7uZFWoqHCPhAR60L2tvfkUsxGgbB+N6ZE770mGeBEtfBpJ9q6bCX9WVdP1v6US0k4/m8cpg4janyJo9gsam+DARSoE+XzbGgL/IsYPE5tHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8936002)(478600001)(8676002)(316002)(52116002)(6666004)(4326008)(86362001)(6916009)(7696005)(1076003)(83380400001)(66476007)(5660300002)(2616005)(66556008)(6486002)(66946007)(44832011)(26005)(186003)(2906002)(36756003)(16526019)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oMk0WvzWqchHlgUhYRGzrfyl93T0SkSvc97ynSIh3ohDg0rxkmhieDg+TgSQiVAtZshpGDM9XykxFFX0IVrr2bWm3CcN/XAxqgCvnPl/pmRq7pDqbqi5Jw4jR48HivZRiYowOVidzz5ph0pZodX27ghmqN6JMtUUWZGrbHeZUDPiZ0CLgGR3qgnAEEr1WSh89llgbHo4tQSGzeY1NIWeBwoCt/A1KPpRat4cMHHQOJGJ0WvofYlg65GcNdb+zb0A+p+F4nWmDR4w0WQQwcM0cJG6sfLPnPYtIeDcZJ9BfAMmKwrFQbiJTF8LRqK2gerj9Je+h1PNl7lgw1Fh1x9od+znnTI3PPCLRgXsAfZYtBa2CndW0ueqMqTqlapDnvXT8RPfR7xggNqGxQ6EolobRaKcJkzTKq76HH79ZIyLCmARN2H0DKwni2Gefx7UGRF7lC6Vy4cd44wZIg7NFFRlzvN2HKSSvtu3h/Gf3ioSzA/p/bvwl9+6PYoPKKJ+l/Rg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbf4416-ac03-4d52-3ce2-08d80c5ec9ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:20:52.5791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH+zZf2X1XW+yReuo84Z04JLg1+DK+OyUXRxFaTO6MWxEZl17JDrrzRM7lI2VV+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since SMU_MSG_GetDpmClockFreq is known to be supported for Vega20
and before ASICs only. For those ASICs supporting swSMU, it is not
supported.

Change-Id: I8ee71664baa32e40df5bb793550785120f3770c6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 9e3fee9e4aca..d10d15fc7492 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1089,24 +1089,13 @@ int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 {
 	int ret = 0;
 	uint32_t freq = 0;
-	int asic_clk_id;
 
 	if (clk_id >= SMU_CLK_COUNT || !value)
 		return -EINVAL;
 
-	asic_clk_id = smu_clk_get_index(smu, clk_id);
-	if (asic_clk_id < 0)
-		return -EINVAL;
-
-	/* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
-	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) < 0)
-		ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
-	else {
-		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
-						  (asic_clk_id << 16), &freq);
-		if (ret)
-			return ret;
-	}
+	ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
+	if (ret)
+		return ret;
 
 	freq *= 100;
 	*value = freq;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
