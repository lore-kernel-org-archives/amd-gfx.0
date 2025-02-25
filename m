Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF5C021A4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 03:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5DB10E101;
	Tue, 25 Feb 2025 03:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZjqkn1W";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E8110E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 03:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdJbk1nM+SaTNKB5kyK+gfjhgxSnNEx5gfoTw/h+2n2dEXZ2/AhNW4c/ljlpdwusj/sIPa0sDmnN0HMD44Qw9Mz5Uia4UvAxpTvXhdVPdFCGO9fQQ3ulw3G4mpOCLcV+ztuIw8tZIm5IfsO7INyzpRJPImWNZqpTf4o38NiBmAbk890bDPuivfMGFMNWELrhZhi0J65qUQLni3sxbo48waJYLCt9u8i6XaE1BpGBCBP+hNv6rv60hOAHYFoKahBE6t5BSnz/62Y1U+ODjM6bn66xphkV8TcWhM7YcFQYs2FrDtJs81eWhc9X0NYCSZSLYV8VF25Uk6hL4rSfDkdZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st9sS54NFpez/tNRIVc0bXKLllwkMNGkcZANpiz9n/U=;
 b=FeiyRCZwdu++AGIN8E3QaDjxGMRcwRLb5hx8X63ycdiz5xhJH75HLq32xSKxdvVolsK2p1vThb4ypR+j6Yuqh1Uzulezz1EOHdr2PGefn648H/7OSAhb6OocKu7CCYge6unl1BeO+ty1LA3ENRmS9QF9NHZn1Svkze6EXr9dGx2yBN2kK3LDX9A422WqC92Csn+ReBeZ26tpYeBDk2VU6bbWCP8cnlvjfvxEAdiXLI0SYjpvUU9dOGOn8s0A6ZaRfDYUHETdHF2A4SmBWL4MQZLcv5y5GQuuG8zpXWWaosfJcUOqvxcXkrMAiLb4kouEWRWQJbQoAiovNWQmy2lIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st9sS54NFpez/tNRIVc0bXKLllwkMNGkcZANpiz9n/U=;
 b=BZjqkn1W0B18wpBn0+FbDudDATwTMWVICK/9swCyIviJ3kXrvZpw/fI5DTA5wL/jZ2CWBrMz/GB8GflY0v3A9ms24neNJmKfF5eZTr28PUY636T3SEYxYGXpByjyG6l4uDgw8HXgAyRAABTJnc8eGYzn57ku+xp5H5Gxjhma/5M=
Received: from CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) by
 BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 03:02:11 +0000
Received: from CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f]) by CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 03:02:11 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Topic: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Index: AQHbg2A83gtUpFkbEU2j4DQWnCY1sLNQ/U8QgAS5RlCAAYVP0IAAG+YAgAAD6nA=
Date: Tue, 25 Feb 2025 03:02:11 +0000
Message-ID: <CO6PR12MB54111ED1D569A4767C36960D8FC32@CO6PR12MB5411.namprd12.prod.outlook.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
 <20250220062515.2050499-3-Emily.Deng@amd.com>
 <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54179719DAD3729506B19EC28FC02@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417843C44D1FFBD8FC8DAD58FC32@PH0PR12MB5417.namprd12.prod.outlook.com>
 <BL3PR12MB642535FD7D55170C2AC45E0EEEC32@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB642535FD7D55170C2AC45E0EEEC32@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20eea709-1c3c-4ab6-a31b-da2884a9d2e2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T01:43:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5411:EE_|BL1PR12MB5924:EE_
x-ms-office365-filtering-correlation-id: 6b1e0b02-6eb3-4666-6eb1-08dd5548cca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?koi8-r?Q?Ac9YnonCbrkYoFXQ8hzNit95mmPF+fTWARraiKv3Iu32GjqGvRK60JCUxvXBSS?=
 =?koi8-r?Q?wVXIlGTuqcMyufqFs1FKvEq/YG9SdIk0rndsp8KBw+z3f72KBCgEanqMypobnK?=
 =?koi8-r?Q?M3K8i12b0/6bCN7vHIVSM55B2iD8cXvyBgztUEQGiENrgG3xj3410CwSn3IikQ?=
 =?koi8-r?Q?3yZRhRgaKcMzU0/UqgfNvmqqj7Sz1tbw3he+ZAl1iz/AkR0/x4fDGRJH8ndDFI?=
 =?koi8-r?Q?TL3ldo7X9bmIurQXeCv/NF55dNTuILzQqRMPW6xYK9MGAc+8RXSf7//p+9GRRD?=
 =?koi8-r?Q?CPfIsvEfEcNiqMXG9lGz67sh57IS2e6dqDEfVRqOpRcNKCLWPGMcwTdlYeUYDq?=
 =?koi8-r?Q?MsYOmcN6B1YautXwctE1UecHJtrQe5HbTe+lfIdSK5A5T53s2g5LJQiKQ0Njkm?=
 =?koi8-r?Q?bx6+TrMznTd7WEDhcLHvSkudfi89P7qvNwcnmUmoEDgorMTL/0kNTL2+ybfJOe?=
 =?koi8-r?Q?cGinMxXHWU5CHFY3oWD28rXrka2AtA3SDP6P+zp03d1kCyzU3PLFK1m+ZpYQLV?=
 =?koi8-r?Q?uGO0mYfpNzNERPEZeeGkcgQMBKJ0jghK7FbdXoN3U+cVRYNJjmFC5lHDy1V1wm?=
 =?koi8-r?Q?jRia1t2hk6zZsXdknO/dIjd9ZB4Y9QuXnAOPMy/XJ5koW5aZChWqyzJfh/QDhg?=
 =?koi8-r?Q?FUb1Fr32HJDkE015QkfR94geVsCtJ3km1a3WVgE6dO4Bw6tHvVvKa7fZZ+uTGt?=
 =?koi8-r?Q?umKgW+HD++Hk0Y3YcmHx1iXCin9kS1NePpB/HuLmwuMPdZOpc74MqrflljkALL?=
 =?koi8-r?Q?D3mFLOBrUuBEo8qU15W8ty2BBOfUCkboMsVOZMTEW37KxHPXKy5oGMbWTta9l9?=
 =?koi8-r?Q?qxSuT6PB4ZdrLw/+lu0c8/7s8y7I9AzCC+XXiS+VViHwpU7Af5KucXUNuYVnhY?=
 =?koi8-r?Q?Eo6ZvyUxoDlax8Mbk1EWs/snAGT0hsZw5IqR10OmXrt5E1pn87XjdjfOsaA5r0?=
 =?koi8-r?Q?rFlxWGSzEgu98JqUiAmXCM9elez0O/4ShlYCzRP8Lrr94A5pW3fZ99D2PvAgu7?=
 =?koi8-r?Q?qMfeGlXFJ09jl5ULbhxNB68xw22hU/B/CEwvVkNEW32KTLXFEImzeZIfRuvED8?=
 =?koi8-r?Q?cdvH7WR401AbIF3rvGuxs5/B6asCge7l7N577wyQDL5/DrT85CZTvo17C1gj0l?=
 =?koi8-r?Q?/7bYih+Eo0C7SQkO0ckBPsaXq87MOSrjomqQ1YC3E5pOUJr4OFKYS2/891AR7n?=
 =?koi8-r?Q?RAYxdzHvgk59T5asb7mOus4w0iAwmvCaNRQUjqU6LWJ7gqyH2RD4uWw0PWgAum?=
 =?koi8-r?Q?o+OHkZrFDCTDtSzNHMHpqDfqtqECJzHuMDXG9afCz1+zgz6WdPZUoC+ssVJy1k?=
 =?koi8-r?Q?AIaPzHncvyeTxv+8mqMklfCUt46uLtmmW4+PjwJ1jHT//UpO1rnCHiOq4Wy311?=
 =?koi8-r?Q?GemqrSJmIDpb4crzc20azPFEK7vfhk+NNuG4CyK02Be3M3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?nYYJiWd7RKzZ/0U/FAM87GahWWxF9dnRCELH3CD3kLrBB/viyEKNux9uomKq4+?=
 =?koi8-r?Q?3kkHjBa1eABdp+1f3jhr6M0+arBZ7keLcNFU1Rb2nT/A+iV/YLnryUEIkU1M6C?=
 =?koi8-r?Q?G8x5gnGMPi0vg6tCz2sGBIXbAPDzbakD9q9KJzxjBGgAxi5H8g5hkwPclYMxeU?=
 =?koi8-r?Q?33NUexSvMo0oEqHxf1zJt+nvIBcnp4YOzxI5KgwnzFHDGJ4iDammaTxUZvLdK3?=
 =?koi8-r?Q?pJfnMpoOiPqAADS09CbsAeZITZQs8qdQQ+AMXl3mxefy9f05T6XaeQXNpapgZo?=
 =?koi8-r?Q?D0BBLAjJmrRHpKljUp/C5nLXc/o+FFRbff46H93/Qk4yq/y+ISeExHYmqajcDP?=
 =?koi8-r?Q?FXnzae6o7u0gsYsOljTiiUFrAYpgudOsGB0Pphuctlrg8Fm+3UTzpHFgN8GIEz?=
 =?koi8-r?Q?90jKl27I1o+34zxTQpGG4BklUZ0AbcwYH8PhQWIk/S0+R9b54iHp/HJZMBGrRu?=
 =?koi8-r?Q?h5cWQOZJKPgiW3Z2EIaPMV927gx0HNqMkq5m/sO0flGXWKxb0D8Nng5U19mLQV?=
 =?koi8-r?Q?eaQO7Vp02NrgCyGRQL36PFKdG8UFqxL1WecNsp7vsIuBwVWc1cPSYxE/peE/8t?=
 =?koi8-r?Q?qH76QVfYilrpjPok6Bo1BTkkrWEm0M+HbLwYnDfwJJl7NiOa9Q1VQJkwedFuGM?=
 =?koi8-r?Q?XlTFDQIGngPVapdaD+jyRhpFuaH/rD2gSepZjMjQz/4dtDe37JJxp562KH/ONe?=
 =?koi8-r?Q?+66UFwIFdFWTmsI+stXG/EkASMAWoPyYBzT5FV3Lacfa5LNm2oELf/iXH08XMV?=
 =?koi8-r?Q?0Y57/1aEIWirLQjX70vqigGdoGh/drVNddZkYNH//RK5U22z8RpEh2QVLiPzPd?=
 =?koi8-r?Q?RFRVkn3FhekJIuxFIzActmHyPTN8OOS8LQ2SUKmiOmQyhOd/V7jv9IPWvZ2qC1?=
 =?koi8-r?Q?6TMLXwC5rkBqqKoSYFHHWrbmw6r23htgeSzhQVHVC4VUXrEeKJvwUqmP+nPOMs?=
 =?koi8-r?Q?NeEwo58WsFknfPBXlhcCltQf5bjWnC1pmUfeY2HPG0H0YtZb0kSLEXcEo/Pf1z?=
 =?koi8-r?Q?/adtoh+jtuItDTLagSmRfCMiQg+kokWb5zQsp617LuRDY5lOJMVk3t+ahzZqLv?=
 =?koi8-r?Q?dzVW9+SpTj8cLod5D11lORtxAcd0UIkpJgPISHtFe+Qc853UHNWutycGyuloL+?=
 =?koi8-r?Q?HlMTAiJ58LLIYBcxH4B+jsI5f7T0MHCp27Qliy1T8XCNHAYDgpIMUKclbcjTCG?=
 =?koi8-r?Q?zBCeP9/sxm/Wyci++Uvja/ss3acuxSS3+3IYsSA1uEKL2NMWmcHM8+bAIyMD0b?=
 =?koi8-r?Q?z8CG3eTlm0XLI7v7TGknyTcjewlXIo8VQnYYUY2Ql0yNHEOUckUFndDFZxc/YL?=
 =?koi8-r?Q?mZB2vKn/x9j0goyN8TAFKNmKVuPVCGWKPiNdhWCk9YVSm1FSr7Mmq8hw+FLSzL?=
 =?koi8-r?Q?+u15zMiyulI1gjgnvB+IG78f5fBHs5gkSEqo2NAvpa23EqyrH32efR4cWQbCLi?=
 =?koi8-r?Q?O4NkL2qr4gDNVowTeogPUjrAcmjHbyoTQHH4iZo9716Dw3FRhQm5GL2qBKifJw?=
 =?koi8-r?Q?cntjGcAKoAUe6P382PJ4C8hnHcwos=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e0b02-6eb3-4666-6eb1-08dd5548cca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 03:02:11.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpsFwxZudbXMzVkMDjZH2extxbjHb3NwEjmekE+33gKpFrB8rBXNuyJFlmKHI6eE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

Yes, I hit the page fault while doorbell_mode=3D1. Error log is as follow.

[=91~L 2=91~\~H 25 00:12:10 2025 <    0.000002>] kfd_ioctl_create_event:844=
: amdgpu: Created event (id:0x00000002) (kfd_ioctl_cree
ate_event)
[=91~L 2=91~\~H 25 00:12:10 2025 <    0.000020>] amdgpu 0000:04:00.0: amdgp=
u: [gfxhub0] no-retry page fault (src_id:0 ring:153 vmm
id:0 pasid:0)
[=91~L 2=91~\~H 25 00:12:10 2025 <    0.000123>] amdgpu 0000:04:00.0: amdgp=
u:   in page starting at address 0x00007f40fb3c1000 frr
om IH client 0x1b (UTCL2)
[=91~L 2=91~\~H 25 00:12:10 2025 <    0.000069>] amdgpu 0000:04:00.0: amdgp=
u:   cookie node_id 1 fault from die AID0.XCD0

Emily Deng
Best Wishes



>-----Original Message-----
>From: Joshi, Mukul <Mukul.Joshi@amd.com>
>Sent: Tuesday, February 25, 2025 10:45 AM
>To: Deng, Emily <Emily.Deng@amd.com>; Deng, Emily <Emily.Deng@amd.com>;
>Kuehling, Felix <Felix.Kuehling@amd.com>
>Cc: amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queu=
e
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Deng, Emily
>> Sent: Monday, February 24, 2025 8:05 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
>> queue
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Ping......
>>
>> >-----Original Message-----
>> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> >Deng, Emily
>> >Sent: Monday, February 24, 2025 9:53 AM
>> >To: Kuehling, Felix <Felix.Kuehling@amd.com>
>> >Cc: amd-gfx@lists.freedesktop.org
>> >Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
>> >queue
>> >
>> >[AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >[AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >Hi Felix,
>> >    Could you help review this? Thanks.
>> >
>> >Emily Deng
>> >Best Wishes
>> >
>> >
>> >
>> >>-----Original Message-----
>> >>From: Deng, Emily <Emily.Deng@amd.com>
>> >>Sent: Friday, February 21, 2025 9:44 AM
>> >>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> >>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while
>> >>update queue
>> >>
>> >>[AMD Official Use Only - AMD Internal Distribution Only]
>> >>
>> >>Ping......
>> >>
>> >>Emily Deng
>> >>Best Wishes
>> >>
>> >>
>> >>
>> >>>-----Original Message-----
>> >>>From: Emily Deng <Emily.Deng@amd.com>
>> >>>Sent: Thursday, February 20, 2025 2:25 PM
>> >>>To: amd-gfx@lists.freedesktop.org
>> >>>Cc: Deng, Emily <Emily.Deng@amd.com>
>> >>>Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update
>> >>>queue
>> >>>
>> >>>Avoid updating the vmid to 0 during the queue update process, as
>> >>>this may trigger a wptr poll address page fault when a ring
>> >>>doorbell is activated  in
>> >>doorbell_mode=3D1.
>
>Have you observed this page fault? If you have it, can you please paste th=
e page
>fault backtrace.
>
>> >>>
>> >>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> >>>---
>> >>> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
>> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> >>>
>> >>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> >>>b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> >>>index 6b38967d5631..3028c16264b2 100644
>> >>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> >>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> >>>@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm,
>> void
>> >**mqd,
>> >>>               m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>> >>>       }
>> >>>
>> >>>+      m->cp_hqd_vmid =3D q->vmid;
>> >>>+
>
>q->vmid would be 0 at the time of calling init_mqd when using HW
>q->scheduler as it's the
>HWS which assigns the VMID.
>Driver only assigns VMID when there is no HWS, which is not a production u=
se-case.
>
>> >>>       *mqd =3D m;
>> >>>       if (gart_addr)
>> >>>               *gart_addr =3D addr;
>> >>>@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager
>> *mm,
>> >>>void *mqd,
>> >>>
>> >>>       m->cp_hqd_iq_timer =3D 0;
>> >>>
>> >>>-      m->cp_hqd_vmid =3D q->vmid;
>
>Maybe we can just remove his vmid assignment if this is indeed causing a p=
age
>fault.
>But I haven't seen a page fault because of this before.
>
>Regards,
>Mukul
>
>> >>>-
>> >>>       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>> >>>               m->cp_hqd_pq_control |=3D
>> >>>CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>> >>>                               2 <<
>> >>>CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
>> >>>--
>> >>>2.36.1
>> >>
>

