Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D8CC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 09:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC2861019
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC2861019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1E06E235;
	Wed, 19 May 2021 09:32:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCA26E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 09:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnq038Wm7/NHT0B+vtXM6jZA59hPhtQMLqYLFhxbw2nQo7MML0dCZKUlReWcZyhZ8Cd00RrapMWYigx0gdfZ8wOaHQRKFdtBUkjeFGsobxjXx6pAPz20mSorgXxoQ/bzbxUyOWYUDaIy56kaGiP/fFEiNrrA267lNaHhoVSbAkPWVZDRhTj38LCcDbM7G3vLdxT6dFt8kLaOMjA1ucNVnNcy78f6c7GDJCZMK/1aAf7Q2ssynD3Ovz4mBWAes8NZFLjPqyoUVKzpW1eZKuqD6zFbHeblRyyzc4hPfTp02RKIJhXxbLAUuwI7Lob5sKgp297VoO75OqgxTj1fDdrkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvSeioQnBpfKsJN3PlYeisTqaPPZ8WmzWOS7aH2/qAM=;
 b=A0Kl/0DoGGL02RHjxVKolY/E7kDUXi8g04zXnRXiFs0yGsK0LfNYG642XqL94phpLvlU6XvthqW5SOZpLD53nQkRZXN/2k0BjfSOBR9ZoBMjpt4tGoYeOMsdiqr3VOAwws0y+sMbecXSwtF1EvsYz8d8E2labFa/2bsscuR5l7MK/wWIo50EA71N99PIerHgZ/puE9fvKY6fw6vZyg7uiPPLQ7F2fEwxBzBOCIvspZZg5lceRPW8O5jVKPJFZrKAuG26Av8i8h9a3nY4283y7a4R75ql4y2AXEgxStHO5EOH7t3pWRZF3m9HJmcA/aPm1WF1DvjF+0e+aUigT0cNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvSeioQnBpfKsJN3PlYeisTqaPPZ8WmzWOS7aH2/qAM=;
 b=QTOmop8b0G7/IUYuOAr95RsKK58cIl/nsuSIAPJ0xRq4+mdROS7EAzQvIVcsq5lGtaRnKBnsXtk6LIypm8ex5k9fx/zROpXAdvxb0E+SrpkCuEZMbGluMo7g0N7Gv5W8Jl77J2huHqjTlC+JJyh5phpM5i1wmzST4iATz6EYhGA=
Received: from BN0PR04CA0199.namprd04.prod.outlook.com (2603:10b6:408:e9::24)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 09:32:14 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::ca) by BN0PR04CA0199.outlook.office365.com
 (2603:10b6:408:e9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend
 Transport; Wed, 19 May 2021 09:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 09:32:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 04:32:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 04:32:13 -0500
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 19 May 2021 04:32:11 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
Date: Wed, 19 May 2021 17:32:09 +0800
Message-ID: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc1951c-ffb8-41a1-473b-08d91aa8fcc2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:
X-Microsoft-Antispam-PRVS: <DM6PR12MB325834B64535C81952BEE0E6932B9@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvZ6VR/CJzssBNrZITDu4/V8PX/sMCtCuoM9reIlS6ncnVpQrKIo7XL4d3BKHDdVtmNdoApuqN8NzKlIrv8hrNIHl5SzYQozUiCEeIsPqyFP1emNIcYCjUaE/7nQybyNF0oSUvhfkf6XevrC9oaK7p1POlPN+6RHxgD53Jus2LIMyIh3oizPo7PKrFPnp5SUKKPovQZG9iCBAdri8ddyh58ydUxt9NJAtyowzO/3TNsKaEAEiJ4SN9F4PiWVUgyfI7ZAN5gKYabVD3wvGHt6PSaHm57kkj9giqhvZEnpzFfkkvjuoOWgiLbqJz9rRWnh2uCKj6Yvi1yqS79Bn5WDrf/WRm7TZe6YRbiX+3wXqCPh7pEfenPkuN+9tk/oI9c424+ibYRmjiYsFf3sO7DsR06GEPyA2uFss7VkYIPvWciMHQqrsz/CARgGLxl21FCelryC2i6aZZQDZq/NQit42dLYNvpAmek0NM9YwrIF7IU1t5aXczY0i/PEMjDZcoGkrSMztAZlB8T9P9beZa8QoYbMmx4LC9IO8t1e1hFmPhio5MKjYkM82+GPQS42HfRn0x3CZbcfEUDcLb8G0rFGQiOmc7NYCfhaZ0h2o1WpaJ9qy4bJX2CVZ2KqJuTr/thXtRb3fFxjUg1PTIUl48NKXzXlnxMOQjr0vU3oRDLI4/VludXb8CzSL+g8CYpuwO/7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(7696005)(81166007)(5660300002)(82740400003)(54906003)(83380400001)(8936002)(47076005)(8676002)(316002)(36860700001)(86362001)(36756003)(478600001)(2616005)(336012)(82310400003)(186003)(70206006)(426003)(4326008)(26005)(70586007)(2906002)(356005)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 09:32:14.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1951c-ffb8-41a1-473b-08d91aa8fcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When there is 12 VF, we need to increase the timeout

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f02dc904e4cf..a5f005c5d0ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -404,6 +404,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -422,7 +423,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			return -ETIME;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ceb3968d8326..e4a18d8f75c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -857,6 +857,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint32_t seq;
 	uint16_t queried_pasid;
 	bool ret;
+	uint32_t sriov_usec_timeout = 6000000;  /* wait for 12 * 500ms for SRIOV */
 	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 
@@ -896,7 +897,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq.ring_lock);
-		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+		if (amdgpu_sriov_vf(adev))
+			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
+		else
+			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
 		if (r < 1) {
 			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
 			up_read(&adev->reset_sem);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
