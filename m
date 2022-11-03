Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBC5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD79C10E237;
	Thu,  3 Nov 2022 06:24:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BC510E237
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2dKc8Vx+7fZwnPNNz3Tu8lEMk9zDfQD5Q9OXIVDk1OTZhZ/Cwhzacy2WdKqfmbtu5Ytx0ATSZWHAePXECq7XJ2BU2sE6KMqI4pUEaEx0ErIF+7DKN/rDm5nUSLPKpjoAPFzpoX/fKRA1M+mP5i9mtbFLPzu3ke77xJRjWeETDP7/+FPMxQAcZMx9RiUDgJTkCPzMFxyi0U1Z1UB6bQmuwE6UzNf1D3IbDNn4O4cn776nNDypGcEaLXFF02T2xr9iXFAdxZljJwRnRJkiSelOhVrQZbr94FlS736rreFcGEH0fjiqFhf77w/ztNazZiVj+TSLUWX8tdXhePCbu2L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wd6fFxOfAkgYU3Q2JdfSFR2j3B/UwwM7qmFT0m/wAA=;
 b=OEfUItExGEaruW4il6NF96DekEut6MpE350fvG8iXJE+fnCjoJ7b6LaNgNOqiEVGUBNlbrlDBwmltvE7aL+T6nZrELkKmvwblqZNTvYlxPWMuG3BrrErRUwnkSAK8SxrwPryD1eODNz2Azv9PyBKTckwgEuEc19bCiQKzJR/WeMITE9T3nFSXL5OGYWdOe3KckNcyqUTJXl5nEIaxMiFJXH8syM8GQ3mY350wKyI5G+JOAvAbJ2VilK2t6o7w8rBCu077T47vL9SaR9ealYO1fVbDpdIUJ5N1Sq3E04Q5htpKAebU/oapXUYai4TEK4F/Kxv+E699VhzXlmZkj8Qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wd6fFxOfAkgYU3Q2JdfSFR2j3B/UwwM7qmFT0m/wAA=;
 b=sFaYaWxlggLhMVGImeh7P1FFDJgot1qPPgUdvACBTYAkgeTUL1F097c6iSSkfnnBOFNvN0WxFh8PffR9o04gjPTF6FgWnGvKbDszd8zAeldhm1Rv/h5XQVF8wJLHL1jFxSlhEh/1JatuAQOnZ2RnJqt8TOCkfn4v77A3clbJKl0=
Received: from BN8PR15CA0050.namprd15.prod.outlook.com (2603:10b6:408:80::27)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 06:24:13 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::2e) by BN8PR15CA0050.outlook.office365.com
 (2603:10b6:408:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 06:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 06:24:13 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 01:24:11 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: add Vangogh APU flag to IP discovery path
Date: Thu, 3 Nov 2022 14:20:54 +0800
Message-ID: <20221103062056.2162715-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|BL1PR12MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e416b9-87bd-4f4f-fe50-08dabd6406a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guGmjlGd1Gjm59tS+PWLIa6c/zNu6gN2HLREK5XC/i4Z+oj536G+eAA8hHkBSNpD++KZpaAe7sLr/54nXKbnBZ6oPV71tmzzNVNroQlKjf/iiw+tJpKbgqhrgEsfQJw9Wjnv2FfOa4Fjul2T+OcWua4y6inOBNbOL5CVaM+YjZFA+OnY4EylOELmXt9+11dVPgliRUf39bpKzzAoSWXxZdK7WN7agFzowjBy9WFsp605LzCbrOPbvyuz6gGX5FjP/1C/zv/J0PjIJ3URTTE64iBj7CkI5duB1VOuuKV9ZaFdi/W/6gPIDBfKZXgHvMLHxOG+7CaxMpNiiJ7JwyGrSJexBoMTA3NYuGD7iC9r1MjS8xMk8/4v0w1JZMT5wuJSCaAlRPC71uWvy3eWx9fYhjFSqaKlC0trUUvkStd1YvdQ0lsrIRFWIFVDc/lu8T1n3j6wKKrOuQcw+xy7tmAXK0EjlAzQqgIGsXkn17A0yBZFMhOE7KY/Za1SW/x4IqB6O3+GWxG1bw3r/sbXrYRDBJ0BySe33+eJSZFCx3eH9cmdpV9T55oPSegi/rjPXOP+5dYW/c64PMne94tdFf/YgGNheBVzI4FUIA5TvYM2yvO3Z+J1mg51SRaFQR/oGjOxV4e10ovQa0hKB9rlT82bHQI+aXBpWTGTjDNRkf65B1IVIadqgUBJ7z25UllOQ2HRY575DJ0wmDrcIE62tWcfIMlqlp+SPyEVBbAhL4J74z5Wk6cY/w7bN6HqMZzLI/EihvzfDzCCybNs/8eyFJWV+AZ5z6xWykVOuJFCuqfPSGX/2meTGaRixTiN2H8Nnzmo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(16526019)(82740400003)(8936002)(186003)(7696005)(1076003)(2906002)(336012)(86362001)(316002)(8676002)(40460700003)(4326008)(6666004)(40480700001)(70586007)(4744005)(356005)(36756003)(37006003)(54906003)(82310400005)(6636002)(6862004)(81166007)(41300700001)(2616005)(5660300002)(70206006)(26005)(478600001)(83380400001)(426003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:24:13.1602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e416b9-87bd-4f4f-fe50-08dabd6406a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the missing apu flag for Vangogh when using IP discovery code path
to initialize IPs

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 95d34590cad1..c1b1f223f3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2153,6 +2153,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(10, 3, 1):
 		adev->family = AMDGPU_FAMILY_VGH;
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		break;
 	case IP_VERSION(10, 3, 3):
 		adev->family = AMDGPU_FAMILY_YC;
-- 
2.34.1

