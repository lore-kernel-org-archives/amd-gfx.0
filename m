Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D78C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9DC10E2DA;
	Fri,  6 Jun 2025 06:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KrmaeG2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5881F10E068
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7vzcCc53w6U0gmikjBHQwlFYGvpkHPS5GlB86o2q4Vhd+/xW9khaKzspWv8po1CVhMdjwSF+MPO+tLIiWS/rj1neSHhgfgxyNsvMxqOdFyO2nmYkjozOqjixwUc/z1D8+gyL3oVSE0gY8IQyfeG2quLm7nrCsYX11kh7jjradGZH0AjKr0aAx5oC2AboTcDeM+ntPxgX8MpCfR1gOfKtT44Ywmq1fPEs36sjmJqyylmlyIXv6aYwxDEK2+HUtz/lvBHBmEaRqT8m80a/UhdiPXIUnpHjv3R4DQKXAgt66paFGt3B0IlaWpnPqJuAhfqElJWme7TJKJfMsFwR45ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwGLe85VYsLMDhqCoL1vm0BsomtdK1XvEVSt/jD8XsE=;
 b=K92Bs7XsvZj8h47o3nB1cWnpW9RwCBmwLMkh4ue1fnL1Ewor+q+dXL8qp1AHYIWap4ayvD6S2f2Fo6cNe0ll4ikiDyUoEDxkf4DDLnUQcSVNvMIpT90LjaQs8V7xdNrTt2hj2P3LxbXNYJtfahUxjPq7U0x2Q7qgTkriPL3W3pz0TE5Nx5sxIT4VEOf7YNxy0+cjXEjf2LqpsUEASNtcpVL9+lakQb4IhDi/o0a7nxpOmGeMErHGhnvfkO8oSXz1g9nj0QwdH45PNgC8Q4J7ZLmSE5eFDyDxWob7JlBYrSvCakx4EjdPLgTK+prIRXdday8nWHtofymDlXtB59UE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwGLe85VYsLMDhqCoL1vm0BsomtdK1XvEVSt/jD8XsE=;
 b=4KrmaeG241lMIi5pZIO3qC/L4FA9J4yS6XeUALY+VVOlejFo0n8rYUNZicwLME0+LlYJoyYEtb1VskSEMAvc597hd7633JP8NTuh+sydeeIMxQDIBcSY2UanheW8H9TuhAR2+Tk8xi5FhGKoK6qeluW0tg/38Wg6Pfk3tl7wHNs=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:11 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::bb) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/29] drm/amdgpu: enable legacy enforce isolation by default
Date: Fri, 6 Jun 2025 02:43:26 -0400
Message-ID: <20250606064354.5858-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6766cf99-22d6-46cd-c6c8-08dda4c58b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THJjTy9ndWxGUklaa1UyVVNieCtDZTU0QUw5SHJZKzlKUCtHY3JGN2lscyt1?=
 =?utf-8?B?WjZZOWxESDljWkVEcnhmQ1ZpUlFuRXY0UHo5TzVEQ0hsUkE4anVKS1N6VCtk?=
 =?utf-8?B?TkR2SENxaVlYZmpEdWtkb1VEcU9XREpaRUk3TFlnVmZ3ODMwQzRoaXJ4QXJF?=
 =?utf-8?B?UGYycnRWSDJUSFI4K2l5ek9DcDJCRXZrSVFJWG9YS0I4RHJBV0xiVXFGdVJo?=
 =?utf-8?B?eUl4ODBtSlI0WjdYcEFmaGlsZkRVZDVycFplYVBrQ1FpZk4xeTgwY01SUGsx?=
 =?utf-8?B?aEJOVHQ5dDc2Sml3c0VKMHVwaVVOalQ5NnNyL2tWT0pJZ2NESjluZUxNWUYv?=
 =?utf-8?B?bmtSakpKQUoyY05OWDNxaFpnTHFub2tmN3J1SEsyYmFaelkwaC94UlQ1ZTZE?=
 =?utf-8?B?WERWUXBObGJBYlN4dFB1V1ZUckhBaXQ4SVE0S0hkN3c1b1Q3MDRhK3hPRURp?=
 =?utf-8?B?bXRtTEZobWRuMW0xampKa0w4RWp1RS9rWXM3czdqY1huNkJpTXhveTdmMXla?=
 =?utf-8?B?L2REaVJ2U2Z6cEwzdDBwV1F3SHhONlRkYzhmcG1acTJkYmVZNUlFRm42ZFJR?=
 =?utf-8?B?SS9UNmRtdWR4bXlrVTN0QkJqcUJ4RUI5cGN6Nlo0SUhEd3lmZnlZMDFwM2ZC?=
 =?utf-8?B?YkdBNUZ2Mlo2WjZtNVRkSS9wTUpNdVhld1AzZHpiOG1yT2pkazRWVDVKQ1lj?=
 =?utf-8?B?Z1hOZmJKOVNQOEJpT3N2OUdETmFOd1lOTGR0dlVPUlcycXpaQnZlS2pXYkEz?=
 =?utf-8?B?WXpVSlRyeWZMd1NGZ1M0enRmU0NGT0lkbDI0ellYUG93TEpaZ08zZVdqZTVi?=
 =?utf-8?B?cmFJWnhraG16a0R5a2ZtSklKUFR3QmJ1Vnd1b2hwL252QlV6TERtdXNtS0tk?=
 =?utf-8?B?ZTZkUmlKYjVveXhrc00zUmZVNHEzQ002RDZRZjhpWlZjSFRya1JBY2l2cUJ0?=
 =?utf-8?B?S0RoTGVUOGRVNnNWYVlxd0sxeFQzZmtTcE5RT0ZHUkhGbDdHVjhmSHpWRk80?=
 =?utf-8?B?b0NycHA0cEp5WVE0Tmdtc21PazQ5dy94MjZuNThiKzRwSUN3S0Fya2FTTWFn?=
 =?utf-8?B?QjJ2MlhucTBnbldFOFpwREpncm1nYzZhT0oyL2VnWXBSbE5XMXBnRy9QOG5C?=
 =?utf-8?B?NWVJdUNYTS8wR3dqcTZGblE0cktRRU92RUtSOGRrSlNNNnlKYVNhaEU0cDVM?=
 =?utf-8?B?aUFDYnJwM0pXZ3hGdWppWUZUUGJtV2htUkdOZE93OExMN3dwWmN0TjJ2bUpv?=
 =?utf-8?B?aWZ4SnZzN3RCOUsxTVNHUTMxQ2dSKzJCa2JHVS83cGlyMEhDMGdleWxaZXo3?=
 =?utf-8?B?cklVN1cwZG1zMElQNzhmMmdZRVVlaXZXZXB5b0s2c3lIZ3p5MlZvQUFQWjVJ?=
 =?utf-8?B?Mko5ZUdwVjNkek9INkxTZWg3ck9JM0lONGQ3bVYyREtzUVFaRmhVVFVzTEFB?=
 =?utf-8?B?L0dVdUNvQWpCMW1pYVFPc3EwcXVyL1ZiUklWMjV2MXRESDMzM0xabHc1S0Zr?=
 =?utf-8?B?eHBZOVNLR002eEF1V1UvT3FoNnJyclVIQUJKNGJoQ0lkUGVaYjF5ME90YTRR?=
 =?utf-8?B?SVkvUm8rS0hEMEVWcTRnZkZFWmZYZVNTQk9BQmtXWUlzUHR2YitLbGE0T0di?=
 =?utf-8?B?N21iWWxHSC9ERG9XWlBMYnpiQTQxMTRHUFVCTkxSY0ZodUgxWkt4UFlmOFJh?=
 =?utf-8?B?WjBrMjcya1BPZmxuRFNEWGJoSEtWdEYxNW9Dc0VISWZRdkV2NkRTYWsvOFRq?=
 =?utf-8?B?OVM2Z2MraHhGQkVtbWRJbjVvemxXZktBV3k2S0FPUm5pRFNMRWJyQWdzN0Fr?=
 =?utf-8?B?Q2h6U1h2SUJydGtpNDFxaXJkbWNOekVucm5kdEtwcXJQZWR6L2U2d0poaEsr?=
 =?utf-8?B?Ti93UFVoWlpWbXl5T1kyU3dxRVJ2ZFZMR0s2MWtMdVZySFFkdUtBWWgybndx?=
 =?utf-8?B?Q1VHalFweVFaUi8zV2ZRQTFvUXlyU3M2c2RQUHBoZVNVZVYzQTBjSk5KbXp3?=
 =?utf-8?B?bC9tVTdSYTdqbmNXNWVpVjF3YnVzNzNQbFZQUGdKNE1GU3NMTjM5OWZJdmV4?=
 =?utf-8?Q?QWjNoB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:10.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6766cf99-22d6-46cd-c6c8-08dda4c58b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e64969d576a6f..ea565651f7459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2148,9 +2148,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	for (i = 0; i < MAX_XCP; i++) {
 		switch (amdgpu_enforce_isolation) {
-		case -1:
 		case 0:
-		default:
 			/* disable */
 			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
 			break;
@@ -2159,7 +2157,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE;
 			break;
+		case -1:
 		case 2:
+		default:
 			/* enable legacy mode */
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
-- 
2.49.0

