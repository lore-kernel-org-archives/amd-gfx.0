Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0DC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB14160F25
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 12:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB14160F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562596E92B;
	Fri, 27 Aug 2021 12:44:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B256E92B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 12:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE0tqrd31zDuLpZTh69lcoeeki5O7dHRubxS3rDoyBhUTgKExF1KB5lLvOHRCimXH6qjS3sCghA9s33Mbv4XnJ6B59FonJlfpLWvGGk02mPL9yXWtp+s886pCKnejuFKLoCoUVZYMzbOh8KR9uo/X251foVERiKts05d6WbantpXvk7mGbUmeDEjRSMdyLGnOKTrbXuH3G1z5DJ53u6Y3GbSpdwTX8mvqgmt1ZjoNJVWZWKltSWSx7FeFyaM02adeZXalEYWXhy/bjTwDwhmbwnOZ3x/9dG/Tx7XFLbruDFhsV52x09tQdD5fm2YP5u6wW1WvXqbEXnqQXpyvYUpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GjpXKv9j1xgX1KcExvrAdZn5t8XwKZBD4DFBdXNE6k=;
 b=CvVtZdpZJ1xRFJkcLNM1MnzKBZuz35bkUQUV/+ttjQWHu7iIdUpvaV66akusB1wp7Xx2xGER87ca557FsNMmb/k/N3nbqLS2u84HgxScs84/hS/dFa/Rd/vbZM9P1qcXEXKKR37MAfz4Z4M3nhXbZiBbccVw0OwNaRfFN6Ro0ioVs+MQ3+AvTr1TbLlTzo5nfvL5K+PgQild/Gp06j+fIaQGIr0qPBQN+RYZ/JnuzUs68zMpcAyDz6rSNTldCtqq5st3WPJdFkN6LOWWcZabnXig0kCLAuq6z1nii1+v1ivBSkb56AGSPiza3WPrM+TZ3HocugsVrNdfLTt3Flyckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GjpXKv9j1xgX1KcExvrAdZn5t8XwKZBD4DFBdXNE6k=;
 b=wd+dWXHKvlTr1amLVAskvnJf8tETUNR7rTRhrn/2FO3w3zjvYts7mtGUo2iSpvbg+YglvsFBu5NMQvEqDZMArSwxYCGgg6iWl8UhJwZDe2fL5+NgpjhQNhSj0z60XLs4P2LLpkY/XY467KRUmAnjWL3zlW2Vw6lMMPQGz6VGLpc=
Received: from DM5PR12CA0012.namprd12.prod.outlook.com (2603:10b6:4:1::22) by
 BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Fri, 27 Aug 2021 12:43:57 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::b9) by DM5PR12CA0012.outlook.office365.com
 (2603:10b6:4:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 12:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 12:43:57 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 07:43:54 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 <lijo.lazar@amd.com>, Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu/vcn: set the priority for each encode ring
Date: Fri, 27 Aug 2021 18:12:59 +0530
Message-ID: <20210827124300.14593-2-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827124300.14593-1-satyajit.sahu@amd.com>
References: <20210827124300.14593-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c74b29a-446d-4869-cc27-08d969585632
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3462BFB989032B9C00BC3AD4F5C89@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVF9YLM6KEKk2wlHddInUFddtDrvTC6GhORE3y8HDMdRZ/vXk0geUvfYRu44zLQ/oi1JuStEoKzBY/L9+9TNQFZKfDaJeUuNxpef4VlmS5bDJsHJrMawHDv6eIvFrOIjsd8Z/rJnR/sD7v5AQiJ5RB+jTohAQDEkcAisVHs8kNQD06PF2Fo44DXnRf3eU2HMw1lEyVTARoqd15jR1OulPwoDovWt57u4+NAhaDmkHCJ2hcComCjIom3l5tRDGp4HnVfBt/wRldB7wiO4Zb0k0RXrNTsEhIlgdQ2V/5nISoLyIlGRFnHt9ZXJ2Y6UZXm4sDCwTqVQyz2xv6FgKh3lyRyo5DzirAsxOqd97DNB13rCyeLCCTTQrTgv/FjvZwQsC2P921x1UGm6nnjIsZNMpq5WqpdYzkR/QfaSl+Ov97/nL81t753ayyjuka/rB0NOW2+ZbvCsUq5kxDmAwYSqilx66x85x3T3PzXSEg1UvOr6XLI44TdDoDUyYbo0EvliTN/nLogDOhLnzPIZJl967w3CopMxXq5xFteJ3KwyOIgC8w4Oe33g2uPVAQp/wPnFoaKr3RgenKZq6TdWD8v2QMNaA0a68h5mAuC7VurUzqf8uMB1QfhODwpQ1zPOuCReFTy89K8wOSKpRK0SiXp6leA+lxlSDGVyjtDKzdYeJpL3FdUNjSlvg/D41l93wDVFv4eXRc3Zo432DKuSl+mYBwFr1OQyq6cAHLxEu0OUCz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(7696005)(316002)(54906003)(44832011)(426003)(70586007)(5660300002)(478600001)(2616005)(82310400003)(86362001)(8936002)(8676002)(356005)(81166007)(70206006)(2906002)(16526019)(82740400003)(83380400001)(336012)(1076003)(6916009)(186003)(36756003)(36860700001)(4326008)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:43:57.2785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c74b29a-446d-4869-cc27-08d969585632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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

VCN has multiple rings. Set the proper priority level for each
encode ring while initializing.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 +++--
 6 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6780df0fb265..75cff7e73fc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	return r;
 }
+
+enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
+{
+	switch(ring) {
+	case 0:
+		return AMDGPU_RING_PRIO_0;
+	case 1:
+		return AMDGPU_RING_PRIO_1;
+	case 2:
+		return AMDGPU_RING_PRIO_2;
+	default:
+		return AMDGPU_RING_PRIO_0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d74c62b49795..795cbaa02ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -308,4 +308,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
+enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
+
 #endif
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

