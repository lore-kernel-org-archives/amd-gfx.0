Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDB0C35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B4310E2BB;
	Wed, 19 Mar 2025 06:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rUlnAEUf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D7A10E2BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlcB2lY/Ol8zcJ92SduUmmBhx6k89mgtTODWCO3Ut2KaqKBoLNxPv9mN2sR8s4XtacaOlSkOilDORi/QMbU6WmHq1Y9P+OVU9KnRcbvKdU7+mWyqAwbFmVnWy4SZDyHFuS+q2jZG6rGkuL7JKjHj5R1VcokNvwFafKu6HQkmZO9wkYcxZgj9TPNhuHTe2KyY6EA/opfqBsRciLq3pAUndHRDZdqk4tyFg41FLxh0Zjmc1wkJateFMOC6sWXB0yIh/ObRgNuGJER2bdLwyBr3pkSJ0TKpUnFMnyPNE5Tla/QmL7eBQ3gnGGuPln+2DPc2bbLYli/DtO/iEE8lgsgsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMoLmvFwDw5JfjfH8G4WjRBCSl7YgGJEqm6I/MUnLE8=;
 b=PoJhHhYJdspYsyhQAFpg0PZHati9iyPF9j+7N8rfhLKXTenEP9WBhsloCJ6IRYkds6hTJI/GMVMw6s7bgLRmE/geK65enBvr9oq195BRnMCideHpAHAH1JsY1cHqYk1qsSEcfi80wlWMJoWXmsKBk/SWRKrJQ7Z+RIlyLE4q6glwu0+xL7WCmA2/+N8qbRlPj+vnW9GUtH9l8a8s4k/gK0Y9BgyzfK6jDvgee5os1RewGpoDtdwNcdBtSiTEO/+/limeiEORuxvwIKNCkFcCv2pSkuicWWLTDGgrtyEWMsiWOS+OafDucrdv0VjsI1G78Xc9xgL+sXjFAxnYTm5pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMoLmvFwDw5JfjfH8G4WjRBCSl7YgGJEqm6I/MUnLE8=;
 b=rUlnAEUfbdyr0x0QlA1mDob91cJppDNHlqBK91z/yeSB6QtaK1yBkNcSCGa+YgIZokerV0RNVjtL3LaIVuGDqPYRsDepGQzXKMCwy2AnXJQf1Ib86R9Gi4yZqUhyChWmAKFLzMUDgZLov+cRTwpYSkS4lo8DYmf0H+Nsb0Pjd8Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 06:42:23 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:42:23 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq is
 set
Thread-Topic: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq
 is set
Thread-Index: AQHbk4CwnacCz/YBB0uvLy/EUMcW+bN6C2TQ
Date: Wed, 19 Mar 2025 06:42:23 +0000
Message-ID: <DS7PR12MB60050B97E4066E9841BC4BFBFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
 <20250312185731.211350-6-alexander.deucher@amd.com>
In-Reply-To: <20250312185731.211350-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=23f2fe6c-1c4e-4950-80f7-4f82a4ae3a07;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-19T06:36:17Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4254:EE_
x-ms-office365-filtering-correlation-id: d235e037-9adc-4608-f003-08dd66b13494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e6dhr+wuQbUdBopH2WMq55AisRQl7iDNf0SFXTWruvRuVMBZ6MyuvKme0AI5?=
 =?us-ascii?Q?ovTSqZ21o8l6l4+6sMru1wm3jDU2Ag5+oGKENkWNlN8JDYixtIvYrezujHTQ?=
 =?us-ascii?Q?tgSN9TMOhknQLoh57e0S/EavXTYOHI7oO80l3tI0tgcZFfTZMHTJ2F/fxeMK?=
 =?us-ascii?Q?dtZ8ECn+77C2JdSOwm3jENowRv0Ne5lUJe524OuUHhtSQ3bEjfKP0IW2cG+f?=
 =?us-ascii?Q?JBZKtByoKbJlrivskjG1oX8WqPkY3WHkOZq6NLmhUNCpFhTqpOyXDAVp93OV?=
 =?us-ascii?Q?gq6fuE2DsZKaqP8QR/VTfTvFAcM95K3uvd66vN3pr6F0Td4ga0ckfLGmB7HG?=
 =?us-ascii?Q?jxyRIFp2J6saLRDwKF1R1NQgckvFLzdaZowAjoq057soKoa/M6nqhWSBsXzw?=
 =?us-ascii?Q?xdhsJdw2z0nNlOBHY7fOftX+zQsfRs2TNzgc7uy/Aeu0gW72bVtWgagqf7g2?=
 =?us-ascii?Q?xOmwYjIVdDFBjEddDa5tGv4ydEDVZ2tcM3q1EmN/c8fsC56UxvysHawMqc1W?=
 =?us-ascii?Q?k6hhNLxX51umCW8KqB59TF1VoEOnWN528qlFDtfh6K/dGj2B0ZWq4a60Dgcq?=
 =?us-ascii?Q?Y/j+UsUnFvqBe2ufoqjE+T84ZDIIdR1y7K0x5Yo731J15LIJ+5GddQpP0ioL?=
 =?us-ascii?Q?1XmBND7o68LdDKI6sJDYgHpFnZ3C/dLZk6eTsU3kHJIbIPv8DJ/G3FntmVAa?=
 =?us-ascii?Q?pdtYnwfbp9m+P2CjyeyzSWbOQgnpljZY9paY8OCd1wRj4kygp+3dFCQZhtcn?=
 =?us-ascii?Q?EFQFFlvlFAGvr/utJHwclBXDneswjse+55B0TEH+SgIGX1fmoXjwAtJ65Noz?=
 =?us-ascii?Q?qbWidSO+samhUSnx/XaXEs4mOEnET+8mVjY9mHIiyA44TQ2aHlJFZx5OrwKe?=
 =?us-ascii?Q?00RMJ2J75Ryat919CusTIe4tB+WlyPhSQudnLmxcIVubTJh9u4LRAc7nMIsC?=
 =?us-ascii?Q?XjTBAw72V5t27c6k5fdnCeqofyFowY25eJPHimU9piqTt5XlTjh+xR8faMOC?=
 =?us-ascii?Q?4+a+ETQExmL/wUA9JJZuUO+5oRRnI6e1COGVwa6w/6c6DQEs+drnwyH5RmTr?=
 =?us-ascii?Q?tG+qY4nsIk2RkRPcz9aLZvumFEHqaG+zeaSq3VP08WGBP3JZKQTBSF4udTkG?=
 =?us-ascii?Q?l/UKfMF3/e7BJRExmnk2FEn1Mu5LfUX1GKSfVwPT4HJsC8pIXcB965qtOl/z?=
 =?us-ascii?Q?GR04dOvJTodOez7fTCqVdpJtbkhVpO4VgZX5rBhwbHP6nNRH2wh2Nx5EsqkF?=
 =?us-ascii?Q?Yvun+oiK3rl8R3igbnfhgLQH2i1tiVECtUKfnS4ab6Bw7S7Q2Yd2SloYCdAj?=
 =?us-ascii?Q?IdKBTzpng7puNCBslD6hcGybvIAEhdLdRZvfv/62eGu4u7P2eEnLE0e8SwgC?=
 =?us-ascii?Q?Bmq5Ff2Y+TPwZVLohZmIuVOIuxsMxUXU4wqlyZVXicWkKeMr3fJWHU6yOcHJ?=
 =?us-ascii?Q?Qzhdi7+z3adOWZzuKjZarJp03MqfBaAl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0K/T0z+eO/pRAO/1nB/pe5CWV24nwl7gVsKFjzKErV+fikp/t2oJ8S62VVSA?=
 =?us-ascii?Q?Tj5a81+c9g57+DtKHLWphf7LeWM3CydtzX0Bm5sU6RYN6K4ljQnFFiZjc4+x?=
 =?us-ascii?Q?ihMWBhQhiGSoOXtiysa7aYpuZ40hB+BaYwqjOVSoJhxRDSQ2xc51nREBpAL4?=
 =?us-ascii?Q?R2bF7M3jYTjRtAPsyESC2WmQKWrhVPv/DEIwS0B5B/MdUK4LfRxpd2+/qiR8?=
 =?us-ascii?Q?zf2hXoiOXL7cTyjE8iPaZXulS6KfFNzMG2Y394MYgTdK3XEMsNANnf8dTQeJ?=
 =?us-ascii?Q?Rqs63RDjtDL6OSlug4SP2CGaVpuY3vxtjPXku8BBJDptLty0znxgQqCyY0k9?=
 =?us-ascii?Q?6c9AyeRf3ArOoYKbx8pNpV65opEi2zjFGpgswCV3ySVOjZPcV3a6thtJQRmY?=
 =?us-ascii?Q?YyTv1OmovfKiozGDQxFbBrTijP5JfUja2ru67agFDAzQGqgF+HWort3t/knp?=
 =?us-ascii?Q?/GcyZfyKtY0jTOnj5s5iYY+72kcWp+WQ/GmfJWewhhKQVvlkWH9QhVcnh+Y3?=
 =?us-ascii?Q?vBPOKTQ8ERyRk+Qy+9SvDCFef17Cw/2ylS46DQwWPQzHGkUgQxdW1qQ6kTXI?=
 =?us-ascii?Q?aSX1tjqDZzv091RHNVc7QUkfny7fYLqKQLTU9HLSTiVEA8g6tlMbW7f06QtP?=
 =?us-ascii?Q?RyZ104jJ90pW5kMSpGFuuIkAIAlrgS7ggq7JQJK+AxuHllzHBjyQ47Cr4Z2v?=
 =?us-ascii?Q?9+QU9iJc7hnwMc8FsC8tgoG3h3hZIHzoCqEsGaMZl79s1CL6vhcMj39eEhXx?=
 =?us-ascii?Q?f9N787tgc9RJAjJ96jkL38VYvz6J5CfszczMg+TA/0T+CVGvC0GnnQ2mKnBK?=
 =?us-ascii?Q?0llSwvWHUDMFXxpl0bgllnW79UvyJEgnsV23MrPm5T/IY0QJ2sv7kahWoXY1?=
 =?us-ascii?Q?t9W10CWaII5HdccEjHzfOUdrm5oDAeFRTCph3cKTQPzfqFhB3b0e35VSC19H?=
 =?us-ascii?Q?fkM/Ce/Jxf78RvA4NVAO+lPIMpyf5Y4df9APqvAqd9ta0FNHuYkNpmV391UA?=
 =?us-ascii?Q?E56eVB8+2y03s3pSGHFiFnzwOWEfquqYTHwkKc5FwcwnSH6q3CgXbA4u3/44?=
 =?us-ascii?Q?g+WkGi7+ydaoEOMwwnm+20eBwagONXoo7SmsJ5aJMF7Vreg9KBycCp+5YYTC?=
 =?us-ascii?Q?8ViIwzkicKTiRRSDFJvqRuGDADzckdvcn+kzc6O3vssztOXm6eaLc3ljASIf?=
 =?us-ascii?Q?BTnJz5Ixxhv4V1KkKE5dM/OLGhWezVA1BjExfa4uDCN/JgksSOwu4fAcSn1X?=
 =?us-ascii?Q?eJ++NtXM2pxk6DvvF2McPIR8MgLwsH6I7ML3a38duV21EzVzVxqBBuW6kLNG?=
 =?us-ascii?Q?3LhWBF4AzEDm/LZtDLMsGkFRm7QpfQd08asiguc6DtqeTXXuYWwbixYlkMRp?=
 =?us-ascii?Q?CrNWh93a6Zp/VrEAegZE21jUSszuPExpRDDseqzhmMxRQtBmmQgL7by5K3is?=
 =?us-ascii?Q?hf/VOMgIyjtcSAwrBv0gc/ymcS1/6trmot7/a5b06kxKcm6ccriqwbnwmCSL?=
 =?us-ascii?Q?yHonUHcfqiCM1aMpYiGPCqvMLch1mCNLyyzhPEyHGh0HVRBVDvFqDeSUOxty?=
 =?us-ascii?Q?W9CAX6cyy+9POicJfKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d235e037-9adc-4608-f003-08dd66b13494
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:42:23.3674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvQZ/9aonBiosJ5ixy6wUc1pIJJEOhLD/MkivLsS/8XTxvcMGC6TqzYPRbhLdeDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 2:57 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH 05/11] drm/amdgpu/mes: update hqd masks when disable_kq i=
s
> set
>
> Make all resources available to user queues.
>
> Suggested-by: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5abc1ca0fee98..971bf01fe46a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -120,21 +120,21 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                        * Set GFX pipe 0 queue 1-7 for MES scheduling
>                        * mask =3D 1111 1110b
>                        */
> -                     adev->mes.gfx_hqd_mask[i] =3D 0xFE;
> +                     adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_kq =
?
> 0xFF : 0xFE;
>               else
>                       /*
>                        * GFX pipe 0 queue 0 is being used by Kernel queue=
.
>                        * Set GFX pipe 0 queue 1 for MES scheduling
>                        * mask =3D 10b
>                        */
> -                     adev->mes.gfx_hqd_mask[i] =3D 0x2;
> +                     adev->mes.gfx_hqd_mask[i] =3D adev->gfx.disable_kq =
? 0x3 :
> 0x2;
>       }
>
>       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>               /* use only 1st MEC pipes */
>               if (i >=3D adev->gfx.mec.num_pipe_per_mec)
>                       continue;
> -             adev->mes.compute_hqd_mask[i] =3D 0xc;
> +             adev->mes.compute_hqd_mask[i] =3D adev->gfx.disable_kq ? 0x=
F :
> 0xC;
>       }

Question: Why there are still only partial gfx(queue[0,1]) and compute(queu=
e[0,3]) queue can be set as validate?
Except that, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>.

>
>       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> --
> 2.48.1

