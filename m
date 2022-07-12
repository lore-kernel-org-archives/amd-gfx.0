Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6803A950F6;
	Tue, 12 Jul 2022 15:42:35 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107F4950F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvY1WlLqP4vNk7iXirR1HOOHvVKwM9o0Pei7T/d8KjHoFgAJDEz49PnjzI7Sz5R7plN4nb97590jt9Dc0oGkEGzuarJ54mkMZtnotdOZDfzQQ3w4o7CwBHx/4xC+Ai72YpRLlQzWlIAX+mUphyHauqbAu0Q7f2ymeDvyqLzmZfPHYYvd7bYBJHczTKXriN2IW48bTwCdSGrEnrARxSaqEFGxwawqvjCh+h3BtFBGL4VyabrP+wK7pZCC1E2mbBX1apkP1kHrkNlrkqZqJXGO0mGwCRCfTLyxbDrUcNWWZDzXItEVRAKfm1wkQg1nTY1K9bxHdgnh5QLTUqzJKn/LQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbjOpMmnpgQpxah+jGz5yBHmLm5VL511z1vxL5/BL/g=;
 b=n1QyymAn0Jv2degSUt+EVtgb6vkCgcKp9rzVtDXXqCPY/7I7NvRGUTstV4E4CSWcLLrSw51VEE8v2S/sHA0gJG8p+LmvjhTToeQ1x3LBmnlaY0dBXMvyjeTWqQfVLBYGCYA5QnReOl+zMdyIgT1BD9zEVEMXp/vB/VCfQSQxiWjJ4fZN/q7VioOnz4kVS+1TrdmayR4TGaBDwvR02JyT29u3PXui4fUTjCT2rUE/Zeqkn/zcAau2H3mkif4ZJvRRfPB+EYjkM0D+GAD3hPozEFCvHSibgKsCC/j/Z3fE2a1yypDJJVCJHPp4ELa2M6SLdtj3DsE9CtLVsx8ZNNrT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbjOpMmnpgQpxah+jGz5yBHmLm5VL511z1vxL5/BL/g=;
 b=APSl0MWmrN4jKCcYms2SvhYJjFi8G9SoddW5w2PLjWCoX085kBloC79oA0dBHY6dZupUv4mQgEMXRadtTGF0NRJZ5bQ7f2hGFMoo2UHCZtWZ6GWryPOwHuT3f8CfXW+5ibz8RWPGVhP2Jmd+bZ5kk+u7Y2RhC1ahqUu3s5g0QBU=
Received: from BN8PR15CA0048.namprd15.prod.outlook.com (2603:10b6:408:80::25)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 15:42:29 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a2) by BN8PR15CA0048.outlook.office365.com
 (2603:10b6:408:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Tue, 12 Jul 2022 15:42:29 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:42:17 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amd/display: 3.2.194
Date: Tue, 12 Jul 2022 23:42:03 +0800
Message-ID: <20220712154203.501678-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bddb1c90-a721-48c9-ae40-08da641d20fc
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6027:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXOFviWVUQN1s0Tn7UQapXZ6lbwKrCBWCy32KC9EvcJRPfoarWK2/tpVryaB/jUUjnp5WXN0xJ0/LtyGDWtTlJQ1MHpcD/FY/hhjyOWwm7vz29VSHoNqxLfH/cPSr25TzmH7Meapdcan5rfQyF+NK+JQBZi7OauOOj8gPtzKgzCLNzlSm9EMdsj6hRaELI4R8mcvIdzN3AyGT27zoGgMMIMP0YoWYdbP+iE/MIb/DZ1TB0WJ+HVjyOxivPCfKrd8GFHSSmVhDGo/RHUA8wNOId9XNi9eo7L3FpgxJXaeRllubVQqbvgvRr4TcJCcoXMRmzmCrBWImgD3lWgWgg3Xb/0nnDk6DHpYqLkVxYXIAr7hQoynoC2qLQjyFEN8URIN00lIwQKEsV+65pTZgm/3d5ydIIsQjImhG9+O/LbAp2fkoigp6k7jKMor0a9DHi1V1A9R0Zo4tjcNavwaVbq1yIO3Ssz9oCIGENLMowtlgUNoU5uxSEH9z7YkTdDKzLo3nK1OvLiaBADvnAoGJmbN0Gz/k7EOi/aKuhJzbCcu23I5+yYnRhd++c5rY1QOo3fX3O7tmV2CjtP+xgQ09YCFyjgxNylgJ0Ni/YbzBc4OrDyDSyo6KO55UCBWh/NtQvWZFZTLIggEYCK3XRGTspFqnm28QsbvqeZ6t/wnJTy80nZQP06/6fc44lfwLwTV1bQO9oxaRvAKFrWbatoNU8ofxY1FCdgJjtnTbkPPOG+xVUMrXp3QJFR1WuSbqLskQ/DNszmfp9bwPeNG6WSQfTKGPSl5mL/t6/lZvH2YJqaeVTjSDIKVuOmBnLL1rG6BccE6tmG0lY6Dju0H/A8WYshAs58aEIekej9AFuPhYsnZ6VQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(8936002)(478600001)(6666004)(7696005)(2906002)(82310400005)(86362001)(1076003)(26005)(70586007)(44832011)(2616005)(36756003)(316002)(83380400001)(426003)(16526019)(40480700001)(81166007)(336012)(82740400003)(6916009)(4326008)(47076005)(356005)(36860700001)(4744005)(8676002)(70206006)(186003)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:42:29.5825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddb1c90-a721-48c9-ae40-08da641d20fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Fixes for MST, MPO, PSRSU, DP 2.0, Freesync and others
- Add register offsets of NBI and DCN.
- Improvement of ALPM
- Removing assert statement for Linux DM
- Re-implementing ARGB16161616 pixel format

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 89a3cc8f9274..7c42377f0aae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.193"
+#define DC_VER "3.2.194"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

