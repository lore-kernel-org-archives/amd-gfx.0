Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CBC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 06:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FFE10E2F0;
	Tue, 16 May 2023 06:31:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BF310E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 06:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXx7Y0N4F6IymAL7Co8tgShjHOa7XMv4aTMtgui1vo9nVbAP07ddGlsL95N/HeMiqS+byigF478Ig9Qc5LDkYNwoi9uYgBkSrLjHMC7J3vla2LlwzIV4xs2s0p/+k3YjKbK12lL878znvI3StZiWlNezzf2PbrdnDhnQ54iDdYc0q8CqcmwMV/ismkbNZso1I905oqNZO9xgY/hcIsRbZexgX4zC2zQRUMi8/50tSBQ3LCoNP6MIDJB/jCCzjQwKxi7/ZJbIsLp9N37L0L0TQnSaOKBqi5pF2WqfDk6eDuSBEmLM4vfI/Q6AwBXxFbZp2iv9mejZGF93L5aNwvdScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vPAD9zaOUvF4HeDfjOpbu72K7iDKT4myePTrT814hg=;
 b=HSOiTc48lxtFZxjWETqirAbN3Ly8Kxe2CKB2ynhBendm0Z4N4ZiYG/gUiAERK8dLdwhyQxFnQcdOeXaaKUE2TUj+KIjxFdIYqyQhUkvNTSrQ5jC3bE7i91+SAgzlqb+vjL0Cr6C/EDWaM9H0+NEhuD160878Wi3qrVxXK+ITSdFaPd9VDEBLs2tg3rsCD2aB5bWvkzn06PaINfXCpcueuu9deUnw8haHqfv0cyg9kQ1dE3kpXacftttoSRe+zaGVxspni+h41/B9CjmJgrvMetimdQK+QnktvLMUGZuO5VGev7cA5AZ+Iocfow6Htp/Umw9B+CoptM6W2MzcLZjSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vPAD9zaOUvF4HeDfjOpbu72K7iDKT4myePTrT814hg=;
 b=EFzLN2wFm+fsktGMIVktd8Gciq2bcJVEo099qBk48Xv7WwqbpqjnjSLM0ONLXAnofYcUc/akjlfD3YPmfDRer4av2FPNAkjitEaK3BdoDVeK9VSm5W15b88Mp/rp/+pcqXASLD4iW8GVsnKnneXSDHGSQrygIaEJoxzOOmiVy1I=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 06:31:09 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::3924:20cc:a172:3643]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::3924:20cc:a172:3643%7]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 06:31:09 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 6/6] drm/amdgpu: add RAS POISON interrupt funcs for
 jpeg_v4_0
Thread-Topic: [PATCH v3 6/6] drm/amdgpu: add RAS POISON interrupt funcs for
 jpeg_v4_0
Thread-Index: AQHZh7Pwmu5PWOmqLUiFQmOe0KXJPq9ccHtg
Date: Tue, 16 May 2023 06:31:09 +0000
Message-ID: <DM5PR12MB1770D0F25E66261582B46BB8B0799@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230516050358.13095-1-Hongkun.Zhang@amd.com>
 <20230516050358.13095-6-Hongkun.Zhang@amd.com>
In-Reply-To: <20230516050358.13095-6-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-16T06:31:05Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e83c78c7-3e3f-4b23-9431-6b5109f0ab2b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-16T06:31:05Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1f1c2763-cc5a-4369-b574-d3020e4a57c7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|PH7PR12MB9073:EE_
x-ms-office365-filtering-correlation-id: 96ae89d9-e386-42ce-0990-08db55d722c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH0k1S1dIWaMVOD/ItpACQGimJdihVuj3fdZiClLOFUy3v9idZVUgYCxQee84gRgrAS3CSUZvs8E2hEC8B1SQQa4nUJizWF47bRtJpW6mzyPg7fLECIXF3WVh2ylu2FUN8851lcsVFo8k/O++rTVvurm0LG09YtgRGGNIqI7X2z8us6bKhsNzToejCbazwuNTWqtd+j0JagY93sqnQECx9hVE2h2imDeIa5ykom56TiJXq4nncqPR1TOkehtTma8HMUEVixT4JoT3w01vDAI8PvcaGu71xZwVYQm7qaL2fcKbxtp101RIc1nhNjvntGlkx7xtErpxJ21greRt0gQK2T9vC4VGKo8wrXVUkJP5BYU8mTErnVjzdeTuzpL1+CjY/YrPQbIvMbxe4nkEytDeTGl3EP1H1amZW4CTEU1hgfkxqW7+2Lq6RM23XR7hCEHETVTU6xoJiouKFUO3li6BaLQzhAev9YeCbrELv4VtyaIezcuGlKoeeXsFA2A8dI06sqvj9Z+CUwH9MF+a0f3gfRXAS8sYkUqKGxaVYSMmAEPNTqE2GTa6jDIBrApJnW5AbS4EKfbOORY8C3cqbSK9fmhScaTr3RmNcVWMETSYuVulmWP4X+721AA5nSHpdB4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(71200400001)(55016003)(38100700002)(122000001)(186003)(83380400001)(9686003)(33656002)(53546011)(6506007)(2906002)(8676002)(41300700001)(52536014)(5660300002)(8936002)(110136005)(38070700005)(478600001)(7696005)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(316002)(54906003)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SVGmDeWfId81ElIUmGOCnc9pIKRi0avQTHuhq/k8MYMJi6ZAV+Bs12BjwZdY?=
 =?us-ascii?Q?fgNqKz8LDfqaZoHAmwWJokH0yZz+E8gjhdzKwoDVtiTQ1l3hUJhWxpJsxozH?=
 =?us-ascii?Q?Sj4Kzg2/iDQY2pSk7gCQjOEnS3jSm7ogLj6qcrhlN/6PR7bVeiqtxDoxUEMw?=
 =?us-ascii?Q?IO0OopNcWEutYlMSw3eLasZHzDL9wPrXyCuZMJE/QJs+R7EhjPtrGt0ygL2U?=
 =?us-ascii?Q?iFsKaYLfx+NjySXQ9loJB+aN1LwTc+du3qkWpG+08ucvM3/AICS4xLKiawnc?=
 =?us-ascii?Q?hZDnvFpfJIZh31p9NMef1VoLSDae/nvcPp8MR8uOmmqEeeqYwaOJELxPgG7a?=
 =?us-ascii?Q?EY2cBiTM1uRlfBh/kM9L8HTXjwySsXa7P5A7+pKzXR/fVa6CVLXjMEC3stFp?=
 =?us-ascii?Q?johvaidxTZ8vgesjSlhpkHpz2on6WY1YTnGtfhn4VIcE/Z8lArhCJ6e3VRjI?=
 =?us-ascii?Q?AAXiDQIfxbsC+LUVHQXK69ylAw4ZQj9TuTAGz0KqW6M0CMLoLJc8gv3raF9o?=
 =?us-ascii?Q?F7n2WxByad2WVHsJXmOO9jybvb/eYutUsDdqhvnyViLT7zx74b+gz6I9rF2z?=
 =?us-ascii?Q?6JR0n9yEOLzF2JPTUCEOvyDjFrZTjJb5tE0IpRXPaCWdCcqR3mVLb4w/YF3Y?=
 =?us-ascii?Q?Rmjib7rUSE5ouMYj0QyclYtrzIfmNCVBlR112VCP6O+nR6mJDqtKSL1swwFn?=
 =?us-ascii?Q?B8Ge1KZAqhr0Q3aavs0BsEn+2AkxKULAAEilF/gVnyPWEvpJm9UE7fj2wJuj?=
 =?us-ascii?Q?YLAysj7bgxNT9LmM38mksuiQIQ6l/KzyhbO0HDnDq24wyUphCMsCF1UxDAk5?=
 =?us-ascii?Q?ccW9AAh2D1E1X5xiUAk7yufVnAiYcKA6gpfa+dfEk0Aud1aB21A5ckj9tYqX?=
 =?us-ascii?Q?bhvulMUL22Mq2JatW61xtSJ2vvsXN4/xa8ZD4JIP9IsM8Diyf9JctlFDKdgL?=
 =?us-ascii?Q?j12rN7hrcrVZBAks6awEBwQP/fVhs554Wn2FR/M3UgcDVTORtY8lAZ6XIQUq?=
 =?us-ascii?Q?l3K8+NCvSFsyb0WFvE68uln3++TpLwTMJzZK9Z2+yFoPY21MLkPnNIEKn2Ju?=
 =?us-ascii?Q?oZ0k5jPPta1yfJo548uCOPVfaYeRhKM3mGGf/I1MpHJ8yEeejI0tPfTCtwEl?=
 =?us-ascii?Q?+k86MWuD894MpbKqN9w0Fgs5MAIckwxBHcwmsZO9nBzWHVrLHQHwjXIXCGPJ?=
 =?us-ascii?Q?S2cu2hkrbBazUNp+iKCLzFtwpW07Fkci9XOk1Smqsu0efM/5kxZQ9aiKH/2B?=
 =?us-ascii?Q?NZks2O1kePs/yHw6tb8ivdy9AQXRnYvWjpwaljutyxyxjqgvK0ICnKULFUVs?=
 =?us-ascii?Q?1hSEVr58VwmBl/1b9Ugi4QcMnrClLGaA1JRvAnF25oomHW6XblwTpoGhJm7T?=
 =?us-ascii?Q?lYHg07Ptk3yaDe+NDI0Xuke2vZeKu/U8nf0qMTILAjxxSi8uxr8cxUh5ErhS?=
 =?us-ascii?Q?nZfxxzCeVBw6xfAJgKaZyMscbxci555Z2zhFJQMqjcDOQ2hJYomTwE+z8YSP?=
 =?us-ascii?Q?f8Q1PE/ELnhCXTl3JQnFzZ7M9bKnzVo4ikhryWk6omiKL9pUebv7WWDVeQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ae89d9-e386-42ce-0990-08db55d722c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 06:31:09.2454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5df1/70ZG5zSKfUp2nFm/r02jbgWvW+Ldc4GMLgiiyD5RmZu5a0oh1tXgELR2Xw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Jiang,
 Sonny" <Sonny.Jiang@amd.com>, "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>, "Limonciello, 
 Mario" <Mario.Limonciello@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Horati=
o
> Zhang
> Sent: Tuesday, May 16, 2023 1:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>; Zhang, Horatio <Hongkun.Zhang@amd.com>; Xu, Feifei
> <Feifei.Xu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Jiang, Sonny
> <Sonny.Jiang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Liu, Leo <Leo.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH v3 6/6] drm/amdgpu: add RAS POISON interrupt funcs for
> jpeg_v4_0
>=20
> Add ras_poison_irq and functions. And fix the amdgpu_irq_put call trace i=
n
> jpeg_v4_0_hw_fini.
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
> Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 27 +++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 495facb885f4..8690467b3285 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -87,13 +87,13 @@ static int jpeg_v4_0_sw_init(void *handle)
>=20
>  	/* JPEG DJPEG POISON EVENT */
>  	r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> -			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst-
> >irq);
> +			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst-
> >ras_poison_irq);
>  	if (r)
>  		return r;
>=20
>  	/* JPEG EJPEG POISON EVENT */
>  	r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> -			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst-
> >irq);
> +			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst-
> >ras_poison_irq);
>  	if (r)
>  		return r;
>=20
> @@ -202,7 +202,8 @@ static int jpeg_v4_0_hw_fini(void *handle)
>  			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
>  			jpeg_v4_0_set_powergating_state(adev,
> AMD_PG_STATE_GATE);
>  	}
> -	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
> +		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
>=20
>  	return 0;
>  }
> @@ -670,6 +671,14 @@ static int jpeg_v4_0_set_interrupt_state(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> +static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
> +					struct amdgpu_irq_src *source,
> +					unsigned int type,
> +					enum amdgpu_interrupt_state state) {
> +	return 0;
> +}
> +
>  static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>  				      struct amdgpu_irq_src *source,
>  				      struct amdgpu_iv_entry *entry) @@ -680,10
> +689,6 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *ad=
ev,
>  	case VCN_4_0__SRCID__JPEG_DECODE:
>  		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
>  		break;
> -	case VCN_4_0__SRCID_DJPEG0_POISON:
> -	case VCN_4_0__SRCID_EJPEG0_POISON:
> -		amdgpu_jpeg_process_poison_irq(adev, source, entry);
> -		break;
>  	default:
>  		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
>  			  entry->src_id, entry->src_data[0]); @@ -753,10
> +758,18 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs =
=3D {
>  	.process =3D jpeg_v4_0_process_interrupt,  };
>=20
> +static const struct amdgpu_irq_src_funcs jpeg_v4_0_ras_irq_funcs =3D {
> +	.set =3D jpeg_v4_0_set_ras_interrupt_state,
> +	.process =3D amdgpu_jpeg_process_poison_irq, };
> +
>  static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev)  {
>  	adev->jpeg.inst->irq.num_types =3D 1;
>  	adev->jpeg.inst->irq.funcs =3D &jpeg_v4_0_irq_funcs;
> +
> +	adev->jpeg.inst->ras_poison_irq.num_types =3D 1;
> +	adev->jpeg.inst->ras_poison_irq.funcs =3D &jpeg_v4_0_ras_irq_funcs;
>  }
>=20
>  const struct amdgpu_ip_block_version jpeg_v4_0_ip_block =3D {
> --
> 2.34.1
