Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57838C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE23C10E409;
	Tue,  9 May 2023 22:12:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D5E10E40B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/FfLFknwGhY/o6HIuw4O7NAOlcoAPkAYkqL6+iAsCmVFTVvXAKF07Jqxjl9QIscNfU7vzNcqWyT4Z9iiM2DQzl791rTsvm9dPIt7zdgc4lkCqhTJ4P0mzqkRX7RobIkGVHtVtUIImV9ZV6uv+k3p73v4m7Zn/CgSx656kUBO9/zqMrfVVnwIc45VlOkEBaslqRpyRtPuUz1MjaG/MUB/04laKE6JEcA5wB20cWqSVFgyzNsTbnUYJ7Prx2zGcOR9O/DVBA9BQpBWvScf7GIT0lRft05loqrw77MPJEwoHOMAGwqk6Rnkf9r+SJ5ChWMdeCjPmUl97W2pZrYktcWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jkF99HHp4YQAP2Bb87JvNB1TT8rF17riqK8p3QOy6o=;
 b=DXz5frnafyzhKCnA+jTt1tM78Bv3gS7ad0YSu9Y7d6dTu7Ip91qwyiNd0cxssHlCfGEDd8qzp4g0E/z7vrTZJM4P41rtDLaclFfM43fchyZGkBDj271Jy36aV2UcTCg1VtAoGGjf5A3uD2umcrX6+9jJjlAnqfYIC0baPuhEn0HSStXUdpPSvrwCi+phePuQVoIvc7zztzjko2t95LAoL5QtnD0DF5iII8FPHinW20q3yaE+Y0bfAKvOtRfL0ex8H638JFTvv12+Tri+R5qhdcyEKoQeouJxgD25b+8GgvSZ+jI3unN7Xv3mZz0MAQ6xXswlDs259vKDzFG1zzwlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jkF99HHp4YQAP2Bb87JvNB1TT8rF17riqK8p3QOy6o=;
 b=YkYimXNz3S4SZbGD1UfjnE4i8jKV7GIdF/Xz4JB/zmlZDW8Q3g29p7CCjiyUKl/5x7EKDpYj/15YXVMX0J+VYwE1PnyLJNf9L8zq5/6iw2WKuQRuPF2V/QFz2Vs+ZQPm9Uv/TsbQjKgTN075vApITXu8J/7w15dALX6S+FlKipk=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:11:52 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::b0) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amdgpu/vcn: Use buffer object's deletion logic
Date: Tue, 9 May 2023 18:11:28 -0400
Message-ID: <20230509221128.476220-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|BY5PR12MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 623c082f-e506-460c-f2e3-08db50da642a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KuYu/ucMbS82scIBDr7FnTARhoctBs/D68W5NjDy3YYn4/WC5mpOWZ/8BCwoPMU+kHlMBXA4511NqWTGW/1kFRRWpZmduIROoj8KilRHEYmb9ekWGsQrHUEv89cPBeWWGc5fFprxncC0DYjtLhcX06hlVCpjeIzr3IcRQPLLDrg5FJ2a71YKYiI1RGd39ER/woyqpDHr94lqC7FaiW3a2KxihGtaqB8nBUfaNtOKP6LPk5JsXP3a/gcnt6komutUflyXOwmcjbqMYYtJgljX/rSUCSfpkZSjJdpnv1pzzvNEXvuXfe61qL/zA7avNCK7t5Kg79Rt2TqU19kKxntOIMCWdtQpCnqamnYulyWCdeBJRV3jIAyyAlT8BSIYe0zLj4hhoUYSo+jsVAMw+EgQ8dp3T0v1ymYI+N3JFP53/z+vrqjwr4ATcWVl63NlWHftg94zJuk3TVjXeELKqyeYwdm2FF2ZGkhENpiAM8J3IA8sOamt28nesE8GyXdgfzLbRsabbEkIbAJqrVCaH72wdSJ8Dx9JPnsuHGnSLo/Vpsgkq6dtrTIkk4GZsB38K0v6aawhb8H5dn1s6cwlZkY11XlcPtRq1387IRT5BBkCVTn505ca4Su7/A8g6ug0m1/3M+cZmEcyBRSSUzTzzlZJWCfGspTN4HWM2Homo+YJGrcrQCjSpwL7t5GkG4Ln1pbsBaU0576D8MVdRIsn3077k+E1WbUKxC6MByFbnEDa+z5peEtKdNEGV50wRaNYBz8vv3RPRIylMJEx2q4bwizfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(81166007)(54906003)(66574015)(47076005)(40480700001)(83380400001)(316002)(356005)(82740400003)(41300700001)(1076003)(26005)(82310400005)(8936002)(336012)(426003)(6916009)(70586007)(4326008)(70206006)(36860700001)(5660300002)(8676002)(86362001)(16526019)(186003)(478600001)(36756003)(40460700003)(2616005)(6666004)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:51.6217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623c082f-e506-460c-f2e3-08db50da642a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

VCN DPG buffer object is intialized to NULL. If allotted, buffer object
deletion logic will take care of NULL check and delete accordingly. This
is useful for cases where indirect sram flag could be manipulated later
after buffer allocation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 57dabfe1a1be..06ec2dc55857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -235,11 +235,11 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
-		if (adev->vcn.indirect_sram) {
-			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
-						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
-						  (void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
-		}
+		amdgpu_bo_free_kernel(
+			&adev->vcn.inst[j].dpg_sram_bo,
+			&adev->vcn.inst[j].dpg_sram_gpu_addr,
+			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
+
 		kvfree(adev->vcn.inst[j].saved_bo);
 
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
-- 
2.40.1

