Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE929C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 11:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7845010E229;
	Mon,  8 May 2023 11:05:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE2A10E229
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 11:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5XWVuHQJG+WR+MmFqJcxW+pEsmN2Dqs4PAuzGnZ1aq4mGaSV70p30uoHkoaG5+DOsey/sC6WFrfzcSKox5kSTR6YGvcJdFPz8RQ01TpITRcbWhd9tVrzNke4xqxmi6KZopVD/Wa8mVq5DlFwJ8+Rq5Y65hieOyt6FFYIOepJd17BiONR12zj05SjbECcsgb6MLBOtf76NalfyVHxBFMeGEAY1eXO2dCQSHmPeGhQBglFok+18VtEjAdx8BFDOrkbOOWppQ3HRt6U2po71n6PCJeUB+LIN8SIAcQEFOSdKLgsrFS6x16HvAZtsscimQuQa1HfVyqJ+/1lDQo1tSaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lsiHxqh49RQ4KD+Di9sg6rWD77baYzHW3td9Vvp7HU=;
 b=kunsY4u09A89IjkuScndHW6a/cgrxrhMrUj/oQvmEQ7OGnlzZMTGpv+a7qCDSa7lRBem5LQAnSQnH88I7DF9HKjJPcz36+L1CF3QvjD0misYRqiqaXZnVD2fVqMoNxqL6BxkozWAEr3rFrA9RNLnfP6lMyi+gdRKa4ukxoIDZg9YqG6y4X0Nps0uyE8bZAP/f/+CZgF0/DpuDd3j6HNVJ2C0utuQY8uVa02kX/lIafmldUH6IDgf4PqqhrtSNs1YV2ln9ryjcI58upXRzHCjcqL4ZSF2iywQjkv9zI47kreHwW5UI0hYaBAhuGztv1MPCRtU/RRcht+I2xFB5PwpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lsiHxqh49RQ4KD+Di9sg6rWD77baYzHW3td9Vvp7HU=;
 b=mlnqqRKx9jaow2vEQyTMm5iBmxgk4+zFFYlzEDcKFM8+P6KZu5rgGhXtm/n1k9qfUfg2OmDnt94dVgu62N8Fg8KNUi2coLw/YU5u+40FWPHTiIK0Isn0byNkS8k4UXJV6BoT1hD+koRGwyuGoAdOZ3ROV32hSIaRcWsdLt7AlQU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 11:05:52 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:05:52 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
 jpeg_v4_0_hw_fini
Thread-Index: AQHZgZas+kmRp1hcDEy7APNuDQGvNa9QNseQ
Date: Mon, 8 May 2023 11:05:32 +0000
Message-ID: <DM5PR12MB17705E6C9957FABED1BA9765B0719@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230508101931.32544-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T11:05:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a490c4aa-82aa-485c-bbc1-c470b98a3163;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-08T11:05:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7c55edeb-c54c-4164-b69d-7c9cc5752fb7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|CYYPR12MB8702:EE_
x-ms-office365-filtering-correlation-id: 86c9a8cf-b43a-4428-50be-08db4fb43001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CN09Uw3kCFvq9akoUizta7yXq2Z4Z2c/u7ZswIVDLTHXfkYvZsVqFmy9D60S9TnTX3U1sHV0MPlDE187avGBk8X8bJClub9+O+b5KgTW3ZCfvouWJIYmv6htyzdqoH6J0V5OjS0SIAXfoU8nYdMNagnTJGPh0KJqwbk608rVD6LYdn8B5mVamZBn9XMMfSdmhvyXFMakg/L5p+1fmUSP6jpyuplkySL8pfBac2HAiF2lpTW+GW1JvqM2ziXW3sRMfdayV3XMKRQ7zEFP/M1lY4NpRNmruAnNSBPIU4Otnz4UnyGrlGECdxsy0EpR1XNMW9iSaxaGv/AwxB6lDiBfiLo/GEqHuTHtOZDkuzWFMiN3ijSh4k6M1xhAZDalkGxKg23QttYzgw0/yTzblsFQ/DAu346l8xh7dvsgUxbG8bYASaBHDrMQxRe2YmxDve2V7l6cUBwsiAXFAv+jehrwclgG8N+9TaRVVzHMVQmpYC2auyR6AMfQwlZK9bGUjyaLTwT2Cnr7u8Z+7wUbVZ3tdXvhGTcJkk3m0CEBCP9+CMb7m9g9DsSt0JFf4mpACyN/m8Hy+gyv8PjqruG8PP7wi6JQBws3gqHsV3hPTolu0z39Bjmd3nZ/4DhX4N9qNpS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(76116006)(66556008)(66946007)(66476007)(66446008)(83380400001)(33656002)(9686003)(53546011)(55016003)(38070700005)(38100700002)(122000001)(54906003)(6506007)(86362001)(110136005)(6666004)(7696005)(186003)(71200400001)(26005)(478600001)(2906002)(52536014)(8676002)(8936002)(316002)(64756008)(4326008)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0ms9n5Sq8XQqQDkxbtScETcLDITtqS8PTHkCsGARl8qYDu6JA+C1WdLnRsn?=
 =?us-ascii?Q?Y10yew+DXVo1xVsGypg3skw3UUQ7LNPeKENlhwPQwTLYwJu3dKGNbzhMneqP?=
 =?us-ascii?Q?I10iS4bCnlVoB0evws8HyaGXBpgLrv+dIloKrY+72WSJw1H6ANeVcibKfJWl?=
 =?us-ascii?Q?g4jXv7fLWZB1IFTSNqG9of4ER4g7OCRbacxC/LDknLCNJuTDRE7puja2/sTo?=
 =?us-ascii?Q?KF/vB2/qfYGoo+hLNA49DMG2nOTiTqTqnnYU0/7HICVNlOQfRLs5dRwMvyIQ?=
 =?us-ascii?Q?Gejia+PdatjMred5d7+8HaB+ES4JuEgqWd0KPjvN/6W/fDz4uJEML4BQDbSX?=
 =?us-ascii?Q?PPPiu1hfQhnUJ6xhk7ZLBE5bSExXi+6wGq3K98Vm9fOj8Qhooil51It1ZVWA?=
 =?us-ascii?Q?TJ1AWYRpMhvSJfW12BvzJvP6h3hiQrAgM152Ap1r+LxcSbaQsFuS/n/BI4k7?=
 =?us-ascii?Q?EYoHmsQRzQk5NaGy40VP28LtokZthwgs8aIym+kKRvQMGK7XPFqMcmq+14/y?=
 =?us-ascii?Q?p0Uen0qA/wpXRk8iYw8FLrxTXBnUY001vmeDq9h+gNpCv8E+yH/ZkROx/afe?=
 =?us-ascii?Q?wUw9X+49Wvl/oYhS4gwavPpY91L3qN3AsXc4tnsASJAuF2H6x9W6ntCkLe7x?=
 =?us-ascii?Q?0x8/PeV43APF38JYOI5eltoarB1wwrnnDe2DQpgcXC4N/ZgWZQN4h5GaZ4QG?=
 =?us-ascii?Q?ZTeIT2BzbFvT6cKKvoTlUc7TVOugLxLkCd4l/4RyHrKb4xHyAqTQPjvALxO9?=
 =?us-ascii?Q?QDpPVIzSTkieeQhSZhcjSoHo9kIY/684yP4Sv/hd01w+9PlOoWYg9OQXclBv?=
 =?us-ascii?Q?ekVdvBOjYTJotpBsuwy7iMrHOqJU8d/EY9AoQGqzrlkY13l7u6TufJgkzMQn?=
 =?us-ascii?Q?pMI3xSCdKyCnhE6eo160Tzek0g3qDbxwvp2f7tsW+MsUVHmLA5DaVrsxscek?=
 =?us-ascii?Q?zu0moYe9L7n0hrznRGDHf5eAyCtvJp1OOSotaaiJX6ykH4w5xQW1dVbb74m2?=
 =?us-ascii?Q?78xXM6XqPuf8pRGx9apvRGuFCQ2NUj3hMRq3i15v4kH1omx0cwMSJjK4Lpmz?=
 =?us-ascii?Q?Junr1Zxkz8g7Z7ajApBxEQczTOkhaJMxxd2V9sEcAp7gf8fQJ38Dm0U/1sy8?=
 =?us-ascii?Q?aN/8dGso4nHn8+RmF0P6HrFTVmSuKn9REN3f9zso/AC4uy72SF6wi9PBiEip?=
 =?us-ascii?Q?+JOm4ShDOuqv5V6ufVFH+CKxD7O0R1RTZ/M/bOsVAh9YKunbYQg1r+qGqIvZ?=
 =?us-ascii?Q?vCINjm68Gj6ZkKPvpcqfQ1vsAaJ1zYZBzdG3trl1IlWuk1rcPp0XZJOqBlIe?=
 =?us-ascii?Q?eHoea8OqjEUEagdjanA++1kORxVKKS2VSrLVmH+fVZrhLOFa/VcAywVWs/q8?=
 =?us-ascii?Q?pAVNgqizXthD4VRvCkxg1Mltb64GsYXh0b5BJhCIJ+vm+G8ePw+JYWgHC6iQ?=
 =?us-ascii?Q?HKGW0ujEUf9S0a6MVjsMVY1YXFB+NFrjxaVA+tNXcC91Ul8CyIeY/hisX8TC?=
 =?us-ascii?Q?WD73Cfb1E86xVlB0uYO8GuK7TLUreZHRKBEEEHOb0631ztUJg4T3qDG6AM13?=
 =?us-ascii?Q?BmDD0MzivVKuQPWMQjk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c9a8cf-b43a-4428-50be-08db4fb43001
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 11:05:32.1351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqvVeJgsDAVgIQ/4/jyzw92UXfRF/e/Ab2mbmUkeN1ixTkkmjGpck1a1mHOk+AzQ
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Monday, May 8, 2023 6:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>; Liu, HaoPing (Alan)
> <HaoPing.Liu@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix amdgpu_irq_put call trace in
> jpeg_v4_0_hw_fini
>=20
> During the suspend, the jpeg_v4_0_hw_init function will use the
> amdgpu_irq_put to disable the irq of jpeg.inst, but it was not enabled du=
ring the
> resume process, which resulted in a call trace during the GPU reset proce=
ss.
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
