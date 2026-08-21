Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAEFC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3DC10E2A6;
	Fri, 21 Aug 2026 21:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41mjUxmv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4074510E2A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehjbyk1xQZ7GecfJ34g+E6UM73w5aMASlJLmjemx7U1aQJM0PrMBkdsSU7n6rSYI54KY1JiqjMFNm4PGiuR+iEOgeS7Cr8knnn2RVIq228yrd9o8Iim4au7Mol0iV09jgYqEUSCzH22AviPtImKGP0UA6abd2DvFRoHOzxk+WvSMqt/cBkYQ3eMouhw2IRujG75Hs7wdnh+MOTHshXvN/NQ7eJP89UqpuRsWAiRQfM0fMYoaKbfWHfkR0jwv5Kg/0NSc1DpCRe0sWBmMqFhLApm9pcWESGJ0pxvwHbh78O6HxySGRMImtbw0VsWZqvpSupHoX/9vM6Fld51RhtONPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdlYg070VNm0FvTMS+dSH4n2jix7gCapnOBiNhbp7FM=;
 b=JYDR17faa3nNqsnUHvU29USCvWjNHAkX4TwaYctH4o2RwcPCc46FoA5pMjhbh97z+uAcjkA6+DqdpIYirhzWGJaDxUrlTmuMkfTChxFY6T1ySORsVqO0xXjv1y8l6Hqia0zXPQFl3XQ3OxZCGLqELZXZZcCSgFuQGLhorYECWkiuKHYyR+HEErC5aFfGaPtOtH2NYSIVB7c0BqLTTDehVCxEqDd0S1hH/ken/KMuxVeWvhwLmbHFRmYnhGGDqWXGnvQpZ0V7pYMUnLLrA938BIyDfSO8fV4lLDWQR9RYLaDtXsr9XgSGF/bzXlEM1JS4WghUmFKstbr8Rg+kjoyz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdlYg070VNm0FvTMS+dSH4n2jix7gCapnOBiNhbp7FM=;
 b=41mjUxmvFoKIRJ3GX7gnWlRoQpzOiDAhoERsPV6zJLBNnvhTavZ8Z36ZkWdmN48scMl5/IJxxyJ7z21C8Rqkj8avDAYiCisWr8tDzXEXxR/6/Bd0lg2lb2q6S8i5JQxszr1VPJ5wckh0qpgQg7708zO7idmdBOVMHPc0tedrrbI=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 21:36:52 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::a0) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 21:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 21:36:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 16:36:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 16:36:50 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Always report native cursor mode for
 disabled CRTC
Date: Fri, 21 Aug 2026 17:36:44 -0400
Message-ID: <20260821213644.689017-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e0ff7b-ce27-4236-426f-08deffcc504a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: sENLrYCPJGUpWceL5la11wQn4qPfCLDd+YRCOwqvmVDm2h0akiKIYu38ZQko6uK3fjawf79fyUT+/LikplTCjcgj+HjKxOYdkpJCXi0PEMAq4ezxSH75ndCgl3/G+fhKOLD4EngF8MVyF2xrIDC5u0DHTjtrgU/TIFciSd8GixudOa8yT4lVpIYVI0Y/iWoDtgRW2B1iJ7MfqPddmUABef8pgAurZ4W11gAoPVp1fEj0zskVPuvj15OU45Plmhcivg48YaIV/Bjnd8auEursUGyFZV1uVJH48Haz/+8K+iZ8dtkKEIre4boFIK9ChQHjm/pp0L76Zmf09mlohvA+3NzM/IgD3Fike+ccloKs3UBU+Oa71R92MpJYM5N7ZnR8MjoFZTga2gU+SLF+xlP1v+q5oheyHl0Fm5nR/1o0Ai0zSSvIY34G4Aym4JW4//2zahAUNWUJnlSbq7y8FZhZGudbj8eo0jjCJX80X9ahhB90WrjYlDvI8Hwfkz56Au+wK3RSYuEUchA/lTZxRBKHu+xeLQ27jdOrVsyeeIZkfQGBXffomX6ZhyoDCAJBBzMmjKD1fn07mUP1aYWXHkDECrvdcdC3UPRp01q5/Hi3S/nhQgd/zWT2qZZDKZgx96htKXUWIzr1lZ1aCEXNe1q8++siIQEQuoqNo2KDGt2qSgXvZwn/4x+zjUfrRd5v7OtrEI1DeMSXya5CeudxkqWnjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vWzjE0slj7zJXHqFqb/HwHJICYoxmlnm75yLee5gP6+Mt2lHWx12xRXcxZD+EsXaQG4sSsacZc9PcjQBkbc8WvNmQkeTTFNrco3CODzH/NJbCf/1B2C0QwlcFIQolmuqTjV7QglRiJGcEtLvRGWN58I0/LS5MTumQVkMfYEP1e885YeaUWWVWKiUnrpjEwIy2jEx+FMcVVaDQSlqFK9FeoIxv9Xq1TXqqSulfqvuwYd5c4K4gZ8KEFTIO5QwL93XH+9fFeo6t4uf8SVLTg2mwSSLXsvGobDKz9KXLbLNlx7VRWtfF6WX13doVrOYCrEXf8A3dJKEKmuDGpnP1MXLzHX6zLdiwVEkrvmBDJxgpbMyZ4iKwuwyK1xPPLc5NyY1WyAyzixpdexSHpBI9tLqyO8CSZz4vQfzmnYRmKyyU5t/EOIhCZEWwYliKlfAzwrP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 21:36:51.3899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e0ff7b-ce27-4236-426f-08deffcc504a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The disabled-CRTC check was bundled into the DCN4+ version condition, so a
disabled CRTC only fell back to native cursor mode on those specific
ASICs, resulting in overlay cursor mode on disabled CRTCs on pre DCN4,
casuing failed atomic checks.

Move the check into a separate early return so a disabled CRTC always
reports native cursor mode on all ASICs.

Fixes: b7d7e714de44 ("drm/amd/display: Fall back to overlay cursor on dcn4x when top plane doesn't fill CRTC")

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index c41fce07b8fa8..8204ad4018e6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -287,19 +287,24 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int i;
 	bool skip_fmt_scale_restrictions = false;
 
-	/* Overlay cursor not supported on HW before DCN
-	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401/420
-	 *
+	/*
 	 * Always set native cursor mode when the CRTC is disabled,
 	 * to make sure it doesn't cause atomic commits to fail when
 	 * they are trying to disable the CRTC.
 	 */
+	if (!crtc_state->enable) {
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+		return 0;
+	}
+
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401/420
+	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
-	    !dm_crtc_state->base.enable) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
 		/*
 		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
 		 * skip those overlay triggers below. A plane that does not fill
-- 
2.43.0

