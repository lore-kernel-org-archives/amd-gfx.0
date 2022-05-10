Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA01C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278610E8C9;
	Tue, 10 May 2022 20:46:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A8C10E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxvXxkyLgbq6ynkJo/tnhJE/WTTPavc3AAqBvH6ElUahlQwy2pV5eB2TvT/9dE5AgnF6LlRnsh9dj9UNP7NomCINh0AujZL5AJYCVPTUwTS0TWTvFw0N1zx2ggxZ1LzPkhKy3CGEeU19rtqh0GFqi8qIQOPi5dFxT24QkMvyJQY1NDlo5qHF6Do4/h/m/qr06Qf7wf9Rh5SSgpXIXOr13LHbelvzcb+8+y2nxgMQqFV0lpGcRo2S9DyZ815EFnRlbGkzj/2qiJmEvFcksfIeeqWoiz1caQUTZ/8KBy6yQD2KXgRn6fGKU7aqAN05sFtITkVF73aDG4jQqAAh6bkKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk5cHbKaFLkmbwWcRCiOQLvRpDNxYn7T1KpT5mjDgbk=;
 b=icjgkhbY6uRLsSCwg7ZZ+0kbV7r8DMVietbg604wv2hcs+joAB81qHPnjCfJEl0Wdvg90X2IfCcvvSabMuDXkTLXNKkmwWnfH8oCgX5yzLa6A6YBam5vovNKcC+u56gHLR+mr8qGVkypb+WtotggUnI/E5mZSRT14+QdMD6lh8RFHBLNyd0QMJgIyqezt/k6GlkTM0xVL98WNOWhKV6AJOJqLTS3MdZOoVomlOcdqgiRhkgGvKtVkeaMWvYIpPZeVBcXzMntGIbHV7djkeZttwoZXhRkNIVEMns6QVB2z0ggQpxGwssva2y3YfSgCuMueHhymLq1CeR/Mn+AltJg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk5cHbKaFLkmbwWcRCiOQLvRpDNxYn7T1KpT5mjDgbk=;
 b=hDOCIxqit4mkXn1saiZfhVJq4WMjUc86Nw5xJFrwV0ddclUDqmYdYpLIGtYlxQ5B3zg2j1YZWOKFdasxCQeEQE3XpLJaItgtDMB0OWYFTrSswO/KPi/gN9SnGKi3obWLb3n/fmjsdtq/bAu6MoowdYkKtxKufTThxvFr676inak=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:46:13 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::82) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 20:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:09 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:03 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/19] drm/amd/display: fix system hang when PSR exits
Date: Tue, 10 May 2022 16:44:59 -0400
Message-ID: <20220510204508.506089-11-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa588dd0-5e6a-4b6b-cfd5-08da32c61ede
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5951E29BB7442C0831E2500F8DC99@PH7PR12MB5951.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxe2BkjzfjkxHvHbbN/EXLcxKk6drrSuhe43xadAS/UST9Yos2LOiMhQN81BCddXBVm9gbMINfvxZoU5lZym80FQ52h2UlyRW7zndrTFi1B/BrMDKz7NZwVts/X/VEtpx7kxHQct48LJjy6mlRKodyGtWRzS8J8OFv4rCwHHNBHDiwtIqE+vWXdRQuEZSScg1zNv1FST+ZgYPFUj7Jg0++1hxFimwl2dVjELk5kA30PoJWaXXd4W6bC0QR1auiZwDBR++DiqRpSF84ICar2W9hO+uYd2fqnjwA149NTKLDTD5QJMkQVu2mBm9nQO62PLLoF4pa02nDB8DcyFvWiPhJNvpzGBpBUmG4OR1G9sTeCKMG1RfaroRbMy4qz568GBYWGoZ60/JxuHlIpYlMiyswpjYhsUTMHmQkZinHnh4iJ7KOJN5Nb9RBpA/ePYSYxRQ5leyI+RY2wEVW9lI/WfFJmbEovNUXRlsWuKL3c984UhenbbCPekSEmhxs8TMX5nIZ7Pno+Tn8w3lR/8GY8Q4n8Ymm5nOOIU5SJo8+5P5FKmKdsRAaQochfnwA5QWKSHMm3Tu9ITQo0+gos1yPwk4eHZqBUvOiXYppcnglqHoD4agaooVwq29Cbofz3G2BzY49CPz9uMw9YIkNh7JedZ2LfuHT0V5laQPbPGEirL1DV+EwvHe9WhkWWisbG3CIHj1LN5l8+kv51cdEn2n2IdhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(6666004)(7696005)(8936002)(2906002)(26005)(36756003)(508600001)(336012)(186003)(47076005)(1076003)(2616005)(426003)(54906003)(81166007)(356005)(86362001)(36860700001)(70206006)(5660300002)(4326008)(316002)(6916009)(70586007)(8676002)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:12.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa588dd0-5e6a-4b6b-cfd5-08da32c61ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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

