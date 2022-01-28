Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC626C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E59D10EC09;
	Fri, 28 Jan 2022 14:05:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FAC310EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY/Gze6YR68ffGo1ayDc/UAzVxKpCkAlbTOWXfTkpLUGi8Vig+08yPfzZOUHZXfbtNhrGEgmZRZgh5XKnB603tuZd9qd7OYHPjGAGAk8+ey74D1caNedmaHDX4gCnEyXtJ9ka389/i9rdG+YyEmVLAsLbn9YZIU4CgWXfRGWZWLMni0bGOchStK33yDq1vrbuGJnZVhy5YMdWNtysQT3YbBB4uoSO9FW5nk6jBlmdVJvZ6AUd1llSe3oLILqZm1H12RLG/SCzp7hOCWIVz66j4r4FGMc2g3jjbJxWtxrIlDnpAx8g6NonA3bXNrgunp5bHv8svXcfd/mcj92FaO/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeAxJilPCOqjW+hM8wY2QLyAdU7tFkUZWbYxI299OII=;
 b=Hvvaa90XqT2WEEOP7oFvL2dVY1TcVhbFsSjiMET2PrRxy+eClSCQYYzAGdgayYoLIYjO2ag3qOH7NhnPyovAZ6G10IT+mPE6OHkr9vdmgvoX1/H800LSYoLbDArSGo/LwgctwYSe/Pt+bOtHK+9M2mMV8f1v57SsvU1AFMWCu5BwiFUKs5xtj0hl1V7M0kiJnWKBjeHLJ6Tk7s5ZMRUWvwckseUhl2Guf4efhXSdbj6Ye77dB30BL0EvrTRFFVbqrbkJjsMf9Z6iqJVdZRp5vqBeJirs9SUlqaBzTBu7o+X5MKXRllnczQVwmxRPkaMAGUY237PO7IOa5S51UdnciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeAxJilPCOqjW+hM8wY2QLyAdU7tFkUZWbYxI299OII=;
 b=S47KOszTXBOnlJpjPJHguVgygPYs3vUhQ21x+I04CwsX6Jj0L/MjhGtPim6ri1wlswFGbdcz9zQkjIEqKOL1GhH3gOmwrhGsn78TX81xt3v6RyCSnXudCFqv3udCyDmTnvV2m3Prdq283o3H2Kur4uL/GxszACee0lqDdLrKqqs=
Received: from DM5PR15CA0066.namprd15.prod.outlook.com (2603:10b6:3:ae::28) by
 BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:04:58 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::dd) by DM5PR15CA0066.outlook.office365.com
 (2603:10b6:3:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19 via Frontend
 Transport; Fri, 28 Jan 2022 14:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:04:58 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:04:53 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/17] drm/amd/display: Add link enc null ptr check for cable
 ID (#2597)
Date: Fri, 28 Jan 2022 22:03:55 +0800
Message-ID: <20220128140411.3683309-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54fc551-a620-42ab-77ac-08d9e2672b5c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5242:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB524217C5B8EA080A2AD26ED5FF229@BN9PR12MB5242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idoPkrC1r4/J6ss2eE/kQ53mGnPJBopTzQz1Nf/0zea/J2C9om70Ia6c3sRgzYHOyiC3WLYF87qZDO9QXzJY7MzC18/KV4vOQjkBHex7w6871FiZ+HlAv4EjWyB/gYXMJcESvOlMY1ICmTWJ/lDUomfqavt8bfCPM7JRQyWkjQE6suuRxJgEFJqoTmn/POSL6p7FMyiOnsikRh4jxAKzu39w1ofIxqQ0DD4532/0Sz30zDp4YjVdt1nYsI74htKUXc/Sj3O1Tru6y/Z7F8fqLUeCJc+rKAdoFiKhUc/WgJbGwAVLnYJn5dJIe/nMaUt6K7+f6UxZc567nFmz4RAHRRpsn2/ZDF8PkJXAH62Qhev9dVQy5mQ49o+WQ/UpHx3xZBuV1jvLu+dGJ5al+zjLpPKs0DVMvesbWBAw5bRC/SG75jRHRN23cCkRdmvXnM7paSvT8y2LRWzM1NLDTSyg9Zj7VJtUCTv4y46EDppFoND28V6UBazkdC0cW6AVpFzWs8cJsbf4KzPnzC5/NU3G28YYxB4eeLPJivuIiJqbkj6Xr7TYP/rMpiiXgtXDE28JGWjJjHlbKX+lGD5qSLluhVWfE1f4fJGzJcaDTP8SfvajyOYiC4cReFgH7v6GsGIpvV7qFrE2l0CdF4+oj38Ny2QKmN6CRi+90p1rC/g6lWSTUfFQUYmjmEBfJdH6gfyhSA0ufzIJ0/viXI7ojb7qbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(7696005)(356005)(8936002)(70206006)(44832011)(4326008)(8676002)(86362001)(82310400004)(70586007)(2906002)(5660300002)(83380400001)(508600001)(40460700003)(316002)(47076005)(36860700001)(2616005)(426003)(6916009)(54906003)(26005)(1076003)(36756003)(186003)(16526019)(336012)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:04:58.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54fc551-a620-42ab-77ac-08d9e2672b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why]
Certain configurations will result in link encoder
to not be assigned to the link at the time we apply
cable ID logic. We should skip it in those cases.

[How]
Check if link_enc is not null before applying
cable ID.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8cfc9a8197df..117183b5ab44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6327,7 +6327,12 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 
 void dpcd_update_cable_id(struct dc_link *link)
 {
-	if (!link->link_enc->features.flags.bits.IS_UHBR10_CAPABLE ||
+	struct link_encoder *link_enc = NULL;
+
+	link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (!link_enc ||
+			!link_enc->features.flags.bits.IS_UHBR10_CAPABLE ||
 			link->dprx_status.cable_id_updated)
 		return;
 
-- 
2.34.1

