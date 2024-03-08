Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C179C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C238111368A;
	Fri,  8 Mar 2024 08:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CL1Lc+uP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB84611368A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 08:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2itVIFwIAk0+eT6bSzstLBMJgJgA0qUKSLCxs3sa5ZUZLnvCqPsHnNkz5PJLM1qGJUBQeePwsYXcb6Ns6ahH0AS6VrRHzat2cON9YJEThG9v0cp6KFGmGxISe0vuEmSIuFjJ68sEZtx9TtCrMEpzWSNHGsJ2H3d4ntkwX66meWiSB1Fr7CIoN+baq27AW/J/sazEaaUsRobE9b+DgVPBGSl+wuG8VBmz+vlJp5++QIwZY8DGqD15c6TCmFGls0o5LS6fyjSO4u5ZiXD1FJ25UuYEciLdg7AunRERirzrRQWLwx+ecJ3YC2P0k+CGwgxBaQIEoRIyuyZjzrZ8fXmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx4lmeoMRA3aK2BS7xZopcELGpGdrHiyIYdjHCY65FQ=;
 b=QHGTrxIj/MHov1Z8OqQXZsJxXMWE8GVMgi4kcIhtu0b4ZhEWVkF2RWrYSL39PIy2iguSL3EF3VnGRN+hFgsu0hG1pM7l4aNqtQd4CLBCKWJxeEzZruYfK77lymv4OE90oTUXV2e4Rub3sT0zXBu9AZzwJdKQvcNpgKZUlOwXTzR7ipq0wP/IXFYMqydhU4AhS0mPuAZOykn3KdiLvPWlGXRYb5oVPoYVqRgjK1ByLYVSz3diwXyk84be1v3WuO3lf6ZFrkGO8J0rVvzKOA5kd1KPYajg1lw2c+2kCuMldfKZS2snYMWlDWh0RHTWFOAwyDYA42HOkDlQ2LFQ66l9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx4lmeoMRA3aK2BS7xZopcELGpGdrHiyIYdjHCY65FQ=;
 b=CL1Lc+uPxY4FRuyEkfdrk1zpX3km5XcmNore78zoiWklaKScm1EEu0FvfXOiexfZCFIasLfaGv340B1MkYcmPIwCtbG2w3aj+N+Lzz+Fp/+MzU9hcDKTzvy1wF5LsVHrncKn3eM8/sg4vNOgiOhFTUnkyWg84lhOl+6tj1Vc5AE=
Received: from MW4PR04CA0333.namprd04.prod.outlook.com (2603:10b6:303:8a::8)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 08:54:22 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::ae) by MW4PR04CA0333.outlook.office365.com
 (2603:10b6:303:8a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Fri, 8 Mar 2024 08:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 08:54:21 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:54:20 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH v2 3/7] drm/admgpu: add vclk and dclk sysfs node for some ASICs
Date: Fri, 8 Mar 2024 16:53:56 +0800
Message-ID: <20240308085400.385793-3-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085400.385793-1-Xiaojian.Du@amd.com>
References: <20240308085400.385793-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 04af75a5-02ba-4587-ebfb-08dc3f4d591d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c347yo4StTvbEnrSyLSYrbPzR4R7XtiPjaacaGh6doo7R7hPJQo3ZO7+aJC86T+neB7fheKbSR1bj3ZiT7f1cJGVHIEi4aRpnFDBogUDugmkMLfg0TwgYe2WBXso53M0UbHFpQs4IO2wnQ0l+fMbFxU42g5YKIrwpnGukI7HPKcHtqePLyzl6lNeaQdvISVL+/riU3ubUnmL67kFsmrTb0xgHwQKFQaHNUO/tczoC+u2L0Dqf9XCWKJ0cm71+6EwLDV2AdAdlz5CrkAh+oJC70IO5vDLrHlq53fAy7rt23bK7yxlREhYl40xJ4bbbYfqE4yi+6hXtw7KmrAlxbbals+9ocpeihkk6H8jbP35UJdHFsthZ6bmko/u6OzyMhatM8FjymWJpRKybHYJ02UWVZSjN/ITlhg+wk7gln+pEKj/23NQ0qt85fwS3ej5mbU2vNizXW2KUgnBGxRVhP9CTpxc769mLlz4tw6Z34OcJOntMWiQMGIjdQaMOll3K0VSx84n9leOC6IOm3t3pzCpVMUME7fQ0ssBTtP7kdR0yF/jtd6vWnKEZPPVMi8+wXlbOWk712kzBwO/xIJam1eF+Kv6VPQSwsyAth4tFGiUB09Ey41yo3/AZG+2LmNiJBTfrCjG6EsNoIFSGYa4cJ0PFLCIMqtLpP6PId8ya7HtiPwLwsvjkh5WjvFEDkGSKH9wQQ9WPEQPQl0YE04i4vdoQFrVl3foNTT/+wSmFMwABGvGRUvmnzSSw/6GHGtwMMf0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:54:21.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04af75a5-02ba-4587-ebfb-08dc3f4d591d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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

This will add vclk and dclk sysfs node for some ASICs.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 99cb2c6e8a4b..09069758567d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2235,9 +2235,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+			  gc_ver == IP_VERSION(10, 3, 3) ||
+			  gc_ver == IP_VERSION(10, 3, 6) ||
+			  gc_ver == IP_VERSION(10, 3, 7) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
+			  gc_ver == IP_VERSION(11, 0, 1) ||
+			  gc_ver == IP_VERSION(11, 0, 4) ||
+			  gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      gc_ver == IP_VERSION(9, 4, 3)))
@@ -2250,9 +2256,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
+			  gc_ver == IP_VERSION(10, 3, 3) ||
+			  gc_ver == IP_VERSION(10, 3, 6) ||
+			  gc_ver == IP_VERSION(10, 3, 7) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
+			  gc_ver == IP_VERSION(11, 0, 1) ||
+			  gc_ver == IP_VERSION(11, 0, 4) ||
+			  gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
 		      gc_ver == IP_VERSION(9, 4, 3)))
-- 
2.34.1

