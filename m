Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB72F9EDDB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 14:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 576B710EA08;
	Wed, 22 Apr 2026 14:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ae8RX1BU";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1314B10EA08
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 14:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDlw+uwe9GlLOdvo1zYdkZfQHdfHsQKY6wpf38muowdf1OUCJHkxtkPX/eq1aW9wTK5sXxgjS+0nQD4s5RBn8G+2O/YlYg995AjtJUXZjotZ8AdvBAEkGAd8BEvF+Ma7w4f31V5jgWLbu75vmz+CVuiTXDOuZynTcJlS7Zu3mGKiqdUxEwLi0SlUyfW+OsqgfPzPuIuJZxGXc1CeJp0/wX3q/nVkFYLfqk+5a+7uV/t4lYnjqE52+AOJuMDetSPBK5RJm8pwAJjBAtb2vSUlFQvKDF+qRVbahDakeRICRNqo+4GPUPMV+5hnQRgSvbxh3YRU5kFydijdcyPLhX3v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CD5zpkE5hh2x3m/JtJ7sPkxTLuyQRvamQZm9n0s/4Q=;
 b=bv7ja2SPWXLOuTfLr2Vb/JLG/S76naiiXFU5JvZ+NEC8AKhI8KVSKnmNpQdhKXqa/KfWdYH2H/RBYfOUtIksB0S9MVa0YioU0qOzRH6If5ktrkq5NfhRjxh7STpRj3U1+8EDUdcjEjkPzGUkRhCrk5CHtIM/kn/OzWunWfIAoGeF4z86iKiFMdq3dcwO5js3RFhm6D128cCZwuMvYvN79J/BZhNKOLw3p3s230UIgxc3RIusujbodGLXc/23CfAdsjeVhggd0QKvZjPsy6TZfgpBqW9b5MAfzySj0vjwiAVGrBQPUat1HFv0m3N8Kqe0pal6OkzxNjMhm8mxuHUNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=outlook.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CD5zpkE5hh2x3m/JtJ7sPkxTLuyQRvamQZm9n0s/4Q=;
 b=ae8RX1BUgZ8NBMm497lRtJIA3DK/pKZylgwCzj9LZvNyC8pufXkHmTEd9qOLk/61BUm6Bt5RFFF7Iz51kaZfTNJdpxKTtPlm8TuABkSvRiR8kwbK9G5dNnzTvnQPRlGtgjt9SXEw7oHaQYJ8Z1VJ1M4PZFru8zdjcZ2Bs4Zw5bU=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 14:31:09 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::13) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 14:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 14:31:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Apr
 2026 09:31:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Apr
 2026 09:31:04 -0500
Received: from [10.254.93.15] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 09:31:03 -0500
Message-ID: <426dc28a-5351-4a15-a80c-ed6dea9c910e@amd.com>
Date: Wed, 22 Apr 2026 10:31:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Shengyu Qu <wiagn233@outlook.com>, Michele Palazzi <sysdadmin@m1k.cloud>
CC: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <siqueira@igalia.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
 <TY4PR01MB144321DF5415AC90AC7C4E34898212@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <TY4PR01MB144321DF5415AC90AC7C4E34898212@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f01bd8-5842-4a0a-f503-08dea07bcbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|32650700020|42112799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: sPNVlbPQe6gUqYGRpyfGXHzDnP2gz/G/9kK5TMVIThPx9kM9N9KFdbfg7xwpn6UQxaj25a6g31FOAHzrlchqaBff2zWTg6RF2Z4iEv5ZRPFh/4T1YCqLNeWq98tE3sutMy2X3wHjPqA6JDKPr3ZpRbmoToREG3wsGXYOGfD2T/k547yuz6QUZN0X9Lxlpv2IKCEJ97MAxvtMhbpvuNUQ1haWmwQc3qtn7nw5eELlylX5kL2F9SZl3YN0rROrErCkAS+fAicoFOpVDVd/r9Td4MbsQnw0MFRmRkcCaP3zUspPh56/EBQ4wg3jJzpHnKQ0VO83J1+jp/WoO2xn0wtfKpt90TXDFUZ9qSf4jMFcnOlse+GonEmpq73jT/4vpV9VQZPUAPmqfx9csbSurFITU7OOV0kO/hMTz0cRgJpVHsVWyt1P7Q764Ht+59dLgiTavalfIA6zUIm4x9B+dgG54SqRTC7S2YnYmmeGLQGLEWZb18QtV4jrSAPoD4/AHPBw6WYNxwsI3c8TU+HjDQtvqPe6bAA5vxOJaG2acAvPfqQ5vc3PnhAfSNDNJR4t3hioFRZkB+7d+/KRo7+WFN6ulDgneRvGLWOWekybNT3aDgEMLlUYO78cLZgQ2lXAoqon3biba122IDzDVsAs9EV+mjOk+HUrO0cBzOV+kHFwY1ntDggMC9h64BWSRsd0IXtdOt5Vou+l8spx9V4miVo7WqhToIcGt8Uq1SEFRMobItck8WHDp4iQgPubxOOlaOytQ5930frMxHeuyoyFWMpOPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(32650700020)(42112799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+UO5YlYozmgNzIhAFonMPHWStQnLIIwNO+ohoxCU7bAx4r0UoJTF/TqCjfvZ704yWuhRDNqhGPFsLfMYV9jLRWaQPOgPu1rN2SD+FJBSIJw8j3pTtksLLOtDkvwUMyV888+tCDw9u1sAMB1Tw2VQeCO3VE1a8IZ7mDn6fEhjHjdqHfvlkS/BR16ZajhprKkXnpI3NUDwn6JpMFVebEX+2J7ERQpd/s6vrMupPmYW6R9Dl5y27qxtqZGcVpg3k6LUoSUg6feGvmm9495yyfZbP3gdqmVrbc4EoIm/Iw/7t0QsqSZ/yJVbVGdMJnxIAAb9mwQFGe44VVlinhoVIvAfCa0CUwGZE1hJFZFyOZN8WLnQEvWcxyZCukzxMQCCGb5UWHIYnX28QBNwiUTQ6PqG6mWO/Zj1Z8j3o621X1T7FzyJ9wTRRfQHCCpUfQ30suQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:31:09.5242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f01bd8-5842-4a0a-f503-08dea07bcbea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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


On 2026-04-18 15:37, Shengyu Qu wrote:
> Hi Leo,
> 
> Could you merge this patch first and do more discovery into this bug
> later? Since this solve some problems for users.
> 
> Best regards,
> Shengyu

Hi Shengyu, Michele

I vaguely recall that restoring the old 5s vblank off delay helped alleviate this by allowing idle less frequently.
That may be a better bandaid for now.

Let me know if the below patch helps, we'll merge it if it does.

Thanks,
Leo
---
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517c..ce5063928413c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
-			   IP_VERSION(3, 5, 0) ||
-			   !(adev->flags & AMD_IS_APU)) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
+		      IP_VERSION(3, 2, 0) &&
+		      !(adev->flags & AMD_IS_APU)) {
+			/*
+			 * DGPUs NV3x and newer that support idle optimizations
+			 * experience intermittent flip-done timeouts on cursor
+			 * updates. Restore 5s offdelay behavior for now.
+			 *
+			 * Discussion on the issue:
+			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
+			 */
+			config.offdelay_ms = 5000;
+			config.disable_immediate = false;
+		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+			     IP_VERSION(3, 5, 0)) {
 			/*
 			 * Older HW and DGPU have issues with instant off;
 			 * use a 2 frame offdelay.
-- 
2.53.0

