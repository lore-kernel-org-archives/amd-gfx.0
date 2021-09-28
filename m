Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3368C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE1261262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DE1261262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F3E6E8C7;
	Tue, 28 Sep 2021 16:44:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4C76E8C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkuVKa+79GFGoj0j8aKIGq4uAIXDGN15eMxfmR6z8xb5TFpkHGOGWitClgRPTqR59BWPmiJ5STSRHxWqoH9hhzOHRESmLxN2Zzi55IZqkMBLUr4Od+PKuIAweuYE4/kdNn8jtvyDuHX4RjkdBsNcK1NSWJ2Bh0k2SE4SUJi7TlA3z6gF9mV/p5VVjIN7IN+CkTfGMn/hCyj1EUSRW1s+FYv3rmxhsRYAFGBRY6ypJeEypjIqVTO/YgFIpw+FG8lq59/9poQ18gAuItyYkrR/cowAxTlCzLDfSz678ZG9ink5nI9ymIwrvEd05Rl0jAy4iDbE9UOfSVMyqsznyBG13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hcjennyG6nm9tp4/Mw+mwlCt8EHKDL55CPRmbRgSwsU=;
 b=C+zhbpjsnGj4a51skj7D/7symDKGVGNIyvMPQL3I4X7aQK+0yZk0IgMign4mFYSWbw/54Sv4hlmV31OxKZZk+mXPbsFlBWaKfnSNTaVqg5thMre7EfmVDzS+8SF62oxV3l2gBBaZRJM2lIcoG7ZGB7UiFV4nQAC2R2ZSMSzuXI8NBsda+7g+NHHM7sY1NNHlQT6wK0t5ZzwBMQ9u2vXtBp6sKjUIut4vghQcgoATT1AjZyOKcyrXrj54ETtMqmQq6bugi3jbM+LWXyc40UezbCeJQvBpUYDZ3ljm5tp6tNKXv+3YqCggOT9uVKM+PhaVq2NCFbDuLxw+TAzfF8BfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcjennyG6nm9tp4/Mw+mwlCt8EHKDL55CPRmbRgSwsU=;
 b=3+7YR4/bHavJwYirIRLAeJrZzXrK+QWaCR5jhcUbvhfzsXPKkLT+W7HfpopbbH1QJ3Ha8LDlOGZ3HVQEv6oO1riOBKLbPmmqts2r4LielDvUu3MZGQJC0jNgeaQUshq9fiUI/Z7vJba86GBHYBC7nb/8qp2gjXbLcpl83AFVrxo=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by DM6PR12MB4633.namprd12.prod.outlook.com (2603:10b6:5:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:44:14 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::f7) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 20/64] drm/amdgpu/athub2.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:53 -0400
Message-ID: <20210928164237.833132-21-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2629b21-46ff-4ef5-c387-08d9829f3432
X-MS-TrafficTypeDiagnostic: DM6PR12MB4633:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4633C6761F11E2F8EB1554F9F7A89@DM6PR12MB4633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSbdqT7yBue89yfdMvqJQECaVU0+/d3nzUgp+wxHkrZMQww2apHFVpc7isKVg9TfYJRH6QCy/h7tzjOn7eRDxEcabf4U/gA/bAJRqgzBOFSsOjmloBTKTj8Lgf6h3TToiPEtifvP8TUwAyeqrM/eKv1vzLEi9CKfLIve0JbPeSqZuov0QPZ5U6qFJo8wx8u6z+Pk8+ZZEJWqHyyg1RDZjG+Gk/454cV3fzUPp3tjJhyJtW7G+8pn9yacFCJDENkQGOmGsZ6SijGW8+qsNAK5ilDtgrlYfg9wcH66iTRtyoBXX4tiqRF32355fi9iWoPLyEaj0trDE/bRTs8wmCuIpXkZAWuHEzi+amg7Us2aaI3C/88tFcFfsU5V/wcgsuo9UHSw3A9KfDvQ2G3uAeh8kZVLfF4HJ1y2OB+voUp20aVK2uO6bNbCNuDu9/CEnRPgy4TleIFEI4DcmrWy8sLwLwiiHpf3tM2m7AD7pxj9R5VCaHI98JxBLV5mTLkc04PkjAoO8c/OWDHNCcx/8/AXsFNfTQQoW6uvIT8o3KOn48urqpkZqwEmkf7BLFoe6JItJzUV5LqVGQ/SveImbOCPHj2ID8Sv2+n42Sle7tw3aTtxzwJg9KbN4jqdX3RYsuMMApjFv/EVHdb28dWn+4bJxlkSuJ5ClVADL0qCxqYGsM0BNFm4Lm7z44zO0H0ox41xM1IoAaxfhrM4IYZgq1LHRCDU4kTcC1F4wVrypsH3xow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(336012)(8676002)(70586007)(36860700001)(86362001)(356005)(186003)(54906003)(4326008)(6916009)(2616005)(6666004)(36756003)(1076003)(16526019)(426003)(47076005)(316002)(26005)(7696005)(8936002)(4744005)(81166007)(82310400003)(5660300002)(508600001)(83380400001)(2906002)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:13.5999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2629b21-46ff-4ef5-c387-08d9829f3432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4633
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
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index 3ac505d954c4..d3f634eb40fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -77,10 +77,9 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[ATHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
 		athub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_v2_0_update_medium_grain_light_sleep(adev,
-- 
2.31.1

