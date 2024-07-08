Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0ABC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 08:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6063210E030;
	Mon,  8 Jul 2024 08:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZCjRTCV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC29A10E030
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 08:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM90YUYUqfFwzRcvVA5Sn40oPpYB4RXtRGQbIi5N3axUdDAnzG/NeEVV8+37OzCv0FgWcZnAmxXcuGAmfiNrFhoNPmdXGTFG4TtVfO+/2r2ZcdF74HvfB5odYFwyofnuKMkaFuS984YCKMHkpGkrJ/YWBn94LoFS+bI/Uhq6I6GxHh+YodXRaCGtTbcwCUltSymLrz/XsZfQZS/4lxobxeiylKb8mv8ZDw+pdXYa4WkA15vHb2ni0HKUV8cyauM5DGOgg6j7Vd3V9eRWf+NgKtRXroOpzCrkG3Qtjq4dV6DJmunurmqz8HcyFNc0mxkiIUTqHN2M+Yt6PqpF6HbDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBw1XXGC1YnIopmUy7IoARVdhxSPrvAccLMUs0Bc5gY=;
 b=C5aTAIf5Z6wN8RmMWwHcFgjTcAyAjw8ghX+xUeiOTDS4bSPLF5E1cTlYr9Tma/6dM24H/8+WYLnPzR6GJpmqKmml20s+w/TlVRqV+MAHyY4NUrZGCJS4SplstGc3GpTruWlNUFZNM8D3Un1nO4gPJyq2x+xU8vOevg5Ks0D8Kl6sZn4/fVlVB3XGqUHuNd6gl8TwR26I/MyYY5P8LniuOrRpl1niXVYpVTqUTzp2DVc4aJ6xcl+/D32FVt/z91l0bzrH4BQrHbQKGAJRLhtMqidaeP2j0CvX/ChxS78n9uCC/S6nYjYYtOtPd6gYwhOwm9DeHP+PmufTraH5bo/UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBw1XXGC1YnIopmUy7IoARVdhxSPrvAccLMUs0Bc5gY=;
 b=kZCjRTCVRkoSJ6kjgk7G2LNpu5HAKFaU/19dtJQNpC0kg41TV+xx5EcmYs5M3oY7WP5a6a3PlN67oJjJw1IsUGXh2G2xk+QPY6pl/JppgZCYdVdwGyy3KBVv8vRJpMAY0HuK7IjFvEc85EjlV6rm77QcpTILIeMgbqLkmle5L/A=
Received: from PH8PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:2cf::12)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:41 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a1) by PH8PR07CA0044.outlook.office365.com
 (2603:10b6:510:2cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 03:02:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 03:02:40 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 8 Jul 2024 03:02:39 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Date: Mon, 8 Jul 2024 10:06:54 +0200
Message-ID: <20240708080654.31640-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: danijel.slivka@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6853bd5e-e929-4370-e12a-08dc9f24576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z1rAmZLVeMcCG2/W1kIyt+asAutwD8e0b1iCkymXcqN1DPfqp6iG2nU3h4JT?=
 =?us-ascii?Q?qrDu2olaGQLQ8HWlmpEGgndMt+Oc+UWmQHR87snGztb2tvziEfC1lgbTOndG?=
 =?us-ascii?Q?FoLnvct6LQLRqnsio3lVjp1aXqFOxke2g3Y8JwFR0/1p+WCY9DHOg7LfBePH?=
 =?us-ascii?Q?bFs690rUjW0c9K5DyL+SkdV6P7KZ00w/mHOz6V9rrz8Z3Kr1VXIIUhGr1Xg5?=
 =?us-ascii?Q?xVv76xosASn1jA4WgyubrpGaLuUrRTXqAblSu5IcMgeY5QRVa541DFk+/i5o?=
 =?us-ascii?Q?mvMGmjyppowZjK3UkSlaZXt1MxBPP3+BNA6rrj+CmWMN4LbcDqk846xYu1a0?=
 =?us-ascii?Q?3Z4YDxpXziPYTw6/7kVIx6mgyROO/ZY+v4UM1dYhVIpOi7sXv47cd6DKHFJf?=
 =?us-ascii?Q?jofY8WX8ypxKj4kutdM0gKMz+9R2yc471WNodAluPBt0cfGbwCz+3ONsFhtu?=
 =?us-ascii?Q?oR8kUoaF6SYmR0O4Bl5uZJFozYNGvUNruNExuLzH80j8p0iwaiTYqyPQzQNL?=
 =?us-ascii?Q?Tv2kdtrlQzJftJRh9ivZmBf/Twd1zzDXmJnkiAh+SCjQSfMUuGfxS3ulrFsn?=
 =?us-ascii?Q?PiuQjnpH+Xdt+SA7+lgAGkuYhVvY5OtdlQtrdsCwOsS/cPlJbC4VNntJ3baT?=
 =?us-ascii?Q?X/E7+whqPkvn271NiHN6wLsfsPKcAyd+0UdDbPX4vOaawH++Uq9oJ8xCL3f4?=
 =?us-ascii?Q?x/T8aJcEJkIERd7OO1GiOjYXqrgs9sOhx4WHHImspaB62KndzB4pg/N7j2MN?=
 =?us-ascii?Q?ApjUDRRIYnOciu6rTa0X6iAg+HznCCOdXAZDSm1YXhCsxZyY34ftxaGOHcqd?=
 =?us-ascii?Q?7UjvwTP57cPZc97G9tHa14D8UArRnz3pgmhDUvqFx2JEfl1SswRdb+yu6ndk?=
 =?us-ascii?Q?B7lMibPR7yRYcChXxXpuVik5Vz1eMuIwyevhaPCFqlpgqjZwA09FJJ0aUq6c?=
 =?us-ascii?Q?F5wZ/Z1UK4XRitnri1kmQmltD2VxrRxPbPaMEsbKioCYE64+ztYr54vMHeH0?=
 =?us-ascii?Q?KK9ZXvpa3oGjZ+EYmwBNsH5Z1vz9BcDP+kfx0fKQGcdPKd3e2Qhpm9wRqC7V?=
 =?us-ascii?Q?v32mKwEcRmyXaGJWxrhMkNZWHd2wIH516na0gLf1Qi0PMzl3/vYOe8P01IPl?=
 =?us-ascii?Q?vUjTweUnpLN1+iKD4GTV+xtkmSJ9CW6xEBVm+eRAjCczdCe7PzQ92GrOBWwM?=
 =?us-ascii?Q?2cKYTWK1+6FS+rcNkkvpaxzXQWr4raOFhWBZTt94RF56D0hxM8Kf9426aaFK?=
 =?us-ascii?Q?hVCu31kz84vPZ0FwKw1BoMi30hO0JDZvd+Rzy0wGdRhKc1UXzegk18ZNRK2u?=
 =?us-ascii?Q?c/MBYWSG/g79zoHA+UIdM4TOya5DsqwTWqNn/fW+dk44uNvddZeUkzk9QvBj?=
 =?us-ascii?Q?hYXM0t6tD5S+9iZBby8wOh2cr37DEyphfPvpsnLnrnWlAFdDWNLmecD70sfS?=
 =?us-ascii?Q?fzDwdh+E554UXMChbDHEFeg9Sp8ImEOa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:41.2910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6853bd5e-e929-4370-e12a-08dc9f24576c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver
load or driver unload, subsequent amdgpu driver load will fail at
smu_hw_init. The default of mmMP1_SMN_C2PMSG_90 register at a clean
environment is 0x1 and if value differs from expected, amdgpu driver
load will fail.

How to fix:
Ignore the initial value in smu response register before the first smu
message is sent, proceed further to send the message. If register holds
0x0 or an unexpected value after smu message was sent set fw_state_hang
flag and no further smu messages will be sent.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a34c802f52be..bfe08fa0db6d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -562,6 +562,7 @@ struct smu_context {
 	uint32_t smc_fw_if_version;
 	uint32_t smc_fw_version;
 	uint32_t smc_fw_caps;
+	bool smc_fw_state_hang;
 
 	bool uploading_custom_pp_table;
 	bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 5592fd825aa3..9e4e62dcbee7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -421,7 +421,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (poll) {
 		reg = __smu_cmn_poll_stat(smu);
 		res = __smu_cmn_reg2errno(smu, reg);
-		if (reg == SMU_RESP_NONE || res == -EREMOTEIO) {
+		if ((reg == SMU_RESP_NONE || res == -EREMOTEIO) && smu->smc_fw_state_hang) {
 			__smu_cmn_reg_print_error(smu, reg, index, param, msg);
 			goto Out;
 		}
@@ -429,8 +429,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0)
+	if (res != 0) {
+		if (reg == SMU_RESP_NONE || res == -EREMOTEIO)
+			smu->smc_fw_state_hang = true;
 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
+	}
 	if (read_arg) {
 		smu_cmn_read_arg(smu, read_arg);
 		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x,\
-- 
2.34.1

