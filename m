Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FEC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29DA61445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29DA61445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8402D6EC88;
	Thu, 29 Apr 2021 06:26:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122036EC8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmE/AOZdPyzuF8HpKmAlwW+NkhgN/XAQpFDeldYosMEiw5sJ6TIU29jTMQSX/+fcwpLqFFDCssu5/+oYt/ehd0+KqjAvc3Qdf9Wu0zxduMeRg2+0tIl6RA6ORXBvxo8BgT+c+z0VVjjCX8ZHufAKibji5c6edmMHWS/Y7Z0P2ti0O74IRtzIQaoTKCrg+F3U5Cil3aWpZW7rHS0ji68Fm8h4y0c3PLx0NIW2gU7AmKxdKDuKinI/iKV+2nQD/SOcXB6LTw64SdYwYoomdClSgpk5XoyYr2HmMjSUSsWqnTsvoTLYZ3f3UybKrG2GZSGhYAT80i88ILyqptcjF1xPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH4UJCATvzg8basJtOyHVKr2mz73lmb0Ec8Iz5ZhaY4=;
 b=MFkE+PZBmxLXM8f3C4v0a2YGXiiCmXf/ta6QSccVJ+OuwSCVc0Aabw68XmON/d1ZravBF5NW0f9yRg6ZBwJkulbfU2cCW8XDZNsZANgWC3rCrzyfe54FvhGrRAzBTNQOIKH1yC7wddeCVdsj2h+Pgh7tD0W+PqFFmvWWFQWKkM93Ed4J/syqRqdAdGeSky2OfX5+lxfQbkPbBayvMwJ5ng564J1ftAaJED5X2shCFTxRvYPHFgo/3JtzcO4ezca2/UyiWkJxrj9YNjhaYtXiFb4CHP6OW1cE0fOVVuhp/F1uXld70f1J/jlLiqyiwfZ8LV0p5gyYPe/aWRn4o7D6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH4UJCATvzg8basJtOyHVKr2mz73lmb0Ec8Iz5ZhaY4=;
 b=OQQri/PA1kc91ZBm/lOkfWbnrIOJIm2jVDFqGPe//7xMdWehGYYlfRD53Ipv6KSs1nCqG/AcUvb3IjtHI8Ns7St7rdUY9Gw0w+ycA+6fNFpq3O7eKrJtUjxkMmVSX2PHOnyK6K4Ob06WQfjxcgXUJLkU3Up/Dvcffu6o4htqVz4=
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 06:26:06 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::c2) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend
 Transport; Thu, 29 Apr 2021 06:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 06:26:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:26:05 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:26:03 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: init/fini hdp v4_0 ras
Date: Thu, 29 Apr 2021 14:25:44 +0800
Message-ID: <1619677546-2630-5-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cca36af-b963-4c45-808c-08d90ad7ab74
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-Microsoft-Antispam-PRVS: <DM6PR12MB404212E6E0A9918C5BCA9FC3FC5F9@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Fy6gMXTOz3Pdv9RC+hoe+SgxeMX7AdIYhGNsb6uTkvSxnUsjFmVsTTeYpeCGhw4fdqk2xNCff1lCYkBPPmXGTyiFrZsI7VD1m+eucnQRh99/GeeUgMberQ8YiyuiAinfYUj0XApgyqkbXhSIgIhjOCAmB6fwsahdcKN9egb3wc5La889L5Ia5upubifl/PS9FcAF2Vhxr5X4srcs3rlutXQcdmoBpQFtdrhEKijV4lqfgLapHLid3lI410jBmcm3L45hULWRKr0hQg6WmyVmzLSKf2uou5xptDiBpwMMLGAW+tE0YQIiINk4Zb2kR8scuNQHb+OQmOOR48ehv2KFQZT8xFmGJsF8BKiTSQ7zUuggFQY5uGg6wx6h7x2PlIYuwsOOfkeaPilgh//wSEBprXnbUX/Dvo9kZq9HhfIG3gtit5YycoFKx7Rd1MdGvOBUDqKGyUmKvLN4EdBRDQLSihI6P7Yrkg9U+tkUuLcYDQggD0l/fa5LhRn+xYNte32cJb0LxPNXOYMod1H0wuecgp5IhT8O8eTRBN0dfCLVOpT7TdqWivP9ywMjrEl+2Ng3dFTupTeC217d41s7/2fw5+/igBJY0jM9LJls3miP40wTL9DlGOMC/EYfmHI/dAgNQMuEKMKnQ+THf+fT14Z3/YfuZA4ljubSzoWxZGV7vHpO3Qy0oCFTbtKoJdquTNx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(478600001)(4326008)(81166007)(70586007)(8676002)(5660300002)(356005)(426003)(2616005)(8936002)(4744005)(47076005)(336012)(6666004)(7696005)(2906002)(36756003)(26005)(186003)(110136005)(316002)(82310400003)(82740400003)(70206006)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:26:05.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cca36af-b963-4c45-808c-08d90ad7ab74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

invoke hdp v4_0 ras init in gmc late_init phase
while ras fini in gmc sw_fini phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index dfa67c2..697ab26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -455,6 +455,13 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->ras_late_init) {
+		r = adev->hdp.ras_funcs->ras_late_init(adev);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
@@ -471,6 +478,10 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
 		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
+
+	if (adev->hdp.ras_funcs &&
+	    adev->hdp.ras_funcs->ras_fini)
+		adev->hdp.ras_funcs->ras_fini(adev);
 }
 
 	/*
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
