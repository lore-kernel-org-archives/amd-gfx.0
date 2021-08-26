Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1354C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CFC610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78CFC610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F2F6E5A0;
	Thu, 26 Aug 2021 09:47:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F93E6E5A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAebK4wiYPiR9nlqcbS/DKX1VVwE4AlyvCcAMhTkWZVCtHPiDxQHEZ9GcQGedGh+9SQHzcl6H/UxHznc8kwp4HtW6bTOOpiip6SXqeTv0VDYVazY2OxYCJm1sEjhYCNekAWGCiqfr60Vx0kh4I81V108GlVilYNnP0zo0j+gMLEZLZIqngSUx9QY//a0CaUkKIsYW44mS/fem5dSdBLauQotO7NWH8JT6w2/nnCoJSTXuH4Zs9kJADa8Jt/YexQyFAphnEH7C7yzn0HB1WkK34uNvodqz9H5GElyTphLRpUnkFxBZuhFQsfBKu2m4Cd7mbiQU/5LJK8MvCIUxa0gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAjCk7SBGRqrWjOmTMvVRiqF0wxsl9fyfhkq1rS0Nkc=;
 b=dw507+TXpZflaki5IhX1HjQ2ArBT5Ppdv/Mq77Z1+gQ7Mf4oT3uvpGCC22LCkZ2qzisZF3zvrVORE0KbWkDhhTg+hR7j+qOrsjcheo2ZoOZDG1Hax96yLLpdl2R1VG0cJhSktVWhCezi7vSHW+5U3IBmA3NXQqPFXXsfaLig7Sg37t5o/8uv83EVLOZeBGKcrnbBdzb2BeYykzPTdH3KvHRojgJaZxi033yixZFz3OKpGJu/09QvUx+XER8qWW7VOpC9Or6FbIuLG6rT3C4/2OX9SCq/hnsi9+UdcWsCoHkazp6+h0tdvVgZT8algLhnTGRX2wjmttZNtmJ9UoBldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAjCk7SBGRqrWjOmTMvVRiqF0wxsl9fyfhkq1rS0Nkc=;
 b=Ln9lmtiqs8fRjz6+SuuSN+1u9uK1OonozOXxnvLj4m4QN+543U9A+w1+VltN7ZxRDhxXN0/CDPrwuh5E4E9IT5jXhUUsaRbq9HRe8A1NFRbbWrxUtE7FV3wTWBDA90fvQ+28w4WQZmR0znZkHqJ/i5+3+6ti38gvOQokGIfkYjk=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by CY4PR12MB1895.namprd12.prod.outlook.com (2603:10b6:903:11c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Thu, 26 Aug
 2021 07:13:44 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::7a) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 26 Aug 2021 07:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:13:43 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:13:40 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/vcn:set ring priorities
Date: Thu, 26 Aug 2021 12:43:06 +0530
Message-ID: <20210826071307.136010-4-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826071307.136010-1-satyajit.sahu@amd.com>
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ffb890-e0a7-49b1-0462-08d9686109e8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1895:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1895146A61265C8620B5E8D2F5C79@CY4PR12MB1895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BN8w9SFvokkheVsUMfmnt8zW1v1Usq3vahZYZvYGCn7vUbk6aZT9TvDCGmUPPvswsw95NSYXt7qZYCx//UYSUXU7Ms4mJRIXLrDLCff38mYG+02QllMrH5sc44PzrftsYNWTobqDh3Zv6vO9Zi+QArQcmMnocMx77mGZFtrisdCTc9oE7uMz1DtaV3imUrQEjx1GF//0BrNuN3zxIt9gbuFhyPbjaI1aExEY1GxP9PSWjmkuAZMl+aazMdKKj5HJUNPAlAxK4qKerBF3M8jU5jQdPJwC4b3ObOOazkg4nohD5auLnqN1WpJD99S5xpiYJOlYE4OFAvDymMnBkxJGoOU1VBu39n7JeG8L7CekmC3h724EkLFYZCv8yrRKX9EE3I9vh026EqqtCn/DyyqR4XT9M3JRtfuyErcv/fL/wCU+vNSOkStBkyY3M8wGeA0dFcJDZVLeUDE0gTQfODp3ahWou6+bj2+DVhXHVQ7d2yEJ7VPh/Lv75tlFzMFbKWQchnEgDPHnRUavYgc5dCY/a7I0fFIMFg1w8LPB0+TcBPHqFg/F6BJZzSBLim11XXt6Ml51vNxMYBCOJSuyYG1cl8EwDG2uztaOCE1gfrKWpuSu0NMOvqSE0teXgU/5ydI/zztuHUkK2RNJj+AfcyC5PEn1NYyb3f7EyT2UJZXYYNJh3JrTfrr8P8a3VCWxIik0VhMoAT65B0vJnuYwJapAnymRd5LOGQFNxdDRrZ5fL/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(82740400003)(70586007)(8676002)(2616005)(54906003)(36756003)(8936002)(82310400003)(70206006)(36860700001)(83380400001)(47076005)(426003)(7696005)(81166007)(186003)(5660300002)(16526019)(336012)(6916009)(44832011)(6666004)(4326008)(478600001)(1076003)(316002)(86362001)(2906002)(356005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:13:43.5393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ffb890-e0a7-49b1-0462-08d9686109e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1895
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

Set proper ring priority while initializing the ring.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 +++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 284bb42d6c86..51c46c9e7e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
 		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
+
 		ring = &adev->vcn.inst->ring_enc[i];
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c546db..720a69322f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
 	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+		unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
+
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
 		if (!amdgpu_sriov_vf(adev))
@@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+				     hw_prio, NULL);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 888b17d84691..6837f5fc729e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
 			return r;
 
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+			unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
+
 			ring = &adev->vcn.inst[j].ring_enc[i];
 			ring->use_doorbell = true;
 
@@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
 			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
 			r = amdgpu_ring_init(adev, ring, 512,
 					     &adev->vcn.inst[j].irq, 0,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
+					     hw_prio, NULL);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 47d4f04cbd69..e6e5d476ae9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -227,6 +227,8 @@ static int vcn_v3_0_sw_init(void *handle)
 			return r;
 
 		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
+
 			/* VCN ENC TRAP */
 			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
 				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
@@ -242,8 +244,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			}
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     AMDGPU_RING_PRIO_DEFAULT,
-					     &adev->vcn.inst[i].sched_score);
+					     hw_prio, &adev->vcn.inst[i].sched_score);
 			if (r)
 				return r;
 		}
-- 
2.25.1

