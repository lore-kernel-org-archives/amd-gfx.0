Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BDC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91C761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91C761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6A16EDAC;
	Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BC26EDAA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7wSAmPTM/v2UTqt4X34SfktgzdaOoA4W5Z6GLA30kf6xZc6xkVUG6VtD/cLD7PPTIAicEeKA+f3Znw9F7Y0eEHn0Zy0WHoXRY4865le9ab3sOg0NXBxGkCcebOsshzQ8r1mhVttdKzDgAuva+UTgUyGbf+MY0O/wdDQb82rG8nPbwDSkTzX45mII8PfFVnFwsGGDerjaN+IDv1r1MyZJmLoTokBqOydp8lcVzFElgWVc3Oe1dun+qNKJ8ycG/R81AAiDJV2bsG0NXBvi6jr3STUEDNbVBMdfijPerZ1o40cDMnermo4vuIXOC7bB4gNW3/RxcfTiJe7rbhKHUTzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CqJCjOaw1L/ZoitpCUzyYbKv2FGmtIpwkmZJV663Ik=;
 b=f2DXTCZ50J3uU85hB1nqV4GPA9fmMYULZCw+pqIh0rSzW0bqvoAQMfEvnjrUU5B5ROmtIB3tGwDiMNEwsbHm+0f/64HyN3HHDmi8P9SSH5qBPd4uCI+jqVq0b4uNcdeBJxPQwyxMKXtsLPuAgPpzsTt2joBEdxwguM+TfQKnNNKsEzvVzP3C+kpRv7KEnlcN0KOQgjzpktDKhR1ybWRAqddZtgyFxwfaTuk2jFxwTsec0kfHKFaUBmkwNeg2zMFnNegy/J6sYImT2HS9Ob8SjcW3TDgxk0t5rWnDUWm6KL9MDKIWVmYG2gkY9Qnk77ucO8QiZJGTibgL49GRCaeu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CqJCjOaw1L/ZoitpCUzyYbKv2FGmtIpwkmZJV663Ik=;
 b=oSAS58+hIRIYncaor8Lb7xUDR7t+Gv6GInX2umzdjv75rRMvLgXO4b2NYNL+u+5w8GFeHO5nZ27eQub4oL5LI0539xO5EyQLL7C7Jwl3KqDZF8cS2eJdRs6Ka9qnyc+wquXlzLHNIoQ9WpmiD5qFXioQ4ZghpQTXuyElbTrMJzk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:38 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 55/89] drm/amd/pm: initialize feature_enabled/feature_support
 bitmap for yellow carp
Date: Wed,  2 Jun 2021 12:48:34 -0400
Message-Id: <20210602164908.2848791-55-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa0affeb-7366-4246-b8db-08d925e6796b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534FDB9509B5063BBBEF6BDF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l48mJHI/rAZmMiJ3IrefuzGDea2seCGe2u/8dc+wPvfb3iaqMOOr8B8eU8yIDWb0aXOYIwGFH03W8feiMMK0AfsU+UV2IHwlA4XgOR+NSn3etSCPUR9jGeG4puWu2VHm5t0l7uBYOiE1oHBdo5HBWMzya2JwTFB5NRoVCCryJveDCSU3SNOTTcPHbr9gteQLiaYA4UKRiMtuzOn9eoKPFb7KPrMvhPaGtF3Dix32FeHvWa4Ji858ezfJjGaWwIPo3UYNCOnNedqWCBkui3G4CDdH/eInbVR3NE34DNcET62SeB/Arq5sEb5YEdrR/XMwV6wRzseWvXmTsZOtBj9WUl8tMi/eKIuMaxFLsUhcXVvG/SLr5D5CSwL4Qs1n4IbX1TPD8KORiAmdr1pxYzwYOlTLI4r4ecRhXkKlTVrO9BUc+uFoSF/u4tlQ52Wp24J8YOfj/VTnsuh999GkIJOcTpPfbsv+uanIZTIq1FQVwGN9MT2MMBVI5ypsZu2WKnF9X76DXLz7iPlmaqthXwYjJATOeQbNea8+lUH7gvuoyC7f6rSv+Vf+QhPZNZHwRNcT72so8G/dXIKJdIL5cr8g9f9BTFHIvaf/aRpRtkPtS/vQWGC8ouU7BCqmyFi2MW6W2MAvskytVWUtHF2gHc/M0ByVeNvCAiUeunWvRVz/X+nQ3CSBLL8IYhuYGVXNIv16
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s/u2Emn0vPKTpm+ViSSk11Oc9CXqGQgC4S2NyRYMSWEKtZhDmHrzVxt1CrKd?=
 =?us-ascii?Q?9FQa/IJ/4yuh0eTc+1RD7oG5uuTTiAG1PwaSzxEooSi30Nocq0x4VqJ9dbTP?=
 =?us-ascii?Q?6rSs8B8aM9JPhiVN4tk7fEFdnn76JjyDuc2dBKhAx/57ESEeqMMqJQYbjsWP?=
 =?us-ascii?Q?uZgwCsUyseOzWhff6ETxleFCyXCoM0mLRWBW6li0k1C1IKeDW0uj0h4DlVDJ?=
 =?us-ascii?Q?8NnnDi4MIWdbFmmHKQsjzldR1K2NLogY88R9cfLj78MnXf7H4F4impHMECLc?=
 =?us-ascii?Q?YKsQowKZNdO3C6RhbE9/uDQCQbq37wCTgprVrBth9hXvFCliEl/fmflAEsaK?=
 =?us-ascii?Q?ZJ4S8xmPbZpbr18bJnaDIpcSDy+MwnuxcPSemhiHsoDkzhBFELFOvQH6R/gj?=
 =?us-ascii?Q?sQzSLf8A1nWQX9nP4knfIvYHvtvVsQ3dcwE8qwblnTjylO1/jc9WPFSEnaLd?=
 =?us-ascii?Q?ua4XbvrNcxLZon4u+Bgr4I3EndkE35Vx8YvCDsMHGu2chaIKMkmhPqwR7AGc?=
 =?us-ascii?Q?o58Uzu1kS1bpD0iXeaGfNg5DE5uzUMU4BLe6WrR/fpHxzz2rBtDz702c+RaD?=
 =?us-ascii?Q?7qvaLRQsSpwmO6tgxc5muM80pnZOOXihhwV2Ex4NW39JEIukZgLKToHFRm7w?=
 =?us-ascii?Q?7LX5yi8pQLjxAUZ2kJ/Tj6WavxAIc8BCm64IlanxnyprKi7aeJJxXMtdNQA9?=
 =?us-ascii?Q?9o+nZKWwT/4Z2f4l4jnsZzGjADSBohDnKsijVdw2inZKul+v1vdQY+CitfFj?=
 =?us-ascii?Q?3aLRth0KNqm9k4i9MVEcUjnHp1sl4vURG0WoPWAlB9mWlze8+WDbn4HfzBQQ?=
 =?us-ascii?Q?yUPZZNdS6v29cXQRzoGoJLMYRa40s3lu9rSBIjcIaAHDItgwFgXI9x4ruC1q?=
 =?us-ascii?Q?W7Fz+E+u0SvtN76Iw7kltzzB1rY2SgGf1j+fxtU1VdtDVOxnJvIdmxmQr/3W?=
 =?us-ascii?Q?ZPgURK+u47a/uSFZwTHiOee6qgtwDzRDhLj2cZdU+1vxpT0elV4lfpt/sLF/?=
 =?us-ascii?Q?XTirnmVlzBxCgPXh2/25nVWD8NMwx7xJXKwwn+zEzgwnOl+VRqlGWCKn1OGY?=
 =?us-ascii?Q?g2foBnolDWyvkowPQbdtWM96pN0oSEae0T/vgXHy8Ywsi6eORN4hWdWfrL6a?=
 =?us-ascii?Q?jHjYrfH/+AWw4MG4OEr8KTPv/DAOdrekplQ6PxMExjzkZ9nLDu8hHEclE0re?=
 =?us-ascii?Q?jgI/04X8sFdxKnae8cBVKr9gETB0/c1lVaY8N23v4FUBY8mYdwmhUc1M8R0g?=
 =?us-ascii?Q?B2uTVV70Wba2OGrtUgMi9OIwxeTEsDq+64qR+ki0ry9gTEcesGpHY8pfz9h6?=
 =?us-ascii?Q?rM6BM1C3Y2E2euDGrMu1R6WQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0affeb-7366-4246-b8db-08d925e6796b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:06.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8Yl+KP3ujHXnCMVHLKLp5hDELmMIyi2QA7cphl4IxgU65QGkza14b/pwqOY7K8gFAwZqLKCGP75nMJzZ09bTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Initialize the feature_enabled and feature_supported bitmap for yellow
carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 935754e0de95..feef77c31d56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -177,6 +177,30 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	uint32_t feature_mask[2];
+	int ret = 0;
+
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+
+	if (!en)
+		return ret;
+
+	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	if (ret)
+		return ret;
+
+	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
+		    feature->feature_num);
+	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
+		    feature->feature_num);
+
+	return 0;
+}
+
 static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
@@ -679,6 +703,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_version = smu_v13_0_1_check_fw_version,
 	.init_smc_tables = yellow_carp_init_smc_tables,
 	.fini_smc_tables = smu_v13_0_1_fini_smc_tables,
+	.system_features_control = yellow_carp_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
