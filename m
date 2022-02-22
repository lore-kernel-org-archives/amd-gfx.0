Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262EFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 20:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4BD10E625;
	Tue, 22 Feb 2022 20:57:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6754010E625
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 20:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAnybweYJuBnD6peoIMknvPOjJt6oyuJXgFfuCMJ/LuW82swRIK+kV6eY/JRmYuzkpm0VNdowh0ItoqOnf3Y73CGDsShTmdiYsuNIKtCqsT9FmRFxVd0c0/H2Y+UUBDHT/oYO4e8uaIVJBf2hXK+j0DUpWQH77472y4/ot+KFmdEPnjr2T8mQ0IUVA0FahRF1zajxmzsB/cQ3o8DQg55gMY9oDZHQEXvhVYTKFsj+Y9pp1wXD/pxNaCaSGzyZtqLKtAFv7ZFe1KvRThki0Iy3KWT3yd8hDPLWrgD6CJzISMyc+BWwksaLH0mrRLnafD38YmwoKZTM1g7s3D8+5Mguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETz1rf+D63+emw+NicEBL5ScFutUiRKL6I9jFOxP4F4=;
 b=FKMAI63oaFg6v/54yLc8IdrUKCA9htAswL3QbTndf9lP546nq9EcASDazTNBPYWZpZJ6Of9S6URVJXtmB6IvybasY6nqoKgMVhZr8JANsOZa3ZvsxuaonVxX7ia3Vt+Crh3VUUrihdlMYpedSwXoozfUdMr4KkGyntU0UAupH2pOeBUM7AGieL9jfJw8Eo+uW2WSTNtYJl0PcT+jzHdwCt/LTsvEFXRXtjZOWz053uFwca7ls3QBhUUIRgjXdID5jnU1juo+PgvEUlKBrKD1+6Gny62SB/1Rw18+P0Yvz3wxeRPO80ArCyc11UjylVAAC7LveMU4Ei9zniTK0+RJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETz1rf+D63+emw+NicEBL5ScFutUiRKL6I9jFOxP4F4=;
 b=Jov9cSkrC54HiCE8Jf101ndYP8SaErVe7Zfh6G+8BUb3THQl9RiWKps9x36xJPUPL+cSbQGIhs8d4h73791187pGelDfJ1uw8Ug9nI1LBKMM1hQRtt97Va+TmdY2rmOtyhHrDcQ0nsqMnqI+4O4t2g2usfgOOAnjdGBH0B47ftg=
Received: from BN8PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:d4::15)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 20:57:02 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::50) by BN8PR04CA0041.outlook.office365.com
 (2603:10b6:408:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 20:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 20:57:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 14:57:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix typo in amdgpu_discovery.c
Date: Tue, 22 Feb 2022 15:56:43 -0500
Message-ID: <20220222205643.1372087-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db17b35-d620-4e4a-7270-08d9f645e059
X-MS-TrafficTypeDiagnostic: BL1PR12MB5924:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5924EEE2871BC8E06962CE9CF73B9@BL1PR12MB5924.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRE/0gFk+wtHTlw9H4KYAuI9Wyip4aEHyZkuVeMMhitkft9xJsqNsMQoIxkMMMAHvyXUH+fBAwrlDV7z/0/OMI3MpkfB98PC7hOpVt5KchgwIQCxE3ADC0p5os13T49JP1xQFWVCz1N36uIJBiNHs8/i7Fo1eQgZe8AVuuSIGqO/m3inG9n6f7LSkReIk6GSm2cWadCis2RUN4GumhbqPIIDXjqmbE/gLieYeLDdMuWHteH2Tjw3lHKUmVlEGjzjO7sgQD5CpaztwoPzJZRn4aC6xvM666yAABB6wilHhvros6v+96SDvgxz+78yn5EWIOR+3BHiRtKHVQJ8vVo/EFO6jcS/BV569DN0bcQ0wFpIEfPu7z6ggZiHU1zfUmYe2szqQNAz7JaxONiJ6t3QFmdpdcRaRwsfwsSYRu6QJlrzs2GER8sF9Hyod3DCcARt2tXM9L+wewwZ1DeYcmOahvsFe3tonWcc34EPxA2PYPy8IEPllukKLoEhGBKkQlH9IUCsRXtWuODwW3K9O8haKfU0rDr46r6VBKMbnvJE1OZmnUEhpgJAHsEP7ZcIueXXyQqiIxQ8FLpR8MWmK//8FLQNGD1WHahV0GYx9lCkuHnWxpVfItIV+nrGvnRkIb6FMbtDgXnk5lx/idgfuP0xUfP+vwGPzKlPOKkI1jpUav7DUlFHw/kW3hnRMEtvnP+quRoHV8v3BmujkonIoQH9JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(70586007)(36756003)(6916009)(4326008)(83380400001)(36860700001)(70206006)(1076003)(426003)(336012)(26005)(2616005)(508600001)(16526019)(316002)(8676002)(186003)(82310400004)(8936002)(40460700003)(5660300002)(6666004)(7696005)(86362001)(356005)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 20:57:02.6145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db17b35-d620-4e4a-7270-08d9f645e059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

disocvery -> discovery

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2e0ff1ace6fc..e4fcbb385a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -435,8 +435,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	}
 }
 
-static void amdgpu_disocvery_read_from_harvest_table(struct amdgpu_device *adev,
-						uint32_t *vcn_harvest_count)
+static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
+						     uint32_t *vcn_harvest_count)
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
@@ -1140,7 +1140,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			amdgpu_discovery_read_harvest_bit_per_ip(adev,
 				&vcn_harvest_count);
 	} else {
-		amdgpu_disocvery_read_from_harvest_table(adev,
+		amdgpu_discovery_read_from_harvest_table(adev,
 			&vcn_harvest_count);
 	}
 
-- 
2.35.1

