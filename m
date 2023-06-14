Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73CFEB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6C210E159;
	Wed, 14 Jun 2023 17:58:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA7D89AC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1fu1Bn4EYz1Mg6jOhKqFvFUPewrcfZiKMju4cu6nT2AA6omtGOKnMDxKoVe9wqiGetv4oceW7tBeJIkjj86Iwx45kRuAkROruiif3TmUFFk5Sikf4FxYXdS5cQw8/8ROtcl9iUHlhsDs/Y2Khdb+Mkl6j1F8oqwLK3Ol3FmoYu3O1mCugP+gXWY+KQBq1fcgu7VNYZ4CQq40jdeyHaZkbCLdNrMJekSJ2V5qypNVAJexfmqJJ1r5hoZCJq2Csl+IoCI+JMvR2GreXszmSRZbIM8A4eacpQ7uRH5cl+BnBGOtL1eoNC7IJfHCWO08ckl2e/xDbvNKrQRAjK3/4YE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ISqmTUAwlQhRPl2KfRHericb8CHu2Yzg9Xg6CA+6SA=;
 b=ANrxdgmcErIyyJVIQRjHfkhpU1sM8aY5iMFJGd432E9+hBDsHcADEeiLEaC3DU1x/ZA4j/fJ+KSElQ+Uk6SmOytxR0mzz/D40M9gMAYenXsHFEtH6pVNnUO9jbu8Ab4n0n3RDxOHEkletBzt4uagwfRttkGmWI4crHw4zwLTIXCp3p05MnmQWJQ5OZ46Cflthvk9YDQqTWiltbYMfCXHY109N31qfQ4jmIMgm1pLgE4NxBKW7gOvgTWroyr1BPIdEbxzVdUO12lauA55vvJ66/1dX1N7pxkZgoCXNXMzT+f75O521skIafBy/yWYOsbfQ8qdqKZx6IsyEVWXE+ptxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ISqmTUAwlQhRPl2KfRHericb8CHu2Yzg9Xg6CA+6SA=;
 b=SuP9JlyjSWqPLFDhhAxxkktP70C+4qbGwxbE+Tcm1L5CVmS8l6y5QyCHatzcNVVOEKDLl1tDBEaW0hUfW5pHhTiJsvl2gvxSqudVeCRLXJb6hwTzDZ8KRqlzWpkiV7uQYe50OU7IrFCABqOGqr93I41/GYNgn81UDU9FOSPygaY=
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 17:58:25 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d9) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.36 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:24 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:23 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/17] drm/amd/display: Clear update flags at end of flip
Date: Wed, 14 Jun 2023 13:57:42 -0400
Message-ID: <20230614175750.43359-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: b53adc41-ea46-4708-ff74-08db6d00f339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZsMAdPvHcjY0gbq3TqPeEvVfNMTaCf1gaaMG9FGMulzVCzx3TeK/Jpzies2tb/EhI61GNgLRM3GbFXEpDwYCbI0/JvuzSRc5Ku7H9/yC6TgouqMTk5Zqczyfpl39i5cO0J061gY/sDD51IsC1G+i3uM95bNMSBZVznD5lzgXT889clUd+MLcL2H9L29ZwG+TlKNtbkwk7aMUmWYxkw7kFrrOXqA9WzmiP/tzV9cZM/EVpRsCpBZXK9s4R9MUNdcVemS5eHzICv6hLS2LVofTVIuMTyWjVQsV67w3o8/D8O8nSXkDXFmiCqMe09yCAmSX91x5MC9OCKcsNlj1jnWLNUUCfBF0WPGBS4IgiyDeqWmR6ZiBdr5yuBEDfjSmiUIRyjB5d50VgkBIVfY+KhyQ5ylWYtWcGxbKTsZFcui0GgC2dZ5rE4AZtLkcG7aq3mDN/86gsR24gI2r5Hq2MUyrZTErrbFvluJOUHpIY7V1FuE01rFv8dNksDwQxXzSRvUT8BhBcmPYcojngHgYC6s0r0RTWFHlsdLWwkdeHhX4/7o4gt6sOG2ByWQ46NjbskSOTlEMnmk5iKPvuKyZhFNKW6DEirE/q+WLFUBac7frSFc+BhZtxVjP4TXj36F4JMQU1psAHe7Bk7+RflE/M1BE7EuzprqdQi0fCHVH5TTmTKgUDNI4b2HI3ywo/ETiWPwJbczBew5yEfL1J23el3h18O1DT5VnHE+XOBm9WravbvhKCxV7+u/hlDG9ah/T63ysi1tknnqmp4qC6zs5jaBTFugi89UVJdRkdCNpSZUUKdQQuiLp3F84/DS6Ct0cmA2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(4326008)(44832011)(316002)(6916009)(70206006)(15650500001)(41300700001)(70586007)(16526019)(186003)(54906003)(2906002)(478600001)(8676002)(5660300002)(6666004)(40460700003)(26005)(81166007)(356005)(82740400003)(40480700001)(1076003)(36756003)(426003)(336012)(83380400001)(47076005)(82310400005)(86362001)(36860700001)(2616005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:24.9743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53adc41-ea46-4708-ff74-08db6d00f339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Clear update flags so the next flip does not have any redundant
programming (if a subsequent flip does not have a stream or plane
update, the update flags are not cleared).

Fixes: 7c2c33690791 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d3d61faeb28..8abf060d5917 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3579,6 +3579,13 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	hwss_execute_sequence(dc,
 			context->block_sequence,
 			context->block_sequence_steps);
+	/* Clear update flags so next flip doesn't have redundant programming
+	 * (if there's no stream update, the update flags are not cleared).
+	 */
+	if (top_pipe_to_program->plane_state)
+		top_pipe_to_program->plane_state->update_flags.raw = 0;
+	if (top_pipe_to_program->stream)
+		top_pipe_to_program->stream->update_flags.raw = 0;
 }
 
 static void commit_planes_for_stream(struct dc *dc,
-- 
2.40.1

