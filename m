Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36693C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D756164F67
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D756164F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0426EC0C;
	Fri,  5 Mar 2021 17:53:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EFE6EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 17:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkVIWEX4Kc/nUDcdzeOTVIIVaOaRtGnioOO2NzZDCyZU8T2TPEvSZren/jFCLGtk6+WkGZ3D2S3AxQo366bdkRZKp0Kf9oJycC3/TKc0Hc8DM9m6Z9/ruhsbLiWlMJqwwVU5AcEACyZmXgqcd9OJZx5c1k1hSf5RqwY3UZH59NWsuIkZLOTRYhiznxhomlS9YtPbXcUZxfw1ctKp0ZdhM7PqGw50pVRqgyHJVy90g7EvYW4p+7XC9TChNwiYPx3sISDVfnqFrBfod3aLFsqVJL9DSns9SYsbpxfdEeCUQntEyVnezJPX/JRmKqZMDpMyAK8qhVcazlKU4Gmh9+rnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLoRUCBWpYEKb/vh3CtJug2Dt0srhStbbXSFxaxJzDg=;
 b=cOvupeGdShsFu1q5lOfTVFoB4N0IVXnv5E74FfR/Q5PD9z61x13bjOClLozn+7Yb9+GLJAxChi65AOvpHVba8KrIppdpVetseWqZG0vtb58ekU+6tYHilSUaj2bPFeDp75DF/pBZ8dlX039uwWP3iqdDkyvHkzNOfSuSH7TgapcurpGVQ7P8jLbpV1TiMcdFiVS0Mqt2fnX1yUi4ZkjnXLAHocZL+/QfRsUKbkHkkg59TeUH54NbiQHyUcuOnzqNqYYHVZA6nSTt7mM5A6wmDuyH9SJnbq3ZE7lKE+nUw+g4HkA4Pzj6ABNqgjsdqRaGUocwoXE6/4KgaoBlUrM3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLoRUCBWpYEKb/vh3CtJug2Dt0srhStbbXSFxaxJzDg=;
 b=gd6GeNg0oO0nLhC8NwEsFzynUTiK0JvKEO1QteyazBgox3jD8UoxK72jyt7VPkDgy03XbJDcytDjHa9R/B1SQJSRYLaTNytJuy4jN7erK6R0WZoGQHyhn5TpIAk/gJ2qbP2UsNX6RpzXuKTuVSNtL9NXbsoRfJEcmdIdy8sC/2Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 5 Mar
 2021 17:53:09 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 17:53:09 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Date: Fri,  5 Mar 2021 12:52:57 -0500
Message-Id: <20210305175257.32219-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Fri, 5 Mar 2021 17:53:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 630544b6-0a9c-4922-0474-08d8dfff898a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40091419BB158EB63BEFF044F4969@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDOLosVXYVOnUS+TTpdiu03adbhAdVDCSTaQLmr+aJ2ZmQhF2f190flBl1JLbNOaGFqR8bDlKdXwFu8jw45UiY96HiY007jFaLP/zZv7Oi0dhkr5pXorhxVf5/ppVhOkpqYrw+rOCOtUEMF3e97pa8PJo4yZC/AOtxEk24Nh4bYD72uNBt/oG/IEME0lATVV1yG8gkRpi2fA8IbYwdvguMEQxujNemBVPA6ylDw1iyejzdJMDogOfNe3eFmCNc0F4CQpUyPBecmdGp6mwEtyIEMr1WDB+9sMdolqkIvqNty3ppJbdBf15l51V/187BOuuspOjOpgZP6TQphZMrtqhooKUANg0zaWvzch9LPpTGz19kR+VjLRI322Ut/rw1Sii+mQPRhyPAu3buzRq/G5vGZ7UDfwkWKvcsMaFgONiBBpQc/IChpzJBu0jA4xG5Yr5Ddic74osY0Fwo1BEF74dv3qeIY8+w3lg+UnqzEq8CLBhEQWskCydn7DNpqxg4luqTUtNJXLiEL5qsWTOjymVTmGP1x5UzYQxdA6oc6n52NJ7lR4Ee5zETZEB2PtBWgsHqYbib10VEF3k9XiRwdkcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(66946007)(16526019)(316002)(66556008)(52116002)(66476007)(7696005)(186003)(26005)(5660300002)(6486002)(2906002)(956004)(2616005)(1076003)(36756003)(6916009)(86362001)(83380400001)(30864003)(8676002)(6666004)(8936002)(478600001)(4326008)(43062004)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SACU5XvLmXxfMgc6EJjm4eQNrkYOnz2CW0VKWHVjtIeud3nkyN9F3+rv8QNG?=
 =?us-ascii?Q?9m+BF4WPyF2uWc0RqMsIILPwp27m2fj4CSDsn4jSV3RY+kwX8vcP8nc2sTzS?=
 =?us-ascii?Q?O8dTA6zsi5WDbtR9AVfVhzHWOkV0KwxI74ZGhv8aQedIYefNT2MUj9cXi4hw?=
 =?us-ascii?Q?eX5FwtUEtoAj8aAKW0Fv7/kn5LKBN4EulL8FOvj9Srm4jb25y5BZE7szZeM+?=
 =?us-ascii?Q?yx/8vZ/8EkuOD3re6ung+OEPm5guu1wWhERoKRUgfr/22HIDkdK8qLCtIkNl?=
 =?us-ascii?Q?e0yUitWQur3Qdgbk9KvlqeaqOV4El9BrVGkNVChQ36arvxpKaX/AQi07cTBA?=
 =?us-ascii?Q?AmR7f2LDjhEOtVdpvT0r7GWlW+MQSMUeoy0r4+e82vpTH1jdjC0VoYNwZ/KF?=
 =?us-ascii?Q?FVzWoBFakzaF3XL3SZkNMgyW6U07REpH/ZBJXGyanLpuxGXL91cWoC12MTN/?=
 =?us-ascii?Q?1AANSIzR9FKR7Y+jX1wD9e6JcXruUImgYOgS5j1rxz5jdh//SKbYspyYnk6i?=
 =?us-ascii?Q?cb26Wd15Y3ipDIBotEyphdiq6+T9N9s10IIx0ppMMk6ruNeioC7XWxGGkhpx?=
 =?us-ascii?Q?1zslA9SiV5zyNdVULI1m1mYbNMe0PWTtTf4x9ojJ+GKUGn1YmlA3K0ue4Hgt?=
 =?us-ascii?Q?TvZmXAVlF3GlgL6LjfcDJ1tMEx0caMr5jpSBpvfg38o9s3/kebADmzS6SebN?=
 =?us-ascii?Q?I3f8+tzpRV0/YaxTG/exSqHNXlrafCn3tcVsQokeOXSaozeRADXntxraFl9I?=
 =?us-ascii?Q?W/eBQZAoaUjpUmFbCYzW1NkVtpzw4R8M+31iQ8X/DMFFC7aMkoQ2RPOputdk?=
 =?us-ascii?Q?sxKT2Bfm5WBX71UlgT5L+K+BnLJ7UwXZ7BjJ573sgYTI7xfKBszu2lE0Flw0?=
 =?us-ascii?Q?gSjdnMzfoEwk3qaC5TLFWFxBbugaNDfPgq+1qJCPGXXm/CcBiq6qB0Uv9Fqj?=
 =?us-ascii?Q?sy0GeQa7TTgJpNPbqzeCoGtwupBfZ1BREh6jUhqYk3tx9IQuhLjs3gov3SYo?=
 =?us-ascii?Q?qQJQqAhaZ6Eb9L1FA+bnLSm79TgdJwERuyr6SYV3+af9j8NcaknTNcO1xf0i?=
 =?us-ascii?Q?vwe1y/2B3ItIc7mjzMvbvJAX+bVzQFUUAQm/NcUwW76j3X0RiarI2BuDnOyH?=
 =?us-ascii?Q?E/Zq/h3i8X8RGKLVtJRQ6SXktqgjGd5aMkgto6jTSmZTgJTYCqay04uNCmwr?=
 =?us-ascii?Q?lcLlTGtnQ6EPZtqX9voYgsIysUyaPesRqlMGYq23VacnIKkMo1zN+xlI5w+J?=
 =?us-ascii?Q?VI7n4YpRSGCBuCky1tTPvlZt7T9FZTiHjv24UUtjMgzR8lNbXn6Sl7/4pRET?=
 =?us-ascii?Q?Ff1OzhFwPK8sA4d4mIUCMC7b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630544b6-0a9c-4922-0474-08d8dfff898a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:53:09.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KREbfmq+RSKP37XB1K0+Sjsh0T2/gxVxRuGS+bb4P/ShW2ykfwlMzwHksgkuj72lY5sm4amwbqqskIuSy3zuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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
to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
 5 files changed, 165 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d46d3794699e..5602c6edee97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
 	uint32_t			num_gpu;
 	uint32_t			num_dgpu;
 	uint32_t			num_apu;
+
+	/* delayed reset_func for XGMI configuration if necessary */
+	struct delayed_work		delayed_reset_work;
+	bool				pending_reset;
 };
 
 #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
@@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
+int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
+				  struct amdgpu_job *job,
+				  bool *need_full_reset_arg);
+
+int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
+			  struct list_head *device_list_handle,
+			  bool *need_full_reset_arg,
+			  bool skip_hw_reset);
+
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3c35b0c1e710..5b520f70e660 100644
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
@@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
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
@@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
 
@@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
 
@@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset)
+		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
+
 	return 0;
 
 failed:
@@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 }
 
 
-static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
-					struct amdgpu_job *job,
-					bool *need_full_reset_arg)
+int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
+				  struct amdgpu_job *job,
+				  bool *need_full_reset_arg)
 {
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4293,10 +4337,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
-			       struct list_head *device_list_handle,
-			       bool *need_full_reset_arg,
-			       bool skip_hw_reset)
+int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
+			  struct list_head *device_list_handle,
+			  bool *need_full_reset_arg,
+			  bool skip_hw_reset)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
@@ -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
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
@@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				 */
 				amdgpu_register_gpu_instance(tmp_adev);
 
+				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
+					amdgpu_xgmi_add_device(tmp_adev);
+
 				r = amdgpu_device_ip_late_init(tmp_adev);
 				if (r)
 					goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 253c59e0a100..aebe4bc561ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -44,6 +44,7 @@
 #include "amdgpu_amdkfd.h"
 
 #include "amdgpu_ras.h"
+#include "amdgpu_xgmi.h"
 
 /*
  * KMS wrapper.
@@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 
+static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
+
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
+	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
+			mgpu_info.delayed_reset_work,
+			amdgpu_drv_delayed_reset_work_handler, 0),
 };
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
@@ -1297,6 +1303,71 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
+/**
+ * amdgpu_drv_delayed_reset_work_handler - work handler for reset
+ *
+ * @work: work_struct.
+ */
+static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
+{
+	struct list_head device_list;
+	struct amdgpu_device *adev;
+	int i, r;
+	bool need_full_reset = true;
+
+	mutex_lock(&mgpu_info.mutex);
+	if (mgpu_info.pending_reset == true) {
+		mutex_unlock(&mgpu_info.mutex);
+		return;
+	}
+	mgpu_info.pending_reset = true;
+	mutex_unlock(&mgpu_info.mutex);
+
+	for (i = 0; i < mgpu_info.num_dgpu; i++) {
+		adev = mgpu_info.gpu_ins[i].adev;
+		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
+		if (r) {
+			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
+				r, adev_to_drm(adev)->unique);
+		}
+		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
+			r = -EALREADY;
+	}
+	msleep(100);
+	for (i = 0; i < mgpu_info.num_dgpu; i++) {
+		adev = mgpu_info.gpu_ins[i].adev;
+		adev->gmc.xgmi.pending_reset = false;
+		flush_work(&adev->xgmi_reset_work);
+	}
+
+	msleep(100);
+	/* reset function will rebuild the xgmi hive info , clear it now */
+	for (i = 0; i < mgpu_info.num_dgpu; i++)
+		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
+
+	INIT_LIST_HEAD(&device_list);
+
+	for (i = 0; i < mgpu_info.num_dgpu; i++)
+		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list, &device_list);
+
+	/* unregister the GPU first, reset function will add them back */
+	list_for_each_entry(adev, &device_list, reset_list)
+		amdgpu_unregister_gpu_instance(adev);
+
+	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
+	if (r) {
+		DRM_ERROR("reinit gpus failure");
+		return;
+	}
+	for (i = 0; i < mgpu_info.num_dgpu; i++) {
+		adev = mgpu_info.gpu_ins[i].adev;
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	}
+	return;
+}
+
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b459ef755ea9 100644
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
@@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!ret)
+	if (!ret && !adev->gmc.xgmi.pending_reset)
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
 exit_unlock:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
