Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D72606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LyRnzlh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC2310F2E9;
	Mon, 16 Nov 2026 16:31:07 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBE710F2E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmYO3V5s8p/FRK6lDjta3T+IVQXDgFbrJTaDQNtm8ei2uxUiCPNsrtO1wJwHhIWf5jrL6+IxWOB6g1Lw4MsoCnA6B9A9rmPuVg92xXX4Z/KKQ2dfJ/a2KWCuwssYZMMPY50YjunxbwrLs9YbDiBBFah+ug8Jd24Q2g8oy/EnzhtVnpcP5AZfk277qv+MLC4TCDlty8tWe4DVrRMRNykwAGFk8TsewiciU2UsnpJ2X+URUu/Mqlg5UtlEVZ/ZowOikfBD9PZ1w2XFKXYRHm03pirvawmKQT+LXuivqCNpX5rf+Hk8cbPhOmAJQZJre/BhJsX+JqgPoBhB/gqVQCj3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FJcXuUwYaTLzz60tt7CKwHLggjhUUbn5xH3lCmfjjw=;
 b=O+j2QHB6jxHPBdABIekPR47nERsrolM4P8Znp188S9664eQtmh34lKKuY4rMtRGFRrlGwkfnrQvMKq9irySZae789nPpVM1syMf3U2ozjGRwih4nhlEMJY6GrCJCi8UuFjYOBj0BtM3YXUpHyCR9fDRYB3DmSNd2E0Cdr3uLrAlwMOUlYjbhw0PKEIYGEKqSiiV/FEMYt3PLNbgqKGt3OnuZKrPZQB12bS5p+1NgS5+IM633v0GlbQyqfy1O/Dw2CwC6NMwHfSg1LUxV+1aomUEzYLPrDl6urnW05dCfdJAWL78ZGI8AS1X/XpcN5Y4KD4ptor3FRS5XzIkLGlYfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FJcXuUwYaTLzz60tt7CKwHLggjhUUbn5xH3lCmfjjw=;
 b=LyRnzlh/dtx+ynThPAxk1nBFnv5wT0sR+hjSS2I6buNknOWpfAMvGD0oqlVndtsuchZD7zX2B0vYdpC9EvkSrp7b1wLZDQiRd0aDG51vF8BgctUNnRutePLE4OV8ZX6OhjB2pX2OLR85cGLnRbf3wlUE8pX64dkMcjW1EZJokgI=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:30:56 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:30:56 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>
Subject: RE: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot
 with its buffer
Thread-Topic: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot
 with its buffer
Thread-Index: AQHdcRQZlGd1nFg4GEumHmwAiTsPZrcw31AA
Date: Mon, 16 Nov 2026 16:30:55 +0000
Message-ID: <CY3PR12MB96318D3A9D1D45BEA9A1F25CF47C2@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
 <20261110130440.474374-2-Prike.Liang@amd.com>
In-Reply-To: <20261110130440.474374-2-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T15:39:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: 46422156-3a29-4291-4f6f-08df43fefd35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: iX2vDdWqfJXY0bu4y9hMx+cStac1fpvcWRXyx6jHk3r/uFjDkeltpRIs1WCMXWU6Q41vK79BNyLNH+ljUqqGyuowiWBPf/dgTeh8Dw/pvYvMjnyIPRce406bvoc1InOxsp6xN7djRHhXmtNb3d0Uu6czA88utBdsv8tRwUmNPeJ+doSIpJByAJ40MCzt8SRND+76HCRf1dAuMdK4/S7MC2B5h5XUGGAJ7BedsXkSuexzouMr300G8RDKU858SN2wXTSZpa3dNMuAb4JpAf85NHCkbCURN8/4pn2GxPFF/7R/8mXij2iMCgD1+BEV0Wk5lk+hPlV7Ev836LBrJNuqo8ltVSYJIUIVyWCZz9hnBwsqy25O+OTUrlHjdfKftfGGsLpVUL6b/zxLGUbykZg2esNrcq+xvevrluT3KbF55uZlrcaMTP4oLJqaiElptEHsHSHt7hNT0iIcfSMh5eyqBIKgJcOAVuLFFWMbpyMyib+qS13luFAx8YRkJbLVLRQ+cDBeIdcEb9+GLoZLK1q254cSyR4W2tJjBxHTpN5M4CiA1V9tgTd6Dtge1aIGtaUssJLxcfbAt+boaZWK9wONHPZS1mKCuJy52uChppadkjnpFeVZslJ4r0cgAWwU//oBKLJK7AZqnfLlCy6vmPX2oGmtBXb9CQxn4Bh4MuqU9VoNFNWFc1Ji2KozdSf5wRjsQ+FodLHwg9xgosrpLZ6zlSviqq1oaM+acxpAXdNDPlw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fn2+Q8dZK5MtoxDjdwOMDtlH0lN32BzsOs5sxcUzP95BILIbK0YZt5aax6/D?=
 =?us-ascii?Q?LXmbACEmYKVR7gqjJRg+gZ7F5FGAn1Bkb/T+1Mt/US93HF/+xIVZ1qsXS8Xw?=
 =?us-ascii?Q?20oHVNZJ8P0nHfs5xT9YBgANWKllCy0eKVuASluGQK2xUFIoZZLAWoNx2gbd?=
 =?us-ascii?Q?qHoAkQZ+aHxXsxPtIU3bGBQJMg4oPzoPJtROrFn4//BpkVamGmFfNxtVvIWL?=
 =?us-ascii?Q?iTAztnfe7hxtuxA33WJ9l69WHD0qY0Qct3jX+wRc0vkpc+uDrGF3R3Zor9ME?=
 =?us-ascii?Q?NOV/8GBPHYtDmFLUUDOnT4mfMIcNbXM+SD/mUploVNnmoQWx80MBqsnIKO3x?=
 =?us-ascii?Q?iIKTIE4HnGCw/ZSpAAXvNsh1ni8RKMBvjsPeipaMEy4iGdf/WFzTC6xxicUz?=
 =?us-ascii?Q?+p929p9/dF0S0gEdQB42wpkGDbaxPg/wzKOb6i/3Uwy9mPWQpPH8GZ5VFDie?=
 =?us-ascii?Q?gAc3rT1UcgaenRzugkX8B46MYvjBXzFZcMGaCxsGy3S6oyOShj/Rq9wdb63f?=
 =?us-ascii?Q?CKl2wWPbyvbE56XLujEB9Nl4ukGg4gRUVdp5Ppnaj6qbdXFT68PXAzWjqBF7?=
 =?us-ascii?Q?63eFcdVR8fUqhPYcxeXlhpd/a3UW2BT/e0jnPN+Rc56ZCx0Qsrye8l9DrMH7?=
 =?us-ascii?Q?M4MLiM8LgI/2se8HMzjxlp5SkE1thD7DFm98AL/YrmpgA510L45X5e/5ROSK?=
 =?us-ascii?Q?TER+n9mJ494qGzSk3LL3+xkkC6icVoNl+a8mxfnP5uUNoHgt62eVvqw2HCbo?=
 =?us-ascii?Q?TlwobCaF/K8+wo1F8t7pCVz3ah+Xf1bfGqiLDKu2qSDSq6VMSudRPWSkddml?=
 =?us-ascii?Q?MBlqubT3XOxfCutkBV3iGXHLMgic27YFcb8AT2CRw2uaMD2bkmjU3jx22e6u?=
 =?us-ascii?Q?M6BGUnGiF0uCErORcsKJ49yNbsIrJwla1IxuEtcZcNSqTu+TtFsFLMTeKRGS?=
 =?us-ascii?Q?a9Q8BNejhLk6//lAkwyttFuzYYl+DTZDke0GtwdX7QT2sWi0x1Z6/3QnH/G/?=
 =?us-ascii?Q?9j4ku0njCGEBG1LsRCCofkXXE5mHMKbNGM8mBFEeMFCvgZ/KN33+f2gB4Dzd?=
 =?us-ascii?Q?9epVGc/Oebx2Bc7DobZmyZNlVcKd8qn1wMSA/yZJwcz+2ueRSN1qalMSeimG?=
 =?us-ascii?Q?8aHSeItsEj6bH5O1Mveh/C63fLDjdUIVr6HaMo1nfnAiCwStXQJCaVmHk3yP?=
 =?us-ascii?Q?39MasJJuhV2k3iof89EuL+g9kYE7M5DELsPlpTzWM00f+A2rERzpd71t/zaK?=
 =?us-ascii?Q?t0JCFvUaC1uTehDiqQb7Kfs8T0RUOoDDel4pYNXYc6WcZUCTCNIzuGNDuosm?=
 =?us-ascii?Q?VyLLQMdcsT4LKifxMb7LwQqW75eeBEWSkX5srHlACKwUHpeToX4LWs1VwJBP?=
 =?us-ascii?Q?gefvX9X1DogIefZS1vS/dHD1LUw46UJKVaow6+ewHAimBI8/Elc12CDhPTik?=
 =?us-ascii?Q?DPZcNt9Dnfad2my+53nBSU11FI1I6dK9icyqy/GkokuB43/fbpoiCIhp0zcg?=
 =?us-ascii?Q?R+2MKIMNfi7fVsjEZQJ5y+dtS0fgYQQwWWDfJAAhuxjpbKNjwzu/AoMsol+M?=
 =?us-ascii?Q?o97+kd2uxGOuncBZlttOWZ3Dv7ttgsiaLu5jixLaHlosW4FdqflKPJWwmAU/?=
 =?us-ascii?Q?EOY9cTgRD1TPOr2IW5nIwPPWXrnyjQAUTBPfwElRHM8+ewrZwYWqSfEhmTDp?=
 =?us-ascii?Q?Pqnkt+d+j67ZJI8YoFNBsXbaS6Ykm8SDcdSZF1RJVyoz+rjU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46422156-3a29-4291-4f6f-08df43fefd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 16:30:55.8599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w22Yxvk3eX1vR+USmcwePKHUSIfE9Nm7Qt5m2tQK1cAJ9SGj4qzx081HgT5VYXujs5pOQuep20jsXofqk4lbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

You can add me as acked . The code changes looks ok to me , but  I'm not su=
re whether the behavior will be changed since according to your description=
 original driver always use slot 0 , now it has its own  slot for each proc=
ess . Not sure whether it's matter .

Regards
Shaoyun.liu

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, November 10, 2026 8:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH 2/6] drm/amdkfd: allocate the MES process context slot with=
 its buffer

In MES RS64 mode, pqm_create_queue() allocates a process context slot right=
 after the process context buffer, but only on the path where it allocates =
the buffer itself:
 - kfd_dbg_set_mes_debug_mode() allocates the buffer as well, without a
   slot. A process that a debugger attaches to before it creates its
   first queue therefore never gets a slot: its queues use slot 0, and
   it frees slot 0 when it exits, while another process may hold it.
 - If no slot is available, the buffer is kept without a slot, and the
   process's later queues use slot 0 the same way.

Allocate the buffer and the slot together in one helper that both paths use=
, and free the buffer again if no slot is available.

Fixes: e32b68c6b135 ("drm/amdkfd: enable rs64mem for kfd queue")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 35 +++++++++++++++++++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 26 ++------------
 4 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c
index cb830f985536..d5c87de519ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -350,27 +350,14 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_dev=
ice *pdd, bool sq_trap_en)  {
        uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd->spi_dbg_laun=
ch_mode;
        uint32_t flags =3D pdd->process->dbg_flags;
-       struct amdgpu_device *adev =3D pdd->dev->adev;
        int r;

        if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
                return 0;

-       if (!pdd->proc_ctx_cpu_ptr) {
-               r =3D amdgpu_amdkfd_alloc_kernel_mem(adev,
-                       AMDGPU_MES_PROC_CTX_SIZE,
-                       AMDGPU_GEM_DOMAIN_GTT,
-                       &pdd->proc_ctx_bo,
-                       &pdd->proc_ctx_gpu_addr,
-                       &pdd->proc_ctx_cpu_ptr,
-                       false);
-               if (r) {
-                       dev_err(adev->dev,
-                       "failed to allocate process context bo\n");
-                       return r;
-               }
-               memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-       }
+       r =3D kfd_process_device_alloc_proc_ctx(pdd);
+       if (r)
+               return r;

        return amdgpu_mes_set_shader_debugger(pdd->dev->adev,
                                        pdd->proc_ctx_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 158fa70a1a8e..0a4e8639c4b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1140,6 +1140,7 @@ struct kfd_process_device *kfd_process_device_data_by=
_id(struct kfd_process *pro

 int kfd_process_get_user_gpu_id(struct kfd_process *p, uint32_t actual_gpu=
_id);

+int kfd_process_device_alloc_proc_ctx(struct kfd_process_device *pdd);
 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
                               struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev=
, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
index 546721b4d59a..102fcb401646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1204,6 +1204,41 @@ static void kfd_process_profiler_release(struct kfd_=
process *p, struct kfd_proce
        up_read(&adev->reset_domain->sem);
 }

+/* Allocate the MES process context and, in RS64 mode, its slot
+together. */ int kfd_process_device_alloc_proc_ctx(struct
+kfd_process_device *pdd) {
+       struct amdgpu_device *adev =3D pdd->dev->adev;
+       int r;
+
+       if (pdd->proc_ctx_cpu_ptr)
+               return 0;
+
+       r =3D amdgpu_amdkfd_alloc_kernel_mem(adev, AMDGPU_MES_PROC_CTX_SIZE=
,
+                                          AMDGPU_GEM_DOMAIN_GTT,
+                                          &pdd->proc_ctx_bo,
+                                          &pdd->proc_ctx_gpu_addr,
+                                          &pdd->proc_ctx_cpu_ptr, false);
+       if (r) {
+               dev_err(adev->dev, "failed to allocate process context bo\n=
");
+               return r;
+       }
+       memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+
+       if (!adev->mes.use_rs64mem)
+               return 0;
+
+       r =3D amdgpu_mes_alloc_proc_ctx_index(&adev->mes,
+                                           &pdd->proc_ctx_array_index);
+       if (r) {
+               dev_err(adev->dev, "failed to allocate process context inde=
x\n");
+               amdgpu_amdkfd_free_kernel_mem(adev, &pdd->proc_ctx_bo);
+               pdd->proc_ctx_gpu_addr =3D 0;
+               pdd->proc_ctx_cpu_ptr =3D NULL;
+       }
+
+       return r;
+}
+
 static void kfd_process_destroy_pdds(struct kfd_process *p)  {
        int i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d3149e6d40e4..4646dfbabe75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -387,30 +387,10 @@ int pqm_create_queue(struct process_queue_manager *pq=
m,
                dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);

        /* Allocate proc_ctx_bo only if MES is enabled and this is the firs=
t queue */
-       if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes=
) {
-               retval =3D amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
-                                                    AMDGPU_MES_PROC_CTX_SI=
ZE,
-                                                    AMDGPU_GEM_DOMAIN_GTT,
-                                                    &pdd->proc_ctx_bo,
-                                                    &pdd->proc_ctx_gpu_add=
r,
-                                                    &pdd->proc_ctx_cpu_ptr=
,
-                                                    false);
-               if (retval) {
-                       dev_err(dev->adev->dev, "failed to allocate process=
 context bo\n");
+       if (dev->kfd->shared_resources.enable_mes) {
+               retval =3D kfd_process_device_alloc_proc_ctx(pdd);
+               if (retval)
                        goto err_allocate_pqn;
-               }
-               memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-               /* Bind one MES process context slot to the whole process
-                * (per device); every queue of this process reuses it.
-                */
-               if (dev->adev->mes.use_rs64mem) {
-                       retval =3D amdgpu_mes_alloc_proc_ctx_index(&dev->ad=
ev->mes,
-                                               &pdd->proc_ctx_array_index)=
;
-                       if (retval) {
-                               dev_err(dev->adev->dev, "failed to allocate=
 process context index\n");
-                               goto err_allocate_pqn;
-                       }
-               }
        }

        pqn =3D kzalloc_obj(*pqn);
--
2.34.1

