Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D090C4321E
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0552010F237;
	Fri, 29 Apr 2022 17:46:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A68110F1C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hexAmIiN4FacWgCR4Oo9C6ElFukj7g7ZiZZWfqKDPYgA8Ea694bG1P1hzstGJnpUJESHxrbbY+kbPjOmnNNuLjkD6mf3dSBgBi8gKo9KPSNZPIkWmD3YF7Oyk2XJPn0iNeJVsxBRSLdXGK5V0tbw/XfglbpxqlmXoGyIYmnPkXTcW1nS/vHlE2p7+Fx43Li7grQSFe2xrth5PN1SupPiF04+cpjS9KVCs0sczpTl6GyeQqeAfYtpAp2NqJSekV2MUhSWGYytct2zSh9OFOirlKlYnut0xJA1EwPuxrZ8priir350G5kikegkDf5wsSxMzrQsKx+UY281WGa01uk2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfUXgRZ4md2rxDH2QvakbexZ0UD5eOV7ifooN5wtMXo=;
 b=HLRgHT5th0F+m/poXqoG3lF05ZmMongJEatx1SLPo29WRVQNnE8bzn96YTrbyeJncD0nTTIgIJ0xO8pLISUIs6VdQ7/Jb955NUyl96W59VOTclQYCuubR+MH+l/BwTKbgeN3Mf6FGumgwNEgG2FyLkJlq2+jmbc/OOyaq5sMDN9TVIYXQKv55PkmtlYJ/f6j80H0+gDMReFHRH9dl4TrVGzOyIgdBkfHdnyUPe3OAdVjloyGIPtein9jL18yfO9CJq72ZY24LORxpDo4Z8QsENSlv+Xh4XDjyF864tpPaWf1RGRJNnRl/wzfrkYthLXbEK6AeY0Ay+LTebmmuJv9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfUXgRZ4md2rxDH2QvakbexZ0UD5eOV7ifooN5wtMXo=;
 b=0efZAb/ORHile/GnaIsaUXe82LMUEukmAnJQPsLzu3cAwHRwsNP2H2BsmTOu8UNrKAWuRzZ0ej6oSKoVfhYZP8DDIRF8+GwNQ+4gng6rb5gPxvh2zvik9N5kAkPWYTYRz6kmVrKwoQkAFk3SIqv5Yq9h96Y9zWbUEEeIHbIpWww=
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:46 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1f) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/73] drm/amdgpu/gmc10: skip emitting pasid mapping packet
Date: Fri, 29 Apr 2022 13:45:26 -0400
Message-ID: <20220429174624.459475-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fcca384-85c1-4a1f-6201-08da2a083b38
X-MS-TrafficTypeDiagnostic: MW4PR12MB5641:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB564120ED7F6082AF494B4354F7FC9@MW4PR12MB5641.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLy6xBNzq6zzJgNXQKcQPbLtG6rW/hW85cMmlBM+Grr8jrqdm8VaeWFuNBYjuSOat5ZjP77PXMa3yXgFyxLJOviaaWQdJTVYHhtVKiB8uXQHi3wr89cgV4bOq017rXO3kUKCH8ucjRhA08dWLXgWVRMsDp1/ihKUc8gJxiVI+gaFwOZs1eyxNZvmVNDtDxYmZHJUgjE5OSCtecM8AgYJEU+KPqtwSxU7W/afpDcM2mqBatY9YDCqz3aqve2TFNrT1gVUNIiHZB+PojlxUm5RwLgmMEVB+RKnka4y2Xkc+yPavjlKj2ug3+zwM03M2phH64VFVLPqJEgKtZu2sgLWdHSVhjiiB5+3z0gG3uRzWXtJi4/4ObY9dbnfx4JMJo2jwTjPV/uxHlRve5dMUBLNtwE+OQP1WRNyQf2JseXpTbA230edRfaahsJQuMBSpjqTYAoT0yDnorgA01c323H5uhjiZMBPrdIa9uEyAw8Z1IErqpGXhQp2LTzg7KXzab1mzHnKJo1FhxUgau3621YfF0+urvpGZ5wumzzm+rvldFN0N5sgF9Bj4P4/CCpH2FxaUEPkg0MZNyqsrmcjKM8KxKH1DGupaqGhSLHK+oIrYvKjV9vtKLih3M4TlVx25dd0f7g6o+M51JU9rvGhkaIMoV1pIlfN6gvEhEHIB5scmEX7dK0vy/RjbzLtQY5Ud/tXmu/sqET4avywf4nMfsk9eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(54906003)(8936002)(508600001)(316002)(7696005)(86362001)(81166007)(1076003)(82310400005)(2616005)(70206006)(70586007)(40460700003)(36756003)(4326008)(6666004)(36860700001)(8676002)(356005)(4744005)(186003)(16526019)(2906002)(5660300002)(47076005)(336012)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:46.7064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcca384-85c1-4a1f-6201-08da2a083b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

For MES FW manages IH_VMID_x_LUT updating, skip emitting pasid
mapping packet.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 487c33937a87..9b4a035a5bf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -517,6 +517,10 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reg;
 
+	/* MES fw manages IH_VMID_x_LUT updating */
+	if (ring->is_mes_queue)
+		return;
+
 	if (ring->funcs->vmhub == AMDGPU_GFXHUB_0)
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
 	else
-- 
2.35.1

