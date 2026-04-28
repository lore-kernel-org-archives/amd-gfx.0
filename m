Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F21FF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B749210EA08;
	Tue, 28 Apr 2026 03:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PH+G9Nt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA4110EA0E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFLH3AEDYJbYu3arI8MZxtF6yFAeVcEYb4d12GkUcgNrv/SO5UNheY/EL3nmjmJhY4+kkPYJ8PrxaSJAz44+l4rl86/81oRtxPaYSpIqHgB8dC2veG/p129ezJeOiG0awlgOSUwcRxvO+gCEVm2tyarCRZ+GUR7K67zkl8yBsmQd9ZW6PC88krhTf1TyvOtZLQbjWimUBZMTO4IzqmzOF9O9/UVrIGYFQzZpEohbY7VrBqbjbxocEGR9ftQujnLfDle6TzLMxThWQgPq409BG1UacSu6Hf1LDwo7llyouIv5qMRQxWLlVAAZv2ruzKjPwZdKeXyKxW1/i0irNkVIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FgdWJMcXbaS+vgWEaLEwtmZNkAVpTJVGhNdkpb2Ddo=;
 b=gSbajIf4WfPjGSScxHDGFFWtNglzGWHuOwma70bYxBLP/drCYIGlkF5kZx+v+xwSjNL89JCTwDP3RW7J2MroETLRmrWBCiCeqNdf303xjuH5Q9WTYUircrMdftMH9/Pp2YTtadAnsee0PI3SMwFKz8hFWzid2cu51HwkMvjkWxh1ul5TGN4No4R1WgfJdJ0zWbP+ydzGGgPyW/hfDNvucKS3Br+VyXxLCB+yUYdcZsa+7wGgTPQgh6TjTjwzg0GQ5SCrK4xo5OOn5reLP4x9SN3pOl4DKKj8NomIIeoN+7twXh9IMQZES3NPmbYxGaV2HXpDHWwTl+e7xOEBY34/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FgdWJMcXbaS+vgWEaLEwtmZNkAVpTJVGhNdkpb2Ddo=;
 b=2PH+G9NtRGEWkVh3FgH7aflvE3M1BTfvNJzDdOyNfOBmsY9ZarJadTWhUpwv70W1vVi2POziYMCbNed2aPxSTD06X/QbvP6DDSAlZSepf9zxWHpKqR0ZFYK2M/TI5sLoPEGIMiKkgExfksTaZEzYwd4/1OaWlpe5wqCpsoMqdZo=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:15:38 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:15:38 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 06/17] drm/amdgpu: add RLC SPM interface to
Thread-Topic: [PATCH v2 06/17] drm/amdgpu: add RLC SPM interface to
Thread-Index: AQHcu9QVkTrGhF5mRE+91GgwGb7KLrX0AsfQ
Date: Tue, 28 Apr 2026 03:15:38 +0000
Message-ID: <BY5PR12MB4179F32708E703797E6EA5D2FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-7-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-7-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:15:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: f03d256c-0d8e-41b1-e783-08dea4d46be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: taZroQCJU+S+uG3EEnLJHR+dRhE0SIDLIV5KsP3GwhPGwRshQWDpVrvj3hDZ10OslYvhd/x9lPOPmOTHXi4Co4Rr8MpMEtUunIGTJBcbxVb36HWwPuofDbLipdrxLrVaX2K9GO5E/92ced0E9xWuZBdrla9aItkbu3quROUVvm/wzsCJEN1csmPtZdAkZOMPzJpNExeqQo71UfWf1aTJPRWIxE3EpD21/6UJHmSxBF70msZsbNq+rFu7IdUh3/0tWmnvTqkrrP5IEWelbZH6/Je6BQwocYUsEgxFewnvYVj2GwBXvBkWFNsTSoPa3Kg7sWWF2c9pZj/gx/dEmNWSJ0dmm9ZnyUmrZB75DpW3IgD/CWwS/1hs1XQuA1M7qoaGJdlMH4BKy/ltOreTPYKugPlAwh1c54bm2hUVuW0HTIZL63wyeyDfvO8Sd9iGe2hh1I9DAm/503D9I/h+zxKWSPQayTlvaOMM+f2bPYBCAtBRRgvZzAUN3WJOcF5c/lOICxBIrUjvlMNLv+ITlowdJe0Rr8/S+g1z4eWNYtbqG92Rz1srZ+SvYqktq4Dy8rLwsD6ZPFLyfySf27BDLLtbaJGFOZk+z8J7KvoPeoTN9jyxuCBuHMyLbxk8q8bUf2MwRWNH8inUHhomkohEdV3ag1oNXOLRyP5NDzwGoHnV6NDAnr/KiQdlRNssHOgHy68N10W0TslM6MbqMvq2ntgMp7oA4BcKCgzPFVSNpT/omKN0rQGHPr9OKGZ63mzgowFhJwy7h3FHDGfIqEQ8qZOe7EN69CEoHJnW2vyM3EwFb+Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Q86YrURUHYAv0opN0npjZMt2WGBbak5/484GEyqVI3N8PuVSJ0WV1bvrEjX?=
 =?us-ascii?Q?/uDkeL3kCZfYVmOrcJVBScXR7ISrgOkfPojcBQlzxdnpnOWvcjeURnuxOnP0?=
 =?us-ascii?Q?1TcbjPc/rht18w8BM+tr9P7wJPEuj3IyCC6D0v7p2/9KCB8cFd8v7J14suh1?=
 =?us-ascii?Q?SPIxCupBQiyOOwg2UaI1tmGEnKzx/L8M4i24vCpvcTPOY6uKGfukom2LGBpp?=
 =?us-ascii?Q?tD9GNiqSHPpQ3vsVIQwosVi95leLf3CeObTvdQoo1yJSO///IAcRDW8dE9RJ?=
 =?us-ascii?Q?og7BiMlMZ2QL+IJQsZ5OimxRwPHHCDY3lGKYhBZGmlK6gvrjmwTagujleu2u?=
 =?us-ascii?Q?CQFS+4jaEpd8X3BDrOJOOF7SfUZlBJYdcFun6zVeBdxAlrypO3WbXYVxdswQ?=
 =?us-ascii?Q?IbuCrJjRLN2m4EyvKmEAvTsH3GHY6LnJgEjzs/WYCdTI54ztr1UHDu4Qk5Bc?=
 =?us-ascii?Q?l1tgga2v+h+efb4yW3N7t7UfUdkA7z7pIwTSkkG8VEuvUAv1U4p2Rbi26K0l?=
 =?us-ascii?Q?VMmdLV+1YNmYF8ODDUX++jZJZlhPQ5uyeJ3Q1h864lU5Ymh8DqEOv9PcTg+v?=
 =?us-ascii?Q?nF1uVNiLGvuIXqvCCNClp2pGpNVm0JyVihJmfMnI215Iqf4cqyWsaQ1FjUZ6?=
 =?us-ascii?Q?9Bm5Vgm4dYyBsldYuNKteVFdbqWJlI3emx3fVOFLRol0vcvqa+j9R/svjKQI?=
 =?us-ascii?Q?x7eRO1cFrhAn7NwKlRVB51W7L7d1eSNBEXVh1HaG1kH/UbRX0IC0ulSTaqsP?=
 =?us-ascii?Q?r1vW1u34UfegbVeTNq3GuXk6M+t3qvtOj3B7be8+N3IFkWZlsVNu6cuA/EzR?=
 =?us-ascii?Q?IxyX6+cKcOR2qovbzcWZycQVgHBvrDmKyJJQqviHAW+hYVKkVJDdo5J2USpp?=
 =?us-ascii?Q?hfOcb2h0ilQt556Yeqphz8FZ3o9kxZbTTFofCEOeO/2jo2Jd/x46jYrVeIx9?=
 =?us-ascii?Q?MeJoToMlg7xPCXUVMsGAOEpefP5a+kVRsSWq+6Y9FktrfZ1cisXNmuD/L8ky?=
 =?us-ascii?Q?Mf3ymhAXLgH9NcQDiedTOs1EpWqAYzhwJ6Y5QZGK0OaDnkr73eZdyc3qZyfB?=
 =?us-ascii?Q?TUDKv/o0wk5tZJLoDaLQyMqCDCvtjr03PFVwig7p6EixJAyhoE7wJ8T84lyT?=
 =?us-ascii?Q?wXUaWkFZbmrU6gQzhn+BjYuUblRepu4ZuTIpUysuPBV0TmgLcgXkrcH/TFzB?=
 =?us-ascii?Q?Usig55+vkZOcqA30oCQ3XIYjnrM9jV4SGYCZhlE6iv2JR8Mkf5MeUdECcHVW?=
 =?us-ascii?Q?KE3RnOwH+CTYTpZ1vbYQXzl3PYWYXL0PDzYOHELoJihDIP8CfQxL6o/ED+Ar?=
 =?us-ascii?Q?mnELqIANM8jogqicJ5b2dYWkahEZQJGgc8KnM+cBIxiqkiwd/aYzLGfbAP2a?=
 =?us-ascii?Q?Ed0DY8Wm1qs27HbWg/2Svj5r2Hi+5wX/DriFamYuetdy0towcwK8PZnWjEgV?=
 =?us-ascii?Q?kO/x5ov6XGRDw7NcgPqEhcUrkHT3UBjcsWiW24m1Nj3tmwlas81tNo0XDBdD?=
 =?us-ascii?Q?WxYVxH2SUmVAL6kS3yRsip24uP4hFWz589FX/sG/Sk+V61BzYRBJLdhuRoE5?=
 =?us-ascii?Q?maZpxHjmZGVdbsD+gbttfzeY3z3+VRC96uyxlYtym2nHsVuHZAVToGMGPQej?=
 =?us-ascii?Q?VouCU3ggIfBeeQVZDSByfaqcgGKrgeijN36s2kQ+goOakBtc9HD6GLfJJubi?=
 =?us-ascii?Q?i6I9q3bIdA16bJrrrYUlaPGvAU4TIUoBvtrm3+xFjxb4CUB6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d256c-0d8e-41b1-e783-08dea4d46be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:15:38.2675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymOPz/IldhCvo9fFvoVqV3JwdJZw4R7IUx1H6XknEKul5FBL232ENo2LXoH23JSJKi6o/1vcb+eqhkaU5Li/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 06/17] drm/amdgpu: add RLC SPM interface to

to introduce the hardware-agnostic RLC (Run List Controller) SPM interface =
layer that sits between the generic SPM manager and IP-specific register pr=
ogramming.

A new function table struct amdgpu_spm_funcs is added to amdgpu_gfx.h, with=
 the following callbacks to be implemented per IP version:
  - start(adev, xcc_id):   enable SPM hardware and interrupt
  - stop(adev, xcc_id):    disable SPM hardware and interrupt
  - set_rdptr(adev, xcc_id, rptr): update the SPM ring read pointer
  - set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size): configure
    the SPM ring buffer base address and size registers
  - set_spm_config_size: KIQ ring space (in DWORDs) needed per operation

A pointer to the active function table is stored in adev->gfx.spmfuncs.
All RLC SPM functions are no-ops when spmfuncs is NULL.

Five generic RLC SPM functions are implemented in amdgpu_rlc.c:
  amdgpu_rlc_spm_acquire(adev, xcc_id, vm, gpu_addr, size):
    Sets up SPM for a specific XCP instance. Allocates a reserved VMID
    on the GFX hub for the caller's VM, initializes the SPM VMID to 0x0
    (from the default 0xf), then programs the ring buffer base address
    and size via the KIQ ring. On failure, reverts the VMID to 0xf and
    frees the reserved VMID.

  amdgpu_rlc_spm_release(adev, xcc_id, vm):
    Stops the SPM stream via the KIQ ring, reverts the SPM VMID to 0xf,
    and frees the reserved VMID.

  amdgpu_rlc_spm_cntl(adev, xcc_id, cntl):
    Starts (cntl=3Dtrue) or stops (cntl=3Dfalse) the SPM hardware by
    dispatching start()/stop() through the KIQ ring under the KIQ
    ring_lock spinlock.

  amdgpu_rlc_spm_set_rdptr(adev, xcc_id, rptr):
    Advances the SPM ring read pointer via the KIQ ring, informing the
    hardware that the CPU has consumed data up to rptr.

  amdgpu_rlc_spm_interrupt(adev, xcc_id):
    SPM interrupt handler stub.

All KIQ ring operations are serialized under the per-XCC KIQ ring_lock spin=
lock.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++  drivers/gpu/drm/amd/amdg=
pu/amdgpu_rlc.c | 90 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/=
amdgpu_rlc.h |  6 ++
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..016eed89d6f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -164,6 +164,16 @@ struct amdgpu_kiq {
        void                    *mqd_backup;
 };

+struct amdgpu_spm_funcs {
+       void (*start)(struct amdgpu_device *adev, int xcc_id);
+       void (*stop)(struct amdgpu_device *adev, int xcc_id);
+       void (*set_rdptr)(struct amdgpu_device *adev, int xcc_id, u32 rptr)=
;
+       void (*set_spm_perfmon_ring_buf)(struct amdgpu_device *adev, int xc=
c_id,
+                               u64 gpu_rptr, u32 size);
+       /* Packet sizes */
+       int set_spm_config_size;
+};
+
 /*
  * GFX configurations
  */
@@ -418,6 +428,7 @@ struct amdgpu_gfx {
        struct amdgpu_mec_bitmap        mec_bitmap[AMDGPU_MAX_GC_INSTANCES]=
;
        struct amdgpu_kiq               kiq[AMDGPU_MAX_GC_INSTANCES];
        struct amdgpu_imu               imu;
+       const struct amdgpu_spm_funcs           *spmfuncs;
        bool                            rs64_enable; /* firmware format */
        const struct firmware           *me_fw; /* ME firmware */
        uint32_t                        me_fw_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 572a60e1b3cb..faf2a34df42f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -583,3 +583,93 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device=
 *adev,
                amdgpu_gfx_rlc_init_microcode_v2_5(adev);
        return 0;
 }
+
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool
+cntl) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       if (!adev->gfx.spmfuncs)
+               return;
+
+       spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+       amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size=
);
+       if (cntl)
+               adev->gfx.spmfuncs->start(adev, xcc_id);
+       else
+               adev->gfx.spmfuncs->stop(adev, xcc_id);
+       amdgpu_ring_commit(kiq_ring);
+       spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,
+u32 rptr) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       if (!adev->gfx.spmfuncs)
+               return;
+
+       spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+       amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size=
);
+       adev->gfx.spmfuncs->set_rdptr(adev, xcc_id, rptr);
+       amdgpu_ring_commit(kiq_ring);
+       spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+                       struct amdgpu_vm *vm, u64 gpu_addr, u32 size) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+       int r =3D 0;
+
+       if (!adev->gfx.spmfuncs ||
+               !adev->gfx.rlc.funcs->update_spm_vmid)
+               return -EINVAL;
+
+       r =3D amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+       if (r)
+               return r;
+
+       /* init spm vmid with 0x0 */
+       adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0);
+
+       /* set spm ring registers */
+       spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+       r =3D amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_confi=
g_size);
+       if (!r) {
+               adev->gfx.spmfuncs->set_spm_perfmon_ring_buf(adev, xcc_id, =
gpu_addr, size);
+               amdgpu_ring_commit(kiq_ring);
+       }
+       spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+
+       if (r) {
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0x=
f);
+               amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+       }
+       return r;
+}
+
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id,
+struct amdgpu_vm *vm) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       if (!adev->gfx.spmfuncs)
+               return;
+
+       /* stop spm stream and interrupt */
+       spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+       amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size=
);
+       adev->gfx.spmfuncs->stop(adev, xcc_id);
+       amdgpu_ring_commit(kiq_ring);
+       spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+
+       /* revert spm vmid with 0xf */
+       if (adev->gfx.rlc.funcs->update_spm_vmid) {
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0x=
f);
+               amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+       }
+}
+
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id) {
+       /* TODO: */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.h
index e535534237a1..c5da9e428c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -374,4 +374,10 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev); =
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
                                  uint16_t version_major,
                                  uint16_t version_minor);
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool
+cntl); int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+               struct amdgpu_vm *vm, u64 gpu_addr, u32 size); void
+amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct
+amdgpu_vm *vm); void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device
+*adev, int xcc_id, u32 rptr); void amdgpu_rlc_spm_interrupt(struct
+amdgpu_device *adev, int xcc_id);
 #endif
--
2.34.1

