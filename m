Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BA110EDA7;
	Thu, 16 Dec 2021 19:42:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3B010EDA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlW6RM/JZZMkFbsVbCzisV7HiEL9+/wK13SGr92IcBwf5FmUMdwPI+jkk26uSOAChQjYooWUgq0hUTEuXbnHxUcLLVLT6hRSyxqzjioQldCFti6xSCkGXlHQl7gYbszbI+B5xGDA3spuDvtucmQVNpzYWAg0QCpdiqdVgn82sTpSgjj+uCUtAq0ut/8q7SOamQ8/yWn0s2HCEDXKkeN3+aqdRZ8hv1EsbMCA7r/zh7GsnrKEOdLDa133ELrG6fKmDVOzy+ycLX6qF8EcB8DL4xJNv2RfZRjackwRKszOW1U2Qe2kPGsCu6ZwR3KJuuyqjclVD4ge1Uw5hDITABevSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WJ4NwypvQarIP69mNQrvTRMpumLLKJ5KPAoCGT7bvo=;
 b=a4VsLA+SvzcYK2MZ9Mm9L3iar3HXmsTSrSkq8KsDeAjwvGV1b6h0SM7SO7Ij9SNZ0GfjhCJ57k1fmzYzMJ/jw7FZ5zxYONPF2lLiEqXrTsus2gLvRKSX3jUPUS3MJVk0B8rhmajMAW84r3e73Z0Tx5WcuugFCxsT26uUCuvZErCXeMmESysqTdBbPlKDfgETpwY5THsEn2kdRH7dvYalgoHfoZ5sR1Iclazm2VdV7VbNnavRULr+LzVQv0SQ/9ndcKeqEcBCYcFhJxOpZXhKNWvtiOZAP+bRgbLPYlYTFz2eqmnSl+s4Kpe+9gJorxUIlOpryVpaeQ3kM7A2Q3T3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJ4NwypvQarIP69mNQrvTRMpumLLKJ5KPAoCGT7bvo=;
 b=eH8kN8EjjKWKcM8V/ZSn4lxOI9W0Y3zaEWktlLF0ybk3cSKmCEI85cyHGdoDcA6fxd6+MrVmv8awNgPrA2rlkgjE3QkA/NAdFbKdZFOr7oTTwqlMtDdMyw3XUYDLjmh8l79/SR4f3DZ1bhSIvAV6EIaDTRhc2P8rvF24Qdn9uK4=
Received: from DM6PR07CA0091.namprd07.prod.outlook.com (2603:10b6:5:337::24)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 16 Dec
 2021 19:42:48 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::11) by DM6PR07CA0091.outlook.office365.com
 (2603:10b6:5:337::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:47 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:45 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 0/5] *** GFX9 RLCG Interface modifications ***
Date: Thu, 16 Dec 2021 19:42:28 +0000
Message-ID: <20211216194233.3839-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0b6cd16-6098-4bd3-bf47-08d9c0cc3cfc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52474E8B06B2649D002368AC8B779@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCedOePBrsfSXbJisColsB+yGW3T8U2mlydvdPALAJ/Vbvq9cu1SAjIYXdThwrRVPGyQIW4JLT6cScor7QA9/JGHT/s6EFrQ+F9H5VntQ7jICrtPeOj5WsG9f3xIgzNd9Dt5q6Nzw9EZy+s0l6JuqRfDlkPBIAAdHqMFhpTVKoCTAW/evzdK/UuMFYLquGeiRyNZcZZVOCgeoNQwtC1br6z5MPGfr3DcGwdcGXvz7trDmbmnhOilXxhEnzFvGycYnnY8M29vK9xv1OaARLNwPg9W6++v2vxW5T8hH9KBpjM6N1vgRDotYNgUiNWxT7CLTvs98mlWAJ7wgGhxOEPfLSbGsvNGUV8WPuSme6WNhDdpyGtrbaUfvM69njI8+dv4jZZWvIMgslxURrSb5D2L8YIyOPIhMh5V1vX9Y7RWo2N/Z7S2NJUFmPwvAQ6xlfyhffmJeuX/jvOSTKtARX5j0jafkTyr2zkVhceZvkNCefppNiBJpwV+6dnVGMjbdmr+/CENK9Ur/eDVICfnj3hTG56x7+yEu8BWtAvyqDtXKBXCIWePL7oC33kpta+QeRGMwG4R/vn5SV1MAQM8FRclW50+Wc9BVH3dIlfn1+3rgI4FgKZAEzm0Me7aVNwJCOf8lBRCGx5fg7T2QckLQn20tA4HBgJZjdP5S186YKJLB+99XuVTfpu64egd3HDJbAiMusH/fpOXJCLxnZ/5CSmem6yJHqkRs86gC4D9f2aiecnWsovoN1ba/TYIO5+1oPIP0TpgJwm4RWkgItHOX2xlBTK6ciILtME++Hj+c1+1xfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6636002)(40460700001)(47076005)(86362001)(8676002)(2906002)(336012)(5660300002)(70586007)(4326008)(1076003)(356005)(426003)(36756003)(508600001)(82310400004)(110136005)(316002)(7696005)(44832011)(2616005)(16526019)(26005)(70206006)(6666004)(186003)(83380400001)(8936002)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:47.7600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b6cd16-6098-4bd3-bf47-08d9c0cc3cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset introduces an expanded sriov RLCG interface.
This interface will be used by Aldebaran in sriov
mode for indirect GC register access during full access.

v2: Added descriptions to scratch registers, and improved code readability.

v3: Remove the RLC function pointer init change. Move xgmi_info call
to earlier in init.

Victor Skvortsov (5):
  drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
  drm/amdgpu: Modify indirect register access for gmc_v9_0 sriov
  drm/amdgpu: Modify indirect register access for amdkfd_gfx_v9 sriov
  drm/amdgpu: get xgmi info before ip_init
  drm/amdgpu: Modify indirect register access for gfx9 sriov

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  27 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   7 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 117 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  63 +++++++---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   5 +
 6 files changed, 157 insertions(+), 68 deletions(-)

-- 
2.25.1

