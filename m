Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F101C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E92206C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3m6rZn0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E92206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7AE6EA01;
	Fri, 22 May 2020 14:57:18 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C736EA01
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 14:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgumqZw9La6+zMsP3wut4PikFTC7n1bnyaUzhV5eeJ+LFBRKBi7PaqQw1XxeAsmj/TDa5wVpw9EzH7zJVr5ysSOiMaqAFjXobMd4/SJZrIYBxpBmuGQPHLsKxKE+laZT3HFJuR8Igos3ZstegeOWOkzHevnkf83qsN7IenwgYZMOOgctjMrsVFvapATjzNDhnwTj4zsnB7GaifhJWDkdRPYN4t68eFQ3hofAkEIMwa9eRiepHAX/AibGP9eKIqsP0Yia5rDqUhVnPfLvJwuIZ3W0v9JvSL2cs32CcsMjCVWHfb+ew0SqQAlFViQ7aRdF21HEkuOMUAw0xhfLBSmhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJtFk+ruWBjTqppUy2M0ctfmFFWtn3EA3wB/MvE4w/8=;
 b=ivJEqOCyPMS5kxk3BEXdkYHZHBCCkUuhDlky97UJS1p4iokfccxRsZfkYbDIXWcAOLvwpwXJa8TGslI0XQ16vnw2KoISA6jRDCVMgChOWZro+kIMONch+r5lBcdFSRr+nwbZksIfDXe45poJdoZP7wjpduYe6NI7Z37psDMbRVjMRWNq2r9yVZGyS3ugN3sSm2zcsG+ONZ4wD5+Eri8V6TmqnvK8sJoix1wJpS0FHh7BMS5qsLNcnXHjGv+CfUDfSc6w70YIOxXfm+IqvaNBXdTYuPeQcRUxJhCZ5FiPFJ5S2ofhDeSkQnIZ1h1Fv0SxwBgdfO7/fSbCAVjb/hp2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJtFk+ruWBjTqppUy2M0ctfmFFWtn3EA3wB/MvE4w/8=;
 b=3m6rZn0zCMC+ddsRsT4l4XNC7zCGJ1emqNmLQmXrM/QTShxRqqHKXLQkOAcaQsxzf7IVG9wVSiTjU9sSEsdF/Xvu2N+4su3gKKLXWZjhYggdLVtNBRrXKN1k6rw2BGw9if1NHGPV4TOZje4B3EHr/iCgNJlydn/NZ3EIYXRUg24=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 14:57:15 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 14:57:14 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix device attribute node create failed with
 multi gpu
Date: Fri, 22 May 2020 22:57:58 +0800
Message-Id: <20200522145758.13348-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 14:57:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b075015-9833-4c39-b95b-08d7fe6069f5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB42415C43873A3879812CBB5FA2B40@BY5PR12MB4241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6eBi9uCCfISDpSd4M/ZdN57c8pZAeIjaJ/yxFlF1595p6WKFAY/Lr/XLu3yxklWGoW2LbR6dEjSTykiSD6+JJuNAHp9YliEZJf8dRRJO113qFd0HxdzStffFzw6IiLLlhqVlVd7Y6+dOqZAv3j7aJVm/xErr/jUJddk6eaf4ZVJnHcewP/JEyPuXeq0kybaHmItMkqWjjfAjK1tY05T4ienocFRroZyKZmWqhXP5FoQcauAz7PcchEFWmw4Yogsq+BDBZXPhqfwqS2JfvOaXuHRmScsEGdUOGpJZg8AJCMHT2Nk7UuvRVAI7xX0/puP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(8676002)(6486002)(2616005)(956004)(8936002)(6916009)(86362001)(4326008)(66476007)(186003)(316002)(7696005)(5660300002)(26005)(16526019)(6666004)(52116002)(66556008)(478600001)(1076003)(36756003)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZylY+J5KCrJsjZg8eG16cZIMD3bYrrMIXSdA6/F/Bu3cD7wFnZJlyVRGYtcl84wa6Khfv4+6EogyVWhp/sj0vGrZTOPFoWSAxGAiiIqg+uQpeoUj2qxPaZfIXuFMMhqQsZvoDH0mXqOzRug3BQhuJaDhQsx6vBs48qIFcFqH9WvD2xJL25jcnCzaNuir5JAQrwiRchDLt/SKwpXwcUnJHLx94mocqtMrcHK+SjY5Znj4PbyYQUGqc60Pkhz3F7zNSfBrgEndqwBAObKX3aJxCEhEMBjICpENm/f3mcOUbbggJWETJ/j+MV7Wyl8ozzhKm2094yh6HK85rzu11DQweMCLy/esFozXUL1+qvCyLdThuU31+SQbF4uMfwUEjvHfACO4oHR0e2J1bBC4Id+nsUHMshB+6DA9VsNfo0Uk/13YgcIlYWSoI7YTCM9M3P6HQUIVOVjDNqjRnxru6MOVRZzcH/ePoTkxO9hHbvNLRXSpoqrAbzmrwpvlRZ4R/pJq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b075015-9833-4c39-b95b-08d7fe6069f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 14:57:14.8433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8wco3ryVd6cjgbMr786qo9SCX64qZiRds1ec5XysteX0AK6ua4MKA//PqjayHUl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the origin design will use varible of "attr->states" to save node
supported states on current gpu device, but for multi gpu device, when
probe second gpu device, the driver will check attribute node states
from previous gpu device wthether to create attribute node.
it will cause other gpu device create attribute node faild.

1. add member attr_list into amdgpu_device to link supported device attribute node.
2. add new structure "struct amdgpu_device_attr_entry{}" to track device attribute state.

fix:
drm/amdgpu: optimize amdgpu device attribute code

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 +++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h | 13 +++--
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bfce0931f9c1..b84146339ea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -995,6 +995,7 @@ struct amdgpu_device {
 	char				serial[16];
 
 	struct amdgpu_autodump		autodump;
+	struct list_head		attr_list;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 55815b899942..ac99aa0a16a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1725,7 +1725,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			       uint32_t mask)
+			       uint32_t mask, enum amdgpu_device_attr_states *states)
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
 	const char *attr_name = dev_attr->attr.name;
@@ -1733,7 +1733,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	enum amd_asic_type asic_type = adev->asic_type;
 
 	if (!(attr->flags & mask)) {
-		attr->states = ATTR_STATE_UNSUPPORTED;
+		*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
 
@@ -1741,34 +1741,34 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 
 	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
 		if (asic_type <= CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
 		if (asic_type <= CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (asic_type < CHIP_VEGA20)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (asic_type == CHIP_ARCTURUS)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
-		attr->states = ATTR_STATE_UNSUPPORTED;
+		*states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
 		    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
 		if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
 		if (adev->flags & AMD_IS_APU)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(unique_id)) {
 		if (!adev->unique_id)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_features)) {
 		if (adev->flags & AMD_IS_APU || asic_type <= CHIP_VEGA10)
-			attr->states = ATTR_STATE_UNSUPPORTED;
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	if (asic_type == CHIP_ARCTURUS) {
@@ -1794,22 +1794,24 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 	int ret = 0;
 	struct device_attribute *dev_attr = &attr->dev_attr;
 	const char *name = dev_attr->attr.name;
+	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
+	struct amdgpu_device_attr_entry *attr_entry;
+
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-			   uint32_t mask) = default_attr_update;
+			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
 
 	BUG_ON(!attr);
 
 	attr_update = attr->attr_update ? attr_update : default_attr_update;
 
-	ret = attr_update(adev, attr, mask);
+	ret = attr_update(adev, attr, mask, &attr_states);
 	if (ret) {
 		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
 			name, ret);
 		return ret;
 	}
 
-	/* the attr->states maybe changed after call attr->attr_update function */
-	if (attr->states == ATTR_STATE_UNSUPPORTED)
+	if (attr_states == ATTR_STATE_UNSUPPORTED)
 		return 0;
 
 	ret = device_create_file(adev->dev, dev_attr);
@@ -1818,7 +1820,14 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 			name, ret);
 	}
 
-	attr->states = ATTR_STATE_SUPPORTED;
+	attr_entry = kmalloc(sizeof(*attr_entry), GFP_KERNEL);
+	if (!attr_entry)
+		return -ENOMEM;
+
+	attr_entry->attr = attr;
+	INIT_LIST_HEAD(&attr_entry->entry);
+
+	list_add_tail(&attr_entry->entry, &adev->attr_list);
 
 	return ret;
 }
@@ -1827,14 +1836,12 @@ static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_
 {
 	struct device_attribute *dev_attr = &attr->dev_attr;
 
-	if (attr->states == ATTR_STATE_UNSUPPORTED)
-		return;
-
 	device_remove_file(adev->dev, dev_attr);
-
-	attr->states = ATTR_STATE_UNSUPPORTED;
 }
 
+static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
+					     struct list_head *attr_list);
+
 static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 					    struct amdgpu_device_attr *attrs,
 					    uint32_t counts,
@@ -1852,20 +1859,24 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 	return 0;
 
 failed:
-	while (i--)
-		amdgpu_device_attr_remove(adev, &attrs[i]);
+	amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
 
 	return ret;
 }
 
 static void amdgpu_device_attr_remove_groups(struct amdgpu_device *adev,
-					     struct amdgpu_device_attr *attrs,
-					     uint32_t counts)
+					     struct list_head *attr_list)
 {
-	uint32_t i = 0;
+	struct amdgpu_device_attr_entry *entry, *entry_tmp;
 
-	for (i = 0; i < counts; i++)
-		amdgpu_device_attr_remove(adev, &attrs[i]);
+	if (list_empty(&adev->attr_list))
+		return ;
+
+	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
+		amdgpu_device_attr_remove(adev, entry->attr);
+		list_del(&entry->entry);
+		kfree(entry);
+	}
 }
 
 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
@@ -3276,6 +3287,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
+	INIT_LIST_HEAD(&adev->attr_list);
+
 	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
 								   DRIVER_NAME, adev,
 								   hwmon_groups);
@@ -3319,9 +3332,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
-	amdgpu_device_attr_remove_groups(adev,
-					 amdgpu_device_attrs,
-					 ARRAY_SIZE(amdgpu_device_attrs));
+	amdgpu_device_attr_remove_groups(adev, &adev->attr_list);
 }
 
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
index 48e8086baf33..d9ae2b49a402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -47,10 +47,14 @@ enum amdgpu_device_attr_states {
 struct amdgpu_device_attr {
 	struct device_attribute dev_attr;
 	enum amdgpu_device_attr_flags flags;
-	enum amdgpu_device_attr_states states;
-	int (*attr_update)(struct amdgpu_device *adev,
-			   struct amdgpu_device_attr* attr,
-			   uint32_t mask);
+	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+			   uint32_t mask, enum amdgpu_device_attr_states *states);
+
+};
+
+struct amdgpu_device_attr_entry {
+	struct list_head entry;
+	struct amdgpu_device_attr *attr;
 };
 
 #define to_amdgpu_device_attr(_dev_attr) \
@@ -59,7 +63,6 @@ struct amdgpu_device_attr {
 #define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
 	  .flags = _flags,						\
-	  .states = ATTR_STATE_SUPPORTED,					\
 	  ##__VA_ARGS__, }
 
 #define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
