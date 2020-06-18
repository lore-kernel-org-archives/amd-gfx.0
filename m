Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3F8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 16:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5337E208C3
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cpt2/Afc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0449D6E43D;
	Thu, 18 Jun 2020 16:52:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155D46E43D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 16:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FakPd2Jicdo1U8FQ8pV68bu1N4UtBXvL8z/4T1I0ZswnHt/E6v+0KS+Qsr0QtWv2Tg+GTPgVzsW5Wh4MnXLIhWA1akbkxXtFGBpfg7KHCVJQQTinwoLnGw1G3qEla4CKyHjloKEdeIDZ9ZLQ1ABq9jD6jbVg1WYwKhLDY8GJUbTZ92x7nKid0FiK+0obl4QnI8yGMBGwWZJBH8fYU2s3T+eG4T1dfs85uEz5SyoEPdoVnjzmB3A/3CfJ31FDNleloRANQa0Wu3hjf5gTarrJUsODDmbMMGR7zI1VPj5bAEM9lWQ0HpoiNQN/mfFOTqZ1LYPuk+GgyFeTgY5V0xUFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XMQAEatNr2Udi3Ral1Udgkks2OOIv8+XWK+B0Uf/mQ=;
 b=ANWcKDTOZnsckNGsxrLOUpXIwFauCXiGYypbZ7dFThZHZtge1iys5JlE1NuSQUxVRvYniOPT8i9yxfQ/cnBNAlwnBEHbCYkxgBflziOEsNbHLomQOUT3wFOzsODFkNKYhEW29a0tlaYH6uSg8aZf651jyxPz622SAJ6Qcy/GjaCVnWoHn4VeOaaxkRbjLmNubqcZJx6vcWHBo7Q8clP6ltJ/pQt6tXUCr9ORep5YhDFjcwIvLgGUKuSiGk+sp4+SPpVwYwZK8jCxOSFGiCTpCJmhWX89hAcyN8qMNyS4L8MeQvOOQU6QnjS6ZNyREMRCTzgMLhaHeWy5pGkfr35qZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XMQAEatNr2Udi3Ral1Udgkks2OOIv8+XWK+B0Uf/mQ=;
 b=Cpt2/AfcrQJey4kkYU/0Xn5yDSx8vim1qkZIj2XTQGN9XaF7fnTNPyLRch/YWru2tCpTGVgU9tj51kNx9kFHlDI4nWZ4SZccpO8enpZjGU9MRatMQPmPYXsXrFnkZLh9JWG9IvS8QzE16qLqDidaVtMM6RJEkabIBXDGLv8YMeY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Thu, 18 Jun 2020 16:52:26 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 16:52:26 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix unused variable
Date: Thu, 18 Jun 2020 12:52:05 -0400
Message-Id: <20200618165205.24444-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::31) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jz-tester.amd.com (165.204.55.251) by
 YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 16:52:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 739ecf0b-b8f1-4705-63b2-08d813a7fb00
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42043835C02A4B1E1C0EE7FCE49B0@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+XaZGuk3i8KfeX63VR6LRiv1BvCkQei5kvEo/7TonzUE7kDWM6EgVPFs3aNtn2Y52TYgwTknTOll0PIe9UD6GmROd7sXKvM0/QQ5GSFBy7ZNf0b7UNtvIan6smTTp7Vk84axM0fZJae4984EesnevJyiEk5VchnbrYFfYZMXSIUHlFQp/PWXrS4K3v+W10ZiA8dHqOWMOD5p9qKGRsiu6vYvbAazOh5puR3vK8D9Hg1WVME/cqN/nrN/LBeh47NopzhglcBXhVVOg+8KmmVB3W0uOuTPMBKGF3MzToTzln7IdlLsjFFqZGm2/SkX6B2pUij+8HaKu4WHncvh+I6VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(6666004)(66946007)(66476007)(66556008)(86362001)(5660300002)(2616005)(956004)(4326008)(6916009)(36756003)(83380400001)(7696005)(6486002)(478600001)(30864003)(2906002)(186003)(26005)(316002)(8936002)(16526019)(8676002)(52116002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: celO/fjh1jVPlVQIPWd60h8KH0F8EAe2qCOLcf1t5GOYCK78v541TnFQOqwu1Imm0x8rKhszsUe1MfQwE7IS+wv7bqeXV6Ff5xU2LTDV4gCGiUhGvbvMXK+2sb/QiOIeAcCx/gzEmWeW6uvG7+XEqw99+tywxY1BP6eiQKkv6XJxy+Wb9+jG/nsueRqKTLWNId4z3muljI/I73OulzgwY+ckkMTV/G7In3bra+fyx04Ml21ay2wlXsZUrzibzl6gQS9qKZalAPYPh58dW7/CTYbGWbr22/Lg3P0yJZKk2tzJ34zrPvsSe4PEh32Y+H9bji4FTPeWsjLXMz6NNeKs6bTLSyLDNrdkv+NCR1o3vv8NGnG10VnhpbHJlUhrwkxnepHC6cGNYAzwLy8UOJWUghjLdv1WVvq6CdbEOoC16XIa/+zbAThoEgz1j2EjJfZ92tOH6uzhT/QSvSMaZm1bvOahhOwWjtBIdzZPehmgq725ew1bvQyzBNYIJTVkVRfr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739ecf0b-b8f1-4705-63b2-08d813a7fb00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:52:26.5647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8AIuHGqE6u//Qp7pu0DVGCLVVaXjAxsD3fkFiNeOiwWmiJE7F4ctt4ZZzjRIQ6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SOC15_WAIT_ON_RREG's return value needn't always been handled by
caller. new design is to fix this kind of unused variable.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    | 14 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    |  6 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    | 14 +++----
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 15 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     | 51 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 40 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 34 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 41 ++++++++----------
 8 files changed, 102 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 552eb7da54ae..c5f49129a300 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -230,9 +230,9 @@ static int jpeg_v2_0_disable_power_gating(struct amdgpu_device *adev)
 		data = 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
 		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
 
-		SOC15_WAIT_ON_RREG(JPEG, 0,
+		r = SOC15_WAIT_ON_RREG(JPEG, 0,
 			mmUVD_PGFSM_STATUS, UVD_PGFSM_STATUS_UVDJ_PWR_ON,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
 			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
@@ -261,9 +261,9 @@ static int jpeg_v2_0_enable_power_gating(struct amdgpu_device* adev)
 		data = 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
 		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
 
-		SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_PGFSM_STATUS,
+		r = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_PGFSM_STATUS,
 			(2 << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT),
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
 			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
@@ -677,10 +677,10 @@ static bool jpeg_v2_0_is_idle(void *handle)
 static int jpeg_v2_0_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret = 0;
+	int ret;
 
-	SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS, UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK, ret);
+	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS, UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 713c32560445..f74262a22a16 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -449,15 +449,15 @@ static bool jpeg_v2_5_is_idle(void *handle)
 static int jpeg_v2_5_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i, ret = 0;
+	int i, ret;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		SOC15_WAIT_ON_RREG(JPEG, i, mmUVD_JRBC_STATUS,
+		ret = SOC15_WAIT_ON_RREG(JPEG, i, mmUVD_JRBC_STATUS,
 			UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-			UVD_JRBC_STATUS__RB_JOB_DONE_MASK, ret);
+			UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 9dbc616b38cb..42f1a516005e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -266,9 +266,9 @@ static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
 		data = 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
 		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
 
-		SOC15_WAIT_ON_RREG(JPEG, 0,
+		r = SOC15_WAIT_ON_RREG(JPEG, 0,
 			mmUVD_PGFSM_STATUS, UVD_PGFSM_STATUS_UVDJ_PWR_ON,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
 			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
@@ -301,9 +301,9 @@ static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device* adev)
 		data = 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT;
 		WREG32(SOC15_REG_OFFSET(JPEG, 0, mmUVD_PGFSM_CONFIG), data);
 
-		SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_PGFSM_STATUS,
+		r = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_PGFSM_STATUS,
 			(2 << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT),
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK, r);
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
 			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
@@ -461,11 +461,11 @@ static bool jpeg_v3_0_is_idle(void *handle)
 static int jpeg_v3_0_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret = 0;
+	int ret;
 
-	SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
+	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK, ret);
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 56d02aa690a7..a5c00ab8b021 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -50,18 +50,19 @@
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
 	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value)
 
-#define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask, ret) \
+#define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
+({	int ret = 0;						\
 	do {							\
-		uint32_t old_ = 0;	\
+		uint32_t old_ = 0;				\
 		uint32_t tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
 		uint32_t loop = adev->usec_timeout;		\
 		ret = 0;					\
 		while ((tmp_ & (mask)) != (expected_value)) {	\
 			if (old_ != tmp_) {			\
 				loop = adev->usec_timeout;	\
-				old_ = tmp_;				\
-			} else						\
-				udelay(1);				\
+				old_ = tmp_;			\
+			} else					\
+				udelay(1);			\
 			tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
 			loop--;					\
 			if (!loop) {				\
@@ -71,7 +72,9 @@
 				break;				\
 			}					\
 		}						\
-	} while (0)
+	} while (0);						\
+	ret;							\
+})
 
 #define WREG32_RLC(reg, value) \
 	do {							\
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index e88a5ef8bba1..6dcc3ce0c00a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -683,7 +683,6 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
-	int ret;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
@@ -699,7 +698,7 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 			| 2 << UVD_PGFSM_CONFIG__UVDW_PWR_CONFIG__SHIFT);
 
 		WREG32_SOC15(VCN, 0, mmUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON, 0xFFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON, 0xFFFFFF);
 	} else {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
@@ -713,7 +712,7 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 			| 1 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDW_PWR_CONFIG__SHIFT);
 		WREG32_SOC15(VCN, 0, mmUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, 0,  0xFFFFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, 0,  0xFFFFFFFF);
 	}
 
 	/* polling UVD_PGFSM_STATUS to confirm UVDM_PWR_STATUS , UVDU_PWR_STATUS are 0 (power on) */
@@ -729,7 +728,6 @@ static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
 static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
-	int ret;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		/* Before power off, this indicator has to be turned on */
@@ -764,7 +762,7 @@ static void vcn_1_0_enable_static_power_gating(struct amdgpu_device *adev)
 			| 2 << UVD_PGFSM_STATUS__UVDTE_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDE_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDW_PWR_STATUS__SHIFT);
-		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, data, 0xFFFFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, data, 0xFFFFFFFF);
 	}
 }
 
@@ -1113,15 +1111,15 @@ static int vcn_v1_0_start(struct amdgpu_device *adev)
  */
 static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 {
-	int ret_code, tmp;
+	int tmp;
 
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
 
 	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
 		UVD_LMI_STATUS__READ_CLEAN_MASK |
 		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
 		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp);
 
 	/* put VCPU into reset */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
@@ -1130,7 +1128,7 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 
 	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
 		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_LMI_STATUS, tmp, tmp);
 
 	/* disable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CNTL), 0,
@@ -1154,30 +1152,29 @@ static int vcn_v1_0_stop_spg_mode(struct amdgpu_device *adev)
 
 static int vcn_v1_0_stop_dpg_mode(struct amdgpu_device *adev)
 {
-	int ret_code = 0;
 	uint32_t tmp;
 
 	/* Wait for power status to be UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF */
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 			UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF,
-			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* wait for read ptr to be equal to write ptr */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR);
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_JRBC_RB_WPTR);
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_JRBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_JRBC_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
@@ -1220,9 +1217,9 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 			ret_code = 0;
 
 			if (!(reg_data & UVD_DPG_PAUSE__JPEG_PAUSE_DPG_ACK_MASK))
-				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
+				ret_code = SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 						   UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF,
-						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
 				/* pause DPG non-jpeg */
@@ -1230,7 +1227,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_DPG_PAUSE,
 						   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
-						   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+						   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 				/* Restore */
 				ring = &adev->vcn.inst->ring_enc[0];
@@ -1252,7 +1249,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 						   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 						   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 			}
 		} else {
 			/* unpause dpg non-jpeg, no need to wait */
@@ -1276,9 +1273,9 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 			ret_code = 0;
 
 			if (!(reg_data & UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK))
-				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
+				ret_code = SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 						   UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF,
-						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
 				/* Make sure JPRG Snoop is disabled before sending the pause */
@@ -1291,7 +1288,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_DPG_PAUSE,
 							UVD_DPG_PAUSE__JPEG_PAUSE_DPG_ACK_MASK,
-							UVD_DPG_PAUSE__JPEG_PAUSE_DPG_ACK_MASK, ret_code);
+							UVD_DPG_PAUSE__JPEG_PAUSE_DPG_ACK_MASK);
 
 				/* Restore */
 				ring = &adev->jpeg.inst->ring_dec;
@@ -1313,7 +1310,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 						   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 						   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+						   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 			}
 		} else {
 			/* unpause dpg jpeg, no need to wait */
@@ -1336,10 +1333,10 @@ static bool vcn_v1_0_is_idle(void *handle)
 static int vcn_v1_0_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret = 0;
+	int ret;
 
-	SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
-		UVD_STATUS__IDLE, ret);
+	ret = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f31b8a5bba64..c0e4133a6dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -697,7 +697,6 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
-	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
@@ -716,7 +715,7 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 
 		WREG32_SOC15(VCN, 0, mmUVD_PGFSM_CONFIG, data);
 		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON_2_0, 0xFFFFF, ret);
+			UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON_2_0, 0xFFFFF);
 	} else {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
@@ -729,7 +728,7 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 			| 1 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT);
 		WREG32_SOC15(VCN, 0, mmUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, 0,  0xFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, 0,  0xFFFFF);
 	}
 
 	/* polling UVD_PGFSM_STATUS to confirm UVDM_PWR_STATUS,
@@ -747,7 +746,6 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
-	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
@@ -783,7 +781,7 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 			| 2 << UVD_PGFSM_STATUS__UVDTD_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDTE_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDE_PWR_STATUS__SHIFT);
-		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, data, 0xFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_PGFSM_STATUS, data, 0xFFFFF);
 	}
 }
 
@@ -1099,25 +1097,24 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 
 static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
 {
-	int ret_code = 0;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* wait for read ptr to be equal to write ptr */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR);
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
-	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS), 0,
@@ -1139,7 +1136,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 	}
 
 	/* wait for uvd idle */
-	SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
+	r = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
 	if (r)
 		return r;
 
@@ -1147,7 +1144,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 		UVD_LMI_STATUS__READ_CLEAN_MASK |
 		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
 		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-	SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_LMI_STATUS, tmp, tmp, r);
+	r = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_LMI_STATUS, tmp, tmp);
 	if (r)
 		return r;
 
@@ -1158,7 +1155,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
 		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-	SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_LMI_STATUS, tmp, tmp, r);
+	r = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_LMI_STATUS, tmp, tmp);
 	if (r)
 		return r;
 
@@ -1209,9 +1206,8 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
-			ret_code = 0;
-			SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 0x1,
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			ret_code = SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
 				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
@@ -1222,7 +1218,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				/* wait for ACK */
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_DPG_PAUSE,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
-					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 				/* Stall DPG before WPTR/RPTR reset */
 				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
@@ -1259,7 +1255,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 
 				SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON,
-					   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+					   UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 			}
 		} else {
 			/* unpause dpg, no need to wait */
@@ -1282,10 +1278,10 @@ static bool vcn_v2_0_is_idle(void *handle)
 static int vcn_v2_0_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret = 0;
+	int ret;
 
-	SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
-		UVD_STATUS__IDLE, ret);
+	ret = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ba1c4fbc19dc..e99bef6e2354 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -549,7 +549,6 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
-	int ret = 0;
 	int i;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
@@ -589,7 +588,7 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
 
 		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
 
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
 
 		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
 		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
@@ -1302,25 +1301,24 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 
 static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
-	int ret_code = 0;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* wait for read ptr to be equal to write ptr */
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
@@ -1343,7 +1341,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 		}
 
 		/* wait for vcn idle */
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
 		if (r)
 			return r;
 
@@ -1351,7 +1349,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			UVD_LMI_STATUS__READ_CLEAN_MASK |
 			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
 			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 		if (r)
 			return r;
 
@@ -1362,7 +1360,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 
 		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
 			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 		if (r)
 			return r;
 
@@ -1412,8 +1410,8 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
-			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			ret_code = SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
 				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
@@ -1425,7 +1423,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				/* wait for ACK */
 				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_DPG_PAUSE,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
-					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 				/* Stall DPG before WPTR/RPTR reset */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
@@ -1458,13 +1456,13 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS,
-					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 			}
 		} else {
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE, reg_data);
 			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 		}
 		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
@@ -1701,8 +1699,8 @@ static int vcn_v2_5_wait_for_idle(void *handle)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE, ret);
+		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
+			UVD_STATUS__IDLE);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2497f29bbb35..90fe95f345e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -482,7 +482,6 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data = 0;
-	int ret;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
@@ -502,7 +501,7 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 
 		WREG32_SOC15(VCN, inst, mmUVD_PGFSM_CONFIG, data);
 		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDM_UVDU_UVDLM_PWR_ON_3_0, 0x3F3FFFFF, ret);
+			UVD_PGFSM_STATUS__UVDM_UVDU_UVDLM_PWR_ON_3_0, 0x3F3FFFFF);
 	} else {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
@@ -519,7 +518,7 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 			| 1 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
 		WREG32_SOC15(VCN, inst, mmUVD_PGFSM_CONFIG, data);
-		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, 0,  0x3F3FFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, 0,  0x3F3FFFFF);
 	}
 
 	data = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
@@ -534,7 +533,6 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
-	int ret;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		/* Before power off, this indicator has to be turned on */
@@ -573,7 +571,7 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
 			| 2 << UVD_PGFSM_STATUS__UVDATD_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDNA_PWR_STATUS__SHIFT
 			| 2 << UVD_PGFSM_STATUS__UVDNB_PWR_STATUS__SHIFT);
-		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, data, 0x3F3FFFFF, ret);
+		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, data, 0x3F3FFFFF);
 	}
 }
 
@@ -588,7 +586,6 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
 static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
-	int ret = 0;
 
 	/* VCN disable CGC */
 	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
@@ -624,7 +621,7 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 
 	WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
 
-	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF, ret);
+	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
 
 	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
 	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
@@ -1142,25 +1139,24 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 
 static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
-	int ret_code = 0;
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* wait for read ptr to be equal to write ptr */
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF);
 
 	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
-	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF);
 
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
-		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
@@ -1184,7 +1180,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		}
 
 		/* wait for vcn idle */
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
 		if (r)
 			return r;
 
@@ -1192,7 +1188,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 			UVD_LMI_STATUS__READ_CLEAN_MASK |
 			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
 			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 		if (r)
 			return r;
 
@@ -1202,7 +1198,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
 		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
 			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp, r);
+		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
 		if (r)
 			return r;
 
@@ -1259,9 +1255,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
-			ret_code = 0;
-			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			ret_code = SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 			if (!ret_code) {
 				/* pause DPG */
@@ -1271,7 +1266,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				/* wait for ACK */
 				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_DPG_PAUSE,
 					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
-					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 				/* Restore */
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
@@ -1292,7 +1287,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					RREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 
 				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS,
-					UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+					UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 			}
 		} else {
 			/* unpause dpg, no need to wait */
@@ -1542,8 +1537,8 @@ static int vcn_v3_0_wait_for_idle(void *handle)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE, ret);
+		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
+			UVD_STATUS__IDLE);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
