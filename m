Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B18C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028AC60C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028AC60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFCE89F47;
	Tue, 23 Feb 2021 04:21:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6921389DBD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np+2MEDVLE70FlsB/NDg8xKALgtq9qomnYFSvS53h/H7FzfRgITWZwSz7rINBkojdhpTCvl0821Q8rsce3xCkty7Coc4cfVFiELcWzwuu32keaJgGIBrhEMXaY5UbGVh6lQij+oaLRZYWgkvkjLoxbEewjGKykw18GzjsbS5Rh8dLKUOB+gCC6OqIQxTd+x8U04hBhBV581v3nLulrgw8kbGDMsRI7xaqf0ILhB9qlDYH5IKdbgWV+AIzi6+81WqT5+0ef8ChIdqT6E+vTmQ+Z6t41fz+krhidh8Mqrq6vWNFqy3oYBTf6XnM8L/pBLef9xk1/r9i0b7iQ5WAIisrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqMYSHKZ1mZHe9v6A+fyNM4I5PH3vNTLm9VfqqQTeHY=;
 b=N1fzTTGHdwlxQQP2mfi+Z+bq3kCdA0ojgNSBcADaVcGZ11aC7X+rJRZcQZEAmtNDmuMH/s8ThIzjlJ5GFUzaQYBMatu/zAk9uQlDiHhUmvs/aad26MwriDzinnGhzH4iZkHZzWZ6Yd2D4Xzwzx6RAZ9xZ0L+nt65xk+3kT140qr2M0Us9nzyNe450QhTguuh6kNwNiawNXRbkfipnz6hMUei+1ciNdjEZy/IrP8QvC3MwCeZl8ZjK48O54417qlHB4M2RYSCQXi3whuIjnYKxvbqNV6D6PRdWW538JMrdcEve8ZH1y5bHOyZIF1aBP2PpdDRRMcvnaNNiy9Ooi50XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqMYSHKZ1mZHe9v6A+fyNM4I5PH3vNTLm9VfqqQTeHY=;
 b=R4/8WWc0KH10YLpG1QR4ldt/9M9jmdfwkBz8tGoKTnYzdB9n8M9K1r76HT9AOjx9/Vjf7tj0zTUGQ6X65zdK4cfGcLb51hAOu9i5Hm3wl8/8XOOXkRcYr4rcZJR5omw9iaOK8EKkDlSYLuxOCe7vEXyqWE6wIt3+Vw979lAqD4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:42 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:42 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] amdgpu/pm: Powerplay API for smu ,
 changes to clock and profile mode functions
Date: Mon, 22 Feb 2021 23:20:30 -0500
Message-Id: <20210223042032.3078-7-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63751258-02b5-4982-1b44-08d8d7b285ff
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850C7133A453795E0D08667F0809@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/Op/68ek1YKGNSQb/2Arq0aQ3zItdnMqbR3RoCn59yXhDt4HqXP0byBdHE3llqZNDJ1B5mKdG3IU7AWO8OxBMw0aEwCBDMhVfBUo/a0Z6RRJcac0CQ7B4Zl3+pfp1X0g2L8VqWBfcw7vZr8D57k/DBJUBAfEEoxXhlVu5OXBOGGKHJpNjdSknPWKPyMkGfhWTp/zinrAzug9cX7FselnlQSpgsq4ECmW9gN5Md6yV+g4iJblNZ9Xq/2tkuggkXlDVWQA4vRX/R0lsN+bNtlviepWJH4BIIyUo4Zu7pXcq81H1pOIs7OoEEpF9E5h/HSz2bW+hgVWlUZUEyhC8mqPsjQx4GoehqATf8E5c7gNBtEL+ENUGZLEDOSfdnJP35k6RHZwXuUY3EM6AvkpczyYsX2rA8xjs2UZ3jE46SGd3Qi1V0kbBYxH/yLyDMZNzP3nYmesT+WRpOSg6aP12xwR1w1OMwpQ5uXiA9tV9yF+yothd20ijU9GKqFTjo3sWGOKeQ82g+52mnwR/33GJBrFj0/VpbDwujqmvpjfTAcQujAHcnm31m3AShTU8aFXLEFsNIVp5mdt9OZYwJDXYv26A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(956004)(6506007)(26005)(5660300002)(16526019)(316002)(186003)(8936002)(6512007)(2616005)(66476007)(66946007)(36756003)(2906002)(83380400001)(6916009)(69590400012)(30864003)(66556008)(1076003)(52116002)(86362001)(6666004)(478600001)(8676002)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aHR61oFs1sLfR6gd7aErxHxZgEyI5iex8QPL35fLGU5ljAkmseMdiXrlgPYw?=
 =?us-ascii?Q?mY/nn+6WGE9dKo98cqQS1yk/6QPZsmJx0VLCeQDllD6kKN11Iubsgb1pX5KK?=
 =?us-ascii?Q?1Z3bvSc4tskBKONSV1ubn373WN/kNfyQk1o2WCgwAEMmv1BM++vaEiaqUpM7?=
 =?us-ascii?Q?mIkUqpHGTEXTsMSyoyrzBClWz07gAJqkh6prgmxFiGV1ZCNke7oPZG8cHzwf?=
 =?us-ascii?Q?T6bmq3u3z9tESvSbN4NOyA8i0B8Zc6S57Muy+SQzhJ73glPCcFG3LlUew6LE?=
 =?us-ascii?Q?LsM714GFPkYZDZb0QqLDZsdG947sazLcHXDCKOBIVBHyxxsvKdMGB7jiCpRD?=
 =?us-ascii?Q?JCB3FRPXzqcaESpESqjsli/v9oooHay9ysmp6JPeXmOx0FPGaZH6gt3y2hgk?=
 =?us-ascii?Q?8QltLKXxBjw80+RPj7qxEPlbpYiKRAGYHMIyB7HCdhtC4LG1/QNcN07Vluko?=
 =?us-ascii?Q?wAMsj41izanREz6LEO6ktbfYujZ2VA57ghFS5EZjuiyVts/ZF5k/BBECrIhD?=
 =?us-ascii?Q?yIDiJ4j23RrDNv27tri7TMYB81lolHmOHMONx56IbzeWDFESw02Uer9UqnZT?=
 =?us-ascii?Q?rkVQEy6jjY487k0OIB04W2uDGCgCgZ/Dnz3zs/enxOf644hfSfmN2ltebBRN?=
 =?us-ascii?Q?27IQq02zVG9oQbbes8cUtVRB8O+JvtdXTLajgtgKmguo0qd2U6uQuBskvh4i?=
 =?us-ascii?Q?pwEhxS33DwxAP9Su01olMchrJqDmC8amwyvX/mxZo+GXnWSiOE+6KdAXexhO?=
 =?us-ascii?Q?0TZqT2t94guzJCR/c/jWJDyMSxC3GoT3QNBpdisrybrPyUmvuevyYeNnmbuN?=
 =?us-ascii?Q?0ucaSeZFL2bHvoje7KP2r+Eq9WF+SlLaD1it+ilDeal4QMhRk5puuoDQqBIS?=
 =?us-ascii?Q?uAd9GncuV5qFx0feDyxdKVm7C0Uz7oJy5IjtGTe9Zd1HzkgsW/6uXd/ml5rf?=
 =?us-ascii?Q?1Y0alMGnI3r5c7jb1Kb0WKtOkcoGxdXMJmgxkZqQ2NvNwHrU1SbygWXzrLYY?=
 =?us-ascii?Q?1bBvAgVjmvzXz2CLnLsjA8yYmDEwodMfv+Gfn+4lAkRrAATnn39U5/aPYX95?=
 =?us-ascii?Q?5aEMW7WdRgL1M2KLR4cWWP7lzEsQt3i3UnFHWHmB6qVtX7v+RnGvqZDwNxIB?=
 =?us-ascii?Q?JXkI54ldNsnlQIdPIfmE9BFLDyFF4YYhvi+N3t9t+p+8GZoWcOaNNHFs4qYv?=
 =?us-ascii?Q?TeS6RK1KH4N9PZH0Nnogihw7zoWPAeSJTg0k3H8MFLWil9hVI5M4v90T8756?=
 =?us-ascii?Q?pkHc4/396/LnTHblq6/QBsf/ediTWw/hFfsLy7w22xfoGdjAhJOIAoZmdZ/i?=
 =?us-ascii?Q?+1ACzTNOj5gdghbbYoX3GFGc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63751258-02b5-4982-1b44-08d8d7b285ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:42.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBT9iheJwEWSnWUId7CAd5cKZagcaODs1QOIyTe9eqwLVlNf7rzbVfIso02kR/MBMwoPmP27dv8U1a1Q5YL8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v3: updated to include new clocks vclk, dclk, od_vddgfx_offset, od_cclk added in commits 771fc82ffc710 & f40074fde207e
    Added forward declaration for function smu_force_smuclk_levels to resolve clash with commit 9485ed36411b7
    Resolved context clashes with commit dfb3bb7fccb37 and v3 updates to patches 0003, 0004
v2: fix errors flagged by checkpatch

New Functions
  smu_bump_power_profile_mode() - changes profile mode assuming calling function already has mutex
  smu_force_ppclk_levels()      - accepts Powerplay enum pp_clock_type to specify clock to change
  smu_print_ppclk_levels()      - accepts Powerplay enum pp_clock_type to request clock levels
  amdgpu_get_pp_dpm_clock()     - accepts Powerplay enum pp_clock_type to request clock levels and allows
                                  all the amdgpu_get_pp_dpm_$CLK functions to have a single codepath
  amdgpu_set_pp_dpm_clock()     - accepts Powerplay enum pp_clock_type to set clock levels and allows
                                  all the amdgpu_set_pp_dpm_$CLK functions to have a single codepath

Modified Functions
  smu_force_smuclk_levels        - changed function name to make clear difference to smu_force_ppclk_levels
  smu_force_ppclk_levels()       - modifed signature to implement Powerplay API force_clock_level
                                 - calls smu_force_smuclk_levels
  smu_print_smuclk_levels        - changed function name to make clear difference to smu_print_ppclk_levels
  smu_print_ppclk_levels()       - modifed signature to implement Powerplay API force_clock_level
                                 - calls smu_print_smuclk_levels
  smu_sys_get_gpu_metrics        - modifed arg0 to match Powerplay API get_gpu_metrics
  smu_get_power_profile_mode     - modifed arg0 to match Powerplay API get_power_profile_mode
  smu_set_power_profile_mode     - modifed arg0 to match Powerplay API set_power_profile_mode
                                 - removed arg lock_needed, mutex always locked, internal functions
                                   can call smu_bump if they already hold lock
  smu_switch_power_profile       - now calls smu_bump as already holds mutex lock
  smu_adjust_power_state_dynamic - now calls smu_bump as already holds mutex lock
  amdgpu_get_pp_od_clk_voltage   - uses smu_print_ppclk_levels
  amdgpu_{set,get}_pp_dpm_$CLK   - replace logic with call helper function amdgpu_{set,get}_pp_dpm_clock()
                                   CLK ={sclk, mclk, socclk, fclk, dcefclk, pci, vclkd, dclk}

Other Changes
  added 5 smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling in pm functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 462 ++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 130 ++++-
 4 files changed, 168 insertions(+), 444 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a41875ac5dfb..7621eaba39f5 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -95,10 +95,14 @@ enum pp_clock_type {
 	PP_SOCCLK,
 	PP_FCLK,
 	PP_DCEFCLK,
+	PP_VCLK,
+	PP_DCLK,
 	OD_SCLK,
 	OD_MCLK,
 	OD_VDDC_CURVE,
 	OD_RANGE,
+	OD_VDDGFX_OFFSET,
+	OD_CCLK,
 };
 
 enum amd_pp_sensors {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 34e5c4c4f280..ec5277ed74f7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -893,12 +893,12 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_MCLK, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDGFX_OFFSET, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_CCLK, buf+size);
+		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
+		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_VDDGFX_OFFSET, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_CCLK, buf+size);
 	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
@@ -1032,8 +1032,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * NOTE: change to the dcefclk max dpm level is not supported now
  */
 
-static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
@@ -1050,10 +1050,8 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_SCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_SCLK, buf);
+	if (adev->powerplay.pp_funcs->print_clock_levels)
+		size = amdgpu_dpm_print_clock_levels(adev, type, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
 
@@ -1098,8 +1096,8 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
-static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		const char *buf,
 		size_t count)
 {
@@ -1121,10 +1119,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
+	if (adev->powerplay.pp_funcs->force_clock_level)
+		ret = amdgpu_dpm_force_clock_level(adev, type, mask);
+	else
+		ret = 0;
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1135,35 +1133,26 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	return count;
 }
 
-static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
+static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_MCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_MCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
+	return amdgpu_get_pp_dpm_clock(dev, PP_SCLK, buf);
+}
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	return amdgpu_set_pp_dpm_clock(dev, PP_SCLK, buf, count);
+}
 
-	return size;
+static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return amdgpu_get_pp_dpm_clock(dev, PP_MCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
@@ -1171,67 +1160,14 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t mask = 0;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_MCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_SOCCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_SOCCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
@@ -1239,69 +1175,14 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_SOCCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_SOCCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_FCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_FCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_FCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
@@ -1309,67 +1190,14 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_FCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_FCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_vclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_VCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_vclk(struct device *dev,
@@ -1377,65 +1205,14 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_VCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_DCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_DCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_dclk(struct device *dev,
@@ -1443,67 +1220,14 @@ static ssize_t amdgpu_set_pp_dpm_dclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_DCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_DCEFCLK, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_DCEFCLK, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
@@ -1511,69 +1235,14 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_DCEFCLK, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	ssize_t size;
-	int ret;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		size = smu_print_clk_levels(&adev->smu, SMU_PCIE, buf);
-	else if (adev->powerplay.pp_funcs->print_clock_levels)
-		size = amdgpu_dpm_print_clock_levels(adev, PP_PCIE, buf);
-	else
-		size = snprintf(buf, PAGE_SIZE, "\n");
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	return size;
+	return amdgpu_get_pp_dpm_clock(dev, PP_PCIE, buf);
 }
 
 static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
@@ -1581,38 +1250,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t mask = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-
-	ret = amdgpu_read_mask(buf, count, &mask);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return ret;
-	}
-
-	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask);
-	else if (adev->powerplay.pp_funcs->force_clock_level)
-		ret = amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
-	else
-		ret = 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
+	return amdgpu_set_pp_dpm_clock(dev, PP_PCIE, buf, count);
 }
 
 static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
@@ -1799,9 +1437,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_get_power_profile_mode(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_power_profile_mode)
+	if (adev->powerplay.pp_funcs->get_power_profile_mode)
 		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -1865,9 +1501,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true);
-	else if (adev->powerplay.pp_funcs->set_power_profile_mode)
+	if (adev->powerplay.pp_funcs->set_power_profile_mode)
 		ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -2124,9 +1758,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
-	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
+	if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
 	if (size <= 0)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 1835fce3369e..20af40b24f66 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1240,19 +1240,15 @@ int smu_get_power_limit(struct smu_context *smu,
 			enum smu_ppt_limit_level limit_level);
 
 int smu_set_power_limit(void *handle, uint32_t limit);
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
 int smu_read_sensor(void *handle, int sensor, void *data, int *size);
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
-
-int smu_set_power_profile_mode(struct smu_context *smu,
-			       long *param,
-			       uint32_t param_size,
-			       bool lock_needed);
+int smu_get_power_profile_mode(void *handle, char *buf);
+int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size);
 u32 smu_get_fan_control_mode(void *handle);
 int smu_set_fan_control_mode(struct smu_context *smu, int value);
 void smu_pp_set_fan_control_mode(void *handle, u32 value);
@@ -1328,9 +1324,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
 int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
-int smu_force_clk_levels(struct smu_context *smu,
-			 enum smu_clk_type clk_type,
-			 uint32_t mask);
+int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask);
 int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state);
 int smu_set_df_cstate(void *handle,
@@ -1349,7 +1343,7 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
 
 int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f88c1d2ab9b8..c760f75ccb54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -47,6 +47,9 @@
 #undef pr_debug
 
 static const struct amd_pm_funcs swsmu_pm_funcs;
+static int smu_force_smuclk_levels(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   uint32_t mask);
 
 int smu_sys_get_pp_feature_mask(void *handle, char *buf)
 {
@@ -355,7 +358,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			 */
 			if (!(smu->user_dpm_profile.clk_dependency & BIT(clk_type)) &&
 					smu->user_dpm_profile.clk_mask[clk_type]) {
-				ret = smu_force_clk_levels(smu, clk_type,
+				ret = smu_force_smuclk_levels(smu, clk_type,
 						smu->user_dpm_profile.clk_mask[clk_type]);
 				if (ret)
 					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
@@ -1574,6 +1577,18 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
+static int smu_bump_power_profile_mode(struct smu_context *smu,
+					   long *param,
+					   uint32_t param_size)
+{
+	int ret = 0;
+
+	if (smu->ppt_funcs->set_power_profile_mode)
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+
+	return ret;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 				   enum amd_dpm_forced_level level,
 				   bool skip_display_settings)
@@ -1622,7 +1637,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		workload = smu->workload_setting[index];
 
 		if (smu->power_profile_mode != workload)
-			smu_set_power_profile_mode(smu, &workload, 0, false);
+			smu_bump_power_profile_mode(smu, &workload, 0);
 	}
 
 	return ret;
@@ -1693,7 +1708,7 @@ int smu_switch_power_profile(void *handle,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
-		smu_set_power_profile_mode(smu, &workload, 0, false);
+		smu_bump_power_profile_mode(smu, &workload, 0);
 
 	mutex_unlock(&smu->mutex);
 
@@ -1767,7 +1782,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count)
 	return ret;
 }
 
-int smu_force_clk_levels(struct smu_context *smu,
+static int smu_force_smuclk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask)
 {
@@ -1797,6 +1812,43 @@ int smu_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:
+		clk_type = SMU_SCLK; break;
+	case PP_MCLK:
+		clk_type = SMU_MCLK; break;
+	case PP_PCIE:
+		clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:
+		clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:
+		clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:
+		clk_type = SMU_DCEFCLK; break;
+	case PP_VCLK:
+		clk_type = SMU_VCLK; break;
+	case PP_DCLK:
+		clk_type = SMU_DCLK; break;
+	case OD_SCLK:
+		clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:
+		clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE:
+		clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:
+		clk_type = SMU_OD_RANGE; break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_force_smuclk_levels(smu, clk_type, mask);
+}
+
 /*
  * On system suspending or resetting, the dpm_enabled
  * flag will be cleared. So that those SMU services which
@@ -2127,7 +2179,7 @@ int smu_set_power_limit(void *handle, uint32_t limit)
 	return ret;
 }
 
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
+static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
 {
 	int ret = 0;
 
@@ -2144,6 +2196,47 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 	return ret;
 }
 
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:
+		clk_type = SMU_SCLK; break;
+	case PP_MCLK:
+		clk_type = SMU_MCLK; break;
+	case PP_PCIE:
+		clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:
+		clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:
+		clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:
+		clk_type = SMU_DCEFCLK; break;
+	case PP_VCLK:
+		clk_type = SMU_VCLK; break;
+	case PP_DCLK:
+		clk_type = SMU_DCLK; break;
+	case OD_SCLK:
+		clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:
+		clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE:
+		clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:
+		clk_type = SMU_OD_RANGE; break;
+	case OD_VDDGFX_OFFSET:
+		clk_type = SMU_OD_VDDGFX_OFFSET; break;
+	case OD_CCLK:
+		clk_type = SMU_OD_CCLK; break;
+	default:
+		return -EINVAL;
+	}
+
+	return smu_print_smuclk_levels(smu, clk_type, buf);
+}
+
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
@@ -2236,8 +2329,9 @@ int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 	return ret;
 }
 
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
+int smu_get_power_profile_mode(void *handle, char *buf)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2253,24 +2347,19 @@ int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return ret;
 }
 
-int smu_set_power_profile_mode(struct smu_context *smu,
-			       long *param,
-			       uint32_t param_size,
-			       bool lock_needed)
+int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
+	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+	smu_bump_power_profile_mode(smu, param, param_size);
 
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -2764,9 +2853,9 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 	return ret;
 }
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
-				void **table)
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
+	struct smu_context *smu = handle;
 	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2840,4 +2929,9 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.asic_reset_mode_2       = smu_mode2_reset,
 	.set_df_cstate           = smu_set_df_cstate,
 	.set_xgmi_pstate         = smu_set_xgmi_pstate,
+	.get_gpu_metrics         = smu_sys_get_gpu_metrics,
+	.set_power_profile_mode  = smu_set_power_profile_mode,
+	.get_power_profile_mode  = smu_get_power_profile_mode,
+	.force_clock_level       = smu_force_ppclk_levels,
+	.print_clock_levels      = smu_print_ppclk_levels,
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
