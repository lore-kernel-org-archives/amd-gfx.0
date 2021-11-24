Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8606C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 14:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457BB6E2B4;
	Wed, 24 Nov 2021 14:20:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDAEB6E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 14:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qpypfit9JNboYN43btUTR2eLDFJ6tV2eOXX0eifTiA0AbP8B0hlaT9kU9LAaPD7cEJYzaNd2VUPUt4gB9K4GF1xnM/cX6ECGdpI6xrV9ZBPoJvz1CJmbawVW7q4QnPQGQQRtUM/30HXAX+jNjdj9uUnnSisRkbWZK54bRfeQYBgQ2RVFDDbkuSALPPBzoRm9vUK1gLo5nrgNq1mo34KtbjRojsGmdHPfhukRq6WJVKlbs0bCXozOupBxHA5Auk3YSVQbDJ+9RtdTVrCIBVVhGcQMuVrozQNFeK/azyFJZhsW+yY5GehsRjdQrcSnanzRuW5vk6yKAQNCs+zj9hr6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svKQ1JK6YZI7K3UvOZKoHzdHooTnJ8ZWZBYcJQVi8F0=;
 b=m1sC6sH3aZXrvCJ+dVxhmKW5jhYsYvYfSJ7VX2omhExYBcx9WFiPZiVwEBpeLJ8faTF/mABiRNlYJo0/fXByrUDddtulwtRjr36V8VwGVTaHrmfmShA8QUSQXsvoCFQ/ssCWu/4Rzh5WiiaQz6q7gQVDlwphGSEJyLVpED6cVsYyxJq+pZ4GooyTj+VGOIAAnY+2FzmgkCbgUBfc60YZqiAHsm/9b1YgzSy3Fs3taIqAdj1sMjk3s8X8FYS85BrXZ6tYcjF5IuhYs5DDJRzubEp8cr63ibxmh0spmKMrbg5WcTW7FVf2FiQkQP0SsiiporLQxklnKOoXQYI/+LDJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svKQ1JK6YZI7K3UvOZKoHzdHooTnJ8ZWZBYcJQVi8F0=;
 b=YLbGtz+iRiveg/jukaXOBPFHXbn6mR8E3KqPApzEGmyGOyIGKuwl61/q9KTanqvqDxTUYZZyQ1tIi1EXDccQtRPIAYVepaebbH5rPIYL8cJJP3y0C9VcEaL0B6cjHfVgWFy9GBpyDmYT8brD4mkn+YWZorcnwvayZ6YPztXcHAw=
Received: from BN6PR14CA0015.namprd14.prod.outlook.com (2603:10b6:404:79::25)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 14:20:53 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::a8) by BN6PR14CA0015.outlook.office365.com
 (2603:10b6:404:79::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Wed, 24 Nov 2021 14:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 14:20:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 08:20:50 -0600
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 08:20:48 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <Alexander.Deucher@amd.com>, <guchun.chen@amd.com>, <jingwen.chen2@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip init
 for SIENNA_CICHLID
Date: Wed, 24 Nov 2021 22:20:36 +0800
Message-ID: <20211124142036.22491-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a2103bd-ee77-41a5-e9b1-08d9af559f51
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3414E77BEE3C5BB951FF0F28FF619@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ws+aDlWP/jvRqXRpC3tAmacoTiUYr6W/Tg1p9rgur7D3HdweCq8uAKTKQGFUHO438JqF7yUGfYdG2vAIcUjVpmCmRJ61h3HENXcHLzAtEZoIoe6+Z3qBCXzBhzXBVRG5ugWDSdAan/kCjF/SjGudbzjD0j4SwSoaNNuAPpgcXcO1GOlGnR6UHOj8UaS+IQp02fsgoJ9ng8FsxrNjGX7tChJcgWCR0V8n2PdrqwZgb9JuU1UM2fCd5yx8phc+BvFKbhCg+4LOn7jd/82D8o+BNUHxfAIeJPe8g5szDAACfmBWy5TgA9eWtWoT+EktzbAH8xKY9PCDzBnxft+Wpw3spz/CfK67zY58BkjyKmhl8sf9ZZY3gWxQlWTIbOCLz3uwOTaoIH9Vxqdlt3UfbePm5DRkushnU8Fd/qs8t8Lsd1Pn2AOGW84uy7u6ZdbM/nGHsRjGoAdZvVTG1a8trHLD8B9bY4QxtcKva6ZBXySNLQr62EQkCjzGbdAcDH6xYff4b0U3acTv7wNZ7fcRSGjuiR//jRKqmvXRs5NZp6pVyJdXOEP74yLHuZ3aSWBX+YHDbkBkX9ZJdXHqp7tuI+ogWxfpnNwQ2+NGB94ZcCsCt3t3FFbYeL3xLUBJ2NfU20lZB5ro7IPyKmbWdK1ACyVN1thw1ZTIo8XVjOfmpm3hQq8fRM680y/3zDdALubsnuxwb8DjveInKER1Gm/DBU/yy3Y/N60kH89qVXLUqekUMnY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(336012)(26005)(316002)(186003)(82310400004)(1076003)(426003)(36860700001)(81166007)(8676002)(356005)(6666004)(8936002)(83380400001)(70206006)(47076005)(54906003)(7696005)(70586007)(508600001)(5660300002)(2906002)(4326008)(36756003)(6636002)(110136005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 14:20:52.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2103bd-ee77-41a5-e9b1-08d9af559f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
Cc: Jane.Jian@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
add new version check for vcn0 disabled revision(3, 0, 192), typically modified under
sriov mode

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 503995c7ff6c..3f9b7b0bab3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -923,6 +923,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
 		case IP_VERSION(3, 0, 33):
+		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4f7c70845785..585961c2f5f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
+	case IP_VERSION(3, 0, 192):
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
 			fw_name = FIRMWARE_SIENNA_CICHLID;
 		else
-- 
2.17.1

