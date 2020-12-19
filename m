Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38B3C2D0E4
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F822343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F822343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5896389D61;
	Sat, 19 Dec 2020 00:49:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CF189CDD
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+b9zX76K7raqj3SI+7UDwUtSZb62sF/epJX6+9IYk5bJLRuZcxiMa45qZ4W3uoGHspv42plWCMBvlmpJoDfqKc0+7Nn5PujFIuN31YOqL1sNze5lXejG/LYlmZs1nJjEMVpiUqaSr0w58ptZhyP4vpfXwMy2vAdLIVl2K/jODnbDsmpi6tjQ/bvel1K9NKIKOfyGe+hSHrDctLq2fjfk6BLrj6caLmiT8TUyNIJn2TN+ER7F7j0/8Fh6SxW2vfVxjBn7Q7iPIVihuZ+zk5sZUE2qd3S422Gi31YjDPqQ6sQMBVgc0YWBaezfm7x9Ypma5EL4+uKhRETP8ejaKqQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux8wC2rqc5TRDVPyKFqoDZXiQ69U1pDz+2BadIxWbmw=;
 b=a3nCmq+hB/hw2CyvLG5utA9+aDKRu9gWpqS6adKC6B9p/RVtLGvqNByQ0uC6lOrmfU3l5KBfcvK0bV2InDOXSVpDgHn8ziPIXLVNGQTiWr2FAnV4gw6pqik501aup5nua9FD/cyCqZLYdLixtae4isKUScTOT4Mz+pP2/La/Eqeg4zddrE1G+Z/uqkdCgMaNtqi/QMHuDWM2kYqJ+fAdNv5PoePGeQHQa9w4waki16ehzvr2QdVTELPTSIIZkqIEshPA0y3n1gRAYL6Rr5P71gS0+uxUlfKyljsmcvRyBtIeT83y7FkMY+SQd+ncs874+rlXlYdx+8m4zWwQ5XJMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux8wC2rqc5TRDVPyKFqoDZXiQ69U1pDz+2BadIxWbmw=;
 b=ttmMtmyKAY2GerU6Vi0ZcgybN9gsEcOHYS0ccjbHLcmuPl2+t/XryOzeyt05w7mxwzW8wHKfaGFk/yy0/K596ruxjzNMIUY7akohqGEde3q5KAEzBoiFAXyLMeht8wshTxLWzruTdnXQ7fzePlYHOBi9S068PwSI3y+HfsJ2lGs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:09 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:09 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] amdgpu/pm: Powerplay API for smu ,
 changes to clock and profile mode functions
Date: Fri, 18 Dec 2020 19:48:29 -0500
Message-Id: <20201219004831.13527-7-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99a67703-e71b-40d7-dec1-08d8a3b7e548
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279E8BCDD35B37AD7882D9BF0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHAv5unmjhI1nPkWDvDJCEMt0nWLp7Duz6UST0lu7M5bgmILJ+tjs5okcIsGlUe/XhiwloDZYcHEHvolUNM21W6FI1xYsQIEKB9+t80D5diy5dSkRWgPcGrSSOS4hoHjU/ZnwJLFav5ZtcgCfQk/vvXQueSNnxNAIywCKdyxS9RdkmLg0EsAhYJQWFRwn33Ijle2Uo9elRpqSWPaTqMETKSgQi7gjvgWKoLGOmjOxbBpVR7nacTQ60suMFUFauelxu6NYUpRKhqTc+wU0+SHumK17akT8Dt5a1VKc9XlnjkQs0eo1fgmHFNIDJJ03e0479+UkUaUi/ubN0NItet1WWFsv8oUDvjbB+XeZq/Y/OdinIVRyqA2PN4Ri1OqY79O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(30864003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5uSDFBC6/ouGeT3ERWCvaePEH2pmJmagmcyZmmQWcrYGQOdYf8JnkwgLXRlf?=
 =?us-ascii?Q?sfsQBPnVKrMd++oOofifVs8mNUQwFjF+AGwh4+9ZEdVszCUVsdwJ+h2o2Aw+?=
 =?us-ascii?Q?W8M+e6qDH8yl1RBEiHlxXk/kgZN+mHCPEPK3YyaI/1IUJK99HHWOGmjlu4Td?=
 =?us-ascii?Q?2ur85h6+jV+6YU2UKNe058aa2duPgmqlaVyCa1BqtEMzXuIMGZqEuMRLU4jd?=
 =?us-ascii?Q?hUDe79F2TG8RUKAUitjhmxAz0eeIN7WvnwYI0mCBfeocFw+KmYOue6X4AOkc?=
 =?us-ascii?Q?phoLGwGFfdJm7d9fFAG4ltThJMSgRsCHWhJsgrac9znkeEPu3RNckTjdLDzA?=
 =?us-ascii?Q?F08MYIr/X1tYTO92YsyBbdTfYhb0xy49G6JYc8J5pPvdfZWLUwqWBePs84za?=
 =?us-ascii?Q?EpZh2MtT7flaM7ZEMVSYUh7MZBTxGw/e32SslE3mVTm4gdSb0HTTaG7+UEhM?=
 =?us-ascii?Q?Vq52C0bWLD/JeKKf/BS1VOx34bnnrWfrBwf6ghmDISMMzoED9KBcItmlfoos?=
 =?us-ascii?Q?7cMutldur7Mi0Adma4rXI/YFjfKYQEVe9vRjNdPqnfsWOkiIC2Sbk/AQIBNa?=
 =?us-ascii?Q?znzv6B3DhHjRxBq9r+PFYEuhvgKoSrnZWXVwy+FnAoS2x7DIcrdb4VxjKHsx?=
 =?us-ascii?Q?UPM9Q/O1rZ0WD+N2peMard+v7TfhK6UwUUVcMBC50rsL0gNDb2PDsrqA5PJx?=
 =?us-ascii?Q?THDWgz0UEmrX2I9YI/Mva8lG/8/T0TPaLIYZ/6z+f3RxHqdMNmSISRMaydEk?=
 =?us-ascii?Q?1vagsDatMNPSyMHtjS2hCenzHS2L7RZ+6E3vQv65ArGbHGfojZJ4oLHDMxJp?=
 =?us-ascii?Q?ZW/U2UcS0FvfCPCVQ06ovAZ3eLHyFWt14hZi2XcpARmstXoFY4otZJoqXW6u?=
 =?us-ascii?Q?CoJ76Y2gmzTwuKquY3MgPDlttxG4mlsNxTB2pih+OyIciuo1XfBhmjchLYHe?=
 =?us-ascii?Q?XvOFrkkEcOZsr7sj5FNu6AVv2EBOFN8kZisr8uKi+ZRLNZvs9swZT3mjJ33L?=
 =?us-ascii?Q?JyWf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:09.3336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a67703-e71b-40d7-dec1-08d8a3b7e548
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjAwCXlh5wi2jLB0TcngDcvUoM9FzEx6ALt48pwlPsoeB71FI1POu3Bi3W2M83SchugYPtpt5hCB8FIGW95RrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
                                   CLK ={sclk, mclk, socclk, fclk, dcefclk, pci}

Other Changes
  added 5 smu Powerplay functions to swsmu_dpm_funcs
  removed special smu handling in pm functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 348 +++-------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  15 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  93 ++++--
 3 files changed, 122 insertions(+), 334 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 41da5870af58..b84b14dc3eb9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -879,10 +879,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_MCLK, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
-		size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
+		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
+		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
+		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
 	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
@@ -1016,8 +1016,8 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * NOTE: change to the dcefclk max dpm level is not supported now
  */
 
-static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
@@ -1034,10 +1034,8 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
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
 
@@ -1083,8 +1081,8 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
-static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
+		enum pp_clock_type type,
 		const char *buf,
 		size_t count)
 {
@@ -1106,10 +1104,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
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
@@ -1120,35 +1118,26 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
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
@@ -1156,67 +1145,14 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
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
@@ -1224,69 +1160,14 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
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
@@ -1294,69 +1175,14 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
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
@@ -1364,69 +1190,14 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
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
@@ -1434,38 +1205,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
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
@@ -1652,9 +1392,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_get_power_profile_mode(&adev->smu, buf);
-	else if (adev->powerplay.pp_funcs->get_power_profile_mode)
+	if (adev->powerplay.pp_funcs->get_power_profile_mode)
 		size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	else
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -1717,9 +1455,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true);
-	else if (adev->powerplay.pp_funcs->set_power_profile_mode)
+	if (adev->powerplay.pp_funcs->set_power_profile_mode)
 		ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -1976,9 +1712,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev))
-		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
-	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
+	if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
 	if (size <= 0)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 739d645df7ef..3c0b6209ab6a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -662,19 +662,16 @@ int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);
 
 int smu_set_power_limit(void *handle, uint32_t limit);
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
 int smu_read_sensor(void *handle, int sensor, void *data, int *size);
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf);
+int smu_get_power_profile_mode(void *handle, char *buf);
 
-int smu_set_power_profile_mode(struct smu_context *smu,
-			       long *param,
-			       uint32_t param_size,
-			       bool lock_needed);
+int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size);
 u32 smu_get_fan_control_mode(void *handle);
 void smu_set_fan_control_mode(void *handle, u32 value);
 int smu_get_fan_speed_percent(void *handle, u32 *speed);
@@ -748,9 +745,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count);
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
@@ -769,7 +764,7 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
 
 int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 48b6e46a9702..2a7330cebeb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1452,6 +1452,18 @@ static int smu_enable_umd_pstate(void *handle,
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
@@ -1500,7 +1512,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		workload = smu->workload_setting[index];
 
 		if (smu->power_profile_mode != workload)
-			smu_set_power_profile_mode(smu, &workload, 0, false);
+			smu_bump_power_profile_mode(smu, &workload, 0);
 	}
 
 	return ret;
@@ -1571,7 +1583,7 @@ int smu_switch_power_profile(void *handle,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
-		smu_set_power_profile_mode(smu, &workload, 0, false);
+		smu_bump_power_profile_mode(smu, &workload, 0);
 
 	mutex_unlock(&smu->mutex);
 
@@ -1639,7 +1651,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count)
 	return ret;
 }
 
-int smu_force_clk_levels(struct smu_context *smu,
+static int smu_force_smuclk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask)
 {
@@ -1664,6 +1676,29 @@ int smu_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
+int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:     clk_type = SMU_SCLK; break;
+	case PP_MCLK:     clk_type = SMU_MCLK; break;
+	case PP_PCIE:     clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:   clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:     clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:  clk_type = SMU_DCEFCLK; break;
+	case OD_SCLK:       clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:       clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE: clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:      clk_type = SMU_OD_RANGE; break;
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
@@ -1961,7 +1996,7 @@ int smu_set_power_limit(void *handle, uint32_t limit)
 	return ret;
 }
 
-int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
+int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
 {
 	int ret = 0;
 
@@ -1978,6 +2013,29 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 	return ret;
 }
 
+int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
+{
+	struct smu_context *smu = handle;
+	enum smu_clk_type clk_type;
+
+	switch (type) {
+	case PP_SCLK:     clk_type = SMU_SCLK; break;
+	case PP_MCLK:     clk_type = SMU_MCLK; break;
+	case PP_PCIE:     clk_type = SMU_PCIE; break;
+	case PP_SOCCLK:   clk_type = SMU_SOCCLK; break;
+	case PP_FCLK:     clk_type = SMU_FCLK; break;
+	case PP_DCEFCLK:  clk_type = SMU_DCEFCLK; break;
+	case OD_SCLK:       clk_type = SMU_OD_SCLK; break;
+	case OD_MCLK:       clk_type = SMU_OD_MCLK; break;
+	case OD_VDDC_CURVE: clk_type = SMU_OD_VDDC_CURVE; break;
+	case OD_RANGE:      clk_type = SMU_OD_RANGE; break;
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
@@ -2069,8 +2127,9 @@ int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 	return ret;
 }
 
-int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
+int smu_get_power_profile_mode(void *handle, char *buf)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2086,24 +2145,19 @@ int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
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
@@ -2582,9 +2636,9 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 	return ret;
 }
 
-ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
-				void **table)
+ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
+	struct smu_context *smu = handle;
 	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2660,5 +2714,10 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
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
