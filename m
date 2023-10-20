Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119BCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 18:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A661B10E045;
	Fri, 20 Oct 2023 18:06:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46A710E045
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 18:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsNMdM5N/ElsUxmtew5TjW+t3IYzVDCKIfupljrXq3Y8Pu0uI//55plb9l1Cck5IY0AW5vCfk/A8fq01Sc0IxWhVr7gxqYgEzf80TXXeTRAKPT8lQ/PCzwtyBr3BQUzH/mdbjEyDfOkInUMeZTTiwlz6SgSopIbdJ26YC+9Ki1hUGgG12/H1EunQ4QR/00iEwnlGsbUvH4s5IIhi1Ng82inb63hGliBuC8G1tyyo0knQ1zfNECaibEGWJ1Kf0vXe/kyeErdIbQh0e+48UhogsMcP2CasJBYx18taSGpNvCWhi4GYOddjAGE/lsncUp4DIv8vivc7flvqSOyxzRX6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtuDTs1K4IRLJd0M8HsAR3aqP6LtVDEPLeKLE1DNhZQ=;
 b=LGpv331T4cJtPx4H9c4E4fYLqMzlp9PobYLxOhx0XC8MbrrfwuJpQJcBcDcPueStgnRREAi5DpVkMeu8aASCJp1RIf4ROy7XG80X/qijUxvK6T22umayx28ksfO9WgbNhbR4hGhYsIHXHnuijA4jNsbgWZbdCWFSUM/Oy4KmSDat3Mha53wCf3fZbDALfOYmKaOljI7AEDw1QUqs+kn8J6CmdHUlm206dzQisLw941NwB+Zhl2xmf38wq8/IrWykCMBbPOL5bYf7/7fqKj/twBp7sqXe2hRik3gXKRn8obYJg2DKgvjPpFuPsu+lQIbH3eaDU2Ph7/NAE1nwNbY+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtuDTs1K4IRLJd0M8HsAR3aqP6LtVDEPLeKLE1DNhZQ=;
 b=B+gziXOVsAmkqubcV+s8aAjthIh7szm9cmGM80Hu2N8r+bgzycUvvXuv7wkocdZ4w91mXbyVdxHc50CHHTYQbHT9Klvo+YqTDFhzV+zs9XpnYvZBrwAStSVaO8xNRN5mRlLIRraZasA69ebL6PuZrf9WxkANkeWqHh0iisXCmCc=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 18:06:16 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::38) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 18:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 18:06:14 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 13:06:11 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3]Reduce code delta with copyright notice
Date: Sat, 21 Oct 2023 02:06:21 +0800
Message-ID: <20231020180734.559121-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af69e95-cec8-4a28-3068-08dbd1974035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TKyE3P/jMLkoVP+JwZjYsO0hJQ2EZQOa2fuKCXTXMCYLU9VOZ3Cm2VtXW6/7QkFGiy8fvIqWdwZLIaWHz4Tzb9c63vKJZWNXQwQjBxhNrUX3FGQLbWDzU2BJCuJrMQBKVWNwMx42Vwyg4rPUzmJf+xm/RF9vkOyJnV1NQMT651whHs5cz4oU30FkCwT/cJVBoeaRilGi4/MUvlfZsLrhlQMwV1je6IKVmvijGOJn0PS/7KBgGrjwD+1/BX137bkjhXOfnL2DEeos7/kblY5oUPuRSBOSjFUfNMfQYKlH2sRoltcOZJWw1KIfqFAc8o/kdIe1No3llAQs47VlM84Y9CllVHkrhjrqftDuQl2rACCrBR5Oq2J2tpeSiO5tjdVXkkfGmWbkNU4d+fPAM2UqDqMIzsuBC4PH9ALOzkMAgPlD1RIRtWj9bug9MeKzsXyiMMipwA4DsIdTNCIi9q7k53L0xatgdzZVHR+SWECZ8jRZZGbp5p7H8aA4cTfls/m10JYuQ3+F0m+zRmoJnmLDM+A217U8z5orizguKUiEZ/2s9CCJjJPdSKPXuwMmgwb1K595L+WzLAz0XpJ5DynPavE526vAHKwi7Y6UtlcbExv4ix1BhQhTrYYFv32ZxnCo89LCM3prNO2Gpuw76l9lQIN3kwqfAYDYjMcgcmQkvCeAfEMZOvwwVyf9txjEZKDEtojHR3uy2ZpRmHYO0Fmy0ZiyLp1UBFm18DGYyUF+wxd/FnPbpOrmqs0naG4eGaevNOwLVO1LniIJG0dTAvBYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6916009)(63370400001)(63350400001)(6666004)(426003)(336012)(16526019)(7696005)(47076005)(478600001)(36860700001)(70586007)(70206006)(316002)(26005)(83380400001)(36756003)(1076003)(2616005)(54906003)(41300700001)(44832011)(5660300002)(82740400003)(356005)(81166007)(40460700003)(15650500001)(8676002)(8936002)(4326008)(2906002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:06:14.9770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af69e95-cec8-4a28-3068-08dbd1974035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Many of the DC files have either incomplete or incorrect copyright
notice. This patchset aims to address this and also make lives
less difficult for those doing backport/upstream activities.

Stylon Wang (3):
  drm/amd/display: Add missing copyright notice in DMUB
  drm/amd/display: Fix copyright notice in DML2 code
  drm/amd/display: Fix copyright notice in DC code

 .../drm/amd/display/dc/dcn303/dcn303_dccg.h   | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn303/dcn303_init.c   | 18 ++++++++++++++++++
 .../drm/amd/display/dc/dcn303/dcn303_init.h   | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   | 18 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.h   | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.h |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.c |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.h |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.c  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.h  |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |  2 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 ++
 .../drm/amd/display/dc/dcn35/dcn35_resource.h |  2 ++
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |  4 +++-
 .../gpu/drm/amd/display/dc/dml2/cmntypes.h    |  2 ++
 .../amd/display/dc/dml2/display_mode_core.c   |  2 ++
 .../dc/dml2/display_mode_core_structs.h       |  2 ++
 .../dc/dml2/display_mode_lib_defines.h        |  2 ++
 .../amd/display/dc/dml2/display_mode_util.c   |  2 ++
 .../amd/display/dc/dml2/display_mode_util.h   |  2 ++
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  2 ++
 .../display/dc/dml2/dml2_dc_resource_mgmt.h   |  2 ++
 .../drm/amd/display/dc/dml2/dml2_dc_types.h   |  2 ++
 .../amd/display/dc/dml2/dml2_internal_types.h |  2 ++
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |  2 ++
 .../amd/display/dc/dml2/dml2_mall_phantom.h   |  2 ++
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |  2 ++
 .../display/dc/dml2/dml2_translation_helper.c |  2 ++
 .../display/dc/dml2/dml2_translation_helper.h |  2 ++
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  2 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 ++
 .../gpu/drm/amd/display/dc/dml2/dml_assert.h  |  2 ++
 .../drm/amd/display/dc/dml2/dml_depedencies.h |  2 ++
 .../gpu/drm/amd/display/dc/dml2/dml_logging.h |  2 ++
 drivers/gpu/drm/amd/display/dc/hdcp/Makefile  |  2 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c | 19 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h | 19 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 ++
 .../dc/irq/dcn201/irq_service_dcn201.c        |  2 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        | 19 +++++++++++++++++++
 .../dc/irq/dcn303/irq_service_dcn303.h        | 19 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn303.c    | 19 +++++++++++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn303.h    | 19 +++++++++++++++++++
 59 files changed, 298 insertions(+), 4 deletions(-)

-- 
2.42.0

