Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276DAEE20A7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DDD10E786;
	Fri,  6 Feb 2026 13:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hko5priI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7958210E786
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG9YzY0hecbA07krUfbpCyhxb+mw8PLuTCnW6/I3fei+kd07L6NaHxkFlp1frzHl0WQlJGvSwv+fWZPGoyjaQNDgIiUZIDXdrhVZQAUALjdZJbPba8LZIFEq8DmTLePQ/EA0m1EylzxnSFh+u4yrInU2bO8bfCtULChWtm60EdIigtJUcdxQAekknszLeRn7Ed6rAdIFRjFzNQUWw7PEK3kcCXFXEiyh0zmooM90B7+YycYOxOofXAQMlQEQvznKPGywM5mhyD+SXdoBYB5qK4PTiLyEWLAP6jVZKuoGsJ75V8KDgKPIRGZT5cK6AQDsWngZOGJwfyzyEKAK5wNDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivZBhhLt2raa0tCO7kBqWNsqdRChfJrNApHEyyLscrk=;
 b=Ld2vd7pn1ewhr9xQ6KTvNEf/yfm548Xv5ky7PXrrMusGM6RrNd55b8PidSf+3j/6LW/qLICV475622FQRrzHMr0Cadoyjtl5OuukIM0Sd+2j7JsYxdNFSO/1JVukrbotq5mQyGip7GQTCKVfG6CiS6EyDDKhZN1G5TM5CqZcnbrjC5kzxuTmUcgbPvYpQHUTF+GOS90SD6DEYxH2zBPtjz5lFPbxQ0A43G4ezw+v5qXVtd2e+XJR6KjqOlznQdbjkuz/jy1Y/yksg9khHAqWIEIrmChhFNKLVsAlWzVMEVcJuIc2JUEXiP3HDq12YAZgQYEVEgf4kwBs5qAOW6cGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivZBhhLt2raa0tCO7kBqWNsqdRChfJrNApHEyyLscrk=;
 b=hko5priIX3kytXkvjh3fc3ysNJnz2EvDwhZagCzroikOtLHAGZqXUZia1gmroOUvhYSjlxmgIb+PLZhUPCogQfjBhwLBO7GUQG2TjWU9c2tFDkjoXjE/IiJQuX3erM4BWDYm876C26ukZmG4gFiCR6Muu9/hNGwsuM612GU40Jc=
Received: from BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 13:56:13 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::77) by BYAPR08CA0027.outlook.office365.com
 (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 13:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:56:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:56:10 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <victor.skvortsov@amd.com>, <will.aitken@amd.com>,
 <Simon.Louis@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Move xgmi status to interface header
Date: Fri, 6 Feb 2026 19:25:38 +0530
Message-ID: <20260206135539.3843805-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 471cce3c-8815-4f57-a56d-08de65877d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ob7p+XOeYgJPHC7XzdYS5OOPtRzTDZ8AZ5/ZeDCML6SJJ5o5PajKS8w9G3f5?=
 =?us-ascii?Q?96Pb0NrxOKqfrloCYUuBlkRXaRrSYE8bQkpeENSFRlREaNWAUuQMKfcrRTIS?=
 =?us-ascii?Q?Tr0/5QwYq7g2RQcCBYL+EiUEkX28UEONgFzu7Nkgzu/3c3pGF51qi6AtmaMI?=
 =?us-ascii?Q?x7gi453xZm8NhDsFfovhIVosxiOuUzNw5lYJbqKcG9NE5pzaET9umrE42Ahb?=
 =?us-ascii?Q?ea2ITXgkaZlpuzewAWwt96o/b01OEgLPGYlQPYfzcK8aqdiToz/6BYgw8DlE?=
 =?us-ascii?Q?Y45CIwMO2oYQqewQfeRduLGDMXeLamViVggl3qmN/s04l50X94OgjFO7IaVy?=
 =?us-ascii?Q?GFE/wuJNee4X270ho7bFNLp1KNadG10z2tFW5DefjAn7dXikMhWTVB0Jo/9g?=
 =?us-ascii?Q?uAR4L0vER+5doAzYHpCU/Vf6plrVne1PN1DzR890u6l6RihO/6MLRUTKVH/Y?=
 =?us-ascii?Q?ekSMIWdhCpxSlWV+nitEGhmoU8ClWLmbOWbyI4q3B0H4mXlsuQGMUoleRZk+?=
 =?us-ascii?Q?TCroeOeWS3Ah8J1liGI2Xnd8Ukonqjf547gsFh1syxsP4q9sef03MlqS9A/H?=
 =?us-ascii?Q?3FpgGyy4VT9AEAKDkIyT1zAH+eQ2n6Vezi0yLkLd30p5shZUWPfhAuRH5Uij?=
 =?us-ascii?Q?S1HRrgoJQu0uVs1sJA9bW/VytPOnfdUJ1DmzY6zfwimsAtW2gMKTFIPdx6QL?=
 =?us-ascii?Q?lXyUdju/PJGSf0mfD7B+xZ9raAN0AinbfviQInyQw+cNJjY1ALW1nMWtV40j?=
 =?us-ascii?Q?Ms5bKFo1j0mliDk2kyfSoSGEUYMew7EGP5CDoP9EDRs6zRmyyaaoFaDPkz/K?=
 =?us-ascii?Q?Em4hlO1/vmO5q3FhwJ93Rl/q3FdE/78rm/uXhHIbT1fQaD3QZcBVGJ6Zsnaj?=
 =?us-ascii?Q?ESeDtAIUkABcWYqfAl4TYWhdQK1UkY3D7XdULDkuLMViVDFB8Q5IFd1aEKeh?=
 =?us-ascii?Q?J7bYaapBHID8nPBLTIHS1MyUQ7iCEFT2p7gucFnBZ3hXEEOK4Vqf/EbMn8iN?=
 =?us-ascii?Q?xeI8V/Pf9Ou9NZEDO7POkyeV4L8fhegusfazV+YbWOohpqtX0Cw6w/DPXY1R?=
 =?us-ascii?Q?03ttSWG1wAq/NLamg56d8PfpTKT6zrxtHekvw+azhbKjLImm+vcS5ujKJc1w?=
 =?us-ascii?Q?WU5EM/vLlbM2v7v944mW7gXQLG1DHCGDKJSZyupDlRRi6c2nlonTQPKEVl5D?=
 =?us-ascii?Q?MfaNa9dmUMnU2c97sZQ/4e9CsIHFXv5YuUGU4hl88jp0ObFhBoi3aawtcsm4?=
 =?us-ascii?Q?n+NBPEster5qaP/GFyB889PFq+E/cO+OXgP/zdtHAm39MpVL5oFVis0y3pR0?=
 =?us-ascii?Q?OXY1JTMpUmlo8zO/8dV25gG4NDfsHkx49vqSVaOCBs4r8olzsgOq7dX8hssX?=
 =?us-ascii?Q?cwSzfpD2LFz4iqqn+NinswDDCxGrkVx8CD9UqqdN7ZZNQp+9G0YnA/5ANWFI?=
 =?us-ascii?Q?CuEvNNEfxhLZfHeLG6fLxPZPUPCw3/htgPLUbvEiNLe/LmfAJxB2LQKpCqwB?=
 =?us-ascii?Q?m9qTPT5+dxm8wpA0zfYRbcJDFugwcjrqcZoQp9vtEUj0DHPweRfCY/utm+3q?=
 =?us-ascii?Q?kKOk0Zw7nnjPxlmVlCSLD7FEpBmIwqcdhQAX5MttAemCO4WS5wNCxv2mPnC2?=
 =?us-ascii?Q?cJKnU+O99hcdT3teB2lMOHtQQ7PlzV0e4mLhl5uokyGqsTErvaFaD4d9AqzH?=
 =?us-ascii?Q?p9ph8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5jqBg428sDMaI89snZmFfHOqZ4a53DLmQ534KfP38r2Ae51X5lGQSAvKfwoPSjOyTi32Nk8DXFxPOHk/YS39iksDFuA5oftYybKHXX5UuJGPN35D8KX5w0EU5ZWO2llC6qpf2lFF9SdvPuujOpz4uhkN5ZXbC1hvrcWBK4Ee2IWxDi/hIPdzqNBs7foQ1TwLRvT3OvIgkP0IsLYSM4gmk584M57c1anxWVNbwF73MyYpW6S2MTdiD9hEevSluRMD9jLLimM+fXIAMjpTTV9dJLxAdeCMDkl99Pa5t/yV6GLwDPPk+jo79X7/KotAgsDrd2iG3yloUp3u7wEEB98ztVtuSP+LbI1xhiYOTxz+YMAK1A3X7ofNPkv7mUt5Xb1WD+UJMQBq2UWYzcFxOy7Zc3t5ohNvphwDez/YGQN5udLDpfyhLh3fa/KDffHB2AA0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:56:13.3210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471cce3c-8815-4f57-a56d-08de65877d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

These definitions are used by user APIs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c       | 6 ++----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 9e32f343097e..0ca6fa40a87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -42,8 +42,6 @@
 
 #define XGMI_STATE_DISABLE                      0xD1
 #define XGMI_STATE_LS0                          0x81
-#define XGMI_LINK_ACTIVE			1
-#define XGMI_LINK_INACTIVE			0
 
 static DEFINE_MUTEX(xgmi_mutex);
 
@@ -365,9 +363,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
 		return -ENOLINK;
 
 	if ((xgmi_state_reg_val & 0xFF) == XGMI_STATE_LS0)
-		return XGMI_LINK_ACTIVE;
+		return AMDGPU_XGMI_LINK_ACTIVE;
 
-	return XGMI_LINK_INACTIVE;
+	return AMDGPU_XGMI_LINK_INACTIVE;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 9fd78fcff15c..6683ffd6aa68 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1829,4 +1829,9 @@ struct amdgpu_partition_metrics_v1_1 {
 	struct gpu_metrics_attr metrics_attrs[];
 };
 
+enum amdgpu_xgmi_link_status {
+	AMDGPU_XGMI_LINK_INACTIVE = 0,
+	AMDGPU_XGMI_LINK_ACTIVE = 1,
+};
+
 #endif
-- 
2.49.0

