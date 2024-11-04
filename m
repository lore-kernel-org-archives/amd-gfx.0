Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC62FD132DF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 15:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8842610E461;
	Mon,  4 Nov 2024 15:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYYlngke";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE9810E2B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 15:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgKIOHXnogpy9hesYNM2B7hP4J51ePWuIJ4mKimWRFu7dbNYwyfI0CVNg8QFyreCNR9ilAVCO0B80PcauAtrDa7+7IXMTec2sr+lF62LbqWE33ZDICvnIDZ1mZ/cXfXjParJvY7q5eFLbpwOiQm1UO9XC8jFlN0xXak0J6keuGqEYZ+QPpJoIzsTLKWPzvXIEs4ZzdKfEccugBQchxXFOwMIlAqETFf+w911OVxxxfDjWjIJOEV1r+xpzQfWfH1Js0tVUPYOwZLaMyxG6SpynPBUZbBipfrw4L7qThKZbPWuh+z9f9cDjoE9ICiIOXNQdgkEUcmbpWZnP18qAlfebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohlKgroYs+xx/TwNC9rA2qKyqC3c6/zsaXwuTx/ub88=;
 b=Yr0qXHjYCH0NdPFTIt2raAC+pFfsA6khQR6GU1gscR7uY+WuYKq+tSYq8CDwBO/MvJAH3kfl/gvXy4oVsBHsTDcA6rtJG3Z6z2DayXQtnErT7mcRdFJOy7dpRmdB6TdB9jGT8YuR9ckeOjunKis3xmf3WQdVPPxJa7M9xrLrBa6DYyypmIS2lj0p5J/ZYZfwP8MFLAa+ZmA0YsdWuaIIicXwLH/01O7iTC8HwVEYB+/QWPMF288E9coG24EluJjfoRfBVjje61/vkLJ8twDQWEweOIDJnzk79pILEIPghmtQcLAx0QSL1+JEk6rHyepDRve0XAGwrcPs6Rd2bSmyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohlKgroYs+xx/TwNC9rA2qKyqC3c6/zsaXwuTx/ub88=;
 b=jYYlngkeUqH6REqty75HJzYYEeNWM26d6qurMTtn+Gy0nNTV4QpjEgN2gR+x9ksoM1DaPMrEvK2RKpWqEV42nOXCLQZSj7WBQw8s/WS0QohEfNyPAh8ES1FuSZdzdgCwFoHtSeb9ZLW+EctDj3cDQPELoAm32sld3y5Qd0p+HGk=
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 15:21:23 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::c4) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Mon, 4 Nov 2024 15:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 15:21:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Nov
 2024 09:21:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fetch fw version from firmware header
Date: Mon, 4 Nov 2024 10:21:10 -0500
Message-ID: <20241104152110.1470163-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7ca621-8404-44e1-924c-08dcfce457a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdAq0rKmG97CR7YbznsFV8qmUfJclFbnH+c2CoIVmlywrt7cV8z91lPqPptU?=
 =?us-ascii?Q?QY9gwKkKxPII9j78r0FOmY3DLr62KXpMw+oYnV1mbXHFH4dIjAV+wIYWBVje?=
 =?us-ascii?Q?iqawcn9omX6SDNB4Qim7YbMmL3LIyJwi7MIhBlnZSbfsbSMO/8ANg5sL2aM5?=
 =?us-ascii?Q?7xylGZOi9ES1peVNm6ToDIZTzzREgogzhkVPzWRQIE6CJ8QWodSUxCSJVASr?=
 =?us-ascii?Q?HygFczsIVUaLFotrT7CsgNw5dDmrjDKtJVVv0/D8lYg/TGb4yKRTFJy4jHgc?=
 =?us-ascii?Q?4P691kYs2y27lCDFxYeB2FTwhi3yyBNcDwirC+NFmCqDhYkblLS0o5v4HNp2?=
 =?us-ascii?Q?Odn9ToL8HMLYmhgq3RY/aEMYxG44vhME6T7zJUVxVqcFz6KRYwa1fv7px6P/?=
 =?us-ascii?Q?3Sri7u48Zs55Dp0u56o0mKFXAv5nIK4w6zvNa6Qd1ms55zCbPeHv2gHpE9NT?=
 =?us-ascii?Q?1uryaqT3BIvOMnLJIFQ87UZS6LVsNoafXJsoNbTywCPVXONfEEoqmJqhc3dx?=
 =?us-ascii?Q?HJg4yo0bk2O6FoNqRrT8ylrhoxMPiB3Z5VmO4hRdsmrEhay5lftjXJsD7W3z?=
 =?us-ascii?Q?Am0rk+aWjHHHkr886V0Nv6y9MTb0oHShpIYVHmRvQXsgFFcZ7iURSBzGkKNU?=
 =?us-ascii?Q?maAuFcdSlRd/GP9BAF9teKX/1QyAu10WxIGCArqeVTGplp6ul4EElgygOuSF?=
 =?us-ascii?Q?j75RhTZaZrbB7QOFL187w54Vp16fjdLFIUXPOSpLWxcHwSHjRjbWH9tq3gu/?=
 =?us-ascii?Q?b3NkvqI87BSCxSTqhmm/TE/+slOC7RbTMi0TrlLP63AqHfaozr+b+fR9/ZB/?=
 =?us-ascii?Q?xEfF6jdOeB/3wMg84QWzICtbmWJ2m0hE16h6nuVB7yJSS1uLCFGtprxPbC1m?=
 =?us-ascii?Q?njZqkqT8ZwNU13h8/2pRDah7SmRY9qQMRyQzCXqYl7OYlea6tmKRSlhfJSRo?=
 =?us-ascii?Q?Ci2usncPXhpsSTzHU61VKndPomDoyR4bMgfi1fNRDJsCoyX9Skl40uHZ+XF0?=
 =?us-ascii?Q?X0JWbAQ/Rfs76bCGwMxd9+iVEvxxp9IT8+SPVxO4RYklH/rfg8BQTUbWWvvp?=
 =?us-ascii?Q?1u1pOOtdS86tuSQtF0ytB2knPDpDUgva6hOHYZrIYaFyefJA0XRG/K0hESGN?=
 =?us-ascii?Q?FVVOw+9KWN/BvPgJFUe/5IbxDpDXllYwBtfcVsNkv+R+R7E6K0/PsY4TOVvw?=
 =?us-ascii?Q?KlRQZc77SkVkx8VDw8jY5XC+tThjbXppX2XqYrAIohtYQJfqvIZNjhE0pc5F?=
 =?us-ascii?Q?yidmEHoZQqKW52R6ne/WcPL6gvxoqSuywweG5O6VOZy96EuSOJhrUQF9lUkm?=
 =?us-ascii?Q?8bSBTssRwT9NHgdbEz4QrvTYOV/edCsIi77EIl736F6p35HNdFJ3Bfxajv80?=
 =?us-ascii?Q?N6NCV1Esq5NGa3UaPNGt9Xbly5/z2wjiUChjGUm6ZCIeDQ42MQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:21:23.2460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7ca621-8404-44e1-924c-08dcfce457a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095
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

We need this prior to the firmware being loaded so fetch
from the header.

v2: fetch directly from the firmware
v3: store both fw versions

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 83d0f731fb65..dc751bdac2cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1591,6 +1591,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	char ucode_prefix[30];
 	char fw_name[50];
 	bool need_retry = false;
+	u32 *ucode_ptr;
 	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
@@ -1628,6 +1629,10 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	adev->mes.data_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_data_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_data_start_addr_hi)) << 32);
+	ucode_ptr = (u32 *)(adev->mes.fw[pipe]->data +
+			  sizeof(union amdgpu_firmware_header));
+	adev->mes.fw_version[pipe] =
+		le32_to_cpu(ucode_ptr[24]) & AMDGPU_MES_VERSION_MASK;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		int ucode, ucode_data;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 45e3508f0f8e..56f36182c9ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -75,6 +75,7 @@ struct amdgpu_mes {
 
 	uint32_t			sched_version;
 	uint32_t			kiq_version;
+	uint32_t			fw_version[AMDGPU_MAX_MES_PIPES];
 	bool                            enable_legacy_queue_map;
 
 	uint32_t                        total_max_queue;
-- 
2.47.0

