Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA193C021A4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 03:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DCC10E843;
	Wed, 26 Feb 2025 03:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0xvbz0ua";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD9F10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 03:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJUp9/2PUvkD+Bm6bNj65tLqblRpAV010TgiZcwaLJtGj9I00+VaNYvtf4d8YSeUG74WodfIfoRrIL4kyP0dTK7x24hcv6EYpKyscXKjYEIbPqsS1oDR6+dyxXLgR1/MqMYpKuSK5GKnt4qsLbeuWz+lb5Nlly33AL7/uguiwTprFNZdCjs61m5+j3JdbRk+xRX3YGYro+ZRLoHpkuWHYhyVQZLOMMj+ri9D7jpQUP2UmemP6SW1L5cApsrTTfxh/+k4FDBrzXpidxb54rOl/2yG49jFAsDLygbCl3wbUaP8C1vwiw4MVwN6ZfwdIc9MAH+r2YK3iIyXzbnCe2bK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McF/tXhh0ob8fYHg6EhaSCqF04Eh7f53fzwvx1T3SNM=;
 b=k5+auAZv/j1zGTwOFooZQXoVWoZSvtI45PetBmhyCTLtXveTNyqBgExN0sd7yaPbZEkrwyQ/Eqrxmp3Dlh3pNfPFHEYfgNm1xo9xbKeg3sslMGNuq+dvZgPXeHs8VXazvXLv1hsCSes+C6cyL9mRAveorO7J8bCuDg8Vvbw3jmS1sR0s7KHVjOSEyn3/LmR15lTHUiRvBfShF7dWvvLAiUHFX2KYgXzk+yOByxCMl7h3pLZX+RwaOrbDbMn7gQ3W/ouusG2tPK086ZKyLaKxZwYyDVqh01Phf209HMSJ6JcodgXJCAp7e6dzG7mt0/Suxm5un+YhCN4fsWeBkF7ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McF/tXhh0ob8fYHg6EhaSCqF04Eh7f53fzwvx1T3SNM=;
 b=0xvbz0uaGQGHdlyyAplZqP8hVGHMgOOG/5DW6FhGgIk1MQ8MfZ5h4v23QF2z32p2i4Gl1WZnOwjZsvHeP77osCmUKmXv2e3OUCRZexKqhrvLQlo7UuTwCdNtIXBhPR57bXrB1JVJECzqFZCAfBZLUvRSPbD36etgUO+hl6mBV0c=
Received: from SA9PR13CA0160.namprd13.prod.outlook.com (2603:10b6:806:28::15)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 03:56:11 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::d9) by SA9PR13CA0160.outlook.office365.com
 (2603:10b6:806:28::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.14 via Frontend Transport; Wed,
 26 Feb 2025 03:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 03:56:10 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 21:56:08 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Disable fru_id field in CPER section
Date: Wed, 26 Feb 2025 11:55:48 +0800
Message-ID: <20250226035548.50191-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 02719e04-c86d-4290-f54e-08dd561981b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vlF959GriJfkjfvqiIAckZDdeOVcHy38CIr+MkqmjgiSOeGLtFtzOumqUf+X?=
 =?us-ascii?Q?cJCvHPd/uQzoipJrwqz76SC/heppTJPhhx7UOjkhSFJ/Gej9nrmaNFE6gma4?=
 =?us-ascii?Q?T3HY8ne7l1d+3EbnLblqVGfbWO5Q+CnrI8ip8uYJSh8b54BFer+Zt+V/K0LC?=
 =?us-ascii?Q?QP9AzczyGij6FhJsgKUbzX0MdGitNVItB+VaXHU49r9ddSgHH30g9Yuw/CDk?=
 =?us-ascii?Q?LeFwvxMF/ET2ayGYylOCmD9IZY3CipBSz4YvyDArKRMWoG1pZGo+WfLfpdtJ?=
 =?us-ascii?Q?KBA2TRB9rBX8O60ZRE9FbBvwueHDsBeL1aJBkSLz7L/z240OR9XYB5iYJ6RI?=
 =?us-ascii?Q?CR9toBPkJpKSrcop4rYScwEWl7+36UOcpktedUonKsEfQmCK6smu6cl54L1Y?=
 =?us-ascii?Q?fDy+a35X9R/gjvsP8szaEuPoMdoiL5rZBrZB/l2dZWO/HSHA0Vq5zCOIfz5K?=
 =?us-ascii?Q?l73l9QsutOk75nBzRhpMmn1eF+lsiCsN8gXUXy8+aEitmMSHHAZ7XX/VnosG?=
 =?us-ascii?Q?8ETXd9C9RSljcBUC/CJvswpTl4QHaRfeZL9YP1G/QtmqfIjg63ygi7oe2xoG?=
 =?us-ascii?Q?XLRKatORgRVXwMycsRSWEgkiUSC7DaEiu+59bO8ZlpMzZZBZPiRRpqIi7lMF?=
 =?us-ascii?Q?IFswffl5kQhKURKM6MtLBa23y2OO/TGT4ypR9i3MEsHTAeRvIPEuOxUVjqZw?=
 =?us-ascii?Q?wvVpn4XesP+Qjxvy8GrCIdLJDlNJ63cckl8CboyIxPAGH6RWaz1KSeE4+G5j?=
 =?us-ascii?Q?rS2Ff/WplF8d8UgTTrJoZxA6kl822WrQQnFROm5xCTRPkjDOLQW7S/9NhbE5?=
 =?us-ascii?Q?iCm0lRhTv+Pyz6qVV5iAKn/qkku1sD9NSbkZH1YtAsQIyTGe3cn1wFED4/Nh?=
 =?us-ascii?Q?KyoXy4SIam4nVUVmHEcYjNWb2admyzha30uD8fDdR6hZC5kztV3NQtQH7Vj6?=
 =?us-ascii?Q?JSk828/xgyt7kmMo14zdwWc5ABt3AB2y0ZukBsweXdpnLVqg2XAFm4KLOZrp?=
 =?us-ascii?Q?0GYyrnEGnhgtQAV5boXKJSjsUR/e+vS1f0gKd/2RobhcWFswzh/IjK0S2KTw?=
 =?us-ascii?Q?tTlSo+WkGiy+AYAk4PNhM2NFcfkT0Min+qNv+wl/Xr5lgCtnEK31rcputmkz?=
 =?us-ascii?Q?muT0HGdWGgZ8h0Nh6zXi+NcaaRPv5k4amTJRQxmOcfmLJ3LgOowP80d+m5Vs?=
 =?us-ascii?Q?e7p6xwoaifkV8JGlBmjC3QxbnCJs2A81At7EsOxjakXap6oCNoTly2oTLFxh?=
 =?us-ascii?Q?7FmJqz67rDOY75C4K+kT9jMLAmHIQo7xgVDW2nt3HIZWby4Bc5+yrdUm4Lo0?=
 =?us-ascii?Q?Wdv2lRKE4m9yaFAC9k87NUVtzSrNwicEhifpQyelsqu8ia09mWRn617Qc1nV?=
 =?us-ascii?Q?xSFKwj56UatumVNiLlBx1aV0uvrFQo6u6XPOf91YvMjhwSsbKVQ2C9UpZ0OL?=
 =?us-ascii?Q?K1aVV2qZ1d4aEjZRPcE0vMkSF52Bd9ct7fvl7ylZPHkzIOsNI/puAMEC2UZd?=
 =?us-ascii?Q?H8WhFLpQ5aABeM4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 03:56:10.5857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02719e04-c86d-4290-f54e-08dd561981b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

The fru_id field is disabled cause of mis-matching defination
between CPER spec and driver.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 5b6bdabb8012..0b288deb9b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -112,7 +112,6 @@ static int amdgpu_cper_entry_fill_section_desc(struct amdgpu_device *adev,
 	section_desc->revision_major		= CPER_SEC_MAJOR_REV_22;
 	section_desc->sec_offset		= section_offset;
 	section_desc->sec_length		= section_length;
-	section_desc->valid_bits.fru_id		= 1;
 	section_desc->valid_bits.fru_text	= 1;
 	section_desc->flag_bits.primary		= 1;
 	section_desc->severity			= sev;
@@ -122,8 +121,6 @@ static int amdgpu_cper_entry_fill_section_desc(struct amdgpu_device *adev,
 	    adev->smuio.funcs->get_socket_id)
 		snprintf(section_desc->fru_text, 20, "OAM%d",
 			 adev->smuio.funcs->get_socket_id(adev));
-	/* TODO: fru_id is 16 bytes in CPER spec, but driver defines it as 20 bytes */
-	snprintf(section_desc->fru_id, 16, "%llx", adev->unique_id);
 
 	if (bp_threshold)
 		section_desc->flag_bits.exceed_err_threshold = 1;
@@ -376,7 +373,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 
 	amdgpu_cper_entry_fill_hdr(adev, corrected, AMDGPU_CPER_TYPE_RUNTIME, sev);
 
-	/* Combine CE and UE in cper record */
+	/* Combine CE and DE in cper record */
 	list_for_each_entry(node, &banks->list, node) {
 		bank = &node->bank;
 		reg_data[CPER_ACA_REG_CTL_LO]    = lower_32_bits(bank->regs[ACA_REG_IDX_CTL]);
-- 
2.34.1

