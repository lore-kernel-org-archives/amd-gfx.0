Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229C761262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 229C761262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB04B6E8AC;
	Tue, 28 Sep 2021 16:43:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F0D6E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9FRQRraSQW+5/dOh9kP9max1Z6a840FsLNNahHDxFUyitAG+fAE5X5Rrr+CmkJjDrESaavIIkm1ypOGb8YoO2NGcMkn521jKMC0YqiJgBDTW9mqjvKKA/iLZL0iSc+a/SYaVRF2C++vGF3CziX1xXWOIQuCNOsWiOt/30+2IaBGbXKYm6sRQkl9A9KXqACRyY7xm+LIX9x9lo3aUI1veIoBH9c+3KmIvWCI9BKqenAi/h4mU1uwPst+wQqMB1VXzTj+qn4lFgZJBDs7gr1V2ELxmMIxiePMS9agoXZiR9CUP8K1/+JIKmv0e9gzpcJb8z6wTdtqWulwAaGwRmKW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SL/BX46lE2C8V/kDXOcBGXq9h4X0dzorj4e4SM9VX0U=;
 b=B1rNa9QXhSDJ8FjqkuchvilIvHSooPON7ChzEBroQlPLebdXipt56EkfbwZcrQ68002lxjJkfF003M2E2v2LGOCasvxCSUITN8b62/MIDU5hxECcPCRUO6PgxHDXezFx+E7G9sIeYetRQehOHqFc3QjgkU9VDpdwC6CctgTcNcRN8Ay/iSb5A62jvVG/dCh7mlHKCYuJbDOdD4mkRgu2XCdBBQBj1PSJLzo+FzvpAOgfFDKscVTuVLlj9e4OCTdQav6fYn5dBxz0o+GX5cQexrVv+Y5hbp5I0Rs1Q4/TnM6v4h/3UX7fHUsAFKHBJlehYiaXa7sLjvDG0nyZGR3F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL/BX46lE2C8V/kDXOcBGXq9h4X0dzorj4e4SM9VX0U=;
 b=UdX3heAvDbcvreIezsMcIjWQpmiko/QgL1BE8Lc94nt6DhRu5+mPYa0HlhmY/MQUptSEiOJtnHZC4VzFMxqHrKkvG5Ln5tbSDI+ULsXkmrmWItxMLgxs/ojhU0/ORBux52DuMslAGSksrD5jKDrDX3RprS4NCo2Il22xZl+lGH8=
Received: from DM6PR14CA0052.namprd14.prod.outlook.com (2603:10b6:5:18f::29)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:43:09 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::ec) by DM6PR14CA0052.outlook.office365.com
 (2603:10b6:5:18f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 02/64] drm/amdgpu: add debugfs access to the IP discovery table
Date: Tue, 28 Sep 2021 12:41:35 -0400
Message-ID: <20210928164237.833132-3-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6392ebe1-874f-4809-94ad-08d9829f0d64
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23988A489AD11186C235BBC4F7A89@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Txi10JsWNhgWGxfJkVZ8m0prnFYeFNBlZmZ0RwdH735+6KuBh3oeYPFDgr00tuBb3GpbELi1xPgqTRHTbIOxtWsvYMYNeQCs7M70ujDdTpPC8xwMqIAtI0C8oAodDpDzM9xD2bu88MMM5nWgfkR9lylhNCXF0i0CwidDFN7zDjzKmOgxuqf3VY51289hr7DpdveP46IgkuEJO0B2J7foPDMf3L0mKMcnpLhcUK4KexjP62iiidwTAGie9lGY77hDYw/uFHYRi9HGSPp2HjQobseefH3ewj4FB6oK6vnk8mqh+27ka5FjjvCbhtQHk2roBtGPIH/lOtSWevhj83Tfnek3MqUluUKJQU1hs+j/S+emceAgTS4+8bvkqkOI2E/3ZqIHjGKkUh4al01codSxwcjXY738x8MHU9ys61+EliQ3dE6FNINrhqeuGaVH2tmH/QB7z2zwwtQ5Z2ldYq1kjgUHEqPvz14h2njMhyLlEsP/tw9IeIOCeQLFO/9XIgGX2l7wD24nBMRdqbxfL9rB0xmgrSbUw1HBjfhci3n1nbMNRWcz76dZfdknKtT/7DxfKpVqRAhQrn4CMU+EAQCvyEF6vIpJst2apEMXjpj5ZPfdTJaHpmoDQOYOFW7ePfxp5mY1znraCtf6ca0bdANqfAoTn+tnBxDvEIulawqv8pnjX3W8dKklBZzc8E57KAcWb/ptW/PgkLbHx11OQ0LF66Hc7RKYur84stUCm6bmjiQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(1076003)(16526019)(186003)(47076005)(83380400001)(86362001)(36756003)(36860700001)(5660300002)(2616005)(6916009)(82310400003)(66574015)(4326008)(356005)(70586007)(336012)(8676002)(2906002)(316002)(426003)(7696005)(70206006)(8936002)(81166007)(508600001)(6666004)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:08.4952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392ebe1-874f-4809-94ad-08d9829f0d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
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

Useful for debugging and new asic validation.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d356e329e6f8..cdb963b9bea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -830,6 +830,7 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
+	struct debugfs_blob_wrapper     debugfs_discovery_blob;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 074ffcf0dac2..31e16a42d4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1757,6 +1757,11 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
 			    &adev->debugfs_vbios_blob);
 
+	adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
+	adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
+	debugfs_create_blob("amdgpu_discovery", 0444, root,
+			    &adev->debugfs_discovery_blob);
+
 	return 0;
 }
 
-- 
2.31.1

