Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73358C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E8010F387;
	Tue,  3 May 2022 20:29:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C246910EE60
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNLPzNkHxerc+HUCJGgu0vk9N2rYDkWiw8KTCgy58CwsT1TcClArdvIDQH0HI7dSppCqKeC7URD6dFAzWUkg9Ezvd5VnBgX7oRoAsBjNJSIlLe+O5Gwr61uVZt3YbKOedZGPFsrSNC9oRTlfGYgLLwBFA5Ckvbcj9FHHJ9VyOkN8zq5stKKzT1zXgEL1PWJkNAjEjD9cvlVikNxF4bHK/H3hNipKuE4IPhSDexexGzFnixmXxWGM5+lZWty0Uo5LIbInOUIvStE7ESCECwprTi1WbeZB1HrL/kUegn1YG3mru+wueTTXORLLdVxs5QzCuO435adtgGlINjoK0bWDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw2bFj9Hc/IitFOK7x01JHPIqRZAb6m20KrWK+wspUg=;
 b=CDLfoIpeudyUdpkbUzQikP4ZdT/si2BsS0kmewiForewuJ0G7e+j8wen3Iums7NA/g1WXlx4Syu8rXklcpD0VgMHP8gXCCtrW9ZyBB1SVxh3TfBVkSH/yq53llNJx84P9eBSataja0Lv4vIjQaX4ye/9JREliGUsvR20tXA8aNYQdQ6s7DXE/rcR9CblQDRAxAjpXPnHDcsqPwKaqVp5CJ7RviQjknplZOrWtBkPc4AFKyTAqSXhXbHt0clFro8iAXbAk6AEKR1e030FEgobTXQ/M9mF2oU8RLvp1//hos+GgpPpBkVPBIg2F+P53Tkoqbn7Ejc2lfLER/Av9d+i0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw2bFj9Hc/IitFOK7x01JHPIqRZAb6m20KrWK+wspUg=;
 b=fOMqGXUT63NAIarygJoofTA8i4sLbobC4PTn+pQ0K601Cf1ilLOTeeN0BkZzbSjZMDzeNtInFELMWuvXWQfxYm/UEVs3rm5F7uORY3dA7q4lEHSouXblO12VWxwRUfdpGabeD/ZZ79a2BLnws9CLB9K46ziBHLDlFLhcv5gww2Q=
Received: from DM6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:5:bc::32) by
 DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Tue, 3 May 2022 20:29:35 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::79) by DM6PR13CA0019.outlook.office365.com
 (2603:10b6:5:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.11 via Frontend
 Transport; Tue, 3 May 2022 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add mes11 support for GC 11.0.2
Date: Tue, 3 May 2022 16:29:05 -0400
Message-ID: <20220503202912.1211009-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb194792-9032-4e26-e599-08da2d43a349
X-MS-TrafficTypeDiagnostic: DM4PR12MB6326:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6326329EF479398D8B15B988F7C09@DM4PR12MB6326.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsSLmlAEpvlT5/j9l1ryP39/oTshfW9WrYdOc34YHnnQI/XqXTCl8VOSds5i6eOzyrzdtnKoj+zP3aLNn7flu1+8G1nXi2JceLvlvASQbbC10GoNrSwgKozuIPhmJDn45vlN9RUEux3JKFfN1yfcLwQPC1kHz/DDQBcVRnesN1Is/nQ/YXRQyr+ubuPJqtfbJoD0jjYBnj+huxioIuVWbk0RdBCmqaOu0u5PVcH/WuCih32fcScDEPqHzCqzMdye1JCR2EGjR6KR8Im6TkSnRAPuKfXs1CRZyWuIWS2mFxkdGVT6lYq1nJlssjP8yhx1y8Cw21UN3JBCMfcQCdHBRBg1XwrXPxCO3Gudl7glCNUV433Ek0wrFgbwJiOycsMeQzrEtq2lxbi0cP14WeDzmAtf7x6vFiAvVb0U+/ptm6hmdVXlBPDlCVApIQwRO0pXH77qZw36/3YCKZQXVEcS6NsBguOWC5BywYJ60tn6Iz0fxd+5TrsqOCZH5u5KhWyNhM8NLIYslOJPE9JoAAahYO2bElPozgw9YQ5CRas1lz5cgS38cqs/WRKdbKO50EiwyQ/iaFAZZKUjShokekK3ladtwH5NNpWqimENCFTqtOlTiS/fnbYMh5iqMC/6H8XzNoewiSH2W19ra8djd5mxp6x9sx7B+HhZropUqgaJel41DTM5PyNLVhPp2buv9mRFdcQ6lp7kUIe0aZsDchj5UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(36756003)(186003)(8676002)(16526019)(70206006)(1076003)(70586007)(40460700003)(4744005)(426003)(336012)(47076005)(4326008)(5660300002)(8936002)(36860700001)(508600001)(54906003)(82310400005)(26005)(81166007)(83380400001)(6916009)(356005)(6666004)(7696005)(86362001)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:35.0996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb194792-9032-4e26-e599-08da2d43a349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable Micro Engine Scheduler support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 903d75aec75c..8d7b087b56fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1899,6 +1899,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		}
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-- 
2.35.1

