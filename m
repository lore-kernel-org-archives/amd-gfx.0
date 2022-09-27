Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C8C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 05:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F4D10E14F;
	Tue, 27 Sep 2022 05:38:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C0D10E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 05:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwgV+K8G9REg4uNf9jt7J5Lv1Pai9fmFhhHBdP8OEYLV4LOdvzZsLUFLnl0egL1GP82qfWiNbhtUaKUSGrzz3g2482Pm0znDEuQOibUGTQUgppd23Mx0skbua7YDqX/awhTDW1lfHXPpeQodLEsUvKHQBLlVvwZ+B8mzCTabtXX8fATK/dC2yQrGnzYYN1mGSRB27Yp1SF6WSu7BvNXFcG916rmZAZiK2Ct+smxR/Ev2t4vtvJ1WN+SrMKnSkIXLveJkpcl7ZOGkft/8gBnGfBYYtRtXSnYnt3hX468DppxMyLiWGOJepA0iVrQuqUGniLvkEFaejUmW0+oQv6fNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAbY8/SN/YYohXfafQalBJu10//OTFEGnQl5dprPRCs=;
 b=mfqf2dZ3oh8wFXQpzbV/TGGI9lG1+E9g2BdtZk2VYmTgTs72uLOqKhOCTYMp3XszZ4OtF11NHF5cN4Cz2JIOz6JDjSc2XikAtcSdC/uDH0MFJJKplr/d8IlF7bHAWQGqQQNe1fWPeO4NUhoH/l0SnQKvOPW0VpLbVzKJZI4uAF2rOiGFLOEQIovu9ZXk4eIp0BRaEE/+L77ZTeeVCdGAcyk4OD+vy23KhApfM8IaOaO7QVmvK7m/IzjgfMqSHLIZUA35898NGOPy9OApioKdkLfAl6tI8wCwpUYOUBbz3eKGgav1MYmUmxmUmBlte4eO0REateRhF8SuLTP3acSjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAbY8/SN/YYohXfafQalBJu10//OTFEGnQl5dprPRCs=;
 b=LnhcFaMLT9U8Rw8CFvm4EHUQcyQ7UHmwOp4RaXpDVYx2yPJqEBY99yWA1PCpx8YcAzqxDvvPou6Sb058Ut/++ethOaw+/gyhoxJ6o5BEvI5zRU4gA9SDREbM/6HPmzcs0iuUmmwOKvPf+kxSFoSSiutlkyzeQNOoeGAbwGxPi7w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Tue, 27 Sep 2022 05:38:33 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 05:38:32 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix a compiling error in old kernels
Thread-Topic: [PATCH] drm/amdgpu: fix a compiling error in old kernels
Thread-Index: AQHY0iKTKYNzJZDXqEWJk4szrD2lJq3ywkYQ
Date: Tue, 27 Sep 2022 05:38:32 +0000
Message-ID: <DM5PR12MB246997A72C8378BE6B427EADF1559@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220927033743.107390-1-Asher.Song@amd.com>
In-Reply-To: <20220927033743.107390-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4370:EE_
x-ms-office365-filtering-correlation-id: 6cb34ace-e196-4906-dd70-08daa04a8398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrbeUzD7BrWG9zjsYaCE42R+dOLvN46OEx1CvLNjhWMGPAJtb8ObSX3Qp6rwOu9+EYscrT6VPIcZHwKThqTS2rD+SHisemaYcKeV/uSWxMKI90pMB4Z2FiuvCLPxgW9Nptz345DBowLS8+BZhFZlzQPCYb3dX2dt8X8AxGAOIryPSnIFN/bHIiVtLYscEtXPyY8J6/u4LXxgBwvUP5mtQ5xqhiJHiy2dWIlmk45/IvjLxipOT3T+Zucshm2D6kHLpaS6PUPoMLh3RqtHKUxP/p9JAGzpPkaQEsxWhxXz3XkQA6cyjHQfByMBuXWAcTIMyuqIqWkwwBDubkfYoWO6xCbxecHR1FOJKSSNDmq+n71wjfIItYod1njBwICiqdK8wWSpBXAUJZtqJRGF2JQFR0RsspDcA8KI3E7kLV0SZJiJr5wXzRUWQ0YcHB02jVO2woM7ql5mfH6OlW87B/0SSNPdpIh5Eq7WHflft228A5WpOM6RA5X5a+ogQB6yTHA4Uha9fBP0wu/c14G0T0KeTHaHO2E7dqDGgr8J8vyTpJq/518RgT8UFKIG3qVaTLzEI9K1FdgYMlZ95rD9CmTqnVub5QnlgP1MjPQIm+FwKCIX35bvKpDgfa70vvUTv2hE3aAt2X1ix+hwW7JhPbh2bm395Qs8bDPIuo7lvzOer89RH2M9+E6H8qyrQzTxw/LAESv1N0pVWSE/Ogcsgk7Xy1yaSUgOc22WkbQNO+Sl9ZQ6Hnf0gasylDThK4fXxz/ygtCo9n6DoUNpBacQcndWEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(122000001)(38100700002)(38070700005)(66946007)(76116006)(8676002)(64756008)(66556008)(66446008)(66476007)(110136005)(5660300002)(2906002)(8936002)(52536014)(186003)(55016003)(83380400001)(478600001)(71200400001)(6506007)(316002)(53546011)(7696005)(9686003)(41300700001)(26005)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFRFa241UkpxYnpiWWpCeGNZdy9QRkxSNVphbG93ZGFvTkt3UEtKZ29SdXZp?=
 =?utf-8?B?dXZSbk9BbndDd1NvWm9HbmtPb3hPVytmbkxCa0dCNDY2VC8xa0h5ZldJTTVu?=
 =?utf-8?B?b2cvN0pyeEhTK29JWS84WGtkWWZNZUJ6SDY5Wm5QaUNQSUZHRGFKMUdRR0wv?=
 =?utf-8?B?SEJyQjdHWXlTWFZubVJPOGVvUnFIMXlhckp3MmoxRU5aTEZUUmxoWFRJSkkw?=
 =?utf-8?B?NTR5cmJSWmlsZkVQSGFCN29VUk0rUVdhMW8yUkM1dDNzbDhFelNvWnVaWnhx?=
 =?utf-8?B?RzMySVpVSDQrbFVtWDRDeWU1TjBhaysvVDYrYVVKWVJRZWE3OHBXVUNHNjVG?=
 =?utf-8?B?SnM2ZUJhempXcWlpMGRTVmcxcjVwOWtwcGxLMkVLMXZlSnFjcitYRTVIdnA0?=
 =?utf-8?B?Qk9JZnNyK25GVWdSaWFVbXFyRE1qbUs4OHFBK01yWFFhdnhCNTN1YkF6MEN1?=
 =?utf-8?B?bENJaUVVR3RPSkdJdC9ZRHZZMC9YcVRYU3EweEVtdWFHTG0xMVZSUVcrOXJV?=
 =?utf-8?B?c2d1bVBKdWNRVHpxYmJwVjQ1VlJxenFuYUcySS9LQStOMncxbVArS01DaE9k?=
 =?utf-8?B?eGlGQ1lHbHVlSThUbUZFWS9CUHZBQXd0WDhHOU9ORHpPRnU2dHVTdlNJSkVh?=
 =?utf-8?B?RFNWcy9TZitZRUE0SVhYWm9ubUN1RXpRWVpGMmt3WHR4VmpLWEZBbEhDZFdo?=
 =?utf-8?B?QmNHY0pkWmNIMnVGQlpRcWFzN2pEbVE1eFY2RGswYjV5ZkRjbG9NRU50UE15?=
 =?utf-8?B?c0tZOVhab3ZJVjBjbjhncExrWVVwUXZXUUI1cDR4RmZZRE13b1lHMlhpSnlw?=
 =?utf-8?B?YmJjNFMyK3RKNDRibWcyWHNBYm1YK0tqWXordXlORkJ2Zno1YlBhdkk4SHNC?=
 =?utf-8?B?cXFPaUpuMWJBM0hVQ1IyS1FDdWs4a2ZVZzU4TmdYYW13ZTNkU2xtU3l5V1RC?=
 =?utf-8?B?azRBbVNpbWVmL0pwY2xnYzRNeU1ISHhHdEtlUXUySVJQMUxVZ2ZqdlZHR1Uw?=
 =?utf-8?B?b3prMWNuYnFZbTM4c1VNenlsb3RQbjdpZmlZRVhCV2R4ano3SzlFRnFuRVZx?=
 =?utf-8?B?b21ZaVlwV2JrUkZ2MStGeVJ4TnVKZmpTMXpObkZVczRNSkFkdWhFRENFTmpH?=
 =?utf-8?B?bjJGVEV3d0J1ZzJIWHJ3c09wd0V3RmdMZmpMTUducnFMNTNTY3hUc2l1NkZ5?=
 =?utf-8?B?aisrTkJnOTI5NThlMGV0dE05SXdIakNGVmM2UVhGdTIzMGdOZEU0OVF4SHpI?=
 =?utf-8?B?Z2FIRng1QW4yM1NWZllrS0NTdWRpUExKQlpXZ2huWmNvOGxYR2dYNGgraitX?=
 =?utf-8?B?ZGpZN1lyb2F6SVZoTUMxa2h4czJXR1kyN21WZk12cmc5M0E1UjdpOVlXaHkz?=
 =?utf-8?B?NmRnNVlXbjBJOG54L3paUWltVDRhMnppYlk5QmgrS3pETFRieENtWG1rbmNM?=
 =?utf-8?B?SExwRm4vODlQUUlQNkFnSFRUMTQ2SkNPdkNQc1JxRXovVkQ5NTdUVjJLOUpj?=
 =?utf-8?B?RW1uKzlxSi9oOEZldjVUUmZIRzFHbEV6ZXNocC9IcTU2WVcxb0EwOVZVV0FF?=
 =?utf-8?B?cTkzY2ZtVHVIUmF2aDZvb3NrNnhjMTRuTklPc0F0WTZZL012dXJ4K1I5MW5z?=
 =?utf-8?B?MFVOTHFBUUU5UlY2OVhYd2doem42YVRNd0xTd3hQZ1llbkd5K3plOTdla0Fm?=
 =?utf-8?B?ZXNBZVV2anNsK3JMcjVlbVlxeXJpY2FPRG5xT3h0Sm5sUnFldVlGQ3dnOEpI?=
 =?utf-8?B?cTg2b1ZtWTVXUU42cWdsZndCNlJMMm16UkdwWld6TG4xRGE5cm9jMUJwaG04?=
 =?utf-8?B?OXdTWWorNFBSSmdOTldmN2J6NWIvNGFxNnlwR3FpL0dEelZxTjE2ZUhnRVRP?=
 =?utf-8?B?VDQ1Y1EzNm1Oc0dpWVFvWGxYdlA1eVRPL3o4Q29IWVRuRVdjcDFxb29yQTdC?=
 =?utf-8?B?TDNpOVR2Umw1SHpRT1hWMENBNUZGR0JlV2pybnR0YkFxL0E2RHpZZFhuenY4?=
 =?utf-8?B?MXk1YyszZU1WY3A4dUpsRDNCLytVS1Izc2NNL3FlRE43SUNneXFhVCtNeVE5?=
 =?utf-8?B?RldLdDB5Ulp1aFBQZnI2akpBRGsrZnpXc1IvdXVIZE5HNkQ5dy9pWmRvQS9k?=
 =?utf-8?Q?Wuluu/STQrCVBxZ5Sxw113bZA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb34ace-e196-4906-dd70-08daa04a8398
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 05:38:32.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNw7eKuaQx94gqT07Rt/Pt7FHonuKJZcdSDalkIw65PpOF0tLej3xAkYj15/WsgVFKpSAcyBwFL3fAXKF3ECrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTb25nLCBBc2hl
ciA8QXNoZXIuU29uZ0BhbWQuY29tPiANClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNywgMjAy
MiAxMTozOCBBTQ0KVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IEN1aSwg
RmxvcmEgPEZsb3JhLkN1aUBhbWQuY29tPjsgU2hpLCBMZXNsaWUgPFl1bGlhbmcuU2hpQGFtZC5j
b20+OyBNYSwgSnVuIDxKdW4uTWEyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IFNvbmcsIEFzaGVyIDxBc2hlci5Tb25nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWRncHU6IGZpeCBhIGNvbXBpbGluZyBlcnJvciBpbiBvbGQga2VybmVscw0KDQpU
aGlzIHBhdGNoIGlzIHVzZWQgdG8gZml4IGZvbGxvd2luZyBjb21waWxpbmcgZXJyb3IgdGhhdCBv
Y2N1cnMgaW4gc29tZSBvbGQga2VybmVscy4NCg0KZXJyb3I6IOKAmGZvcuKAmSBsb29wIGluaXRp
YWwgZGVjbGFyYXRpb25zIGFyZSBvbmx5IGFsbG93ZWQgaW4gQzk5IG1vZGUNCiAgZm9yIChpbnQg
aSA9IDA7IGkgPCBkYy0+cmVzX3Bvb2wtPnJlc19jYXAtPm51bV9kc2M7IGkrKykgew0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBc2hlciBTb25nIDxBc2hlci5Tb25nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzIvZGNuMzJfaHdzZXEuYyB8IDMgKystDQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMyL2RjbjMyX2h3c2VxLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzIvZGNuMzJfaHdzZXEuYw0KaW5kZXgg
NzcyYWQyMDBjNWRhLi5jOTFmY2RlN2ExNmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMzIvZGNuMzJfaHdzZXEuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjMyL2RjbjMyX2h3c2VxLmMNCkBAIC0xNDA1LDggKzE0MDUsOSBA
QCB2b2lkIGRjbjMyX3VwZGF0ZV9kc2NfcGcoc3RydWN0IGRjICpkYywNCiAJCWJvb2wgc2FmZV90
b19kaXNhYmxlKQ0KIHsNCiAJc3RydWN0IGRjZV9od3NlcSAqaHdzID0gZGMtPmh3c2VxOw0KKwlp
bnQgaTsNCiANCi0JZm9yIChpbnQgaSA9IDA7IGkgPCBkYy0+cmVzX3Bvb2wtPnJlc19jYXAtPm51
bV9kc2M7IGkrKykgew0KKwlmb3IgKGkgPSAwOyBpIDwgZGMtPnJlc19wb29sLT5yZXNfY2FwLT5u
dW1fZHNjOyBpKyspIHsNCiAJCXN0cnVjdCBkaXNwbGF5X3N0cmVhbV9jb21wcmVzc29yICpkc2Mg
PSBkYy0+cmVzX3Bvb2wtPmRzY3NbaV07DQogCQlib29sIGlzX2RzY191bmdhdGVkID0gaHdzLT5m
dW5jcy5kc2NfcGdfc3RhdHVzKGh3cywgZHNjLT5pbnN0KTsNCiANCi0tDQoyLjI1LjENCg0K
