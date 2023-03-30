Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6401BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F266A10EFE6;
	Thu, 30 Mar 2023 19:42:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24ACC10E2D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyERWkM7+3t79Pr/5jMe/RMZ8kdl5hmj2zu0UIP6yGsTHWH3d/Dd7yEHFFCl/7ULg/e8/RbyjUeP60FIubKmXNm/ZQSSax+dYZCzyPkgjuS/Ilrd7G2nOijH+7Z8/J9IYeqWCX+CJz0J3U4EfNq5Y9ENlTbpPwuHrVQx/eo7cu1mkzN2K/NulywD4RuXM3Sas2UNDkh6cI/FFvjdOSC1gBZJ8+55ARCOVFfgRau2fsX0mFOrpmVyYjoVEQgzNaMDE4QBVClNZDUCF97Er2kq+o1es6Lfmm4ftTSZUqsx1BDAKOyUa7SoandrIcJj8KD4DCP7IwDEO+dj60dURujuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3cC6QpAHCwhgzgVgLp7D2Wj7ehI/OTAyjd698OgmFM=;
 b=h2zcBLkeSdAOHur8dT5fifleOdfWcvYjDCixwLmXc/fVNhCuvvVE5BYwjSibJfArXxPz7o9MUTFghONOBRkg367SEwf/zE0KQRaEzJlqJeLw0DP2jV2zayi3mAF7rSJdswOMn0lBuQmGmAXntP9w0OxEVZ0ShnI/6X1tlS4XHobtu1m1uArNsMRwZlUzEjMURfhVF4zCxHdTQk7nGgEbilBRcYl96JJ8eIevZuH+q/lszdI4cAwjkTiFpuitXHHpG6PDYigapcciqrRf3vFqL5nSgYwDBs+R3evspNljm749r3evPCkSXvIQ3IaPHOa24qp+SN3x3V2wtDc7G13PTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3cC6QpAHCwhgzgVgLp7D2Wj7ehI/OTAyjd698OgmFM=;
 b=ZYXCaAeWYsKd0eVe1bnQkjl8BomufTgdAdHAi4tp8WB6m4J7qApaeAZwydMdQzZuDyaLBwP92sw3FkiGNPIAi+wsZNK/O1iPj9IZWTORX0vSby7NiDCK2MaV7K7TGbOKg1YAytueMd36dh0C8cBP97E76q6BTc+mP0X80grnBGg=
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 30 Mar
 2023 19:42:50 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::58) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/23] drm/amdgpu: Move generic logic to soc config
Date: Thu, 30 Mar 2023 15:42:15 -0400
Message-ID: <20230330194234.1135527-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f71924e-2238-4a16-2848-08db3156f27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kn5BfkiXqCEb7J0cNdsBiCW2aYC5KF0Gq0d1B3AK0mNKtKCPX/K1NQPtyapE1gIgt2ekTIJu8XcyxDix+jwokNKeazKrywhmfKjEnhg59gcwUIxxa0pRix7ts5PXBT95XVvG2UAygABX9GYb2VQNY7GbC5yf1Mt6q1iwX5o+RRAkk9bDErPUGcAXLhdkl6HF0Sn3ZfySNthf4iGogNOo8zPHdMmhm1chRfz2dsMOwd23NLcWeCVFBkdq1WmNSsblXKaFNmgljWUCfmllqDiG0sQjExudR3OHxg3MeVmT2P2eQuhxlwg6ZZjpI7tcfYD9kC7ke1UsvLaygyOnan1BzjdANYynLcIDmI3g7rukWwvsE+MBANnbfYfNF2kKSQReDV1bM5azoQ0/LsZJNGRRz5qrfjAlv9cQf1ugl46nMhhwOhiv/u1wLkavJwKgv5Ahw8BadSWOtuytKUGIIMTm+7dZFhiX4N0i+lmgjDdCkM7R4xF1KDEtWupcSfo3kjd3WOT73b1uoDs/ZuuLkIFK4f+R6CnkPrmNxZ7up1tAN9sDcSQrj5TF374C4PoYgh98cpPqfVPIMdmlTHpHf07LITd96z/7qwEvxfsso8MXQGkRTm1ce6lPTWhmzghzif2Jif+xwXydafwDsoftAwEShrOKwrdEXlC+gTKyXoRva6UThnGA2gllDE4lxdjV9/rwGSuDhk+PH9DouBQ18kbA6MvwliOJtpC1tIKlpioMwftyRISxSrSFzHYtAgqa/M0dp4NExRehow583oGbD0TuWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(316002)(36756003)(8676002)(16526019)(1076003)(70586007)(54906003)(70206006)(41300700001)(40460700003)(36860700001)(2906002)(6916009)(81166007)(82740400003)(47076005)(5660300002)(40480700001)(7696005)(2616005)(6666004)(356005)(426003)(4326008)(186003)(26005)(86362001)(8936002)(478600001)(336012)(82310400005)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:50.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71924e-2238-4a16-2848-08db3156f27d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Move soc specific configuration details to aqua vanjaram specific file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 2cbac0bccd80..a6204b588829 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -359,6 +359,15 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
 	int ret;
 
+	/* generally 1 AID supports 4 instances */
+	adev->sdma.num_inst_per_aid = 4;
+	adev->sdma.num_instances = NUM_SDMA(adev->sdma.sdma_mask);
+
+	adev->vcn.num_inst_per_aid = 1;
+	adev->vcn.num_vcn_inst = adev->vcn.num_inst_per_aid * adev->num_aid;
+	adev->jpeg.num_inst_per_aid = 1;
+	adev->jpeg.num_jpeg_inst = adev->jpeg.num_inst_per_aid * adev->num_aid;
+
 	ret = aqua_vanjaram_xcp_mgr_init(adev);
 	if (ret)
 		return ret;
-- 
2.39.2

