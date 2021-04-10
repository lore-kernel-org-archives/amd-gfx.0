Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095BC433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DD9610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DD9610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A33D6E4E8;
	Sat, 10 Apr 2021 02:04:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771A16E0E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbYVDF/vo1Y/zNYG9P9L9airtUBd4DflSJW++RZesJtOeKsY2VLx57zAWSdSCf8q0X5kr2hZ24nxKLIYfyUdGNFqbuw+8O6KHZndpXPj5YAX9eemHYVNn+XXu4iNaOivNCIOdLHuyV8GSi7w+f7v81/eOxP2yPHHzVOv73svkYtM5SpG/OEh2J+ecCoSNhnQUldnF1BNScYEpDr0JrqGOueUL2p2Sn/jDmOxPVWKCEgbfee+Hy4JtRjIi5TTgLqj0XMxiJxOwAMj+6s8zI4rPPdS8nJn7T65YB7KYQiVNOcB1r3v9TG5bhkdktSgxJPFHb6rxC571nDKkmT9m31ZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy0LMIgtBHTyFL8q6k40427V0S4zxfReEDplFnmmSPQ=;
 b=goSWsAIRmjhkQMlLB2IvnGd1v4C94yLTrIXunDAAyhplcnsz/mPPUi3iqO4E/F+HX3y+28WYXVNZMNfW+5ZaMbbICDihSUhFhC0AydgfFB7BsALcZo/IQJ3sJvsqDc6h2PXF+XhWfTyicWNtR8ohmYHWuKzPJlnogPOxpKhLNy+aMP2Bybbrhjtu56kTEeEKzTStMzyDWNSLBc4mwAOLf/HNcmTTmtQmr4DfJ0CuCD++ji/VneSZqaVEz3HpN9whGx+GSVkCNBGrj40eSQMySPLbXwFpyNpYACuyvhoKAlCsMa7oUaWQx0q4+Uoeudx37TwEVbb9Gdj4AzbFOHLHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy0LMIgtBHTyFL8q6k40427V0S4zxfReEDplFnmmSPQ=;
 b=JERw3HygaVE051q/N4HXPppIt+Q3Xs9hSv3OBpv3E4Zw4r2dT99pA6YzsBqsyyBNoezn5/7r8u3kHqw3PqOLoXZi781vSgo/wsmyYuNhOwfVv2/uQAFdi/C9lkTynQrV8SbzHRhXb3ueU7T1rUNQzF5JtKGd0vPOwwLvN+Id+8A=
Received: from DM5PR18CA0050.namprd18.prod.outlook.com (2603:10b6:3:22::12) by
 SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Sat, 10 Apr 2021 02:04:48 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::2a) by DM5PR18CA0050.outlook.office365.com
 (2603:10b6:3:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:47 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:46 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Set LTTPR mode to non-LTTPR if no
 repeaters found
Date: Fri, 9 Apr 2021 22:03:51 -0400
Message-ID: <20210410020401.1100228-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c77c0a56-7b9d-4d27-f2d2-08d8fbc504f3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4496:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4496F8DE359082BC029E9242F5729@SA0PR12MB4496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ekzsqxgg1eZj3MYKuS3h788dS5Ihef9G8yIwme+LRB77jcZZ0+U8kVfVpkBMaxsxu1FeHfkG2PvpuEHCdj8dgbH9yaemW+MzeuoQCx+6c37EwHyzSntPHEvCjIcp8JBqzmOqWg2OqVxv9BwGa8G4ZlnTGB5exn/JCrU4TrpuVW/QKmKMmZIg25M6CUa2neDn1MoC9jIoOwVyIyjYwOodLhhUPGGUZEp38+JKkAdyvvZSPClLTAsUiF8OQ/++4f8AECTy1fE4hknfUO59I/Hws6T9jRs6Ae6vX8WR9gub0iEtTxXYov9Pmf4d1qrXgehdtN3kfxYIKRPn68AAT6rC88WZ9bzHyqDrS/VEOhUVEuSsNNy9x3mIbYRhkVRe8LgqMT4zZsjUIIedqrhnyUmL3TVop0eouTroDDjdkMq4TEsB847UNrietWR3g3cJNb3zTZjtGmuRhkqlLajQcWj2rbiWH+rzVduIk/D4RU6FpCH/IllUbLvMq2eM6xG1WrzQBrWQbhC/gJ+3GSHoXyuCNstHbLkRfeZZKqz+jIOUTlsLL6m27tkJ4/eo1tLNj1AVdZrdR3gjoNFgfjsaDJzqosC5rP0Hd8vFhB16WHoQ4RRc/JKFWMUxJucnVXJvWkHL8SLElAvFTXeGTpUrIopFTIzhQCAphBWPS68OPpzPESeCm14J7YuEO86M6LZ/nfQ8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(36840700001)(6666004)(82310400003)(82740400003)(83380400001)(5660300002)(81166007)(70586007)(70206006)(47076005)(1076003)(356005)(4744005)(54906003)(2906002)(4326008)(478600001)(426003)(316002)(2616005)(336012)(6916009)(8936002)(36860700001)(8676002)(186003)(86362001)(36756003)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:48.2091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c0a56-7b9d-4d27-f2d2-08d8fbc504f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
If no repeaters are found, we do not need or want to attempt to
link-train repeaters, as this could cause bugs.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9d6a8e728317..e6f8f3c255bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3582,6 +3582,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
 		if (is_lttpr_present)
 			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+		else
+			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 	}
 
 	if (!is_lttpr_present)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
