Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE12C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C34210E19F;
	Mon, 12 May 2025 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4hH1qNyZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DA410E19E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt8tSE7jE89igmrm8QwUX8/Ydil9Zd/9akTqYkBtDCTiejCNk0arsE5TrqbNb6HJheKsQULB8T6aWmtx7nkQKfN0lkaSeu+02EDFWNHgaZAe1bKWFYmFmuvq0Stok3TPDsDB6+Adah4hZWnskofUFu4jNNHCIBiUns2mQwaI8uh97S5Zli4RnGMfTgiwR2LiPUvrxSzOoz3h6+HSOi0IEJOAYS7Wb76uZZsCMWpTqpHGii9uv5dwjwsaU6JuDAXeKFzqWdqfCYhljBjrtCSLQHU3hKNdR8Ex9lhsC2CqbuzVAzZLJqIk3rMk3KGw2aKNsXbJ7toHIxb7+CKilUlpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlekfIh/suxQpquieVzmBUa/BQJLpwJDljqRlw9D4wY=;
 b=QFs/fZfqvs1gCBHoE7+8aseLhKWMHMz/wO2kiU+IUgBPXp9vChSvk+ApJ2JfWyqzhaL2iY4jUhTG8Wp246IqlPVtC1wuhHM99+wN2C9y6ZUayaH2XEDJJRMEOpWZRzK6RL0d7wUBCUPeHOrJtktnEh6mEZiMKiwt8k41uSlRj0Ikie9991qoz+kz2u876CfoKbGMmi4/27JWRYycgu5Eq3Ibqdko4Nir0uUrpwdWLGska9aoCiOSHdyzKEQmslEjefaF0cQayfsrenBrhJ80LFjh5jBYO64Jl4GuVeFrTbDw++q/qnT3XAyl1Icz+KZU2Cp9NH4lsnJ9JRSJoRGIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlekfIh/suxQpquieVzmBUa/BQJLpwJDljqRlw9D4wY=;
 b=4hH1qNyZqXlLVIRXHq9j73G6xLhsM6+AvaDvXVjL0599GLEbCymBvhkv1M0oLGhSrJVNTl7FQbyoxYgeCnR1Ay9MAhDJEFuN5f9iMOgyT1gRqkgeZPovtdGQ0dYTCjaWxFZNt6M4Sps74NjSefV7z+UirBP9t4DjZLtniVrD+Ic=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 14:34:14 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b4) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 14:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 14:34:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 09:34:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the count method of defer error
Date: Mon, 12 May 2025 22:33:57 +0800
Message-ID: <20250512143357.9377-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: cd358b61-4d06-4629-b382-08dd9162119c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RHa0/TDO1n30y0m52j1uY83ptkItEl8eiD1flsCU7/CHqlnqoJvZq3hrIEEB?=
 =?us-ascii?Q?rh1Y6rkORi/+6GQ6lHqdgoD/ck5tXaItawH9jdNVv56BHGmtpHhwj9QU2yWU?=
 =?us-ascii?Q?iougShnB8JKoAuLcWAsjXW6Q5BR4CPcVELshvlMrDFSTR0YSLTIBKAWijIcv?=
 =?us-ascii?Q?V0OjIShE5YwLWg6UUm4fHhs8HsQDWmyJtiec1XXDmrsjMmE0wO7p+uYYUrLZ?=
 =?us-ascii?Q?cPADXDWIXVj3hf6MzZOus+oOw/S6q2K28QizwCgr7IGhCQfPCDY8b9JqUu5r?=
 =?us-ascii?Q?8L7GDlb+krKu7yYp3JdzyUzUBB5rRSVgY21AaS29b3kTzLH9Sihvukd1IL5S?=
 =?us-ascii?Q?+eLIKJSxOM+1yeblXcScP+cBaOvSb3oKUPzRz5nnEAXGlhm3ajzdiq+iemsO?=
 =?us-ascii?Q?XlhlcsC4IDQpqEHAIOWhyMy6GGHptktRUKKyVDsQJ7L7x1HtlJnTndgKUGW8?=
 =?us-ascii?Q?2Zlfs5CCgE7sPm2k5vDXst12wWareIJ4gipHJjO6Go+/HmXghS1nfLbhEPPI?=
 =?us-ascii?Q?bkQK46c5eLL4UUMNbG3bMvUFYGZKQoD6uIg0pCNb9+6Wd79JKTE6ZeFxmBAN?=
 =?us-ascii?Q?Kw6UrtwaU9rx0M2zXIhQhzMk3golVN59h3tgPWyxkm4j7gI0zmhJC+Mzf1Tv?=
 =?us-ascii?Q?mdNguQK4qP83n3E0Az/+EUEthXFB0ruxB1jxkOBsBVFXnXBF0gpFuWCmdkFc?=
 =?us-ascii?Q?1HQAIou2q98WF8EeIn4PCH2xSm+dgeiBH+D9E2xNmlKspLqaDnI+nee1ZKFG?=
 =?us-ascii?Q?aWA+96xzZrm1woViGGIpP6CE7e6CuYRj/ltkOI/EnfIzEYTWrNpq1uVzBRAj?=
 =?us-ascii?Q?/kpWnbp2QF+jJ+hZSOJ9OHV2ka5X2N9nVV78ztvixNQzndbI0RZ3E313azrs?=
 =?us-ascii?Q?ylPYqR2XWIdJdvnerwJjdOi7jK55JvypfugSWWSteIWf/HvmodfqFMe7lcHm?=
 =?us-ascii?Q?On2pQgT5uWGSIAJRt3foB2pL7l2u40ukr7mbqU1ZABVkSB+wViNLvNGHq8ye?=
 =?us-ascii?Q?ElyxNojc9ihdhzQ62URhtlBR9+4dZsQ3dwZ/B5KieQ5emOocpSAYVpEhSrKS?=
 =?us-ascii?Q?FoUT8YQ7s93Fab8d2+x7LA8Djevf+h30ykQRWiN4sJ+9FTph0L6Bv0nMblkj?=
 =?us-ascii?Q?SAQ9UuR+c0FOklVhdcTK/wAUzQhYk1HyJwcw+2CqKikj70oxBpqIKLUO5SPE?=
 =?us-ascii?Q?HFH33f2Ja3uwH/O/51CGUn9mpWCuoYiNXrbAo1QVi6O0VsNO9G++MG3aq5qZ?=
 =?us-ascii?Q?Hy8x1t6B8fbGw6DLk6sFt24wjAmRUUMAlxKnRV8ot7mYYzKPX+lcL2Pj5xGE?=
 =?us-ascii?Q?i2Kj3F9HxtV7Nc4D1Rc7MnNSbcRYb2uk7kmqHwJgCEj0SsLWRjyICIdx6fq+?=
 =?us-ascii?Q?SkHnPuM0xTe84nG3XdeJOpFwmJ2Hb1KuqW9963JLZXFYYJ26zEaKrU0hwjKN?=
 =?us-ascii?Q?lZFGEM1pryxOSCQPN5l4Cz+r6d9FRQDf57L1h+FMKx0LtlWSL+xep+KHgNX8?=
 =?us-ascii?Q?+UPGvARS6C7uPFmr4YEeMZxvEBSJRWu/muZo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 14:34:14.3571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd358b61-4d06-4629-b382-08dd9162119c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

The number of newly added de counts and the number of
newly added error addresses remain consistent

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 8adceeee298b..c19e40d095a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -533,6 +533,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		pfns[i] = err_data.err_addr[i].retired_page;
 	}
 	ret = i;
+	adev->umc.err_addr_cnt = err_data.err_addr_cnt;
 
 out:
 	kfree(err_data.err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 857693bcd8d4..52fb71c4ce9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -130,6 +130,7 @@ struct amdgpu_umc {
 
 	/* active mask for umc node instance */
 	unsigned long active_mask;
+	unsigned long err_addr_cnt;
 };
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e404c074975..0a4ab63287c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -428,8 +428,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 		bank->regs[ACA_REG_IDX_ADDR]);
 
 	ext_error_code = ACA_REG__STATUS__ERRORCODEEXT(status);
-	count = ext_error_code == 0 ?
-		ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
+	if (umc_v12_0_is_deferred_error(adev, status))
+		count = ext_error_code == 0 ?
+			adev->umc.err_addr_cnt / adev->umc.retire_unit : 1ULL;
+	else
+		count = ext_error_code == 0 ?
+			ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1ULL;
 
 	return aca_error_cache_log_bank_error(handle, &info, err_type, count);
 }
-- 
2.34.1

