Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEA2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 06:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5D010E7FD;
	Thu,  2 Jun 2022 06:44:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D601310E7FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 06:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbKY9E2jGWZi/uzop8+5Z4Dzs9yf/wTmqHIfqbEzD/kkQTb8JIoUxe3wYk0AWcl1R3r8+anYvog7AkuWg/Cch5/19cgMCfv1WDlbNKtTnWjZVVKFHw+lrS0lPF/nQAt14D+twzfn4HuielADLr/offuUHpU5ydvxXd4IvikPogUNA5CWQT0kWT4wkTZ43zN8qpdi9AP5waO9ZJPmn02O1mMKOo0lOcI09oZg+RyOC31+urMejkY8vpbmvxq/B+OJE4fYI719HL9704j58i/esr7obkJh4lMVTujreHEfz7Xta//bfXReJi9lJ/ilEnnhCL6RuU0uiBsbsELBJ5z1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXj/jZreTmwSKkPPRUyOrxELpSd7NE7CSNpPqTXhMAU=;
 b=jKvF6louYvLPoEISszbqrmVq1eUoo6pPViIl6n3tqRQHGKKsqat3BCx6nrSrtSPDl+yHkhY2fN34q8ylJuUaXGYSyzHb3SkLbCUodiWrSD2Jni4LTRBJ0vDOn+rl3+Vp4xmnKc9XPGcMGhhz/laxtsAMjH/NRNLsqaUKHVTO6WudWtdFnXpuJWb8aA1YvdwVTOKjORk+eXZkMoGZnM0TVmOzfKr4IpkZ2kZKJuftOu9koCudVTWD3xAk2/P8BHSzXxzIarrwFiPGhIWUokWSIbzGDGrpLLN14+gyByayFNexUAaY8tI5rFuCN2LDEZHB35jgxvQZJJ+Xh/Dn+dLY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXj/jZreTmwSKkPPRUyOrxELpSd7NE7CSNpPqTXhMAU=;
 b=i5AmI+1cxZ7Rfd6bfUUop0LCAaW77j/TSsO8R6hwuAMiyzbu4e1GqFgCduF0OKvuZUfiM+N+GHsXu1HjOpS+muNtkldMw0RC3teei4p+YHeXRxFyovYGdCzyII2ET0y9vt1N/QpKIPyp69ZRaXK4+vEfo0teHmbtUkbYUzPKgYo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN6PR12MB1522.namprd12.prod.outlook.com (2603:10b6:405:11::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Thu, 2 Jun 2022 06:44:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889%3]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 06:44:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: suppress compile warnings
Thread-Topic: [PATCH] drm/amdgpu: suppress compile warnings
Thread-Index: AQHYc/GfIwjDPHVjqU6A+xPQDXi69603ASUAgASuJdA=
Date: Thu, 2 Jun 2022 06:44:10 +0000
Message-ID: <DM6PR12MB2619A4619E5123DBA285F04DE4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220530065032.677498-1-evan.quan@amd.com>
 <a32cfe57-cb97-b411-35e6-46141ee9e739@gmail.com>
In-Reply-To: <a32cfe57-cb97-b411-35e6-46141ee9e739@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-02T06:44:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a2cddbe2-c90b-4f45-8115-8f31195ca25c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 667732b4-0a9d-48d7-6940-08da44634c85
x-ms-traffictypediagnostic: BN6PR12MB1522:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1522972F886DE5400291C19CE4DE9@BN6PR12MB1522.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJoL9joqGahIez0STAe6CAkzL/rvKYvjXSIKeVoOLTT4YZRQCJxI7tqR2v5+NUa21V7/7DYybvyCQ6c98fxCuZYeppT/KKgntcSuzF89TUoabUbedl2NdaKPg20/PaQyLwlSueOciydsPJHwiutvgcP3nffhh/NhdiD5SSJvVnm9sE9z8Hi7S37IEPqFbTFmIiuWeqhIBj9GGhrQvdLfnDNu4iEKBONOrllFzi9hTalw0pHG2aCaMdo9NvZz0FP1B+ZGpM1itpTBuAPrUaQSjm8ElIHWtcyt5hQ8RyyMUeR4xP8eYfribE0QSSx6JY6u2vwn6F7q+2/bIAWrjblEYl1ctOlM7su5y4RIXQPhXM26tyQNY5V35Wo/qdPKg32vIVaS6JwLAU8bKTZb9Q3t5DFTWCU9FxTtkuu3wMfVJR/PFAFZnzsKDWa1GdqEtgnvxSltLOdrH7RJbjYzJAoDF2xyw7U7TBg+7HuDjQr6r1p/Y7iSBJLum8kwd4ulIR0Zl6OE0piGaFZGcXTd0tshRb8PcAkJFW/ea79BH8rwrtVxwwT1XWG0Oe2IwmI3U9UTq4ouR6tJbyIfOVt/SAo+I+a0ZE7gYtfuy9uIK7nIdH6R/NTuhI1qab0l+KVbEkDG/uwgZtRpqVS/is5YipJrvzrqy2fqhlJ480M8fv/p55zADSEeQSXVFvM00r3jY6u9o/X2tGzbyexE5H6anBnm2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(26005)(66476007)(66446008)(33656002)(66946007)(316002)(66556008)(52536014)(122000001)(38070700005)(186003)(8676002)(110136005)(76116006)(38100700002)(4326008)(5660300002)(86362001)(7696005)(9686003)(6506007)(8936002)(53546011)(71200400001)(508600001)(66574015)(83380400001)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THJsZ1JsdVR2Ymlxc3RCTTV0a1lYMFRSOFVVTXExZHFRVGI1cjNERkxJNUsv?=
 =?utf-8?B?YXg4VjdOOWJ2UmdoNVZ0SWlUTUVpc0cxKzRQKzdNVUJ0NjZja0hlNXlkVnYv?=
 =?utf-8?B?dmVFcndkTGNnamNyUW8zRHRDVENqSjRJUUs1dkYxR1JEenhQUjd1elMzY2gx?=
 =?utf-8?B?bXIzK1VWcjlpQ0JqNUQ3bDRaczEram9rb0F1dmRya3I5RUNOUUhKOHBRNnVU?=
 =?utf-8?B?azRmL3RxWVFGc1pWQ1Bka000a1pmOGJ1OGQ5SkdGSUtxVm1ONEVBRVExZjcy?=
 =?utf-8?B?MmUrWHN2a2NDZEt0QUFPWE94M0hqRERySXJENzJuSHQ0b20za0x1VUptZ0dO?=
 =?utf-8?B?RmV3QzdxVm5IT2h6UVUvcmYwZ2FnUGQ5VnFZKzFMcXkrZjQ3ZkVJcUZiWGZm?=
 =?utf-8?B?MTI3MlVwNTUwR29xREVMRmROZ1g3dVdrVnlFbVlvaDZRc1hpdFRoQ1daSjVw?=
 =?utf-8?B?RlNxT1ZZNnJBSm5ReXhhZzU5cStLcHlaQ3BuQTRhWXN6YktTbVVGbkJxR1ZW?=
 =?utf-8?B?bHg1QnJwQ2VjUm9wZVdNVlhKNVFieVJSUlRJSWovRFBCZ2VoeEFkU1k5eVV5?=
 =?utf-8?B?bG44U1g2V1ZCVnNGUnd4N2M4TkpFdlRjR3RzOTZVdjloNzNZdmNSTTh5dVlh?=
 =?utf-8?B?SkRJbHM0WVJ4WEdSZXZwVzlWWWtuUVFZa1VPbGxYSWsyM09yVXk5U0NaY3Qz?=
 =?utf-8?B?WVpBODQ2QktZVWdHN2JWUzVKMDRPMW9CVExBenN0Mm00OW50bzlJKzNXSEZy?=
 =?utf-8?B?cHFQZ25TMEwvSTg1TWZUM2FUL21VelNQcUVqT2RsYlRoc0NwK2pTQnNlTW9O?=
 =?utf-8?B?bm81dlVTQld0UlZiZnl0STdqZUU5NXJjZWlESW9LVWJXdGUyME9yL0Z0SzMz?=
 =?utf-8?B?bW1LVUFxeVdxWStEcUZmWEZSRnh6SjZ3OUlVMkQ3eTM0aUlBSVRRZW1ma2JZ?=
 =?utf-8?B?WGMwa1B3SWhvZXpaWFhRQkJQeWtnd0x0Uzl3U0Y0RUl5R1lhb2lxUnkveWRa?=
 =?utf-8?B?cnA5bGpZbmRxdUdRZHJ5OHBPdDBmVDBSb3lPMldvYit5Y0Y0czd6YldmWGR4?=
 =?utf-8?B?YlVxRTBtUXh3VzhTa0ZWSkNzWk9OdG96QUpqSXF0S0xFZ3F4ZEFIZkU2Z2Na?=
 =?utf-8?B?eVMvb2NrNk5uR0piczR2cmM3TjVvbGNPeEZLSU55R3JvUkgwSTFIYVlTZUpy?=
 =?utf-8?B?b0dwWmg1MGNkUm10NXVGRFFPZXlYR0VsVmpFNlFzK3NtZE9tZk5pLzVqTUcx?=
 =?utf-8?B?RmhMNFZQaC92ejRVbUtDN0FJZCs1a1diT2MzY25QUU8yZTFpQUhJTUtVS2di?=
 =?utf-8?B?bSt2dGl0dlc3QnhiTHhxYUVSbGNxQzdKdG9nU29hdU5mejFIVCtNRkxWNzFR?=
 =?utf-8?B?MTM2eVdIY254d3VQb21IMERwTStvYWMwYmptSGNPT1BGRTlrY2VtOVljS3Qy?=
 =?utf-8?B?UkN0d3BTQXBFbFZCUVZvaERxaWRmNGU3UURUZnNlR2pFWG90VGdOWlJqVFQ5?=
 =?utf-8?B?QklqNUJhWVdJM2xKT1diNEY2eC9OR3FtZnV1VHJyVnA2Vit6TnRYcTNLTTE2?=
 =?utf-8?B?OXM2cHdJWnZzNkRSSTlEMkZmTm9EOWk5aCtwSEZRbzgwbUkyaVU1UE5OVHpy?=
 =?utf-8?B?MStiKzRFbDJBNU4xeHptbmc3VnV5RDdNNG5qaTQ5VlpwSGJyMi9WS3V5Y05E?=
 =?utf-8?B?ejh2dTN0U3UyUzVxcXpOb2hoZHFMVnFJdVhNMkdHR1VobUV6WVdoTFNVK3VN?=
 =?utf-8?B?LzNtbWJnV2Y3bmZiOHZhZlpUaXlTUVMzSDRYOWtNT01EdkJHS0pwT0NpbSt1?=
 =?utf-8?B?OXFnaEhESGVxdHlZY1VwbU9kUjM3UGRVMFcxQVpqaFhWUzdKRjhwVXp2aEVP?=
 =?utf-8?B?bnA2eVhuV3ZPY3E1NU1UQy9RTkpjZGgvcGlFdmFKVSt2MXBENWhMclB1Ni9a?=
 =?utf-8?B?OXhYNnVZZnV5MU1Ta3l3WndVZ1grbTVUSkNUTkY5djVnYkR1YStVUzYwUE9u?=
 =?utf-8?B?dUxsclZqK3Y4NURMc2VZRlNvWE0vVWxDQTVjd1pTYy9wUCtER3hUM0h6eVVH?=
 =?utf-8?B?Z3puWWFieHRRRlJoSTlZVVVKb00wN0JVRXIyNkYwcFg2T1oyVTgxdlI5MGNI?=
 =?utf-8?B?ejZzV056cUcreEd4YjhGQWhYMldVMVpoQzMxMktpOUdrT1NIRGZpeTAvSGRM?=
 =?utf-8?B?cDVCMWkyelR6Ym1zVVpsbEFTVW5zMWk3RTNiTGYvMjF0NWx6Vk9zbVNWVG5i?=
 =?utf-8?B?TXdzOGd6bFhUcXUyK2pzT2duY3VNL3NMNEhxdU05UnlXd0lsYjQ0aTNLMWNW?=
 =?utf-8?Q?g+Aq1z46J25lMVw5ug?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667732b4-0a9d-48d7-6940-08da44634c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:44:10.2452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QSdB5DftSy9mGPYcF+92Ap47SvToez0au5sk4b9tjZfXORxXGWmTxnYmYKzQ7lT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1522
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSAzMCwgMjAyMiAzOjEyIFBNDQo+
IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHN1cHByZXNzIGNvbXBp
bGUgd2FybmluZ3MNCj4gDQo+IEFtIDMwLjA1LjIyIHVtIDA4OjUwIHNjaHJpZWIgRXZhbiBRdWFu
Og0KPiA+IFN1cHByZXNzIHRoZSBjb21waWxlIHdhcm5pbmdzIGJlbG93Og0KPiA+DQo+ID4NCj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdf
cHB0LmM6MQ0KPiA0MDc6MTI6IHdhcm5pbmc6DQo+ID4gc3RhY2sgZnJhbWUgc2l6ZSAoMTA0MCkg
ZXhjZWVkcyBsaW1pdCAoMTAyNCkgaW4NCj4gPiAnc211X3YxM18wXzdfZ2V0X3Bvd2VyX3Byb2Zp
bGVfbW9kZScgWy1XZnJhbWUtbGFyZ2VyLXRoYW5dDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMV8wLmM6MTk4Njo2OiB3YXJuaW5nOg0KPiA+IG5vIHByZXZpb3VzIHByb3Rv
dHlwZSBmb3IgZnVuY3Rpb24gJ2dmeF92MTFfMF9ybGNfc3RvcCcNCj4gPiBbLVdtaXNzaW5nLXBy
b3RvdHlwZXNdDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBh
bWQuY29tPg0KPiA+IENoYW5nZS1JZDogSTY3OTQzNmM5MWNiOThhZmI5ZmNiZWY4OTQyZmQ5MGEx
N2U1MjM0YjUNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
MTFfMC5jICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyB8IDEyDQo+ICsrKysrKysrKystLQ0KPiA+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiA+IGluZGV4
IDhjMGEzZmM3YWFhNi4uY2I1ODFjZmM3NDY0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiBAQCAtMTk4Myw3ICsxOTgzLDcgQEAgc3RhdGljIGlu
dCBnZnhfdjExXzBfaW5pdF9jc2Ioc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4g
ICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiAtdm9pZCBnZnhfdjExXzBfcmxjX3N0b3Ao
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gK3N0YXRpYyB2b2lkIGdmeF92MTFfMF9y
bGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIHsNCj4gPiAgIAl1MzIg
dG1wID0gUlJFRzMyX1NPQzE1KEdDLCAwLCByZWdSTENfQ05UTCk7DQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19w
cHQuYw0KPiA+IGluZGV4IDRlMTg2MWZiMmM2YS4uOGZkNzY1MmFlODgzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83
X3BwdC5jDQo+ID4gQEAgLTE0MDYsNyArMTQwNiw3IEBAIHN0YXRpYyBpbnQgc211X3YxM18wXzdf
Z2V0X3Bvd2VyX2xpbWl0KHN0cnVjdA0KPiA+IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4NCj4gPiAg
IHN0YXRpYyBpbnQgc211X3YxM18wXzdfZ2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211
X2NvbnRleHQNCj4gKnNtdSwgY2hhciAqYnVmKQ0KPiA+ICAgew0KPiA+IC0JRHBtQWN0aXZpdHlN
b25pdG9yQ29lZmZJbnRFeHRlcm5hbF90DQo+IGFjdGl2aXR5X21vbml0b3JfZXh0ZXJuYWxbUFBf
U01DX1BPV0VSX1BST0ZJTEVfQ09VTlRdOw0KPiA+ICsJRHBtQWN0aXZpdHlNb25pdG9yQ29lZmZJ
bnRFeHRlcm5hbF90ICphY3Rpdml0eV9tb25pdG9yX2V4dGVybmFsOw0KPiA+ICAgCXVpbnQzMl90
IGksIGosIHNpemUgPSAwOw0KPiA+ICAgCWludDE2X3Qgd29ya2xvYWRfdHlwZSA9IDA7DQo+ID4g
ICAJaW50IHJlc3VsdCA9IDA7DQo+ID4gQEAgLTE0MTQsNiArMTQxNCwxMSBAQCBzdGF0aWMgaW50
DQo+IHNtdV92MTNfMF83X2dldF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUsIGNoYXINCj4gKmJ1Zg0KPiA+ICAgCWlmICghYnVmKQ0KPiA+ICAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPg0KPiA+ICsJYWN0aXZpdHlfbW9uaXRvcl9leHRlcm5hbCA9DQo+IGt6YWxsb2Mo
c2l6ZW9mKERwbUFjdGl2aXR5TW9uaXRvckNvZWZmSW50RXh0ZXJuYWxfdCkgKg0KPiBQUF9TTUNf
UE9XRVJfUFJPRklMRV9DT1VOVCwNCj4gPiArCQkJCQkgICAgR0ZQX0tFUk5FTCk7DQo+IA0KPiBU
aGUgc3RhdGljIGNoZWNrZXJzIHdpbGwgd2FybiBhYm91dCB0aGF0IGFzIHdlbGwuIFBsZWFzZSB1
c2Uga2NhbGxvYyhzaXplb2YoLi4uKSwNCj4gY291bnQsIEdGUF9LRVJORUwpOw0KW1F1YW4sIEV2
YW5dIEkgYWN0dWFsbHkgZG8gbm90IGtub3cgdGhhdC4uIFRoZSB3YXJuaW5nIGlzIGFib3V0IHRo
ZSBzdGFjayBmcmFtZSBzaXplICgxMDQwKS4NClRoZSBzcGFjZSBhbGxvY2F0ZWQgYnkga3phbGxv
Yy9rbWFsbG9jIGlzIG5vdCBvbiB0aGUgc3RhY2suIFBlciBteSBrbm93bGVkZ2UsIGl0IHNob3Vs
ZCBub3QgaGF2ZSBzdWNoIGxpbWl0YXRpb24uDQpEaWQgSSBtaXNzIHNvbWV0aGluZz8NCg0KQlIN
CkV2YW4NCj4gDQo+IEFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gUmVn
YXJkcywNCj4gQ2hyaXN0aWFuLg0KPiANCj4gPiArCWlmICghYWN0aXZpdHlfbW9uaXRvcl9leHRl
cm5hbCkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gICAJc2l6ZSArPSBzeXNm
c19lbWl0X2F0KGJ1Ziwgc2l6ZSwgIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIpOw0K
PiA+ICAgCWZvciAoaSA9IDA7IGkgPD0gUFBfU01DX1BPV0VSX1BST0ZJTEVfV0lORE9XM0Q7IGkr
KykNCj4gPiAgIAkJc2l6ZSArPSBzeXNmc19lbWl0X2F0KGJ1Ziwgc2l6ZSwgIiUtMTRzJXMiLA0K
PiA+IGFtZGdwdV9wcF9wcm9maWxlX25hbWVbaV0sIEBAIC0xNDI2LDE0ICsxNDMxLDE3IEBAIHN0
YXRpYyBpbnQNCj4gc211X3YxM18wXzdfZ2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgY2hhcg0KPiAqYnVmDQo+ID4gICAJCXdvcmtsb2FkX3R5cGUgPSBzbXVf
Y21uX3RvX2FzaWNfc3BlY2lmaWNfaW5kZXgoc211LA0KPiA+DQo+IENNTjJBU0lDX01BUFBJTkdf
V09SS0xPQUQsDQo+ID4gICAJCQkJCQkJICAgICAgIGkpOw0KPiA+IC0JCWlmICh3b3JrbG9hZF90
eXBlIDwgMCkNCj4gPiArCQlpZiAod29ya2xvYWRfdHlwZSA8IDApIHsNCj4gPiArCQkJa2ZyZWUo
YWN0aXZpdHlfbW9uaXRvcl9leHRlcm5hbCk7DQo+ID4gICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiArCQl9DQo+ID4NCj4gPiAgIAkJcmVzdWx0ID0gc211X2Ntbl91cGRhdGVfdGFibGUoc211LA0K
PiA+DQo+IFNNVV9UQUJMRV9BQ1RJVklUWV9NT05JVE9SX0NPRUZGLCB3b3JrbG9hZF90eXBlLA0K
PiA+ICAgCQkJCQkgICh2b2lkDQo+ICopKCZhY3Rpdml0eV9tb25pdG9yX2V4dGVybmFsW2ldKSwg
ZmFsc2UpOw0KPiA+ICAgCQlpZiAocmVzdWx0KSB7DQo+ID4gICAJCQlkZXZfZXJyKHNtdS0+YWRl
di0+ZGV2LCAiWyVzXSBGYWlsZWQgdG8gZ2V0IGFjdGl2aXR5DQo+IG1vbml0b3IhIiwNCj4gPiBf
X2Z1bmNfXyk7DQo+ID4gKwkJCWtmcmVlKGFjdGl2aXR5X21vbml0b3JfZXh0ZXJuYWwpOw0KPiA+
ICAgCQkJcmV0dXJuIHJlc3VsdDsNCj4gPiAgIAkJfQ0KPiA+ICAgCX0NCg==
