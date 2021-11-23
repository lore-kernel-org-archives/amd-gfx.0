Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 11:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500606E203;
	Tue, 23 Nov 2021 11:33:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FB26E203
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 11:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drv97i9AG2Mltj1kuOci49w6VgS/QHB9RdxpVztuz6DomVethbj0meJcXbLiymj+SLp7hjrYiOrEeshLqXpgdLDdPGT2DREUc6ex3djaEt8XDALI/ubN2vcieb6WKa7328SPZgUsGJx17eT8NOkAEhCNgGqUBG601VksrvScNTCxejwSRfi+CW/eT+tI4QiHXs+7kUmC7lnM1ImACYUYETnv6NQXVYhymLGfgq1u34hr/DH/nJohTetvmJ/o3cOmYMe2x7caJezAddtn8rW/a+GevO/5zJUtshoakdthNJ9TOWUaf5FWSUkOJBnRTZmeyintyXOROjdbqYb2rRkxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqJ8tZ21Ygn4qGj+UfePsVD8JsG/Mm8kOIb6MoEDIQU=;
 b=Dz4S5FQ8Aj1df7nJzTQo8cIFO0JUp3RWRsp7xib5bv5bvdABgZOpzILn4HjTDauRY1s4PU2vioL/Im77U1l6w2KD4GFgDtXS+YdHvk87kqgsoz8OzNqbrHrJetmAcsEUenUP++Yy5ow9urBwS5W94cJnX25TukWYALqt+H1scMoo6k8ulnAw8i3D4nqn3ShRdBv7qRD85HS4C7Oqxzv27WXsFYi/rmxK7AXeaEs9KLKwZP0PA+62+Us83ukOMT+wazPL9nndtyyuUVZvYcxkfEUpX2pLGPUFMP1bHcQBC/FoFEX7AjSRS3emtvoV8zMgkeVy7qZjnoBhPhRAin5TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJ8tZ21Ygn4qGj+UfePsVD8JsG/Mm8kOIb6MoEDIQU=;
 b=zHVNheXKonkZi15m9gskX+yyw3eyTsOsOP876mqnawN5YutIDFLlJebyG4w48PEg5iwsniQjo/7podH25sZIS1G2RlzHfgJMLLhWrmhUGTVmHa1TDZM+BY8KF60nrWU/+7WipPSO13U1TRBHqXz/0ji+WseSiiGWYR2swkYUUAA=
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BYAPR12MB3352.namprd12.prod.outlook.com
 (2603:10b6:a03:a8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Tue, 23 Nov
 2021 11:33:34 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::ff) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 11:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 11:33:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 05:33:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 05:33:31 -0600
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 05:33:30 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip init
 for SIENNA_CICHLID
Date: Tue, 23 Nov 2021 19:33:27 +0800
Message-ID: <20211123113327.5149-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a6d955b-118b-408b-4b5c-08d9ae75157d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3352A5318C98120434726953FF609@BYAPR12MB3352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVapXzGQos6wOFmJKms6hNGJ3hTRWbXhloARtRNyogDKhJBspFzwZTcNUFb15CpPzPpDEJhvNlG2a3JPZWJzT4Seqp+mCQEM7HNwgLXP/3paaDkePkrjLadHgAVNobUGQVGCypT6mqk9PE/QpKLXjnIv8LNMHOfBgYcT14h7mQCV+9b7mCqimiEbzTzjYOJGEePyvKVV8Kc19IgA1Xu0N/4lOeNRXl8MryfVFOfPt9U60a0z6ThrrdWF9WlJnxyTAM2iq3BiPt/OkkjOmhY/4DRzNwU+eUKh8aExz6KRUWW7E/8E7ye8xinFNHzn12i7nShC/chsJRpoxTeGTYou90JFNXYCnQEh4zTIm+RIAKNkk29d782jZUO5GmURi41BmiqJKNmFP+73vDmrsYf1fVan2quzaAAmr4gRy6mcqjKMs6djeSVgz9YyPYBCKSXfpq45gokDpU/vvPhFCgC7rDvJN7+FoiRikBET04oiPUQ4GBrhneBTb0HBaEnHzTWfQz3bAwoNgb6tJYLAd64ryR5pk08Prl+k0WgS1saLHQTn05Ve+rJ9UX7hn87d7UKjPbTaRFt8O6zWL22+xIdrGWvV7Y3Hza3K1iT83dGtgxdP/C08e4v34vteqB70CG+veD1glMJsZjwpNAH1Khe3n4SG0AockNVZyZbPS9L8mw8kRTtOVHNMnyiRbIBNPMfG5iYP4iIryIrf4OvO86tFyCVlvFIZEsnaNCr/DFkDySS3i4gVCXDxbyMSCQvzlPBq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(2906002)(70206006)(1076003)(36756003)(2616005)(8676002)(8936002)(508600001)(5660300002)(6666004)(426003)(6636002)(336012)(47076005)(110136005)(26005)(316002)(4326008)(186003)(81166007)(82310400004)(356005)(7696005)(86362001)(83380400001)(36860700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 11:33:34.3006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6d955b-118b-408b-4b5c-08d9ae75157d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
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
Cc: Jane.Jian@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
skip ip revision match case and continue use asic type to check

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..0a91e53f520c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			return r;
 	}
 
-	r = amdgpu_discovery_set_mm_ip_blocks(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(adev))
+		r = amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+	else
+		r = amdgpu_discovery_set_mm_ip_blocks(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4f7c70845785..87f56b61be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
+	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(adev)) {
+		fw_name = FIRMWARE_SIENNA_CICHLID;
+		goto next;
+	}
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(1, 0, 0):
 	case IP_VERSION(1, 0, 1):
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+next:
+
 	r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"\n",
-- 
2.17.1

