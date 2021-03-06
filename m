Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F6C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A6A64FCC
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 21:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A6A64FCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D326E082;
	Sat,  6 Mar 2021 21:20:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7203F6E082
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 21:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRy1Cnq4b+ipSRZyWzynfnAYJ49TVnnBOZYeKjn9TBNF0DXvECbxDhyvpoBNMNHXe49DpVuPJPfg3dLCzwkg5oyKXpwUBNzKwZV6h83/38GSXlvXFmj47/Ox47KCD9piz2hJ9G3M9uEkPTm2E2bxcYGTOosDiFCkV1faKG3JEH2KomywE+OBIwqSsTXwE+UkBq4w6A7HttmgRSOIJGOS9522uKng69gG7lZQFXiQbprV6WY0n6ioaU3oXpXoAMkd0UKrpNS7AsacDNAhQeQAhbaPZGtUnmbL3Lvf4ctiJQhY/q13OKu1UFcSMFL8Q9CcquLLFjUctC72XhjynmZkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXxAsB+W+uLIcbwKTVhz9amJ91wuSTWmSDfB8uYPRrk=;
 b=KuZrs65t8BlTlBgprUvA7uS6E7jzwkW7eMx3BoNTygqO+kivWk2afpfDfLmE+S6on1JckB2OCufMG2ilknUTbSdKMTjRnAqjB+kasrIh7IG4V7aIS4ajsABtmjLYV10r7Wzpn+/stbAezGsLArG7uKQeyrTXpfQZPrbDvHWwE/USbqLPnJFLd2rH5NVJJCdI6g/Eyqf6XIiOzKvum+NHSmYTIr2YdsAkdehHDagcZFoUH4zwHvRaW31WZimimjdyBfk/pqdiknEz/E3Jib/n5cxMlfKmFC21bEiNiIbyrNrd9EZ3Sf20M/XZVmdhnDGke2s1W4vdybsqPFVbvNZR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXxAsB+W+uLIcbwKTVhz9amJ91wuSTWmSDfB8uYPRrk=;
 b=NwDmJKjpo1NO/+TldfCZhBnzIVpqRKZwKzw1QficesyGBpBaUX3gP4GYqZbQf9Tz7P80Nyzkksh7m4aAaE5yKuU80Ts/6H4vr9YB6rXCHIqq3mfUmXM3+Ktvx9x3jkeJfqX7XUFD5jeK2W2xmtvpe9imAJP5BZxzNfqJ+4Ja/Lc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Sat, 6 Mar
 2021 21:20:48 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Sat, 6 Mar 2021
 21:20:48 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Date: Sat,  6 Mar 2021 16:20:34 -0500
Message-Id: <20210306212034.14421-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Sat, 6 Mar 2021 21:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8f664fc-e340-4c96-c357-08d8e0e5b5fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28099B72C78B3C3257B4651BF4959@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZ3enEGOCx1fwEomrtwsNGphn2Nb1CIFOBsA/VjRDrnLp2XJ0j3sXzAmnwtKzjOCS3bCdAolDb4g8TIx8mxx4vrgUConHU5N6p+S5ftj7r2sCDHUt+JM0HA7+/oDgT1mAxarV4AWZheozXWisEgq6g7ZQ3spL/7cBBCCugTAF8tQqi1pc6ft2R6gAW5CssZRYTaC+mY/mD5Vu5DT1ID3tj+pdijHtQgbUFe8e0mpc9JcdSGl8H0zIQm2j7PeczbaYPaj1aAVu6wT3l5qJSwwMhxkZ+Yg2wlcG+Td0DlcE86ek0wQSCWH8TM565hJwCYTDD1NAnFhI9XMJCfMztW7NKUmSqvkDlm30JRrg1rdRYyxvw5oyS0bBM84xCDi+CG2CmAAEVwecwjH8lPf/GF3ktshh4yts8s9lBXwHgsRPUJRcynT2ch8dAWy65QL7mENNvNgohyIRz96u73w6SMTYvpPvEGNNPwSfnPMeezpubRQppfd3D6U7A7QDdpBrifLGK2sdtxAbTB0OUoJXAMVgx70bISiQgvHmjmdbQq5Qo8uYEfU4MBLFvEyt8A6xkPK6Ncn+GHpvB8Jr1a4F96a+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(316002)(66476007)(83380400001)(6916009)(66556008)(7696005)(2616005)(66946007)(956004)(52116002)(186003)(30864003)(6486002)(478600001)(6666004)(86362001)(36756003)(2906002)(5660300002)(1076003)(16526019)(8936002)(8676002)(4326008)(26005)(43062004)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ts8+I+6SG9WtMTlmg3FDKRrPGW4QElupxl/84HD1NCp+S6m8xCvllCd98WKr?=
 =?us-ascii?Q?7BUcrNSu+z2cKV4XR4iJEhZEkk24Jjtx1/v77EvXPRhAnAszSbx362XLY1mq?=
 =?us-ascii?Q?cIbucRbjByJ/oLTz9t8w25MR/bzaahwb1DrB2Yqt5Zd3J2nLotmpZgVb5guv?=
 =?us-ascii?Q?qhLg+YqprjBgwzPQvgKuHvbXSqNmZp5CGDlQdC5Rgu3LWUA9ScLDFRRLS5xV?=
 =?us-ascii?Q?a/8/wT1gJMihqH/ANQwrCG6uWdDxabDIfd9ErlvZhKMZUt6XC4S8k6Q5vzxn?=
 =?us-ascii?Q?/3/yVyP6Tz2MnIbDwt1lnKH6gczswUi42798o58/UonMn+mpWydF3NKavDDv?=
 =?us-ascii?Q?qnuXKWoREbauWAG19BvkOWWYhurgnwYQw2BYETf7Z+XR2YWWFMKVepMyx4dy?=
 =?us-ascii?Q?VreeItGGLCPUEQPrXEMYKVHMdlNxyj0LuvYljGa6W1H04mtsFmk4+oRTyypt?=
 =?us-ascii?Q?Im4FnRk+aU/6Wy0O9VL+uMzsM8AFcLsTAG+EAalMW5J+msIsHkFspBQd1QLJ?=
 =?us-ascii?Q?6pZy4lYITZkBZQc7JlRbnZZt5hVkrj6vOsW+ufHCEXEMKAHkFCScLbqITPRU?=
 =?us-ascii?Q?ymEN7ud68GvLbOo3NxTi6R4ZLKwNMWOAhpAY2vIQYNPfR9uuySuKwtG6FzWT?=
 =?us-ascii?Q?Mth/DPuz4z7TU5i6mm6g5VBmpbQ4MXzjguzNqTtZuu8jHAnBGfKw6I7slR5r?=
 =?us-ascii?Q?nGj1kFsIOshIMydsQ9KQ3zdY4m2hL2RqgVMBoYge6oyP1iDggd214xP55gUS?=
 =?us-ascii?Q?1l+flwgJ5sKBfxv/jlEEMu4f/em4toJo42MyQq9TxC4R/87jiPPfXqkp0zVd?=
 =?us-ascii?Q?IhwUckQWE/53uBhnPPXwOLkyCmhoyznbmiz3UrlEJIVYfx4NZHm5z++q7Mn/?=
 =?us-ascii?Q?ekJ6qHk7b34nedmRZK/Cvy0lIpeOhPTOGMrFCSDBNTgwnU4i/zdmCGHjye5K?=
 =?us-ascii?Q?k8AdO5VwkGvjqzxQQCIcN/lGMB6FrcU0ta7HTqamAT0O89xZpkyW1m8iCUX9?=
 =?us-ascii?Q?DFd2Ftb/sz//lbPMqeK1ZPAbh+p8pyKQDtMF1gkw1pQiMsT0Gk19KbvrCCHx?=
 =?us-ascii?Q?eJQW3DycYrmlhoTeLjjNGVnmtmkAJ3CQgp7SwmJbxBIY7Ua4+6wJkwbcV954?=
 =?us-ascii?Q?radhAehCVBecoGzLFyMyfsxBCMxz58PMPTCoI7Q79DDg+uyu9Xsbqby1jcIW?=
 =?us-ascii?Q?Cje4lFcfjQ164HdAo7rvExX3IHy/wIMx7HVyIXeX/34D9geCYczpMt1NbwNt?=
 =?us-ascii?Q?gbPor/B3j92r3L1Ci3LfYy3dKcrzOdxuPfPOOHFxXcMon5HUKWakhq1O9zZX?=
 =?us-ascii?Q?ip0aOofrFnNzFLF2MsAAR7R9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f664fc-e340-4c96-c357-08d8e0e5b5fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 21:20:47.9613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdsd8jsw3hErmc7QNBk6Fo8GktLTPvd37poXkO3eHqH+09WT8+tJH80LAzjL4bAqJE8EBMNQERGrRZGd6R9zNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  69 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
 5 files changed, 163 insertions(+), 30 deletions(-)

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
index 253c59e0a100..0bfc5f978d4f 100644
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
@@ -1297,6 +1303,69 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
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
+	for (i = 0; i < mgpu_info.num_dgpu; i++) {
+		adev = mgpu_info.gpu_ins[i].adev;
+		adev->gmc.xgmi.pending_reset = false;
+		flush_work(&adev->xgmi_reset_work);
+	}
+
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
