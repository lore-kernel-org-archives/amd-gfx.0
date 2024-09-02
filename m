Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D53ACD13CF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFA210E220;
	Mon,  2 Sep 2024 07:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wyl/WSAR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D503310E220
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiHsPuV7G59SRXq9OwC+3KOrYKE8oY0SE/hVVpN7MQA45Qw1/gK7dYbRnJIkJ6DeBQRff6mWIUXyJTsmGrtBm0RFicKqGo94yXON2RL5sXW19FeAEfnjyntTWZU3lY6hkFXaIAiq6z8ooZ4N189Iis3jjvZUMHMX+3Cz7O/XhwMbr11iaXIbSDraB7myRpraUcwmlmqzF9vepFu2rmAI20rbPfLwP5EvahxwJQvWd61av3R4fQHpcNb5V46mDgF3hAdW2x02/ir2C6angK8xDZ++O/4sHouKXYK/NDROD8NDZ3qBGa0o8zgulzJULnbp0SddISzmlDyU4GIhCi6NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sApR8MmKVqxhHO90u8QbniYPSHPI422QrmQMAHpOkSg=;
 b=HcbOvXkN9YADs8YMHQ6kTV2JBkipHd+wl93G1u2KDohjwrJ0dVlRbAPD1/HNWJco6si7Y+nw8TQ3EONlNZZjJYo/UOgeXuvhJ8fEYiuGwV7x9yfkKbjiE3tPRiT4Bmpn2ctOgLD8/U7+VSpF/VucUVCd3xPq0GR1DUZ6oTPNaFY2Y4pVmXJ9rbB8uh40JD8VbtGY0GiQ7W+SjGujf9In3fFT94JjfSy6wM7oSKrn0j+fQWOqrnlxn3AhP+x3ylVBv68iXeeWP1R6KuVqdHXBjQbeNXYImmZ7f/IEOwly5TS8gtC287Rp83TaQ2zuW/i8ccGAqPWJuTLCKq4NBkiYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sApR8MmKVqxhHO90u8QbniYPSHPI422QrmQMAHpOkSg=;
 b=Wyl/WSARaS4OFIDhID9MibCm/0PG5G9l/cgATIKk4ghQh9KvvCshTSczJGyIbwCNmFRrVIkes1SYVCV6oupDg8hPg9qG+KVa2sxXPQttE+THS9SXuy67hAhEmNeyLwKNlzadMtvd7IUsePmvaZcmD1AkHyI7OUbpo3U1l6c3bdQ=
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 07:34:50 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::d0) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: Support reset-on-init on select SOCs
Date: Mon, 2 Sep 2024 13:04:15 +0530
Message-ID: <20240902073417.2025971-9-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e1dc3-07d0-416d-32eb-08dccb21ba2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdOqGxyHd8UUqhSzL2QCitnx3Jdk8PmqR9mCqFWLqFQz/08/+u84lZPajWUd?=
 =?us-ascii?Q?RmoBuVv8g9sJaq+JbWo0f6A9VGz+4TKXo78shO9B1QN+uhcNMs+61sDjQlsN?=
 =?us-ascii?Q?S66cPwIytNKL+BqnMDfotpAaYANF3y/GnNZSxoqx7rEx8R38OtvtPMc6Q0qC?=
 =?us-ascii?Q?DN5ymzU0NT3Orb/LogEBqNeRO3OmDMhOuqd9F4amzBOvMbXhnLu/s1AJFSVB?=
 =?us-ascii?Q?RJt+1EEBPOhmx72F4xFdGYNLIR3fDIlLqDXtOb0aAg+h80De71zm9MrclWeB?=
 =?us-ascii?Q?gTNjFTyvOsqQtL1kOuH5pFa6hxFE7p5faMWYMBU9eQlvxCBXVZasjKckxjUt?=
 =?us-ascii?Q?vyZ0JFm9719ArdI00xLvifKk/AbZMoGtDyBmGBZwm9rNSpXW8O3Gg4PLtjwQ?=
 =?us-ascii?Q?+7bx64utmgwCiBvAz/CP/00o1T5fyAaWi2G4E2tUmUdXdJOEzmCsSzMoChUv?=
 =?us-ascii?Q?bNALudOs6JBBjB8djbJCO1RtitWtgSEJFG0GSBM4A9x9rjsBeuERS/nrIoCF?=
 =?us-ascii?Q?pv1nGm9G1bVL6pGbd+LZYDjY3BoEf5Gt0RYVSxVntM/TFljxkUVelQDWY/MR?=
 =?us-ascii?Q?dUZvHaIea9SyAOVL84iUWyjm6U9g1zP61JE9w/rQ+eHorbMoqa2Jh8NnSjW9?=
 =?us-ascii?Q?6OlY53/MpzVRB0q3DYWAGMIkkYNU9KVcr9yqz4R/uqRNIePnGcIocHP3IvGN?=
 =?us-ascii?Q?5DMzaIHnQXxGK4vW/JMy+mInZvgNz6QRZHFMEOuoMubfje0lLqQWCais1rTV?=
 =?us-ascii?Q?UQ88E1J/SGGtS9wnfSI+a3mLyZDppM6V2u9/cLXwDyq9Qs7rMdI595rieQZJ?=
 =?us-ascii?Q?g0odBjCtXC4otzIQe4oDEs/p3boDOWh+StvxXbcoJp9pinOpUaNUToIw5FBq?=
 =?us-ascii?Q?P4bAaAuCmahv7GptkBFTI1cj5kXJSwIHHMsNuPDbRCXwJexB43SxZNU1ccY4?=
 =?us-ascii?Q?U/HytPzLEnCYfFyyMKxhmfbnFimbCtI83WvhUgjvD5/FXa1YER7RAeJHgG9L?=
 =?us-ascii?Q?NZVTIeXaqKJWGtwbuV4Etu1xXfW0gIZAsaMsT2TMNkqh4vr61nMaW2m5fNqt?=
 =?us-ascii?Q?MHH7HeNxMkmlJ90YMVrxNNq6nx2T3t1Din64mMB5QrWw0mAfDG+eII1fAvgn?=
 =?us-ascii?Q?bkLmlctNT8Vgfibl4HxgDlfaZ4k0HezYnZWGW/jZDek8DhIZL18lNzX5kxgp?=
 =?us-ascii?Q?aBxNej4WlsS5DXbZaCNOGKI2UA+QpwSOWJAuh6NHCX0qMm0JdFr/k8dDdHBz?=
 =?us-ascii?Q?eCASelFcdGw+RvNvlDE9xyx/dsvhHncq/XmaC7ysbBnfW3glEM/IWg4zLoDn?=
 =?us-ascii?Q?CtAVczcK+XiSC28i1TZLK2vHWo4OB4Zq7pkMEt2bYZ7MP2U9WzL8I7c/4J5d?=
 =?us-ascii?Q?RIy4VkiU9U0jL8kxwvhLQKxR+GOpqwO/V99fQ8QxUoDhIZQgwZpFrdPVSRcX?=
 =?us-ascii?Q?6bFHanNWpgc63RqBC6aW2ECALCni28L0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:49.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e1dc3-07d0-416d-32eb-08dccb21ba2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

Add XGMI reset on init support to aldebaran and SOCs with GC v9.4.3.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index b0f95a7649bf..119acd9fc6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -417,6 +417,7 @@ static struct amdgpu_reset_handler aldebaran_mode2_handler = {
 static struct amdgpu_reset_handler
 	*aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
 		&aldebaran_mode2_handler,
+		&reset_on_init_handler,
 	};
 
 int aldebaran_reset_init(struct amdgpu_device *adev)
-- 
2.25.1

