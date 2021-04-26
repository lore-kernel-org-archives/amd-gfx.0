Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFFC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E7261073
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E7261073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D82F6E881;
	Mon, 26 Apr 2021 21:26:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B44F6E87F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 21:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgvuVKEsGQv5DcnV3aO/9koiEFrqqKFgTXMTKS1h9bc4XXRa4lUScGDHMicDAwGBEAaW90rCHBn7UwlPVdXx+9/JIQkUB2IKcdCVTC0QZ01t61m4BAZz/HumiWZbSKJLjhiIsjnmYNaaRSLm+I+KI3UK83pe4JDtJAnLTl4040/BfFCl6PxmUhfLyQ/bjHJbqYTaZ02yqqxUWYX/dcj9bYfia6oHsMvwO3YcWESNy0cu3vQ8eTr3c0pDfXIxgBwG0tpLnvpvf+v1GmBCn5rwgdMtYvRcbk/bOtNLu+yTAOhHw1xIpItaCJs724q3l4yJeRnkGyphiE0e8/oHh58nAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apHzvKTgFvsWc5v0fQjKFfyLdMHjglThS25uk8exhGY=;
 b=CnHsj79/2x3TEQ36Ea8Pc6JGZbqnP171seqfxhhZ30OqG+vf+boD+he+6XAQ3RadAPBEbTFX01Fz2stugBIXspmmeN6hF62h0zNA/thRR25J6d+ijsEtlucZSwYjAJf3RgmfMbBsJ0+BH0EZ5ic4aN7a//3ip0fikEPog5tYjRRGOHRBmYe6RIXcucnnsJEVP0cdG9er4yzOQ/dCs+sbSnSR4QFtITcUcuDbO9GEl40kJcCrENOtOTZleE/X/S4Unkx0d0f/ce6zKN8XJ6N9fTF0YC3CdpINSS7fF+HIw8MqeYYseIFk4zmLut6CzMz7PAN+trpOjhMMwjq9gLcSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apHzvKTgFvsWc5v0fQjKFfyLdMHjglThS25uk8exhGY=;
 b=Lop+Bb12rfjhCwm0mKrHJptU8eEZCts4HScopzWGlwp0oLiquH+MF4sL4JCUPPJKAD5uRP8VcnapysrDEROXlhTMng5v5qsFPtrb+T7/7pvLVI+8WS0WQzJRAiM7hgVWYNO14+ji65e6AICKS4R6OW5KdHfJbU/7Zlb6DXPgI78=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Mon, 26 Apr 2021 21:26:49 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 21:26:49 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 4/5] drm/amdgpu: address remove from fault filter
Date: Mon, 26 Apr 2021 17:26:30 -0400
Message-Id: <20210426212631.8130-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423153550.25188-1-Philip.Yang@amd.com>
References: <20210423153550.25188-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Mon, 26 Apr 2021 21:26:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 609e0f04-1633-48a3-8c1d-08d908fa009a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4636C72A4622C21599E54302E6429@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlKGh+80no4O/G5FuiNXKD6G7oxZUHt7mDaqBSUG2wjFv7XQKpOHWJVoKkM22QSo0NHxLd56T+mAW4waIQn0ixG8iYv1sR3flejaSDz5MmxcF4z4ox4VdCq3yNSxPhqTfy88TzhZHYYM4WzA8coAJDSb6xFo9BhpT5fntmDKJot00G8n1PwpXuNeblZUt+w8CWT+Kv+RCQ5NIuhA8nIKZXKREnUevn48B82szRvCVJhRb1sm+LEVmobQBIrJzAXrFMqJzQuDeZEFxdW+v8zTKOtzhp1iX13P4T4MxgPk5bifLqDlBdC5T2UIZeC4yFN+SVRRyOd3XImITgyPsi8GhHQ7mTUkVc+DlsUjsxXJEDgSrvTWzsFTkq/tf0gTZBpWsDXyaauH/NUGzUvC38ExwKLnsqKH8CeywGywpEJ2VYvWpxvd3kC9n2nftYxhNfjPvWrfXaUglfU8FbW0YVCFePdLJLDUdnO7Ytg/tjbXUuzVLkPLcaby0Y3ESLjDgMf7CVj591tfiN8hI5kNK+RskeMIuWAto/yjFjOwG75dYXplWrWCcSDx/6YBsI8cSNaF0og1Zc3VfColTfnHpj3MGUeNgHu3LGian6OqiSnLHGVEEl83WQvrpvWAlzujrFxOMQ6SDWC1WYFUVNFDNLfSEQI7niZMxHZuldLuwJ8OzZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(2616005)(38350700002)(186003)(16526019)(2906002)(38100700002)(6916009)(6666004)(478600001)(66946007)(86362001)(6486002)(956004)(1076003)(66556008)(8676002)(316002)(36756003)(26005)(52116002)(83380400001)(4326008)(66476007)(5660300002)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aT61zWA3y1ZO/XPFw8AP6dR8j+fRRznNBNxGmicr4Ltf3wZG2jcIQwrsZoAF?=
 =?us-ascii?Q?vciEjZr6qfN/A51l/6lwz2QF8sKdjhHJ5AYVeNmnLO7rp76jlvQ8ojuTHVwI?=
 =?us-ascii?Q?oxHEbIVqSYTHLYiTq62eKrtpksVNqQFuKj9WRXGME+tPcg3xNy4w/PaA4phT?=
 =?us-ascii?Q?q/V0nzHzyx0sqMpR6NNmFbHnT99+kSZPDODCxA3cpaXZvLCylk6U4GBRa5wp?=
 =?us-ascii?Q?j9mGYmpshbheTHKbnA/9YoAkGDhxsNazVaMq7SZza/Kb24p83MuBuyRshonD?=
 =?us-ascii?Q?KcjT8Ra8P45CoItByG40XRD3TuFTuWYgUt0aUq3+aTG5BXAebNYMooOwLdOn?=
 =?us-ascii?Q?8C/yB1lA79P74+tsNzPlzQBh1mi12RT98dPwtIwFfTkR9XyJk499qu/e8O/E?=
 =?us-ascii?Q?xiW1NQhyJ99jQdj4t/4pxxtLvnC5B4GHLbWV2ehFdZZIhcDny88FpnxYbUYL?=
 =?us-ascii?Q?fnWz7GF8AF+qi6d23EnCd1boCfT2G1bGqlXjRXsHfN8b3+kmWiGcpGOPoFaH?=
 =?us-ascii?Q?kUhOG2ha15U1OjP/eU5oT4Paj2uSSLmzyOgqXVWZG6DEaBYeg3lH879+7IIV?=
 =?us-ascii?Q?+YHTf3SotafuUwxXuzVEfPGm5oGDHLmEhmSgNFCkeih7wqSssBvLP2i16Fnh?=
 =?us-ascii?Q?OuJ8wEoQHQNTk3m/HMgrb0mLxBTTbETlhqJeV5vkMRxQl5nAGPlDiwEHTV8m?=
 =?us-ascii?Q?QmmXmf/E+yIfGiN3mRM10yY8dKNQ5tI+yfUB93Drt7W1VV5VDryL4qQtqP7U?=
 =?us-ascii?Q?XDsWJIstF4gQLbypRqLB+rtB0MooiMrfIpJ4I7KZxueAxcrC7PQOZmwuq8yA?=
 =?us-ascii?Q?1jmR8ugZjUKlRDA/2iV66CrR65ZqBwuJpe5P/egSoYG66/wQ4le6iXXl1g1Y?=
 =?us-ascii?Q?o3mro8pdA2EBKJAbgRIcV3qJfFDH0oLFGhe2Y7dROYj928gHdRh+y5ARRcJi?=
 =?us-ascii?Q?8hho5MAN7v/fZGu/2B4HAPG5eQxM8pHry/RZAgCuJM81KLHqCmQpws8bTPTz?=
 =?us-ascii?Q?rXrK6mfDSNtr7hoBVkcvjT3eZZmA137oPlw6igzrihIW/kvNL2P2+DC0zwsc?=
 =?us-ascii?Q?orKgiFvgJdBMipQu8gOIiYu8KJnXIknq+yMoi+GrJ9NfSov+VoSgHlIQCM2x?=
 =?us-ascii?Q?4dQAfXGlbE4+vdqfPMCBQaKO0u4IeA9iEUEAWdPtJ7cSyn4bGJ9dbyq2fUyQ?=
 =?us-ascii?Q?R099Z3rs3l7cwPicB/uy2O3+0L2y1tGxl4+JO/zqcuh/smpFB9q+WMUEIZAY?=
 =?us-ascii?Q?YNS4/cTP6tMsEefL69hmOw1BZyXZ+FbGKz7FpeXK8GccJkL5cU3HW8X5yxZM?=
 =?us-ascii?Q?nyA7IH63e6DHhIAHs4xYmsdh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e0f04-1633-48a3-8c1d-08d908fa009a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 21:26:49.6729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRRM3kY3gACTNZgTBA9sA6hj5E1BqCRGeORLNjXIYFB5+kxY9/iBm3oXEiVDSUwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
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

Define fault key as atomic64_t type to use atomic read/set/cmpxchg key
to protect fault ring access by interrupt handler and interrupt deferred
work for vg20. Change fault->timestamp to 56-bit to share same uint64_t
with 8-bit fault->next, it is big enough for 48bit IH timestamp.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 54 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++-
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..888b749bd75e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
 }
 
+/**
+ * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
+ *
+ * @addr: 48bit physical address
+ * @pasid: 4 bit
+ */
+static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
+{
+	return addr << 4 | pasid;
+}
+
 /**
  * amdgpu_gmc_filter_faults - filter VM faults
  *
@@ -349,13 +360,14 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
-	uint64_t stamp, key = addr << 4 | pasid;
+	uint64_t stamp, key = amdgpu_gmc_fault_key(addr, pasid);
 	struct amdgpu_gmc_fault *fault;
 	uint32_t hash;
 
 	/* If we don't have space left in the ring buffer return immediately */
 	stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
 		AMDGPU_GMC_FAULT_TIMEOUT;
+
 	if (gmc->fault_ring[gmc->last_fault].timestamp >= stamp)
 		return true;
 
@@ -365,7 +377,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	while (fault->timestamp >= stamp) {
 		uint64_t tmp;
 
-		if (fault->key == key)
+		if (atomic64_read(&fault->key) == key)
 			return true;
 
 		tmp = fault->timestamp;
@@ -378,7 +390,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 
 	/* Add the fault to the ring */
 	fault = &gmc->fault_ring[gmc->last_fault];
-	fault->key = key;
+	atomic64_set(&fault->key, key);
 	fault->timestamp = timestamp;
 
 	/* And update the hash */
@@ -387,6 +399,42 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
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
+	uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
+	struct amdgpu_gmc_fault *fault;
+	uint32_t hash;
+
+	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
+	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
+	while (true) {
+		uint64_t tmp;
+
+		if (atomic64_cmpxchg(&fault->key, key, 0) == key)
+			break;
+
+		tmp = fault->timestamp;
+		fault = &gmc->fault_ring[fault->next];
+
+		/* Check if the entry was reused */
+		if (fault->timestamp >= tmp)
+			break;
+	}
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d11c02a3938..95e18ef83aec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -66,9 +66,9 @@ struct firmware;
  * GMC page fault information
  */
 struct amdgpu_gmc_fault {
-	uint64_t	timestamp;
+	uint64_t	timestamp:56;
 	uint64_t	next:AMDGPU_GMC_FAULT_RING_ORDER;
-	uint64_t	key:52;
+	atomic64_t	key;
 };
 
 /*
@@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
