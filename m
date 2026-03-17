Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009C7FD7091
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7600510E6B3;
	Tue, 17 Mar 2026 20:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwfeOzIq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E60D10E65F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft/bYFNAFSV3hNhtX3dDNr74Rk8/n111Ba/cBB1dBKmrBonfsraUnCOISlK6RpDfW/9iAHtCtIc1YIchFbyQ/R1h81SfGS3Vbf7tYPdgWry6Cfs4wBnVHAxYA0VZ/oMCHFi4bgxZwVWo57HVJvXZ/4dxqwKeF10k/JhiPI9rO3tkNLLRCkF+ddsxJGZzKiKQVb2EuYHOd6WtOmRnjFwy/VFfwG2wUfXclqPST1qDLJhXniWCZQhIlhJqnFG4zLBZD4IQw0kmTzF1prThDsVZTSM7YG9lQev4ZTryKr4WSjm0ngcW1XwTizWCbChDJ8ntoHrmPP4RHwX04C5BsQVjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJtNWcuslwdXAvkgQK/dbL4KYDUf+ffnbYMe3EZr6zY=;
 b=gAfYHTOVTtB9WBxt/WzaEivoSfHYTHs6wFcroqcrcoU+tt9xcnfEWLJLLEJNMKY8E6acSo3jLCrjcTtA50N9ffsUtnNB1A2cs0priy3Jr1T0vLu2Qrhq8xpsYCNecWkYzmfXpbz4jW9ClnGgSWtWVFAnnWgYuV4oramKq7YzRv1GBtBH7b0eI77LZIqLDQHuQpwQzlCa10YCPFpnYcWBNIHBfo2sBe9l6p5ru5kp/JguRuXujRljtWpgH3D0wUMvNQ1BT3Fl2/1KaqBoxtPGL/L3wRILqLbOEtwCxxT7t7VDBI1/jE1jqR7rJ8uOtu15WvEQUBFvEU5jsb+AUa0j+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJtNWcuslwdXAvkgQK/dbL4KYDUf+ffnbYMe3EZr6zY=;
 b=UwfeOzIqqW6MAkXvioP3YxtxvdZPqXkc36/ygyNuKL4JW4OwFKIWiaWXFq5CR3EentKDnTMWspZTyT9MstDkv5SMSzCzAHTOvzNT3iOtafRyphaFZpLFbTv/84mHGlDNZDTSUsiTZDxEfUccLSMeAeLSavQv5xx+RwmWg2goiaE=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 20:13:32 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::94) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 20:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 25/25] drm/amd/pm: Enable user specified gfx clock ranges
Date: Tue, 17 Mar 2026 16:12:41 -0400
Message-ID: <20260317201242.3808136-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e8c54a-05bc-486f-65a0-08de8461a86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vvhuZCbFvrVVae91aOFIApMPdS97a1LUlHRH9pIEqp+XQcQyBlA1cgXXQiSe2fY3Z1tNkQYAD0hhoxOyEbwNDNl9XsKSfEiiPt2+JPXF4/eVqdrff8jr/Usc0UzbBWJ+uHEBGDEmbxs6I1oGTJYUtGf9UYIkONSUC0XVkp7f42norZHVzJSrSfV9uqZafxDSgP7ynY/WXMXO6PvxcdpX9mOA3AZ38294dqtsAyHt7Zwe0CTCk4txbeJjnCUypotbwuAj7HMK4KdNcrdq/GDrChfU8veGiNW3WPG+I0y0OJ4NdqNL/lQrD4rSbI6hV8syUTiPlwElPj6ERsZ/9VQbu2EW0QLk3MtRGl1KQInFIj8bqXLm+tBhnALA0I8Cq+cfabpFSZQxEm3c1ZMSi+29SfYpKLEG7PA4fQ1P94Mr1VVr7+aNQgt/nVZxKjXMuNisR+/UyRD7fpSVEX/vAvfzRgbw0guAEVZ4VpZAEI4L1A9mwoBsMvPOyuTKUHUf/YkhXo5HtU4egPH9uZMqLcXKdcXAAibgTVwbkBVrbTcHpAI3wOeUrbK1IzzA/awOmn6tDi39/sYY2b5ncUVNkKQWKgBquUAOmdTs3JccEmo8W1UDsNmxn2Qw2o7UQJImOtO7D6cnsrIV8RQcQNQDalA9B98O35vtAXuyQCm/y+Q6igaOvRVs/4vgp6WIhCiTlja+q+/lvMbcherkfISjxav8V4MCbLI9BuNNUILNS5bB16gJ3fAV5Z6dvDMWF5/030Bv1RSJF2UtFw+PASlXn6nXGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JAzMW4dDAAY5bkI0Rdd8Ag3aEtTeJuwWBNjqN1L01UH8i/mT25jE0VNOV4PBSbLq5BZsIxjFrDacSbYNFSghhoyTYqyLQ4xlimvMc9cjX3qZY2G68pDyMRu9Us8rmpkKr5EEeQsvOWZbTEUKOE009z+AGJGhOasJir6Nst1ZuB73TXUzb7QYNkLyd4MCHVyWk5QbaX6eCVF4R7Ot0sNXOBnq3tv9rm/vq0uVDXDiDp5UbWzf9fTO8yvz3Q7tVLl3fpsawkAY/D6lXYFyfxkW+D1OE1BjHVmI+LUak09vp24HRLA2+c/RQXTpkk7s1DgIHY34z/sXki1z9ugvf2zkB/BRG/oa2tPq/bjzLlu7lbAEMoXL0EnVEvWaAWt0ntMcbtlq2TGJXa4+ThVaKFHDlDSV7nB2NxPjldCli9XGZyRDrMVu+2BcQLvuZBfdTMOU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:30.4213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8c54a-05bc-486f-65a0-08de8461a86c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

From: Asad Kamal <asad.kamal@amd.com>

Enable user specified gfx clock ranges for smu_15_0_8

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index de82eb0f59934..0748c42ec7d5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -805,6 +805,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(15, 0, 8):
 		smu_v15_0_8_set_ppt_funcs(smu);
+		smu->od_enabled = true;
 		break;
 	default:
 		return -EINVAL;
-- 
2.53.0

