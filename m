Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28A3C77B79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E02B10EDCC;
	Fri, 14 Apr 2023 15:54:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E025D10EDC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1+glKVdnRnaW7tTp8fNiiR3jn1KrGFfEl2j1hc1bKBEs0BpygtcbIRtU7nEAenggSr/xZ6ApqDhCup4Le1441ykcCCHUooFJdupev4vuEhcs+mylUspH6ImaMObMejtWFXosjGmy9fqr/hl3WaE3LrWdOQrTZkl3qt76qRBhHl42VTT2DjvpuH55iwPMbxuyV8J0TcoDv/EL8cN7M4GSz96BItey3+/Jal5GOT+IP0x9OA4kz8Jx2XseGEeh2kx6xiBgzMB1imbQcqSAK5A2pRaCdJCvPWMvS09kCXBzwGHboVbugD8u3AOsQ9c9WBcpEkpDq8Q118ON1whGiaCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7hxVqjxIl047XKznjuEIBZDu6284jpFDhFv7WnV8As=;
 b=BOKYluSvbcDYN0bX5fP8/06eSf0V4u4poAGlt+LmEdnKXyJPOxQz51+wZEoOaIR6TxTebPRnZ2RAElcADXI73Y5xe22t4qhQmqnc7wfpCwOMZSQiJmjF9Vo5+Unc+caYa+qeIua0KqONp/L4KJM6q8WnTVQsCIBipSJiRkcDDiVsCDUmLypHUzM4nGoOxtx6pm6eiw0o7ci96KiCX9o5yhU1+nzJNJQ06+DMzw4Pq8ieD28qIIsTUmL5yivoyILVgWEkx8HJJJ2MoVx23RPXaqmGt2LVSlYb1ltxWwmzjv0ivdHbCrbn/w0MEoAQuz38CnvpSKT5P1hh4oAcUXV+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7hxVqjxIl047XKznjuEIBZDu6284jpFDhFv7WnV8As=;
 b=gtcnhf1gLe7VcKuzGKAxWii9PWeuEOA2zQZWv/XVGJdzOaKU8kSIjfTXsGLu/CzhAQlClca85XDpCS28iFg/MQNOWofx3ealulbEHiBoMyouyDxEcBYdNMA0ZZOwK4+O5UyR8O7NS42yMoDF4rg8lFpSCTUr8oGHxm3ZMQRnCAM=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:17 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::4f) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:17 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:15 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/66] drm/amd/display: Reduce SubVP + DRR stretch margin
Date: Fri, 14 Apr 2023 11:52:44 -0400
Message-ID: <20230414155330.5215-21-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 07590987-0d2b-4b34-7488-08db3d0080a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/RjE+NlyAMyeHZXOvNkuyuQQJPWigjzrpbswMXab6pnfid6bP+xRcOwXXUJqMgbM/8DnJhkWeVBobDcY6CPB4Ed6WLqnzVlkPmzyLiFarTO2HWCm8kueRSyo8iC/Rsn81xp1WSpUvI58dDhRhB6reLljyo0dD3oSCz/S8ase+dttAaAqtNnrfL2Fpv7NRQBknD7JG73QsDH0HVD/TrpN37L7P1P45g3pPycc8pmKguTHB+JuZvGoteh+mNK0YzeKWhQhGlTXsYzhqkTudUBZnEhcHLzsRpJcVW3GK3LzCFwUCSYN8dpxmMq3VdBlWGQL9YbBzqHinSJwrT4h/jsiNuWC4WAQ1bksttf2TqZM3VPxNe4ksD9SUuUfVz2Q2cKJ22IP/ypR5k7GWEiIvIZQHSBzeq/43uOl8+aUJtyn70BhTA57U2WuLDsHOiJ4JF7XjXj+pAXINq8SnBttQbcHi/sZKRtnuh7Mj4Bj02SMf6KOPYlRfPK6ZdfNJn1NI/510/IhpZMdu9b4OfwpgeqVc5kxUH2XF5sNwEXgzKlHXo+tLLrG5TDXT2AA28kIioc0t3Np1+APcxBYGlw0zJrQ3xcbr4bE5zFELMG5Cm3dKcLJkwgB27ZXVjwa4zraoUnQhhV9AzigHliixWTJMV+jorCS02T6yq58gQ6NZj8mYZWZFvOWrEmL0DN3rE2mLIoS1yoBsXmrLmTNlBNUFPTCO0dtu5M0QRyNkl3RTXl/OY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:17.0144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07590987-0d2b-4b34-7488-08db3d0080a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <Michael.Strauss@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Having excessively large margin causes failure in the static
  schedulability check in some cases for SubVP + DRR
- 100us of DRR margin is sufficient based on a weeks worth of
  stress testing on different display configs

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 181a3408cc61..25284006019c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -144,7 +144,7 @@ struct test_pattern {
 	unsigned int cust_pattern_size;
 };
 
-#define SUBVP_DRR_MARGIN_US 600 // 600us for DRR margin (SubVP + DRR)
+#define SUBVP_DRR_MARGIN_US 100 // 100us for DRR margin (SubVP + DRR)
 
 enum mall_stream_type {
 	SUBVP_NONE, // subvp not in use
-- 
2.34.1

