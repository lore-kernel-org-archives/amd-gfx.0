Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12305CD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB16410E222;
	Mon,  2 Sep 2024 07:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EvVbvHID";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A4110E222
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZshamdR4R4LMZsDxSt0AV+62fU38pHfMEmNzZGPmhE7lKMlIqliU4SKGAXqdBqCTHzxS/pydLXEoSKNsQuQt1BqZvglEvHcUH84sSY7Wz/uiN+u1TWWz+4W/q0YldkyeVoV//3wtC4snypMtd6kkBFLdqE6DCzrWZ58VdayOM77EyUfF2JpHfWP4tlXA2UlEr/LnzZbTrOFnjinMIsvsQOEoVVpjDE6HmX3dmibe9jjeCdLsIGJp0eGRX+uUJXfWsN/R19zIbn6/jezeJNZYT4EgFSiHBkvyAIc2Byqz+BPtoH8MdoLTCY1EGRSWH/Ly8mYznrnvjAJZ2OGRzYoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAY4TbISC/TCgn6SUGWVkhPqCm8ouX7sYXLPfYXahJ8=;
 b=b4aa5eZzZDvnCb9IqU0Awq6zsXIme5ouvHZywYHDPz9Ds66AP/KkkKbQbN2bfBGOX7UJU7Gv/2Lb4g6Z1SpQ1KeoRuNISfAIRHVQUKoP6wzFxCC2ydJKCSIZ6vOZN29skdSy8IOz/yDFMMiy/ZOfQOhmIVzYyNjx8epR8/Dd1FjEdVwtozz0I3iofZFvqfi7H9QPKIENIm9ib+oTWCN5bPwWKshg+rpAsM+Vt++Luf7cUIqFw42mDEt4ss0PhpG+T/M8SHOs5KQGOwfCPrncB9whdBfJbFMqzrDjo9HiH5A7ianHR4mEEXQqHdgnHw+hwbJ06vj8gEXPuaeCxiGEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAY4TbISC/TCgn6SUGWVkhPqCm8ouX7sYXLPfYXahJ8=;
 b=EvVbvHIDnxVTLUOD2MV0QxPAhE2O5B3rwXb0040Fl1n6HEJY4cEkiZDejv5AbuxYIMhW38vYsLwEQHI3A4+O7fwvwGbIZGHKnY5mRQXUVCbWSAxFcuY/S2kV3HYW69PDxjGDW5PxQYQxtPXzeQ/GBtsAxMfeCF3BpNwcWColvB4=
Received: from BN8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:ac::37)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:34:53 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::2a) by BN8PR07CA0024.outlook.office365.com
 (2603:10b6:408:ac::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: Add PSP reload case to reset-on-init
Date: Mon, 2 Sep 2024 13:04:17 +0530
Message-ID: <20240902073417.2025971-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 741b8622-b6ce-4653-1edc-08dccb21bc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tg7wHMwrJe/sV+PeHK939OFcXxDqoxkS/N3uHjpxS5mdQN8nsJqz8aZ7G0ei?=
 =?us-ascii?Q?J555oncIfKuWgskvf/ZPcy1Mun9FBv7dpA5bVbr9+EZY9aFZ/dY6hYUIjzNC?=
 =?us-ascii?Q?R1zxKGOWd8fNmmHb41VomIJCfnW1cUM/Jt91mqCepS5611RIhnoHi7VUfVbx?=
 =?us-ascii?Q?IQcP+4f7rSmASg11NsQ7KOTMt2dmXtPXS1LHMuN9rtevP7inVWMLM5/snDP2?=
 =?us-ascii?Q?eOVQDB0VAqcJQcp5Ws1BguRjs+QMFK3fX1Fj4/f+PcvHInXuMN3oGUL67QoR?=
 =?us-ascii?Q?MD2OZjD5CfvYLVxFIrhfn0ZCzvyOWs3lohIqw3THsGdklmK37tfFf4TstA8m?=
 =?us-ascii?Q?AAk1ZzaaXXxyMLDmIIVt5VS5q9+iBsvE1TgNTeF9o7wag100FOauZ8hKj2wa?=
 =?us-ascii?Q?QSiJB/kOIufsGLD+SFkuGGuS8WUoChFQR8/G6qbTdb71DV2McsdjgeyHZUuw?=
 =?us-ascii?Q?uV+iDh4JBBPgdn+iByHd4KcEPlO54T941xfQdwjCcftgx/9vVgbHwQ+SJ5e8?=
 =?us-ascii?Q?IbsqtBWUzxoiFIOwcoIX4tkUA3Zv8scs2YI9RWK4f/WnfU4UZlPJRxowa8wE?=
 =?us-ascii?Q?g3v/YHTIff67mg8qqJmoxwEGyZFxTZ0mA9lns/4GhIybwGz1ExijsNebBy21?=
 =?us-ascii?Q?D4DJMaJUjY84xbD5JkQDkgHyx41vpyXtqccpt6V5tnKJ241CmTaalZDZBUZO?=
 =?us-ascii?Q?zLrhBA1kDXJIHqchqbx5yC1Owpv8qEeeQFDOre51j+g5UJE8p0pKZdUiGvL3?=
 =?us-ascii?Q?e+tDhWq7yY/GVS9jAw4r5gQ1b9y6IIjHsmNKd2GAfuxb8EoY4WWHdxE2EmZV?=
 =?us-ascii?Q?diL6hj5JJNAHcPAfxMmejW5MTkHHfE1YWHRzuXP9q3dGov0c3PDKrPmDZx/K?=
 =?us-ascii?Q?3yqhnr/r59LSiPSyEaioq9gjPBicnBZexJTbiTr090m/9wdXHYIszMov0Hoh?=
 =?us-ascii?Q?M6c39udY0WWC43AJ7hSEUbdhC/420Uar7bkX4wtng1zM5pTf85hgqdcmd4NL?=
 =?us-ascii?Q?ucLqpKiTN/27NnWXo6W0J72KCBNxctgEVl2kZ1SlSohfy7XwwNiULzCCbPWl?=
 =?us-ascii?Q?QO9CBAA4IaBnCv4IdC4FCDHmNMLQk4GBdj3shp1bwrGIzN4vCVM5r6Dc0li4?=
 =?us-ascii?Q?WgWU2zdobgwg3atVO7nWiSjhGMkqCPoxgiXGaWMdpmMqyNca0+jJgVMQFHve?=
 =?us-ascii?Q?mkwEk+qzU7/Md0Jveooe154leeD4RjV6/1COsvhWu5p8rWX9rLbjC6boD2FH?=
 =?us-ascii?Q?NnBGIZgM+Yp5Qyisqtp3wGMVv+qB40x6kNhCvjKtEFRnsNU6Ka2iTWiKcvzm?=
 =?us-ascii?Q?7yMNvhEj77fsuJpozEYfQdKWy0A9pnwUfyx1cyDlDS499NWvAVHAsyf1qYch?=
 =?us-ascii?Q?ylbtn0GMlcs+v4D+npv6dcZu0ttS7qdBTdxzUdvIG1yc2eV2OgYVy3TEQGmC?=
 =?us-ascii?Q?E7K7vFXo/m75ZvB5OGh1KF1drxrxzVCi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:53.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b8622-b6ce-4653-1edc-08dccb21bc57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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

A reset on initialization will be needed if a new PSP TOS needs to be
loaded than the one currently active on the system. This is possible
only on SOCs which support a full device reset which results in unload
of active PSP TOS.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7901b3fbc127..a1e049bcd4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -829,6 +829,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_RENOIR)
 		return true;
 
+	if (amdgpu_psp_tos_reload_needed(adev))
+		return true;
 	/* Just return false for soc15 GPUs.  Reset does not seem to
 	 * be necessary.
 	 */
-- 
2.25.1

