Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D20EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F0064EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F0064EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBDC6EBA3;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FD36EBAA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leNP1U4b+z5xALBJd8sDF/Fcrk7+IU0hqtoQVhbiTXC+gaM2B2QNfO5ZbWXA/F901Lrr65GR9n/cSpP+bpc8QO+WKZx670VZKrAF2i8zA2dzBz9egYSr9NLvbEPs953J6TszBZRimr9hqmQccH0qex8UiBugKzodlqxzS4jxl5cPw0YtG+k6uvHQLCTWL5QuXvw8QK3FBDBWCxQ0u8sunVyAcrdrwWKY4gHggLGEvAjbdTu6vK3PxYAilv+C+zkVnOR4QnyqI515dSBp+Ypoqxtv7kqy4GtQJIybVBNee3lmzILRm4o8pqtX3bzhT7IY/Hqya25/w3yq8vOjOsMuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMaqVydup8R93Y0PxtBDzKcsOtabJcsJ7UBTiCQ3RPQ=;
 b=IeNkDCtPnWcdML8WLEW0uxYNczrH0EpLb+I5rXaDEZaEjzRGnDXoubnZzN2m6CpID+Hh22NG2nYgRjDLRtkIMP5FMxdfxnnTiBFWz5GBWunqxKkHGZxTYf1vwtyNrtKC9dDCfQwAZ1hxxoxuu6pNKprZmg0+zlA6QlnRlFwqyj4AGtIIfljOgc75wzegsFjhzwqJzoxa0kjvaD7ZHwV1cUTD6jvSnn4Q45ShykH8ShH8+Oy9Ls5xvF4TY26OfSTT/iUSlwMs1Xt0Jj8vZ4MIR1NVzSgA3Zu57TXv19ksQ4qOdEEHjP44bo9HeUIiW04FzJwR9SYMu8uczmBrL/dgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMaqVydup8R93Y0PxtBDzKcsOtabJcsJ7UBTiCQ3RPQ=;
 b=b7nhwTl4JUz0e85hOXahW8gAa1UP0oz0Gzdibb9FSH0MtZC1hIgrzfa+TiMZYjhprciEe8uRUOpl660lqfLQAi65AuWSu4EO9VwS7ww/oOmztkw7MajQ+HMZ6GAtUm7w7+c8e5v850aaj30oSqIQtzwdUNZdUY8AyVAz7e/9Tyw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:22:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 142/159] drm/amd/pm: Enable user min/max gfxclk on aldebaran
Date: Wed, 24 Feb 2021 17:18:42 -0500
Message-Id: <20210224221859.3068810-135-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15e4be27-1f1a-4c63-c105-08d8d9127615
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4831321C6A4A15058AA607B9F79F9@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIcY8tLvbqa72wULLFdAtJGAxNuww1r+cBemFu7T1EJD/gVjBylUTfsJ43T7wivmnFWMd8PffVlNVaT3f+OlTvSA54XqkrIAZCkUlW6OhQ1XyYdwfxpiHscfrb4r/FmX3RWj4mHN1IbZgREVHZNyUDXMtUNfwxwpmVIAX4ZwtAvnwI0JHXqKVALc6zHgYy1Js211b6QkhEs7t7YEYRhWdV39kyzgo4aeX2sQtCg9EV5w++7ES6dsBwBHc3AFq6gZbgtQrXBnV2TvLgtlpTdcLhoelHptBznGu41Z1gH0+ktxTpMCsqCyFzpHXQWigmdtAZg8z1RcbCHA/SZhsBKYU3yBPlisGI5fyphLwHPHeDrbJpjFYLB4D3gBLhVm5kCkWvE/tYmg7Sb19BHrmbfteismhVlwXHjyxgX70DNqeyRLdLWOL5l8opuM2rp0aXAFihPShEOsqUmoUKe536x8Eu7Oa82VHw1gkcTDnTxSaQ6fXy9I+gTTVOoR83oqrF+eKx4hbiRD0o+ULgjD4Cqvg3p6YAsj7KkVGsErqNm6wd6PdMJ59GcbvW9eYRTPQtjc87SG+44mdkaeEPyWwQ2wKg4WkGvO5BvMFCscxMmj7GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(6506007)(6486002)(83380400001)(316002)(6666004)(1076003)(52116002)(86362001)(478600001)(54906003)(6916009)(36756003)(8936002)(6512007)(4326008)(8676002)(69590400012)(66946007)(66556008)(956004)(2616005)(26005)(2906002)(16526019)(186003)(66476007)(40753002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?flciOKJARoBloQdvWGXAjaSzAQoT1CrtpEEf6KJv4iudir2iY9Ay7jU7CMeh?=
 =?us-ascii?Q?q2/zHIgT+x0AVMYG9kUtk/YBAs+C/yVu6XGbUOGk/KbPxkRxwiAvkUbJmWuQ?=
 =?us-ascii?Q?JpW8F2SIwE4aosiK/OVbXbYnHnvjbYIDmXJpWGY3LwwqEfkLiIsDOIHJvcfG?=
 =?us-ascii?Q?6TFr7xgep8YFMIBqm2Z7cEKA6OkZs6s0oUNTeA/5ft80YnFCpVyw1qtshQbG?=
 =?us-ascii?Q?dXuejatiIcNBwCg26p9adz93Y5IDxAUL9FjHC6EEvAiBrRsTHQFwO/2HSx/d?=
 =?us-ascii?Q?X5eHbbl2LS8gDUt6uYgl3xMgBl8XK5wlOANh11DsEiHTzRfQ7TRgooe7u4qI?=
 =?us-ascii?Q?3akipZA2Ghj1FsloIbIow6dkeD5wRkQfPn5DCXIXeAHcApd/WAhtTRJlS8o4?=
 =?us-ascii?Q?kYi0TeCMQD6tua2dBfbdZY460iOmIGZUQjBnJiNQ+TYomPR6xzpd8UUa2+qC?=
 =?us-ascii?Q?M7guk6rsyAm7bBTkG7vLezcFLjTK4gYNODIiSPfSxfgklZ68cGvGH5WcBJn4?=
 =?us-ascii?Q?kuMoovhZMUbMjobO/i5i6B6qxwuUfkp0+PjezWAitlwObhvJN3SRLwv1W3pV?=
 =?us-ascii?Q?+fDauHi9R1SA+pgAITFPhbCnZyqm1SaKVcmeDY7pxCiAqIGLMGzEJaF3ZRg3?=
 =?us-ascii?Q?QE3DC6lAx6Sq3rRXAgekU34qkBvEAgh1n1veXJUwF8rCIJWI9n6SY7q6CrYI?=
 =?us-ascii?Q?ls417BcwjngEG8sGC7C+4rdU29WI9LZVKZty5afHXNLbliN4LFiJdT/QEZ1g?=
 =?us-ascii?Q?hZ3wTUXk06IoB/R2T6DZZ9xpFJObna+M2ZScC7PIY/6OnDCOiGFb+jRGL1K0?=
 =?us-ascii?Q?3k+Z0qQ6COn9Yoy/BgcmIIIfPzE7Fsc3QaG014k/4r8PTQPeRHVo0gdc1w1O?=
 =?us-ascii?Q?hqc1R2HX7vLqzrxTdt1MliEp/s3lZ1lCBloW8QrLyMaNOSv1P06AobZWq8GY?=
 =?us-ascii?Q?+ABTObeouZbnQu7OqAWB3y1cDjUUOBT3pQmTLQQAfp+9MzO81+fs4MDHYfvL?=
 =?us-ascii?Q?FHDwoW6sS4MFz2M6JgbcWjbAZsd2L+1N/iDvudytyM9PUfyctJ5GzopgCkLS?=
 =?us-ascii?Q?IuF1BzCuFMSteBrlf0vM0/Ff7qlCF0QXLlzA2uHq2BZUMIioeLw4zmLPt/bo?=
 =?us-ascii?Q?YW+MCFH+PhKNICCfb18gY7RKZtlBpmq1rr/gZTUmMWy6365JIxnDXS23eYO0?=
 =?us-ascii?Q?7nSyU+zpOWn/sYA1WE2H0smIjIfq2RqcvtEgUcub2l3NECiufxZSj+z22g7D?=
 =?us-ascii?Q?etyTOwKknb2Fe7yGtntGxB+4E/LjQgHgfvIkAGi5i5mFL/g4TByh0gq8+2/p?=
 =?us-ascii?Q?1wRWPyMeCJzsCfeUasYExZQu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e4be27-1f1a-4c63-c105-08d8d9127615
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:58.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDovaonlT5TDYGu6Mc6b4uvgzHTGVFp8DfXghQUT9Ucbh8ggpnWvTeYeJHyqQBjL94nkAKt6fgUir+7thK/hIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Aldebaran has fine grained DPM for GFXCLK. Instead of a discrete level,
user can specify a min/max range of GFXCLK for any profiling/tuning
purpose.This option is available only in manual performance level mode.
Select "manual" as power_dpm_force_performance_level and specify the
min/max range using pp_dpm_sclk sysfs node. User cannot specify a min/max
range outside of the default min/max range of the ASIC. If specified
outside the range, values will be bound by the default min/max range.

Ex: To use gfxclk min = 600MHz and max = 900MHz

echo manual > /sys/bus/pci/devices/.../power_dpm_force_performance_level
echo min 600 max 900 > /sys/bus/pci/devices/.../pp_dpm_sclk

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7bf8316b9816..befc117a25ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1143,9 +1143,16 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK)
 		return -EINVAL;
 
-	if (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
+			&& (smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
 		return -EINVAL;
 
+	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		min_clk = max(min, dpm_context->dpm_tables.gfx_table.min);
+		max_clk = min(max, dpm_context->dpm_tables.gfx_table.max);
+		return smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);
+	}
+
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		if (!max || (max < dpm_context->dpm_tables.gfx_table.min) ||
 			(max > dpm_context->dpm_tables.gfx_table.max)) {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
