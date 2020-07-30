Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12567C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D73020809
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 09:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VZQj9z27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D73020809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC786E140;
	Thu, 30 Jul 2020 09:15:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4AA6E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 09:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4DxLiVs9VzdQj8CyshaH406WRztCu3wXjbLvikWYoBocjeIUjRuVq+OPXI7JOU16x/09bCUD75dkjXYyMtYfzNeHfsmrXhf52fmRhzxkDzfZBZ4ROAFnkMWcPPbiLuVaAM0BwLfhiFvwTn69OXx37s2HoxyFDqWyptSALUN4TDkBWHKwM8DwFsqWWSUruUhLl+JrtkrunEkoashkZaQUQ1PckrDh4oQ4o8/Pt1AQU5ydOgSWkZL41+uyLm+1cogj2GbTtzt4yZDvLnpd1kFWeEQGgqy4AuJ1nPXHqo637KAT1No/cubLi9X1RrfqixqvPaR0UEzmOgujVTuhCPk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZeWaN476E0PxxKo2MtStLuJvEPRBW8bVg4JXIuXLQ=;
 b=lXJWGcZ50USmK0DmEatRgLBZrPf+YdCREWHHHEYDsYwNRgKKC7pgI7WmMEdQMoPDCSi7f/BTcoTi6wSmwr0XQkXw6wDs0O7+9guhU5yACtQ8z99FhkzXuPdEjGavfNnzRDTiwCAqJZR9bpR0csDojVxKfzdC7MAQhquDP9BlqIaXvaxT0hceDI0/QtULaEp/izro8JFxNSnLwN8j8QdW5nHOQT6bPYi8DlIRHJ54IDnbz/sLgPJ6b9azFARyluJQGtP3qNdjJEoZ5DMEA+NzkkppG5et7zzwjNxvKuWgYGAbqcZF8xO4mgQAp6VTNFt2WkVeRSexxs4PN5uBX97kNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZeWaN476E0PxxKo2MtStLuJvEPRBW8bVg4JXIuXLQ=;
 b=VZQj9z27VOdETkknyKuDTi7obJXlvAEjiG5xH1a9g52OzSosXCyaOI3VGAhGIR2WzEcaQU+jbVAawXBIOt9HRAyHbw8pJrmSpDDj1luhfWHucYRPsAKo/58aJXns+ErTKtCYQ69Zjmqh8uMMNG2DBqpKPqUOvQ47sPTEvRYhX8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 30 Jul 2020 09:15:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 09:15:00 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/powerplay: enable gpu_metrics export on legacy
 powerplay routines
Date: Thu, 30 Jul 2020 17:14:28 +0800
Message-Id: <20200730091436.4551-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 09:14:58 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a33ae129-e39f-4513-fbb3-08d834690905
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB002763FED9C3A23B01CF5AC2E4710@DM5PR1201MB0027.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+7IbT20L+Fp2gdIA3ZdEo0wOJTXKVNrUljNw/GwNS+dHi74c3ELZEKT9e+V+Y7dhH8sKh6GtJPHe7wBO3ms/QlBjlgcVvgd4D/wlQjmnomik1u//c3Vc2YlQ2KlMtU1xzdvXhtj9emLEjHHSMRfwYCD6f53GpDAi3xKL4HCeedyd6h6UB4Voea17aW0eBjjf0aCo7O+rRQ9odbpyTvDh1Xr+89qC96+9jy7IPOs1GgRM8+xkVm8T3FjJoFsAwF5WnaaDL7+7YXb4J4Jv1XOTKZwki1wAh+v5N4ze4Zuj80RBkUgwGFgnXw32G3LzlQSL4fxcdcxUSwX4iUtosx3yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(6486002)(4326008)(2906002)(66556008)(5660300002)(66946007)(6666004)(66476007)(1076003)(83380400001)(26005)(2616005)(956004)(36756003)(44832011)(86362001)(8936002)(186003)(16526019)(6916009)(478600001)(52116002)(7696005)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4MuvZ2/qhtTJRi6jNndKMwF1JCGov3kFpmm6i4thbQxAaXRnGst4cMQ5rdx53RL0rriFyFmdSngtAp3lzSPCkEosIuThCSxjYDRd//9/71CqDewajkZc2IYahZPoLCQ/mfsca+TNpUZsqaFEyw42ANdBTjRHxcJeHkmv/IpDJM4fDiZPVVm8hU5rsj1o1v6RBcL10AjNwF2jZoqplSBMgVDNEb6q3b1cXxfx4+dt8TtdrZrG5IXWrVljtddlKkznvU5jygv4AQoXybsn1MaoOn65mIkr1KYnZhsdZqmK+4WjMKLiVo7C+xbSaiLAvh2mAFJqfhxoA3YxgvGlfDKUet+FI87eCHSRRbqsMjf9DRUEJxy+SQ93/serVORq42/D1gVB0xQYwjHW0KNp6qCEubpUiPuzh2kVrZHNcEoo262Cs3pyI++wp2bNUIj2zqSKu1MMgKqhRcF2SKie0ZvvUfKAU7QslPJ/ig6wuvbUSOh/ZrZwl9GP05y5Gznf/Kiz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33ae129-e39f-4513-fbb3-08d834690905
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:15:00.3540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d13nrClO0aPxZ7V1plJXpDC8uZOPUkPTS1hX2jZKtrEuY5xTdXkwALKLDqq1/NC8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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

Enable gpu_metrics support on legacy powerplay routines.

Change-Id: Ic2f09babe7e6bead9a838b7ce3c94bf8d4110991
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 7e6dcdf7df73..a6321f2063c1 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1598,6 +1598,24 @@ static int pp_set_xgmi_pstate(void *handle, uint32_t pstate)
 	return 0;
 }
 
+static ssize_t pp_get_gpu_metrics(void *handle, void **table)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	ssize_t size;
+
+	if (!hwmgr)
+		return -EINVAL;
+
+	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_gpu_metrics)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&hwmgr->smu_lock);
+	size = hwmgr->hwmgr_func->get_gpu_metrics(hwmgr, table);
+	mutex_unlock(&hwmgr->smu_lock);
+
+	return size;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1658,4 +1676,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.smu_i2c_bus_access = pp_smu_i2c_bus_access,
 	.set_df_cstate = pp_set_df_cstate,
 	.set_xgmi_pstate = pp_set_xgmi_pstate,
+	.get_gpu_metrics = pp_get_gpu_metrics,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index 15ed6cbdf366..1b3529efc91e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -359,6 +359,7 @@ struct pp_hwmgr_func {
 	int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
 	int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
 					bool disable);
+	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
 };
 
 struct pp_table_func {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
