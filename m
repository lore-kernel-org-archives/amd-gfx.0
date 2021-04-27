Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A031C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2291613DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 14:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2291613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDD86E97B;
	Tue, 27 Apr 2021 14:51:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608146E97A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 14:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao7SKRowuK8sS1SvKqAnvlJ7BTpeWyDTy6aqQoSa5m6YgKKVrstcwSqW4WI4Rp3t+DJ94+EZUXdHsYgk4Ao1tVY/kypWLPMSuElYeCnMmKwlZJfIi92uUpCWL2iiAc1XwoSftjLiaRE40FeFdsw4CLlFEQ5Y2RxImZSlopfH3p38dzdQppoFibA/c6wB39+uDu8UUWqwuhaw+xO1w+LfC2VSHW9K8TyIDh7JSjGzodzl3KhRZIKqVEVL9v223vFNNI+OPcqpvOQSzT1oZyHoVrsVYVSkGkFS1cvB5Ag5oVnoX0puuSJFd1ODUUUaVqJhsdODEZ1R9m/LE+QM4dIMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqsGQvcSEStlKzrc19Ri/HUB/JtEJCzSzqDu+k1fXRU=;
 b=gv5NuEV+67S4/KPEzp7pWhnzwYfWordnalgRzzcrAIUDEqznsPVVbyVqRUsD2xqd2t0AH/5tOprTx59VQg3kPNIP1aR8PDJMCa57o/XzECVIFLj45Q/vF6wodfqnQJwF4vJoz0Aisp7BDOjvh+fg8RFyiI9RsCqeiMIFme53ClXqu5JSiSjKLVj+PDGW7p0lAn/+FzQ8X0Z9Oj172mTSmmpN8HzdqHrB1N9wyqTV+f92H2OO7pF83ZFE+p5gL3woIoI445LKYaRgQCK26uSQep+SObp2qpB1dU6/OFtpwl8Sr1MgXVPRsM6up/lyC4+YL8qh9E+r+hqm6G6PEI5Twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqsGQvcSEStlKzrc19Ri/HUB/JtEJCzSzqDu+k1fXRU=;
 b=007ryTJNpjJXYjD/WD/zCVWcdXqSZ2xdzBhoZsSL0/xWjJNXOIl7cx/LaUSdTAlBqmVa0+7wVqUMbT9jHpjxlcmgdAAlgRjShchZ4LItpbhifMwvRl3bXl7K6+92TWFV1R90l5zHLBulfSyg6MNuLoo82m9BDBPdVEsI/3t/13I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Tue, 27 Apr 2021 14:51:32 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.025; Tue, 27 Apr 2021
 14:51:32 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 4/5] drm/amdgpu: address remove from fault filter
Date: Tue, 27 Apr 2021 10:51:19 -0400
Message-Id: <20210427145119.670-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423153550.25188-1-Philip.Yang@amd.com>
References: <20210423153550.25188-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::27) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 14:51:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b8fb59-cff4-48c7-1631-08d9098bf251
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011D5FAACD8456678A1FE06E6419@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbN899sj6xLgouMvbg/CNQnm6SOj8azWuiF7XQMAacyPbGmgjrglo5uGZdV0tavzGEV9QWARQMoziD268mEQzwAuDj+wON020dDtv0Yfk9ldF64YMPni+oB7byLnCBSGW2s2ZdOeT9YEIsv1TRjjIHqQ+7V9Bq6MHnu0hYgX5IMUERg67Ie/bXoPLL6TrWUxUONVD8rykumNUlPYDzSBlG1vj4d+w1TexoSTfE4WFKGJ+JPp6WJFqMZQn60k1xB83x8/0B1lj97WNhDlcvC1hvWzDWAo3AY0tRN7FcSu7mhsqVr8Z53pdRnRmQ7Hz1EQONVpmce570NRJoh5sr4Ybows3aZmx4YOZKTZ43x5gvqPyDMh3vz7OX4R0IPGCyzNgMTulKMrd6g/Bkvl0gGLP5odcuSMfkBxNqX4Sqmz9mjfyaCfYsGfTK59fHIVjQOv35EmX5nIMZLzm0SKM3odY99qSgVCjxtkMRB/gIdiaUD860TTG72V4/ZTBIS8wbAkRxS6BKZH0FQzWDzFRTghtVYRDgPYSLqNyTtviN0Hy9MXeDAxc04z4I7Kcax8Q/8m62WruEJitatvZ7kS7FpoBQJpaRVOwSsxz1Yz/QmnNu2KqErrTY3bQHiSlQN4XTtoE2cbleY9D2RtWq3DS/H3ZCB1uHL5MuXcHdmPoUZ/V8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(956004)(2616005)(2906002)(36756003)(66946007)(6916009)(66476007)(86362001)(7696005)(16526019)(6666004)(498600001)(1076003)(6486002)(38100700002)(26005)(66556008)(83380400001)(4326008)(52116002)(8676002)(186003)(8936002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?woNLNC1aKV0sR1p2MYWOQia49FVvCJP6Mdx6Uc4I31RWnjtekw6hWXuU9RMD?=
 =?us-ascii?Q?SyuQ1DnfAmpeOqfXz13fF5C8bXybZ6eVU9et6YiAg/HGureK+rrQStYjx7/5?=
 =?us-ascii?Q?6porwdbg5HqpJLaKzY+OE7PZLevxu4+dHTSB6eNoWnDRMqU6DYL5Lr8li1HM?=
 =?us-ascii?Q?0loPo9tawniIXZ1OsJ+vJtI3ZlVXdXrKMK/nIx0xzJlQ8hxX3dIIucYsDTkI?=
 =?us-ascii?Q?tV0yWi4hD8z44aUr6xTNHDaTQFdR962nWNgw7/mnsPuxz06KoYcTnb0JFP42?=
 =?us-ascii?Q?BNksdCyBpaOZ6cNncdootbqL/gHGX6tnrWhrva/WKqU6tW9ASVEVnhOsDStc?=
 =?us-ascii?Q?6ev/rW7TwPHRCLVfnDt8v8gku6JXGUbWB15bMv21C7rz6QdV+ke4IwPAvAVi?=
 =?us-ascii?Q?cS8GekXZ7dSLC+sdnkiWZrBh775t/iDVx7axitdPWggre7ZaLWKTC2WweD4f?=
 =?us-ascii?Q?SzCiVab+45NWqroSpBnw3at6yQNilIwxh1WeUXgRjsCz1fLAdSEUZCIYzwAk?=
 =?us-ascii?Q?38KhFcuWks2uZMA0LjfJ8MaFcosHFcWfp1OpHwzGIBbgbD9Rys6QuGqRZ84P?=
 =?us-ascii?Q?TkmhWg0F69wFmRaR5jVPdNpLjQAhbXIuJ4uT75YtVQIrjRvv8YcCaXRAJCgW?=
 =?us-ascii?Q?FYUj07cotKkV7jUylfWJjdOudwGsM2PPTF2zBBttXeAqE5rtGLtT9UTU80UZ?=
 =?us-ascii?Q?Tm8mYKtJRBiey4p2WUikpre6c8gDtMQAAX0WgPEOoeomexT3tTjhAriWjWt8?=
 =?us-ascii?Q?oeoN4p9kbMBf8OriiKS3lAtW8WFJZLhcoJreiNfYR32iqa/RuJlwRyV+Zsy7?=
 =?us-ascii?Q?GW6eRzo6eHdRsJ8n1k8BuhdJp8roCKNaM2qhAYapzV3ffGk6KoXe+ylvTLu9?=
 =?us-ascii?Q?hyGTqMZZbkCT93WDtcSzx5PZ2GHZrgBBcG0yTjoUK5ImxrpD35HTuHxz6bh4?=
 =?us-ascii?Q?rPADStR9M9Elx90LFpNQfyk1HbNh1cGdqPSbRVBHqholuB1MW+f8RSGaCxF+?=
 =?us-ascii?Q?uojSZBg7zG5PZxoU0YT4/wasoSN6FfuYvvFC4sik8HqybgbuVSoHxGoAbzyu?=
 =?us-ascii?Q?jhjYP0NP3k8FGyu9+ikZTKCTs7yRbiCVU4qpGz8XgJLnwpnPUINGx2R11Ll8?=
 =?us-ascii?Q?BpB0EClpgvb8bADL1xs1ExcQI6OC5a3hjIblz3jwu8qmZk35iLsbbzOJpQqL?=
 =?us-ascii?Q?diYk4guhqJ+qAXqtcAYfSIEiu5K/aWFc80/7Bqp5ghNvkjVY3HbXzEa2i+OJ?=
 =?us-ascii?Q?53Ri1yy84Ju4iJVbClQFzM1XJzxu2HhNxWvaxfi6s6ryK8M8+YfQ6/KZcQzB?=
 =?us-ascii?Q?6hIhJoTkLifk0oGm9B1Q90ap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b8fb59-cff4-48c7-1631-08d9098bf251
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:51:32.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq/C0rXSyq3r3ttNNqJs8rglHUwFAM7gmu6exORz3xbTVE6xIp0BopSJcnht6XGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
work for vg20. Change fault->timestamp to 48-bit to share same uint64_t
with 8-bit fault->next, it is enough for 48bit IH timestamp.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++--
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..a2e81e913abb 100644
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
@@ -348,8 +359,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp)
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
-
-	uint64_t stamp, key = addr << 4 | pasid;
+	uint64_t stamp, key = amdgpu_gmc_fault_key(addr, pasid);
 	struct amdgpu_gmc_fault *fault;
 	uint32_t hash;
 
@@ -365,7 +375,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	while (fault->timestamp >= stamp) {
 		uint64_t tmp;
 
-		if (fault->key == key)
+		if (atomic64_read(&fault->key) == key)
 			return true;
 
 		tmp = fault->timestamp;
@@ -378,7 +388,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 
 	/* Add the fault to the ring */
 	fault = &gmc->fault_ring[gmc->last_fault];
-	fault->key = key;
+	atomic64_set(&fault->key, key);
 	fault->timestamp = timestamp;
 
 	/* And update the hash */
@@ -387,6 +397,36 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
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
+	uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
+	struct amdgpu_gmc_fault *fault;
+	uint32_t hash;
+	uint64_t tmp;
+
+	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
+	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
+	do {
+		if (atomic64_cmpxchg(&fault->key, key, 0) == key)
+			break;
+
+		tmp = fault->timestamp;
+		fault = &gmc->fault_ring[fault->next];
+	} while (fault->timestamp < tmp);
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d11c02a3938..6aa1d52d3aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -66,9 +66,9 @@ struct firmware;
  * GMC page fault information
  */
 struct amdgpu_gmc_fault {
-	uint64_t	timestamp;
+	uint64_t	timestamp:48;
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
