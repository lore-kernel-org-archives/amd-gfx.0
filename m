Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29057C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17C561283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E17C561283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F6B6E21D;
	Fri, 19 Nov 2021 19:43:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0AF6E21D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg9oRXiFE2Bi/9VkPwOFatHR3XgOHwZRyfuRAW8Id1Q0Ozjbvrc2I5CVHoVcW0c+Xh0mpF28oN+b/DtK5QSjokq61V076nO/IbwoBpMaCkWSUVeT6EnMqtHPcdetOELIGYelFIhDSZ6y7peksSQw71YdwZJw6tAaxp7otNiPGBQkvGd+/lRykPN0hf+PPT3Wn5wMcz9gHJkN1VNt6mkR6gaj0BEn4TFvqP3WIIe2hdKfPitis4eZcSMkvq60vjKLGiXEx0se7Y5jvJ+R9heyFn6qdLfNTbO2uJ2ZhRiuMd7kCucoSEy9DUjlJfvRWXS5v7KFU2faLDozSttJyXx9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75FwnCeBl9X6054ym5t+dHndUEePwAkUevv8G7cOx9I=;
 b=je6E1vvncEz/kB5VnpJG2neULnNjYZ7OtDBHQIfcq3iWxUWrsTN9l8xRxh5QIhF9erMQkT1sVOHP0+xZRGYS95LBHy+Vhi1qdSbfJ3GCSKE1sabIT3tjW2OtpCOgzVZ4rggt2pvkDfn6IQC4+nbDjqoJj7jzQOXhGj2W1wSN2v2YNZTZFo3ZpQlb67GL9FNVnFzxkoixLcWBhGm4B7cQivTv8O2mTgAhtdOy1MFbqtXiV6bx36YIFvIcPtRSEj5/HgAMAPNbR19BmBFOYjdfrDhrnNM+8DVxi0JwyKB7gKRgfCKZY8P6UwIm6RYa81UURmsKSp93ic+sx3w6h7dnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75FwnCeBl9X6054ym5t+dHndUEePwAkUevv8G7cOx9I=;
 b=YSHHiJNscLe6xSmv1IUr7K8ZGyLm4s7IeRJjEhcHn78Y2mtApkvtLzDfuW15u5VJP+6nD5cJ4jXII8tiOH4y3FHcxlEAk2RtAs9uDCw2d2apn9WM5ZmA8DXyTC0cdckAD41y2dHtpJOL/cHml03mgvvnyZvGOywDGh37nDlqqDE=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Fri, 19 Nov
 2021 19:43:50 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ca) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:47 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches November 22nd, 2021
Date: Fri, 19 Nov 2021 14:43:23 -0500
Message-ID: <20211119194339.97573-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b88a9f8-01d7-4caf-c33c-08d9ab94e8c6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5072:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50721A9D81096CDCD36328D9FB9C9@DM4PR12MB5072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAl8HZoiWnQzMkxzDP6oOBVV8pK7k+ZzLhc5fJaqqCCWOJLeReI1Hb6HY3D4ueucEUeGTRcZPdPFoMJSr9Q2CcTFfKCcF46Ec00OBtiPi+ITh+BgqVoVg+DvP1x1Y8zxsZugHExxmj2vpQQtckWC7i57VLRUq/PuhJhyUlGXae53ZWd/pQyXl3POvgUnONDlqt467VxUyjn834PJQdafkDy8Apo5Zy8ItFl1a4aGJGSU9tUdM2fofDVfwM3Z/5NQ97y/qeHRF8+gU6ZIZjPfPtK3YkaLAVW38AsfkuAFWLkhcBSmYiavmOV6OWMjbVxURI4w0uNBlnG+usafHIkQhgMDW4bk8CP84GCa3c/C99dTnKqJW2reUL/5VCRqMZ6BkhQ/47R1cyH+xuxkWjP2rm37GEII0KMOay7Vymi4WimPqByizZxx+Wt8liHZv1IcnPEUo8FAVasqSJVLpSHH/pau2W/MWLLi6kBdBnXnh+f6Epr/spFjkGli1RS6TyH8tbSoAY0ibhpRgxAh8bu4rzHLvlhCPmx2vV4VvI/IeQmsKMBsgFJtiuYggTRd4uCy+y2muvTgBBxUC6fLIVknefffbWWh7vsSKNH7wxj0brNoKAY14ytTOnPdCCHHgrOhqCmJ9Rfm4bw+aVuawOIouKydboUkLK6Ejn6SZaFrgHydL/5/hk1eN0SOohi6opdo44lEU1ouEVnOFhv6eQSR/fugrnHooOZj0q1VYY8qFSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(6666004)(1076003)(6916009)(5660300002)(70206006)(4326008)(86362001)(44832011)(82310400003)(8676002)(316002)(47076005)(83380400001)(356005)(54906003)(508600001)(186003)(8936002)(26005)(81166007)(16526019)(426003)(36756003)(36860700001)(336012)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:49.6946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88a9f8-01d7-4caf-c33c-08d9ab94e8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- DC 3.2.163
- FW promotion to 0.0.94
- Enable seamless boot for DCN301
- Improvements in bandwidth validation
- Fixes in flags update, link encoder assignments, DSC, ODM combine and more

Thank you,
Lillian

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.94

Aric Cyr (1):
  drm/amd/display: 3.2.163

Charlene Liu (1):
  drm/amd/display: based on flag reset z10 function pointer

Guo, Bing (1):
  drm/amd/display: fixed an error related to 4:2:0/4:2:2 DSC

Martin Leung (1):
  drm/amd/display: add else to avoid double destroy clk_mgr

Mikita Lipski (1):
  drm/amd/display: fix accidental casting enum to bool

Nevenko Stupar (1):
  drm/amd/display: Display object info table changes

Nicholas Kazlauskas (4):
  drm/amd/display: Fix DPIA outbox timeout after GPU reset
  drm/amd/display: Run full global validation in dc_commit_state
  drm/amd/display: Set plane update flags for all planes in reset
  drm/amd/display: Reset link encoder assignments for GPU reset

Sung Joon Kim (1):
  drm/amd/display: retain/release at proper places in link_enc
    assignment

Yi-Ling Chen (1):
  drm/amd/display: Fixed DSC would not PG after removing DSC stream

Zhan Liu (2):
  drm/amd/display: enable seamless boot for DCN301
  drm/amd/display: Rename dcn_validate_bandwidth to
    dcn10_validate_bandwidth

sungwang (1):
  drm/amd/display: Fix ODM combine issue with fast boot

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 66 +++++++++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  6 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 +++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  1 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  6 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  5 ++
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 31 ---------
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  4 --
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 28 --------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  1 -
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |  5 +-
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 11 +---
 24 files changed, 99 insertions(+), 113 deletions(-)

-- 
2.25.1

