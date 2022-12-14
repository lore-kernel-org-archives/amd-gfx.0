Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7085DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8422610E47B;
	Wed, 14 Dec 2022 20:22:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E286810E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLHPiae1/GAbzY74vguiQWvHZfmsbWD9zzTFyTb67eKRK8enjuBHnygSOd5pUfTYlRyKzAzX3qIuLOZ91S40crkp0CfdgUlXDLB3U239UcyQnbUzk4wGD30YH/HHgC56z2HHlPIY/RlhVYoM2pxUn/OOk9Nxe70duI/RyhD7p7+LU0wDvkAPrK9Ya4e7YSd5ni3Nc4qD+GdBf5f/SIwS85fVCErbXcJtmsTCjFAxCoI++WvsmssPp+hE8R/OFD5SboAdQ8wN0enBz0DZC+9QWYGhdnBg+Re934z6ps7S7+W5pHeG7oLWAIzfM4HkMyYbMib402PpCImEFPecjbhMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKmPKgd0Z8X1MgYLFth8JmfHEE3ebEIcNRDLOxnPQJo=;
 b=FrNOUcC7pPLrngUmN0WqVYNy5L20M+0EbKiVvRbclVJjGVDPFweDD856AfBVyNh4MY3/X/47vvWnLmOPFymzAbNRZc2dZoBAm6Nb6nMLrM9B8BkGmh9yxAgqkgmCrs57iiSFSq2n2tRY4aCgr8wBWxXy00kDbzmYivPLIdYehVQoAX8330ugt09kA4AzG/6WCx3cK0n23Cty/Fs6kYY1hbyvFp3w7XYeFMMEmEARI3TIj6VOwQHflcQu2iJqzmvOoasvMBOToYX74ao/mRWpf8D3b813y8qurBklJsMrA0xVkSenkcQp/4Fc9FMGTeszejr49f/GDXsCt5HKx5JL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKmPKgd0Z8X1MgYLFth8JmfHEE3ebEIcNRDLOxnPQJo=;
 b=1OBIvGNsPkAWDp9i6K7N5yIXwVSlOw4T4EqWinYdbFB2DXO7K1BSTdNoquKBYc3tdiLB9Hr3UG14Fcdk2w9S4auv8euMU99wWqaGzRH6vpx6Eme1PB4qxZ+srjV4CyjdsFW0Cl7MH+HfKJs/HBhqYHXQIfw3bqrPqmsUjvm/IKU=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Wed, 14 Dec
 2022 20:22:03 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::a9) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:58 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:57 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/18] drm/amd/display: Defer DIG FIFO disable after VID
 stream enable
Date: Wed, 14 Dec 2022 15:21:32 -0500
Message-ID: <20221214202141.1721178-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: cd252eb6-f464-4615-083b-08dade10dc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOkICx3bOkl4ZFqSmtPFYC9RNsG+c18W+xA16KrOcZh6mL0P2mNoncz2sPxzvmAy3cGW51iAQaGGADY6Pn+Mp/XyE+4CJSbuFpDc9Rb6L+Q6Gi0tFUTchyAwgwIjXbTcmaD4v04W5DSTRqurdwI+4EKPHhi5Nat7+ybJMnrLaVfLyVCg5kGbfDZHbDxNTx13SJ4afje9VKtnVE2eGTNMRFyFQc0xSc5G1J4Cfvk/HKOecHWthDDJA2xG3hItxeJcYC4OvpkdsybuMV0GS2nPK5u1ycB6tHPVLGpmI5mDg0NbIrjQiEAeEkf3DRGYsQCeKX1McqDsONRwdL9a1lBDWMq0SAX9eh8cao62HezaZkT6CW44NpB2Q7fIgKbVFByRF2/wJ6KWryACd+YybsehjIouGQmFbZ2S4AkwwBDvYZvqvn9c2+G8K502T01qm4VcR5NGDeJ0BW8AGuIhRe2WmJMm4t49LdJNE+ksbY6s/0WpoUjVY3HTG2Rz1rNdAU2lhp3H/d2hbdH7kPSKBHcfuX7JjWuqM/N7xbGDUlR1VsNDqbDeGZM11BDQmo+nmYL2Cf9KYD09EPct2VSI4vqo2SWQYpZpWwCJCYX/qiyR1XwMt4ZewkBs9oCUoHc19h6aGgFo4Ucpv6RJx6erqkj0xNkn2WoEu8na6GIup4JYxQqi341all3gX5p1Bgq6rEWtmTvKUNavbiryNWFFAXzGVBJd+eCuSAK+/puxbhJ+5PX6bS+xBE9/7I4EjHSyGRB6ZgSUkyZsIeMrJleW9Zsj15O9aqY8u5ACms/ikFzuVRc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(8676002)(86362001)(44832011)(70206006)(4326008)(41300700001)(40460700003)(8936002)(54906003)(70586007)(316002)(5660300002)(36860700001)(82740400003)(26005)(36756003)(82310400005)(6916009)(6666004)(7696005)(478600001)(83380400001)(336012)(426003)(356005)(1076003)(40480700001)(47076005)(81166007)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:02.5963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd252eb6-f464-4615-083b-08dade10dc91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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
 Syed Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
On some monitors we see a brief flash of corruption during the
monitor disable sequence caused by FIFO being disabled in the middle
of an active DP stream.

[How]
Wait until DP vid stream is disabled before turning off the FIFO.

The FIFO reset on DP unblank should take care of clearing any FIFO
error, if any.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Syed Hassan <Syed.Hassan@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 38842f938bed..0926db018338 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -278,10 +278,10 @@ static void enc314_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
 {
-	/* New to DCN314 - disable the FIFO before VID stream disable. */
-	enc314_disable_fifo(enc);
-
 	enc1_stream_encoder_dp_blank(link, enc);
+
+	/* Disable FIFO after the DP vid stream is disabled to avoid corruption. */
+	enc314_disable_fifo(enc);
 }
 
 static void enc314_stream_encoder_dp_unblank(
-- 
2.39.0

