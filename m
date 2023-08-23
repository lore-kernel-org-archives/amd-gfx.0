Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB17EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6420310E439;
	Wed, 23 Aug 2023 15:51:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04ED710E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1h9PD5ufRP5OjMUSfTFxLeYcqJH6bPASsQYTAD4avQEyonXvKOy3ir9fWXfrPTYWXLdyrqvdQWS5NkD0xmSrkcv6LNGq1RCokGC1UKh6wmIHHRD58hMiHH4dAYMN+Q7rkKTpU72Og+MkW79nkRpZ0gSZ8ZEKttW8qGl6J01GsB1ghxv4CL+p7jngES+n6n7XaSodb4623PESsKnPVTh/Bx2S0GApHWA+zV0wXWtPbCX3HcMb0B/ZXoIGbloIyCJMvZmcb2Yxd1eg0NRQChAiMJ2qu4mHyypVdjZAsuQKPOAGiUtX1Zk8IA4Lg5t2TuxfXC1E4VfHjVUj1meQBJbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ4tj/B4l4fNj37E01s5Abk4a16vABfnXEs9x2JkMnU=;
 b=P1MAm0wH3pVkDkZExCqG+t6Koz0IpRUGZu3PfknX773ZbIpxYvCpv50QEyIMsj0vXNBSWnDG17QpTZAVmBzwmJmVw0G26M5zI3yM8fjtQGPlNoxrQBOL6aEDuc85IEpXrV4GGo1ghjFwRAJKEzn1wDXjI41ZwY6/8EGx78RYbbNwH2+YIMBMY5uZkATIRpq0dkSK5TOBG9mC510tmbrgElIXGw8Ki6WaiJOmT+hezUZWYZWVb/EL76sDlozc0PYeXUQO2gQbX05zIp9LpUn2JYxl4NfeUF+EEEWaVszrYc415PAzf9GdWqaCOqt8ptQ3SnbbT7zujVk5hW7663zlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ4tj/B4l4fNj37E01s5Abk4a16vABfnXEs9x2JkMnU=;
 b=IM0otss5a8UZ26jquoLYYanQLQnmQoOQQSQ/GA1M6JBXYrIECLQuyf7lPz5GbUGa/xGxKNdlH8Sfj5u0wjRxlN83M1LBhF+AXxD7/0FLRnRhSRHynoRftZDHobag1Dfnxo2gFcRz3vwAQzfUbvAcjazfhGRRn8O8Ej9Ck0IE6Rk=
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:08 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::e) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/35] drm/amd/display: Add DCN35 family information
Date: Wed, 23 Aug 2023 11:50:16 -0400
Message-ID: <20230823155048.2526343-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: b73a6d5e-a745-4d5f-cea7-08dba3f0c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgWcGFt3PethFnut9H/0nEjRl/CFEPhT7iaHzInIcFEg0PK9k3AEYI14o2YZMyaH58c8/ewsLaMAXudiRff9fhICQdFV8MKvAKHQAnq88axD8D6wStVKbx3+EYine9DmAqGM0CwVj3jiFa0y5Nj/tmdd2OEJNQu4+c60do217mp+PECy69387P+4ayq4m/hwuDUwS1wOAgxOD5eMuzjbt1GYwP1zghDJHHalR2b0XLWYDhY+ShLBxEf8CliyKWPylaC0yClx3jFWTzxwrOzJyY+31/v2f5MgyquBgThjDjhmCHAFthGEyY6yIeCJB99qeI14gQVoI0cKXukpPlC0Twtd5ww1PaQZM0JG+Ss64uQU3MZjT/IkUfNfU2muGOGN+1KovdRIbALvXpZBP6SrcLB8DwP0wDGd5equttMRsD8JYQwif1JAZIZhqmLW3+4MSWGfjVylJKZHOnOSex+QeYYebmD/+CiVcvOoUBIDQiJbFsS3ZydEwDVImmFEkmB9RG/VqfwIfyuQvolZFv14LPZanl7L/r/K/NhRqU+uJUtmV8HgRDwPZVVjaK3qMya4BE03EGY98jZ/9+Nnt/ioB8EiW+kg+QjKwswxRh1lWvdMp1+eNWb5fcG2nIHa3c/MRM6pTe2tVaz2x6voad0qN6z6gRLJMFzgYe6akIQ6jSeckF3vFexR8wLIe5rNjj2zLMhd+V0QnFHFIYYLDO4KaYKC3D5CL1B0QcN2PqeydxzzLIfXPtv2yBj5z/y/9H4aBa3KhkipxXADMEz97lg07g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(478600001)(86362001)(316002)(7696005)(6916009)(54906003)(70586007)(70206006)(6666004)(81166007)(41300700001)(8676002)(4326008)(8936002)(5660300002)(82740400003)(1076003)(356005)(26005)(2616005)(16526019)(336012)(426003)(40480700001)(36860700001)(40460700003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:08.0778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73a6d5e-a745-4d5f-cea7-08dba3f0c42d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DCN35 family information in DC.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c      | 4 ++++
 drivers/gpu/drm/amd/display/include/dal_types.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 3907eeff560c..c8505273421b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -740,6 +740,10 @@ char *dce_version_to_string(const int version)
 		return "DCN 3.2";
 	case DCN_VERSION_3_21:
 		return "DCN 3.2.1";
+	case DCN_VERSION_3_5:
+		return "DCN 3.5";
+	case DCN_VERSION_3_51:
+		return "DCN 3.5.1";
 	default:
 		return "Unknown";
 	}
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index d2427cf1155f..1c6f24cb1d2f 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -62,6 +62,8 @@ enum dce_version {
 	DCN_VERSION_3_16,
 	DCN_VERSION_3_2,
 	DCN_VERSION_3_21,
+	DCN_VERSION_3_5,
+	DCN_VERSION_3_51,
 	DCN_VERSION_MAX
 };
 
-- 
2.41.0

