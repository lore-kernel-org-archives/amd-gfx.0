Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8074FEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0F110E2F8;
	Tue, 20 Jun 2023 17:16:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BBA10E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4wQH171TRNSdYaval+NZ8YovSYXFo7kO19W9OtMB0UsYTQCZwOWART/JRwRHqzHidedtdD+RbrBeEEmPtsJBL+jjUEqaPdt3PqqL1bVH76j6RD+3PdvgAo7NebWFhSZHovIo2aVEBzjdJd1OlpxoVRp+cF7DymETDWbSSINfNEronrNQ3irukxA/RxIo4ToKLAo8ggmIPFp85j5jvvqJhBv1d6fy9GQoOFasN8yEIYwOX8LScWEzeNJP0QG7nnjD+kJWwwwQtrDB6d33TgbX8Ak+xvEm0rms8K1zPGZQkXc9y2Be5TVZHW4sU6Gcydaj5Tg/0igEWD0XoOAT+4mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/aPtJgVRuadEIZBhVr9l1mal3qhCRh/eXH+N3snvGQ=;
 b=XJLyJX9hkuzzW/IpYCdTX980ZXdg8PfqBGmIu9sdA+UvUIBWwz2npEAZQoIKOPSGtgl9IFdRcQOtDpn11rJJSOiDi3qpJz6uWuQ1OmNW34ilW9z+q+t749IJk+NUpwPw23Yln4zKTMO6D6PKm6d5PUWGhZRJ2FLt+KJDWxOrONEexCV8bC8psriM61t3aPS+cziAmutjRi+TU4mlWWMrnuW9evDNi1rASaBSm7w7RZb5kDsgvZVP2ZxGOkttI16osJLVJjrYTHgpF/DhmR/hCWIFagyfFpY8Z5Sl5t9Qnb7QEvkF5TvypMTE+OnNLSZeK9SV4WP0lw7nq6MmyGYd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/aPtJgVRuadEIZBhVr9l1mal3qhCRh/eXH+N3snvGQ=;
 b=01jtD50arNRuNFGvmSy8pvl9TT5vvEnG73vtKsn6nPmDNHl9HOIaHOLB6Tf0kOWzb8zP72PzwGeGPru/ZAO9W2vgY/wFLcsHYFW/ekPKlEDLj2jPKvgL/30iMGskQe5GkTNszeSS3Vqd0CWGVTcJHvwLKDRosYcWG0Cq4GYCdRE=
Received: from BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:35 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::6f) by BY5PR17CA0007.outlook.office365.com
 (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:32 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 07/12] get absolute offset from doorbell index
Date: Tue, 20 Jun 2023 19:16:03 +0200
Message-ID: <20230620171608.2131-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: c9887e1a-58b4-4fc9-c72a-08db71b2197d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfymJuDbwn0UMcZp/uwz4+fz7RuUFnCBKprjx9TEqJFKwswiAkvl2m1YbuWNge7xNLR44Y0NXq3fa4o/D59drihKtrnMaashJo1f0T35gj+eEanNoH5A5bYQCJx+/xLj8iQKJliK6zEut7QZfV542kbVD8d5R8ID0N3AkpZBXeE4PJddYhI3HRqGSfPWTUGrQCJ4PGE0HIf2oJ5V3ldKwqrmMNnysDGZCUCRR7eqgLC8Mw9ef8qBpq05M1XKwlYYKsJLm2c4ECOfle3ECYzVwY85WhZA8RI7DIS2bdec46SGyclqxug72V4jl3k0BSFD7iIy4+E010KvSqAon8DVH92sQmxlHYOV0/CXoMwmFVdSCQwvK3KrzIqcLVJA6PkyxeL4SYQseop9gqSsrd2b3QXUiVazXVNlVjrsziDb006QGAbRoD7Cu4HDiBxo/kRWuZqORwK2fBD6qqHaFzWc77QRecblt9WAmGso9f713kRIqwjbc0MzPiakFwf/uClNclrkWdUhlk8v2XOa1S3zwy+VM+afULF0dccVfC+aIh2gdbXp1huf4HhJMgdkEly5gapK7Vbd/U+w+gyCk68iGBsNqL1G9CRW+ujzqLj8B/+20DAZgoAzXGlw1RmT3aHqNrqu2Nsq5BoM2SlpNcr8VIAAm0cbrnOZaKauiUWi5oMdt8m5XwTtK1aLDfJUx0Sh2GeYw0sowdIA+UB0GSnhS30eJ71jSPAiwwfM41mL/63P9aVBQOQuG//7MF/yd9m/yK2HTQyYtFKmlUDKVMxpGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(36756003)(8676002)(70206006)(70586007)(4326008)(6916009)(41300700001)(81166007)(356005)(2616005)(47076005)(40480700001)(426003)(336012)(82310400005)(44832011)(86362001)(7696005)(2906002)(5660300002)(54906003)(8936002)(316002)(40460700003)(1076003)(26005)(186003)(16526019)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:34.7598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9887e1a-58b4-4fc9-c72a-08db71b2197d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a helper function which converts a doorbell's
relative index in a BO to an absolute doorbell offset in the
doorbell BAR.

V2: No space between the variable name doc (Luben)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 002899edb9d7..48e3c848ddfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -317,6 +317,9 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
 int amdgpu_doorbell_init(struct amdgpu_device *adev);
 void amdgpu_doorbell_fini(struct amdgpu_device *adev);
 int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index);
 
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 118f4bed32fd..e1599fd72954 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -108,6 +108,27 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 }
 
+/**
+ * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
+ *
+ * @adev: amdgpu_device pointer
+ * @db_bo: doorbell object's bo
+ * @db_index: doorbell relative index in this doorbell object
+ *
+ * returns doorbell's absolute index in BAR
+ */
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index)
+{
+	int db_bo_offset;
+
+	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+
+	/* doorbell index is 32 bit but doorbell's size is 64-bit, so *2 */
+	return db_bo_offset / sizeof(u32) + doorbell_index * 2;
+}
+
 /**
  * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
  *
-- 
2.40.1

