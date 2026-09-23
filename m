Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94791C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F36710E939;
	Wed, 23 Sep 2026 15:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMZWanuM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7430110E934
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQi6b2nEJaY64Rihd93TJfm/AbFxxhM+aLaNfVDRrLmjFrCjPxVJDFakFlYGgzs73O7fRU4NZypp6CPAMsMyYyrW+SgHQFleTYtJKMVQ9SLFhCK36mSpPpFqE7N8n9Ufkowv8K3nmCj49gZRJshLhmKhBWSG1yRLf32J3P32teFHD0LT/B93Wqj7o5rGNKvhnw7hQjhcewNbrDMKlpLEvgmeeD/g+tGGn408Iu/J2E5Zv7PPfCW2S3eY+d7WaAO9dJGZeKA++2BHzqbmDGdHgX+y8pnEOfd4abx+lIQrZsX4xFDzTfVThzGrONEfA022bO8o8GvjxzZWMPwJ4xQESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyIPfaMuXPMpZfUKFqPdmCnRUra7lPJ1Ye9T6f589R0=;
 b=vfL3+jOM9xSgbN0nF5wg6CNb2DKS2cJK5pyogDQASGOsBGkUHPRV0qXYtVlopHVSvHsLxxMs15N+8TDuViY8c+4ZONmepFdofogqIc+/ZLF2hPySvOJx1YgV7HIQtRr/FZXpVN/KnZpVNsn73v+5XUeyLFHwGod1PGZs5aYqCQEXBC8+iXF+shDnk4EdK1MVorlzTP7gRnNfNYXJtEYcShMZUwx5RViyq5sCVM4d4uPbJyZlPg6gUWgCLVd/N3/kBMcMIBJ7X+JGlgTg/Ch+xvNMkIBbZcAkQf/l1a4L2yCXdy/gkIeN7k6F4/rIrwfRpafVsgH2N63w9GyQcCdFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyIPfaMuXPMpZfUKFqPdmCnRUra7lPJ1Ye9T6f589R0=;
 b=pMZWanuMaMcWZnOhUfoPZPogV1a4Ye3OvwqVjsoEQsfmv/tDULbJFVu7WIB/j1tBsTd1lZ6sERExy3zR1UmM4mkXqVjtJAzSzeWd9mC79ZG2RUlAiK+52aup12WrbXB+UeIWi6oFdmCZBOr3SKV/2YQ+ybr4/Dtnl4AxwXiMlSI=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by SA3PR12MB069216.namprd12.prod.outlook.com (2603:10b6:806:52f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:51:09 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::8b) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 15:51:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:51:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:51:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/5] VPE v3.0 Support
Date: Wed, 23 Sep 2026 11:50:52 -0400
Message-ID: <20260923155056.2816021-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|SA3PR12MB069216:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4aae30-f88b-49f2-f76f-08df198a7c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: r94D8Zu+gWcm0s2rCdCYaGtnjWxYKHDvzHxMNU6Ai7tMZMrHTrCc32SdyI+DXOAAbQmSVeslyl1m92iiQtyYK/5xwi7DTY5qubKs+eoO3Zvd816na4fZNGLo6rwL7mYfnlZOPoRss8dd/TJAjk4mDBRKMP+5uPi3Vdz+g24oXfK9Rr+yj6jtnRnxvYX2xMh58FEVIMyj/Ch9kEx7PWXmur20sWlX35wh1uSmtN9ipfvnSuvuGOp5ls0UVmV6kyRLpQ449pxz4la0p35CRAah98GK0b6crfes7lDGTXESFRcoR8lN5UmS3TfMOLWm/y2gpS3EZsF0lZWEN1DRxHav5ZqgyZ7Uje4IWfACh+tpdu7stuy1qYqs3usyBn0QYxoRBYzi6iEj6wcel/jDe7BqtLnyjiP6BGGhUfaZMmQfSdae2y2WOWO7CQMF6FQ8KV2eA1kPhPlT15EaQ4cTtX7UMc46KvfWgYXjnMUe+flBmzTNIlYl7PBa/O8oXf7jYB34XmQfihssMOe8bpYrHk3jpn37c74MM5liEsqNhfUnt7UZMupQ4PubaKyalHwVRto1UgGdb56ygS6UIAi6BCiOChBy8bVoRNhwMTa6y2pNYtwxPEk3kx0WtmJRhkT5QFLUcxKjqYALL2aOEJLMHvuhS0bVWby5xKymCB4eu8WJL5uefvKdoxNleO9xIti1ao8iOaT3SmtSkQZ1R1BcCUvCqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IsSzG5hjbMonQkHNwDirdU2DmaxVFJraxMeynt7YCI+hjbNe4egfAhBAqUrkFHiuiuZ5fgjdWf9Y5usWl8MxC37n3UIC9Lj2osKyTRxQSSQ4cNmdEvB7txjsjXpfNau+DGJRf0ZevBfQumSSMm3UU3E5dKYEztKRsuf0/tSq9sB6HDofKCqjgGVYfW6JgMWyT2oHL7aZhigSbLQ/OGCahypxbLVdn9YVgLYGM7oSCLTtAE6bxQ8kFIWgD9QY3kdxfsv9dPQv8M7PJpi4AZKTZm4QO2jN4Mm7uuCRF6AWLfTlKLSVmSO0+RF2dnAw40eGC1XJyOfA2UIHY0pJtmXRl19XUoZlIfLc+gpNuORmx3AYMZGBTkBJgwIN9OM/MebUxEzkYmIYVLBfjO0PnY79dpcFZcWcqzo5R/MugRuj9fjeAQNH92kp+bdSLPL6ZIil
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:51:09.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4aae30-f88b-49f2-f76f-08df198a7c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB069216
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

Add VPE v3.0 support.  First patch adds new register
headers.  Skipping to avoid spamming the list.

Caden Chien (2):
  drm/amdgpu/vpe: add vpe v3.0.0 support
  drm/amdgpu/vpe: add vpe v3.0.1 support

Hawking Zhang (1):
  drm/amdgpu: Add vpe v3_0_0 ip headers v4

Lin Cao (2):
  drm/amdgpu: Allocate VPE cmdbuf from VRAM
  drm/amdgpu: skip vpe dpm enable if dpm_enabled flag is false

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c         |  351 +++
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h         |   29 +
 .../include/asic_reg/vpe/vpe_3_0_0_offset.h   |  877 ++++++
 .../include/asic_reg/vpe/vpe_3_0_0_sh_mask.h  | 2661 +++++++++++++++++
 8 files changed, 3955 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_3_0_0_sh_mask.h

-- 
2.55.0

