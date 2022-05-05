Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEFBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232A010E3B8;
	Thu,  5 May 2022 14:24:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735710E3B8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWL0XI3OwDCj5rvWISijfZt1G4KzofPnA7Nie5Bjtid1l6JKYt8UvsTK5XIUG0asAZK6BIdB7P6sHHQf5GEnuKtkw4SQt4sraefkZG90BBCQXZ+HcO4CtrWgu+cnKtK0f1k1/2lSpVLkPP9R7Ww+vowsz1lnguHoYvGS41KyMJTAZqozZ3q8qWwAgZ/2QDc5m3DbGrs8tV5p68ML2mqMEiwDU++22fTTw3ff25hN5jMdjumdBtzBsl72EH+EG7LL6KEj7OXt2aBGNGPuchIHEaxMSCAH4EZD2z0wqgLxBg3Le7v124Jce5wMKKtIYVJw0FoTGwvq5zwdxXF+ME8NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk5cHbKaFLkmbwWcRCiOQLvRpDNxYn7T1KpT5mjDgbk=;
 b=XusKTJuHBiD6BAwPAebZZb45lc+MBq+44KwBoS4A4IYxNvK1gz3xT1kvJ9sN3pNheEGyhCD4+uFYxPNtj6IqeFDHhgCVYR8eIJCO/doPZNdUv6rfPyqsGwNlmVwh6OGddEBnRmCMUrtaUzsrAg2GLnSk/L1wPvL0Ak9x3Fp9syTOXeUkv/5/MoijJAHHYXuMTjro7XiRFNxUaRE/lZjRvSuod1LJLmthNarKt+4CMMlfo9JwxVP/F4Y0qQ7t+jHHNhdsv7h5EVki/aIyTuX08CGfxrgCwQ/ZDR6f89/KdEVwC3Zq3GvzddymQSnoJ2X+B3gpIj6wBHqTc2KhmZIBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk5cHbKaFLkmbwWcRCiOQLvRpDNxYn7T1KpT5mjDgbk=;
 b=i/w0cfRFSWqw/jpbdBovN+i6gIhQvBp5HqtAnPNDo47It3CAlX7APzrIXrPvNRdXwHyhW0cg7xV78/pVKRJdSZ7aTD6x+n40+41+Yz5p7K8ExhC89So9apr0YQEc15anYxkHs+P16aFED/o7PM/xoTU/yrNfED1t9V7a022Xg98=
Received: from DM6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:40::18) by
 BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 14:23:55 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::60) by DM6PR03CA0005.outlook.office365.com
 (2603:10b6:5:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:55 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:53 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/17] drm/amd/display: fix system hang when PSR exits
Date: Thu, 5 May 2022 10:23:16 -0400
Message-ID: <20220505142323.2566949-11-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b463cdbc-0855-4070-5c34-08da2ea2e307
X-MS-TrafficTypeDiagnostic: BN6PR12MB1860:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1860B6884955507C0E37A7D28DC29@BN6PR12MB1860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m9Xmp24g2YaWF4DlDa7z6JdffRgs8xJVJJ808D+16rpNv2Qid4ZADKxlvbA0XvqoOqh0BhhbTVruWuOLcYRanz+cudoWR8W8SC32k+6TLOt7uCqMBQaJ4TqFV1FVQ4k5XNl1aIPMcvpFdEIzvOV6v1FDkQySjoi010SSJZUelVlG79IDhT/ckb9WuQQhC3Puqnlg5pmZctNIw2pe8kPaNW6fQFOgpYJdSggo3O4ity1kMa+T+wtuDnUCrWonF3SfYpnOlpsFWunsgN+zIlf+3ifeD4HHtH2JHtMSH6LmZ4+homm0BbloVArLqQj+wqwY+o/nGhPV5Mni0AM0qXo5zvNA7qeUXJC1ENpxNmN+jGCSkn5gCAlcfe8xCBU1TYA4AT/7/X8fetlCbQ2hu9Up/8ERs87PI21zNQ6Ic5ZZU8mx6+D36ajollujTDXCZWKRlPqHypWEHVnMDDNiNlQiuz1YhLrzoDT4VWxyuSzxhnvg9E2DS/ow+fmkDdrIztAPuSIm4XnbGeYMoi6UavDecgQmvoXMDw2v3Zwab4ODQhTEi5Y2HfhV4Sr5OvgzCr4X3ytn7MvGCkX90/eyFG+zCq3yO6adynjkeJdLiJZdc0mPe6L7RhjUE139K5F8RlL3ESzIHRfewkQM/3Mj4Q51T0DLlFArzCe0kcvyTXHh0txFSskeClyBghW4LR/BNIvVZ9lPdyeXHc5nytYXmM0ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(26005)(1076003)(356005)(6916009)(6666004)(81166007)(86362001)(426003)(186003)(54906003)(2906002)(47076005)(336012)(2616005)(83380400001)(16526019)(36756003)(40460700003)(508600001)(36860700001)(82310400005)(7696005)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:55.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b463cdbc-0855-4070-5c34-08da2ea2e307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
When DC driver send PSR exit dmub command to DMUB FW, it might not
wait until PSR exit. Then it may hit the following deadlock situation.
1. DC driver send HW LOCK command to DMUB FW due to frame update
2. DMUB FW Set the HW lock
3. DMUB execute PSR exit sequence and stuck at polling DPG Pending
register due to the HW Lock is set
4. DC driver ask DMUB FW to unlock HW lock, but DMUB FW is polling
DPG pending register

[how]
The reason why DC driver doesn't wait until PSR exit is because some of
the PSR state machine state is not update the dc driver. So when DC
driver read back the PSR state, it take the state for PSR inactive.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 119ce8b7a555..144c387010c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -657,10 +657,17 @@ enum dc_psr_state {
 	PSR_STATE4b,
 	PSR_STATE4c,
 	PSR_STATE4d,
+	PSR_STATE4_FULL_FRAME,
+	PSR_STATE4a_FULL_FRAME,
+	PSR_STATE4b_FULL_FRAME,
+	PSR_STATE4c_FULL_FRAME,
+	PSR_STATE4_FULL_FRAME_POWERUP,
 	PSR_STATE5,
 	PSR_STATE5a,
 	PSR_STATE5b,
 	PSR_STATE5c,
+	PSR_STATE_HWLOCK_MGR,
+	PSR_STATE_POLLVUPDATE,
 	PSR_STATE_INVALID = 0xFF
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index c2d65756ce5d..e784002fe312 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -74,6 +74,22 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 		state = PSR_STATE5b;
 	else if (raw_state == 0x53)
 		state = PSR_STATE5c;
+	else if (raw_state == 0x4A)
+		state = PSR_STATE4_FULL_FRAME;
+	else if (raw_state == 0x4B)
+		state = PSR_STATE4a_FULL_FRAME;
+	else if (raw_state == 0x4C)
+		state = PSR_STATE4b_FULL_FRAME;
+	else if (raw_state == 0x4D)
+		state = PSR_STATE4c_FULL_FRAME;
+	else if (raw_state == 0x4E)
+		state = PSR_STATE4_FULL_FRAME_POWERUP;
+	else if (raw_state == 0x60)
+		state = PSR_STATE_HWLOCK_MGR;
+	else if (raw_state == 0x61)
+		state = PSR_STATE_POLLVUPDATE;
+	else
+		state = PSR_STATE_INVALID;
 
 	return state;
 }
-- 
2.25.1

