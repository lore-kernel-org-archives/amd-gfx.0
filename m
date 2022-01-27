Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3909C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717E210EE08;
	Thu, 27 Jan 2022 03:39:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982F410EE08
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwoETUqNsudZiBOkwHWmIe7WLJuQFUGUf5VqSPMbJqFUVfcTB7qhXl3h3vmwW8I3mZJsT3L6xUMQtNq+H7OF+aMhSDhR6LxH5UVxPTx9vqkgf2WpgBzwyfzVsxWO8wPyvKfjj5rotONTpfo0zIzAmxBd9KykrxRICW9Dsmgh7KkB6/V5IS0RKQG+R1VRbGDb2Fn3JQAsHKjgoS5GGCiYlKjVAgvKvU3tJZ1QP02QiZc4fz7tvH3LhEU5ueimoDtZfUX95MNHgD529SvpAELGAEzA5+jwz07vUQ7lVvUWK258W1MilgRaPO1R9F5e3Kv9xv78q+Vi09nkTpvIQtKMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6CZXIiChL2AnBgq2z2PEG87RW3rTOOg9sk624ovsS8=;
 b=CGY2sz80PARCPvgrWaFkpFd6gcM6USx2CTmXz5/ZW4fyYcWAD6HTkLn3BRdKj7SnYtz3dII6mUBcIQyUor2Iys74HFtxNmqRjkE4e7Sx0BFlnextNEYvtBHBXcIRVp2RFhUQHww23NqRDXKhc6XD8hI8goFwaNuehHftARmB4lj+0AGS1dLCG1CHejRU6TPN5ODv4MKPXEDWN8+TxaWShv8m3TelH2x/3S0FFyM7zSU4LZuwKHxIXL20AcLpFW8muGKCf8zinDGEfQb4BO3KP5Ej3qQLRn/L7SkJvPt2iZ53ZdptkWO4xWhT2IdOUX9PzZXOkJmthncw04cHEJhL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6CZXIiChL2AnBgq2z2PEG87RW3rTOOg9sk624ovsS8=;
 b=4rhZKH+mvO8JiUOg6ooiYMnGyUPGBH8QTnnciIUTZSVbejjzQRqDl+CuARl4fizXXCbuvnjpqrpnGkar+bPNRmr4Mfp8dhijRoAntNMRBOYNAQEL/m6EFVaXVQK5SeQlDe6KyLzcnk4qwMZ7HM47/4qapwpNjwYUEGSlCh46Z/Q=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by CH2PR12MB3702.namprd12.prod.outlook.com (2603:10b6:610:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 03:39:00 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7dc0:b85f:5c9e:33be%6]) with mapi id 15.20.4888.020; Thu, 27 Jan 2022
 03:39:00 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Topic: [PATCH] drm/amdgpu: Fix an error message in rmmod
Thread-Index: AQHYEdLUqv+l+snVMkWySvGKcSJw8axzjpeAgABPAwCAAL9QMIAAzHQAgADFr7k=
Date: Thu, 27 Jan 2022 03:38:59 +0000
Message-ID: <DM4PR12MB5294D2C47F12FC897406884295219@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220125100321.450194-1-tianci.yin@amd.com>
 <SJ0PR12MB54888020E0D600D546BAC634825F9@SJ0PR12MB5488.namprd12.prod.outlook.com>
 <b5fab406-062f-1fdb-832b-1ba0249e1e10@amd.com>
 <DM4PR12MB52949E3762DF92C8C747ED8A95209@DM4PR12MB5294.namprd12.prod.outlook.com>
 <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
In-Reply-To: <c7a7d79c-c59e-51ed-07fc-22d9b57c1271@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T03:38:58.990Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4f91b86e-4f7a-4785-34af-f1a6ab32c04d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b1d5cc5-54cb-4f8a-1f70-08d9e1468e42
x-ms-traffictypediagnostic: CH2PR12MB3702:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3702E9C6DFD8F94742D053D495219@CH2PR12MB3702.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90/IEsGNASgAn2mZSpb9mGHOOPhsv2XJMRUsHLHCmiN1d/WR18GidZtxKQpHq1jWEuprc5ig45r/8Vc4gLtzm4yAOlyYLw/qNHx7xnX7Kl1DA2IiHoDTaNQmm9kICJ1x/7eHFqOzvu1Gvr/jGnBmqRMLKtwkPhb3vHnAtZa6GeMN2itXWGWWyUQkZqEhs/hizzsDWSugMVu3fBGVvI3bjydxCvF1GKkZZS+qQmiEsCHHa7s+Tk8GR4ji5wIOR1DMVFNLBfzEJsSR/8CfN5TiS6DXDERmXTVSTcVVoGCcpBEvVFESvusysVACdd+QGGPD14NuHZ3hA4bkwsIrgMdV2o9jvvvr9MlC4Mkz6ENeUZgEgSYXNir3FEkhSfVrGQobpz474AGEC8faXS73c4bWUDRDjXZTXsOTJql5B2jNWknx25pIcl+S4v9/mODMC76eUhJuJJz1XJC6UWf9mUWk2jYBufDgZQURx/OUIklyPRmWkr8JHIELTOwxCeg7bgDQY2XoP/R2cO9aVwE0onVK3IK7otv71xibyahxfjE3hHDMEwRPlmWESkqFBgmWTnZfhXhj7Aujlt5Sxqi3WY6gxvIhivDT7tiyEP5UKV2s8mkMwlGp7U0KjoWRCuuBa7CBztEjP3Ix6ZXhFoo6IizNgRH5KXYqgMLQsRsW7DlQTIZ0AWi3uWjaYudP222aYWmV/RjxKzT1SVDz14QkgBXxjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(64756008)(66556008)(66946007)(38070700005)(15650500001)(66446008)(316002)(2906002)(110136005)(33656002)(8676002)(76116006)(53546011)(6506007)(8936002)(66476007)(26005)(186003)(83380400001)(71200400001)(4326008)(38100700002)(122000001)(5660300002)(91956017)(86362001)(55016003)(508600001)(19627405001)(52536014)(9686003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uoR0e9d167Rc14Cm9H6v17OkJ+7pzprYyaN/oiK+zPlLmZ0DNYloigLQuAok?=
 =?us-ascii?Q?5FCLJYgrLNgaKiB9wDPOWAp8PyZazIVcEOEHxkNjvlPJwrbC91l5wi2eLKqn?=
 =?us-ascii?Q?0gWzsC6YT3eg48W6WtAHs1ewTBHkerQvECIG6EnDvmUGyjifY6nDYEe8P55e?=
 =?us-ascii?Q?x2EJ9S4IUNETBpOP1oci66269ITxBb0J/9Kz/eqcioYUKlXRTp2EQgU24zlh?=
 =?us-ascii?Q?bDUSaGJwjcQxkSMu1FyIQUCm2noZdU7zSmPj1AJwYvffy/OcUTgGX9l2hz6a?=
 =?us-ascii?Q?VGCqq3TNZW8qSs6w1EZI2Bsf+NvGgYwfobh8H6ozp1fN7hPkgkoKyf7tvHqP?=
 =?us-ascii?Q?bruXUH6Cv8mPr6h8ZLGUV9MlIyVu1a4Ts0RDjk1Wp/2AkbDT94jKtCvYT+C5?=
 =?us-ascii?Q?3NhXUe4KqRVqO7z7LGZjTmuRmvz8rzd+C5FSQyetBDzM7nBMudWmd7LaOLQI?=
 =?us-ascii?Q?ehbLx9kPx4Oar2CKQpLAUzrKFtUQAh9SRTFvkF239h5mGcw7Frcq/KIZqd4m?=
 =?us-ascii?Q?8DxWjuPFc6epa/JGUfav5ebqF9j9XZbgu9G2RWH8l7kBkrvQX7a5EQRymqSp?=
 =?us-ascii?Q?qvkJoGgF130Ew3UGpc/s6/BhjsjAgM8Ub8E+xVzQaaO5cCiZwbV0gvC8dcki?=
 =?us-ascii?Q?h2CdPPv9So86NscsXjB885j4DUbYtDJHzR6zKG8/feGa+bmfK2uzhssoS9ob?=
 =?us-ascii?Q?bbePgbPwioZvQfoTNcYjXbiua+iM6r4GP0zBzvTXM8wqnAlAs1Ga3qKDYGb9?=
 =?us-ascii?Q?oWKHJP1VGLzvhiOdrOSy03hyarIxc6WpbyBoVp0BDeazYlth7AeK+V3vNJdK?=
 =?us-ascii?Q?SDL/2H/+/nbRMKnxx+YyA8mdhKVCobCvPi4AiSwXiaH66M1TwVjAyNnkw4DZ?=
 =?us-ascii?Q?keXJLUbJBioXaidFQ0tgP4rCMRBNkKTe9YgIPT77zPckb8MeoB6DQ+zUu1/P?=
 =?us-ascii?Q?znYpEdgqXB0RQe1ULOgX8iwLO/XUK38zLmWd2Jnql5cvpSB6DJwbYb8IkvHD?=
 =?us-ascii?Q?HynjBzJd/Cjc16OfuJ21EssxTePuVr1wd3nX4+XqXcAQ90hj4+QIwEXHQ9k1?=
 =?us-ascii?Q?IvUthTZTZm9av27+4U9b/8p3RTtEzyjEM9ygos08j9wmZxoLIwRuncl83EMk?=
 =?us-ascii?Q?6mXWjOFR+kySeiYcJI1RzYHMpHwHX0RLxTcElmhLSnQYXGT/9Z16x+DEFMNi?=
 =?us-ascii?Q?vJ4X2+9gSqELKFBIl38dpIEl7HirgREhbQtx+21Xt7Q+rsp12sp4v8GtYkXw?=
 =?us-ascii?Q?6MDZr3T90tXcVLtR86Kl7b8nu0DoKoprWdMymXidS/3nXmYyY29AVYfoZgPX?=
 =?us-ascii?Q?XERA5wZbTs6DFQ5iPGxjI7UBWvM+tNWHFkRnwyz0IgDaH+/6Bk8n0LumAskD?=
 =?us-ascii?Q?75AlIXdETc7IFdDu/HX4ceBj6pyf6o2QvNHZQxKT99mBwM0qG1tGXhFNhkuh?=
 =?us-ascii?Q?47I9NAr/0rDdUJf0fxgcbveiQnEgE2CCzysAs99vKWmxeq9qKMdLSr59mUP0?=
 =?us-ascii?Q?UAQhimipBue72jQApMP4R8Fu70AUW+KG1+3lo9mhPjVR4eKcpWTw7tMt+NS0?=
 =?us-ascii?Q?uSPdFstYbNwoyepqZsAPJZWdkWFRjYHu+0uDzmB3K+ANbFyXJsFPdSKQfMWs?=
 =?us-ascii?Q?04h535r9DzmN+Kx/c0JZvD8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294D2C47F12FC897406884295219DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d5cc5-54cb-4f8a-1f70-08d9e1468e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 03:38:59.8420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdhSQT1q+RXS0wJpvjDlQO+nj0KwSQlLeJtcuCT8GhiG1qDuDKGznDBsBQ/byk4We3hrlM991IIjYX/nfTA1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3702
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294D2C47F12FC897406884295219DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

The rmmod ops has prerequisite multi-user target and blacklist amdgpu,
which is IGT requirement so that IGT can make itself DRM master to test KMS=
.
igt-gpu-tools/build/tests/amdgpu/amd_module_load --run-subtest reload

From my understanding, the KFD process belongs to the regular way of gfxoff=
 exit, which doorbell writing triggers gfxoff exit. For example, KFD maps H=
CQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ, these both trig=
ger doorbell writing(pls refer to gfx_v10_0_ring_set_wptr_compute()).

As to the IGT reload test, the dequeue request is not thru a cmd on a ring,=
 it directly writes CP registers, so GFX core remains in gfxoff.

Thanks,
Rico

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, January 26, 2022 23:08
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Yang(Kevin) <KevinYang.W=
ang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix an error message in rmmod

My question is, why is this problem only seen during module unload? Why
aren't we seeing HWS hangs due to GFX_OFF all the time in normal
operations? For example when the GPU is idle and a new KFD process is
started, creating a new runlist. Are we just getting lucky because the
process first has to allocate some memory, which maybe makes some HW
access (flushing TLBs etc.) that wakes up the GPU?


Regards,
   Felix



Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):
>
> [AMD Official Use Only]
>
>
> Thanks Kevin and Felix!
>
> In gfxoff state, the dequeue request(by cp register writing) can't
> make gfxoff exit, actually the cp is powered off and the cp register
> writing is invalid, doorbell registers writing(regluar way) or
> directly request smu to disable gfx powergate(by invoking
> amdgpu_gfx_off_ctrl) can trigger gfxoff exit.
>
> I have also tryed
> amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,false),
> but it has no effect.
>
> [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed
> [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff
> [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff
> [10386.162297] amdgpu: mmCP_STAT : 0xffffffff
> [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff
> [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff
> [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff
> [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff
>
> Thanks again!
> Rico
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Tuesday, January 25, 2022 23:31
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yin, Tianci (Rico)
> <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun
> <Guchun.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod
> I have no objection to the change. It restores the sequence that was
> used before e9669fb78262. But I don't understand why GFX_OFF is causing
> a preemption error during module unload, but not when KFD is in normal
> use. Maybe it's because of the compute power profile that's normally set
> by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.
>
>
> Either way, the patch is
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>
> Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):
> >
> > [AMD Official Use Only]
> >
> >
> > [AMD Official Use Only]
> >
> >
> > the issue is introduced in following patch, so add following
> > information is better.
> > /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/
> > /
> > /
> > Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> > /
> > /
> > Best Regards,
> > Kevin
> >
> > -----------------------------------------------------------------------=
-
> > *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> > Tianci Yin <tianci.yin@amd.com>
> > *Sent:* Tuesday, January 25, 2022 6:03 PM
> > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> > *Cc:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Yin, Tianci
> > (Rico) <Tianci.Yin@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod
> > From: "Tianci.Yin" <tianci.yin@amd.com>
> >
> > [why]
> > In rmmod procedure, kfd sends cp a dequeue request, but the
> > request does not get response, then an error message "cp
> > queue pipe 4 queue 0 preemption failed" printed.
> >
> > [how]
> > Performing kfd suspending after disabling gfxoff can fix it.
> >
> > Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
> > Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index b75d67f644e5..77e9837ba342 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct
> > amdgpu_device *adev)
> >                  }
> >          }
> >
> > -       amdgpu_amdkfd_suspend(adev, false);
> > -
> >          amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >          amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
> > +       amdgpu_amdkfd_suspend(adev, false);
> > +
> >          /* Workaroud for ASICs need to disable SMC first */
> >          amdgpu_device_smu_fini_early(adev);
> >
> > --
> > 2.25.1
> >

--_000_DM4PR12MB5294D2C47F12FC897406884295219DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The rmmod ops has prerequisite multi-user target and blacklist amdgpu, <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
which is IGT requirement so that IGT can make itself DRM master to test KMS=
.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(23, 78, 134);">igt-gpu-tools/build/tests/amdgpu/a=
md_module_load --run-subtest reload</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
From my understanding, the KFD process belongs to the regular way of gfxoff=
 exit, which doorbell writing triggers gfxoff exit. For example, KFD maps H=
CQ thru cmd on HIQ or KIQ ring, or UMD commits jobs on HCQ, these both trig=
ger doorbell writing(pls refer to
 gfx_v10_0_ring_set_wptr_compute()). <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
As to the IGT reload test, the dequeue request is not thru a cmd on a ring,=
 it directly writes CP registers, so GFX core remains in gfxoff.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 23:08<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Wang, Yang(Kevin)=
 &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@=
lists.freedesktop.org&gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix an error message in rmmod</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">My question is, why is this problem only seen duri=
ng module unload? Why
<br>
aren't we seeing HWS hangs due to GFX_OFF all the time in normal <br>
operations? For example when the GPU is idle and a new KFD process is <br>
started, creating a new runlist. Are we just getting lucky because the <br>
process first has to allocate some memory, which maybe makes some HW <br>
access (flushing TLBs etc.) that wakes up the GPU?<br>
<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
<br>
Am 2022-01-26 um 01:43 schrieb Yin, Tianci (Rico):<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt;<br>
&gt; Thanks Kevin and Felix!<br>
&gt;<br>
&gt; In gfxoff state, the dequeue request(by cp register writing) can't <br=
>
&gt; make gfxoff exit, actually the cp is powered off and the cp register <=
br>
&gt; writing is invalid, doorbell registers writing(regluar way) or <br>
&gt; directly request smu to disable gfx powergate(by invoking <br>
&gt; amdgpu_gfx_off_ctrl) can trigger gfxoff exit.<br>
&gt;<br>
&gt; I have also tryed <br>
&gt; amdgpu_dpm_switch_power_profile(adev,PP_SMC_POWER_PROFILE_COMPUTE,fals=
e), <br>
&gt; but it has no effect.<br>
&gt;<br>
&gt; [10386.162273] amdgpu: cp queue pipe 4 queue 0 preemption failed<br>
&gt; [10671.225065] amdgpu: mmCP_HQD_ACTIVE : 0xffffffff<br>
&gt; [10386.162290] amdgpu: mmCP_HQD_HQ_STATUS0 : 0xffffffff<br>
&gt; [10386.162297] amdgpu: mmCP_STAT : 0xffffffff<br>
&gt; [10386.162303] amdgpu: mmCP_BUSY_STAT : 0xffffffff<br>
&gt; [10386.162308] amdgpu: mmRLC_STAT : 0xffffffff<br>
&gt; [10386.162314] amdgpu: mmGRBM_STATUS : 0xffffffff<br>
&gt; [10386.162320] amdgpu: mmGRBM_STATUS2: 0xffffffff<br>
&gt;<br>
&gt; Thanks again!<br>
&gt; Rico<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; *Sent:* Tuesday, January 25, 2022 23:31<br>
&gt; *To:* Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Yin, Tianci (R=
ico) <br>
&gt; &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org <br>
&gt; &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Chen, Guch=
un <br>
&gt; &lt;Guchun.Chen@amd.com&gt;<br>
&gt; *Subject:* Re: [PATCH] drm/amdgpu: Fix an error message in rmmod<br>
&gt; I have no objection to the change. It restores the sequence that was<b=
r>
&gt; used before e9669fb78262. But I don't understand why GFX_OFF is causin=
g<br>
&gt; a preemption error during module unload, but not when KFD is in normal=
<br>
&gt; use. Maybe it's because of the compute power profile that's normally s=
et<br>
&gt; by amdgpu_amdkfd_set_compute_idle before we interact with the HWS.<br>
&gt;<br>
&gt;<br>
&gt; Either way, the patch is<br>
&gt;<br>
&gt; Acked-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Am 2022-01-25 um 05:48 schrieb Wang, Yang(Kevin):<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; the issue is introduced in following patch, so add following<br>
&gt; &gt; information is better.<br>
&gt; &gt; /fixes: (e9669fb78262) drm/amdgpu: Add early fini callback/<br>
&gt; &gt; /<br>
&gt; &gt; /<br>
&gt; &gt; Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;<br>
&gt; &gt; /<br>
&gt; &gt; /<br>
&gt; &gt; Best Regards,<br>
&gt; &gt; Kevin<br>
&gt; &gt;<br>
&gt; &gt; -----------------------------------------------------------------=
-------<br>
&gt; &gt; *From:* amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on =
behalf of<br>
&gt; &gt; Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt; *Sent:* Tuesday, January 25, 2022 6:03 PM<br>
&gt; &gt; *To:* amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
&gt; &gt; *Cc:* Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Yin, =
Tianci<br>
&gt; &gt; (Rico) &lt;Tianci.Yin@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@a=
md.com&gt;<br>
&gt; &gt; *Subject:* [PATCH] drm/amdgpu: Fix an error message in rmmod<br>
&gt; &gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; [why]<br>
&gt; &gt; In rmmod procedure, kfd sends cp a dequeue request, but the<br>
&gt; &gt; request does not get response, then an error message &quot;cp<br>
&gt; &gt; queue pipe 4 queue 0 preemption failed&quot; printed.<br>
&gt; &gt;<br>
&gt; &gt; [how]<br>
&gt; &gt; Performing kfd suspending after disabling gfxoff can fix it.<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930<br>
&gt; &gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&gt; &gt; &nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index b75d67f644e5..77e9837ba342 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(st=
ruct<br>
&gt; &gt; amdgpu_device *adev)<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev,=
 false);<br>
&gt; &gt; -<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_se=
t_pg_state(adev, AMD_PG_STATE_UNGATE);<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_se=
t_cg_state(adev, AMD_CG_STATE_UNGATE);<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_suspend(adev,=
 false);<br>
&gt; &gt; +<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for=
 ASICs need to disable SMC first */<br>
&gt; &gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_sm=
u_fini_early(adev);<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.25.1<br>
&gt; &gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5294D2C47F12FC897406884295219DM4PR12MB5294namp_--
