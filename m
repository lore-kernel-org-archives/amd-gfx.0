Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDABD0C5F4
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 09:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BB510EA4D;
	Fri, 25 Oct 2024 09:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o589UGbD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D0810EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 09:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxKrQSarOJJvpKFrsEg5jkGtW/pKIBshKQTrHI8c2T/jHfPlVGlN0lVmIuVWrpm+to8Dt06yuNb6TbJ/d8KU1m+YjwF34HFO/AsR1qZUjhdET7oXyRxPdNnJQTyiBExkucSvgpQrQhZ9urI5YpsvhHUS0UX6J16uUQbClc/jmFzPAEmELmeDT9kollwQsSC1yU0+EyjUQBelPbO7ps0S80gNEt3jdS+ewj+0QJuT9t30LTDXLRryOsSNHrFvskESsFbvr2A136o03FNvSlFBW6d2XdvAu8T4re6znFRQQjPDdwhmK83RK/0ijg05LfKY2qP5KMAF9u7Ww5xXVwCLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR1XvKSWEvXkOOoL8v++IIVrOqWSYiWECrcx0mYtLv0=;
 b=UzQWhwTrlN4x8eBS4Cr9HmNBacQ/GTzBJvYqgWd53UxUJ3W7yoCfUWfNGIT5TAgI0E6DPiTGwU7z5ObkaMd8BElKAQodbkxOF0QTf5QLG9Wvrevv1n3snpAo9ywJ8XpNDAQHvaHoV6rl/F945taw8OpeoKn1EQ5Jg5+otwFdtyd9Vb/sz3LOJwH+5SOa2hp4cWE1CTFQabO4N266o2EWbBPcZuUqOkiHm/GOUKLf3Q1wKlwpBWlLUFFCtp5viXwVQHp1iv4pa6ZjUHFs5VjVmTHqYeuadJOdRR7TOaXZrkeW1WZMG7fTVMJk/GkDuSBeDqufvplVo8ub5NCFla4aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR1XvKSWEvXkOOoL8v++IIVrOqWSYiWECrcx0mYtLv0=;
 b=o589UGbDsQA5veqmynDqP3A9lXtjNHmr1WtM9uX5t3zLfVjA136btYRjWLKuQUKqw7trnHBAai2Q1Jet8uerfZQBUVli/S7kYY1kTKs/rRZRnHWokH0pNttKfIwKynC2an2iPwEl2La20x52JzSzeeWf99I4k1PR+kztUedayEE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:35:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:35:37 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Topic: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Index: AQHbJq429bp1LgoK80GKW1wS5+6ay7KXEJcAgAAf1GCAAARXEA==
Date: Fri, 25 Oct 2024 09:35:36 +0000
Message-ID: <PH7PR12MB5997D675B49C6D132C4233E2824F2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241025071922.95979-1-kevinyang.wang@amd.com>
 <fc9e60c6-2796-4ff9-b1c3-f023b07fca85@amd.com>
 <PH7PR12MB59972E180584F42E756D7D35824F2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59972E180584F42E756D7D35824F2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89770688-4582-4cb7-bb22-6ff302e918e6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-25T09:18:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL1PR12MB5706:EE_
x-ms-office365-filtering-correlation-id: 6a448fcc-0397-41fb-75ff-08dcf4d861be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zt11XV7MqpKQP00UWMtWSYxdlTVJ49yQoFCHIPCb8YSWU1NMoelfbTULtBuf?=
 =?us-ascii?Q?6s7c4elCi/gFnPQcdAm9COH8nTZaWOHZBJgJCsmJYELoU7GXp2fITm1JGCUO?=
 =?us-ascii?Q?mlm/gCkhUGOkEqAewPHI41Zy/a8cxmmIhb1qCIIZEaPVF2XZT1eLdQVaoUPy?=
 =?us-ascii?Q?7esO/xo3C7JAIgnszyiUH/RJkZfko+djdwbGP++6oTtdL6O6RwdcFerKif56?=
 =?us-ascii?Q?GPdAKAQdZlM3TQtwKkKP505Ko7O/vlnLT5QjP65n1IIjpqqaY5XYsQbAG/qq?=
 =?us-ascii?Q?AN2iSjhyZIGPZMdjSu9OepSHWCMU+AXlalMf12Mut/Hem0rEUGlBs/n6dQmH?=
 =?us-ascii?Q?2Knb/MRD7W0XgEpqsAR6Y1Hoh5h5GqK5gQPinMC/0nQW2LQNLJgW+a/leLr4?=
 =?us-ascii?Q?lpsaCEvk/odhxgchrn3yEBBW0ymqfa6JTnrp4goeZ7QZ7sv94oQyQzbkeu5V?=
 =?us-ascii?Q?NkPuLrJD5EwefvXNLDUal2zV5K2SuvAtCqknzH0gt65BHL7HF60Tq6NDJFza?=
 =?us-ascii?Q?ywJv4LK+Rigm23D+3iTDlKXPcBnr6pDVqFJ52XQWNmWm2KQ8zpQtMbeRpWHM?=
 =?us-ascii?Q?lAoQkmx1HQn39DR13kywIscG3/X6+mAuQ9v0vYnR3LcAUATYYHQPzOlLBPxJ?=
 =?us-ascii?Q?86CuZpvaEzJHf60Tsc2VWsHqr8XXuhg8PcfalL4u4iuDEJFsvoSAuSK9GOeC?=
 =?us-ascii?Q?/3NEs6K5BKwItCCdyol/Y1woLF5y1K74mTzWTb0hDgZjpazLPhAZVNHpNCY3?=
 =?us-ascii?Q?V9RSoShBSg3gRsbW/9wBMWsU+tdloZrgBORAOuP2M4KI/Q1hJG36WJv8HdxT?=
 =?us-ascii?Q?r6WmotqZw+IgmWB3e8Y70RB8ySlqoYH0DYWo6l/OiocbFLUkr9WvJQ4zGZMs?=
 =?us-ascii?Q?8JJJOCZXlT6TKmrRJRYp60Giwe9ojitjNk3mbopiR+Pw7tqj8A/fAs6wCOYD?=
 =?us-ascii?Q?RWfpz7BMIHRVZxnVPfT13bivYqxukKyOUtEMsA6tLTnqk4xqa5Nj3yAbZXU1?=
 =?us-ascii?Q?VURfrxLSJBYtf4z9cnXuvDlpnaw5FVlRopkIeXqJPyJ3CnhnIeDne1OQOYfm?=
 =?us-ascii?Q?T7Q2iv3YtiFkKPE3N7nYhy2T8ZPEVbWiP4bi/DQSRNzz8DvyV2lYeJY+cL8K?=
 =?us-ascii?Q?WJRXPXb+Slf2YkEK48lN1UQPtppFBD01GjxeiKTKtdc3qaqhEqc2cdEkqu1s?=
 =?us-ascii?Q?ONjdwDo7Z6M1Lho1fOOQxq7iuS/VlkuLAhXjWYzVhfIJkG/4dn+GrYAwOZB0?=
 =?us-ascii?Q?THPIf/HhzGKCH5QeLecZcCxUaHxgKGy8rm2SJT//zZZXAiTdgEWVA4vS5AgC?=
 =?us-ascii?Q?vqEqDPFc9/Wo6jDdn6k6ECUPwXy87t9OT/a7mkvXrMkIcC+Lg1K5OIi/4EBE?=
 =?us-ascii?Q?DQhu12M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wNhR/dhb7lCllcgV86nZy13boxn75bzwCbsUPP2UvXI5Ey979HQqY7auIFrZ?=
 =?us-ascii?Q?E2a4Ft6oijybAFU03GUWXdT3Ooe0O5SqkRStNBBuQoAproB2DnhH30tMx4zb?=
 =?us-ascii?Q?2+yNPE1kGQwaukdTjlYDoSK9dhlX6BFtVuNeaY9jZvyWbbMTXy0XV78P9hVs?=
 =?us-ascii?Q?6kfOGEYYxdZ3kAfUhosxbXSmH6obhmbUuA8rRUeswe49GqSsnIFv2Ldq4Pz8?=
 =?us-ascii?Q?vJ//Lsx+d6XbRLJfR2wpM/bm6SIJRTOo3lpgs+dAWtIPP84MrtBFPWnsmrqu?=
 =?us-ascii?Q?2iMhf8FJPcS8dIhSZEf9NbJ5/g0lNMW4a1oLTq1q/5wP5g+QEU78eSmLOUxL?=
 =?us-ascii?Q?A42OUVO+C2oY26kXEyKuSmeU93OxkhHBEmhq8tNrBYpuaDNPEQbPTuncPc1F?=
 =?us-ascii?Q?b6eJj32CDNWR2xHA+zpw961x6AnQmq7iYCFzkUPygm7jY4dMlRTEtMWhAGgt?=
 =?us-ascii?Q?nwpjq7LMbiYbWI+4VjaNaOrhn6hJgUufXaMSsxxHnM0YjGoa9HpvjfHx/+hR?=
 =?us-ascii?Q?+uXF6yunPUGoC1p6vctB9smWQXLx65qBpPFeYmHiSwslVNpM38I4ie0zypgC?=
 =?us-ascii?Q?PNaEpoaHJyKNkXnZlrBSrr9dk9lzRauYLWG1GSV+2xqZ43pCRMsnyfCWv48+?=
 =?us-ascii?Q?GacPx7A3TIAztzVVJTfrzOzrs9SjIqHx3bElsyDmVvzeaDNjBmqV7HSB10Gy?=
 =?us-ascii?Q?zqk09JNeak9n5XVPW/vEoYiTuhuaZQW44xlbSrAA/gkomxurLfkQlczFqtIv?=
 =?us-ascii?Q?2Ka8hNL7VMAVZ9FBRMVDCdH3OwAL9Caqbko2bWtp2tBp/pmnOHwejSVVFfdS?=
 =?us-ascii?Q?3f3ffCnCW7Z7vQWlbumOMOo/M/IjK0mbi1u/FxqVLBs533REi/8iNJ33DWkP?=
 =?us-ascii?Q?mUW1+gBTMNUOC/ZRN3yQ7oWFB7XGUR9CWweBnm/FgPQZiaTrEJv0x01xaqtM?=
 =?us-ascii?Q?UJyLyDqU5yf7+raeyQzMCHVdk0ti8B+uA6JrdYiiJAaC65JHy7eMOidRIkbY?=
 =?us-ascii?Q?lhJDI49YzUuftUvz7RioMY7YfugXDyY1xva/mZGr7FP55uQko+mRILJCt1Id?=
 =?us-ascii?Q?0/aR+JLFXnJk5j8KJNMwtXEWE8L16G1cxQMxkMBSjn0knr4nppE+fmn9FCbz?=
 =?us-ascii?Q?IFxqj0b1cQJbfojZadi3Af74xe3VGR4C40QsiTIWZwx9P7e9aTRmzV5A2F+d?=
 =?us-ascii?Q?1tATuEa4ifJQbjCDyLnaea744jfrCSigEiJ+eiwogrIA/CuOu1ILd0+WEGHi?=
 =?us-ascii?Q?ybnaDEOuWHQs/ke9b2P2BK93eT/GoXEE7eu/LqXy7vvtsak794vZ2iwwBQsb?=
 =?us-ascii?Q?cmmtVYoREXpkkMbGkRUaBb0JqYlYMXTxhCykj5Fh2BtR2hDKrBwHJWWHaijS?=
 =?us-ascii?Q?6beuAO6ZT45bN0MsHaVlzhH18O7WSvpuYZGP9z72bcY26TEQUah0Ua8NAHdj?=
 =?us-ascii?Q?gnG5BdoXlBws/sYvjBT/bmHiF84i+KUj6wQ4CFlkYKjFnWEX6KnYIDo3IgGn?=
 =?us-ascii?Q?MGmookOMBfkucBeRgKQE5T0sEKkdSdXWHCKh1ZyOPde4R1hR1DsHwtygzU3o?=
 =?us-ascii?Q?gU6JbSkCe+MNkIT/4Dk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a448fcc-0397-41fb-75ff-08dcf4d861be
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:35:36.9456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8KgMga5hL+VnZJAP4chuKxtJyO/HcmP2bZ2XeW7EuJyNaprm6b9fjpojJsaU2wB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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

[AMD Official Use Only - AMD Internal Distribution Only]

Fix typo, DE -> UE.

Best Regards,
Kevin

-----Original Message-----
From: Wang, Yang(Kevin)
Sent: Friday, October 25, 2024 5:20 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize ACA log print



-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 25, 2024 3:25 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: optimize ACA log print



On 10/25/2024 12:49 PM, Yang Wang wrote:
> - skip to print CE ACA log.
> - optimize ACA log print for MCA.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 18ee60378727..3ca03b5e0f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -348,6 +348,24 @@ static bool amdgpu_mca_bank_should_update(struct amd=
gpu_device *adev, enum amdgp
>       return ret;
>  }
>
> +static bool amdgpu_mca_bank_should_dump(struct amdgpu_device *adev, enum=
 amdgpu_mca_error_type type,
> +                                     struct mca_bank_entry *entry)
> +{
> +     bool ret;
> +
> +     switch (type) {
> +     case AMDGPU_MCA_ERROR_TYPE_CE:
> +             ret =3D amdgpu_mca_is_deferred_error(adev,
> +entry->regs[MCA_REG_IDX_STATUS]);

AFAIK, deferred errors are not correctable. Shouldn't it be checked against=
 AMDGPU_MCA_ERROR_TYPE_DE?

Thanks,
Lijo

[kevin]:

In this case, the type is used to indicate the SMU bank channel, only CE/UE=
 bank channel is available in SMU side.

Best Regards,
Kevin

> +             break;
> +     case AMDGPU_MCA_ERROR_TYPE_UE:
> +     default:
> +             ret =3D true;
> +             break;
> +     }
> +
> +     return ret;
> +}
> +
>  static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum a=
mdgpu_mca_error_type type, struct mca_bank_set *mca_set,
>                                     struct ras_query_context *qctx)  { @@=
 -373,7 +391,8 @@
> static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum
> amdgpu_mc
>
>               amdgpu_mca_bank_set_add_entry(mca_set, &entry);
>
> -             amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
> +             if (amdgpu_mca_bank_should_dump(adev, type, &entry))
> +                     amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx)=
;
>       }
>
>       return 0;
