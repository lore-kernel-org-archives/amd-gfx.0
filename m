Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D8EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B80B613E6
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B80B613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010AE6EB20;
	Fri, 23 Apr 2021 02:04:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615436EB20
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5sdac5W2Lz6sOCkOuxAX/UCdc24JoTIUCYXOEOUHrYxMKef6OXOGt78LU9E+xQ7zbx1JqJyNLpo/9ODddf50C/5NDGci5dSYMTsFXUAovjHiMsPA+8Tq0GWncs4kTpdFqAw3+Ie4dIz9Cxr9/FVdHcNJxqQzXhTjd68mSaptyMbT6EdNcMaK3KxE/cp36QL/O4AIcphKl5suI1IvWc0FmjgrpDMe91G+tCMEmeTpo5eRkw8qS6uPkRqY7zAdyL2IixwOa5Yhgn8Y8ZrGa997z7EZKlY4hPQo3rARlMug4aV2Xj6vLcwi5bilNLkLb7syhmk+MErSLXkBKKTuMJMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX+Y6NSS9mPYMagndx3YQUeJk1/yuJJJ8wf+bmqvmC8=;
 b=HSzTK4HNSjoRz/PDIBMLFeCH6YSA3tiVNIF3N69l3JxmLxaxh/WeBuAsaBjIn11qaFntCVwgQ/hzevUpo5Jdne+Mu/p78rjxWft0+qc95+V31L64A7TNVOqFbkoxkzshHD1kpte+1lVcv85BGh7ef6LdCFuL3OW5Wr8EYPod6cfceTJlqCPeV09TCECgCHXlLyZ11nIL67pJ/ReQ5tqRDfh3aYnA3lnAeY/hVB1syezTwHNqWj5oEuFNWm721/CiRgpa25QEVsDZSAqmtHYVgxSrYk5E4sh9IxZx9e3P2OSuoPc6YvO9FBerCMyKDuafuQYvuveCxYWV+hTBUT1Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX+Y6NSS9mPYMagndx3YQUeJk1/yuJJJ8wf+bmqvmC8=;
 b=XRZkjnB0CpqSATG0VD8eRZu/RTBBCqyXqSpOQUENug+KnaC1VrY15LrN5s9s4DS5GGPUX23+SnwsFz2+3j1frm+3ZURA5f4mzFOm0PzcWl8zMrYpqaqGoEo32HygwcPai7M48bD8ngBZldnPkRlh6aGiCxrqmaxBM25czKDONLw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Fri, 23 Apr 2021 02:04:10 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Fri, 23 Apr 2021
 02:04:10 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: address remove from fault filter
Date: Thu, 22 Apr 2021 22:03:56 -0400
Message-Id: <20210423020357.31102-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfbcc441-d864-4a09-cd34-08d905fc155c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40103F6C6045230631CB8E3CE6459@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmPFhjXIgYQlpQark+XJvrXAlCP3fHcvYEZg/pHKuT47m87kYpLS4vJa8/4UlxxIKI1Uj4KYea65+6dszfNep/bNYytZ3TmTNaDjNDb7kg1iy1o/olGx9UQF5XO0fW24lFW+BEqAcb9z4hBL/Tsa8R3ZwWvyxccQf20hDFLVlonm9GxpbIXQaGFCdiHwJc1hxuyXD3EEcRr+GZKIN5ucEpV7bGd+tm0OYVcVfJ6JnNX/Na7yFralxyvNDQLut16FqhPcVJX5CzFBfSJHx9NZ9cuUuCM9ts+DyyiNWc/ZPAulk0v0rPuXbkIxL2McP3EclqpC0YmxlYDn9NTG48TT+D44ZyWtFmunf+SLMNcrkwkNI+P4dH0kXkxNmDjYp5xPMDRAVa/y6eNabETuehK1uFxpiSS/xACwQk6+VHa21KNXCEL+LA6wWEawnI3ZVMchlI8quogVYQOk2Y7sB83tkwhLG1mOk+wGTAq9MGS8DpUoT1sWcNB8cx7ll+z02e93hbuwZWU4z+xUxVi0Ayzgg6S0HYQ+xnI8fDppNmEGS7jXITWs0EdpUbiiNT2AY/FUN04es/5XWX9YlTzmTgfR0x4ah7KabGwiU8hXrfTiQHZSKtB5ZYs/K2nq7Y9DZcyuf2zy4hWK2g5flXXX5nYwx/Qy8dXd5TqmCqstIzvIa4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(5660300002)(1076003)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(6666004)(26005)(186003)(16526019)(2616005)(956004)(83380400001)(6916009)(2906002)(8936002)(8676002)(4326008)(478600001)(86362001)(52116002)(7696005)(6486002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aQgWFTPThseQIH4J6PT7BZO7+Fv1vaa5WwzH4dSIbV8GOAtq8WCUUOMLN5OB?=
 =?us-ascii?Q?wFY+eMQ3hzhE7+yRhCJ+aIbSYpgBZ4wWkOLiNB4AfdRokYyjzKWD5ab3eukj?=
 =?us-ascii?Q?JuwPVGAHJ32lgQ98yVU4pqD8ljoikcffC+588ghlhFDDMmYVnrWTzaqrp+eo?=
 =?us-ascii?Q?b70hQ18Xu2m2Y7nsHCOknUWlPmvHDRwUW3V2JSPJUv5ybCcVooFj+bGS6kgo?=
 =?us-ascii?Q?HA18Ov7Slr7Y4WrS4hNG/r1EI1xPPehD8CGu4kYrDCUTwwX3pMPVy9DD2zz6?=
 =?us-ascii?Q?apBIrzXzJCAm4yQDDxGcJ+1qMqFg8X5zCJfNxdFZ0xl15OAT5Cah+X+vWL+Y?=
 =?us-ascii?Q?mEe29jaAmjlQWV9ajmUSMGUQ02D29kHD16ZY1NaCeci8epetdtBkYP5FngGl?=
 =?us-ascii?Q?OtLflLy9lUoC+vS4NRc6X0q5Vaf4nivbo0rOuFkU6K+FLmwTMMVIz/bP/fex?=
 =?us-ascii?Q?t2XwpKWLUao2d5OhXBgXQRNauFuJarnU/Jrt2TXmlRfmxOeY3bS0F6TFQqE5?=
 =?us-ascii?Q?BJITMFR686hzVxwmImuofIKdqTkCRTT+ggjEPpPAkvpMmCCBKKYx2MqA2VXo?=
 =?us-ascii?Q?aKr/M/NknAcei4zXP2x0T4+yjjFwHqgkt1/cDGCJ7wTLdHKrHER+876+aTZt?=
 =?us-ascii?Q?PYV1G0bY8RHSO6Pte4TTAuP+bpeFaJNnmgr57cuJNEBBZxs8hPziHfh4ZOj+?=
 =?us-ascii?Q?F+5HMuGaCIdmMGRVg6BHLrv7DorH1LLMXChJWxjGpRpDdaU/Td03XchrSvHp?=
 =?us-ascii?Q?ZfUOEjTdsC05cMNEm6GNQ0dtJhYaIRO16/Q5sDdd11crfhntdvWnFQjkkjVH?=
 =?us-ascii?Q?LEFKaC1OrOLlpiKOzCquOjo4w8By/L22Kjk3DkVouELzXgvU9yqQiJ6mxbpA?=
 =?us-ascii?Q?up804aI3u82jlHIQz/36hPshZMFxSYwsDhuIYyLNupMtMEgWQ5ANglkbn8dU?=
 =?us-ascii?Q?9zqlCZUwEzL9iLkqp64CNbXOeBIoz13j9YoP4QzUzxRjF4iPl14sVDbPHIWD?=
 =?us-ascii?Q?ua63MNeZvEsaZ4iciOAcbUn+9TTQ+fiuRgVgEa4WQydl91Wnsf1ia36hCBab?=
 =?us-ascii?Q?I7yqwFD3kCRQwNg9NphLqIjlwb2/jy42D/9k/PfVT0GI4ngQH4PH6YVNsg+Z?=
 =?us-ascii?Q?AsENvvizV4r+KCRtiqJb8t/cs3VrdK+TtoFIl+hCxnCcPr0jiIP6YG2qpN5T?=
 =?us-ascii?Q?ts02neJofPHApMIwLG+GtcS2CIBvC/BzDY+CAOvz6mKnyZAJBWmlsd7uDwQq?=
 =?us-ascii?Q?91ovhNK1Y5760sYQTIiIzi63liqKCvND0BmOJhjU5+pocPCh8PR+UG/0nTN6?=
 =?us-ascii?Q?mioYIClaPaLgyN2nK01mVhwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbcc441-d864-4a09-cd34-08d905fc155c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:04:10.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0Ylj3ez7hs4vrNHp2RX943KEoUjavqDtUktNRtGV8Yx0VS6pCs1+RYnYoqNHm06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
fault ring entry of the fault address timestamp to 0, then future vm
fault on the address will be processed to recover.

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
index c39ed9eb0987..801ea0623453 100644
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
+			fault->timestamp = 0;
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
