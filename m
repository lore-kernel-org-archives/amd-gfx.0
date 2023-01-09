Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F85C5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 08:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C3810E28C;
	Mon,  9 Jan 2023 08:29:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D61810E28C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 08:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAdpmdNfyPB3s/NgMXpufNwfX6z4FtWO74lQ1o+aTnvgL2eJ5b4qavoWgqN2XkaCH8ZoY+dIwlCnU7Xf448BfZLbQ5YpF0V/OuKPx6/BWmJ9H25qaCSV9NfdbIkxGCAT70i7sOc3y3BP6ug70GZyuOiuWXyi4nlMN6sAD2AtDO+B1gct6v82nuN9nWgJb0vcOiiar3QUnG7U2fj5v+s6sTIGCIl1vaD2+VPH8FTBHjwXVc6AclF33bUXZ9uRSKlHnRgZpV2Gw/R6L8tbcGqSWYfX1BzliVKGCFpNdTHeAjTkBX+lvtxv5Vqx/NRdT4emU+zU0M1ECnwD/EhfKy5grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrirSJO0aphrqfh5qTSsiMaV8DUCpSWzNlRlhpLaeAU=;
 b=hH3t0CsZrCyN2waTIJhkwX3pRxWUk0CAUM39dsrPRDnbO3s7R0AJYwX6fcwzb2in+ISlms0NQNYiX1QYA0sqhbemPuYUXEDvpfEOPul68s2owb9Nc9lfm3osAnlK0sW0xUBOReEInQnOWrzPxb1JpPA2V8Nl4zzKo0nnCZ9oZUz0Daum9c9L/vxzJwBFQOlLOKeZtLgPv7SUUTnq7v1NH2h+npS8Z+hrtcCwDTKgWZWoRhQClp5ClqNmhQuNJZlkxAe9ZhrJDZHhEpL6FF01GzmRdfEIRQ6R91aVBS/0vRtZ09D1v1dNEfPlBZEn1B2byPYz/ZatJT3JfSbYs8i1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrirSJO0aphrqfh5qTSsiMaV8DUCpSWzNlRlhpLaeAU=;
 b=MLM58W6ytQxj5kfHrJS3wU5JggIEGn46+r8lwDkyrwcEzusglefHnMBk3n3SusKk3Livw5eqsHIBctQsirkADe6OkK/ktia0PHyZrf5pJ9DpVQBFfAopW+fD5ZJ/IUW/TOgq2zcexglHajtqcnH7TqCfi+tpxBGwDf7x7/WFAb4=
Received: from BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::8)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 08:29:42 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::f3) by BN9P222CA0003.outlook.office365.com
 (2603:10b6:408:10c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 08:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 08:29:42 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 02:29:40 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix an uninitialized variable
Date: Mon, 9 Jan 2023 13:59:16 +0530
Message-ID: <20230109082916.1307570-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0c3a6b-21f4-442f-38e9-08daf21ba810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMkvvWnwsYdHpJ9c1Smc3NrELrroxEVS+m2qO+Quhy+51B0/zQUvPEwg/8sNfnG/u/IFgPrm4YueDqMeGny87hRkiKx1APzQ8ReaOnbVm0KyHlO12bwo+Ab5uebDx8otslQjymro2hCtqjWHHyVjjdzX0JeO7ihVWEiF9PR50Jj4igenSYc4ZVtjVBkj7rPGSEGA1RmYKKdwVTHewqN1OYvHlbME6b7Wu3f/lofMFA/VmK2OgnNTQWkn5QwisuOk5PS7DL8AYybw+b0UJsa5+q9l35/7ibc2kgq9z8qq16VfJv7HagVzqQrrL6IrTZol5sGaA/W/bTzbi1R3FjQ4kCUMoRRCH833ebf3Wk5EQtmqS6jRuMI4AcBj6utIsznMcEbyee/+ygITIkYHpfx9Rffoqlc61o7PqNv+y7v9EfK3SjS+dR04aI7rLiC97otqK1NqLIofBfeWjkntbS9x0GfMP8kdvbB5ixNZ2qKPyMpHYC7Lh4Jjl+6WVNDHBqSLwEQUH2E1aN39ht95+fnrY59lQWCfyzXG5lDL7ATIwsVXvc70LV1RlHH6CQ06TLDYDEQZyKjrXE6GM83tlYrDcUvcN7VmOkoSe6HkEr1yPdOes+CIC62DxOAM8gJ/ISn4L/NuxPZr+Rd4ZX4QvuVOTXd7zi5CUNmnD5HkXXH3tOJ0mK57gernn0JDWSJ7tQvY+/JVcNyA0e8o5gidVpeZmb8Rbas0ol+KuSGcSqamWtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(316002)(40480700001)(44832011)(26005)(7696005)(16526019)(186003)(478600001)(2616005)(41300700001)(426003)(40460700003)(47076005)(110136005)(6636002)(70206006)(336012)(54906003)(4326008)(8676002)(70586007)(8936002)(82310400005)(83380400001)(86362001)(36756003)(6666004)(36860700001)(82740400003)(356005)(2906002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 08:29:42.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0c3a6b-21f4-442f-38e9-08daf21ba810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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
 amd-gfx@lists.freedesktop.org
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

Initialize the variable 'i'.

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0e1e2521fe25a..64f2b855a378a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -204,7 +204,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 {
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
-	int err = 0, i;
+	int err = 0, i = 0;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr;
 	uint16_t version_major;
 	char ucode_prefix[30];
-- 
2.25.1

