Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06381C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 12:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B8410E9AB;
	Fri, 10 Nov 2023 12:33:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6451310E9A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 12:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFXYXRkVpdyw4wyRg47FD8d2bMFK6DEtGVZrebY9/ltqhb/1ku3OeuIC8QSUAlyeqcIe3XXF/g9swq2Zj4UTIBMbOiJ/d3zxy5ULs0H4hRvzKAPyk5bCm/OexlqaZw+BbwBAdtpSoVMq/AG8hMrnNjS9zXwE4CqZcTMdrNMtH2Ym0ptCYZ+wi/fLDcqSFQZsQdLYqRejNAR+4fU8JU0QTYJr2I/PMWzAaQsqFFUHuHcf8VKmkxi/QBHRfytxGYNgzEHKDT2YQBUV1Orjaso/kMUsyPePJDfLLBRh1Vyh7s67e0jjGjPvSv38lPhN5f4EFN5xa4hHasuaD5untdNt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWaJGoQmofVcXBBUOcBm61xosAJ4Z4Su5TiGhn2P5Rs=;
 b=LQ81y3pn9HUpplLMyLF6e3F5xafwzOuJECFQxOzulQSSqM+spoEDWZlPTHi9ucxj0Nb4Dsp1i91S5v34U3eP+WD3rH4HJNFtyfdYuyWdTMkWK38rq7Po3Dcqd+2y+V2a0zOQ5L7xBNnuFvD6m5u+ArQIYHLdkmr7uL0QJblK4EFPf+Isz1BJiv0bBwVC47kasgFZhQMeSNTiwPY6/ljTq0sTM2+3VARXywaOtGcd64x5J2F+WLEFh4jWLh2kLDtCvaPRyqj1k62I89MnlZw9q/7pXa9mJuy+NAQPfqxdcj+SMgfOMXoxnxz+HLuQiVt5rg8COz35yRTQ+mgPF8yCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWaJGoQmofVcXBBUOcBm61xosAJ4Z4Su5TiGhn2P5Rs=;
 b=aQjslH4SPStmkXXuA3W07ymnrG0DsOr/pnCdJQwlOm/FLI4dgb2k4hHCzb4VcK8iqIV2ceujm9ppp+gJPt2GGG67RWQjXzTiTnnkBQGYh6/FaymklTC1RzSoDmHmH1gLGnN7dcgdkt2ZDirFMGVEliQUw9Dc4+R0lzMFuOznQU4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 12:33:24 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 12:33:24 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Thread-Topic: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Thread-Index: AQHaEt/G1HwoSsEyAEKEn3N/v0ob3bBzYUsAgAAdEnA=
Date: Fri, 10 Nov 2023 12:33:24 +0000
Message-ID: <DS7PR12MB6071998CBD52299E8B72B8DD8EAEA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231109073813.552664-1-lijo.lazar@amd.com>
 <805b31f8-3a49-c7c6-3f7e-044ff35fbfa4@amd.com>
In-Reply-To: <805b31f8-3a49-c7c6-3f7e-044ff35fbfa4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a768b7c7-a299-4e83-981d-02e9cbc6c3f9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T12:33:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|SN7PR12MB6888:EE_
x-ms-office365-filtering-correlation-id: 1f9b35b2-68d9-4630-a68c-08dbe1e93ba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BD80IyWoJ2RkdtNrJgEXxwITMqSRKtqaB9tV3Cx0KsPcqJlHkAhbxZdiCbsDW9oXvI46eceo/tiyyYf/p1ZgPyhrXh4ps11WsOK3jciAQAhN9E+FwF+j2FP2PKARlN+OqSBtdramb/WNOtjaV72CIlGcyFfly8PEUAGn2OQiZbd3iRTy+Wc07oQ9tEnHG5ptCuUTylls28WTCXRjBQF4IrTdK7BbZL17XAQ/CP42kA6Z8fpUTcjOdQ97VttnGO/+7nmtDYE1dMKfnQ3xIiWdRZSEC/VBdrYt69POCLLsG3QP2i2PhzE6uoeWDRQZwy6LanPw9tegaHSgDtb+pbHzToaFWAghMxmVFVd0ZLuKZK9XGGKE1cc+whpgBQPTRRYRCA27l7qJBI9yByLuqmlF9LflKaJS6xMXmOBJulJUh/ifrY2w1wDAENBlKNyaYaOZj6hL67kxgZ8jwCPg0cdCxvLMzCIALF481b42Q8LPvMGiYfMVBqPVBTDTm+cG+cOn1OMRefmB5Sf8ZVdAKU1XCya8WnSicvRlW9En2Qr0UC1hCZ3Oe8Z4zYbBMFZRnM9SFL4SZXfpRr0gZFrDZ1aGy739gfB0VtofSG15BaJVSECuNunohc6d3RZIrqVO080f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(9686003)(76116006)(52536014)(122000001)(478600001)(26005)(66946007)(66446008)(54906003)(66476007)(316002)(64756008)(66556008)(110136005)(7696005)(38070700009)(53546011)(71200400001)(6506007)(8936002)(8676002)(4326008)(55016003)(33656002)(38100700002)(2906002)(83380400001)(5660300002)(41300700001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFjWTF4YWRkMjU0YmNlbU5uaEtSY1ZtVmprSjJ2Unk1SjVwcnBDUEc1VnRz?=
 =?utf-8?B?ampHc2lQL1RoSWFybTJpTXYxTkVraTh5T1R4RjBDMm5YZlk1RHJoN2YyZytT?=
 =?utf-8?B?SXQyZUYrR3VZcm1oUGNIaWVua1UySHBlWHNBRERZSElhUGo5ZVBuRmZHUlNH?=
 =?utf-8?B?Y3dpOUlRZkpnNU8wVkl6ZU96NFIvWHZwb2VjSGZFVURyaUdqT0NmUUc0d09j?=
 =?utf-8?B?QitJM0U1dHhNRXRseWpGcEx4eGt4WWRwYzYxa1QranplSHhYVVNjVEhIejJy?=
 =?utf-8?B?aUVGQVdWYnZBMXJKd2h0YTJIcFJKelMyRENPb0lNUU1PQnhHbk8wZ1dKaWhu?=
 =?utf-8?B?dmNQcmNucTEwSHA3bFhWeHVPZDVzKy9YbzM1RE8xdUlWNFdxWllxcUNBN29p?=
 =?utf-8?B?ZWNVbEFLQnIzT0dxU0V6ZFhmTC9tR2VqMXJ5VktEcmtSVlZCU0h2UE9FQzF5?=
 =?utf-8?B?aDUxQ3gvOVpGUnRjR3dWQmRhV1pQWjdlY25ld1pqc3BWVFVPMjMzVy82OGoy?=
 =?utf-8?B?c0ZmSjhEc2xIZEgzN0NKMzFVbVpRaHZwYXNnWVNmdzBGUm1MUG5Yc1FUVVor?=
 =?utf-8?B?UCtuZVNOaGoxRmc1SDU4dm1BZnhQbTdIZ1RTeW5ZdGt1aWkzUmFBeEg2c3Ax?=
 =?utf-8?B?ekZlZUo1ZGpuUzQxcmRtQUxkYkRqZC85dWc2S2lHTldwSWdCZzVvK3doekUw?=
 =?utf-8?B?V055SEw3R2cwQkxUV1R6WHdwRmlRbzNNS0U3dHEzQTEwREJURGw0ejFYRVRT?=
 =?utf-8?B?enZNYytCeXYzOVRiNmFuRjd1amNRdDZneTBMbmFLcTVlR3dGS2hlcVRMKytu?=
 =?utf-8?B?SHY0TlhXMUlERXp2N2dsYzZicG96NGVWMHRTdm1ESE5Wb2hxRUh2WTVSSzBN?=
 =?utf-8?B?aVNEM3VTdjRaN0JGQ3ROQUhHN1owUU52RngyTzZ4Y3p6d0lTcUdJblVQQzMx?=
 =?utf-8?B?aGM4UGIxbnJ2MWFQcXZxVWN4MlBGVnJXYldLTm1sZzVGVHhvb0dPc0RzMVJr?=
 =?utf-8?B?eUU2VzhYSnVkWDJ6KzloNE5YQS9NeGVJc3pwak9xaE9Mb0wxU1dzTDhFcnpV?=
 =?utf-8?B?WDlNV1FjMmpHYnFRQzB2U0xpL2dkN2IrNlZjditRNURUUTcwK3ZFOXZUakpC?=
 =?utf-8?B?bGowYmtXQzdrYmJwV0VIWkdhakk2ZVlOVXlIb09IdjBzblV3a2ROcnl2OUl4?=
 =?utf-8?B?dlJlaFY3Z0J3RVhtK25rMHpEQnYyUm5scTBTVFNjd3AwR2NLSXZkSnlGSTYy?=
 =?utf-8?B?RjdyWFJyWklYOHd5UnhCcmtkUEQydE1SSmN1TzBKY096YXo0aWFvQWdmS0M5?=
 =?utf-8?B?cW5KamZlTkN5dlhiblZKOW1LUzVkT2ExcTR4TSs5V3llTXI3SnRuT1B6K2Rx?=
 =?utf-8?B?SnFvZjNVWitWdjNkNWZIdms2YVRoVnNJVzNheWt6NWdLVUxidkU0c1NKRlBh?=
 =?utf-8?B?RDVhTmtUODNZWWplc2p5T2ZOWnZZaDNxVXZKL1F5YkdMTHliNmJEZWhDcFh1?=
 =?utf-8?B?VXVQNENXY2tpdDhZZWlRUmZPTkdMNEJMZXdNdmZPVG1PcXErK3BKY3JvbnZU?=
 =?utf-8?B?cmRqVVJwS0hhQ280TjY5R1RYREdaSlBFS0dEL3BzZ0d2N2Q2UTVoYWprZHlk?=
 =?utf-8?B?dWxxSTMzTmgrNE4rc0d3dlJHcWZ3d3Q1bEtmVlJZdHdMNFBwM0VqNDFlTlFx?=
 =?utf-8?B?NG1zelh5eXFzSXdxSWxlTEQzTi9kbmloamI5cmRMZ3dlNG1qZ2pvMU8zTWZj?=
 =?utf-8?B?ZERnOWJva1ljTlpvYjd5NExzeVVHa0wyVlJYYXNMdWhPd3g4VDBtNzRVNWMy?=
 =?utf-8?B?Mjg2OGpiZ2FVanB5VzFCTExHSFJ4ZHpaVWJNeGdaOTF2dXcxaFQ3bnR3Q3VT?=
 =?utf-8?B?QStiM3VncGlQejlKWk9LbllMWTllRWNXNUhEVTJ3YXUrbHhha3RFc09QN3ZM?=
 =?utf-8?B?cnpDalFxdDlRT09EQytWQlhyZEY4Wk13b3RDMGdzK29ZbWJtTlNzVTVKVERN?=
 =?utf-8?B?T2VmTTBQUitGZFpGcFhwS0FMc0xlY2hpeTdHTTduSjBmSjlnc0lBbDVVdkNR?=
 =?utf-8?B?TE1TbWVFeWVCK3ZmT1JBRUdWTUlRVVlTT0htVW03WEF5Z3FZREM3R1lVcmJy?=
 =?utf-8?Q?nxmM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9b35b2-68d9-4630-a68c-08dbe1e93ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 12:33:24.6895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDmXwtLUXgaV2gNpBsu/oVAdmli01lsKTkQZH5oEbLmfjaTagL6J2NxSXlOQ+PSzz3VC5qFFz/Nq5qjhm+sJQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBBc2FkIEth
bWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQoNClRoYW5rcyAmIFJlZ2FyZHMNCkFzYWQNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMYXphciwgTGlqbw0KU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMCwgMjAyMyA0OjE5IFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGdwdTogU2tpcCBleGVjdXRpb24gb2YgcGVuZGluZyByZXNldCBqb2Jz
DQoNCjxQaW5nPg0KDQpPbiAxMS85LzIwMjMgMTowOCBQTSwgTGlqbyBMYXphciB3cm90ZToNCj4g
Y2FuY2VsX3dvcmsgaXMgbm90IGJhY2twb3J0ZWQgdG8gYWxsIGN1c3RvbSBrZXJuZWxzLiBBZGQg
YSB3b3JrYXJvdW5kDQo+IHRvIHNraXAgZXhlY3V0aW9uIG9mIGFscmVhZHkgcXVldWVkIHJlY292
ZXJ5IGpvYnMsIGlmIHRoZSBkZXZpY2UgaXMNCj4gYWxyZWFkeSByZXNldC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgNSArKysrKw0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5jICB8ICA5ICsrKysrKysrKw0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNldC5oICB8IDE2ICsrKysr
KysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBpbmRleCBi
ZWJjNzNjNjgyMmMuLmM2NjUyNGUyYTU2YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiBAQCAtNTQxMSw2ICs1NDExLDggQEAgc3RhdGljIGlu
bGluZSB2b2lkIGFtZGdwdV9kZXZpY2Vfc3RvcF9wZW5kaW5nX3Jlc2V0cyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikNCj4gICB7DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBh
bWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOw0KPg0KPiArICAgICBhbWRncHVfcmVzZXRfZG9t
YWluX2NsZWFyX3BlbmRpbmcoYWRldi0+cmVzZXRfZG9tYWluKTsNCj4gKw0KPiAgICNpZiBkZWZp
bmVkKENPTkZJR19ERUJVR19GUykNCj4gICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikp
DQo+ICAgICAgICAgICAgICAgY2FuY2VsX3dvcmsoJmFkZXYtPnJlc2V0X3dvcmspOw0KPiBAQCAt
NTQ1Miw2ICs1NDU0LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgIGJvb2wgYXVkaW9fc3VzcGVuZGVkID0gZmFsc2U7
DQo+ICAgICAgIGJvb2wgZ3B1X3Jlc2V0X2Zvcl9kZXZfcmVtb3ZlID0gZmFsc2U7DQo+DQo+ICsg
ICAgIGlmIChhbWRncHVfcmVzZXRfZG9tYWluX2luX2RyYWluX21vZGUoYWRldi0+cmVzZXRfZG9t
YWluKSkNCj4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgICAgICBncHVfcmVzZXRf
Zm9yX2Rldl9yZW1vdmUgPQ0KPiAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9iaXQoQU1ER1BV
X1JFU0VUX0ZPUl9ERVZJQ0VfUkVNT1ZFLCAmcmVzZXRfY29udGV4dC0+ZmxhZ3MpICYmDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfYml0KEFNREdQVV9ORUVEX0ZVTExfUkVT
RVQsICZyZXNldF9jb250ZXh0LT5mbGFncyk7IGRpZmYNCj4gLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yZXNldC5jDQo+IGluZGV4IDRiYWEzMDAxMjFkOC4uM2VjZTcyNjdkNmVhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuYw0KPiBAQCAt
MTIwLDYgKzEyMCwxNCBAQCB2b2lkIGFtZGdwdV9yZXNldF9kZXN0cm95X3Jlc2V0X2RvbWFpbihz
dHJ1Y3Qga3JlZiAqcmVmKQ0KPiAgICAgICBrdmZyZWUocmVzZXRfZG9tYWluKTsNCj4gICB9DQo+
DQo+ICtzdGF0aWMgdm9pZCBhbWRncHVfcmVzZXRfZG9tYWluX2NhbmNlbF9hbGxfd29yayhzdHJ1
Y3Qgd29ya19zdHJ1Y3QNCj4gKyp3b3JrKSB7DQo+ICsgICAgIHN0cnVjdCBhbWRncHVfcmVzZXRf
ZG9tYWluICpyZXNldF9kb21haW4gPQ0KPiArICAgICAgICAgICAgIGNvbnRhaW5lcl9vZih3b3Jr
LCBzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbiwgY2xlYXIpOw0KPiArDQo+ICsgICAgIHJlc2V0
X2RvbWFpbi0+ZHJhaW4gPSBmYWxzZTsNCj4gK30NCj4gKw0KPiAgIHN0cnVjdCBhbWRncHVfcmVz
ZXRfZG9tYWluICphbWRncHVfcmVzZXRfY3JlYXRlX3Jlc2V0X2RvbWFpbihlbnVtIGFtZGdwdV9y
ZXNldF9kb21haW5fdHlwZSB0eXBlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKndxX25hbWUpDQo+ICAgew0KPiBAQCAt
MTQyLDYgKzE1MCw3IEBAIHN0cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluDQo+ICphbWRncHVfcmVz
ZXRfY3JlYXRlX3Jlc2V0X2RvbWFpbihlbnVtIGFtZGdwdV9yZXNldF9kDQo+DQo+ICAgICAgIH0N
Cj4NCj4gKyAgICAgSU5JVF9XT1JLKCZyZXNldF9kb21haW4tPmNsZWFyLA0KPiArYW1kZ3B1X3Jl
c2V0X2RvbWFpbl9jYW5jZWxfYWxsX3dvcmspOw0KPiAgICAgICBhdG9taWNfc2V0KCZyZXNldF9k
b21haW4tPmluX2dwdV9yZXNldCwgMCk7DQo+ICAgICAgIGF0b21pY19zZXQoJnJlc2V0X2RvbWFp
bi0+cmVzZXRfcmVzLCAwKTsNCj4gICAgICAgaW5pdF9yd3NlbSgmcmVzZXRfZG9tYWluLT5zZW0p
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0
LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzZXQuaA0KPiBpbmRl
eCBiMDMzNWExYzVlOTAuLjcwMDU5ZWVhN2UyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jlc2V0LmgNCj4gQEAgLTg3LDYgKzg3LDggQEAgc3RydWN0IGFtZGdw
dV9yZXNldF9kb21haW4gew0KPiAgICAgICBzdHJ1Y3Qgcndfc2VtYXBob3JlIHNlbTsNCj4gICAg
ICAgYXRvbWljX3QgaW5fZ3B1X3Jlc2V0Ow0KPiAgICAgICBhdG9taWNfdCByZXNldF9yZXM7DQo+
ICsgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCBjbGVhcjsNCj4gKyAgICAgYm9vbCBkcmFpbjsNCj4g
ICB9Ow0KPg0KPiAgICNpZmRlZiBDT05GSUdfREVWX0NPUkVEVU1QDQo+IEBAIC0xMzcsNiArMTM5
LDIwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBhbWRncHVfcmVzZXRfZG9tYWluX3NjaGVkdWxlKHN0
cnVjdCBhbWRncHVfcmVzZXRfZG9tYWluICpkb21hDQo+ICAgICAgIHJldHVybiBxdWV1ZV93b3Jr
KGRvbWFpbi0+d3EsIHdvcmspOw0KPiAgIH0NCj4NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhbWRn
cHVfcmVzZXRfZG9tYWluX2NsZWFyX3BlbmRpbmcoc3RydWN0DQo+ICthbWRncHVfcmVzZXRfZG9t
YWluICpkb21haW4pIHsNCj4gKyAgICAgZG9tYWluLT5kcmFpbiA9IHRydWU7DQo+ICsgICAgIC8q
IHF1ZXVlIG9uZSBtb3JlIHdvcmsgdG8gdGhlIGRvbWFpbiBxdWV1ZS4gVGlsbCB0aGlzIHdvcmsg
aXMgZmluaXNoZWQsDQo+ICsgICAgICAqIGRvbWFpbiBpcyBpbiBkcmFpbiBtb2RlLg0KPiArICAg
ICAgKi8NCj4gKyAgICAgcXVldWVfd29yayhkb21haW4tPndxLCAmZG9tYWluLT5jbGVhcik7IH0N
Cj4gKw0KPiArc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9yZXNldF9kb21haW5faW5fZHJhaW5f
bW9kZShzdHJ1Y3QNCj4gK2FtZGdwdV9yZXNldF9kb21haW4gKmRvbWFpbikgew0KPiArICAgICBy
ZXR1cm4gZG9tYWluLT5kcmFpbjsNCj4gK30NCj4gKw0KPiAgIHZvaWQgYW1kZ3B1X2RldmljZV9s
b2NrX3Jlc2V0X2RvbWFpbihzdHJ1Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbg0KPiAqcmVzZXRfZG9t
YWluKTsNCj4NCj4gICB2b2lkIGFtZGdwdV9kZXZpY2VfdW5sb2NrX3Jlc2V0X2RvbWFpbihzdHJ1
Y3QgYW1kZ3B1X3Jlc2V0X2RvbWFpbg0KPiAqcmVzZXRfZG9tYWluKTsNCg==
