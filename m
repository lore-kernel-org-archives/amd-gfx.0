Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88EC7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E55210E327;
	Fri, 27 Jun 2025 14:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RksBDmC/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A055B10EA1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAEWFf0TpnuMWoR/sa/6q8DRzSs4sBahS2KROA7/zh55M76TA8EmTKFR7zjnspgoybsOQdQfSxozJt7UYNvnjFQB98Xmo+r70sVf6xz2oV3LMtVk1ocl71IbaSz3eVmiO6k0KlYctMLTcgwUyhNN1hInIIYxEw1iUUquUXrNYNytcrGMcxnWM6OLJe0gndC07lpeOB1t8WhOvCTrRH7WcSnrvPZacu5ACY77l3zmkOiQyO2sh8Z1yWBCPIXo3JQxPYvnisP0RGLbzozdlDFvpbXZ1qh678WLFCI5wu+bZdCA4pz+UoAxu92su5nuyVIIjyPWGuEKp9LEik3juW0/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWIYZVzY4refgSRQYi4GFfQsg3h7r4pQxgTVJ1yt0Fs=;
 b=kUuAsuGfOxV7lmtdL4I9d/RXI2p84oprNuHPR+DEF5+K2dt85JCIajz0J2pPDzzrqhf+2kqiUUgQ3WA5BZcc9tziyh6uOKe9aZYt9hWn9nmK/+cAdhGUJDJtqeBuMQ5LCsY7F/gz03MYtubxubEWNV324y/iBFrJAnzCE9uIZdyNFEOi8oEXyCzzchwBLkXUPduLMCXVaZYfYQn7vXGLkP7f3uunpzGKd51AA+QK6N/oVivYnwtetR5bB/5YwGcpSIZVLw6zedEOqqvkhdhwvYnR5qnglZUFf7G0zLjKLfZVYF6UsQJg+ge51OtYiRPkllcI+RVxZW/7tDahiOWHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWIYZVzY4refgSRQYi4GFfQsg3h7r4pQxgTVJ1yt0Fs=;
 b=RksBDmC/N62PgTz+AY11ADlVw2DdidIh9MQ9Dgz77SniATbswU/O5hCw0Pr1zH+ghR4i90GQsKxVT2KBOxZW1zd0TnaVSGvwxRzFSgkSgvTOKFC77o//rUlXAQEDr9h2l0ypvZniATwCXrJboT19wnBG2WGTSE9xewPgYiZauBs=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 14:34:09 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::ce) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.11 via Frontend Transport; Fri,
 27 Jun 2025 14:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 14:34:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Jun
 2025 09:34:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: add support for cyan skillfish without IP
 discovery
Date: Fri, 27 Jun 2025 10:33:40 -0400
Message-ID: <20250627143342.23856-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627143342.23856-1-alexander.deucher@amd.com>
References: <20250627143342.23856-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: af4e8634-f1d9-4bfb-7c94-08ddb587ad4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qgcX/WaHheH20AeYSPKy4VvrNIHUX7+XJI0S6sy4rAHahdxYBNK6g62fkril?=
 =?us-ascii?Q?fUYosT9FMFQR5s1iaS6YQ5JbiZSP7SkNHDH7RF/PqQaePPTQzSBh8veq2lzV?=
 =?us-ascii?Q?52xbMZLHmj6QzcbWTgKraxveJZjjZWxAwOhQ4hsP6Gm6Wu7nrpX4NpRScZrE?=
 =?us-ascii?Q?ob0w0WuCBSdSOLffAWcI4pVkVu/VqQUY+gta4ZLXB2wV3KqZlyqC5Xwkec1u?=
 =?us-ascii?Q?skQyqcuc/z+uaT4+BQc7C1bGbpu+OI54zcgzuix1lddOfTKvlKjwfnhEJzDh?=
 =?us-ascii?Q?hPMpi5judIOFg/hJMfom01CXiaY4ME7ew/e6XieqJGZDsJIXLngISMhL+sDl?=
 =?us-ascii?Q?GGkIx6w6cPrxC3ii7qXZ0wv7AisOO3V4E83tkjU7noN1YjBbGuhB0mpZ/qrA?=
 =?us-ascii?Q?V5BxuEAdzuULAegcpWAqsHMUo6X12+B0dh2k7toZjgYNbBDV1J81kuRPBo6z?=
 =?us-ascii?Q?7yxXz23+IGbdD88M3jmwDjuuOlv9WvJjNCY5nd5YfXg7DGZWZjwcj0t9iPOP?=
 =?us-ascii?Q?vSWl7M+A8bBmCJZ6F5KERUzTFt3E+Xg4rme3Kp5luPNXGWxWknPBouonwqyA?=
 =?us-ascii?Q?hL9nsvr6HDsEEIBlUqYcf0y2rWUjrqfdBlAnJg0oeBMLkdTZ6q/EnlMgwYcZ?=
 =?us-ascii?Q?V3cXQpgtPfbnarltIpxpMc/wiko78oI6xx2gpU/tLAjNBSX76EAVdzu7qeMt?=
 =?us-ascii?Q?+oaHKnvQIL8Xchv++nrQulOjQHkJymobmknPVY50agLRRZgh80rmgdHvtvct?=
 =?us-ascii?Q?JkNifvbvEIIKqp+lxmvLH+1W0v5g1b5jOXuECKGKaOSqEhS2wwlHUIvyh/P6?=
 =?us-ascii?Q?PScPpzjRtjHyvRvC0PKcg4UJ2rBdXcmZW90HJQQXcd78hxOlBBcNBO+n4NuZ?=
 =?us-ascii?Q?lnXJrzKAn61EcYJdMkLzARjptuw/+0UGgj0udbbhnW+PuGGlM+9Y883/LYun?=
 =?us-ascii?Q?zRzmJPs9KqSB0EEKkV2SdGRYq1Qvl8aaHQr4rQz3KCHLkcqRENYVrVNTMuz5?=
 =?us-ascii?Q?WAjfjSaydjrRQ7IEeH3yrqXcYZ+R+8GVZA426mfsCnVSDQY7cZjdomnfY5Gq?=
 =?us-ascii?Q?p9xKmL5XVzZ2myP4C7TUVLMMSDDdyc0VcFaXY82W1vkqx6L0YQYpRc1sBnFI?=
 =?us-ascii?Q?fCAbwdsT6h+8MLtZuL5NBZAtkGnWpSymw9PFDFa1LbefrwRgkhCjK591iUo7?=
 =?us-ascii?Q?5HCw611buM3kD+U4O/y79XKHTf7vYE2se/91VKTXcX/b0xeJE56K+QTpPF/t?=
 =?us-ascii?Q?c41gIBahWV98RMhoO2U+4mrcr89kM/PiDIK0r7jUTMG8BBHHVvPXvomwPXEF?=
 =?us-ascii?Q?WBkhLT0uMWrLUwd/pDJLb9VCioh2Pt9iqMj3mmIKcCfVvwOzVyfq8LmptpOL?=
 =?us-ascii?Q?De1J01kkzzbfRokOYVHbyEXUvclxINdZR1dJW2UNkbssssHSwZzEnJZ9LIZR?=
 =?us-ascii?Q?XwFQEgov71H2R9+q6ob21ULAgxOOdGd4bFUpj8lut2Kh5dxOE/WC0+BDNDek?=
 =?us-ascii?Q?9g568d+48Y0Q62UEcPVpLlEMUeFVOjVVbr6+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:34:08.7822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4e8634-f1d9-4bfb-7c94-08ddb587ad4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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

For platforms without an IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 81b3443c8d7f4..ae89dc9687435 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2573,6 +2573,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_discovery_get_vcn_info(adev);
 		}
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+			r = amdgpu_discovery_reg_base_init(adev);
+			if (r)
+				return -EINVAL;
+
+			amdgpu_discovery_harvest_ip(adev);
+			amdgpu_discovery_get_gfx_info(adev);
+			amdgpu_discovery_get_mall_info(adev);
+			amdgpu_discovery_get_vcn_info(adev);
+		} else {
+			cyan_skillfish_reg_base_init(adev);
+			adev->sdma.num_instances = 2;
+			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(2, 0, 3);
+			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[SDMA1_HWIP][1] = IP_VERSION(5, 0, 1);
+			adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 5, 0);
+			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(2, 1, 1);
+			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(8, 1, 1);
+			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 1);
+			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 8);
+			adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 1, 3);
+			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 0, 3);
+		}
+		break;
 	default:
 		r = amdgpu_discovery_reg_base_init(adev);
 		if (r) {
-- 
2.50.0

