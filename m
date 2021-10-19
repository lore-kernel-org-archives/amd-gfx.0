Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2796F60F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2796F60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7406E8E5;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417CC6E8E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5rOQ/qeusmuPQpzMnsUKdHXdpkkRRytF8jbD5ZWUPK8KeDGY8O7qTXBZrD6VWXUvibctgwZp8r0dKGOZd4vSsFeAxF80G1sk1Izm0Yl1zk0EQeJS9qp4nvPaCdcfTL6N0gVeFQWYDsX0ES62WINaFdB/+FcfwPJWCAEcyeYPCygpS26SAMC17aUrieEy615o/H8dXFgQaJEieKTLDO1/UjdGg+UNQ/7lxsV4Eb52eiKBwGzH1vIh+/tzaFmsJ1A86sjEtwE/eYAaMX4TiuVoCy3VCGA+i9IoIow3c0KJsXxSFKF1RB6YQbTxWfWNAFG/+lGC3Neil63u+UtD/Px1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kILuFQitPCWcU7zd7+GZV147WDw4H0Q91otv/orqiTU=;
 b=eIMNc/2XsGkAkaJaar+8kxP54uJG0C0wTFRgfVppEnELOCWR+em3AHEMHKbfUXhWJa0nCeZJ+qPGZSdI92Ot8kzhaxeIL3M3aox/ELMO2jdq0LUmYx6/32ipVQezCcHMfbwG1lG6Bkrs0QdMwW1YwcnQVuP8YfHWEZ3i9s/j4oFCcw1NMgUU2fTL0iAM9A3W/rXtCcRi9JcYXarp0mMjtBk+0hibE06sVhKqldNww6cBlm4u2DCXgF9ythbiIKG7aVi5QoWZuMdzKQ3194hCKkanLTo7VZehZ9vRchiya4mU7sy8U3bXO1FPZeGX/e0CGmurjyo6XYL139a6LXXNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kILuFQitPCWcU7zd7+GZV147WDw4H0Q91otv/orqiTU=;
 b=o2AnvDmSQfWLgF7y2mYuksDOyiFk2MEbxYGo6fOOqMhj7oXRdnYKgXRv3nyZKUsD9TGa1HttahwoNGgrrGe5YQlSa1nsRYRum2cAPpVQ+doKpC3RSReypBOtD5C/Bw3qliD32RsIGcwXY1Tdj9UWISfmIh7nS0r9hKZTvKb/gqU=
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:14:59 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::58) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:58 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:56 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 07/13] drm/amdkfd: replace kgd_dev in hqd/mqd kfd2kgd funcs
Date: Tue, 19 Oct 2021 17:13:28 -0400
Message-ID: <20211019211334.1552825-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e862b10a-703d-4fe9-9c79-08d9934581ce
X-MS-TrafficTypeDiagnostic: BY5PR12MB4098:
X-Microsoft-Antispam-PRVS: <BY5PR12MB409853DFEE49286F699725148ABD9@BY5PR12MB4098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WM4VDIGA7VolwlqofYhHpP2ub8O5btRwYeDGgMYqrg9GfovhzIpfQnB3JcH39RmsTRvBA4ztIP8FUohrVQcydVIiHNFdtVTF83Lf7JoJ9spSmw1fmALrFbVK07IThgJSVrnk6kUpX/g0xXtTldDzIGpuzudp0BKUEatNcCOCdH4i3lGIdOR41BptARkQW+iKe6yfz/J4RKMRHJjpSmSzl0xePT1oicc+CDT8UFqfUiP5SuRJnEPTS+VgOu4UyxvvY0AR//3OlZNvvfaTSrNJ6AWeJvK1ytbjNA8twJBcshtcAe3P+ISjASeBn8kmjwn2l9dsLM+lFa4qIViC+JzI5beibyC94rgqG47FFcjRYLy2RBOtMHrFGyG/Cw42xyuGAKlgTfWLEMQpADI2DdpAIM0FDYlXnsERvOum6KDCfhcwUa8P2S4xl67+d9JGfdYRofFLTN1RQxV0Jz51Qrtg9e71NAa/0Fy8phAVTGdlePSbaCAcSLo1aVrMairJaIKTps/1KhpI3WydiC17L1JkSInOuWzjUVb6UBQ2hQGJrWrJql8hGe5hqdotEWztnRsWRZLSgFkSZ0ZJxBfrURqsRB5hz/n+K0ohRjj0KUUNTTYdgYwkNkVBFNm49UFLPa12NJih6N1buRQ0EDdyqGkfqSBwcizAaU/iH3NBgu+MSuRAZPzlSEjJdtr1yCKNMzXmzAhSAG5+/L/ZvUraXY959KQK+fmIz+nyem3vbZ+UHvk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(5660300002)(2906002)(81166007)(86362001)(426003)(36756003)(336012)(16526019)(2616005)(83380400001)(82310400003)(186003)(6916009)(7696005)(30864003)(508600001)(26005)(47076005)(36860700001)(4326008)(316002)(356005)(8676002)(6666004)(70206006)(54906003)(70586007)(1076003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:58.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e862b10a-703d-4fe9-9c79-08d9934581ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified definitions:

- hqd_load
- hiq_mqd_load
- hqd_sdma_load
- hqd_dump
- hqd_sdma_dump
- hqd_is_occupied
- hqd_destroy
- hqd_sdma_is_occupied
- hqd_sdma_destroy
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 13 +++----
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h   |  9 +++--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 36 +++++++-----------
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 37 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 33 +++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 35 +++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 36 +++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h | 13 ++++---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 12 +++---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 14 +++----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 14 +++----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 12 +++---
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 25 +++++++------
 14 files changed, 129 insertions(+), 166 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 5a7f680bcb3f..c2b8d970195b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -123,10 +123,9 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 	return sdma_rlc_reg_offset;
 }
 
-int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+int kgd_arcturus_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	unsigned long end_jiffies;
@@ -193,11 +192,10 @@ int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
+int kgd_arcturus_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
@@ -225,9 +223,9 @@ int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+bool kgd_arcturus_hqd_sdma_is_occupied(struct amdgpu_device *adev,
+				void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -244,10 +242,9 @@ bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+int kgd_arcturus_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
index ce08131b7b5f..756c1a5679c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
@@ -20,11 +20,12 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+int kgd_arcturus_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm);
-int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,
+int kgd_arcturus_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs);
-bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
-int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+bool kgd_arcturus_hqd_sdma_is_occupied(struct amdgpu_device *adev,
+				void *mqd);
+int kgd_arcturus_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 69aee5b52f64..5927a8fcbc23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -212,12 +212,11 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 	return (struct v10_sdma_mqd *)mqd;
 }
 
-static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
-			uint32_t queue_id, uint32_t __user *wptr,
-			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_compute_mqd *m;
 	uint32_t *mqd_hqd;
 	uint32_t reg, hqd_base, data;
@@ -295,11 +294,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+static int kgd_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
@@ -348,11 +346,10 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	return r;
 }
 
-static int kgd_hqd_dump(struct kgd_dev *kgd,
+static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
@@ -380,10 +377,9 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	unsigned long end_jiffies;
@@ -450,11 +446,10 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
+static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
@@ -482,10 +477,10 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
+				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
@@ -504,9 +499,8 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	return retval;
 }
 
-static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -523,12 +517,11 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
 	uint32_t temp;
@@ -637,10 +630,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index b33a9fe715cd..2fc7dfc4fc92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -182,12 +182,11 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
 	return (struct v10_sdma_mqd *)mqd;
 }
 
-static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
-			uint32_t queue_id, uint32_t __user *wptr,
-			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+static int hqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_compute_mqd *m;
 	uint32_t *mqd_hqd;
 	uint32_t reg, hqd_base, data;
@@ -280,11 +279,10 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-static int hiq_mqd_load_v10_3(struct kgd_dev *kgd, void *mqd,
+static int hiq_mqd_load_v10_3(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v10_compute_mqd *m;
 	uint32_t mec, pipe;
@@ -333,11 +331,10 @@ static int hiq_mqd_load_v10_3(struct kgd_dev *kgd, void *mqd,
 	return r;
 }
 
-static int hqd_dump_v10_3(struct kgd_dev *kgd,
+static int hqd_dump_v10_3(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
@@ -365,10 +362,9 @@ static int hqd_dump_v10_3(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int hqd_sdma_load_v10_3(struct kgd_dev *kgd, void *mqd,
+static int hqd_sdma_load_v10_3(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	unsigned long end_jiffies;
@@ -435,11 +431,10 @@ static int hqd_sdma_load_v10_3(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int hqd_sdma_dump_v10_3(struct kgd_dev *kgd,
+static int hqd_sdma_dump_v10_3(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
@@ -467,10 +462,10 @@ static int hqd_sdma_dump_v10_3(struct kgd_dev *kgd,
 	return 0;
 }
 
-static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+static bool hqd_is_occupied_v10_3(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
+				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
@@ -489,9 +484,9 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd, uint64_t queue_address,
 	return retval;
 }
 
-static bool hqd_sdma_is_occupied_v10_3(struct kgd_dev *kgd, void *mqd)
+static bool hqd_sdma_is_occupied_v10_3(struct amdgpu_device *adev,
+				void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -508,12 +503,11 @@ static bool hqd_sdma_is_occupied_v10_3(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
+static int hqd_destroy_v10_3(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
 	uint32_t temp;
@@ -559,10 +553,9 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int hqd_sdma_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
+static int hqd_sdma_destroy_v10_3(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v10_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index d00ba8d65a6d..1190f58c4a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -202,12 +202,11 @@ static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
 	return (struct cik_sdma_rlc_registers *)mqd;
 }
 
-static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
-			uint32_t queue_id, uint32_t __user *wptr,
-			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct cik_mqd *m;
 	uint32_t *mqd_hqd;
 	uint32_t reg, wptr_val, data;
@@ -248,11 +247,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-static int kgd_hqd_dump(struct kgd_dev *kgd,
+static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t i = 0, reg;
 #define HQD_N_REGS (35+4)
 #define DUMP_REG(addr) do {				\
@@ -284,10 +282,9 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct cik_sdma_rlc_registers *m;
 	unsigned long end_jiffies;
 	uint32_t sdma_rlc_reg_offset;
@@ -340,11 +337,10 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
+static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_offset = engine_id * SDMA1_REGISTER_OFFSET +
 		queue_id * KFD_CIK_SDMA_QUEUE_OFFSET;
 	uint32_t i = 0, reg;
@@ -367,10 +363,10 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
+				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
@@ -389,9 +385,8 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	return retval;
 }
 
-static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct cik_sdma_rlc_registers *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -407,12 +402,11 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t temp;
 	enum hqd_dequeue_request_type type;
 	unsigned long flags, end_jiffies;
@@ -509,10 +503,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct cik_sdma_rlc_registers *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 06be6061e4c0..5eb4e9bbe463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -160,12 +160,11 @@ static inline struct vi_sdma_mqd *get_sdma_mqd(void *mqd)
 	return (struct vi_sdma_mqd *)mqd;
 }
 
-static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
-			uint32_t queue_id, uint32_t __user *wptr,
-			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+static int kgd_hqd_load(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct vi_mqd *m;
 	uint32_t *mqd_hqd;
 	uint32_t reg, wptr_val, data;
@@ -201,7 +200,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	 * on ASICs that do not support context-save.
 	 * EOP writes/reads can start anywhere in the ring.
 	 */
-	if (get_amdgpu_device(kgd)->asic_type != CHIP_TONGA) {
+	if (adev->asic_type != CHIP_TONGA) {
 		WREG32(mmCP_HQD_EOP_RPTR, m->cp_hqd_eop_rptr);
 		WREG32(mmCP_HQD_EOP_WPTR, m->cp_hqd_eop_wptr);
 		WREG32(mmCP_HQD_EOP_WPTR_MEM, m->cp_hqd_eop_wptr_mem);
@@ -235,11 +234,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-static int kgd_hqd_dump(struct kgd_dev *kgd,
+static int kgd_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t i = 0, reg;
 #define HQD_N_REGS (54+4)
 #define DUMP_REG(addr) do {				\
@@ -271,10 +269,9 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct vi_sdma_mqd *m;
 	unsigned long end_jiffies;
 	uint32_t sdma_rlc_reg_offset;
@@ -326,11 +323,10 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
+static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_offset = engine_id * SDMA1_REGISTER_OFFSET +
 		queue_id * KFD_VI_SDMA_QUEUE_OFFSET;
 	uint32_t i = 0, reg;
@@ -362,10 +358,10 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+static bool kgd_hqd_is_occupied(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
+				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
@@ -384,9 +380,8 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	return retval;
 }
 
-static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct vi_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -402,12 +397,11 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t temp;
 	enum hqd_dequeue_request_type type;
 	unsigned long flags, end_jiffies;
@@ -507,10 +501,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct vi_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index a79f4d110669..480014ada833 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -227,12 +227,11 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 	return (struct v9_sdma_mqd *)mqd;
 }
 
-int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
-			uint32_t queue_id, uint32_t __user *wptr,
-			uint32_t wptr_shift, uint32_t wptr_mask,
-			struct mm_struct *mm)
+int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_mqd *m;
 	uint32_t *mqd_hqd;
 	uint32_t reg, hqd_base, data;
@@ -307,11 +306,10 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	return 0;
 }
 
-int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
 	struct v9_mqd *m;
 	uint32_t mec, pipe;
@@ -360,11 +358,10 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 	return r;
 }
 
-int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
+int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t i = 0, reg;
 #define HQD_N_REGS 56
 #define DUMP_REG(addr) do {				\
@@ -392,10 +389,9 @@ int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	unsigned long end_jiffies;
@@ -462,11 +458,10 @@ static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
+static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
@@ -494,10 +489,10 @@ static int kgd_hqd_sdma_dump(struct kgd_dev *kgd,
 	return 0;
 }
 
-bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id)
+bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
+				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t act;
 	bool retval = false;
 	uint32_t low, high;
@@ -516,9 +511,8 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	return retval;
 }
 
-static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
+static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t sdma_rlc_rb_cntl;
@@ -535,12 +529,11 @@ static bool kgd_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd)
 	return false;
 }
 
-int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
+int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	enum hqd_dequeue_request_type type;
 	unsigned long end_jiffies;
 	uint32_t temp;
@@ -588,10 +581,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	return 0;
 }
 
-static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+static int kgd_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
 				unsigned int utimeout)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	struct v9_sdma_mqd *m;
 	uint32_t sdma_rlc_reg_offset;
 	uint32_t temp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index c63591106879..3fd99968f463 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -29,19 +29,20 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
 		unsigned int vmid);
 int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);
-int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
+int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
 			struct mm_struct *mm);
-int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
+int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off);
-int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
+int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs);
-bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
-		uint32_t pipe_id, uint32_t queue_id);
-int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
+bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
+			uint64_t queue_address, uint32_t pipe_id,
+			uint32_t queue_id);
+int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f8fce9d05f50..1919efe06f30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2064,7 +2064,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		return 0;
 	}
 
-	r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->kgd,
+	r = dqm->dev->kfd2kgd->hqd_dump(dqm->dev->adev,
 					KFD_CIK_HIQ_PIPE, KFD_CIK_HIQ_QUEUE,
 					&dump, &n_regs);
 	if (!r) {
@@ -2086,7 +2086,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 				continue;
 
 			r = dqm->dev->kfd2kgd->hqd_dump(
-				dqm->dev->kgd, pipe, queue, &dump, &n_regs);
+				dqm->dev->adev, pipe, queue, &dump, &n_regs);
 			if (r)
 				break;
 
@@ -2103,7 +2103,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
 		     queue++) {
 			r = dqm->dev->kfd2kgd->hqd_sdma_dump(
-				dqm->dev->kgd, pipe, queue, &dump, &n_regs);
+				dqm->dev->adev, pipe, queue, &dump, &n_regs);
 			if (r)
 				break;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 064914e1e8d6..58a71cb0e537 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -170,7 +170,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 	uint32_t wptr_mask = (uint32_t)((p->queue_size / 4) - 1);
 
-	return mm->dev->kfd2kgd->hqd_load(mm->dev->kgd, mqd, pipe_id, queue_id,
+	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
 					  wptr_shift, wptr_mask, mms);
 }
@@ -179,7 +179,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 			 uint32_t pipe_id, uint32_t queue_id,
 			 struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->kgd, mqd,
+	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
 					       (uint32_t __user *)p->write_ptr,
 					       mms);
 }
@@ -271,7 +271,7 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 			unsigned int timeout, uint32_t pipe_id,
 			uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->kgd, mqd, type, timeout,
+	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
 					pipe_id, queue_id);
 }
 
@@ -284,7 +284,7 @@ static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
 				unsigned int timeout, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->kgd, mqd, timeout);
+	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
 }
 
 static bool is_occupied(struct mqd_manager *mm, void *mqd,
@@ -292,7 +292,7 @@ static bool is_occupied(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 
-	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->kgd, queue_address,
+	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
 					pipe_id, queue_id);
 
 }
@@ -301,7 +301,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 			uint64_t queue_address,	uint32_t pipe_id,
 			uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
+	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c7fb59ca597f..fe03f2a77fb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -147,7 +147,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 
-	r = mm->dev->kfd2kgd->hqd_load(mm->dev->kgd, mqd, pipe_id, queue_id,
+	r = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
 					  wptr_shift, 0, mms);
 	return r;
@@ -157,7 +157,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
+	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
 					      queue_id, p->doorbell_off);
 }
 
@@ -237,7 +237,7 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 		       uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->kgd, mqd, type, timeout,
+		(mm->dev->adev, mqd, type, timeout,
 		 pipe_id, queue_id);
 }
 
@@ -252,7 +252,7 @@ static bool is_occupied(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->kgd, queue_address,
+		mm->dev->adev, queue_address,
 		pipe_id, queue_id);
 }
 
@@ -318,7 +318,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		uint32_t pipe_id, uint32_t queue_id,
 		struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->kgd, mqd,
+	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
 					       (uint32_t __user *)p->write_ptr,
 					       mms);
 }
@@ -360,14 +360,14 @@ static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		unsigned int timeout, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->kgd, mqd, timeout);
+	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
 }
 
 static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 		uint64_t queue_address, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
+	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..643d3eb18ebc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -198,7 +198,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 
-	return mm->dev->kfd2kgd->hqd_load(mm->dev->kgd, mqd, pipe_id, queue_id,
+	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
 					  wptr_shift, 0, mms);
 }
@@ -207,7 +207,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
+	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
 					      queue_id, p->doorbell_off);
 }
 
@@ -289,7 +289,7 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->kgd, mqd, type, timeout,
+		(mm->dev->adev, mqd, type, timeout,
 		pipe_id, queue_id);
 }
 
@@ -311,7 +311,7 @@ static bool is_occupied(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->kgd, queue_address,
+		mm->dev->adev, queue_address,
 		pipe_id, queue_id);
 }
 
@@ -373,7 +373,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		uint32_t pipe_id, uint32_t queue_id,
 		struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->kgd, mqd,
+	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
 					       (uint32_t __user *)p->write_ptr,
 					       mms);
 }
@@ -415,14 +415,14 @@ static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		unsigned int timeout, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->kgd, mqd, timeout);
+	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
 }
 
 static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 		uint64_t queue_address, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
+	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 33dbd22d290f..8b8151597ec6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -161,7 +161,7 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 	uint32_t wptr_mask = (uint32_t)((p->queue_size / 4) - 1);
 
-	return mm->dev->kfd2kgd->hqd_load(mm->dev->kgd, mqd, pipe_id, queue_id,
+	return mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
 					  (uint32_t __user *)p->write_ptr,
 					  wptr_shift, wptr_mask, mms);
 }
@@ -262,7 +262,7 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_destroy
-		(mm->dev->kgd, mqd, type, timeout,
+		(mm->dev->adev, mqd, type, timeout,
 		pipe_id, queue_id);
 }
 
@@ -277,7 +277,7 @@ static bool is_occupied(struct mqd_manager *mm, void *mqd,
 			uint32_t queue_id)
 {
 	return mm->dev->kfd2kgd->hqd_is_occupied(
-		mm->dev->kgd, queue_address,
+		mm->dev->adev, queue_address,
 		pipe_id, queue_id);
 }
 
@@ -343,7 +343,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		uint32_t pipe_id, uint32_t queue_id,
 		struct queue_properties *p, struct mm_struct *mms)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->kgd, mqd,
+	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
 					       (uint32_t __user *)p->write_ptr,
 					       mms);
 }
@@ -384,14 +384,14 @@ static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
 		unsigned int timeout, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->kgd, mqd, timeout);
+	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
 }
 
 static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 		uint64_t queue_address, uint32_t pipe_id,
 		uint32_t queue_id)
 {
-	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
+	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index ba444cbf9206..75e40acdd699 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -238,36 +238,37 @@ struct kfd2kgd_calls {
 
 	int (*init_interrupts)(struct kgd_dev *kgd, uint32_t pipe_id);
 
-	int (*hqd_load)(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
+	int (*hqd_load)(struct amdgpu_device *adev, void *mqd, uint32_t pipe_id,
 			uint32_t queue_id, uint32_t __user *wptr,
 			uint32_t wptr_shift, uint32_t wptr_mask,
 			struct mm_struct *mm);
 
-	int (*hiq_mqd_load)(struct kgd_dev *kgd, void *mqd,
+	int (*hiq_mqd_load)(struct amdgpu_device *adev, void *mqd,
 			    uint32_t pipe_id, uint32_t queue_id,
 			    uint32_t doorbell_off);
 
-	int (*hqd_sdma_load)(struct kgd_dev *kgd, void *mqd,
+	int (*hqd_sdma_load)(struct amdgpu_device *adev, void *mqd,
 			     uint32_t __user *wptr, struct mm_struct *mm);
 
-	int (*hqd_dump)(struct kgd_dev *kgd,
+	int (*hqd_dump)(struct amdgpu_device *adev,
 			uint32_t pipe_id, uint32_t queue_id,
 			uint32_t (**dump)[2], uint32_t *n_regs);
 
-	int (*hqd_sdma_dump)(struct kgd_dev *kgd,
+	int (*hqd_sdma_dump)(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs);
 
-	bool (*hqd_is_occupied)(struct kgd_dev *kgd, uint64_t queue_address,
-				uint32_t pipe_id, uint32_t queue_id);
-
-	int (*hqd_destroy)(struct kgd_dev *kgd, void *mqd, uint32_t reset_type,
-				unsigned int timeout, uint32_t pipe_id,
+	bool (*hqd_is_occupied)(struct amdgpu_device *adev,
+				uint64_t queue_address, uint32_t pipe_id,
 				uint32_t queue_id);
 
-	bool (*hqd_sdma_is_occupied)(struct kgd_dev *kgd, void *mqd);
+	int (*hqd_destroy)(struct amdgpu_device *adev, void *mqd,
+				uint32_t reset_type, unsigned int timeout,
+				uint32_t pipe_id, uint32_t queue_id);
+
+	bool (*hqd_sdma_is_occupied)(struct amdgpu_device *adev, void *mqd);
 
-	int (*hqd_sdma_destroy)(struct kgd_dev *kgd, void *mqd,
+	int (*hqd_sdma_destroy)(struct amdgpu_device *adev, void *mqd,
 				unsigned int timeout);
 
 	int (*address_watch_disable)(struct kgd_dev *kgd);
-- 
2.25.1

