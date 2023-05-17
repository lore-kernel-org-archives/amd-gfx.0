Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4929C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 12:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617AD10E40A;
	Wed, 17 May 2023 12:55:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639FF10E40A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 12:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7oRigB5bbjowNafIKR5XlET6Y8agG71w6vb+moyBOFhC1TV719UezJoM47MXKyMz0N72cLA8ToxZEWQhh51H/y15eGXVUs0QUCc8WX/KKiqC6QjynW30JJvhQCBugDTnnDvc2msQGb3dGsFMJJiqTQd+aB8cKgQnIZONfpSvtGPZ9HBs7cgz23c+3CTSePBgHXEQP+9rPODh13Wnl7oYQNb1Lz5KdrSFrNsPKTu8ZdjPBaxlM8rKh9u0+QHxugsDc7AvX7I4QtHG9kQqsJC7thu+AiwiG8W+T/iP/Be6xL+pJ0RdfZuwdofqAzRriOoLSAYkl0eurlsSTauQ4KlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pmdqVQWt0q4dX8LcsuCD1iUGT87IeLsGiBAeZwjpNE=;
 b=RDYgu6SQJsEmW3vnYquef3wooDMrHPOWz9fxOGELJ0PvuHXjc3+DgQdOUwaKw5HmHfJdVWYnryBwrQCqS4GImgGvRl9aMRL9dp2/xx8H+wwsN/kHriPhdb9GHG8VcVUUesvvAVkfoRUcSccg4k1+PbOcHC9DE5a2MOVyPtMyDwHD1kg6LGhMRBdyzcE5XtNCkxEQiauSykmaaRxWfP2kjiY8bLvh4ryhC+tB0sy8hrS+oj1I/xnS4gUpt4HEzc/8+6zfUwdY1FR3nDnvqCFTx5dY09Y+xdUhWIzN6ds/tDFX4QQ3r2VZwpEVwqBtufIHWXzyWumk1GhMlWvrfZ67rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pmdqVQWt0q4dX8LcsuCD1iUGT87IeLsGiBAeZwjpNE=;
 b=ey781aaV6RN6yfTzwoNXppKgARZXsh3SVLJ4yZAuPi5tHppYWIMFZWyiMINIDUenWbAfw3lDwgFJEz+ZYAQK3ieC2TWBOxpN8i6x6fJM4J/wlmGL/RVZjpYKaQI8upMXeLk/l01+BVHKBHg/Oo3Brr1qJpbMYZ17C6j4KFArSSc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 12:55:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:55:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
Thread-Index: AQHZiKd+3u8bYpHwgUqSTXVSwcUH969ebBwQ
Date: Wed, 17 May 2023 12:55:13 +0000
Message-ID: <BL1PR12MB51445B302834A275A99BAD3AF77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230517100711.1856524-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230517100711.1856524-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T12:55:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6999577a-8c66-4dd6-942c-5e6062ec5604;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-17T12:55:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 25e0a93a-5d8e-40fb-9a6c-166f2be0ae01
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB7668:EE_
x-ms-office365-filtering-correlation-id: 612c3562-7df3-4499-e3d7-08db56d5f4c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g07LOuns/ZCNn4H7Sz1q8jdVs7zCv7kJMz9avDmRGRXZ57oKzLm4Xi6/9a7DlcLFIylZEd1w+E/+0jDv2Wj9w+8eTKaL7TzAuY09abnjVrXgR9obzwLWahFj113k4n1EMh+qwA3/aRvZxH02VGTeG5wSY/VFIObCHfeXJf4MbZghC5I4U0IYRkqtnbcd45c/3ruUCNy2+rPGk/o4ijBPMqnk8kUP8znvRPnXqv32Xaem0QFx2nt1YkyBOg2iRyvAs84OoVBbIGIoTqlMfXIUTLbYAKfot9EsYrST0+49rYQg4QS0lh0a/j/RAOguaQjyEMALdWUZseciJf0bgwcKjS1eY7tje0vyKaul0W9uL4PlsEkODos+qb1oy5ER960R2g6dZJ51S1qdvvJW40ntZBFEYIvHzpsdrFGVoLb9JzLnqhNtHs1NJneqG3Qf8CDTUNUvnVoScIZGRW5QuGiHcxibYCEo2XbdN6gpbCuAK9wnN7g2quRwvwfUoNoMEOz2L9Xfr/IeEwlsnuMSfIaJTRrMNh/4CUK8YQ2lLexoh5DI75M4UfEUSt9cRBFghwOdRopaQmFjzu5cot5SyVdTnartXP4f/ivgO7X5lNj4KLX3UYAPwnBMCModW7QADjgV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(7696005)(66556008)(64756008)(66446008)(76116006)(478600001)(4326008)(66946007)(66476007)(6636002)(110136005)(316002)(38070700005)(33656002)(86362001)(66574015)(83380400001)(6506007)(53546011)(186003)(26005)(9686003)(52536014)(8936002)(2906002)(5660300002)(41300700001)(8676002)(55016003)(122000001)(38100700002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkFzNlIwMy9FT1lkS0xhclc1b3grK0ZBT0hwZmd4SFdIeE5pMkNDN1g3VHFn?=
 =?utf-8?B?cDRiZ1R0Z2tNNmZOT2FmRlVHTThublpZa3hvLy91WlRIM1pEaDN2by9JRTNu?=
 =?utf-8?B?NmxBR0R1L3I4N0hJVXlHRUh1ZUloZEhxd1dPRUI2Rm5CbDFJKzlVU21nOGgr?=
 =?utf-8?B?VGprQW5MUjdFWmZreHBPZDVaeGpkTm16cVowc1I5QWdYYUI0OEVRMGxoV283?=
 =?utf-8?B?NTFEUldIa3BFLzdneDVPSXNFenRaUGJFUmtXcHMyblNQSDF4d3dRbkpEOGE1?=
 =?utf-8?B?R3MvMFYrZURsVWMxQzd5eFFDZW1iN2x3WVFNSmhqSnp0ODl2R2lZNVBnWm0v?=
 =?utf-8?B?Z1JoL2xPME8zNUx5VGgrMGl1SC9UNnF6REdVaU9ZdGdGcDQyUnNRWmlmSG5W?=
 =?utf-8?B?UTRPWXViRHRON2VIS1VDeXRYSUtZL0NUZXNNVjRyeGszbkx6VWVxNlQzUWww?=
 =?utf-8?B?QW53ZXB6TGdOcHExVCt2aTd0SUp5UjdITGtBc0RNR1NiVmRZTTZVcm9EOWZ5?=
 =?utf-8?B?TDRBN3pZSGJkNzJMZEsrMTVHbDlqNEloN1FKWHNrUWdrWWtFZ3JYL0pwRjJM?=
 =?utf-8?B?QXBoaDArOGRvaW1uWGpISWdTb3Bjb2FUVGNTU3JsdzBHMm16Y2Q3SytEbEJo?=
 =?utf-8?B?WkZ1cHZMNi81bVVZbHRTLzUrOUNCQUk4cHZWT0tGZlQxNWFmWDNXVW5lQU1O?=
 =?utf-8?B?Smw2ZGVNeEZKUjBNYzZmWmt3a0VSb2FCQmI1MC9xbm5TUGQxK01Hcmt1Z0V6?=
 =?utf-8?B?cVNGdlFCdU1Qc2tseWVkVUJ3cEJhcUxYYnF2ekg2THkyRUxLT08yK0FtZ01a?=
 =?utf-8?B?ZzFkeTBCU0tOVWZEcUJUNVVNN0tQV2QrUkJZekR0QjNmOUZqZEJra21RcVM4?=
 =?utf-8?B?clk2QkNKdmRESHI0SkMweEJLNXpjUFVmaXlyVDgrMXplcCtXWmE2anFMczQw?=
 =?utf-8?B?SDljQzZSUDAxUUJCZk5XL0NzazE3UlBtWFpjcy9BcVJzaUluMXZua28zelhh?=
 =?utf-8?B?SHFZdDJxbEp5c05XMmVSYWliWjh1Y3dXNkhjZnpYdG8vYm9adUFRd29KcW1m?=
 =?utf-8?B?Tjg2Vm5YV2tPZitIQmtmZVRLbHVjVHFOSWhldWpCREhjZlNSaGdhRHIxMlMz?=
 =?utf-8?B?Rll4YXh4Y1ZVQ01hbmV1QklWZnl2djhjeWpWaTRBb1Zab0xnWlRVWDNuWGNZ?=
 =?utf-8?B?Z2VtcWhlTVkwV040SVJTcVZqdGZ5OVlwV1Q2K25PZXd4M1NmYzdSOWNwa2F5?=
 =?utf-8?B?ZzhYaHMwbm1OajdiZ1lTcmg1UHlNSncyZmJjTjluNCtyNE9nWDhmUkhzd0xq?=
 =?utf-8?B?aEFGcVkyNlV0UVlWcGRka1pIRW5leS9GZkd6aGpBZGxqajdBTHRrcnF6MEJP?=
 =?utf-8?B?N3QyZ3pJSERwSGpDbm5EOFUxbWdERXp3WkhUZ2FNYzlERzc1L1VHUnBFWThj?=
 =?utf-8?B?U0FvRWZzZDR2eENGbFFZY01XQytPNFI5WU9JK04zM3M4VUY0d3lNRGRpYVA3?=
 =?utf-8?B?TjNhWVNNNXUwUVBKay82SHk4SFFqR1RkdFBER3VCSDgyU1FnVGFBRkI3WGo4?=
 =?utf-8?B?a0swNTlnL08zeHB0bUcwNm5kc2FDak1sb1dVQTZpOGE5U2xEZ3lDdUFkaE5j?=
 =?utf-8?B?SThPZDZodkxiSTkvOHp4WXBtQVJvcTBiTUhBTkMrazlidTUwUFVOZjR6WjhT?=
 =?utf-8?B?d2d0ZlNyMldLV01lV2ZaSTF2QjBEN2NWZkcvTjVKSmxZNmNyVTFYN0c3QUE4?=
 =?utf-8?B?a1JwUWNPYnozem5lcTZzUW5mV2ovbk5wbU82L3p0Szl6L1krQVlrMFRlZTlM?=
 =?utf-8?B?aG1mR3VXcTZhenBHd0VKZUIyWEt3NytZcW9oWlAxN3l0M0tpWnp5Z2I2STNC?=
 =?utf-8?B?TTdzd3ZQNXFTMDNUL3hnZ1ZIeE5CUGEvZWo5aFF3cG9DMGZ5Z25WTUFta0Z4?=
 =?utf-8?B?dTRDMWVxL1phY2RJU1dXRUp2ZENtMjhGMU4vdmVOWU9XR2RqRWo1ZHAyS0c2?=
 =?utf-8?B?MlI1Mk5JaWk0OVlTQStPcFhmdTRwOVVJY1JFU29SNXRHQkNqb3hXcEZvMTF5?=
 =?utf-8?B?d3BvVFhrdndNb01TV1doZE5IVzdLNjI3TElQWEJ5Ylp1RUJaVG9LWUFobVU4?=
 =?utf-8?Q?uDPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612c3562-7df3-4499-e3d7-08db56d5f4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 12:55:13.7536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sr5vCqml+/rajqAot+P5ydF16eRNZPlAGFz+GCQwxWAooB+BVCmbGUmcDyHB2Aeij5q4odP6vsYS/8oE1uZ78Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAxNywgMjAyMyA2OjA3IEFN
DQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJ
TklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyXSBkcm0vYW1k
L2FtZGdwdTogUmVtb3ZlIHJlZHVuZGFudCBlbHNlIGJyYW5jaCBpbg0KPiBhbWRncHVfZW5jb2Rl
cnMuYw0KPiANCj4gQWRoZXJlIHRvIExpbnV4IGtlcm5lbCBjb2Rpbmcgc3R5bGUuDQo+IA0KPiBS
ZXBvcnRlZCBieSBjaGVja3BhdGNoOg0KPiANCj4gV0FSTklORzogZWxzZSBpcyBub3QgZ2VuZXJh
bGx5IHVzZWZ1bCBhZnRlciBhIGJyZWFrIG9yIHJldHVybg0KPiANCj4gQ2M6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFu
bXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiANCj4gdjI6DQo+
ICAgIC0gQXZvaWQgbXVsaXRwbGUgcmV0dXJuIHN0YXRlbWVudHMgaW4gYW1kZ3B1X2RpZ19tb25p
dG9yX2lzX2R1YWxsaW5rDQo+ICAgICAgZnVuY3Rpb24gd2l0aG91dCBhZmZlY3RpbmcgZnVuY3Rp
b25hbGl0eQ0KPiAgICAtIEZpeCBmb2xsb3dpbmcgd2FybmluZ3M6DQo+ICAgICAgICAgV0FSTklO
RzogUHJlZmVyICd1bnNpZ25lZCBpbnQnIHRvIGJhcmUgdXNlIG9mICd1bnNpZ25lZCcNCj4gCVdB
Uk5JTkc6IE1pc3NpbmcgYSBibGFuayBsaW5lIGFmdGVyIGRlY2xhcmF0aW9ucw0KPiAjNzQ6IEZJ
TEU6IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9lbmNvZGVycy5jOjc0Og0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Nvbm5lY3RvciAqYW1kZ3B1X2Nv
bm5lY3RvciA9DQo+IHRvX2FtZGdwdV9jb25uZWN0b3IoY29ubmVjdG9yKTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYW1kZ3B1X2VuY29kZXItPmFjdGl2ZV9kZXZpY2UgPQ0KPiArIGFtZGdw
dV9lbmNvZGVyLT5kZXZpY2VzICYgYW1kZ3B1X2Nvbm5lY3Rvci0+ZGV2aWNlczsNCj4gDQo+IA0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2VuY29kZXJzLmMgfCA0MSArKysr
KysrKysrKystLS0NCj4gLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZW5jb2RlcnMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9lbmNvZGVycy5jDQo+IGluZGV4IGM5NmU0NThlZDA4OC4uOGMxN2E3NGYwMDFhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZW5jb2RlcnMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZW5jb2RlcnMuYw0K
PiBAQCAtNzEsNiArNzEsNyBAQCB2b2lkIGFtZGdwdV9lbmNvZGVyX3NldF9hY3RpdmVfZGV2aWNl
KHN0cnVjdA0KPiBkcm1fZW5jb2RlciAqZW5jb2RlcikNCj4gIAlkcm1fZm9yX2VhY2hfY29ubmVj
dG9yX2l0ZXIoY29ubmVjdG9yLCAmaXRlcikgew0KPiAgCQlpZiAoY29ubmVjdG9yLT5lbmNvZGVy
ID09IGVuY29kZXIpIHsNCj4gIAkJCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRncHVfY29u
bmVjdG9yID0NCj4gdG9fYW1kZ3B1X2Nvbm5lY3Rvcihjb25uZWN0b3IpOw0KPiArDQo+ICAJCQlh
bWRncHVfZW5jb2Rlci0+YWN0aXZlX2RldmljZSA9DQo+IGFtZGdwdV9lbmNvZGVyLT5kZXZpY2Vz
ICYgYW1kZ3B1X2Nvbm5lY3Rvci0+ZGV2aWNlczsNCj4gIAkJCURSTV9ERUJVR19LTVMoInNldHRp
bmcgYWN0aXZlIGRldmljZSB0byAlMDh4DQo+IGZyb20gJTA4eCAlMDh4IGZvciBlbmNvZGVyICVk
XG4iLA0KPiAgCQkJCSAgYW1kZ3B1X2VuY29kZXItPmFjdGl2ZV9kZXZpY2UsDQo+IGFtZGdwdV9l
bmNvZGVyLT5kZXZpY2VzLCBAQCAtMTY2LDEyICsxNjcsMTIgQEAgdm9pZA0KPiBhbWRncHVfcGFu
ZWxfbW9kZV9maXh1cChzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsICB7DQo+ICAJc3RydWN0
IGFtZGdwdV9lbmNvZGVyICphbWRncHVfZW5jb2RlciA9DQo+IHRvX2FtZGdwdV9lbmNvZGVyKGVu
Y29kZXIpOw0KPiAgCXN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICpuYXRpdmVfbW9kZSA9ICZhbWRn
cHVfZW5jb2Rlci0NCj4gPm5hdGl2ZV9tb2RlOw0KPiAtCXVuc2lnbmVkIGhibGFuayA9IG5hdGl2
ZV9tb2RlLT5odG90YWwgLSBuYXRpdmVfbW9kZS0+aGRpc3BsYXk7DQo+IC0JdW5zaWduZWQgdmJs
YW5rID0gbmF0aXZlX21vZGUtPnZ0b3RhbCAtIG5hdGl2ZV9tb2RlLT52ZGlzcGxheTsNCj4gLQl1
bnNpZ25lZCBob3ZlciA9IG5hdGl2ZV9tb2RlLT5oc3luY19zdGFydCAtIG5hdGl2ZV9tb2RlLQ0K
PiA+aGRpc3BsYXk7DQo+IC0JdW5zaWduZWQgdm92ZXIgPSBuYXRpdmVfbW9kZS0+dnN5bmNfc3Rh
cnQgLSBuYXRpdmVfbW9kZS0NCj4gPnZkaXNwbGF5Ow0KPiAtCXVuc2lnbmVkIGhzeW5jX3dpZHRo
ID0gbmF0aXZlX21vZGUtPmhzeW5jX2VuZCAtIG5hdGl2ZV9tb2RlLQ0KPiA+aHN5bmNfc3RhcnQ7
DQo+IC0JdW5zaWduZWQgdnN5bmNfd2lkdGggPSBuYXRpdmVfbW9kZS0+dnN5bmNfZW5kIC0gbmF0
aXZlX21vZGUtDQo+ID52c3luY19zdGFydDsNCj4gKwl1bnNpZ25lZCBpbnQgaGJsYW5rID0gbmF0
aXZlX21vZGUtPmh0b3RhbCAtIG5hdGl2ZV9tb2RlLQ0KPiA+aGRpc3BsYXk7DQo+ICsJdW5zaWdu
ZWQgaW50IHZibGFuayA9IG5hdGl2ZV9tb2RlLT52dG90YWwgLSBuYXRpdmVfbW9kZS0+dmRpc3Bs
YXk7DQo+ICsJdW5zaWduZWQgaW50IGhvdmVyID0gbmF0aXZlX21vZGUtPmhzeW5jX3N0YXJ0IC0g
bmF0aXZlX21vZGUtDQo+ID5oZGlzcGxheTsNCj4gKwl1bnNpZ25lZCBpbnQgdm92ZXIgPSBuYXRp
dmVfbW9kZS0+dnN5bmNfc3RhcnQgLSBuYXRpdmVfbW9kZS0NCj4gPnZkaXNwbGF5Ow0KPiArCXVu
c2lnbmVkIGludCBoc3luY193aWR0aCA9IG5hdGl2ZV9tb2RlLT5oc3luY19lbmQgLQ0KPiBuYXRp
dmVfbW9kZS0+aHN5bmNfc3RhcnQ7DQo+ICsJdW5zaWduZWQgaW50IHZzeW5jX3dpZHRoID0gbmF0
aXZlX21vZGUtPnZzeW5jX2VuZCAtDQo+ICtuYXRpdmVfbW9kZS0+dnN5bmNfc3RhcnQ7DQo+IA0K
DQpUaGlzIHBhcnQgbG9va3MgZmluZS4NCg0KPiAgCWFkanVzdGVkX21vZGUtPmNsb2NrID0gbmF0
aXZlX21vZGUtPmNsb2NrOw0KPiAgCWFkanVzdGVkX21vZGUtPmZsYWdzID0gbmF0aXZlX21vZGUt
PmZsYWdzOyBAQCAtMjA4LDYgKzIwOSw3IEBADQo+IGJvb2wgYW1kZ3B1X2RpZ19tb25pdG9yX2lz
X2R1YWxsaW5rKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwNCj4gIAlzdHJ1Y3QgZHJtX2Nv
bm5lY3RvciAqY29ubmVjdG9yOw0KPiAgCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRncHVf
Y29ubmVjdG9yOw0KPiAgCXN0cnVjdCBhbWRncHVfY29ubmVjdG9yX2F0b21fZGlnICpkaWdfY29u
bmVjdG9yOw0KPiArCWJvb2wgcmV0Ow0KPiANCj4gIAljb25uZWN0b3IgPSBhbWRncHVfZ2V0X2Nv
bm5lY3Rvcl9mb3JfZW5jb2RlcihlbmNvZGVyKTsNCj4gIAkvKiBpZiB3ZSBkb24ndCBoYXZlIGFu
IGFjdGl2ZSBkZXZpY2UgeWV0LCBqdXN0IHVzZSBvbmUgb2YgQEAgLTIyNCwzOQ0KPiArMjI2LDQ0
IEBAIGJvb2wgYW1kZ3B1X2RpZ19tb25pdG9yX2lzX2R1YWxsaW5rKHN0cnVjdCBkcm1fZW5jb2Rl
cg0KPiAqZW5jb2RlciwNCj4gIAkJCS8qIEhETUkgMS4zIHN1cHBvcnRzIHVwIHRvIDM0MCBNaHog
b3ZlciBzaW5nbGUgbGluaw0KPiAqLw0KPiAgCQkJaWYgKGNvbm5lY3Rvci0+ZGlzcGxheV9pbmZv
LmlzX2hkbWkpIHsNCj4gIAkJCQlpZiAocGl4ZWxfY2xvY2sgPiAzNDAwMDApDQo+IC0JCQkJCXJl
dHVybiB0cnVlOw0KPiArCQkJCQlyZXQgPSB0cnVlOw0KPiAgCQkJCWVsc2UNCj4gLQkJCQkJcmV0
dXJuIGZhbHNlOw0KPiArCQkJCQlyZXQgPSBmYWxzZTsNCj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJ
aWYgKHBpeGVsX2Nsb2NrID4gMTY1MDAwKQ0KPiAtCQkJCQlyZXR1cm4gdHJ1ZTsNCj4gKwkJCQkJ
cmV0ID0gdHJ1ZTsNCj4gIAkJCQllbHNlDQo+IC0JCQkJCXJldHVybiBmYWxzZTsNCj4gKwkJCQkJ
cmV0ID0gIGZhbHNlOw0KPiAgCQkJfQ0KPiAgCQl9IGVsc2UNCj4gLQkJCXJldHVybiBmYWxzZTsN
Cj4gKwkJCXJldCA9IGZhbHNlOw0KPiArCQlicmVhazsNCj4gIAljYXNlIERSTV9NT0RFX0NPTk5F
Q1RPUl9EVklEOg0KPiAgCWNhc2UgRFJNX01PREVfQ09OTkVDVE9SX0hETUlBOg0KPiAgCWNhc2Ug
RFJNX01PREVfQ09OTkVDVE9SX0Rpc3BsYXlQb3J0Og0KPiAgCQlkaWdfY29ubmVjdG9yID0gYW1k
Z3B1X2Nvbm5lY3Rvci0+Y29uX3ByaXY7DQo+ICAJCWlmICgoZGlnX2Nvbm5lY3Rvci0+ZHBfc2lu
a190eXBlID09DQo+IENPTk5FQ1RPUl9PQkpFQ1RfSURfRElTUExBWVBPUlQpIHx8DQo+ICAJCSAg
ICAoZGlnX2Nvbm5lY3Rvci0+ZHBfc2lua190eXBlID09DQo+IENPTk5FQ1RPUl9PQkpFQ1RfSURf
ZURQKSkNCj4gLQkJCXJldHVybiBmYWxzZTsNCj4gKwkJCXJldCA9IGZhbHNlOw0KPiAgCQllbHNl
IHsNCj4gIAkJCS8qIEhETUkgMS4zIHN1cHBvcnRzIHVwIHRvIDM0MCBNaHogb3ZlciBzaW5nbGUg
bGluaw0KPiAqLw0KPiAgCQkJaWYgKGNvbm5lY3Rvci0+ZGlzcGxheV9pbmZvLmlzX2hkbWkpIHsN
Cj4gIAkJCQlpZiAocGl4ZWxfY2xvY2sgPiAzNDAwMDApDQo+IC0JCQkJCXJldHVybiB0cnVlOw0K
PiArCQkJCQlyZXQgPSB0cnVlOw0KPiAgCQkJCWVsc2UNCj4gLQkJCQkJcmV0dXJuIGZhbHNlOw0K
PiArCQkJCQlyZXQgPSBmYWxzZTsNCj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJaWYgKHBpeGVsX2Ns
b2NrID4gMTY1MDAwKQ0KPiAtCQkJCQlyZXR1cm4gdHJ1ZTsNCj4gKwkJCQkJcmV0ID0gdHJ1ZTsN
Cj4gIAkJCQllbHNlDQo+IC0JCQkJCXJldHVybiBmYWxzZTsNCj4gKwkJCQkJcmV0ID0gZmFsc2U7
DQo+ICAJCQl9DQo+ICAJCX0NCj4gKwkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gLQkJcmV0dXJu
IGZhbHNlOw0KPiArCQlyZXQgPSBmYWxzZTsNCj4gKwkJYnJlYWs7DQo+ICAJfQ0KPiArDQo+ICsJ
cmV0dXJuIHJldDsNCg0KVGhlc2UgaHVua3MgbWFrZSB0aGUgY29kZSBsZXNzIHJlYWRhYmxlLiAg
SSdkIHN1Z2dlc3QgZHJvcHBpbmcgdGhlbS4NCg0KQWxleA0KDQo+ICB9DQo+IC0tDQo+IDIuMjUu
MQ0K
