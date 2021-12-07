Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6096AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 04:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969B06E9A8;
	Tue,  7 Dec 2021 04:07:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5156E9A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 04:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5zAZj+7Noc7BUK4DeOD3NFT+f/YZKu0LOmdAL5ps8YelwzwKO9ViZOEvm1/SxZ+f16VFg0VMVDQKMjr+9bQoYjJbdV+01vDbOSxux4gmvUU/5U2FQyDmXNrElm7RqDlHasXpVkuOdJIwJPqEZ3eHNYda2autqZ+bvDQm/9Wc8hRhhbIMm23/iGLZXzHCus4GbTe3gVs1o1t8yKybH6PS6mIaRE4559Anv52GrXFOGVVz2PgZKVRxtiRLbjq2fKxhrqJm9j8mtiMbnPgLK59+lYHNddfaIMGb6ggS7p+H2gRmTT4ueweQZZdvGfncQw23tDZpBNVi4Qer2hPyqLVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50z2SqWShqYFeJOf1vKN0Ej5ptx/Rr0WfFNeCA/hJuk=;
 b=gKsaIbnCS+pTrpYxsEyGU7mGWnsM7f52pLIPCTjoyWn95donW1sJfi6EmafZYHeul5E3WOBENoyXL3i7W5nHm+lG171mF3Ynd2CeJtQWWYr8DwFCaFD6kkZImfpBvDhL6AKf7arQLCon8VUl1VWk9Ica7ICsr/pvgoi5GXYL0Gq869q96FD4xjHkrzJNeoarazVFKwk83QtYbS3C9Fe8pwCcDR2oGZ9dW94CYP0Hdlnsl9czo0STOqDrOLL9AMgrxOup48yrvWLx7v0wtx5a1KZIT/Ja+mV7BelIGe4KS2qH2QozwZ8AihIlfBhZN00ezJvSPsNOKly1ggEM2by55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50z2SqWShqYFeJOf1vKN0Ej5ptx/Rr0WfFNeCA/hJuk=;
 b=Bkx1d5QwEcPdijFYCXAtqjexin3tbV1kiFRY5DpUUn1i5M3R6m900H3GmRDU9EGUFVM7+6JhlKyqHuU+iO4ePin5ni/slxwYSlhujD+8jewnMtXtNzGT2k3jdOHN0kh2NkC4kzn5tGVEAmt26HX/hRPAgyaSGjgdv3lOMHcWIVc=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 04:07:00 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 04:06:59 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Topic: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Index: AQHX5qGzwQrRwGnuTUmemrwDRbB3tKwlAK5ggAFpeACAAAJzMA==
Date: Tue, 7 Dec 2021 04:06:59 +0000
Message-ID: <DM6PR12MB4650549B4CC9AB4DA48C81B0B06E9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-3-YiPeng.Chai@amd.com>
 <DM6PR12MB46507136C714550B974B682EB06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
 <CH2PR12MB4215017BC0C393FEA8BB694AFC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215017BC0C393FEA8BB694AFC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:03:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f91674a0-640b-4147-8237-7e6e1c20c707;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-07T04:06:56Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0ea70701-4e95-41a5-b1d2-4ae8ec7de0d8
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00996907-20ab-4a09-36d9-08d9b937047c
x-ms-traffictypediagnostic: DM6PR12MB3819:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3819E993B3852E49DEC4295BB06E9@DM6PR12MB3819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf2mQqbE/X96LFN6VnLQfGa3fX1mfhDk88zyZjbzEHM5H9NWt3wOTi2upKDRdAEM8S3CvlcYR685mvfC9KIMdmc6dl9JA8Cd3Nt2TYSC00Od6IuZoMS5VBIitMph9Na25aFpTiK9wIdo83V4wQS5uJ+aKslnQTL2qCosz0YMyqiswNExppWTuq3zR2riM17r3Gjlsr+jo3URbGS5aQcYf1JFGVRhiBlQc3xL6caUFi0CUnspATRt0vWWQ4IaqxHimQU3fOHG9lO7c1TwgB/vP0UJKms/m5HBaeyIilepwZ8uOYZl3CVXkEpbntlk9NGvnZpLi3bXC8XwOjTj3n3Otsmu8pj52Fgcf9Ju7clCSxJc5I0qx0KR6GVmuIIoK/AHu0jjxEY7MJUIw6fXKe635fNKX79BXSobGI/1Jko8w2Fvh8HqYoucYgmUEFWNQ013eQm9zyH1OtDbrG+rSgdov/LXoWD9yx8zVJO3EycqQWZ3H36Lm16HNognoE3IXHahh2Jsf0GLdburE4+BDng6jGBBr7eKppwtGbriElEcah1OPHPtbZWuxSJAjl2tUKv28ZgqLTyIH77prx/hgcaYxxEXbhj+K3Ckm0ESrXxiYb8ddm9J2HMpxl/PCH0UL1IDvmE9HU0R/6zLS3NV1xrGk1yJElkVqABgWxuWS+5tcqOOtZQxIl492/dWJkV8N5bo8fHiPaHhUTrAJeZyHs7cgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(26005)(8676002)(4326008)(86362001)(30864003)(8936002)(83380400001)(5660300002)(6506007)(2906002)(53546011)(122000001)(38100700002)(7696005)(66946007)(76116006)(508600001)(9686003)(55016003)(38070700005)(66556008)(66476007)(64756008)(52536014)(66446008)(316002)(71200400001)(110136005)(33656002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k3KYDq3rS9KqognB8QsSPhv7e/MjgxHdxguECenhy32qo6/Mp7tQGTaIMnei?=
 =?us-ascii?Q?djiZHzDC0PvNhlw1FAjbA2WA1K8sZ+IXmLdPhU0MxFCNinwygRpMTKV3OKs6?=
 =?us-ascii?Q?4KjO+1BSMgUsNFFXGC8f5EBaCNag1k03LRUrhtqz8nTRXPVeb3+lPQfiXIX2?=
 =?us-ascii?Q?i8kEnLvZD6zvHqP+reAcqXRdJ6p934gNjAxoONN60canbqAlpJiJPO4Xt1Pr?=
 =?us-ascii?Q?W8K9J+a42jDlQEdafXphmuen906x8kPjBiwZbvISb7MFqgpVdTIj70aFWUTr?=
 =?us-ascii?Q?dehVBSkuN6qM/ImeAvtJ9Q1vFRfd/+67ijKI7UUXG1xgHYwUL+5EedNWEGGG?=
 =?us-ascii?Q?dPUtlSX24flBFP9PtRledkRoAk4RRRbIr064/Eok58VHg8DH65s2rFGQyZFP?=
 =?us-ascii?Q?OeMilvy9LDblN0fjnLRTeeykoLMNCOMvAjVp9zamH/M3OP7dYNFJnjUgsDx0?=
 =?us-ascii?Q?ZhVU8dAUJ+vF8QCMuzYCf/HKOkFY9fasMVnxe6Oty3RM8wcg0XV3LQos9cdt?=
 =?us-ascii?Q?YIeAlPk17FCbBEToeFRnP2BUqMhFRmuBe/J6WHk5vqT17MCfv+iL+m3daY41?=
 =?us-ascii?Q?f8pV4MvQqrZB4PyWjETyGt6InxjfRg/qswphnccZd19+fexAMzJ77V8BU8qc?=
 =?us-ascii?Q?euPTFiLgBdnjzAIWagu7ZUOanxNqGaPVEyW47+2/8miqWofJBAmBDNgXTpDb?=
 =?us-ascii?Q?qmXILtmknnEe0w9VPoZFF68pWDCPV6aaojinwUiGx05qK0fKHcRJRv4UIYRj?=
 =?us-ascii?Q?c4+iJ6cxkSkDH3Sxa16NoE6RFVltGyU4nCpS6l3Er9pjhLpsTYXuPuS0VoIk?=
 =?us-ascii?Q?VoBs7JOTGvsrVjpMvicr5Bqt/p8xi7+SV9WsrYBGSM6OtzSC+b0L4tjn8WoP?=
 =?us-ascii?Q?EXdGqtyseOUvAfW/xKSVboik13COL5teUPuU2s+j+o9Pjzdd5wXgi47E9vpT?=
 =?us-ascii?Q?i1o+i8YrrDBqSHix+eoWneL0jFkBGkzab/9bWRuF3cTAYMlkyEFIYhXxEmh9?=
 =?us-ascii?Q?977hCY92t4bkD4cwLuViX3UpdwiRm/raqI+czu+0762KJ2V4+CdKYsx619Ap?=
 =?us-ascii?Q?0FFiShybB5esUKUQkDvO1lhDpUBk6XuWMPwtZDRp83YsRuDDKwOpgSkCBcpn?=
 =?us-ascii?Q?CoDymXX7ZDnLeBGxufGfSn/sW2gB+ubqKCeQO5oIUX+2acpRQ/GzLKV2icfa?=
 =?us-ascii?Q?QGJ/Fhgna6RlPCe26CbRJ8yP9Un2jaD9D+Gw2QVoOrFIi8Qwscbc+QrvgH7R?=
 =?us-ascii?Q?VzCr0u28aVQcQV5SzuShx4MJTdizOwb3YirQqCnBBsZtvl3anPoYWDZiZ7ad?=
 =?us-ascii?Q?Ij/p8oNl7VORTzyqxNUUcyWI8FEQAfLJ35t9hSnmax9mVV1Jf1r8SIrMBgIK?=
 =?us-ascii?Q?HiyqA7weSwoTx7PR6pHsoA/ToJkD+IDigxAvOn07MsDFRmXtVnzv9RTpojNJ?=
 =?us-ascii?Q?uD/l/C5huC29vIKpzxH7Wheo4V8asr5ZSK4An7kwCpw2wN2ngzEQ5W1InmwQ?=
 =?us-ascii?Q?kdPai/ewHZ9JNmWtJN+Xu0Vvht7s+MTukUj96KpYJzBSw0ySxwLRUca8IxX+?=
 =?us-ascii?Q?gA/awmYcuxRQFppLErI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00996907-20ab-4a09-36d9-08d9b937047c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 04:06:59.7875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6iEbPv1Y/r8v9xnKua15strqRSYUf3A7o2CX43m0HZmBtDunpxRd/1M5Cb3TAB9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Thomas,

Please see my two comments.

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, December 7, 2021 11:37 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
> unified ras block data and ops
>=20
> Hi tao:
>      I add my comments behind your comments. Please review.
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, December 6, 2021 2:58 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
> unified ras block data and ops
>=20
> [AMD Official Use Only]
>=20
> Please see my comments inline.
>=20
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, December 1, 2021 6:53 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas
> > <YiPeng.Chai@amd.com>
> > Subject: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
> > unified ras block data and ops
> >
> > 1.Modify gfx block to fit for the unified ras block data and ops
> > 2.Implement .ras_block_match function pointer for gfx block to identify=
 itself.
> > 3.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the corresponding
> > variable name remove _funcs suffix.
> > 4.Remove the const flag of gfx ras variable so that gfx ras block can
> > be able to be insertted into amdgpu device ras block link list.
> > 5.Invoke amdgpu_ras_register_ras_block function to register gfx ras
> > block into amdgpu device ras block link list.
> > 6.Remove the redundant code about gfx in amdgpu_ras.c after using the
> > unified ras block.
> >
> > Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  6 +-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 15 ++---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 80 ++++++++++++++++++------
> -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 73 +++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 39 ++++++++----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 42 +++++++++----
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
> >  8 files changed, 178 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 1795d448c700..da8691259ac1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct
> > amdgpu_device *adev,
> >  	 */
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
> >  		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_count)
> > -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> > err_data);
> > +		if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +		    adev->gfx.ras->ras_block.ops->query_ras_error_count)
> > +			adev->gfx.ras->ras_block.ops-
> > >query_ras_error_count(adev, err_data);
> >  		amdgpu_ras_reset_gpu(adev);
> >  	}
> >  	return AMDGPU_RAS_SUCCESS;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 6b78b4a0e182..ff4a8428a84b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -31,6 +31,7 @@
> >  #include "amdgpu_ring.h"
> >  #include "amdgpu_rlc.h"
> >  #include "soc15.h"
> > +#include "amdgpu_ras.h"
> >
> >  /* GFX current status */
> >  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> > @@ -213,16 +214,8 @@ struct amdgpu_cu_info {
> >  	uint32_t bitmap[4][4];
> >  };
> >
> > -struct amdgpu_gfx_ras_funcs {
> > -	int (*ras_late_init)(struct amdgpu_device *adev);
> > -	void (*ras_fini)(struct amdgpu_device *adev);
> > -	int (*ras_error_inject)(struct amdgpu_device *adev,
> > -				void *inject_if);
> > -	int (*query_ras_error_count)(struct amdgpu_device *adev,
> > -				     void *ras_error_status);
> > -	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> > -	void (*query_ras_error_status)(struct amdgpu_device *adev);
> > -	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> > +struct amdgpu_gfx_ras {
> > +	struct amdgpu_ras_block_object  ras_block;
> >  	void (*enable_watchdog_timer)(struct amdgpu_device *adev);  };
>=20
> >[Tao] Can we add " enable_watchdog_timer" function into
> amdgpu_ras_block_ops structure?
> >And I think using ras_block directly is more simple than amdgpu_gfx_ras
> gfx_v9_0_ras structure.
>=20
> [Thomas] The ' enable_watchdog_timer ' function is not a common function.=
 It
> is only defined by gfx_v9_4_2.c and called in gfx_v9_0.c.
> 	   I think the function pointers in the amdgpu_ras_block_ops structure
> should be the functions used by most blocks and the final goal of
> amdgpu_ras_block_ops structure is to eliminate explicit calls to special =
blocks in
> amdgpu_ras.c file.
>                  So, I think it had better that the enable_watchdog_timer=
 function only
> use in gfx but not move to amdgpu_ras_block_ops.

[Tao] I know your concern, it's a tradeoff. Take the following code for exa=
mple, I think struct amdgpu_hdp_ras can be dropped and we can use ras_block=
 directly.

struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
	.ras_block =3D {
		.name =3D "hdp",
		.block =3D AMDGPU_RAS_BLOCK__HDP,
		.ops =3D &hdp_v4_0_ras_ops,
	},
};

The struct amdgpu_gfx_ras below can be also discarded if enable_watchdog_ti=
mer is moved to amdgpu_ras_block_ops. The current implementation is a littl=
e bit complicated.

struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
	.ras_block =3D {
		.name =3D "gfx",
		.block =3D AMDGPU_RAS_BLOCK__GFX,
		.ops =3D &gfx_v9_4_2_ras_ops,
	},
	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
};

>=20
> >
> > @@ -348,7 +341,7 @@ struct amdgpu_gfx {
> >
> >  	/*ras */
> >  	struct ras_common_if			*ras_if;
> > -	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
> > +	struct amdgpu_gfx_ras	*ras;
> >  };
> >
> >  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs-
> > >get_gpu_clock_counter((adev))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 1cf1f6331db1..190a4a4e9d7a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -862,6 +862,27 @@ static int amdgpu_ras_enable_all_features(struct
> > amdgpu_device *adev,  }
> >  /* feature ctl end */
> >
> > +static struct amdgpu_ras_block_object*
> > +amdgpu_ras_get_ras_block(struct
> > amdgpu_device *adev,
> > +					enum amdgpu_ras_block block,
> > uint32_t sub_block_index) {
> > +	struct amdgpu_ras_block_object *obj, *tmp;
> > +
> > +	if (block >=3D AMDGPU_RAS_BLOCK__LAST) {
> > +		return NULL;
> > +	}
> >[Tao] The "{}" can be dropped since only one line under the if.
>     [Thomas] OK.
>=20
> > +
> > +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> > +		if( !obj->ops || !obj->ops->ras_block_match) {
> [Tao]  Need a space after "if" and the space before "!obj" can be removed=
.
>=20
> > +			dev_info(adev->dev, "%s don't config ops or
> > ras_block_match\n", obj->name);
> > +			continue;
> > +		}
> > +		if (!obj->ops->ras_block_match(obj, block, sub_block_index)) {
> > +			return obj;
> > +		}
> >[Tao] The "{}" can be removed.
>       [Thomas] OK.
>=20
> > +	}
> > +
> > +	return NULL;
> > +}
> >[Tao] This is a generic ras function, not gfx specific, the code can be =
moved to
> patch #1.
>     [Thomas] OK.
> >
> >  void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
> >  				       struct ras_common_if *ras_block, @@ -
> > 892,6 +913,7 @@ void amdgpu_ras_mca_query_error_status(struct
> > amdgpu_device *adev,  int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  				  struct ras_query_if *info)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D NULL;
> >  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
> >  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> >  	int i;
> > @@ -899,6 +921,8 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  	if (!obj)
> >  		return -EINVAL;
> >
> > +	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
> > +
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__UMC:
> >  		if (adev->umc.ras_funcs &&
> > @@ -919,13 +943,17 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  		}
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_count)
> > -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> > &err_data);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > +				get_ras_block_str(&info->head));
> > +			return -EINVAL;
> > +		}
> >[Tao] Can we put the check behind "block_obj =3D amdgpu_ras_get_ras_bloc=
k"?
> The same suggestion to all similar code.
>        [Thomas] OK.
> > +
> > +		if (block_obj->ops->query_ras_error_count)
> > +			block_obj->ops->query_ras_error_count(adev,
> > &err_data);
> >
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_status)
> > -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> > +		if (block_obj->ops->query_ras_error_status)
> > +			block_obj->ops->query_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > @@ -1012,18 +1040,21 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> > amdgpu_device *adev,
> >  		enum amdgpu_ras_block block)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D
> > +amdgpu_ras_get_ras_block(adev, block, 0);
> >  	if (!amdgpu_ras_is_supported(adev, block))
> >  		return -EINVAL;
> >
> >  	switch (block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->reset_ras_error_count)
> > -			adev->gfx.ras_funcs->reset_ras_error_count(adev);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > ras_block_str(block));
> > +			return -EINVAL;
> > +		}
> > +		if (block_obj->ops->reset_ras_error_count)
> > +			block_obj->ops->reset_ras_error_count(adev);
> >
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->reset_ras_error_status)
> > -			adev->gfx.ras_funcs->reset_ras_error_status(adev);
> > +		if (block_obj->ops->reset_ras_error_status)
> > +			block_obj->ops->reset_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > @@ -1088,7 +1119,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> > *adev,
> >  		.address =3D info->address,
> >  		.value =3D info->value,
> >  	};
> > -	int ret =3D 0;
> > +	int ret =3D -EINVAL;
> > +	struct amdgpu_ras_block_object* block_obj =3D
> > +amdgpu_ras_get_ras_block(adev, info->head.block,
> > +info->head.sub_block_index);
> >
> >  	if (!obj)
> >  		return -EINVAL;
> > @@ -1102,11 +1134,12 @@ int amdgpu_ras_error_inject(struct
> > amdgpu_device *adev,
> >
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->ras_error_inject)
> > -			ret =3D adev->gfx.ras_funcs->ras_error_inject(adev, info);
> > -		else
> > -			ret =3D -EINVAL;
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > get_ras_block_str(&info->head));
> > +			return -EINVAL;
> > +		}
> > +		if (block_obj->ops->ras_error_inject)
> > +			ret =3D block_obj->ops->ras_error_inject(adev, info);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__UMC:
> >  	case AMDGPU_RAS_BLOCK__SDMA:
> > @@ -1727,15 +1760,20 @@ static void
> > amdgpu_ras_log_on_err_counter(struct
> > amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> > amdgpu_device *adev,
> >  					  struct ras_query_if *info)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D
> > +amdgpu_ras_get_ras_block(adev, info->head.block,
> > +info->head.sub_block_index);
> >  	/*
> >  	 * Only two block need to query read/write
> >  	 * RspStatus at current state
> >  	 */
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_status)
> > -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > get_ras_block_str(&info->head));
> > +			return ;
> > +		}
> > +
> > +		if (block_obj->ops->query_ras_error_status)
> > +			block_obj->ops->query_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 08e91e7245df..2ffde223c4f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct
> > amdgpu_device *adev,  static uint64_t
> > gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);  static
> > void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring); static u64
> > gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring); -static int
> > gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> > +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device
> > +*adev,
> >  					  void *ras_error_status);
> >  static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
> >  				     void *inject_if);
> > @@ -2118,6 +2118,18 @@ static void gfx_v9_0_select_me_pipe_q(struct
> > amdgpu_device *adev,
> >  	soc15_grbm_select(adev, me, pipe, q, vm);  }
> >
> > +static int gfx_v9_0_ras_block_match(struct amdgpu_ras_block_object*
> > +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> >[Tao] The return type can be changed to bool and return value is true or=
 false
> instead of -EINVAL and 0.
>        [Thomas] I think the return type is int maybe have more scalabilit=
y for a
> unified ops interface.

[Tao] You can use int for the convenience of scalability in the future. -EI=
NVAL means error but it refers to no matched block here, is 0 =3D=3D "no bl=
ock" and 1 =3D=3D "find block" is better?

>=20
> > +}
> >[Tao] It's better to implement a general ras block match function in
> >amdgpu_ras.c
>        [Thomas] The match method of mca block is different from other blo=
cks.
> Others blocks only use block to match, but mac block should use block and=
 sub
> block index to match.
> 	          But I can add a default match function in the amdgpu_ras.c, if=
 ip
> block does't define .ras_block_match function, it will use the default ma=
tch
> function in amdgpu_ras.c.
> > +
> >  static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
> >          .get_gpu_clock_counter =3D &gfx_v9_0_get_gpu_clock_counter,
> >          .select_se_sh =3D &gfx_v9_0_select_se_sh, @@ -2127,12 +2139,21
> > @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
> >          .select_me_pipe_q =3D &gfx_v9_0_select_me_pipe_q,  };
> >
> > -static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs =3D {
> > -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -	.ras_fini =3D amdgpu_gfx_ras_fini,
> > -	.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> > -	.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> > -	.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count,
> > +const struct amdgpu_ras_block_ops  gfx_v9_0_ras_ops =3D {
>=20
> >[Tao]  static const?
>     [Thomas] OK.
> > +		.ras_block_match =3D gfx_v9_0_ras_block_match,
> > +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +		.ras_fini =3D amdgpu_gfx_ras_fini,
> > +		.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> > +		.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> > +		.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count, };
> > +
> > +static struct amdgpu_gfx_ras gfx_v9_0_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_0_ras_ops,
> > +	},
> >  };
> >
> >  static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev) @@
> > -2161,7
> > +2182,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device
> > +*adev)
> >  		DRM_INFO("fix gfx.config for vega12\n");
> >  		break;
> >  	case CHIP_VEGA20:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_0_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_0_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2187,7 +2208,7 @@ static int gfx_v9_0_gpu_early_init(struct
> > amdgpu_device
> > *adev)
> >  			gb_addr_config =3D RAVEN_GB_ADDR_CONFIG_GOLDEN;
> >  		break;
> >  	case CHIP_ARCTURUS:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_4_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_4_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2208,7 +2229,7 @@ static int gfx_v9_0_gpu_early_init(struct
> > amdgpu_device
> > *adev)
> >  		gb_addr_config |=3D 0x22010042;
> >  		break;
> >  	case CHIP_ALDEBARAN:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_4_2_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_4_2_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2227,6 +2248,14 @@ static int gfx_v9_0_gpu_early_init(struct
> > amdgpu_device
> > *adev)
> >  		break;
> >  	}
> >
> > +	if (adev->gfx.ras) {
> > +		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> > >ras_block);
> > +		if (err) {
> > +			DRM_ERROR("Failed to register gfx ras block!\n");
> > +			return err;
> > +		}
> > +	}
> > +
> >  	adev->gfx.config.gb_addr_config =3D gb_addr_config;
> >
> >  	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << @@ -2448,9
> > +2477,9 @@ static int gfx_v9_0_sw_fini(void *handle)
> >  	int i;
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->ras_fini)
> > -		adev->gfx.ras_funcs->ras_fini(adev);
> > +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +	    adev->gfx.ras->ras_block.ops->ras_fini)
> > +		adev->gfx.ras->ras_block.ops->ras_fini(adev);
> >
> >  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> >  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> > @@ -4888,16 +4917,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
> >  	if (r)
> >  		return r;
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->ras_late_init) {
> > -		r =3D adev->gfx.ras_funcs->ras_late_init(adev);
> > +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +	    adev->gfx.ras->ras_block.ops->ras_late_init) {
> > +		r =3D adev->gfx.ras->ras_block.ops->ras_late_init(adev);
> >  		if (r)
> >  			return r;
> >  	}
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->enable_watchdog_timer)
> > -		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
> > +	if (adev->gfx.ras &&
> > +	    adev->gfx.ras->enable_watchdog_timer)
> > +		adev->gfx.ras->enable_watchdog_timer(adev);
> >
> >  	return 0;
> >  }
> > @@ -6841,7 +6870,7 @@ static void
> > gfx_v9_0_reset_ras_error_count(struct
> > amdgpu_device *adev)
> >  	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);  }
> >
> > -static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
> > +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device
> > +*adev,
> >  					  void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data
> > *)ras_error_status; @@ -6850,7 +6879,7 @@ static int
> > gfx_v9_0_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	uint32_t reg_value;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -6879,8 +6908,6 @@ static int gfx_v9_0_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >
> >  	gfx_v9_0_query_utc_edc_status(adev, err_data);
> > -
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring) diff
> > --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > index b4789dfc2bb9..2d816addbd4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > @@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct
> > amdgpu_device *adev,
> >  	return 0;
> >  }
> >
> > -static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
> > +static void gfx_v9_4_query_ras_error_count(struct amdgpu_device
> > +*adev,
> >  					  void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data
> > *)ras_error_status; @@ -872,7 +872,7 @@ static int
> > gfx_v9_4_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	uint32_t reg_value;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct
> > amdgpu_device *adev,
> >
> >  	gfx_v9_4_query_utc_edc_status(adev, err_data);
> >
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device
> > *adev) @@
> > -1029,11 +1028,31 @@ static void
> > gfx_v9_4_query_ras_error_status(struct
> > amdgpu_device *adev)
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >  }
> >
> > -const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs =3D {
> > -        .ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -        .ras_fini =3D amdgpu_gfx_ras_fini,
> > -        .ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> > -        .query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> > -        .reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> > -        .query_ras_error_status =3D &gfx_v9_4_query_ras_error_status,
> > +static int gfx_v9_4_ras_block_match(struct amdgpu_ras_block_object*
> > +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +const struct amdgpu_ras_block_ops  gfx_v9_4_ras_ops =3D {
> > +	.ras_block_match =3D gfx_v9_4_ras_block_match,
> > +	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +	.ras_fini =3D amdgpu_gfx_ras_fini,
> > +	.ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> > +	.query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> > +	.reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> > +	.query_ras_error_status =3D &gfx_v9_4_query_ras_error_status, };
> > +
> > +struct amdgpu_gfx_ras gfx_v9_4_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_4_ras_ops,
> > +	},
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > index bdd16b568021..ca520a767267 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > @@ -24,6 +24,6 @@
> >  #ifndef __GFX_V9_4_H__
> >  #define __GFX_V9_4_H__
> >
> > -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
> > +extern struct amdgpu_gfx_ras gfx_v9_4_ras;
> >
> >  #endif /* __GFX_V9_4_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > index 54306fd45ff1..2744709fa09d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > @@ -1644,14 +1644,14 @@ static int
> > gfx_v9_4_2_query_utc_edc_count(struct
> > amdgpu_device *adev,
> >  	return 0;
> >  }
> >
> > -static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device
> > *adev,
> > +static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device
> > +*adev,
> >  					    void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> >  	uint32_t sec_count =3D 0, ded_count =3D 0;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -1664,7 +1664,6 @@ static int
> > gfx_v9_4_2_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	err_data->ce_count +=3D sec_count;
> >  	err_data->ue_count +=3D ded_count;
> >
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device
> > *adev) @@
> > -1934,13 +1933,34 @@ static void
> > gfx_v9_4_2_reset_sq_timeout_status(struct
> > amdgpu_device *adev)
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >  }
> >
> > -const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs =3D {
> > -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -	.ras_fini =3D amdgpu_gfx_ras_fini,
> > -	.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> > -	.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> > -	.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> > -	.query_ras_error_status =3D &gfx_v9_4_2_query_ras_error_status,
> > -	.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> > +static int gfx_v9_4_2_ras_block_match(struct amdgpu_ras_block_object*
> > +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +struct amdgpu_ras_block_ops  gfx_v9_4_2_ras_ops =3D{
> > +		.ras_block_match =3D gfx_v9_4_2_ras_block_match,
> > +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +		.ras_fini =3D amdgpu_gfx_ras_fini,
> > +		.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> > +		.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> > +		.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> > +		.query_ras_error_status =3D
> > &gfx_v9_4_2_query_ras_error_status,
> > +		.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> > +};
> > +
> > +struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_4_2_ras_ops,
> > +	},
> >  	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > index 6db1f88509af..7584624b641c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > @@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct
> > amdgpu_device *adev,  void gfx_v9_4_2_set_power_brake_sequence(struct
> > amdgpu_device *adev);  int gfx_v9_4_2_do_edc_gpr_workarounds(struct
> > amdgpu_device *adev);
> >
> > -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
> > +extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
> >
> >  #endif /* __GFX_V9_4_2_H__ */
> > --
> > 2.25.1=
