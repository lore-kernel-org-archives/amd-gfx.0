Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B62DC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 01:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC4F10E791;
	Fri, 26 May 2023 01:19:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FA210E78D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 01:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjQUgsnw2QECQjqotLzbab0yMs+GjVBSg8g89mxcFDvkZILX5VFLd10ketSyeFV90N2tklHsprP/El6eYlDn2k1sc4XHDKvoR6EVNU+f9+OECmYuj5lic9E5wM+tLjg/y6mSvivzi75MmkBOOnaxKI/LxW/+ctz3VhKq5jwf9kibnh5TmIqfI1WLYYSSlQdLjtu8nh0Ww0Uj1j+rVLtyB2/VWnJ9UhHXyHH27QyCXfSBQRZz5PzMvgMFZfBMsYDgTJVHBMy0r9Es0FjpFYcI5MDXNU4qhRNfF2EqQqGW87DgLTiR71idNjAK11wevZXiiDTNhgclvrZkXLyUC2GAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dVwqsoAzzYAxHpGWqqrx4e2JPEPqkU8Dvaxtb9UJ0o=;
 b=MtcZq84iY8YKpXz5NCiPN1nFQ6H+ZYgJ8iSCAhYv8NxY5iDBxB1K+ZBgCfJJThpEaA6i6Lim6gN325CmcEmWACBCdkTaJV+AV0GXKNS+vlhZLXRenDA3n1Hzj01rzh92h6ijYPNliagoSOBWFYbkwHm01i1ghjnIQwXbxm9LJxNy8RfaulFwsvVWz2OOzgtgU0oUBDXYz1Sskkeii9Rj6CuYIQYiDRRyywgO0YuCnUaI4TUZERlVXmU91r6iF2pMIhMWmV9k8CEe31u6Rr8/Io4Eocu7n54ljmOiD1p3rePi79MK4wXur+fO7760nOhXE9mvMJ+0f4G8SuwIbXPpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dVwqsoAzzYAxHpGWqqrx4e2JPEPqkU8Dvaxtb9UJ0o=;
 b=UitBqbiqCIPY0eOKGQuPWCBQq6K7NpeUydGiy4mZXZ3sFjS59mfcUxwl0e6ueAlIBoP9ikBic8SB5I6FsdLn91GTFcoOS7vIc09uINeIN+7ZpIt/jWWiZ/vxl4fFP64kRJ6wRvOvjSoNDpyajpfahmvYPUz0zxl1Rr0vdu73x00=
Received: from SJ0PR05CA0104.namprd05.prod.outlook.com (2603:10b6:a03:334::19)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 01:19:27 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:334:cafe::7d) by SJ0PR05CA0104.outlook.office365.com
 (2603:10b6:a03:334::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Fri, 26 May 2023 01:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.18 via Frontend Transport; Fri, 26 May 2023 01:19:26 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 25 May 2023 20:19:25 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Implement gfx9 patch functions for
 resubmission
Date: Fri, 26 May 2023 09:18:46 +0800
Message-ID: <20230526011846.3331119-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526011846.3331119-1-jiadong.zhu@amd.com>
References: <20230526011846.3331119-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9030bba4-6830-4077-6a63-08db5d873f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJdP+F1Uc2ONxW3ngokDVLrcq7IW41wmnV6pefgnWeqpYKNLJ28oEJDhp+p4EwrX7f87GPuOvVw7oXEky7Md/UUzYa+uCMhz6zgq+xWwnFZOm2ksTFn1DgnE6689VvSc4hBlOqbePGvFZe9+eYXCEj0MW505G95C7oEG33BCSzomcUKC0hBQwUxkVUPkYJJ9t3g7fVUuqMXWQa8HF2b9VPaFfSNyVZGbciSfwLsBQDyNczX3Mitz/0ljRHepGVA8BA05gYduEwaNoMsPQ5K8SVawVUrMdY6oYbKoUaOPp1SFckpEBaAAyk8B6QTibp/JwK/YYfrTE69DY7RUk4ECbpwOf1ejfa8U1+V1wzFOavn4wx6W/8J8dbEdgzQ9NXymeHwHXMwBFjgy1TX0azEYFKJhgKF38PnwCxm9CHM0viXwDarFVj/hF/u0COv9t6KyU+rupWTwCSoJh+jd7Ng3RYlrsPDoKixRoPst8uc2MJwI6W+28EzQo1klzwgMZfQLdsqXRXLOMRX46BIq/+8XUcgsqv8NCpI3mnv7/xy3rqIKabcZF8cU4ygmsEwvzmT50GxBYz9QL+4NrCqIEc7Hp+g8hDFa6XMzaeYO61mM4ZZKjvllPOT3gNGiUrSVWSDI1BbR3GwBzqA2FHQI/hfJtLeRGMD3H0Z8R8DBgCnrBGn670eJaAqnWNIDpoPUXD1M7b7wv9otrlrDyYWC9GCINuFcz57Sp6tv1XapyM2EM+VBfmQpYZc2ANWXOLmWdnqo7n9EgfmAxLxfM245CUb12Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(40480700001)(8936002)(40460700003)(186003)(26005)(41300700001)(16526019)(5660300002)(81166007)(82740400003)(82310400005)(356005)(478600001)(86362001)(70206006)(70586007)(36860700001)(4326008)(1076003)(316002)(6916009)(2616005)(6666004)(7696005)(36756003)(47076005)(2876002)(2906002)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 01:19:26.9427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9030bba4-6830-4077-6a63-08db5d873f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Patch the packages including CONTEXT_CONTROL and WRITE_DATA for gfx9
during the resubmission scenario.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cbcf6126cce5..4fbeb9b5752c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5172,9 +5172,83 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 #endif
 		lower_32_bits(ib->gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_ib_on_emit_cntl(ring);
 	amdgpu_ring_write(ring, control);
 }
 
+static void gfx_v9_0_ring_patch_cntl(struct amdgpu_ring *ring,
+				     unsigned offset)
+{
+	u32 control = ring->ring[offset];
+
+	control |= INDIRECT_BUFFER_PRE_RESUME(1);
+	ring->ring[offset] = control;
+}
+
+static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
+					unsigned offset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	void *ce_payload_cpu_addr;
+	uint64_t payload_offset, payload_size;
+
+	payload_size = sizeof(struct v9_ce_ib_state);
+
+	if (ring->is_mes_queue) {
+		payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+					  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+	} else {
+		payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
+		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	}
+
+	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
+		memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, payload_size);
+	} else {
+		memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr,
+		       (ring->buf_mask + 1 - offset) << 2);
+		payload_size -= (ring->buf_mask + 1 - offset) << 2;
+		memcpy((void *)&ring->ring[0],
+		       ce_payload_cpu_addr + ((ring->buf_mask + 1 - offset) << 2),
+		       payload_size);
+	}
+}
+
+static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
+					unsigned offset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	void *de_payload_cpu_addr;
+	uint64_t payload_offset, payload_size;
+
+	payload_size = sizeof(struct v9_de_ib_state);
+
+	if (ring->is_mes_queue) {
+		payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
+					  gfx[0].gfx_meta_data) +
+			offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_cpu_addr =
+			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+	} else {
+		payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
+		de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
+	}
+
+	if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
+		memcpy((void *)&ring->ring[offset], de_payload_cpu_addr, payload_size);
+	} else {
+		memcpy((void *)&ring->ring[offset], de_payload_cpu_addr,
+		       (ring->buf_mask + 1 - offset) << 2);
+		payload_size -= (ring->buf_mask + 1 - offset) << 2;
+		memcpy((void *)&ring->ring[0],
+		       de_payload_cpu_addr + ((ring->buf_mask + 1 - offset) << 2),
+		       payload_size);
+	}
+}
+
 static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					  struct amdgpu_job *job,
 					  struct amdgpu_ib *ib,
@@ -5370,6 +5444,8 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
 
+	amdgpu_ring_ib_on_emit_ce(ring);
+
 	if (resume)
 		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
 					   sizeof(ce_payload) >> 2);
@@ -5481,6 +5557,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
 	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
 	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
 
+	amdgpu_ring_ib_on_emit_de(ring);
 	if (resume)
 		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
 					   sizeof(de_payload) >> 2);
@@ -6891,6 +6968,9 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.patch_cntl = gfx_v9_0_ring_patch_cntl,
+	.patch_de = gfx_v9_0_ring_patch_de_meta,
+	.patch_ce = gfx_v9_0_ring_patch_ce_meta,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
-- 
2.25.1

