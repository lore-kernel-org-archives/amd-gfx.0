Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BDAC47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 11:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A45910E3F3;
	Thu,  4 Jan 2024 11:49:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E8A10E3F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 11:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSD7yXsMEJ76iA+MVKkc3nBuIseZYQU1Pz3tFzv9i8LisEDltVkjLc/UctKQBxDwiloAGJkIPu821EsiS17MF6RXLsAhITpoQA7ZNOweFKbLS92hmy7EoO1xu/x+IgMrGqx7mowA0h1e4y+WJ56w6ZW0tj+yvzKiWpfUSWdHRBRd3YxrCgt+DEZPZoCxEp6t2Pji4aZP3UQD67PeKgdE83+dzku/bpTu7D1W4Yo653I6fpScau/XjNXCGGDKPF1t6vMjJDgksckEa05kf/jlvL3YsY15amRkpYqccIl1iUKAFYbWitL9nXCP5gjcYWwlrbDxoJuWyOJ/SLGVkPVrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybEHvKtnc4lpSnsGhoBQukC+BDJiU1dfhRmL5qFZSoQ=;
 b=gY4OCEZi6WE5UknwewU1sYbguqDZHdqgGMF8A8hENPkO0B0EVj41LBAocEmPhDp0ikTOR37/0wte0G0M2ag0nfQP4CZ7qTDJKTKuWOmW+BvdwcRdtUlp4T90z9VrsIERWqY5BqhKcmEJAA0jDfN0pc0ipAAbBrzBE9sCjWXi+542Cx0bamtO7HG3P0vb3eBpiZ763sy59+1B24+qp9tJzqCrJZ7LTKgIsjWkRlvoL5xxg9rzGJSJaIb6+3mPHtgYhm1QdUbteJN/sgfdjCODLGB6HogF2h2Ju071aGFxRzWXfaSnAU4U1bE2+yQgY5oQSdd/bhrz868ZZ/s2YxwNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybEHvKtnc4lpSnsGhoBQukC+BDJiU1dfhRmL5qFZSoQ=;
 b=eD8Xk2u9fwEsqe3b4xBVsilwQAL9gbI1NdLPwHoRHAQC9rvDpDe4a1TU7GQPoT3m+DWrHjBnshYwYjayz9mPxJ+QDz//tAu3jLBXPI7D5FmVEZUEBJEl6IkOWpzc6Vrng2LxAAbcOcR5RywG0iCZT9+cN3bcZV2OdBGhdOm/w/A=
Received: from SJ0PR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:332::8)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 11:49:21 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a5) by SJ0PR05CA0063.outlook.office365.com
 (2603:10b6:a03:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 11:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 11:49:20 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 05:49:18 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/12] implement new ras ACA driver
Date: Thu, 4 Jan 2024 19:48:46 +0800
Message-ID: <20240104114858.3475783-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: bebc54b8-d206-4c91-cc24-08dc0d1b3067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j8wwz3puAAdE5oW+3QUe61YBTmnhgOpRXGQoSrwYHb4nUyDgfdr2QI9R9pV9NPtI1w6L54SRliwLdFevVKbFb/i1dVazrh8HqcEcy7JWrJYog69GQe9LLyuiizTqCClj4oQknjOv/AYRWZuVILufiikBC7OC1QODwKPjMd4is4YYlG8Oz4LDiZtMsADKBdarRytDZLSWUaPwy1kTqpkU5RMXH22irCF4m3bTXcGskCkegEhFrQBoVyQ0TehjMeRbAipTqyCqFlSfmJ19AQ8gagfdt0lSxBbc05M5c4BKeWdBQCFCguZp36vYPujZPGoh6YKvhBeS3jlXpYxXZVGWjU2b2kmxPVsWlu0TwJU8yhBCeDbDArT3UtzAtaKrLmeXVqCd4V8zPgywjy3lcUDGIjNgd3vGA+oCqPXH/ZLjhU3EGhJUoGL9HsPy/rEeNfn8tjqfJnAv3SiNU8f+5gIKZ2FcT11l3vVXCsEx6gouP1CGcqyGDfdjXch4zR7IjJLaUrMRE1JtaQOeZ6oepJ2GfqbdofylUrgonHuDLrJASN82Fs2z+4PPvwZQ+RDgrVaXHRIQkqzxKoNc9EA2ha6P17QY6JIyc6Ie7yMSp5uwDM2t4B/OeXscwyxJVfs62kM87HO2H9NfWwMVuyhae4h04jpklFAu489hL696Whf9DqwF1eY8vrAmnC6L0/0r7uuFMnFPLlx9jnRUQiZ5H2CUuHEmBgwswxFF0GITtz3BAaDtV7+wVjAFPPzUfo/pQsLZNnS2+ELUE/KRMpZgxuAEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(8936002)(8676002)(6916009)(316002)(54906003)(70206006)(478600001)(4326008)(6666004)(7696005)(70586007)(41300700001)(5660300002)(2906002)(86362001)(83380400001)(336012)(16526019)(426003)(81166007)(356005)(40480700001)(36756003)(36860700001)(40460700003)(26005)(1076003)(82740400003)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 11:49:20.5748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bebc54b8-d206-4c91-cc24-08dc0d1b3067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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
Cc: yipeng.chai@amd.com, tao.zhou1@amd.com, Yang
 Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
- implement ACA driver

v2:
- Keep the old MCA driver code
- add a helper function to determine different code path between ACA and
  MCA

Yang Wang (12):
  drm/amdgpu: implement RAS ACA driver framework
  drm/amdgpu: add ACA kernel hardware error log support
  drm/amdgpu: add ACA bank dump debugfs support
  drm/amd/pm: add aca smu backend support for smu v13.0.6
  drm/amdgpu: add aca sysfs support
  drm/amdgpu: add amdgpu ras aca query interface
  drm/amdgpu: add umc v12.0 ACA support
  drm/amdgpu: add gfx v9.4.3 ACA support
  drm/amdgpu: add sdma v4.4.2 ACA support
  drm/amdgpu: add mmhub v1.8 ACA support
  drm/amdgpu: add xgmi v6.4.0 ACA support
  drm/amdgpu: replace MCA macro with ACA for XGMI

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       | 851 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h       | 202 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 130 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  83 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  89 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |  88 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  82 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        |  60 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 139 +++
 13 files changed, 1724 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h

-- 
2.34.1

