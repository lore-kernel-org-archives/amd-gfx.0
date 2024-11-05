Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB7D36137
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B588E10E615;
	Tue,  5 Nov 2024 20:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qjcBWPxO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1FB10E615
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI/7+I8k8LwKm8NO6OjbVOYbkQMJtShen2AlCf0eHL98zB/aMqO8eSC3PCNmWGQrTPjFu4WWEPx+SrQBlS0hppM4cweF2xRChr6+CPCtK0KN+/OrnTRh4cnRc9zRQUrxxP/X52KTsJ/iMQKm+51rIhDTpVJUB6w2uU7C+mbCUIZ9MdG+wHs7ivUwrdheoHPX9c4CqR7bA19sERMt5py0Bcp4ExFS9Sd1GI9lEBqELq8xbvbxms7ZVFmIs6/iWGjKw+hAM9gUZc3sF8PYY5b5XBXGY5F/MROQNwFQ6dUjKCcnOeqczPZI0p1k56OkIuXKdr2hWt3+5aKBka8DAs+pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z8/q4HbdT+FuZXWEOu93V/2sKEXIK8NbaPKs53oAOA=;
 b=Qdz5kUVJqNrCRT/j3pjArw2Htxp4prANRiKYhkEGZFm6oudtv8Gl2pBAmXkR39OFIHABh7ckRBl9Ngc/7hRIfsXMGiSd2VbLJghxiDcF5cKR8Sr/sA0+0Vl464NCV4P0vc3h6g8Z0/GfvjiqKrU5HwYtQZn/DNVu5hv/02yEciFTll14/WXUKr4s8a22ILQVBOmqN+yMGKCp3R1nn/b0pEDq27gufcbmn6d5wcSCD6bBuE2Eb86zJrmbotKvFWbzKbzcBQVS7+hvUsc7hH/26cC4SuGx3yKlbaziPBKWDixh6plnsY5tf4k2T6kolLpC5gjGdvj1yxgTYBB1av3l/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z8/q4HbdT+FuZXWEOu93V/2sKEXIK8NbaPKs53oAOA=;
 b=qjcBWPxOppSk1HOXF3lFBgA0OyTdojUfiyj516c6+I0MFfpf42UEKmOc65ZNFqyWGtyykHM3kBpuVojXm1HVPpo51bAqWioCOncFrqkIF5BVKB+89tbuHarL/hvU9QZHCo98mrfIVtwMwVDSIGkOGi+cJNmn4xG0IauaGkZFwvw=
Received: from BL0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:91::36)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 20:25:00 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::5f) by BL0PR05CA0026.outlook.office365.com
 (2603:10b6:208:91::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:25:00 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:55 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 15/16] drm/amd/display: Adjust VSDB parser for replay feature
Date: Tue, 5 Nov 2024 15:22:16 -0500
Message-ID: <20241105202341.154036-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d45e5d-081d-4baa-5439-08dcfdd7ec40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gQnW8xuc6QtGNuml7OowxA/wj0wWK65+atYy3820gkwCUc3SY51hFmHfdFIQ?=
 =?us-ascii?Q?bBRgv5r/u7ZNLx+BjAcqEluZj2MM+hptA3vzBlHmklh3E3Gf+QbLu9dnDLv5?=
 =?us-ascii?Q?F4Oy6P11NMJH7oVXliZSyMCWc3l2QlKMpezhczQLn5ihsSq3Sfv8CInHmJHI?=
 =?us-ascii?Q?vBFn8VFd8IvRIgontylWPV80VBMcOYeJeyMLRe9jVw1oHynJ1Mx62ruDqPmp?=
 =?us-ascii?Q?Wckb9FHNJ5yiECfR9RFrvKwydohgEI02XOpKoqWINkI9qi6RQm8K74Zs+77s?=
 =?us-ascii?Q?ED789mE9L/FrMeTw9TGUgR5UooiuHty4/W1OUYjkarLdbZ4nuvF9o0z8etmS?=
 =?us-ascii?Q?0EoLXm851j4wMeyTaCKe239SpOFJd5krQRNimQ/r5u+1FNiH54dpyhFb/kUr?=
 =?us-ascii?Q?WMn54UrFL68JZYpKklXuudnHbFHS5eoqTrrAo5/sORcAkstc7J9shdTXHeAt?=
 =?us-ascii?Q?97/G1RjxO2LJJrMrR4EQDHP5o+KVvh27ZbE+gXADavclkeBI2ZjQN2Yxcnie?=
 =?us-ascii?Q?6bl5rLvl7qzfgC35XcwJ0cRUPM6U0J5s7o4WTnqJW+EiA2l36ZNa0gnnLdcR?=
 =?us-ascii?Q?nkWkgdqETf1IP1mz18D4+UmfbCTWZe6YBSxH5cMs14MB5aw2vLQVKCJ9fgqD?=
 =?us-ascii?Q?Mphb29E8Lyt4gm8YdF5brpjCgKEcHC6gs1bXn/MchvZ2Cy2bjGFTCpZhG3Dq?=
 =?us-ascii?Q?YrCLEkJF4DDjdxnZm4dbgMq6UilWCa9UL6Anin1R3TUOueWzAnfBptSQ787F?=
 =?us-ascii?Q?t0a7aML9BOiL+SdZ9TmGNch4pFoL21gk9OxRlvNGXo5D7HdpMG+NgLjB67jc?=
 =?us-ascii?Q?f3K362uDG27M0zfWNDJKZ80lFT93fu4gOJc7RJd9jyygryDcuDSZDJtry+PH?=
 =?us-ascii?Q?Akh39gKaAX+VsbEymEaghCMNpmHLmIwVokJELekzMe7zXKULL4avRbSqWEaM?=
 =?us-ascii?Q?U8KY2c8X7e1rR+2f0i2mNgp/2uRTxMVPlVdAavRvOSyi//ljcvOn1XIBkW6n?=
 =?us-ascii?Q?rnd6QNpIDrx4haigtPGq6DT26knJ44YcOmp8g8d01be1V/PIMNOKmdy2BnLf?=
 =?us-ascii?Q?FjGfbTJ/I5VXcCHHkU75rj0Ub+dX744DGuDclIz2GdpUWHL23OpQXzGmQJ9L?=
 =?us-ascii?Q?p59SuqAVDfUuA4z9yYN4GjC6JnvGPIGIPCs99so6szBBNSM8a2iBapE4cL91?=
 =?us-ascii?Q?yiDVTpiCu6KsQDW2/RacWYVBYV9fe07+yS4Owi47gJy5v5jA7tjmGGWQco0Y?=
 =?us-ascii?Q?bV3cYTNb145MTkqCmJb8WZeoL/akdpjLNLOMb6Td5gJ3SovcMDFwoYK689Qy?=
 =?us-ascii?Q?u57aTkOV3nj1M0gSc6hNv9/FXQAB1AaC+COPtGB27K937LKX/GyKSETvQMiK?=
 =?us-ascii?Q?Ob4ZilXxxQAAJzkEoGshEayQdlvZE9FEy8HMYtrY0n9JWnO/9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:25:00.1483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d45e5d-081d-4baa-5439-08dcfdd7ec40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

At some point, the IEEE ID identification for the replay check in the
AMD EDID was added. However, this check causes the following
out-of-bounds issues when using KASAN:

[   27.804016] BUG: KASAN: slab-out-of-bounds in amdgpu_dm_update_freesync_caps+0xefa/0x17a0 [amdgpu]
[   27.804788] Read of size 1 at addr ffff8881647fdb00 by task systemd-udevd/383

...

[   27.821207] Memory state around the buggy address:
[   27.821215]  ffff8881647fda00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   27.821224]  ffff8881647fda80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   27.821234] >ffff8881647fdb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   27.821243]                    ^
[   27.821250]  ffff8881647fdb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   27.821259]  ffff8881647fdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   27.821268] ==================================================================

This is caused because the ID extraction happens outside of the range of
the edid lenght. This commit addresses this issue by considering the
amd_vsdb_block size.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1d47719e7af1..8381afbe6e4d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12096,7 +12096,7 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			break;
 	}
 
-	while (j < EDID_LENGTH) {
+	while (j < EDID_LENGTH - sizeof(struct amd_vsdb_block)) {
 		struct amd_vsdb_block *amd_vsdb = (struct amd_vsdb_block *)&edid_ext[j];
 		unsigned int ieeeId = (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_id[1] << 8) | (amd_vsdb->ieee_id[0]);
 
-- 
2.46.1

