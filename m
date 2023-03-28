Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8A4C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E835910E0F1;
	Tue, 28 Mar 2023 15:14:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC2010E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyrzGGR8Is2WlQ8GaYDvhIEBalUQjETiVMXDZif1OIjgIaz3oRH37CIOYEflFYIeaRlCPKf1FcjTkVLKqZf7jCj3VnNQOTxALRGNhtnXqacuW6ONOxifGGRxNPrQmjihC7WoHzedFvK9qUjTTETSdIsWO+ZnZGie15/wSkRWhuMJBJEYGmPTgfrRrEfkSCqAOOplGvQjHJa458v3tAKBy8EXXNfieGpLnpQ4nd51JWj7H4lWZGaj/Dy2uAtCsSdyGcqnxStHXpZuQQ2P5kCeqcM2/pjQgMZQuAvzWl4NrdcSQ54LkUrQEDfLgfjJuEtRoG4I+zzGdUz1RZngKRgXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArDUZkY4hiSMlqSUttZyYIjMuYkJyLHZuPcMX3L9v4g=;
 b=cJ4G+kESZT75uSKW31d37Di99eWgqZhf7flGC7fI1+2ybIz+5ROmLJ8QKewAvmEAqhaLNWeVQ4AMAOGRrtN+0jVWdqlBJ/z+yXNoY75Afu82O2tj0fF7+bTZfqDKnx9RFatMwmmSKjnMRryKKLRc2ERJaIbkIBbLvraeZofi0Kdsb+W97OZVhNXZ84D+Kl8a4EQz+ktVH45C8qtshtL8oOJtkl6VqCcXjUCDSkOeAq645Xjyyk0Cq+l7xfKMVHPq+EWqgy8IDQciYQirJ/ySy/eCOhVJv43eGMi0XrqTO+IbpXbhMdCA7UwofABYdLz5cE1kh6BbM85/3kg6w2VEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArDUZkY4hiSMlqSUttZyYIjMuYkJyLHZuPcMX3L9v4g=;
 b=YjbwGaP61zM0Uj4DqaMZcOEkraiG9+z2lZHeElJQbZ0UnUpl3bcu8I/7k1J090rpPiujr4mu8r7DW+UVy43k/U1g7WDrMT/RR8R5belqW80PtXyFGRNAo+r8ye1BVC0yEDaLO6ifoJ7l9EhDF1kfIUny8/qNZIiEEUMmCFFskfg=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:08 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::63) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/32] drm/amdgpu: support gc v9_4_3 ring_test running on all
 xcc
Date: Tue, 28 Mar 2023 11:13:13 -0400
Message-ID: <20230328151344.1934291-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cfc611-f264-405c-d506-08db2f9f136e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3khGf6bv9BVmUTMQd7tl/OeEIWjAOn29TixZY9lMXMbSiWTbW6DzF6FMpdjn3GanAhHOIr+65ka0Xy+mc7S8BcZR43tLrDoa7YIaeR9ceqn6DwQzYoawtSOb7QI0oefbB7ybp7E41IMub6Fe7l2KUVlsTYqM0zGwHCVQd0tap0if9sh1aKoKY7+BOpvSxgsRMGIDH7OYRFw7BAdlWb7GjJq58oKQtXOjoU5xmM3nbTsTF1j/fqvyfx5lXG8h8LxCW1c8FoChIBhAT/C9OOTxY8vLObIQNxDwKAb5WsiEBY6w5YtnT2fXwX17VYnNnH8mr0UcGJteTpQKJJqX4a1DaJA88W38oMeT/U1U02JJLHiFoPuOKuXsCnz5/GBOkprnygSPAUysBCGQe+6WUpgnW0vP0FP/oBdmGNCZV2vRgtHfMBEnQrFj4po2VOVHiPiHnP28I7d0TjiUTqa2uACwqYqJaU1VitbAoWVxw5XYmF+z++ylEP5pojkoN+/d+GXC6noYYooFMM5IF7smaYdagvOEp4RtSnaxsAX9W6s9ZxNr//OLnyoFvg9wdWo97FqlFCAIjwfXI8viSkLwTqw9TR8orkaS1YB6trySNazbcYsWrXcOvcWWd1iH0R6E+popXwVMxavHSr+Isr04uaXod8XdQVJAsQsnyJQN34aLHHw+Xn2FvIgGxhnTsSEJjEMhhcjY+Rd73a/WTCI3VKAcGFWMjEWJ76rQ+nIxs73mDu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(82310400005)(86362001)(2906002)(356005)(40460700003)(6666004)(186003)(2616005)(1076003)(41300700001)(478600001)(6916009)(70206006)(8676002)(4326008)(54906003)(70586007)(5660300002)(8936002)(81166007)(26005)(82740400003)(316002)(7696005)(16526019)(83380400001)(426003)(336012)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:07.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cfc611-f264-405c-d506-08db2f9f136e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Each xcc has its own sratch_reg offset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 204b069c587d..351bc16b95ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -232,20 +232,23 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 	uint32_t tmp = 0;
 	unsigned i;
 	int r;
+	/* scratch_reg0_offset is 32bit even with full XCD config */
+	uint32_t scratch_reg0_offset;
+
+	scratch_reg0_offset = SOC15_REG_OFFSET(GC, ring->xcc_id, regSCRATCH_REG0);
+	WREG32(scratch_reg0_offset, 0xCAFEDEAD);
 
-	WREG32_SOC15(GC, 0, regSCRATCH_REG0, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0) -
-			  PACKET3_SET_UCONFIG_REG_START);
+	amdgpu_ring_write(ring, scratch_reg0_offset - PACKET3_SET_UCONFIG_REG_START);
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_SOC15(GC, 0, regSCRATCH_REG0);
+		tmp = RREG32(scratch_reg0_offset);
 		if (tmp == 0xDEADBEEF)
 			break;
 		udelay(1);
-- 
2.39.2

