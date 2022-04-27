Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37246C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA0710F3B0;
	Wed, 27 Apr 2022 03:01:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E99C10F3B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJzebvZMXgff2DrbcBz8ESfIYvCq9z8jHd01brLTU4GzfXuSEqV3elyCXDYUVMaH2RNuPe1JwN9NmejvQSbJfGM6Fv1DYO6GOoCmaryXY7F0Q82X7GHm8SBCoKRHoH6y7je0lw9xCPS2laXAtpq5YsuImwqRXCSAAesmEjSiglPaM6fM0Jd/62D7nnfRmHDdoSMtMTYHwZ/K2MYj9IJGjhcvWF9YF8oUQ6ejM6u9mMGkqOdDtegUSkhATGMFPNc0hq4TPSe2I3/wD0ndcmGxHf0KTF5BhmCrlGsK/EF/Di2GWGhUKEgKB/hpPi3Q8OC7aCWqS1vb37Ahxq0PhtU4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd3RSnOYlKWY8J1dfdicbmotxLub6eTtcJPROIFyFrk=;
 b=l9WyGGnXGEPiJ8dsanWymoaTzObC8y3La/DY1Da43qut1NUhzKae+Rj6C3G3DOE2EcFEs4Q8lANBRP3RUoUeAnFMmTM8Zx9IbVC+Gr7mN2CrmwYvXUGUhz8DhuXAjWBF2PMb3Qo3dxvddg2r7uhvxLbntD0Cx9K5WN9OAoGdwLrsdaxvczPKST/LyjqaMW/At99uegaiXfh6uzaT/rZfZ+UuxMBFeJ9yduTU4v6hKS/yDq5UeRCNHNgXrpD2mvVJuXd4DWRzexcUiX6/2ZsX36/4VN2JF5rDqd9V+80e4PNCKrW+wMfNU6eRgCIw3qJWs1JTeoFQl2AioLQgWBk5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd3RSnOYlKWY8J1dfdicbmotxLub6eTtcJPROIFyFrk=;
 b=sLXjA4+xvXumwvWG3nUhhrP9M4nSdpycVNjBCtrJ7wIuFyAvjW1r0oTiVPHwQFDVQrVq/ItUdNGOjxRaksOvtla0qkl9SClKkmhAVAXRtBPAS56S348gd8UVtBm5JD0MfdOi6VgSGY/2UV1z7w+VM/ALIvVFbt7uLVUm+UVLXXY=
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 03:01:16 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::f1) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:15 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/8] DC Patches April 27, 2022
Date: Wed, 27 Apr 2022 11:00:51 +0800
Message-ID: <20220427030059.1242868-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5bb30c-073a-4abb-51a1-08da27fa3214
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB467037373613ACA5B0468F85FCFA9@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXTOmS1koHevmCSljVU6SIbcWIJdzhAdF/1y89cgxVFHR+kcPzQeyop9yIzj2a/FdCGkoIkmTQM/WXDKBd6/E8cD/XWZ1BB0EslIvTPO4LhWinlAcXyn/4MMLqoCbytcjXnZ7uCT3Oa+himHLg5kIq4RDrisGcJIIEPBpjaK3f9vxQ3/neTVR2laXcKQXT2fkTm8vmjmju3MYLL0cw+qXC96n95tPqyl0wlOfdTLmB0bo+kv0hRdDKirIGW/+eVC7CFX8z40bwZ93P60S0zAFmtia5QFwuC7Dcnw3buBYlkipc1Jy0c5INrKHQ6bsZqgIMhepx+xByNyujcV9Wzts4NLGWXsRqXLBr3Uq/rxQwG5GY8PO8cHxIBrx2LtIZXeIoioN75+dNT4eDTvMD9moHn0PCWu4ZG8i2x0cK+rhD70jP6vNk2EcbqEUXfrQo0zNbGAbTQEu4FLIwrjRE9BJc0UpJ94ANpNx/xzuPLpDIrIMF1F8RreQui9nMGcqD8ZyFctwlas6Hhv5eTVwDo1hurXE6DTDddF8b456uiZEex0HIEOxMiQoERJvLeaEHu6RXbSP6eKSyaz4PNm1mk10yQcCzjC6wSw3lh/TFfY784m/CI8vpjdEN+lzffEC2BWbrCpWkUPQlZOq2wZhnAWg5uRvs03uE9o+vw9iyCdMJmobRiMB1WZDMPcopyv14szBnGuLOk8KDTzaP2L0gzhYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(26005)(186003)(6916009)(54906003)(336012)(2616005)(40460700003)(1076003)(7696005)(36756003)(82310400005)(508600001)(36860700001)(81166007)(86362001)(5660300002)(2906002)(316002)(6666004)(356005)(83380400001)(47076005)(8676002)(4326008)(8936002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:16.1221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5bb30c-073a-4abb-51a1-08da27fa3214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Have optc3 function accessible to newer DCN
* Add CM boot option for USB4 tunneling
* Fix system hang issue when game resolution is changed
* Remove outdated register for dcn3+
* Add new DSC interface to disconnect from pipe
* Clean up pixel format types in enum surface_pixel_format

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.115.0

Aric Cyr (2):
  drm/amd/display: Clean up pixel format types
  drm/amd/display: 3.2.184

Eric Bernstein (1):
  drm/amd/display: Add new DSC interface to disconnect from pipe

Evgenii Krasnikov (1):
  Revert "drm/amd/display: Reset cached PSR parameters after hibernate"

Jimmy Kizito (1):
  drm/amd/display: Add Connection Manager boot option.

Lee, Alvin (1):
  drm/amd/display: Make OPTC3 function accessible to other DCN

Tse, Kaitlyn (1):
  drm/amd/display: Remove outdated register for dcn3+

 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 +---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  | 11 ++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |  5 ---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 10 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.36.0

