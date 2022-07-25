Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A43C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 12:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903DBA6A11;
	Mon, 25 Jul 2022 12:24:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EA8A6A11
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh+dLJ/4tYJ4aDk3qEq9zVdyUtn8L3EHjZacA1ARRocPeQichPV6g5aP84wClWg4VjgDln5iAdnp/T9FABWIv9XqhvhUwML7nn6H07FBr/gv81AK4Fzxhe72DArALVSy9qu3LUgV20ILAlTbx46fUGOgmmd3YCiPH2tykiezHxtfVW5lrTLleSbB1wjAG8GD+7ZCiqPayHb857dQvvcKBePX9JPafiT5CoRGhco+YAWXVWDS4vrIaufUEFmindduVPOKmbITkjLoGRGBOHORuITqoW5/KrZpChsue1uEFdlH3cWaJHly8hqQW6n2C1TEzfOW4AOAZ6Z4HctnsLHYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXaM9rut07aCXxuOI7aETLmPWMqycwBObjwZloVR7Co=;
 b=gp/TaCKpvNEnxIGfW8xd18Ile4D0mhXVOMOSb03SdrUBFubz28yo4fY2HVPbN8PcxgUl04JmuW5pk4tRdUgQ5hQT7AXJoO3GvjbwBKfE8hoey/F06NCIqF3Z4E+xOVmyE4fcfzuO4bpJhglnJd6JlLuob8vp59j3JYegyb+rmVK3lyhMLpMgGR2JTWLIkv+Qp11ctDotxlB1/VasvDDMfVpa59oaE4fSYu9EdlpchHwQGEUIqjCCz1tEX95u2Tf6dJgWtnrXwmkFDkCNAisb9bhqcvUraUJcP8l6CacYBeOqyr5M5B9Rvo9GWxiU9rRZLwTJI5o8Xdn45mHvu/eU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXaM9rut07aCXxuOI7aETLmPWMqycwBObjwZloVR7Co=;
 b=tuehPbBygj0zofu80AqoSdXb1k9kFz1C3j3oj2S4GU+qctO6DSO++VohyoNknlg9ZHZusAL260ewoMbl1fQSiuIn+pkOtsork/QU1aNRXgV2kBtzdEgdrMTtGx59Q4bWrsTrG+NNVwyirgkyDEg+RVBv/q7U7PEnDtwzW+yswz4=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by MN2PR12MB3920.namprd12.prod.outlook.com (2603:10b6:208:168::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 12:24:12 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::1c) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Mon, 25 Jul 2022 12:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 12:24:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 07:24:09 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: Set svm range max pages
Date: Mon, 25 Jul 2022 08:23:16 -0400
Message-ID: <20220725122317.24606-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725122317.24606-1-Philip.Yang@amd.com>
References: <20220725122317.24606-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c009fd56-52ba-4d16-d6bd-08da6e389464
X-MS-TrafficTypeDiagnostic: MN2PR12MB3920:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm6/K1m8J2gOWJtY5TTbjBuV2D3+zAtODk+b38rX6cZVwMwIFFSuGaovSSOPaZKwIBLZSraRbnH9+uuU6meIBTKjd7zbKEl1CAY76RG+6juBKHx139IVQ22Vq53FMO7JRaLfR9/4hLpUUbldxcTORsPWgkLL38+2Zm9T1GYk/dbtzEuIpAXblj1zcUWUSIffJvnBLdW4uDIQ6Hx7f2xU/li1qYayH2YKt6XgwjUL6xzQ8PRsgfszAtxVHDLzsURd0EfodvH9fZMWVngRmVhIIu/iU8wL09Rcl2EkZ1cqmA88M46e1Dz8iriAetGJ8dp9KbuBL9u/Hs0YmVQzjAwJzYvIFcQuxI7HcxJOkbO4Zk5W43KweetaKdIxz3yCCxknPid1uLFp8KgdoLLPNMMJypAyxUfk+h2Mud25utCYhn5xZiOsNE3PcWSxRv1mlazZtVPeDfygU5Em19PN/76bmiYfQOkWzaAxuC98L56NNdNQ21q8ZHIiHvAJMYxAWileYrH862bXnIcrlF+qSOKPp5ns6kGRqi01HWZu4WnhybzcDZGPkzVxWMNvHf0MsvWj1xTTWIbrpGbkdoOxd+lUqNUL3JS27y5yvW1fhkQlJCYmhtLCf5K0d8kIVG+DTE5YC89L3jakVZMnpcPMmeL0wYYERGFK+KCZPRizVn/Hwv80c+1vMFDWwAZ57b8YODsJ+Tzi04UiGenEvpvDpHS9PmnorFzdwTNzsAt2TLq4LopKLH8t+vejdfXfBIwymVDrxqs1uxGVjzN9Wr14bnxHaQu+ZAO1+Tk34CB8PuJw6irvXjSpHx/UHI50Zn4ChgBsVJ0DNRfyW48JixlbjFD6/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(54906003)(6916009)(40480700001)(40460700003)(41300700001)(316002)(26005)(7696005)(478600001)(2906002)(6666004)(82310400005)(70586007)(81166007)(5660300002)(8676002)(4326008)(8936002)(36756003)(36860700001)(82740400003)(356005)(83380400001)(70206006)(336012)(426003)(47076005)(2616005)(1076003)(16526019)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 12:24:11.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c009fd56-52ba-4d16-d6bd-08da6e389464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3920
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will be used to split giant svm range into smaller ranges, to
support VRAM overcommitment by giant range and improve GPU retry fault
recover on giant range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 9667015a6cbc..b1f87aa6138b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
+	svm_range_set_max_pages(adev);
+
 	pr_info("HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b592aee6d9d6..cf9565ddddf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -46,6 +46,11 @@
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
 
+/* Giant svm range split into smaller ranges based on this, it is decided using
+ * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB and align to 2MB.
+ */
+uint64_t max_svm_range_pages;
+
 struct criu_svm_metadata {
 	struct list_head list;
 	struct kfd_criu_svm_range_priv_data data;
@@ -1869,6 +1874,16 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 
 	return new;
 }
+__init void svm_range_set_max_pages(struct amdgpu_device *adev)
+{
+	uint64_t pages;
+
+	/* 1/32 VRAM size in pages */
+	pages = adev->gmc.real_vram_size >> 17;
+	pages = clamp(pages, 1ULL << 9, 1ULL << 18);
+	max_svm_range_pages = min_not_zero(max_svm_range_pages, pages);
+	max_svm_range_pages = ALIGN(max_svm_range_pages, 1ULL << 9);
+}
 
 /**
  * svm_range_add - add svm range and handle overlap
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index eab7f6d3b13c..346a41bf8dbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -204,6 +204,9 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
+
+__init void svm_range_set_max_pages(struct amdgpu_device *adev);
+
 #else
 
 struct kfd_process;
-- 
2.35.1

