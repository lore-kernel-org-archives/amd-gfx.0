Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F73DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608F689DF9;
	Wed, 23 Mar 2022 11:49:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146BA882C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be4P3TmcEzjeI1lSq5mXP3DCWyJIOWIcAAOddAkYcCTrilIH/0OLolveARockuzvx7Qt5xDEWVuYsKCxfGVox4t7TCUw2PC7VbcPrCi7uuyiFhNF6BwVD5nRbeIWEzndXp4jRodFQ0jB445ROXnnCespVaUMg0JjApIloKMyHphVRhCP7yGk56dl7mZYy5vzC/eqv+CNzsp1RyJwoid/bDMpnDxljFGTlZdng3fFyxPYsLyZoBP0Mv2S/t9Bv5whOB/WFm1mi35VM6Y2U8/BDa2eygSEZOIpU+UpotU6ng3opG6da7mZ+zv4AGyIp8CcImbgoCuRSErHlGt8O2D9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Ii1fVO13U36JP23p71luGJfRO0iaU7Qhdz69xW0pk=;
 b=KTMoIOP2YhAf+qpqJSI0MqPfLypnhU+O0Fje6NnaqGSqZKQZI15xUZYa3b2VBz79MLBwNRS8tkbxfeUEhH7BSoZ3BZWF4YaWHoHWz87Ftll+5rD0g9ce8db49hOUFZhhidgkqmAAdtSE1x0Ox6fyG4g7KFBsUjzbtDhKL8yNoD1NZsPZWkCtCfjUnSfzblcailGvzl9fzx/Ww06rJr6ibSdPOw7Fa5VfNc6PV0o7TAauG5nN+hy6PnRyBN1E3ZrRudJ4KHxJiIdxcwE97+vykWa2u+2ugO50Op+DeJn/mgBBn8UR1cVY/LajlCotUejropp3AJ8JSouoU/c2Hpu5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Ii1fVO13U36JP23p71luGJfRO0iaU7Qhdz69xW0pk=;
 b=FIPUFmhPte38ut56iv9+IDE0jIh8p5ZE2gQQwt0ayMbfbyrdC7MPVRPKLRd5xoi4kgOq6RjmH7YZ+vpqBQrsfbYyjI4y+Xo56Ol863UEwIdbmKSgGhaB76XXEdlHea2yNQ1tN5GPVI/kl19UzYdM3629DycSLduK6k3As0cdcPQ=
Received: from DS7PR03CA0148.namprd03.prod.outlook.com (2603:10b6:5:3b4::33)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 11:49:15 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4::4) by DS7PR03CA0148.outlook.office365.com
 (2603:10b6:5:3b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:14 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:07 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Complete and add dynamic completion to umr
Date: Wed, 23 Mar 2022 07:48:36 -0400
Message-ID: <20220323114842.78516-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a58ddb-45ec-4017-eae5-08da0cc32796
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5222E83968F042109565F77299189@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gU/1uXwKz0A5+TyiABgYw92dzgmtImWwZLkAkDeL6ynq0UbmeyDEJexSg9H0ngG07GRqxreXHEhbaOfJcRz1lgI6EZgQ81IivqvXs777dLCa/9TefayzJOs8XJ8f0bZSpdoI60uNHwMz5b2s4HeGVeXCBgPfURM3ywuRg/YCODkQxBKWraPkvdMF/pc5jISr0KVX8YpOSyplFxZ6VdVzBGngwPsW0C/+Zm93Isw/5HEY/CoLo7ztKEH/pcmGPTmmFbkMqT6vw4Q3cSAlJD4u1M9SeAoZOmlJ0Sy6clwEzE5uZu1a05JLp/sk5tbMddqzv2vGiJ+20P/259Rx2wLa7MlZGlmo7oXGaVpMIYOu2dhUqnen8KHn83lbEXGayLjuUDVLqP0+SktA+MYvTdD24HEY7QBTdFxYF+DTYJo+64YirgivxDCpRh4Izyi6uW1hKRxygumQwbhZpKqdHUG8LaE+sSUOTxPAZzRULZrUV9FzTqgf2sLenr1AZemGcqdjJGxNqlXjOFjpUtRkoqYZhQGZTiJa5teByhL7ITq8RzTRCdPcryaxKfOd3MYdiXRGpREPjVAIn36tPfZY45hWW8McCJu47wiOMIj5QpHudCuMLinkkcyU4giiJUih19Fe/xhlpopjxhchKWT1aK/8AXKoOvLbBbfyesK6wgBn0s9qeOwRv7qTQATqAjN6yFLiz7Zr09Hn73Iaex6zUfIzlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(5660300002)(86362001)(508600001)(186003)(26005)(426003)(336012)(2616005)(1076003)(16526019)(66574015)(82310400004)(36756003)(70206006)(2906002)(70586007)(44832011)(316002)(356005)(8936002)(40460700003)(54906003)(81166007)(6916009)(8676002)(4326008)(47076005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:14.7610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a58ddb-45ec-4017-eae5-08da0cc32796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom StDenis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Complete and add dynamic completion to umr.

Some of the difficulties seen in this work were,

*) slightly different output of sysfs files depending on the system
   configuration and the number of controllers in the system.

*) Merging of the IP Discovery sysfs discovery mechanism.

*) The varied and finicky user input strings.

This work was tested on two different systems with different ASICs,
with three distinct configurations, one of which includes two
different AMD GPU controllers in the same system.

Luben Tuikov (6):
  umr: Rename "scripts/umr" --> "scripts/umr-completion.bash"
  umr: Rename completion function
  umr: Complete umr completion
  umr: Replace and reuse asic.ipblock.reg completion
  umr: Replace and reuse ipblock completion
  umr: Add FILES section to the man page

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>

 doc/umr.1                   |  13 +-
 scripts/umr                 |  83 --------
 scripts/umr-completion.bash | 402 ++++++++++++++++++++++++++++++++++++
 src/app/CMakeLists.txt      |   2 +-
 4 files changed, 414 insertions(+), 86 deletions(-)
 delete mode 100644 scripts/umr
 create mode 100644 scripts/umr-completion.bash


base-commit: d773ac6b1f529c02d8d2021d69e2dcfad736628d
-- 
2.35.1.607.gf01e51a7cf

