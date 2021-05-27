Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5BEC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586F761284
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 03:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586F761284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71CB6EE0C;
	Thu, 27 May 2021 03:50:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720676EDFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 03:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQQnrJN2rRJ5tjZ8lTSRVEDwkvgB+sWizg87hjCKOPETRKxWzVdynMoCAPIEMsy4XF8g3xM8GNktor970PILfq4RUoB76t0BBIf9b8X5u51bIahQzM5ZZfn4HQGzP4oNOKV+HuYO70D4awAJvfXXLRcRFIFO9JrjXPy9viJsL/ovfmehiV44g7eQDM2spgHPvYQfXCB80YGuLNNlp9i7/Mu6WjsfA8bwCz+LDIYZkUXt9s4r5f59pe/Wq/auzJ85gyH5FRDxyENewJpZIAqLxSGufOdLzY2s3nAYcYujz1JD9kNF86bznHuTYJLHlXAGG0+fMbcpiTfa1zjPtD3wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlUasuKmZjqmZmo09Y2a5xDp5tmT+KDtakKxSaGXb/Q=;
 b=D8Zkk8sq7o7ZX+pWS8kjTNIa4C9d1ziwEs1U/Y7HczNMOUhO1tvjD1LFuDeN0WUcsyQZc3JQGs1YO3XMmgwXCu3ruDL1zFg02E8eAnl7faOig5QnlH2d1MNXDpavqbzllXfKvcgjMRB1fBlfy4U3mToL8ltR7Ea/EJeBcLlojZiUWV5ZLmB/Erne3K0Ct8DONd7ll0vDsm9dlgIWcMzvIDM/hypXl1z4E2OprNgbtznRzwaJ+QPqlfingqpvVCRuIxvtM+Xr+aIrTW2jmQeZ1rKJjlqQccn7HYAEIO9fTuiQw0RmU427KeukwG8fTzlGvXfc0xzrltzs7bpKtiojgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlUasuKmZjqmZmo09Y2a5xDp5tmT+KDtakKxSaGXb/Q=;
 b=e6BfUBV9iUzl6gPCykxVCfUBweWEVCfXjsb2ZVm8o3Ph9mNw7jwxbnjBPCsfMXxpmorcWkcbx4S9UezauPK1xrMQu3GlfJZRCN9lQdQSOBTFl8Bvm3zTXkIZ5uX51qFxEvO09Kwu8Wj/MasjI5iXbjhp8SUxBmzXqyK51gT0Smc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 03:50:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 03:50:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu/aldebaran: fix check in is_dpm_running
Date: Wed, 26 May 2021 23:49:52 -0400
Message-Id: <20210527034952.247846-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 BL1PR13CA0175.namprd13.prod.outlook.com (2603:10b6:208:2bd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Thu, 27 May 2021 03:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b474b477-076d-4c35-94fd-08d920c28599
X-MS-TrafficTypeDiagnostic: BL0PR12MB5009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5009E2661A5CED248200AF9FF7239@BL0PR12MB5009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amKLz91dOXo3JaJyOm0ecdOEWNL/EkIT7fism44U2DCRQ/Zn4xRbz7G6EZs2OgoS/4Xch1Wr+ohKpsBgyBi/so8NsgrwMNlLtPLoivevmr5u2QCJtBWIqNUkODcruXGvMo4jNJFN67YDTM61DL1r3PcvZrwvgcmE+J0mzFZ391JLa9RntNShC1VSyXabflI1MDdNRjZms/aODbA2iROEl+ePVP78rJzVxWMNsRiTnhO99CyRO12On7RvskpdhDqzD/esVBU8kBckeaGRs4j1s6Ul/U9YeG/qmuOBiPnMDDEwL/1zB62+AnMI0tE4qAM5Mf7ResZYTQjt669MPywKMu1QRH9ybI324VBjA4WRxC8zCxnfOO0REufHBhVhx0slWxMlPMD39k+L5HSGhMcPePiC4Vy6QG8LxxYs3x9GCcqNDp+XiZSpw7pSr6ysybHroKdELcjZFjFMDoQvKiVqU+7mVfm7GI3qpvZ4mvU06TDPyveR5v2XUmVuIpEWBvxNmcdLht5BD+CR4/tD6PdAsn6ywVSysmX+2eh6FX6J9AZbhVM06SjUGiB/8M8sGcrRsJCY0zklMZg6h7nbPd/nAG+FYpjHKrqdjTcciHCRbNYLD+6VxtpgO50YjwHGFuUYsasl3j2yJJDB6RDN2mRuVktUBzFu21u7j3QmvWGEAFs7XxBEwLd0XylbXQOM1gY4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(5660300002)(86362001)(66556008)(6512007)(66946007)(6666004)(2906002)(6486002)(1076003)(83380400001)(66476007)(956004)(2616005)(16526019)(36756003)(52116002)(26005)(8936002)(4326008)(478600001)(6916009)(186003)(6506007)(54906003)(38100700002)(38350700002)(316002)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0Ti29Ck3hJaTmUly2NI+8w5mRWzNjMA4u98P/z/Tn5YqOtUiiy/wDIetItLh?=
 =?us-ascii?Q?RjY0IGIfwtkC5c1PfwmzpKz6vNoudXng0DKhojtzbQTS+RhFMvtdFFmwvK2g?=
 =?us-ascii?Q?ULEwS02BdCCHQXpivkPZxYjydZ3uu9XBhkjvx0Nae2eVOwv9ZzO5HSVtoKs/?=
 =?us-ascii?Q?w0Pkk+drCkZE1QLooBPPYfdhEk2sqw84uxNpwt30lXBFflHHgjQpLQ3kfHRj?=
 =?us-ascii?Q?P0Yauxyo+q0kiRQS3ZbsW5rH1VUkxEMk2cajXW/l/zjeyY3EsRuvmQLkmXHe?=
 =?us-ascii?Q?yV+9bE/juMMhm4qZyTvbUZbz+ZHKV0sd+EwyXP9YLhvwHAz7x+v23iOjZ/ad?=
 =?us-ascii?Q?ZypbdAogWnw4PFmIB84qOIkkNHYVVLJFPK7RR1h+bMU0KZLhUpE7SbFiDeHZ?=
 =?us-ascii?Q?Xtlbx/o/ht2Nmb9THJf6hWdlBTxdh7OF6S6K/vsoPBXIKvNSUuzNcmSnfyhI?=
 =?us-ascii?Q?u/1SU2lc7J2YaKrwlhXgnw9EI7RrRUZR0FJr5TiVEtCKisyy61loq2yWLL7R?=
 =?us-ascii?Q?xJJSScdQHHJcazYlGk3ndoqaC1J69TZKNkV6P/hpwgHq2e/1aXaLskTmxplK?=
 =?us-ascii?Q?7Ewldpz42Ra6ZEo30GqjlKNy4MmJJs//pNpxe1S4HHgzv/X0DD1WV+6Iwb4d?=
 =?us-ascii?Q?MSXZqRl0dYACZDX8sN620Sl+4JdiQfRYELvSbviEnOetrEvyrK6PdsTC+QyV?=
 =?us-ascii?Q?SzQ/TOF65fL00Q58/6q8H5G35EoTdN8bVDKKZBrm5YNi6x/CpKgORKVhxkRy?=
 =?us-ascii?Q?Pv0SzG1oh0JWbw2iiDsOy09i8Byb5Nh7n4A+4giQPs8d2GSmlZDcFFJKVXoC?=
 =?us-ascii?Q?oY4s9esuKBwSOeuIkEHRF20yPpqGaSd+mIWy3MI4K6WwceBmoXyXaEz2TEnL?=
 =?us-ascii?Q?YCtRqhEipXHDrXs7rWR2OKOSVnZ/7vhGKBakCQVT+9/dXcBot1JSdAikcN7s?=
 =?us-ascii?Q?NtPkmkI+m2T9QV47TYgBvGMHfT9K0hTrXdOJLafY10M56qTohs7Kr1+93T8R?=
 =?us-ascii?Q?f1Lg1+YyLMKuBSTHhQZ8iQzoFWdUDpMjy9cQQRXtqKgSwtOUgYVn0lfBxPYF?=
 =?us-ascii?Q?mukclg3R7o2VZB2WLLAxZybX+VsoMbrYFQCPjiSn+6k4mU9HRId+4lf4rB6n?=
 =?us-ascii?Q?+IKFBCo9vvl0+0YAb0rG5mY6w5IwRCSokU576X25FQ6+VJxVMkmaaJKfi2Cz?=
 =?us-ascii?Q?fLk3GKZ2Ba8/09t0Z6KO1Lk36b3jSyShbBY3qkeLjTdlLBc2A5tyr1UPcu9j?=
 =?us-ascii?Q?mIslXPVN4CdIk2Q4hj7nVUyYqPNO9emQPW/bnS0Reyx79UKlL2vGk2mFJNRr?=
 =?us-ascii?Q?tjLAiSiGMKJJDDMzr6r0U8JQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b474b477-076d-4c35-94fd-08d920c28599
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 03:50:09.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IH0w1LZL5UbeJKquHXdCMW+O7a1b3ktstSQveYKK+lwT9zIXpSeIUcUvXcOntX42yaXZQp2VpxSzwQPncJu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If smu_cmn_get_enabled_mask() fails, return false to be
consistent with other asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d6ce665baaf3..7a1abb3d6a7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1368,10 +1368,13 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 
 static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
-	int ret = 0;
+	int ret;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	if (ret)
+		return false;
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 					  ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
