Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED41C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3042310E9CF;
	Wed, 28 Sep 2022 19:42:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A13810E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD3afIhe90ubkHDrD8AZh4/078sq6y4o5YEKZpDHAYrqnaqmfDIvpv8z4sHvkzFib+yaPHDs5WLh0AZv0Uvs9DtUUJk0L6v3+biWRUVb2lgP0E7cV7KIqzkjKyAnlwxNm0bvwUoRlDlGG7DwDJOq0+8mgtdD5ymgC1kqcE30b1SpOAthsqlwDkK3b6dJikCpwMDzZkJclU+axuv9OvSlOk/VozEpF7UfLhUS7ksc9jvGSrvr+WcJiq1B6bmZJVeV3QvrJOiOMmqAnE3ThfUuftDaLRXUBlWf/L6SSd2L9JDrUe3bUTZxRD8AsqhgMRQSqUMc6imYWINZZq4j0UVE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXLYKqpGz0GRoHt2hKx7hcdnLL5ZcSment7OIOq5BHk=;
 b=d4+EKsrhHWjSPidCpspOtgoinuA1EdpDhWFLX6C83T0nrB9qeB9JxNyR2sdKabDkxx5z4HxbQfeVBPI2muHVfuitnY+7CM1GQLJK2fRbq0atj6bqm1yeQPX5ReKXVZT+vkYv2w4TsLebfz4DF6K0nKqHmzV0qGogdRXIi6iO7perHkyBtaiC8uNmIi6xFXZUcOUqwwAMQrK2xcXl1NeAeXIi4sAznoyeQ6DnzlDMMDkHAIboTxJbcA7EnJ8KQhKO6YPZ2FWRU0GGev+xzhAk4Lgaiydlhivv4ryzhpHe+uq7r1Kv7fYtC1TkUy7UVNaWeYw5jhJPL+aRwsubhBLRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXLYKqpGz0GRoHt2hKx7hcdnLL5ZcSment7OIOq5BHk=;
 b=o5pwz2rKio1ru4SeDmRTGnbRwz3sMNyxJax/Yrrq9nonXbn8PPBYBPwhWRwBQjCZMQcK69LTYVtG0ifHLWgVIPbitHdL0zzmRJ4BL3hlui8IJPVXN+NNWbus+HPbVqHaqqcJOckuJngto5pQSCeHe1jNmsDNFiW2E74rccqQybU=
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Wed, 28 Sep
 2022 19:41:00 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a8) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:00 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:58 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/36] drm/amd/display: prevent S4 test from failing
Date: Wed, 28 Sep 2022 15:40:01 -0400
Message-ID: <20220928194028.144879-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 70083ab7-4e8b-4f52-ae05-08daa1895ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4To+0ZAtqBiR3fU+2VnH0IDwp3ynGndYbSrbPJ9WbturytYC7VTOMen5VTgEbVf9MDEfBrBuBEc5tPq2g0v4QTIuCoMxGD413Syafa2oxA9ry7/ncZJad6xysF5ROJXf78Bv0bzBoeBQwealnED/846a5sDol683sOxnlrZrtRGeX0wmGslngNhIb/PBE27WZRSZ4wRqqUo78xLImgUqquuyrWNzx3zPC4BIXFuT/KGOCW4DOvUv7zJLTe2pWipR68XkpmT0DV110lYW6t7iUgDfoZqMNM3lm1FcZrH18l9gRrmBTIrN4jlfSmr+caYrzsyKWzfeXmX3V1iOQ+G50rOFJ8TwyZWtvMaqX2A9ruTleY3fbq4o2nOXuZw7SRXa6/CiltvoSm0B4fUmiU/2vhZCDP18DQTK3pebCyjr9k+TSDhYHP5ABMf7DU1oNhbucolfwHXCGk2tpjdGdI8+vVx+g8rATxcIokiL8CuvcGZ8jVnUFr8qtDxjYRxHXiGc6Gq/PKZ8wMU8PpYFca7Wub2QXbhO+gK1hhlNJVACv8lFYOsCBoCb3trR4YKK0E1W3UdijXr1LoqwLySmXww6YGvRJ+6TK62spi12knJFNXE+s1d+BW9BTHTog9XQquxEiigAMKifoa5b8l/qCwGpagAPl/SyWgbGqHVROJWnHXRSW52HCBJ7Mg7GfCAYTU/I+rK3cBMdsyDjGoAPBn8pxHLyH7Dm+ZYkKTLrHF/RXtHMRTvhNt3xrbqOlj6AEJhIOXBBzEIOy8R6QgNsfyibkGPujwM72T6Svup2L5RfWQswXDPr7cGrbL0DMSkTLSwzyX33/nR9t8mXGtlAeBBU2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(81166007)(8676002)(6916009)(356005)(426003)(478600001)(316002)(36756003)(40480700001)(5660300002)(4326008)(41300700001)(70586007)(70206006)(82740400003)(8936002)(47076005)(2616005)(83380400001)(6666004)(336012)(36860700001)(40460700003)(16526019)(7696005)(186003)(82310400005)(86362001)(1076003)(26005)(2906002)(44832011)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:00.0095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70083ab7-4e8b-4f52-ae05-08daa1895ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Hansen Dsouza <Hansen.Dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
limit the vm prefetch check for now, until the feature is fully
verified.

Reviewed-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 5752271f22df..c5e200d09038 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -67,15 +67,9 @@ static uint32_t convert_and_clamp(
 void dcn21_dchvm_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
-	uint32_t riommu_active, prefetch_done;
+	uint32_t riommu_active;
 	int i;
 
-	REG_GET(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, &prefetch_done);
-
-	if (prefetch_done) {
-		hubbub->riommu_active = true;
-		return;
-	}
 	//Init DCHVM block
 	REG_UPDATE(DCHVM_CTRL0, HOSTVM_INIT_REQ, 1);
 
-- 
2.37.2

