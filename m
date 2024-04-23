Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23174C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 03:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6CF112FE3;
	Tue, 23 Apr 2024 03:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYQWLuPY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A56112FE3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 03:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fccYvd5PRdqesCfNhhEjUn6BVoEQCYCpMKM0TxzySFEZxLEbczqdMfiPI8FWYh98GUU/vUPMED/7gZglB3jLAFcuHTQ4KRO5QoXGJF005qzCDQ+GWPyc9XaTWPiZsBHICO60DabxIt9fY7HuJqmhvv6AubuaILRQ1BgLZUS7roF9R0KJiyTpzjqx2YZVmas7+c9HsY5QRVYLz6uOyZD4xANl0wp5KGeMJFF4Ln/xKJwqs53d9htQ8UxYbfyx31KhISNyRv2yDdg1y8UBJ9xa2kn5SzS/C9EKAmMwCFrbOKviZpN2+W7aevBSm958L5xs5RSpHPhcf4WfJckrqpP6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qocJ8N2g6lkjdvjBU8/mzYscy47xlt0cZar8u47dtx4=;
 b=C0LqJAtP2TnQ8kbHMOudh9LlC5Ge4JGrNv0A1a6tEhKnsRer6jf4nIF4S+zMaVkIyVmoKJ+8vOd9twxPAzdHiuS4v1RRtPEuePZbD84HqvDAlNxivj8hRskpkb8bYdc7GVYk0p0BAwEZiVXxy2Cn6NNRgOL3p0SsdCQhCVHMvmw0Z5YDc9Enlmy2mNJCIPMLQm+ViIcCwTcfdSm5brzUeZ7qMMveLcU5MWqm9t850k06/ux1rbEYk4Avb2DAzLhmy94a30H24E0C7i5hh3bBtTOlqMGVkwBA8aftN9thWt6M7Fpgq8MOjq7LXAqWtMpdPDJk/6HGQUK8vCe1MVeqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qocJ8N2g6lkjdvjBU8/mzYscy47xlt0cZar8u47dtx4=;
 b=lYQWLuPYD2xb4gMmy2VIHT0Gymx2G1e3vAmEmeQ0//Y4bXog92haB8v3nPLqz6Gdpg/GhuNvOCyKjneG9RJj/IUPS/LOI65eCkYCnwrAKC9O1SWBh3rLMa9jbX/awgydX/yp4zglifBdSuaZsfWaWreW2MpES8aViTXqDRXcYLM=
Received: from MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:14:45 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::cf) by MN2PR02CA0018.outlook.office365.com
 (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 03:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 03:14:45 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 22:14:42 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix ras mode2 reset failure in ras aca mode
Date: Tue, 23 Apr 2024 11:13:38 +0800
Message-ID: <20240423031338.863302-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: dc69f989-3412-4f7c-25df-08dc63438688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P3SNN1bPUHFUOAWHvyGIdv1Qm6ZM03WwA5fk/AgTqIFLul6vH/JPvZ+EKd+K?=
 =?us-ascii?Q?QewKco8kf3s1igAHxHAKlfWwrstx/YbsdQ5ONtTA9I0QzHpqwDp35n2fE0bL?=
 =?us-ascii?Q?S96whfXL+RPD61jL3vviVoXVRFMQ7+PQzW7MNnObjqdp0NmgKqatqvFIZuDl?=
 =?us-ascii?Q?PoO3y95mM172bYxVcmSgyxbcL2VLHsD6qyITboh+jdi4fMCRgTdMqXWR62hY?=
 =?us-ascii?Q?atJf3CrHgxwaIKuSCzXXaC0wvCXibftltf7nQHTjGwu15WQ/s/Ay5Qia933m?=
 =?us-ascii?Q?MZ4MelqUtpiicAegpHjbl0fMVMHho+SKdY5CHf3W1W25lCZXCtYDammpxlQE?=
 =?us-ascii?Q?mUQp1zUmqLU/q9U1+pk6Iz6UluWy6lqcvxxhUjkJNv+1/3EwnsDGwCORp00d?=
 =?us-ascii?Q?IP79Z5WMsbNyFryv9gstItDy/8CeYyUfBl1Go4kVnJHCNcnhg7c4/zxnpAqy?=
 =?us-ascii?Q?hdnfHbJ73XwfPLeWK53mU4YqNLjkNe0SNcdzhxsy8KssDPmFny3E4zas27RO?=
 =?us-ascii?Q?8AFAP2jw+SfmB8vLKxxHCejfx5i1Ld5Ub3HGLa4yGUB2BqzmOhQRXgIhK5AV?=
 =?us-ascii?Q?wYLz7gmZDgWGbHaeDgY0kZiUSWt6ZgV8CGgOq6AL40DSxuJzTRXzHa0qrpHV?=
 =?us-ascii?Q?2PYjnkEsgjsW6IBgj8N37QmPiqBMEXdt2xWJwZSuqdagTzSpjPuV996kEF29?=
 =?us-ascii?Q?5KEhsGHl2Bk9N9TvwqZQA2QhTlyTNeo14nKA6vTi6xV+VjHSV6NrYlH6xWj3?=
 =?us-ascii?Q?aEi/2ZJszMELT7XaFbWjPncR1icuK40f3plhOfSkI6SWKQnRCrYhM+R5G4mf?=
 =?us-ascii?Q?3a9OwBQIr0w2zILmy5VJt0oldCug9y7bNchjWOu4usksqSnPCJbnwruzg5Ai?=
 =?us-ascii?Q?C+AJed259RrdosSBldVCRo2ghCTf+PA6iWlUzfdIN3QycI5x0HOM/HuU7UfY?=
 =?us-ascii?Q?yFh0U0yHqiXJ7YXZZfmAFi92LE7yNC16RC+f4Jibf+FNyAJtVbB0n+arjeQb?=
 =?us-ascii?Q?vAh/3bPLxJl76uMDu88bJnB273JWFTtIME2za7O32WxI+JelcF+0gLxyL0l0?=
 =?us-ascii?Q?1HfbCZkrNo+r9I7j9P/CY4+xJy9k/pzH4bpgbA0P4lnDcnxQUfdfWuxJZSIC?=
 =?us-ascii?Q?Q0PaRY4HKq9g6EiB7jTHWoBaSvsY/SPB9pOkFgPta67W0f2bZ423Ut/mrwc2?=
 =?us-ascii?Q?ioNDgShdABTTAc3eF0nWg3kdSw+9r15qfwi6NOR966reTX+wOeU0Dij3rgrT?=
 =?us-ascii?Q?1zclfNp8sgD4FPFsi2Pja4eAz5uFkpr9m7RyNoEgnRmH7AeK6taQLU1MOBWY?=
 =?us-ascii?Q?FCowCqWmkOyfnNE/9aBKt0wbbH2GtYeY8PDf2AofwW1JVO6HD7kHwlCaV8ya?=
 =?us-ascii?Q?9rF45dw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:14:45.0327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc69f989-3412-4f7c-25df-08dc63438688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

Fix ras mode2 reset failure in ras aca mode for
sdma v4_4_2 and gfx v9_4_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..c8bc34aafdd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4324,6 +4324,10 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	if (r)
 		return r;
 
+	/* in resume phase, no need to create aca fs node */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
+		return 0;
+
 	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
 				&gfx_v9_4_3_aca_info,
 				NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 7ea209b68154..77ae943745fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2249,6 +2249,10 @@ static int sdma_v4_4_2_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	if (r)
 		return r;
 
+	/* in resume phase, no need to create aca fs node */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
+		return 0;
+
 	return amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__SDMA,
 				   &sdma_v4_4_2_aca_info, NULL);
 }
-- 
2.34.1

