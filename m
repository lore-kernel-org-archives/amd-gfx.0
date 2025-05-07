Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9E4C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0660510E107;
	Wed,  7 May 2025 02:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJkl96/s";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B4C10E107
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG+JUtDiXXwEE2J7rmTeSTwxxoCqcNP5dXyaSlU/wddHWE+sYumyCEIR06GCagxJ2THroUZuT3PZnA5B9mOn6TWH3q5VtpNwC1Me1bbG2b/r9yDiD6QUK+P+OATqeid5NLDuRLKHbIsH+E7a55GZD/ipbENtpqeJ2clgzu/nKtwuAkMKim63s1Tdzd0K00GfkdskdvzAnWPTU3DbHkSh8i8gmSKkpPmYJ4AyH083bD0GJMC2JCf3LGNBRKy77r6V1lw3fF5nY0xhh4vBW0kDVn+u9DKn3TpxLhbNLNzz/clo9CQVUb45cgP+oWajr9h0SZTgT7B0iVGeoM4hpHMkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAyB5RyJr1M7ncHLuRH0LsAkV+WaEy9mWjLDoKFJjAk=;
 b=mn4pM67t9QccKovjXiRrpEL7TfnujsxPOIcOrmjavJaDaZrUoQDQHfXzOHYIk+7Ql0zW1zHplyjMp+a0ZTrTD1J7wuTaZCNvvTw3pBiaN6CNRzWqKCiZ6FXPyVDFiMkzzf4qJLC1V6wEMR0NAYkQHGCVhVGzkTOaPnabUqz9tPHHV8gT+Gkk9pvJnaQEoYcJBiR8uUNHCF/vqY5MlciQ4vl85k9zjB6eF/X+I/Xb4WLHlUAVzynsH6IrG9YJIRpQSkJMhQJQLP7AIBEqyKTxOCzNXdUvOD9s1sPQaJedIMhrkLW56hA/ka9Q7QpHQ3Dc6c7RXLWVTFlCETPCgd0Maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAyB5RyJr1M7ncHLuRH0LsAkV+WaEy9mWjLDoKFJjAk=;
 b=RJkl96/shSWG0flcz7W1KJ0mJWxMVsxUF0jnDLOn70UUZLO5XIA1qmepdZDGA4vuLuOcTUoCoSr7ndzTsAfUZstJFLeufyzfw9i0HRcYdBUkfxY5HLWPaOHeM6dn+lHBFI5p2EtwQFYJES6J5jQsfa8rXgu0S08Mq+6CS+SlaHg=
Received: from BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Wed, 7 May
 2025 02:24:45 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::80) by BYAPR05CA0064.outlook.office365.com
 (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Wed,
 7 May 2025 02:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:24:44 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:24:42 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the count method of defer error
Date: Wed, 7 May 2025 10:24:32 +0800
Message-ID: <20250507022432.368396-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: e49ebe5c-5ab8-499f-237d-08dd8d0e54a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otYEXuY5OZdtnomvKs2+VbH+ilYHmxw4OEj+cLyV7l7HrJnyJAbQN/OADumK?=
 =?us-ascii?Q?r06f7KpshR2SR4E1rbTJZ3NFkE+2otmjZtni1g4M22XitIse1znljR0eNCuW?=
 =?us-ascii?Q?NyoRTuT/AQ+09YCBDeitR9FU34EMl83YAQXODqGQkn/NcSjMyWbaukksZYE3?=
 =?us-ascii?Q?9iHXhzhbOlOhzLHLuldyqt3/JXrC/za0oFmTcpb3dRqrF0d6dj2pEq0Bps9c?=
 =?us-ascii?Q?V+Kztb3O+/gu9Ds3KIU4TrgSNCdQ2EvLC9Zx1xs7WNdvg73/1+LQTDj72Ksz?=
 =?us-ascii?Q?TtwqhJzGSavE79WUyvNkBWWIZDTdkSxbDysgSeOEm19iEJqvBQR2p193B7S6?=
 =?us-ascii?Q?jK7ZL/wMLLOQt4S08mH1cw/HVIsht0YH0igg5BRNltoY5ddMQHZydeDjIpm/?=
 =?us-ascii?Q?YigWnF/dfSkBkIRf3EUh7l6vVnnrgqgU3Pgav6g112zq+SV3qXwN1lrfUvCi?=
 =?us-ascii?Q?fptL7jcxcfsptEEnlYiZa+/5KF4lTVX1/QsDvBpAr3FiYOImRUx/snFxrTJ2?=
 =?us-ascii?Q?LrDH294qpIU0gDJU+89pPZGLnbuZdNonLiEKiGlL9idwRGCgDJgQ1UuMXUIY?=
 =?us-ascii?Q?ZmBCG9QDgW0JBnuaSNqjUvVO+PygvhGWy/vmFyl9UdEb7wO5csmwTcVjtcvz?=
 =?us-ascii?Q?r124gamxQT1Ah6I6UDwbE4Ga2OZSAfkLiY14+bMHrVr63QxMeIT0WWq+7GH1?=
 =?us-ascii?Q?7zsJSB5EvQ9gebqBsYkwxkuC6TFKf97iN9UJAR7+XJLdqBKERWE65cd+Rwe0?=
 =?us-ascii?Q?cDXGe/ZipoPWuXYyhEL8dholONFtLg7q7ElA+w1Do4C4Wq0csQTXCzkqksD+?=
 =?us-ascii?Q?ZGxu0o1jtKF2MMUa4la71JENggXSfz1CdyXkrh3uJbTsrUdbVb4Ewm2AFxE6?=
 =?us-ascii?Q?yykIjNsq0o8og4SlPuI0FQZtQD4V3IyGXILKbnR52IIt6Tfq7VgMWUnYgKp3?=
 =?us-ascii?Q?zlP1jDMEBb2buLEcTles/DbMvOKim6vWWsgWONcg6q116QBhXgsRqUixO3Nq?=
 =?us-ascii?Q?ZeT+Uc68e1gFkGPtY+JplQekS5DmMSx9bNlB59t/8dofG5bOtVbEgdUM78Tr?=
 =?us-ascii?Q?bgfgK8OQT/muNd3uK9hk/rG87itRTV7gBjzxKq9BeAhWJxw1c4dIiDE/SnLr?=
 =?us-ascii?Q?JVfqzc++q3vVzl75Bj1Ew1qBFVdnq/g9P/timjDn6oLVdz51EDi+Byct1t+N?=
 =?us-ascii?Q?Ff5ZAkRSoJ8Pns/9gT8CBwYRyRL2eBS5mOC7YpcC0CjR5uoLTbW15wimCeHc?=
 =?us-ascii?Q?V49EQgQ231IYDaprj9XFf81A1lF6AvsP8pFcgKbvxQiXz+Anak6vJN8gLnbj?=
 =?us-ascii?Q?OZRUDM5SSVOJC4xNwX6YO3jokKPgIyARiJzIS+yOH+wHvXU6qr9Lzrb/Eb8o?=
 =?us-ascii?Q?6GV0qIN0wDjDqJuVNf7rBJyVdWrZjX5xva+H/M/LS9PQAMXNw3jo1rzxrkZn?=
 =?us-ascii?Q?uBqgvnmtwqHddLZNeS3XlaS5ljNDoq3LpAWkVX/7PpkzhcDn/ORsI3nbdJ3d?=
 =?us-ascii?Q?4wysUISUjbDx6PMUyrXyQE49sbQpS4Bub0+D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:24:44.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ebe5c-5ab8-499f-237d-08dd8d0e54a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index 0e404c074975..eb3f99dbbcd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -262,6 +262,9 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 				soc_pa, channel_index, umc_inst);
 	}
 
+	if (err_data)
+		adev->umc.err_addr_cnt = err_data->err_addr_cnt;
+
 out:
 	return ret;
 }
@@ -428,8 +431,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle *handle, struct aca_bank
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

