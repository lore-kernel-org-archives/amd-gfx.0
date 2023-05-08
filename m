Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E423CC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 12:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB4B10E265;
	Mon,  8 May 2023 12:31:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3A410E265
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 12:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INsepl9QgV5y6E8D/FFMEUXRSzH1mM4E+hh/OT8rYvPPcBXbnLzVnaGQHubkjgPlVdLx/Rqte0zPOiD3xzFqlDeUn2Lj4FQlNUcEr/d4onNqFHdkyziDKyG7xco+sbao+qXr3A5Avpmaowouu7SmRfmdKEktjEV3Hyb4ckomywu1a1/nN+jok5HuYmLQpkZh9SM1md8zKbZ/aDEs/a55QlzbPPFYF0K1h0Nukasm1Oa9T81iiAEVvgZfefh6q5ePbl8dO6D77kkyNZZWhFB/RR0AcVk3P57PKoJB0bZw72vfTu5snRlmFBawIm6O7qc3UCDJfp9ozaxhzyWMXKt2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yikJEcnLt0XJF/L45VTfZKzrjOp7l5XSQBpJG3VEZc=;
 b=BQwHgCcZ73fpxgDDqBTJqEh+q1Ee/DII+XqSWvORpuBkK4aBQGj1Oq4OjKSGhf5ElFJHesWjXEIH1rHF1Dp/UNckSpixFWEQbkK2rOz7TTdcVCZ/ULahcULKxLdTKgyzHbShxIQ+TT9jCzDdixPCDwfbBXxSkUnLy892RoX+DaBnqJdYWdMDogp5CtkXBFr/bO6WD/8KlH/tGHPMkycV3zU11dTdWr5antG/LQilh9EonuiB2OrouIwzVYRGCQd0FmtKyrxjzFIxATwvxH7iglcC7+grfGFSuaXKvH4tlWax/KML51vqyiQUo56styXizYUvrR8CylmobyIFAGyDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yikJEcnLt0XJF/L45VTfZKzrjOp7l5XSQBpJG3VEZc=;
 b=ZPvNWxO0CT8PCfVJe10y79WeXOOpZAB4srcapPkx40XkibIhO8KLbKK2TEIJLzsdely6F65EOryl8mvIpaBvi8abUQYBSPMeLEcU/UJ+tNE+asKkaBBKrNmql/Cg8wqcjTJ00JVksRKuyZFK7XZv7z5YyvD0S3aE2y+Yz2/R3s8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:31:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 12:31:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Horatio"
 <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Index: AQHZgZasZrRwdOnxbUWSv4+E8XTEcK9QNtUAgAAXeOA=
Date: Mon, 8 May 2023 12:31:52 +0000
Message-ID: <BN9PR12MB5257E9F12A8C0FC2CF8B1A5CFC719@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
 <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T12:31:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a490c4aa-82aa-485c-bbc1-c470b98a3163;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4408:EE_
x-ms-office365-filtering-correlation-id: 50fd3674-b327-449d-d3e0-08db4fc033b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1T/t45VU81CfW3SkGeEj1rrHKRws3KUuZktQ5U4h0DnzCVP5c6l2fkeQs953r6/ibAjfdg9ncDBhu+chNLnCnrzaoOSD/MzpEBQH1jd6B3ylOmhCFNMzIeIPMSTB6qbh1NIr2juMQ8Ku815V6uiPqXXy+t3TGE/0qTiKuXWSuxF7vBbSIUiV8nTAnPILXlYs7mWHngL9haeZyQLdv5Cx+I7dcufLeMqTJqYbWpj2qfw1zrR812KlgPND1K+vtiRHn3eR6IPfcAmBkCUYstMe2MppK5TP7TO8wRyo4Xk08brrUPOk3J2Z0CfOlfygYcC0rddlwXJmB0dhNjL+qvqPjCXNrf8mmnY7oCTpfssuxEqspKSy1vanUVwS+gA+b2mtXy21ZtU1u0/og7v5SxN1fu7UOtATxhSNfxYIEWGD9Xw4J79ArC5/bkKUSwuDdufadR3/DsfxLkPT2DX/OC+G6ad8K3eu4bsarE273bwQbjA4H2pHbYr/O+3PrNoXd3eNdtoDdDLxVNPjej7AzmZOVVCM/xwguO1MUFL6em/8geMSRc77aI4cI4wPxtpxmL/KqH2dNNURHZaKdgXU1snSmEJ1OQo4PWqH7oEektdDefZfpWALmRFIGaqs4BhQZ+Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(53546011)(9686003)(26005)(6506007)(7696005)(83380400001)(55016003)(38100700002)(33656002)(122000001)(86362001)(38070700005)(186003)(110136005)(41300700001)(2906002)(54906003)(5660300002)(4326008)(64756008)(66476007)(66446008)(66556008)(316002)(8936002)(8676002)(478600001)(52536014)(76116006)(66946007)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lnaKWNo3Orki6DIZpm9MV/hYHyijMbfsY49H7DqDw5ENTHzJeOs7HMpXHROw?=
 =?us-ascii?Q?Q0R3nfBHztnN7Smg1xq7xFfRHSHbTLXV315ku4D5v7JmUrENtnEtw9NHn39L?=
 =?us-ascii?Q?Ts1cJ6KE4VpFO6zOoCvJcKwi8UXWzZ8s5qysCwAO9JE019fMEz9KpPWH3H78?=
 =?us-ascii?Q?pWAeUgVK1IXK0WSas64TVPhTMWVX+sZyteYFUhnZf+7v0YYLTGrdbAL8jKjW?=
 =?us-ascii?Q?mfhBJY7B2W1Hd/4vk1Un4AHPpmn7T4s/oVZSzRv0bqLwxFO0PBPOqxf08sE3?=
 =?us-ascii?Q?cKCpP+lI5F2cd5iiIlT5CR1P/zL9ICRi48dpnDO3eo9awP+0jmHM0H5z8jnl?=
 =?us-ascii?Q?7d5ConTIh/HeawU45juZlnXkn1mYexNQJqbC9qo/FIZiCQj56rtjM1qdD4sI?=
 =?us-ascii?Q?rk40kkRAtJkziaTISueNWuNch9tOegY4MeWCFhWXtmPnNYafQFafHRJuyv+w?=
 =?us-ascii?Q?lERMT/h2jl3Jar4EP1a6WroQHq85JUA1MMoluwVkbMrd0KF/HCnm3oIYqrmq?=
 =?us-ascii?Q?06tjTOxkj6GF+ACZwgFZaCJP+CXjbf+rzKf/bKAMdtC72uVf0g2DigMJ0jWm?=
 =?us-ascii?Q?YMdds1p1lqYqAkqtE4p24EZaNr6NdwoZOUssSeAvI+yxIvSlnS6Dj0HaLbIh?=
 =?us-ascii?Q?6taikuM8Ny0Rhb8zvHK8c2kKTWsHpHwVOY5CEOmR5UbtS8A4BAvwbR+AHGHx?=
 =?us-ascii?Q?jOHsO7zlY97E3nUjLEV5fNVCGbMXAzYH9MBeaJDMdx/bJNucIIWiZXPc8Hwc?=
 =?us-ascii?Q?c1DSvvoRblFRquFShC1YrUmUP+WsDtPP5zPiDV+Mo4USerJmy9t4lGUj2+4+?=
 =?us-ascii?Q?cbCt2vsiwmCofaUixB7zEfi0ocIDZkstaKpQYIBVfdCX2qS95kyjJ2HzuxBX?=
 =?us-ascii?Q?J5Ab/jhZqlJ/wVj//QixiDHSc5F6mLxqYp1wM+KT6BYKKbKZ7aNtVOgjbsoO?=
 =?us-ascii?Q?ZHBuUMiOE9HkRRm5webrnliwcX+s6bNq/sju6nfrh/TJnITfRbyMz3lDaisl?=
 =?us-ascii?Q?1E3kWLRJDprdPpYWvVhzQLhuLPAo5JWT1wsNfZX5mh7Pw+OH84rkUmDOckqN?=
 =?us-ascii?Q?VH6TNuBnUOMe6kaBv9kj+w6t9UC0y7VFLeOEQ3bV0NxKrvvcAM+rfWpTEtR9?=
 =?us-ascii?Q?PIdQ8nHtW5G/Fd3LAtLfE1uahej1QVzoFQGfjuS4EeIK0kjxkeW8PLy7SPIX?=
 =?us-ascii?Q?OtpWX6LtsV49IR2ET81GzzNiBve8dK7+k23qpCNeky8yOAnSW1opuHX8sSSZ?=
 =?us-ascii?Q?tlfiEIR94Q57M0ddfvuMuGHbB2hti+Um21VPIEU4A+0MSXBmO3qj+zNOCgak?=
 =?us-ascii?Q?slm8gML0jwC3UTNj+F6oIA9nJomtxs8DVJS+8GzmP/+u2xVEX6/WQ4S5U5sj?=
 =?us-ascii?Q?+ftGMVEGMPpENOGY8xdmykNvWnYia0NDH1Dj4DFc8wGdh2OjNi6uvL6YZYKk?=
 =?us-ascii?Q?d7BUS5tM5qxYn0vuoIp7mmq4UDiPRINdds+7erdaTP/5nCcza+UrJYun7dv/?=
 =?us-ascii?Q?ff29x23fVvchBH91Y59aOfD6YS/hJn3J16i0wMFzA6N/t2JiscfDuyd50l6O?=
 =?us-ascii?Q?l6qZ8L2ohq43fdtlN3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fd3674-b327-449d-d3e0-08db4fc033b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 12:31:52.2419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcUzFtRdCJdt7Ke41D/uu3aofuuFnHrFc05yuc/NuePBpIOlde81j9XZcF7FJ1o6xF7HiAypoYP7lU7/Qkxviw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
 "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Shall we consider creating amdgpu_vcn_ras_late_init as a common helper for =
interrupt enablement, like other IP blocks. This also reduces further effor=
t when RAS feature is introduced in new version of vcn/jpeg

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, May 8, 2023 19:06
To: Zhang, Horatio <Hongkun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>;=
 Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciell=
o, Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.=
com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in jpeg_=
v4_0_hw_fini

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao=20
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo=20
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)=20
> <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in=20
> jpeg_v4_0_hw_fini
>=20
> During the suspend, the jpeg_v4_0_hw_init function will use the=20
> amdgpu_irq_put to disable the irq of jpeg.inst, but it was not enabled=20
> during the resume process, which resulted in a call trace during the GPU =
reset process.
>=20
> [   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
> [   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
> [   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 0000000000000000
> [   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09:
> 0000000000000000
> [   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffff99b2105242d8
> [   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15:
> ffff99b210500000
> [   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000)
> knlGS:0000000000000000
> [   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4:
> 0000000000750ee0
> [   50.497624] PKRU: 55555554
> [   50.497625] Call Trace:
> [   50.497625]  <TASK>
> [   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
> [   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
> [   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
> [   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
> [   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
> [   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
> [   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
> [   50.498060]  process_one_work+0x21f/0x400
> [   50.498063]  worker_thread+0x200/0x3f0
> [   50.498064]  ? process_one_work+0x400/0x400
> [   50.498065]  kthread+0xee/0x120
> [   50.498067]  ? kthread_complete_and_exit+0x20/0x20
> [   50.498068]  ret_from_fork+0x22/0x30
>=20
> Fixes: 86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption
> handling")
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 77e1e64aa1d1..b5c14a166063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -66,6 +66,13 @@ static int jpeg_v4_0_early_init(void *handle)
>  	return 0;
>  }
>=20
> +static int jpeg_v4_0_late_init(void *handle) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +	return amdgpu_irq_get(adev, &adev->jpeg.inst->irq, 0); }
> +
>  /**
>   * jpeg_v4_0_sw_init - sw init for JPEG block
>   *
> @@ -696,7 +703,7 @@ static int jpeg_v4_0_process_interrupt(struct
> amdgpu_device *adev,  static const struct amd_ip_funcs jpeg_v4_0_ip_funcs=
 =3D {
>  	.name =3D "jpeg_v4_0",
>  	.early_init =3D jpeg_v4_0_early_init,
> -	.late_init =3D NULL,
> +	.late_init =3D jpeg_v4_0_late_init,
>  	.sw_init =3D jpeg_v4_0_sw_init,
>  	.sw_fini =3D jpeg_v4_0_sw_fini,
>  	.hw_init =3D jpeg_v4_0_hw_init,
> --
> 2.34.1
