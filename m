Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B58C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6A010F00E;
	Mon,  2 May 2022 19:08:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08BB89077
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoSz6YR+RlSg6ojk8uYX/dBWabV6ogvtEHSLhJsg9pIxoeRCEPrPs/u7OqBE5vU8dEVwibxpQ1sqQcY1Alg0Nqu3k+J3sKHEvv9P5pDupMzkN7ECqbWkdtKQPv2CqNhM0jqwCu6lUJBrS4Rmamrz+eFQtP1YfaAMBqvv0o/GqnTwRd/DIBoXhoNHXZTS1P+Gjrsu77OyfkxrXXKHoABNFLgDoa9N+8G2/XUq7Ka3osqQ1ECQmlpM7udPmxl/Y5pfSXLrpNyIYLSjR2UVvQWoLDihlzRv4ZLRzjPLtwxKhGDEyNqDAkrzyk4KyNflsHJ+TEJAuyoPDjztBmKpf7Ntzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbq47xUgzvPAoumlW+pn00XINtlLf176YcDMSwNLYWo=;
 b=nWx55MWoBn0/x+KQH04wP6mIO7VtXwqw5MNvlAoIv9FffWKH6AEIuEnh/J9K/6+BO0JHK7dWJcBRnlKEFNbxhJzdc+RoDnRbzezotVE9fUUuR4v96oIL2iKQm1qdG1jICa2tvLOajqg8fRfTKStU4maTahuMYqZ8Z5+fXLc0MtsTfeYn3jyFYsBDeId8jGWze2LTbeDxc8SR8g0XJpmPFz3Bi/ftVBgu/PXDb+xlkZy/GXU+b/MQdAl0p5qk5FjmQMFfL9G3LyHeKCdeH5I9BnRlOwudMS1xtt39ewQpUkaJA1Fix3vCrQt9L7bHEWnDNw0glWeJAcvMMQIxtRqwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbq47xUgzvPAoumlW+pn00XINtlLf176YcDMSwNLYWo=;
 b=4yIdKPitn6VqpqZpm+r+nVU6ly/e9fVY7YIU/AmKljSIPoEj96LOeD0h8xWOmgM89OvfUcDuj98SqyYxKGRTt1iy4cRqZ3SwxLEh5KchHjl2usSNbyh0ovpieQXKrGJG3CViyLCTnWkmj6QNONRnqxvJ6CVqrDWf5WWrCukIKfo=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 19:08:17 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::fd) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] VCN 4.x support
Date: Mon, 2 May 2022 15:07:54 -0400
Message-ID: <20220502190804.784271-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6ff8e2e-d970-429b-1b3f-08da2c6f1d49
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54015E883B26F24F0B0D222FF7C19@PH0PR12MB5401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbtKJqeGE8CSQZ7a2GHGaic8Fi/IWyd1+sDmLqLpTeFRA4pEIsNGAiKUReH9yAe0BFf8KDwKtbREJJa0vVPX6HifAi0XnwqITVDjJSTysZgXG0tQ3ufCZ0BfORSJP4vHlEyhMFlYrUSVIYhEmkTYdEfo5PLHebYQZKw05Km0ENxDZ/lscpSywVt8VqasMiLEMu+U8V5IRIa442n7K28jVBEuih1g3ktXX4b23MbRHOVOEM+BeXaCD3OsH5/GEhmp2Jwa32u1+OOwDu8zOGAGYCyWjNy1DhdPjmOCyB6m028VlKtWwJiXGTkTEEbn0ZaGGIAQ3wwr2qWwMs1dXVlyKBGuSbIMifBK3PJA6aT5k4OaYz2pXQlSMDhUk6RB4xi5uwE1DMKkNbrALo8Th8EfFY4hVOs1O+msEWc4JDpU8mfqk1jgx0o81TQiqNpBGXA7/KEDfAsaNEL7aYynMrgF9zubDq8m/yyZLxzDG9wd99MsBU6M0UTbsuS65VztUClV3qvImSR0iuao5W4iY0qjfbK8Rr9PkmZCy5l/kM33Ohhm4o15gwdheelcgBjGyTq9o3RTqWEvKf7M2jo/2tSj4vPIRei5LiRs7S5ljO5OtXvh5ZLa71nFL9cyhmxhSZjUQ27SRddXZtQPaIysTTnr/PxDWRFT7eBtNxKzpHuXlUsthdEmFKfRtNtgRJOT9CjkGAk0cOr6G2kjpS70LMRHpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(70586007)(336012)(426003)(47076005)(40460700003)(70206006)(8676002)(4326008)(81166007)(6916009)(2616005)(36860700001)(16526019)(1076003)(316002)(186003)(2906002)(86362001)(26005)(6666004)(36756003)(356005)(5660300002)(7696005)(508600001)(8936002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:16.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ff8e2e-d970-429b-1b3f-08da2c6f1d49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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

This adds support for VCN (Video Codec Next) media blocks v 4.x.
The first patch is very large as it adds register headers and as
such is too large for the mailing list.

James Zhu (7):
  drm/amdgpu: move out asic specific definition from common header
  drm/amdgpu: add irq sources for vcn v4_0
  drm/amdgpu/jpeg: add jpeg support for VCN4_0_0
  drm/amdgpu/jpeg: enable JPEG PG and CG for VCN4_0_0
  drm/amdgpu/vcn: enable vcn4 dpg mode
  drm/amdgpu: add vcn_4_0_0 video codec query
  drm/amdgpu/discovery: add VCN 4.0 Support

Leo Liu (3):
  drm/amdgpu: add vcn 4_0_0 header files v7
  drm/amdgpu: make software ring functions reuseable for newer VCN
  drm/amdgpu: add VCN4 ip block support

Sonny Jiang (1):
  drm/amdgpu: enable VCN4 PG and CG for VCN4_0_0

 drivers/gpu/drm/amd/amdgpu/Makefile           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  609 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h        |   29 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   53 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |    3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |    3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   26 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h         |   12 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 1877 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h         |   29 +
 .../include/asic_reg/vcn/vcn_4_0_0_offset.h   | 1610 ++++
 .../include/asic_reg/vcn/vcn_4_0_0_sh_mask.h  | 8055 +++++++++++++++++
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |   41 +
 16 files changed, 12375 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h

-- 
2.35.1

