Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29AAC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4919910EFBF;
	Thu, 30 Mar 2023 19:18:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D075D10EFB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHfj6e6bMzLFfwwMVS4TMMaNdPiAMswu3r2pNMmOnlQdvCTaT86RyngJ98fhnIQ6kVUKDfnXiq/RFgEFwsAyKb1H7xZTRfvun+qfpWCFXzaqmXMi5ds17r94IMgSC4+L8e8IaOIipvdfiBiXoLJHQkBUcjfsO1BC2OR+C+pLLHMEyvafUnP8NDmWqtLxgn/OB13Dg9cpYJONK9i8w5PVhFRr2XXwwg9FU3IR7ZEQf2CVYrOqBaUaFDJEsoG262UBF1muR8ZNbEzf7bJoYVNkzvSkd/vizaQy8K5NnZHJI8FnXoaSpCkKVrPMMQe90wM4kkyasOX+WSQthO1GhWVdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wloE7JewiIiTz9tXeQXKG2ton9HLKYlUO/inRfbEzfc=;
 b=gaB0eBiDWf2gR/+a/Zqqo77zj98DFlT39+y0LRnf0XtWPa9u5jNIKpQ4T7oxG8ra+oXdYbv/1vdYJcRrJMQ+SoMIsZk66qkIcPa02qfiHSda/6y/MwJ4pmv97sAXk7sIZ7PiQ+zL2UAvdmZyehuFKtLbYaFo1AMLZKM5R3N/M1GI3De/Fr0jQ5w0fkzTWZz7UmofJzVgdFX3GeXZaXD+69X5QCxwfufWIgG3lPcrCs2DnvHX2R+j52Vw1fVvTcChrBEinK0rSJI1Hr+ZZIQN0f8hw6yLAaqMSHS0d3rGDw6bTRKzcDk7PK7ZFC56Z47vgqswZ4m548uS8eDApnPr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wloE7JewiIiTz9tXeQXKG2ton9HLKYlUO/inRfbEzfc=;
 b=PGIWEgf1EXr/tjJi+iDW3ztz3fk5k2kTtEzruQIFb2IPsmgIA6jZ8M0aJ1bZSlqtFIZlQfmHkv6PkFIZOUMKOkXsp8cyFm3fOUNZT+3JgUIMlLwYzGBwIeA1Uu3HIFIbgrIwT16dcW7pgH4SYW7gCZFSWBXmmH7WSYrLli6l8Eg=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 19:18:08 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::68) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size query
Date: Thu, 30 Mar 2023 15:17:47 -0400
Message-ID: <20230330191750.1134210-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: dde2fa3a-5b8d-40e5-6689-08db31537eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap9QQQqDj7XU1s5M06++7shKrVEkP7c/7lk1bEY9yS1Y9KTR9+SStp1sLmRHJdN88laccrkSHIQYgnRFSx8DZ3ool97FWfW65uyu3bXdJ1L0Io2/ldttvOWISluVHsCKevT8MfUFYrpt21U+fQ6Yoiq1inWOeDFYAhJo6p8JXS3BqBrdKhhJrXPru5X+IP7WtofLsBUHdheFYFJhmmYznFqqEQYSvqzl9n1SRTwHT8b4pNxsXXk3HHJn5ah6102L13TE8mGx4SUnELfhPyosxLIWyoWsaEU+O7z61QTc31Y6D49RQ5V7gfGGNJ+uQ5jZvxIAcpqBKtxGjwTcTwuShcgRh6ADCCCsjYvKwSW5Yz4bGrGYk3Fq6U+T30GtdoNfrJ3iQoPbGn587Hh2VX2LrZu1gxwTeRBLFzK5h/d9R8g9oJULZ24YbEcxvRJWuKX8uHhB19HwzX6epzvOZh6X8KFe7WPxtrj6RGNPvL3ykWCOfYB4sJvdDgsdZ7IwyyFQAj9mhEa/b8P3S0R07On7nviR5fEDyogsroNUFq/0VzEUWmWkIpeRT2S9zv3y18/2rJskAYD8c63D+6K4DX8Xz8zz0uXztpj5qzAhHvOfd/qxLKc8C1EGjLltgNCBBH9dq4VEveBEgaVajcmecB1FiyNlgFtqoC7qELZXyg8wBhheAMCBfKY0vc55DO7esKrGIXXvyOMR0wbCb+h4s/w9ZUlxStonxklOwhISykNgdRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(81166007)(356005)(26005)(6666004)(1076003)(7696005)(316002)(6916009)(86362001)(478600001)(82740400003)(8676002)(70206006)(4326008)(36860700001)(70586007)(82310400005)(41300700001)(36756003)(5660300002)(47076005)(2616005)(336012)(426003)(40460700003)(2906002)(8936002)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:08.4253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2fa3a-5b8d-40e5-6689-08db31537eef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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

Use the new callback to fetch the data.  Return an error if
not supported.  UMDs should use this query to check whether
shadow buffers are supported and if so what size they
should be.

v2: return an error rather than a zerod structure.
v3: drop GDS, move into dev_info structure.  Data will be
    0 if not supported.
v4: drop local variable r

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..fd735df92b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -876,6 +876,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
 		dev_info->mall_size = adev->gmc.mall_size;
 
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			struct amdgpu_gfx_shadow_info shadow_info;
+
+			ret = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
+			if (!ret) {
+				dev_info->shadow_size = shadow_info.shadow_size;
+				dev_info->shadow_alignment = shadow_info.shadow_alignment;
+				dev_info->csa_size = shadow_info.csa_size;
+				dev_info->csa_alignment = shadow_info.csa_alignment;
+			}
+		}
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
-- 
2.39.2

