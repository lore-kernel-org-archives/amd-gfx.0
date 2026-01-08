Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14778D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACEBD10E67C;
	Thu,  8 Jan 2026 04:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEi3dfBS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363C810E67C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZpeRwAvYZEssDDTRO264NfPtyrvU9ptGruaaHY4i4maJE/PNTt1uUHDLYyJCJwS7KLE0PM+TZuEuIAUjKjSi0WJNQbDxYY23KHSCscwmPcVP8wm3nYUFlo2t9YR8yCQytzypHxSbvVWVqK28iK9kj1ZU0wiXVxQGzM41yi2YNUnx600EOmnFQpU8KBRA5qfQRa3NuUa3pTJtiS3AA3M+AU0sBUGh5jTKsFKJ+AUhehHy4wyczaYg28L46zHgJDHdgmIh6sdVobZ1qZE97B10AdiCy5zndn6pwxf+LrESu5EYXyGFNS9NPQeTyzAxCZnsoY+pfSEeV9Fo9eyI2/M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqNVElR5zeGRB9AswjfSHqIJxUjWcB2JemHZn1ydgns=;
 b=NY55HRezArKeMIbVE+fJWk4sVm3pD12fofK2NFKOF3nTDH8JDbMbU2xZoLuu7wpktd062KYECBR1xB3aCx9+tx6hWm7htvrGQj/KRiV1LvnO4X8KZovymMk5wuQastEgnrO+dbY0s1hDkzyxdjjJQ9l+6RLyHspRhKJCGcIf7caVyvUEXaPJLghORnGznn5Pio2HFrYEnTbGlnhqClTM6HOa7llwe1mAQDQ3bWQrl9+5PQo0ghflgHwX2IjduvdcqXlYouMhmGk56xczpJY8xlTdLvRofXB0Auj27WSSrsUhhh1baxcBOb5Ctxx7rjyORkc1iDejE3R2dyZcQDQwUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqNVElR5zeGRB9AswjfSHqIJxUjWcB2JemHZn1ydgns=;
 b=fEi3dfBS48qISq92pcx7YV09P30Rl2dkAFjRHUJUKTYdmTDkfTjJ/8R9+ICSiEO5Zn7x+ymQTOiRsuBHX3B5tKeRyVcX2orKExiDx3jyPaVyms8+8ML9JqTQix1UkP6TSoD5DK6g0Bpcqll4UUcz5PnaKxWGSK8VYuTDHByZvv4=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 04:49:29 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::d4) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 07/24] drm/amd/pm: Use message control in messaging
Date: Thu, 8 Jan 2026 10:17:23 +0530
Message-ID: <20260108044839.4084279-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c180e8b-2a8a-495c-1d6e-08de4e714e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AqQ5INu52ucpH6VsyxK1oE0crBtLeCAekLb/aSpSVXaynI/7xgJfhSD0T1li?=
 =?us-ascii?Q?OjRxWuaeCRIsWtoqZ2d7Xk8HfB/ZQZwqM48LPbmohtyKNKy4ySa1GRo+gRgE?=
 =?us-ascii?Q?kaHQDhImVM2IqNMZsEoXtwIZwhHm+CUtcE/c59fEbffVlgEf+ZtzQgCwbWOa?=
 =?us-ascii?Q?PtorDU6327j1MVHSw49ZPT/kQIfwxE5/AW2taEvjvDkDADjHEgQOd/wyR5qw?=
 =?us-ascii?Q?aWEd+gvHU6sOdI+f89WnotWHo9/KPW/PEDGoZ8vw/OXaN5aNFcg2rhByYK2D?=
 =?us-ascii?Q?3ZLSGNhA4wIQVD+nqtjODa5qE4Q2f43rYL1iT+Q+NsG/In7OB7/1np6tjLBF?=
 =?us-ascii?Q?TVw/QDP0gSYp8TsJqr5K1PZELkdj4cb38cAg1lRhenF8fRQDQlowk9h9skuN?=
 =?us-ascii?Q?bxIMnhGfxpBQ1G+d8l7U413IhaBUJ21T3zy7lJfVU54MM4n294tBhxwgpdG1?=
 =?us-ascii?Q?QtD57e+hidv4VJSXSs+YK3S5ZRAzAGJ6bgCmFZfn1wb71/v1eqbME5mlOuHG?=
 =?us-ascii?Q?52YFfY2RcyN+au3NyvwW8aKZ9BJPeuyBwAgltR6gmZFSCqcMe01VluL5ORdS?=
 =?us-ascii?Q?QfXqUvrK1Q3EuESSSjDO6wsnrvKX8GmFsUWe7sKH4xP1HmgdfN30pEE8JIMj?=
 =?us-ascii?Q?OCMswbEmW9JPfTF7lAG86k9P8t49K0o7MnbmIpM6h0np+3yrWn5/lsD7Rfk5?=
 =?us-ascii?Q?xePZu0IHA0EhxO/0D1ZDVOX81F+mkf6Es4wJJbEcTPjBgAzqRLKc8SPdk3yU?=
 =?us-ascii?Q?o+8Q33bvwctsA5SWDcwrFM4vYqUgUndhYT8+IuZUej/iLzKfAS1KQISob+BI?=
 =?us-ascii?Q?Ha4p04oeIm4lWZF00cNgWWKd2oxwdsWqQ2Cwuq3pM2zzyu4h/19JJa0u6tr0?=
 =?us-ascii?Q?PQuYSTYAixSpO5hVIbbyYphXHWMk9/4Q0L02dbE825qo5NERN/w7Xz8ln18w?=
 =?us-ascii?Q?vdPGSNAs3axCzQp1Uh+74HLrUcT8XOMwiHRKzP/B8Zs5OGvSNxfwHk86gg+Y?=
 =?us-ascii?Q?bbtrU9rxzqGBFnsoGhuR2isM4RU4Lv3U/as6bGDwYgUw2OSR1DSYAhpzm1QB?=
 =?us-ascii?Q?mCxXMR2m2kC0KwESQXq135hSqjbT+HcPRDX/DycAEi/+keG1Px16+IuWxDXv?=
 =?us-ascii?Q?+aAgitJ7lPL+zF3/AAU0SdIj1FnhM703gZjzafA9EkQUd6Ppkd292egJP2VC?=
 =?us-ascii?Q?6OI76ssO9nKNENtXiAHReAPV3nKBOJPOjAuo1hlGFsvT1eCdL52+fSVssdwE?=
 =?us-ascii?Q?4lNKWQIMrEmiTxkM2Ao36TXGnCJ1puXFo8dtjMfOXLcPHwPlJCMZFTJCBx53?=
 =?us-ascii?Q?XUldpXaRz7YybuD7DttpqaLGNqmZutPWsmhRwCh4VodYoBdu8LYS9Ok24U24?=
 =?us-ascii?Q?CoiNKLhBO7GUROJ8Xv1C+E6cZjKk3QBGzVooem3AQigISpkxxjtGayrDbIck?=
 =?us-ascii?Q?KmpcaFayi4DARkKIE2vFE0bVrwb3rRcoaAq9bAnoZDks0EYawq6Yl5D+qVDh?=
 =?us-ascii?Q?EeaQ9bWPdWbBPRGKegsY/zhVIz8kDIAVYL3bfx453QVCwjV5tSi8HrsrGJTg?=
 =?us-ascii?Q?2qli6NLw1NpIyw90DZ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:28.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c180e8b-2a8a-495c-1d6e-08de4e714e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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

Use message control block operations in common message functions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 217 ++-----------------------
 1 file changed, 15 insertions(+), 202 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index de4b7f423a76..ef603a4d57f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -65,14 +65,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
 	return __smu_message_names[type];
 }
 
-static void smu_cmn_read_arg(struct smu_context *smu,
-			     uint32_t *arg)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	*arg = RREG32(smu->param_reg);
-}
-
 /* Redefine the SMU error codes here.
  *
  * Note that these definitions are redundant and should be removed
@@ -127,75 +119,6 @@ static u32 __smu_cmn_poll_stat(struct smu_context *smu)
 	return reg;
 }
 
-static void __smu_cmn_reg_print_error(struct smu_context *smu,
-				      u32 reg_c2pmsg_90,
-				      int msg_index,
-				      u32 param,
-				      enum smu_message_type msg)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const char *message = smu_get_message_name(smu, msg);
-	u32 msg_idx, prm;
-
-	switch (reg_c2pmsg_90) {
-	case SMU_RESP_NONE: {
-		msg_idx = RREG32(smu->msg_reg);
-		prm     = RREG32(smu->param_reg);
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
-				    msg_idx, prm);
-		}
-		break;
-	case SMU_RESP_OK:
-		/* The SMU executed the command. It completed with a
-		 * successful result.
-		 */
-		break;
-	case SMU_RESP_CMD_FAIL:
-		/* The SMU executed the command. It completed with an
-		 * unsuccessful result.
-		 */
-		break;
-	case SMU_RESP_CMD_UNKNOWN:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: unknown command: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
-		break;
-	case SMU_RESP_CMD_BAD_PREREQ:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
-		break;
-	case SMU_RESP_BUSY_OTHER:
-		/* It is normal for SMU_MSG_GetBadPageCount to return busy
-		 * so don't print error at this case.
-		 */
-		if (msg != SMU_MSG_GetBadPageCount)
-			dev_err_ratelimited(adev->dev,
-						"SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
-						msg_index, param, message);
-		break;
-	case SMU_RESP_DEBUG_END:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm debugging!");
-		break;
-	case SMU_RESP_UNEXP:
-		if (amdgpu_device_bus_status_check(smu->adev)) {
-			/* print error immediately if device is off the bus */
-			dev_err(adev->dev,
-				"SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
-				reg_c2pmsg_90, msg_index, param, message);
-			break;
-		}
-		fallthrough;
-	default:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
-				    reg_c2pmsg_90, msg_index, param, message);
-		break;
-	}
-}
-
 static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)
 {
 	int res;
@@ -252,54 +175,6 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 	WREG32(smu->msg_reg, msg);
 }
 
-static inline uint32_t __smu_cmn_get_msg_flags(struct smu_context *smu,
-					       enum smu_message_type msg)
-{
-	return smu->message_map[msg].flags;
-}
-
-static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
-				    enum smu_message_type msg, bool *poll)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t flags, resp;
-	bool fed_status, pri;
-
-	flags = __smu_cmn_get_msg_flags(smu, msg);
-	*poll = true;
-
-	pri = !!(flags & SMU_MSG_NO_PRECHECK);
-	/* When there is RAS fatal error, FW won't process non-RAS priority
-	 * messages. Don't allow any messages other than RAS priority messages.
-	 */
-	fed_status = amdgpu_ras_get_fed_status(adev);
-	if (fed_status) {
-		if (!(flags & SMU_MSG_RAS_PRI)) {
-			dev_dbg(adev->dev,
-				"RAS error detected, skip sending %s",
-				smu_get_message_name(smu, msg));
-			return -EACCES;
-		}
-	}
-
-	if (pri || fed_status) {
-		/* FW will ignore non-priority messages when a RAS fatal error
-		 * or reset condition is detected. Hence it is possible that a
-		 * previous message wouldn't have got response. Allow to
-		 * continue without polling for response status for priority
-		 * messages.
-		 */
-		resp = RREG32(smu->resp_reg);
-		dev_dbg(adev->dev,
-			"Sending priority message %s response status: %x",
-			smu_get_message_name(smu, msg), resp);
-		if (resp == 0)
-			*poll = false;
-	}
-
-	return 0;
-}
-
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
 			       u32 param)
@@ -375,22 +250,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
  */
 int smu_cmn_wait_for_response(struct smu_context *smu)
 {
-	u32 reg;
-	int res;
-
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-
-	if (res == -EREMOTEIO)
-		smu->smc_fw_state = SMU_FW_HANG;
-
-	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
-	    res && (res != -ETIME)) {
-		amdgpu_device_halt(smu->adev);
-		WARN_ON(1);
-	}
-
-	return res;
+	return smu_msg_wait_response(&smu->msg_ctl, 0);
 }
 
 /**
@@ -430,70 +290,23 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int res, index;
-	bool poll = true;
-	u32 reg;
-
-	if (adev->no_hw_access)
-		return 0;
-
-	index = smu_cmn_to_asic_specific_index(smu,
-					       CMN2ASIC_MAPPING_MSG,
-					       msg);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args[0] = param,
+		.num_args = 1,
+		.num_out_args = read_arg ? 1 : 0,
+		.flags = 0,
+		.timeout = 0,
+	};
+	int ret;
 
-	if (smu->smc_fw_caps & SMU_FW_CAP_RAS_PRI) {
-		res = __smu_cmn_ras_filter_msg(smu, msg, &poll);
-		if (res)
-			goto Out;
-	}
+	ret = ctl->ops->send_msg(ctl, &args);
 
-	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
-		res = -EREMOTEIO;
-		goto Out;
-	} else if (smu->smc_fw_state == SMU_FW_INIT) {
-		/* Ignore initial smu response register value */
-		poll = false;
-		smu->smc_fw_state = SMU_FW_RUNTIME;
-	}
+	if (read_arg)
+		*read_arg = args.out_args[0];
 
-	if (poll) {
-		reg = __smu_cmn_poll_stat(smu);
-		res = __smu_cmn_reg2errno(smu, reg);
-		if (reg == SMU_RESP_NONE || res == -EREMOTEIO) {
-			__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-			goto Out;
-		}
-	}
-	__smu_cmn_send_msg(smu, (uint16_t) index, param);
-	reg = __smu_cmn_poll_stat(smu);
-	res = __smu_cmn_reg2errno(smu, reg);
-	if (res != 0) {
-		if (res == -EREMOTEIO)
-			smu->smc_fw_state = SMU_FW_HANG;
-		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
-	}
-	if (read_arg) {
-		smu_cmn_read_arg(smu, read_arg);
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg, *read_arg);
-	} else {
-		dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
-			smu_get_message_name(smu, msg), index, param, reg);
-	}
-Out:
-	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) && res) {
-		amdgpu_device_halt(adev);
-		WARN_ON(1);
-	}
-
-	mutex_unlock(&smu->message_lock);
-	return res;
+	return ret;
 }
 
 int smu_cmn_send_smc_msg(struct smu_context *smu,
-- 
2.49.0

