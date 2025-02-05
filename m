Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8131BC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 11:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E7C10E191;
	Wed,  5 Feb 2025 11:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yHuHl1KA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AA510E786
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 11:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aflE4qFpr4Uj81FEv8nXlEzR8zXVuSvEBJJbPQvkPOa683p8PEb1qinfkZKff9AjvYUeeKmU0XdDBKcmw+7L/mSBq9U89KPQBrsalHiCpudUK9Wz23yPrbcsaPZV3VMF6Q2UakJlZ1w1Vsggxeu35DNMD1dqhqlrphUAQgeCOIPrJjN9T7ypkpivPbhtVEGBvWTNm+SdMr8m9tHraXAjWT3XdkLbRN0Vwy5Ig68yzUUuSxRbipnCXYMAVBVsAuLFlVPqY6yzA7aa9zT72VSFBYeM8aLv7ij/ulQDt3jglr3Kk+iMHat1DcJLYDlvG/AgzCxVfcGt5a1q6ouO4pW2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh9mgjMYkWXfpG+bRORYGp+0207dmMtPDt8ddJYrq1w=;
 b=lqMWZ4i9YjlWfyfjTtPP0NgVcbg6aQo6sc1Ypy4j6oYfRfw2yDjqZjs3op8FpXAUph/po5l9JDsteNlPIBRwEAp7zf7r6YTR71nROYLTW6XQPCTHkI7JeHSdD8qlAbuxlLGMQcERS9c7di2T7Kwetk29KEqT9VIHL5ktm9/5fEsf9Yka2RSDEP4qsdPfjmbBorWGmxyUX884/6imWpxKTDB+G2G5kFAUZSK3gJibVWju6oGsx6YYbXaiLqLGhlllHuzJbzFB3f24+oGL7Z+WFMY7Y3bgpjK7Utkxs3HWjENhPYRq9kn1vDZY7OvPZZ92pTv/BHUac+n30csFE5ZjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh9mgjMYkWXfpG+bRORYGp+0207dmMtPDt8ddJYrq1w=;
 b=yHuHl1KAhoIovz8xPc6eoAjF80eGCSgUpWle+uPbM23WhDsQfVgz89ktmq9Yawv/zfOqhIk24bqCQzSuulgz3y0LXODfHX2Yb+vgdg0frSTbbgUg8NZi7D/12OFCY7aj79OwucUBtN7kbHFQ68wKS3jf1njNjFMULV9w1A5qA+8=
Received: from MN2PR02CA0033.namprd02.prod.outlook.com (2603:10b6:208:fc::46)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Wed, 5 Feb 2025 11:38:54 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::d0) by MN2PR02CA0033.outlook.office365.com
 (2603:10b6:208:fc::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 11:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:38:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:38:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Make VBIOS image read optional
Date: Wed, 5 Feb 2025 17:08:32 +0530
Message-ID: <20250205113832.1903614-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205113832.1903614-1-lijo.lazar@amd.com>
References: <20250205113832.1903614-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2bb16c-10d3-4d60-1199-08dd45d9ab60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QN+PR2sNitE8DbelEH2EONIZECPeP6iA+3K1zKt+E8G/aq/7/Yt3Lq+wT20y?=
 =?us-ascii?Q?R7lYCX8dSo4f0mw+EPQAGJSTxB747zQEjNd2hc+RJlZpRAfA19bJAgj97egG?=
 =?us-ascii?Q?bXKtSFulPT8fvFk8rSart8dC1XBkRx/0dQ/eio29OZkdI10YJ57crATDn73x?=
 =?us-ascii?Q?dZXc0RUX49sbVrzqtCGEbCrCJpYT1NhaGRtL76pa3gluBvc07HkKyO5l8Y24?=
 =?us-ascii?Q?gSoB1Qme7DHNt7M5p3Go2fGlrtdkNEWtzD8kpF1/haVorNwp+UYHakSueNRZ?=
 =?us-ascii?Q?qYZHqsDoEohtMlJggiAbsXdILptE8R4R0ZCy2MNjgBfrYl1sl0o3bwedC6PV?=
 =?us-ascii?Q?h1bJIYgXV1K9zDGNzFtmNGmr5X+PVH9SZDYcUbfXLdCmiFkrf7FN05lzXBZN?=
 =?us-ascii?Q?2pd9HdGh/9rF4mQud8EUqp2jDZ+iALSU8IoJBogIK/mUJ7XG7mNMrTRM9jcB?=
 =?us-ascii?Q?nw9tAKsosUfYCvFe1/uRGKPyuhFiyvAkvIEO3zmJLJUweIy1NfPH1ZJS0II/?=
 =?us-ascii?Q?uti2dkNKDNDlmhfXfAvcbeMLEcJSpYHhJ/yGxnsCHPd+MdxRKEWbOSlHRTCS?=
 =?us-ascii?Q?ozZgpmpuV//FgR4Spa1gkV5VJGSbgXEvmXcCwUx0hNk+Du9LXCk5rnNauUFz?=
 =?us-ascii?Q?8EzMgI/VxwZGsOWAB840LrolwRuDQAAwvmUqWOajACYd0BwbSqq1Hc0mLE+b?=
 =?us-ascii?Q?FKiJSQyLxRoqI576EiS1UnTk6yFlGqCs0d/0DT3rQKvjYwqTiT03IKZKTpI7?=
 =?us-ascii?Q?YtFaKxMoE/59zJjbDXMhlk2RU+rOOQwEnxVKrI+qbu0v7mH2zka5ZLnafF2s?=
 =?us-ascii?Q?j06sneYVcbFqePTlfeTZeSb3SHgrQi9Az8upGVm6Icu7pOOsBtSv/blM1n1U?=
 =?us-ascii?Q?5wItAcn2aciTOPh+NOhd2HTWb54YrcB7jziopKpGVWFoxGosk1Ni3zwGd5wO?=
 =?us-ascii?Q?M6OBn9gg2dpnSFbKttX8qgssHn/uvrhv8no53mDJl0Tu1CrfL4luSWf1YKY2?=
 =?us-ascii?Q?NGOrbedXzkclWgHXSEXUkMu27wKxecGn1LyD8vPDEwMEQro5ewzzGK9+wTq2?=
 =?us-ascii?Q?0HN63oCU47+U7UCZDaFtW2p/7xaST+VjFC4dWc/XPNtAGsrP+shk4XpW+Jbq?=
 =?us-ascii?Q?hJqCZr34/dROuhGVy7hlqUF2MkAOPlTLUqliexurXR/KqO2ILrG9PAJPm+Ii?=
 =?us-ascii?Q?x0kHM8scf8LiB8CTS5ufFcUffS320YYAlPvTf0N5L2zdT8703J2tG21c8hnn?=
 =?us-ascii?Q?FuHUKdLL8PUr1RV4gupEWhE/V7a+FG0IbL/yHQvOMCet+IIePT0xzDDevNO/?=
 =?us-ascii?Q?yKxZ+XyrjqUWkn9FdacmObUxM96Rwx92vR5/uZ9aD+6AdUADI55l76RKkChz?=
 =?us-ascii?Q?UzL52H5LWOOhLRU0crFLfY8zk5TaXbPSOubdx82a2ij5MPTNSiD2ro6ABIvz?=
 =?us-ascii?Q?2qk0Ch1qYROMfYwLp+Ll93dJ+X/5bNF3pv7V8RCCzJtqQigXP3bkfq+Tl1vJ?=
 =?us-ascii?Q?Y7ZcT2GPkrsJihY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:38:54.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2bb16c-10d3-4d60-1199-08dd45d9ab60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

Keep VBIOS image read optional for select SOCs in passthrough mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ddccdceb1d2f..ade4d5cd45aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1397,6 +1397,9 @@ static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
 		return AMDGPU_VBIOS_SKIP;
 
+	if (hweight32(adev->aid_mask) && amdgpu_passthrough(adev))
+		return AMDGPU_VBIOS_OPTIONAL;
+
 	return 0;
 }
 
-- 
2.25.1

