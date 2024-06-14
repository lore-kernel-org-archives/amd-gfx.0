Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D969C27C79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 17:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986D510EDF4;
	Fri, 14 Jun 2024 17:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tce8X+6U";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC2610EDF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrCLo3SQBj8pDRM5Wngog2SYO5r8eGl6Kk7rEbfFiFdQ2nGQPzPWS/tzmkIvE97yaY0Ezxv3/Gc1ucpo3hH73j4LvShtytid3v3RXIpxWwMsmvYgR+dGWv8ADWESlGEGb1yoQmuR3Ow0QpIQjEDlIyrbymSPEwMs45+C+5Rd2ChQ0C3MkWfqZ6Cro2JQ+Y1i7SMd8f5FU2ozaj0w/Vr4HOgQgtFgp6Hkalg+8kavACCQX37Y3k3cQpHBhSfpDOyMGrrWYFBeS2vek0GD7uKG3oIeDhwy9mcpceQ9xOrwh28MJQ/JRPKbonfbBO8aYBGsJqa9DHryX1joD2D2hUKhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33KHdaJKG4WHNSGgcjcHEgTq3068CZExlFAqIK+juCI=;
 b=UzOMF6r+gArHElxDQ0569+7oSGQp6q5/1wFf8FqbUhSbGNVh3RF7WY9EAO5vW/dN9VSopp8rQ1oljmyc1+0lMs1amdqFgb+mcJlrMVv7UsykIrWcKEqmhleJTihxYtMHNGzMTA9aw1dtHMwgHLbdyPp8SMHK3/LVgmnK2nI1DxJis1UEOMuH+it7+4et1Msv/LBhATTsMErEPhv1mKkHri2eSlE1psxKGHHhxPXcHvwDxALasmVIfOEnfFUAT8Kck22qt1IhnBfwT/RiWYQDBl7fMeAjiMIBYuYiqILfAfl30vceiuCTwGqCJAQGW8WIwtnGAMrW7qVQjJ+jHj1Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33KHdaJKG4WHNSGgcjcHEgTq3068CZExlFAqIK+juCI=;
 b=tce8X+6UdoHqxHGmL0fNZEiowVwFuq51FrPhykmKt/mDKPBD5QywLcOq9Ux/EL45PiM6Vv3O40IFH3YXACSlHw6A0Pf4MNwuBMuiPF9tA08qWCKGwqcQJr5/zu6WQKRcx0xNebQmqcISghqxfJ1B+uEGjUo694skkxNCE/aMizc=
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 14 Jun
 2024 17:06:02 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::b2) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Fri, 14 Jun 2024 17:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 17:06:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 12:06:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tasos Sahanidis
 <tasos@tasossah.com>
Subject: [PATCH 1/2] drm/amdgpu/pptable: Fix __counted_by attribute
Date: Fri, 14 Jun 2024 12:05:50 -0500
Message-ID: <20240614170551.6195-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de85571-6dd9-43a9-7602-08dc8c9444f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZJEeuM44pBlVSRixA9pUWdxMezM+fe0FqEkPlcjqY3XT7HDfP3+jQd4t6YeT?=
 =?us-ascii?Q?3ueUGVhgy+8EEVuzf3mImcy2DOvvPiUhFxmYN211Jzxpk7sSEC3dtYKMwt2p?=
 =?us-ascii?Q?TmAH2Sz03Ajpagzy7JyHLmw04X1/67nGFRjoNx/iUrlu4s4C1YMso9Dk+ds3?=
 =?us-ascii?Q?s+YD1popguzDhy60NIvsaL/SzwZJoIt8/3wskzlzoTq9QQ20l2FWSiyhFZkB?=
 =?us-ascii?Q?0X7Vp9PG/CuTLO+3/hjVeNSco3Ysc34iOJh1ZYGuFOM0NDM5OKLnumbPDWLc?=
 =?us-ascii?Q?hmwnHa6n3XxhoNye4Ty9FUkFlg8PitI30IVcI/9OK6I8N6EG36Vy1DJuaVtB?=
 =?us-ascii?Q?gBqaqwTaYUxWs7ob5Dnc9tIVHz7KTdqNdUtyXo+C2oV5+PSE9TLyCPKZqgWk?=
 =?us-ascii?Q?1wWnyHQz6T1WEvQC6pBr8Hn0OUTOUbbZW1+oFL1AFdDjR2RgLLzm6Pc62cd6?=
 =?us-ascii?Q?+UnnpBcvuYgew7mS9QTgKNPXRYY1n9ABE9/P8q0Npqnqc9dPWqyfUkeM3UWi?=
 =?us-ascii?Q?M9ODajvX8SjlF+u04+cLPoj/r4fMyEjBiwJP1yY3pxw3wXMaSLSlMkEupeoP?=
 =?us-ascii?Q?GrkrGmjeV0BeXoFBiHCltH84uNTDtnUDu0jrOW9iwwiAQ3NsbKRNniihsnHG?=
 =?us-ascii?Q?5MQeMfhCRQys4Z7Alwt2vw0NUdRoApMpQ5F5gzqtiFSEFeDKwfD34T1MBQsm?=
 =?us-ascii?Q?FhA641OmCVtEWdZANNS9QeINZi8SCRq9jEgsWiDxHXxgkcHuSpJht6cWydX7?=
 =?us-ascii?Q?70kZHP2u0/QnW2QjKX+DkivKbHelWjypCQ5PHxu9Z+YkwFJ+NZUzX1FVQLqG?=
 =?us-ascii?Q?uCrxzjriYx+zz1mkY7wnWtjKhUr/9iUk/0uW0JSOCJqfm8n7FYSrbSwThM5L?=
 =?us-ascii?Q?cmsgxFAFw0ubICtlCT+j6opcA/C5KL5NeVGt9yfXsD1k3E8rlau+e88GXthA?=
 =?us-ascii?Q?fVqRRYPfSoEeJTrBS4e2WEDkjlqpqb/1EqzOQ6x/ojvmkXGFHa5y0f14zJm4?=
 =?us-ascii?Q?EikzoW2hwWvwCDx45aFfPj/TpnD2cpHQQKgP1s/B3IKkVBMazwFmwYl2rLhq?=
 =?us-ascii?Q?u38rq08PPwH2wRYkJDJuVgOhaiat9Yn3hlk2u8nYYIxZa82V4f3sLb2GFX2h?=
 =?us-ascii?Q?xBv0//O9ZoKZ36Q9LYC7mKXg7PPZs0mkelKfOx+DtSVq3x8VgDEXM9Vgsb9E?=
 =?us-ascii?Q?wYY+mAWRWwrhAIqB+IhiLRmSXtms7UXfVpVeUWayXIA5JaGYG3vjDdqhLJjw?=
 =?us-ascii?Q?Zgvlv2ymnCkQVPlwKakm8BtP9iZ8B493Xot19zfs2PhGF+B8Ub1QuaxlutL4?=
 =?us-ascii?Q?FNNf/Imb8RzU3BnSsIgA27Xsa8JH83N46MBedtZt6pbRBDS3R6HOpuo8T3cX?=
 =?us-ascii?Q?shpLqLd25/XxaDYZMHB6JVFo8vSvXyc/17QGJ03hw3quQxUOfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 17:06:01.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de85571-6dd9-43a9-7602-08dc8c9444f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The attribute is not helpful if commented out.

Cc: Tasos Sahanidis <tasos@tasossah.com>
Fixes: c6c4dd540125 ("drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/include/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index f83ace2d7ec3..984770d0eb4c 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -480,7 +480,7 @@ typedef struct _StateArray{
 	//how many states we have
 	UCHAR ucNumEntries;
 
-	ATOM_PPLIB_STATE_V2 states[] /* __counted_by(ucNumEntries) */;
+	ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
 }StateArray;
 
 
-- 
2.43.0

