Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00027C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F17E10E9DF;
	Tue,  3 May 2022 20:09:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EC310E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMG/IeVXdvRoHd6Tz/P9Zn22nnwrHw+zOEW78MEXm8oRuK+NhTA4z/ucRYRZNhk7WPn9dz3Mdg7OEiH6c0jn55fFBmkrBPD4GfcRcx20mYl6J8hdSAaRcQnmQxE+Bv0kN95kspPM8NEsowEtQY1sQa1oBsCUspdoFNJa1MsbwvxM/oUgLTJn0+zyJWm4jFPVg6/PSFjZYRiy5vMCwkt2aptA0famB40XvdGJ+iFXCi7EgkmoNjJcbaa8++irlNbOGd7ka4lcSiV+b3T/KnlouBMUYv0BnFn0k+m77uP1YMDC21i5YBy6yJ9P4fXK/OhfirS13BTdWnDdTOaTmahd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYDsikxm/34gCTqsnLK1W2bKHfkk4V0CHeetC45vtag=;
 b=YXNKOZw0KwM9cQqmua3gnBlu725m1XuFIOZQsPQcue4CDpikyiq8IJuLsPT20dlIq/g8W23a78PJqBUC3tPH1gEvTOmV+dTO5vmcrdilK3VfUlHKFllaBr/2q62mktqAOFIDsWhZuXLw0nUfuXnPoZ6sexFrbrk7IUcoBp+ZAniXJRV4Y2/G9xqKZVvNheZMgm5h3WsMbB2B0qzjjYWHg36v6icCNwJVJ9Bchv4kUWGL2aLtd2pUHaF2XOp2NgCYL441iXwqpkNkZzPXr12INnuOeb99/alj9p+5ZU8d0362sR+iFtT7f0fePsB9mdxHyiUVjdH75zivMHfT8fxkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYDsikxm/34gCTqsnLK1W2bKHfkk4V0CHeetC45vtag=;
 b=wMR02M+uaA9dBhjhwAihOOOk0iqXjw9ypxm328zWDHLJ92ePMzy2sBvZAaSiZSwDVWFRRVDiEQWwI+hX5QOS7IgtwkEqGX3ngeGgTwbHZ5kz+JBGVQRz+94vot1T8ePzghcuWmNrw2UJtUQIKLusuRJdX7DljSdGOzTJfM8a1gQ=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:09:12 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::1) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable ppfeature mask setting for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:35 -0400
Message-ID: <20220503200855.1163186-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87979c3-5c21-4a73-a683-08da2d40ca60
X-MS-TrafficTypeDiagnostic: CH0PR12MB5025:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB502540C03D950EB6B9CE833AF7C09@CH0PR12MB5025.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuIR0I/LncLDdjyly/i33v7is8Pq8DHl6XRJvqMy6UaWW7UoqqQAivf17nSV69xqorBuUrE8EqSlRULzOMRSFg2xNEU0H/Opli58kSJQPPJMJochb/vofb3t13c7ZL4oiSj0g8V59NhLpo0JztXCGeI8sSg4av+ge0dvTSjk8YtrGiiV6Tz30vlIFkNPP9anWXGGe+VN1vUmWOsDlw3SlmcIZj0F1vBfozNyJh79UK//DuiynlIWxNqeJ/8pZmkgeJeOoGCIImSBsJwEgJQrRvIrZvrglr+5bgq0ZTK3hvmxSrxxLfKk3edDx2y8TA6jfOlEZDPe/SACex0g8mh1ht7/YYEb0e/Tj75iv309/vLFYGxpChXIYjVE8hWwoOPJnjEubIRsSb6WW/WsHGD74KOAiCW3hAGeM2S+0IwuIuRGHGhmqlUx8GstoMj3BigNt03buVr9+Aj7+NdTeMQ2UOcyNzgxY+QM94H73ttzhd6vvxbaVSqU5DiaZs9vVPdCQYo57izbZPZYlZv3roh+p57iAX7J91E2NezVkg/FjdnUp0kcF38DBj9rWk/iiHanHLI6qSBWLv7MYKbqaUHLvh40ruFrOnE6nJkAzbQoPLpTM1M1wIU7OdA1dQ1g8WwRxIcBIiPtl/S3Fzpg5/z7jGLWATqgvJMX3ov338IX7pbhf1rNHLzHgNtnWNQsn/MDbVjcwRf4Gtmfgi57/tpuhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(5660300002)(2906002)(86362001)(6666004)(356005)(40460700003)(316002)(36756003)(81166007)(82310400005)(36860700001)(6916009)(7696005)(336012)(47076005)(16526019)(66574015)(426003)(2616005)(186003)(26005)(8936002)(8676002)(4326008)(70586007)(70206006)(1076003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:12.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87979c3-5c21-4a73-a683-08da2d40ca60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interfaces for retrieving and setting ppfeature
masks on SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b4c693d322a0..b9a6dcccc0b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1550,6 +1550,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
 	.run_btc = smu_v13_0_run_btc,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

