Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66228C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B618112E33;
	Fri, 31 May 2024 06:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWkgGwC2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B2510FB99
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl4yUkyrya4gjIDNMiak0I1UV97xnFvDlaEW/s2nItioOgrzLf+VEHsA7WpkSyzazqKQXmKgEwHg53g1djzBhnfogseFYpRnxvmi2yf1gSh1SiFLwOncrfCPR3/wm9GBP9bDMz6po8VOR1WwV2VSMX+M8gscLDpsFw6dyPyISksfUmNEnc8Bb8Nq/PP+vdRh1ESZefnv/2oF7Ftsm3goIeIrVug2a3hJOU5u/gRdLhUEMkS3lFSgeHYJJCr0E/y17mupfI4z64ro/trgdsjY1YC+8FdeNCwCG0vSRbTeNC6jagOKISqwzvb5f3TZ768R1D8jLLebIkNuDRMyRZvC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N18W8jCbgfAaJkZmZywZB2ltuv08hrXDXALULnyx/G4=;
 b=ft4cBdcIF6rRfU1J9ejgxos59K3C/+VTrTQfNjZ8E5wAIF8VChqnaZHHNTONdHKT0fXMO1TJzuJxJzK4oufGinQ5TD2vJn9lS6i2FQUuPLRpCdy3tRTHDwm6312ZLxwf5dWFHMJIjOxLnqoZyzrsNPdtDhcvHtjUI09h/lKC4ixlm0GweVRR75YfiUWF1vxbJlC4PuNLWhXhBWB+6bhwL4Rm9IL+GZ0D2Y0OCmcHWBTwNQZYcr/4htkD0BMbCWQdXu+6mtXvWlFFq0sbir/MSEh8j4uxrNE0aFrQEfljtj9znkUIEfhdFZArQoLAj0r+Pn0prrPuBymXT3lJckg1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N18W8jCbgfAaJkZmZywZB2ltuv08hrXDXALULnyx/G4=;
 b=PWkgGwC22HLYGBirl5l0vVCIoMbvpT+lWnIJvrH1z4pC3Rpa9kEYGNjqPuSj5C8IXsMtiIA4TN0jbIPVkE66sW7oncKH13zTSftUlRJdmKsjlxGZIGTbMf62ZOocdL3uY44KtlDsWbsFFGylD+/ep3lG0Q3RY/iR2JWdVkchcfE=
Received: from BYAPR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:74::32)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:18 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::ca) by BYAPR05CA0055.outlook.office365.com
 (2603:10b6:a03:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Fri, 31 May 2024 06:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:14 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 11/18] drm/amdgpu: refine vpe firmware loading
Date: Fri, 31 May 2024 14:52:42 +0800
Message-ID: <20240531065249.1746350-11-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb1a417-74b5-4167-5268-08dc813e5a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X62txY52n1vuontd1nnVPcdQYQoeft7dG8r0WVdA00Bv7y7cmVm+jp/IWHze?=
 =?us-ascii?Q?i7wBH9oISC8uOw3uwersEmYXRYV4bMkaHu/jPjV7QQfg1Pj2ZiGOB/PMday3?=
 =?us-ascii?Q?GXfh7oUmN4VyYyA4CPMk+h1ouRiaFS/amHbQZT4bCt2KWdWEBcD5G+5Q8U4l?=
 =?us-ascii?Q?nj9gQvl8xTXO08MJdGMI2FCCdsdTr+kdya47yQap8CVRmOhmQ7iDhp22QTXe?=
 =?us-ascii?Q?IBB4TEmJyCdi7beGxW+hSxaTLn78SdJOEwYzKcP+CU4vdlxvhNanqRAWlBaL?=
 =?us-ascii?Q?tAjrN9E/GhE0rrqc/SAI35OI14K3WPyYFxc9tMkZ9nyNqKPmOCKee/ilVGNI?=
 =?us-ascii?Q?VBSZyvHScznEdeWmnXo+rYyCpYJ+2K2xCuQfPwHo1384owScZ2yPYeloLFVK?=
 =?us-ascii?Q?aQRFKkKvj6rD6yq2pANzvfr84Arst1q5q3P5obvKoWvliJLwT9EhesuaLvw0?=
 =?us-ascii?Q?Nt8z8iq397UnnNEVXSrVPf9C5ukMV/FX0GJwITXsGRicsoyM4v6T23cEFhSB?=
 =?us-ascii?Q?LEcFG+vmsXplfg6NNvqy0Su6JQAdeJOERl8SNCUaUwbPFG/nx7KfBPApAqod?=
 =?us-ascii?Q?P8ZGboYuIppvmViydWrDBwonwsuilgRFUMxluNwv4aemgCDJ9M/MtQm5Vpzv?=
 =?us-ascii?Q?5yNYO04Ca1FtY4l6A8As9UBC8stLIujK1wDTBc2FjOc93eKS12aJkShUIeNW?=
 =?us-ascii?Q?dHzI607DZLsNPetsqshTWAwHCMiix8Js+kFFCTIhqxbQe9kXhqvzjU8okKzV?=
 =?us-ascii?Q?yklUthUmHDOncZO7mcsUvggv6Nje0FsJd3PDogBNrV3SKioP9dXyam7WwDb+?=
 =?us-ascii?Q?E/Ry1BNbvPOcks5JfSJUX/7VBDjg4oimmRS7OtFDjvMsklcc4rqKd+3ahY2d?=
 =?us-ascii?Q?nzgCjr2V44BvRjDbYKo3xfkbrZZRwd3XGsfNRN0L7krNDACLPQyHPpd75evt?=
 =?us-ascii?Q?buNv4pdICYpJYcoEuj7M6Zqex/SMkZ9TikQ717uP22Pg6yx6VfQ71hRTOEbd?=
 =?us-ascii?Q?hV52ISaOcV+DKcNuvkPLAgo4863sM/BpnV+tSStXBG5bXKmHVtuc639Evjh+?=
 =?us-ascii?Q?RvJ+kCR/fYByHp1enkbLww6R1Jhi+O6YG58vJGGE9Z4EUjie4MOAAvOVTWiJ?=
 =?us-ascii?Q?JI2CGmMrBJk/dyvysSzw02ZLRUf9e/UG5YwCxif1aVcg/RaJ7m+ZtqUzKYry?=
 =?us-ascii?Q?9dDQheYOT97HA+8q+ODXylwpvfvXI9kU8IEwnw5uwljA++dSAo8K7Tk01qQz?=
 =?us-ascii?Q?anniFTw0WXigSra5dDjlhS2QtIizovr/pToIKNIXLaKpU/3OfdDkOgaCj07O?=
 =?us-ascii?Q?VT0Wpi0Rb8QnfGGU5vE3rc/wHzT3VgzuXOGXjuO2cJkm4bJVBgZh/QRcoFAw?=
 =?us-ascii?Q?9iwYH9N4L5sNaJ65ofkzkIS7mRE9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:18.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb1a417-74b5-4167-5268-08dc813e5a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

refine vpe firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 49881073ff58..bad232859972 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -232,13 +232,11 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr;
-	char fw_prefix[32], fw_name[64];
+	char fw_prefix[32];
 	int ret;
 
 	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", fw_prefix);
-
-	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, fw_name);
+	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
 	if (ret)
 		goto out;
 
-- 
2.34.1

