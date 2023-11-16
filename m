Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA167C072A2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E20DC10E035;
	Thu, 16 Nov 2023 02:47:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F27A10E035
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE07KQ5zfWLnwcbHebfLfZG/GcGg3AuQeClwgXxteQ2SOqSLJtUgpsLvM64wco6gxvrqeXnK3w/8mfexKSXt9jNBYRjGOL7AMebrEspGRB/sSdmyDcoV1AVr8Ua9OQgdAbnbNqnDk7oogs+1GiIPFt2l+JV1PMohwAWaW02J9Q3i0P/FS8tv3+ZrppqIinoNG+h1QQyVBEn7VIg+aJpxVGA3DGmV8A4kqsebt/ggyGxUEuOcBASphx7IQoDxbW9vXHxpsLJhSn05cAjBS5jsWhxdCLGduJzaVy2qFuugVxDgN2bxQdRj5Cp98o0f4vlbRGKYdUUn9pa4VGMmlhjL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KD3r+92jNKlCL5EfSemLsg0/Xtd2AkpcStorkmXGXIk=;
 b=Rq1cOFf/z7eChkeu6K7AfKnH3svjC+pzq09++9NQrEoTRbEuBdhSpPXwkx2HyUmf4yHdv0ofHdttPZNuDTfZ3HsDNAB9MvrPsjuk0Y8YjK20UDbgtJHde66aWnSI8xSzIjBd+eSQ0aQr1usVo6TsAel2GZ9e3Z4dT11fxis9sFUComFJRjsVn3gUcRETOVefOad6g/DPyxcGyWqxpYhs/bnCDHofjbIsEDbwozsszU8KR6YgC1a419aZkXZZNCmwxp2zM5lIIq2fZqUHoxYVhg+cH8PDBTAyCScxLHGIjg4rLfeIMuoDS3L7hrtf+fq9DA23L/FKGOQvZSyBzdR5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD3r+92jNKlCL5EfSemLsg0/Xtd2AkpcStorkmXGXIk=;
 b=T1n2efNtP1OXV1Dh+QPdLE4XFhdl1+jSU+cQdRWNuXCu9+XjNwKif4CgWM/h53eNf4dvkMFelQX7Z/LWT6STsmFEnH4vs3hhKJOhPzWDOkbQ+s+yLGvnQjucfk+xzC1A4UDHxXDJmKQsly4uFlNl2IjCa9fo7+MQ5vw5CQ2H1oE=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Thu, 16 Nov
 2023 02:47:27 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:610:32:cafe::ae) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:26 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:23 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Enable LSDMA ring mode
Date: Thu, 16 Nov 2023 10:46:57 +0800
Message-ID: <20231116024703.2838690-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c110a0-5aa7-4fa5-3cc0-08dbe64e5e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuXDtyjS0vpRN8DMvBjc70sZBOm3Z8PGKV0QoXPqtIuQE7XK88lJB9sXtYYxjnLZ8QOECwoTWO1Ps/UYtnU0XIOGCZALnwkB0b6RHwJdKdLILZhpgwhDFdbcNlh9GkEytoSiS7UNCd+44uy3rKoRVERdtp6LlY3Zff1mEASYsXk/NVnmIzI4jSjiqSQdIIOJlqht+J15lgekv26ZPWgl8TYLu4wLtHmS6xvncVdjFbjDtP/dj5UaU3CZDojwdg31q+yPAWLF9qNHleUEO47cCTMf2/HVoVOw1zWiIVGTmjmiqUofBMA1B+MfNa8u7jB1N9c9Yj+GZSOlMJFFgVHHpfU2VVcmXOIbay8hP96hSxh8lnqnlxslEXEGLMRLOGbPWOBJFNun7/8BowFq1Ztdsl1Sc1tRVmfz2C6F6FaH0xIxUkygVHrBP9cJEAsWAstai9gmfI+CAXyGBPWsw42KZYOhMBceJ4nhpOLWrIMj0pQ+omf2aEnjvVyiZKYbfsWwyCzY/fCKXaNStvYeXvdqbf2buOQQXwCKA94xCCnPNIc+yt9ctna6ZTHB0vBC0efkl7724qRlgKkKbhEiRCVnQq/QH6nGNDEQkYvKZEF6ZUqg7afiSz6fHVApymV9a/lC/ZYGuv7NMVS+I2cpoNzSUACIb3WMUzIQB2vshvFuet04qtVB97zW6TPGyW3kLpNogDsPoEASonp8o5u8rCVd5UgjbxnAEf1GeNyUVKWoto+NpOzRaWRLYWCD71+lfvQIPqrqfRiiUncE1iCktN6t6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(2616005)(2906002)(5660300002)(7696005)(40460700003)(6666004)(86362001)(4326008)(8676002)(8936002)(70586007)(6916009)(70206006)(54906003)(316002)(36860700001)(41300700001)(47076005)(82740400003)(83380400001)(356005)(36756003)(40480700001)(16526019)(26005)(81166007)(426003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:26.3234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c110a0-5aa7-4fa5-3cc0-08dbe64e5e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series implements LSDMA ring mode, creates LSDMA ring and implement
amdgpu ring related functions. Introduce a new module parameter amdgpu_lsdma
to enable LSDMA, switch buffer and paging funcs from SDMA to LSDMA. It changes
amdgpu driver buffer operations to LSDMA, changes default page table update
to LSDMA. Since LSDMA is outside GFX domain, it can work without waking up
GFX which saves power in mutiple scenarios. With LSDMA dedicated ring create,
it also exposes interfaces for users to utilize LSDMA capabilies. This series
is tested on gfx 11.0.4.

Yifan Zhang (6):
  drm/amdgpu: add lsdma hw ip definition
  drm/amdgpu: add lsdma interrupt src id
  drm/amdgpu: update lsdma headers
  drm/amdgpu: add ring mode support for lsdma
  drm/amdgpu: skip LSDMA for mes self test.
  drm/amdgpu: Default disable LSDMA until proven stable.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c     |   40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h     |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |    1 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       | 1293 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.h       |    3 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    1 +
 .../asic_reg/lsdma/lsdma_6_0_0_offset.h       |   48 +
 .../asic_reg/lsdma/lsdma_6_0_0_sh_mask.h      |  452 ++++++
 .../include/ivsrcid/gfx/irqsrcs_gfx_11_0_0.h  |   20 +
 include/uapi/drm/amdgpu_drm.h                 |    3 +-
 17 files changed, 1940 insertions(+), 7 deletions(-)

-- 
2.37.3

