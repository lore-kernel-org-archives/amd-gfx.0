Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6952FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2592D10ED55;
	Mon, 13 Dec 2021 03:53:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D383910ECF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnLNadYJyeEBPlE/KgjaDuR70CR0+p53DaYSubjLMZsLKYSvqb1DGG/5a1UCrIVf7YYR5bGvuhYpjbIeyrOkzY/DGf4H8UuzCI95pbpWZr4MUfIQdj39Kif7XKUA+CMZj0EOne8z7D+kW3y80naGWJdar8btoBb7qG+tHLTjF3cUnpN0nWePJFsSiyDIx2FsjF83DPaaq2x+6td/iK1sKPxPTqdtg77lXBF3fERzUmAyaLJNjSPx2k0twK/KcEHSSWfp190+JtZO/UnSeIKcHPA4bNiuhJFcycGEV4eq4+i/+7oAXUpco7a8DuCvt2esds+S1iI0OhrmnWc+z1UbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWgcqhRwsFAKrk96fSChcuOCuvwGS/S1nAj48QMkEj8=;
 b=IcNBh6j9D71b6C54RHq1+x1jGATkZouYbwcsSrpxw3BSwe2KLFaNo3JqA8YIXkvRH/xJy0ZNi7/K1ivKkUSC9C6EWyTWIxnVoij9a0v5cYqVCVOlbp4qUlLQdlouEG2tj6Xr6Yl31nY8fPPjtk6/oZu8xjPnbF8EMm5XS0lZQym18/GFV6DIRpEpZp7tGVnEWVDslrLFUTSVLeUWD+cY35vQuQxPheJWXglOdqTDpghv7lw2LxQvyHiNwB2Sl9xK9d1c3P+iaBBIErwCqnGnSZ3qz9gX/3u7GQJ5Q4/QAzV804BrBJG5lpCJ3XIppCMZqxjaEInBM9Og14/30g+lRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWgcqhRwsFAKrk96fSChcuOCuvwGS/S1nAj48QMkEj8=;
 b=WlhYDbdQWBhOMUsWUrY3Ifbzm2H19N5MOB5T5P5/WMXCo08AVCmpA/8gif0HP9noeQf1qEeUTQU6CBtcvG0uku3b7ilLgh3li0b2R28+S/wiDU68Nk1XPv/ZsTxl5StaSCSyLF3wZlfmIIMXMvC9ipTcBHG1VdYtI7ZtB+Wt/3o=
Received: from DM6PR10CA0006.namprd10.prod.outlook.com (2603:10b6:5:60::19) by
 DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 03:53:04 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::ac) by DM6PR10CA0006.outlook.office365.com
 (2603:10b6:5:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 03:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:53:04 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:53:02 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 13/16] drm/amd/pm: relocate the power related headers
Date: Mon, 13 Dec 2021 11:52:20 +0800
Message-ID: <20211213035223.772700-14-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74fd5041-c399-42c3-556a-08d9bdec10d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4331:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB433150C7E142CC548D5AC5D9E4749@DM6PR12MB4331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NK0/VXAydhH+VfEVucQrtds1eLQ8xRdtLCGdcCFAo6JBBfZNfcg8h4XHipWmtvt+RzUypClHfVDyP+pEwTAAtqBA5GsyUBeChg9jatXmgZgzKMeofgyGGyfdzlmwBV004htDVrXE9JwC3L2Ewd/NI4bsB5PIfxWYlY+KwzHkcdGmRwwGENTMwYN2NXJkfXWJBv/7Q1f043HYEAeA4WMYgfEyBYTYaAfejmDHZyE/aa4L5Xlgfa0UyMsSohQEjZc5AcajqC6Dh+pOHc9X9ZO/KRJobLYl190RXc1RqzieGllNcAW/XSS/Pjh2sVNN3vxfXDnSjqNCX3JN4wZ256yRIwZCSKqaS/KtZUaCI7cqneNOxCdOixml5X18DX62qT3L0Ch5CoiGLsrWUyfAH01zXgc99tFEWVyCzfCTqurB/5+FToR6oNhA3eMhhV1J7MaPrKzZS+jpQ0lgmCAIaFy/bFqOjZQSkLsOyTYTizLtro8gM7rcGrxzgSYzoMCNPaCNJJUlu34M0bDnsnFWa64jWdj0+7NeGrTB/ashdZjuwGy7Zk/8lGZCuNiGpLJdxLM8rV8f+gGgIsMUIqiVypaFndRtgjRD9lv+whwNUFZ3Y1TcSE7nIVIA5g1dGLiqpBPTgi0RWeyecidTe4qsKPm4LQKVBsgZN8sdD8epxw20qZiiR9KCQg6rS5Sw/wQu+zCKHF1co+SjP9LRAcLBWI2SeUMJjhwPqbJxEP+lVFA5Atc+T6h71KDB5p7xqC0ss77nCJeo+pdHtSmk71E3n2/TQx6GYKodQzkxzVBCjQSWdus=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(30864003)(316002)(356005)(36756003)(8676002)(7696005)(70206006)(83380400001)(8936002)(2906002)(44832011)(81166007)(2616005)(6916009)(36860700001)(70586007)(26005)(186003)(1076003)(6666004)(336012)(5660300002)(40460700001)(4326008)(508600001)(47076005)(86362001)(426003)(16526019)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:53:04.1114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd5041-c399-42c3-556a-08d9bdec10d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of centralizing all headers in the same folder. Separate them into
different folders and place them among those source files those who really
need them.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
--
v1->v2:
  - create separate holders for driver_if and ppsmc headers(Lijo)
---
 drivers/gpu/drm/amd/pm/Makefile               | 12 ++++---
 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32 +++++++++++++++++++
 .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
 .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
 .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
 .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
 .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
 drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
 .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
 .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
 .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
 .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
 .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
 .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
 .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
 .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
 .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
 .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
 .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
 .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
 .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
 .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
 .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
 .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
 .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
 .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
 .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
 .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
 .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
 .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
 .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
 .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
 .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
 .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
 .../inc/vega12/smu9_driver_if.h               |  0
 .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
 .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
 .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
 .../inc/interface}/smu11_driver_if_arcturus.h |  0
 .../smu11_driver_if_cyan_skillfish.h          |  0
 .../inc/interface}/smu11_driver_if_navi10.h   |  0
 .../smu11_driver_if_sienna_cichlid.h          |  0
 .../inc/interface}/smu11_driver_if_vangogh.h  |  0
 .../inc/interface}/smu12_driver_if.h          |  0
 .../interface}/smu13_driver_if_aldebaran.h    |  0
 .../interface}/smu13_driver_if_yellow_carp.h  |  0
 .../inc/interface}/smu_v11_5_pmfw.h           |  0
 .../inc/interface}/smu_v11_8_pmfw.h           |  0
 .../inc/interface}/smu_v13_0_1_pmfw.h         |  0
 .../inc/message}/aldebaran_ppsmc.h            |  0
 .../inc/message}/arcturus_ppsmc.h             |  0
 .../inc/message}/smu_v11_0_7_ppsmc.h          |  0
 .../inc/message}/smu_v11_0_ppsmc.h            |  0
 .../inc/message}/smu_v11_5_ppsmc.h            |  0
 .../inc/message}/smu_v11_8_ppsmc.h            |  0
 .../inc/message}/smu_v12_0_ppsmc.h            |  0
 .../inc/message}/smu_v13_0_1_ppsmc.h          |  0
 .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
 .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
 .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
 87 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu12_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/aldebaran_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/arcturus_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{inc => swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)

diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
index d35ffde387f1..3d17ffb77f31 100644
--- a/drivers/gpu/drm/amd/pm/Makefile
+++ b/drivers/gpu/drm/amd/pm/Makefile
@@ -21,20 +21,24 @@
 #
 
 subdir-ccflags-y += \
-		-I$(FULL_AMD_PATH)/pm/inc/  \
 		-I$(FULL_AMD_PATH)/include/asic_reg  \
 		-I$(FULL_AMD_PATH)/include  \
+		-I$(FULL_AMD_PATH)/pm/inc/  \
 		-I$(FULL_AMD_PATH)/pm/swsmu \
+		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
+		-I$(FULL_AMD_PATH)/pm/swsmu/inc/interface \
+		-I$(FULL_AMD_PATH)/pm/swsmu/inc/message \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
-		-I$(FULL_AMD_PATH)/pm/powerplay \
+		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
 		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
-		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
+		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
+		-I$(FULL_AMD_PATH)/pm/legacy-dpm
 
 AMD_PM_PATH = ../pm
 
-PM_LIBS = swsmu powerplay
+PM_LIBS = swsmu powerplay legacy-dpm
 
 AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
new file mode 100644
index 000000000000..baa4265d1daa
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
@@ -0,0 +1,32 @@
+#
+# Copyright 2021 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+
+AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
+
+LEGACYDPM_MGR-y = legacy_dpm.o
+
+LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
+LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
+
+AMD_LEGACYDPM_POWER = $(addprefix $(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
+
+AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
index 614d8b6a58ad..795a3624cbbf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
+++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
@@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/
 
 include $(AMD_POWERPLAY)
 
-POWER_MGR-y = amd_powerplay.o legacy_dpm.o
-
-POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
-
-POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
+POWER_MGR-y = amd_powerplay.o
 
 AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/power_state.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu10.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu71.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu72.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu73.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu74.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu75.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu8.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu9.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturus.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_arcturus.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_skillfish.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_cyan_skillfish.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_navi10.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_cichlid.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_sienna_cichlid.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangogh.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu11_driver_if_vangogh.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu12_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebaran.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_aldebaran.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_carp.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu13_driver_if_yellow_carp.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_5_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v11_8_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/interface/smu_v13_0_1_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/aldebaran_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/arcturus_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_7_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_0_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_5_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v11_8_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v12_0_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/message/smu_v13_0_1_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a03bbd2a7aa0..1e6d76657bbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -33,7 +33,6 @@
 #include "smu11_driver_if_arcturus.h"
 #include "soc15_common.h"
 #include "atom.h"
-#include "power_state.h"
 #include "arcturus_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "arcturus_ppsmc.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 3c82f5455f88..cc502a35f9ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -33,7 +33,6 @@
 #include "smu13_driver_if_aldebaran.h"
 #include "soc15_common.h"
 #include "atom.h"
-#include "power_state.h"
 #include "aldebaran_ppt.h"
 #include "smu_v13_0_pptable.h"
 #include "aldebaran_ppsmc.h"
-- 
2.29.0

