Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC74C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099DA23787
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 04:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099DA23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF2089CDE;
	Thu, 17 Dec 2020 04:15:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D8D89CC9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 04:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0uU587IA/uSYt76Rvjtg9Bj3xpVmreok73veRz24jgXg0bQnO+cFj6oeG5qOKE4Ir0+HPBbwPDyuLuwSsXN5U+wS5soa6SEB31z+wCu8oBLkabxxCUCKBJMPPYOd997eYQ+ITh6+AoQTAhGh6GkM72RW3lPyNQcB1MJr3TckOVn6M0jjZ97czOV1RKxlq2kl1FYGL7flYGqTAnHvO3bh6DrZhO8Uci6KLWmL0up40n/mhVEZ6eTdj544VoQgOysulD8WbJNFyqLhrJHK3cURg3m7v0Rikd+0/BXOAoguD4mqV2+lvTbd30mlMxzmjH3D42XSGkSekk6MYgP7m4Tig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvPd9ozcx7XxPgHjaczrLvI5uh+pLqKs0w4VSZ6uqzk=;
 b=f35dgI3+sseyDNQIGBPApQkzFeb8Z3JS5VM2VpZLPUNWPpgdQt9ZyJ3w3XtfKxu7+FM6xakamJib64budmNnFGYUupojUbatzQIDLm3P8qBO42uZADKSJp2+S/ri+VlMNyxaMT0PDfi23RY56aq+nTEfnSont7XuLEDNTjrkKkOvr9LmUdeh8w0EI+d/hVmq8sOFUiZNdlQfKjaX3vA1VDpPP6AIwdcl9qifpV4dWMDTKKIx/S0nW4ZJrHHe0PVS0EAS8E0iFSHKcOH7YUcHWwuuSkUzTTJWOcONTpsqK8QO5u4knJ+1aihD4kbiLrpi7cQbU2jqGBPq8J8TDaXKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvPd9ozcx7XxPgHjaczrLvI5uh+pLqKs0w4VSZ6uqzk=;
 b=K8C1m1qPPwFRULX0Lmv+kHGYiHj7X4tM4IO/0ci5UbFbXgqzQGtNar8Wi1KAzNk/03uCl6VZh1smP+XyA7Ch0UrCwADhpxRbWYWN33+veQ/5Wwu1ZwSno84Tm6O6slEj67a7XG5MzZv2GWs3u8sZ/1k9MJSBISHadsF7893OGaI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Thu, 17 Dec 2020 04:15:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 04:15:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: populate Sienna Cichlid default overdrive
 table settings
Date: Thu, 17 Dec 2020 12:14:53 +0800
Message-Id: <20201217041455.87870-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.9 via Frontend Transport; Thu, 17 Dec 2020 04:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d371f38-75a3-45c6-e4d3-08d8a2425d58
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359AB530DF3A2E329673E65E4C40@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mij3+nmjWBZCg0ZlyFQUFiEOdwQZp0nH6nyEBat/8bsiA75GPwoY89gdCiIpQXUxR/KvZVgPwLSDAVNHnVyANuHImj4CrsuqeIZc5byRuG8l6zIYUKbFxkOIf4dMI2PPvDfUwFnqJ29LI9sMD/W0J9DzAZHXtfgI3QJLHd92A+2zmkW/uIIsmW/GvBCaZFMlVj7gUUWda/H0rN7LTnGDmYtmqSlkGUEBqhhTCxqtfwH0vjLjMDB/RrE5aMu0+BkY5SYcFPjZVZ6wX9RtS4A1SqD78NT0zNl6VVIFsizU8/75hgorEPY5KNXN44OahlvQidbD0wkK0o064aeZoYFDoMGa5HlaYmJm/g7+gwMjpWJcXeuG6l+rjNBPihjR80HtAN6ui75Af+L4f1jPjH3X2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(66476007)(66556008)(8936002)(54906003)(36756003)(1076003)(26005)(8676002)(316002)(83380400001)(186003)(16526019)(66946007)(86362001)(7696005)(52116002)(6486002)(2906002)(5660300002)(4326008)(478600001)(6916009)(44832011)(956004)(66574015)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sww7YkmOLwySQBZJVl3Ti+iU3vA3f8GDSjpgRnxrGvkObRVTUD/BmJJ9AyuN?=
 =?us-ascii?Q?aTbv/k8uqfx1dtJa4840VQsOgTY99t9jjam54gMr8jjFLvalPgQ7vc9WJ3qu?=
 =?us-ascii?Q?GA+X+eepJRCc1tueDJkg461gJZnzHINly6ve8FLz5E2UxsQL/k8KhhFk1/fZ?=
 =?us-ascii?Q?+1w/BuhrjmcmbPu3xb9gpnxBhn8/KNep9TyhSi2MaqrmNVpHg0gUZJGnfBzb?=
 =?us-ascii?Q?/WyTDpB1PBNA3EopjfGsNEuvohw3SMRrRega99U5Ta7DQjMZx0Vrc31bQQI7?=
 =?us-ascii?Q?yex1cxX2jKW8BfvlPEWIjpDSUH+9noRtjEjsQ9JlLLW3rsv9Qhv/G5Xgo8pl?=
 =?us-ascii?Q?cC23IS0C0XRb4xeai7PMPQ0tjSiCaC79fvDGDw7gQIM4lrnYbSLOWDnCynfo?=
 =?us-ascii?Q?jh8krcDEieRzb+t5MQcd/3CJEmIUfKSGkKJM9MZzYXpcXOetfwZhQ4XlS8YX?=
 =?us-ascii?Q?EuP4vZWR+Iany1ePPomJbjfWW5NZjm67ufHRT4KKRiXuMTOeHTeEAD7CbL9X?=
 =?us-ascii?Q?AIOOt5zTNtLzIVFyk6qNxQZa6MsP+dJJptLSGa71BqCYkq/ZwjIISuuegxRS?=
 =?us-ascii?Q?FOtWjqczRH7lQyvInwtzf6qTb2ZpKp7z/3LKZxl6XITSOWrc+IFMcnn2A5W7?=
 =?us-ascii?Q?zKo2VTSlYY/zWjUId/nBa7+sqnfO/3Xs7HyDChiBPPXy1iVUP/P4ZjsMnNWm?=
 =?us-ascii?Q?qxjdEQ6ilMbmzYEZu99P+4U9XSSGJdyuevmEncw5AA85xT9V4J1/938SbdP6?=
 =?us-ascii?Q?5noFtioceZCVI/1OnQSCAnhGnQ5RBU5CWQN/xSagUQhR/jTtbpXctodmg8FG?=
 =?us-ascii?Q?niglIsLK4XSzyYbgNERwL30xdtHKQT8DRGtryJtV3d9FPyXfrXFm9oKwNC+T?=
 =?us-ascii?Q?C1iXmdoidlYS2P+6Ds+nK7DaRpavZVhRS3HxCLYXVve6jRu35hVNn6ZW0EOk?=
 =?us-ascii?Q?9EmPhPTACIYYfq+rEfrH9CbCCg7/ZZ8shTJT4eH2Z5lxjzQuj3DnxOJ76i1t?=
 =?us-ascii?Q?WKY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 04:15:18.9194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d371f38-75a3-45c6-e4d3-08d8a2425d58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Lx7W8e3DEkxtOKov9B/pQvZJKqj020eOJUMA7KhrHhMddKOtRI7uAL4dQ0eVan3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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

Populate the bootup overdrive table settings.

Change-Id: Iaee8c8afd5cbf12008aa6ffe0e90c8ffe5aa4fe2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9608745d732f..cbee4ca43707 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -314,6 +314,12 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
+	/*
+	 * Instead of having its own buffer space and get overdrive_table copied,
+	 * smu->od_settings just points to the actual overdrive_table
+	 */
+	smu->od_settings = &powerplay_table->overdrive_table;
+
 	return 0;
 }
 
@@ -1694,6 +1700,37 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
+static void sienna_cichlid_dump_od_table(struct smu_context *smu,
+					 OverDriveTable_t *od_table)
+{
+	dev_dbg(smu->adev->dev, "OD: Gfxclk: (%d, %d)\n", od_table->GfxclkFmin,
+							  od_table->GfxclkFmax);
+	dev_dbg(smu->adev->dev, "OD: Uclk: (%d, %d)\n", od_table->UclkFmin,
+							od_table->UclkFmax);
+}
+
+static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)smu->smu_table.overdrive_table;
+	OverDriveTable_t *boot_od_table =
+		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
+				   0, (void *)od_table, false);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
+		return ret;
+	}
+
+	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+
+	sienna_cichlid_dump_od_table(smu, od_table);
+
+	return 0;
+}
+
 static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
 	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
@@ -2817,6 +2854,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
+	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
 	.run_btc = sienna_cichlid_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
