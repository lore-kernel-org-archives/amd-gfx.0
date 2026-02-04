Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC23E8B39C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A28A10E4DC;
	Wed,  4 Feb 2026 04:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUGY2yLm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D297110E53D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lri0nweL5eodZNGmncqyHkBH3v5NLTWVM+9qPr5ZpJYCdQGR1A9ONRD+xMMoZgy1nV5OQOoQb1mj+6gQ60OodVx02My0ytPmtV/The01Bed60GYGeTUTOpbLZIWAPiaK2DK3fHDe+71yQF4m8h88zy4358PretxecBEIhtDPewLDvcHCRNTyb03CfrR2qVmAfUr9+yec08ZAQoJm6TifDhwqaQjL0/9+hFXsRKBmeXy7gUbhX0/XPy4RiI98tWujpKiR0XruddCZSiBePXPxIgaBpPrDghZ742fZuqRnxHPjMr5nrz4j8G2kvsFr/uMZoOvdUuF9e6tL2f4iFmwAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsy7fSXJbPqY7VKW3LAzmpErp7uRvvrnD9ePRw4w09c=;
 b=AAslH6tzVjp494PWmfpORomatYHQytRnFwR0s/rHHiQnm5qYfD3qXbU4LoDppnIM9xv8tfazmRFV1DdlTxYcS+Nbej/NjJ151dEYMoWaqxcqsvk/aswTTDl/3Pae4Ks9NDovnZ0TOexSpSsEM+W034aTlSQR1t5bjsVBWT4dV1AbFTezQ2HHxbb+cmf5ZhEfcR39uFyo+QWeNsBwJoIpdc87pnvh73bmsOgc0PoDV3OUTFSgyVJ1e5TnIxRFwF50NdjpIt5bJ+XaIH6XjAotXjbtX3w1owjD9i5eR++gDPlPShgkTuGzsG50F5vzU3AhlZRbUYqcSZnfH+9MWXy4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsy7fSXJbPqY7VKW3LAzmpErp7uRvvrnD9ePRw4w09c=;
 b=XUGY2yLmRolEsmv5KbVohFRfy8mPPylxmYH3IWE8unPTU3/mdgLMCa4Sfgbrfc+QhUI7hVZ4gXLct3gGfD4Cv+vlVUZ3Fhws042MU9aeiNA6Qv7Wy2T/1YtcRMsrsH5p/bDYf6bfZ+f95FXwfeVcqiiZVaM4A5NLosMn7IN23Ic=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 04:44:13 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::52) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 04:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:13 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:07 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, "Kanala Ramalingeswara
 Reddy" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v2 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Wed, 4 Feb 2026 04:43:36 +0000
Message-ID: <20260204044338.96093-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2066580a-aa29-4c10-746d-08de63a80b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uiitP34xpFHesbymLjDa2Az1+4cvXmgZG884dMxw654nASnIn2WWK3lrk6kC?=
 =?us-ascii?Q?M7eM11V9+KW9kLFyJrEUtN6LZjCKtUShhX9/VxOWGGJ8/qfqP4wYvn1ajEYP?=
 =?us-ascii?Q?Ug8GfSCKEb9BpjCVO9n7ZPErVpB3PlwYtEA/yR9hXAF9jniCuDy4jMY9fiRB?=
 =?us-ascii?Q?QWEYd1CpLlk+QjGNYq5OP04VyDjZ7TQNuirg0JSDhXmYrFZVuK4dY5qXm2Ro?=
 =?us-ascii?Q?Mnz6wtZz9J19pikZ1kPwZ7Sq2Fp475kUITWKY0Y5d10/qdI3Z1U6heWetppt?=
 =?us-ascii?Q?Q/9sHEsb2JrMZ52R0iCkgscWD5sXzBzYS4a8oNDOa9qFkQ40jJbAvsaBmeGk?=
 =?us-ascii?Q?xBef/AbO6t6eydPApMyLNSqaE1tXnPLarAgOufLAMvLAdojIen8vY0Xju/Bt?=
 =?us-ascii?Q?KBJzcYyScJzc5fOKHi9rF10588O8dq/j5sQ3nuYlqF6RqGX0dVMY7Faqa0la?=
 =?us-ascii?Q?SefQMWP9eanqBnmguSVKP9yOcsoJE8lUW1E+lNheO+zCYZcvgadrxqIH02Af?=
 =?us-ascii?Q?GnSlrw9KBqmDH9JOUbcffnzd1EkBJfC4Tc/Mb3ftCf8fote+L2xn1EjzBSOK?=
 =?us-ascii?Q?m9SnKHI7KINfHIPoTtBsC7JTHbLUOLr42knJ3HWl/Lk2JFmN9d37RyRR6EN5?=
 =?us-ascii?Q?oMFBVuQdmHwav0Av8Wn7EM0/SjR4Kx3cFswah5+DpcMkWGeOfOI65EbQNcg4?=
 =?us-ascii?Q?LvDtCN5lMfx02CvuDuSdfRhSUDvPRhmpkUr4FK+Q2KKW/0DEL9c57BUt2MQV?=
 =?us-ascii?Q?MrLbkn4R8E1H28IoKMD5G6N9Q8r86yTNYVy0fdD95S3gtt9JjD7qG/e7bVA3?=
 =?us-ascii?Q?J6hU9Z23M3vWuGBRuUTrwc0BtnbamyZ4KCwQcKWXN3GRigEq5edG8iMoZ8uD?=
 =?us-ascii?Q?wj/r/hpLgaIVegJabDP3wE//Qqm1S/6KOz43GhWZlmRW4YBW0+0eJUb5Yp/+?=
 =?us-ascii?Q?mkX4rAjxhStmBjudwHdQuEQqh4U7jSi113nDZpFLi06JjN5qaBK2mMtO6dWh?=
 =?us-ascii?Q?dJpzRmEH+h12ax7Ip9psqzJFKZz9l5fisGafNZ3W9ReGwdpA8OzPBPwU9Vey?=
 =?us-ascii?Q?Y0irkPT1YnYRECpu3Z0cSIrFx8+ZWh4gZjeAB0sVyOI4+vo/8qMBicFH9Ztk?=
 =?us-ascii?Q?FSj/VMWOFjMjUFQTo02Ox7sQFxMu4eNhLWAaUj4+54n5dCoTOXFkh9yNtPgb?=
 =?us-ascii?Q?vlnUmDufvsD3NOgfC0UbGNlvsIwX1X9nOJB7YdR5gMcAUfSa7cZ+pnnUX2MI?=
 =?us-ascii?Q?lK01Z29BD34yx3tfFFGJmOyu2jGUno/lSPFk5Fkx/8sB9wt7ranER4SHbiN+?=
 =?us-ascii?Q?Lp2kDvGGHcL+CprU7ZnTC/+w0w+hbQyrBDDBfMhQgjB88xwTD2CMnCRNELKb?=
 =?us-ascii?Q?nkeTHjnLYMNSiDv/X53ccew4xrsjFUF0owV9NkvQqtDxGveNFxnChMpDCpDt?=
 =?us-ascii?Q?MeE4GjyCrZnu0aO35Yq1oUdON1Z20AxBNTDKbsYZenBgyB7BXFfCDYE4aHfA?=
 =?us-ascii?Q?EK2ImTrXz2gXNk435zPWbM1ibRy+uKxab8RVPXyBzpUoqxaWePMWZQCTWJIy?=
 =?us-ascii?Q?TVO4EIJsqkVt8Y7TJjOJwnfZpEJHNVlBdkj8Q4A0Tp3e/icWodaq7uy1fEXd?=
 =?us-ascii?Q?eMw4GmwH0/D+Y+y819iHH037zfSD5NpbGvNyYGq8z5GaJ1xYHYpCC6jCYahB?=
 =?us-ascii?Q?TXgbnA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MSliBGERRbkh9lxELWaxOuCwTkw7+L11a6P189ieNzudZUQpkaMql4ADhshpBUARjkMyDZAIDk1EdFIUQObfLGFuD37u7+ckMYchD0hTIKYms08ZFdLEl/OWe5BYZxcpGAdBbuoyyUV5ob/ju1tmgN0nU2lUYkYdFlf19GKNQnTcO6tmjU+zEEfMIXEGW7T72RVQDry7dmlx5Kmt5erGJ0ORircBsiYh3NcH4EbXMysiEa3Jb2DjCy73c8k8gNlN42y9qJUlUVSE4Od9THRIYeSV44STGBhirOt9IwjCuJ7OD9EdrmkBQTseTKYC7hXMDCBX4G9nHWUp/9XkudtijzT8qCG9u5VvbAE0QoUHwGEk1gfVaHTOikZbppnbGaN6Cn6x65aN+VysBpV40uVFG+eI3yaqL+FM+TzXyJc0rsrTj1ypu9LMMhlq2VIX4VVf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:13.0168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2066580a-aa29-4c10-746d-08de63a80b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

