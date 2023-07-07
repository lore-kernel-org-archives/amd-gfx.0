Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4C2EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47DF10E5C5;
	Fri,  7 Jul 2023 17:47:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D6010E5C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu2ge6LngDFgg4UasF+pmufn7Eb9HxjQX0KxIVGArYGWpB1eM7dgMwj2w3C8vwIfZ2YcsHGVb/RAbHT3HEf+OFaexVdbvVFL7ESK+KpiPNQSIPUCUsm0LjpMnCXpZH/sbYCX5MUO317QGAgo+aq+xEw9alw7Q71g+UQa4k3HQaBP4hCuwiJepsEhTecnB0zoBNRbnZSOS+O3RjS7eXxEk14zCoB3+FdGZ9+QEFhbgS4QZrfPXFpQAIG5dUj3flathlN35+qnVvsLL3meWeCHVxptUIwlU5G2/ITjCjMGb8tpag5XrqDZ5ndYz/PVPuvO0ZlTpOIVU1LlKSqCphngyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuZufPseuHJjeZJqXGdumy1KE/sTdyXW4NCO67/vyrQ=;
 b=hA6elolL6a6FzXmKLfbT/g6KoQze7LyP3vWzXFiK5+nFSB5hsKMJUlICA5W14giwbbEMozpQ1z2dn1S5xLM+9IOC7NkcPTVqT/24+I9R2l0rmoTFTEyMMezEyOo0sh8VHiYyACqgGzS+UAuFaXAquuUGl4XsjkBrk1cH5EPs1eJycTBsv26DtB/i4bccQaD6CjTGFgtKlpqoP+b3BvuFQwiKpb4BwbG6DdhNX1QRnmYuo/Ep85rYZu7OD9jasALFVzRSrNc6Cw9nsB9gX9AwOMzV+d/KHRpiPz3EBi5pp5Gm844OCpqNuMb3maH4mzzo+3tVY0xfnV3T1nI78BCcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuZufPseuHJjeZJqXGdumy1KE/sTdyXW4NCO67/vyrQ=;
 b=qoLZbsec2gTqVv+tnW/jqm0ivD42U8TaUb6MMw3GN1d3tYPSnBwxVrut5l7mE/v+gZN/zMu3PCsp63C20Y2cQeyBPYQyJcHSOYIcRqKspX5VXPjybIm5OBqM/X/tW0ClWDWe4WLi+DO1e7bHB5dJM7+HLz0Q61yrSAJcdgtoXvk=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 17:47:05 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::90) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 17:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 17:47:04 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 12:47:03 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Upstream debugger feature for GFX v9.4.3 
Date: Fri, 7 Jul 2023 13:46:44 -0400
Message-ID: <20230707174648.146441-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8ebcaa-a415-49f3-9ab5-08db7f122d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PxUAJCA4bEaFAj72pmSNCGeHor+sYeIRTkp6QrXA5OtHPS1ni8DUvgjXUmarZdDGAnZQDcKvP1Lg7HCOFhLBWQmH7os12uV+KgtRbONyErA+jZT6Sem1seLtlknyNJITy7OyfrJS80A7Uy1hp+p3qDfRAqPn54lCoWsmQNjZLsBiILO8z0bGUEEkSMln9W+FpXeKgN9cd9F4SaOic2UeLatBcC7YyPkQSNnK/JrzKfjpTUkAbaP9X6D1aliIm7lnlgbLN16xzqkMsGvyJ5tf1q3haevTYcY64L/C/otk4kn4/FtaEHgNp4jv1Rh2JszVRuwIpkcV/tIglQuV9VtHnC8L+dOqduJjR8aGCa4ZLmYS5xQAZ/QWf7S2F5QllZiy37TeeRTzR238958wVNONHP5LjixY+iXJUnjGSaUy/3NuHBvhqSOKu5DeYND/7EfFrcdYD9ZvaDsY9wgDp0Ah1tAnPlGDDWeWQhh5dtUh89xWmF8op39YBvJYmd+lwXBxgN+k/00o2Xo3ELxF2gTulTEZ5hkK1jMhge6XS249wrwkUHeutpUPd64JytDRi29WDxadBKU6oNP5Hq3Hj0lCLLXuQd/yTBPVeI4upEtwjPzS7OU90nzOtQH8DMBLiEVvNQb07a1F2KxgcKxT4QvoHFNenxv+EmqH7DfaeGE8CIC135HtR91E7BIZF4XcQ6c6Y39GIN4BxrbQ5VLh7OGnTmrcZCLWyMQcdbkOi0+u1YxyfKH3lQoGgIqUr2HuJ2F71HdPGDmTl3cJgg0wXAB3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(40460700003)(478600001)(81166007)(54906003)(356005)(82740400003)(5660300002)(8936002)(8676002)(36756003)(2906002)(82310400005)(40480700001)(70206006)(70586007)(4326008)(6916009)(316002)(41300700001)(1076003)(26005)(36860700001)(86362001)(426003)(47076005)(16526019)(83380400001)(186003)(336012)(4743002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:47:04.6670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8ebcaa-a415-49f3-9ab5-08db7f122d3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Jonathan Kim (4):
  drm/amdkfd: add kfd2kgd debugger callbacks for GC v9.4.3
  drm/amdkfd: restore debugger additional info for gfx v9_4_3
  drm/amdkfd: enable watch points globally for gfx943
  drm/amdkfd: add multi-process debugging support for GC v9.4.3

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   8 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  27 +++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 166 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   3 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   3 +-
 13 files changed, 231 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

-- 
2.34.1

