Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78925EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 11:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB47D10E132;
	Thu, 15 Jun 2023 11:18:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 314BE10E132
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 11:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzZeAZKU7wLzvnKQoktWGVjGYf0jWCIZ34NbGj4o2LE6OLB9PHrnaYZU2E50MEKl6n1UbJNtf6H8ibt8oCbMOEbj3pfyb30gtmrclVTjV9z+u2asbYLZUMU8F2pLKz1+uZIyKnzf6W3KDgYVaJ21dua2O1OVZnb5MWr4SReZHV8JF5FjMF16eDXeuiZIUXdP4WpWDw/+uGLsWkADETM2k+8AIZLrnu1BlrL8Ij2GJinZZQB/87YLpIJn+i8Ma3sN1auvuHtZRFUMWi1J7ciNrlRQR1/1dfQEustDes67eRHWGkqmuBZRLDVHbKq7wSIw1Udk5LesnDp9B1Pa/ldloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE6rcKFBPie2xwuzxOfwTWku7A/P8r1U6CbNDoC8BE8=;
 b=dWUhPI0rjXpUqFWNehwx0ZELk5ygQPIor5x/oKGv4Sf3E9UiTK5EIwe60zdaUO/wFEm4vn/1KCwG6b9+JpB90pt9CgGIuHbm1NGd/nPclXH6KDRPdHpa23omNXbt/TeABCVyBlxBRcPvAGsbJ1SEHmw+3TrsgjTtC/mOiRZZNHNAgZv7hrtsf96/bXjOMXPX+qo6lYnoePuhuKTcq5Obh7NXUOtQOTuMD/57eKIxjZQt8FK1XDPqVbjaCTHfIsAHg6Fe81huLjsi9rnQf8s+aE1uGHSD9c3T0Sb0nqK2gVoxq5Ly9VCOx3U7xcjHzVTZ+FMkbS29IAHiQXqGFdnoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE6rcKFBPie2xwuzxOfwTWku7A/P8r1U6CbNDoC8BE8=;
 b=JAsxCdBFWpXY5buyeByz6GnpuOs2HDq9uPUinU3VcHqQ0q+JtYZ5HqiwlDLZ7pPb9M9bmYC5s0mmjekNXbv3CM98bTSoeCSVNbj/Z2C3C9QakkuErvC0KTThwah4YlGIHfwwUBsJTg42u/F9FT1sJIAAIz1XixlrXwikICjgARU=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 11:18:55 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::bd) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 11:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 11:18:55 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 06:18:54 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip mark offset for high priority rings
Date: Thu, 15 Jun 2023 19:18:37 +0800
Message-ID: <20230615111837.285610-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6751744e-120f-423a-df64-08db6d924e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYoBjWqiZuzkq6dG0Eyvm5PKVNBawfXOjRq0DabINvFjvByez+qtXvo8Rk4ccyO21PQFmoVMml4YpFZlawysdgx5xceMYq+QM8FZyqAxKSS/Uq/VNph2s8WPZbjQyk9oShJN3HntskI+J4BpWAlIuadk81VWw9R0AZMN+q9H4We6pH7DV/D49TDrL6D8ZPyMnXb4Vdsk0/O78A8rq6y8h9A2VZm5B3yKjoSlHMXUAkckge5qCz6CdJof8XoFG/QOXfEDSA6UwQh2v8GCEeFVCPZA9G5zevRiFzskOMuKpLYDLZfOAoiD7P53cUauO5mk/OiZsbzot6+oIfdfy0MUlV8mjR09c1DMuZcOEGkI78Qm5uzWXG76so2mjKn/+jMI25wKyfHskMAtuKXAMtv9snQDGCeOs+cqJLfd6O58gAfPR/X5r2sslyTKbtM4pyG6PTymXnOb9oaQGHrBfmY6DmH1FoYcCYk+ocVmz5W579v4ANdvrRugz2GUqZBVi1iGNlFjY9jeX33reUexo8IABc++pAc28K8B0/zlIytnAyGO6wLayMooqvDV5p4CrwchIA6C7MoLgBOqUiBiOo1tBmccLQqYGg1wEgoixzqpK6gTIgBzzbSP7UmOqlWlMxiTNwUX542aTfdgbJD4vMTBfmdE0eCmUFdEf+NjY+UIrxOETe2su46Fzt7gdvOh/XePAlRkbdNZiFrYy1jjp1p9mm5xyaMieqH31uKdK9wPa/+zI1Q1oHxirQjTG7dW1IoETWJwTEi88z3Ll7qZGBYbAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(40460700003)(40480700001)(478600001)(6666004)(7696005)(316002)(41300700001)(5660300002)(8936002)(8676002)(2876002)(6916009)(70586007)(2906002)(70206006)(4326008)(4744005)(47076005)(426003)(82310400005)(36860700001)(336012)(16526019)(26005)(186003)(1076003)(2616005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:18:55.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6751744e-120f-423a-df64-08db6d924e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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

Only low priority rings are using chunks to save the offset.
Bypass the mark offset callings from high priority rings.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 73516abef662..b779ee4bbaa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -423,6 +423,9 @@ void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring *ring, enum amdgpu_ring_mu
 	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
 	unsigned offset;
 
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		return;
+
 	offset = ring->wptr & ring->buf_mask;
 
 	amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type);
-- 
2.25.1

