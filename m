Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D2C02198
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Feb 2025 03:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A5010E023;
	Sat, 15 Feb 2025 03:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zHqJfwki";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2D310E023
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Feb 2025 03:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjZ67clfUSzdgTtykJqg+biPaBhYZn4/H7YDugmmZE2spL+wzkvURLTY6BFDVqW168DXKrZsALEHyV2ZDL+t7bOhyjOt83ABR9POsD1JfDwP+TSNw9Jm3KCFoiDOuFY5dbNRd2MBmk52cjQX/fFh0adJc1VgEmvv93WxT3pjHO/iFdJWIOdmR9ECutyBcJOFRLr6dx1ynTy9qtRcyaNcK3KJrZWO0sygVwWBHk+GB9wvIcDxo77osf+wkXAIRRK6IyGOgw6fbM8npRiV4L3osi6jD9TxfMcmyfrHM+dJPcc2G8tIrhBRgstyy14NVSw445oNj58j9UNaelPyQeA/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYs8xYF23PC5ed0cKNXrCH0Am7yUbe+2/g6t86JO1yg=;
 b=CFEIoheezc+d82GQSevdGHA5Ab5X81shEaj8RqlnpNCaFsVIw6Gg+nLQMs65QGuhLobyo8QUiprEZ7dNFvsafKv3apQ0mCdulR04yiQ6nHvX+ooCYhWp2q62xKDzDaivpd23k750YGdSbJARqumf/QJHpchFKe8bc/HN24CcMqnt52Jg21wmaYYl4CSC2rwe+EQlwvyCbbb6gpqDXZmp0hmPOkRaOmcCpOSedlKbbs5QYbRfUdANqAe4vNH0dunsEn1gGvhRgs9oHhv/D2p0TXbt9xDw42M1jG4MZI74pf80a6nZRAITaGx3EMIhDvQby76PDZBzErVEynTLVBNhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYs8xYF23PC5ed0cKNXrCH0Am7yUbe+2/g6t86JO1yg=;
 b=zHqJfwkiCjVHFpTPY8s2tfCI3UuTj+O6eYi4HVs39Tum4HGYxHwa/8fujL03fV1R+k8pHC+ToncZ7M0gMjdBy+wXyDdB8UTNViH8Kj5fX/rlvt7r9uDs/EVZCaJfSACaqdL/T1HTKO8eT+o5/lqtY3uHDy5WeJpDw7qQbQPLJaU=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sat, 15 Feb
 2025 03:35:42 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 03:35:42 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once
Thread-Index: AQHbfvPVkRimjnZ/jEuMrl0aS+yjm7NHARBAgAAC8QCAAAuhkIAAAdiAgAAAZxCAAJ4wpQ==
Date: Sat, 15 Feb 2025 03:35:41 +0000
Message-ID: <CH0PR12MB537283362B2D91721549F92BF4F92@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250214151901.2071738-1-alexander.deucher@amd.com>
 <20250214151901.2071738-2-alexander.deucher@amd.com>
 <CH0PR12MB5372425560C5BE3E4FED28B8F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F31AC0DD465DD9D63EB6F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CH0PR12MB53727651D93D9CE233CB86CFF4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <BL1PR12MB5144F2DD16616390864C9B72F7FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CH0PR12MB5372F19D2E025DD5FB23A824F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372F19D2E025DD5FB23A824F4FE2@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T17:41:34.8500000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA1PR12MB6577:EE_
x-ms-office365-filtering-correlation-id: 4d921e35-9cbf-41c3-b829-08dd4d71d2be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?Windows-1252?Q?uWYvimQ7xUNKhfcjp8djH6B8L+I4K/9kCwatwNKE06o2whSKZzKPRhxl?=
 =?Windows-1252?Q?1kkqAQCd0A0bn6t0/+mrgECbNH+Y8ew7hIi2n4VJ6mWq5yolBGNqkl86?=
 =?Windows-1252?Q?DFD6UjDCI1TsLr9Bj1F+KIujfxQQikdFtxDXIUGDmeNL7fMfKb+3mc9X?=
 =?Windows-1252?Q?FZgxsaP8CnpRLK1igYkKx3LVA03afC65zCWLrk1J+CYTDFOygmgkl9M7?=
 =?Windows-1252?Q?6BAWL2rtKXvzNn++Y5wGaVLkIGJb1P/NvhSPgtSzpyZLt6TzvXPuHD1n?=
 =?Windows-1252?Q?Q1uRF2xAET4VJDJj4Kofc9jqtkZcfsdvvt1IY22vy8CFgLekTXLDeKff?=
 =?Windows-1252?Q?6fkyDQBDHibLiAf7qxyEaYhEGF5ZugeBjVXx06CE1YImDCmZc/VcN4Ua?=
 =?Windows-1252?Q?63ga/gqhjRzS2pZryTVALCZedshugnnIqEptCKpUlFtqYsnyr9kPnbbA?=
 =?Windows-1252?Q?lo7chad41PFGyTEb4Sy1S7yufHSqcuqXYgynk+H65cx2hM+pOgkM92rC?=
 =?Windows-1252?Q?sDFvGS0HUz7EsfDUy7J0jB6O2XXMfMdH8LHNU1EaSLDT7IeZTgSRfjwo?=
 =?Windows-1252?Q?mvdbcEiEbSJYHTGEjLHmT1bE8F/UBI5YyooB2BDBBX/ncl42K2r5nAxj?=
 =?Windows-1252?Q?6weAXfOMSQv1UyqsPwaXlaAWAzkBrTf/JNM8kQkPqXnrvysZi9H5Av55?=
 =?Windows-1252?Q?NX0A1oLvTvzdKa1vzkeKXXBzwH3f5khXe/msnp8yOLLvv/8dQiBvLFkt?=
 =?Windows-1252?Q?3O54k06OrByFVYS6L+lLq11FT0xUVlaW+wLgPYKnzdXA15VGf9qRhACz?=
 =?Windows-1252?Q?da7lE3ttbzUDYcHV0h0pfmIPMPlJImGUCSq5pf+vMz50J7gs0MLYoy1N?=
 =?Windows-1252?Q?jgFpLXlwecB7RGt605lhQLPZ/FSjZled5CDza6x+fC3aqf9yX/1cIzil?=
 =?Windows-1252?Q?i8wwXKijD8iqJ1kHhZQdTFLOWyYd0RDJbJbhh11qUt57lQ0/T+RW5Ex0?=
 =?Windows-1252?Q?xvqJCHzhNe3/Kl7EoTbkb1RxDGF5G1xR1K+Jc06gbaevx3/xrTjNmmP7?=
 =?Windows-1252?Q?d3uGTj4CXUCPS4N5Ph82dZVwKe9g9MJPOgtTn3qHvLsEZllFz1xacXN+?=
 =?Windows-1252?Q?13PZ2VwJFpt9tQUjsxYnrjMPrbp4hApoCCZYTuQA8AN3mc3rADuEIIqe?=
 =?Windows-1252?Q?kmPeqlbU7sAmyxgOpPj2YeA8HnTeAaIPukZwriAzBoe2cLdUEvlrUnfr?=
 =?Windows-1252?Q?9cnYqYgRx+eeyrqk6kP8KiVdG3ocZ+h1FFI4T7zIgDvrDJwUCgbsOCta?=
 =?Windows-1252?Q?By2u01GtSvfnbgqKXOUovYJYmVJLjVh99fnY8DJKRWNRtoWq38bi1u9A?=
 =?Windows-1252?Q?n/2CWgSma5N4xSBuclF8gIyDkwivWCTAruv0mtbC+u7KDcaILFS/s4fE?=
 =?Windows-1252?Q?7w0zLkFue/9SNDpYJ6jbf15WlV23ST1qbiOsRIR20tB+RmdYm8PQF9uI?=
 =?Windows-1252?Q?9XyyanAFBaZJ7YJlxMRBGivpjqMR0yFYWrMyzyBYPqm7l63z4HbSuRsI?=
 =?Windows-1252?Q?Wfu5reAun5IxE+dX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XnaK6HyWcFuUgHhfH8yKQmNLbuqnlmNMl9X8/LXjrivuKA4ZGBXBEipc?=
 =?Windows-1252?Q?MUtnRw03fQrxWlOTx8IV6DJ0Da2aQXAmacl6v99rByyab0j77eIe/Vr0?=
 =?Windows-1252?Q?H97Mo/NVkAjWHR+NXMGGqUIa0Msi+U9DaAgKsVtGQZ+a/0NR8JJ/7rUT?=
 =?Windows-1252?Q?gX76KnehnXUc7AXcl+y7OKG/R0cb85afr/AWuJpt7mOmMHkovkPrtr6/?=
 =?Windows-1252?Q?qRAyeTKp81A4JhA+khq4VA82pPK3nKKJLt1oH8DC8FXRcQat03L9siA+?=
 =?Windows-1252?Q?YzKm67+ZppcGg/Z1dmkVFORPrTFAPALx7SpwgIZ2wCzkTYW/P/XLCv71?=
 =?Windows-1252?Q?LFhqTwa3muNOeryaPJW9x1QnCP3cD5YbU/23OhyLt/DoGz7YkH4Ochui?=
 =?Windows-1252?Q?VAV0iAIY8DnxqlrpKp5/0+teSgaciOTRgbCtxpEASuR5c8DthiYopjuz?=
 =?Windows-1252?Q?VIig1j1fISyj4iRzTQ6vXh6ut6Ovh2vkucoZ6FwdvgXPtXQ9Jmc+SK1V?=
 =?Windows-1252?Q?yMf2udRuW/Bkyu7QM8pA4mL4L6DwTAz4ZtV19mEKQKenxi99fYO8AZ00?=
 =?Windows-1252?Q?54qSr/9we8U/t0pCyRFfSY8XjC84pbT9bhPOLcJKvE74+w4+xdf0UuF3?=
 =?Windows-1252?Q?cCGErKbppxyY7cI6emz1CCdFl53EFRMccrZf8IqPBVdZLtLi5boVhmKJ?=
 =?Windows-1252?Q?uLT4yrGywGtVHewvYRhDDAKZzNoj0/tQvfWwcfrqxldzNkLMRKVWRPaW?=
 =?Windows-1252?Q?p4dj0PyFSyadh7sjH4HlFS3v4MxaDG3/4mP5+ZPg/kyjq1hUvpLBiOt4?=
 =?Windows-1252?Q?5IcaX0HI1N9xU8i1Tzlz1zUuIgkTm4u1TV4GUqP7GMIYLI0+Y1HfvBFH?=
 =?Windows-1252?Q?8B5+3xF8ZISnvKuXVNomLqO3Ywmv6E03wVUGMTJbiUhGkVPOKPGHXPMv?=
 =?Windows-1252?Q?dH3Dbqrv3D+LRgq/ZzZwQ0dojcVR2R7HYYH/VDd3cJOw36kdtXH9EzXH?=
 =?Windows-1252?Q?LyjtEtEgmTlgS2zLNLIAHhMR9/PFHia9axirJ7ftX0TENWL9MDUuZ27G?=
 =?Windows-1252?Q?aEluVXcBEOU+SdlI0OQnuFdDcMYUIBNCSAJt2OKFC0mVX/+8mmMRwSoX?=
 =?Windows-1252?Q?HwE5ACgSgAymfvSc2WorK25WFmG1MkfQdqB9jy7U6SUZi5Oe8rdK9djt?=
 =?Windows-1252?Q?EjjCSMkzWw661dzIiBGe1aDIKT7R6ywrAh5aMiUxdZsrQkNzu4E8CtUw?=
 =?Windows-1252?Q?Mg6Kh8R7Xr+3j5OQBhr+aO3VkLeqYXlOlcbmFCQnlhdhisgHZWdLffTi?=
 =?Windows-1252?Q?duiNoK4fcoFqNVJ0p/nkcwxMVrPp4OSYt/3Zyr+Y18z27osRtO1/tJQ3?=
 =?Windows-1252?Q?uNW9M4TAtNeswPYgpGxdk1OjeDWpBvfLJG2jsbnq2CT3fW5wabJdl/Sg?=
 =?Windows-1252?Q?AzItvNApmeEMOJ2rJQqaebL4RykbxL8eZPGcPdJ6VnpwqlyJUfhnpWt5?=
 =?Windows-1252?Q?0NJfJvoN2jZEu5iGNWoHsd2X7zrzXy934x21d+RWtpj6MT8JPzeb6VuV?=
 =?Windows-1252?Q?i96ZCmJ6StKSmTVxZ+t66yVLd8B4Rbqp0hifoUmxyg5giqqSobm2nZqB?=
 =?Windows-1252?Q?pyrZ7Uk4OFQwL4q95ppYDQhkZmeSTIb3U7FIueVE+ALedt7uI/9xaYnj?=
 =?Windows-1252?Q?klVM7xVgL7GJ7Lw2MajZ2WMCkGpJpPq6rRvnVmzuQCN8PMCUoya+h+6c?=
 =?Windows-1252?Q?CZkfO9iuBoKP+UNA3XYa5l/6Tv0zoXIPDSVS/6dpVzoXO4P21JJ8J7aS?=
 =?Windows-1252?Q?upl/1w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB537283362B2D91721549F92BF4F92CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d921e35-9cbf-41c3-b829-08dd4d71d2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 03:35:41.8744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kH8FBi39lQTCnprOKcn7LT9ibxq7V2KUgUjVQxkq9jalLh0kXSyGLMFP8MDWWcIRKax8Y33ZILq+wUvnshA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
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

--_000_CH0PR12MB537283362B2D91721549F92BF4F92CH0PR12MB5372namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I think I should make it more clear. When mes is been used , no matter its =
pipe0 or pipe1 , we expected both set_hw_resource and set_hw_resource_1 bee=
n called, that's requirement for mes_v12 and later . For none unified mes c=
onfig, the pipe1 will not use mes, so no mes api is required for pipe1, but=
 for pipe0, it's still the same requirement.

Regards
Shaoyun.liu

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Liu, Shaoyun
Sent: Friday, February 14, 2025 12:46:27 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce


Oh,  you right.  It=92s only for unified MES , for none-unified , it will s=
till use the kiq from CP directly on pipe1 . So there is no MES API for it =
at all . It=92s my fault . please ignore my previous comments . Your curren=
t change for this serials is good enough.



Regards

Shaoyun.liu



From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 14, 2025 12:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]



Does it matter which pipe we use for these packets?



Alex



________________________________

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 12:36 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]



Ok .  From MES point of view , we expecting  both set_hw_resource and set_h=
w_resource_1 been called all the time.



Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com<mailto:Shaoyun.liu@amd.com>>



From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Friday, February 14, 2025 11:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]



I can add that as a follow up patch as I don't want to change the current b=
ehavior to avoid a potential regression.  Should we submit both the resourc=
e and resource_1 packets all the time?



Thanks,



Alex



________________________________

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, February 14, 2025 11:45 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer on=
ce



[AMD Official Use Only - AMD Internal Distribution Only]

I'd suggest remove the  enable_uni_mes check, set_hw_resource_1 is always r=
equired for gfx12 and  up. Especially after add the  cleaner_shader_fence_a=
ddr there.

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Friday, February 14, 2025 10:19 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once

Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8dbab3834d82d..6db88584dd529 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,

 static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe) =
 {
-       unsigned int alloc_size =3D AMDGPU_GPU_PAGE_SIZE;
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D mes->adev;
        union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;

        memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt)); @@ =
-689,17 +686,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes=
 *mes, int pipe)
        mes_set_hw_res_1_pkt.header.opcode =3D MES_SCH_API_SET_HW_RSRC_1;
        mes_set_hw_res_1_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
        mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout =3D 0xa;
-
-       ret =3D amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-                               AMDGPU_GEM_DOMAIN_VRAM,
-                               &mes->resource_1,
-                               &mes->resource_1_gpu_addr,
-                               &mes->resource_1_addr);
-       if (ret) {
-               dev_err(adev->dev, "(%d) failed to create mes resource_1 bo=
\n", ret);
-               return ret;
-       }
-
        mes_set_hw_res_1_pkt.cleaner_shader_fence_mc_addr =3D
                mes->resource_1_gpu_addr;

@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)
                        return r;
        }

+       if (adev->enable_uni_mes) {
+               int ret;
+
+               ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE,=
 PAGE_SIZE,
+                                             AMDGPU_GEM_DOMAIN_VRAM,
+                                             &adev->mes.resource_1,
+                                             &adev->mes.resource_1_gpu_add=
r,
+                                             &adev->mes.resource_1_addr);
+               if (ret) {
+                       dev_err(adev->dev, "(%d) failed to create mes resou=
rce_1 bo\n", ret);
+                       return ret;
+               }
+       }
+
        return 0;
 }

@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
        struct amdgpu_device *adev =3D ip_block->adev;
        int pipe;

+       if (adev->enable_uni_mes)
+               amdgpu_bo_free_kernel(&adev->mes.resource_1,
+                                     &adev->mes.resource_1_gpu_addr,
+                                     &adev->mes.resource_1_addr);
+
        for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
                kfree(adev->mes.mqd_backup[pipe]);

@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)  {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->enable_uni_mes)
-               amdgpu_bo_free_kernel(&adev->mes.resource_1,
-                                     &adev->mes.resource_1_gpu_addr,
-                                     &adev->mes.resource_1_addr);
        return 0;
 }

--
2.48.1

--_000_CH0PR12MB537283362B2D91721549F92BF4F92CH0PR12MB5372namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">I think I should make it more clear. When mes is been used=
 , no matter its pipe0 or pipe1 , we expected both set_hw_resource and set_=
hw_resource_1 been called, that's requirement for mes_v12 and later . For n=
one unified mes config, the pipe1
 will not use mes, so no mes api is required for pipe1, but for pipe0, it's=
 still the same requirement.&nbsp;</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards</div>
<div dir=3D"ltr">Shaoyun.liu</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Shaoyun<br>
<b>Sent:</b> Friday, February 14, 2025 12:46:27 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#467886;
	text-decoration:underline}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif}
span.x_EmailStyle24
	{font-family:"Arial",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#467886" vlink=3D"purple" style=3D"word-wrap:br=
eak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Oh, &nbsp;you right. &nbsp;It=92s only for unified=
 MES , for none-unified , it will still use the kiq from CP directly on pip=
e1 . So there is no MES API for it at all . It=92s my fault
 . please ignore my previous comments . Your current change for this serial=
s is good enough.
</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Regards</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">Shaoyun.liu &nbsp;&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Arial&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Ale=
xander.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 14, 2025 12:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Does it matter which p=
ipe we use for these packets?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Alex</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.com=
</a>&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 12:36 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:11.0pt; font-family:&quo=
t;Arial&quot;,sans-serif">Ok .&nbsp; From MES point of view , we expecting =
&nbsp;both set_hw_resource and set_hw_resource_1 been called all the time.
</span></p>
<p class=3D"x_xmsonormal"><span style=3D"font-size:11.0pt; font-family:&quo=
t;Arial&quot;,sans-serif">&nbsp;</span></p>
<p class=3D"x_xmsonormal"><span style=3D"font-size:11.0pt; font-family:&quo=
t;Arial&quot;,sans-serif">Reviewed-by: Shaoyun.liu &lt;<a href=3D"mailto:Sh=
aoyun.liu@amd.com">Shaoyun.liu@amd.com</a>&gt;</span></p>
<p class=3D"x_xmsonormal"><span style=3D"font-size:11.0pt; font-family:&quo=
t;Arial&quot;,sans-serif">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_xmsonormal"><b><span style=3D"font-size:11.0pt; font-family:&=
quot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.=
0pt; font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;<a=
 href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt=
;
<br>
<b>Sent:</b> Friday, February 14, 2025 11:53 AM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span></p>
</div>
</div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Calibri&quot;,sans-serif; color:blue">[AMD Official Use Only - AMD Intern=
al Distribution Only]</span></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">I can add that as a f=
ollow up patch as I don't want to change the current behavior to avoid a po=
tential regression.&nbsp; Should we submit both the resource and resource_1=
 packets all the time?</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">Thanks,</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">Alex</span></p>
</div>
<div>
<p class=3D"x_xmsonormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_xmsonormal"><b><span style=3D"font-size:11.0pt; font-family:&=
quot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"=
font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=
 Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd.co=
m</a>&gt;<br>
<b>Sent:</b> Friday, February 14, 2025 11:45 AM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 bu=
ffer once</span>
</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsonormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_x_BM_=
BEGIN"></a><span style=3D"font-size:11.0pt; font-family:&quot;Times New Rom=
an&quot;,serif">[AMD Official Use Only - AMD Internal Distribution Only]<br=
>
<br>
I'd suggest remove the&nbsp; enable_uni_mes check, set_hw_resource_1 is alw=
ays required for gfx12 and&nbsp; up. Especially after add the&nbsp; cleaner=
_shader_fence_addr there.<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Friday, February 14, 2025 10:19 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu/mes12: allocate hw_resource_1 buffer once<b=
r>
<br>
Allocate the buffer at sw init time so we don't alloc and free it for every=
 suspend/resume or reset cycle.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 39 +++++++++++++------------=
-<br>
&nbsp;1 file changed, 19 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index 8dbab3834d82d..6db88584dd529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -678,9 +678,6 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,<br=
>
<br>
&nbsp;static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int p=
ipe)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int alloc_size =3D AMDGPU_GP=
U_PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D mes-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union MESAPI_SET_HW_RESOURCES_1 =
mes_set_hw_res_1_pkt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;mes_set_hw_res_1_pkt=
, 0, sizeof(mes_set_hw_res_1_pkt)); @@ -689,17 +686,6 @@ static int mes_v12=
_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.opco=
de =3D MES_SCH_API_SET_HW_RSRC_1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.header.dwsi=
ze =3D API_FRAME_SIZE_IN_DWORDS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.mes_kiq_unm=
ap_timeout =3D 0xa;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,=
 alloc_size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mes-&gt;resource_1_addr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) failed to create mes resource_1=
 bo\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_1_pkt.cleaner_sha=
der_fence_mc_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mes-&gt;resource_1_gpu_addr;<br>
<br>
@@ -1550,6 +1536,20 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE=
_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_gpu_a=
ddr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.resource_1_addr)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;(%d) failed to create mes resource_1 bo\n&quot;, ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1558,6 +1558,11 @@ static int mes_v12_0_sw_fini(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D i=
p_block-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe;<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGP=
U_MAX_MES_PIPES; pipe++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(adev-&gt;mes.mqd_backup[pipe]);<br>
<br>
@@ -1786,12 +1791,6 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
<br>
&nbsp;static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)&nbsp; =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_mes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;adev-&gt;mes.resource_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_gpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ad=
ev-&gt;mes.resource_1_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
--<br>
2.48.1</span></p>
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

--_000_CH0PR12MB537283362B2D91721549F92BF4F92CH0PR12MB5372namp_--
