Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E7CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6710E485;
	Fri,  4 Feb 2022 18:42:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5FE10E485
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdU9Zn87BpHFBuiHC0REyJy1jImVZmnFTidRDqiOQpiMohkYRd6AeoeGymmV1cTqkHP5cKAM9fLgEN5NzIp059EAbB8CqIX2j+g9jvNNd2HuUVqt1Bp3x4oK7wDQca7coznwYcMtno5ygx8L4Poe/jL8cl4Vxopv38vJpKozP+WXljKgJX2lToyjBG5JMmXMsmJUP72cHirI8ywN+bLOrpWdDe0FGnT1MWgehWfYMv/osovZhV8vpTeXi4mo7yh9mr9DTeZnAtK3qAU4Tn/MmT3qtkQDNNM7gKtTh9VofTfNde6zZVHbPUFKHz53Gn9k3SiZ2yZIs3SVj+6ML/FgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpbeMN1fZ5SoxssV+0+cH7LFz8VdRC1sVkQ/HVqMffo=;
 b=a9ECoOT2/+itGJJE/SrReKzyIxQNVybGmHNWzEE9oyphtGltu2C61vHxVQES5nXfzsyhlX3HQ+4BtnKl5IUZ2kn5zokBy+UDd925IE+vm1+XFOtURbQANEiV0mDDdRD7AAnCP10ygSj7M8bI6hhVEDWarnyTFeyH4pgr1SI7EPWymqHVtM2tyCPUmcIQx/WUFT4QXvHkFv/nwrxuaGniFlNfSQNdyijVniS9fJIpGN1QvM/+HOzKJIhwBFYxFPXKn7Cs/IVdSp47DlUxR1onZNZsPOXnQD1Dm8nqf06n6uBmRIMHNlQE6bPb7iND4h0IyvuN4qW7kxRlKiSE9HdgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpbeMN1fZ5SoxssV+0+cH7LFz8VdRC1sVkQ/HVqMffo=;
 b=BcK/HJYQZVAji+dPGjJosVD7LYiyxkahMMZT27MbdFYu0HAOlxhFlr06XYFT8ITh/Z3bNzEJrxjDMCYcHFYVZqpr/jVaNf2GzsGYem+8UAC1Lwxlo/RfLW9CTzACZs12UX4w4LPtOe3+H1OHbkj/zFnyH9TVEA//kXH3jr0ORT4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MWHPR1201MB0207.namprd12.prod.outlook.com (2603:10b6:301:4d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 18:42:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 18:41:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Topic: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Index: AQHYDwZgmiM6tPfbKk6pcwThDQVivaxumGUAgBUU44CAAANYgIAAAlUAgAAA3ACAAAFugIAAATOAgAABfoCAAADyAIAAAKOAgAAVUsE=
Date: Fri, 4 Feb 2022 18:41:59 +0000
Message-ID: <BL1PR12MB5144C96658B5B9F3058FCB1AF7299@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
 <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <b885ef98-3ff3-92b3-c238-041a0f5ab2a6@amd.com>
In-Reply-To: <b885ef98-3ff3-92b3-c238-041a0f5ab2a6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-04T18:41:58.752Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: aa7da581-9488-17ce-f7de-ea88a5dd20b0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 934f4bd1-f29f-4c45-13b6-08d9e80e0749
x-ms-traffictypediagnostic: MWHPR1201MB0207:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0207766BADC825211A3AD814F7299@MWHPR1201MB0207.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hUBslIOXu/g5OyaCNBk3CseRTmHl4GZP+sTKP4q+V/zb7KLhHYDvfCERLeALSg6sxdWwmvCO22QBY2LEUhG1Ta114q9v0HfeYNSafA3jJIt0mU9I6j91j1NfaTCGzroNUedlkjOcywhwAo3nkUlLTkOzAVZJg90RCPzOzwY/NnOqGQP+xj0O/VipFp58ao7CxfzNz43U+NghdNr42PRAgKwV9RQfsz9rTQSCCM7GmbNFov/w5uZX1/t+c/5jLTmSgTrn/MzGij4VNzTlmtlrzsdj6fsNumdjPq3PnV3qDGtN5Y9SEN8TyW8J4BrsIcmhn2BsT6obf1We8hifLZcPa54StIj7LE4YaXsjcehqQIG3c7RlKQ/g/f6yNOoTMDSqc8Q9LkvvD5HjMiRCcdwZHUCzqllry00F8iy/vKCaAj2uj0BwQlTYDgZzNfYsR82fsr73oujEfSNgqouM8mAd8V0gdAklToH6pOYAGdYItuovz3zD32omtAvLLOmUlseSOuEJyL43OU6jPjluimQ0UQ7dsugrp3HldK7imoUwicmmqocoQUpJBgEm1wRWcgpuSwHSCnQqWiLTpiDB7rLa3aokZO4OD1ObnOypM4kNDnzfIozVa8UE+4L6FzvvEv8j0veNrcUA1ap3cgI4PFcZ8virfM0mOBCq9qVf1WyJ0+jeuDqWROPSYGJzQF7b5EQvSyAkkzWIOOuRxG6BWgpONA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(55016003)(8676002)(66946007)(64756008)(4326008)(38070700005)(8936002)(5660300002)(2906002)(52536014)(66476007)(9686003)(7696005)(33656002)(508600001)(110136005)(54906003)(19627405001)(6506007)(26005)(86362001)(53546011)(186003)(83380400001)(71200400001)(66556008)(66446008)(316002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iD+iWDhQlJf9LshDaLNPK8NOvHwMa2ywc+uH8FSwFfLd6E6CE9NhG4hN02?=
 =?iso-8859-1?Q?70QdTO++smRI3DqA8roScwAyj3IjxRUOBHq7FOLOaMkWqwgj4IpmT38HOK?=
 =?iso-8859-1?Q?aQ9+hqpwWcIlIG16RP6zTTpKiZdRI1ULFVlqzSO1puc83M90APQ6GAZtAx?=
 =?iso-8859-1?Q?hD4wJj74lL9ie7gaReaQ/kav8NcLCx0+rSJhOxuf5WpSwCCZAT/5WkBGqP?=
 =?iso-8859-1?Q?HWohC1ZVyo/T/s34rCr7kqgV0hP1Q8b1eHLU06lhE+H2891G151sR8jU4O?=
 =?iso-8859-1?Q?O1AUKs6clI/jVU5OHrppvefOFFLjuYLoUMSy4vJkHbgBbQ1UvnHt+ol6+3?=
 =?iso-8859-1?Q?8agN5vvxjpHGJIvHn141SH8F16BJcweQ88CgCOHIrCtOpgT4GQaje13mLb?=
 =?iso-8859-1?Q?7dTZB/sroLo++qs88YqqULtd/s/wOIvptKyxNHjMR8oVNuGQrDkn4Us6Po?=
 =?iso-8859-1?Q?/KhjvhCx4fk7yUbvkRT3q8WTyzYkjH22mMgo2rRGcdV7xH4M8FiZlkuD2Z?=
 =?iso-8859-1?Q?MIabEsJ+seUsywtPVthQ9yOZ12mJeCKDWsnz/FH9PTZrkwkEvCRS1AeF2z?=
 =?iso-8859-1?Q?XmPsJZV80n3fgIBCdxvQ+E4Tkflc/FVTcLVBK9srKu4biT6Q1heV62Pwi3?=
 =?iso-8859-1?Q?MrP43r3sFrLw7Uq3Jy6CoFCXfIUy3o4NSYO3oKHcL2QNQB0aSVTCJBXLIm?=
 =?iso-8859-1?Q?PDhQnw8SYT3i1lwzrD7zQUHozyny14qvZaBKmpSScRGxPdshmY72pVE/X5?=
 =?iso-8859-1?Q?9myTs//ngaT3vwNHt7rGEiJGLWEO3cuUEpuvHkYvpiMaIMk1+KBpvEQF64?=
 =?iso-8859-1?Q?H0AlEvW8EeZEEmZCzVInZ6YJFu6leuLXRCRnDYQcUkYHPRRpybmqMmVIM5?=
 =?iso-8859-1?Q?b9+79zq6/eFykhux2CraGGlAOlByoqZL9F60Urt3ck8wILrBPJdFNw/WIQ?=
 =?iso-8859-1?Q?7+ooKmK8x9Z+yLjnmEO7q5FPYXcKgVO4BR40hIkk4rf0XrvMNMGxLOm7uG?=
 =?iso-8859-1?Q?pznEn+CH+xEh/eNdxsqkAUgebVWjtw4rnYE64hCdslBR3EjsA+MKv49rGk?=
 =?iso-8859-1?Q?KfaYD03r59ui0gPiCt+TQlqoqn1wkJ8f5ia4w6DcmIL3WXORUoxUq1zRC3?=
 =?iso-8859-1?Q?1YieZPsD+NlW8GCNXmtVn4rG67TiIcRqw8oH6pHj3Rsxdm6Mxzu/wfvkKM?=
 =?iso-8859-1?Q?ibIgjkDxN3a3OmH1wAlLsFDy+mhGuNAIQVQZu+U54zVjA988W5Hg1ujscQ?=
 =?iso-8859-1?Q?3buDw8hBgYtd+zXHtQWgHIND/stcbtoGgE06stHDjkS8mzVXyHTQtCQG8N?=
 =?iso-8859-1?Q?FGhvjchI9aVUVuRMKn4fX50jKlgaaYF4K1uvAdy2vGQo/o2OIZ6rf7tcsY?=
 =?iso-8859-1?Q?/XPsE9G3sq/qrml0Q0zc56xLlIFHiGfKLITCAECvyswYL1lzjEQDClVtLC?=
 =?iso-8859-1?Q?fkKLnr6hzq2n2Fo0sFauc1peYFIOm9CQqjBOViePw0Gvsx41xk7wbwsdMl?=
 =?iso-8859-1?Q?GodhNXKrz+FDVIx6WV3FxUj2Qab6s3LJLB0igtj7KQPnBBJxnS5UkuXnLf?=
 =?iso-8859-1?Q?GbjVArxiVt0ppO0K06a5g2CRqZnDvITfjtxNBJQI3VqM/SmsVvjAuQ6n5Q?=
 =?iso-8859-1?Q?atA8bqMToeFm2IrMXEFL8d07jrU5KOZkxDt71UQmoWchINxrt/53knJUOT?=
 =?iso-8859-1?Q?hFHobr/7YT7ZrQ6sjgY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144C96658B5B9F3058FCB1AF7299BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f4bd1-f29f-4c45-13b6-08d9e80e0749
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 18:41:59.7333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2FfCap+Ig73316ckENv4Pa0OKqlCDS2o8m264m3l4ilooNVz140NNyzHwTfxDvdrjjOkswQ03yV0QwIF+j9nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0207
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
Cc: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144C96658B5B9F3058FCB1AF7299BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

In the suspend and hibernate cases, we don't care.  In most cases the power=
 rail will be cut once the system enters suspend so it doesn't really matte=
r.  That's why we call the asic reset callback directly rather than going t=
hrough the whole recovery process.  The device is already quiescent at this=
 point we just want to make sure the device is in a known state when we com=
e out of suspend (in case suspend overall fails).

Alex


________________________________
From: Sharma, Shashank <Shashank.Sharma@amd.com>
Sent: Friday, February 4, 2022 12:22 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath =
<Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler



On 2/4/2022 6:20 PM, Lazar, Lijo wrote:
> [AMD Official Use Only]
>
> One more thing
>        In suspend-reset case, won't this cause to schedule a work item on=
 suspend? I don't know if that is a good idea, ideally we would like to cle=
an up all work items before going to suspend.
>
> Thanks,
> Lijo

Again, this opens scope for discussion. What if there is a GPU error
during suspend-reset, which is very probable case.

- Shashank

>
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Friday, February 4, 2022 10:47 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranat=
h <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>
> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>
>
>
> On 2/4/2022 6:11 PM, Lazar, Lijo wrote:
>> BTW, since this is already providing a set of values it would be useful =
to provide one more field as the reset reason - RAS error recovery, GPU hun=
g recovery or something else.
>
> Adding this additional parameter instead of blocking something in kernel,=
 seems like a better idea. The app can filter out and read what it is inter=
ested into.
>
> - Shashank

--_000_BL1PR12MB5144C96658B5B9F3058FCB1AF7299BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In the suspend and hibernate cases, we don't care.&nbsp; In most cases the =
power rail will be cut once the system enters suspend so it doesn't really =
matter.&nbsp; That's why we call the asic reset callback directly rather th=
an going through the whole recovery process.&nbsp;
 The device is already quiescent at this point we just want to make sure th=
e device is in a known state when we come out of suspend (in case suspend o=
verall fails).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Sharma, Shashank &l=
t;Shashank.Sharma@amd.com&gt;<br>
<b>Sent:</b> Friday, February 4, 2022 12:22 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapura=
m, Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;C=
hristian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 2/4/2022 6:20 PM, Lazar, Lijo wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; One more thing<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In suspend-reset case, won't=
 this cause to schedule a work item on suspend? I don't know if that is a g=
ood idea, ideally we would like to clean up all work items before going to =
suspend.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lijo<br>
<br>
Again, this opens scope for discussion. What if there is a GPU error <br>
during suspend-reset, which is very probable case.<br>
<br>
- Shashank<br>
<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;<br>
&gt; Sent: Friday, February 4, 2022 10:47 PM<br>
&gt; To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapuram,=
 Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;Chr=
istian.Koenig@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 2/4/2022 6:11 PM, Lazar, Lijo wrote:<br>
&gt;&gt; BTW, since this is already providing a set of values it would be u=
seful to provide one more field as the reset reason - RAS error recovery, G=
PU hung recovery or something else.<br>
&gt; <br>
&gt; Adding this additional parameter instead of blocking something in kern=
el, seems like a better idea. The app can filter out and read what it is in=
terested into.<br>
&gt; <br>
&gt; - Shashank<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144C96658B5B9F3058FCB1AF7299BL1PR12MB5144namp_--
