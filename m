Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B29C5478A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 17:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC6B10E054;
	Wed, 21 Feb 2024 17:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xXlr0LCF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5FB10E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 17:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWGJ+kyN989i4Zq8hnCYH8nSRbV8LULik20Q7DnMaH7qRzDYp5Z2iu3uLoX1LNsPsKO5oTyQp3p/OVav2Cik0UTJneCMzNWd1WMW+HOwW/rzq09Jw0V505bp8942ATz08D9gmUmTCByNvxytMELfv37ah70lcWWfIz+s0o08v49SoUGVpAH2ukCTECSl328owtOrJiB0RznXGtCpVigr07Hqu3Apmbx5GW6NT6L7OlMdYu2Xwv/6JId/T8ZoLVJI3AViNG93w1/CK3XZIVAkRXUazLa+1P24h+7+X23CbKoLIuq/jHr5TE+Rcp1K3XMf9pnTVLEtNfKCctzyBiOmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY8+a866oL/EsdgHc/LScYFz09zVQUF69CJVDPvCLKM=;
 b=Rqmg1yEDyNaqPhWX9zuMc/S8DaoIkNo+SX/nivL6MilWlIRDO1QTYFYT6RyBfB9tSqWKv+H4qHQ7rq/dIWfEFhfWFi/umP62dBgGFRPZsAb0O8eZypuWYJepm9AgsrJeaqtU3HTKOc34r3uOtDTDLdTfSXU0K9kTc/pCs9q9YMEViUD0wAfjKu/c/TRCYrIEHesw2jmwVNRU2xiLgD8KEBv7q9gBmQVd0+EM+vvMAR+v4X8EYW4FeCy40byfWc+lUtSzW2AWBfq2i04Ogq05wQ0WgeUru855hCpgkODlPPL+MBCHNjniECylyzL3FqA3U5Rd7CiD0/t4jB/Ah28wRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY8+a866oL/EsdgHc/LScYFz09zVQUF69CJVDPvCLKM=;
 b=xXlr0LCF0EmIdMsISOSoxcoAcWX9INQy9I6x9YDxBb8r/uSHb8mcUoTW1Lf9PK/+7yZKQS7z50d96iI04eYzFEnBuIuXmRHyPhfvA1TesdaRMVrlPO+p6wEWERPaG3P31/K5D2T6lCk9xWgLb2x2ijsTOlJow9gkosKEeYx35D8=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 17:00:29 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::f2) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 17:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 17:00:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 11:00:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/vcn: Enable VCN 4.0.6 Support
Date: Wed, 21 Feb 2024 12:00:12 -0500
Message-ID: <20240221170015.8866-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bcdeb8-5f36-4719-0c9f-08dc32fe9b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVoncmo7a7B+8Be0gv2f2eD9GCEjqvPMb3EqVYxqc+lKBPBhKj861bsMuJbGODxLRjOZhaVdkixpWGS2hW7V8HvBBm4m7d4OvcwxDQuqm5H3SA1oHKbuesPkunS7JTd2+eODsMDrZscMXCoeKjxBo7pHUAl3dOZ8clS7VHHFjYZuc2e3cNfld9onGrbeus5VZ4H3QX1u89THjA5NFyQYSvMt+UP46Yvy18IQAoRohssF81xzeSMEZ+Jb0Mv4mhoEM11VbXQnmCmI4ValDPccVBmLvNh82fpJ0/8ItnvOGQvp24EP1GaroVyunMrFh/yVg2G5G3tiZ4gsBIhpx0o3peNwNY7JA7kw139TLYD1drA1ACNTanRiT/TnkbifT8X8GCLsppOY/Zr8I5Xijr7C1RPFvX4orrf5bfuFJN17m6duKnT7GLZU0Rbm4fnBRS14prXm9WPWEpc7khvcwbshN3lkirARRezEjes8q/+RTiBC/voZUvZ+m8EsLVKcvNlylTZ65wYB5z0KSFQ/PywEAW5Ib/Dx+5Rb1RdU7FvB1iv520OB74VuZaFmHreSGp9j3879FO8gTRWmIXeCjw3TdXs9lt2IMAhxyxDJdKKf/tMOzhlQH59e+EySkJwnffIIV7mrR+HOeqFBSKd8WBeNVrADOC31FGtn/guPhvlcgj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:00:29.1518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bcdeb8-5f36-4719-0c9f-08dc32fe9b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Modified driver to use the appropriate FW files and instance.

v2: squash in fixes (Alex)

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index eb2a88991206..b2535023764f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -59,6 +59,7 @@
 #define FIRMWARE_VCN4_0_3		"amdgpu/vcn_4_0_3.bin"
 #define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
 #define FIRMWARE_VCN4_0_5		"amdgpu/vcn_4_0_5.bin"
+#define FIRMWARE_VCN4_0_6		"amdgpu/vcn_4_0_6.bin"
 #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -83,6 +84,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 49e4c3c09aca..0468955338b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1684,6 +1684,9 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 	case SOC15_IH_CLIENTID_VCN:
 		ip_instance = 0;
 		break;
+	case SOC15_IH_CLIENTID_VCN1:
+		ip_instance = 1;
+		break;
 	default:
 		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
 		return 0;
-- 
2.43.2

