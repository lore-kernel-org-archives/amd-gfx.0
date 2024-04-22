Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561E3C07E8F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6EE10F2BE;
	Mon, 22 Apr 2024 09:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pV3tgGYD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E7710F2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/kp+EVvCTKNLpG9xDi7y63ab9ErbfOU4YY14RRFu44emJuLY6+ulc9tgTKUt47ab+Xp7E35os/2GpRVPzHU2Gb6QpsMd8RkTtnW7O3cNBsDqQvUa+Ajk0VH6ABcQMSJ6tH+AR9lDgaHCfvhV1Y2vW3Em8Eevw5cuRIv+DDxJuQUgqYC7Y/euhtTSMrreBdck0YHoN8zZNoQp5ENJ82oOQNoBAL+56e0ge6Sw94Akz7w7IzHYlNqqAeBOuUgKlcjH5Hgx/LoZJFvmoFXjszJgllZnAgRkIGHlO6iHY6thFSDP0sIv79he9Y2j46oyaccSQAy3VlMXskXJzG78aatHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWPbxgCByalpBfiuGt2OY3HnFfiYb2GSvw4uhRGzC2o=;
 b=d9G+n1oQPTtlisq4X7kwyCV9AigoKqAmDf7Zca63vl1RjbVsEEGiwnvA5gy7ewmy6qUyotI1Bu8IcEbkz6+2MqLxxLcFfXu3esIdlZ0lCzrcQckbsvVgf1oOjLECEttX83VKDvgULJWgkUQq0f/K87Y/v0XVbPwbw7xuN34v9+N+a31i6TxJo3P61/x/cCvpTmRA4RKJ+sAf3knPsz3ZugWLxNj9PhC9QTZZz+koJyi6dDxStUH0gtMtEHZEH+nU7u8W3q/bHx/EaL/FoROodLtihM02i0RHKyR5A4UJv8lzk6HC4f8JgJCsTi3txxR0b9ca2y/5Qct4PsQyau5kDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWPbxgCByalpBfiuGt2OY3HnFfiYb2GSvw4uhRGzC2o=;
 b=pV3tgGYDaC9YDIuBtsDiZeo9cqLVnkxfQ0dSHFOJqZn2iZnz0AYTVNaTdRjsVIPBecTfT+qfAZ2+3HjzBkRrgOO5teSEp45KyryJufQWu9A2A2UOR3+TEwxj3C2c9cyfUe2kRHTOvKlm94xxxe9TjIlrAOtNaZnIzdgrpOzR0Xk=
Received: from DS7PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:3b7::10)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:49:23 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ca) by DS7PR03CA0095.outlook.office365.com
 (2603:10b6:5:3b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 09:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 09:49:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 04:49:20 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Fix the out-of-bounds read warning
Date: Mon, 22 Apr 2024 17:49:06 +0800
Message-ID: <20240422094908.537208-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c30789e-27db-41a9-6bd6-08dc62b17d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fWu6+Wc6TnL38WXmRmDEBm4Io6XrIavzOc75SmbfZ4kGlAYJf9X/EMMXkr1u?=
 =?us-ascii?Q?v5xzdW98fdhzGkRLQaGDUjRlg4cz01ratb3vzpw3aEiIcuuQEgyzLBHXvXn6?=
 =?us-ascii?Q?zRzfiRieE69GuRSW9YwkApq8OQ70TieuUEmKj3AMGgx3uRQGJy2ttokZKcoK?=
 =?us-ascii?Q?N6UnCQNBBipTYpTCaOmTMpCiQZ4A+EM6wbHz4aa6egDvPhqWgxRMGJ85dt7q?=
 =?us-ascii?Q?i/FzY3DaWr+1BeNmCau9F2Sx6GAvZNXA4/cdPExm7Y7tMuy626Umfdj0pg9V?=
 =?us-ascii?Q?ieHVECGYeE7WzWVE0txkmR4T8pKvxC3bEAlAFem3uTAnzaFLBQkwl2xYB0HG?=
 =?us-ascii?Q?njWu0qpHJDk0bOouch0caHfs242t6xRYT7VWpM5YrxQQJPPsY4PdLIFJuhTf?=
 =?us-ascii?Q?i9cyed/6KzzXUSMi8sXVLsr1u5sW5fqnQLnyvK9DdNpO4b2J7LE8kR5tez42?=
 =?us-ascii?Q?Wve4h/o2HdgDVTF2RVe+XqUa+vzuXBazwTynf95JUsctSYw4QNWitpbGV5oY?=
 =?us-ascii?Q?gtzGkwFnhu2McxqsV0BleKyTE/aMNa05Ufg62FJbUxkRLc5DInsUmADNsuxv?=
 =?us-ascii?Q?GTe6mGhWkfIxr0Vx1aBFUxsJRVwxQwzHq0mvXz9BQRd9sID+r6m6eeknuqpJ?=
 =?us-ascii?Q?CxmrrNm+CsyWYLjcqqJsEuduSI5GqoFKrUf8D797/LgPdmvLfuTYjCcJOHdl?=
 =?us-ascii?Q?s6DG6l9aEnQSF7UgMHWPLti4TmaEZf2mtMAFIkPTgi7LmXjWtes/PdQ7QKeX?=
 =?us-ascii?Q?TQVp+AFkITEPmTEGJVbD+F29NJOpz9Qy3cVAf9GnNpsNsdxsrpPhr6F4Qo1a?=
 =?us-ascii?Q?UAxuYqCEhmBrt0WMGQwrImJUCvkE5C+E7ItVZv4jNVE8FdZQk7k6lOOqp2PA?=
 =?us-ascii?Q?/KEQraZDRlKGDGJGc5boBXHlO2aBNaxB9khd8cz44mJElOoe5fIkq21tiI3d?=
 =?us-ascii?Q?q+Xfl9tvYqcq0zz5xs55ywre9ngTZNEH9EQg4GokYsMwlR+7LSfz8SGHfUHS?=
 =?us-ascii?Q?t5PTCClG595JEDCkuKdIKpXkpod3kixeh+WVw3mu3wj4NsphTaJA4zefkKep?=
 =?us-ascii?Q?DdZpldoxUiyfLYQP4Fl26QazZnP95wXx223dGP/P6HSEA8mv5zGKeOpFj+hC?=
 =?us-ascii?Q?D9R3MgsvaPIzjm280lYNUdxfspvai76eqpMiHVB27+ZrmOQIlADQFy9Dyftn?=
 =?us-ascii?Q?bQ+HMEOu3nSlV+qeKplzZMA5OwAfFLjP9XVL1Fexu5Gmm4ROU24ZuibBkPlB?=
 =?us-ascii?Q?GzPXCu6u+CsY3iFqnlHKnSRNexT8EBNzz6FYCW5ripyHm6P2dFAxP8oMicsm?=
 =?us-ascii?Q?y7GUJG/TMYzk+0Od95iJlxziNelyE4obbgqLhPZxG7Xwffeqs159xE75r4G2?=
 =?us-ascii?Q?ZTk5pjJkl32ZGZHA6EUTqZcEirW6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:49:22.5791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c30789e-27db-41a9-6bd6-08dc62b17d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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

Use '<' instead of '<=' to fix the out-of-bounds
read error

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index eb25af46622e..5c08ad234439 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -144,7 +144,7 @@ static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
 	const char *op_str = NULL;
 
 	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
-	    (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes)))
+	    (x_pkt->opcode < ARRAY_SIZE(mes_v11_0_misc_opcodes)))
 		op_str = mes_v11_0_misc_opcodes[x_pkt->opcode];
 
 	return op_str;
-- 
2.34.1

