Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED2EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043A3113FB5;
	Fri, 10 Jun 2022 20:53:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0029C113FB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5WU7J8mOIXZr4VdKiubhUZ+AU29FkAF1Ihzqlfi+cm/9cBfrRO/NO8goHKnm1zhMYUBpO69GkzPclaSo0h602H+Dehv66AvbQk/FmelANxTIKCz5bavphcP3lpksJLsGHheMPspUGUl3zrs0Wl/gHyVc7lS13RQO4G4gi8aGxlOQJ/8w3aJkjYvST8elHpz6WXLPe1xS2f3mkavi14bCAL2Prv0SY8I22rK4MoQXWVaXb3B5f3zMkdWgBRc676xLQMLUsFm4wecjfR6u9DKLW3bJAuAOSgSsfBBDMcUHT6UX/DRHTe6JSHT9aR835jTKuVvtW0JUIxx3y6SvPpCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IPWnhYJHDMOqJbnJxmB5Rasl8rrQsm98ZcoG7Ya5zc=;
 b=nepOav5p/1FhLjolpqfqPy2yIYngqNFeHNz+71RKgkT8x5wU+p93w50oqJI9t2JVApQvNexgy/R8Qe8t2Irtr2ET1OeEtRY5psBzNHSNob6/xx3I8nDaBUQaPlqgOrUFzlvmmYsNFfukZywczT+62w1qifFqQX8m65cjM8Bc8TUlNo0zrTUHGtkx4BLRwe0QyxSm+jO4LKEdiduNNBYO5Hchfo0cgd76mL2t65hp8gpJES0KcbvrVji5cpoVgggiifhM+5QRIAVtOOxgwDttcWtQvY4kvyZ3R3wxKxUqz5dxOfpdCtvA+/svUkBn1kTpWNToy/vP7v9+SdvqMNlM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IPWnhYJHDMOqJbnJxmB5Rasl8rrQsm98ZcoG7Ya5zc=;
 b=EV3FIsJ689uSuAe0VTokXfeBBHimGjA7q5vUVlkjyrlTSNwr0vzCNeauj4vaFice8YNcPZEV0Z4QKRUo9CV3RJnloontug9YIjASTFSCo5kK/ovXulWToRgVOrNm28uGKJoch15MrnUWIjegZJMynW4HhoYj7Mc7028hIrInZe0=
Received: from MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 20:53:09 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::34) by MWHPR15CA0028.outlook.office365.com
 (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:08 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:02 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/23] drm/amd/display: Fix monitor flash issue
Date: Fri, 10 Jun 2022 16:52:25 -0400
Message-ID: <20220610205245.174802-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e86098-d733-4ad7-c096-08da4b233992
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174CA6402A7380B136A62DFF4A69@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iSq0rYxBJF08Iim8ATMD1d5qmUeJZf76v0lo+26Xg1kegacestASmhNj3O8aitvb+6GNxKY4Lg4ZixMaCHlGs1yk6iHj8dvq8XswCkDLvK9y7ZAsnue5XYFdsIApRYtnW8a8twMCBgVBEccIdgRkAVNfmJZhnOoMbv36eJZO/QlEWmnKNaLNDDKoRXRo8AzS5cGkVRYOAQm9HqPsBtfwshDvXrqco2Frw5gcuNWv4Z+soCX5lqfP/HXS7+FeFqPOiRnpOp4VI4A4U42PsgZx6QGkUslf0ab1VkhJ6mg390ukmJSf7r7DmYJPi2EgcefjxMffryH0tgLLCZpl45TO2yqJNGCCmK1r/S/YZ+ymiWGtqvf5GInNQyiKr5dPSm9AC66/TnzjAkW32qN0K9EDg2/mX3xDUMiZb3NrI0ksEhyw4QAYCeutN+wWal76y/uhHt9pHGvwqg0P3xFrvclqm0TWqAxdG8z8aIyn2Jvl8zjOl1YSvyPPQ793Vq2fnIB9CDt8Tc/27liMdIDBMMXHcfDaDxqtHhtJJCGuERxY5DklRCZcuSNO8zMIC1Gt6m08ALLaaTruT3dOf57L003AZ5wGZ3KXaesMXoCcChvvyjHa83Ip0UZjjiMdSmJrB8zSLPr1/TvUR/jYu0/cRVCA6y6MPOrHLPWPlZrJDhY9sW7pzeIlbqnYnCwrS2JtTFctzcar6lN5a+lZ0QZx8AbaKQ1+24gTUQLSlCfTVQ+BY+zChWSetkLJiW1yGgcY0fN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(2616005)(70586007)(426003)(47076005)(1076003)(81166007)(70206006)(16526019)(26005)(336012)(40460700003)(316002)(86362001)(83380400001)(356005)(82310400005)(44832011)(36860700001)(508600001)(5660300002)(8936002)(186003)(2906002)(8676002)(6916009)(6666004)(54906003)(4326008)(7696005)(36756003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:08.6329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e86098-d733-4ad7-c096-08da4b233992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Cc: stylon.wang@amd.com, Hansen Dsouza <Hansen.Dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, Shah Dharati <dharshah@amd.com>,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, "Shah,
 Dharati" <Dharati.Shah@amd.com>, Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shah, Dharati" <Dharati.Shah@amd.com>

[Why & How]
For a some specific monitors, when connected on boot or hot plug,
monitor flash for 1/2 seconds can happen during first HDCP query
operation. Ading some delay in the init sequence for these monitors
fixes the issue, so it is implemented as monitor specific patch.

Co-authored-by: Shah Dharati <dharshah@amd.com>
Reviewed-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Shah Dharati <dharshah@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
index 1f4095b26409..c5f6c11de7e5 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_transition.c
@@ -524,7 +524,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_dp_transition(struct mod_hdcp *hdcp,
 			set_watchdog_in_ms(hdcp, 3000, output);
 			set_state_id(hdcp, output, D2_A6_WAIT_FOR_RX_ID_LIST);
 		} else {
-			callback_in_ms(0, output);
+			callback_in_ms(1, output);
 			set_state_id(hdcp, output, D2_SEND_CONTENT_STREAM_TYPE);
 		}
 		break;
-- 
2.36.1

