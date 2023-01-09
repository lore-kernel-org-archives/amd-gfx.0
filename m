Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76AC54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 15:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A661A10E214;
	Mon,  9 Jan 2023 15:58:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52ED310E214
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 15:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP/DDjB/DP419312hclvdJde/9iIPDkqj+vIC5v5QAI4MsdcngTYqOSRRgsBqqU21AvjC1AzxYygYzOiP+79JZv9BTuO9rXSXxH+Jl5BrZUbp1rJt26l4SxP+30xh3I1A4Z0u+qpgAyrMrzSBxKPBeLFZUNFpg2Ril9QAgrBVxKubivTDd0OKXFuJdz9fC14c04vGe76N2U1Ywv3K2fALmZnjAQR74r2dBWVkhvoPhM3nRwlvC/HHDNaH+QQSKbeoj+4RWzGAvMyMDTM6HzCqPqAn9MZz5eWqREHkD4Djhx/JpVviIuIY2oEqa3yaVub2FrnQ4vtIPAXQRxJ5lwPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RqzJUK0hW5rXWVWYVwK5RV0B+87sLmgtIPQ8u1AZQ0=;
 b=Zg5YR/PPZZRJkTeJDeu1nXEvaLQ078Z0APYPe22Qd8NhY2Tu55D/9hNLZ1+MFZR7JMklPMHIP9wyQwtuK/FY+PFXvpB2krFlNgSOhaDCufrtwDkZk95NrFLA8HaHn6otUyuoLrK78k7POafU1u0HTqG5xh9hs/lyiLRdx2ma0q11fusxe8aD4Za0UM/+oJU0G9UpZP/3BLJ7mkqtijoHKPrzSQRCf2ousf6oVjWhsZPrqv3fkyHX0/2eRtWVfwi5vUus8QAc5oxoBw8+9QUSTlnRhbO2vf5UnakJJ4m3DRw5z5+AYbg/CV1fpPcJ4y5hpTd0dVp3hhSDyCL8kArTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RqzJUK0hW5rXWVWYVwK5RV0B+87sLmgtIPQ8u1AZQ0=;
 b=LnpszylQfhtwoGJbaBFJjBvW/rwhRsbJ704z776+JNnu3B9rUkxF+awWwHtNUgV3lJNDnIZKuHMR1jdhdtx9P56+UC0xfTADsFkgNsNtv5C6geM1qOlErvrDebTBUlLBLCBu4cCL1pCbuWgUJ4JQi2t1azINi8do6plXSUbO5w0=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:57:56 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::ad) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 15:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 15:57:55 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 09:57:52 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix an uninitialized variable
Date: Mon, 9 Jan 2023 21:27:35 +0530
Message-ID: <20230109155735.1442464-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab4a8ae-6f8d-4a60-babe-08daf25a45eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVAhfYbe0ULKOvKGbZ4VJpRRn6WbxdgOYtDsnsVnNQl/LsgFvZ0dbdh2aOiSjwBVS6a8rdGbFjX+nW9OpOo4E4UGBp6uIWopJHRnfAwzwcw2jNL8xhYkg9i44nzAKx81oshe7H7rKPD9PM/QcsFgOlm/Y0sNN+XCSnItv3xeNYJvK9qwUJBvIZlhmkHSLRE73+8v9wwg/g9XuZZd1XOA+L26VZmDxSN/ryN0KQ3LPeklmnnIc3PCVm/ZFhRtMbQPY3Zr+vSrOLgWAk6vfv2MJZwNzjKjFgseoAilaaroeqsOjMGLozDK3Sm/E9HydT51ywUAOd8US0/A76RcgNuc/Tgs7vHKA2Uw9xhkLgUL5rqluw/XXrOK39CB7+V2AaNSi34RH+Y0rlzF/q43bxnEkvkHxhb1gfEHtyAUNfnI7+7jJhiZDJ7fB/h8xV9GkaoSWRQYxIV1RDi2/RZ8/gPrlNTJ8OCrwbaOJHs5zv+iseoaLpn5cotNzJZNO6smvNqTZU9VeFssQPAm5Bx/H+cjHBBU/89ggYVg6EXuxnSqbvxFxohhdxoSVmvS32xo4Flhl3oa0n/bM9YXXsf3xZ62spdxB2cMxC+t/zyuW571eA/CaQSq0NOF8KJkWBZkgeLUBBKMy2+y700b4gJg/QVvXxgHoGI07IZ+I+bJBggRPdgdpOVwX8ZWUK/970/G15dangTNq28S6ZNum1ZfwhagPMKOBPjOIQ9/6CDLC7zlXoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(110136005)(356005)(6636002)(82310400005)(41300700001)(478600001)(2906002)(316002)(82740400003)(6666004)(44832011)(36860700001)(4326008)(1076003)(336012)(83380400001)(8676002)(16526019)(186003)(26005)(40480700001)(86362001)(7696005)(40460700003)(5660300002)(36756003)(2616005)(81166007)(70206006)(70586007)(47076005)(426003)(66574015)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 15:57:55.8682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab4a8ae-6f8d-4a60-babe-08daf25a45eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Mario
 Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.o
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:217:71: error: variable 'i' is uninitialized when used here [-Werror,-Wuninitialized]
                snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, i);
                                                                                    ^
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:207:16: note: initialize the variable 'i' to silence this warning
        int err = 0, i;
                      ^
                       = 0

As suggested by Christian, buggy
"snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, i);"
shouldn't be "i" in the first place, but rather using "instance",
because for instance greater than 0, we want to have different
sdma firmware for different instance we add the instance number.

Remove setting err to 0 as well. This is considered very bad coding style.

Cc: Christian König <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I2f1180af4f37bf1efd4d47e7bf64425b0b3809fb
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0e1e2521fe25a..e9b78739b9ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -204,7 +204,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 {
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
-	int err = 0, i;
+	int err, i;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr;
 	uint16_t version_major;
 	char ucode_prefix[30];
@@ -214,7 +214,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	if (instance == 0)
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, i);
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, instance);
 	err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, fw_name);
 	if (err)
 		goto out;
-- 
2.25.1

