Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F3C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FFA10ED61;
	Fri,  8 Jul 2022 22:09:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470F710ED6C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVr3y5i76OB5q1THjFE6uKwUm1Y3kJfZ0I8XpCqSAs5a80sMRvLYZt92G4Bgjrtf547FgLnP4r+BEBGKIKGclZDMoATDKiCKjIhxUSGiiYx82CdLPYqVDr97Duy79vNw8sle7wh5ySC5uQXn+oBq5hz1usJNmNS7Q8ljpY6Kc3ewgjlMtIXfW6X3EQgfOKL6HRBh2bHrswAkDvAvu6PBXNMQSymNGuJbzyUoe0MmUwsClYjKqflbRkkVlppI2GT4gpLDOmGHpMc+LaLTtUX/LPxtOhdlgQZuf9SNRDliKalVRAd8KjyZsHdJjphv9/E0mQ4/gLiDyTXAYHMdhK3VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXqGnXtALPfIYEowz3roCwi8v9lGaKlGIFtw9D/+qzM=;
 b=hH1fDrPUQ8RjR6Emz1duCInyBn4baNhwlQYCRcpqQD3TMRuDnjmWaiQra/n/8QlfUrc+kpq0m/ZtSCiUw455BmrYaV8CubL5+d7OGLAoPnXcCWokNKt5kUzv9frbeSv6Nwd0KlAdz1A9lEuKVwCwUt+CgeeRyldf9HL2L/9bltRMIZsYf4oPZQTZlgUUYTvrAtVPZnjGx5uyjtM7rXurHUDNmk0z+ZffYoExUHmWVdXl3qjgztSJYARmrzFNxoCyyMrNmvlRmUVtpycibfJZ/ELZ8QZ0iPBZz+VJARJJfG8yvzA2IdOs0X/3wh5yKuhY6m7TwJDtW8VPrSaJX5QFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXqGnXtALPfIYEowz3roCwi8v9lGaKlGIFtw9D/+qzM=;
 b=vlALGUaiDQeubky4N9Z3QkBXaZWayIIN6Gi2/01UmOLi7tqEHbYvTmyDSlpN5oTlWDCyuXpe/V3XZNHUs/DFCaJuUvZKJLAdGUlLRYxCZcmoN3x6ss7doQf/Sb614fFd4u5OtK4OkurovLna8vbB8nNsjc3bPrxjiZDdWHwI+S4=
Received: from DM6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:5:80::27) by
 CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 22:09:09 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a1) by DM6PR08CA0014.outlook.office365.com
 (2603:10b6:5:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] Add DCN 3.1.4 Support
Date: Fri, 8 Jul 2022 18:08:47 -0400
Message-ID: <20220708220855.1475213-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cadef85-b852-4e94-9d03-08da612e7b37
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5blyoEWqYezREQOLhT66Ai939b8cuVrbMb6y7JOb6mw3UMdr2EH24TMB/N4fw8AIMEdpSzOrAZX7KhsW45fQu+I88GnFwBuD9K6CO1b7m/NkGnRMSYCpOWYKgdQUGz/UgitE3GuiD2WwPwF3ihWzvuoPjlp8bjvyCcNH58aZmpjqAspjoqYBtPwaZdvkb4ijFctqLjtxN5X8UwlfcZnczke90wmas5Z00U3XQryw/Ydo/nmLfWjSD7aMOImHZIr/jMWvGMyt281/r9o+NhVtEaov4hYqiKVsCbWHsch7ADg7zO728jkHTzlwQrMOXpuVutIyuYMyp0mHsXIgs51RulxgKLy9Qung+TIlp2x4OAAEELBHQWBHpOAAYKzcvnmWamwlJx0mZP5UHqZoKzD1mdtKngmlZG3eAMPuI4pk3u20xrxUxSnbqA0oIYB7usCvvAQK6lRhCs4nmrOS3/zVk8JWVozsA6seWCPF4xyQTQ6Msb4ph9kjOyedcksSTlZdRb6lJSiiZ54jlN+xyy0M7oZD3pCEWFOgJq+v3rpdlgXS/zTmW1Tkb8bkCsZBk5j7ryUAWQUoTz6FEh+lbolS1NMeAjyy05Se8Oy38P472xNUo2fcLcV7I99hkM4s3xECYFBA6dGcC/JXuKpgeF1F4QOTV898WLRzrmExOXM3ajNZxr60S0FP+fTfHccbSHFiTz//Az2lpo9PI57SBI+k8EskZ+9V0ZEZjf30enS0HR4xEtviuPT5+DKReAxg191rDSLv/ho2zOZ5Ruw7x1Lyk0wzsDQAc7JCujPJaSqf5LdypE4ysl+JbIiQ2IaGJQjqCIepcHqn4Tpcacjm0cUrVA5lfy4eshDr+28J48MVLXGkEzhUhcvlTU2ruyB4lZHX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(8936002)(2906002)(5660300002)(81166007)(82310400005)(82740400003)(36756003)(70586007)(478600001)(186003)(356005)(8676002)(40480700001)(70206006)(4326008)(86362001)(40460700003)(36860700001)(6666004)(336012)(16526019)(41300700001)(83380400001)(2616005)(316002)(7696005)(6916009)(34020700004)(1076003)(426003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:08.8884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cadef85-b852-4e94-9d03-08da612e7b37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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

This patch set adds support for DCN 3.1.4, a display block
on AMD GPUs.  Patch 1 adds new DCN registers and is too
big for the mailing list.

Roman Li (9):
  drm/amdgpu: Add reg headers for DCN314
  drm/amd/display: Add DCN314 IRQ services
  drm/amd/display: Add DCN314 clock manager
  drm/amd/display: Add DCN314 DC resources
  drm/amd/display: Add DCN314 DML calculation support
  drm/amd/display: Add DCN314 version identifiers
  drm/amd/display: Enable DCN314 in DC
  drm/amd/display: Add DMUB support for DCN314
  drm/amd/display: Enable DCN314 in DM

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    11 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |     1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |     1 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    22 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   751 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |    57 +
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    |   391 +
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |    79 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |     4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |     1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     8 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |    17 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  |   219 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |    16 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |    35 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |    28 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |     3 +
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |    43 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   265 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |   158 +
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   448 +
 .../dc/dcn314/dcn314_dio_stream_encoder.h     |   311 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   341 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |    40 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   158 +
 .../drm/amd/display/dc/dcn314/dcn314_init.h   |    34 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |   240 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.h   |   255 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2357 +
 .../amd/display/dc/dcn314/dcn314_resource.h   |    43 +
 .../dc/dml/dcn314/display_mode_vba_314.c      |  7420 ++
 .../dc/dml/dcn314/display_mode_vba_314.h      |    44 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  1733 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.h   |    70 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |    10 +
 .../dc/irq/dcn314/irq_service_dcn314.c        |   434 +
 .../dc/irq/dcn314/irq_service_dcn314.h        |    35 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     1 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     1 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     1 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../include/asic_reg/dcn/dcn_3_1_4_offset.h   | 15245 ++++
 .../include/asic_reg/dcn/dcn_3_1_4_sh_mask.h  | 61832 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_3_1_4_offset.h |  7215 ++
 .../asic_reg/dpcs/dpcs_3_1_4_sh_mask.h        | 55194 ++++++++++++++
 50 files changed, 155575 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_4_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_4_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_1_4_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_1_4_sh_mask.h

-- 
2.35.3

