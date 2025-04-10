Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C53EC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 06:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A7B10E07D;
	Thu, 10 Apr 2025 06:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXIuYeeh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753E910E07D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 06:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgppH8kz2bq/fM2sNWvaxTbdbYQMupjmyGH8m1MNMuESvtvLvOSPsZEqBQpLtaaeIBEr++h2i2/3wmaLdvEKIqfNryRRTyLtgqnNP8AA7/RXWse9afoXZZzNhuImOWVbRTlgRPBn5YmdqFKheBFFJuAJyeat28Gxj/2nEqbyxaeyvQNDhO+ogk75wFJ1uO7yI7hH95Mpgzs0t7hiLLBYISncWISgZODVmwSu8NY/gCgJqfVlzgnMWtvgqRc/PolBgy6vAmqbXG1JJboiA5atFolbUKoqyBD3WsftdZfyIEAeHEg94eiimBSj/OUIfRM6PggUP8E6BG2XyVcSXCoY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZXml8XKLW/Cgsm40BJNI8Rg1GLiaE8MpxS9jxFfn9M=;
 b=wC6uzH5WZcdksNSfggyPh3MhZui//PT09lCPsdByFkKtFpJk/EsOZ/bjJSxOZU8QaRQX991yvAC29mOMc521Uz7sCbBIS5vpPhdfDxr/Y0wUElzvJ3VG3FH2zBDnXy+S2f7HaTLn/CEwfYg7qkSHyQ5YzsDLNjfwWVAGQupaAtOEWCEflFnhuOO1Hssf76GfQBD/35J1o/UvaOda8tm2SP5AVB8CRMDXUDmeV2U/Z8AyR9iTTshatT96z4sTJ/9sCEx3lZjfIfc3zZ7HbIAet/uvhuK2Oy77SYsXvqb+q2BowbJ0165bgU6kchYqVxfk6S4TsmP0yYD/7wOXnTQE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZXml8XKLW/Cgsm40BJNI8Rg1GLiaE8MpxS9jxFfn9M=;
 b=EXIuYeehtoy7NI5B4P6e7srlfexcvo4Bu+kYLvx86+Vyf3QUkkw+26jinNO3K6MvipjZYbYjFvK8TLoyzbIHa6KMeQN5aqPP3oQmeNk6kEdiah6a56lJm6KmkI4t78seYzoJOOn8v2FAX+kvu5sDjBNefyARNr+MHvUt+DtS8H4=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Thu, 10 Apr
 2025 06:26:03 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::32) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 06:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 06:26:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 01:26:01 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 01:26:01 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Clear overflow for SRIOV
Date: Thu, 10 Apr 2025 14:25:54 +0800
Message-ID: <20250410062554.573023-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 578e4a6f-fd3a-4c9f-44a9-08dd77f8910d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CqVb8BLMbPcqyKXS8pvgZ5TxjbY/+bjUnG0Alw44O0UCRHi9h2tbf67uZMMG?=
 =?us-ascii?Q?KTHxSy5RDJIuF1vQcU8IXGSnyRsyvTV6Yxwrw+6OxTzNj0hBt/uAhEBZfjZE?=
 =?us-ascii?Q?lFpXXVzfbsuUX6mr2vgCKmA2Mag6wQvNVppMLSFVv1wmUUMogSh3uqKK5mix?=
 =?us-ascii?Q?FgKPVhL78pohKt9OYQGKsp5rQbXBdYD/3denHMDwh5n3ys6lBAs7TFvyHNvK?=
 =?us-ascii?Q?xrQpCzCLznQSjucBCxEV+i8XZk2iDDACaU3zz7WQ5tq9LNIj+9pq9CrvJTq0?=
 =?us-ascii?Q?29sZW0idLbgwZ/WIRp7PA2GAYAmrVEouzpo5aCv4jUHebKyhQQVYF+M3e4kV?=
 =?us-ascii?Q?Z7HA0mC3B35tODvNBTo4upaI1MJC8/JUA0xkxIeQEl+yVgoknWYQ5dlU3V0B?=
 =?us-ascii?Q?1xuHIOYU6qhjhOSCkR3DUqTZU7ipWoD1dtQ63+Kd3w1EzQza/xAWx0fw8dPN?=
 =?us-ascii?Q?i7+kIJHmhercFckAmAWL8V1EsTiwAtxbKUAwav5uluH1f0WhLEwxMy1a7lSI?=
 =?us-ascii?Q?QsyL6ga5XIrfTLcCAm9pl4K72hi2Rg7zeyyQjRGo8uOF6tMu3wT3CYEuyy3P?=
 =?us-ascii?Q?cb/AFe9/IEXy//DKSY2wumcD9Mfs2mR7AZsPF0BW1DnmV2nBLilh/JRBQUBU?=
 =?us-ascii?Q?CwNMOqt3HjOHVpHDFLcuePcUueXk7Ixb6EFZwLWDYmeiJRc64Y/vUFX8cSMD?=
 =?us-ascii?Q?IpMYNNAGBD2g9s9M4LALUyJnBUto80bdRZ22Qt942tR7XrBrNXH2Ks5Miwix?=
 =?us-ascii?Q?5MiAXTWCtgvi5Qmyu4058oLluN+D61TbtMoKjOepGcVXj3LbOGxzw3RFHVmY?=
 =?us-ascii?Q?QyKQcNUuHviXVdAgCV4Nn70dlo35IiVUxFnDEmUchJjNTpLD20MIttQ+aVrV?=
 =?us-ascii?Q?ko3dxby/ctDOuhp4G24ZhiVHBrDOteouWFZLARcGIdV+MhN4/hHKvTWrcl68?=
 =?us-ascii?Q?voByj+7hvAN9dt4GQvYnZWcU4dHdHLhQqmqWR+GGpSMFVjgD0AOdknngdvir?=
 =?us-ascii?Q?qEfsIzdtxdtr8J+z3YvM04jW0jrEvqHIDYBntgQPgSPU3V2ua5hA9IIb2ByE?=
 =?us-ascii?Q?Dng343DK4YK1nNlx6YL0OUPblxLIaVCKJ+IljJ30UroLXY0vvjoOtk7Iav8h?=
 =?us-ascii?Q?+mc73dkD3aqxm+K3uXkTYuj264axbzKruJin8euWxzaLhcJfk8pl8f0nbbMO?=
 =?us-ascii?Q?h1ppLgjVedaXr98GUe6/Xd6cSmMsvhZzvdpN5zBlnFTxMGQbpcE5Ww5fX/Nc?=
 =?us-ascii?Q?Dlgbcl0gCrNV6lyjoY4JHCBtuZIoNp5iIZYrO0OprVQejWhLm0Q5H4Qmmd98?=
 =?us-ascii?Q?zyxYztvYKi39hGHC0TmyI44kw9WYTLS8/QoelHophxV2qezYjnFWDvy7F6LE?=
 =?us-ascii?Q?9TmT6DZ6z6ekyQC33/tMwsLR1Y2cC6U9xbuy2MI1MpzaM62vC/0zTuPXc+pC?=
 =?us-ascii?Q?qvAVxl1SNaz7VUQmv4EGOSWnpSwDbhkEAsRR98riD2zZJQ+wjwpdUX5DI73H?=
 =?us-ascii?Q?cSU6Lmso5LUk1ekEGTxFJOr6aZdi3U9p9kKy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:26:02.4857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 578e4a6f-fd3a-4c9f-44a9-08dd77f8910d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497
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

For VF, it doesn't have the permission to clear overflow, clear the bit
by reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c |  6 +++++-
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 901f8b12c672..23bace1b457f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -227,13 +227,19 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 		ih->rptr &= ih->ptr_mask;
 	}
 
-	amdgpu_ih_set_rptr(adev, ih);
+	if ((!amdgpu_sriov_vf(adev)) || !ih->overflow)
+		amdgpu_ih_set_rptr(adev, ih);
+
 	wake_up_all(&ih->wait_process);
 
 	/* make sure wptr hasn't changed while processing */
 	wptr = amdgpu_ih_get_wptr(adev, ih);
 	if (wptr != ih->rptr)
-		goto restart_ih;
+		if ((!amdgpu_sriov_vf(adev)) ||  !ih->overflow)
+			goto restart_ih;
+
+	if (amdgpu_sriov_vf(adev) && ih->overflow)
+		amdgpu_amdkfd_gpu_reset(adev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index b0a88f92cd82..7f7ea046e209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -72,6 +72,7 @@ struct amdgpu_ih_ring {
 	/* For waiting on IH processing at checkpoint. */
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
+	bool overflow;
 };
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index f8a485164437..8d3ae88b96a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -349,6 +349,7 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	/* update doorbell range for ih ring 0 */
@@ -446,7 +447,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index e9e3b2ed4b7b..2ad209406d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -350,6 +350,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 			if (ret)
 				return ret;
 		}
+		ih[i]->overflow = false;
 	}
 
 	if (!amdgpu_sriov_vf(adev))
@@ -437,7 +438,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	if (!amdgpu_sriov_vf(adev))
+		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+	else
+		ih->overflow = true;
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
-- 
2.34.1

