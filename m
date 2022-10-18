Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5534D10E89D;
	Tue, 18 Oct 2022 12:28:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DA710EF28
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euRaZ5VnkbJUS4SBy+CZoheqnwCkGfg2fgMDXodlaGprPYOJ2DwG0UG9+HQGhWfZbtVSW7cRLpXEaeKz9vU+UkuU7f7A4F/6IkAjFfxiTgZSUf/6Nwa1AMip5ma2USh5DBOEkuT8sMcW/p3M8MzVPDGLijDuQvQ5W23M0Btj6Y0VwjxbLpKWq9HeIxpA4gHQGgSGd8FeZ8ggbN4AQ/cyQtKKjXEuB17KdL0pIj0fV9odulRYbnRZ+jlQ4hGNbzbIaFUmBuu377+U2z5Eplp47Mab/WrCcmf0Zr3v3XO5SZTZXjCDfFz6gbyjoxG7osq3byB64+TVZSQMS5uXxPbJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofv8P9ZzXVnGyX/Az76KWvuryzlPZKB9mPitb/s09oQ=;
 b=gpX4oxpSbh3WOW5GatAHmiQ2B8w17UOqyxvnja9dAspMyRMLl/gx65t+alo/C1g/mM/WkatrFWUAt0fVD62F4dPRq7ZzInlhhaqcm931IEOSOToIOv47s/EcphAV5dqt3xCCKAYfL3OP0VcDQC0l3yfzsNY7E+f62o/lXqQBYjtmqZypqVXedvkilnVTzodHX7AX7bozA9ajgXmdQQvx6+7/Mzj8IRlell/hsBVwhM/hdwodzFh4yPqFKKEukA8Cr+6gqhMGJKosUx8/5En/XBBwjW2korN3ufhqkCAIFGyJHlOAdolBdcmc2EKt6QqHeJJ+eB4f5zaK6iPpOuY5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofv8P9ZzXVnGyX/Az76KWvuryzlPZKB9mPitb/s09oQ=;
 b=DqZ8UR7WVfzxJc/nU7/9SYIVhJ+czfpypmcMw9BQswqomyU4RUUSJb1tV9m34OSfcsEX3IwwB8YbR3E/8iafboBNBlXzu2zg4zD8lF3aaP/ny1tko1Ni06osEwA6JqZVIPzz00ZXbZaVC02xCa9CvYd8Jf5FHCjZYzcL4Qsi4S0=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 12:27:53 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a5) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17 via Frontend
 Transport; Tue, 18 Oct 2022 12:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:27:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:51 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:27:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/12] drm/amd/display: Check if link state is valid
Date: Tue, 18 Oct 2022 08:28:15 -0400
Message-ID: <20221018122826.1790114-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: fd649bd4-28cb-4316-35f7-08dab1042d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bSgeyAG2k8IixP6DBR8NpVvRCsZV9gc9kBf1EBmCJyjk5HN92BfjTA+OVhDRXrSSDmvp9llUIbWCkCtPqJAz1sOBtn4N1GR5hKlelg4V1f9LQCe0YFg52vVtgwyWE9BSOC9GliQPeoFqHJETTR9/4wW6hRvHNiY7UB/aHhtaNTKaO/sL6wKbXHUrD8tjKbMfbIHT9bgaQdcgAk/2BZi2h4sUBY990TYFIYVEUsLvsKG0M0Lr7fe9TpzT5PtcgVNeEEPm33dvKgXjY3TcPZxngqqSPfvQXtML0Y2D5NPs9z1PNB7wisxBjpwNeg8XpUiJoydDpTlrDbp+nTr61Vr3Gys/rsQZ4YDvA/ihZuX/Vmx0mOFL19wxLwGBjCzu5MBZNVb4HTxU0tG5NZhY0WiMmwfzSLLYZxTweFdVFLG72urPbxPLOuyouf4ySN+S4qlNfcE6Br5dyHEDToVEpK8BHuKqYdcqifKHT3vEFjSW+8XJgxn8cugzFY80gwcPuZPkQgiDurY34k05R3bsfe2OFo3Dn4lPfVGYta+KivFt2eb8vFkVudv8IbwCnMgQKg0Fam9Zf7WTaKPyzqDVdFotuuWnvSteU+v6EklmZRz+nT+aWcGnA8fAo1ab5WJTouHzQ/qkpOwPkYxOjJD7G7faIBrsevdhFlpZeh2rmP2toKeI9/t13iUENhT0FAEsWcGfYvGpSoE5uqNQA0exeeXlDN9jXZuJ63qIeAzDGnkaOGcZlMvMppibdnUH4QnC3E+7DuDJLLaAoSEDlV/CiLSIyJq7GVB4ytO8i5vQJsUD0TRSpZK2cvYxQ4qxx+auqRx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(478600001)(36756003)(426003)(8936002)(5660300002)(82740400003)(81166007)(336012)(47076005)(356005)(86362001)(36860700001)(26005)(40460700003)(54906003)(6916009)(6666004)(2616005)(186003)(1076003)(40480700001)(316002)(70586007)(41300700001)(4326008)(70206006)(8676002)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:27:52.6403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd649bd4-28cb-4316-35f7-08dab1042d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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

The link state is set to false if there is no link and local sink. Even
though the stream state may not change, it is desirable to commit the
new stream when HPD goes low to high.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 997ab031f816..7b576bd24cb5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1500,6 +1500,8 @@ static bool context_changed(
 	for (i = 0; i < dc->current_state->stream_count; i++) {
 		if (dc->current_state->streams[i] != context->streams[i])
 			return true;
+		if (!context->streams[i]->link->link_state_valid)
+			return true;
 	}
 
 	return false;
-- 
2.38.0

