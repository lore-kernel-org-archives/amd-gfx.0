Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F88B10EF30;
	Tue, 18 Oct 2022 12:28:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DA810EF30
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSYCE3yeyLdV/wYQe1LpNo4kPwW04uojpqEI6aVl7P4rtBMGYy+M24UOg8olrftpqjKNzHl1TKoKxB6q6foyMDnZ0Q4L1OK7FdxXQFEG1CFDfy/QuL9KEdy6Ml1sKdMXTgnccwX7deRqLW2p6HQ/uIxppabjGIUi5jzP5TkIeaK0IU3e8T+ZZXsMhgiZ0DlM7/Nfocqo6xfPwMG9qJazo1KGZN3qq+hdIDW4gZ4eyCEGq6qi++TZcxcoJUDgo2qbEY+KIQPs43s9ymrKa7Xyrkg+k9hZA49N+VLgLjfUMHK8ls/xBncAo3P1Q6wsPXvd/JyHW63rXcTQgCJoPYPU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4+CiPcs+WEan10JX2Ig9Kav8lPZg4LwvViGZTqs3es=;
 b=UV76CjlRFlEO8BSNS6XlqQMr1I8yDiFnEerBIs8Dud0AY1gVl+LwXD0257h5niJqJ6n3kCSj4xNjgJ+Oz7DkkhtJdU8HwwltRs73cGTqlA47rCuJU3Z+rmqyH0juW73mJZrxwQojvdURE+qxo++CsYK2O4HyaRkpsYWLbLH3QfEnY0tiaOZ05RGuSBViZktyM66j05Q+oTQHG1zW7+CysKt4gzsxndNxkXhGqeR9Bj5Kg33NIxWFKKdAx/komPcyLfOVn6+uQXNpNH3dLVMH/pQRiuRApICB+eWSdQ83E508+mmCh9GBibAmJpI45a5ZW/tb/97eVCW0fjYRSnPYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4+CiPcs+WEan10JX2Ig9Kav8lPZg4LwvViGZTqs3es=;
 b=t1vADwFe1D57L7+0wMJ0DMUHnhiIS89D+QMUbv8FEsar9NfGN9yN6PsZcNdNLdNTObCrug2LzmUyR8VZcupMwb9e/A5/lDFENmCBfByDRbbmxaKvgSZC7ay2oz9bf2nuxHppC2tepepEX1Cq+VWB2PsIu5L+qQa/iKBFcU0ZpXU=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 12:28:43 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::d2) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:42 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 10/12] drm/amd/display: Avoid ABM when ODM combine is
 enabled for eDP
Date: Tue, 18 Oct 2022 08:28:24 -0400
Message-ID: <20221018122826.1790114-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0000b881-c0f5-431b-6185-08dab1044bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlaB5+w+3rkvBf5bb5wfyAveikxBE3nA66QG8pTJHLuzDvtri26z7f7N234lRIj5H1A5B8BMzXxZuFEx0Xc0l7ZkABAbU2SOaOyF9DPompyNsqTbJo7PiO6ljoHc3ec2sgXwFNqO76IQJZx+ubtZheBaMeu1SdWSPmwyvzp617tCSVKZh4/Vbb8JKZ3en15845huosBaykgvvPEByF1c/nwL08mlfr/B81F7xgqg+l4RiVoxoj8IO7lZwUH4NiVsQLpjX+bM+EynBiELD2XuiDZOjt4/u8uYyICT09JAF8PAgc1aI40T+X7WCr7xFxn5VT75HyJWl6qeYXUFNU9Cl2u7N178B2SIwTUDBRLJLlotjrX3aJzxy2pyoHoGH15eG3VZT2Wpt1IGC9nU3autdRJ3WlpfOFV+UQ2j+jl69Eq+33XjJy6rGoyTG/SVEw4bFBUsVD++P4bb15Lo75Du0yJtn5WUoIHpk33F7wXhkicq2jxrF2CX5GF66SzMm+A0b9c6ofXR28wL5TG5nFjdZ0qmfM5CPfD1Fblwf70f6UhfPGWzDbg/NbvuPruM6+B/oMf/Hucw32dbbSddyDh5+YXSoK9rXsOkI4wRb6BC++xG8eIWQrIefSU5j55DhmBKRcqVQxLgmR54/ahCoZrjhV67OztQRkZBeXHIqe76OizVHR1pZ1sdiEgX24a6+JnFb03W+xqcAyP5+cY1smAJbdk726sGtnPp6Ykkihf86cLX71+kk25io4Ogslv1RLtaFXVA8TWyhXkUbGjmDRQAmpreg+U4jVtCfdFJ9HujQqtQUq6J/K0Clj77xw617VRXJSnoI3G3JWyHz/cWq59m1RNfEELttfljqHJXF84KSzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(478600001)(356005)(82740400003)(82310400005)(40460700003)(8676002)(186003)(1076003)(2616005)(316002)(54906003)(6916009)(70586007)(70206006)(6666004)(86362001)(5660300002)(36756003)(36860700001)(26005)(41300700001)(8936002)(4326008)(40480700001)(2906002)(47076005)(426003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:43.4621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0000b881-c0f5-431b-6185-08dab1044bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ODM to combine on the eDP panel with ABM causes the color difference to
the panel since the ABM module only sets one pipe. Hence, this commit
blocks ABM in case of ODM combined on eDP.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b7afada35b24..375439c51cd3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1950,9 +1950,19 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	res = dc_commit_state_no_check(dc, context);
 
 	for (i = 0; i < stream_count; i++) {
-		for (j = 0; j < context->stream_count; j++)
+		for (j = 0; j < context->stream_count; j++) {
 			if (streams[i]->stream_id == context->streams[j]->stream_id)
 				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+
+			if (dc_is_embedded_signal(streams[i]->signal)) {
+				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
+
+				if (dc->hwss.is_abm_supported)
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+				else
+					status->is_abm_supported = true;
+			}
+		}
 	}
 
 fail:
-- 
2.38.0

