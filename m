Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A74C43219
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3826510EF21;
	Thu,  5 May 2022 20:11:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B2210EF21
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG6fXg1xL1MPdPstJfQ6frkcrqH5e5NFRZaJ+W1U0KSJ9j2mOvDk9u31mSJXxO8CC2KRgBFcNjCBwM2zwa+PGSeKqilnsUV/mI9BSt2Moqs0bhOmBNQqRPPOdqzPJG+mcyegglVBLpeWtbwM8HQEORyrjSN1u80bWsc2ExK4XiTeta4Y12pbmrCnVEw4IC8KiC1pbUHHGHMyPQYfDXcukgsUpcC7DMDDEMl2b27eo47hWJJwX5wOLre0yHtkbe3cyewgoEvc5t+/g2gjKBpFC4VIQuUOg6LpXGPcownosD22yds1QZxfhfYLiw7g6QM8ui0lPH4ScZFZPw46f4k67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ3Kyo3jsei0FBwzNxacZjlq8o32UZ7VsTDEPGvlDVs=;
 b=fwprGtWVP1Yb7z9pV9qUaN+xbc6tuFzS/Dz0OKz29MPrBJ7ZvesPOZ56OiGxsYK5/DmaybrUcUZu7XbtkkWKNcGs4gwmmyFIJ/gDDzMnJW/bz4814fPeGKvaSxmTXXrTyFi5wF/tdqutAZrTU6BhPXPtMkrP6iNKj63cNNg7KYtAuR3+Nb6gKdvlrkZIbwiLiypcRnniG+D07wGslosb4Xr2qPRLRw5gy5uoqanZQ117urNuWKV0UYByYadNv205idZ5DlgglhdMcy4LRFY928ZvLhCRHqY1PRGoVqWz8Q75FLRffJhuMp0YbsDqK0N2IURngcyZzw+djoZV4A5xJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ3Kyo3jsei0FBwzNxacZjlq8o32UZ7VsTDEPGvlDVs=;
 b=WCqtMONu8ctPAkdY7Yk9aCcfRZ8e/fEj2fMqQhRRAuIRzWffISdnNut2kSqmNK7Nle72NNSlfeObahAbekIf5whi9GAafwqhLOkaR2H+U9SoLDAOK5lDvxHV3IcI8+WlAwR4bBIkycVs0kwrbiduKlqzNUQIVxIfcNOj99NyqWQ=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by DM5PR12MB1946.namprd12.prod.outlook.com (2603:10b6:3:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 20:11:28 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::53) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 20:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:11:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:11:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add SMU v13.0.4 into the IP discovery
 list
Date: Thu, 5 May 2022 16:11:15 -0400
Message-ID: <20220505201115.1293848-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51d89dd-4393-4e17-9e5d-08da2ed37005
X-MS-TrafficTypeDiagnostic: DM5PR12MB1946:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB19461C0E313C8AB619074836F7C29@DM5PR12MB1946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8L0DpGg2iSdaSsUfw6PwwYDIE5ODtiRcWrCsENjoK1Fvom0JUX/5EYxYhi35CzjnGOiLBC8limnX+b9vFAl+/HcG0JhJL/HtmGR6Hy6CvLcjWespowTbgZc7l5pDrRkb3nyFhHBuoyFxYrDCckgvBYz7j5lmBokrOByRUub/4lprWlNTI0UG7D8qBnvameVQ+zpPgaUI1u3oBtH0atTqy8SbFPtltTsGK1dEEDLWs6vjxOO3tcBRY0XCsLTcjeWI26+YUfPf3vygzIA8cny/VLOk2kOqhICzhyUHIiHUN86Sv+qVkqJE2/9ah5cQeq4ZKG2r3AlvjpZtbZvNWCAcDA4UhY0FFF30wbJXk+nJS7vaynViwXr5hsYpXcfsnP0J30sBjpT8rK5aOzd7W6Bdycz6+LlbeYRLqmNkmvQSDmvzaZ9NrddiNiJ/rWIlqImYIf5VOZ/z/pGihrrrRDRAZkN9lMykw25yTz5k3EFtFogiCstDizQ6+gnhV6WJ2JEk9aTbVVOPwNNLhmQmOJGpcrlcBSLO1WhJeZI31gJtzhuVbPS5nffySVIyhY5CpKhcaNxvDRAhnujIuPfJEE//Ac1axjKnCMHOaiD/oZMbYOPPO1OVQEGHfRkmHZ1D+D6rwZqqX8VE5eV4gg5vdfF/dm5RZpyBSHmmbSLidKNY4mYNEJoYXeyWmSVzj0RwRPHLllUWL/sQbySOl1ui745vfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(336012)(40460700003)(16526019)(508600001)(186003)(47076005)(426003)(26005)(6666004)(7696005)(356005)(2906002)(8936002)(4744005)(81166007)(82310400005)(5660300002)(54906003)(316002)(6916009)(86362001)(4326008)(8676002)(70206006)(36756003)(70586007)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:11:27.7802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51d89dd-4393-4e17-9e5d-08da2ed37005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1946
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will add SMU v13.0.4 into the IP discovery list.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d7b0fd1cad62..881570dced41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1656,6 +1656,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
-- 
2.35.1

