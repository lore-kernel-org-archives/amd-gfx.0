Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B92C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE3C10E6CF;
	Tue, 11 Jun 2024 16:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sN0aiuWh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A4510E6CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ywxm3v75YqCubzmphcmAhSzD5ivP4IrKzMjkjc+CZqv9uBbLNEdw+Znv40FHFLmP2shsU/hzcqAci05uXFICDSvFKUsrSZRJNpVKVMk3ObvUbcwrMLjGqXvQ/vFvqavRh0EJeKlCHYgSuttNic85TBtDNqAHj5uoAchi2uST43x5jxURPkk42Aks6a5xz21s3gYOx2vG83g7kZFKWnM87GFLxWxblJK3kzck6yfc2ydLokdJ+EDgiz7fKL+JYfD60YQK9yTGRGuN0zQDuBVyi0Y5pKKGPGO8Wk85eExwqFv0Rwqv/6PEX7BCdOYBAlGpdi60pOW1IJvaO1OLp7HOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHy/NZnTdPQDxbhoVccND4dtXaDb/furT5q9PN9splA=;
 b=XiZTdRCAMSCNhhUm/iwArWNcU4S95nzEkF3gIsblQXGbPf67yYZh8srIJvUXdy7y2DPIMFvNgTlmiaueX9VhP61M+Onn49oIPCOYcJXyunUtT9fiQ+MqdaHK9Vx1zeePePnNOReU9JucRoLy/tP7K3L09EQb4p20rjiKw5eeLGuDWpmYQ9GIFgcbfjIOW+dPH3CfEBG4XtCn7F7l3S2vRNAdVDUM5g8EIDVnnSnWJGJ6ruRHpufxTdCc/RGiGDM9lHtcy0Um9cznRrY6ET93YQfyXRtpr/XDSWOWNcCKigbtJQatTaUS45pV1AV5Crvt4kSXcEM1vdZsTE7JYpt8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHy/NZnTdPQDxbhoVccND4dtXaDb/furT5q9PN9splA=;
 b=sN0aiuWhXfJWkP28WHRWbVI+MIIABlxru/BjV46J7LhlPYV+r/2yg2yTxRZGeLF5XiRoL+2Q+MEKHdgQIZaUUDh1kuwcTsGjqJH6N+eUMTMXZJsUZZF6iMu8q8yZovIIpGB2+JKMChOCPKptnBMVqEUHqgH0ICVHxQ55X1Kd27s=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:34 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::7) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:31 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 14/36] drm/amd/display: Add null checker before passing
 variables
Date: Tue, 11 Jun 2024 12:51:17 -0400
Message-ID: <20240611165204.195093-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d18f3d-0dff-415c-6203-08dc8a36e446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DUX5Rx/kSvf8txCqO7Cl4bLzXEUZcCmNZ3jENuJpfy0P0bd9uwIXjXX/frwd?=
 =?us-ascii?Q?xjzxd3LXmSjF7wzsfTX2iBauDWAk1+Yl67xXFtn1N0ajx1xdmsTT/36LOFD1?=
 =?us-ascii?Q?Nc1wHMOPWoWbzCD/fUrcqt5eL8kmZ7Z+7bs/+7sourF9w2dBuU8qNgoBLU/C?=
 =?us-ascii?Q?12VTeKdUGYOBsjVHSnUKjP5RpAxUMJlz1J0mx+e5wXlriw5uBtKjRG0jJX8M?=
 =?us-ascii?Q?pKYfkr6qTHpJNEcA9qR41cX3d7KKn2OE91XJ63kZ1w0fNEaaYd4nGBR9DMwe?=
 =?us-ascii?Q?45/j6g2L1iExc2AizNc0+oik9MN1kUv5UNdZ6Gva6fwLXOm1vk2Rl9PLct4H?=
 =?us-ascii?Q?KCkHIjaDZL7Us2fBqkpG+VbjQA29Do1GJCA/17SPaEUFItstWckhsUxYcXGF?=
 =?us-ascii?Q?+u0c0fCNLdzGPNyWI5wZEbRYbA5gbnY7I4rneLoHGOlzreC7xTCGNnHVOcBS?=
 =?us-ascii?Q?eLuBp62F8qwjQi1YgwBEg4XKaEPR3PYsIISUIQrIfBjEfGQNLPqwg58pkPdR?=
 =?us-ascii?Q?euz5wfqNVS5H2kusjVl3sY13qNjGSWyhP9vEIBqZSpfRthFLvwcp/l8cJT/f?=
 =?us-ascii?Q?Mgong7kBM5vjMhNnxMMySjFDyTtfGWSpq3WfViwMbl4r3l58o/Juc4wNw97X?=
 =?us-ascii?Q?1kuF9p18twxaLYac+Yt3qiUCkipdOPvy56ji9o2XNnY2YOOxhRxgCJ41G5Df?=
 =?us-ascii?Q?K3o/5KeC/y1l7t4ITOmLOZ0Os2md2vEMGeqogxpgZCkHkDopGbYD4WvpLVpe?=
 =?us-ascii?Q?d06vKtdJeXM+t88ZrFJajRNdodIqZYRKkgiRfrTb20NT7GS2XrjmzskSYMTm?=
 =?us-ascii?Q?G3wRWUqDghknCbMPcX5UDanKOXWG9b2L0+qvwXRzDxI3JK3q0+0EY4R0jOkQ?=
 =?us-ascii?Q?GjnKm0u7MSYdCifVQg3pZEmUYtavIHu6ZipkcO/N2vRVeVwJZdE+fPJYw74T?=
 =?us-ascii?Q?vzMrz5k5D5MmHymLgJOtjWEyH0k6rIO4GH3HxiiKrPjWccChf4wQV4NlRoJ7?=
 =?us-ascii?Q?0P7fRTgz5LCTfGdlEP4u7LUBkrsmReD3g80OsdHPdhfpsU9chFqWAZ/X2IHu?=
 =?us-ascii?Q?bIdQpyKDswvDhUq/oHWHcz/weoCPfhaxOAZMznUFnpMnY2WrFtuXu+9WgBJY?=
 =?us-ascii?Q?8df17AtR15naCg1Jx2+G+DXGYX4giUVeQ8q6k4Tyqm0F0P12J7JYOI1743Op?=
 =?us-ascii?Q?6C8y3R+4HDVZW6twoMljHS6QmN7o+shO/xvFLkguPVmw6TT+OEcev+uY52bc?=
 =?us-ascii?Q?t0KhcONCdbwNt8CLDs2dqzo3oHajvgbRoZRCnu8TV6fBw5vnSlz6HKXgPdY2?=
 =?us-ascii?Q?I1zOtG/Kf/6wcOqkbkp98zxfMiwzuz6OachsaXGNw+GQRR8saA0DoPhTnPr7?=
 =?us-ascii?Q?dYr2tj7UgqF1nWbB9qs0Uug/RaXCAoeoA0RF+ulTOsI+ujZ2tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:34.1671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d18f3d-0dff-415c-6203-08dc8a36e446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

From: Alex Hung <alex.hung@amd.com>

Checks null pointer before passing variables to functions.

This fixes 3 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4de50b297035..48a9243ada7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2875,7 +2875,8 @@ static int dm_suspend(void *handle)
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
 
-		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		if (dm->cached_dc_state)
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -7102,7 +7103,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		aconnector->dc_sink = aconnector->dc_link->local_sink ?
 		aconnector->dc_link->local_sink :
 		aconnector->dc_em_sink;
-		dc_sink_retain(aconnector->dc_sink);
+		if (aconnector->dc_sink)
+			dc_sink_retain(aconnector->dc_sink);
 	}
 }
 
@@ -7929,7 +7931,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		if (encoder)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
-- 
2.45.1

