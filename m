Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B083ECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2680810E11D;
	Fri, 26 Aug 2022 18:43:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C88E10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz/KecIHb/ro4V9bJyaAzenGRl+PMJQKCANk1oyGDPzt5ELL6bC7H72wX6bWTHvJ15EmjIy1rZazoace99VOc/l9xJaulYYCqu12LDCkZZspmzgX9Uo5mjgjME6ji1YM/hoCwkgruEHjy6FhbT2wpsJpILYY4u/eaDscPOuJuNci8LZ0SmhSp8aUiyzq1khAuPelrS9HJgydN9DLL78PAgVCBRwmCm8W31nD3RnOrVyfnT5QL83xT18upFipxeeh4dFQLT+DaFGiG6k8uKIxCsz3J1Ed0G8cwBjceV+pQlQaTA1Mo2g0YjeCCZizWSMy03aYGtXypB5Hdeg14a9nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOh4C1nuT0vBU8ziqDRUfLzHLRTtzS0+xegbNEGxQ/E=;
 b=Kz4jJhgI4wsty+JdIEtqgSF2mWgpcD5XpuwRXyJEodgbKj+b6J1sLrO7uVBkQ+YY7r9Egaoj7ut5hlGuA04F7gnUJ029sBi1OM3urPsYjLKFV0p0jP91i+8r9EvNHRbEqHyggx253n5RewGfzeJ0B3qPojrvAqAv986+kDxMIZzs0ZPJJXBDsKFak149dwLI0t5WToAuUBa0Wf9GsBxM4IjQmG4F4W14OHtENWKUHCa+tIOoNPHFq4J2RBO8smZ4oEkeH6HwvJ4HYKKbvstc6XnwGkvuvil8UqaSL4Wh8CHQMKjv0+xyOCzmTfhPrAKfm+R3v93+uLlxPPK26jzO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOh4C1nuT0vBU8ziqDRUfLzHLRTtzS0+xegbNEGxQ/E=;
 b=TPiHqMlR6Txj26tv93L+ZOT6qhwtesG1jrNKAV86OhpN4rrEXif65tiO0cAbqZ9kybY7NMIUPzkeKg6MPmoPLwdgadQTnBAoJq+6j4e+TxnVTXmuv/AsLjfeBMSgoweU0XOwOTjR0qd1hM4vypyhmBPe0H5Smvrx9Uix13rhJ6Y=
Received: from BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14)
 by MWHPR1201MB0095.namprd12.prod.outlook.com (2603:10b6:301:4e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:43:02 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::95) by BN9PR03CA0039.outlook.office365.com
 (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:43:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new ip block for SOC21
Date: Fri, 26 Aug 2022 14:42:45 -0400
Message-ID: <20220826184245.855216-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184245.855216-1-alexander.deucher@amd.com>
References: <20220826184245.855216-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a99632-5b0c-4a0a-eaa6-08da8792ce79
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obO0ERo/ZNesw+276JIw0OJNJjTca8jT2J5wQvxT7DGUHGjBuokOWOk7w2nErAReVqli8O1Zj2cB0n4RnstrSbkcVIwaepGsBtyN7hs9hoaA0ALhn1Dt1Lb4vrKPJZFIF584dhFRnpmFPnb1fDwTbWV16fKd5MeOE+IcQJD/DdtgRBFwPMs436fDlAu8UtcC8VT2lIf6gUU6t8hEUkQqx55bE/tDv48G7+5uGkizUGiV8skadbzlNd2nrXPMeIWp6v5qvqLcIhHfuFZYBoQt9fsICEd7+EFwLDh+CuJeGGX5k6w72My8qKsDyB0XeOcn9PIlIn7epxF0s9vQGTl1H2lf+lpBUYCq3EqqcYkknmeKbvKj6LaMA/rodX8ILDmbHgzifInOAtZYKN58PVfn0apc8XeJnI5QyjSWEnft6nWILcW6IWKMWmBog0OcvimJqoi8wOIwbrk94iE2F3/ibTKO1BwwMYbf0cr0ELK2bQ5hTcUkf0iVuOFXK8ky6+mpRp/UI1KTfCNxQNlWmdVwy3T5buoXrpdgYhj4yigZbxqMPLwSdJqfzTay3U7inoysvo8QFO+VKAYXvLJepLUkJ+6T/8M+CxnX1QFwQqWQY5dip+QEISRHP86o3kferp7pC36+8TRzHm30G2u1al6PTGPLCn+x8KaAclCvsWOq2+B9wZJXq3ItzIH0nnoiy4V5kYoCu7mhtOOdFsz0RjWqIGbFcYGuyOP0f8KGu4vgDed4EonT1t+xN3m6dMDC5kBgAeB9Cq5UvBOt9bw1sVz/BMGxz9bjr9hQtT4ViEthkxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(83380400001)(336012)(356005)(2616005)(186003)(6666004)(478600001)(36756003)(1076003)(26005)(41300700001)(16526019)(7696005)(36860700001)(2906002)(426003)(47076005)(40460700003)(82740400003)(4744005)(81166007)(5660300002)(6916009)(82310400005)(8936002)(54906003)(316002)(86362001)(40480700001)(70206006)(8676002)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:02.4636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a99632-5b0c-4a0a-eaa6-08da8792ce79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0095
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for soc21_common.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 95d34590cad1..c2e8a9fe81f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1506,6 +1506,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	default:
-- 
2.37.1

