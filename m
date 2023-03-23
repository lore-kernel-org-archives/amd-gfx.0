Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F43C76195
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3216310E48D;
	Thu, 23 Mar 2023 12:36:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC8B10E48D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6f26InPgMwpMr2LjE9a0XMDR56lXM8HH24Zh/8GZz0B0AxSaoPeYELsKMK2BN59ujuEFHD0+gBZlHsM60UfC9nZbEdnfrxcYDud0Ngmrpwui7y63s5XCLHFD75zHuGiiTtGn68o2AQsRhExioQbiyD792UvTg19O4OVH58AS2UULwIlA5MsGhAIGcP9FFi3UpLQ/jISAeXz5gNCIsPSgTcatA7zs9xHy4vpcEnLHHsivl/UQ+aIwxuZC61Z7uRhEcm15dXh9VWbm9JKCvrgidYqL93Bhi64yKpki5ZDIv4+Bdz4SjU/AYJIoTXUbMpH2tqAQ6DLPN19CbQQgVz/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AVi2ivZMSWLhTAVVLO+lafspOOelUTbrRTyZlj/XII=;
 b=KkbpMXdSifAXotvzZ60B3zM2mPa/JV7i81Jb/zkOf4qjazlcGLFPe5VBlWf6d5jw9rqRrCVysRvtlV8YtQxv3ukGA5M74dWJEtqxcHFMMQsd2T9wDcc5m0ms1b0ZlQ07WbuNcDoq1vaJsKw60CIAbkF7lDvboxQz7Hy/Vc14xgqFejNajAkI5T0Jp30j1omfZMuvlL1P4ZR7/kXJ7MEHDgW4kzphLEBWOQ2jTSvE64L1/8yYeemM4aGcDevZ5sBsLp1z8Yf/0BzBxVzIA1FKl7oGeJUM0z869142MvIcUSlFvbzcSSWazovLhBe4AQCqZ43kFrPEP52+wxTbCYUQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AVi2ivZMSWLhTAVVLO+lafspOOelUTbrRTyZlj/XII=;
 b=vB4dj2VLFeqjOcO5RtQ+lMiFUkpCIDK5+n4tBcagBHHrdfEVDslJnk6//JCw72fjZi/+LIqGJTns8epHpg9VtjLP77+UJ5IbBJ6eQ4vUa8gG1vs3HdzT24MDkn+XsvLgaqDXwzfRM3oAhasgeSj56jaj6H2zdts4PbK/6GHArhc=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 12:36:42 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 12:36:42 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXYOURkYCGNefDUK3mypny9B1vq8ITEEAgAAAWvA=
Date: Thu, 23 Mar 2023 12:36:41 +0000
Message-ID: <MN2PR12MB412862810D7180FAD76DB3BC90879@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
 <MN0PR12MB6101863E54001078B11FA04FE2879@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101863E54001078B11FA04FE2879@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-23T12:36:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=33df8f09-a99d-44cd-bded-b4c8200031ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|DM4PR12MB6135:EE_
x-ms-office365-filtering-correlation-id: 189c06a2-d159-4e03-1b0f-08db2b9b4152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yft2FK/t/ldQYT1ikZHRpDXM88A4Gsc6o3N+rkuRF8SjBqhzb6skZZJgAwm3eOXD9sjOdE9iOLAS7iSQm/zIWAjqu5tdGQYxIYUv3UZ5udSNm9Mydeg4wJJO1Zgq/G8W2xnsfq4GoaRCLZcrNyKLjIuNvMsTQAAJgypKSV0UeL1IxqcoM2MTXbMWhBDXIC1vAgi1LtEjz0ZH7kEWO9A44L5EaRrh5JYnOnI9qNPIs9gtb4TzT3jA4BI9XUd72KelmKqbOZSBqpQaSxR18sDVHn1Vop+RdGPHBZG5bdcF3EbFyWEgNIFax/rNWeLSDLHUepBtPUOKuM63FzI/m9qdqW/cstFbCyQkg1urg7QTB7+gl5n/Oko70hCKkd131tNcCqAR45eUq7kxfFEMxqeQ+tc6g0DxRbH2Yb/HOHTDNQqRwExQV48mWcpeC9bEeOyU+KXxbc6Xa99+8o9p9Oe/dAFKDWN2uN8Gpn0wfCvbjsZZ73gw7XQRcbt+1NppgQiSs/3ZucbiM0VirSYJZloQziUP/jfhfA23PRAqzSK/uQ4TFYMxJm/OdfCVMM5zXdImAOnkbpxf7V7pR3wFTrxLj0/eUwwVGsIdBwuC8hnUcsIo8CJXl+R4az1D8xo2OZBIyXikdnJjMWRhOoCXgl13uzOmFvolVA32fZIWPmGPNTYTiSPDuIum6P3B/eoy0CzNDnZYwGE1E5z70D1eJJamHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(71200400001)(110136005)(83380400001)(26005)(9686003)(478600001)(186003)(921005)(7696005)(64756008)(66556008)(66476007)(66446008)(4326008)(8676002)(316002)(6636002)(53546011)(76116006)(66946007)(6506007)(66574015)(41300700001)(52536014)(8936002)(2906002)(122000001)(5660300002)(38100700002)(38070700005)(55016003)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHpoaGN6c05BVlhCdHdOZ1pGak1GOGFWdjROZ21VdmJxVjcwNjg4K3c0Q2o1?=
 =?utf-8?B?N2RHNHp5Ykdrczk4NzR2VVJEcDR4RlZzdURkaTJjekZBaDA5V1NyZ3NWZmRS?=
 =?utf-8?B?L2MwUkFHeHRRald2dkhXRDF6bEgxak52d2ZHQVcvMHBtWUtobExEdTJhUWRx?=
 =?utf-8?B?TFNESlJlOWp0MXZCRHlWaS85MlVLVStxYmVMaFBNaTE5MCtxZ21odU1EVU1o?=
 =?utf-8?B?M2NiSzZIY0dCLzl3VGpMVjdPd1JqUWpLM2hScTlleWVCL0dYREk3ZkRrVXBF?=
 =?utf-8?B?T28rZWsremVST1U1QkZDd0RLdi92dHpBc05yMy9Cc0RXZ1VZNVFId01VYVMz?=
 =?utf-8?B?czFob1docy9kK0FzQVhpMFZDUm5zektlVWRvZlA4YzRZQ1JLS0JObVVOSmQz?=
 =?utf-8?B?dThQcm51VjViWDVBdWZGMkFQYUpQTjFydEllRkN5bTgwckYrM1M5aFVFMTdQ?=
 =?utf-8?B?QkwrVzM2QlBHVWdIbStJTFQ0dlhmbnRtS3lPRkN5bzRGdWtYSGQzMnk4dzMr?=
 =?utf-8?B?ZGhheWFMVWdSRi9pWWd5M2J6dURtQ2xtbjA2N2ZqT29VM1NId3Fsd2N3T3p1?=
 =?utf-8?B?U1V5dURqenlJdVpKY003aTZxcXVtRW84ME82SHpNTjd1Ym90UndNQ3YzdHdZ?=
 =?utf-8?B?ZDRDK3V5UUVaZXkybjEzQkttdDdXaTVTaGJDMGcvOWhMTHVHSTh1ODc5KzJP?=
 =?utf-8?B?MmllY0tPYzRVdkVtcWh1dnFIVTFkVm1sNm94UjJ4VW5GODEzZ3BPMk5QVVNZ?=
 =?utf-8?B?Snc1TktUQm0rQzB2dU54OFRCRHdIc0VMZmtRZFErcTg0bnJBVzBxRGVlNERK?=
 =?utf-8?B?TGJCTlNQUmkwV1dKV1YxWm5UNHM0SVJaZmt2d1JySVpmVWo4NFN2OFpEZnVB?=
 =?utf-8?B?d2JWVmIySUhjMjljVWNIL2hRTEVMTmx4NnJlamdiQ0ZEV3NacVd0QVFxK1kz?=
 =?utf-8?B?NkppeTVPWHZZU1VqdW5pOG9NN0p0RWV1U1BGbzRsZFF4SmpMT2RqWWFWZ3Zx?=
 =?utf-8?B?RkxweFg2RUc3QWRzT1htNWIydnF0RzliZFVIR0drWjFuejRmN0pLMjdJY2w1?=
 =?utf-8?B?RnNWdERaY2V1RUpFcko5OTlwYTAwS0NOdHJjR0UyVXdhN205aGtZRTBlaGRk?=
 =?utf-8?B?V1pJYXBtUFk1Rkhma3dEMld6VEFIME5pUTBqQmE2dFRQM3pIUW1NT1ZMMnY3?=
 =?utf-8?B?ZExEMS9leXFua0ZYbHlqcGdWcmZFdjNHdnlQaFp1RFpTNXYvRVJPdDgxbHJZ?=
 =?utf-8?B?WEJyVlFnYno3Snc4MTlkbUtNWTN3cVU0UE5MTitaeDBKZjAwb0dkampEdDRz?=
 =?utf-8?B?YWd1T1NEekNLMTExR2ZhVTdQckdKUDJrMGVFMzBGTUc1Nzc3MXpFdG1JbkQ2?=
 =?utf-8?B?Ti9BMVlWQk83ZlVzVE9pYU52VUp2eXlpTlNZeE5XS2ZWUHV1RlZhVCthYjVN?=
 =?utf-8?B?SWJIbFZzWWtBL3EvSENuT0IyVzNRUUhrS3JFU3Nha0wwMlN4c1JYT2JMcHh2?=
 =?utf-8?B?NTRnWUhzcTJ4REFBYXFmbmJoaXJ4S1hQbHV4NE1CSzhJZXExellqWmNNQmxm?=
 =?utf-8?B?bnBtT2RjeXcxditjVDA0NWlSaUtwY2lZZytlVkwzSURuczJTTEJGdWRoR25M?=
 =?utf-8?B?T09oNHc5cndpUFU4d3ZyUHZOYmNZdDBDanVrTkpTRmhPeXp5Ulo0eGhoMWFS?=
 =?utf-8?B?VnF6Z083NXBJYS9iTUxOK3VQN1ZWWk1EK201TmwxN3gra3NIaGZGZzg3V0Np?=
 =?utf-8?B?ODlCM1YxeW9LSEtMK05KSW45VmdDUjVhaExFV0k2WWNGT2tHdll0emZUcWZE?=
 =?utf-8?B?eVlWTzlVcVN5UEJNamRUSExYTFlPT1BycENzc202QVUrb2Y4K0YwM3lhUHdK?=
 =?utf-8?B?MXlBNWZ2K1c5SzFORHV4T202dmVCZEFyV2dmNlFBZHMyNnRjY095aFk4UDJC?=
 =?utf-8?B?NXlZUDFsY2VqQTgyMkN0L08renhUUGgzV2Q4ZmcvKzh5V0hFdmd4ZW1jRm1H?=
 =?utf-8?B?Ry9OMFZ1a2VhME9zbitMalhlN0YrOTVPeDB5YXIvblg5anBTdUpHTWlsY3hI?=
 =?utf-8?B?N3NINnVKTm80OUlMajN4dmpwNFkxc25kZ2U2ZzgzQkhFbUZ5VnI0Z2x3U2xk?=
 =?utf-8?Q?60wtPGsZBTbOA36CNUap7NqgB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189c06a2-d159-4e03-1b0f-08db2b9b4152
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 12:36:41.8569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkbzaOqtBFBxmidS2KLov/afkFDazqIwulJLYQHryJ9RVGG53yKXL9WUPm6CcInu2Nu5wIr8JQFldcs7DFm4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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

W1B1YmxpY10NCg0KSGkgTWFyaW8sDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cywgaXQgd2Fz
IG9uICIgb3JpZ2luL2FtZC1zdGFnaW5nLWRybS1uZXh0Ig0KDQoNCkJlc3QgUmVnYXJkcywNClNy
aW5pDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGltb25jaWVsbG8sIE1hcmlv
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywg
MjAyMyA2OjAzIFBNDQpUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5N
VUdBTUBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpLCBD
YW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBS
RTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRml4IGxvZ2ljIGJ1ZyBpbiBmYXRhbCBlcnJvciBo
YW5kbGluZw0KDQpbUHVibGljXQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFt
ZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAwNzozMg0KPiBUbzogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciANCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8g
DQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlA
YW1kLmNvbT47IFpoYW5nLCANCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiAN
Cj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZC9hbWRncHU6IEZpeCBsb2dpYyBidWcgaW4gZmF0YWwgZXJyb3IgaGFuZGxpbmcNCj4gDQo+
IENDICAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5vDQo+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoyNTY3OjI4OiBlcnJvcjogYml0d2lz
ZSBvciANCj4gd2l0aCBub24temVybyB2YWx1ZSBhbHdheXMgZXZhbHVhdGVzIHRvIHRydWUgDQo+
IFstV2Vycm9yLC1XdGF1dG9sb2dpY2FsLWJpdHdpc2UtIGNvbXBhcmVdDQo+ICAgICAgICAgICAg
ICAgaWYgKGFkZXYtPnJhc19od19lbmFibGVkIHwgQU1ER1BVX1JBU19CTE9DS19fREYpDQo+ICAg
ICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fl5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gDQo+IFByZXN1bWFibHkgdGhlIGF1dGhvciBpbnRlbmRlZCB0byB0ZXN0IGlmIEFNREdQ
VV9SQVNfQkxPQ0tfX0RGIGJpdCB3YXMgDQo+IHNldCBpZiByYXMgaXMgZW5hYmxlZCwgc28gdGhh
dCdzIHdoYXQgSSdtIGNoYW5naW5nIHRoZSBjb2RlIHRvLiANCj4gSG9wZWZ1bGx5IHRvIGRvIHRo
ZSByaWdodCB0aGluZy4NCj4gDQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQo+IENjOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4N
Cj4gQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IENhbmRp
Y2UgTGkgPGNhbmRpY2UubGlAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBT
aGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+IGluZGV4IDViMTc3OTAyMTg4MTEuLmZhYzQ1Zjk4
MTQ1ZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4g
QEAgLTI1NjQsNyArMjU2NCw3IEBAIGludCBhbWRncHVfcmFzX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAJCQlhZGV2LT5uYmlvLnJhcyA9ICZuYmlvX3Y3XzRfcmFzOw0KPiAg
CQlicmVhazsNCj4gIAljYXNlIElQX1ZFUlNJT04oNCwgMywgMCk6DQo+IC0JCWlmIChhZGV2LT5y
YXNfaHdfZW5hYmxlZCB8IEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0KPiArCQlpZiAoYWRldi0+cmFz
X2h3X2VuYWJsZWQgJiBBTURHUFVfUkFTX0JMT0NLX19ERikNCj4gIAkJCS8qIHVubGlrZSBvdGhl
ciBnZW5lcmF0aW9uIG9mIG5iaW8gcmFzLA0KPiAgCQkJICogbmJpbyB2NF8zIG9ubHkgc3VwcG9y
dCBmYXRhbCBlcnJvciBpbnRlcnJ1cHQNCj4gIAkJCSAqIHRvIGluZm9ybSBzb2Z0d2FyZSB0aGF0
IERGIGlzIGZyZWV6ZWQgZHVlIHRvDQo+IC0tDQo+IDIuMjUuMQ0KDQpUaGlzIGNoYW5nZSBnZW5l
cmFsbHkgbWFrZXMgc2Vuc2UgZm9yIHdoYXQgeW91IHNob3dlZCBhYm92ZSwgYnV0IHdoYXQgdHJl
ZSBpcyB0aGlzIGFnYWluc3Q/ICBUaGF0IGRvZXNuJ3QgbG9vayBsaWtlIGFtZC1zdGFnaW5nLWRy
bS1uZXh0LCBMaW51cycgdHJlZSBvciBldmVuIHNvbWUgcmVjZW50IHRhZ3MuDQo=
