Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1C3C54E76
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 20:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD7D10E343;
	Tue, 17 Jan 2023 20:00:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79A310E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 20:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm2yCL9NDdybkAeAJTer1jHNJVbZIPXFCHXzNqfp9hSOR7rrSu6PUIoXDZlDgCVOc0yn/KBHa3/rT/Vyo3inQoggVGADtaZxEiA14E2LEiTr3tx51frqF2iLsCwWCzopcJI4ZWjTJv4rm10G1ShRcKlX60+Phx1+Wkes0v27/+7Phmc/gHbUyxy00BhqgAakPqOEoLnFYHvEDCzDiubnVRDyHU3q1l+13uwTHxJE5UgHunBROKXjR3C1Se5OvbsKrDn10GbR6qzNjCYdP/FwA7ehmlYLHCmqhETVsDPf3ZdjaZrnsyBtkpkD5QmaM7bnFOmE1OtX4/sPlXylo1PYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHrJeTVlk5bQpeEgL2kyJAfJsPnc+q4/GBp+5KXSDW4=;
 b=ONk1QDFgRmzydS3+hgUFf+JDLT+cVZP29FfhlZjOOckmCNkntXatyd0i+Bc3lE7US6KQrVGOxqzW2UYOl3Wn+jqrxqwwDEv6tDjta0WHP2Rv6xZ6B2UrCAsXP9Kwu5Gz7ctNd6GdDdtISigonMseDYiO0LayJFNDIARquX20f0kGvGIWyVjmnyaSbFPnN9zxB8WIfUIrZOg32/tL5g8Nkhcm8s0mzUpYhLkf9qTf/1Q6qH79iKtsvZP4ZwxsJ2AVrq7+tfJkipwADUGxe61AZhUmxyI4ROZo+E7PxQdbvf/o6DQ5LkqLbauj5NkO/8CdnvXaQqaINE5VfXQzDz0Ziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHrJeTVlk5bQpeEgL2kyJAfJsPnc+q4/GBp+5KXSDW4=;
 b=tjS69T80IdQE9Apq7fKcYs6bD66L6rIea62UheOSo2YBR0Ot3Bj1i2KcKMf2kVG/X6Ad3aeQvetltEETEMLzX7MlRj5lHZxQzL3D5uvUi62dsl6xJKASEFu4vX4psm4WOHlCe7ZhUX73yRvBEN8rO7KiVpmJWvLi+sMLeCYXrpU=
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:00:06 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9b) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:00:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:00:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/vcn4: fail to schedule IB for AV1 if VCN0 is
 harvested
Date: Tue, 17 Jan 2023 14:59:49 -0500
Message-ID: <20230117195949.1729608-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117195949.1729608-1-alexander.deucher@amd.com>
References: <20230117195949.1729608-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: fd14a130-d34d-405d-828e-08daf8c56df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dua1wX9wsdTarUcU2b6CDJ8EepJUkPTxUSvL8KiYP80wPCRhoWq8A1IuveKOTq6kDmzkUxKWkBIMRDIjaW+hcOtK2tw8Ar+c+ZXbn/AfqkiGziO5AOE++fsLBR8yhOggVAaU1aNGHKOB9PZ/U/wrmOUZPvKyDumxntDEIqIenUwZyHGrgPt/rNvGdgPQmXWPi3Z8KmojoWdthljC0DBdAkgBLQ6NYxm/TbmJp8bN9JwI9cYXJXJPKvCnaDfseRbF3yFFPJsrS1jrSU8T701x+TbMViX6VuU3KHIsegMYm1M2Fj1R27hoVJLPWA2flWgPrzPVpyt+BLJ27prpFAZE4Prwkz/jGClGIigL3h3feTUTDeGIEBCInNJAv7T7cbd6APqREzv6mgXIg8HpPxN2sG3yZpavimOY3nnhBOEvfHvezH+Yr64kDXl371FfD35JS4dlYIh0qKn/26wkCMFK2KG4HMffzODj2Qqto7vJsYd1z4NGFtM/1lZSQUUR/C70pv9AA+Hb1f5yqM0dPSwrv/rzGa4p/1tmP4Z9QoqzmwDNgvz0wtnSPbJkw1HaGuW8DgOzNFusk+IYui7msk73lAAwHzPFCeyE07Fx5aHa1uLxlyk9udNyWMn91p+kiYwGMuogrv4IfmooldbbxNc7ICKfhGSn1oIvdKdHbVN+r8436uABkVkADhxvXZme2HAaRsewZDVou7IkUiPpz8k/b6Yab2pMwgtmTAFUqb2Pgjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(40460700003)(16526019)(7696005)(40480700001)(36756003)(478600001)(186003)(81166007)(356005)(36860700001)(2616005)(82740400003)(1076003)(47076005)(336012)(86362001)(426003)(2906002)(4744005)(26005)(6666004)(70206006)(8936002)(8676002)(6916009)(70586007)(4326008)(316002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:00:06.2254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd14a130-d34d-405d-828e-08daf8c56df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only VCN0 supports AV1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a79b6088374b..efb22d0975b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1632,6 +1632,10 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
 	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
+	/* if VCN0 is harvested, we can't support AV1 */
+	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
+		return -EINVAL;
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
 		[AMDGPU_RING_PRIO_0].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-- 
2.39.0

