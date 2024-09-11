Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52554EDE998
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB02510E173;
	Wed, 11 Sep 2024 07:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IiZOxHLD";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D888B10E173
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHLQkud3Rh/sKqsU4ZER3JShOROWGmELwkfkdo9RigNO+jJbHv1NC8y+gXYscZFnhxb9TYWasIp67Prv5YGlTqYfkzK+qQ+tVgBLUDcirReOXXE8U/T+dJTh5AUP0UV81Bl7OjwtR7TYv0gcow8tEPWagAD5ZjaGvTuPqdVWW8RR02T/uCMyap7Mi+QGaNL4FxxYzGt3IP8/FSSVoZHjlKQ3CC2IidG5pya6sYT9cARj/E9fCq3+oIwHLho1l1BrRVYflnjIchgM5mG9lottiRQzcC60LTpwXubxP3HyXLaEFe4SYhFKDWYOdxiGkfQjejg26KKbbe4m6r2mgeiokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UezLTWR7q86XmvtoEotMHXjL/K0lQg4DfH5B9CvG5mA=;
 b=iHs7v6I40OtStiWEJC6fpJeMEoE9PjRTcx8kPVgGAbMwbCpcyO0qONlp2JplsMnqmMf4ARH6BvurrHMNxiKYu6+XWWancoX6Qa9yQSGC8vEbdNxQHPVh3HZibAw7X5zWt054d9TWMZRCwIM3HJuPYtDBVx6f0j7i/57Fkwp6n4bEjVUG44vllDaQlW5SvwlHo+z7KYlCxgNu/bIKH2EjgLh9cX/Jvi7/iv6Su5YvwOyR1ib8afwEg8P4ioSEa2Ds8Hk5xVVl3qQJqlJ2NNYB1sRHeBbH8dCcXCPI0AN8LO7a/mqFfnC8trfeojUNx0lK+7x3VzveNXUHNOqRighiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UezLTWR7q86XmvtoEotMHXjL/K0lQg4DfH5B9CvG5mA=;
 b=IiZOxHLDuieyATxG13RYFnUabsQpzZk188b2yFq8ziaYK3PH9M5ZfSbJ6NGoJSyoHEg4t5D/jlUG+7IDmCirJZxmjGzkCNlN+qXMKsS2YI5gcJG0kDJMg9wOvcHyPR7jX/ShC7E7nU1nTYpna5kBm0UmZqTPT5sItPlhGh4yllo=
Received: from BN6PR17CA0052.namprd17.prod.outlook.com (2603:10b6:405:75::41)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 07:09:07 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::35) by BN6PR17CA0052.outlook.office365.com
 (2603:10b6:405:75::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 07:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:09:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:07:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 10/10] drm/amdgpu: Add PSP reload case to reset-on-init
Date: Wed, 11 Sep 2024 12:28:58 +0530
Message-ID: <20240911065858.2224424-11-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 005ad7a7-0497-4f28-cfdc-08dcd230a07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dlHa4IMSAjY8lTKcjfJHIIzdH0Ysfa1NWBbybqbIi7f/StQVl8i9pYIpknzC?=
 =?us-ascii?Q?aXnfop1A7oEKy16j7AFQGryAosemF4MihlSf1JTraPCw06A6YRjy1DezifNS?=
 =?us-ascii?Q?+b3mchm4PJxfl5ef6rcGtX7j1p50mn7LVS6wERLBlY6SJgT4fhgH/iiLntJ3?=
 =?us-ascii?Q?k22Xc/JGN9debs5q5fTYC9tqeXURui5xDa6uXzchIHp/hxmjIyRk/XPFpkFI?=
 =?us-ascii?Q?qOR7lqPewu8qnRujVrjW4iIruCifUDWzdfyZHqpOw1Wu7EexYXvkiJ9vV7G0?=
 =?us-ascii?Q?Re/07cmqwrsmDjGkaUsb6pK3RVwPdpFbmc2YIsfAPmFiImqXia0eDQ0oif2x?=
 =?us-ascii?Q?UV/7MwEUugcWJz5K5E4SSKsuQMoJW6UGy9EI/hOAkC86zUz1UvWejqg8UItU?=
 =?us-ascii?Q?nkZGAnjMLww3oIWBr+fa3nExO0ExTHuEqc0GhQrNZAPOiY5cIiYo2JFaAhyD?=
 =?us-ascii?Q?wEhh3JaxQT4WgdAtc8123UhYzREczlGqWl2KAftqxoBH62vg0VwkPVQC7lIm?=
 =?us-ascii?Q?P1g4EXqqb3gz9Qh5hPwU14m5Vlz2n+N9WI3ZPny54G0OISe4wux5ZeBnsvhF?=
 =?us-ascii?Q?jJc7U9RseCSe/gaLrba3N4PdR0ckdrHKJl86/ijYsU8KaZz7sFw4Aa5in+SJ?=
 =?us-ascii?Q?p/kT4OAzd9EXbd+PCmzQ+KOn8XnOShR/wnMg2jJTOW0MixoKl1w7yHc2gh7Q?=
 =?us-ascii?Q?vFj678HfVoe0nznMm0C3ky5ysOL2c9gnLqyFDVeR/7XnqIonn4GkQnN6gaft?=
 =?us-ascii?Q?MIASvKdUjPylTkrYlAH10HcQTfvYcw6VVR1RzIIc79gxBIbracz7A1YgchIy?=
 =?us-ascii?Q?BIq+XXZzgD2aiEd9gLndeCUXn+9HuXk6jrqYhuDrDHmKfNVdfkRAwxiXB/wu?=
 =?us-ascii?Q?1FYv607nuUzG2OVmbtK+DOa/TJSjJzCwQyuh0JC169oYK1o/yZD4O5RWSh8y?=
 =?us-ascii?Q?uIG857LbvM16Hs4Jwk1SSCHaJrw7kHVuqM24zL3FsIV1qYx7+sjLH/4FULQx?=
 =?us-ascii?Q?7v44P+hR9syPZYvABPWd0Ejkx+kdbasiDehU016C9U5corVtFKwxCfF27BEE?=
 =?us-ascii?Q?LsPfY4ISR+qYKROuaYPEQzpQIQgMwCWSqDfG7qV1APLJbgYYe1/nmOpGg0Or?=
 =?us-ascii?Q?5Ti4iN7qiTYr/lR8vwHUtpU/E3Lo1C7/QnDjQJaNA1W0XM5UwWv7+M6grmba?=
 =?us-ascii?Q?wJWNdgtJwfpxbQ4fmJYXG1ymBvtXBgZaFbMu2aQCq9iNJfnBbjHzOKgCJPcL?=
 =?us-ascii?Q?LnIvJg2+iIJGBfsBNkxp2vGPa/elVxEgOuJD42YHzVZo6alpY1U5OUpaXz6l?=
 =?us-ascii?Q?5Mjiu4c8maMC0u0M5AbOM3vCR5lc2iifQAw+GDc3i2jf0ifTHyJZXKsSm44X?=
 =?us-ascii?Q?QaDnJC6gePp8RTvS7ACt9Etl+tC9PHSzw0dEm6PTeCnNV1bI+FkFkpzUJTn3?=
 =?us-ascii?Q?MWBtDb2q1nFKbSaQ3KHOVWE9BBhS277J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:09:07.1718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005ad7a7-0497-4f28-cfdc-08dcd230a07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e60c69c5f894..e8aaeaa6d249 100644
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

