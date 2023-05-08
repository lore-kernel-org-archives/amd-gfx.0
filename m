Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FF8C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 11:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EA110E228;
	Mon,  8 May 2023 11:05:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6201310E228
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 11:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUWyFx3IjB1dvAw9s9f9CQJOnG9b/lX/EjiD/P24bMh2rJCzjxf0w4/B/Z2LkmQ03NWzCmhIxOsj3Y5d5NYKxzsx2oXvbGzCkddbjcV55j8fSj72DXP5M7K+IaVoDDWd92A6iHEAX1s+WjHLIqEKdFUi9Jd+TDQsv3aufML8/lDeBPIhvvrNNNIw2Rwfr3O6KuOH32FAc0sEkyX0DSCq/TOa3JNgWBDHYi6T8BCqZS30UEFNy4rRfya/SEucE2ZG5kODv6Hz0Z/1idc7fOWbn5n36Zv1VRnpOgBpdXXN6oUe4L7BAPbAns9pL3yRz0sFJ10c3LRoA9UzVHdI8Py5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL/Y5gkwxmnGOst5YjVzumTvhpjxE28K1sacsDrYOA4=;
 b=ELhoG5zF1s39DMlrph7k+GUdNosUzNg+EOUA39ho51wuQlR8pzqFGsB13HaCsc1StEoblp3zsmHRKKHEiPF5ttwbtBK9uKbjAoL8OH9wrDxgM+T5pfeWXECMmyCWQyJheQoaDWYTYYBXZ4wNQeOCtemTjfz9lslfXtPZBhmcQs2SMLuowYAmGohEgXCt1349JJ+NgN1qblJ187t1II4J64KHtfCEu2BS2YF4F5sbzHHAhJA3O1zYM6+ZP1KLuo6iPiFs8UmuCAT6w5+34TS03sxeeb7RWxpcTAQ1fEl3K+kMW6IDXEPFLY7HA+6dzyxOIJqJpOAMmFpcYpmLCjIrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL/Y5gkwxmnGOst5YjVzumTvhpjxE28K1sacsDrYOA4=;
 b=Q3AYpAkNzvKycoAdQQrWmUP73GekY1nTIBmnM5H3CJps17/SfNVkvUb/SdZwFKywp+iTJBXY+9Mtaml9ecgU4eIX9v/+eO/UL5af1vtJ9sDQMgtZax5w7LYNn46mdYjfEBYvSa4cF309fVACZhqjvtlpNSx3x/vYYLIumbzkPvY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:05:18 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:05:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 vcn_v4_0_hw_fini
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 vcn_v4_0_hw_fini
Thread-Index: AQHZgZaekP58P4p1tE6kPhgqMFqNQK9QNkXw
Date: Mon, 8 May 2023 11:05:17 +0000
Message-ID: <DM5PR12MB1770ABDE19DAB199BF573ED7B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <20230508101931.32544-2-Hongkun.Zhang@amd.com>
In-Reply-To: <20230508101931.32544-2-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T11:05:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c83f220c-00c0-4247-afba-3455092b50eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-08T11:05:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fce7f834-442b-4449-a1da-e3bd22f2324d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|CYYPR12MB8702:EE_
x-ms-office365-filtering-correlation-id: 9aa8855f-fff5-435c-e85a-08db4fb41b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBF6NxJWIZE0wD/yfACvQF1smuG9S1UlpjrhVIy/PF3vQnpBClJkx6+whYCXGG47wRowVfgo/aMaui9SYUTrltDNlX/u8HdjjqlyKymVhATQZCTZ4YXJZz9j8mAcqVyGKrIx4oATSwkYT5hCPQuVnerugrsAypS46BheFITtemw5Yx6zg8rPUzpNCgfVDNPoAbz1zGGdFYY06Pv2iViB8Wr7vUl8WiFLRZ6z3RDtLjkQyt6XKt4kPGMANR02C3rWXEkg3pyeNcaGNUoEkcxO1c/5cwNcAwPMynRn4rg4i4hyej45qM9gDcEDCpwl6+4Ir3YrIW2jvGdw9awdLi+ZYMcFxWUgaok9OWVG387AlfVeGH29bVFQTZNtZpHjmawYU1SE92VnfegUzduzlmg0l2m1ibmEVdRmyMDSFkw95xa1ChDIlX3IqV5+VGS/1mLBWEZ/PZykRrV4wLO6tQ1x/jiF+GPKeIroAHLmlZensiYbmyLwsckjzSVd+DFO6A0XF5z9uO8g7zjRHxTo8z2RGuVlRGMlcdtp258uQuNqGmAR0nQaEtEnDH+y0+y1Jo+TljJJHYf1wviT3bHLsqKbcXnC4IyRZhO2CyseLSYgI7QxO7KLZmviFA6/TWYrdeAn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(76116006)(66556008)(66946007)(66476007)(66446008)(83380400001)(33656002)(9686003)(53546011)(55016003)(38070700005)(38100700002)(122000001)(54906003)(6506007)(86362001)(110136005)(7696005)(186003)(71200400001)(26005)(478600001)(2906002)(52536014)(8676002)(8936002)(316002)(64756008)(4326008)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BrnchichUIv4ZwaGKGje3H1y8rYgpgc9eqoK/gevrN2qM5cEy1RfMXKcSXkO?=
 =?us-ascii?Q?NfrWThm+dvPB6LVJ/dTEKC+3L/tcsDdc1mDtFZPfocWJAp2fUmT9c25fxL3M?=
 =?us-ascii?Q?cd3rYo79zlzWKVNKF0qzUIbuOPyQK5Z53s0PXKRTRagr1RpI3JiNmQ3qLSFP?=
 =?us-ascii?Q?m2jBooKZrhxQVyi9ly48ntEpTvPy9e4GbOH7u1WBRnhkTKkb5Fi+2io0vIOj?=
 =?us-ascii?Q?MlaWzvpTxGYGnWFWuhGoiIlNUpN+PMTetHGFzKfG/EQdnxhxApgqpOWVrrKw?=
 =?us-ascii?Q?KJgVP/YGYECzXCKfutig5QZ0GRTAWaPMArbP74QWxb1QuiKm0V7g2z9PCLmA?=
 =?us-ascii?Q?HFBGNmBoIVN5g407gsmoRiUCMTU9ZPBZ1Okp9+tE89x0A4rejyAGWTbjpWK8?=
 =?us-ascii?Q?76G8GCSHfeRkjJYZkpYBMvLvJIIN2wnnEgnpPWbnpxutLGvd9Ke5TFdI/4QA?=
 =?us-ascii?Q?g2HCNbLW/Q4nbvEyZYobPUG30qJQyQ28HiPGyGZ0if9S8CKJobdOhJWIMsZE?=
 =?us-ascii?Q?Qnst4XCO6hX7dpblUa8baA/pHYE4bHfBlZHaF1gl7Ou1UFslOlbl1x/4Lb8A?=
 =?us-ascii?Q?az2T/YRYGd4TnYTjohGbUOz+89eyhONAAEof1PtQUCJv0PleuC5WxaY7L1Gn?=
 =?us-ascii?Q?Bf1gPAiOFGyW0eEkTOtXGfphtQG2xx/ZHKoHgJE/KZgBXjFZC9YkmhAmitb8?=
 =?us-ascii?Q?xlrs/3arpNU6NsYKhOfIV5sy6lxCZF+TvvKrWxCooIpHeW3Yun6OmsuG2ZTR?=
 =?us-ascii?Q?sgHuM+L2FMUviY8BDDwNU6ijfnWLy1x7D2GDeGBjF9/RxLxqfI/poqP2yzC0?=
 =?us-ascii?Q?1NrIg5E4ERQR8D1Q7rbqwHmnPjVqLXvzfoQEKzuABRdqVQ4OVpCG72Y/sWWj?=
 =?us-ascii?Q?eCQVa2zTYc9u0NjArD2X4+Tae9tZ+53NPWoW7MFfkg8MJo9j/DJOJAOMmX4b?=
 =?us-ascii?Q?zpcgxibaiLO/VMLfbuApzO3IxpEZO8ssuV47MXL6zHYecYjKDLsLyEa875WO?=
 =?us-ascii?Q?w1mKB8xnMXTsZpdcSi6l3TBXMmw8K+8Ar74hlpuRoZdTuBviso+T7M4QlyIL?=
 =?us-ascii?Q?66mFG2uDQ0Q43Zg9wRxUFwlHAzWmklk0p/Bgx89bU1QD9dHNbxSvTokxB632?=
 =?us-ascii?Q?HFCJFW1xPvsssg0zJtiTSWngOyABCx9FxV/+2Ta0ZPyG4Hw5MTtToffNVCwq?=
 =?us-ascii?Q?EVLvdnrGzEC919aItynaDdraZZ0lrVctzeD29Hu8fZTi/fdfu4G/BMt5Hdsc?=
 =?us-ascii?Q?rsR2Oul8NHoUSyAzj4cNqQwn4AaYjX9d5idMC36dUyxqPzEgZnQ7YZw7W3w4?=
 =?us-ascii?Q?QroulNoj/C/gzDyP/MUMieJRJ4i0kZ4yRjJVWCg9jE1toy6+MzuTJexxa2/U?=
 =?us-ascii?Q?aJ0aEqb2gpLyKO0ArQ0uZ6nN8hbvdLAza91kr+gDXgPrajFQ7JOon/gd4Rmp?=
 =?us-ascii?Q?RVYGbWVMo5j2jQ6wYRPfPlf8hHtuBAF7BdHdXyoJ/7dyzxIjn3qCS9AWOqRd?=
 =?us-ascii?Q?njR3LdHv3AuTzokABByB8GvPhkCu7aj6DMNFymwN2gom7KT69+RckL4oYCjJ?=
 =?us-ascii?Q?j3am21NALKVDKZz3j4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa8855f-fff5-435c-e85a-08db4fb41b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 11:05:17.7201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMITa+pl6uz+I1x7z7wJgw5Cc7tzP8V/x9k1k23QQrYB8nWqlFIIuZkho8gJORIu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Zhang,
 Horatio" <Hongkun.Zhang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Jiang,
 Sonny" <Sonny.Jiang@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horati=
o
> Zhang
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhang, Horatio
> <Hongkun.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: fix amdgpu_irq_put call trace in
> vcn_v4_0_hw_fini
>=20
> During the suspend, the vcn_v4_0_hw_init function will use the amdgpu_irq=
_put
> to disable the irq of vcn.inst, but it was not enabled during the resume =
process,
> which resulted in a call trace during the GPU reset process.
>=20
> [   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
> [   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09:
> 0000000000000000
> [   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff954c568e2ea8
> [   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15:
> ffff954c568e2ea8
> [   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000)
> knlGS:0000000000000000
> [   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4:
> 0000000000750ee0
> [   44.563633] PKRU: 55555554
> [   44.563633] Call Trace:
> [   44.563634]  <TASK>
> [   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
> [   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
> [   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   44.564061]  process_one_work+0x21f/0x400
> [   44.564062]  worker_thread+0x200/0x3f0
> [   44.564063]  ? process_one_work+0x400/0x400
> [   44.564064]  kthread+0xee/0x120
> [   44.564065]  ? kthread_complete_and_exit+0x20/0x20
> [   44.564066]  ret_from_fork+0x22/0x30
>=20
> Fixes: ea5309de7388 ("drm/amdgpu: add VCN 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index bf0674039598..b55eb1bf3e30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -281,6 +281,21 @@ static int vcn_v4_0_hw_init(void *handle)
>  	return r;
>  }
>=20
> +static int vcn_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +	int i;
> +
> +	for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
> +		amdgpu_irq_get(adev, &adev->vcn.inst[i].irq, 0);

[Tao] we can also check its return value and exit if the r is none-zero. Bu=
t either way is fine with me.

> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * vcn_v4_0_hw_fini - stop the hardware block
>   *
> @@ -2047,7 +2062,7 @@ static void vcn_v4_0_set_irq_funcs(struct
> amdgpu_device *adev)  static const struct amd_ip_funcs vcn_v4_0_ip_funcs =
=3D {
>  	.name =3D "vcn_v4_0",
>  	.early_init =3D vcn_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D vcn_v4_0_late_init,
>  	.sw_init =3D vcn_v4_0_sw_init,
>  	.sw_fini =3D vcn_v4_0_sw_fini,
>  	.hw_init =3D vcn_v4_0_hw_init,
> --
> 2.34.1
