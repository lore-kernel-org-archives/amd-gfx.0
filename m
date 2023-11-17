Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA1C072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 05:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC82B10E10D;
	Fri, 17 Nov 2023 05:20:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690B110E10D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 05:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJKy6ml/KxSunCKZcydw/hSUF/ft+HU+ozKqlMITGY5HzHHW4WXFg/konfIs6rMkZw+C3vv4XJcPYt+1r4flJjB/p1dFtWIkecjl1+CKlMQiPUbKpluCdurYVfmjgbHgRlCUUrtJ9ZJkxk3Al9MeHvcXaWLh5IrcrA0yDYtVKptOP/I7V/JWHWptbJkB1sXDK+ihKE8vIwUqFuYd5Q24souYHEy1YJgx3q0pjTeNTP/vmO7fjQfWhJWM5Edl63OxCNBbykBltH3F4h1+NVfY8AQZwNPDuko1I83NMSm8pCBmFfMyquZSsmY65ZsXUN0/5VJD9ypy4Sa4KGN92LenrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0XL0ZcgmlePty71mXnm/RSK6wrW28MauK65EfTwyLI=;
 b=cmel3mUPfPotd26pBIheB6DK9oaB/Z20ZyhqK5MtcOycmJdA1LSE5Bw9xmHWoel7QsHfbc841uHyuI6jHin5hGQNp5ynozyoVWii9kbOrDxuyFly4MJ8auMnT+/VFU6CmPQu32pp5e+3x5Mx5OfUBovcTf2YRTUo699XRm/gfR87t4CgW3S8GIbFO1G24hUnUDBBBO02XkOJBaOUXzfyZCO89kn/p6ywBlt0ag2c4ffD85P3httEk4LcHnAKqf8mR6ArLb96OJ/OeehwDaLiSSRcLLiKgdMw6DNvU3fA+pFfCHtMp75LTQIBk4fkf3akstVj0gKR/nu4H9iflIGYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0XL0ZcgmlePty71mXnm/RSK6wrW28MauK65EfTwyLI=;
 b=qR8WAJ/hUncfWp13Ktw0SyrysoQfUbGFD+/5zSCqAo6uyIYLpBzL//vfoPeh4+B+lVCn2OPw1kBglpgKPsShj1NjmRBYVEEjVdbhT8K5ZSjPHo5JM1wg9U9D5fcuWYRSxmPwluiCfzFA1goxBcqlRHF+ZsewKBdbdNZcxDLG94s=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 05:20:24 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::24) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 05:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Fri, 17 Nov 2023 05:20:23 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 23:20:22 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Copy HW exception data to user event
Date: Fri, 17 Nov 2023 00:20:10 -0500
Message-ID: <20231117052010.3166816-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 14898659-afcb-4e2f-103f-08dbe72ce6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7p9JuQ4vES1385TeidyU6SWvMgr14EaMswHZ+kn7Pu6he6072ySRUM2A7FZB2PREqLjJ4eMAiC4+H/eV6g6rD1meURmPmHLcj+l/2ryrYzvBXWnQHv0lc3+abn03MnXlsw9DRrd9fvkg+GRv19g/skE73fo50mnh6bC/KnL393CARe7+hl1IB0raguUefCpMOePZWfj0xBs8kEplBqn0COWNlnnrxAL+bqEtbbv8GFqcDMF1ix73LLbdlbYXAXzei1fsb6oxM+/TPV4EWrCr3U09WS0RKxJbmKSn4VBe+wavBwHiBLyegWJzkZyqDdsUy3rznkQU3OLHjQlC1sYRHfdJJ/k4DVAJGQJV2j29s961L1biMCTm2+Q30dN4NjGNHBd4Fzru2JquKWY7pteKbMT9Pi5d1qqfuYDWxiX3W20aaPWhuJWYo2UNUtnH1wHPMDE/MWYXKLv10mpDe839zLpBen4pq25Z4VsYBx0dj0LvbuIu8aA4GcNVHBm1TRpOKKI9NeHp42IVpwNxsTxrzZNxNsSffFykkzesLmGenZjFf5CiIzdwy5aKfVxWRPidTQf+Hu09vQdEShuJ4GsH6KLC3mONug9RQGr5XFz611jBO41alx83lJ/2vamB/poIxbafZVqJTCIP9Qyyr+1tCCdOObYXyyysi1sDpO3gtt2iFGQi4CLUZcTfJ0HuShnpweZPK7y5ItyNNvfFYLIKF5aVdEVcdP2qEKXPH5op34H8kQqB7SrQ14fLWSV4McF7NwNdq1yplgxd3ezm8UdZ4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(81166007)(70206006)(6916009)(82740400003)(36756003)(356005)(54906003)(16526019)(70586007)(36860700001)(6666004)(336012)(86362001)(26005)(2616005)(7696005)(4744005)(2906002)(426003)(478600001)(316002)(1076003)(8936002)(41300700001)(8676002)(4326008)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 05:20:23.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14898659-afcb-4e2f-103f-08dbe72ce6a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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
Cc: Felix.Kuehling@amd.com, Lijo.Lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes issue where user events of type KFD_EVENT_TYPE_HW_EXCEPTION do not
have valid data

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 0f58be65132f..7d3db017f8d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -880,6 +880,10 @@ static int copy_signaled_event_data(uint32_t num_events,
 				dst = &data[i].memory_exception_data;
 				src = &event->memory_exception_data;
 				size = sizeof(struct kfd_hsa_memory_exception_data);
+                        } else if (event->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
+                                dst = &data[i].hw_exception_data;
+                                src = &event->hw_exception_data;
+                                size = sizeof(struct kfd_hsa_hw_exception_data);
 			} else if (event->type == KFD_EVENT_TYPE_SIGNAL &&
 				waiter->event_age_enabled) {
 				dst = &data[i].signal_event_data.last_event_age;
-- 
2.34.1

