Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C18C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 03:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF87010E431;
	Thu, 24 Apr 2025 03:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuylnJZp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1F510E71E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 03:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqyNgw9m7ipgg0iCpuZcjdiExjHE7L0daNow2MLpzZNS5uG6USk9Wh8F34uZ55RoiFIRAlUsmNg2hdhzdZTsh0bp277mw8uUThoNUUjt24gVEBvWD6uCDfMjfyKO5Oy09hukxSwb07u1shngQ5AgWhiAokAApjsN7gHIJ/2S9AC0Z2HuwAF01jjeoNZl7mY7NCswxqHJyK6BzzpyoI8MY3GR1kMUKWKNUh16FAXhfTP1PGxRvaAdWIA3DI0Ai8S/FQCqqMe9/8qu/TqhL2uDWY8KrXzMJFoKtJBVRkY9YmqMES6KbNgcjo9BfRp0FlcJviUcSx5uB50Lztl71TiP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT+wT+VYO55UHdV0CdK69JsWSPrceYQFZSdSWejXRa4=;
 b=Lf6YgDk3QoMyICoCXLHdlQU43sS1ED4OY+nbbQX0bY3qHdkiSnT/xHNxgHUFGUwhyvNiXV2WE6biwYQ7q8itdDWSphW0ZlePS+F8XjYYU82dNqqEk5BAFdoMxdNPgoWXrcYghfPNeirZOiggDQLS31vszwxFIsOnXq2iDmzLwAn6s0wmcye0cJO2jhuhCbMQzXFWwyi0UZc7eYurFVKe2dBCT/+EdvS67VW8deHIxYdfNmi0CwUUfA44RR6CZyI/bn9AgM5l9I0jDoE+R/5pWoaPON/a4i/weURVh5Bwpcs7MJEgeHs5z8p7C7Km9aFlrDoi9JxBeupi9BMGy1Kf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT+wT+VYO55UHdV0CdK69JsWSPrceYQFZSdSWejXRa4=;
 b=FuylnJZp/MqMxLZiR7cOwjWaJXQ5U0snjY4hiAqC13gU/1NZ9bUe4iNWnXOz9Dub1dEoyJGK+t6tmxMLCo7vMoXGUzoR7Z6YWrpF199P/x3tgcBrvGjJC33MVqmUtXyGnOePqQ94fzADKJfg1jpELM+4oPjYXoo8S8bwIp6G/Og=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 03:39:09 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 03:39:08 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Topic: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Index: AQHbrSrP5jEga9/xXECMUfv7z3IS+LOmU9uAgAKqkAWACTvUog==
Date: Thu, 24 Apr 2025 03:38:49 +0000
Message-ID: <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
 <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
 <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T06:37:37.7964291Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|CH3PR12MB8353:EE_
x-ms-office365-filtering-correlation-id: 4984dac5-121a-4084-aaa6-08dd82e191b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?d+L7mhzVm2pNKZhS1pXFhb+joqTDP0tknBBZ8AKO3HkbOLmWFv6u4rr7?=
 =?Windows-1252?Q?Y3Iofy1yzwlG01QfTfSQ4H+naAHtrDkiO4rqosPQ7sneAisxauCPUbTH?=
 =?Windows-1252?Q?oEGRJjGAszrWEi5oRdBCu8lEpopiW/KVWoQsM7wEb27xjx681bnUbE0+?=
 =?Windows-1252?Q?RsM+C7pZpauejrpdZ59C2Njn5Mg2CrUfa+YSDA0dQOweDvvapMEWfc5Y?=
 =?Windows-1252?Q?Ew7gT5jQuj4iXyLvl/JlLDytSWI4/SlyFbC9R15/e/YN/fIQfJp3Wg+G?=
 =?Windows-1252?Q?0dVDbFX643eywQcf1++4SXN9gvHXVGc6ABglDzC/ReMMlfUGp3DJH+/5?=
 =?Windows-1252?Q?A9h3Z39I9W3+twkUwR2bxjF+IaCHGOE/9ZCBAUx4ATv3s7rjXcvTehY+?=
 =?Windows-1252?Q?cWCFAcX3Lx2rIhEnJq2v54z86kS7udwfTVIFdM8rOFG8+Znb0u5VMAQp?=
 =?Windows-1252?Q?AQeEDTWXI16zyLKmZBVlcQ7cmqLRP+g7zdhbc4hrnjJyEWemIg9f6VMc?=
 =?Windows-1252?Q?BxjelGRecz37ezR0Wp+Mz34ZfZ460C3VkWvvMWeuSsPoLpsL5DkYP/Mw?=
 =?Windows-1252?Q?9IiXDXBKRHr9G893WIOdtwoSil6IXtgHz13M+XVeDpFSkPgRLUn5FLGS?=
 =?Windows-1252?Q?UBknd1KC+DkaIWLmqtA/mPrC7sXQzL/f1s971aub5VyYyhDeEgH3F+NR?=
 =?Windows-1252?Q?ZjXRo1T9mHYAPZgD0stkIKy9XiJrtqa/0prFGeI2SxFqRVVtLL9hGIMu?=
 =?Windows-1252?Q?YuUYDakCQpoyEsfCwn3ROaqrtI7m1hUw7iywxPUbSDJ5jzP3Mh6Ob0TG?=
 =?Windows-1252?Q?jGQa7Zv+3A7Hz5Q976qgeV7IcRGWoImlLY9FEH7bHb3xb6oA1UdtsbJy?=
 =?Windows-1252?Q?KmR8wEAzeRtf6l35xnjgq2w2mB6kObvz+eX8/9yCW31ovxj423f0BZ2C?=
 =?Windows-1252?Q?Xf3HEzoYPIB/q70wsUV2zwglIDcL5/UQUnqflzaQLBmTk7pTS1LKdCiK?=
 =?Windows-1252?Q?pxD9gvS49pl8Sd4fyCYqA9+NXA+ZxvSdrgOihiKvAgVbSH/ZpCF4JzB8?=
 =?Windows-1252?Q?aylmt9no+H2YARwFmveogfcBq4tbmcA0MmEzGj2fE+2HvGd2FIbiFJeu?=
 =?Windows-1252?Q?eysS/uGb6P+8itBj/nWTH1bE3nEwR6Nur21cAA+rJffjr+mN2JywtWsZ?=
 =?Windows-1252?Q?ritAYvtiux6hedZ/1/vJcS91c9xZPqgCf7otoUfHgvrpJPJ9blSKv5Rn?=
 =?Windows-1252?Q?5araxq6tMHISilNlyJ6BwOG7UhIUJe3UqwwAIG27JXXpF1x8sYyE/9OV?=
 =?Windows-1252?Q?eIgphE7Rko/4N6c4anAjEDxoYk6/hZg0HrbC/MirFH/QcDxgekhUhe2U?=
 =?Windows-1252?Q?0ACcqynreyof47TcBG09BZEXhXPKEkZMR8pfPmZv87dMx25C2jU49/Qr?=
 =?Windows-1252?Q?BG48hDlcAJ8ruExDfFf06iINIgH3KeI5DGF/NKEQcTAan9g2jyEzCmio?=
 =?Windows-1252?Q?8k8c3vNdzXqD+iCPzJt96IYubisE+UqTSkvfEuEkfOCaIKzMkIlnUCat?=
 =?Windows-1252?Q?mzSQU3RcDOd4Np8zASYnV5mNRbjtVcoM5WPz0RFnGACULDCO4xB2Mwoi?=
 =?Windows-1252?Q?yEg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?8k9qtdng0qAauJuqJsqYimQM0Z7qu9iZAXhmd77B1XMIdrvqvmhMyfA6?=
 =?Windows-1252?Q?PUH1zHrX/nFsbCGfSTRU5HYZif2N2UFJBAfWqjFQAu0UMUB+TUdKkX9I?=
 =?Windows-1252?Q?o+Bb7hTTYlDHjl2X+k6RjUEBBG4KQqwh1j1iEpic/zc7VpGryjBkNnvU?=
 =?Windows-1252?Q?y/6r8VHphPbjULD4bKaHSVTihNF7y5rX2FJyvLFzp3TNnu966lvT6UO/?=
 =?Windows-1252?Q?UPQft4hcVQHmJeLvCOhH+XrwiBnmY/FHHpdsHAj/aK7ofvfhW4yGkPAq?=
 =?Windows-1252?Q?Jv/L0F9/jDWa+FHO40v6CvDO+dkcxZ2O2OC/shdxN4v5EalcDB5kVvkJ?=
 =?Windows-1252?Q?Xdby/pAoNZc+DRBL4PyQGU6NYfl+iJNnw+jMlTauYJYHNdhDmr+ZDgEH?=
 =?Windows-1252?Q?Rp47YzSmhKNBXpGWPZ44cWYMmI+L2KsoZNWktAqOD4KkFHh2EoLzV4tP?=
 =?Windows-1252?Q?J9llHff31l8C0M5GRFcccpYqGnF0vOWvLqEagFYfYlH9sZpFXkzfQRyR?=
 =?Windows-1252?Q?cHfbox6PrOuXp4UtpG9wmO7/uGzopN87FUU7OYvfGpr6+7uJC9cEHHOK?=
 =?Windows-1252?Q?vsiomv3xApyChF2cbPji54BrliggZegcn/nVC0Exgnm0u88iE8fCzLXo?=
 =?Windows-1252?Q?eQUb9uVoxChPSoqr7qUAu4xHL+JjCQRmSobg+d777b8QZsto1Twmlze8?=
 =?Windows-1252?Q?O4wNA6gV9WruxwiJL4fO6mACWcdV/YWCvtzGWT3bTWkDpPVPfDrf0X5L?=
 =?Windows-1252?Q?cW5j8pub9zSRAfu1EA6b277F2Rf/Eh1mhq7ocQLWYY6mVyorWJV+2NAG?=
 =?Windows-1252?Q?ReYmEh1ZMgfY5XP9RcH/Qp3DS8+0AJuJPstbOQ+c390bu/2X1iZLf8Y0?=
 =?Windows-1252?Q?y52yu7wXcQz+dxs7KUECpRRR+Hb3GGO36eS1TP/tbnPtVZDxRtyLFsc7?=
 =?Windows-1252?Q?PqrD81oqTyBf1t/8K/4Z7IdDcSN3LCo2Nk0AxFcXr5xsUNj8koCY655A?=
 =?Windows-1252?Q?u0KKEhGrDwX0kHF4isdNiVMZQqIGiPyyA88tHkggSTR9UQK+0c7+Ay6M?=
 =?Windows-1252?Q?4D/YnMm94U4wsWu7Cy7Aw0O3owKX8XGA7ZbYgtiWPMdcVQbucbiFSSO4?=
 =?Windows-1252?Q?DeDdbu08m5QUk441SVAxpkz4lDte1nvShJEa/o+MGGSf/VzlRUWsNGzT?=
 =?Windows-1252?Q?VqKIX8dIxfaqVMm2mC1yT4Rd/tFj+RYkMDMDTR6jlMeh6cCXlPcNibXR?=
 =?Windows-1252?Q?czQ3pHG2YEK113GIBS1ymPvQmvJAAaTt3zxp4AVaTQ2JrBe8LrADkyzA?=
 =?Windows-1252?Q?adINjZOg4rFh0tZoP/ANGj5OxlYt6dbUj11PJNICuurEduegSoaIl9Lq?=
 =?Windows-1252?Q?oJcGOzdDL41M3Z15iTVkziVu2R2ZojMFHjtO1PDk0bG7SRGc/4BE8VB9?=
 =?Windows-1252?Q?lqLg647ANZlNzYWS9Qj4/hixHAJ6ZS57XN3RdlZwhbxQUH6CVJjLv+oY?=
 =?Windows-1252?Q?GMTFNtd0hqSpPIKOoYI2YDhdiB6RWmxt5DsiSYvV5s8I8nVEB64ClMl+?=
 =?Windows-1252?Q?sGwcg0zFYdGniT6YaXDDUPEAfSvKESkztz2EGRq41L+5dwty2ELwdZrQ?=
 =?Windows-1252?Q?4jRYP9w8qRltY70W8fNIrmwxjucAUA116oliTRT5Ym6rh5VwvGBYLHsq?=
 =?Windows-1252?Q?TFZvp8yPrCI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB593776A65DBB235A1A9780FBE5852DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4984dac5-121a-4084-aaa6-08dd82e191b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:39:07.9972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNEti1anRNhUwgEcvIfDp6Wk6uUpB2GG0eKyaqZYM9GNuvW80ngSepFKuKAyNHXxiy9nOn2HGkztahpgZVQeKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

--_000_DM4PR12MB593776A65DBB235A1A9780FBE5852DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping=85 @Koenig, Christian<mailto:Christian.Koenig@amd.com>

Thanks
Sam

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, G=
uoQing (Sam) <GuoQing.Zhang@amd.com>
Date: Wednesday, April 23, 2025 at 14:59
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com=
>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error

[AMD Official Use Only - AMD Internal Distribution Only]


[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>,

On QEMU VM environment, when request_irq() is called in guest KMD, QEMU wil=
l enable interrupt for the device on the host.

When hibernate and resume with a new vGPU without calling request_irq() on =
the new vGPU, the interrupt of the new vGPU is not enabled. The IH handler =
in guest KMD will not be called in this case.

This change is to ensure request_irq() is called on resume for the new vGPU=
s.

Regards
Sam

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Date: Wednesday, April 16, 2025 at 21:54
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com=
>, Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> IH is not working after switching a new gpu index for the first time.
> IH handler function need to be re-registered with kernel after switching
> to new gpu index.

Why?

Christian.

>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 19ce4da285e8..2292245a0c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>        return r;
>  }
>
> -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev)
>  {
>        if (adev->irq.installed) {
>                free_irq(adev->irq.irq, adev_to_drm(adev));
> @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>                if (adev->irq.msi_enabled)
>                        pci_free_irq_vectors(adev->pdev);
>        }
> -
> +}
> +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> +{
> +     amdgpu_irq_uninstall(adev);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.h
> index 04c0b4fa17a4..c6e6681b4f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>
>  int amdgpu_irq_init(struct amdgpu_device *adev);
> +void amdgpu_irq_uninstall(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd=
/amdgpu/vega20_ih.c
> index faa0dd75dd6d..ef996505e4dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_fini(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D vega20_ih_hw_fini(ip_block);
> +     amdgpu_irq_uninstall(adev);
> +     return r;
>  }
>
>  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  {
> -     return vega20_ih_hw_init(ip_block);
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int r =3D 0;
> +
> +     r =3D amdgpu_irq_init(adev);
> +     if (r) {
> +             dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", __=
func__, r);
> +             return r;
> +     }
> +     r =3D vega20_ih_hw_init(ip_block);
> +     return r;
>  }
>
>  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)

--_000_DM4PR12MB593776A65DBB235A1A9780FBE5852DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Ping=85
<a id=3D"OWAAM40A521FF225FC54D968E2E4F371415F5" href=3D"mailto:Christian.Ko=
enig@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Koenig, Christian</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;=
 on behalf of Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Date: </b>Wednesday, April 23, 2025 at 14:59<br>
<b>To: </b>Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;, amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;, Zhang, Owen(S=
RDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAM7B04ED50E2293946AC1575664F4D4885" href=3D"mailto:ckoenig.leic=
htzumerken@gmail.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Christian K=F6nig</span></a>,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">On QEMU VM environment, when request_irq() is called in=
 guest KMD, QEMU will enable interrupt for the device on the host.</span><o=
:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">When hibernate and resume with a new vGPU without calli=
ng request_irq() on the new vGPU, the interrupt of the new vGPU is not enab=
led. The IH handler in guest KMD will not be called
 in this case.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">This change is to ensure request_irq() is called on res=
ume for the new vGPUs.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.co=
m&gt;<br>
<b>Date: </b>Wednesday, April 16, 2025 at 21:54<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.04.25 um 12:46 =
schrieb Samuel Zhang:<br>
&gt; IH is not working after switching a new gpu index for the first time.<=
br>
&gt; IH handler function need to be re-registered with kernel after switchi=
ng<br>
&gt; to new gpu index.<br>
<br>
Why?<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<br>
&gt; Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 7 +++++--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |&nbsp; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 18 ++++++++++++++=
++--<br>
&gt;&nbsp; 3 files changed, 22 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c<br>
&gt; index 19ce4da285e8..2292245a0c5d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt; @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.installed) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free_irq(adev-&gt;irq.irq, adev_to_drm(adev));<br>
&gt; @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_fre=
e_irq_vectors(adev-&gt;pdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; +}<br>
&gt; +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih_soft);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &a=
mp;adev-&gt;irq.ih1);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.h<br>
&gt; index 04c0b4fa17a4..c6e6681b4f71 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];<=
br>
&gt;&nbsp; void amdgpu_irq_disable_all(struct amdgpu_device *adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp; int amdgpu_irq_init(struct amdgpu_device *adev);<br>
&gt; +void amdgpu_irq_uninstall(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_sw(struct amdgpu_device *adev);<br>
&gt;&nbsp; void amdgpu_irq_fini_hw(struct amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_irq_add_id(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/=
amd/amdgpu/vega20_ih.c<br>
&gt; index faa0dd75dd6d..ef996505e4dc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt; @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_bl=
ock *ip_block)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)<b=
r>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_fini(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)<br=
>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_block-&gt;=
adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;amdgpu_irq_init failed in %s, %d\n&quot;, _=
_func__, r);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_init(ip_block);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)<=
o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB593776A65DBB235A1A9780FBE5852DM4PR12MB5937namp_--
