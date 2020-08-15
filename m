Return-Path: <SRS0=E5ou=BZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D443FC433E3
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Aug 2020 01:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF1222E02
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Aug 2020 01:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z5WVw5d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF1222E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268746EC59;
	Sat, 15 Aug 2020 01:25:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142FD6EC57
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Aug 2020 01:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDD/wSdTZJgtNvvELGzfUIQJzSUzs1ByzVdFZyRQYr55T4g3cxkCs7lR0LL0jo5PSPq41kShjeMcEvzETkdqZlX8io2Z+HNwpMLmIRQ3PdnavZQEYYt5X92D0gSaoEt09FzROmZPOOQSACdGuXl0doCWBOXbUMNnIvItp/CAlsIX6KjxF/GOe+9EVK2vCK7fefZBl+tBtWVGjoWiaYWn2RP6PsyM+Zy1dFjIAqPdRVD2VsuAllZTMyC6pxABpllkWvgRNVAMzhcI5ldDm2DHcGPbSYE3wx96bAqgsH2NtO+kWMrdiQy3MBU92j+e6ztyMNZ5LDO2Si8k7xViMCbHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ST283AZ7WDfQHM6Tg8vPWp4K40mozbl/XhrsNBiJvA=;
 b=BeNMExk81sZMhZUq6ra4jc3fvIYjIFUFs05Uelc5KafSnXx+bCb9iTBqposZaQNubyblsdvqmbSZgi7fqS/zhMPVxYNOaxHvII0/hdtwF9Csq3tKkbv77mZqEDUFjuLp7mkU+ean7RWeua4wd+utKf5M0xT5J3ag+tNxMAVDlipRQCIMPyJx9nvlTDaCmVrHT1LK8UgOrJrAv5k1aUAHKjxAf94xlQ5u8pHoZZJcX4Fx/Z6zTkQr/rmiBjtxE2K2zMaRXOR1vjXh9gzo+6wKEK1WYA2mc+qnG/TUl/+oSa0TAYh+v8SI85NCYGJZ2XN5zpDXjsC3I62vNXUmKDujTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ST283AZ7WDfQHM6Tg8vPWp4K40mozbl/XhrsNBiJvA=;
 b=Z5WVw5d6ao09WHUBM6VJkffQSPxuzXa169Antu7b1ZT36oaIXDrG9SvCg5pxabzMOizPLnqO07Y5UuCqYsjYQ3VqUUH6jp7M9+jSNrzQYdfu0BrZ9isk37KuKhtTHK40HxKxPY5CjwQNA0045c2R8kJ47SvLvoFSDQdIMgw4gzk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Sat, 15 Aug
 2020 01:25:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3283.015; Sat, 15 Aug 2020
 01:25:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: amdgpu_device from DRM dev by macro
Date: Fri, 14 Aug 2020 21:25:32 -0400
Message-Id: <20200815012533.7677-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.215.g878e727637
In-Reply-To: <20200815012533.7677-1-luben.tuikov@amd.com>
References: <20200815012533.7677-1-luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Sat, 15 Aug 2020 01:25:47 +0000
X-Mailer: git-send-email 2.28.0.215.g878e727637
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ee2142c-583d-4051-dad4-08d840ba2349
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4436F3683D525AB65BF1B93099410@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:111;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7tJN7TJ9gJz8CNsszK8dNu51/x1RP/yJMyKiPNjH1PnqRSTJ3ASdcbC6BFnSi0mjY6DSzpjz7HdfASuPqdi8J7qCYL5CU+j6Ey05xPZp3iuUOFUH8GGmHNv3g32vpF6lqreoSW79TLDcXOXflV4l70laOaSbl5BudobKMkwOqI6bHpUWo8NlDlKFY/jeRL2M7zxiPwfLtZpySSNiGqwaXvQ6Y3az/wA+aZGgTeO4te0+Aa8wCiwqpl6VrnMQnua8g0fgBnGeH1dYGpVhu9eJWNKQGtA+ZDj+bVIVX7ycjwfqFHkUGn2BdCKgUR8OpBJtcRhT9uVv5NQ2Iqnjofw0Ulp3gBbDlidh9ELvZzf+nyjFk26NWGCX9HowhAYtAT2H6UAXhSm2xjSmZRH2jPDRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(316002)(66946007)(86362001)(36756003)(52116002)(66556008)(66476007)(7696005)(16526019)(956004)(478600001)(1076003)(44832011)(6486002)(26005)(8936002)(30864003)(2906002)(186003)(5660300002)(6916009)(6666004)(8676002)(4326008)(83380400001)(2616005)(21314003)(559001)(579004)(358055004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Kw2Z+KOVOZE6LMZ4yuKWDu2h7hBdun3KaZ3Gn3xC1iFHZnOlN1pSQeYsNgIg2lsFdiuyLMhUp2QlZOWZQ8WjlMZ2lClY8rce+OuAw+8FBkW9kKixOTRpt3+JbIUAul0Iw4VnA+UpOwyAojqX9K9EnVUQwn/M1+xfFfr98Eb5lUXDge5DCa3udSuiHkv+JMMKimYP2la2c4tlGzDHs3JyFpp7camCXWZr6ayenKkb1D7pU9eDyLeR17t3Sm4kTGhz1BQCZ6xhOcFE64oge1uBrc4dNGQtQEQ+ZrJ4bwIACdS+08QoE9PqeqjUGn03AWZvPn338VzaLuzSh+ZsuBUw2QSPLuERopmRpaDji2VrBf1U6tnSNux4wuorNZwKJa0b85EB0SfpSowpzq7K51VECbddVx6xQm06r51baxppyktTBMTaeIeSOj19Lk9MvJhTZH4+Yp9TOM+NM2OTsfR+pvcx1DRg4pd1oD/xyu58INvDM1EcHfvAbMuiWWhFxwGCkXi8j9S63UYiFQrF6eTK2kgY1G9KTiG/AJXJoObGiZvIgt6ZHh0R/eQf2iWnTjp8O0WHLBlgeFJUBKAgn/EHNbZgJ2aUGdVFrMvg+p62mIRKPvb7xUFysc7SU/aTYkeOLBv4BCw498j454jbmaDMZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee2142c-583d-4051-dad4-08d840ba2349
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2020 01:25:47.7640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDRsPi4NAdr37jadqB42sOUPBB1lCJPWnfRHGTUB1HIkh1EVsvbxNXlIyJwllc3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get the amdgpu_device from the DRM device by use
of a macro, DRM_TO_ADEV(). The macro resolves
a pointer to struct drm_device to a pointer to
struct amdgpu_device.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 18 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 20 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 12 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 16 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 80 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    | 22 ++---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |  6 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 34 ++++----
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 48 +++++------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 50 ++++++------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 58 +++++++-------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 48 +++++------
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 +++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 +-
 44 files changed, 301 insertions(+), 301 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f9d97f61aa5..0268bb1da82b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -988,6 +988,8 @@ struct amdgpu_device {
 	struct ratelimit_state		throttling_logging_rs;
 };
 
+#define DRM_TO_ADEV(_drmdevp)  ((struct amdgpu_device *)(_drmdevp)->dev_private)
+
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
 {
 	return container_of(bdev, struct amdgpu_device, mman.bdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9738dccb1c2c..cf185f3b8ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -498,7 +498,7 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		/* Can't handle buffers from different drivers */
 		goto out_put;
 
-	adev = obj->dev->dev_private;
+	adev = DRM_TO_ADEV(obj->dev);
 	bo = gem_to_amdgpu_bo(obj);
 	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0d75726bd228..aed2bd9e845e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1681,7 +1681,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 		return -EINVAL;
 
 	obj = dma_buf->priv;
-	if (obj->dev->dev_private != adev)
+	if (DRM_TO_ADEV(obj->dev) != adev)
 		/* Can't handle buffers from other devices */
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index e33f63712b46..351ad1945199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1882,7 +1882,7 @@ static void cail_mc_write(struct card_info *info, uint32_t reg, uint32_t val)
  */
 static void cail_reg_write(struct card_info *info, uint32_t reg, uint32_t val)
 {
-	struct amdgpu_device *adev = info->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(info->dev);
 
 	WREG32(reg, val);
 }
@@ -1898,7 +1898,7 @@ static void cail_reg_write(struct card_info *info, uint32_t reg, uint32_t val)
  */
 static uint32_t cail_reg_read(struct card_info *info, uint32_t reg)
 {
-	struct amdgpu_device *adev = info->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(info->dev);
 	uint32_t r;
 
 	r = RREG32(reg);
@@ -1916,7 +1916,7 @@ static uint32_t cail_reg_read(struct card_info *info, uint32_t reg)
  */
 static void cail_ioreg_write(struct card_info *info, uint32_t reg, uint32_t val)
 {
-	struct amdgpu_device *adev = info->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(info->dev);
 
 	WREG32_IO(reg, val);
 }
@@ -1932,7 +1932,7 @@ static void cail_ioreg_write(struct card_info *info, uint32_t reg, uint32_t val)
  */
 static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
 {
-	struct amdgpu_device *adev = info->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(info->dev);
 	uint32_t r;
 
 	r = RREG32_IO(reg);
@@ -1944,7 +1944,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 						 char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", ctx->vbios_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 85b0515c0fdc..b187e93ccf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -265,7 +265,7 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	union drm_amdgpu_bo_list *args = data;
 	uint32_t handle = args->in.list_handle;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index a1aec205435d..002672477e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -41,7 +41,7 @@
 void amdgpu_connector_hotplug(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 	/* bail if the connector does not have hpd pin, e.g.,
@@ -279,7 +279,7 @@ amdgpu_connector_get_hardcoded_edid(struct amdgpu_device *adev)
 static void amdgpu_connector_get_edid(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 	if (amdgpu_connector->edid)
@@ -463,7 +463,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
 					  uint64_t val)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
 
@@ -834,7 +834,7 @@ static enum drm_mode_status amdgpu_connector_vga_mode_valid(struct drm_connector
 					    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* XXX check mode bandwidth */
 
@@ -941,7 +941,7 @@ static bool
 amdgpu_connector_check_hpd_status_unchanged(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	enum drm_connector_status status;
 
@@ -972,7 +972,7 @@ static enum drm_connector_status
 amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	const struct drm_encoder_helper_funcs *encoder_funcs;
 	int r;
@@ -1159,7 +1159,7 @@ static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector
 					    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
 	/* XXX check mode bandwidth */
@@ -1311,7 +1311,7 @@ static bool amdgpu_connector_encoder_is_hbr2(struct drm_connector *connector)
 bool amdgpu_connector_is_dp12_capable(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if ((adev->clock.default_dispclk >= 53900) &&
 	    amdgpu_connector_encoder_is_hbr2(connector)) {
@@ -1325,7 +1325,7 @@ static enum drm_connector_status
 amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	enum drm_connector_status ret = connector_status_disconnected;
 	struct amdgpu_connector_atom_dig *amdgpu_dig_connector = amdgpu_connector->con_priv;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a94b3f862fc2..783cc45399e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1277,7 +1277,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	union drm_amdgpu_cs *cs = data;
 	struct amdgpu_cs_parser parser = {};
 	bool reserved_buffers = false;
@@ -1425,7 +1425,7 @@ static struct dma_fence *amdgpu_cs_get_fence(struct amdgpu_device *adev,
 int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 				    struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	union drm_amdgpu_fence_to_handle *info = data;
 	struct dma_fence *fence;
 	struct drm_syncobj *syncobj;
@@ -1601,7 +1601,7 @@ static int amdgpu_cs_wait_any_fence(struct amdgpu_device *adev,
 int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	union drm_amdgpu_wait_fences *wait = data;
 	uint32_t fence_count = wait->in.fence_count;
 	struct drm_amdgpu_fence *fences_user;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d85d13f7a043..6d6312aa47b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -389,7 +389,7 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 	enum drm_sched_priority priority;
 
 	union drm_amdgpu_ctx *args = data;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 
 	r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0af249a1e35b..c35671c95975 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1232,7 +1232,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int r = 0, i;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -1281,7 +1281,7 @@ static int amdgpu_debugfs_get_vbios_dump(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	seq_write(m, adev->bios, adev->bios_size);
 	return 0;
@@ -1291,7 +1291,7 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -1312,7 +1312,7 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe8878761c29..9ac2892131c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -132,7 +132,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint64_t cnt = amdgpu_asic_get_pcie_replay_count(adev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n", cnt);
@@ -157,7 +157,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_name);
 }
@@ -179,7 +179,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_number);
 }
@@ -201,7 +201,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
 }
@@ -219,7 +219,7 @@ static DEVICE_ATTR(serial_number, S_IRUGO,
  */
 bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (adev->flags & AMD_IS_PX)
 		return true;
@@ -236,7 +236,7 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
  */
 bool amdgpu_device_supports_baco(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	return amdgpu_asic_supports_baco(adev);
 }
@@ -3458,7 +3458,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		return -ENODEV;
 	}
 
-	adev = dev->dev_private;
+	adev = DRM_TO_ADEV(dev);
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -3546,7 +3546,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 {
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_crtc *crtc;
 	int r = 0;
 
@@ -4635,7 +4635,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 
 int amdgpu_device_baco_enter(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (!amdgpu_device_supports_baco(adev->ddev))
@@ -4649,7 +4649,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 
 int amdgpu_device_baco_exit(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 5179d5ff2259..4bb30f2a2680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -152,7 +152,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 				struct drm_modeset_acquire_ctx *ctx)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_gem_object *obj;
 	struct amdgpu_flip_work *work;
@@ -292,7 +292,7 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	pm_runtime_mark_last_busy(dev->dev);
 
-	adev = dev->dev_private;
+	adev = DRM_TO_ADEV(dev);
 	/* if we have active crtcs and we don't have a power ref,
 	   take the current one */
 	if (active && !adev->have_disp_power_ref) {
@@ -823,7 +823,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	int vbl_start, vbl_end, vtotal, ret = 0;
 	bool in_vbl = true;
 
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
 
@@ -953,7 +953,7 @@ int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *filp)
 {
 	int ret = -EPERM;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (adev->mode_info.funcs->notify_freesync)
 		ret = adev->mode_info.funcs->notify_freesync(dev,data,filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ffeb20f11c07..8cbb43ddd48e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -420,7 +420,7 @@ static struct drm_gem_object *
 amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 {
 	struct dma_resv *resv = dma_buf->resv;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_param bp;
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c1219af2e7d6..a887460bbb02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1167,7 +1167,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	} else if (ret)
 		goto err_pci;
 
-	adev = dev->dev_private;
+	adev = DRM_TO_ADEV(dev);
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
@@ -1201,7 +1201,7 @@ static void
 amdgpu_pci_shutdown(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (amdgpu_ras_intr_triggered())
 		return;
@@ -1234,7 +1234,7 @@ static int amdgpu_pmops_resume(struct device *dev)
 static int amdgpu_pmops_freeze(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(drm_dev);
 	int r;
 
 	adev->in_hibernate = true;
@@ -1270,7 +1270,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct amdgpu_device *adev = drm_dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(drm_dev);
 	int ret, i;
 
 	if (!adev->runpm) {
@@ -1321,7 +1321,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct amdgpu_device *adev = drm_dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(drm_dev);
 	int ret;
 
 	if (!adev->runpm)
@@ -1357,7 +1357,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 static int amdgpu_pmops_runtime_idle(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(drm_dev);
 	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
 	int ret = 1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index 61fcf247a638..239ca52f7f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -35,7 +35,7 @@
 void
 amdgpu_link_encoder_connector(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 58d4c219178a..68ba263f4611 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -700,7 +700,7 @@ static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int i;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -749,7 +749,7 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ee1e8fff83b2..292c7a505b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -216,7 +216,7 @@ void amdgpu_gem_object_close(struct drm_gem_object *obj,
 int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 	union drm_amdgpu_gem_create *args = data;
@@ -297,7 +297,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *filp)
 {
 	struct ttm_operation_ctx ctx = { true, false };
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_amdgpu_gem_userptr *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
@@ -586,7 +586,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	struct drm_amdgpu_gem_va *args = data;
 	struct drm_gem_object *gobj;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_bo *abo;
 	struct amdgpu_bo_va *bo_va;
@@ -714,7 +714,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -791,7 +791,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_gem_object *gobj;
 	uint32_t handle;
 	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index bc01a06546aa..e2fe43130e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -47,7 +47,7 @@ static ssize_t amdgpu_mem_info_gtt_total_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(adev->mman.bdev.man[TTM_PL_TT].size) * PAGE_SIZE);
@@ -65,7 +65,7 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			amdgpu_gtt_mgr_usage(&adev->mman.bdev.man[TTM_PL_TT]));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 70dbe343f51d..da7449ab0595 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -40,7 +40,7 @@
 static int amdgpu_i2c_pre_xfer(struct i2c_adapter *i2c_adap)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_get_adapdata(i2c_adap);
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t temp;
 
@@ -82,7 +82,7 @@ static int amdgpu_i2c_pre_xfer(struct i2c_adapter *i2c_adap)
 static void amdgpu_i2c_post_xfer(struct i2c_adapter *i2c_adap)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_get_adapdata(i2c_adap);
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t temp;
 
@@ -101,7 +101,7 @@ static void amdgpu_i2c_post_xfer(struct i2c_adapter *i2c_adap)
 static int amdgpu_i2c_get_clock(void *i2c_priv)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_priv;
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t val;
 
@@ -116,7 +116,7 @@ static int amdgpu_i2c_get_clock(void *i2c_priv)
 static int amdgpu_i2c_get_data(void *i2c_priv)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_priv;
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t val;
 
@@ -130,7 +130,7 @@ static int amdgpu_i2c_get_data(void *i2c_priv)
 static void amdgpu_i2c_set_clock(void *i2c_priv, int clock)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_priv;
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t val;
 
@@ -143,7 +143,7 @@ static void amdgpu_i2c_set_clock(void *i2c_priv, int clock)
 static void amdgpu_i2c_set_data(void *i2c_priv, int data)
 {
 	struct amdgpu_i2c_chan *i2c = i2c_priv;
-	struct amdgpu_device *adev = i2c->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(i2c->dev);
 	struct amdgpu_i2c_bus_rec *rec = &i2c->rec;
 	uint32_t val;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index dcd492170598..66a76b19fbee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -445,7 +445,7 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	seq_printf(m, "--------------------- DELAYED --------------------- \n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0cc4c67f95f7..422491eb8042 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -151,7 +151,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 irqreturn_t amdgpu_irq_handler(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *) arg;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	irqreturn_t ret;
 
 	ret = amdgpu_ih_process(adev, &adev->irq.ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f8de949d2510..8335f831fdf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -78,7 +78,7 @@ void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
  */
 void amdgpu_driver_unload_kms(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (adev == NULL)
 		return;
@@ -479,7 +479,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
  */
 static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_amdgpu_info *info = data;
 	struct amdgpu_mode_info *minfo = &adev->mode_info;
 	void __user *out = (void __user *)(uintptr_t)info->return_pointer;
@@ -992,7 +992,7 @@ void amdgpu_driver_lastclose_kms(struct drm_device *dev)
  */
 int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv;
 	int r, pasid;
 
@@ -1077,7 +1077,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 void amdgpu_driver_postclose_kms(struct drm_device *dev,
 				 struct drm_file *file_priv)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct amdgpu_bo_list *list;
 	struct amdgpu_bo *pd;
@@ -1146,7 +1146,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = crtc->index;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int vpos, hpos, stat;
 	u32 count;
 
@@ -1214,7 +1214,7 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = crtc->index;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int idx = amdgpu_display_crtc_idx_to_irq_type(adev, pipe);
 
 	return amdgpu_irq_get(adev, &adev->crtc_irq, idx);
@@ -1231,7 +1231,7 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = crtc->index;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int idx = amdgpu_display_crtc_idx_to_irq_type(adev, pipe);
 
 	amdgpu_irq_put(adev, &adev->crtc_irq, idx);
@@ -1268,7 +1268,7 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 1705e328c6fc..4a7a37e21201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -159,7 +159,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 					  char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	enum amd_pm_state_type pm;
 	int ret;
 
@@ -201,7 +201,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 					  size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	enum amd_pm_state_type  state;
 	int ret;
 
@@ -312,7 +312,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 							    char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
@@ -357,7 +357,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 							    size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
@@ -471,7 +471,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
@@ -513,7 +513,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	struct pp_states_info data;
 	struct smu_context *smu = &adev->smu;
 	enum amd_pm_state_type pm = 0;
@@ -558,7 +558,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -575,7 +575,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	enum amd_pm_state_type state = 0;
 	unsigned long idx;
 	int ret;
@@ -639,7 +639,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	char *table = NULL;
 	int size, ret;
 
@@ -684,7 +684,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -835,7 +835,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t parameter_size = 0;
 	long parameter[64];
@@ -945,7 +945,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -999,7 +999,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 				      size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint64_t featuremask;
 	int ret;
 
@@ -1049,7 +1049,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 				      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1114,7 +1114,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1186,7 +1186,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t mask = 0;
 
@@ -1226,7 +1226,7 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1262,7 +1262,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t mask = 0;
 	int ret;
 
@@ -1302,7 +1302,7 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1338,7 +1338,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t mask = 0;
 
@@ -1380,7 +1380,7 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1416,7 +1416,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t mask = 0;
 
@@ -1458,7 +1458,7 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1494,7 +1494,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t mask = 0;
 
@@ -1536,7 +1536,7 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1572,7 +1572,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	uint32_t mask = 0;
 
@@ -1614,7 +1614,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t value = 0;
 	int ret;
 
@@ -1648,7 +1648,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	long int value;
 
@@ -1695,7 +1695,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t value = 0;
 	int ret;
 
@@ -1729,7 +1729,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 		size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int ret;
 	long int value;
 
@@ -1796,7 +1796,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	ssize_t size;
 	int ret;
 
@@ -1834,7 +1834,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 {
 	int ret;
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t parameter_size = 0;
 	long parameter[64];
 	char *sub_str, buf_cpy[128];
@@ -1909,7 +1909,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 					   char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int r, value, size = sizeof(value);
 
 	if (amdgpu_in_reset(adev))
@@ -1949,7 +1949,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 					   char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	int r, value, size = sizeof(value);
 
 	if (amdgpu_in_reset(adev))
@@ -1995,7 +1995,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
@@ -2042,7 +2042,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 		char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -2073,7 +2073,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
 						     char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%s: thermal throttling logging %s, with interval %d seconds\n",
 			adev->ddev->unique,
@@ -2087,7 +2087,7 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 						     size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	long throttling_logging_interval;
 	unsigned long flags;
 	int ret = 0;
@@ -2137,7 +2137,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 				      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
@@ -4184,7 +4184,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 flags = 0;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 116a89990f39..4e8ec7c9fad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2604,7 +2604,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 					 char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t fw_ver;
 	int ret;
 
@@ -2631,7 +2631,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 						       size_t count)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	void *cpu_addr;
 	dma_addr_t dma_addr;
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index c799691dfa84..3d296cef92c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -115,7 +115,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
 	union drm_amdgpu_sched *args = data;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	enum drm_sched_priority priority;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 20fa0497aaa4..6f1f982684c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2139,7 +2139,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv = filp->private_data;
-	struct amdgpu_device *adev = file_priv->minor->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(file_priv->minor->dev);
 
 	if (adev == NULL)
 		return -EINVAL;
@@ -2320,7 +2320,7 @@ static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	unsigned ttm_pl = (uintptr_t)node->info_ent->data;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct ttm_mem_type_manager *man = &adev->mman.bdev.man[ttm_pl];
 	struct drm_printer p = drm_seq_file_printer(m);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 039245c98ff8..887d4645b32b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -408,7 +408,7 @@ static ssize_t show_##name(struct device *dev,				\
 			  char *buf)					\
 {									\
 	struct drm_device *ddev = dev_get_drvdata(dev);			\
-	struct amdgpu_device *adev = ddev->dev_private;			\
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);			\
 									\
 	return snprintf(buf, PAGE_SIZE, "0x%08x\n", adev->field);	\
 }									\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71e005cf2952..f93316bade94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3209,7 +3209,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	union drm_amdgpu_vm *args = data;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	long timeout = msecs_to_jiffies(2000);
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 9b03fadc42fb..2b7f103aa872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -46,7 +46,7 @@ static ssize_t amdgpu_mem_info_vram_total_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.real_vram_size);
 }
@@ -63,7 +63,7 @@ static ssize_t amdgpu_mem_info_vis_vram_total_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.visible_vram_size);
 }
@@ -80,7 +80,7 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 		amdgpu_vram_mgr_usage(&adev->mman.bdev.man[TTM_PL_VRAM]));
@@ -98,7 +98,7 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 		amdgpu_vram_mgr_vis_usage(&adev->mman.bdev.man[TTM_PL_VRAM]));
@@ -109,7 +109,7 @@ static ssize_t amdgpu_mem_info_vram_vendor(struct device *dev,
 						 char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	switch (adev->gmc.vram_vendor) {
 	case SAMSUNG:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 67a756f4337b..63e258f7ba99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -229,7 +229,7 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 				     char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	return snprintf(buf, PAGE_SIZE, "%llu\n", adev->gmc.xgmi.node_id);
 
@@ -241,7 +241,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 				      char *buf)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 	uint32_t ficaa_pie_ctl_in, ficaa_pie_status_in;
 	uint64_t fica_out;
 	unsigned int error_count = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
index 213e62a28ba0..81f53cd4f91b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
@@ -41,7 +41,7 @@ void amdgpu_atombios_crtc_overscan_setup(struct drm_crtc *crtc,
 				  struct drm_display_mode *adjusted_mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	SET_CRTC_OVERSCAN_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, SetCRTC_OverScan);
@@ -84,7 +84,7 @@ void amdgpu_atombios_crtc_overscan_setup(struct drm_crtc *crtc,
 void amdgpu_atombios_crtc_scaler_setup(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	ENABLE_SCALER_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, EnableScaler);
@@ -114,7 +114,7 @@ void amdgpu_atombios_crtc_lock(struct drm_crtc *crtc, int lock)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int index =
 	    GetIndexIntoMasterTable(COMMAND, UpdateCRTC_DoubleBufferRegisters);
 	ENABLE_CRTC_PS_ALLOCATION args;
@@ -131,7 +131,7 @@ void amdgpu_atombios_crtc_enable(struct drm_crtc *crtc, int state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int index = GetIndexIntoMasterTable(COMMAND, EnableCRTC);
 	ENABLE_CRTC_PS_ALLOCATION args;
 
@@ -147,7 +147,7 @@ void amdgpu_atombios_crtc_blank(struct drm_crtc *crtc, int state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int index = GetIndexIntoMasterTable(COMMAND, BlankCRTC);
 	BLANK_CRTC_PS_ALLOCATION args;
 
@@ -163,7 +163,7 @@ void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int index = GetIndexIntoMasterTable(COMMAND, EnableDispPowerGating);
 	ENABLE_DISP_POWER_GATING_PS_ALLOCATION args;
 
@@ -192,7 +192,7 @@ void amdgpu_atombios_crtc_set_dtd_timing(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	SET_CRTC_USING_DTD_TIMING_PARAMETERS args;
 	int index = GetIndexIntoMasterTable(COMMAND, SetCRTC_UsingDTDTiming);
 	u16 misc = 0;
@@ -307,7 +307,7 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_encoder *encoder = amdgpu_crtc->encoder;
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -588,7 +588,7 @@ void amdgpu_atombios_crtc_program_pll(struct drm_crtc *crtc,
 				      struct amdgpu_atom_ss *ss)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u8 frev, crev;
 	int index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
 	union set_pixel_clock args;
@@ -749,7 +749,7 @@ int amdgpu_atombios_crtc_prepare_pll(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder =
 		to_amdgpu_encoder(amdgpu_crtc->encoder);
 	int encoder_mode = amdgpu_atombios_encoder_get_encoder_mode(amdgpu_crtc->encoder);
@@ -818,7 +818,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc *crtc, struct drm_display_mode
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder =
 		to_amdgpu_encoder(amdgpu_crtc->encoder);
 	u32 pll_clock = mode->clock;
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 9b74cfdba7b8..01ce18b60c0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -60,7 +60,7 @@ static int amdgpu_atombios_dp_process_aux_ch(struct amdgpu_i2c_chan *chan,
 				      u8 delay, u8 *ack)
 {
 	struct drm_device *dev = chan->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	union aux_channel_transaction args;
 	int index = GetIndexIntoMasterTable(COMMAND, ProcessAuxChannelTransaction);
 	unsigned char *base;
@@ -305,7 +305,7 @@ static u8 amdgpu_atombios_dp_encoder_service(struct amdgpu_device *adev,
 u8 amdgpu_atombios_dp_get_sinktype(struct amdgpu_connector *amdgpu_connector)
 {
 	struct drm_device *dev = amdgpu_connector->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	return amdgpu_atombios_dp_encoder_service(adev, ATOM_DP_ACTION_GET_SINK_TYPE, 0,
 					   amdgpu_connector->ddc_bus->rec.i2c_id, 0);
@@ -702,7 +702,7 @@ void amdgpu_atombios_dp_link_train(struct drm_encoder *encoder,
 			    struct drm_connector *connector)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_connector *amdgpu_connector;
 	struct amdgpu_connector_atom_dig *dig_connector;
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 1e94a9b652f7..3effe97f4fca 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -70,7 +70,7 @@ u8
 amdgpu_atombios_encoder_get_backlight_level(struct amdgpu_encoder *amdgpu_encoder)
 {
 	struct drm_device *dev = amdgpu_encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
 		return 0;
@@ -84,7 +84,7 @@ amdgpu_atombios_encoder_set_backlight_level(struct amdgpu_encoder *amdgpu_encode
 {
 	struct drm_encoder *encoder = &amdgpu_encoder->base;
 	struct drm_device *dev = amdgpu_encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder_atom_dig *dig;
 
 	if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
@@ -152,7 +152,7 @@ amdgpu_atombios_encoder_get_backlight_brightness(struct backlight_device *bd)
 	struct amdgpu_backlight_privdata *pdata = bl_get_data(bd);
 	struct amdgpu_encoder *amdgpu_encoder = pdata->encoder;
 	struct drm_device *dev = amdgpu_encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	return amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 }
@@ -166,7 +166,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 				     struct drm_connector *drm_connector)
 {
 	struct drm_device *dev = amdgpu_encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct backlight_device *bd;
 	struct backlight_properties props;
 	struct amdgpu_backlight_privdata *pdata;
@@ -229,7 +229,7 @@ void
 amdgpu_atombios_encoder_fini_backlight(struct amdgpu_encoder *amdgpu_encoder)
 {
 	struct drm_device *dev = amdgpu_encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct backlight_device *bd = NULL;
 	struct amdgpu_encoder_atom_dig *dig;
 
@@ -319,7 +319,7 @@ static void
 amdgpu_atombios_encoder_setup_dac(struct drm_encoder *encoder, int action)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	DAC_ENCODER_CONTROL_PS_ALLOCATION args;
 	int index = 0;
@@ -382,7 +382,7 @@ static void
 amdgpu_atombios_encoder_setup_dvo(struct drm_encoder *encoder, int action)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	union dvo_encoder_control args;
 	int index = GetIndexIntoMasterTable(COMMAND, DVOEncoderControl);
@@ -573,7 +573,7 @@ amdgpu_atombios_encoder_setup_dig_encoder(struct drm_encoder *encoder,
 				   int action, int panel_mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -762,7 +762,7 @@ amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder *encoder, int a
 					      uint8_t lane_num, uint8_t lane_set)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1178,7 +1178,7 @@ amdgpu_atombios_encoder_set_edp_panel_power(struct drm_connector *connector,
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	struct drm_device *dev = amdgpu_connector->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	union dig_transmitter_control args;
 	int index = GetIndexIntoMasterTable(COMMAND, UNIPHYTransmitterControl);
 	uint8_t frev, crev;
@@ -1225,7 +1225,7 @@ amdgpu_atombios_encoder_setup_external_encoder(struct drm_encoder *encoder,
 					int action)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder *ext_amdgpu_encoder = to_amdgpu_encoder(ext_encoder);
 	union external_encoder_control args;
@@ -1466,7 +1466,7 @@ void
 amdgpu_atombios_encoder_set_crtc_source(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
 	union crtc_source_param args;
@@ -1701,7 +1701,7 @@ amdgpu_atombios_encoder_dac_load_detect(struct drm_encoder *encoder,
 				 struct drm_connector *connector)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
@@ -1751,7 +1751,7 @@ amdgpu_atombios_encoder_dac_detect(struct drm_encoder *encoder,
 			    struct drm_connector *connector)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	uint32_t bios_0_scratch;
@@ -1790,7 +1790,7 @@ amdgpu_atombios_encoder_dig_detect(struct drm_encoder *encoder,
 			    struct drm_connector *connector)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	struct drm_encoder *ext_encoder = amdgpu_get_external_encoder(encoder);
@@ -1848,7 +1848,7 @@ amdgpu_atombios_encoder_set_bios_scratch_regs(struct drm_connector *connector,
 				       bool connected)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_connector *amdgpu_connector =
 	    to_amdgpu_connector(connector);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -1999,7 +1999,7 @@ struct amdgpu_encoder_atom_dig *
 amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 {
 	struct drm_device *dev = encoder->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
 	int index = GetIndexIntoMasterTable(DATA, LVDS_Info);
 	uint16_t data_offset, misc;
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
index b4cc7c55fa16..ced8d4929d72 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
@@ -40,7 +40,7 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
 				       u8 *buf, u8 num)
 {
 	struct drm_device *dev = chan->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	PROCESS_I2C_CHANNEL_TRANSACTION_PS_ALLOCATION args;
 	int index = GetIndexIntoMasterTable(COMMAND, ProcessI2cChannelTransaction);
 	unsigned char *base;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index e38744d06f4e..67f85b74c392 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -504,7 +504,7 @@ void dce_v10_0_disable_dce(struct amdgpu_device *adev)
 static void dce_v10_0_program_fmt(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1209,7 +1209,7 @@ static struct amdgpu_audio_pin *dce_v10_0_audio_get_pin(struct amdgpu_device *ad
 
 static void dce_v10_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1226,7 +1226,7 @@ static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1272,7 +1272,7 @@ static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1328,7 +1328,7 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1483,7 +1483,7 @@ static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 static void dce_v10_0_afmt_update_ACR(struct drm_encoder *encoder, uint32_t clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
@@ -1519,7 +1519,7 @@ static void dce_v10_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 					       void *buffer, size_t size)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	uint8_t *frame = buffer + 3;
@@ -1538,7 +1538,7 @@ static void dce_v10_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 static void dce_v10_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
@@ -1569,7 +1569,7 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1749,7 +1749,7 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 static void dce_v10_0_afmt_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 
@@ -1822,7 +1822,7 @@ static void dce_v10_0_vga_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 vga_control;
 
 	vga_control = RREG32(vga_control_regs[amdgpu_crtc->crtc_id]) & ~1;
@@ -1836,7 +1836,7 @@ static void dce_v10_0_grph_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (enable)
 		WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, 1);
@@ -1850,7 +1850,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_framebuffer *target_fb;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *abo;
@@ -2095,7 +2095,7 @@ static void dce_v10_0_set_interleave(struct drm_crtc *crtc,
 				     struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	u32 tmp;
 
@@ -2111,7 +2111,7 @@ static void dce_v10_0_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u16 *r, *g, *b;
 	int i;
 	u32 tmp;
@@ -2250,7 +2250,7 @@ static u32 dce_v10_0_pick_pll(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 pll_in_use;
 	int pll;
 
@@ -2285,7 +2285,7 @@ static u32 dce_v10_0_pick_pll(struct drm_crtc *crtc)
 
 static void dce_v10_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint32_t cur_lock;
 
@@ -2300,7 +2300,7 @@ static void dce_v10_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 static void dce_v10_0_hide_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	u32 tmp;
 
 	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
@@ -2311,7 +2311,7 @@ static void dce_v10_0_hide_cursor(struct drm_crtc *crtc)
 static void dce_v10_0_show_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	u32 tmp;
 
 	WREG32(mmCUR_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_offset,
@@ -2329,7 +2329,7 @@ static int dce_v10_0_cursor_move_locked(struct drm_crtc *crtc,
 					int x, int y)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	int xorigin = 0, yorigin = 0;
 
 	amdgpu_crtc->cursor_x = x;
@@ -2503,7 +2503,7 @@ static const struct drm_crtc_funcs dce_v10_0_crtc_funcs = {
 static void dce_v10_0_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
@@ -2557,7 +2557,7 @@ static void dce_v10_0_crtc_disable(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_atom_ss ss;
 	int i;
 
@@ -3345,7 +3345,7 @@ dce_v10_0_encoder_mode_set(struct drm_encoder *encoder,
 
 static void dce_v10_0_encoder_prepare(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
 
@@ -3385,7 +3385,7 @@ static void dce_v10_0_encoder_prepare(struct drm_encoder *encoder)
 static void dce_v10_0_encoder_commit(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* need to call this here as we need the crtc set up */
 	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 0a6be88ebad9..2c61e0874b32 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -530,7 +530,7 @@ void dce_v11_0_disable_dce(struct amdgpu_device *adev)
 static void dce_v11_0_program_fmt(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1235,7 +1235,7 @@ static struct amdgpu_audio_pin *dce_v11_0_audio_get_pin(struct amdgpu_device *ad
 
 static void dce_v11_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1252,7 +1252,7 @@ static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1298,7 +1298,7 @@ static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1354,7 +1354,7 @@ static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1525,7 +1525,7 @@ static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 static void dce_v11_0_afmt_update_ACR(struct drm_encoder *encoder, uint32_t clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
@@ -1561,7 +1561,7 @@ static void dce_v11_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 					       void *buffer, size_t size)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	uint8_t *frame = buffer + 3;
@@ -1580,7 +1580,7 @@ static void dce_v11_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 static void dce_v11_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
@@ -1611,7 +1611,7 @@ static void dce_v11_0_afmt_setmode(struct drm_encoder *encoder,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1791,7 +1791,7 @@ static void dce_v11_0_afmt_setmode(struct drm_encoder *encoder,
 static void dce_v11_0_afmt_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 
@@ -1864,7 +1864,7 @@ static void dce_v11_0_vga_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 vga_control;
 
 	vga_control = RREG32(vga_control_regs[amdgpu_crtc->crtc_id]) & ~1;
@@ -1878,7 +1878,7 @@ static void dce_v11_0_grph_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (enable)
 		WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, 1);
@@ -1892,7 +1892,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_framebuffer *target_fb;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *abo;
@@ -2137,7 +2137,7 @@ static void dce_v11_0_set_interleave(struct drm_crtc *crtc,
 				     struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	u32 tmp;
 
@@ -2153,7 +2153,7 @@ static void dce_v11_0_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u16 *r, *g, *b;
 	int i;
 	u32 tmp;
@@ -2283,7 +2283,7 @@ static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 pll_in_use;
 	int pll;
 
@@ -2364,7 +2364,7 @@ static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
 
 static void dce_v11_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint32_t cur_lock;
 
@@ -2379,7 +2379,7 @@ static void dce_v11_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 static void dce_v11_0_hide_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	u32 tmp;
 
 	tmp = RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
@@ -2390,7 +2390,7 @@ static void dce_v11_0_hide_cursor(struct drm_crtc *crtc)
 static void dce_v11_0_show_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	u32 tmp;
 
 	WREG32(mmCUR_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_offset,
@@ -2408,7 +2408,7 @@ static int dce_v11_0_cursor_move_locked(struct drm_crtc *crtc,
 					int x, int y)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	int xorigin = 0, yorigin = 0;
 
 	amdgpu_crtc->cursor_x = x;
@@ -2582,7 +2582,7 @@ static const struct drm_crtc_funcs dce_v11_0_crtc_funcs = {
 static void dce_v11_0_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
@@ -2636,7 +2636,7 @@ static void dce_v11_0_crtc_disable(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_atom_ss ss;
 	int i;
 
@@ -2706,7 +2706,7 @@ static int dce_v11_0_crtc_mode_set(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (!amdgpu_crtc->adjusted_clock)
 		return -EINVAL;
@@ -3471,7 +3471,7 @@ dce_v11_0_encoder_mode_set(struct drm_encoder *encoder,
 
 static void dce_v11_0_encoder_prepare(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
 
@@ -3511,7 +3511,7 @@ static void dce_v11_0_encoder_prepare(struct drm_encoder *encoder)
 static void dce_v11_0_encoder_commit(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* need to call this here as we need the crtc set up */
 	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index d05c39f9ae40..cf3e7062524f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -401,7 +401,7 @@ static void dce_v6_0_program_fmt(struct drm_encoder *encoder)
 {
 
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
@@ -1114,7 +1114,7 @@ static struct amdgpu_audio_pin *dce_v6_0_audio_get_pin(struct amdgpu_device *ade
 
 static void dce_v6_0_audio_select_pin(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 
@@ -1130,7 +1130,7 @@ static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1174,7 +1174,7 @@ static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encoder,
 static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1235,7 +1235,7 @@ static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1392,7 +1392,7 @@ static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 static void dce_v6_0_audio_set_vbi_packet(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1408,7 +1408,7 @@ static void dce_v6_0_audio_set_acr(struct drm_encoder *encoder,
 				   uint32_t clock, int bpc)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
@@ -1446,7 +1446,7 @@ static void dce_v6_0_audio_set_avi_infoframe(struct drm_encoder *encoder,
 					       struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1488,7 +1488,7 @@ static void dce_v6_0_audio_set_avi_infoframe(struct drm_encoder *encoder,
 static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
 	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
 	u32 tmp;
@@ -1522,7 +1522,7 @@ static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 static void dce_v6_0_audio_set_packet(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1566,7 +1566,7 @@ static void dce_v6_0_audio_set_packet(struct drm_encoder *encoder)
 static void dce_v6_0_audio_set_mute(struct drm_encoder *encoder, bool mute)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1579,7 +1579,7 @@ static void dce_v6_0_audio_set_mute(struct drm_encoder *encoder, bool mute)
 static void dce_v6_0_audio_hdmi_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1616,7 +1616,7 @@ static void dce_v6_0_audio_hdmi_enable(struct drm_encoder *encoder, bool enable)
 static void dce_v6_0_audio_dp_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 tmp;
@@ -1645,7 +1645,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1714,7 +1714,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 
@@ -1788,7 +1788,7 @@ static void dce_v6_0_vga_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 vga_control;
 
 	vga_control = RREG32(vga_control_regs[amdgpu_crtc->crtc_id]) & ~1;
@@ -1799,7 +1799,7 @@ static void dce_v6_0_grph_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, enable ? 1 : 0);
 }
@@ -1810,7 +1810,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_framebuffer *target_fb;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *abo;
@@ -2033,7 +2033,7 @@ static void dce_v6_0_set_interleave(struct drm_crtc *crtc,
 				    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
@@ -2048,7 +2048,7 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u16 *r, *g, *b;
 	int i;
 
@@ -2148,7 +2148,7 @@ static u32 dce_v6_0_pick_pll(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 pll_in_use;
 	int pll;
 
@@ -2177,7 +2177,7 @@ static u32 dce_v6_0_pick_pll(struct drm_crtc *crtc)
 
 static void dce_v6_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint32_t cur_lock;
 
@@ -2192,7 +2192,7 @@ static void dce_v6_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 static void dce_v6_0_hide_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 
 	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
 	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
@@ -2204,7 +2204,7 @@ static void dce_v6_0_hide_cursor(struct drm_crtc *crtc)
 static void dce_v6_0_show_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 
 	WREG32(mmCUR_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_offset,
 	       upper_32_bits(amdgpu_crtc->cursor_addr));
@@ -2222,7 +2222,7 @@ static int dce_v6_0_cursor_move_locked(struct drm_crtc *crtc,
 				       int x, int y)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	int xorigin = 0, yorigin = 0;
 
 	int w = amdgpu_crtc->cursor_width;
@@ -2397,7 +2397,7 @@ static const struct drm_crtc_funcs dce_v6_0_crtc_funcs = {
 static void dce_v6_0_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
@@ -2447,7 +2447,7 @@ static void dce_v6_0_crtc_disable(struct drm_crtc *crtc)
 
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_atom_ss ss;
 	int i;
 
@@ -3146,7 +3146,7 @@ dce_v6_0_encoder_mode_set(struct drm_encoder *encoder,
 static void dce_v6_0_encoder_prepare(struct drm_encoder *encoder)
 {
 
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
 
@@ -3187,7 +3187,7 @@ static void dce_v6_0_encoder_commit(struct drm_encoder *encoder)
 {
 
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* need to call this here as we need the crtc set up */
 	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index ad0f8adb6a2b..db6d23c85a7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -444,7 +444,7 @@ void dce_v8_0_disable_dce(struct amdgpu_device *adev)
 static void dce_v8_0_program_fmt(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1146,7 +1146,7 @@ static struct amdgpu_audio_pin *dce_v8_0_audio_get_pin(struct amdgpu_device *ade
 
 static void dce_v8_0_afmt_audio_select_pin(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 offset;
@@ -1164,7 +1164,7 @@ static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 						struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1225,7 +1225,7 @@ static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector;
@@ -1278,7 +1278,7 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	u32 offset;
@@ -1446,7 +1446,7 @@ static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 static void dce_v8_0_afmt_update_ACR(struct drm_encoder *encoder, uint32_t clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
@@ -1469,7 +1469,7 @@ static void dce_v8_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 					       void *buffer, size_t size)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	uint32_t offset = dig->afmt->offset;
@@ -1489,7 +1489,7 @@ static void dce_v8_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 static void dce_v8_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
@@ -1516,7 +1516,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -1678,7 +1678,7 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 static void dce_v8_0_afmt_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
 
@@ -1751,7 +1751,7 @@ static void dce_v8_0_vga_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 vga_control;
 
 	vga_control = RREG32(vga_control_regs[amdgpu_crtc->crtc_id]) & ~1;
@@ -1765,7 +1765,7 @@ static void dce_v8_0_grph_enable(struct drm_crtc *crtc, bool enable)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	if (enable)
 		WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, 1);
@@ -1779,7 +1779,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_framebuffer *target_fb;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *abo;
@@ -2004,7 +2004,7 @@ static void dce_v8_0_set_interleave(struct drm_crtc *crtc,
 				    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
@@ -2018,7 +2018,7 @@ static void dce_v8_0_crtc_load_lut(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u16 *r, *g, *b;
 	int i;
 
@@ -2140,7 +2140,7 @@ static u32 dce_v8_0_pick_pll(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	u32 pll_in_use;
 	int pll;
 
@@ -2188,7 +2188,7 @@ static u32 dce_v8_0_pick_pll(struct drm_crtc *crtc)
 
 static void dce_v8_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint32_t cur_lock;
 
@@ -2203,7 +2203,7 @@ static void dce_v8_0_lock_cursor(struct drm_crtc *crtc, bool lock)
 static void dce_v8_0_hide_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 
 	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
 	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
@@ -2213,7 +2213,7 @@ static void dce_v8_0_hide_cursor(struct drm_crtc *crtc)
 static void dce_v8_0_show_cursor(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 
 	WREG32(mmCUR_SURFACE_ADDRESS_HIGH + amdgpu_crtc->crtc_offset,
 	       upper_32_bits(amdgpu_crtc->cursor_addr));
@@ -2230,7 +2230,7 @@ static int dce_v8_0_cursor_move_locked(struct drm_crtc *crtc,
 				       int x, int y)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	int xorigin = 0, yorigin = 0;
 
 	amdgpu_crtc->cursor_x = x;
@@ -2404,7 +2404,7 @@ static const struct drm_crtc_funcs dce_v8_0_crtc_funcs = {
 static void dce_v8_0_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
@@ -2458,7 +2458,7 @@ static void dce_v8_0_crtc_disable(struct drm_crtc *crtc)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_atom_ss ss;
 	int i;
 
@@ -3233,7 +3233,7 @@ dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
 
 static void dce_v8_0_encoder_prepare(struct drm_encoder *encoder)
 {
-	struct amdgpu_device *adev = encoder->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
 
@@ -3273,7 +3273,7 @@ static void dce_v8_0_encoder_prepare(struct drm_encoder *encoder)
 static void dce_v8_0_encoder_commit(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	/* need to call this here as we need the crtc set up */
 	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index d5ff7b6331ff..873200b0ba80 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -132,7 +132,7 @@ static const struct drm_crtc_funcs dce_virtual_crtc_funcs = {
 static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct drm_device *dev = crtc->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
@@ -697,7 +697,7 @@ static enum hrtimer_restart dce_virtual_vblank_timer_handle(struct hrtimer *vbla
 	struct amdgpu_crtc *amdgpu_crtc = container_of(vblank_timer,
 						       struct amdgpu_crtc, vblank_timer);
 	struct drm_device *ddev = amdgpu_crtc->base.dev;
-	struct amdgpu_device *adev = ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
 
 	drm_handle_vblank(ddev, amdgpu_crtc->crtc_id);
 	dce_virtual_pageflip(adev, amdgpu_crtc->crtc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 0aa1ac1accd6..ee0104e72e18 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -251,7 +251,7 @@ static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
 	int i, count;
 
 	ddev = dev_get_drvdata(dev);
-	adev = ddev->dev_private;
+	adev = DRM_TO_ADEV(ddev);
 	count = 0;
 
 	for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ff5f7f7ceec6..e8ca41c848aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -544,7 +544,7 @@ static int dm_early_init(void* handle);
 static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct dm_comressor_info *compressor = &adev->dm.compressor;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode;
@@ -586,7 +586,7 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 					  unsigned char *buf, int max_bytes)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	struct amdgpu_dm_connector *aconnector;
@@ -625,7 +625,7 @@ static int amdgpu_dm_audio_component_bind(struct device *kdev,
 				       struct device *hda_kdev, void *data)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_audio_component *acomp = data;
 
 	acomp->ops = &amdgpu_dm_audio_component_ops;
@@ -639,7 +639,7 @@ static void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct drm_audio_component *acomp = data;
 
 	acomp->ops = NULL;
@@ -2050,7 +2050,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		return;
 
 	conn_base = &aconnector->base;
-	adev = conn_base->dev->dev_private;
+	adev = DRM_TO_ADEV(conn_base->dev);
 	dm = &adev->dm;
 	caps = &dm->backlight_caps;
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
@@ -2239,7 +2239,7 @@ static void handle_hpd_irq(void *param)
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 #endif
 
 	/*
@@ -2372,7 +2372,7 @@ static void handle_hpd_rx_irq(void *param)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	union hpd_irq_data hpd_irq_data;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 #endif
@@ -2793,7 +2793,7 @@ static int dm_atomic_get_state(struct drm_atomic_state *state,
 			       struct dm_atomic_state **dm_state)
 {
 	struct drm_device *dev = state->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct drm_private_state *priv_state;
 
@@ -2813,7 +2813,7 @@ static struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct drm_private_obj *obj;
 	struct drm_private_state *new_obj_state;
@@ -3460,7 +3460,7 @@ static ssize_t s3_debug_store(struct device *device,
 	int ret;
 	int s3_state;
 	struct drm_device *drm_dev = dev_get_drvdata(device);
-	struct amdgpu_device *adev = drm_dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(drm_dev);
 
 	ret = kstrtoint(buf, 0, &s3_state);
 
@@ -4854,7 +4854,7 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 {
 	enum dc_irq_source irq_source;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	int rc;
 
 	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
@@ -4870,7 +4870,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 {
 	enum dc_irq_source irq_source;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	int rc = 0;
 
@@ -4947,7 +4947,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 					    uint64_t val)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct dm_connector_state *dm_old_state =
 		to_dm_connector_state(connector->state);
 	struct dm_connector_state *dm_new_state =
@@ -5008,7 +5008,7 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 					    uint64_t *val)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct dm_connector_state *dm_state =
 		to_dm_connector_state(state);
 	int ret = -EINVAL;
@@ -5064,7 +5064,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	const struct dc_link *link = aconnector->dc_link;
-	struct amdgpu_device *adev = connector->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(connector->dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
@@ -5250,7 +5250,7 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				const struct dc_stream_state *old_stream)
 {
 	struct drm_connector *connector = &aconnector->base;
-	struct amdgpu_device *adev = connector->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(connector->dev);
 	struct dc_stream_state *stream;
 	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
@@ -5527,7 +5527,7 @@ static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
 static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 				       struct drm_crtc_state *state)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct dc *dc = adev->dm.dc;
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(state);
 	int ret = -EINVAL;
@@ -5899,7 +5899,7 @@ static int dm_plane_helper_check_state(struct drm_plane_state *state,
 static int dm_plane_atomic_check(struct drm_plane *plane,
 				 struct drm_plane_state *state)
 {
-	struct amdgpu_device *adev = plane->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(plane->dev);
 	struct dc *dc = adev->dm.dc;
 	struct dm_plane_state *dm_plane_state;
 	struct dc_scaling_info scaling_info;
@@ -6374,7 +6374,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct dc_link *link,
 				     int link_index)
 {
-	struct amdgpu_device *adev = dm->ddev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dm->ddev);
 
 	/*
 	 * Some of the properties below require access to state, like bpc.
@@ -6629,7 +6629,7 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 				  struct amdgpu_encoder *aencoder,
 				  uint32_t link_index)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 
 	int res = drm_encoder_init(dev,
 				   &aencoder->base,
@@ -6814,7 +6814,7 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 static void handle_cursor_update(struct drm_plane *plane,
 				 struct drm_plane_state *old_plane_state)
 {
-	struct amdgpu_device *adev = plane->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
 	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
 	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
@@ -7351,9 +7351,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * on some ASICs).
 		 */
 		if (dm_old_crtc_state->active_planes != acrtc_state->active_planes)
-			dm_update_pflip_irq_state(
-				(struct amdgpu_device *)dev->dev_private,
-				acrtc_attach);
+			dm_update_pflip_irq_state(DRM_TO_ADEV(dev),
+						  acrtc_attach);
 
 		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
 				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
@@ -7383,7 +7382,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 static void amdgpu_dm_commit_audio(struct drm_device *dev,
 				   struct drm_atomic_state *state)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	struct drm_connector_state *old_con_state, *new_con_state;
@@ -7475,7 +7474,7 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	int i;
 
 	/*
@@ -7522,7 +7521,7 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
@@ -8493,7 +8492,7 @@ static int dm_update_plane_state(struct dc *dc,
 				plane->base.id, new_plane_crtc->base.id);
 
 		ret = fill_dc_plane_attributes(
-			new_plane_crtc->dev->dev_private,
+			DRM_TO_ADEV(new_plane_crtc->dev),
 			dc_new_plane_state,
 			new_plane_state,
 			new_crtc_state);
@@ -8591,7 +8590,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct dm_atomic_state *dm_state = NULL;
 	struct dc *dc = adev->dm.dc;
 	struct drm_connector *connector;
@@ -8944,7 +8943,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dm_connector_state *dm_con_state = NULL;
 
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	bool freesync_capable = false;
 
 	if (!connector->state) {
@@ -9146,7 +9145,7 @@ static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 {
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct dc *dc = adev->dm.dc;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index b321ff654df4..8656d6a9e88e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -308,8 +308,7 @@ static int __set_input_tf(struct dc_transfer_func *func,
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 {
 	struct dc_stream_state *stream = crtc->stream;
-	struct amdgpu_device *adev =
-		(struct amdgpu_device *)crtc->base.state->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->base.state->dev);
 	bool has_rom = adev->asic_type <= CHIP_RAVEN;
 	struct drm_color_ctm *ctm = NULL;
 	const struct drm_color_lut *degamma_lut, *regamma_lut;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index eaad9099bc0b..bf10ac6d2eae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -101,7 +101,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
 					enum amdgpu_dm_pipe_crc_source source)
 {
-	struct amdgpu_device *adev = crtc->dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 84360f3a0162..3e227d384413 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2147,7 +2147,7 @@ static int current_backlight_read(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_backlight_level(dm->backlight_link);
@@ -2165,7 +2165,7 @@ static int target_backlight_read(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_target_backlight_pwm(dm->backlight_link);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index fcca4759667e..5506610b33df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -235,7 +235,7 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 			   struct drm_connector_state *connector_state)
 {
 	struct drm_device *dev = connector->dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(connector_state->crtc);
 
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
@@ -331,7 +331,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct amdgpu_dm_connector *master = container_of(mgr, struct amdgpu_dm_connector, mst_mgr);
 	struct drm_device *dev = master->base.dev;
-	struct amdgpu_device *adev = dev->dev_private;
+	struct amdgpu_device *adev = DRM_TO_ADEV(dev);
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
 	int i;
-- 
2.28.0.215.g878e727637

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
