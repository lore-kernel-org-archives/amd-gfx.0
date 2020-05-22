Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0920C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496A3206F6
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ErHojZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496A3206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB226E0CD;
	Fri, 22 May 2020 15:41:31 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C996E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 15:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cewwZgdz1sdTC2boVhDzOtcgZTI+AriZpfhg1eZGGQzYPCKOkb2APCbfuU/dd/G8pM+eQvYJQ8SxL2Mczj/KKigjDEqckPrLmlf0zQXf5BoiaPpFIxopPsrCGzvTBYu63EpWwgLxq+hGyIXmQgurr5mRTOoSTmgOhxY/cRykserxe2f/y6Yq51w5PccvXosxELRRtd1rG84F3FLYpKGLzx7NZtb5vQyvhxDWSpiLtQk3yl8r+VxPZs34zi+qI1YE3mBopE4pW+n5ukWE/jblOtPVklqP/i0G3uO+L5YgQcT5RHeIBKlicm3sfdGauhz2AdJ350LMDc8ANEzqFZaA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXltyKqqCMp+SzvGa2gapbFXPhR1En1rinQuQ+XVkqw=;
 b=ZLuqjJXFdqfCN39ErVW6NtGq4IgFT7ehwhmcA30OFvjqncNek0nu0L1vlPszt0nGOM95UAlMCz/e7c8E2zD+tnGyaz/mQ4Nm9G4ULowADzLf6OL7Szucwp9GrcxE8sG6PzHE9v4SPJnQFsTfOWC4Y+OuGZrQQjLPJ2CKDvcxctNiiNWWlCaMY53gLzgtd604GQbc5W8HLr8PXKehOR/Im+06bQR+MojNVYTskiLuPQgTTS4EHW+Uy+LpWTRPn4NS3ywrcJp+ghyWctUpwYPXNK2Djezq1+5p/vnt29sXo4KiCtIRIqpMF7kg2PFarmi5Gx9rIgnfiMwz+WznCl4wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXltyKqqCMp+SzvGa2gapbFXPhR1En1rinQuQ+XVkqw=;
 b=1ErHojZUpg+9AdC5ONhAmgXHAQrTAl4+WKxuHm45bqHe7UcAHaVG5Kpp7AVvUIMgIpl9bOAoM0q/c02pVJnv7LDQ+HD8U+mPz3T0RpFtwyrvNBa0baJJQo/1axkkrBWK27PNa0qLjlqrG5L+b8s7Kafo0reyeIAqhp/IpUyCmKE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 15:41:24 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 15:41:23 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix device attribute node create failed with
 multi gpu
Date: Fri, 22 May 2020 23:42:09 +0800
Message-Id: <20200522154209.4866-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:202::23) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK2PR0302CA0013.apcprd03.prod.outlook.com (2603:1096:202::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.8 via Frontend Transport; Fri, 22 May 2020 15:41:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60fc5e33-3b0b-4e5d-852d-08d7fe6694ce
X-MS-TrafficTypeDiagnostic: BY5PR12MB4020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB402073F661FC90ED2497105EA2B40@BY5PR12MB4020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBXwt9+IeeU1c1ZFAKa5nA9WUcrWvArBvOPMGGjKHVrRWGAgBBEc0akLLIlfFowezrT2AO/AyOqKoqFS2O8DIK42Rvub09qDMeF+42BqSEbLtOcYwQY7LOEOY/ywBT/5tG2bDtK0hE4CaY5PUQKvE8LDf1P1qezn6FwEC1RMMSKsZDQe55r6rzE2/tNM85On03+XrkB7racoWWVehXuJUsTi2pZ3ga27K2F7ylnIkq7cB3XRPIETC99k2gWB2eHeDqtSffEbF5vn7wLqd1u/cwB2J+aVH9t4f6vlI3TB15e9gLuj9nWGI32ZjUMsKKUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(26005)(52116002)(86362001)(66946007)(36756003)(1076003)(478600001)(7696005)(2906002)(8676002)(4326008)(66476007)(66556008)(16526019)(8936002)(6666004)(6916009)(186003)(2616005)(956004)(316002)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oNC4LSOlJApN/b8lKDuI5kzrb8C6THJK+gjPBYAAJXYXAwU5++qAqk+y6IrrwYaMtupl0GmSDvFDWunOVai/aRNps/sxUHLWcUpL+76l3JmBivm9YoVd+gK3blFOGfIPUZT5foPbwx74Fzq592z1OxfryV1Q/Ftv5Az3lcFOM/vUL+CDdOeTH4LNja/RmbQ1pwv/nMxtTXSMJOvnqXAkw8N3HtCSB7OWSvV6brZ92QLiSI8JQ6vV7wyeFwyKd27bhsxPut6iCuEIOHg2r9q1Y+MXYYt/N60UcgOvfK1t3dseBA4tN3eR0apnPmAI4Yt9xWe7FVwFT+IVl8/hu0PBt0MyDFPXKViqnP/J+my/sbCsAfZOzkBwlr4b7Ed8Rla7+UDzBX5Ap4zsiuEWyiD+bPUL3ze818xj48fBiUofmXz6rr47hdAjcKzsVqu0nRppTpTStWvri6e9dw7QKm64eUw38JlQCr+m+cedX6aAJNUOW9i9875xJ+s9qPyGmnz+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fc5e33-3b0b-4e5d-852d-08d7fe6694ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 15:41:23.5106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKi1ghQIeaKtex0RyIYlNslHTHV9ndbjl2VGJriO57m3rYsKRgv1lfyx2fcEeKN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
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
3. drop member "states" from amdgpu_device_attr.

v2:
1. move "attr_list" into amdgpu_pm and rename to "pm_attr_list".
2. refine create & remove device node functions parameter.

fix:
drm/amdgpu: optimize amdgpu device attribute code

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 85 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h  | 13 ++--
 3 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 956f6c710670..6a8aae70a0e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -450,6 +450,7 @@ struct amdgpu_pm {
 
 	/* Used for I2C access to various EEPROMs on relevant ASICs */
 	struct i2c_adapter smu_i2c;
+	struct list_head	pm_attr_list;
 };
 
 #define R600_SSTU_DFLT                               0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 55815b899942..dd5be3bb4bb1 100644
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
@@ -1789,27 +1789,29 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 
 static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     struct amdgpu_device_attr *attr,
-				     uint32_t mask)
+				     uint32_t mask, struct list_head *attr_list)
 {
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
+	list_add_tail(&attr_entry->entry, attr_list);
 
 	return ret;
 }
@@ -1827,24 +1836,23 @@ static void amdgpu_device_attr_remove(struct amdgpu_device *adev, struct amdgpu_
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
-					    uint32_t mask)
+					    uint32_t mask,
+					    struct list_head *attr_list)
 {
 	int ret = 0;
 	uint32_t i = 0;
 
 	for (i = 0; i < counts; i++) {
-		ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
+		ret = amdgpu_device_attr_create(adev, &attrs[i], mask, attr_list);
 		if (ret)
 			goto failed;
 	}
@@ -1852,20 +1860,24 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 	return 0;
 
 failed:
-	while (i--)
-		amdgpu_device_attr_remove(adev, &attrs[i]);
+	amdgpu_device_attr_remove_groups(adev, attr_list);
 
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
+	if (list_empty(attr_list))
+		return ;
+
+	list_for_each_entry_safe(entry, entry_tmp, attr_list, entry) {
+		amdgpu_device_attr_remove(adev, entry->attr);
+		list_del(&entry->entry);
+		kfree(entry);
+	}
 }
 
 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
@@ -3276,6 +3288,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
+	INIT_LIST_HEAD(&adev->pm.pm_attr_list);
+
 	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
 								   DRIVER_NAME, adev,
 								   hwmon_groups);
@@ -3302,7 +3316,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	ret = amdgpu_device_attr_create_groups(adev,
 					       amdgpu_device_attrs,
 					       ARRAY_SIZE(amdgpu_device_attrs),
-					       mask);
+					       mask,
+					       &adev->pm.pm_attr_list);
 	if (ret)
 		return ret;
 
@@ -3319,9 +3334,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
-	amdgpu_device_attr_remove_groups(adev,
-					 amdgpu_device_attrs,
-					 ARRAY_SIZE(amdgpu_device_attrs));
+	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
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
