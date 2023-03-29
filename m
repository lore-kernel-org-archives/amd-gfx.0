Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62658C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 10:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4F510E190;
	Wed, 29 Mar 2023 10:51:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8180610E190
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 10:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avlk+PmnJQRDPpXf1i8g+kGh9qigFrejljr0zL3xOCureCOsCc3YAd62jlqnKo788+izCXcaUhHR2Emk9hjFKVjaNfDTT9C+oATNljhOJa3GqNXG05FVbGWeGr8GKVvBpGrwds2IL8w6imP4JJWzJvMhJPhJs8COAeVZYHiliyVVYOVQBeDcU2eUTY2+zEEE2QPEoCmWBys6IdSJz/1lKLNLIGxYBO7+bid8hWPc0P7qWJT8WJ5TRW1Ursd+o8LPQ0q7G+KEPQW0t5S1Jln7vkf068s1rwcZNVTRGn67BO8EO/Kci7IjkNbGhu9OvnQGt07V2mLBBKGDUHI9z6ehNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3ajubBeu/hozQKJ8UU4F1y+10GDBIyJnV4v3h9WUes=;
 b=BT6lbo9FKM6KNh5VYb1Q2DjAlbkHQlDkd7xAEbHDkQj8oYy1asSfhYFFxXayrF2wWIbd3kBAjJUw9a1M4rZFCwuNplLopgPNd093EC4dPqFHnxBG1o1D6Bk6idozoGh6y9ikPqbrUoQ7AR90+5PZjcpf39ZfzA4uRiZim3R+QUAN1mb4stdTvWLQXUBY+4ctQKLjK+756qIcNo91CqZpqvH5ySarXb72tyY5ZiYU+JarGVXlnN35ly2iR5EQfdWjyeJDAdxIze47+48oxeoDzr8Z45YXLa3bYzoZcUFK+tNsPBhuA1+xM0+2yk4LxKU17crp3vZOygKCH0XufaihgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3ajubBeu/hozQKJ8UU4F1y+10GDBIyJnV4v3h9WUes=;
 b=NGYqR5aL5DxtQ23uQfoeTdg8r3uo+KL9ZN/wo1ZlLTfUtartL9alE2LP3iHRgvdlrX/mxQ14EKyhxw9yXVumCM8efvfUFtwcXrOPTYK6HHXCcqy05lpkeR4VQTqewdOJDcZKBCenZMUYJDqebS3BSpRAFMIMSf6g4rNe1N0BO0Y=
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 10:51:35 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::a1) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 10:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 10:51:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:51:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:51:34 -0500
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 05:51:31 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for NV2X
Date: Wed, 29 Mar 2023 18:51:15 +0800
Message-ID: <20230329105116.214594-2-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329105116.214594-1-Tong.Liu01@amd.com>
References: <20230329105116.214594-1-Tong.Liu01@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d2665e-1b28-45d7-af84-08db30439092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49Q36yPLFHGicuGYF/Kjgc7nnMxZFf0DixsU/38Ynux/6NuvSJRVNvrEKNj2qXcf3ejy+6tTX+lu3ZPngt5LDUFnnq+4szHo63gGgTTvmCh8Iidc9p/TdR0Y4fuw5WbXMEyolyDYu2z06FxWhhF827Cs1f0i8BEkB347YghxQ7YMW+P8+SkxGXYmbhQ/r2vKjXUS/09QZSo9redJEcihgxpfzZWXrZ5cbHNTua6V9Fh92EiwNPgjSW9K49dm4ZE9DG1/AeivIWKtOECxIdqctu5PP2whk+2TFGKKrTlLNlqzYXxh6ZbhuCXec9sEJ7nQJhi5mE22qMOHV047cr2ZFk5+dZ8eozQek839f+cqfrZz1a7zy8EfCWpvIgwtZUX5lk5EMhfkqnoczginzlrmFFpci3JzYDomYMlfaUqk9DcwA0hjhaz9Pbe+nsMBSQ1hJMyIGm5ssO2reuSZuzSrFtNlh7TSmpPCn5ohytFCLL0lZ7PBwSdV0YOhprFC6gRkjLuPhd3azAbnuxx71K9bCWBAh8ff/jig7tCxGpCuIPNSDyMFgmikVL8BxlW8Mtqtj9eqr1THVydMC20ZuE0U5mxcseD0lgBFgiXyQCZDteiVTEUlbpRuYbwVO4i+fUglcmswqPDMIxfcWpk1ELvO6iWvWfdNaey78cXbxOvBqTbCSjwfCXb0KoCD3kj8/P0TMqRGNALcFzeotQS0DvU5xWVKFWPsu70zfZwTBIUp5VY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(6916009)(4326008)(7696005)(36860700001)(70586007)(40480700001)(70206006)(316002)(54906003)(40460700003)(478600001)(8676002)(2906002)(47076005)(186003)(5660300002)(1076003)(26005)(83380400001)(2616005)(426003)(336012)(36756003)(82310400005)(81166007)(86362001)(6666004)(41300700001)(356005)(82740400003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 10:51:34.9219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d2665e-1b28-45d7-af84-08db30439092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable vclk1 and dclk1 node for gc10.3.0 and gc10.3.1

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9991447b5f14..ea8e5e3829dd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2123,6 +2123,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+		       gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
@@ -2131,6 +2135,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
+		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
+		       gc_ver == IP_VERSION(10, 3, 0)) && adev->vcn.num_vcn_inst >= 2))
+			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
-- 
2.34.1

