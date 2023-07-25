Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CF0C001DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 14:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2117710E105;
	Tue, 25 Jul 2023 14:28:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0D110E105
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 14:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwYwdJRY2Uga3Tlq+jfVJneuQMp50roxef5rjoGDMYXQQs7HoBA+vHRL2FCrv55f1uFr3gXfzagf5GGU+VIPpscLVEqV1FFfMO+mbIO5Apba34mhOKpsJlLTw81IaLzIzq/03rg2fEAxz35hupSK4Yps4CdqW9pYQ0vFf3f8Pyqxex3HLmPmhXKdSkLGmDPEV57L+s64Q6MfWcjm3JxKhzqGUI76NERwGBzBMwPSZ5CiO/ERJaE7KN9dJS8KOsokDL4vFbhue2bbC64x3XFgff372eSzoPi4zTSNeS73u7+47r6FmjvRQlOdutEO7Phk4mxOjfIMS0UUuwj5laYrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSfVtqokqO4GS1BZh0Z8W9TFe7C1KXmY9Q/zxIiIqFQ=;
 b=NeTqCluJDENSFAi8unj5ytFHwPQux62WLwsYbvd8LdbxkPwslN2aCMpC0LrNqdge0cn0I/psPZ5IDYe2DiOHP1YD5KmhU+k0gY0kjdWbaYRqVRtvHxKJFRlBE4i9BYG+J1qzc8q2D57KujWgi6caWqeaTMtPikNsKv1wgQpRbl7Syg5sgiIKAN/CA8V6e76AaFAqa1bVS5eTsDPfNfuV2u19RsLUQ7w+cbEflKgpgYQuaruXYltGi4mcGxzSVEEx+7A4pQ41K2sjvTEUCwaRDWVA1fE/xXRXQy5AfMMTi5aTLoCYbe67GTsC999lSRPN7pfUH3ACa4x0ch6Rdn2YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSfVtqokqO4GS1BZh0Z8W9TFe7C1KXmY9Q/zxIiIqFQ=;
 b=CaQzktujgn70u10x79PRrZ6oFd7kM2chCTiMvVu1IZV4yd9LlGOTCJDMs1e4r8hTW6p0snlcrGFkhNuhqU6xfP93DxCkSVs/zXQsHcu9IuaLO37Wvp3UgeEzeHXK37Pb4IHuuvT8f01EmX1HdiN/tI2gcrXed28oR9JmkE477X8=
Received: from BN0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:141::30)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 14:28:22 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::e3) by BN0PR07CA0015.outlook.office365.com
 (2603:10b6:408:141::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 14:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 14:28:22 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 09:28:19 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: update kernel vcn ring test
Date: Tue, 25 Jul 2023 19:58:01 +0530
Message-ID: <20230725142801.3042029-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 599a5f11-f59c-4a78-add2-08db8d1b665d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //tz2a7pCy06UQU3tkGNtO1oY7GxGoSLJFPDyOlnRtPj4M8RXAMC0dEwbM83hz7WV7cm3K+TLJuuwCBZoHHSgLPx6TYuauKDPXLisDvxoutLVcx48KvnT6/3u2y1zc6AN1U51d31laDhlZo6VvZ3o/0N2+sd8N+MG7O8dopTkwYKKeHRJoYeXWHcIshpBVJ8nlxE1rr4QKd8VQ62MP6gKmLT6ZZ5CkIZ4vnz8RlENBSgMdghaIdb0vCxbNPPI22/WDdbkGM9Cm7v6cwhIXumGYNF8cjMjbXFZaQs5QZngQoaKXkfPrYWCdv++t3/L8+F8ERaJLTbCHnrU+fhALjNZfZcsp89F4zYbnCRrSBiWWNWuuIhfYxdC1/WGUddQA3lO/me9UAcXIIyIWk5ASK1FiAY+8eqmEISbJc4TCti/x7oLCNd4iXzQYjQR9R1SArQ07et3IVOyjIpEWsgAUPvWSFNN3YmQXrG6xTkcYgsaswCgMA+k6t3132Mwu70xZJCybBNh7GlCR6cckGBvf8nDsZHRZTEG6iqXGDyNyuusfOolu2NeB3qKfAIObhnDYncFC7uMR4UG2nIifAN46CHIupyyq3VNDqPRsS2RRhxmWRcTIBIgzxExADBN7fE1Gjx11wOXVvH1qFhG0BlfyFTWxdSMvlVqDKBZM8jembFZzHFojd74VC3cUL4c7W8S0AvXQpiEByL0a/kCT4I+u5hVDHsvwvwrtBvuYN3G3u0C3dnD8lw4IzgFK60NoId2vm3L3j38u65M7TVA+SY+bdoLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(7696005)(2616005)(40480700001)(426003)(40460700003)(6666004)(478600001)(356005)(86362001)(81166007)(82740400003)(36756003)(26005)(1076003)(5660300002)(44832011)(41300700001)(316002)(8676002)(8936002)(4326008)(70206006)(2906002)(54906003)(110136005)(70586007)(6636002)(16526019)(186003)(336012)(83380400001)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:28:22.3793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a5f11-f59c-4a78-add2-08db8d1b665d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
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
Cc: sathishkumar.sundararaju@amd.com, christian.koenig@amd.com,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test for vcn v1 to v3.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 33 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 +++-
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4e1256af80b6..56fb66f1d2d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -539,6 +539,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct dma_fence **fence)
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
@@ -552,13 +553,23 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
-	ib->ptr[1] = addr;
-	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
-	ib->ptr[3] = addr >> 32;
-	ib->ptr[4] = PACKET0(adev->vcn.internal.cmd, 0);
-	ib->ptr[5] = 0;
-	for (i = 6; i < 16; i += 2) {
+	ib->length_dw = 0;
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
+	/* session ctx buffer cmd */
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[ib->length_dw++] = 0xa;
+
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
+	ib->ptr[ib->length_dw++] = lower_32_bits(addr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
+	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
+	ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0);
+	ib->ptr[ib->length_dw++] = 0;
+
+	for (i = ib->length_dw; i < 16; i += 2) {
 		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
 		ib->ptr[i+1] = 0;
 	}
@@ -591,13 +602,15 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
+	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -626,13 +639,15 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
+	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
 	msg[2] = cpu_to_le32(0x00000000);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a3eed90b6af0..23a80e656ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -172,6 +172,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -375,7 +376,9 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
-	uint32_t pad[30];
+	uint32_t session_context_buffer_address_hi;
+	uint32_t session_context_buffer_address_lo;
+	uint32_t pad[28];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.25.1

