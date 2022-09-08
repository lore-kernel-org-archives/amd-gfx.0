Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE114ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 01:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1604410E917;
	Thu,  8 Sep 2022 01:13:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3389D10E917
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 01:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6xbltYV0cJ+mFmyjMgmIfcMe5faIWAox7Ns6QQyASwOF8rATi1l5sT44QiGa03ycvQMYSA8otgFnWWoVZnZ1snEN0lFXY7S9iy5ek3TzfTy2NpsdpRdy5KdpfrkWUyxQp3KzwaLhnP1T2HR6Pm/HeQsDYWKOQ//cNFxIqKdzarzWXvwF2kEhfoYRAsc8TaHwoGwkXbCrkNsMQekUhaEOxEqBKkiuLMLi+YQAXi0ex6s1eNE6ZhxICqvq4biOmNASgaRSl/X1CLYZDHAOJSuzQGeWl9nYBuxp6CYYkdmT8igywa376WfCf6DWzA/ESuN7Rj81a561+ZQWufVdELlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ6ccogov7jnpll7x2gFqrl1kgS2e40xI468j+BDGO0=;
 b=YvTf7oheZTPbUJqV8HlG3skGpJCI/DyLcS0Im267OaNE5XdQ8Mqhv4LGqO/cpOFd3JLV984pR/C8G2af0j46wtRD4CBvJDS2v843i5MGv/gU2uxw8Dxgv7dKq3W4vToZm7WzSLZnZsnPVQgWp0ktsg4UAeTGB21w4swIB9pECrs2fj7FtzC0PEa0uDGmiM6x6KuJRAATtNfEeqKncjyr5TAhm/NkqwRmpkT075W0qSr9G7ih04StGqNdZ3dID4owbnlU6h7SQqWnV+CH+OGPNu527IZgiP7XrBLoDiDXVYLcU/S6C9djqIN1oGD6ind3t7VnuJoPWSR7pX0gAI5BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ6ccogov7jnpll7x2gFqrl1kgS2e40xI468j+BDGO0=;
 b=pl26PtCi4gciZ07euaftnlBNkIxQOwx592+9WhK2kj/XAFx0uywbrTIOuV6DuzH6jNXSPLbygUv8saIFovwOFRXxxrraqpCuV3ElSH8KV5duhlyUh7HinRqJv5s/A9p4DJrmpyZG5muCZxHuBhHJq2FtOSXvD9Djr0gQdWhSiTU=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Thu, 8 Sep 2022 01:13:07 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::70) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 01:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 01:13:06 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 20:13:03 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable full reset when RAS is supported on gc
 v11_0_0
Date: Thu, 8 Sep 2022 09:10:35 +0800
Message-ID: <20220908011035.17145-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b6ecac-86de-4787-ff48-08da91374952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iISFVlFHLZI8Ik1tW2+7em7jZJYyPJTy+SkbrJu3V3+CrvCfFwhYnw8HejgwQB/1tcheeF5ODNeqT3Qqevh7/2s0/uPe8ResBM3OhtWT8QKF+08bgqqKBnmqCq0b1VLbfZsXpD3l16XI+lOPSKxCtI3ozS+Ws6iwp8nwCntqqvGw+JxwfiBYED4A/b4jpm48svxfSJ3AyxHWfteZFNziyABmFzjb8oDL39s6TJohquBeE5yBAq/GdgDLALm/KlddaPWYLfvWR7fEsShfwadie/J8+ICYvp3uqRPh0ch82Yfip4sA62VqeyT65G+9P2Dy3WLPe1/UFoxCGvYZnkq4kYL6/T2DvKkyCM0G/lobZm76kIc9rwLAppLRhTi5stuo7ieIvCTj4DdGRvCX2HO0Hlcay4GMZKuf0NinrXs5JvVujffiDShe0HY+oYxXAKvC3LeRpDcV7v2ZBG3zcyhoHuC/p8VO28kexJzC5Nnsyd82wUSgogGlVvEy24+hoI0XDE+oqfNj2hxntOqw9Obi16wXE8RvKZM/D2fak7bFMOF2Wqymc0gAdJozEnoo0jAGwtc6tJbBFy5+bwMCgXY9RLY1ll1Evxb2Z99tCDUwO0eBcdQd0jcXv267ppUfCZ8EExGadaWJcWeDf/5OGCLDTFErTLjN8tVX7lu8RJTVXcQe1hufBGffF/FAkssO97XVWPc5xWr2n9MuYuaSdvnCZ9uLaoHCgKACE00bRm7gSMqwPvNqnWwz0UusJvGUhn2JK5uD6UwmdJXbaGhN9/XHC69yhQ6AofFS/jBfeOjznP2TLDQf9qUcUbEm62ycn5Oi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(478600001)(82310400005)(36756003)(8676002)(86362001)(70206006)(70586007)(4326008)(2616005)(186003)(1076003)(336012)(16526019)(47076005)(426003)(5660300002)(36860700001)(4744005)(81166007)(2906002)(82740400003)(356005)(41300700001)(316002)(6666004)(6916009)(7696005)(26005)(8936002)(40460700003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:13:06.3563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b6ecac-86de-4787-ff48-08da91374952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable full reset for RAS supported configuration on gc v11_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a26c5723c46e27..81f32d77c98cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -421,6 +421,10 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+			return true;
+		else
+			return false;
 	case IP_VERSION(11, 0, 2):
 		return false;
 	default:
-- 
2.17.1

