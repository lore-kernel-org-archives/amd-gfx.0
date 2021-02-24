Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5D464E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5D464E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09C66E82D;
	Wed, 24 Feb 2021 02:23:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7F06E82D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 02:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwDqyrao/EKSl0nKJiGXlyxMZKpWswu97/SOaNwKTPDN+KmQuUqPv7+27Zj/MLxY6YipllHUpg2O9P05SQijeOr74tuzB4559VRNRh0ZONygTueMGTQKMyCfRNygQ43d5QGPnPyGfXrjwBHF8KpKYU8QaksrGpMSKAgEiQL5mFwC2W/q/bmOCyrV9wizvFefLQ8E/biqPmW99BhX4m58hwk3CxGb880v8Dw1QaFAZeiIAFzZJOnTK3XGHAUnyHdnkPJncI+jZXKSsScx0SPELL2RtyjPcROmbGZlCfFktGamVHPZgq5JWBpDFQmswBtxiy3w9F7rOfR+sQi32CqPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9FZ+LmH9BqwGuaGBolHXuJimmiQPU8n66KfbZAbIcE=;
 b=UANuKyvuRfXLMlcVp0G/kg61S7WjZhPDGDPYQoLT4ApDcePzi0hu/QeniPK3+KZ6gbZZ38uDWjz8ktDF4F31EpeNZp/7qYfNEazN7ocBlxGKpbX3d036EXBdZ3TpzSP7to1dIyRo9w7VsXg+S3ZNFVxU6dkgsiVsQ97MiyvDaSAZ2hYHZ+2gjpimHBSy0J4GREYY4ou/YG8DbhUXNvhzCXsksLglaHlgUsycPlWGQMOL+dJdmqEP3sniJ/VRJOIBFOWiAyiN6i+oeApHVkXLo/ekoZSk01MLuIxtewKLsKAVhk8cGkC6hNYoQBwuqvbYgbkRoyJYI2axKf8WXeGQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9FZ+LmH9BqwGuaGBolHXuJimmiQPU8n66KfbZAbIcE=;
 b=uCBgwG1BeBgv2RSlLj85zo28vkDvEjG0NXhqPSOAdX/50Rw6G+CErtjURIsQCfVvq7ZEkGwS0A/kLdS0TRb5nNHT8E2g5w75Z0bfYsrK4pwcqaZ8cNycTSivesxSuIL79mOHDmZSQM+DdMzZNAr5yycHUjvSuqX9rPiid0P60Wo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 02:23:22 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Wed, 24 Feb 2021
 02:23:22 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Date: Tue, 23 Feb 2021 21:23:07 -0500
Message-Id: <20210224022307.23521-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29 via Frontend Transport; Wed, 24 Feb 2021 02:23:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7fc62e2-8347-4608-90f1-08d8d86b286b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35949973F544E7F354C49BE5F49F9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aq0IiT2nzW//6wJt9ThykuBEeMZSgPeEQudATOjv3ZMq2ADgZviJS925HZcEDmzCehIxJ3sTbIuGZNAnNED1hf+kpd1Naem8rDl12rm6r8bMSE0AwK+cjJjXcgirUZgLE9MOxWcmm0EUPZ5Krcm1M3Vox5NLj6936VgCfh70QQWLIQQq1dkz2P+MPD21OIRYRFPbQT9dCqj48x6cIW3WOnKeyXtMS/kzZiAvinx2/v3d9WhGA8DnzxVDxEwqG8UvPjo2MbSvlQuyk0UIGQpAS0kH5Z8Lj0YVG5ez2chMmbAKWpS5lfIXAJn5sDUJNdApMfHZwBiU6UfyvXKg63NHTx832RVavvmADxWWYAZKhJeduvZ9efRa92QKKueF3ibN8lw60dLKGRer2hlUuJyjl10jxy4mV3x2XnMuLJl6MNoON2RArUEwfFtqVBvnq+w4kwCe6UFAkv2+GiTBI25TUe3u7cj2YIHq3DgGdjPo8TSfL3wFm1nQuN0sOM4KSy4oZ3qSLhf7rJHyEzF7RV917mu+0w8/j6qEUqfvuhg6N7DYSlRKmVx2FlFixzpxn1b4TQLC4VLfEhIOE23I2aEPng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(316002)(6486002)(16526019)(956004)(86362001)(8936002)(66476007)(66946007)(186003)(8676002)(83380400001)(2906002)(2616005)(1076003)(6666004)(4326008)(66556008)(6916009)(26005)(7696005)(478600001)(36756003)(52116002)(5660300002)(43062004)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WS33HmkqiR753kseAihs3SMcrN37jUNc79OqjTFkFGsVwcj5U2571eNfp0Pq?=
 =?us-ascii?Q?9y4FgxikSE5CZ8TrUTMudUci3jb/mVoTk5c5NpsH5OrzPRIEKEfSA3GSnw3G?=
 =?us-ascii?Q?U/E6Xg7DUqnOmFmMXgGf3NsUJC8XVrMDnKcLkBbEUKlEMB0BDm1bnFOCyax1?=
 =?us-ascii?Q?KG5y+j9bXI+mdS2N+Nw2KyEKYaMgvE8dTZ+I31ZGOTq0ggYnFezGoNh3HBV9?=
 =?us-ascii?Q?H517pMYwTkOi8xXDZ+p8n2DC+LeFKU4nMR6IvbXWwO4ZvZDzpBBsGEWPfaUq?=
 =?us-ascii?Q?vCH0bI7WCr7Hc4qVG+39JhffTd1+hAYkPduVDhQzFciIvHsPtxBnHGjcsDTM?=
 =?us-ascii?Q?uV0GU7CcW5NPRO2JDcWNWoWzb80uA545pu54BC9c44vTwpYFKGhzeaFRTB3x?=
 =?us-ascii?Q?0uinQ4IqJUovQDb2waGYbQAqW6yBUMHw8+3CMMci5CpBjbLQCoOT0/Sxes2I?=
 =?us-ascii?Q?1BJNUK06lZQstqKjhpkxPtZKIPqtzwnoexi8f2Al+/fPJPMTpmPG0zvBdVui?=
 =?us-ascii?Q?CxZsMbk+bK+bOk/8YIuxJttYAZ/EMQ2UymgATsseGEppD1iTjzGs23yw14Kl?=
 =?us-ascii?Q?Lp6O06gKorbLo75a6Wpzj7AF4SVEcvewy33aTZKA1A7aEuDqQvvCqbcQjpSx?=
 =?us-ascii?Q?LDCq+ZgbHjabMYY0DUW90rcQMysEhcPwx9+QSAQ26IVmnyAVYiKgsWH4Ms/m?=
 =?us-ascii?Q?gxSwkQeZ2ACpEZDZ4IhbDcS9flB7x1KKLaghKUrN78m/xYjfeGyF7J9GkyRz?=
 =?us-ascii?Q?B4NS4JI7Uxta0lZnQygoCCzAC0FpRUCigyl0MyYuVRhEiR+oCHI6aVCckXtW?=
 =?us-ascii?Q?Ux7BSzSLAZfsBMEQC9ExQvlb2wFkbH5I+ml9T//HiUL/VYI+/HjTiLkBeOG5?=
 =?us-ascii?Q?SeIWn/tPxk9jHRoSdTaIS3AbRWQyP3PoSEiWAyrAZgnZhJOTTabUSfBmD/7L?=
 =?us-ascii?Q?rm58N+PVsl3rQRkIKb74pzPhLwAMyEjuWWR7vmt8fsN6sRGrWbxBt3wwI1fS?=
 =?us-ascii?Q?qqU4ZMvXusTeZuGaV6Dueb2saVGK01TEmAWJJQhWvxaPRbribadvpTe2nEkx?=
 =?us-ascii?Q?9K41znNylh00yJfi1cH98xV3Zh3TqpfV0jMWcH+fa2wxHq1cviczj9qR4i1L?=
 =?us-ascii?Q?uhh6Bgm/mFEy08HbBE0E7RDIokb0itFJ5YHh9ZZxyyOwTEvVGDrR62obfJwe?=
 =?us-ascii?Q?o9A8Bz/j+eH+Z9us+TywfzUHemgrL7sSSRn4Gm7nRutEN5ykvkW75be4aZaZ?=
 =?us-ascii?Q?c/jIYs6wv6mGMN7frBu2wucpnncUKAeg9kKZ8SH5E4Dxyc0IrIZtNxq4DlIx?=
 =?us-ascii?Q?wQ5aghWOBT+D5of4NH2Z4s4A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fc62e2-8347-4608-90f1-08d8d86b286b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 02:23:22.6352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98qNUUpmiMMf62oABtceUTbZeUC2jJRXGVqnvXhuV31qKm+5YkM178S3TgAxRa5otBgje8KcNQV1v5sMLfyGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices
without sync to each other. This could cause device hang since for XGMI configuration, all the devices
within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue
by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't
do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init
to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing
gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 420ef08a51b5..ae8be6d813a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4797,6 +4851,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/* enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..cb59facba17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/* Don't do the real PSP HW init if we are pending on XGMI reset.
+	 * The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
