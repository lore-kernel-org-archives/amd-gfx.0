Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D7EE20A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1091A10E734;
	Fri,  6 Feb 2026 13:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6DX2/Ag";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE36810E734
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3hPY0KrtsuQO5Jjj+11buZv6/lx9OigUNfzcR4x0uwWxYbusIUUOmiN26VOtn4JN5xaO67AcAFXaFyRhea01v2KKNojMzY6w3dL6MwFQ99F8bx9w7gtu6ICpkacWN9xpzF+gecbYelPRpcrsb0Bx1G51BX9n7kM9SkDfHOUP/N42Llxdnb+NhXJAPePotwc348DamNsB1IW5Xef1NCPwtIRXEdd0Bt/0vcOeaquqxKiricNqmdSyqZRZHASZHa5cXLF0fqKlLmV29bbq8rz+4GowgR0BYarTDQ7unZ3SC4dCkoRB/wO92raIJXGzZOvR3a0mt+Mk09o91vd6qo1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=NMEYdcKHdGkxflyDYBsQrlkPhYo05Illbhyl16SnKUAcHWmIq8d43GXTZsYv+6j5dM1t4mdwoS2U5PjAOPq2EHeErsBUhk6RjJJS5BSPjcyN866Arq2Xcg/Kle1rBj3gnZhE2tRedz9zStR5lKAs7g5keS+Frgt1/+L32Rc9PEH8d+LtZyECs1Kh/0W+6J6dTl/xg8djrp7MndHhyaIi6Hn0Q/BJdnrRI3s8V6SWD3dXTkgHHop6BnL1XcXFOcpxKWuNHQ+/AIt8E59VrPNMU8geIKKGkdl1gn1iPZi7VP0wzQiev7BtGGNaGJsHj1CeMmXz9uJ4Ogbfcs5ikzyFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=y6DX2/AgK7CnUuYuJIe+kl89OrGe+FFq0OO8O15Yahf6VIw6Lc0xMqd2XZg2Rxo0o/u2WXUhHPuS38o0bWFqApdmLHw366IQEJJKOcc5nDZTFOdc9vqoSFXRapI/PRTM0y+0mvNmrvHFi3gfhludAzR6z43WxAJ4cfT7mAy6+lg=
Received: from SN7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::26)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 13:36:38 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::72) by SN7P222CA0012.outlook.office365.com
 (2603:10b6:806:124::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 13:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:38 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:36 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v4 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Fri, 6 Feb 2026 13:36:05 +0000
Message-ID: <20260206133607.91047-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6a6fbd-a0e0-4906-287d-08de6584c14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SMSAhfTJz4ABDY9Gdql8dFuV/RZXz0KaqOQ6M63PgrKM6ZjRgVUxIlVcIPBd?=
 =?us-ascii?Q?6vOAPaL2MAtwUCX1RA2/ShmWXQ5Mb6b6/qCXCGsIAK3C88ZavMXjs19pQ1uj?=
 =?us-ascii?Q?ipr5YEh0Y+GjAC7z03K8HZUn33eFCNYkrnj+AJIeY4LLOpxhY6jfTFRO8gJE?=
 =?us-ascii?Q?5dyJWRXUc78t3OKPGFsg5c6S/V1Tb0VNkptRafzZTqODwYF6d1EKXWS4adN6?=
 =?us-ascii?Q?HfTUWG2Mm4Mg7obSqU3dY2wlqNg1LQ1JBz1FcdzOtdLTYL4HCwxqs9vKS/gT?=
 =?us-ascii?Q?D3w8R033H9d9CsA2Eau7RCs9CkYFgXY858fi980wxl2jqGn35eg055o4TUIp?=
 =?us-ascii?Q?042M9oPIBTR1zAak/ze2OOIXb0Nxh3Gb3kq7eed8FGXbI8i98eMfSmnaqCb9?=
 =?us-ascii?Q?utJHwEunamYpiCkl4xpltx/T7koM76eVbvkuCciVRB6piRaG5JvLSanKa+aw?=
 =?us-ascii?Q?mfAxW9q+Z6kNBir6h6CSgp7NSKyD5HCub+H7jiiqxG+1eP73/ySTHz+9PeBs?=
 =?us-ascii?Q?tGsAWBt5sUwMklzvGluzZhakc97RX6Xr4iA1FDbPjad78urbnqmuaK0+jvrw?=
 =?us-ascii?Q?/z6fZxreuJCffZeurVZIeFzysOn0vAgav1Uz/bPYEJN1QNhTJRaBQ4dOZnHz?=
 =?us-ascii?Q?CrXvEuQgPZ4uZXXhDm2XJ2L1DO3sRKmksNAdenmXQjMyDw+axLQdB41nnI1w?=
 =?us-ascii?Q?y1/2UjwCQWykgfzdUprt+T034n95SfRYfFkwrigQgDRwU7K0UMufmhixZggA?=
 =?us-ascii?Q?m1RsRgI/H2gIriu6tGHg2VEvV8UYG+AzJ9pB7eyJzRqqzi0EJJQxCUs8EdA4?=
 =?us-ascii?Q?WO+LKw8cVC3rbFQwdkW1r9uFVaZv1soFlv+mmSPUxo3ZwRQCLZY1Qbn0GuUo?=
 =?us-ascii?Q?b9QlAqdY863+/9jBy8jUPSqIBCjCS3DjxjfVq8+UG7l96cnCnvXSy29BtWhE?=
 =?us-ascii?Q?pSSKY6r5nDhdKnwDXmMhjSw/AvS0CEfUFc9tKLxNs3ueiuUKvjSD1GTlszVf?=
 =?us-ascii?Q?924cwePV7IoarKN6KTJBRmyB+bKwxkqYZ5IGD3F/TKlDujctnZrf/2uTMkKe?=
 =?us-ascii?Q?5E+x5oDr+XBUeWrh5yEAZKG/8cTFXolcRQkbiTW9BeosbENCzjZwUabiB4Uj?=
 =?us-ascii?Q?zvcdCcb81UD9vbKzjbwQPj+aohNviOmF4hATpKkC8izIvB9EH70F5lRzB5j+?=
 =?us-ascii?Q?Yyt6Xp3x0CvDNY8ihiGclTcAGaF+UCEKIYQoisXFvR4rXr+1ljyvbjt6I3Vm?=
 =?us-ascii?Q?ybpEYuCZAzH25IE6BDFEuFHpL5wMwZphGuMZ4KiCLsyRfQu7N2ZmvTL2oTmi?=
 =?us-ascii?Q?jrfy+B8srA9gnvB06eoTmsTGW18yFHvLgoK5LWaVHTz67OEqJjEC4Vnqrvvp?=
 =?us-ascii?Q?JYWPPbTTkvpLXN58Cka6a1d9PgyNpUo80+qFSCah4GWYxq7lEUQhQ15xTDpJ?=
 =?us-ascii?Q?1jfo2kQ8Q/ZmRYis3V+gPb/RmUCGEmYfYj+teRWyyHJCo8vmKxU2+2/DC1vC?=
 =?us-ascii?Q?CAZ8ql279WrJPZjRVdnZRbFWCrh/CcJaqih6o7Ab2AndNZVtV7bhUVTTHv9u?=
 =?us-ascii?Q?V7FS+49kcEiKvVDtZFTHfk8XHIPxpX61xALhCRjPod/2B4LPAw68tZr++qxq?=
 =?us-ascii?Q?UVTF3yGg3Q7VffExWNpiTK6ARA3a+Pwk1YUwSsLl7INXVN6Qcn9edfTgCTcE?=
 =?us-ascii?Q?fUWNzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wTj9j9fYHFpGvtGhA9eDvf1j3QhElHt7uyHj6BOa5nWEEqDDqKzlZ4a6CVBtgRyCTQGbhEI0H2R90Ap5dybt5+/GhhwJsC9MkcWyBkqVNC/M6Fl35gJIW7S8Qxs9bEdjUcnOlm2F3/en+ae4zBmreoIfSIfhpbhJFxoz0G+3sAewrneOCcoBwhGZ/K0jQSUTm5LBumo+Q/JTsmcES/cJasqkftPBYwvDnHtbwT9K+RyX2UqPSLyiNjGcP15ePA1HF2ha/vQrCMRt7GAw1okzoWUdX2o5gVaI44ufRaXGlxiTaZrIZaqM+2eWwMsL9q4k5GZvJ4en5BjHkUqW+4PEMlfGovrQRSa+Y46GnGlpVv4+CaxHBhvYUiWyDBKQYUKb2JrkEaj92HPu+s0nOcjHMcQd7l6dGP8GgSd1TJb56q8tqXm9ABp+EP6BjeBiQDkA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:38.5834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a6fbd-a0e0-4906-287d-08de6584c14f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
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

