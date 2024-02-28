Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B45BC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8116E10E06A;
	Wed, 28 Feb 2024 21:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SquKa9M2";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA5A10E06A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9/KqmAZ2gl9kCTEcsdN4bRL+9/Pm1Fm1Xj++HQI6KBVFZE2auQzVXde1+7SG80cdkb9rstNr8FyZUou/sxRbtol5Yid0WqRJYBM+6MOeHq/vVv5xMfdHarr/P2DsRsxkIkdmivEYlDVq9JUu61MDaGs3VWeDElo64Zpe1KT6FXa6kUR8IoXF2vSmEbhhYXF1/h5dpHRJ9cAEfCVaC+4ofoWdAtpH792xBH9W2s2LGfl4RPLb4uXqxKUduQ3X9Y4kyylKjm0NbROdz8Lq4TR5JKOYDv9bKqs0kn87Sy/XBZp+GhhP/boCPblnDaxjpkiuCfoUbI/XHTHmXCOpx6v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmj0PmP2IuC+0PxV9w92RRvQIFE5VwPYJMxxvc4MfCA=;
 b=YAlHB12bZmV6+VoLTu9/XRFHyoN1EyLNEDzbtV6Gnm0jHYjKs+ZczvIER7uNRXI7F/TrQZ16TywQqDmca47DfCoatrD09HC5J/+oRgjWNmK3F8/9VI/58tfeZSqXhF5Ou8tVxQBF6MQB2EdkRsLIs1Bs4RIcgUcTDcEbI1uICOCjQXO6rTJAcicBZzjPOoYaOCjQ0gZCBTG/2yNX7QdkG2Gm6b6YSAEyMnArQVJEOiV27nYDFROPZmkIzJ80YWrdDoqgOx62ubNoQZXhBHQdBwa8eXuF2YTW9I03Yjt/nemF8o1BBwCX0CxTCa8zeAymZLyzVhtmXo4474ENRq3YYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmj0PmP2IuC+0PxV9w92RRvQIFE5VwPYJMxxvc4MfCA=;
 b=SquKa9M2S7mzQZ9iT8mL+q2pxiCX7aGljst4KpsdrLobcWqtAANQkZS5zsWzhHxp76TgLWUUR6Dhsq7D1vU8T2/TalwCXEm5hlN05KJpzGsHI/AUGlXzNwwQj5I3+xSa+1yq4N03Q/cWi6K8sD84wevP0xHP0ofUgHsAhGl+3Z4=
Received: from SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::29)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 21:05:14 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::73) by SA1P222CA0082.outlook.office365.com
 (2603:10b6:806:35e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 21:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:05:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:05:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: handle range offsets in VRR ranges
Date: Wed, 28 Feb 2024 16:04:57 -0500
Message-ID: <20240228210457.3495700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 954020d6-d568-4ea6-8054-08dc38a0f501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lj7hHfAqz2EeUqoeWX3XODi9j2zZ+dYN9zJQUTFRgxfT41SWBdUA7TXP7JMRCoVpdwmHpShfx+3rQ2FUVEm1bW6/utKGakPWOdTW5nlLuEsKE1UwKJFvuZkoR+XmRmYEWwqvmT/xut4PW+/U/nqzbp/FygJj6UPP34hlpSj3wDNhs2XaiWboehimd8yKijXiCtAuMGTsrYybRiz4dfGaKRQT5vjJdaMMeqbT+p7ggJ+JM67vcof6is+pvRzspcbS6VuaXXBSgQ0W3T///rJ9srWizfbCL2tgxLsETQUfK6eJQtMvv4JvJiqmsXZfjj2kl4ARn+pgeWsqLllRIiiyzOQvHQhO0PvExsdQ/aTJyPcmevMy6IyRQSsDKE06MJ6j0+TSrQzWjjBCUi5rA28pVHFB2zJDoaMfG3Sn6dZvH8lFMff6yWAKZuqJB0M9pBxX6Y4sBqXBRhnw5TuNgTqg2S/RgEJG+BXTPW8JQnQPgggGnzOo4CpNC28/uyv5lHL+nOmftsDyp65FtqIWLz8h3ih3QqBadsJdetVZU4Pu68moBhLS/XcydtOaqkgGVD6aKOj03h7+7sWAYlntvNnLkDhDnGM1N29MkTrmhROFIBNko/PdAewZMTR1z6R6jst7AwO6+U5Su8L/dnST0VG6pAREsTqOPIJ0DOyih+4KlZJUlb78dsCj0HdRfSyVT0Zs5+RcnbM5L+V6NGWXqecwyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:05:13.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954020d6-d568-4ea6-8054-08dc38a0f501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

Need to check the offset bits for values greater than 255.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3203
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Can we just drop this code (at least for DP)?  drm_edid.c already handles
this properly in get_monitor_range().

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32efce81a5a74..c4fc65ba6b29b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11300,6 +11300,13 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
 				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
 
+				if (edid->revision >= 4) {
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MIN_VFREQ)
+						connector->display_info.monitor_range.min_vfreq += 255;
+					if (data->pad2 & DRM_EDID_RANGE_OFFSET_MAX_VFREQ)
+						connector->display_info.monitor_range.max_vfreq += 255;
+				}
+
 				break;
 			}
 
-- 
2.44.0

