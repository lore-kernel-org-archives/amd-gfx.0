Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD3C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DC310E405;
	Mon, 27 Mar 2023 19:46:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E10610E405
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLxMPyOyZetXHzKAb8/6kZBgHt1S7tG6jXUYK/blI0T+3MbqJsaOxwuIW0kv7CPc8AOeLCiV8I2zeg2UBmmwGxHg0iQDr85BCL050BL7bkJFcZV64UfKuyLG6hMkPbBNZZ7INN2I1qaIH7fw/OQuavOXi3fhqpx/B39o67Id9vMwuWhvbbKZ17dzIwiCWVF3DtUM33nnWpms+zzywy9i+KAsxDW0w0WeDcvofXXzH+aRpVF3/PoAfomK/P8KIpVVxyaqKfPz3sdgI7sYTAZixmH1gx/BUKUmTtJMNJSeUFN/SEVsnF4eSipUYBpGMCEsQvth1s/h9vtCfhPglHRuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyN3P5tQGugmrSX1d7QqfLRSowXxxa7f1sYazDouFuk=;
 b=MLl9Mf9BrKsE2cJfAthGZ5X7LYl/gUkgCLATn4c56x95TdnLKG6vi1tZOXIiL9tYnGStvlxz4yfFfOLHlsZscCJluLiXW9qEXbkD4BbtiNutSYRucfLuDsNaKV/vpHeFce7GobzxySvT9+Ctz5ZQEUoTMZXWICOinx91/MG2WUIimuM1vuwgO8GcInJTsclYsEcPdx6slSYFUlA0yOTv+aGlSajw737Jt1eguKgMwI3Da3gZWiiLauFTlEWkJx4ApAMO1rZ0fDtkgG+BNAc/DGNep9K2LefWDlk309T+FMBOgvFg/c6pXoX8tp/gQPrdGdnlWXu72L0/zV0DcriPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyN3P5tQGugmrSX1d7QqfLRSowXxxa7f1sYazDouFuk=;
 b=KDYi6S7BihOwuLsKREDAsvz7v1O5UfAqhy8M/856EHlzNwfsZrnuFp1udHVvBu1U/4kjQucaUgE/hvCLBy6h9PuXbvVIHL7irQef0cSCdrEAovFs6aixa2036OwAXPEw/SDo8tAZrTmA5nwyTz9DoL7qn+usFgbCf+bn7pCugPw=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:46:36 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::ab) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] VCN 4.0.3 Support
Date: Mon, 27 Mar 2023 15:46:12 -0400
Message-ID: <20230327194622.8109-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 46343a43-fef6-4747-fcc2-08db2efbf978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypepBKeAOphtC6J66F9vpUOZH9pPaCLG7X+TKPR0SA5t0ccFah880dXfSpxC8BpyM4R3hyfXNxV07a0VlYMQGFrE2p3yLGXcTq3WzL4jHujmvwodQVcNqSH69sjvcB4kXwWy5nopeoMotdq46xcKNzGi4WBkxTnELmYi1txC8rV5nxrGVxnxO0YXmpZcT0FE6d8QYo0IacId4zmTuuU58TjpHxckuwwFcpX5L8mqlXUyaK8w+6uXGR0oEFCP00TU8/4iKg3xUSH2dT+kuieZxQ8p03Z8OQ/ZoTQw3+JOoAwszuKelQZT84P269TaFYWBFesPf8QAIBNKwqObqgh4aPwh811WoOCHRzW+qZNXDUOrHlsZ6AXpDS+qXuxba14noZydSLBKEZTldcUlbRBKVxQ6Hn/px3HmEwxuE5DgjSgG0/Ft/CCXCxjar9ZZTDQJthUACHl+GlySw7Sua1jXUveNBzn4Hb+viCqPnb2XoVqCJ56GP7EpocEplAA9cXgWJ0/a25OIQB2lFn8fE/D1TKM3th3OEnBGiHAB3Vl48Kb3f+oja3cPUpMUjoufWLeVNIEM6u1lN9wEB1vgZIBE7qoDJDWkitZzEBgVkeUDOTwuBBBWcKI421I8sv89k8aVZ4kKrIr8EqkBL8J1X3+2OdPKiWj+h/z2c9VRKZVYEe5GKOYlFIl9ZrdqijbrnwUKcAjInVCywTGWW1PZ56vWa/K6jDzjSOfmJBh6+UamPhI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(478600001)(316002)(81166007)(82310400005)(8936002)(5660300002)(86362001)(36756003)(2906002)(356005)(70206006)(70586007)(8676002)(40480700001)(6916009)(41300700001)(4326008)(336012)(16526019)(186003)(2616005)(426003)(1076003)(26005)(83380400001)(82740400003)(6666004)(7696005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:35.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46343a43-fef6-4747-fcc2-08db2efbf978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds support for VCN 4.0.3.  VCN is the media engine on AMD
GPUs.  Patch 1 add new register headers and is too big for the
mailing list.

Hawking Zhang (1):
  drm/amdgpu: add vcn v4_0_3 ip headers

James Zhu (10):
  drm/amdgpu: add VCN4_0_3 firmware
  drm/amdgpu/jpeg: add jpeg support for VCN4_0_3
  drm/amdgpu/vcn: add vcn support for VCN4_0_3
  drm/amdgpu/jpeg: enable jpeg cg for VCN4_0_3
  drm/amdgpu/jpeg: enable jpeg pg for VCN4_0_3
  drm/amdgpu/vcn: enable vcn cg for VCN4_0_3
  drm/amdgpu/vcn: enable vcn pg for VCN4_0_3
  drm/amdgpu/vcn: enable vcn DPG mode for VCN4_0_3
  drm/amdgpu/jpeg: add multiple jpeg rings support
  drm/amdgpu/jpeg: add multiple jpeg rings support for vcn4_0_3

 drivers/gpu/drm/amd/amdgpu/Makefile           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h      |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    17 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    12 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |    14 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |    18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |    14 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |    16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   840 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h      |    50 +
 drivers/gpu/drm/amd/amdgpu/soc15.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |    12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  1438 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h       |    29 +
 .../include/asic_reg/vcn/vcn_4_0_3_offset.h   |  2254 ++++
 .../include/asic_reg/vcn/vcn_4_0_3_sh_mask.h  | 10424 ++++++++++++++++
 18 files changed, 15120 insertions(+), 63 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_sh_mask.h

-- 
2.39.2

