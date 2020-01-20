Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A8C33CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD16D2073D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GZa114ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4286E8CD;
	Mon, 20 Jan 2020 11:08:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DA36E8CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 11:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dg+vXg9AscvuMWO+vxPlBAr03RQEYfalFv6ZNYFe0pjL77B1wiIAXY1AwbgP0GJFYdrD8pGEZukqEWZMSyrv1h790fxXfZtppuAcT4FKHQN5Sx+uA9ipbbiZvfGj2nuB1H7IZtZ9tuhMFcJ0vXx74hkGY6eAkpE560LQV8XtJDtvKGPhRq1TRGjJ9+jHR0DwUcy3gDJaMpaL0r60hHNf2yPeImNOg16GynxWZTA/2S8/SIAAH5eIA4JvlgHq8cBjCyo53bEVLDiuj++TQUPCDuHyjKGvx0odRL6x4zVhVGasZHk+Def/dHGKGZuoj2DmZ6To9Py0bFbbMapSkqgsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KrjjUbon0uczS7rGNueAtCk4SK6e/zMb0tEXSKbxgk=;
 b=d453wImusyokfTatWOtFgam28X/4Sly2gvARpMx/Qt3914jr+NbiWoIbalQSgcfKMSYwJ8+axSDBtB7FIRmFDYYdO7SFSybh19eoyYL9RMGtjGFKJOF2tOPIpXbvB6fK9dbiW68BSMIxShDCAgWNKsh2uGN36SovRGP6iUC0xfeDmKwVnABpy68yQWheLTttBSC835AZ0/lJIuRYpjzXTlDKMvvkf7DK11O4Kr+ZAfwXZ3kj1I0H/gCSt++YzmZ40ctumDdUkV4NoaB4tKAFJK8lWAhIQ5OxXK7L84xQbSamwG/s++SqhxnmmnQjwXXsjfmvsHKYBIIYqI3s1h/tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KrjjUbon0uczS7rGNueAtCk4SK6e/zMb0tEXSKbxgk=;
 b=GZa114ue3RxAvLgBEnvDucapX68+G/dWAlY7I9EjJpqFyk7jykH9DGYOYMbxW8P5MWWW5xkbFdzrRnjiAlWQL+4BnmPgn2US6dzsNxiLOG0V6y+9sCTWq7VHCLDICJD3GDkjp2UGRFkhAm9pNrdNUROdtz12tAhzMJSkpAa0OLo=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Mon, 20 Jan
 2020 11:08:34 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::204) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Mon, 20 Jan 2020 11:08:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 11:08:34 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 05:08:33 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jan 2020 05:08:30 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached issue in GDDR6
 memory training
Date: Mon, 20 Jan 2020 19:08:22 +0800
Message-ID: <20200120110822.30163-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120110822.30163-1-tianci.yin@amd.com>
References: <20200120110822.30163-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(428003)(189003)(199004)(86362001)(8676002)(478600001)(8936002)(7696005)(6666004)(356004)(186003)(54906003)(316002)(81166006)(81156014)(26005)(2906002)(426003)(44832011)(336012)(2616005)(1076003)(6916009)(36756003)(5660300002)(70586007)(70206006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3082; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 614947a8-0ebb-459d-9aff-08d79d99174a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30825D1947B4A684ED21C6BB95320@DM6PR12MB3082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0288CD37D9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Hv5TLwHyQbmThUUuxzaCSCkTl90L5wcut6KLhfCYRTSyJ0TLIvyYf2vd4RiMs0lpjkr1f4HEkdy4z/rkWozGvA8Kb5fVscV91YlgRoZ9C6gb4+MiiNP24Bp8b5BfPTBEDyP6O7KPL7J3XFN+dKTGIvEjMm1diQjSPsWiYxAgZTUNagFhlZdBshZ7+rF13rh0uAXYfxnqbLZjTBzQ3Uyb5J8n7Dz4xcFPmg2yp3Cdpt94UOa+CfZgtr1xIZw5Pg07RT/scTbcXCsT2hUBBROEukXcBPXoqwW9OHJf5R86GtBkU0d2CTii/6Du9KPPnQb02M24K7Z4nyq6JCbKGkRnzKaEljzHPgBfprOoFJoKGw3zTTzw1aUHdfhBKbvdMKyi6lU7yQ700Qmk85v3nhw+rcqlC2T3EpcoWhnQAOeCDeOwU2F09OY669fbwmRtk0S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 11:08:34.1576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614947a8-0ebb-459d-9aff-08d79d99174a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
In GDDR6 BIST training, a certain mount of bottom VRAM will be encroached by
UMC, that causes problems(like GTT corrupted and page fault observed).

[how]
Saving the content of this bottom VRAM to system memory before training, and
restoring it after training to avoid VRAM corruption.

Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 32 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3265487b859f..611021514c52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -172,6 +172,8 @@ struct psp_dtm_context {
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
 #define GDDR6_MEM_TRAINING_OFFSET		0x8000
+/*Define the VRAM size that will be encroached by BIST training.*/
+#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE	0x2000000
 
 enum psp_memory_training_init_flag {
 	PSP_MEM_TRAIN_NOT_SUPPORT	= 0x0,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 685dd9754c67..51011b661ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -972,7 +972,10 @@ static int psp_v11_0_memory_training_init(struct psp_context *psp)
 static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 {
 	int ret;
+	void *buf;
+	uint32_t sz;
 	uint32_t p2c_header[4];
+	struct amdgpu_device *adev = psp->adev;
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
 	uint32_t *pcache = (uint32_t*)ctx->sys_cache;
 
@@ -989,7 +992,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		return 0;
 	}
 
-	amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
+	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
 	DRM_DEBUG("sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
 		  pcache[0], pcache[1], pcache[2], pcache[3],
 		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
@@ -1026,11 +1029,38 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 	DRM_DEBUG("Memory training ops:%x.\n", ops);
 
 	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		/*
+		 * Long traing will encroach certain mount of bottom VRAM,
+		 * saving the content of this bottom VRAM to system memory
+		 * before training, and restoring it after training to avoid
+		 * VRAM corruption.
+		 */
+		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
+			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+				  adev->gmc.visible_vram_size,
+				  adev->mman.aper_base_kaddr);
+			return -EINVAL;
+		}
+
+		buf = vmalloc(sz);
+		if (!buf) {
+			DRM_ERROR("failed to allocate system memory.\n");
+			return -ENOMEM;
+		}
+
+		memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 		ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 		if (ret) {
 			DRM_ERROR("Send long training msg failed.\n");
+			vfree(buf);
 			return ret;
 		}
+
+		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+		adev->nbio.funcs->hdp_flush(adev, NULL);
+		vfree(buf);
 	}
 
 	if (ops & PSP_MEM_TRAIN_SAVE) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
