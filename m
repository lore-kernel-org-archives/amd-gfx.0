Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3B9C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF52610EE08;
	Tue,  7 Jul 2026 15:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EgrLxoXl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCFE10EE0E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPKSw+yU6P8+zY0n49duTb7444c5sqZPSgZYBvWKTvFvTi/4EKD84j8UR/i0ZbRsl+kuUSgiYMQ2TL6trAGRzbGo9SQa52KMl4NRWiMfHZIt2efaSp1NsA98nkVRB2Tsod4dDePAKBCInD/xT8nvATv7tRlpR2woW4Au3s0fAA8pso+CgJtnYB21kZiTptfBIVUdS6WpM+cLRtphH06KXtYLPqKY2d+H6CSWdYOsJKqUezkwou3hLPLoi1Qb0p17/rNdWi5MRZcFdv7p6kuoJENVrGb7OIZbgvV7gkqwJKTEJdSzPy0g/hv0H+dspRqsfQz3Q5YdFIRU8ADDpgHjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJrSWRkZ+gilT9HyN7ma0jZ+4OrwcMSI+3EPufOs0iM=;
 b=w6pP+s/jR1TERaAKqXK7IYX1NZ7+P0Kg8dAImOaGRGdSJGvW+EOkzKq7/JifR4pH5vrKAxtSGhKdx3PAuAhwvbRCZRS3nPwEGFVTM7TRopsXghsI38kFy7qaB8ueqgG/Gx4SnzGyEhE35quNeGE66lo59BhpKy7kJkdMHhNhsP8fuY46yq1Go1UgRMD3hWog7mUuLYAhH56QeZKOooX/YZ7Pw9c17hzCBIJ9xdmoKp/Aw7fiDXKez/AiapKeAmz3Av5BlD7TQMBuNenaByiwkfKEtJBQ/biekadSI6zU9lEKpERsbA1QeHVNRQ2DputEoEe9HsDNElUzNXIY9YOi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJrSWRkZ+gilT9HyN7ma0jZ+4OrwcMSI+3EPufOs0iM=;
 b=EgrLxoXlTHh4FIF72dyOYQUFmP9HzBDHe+gW+MnDqUXezXEPybZrsxenW0lSjdGh9yKgLElXjpHjZCWVR7YYP0wkZY2wZJhzW0bRD8mqjEibBeqII7TvwdfY8VVWLnRV2JKE+sdKXGM/wxWmt7hb/v6zN6jFk9WZA1x1e0E7YOU=
Received: from BN8PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:d4::20)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:17 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::47) by BN8PR04CA0046.outlook.office365.com
 (2603:10b6:408:d4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/30] drm/amdgpu/atomfirmware: WARN() rather than BUG()
Date: Tue, 7 Jul 2026 11:41:38 -0400
Message-ID: <20260707154203.2603209-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da786e2-992c-4efb-bb23-08dedc3e52f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Xoqa99TC7HSO2N/d/nWmSf/aJQWDRNwUwFfHZWxOuG6lpHvDAho4jF+8SLfST6aeLuWygU8YfpOuXE1GRydXWmNuV/AcYYqp2/lAeHOOzOUDcR4L4VqBxsZ3UOCnNlsiR/vRZ5SEXkdbJElbMHtjYV9gIu2DtPTzml+z/a3fzN5qoiy/gRQFcKpZRUWHBUy9wAWE7SDeQ1MTyN03/iWfIjj5RYU+3dSyG/JtCcnRfV11Vltoch+ARnpLvZy0eats6e/KsMoEmpTIKR0+Jy3N8syCLcHaC89SPhuEH9w6KjILk136SHOgltySKwIvUlvvLaZZPWRDcN/qR4B9BWfKEGPlwPOBiZdztg2jVVu+Wp4NY3GLZ42AHhIXbI/Ut6tf/bJeHY8sUK8YCODzrziF/16u8cv9sMSK+RtV8j317rgb4ScUC8l1UTjN4iwoUFT3om3RG95C0J83UiQBmDTBXZewY+VMYJf1fYPe5k8/6At5Tq6ESESTB2wWOUKITrlTnnUnzRkWBe+mIRCWXaB1SNsXbwm3VGXf1B+1v/aYHHHizfhkQCwZ2oQxOk4dspV0cBF3Bs2SDNeQkEgWLEyfnY2SdgvKCkkI7mSmxDHFrUO/1LWbTVy20ywBc5qGcY9JeB+Bkr18dMKFggYxsPc2NymGtPETASzRz3B0sTw7hw7Uu1FtDKk1u7HAkH2T47Ajg9Qg+TULNxqlD7yj88MIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sB/lgm9LtSMb/ReJRvTdQOD4jdsbLUuHLV0H7db2BsYQfxytUZ2DUmKn55DutoRXG3J2d48aPPb8WoottRHdCzdkDYqKTRM8T0aiS+RZaML/Vokkw+TKwNydX273+CbdapuQn01oGojQbzGoVp4QCc9ujrxnhDZLduS6izK8r21MKRBWhU5eFpDjAiMiIDaTwEJJsDCXP/69cLyvaPlrT04prmQvdKhQWvrkxij/Li++sArVzDK4p3uxZmalOI+m4uu1uf2jyUdDQQ1ozska5/23oHeTFlnhW5ZpT2z3iZiFZl8aZHaBNo//b/dlQLd2mLYGMOpGMnzRLP4N1iHusM+GGWTnAuyrijEWFo6IZaLKl/psT861kMqFD0+hSkDp2aCOBPxKJaP9vfMt+tOSqh2j89FpyE7/0Coxt1LJLawvs9AM1JglQp6JV4AOaZOD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:17.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da786e2-992c-4efb-bb23-08dedc3e52f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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

There's no need to crash the kernel for this case.  Just
return an error.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6860a3a4d4667..1e21e3444802b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -917,8 +917,6 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 				   (crev != 6)) {
 				spll->reference_freq = le32_to_cpu(gfx_info->v22.rlc_gpu_timer_refclk);
 				ret = 0;
-			} else {
-				BUG();
 			}
 		}
 	}
-- 
2.55.0

