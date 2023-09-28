Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2B2CE7AF9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 03:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4764B10E450;
	Thu, 28 Sep 2023 03:57:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1307510E450
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 03:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePzXhAyATORG1O5bSqeH0LyMjbTRawsulsFA61cCKwVLKHlhqH6ctkbzxZv8Vr3GwACVReu+VKhaK6YDFZ6Z84/8w8RIcTvoF50ZqqN/f7Om6l6TMCOu7Kw2kLPtJeXrHm/5r/Hf8RwQ/OCfLtxW9e5pwNur2a2OmS/UqspAHp2J/pVUmAZAxK8nfmolyFv/LQfEVUXaQElsTVTXEKev89K35k/n+G42w9IlCjA3ksN2p6JZAH5vRF0az+eiWLywOSyrYFZ8g7gUgyecWLZnLAkflhBWIX/KLaOEK63Cw2CGnDhV0hcYMC8LQCxFNqLmZqdpSiALTilaiOb7joTb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Rh+LoWIbTtuuS+MebipVFXt93Ufgx2nXeBsZiummM=;
 b=CVYd2KNeVtRB99ASVvEIr7rnuayGmwdza1Z8KxCrqWpLbiowgahw+3RT66iLEfZd8RM85u52KbfsSLEvMoDZYlQoJS9l7b7EaZtIm251yds3+QB0YahS+82TbIHO5A87EHFthu3FUDPqsYOvMXSXUKXAj1KCt1VPFI5htkI/ZKFSiySP6D/xY2GkNQxkL1ZTOb2AUr/Hum1qoPDDv8t4JgaoYpWPtDr/ZUFBWEK2tg/ioOH4amXHvQqx3qjwVMLFG/g8ybLCpY2Gqj2mE3306hbq1D4AUFg+qjfc0EP7NjQAq3WQMU9ntaBTRBMBQ9C6its7FyP56hct3hibPywC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Rh+LoWIbTtuuS+MebipVFXt93Ufgx2nXeBsZiummM=;
 b=VZbuczuiC79ONldkLpLtJOCxAdAFUjEIGSQA/RZyoyzftlzaqejFmUzzg1LHe60EHJiFYTlAN5AJk0MZbvNF88HWFwqf1l7bFHNEwDGwVNwY0ncaIF8c61nbE+m5awMhVZTfRywwXBO1RSJ+33ybkVRj1wAZK8ITdjqAToPA9/0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 03:57:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::4d4a:1407:b587:59e8]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::4d4a:1407:b587:59e8%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 03:57:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Skip ring test during ras in
 recovery
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Skip ring test during ras in
 recovery
Thread-Index: AQHZ8b3IGPXfKTdDW0yBqSBxWcaRRLAvnDBw
Date: Thu, 28 Sep 2023 03:57:07 +0000
Message-ID: <PH7PR12MB8796EDFE472E9DE2BCD72944B0C1A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230928034203.2171971-1-Stanley.Yang@amd.com>
In-Reply-To: <20230928034203.2171971-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=69bb6c11-2f69-4cc5-8179-1e7671ec9eb9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-28T03:57:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: f866b0a5-8b29-406c-0278-08dbbfd6fbcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJrBEe7v7baJBimwcsAQXLZjM3lM9E+LDbmCR0pTJHPIFoqXR0qKAXxhHFXb6kYhTDKkZjudaE+EVR6vr9tOHZCwqO3dMpWLm+tClFH+MLPEALvYynI2bC0Ll4MCbcCr8FOhmulnmX3rgeH+7EE6Fx5qfEsnxrofDlvlo6Awee4gZXHQv89GL2wIOHfWE6ZxyiJ4bSVSQr3xZU1XjfcFYkIBZeWAyTEi7f6XcQOVpU44Z/gzjlRv9GzHr92YzDxMfRXE9xHllMnCCQGgqLnkTC7l6bZbq3hCv4TUeHyoHntAUg1aZW8f6OrTg8XgFle1fC7w6Ne4I+2AnfRMhw5/tomhfz2a/UZpEpgXeZAofWmYKD+ghuy2PDuM0N091HsYJaikbDsLh5utIvgLZqTErABzTVwAqkHLP32YxvoLaZrmhOHbN+kF0g8VcqkhmsdytQEAC4nrVHKPUKk7NA+nR52WCqDUWSd3TL58c3I6PWhUodMjQaTvm39sHlTuqBvhLXIqo6Y18kAVdPy/ZA3ImbNxgUf3+m7pB1pMc6GMVOGyGJGb3q8PqWSGCxAOGmNtaz9sK79SC1/Yj7PirbX9lR+0c4ZFOo8ODYMZ3lPcZevN5mXLA1Zht1wWA4DCuV/W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(52536014)(5660300002)(8936002)(8676002)(4326008)(41300700001)(66446008)(64756008)(66556008)(316002)(26005)(110136005)(7696005)(66946007)(76116006)(66476007)(478600001)(71200400001)(122000001)(53546011)(9686003)(83380400001)(55016003)(38100700002)(6506007)(38070700005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rXmbkMv2OOSWZ7wnzrBKMFfAaVGT06/xT0jsZOBVpuFh5SN0SSieAnXgJbIk?=
 =?us-ascii?Q?WP0pqM/3m9hKNDQZRBk/yraAZGnqYWtTbT2pfCwFPmz/bG7PlE8fSWmylWg1?=
 =?us-ascii?Q?UYrSLAr15wupehmfdZ1YwWLxpxmGHzESRI8MfHRZI2N3erkS+r/q+yZpFS3u?=
 =?us-ascii?Q?YS6lSSj5W4ly2mM1aEc/atkDYZ0n/FKUJNl9kWU6MR44WhBNgFpCQHDUco4I?=
 =?us-ascii?Q?MiDqI/Q8t08ND5rxDtKqiZ+4zLf4cdDR/hZwpx5Eq7NJWJQ28oALh7ArKaaa?=
 =?us-ascii?Q?JKs82EUVP2KMucrtAIEElOieHk5tNJRv6zuHT9nSseKlK/N1NZQVmuPrfkLs?=
 =?us-ascii?Q?x7tzDShNrXM2t8Vk7WY2FvFG6Q900Q5cwRr3eRNKReEKkK85GkxIHgYoumYq?=
 =?us-ascii?Q?0leBGuj0Nzb1JyHiE6s1Mz6hnFdKwQ2z+qKWScnt2mjoHsV3HuYyz3r6aDoB?=
 =?us-ascii?Q?3TCr+AoCA5452S5cDDrD3msQdcNpcIpi2+T1Rg3dM2kTXYdYuMJy8A9Z3I/a?=
 =?us-ascii?Q?vayEoNX2L7u1eRkHpBSkvrqQwFdfvHZbVyJZ18uQ9ijZ5QEczmBtj804oZBc?=
 =?us-ascii?Q?X67Kl5xvVwul5eDTxGPgsGigIP/fo6XKfKqz5GUlak14n2ztd1wsuVLE/9JG?=
 =?us-ascii?Q?bi9PV1SeMDwkWPuHs7VLhq0KrHfEdQvyg/RHp4H0LJMCBG5Y9K5r8kGUHnFQ?=
 =?us-ascii?Q?iARXN79XENAft6kTZCK8G6rua+KFDVoaMRkDMMccu/zlknnU0GpFIsXufx0b?=
 =?us-ascii?Q?YMSncCWfVVosF2M57YaAAuyBYEOwtcHnn7koHguriSWNkzL3QSR+6+suNr9L?=
 =?us-ascii?Q?WM+1BZBb+BZIlalNOOlHSZAYMSkDel0EBRHTPxU4f228dWBKg0WNWDYH744K?=
 =?us-ascii?Q?4B1AcMGYD1xjqj6o19rI3eCflzpQ8C7Dl742UvURQN7s9nJ/F6Z3vgfJnZ09?=
 =?us-ascii?Q?qO1/YsM0Wfc68skwo2Ns58plXms7gjJtS8QMekIPOtB+pQ7HsMkiTf/OkEZf?=
 =?us-ascii?Q?7tvn+Hglk1uTx8Escqqgbwl156xNAdp1pXLIaqoiddphG86sWtMScXAtIfj2?=
 =?us-ascii?Q?hyilxk/LADCdHJWhiPueu8KSexLkI4clVuzMhn2ef0Pq78R4bqyqf8TPXW0Q?=
 =?us-ascii?Q?QE32Srrt4XPW0uSHAhv04z8qRj8+3O+kfXTHwmu9pkWLGg7cRCABtwJoYGI0?=
 =?us-ascii?Q?lUbYMO03G8v9NjnXejwjjNSpn+vSOscIq5LRDW/bcCCeb7DcLEIGRaHS/uLe?=
 =?us-ascii?Q?3cAt/szKsVl7SyYWAUBy1s5LSFQtMScxQ7YX6Qpd6og3eKTh9ciIMi7nrM6o?=
 =?us-ascii?Q?7ppbypoMYj5XUSqQMjr10B7BHu2XyT8YYUzpQ6e0TE8nmtcZmdcS1Nh/6MhS?=
 =?us-ascii?Q?TQM6y42FUnaYpmrGNtkt1i8D7J8DpgcnwDSfrCJOI3fDekqEKFTNZT7sKFtR?=
 =?us-ascii?Q?fDGu1TMRrQR5xOCk3NGInvjH5ApM/MH2uDfAMX4XqIMsNE/4e6VDMcWejvpN?=
 =?us-ascii?Q?Hwj8hoozNc9he/ZSzohbFuJfxqcSQ+QYKVxjhUg1/bbZgnnk/rrnjdbQz0Wg?=
 =?us-ascii?Q?fKC3YR1gcLEQmyTEMpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f866b0a5-8b29-406c-0278-08dbbfd6fbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:57:07.1109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imYYOb2jwdZm9GiJHw6nxU6wBNdxYD3VBDA4rTkv4EHCifPFZNvY3HdaXlLe8Mrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, September 28, 2023 11:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Skip ring test during ras in reco=
very
>
> This is workaround due to ring test failed during ras do gpu recovery for=
 aqua
> vanjaram.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index fbfe0a1c4b19..9fff58d073a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -248,10 +248,16 @@ static int gfx_v9_4_3_ring_test_ring(struct
> amdgpu_ring *ring)  {
>       uint32_t scratch_reg0_offset, xcc_offset;
>       struct amdgpu_device *adev =3D ring->adev;
> +     struct amdgpu_ras *ras;
>       uint32_t tmp =3D 0;
>       unsigned i;
>       int r;
>
> +     /* This is workaround: ring test failed during ras recovery */
> +     ras =3D amdgpu_ras_get_context(adev);
> +     if (ras && atomic_read(&ras->in_recovery))
> +             return 0;
> +
>       /* Use register offset which is local to XCC in the packet */
>       xcc_offset =3D SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
>       scratch_reg0_offset =3D SOC15_REG_OFFSET(GC, GET_INST(GC, ring-
> >xcc_id), regSCRATCH_REG0);
> --
> 2.25.1

