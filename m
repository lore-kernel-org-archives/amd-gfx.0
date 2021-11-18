Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D31AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D537A6108B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D537A6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA696EA2A;
	Thu, 18 Nov 2021 18:19:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBADA6EA5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 18:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzGSMKciyRI9K7aCx2Vj4uQoPdieH8ySvQlLnIOGwHkmIRCv9bvIE/ByYX9CfbSLga/tINK/T1F6ErxtBmJLLSCDnV4m1oIHATIZFas+MRuGxiQa/K9/AyHji4n/xo4MPvPdAevtKpMeJ8yQKrizYRGfhXNiW4qUp8pnkeyhywc5XqVa9EcUSTTNwCtmJcbz7AgD2TFFKA4r3mwYHsfjuS+ct+IEBFOSTSMMmX0XUiG2568+2+hboa2eonxsnoiTY8Hlb5qlLIfSa0Q0sO8QYzoeuzMaqpFyz4M7GY9NuqwfHdOyHS4IySK5B5ouLGJJpRbT72TVf0MQq0o8Zexv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZzgVY4qOHMG/g3X8g7Vc9ibAg8SsA8lm2ctgcXpMH0=;
 b=f4yNspPspbJSosXQloxfp+uclq1IgkZLNQgc9hdEatmTzEPdQmEWQ8G57dU0QTZJwDw2mRp6Ogbz/cOd1uJwexkrn07oYrHelw12rw384PzaugQ3AKdnhwBLwmxwJ/F5aGPYFz7Ukfsw5e1gXMD4tysGX7ABBP39pXnjs7tEGX8pKif0sbFPpyB0r96g35S69Oo8tYiHOoGmvlJBwOC+5GxRO1C5NzkNbV+WYUE3rxN9KGRyo0CdvQdN9ZRUq/5ChzGGX8rV7UlCU+cPQcRD63z3naiqTmNACdJAsMm8KLusTp8/v50S+ZIRsEkIXQhs8PEEpOzFyxcGGNLLxXgJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZzgVY4qOHMG/g3X8g7Vc9ibAg8SsA8lm2ctgcXpMH0=;
 b=MnWSzbDbClBdq5cvFojuzhTOXnBVmMHX/gJLMJ4xRfcybwsjbJgkozMO9eoJnjGUBUFnL07EnWOZh4UCaBmwPI1/JqPdSyuloX9YExucWAMZqFzg1baAD+JfK597E98z7Fz0AOyKNLXujjeYONVU79dVxdDP6iNXFN/GMjOJya0=
Received: from DM6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:5:174::18)
 by BYAPR12MB3045.namprd12.prod.outlook.com (2603:10b6:a03:ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 18:18:59 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::bf) by DM6PR21CA0008.outlook.office365.com
 (2603:10b6:5:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5 via Frontend
 Transport; Thu, 18 Nov 2021 18:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 18:18:59 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 18 Nov 2021 12:18:57 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 0/3]  Add Smart Trace Buffers support
Date: Thu, 18 Nov 2021 13:18:24 -0500
Message-ID: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5bb36f-9f6e-45e2-71e0-08d9aabfe427
X-MS-TrafficTypeDiagnostic: BYAPR12MB3045:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30453718808C202B962E4614EA9B9@BYAPR12MB3045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXZ6uWJn8wi7y+FgzygHs33w7f1VfTMvd1kZ5AwDCCbtmBSuMG9PrQIu0K1nrICptd6OSVCJEBdZuxXA8MBnRIQ7J/dtC7MnDpiU07wVOp0UNfVtOJBa38aBTp/wtCNqrW31s+Us6yRlVBwdiN9fnVGZlcYbjcVqVwDRbh5IOemP0dk/RWPgShNyGeYd/+sN5jnATcGxK092I7g5OsBANCzFQ0sSBDasRCYDvfSe3QBRh9SD7qqmx+yxCe3u3sGgOqAAY0tUPH/g2/gSuCgy8LP+Yp8g2t5jm2fVk6xKbPxA5tRHomo69efEwRCnM5hFV6ou7Igd6drIovJNQw/mxqSPiNV+54XG+thymTXscVG5Yaj7SA2gDuVuml0dsgERzv/hMr9ZGKS/8hwod2mPGsW+BGO085hJcTLB0UH74gxJMqcgfAzOsPxdiuwwBozH0Ijri/FE/eJDKTntXSA0NRBjKXmE5iuhNJiqJztrIJQKcObvXGBgmRyiD9KVkRiZ41gBkDsBw8kZc1LRrYMNskL8nQaQaqRuxhn0GrtghePstP7fG6+Xl3bCSeDy31cBsObfMCQ3isjHUqUkrncisuvkmXPGuirCXfebPBcdnjtEj4MmHmfpLv4kqL0NyUYtcUiyKTSk3YEQ4sF5j7g7aOUK+d7ERHzMCThEw/woLjzs/64MzOREOxrxkgkvF6LtHVK8H1wjOFMaF7UQDM+qfU8BO/T27W6mNoyyDYZPHIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(4744005)(336012)(5660300002)(1076003)(47076005)(2616005)(54906003)(6916009)(316002)(6666004)(4326008)(8676002)(186003)(2906002)(16526019)(26005)(7696005)(8936002)(36860700001)(508600001)(36756003)(82310400003)(83380400001)(356005)(81166007)(44832011)(70206006)(86362001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 18:18:59.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5bb36f-9f6e-45e2-71e0-08d9aabfe427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3045
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
Cc: alexander.deucher@amd.com, Lijo.Lazar@amd.com, luben.tuikov@amd.com,
 Shyam-sundar.S-k@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The Smart Trace Buffer (STB), is a cyclic data buffer used to 
log information about system execution for characterization and debug 
purposes. If at any point should a system encounter a functional 
failure the trace can be collected without need for reproducing 
the failure while running additional instrumentation.

Andrey Grodzovsky (3):
  drm/amd/pm: Add STB accessors interface
  drm/amd/pm: Add STB support in sienna_cichlid
  drm/amd/pm: Add debugfs info for STB

 .../amd/include/asic_reg/mp/mp_11_0_offset.h  |   7 ++
 .../amd/include/asic_reg/mp/mp_11_0_sh_mask.h |  12 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 104 ++++++++++++++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  55 +++++++++
 6 files changed, 196 insertions(+)

-- 
2.25.1

