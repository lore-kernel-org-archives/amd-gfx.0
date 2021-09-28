Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1536101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE1536101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8087D6E8B3;
	Tue, 28 Sep 2021 16:43:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851FC6E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOFY66APYq7AjFciCBg81MUElx575P81+NlklhVPeCtVJjzPLGjy+oya20AGfniiukMcuPWjR0m0mEq/km1YUXVWVYYhENPNBcnwW5NrEZzpe67FBxiB+/+iWmldu3eDjBMZvSmzUEr4opbX40F2tZFmxH0xKFUf9Pc1DU8FLjldmtNMT9vE8Dt7Bphatv0QTxWBd5YVIXUFE0uHRf7FI80eBL5KY2OwTgdoCyKSEJNsDIF08yL6juk6SaDDTBsbHd59OlBBpCQRG3ua8XwGYCxmbIDQ0Ki0E4FbDN0FulECIYdgMrA9qHQAkGZIJ5d4T4VheGuVewso/aUcRKfAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bIGXseg2x8GpnguOc5uwuFRJFWRC1rExtqsWmpP0sfo=;
 b=TRIr+RwlNmgT8MCDdrH6h7oUYXUXhwUEVCcPaqLzLgDF5WsdJGF/SOhzaRn87kLgeROuQtchc33Ss8Fi56Y9NgyJmWHxUOqaENC9UUCKzuvMml+8f5x5aBhpXwViYkIkpRXyADl6wAtk/nWnvi++kVgZOT8mB3jPGP8RdF9m9U3Nd/hZScrySxutEcDlkcLbSjo12RoeGomyaGWPbDMvGx+EZuzkhDO9zpEqGpFL7HtX1diJ5Bzlp/T/zXv1AwWMrhbEJu7uHu8CNPMz3Dm3w5IGvhZRv9ruLG7f22oDEMqA494+xBcBiSLdVQWkXJgnD1JRoo5pwO+eJvvxB7/55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIGXseg2x8GpnguOc5uwuFRJFWRC1rExtqsWmpP0sfo=;
 b=zK8kUtdhWrc5zdOak5vMe6xHPYAPfdlHuS6dq/dx9gKCvNLVbsTN/4KLbXjqpPrBVmqBDrrYPUFhvexV0hHjSby8JczoYXJxoMZLXtn+RqJsZx/Qbu/ER5qXUrfvz3eb8lB4kflw5cv7QhCtvT9JSEvxQqe0YXIQ+DVFLtZavuc=
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 16:43:23 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::3c) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 06/64] drm/amdgpu/nv: export common IP functions
Date: Tue, 28 Sep 2021 12:41:39 -0400
Message-ID: <20210928164237.833132-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 292b0771-8c7a-4d0d-fc24-08d9829f15ec
X-MS-TrafficTypeDiagnostic: CH2PR12MB4940:
X-Microsoft-Antispam-PRVS: <CH2PR12MB494044103E0020CA8BB6900BF7A89@CH2PR12MB4940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXCoRODuxep0KpwNonkL5xOWnFVQTB//VCJlSxS1VENBD0rZ8I6qh+tK4Ltkb9z9Mh4q3g5nq4YmXKaJQIrCcIoBYUDgHgxf10s/j2BAr2KJ7zieUO10GV9+bEKRZKju1k6t1wQpbNFTmr7prfqK0gd6ekF7t+YJ2vKMAiqJRMbhYFD3+u2ohF5qsQ54CRYxdL33we6Jxl0Il9SNh8NJAwxj5OtajFnLJq0K9+SzwgxDhD3GGaH79cvRL9sYKNxbW3D+JoHIMeRocJSZrN85qsgJOsRtOMBnu49nQbMUPFbpTSP1bfQYsx54zk99QId9JEDdhh3Zvax8nORoerIKlgmjwDBUgd5Nevz9A5xbDV5aHCT9qiSUocQDpZUcjyiUOazSOZyk7Kl/cmg9NoobYCTPmsHXr+BneOktFq/fXrM642OhGNUqgDFPql7wK1CFnOeH05SgTuh+0TTKxvrTbhaEVVliTegaTBTUh4M1N3TO6MtgbS4rl2a79dRHm4zGcyJx4oETTJ+py4kocNkfCuvcGwYtMWaOhfd++L+cOE36kn2xvKI2vsHA1yhsq1hdcv4C/xMIUyay5d0SFXowPpFSlXFEPMk7W4zSNnQHZuMVHO2NGBZ3krH+CjH8LPgTcUAsMDwZDg32Kcp1LwFaaAjyKY2JPnMoeIOHvgHUiXRF2A8XApfikXCbwV0SLIwRUnJKt23443PZfkuD0rTtCn+8BUmUZRy7djAFBe1zY8I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(70206006)(8676002)(356005)(82310400003)(336012)(70586007)(54906003)(508600001)(81166007)(36756003)(2616005)(316002)(8936002)(83380400001)(1076003)(2906002)(47076005)(7696005)(4326008)(6666004)(66574015)(36860700001)(86362001)(6916009)(186003)(16526019)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:22.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292b0771-8c7a-4d0d-fc24-08d9829f15ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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

So they can be driven by IP dicovery table.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 726975caf4be..0dc390a7509f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -599,7 +599,7 @@ static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
 }
 
-static const struct amdgpu_ip_block_version nv_common_ip_block =
+const struct amdgpu_ip_block_version nv_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 1f40ba3b0460..7df2f85bbcd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -26,6 +26,8 @@
 
 #include "nbio_v2_3.h"
 
+extern const struct amdgpu_ip_block_version nv_common_ip_block;
+
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
-- 
2.31.1

