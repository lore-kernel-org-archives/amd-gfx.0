Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C458ECF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 19:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2F10E15C;
	Thu, 19 Sep 2024 19:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A178NIt0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C122610E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 19:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLEKvLnHdPddNRE60Gte/anB1sra6dQyeHnyYMtQiw4j2h/tutVjiuAbRm4pcMZ1d4FCQUfzV61CtdT5dJeEJ60Gz9bnKO0ouEtantQPdaGbzat4nDMZfb3Kq2aSZDuGkbHEVZ8caqGT/du+BQwdCjryre/OSAfpf2b8k6BQjc8YVhn7oddd5e2RxvoDEKTzCcn7m4drVzHlp5OGw/wX4yAR/SFFD6QfzW7RU0Nkb2hh9rb2luqIl33ctqJ7DovJU/eSWBgc0feVe7Lr+j98wmLL5GOAZRFSClz2gbdW9/FMoJJdKpoQfyEsDIzr0nemBMy+ubB+jtV/NKVkfk5XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQvxbAXL8L+jdpuRoWe/bNbzJ8yPXokjrpZgelHCOSc=;
 b=oGVyD6qQJf/b4t6rQTV8lWljlE+dqtCmwf3xL37CPmNYiYJH9xl+CIfbuEGzrDx8y7TAbsa0x6dxwlNrqcjPlbjyPNkDK8hq41wKXZ+65F8Do8q09p0/6lEzPMEUvRFxy37lgrpHaV8wa5ST4Wfl8qiBvGizHvyFYsCyVyVZNWF+xRSg2uBh9VqdyVCgf8r+QDvaFaODDo8QD9n5m0r9LhZwTpB3b83ow9sgdzXdeWgzPY9S2SU0VtiTnlL8I2rbvpOy4euLv1xbLrrhDI7OwZ84GqhdKTMfbSLOWcsVfM76iZDJqucZRSbZ0IFsD9yYGym+RX5ceWzbsw2lEgiXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQvxbAXL8L+jdpuRoWe/bNbzJ8yPXokjrpZgelHCOSc=;
 b=A178NIt0d7xD9Cgrw5GXNL2JiWunnzaL89gtGLrY2qKvRV4TMDbQMJ+Zhukagtqwi0eZsNme2NOWoJOtb3XGmay+I5i0ldzY8GTMFu/cJoMUL3y5hvvt/Zx99cGlNtHhZ8x25czlRhi0vggJDwVStgB4XQ+UHZZoAhCuVEUsOzg=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 19:56:10 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%7]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 19:56:09 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
Thread-Topic: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3
Thread-Index: AQHbCruBDU5VovR4BkOUkUJmLzB97bJff8nQ
Date: Thu, 19 Sep 2024 19:56:09 +0000
Message-ID: <CY8PR12MB70994C6CF136F1F1EADAA3018C632@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240919174326.4587-1-mukul.joshi@amd.com>
In-Reply-To: <20240919174326.4587-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=45ccd442-91d2-4266-8ed0-2624687e17c9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-19T19:32:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|PH7PR12MB6394:EE_
x-ms-office365-filtering-correlation-id: 90a9238c-ec05-406b-49de-08dcd8e51b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?w6NblNl9m1nAEXRtaiP/hnwi65Q23EUdRgnDhECBfmMLNS+Zwplb4hBOTfhv?=
 =?us-ascii?Q?lVMV280frF7f7BiNrSDC3RFX6vlXlwhtNw5kOdXnxGu0IF2AHa9o4F7pcShU?=
 =?us-ascii?Q?wWJKlT0dZjMkIDVq+HP3A7wGgRER54QEyIhuIPz+rlFlyo8kh0EHAfKx+eOv?=
 =?us-ascii?Q?Xdob/lkaYzcwzkl6OkbSyyTZaKBIUMC/tXSx6/9O3FV90lrp4aV1l4bFDSHK?=
 =?us-ascii?Q?s0iNFr/I1s3wcJPZZu09dzLRe7l72y4x0McuC+WVRiceuGVIWRkWgxJ7dXPv?=
 =?us-ascii?Q?H49FrNJYh118l1zEIJixklWtHCsG3wpgRHQnwnu9mkFHMSByN4kpbtJN1TmX?=
 =?us-ascii?Q?gB23ZwmgF38gZp65LsREr22DCG3RYTYIcXO/HuYdp/9sDAFBNBKurQdp7btI?=
 =?us-ascii?Q?S4MF+t+hZDS6Q8QTaaDK3nt4GBW0suGSYM3ytz3QALqdT8C5K/WW0BP7F6tw?=
 =?us-ascii?Q?at/FEjMrmvEn5rIGwMGU8PYj/uTCZz0EUZ+SeK7p8PbQ52XXwVzb8Z/TuTBA?=
 =?us-ascii?Q?cSb2Q1LoK8I/lkvhUB5r2XlZxAxdUUU70l28UKoFAtXzyWocoB7GavMt2bmq?=
 =?us-ascii?Q?ou5z7E1j4DW3FqrrFHhaJLa8fB84LSynVfkvjsqhvEn/4kGSOPcj7pbXTUfS?=
 =?us-ascii?Q?vN8JxamaFy695E/mbMpdWSa2MHonbz64DVhjW6efj5YeodSjZbANiDpuDqZQ?=
 =?us-ascii?Q?tv3Au6/Jw0zMdYOBmjgkpWHfzucD14ujzJN1eD2VmYcjfAStLdF0j0l0WeDO?=
 =?us-ascii?Q?UYxpzvmyXIWMrpRSyVCR1X/4vj2AWhgeWcMEsGXh8Uq2EYMWLZiEQD/ZKnWs?=
 =?us-ascii?Q?Wxl//eN3IS3fOw+t3sdNsjyEQZB0kvvU+WWBEr1W4MiuV1OX4tKrujsApBC9?=
 =?us-ascii?Q?koE3eehSJcv7W4S4Uv57LTuFLUGfIS1Lr6r5Rum5alLuGhtwHBPTOMpWF4h6?=
 =?us-ascii?Q?5uym0dDWgoCciyWvJFbKJZTlPUQQ0AhwbcwxS9Fko800qXH/YNb/Hzihl5MW?=
 =?us-ascii?Q?C0x+mp5k6SvXn25qr+HunljL65B+/YfiiJGaeUtniPrg0UkWBbK6epwZZaBS?=
 =?us-ascii?Q?XhKSPB5LUUEIERinS1DaAS2AXdYe4HjmBvZp0vcsydvd1KMlg7RKfX12fz6l?=
 =?us-ascii?Q?e3Hc5ct8RrTL/2jwN4zBtVIa6xdFnbR6ueWQpao5DKnX/DUviz9PtR35EKox?=
 =?us-ascii?Q?NLTAEy03cgQ3ExuVXqFwdeU9o5iGYf0cPhlr30onpx2ZAkNBE4JWRNV7tzE2?=
 =?us-ascii?Q?ENycUVQZiNFgh2tnLB3n3TbjJ6/0jaNosdBWkI2NCv4AqNopn2E/pH9l6YQf?=
 =?us-ascii?Q?nHPfTvThVOus3moO4SqabC7Ri5nVYlXGLMgEZZ3mgykyBY/t4QzDxlmnJku5?=
 =?us-ascii?Q?RnJuEdMjEnDke0ktozkawToHBRuq3Ff3jPmafXep0aE3K3H65Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UU+1/3lamfdFcuLSIUviJjgchnl3pZ/UIjdGA3HvawfxXWst0yqQ6FcRG2b4?=
 =?us-ascii?Q?jvIKjAIju/0YNZVbr3VYNmRopraZAvuPDWfVgV2WWECG5jQyGmXUliBNZcTO?=
 =?us-ascii?Q?9vwIdzRFt4r9WFdmbQPr31dEub26fdipzgUx5Jlv51XF0OhDAB+J2jOY/iWp?=
 =?us-ascii?Q?k5mC23s6CjPjekA6lJBV8KDLNseI6GurMIRNs7fVuQXy2aHvkWLwuuWyQpe7?=
 =?us-ascii?Q?+bk7qUFYoCvdH/BRAfFwG5eZscxL0nkLzSJx4iSGwX4ApyP7UvDT46B6WrbI?=
 =?us-ascii?Q?q/RCGzvDJAsy2/ZjFx2i1S9sL3d6wD3MbVL5A9XlI8QSfi/CDzlw7LtpCkU6?=
 =?us-ascii?Q?tbcU53KhpZi/oteGDGnGdhqvQrpWe6nX+roqOjGPqQ+1yw55kqi7HqjL91No?=
 =?us-ascii?Q?5pTcWqqaqdBtf47auncnyuj6Srpw056p7KBrbpE909albVdJ6dsf8A8Pxhiy?=
 =?us-ascii?Q?mY+aGQSMamimy19ovhKlwcN7cUV5ihvoAT1uip1+MR/5LjvG47LFAhtHpRY8?=
 =?us-ascii?Q?jUh8puFN+vojqK6IbcxPwIlXSrabM4ZQZn60z3OfjXj4GP3bSGCxyBhw6peQ?=
 =?us-ascii?Q?cev0nFvcjRrJAKoIxYLzHtoqGLyw8HndlO9fSmhG3ugC2/hYemPlv922rBcS?=
 =?us-ascii?Q?rqvA9SaP6ye7dRjnezjh+EeuMVWS/pE7Vwxlu3snf06ktRG1QgrtbHd/poeF?=
 =?us-ascii?Q?Jogh7zfLW0m8P3hHWtXxv+274ZW0zKBi1LURqYnIOwpntJPf/pX/RbVoFaFq?=
 =?us-ascii?Q?h62DqcJ475RQTpdIngxvU8M6FNDZpP59OPw4VPGog+hVgLGCtk1oigMp0xfP?=
 =?us-ascii?Q?rgVTL2eYPPSsIGK8oZiIzLfOzzGhUMda+86eeAoOntEpP1wabPuFx7+SbfBe?=
 =?us-ascii?Q?XzB9XwZp8NaIw3AnJ4bE3aZP0j9CV9q9G6d2d6aJob4C6K+2SPmHBERQzerb?=
 =?us-ascii?Q?mXj6tY7jBEUOhyhvIdIHE1EJT+ztZOkgzaPX76rNH5VnljV2bUbMavAea114?=
 =?us-ascii?Q?l7YhRtoHf0qeKxG3sdONFvyliT5XWJS9YOY77/Uj3nyetvbUD0iZ6FkLpJ+v?=
 =?us-ascii?Q?c7uBP6hhTrfDjF0voBJCK/ZJas7UUBjcH/3gBKeHkUvquJ1e1E9G+gHANRp3?=
 =?us-ascii?Q?IkxJ3YqqaxaYHMCPk+0gVmkaJbicc3MUAY1/rrGTNhmqDuC4lfPZj5Od/k7W?=
 =?us-ascii?Q?yhVZPyClXdLl+DpjGszxM0PeIR82tQS9fm6kuBvh6LrNk0rr/HzO3pkpfQBj?=
 =?us-ascii?Q?YCmdvWQdyCn6a+xAFCCE9QaSHwMbDd75iwy5X/TovHdY3bGXufwb1o0v1m7e?=
 =?us-ascii?Q?/wbZetN8aVMy9l56EzBKgiU92v9Ug6BZFMbhC15XqENc0kRzuJuWZG/NVZdI?=
 =?us-ascii?Q?ZrDaCK6EHt5i2/bXM43CkH/SDzSWRKpYUk/CJG+3piitKDEHdULLzmvE7aAh?=
 =?us-ascii?Q?o7oUgPrkQdudZiBtgX/AsDU/VzvDnaVGDsO6nkJFPTRkUj3k5cqnnwR/6oOz?=
 =?us-ascii?Q?ZHO5cGEqpntTdnOEfIbFH9nfcx+r00dVZruu9tup3GlxBetZt/J1b2SPDmVj?=
 =?us-ascii?Q?zv31E2mAgEEoTX8tX+A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9238c-ec05-406b-49de-08dcd8e51b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 19:56:09.7604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLuB9Z2g/qXTQ2y9tIaU2/sTsPESTG+hB/75d0RGgaEtIHsisNSXjdSqXZWqPro+dUVKjbSRWBV+B2nzWY8CYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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

[AMD Official Use Only - AMD Internal Distribution Only]

This looks like a more robust way to get this information. Few comments inl=
ine.

- It might be better to break this into two commits. One specific to 9.4.3 =
and other to use doorbell instead of LUT register. The second change affect=
s all gfx9 ASICs.

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Thursday, September 19, 2024 1:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Joshi, Mukul =
<Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Fix CU occupancy calculations for GFX 9.4.3

Make CU occupancy work on GFX 9.4.3 by updating the code
to handle multiple XCCs correctly. Additionally, update
the algorithm to calculate CU occupancy by matching
dorrbell offset of the queue against the process's queues,
instead of using the IH_VMID_X_LUT registers since that can
be racy with CP updating the VMID-PASID mapping.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 92 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 +++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 10 +-
 6 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 1254a43ec96b..b8c01257b101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -950,28 +950,30 @@ static void unlock_spi_csq_mutexes(struct amdgpu_devi=
ce *adev)
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-               int *wave_cnt, int *vmid, uint32_t inst)
+               struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
 {
        int pipe_idx;
        int queue_slot;
        unsigned int reg_val;
-
+       unsigned int wave_cnt;
        /*
         * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
         * parameters to read out waves in flight. Get VMID if there are
         * non-zero waves in flight.
         */
-       *vmid =3D 0xFF;
-       *wave_cnt =3D 0;
        pipe_idx =3D queue_idx / adev->gfx.mec.num_queue_per_pipe;
        queue_slot =3D queue_idx % adev->gfx.mec.num_queue_per_pipe;
-       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, inst);
-       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, inst, mmSPI_CS=
Q_WF_ACTIVE_COUNT_0) +
-                        queue_slot);
-       *wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
-       if (*wave_cnt !=3D 0)
-               *vmid =3D (RREG32_SOC15(GC, inst, mmCP_HQD_VMID) &
-                        CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIF=
T;
+       soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0, GET_INST(GC, in=
st));
+       reg_val =3D RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, GET_INST(GC, i=
nst),
+                                 mmSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot=
);
+       wave_cnt =3D reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+       if (wave_cnt !=3D 0) {

Why is it queue_cnt->wave_cnt accumulating instead of direct assignment. Th=
ere is some inefficiency here. The code is iterating over all queues two ti=
mes once in kfd_get_cu_occupancy and once more in kgd_gfx_v9_get_cu_occupan=
cy(). Is that strictly required?


+               queue_cnt->wave_cnt +=3D wave_cnt;
+               queue_cnt->doorbell_off =3D
+                       (RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_D=
OORBELL_CONTROL) &
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) =
>>
+                        CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT=
;
+       }
 }

 /**
@@ -1021,24 +1023,19 @@ static void get_wave_count(struct amdgpu_device *ad=
ev, int queue_idx,
  *
  *  Reading registers referenced above involves programming GRBM appropria=
tely
  */
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst)
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst)
 {
        int qidx;
-       int vmid;
        int se_idx;
-       int sh_idx;
        int se_cnt;
-       int sh_cnt;
-       int wave_cnt;
        int queue_map;
-       int pasid_tmp;
        int max_queue_cnt;
-       int vmid_wave_cnt =3D 0;
        DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);

        lock_spi_csq_mutexes(adev);
-       soc15_grbm_select(adev, 1, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 1, 0, 0, 0, GET_INST(GC, inst));

        /*
         * Iterate through the shader engines and arrays of the device
@@ -1048,51 +1045,38 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_devi=
ce *adev, int pasid,
                          AMDGPU_MAX_QUEUES);
        max_queue_cnt =3D adev->gfx.mec.num_pipe_per_mec *
                        adev->gfx.mec.num_queue_per_pipe;
-       sh_cnt =3D adev->gfx.config.max_sh_per_se;
        se_cnt =3D adev->gfx.config.max_shader_engines;
        for (se_idx =3D 0; se_idx < se_cnt; se_idx++) {
-               for (sh_idx =3D 0; sh_idx < sh_cnt; sh_idx++) {
+               amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+               queue_map =3D RREG32_SOC15(GC, GET_INST(GC, inst), mmSPI_CS=
Q_WF_ACTIVE_STATUS);
+
+               /*
+                * Assumption: queue map encodes following schema: four
+                * pipes per each micro-engine, with each pipe mapping
+                * eight queues. This schema is true for GFX9 devices
+                * and must be verified for newer device families
+                */
+               for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
+                       /* Skip qeueus that are not associated with
+                        * compute functions
+                        */
+                       if (!test_bit(qidx, cp_queue_bitmap))
+                               continue;

-                       amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xfff=
fffff, inst);
-                       queue_map =3D RREG32_SOC15(GC, inst, mmSPI_CSQ_WF_A=
CTIVE_STATUS);
+                       if (!(queue_map & (1 << qidx)))
+                               continue;

-                       /*
-                        * Assumption: queue map encodes following schema: =
four
-                        * pipes per each micro-engine, with each pipe mapp=
ing
-                        * eight queues. This schema is true for GFX9 devic=
es
-                        * and must be verified for newer device families
-                        */
-                       for (qidx =3D 0; qidx < max_queue_cnt; qidx++) {
-
-                               /* Skip qeueus that are not associated with
-                                * compute functions
-                                */
-                               if (!test_bit(qidx, cp_queue_bitmap))
-                                       continue;
-
-                               if (!(queue_map & (1 << qidx)))
-                                       continue;
-
-                               /* Get number of waves in flight and aggreg=
ate them */
-                               get_wave_count(adev, qidx, &wave_cnt, &vmid=
,
-                                               inst);
-                               if (wave_cnt !=3D 0) {
-                                       pasid_tmp =3D
-                                         RREG32(SOC15_REG_OFFSET(OSSSYS, i=
nst,
-                                                mmIH_VMID_0_LUT) + vmid);
-                                       if (pasid_tmp =3D=3D pasid)
-                                               vmid_wave_cnt +=3D wave_cnt=
;
-                               }
-                       }
+                       /* Get number of waves in flight and aggregate them=
 */
+                       get_wave_count(adev, qidx, &cu_occupancy[qidx],
+                                       inst);
                }
        }

        amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, i=
nst);
-       soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
        unlock_spi_csq_mutexes(adev);

        /* Update the output parameters and return */
-       *pasid_wave_cnt =3D vmid_wave_cnt;
        *max_waves_per_cu =3D adev->gfx.cu_info.simd_per_cu *
                                adev->gfx.cu_info.max_waves_per_simd;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 988c50ac3be0..b6a91a552aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -52,8 +52,9 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct am=
dgpu_device *adev,
                                        uint8_t vmid, uint16_t *p_pasid);
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
                        uint32_t vmid, uint64_t page_table_base);
-void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
-               int *pasid_wave_cnt, int *max_waves_per_cu, uint32_t inst);
+void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
                uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
                uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b465f8d83e..784d155d8bcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3540,6 +3540,26 @@ int debug_refresh_runlist(struct device_queue_manage=
r *dqm)
        return debug_map_and_unlock(dqm);
 }

+bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager *dqm,
+                                       struct qcm_process_device *qpd,
+                                       int doorbell_off)
+{
+       struct queue *q;
+       bool r =3D false;
+
+       dqm_lock(dqm);
+
+       list_for_each_entry(q, &qpd->queues_list, list) {
+               if (q->properties.doorbell_off =3D=3D doorbell_off) {
+                       r =3D true;
+                       goto out;
+               }
+       }
+
+out:
+       dqm_unlock(dqm);
+       return r;
+}
 #if defined(CONFIG_DEBUG_FS)

 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 08b40826ad1e..e5951589e5bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -324,6 +324,9 @@ void set_queue_snapshot_entry(struct queue *q,
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
+bool kfd_dqm_find_queue_by_doorbell_off(struct device_queue_manager *dqm,
+                                       struct qcm_process_device *qpd,
+                                       int doorbell_off);

 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *=
pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index a902950cc060..6720bd30517b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,10 @@ static int kfd_get_cu_occupancy(struct attribute *attr=
, char *buffer)
        struct kfd_node *dev =3D NULL;
        struct kfd_process *proc =3D NULL;
        struct kfd_process_device *pdd =3D NULL;
+       int i;
+       struct kfd_cu_occupancy cu_occupancy[AMDGPU_MAX_QUEUES];
+

You can just use sizeof(cu_occupancy) as it is an array

+       memset(cu_occupancy, 0x0, sizeof(struct kfd_cu_occupancy) * AMDGPU_=
MAX_QUEUES);



        pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occup=
ancy);
        dev =3D pdd->dev;
@@ -287,9 +291,19 @@ static int kfd_get_cu_occupancy(struct attribute *attr=
, char *buffer)
        /* Collect wave count from device if it supports */
        wave_cnt =3D 0;
        max_waves_per_cu =3D 0;
-       dev->kfd2kgd->get_cu_occupancy(dev->adev, proc->pasid, &wave_cnt,
-                       &max_waves_per_cu, 0);


A comment as to why you are using only the first xcc_mask will be helpful.

+       dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
+                       &max_waves_per_cu, ffs(dev->xcc_mask) - 1);
+
+       for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
+               if (cu_occupancy[i].wave_cnt !=3D 0 &&
+                   kfd_dqm_find_queue_by_doorbell_off(dev->dqm, &pdd->qpd,
+                                               cu_occupancy[i].doorbell_of=
f))
+                       wave_cnt +=3D cu_occupancy[i].wave_cnt;
+       }
+
+       /* Update wave_cnt for the number of XCCs in the partition */
+       wave_cnt *=3D NUM_XCC(dev->xcc_mask);
        /* Translate wave count to number of compute units */
        cu_cnt =3D (wave_cnt + (max_waves_per_cu - 1)) / max_waves_per_cu;
        return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index 7744ca3ef4b1..e3e635a31b8a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -71,6 +71,11 @@ enum kgd_memory_pool {
        KGD_POOL_FRAMEBUFFER =3D 3,
 };

+struct kfd_cu_occupancy {
+       u32 wave_cnt;
+       u32 doorbell_off;
+};
+
 /**
  * enum kfd_sched_policy
  *
@@ -313,8 +318,9 @@ struct kfd2kgd_calls {
                        uint32_t grace_period,
                        uint32_t *reg_offset,
                        uint32_t *reg_data);
-       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
-                       int *wave_cnt, int *max_waves_per_cu, uint32_t inst=
);
+       void (*get_cu_occupancy)(struct amdgpu_device *adev,
+                                struct kfd_cu_occupancy *cu_occupancy,
+                                int *max_waves_per_cu, uint32_t inst);
        void (*program_trap_handler_settings)(struct amdgpu_device *adev,
                        uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr=
,
                        uint32_t inst);
--
2.35.1

