Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30358C0502A
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7653010EB5F;
	Sat, 27 Aug 2022 02:50:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED3510EB5E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahafhLQNu6orv0Gm5Xkt7QiORkXy0y2UKx7KHQtC39WbWR5hZVvQxM3rmqPsKYey896bBkJUTfGTRZu7nruKiEyTCoyOMgTtP2OvKYKqtT6Y5Aqh0ARDEpo4Mkx5hlZppYoXdxycXHRE5mHHebx+mdF7s7fOcwJyNwA7TEnRYhtvlXax/sGRBFoVc30qdhiC/F39gsGl4k3o6ml2cZrh6nnQEMGiOq7I6JkAwrNePuTRW6QxZSfiCWNusXflg/EtwZyWJsurkJ47uCaJ/dghVv4kvuG3/pQQZxfq+HD00pN7epz+yfDOzrDZHtvrpTRHF41XR6QbWOfREiLD3vISYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vkgJQoCw+jRQnQ7aBe8dy2imaG26MYgxQseyo4gvXY=;
 b=AiN0dtvB91M2MrJRvoIIfwjn7VHjVctsZqglwuxsg0N2AMzw+ERssDdmNrFiPRHoluKVO620xgJQS8s9+W+GgeqoaAGinZb6F/ADaIVD4izwPym0DUb02UxD/Wp5kjtwLb9l4taHDFdt9gj/JnbqZW5grv1UtsSXiGrnTToz/MkyDLSFMbMpwGT1kFZVDN4V/ME49nWRntKuqy5RjAkttH0aFkL7LXONp+pkSm9WNK49EITk5MNX4BgB2LAFrUMobkkXoEs1lxpvdohrj78PunghkE1ZeRvctsHpQNomaoeyrJwe6fYR4heFqGqQFmpy8YHg6XHmlnMLc8EmWnYciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vkgJQoCw+jRQnQ7aBe8dy2imaG26MYgxQseyo4gvXY=;
 b=wmYXUiIwkWg2jE0gZWYirL4gzWmUvUzdKc+6dVENh80RAdWWT8LwRDXNM4PMulHW0aL6qFY/Bsd7Z2QjTypm2vnSEIADhdMQ4axborMi2meyTk0BASDK8LkgN/YwrCUQQU6OS1Jzps1z+kc1p4sYhwx7ysRzjETmL6CBOzPET0Q=
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:50:48 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::58) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:50:47 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:43
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: set dig fifo read start level to 7
 before dig fifo reset
Date: Sat, 27 Aug 2022 06:50:27 +0800
Message-ID: <20220826225053.1435588-8-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b40b241-06cc-4e3e-1a20-08da87d6f237
X-MS-TrafficTypeDiagnostic: DM6PR12MB3931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNoG4AQzUTiqOCi4jzwLpbf7vPdi9OPWJy2lZc0nekhgxD6dJ+XrgCW8Otg2dzMkww1Y0HEIAGyRn8f7ey3mxp9pEsNzqdnN2QQMbCWIvoRzpPMBBgE2fTm4gXArAmWqqPt7tJvV77lc8oYqqTWUTpJFkVf7LPGX8mimG/6RjhZHBucQfAftVXN3Vv8Xfwt6mQSMUMzy+aVwyE4nkFpxLmc4t4r+Is9F3O8upJeP5BQPD4YglD4HvYY3ErSoD7X07FpOWYzqFbAaWsxWaRK0emGfUiR2A8dwN5wSPgQEvc/WaOp+SFcudfXA2TDipP+OMoEF2RCv3uYxXm+U6CpheBmjZaMlDgcg7pRAUR54gfVcOuCjK7zlpQr6Pq0CF/yk8uL+oqSZ0XikdeSn1tEfyjg5V/gk+CkhyVzqctIKDNJjhZeJzcaqIv2qIxK8sj18078zZjS7sagUCkzeGtwsZdzr+OAROlFg/u5t81K9QsmDd7IAsSEE80j42mHB3H6Qwu5vFo+5t1rflowxfHpHdWcMaBWLNMgOwN5Q0qI6bBPwVva1WamPA5PgwH+2LQirdGnGIGt2PKnX98Xy7alqLk7CK1XUfgNs9KQdOCznwWy8hFEY8B6Q/kyLhf4cfaBOL88UAHtxycl1HRvacREjzJxb7MgS4WacwG5a3b3N1l+LXhZflSWvagrPHH5eXKy/J4VNGnDWs1bcigJ8ibO2iYjKoRVVcRj+HVmyTCiYAVjbN3P2qeu7k6Q7OtDJSAWf5TmhhC5pOe9CpORGnStijF1+6+bAzAah9gBdsnOFZ2gV/45/eBHQ5bV+k0EBHuzmg1BoCPVofmQDQPg82DyOYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(26005)(6666004)(82310400005)(2616005)(1076003)(47076005)(186003)(7696005)(478600001)(336012)(426003)(2906002)(6916009)(316002)(8936002)(5660300002)(40480700001)(70586007)(83380400001)(41300700001)(54906003)(40460700003)(86362001)(82740400003)(70206006)(4326008)(36756003)(8676002)(356005)(81166007)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:48.1701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b40b241-06cc-4e3e-1a20-08da87d6f237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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
Cc: stylon.wang@amd.com, Wang Fudong <Fudong.Wang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wang Fudong <Fudong.Wang@amd.com>

[Why]
DIG_FIFO_ERROR = 1 caused mst daisy chain 2nd monitor black.

[How]
We need to set dig fifo read start level = 7 before dig fifo reset during dig
fifo enable according to hardware designer's suggestion. If it is zero, it will
cause underflow or overflow and DIG_FIFO_ERROR = 1.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Wang Fudong <Fudong.Wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 26648ce772da..38a48983f663 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -310,6 +310,11 @@ static void enc32_stream_encoder_dp_unblank(
 	// TODO: Confirm if we need to wait for DIG_SYMCLK_FE_ON
 	REG_WAIT(DIG_FE_CNTL, DIG_SYMCLK_FE_ON, 1, 10, 5000);
 
+	/* read start level = 0 will bring underflow / overflow and DIG_FIFO_ERROR = 1
+	 * so set it to 1/2 full = 7 before reset as suggested by hardware team.
+	 */
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, 0x7);
+
 	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_RESET, 1);
 
 	REG_WAIT(DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, 1, 10, 5000);
-- 
2.25.1

