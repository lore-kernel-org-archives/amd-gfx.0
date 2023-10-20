Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436DCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 08:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B34010E082;
	Fri, 20 Oct 2023 08:52:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF4810E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 08:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOaifaTsTMiqm/A3oZK2xuX6s0QhOmdE/7MS7uuCQBOXg7OLDy7eG17dmROtUC3BZELGCT6CsLxi3j13HSm1byflqnqFVUyVqAubLvrpNeOxaI2i/fQMuBJL4hq5tHXqq04hys78rYXiP7fbpXJoWYkzvEfGupWiuo53wwlpSVdtavLd/qu8TbHBrmYSnOlfjMgPDxJ5FbSabWULzRdjeC2S3j8aNFHViFooZPbb8dwZLNBvoYbjTq0hiFNGk7IichsboK0KRWFxLlQHZCd9yLS+1uVGFFtCG5zS2SG+WRbNHHcS7orgsnbGde/uIYxE+LFiwdc04tt3dUFlmXRu9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWPLevDI/rV98A8a8cCNjEhc95MAc3ipJIhixOC7GyI=;
 b=cy2CsKwC0RFf88cj5OpvPuTq3wAM0GLf70Sg5Vm3UfmnrGvvY3ZsVAifK/uf7gBirleIUNQV3G/1m3LPP1jHoAvTyDyOcRAcrEY7GmFgokEiWEltXvFP0R3ThAluIeNHmb2Hwkme/uyUyIIFpqeplmTFznhUaY5oJcmfXaljnJ1FR304vb5NQ6V/g+K5jmMX9G5sotaVL9GzocFLXW9Sqohq+pE6dyg4EKXt18VORwqWCxuVkSjWphDGSJS/g8/eU9KbfmroCuv64qBCCe3krBtCr471HutbmEPY3G+zFG4ooOubvrI3zn6B2btzASwv/G38AYUpMYY1npWGql1jiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWPLevDI/rV98A8a8cCNjEhc95MAc3ipJIhixOC7GyI=;
 b=4CNtx7JyMvHRDI/Asz8zY2uGMBqukzluppRLOj4bA6kiQj1Tz1VD39UvfVhogrL3tlnz3u3j22pv1AT3mAjlSyV5KJQk9FkJ2Eb+Gg6FGidfltrUTnc2rixu0w5Xmu8GnC2P2f96OjSRFBIWVoA/TLBrNHeeKoEQPdG2DAlJ50I=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 20 Oct
 2023 08:52:45 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::c08b:f17e:eb8b:d410%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 08:52:45 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add timeout for sync wait
Thread-Index: AQHaAxyM4KjrEUQfs025qlHPjTaSYLBSR/0AgAAFewA=
Date: Fri, 20 Oct 2023 08:52:44 +0000
Message-ID: <PH0PR12MB5417863B213789488F00ADC98FDBA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
In-Reply-To: <fbf6e76a-547d-423d-987b-9d1260437322@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=de43dafc-38ba-4a9a-bcf7-78755e3c736b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T07:48:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|CH2PR12MB4198:EE_
x-ms-office365-filtering-correlation-id: 5837e38b-1335-4603-b101-08dbd149ed65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqmWVCLoMf9YGXvPWefI2JKWx0MVH5mkyZpK/dTZfR5lFd4AO6+Qo0+0VWXRMT5akMh9oAyKeZoGh8ggQxrjj0fpfG2i/gpbWWl778jXovA9ZMIxFEOVYBCXzUvXs5BANk2f4GxaVT2w5z49W6GoC+Z3fhq8P/A4+1NVmkTPDC16r/FjmGNAb/z7iS94RW8dkge3yKQO51AjzSnpJ2PycprQmuZGzchvUmecyLSA2rc7Wd5xJUi5dvrvz74TBSKXajGfew74zX5whOAlgu7YIoODHvAg0WtAxV7jzvsSyUUBVfxYD4ogEk5iEVB9PrCabTJCNVC/+qraGdIc+xSzPX0111aFFm2af0mdNeZpxSDNrcm6D0fIWqtqMIM8yrFthgFkCWDKP2TmKWkZJpVsBu2D1cPitL53rEZ1GUJ/a3HE9kIoTKEbVeyaAvIuuaMTkMrlY0QDBjXSvkzYUwEc3sIP1/BdCp0BhT6TMANh+Qvy8J1F9GqbSrsmRLe6YuNAgt/Zm4Emjbal3kwqwtCntAmUyCX0vpJHjFbWYkafb1BpavT0cOrMsQWGlO5AR0RpPg5SRiAAaCkyVg7XQpgJjJ+K89E9URVf5SZ9Tl/NMLJ3TZ6jyleCSlPTLqOt6EOZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(478600001)(7696005)(83380400001)(9686003)(71200400001)(38070700009)(55016003)(86362001)(26005)(122000001)(38100700002)(8676002)(33656002)(66574015)(2906002)(41300700001)(64756008)(76116006)(66446008)(66556008)(52536014)(110136005)(66946007)(316002)(8936002)(5660300002)(6506007)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZmWEVzUXVXTmFPdjVHaE1zY1BiRjg5L0lDczY2ejAvQklLdDB0MzFFVmQz?=
 =?utf-8?B?N2xnQ2pPdWZhWktCaTE1aEgrZXY1NXVVTDVUVGplVzZSa011WTVlajB2b2lr?=
 =?utf-8?B?cW5aTWVjREJvN2pORXFCZHJHQTNCUGxQQWZvQmF2VkNXWlY1TW9vdlFOcE9I?=
 =?utf-8?B?bkl1OVpJYnFlaFozcTJoWU9NNElpMHRTYjhpbEhYSDVKNHQ5MGJkK2N5SmNo?=
 =?utf-8?B?Z2ZHek9GYWJ2MzRvTmZ3MCtEYzJ2YXlaOHo1NXlRY0pCcXFvck5ad2dsYVZt?=
 =?utf-8?B?TlFNREVVbjRnSU8zQUVSdUhEZmpEdXN5bGwzZStjUXB2bGtUMUpORldUaFBG?=
 =?utf-8?B?dVE5NSswbmlPR2VlVHJmTW9DQVh6NGxyTkNsR1NaZVdHRXFWaFkyUmNPK3Nu?=
 =?utf-8?B?YkdjRkcvdzloNTgyZ1dnMnFkWm5ydW9yYW5ZQnJwZXBCVEJaRzRLTXBXdlRr?=
 =?utf-8?B?bW9aVFZudTRXa0NWK0pIemdCZjM1TE9CeGZrbFlnMkhkdU1iYmtmZFRKQW9x?=
 =?utf-8?B?Yy9jcmR0TDRDLzRidTk3VThtK3ZHendNdlJKQnVpdUFmM1BvaVpJTWNiOXZO?=
 =?utf-8?B?WTdqSit5dVRLRDZXWUV0MWUxV3FBVzcrd0RpSmtQVXRPOU9qS0V4M3JqajhQ?=
 =?utf-8?B?dkpLT1FqTjR3RzR2YW9WaWk2aHhNTk9HVTY1WXhvc2MxT2pVWHh6T3JOelNC?=
 =?utf-8?B?RHJZMG9pZUVmUzNpNXM4UlJkaS9VT1k5WjBoUnNmNWFWbjlLQ0NYZW1CeVk2?=
 =?utf-8?B?WmwvQVBNVlpDbGUzSWxDSHY4aXA3T1NjaEk0eFFtNDVEM0FpK1VTZ3Fsemg3?=
 =?utf-8?B?VjRVTFE4WlV3RXRsbzJ2TWhjd3NQTEU0OGhhL2JBbTFlMXlFZzhFY0xxN3Fx?=
 =?utf-8?B?ejNGTzdzdVZjb3ZuWSs4bzNMTzg5VjlBVWEvRndjejNuVTNsSlZaVFZMUWZP?=
 =?utf-8?B?eWp6dkFrSUhaUitUVmVqOWhnWEZteUFxMDMvZ3pzWEpvYVhOSzlDQ01iR29v?=
 =?utf-8?B?aFdTVTUzTlk4bTdJUVBSQTV4d1R3enhldEdRUlBtNmVYb2JyY202clFCOXRj?=
 =?utf-8?B?aWk0MFBzemVUSUhMakFEV2QwdVN0QnZ6ZjZXVDBjdlV3S3FnNmpRYjdGdzRZ?=
 =?utf-8?B?b3FIOC9rWUdScHh4dFJvNDdUM1phTW81UXorRzAzYjU4a1ZyejJwcTllZXZD?=
 =?utf-8?B?c1FZakl6Nm9pbERmUFBDWm8xaGZLRjFVZGQyT2VJS3pMKzY3dHFUYTVQSnB4?=
 =?utf-8?B?WExabmNNd0VvSWI0cnM5ekQ3eklOMmI0MTZUSjdhNTA2SVNIbTZRdGJxTCtV?=
 =?utf-8?B?NTZ6bmgrOXJQbFgzK0dTd2dUWjcvdG9FR2NkVjFiMXduZUtPWFZYaEw3ckZv?=
 =?utf-8?B?aWNzVnN0R1VsTGdmMG9ySTlpVjY2VWZ2MlE3azNGemcxNUY0bm4vWnVGY0x2?=
 =?utf-8?B?RFNCVXNkTWFGY2pRM212WG8rZ3owN1hlNytDN0Z2VGJBZU1aRmxkTzY1RnZF?=
 =?utf-8?B?dzBOYStEYzRJbmR4SlBRVSsvcVlqTC9wLy9xbTBXNFEraW9iMmh3anh4VlpF?=
 =?utf-8?B?NERzaEZDL1pROVFYY3FRNlljWG50UGUwMEN0bmlJZTVOODRvUEVYL1lKajha?=
 =?utf-8?B?US8zT2huOS95ak5EMG9jcmh4NUlZRnkwTk9JVFYyQU9EeHZUKzNQdUNJZE9Q?=
 =?utf-8?B?bjRiU1NTa0Joc0pzWm1WbU5vNFdpN0hQYUs0Z200T1ZoRm9acGE5eXhrVmJQ?=
 =?utf-8?B?K2QvaG9EMldhcldxdlFCdHNwSWxscUJPTFNPU3lVdTZrQVhYRmNQOFg4WlBu?=
 =?utf-8?B?SnovbS9WSGlBcUR4ekl3YkRjNjljemMvcnIrQzdMRWh3NWhpN2xSMnVTTy9v?=
 =?utf-8?B?Vk92YzBPK3pJVU52cHNKNm5odGprV0wwMFBXMW5tNEJhaGVUWVFzT1cvZFdC?=
 =?utf-8?B?NDBlZVBaMzBXbityZmJLLy83cWpyd2NOMnc1TFhodDE3OEVjZVlBVXk3NEg2?=
 =?utf-8?B?KzkyTHo0b0dTVjArWFE5dENQcUw2aXJlUGMvRHc5cGJEOVZRaFdObnJ2OWpp?=
 =?utf-8?B?T1VRRXFhUzlXbUtkM2EvK01HUmROQVVvNUpRTnZ1TTZzWjltRk10Mk10bXRC?=
 =?utf-8?Q?aRSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5837e38b-1335-4603-b101-08dbd149ed65
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 08:52:44.8677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAAZu+sA1XNlenkFP5ZQJl0Zj6NGnc4xQvOW3m+GzIEs/xdrfdKV/2DsYXSxJv1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCiAgICAg
VGhlIGlzc3VlIGlzIHJ1bm5pbmcgYSBjb21wdXRlIGhhbmcgd2l0aCBhIHF1YXJrIGFuZCB0cmln
Z2VyIGEgY29tcHV0ZSBqb2IgdGltZW91dC4gRm9yIGNvbXB1dGUsIHRoZSB0aW1lb3V0IHNldHRp
bmcgaXMgNjBzLCBidXQgZm9yIGdmeCBhbmQgc2RtYSwgaXQgaXMgMTBzLg0KU28sIGdldCB0aGUg
dGltZW91dCBmcm9tIHRoZSBzY2hlZCBpcyByZWFzb25hYmxlIGZvciBkaWZmZXJlbnQgc2NoZWQu
DQogICAgQW5kIGlmIHdhaXQgdGltZW91dCwgaXQgd2lsbCBwcmludCBlcnJvciwgc28gd29uJ3Qg
aGludCByZWFsIGlzc3Vlcy4gQW5kIGV2ZW4gaXQgaGFzIHJlYWwgaXNzdWUsIHRoZSB3YWl0IGZv
cmV2ZXIgaXMgYmFkIHVzZXIgZXhwZXJpZW5jZSwgYW5kIGRyaXZlciBjb3VsZG4ndCB3b3JrIGFu
eW1vcmUuDQoNCkVtaWx5IERlbmcNCkJlc3QgV2lzaGVzDQoNCg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjAsIDIwMjMgMzoyOSBQTQ0K
PlRvOiBEZW5nLCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogQWRkIHRp
bWVvdXQgZm9yIHN5bmMgd2FpdA0KPg0KPkFtIDIwLjEwLjIzIHVtIDA4OjEzIHNjaHJpZWIgRW1p
bHkgRGVuZzoNCj4+IElzc3VlOiBEZWFkIGhlYXBwZW4gZHVyaW5nIGdwdSByZWNvdmVyLCB0aGUg
Y2FsbCBzZXF1ZW5jZSBhcyBiZWxvdzoNCj4+DQo+PiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVy
LT5hbWRncHVfYW1ka2ZkX3ByZV9yZXNldC0NCj4+Zmx1c2hfZGVsYXllZF93b3JrDQo+PiAtPiBh
bWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19ib3MtPmFtZGdwdV9zeW5jX3dhaXQN
Cj4+DQo+PiBJdCBpcyBiZWNhdXNlIHRoZSBhbWRncHVfc3luY193YWl0IGlzIHdhaXRpbmcgZm9y
IHRoZSBiYWQgam9iJ3MgZmVuY2UsDQo+PiBhbmQgbmV2ZXIgcmV0dXJuLCBzbyB0aGUgcmVjb3Zl
ciBjb3VsZG4ndCBjb250aW51ZS4NCj4+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVu
ZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9zeW5jLmMgfCAxMSArKysrKysrKystLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jDQo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4+IGluZGV4IGRjZDhjMDY2YmMxZi4uNjI1
M2Q2YWFiN2Y4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3N5bmMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5
bmMuYw0KPj4gQEAgLTQwNiw4ICs0MDYsMTUgQEAgaW50IGFtZGdwdV9zeW5jX3dhaXQoc3RydWN0
IGFtZGdwdV9zeW5jICpzeW5jLA0KPmJvb2wgaW50cikNCj4+ICAgICAgaW50IGksIHI7DQo+Pg0K
Pj4gICAgICBoYXNoX2Zvcl9lYWNoX3NhZmUoc3luYy0+ZmVuY2VzLCBpLCB0bXAsIGUsIG5vZGUp
IHsNCj4+IC0gICAgICAgICAgICByID0gZG1hX2ZlbmNlX3dhaXQoZS0+ZmVuY2UsIGludHIpOw0K
Pj4gLSAgICAgICAgICAgIGlmIChyKQ0KPj4gKyAgICAgICAgICAgIHN0cnVjdCBkcm1fc2NoZWRf
ZmVuY2UgKnNfZmVuY2UgPSB0b19kcm1fc2NoZWRfZmVuY2UoZS0NCj4+ZmVuY2UpOw0KPj4gKyAg
ICAgICAgICAgIGxvbmcgdGltZW91dCA9IG1zZWNzX3RvX2ppZmZpZXMoMTAwMDApOw0KPg0KPlRo
YXQgaGFuZGxpbmcgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UuIElmIHlvdSBuZWVkIGEgdGltZW91
dCB0aGVuIHlvdSBuZWVkDQo+YSB0aW1lb3V0IGZvciB0aGUgd2hvbGUgZnVuY3Rpb24uDQo+DQo+
QWRkaXRpb25hbCB0byB0aGF0IHRpbWVvdXRzIG9mdGVuIGp1c3QgaGlkZSByZWFsIHByb2JsZW1z
IHdoaWNoIG5lZWRzIGZpeGluZy4NCj4NCj5TbyB0aGlzIGhlcmUgbmVlZHMgYSBtdWNoIGJldHRl
ciBqdXN0aWZpY2F0aW9uIG90aGVyd2lzZSBpdCdzIGEgcHJldHR5IGNsZWFyIE5BSy4NCj4NCj5S
ZWdhcmRzLA0KPkNocmlzdGlhbi4NCj4NCj4+ICsNCj4+ICsgICAgICAgICAgICBpZiAoc19mZW5j
ZSkNCj4+ICsgICAgICAgICAgICAgICAgICAgIHRpbWVvdXQgPSBzX2ZlbmNlLT5zY2hlZC0+dGlt
ZW91dDsNCj4+ICsNCj4+ICsgICAgICAgICAgICBpZiAociA9PSAwKQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgciA9IC1FVElNRURPVVQ7DQo+PiArICAgICAgICAgICAgaWYgKHIgPCAwKQ0KPj4g
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+Pg0KPj4gICAgICAgICAgICAgIGFtZGdw
dV9zeW5jX2VudHJ5X2ZyZWUoZSk7DQoNCg==
