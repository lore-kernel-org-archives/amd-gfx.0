Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22738C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF83461266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF83461266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0096E8C5;
	Tue, 28 Sep 2021 16:44:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B424C6E8C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsRQbOGYZu2itaUQLE0fpDXEeuuAXsIekROTLEYtLNhg0zv6jdnhWFbu6/QK6XJxj1sgqPmkuu8vvsPI5/siaxDBUtZftB0uK74CwBGmXtkRvPuAAsR+H/3c5NR8FyG/QwmnQqtNU445F70NAjK7mex+mHCoPovUtxndrnhhtUBYysw+R0I+LhiLwElEf2Y5OGDvfJNGC8oZ2PukK20g3jDfnOJt0ZrAdyMy48oJBz4k7BuSe8iNGv3IuWmhcM50x4xjmLnEKlOK2WWRs4JJhh5MuM7If5ug4sgHv3YGvpeQaEG/8/FgE/Gy1pTJJjo+i3Bu9IierOLHhj8Guwf8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=COtc5++DmTNMhFQW0t+zWCzxet0Zm7w2xeECOUakNTQ=;
 b=OpNUr9wUN2D4QhhMXBk0OQISN4YE8JG8SKc84FocD/esImAEH//sLJHJAg19sAdvC5vAZRaPyi3gg0q+yV2/xhTSIhIo9KTe7EUjsp/12IqUoIIaN/ZodYag/Ci9/t712u8RgneiN0KMEf7k8s25euIrdcA2hIzetvq4DXzPJfKrPwo6aWAPBa1rD5yiZIoG6l5RsDMODwm84JM1XUCovBisWt4vHXavMlGnw/fQPElNp38fhvPcaKPK/Oomux6D9/jlBvXbwjxu67dgoevyV20SICfdk3zgobGs4w4HmqMsBSkYqUD7QcSGTWEQi57G8GeiqyfTMTo3J8Zs7UR64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COtc5++DmTNMhFQW0t+zWCzxet0Zm7w2xeECOUakNTQ=;
 b=yJqd1thyywdVR9E06SWRa3xtDFr+GyZwXSYcrc61yX9nM5fgx7rDXG1ogqPMOGHZrErLOQnuywBHdo6Mbr5+1u6iGwZmsAbLSmXgtiWYU5ybi3TMvMsqJ6xERRONrrOFYkwKa7bSnA627iRDzn7QVWD0W6t08qoVjrDdrfkBixQ=
Received: from DM5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:3:93::26) by
 BN7PR12MB2658.namprd12.prod.outlook.com (2603:10b6:408:25::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 16:44:11 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::4d) by DM5PR20CA0016.outlook.office365.com
 (2603:10b6:3:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 19/64] drm/amdgpu/vcn3.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:52 -0400
Message-ID: <20210928164237.833132-20-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86e132a8-888d-47b0-6883-08d9829f32a7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2658:
X-Microsoft-Antispam-PRVS: <BN7PR12MB265877CD31BC97910C01DC66F7A89@BN7PR12MB2658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G89I3rfmrBvxKjS2D/16CHlTj2QYyfodwxnj6/DVKqXUxj9gajlbhaDFY4VFx8FJs/pCoe07c8iVJUqcvUspm3/QN6JI9glKQ1dOa8VevEirxdK9ofiCJEBVgYbNEWeuJwVv9JcpXVzBTyhg/W+zMlp9xPFyPJBh+oAIMaAIWPqn1J+/ENnmlZV8fU+cLOKK/Q454IVQU5H4rlp7v9XytLvKqrl20FwVoCg1OLISHnQnFgO2h6DdjRTV7caZWZqPDpwA5DIyzsv0MccYitcpFcJFSXnFWIqZCBczuM16mWHAX+MAtGs9zIssvwSRqoZmmPbQ/lkjuhek7C+QZ5Xbv042jGbGf4SmurOA9nYo8jjN+bZsBw73BZJP/mdFlOptwsT9kWPliv0HvZRx/SUQ+5d8bTAF7B/1Nh2i0iCq8aMg8fUrZKVO+Kgg7a63WYQipzEODrFO0NwXCqHC7ot4L084FONwxUIGauuPUuoGyS/4mImqmHq9J3PiL1HZkMSfsmhWE8BKDXPUHFpPU7U8X1fbn5/Rj9/iUE1x009zp02JLZn61wIXALdKVa6wCgWgnsD85FcLgeyyVngMrW8WzGCDlByDeHK2o05YgKbf+gLSL0ZstbrKGdFmCnZuGY4J2aFYbbb1XSs/ZT6sm96zN6FB0LklzJ7MgRttr3BOkwhNLT61WPRDjjvzO8HqIvM2YlZ/OYQHDjSe1O+byWXVrkOdHRQBFKqMpM+IPGKTioY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(82310400003)(70206006)(316002)(5660300002)(2616005)(26005)(6916009)(8936002)(426003)(508600001)(6666004)(36756003)(70586007)(86362001)(1076003)(36860700001)(336012)(8676002)(4326008)(66574015)(16526019)(356005)(54906003)(81166007)(83380400001)(186003)(7696005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:11.0079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e132a8-888d-47b0-6883-08d9829f32a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b1af70d49c6e..ef36ee0f3a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -95,7 +95,7 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 0)) {
 			u32 harvest;
 
 			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -112,7 +112,7 @@ static int vcn_v3_0_early_init(void *handle)
 		} else
 			adev->vcn.num_vcn_inst = 1;
 
-		if (adev->asic_type == CHIP_BEIGE_GOBY)
+		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(3, 0, 33))
 			adev->vcn.num_enc_rings = 0;
 		else
 			adev->vcn.num_enc_rings = 2;
@@ -1272,7 +1272,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
 		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
-		if (adev->asic_type != CHIP_BEIGE_GOBY) {
+		if (adev->ip_versions[UVD_HWIP] != IP_VERSION(3, 0, 33)) {
 			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
@@ -1644,7 +1644,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
-				if (adev->asic_type != CHIP_BEIGE_GOBY) {
+				if (adev->ip_versions[UVD_HWIP] != IP_VERSION(3, 0, 33)) {
 					/* Restore */
 					fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
 					fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-- 
2.31.1

