Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317AED79779
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 07:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782B510E3A0;
	Mon,  2 Feb 2026 07:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IRyR0Cyp";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704CC10E3A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 07:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhftx2mGFB6UgJOO0ZNfxGjgSPSTQ2KTbdo7SW0wrsLNsfGzmLxFPtNXaSB/UyVb8o1+IgkVKWHXqQLu4COANlRgf2HgdIbJsKwSC8iIt7BnogTRAwfoIdR1c0pEjHX1NFW6GSkIFLXxhozR0CAgMy/hIz27JPTISUQ+dOhuPM5BmLdqJl8dosZXccczaMoqLeYi5VAKlgWHGZ6BcVkw8IsBjsdAIFmYiw7FbXWt3WMIvsPpNrrZidwBA39GgEPXKW9YrmkJHh8N7Y7JAtJgoMp2vANTXCMSxer+12vijQs+IEbRd009YLhe7ERSbUT0sdot0mktadzF4J4jSxrNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLCyUo6upzTXpO58hkxJeUEx0PbNaGWuOuccTktL6E0=;
 b=LcOOwydGiApWiBr0SwLJiUCbjeEp32910jpu13qCMUBDbHc/yc9wKWdoWcBqjb+Uygh5V9GmMNsDwX8WEKtFsnn2t816v1Y4jKlMvZb35t3WzOKko7EPwa2rPZoHc3O2P1tHsmopcCtCSKEWH4ALvbn6E/bsklTXoFgnpiaGN+7Mhtc6rgd6a8zTWmrJpHU+tVslL+KSjPQakp6Jq3jW22Xb1K+SYFv4TeAkQa3pJJvqr9tS2OdUhXTKYv+yJ350+yAJn12WAorXRo2C+g2X+M/rNwrKBG+XTOYm2Ljvb05WYQ/hkmlEXBmm+EFb1QVx+L9OgMMuk55JjDcLxSvq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLCyUo6upzTXpO58hkxJeUEx0PbNaGWuOuccTktL6E0=;
 b=IRyR0CypD1Utay0xhWceNhg4OyB5uK+VeOsb9Z0s9bx82Dp5A1L7F3+DuK1gKMJA9D+TlXhjfaLStpe1kvG1lPxBrk4rM6AyVG16UpCU3j7D7An8bVL8Q0t1BHzJAAna/cTWMKFOvLe7aR0CwAzwUexIFSHDnRgQ99QnsJQSq/Y=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by DS5PPFDBFC954F7.namprd12.prod.outlook.com (2603:10b6:f:fc00::664)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:25:43 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::f) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 07:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 07:25:42 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 01:25:40 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu: Protect GPU register accesses in powergated
 state in some paths
Date: Mon, 2 Feb 2026 15:24:52 +0800
Message-ID: <20260202072452.2364233-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS5PPFDBFC954F7:EE_
X-MS-Office365-Filtering-Correlation-Id: bb76f741-f51c-4f47-2e19-08de622c45c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrfrwvubFSYDJjfnxWKJdSLIDWeA/JhBtwLVdYeaqt1I00uu/t8rQzAxoNor?=
 =?us-ascii?Q?aTKhxLhlyJ4CMrikAmJ1JNRYwtbSlxNMwfKB/Uo6tM7/2HMelrVpD/80vNlX?=
 =?us-ascii?Q?2+aY2tU1NU36E47sfZr95Lf9z6hlJKuBZPIFhEfUXJIUtEojc04zCY4zWbBJ?=
 =?us-ascii?Q?1E14afIcibX0FIbjFrGOGLa+iwejb/touZsrGUKsjQtS2O1zrWBttEr8nZw1?=
 =?us-ascii?Q?3J4/C9YFOnNtiQr7+lHbxyB1upZ+P3nlBndV+NKeInNJI3+9lX/IuZ46FSsu?=
 =?us-ascii?Q?K2545u0m/gIqjVKZbahIFE27WT0UE6S7zxfyZQqJEbcJuDTsMnuokYa5qEMw?=
 =?us-ascii?Q?pZGCkEary8awpsfRiCrJ4KkwgtL1LENrEyvYSKd5XM5p9uRyR/rPUdh13s3o?=
 =?us-ascii?Q?YrLLzVTHfN8Lcz0SDExFfjdqYhCOqrNtpevpRRQxky3oKaAOe2si6HzreTHt?=
 =?us-ascii?Q?KcMWV6y6qXxwAZWE0+SRwZvfWL6tYqdjBIqLDIggTjf9N78FLwOAhUu2253h?=
 =?us-ascii?Q?O9kJ1EBCmQ0OcPhvQjgGQgCM9BrwDKCcM8ZL8gN3R0ogeS4p6kp39DQMeZZO?=
 =?us-ascii?Q?ZOWLDR3/B4jv8ZmhjZPMjwN+VhyiyyoDZW7jfV5PZP1UZ8aGatu1NK/+1MuA?=
 =?us-ascii?Q?X7PZTDky9k04xMAceFi3R8cSLgCoWUt1K7JUGLkAyrZ++GkL4sR3OgzGzgUc?=
 =?us-ascii?Q?7lIkOHpnBO+PL3bWgbpY+9y8SQP0depR+O1kqRJmO67iuAWv3gGMsW+rBQXk?=
 =?us-ascii?Q?V5nzPkMTdbswXhF20NKPIGvblmAL07O5rUE9eY7B7jyyz881ApNmJZaPK2TA?=
 =?us-ascii?Q?rhZedwKMZGjl3neXk7eyk5bYJKhMJ0LSTH1MXVEZpkDUHxiQRAYgENLlcG4a?=
 =?us-ascii?Q?tlL6EMFY0S9YVvsKRCFiRo3SYKdT8nsZvqiv0GvtZDHZCzIpsjBEkUwlb/OG?=
 =?us-ascii?Q?FmQhRw7i19u6OfHlDbp1f5vUYaZHRuH2R9kPWY+m+oUOw7PQ3ZrHEp/fThmF?=
 =?us-ascii?Q?kUFY7Gf5yHlRvi9yIwiKpD72k7PNnm+NLEvlaEHK3CKzqr76Vf6OyhpbZMnn?=
 =?us-ascii?Q?MwHbX9b+eMAvSJIKw8g76JysNB7ydRbnhHVXjpz46wUQI5leUb8SkqZHOp2d?=
 =?us-ascii?Q?sPH8HJklzlPKZ8I7fq9GAC+uj+j8RxcjY+gIK5p0c0XYaHZn9ufJVQ8y6+OC?=
 =?us-ascii?Q?hVmPXI8U91VEFahjah7opqDamul/+1v9pUU+cx6Be3v+Y/Tpf+XUp2hZVMFf?=
 =?us-ascii?Q?6TyNIEyAQZC9BVTO1VB0RG7SlKwYwj3CNzA3XKJ98FLHMQo41tq3eyvUkx7l?=
 =?us-ascii?Q?0AZEKLPXWr5VI+CVUhKi2Y+m/9IDamtlmVdiT+NJhzFRSiNfCIcjHdRfJCha?=
 =?us-ascii?Q?LWuuTyvQytJQZk8qZqfJxwhB3SgLgkDpTSED33G7nqyeFcqqmLNrNR3LoeR/?=
 =?us-ascii?Q?AZ2Mk6qA4ureYStD4j72detrGuCg2rNehOrqGOlWCIkBia+e1OFwdK5mI7o8?=
 =?us-ascii?Q?Bp7FKgfqjOv4R7DGpfQFDAM6zJZDLYLdv4YR0+Ta9F/TLCdcs5pIOgv+hd7U?=
 =?us-ascii?Q?g+BAZ8rhAArL8IgXakJtJ9eWuhkh1wQnOzul1rKqBu9MpXmWe+kZDU1AI7Zs?=
 =?us-ascii?Q?JUJ/rLVo3TF1ynQ+QqoqN+QFKedmBscM1+cndlc6G6xWdRcU4EOytFCrv5d0?=
 =?us-ascii?Q?Y36HJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rmIcjX+Vg/TZ965NiUwElrhzR/XoNVBL5JgdUhuGUeQp/yDFFjdkG6YczBE2chBnPoT+nC+SGeYiz/uvTFHesrVyt2xb6DrNr+9NT+kHXVcjmk6lvmjwRkeRx/jNUMAoO9HZRzgLwHRqTMcHuG0nOlcOPnyT/z5UiotYSAfaw/35k6IMeljBpEryO/EcYm1kH3HnrzAjL4idbVl5d2f+VLMC5koWDzKrPQaWjn2NDArspicPpe3G2BGuAMCP1aVHV1kJMwzJiYPNKcRVxHwyLv3ScJ1FgUAlLb85+HLbRnc70WqOKzj6E3DPOajARV1JONY5jnUr3oxF7kD2+KuUk31ryDi/5CnzXV4L3LqsFRWyR7+Rss9nyS6WeX3os18KPrTMMs1uAl7ur+CakqDZNF5Y7OA9GdjhWMgZaHQEND4WQ5rdIjcLn9NhYpDGWkGj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:25:42.1210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb76f741-f51c-4f47-2e19-08de622c45c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDBFC954F7
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

Ungate GPU CG/PG in device_fini_hw and device_halt to protect GPU
register accesses, e.g. GC registers are accessed in amdgpu_irq_disable_all()
and amdgpu_fence_driver_hw_fini().

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e3..095730c7ef8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3506,9 +3506,6 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
 	amdgpu_amdkfd_suspend(adev, true);
 	amdgpu_amdkfd_teardown_processes(adev);
 	amdgpu_userq_suspend(adev);
@@ -4904,6 +4901,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_virt_fini_data_exchange(adev);
 	}
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized) {
@@ -7362,6 +7362,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	amdgpu_xcp_dev_unplug(adev);
 	drm_dev_unplug(ddev);
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
 	amdgpu_irq_disable_all(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
-- 
2.43.0

