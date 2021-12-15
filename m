Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE14C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B35A10FA10;
	Wed, 15 Dec 2021 20:45:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C57A10FA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTeXukqWJrf/faUJ5SzBolVQz8J14otGVXatSvNPGw39Dky8vvTa0/nmM4xxWBL9qY8o8s9f36TJKqMIIRyddt99SqkHyoeBHIV6S9U78yRYuaSauqnL+NoU67N0Ez6qKbm8/tsjW4aRl88NsgkOkX7lm8ldLLfvj9uFGX3LFDFPuKwTRYyg6/S9ti/gHk4S/ZOvOFQDybVMhu61NdcanVYnpJLZ257Sco6WXF8jQkaMF3gk7tan5ZyKP+Tl22+OMw0CNQnTYFjDgdmwf/HJE8d+YNpKgsH40W9uN3neYTsCe0Dagho8uq3IY0A2s24kf2Tk65vgcO7n0wQz7k6MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D02TFlVl9q65G9ShuB3b7KwuvoUofUjtJHoxRoN55Q8=;
 b=Khf7IvhvwmlVmDycXTA5An68MXr0xoYk81RX+/hZI/5KXWwgG6RSlMQ3p9LfK48rjLAKg4fBqA93OBuEvVFqGeby+57pfsrBTqCqIajcAxOZh5z1gvHk0GoSXZq21PDArorGZ5T5W6qafaeFOR7Wu6MP05hDkrfx5N2TgIFyAEISPuVht5BlxNT8FVmrJX1pLEGJViSuTstrwZAVJOWj8uvotZ2/uE4PkbWlLMk2AEDjTwaZuOmaIuGTaCM0d9eu2tGUuLrPkCagiuZWbBOtSMYONZp+L682D9sUvvVatrYQ/ek/3hPk8LWfpYkOKfwnsl+AV0RKNzjbnZ4NFmjgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D02TFlVl9q65G9ShuB3b7KwuvoUofUjtJHoxRoN55Q8=;
 b=2mdDlCOxDJzlaYoF8avbt96UK+Fg/e4eeZF64X7fNTrm7Cc67ZKldM/Cns89M5GAOCbfSAXigFbDkmcfw7jVvapx8Skc621xRWqXu8ESOludTMKD4eeD38WVSysXhMlkYluQKc0uWeepdacW8XT6EtptAGizLwu/j1G6+dx0RdM=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 15 Dec 2021 20:44:55 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::b4) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Wed, 15 Dec 2021 20:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 20:44:55 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:54 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 0/5] *** GFX9 RLCG Interface modifications ***
Date: Wed, 15 Dec 2021 20:44:34 +0000
Message-ID: <20211215204439.7216-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b088e827-ad96-4ee2-f785-08d9c00bc06b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2692:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2692F4015E608AF50D7F956A8B769@BN7PR12MB2692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsX7RKQitR4F+f3WtPSRj2Eu57/eI69gfKFQDrE9z+U7ECVSjqMwszujKrMA3repoFw/1oaC34vvqwXLvdKNMA+s7a3tM0lpQ3qcfkHIpawAYiIwAisp4D045sXvEsy8hHple3n+NYUMYd901HoBBiRGHRUnw29poHrxyvzqoE2ugNMeU/pwCUJWY+9UF2xuqjgH4me2QU7Rpc7CB+5Q65SynuUHbggqWNR9w0LinX81PwJFtzVsSmladJs8FhEKT4gZ1+3jk4UbFG3YfDQQc30iZZAh/Uxjq4+8iCzUUNwsxDcXZ/kWKVJb8K39E4up8TyVEjBmphA+fJB3mt0GQXyZYxekWwiuKEiC3fZjHL8QxrvX5Y8WZiDBac3ts7AgkPhfFa+s/WmMuD/4dbATTBsZc4VnQBxjooYfZSSM/Eur35g2Pv23M8640v+hucDaJaOfZAiVhT3iyIc+QwHUoPhznUtQS852wMyx4d2FmodHsMr1CwxFboW8zmTfdVeaDTTQY1sFrfO0A7wYBEgSJj0/KT2mbFqDazr/n0CcsqpZ0uq47XN7HCzLbXFhGRnoJ42jhc8ukQvHeLoxrbVU0/3HFwmOeWM2bxEEauwaCaLVWUu6Es5Dj4Z2a83qR3QcLgJ/SvKo7+KLxBv/rT3meZaq6g6skB+CH/s490W5b1jWRiogM7D5pX+60p5YYwdUesVsUjmLhcbbGUjxkpQ+cqvSbWIsBnwCKtDSmYxGWHJ0ra2dGQT4fbG433HHxGY2/Ug/iYdi71KDhQATGLMzjCFNm3hebooXWQ74Aud8htI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(2616005)(336012)(82310400004)(70586007)(83380400001)(26005)(44832011)(16526019)(186003)(1076003)(36756003)(81166007)(110136005)(8676002)(4326008)(426003)(6666004)(5660300002)(86362001)(7696005)(356005)(508600001)(40460700001)(8936002)(70206006)(2906002)(6636002)(47076005)(36860700001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:44:55.4261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b088e827-ad96-4ee2-f785-08d9c00bc06b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2692
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
This interface will be used by Aldebaran in sriov mode
for indirect GC register access during full access.

v2: Added descriptions to scratch registers, and 
improved code readability.

Victor Skvortsov (5):
  drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
  drm/amdgpu: Modify indirect register access for gmc_v9_0 sriov
  drm/amdgpu: Modify indirect register access for amdkfd_gfx_v9 sriov
  drm/amdgpu: Initialize Aldebaran RLC function pointers
  drm/amdgpu: Modify indirect register access for gfx9 sriov

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  27 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 120 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  57 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |   5 +
 6 files changed, 157 insertions(+), 58 deletions(-)

-- 
2.25.1

