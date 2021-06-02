Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA614C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB7561C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB7561C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC016EDB5;
	Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49B66EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tns3TB8JUkKlnhar6gRIrn9iKMFo9rosNAeT/VPhkea+ijHoi1UUfCDNOc9+4I3bqF4r93TgtU6f4nM+Qxr4c6sM2gV7eCQeJjWEl5zZvwKGmjgKRlUoulO/a+Gu7ZEusuUmX2AH2B/FFt/PHD75KfkwrGq0u+jQS/Vm6TRB24J+21urxQIBKoCf6P2nOjoEx/QgbRnDlIX3qwkFK6uHusrw3YbfR28ZQJXb2nwCBzDeBNbJHCL8xXwF/MwAbf2SDvqu8yNRcID9Kdgme4aCrW0iEgWkwUu5+FXc4dn831OtORC5fLyJ/cMmOkHyeiyx6xR1COrJSKDy7ld8CUx//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGOu+l72Hn6rNNfILh1kx1M96V//c67GKLaNfWCD8Fo=;
 b=l0NqoZsK0BTGv6EeZJ2m+0oZX4kYVVynTuWDoSyTm2tgZW9VY3Kl9ndVciUrnpPOyi/LqWBZLY4TZnzrlVzK432Qz3DV65wGvKNmHG9Hkc9lvrwlUPW1CbsJj8lRUzqRMTSTgONdRbuZSOyL6Dibcz3syGYHn7c1rbx30AxA7F61MLNmlUwE4EZggYyjTJwd+hbF451PqyoLY4xTxOCnvy/mFbY2XfFDtQ47T0vWHgnGAy803aMNzfYXmof6iR1MOr7qZ92YFkGxP1CN/8aokDEcp0M311Uo74+Ku5rqNKaeMfvfdiEX5IVLQNwm0Tt3oWDRfbecoDStjOBXUNVB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGOu+l72Hn6rNNfILh1kx1M96V//c67GKLaNfWCD8Fo=;
 b=gW3mP5krJKjTNiiiwvuJZcCrqj721kS3S/NCmnNNmlU5UPsvgs1QN1vCpcVTAXYcKNa7plFPCsIHsgcIYvzwaJbObOb+ASLyKSx/Amff/8h7BgNLNmn6Gb/Wxkl+H6aUiDV050/AInf9uNuSCpwHeRKZoS8wLvT2ydE431ldZU8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 16:50:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 52/89] drm/amd/pm: add support to get dpm clock value for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:31 -0400
Message-Id: <20210602164908.2848791-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d740026-72b4-413c-7e79-08d925e67860
X-MS-TrafficTypeDiagnostic: MN2PR12MB4487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44870D2A56C10FCB13B5D979F73D9@MN2PR12MB4487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcbgIMocok0dgSDEf1azZHQA48plEEDmrRjpf86cD0bEULpakTtjMTlZnTiRlKkrnN2IXY2/5AmwVDVt6db/VJ9rbWgoWrwjvlcNOvRPPJSKAW3Ac4gYps4ciPXG0AWZ/iak9bBbk6nPJv2hL6Wgwb66xBcZ6iSkTQNuFeTurkMgbEpl9OdCJT68YE9U3cO+5kUfZmnp8k7ghoBP/chOG/ess5gIHnrpR7EQtHbtDnMCacAl+wstrqa/BLnWYLtnoqSJrRYMbEjawYt+6bV2Lh7hJQFRkpGAG9q1fHGrnBuJeHvaDq156EQ31F5uVwmjSqturV03M9gO6ehXjlOaLgsBorBgJNpJsgklRq9ZysKhFBQ901jqIZsb4UETypdCE94jCSnDvSlB8srUjtFPTIXWKInE64JFUtc6jFEGrjt6XQRn7F5ZKRUkt/MrBfoBkrK3I6ih4GzotCs0QcM6enzlDw/K7LajBjI9ChzJ1ku2mY75W58GUrku45ZcFUzmJD/2ePvdsItEapavOrHuZ+I859nkvlX5qjZivNo1YFXwFL7HPPOG+1q8DOVMYt4X8MZT44+92OqMbfBSS1z0VsuNaS8woWAy4B/r0EuqIJawyRDb3KqdGQ6iwoV2hSpqldJQ3j3ZfHkB68Icbjt9ftJK4HBdv/LwEKdj2lGt8Sqnlli6wXSFdyxQsGqthV0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(86362001)(54906003)(1076003)(8676002)(478600001)(6916009)(6506007)(2906002)(38350700002)(8936002)(316002)(6666004)(36756003)(66476007)(52116002)(16526019)(186003)(26005)(83380400001)(5660300002)(6512007)(6486002)(4326008)(956004)(2616005)(66556008)(38100700002)(66946007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1Ze/AFhfJvSJdi++gV64guReWyjbsKeXA36aRNff6t1C1WIjE2T3Nuwudsr+?=
 =?us-ascii?Q?R1o2Fo/5qdEBRKF8D9+iWCr6VyAvGwsg7bX95GTR8p7x9y95pMHf/GT9pSPZ?=
 =?us-ascii?Q?UVDj2fuwMEYHFVDAUz6YS3PLu7duXcZoh4PxR8XOQLR2NDh8CTNzrGI9pENr?=
 =?us-ascii?Q?Tvz3RHB19WcLIp0cH3uNMmkcDZJ/md3kZnrTac6CgPlJP8Jnt79H2VUqhh38?=
 =?us-ascii?Q?LsbygmZlOda0OL9sJkog+FwTaedv4E9Lt53bgVqrolfUiKlyfGIwXGc6E7SL?=
 =?us-ascii?Q?AzhRfOo6Zln3wMR8OBqwkV4zWseC5r8MXzCwzeBEPq7NkHXOytZ859f4b08q?=
 =?us-ascii?Q?K1NwWAW5MeAWOW+VpoZkdEHjRlqzTAtXyeQlI5Xbb9DjLrt6O1kVUhua0toT?=
 =?us-ascii?Q?Zghs6ZOem0Ac1RRj0ANp/MrYaho6sbjjcipEbGeFdOpbIf2KPfTJ7L+2vvVN?=
 =?us-ascii?Q?uzhgHB5cPslRjMbsUoHy2WF0mTwpGcISRhAO8FzI9O+RR6vVuoTOyJ8y6f9T?=
 =?us-ascii?Q?S9/0hleZPFQgzwb6ge6Km8uSQ7XtwQdv03tJSB/+zHvn1SJ63/3daNsuXKlc?=
 =?us-ascii?Q?pkB5VPcVLh7ymc8Wrchv8lleXs4aEWlnD4O3ojqGE6C84w9oBk2e3EnZrqJl?=
 =?us-ascii?Q?qjOIsyzSa97qKMjaZwcmbCmkQSru/j36Pg9egyXccxG6gvUPeN9c3uv+xio/?=
 =?us-ascii?Q?g6Y8UEOz7Z97JkK+juxJN+5k1L7zyeHd5o8qg8q1mltMLMqnMKzCwcnP91Ja?=
 =?us-ascii?Q?QkCi2F0jEzgUTRCi0B4H+Q7hgBJHo6v4ru174nk3TD+g8YWDeJVZpEs3nykl?=
 =?us-ascii?Q?r+bOBSey+wxSvLtCVLGuS/RJWqM7jQNcZ93Cs2QB6o3/NfG/VWjG5/DzHrjV?=
 =?us-ascii?Q?+YVzDA/Xbm4JU9T4TRIqgeyZ2FEQRDJLoNSRNGgG0pJ4lhGWObbSnpozcznR?=
 =?us-ascii?Q?Bn4V74GstYawEdo9WZy9Tfval2MlULgGCQU6tWjmD8RhKWdewEgpTvF6kvZr?=
 =?us-ascii?Q?DOuh9824vQmmF6degl5RL395m5ZpYTUMWpBB9AEyrBsoRXez6ttJbLsCNLc4?=
 =?us-ascii?Q?OEAWH0T/x8Ffb6m0KoRsryU+dBu8qLUmNHyjTa5w6y1WGZ+WjvpfXnxLpZsv?=
 =?us-ascii?Q?3E0W5PsEIapjFmkw73jPPm+T6qjGme7NKrysJNk/QFftjPirvyNbMwQXhMgu?=
 =?us-ascii?Q?RJxpNGciCW2JNqPcISeNHTQbHtl+3CHt4xj60GLL2DUmJ8vMB+rIYgBRqqsM?=
 =?us-ascii?Q?1ki5Lph7dAv1Q83NMYp/+WAxgQsBN98INvWZan9j0gUVzHeydW2UfXNYXiSz?=
 =?us-ascii?Q?KixIrSMpp1ARO1XbPv4UcKzd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d740026-72b4-413c-7e79-08d925e67860
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:04.3434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsYtuuSNMZ1M03FQPLUw7rFk5Sl5aOaOHr4/IPZuwa/nJsO3jaCHOhpFhcJmY+Xsp7llE1v6DIV4cE3Kf5PVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Implement the sysfs API for getting values of pp dpm
clocks(pp_dpm_socclk/mclk/fclk/vclk/dclk) for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 128 +++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index fa871df86d86..211cc9bf1ca9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -458,10 +458,113 @@ static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM
 	return ret;
 }
 
+static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		member_type = METRICS_AVERAGE_SOCCLK;
+		break;
+	case SMU_VCLK:
+	    member_type = METRICS_AVERAGE_VCLK;
+		break;
+	case SMU_DCLK:
+		member_type = METRICS_AVERAGE_DCLK;
+		break;
+	case SMU_MCLK:
+		member_type = METRICS_AVERAGE_UCLK;
+		break;
+	case SMU_FCLK:
+		return smu_cmn_send_smc_msg_with_param(smu,
+				SMU_MSG_GetFclkFrequency, 0, value);
+	default:
+		break;
+	}
+
+	return yellow_carp_get_smu_metrics_data(smu, member_type, value);
+}
+
+static int yellow_carp_get_dpm_level_count(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *count)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		*count = clk_table->NumSocClkLevelsEnabled;
+		break;
+	case SMU_VCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_DCLK:
+		*count = clk_table->VcnClkLevelsEnabled;
+		break;
+	case SMU_MCLK:
+		*count = clk_table->NumDfPstatesEnabled;
+		break;
+	case SMU_FCLK:
+		*count = clk_table->NumDfPstatesEnabled;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int yellow_carp_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+
+	if (!clk_table || clk_type >= SMU_CLK_COUNT)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->SocClocks[dpm_level];
+		break;
+	case SMU_VCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->VClocks[dpm_level];
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= clk_table->VcnClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DClocks[dpm_level];
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		if (dpm_level >= clk_table->NumDfPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->DfPstateTable[dpm_level].MemClk;
+		break;
+	case SMU_FCLK:
+		if (dpm_level >= clk_table->NumDfPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->DfPstateTable[dpm_level].FClk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int yellow_carp_print_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, char *buf)
 {
-	int size = 0;
+	int i, size = 0, ret = 0;
+	uint32_t cur_value = 0, value = 0, count = 0;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
@@ -476,10 +579,33 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 		size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
 						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 		break;
+	case SMU_SOCCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+	case SMU_MCLK:
+	case SMU_FCLK:
+		ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			goto print_clk_out;
+
+		ret = yellow_carp_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			goto print_clk_out;
+
+		for (i = 0; i < count; i++) {
+			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			if (ret)
+				goto print_clk_out;
+
+			size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
+					cur_value == value ? "*" : "");
+		}
+		break;
 	default:
 		break;
 	}
 
+print_clk_out:
 	return size;
 }
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
