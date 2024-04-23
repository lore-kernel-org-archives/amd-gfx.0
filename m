Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE37C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797DF10FD79;
	Tue, 23 Apr 2024 08:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n1VTEX5N";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D99110FD79
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YopY5Vx3/qrEB3Zl76hhXrIiyX12SIaARzI569HjybW6vZlchgc+1DJDc5J66PqU1KvbPw4B+SYQgIunGGe/OiANeCbMI2hd8F0svCKhhPJP0bEgGVeo6lDbB6ZvKQrYdkvAMJ+uW9i7M92BW2YnutuA1Q4AEPM8pyi8WL/0iK9wKbNBA6IsZGItqXdoHMYAlSiW6yDZBNSQ4HRML2PsmYQ/OyWRR7rWXLTs6CzBgDLKxTKpcK9N5AAHoxlYsLaXtdOT++yhOhBxNzGm2CPqtODyf3TSFDhfXqnuc1xWD78MtYZMz8m8qG4LfnKnLp78vqa5FHKjo5IrnoTqk05Y5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kev4S4DleSxvgRUm/OWebpmEg67dHAK/WQF323nIFpE=;
 b=BFq6/9T3EBVpEy1UaeouAfvx6OIbuWI5lA3Sywpq4OsOeHQDVjzfh88I85aUrA1KZgIryfoD7Je3vdSpcKY36kA4skl71Eb+EOorFhlWa0vhvSyLjsTHjA5zA4oEHsu8g1kUptJBspeA4qVl7GlVFkuY9zmPUVJq5KScmc5GheDkaO5Oxq0O2uLlI3+nSVFiEhXFGSI89XxQmnlyl6iVrtbDdGyTD4guyK7DByA6tEtUQ9BfLRqOtd23px3boVIC+lxC73AwPtBJIV2B68BhJGOGARkdcHw52n7ecZ0WZsoltn1osZPEHPINLAmyD9xwNt+jXt6Bp2dJFKl7A8ry6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kev4S4DleSxvgRUm/OWebpmEg67dHAK/WQF323nIFpE=;
 b=n1VTEX5NlxWmS1GTBusUlUVt2i6hJrAUyPmcJFUa4kbzBRxpH/gl6qBuoRMAQdo37K6n2/MkZNhlAri4LJC+6+QIv7GPTw06ETixzlyNJMft93BP73uHCskQx9nzAzwXu4wDlWDUe4O8A0v30svL/FB6hVbFDN3ijXeCUBYcPWY=
Received: from DS7PR05CA0041.namprd05.prod.outlook.com (2603:10b6:8:2f::8) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:44:23 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::ef) by DS7PR05CA0041.outlook.office365.com
 (2603:10b6:8:2f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Tue, 23 Apr 2024 08:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:44:22 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 03:44:21 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix uninitialized scalar variable warning
Date: Tue, 23 Apr 2024 16:43:58 +0800
Message-ID: <20240423084358.1285658-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: dea401f7-0c6c-4d93-106d-08dc63719314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwmATIrTPHNI/khlWI3aZSyBBpzrD8eI0+gq4QK8l24nRZvBOj9bQnuFLV1E?=
 =?us-ascii?Q?8dIBbglAt8y3WC6H9H45xYFAAvVPpqNiskUpGPTN0lZS2HHr5MnMTAC5rKFw?=
 =?us-ascii?Q?/376sdZh842bQcWWjTNKGZkaehopdPev8u6TcnLxieOfjlJ2MGdnWYtwoVkR?=
 =?us-ascii?Q?0nEF98baBE9XamQjA0eMk5UJTypM5qhrWN/vaSgjfNBiZMwfEDZavAfm2iBH?=
 =?us-ascii?Q?w6efhB3lYNYo3FAXv+AG3u8/5kQL7m21NUr2x5+kFFmX4sPyh3rF0FTK1924?=
 =?us-ascii?Q?EvzPfrYcbmAX8CFelmNxX+KXGb/Q2JshlUlshaZpnB5BYHuL0e+c+8U84PSR?=
 =?us-ascii?Q?PoBM8leKjBZszpmQ8LHDE/y8RIv43yGxJ7e2bxVP6ak8EDE98YbnVuXLxpzc?=
 =?us-ascii?Q?h2O6Hwydidto4+ZDaczjtS6d7IIF3HVam5ioV+FDDS6Yrp/M3CkgqEihhor1?=
 =?us-ascii?Q?iHkbilFyWOozwTtR11E9KumekoadMhcPUoWyyOY1TW/E1pJ0dzgNd5LQtK5z?=
 =?us-ascii?Q?U4ezK2sdk4U6BPE0rZTAQ3jcm/PZKa2KZUCyuuVZs3NxCB6K4yYdjxNmANPA?=
 =?us-ascii?Q?QYyLw2KoqpsyIzIHji8FME8sJdBqBbY3dlxvtsF8vVPmkREaxdkhR1PFYUqU?=
 =?us-ascii?Q?4FcC4uoxXgycHSF5KHgvnvQAJURJLOqUw8CGF7sSLrDcSbe/RWBfCQ4WeAOI?=
 =?us-ascii?Q?lQ1TOEN+OuM8xcaimxS2IlR9V+k3Lvjn8IpBfjW/gmPUIwLRrBLyJRkN6kQe?=
 =?us-ascii?Q?bg3WC29O7/CQ316b4k+f/U0fpgB7/yQz+qqZmmj1/aXGyKTCfJCpfqDZHXLI?=
 =?us-ascii?Q?kw4NuC+NgiBjCT/HP3+hRePKQLJq30diPQ1SFQSeHnFtuxD/afGtmlhG5qZi?=
 =?us-ascii?Q?Bj20eJC2j3MMEeKh8s4J5G19vvnD71Tbf6cDhjQpPdem2UmuJvGZDong/PHl?=
 =?us-ascii?Q?cdw/c2pyEaf3pQWxWoMZSTad0xoAZL/QKs1nRyHVj9iv6+AeCiOhOcb54T3/?=
 =?us-ascii?Q?rlA2OLK49tCNQsJqMGyp4iLFwfH7/YfWEKg6MDuUxgdjhp302OO5RCRyoe3u?=
 =?us-ascii?Q?FlEztRbI0+z201/NTimdFfHUc176XiA/GeYV7/5YSWA58zdabQggchp5EDng?=
 =?us-ascii?Q?Wgtd1IL67A1ZtGy262/K5R0YEl33Am1AZgqqumzFTvTyFhE7jHmVBk6tTcWD?=
 =?us-ascii?Q?CJjxHyjQfsaIpZWAaR00DNmikLRVmEOlve9WwSd2ze1knXsqQSB4PQICnBFI?=
 =?us-ascii?Q?PgL1eYPrOOZut8CbokdeGYXOFK5/kBmzAc7VitHN7dp4kmnEaglqSML+JW5D?=
 =?us-ascii?Q?QVD+UIYjxBp4nM4BtJ+4Dx8g9sCyALolO88GpU7j6so9c2MBz6VMod3fBlMH?=
 =?us-ascii?Q?QbxBgd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:44:22.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea401f7-0c6c-4d93-106d-08dc63719314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

From: Tim Huang <Tim.Huang@amd.com>

Clear warning that uses uninitialized value fw_size.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d95555dc5485..8d5cdbb99d8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1084,7 +1084,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 	const struct gfx_firmware_header_v2_0 *cp_hdr_v2_0;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct firmware *ucode_fw;
-	unsigned int fw_size;
+	unsigned int fw_size = 0;
 
 	switch (ucode_id) {
 	case AMDGPU_UCODE_ID_CP_PFP:
@@ -1205,7 +1205,8 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 		fw_size = le32_to_cpu(cp_hdr_v2_0->data_size_bytes);
 		break;
 	default:
-		break;
+		dev_err(adev->dev, "Invalid ucode id %u\n", ucode_id);
+		return;
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-- 
2.39.2

