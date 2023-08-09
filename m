Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C792C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 07:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8E310E25D;
	Wed,  9 Aug 2023 07:43:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C0010E25B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 07:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve5czYrBNMcOn0Js12HKJPwjeUhQGFQg13PavtAayhmjDgk6W174FcXw/FV/BqcXOAGep8QDuBXMU/7dOI9hSxeyR6be2esSKHwX2bsoe+ZuILwvdCqsNNKs86ibedCpDW+/H0P7ygj/1+Y6LVqv4t5FeCC19C86vFbz+4m0wj3bBmYW4YhXYXVfaZUMkFMjn2HpMZlYd04489ZfYwSwv+OonxKznhuv5e03jYtfoIKehq3pnCherFZY4jQlBEhDC9frLKMi2gWFcj6MDK/RWJghYV86CA3cRr+zJu4S3RtcO5aMBL0DZj2mqTICY5XmI2IwFVuh9WjHefp32egw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E48hxAfPln6+u9eS6yKZCH9E6sNF9VKm6eHuvnuTmcA=;
 b=mmxjCzBs3SO8+fTC5EwyZ5KfV7ieFu8QVKjxZ5V0PEHYQrjaYUCqLn7Yw3cHWE1+NTM9UDJOeCzR9aa1hUonP7iW3FVjOniLDfF5PYsU056R8EDFnD476tnqjmWG54YgKIxRmx8gVT+r2I5neZBM8YolQ6bnvHK6hSwL9UIExWolabiioz2yQuaSPlxzPeZRzkjsjsgtakciP82SZHr8aIvb8el09/vq/F7O3nzPcb62S5wUhT3sT8kaDw+XYCQd8xBqScOfykRMTe+eUg/5lcC0AcQZZRoQdk8HYIvVCWxAyLkNjUi+tFiSIsXKrZcDx9KfAD/5TQNgBp3Mu9aW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E48hxAfPln6+u9eS6yKZCH9E6sNF9VKm6eHuvnuTmcA=;
 b=pUScO2fWhhcAI1v/yIABqUEB2U/8hoZJpiQYpY7Br7c7ihhsTEJjcSPCqXPAOJRJPzMx7nyk6MWTHWJe6ASUcROdSPecHx7ANmbf2SGYl4R/fzhCP7kc0xiBgAgGZ0FW9yYbxHPobyon2BRi5zhOINvQ0VinTww5KzHBXVkTiT4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 07:43:32 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.022; Wed, 9 Aug 2023
 07:43:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: Fix missing comment for mb() in
 'amdgpu_device_aper_access'
Thread-Topic: [PATCH v4] drm/amdgpu: Fix missing comment for mb() in
 'amdgpu_device_aper_access'
Thread-Index: AQHZypNGmkQmuP7D0UmvXdTrY1SoJa/hlP2Q
Date: Wed, 9 Aug 2023 07:43:31 +0000
Message-ID: <DM5PR12MB2469CF75A055B3D13DF49611F112A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230809072917.242488-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230809072917.242488-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fccf6d2c-c7d0-4d28-8698-ccb38a5390af;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-09T07:42:43Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|LV8PR12MB9109:EE_
x-ms-office365-filtering-correlation-id: 9be781f5-9135-4606-21e7-08db98ac5429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9NBNHHp8osJE2Mki9INkVAdRo3RHHb2styeEkLYAQavw+Ib5KLZaRH8ujgH8OEyPLCoDqgJF0BvNhnEAoUo/n81P1uY4CUoiLSffALTOD2PeS+iBCdbItEW2dRMdH9m2uNzRheX9G7E0SO0eOXrDyN3VZmJ0DfCQl4RyZ6aUNls1cOw6yvNg3Oib1KhSeqYl7/sP5lm90W0XqLmARMVNIluyCU81sDpZT4CHYrKhi+9TQNYwDAl95QeNZz59USOYJHNVBg/eDcRh0/iH+cD0v5QWu+Tg79X2L05gw7VOahprJjxoS9xVvUlmM/LrK4hkWfPA+ykOQQHIP+bI0OQdrghkXUmks1QL1PpKSJtTLh7NgMGk0VRcbpLoCRcXwwVXm4RO1MFifQrqbvnLwkLcwrDaBgn2dIITNxytQmlTgEUpVbwVkYMxaEhs2Cz95gHBTpwo66jk/fqDE+013VirImSkk11iZxTDNgDBnjBU/ZzVrUxYMC4DvMe61R4wOzP3HWEiRN6dkLc337x7XEfMuCsQdxjlQeQuhKvY6H9+MFOd2DtPN3+ahSLlQvE1wVQr9v/dRiOk0OwY0pABbHhek6YX0C9xGNumU4rjFcx93SQyTQnwxIEFMOoxghmdhyO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(186006)(1800799006)(451199021)(53546011)(6506007)(26005)(9686003)(71200400001)(7696005)(122000001)(478600001)(33656002)(38100700002)(110136005)(66556008)(66946007)(66476007)(76116006)(66446008)(6636002)(4326008)(316002)(41300700001)(8676002)(52536014)(5660300002)(38070700005)(8936002)(64756008)(2906002)(66574015)(83380400001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3I0K0ZKenl5bzFqMllaV0s2OUtIOWdINldJR2U2MlNyNnkvNUhFNHhuVUVo?=
 =?utf-8?B?TStQNGJ3RkZZQ0hqRUtZcm9GZjg1WDBxLzJRa2lQLzlHRHlKOGh2UHdsaG91?=
 =?utf-8?B?cWp0VlhzN0xUK3hudmN2Tmw3SEdGcmFVWk14elpMdUJ2U0I1czFRbm5sdWZB?=
 =?utf-8?B?c09wV1hrRyttZ20rcXFYSHQ4WEFPU1RPZmdaQlZVMnBFQmsvQXZTcER4Q0Js?=
 =?utf-8?B?UTZOakJudzd0V1VCbDRYS1c4VE1rdGRZYzUwMXBMTk4vRFhzd0Nab1IxcDlo?=
 =?utf-8?B?cnhJNUxFRFZYUzVRZ09jT0c1aEJrVm5HaFRwZkxqV2xETnVUTUxXeG5XNWlU?=
 =?utf-8?B?RStjWlJTT3VrQXdTcHh2WWRkZnVscGhnbld1UEZIOXF2anI4NGNKWm03bkZ2?=
 =?utf-8?B?eEFRckdDZzM3bDlyNVpBYUlpS3pSZG5nRCtDNG9vaFB1Q3d3V2RCTjR5bWxO?=
 =?utf-8?B?Z01KRmFvWUFwQlI4OHlYM3pNdlJpT0wrT3RjSStrWmZ4VjB3TjVlY1BhOGgw?=
 =?utf-8?B?djZNWSswdjVsN1N4NkxkZDFFejVrbGw0cC9QY2drSzRPc0FtNWwzSjkweVlR?=
 =?utf-8?B?QmpVNks2MnRncWZaMUxOSXEzeHB4VWlmemFYRTJoa3ZPOGh4M1JlYnN0M0pV?=
 =?utf-8?B?YTVCTFFSRHRUd2JZWmtXaUd0cWdNcVFQblhtQ2pYNzMzRmM0dlF6bk9kNE8v?=
 =?utf-8?B?QzkwVDNWZ1pUYnN4c0lqZVNtNnkrbWhlS2xCVVZtRWliWVdEOHp3N3QxMHoz?=
 =?utf-8?B?TFRGazVGcEZ4cGZMdDRVNm1tTUpvRiswbVhhZDlTSnpEdG4xRkFNYmRVZnlE?=
 =?utf-8?B?U1RDa2U0cUZKU2x0d0orUUxOejBBcWpXUWRuWlFLa1I5N2E2N1JUbXdrQUha?=
 =?utf-8?B?OTMyMmNxREkyS1VXMFNCcWMydEcvOXN0TXNPZy9BODNMdkpINXk1T2VrMUxk?=
 =?utf-8?B?RTM2VGJuRWNIM0RQekZnOXU4alVBVHUzNXJLbmxKUUl3U2EzVWhlR1NSdmpM?=
 =?utf-8?B?VTN5REJCc2dWdmlsQW1FdHR1NU9YL1JyVUhmTm91MEdPODFsOGxZVEYzUDlQ?=
 =?utf-8?B?OHArN0hMTExQMTFvUEhJbnRJN0tXNTJFNXk0Y1pCMjJBbWRXUkFXV1lrSUZJ?=
 =?utf-8?B?V3dEYjFHNWFERFlpRFYycXBwcEZYSy9kQXpSZ2M2dDZGdk4xbmZzN3hxamU0?=
 =?utf-8?B?SzVISlE4a2REYVNxS3VDZTM1SDhLQlc3NCtqNnlnMHVWRXRqb3EwcWI0ekdi?=
 =?utf-8?B?M1pVMUQrMnd2dHB4MUUvTlFPY2g5Sy9uclhwTmtkYVF1UHIwWkkxT0Jxc1Qz?=
 =?utf-8?B?bU11RkJzckF0ckJtQXdKZCtoajBONm5RcnB4QVd1OUQvSTc3NWFyVlppeTVO?=
 =?utf-8?B?MXFlNndFazl3ajYyQ043bnZPVmhUZ0FOeE94bE9VRGVHdm5NQlljRTBxY013?=
 =?utf-8?B?WGlGNVhGdS9jcm1HSHNLbFFMZjZIMTQ5aTRLZ2ZIY0FmMnpCL05sd0kxdXZ1?=
 =?utf-8?B?TDZjQkVIbHErNmNUWlYyaFVpZytMY0ovZGlhcUZ0YUo2NExWUW5tU25QVk1Z?=
 =?utf-8?B?N0hzZG5WeVk1SG5pOCtFNnlHbnZhUFNKaVpIQ294VnRhbnRZcDU3NlpKQXVK?=
 =?utf-8?B?dUk3Ynl1S0tqL2dJNVJWTVBjdVNLZGNQL2cxajV0U0ZLQzRNZjRrYlpsQ21p?=
 =?utf-8?B?clNCWHhiQWZPU2FrTENYaDc3Z29YZ25hNGQzZmdVN3VGRmYrckdqdFhpcDV0?=
 =?utf-8?B?RUROOWFjY3RtYWVsbVRBWDhhVkNla2F0RDRLV0ZKTC93NEEzYTB4SUJaSWRn?=
 =?utf-8?B?WHdXUU1kcEI5T0xieVl3UkswVTBKanRkMDU5Q21HbWV5dG9yczhNYVZsNTVQ?=
 =?utf-8?B?ekg3bENHd0tNaHF5cGE0ZmJwbHVPUXRYdXVuUWlFd2x0ZGdqa2N4MjcycXd4?=
 =?utf-8?B?MnBhVXhJNzk0MGEwS0FqbzZtSi9wbERGcjZmOEVuT0pQRFpmYzV0Wi9kelo3?=
 =?utf-8?B?SEM4b041WmlwK3R1eGF1cDA3WktIM3ZtOXR0Qm1mdFl0dHp1VFlLdUNkQkFu?=
 =?utf-8?B?d0ZFSnY2aUk4bEExZmR0Y2Q0bDJzWXA2b1kzczkzQzVxc1o2VE1yTkFCWEFq?=
 =?utf-8?Q?N3aU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be781f5-9135-4606-21e7-08db98ac5429
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 07:43:31.6288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mI2OiCbKHO+KB77LWwS4RwQ3xfsO2zD9LCPqCYIuZo3eRlGMad9vZwYW8IvSP0W3XpL0ZfcRIYa5PUuV4LZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA5LCAyMDIzIDM6MjkgUE0NCj4gVG86IEtvZW5p
ZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+Ow0KPiBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0KPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8
U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY0XSBkcm0v
YW1kZ3B1OiBGaXggbWlzc2luZyBjb21tZW50IGZvciBtYigpIGluDQo+ICdhbWRncHVfZGV2aWNl
X2FwZXJfYWNjZXNzJw0KPg0KPiBUaGlzIHBhdGNoIGFkZHMgdGhlIG1pc3NpbmcgY29kZSBjb21t
ZW50IGZvciBtZW1vcnkgYmFycmllcg0KPg0KPiBXQVJOSU5HOiBtZW1vcnkgYmFycmllciB3aXRo
b3V0IGNvbW1lbnQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbWIoKTsNCj4NCj4gV0FSTklO
RzogbWVtb3J5IGJhcnJpZXIgd2l0aG91dCBjb21tZW50DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIG1iKCk7DQo+DQo+IENjOiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4g
Q2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6ICJQYW4sIFhpbmh1
aSIgPFhpbmh1aS5QYW5AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFu
bXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiB2NDoNCj4gIC0g
SW5jb3Jwb3JhdGVkIGNvbW1lbnRzIGZyb20gKExpam8pDQo+DQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQo+IGluZGV4IDRmODE4ZjEzZGM5ZC4uNjVjMzY5ODdmN2Q2IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC0zMDUs
MTAgKzMwNSwxNiBAQCBzaXplX3QgYW1kZ3B1X2RldmljZV9hcGVyX2FjY2VzcyhzdHJ1Y3QNCj4g
YW1kZ3B1X2RldmljZSAqYWRldiwgbG9mZl90IHBvcywNCj4NCj4gICAgICAgICAgICAgICBpZiAo
d3JpdGUpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIG1lbWNweV90b2lvKGFkZHIsIGJ1Ziwg
Y291bnQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgLyogTWFrZSBzdXJlIEhEUCB3cml0ZSBj
YWNoZSBmbHVzaCBoYXBwZW5zIHdpdGhvdXQNCj4gYW55IHJlb3JkZXJpbmcNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAqIGFmdGVyIHRoZSBzeXN0ZW0gbWVtb3J5IGNvbnRlbnRzIGFyZSBzZW50
IG92ZXINCj4gUENJZSBkZXZpY2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAqLw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgbWIoKTsNCj4gICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9k
ZXZpY2VfZmx1c2hfaGRwKGFkZXYsIE5VTEwpOw0KPiAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+
ICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX2ludmFsaWRhdGVfaGRwKGFkZXYs
IE5VTEwpOw0KPiArICAgICAgICAgICAgICAgICAgICAgLyogTWFrZSBzdXJlIEhEUCByZWFkIGNh
Y2hlIGlzIGludmFsaWRhdGVkIGJlZm9yZQ0KPiBpc3N1aW5nIGEgcmVhZA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICogdG8gdGhlIFBDSWUgZGV2aWNlDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgIG1iKCk7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICBtZW1jcHlfZnJvbWlvKGJ1ZiwgYWRkciwgY291bnQpOw0KPiAgICAgICAgICAgICAgIH0N
Cj4gLS0NCj4gMi4yNS4xDQoNCg==
