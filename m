Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66AAC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD1B61396
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 15:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1B61396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E276E12B;
	Fri, 23 Apr 2021 15:36:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750042.outbound.protection.outlook.com [40.107.75.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC356E12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 15:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUppXv6cS9jA/7YaW0n8sOLfaxgiQQs/83QAi2q5IrHmraG0kfVM6qf9L8Dz6+WOsUkOo7ogLKmapHlSeewhGqBX8ZgAj7WFA9TY5urnkv75Nf3i1fN4B5H36eLqaG4l+ty10HW4u/smO1aWGAwEk8PDoEsD4ox7mt1MZVrVEHEbb9rU1BLaVcCzeYZr+0RA9gF1PJY4Wq7/eBSWnvUcXhwSWiMsHbwGwUhT31AQ0qQbWfFPRBZ4S8w16T4mG2HdyNXbUCHgVIHs3wuv1xrjz0KL49fIWFA5f8Ru4n8d9UlCUHjMYMo5YlSYSUmpUn9fnQHkBV1vPKtyAyhzcXJz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RgwxYEGA5pOYEi5zjJI61yCZxWtEHIEWpSH9aauao=;
 b=L2zBlAI/3XbpwhaIfHLqZzpGF//fKhUzH28u0JwyPK/qcslTCZZNsoy2K3AI3nMOBjNIjRK1YNNWVtuAsyYdlpVuv0TATJ40bci928m9KzhkLNAkAQI0P8s4ewrKyqmmpoLiKk1O58rW520welDtaTGStH0/cw7FykFyZinXR2xqGwURwtDg/hzDw9viFjYSp+74+PY2j6otEw8eR3DP5bkEygyh1g6fShge4qRkWtJFK8LGjalDgYXrUDNLgCBhyBtR4dXJ8cKah04vxNaPBIscaeMv4MfsMOgH0lx96hV5tC799hKfWzBZKz6o7ScWJnPjXkBEBsk1Y3eqhhGrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5RgwxYEGA5pOYEi5zjJI61yCZxWtEHIEWpSH9aauao=;
 b=tlLrYo3IpRH1RlwRAd/BPJs3pHVzwzr3h3FtV8lsFseeS3RVJ4Xncx/1pcRkQ5dybWVel1kk/H57pboZoaXrXuRhjcqDLG6aMcLtAN5bcvonIpwBkgbWn/0N1URbaO0hPYN0zigAeoNKH8gHLwWrxBSAsbUY7N8oD+18SUDXsjs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Fri, 23 Apr 2021 15:36:03 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 15:36:03 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 4/5] drm/amdgpu: address remove from fault filter
Date: Fri, 23 Apr 2021 11:35:49 -0400
Message-Id: <20210423153550.25188-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 15:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907b7369-7536-4e70-4ba0-08d9066d80c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB48108C64D15B3658A8FABB7EE6459@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCC4KVg0AMKgcXnvVMNx8JztOqMdfLIDwz4S4z3WXvE4WcF1sWYbB6oxKCTcVA2tJ+bDwgkeLEyXkZqrk+JIOKmuNZK/Ul3tS0obxFSvXwcjRPntLFoE1Q/m/YNuk5gOFoOjTYvzsCJyn73pDu1t6j7MiLVQmfoCS7gyMiMGg82aXU4vRlJR4fmpj/HGedTHFsdqg1eJIgOhpbVd3DDrLfq4Mr28O+NmJftaCaJvpJnlPlHMsL1elSl3Ru67r4C1t1ix/5v1dXv2dKxBtFv8xXK5CucQc4nUErLSWtjsbb2HxPYvnMOcwQuO4ZGWARDuRrweoReGgolYPODZ+oJUUJKYlIX27Arq9qirSl5q+DwiTwghMfL2646limjBLy6y//PMW1KktWnJonGLzRukM9Vz6ZAFLcO/xjsZFo/SH8zet+94iSyCW0vJJhkOtfDdL6JGpjw1yiRtXfbsW6akuQoR+zCemquVOP5IHDLKehCYCzVj2jobkgLAcCLca7MR+DvEnK3oc2c1gMrM/pugAk0Ys261MzBU7r2aFBXicnezlBNv5tu/nEOhliyA9xc5Likx1jOHwsQBqTBf6Lmc89INIy+BWZr11Nig3K2T9bvMDd0mJV0gKpHo5/afN+mxnF6NE2aOoHhLsfL95kkFFH05UU8OojG5A5Nl7gDU/Sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39850400004)(136003)(6916009)(66946007)(52116002)(36756003)(2906002)(316002)(66556008)(66476007)(6666004)(8676002)(4326008)(8936002)(7696005)(38100700002)(478600001)(2616005)(86362001)(186003)(83380400001)(38350700002)(26005)(6486002)(5660300002)(956004)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rfrQpNPC5UoSVmV/kwZ3PEbVikmRNRTN+sBSj1A10JYP7aLxBtLE2OXWJG//?=
 =?us-ascii?Q?8wxD0KJZ3a+hJHd007XG5fzEf+TTOyN3nfWJKS/2Pqd1bxAC2Hj0QII/V0B9?=
 =?us-ascii?Q?7VZlBuLBi3BaCYIN3AEKOv0cEw5Didxe3qeklJp2XpFAxQSlrlAmPrXx/6FH?=
 =?us-ascii?Q?BXEfQrD0DVTGj8pmJ/+kC+Q95TsdUUJ3rUsfFI8EaczozvFx4dnNlZTiPM5G?=
 =?us-ascii?Q?/WTKcUrv1lCAZGFTG2//W9W4/kodrmTyyhxBny/HzAYOhQY5F+zDuSx6N+Vd?=
 =?us-ascii?Q?Jn6eO6gWoMsh36Q+7dk+CC+qc8gCZW28VXLN86jiCPuGVPmXinKwupJg/uiu?=
 =?us-ascii?Q?ZVvrSNojm/rTwc2WfoXYhkL5RbMiaXL+HZmllSVMRStA8CSYAmL+Xkhi8K3v?=
 =?us-ascii?Q?zwh9cM2pMoj4jedNz07bjFhcir1gkVpWyNq3QcOmI1wAU9k+POwcBiFEFYak?=
 =?us-ascii?Q?4UxeVhHilSD5wUQ6NR4jutGRPGFdzsyKekT2KJynVlgL4Iyj8FUtEKxrCdl4?=
 =?us-ascii?Q?ATcDTPsw50C4xjdjdHAjOuI44jdqhPPsMHMJFE/xYBa8cnOGP+c6O8jubb18?=
 =?us-ascii?Q?aD2cH+uaa/ukpV+pamXSNfIXiSjf7gLTHhYDTHd6t0Cg7Biy3rzKTeEyRbmm?=
 =?us-ascii?Q?/TeWkw7uWFdwWxLks4cqBUmXPc1NZJ/9c6HaiJ7nz4ugyBcYkqgPYVysCS1u?=
 =?us-ascii?Q?zUSzax98gF8i1pF5QQxATb0A98YmWYjtL9DfHSjArGWpjkMom5iTy5Cyqefo?=
 =?us-ascii?Q?sX8CecCbEW9aChmgGY+0RSjFVF4/xgO7z+9UJawdvQw7TzPYz0P+ujHseJQE?=
 =?us-ascii?Q?ISb43e7wzh+r4z3hj36dq4k2QV8C4HXtpC1xsgDz/JbE5Aocm0EnXAL+eUhm?=
 =?us-ascii?Q?QuOvvTPePP8+ohI1F/r/D1NhS1n4v6K7MeegbsIqVRDqMad6ZyIQsAxOa5jV?=
 =?us-ascii?Q?HlHcVPdOqWYO2Ca6q84rHIBgzS4Rp+1XLEpjFK/AQz9PCoJan677lsX0QAAj?=
 =?us-ascii?Q?Z2YHsY91de7IQvIlU3gkimseJ2h2C0YqtdMH9+YglWZ883bQr3oH9TIfFc+o?=
 =?us-ascii?Q?QQLoBbehwT8uKOV9lltZNuWbgy2C0UJHjJmojgNTbVTrw4bNgv9uM+CqoV6Q?=
 =?us-ascii?Q?8O7X8BZeew+sDUE/E9zgYOw7PN/UuPFBGvLPbQ/Rk0vZyiwyvDTJdJ1fG3Tj?=
 =?us-ascii?Q?QwdiXDlDwobWA6hBjvGqlMi4Z+3xXGkikkLYPMSMZIAWlatgJZJV4cy46ZAy?=
 =?us-ascii?Q?ES7nKN5h6R0ie0S/Xpl/DCgGFUO7Fio8YS2yUZ2H+h9HGfoNoy1qfh5CQmX+?=
 =?us-ascii?Q?228thO+7BUQkN/FZ47GQFtGK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b7369-7536-4e70-4ba0-08d9066d80c0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 15:36:03.2282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZrwD5RekOVUh/2fGGrg5YnqisMz2AdqOxZZn21AdpPCLrzi0Yrt2SvsOUpvyPCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to remove address from fault filter ring by resetting
fault ring entry key, then future vm fault on the address will be
processed to recover.

Use spinlock to protect fault hash ring access by interrupt handler and
interrupt scheduled deferred work for vg20.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 66 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  1 +
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..91106b59389f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
 }
 
+/**
+ * fault_key - get 52bit hask key from vm fault address and pasid
+ *
+ * @addr: 48bit physical address
+ * @pasid: 4 bit
+ */
+static inline uint64_t fault_key(uint64_t addr, uint16_t pasid)
+{
+	return addr << 4 | pasid;
+}
+
 /**
  * amdgpu_gmc_filter_faults - filter VM faults
  *
@@ -349,15 +360,20 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
-	uint64_t stamp, key = addr << 4 | pasid;
+	uint64_t stamp, key = fault_key(addr, pasid);
 	struct amdgpu_gmc_fault *fault;
+	unsigned long flags;
 	uint32_t hash;
 
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
-	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp)
+
+	spin_lock_irqsave(&gmc->fault_lock, flags);
+	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp) {
+		spin_unlock_irqrestore(&gmc->fault_lock, flags);
 		return true;
+	}
 
 	/* Try to find the fault in the hash */
 	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
@@ -365,8 +381,10 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	while (fault->timestamp >= stamp) {
 		uint64_t tmp;
 
-		if (fault->key == key)
+		if (fault->key == key) {
+			spin_unlock_irqrestore(&gmc->fault_lock, flags);
 			return true;
+		}
 
 		tmp = fault->timestamp;
 		fault = &gmc->fault_ring[fault->next];
@@ -384,9 +402,51 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	/* And update the hash */
 	fault->next = gmc->fault_hash[hash].idx;
 	gmc->fault_hash[hash].idx = gmc->last_fault++;
+	spin_unlock_irqrestore(&gmc->fault_lock, flags);
 	return false;
 }
 
+/**
+ * amdgpu_gmc_filter_faults_remove - remove address from VM faults filter
+ *
+ * @adev: amdgpu device structure
+ * @addr: address of the VM fault
+ * @pasid: PASID of the process causing the fault
+ *
+ * Remove the address from fault filter, then future vm fault on this address
+ * will pass to retry fault handler to recover.
+ */
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid)
+{
+	struct amdgpu_gmc *gmc = &adev->gmc;
+
+	uint64_t key = fault_key(addr, pasid);
+	struct amdgpu_gmc_fault *fault;
+	unsigned long flags;
+	uint32_t hash;
+
+	spin_lock_irqsave(&gmc->fault_lock, flags);
+	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
+	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
+	while (true) {
+		uint64_t tmp;
+
+		if (fault->key == key) {
+			fault->key = fault_key(0, 0);
+			break;
+		}
+
+		tmp = fault->timestamp;
+		fault = &gmc->fault_ring[fault->next];
+
+		/* Check if the entry was reused */
+		if (fault->timestamp >= tmp)
+			break;
+	}
+	spin_unlock_irqrestore(&gmc->fault_lock, flags);
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d11c02a3938..0aae3bd01bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -246,6 +246,7 @@ struct amdgpu_gmc {
 		uint64_t	idx:AMDGPU_GMC_FAULT_RING_ORDER;
 	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
 	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
+	spinlock_t		fault_lock;
 
 	bool tmz_enabled;
 
@@ -318,6 +319,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 498b28a35f5b..7416ad874652 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -839,6 +839,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	adev->mmhub.funcs->init(adev);
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
+	spin_lock_init(&adev->gmc.fault_lock);
 
 	if ((adev->flags & AMD_IS_APU) && amdgpu_emu_mode == 1) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4da8b3d28af2..3290b259a372 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1444,6 +1444,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	adev->mmhub.funcs->init(adev);
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
+	spin_lock_init(&adev->gmc.fault_lock);
 
 	r = amdgpu_atomfirmware_get_vram_info(adev,
 		&vram_width, &vram_type, &vram_vendor);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
