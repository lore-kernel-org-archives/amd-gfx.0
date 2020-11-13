Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C30C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301E82224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YVi/qp08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301E82224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21AC6E82C;
	Fri, 13 Nov 2020 20:57:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7ED6E82C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxeev9ytIbuwclW5/NQL/wrBs1BthFzqDoXplkPM71l/XSN1cVsLBiAmy9usDBuU17c1sSViRZhw0A6ybIkbeCtrtVwKf+1aDZEt4Gy5A+uogzvLNCZ6gZLyxIB4useFTDESYR7pkws6dvFJG6841YlkFoAG5C2QlWPdZ5WjdNlqyvdtx9WOg3G+zzAIRfemFX/yA4b6xJfwgr6Vn11WNPXA7h8f41xj9AA6TcIEjqPOVENlanfl76qtBkAuiEREzO07Cgkm1J/1A75LoDCYJVciXjfy98C+t5wsH6xocL5mUeQYFjJQNXRK7WAm7ZpJLwZRJwjyvpJzG2lEyE3h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HZ9+BWwxpclkupkVLMDBA0CohhKyNBrLgUnnbqCzGA=;
 b=Fmj60z7MQCn7VX5nKfYdFHyc1/Y1D6qKScIPuyZXoJNrVLvY0LBY/Jy1uRFz2A/rb6EqCAIgWkQLyUREciRgBRjokzlXYOps5tdTofCHDEL2YtaH5Ijj4/rvDHMZlrlBEtsKyOsVVPOKvLn8Y+qqBIYOBl/JZF5MyAXzl8GC49lDWkQkV7rR75whIlxpNU1dXSLEccfbO8gEHGMRXbwriSGZC5SHcV9bKy16AaIT0z/gyOVyb8JKM1mYvmhMB2q1yQj9r8riIR97z5+CmpvQpUjCrFS7cn7AtcJOZLeCivwXd19H9w6BFIh8eL9FLfH0B26fSFUb3JH92IHWOticAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HZ9+BWwxpclkupkVLMDBA0CohhKyNBrLgUnnbqCzGA=;
 b=YVi/qp08m51a3xmtFXEo53g6eUO1r8rykO3AruStOY2uzkQbMaBLAlDwqcrfUD2tNzgZDlB6nJ6VoPrj3kzNta75lLsztvlEiWhzrTaZm1GzeLf7S1QydGdqonIdQkwT5sO0IhFgHLGpguyB2i32XNOIez0xiGz1kQSr1b2kJ2o=
Received: from CO2PR04CA0100.namprd04.prod.outlook.com (2603:10b6:104:6::26)
 by CY4PR12MB1480.namprd12.prod.outlook.com (2603:10b6:910:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 20:57:36 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::ff) by CO2PR04CA0100.outlook.office365.com
 (2603:10b6:104:6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:33 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:32 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/17] DC Patches November 16, 2020
Date: Fri, 13 Nov 2020 15:56:28 -0500
Message-ID: <20201113205645.640981-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89975ba5-61d9-4f28-01d8-08d88816bed3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1480:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1480155E3BD1B6684F4A7508F5E60@CY4PR12MB1480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73UgqXMah3K6kt8iwyi1UT8Ds14ErbuFzStvB8GJ5CSKiITNsQNqQ/TNtIfTOCv3JnqbATFvK25aMJmOcdqVQg6J4wy73YP5oSMUhnUPpkKasOsrrVO1FnvGmdX6PETbIdytblOUyvYzs7T+KhiEPsjRzfKCRYGo9qovcplyZLP79jc4ATSlOxAJtSHGi5EjGLODca/uFuGpEvFA64LUPHHhFb2eGdt5Q9vBVTyEMZLwYp6t9wQZDLSN66PwinGDE7xpgbt2xHvuP0/Wji4bPNyKj6xFqv04YWBQ/ayYQQTq6Ts9J53UoCu4ViitmQdRv26gPnYAqLMiEf6ckR9QeIcSQwxXsSAQHVv468rISEAVRZa4X+/k33oRQk49MVTCK8TiS3WevgkKR7f4k2cJtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966005)(86362001)(8936002)(36756003)(2616005)(426003)(6666004)(54906003)(83380400001)(70206006)(478600001)(70586007)(4326008)(82310400003)(7696005)(82740400003)(47076004)(26005)(2906002)(356005)(186003)(336012)(5660300002)(316002)(8676002)(1076003)(6916009)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:34.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89975ba5-61d9-4f28-01d8-08d88816bed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1480
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This DC patchset brings improvements in multiple areas. In summary, we have:

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.42

Aric Cyr (1):
  drm/amd/display: 3.2.112

Dmytro Laktyushkin (1):
  drm/amd/display: remove unused dml variables

Jacky Liao (1):
  drm/amd/display: Add I2C memory low power support

Raymond Yang (1):
  drm/amd/display: correct data type

Roy Chan (1):
  drm/amd/display: Detect dynamic backlight support in eDP sink

Samson Tam (1):
  drm/amd/display: fix cursor calculation for 1xnY rotated display
    groups

Sung Lee (2):
  drm/amd/display: Populate hostvm parameter before DML calculation
  drm/amd/display: Handle Unknown Result for SMU Periodic Retraining on
    DCN2.1

Wayne Lin (1):
  drm/amd/display: Expose new CRC window property

Wenjing Liu (1):
  drm/amd/display: minor restructuring of pbn calculation functions

Wyatt Wood (2):
  drm/amd/display: Hook up PSR residency command to DSAT
  drm/amd/display: Increase sr enter/exit in rn ddr4 watermark table

Yongqiang Sun (4):
  drm/amd/display: Program dpp dto based on actual dpp clk
  drm/amd/display: set dpp dto as per requested clk for lower case.
  drm/amd/display: Add dual edp optimization flag.
  drm/amd/display: update vgh bounding box

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  19 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  43 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   3 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  53 ++++++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  30 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  12 ++
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |  16 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  15 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  64 +++++++-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |   2 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  60 ++++++--
 .../amd/display/dc/dml/display_mode_structs.h |   2 -
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   7 +-
 25 files changed, 448 insertions(+), 53 deletions(-)

-- 
2.25.1

Thanks,
Bindu R 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
