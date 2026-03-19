Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C12F107526F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A73510E8C1;
	Thu, 19 Mar 2026 07:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3u02e87e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F5F10E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDjZbLHYrbnSgpwkrJ8OQzldwZist9pmHpxcwjipzM94N8mSH+XUoe60cy6dk6HT2mIeP/Id9nbcH8jhXXBPCnxyjrVmmTlCgDobFZ9mdNMD/87vLrfW0euupuGyAVOTWHPHQ+vZ/4LuFf+SyFiKlLk3erA3wuNEvQtDc+9wYAk0zGCyvR4jhJe+cZHXBO4jYRJRub3HSqBCiG40d1VIi1Vc9dHLU4jTnjRXtVdAHCtD36FJqq5jIg9LSV+yMhnELaz0pQLK+p39CvXWZnRC36I/gNf4ko4dIHegf1tpLT87fffbNEFrjeaXSNCTPKHxyNqkcego1ycT9PQe11Xffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uZQ40zdJsThnCntxkZ2KyFijOsLorgy4tgLrgWQaEo=;
 b=ypI1pPluPZVeS+j52wEuzEq2Xi5j6VwGgEtSwvKvN2Tg/UlnQ/heHSS9m1BJ/9UMXr426xc62ONE7uMNa/kyPj/bAC2M2GatKGlNRhup3Ao8pEMc+NMNFd+WTt2xGcSWRzjSUU3JDFABOarJQzTadweLrXjHflkh3GO63LuWl0/jJJEtP9/t+tSsKZyZbTERZ9cQduj6RkWal4oYahj7MOBsfcC+fWsPxcaVwPCNMy057BRp4QcH8K78orUPHvKD9P06I+V7KXm0Ya+aWSsmZ4xAS0RcyqNj1xZZ3DbNjaz3VKuPy8oZDCCJMCE/84DEGKdreU1arO4Pav88K7lmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uZQ40zdJsThnCntxkZ2KyFijOsLorgy4tgLrgWQaEo=;
 b=3u02e87eqCDj/RxZxm2JAQQz6orJx0rxak9YbwmK7zqyrKcMfE5uf+jCAlorwqrPJfLMJdJ64Ig6nP+yqSXxsCiFkZL4ydaW93v0B9/c+lW73ZbRvgdWxcJp/b6nb3B1bqovYrxcamIl5gQAF6rrPKEi1Zy7QinJvLUaqegOrE0=
Received: from PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:43:33 +0000
Received: from PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3]) by PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::fbd5:79fe:588c:41c3%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:43:32 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Topic: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
Thread-Index: AQHctq0tde2MDjjZ2kW1JaItaybTorWz802AgAATn4CAAAHhAIABG2YAgAAwkJOAABCwAIAAEdmAgAAC+mE=
Date: Thu, 19 Mar 2026 07:43:32 +0000
Message-ID: <PH7PR12MB6633C6E2C2034AF93CCECDAEFF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
 <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
In-Reply-To: <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-19T07:43:31.922Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6633:EE_|DS0PR12MB6413:EE_
x-ms-office365-filtering-correlation-id: d87c9c7f-293f-484f-2e7b-08de858b3880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|18002099003|56012099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info: g7W9WIPBRw5aHhikrs7KKWCNAtu2vfSQfwJ82uNTQVHTfXMomeGYte6eABidoLMAutQMJ3Al9ZnPxJGjCZY8wdPcj9uaMB6RHve2ANBgQlbUT69aQSZLjjxw/ku2I+rD4JCDQ1LlBizUzW5JXr+MH5AqvBVmUa4iIwyn6yE2+AW7vo8vnyM98PQ8kWlRX78pjryjygbneHZu0CaMZ6QpcQqaAXdbPBdd8xEHeUFsEYU2smNH9UlVMrxzMKVIJSFSly5jlGc8N+9ig8p6rycKz0ChO38Rp/cwEgdHWjwIkVSWAaNQ7gD9xvZWtn5BZFVJr4zCBfjUmRqoM5mZt2wbX0FfBfd+/bS3CeYrEgv+ia9tO65HSjzv0QNdm+IXvfObdanVTBzc1VILcOup3mce1/v5TQglepVkhB/UoPCHDUoJENRKaTEOUZEeNhwvfoGtr/ZUdqwXa/1DR/Tdt+Ao/zWEvsCpTFDlnYs1zGpEsRiKvHEV1MKBFFJs2OnjZ2voj6OW2DxUf5cyaJLSKeRVqyRPetB9la3G9wzoU2woJT89q3O4FZK37b93TcmsPncoSCqiVRpwgB74MsYAye9Gu1N8p6nf/djGa5wnXZ58oIwBqxXcXX2cHE3zZDqDLHrWWUVutoM560bleevalGo00xJHGMO6k3Xtrin5/ImeJ8XiWI83eatq+Pq1CQ9NmhPp+avEqUAHiEuSwZiIYH/C0UWgXVGOyU0EzUCyI+7d/4wmjhcyBGGtSoAnuVmAIaqH5G924RV7wogKrDGyFYHB2kKh4PVJRlg8S3Rpr8i4wvLflKRPBIyEZEB705CKN4n/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(18002099003)(56012099003)(22082099003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?j6Xo16aN95+MxF75j+Kve/te+EUmJMRzIk8oXev9l16ziXTqbmvYKf+3?=
 =?Windows-1252?Q?8ykSJ/iXqgPUEgPW0NvCO1cwJx3MGvty8rSwHmy0tgXoZ4C7zR2Xul8D?=
 =?Windows-1252?Q?0f8HnWbp9IiV5eF0ORD3dck736THeCvzS0ERo+Ixlbcf2xpmURXHuCqt?=
 =?Windows-1252?Q?ITZXnFbPzsO/8dA4F0zXiITnrxHgcP/n1COjQ6AzLSl4e2jT8ULlhuPe?=
 =?Windows-1252?Q?xHG2wxAM3ft1xw5gFTrTwEB70vVCop1YRxBqRso0FS8ZpTu532cMAIKi?=
 =?Windows-1252?Q?TTrcTTsN9kS2cxZQvCfzl+Z8FWVRQOIhFsDKTaHc73zoOsVC5qxkYIv/?=
 =?Windows-1252?Q?oRfIJ+Oi5M6+P+Vj7lD2c/vqoY6hq3AlAodrHZX5iwRUm3jVRXBlxa+w?=
 =?Windows-1252?Q?AqnsmawdKNrLKECTuft/i3VY9WzRYKgUWFx1sj355FaFiyNtP/UGHe0I?=
 =?Windows-1252?Q?nl29JgheptHVG0DDIfFzRq9tIBAScFmPXx1UkWRxFAXbi/lCDyOO3jEE?=
 =?Windows-1252?Q?tYZ32hkHoolvOjLLnSUtTYOKdoNloxJ/9y9H6K0dtBUrBv8+W7SGqrmS?=
 =?Windows-1252?Q?prG1A9wz/8lOVRskLOyMsFoae3h2YwX/+CghdIVdQAkxOk6oe38pRjET?=
 =?Windows-1252?Q?jDunBruPuN6PQmiIs2eRBbzbV48dJPwYoWoz1M19xLmjuwvxqboh39c3?=
 =?Windows-1252?Q?J0dundMBg/nx3v0l+uEAh+ozfETZFm+KjeuVa09wQgD3Q8ZLwUCe6FNb?=
 =?Windows-1252?Q?gMWiEwlsOThXbjdtbneenJMnO2QOBomdibKPfCbAYwTiWOSVwsnXSsp3?=
 =?Windows-1252?Q?XzEJY8gmYBMgZ68ao8PwU8x02wUuHBE04e23AdFCKulN64zEF51veV+p?=
 =?Windows-1252?Q?db4vK8QURw60PnLegVRsgVGEYHWoAt5AQyO/ztU6d7X6Fu53YNUe4nPm?=
 =?Windows-1252?Q?wvx7OwufxmLbxIRq+zIsomZ1gfKjE8g2i4YmapT0ydVWz2cttLOYEACa?=
 =?Windows-1252?Q?lhOh38AsQGAJedTf78zzusHtWQk/VJ2OS7ytNaMyrCN1Xx3y5mK00NH4?=
 =?Windows-1252?Q?yU5pKKLNfE+zhPEbJNI31MG3ozIQy8EMnYL8sjNw85apIPB+R8Q4mPU+?=
 =?Windows-1252?Q?7zzrhnz83PH2aIK7kiRSp78GcUZUOB4QPNQrfuhQpBjyMU3s2qyu+xqp?=
 =?Windows-1252?Q?8n4HVUcczngEeh8n673Xyg4s6wtvs5xGeT9ow5e0VAs1o8meHKhpl+2C?=
 =?Windows-1252?Q?MmPjH9ZqXqYgYjppa2z+ZnwJ7p72QMw4/CYUB9jewWhjzU0/+C2iICmw?=
 =?Windows-1252?Q?4qL2iZYrUYMEjZ3LzJmbde3c3h67rLHcjo0s4S/n2Rrdv8lxcq5CwgDj?=
 =?Windows-1252?Q?AUQ0yRNIhdndhAgn0JcWENNu3zebNoXPSvwaknaM6nqXb0JoyZ0KXQns?=
 =?Windows-1252?Q?eAkootOjyZH3bfxMgGdSnFlwr8X3HlMg//doSJjQwPlktBh0hKiEqUD5?=
 =?Windows-1252?Q?8Ped2YG/SkW0blPzJrLxq3UtPrrC5aHZJti9/OhXTFZYpTwb9ugOqbMc?=
 =?Windows-1252?Q?PeGvZmcF9e6QFmZcHBBH8Ay15PRgFvTPxDb05n9jLBg03Q94Oekxlj7u?=
 =?Windows-1252?Q?XA6aUyzcTNeGE5H0xiqy4YxR+mhNtC9Kd0eoa1+kZWJu/IjirqWpWEdP?=
 =?Windows-1252?Q?adZ7VVn8Jsn2DVsaFZmHqt3g7i/fgOVOj95gMEzItcDJHe+Z7U/XN+tj?=
 =?Windows-1252?Q?vgDRbu1IAUhFxiTpD2t51O9Dg2IpbflwYsKCI8WhVOaMn8Ha7P7DkD/2?=
 =?Windows-1252?Q?5TFU++MQMnv33PRfqQosvxlzOW7Ta6yKdEFGrTGWro9EQ5Bm?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB6633C6E2C2034AF93CCECDAEFF4FAPH7PR12MB6633namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87c9c7f-293f-484f-2e7b-08de858b3880
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 07:43:32.7775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEOe1y6CqtYqqs1lZQw8SL+I8s4R3J5yMYTKUH1SJ8RwPoIiZ89kwY3q9+gVHlcwdDzU1FKwY6cxcD1P7NYXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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

--_000_PH7PR12MB6633C6E2C2034AF93CCECDAEFF4FAPH7PR12MB6633namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

alloca(0) will point to current top of stack and hence it can be said the f=
ield is initialized.

Thank you,
Yogesh

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, March 19, 2026 1:00 PM
To: Liang, Prike <Prike.Liang@amd.com>; Mohan Marimuthu, Yogesh <Yogesh.Moh=
anmarimuthu@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang, Jesse(Ji=
e) <Jesse.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; O=
lsak, Marek <Marek.Olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument =
validation"

Hi guys,

well when mesa leaves some fields in the structure uninitialized then that =
is a pretty bad idea and we should eventually fix that.

But always setting the pointers to valid arrays and just setting the number=
 of array elements to zero is perfectly valid.

That doesn't even needs a debug message.

Regards,
Christian.

On 3/19/26 07:27, Liang, Prike wrote:
> [Public]
>
>
> Thanks for the confirmation. If Mesa doesn=92t zero the handle buffer, I=
=92m going to drop this validation check in the kernel and then leave a deb=
ug message for this case.
>
>
>
> Regards,
>
>       Prike
>
>
>
> *From:*Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> *Sent:* Thursday, March 19, 2026 1:31 PM
> *To:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd=
.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Khatri, Sunil <Sunil.Khatri=
@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argum=
ent validation"
>
>
>
> [Public]
>
>
>
> Hi Prike,
>
>
>
> Regarding below check in the Kernel patch,
>
>
>
> /* Reject non-NULL pointers paired with a zero count. */
>
> if (!args->num_syncobj_handles && args->syncobj_handles)
>
>           return -EINVAL;
>
>
>
> Mesa uses alloca for args->syncobj_handles, alloca(0) returns non NULL.
>
>
>
>
>
> I think the check "Reject non-NULL pointers paired with a zero count" in =
Kernel can be skipped.
>
>
>
>
>
> Thank you,
>
> Yogesh
>
>
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
>
> *From:* Liang, Prike <Prike.Liang@amd.com <mailto:Prike.Liang@amd.com>>
> *Sent:* Thursday, March 19, 2026 8:03 AM
> *To:* Khatri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>;=
 Zhang, Jesse(Jie) <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>; Khat=
ri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Koenig, Chr=
istian <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>; Deuche=
r, Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>=
; Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com <mailto:Yogesh.Moh=
anmarimuthu@amd.com>>; Olsak, Marek <Marek.Olsak@amd.com <mailto:Marek.Olsa=
k@amd.com>>
> *Cc:* amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org=
> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argum=
ent validation"
>
>
>
> [Public]
>
> Add @Mohan Marimuthu, Yogesh/@Olsak, Marek
>
> It looks like the validation in several places doesn=92t match how Mesa a=
llocates these buffers. i.e when num_syncobj_handles is zero, syncobj_handl=
es must not be required to be NULL, because Mesa leaves it uninitialized wh=
en allocating it on the stack. We should either implement a proper fix in M=
esa for this case or drop the known broken validation check.
>
> Regards,
>       Prike
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org <mailto:amd-gfx-bou=
nces@lists.freedesktop.org>> On Behalf Of Khatri, Sunil
>> Sent: Wednesday, March 18, 2026 5:39 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>=
; Khatri, Sunil
>> <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Koenig, Christian =
<Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>> Deucher, Alexander <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@=
amd.com>>
>> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argume=
nt
>> validation"
>>
>>
>> On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:
>> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >> -----Original Message-----
>> >> From: Khatri, Sunil <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.co=
m>>
>> >> Sent: Wednesday, March 18, 2026 4:22 PM
>> >> To: Koenig, Christian <Christian.Koenig@amd.com <mailto:Christian.Koe=
nig@amd.com>>; Khatri, Sunil
>> >> <Sunil.Khatri@amd.com <mailto:Sunil.Khatri@amd.com>>; Deucher, Alexan=
der
>> >> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>
>> >> Cc: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.o=
rg>; Zhang, Jesse(Jie)
>> >> <Jesse.Zhang@amd.com <mailto:Jesse.Zhang@amd.com>>
>> >> Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl
>> >> argument validation"
>> >>
>> >>
>> >> On 18-03-2026 01:29 pm, Christian K=F6nig wrote:
>> >>> On 3/18/26 08:47, Sunil Khatri wrote:
>> >>>> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
>> >>>>
>> >>>> The patch has caused regression for userqueues where user is stuck
>> >>>> and is waiting for fences and a gpu reset is triggered in kernel.
>> >>>> Also for any of the parameters when count is zero, the driver does
>> >>>> not read from the pointer and having that check is overkill.
>> >>>>
>> >>>> Application:
>> >>>> MESA: error: amdgpu: getting wait num_fences failed
>> >>>> MESA: error: amdgpu: getting wait fences failed
>> >>>> MESA: error: amdgpu: getting wait num_fences failed
>> >>>> MESA: error: amdgpu: getting wait fences failed
>> > After I reverted this patch, the error still occurs when running glxge=
ars.
>> > Does it work fine on your end if you don't apply this patch?
>> >
>> > amdgpu: getting wait fences failed
>> > amdgpu: getting wait fences failed
>> > amdgpu: getting wait fences failed
>>
>> Yes, it works. You might need to update mesa too. I am using the latest =
mesa with
>> ubuntu and i dont see those error. with your patch they do show.
>>
>> Regards
>> Sunil Khatri
>> >
>> > Thanks
>> > Jesse
>> >
>> >
>> >>>> Dmesg:
>> >>>> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail
>> >>>> 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [
>> >>>> 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000,
>> >>>> type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0 [  124.687518]
>> >>>> amdgpu 0000:0a:00.0: Dumping IP State [  124.688351] amdgpu
>> >>>> 0000:0a:00.0: Dumping IP State Completed [  124.688355] amdgpu
>> >>>> 0000:0a:00.0: [drm] AMDGPU device coredump file has been created [
>> >>>> 124.688357] amdgpu 0000:0a:00.0: [drm] Check your
>> >>>> /sys/class/drm/card0/device/devcoredump/data
>> >>>> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout,
>> >>>> signaled seq=3D569, emitted seq=3D571 [  124.688366] amdgpu
>> >>>> 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid
>> >>>> 3479 [  124.688369] amdgpu
>> >>>> 0000:0a:00.0: Starting gfx_0.0.0 ring reset [  126.560451] amdgpu
>> >>>> 0000:0a:00.0: MES(0) failed to respond to msg=3DRESET [  126.560456=
]
>> >>>> amdgpu 0000:0a:00.0: failed to detect and reset [  126.560460]
>> >>>> amdgpu
>> >>>> 0000:0a:00.0: Failed to detect and reset queues, err (-110) [
>> >>>> 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed [
>> >>>> 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1 [
>> >>>> 128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled,
>> >>>> skipping HW
>> >> reset [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
>> >>>> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but
>> >>>> recovered through reset [  128.804574] amdgpu 0000:0a:00.0: GPU
>> >>>> reset begin!. Source:  6 [  128.816663] amdgpu 0000:0a:00.0:
>> >>>> Dumping IP State [  128.817458] amdgpu 0000:0a:00.0: Dumping IP
>> >>>> State Completed [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed
>> >>>> to respond to msg=3DREMOVE_QUEUE [  130.963949] amdgpu 0000:0a:00.0=
:
>> >>>> failed to unmap legacy queue
>> >>>>
>> >>>> Cc: Jesse Zhang <jesse.zhang@amd.com <mailto:jesse.zhang@amd.com>>
>> >>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com <mailto:sunil.kha=
tri@amd.com>>
>> >>>> ---
>> >>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 -------------=
------
>> >>>>    1 file changed, 29 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> index 3fcd70a38374..0d9a13081f2f 100644
>> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> >>>> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct
>> >>>> drm_device
>> >> *dev, void *data,
>> >>>>         args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>> >>>>             return -EINVAL;
>> >>>>
>> >>>> -  /* Reject non-NULL pointers paired with a zero count. */
>> >>>> -  if (!args->num_syncobj_handles && args->syncobj_handles)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!args->num_bo_read_handles && args->bo_read_handles)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!args->num_bo_write_handles && args->bo_write_handles)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>>     num_syncobj_handles =3D args->num_syncobj_handles;
>> >>>>     syncobj_handles =3D memdup_array_user(u64_to_user_ptr(args-
>> >>> syncobj_handles),
>> >>>>                                         num_syncobj_handles,
>> >>>> sizeof(u32)); @@ -
>> >> 950,25 +940,6 @@
>> >>>> int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> >>>>         wait_info->num_bo_read_handles >
>> >> AMDGPU_USERQ_MAX_HANDLES)
>> >>>>             return -EINVAL;
>> >>>>
>> >>>> -  /* Reject non-NULL pointers paired with a zero count: the pointe=
r
>> >>>> -   * is meaningless and indicates inconsistent input from userspac=
e.
>> >>>> -   */
>> >>>> -  if (!wait_info->num_syncobj_handles && wait_info->syncobj_handle=
s)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!wait_info->num_syncobj_timeline_handles &&
>> >>>> -      (wait_info->syncobj_timeline_handles || wait_info-
>> >>> syncobj_timeline_points))
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!wait_info->num_bo_read_handles && wait_info->bo_read_handle=
s)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!wait_info->num_bo_write_handles && wait_info->bo_write_hand=
les)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>>> -  if (!wait_info->num_fences && wait_info->out_fences)
>> >>>> -          return -EINVAL;
>> >>>> -
>> >>> Mhm, in general such checks look valid to me.
>> >>>
>> >>> My educated guess is that userspace sets num_fences =3D 0 to query i=
f
>> >>> it needs to
>> >> resize the pointer out_fences or not.
>> >>> If you have time please double check which check fails here.
>> >> Sure, i will check on that but for now i have pushed this revert.
>> >>
>> >> regards
>> >>
>> >> sunil khatri
>> >>
>> >>> Apart from that Reviewed-by: Christian K=F6nig <christian.koenig@amd=
.com <mailto:christian.koenig@amd.com>>.
>> >>>
>> >>> Regards,
>> >>> Christian.
>> >>>
>> >>>>     num_syncobj =3D wait_info->num_syncobj_handles;
>> >>>>     ptr =3D u64_to_user_ptr(wait_info->syncobj_handles);
>> >>>>     syncobj_handles =3D memdup_array_user(ptr, num_syncobj,
>> >>>> sizeof(u32));
>


--_000_PH7PR12MB6633C6E2C2034AF93CCECDAEFF4FAPH7PR12MB6633namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
alloca(0) will point to current top of stack and hence it can be said the f=
ield is initialized.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thank you,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yogesh</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, March 19, 2026 1:00 PM<br>
<b>To:</b>&nbsp;Liang, Prike &lt;Prike.Liang@amd.com&gt;; Mohan Marimuthu, =
Yogesh &lt;Yogesh.Mohanmarimuthu@amd.com&gt;; Khatri, Sunil &lt;Sunil.Khatr=
i@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Deucher, Alex=
ander &lt;Alexander.Deucher@amd.com&gt;; Olsak, Marek &lt;Marek.Olsak@amd.c=
om&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAI=
T ioctl argument validation&quot;
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi guys,<br>
<br>
well when mesa leaves some fields in the structure uninitialized then that =
is a pretty bad idea and we should eventually fix that.<br>
<br>
But always setting the pointers to valid arrays and just setting the number=
 of array elements to zero is perfectly valid.<br>
<br>
That doesn't even needs a debug message.<br>
<br>
Regards,<br>
Christian.<br>
<br>
On 3/19/26 07:27, Liang, Prike wrote:<br>
&gt; [Public]<br>
&gt;<br>
&gt;<br>
&gt; Thanks for the confirmation. If Mesa doesn=92t zero the handle buffer,=
 I=92m going to drop this validation check in the kernel and then leave a d=
ebug message for this case.<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Prike<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; *From:*Mohan Marimuthu, Yogesh &lt;Yogesh.Mohanmarimuthu@amd.com&gt;<b=
r>
&gt; *Sent:* Thursday, March 19, 2026 1:31 PM<br>
&gt; *To:* Liang, Prike &lt;Prike.Liang@amd.com&gt;; Khatri, Sunil &lt;Suni=
l.Khatri@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Khatri=
, Sunil &lt;Sunil.Khatri@amd.com&gt;; Koenig, Christian &lt;Christian.Koeni=
g@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Olsak,
 Marek &lt;Marek.Olsak@amd.com&gt;<br>
&gt; *Cc:* amd-gfx@lists.freedesktop.org<br>
&gt; *Subject:* Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT ioc=
tl argument validation&quot;<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Hi Prike,<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Regarding below check in the Kernel patch,<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; /* Reject non-NULL pointers paired with a zero count. */<br>
&gt;<br>
&gt; if (!args-&gt;num_syncobj_handles &amp;&amp; args-&gt;syncobj_handles)=
<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Mesa uses alloca for args-&gt;syncobj_handles, alloca(0) returns non N=
ULL.<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; I think the check &quot;Reject non-NULL pointers paired with a zero co=
unt&quot; in Kernel can be skipped.<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Thank you,<br>
&gt;<br>
&gt; Yogesh<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------<br>
&gt;<br>
&gt; *From:*&nbsp;Liang, Prike &lt;Prike.Liang@amd.com &lt;<a class=3D"OWAA=
utoLink" id=3D"OWA4bfe5349-c817-2b56-80a8-37b1e7685e30" href=3D"mailto:Prik=
e.Liang@amd.com">mailto:Prike.Liang@amd.com</a>&gt;&gt;<br>
&gt; *Sent:*&nbsp;Thursday, March 19, 2026 8:03 AM<br>
&gt; *To:*&nbsp;Khatri, Sunil &lt;Sunil.Khatri@amd.com &lt;<a class=3D"OWAA=
utoLink" id=3D"OWA9731cae4-1810-8939-30bd-3596b397aba8" href=3D"mailto:Suni=
l.Khatri@amd.com">mailto:Sunil.Khatri@amd.com</a>&gt;&gt;; Zhang, Jesse(Jie=
) &lt;Jesse.Zhang@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OWAc1f77a63-e2=
1b-5792-9b33-9ff9d131ffd9" href=3D"mailto:Jesse.Zhang@amd.com">mailto:Jesse=
.Zhang@amd.com</a>&gt;&gt;;
 Khatri, Sunil &lt;Sunil.Khatri@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"=
OWA395f71c8-71c1-b4b0-10bf-5aa5591ce661" href=3D"mailto:Sunil.Khatri@amd.co=
m">mailto:Sunil.Khatri@amd.com</a>&gt;&gt;; Koenig, Christian &lt;Christian=
.Koenig@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OWA5db2f4f6-53a4-0719-8d=
c9-9139c80cc606" href=3D"mailto:Christian.Koenig@amd.com">mailto:Christian.=
Koenig@amd.com</a>&gt;&gt;;
 Deucher, Alexander &lt;Alexander.Deucher@amd.com &lt;<a class=3D"OWAAutoLi=
nk" id=3D"OWA86ed15a5-3272-365a-6753-46bbd20639e1" href=3D"mailto:Alexander=
.Deucher@amd.com">mailto:Alexander.Deucher@amd.com</a>&gt;&gt;; Mohan Marim=
uthu, Yogesh &lt;Yogesh.Mohanmarimuthu@amd.com &lt;<a class=3D"OWAAutoLink"=
 id=3D"OWA8e0e471e-9020-2c51-2593-ec14f7482679" href=3D"mailto:Yogesh.Mohan=
marimuthu@amd.com">mailto:Yogesh.Mohanmarimuthu@amd.com</a>&gt;&gt;;
 Olsak, Marek &lt;Marek.Olsak@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OW=
A4db333b2-421a-3a1a-6841-27ce13af298f" href=3D"mailto:Marek.Olsak@amd.com">=
mailto:Marek.Olsak@amd.com</a>&gt;&gt;<br>
&gt; *Cc:*&nbsp;amd-gfx@lists.freedesktop.org &lt;<a class=3D"OWAAutoLink" =
id=3D"OWA17a5ed4d-9c4e-f53d-02aa-a7ac031f787c" href=3D"mailto:amd-gfx@lists=
.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>&gt; &lt;amd-gfx@=
lists.freedesktop.org &lt;<a class=3D"OWAAutoLink" id=3D"OWA7326371a-f0dc-5=
20d-a3aa-1a5a57b0c64e" href=3D"mailto:amd-gfx@lists.freedesktop.org">mailto=
:amd-gfx@lists.freedesktop.org</a>&gt;&gt;<br>
&gt; *Subject:*&nbsp;RE: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAI=
T ioctl argument validation&quot;<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; [Public]<br>
&gt;<br>
&gt; Add @Mohan Marimuthu, Yogesh/@Olsak, Marek<br>
&gt;<br>
&gt; It looks like the validation in several places doesn=92t match how Mes=
a allocates these buffers. i.e when num_syncobj_handles is zero, syncobj_ha=
ndles must not be required to be NULL, because Mesa leaves it uninitialized=
 when allocating it on the stack. We
 should either implement a proper fix in Mesa for this case or drop the kno=
wn broken validation check.<br>
&gt;<br>
&gt; Regards,<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Prike<br>
&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org &lt;<a cla=
ss=3D"OWAAutoLink" id=3D"OWAa7ab9b90-07c0-0619-6a64-b4d71bbd5aa8" href=3D"m=
ailto:amd-gfx-bounces@lists.freedesktop.org">mailto:amd-gfx-bounces@lists.f=
reedesktop.org</a>&gt;&gt; On Behalf Of Khatri, Sunil<br>
&gt;&gt; Sent: Wednesday, March 18, 2026 5:39 PM<br>
&gt;&gt; To: Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com &lt;<a class=3D"OWAA=
utoLink" id=3D"OWAd6edc85e-4081-9596-3221-d8acf2eb9af9" href=3D"mailto:Jess=
e.Zhang@amd.com">mailto:Jesse.Zhang@amd.com</a>&gt;&gt;; Khatri, Sunil<br>
&gt;&gt; &lt;Sunil.Khatri@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OWA371=
1c294-16d2-2428-0726-9ecd8a7deb5b" href=3D"mailto:Sunil.Khatri@amd.com">mai=
lto:Sunil.Khatri@amd.com</a>&gt;&gt;; Koenig, Christian &lt;Christian.Koeni=
g@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OWAf4369d89-5995-20f5-46d3-6c1=
b8c91215a" href=3D"mailto:Christian.Koenig@amd.com">mailto:Christian.Koenig=
@amd.com</a>&gt;&gt;;<br>
&gt;&gt; Deucher, Alexander &lt;Alexander.Deucher@amd.com &lt;<a class=3D"O=
WAAutoLink" id=3D"OWAe2105c77-cd2b-d07a-1304-83077abb4a0b" href=3D"mailto:A=
lexander.Deucher@amd.com">mailto:Alexander.Deucher@amd.com</a>&gt;&gt;<br>
&gt;&gt; Cc: amd-gfx@lists.freedesktop.org &lt;<a class=3D"OWAAutoLink" id=
=3D"OWAb21ac47b-9338-b3f0-45d1-1fe1c9785ae7" href=3D"mailto:amd-gfx@lists.f=
reedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>&gt;<br>
&gt;&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGNAL/WAIT i=
octl argument<br>
&gt;&gt; validation&quot;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 18-03-2026 03:02 pm, Zhang, Jesse(Jie) wrote:<br>
&gt;&gt; &gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; -----Original Message-----<br>
&gt;&gt; &gt;&gt; From: Khatri, Sunil &lt;Sunil.Khatri@amd.com &lt;<a class=
=3D"OWAAutoLink" id=3D"OWA84dcfcde-109d-4294-c791-337586d0fe9d" href=3D"mai=
lto:Sunil.Khatri@amd.com">mailto:Sunil.Khatri@amd.com</a>&gt;&gt;<br>
&gt;&gt; &gt;&gt; Sent: Wednesday, March 18, 2026 4:22 PM<br>
&gt;&gt; &gt;&gt; To: Koenig, Christian &lt;Christian.Koenig@amd.com &lt;<a=
 class=3D"OWAAutoLink" id=3D"OWA571a8c72-efc5-be3c-d058-09b21d3c2c5c" href=
=3D"mailto:Christian.Koenig@amd.com">mailto:Christian.Koenig@amd.com</a>&gt=
;&gt;; Khatri, Sunil<br>
&gt;&gt; &gt;&gt; &lt;Sunil.Khatri@amd.com &lt;<a class=3D"OWAAutoLink" id=
=3D"OWA141b7cc4-6a36-4291-e78b-03e8b718c2aa" href=3D"mailto:Sunil.Khatri@am=
d.com">mailto:Sunil.Khatri@amd.com</a>&gt;&gt;; Deucher, Alexander<br>
&gt;&gt; &gt;&gt; &lt;Alexander.Deucher@amd.com &lt;<a class=3D"OWAAutoLink=
" id=3D"OWAc4849d85-aa37-8655-bff8-efe821d8027e" href=3D"mailto:Alexander.D=
eucher@amd.com">mailto:Alexander.Deucher@amd.com</a>&gt;&gt;<br>
&gt;&gt; &gt;&gt; Cc: amd-gfx@lists.freedesktop.org &lt;<a class=3D"OWAAuto=
Link" id=3D"OWA99c9e2ce-328b-e770-b1cc-375b9d955ee0" href=3D"mailto:amd-gfx=
@lists.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>&gt;; Zhang=
, Jesse(Jie)<br>
&gt;&gt; &gt;&gt; &lt;Jesse.Zhang@amd.com &lt;<a class=3D"OWAAutoLink" id=
=3D"OWAbf359516-6256-c66f-c318-a619690c928f" href=3D"mailto:Jesse.Zhang@amd=
.com">mailto:Jesse.Zhang@amd.com</a>&gt;&gt;<br>
&gt;&gt; &gt;&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: harden SIGN=
AL/WAIT ioctl<br>
&gt;&gt; &gt;&gt; argument validation&quot;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On 18-03-2026 01:29 pm, Christian K=F6nig wrote:<br>
&gt;&gt; &gt;&gt;&gt; On 3/18/26 08:47, Sunil Khatri wrote:<br>
&gt;&gt; &gt;&gt;&gt;&gt; This reverts commit 0cdff8eb31c139dde4716e4aa3719=
8c16364629e.<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; The patch has caused regression for userqueues wh=
ere user is stuck<br>
&gt;&gt; &gt;&gt;&gt;&gt; and is waiting for fences and a gpu reset is trig=
gered in kernel.<br>
&gt;&gt; &gt;&gt;&gt;&gt; Also for any of the parameters when count is zero=
, the driver does<br>
&gt;&gt; &gt;&gt;&gt;&gt; not read from the pointer and having that check i=
s overkill.<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; Application:<br>
&gt;&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences fail=
ed<br>
&gt;&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<b=
r>
&gt;&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait num_fences fail=
ed<br>
&gt;&gt; &gt;&gt;&gt;&gt; MESA: error: amdgpu: getting wait fences failed<b=
r>
&gt;&gt; &gt; After I reverted this patch, the error still occurs when runn=
ing glxgears.<br>
&gt;&gt; &gt; Does it work fine on your end if you don't apply this patch?<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; amdgpu: getting wait fences failed<br>
&gt;&gt; &gt; amdgpu: getting wait fences failed<br>
&gt;&gt; &gt; amdgpu: getting wait fences failed<br>
&gt;&gt;<br>
&gt;&gt; Yes, it works. You might need to update mesa too. I am using the l=
atest mesa with<br>
&gt;&gt; ubuntu and i dont see those error. with your patch they do show.<b=
r>
&gt;&gt;<br>
&gt;&gt; Regards<br>
&gt;&gt; Sunil Khatri<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks<br>
&gt;&gt; &gt; Jesse<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; Dmesg:<br>
&gt;&gt; &gt;&gt;&gt;&gt; [&nbsp; 122.668493] amdgpu 0000:0a:00.0: sq_intr:=
 error, detail<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd=
_id 0, wgp_id 0 [<br>
&gt;&gt; &gt;&gt;&gt;&gt; 122.668504] amdgpu 0000:0a:00.0: sq_intr: error, =
detail 0x00000000,<br>
&gt;&gt; &gt;&gt;&gt;&gt; type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_i=
d 0 [&nbsp; 124.687518]<br>
&gt;&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: Dumping IP State [&nbsp; 124=
.688351] amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Dumping IP State Completed [&nbsp; =
124.688355] amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: [drm] AMDGPU device coredump file h=
as been created [<br>
&gt;&gt; &gt;&gt;&gt;&gt; 124.688357] amdgpu 0000:0a:00.0: [drm] Check your=
<br>
&gt;&gt; &gt;&gt;&gt;&gt; /sys/class/drm/card0/device/devcoredump/data<br>
&gt;&gt; &gt;&gt;&gt;&gt; [&nbsp; 124.688361] amdgpu 0000:0a:00.0: ring gfx=
_0.0.0 timeout,<br>
&gt;&gt; &gt;&gt;&gt;&gt; signaled seq=3D569, emitted seq=3D571 [&nbsp; 124=
.688366] amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0:&nbsp; Process Xwayland pid 3471 thr=
ead Xwayland:cs0 pid<br>
&gt;&gt; &gt;&gt;&gt;&gt; 3479 [&nbsp; 124.688369] amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Starting gfx_0.0.0 ring reset [&nbs=
p; 126.560451] amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: MES(0) failed to respond to msg=3DR=
ESET [&nbsp; 126.560456]<br>
&gt;&gt; &gt;&gt;&gt;&gt; amdgpu 0000:0a:00.0: failed to detect and reset [=
&nbsp; 126.560460]<br>
&gt;&gt; &gt;&gt;&gt;&gt; amdgpu<br>
&gt;&gt; &gt;&gt;&gt;&gt; 0000:0a:00.0: Failed to detect and reset queues, =
err (-110) [<br>
&gt;&gt; &gt;&gt;&gt;&gt; 128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 r=
eset failed [<br>
&gt;&gt; &gt;&gt;&gt;&gt; 128.789848] amdgpu 0000:0a:00.0: GPU reset begin!=
. Source:&nbsp; 1 [<br>
&gt;&gt; &gt;&gt;&gt;&gt; 128.790161] amdgpu 0000:0a:00.0: Guilty job alrea=
dy signaled,<br>
&gt;&gt; &gt;&gt;&gt;&gt; skipping HW<br>
&gt;&gt; &gt;&gt; reset [&nbsp; 128.790174] amdgpu 0000:0a:00.0: GPU reset(=
1) succeeded!<br>
&gt;&gt; &gt;&gt;&gt;&gt; [&nbsp; 128.804538] amdgpu 0000:0a:00.0: [drm] de=
vice wedged, but<br>
&gt;&gt; &gt;&gt;&gt;&gt; recovered through reset [&nbsp; 128.804574] amdgp=
u 0000:0a:00.0: GPU<br>
&gt;&gt; &gt;&gt;&gt;&gt; reset begin!. Source:&nbsp; 6 [&nbsp; 128.816663]=
 amdgpu 0000:0a:00.0:<br>
&gt;&gt; &gt;&gt;&gt;&gt; Dumping IP State [&nbsp; 128.817458] amdgpu 0000:=
0a:00.0: Dumping IP<br>
&gt;&gt; &gt;&gt;&gt;&gt; State Completed [&nbsp; 130.963939] amdgpu 0000:0=
a:00.0: MES(1) failed<br>
&gt;&gt; &gt;&gt;&gt;&gt; to respond to msg=3DREMOVE_QUEUE [&nbsp; 130.9639=
49] amdgpu 0000:0a:00.0:<br>
&gt;&gt; &gt;&gt;&gt;&gt; failed to unmap legacy queue<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; Cc: Jesse Zhang &lt;jesse.zhang@amd.com &lt;<a cl=
ass=3D"OWAAutoLink" id=3D"OWA13625298-8b04-d9c8-98f0-fa604b828342" href=3D"=
mailto:jesse.zhang@amd.com">mailto:jesse.zhang@amd.com</a>&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.=
com &lt;<a class=3D"OWAAutoLink" id=3D"OWAd83430b3-77d2-c460-8ffa-e69074df9=
d5f" href=3D"mailto:sunil.khatri@amd.com">mailto:sunil.khatri@amd.com</a>&g=
t;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; ---<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_u=
serq_fence.c&nbsp;&nbsp; | 29 -------------------<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 29 deletions(-)=
<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_us=
erq_fence.c<br>
&gt;&gt; &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=
<br>
&gt;&gt; &gt;&gt;&gt;&gt; index 3fcd70a38374..0d9a13081f2f 100644<br>
&gt;&gt; &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fen=
ce.c<br>
&gt;&gt; &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fen=
ce.c<br>
&gt;&gt; &gt;&gt;&gt;&gt; @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioct=
l(struct<br>
&gt;&gt; &gt;&gt;&gt;&gt; drm_device<br>
&gt;&gt; &gt;&gt; *dev, void *data,<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
rgs-&gt;num_bo_read_handles &gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a=
 zero count. */<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_syncobj_handles &amp;&a=
mp; args-&gt;syncobj_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_read_handles &amp;&a=
mp; args-&gt;bo_read_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!args-&gt;num_bo_write_handles &amp;&=
amp; args-&gt;bo_write_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles =3D a=
rgs-&gt;num_syncobj_handles;<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdu=
p_array_user(u64_to_user_ptr(args-<br>
&gt;&gt; &gt;&gt;&gt; syncobj_handles),<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj_handles,<br>
&gt;&gt; &gt;&gt;&gt;&gt; sizeof(u32)); @@ -<br>
&gt;&gt; &gt;&gt; 950,25 +940,6 @@<br>
&gt;&gt; &gt;&gt;&gt;&gt; int amdgpu_userq_wait_ioctl(struct drm_device *de=
v, void *data,<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; w=
ait_info-&gt;num_bo_read_handles &gt;<br>
&gt;&gt; &gt;&gt; AMDGPU_USERQ_MAX_HANDLES)<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; /* Reject non-NULL pointers paired with a=
 zero count: the pointer<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; * is meaningless and indicates inco=
nsistent input from userspace.<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp; */<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_handles &a=
mp;&amp; wait_info-&gt;syncobj_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_syncobj_timeline_h=
andles &amp;&amp;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (wait_info-&gt;sy=
ncobj_timeline_handles || wait_info-<br>
&gt;&gt; &gt;&gt;&gt; syncobj_timeline_points))<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_read_handles &a=
mp;&amp; wait_info-&gt;bo_read_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_bo_write_handles &=
amp;&amp; wait_info-&gt;bo_write_handles)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp; if (!wait_info-&gt;num_fences &amp;&amp; =
wait_info-&gt;out_fences)<br>
&gt;&gt; &gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return -EINVAL;<br>
&gt;&gt; &gt;&gt;&gt;&gt; -<br>
&gt;&gt; &gt;&gt;&gt; Mhm, in general such checks look valid to me.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; My educated guess is that userspace sets num_fences =
=3D 0 to query if<br>
&gt;&gt; &gt;&gt;&gt; it needs to<br>
&gt;&gt; &gt;&gt; resize the pointer out_fences or not.<br>
&gt;&gt; &gt;&gt;&gt; If you have time please double check which check fail=
s here.<br>
&gt;&gt; &gt;&gt; Sure, i will check on that but for now i have pushed this=
 revert.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; regards<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; sunil khatri<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Apart from that Reviewed-by: Christian K=F6nig &lt;ch=
ristian.koenig@amd.com &lt;<a class=3D"OWAAutoLink" id=3D"OWA1acd249f-4cad-=
6caf-62af-fdf1ea2c1534" href=3D"mailto:christian.koenig@amd.com">mailto:chr=
istian.koenig@amd.com</a>&gt;&gt;.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt; Regards,<br>
&gt;&gt; &gt;&gt;&gt; Christian.<br>
&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; num_syncobj =3D wait_info=
-&gt;num_syncobj_handles;<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ptr =3D u64_to_user_ptr(w=
ait_info-&gt;syncobj_handles);<br>
&gt;&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; syncobj_handles =3D memdu=
p_array_user(ptr, num_syncobj,<br>
&gt;&gt; &gt;&gt;&gt;&gt; sizeof(u32));<br>
&gt;<br>
<br>
</div>
</body>
</html>

--_000_PH7PR12MB6633C6E2C2034AF93CCECDAEFF4FAPH7PR12MB6633namp_--
