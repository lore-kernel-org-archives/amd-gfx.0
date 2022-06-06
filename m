Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99282C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D89211266E;
	Mon,  6 Jun 2022 18:11:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445E411266E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 18:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1i+ARl8nmAub4xGgzSx0z6shD0lZIboSooynmefIc8qLPT8l5PxZG3uhDg3Vog2FFwhSEBZrgcibRkjbHoZunyFPenyAkrNXXiLrkTfrjh0ovDAHZ8eN4j82aexjKO4WuENai0hUfiHXw15F9XMKl0sLEKnUxSj8UEx2hidmn7BjBh0vS05zKOD8VH/2wrLYTXhUQ31WUbS6rEKtR/ZPAJN2I7C48VIDsf7o0pQQ3FcXfL5OU2nw+H5FTow0T2Cj2yTFPFCeBklYUeywkO6ZNW4GslQLGQUJOGmVcJ6Mfa0JSieyFWeIdV8OPnIGwM9X4jKHKcmz4sbZaWUIyqA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3QQrfmup2BR4nNHhZNU20p3VxdDWDC5Z+/yxaVPh38=;
 b=jFZOeMxFmWNLRGJx8jAGT5Rl1e9Je+DtNGmtwu1vqRTxie1PlOjfJsPQEoSeQlNwKigJa9pS2gSDVRxFFLDsjmWIhgHDCioGhUD6oNL2+hM2rsD8Ia+o50KHtV/oYnjEh5FtuI88BE0HfjBDWWdwpY89JmrnU3JvHJ3Ib1b+lxBSXUaYIybA+atqohimKdY4wX2ulvGtxhslKPaZcSp1x6t6p4Ici+AT4fZ5DZ80VCxbrea33GGScIfatLNPi/j56MHhwS51TD27tdjFyn/Pz67NatFbOfYoFxQxLnF18C2QC1REVV/5f+FKzyAeYCn8ewR+jzps5yMaPQkeHpQukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3QQrfmup2BR4nNHhZNU20p3VxdDWDC5Z+/yxaVPh38=;
 b=NUg28bv+e19BaR71fhToFl1dIbK2uKxvMJddFGmdglogVMrOrMNf2/AZKXZqgPkxvulYVsh3GujUFBVb81GozslmR1zebYMLuzaJXCEd8GOtOrbMH1+gQqlfa5ZwF4c5h0AqUM7/aJm7OpZh2Yh9zGxO16DdpNTusJvWZkCd/0g=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 18:11:47 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 18:11:47 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Thread-Topic: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Thread-Index: AQHYdzgLncroj9sg+kegKWvw/B1zGK0+Q46AgAB5tOCAA7c9gIAAPp6A
Date: Mon, 6 Jun 2022 18:11:47 +0000
Message-ID: <SN1PR12MB25752BA8B8609046E8D6286AE3A29@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220603105227.3363029-1-Ramesh.Errabolu@amd.com>
 <412d12a6-24e5-ff30-2d1f-b631e0e21784@amd.com>
 <MW2PR12MB25693166D2F65B64427A782BE3A09@MW2PR12MB2569.namprd12.prod.outlook.com>
 <1763506e-f963-d163-831e-29a2e59f415c@amd.com>
In-Reply-To: <1763506e-f963-d163-831e-29a2e59f415c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-06T18:11:44Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c6fbf47f-a3d7-4459-9349-b9b2b54e9892;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-06T18:11:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a1c6e9ab-950d-4c21-b30f-3c22b893ae41
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6594d717-ea47-4948-747a-08da47e8056c
x-ms-traffictypediagnostic: MN2PR12MB2943:EE_
x-microsoft-antispam-prvs: <MN2PR12MB2943D7DEADB51D1623748653E3A29@MN2PR12MB2943.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zmi9Nahpxvo5da+jZ8VMzBOVec0hAUq2orFe5l1QsfvvuwQlJCbDawkVMZqC7asp+p+YgsJ9/DMAfHk+dg4X7XV6Vez9l8AII8AmY7FXAR/GF1BqqXW/kScyCqkwOk/PHPZkrOw2MMTJnyz9OO8ivt9Lf687Ao2gu+PBtGqykINvpQeXS6r8L1aCsB5PS5JVknbx5PZkj0OKm02OEIbfZD9CPjp3vWLvHbT9shyhO5XIjFJ1vun2svOGNdv/zuVuy/MTGUaqwNDqe+DQykUqcs1DGS0wssZAe+jOSu3dT7Djt3kymLWmqxuYqrleizXLDcD29WIp2+FHgNxlCbNLoi6j/uE7xCvLGe7GlP8Uozl+PuFmoYwo33gobukE1tvz2ivllT7rpiY9rZw9NGqA0w6KZLkdScPPyqTukTx+6ijgMsolzGG5ckJE3mXgkYPisfN81HuGND4ohJ1KLkrtRhnyrEiXilG8Icb/LPG+MMnhrcjw9SyLnK+MHdzkzpMpZfv7pfNyziWuDxZyi0VQ8p94JaOdROsYtXcmCP0Ig7NPIoP0LP+DIwaALDpXGDzEYxBXyFyyZVSMwgV2vLZv7ClWxBh7ds9vuGeQbPJaVUCp0OwO2bbmCDBWNjrSInygigsRKt2kd+i7mDBZYFqe2yiCTstZN1G/4akOy9qlBymiOEx3GiJQy8/tlRZogZAJYZiTLkNloSC1p1prYgeww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(316002)(83380400001)(508600001)(2906002)(33656002)(52536014)(53546011)(110136005)(6506007)(9686003)(7696005)(26005)(71200400001)(55016003)(5660300002)(122000001)(8676002)(8936002)(186003)(66446008)(66556008)(64756008)(66946007)(76116006)(66476007)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjdGQzByckZwOEp4SndtVFNTUE96YldqY0pHcW8xNXVFQkFyQzNQNktFQWl0?=
 =?utf-8?B?SzF1UEhnaUI4OWFkZW9YMEdON0E2NjlOcHQ1OHd3NHZ5Qm1WZm9sMHhORlA4?=
 =?utf-8?B?OXcyNUhaREY2alpkdnpJbnlBdGxrK2krMXM4R2xZSmNvRlppTXZDYTRJYmNR?=
 =?utf-8?B?dG1FTGplZVhlSzZjTm84ZndrUzlONm5oQzZwNmlvd2ZHZGdkOFV1TzU4OTRW?=
 =?utf-8?B?aHQ1cUlzK0JVamlqODRXbjRRdE4xWnVkQmJrZHhLZlpuaTNXdFBFRXNmTzJl?=
 =?utf-8?B?MFZBcjlScG5vemNHQmpuLzlYZlMwbWh2eTdJZUNRNHl4UEI5OStFMktpcnMr?=
 =?utf-8?B?Z0RSbk5uQS9BTHVPU2gyd1dvSlQ3aEVyMTFleDgvMDJVR3djVWhPUVdKaXdD?=
 =?utf-8?B?bk1OVUExQlJTOEtyWXlnWHhFYWR3Q1p1M2R5bzZmdWZ2dDFPSkpUZkFnQjFZ?=
 =?utf-8?B?NDJjVWMyOUIrNEIwVm95R2gxY3d4bEhwQXhpRWs1eCtvRmlvemk0VC85QmZW?=
 =?utf-8?B?RXhXeGs5YlozM0MydER0YVVGa0d2U2xYV0RxanlENnJNV05aZzdYdVFZRys1?=
 =?utf-8?B?NG9SNFZJQkp2RmpnREdncEtvRG4yd0NqbzJxWjkwL3U2REYxWFdZM0ZoQ2xi?=
 =?utf-8?B?cGhQVm5mTjJsRDJwTm5IdUNFTHJQUVRFaVlqRWl0cDM5SDIrVyt3bG5CRURa?=
 =?utf-8?B?aHVjWU5IcStKM05RMVRjblpZQ0ZVZ2dHdk1rUXZhdGVHVjVpUVpEVDZaWXZq?=
 =?utf-8?B?Sk9vZU1aOXVQTkdFdHZvVWN3cUJpV3A4T0VEdWJnOXVicDlJZEVTbHd5ZS8z?=
 =?utf-8?B?VVVnYkV0NzNUQmhxd2FYNHVETkFHMUJvVVgvYWhRUkh5OFhPcGFyUHRtVmpI?=
 =?utf-8?B?Mis0NUNUQ2tvNUxHUXF2Rm1CSUFGU1d2TUd2a1hWWVRrZmJFUW9qTE9vWTNq?=
 =?utf-8?B?N2hGS3lSTDd6OWFCNnBlaTE5ZC9TNEtoaFErcEs2TlpGNElWdm53SkZOeXZV?=
 =?utf-8?B?S2h1R0VEU2hocWlrWVNJcXAzdDFDbTFZTHkrbUdVQm5vdlRucUsyM1RWM3VY?=
 =?utf-8?B?ekRDUDlxSmwyZm1qbVpHcEkzUXJadi9aZ0IzYys0ZXM1YXhsdDJ2V1l0STc4?=
 =?utf-8?B?cnowSElxdVdOVUl4NWFTSllXeW56Uk9kUy9HUjFaQU1ERURJcW9KZUMwcTlt?=
 =?utf-8?B?VDIzNnhGbTZoMWxza2JLOTNiVEFibDh1SGxtSE5CSDRxYnh0eUJUalV3aHRZ?=
 =?utf-8?B?TkU0Q1pCQXJraTRuRm1ySTJMYStLeFI4aytHRW9nRnhYQWtUVHhjQXQzcWRY?=
 =?utf-8?B?Zy9EQy9TQWQzaEhCeXNrUGxadmp0cjFNU1EyWU9TZ0M5RDc1T3BVbGlGOXAw?=
 =?utf-8?B?b005dXhBREYwRjhDQkMzVWJQeElIZ2tzRXpzR2lBQlU4aVNuUk9LajRTTEtk?=
 =?utf-8?B?UHd0OXVadVlCZ1dySDRaQmhSVktkRG9IRlFZQWFnRW1tZ0VGdkduRHZMUXBu?=
 =?utf-8?B?ZVZFL251cXJGdFdoMXl2dzhHdCsyQ0RrWHFFK2JUUFZ4QUQ5MGpOOHNMcHlV?=
 =?utf-8?B?b2JUSENkZU9WOTdwbWgxL253Y2JpWDdiVkZTNHlMY296MWh2R1J0MDF1ajk5?=
 =?utf-8?B?QW5lcHFrRmhVNXhrMzRha0pORVdHbkRrVzRPbzNzTjNZMjgzbjVvd29LZ2hV?=
 =?utf-8?B?NGhNUHdxc2VyMlFHSGMxSmltd1RUNTBjTCtHeFNmcENEdHorN0dCakR3eVdQ?=
 =?utf-8?B?NEg2OTgyMHk1OGljb3RTcmZiQlZ6TDZEVmpQeUx3SlQ2dUVBVE14ZVdYdFdR?=
 =?utf-8?B?MVBvcFhMZ3E1YWVGd05FZWJEU0s4cm9mZHNlN3VDQm5KTk5tMFUvYWN6dlBQ?=
 =?utf-8?B?cy9UWHdya2hFcWhvcWh3WE0vY2hyZkd3VFYreUZ5cDBpNzF3c1B6ZDBwTUM4?=
 =?utf-8?B?N1ZlNzZ0cnZZVFRySkNTQ3Q2REUzS1k5RzJrYUVzRjB1SWQ2dmExbER5Umdx?=
 =?utf-8?B?Tm5yNFlLMlhTb3lGMTgvYTllV3VWbHdwLzZHSG1lMUJreHRaRG1zRXdGWXVm?=
 =?utf-8?B?Q1BtV1BMYmFCOXQ3Q2xPdjcrcHRjSnFqczVodFgwMmYyZHIwN3pCUWxwM3FR?=
 =?utf-8?B?UUhnMXVFUDA1YzBEancvOHVaelk3alI3dUVLZWp5Sit4RVE4YWh0T2dxeWtW?=
 =?utf-8?B?dTBWalAvcE0yakFsVHZodlNVb2hrSWh2WFVXYS82UktVVW5TaGlRekpSbUFY?=
 =?utf-8?B?RUhmZkVaL1IxR0dpRVVCd2t4cXRTN0QweHljSHF2UHRUWk9TNmU1bnJudkpK?=
 =?utf-8?B?dldBU3B5cmcyayt5T0lTRngwcEZWR2JQNEpwbmJ4K0luZEVmSzJiQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6594d717-ea47-4948-747a-08da47e8056c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 18:11:47.5012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEwnBmMXKyOBR3Ph5gCg3O/oYlMJj5q/pBgtwr7ywTdPVLQRgua4alo8M9S1u6j+TnTRHRgnGGy4esWyU3021Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkp1c3QgcG9zdGVkIHVwZGF0ZWQg
cGF0Y2ggYWRkcmVzc2luZyB0aGUgY29tbWVudA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6
IE1vbmRheSwgSnVuZSA2LCAyMDIyIDc6NTcgUE0NClRvOiBFcnJhYm9sdSwgUmFtZXNoIDxSYW1l
c2guRXJyYWJvbHVAYW1kLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZGdwdTogQWRkIHBlZXIt
dG8tcGVlciBzdXBwb3J0IGFtb25nIFBDSWUgY29ubmVjdGVkIEFNRCBHUFVzDQoNCg0KQW0gMjAy
Mi0wNi0wNCB1bSAwNjoyMyBzY2hyaWViIEVycmFib2x1LCBSYW1lc2g6DQo+PiArYm9vbCBhbWRn
cHVfZGV2aWNlX2lzX3BlZXJfYWNjZXNzaWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4+ICsJCQkJICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKnBlZXJfYWRldikgeyAjaWZkZWYg
DQo+PiArQ09ORklHX0hTQV9BTURfUDJQDQo+PiArCWJvb2wgcDJwX2FjY2VzcyA9IGZhbHNlOw0K
Pj4gKwl1aW50NjRfdCBhZGRyZXNzX21hc2sgPSBwZWVyX2FkZXYtPmRldi0+ZG1hX21hc2sgPw0K
Pj4gKwkJfipwZWVyX2FkZXYtPmRldi0+ZG1hX21hc2sgOiB+KCgxVUxMIDw8IDMyKSAtIDEpOw0K
Pj4gKwlyZXNvdXJjZV9zaXplX3QgYXBlcl9saW1pdCA9DQo+PiArCQlhZGV2LT5nbWMuYXBlcl9i
YXNlICsgYWRldi0+Z21jLmFwZXJfc2l6ZSAtIDE7DQo+PiArCXAycF9hY2Nlc3MgPSAhKHBjaV9w
MnBkbWFfZGlzdGFuY2VfbWFueShhZGV2LT5wZGV2LCANCj4+ICsmcGVlcl9hZGV2LT5kZXYsIDEs
IHRydWUpIDwgMCk7DQo+IFRoaXMgd291bGQgZ2l2ZSB5b3UgYSBjaGVja3BhdGNoIHdhcm5pbmcu
IFBsZWFzZSBydW4gY2hlY2twYXRjaC4NCj4NCj4gV2h5IGNhbid0IHlvdSBpbml0aWFsaXplIHAy
cF9hY2Nlc3MgaW4gdGhlIGRlY2xhcmF0aW9uIGFib3ZlPw0KPg0KPiBSYW1lc2g6IEkgZGlkIHJ1
biBjaGVja3BhdGNoIHNjcmlwdCwgYW5kIGl0IGRpZG4ndCBjb21wbGFpbiBhYm91dCB0aGUgdmFy
aWFibGUgYmVpbmcgbm90IGluaXRpYWxpemVkLiBCZWluZyBhIHZhcmlhYmxlIG9mIGV4dGVybiBj
bGFzcywgaXQgaXMgaW5pdGlhbGl6ZWQgYXQgbG9hZCB0aW1lIHRvIGRlZmF1bHQgdmFsdWUgb2Yg
WkVSTy4gVGhpcyBpcyB0aGVuIG92ZXJyaWRkZW4gaW4gYW1kZ3B1X2Rydi5jIHRvIHRydWUuIFNv
IGluaXRpYWxpemluZyBpdCB0byB0cnVlIGRvZXMgbm90IGFjY29tcGxpc2ggYW55dGhpbmcuDQoN
CnAycF9hY2Nlc3MgaXMgYSBsb2NhbCB2YXJpYWJsZS4gQXJlIHlvdSB0YWxraW5nIGFib3V0IHBj
aWVfcDJwPw0KDQpDaGVja3BhdGNoIGlzIG5vdCBhIHN0YXRpYyBhbmFseXplciwgaXQgd291bGQg
bm90IGNvbXBsYWluIGFib3V0IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGVzLiBJdCdzIG1vcmUgb2Yg
YSBjb2Rpbmcgc3R5bGUgY2hlY2tlci4gSXQgdXN1YWxseSBjb21wbGFpbnMgd2hlbiB0aGVyZSBp
cyBubyBibGFuayBsaW5lIGJldHdlZW4gdmFyaWFibGUgZGVjbGFyYXRpb25zIGFuZCB0aGUgZnVu
Y3Rpb24gYm9keS4gVGhhdCdzIHdoeSBJIHN1Z2dlc3RlZCBpbml0aWFsaXppbmcgcDJwX2FjY2Vz
cyB3aXRoIGl0cyBmaW5hbCB2YWx1ZSB3aGVyZSBpdCdzIGRlZmluZWQgMyBsaW5lcyBhYm92ZSwg
YW5kIHJlbW92aW5nIHRoZSBleHRyYSBhc3NpZ25tZW50IHRoYXQgdmlvbGF0ZXMgdGhlIGNvZGlu
ZyBzdHlsZS4NCg0KUmFtZXNoOiBJIHdhcyBtaXN1bmRlcnN0YW5kaW5nIHlvdXIgY29tbWVudCBh
cyBiZWluZyBmb3IgcGNpZV9wMnAgbW9kdWxlIHBhcmFtZXRlcg0KDQpSZWdhcmRzLA0KIMKgIEZl
bGl4DQo=
