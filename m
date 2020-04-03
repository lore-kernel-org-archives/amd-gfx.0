Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A2EC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FE92063A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 07:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NXpbQMBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FE92063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8DF6EB11;
	Fri,  3 Apr 2020 07:03:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BDB6EB11
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 07:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVh1wHqYu+LP8bfWbl/qv89NADcpqt0je9YWsMKzV0OTHZSKh6pkf1kZdQe5iTUlusMYlrpeOp1Z7ikGf7apuY+Y6ZU2vaXONOBThPoYfkp7E6zqYRC/gH4mhy6t9hFXjOZm9sn+AJROj2ltKRm4HjVgdHAmJqe/m+NFLX+OaYqc8WJrmlM1gIDiYuJ9NhUvVCKJAX/hCYxYNMXv6Qkbv5hnbSMJZpuA2lLorymNV2UwnRuxVBLKT156N9UvGzIQ/z5PXXnJTMmMH+CC5iG5oikWE4RQYP6V+V0pwjqgJ4Z/K1GZDrIsvxX/7Zp8geNI5P9jzTCQ29+O/S6X/qJdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJpaQ+HVUjUAuCCH2yX4w0WM2/DboS3gARTSSyiN91Q=;
 b=To35GutVyzkiyxcLsmfBKjUZ16XBxxcydzADvRIpy8q0O18htpuyAKZv3BWT3pMqBNMQ2TX6xKAsTFjgw21Hb3dpKRIpv6tK+ttTCsTAz2OTL5ynuuLtlnCGL7aoGzo5kzi2VbmZmJ4gxjaUQ9hGv4eT97HsQZ0XOG7ZZw0JEU7l7kDc+7SqlwxWOpbRjkjPVGbNMQhdEQPYkomxbmm/U5zOqYKekY0cWovwV6GrIDOlGf5XVMMmKuBSc9LI9WC12cQlTSELfAx7vgAeKmhnOV6g8s7F/leuQeU76awjNVso+NxRQDLtA7Fib7uTxHs61pNE03I/co2X4cXR2hOpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJpaQ+HVUjUAuCCH2yX4w0WM2/DboS3gARTSSyiN91Q=;
 b=NXpbQMBairmMrrKSM7xEu69NVeSbAcT6y5QPr7S7EmwppGbpIQDBO9rJ9VNXnMMd0aRY7g+qVH8gx4w5h82u4+th83T6tUsWDLi7/I8N4xOjxWsbTv8vya1Zq+fzxeGoESoAZ4VqM72tLqKr8k7R51HxiS8aq/0QMcvEKE/LDBI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 07:03:48 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 07:03:48 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: error out on forcing clock setting not
 supported
Date: Fri,  3 Apr 2020 15:03:19 +0800
Message-Id: <20200403070319.10190-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0072.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 07:03:46 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25e37989-60cc-4ec1-d761-08d7d79d2806
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:|MN2PR12MB4240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4240A182CFADB91EFDFA3674E4C70@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3344.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(956004)(2616005)(44832011)(36756003)(8676002)(81156014)(81166006)(8936002)(26005)(86362001)(478600001)(4326008)(186003)(316002)(16526019)(6916009)(66556008)(6486002)(7696005)(52116002)(66946007)(1076003)(6666004)(5660300002)(66476007)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oeORwC0fP6rzCMi8zlq/z318M1X7+Z6XViOmpmkZvFlyB3qwTdjeCwOn3RC8zMFS/M4dmb20T/DccBwGmYbQJ6ArMJ/OPewiRml/faImpa/3t5+dP3Nr5HLkTWb9gScS3FiSMN00jQyboFeZVkzp93QIHsk5sdYKM0KUIgxklF9Vg9ieij3hUb/rMRwy0dnC5s5tqLM1+eR4O6MCy+OzoPAOHZaHKpPcre35q1EotS5D7bcAoM5M3Oo/8izHXUXZ9KwbNclU+aByX1QN/6kNiMrcihBT1kFvAerUPONGup5p6aCnqUOYNajoznEn2l4f2UNdUPb/b11hmGE1/pV62LdRVc84W3iC6tU4j3MfTTwe5997rONSgD2gwslcR7UCohNg773NgKL00BkddlW8KiPAFMvdiBQ5DWhIJ84w5hjp+ugyyQ+xgOAolMvFtTi
X-MS-Exchange-AntiSpam-MessageData: PngplN5W+01pWJUZ+hwcavN2DjvagmaqlHZjOWv0K+0srLjVV2vCOTjQ8HWr0hg1iktHMdUfIR3cxQotDSijOm44pq9pBVDohia7zEJH1l170ZhXTAhZP8wpw28uxK7NxWVlKf4lSiBp2rFVe2G70g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e37989-60cc-4ec1-d761-08d7d79d2806
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 07:03:48.1776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/ZwJ+Wz+yUULVOWb/gIe3rBkzktLCTmVB7nOWUbtbRthlzYWhPYPnuIiHFrn6sV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Kent.Russell@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Arcturus, forcing clock to some specific level is not supported
with 54.18 and onwards SMU firmware. As according to firmware team,
they adopt new gfx dpm tuned parameters which can cover all the use
case in a much smooth way. Thus setting through driver interface
is not needed and maybe do a disservice.

Change-Id: Ibffdb157639809707aa71049a935e53d1b4d06eb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 47 +++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 5db8c56066ee..1ef0923f7190 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -794,8 +794,21 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
 	struct arcturus_dpm_table *dpm_table;
 	struct arcturus_single_dpm_table *single_dpm_table;
 	uint32_t soft_min_level, soft_max_level;
+	uint32_t smu_version;
 	int ret = 0;
 
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		pr_err("Failed to get smu version!\n");
+		return ret;
+	}
+
+	if (smu_version >= 0x361200) {
+		pr_err("Forcing clock level is not supported with "
+		       "54.18 and onwards SMU firmwares\n");
+		return -EOPNOTSUPP;
+	}
+
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
@@ -1512,6 +1525,38 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 	return 0;
 }
 
+static int arcturus_set_performance_level(struct smu_context *smu,
+					  enum amd_dpm_forced_level level)
+{
+	uint32_t smu_version;
+	int ret;
+
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		pr_err("Failed to get smu version!\n");
+		return ret;
+	}
+
+	switch (level) {
+	case AMD_DPM_FORCED_LEVEL_HIGH:
+	case AMD_DPM_FORCED_LEVEL_LOW:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		if (smu_version >= 0x361200) {
+			pr_err("Forcing clock level is not supported with "
+			       "54.18 and onwards SMU firmwares\n");
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return smu_v11_0_set_performance_level(smu, level);
+}
+
 static void arcturus_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2285,7 +2330,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_profiling_clk_mask = arcturus_get_profiling_clk_mask,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
-	.set_performance_level = smu_v11_0_set_performance_level,
+	.set_performance_level = arcturus_set_performance_level,
 	/* debug (internal used) */
 	.dump_pptable = arcturus_dump_pptable,
 	.get_power_limit = arcturus_get_power_limit,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
