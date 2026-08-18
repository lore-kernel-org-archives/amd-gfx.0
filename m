Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F204C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 16:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B1A10E066;
	Tue, 18 Aug 2026 16:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JjA4oxWW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC22910E066
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 16:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWwAWSyM1OdLNPoVtbsfdX9KqZYVmTYj4DWd13gxFtAi1wY0agERfHmA1EtAWuXL4Aup+ZU2HW3l9eQUVnvmUheEwgNf3Z9AWDUA3+hU/0LryohV3g4u8s2lpXOAwzhtCL1x6K6BsZK6T3jEPuehfZWNk2r42VF/cfxFzRb6u14TUvBoqRmmGgqqEuiwUIjU/XgKdikk98FHzqVQR2x5Sppfnc5firkoJsokp1Hb82rXw4+b51Wty93jJXUvzPrmK+KqE58YSAEyZJTX/iBQoiB2eezLQtnz0fEKeyaRKHLCmkfk5TvUoBD6B0KA9UbQx3AxZaXB5rbD4r2tzThjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIxLTKApffKtCFI/cgvdRzfvlhtzYLA+lMHRwwzOSfc=;
 b=CT5lhmJRCxUT3ili/5VqgErBft9TBANRjKbC8VIWSlQINbYHoiIUgfbxsQKBz86f24zKBL/mwoY1J0GkMZGtdFOT3+9+M7MXm8XuKIRbJQBnXWBeqrZoF+WDsrxih65rujQg3TgYvepItRFslAlvzQ43QKbCctnv2u/2fibco0MpTziY8OVibIBaxAHCJEq2AuMmZwNf2+StaHC0XZ/N8QxpTwNAwU3rP+FZyMUiThLvq8syvlcj6DU6B7Bb2rptIXCpONGVhpK//yFFgJqbLyjArklPi6eONmKdNnpPMYtOWJ+AKQJktfoovBPI9MIWlfydK/5uyJV97vrdR3iyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIxLTKApffKtCFI/cgvdRzfvlhtzYLA+lMHRwwzOSfc=;
 b=JjA4oxWWP99hcUzDvp9vnTwSkcsaGxh1oNP7XxLD1UdsS1cbLwdPVZAOMlv9PB74sMFQaCxKbginbuAsQkzRBj9WXw6J9kbvUlOBM0VajdXklbVO/lOYzcKX4DX+zhzYhTaN072DqelvZvDDTWUw6okNMtXEz2T/bRR8ql4n40Q=
Received: from MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 16:45:41 +0000
Received: from MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f]) by MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 16:45:41 +0000
From: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH 2/2] drm/kfd: Add CU occupancy support to GFX12
Thread-Topic: [PATCH 2/2] drm/kfd: Add CU occupancy support to GFX12
Thread-Index: AQHdLoGw8fJpihtfK0mKBorhN4/FqLakA98g
Date: Tue, 18 Aug 2026 16:45:41 +0000
Message-ID: <MN6PR12MB859093D27307262B59988593FBA62@MN6PR12MB8590.namprd12.prod.outlook.com>
References: <20260817194953.97887-1-david.belanger@amd.com>
 <20260817194953.97887-2-david.belanger@amd.com>
In-Reply-To: <20260817194953.97887-2-david.belanger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-18T16:41:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8590:EE_|SN7PR12MB7347:EE_
x-ms-office365-filtering-correlation-id: 3617214f-fa86-466e-5327-08defd4823e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|3023799007|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: MlTNmu8n4+TTcViEK9807iaERBA7Y0iPU2+Lwug1t+VjLaDmHGpelbmLFNjBfsf6tQBIglu1FV7XUd16yFR9v4IPn1FDzx38pZ9Sp+f7CCE+m7a6NvxNT9QBT4EOh9a7Cvhrb7yO4kPNrWVUH42vPNpS8xNi/eQqxU3q/Ql2ahoj/ttUOqKl7T5UN26Jqemh3qPo/KG3jyUIptkOQZqn6iSofL76PXGThlqrySadPtgT0UMkIzoOTnnP3CtGYjLf4hTQXTPWr6zDFTy+NJnDmOpuNETnCkbkxa8rVMSapNejHLFspf8ICsz0TK2GLIkJt6aozoYNcUkcQDCHU6SwmfRYWLo7RM+QiIaTBIdd/gBGGhVUh9dxGnpWxwfh0TjQBuRaqPDBR6352Zy+7pGWOmOcJ6231qdDLdGUEMOBlGeYDcYcNRFBv9d9cuUlNv7V+6NQu2El7PRwlPEQwJQVRXRi8NFiqW9sTZkfnjMoBrOBysjvNfgLRLNHCu+BRfoiM/UjgwDqF2F14wrp/mfA8iTa5tv6GkbqEAn7xSqkfPTN2vDfqiy3fwkdfhqaZgzjSqlJl3ZCOTLndkkwVAie/AnJNu8HbaM79ePSZX7jX26hcbwPBIJJQd+JoTRCqeHXdm/3AUBpyl3OuPP4PQSjKS9WzfyIH7doyVmNSZbP8kTWZVoa3yrVfr/ww1mWIgxZcjAs6hgtfx31FnsWJ0FqdAfZlI0u5M666Fx1Wnq/SaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8590.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(3023799007)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T7D4fKoD8jLc5Xv6RUlAU7MSPkYK6PI73Smim9spIoeRNmSvHXEyu3pRzK9p?=
 =?us-ascii?Q?J3tEIdMbghoC1U5PQhV4aa3p133t4LVGQxdcmoiG1v7BqQPmXHh8I0wqbleT?=
 =?us-ascii?Q?AFm/GAGc9gl0/jj+vmp7N3yiK29T0sDNOJr6pNmqrkJDWjZV3t5F2qzctQNG?=
 =?us-ascii?Q?4FOkdeys1//o/IUDHt1WSGKc9YQakZnVa55nlKhN7EQKByn4ByDDtoLTPSY/?=
 =?us-ascii?Q?LizNCpPoqtxrczbtqTRKhsg5AP4umTSHqB2j8SEw5zMo7vP2LJe9HWTPId0P?=
 =?us-ascii?Q?DIaoqQ3HbpILsUgJUByUC4ovUiDjwjABhmtaMfGqDv9vpqW/w0/9P5d0fczH?=
 =?us-ascii?Q?I1fkbhWJVVX0/2JMpL6d/UH9WH7M3+TjZaojCDDesFk05xBet7ajNHsHD+/l?=
 =?us-ascii?Q?cDtmGgQALcDj1GgHOupuPuBnHkwBw4P+hgw7AA/oH2S4DWrsxUWbx68UDbZh?=
 =?us-ascii?Q?JwS6JgS7JSn/7v9SlrmgnB6tYt0NBGTOGYR/pXSZzHxIs2FagY8FPl/mw7pB?=
 =?us-ascii?Q?ZMRuHlj7e3hnvCx8o3PPcrQvzOePX5f0gj00Y5mZgKpEl0dn2ynIE47DcCc8?=
 =?us-ascii?Q?euITHzsd4CMQrIdE5hZ5iKTXUKgLmmp994Vx8pic7b5CrK7fF0BDluE2hDAa?=
 =?us-ascii?Q?21NukF0dQd4p1K1zh5I6KDMhmUOpwL5egUaTNpm6lIPoSQn1dg9AIL01QvzR?=
 =?us-ascii?Q?AY1qjnNweebkKSlMyIuvdg9XpF10J/PSqfY69oGiW45xj91C5oJmQWahtXgS?=
 =?us-ascii?Q?cOba1/Cu6qeMrrMAKDbiYByQsdFfTTMT4YmKUpIM7gZjDTLHKZhKzTt49qLQ?=
 =?us-ascii?Q?AHNQEwLJw0WAj5NPSEgOLZKNM0rSILBDtYcn8SUsI5aYBV7DBjgAhZhNEBbl?=
 =?us-ascii?Q?GuHxGJ0pBTrk76lot3tI2s8b988pszx9ETLirciQ6CIChlhC5mHfdkoKCqGG?=
 =?us-ascii?Q?LnxeaiJoTItr5dWfkslHKqSaRgZ8vnEDIQcIVESmGGN6duJnsf/IYsrwnrRF?=
 =?us-ascii?Q?P0J7JlfiQaR+HmV3al4NSpWbVIzzTzLTPsoQ2O6sxPAIUFHckVLATCe54wnI?=
 =?us-ascii?Q?n9o3iQ/QECIFwA+VCI4iKLfaEzQ+dK+zAtw1oLJXSYah060H9f6nh2YiBSYN?=
 =?us-ascii?Q?JGHNOrqbiu5jqxEPc79VjdNoBiDiHl2wHscW6t3IVL3AWbYDMtgm3rJTsDAl?=
 =?us-ascii?Q?o50WVZWimKDjiEIrsD4ULiICopFgu9q9kleEHY2MBhxw0eEHnYfdfc2kx6Tq?=
 =?us-ascii?Q?q35CBwxVvR+XQWd+ADb77s55e4tiV8Rkx0Vb8swsqMhd0b+jWHQME9eFbkms?=
 =?us-ascii?Q?sbBIvaPMgwtwnzkmNOOiGHk02moCVDvYodw4ehb41Ge4tVVYdFQs4dHAmIgO?=
 =?us-ascii?Q?KgB+6eJnvBrXspimldtPqSGo8Z49u88rfriDFdzCHgAAChn7ko+lawPUzOx9?=
 =?us-ascii?Q?ATGJP1+265QOCNr7pMyEhgktFzalAH5aGMBNjSCfdLGZ+nzWYMqPNe5meRFa?=
 =?us-ascii?Q?uiyvqZ0qKdB2co9SpzJ32mPVJJzZHH7U+c4g5n/3usAQyX5PBvMRtrQJ3RO1?=
 =?us-ascii?Q?f4tACkX53Im1H2ehAIt05NBRGmk/YjONK0hxmbaENMN36oM7pKd+CNOXhieG?=
 =?us-ascii?Q?D5l95Q/QQLgrbk2Wc6gpBdF7P17hfLkCaqm+RBTOQXDVjRF/gq/Nx1P6j4wX?=
 =?us-ascii?Q?XiIlcBzGwMWieKJbpINy4iFjBb++E3whQkUemiBLYs6gWmJD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8590.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3617214f-fa86-466e-5327-08defd4823e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 16:45:41.4496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uy4WE3oWYnqgxI9+VT3zAJqBTM/L3w5qDmatkY9TkGA5HTZrdxfVBBcdNKD6qeQTnKDeYjS5EjK4rFNpDmsBYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

AMD General

If there are active waves, gfxoff will have no effect. This patch series is
Reviewed-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>

Regards,

-Sreekant

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Be=
langer
Sent: August 17, 2026 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Belanger, David <David.Belanger@amd.com>
Subject: [PATCH 2/2] drm/kfd: Add CU occupancy support to GFX12

Port changes from GFX9 to GFX12 mostly as-is.
Minor changes to register access code.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: David Belanger <david.belanger@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c    | 150 +++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index e11ba3e918411..c7717cf0e148f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -368,6 +368,153 @@ static uint32_t kgd_gfx_v12_hqd_sdma_get_doorbell(str=
uct amdgpu_device *adev,
        return 0;
 }

+static void lock_spi_csq_mutexes(struct amdgpu_device *adev) {
+       mutex_lock(&adev->srbm_mutex);
+       mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev) {
+       mutex_unlock(&adev->grbm_idx_mutex);
+       mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * get_wave_count: Read device registers to get number of waves in
+flight for
+ * a particular queue. The method also returns the doorbell offset
+associated
+ * with the queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @queue_cnt: Stores the wave count and doorbell offset for an active
+queue
+ * @inst: xcc's instance number on a multi-XCC setup  */ static void
+get_wave_count(struct amdgpu_device *adev, int queue_idx,
+               struct kfd_cu_occupancy *queue_cnt, uint32_t inst) {
+       int pipe_idx;
+       int queue_slot;
+       unsigned int reg_val;
+       unsigned int wave_cnt;
+       /*
+        * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+        * parameters to read out waves in flight. Get VMID if there are
+        * non-zero waves in flight.
+        */
+       pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
+       queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
+       soc24_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
+                                 regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slo=
t);
+       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+       if (wave_cnt !=3D 0) {
+               queue_cnt->wave_cnt +=3D wave_cnt;
+               queue_cnt->doorbell_off =3D
+                       (RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL)=
 &
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
+       }
+}
+
+/**
+ * kgd_gfx_v12_get_cu_occupancy: Reads relevant registers associated
+with each
+ * shader engine and aggregates the number of waves that are in flight
+for the
+ * process whose pasid is provided as a parameter. The process could
+have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @adev: Handle of device from which to get number of waves in flight
+ * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
+ *               for comparison later.
+ * @max_waves_per_cu: Output parameter updated with maximum number of wave=
s
+ *                    possible per Compute Unit
+ * @inst: xcc's instance number on a multi-XCC setup
+ *
+ * Note: It's possible that the device has too many queues
+(oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This
+could lead
+ * to an inaccurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid =3D getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId =3D getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be
+incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is
+ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have
+ZERO or
+ *  more queues slotted and submitting waves to be run on compute
+units. Even
+ *  when there is a queue it is possible there could be zero wave
+fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g.
+waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides t=
he
+ *    number of waves that are in flight for the queue at specified index.=
 The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, store the corresponding doorbell of=
fset
+ *    of the queue, along with the wave count.
+ *
+ *    Determine if the queue belongs to the process by comparing the doorb=
ell
+ *    offset against the process's queues. If it matches, aggregate the wa=
ve
+ *    count for the process.
+ *
+ *  Reading registers referenced above involves programming GRBM
+appropriately  */ static void kgd_gfx_v12_get_cu_occupancy(struct
+amdgpu_device *adev,
+                               struct kfd_cu_occupancy *cu_occupancy,
+                               int *max_waves_per_cu, uint32_t inst) {
+       int qidx;
+       int se_idx;
+       int se_cnt;
+       int queue_map;
+       int max_queue_cnt;
+       DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
+
+       lock_spi_csq_mutexes(adev);
+       soc24_grbm_select(adev, 1, 0, 0, 0);
+
+       /*
+        * Iterate through the shader engines and arrays of the device
+        * to get number of waves in flight
+        */
+       bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bi=
tmap,
+                         AMDGPU_MAX_QUEUES);
+       max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
+                       adev->gfx.mec.num_queue_per_pipe;
+       se_cnt =3D adev->gfx.config.max_shader_engines;
+       for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
+               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+               queue_map =3D RREG32_SOC15(GC, 0,
+                                        regSPI_CSQ_WF_ACTIVE_STATUS);
+
+               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
+                       /* Skip queues that are not associated with
+                        * compute functions
+                        */
+                       if (!test_bit(qidx, cp_queue_bitmap))
+                               continue;
+
+                       if (!(queue_map & (1 << qidx)))
+                               continue;
+
+                       /* Get number of waves in flight and aggregate them=
 */
+                       get_wave_count(adev, qidx, &cu_occupancy[qidx], ins=
t);
+               }
+       }
+
+       amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, i=
nst);
+       soc24_grbm_select(adev, 0, 0, 0, 0);
+       unlock_spi_csq_mutexes(adev);
+
+       /* Update the output parameters and return */
+       *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
+                               adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v12_kfd2kgd =3D {
        .init_interrupts =3D init_interrupts_v12,
        .hqd_dump =3D hqd_dump_v12,
@@ -381,5 +528,6 @@ const struct kfd2kgd_calls gfx_v12_kfd2kgd =3D {
        .set_wave_launch_mode =3D kgd_gfx_v12_set_wave_launch_mode,
        .set_address_watch =3D kgd_gfx_v12_set_address_watch,
        .clear_address_watch =3D kgd_gfx_v12_clear_address_watch,
-       .hqd_sdma_get_doorbell =3D kgd_gfx_v12_hqd_sdma_get_doorbell
+       .hqd_sdma_get_doorbell =3D kgd_gfx_v12_hqd_sdma_get_doorbell,
+       .get_cu_occupancy =3D kgd_gfx_v12_get_cu_occupancy,
 };
--
2.51.1

