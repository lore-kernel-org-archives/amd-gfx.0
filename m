Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AF8C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 04:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5B410E43B;
	Tue, 28 Mar 2023 04:07:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07A510E43B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 04:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRloqb+M6yjg1ZvhdY7QtwZNVzyR9slfsV6dTtzq57c1bO0DrJTB2KA4bRyl8hpKm6qkVlYqDW93+nrZSO4PyaNhyaKqbaW2+V3+VZxtAl6kaVMMJCjJHTOMmnhXtDV34LwvwnR8tCpxtpJH73I6kvc4qkONWw2zf2g7C2ab2LADDwOxh82MM4JPvAJ/UJCsTcHz1jMEy6hzbSRb7PZhr3O0vs/eZoa2gFSyapCukwKiH0SJRpGIFtHP3NAS5j/9D03QcawgD388KSi5554MpzEG3zFyLItSFkXjUKR4H6nTEq3ajNo10RtC/BfXi6y5+Neixra9hE1O1sx3wvxsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs86gNeGIn3Y2xx4oYZ34XBL99dac8N1Wm9rmwNpUQc=;
 b=S82uFUBRqCIUxrwdm+00V2aAcVjDcz7Eyk19Ewy/RS3e65R5pY0lDidW/9vmuxwchSp2Am4Us0PD/eQmv3UsURPs6wntBrhS0uiICwsnVWkmigoZL4M9PfMDMSInm73KGcs8woiPLq49D0e6UrgRZcOWBrxM/RkEwJJ+gtdrDeAC0RBDXTCaaytNj6suvpSRawTMpXgKPBBQJRLhC71n6IrwGCnc3bN3nxV8CTHMox3MdObIcxIRp7rd7eRLFFxM8W1+eWn4UkslI+uvgmu4YFEu3OnyXttDrEnvGss8M+GDe/pQy0zZfphLy/8y+aVoEt1/SEIo73evoTWf3lvCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs86gNeGIn3Y2xx4oYZ34XBL99dac8N1Wm9rmwNpUQc=;
 b=K2iXQJF3XvLReXddN7ZeSMVe16+2MKV1KTIai49yIJrdNbycL7tlCTiZrzwtzSQNYnbewYysJ54nA/9BhNpjT62WK25hjpquWqxpZhtILyhJxpYyKDkKmw8JQpRG7QvtJP2OPAgS24Tyl0KuhZC8DXqkBO6877Tu2hdwT3/HH28=
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 04:07:40 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::21) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 04:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 04:07:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 23:07:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 21:07:35 -0700
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Mar 2023 23:07:33 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Horace.Chen@amd.com>, <Hawking.Zhang@amd.com>, <haijun.chang@amd.com>
Subject: [PATCH] drm/amdgpu: Add JPEG IP block to SRIOV reinit
Date: Tue, 28 Mar 2023 12:06:51 +0800
Message-ID: <20230328040650.3306297-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a8eed4-d6b6-4446-71de-08db2f41f8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um7hKjbiXcQwKwIqTnXRepR7D/OnTOtzboLOcF8xoUPeF1QwlxnZXzUzpDaQ0wxu1haaKNb8bORSK7pxhSrDqFyKTKPNJe+dd63YGJDedSruHEdcKgws8yTUJQkVZqpGgZFVwXhSoTEQbO49T8UCqAy+Isck19CDTJ11ZcSHLEJKXXB7FuSGhDH/nFdxQ0UK7SwV2W1wZlZp2YGHD+YD38XPH+6EGtE/V+jMdOcJuZKFPVJuEF27P0dupPdAJgSFi1yVuAXSAL3x57f0wuvB7pidhmQukB+3zfFAKIAIXIKlu0SpXR87l6YwEPU0aU2E5Icfg5/A0VZUvUV9F6z7aVvIFFLstv/3cfcFUD98MUD0EEPkpj7HmTA/e7JjaE6u/Fn4AUCwhUj+9tINWkxhU+cmxjAB+Ea3HrP7NBdOg3tEVn6BF0ZovC6CDc096gvBdu4PXsYW5elTIW9N3w4aPiRm3G7sqpl5dZlJ/VN+AM2gV4gTTcZHEjqfCcj99ada30lEU185+rOeq6EfFxjicAd89og5rVrhWjBAvnsMq9Lc4CCLmR45jZeLLOjl3A2BNVj81EfgrEUEfvTW8VhlzH2pyL9bghHWIMBkUPUevKhrx0Zr9p1Cq4TKJGbhlayfkKF+6w/k8LMlbqu7KAc1K/u4qxN9xVBeEqrf2wJfUWrYLV7vxyLY4dmVdACZP3t5goy/zXW/4deGqrVmxVmr6x9VZyeOCCUbkntYylWUed7pbMVI5XQWQao0l/2rPWVM0lO7VikwC23k7Ic16dUsEwXkJcbhqtyu3dSus/KG1sNjnAgKt503yl0FLLPw+vPm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(36860700001)(40460700003)(40480700001)(86362001)(36756003)(82310400005)(356005)(2906002)(6666004)(4326008)(186003)(478600001)(26005)(1076003)(5660300002)(8936002)(7696005)(41300700001)(4744005)(110136005)(316002)(336012)(8676002)(2616005)(83380400001)(6636002)(47076005)(70206006)(70586007)(426003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 04:07:39.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a8eed4-d6b6-4446-71de-08db2f41f8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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
Cc: Yifan Zha <Yifan.Zha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Reset(mode1) failed as JPRG IP did not reinit under sriov.

[How]
Add JPEG IP block to sriov reinit function.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 065f5396d0ce..3b6b85d9e0be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3183,7 +3183,8 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_MES,
 		AMD_IP_BLOCK_TYPE_UVD,
 		AMD_IP_BLOCK_TYPE_VCE,
-		AMD_IP_BLOCK_TYPE_VCN
+		AMD_IP_BLOCK_TYPE_VCN,
+		AMD_IP_BLOCK_TYPE_JPEG
 	};
 
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
-- 
2.25.1

