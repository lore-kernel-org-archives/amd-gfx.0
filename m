Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30432D4979E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 05:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11EA10E0F6;
	Mon,  2 Dec 2024 05:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bTv1Wk/c";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E0E10E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 05:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZPPlYWGY0ZEZn+6smvVCvPPFsxsxHPms0t7C8LHAq/KzSu6A4aOEHH/X7A4fD6BVvsDe74MqU3o4o/V9uVInaXmM4Z6OtxO+KwabYAKKZmPrl6KQttVF6SONREP+Uo+GNeeebLFkxYd7Jy3Qvi9tTxWUQrhUsUlEh9vEyJjLzPjonJ/oV8V9UwYu9VPwp06WvoyFWNo+xQ3i4U2hREUykFNsVy75fWvAPNolwT9+5CIIofVTdA8VjhYa3smz7A8lfQnc9onKpyUhTWpG3GQgxsxbTvuNwKQvUr1nyy9pTQua8d1A74oznbGfK8TNLolVhESqz2yN4np2u0uVwqGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZObSqpB25BwLKoSPH5sk6IlO+MEO8YfBS6LN9YCTyy8=;
 b=Tmx1sP8zVPMwWqRJhdj76UAPOFvuOLVb4ZcxtyFXH7bgZgN79PLd9A2JYN1aqeRks1vP8ZnIP6GrPwiAdvYKn2TC7lJ3E7C36EhrpU/kr1WBdHUagBQtaLJ++hNrgE4IXZClxC3ds31cL8aDWzl9JPo8+XkbUBL6W3iQPmPOXvPO1yH6cgwmOtUFghBipArmk5Ln9VhW9n+z2PDwbFlA/Viz0XWKUVyUxXhO/cVSAOlPsuP2be8b0DX0JlADlI+moWWpz1Qwvtyz9oHi69+PSwJwa4FvOnc0zSXlDf7d2vAEz4eoVJWSFxLO00Q6hU4XjOYp1Nz6EVh2Ir23iTJ5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZObSqpB25BwLKoSPH5sk6IlO+MEO8YfBS6LN9YCTyy8=;
 b=bTv1Wk/c7SXmT4d5GU8WYU0Eh7vbipGvngEn8cZYNJFBTMl17zhpprKH8081hUaAW07BY3PxZtCpHeSNYKxZtzorzSIk0YwH8t5GMBODczZe1OVjewLICL8wB+UhNxmoMr+rMWpfHOYEZMrbdD1mgCMl8QDzdViEpjR0kM2+9Xk=
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:30:06 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::c3) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 05:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:30:05 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:30:00 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, Jinzhou Su
 <jinzhou.su@amd.com>
Subject: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Date: Mon, 2 Dec 2024 13:29:45 +0800
Message-ID: <20241202052945.7303-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd77ac2-c4cd-40e5-7c35-08dd129260e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/6eqLgeZoys1Q3oN6uGg+HNk05cOvMuHHQO5Qi/XNf+g1OALhN4GvlTOPm5c?=
 =?us-ascii?Q?t1zY9k8XXbgMPXFp8ATHw5zxiAYWd88XuWdXKOkUyDhJv0JPd0sSrkpmNosP?=
 =?us-ascii?Q?Vp2oIyPeY9V8k/YXM8QTImb0btcRj3DKQ92VgYAN7X/6WXzG5TBb6pmQ1FVZ?=
 =?us-ascii?Q?kMOQCFUv7iajYD0ntADRJYzQ2FEf56lnp5m4gqU/inWKIRHrT/WT8/ekP8nr?=
 =?us-ascii?Q?YWTyQQCAkCqgKXU3EMCKIU9/SXC32ROvWXgyHloFxU0hkJxSjDuzATVHujpv?=
 =?us-ascii?Q?Iwfwwl2VprDx4FqOP+TRaQGsAIoENVsDkz2lp3+S+ATk7yHx9OPdEtw97L5H?=
 =?us-ascii?Q?EzA29+nS2ZotlTgqvWeYLxg15bK7WEgT8dtIN6oxukNyFfBblLE2v6qzeCei?=
 =?us-ascii?Q?gdd7O5hVGvKNEaOr38kDXWoEY1aEtHJjeqlqauWymG0NbgOvQ0X6ALJPOq0i?=
 =?us-ascii?Q?WSsLBupORis6vJNvKSgLNzQSSNjoFxxpQrGSLMWA0BgKPzq8BysEJfHxdfoT?=
 =?us-ascii?Q?rUQfI63Kdt0uIAdIxQnJZFAAu2N8ubtl2e3uwqCiAFY5chsRs55liXDps1VB?=
 =?us-ascii?Q?vMSfBxvw1ZR2wYBBoGtlXkV5YefeF07Tz1brB2GgvbwaO1YQUWuS6M346yl8?=
 =?us-ascii?Q?wpt5YcsusR8nTDellqPeqIxAaST1RcYnxG22cZ3CeD25W37JpUgWeZIatahj?=
 =?us-ascii?Q?vCb6Xvu5PNt8SDSAvEK+yxRtjJvx1QpA/U2kQaW58szc00QWS5pDzE6GisiQ?=
 =?us-ascii?Q?xGt4HGp38U+nhUVKHO7GMEgPgtfEw0xwv93En6gPzWfTV+FAwiTNpb/5zw1d?=
 =?us-ascii?Q?W+QNPRFOkzN4u61AoBCHz8m+6EcwzZbwe7J3F9hQxxnIbClV973Uq1b+azTP?=
 =?us-ascii?Q?ZJmeHmBR/V2MrAK8DbZidLcMHjCthEp5Rbvx1TWz5YZKci06Fqnb6T5l+ZBu?=
 =?us-ascii?Q?1AtlgM/6qOBknNj+Lk0WwrLgE99D+B0nF0C/p84+8w6hN/M0kQHEsKh55xC/?=
 =?us-ascii?Q?z5m5uWdfZbX8enNUBsqSJxvi7g4Nd/Bm0AqZHIPqi5ljvoMyUu7rOuiahHmu?=
 =?us-ascii?Q?BfzxFh2I/9h4/aw5/X4FR5Fm0dpIO/HcGfQOTDXuljPDU41zlhlMSFfw5F8W?=
 =?us-ascii?Q?SnDHjCL78a+c6XQFpUWnbcPuW34eiXvea8V/FShOcb80ni6zEJwclrhuiBCD?=
 =?us-ascii?Q?fgQw18RX20MY5HA2tuEaYZlADkS1IUqlOfkkQ45Dfa+zg9d7/VWFXvG5f1cV?=
 =?us-ascii?Q?gXZ8j3PmV5sUCRvx2osvqiVdEJT1X0/4DRpZmRXNppgV+3unLGkVXQJ7QhML?=
 =?us-ascii?Q?+Y4iShaWCwG6T6W8N8UplCYd6PGxunv6Qj4oEKzDjcTEkJJ28Q6cacmb4sNy?=
 =?us-ascii?Q?PixaMBQ7djC7icShyTIsI1L6DlIWXNz/keQk/1Yqa/v/oGyqUtHyjSZVrf9C?=
 =?us-ascii?Q?L3XM/3fxW8zXQc2LjbPMhFnv1Rlbl0zI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:30:05.5355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd77ac2-c4cd-40e5-7c35-08dd129260e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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

Return eeprom table checksum error result, otherwise
it might be overwritten by next call.

V2: replace DRM_ERROR with dev_err

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..bd8acb55f76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1412,9 +1412,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		}
 
 		res = __verify_ras_table_checksum(control);
-		if (res)
-			DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
+		if (res) {
+			dev_err(adev->dev, "RAS Table incorrect checksum or error:%d\n",
 				  res);
+			return -EINVAL;
+		}
 		if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
-- 
2.43.0

