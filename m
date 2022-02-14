Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93573C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 02:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46B010E19F;
	Mon, 14 Feb 2022 02:58:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6757210E19F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANnWGnfzKbR0qmJ3P03Q32CuVTHxPf8OchfZ2w0djVnBdOjn2PmpY94YdJrlYVrldCIBo6qwHWaBJwxlF6EXHrfavTMq0Js7BH9w+UB+w8+v+x6+zfs7ZdgOXvXOXXcTV+2YegU9Cd2PJxevh6uzcu/lcyLlHaafQ041Yws7vRIh8HX64zvYR+5YLWfx1gqwr2vAZ1OydofSIr+oOXPg23NQgDIf01YsjCgSuDmvz/zKW1TtqAslOEn3gsErF4KUs4/tcwbx2icji07TDny9+Wfpn0VQbm5T8OCZUMNfbv8AZFj2pyd/0ZabFH0zXeQa/tAyO+g+gBLX09F5f+E/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcumFARnaE+Ee/fYbS1DUjotf68agIXwzVqlgRlVL84=;
 b=Wk3XISAd031ItG2JLdRP0cqkPsbeHygCrYhhyrl7w0nW3grS3pnVKxdTiZ7E3CSsqzs6wOF9OfPx+kqZK5DLG6eJ6PXbgCPWKpf339kqMggfM8IgKFVkia1lNPEcgynIotj2vLPj29TgCa0UKpWiA4FucTbb5o0rbPdhJNmlteOOTgRN2H8HG7MQkoWetDdSlA4z5jyIx5v/zPp85zJbHpILJAbOXwpsOJG+NrtjyXUQdTY1akjv350rVTk/pdSIfm+TfshBVp3g2c6VPNKwkkfncIRQix/+D0S7n5eSwqYcgybSlCfsIQegic+n+b/4jlRBfp4qVOYlOnJ8sUjXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcumFARnaE+Ee/fYbS1DUjotf68agIXwzVqlgRlVL84=;
 b=XgoNigkV3eNco4QZZ5tTlCLHJOmQ1jYhIAVrFiNahw619AhQGEEwUb5WfKENKEK8/vsrl06M1NFe911slsFejHfzN6VeayiheE/4A5JTJU/BmYvmg011PlPuCxURWy0xFoBacSbphclXJ1gB852GmK8USO7vzRVThd63F3xlGnQ=
Received: from BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 02:58:35 +0000
Received: from BYAPR12MB2856.namprd12.prod.outlook.com
 ([fe80::f172:b623:5bfe:7566]) by BYAPR12MB2856.namprd12.prod.outlook.com
 ([fe80::f172:b623:5bfe:7566%6]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 02:58:35 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Index: AQHYHwnCKPsGr2Ieo02OTVMmw2ie1qySXvtA
Date: Mon, 14 Feb 2022 02:58:34 +0000
Message-ID: <BYAPR12MB2856AFFF4A9FF47F1F371926F8339@BYAPR12MB2856.namprd12.prod.outlook.com>
References: <20220211053856.31729-1-guchun.chen@amd.com>
In-Reply-To: <20220211053856.31729-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T02:58:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c44813f0-1d2e-438a-bab2-1396c05c0f3b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-14T02:58:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0c75058c-54d7-438a-9776-5168e732c89b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b57c40c3-b45a-4d64-b7d8-08d9ef65e450
x-ms-traffictypediagnostic: DM6PR12MB3932:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3932FED653A36D43B6552A81F8339@DM6PR12MB3932.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4chvTw6Mp9El4ZsAC7MxDIHtPkYn5uZ2dtemePQ4ioV0mbc18ErFFF+YAEjp2crSgT7LisUovt6vc7JGuwbAekUUWP05dl7bR0HNWGjjaI8jNOzUflYPUv6hzM0Sarq/ngjkreMOUVH5PqyTJEFXL5bT5bu6lgRUaJDx8EqrjUoUw2Wfj25MrQ+y3O1+HiyCFk29024U4eFmlqa2RKXdiuyUULG0hwco23bLv0ywt81idLBXBOF8SAx8P2DZuRIhu7eC2yJq51e/CFse8nBAs+4pgwUaHwwMRf4Xq1pwnDxSUMDCKO1E0c0IbvEiQ/7xge78Ja61wqnqZJDMaj1azbV6NcASwox4n6AT7DSWqUG8uaiObAqr2T18DLeoyFYsMOkx9T7SxxCa+Zu3gjQOdOfJk+UA/kQB7T4gpYG651Q+9sBCntno2Fbt78l2oyarYWougixV/1U+2eQ/vuOmImHaqznK8y4BYaplNAE6Os8zojz/RKkmsUxXj/UiFPssZiSaDqeTpPJ5qQ2/z8std7b9IpTah7Kb2E/txAyFUsYzDNkMWeyN8SuwIjNl+cftF4FOtnyL1mSv+dcUw1w0j0pKgG6NURGMFdZEUKFh/RxfGNocTpTfO9neWnfkv10VlFebIc5Kj0CI/Bb9aIgoyHxAOecwApnRYL+ydYVvDpwPPCWr+sOqzZzufKlaSpQ5gEIdXN0WGJoVmBtYfDtizu3JSMr0GIRRrZjZmu/i3A8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2856.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(9686003)(55016003)(186003)(83380400001)(26005)(921005)(316002)(76116006)(66476007)(66556008)(66946007)(33656002)(66446008)(122000001)(64756008)(508600001)(8676002)(53546011)(6506007)(71200400001)(38100700002)(52536014)(86362001)(8936002)(7696005)(110136005)(38070700005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ECwMxggDwETeTNa8xhOZD9t7esjlAY5OKvK8k+wFWiYv18jU5enTjjtJaFYG?=
 =?us-ascii?Q?zVcxdlL4Gn3UrxY1JUpLbCih+TFFGDCuELT/icKOGNQGNNowhifPIJyC7wAh?=
 =?us-ascii?Q?qFYwiCFXzPMgEyD9LWLp/xUT1v60f+O3Tee2U8KX0NJaYQ/OGlrJVlYazsPf?=
 =?us-ascii?Q?janGBlFbiZfFsg6AK1TUdby378a68LpIqximjTj7jn+JUlBQwEgwhWNmqfOZ?=
 =?us-ascii?Q?3iLWCWGUw8INXEm/dJX7aQIx1rNcngqQM5kLPL285m5q5qU/D3K17CVi6pgq?=
 =?us-ascii?Q?lo8T5lsdMEiXMcpA6TCKaBA+FBfhuqqUhuI58pSB6UhTtSxgmIXzXulv7AqD?=
 =?us-ascii?Q?TOStwbc2/8r/yOu5kOvemhFxsCqCYxtJbfJn0L1c6cP1yrLWPWVHmv1FrHA3?=
 =?us-ascii?Q?u5Tk4Snw9p72KUvU3DoLS72U2TWL57A7gIcCxbq0+ao6VVEqIQbzLqgri2Mo?=
 =?us-ascii?Q?bgcoK1KiVU8Qgt3FevyO7D47gKWkkMxcbCCUQmfaZ3s4ByoWJGQ1qVEjlBru?=
 =?us-ascii?Q?e7z+gdwyMYQ4rzjQzsBOZhnaQ6fdWQoSEsxnkeNNhuhvxBoZUVG15R/Yaygo?=
 =?us-ascii?Q?hWRViK4Nws32001Bup1u6KfrGDw0qJHfUtva4fGSabShcneENAjErFROYMsz?=
 =?us-ascii?Q?GJyYda2CWTh0FsB+jM8W4EgpdOce7GiY7RCs2/nUuuhGCut6Jhyuzeu8n0kx?=
 =?us-ascii?Q?jl3XGjsjV+NcMPMWMbJzgqCppENKQiDcBygnWc+EFnKHJMTIguN7X6SRpgdr?=
 =?us-ascii?Q?4iECMK5WOo7HuocBpmVrC0M+l6RfKPYEq8y4HlnHvAansaM+KlnNFXMOLCgf?=
 =?us-ascii?Q?7J9ZE7Q2SRbukznZzKHmebWc8eLOOrH3NVJhAE+/Tbzx0LhPZY2vz/4ayNOg?=
 =?us-ascii?Q?LfRIQs3CkBzNmF9IVV4kKqJFvptrKQVbPYJ7SYlUNsr1GPFXPZz+hkEy6GRa?=
 =?us-ascii?Q?SiyFX3Nv205Zie/SAUr7FUVZuxsZokK3UBP7CMHV6aRa5yKM9vjurvRu9kW8?=
 =?us-ascii?Q?3vt8bEqFDj7XRHzxBuhmQl4LtU21iVGZ7w9qyKU+Rw9d3Bw23CRfXgGimMiv?=
 =?us-ascii?Q?X2Q/fLQ3h3T2ij/itXufu/yYFI7Rghse+dfATer9c+9Qmy4z/eT208LvktuM?=
 =?us-ascii?Q?i0xQC+o/Vj81rS9mqrMiweCR1vxm44Kg82Zoci7/W+I/8q4sLh3eFOvX8R3X?=
 =?us-ascii?Q?b7xrCCbbOmju92m+0YOw+cfrZt0NMICyCW7u87WbQksnI7eGC+pkM7fosTKx?=
 =?us-ascii?Q?pH8Dd0A1GX6FRblnV26tDeRKZGhN3+lcutoR3mntDTPErzbUVHNYgvtfyzEG?=
 =?us-ascii?Q?WgTxEPrlBD5IiQ1xnMd+LpWpTtnFaQBQVVrjGxo1cdBAEhNK9taivGJHhSnK?=
 =?us-ascii?Q?Pv+CrSjuwX85ELp0fYFnr6xbLCe9yOgjsfOPKmxg88s1CedIBqotvYTmmqWT?=
 =?us-ascii?Q?ur3X21UXKXh5pKWrUmqc8FrrmTojE3sotBFp05bZJV042jNNrxLe+Jks6sfC?=
 =?us-ascii?Q?2JtcZFeHf588bIchrMvGHP9Bims9aQ0js7h9zZxyBfqjvCAQJg7/3LEYPU4S?=
 =?us-ascii?Q?wGAdw6sLSG+CnxMuw+XzOIy1+E8S2NddbZH1Pv+jNVgn5KUA3WA6CKfz4RoY?=
 =?us-ascii?Q?GSSNRXmfzzjQfaFQf7vnSLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2856.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c40c3-b45a-4d64-b7d8-08d9ef65e450
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 02:58:34.9303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGbPPIqBntP58yfNGmBGtlM8d8ly2Meje3CCw+iDtsj+XeJnCdRps1JtNgZbzogB85byaPoD1hB3IbqTHS513A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3932
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

[AMD Official Use Only]

Reviewed-by: Peng Ju Zhou <PengJu.Zhou@amd.com>


----------------------------------------------------------------------=20
BW
Pengju Zhou



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, February 11, 2022 1:39 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Skvortsov, Victor
> <Victor.Skvortsov@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
>=20
> rlcg legacy read is not available in SRIOV configration.
> Otherwise, gmc_v9_0_flush_gpu_tlb will always complain timeout and finall=
y
> breaks driver load.
>=20
> v2: bypass read in amdgpu_virt_get_rlcg_reg_access_flag (from Victor)
>=20
> Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for
> gfx9")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e1288901beb6..6668d7fa89e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -836,7 +836,7 @@ static bool
> amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
>  		/* only in new version, AMDGPU_REGS_NO_KIQ and
>  		 * AMDGPU_REGS_RLC are enabled simultaneously */
>  		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
> -			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
> +				!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> write) {
>  			*rlcg_flag =3D AMDGPU_RLCG_GC_WRITE_LEGACY;
>  			ret =3D true;
>  		}
> @@ -940,7 +940,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>  	u32 rlcg_flag;
>=20
>  	if (!amdgpu_sriov_runtime(adev) &&
> -	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true,
> &rlcg_flag)) {
> +		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,
> true,
> +&rlcg_flag)) {
>  		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
>  		return;
>  	}
> @@ -957,7 +957,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  	u32 rlcg_flag;
>=20
>  	if (!amdgpu_sriov_runtime(adev) &&
> -	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false,
> &rlcg_flag))
> +		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,
> false,
> +&rlcg_flag))
>  		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
>=20
>  	if (acc_flags & AMDGPU_REGS_NO_KIQ)
> --
> 2.17.1
