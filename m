Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22D3CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E8510E231;
	Tue,  4 Nov 2025 08:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKvWbnLf";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC76310E55C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi16RFEbp8dMYPyi0T0do1UIYt56wFPSx7mGaU5sp+GPxpGMALF6Sfbt9V0KbTSKHkq2D9MN0rGPaNTNcl+KdNlpaStU649rwsVWDZz4j0kneA7agRmLi+zKXrESEffrPUyxnGLBZV5Dc3FMVs6jk8ZDgm8wd4arWhBVnjbSvR/8nY41wvF2xm9+AHoWfP7IZ95ruAyJIgeiM59QHRQAnEncJUtYjMwkYtzHn4XaCOMV4YBdF5+m6jPHXRh0vWrH3QNNkMrlDI0NsgEOYttWy7yXutCIgH1qyBbTG2D8X3UEfuAtazACMwKOr2H2V78JU3nPf7e5/nkv9fdkA0U3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=C2PmH7nQGYY4qOEU/ye///jJxZKcr1EGVGvBjaBHdoQEz5S4CODdfA7aepQez3QKvMycVOl/sOkLGbBGslrp2LEki9+eR7aCptYFyBv+u9HK0tETe5RjlnudTeuPHlfGDRkjgsT4rHLaUeG329eEr2HdnhEfQ/viYEizD5ovB60samL6CJgyEFoHPoqn427H2GWxTQ4TyJydh3F4YcP2hymAlUc2t87yWsODuWUqn0Sq67mjSQdgfH0pSu6IXFg1XGkFnDluofATGqavPlmffKxodZWawbHH67GFaWPxGKlXtAJKVaKRDLR1yupWoYH3HMmBq5REgx8eAhP1pWzVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=fKvWbnLfmdRM4qr8b7QXsKEwoU3r1C0PwsMHI+7oAvzG/7VCnzYJS0zziKlm4HCHex0x7/DkGPCjHJgkKmYvjnvqvGZ156SBZzxpKymrvmAQny5JvQlrYZAosjyo/gDe5du18caDPygAhajbkjuPNAVSiUSaH1EowU26tXISM7c=
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:47:16 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::cc) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:06 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: make MCA IPID parse global
Date: Tue, 4 Nov 2025 16:46:50 +0800
Message-ID: <20251104084657.1412130-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: fe447d5e-1c6f-4f12-8ba3-08de1b7ec1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rK94YXDpPATr9CzeJlPUS8EElkI8vhr+Xm56sB7mcXblb0kmhOe64E+WVQeW?=
 =?us-ascii?Q?qeX6X5XCrAed7vyT7Oo8pOD0SxYGSdUyHdt2TtD3DgoDdzszw6DJpmbYP5XY?=
 =?us-ascii?Q?PU5iyBfiT8GoR/F0hl0TMT5Rp+Plj+1MnqtuLPN6DVSy6MKRPKhYZbeoCGAe?=
 =?us-ascii?Q?vMuKSa+AO3ANy8kMMUqS4wSSgJzsI5yaGLeuPqpGlWtCCRSNAUM/E6uNzFim?=
 =?us-ascii?Q?wkiLaqKAlerz++voshRDQe1rgvg9Ft+0crC6bMhtt4bKFgP7HMzQxow6fzBf?=
 =?us-ascii?Q?ZfmRIyWV0ivLsBG7OkiXXz6dl6tjrih+ZDVp22uW5d0JqRE1ybdyHOPEB6AN?=
 =?us-ascii?Q?ebJUNU45I/NfexXZRupAbh5Vvhx1WvdXzVwAo8epUWf4s0LB2tH90/6sG2k/?=
 =?us-ascii?Q?Xr0FoeZqgRyzgVItgJCvoKbnu+LtReAQN344sFQtK80k82zjll6GvT1yW3FH?=
 =?us-ascii?Q?RNRgZ5u007YCCJG1it7GvFUGpEv3hxFCK6YPL1tH76eQ2lQl9EsxJDEk+uML?=
 =?us-ascii?Q?TBp5uYES7vIhhlJfHJj6Y7lBeb7SmW+DDixY50udQgph/oiaI03F0e5ekDj9?=
 =?us-ascii?Q?yPSSGycrV6shJM8VICRfhVPOOW3lme70Y7t+YqTkAyxa5JbFGxT2DL2Cc6mP?=
 =?us-ascii?Q?Kppgd47x7ZgnymisPQ9i5yLAJ1MpnzXuW5xSTkXuSuYmPG0bJ9gIleqzae9l?=
 =?us-ascii?Q?l8kq4Dvy83sUb0f1vDJHd7PBwwVr64l6xJkl9JGETNyV6H46s98np1wr3i2e?=
 =?us-ascii?Q?jBQmoTMdRe5Q4F8NCzXCawhNjGq9XpdRW1nHbObgzwiuzng0jTmLIa5OnB7S?=
 =?us-ascii?Q?CudiywcWZXYyyzu6O+ZCamrNUKb92b7+XOrKKyzftebMVsD1RMc4Fy4U69Yo?=
 =?us-ascii?Q?Ol5MnrcW0YJS2pkjkrxTyPFo4QnVlveN7U6Rvcj9lmU3ES/3d5yfI8sTy7ty?=
 =?us-ascii?Q?1s/8SApaUqVp3QI8oIk3UV6Y4RrPlm5smqMvl9Y+eODriRFbTI64SIuZISpp?=
 =?us-ascii?Q?8cpTOVHsFoDEtVfI0FezJW3oIzxrdElwMgmfMHfZlBqvHrQIbKBgjjlDi0ci?=
 =?us-ascii?Q?P/bKINLOfOUKY9q6u+2zpylnYeVdclz79mz7J6pdNYNU3ukrVx46t06Z+OiD?=
 =?us-ascii?Q?Tu9M4ct9gCQQ/pEAQ5AZX3yjbQeGDpg+YhOwD3Cx6QAAqPdmBBU/TGXOpLw9?=
 =?us-ascii?Q?tv6vTFXT2Q9dvNBW38r+FC+Kya/jTCn7oeJDUBovmeupmLA9HzYflpKPVxPS?=
 =?us-ascii?Q?E/3aaOCvYe108Fp7NCUsnkbtGoFncenHcQ9SrfECL+ucPBt2VKK30cxE5Xue?=
 =?us-ascii?Q?7N8soApMyLnHdUmweweEaifhHCo1Gf1AHxA+iadJrZ+bFNzb9REO/KTeDTW6?=
 =?us-ascii?Q?KQvYbXapmHYX9UT68x5m10/++45BWoSrwQAVUHW/h/o9SAuYU1lSs6OtHAhi?=
 =?us-ascii?Q?ViiC9TRtt5L/PEc1aAq7fl/o5s9XMiagAgN5A07riiNqU7R9vOMBy2+6AoHY?=
 =?us-ascii?Q?2opYRWY2LWlKuQcGDKVz7NCEJF8R22dVQla9jjcQ3BNG2gkeZ93tlYYGGxXj?=
 =?us-ascii?Q?IvhBmBTcA7KvKHRYfT4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:16.1715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe447d5e-1c6f-4f12-8ba3-08de1b7ec1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

So we can call it in other blocks.

v2: add a new IPID parse interface for umc and we can
    implement it for each ASIC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ec203f9e5ffa..28dff750c47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -113,6 +113,8 @@ struct amdgpu_umc_ras {
 	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
 			uint64_t mca_addr, uint64_t retired_page);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
+	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
+			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8dc32787d625..0f5b1719fda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -711,6 +711,19 @@ static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
 	return die;
 }
 
+static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
+		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
+{
+	if (did)
+		*did = MCA_IPID_2_DIE_ID(ipid);
+	if (ch)
+		*ch = MCA_IPID_2_UMC_CH(ipid);
+	if (umc_inst)
+		*umc_inst = MCA_IPID_2_UMC_INST(ipid);
+	if (sid)
+		*sid = MCA_IPID_2_SOCKET_ID(ipid);
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -724,5 +737,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
+	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

