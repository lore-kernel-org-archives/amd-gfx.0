Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A77C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC2B10E16E;
	Fri, 14 Jan 2022 03:36:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F88910E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5XzgVSz0p9l5fiWCz8IXqFX0Takq5+EYu4e90cb46Z3/x/8v4bEDSmGMvlLkmXiwi8ghMnRvixVyNu7+rF9EAhOvtd68yCTnfFL6qPC6L9geLkUktxHC5Rr+jbKGi+takK/RkCUc1LcUst3w9qZr2HGQgUGIV0iTlCQ6yzPWaWqn2gpsGdqGxgcwFl6FEDBHMCOm0cWVmncsOyllTYYz9PS/wXtTv7dkxpmWXb3nw56WI+5lrRej184teFM490Bax0yTR+KFr+hFUmmYE9AId5+vPO6lsLqDva5e/LAQTWpsGj4j2fh+5t9FxLj88j7fOn5uBzjugQ/E3eh6ReBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO9wgK1v+oj4u/jM6ibOBgGoc/IDngyHhRIYXPaYqnY=;
 b=kivb/y6Idd8Cl0XOrTtEVHmwYYxyconoSWszwC5/3Nkc+3YnPhYe7WTTOVoL8/obfk+d+cRh+uE3FGVjutowck2K0l8cQzrntA2HITbms0ZYsXPwf6GNBNomNbG6AXvlABD79lck/BcGpCUcPyEjiV26/jdDHRNcOyGZQwI+xuet0rav51KBUYt5n6pTg9H+rq7k4DyMz+OO5RMGbX9XvOAtdrWPQczzmgmvSrzy44ckSWjMwmTjyaDJK5+bxqPmYcO1EXbwmMTe3KPgvGSb6vqRdy11U5pL13tl1UhLnE6YTekz2xTA4wamMvgkOh9CpaRAk2YGPES7MX42DH6+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO9wgK1v+oj4u/jM6ibOBgGoc/IDngyHhRIYXPaYqnY=;
 b=VhzDL0Dj3+FHWHthYcCepqVWs7UVtcvqO29eqOWzTpO7Hfyu/36ynPYDfZn1FqqleAC2QLR7IRxEuWZ+fjvf4d1pYtBfutRtpxwjWHUSSeXmQGfKxIAZDxjf0uOQAiacGAZSFHrY/Si7z/Xs+efeeU6mEdZJZ5YKncGTx4v6Z8Q=
Received: from BN6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:404:65::23)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:36:40 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::ce) by BN6PR17CA0013.outlook.office365.com
 (2603:10b6:404:65::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 03:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 03:36:40 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 21:36:38 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Fix the code style warnings in gmc
Date: Fri, 14 Jan 2022 11:35:57 +0800
Message-ID: <20220114033559.4009592-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7754adb3-d323-4f55-e012-08d9d70f13b7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5392:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB539223E695CC1965017BE5F1FC549@DM4PR12MB5392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3a3Y4pzbHjKPTuQRsG206CiPqGhVA0EFqOlOG+IwTU5ZVEcwfywAG5MqurGsKzdDEDBAk3m/kuzAOWdm2gVeRKVShdrvsnl8+sJevOMInxyfpwRPRcSaTAEpva3/WmmmOoMmn3hf1XX9DEr9me1+INSHpFu64Wk/Rm0/cz3fCa1igHwI0QI3E0bJ5fO8iaMN5xyfyAOnIs8R+xalKyfD40j271jIgAzzXS3M/ndqWtbUVE+Gz5ObIKt7fQ0U8t0E6+04wrSHcqG2UvlwuLDpIuCKtCvZbWhUJohkXW+TauESz2pJ5And6QOQwH30ArwPidcEdxk/sXQipq7p9fwwaw526H8Vh7GrbhMMmyP4yX4A4gIHNhgdcQtAiM0nKoVHLIG0DI9UBkaoPsxBNEEfFT4okv3yh2V6cg3oS4ssqeoWBPVp/jAszIeE8ACYhD6zYrgJ7GP8W6cGcuMB3RcIV87zdZSLgyKcfxowLgGdca/ttXk1OT3Ffe3PrkbWJ05n7QNq2zY6+4eqwGOjBWVHY6kBpkwGvAjkUChvolvzOWQN0xXK+5OIRhI/aiYsajz2h/CxkDJqyr8MJbp+XHWG6tGAOVWrekW+MrrBHOusKnTyHl3w+VnRnzRuqr5USO87piexPjChfxUgxsbJeHSRmsT7mgK7Zuu87N3z0BGYM2MTcKVOu7POS2kUb6fmZDIMCcS8WgR3ZRsjoF77zgSoJVXkBzmBnLVF3fIPNG0ST3xOamSMuyEae1k6SS3Zq4hzVh+cWCyg+lIb1zO77aYAXYSv5GO/dK6GlIt1QFbfBirns+ZNJBALvndbAbskCur
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(6916009)(83380400001)(8676002)(336012)(426003)(47076005)(356005)(54906003)(70586007)(26005)(186003)(8936002)(508600001)(16526019)(2906002)(1076003)(36756003)(316002)(4326008)(81166007)(5660300002)(86362001)(40460700001)(36860700001)(7696005)(82310400004)(70206006)(6666004)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 03:36:40.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7754adb3-d323-4f55-e012-08d9d70f13b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
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

Fix the code style warnings in gmc.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5ef4ad28ab26..4f8d356f8432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -672,7 +672,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name,"umc");
+		strcpy(adev->umc.ras->ras_block.name, "umc");
 		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3965aae435f8..c76ffd1a70cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1231,7 +1231,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	if (adev->umc.ras) {
 		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 
-		strcpy(adev->umc.ras->ras_block.name,"umc");
+		strcpy(adev->umc.ras->ras_block.name, "umc");
 		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
 
 		/* If don't define special ras_late_init function, use default ras_late_init */
-- 
2.25.1

