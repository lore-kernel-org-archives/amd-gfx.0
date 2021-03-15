Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EF3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EE564E28
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EE564E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B0989BC2;
	Mon, 15 Mar 2021 15:17:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093DA89BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buQXmys7bFCwIhiev2InizDmhDcZv+dCwHcd1742vVby3S0cPHy9ILfFRiw9X8MPpRjXphZi2DgbvVg7L4MXhGa9XjEIxESAdjB4PqX2GAYUM8NdDtH1ch0OdeR4Kxv/esee+oq16Uenl0KAL9P1PZbmhxGsyaTceOmEj7YfrTHYFyUo++vAZu8Skhq8U0kZEiPTFdM7XkLkMp6yayMEgb90x9xaL/ELRJdJyEfsNiW03aVYx4snF/YlOEyVU8rsTYYSIkl/K7y4PsrOos4fwZZzma1Z1o/TP79j2s5U1J9aU0PWX7aTXEL/gK3l5r01U3+OX1svVZYs4PKX99hz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYmWTyDr9bdqiWcRpRsx7EMyby41ktkRV4icb5x5uWU=;
 b=D35WP8NDRxPSz6tP5SdjmS+vE+E25ta0/jUU/20CpMekAtdZYcaRJsLNEp1OZkVGveaiDI697QxPFGfdnRJnVCVMGYVpGATgagPV+MlLeMZtEnOFhDIdZ2G/qQ45ijCy8839PMxo4pJp2u/1cffg7pNd1wRyUJPt0pFPeKmtqK5M/EACVIzXKbEolaG0/mL1IsIKGE2fc2JFyeMjOal66i4OpDzGMLQvCKdxD6W8TF7lgQp+4vx1ZDgNHtmQFqjpU3eIlK0uTi92i3gxWuCRDtQ6wBmTO9vmthrf3yGjocmGA4A8ECoQtXzW5+LQP7Jvcy+3UQ67XZ1BhmNYxeOSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYmWTyDr9bdqiWcRpRsx7EMyby41ktkRV4icb5x5uWU=;
 b=kxRbzSdaUCedEzHLZBpzG1kB/yrKEQGzW9N/rRfbOG0vKmX7GdLdUjSdCBPVmJvvCeoX0VoLZ63hhsof3Yzrkm2GihL9tpjscG1fizu677Jv3ZlebbsO2NyJ990YadTk9urMoItV+4DYjN0R33FJS5CtHNyns/jEDloJIXlT0uw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 15:17:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:17:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop legacy IO bar support
Date: Mon, 15 Mar 2021 11:17:14 -0400
Message-Id: <20210315151714.1036424-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0355.namprd13.prod.outlook.com (2603:10b6:208:2c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend
 Transport; Mon, 15 Mar 2021 15:17:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c45e1ce-54cf-4d60-6aab-08d8e7c57533
X-MS-TrafficTypeDiagnostic: MN2PR12MB4455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4455417CD24933D8639F8FB5F76C9@MN2PR12MB4455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FF+kt4L9vQ0DLhPmMbVQUZy38/ZiDxWJ0eN3pPNqfgVhhj5XAqKfD28cJtdZNr6Hu4LENEGN6i3dPYjUm2tm8BHhE/ise/J/0tI+RQpBI+aMykJFx5lzxWuvS6C+qix1dGwhDSkrt7sVIZRsxpcmQHx0jTLAuSeVhMHQHZYJaVbYCtOWBy3X81WS6FCtTk64fqMhsK5LIfbFJ9guNUtqraA1I4lSsnpfqBhEP+78RHzKmhs5aJnCEtTa58S2XIxX9KSgfyzk2+FN0STYnCns81pDoISKYbCH/RsWREPuLLbo4jLgjTuIOXIn3OS1NkpP9+3zBxbiG3Jl3KoFgn2CuB8UzZZj19zvWGidudGYh9qPWYQOcxmRMLEz+8IeKU7JXycRuCmm5Fwd0D96H6iCgEsuaFTVvz4P6q4prT7hZXqMSRcZ6fGF7y5mj5ddEi4wt1mC0BUxAHXGHCULdSToo6zE0UBkellGuA1P+lgaqgU/55pU9g5bfpiUpYiOspp+RKq6zWdj9DLJ8DzGEOlyXvCJkaA3kp2OQo0sSikqU2HkyXxqZ5OvjllQx7+U64+RwXEvYn1GZobRVmM/BiXeTkM0xVEVK5aIDRX+hoYa3jNDfN1k14hnVg6O8mLpWv/sBVUce69Jj9FAgfbR2xENCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(66946007)(34580700001)(478600001)(6916009)(69590400012)(6512007)(5660300002)(6506007)(45080400002)(36756003)(66476007)(316002)(52116002)(2906002)(26005)(8936002)(6486002)(86362001)(8676002)(2616005)(186003)(16526019)(54906003)(956004)(4326008)(6666004)(83380400001)(66556008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TwQbKKiqAnzxmd8E3Z2tG8H5Hy2wtU4HfbR1BEB4T5PwwkyPIMXVa0OMD+gD?=
 =?us-ascii?Q?Rn+MTrVLSC4f9USrrj/hQyPMImJ9fWXsvWzKZmueK3zteI22uC7suYWGbmw1?=
 =?us-ascii?Q?08Vfwn8RndBLf/1EtKqhPSfJRdv11p/xFgdalpVe+AUnYIyAoSd73widGRfL?=
 =?us-ascii?Q?17DCxZg9flQ0KcAf9SYwx6t0EAV0BzDQxmoNNUqQ4eR0IPN+tTHbQzh6k8zI?=
 =?us-ascii?Q?XuaEPFFnr+KefhCiukhtHCsgb0vj8PwbxnzTmNpiazeZZqkbX1nfpWI0mWMM?=
 =?us-ascii?Q?OfNsvnhPNAbQU602qg/zBbfs7XCoep1F/77k/vlr11Lefj8VX7TMaSDpqUat?=
 =?us-ascii?Q?Mzberi38+nf07GvzZKFZrXud7a3q56kyl9Kkb2cNwsnFycmgLe41bZRu8eXl?=
 =?us-ascii?Q?0xOp3ADSsVkJfCEENxY7+4Ks4eIgGYZDdHrL+ZUHl67am82YJeJ7UbM3Bp9X?=
 =?us-ascii?Q?07PPB4+OEp97R6hOf8x1J4uWdPakAAfxaSm6i9spRRbq4VqOMjuO4HrtxnHS?=
 =?us-ascii?Q?E1nxMN1pNjsyUJmVIQ1KXz8Nr8P3qikXJZ+5V3421ZLOj1QevwmQ+/8r7QT2?=
 =?us-ascii?Q?13grdgbNJm4sGeBoGNHHo5FzULoIfHxYL67lU2h1R70YfYqzRHStd7HaWkX1?=
 =?us-ascii?Q?zYiCytUHOS1iLj9ZVQSy1JMktQti7DKzyGBJSqgKE1HRy/AcID5J8cGXgV4m?=
 =?us-ascii?Q?H6NaX/iOfuy/jH3FBnDR/CjRXcwFgt/VODJctCTOAiudh2h8SIWg5jrYyU/e?=
 =?us-ascii?Q?Ub5AGQbomO1Zz0GcE6c6//1Ug4hcgmrSiyaThA4m0yzK/aoe0C7VfFoqmVgF?=
 =?us-ascii?Q?JVdO3SwUoTZHFb14dvuI5RoADotI3nGwVTvKNlKvwfwoc05+xZDlUXWLIMOM?=
 =?us-ascii?Q?wFUTr0YjpJm6HAVUHZcRWLqIJdKUwYWEeMS7N4x8K7fEv68FkxBxOBl/IB8k?=
 =?us-ascii?Q?CQDRQbej551RFeiIrLfQyaSlSEC7MPHVcTsn4no7F1ld2ya1hucJ6JG+n+H0?=
 =?us-ascii?Q?sSX5ozpMPDy/wCJHnfQefA8ePw92sNGmu85xtqEYF/OPyc39+cebdwnZhf3g?=
 =?us-ascii?Q?Ljx8QWh2yQ6uKHa5YlCM+qZMGfbEBVLcaOSap7/YbZzWeIa0CGj/q0ig1Dtv?=
 =?us-ascii?Q?Y2U823xswSrwDhDdp5QOnDvQM46HaeB7B8CxrDDOfEQOtQw1E1gLUTHn9Q3k?=
 =?us-ascii?Q?zeGTdADqofX4OlfGDaC9d9NfsWvpAYbKejnwXjc8E0krF09HfGYkzgIS7OaT?=
 =?us-ascii?Q?8770cB2ePycUHLRVm99zYQf3APt8fYE0UwXwR0TXZsiNUu3AqU4RBv3djE4a?=
 =?us-ascii?Q?7HEoVod/oClF8vp87x+oEZQf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c45e1ce-54cf-4d60-6aab-08d8e7c57533
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 15:17:33.7327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BKIw8O6+vc+rSl7xyyJkkZHYpq0dbnX/9pXEan3TaK9jSB6x6sqtj1IlHwI7jx8FKGmPlAco9G539we7t9a7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It was leftover from radeon where it was required for some
specific old hardware.  It hasn't been required for ages
and the driver already falls back to MMIO when legacy IO
is not available.  Legacy IO also seems to be problematic on
on some thunderbolt devices.  Drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  7 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 43 ---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 57 --------------------
 drivers/gpu/drm/amd/amdgpu/atom.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/atom.h            |  2 -
 5 files changed, 2 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f69e6389bdc6..e738ebbe738a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -876,8 +876,6 @@ struct amdgpu_device {
 	spinlock_t audio_endpt_idx_lock;
 	amdgpu_block_rreg_t		audio_endpt_rreg;
 	amdgpu_block_wreg_t		audio_endpt_wreg;
-	void __iomem                    *rio_mem;
-	resource_size_t			rio_mem_size;
 	struct amdgpu_doorbell		doorbell;
 
 	/* clock/pll info */
@@ -1109,9 +1107,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
 
-u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg);
-void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v);
-
 u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
 				u32 pcie_index, u32 pcie_data,
 				u32 reg_addr);
@@ -1202,8 +1197,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 	} while (0)
 
 #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
-#define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
-#define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
 
 #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
 #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 86add0f4ea4d..e05648a8a145 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1905,40 +1905,6 @@ static uint32_t cail_reg_read(struct card_info *info, uint32_t reg)
 	return r;
 }
 
-/**
- * cail_ioreg_write - write IO register
- *
- * @info: atom card_info pointer
- * @reg: IO register offset
- * @val: value to write to the pll register
- *
- * Provides a IO register accessor for the atom interpreter (r4xx+).
- */
-static void cail_ioreg_write(struct card_info *info, uint32_t reg, uint32_t val)
-{
-	struct amdgpu_device *adev = drm_to_adev(info->dev);
-
-	WREG32_IO(reg, val);
-}
-
-/**
- * cail_ioreg_read - read IO register
- *
- * @info: atom card_info pointer
- * @reg: IO register offset
- *
- * Provides an IO register accessor for the atom interpreter (r4xx+).
- * Returns the value of the IO register.
- */
-static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
-{
-	struct amdgpu_device *adev = drm_to_adev(info->dev);
-	uint32_t r;
-
-	r = RREG32_IO(reg);
-	return r;
-}
-
 static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
@@ -1998,15 +1964,6 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	atom_card_info->dev = adev_to_drm(adev);
 	atom_card_info->reg_read = cail_reg_read;
 	atom_card_info->reg_write = cail_reg_write;
-	/* needed for iio ops */
-	if (adev->rio_mem) {
-		atom_card_info->ioreg_read = cail_ioreg_read;
-		atom_card_info->ioreg_write = cail_ioreg_write;
-	} else {
-		DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
-		atom_card_info->ioreg_read = cail_reg_read;
-		atom_card_info->ioreg_write = cail_reg_write;
-	}
 	atom_card_info->mc_read = cail_mc_read;
 	atom_card_info->mc_write = cail_mc_write;
 	atom_card_info->pll_read = cail_pll_read;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e04ec3c83485..112749549c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -466,49 +466,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	}
 }
 
-/**
- * amdgpu_io_rreg - read an IO register
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- *
- * Returns the 32 bit value from the offset specified.
- */
-u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
-{
-	if (adev->in_pci_err_recovery)
-		return 0;
-
-	if ((reg * 4) < adev->rio_mem_size)
-		return ioread32(adev->rio_mem + (reg * 4));
-	else {
-		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
-		return ioread32(adev->rio_mem + (mmMM_DATA * 4));
-	}
-}
-
-/**
- * amdgpu_io_wreg - write to an IO register
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- * @v: 32 bit value to write to the register
- *
- * Writes the value specified to the offset specified.
- */
-void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
-{
-	if (adev->in_pci_err_recovery)
-		return;
-
-	if ((reg * 4) < adev->rio_mem_size)
-		iowrite32(v, adev->rio_mem + (reg * 4));
-	else {
-		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
-		iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
-	}
-}
-
 /**
  * amdgpu_mm_rdoorbell - read a doorbell dword
  *
@@ -3361,17 +3318,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	/* io port mapping */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		if (pci_resource_flags(adev->pdev, i) & IORESOURCE_IO) {
-			adev->rio_mem_size = pci_resource_len(adev->pdev, i);
-			adev->rio_mem = pci_iomap(adev->pdev, i, adev->rio_mem_size);
-			break;
-		}
-	}
-	if (adev->rio_mem == NULL)
-		DRM_INFO("PCI I/O BAR is not found.\n");
-
 	/* enable PCIE atomic ops */
 	r = pci_enable_atomic_ops_to_root(adev->pdev,
 					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
@@ -3693,9 +3639,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	}
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
-	if (adev->rio_mem)
-		pci_iounmap(adev->pdev, adev->rio_mem);
-	adev->rio_mem = NULL;
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
 	amdgpu_device_doorbell_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 515890f4f5a0..3dcb8b32f48b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -114,11 +114,11 @@ static uint32_t atom_iio_execute(struct atom_context *ctx, int base,
 			base++;
 			break;
 		case ATOM_IIO_READ:
-			temp = ctx->card->ioreg_read(ctx->card, CU16(base + 1));
+			temp = ctx->card->reg_read(ctx->card, CU16(base + 1));
 			base += 3;
 			break;
 		case ATOM_IIO_WRITE:
-			ctx->card->ioreg_write(ctx->card, CU16(base + 1), temp);
+			ctx->card->reg_write(ctx->card, CU16(base + 1), temp);
 			base += 3;
 			break;
 		case ATOM_IIO_CLEAR:
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index 4205bbe5d8d7..d279759cab47 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -116,8 +116,6 @@ struct card_info {
 	struct drm_device *dev;
 	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
 	uint32_t (* reg_read)(struct card_info *, uint32_t);          /*  filled by driver */
-	void (* ioreg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
-	uint32_t (* ioreg_read)(struct card_info *, uint32_t);          /*  filled by driver */
 	void (* mc_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
 	uint32_t (* mc_read)(struct card_info *, uint32_t);          /*  filled by driver */
 	void (* pll_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
