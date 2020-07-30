Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D42CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3465620656
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3wLQDiuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3465620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2A76E8AB;
	Thu, 30 Jul 2020 09:15:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7156E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G44112jTtCzFyUHbM8PxDNN3SCGgCWNLozedpzrdVm4hAv+TDdWaZwtpoE479t2PQyuJqIBHwN0gRXPziu14iL095koO0Ho+KUreF7ykV2438QAGkEfbdeTL15zFCvKDj7ZYKwNqWe3Q1cx0ZfwVc75Kf52dMxYdtrpFij8t5rXtlIpHlu4+x6far5dmK8IkImag9gnv5hmTZcKrx1XV9D3iv0KAh9wJk6McRM7vTvVYaYE/5mHVYPHNv+4gyiHv1yrPimGkEwRBPuykTzpW1LJkFwmbmayVzTOOFJuE7cAM0A8aHzZGwZTtpfbw0crJOaXPFgD75b3IEqUWoo7XHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWI+0eIDsWfhl7TWfTPh/uDKJlVbHzI+3BnkUMpxa+U=;
 b=VnDb4lQ6wzyfOqAqKY41bvrNRYklmDJyIDBYMioMI9vBAeCA4dBUKEY9gp+4jlvTR6g0dgz8776EARYhvWAlsL5Qo7cbAkwz1rpNjVDiSgeIIwdkhIfVg0ZprUTfIYsbUhHT0gYu8E58aZlxXfSxhv0WSZKdkMAtMOeG6bolzMhK2q/5AE9k0iiZktcZY0pU6p1RBZcedaQK3183eDaJ8o6gFex8Fn5/lPTloryenVPtEKAaTeDbaAfJhUFu+YscMPA/JAeJGb5/kKNbaimk5XMAj63dUhMwcjX+KvntckR+MuciYwkvEZtgv8YC0213hPvAEUWfA8y/JkbjNXJIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWI+0eIDsWfhl7TWfTPh/uDKJlVbHzI+3BnkUMpxa+U=;
 b=3wLQDiuGiIOS1U6dnrVcP2FAMfY2z5LN14J+zgZ14JnVx4WUL7heN11c//9WNRZZUSeVGWCxJOEMbY2lEC/d8MV/e7rmEcIutV2gKnVzUWuXK4VtRyiZCbtuIJJJvuEH5Hwkk38GRnBaAa2xgy87sgSsFjwlNEVDenxPi/cYta0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 09:15:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/powerplay: add control method to bypass metrics
 cache on Vega12
Date: Thu, 30 Jul 2020 17:14:36 +0800
Message-Id: <20200730091436.4551-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730091436.4551-1-evan.quan@amd.com>
References: <20200730091436.4551-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 09:15:29 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ad1b443-2b82-4106-ae0b-08d834691b1a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092F34BF618F42D3999C48FE4710@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmXqh/2+1FEkNbUUzl3wVD1Gx0surmT1HB3iFLesQ9eD6Wsdl6E2m68f8WqObENQqk073quuDXSGDpSCghixKH5cfO0+bMt/XQAk7QhMoYdXFFhImIb8gtJ9V2OehjzC5K96by9JLZHWBw3CiLnNTicCUA5O6iR8qVgVELnysh7/q60C64lNCAyUoOyTOxQiHxHu2MVi+SB22KKGji1R6SjV6kEsr7Dsno3gpcH4B2QS8VmdB53LIYqXTQ/KL5I+PzCQN8jxXln7CyT0rtyrGwuS4ID3115YKoTG6jmiZuceHx08z0sj2stbkYXFyVuBbQxiSrxBy3gQP3f/QK2HMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(16526019)(5660300002)(478600001)(4326008)(186003)(26005)(6916009)(44832011)(6666004)(316002)(6486002)(66946007)(66476007)(66556008)(7696005)(86362001)(1076003)(83380400001)(2906002)(8936002)(956004)(2616005)(8676002)(52116002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: md5tz56THQh+Gjyo/4fT8+nUbVDDgVPjNRwB8bh6Zn++XJjNZHKJ5wBEdBuMW+YR5Raar4tjVYLoG1/WIxL0VEJzTCognepm6YvzzXehkadBCG5BTNXK0MF4OF5mhklwFyDK5gilHfte4bZqFoEFGW1Xov5nRD9F72o44TelAUVI//D6hFRVVdcl+d1f3KorNeY/TUrd9NOdD7s/OFhCuLrEDwsx+IQhQKd+QUwWqGm7aqwO+fzMQWR9jhi77/1lfkMTVAzfwES6Pn8YUJCBwTdbCoWGsp4D7vIuuaZkXnI1o+4DOADJ5cU3ZUhM3ANpqE7yGdKkRmTBp+cDocgXSyPfTv2fYRAOhRQC6O5+O6TE42hnEEEKa4vDIYwPZ8pcP3s20Z9llyHLc7gn0oJj5zraT6LbeRK2QyvhsJM7pFveqkfOdrLOh9Omjepr20d7hA6WCDPNyr80QJsjwLk+KUVyweoVDypf+c998Ml/Hyqzr5QA1dVNOE9CSZiHUGR41kIfdWR5F5MWg4COmpvTDiiMCDWUxc/dlavdEFMZd9IV8hROP1voqGZvgoPl30DkCt/alXh53oQFPuu0w+XCgB9BzUo22gXZDBqegW7rHGRTPwSf1PBdPPhb2hjDJw1ft2Vy/hPMc82ZK4pg0UizSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad1b443-2b82-4106-ae0b-08d834691b1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:30.6077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnjBnWdr1z0tiOjGDucwdnVqww+uotsVtHvSemJxThgFdUxvHqyLzoFEnbzeiJgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

As for the gpu metric export, metrics cache makes no sense. It's up to
user to decide how often the metrics should be retrieved.

Change-Id: Ic2a27ebc90f0a7cf581d0697c121b6d7df030f3b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 67e6a0521699..e5aada3b2d4d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -1262,22 +1262,29 @@ static uint32_t vega12_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
 	return (mem_clk * 100);
 }
 
-static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr, SmuMetrics_t *metrics_table)
+static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
+				    SmuMetrics_t *metrics_table,
+				    bool bypass_cache)
 {
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
 	int ret = 0;
 
-	if (!data->metrics_time || time_after(jiffies, data->metrics_time + HZ / 2)) {
-		ret = smum_smc_table_manager(hwmgr, (uint8_t *)metrics_table,
-				TABLE_SMU_METRICS, true);
+	if (bypass_cache ||
+	    !data->metrics_time ||
+	    time_after(jiffies, data->metrics_time + HZ / 2)) {
+		ret = smum_smc_table_manager(hwmgr,
+					     (uint8_t *)(&data->metrics_table),
+					     TABLE_SMU_METRICS,
+					     true);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
 			return ret;
 		}
-		memcpy(&data->metrics_table, metrics_table, sizeof(SmuMetrics_t));
 		data->metrics_time = jiffies;
-	} else
+	}
+
+	if (metrics_table)
 		memcpy(metrics_table, &data->metrics_table, sizeof(SmuMetrics_t));
 
 	return ret;
@@ -1288,7 +1295,7 @@ static int vega12_get_gpu_power(struct pp_hwmgr *hwmgr, uint32_t *query)
 	SmuMetrics_t metrics_table;
 	int ret = 0;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -1339,7 +1346,7 @@ static int vega12_get_current_activity_percent(
 	SmuMetrics_t metrics_table;
 	int ret = 0;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+	ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 	if (ret)
 		return ret;
 
@@ -1387,7 +1394,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -1396,7 +1403,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = vega12_get_metrics_table(hwmgr, &metrics_table);
+		ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
 		if (ret)
 			return ret;
 
@@ -2750,7 +2757,7 @@ static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
 	uint32_t fan_speed_rpm;
 	int ret;
 
-	ret = vega12_get_metrics_table(hwmgr, &metrics);
+	ret = vega12_get_metrics_table(hwmgr, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
