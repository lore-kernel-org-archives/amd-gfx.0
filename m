Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5717AC5516D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 20:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67B110E0EC;
	Thu, 30 Jul 2026 20:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZxIhOXg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC3E10E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 20:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twGDxXsVRL+tOh2W5GO8UtGsRRTWGMthc7uP5fOxtvO4A99mAMdlpDIokOeRsMx+aaes41xdP9pqCmWQZaRO/BWncEquhJ5RK03vffEYEio2f75AbdSxIW9rBEiajA1cV1AmAYINBPQT+/QltvNfuc3viqnJfch/xGhXS/LvDHDeZw9CpqAULiwz/KtDukRBo5BNgWLMAfbtUq2qzVEyEd1KyxyNJGRYW7UtCOmxEQzD4+EuMde6Pbg1DhqJvQmCtNLH15gaEe/gVlDXqRCACOCKg4c+gOB0u5Iqigs8GKWSo9lTAzYY+v7iPo32Bg9F5CvFn16PupsrPVa05C1SjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9evIXwDw2TalEKwXLU5XGuX8Bk3Jdi+QmgcZ5xtbTQ=;
 b=ZeoWxLyTmSW5xIlRFcqTEhHpc0WF4CHHs4BPwt/kga5SRW39PKBpLNAyTEQjKRoCxeJkaSl4GMZgwhEfFkuoGmnteMNZqf0U11kJ5/qxQDxYtM5tGrzM3x/08qXcLbyKRJI7M4rx4DhvAij4aSjseiiX3PttUqpJOCb861yajlpoVK0GCa7Gf0nFmR/E29UwLYrYL3N7cmk1BgcBKCfHKyaZNIe/+LOJJPSUv16SQWL9l8HGBNS6cqNG4Tk3tW6Om+Ci623E5bU/u6AmCTDane4A0C4vBeuxy7qJQJ1aqIP5V2LT2MrajmtlEfFZAuP0xtcvhkWMvggvgazGXjsyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9evIXwDw2TalEKwXLU5XGuX8Bk3Jdi+QmgcZ5xtbTQ=;
 b=fZxIhOXgainCBK06ldG5MgzqSyczdfVdyaTZ1ktiauKml9zwUvTIid1s1jur8tK2jvmF7r9LRXwGYdiXSiXsSC0Ej9rIG0xTooPJc1/Ob0A0WTJe7Xx7Rvv4KlGCsbBSKTP7/7HXziDqkXhuyKGqqChkd/F2+Lj4niYwIJMPo8M=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:33:05 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 20:33:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add JPEG v5.0.2 SRIOV code path
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add JPEG v5.0.2 SRIOV code path
Thread-Index: AQHdIGHnzuO8VQBMVEGFII0E1f/DXraGhFvw
Date: Thu, 30 Jul 2026 20:33:04 +0000
Message-ID: <BN9PR12MB5146B6FB172724965076364DF7C92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260730202731.265870-1-Bokun.Zhang@amd.com>
In-Reply-To: <20260730202731.265870-1-Bokun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-30T20:32:38.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|PH7PR12MB7427:EE_
x-ms-office365-filtering-correlation-id: 805c4ed3-32be-4cab-5c8d-08deee79c1ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: nPnll8fuKpinvMwFKNHBXDvHLw5P3WfK+J+PpNdC0hKxCIpqowl4MGBUIAjexKQAVQzIf658xyHYRJrI0RcmrWcRBGJQGqMWnkE7gPReqOLo+LdWAeG4eLEpzRyPX8clKoZO1TFEuF0O3tuDKaaSQVrRW9yYlmMcIrP9lXHfsqjZc2P4LQNNVllowH27pXzRd0RX6YsWEefJ+uuiBJvRbW4EsMaS5Lb2SVwEoQOh+IlsZFEkIt0mOZj3a0GuUypj2Y0iBK8pDryYmYcV0fZCUJr7eWT29/2jIxUaF3JpzeRHQKUSKa8dfSpR8YAgECPnmIkI/sUxBPe2Vd5wo9EItqxj7aliASk6f/GqrNHAKwwenjBBTF7vkUWILmbt+KE7wEiOllKfTJGtztZiBiGr1OC/VXXbSBgr6qimwc1ONgIBU7RHTkogi7w31FrTV7KR+YMa3sud4q0kgGHrn/YT8nVTq7IRvqO3XnQ70g/CI14NMFpwrJho72twAVFA1rGfe/5FBz/ioq+tU6b8PPr17rpY63hTN5hxu/YVjnN3MuprIEuElLqShmRQRm/c8JFmDI01fR6iPspSu+7UAPvRaCKqVnxtVLpMAlj2r3cYXaMJqKWuYSaCwLvg5va0KtpnNryc5tDO/8F3FWArkdjgT9CfrUhn7vQwZOJtUt9hc82RL3hP0kd7RDPU5dVorJgHpTb7FgCmtL+HrxzRiqJwrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pHaCr/BzoqJ5zV31i3FhHXuBuoql1lAavrdBplz2g3LCmRXMES6H7xcoPij1?=
 =?us-ascii?Q?P5iB8Q4XVk2ejxXlSQ4ubtJmZBCmFoO+7Ar8hJjVb/8T8HyIejmLxMv3h78K?=
 =?us-ascii?Q?eI2qlS1VgxUMa5BbBXPDL16c+PwszJQVEO4M0Ew4Qe2taxJLUbFkG/49tKcl?=
 =?us-ascii?Q?rqo2MsM0hjKLXVdy9f8F28Q5shHoyoLz9aD/IBP2/0LxbPke1zfUsS6GInve?=
 =?us-ascii?Q?Y/7a6cnVVyy94BrIGm5T8mwS0cnxumODhUia6+44XGYJ6/1iW+a621hV/4RA?=
 =?us-ascii?Q?B8K22dyYJITqF7aIVKYuCc15II5jeRCKK1kG93LURW6y6LOfMcwtzakiKVhO?=
 =?us-ascii?Q?uQFN4RU9pKsgi+U2TaKZo7aegbpx7Gf5Xd81MbtYUKA43D5nlQATd2FeyV83?=
 =?us-ascii?Q?A8wAPURIWfkulLwMl0AAMZKVtqY0sfudckaao4K5PyYzw5o5E3jNR3JVJMhM?=
 =?us-ascii?Q?vBzIQiepDy68iaDUEGguplhPTHdj5sHYq51Ryr0tp2OpzoM36tD77clygJ0v?=
 =?us-ascii?Q?zTt/VLwpcoIFLatGZwfOSI4eUwxtb+8YkRxpwlQc89Sejgiu0RqxgMQ5Hhsb?=
 =?us-ascii?Q?xh4fKAz/2qEdWGMPYqhIwrqSzkwVRY8LTyDnTm5VmK60RVklmaLMSMCEB71y?=
 =?us-ascii?Q?8a+795XWPr5WCkJbBMTnq0Xi0HT83OUJAlYc8gyvlzN4rpzeCpyiLJWzqoz9?=
 =?us-ascii?Q?R/DQiva0axLMtdQbPqlE80diztgnTS2Ona8T54w+OutEz3A2u+bTA+SZcXev?=
 =?us-ascii?Q?XGW3x6U/1Gy9PgdLSmXoWgertaUK9DFQ3/LCG1FMTxMo/9uBfGkUXfFEcemK?=
 =?us-ascii?Q?FiQoPPH9uh10l4mAxYBWi/aKB3BcOxzPl6p0U+MQ9sfZrXbTLon5eJrzygit?=
 =?us-ascii?Q?iizbeWXh+UjJ0h2fFIkpqu/XIyjJ7YJg+Sj61pw6E+br014p0E/97hfmz993?=
 =?us-ascii?Q?Y6B6tSzT6mw3aRorVUa5RUIWDLFvCAFH2nUQXRVnppJrdHMJ8s0o6XIpL4pm?=
 =?us-ascii?Q?D2M2ujprVW4qjbaQMi68U18w1cWcO2K8JfoLKYYQGJRGwdLNBz7enQVQKrx7?=
 =?us-ascii?Q?I+NwhiqXJohJ+3pzw5aV1ja/AuNoPN63GTDQVHu7LXQ0DqeSD5P97T9bcgHr?=
 =?us-ascii?Q?lR77+cu/+8vNdjs4R7ajVf5Hk7GFlJp7PCpYPJwyCF9xTDPqmaQRKBCHCEH2?=
 =?us-ascii?Q?cooyG1A4dbNysUiAAx3M1jgZhmAzimetzOtB5Bq5vof5UkutxStxaAVy/CpQ?=
 =?us-ascii?Q?LoultrPF4Ev45LONcgmDc170hVOMWMdWYs9d1bZrER2BwiIvGbNdwcCR1OyI?=
 =?us-ascii?Q?K45hmPC84EuGIRrL10Jj2et4hwu+vycVl/+7UNIQxG/In9VjEjEJLeh4fDe8?=
 =?us-ascii?Q?1TOQd7qBEZ997+YVIi9R169sZXTxkDsDaS+Ab9g7irg0axdMkh9OfaD0Ri2y?=
 =?us-ascii?Q?0RCFZB/DR5dSynPoR366b7cQEhAOmxEwPMscyV59J/bsmszgmfpNSwzWjazD?=
 =?us-ascii?Q?I8kjKm9hCyV2FwAnarBTwP+S5BSoaG5i4XhXKGoKA38bTb7Y0WANYowewIMZ?=
 =?us-ascii?Q?T8w1yibw26t1tBHeZ8gSt1D/Jd6zZocQYBPbK6QUK5RqahE2iGumIPnyuA3l?=
 =?us-ascii?Q?v0eCEu/iC/KQ4Hu/EoYI2M+X6Tm5LJk4Wlia+mAbOZjipuvEtXHUSAS/kfBU?=
 =?us-ascii?Q?xfYAx7LngBhrDhsjCoMJwJWDgqvabMeXeX+HaVEBPLfj3WQv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c4ed3-32be-4cab-5c8d-08deee79c1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 20:33:04.6066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29s6c/DhoQ8MWnQ5dGZWg0LeQfvxQSNORMAQqHSDy47w8ktJySZNcE/1aCekr/tHDSnvebTS0iBhu4SxcnAhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun
> Zhang
> Sent: Thursday, July 30, 2026 4:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add JPEG v5.0.2 SRIOV code path
>
> - Add JPEG v5.0.2 SRIOV code path
> - Add JPEG MMSCH init table transfer
> - Skip unsupported actions such as power gating
>   and per queue reset for SRIOV VF.
>
> Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 156
> ++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index 1c7f13e1cd75..e9df11a5dd26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -34,6 +34,7 @@
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev);
>  static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
> static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);  stati=
c
> int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
> @@ -164,9 +165,15 @@ static int jpeg_v5_0_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>                       ring =3D &adev->jpeg.inst[i].ring_dec[j];
>                       ring->use_doorbell =3D true;
>                       ring->vm_hub =3D AMDGPU_MMHUB0(adev-
> >jpeg.inst[i].aid_id);
> -                     ring->doorbell_index =3D
> -                             (adev->doorbell_index.vcn.vcn_ring0_1 << 1)
> +
> -                             1 + j + 11 * jpeg_inst;
> +                     if (amdgpu_sriov_vf(adev)) {
> +                             ring->doorbell_index =3D
> +                                     (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                                     2 + j + 32 * jpeg_inst;
> +                     } else {
> +                             ring->doorbell_index =3D
> +                                     (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                                     1 + j + 11 * jpeg_inst;
> +                     }
>                       sprintf(ring->name, "jpeg_dec_%d.%d", i, j);
>                       r =3D amdgpu_ring_init(adev, ring, 512, &adev-
> >jpeg.inst->irq, 0,
>                                            AMDGPU_RING_PRIO_DEFAULT,
> NULL); @@ -187,7 +194,8 @@ static int jpeg_v5_0_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>
>       adev->jpeg.supported_reset =3D
>               amdgpu_get_soft_full_reset_mask(&adev-
> >jpeg.inst[0].ring_dec[0]);
> -     adev->jpeg.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> +     if (!amdgpu_sriov_vf(adev))
> +             adev->jpeg.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>       r =3D amdgpu_jpeg_sysfs_reset_mask_init(adev);
>
>       return r;
> @@ -228,6 +236,23 @@ static int jpeg_v5_0_2_hw_init(struct
> amdgpu_ip_block *ip_block)
>       struct amdgpu_ring *ring;
>       int i, j, r, jpeg_inst, tmp;
>
> +     if (amdgpu_sriov_vf(adev)) {
> +             r =3D jpeg_v5_0_2_start_sriov(adev);
> +             if (r)
> +                     return r;
> +
> +             for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> +                     for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +                             ring =3D &adev->jpeg.inst[i].ring_dec[j];
> +                             ring->wptr =3D 0;
> +                             ring->wptr_old =3D 0;
> +                             jpeg_v5_0_2_dec_ring_set_wptr(ring);
> +                             ring->sched.ready =3D true;
> +                     }
> +             }
> +             return 0;
> +     }
> +
>       if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) &
> 0x100)
>               adev->jpeg.caps |=3D AMDGPU_JPEG_CAPS(RRMT_ENABLED);
>
> @@ -276,8 +301,10 @@ static int jpeg_v5_0_2_hw_fini(struct
> amdgpu_ip_block *ip_block)
>
>       cancel_delayed_work_sync(&adev->jpeg.idle_work);
>
> +     if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
>                       ret =3D jpeg_v5_0_2_set_powergating_state(ip_block,
> AMD_PG_STATE_GATE);
> +     }
>
>       return ret;
>  }
> @@ -407,6 +434,122 @@ static void jpeg_v5_0_2_init_jrbc(struct
> amdgpu_ring *ring)
>                                        reg_offset);
>  }
>
> +/**
> + * jpeg_v5_0_2_start_sriov - start JPEG block under SRIOV env  */
> +static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev) {
> +     struct amdgpu_ring *ring;
> +     uint64_t ctx_addr;
> +     uint32_t param, resp, expected;
> +     uint32_t tmp, timeout;
> +
> +     struct amdgpu_mm_table *table =3D &adev->virt.mm_table;
> +     uint32_t *table_loc;
> +     uint32_t table_size;
> +     uint32_t size, size_dw, item_offset;
> +     uint32_t init_status;
> +     int i, j, jpeg_inst;
> +
> +     struct mmsch_v5_0_cmd_direct_write
> +             direct_wt =3D { {0} };
> +     struct mmsch_v5_0_cmd_end end =3D { {0} };
> +     struct mmsch_v5_0_init_header header;
> +
> +     direct_wt.cmd_header.command_type =3D
> +             MMSCH_COMMAND__DIRECT_REG_WRITE;
> +     end.cmd_header.command_type =3D
> +             MMSCH_COMMAND__END;
> +
> +     for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +             jpeg_inst =3D GET_INST(JPEG, i);
> +
> +             memset(&header, 0, sizeof(struct
> mmsch_v5_0_init_header));
> +             header.version =3D MMSCH_VERSION;
> +             header.total_size =3D sizeof(struct mmsch_v5_0_init_header)=
 >>
> 2;
> +
> +             table_loc =3D (uint32_t *)table->cpu_addr;
> +             table_loc +=3D header.total_size;
> +
> +             item_offset =3D header.total_size;
> +
> +             for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++) {
> +                     ring =3D &adev->jpeg.inst[i].ring_dec[j];
> +                     table_size =3D 0;
> +
> +                     tmp =3D SOC15_REG_OFFSET(JPEG, 0,
> regUVD_LMI_JRBC_RB_64BIT_BAR_LOW);
> +                     MMSCH_V5_0_INSERT_DIRECT_WT(tmp,
> lower_32_bits(ring->gpu_addr));
> +                     tmp =3D SOC15_REG_OFFSET(JPEG, 0,
> regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH);
> +                     MMSCH_V5_0_INSERT_DIRECT_WT(tmp,
> upper_32_bits(ring->gpu_addr));
> +                     tmp =3D SOC15_REG_OFFSET(JPEG, 0,
> regUVD_JRBC_RB_SIZE);
> +                     MMSCH_V5_0_INSERT_DIRECT_WT(tmp, ring-
> >ring_size / 4);
> +
> +                     if (j < 5) {
> +                             header.mjpegdec0[j].table_offset =3D
> item_offset;
> +                             header.mjpegdec0[j].init_status =3D 0;
> +                             header.mjpegdec0[j].table_size =3D table_si=
ze;
> +                     } else {
> +                             header.mjpegdec1[j - 5].table_offset =3D
> item_offset;
> +                             header.mjpegdec1[j - 5].init_status =3D 0;
> +                             header.mjpegdec1[j - 5].table_size =3D
> table_size;
> +                     }
> +                     header.total_size +=3D table_size;
> +                     item_offset +=3D table_size;
> +             }
> +
> +             MMSCH_V5_0_INSERT_END();
> +
> +             /* send init table to MMSCH */
> +             size =3D sizeof(struct mmsch_v5_0_init_header);
> +             table_loc =3D (uint32_t *)table->cpu_addr;
> +             memcpy((void *)table_loc, &header, size);
> +
> +             ctx_addr =3D table->gpu_addr;
> +             WREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
> +             WREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_CTX_ADDR_HI,
> +upper_32_bits(ctx_addr));
> +
> +             tmp =3D RREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_VMID);
> +             tmp &=3D ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +             tmp |=3D (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +             WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID,
> tmp);
> +
> +             size =3D header.total_size;
> +             WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_SIZE,
> size);
> +
> +             WREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_MAILBOX_RESP, 0);
> +
> +             param =3D 0x00000001;
> +             WREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_MAILBOX_HOST, param);
> +             tmp =3D 0;
> +             timeout =3D amdgpu_emu_mode ? 1000000 : 1000;
> +             resp =3D 0;
> +             expected =3D MMSCH_VF_MAILBOX_RESP__OK;
> +             init_status =3D
> +                     ((struct mmsch_v5_0_init_header *)(table_loc))-
> >mjpegdec0[i].init_status;
> +             while (resp !=3D expected) {
> +                     resp =3D RREG32_SOC15(VCN, jpeg_inst,
> regMMSCH_VF_MAILBOX_RESP);
> +
> +                     if (resp !=3D 0)
> +                             break;
> +                     udelay(10);
> +                     tmp =3D tmp + 10;
> +                     if (tmp >=3D timeout) {
> +                             DRM_ERROR("failed to init MMSCH. TIME-
> OUT after %d usec"\
> +                                     " waiting for
> regMMSCH_VF_MAILBOX_RESP "\
> +                                     "(expected=3D0x%08x,
> readback=3D0x%08x)\n",
> +                                     tmp, expected, resp);
> +                             return -EBUSY;
> +                     }
> +             }
> +             if (resp !=3D expected && resp !=3D
> MMSCH_VF_MAILBOX_RESP__INCOMPLETE &&
> +                             init_status !=3D
> MMSCH_VF_ENGINE_STATUS__PASS)
> +                     DRM_ERROR("MMSCH init status is incorrect!
> readback=3D0x%08x, header init status for jpeg: %x\n",
> +                                     resp, init_status);
> +
> +     }
> +     return 0;
> +}
> +
>  /**
>   * jpeg_v5_0_2_start - start JPEG block
>   *
> @@ -566,6 +709,11 @@ static int
> jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret;
>
> +     if (amdgpu_sriov_vf(adev)) {
> +             adev->jpeg.cur_state =3D AMD_PG_STATE_UNGATE;
> +             return 0;
> +     }
> +
>       if (state =3D=3D adev->jpeg.cur_state)
>               return 0;
>
> --
> 2.51.0

