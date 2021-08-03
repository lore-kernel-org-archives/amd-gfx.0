Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07E1C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6880660EBD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6880660EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9156E1CF;
	Tue,  3 Aug 2021 08:07:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FFD6E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 08:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgHRQfEBfPBHhoJZ9R879ZqE46TU345dc9cXJkkBmeeXRJNPu89YWKuzUnhvOvYfcm21+g8cHGVGIegqhKGm+wiF25KnSTPpNDW7ulL+kUiUP/mFhDlrT9tlugql5YdYZ0YBJcdTySmRs+++PNbV7nszcBM0wM3EVQq4do4O3+/TdGydO3GNaxo6hPvFuKeM6GTeyhb4pf84o2THDbh4VnlG5keBe7ONP/9GmdizLELzr6FMujflEF+TZ51R7PRsmSoQKLDhrTYX7+galyz4Rge4k6+LAorrIPkk/YsN6Ox91Q6vGUMlETUj8cVTqrXoZ7bXKT9o93afV3dD8YrxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGx4w/NPbPCwVhHkyG72lA1o1b5XIk9XXnwmnkJSg2s=;
 b=Ak2b4sLC9Molnnn3w5sB6JBJ5HS4wmwO73CNVavairoEpSNovqHamrmRq66jIwZUGDBnAv9Z3cGkOXFvWBaLkifBhwScmRLPGQxRAvtV/ITZn3KRGn+hPfc2BtBMCkfmtvpXpz3EH+yn3cO9yaTL+L+IzB1GMPd+/DcA1dbFbf125tCAfVUOKXCab4g+eMVPFUIgaFgE0AvxdhTClFcuAH7eyyFBs0an/A1hNfmbxT38BDuD9hUQRLclMR55gSXyKPZSwsJxto8ZlKQjhq4/63dq3jQhNBGFh+kNEwqDQvMiS8wpnoCdb0rMkOnzwIltDGbCyi1pgMQPBARiLAXYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGx4w/NPbPCwVhHkyG72lA1o1b5XIk9XXnwmnkJSg2s=;
 b=VC/a1Zt6YBcCNZn0UtdboBRP6rVVDafQgfBnxoDozE+/cKe/5x6R3TF53CBmKLvMh0MV2HZc/nbh8GONb7pV1iQI5OFzLcdSskcY7bPdjS9gnCYcS/Z1JevwfITihI5zzj3eJ2rpQF39aFgwvjv/d1c6X4qF0+0ICbsa7p/07WQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Tue, 3 Aug 2021 08:07:08 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:07:08 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
Thread-Topic: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf
Thread-Index: AdeIE69In8ALCgfnTcG4u06LTYuZEAAHUgIAAANZ0GA=
Date: Tue, 3 Aug 2021 08:07:08 +0000
Message-ID: <DM5PR12MB2469E5043B5DF107A5FF413BF1F09@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <DM6PR12MB46495DFBA7AA7E20614B7CC591F09@DM6PR12MB4649.namprd12.prod.outlook.com>
 <9c4fe075-d02b-cb5d-3965-d78e5b937540@amd.com>
In-Reply-To: <9c4fe075-d02b-cb5d-3965-d78e5b937540@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T08:07:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b6ea91a3-e206-4704-b6ec-8bcfc3a5aa64;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54d085b6-8ace-4ebd-6ae8-08d95655b06f
x-ms-traffictypediagnostic: DM6PR12MB3467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3467252A0D4D8E3F1E90E0C3F1F09@DM6PR12MB3467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlPWmQew4LwClpw+7Sterwwijv/GPty7SoJww6HulKi8ZvGgNc+rzM5qec27ceQ7sPux7KvuaVucl/a5H513+yAxehf8vP+Yjp/wcZdZs9jj88oQn3/CkczYfRl9R4NxcPWBeNIqudT9EZj5ZtOkz+a0MdHUImq2D+kgCShrETfHdMLiyzM3D7XI+KObItVtNbDEMxnD4rESF1isLqNAUMJuecMDXc1683cE9ssxlhD1+h+Hthl6rJBJZDFFfVKprF5zGoRLvlb6en1CsVvsRkmcWUga2eSU5s9bfWqx9evKsFC2U7bqTY7YU/RHWf6ByvbbgThCe2gbwXQcxnbsMpLhgaXyZxf32tGbvC24UZddxYcmLnyposAHwGJCsqxzcEfdpZ3qwVlkEJAGILvwukdPayYpAbDcqhEMlhBKwZbxzZJALR8KipaOrca976K0iMeblCgXWxtV9yFV4r9GgK09/e8sX5kwVpLJcCW4BXw5/K/umrKbMNCOazul8mUkFKUa0npbojZr+jiIVCEplyPXH0TI76LQY0h25tcXfn/zdzM85YksznCEymgmRhJxUnAuYMlIDAwHDxg2Mu1KiYlRch1377M1meJXDcoCqAsDoYe7VKlz13UEefa5VwdNbbjSP0D10mpl0VDBXczCfi3vQFHcxSdNG4u+5aUy/RL9k9x+xTC4u6tqnSvk4HAUHP3fA4IFUwvyZ4un2bTJwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(316002)(26005)(52536014)(186003)(110136005)(66476007)(66946007)(66446008)(66556008)(76116006)(64756008)(83380400001)(86362001)(30864003)(71200400001)(4326008)(5660300002)(478600001)(38100700002)(122000001)(2906002)(6506007)(7696005)(53546011)(55016002)(33656002)(38070700005)(8936002)(9686003)(8676002)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zAgt89iP7pfzifYdNk+/JXPQlJ8Yek8kECBiHSF7q8bCHTh7Anhx/cipUt?=
 =?iso-8859-1?Q?qLAEX548Tgt6PT854bdQ3iK7W8ZFt4z/auy2XeN5urBJ3QIexyHG2SIlhK?=
 =?iso-8859-1?Q?YTGWK/J0KNomJ2Z6Nf8etqfTyPCj/cmffPpPrwSiaGvPfsI0CnjXDPiiKU?=
 =?iso-8859-1?Q?t14++kjJWVMjGSxBzlInLQbmqgxPkyMQUJryOLSRj0oWK09YYRtpEi7mED?=
 =?iso-8859-1?Q?qT9CV87VL02NDv9Sg0INOLF7GoAItSjECyQf+Q8le0Dk7YbulABCmZHk2I?=
 =?iso-8859-1?Q?CnvOtItoBsp/SLvDY7ipPdexvouoK2En56Z5yB9mwRzAhLeiP4bCxVueq5?=
 =?iso-8859-1?Q?89xWrUOBtWzwLa5+zYmLztu4T9VVqdYUhpbpwM2CaRkCNFqf3AO03JEspB?=
 =?iso-8859-1?Q?kac9TvLdqJncv4RtFqYOsMRwVfJMwqTbD3YUBAWr4NFfKVNGnvTvTsmyIK?=
 =?iso-8859-1?Q?rDqqmF9p6m8sve1tyvTZgew6MIIIPJMS5AzF2Xb/m1kHFZgTeait2AQId3?=
 =?iso-8859-1?Q?u/d6QudvkNdnMUa/CHmrq9fVLxept6Jshmr2bFrENHoIKzwDA90nsE0b1/?=
 =?iso-8859-1?Q?ia0wkcLSZCTUpEe2ky+3G/uCiqQqA9ZkkIYh5PVKeptcL/qeb0FYrcyeRI?=
 =?iso-8859-1?Q?sbukDRj0SqiwmTcOPvBOC7krDrJ6lFBpe9xYJYCPkXGhJ0NB9p36FbENIN?=
 =?iso-8859-1?Q?kaq2FS0350dCNiNlYXIeoSzWOxa+7WTLb7kPW+zenUqbqp3pw9pUIFgRZ5?=
 =?iso-8859-1?Q?333pJvahf39He1X19V2RTQNn//NO3HQwE6aEJMjcRFxzA3xFWdQv0K/xgX?=
 =?iso-8859-1?Q?BAlG5o/jUX1mxMULzQ8pouBvPfIQwBGBsxJ7N08M4Pga8Oz+qKYr4lZZCJ?=
 =?iso-8859-1?Q?FekqGRF9HyZiuO91hBFp4UrC47hxnR0y/nrHxKt+ZOn0OE+PwbR6nRvMuR?=
 =?iso-8859-1?Q?QcnzWt6tWPwLOqbmaoH1VQHzx2GopALO6DGQZveZx3bZOtUFzqfe/CVXzd?=
 =?iso-8859-1?Q?LRWSQiZXTU5T8kVtNjADd+e7RG8NeZI1b2LvvUROe6/XvHqc9n1qDxwcjH?=
 =?iso-8859-1?Q?yaWGqOugpiXawCTv3Zd88OQ1ed1LTgK6vK9op6bK6oTdsBPRPtHFGflrai?=
 =?iso-8859-1?Q?QLL7gAqrIru2uBLPdNAh4uZIl43ocKXeWH4CD2m5Wnb6DRsWMZSQl+CUil?=
 =?iso-8859-1?Q?zMcW1pprEq5ObgzvZK9P12P3t74WSiVzOqV0C4B0gE1AdvHXLz0ncytsD/?=
 =?iso-8859-1?Q?0Sbpu1iDNg8Ist63g3Ixgsvn7KJ9D+v9rWTH5ZBmU2duN4j8EjlgsiUIaE?=
 =?iso-8859-1?Q?GqAteCOJ8ROCj214o7nrrV/rABOe/fW3cQxqiQYsL+wWNM7h34mYSrby/g?=
 =?iso-8859-1?Q?AOUf72utKx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d085b6-8ace-4ebd-6ae8-08d95655b06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 08:07:08.0687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXowYOv2h+kxH/A5imb89lASNOwhCBfNT/m6I4n43UnjzOdYkJQXwy/i6AiMNKjMTi45SuZ2rRmGSXArKn08ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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

In psp_cmd_submit_buf, it has psp->mutex to guard this, so it should be fin=
e.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Tuesday, August 3, 2021 2:30 PM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: remove redundant host to psp cmd buf

Command buffer in psp context means different command buffers cannot be pre=
pared in parallel. Any case of submitting commands for different TAs in par=
allel - ex: for RAS and some other TA?

Thanks,
Lijo

On 8/3/2021 8:35 AM, Li, Candice wrote:
> [Public]
>=20
>=20
> Signed-off-by: Candice Li candice.li@amd.com=20
> <mailto:candice.li@amd.com>
>=20
> ---
>=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 253 ++++++++----------------
>=20
> 1 file changed, 78 insertions(+), 175 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>=20
> index ed731144ca7f..9c18558e3bc0 100644
>=20
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>=20
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>=20
> @@ -253,6 +253,12 @@ static int psp_sw_init(void *handle)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_runtime_boot_cfg_entry b=
oot_cfg_entry;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_memory_training_context =
*mem_training_ctx =3D=20
> &psp->mem_train_ctx;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd =3D kzalloc(sizeof(struct psp=
_gfx_cmd_resp),
> GFP_KERNEL);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!psp->cmd) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 DRM_ERROR("Failed to allocate memory to
> command buffer!\n");
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ret =3D -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!amdgpu_sriov_vf(adev)) {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ret =3D psp_init_microcode(psp);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 if (ret) {
>=20
> @@ -315,25 +321,30 @@ static int psp_sw_init(void *handle)
>=20
> static int psp_sw_fini(void *handle)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D (str=
uct amdgpu_device=20
> *)handle;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_context *psp =3D &adev->psp=
;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_memory_training_fini(&adev->psp=
);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->psp.sos_fw) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(adev->psp.sos_fw);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 adev->psp.sos_fw =3D NULL;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_memory_training_fini(psp);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (psp->sos_fw) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(psp->sos_fw);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 psp->sos_fw =3D NULL;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->psp.asd_fw) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(adev->psp.asd_fw);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (psp->asd_fw) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(psp->asd_fw);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 adev->psp.asd_fw =3D NULL;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->psp.ta_fw) {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(adev->psp.ta_fw);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 adev->psp.ta_fw =3D NULL;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (psp->ta_fw) {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 release_firmware(psp->ta_fw);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 psp->ta_fw =3D NULL;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->asic_type =3D=3D CHIP_=
NAVI10 ||
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0adev->asic_type =3D=3D =
CHIP_SIENNA_CICHLID)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 psp_sysfs_fini(adev);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D NULL;
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>=20
> }
>=20
> @@ -491,6 +502,8 @@ static void psp_prep_tmr_cmd_buf(struct=20
> psp_context *psp,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t size =3D amdgpu_bo_size(tm=
r_bo);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t tmr_pa =3D amdgpu_gmc_vram=
_pa(adev, tmr_bo);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_SETUP_VMR;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
>=20
> @@ -506,6 +519,8 @@ static void psp_prep_tmr_cmd_buf(struct=20
> psp_context *psp,
>=20
> static void psp_prep_load_toc_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0
> uint64_t pri_buf_mc, uint32_t size)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_LOAD_TOC=
;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_toc.toc_phy_addr_=
lo =3D=20
> lower_32_bits(pri_buf_mc);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_toc.toc_phy_addr_=
hi =3D=20
> upper_32_bits(pri_buf_mc);
>=20
> @@ -517,11 +532,8 @@ static int psp_load_toc(struct psp_context *psp,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t *tmr_size)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Copy toc to psp firmware private=
 buffer */
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->toc.start_add=
r,=20
> psp->toc.size_bytes);
>=20
> @@ -531,7 +543,7 @@ static int psp_load_toc(struct psp_context *psp,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ret)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 *tmr_size =3D=20
> psp->cmd_buf_mem->resp.tmr_size;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -588,7 +600,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
>=20
> static int psp_tmr_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* For Navi12 and CHIP_SIENNA_CI=
CHLID SRIOV, do not set=20
> up TMR.
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* Already set up by host driver.
>=20
> @@ -596,10 +608,6 @@ static int psp_tmr_load(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev) && p=
sp_skip_tmr(psp))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_tmr_cmd_buf(psp, cmd, psp-=
>tmr_mc_addr,=20
> psp->tmr_bo);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("reserve 0x%lx from 0x%llx=
 for PSP TMR\n",
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0amdgpu_bo_size(psp->tmr_bo),
> psp->tmr_mc_addr);
>=20
> @@ -607,14 +615,14 @@ static int psp_tmr_load(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, NUL=
L, cmd,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
>=20
> -                                                                      =20
> struct psp_gfx_cmd_resp *cmd)
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 struct
> psp_gfx_cmd_resp *cmd)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_DESTROY_VMR;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
>=20
> @@ -624,11 +632,7 @@ static void psp_prep_tmr_unload_cmd_buf(struct
> psp_context *psp,
>=20
> static int psp_tmr_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_tmr_unload_cmd_buf(psp,=
 cmd);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("free PSP TMR buffer\n");
>=20
> @@ -636,8 +640,6 @@ static int psp_tmr_unload(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, NUL=
L, cmd,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -662,7 +664,9 @@ int psp_get_fw_attestation_records_addr(struct
> psp_context *psp,
>=20
>                                                                        =20
> uint64_t *output_ptr)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
> +
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!output_ptr)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return -EINVAL;
>=20
> @@ -670,10 +674,6 @@ int psp_get_fw_attestation_records_addr(struct
> psp_context *psp,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_GET_FW_A=
TTESTATION;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
> @@ -684,29 +684,26 @@ int psp_get_fw_attestation_records_addr(struct
> psp_context *psp,
>=20
>                                           =20
>  =A0=A0=A0=A0=A0=A0((uint64_t)cmd->resp.uresp.fwar_db_info.fwar_db_addr_h=
i << 32);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_boot_config_get(struct amdgpu_device *adev, uint32_t
> *boot_cfg)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_context *psp =3D &adev->=
psp;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D ps=
p->cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(psp->cmd, 0, sizeof(struct psp_=
gfx_cmd_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gf=
x_cmd_resp));
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG=
;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.boot_cfg.sub_cmd =3D BOOTC=
FG_CMD_GET;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd_id =3D GFX_CMD_ID_BOOT_C=
FG;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd.boot_cfg.sub_cmd =3D BOO=
TCFG_CMD_GET;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, NUL=
L, cmd,
> psp->fence_buf_mc_addr);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, NULL, =
psp->cmd,
> psp->fence_buf_mc_addr);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ret) {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 *boot_cfg =3D
>=20
> -                                         =20
> (cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
>=20
> +                                        =20
> (psp->cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> @@ -715,19 +712,18 @@ static int psp_boot_config_get(struct=20
> amdgpu_device *adev, uint32_t *boot_cfg)
>=20
> static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t
> boot_cfg)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_context *psp =3D &adev->=
psp;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D ps=
p->cmd;
>=20
> +
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(psp->cmd, 0, sizeof(struct psp_=
gfx_cmd_resp));
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gf=
x_cmd_resp));
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_BOOT_CFG=
;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.boot_cfg.sub_cmd =3D BOOTC=
FG_CMD_SET;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.boot_cfg.boot_config =3D b=
oot_cfg;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.boot_cfg.boot_config_valid=
 =3D boot_cfg;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd_id =3D GFX_CMD_ID_BOOT_C=
FG;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd.boot_cfg.sub_cmd =3D BOO=
TCFG_CMD_SET;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd.boot_cfg.boot_config =3D=
 boot_cfg;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd->cmd.boot_cfg.boot_config_val=
id =3D boot_cfg;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return psp_cmd_submit_buf(psp, NULL=
, cmd,
> psp->fence_buf_mc_addr);
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return psp_cmd_submit_buf(psp, NULL, p=
sp->cmd,
> psp->fence_buf_mc_addr);
>=20
> }
>=20
>  =A0static int psp_rl_load(struct amdgpu_device *adev)
>=20
> @@ -735,14 +731,14 @@ static int psp_rl_load(struct amdgpu_device=20
> *adev)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_context *psp =3D &adev->=
psp;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D ps=
p->cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!is_psp_fw_valid(psp->rl))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(psp->fw_pri_buf, 0, PSP_1=
_MEG);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(psp->fw_pri_buf, psp->rl.sta=
rt_addr,
> psp->rl.size_bytes);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gf=
x_cmd_resp));
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_=
FW;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ip_fw.fw_phy_addr=
_lo =3D=20
> lower_32_bits(psp->fw_pri_mc_addr);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ip_fw.fw_phy_addr=
_hi =3D=20
> upper_32_bits(psp->fw_pri_mc_addr);
>=20
> @@ -755,6 +751,8 @@ static int psp_rl_load(struct amdgpu_device *adev)
>=20
> static void psp_prep_asd_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 uint64_t=20
> asd_mc, uint32_t size)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_LOAD_ASD=
;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ta.app_phy_addr_l=
o =3D=20
> lower_32_bits(asd_mc);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ta.app_phy_addr_h=
i =3D=20
> upper_32_bits(asd_mc);
>=20
> @@ -768,7 +766,7 @@ static void psp_prep_asd_load_cmd_buf(struct=20
> psp_gfx_cmd_resp *cmd,
>=20
> static int psp_asd_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* If PSP version doesn't match =
ASD version, asd=20
> loading will be failed.
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* add workaround to bypass it fo=
r sriov now.
>=20
> @@ -777,10 +775,6 @@ static int psp_asd_load(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev) || !=
psp->asd_ucode_size)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->asd_start_add=
r,=20
> psp->asd_ucode_size);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_asd_load_cmd_buf(cmd, p=
sp->fw_pri_mc_addr,
>=20
> @@ -793,14 +787,14 @@ static int psp_asd_load(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 psp->asd_context.session_id =3D
> cmd->resp.session_id;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>=20
>                                                          =20
>  =A0=A0=A0=A0=A0=A0=A0uint32_t session_id)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_UNLOAD_T=
A;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_unload_ta.session_id =
=3D session_id;
>=20
> }
>=20
> @@ -808,7 +802,7 @@ static void psp_prep_ta_unload_cmd_buf(struct=20
> psp_gfx_cmd_resp *cmd,
>=20
> static int psp_asd_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> @@ -816,10 +810,6 @@ static int psp_asd_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!psp->asd_context.asd_initializ=
ed)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,=20
> psp->asd_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
> @@ -827,14 +817,14 @@ static int psp_asd_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ret)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 psp->asd_context.asd_initialized =3D false;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static void psp_prep_reg_prog_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 uint32_t id, uint32_t value)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_PROG_REG=
;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_setup_reg_prog.reg_val=
ue =3D value;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_setup_reg_prog.reg_id =
=3D id;
>=20
> @@ -843,22 +833,17 @@ static void psp_prep_reg_prog_cmd_buf(struct=20
> psp_gfx_cmd_resp *cmd,
>=20
> int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 uint32_t value)
>=20
> {
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D NU=
LL;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D 0;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (reg >=3D PSP_REG_LAST)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return -EINVAL;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_reg_prog_cmd_buf(cmd, reg,=
 value);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, NUL=
L, cmd,
> psp->fence_buf_mc_addr);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 DRM_ERROR("PSP failed to program reg id=20
> %d", reg);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -868,6 +853,8 @@ static void psp_prep_ta_load_cmd_buf(struct=20
> psp_gfx_cmd_resp *cmd,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0
> uint64_t ta_shared_mc,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0
> uint32_t
> ta_shared_size)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id                        =
                      =20
> =3D GFX_CMD_ID_LOAD_TA;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ta.app_phy_addr_l=
o =A0=A0=A0=A0=A0=A0=A0=A0 =3D=20
> lower_32_bits(ta_bin_mc);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_load_ta.app_phy_addr_h=
i=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=20
> upper_32_bits(ta_bin_mc);
>=20
> @@ -899,6 +886,8 @@ static void psp_prep_ta_invoke_cmd_buf(struct=20
> psp_gfx_cmd_resp *cmd,
>=20
>                                                          =20
>  =A0=A0=A0=A0=A0=A0=A0uint32_t ta_cmd_id,
>=20
>                                                          =20
>  =A0=A0=A0=A0=A0=A0=A0uint32_t session_id)
>=20
> {
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id                        =
                      =20
> =3D GFX_CMD_ID_INVOKE_CMD;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_invoke_cmd.session_id =
=3D session_id;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd.cmd_invoke_cmd.ta_cmd_id =
=3D ta_cmd_id;
>=20
> @@ -909,35 +898,25 @@ static int psp_ta_invoke(struct psp_context=20
> *psp,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0uint32_t session_id)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_invoke_cmd_buf(cmd, =
ta_cmd_id, session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_xgmi_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the loading in sr=
iov for now
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0*/
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->ta_xgmi_start=
_addr,
> psp->ta_xgmi_ucode_size);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_load_cmd_buf(cmd,
>=20
> @@ -954,15 +933,13 @@ static int psp_xgmi_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 psp->xgmi_context.session_id =3D
> cmd->resp.session_id;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_xgmi_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D psp-=
>adev;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* XGMI TA unload currently is n=
ot supported on=20
> Arcturus/Aldebaran A+A */
>=20
> @@ -974,17 +951,11 @@ static int psp_xgmi_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the unloading in =
sriov for now
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0*/
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,=20
> psp->xgmi_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1204,7 +1175,7 @@ static int psp_ras_init_shared_buf(struct=20
> psp_context *psp)
>=20
> static int psp_ras_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct ta_ras_shared_memory *ras_cm=
d;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
> @@ -1213,10 +1184,6 @@ static int psp_ras_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->ta_ras_start_=
addr,
> psp->ta_ras_ucode_size);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ras_cmd =3D (struct ta_ras_share=
d_memory=20
> *)psp->ras.ras_shared_buf;
>=20
> @@ -1247,15 +1214,13 @@ static int psp_ras_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret || ras_cmd->ras_status)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 amdgpu_ras_fini(psp->adev);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_ras_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the unloading in =
sriov for now
>=20
> @@ -1263,17 +1228,11 @@ static int psp_ras_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd, psp=
->ras.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->fence_buf_mc_addr)=
;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1514,7 +1473,7 @@ static int psp_hdcp_init_shared_buf(struct=20
> psp_context *psp)
>=20
> static int psp_hdcp_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the loading in sr=
iov for now
>=20
> @@ -1522,10 +1481,6 @@ static int psp_hdcp_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->ta_hdcp_start=
_addr,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0psp->ta_hdcp_ucode_size);
>=20
> @@ -1543,8 +1498,6 @@ static int psp_hdcp_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 mutex_init(&psp->hdcp_context.mutex);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> static int psp_hdcp_initialize(struct psp_context *psp)
>=20
> @@ -1579,7 +1532,7 @@ static int psp_hdcp_initialize(struct=20
> psp_context
> *psp)
>=20
> static int psp_hdcp_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the unloading in =
sriov for now
>=20
> @@ -1587,16 +1540,10 @@ static int psp_hdcp_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,=20
> psp->hdcp_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
> psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1665,7 +1612,7 @@ static int psp_dtm_init_shared_buf(struct=20
> psp_context *psp)
>=20
> static int psp_dtm_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the loading in sr=
iov for now
>=20
> @@ -1673,10 +1620,6 @@ static int psp_dtm_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->ta_dtm_start_=
addr,
> psp->ta_dtm_ucode_size);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_load_cmd_buf(cmd,
>=20
> @@ -1693,8 +1636,6 @@ static int psp_dtm_load(struct psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 mutex_init(&psp->dtm_context.mutex);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1730,7 +1671,7 @@ static int psp_dtm_initialize(struct psp_context=20
> *psp)
>=20
> static int psp_dtm_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0* TODO: bypass the unloading in =
sriov for now
>=20
> @@ -1738,16 +1679,10 @@ static int psp_dtm_unload(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(psp->adev))
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 return 0;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,=20
> psp->dtm_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
> psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1816,11 +1751,7 @@ static int psp_rap_init_shared_buf(struct=20
> psp_context *psp)
>=20
> static int psp_rap_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_copy_fw(psp, psp->ta_rap_sta=
rt_addr,
> psp->ta_rap_ucode_size);
>=20
> @@ -1838,26 +1769,18 @@ static int psp_rap_load(struct psp_context=20
> *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 mutex_init(&psp->rap_context.mutex);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_rap_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,=
=20
> psp->rap_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
> psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -1982,11 +1905,7 @@ static int
> psp_securedisplay_init_shared_buf(struct psp_context *psp)
>=20
> static int psp_securedisplay_load(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(psp->fw_pri_buf, 0, PSP_1=
_MEG);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(psp->fw_pri_buf,=20
> psp->ta_securedisplay_start_addr,
> psp->ta_securedisplay_ucode_size);
>=20
> @@ -2007,25 +1926,18 @@ static int psp_securedisplay_load(struct=20
> psp_context *psp)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_init(&psp->securedisplay_cont=
ext.mutex);
>=20
>  =A0failed:
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
>  =A0static int psp_securedisplay_unload(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> -
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp_prep_ta_unload_cmd_buf(cmd,
> psp->securedisplay_context.session_id);
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
> psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> @@ -2552,10 +2464,6 @@ static int psp_load_fw(struct amdgpu_device=20
> *adev)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 goto skip_memalloc;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd =3D kzalloc(sizeof(struct =
psp_gfx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!psp->cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (amdgpu_sriov_vf(adev)) {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ret =3D amdgpu_bo_create_kernel(adev,=20
> PSP_1_MEG, PSP_1_MEG,
>=20
>                                                                        =20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AMDGPU_GEM_DOMAIN_VRAM,
>=20
> @@ -2709,9 +2617,6 @@ static int psp_hw_fini(void *handle)
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_bo_free_kernel(&psp->cmd_buf=
_bo,=20
> &psp->cmd_buf_mc_addr,
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0(void=
=20
> **)&psp->cmd_buf_mem);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(psp->cmd);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 psp->cmd =3D NULL;
>=20
> -
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>=20
> }
>=20
> @@ -2875,17 +2780,15 @@ int psp_gpu_reset(struct amdgpu_device *adev)
>=20
> int psp_rlc_autoload_start(struct psp_context *psp)
>=20
> {
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct psp_gfx_cmd_resp *cmd =3D psp->=
cmd;
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd =3D kzalloc(sizeof(struct psp_g=
fx_cmd_resp),=20
> GFP_KERNEL);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!cmd)
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 return -ENOMEM;
>=20
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(cmd, 0, sizeof(struct psp_gfx_c=
md_resp));
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->cmd_id =3D GFX_CMD_ID_AUTOL=
OAD_RLC;
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D psp_cmd_submit_buf(psp, =
NULL, cmd,
>=20
>                                                          =20
>  =A0psp->fence_buf_mc_addr);
>=20
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(cmd);
>=20
> +
>=20
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>=20
> }
>=20
> --
>=20
> 2.17.1
>=20
> Thanks,
>=20
> Candice
>=20
