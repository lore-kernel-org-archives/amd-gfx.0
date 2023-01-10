Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4087C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DBC10E60D;
	Tue, 10 Jan 2023 16:58:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0466810E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLNqU6mDt+Lhaba2PHZ2l67gX/NMI2fWMf79aNCmiDznF2Ip4wmOcRE3wLZ5YQcNjL+W7SRI1DkhX/OIeAniBJq5HFDCACv1wVSkNH0MZ54JfN9yrPRuH8gJc9+qfrHTzGYxJYg3qEG/VHOyEygYybAyW5cN7AsEea5yhE8x+4owwZEOhQHQiX0XG7h6PSgR+gwiFYYujIEkTZWVKsUFIhaT58+N5ETGeR8rGZkpu1gtCmSgLTVFLadLPgSfracyuJ4cpBqmtcxmtf+OndHDNuyE6Cp5w5ByNgfdR1QIiyn5CGuvzK54bcfPv6gcbg7TAIFFsgv6sfyCWw+rrvc3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yINAYRVN9ZUNvA96wxiCBAsFY3U/1vzCKQ6PAsNpp0A=;
 b=RF12SMDbi/sJ0UuMTG0F7AONtHMCRNcT58SYCPR221dyBXzdgAUn/mN1Nz/fUfyjjQ33QCKxlSzz3Jqkra9u+Bbt1SAu/JDdY5Wlb4pvdPDM7shzMV6ENuLbqKeqC1VMmNuuc7CvrbT9DO2zZHFl640e1+XU/rDLHqA+rsBS/0bxWjR7jb4W1ApfHUVtGTN0DYogS3afkk52Rm+LysabikKt8fjxdm/R9/mmgj2nihg5nRQjaGxtPXsh/CFCePjqNER+wtPcXy327jSdw2w7HX9X79tsli7SUzcsPlefyYIj62GNBVorzvsme9FTrXgtMWwVOtPV58D9bH9+/evhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yINAYRVN9ZUNvA96wxiCBAsFY3U/1vzCKQ6PAsNpp0A=;
 b=erJOZlac2pMVJ4Vg3Xv5zZe8hE7bTjx8UNpa9AMzOef5wRf47KCv19VaqCLh/URo+SlB7CwrLZfj/w0eeo48YtR6jQlNzi+j9C6kjIWJR0uM7fuh9/JfqzHdN3KZwgMjwzWuj26G5CEzqOHrzIpzBsR+I5i8VfHt/FsbDUZZj4U=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:02 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::8f) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:02 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/37] drm/amd/display: cleanup function args in dml
Date: Tue, 10 Jan 2023 11:55:14 -0500
Message-ID: <20230110165535.3358492-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: da62f4a4-821f-46d0-ce07-08daf32bd607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t4U399DNSQqrCrOizRQz4353cToH+BgN4QIFIWPMvefQZY5+Foabn+R2kZGErxb4B30UmRTEZwoGcU2Vss2lDl60mF6IROd0bQu1Zw49ohhi3X9t9ebmzbGxNzo9smfJ5cYTXU0UChSdY7f3RithPIDfoGXMPSswihaL2tgzAeWsxB+KZ3kMDKswhJ5RmQvNAAgt+xAkp7/pmUZ3Sy9s8CgeeorOAs15pasXQN38408sW43rrRxmBshMFGJoVe0Bl04DYUE+TGP6pMRi4oWWIA2+xufgz3T8teeo3OqI3PVfNpjeOkg2On/siAPUrK34RnEQ6zcRMBU5rY3j6rlhxUSUbse7lBuBo4c2ByNfle79v7ecH95vdlPjhYu/TU+7LAHzJeCru2qwmyDCWougACG3FkrID7A2dFZ5JDxaLWozz7YCHH263xEPJCYwgzDTnj/H/bKMNWlHy2yGm7VG4pYc6WrWRFf9nIffttG5/cxF9i85CccYDSaTWye4sTLzHBt9H0DmFMQceMZpC6X/esvuxo1lzhdphIBfHIIpl7DFssrmG13mX0uJHI2isgXpFuLsXbsUEfLoVzm3J/sLu+wQrECGonDFkFTUStEJODbH85LlZV9czhk+m1t8jqzpwGqvWe4rq30di8ueUX4JX1XASy0E9Z1lMYOxZmGTOKuqLaHw3tm2kjPvR1rINHboPK3xqp8y2aGiXm/eMgijjIAuzV8suMxcsRhxtLt6jE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(8676002)(54906003)(86362001)(6916009)(70206006)(83380400001)(4326008)(70586007)(40460700003)(41300700001)(426003)(5660300002)(2906002)(8936002)(316002)(2616005)(1076003)(82310400005)(40480700001)(336012)(16526019)(186003)(26005)(47076005)(6666004)(7696005)(36860700001)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:02.4919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da62f4a4-821f-46d0-ce07-08daf32bd607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

Remove array size on array passed to CalculateDETSwathFillLatencyHiding.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ba23b199afa6..a089be99b2d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6254,7 +6254,7 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 		double	PixelClock[],
 		double	VRatioY[],
 		double	VRatioC[],
-		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[DC__NUM_DPP__MAX])
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[])
 {
 	int k;
 	double SwathSizeAllSurfaces = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 5c7196d1ddef..d41c4d8b0c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -1160,6 +1160,6 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 		double	PixelClock[],
 		double	VRatioY[],
 		double	VRatioC[],
-		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[DC__NUM_DPP__MAX]);
+		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[]);
 
 #endif
-- 
2.39.0

