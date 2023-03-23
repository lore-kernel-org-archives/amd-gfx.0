Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5284CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA75A10EA7C;
	Thu, 23 Mar 2023 12:33:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E6F10E48D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUsJYHZ8fL58PXMSlBq1YickBe4EQf/efhDjzCbP66qxHoEmxAxnTCGymgvSylTp4gJLEIpz78Zvh6DrHQnxLvgMGTuZKB0r5dP4nvLwW0J5OWPRo46wydA3VIZWtCZONms3v6Rnoi6mpBM8SLxjlEZiURFE8403z4U6KYsDHHkGlSAisuipAbZtOfJTeeFKNf7SLe1Wm8UU8cgTMH1JiWJI61+2GU7C5RPhE9nwmmfble4CP+vwG8vAUzoTjoN9cF8y7tmnjCH6EQvPonBo0z9dt4bM7uFBoQ3RURGZOZYl85v8cMQRNegND5PWv53Pe30gQPaKM0Ul6tkABYarAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CibiEAODz6S5GAo8w6AyGopSU9uZk1OBJOIcZ9wqmSQ=;
 b=mTklgk1aCDJF3aMcumCKFR+N+CSUewsUC5J2xQSAAdC/1sZ3sHAtsMtlHPRHfirHR6wl8H/HKcbNYqzE4/JpXlZPt4d4ekSfWNqESa77nUnzpW0oJPDM0oMf5F1bgUvDm8YrmnmlMVBdY4ggGjd4AXYmRFc9NigxAynAEbjuH5grCB/wOnDLdZlT1NzNBus47L7BWiLdyZuCEI05qDMathA0tqzLyQS5A3FRuVf5vLx1Hz7WXcoELYVRbO6MKNHcRlqn9ry/Kmoak+1f5DECVT+bCx4+dQphnPscEMZv6PRshMMl/bMjPpOB+v1UX5/wgMWg5VyoEY1qOBRDADtVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CibiEAODz6S5GAo8w6AyGopSU9uZk1OBJOIcZ9wqmSQ=;
 b=YfddGnxKSHDprGycHyRHJy5VMZ+t0//FTf+f7NsmH4YVd0AiyZwW1ioH0k9+85FxjZlvNcgFgH1k2gZE1AQH7qOkJZw/Bi37sH42mkVdSZHsE2G8vzYjYBm8CNiINTH9WphGQ9Ag9vQrxodtNOjhWJ0W1zLkJ2pPH5F2oAFNXEA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:33:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 12:33:16 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXYOUfnKIhUiB4Uq8jjPrM23UvK8ITDCQ
Date: Thu, 23 Mar 2023 12:33:16 +0000
Message-ID: <MN0PR12MB6101863E54001078B11FA04FE2879@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-23T12:33:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=33df8f09-a99d-44cd-bded-b4c8200031ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-23T12:33:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c44e3c8d-5998-4698-a27e-93cb623f7bab
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6033:EE_
x-ms-office365-filtering-correlation-id: 8479c626-d8e7-4715-e3de-08db2b9ac6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cuhdDu+b0MMpUWEhWF+MJ0c2gwIOdLeKPEZkMAldWckdofKZUDqIcBe8QhMu5qhuF8gFQ1/Jl7TiurymFV5E4J/9IVFim9qNAimBJzm99LpYH6vG8k/5tfvdZiLqa1WfzCh0xrHqYXTah1i5AoMfC/rWuwl6sQTxkyXnw04jHfXQpjnv/TyTAJR7mG43Jynf39ilNVE2HVIbk7jslSnKVyGtM3lGkrEmXLzOK6Lnh/p/IdKn6K4B2g+MghXdiLAIcs+l0VyXSh0rj2qDn3g1E42Jao0MBzIzZv2f2d/KYeqmDwxyT5XCjvHY/fRTtJhJGgH6MQiMP19gFh4Mw+hcC6ACnAxVdXSBhi/8wT0IUbxWwKHewk13i8MJPHrz+HHZtt40TzpTAGDVYa0SBCgIzTqxxS+KwK7VMyWCNMtO3EkSKSogViFWeySLvIJVWw86KtobQEWzKvSegDLl3Fn7qT8OvJU2UW5WrRpSK7wCcXWBtStnV8emBx6sWMicdGufWUFSTKQiZ9/F9szBlxQsqocdrh/bDjqEMgyz9h25G35eqJZMyDdJut9owgLhVPt7z4o5Nmn6Gq/d3DtV+eGFXwPqi7/QZ+uOk6axM0hBlqIwc3WHeMntdudU1bWWEEr2yuyYt5xB4n6/rXj4Go+deUd/IWKSjbS06uJbKSv1Kjp9DZFhHBXh9MAkXMjz+bhuXN6gf0XgnDZs7lEMGDd6IG8vrzxaHBpat1NQuEuElRw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(921005)(55016003)(38070700005)(38100700002)(2906002)(71200400001)(83380400001)(478600001)(66574015)(9686003)(186003)(33656002)(86362001)(7696005)(316002)(110136005)(6636002)(66476007)(64756008)(8676002)(66556008)(66946007)(66446008)(4326008)(76116006)(52536014)(8936002)(53546011)(26005)(6506007)(5660300002)(122000001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUVtU1dtM1pPbEJuNkhyRnI0YVJFYnVzQ20rTTRuaVdtZW9zcVlMcWZXT2N2?=
 =?utf-8?B?YlFsR09tT3hKaDVBeFZwUWt6ZXpsZ1o1ek1LV3gxVkphellZS3Jhbi9IMWlX?=
 =?utf-8?B?d2R3MGdrRkZiT09sV2h1TjgvZlp1YkZTeUxoNFlmRDZsT1ZTQUZqWTlnT1JC?=
 =?utf-8?B?UlUxZHhRREIvUHIwZXF2dlcreFRmKzIvRGc5UVJ5dXB0dXNmMEZNZnJkek9N?=
 =?utf-8?B?T1piTGlYTzNXUDBIN3Qra0VPbklpdkJiSWUvWkEvZDg3YkxZdjBsa1c3SmlK?=
 =?utf-8?B?SzRqdk9HSEk0SEFZSTRRa2NUelR1VG91MHFFK2taQXVueXVuSDUzL2pYei8z?=
 =?utf-8?B?VnpsU2NtK2g3T2t3TjFlUVZSU2pVeFI0djYyZXVKMjAvRU1EYmtvWG9OaUFv?=
 =?utf-8?B?WGwzVnI3Q0s3bThZRHhkWHM1S0M1ME13QlZZcW9kamV6KzRYaEx2UnQzQ2xR?=
 =?utf-8?B?UlgxMitDUlg1VklLYnF4OEdwbjB3MlFabzg1MEFCcWpEdnFTdHRyZVdMN2Jj?=
 =?utf-8?B?b0I2dU9SbTlJcGlWbWxCZG12eHFEV0lXelVGWHRoQlNzUU1HR2lBNjlMOEgy?=
 =?utf-8?B?N2VreHBQaWhYMTM0VlZOVDBZQ3JzRHdxTlVYYkFiKzJDblJhYkltZVlWd1Y5?=
 =?utf-8?B?ZUJCdnZqZ2JROUhvQ0JtNUVacWZwYmZyenVIaXpUbUlFTlBFU3dCSy85M1Rm?=
 =?utf-8?B?QmZNNkNKTDhia1drcGJWeFRKRTRuK0pQZGVVNnBkaU1XRFNramNQaWlZb29D?=
 =?utf-8?B?QkdGS1dDT1pBaFVKYjdSQkI4V0p1cEhCanVWVnJhVThiWUIxdWhSVjNobEZO?=
 =?utf-8?B?b2ZRTGdHYThOWTBlYnYrYng3dkNML1c1RTJ1YUNZQmVDdW4yMzZzcmR3M2Ns?=
 =?utf-8?B?TFlpUElYalVZRDExSnBKa0xuREJKL3FEWUl3bkFCZ3RmZldhc2NIcnErTUFG?=
 =?utf-8?B?WVZDMUVPN2k3SFh4NC9EZWlzajJjMTFKWnZsT01TdVo1eU0xQ0U0SHJKODdw?=
 =?utf-8?B?VDVIT2JBTUt3WkxqOGNVUzF1ajNWN1Q4Y3g0OE1iRjhqbzZSY1B3bzZjMDVx?=
 =?utf-8?B?dmF1Um5TUklxaUdrTEhxK2RRZm84a085SU1BZmFDaldJZUhiNTFaS2Vyc3NZ?=
 =?utf-8?B?TG4yNVlhVUtWbnhFVlBnc2J4Wnh3RUg0eTh2SnhpakI1bnc4NHN2ODJIdktD?=
 =?utf-8?B?RnZDMUlLRWdkUDc1R0I4Z1QxL3lxa0xYN2ExSVNFc2VDMW1tR3JkRUlEN0tP?=
 =?utf-8?B?eWJaNzR0dHUyUE9QZ0FpbUNvZFpFTmdJNDV6Z1RHT01hV1NINStvQ0tuY2hr?=
 =?utf-8?B?a2hKRVB5KzkwVytzeHNZRlJPZFZ0UnBQeFJwVTJLTTVVeG5pTyt4c0hGNWwv?=
 =?utf-8?B?MnRTRzRWQVJCUEd2Mk1vYkVJSkphMENRL0xjQkpwM1ZoTERUT3hqdGZWOGJX?=
 =?utf-8?B?Wm9FNWtncmVMTXBsNHR0RXU0MGthUVN5czlPbWZHT3FCeEFJZzJtbHJZVmRn?=
 =?utf-8?B?YnZBQWpVZklZS3pHSnNQQ0RxVmJkVUY1YlZjMmRqWHZRcWhFTGtZTjhyczNN?=
 =?utf-8?B?UldGUVliSVFQNGVTV252RVR6M0xUc2UwTHpJNEZNbm9TL3RFcTBCWnZEN3NQ?=
 =?utf-8?B?ZlFPTHlDYm5FN2ROM21pYWt1VU5XbW1XNG1HODNQa2tmakc5OS8vL0Nod2Zp?=
 =?utf-8?B?eHFvTDBjem1rcXBVR1B0ZHVkR3dVK3B5WkxSQUNNb1hrcUlZb2poQmxHTmNk?=
 =?utf-8?B?RUs0b0p3NVZHZEFjdUVOQnNteXV2MmlpWFZhS2FjUzl2TXRla3BHNHRSSHdE?=
 =?utf-8?B?cWxNNnJRdGZyTjRKQUVmWjVWVEQ5WmFoVGFCTEQrMWFoQWtJQ1J6MUlpZ05H?=
 =?utf-8?B?T3JMWGg4Q1o2QzV6N2dLd25QYkhiZVhCTzFsYnVidWZPNzZGNXBYOTFKNk1X?=
 =?utf-8?B?RjRNOGZYanNibFIxbjhTWWZPSDdhSnYrK05PcURiaUZkVHR4M1NaVEY5dk55?=
 =?utf-8?B?UmhHYjNvUStCTFFOdUU2SGdDMmNQcnVzSFhZTzJmbTVrajdhUHZGdXJSaXpS?=
 =?utf-8?B?QVEyUnkzT3BGOHZ4WnZvd0drajQ1aTVFTm9mOEJqSm5vaGlKbnlOamhxUXpC?=
 =?utf-8?Q?9Mwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8479c626-d8e7-4715-e3de-08db2b9ac6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 12:33:16.5075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c32aZjR/+flwwadTPo/I67SjbKeVFnUQfqmjN5AOalPbGTP28fpY6xHBDZnM2v8bXkCAVHjmia8nybfAf7jO4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU0hB
Tk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggMjMsIDIwMjMgMDc6MzINCj4gVG86IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxp
bW9uY2llbGxvQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgWmhh
bmcsDQo+IEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IEZp
eCBsb2dpYyBidWcgaW4gZmF0YWwgZXJyb3IgaGFuZGxpbmcNCj4gDQo+IENDICAgICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5vDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXMuYzoyNTY3OjI4OiBlcnJvcjogYml0d2lzZSBvciB3aXRoDQo+IG5v
bi16ZXJvIHZhbHVlIGFsd2F5cyBldmFsdWF0ZXMgdG8gdHJ1ZSBbLVdlcnJvciwtV3RhdXRvbG9n
aWNhbC1iaXR3aXNlLQ0KPiBjb21wYXJlXQ0KPiAgICAgICAgICAgICAgIGlmIChhZGV2LT5yYXNf
aHdfZW5hYmxlZCB8IEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0KPiAgICAgICAgICAgICAgICAgICB+
fn5+fn5+fn5+fn5+fn5+fn5+fn5efn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBQcmVzdW1h
Ymx5IHRoZSBhdXRob3IgaW50ZW5kZWQgdG8gdGVzdCBpZiBBTURHUFVfUkFTX0JMT0NLX19ERg0K
PiBiaXQgd2FzIHNldCBpZiByYXMgaXMgZW5hYmxlZCwgc28gdGhhdCdzIHdoYXQgSSdtIGNoYW5n
aW5nIHRoZQ0KPiBjb2RlIHRvLiBIb3BlZnVsbHkgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nLg0KPiAN
Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IE1hcmlvIExp
bW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiBDYzogSGF3a2luZyBaaGFu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBDYzogQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBh
bWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNh
bi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gaW5kZXggNWIxNzc5MDIxODgxMS4uZmFjNDVmOTgxNDVkOCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBAQCAtMjU2NCw3ICsyNTY0LDcg
QEAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gIAkJ
CWFkZXYtPm5iaW8ucmFzID0gJm5iaW9fdjdfNF9yYXM7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2Ug
SVBfVkVSU0lPTig0LCAzLCAwKToNCj4gLQkJaWYgKGFkZXYtPnJhc19od19lbmFibGVkIHwgQU1E
R1BVX1JBU19CTE9DS19fREYpDQo+ICsJCWlmIChhZGV2LT5yYXNfaHdfZW5hYmxlZCAmIEFNREdQ
VV9SQVNfQkxPQ0tfX0RGKQ0KPiAgCQkJLyogdW5saWtlIG90aGVyIGdlbmVyYXRpb24gb2YgbmJp
byByYXMsDQo+ICAJCQkgKiBuYmlvIHY0XzMgb25seSBzdXBwb3J0IGZhdGFsIGVycm9yIGludGVy
cnVwdA0KPiAgCQkJICogdG8gaW5mb3JtIHNvZnR3YXJlIHRoYXQgREYgaXMgZnJlZXplZCBkdWUg
dG8NCj4gLS0NCj4gMi4yNS4xDQoNClRoaXMgY2hhbmdlIGdlbmVyYWxseSBtYWtlcyBzZW5zZSBm
b3Igd2hhdCB5b3Ugc2hvd2VkIGFib3ZlLCBidXQgd2hhdCB0cmVlDQppcyB0aGlzIGFnYWluc3Q/
ICBUaGF0IGRvZXNuJ3QgbG9vayBsaWtlIGFtZC1zdGFnaW5nLWRybS1uZXh0LCBMaW51cycgdHJl
ZSBvciBldmVuDQpzb21lIHJlY2VudCB0YWdzLg0K
