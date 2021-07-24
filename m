Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4A7C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 03:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325CE60E8F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 03:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 325CE60E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B7E6EE45;
	Sat, 24 Jul 2021 03:43:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FCE6EE45
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 03:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNIKOMFPVPOoDyb+gnMU2Z89eZ+UcBnUUvFbXthf0TxKoK6RQ6gC7BkOtkX4LhJW1OILAS/8SIDQ4FxcL2RlTC1AyNG1vw6wR83Gx2IvdXMDhfsAW9s3HsNWb/WkPeUh7RDxPX86pbdLyitCas2AVqWdQhFkVeP03rPCW+G1lyGqq0SRSeUzDJnXiqyW4/HJeO0dUGgqu1l7dCnEO93RDf1mH5/T7GjRzx6XoG1KUVZ1unSfOMIoygoXaXwLiw56hlvRFW+i8IWpQ9rkl9G6zacq2vc5pVihHOLyYCXZ1w0SiMYzPMOpEh3tICtBalJWMKFNqSIjJxT2zhV1PpUdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMPJPQ94V/fn/BRj6bzX3I9MN+rVGqH8u9Ki9wIbEQ=;
 b=VFENVTeVCMvnV+zGjT9z0vFsLLTLdzu53+BEJx6tyMu20vbv54y2az+OIheC9lxmvjXcMPk4PihlH94vRhcDcTxP4T+oHF59dbw6fp4GNsNwSpnxscl/jUyhcF92wKesf2kQX7om5Kf0OdCIv9qt7AyDXHy5q7TLgqp4UmhhlBoUbdSXXsXnRz9c1i/6tRslPe6tShboaTTHtLJ/1x4QFJiOzAyDASuQ874S5+6pO6COZKAPUvdSUbSjjDXj74EUXDaLvqtbMJ7OjuTFzvuq3TBqNd5jtNgNirMmk3cJXeJijB23cwx2BpOd1n+B2XEuCNUIsqqdeStf232yxR75xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMPJPQ94V/fn/BRj6bzX3I9MN+rVGqH8u9Ki9wIbEQ=;
 b=eGOSSM0LFj7diQMDFiu4TIlZtt3ZH5y5tLvI6mnIgACsj2udEa024xL5BVpfHBilsGxc+Y40YL1xl7hgFF4EUsCDhrH4uanvyBMuVq2l1iPL2Ogr4EqdAih7NrCCFLfworCAx8d2dvmHo/whzfiwnlPe4xjq12/9biQg2Xswbm0=
Received: from CO2PR05CA0090.namprd05.prod.outlook.com (2603:10b6:104:1::16)
 by DM5PR12MB1177.namprd12.prod.outlook.com (2603:10b6:3:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Sat, 24 Jul
 2021 03:43:09 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::38) by CO2PR05CA0090.outlook.office365.com
 (2603:10b6:104:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Sat, 24 Jul 2021 03:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 03:43:09 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 22:42:58 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches July 26, 2021
Date: Sat, 24 Jul 2021 11:42:02 +0800
Message-ID: <20210724034216.3833957-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7642fd31-b6fe-42f7-2b7d-08d94e552794
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1177919AF12A34D53D2FF31D97E69@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b392qLhmgMoa/SipORBWA+MHPdo9AtdurC+ynoIOMwokunhGBg68UBehBz640XCOm+U2+E8ocnJtOH+2yu0gMelrbxfH1xwxTCASR2xoBe9mgmfmkgiTOC0eEf5dQtJEpBOZr0z9GCRWLczWVB77zt3+x+ualaQHUfsfa/vFRDf6FXMvQ2EVyf1xt+RQQoZsyl9fTXOKfuzOHzx9NMs4ahUodR4jdCZ5CY4MKMWwpaO4tl5kOELlQXYUdvr8GQ9TudtaUteALV1+Cy+rbHGH8DaOXzbAIeo+4B+ahdt31FsaNwHQ5UYkM2Vl4cCd3CnEJpQLgXJTivosP6SQvzWClI023SE0d8fAKKfOwx3aHEL085DDNwD97xeoJtAmv++bySNDJrCR37RIwBsjFLNBHMqzZ1reEC6uLYqLN396vdsK9bD9TCsimq/8yooI6PobocxdiwSgmtgXrl4mHtv9o9Es+rm0i53j1r6SqMypo+aK84Ue9Igp1ZQHic9jX0PGp4cHMBj/WBrwYgb8jJOiTYrJeDskvIiQEKMymvY0HHnq7jV0bcPmLIao+NfrVKrtpI+3CXfTJkE9NgpN2nmU6rXZjG9BwEorNe/87D90jwpMuTeFUsvauWdWLAsDWmbCdR2Do2RxgnZp6sQ/xMfA60Y+JAkmFqidDiomzyNsidYOmpMQ/YfUF1ZDcT8g2Z9+ZSzOwYyvFJWW7VG1uc9uR8XednrHY2Wlta4B+87InGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(356005)(5660300002)(83380400001)(86362001)(316002)(82310400003)(2906002)(36860700001)(1076003)(36756003)(7696005)(2616005)(70586007)(54906003)(426003)(81166007)(6916009)(336012)(44832011)(8676002)(508600001)(47076005)(6666004)(70206006)(16526019)(4326008)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 03:43:09.1185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7642fd31-b6fe-42f7-2b7d-08d94e552794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Guard DST_Y_PREFETCH register overflow in DCN21
* Add missing DCN21 IP parameter
* Fix PSR command version
* Add ETW logging for AUX failures
* Add ETW log to dmub_psr_get_state
* Fixed EdidUtility build errors
* Fix missing reg offset for the dmcub test debug registers
* Adding update authentication interface
* Remove unused functions of opm state query support
* Always wait for update lock status
* Refactor riommu invalidation wa
* Ensure dentist display clock update finished in DCN20


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.76

Aric Cyr (1):
  drm/amd/display: 3.2.146

Dale Zhao (1):
  drm/amd/display: ensure dentist display clock update finished in DCN20

Eric Bernstein (1):
  drm/amd/display: Always wait for update lock status

Eric Yang (2):
  drm/amd/display: fix missing reg offset
  drm/amd/display: refactor riommu invalidation wa

Mark Morra (1):
  drm/amd/display: Fixed EdidUtility build errors

Mikita Lipski (1):
  drm/amd/display: Fix PSR command version

Victor Lu (2):
  drm/amd/display: Guard DST_Y_PREFETCH register overflow in DCN21
  drm/amd/display: Add missing DCN21 IP parameter

Wenjing Liu (2):
  drm/amd/display: add update authentication interface
  drm/amd/display: remove unused functions

Wyatt Wood (2):
  drm/amd/display: Add ETW logging for AUX failures
  drm/amd/display: Add ETW log to dmub_psr_get_state

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 108 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 120 +++---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  81 ++--
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   8 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  21 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   8 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  48 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   3 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 393 ++++++++++--------
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   3 -
 .../amd/display/dc/inc/hw_sequencer_private.h |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  70 +++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   2 -
 .../display/modules/hdcp/hdcp1_execution.c    |   6 -
 .../display/modules/hdcp/hdcp2_execution.c    |   3 -
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  53 +--
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  12 +-
 26 files changed, 538 insertions(+), 444 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
