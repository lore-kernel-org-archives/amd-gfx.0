Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7383A611C0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7383A611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93116F608;
	Wed,  6 Oct 2021 05:07:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E2F6F606
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 05:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehDodfWV3ZKwCATvFyS/wot9Hg54twd8Q7e/Ua5EW2e7x3+05XoT/TuLeu7k6FI5ihmbijGFR9J8qD7YGMb+K54ayNB7FRRmO3o09EROcNiLduXKGM3NZ/vRlBUIDNkMLWPspAdyJI9vJLKJb9kQZxKMFjBPJ1j5Ggg2YoeB1YGnG8xaf2YVJG0SSAYeXYY1NpM1SZIIkK2j2Vva6e22UsU+2Ptb/b6eY/10SS3YRYHMUJsKYZeTQsJ9lZvpCtIoqTM99nKOa4la7CKOCQjMbMKPaGN7bkGA0f932XOrNu6ok4Yjt+2IU3zaZ1yd7obAiSfyOabI344923QN99mAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/rezGuRreZg2e0Pd4VIhbAaBAJeESQMgbMAc45vegw=;
 b=Oj2R71umOspSAw07d4O+0v9B8vCUY+2GaYbuFRmyd6ZXuGUy1F1g1+6C42kJNbvxZ7r+BQ90EaCJNKfh2Srio91Y7LJEExBnBH4lp4uDcIAbLaolQMTBdUkYOzvXmke/EssrtLFThIp2lU7yGoPUL2ZWgf8UxByqvRhQxCKPblgew/8KPu//cb17QKHKZtR/bQxKJUMzs7OoRF6ZgqS0ZGqaWVcsO3VQEDhHO9i+lxX1aCX5Sb7HrMjFVVbR0QOuC1BFBK1ydKsAJplBEHEPK8f5ZjA65AWXBUFCcEYaeFu3fN41BphbChPlwhFDHVc4hv01ngWDrp01xDdSKNl5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/rezGuRreZg2e0Pd4VIhbAaBAJeESQMgbMAc45vegw=;
 b=BCYCvdUfS6SNQw2PK7AWVC6uL802bd8RVWxzXpdOYM5TXgM7q202KYhD3QpJ8t7k5yq80aZihWRUZCShVVwm0MOLYRXDlxLGgHQ3ZfRU4bC2occEp0XOyOpOme/QbXPL5on0875HPhtQkJCyvaklD458hT1Oqhk+PWO9hVDlRUY=
Received: from DM5PR07CA0150.namprd07.prod.outlook.com (2603:10b6:3:ee::16) by
 DM6PR12MB3498.namprd12.prod.outlook.com (2603:10b6:5:11a::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Wed, 6 Oct 2021 05:07:15 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::69) by DM5PR07CA0150.outlook.office365.com
 (2603:10b6:3:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 05:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 05:07:14 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 00:07:13 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 0/2] v2 Add limit_type to (pptable_funcs)->set_power_limit
 signature
Date: Wed, 6 Oct 2021 01:06:53 -0400
Message-ID: <20211006050655.6220-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfff9cf-db7d-4c54-959c-08d98887293c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3498B9FFB45BC3284574C245F0B09@DM6PR12MB3498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsFyxTvyOS8+UQBum92eMQ/kH5IqU2fI1V2TJ7s+kE/14oiwnQHip8yPbaELID/DMF3m8EKGLiTgXn9RA0g2bbvgW27pNJo2JQWuNVEAFuB0gcWi4Ed+3wKVuH5yWlYSbQXK9SffNqfoxp9UPxvnmiTO4eRxaaRRVqxK558LcFGCLBj0nEim6xbWrBUWOnEpop0wvNjTE8y+Y88p2DFBq13ipwJDppBK7FVZr0WpzL6eSfgDQXQlqcbM3haYjx7iCHAv+b+Ud9nMvkLxUh7A4317/p9EWJJ7mERwSuFrPKf42A6x+etnoaHicp70km8x6VCRwCeIpCjV8EDNvBMtRdks9BbsgZhpvsLti78t3QcXjM3vuKdgLXDXfpTW+RWuO9bPU5zNMZNhpe3c6CKncwcc7VcfvN57yOffPLGaWeGj+NCqR9AZjWm8qZ1X8x9q6KRSDQEhjA3BeDdD8lFEN0iOKTOjsNr2ZlpxCrNxbxjSCDBwHyG/LAoyySfJKnic9kkDI7lSZX3wvee4OVoH96YSTiH97OzDJSxxW5UI0B9m6eS3MsGUzRjsqG1Fu9SAkOjo3GIFiVHBWuEWothqbRTH8fsOzBTlPP+/NRyKdeBuNyFur5g2zyq17EurO2fh0pZU922t2FuVV817HWJIXLwnhqUrsDSc/DlFkcG78rGYRDLhhDBhxDQrdSNMfZTm2Af2OFpI4pTbivtzTYl1kSFDwnfAge7zkIg12+lk9GU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(81166007)(4326008)(316002)(26005)(36756003)(2906002)(356005)(2616005)(86362001)(1076003)(508600001)(16526019)(186003)(336012)(44832011)(5660300002)(7696005)(426003)(6916009)(70586007)(82310400003)(47076005)(8936002)(8676002)(70206006)(83380400001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 05:07:14.2695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adfff9cf-db7d-4c54-959c-08d98887293c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3498
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

=== Description ===
Add limit_type to (pptable_funcs)->set_power_limit signature

plus small patch
 Fix for incorrect power limit readback in smu11 if POWER_SOURCE_DC

 v2
 add check for SMU_DEFAULT_PPT_LIMIT
 dropped patch: Explicit initialization of cached power limits in smu struct


=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.3 LTS)
 + Kernel(5.13.0-g9e50250d2084-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ d6119c68a46e
    + 20e15ca8448f amdgpu/pm: (v2) add limit_type to (pptable_funcs)->set_power_limit signature
    + 45fb82fd6129 drm/amd/pm: Fix incorrect power limit readback in smu11 if POWER_SOURCE_DC


Darren Powell (2):
  amdgpu/pm: (v2) add limit_type to (pptable_funcs)->set_power_limit
    signature
  drm/amd/pm: Fix incorrect power limit readback in smu11 if
    POWER_SOURCE_DC

 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h        |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h         |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h         |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 18 ++++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 11 ++++++++---
 8 files changed, 40 insertions(+), 19 deletions(-)


base-commit: d6119c68a46eae0b48c77353aa81e6e38b009d24
-- 
2.33.0

