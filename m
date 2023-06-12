Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA38C88CB2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 15:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C988C10E2AC;
	Mon, 12 Jun 2023 15:47:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935A510E2AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 15:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYdxQeGbwpJWQ1qr5pJRYcom665zk1MBiCqpPvnxTDhwRpMKEJgf+5DvqSi2bZKGwfk9+mkLDDgJfAEmAZ0YPh3oCvEJUBekVW2H2GKDzu4QmsYxxFnw+CJLJ85zK1cU2tZ9jixyWoK264TDsTkMgV0XxTHgH8R8RDxdSYNtefU/kg7QVZenAk8s6OZdXJvVsS7kJqDGVQZkLacATephfXrobPoI8lP3LwMfPwOkH2pX/QVyXX4MrX2wDp4TdKG3CbaIKjN6Pzb77/3TFfAxQCbP+raP3ET5qNih+I0U/YXsa1WqjI603QSxm72kHDpgxpt2MOpDT94QI8w+ep/3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dmcYxqVr9yUQ+ik8878neQhlI+yiPnUCKgaPKVPQos=;
 b=Kafz6NPMM31USNvRTZnHIGoNu5/oN3e8PCKAdZAc4UbpE1Ugg9E7fwrAGIAL0EZGaX5b7HsCOtMKf4pPgZozjixCUlfpmen9pqtHUsRogtMzVhdJVyz/HFMjr7zDJYTQRIA8hIBKeJDUoxAQLDGGrOHoDRoBXh7nBnFfFV3dtHW62T2z9IjuSGVmajUjlGpjjsSlRRI9NSD1Ajkaug+ASY++1s+SgqHA2PP5nhVzesV8eomZ/gjHqecseh474HMAFWLOj641tAp/d0mJREza9qsYO61sSR7abXHZe2CilR0EQNvxX2MJo1feS5dESyDkgh19u7YmHEdUK2seRiStHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dmcYxqVr9yUQ+ik8878neQhlI+yiPnUCKgaPKVPQos=;
 b=30nS7t3alAh09KISn8iPC1sF7UDMbq7Za/ORIGGBW3w2Xhxja6CdHyh+imtmNEptmeexdxl/oqgKZpI3vEIx8E/4o4r3yn/sgvIdKzDgQD290cSZ0PoalE541fPXMXUNlI0WeNKU4PgVjvtRUp8was1K6pmLOkCM3AWsCKpdYMg=
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 15:47:11 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::36) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 15:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 15:47:09 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 10:47:08 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix null queue check on debug setting exceptions
Date: Mon, 12 Jun 2023 11:46:57 -0400
Message-ID: <20230612154657.2309434-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d6a84c-df3f-4523-6e1d-08db6b5c483c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v84HUU9R86KmdR7Xne7lsjrKK8B4M2eNAG/8FW13S1sImawbOaj0Qy3a277YWDVvKAKM/ii+hSniOcIf1MeZPkkwErzP7oVwYQXZn99DEpVaq74BgJaEMxSmsu+DxdcltLA4pCDnivLTg39gwPXHwww2upX1PAI3YIH5up71UCEqRwAsCmS/HSx+Vz9nO/J4PuRkNvpKS5S1ptxuRXazAsh/5xE+25NFu1Xyjs7YZBzurMiMKkx8wJv8Fqlx4rKptRqOjTOhJZKarrTiD34vtJJB5hih4VUQnoMqnpMwroO51WkxKh/H+KPNDK53v1QJseqID+rb1shqTj7qgdxEYlyg24IPWFgTsyug7M3yMTeC7YdtDIwRvFEFcRtZ11id1u+fgSKEZyGMRFj4D9qp39UEaRycl7gzajfjYgMHqEC7MZosypboA/RD7Tu8iFbzrTiDn0T3YP0GQyTZ5+Y8NO9FEWSEDdHxRbA/lFv4jg4C5Zgm5R5znsGI/1B2/IlnNx30dWpydfrz7/AysCxKE+Nr6RD/bIJCWyuf2+B8u2WFaPEORr4Yos9IMUkHupiZxQ0ardstyTI5ejuEkPad41EOSi81/9kfZl5I9eyh3gZqK2nhZGQ2bH5JyHJjRQNmUq7m+/jo1gTnG0Mb9EzWq5z+SiGtz7Ff1NeCMcdOrN6G/JHkUgXzvr9n1v1Xd/r8VK1DmoGMk4JnuMoewvDpK3gxNHiawxCMsIl1uR4kmokXxWKiMdL7WmJq93j8nkD1+plQr77stNkkJcEFB5I2sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(54906003)(70586007)(8936002)(5660300002)(8676002)(36756003)(6666004)(6916009)(4326008)(478600001)(316002)(40460700003)(41300700001)(7696005)(81166007)(356005)(426003)(336012)(44832011)(186003)(40480700001)(47076005)(26005)(82310400005)(83380400001)(86362001)(36860700001)(82740400003)(16526019)(2616005)(1076003)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:47:09.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d6a84c-df3f-4523-6e1d-08db6b5c483c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Null check should be done on queue struct itself and not on the
process queue list node.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index cd34e7aaead4..fff3ccc04fa9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1097,7 +1097,7 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 
 	pqm = &target->pqm;
 	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
-		if (!pqn)
+		if (!pqn->q)
 			continue;
 
 		found_mask |= pqn->q->properties.exception_status;
-- 
2.25.1

