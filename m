Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC7DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22BD10E4C5;
	Fri, 11 Feb 2022 21:51:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF9510E4C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCIDtzR/Opkd15FrcGLGtf9j6cGWF5w96Unutxk6kmcEccHY9monn2Z29zMzDuPMHECc+mV+m76+3utys3KIngOq3nRqDvPdg1vcDa1Kypa94vsvjlU0omQbBVrZk5DqP2Mw/1Ug9h0Kz4kdBkIDU5V1Ilnt/aL2qyD8xg4SvO3iB5ntZX7LZ9UsXomN/TfqJL2hIgTcjpp7twl6umBj0c18EZjId3n3LW8B3wx19XA/48vzj3H28vdPNEW5Tye7z09DEc3vigE8JcVLRw4q8dEQeQ1KsAN7zUq389E2/RRTPblSxMt2i4G14XX0gkeCIN//za/nB8B1u6Lb9lV9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8g7D7RswshdPJS5pYc7/a7BmqpPbB+3/EUTyhcbcUk=;
 b=GzaRVhLyH9YSQ7VooM0KT3RchHtuCpyAYnJrq0HHPao9Nq0d5hPPgsWJQ723rOmok2+f2Vk0foXcExzzw0RzDyK9BjHVr4yyW9Cxddryyr4+ZUnKlCoOXSkapfIDNN2cQADqa98XaU0fR+4MKQAYDHKvHM+dZE27O+XfUfHFPPsIQHLOwBbnHylIRACSc+/oUyFYi92KPh/vPUOCIt/LXAYXxa8nuXAzxi0KCapNKnWiRLJ4DW/lMHczP8uzWBmXdLSigYgJ5FY9AO6fVkJv4Rpo3yOL1pJlxkPsn8sag4PvnjT8NwwRYSHQDUEMg7tPhNnT8q2JsVNSCAochuZkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8g7D7RswshdPJS5pYc7/a7BmqpPbB+3/EUTyhcbcUk=;
 b=AiCgzaEsOs2EGLMiW4dXy1MZyVHVDOX8hU08HA5ZOpiLniysufB+SnMz6q4u2aQO34lZDX/glJtAr899ibrY/1rRuEx4dKSmKXNtNLB6e0zF2HXHQA36VSjqv1S2Xe4usQU7rD1oL/5KCCBSY3Jw4klgUcK37kVvyb0hmQV7CmQ=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:51:55 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::55) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:51:54 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:51:51 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches Feburary 14, 2022
Date: Fri, 11 Feb 2022 16:51:31 -0500
Message-ID: <20220211215142.94169-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcb547ad-2972-401d-ded9-08d9eda8b82f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB550795C4870EDD7989E7BAC1FB309@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZnvJAGd4kpn7tyq3/sXArdhyp5FwEmZYX6z1FSGWOiSeFK/fU7rZFNECY6xaUNtPajn6IHeuOqMjupzopR89tPYIiqplTOTfESPaLFDbSucQ982q+mdy8HLChd5mdiR0sXKRBd/VpJKunNBNTXEu7heUkefJrxgBZdZ+lAo64z0Oc9bXL/Zd54BpWD15uS5XS55rdLPn2jYRN7buRL1IwKBwxriYSQjAbiM8EWu7rnCHIkvPs1LKFmvoPjJMsebFoz7F5RwNfwwssAN8R0lBPjWT0kouWFtNjEXn0Qwxw8yNQPWV3hj0pCSVKf8/kMY5995yot6Wt5B0LEm8eqYb8iGRSpzNIa5eFaw04PUUZ9L6nWdAP/jY5Bn78dcRWoTsID5ADXK1VENbyTFX1CdO5+zF5zfMmqZGpwyiB7GLERaH+ZQuGYH9VCBLLKIdP3M8D+AexheULm3I/nUeJ4Dd69uHHaO4sV/mCFwg+WtC0zm9V0kdOfDdvM/tSIUGJY7eUvIitSSGoXH7AI5puvBuZFAUxyZInJhNbJP13VuScoaAhPqWAy6UV8za1FN7Z+Z90CtkqKPPNpEolKqYj+XQVuW+M6CVwdzlBqpTvDLtu71H91J/yA86ShBYiWKFz9LEN4egD4LPu7w4kAY2dXRTWPRPFTCrx8GnX8e596J4UeYfUQzzqrscL027bphZx94bzF3WpFVPfTc+6rnwbEst/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(36860700001)(6666004)(82310400004)(356005)(81166007)(2906002)(508600001)(54906003)(70206006)(8676002)(4326008)(70586007)(316002)(40460700003)(1076003)(6916009)(83380400001)(8936002)(426003)(336012)(5660300002)(2616005)(186003)(26005)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:51:54.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb547ad-2972-401d-ded9-08d9eda8b82f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
-Fixes bugs for dsc mst hub 
-Enables Z9 denial interface by default
-Fixes dmub outbox notification

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.104.0

Aric Cyr (1):
  drm/amd/display: 3.2.173

Charlene Liu (1):
  drm/amd/display: make sure pipe power gating reach requested hw state

Eric Yang (1):
  drm/amd/display: enable z9 denial interface by default

Hersen Wu (2):
  drm/amd/display: dsc mst re-compute pbn for changes on hub
  drm/amd/display: add dsc mst stream pbn log for debug

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for dmub outbox notification enable

Oliver Logush (1):
  drm/amd/display: extend dcn201 support

Roman Li (2):
  drm/amd/display: Add affected crtcs to atomic state for dsc mst unplug
  drm/amd/display: Add dsc pre-validation in atomic check

Sung Joon Kim (1):
  drm/amd/display: reset lane settings after each PHY repeater LT

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  13 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 257 +++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  66 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  20 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  16 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |  25 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.h  |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 -
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  23 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   1 +
 18 files changed, 429 insertions(+), 53 deletions(-)

-- 
2.25.1

