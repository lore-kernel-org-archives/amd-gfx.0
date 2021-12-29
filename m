Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CADC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 02:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C394210E39A;
	Wed, 29 Dec 2021 02:39:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EA810E39A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 02:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igY0O3AY4sPAVij1BWXqtFG41jtlIFTYcx/Zzs/66f6zVpdysp3ZSjcEFBct7DgOk9n+KeSYHYXGfwuiPmDwM+RlvnXl/mKbxNnjx92FKJ7EG6Vn9p/+9i0idEiLtHWxWKwHAGTV28gamjem4PCzItWaDY/nAjyqpQ+tmFSqf9CLfymjuoWLFhbVUr8TNg4lKuzTVHdPCw2YwTpnkVJcktprD96nN+YOPrz7Xh5/YwyU/0azN8XpG2dnAUIXRp2Au/mlradGhoBHeX2Pe9K6/dp/W+73CLNWh+BnGpF3bZ7NTmihBTe9w3hLMsAuZ3vnoNd52p3g3vMDyihW8h2hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPS+tDMr4ChZ7WWadneH580XB6PZ07rXf5NkfGZDF1U=;
 b=feV0HrYfRDNBTFUlXM5rzaXFyRkdiQ7a0Dv3uTNP2ZKnHwGVgQ51KMb62xqTWQKXHx6qyl4D+Cra9NA0A1yAn+QoFiu2te1d+b6CFZthF/+hmqkSWxQWthNvhndnruLF1R58jNHsk6QoWPseD2Bi0HKQWmvbjyoAqq28ZNtOP7R49bTwUCIvOOK9urzmV6rq8mLV+h+Q7lAt39jaeXT2/GsZNP/hHyTQT69gi2p5NAe9xdP1e/lERViqKlMBd4bx3NhmchOPmWAmxe5C1wnwQ2mIphssoIs6ZykKPPXtMt4l5xW2vNlUTLjgTmovRxg69WTrVib8XCZQruVocFxG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPS+tDMr4ChZ7WWadneH580XB6PZ07rXf5NkfGZDF1U=;
 b=U5Xe/d0jkWF3YwqHKxZGtLDQKp2fpjWAAREAdRV/RpIIk8uzm9ypvn8nbp2rBSSoXCwO2qszfDvmDBOPaaIDOzOqNZcVJWkx0RC5AACxptL0P0XqAzDoEnI28T/tZgWGgvlpPkL/IBHZhHGuq5bsJgHbY+kH8JUjOB2u8OBhzpY=
Received: from DM5PR1401CA0006.namprd14.prod.outlook.com (2603:10b6:4:4a::16)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 02:39:28 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::12) by DM5PR1401CA0006.outlook.office365.com
 (2603:10b6:4:4a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13 via Frontend
 Transport; Wed, 29 Dec 2021 02:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 29 Dec 2021 02:39:28 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 28 Dec
 2021 20:39:26 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable sdma ecc interrupt event can be handled by
 event_interrupt_wq_v9
Date: Wed, 29 Dec 2021 10:39:09 +0800
Message-ID: <20211229023909.17214-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 680f2fde-f8b2-4d07-b1f1-08d9ca746f94
X-MS-TrafficTypeDiagnostic: SA0PR12MB4576:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45762437157A2A784798FD7DFC449@SA0PR12MB4576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5knVFPpdxICpzG2imzvSl8pzki+CVTuOQhUg/PDR8e1hK0UW+9pnel+LIJwuY6On2hnTdqokyLzO0uYPWC9Qv+R3caK/T1M7CAlwGdneAE5sVWSz9Q2iGbID3yz38xYteVXpZlUXOKo5guIoi91Iec+5W7D6OrIhv+bLpvATVDuu3aS2PPJ6ubLabe+Qbv2DrvfDttt3zDxTnUl3vC/U/TxxCVj14AvUsiSckLHYIuQ09WMdkWlsLOPBOU0iR/BQrTQXUZNulDzgO4pdF8XSourapkQ/19TngqumeRPDoy6OjG7jeO2GDkVDl4uqaBsLFnivlrz7ydSQDYC2ohUTXXzpkKf27eC4SwpA91oKbzsVxmObv4lbUCbam024HP8vvAAdMdls4sxOeFgnsC2aUVgV7ScMS/26VN31ZgsiU+69xYrvJ1Z/s/dHTCDNlpaqr0Cqx0dtn9JDKce748yHOHpFM/c3JF2sLwaxUqKchUNXVdmTgNtdYCtxLrtOhh0vufXzqvcr4XZu6nAgsCHXs4QSgeFn5FLnTqvv11UesOedMw801L7cWPAvZl7ZaBKXY7U/ibltBlPnUxmf4mCKKKwPR43aP1a9S9LxxYu4LBtRAcJLSCn+9a2mJ5WpEe9MSqieh1BjueKbiLYMaBTEHl9IxI9OUOA+L2WBuTBOZIN4OhZu1loCzLxFHNJ1ALnO3jEgpCmdXDaUaJZmv2QqtuXzEVgkiO6vwsQS+swypAxGzAYgrdC6ZK+H7Cipm5g0JmtO16LOdh3zSfd8xWwteHYx7+3OLKNWIs9kNbxOT1osU933KzHPkPZ8Mfyuvi5dPikCWztkiEeK4dUgMMzVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(8676002)(36860700001)(508600001)(6666004)(5660300002)(4326008)(82310400004)(47076005)(4744005)(36756003)(7696005)(8936002)(356005)(40460700001)(6916009)(426003)(54906003)(86362001)(316002)(186003)(16526019)(26005)(2616005)(336012)(81166007)(70586007)(2906002)(70206006)(1076003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 02:39:28.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680f2fde-f8b2-4d07-b1f1-08d9ca746f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable sdma ecc interrupt event can be handled by event_interrupt_wq_v9.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index d15fe087ba55..1d92e1b7f8d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -220,6 +220,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	 */
 	return source_id == SOC15_INTSRC_CP_END_OF_PIPE ||
 		source_id == SOC15_INTSRC_SDMA_TRAP ||
+		source_id == SOC15_INTSRC_SDMA_ECC ||
 		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
 		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
 		KFD_IRQ_IS_FENCE(client_id, source_id) ||
-- 
2.25.1

