Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35562C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC0F10E1C9;
	Fri, 10 May 2024 02:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eclpc9tE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D687E10E1C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/EokJtdYkLeCuj+iP3GAb9gKPtFDfGFZqVoqFt3qFm/7HeVyM/ZrDcXw21bE9tT2PZ1GV6vkOyOcqRcgh04SxFFm9NE2DzxGIn01vDeft829iZdsP9FpnRLSOHSx8lB5erNPP9/2Fh7sBUgUkqwjUGG/rUlwLXh6hTZ6lRPRbmYUw8qkTL+WOHw3j2ZExeE0o6QCIa6dDNdkLFUWX6FUvGCEMnAetERYCpLwn8z8VTntErt++/GQzc+2QWmIR3PtS3tmKJgRsnSVZOqfMPwqXoiOckHbMHDLn9X+llaWpygFewkopfatvmh0IOSkgIKpywzqbCDiVoNEbW5iWhiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZTUKrzcWhsUN7vBgxko9zpPlGty+WfUt9oOFDRpWAY=;
 b=BCIdoN97mUcoz/nNTT2aFaiQiMz8qpnaQb8M/RjMXUAjNCn8T0VARqo+Qnq99s3mMZdYJi7Q+O3d6acbEYNdApA5B1Cf6ioCFZkrLKIXPw4RK+X16qxlVcZuJgRCo68MP+d1k2L3LhjEZGUq9SPmxK2ZaidSCtWnyIepAjxElnqkw9jDzFbTVa5iqar/jvuIabEfdUJ1bKD0/9Xq6optLSGUFA7ssgWCvO03fJTRtxQ+eIaxj5/0tJcrZ5DXNeTFjJIQlquDELUti5XK/UQTAc/0KS0gsqGevhSNKuuMUUnJnQYTOwrlLfYE6XF+KN5C9sB7BLmN8oIDJs64rjJn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZTUKrzcWhsUN7vBgxko9zpPlGty+WfUt9oOFDRpWAY=;
 b=eclpc9tE98wwzyPlM+rmoGN2rMuF7ofboufzXu9wLsZzJWQCT7qHnAHicCiSGKXxG6Hlf+YRcz00hrG9Fpx7KlgsKeRlgEXBMiA0BuEupXMNGq5zleBLeuJvaQxxakzWerTv0XgzyGc9wU+fzsdq3d3ANtLedW7oTVuwlj5vsDs=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 02:54:18 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f3) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Fri, 10 May 2024 02:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:59 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 17/22] drm/amdgpu: fix the warning bad bit shift operation for
 aca_error_type type
Date: Fri, 10 May 2024 10:50:33 +0800
Message-ID: <20240510025038.3488381-17-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ed678b-ec04-4468-aa24-08dc709c7c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L5Ng8VlUqk2HtFEhOtCln3DmpiSYv/udPi6hW2ol2wQeBSHIEyH9Sbcwf4S6?=
 =?us-ascii?Q?ybC++b8XUqWPbN630eXvYFBqZqZcmW3HI8qFNdQhtG6Pb1O0Sp1CVeOmyth1?=
 =?us-ascii?Q?JLeHwcyxIY194WnA6tTJMoQIDfVhIIJMKAXObWmRhElfTMJQ1Kh6m2Wes1u0?=
 =?us-ascii?Q?t3leR2YAw8+XgxlG6EPcEmUwDaWPfXu5hmUzI7Y1OU+YQq5Wil5Y0VrxZhFI?=
 =?us-ascii?Q?pCbhR3V98zTjtmX/SBGlVy3ooywmbC2biEW6BvJiPslqnxGbJ3Bvz4nXmTVP?=
 =?us-ascii?Q?9h70dBKI2vQy9TOFN86iSCQcIi2im89JwDVYbMNSnORPCZAmySq3YgGWwnym?=
 =?us-ascii?Q?3RKSqMgdRvJyA/VvJHCOrnE9Y5ox0YuIkmr+wLGGuOA3gDIMIxRadkvEN7B9?=
 =?us-ascii?Q?UNZ4ub3DiAu/jyunNS4z/xJBNATpe9beUs/ip02SP8mjORcN3Rc2ktmE2/y5?=
 =?us-ascii?Q?VRTxpJV/CE97V+AjphuT5REWd8tkITvhTzwvyEBnQp+1AZeCRlGbnH1YcPk5?=
 =?us-ascii?Q?lt8qrAhBRnRO3tqS0mRENeNPXWfHAyIcDUDQMpkU9l/Liph0AYZw0qNvnLlv?=
 =?us-ascii?Q?7TKeHyEK6E5/Bk8ItUNzlp8hBenRYME8mRvJcS8K0SL4hAZGReRxYh7QXnc5?=
 =?us-ascii?Q?PvUZPtOXjfTXENwrjjSYARCXjreWPOMojuM5CM+2KiEYSFjb1t8ziHpYQuUv?=
 =?us-ascii?Q?zXYHsBJTV3q1hxHeXUNyhL/oKuYfnIvh4cTTFFkuKSk7GZnsniSxR5s8y+or?=
 =?us-ascii?Q?4SfStj5daPdSP3E9udxHwOj4oqkbsDqDbyTW0W4H+iHwzJsYF4SdhVLOuJNF?=
 =?us-ascii?Q?bDnf8a9cIu+WlvINsSHVQGyTR17N89dfZAP9hsO18Em0us/IbCe4Qs6fv9Ya?=
 =?us-ascii?Q?wYh5yNVucgQW/w+mfk/z+PUVJPhy+YZF+ypj+hT2dhAbeyV10HVA3d0Dy5ww?=
 =?us-ascii?Q?Wk2g+PSGzFJrzdAz35wGRR8JOl+eKZKjJtng5ZSZsmze5EKu+b3XddkJREWE?=
 =?us-ascii?Q?Br1IgaTUA2TO0V3d9Um30NDBWkvxkIoay6MQ4R3X5ym4ZsxzQA9ufYRI9Mvj?=
 =?us-ascii?Q?D3682bsFqZ5CG2n2meXOd8Vl9ASHPVsMK193tqM4JRMion4Ytm13TY7M+2jW?=
 =?us-ascii?Q?sWem1d4nD/54hozsfAb9Ja2R1kvPGIXAfXtkU8Is6lhFJR+I/v1R8nhtOmD4?=
 =?us-ascii?Q?tgrJKY5l2BoMpTDlRwN5aqH2Dis2LL8u4DAoyX9KZjUR5ybQOoly5xWdTCBF?=
 =?us-ascii?Q?O+gA2grlrlT5wR2G4xrahKfQ2DED2+z7aMlkxacNd3gwM43oWYXPEHEei/G6?=
 =?us-ascii?Q?mDEKgHRLMzPglgmebvnZOdC+SwmybL3mOjbG5mSb3qZBKhtNe+wACJwPc5rc?=
 =?us-ascii?Q?x4mVo+OumCD70aRX5MhVxcciX06N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:18.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ed678b-ec04-4468-aa24-08dc709c7c64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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

Filter invalid aca error types before performing a shift operation.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 28febf33fb1b..9e3560c190e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -534,7 +534,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (aca_handle_is_valid(handle))
 		return -EOPNOTSUPP;
 
-	if (!(BIT(type) & handle->mask))
+	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
 
 	return __aca_get_error_data(adev, handle, type, err_data, qctx);
-- 
2.25.1

