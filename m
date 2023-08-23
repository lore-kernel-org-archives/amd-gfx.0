Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B5EE49B9
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D8510E45D;
	Wed, 23 Aug 2023 15:52:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D908110E446
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWa4YEcuIrK8p2dOfrdtrQ/02siqCBSetwCOxayORTx/7F6r2u4tmQRY3CBL4ilDsrjlhcnXGHjdJlZe8KIJtSc3yjqyUf7KGk2sw5Y3FaNtdQVLZMcUfZOb0b5I7MCRTOaBqIVc7FTgmRfByMR4BvbmXpaooNYwcgM1yYLBZme1XC/psF9JJZKvMH7M4fYbWnaikOEwjaV7om2nVguRDw0gMBmB8FhURKStkyOaEiPEzg+vVvAP9rITfmbierMH0+KKsEdv2zr0YDUjffzJSfptqU9gS3d6z4+JKzUPxVB7MAA783r3Mi/lYIhhrzuoVu8I56JgYEe/sBv/0PmDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoOLdkFP01RDAXVLv3S3BSNyCrJVbIc/BmA64bekAH4=;
 b=irI2S9yQcjHubs+rhezZ2c28KjKsQgS5lPoMidpqezD/Qgicf63ZrpW148PHMPrDxjqvxznuYOpj84rDofhSVaKBT9ue6YoHZg9MDFHX7oBbWeqneBXUuO6z6v42He5u4pr8uz4U6DDSW0T+z5ujNa4eqtrm+gwuTimlrXbxwIPYedL9LDWQu4YntPdBI5HVTkOYpy4yCW754x8hDkIJsTEGQ6wdsLxKfupVl4ESJe10la29Yr4q1nNUmmsBhLZeg+8uZNYO6zUGjrPAPRTtdgZF6GK6La43xLYXsQZ4/nr3RfL/pOPqt5SdRN4n9RCsJ5EAKXmJrT2G0XPXk4a31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoOLdkFP01RDAXVLv3S3BSNyCrJVbIc/BmA64bekAH4=;
 b=sEMY6XwIE+O1dzU+7brpaM66rxxHjkgYm37JO05/IPhIOv4yLvUuaSCo8o69ORSzbWj9pLsk5J9FwtpYzjvuxw7VZAndm748+mNc+qr0KNSToYMqk0mPuPFb9IEOkL9oTdh5w5wTwLzrLMYMeD8tvkfzYkyw+636elkx/2gnnPE=
Received: from CY5PR19CA0056.namprd19.prod.outlook.com (2603:10b6:930:1a::25)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:28 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::15) by CY5PR19CA0056.outlook.office365.com
 (2603:10b6:930:1a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/35] drm/amdgpu/discovery: enable DCN 3.5.0 support
Date: Wed, 23 Aug 2023 11:50:48 -0400
Message-ID: <20230823155048.2526343-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6240d793-f772-4d54-66d6-08dba3f0d069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5uIL0aqoAMDp6BK3v4BH3iEwDpgKlVCGtzJV/PbmfM+VpImZFjvJyUJO4egUExQovaEzuWVL/8GBaYyqNAUAJRltC+X8zUGxiZR6gAcs1AAyfDSWwwn7fQ6jwHOZYDQ6U2q71lQijtUmMxRbwzdCKzhMdKsFsR3fdEBQ90+/gAtr5z4tnqjvY3mN/2QXMZQmeVN9im88FFimvafHMSepMl2WVcfQwwSSfHc3jaxKWQrgtVaSuJDFAP89hdLRIl+vWiReiCBl4TL3AA1+6r1UmgsxGba1RxOT0+2CaKcsJhPgeNTHbtn040eOVgVjoGMwgGKwFGrfFQcCm/YjcjQqKMdjGQOb8r1EbejTlPLqbCEMVpMhznexfqAah5sWHeIvW3Ir/JLiDc7paDsObfraEHum145VlOzjiyZ0Dcbn0htZQJ6ulVrG9/7rplQ1iztJubBQx3/ECC0nW1k4/cMHQZx8CGv9V8t4xru46lTfUZ0JlYm/VNtynpoINBEyO6nBt0omz23bwONC2SWB6p7yPxBVLpRe3jEiRYCSHD7/X4BF1Ytc5Jan6MZJ0BPx0GoEGKS1RSfdH0qacpoAV4eN84J5z1BRKMXqdMuKYtos8vfY1ACgSwGmTNioM+qyOzjQM+ot94vKTiiqsSQ3SuSsf6z7XrFJJZ6lO5QF/RvsPK8EL4uAtFctSRQWeyxTijSmXOoTgU+7A8wViREDaDy9oweG844ZahSAmNs4eObf5Y71lPVD4RYvrMzhXCiibMgJQPLDMYKLjl9uYlgH4cW9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(4744005)(83380400001)(40480700001)(7696005)(5660300002)(426003)(336012)(16526019)(26005)(86362001)(47076005)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(70586007)(54906003)(6916009)(478600001)(81166007)(82740400003)(356005)(6666004)(36756003)(40460700003)(41300700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:28.6010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6240d793-f772-4d54-66d6-08dba3f0d069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Enable DCN 3.5.0 support.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8fedf75224eb..9a1598ce1a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1883,6 +1883,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
-- 
2.41.0

