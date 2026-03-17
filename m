Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472CFB5EA0
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 01:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BB410E404;
	Tue, 17 Mar 2026 01:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I3XCav/9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3201710E404
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 01:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okc9syIUvviICuCAckv2R6ShizWS5OuY4/yVMPamTpO7UdZK7pe2HdILOTbRq1Iq56e1KG1uXsBKPX8DzC90zwHsOPBa9ElvpA7BTLKJlIAh98mpy5qoEH21xJoOvKboSn4MDH4zP41On+ux7CR2UXSV8GTwywBNl8/PCtez3IdYGSwGhvv83NEhJ3Ap7EtTgsDr4M64/itdiRb4Olu32lpRZIKeln05WgMT6T9FBcokB7gD6gqZbbxy03r04VU/UyfIakB7L/HmcT/uWB8VhKhlHnVFP+QG06AJNcM890B17EO7sJgYsoAoYxhdZtQeYnAmIc4dddQ8rXB1rP3vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR/vSRPTGvbPXi1Kk9E8RTHS7SRhlW2ytH9xa7sfY2w=;
 b=Czs/XKZaGthdKJQl5qLLFaZs1o/RsJIo/v4Vs0CHPIJfYYwGHZZc86dgMRgvgqrNrFQ/eJYDtWZ8aqZXspCKokw1F+1tazT9JMOqIQZp+gv+4NE1HVxoBDB/VO4nOfwSOS4uCNzzcNCZKSU921Vdm8hfTy7OSDIwf1G4WHoJGWb5HT7q3xJsXLm3CiVQbEzz+//k0USD8toQyqKaEZkK7XLVy+sdvuruIJxWBYT8KZhY50Ata1+PUot5lb60vdkopAYwuwdT/u1V2jWuLnInzKcfVAgFT6J1us6l4amwGBWIe7yz5Zb+1p33F0NRaFloocreoC1sYeZYs4BGVrGqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR/vSRPTGvbPXi1Kk9E8RTHS7SRhlW2ytH9xa7sfY2w=;
 b=I3XCav/9ilRGXG7qs4v29Z2+2stpn3soiB8jERBg7yN/AxYScTWeG5uB6CNGOPof0LMmNOaAJfVDhq1LYFxDJwlf+Y3sgME1nvJwVXgxFQ3LgK7l8Uy/+307YKY70ngMoe9zsHDKLGq0yPr6aAi56oTpFff3dGtb61Au+ormB1A=
Received: from SN6PR05CA0014.namprd05.prod.outlook.com (2603:10b6:805:de::27)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 01:17:29 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::c3) by SN6PR05CA0014.outlook.office365.com
 (2603:10b6:805:de::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 01:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 01:17:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 20:17:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 20:17:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 16 Mar 2026 20:17:21 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: replace WARN with DRM_ERROR for invalid sched
 priority
Date: Tue, 17 Mar 2026 09:17:05 +0800
Message-ID: <20260317011713.1812421-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: bb36ca48-6cbd-40db-fd01-08de83c2f4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ASTBxMf3L3bfx/rG0tV2NsxB0yOzYGRbSLAZft4zCMt91nJA2Fos7EI+qb/s9fue3VBY02BOSKD6mqmmwvBoy2/2UEaRx68rw9To0tfX8VA0ruApVaspY3lN/BR84D9X2Sm7kzUg+zuhTx9P5HhOSUuY2t9SSyBMMwHboaBWJAHrqk0y8xOti6vws2vCyVJU7hSuhTZFgiwEBK7xS6UmIMp3M4bkoTCKGCQrT9XwgUpBhkN3kfIbBZ4oUsh1y/ex3QBp9RkOy3eEwFPUyEjVxqATDHi2dnr8Gqg5WB95YyQwtadx9FhNIdZMV7WY4890PB0Oj3Byb9tjHgJ1rKGR9eGlMJ/tlsDCWt42tLjswFa8rZC9L+Jg04e0EMmkYWKUqN4guxj2XyInsKEwQVZc6qM4gBJKVW/OO8m4SWm4KairvtTJMa4QrRuDmMWmyV7Qiwkr5i2WYc8xAQ/OOsvWQIJ/HEITxdq2uO1EaQDwGVWB6GZT5uvfC3klZK+2si6mcy+yIl1iuZ6GrYXv59lv1c+6B363eBWlCvFgfE6PjZ+dwzOewXia620nkvR106daygqjHagJzbADVKkytJ+mobTi9Xr4l1aAvfAz8rAXbYnLDp2HxizZx2wrw4qfNcQvmo1Dv86XOON0+gbVIElJVEdUL6ERZJ/gQST/mM0bGZuq7am+OWAv8QvlrSPFINPWGe+p2RIP0so4ZV2WGTn1QqJPvXpFRZ11L94hvycvuSnGWnAEj8ZiaIMPBZ9eEV+0KNOSTWJE8YwvyD/aUsseJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AS33p/XzmHb9KzTAq1+WlrOKzXhilEV8o71RaviKTPQ7XlVwf18zsWZa+zgOjVsmTlVPMwMeNm9ivoI86G+5e5m6y3ohbqeWxw5dzSIB5le/nDjpSKakUsh2ibhUmGsIeOHUWaJ78vZkvTmddVarFqe1+HKii3KUhqKe8Wzp07aBbau2B7amoS+07UTMYh6cCyMyzGg3f+slU9B6stxkbOeR2+wZ8V7M9SprapHzdvynLTOsMHdueWfLUN72khQFd15+RFz0dl2PGy4Cgnrq3qO4eeX+q9xRauD2Qfi5TCcPMdSlq5X8Ym5euECAPCzkIsGQ1HS2SAs8HJHx6OXL84tDp2GYL5LMiGWOCzKmc4qlmH394G17gKlDIvaobmCCFxU5Y+aQ014g+Adfr5zMhllcVSgj7EGqnIQAXRI/qEMGBxt13igl5M2N9Jjz8BG7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:17:28.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb36ca48-6cbd-40db-fd01-08de83c2f4fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

amdgpu_sched_ioctl() currently uses WARN(1, ...) when userspace passes
an out-of-range context priority value. WARN(1, ...) is unconditional
and produces a full stack trace, which is disproportionate for a simple
input validation failure -- the invalid value is already rejected with
-EINVAL on the next line.

Replace WARN(1, ...) with DRM_ERROR() to log the invalid value at an
appropriate level without generating a stack dump. The -EINVAL return
to userspace is unchanged.

No functional change for well-formed userspace callers.

v2:
- Reworked commit message to focus on appropriate log level for
  parameter validation
- Clarified that -EINVAL behavior is preserved

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 341beec59537..4126e5026c20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -104,7 +104,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
-		WARN(1, "Invalid context priority %d\n", args->in.priority);
+		DRM_ERROR("Invalid context priority %d\n", args->in.priority);
 		return -EINVAL;
 	}
 
-- 
2.49.0

