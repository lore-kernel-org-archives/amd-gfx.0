Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA7AC64ED6
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 02:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE8910E545;
	Fri, 24 Feb 2023 02:26:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD46910E545
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 02:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i99W+iT2kUA+122dUfTB4EqW7pg+94QHRJLW+0Fo3huG0omhGCxBWbCd3sC4WQiqA5waRxZsP8IXJU3eRVNX56rcS1+kGZUpYEyDh9p2SCjffuOYC3Vct38VnKieIE8WeXBTfh/UbwRG0f6n7at0DCVmnOaehqkDXfC6AVtlTN7icAZCdnNzsDDnZZQ/MfXOjLjDFP1Kys5jhzcE5Lsr9NAKo9AexHc2fiWiPNpjdeMqN7Qhzg6tsa8mlZaRKXBCg1XJqRACYuc2g5rlGms5P6TaKvfn30bupl9ZoT9YV7zCsddvLXRVKJAXifmD719d/Rtd8J5EXKNz/ALF0VZvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZCPSuaH/3WE47fuJ+wXQF/c3y5q+tXqpH2J7a39jX8=;
 b=nHfo5xBOMrgZeShsW4fhl3mnLMuaa6sTP9Zh/VxVkoSq6HbqbfZDeSulp/JUanc1hwVLXlBtbndCXhqPHYeWzW+fwL90YwX+6n9NG+XFIo0QYPQtd6V7+7aF3ShqM9QHYoCQIfh5mWotV3tgG5MryvH7TNkJW6PLwNo5awhKvbh9NJY546JL3HAFvmUT1SoX3P3YBXtFOiBj9n4eGjw1KZAWEj0i4VszDioBO7bBg3N0JNKYniDZf6IdB1RiPH8iV63tTQ6Wpg2vIAhPLPdwtsKeVYxqG5cONkoB5Q82fXlpbmdx4JawONT2+633dyMZh2OcrC+MVU9Iy3m2Gh9AiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZCPSuaH/3WE47fuJ+wXQF/c3y5q+tXqpH2J7a39jX8=;
 b=f3+wzkA7POETwY3eWBIHDzIcH/698zJKqGrUlh0kEkhkLdcVak2hrkG1ulaFkuHvFh/WFmxxSOcVUuiAC+N9YA/bhlEAf8FYTO2lPVI2h0Pr4HhGQ0rDuL2eRZCj1S8oVt7lwAm1LqkuVnZJ4xOJlp7v//cQcy/HEpKbK4eNWLE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Fri, 24 Feb 2023 02:26:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6111.019; Fri, 24 Feb 2023
 02:26:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Bert Karwatzki <spasswolf@web.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
Thread-Topic: [PATCH] drm/amd: use drm_kms_helper_poll_fini in
 amdgpu_device_suspend to avoid warning
Thread-Index: AQHZR8uVIouso5QalEmxjBr/Sj3Sia7dXRXg
Date: Fri, 24 Feb 2023 02:26:24 +0000
Message-ID: <DM5PR12MB24697477DE905E5985169EECF1A89@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <002235887cbe5ee00240b568223fdb3bb3a25c53.camel@web.de>
In-Reply-To: <002235887cbe5ee00240b568223fdb3bb3a25c53.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4042:EE_
x-ms-office365-filtering-correlation-id: 23b48edf-bea2-4010-fbf7-08db160e8690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ry9nyFxtRKr4hqlUSRogyCGu3QzPzn+Tt5rwCrwj5Y30tuvcK3JRyQf6HzmyO0PE+5xFIRUtOUdxSRlxVSnodP8dTB/IBW/ahqxRqLeHLu7xcIxnmMhx/04TLqfzHy6sfTwfBhvZcyoPts+0qWNw992SlBsHR7ABX0+lQiinhcIetPcxGiaIvmMZe08L/CmqEw08Kr0h/6e5M5ge8QyQ9vhf06tzrUDf6oMyF9ztNyJY50HeKf1jQvC8yMGAHD8nmFNufk1jROKFipsGTxhEA+qs7+dUmSz1tt08zIOL6uSkhduK4cqFdlXT3q4EXoO4C4OorX/dm66Ezt654apM4Z+pyEUKlMXt8cDO2CPa3l4JSCnWp6LUJzYz8SIHQaUBvd23SOqFqlnYv33ytdQuJj2hVVsk1wLctJEfw9D2LK6c+Yzuc4o0XFdcwxoRSwguDt4Z8fBGZR22BOzObRwlmCDxNNlEZWHEg5IDz7KTMcruudwngjS9FHcR74nVTjexPMfyhwIxN0eT8alrutmUr2G21J91krjYvfET1u5aW2vNh7pfbYs5+wK3Al2Oa0F72t1aQAqH7s9wFYY2EXPbd8KUSCRoHErtrSclMeB3uvEXCGiPcMSTps/sQfzp7e7ajLnFTaa6tYiaYFKrq6nacw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199018)(66476007)(64756008)(66446008)(76116006)(6506007)(66556008)(66946007)(83380400001)(110136005)(8676002)(52536014)(8936002)(316002)(5660300002)(41300700001)(53546011)(33656002)(26005)(9686003)(186003)(966005)(478600001)(7696005)(71200400001)(38070700005)(55016003)(2906002)(38100700002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkxwSEhjNjlCUlB6ak82Q2ROVDh6MmNKczRJRTFlVnFnallZU1V0MHEyUHA2?=
 =?utf-8?B?bk1pU0tpS0hIbGV4ckNoZFlkem1hVFNuci91Z0loWW5qSldpbWNLbDdUNGx2?=
 =?utf-8?B?NEV6NWUzOXF4WVZ3b2x3K3Bld214R0k2aXZmR3pXaXozUmp6NEV4Y0NvSDdT?=
 =?utf-8?B?RTJLaHhoNTNRTXF4cGJjZzV6MEFpVTBrUnpJcGVacHNvbzBXTVltWnV5RDJv?=
 =?utf-8?B?d3lnNFlId1l2TUhDNFJpTmM2UllvTG01a2dITGVyckdFdnBPTEwwbWQ5ZGlJ?=
 =?utf-8?B?VE8xbTlCOTdsT0lvZ09NQWRjR1RDa29aR2oxOStDSHNpc25SNHdBci9CUDNz?=
 =?utf-8?B?OXMxKzdSTG9yM3JpSFlVb1Z5cXpMR3phL2Z3cTdjZWRWekFpZWwzb0Mrb293?=
 =?utf-8?B?aUVCR0dqUG5uN0Jka0gvNk9NNG0vSmhIZHhwalZEeHE3T3BZc1ZkQklSeU9a?=
 =?utf-8?B?dldYb0FQU1VoVUNrUTMzbytkOGRhcm16cmV2dFNnRHJrNGkxZU9EZ0kxaGNM?=
 =?utf-8?B?TFJQK3FwSS9NSjVveHpEcEZSOFdIVWozdTFOTzR5TUZHOTZqWG9QaXFsaS9k?=
 =?utf-8?B?ZU4zU3djVjhDT3JWVU5uWHBMMTc5ek84Nmp5bEpTMkZBejRoR3hrRzRpNk9l?=
 =?utf-8?B?S3NMZzQ4djVCSk0wWHpmUk81S1FBTDJQaEZpeVpPYWpkczF4MG41a3pxWW16?=
 =?utf-8?B?NHlnNDE3aWxjZTZjaHptWnJSUU0xREY0bmd3SGNab2xsd3hyczFSVTM1ck5C?=
 =?utf-8?B?U0NURkFmbmxQNkR2VWRQL09QL2dUVENIalJEMHQ4cW80MnJ4OXRENmdzZHdV?=
 =?utf-8?B?amxiMWFXUTh4dXA2K2FsOWhnU1pXSStSTUdoN0xWblR6aWxObmk1N1NqQ1JP?=
 =?utf-8?B?MGlqQXFtdjdDRmQybUxXZGZkd0tWOS9RdytBRnFxYUhDbHlIMFhITlFiSzdm?=
 =?utf-8?B?TTNiRmlGUGU4MHdvVjRXV0h6SHNmWmN5YmU2enZBWFNYenAwbU5qMW5iMmZz?=
 =?utf-8?B?ZzJuRUxKL0RkTVVVM01wYWNVcGVPeGNDdW43QUYydk1wbjJiUm8rUllLbnhO?=
 =?utf-8?B?MEtEOGlHS00wNkhFMk81UzRNYVNNNzZ6UUNkeFBIaHRWa2RYalNhVFNXR05F?=
 =?utf-8?B?MXdQTGxSNVY2SU40ZkFlcTM4cFJYbnNyNlU1QTJRNnl2bEpMWlllVFp4VVVt?=
 =?utf-8?B?MkFjaHhObndHZUhnSjNRRTBjL2VyaWpwaEhUb2hqNHJTcjdtQXpybUIwZ1hH?=
 =?utf-8?B?dXZra2dja0ZKZGErWVp3K2xMRkRLR1VqaExSUHdzMmRBNG9VVUNqZy9MNW5D?=
 =?utf-8?B?R3hWNWZTWmtqSnJTVFZaQjBRbHdHV0FuVkxZVFVqdCt1eVlnaERHaTZqbzl5?=
 =?utf-8?B?V3I1c3RjeUF6aWk5cFRCWkNISENJTlRYaExRV0JvYjBKa0ZSeldhd1hBdnIv?=
 =?utf-8?B?ZE5PVzRnVzZuWE1rZ1o2ekVreWpVM0d0dFNtY1RkVUY3ZXg4NVdKRTlDTHFw?=
 =?utf-8?B?NThRQlVkZDFaekhLdUt0M1BmejhaemNUT0ZISkk4cDB5M1BsYlZhTFROaG9u?=
 =?utf-8?B?Y2pYSi9OY2lzYUYweHQreXFpS1lGOXhVMElONDRwbFA4bUlZVHBaZFJDZ044?=
 =?utf-8?B?eUpzcnhlZWdQQmdQOEY3b1dqYnczK1I0bW5jRnoxOWQya1o4S1Z1MmVqQ3Zl?=
 =?utf-8?B?UXd0cEV4eVFVSGNmcGR5NEFWMzIvR3lJUUtQWG01bjhVWW5WNGM3M2xwRnBB?=
 =?utf-8?B?alFpb0E3ZExtaDA3NUZHNW5rREkzclpNZ0E1TEUrbFcranBNVHB1bU52NStW?=
 =?utf-8?B?TkpXbU54d1M0QjdVc2xLOEo5OVBwVnMrUWNGUzhtNEJTeDRhbFhjRW9UT1Rl?=
 =?utf-8?B?d2lnanFlY3EyWE1DU0xqdTh3TEE2eWtrZlE1STlNbWNDbDV5bDNJVTlrT2pm?=
 =?utf-8?B?REVRK1M2TUJORHRwbHRCOG01bGZVaGh5MnNwS1cxdmFXRkJxNDdRL3hGNTFI?=
 =?utf-8?B?UEtzWXhtVzJWZVpGVlFpcnlCYVhXdFJVcElDQ21KbnFyMTE5K2IzdHRJUGtM?=
 =?utf-8?B?WGJ0VFRpaUxCdTNNMVltbXBkSVpTMGNJM1N3Y2dIMzRwZGw1Z0dCUmpUV3JK?=
 =?utf-8?Q?uihDv9ZODeK0jyyf61wiW9D0M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b48edf-bea2-4010-fbf7-08db160e8690
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 02:26:24.5746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2CwJlyV0nZWALGD4Io4A0P2dRZOsOScOkaudUzhMwBK6S00lqZzVP/bt2Ix8G/nAY8PsYl19ynXWZJXfmlKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

SGkgQmVydCwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLiBBcyB3ZSB3aWxsIGNhbiBkcm1fa21z
X2hlbHBlcl9wb2xsX2VuYWJsZSBpbiByZXN1bWUsIHNvIGl0IG1heSBub3QgbWFrZSBzZW5zZSB1
c2luZyBkcm1fa21zX2hlbHBlcl9wb2xsX2ZpbmkgaW4gc3VzcGVuZCwgZnJvbSBjb2RlIHBhaXJp
bmcgcGVyc3BlY3RpdmUuDQoNCkZvciB5b3VyIGNhc2UsIGlzIGl0IHBvc3NpYmxlIHRvIGZpeCB0
aGUgcHJvYmxlbSBieSBsaW1pdGluZyB0aGUgYWNjZXNzIG9mIGRybV9rbXNfaGVscGVyX3BvbGxf
ZGlzYWJsZSB3aXRoIGNoZWNraW5nIG1vZGVfY29uZmlnX2luaXRpYWxpemVkIGluIGFkZXYgc3Ry
dWN0dXJlPyBXZSBjYW4gZ2V0IHJpZCBvZiB0aGUgY29kZSBjaGFuZ2UgaW4gZHJtIGNvcmUgaW4g
dGhpcyB3YXkuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IE9uIEJlaGFsZiBPZiBCZXJ0IEthcndhdHpraQ0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAyNCwg
MjAyMyA0OjUyIEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWQ6IHVzZSBkcm1fa21zX2hlbHBlcl9wb2xsX2ZpbmkgaW4gYW1k
Z3B1X2RldmljZV9zdXNwZW5kIHRvIGF2b2lkIHdhcm5pbmcNCg0KV2hlbiBkcm1fa21zX2hlbHBl
cl9wb2xsX2Rpc2FibGUgaXMgdXNlZCBpbiBhbWRncHVfZGV2aWNlX3N1c3BlbmQgd2l0aG91dCBk
cm1fa21zX2hlbHBlcl9wb2xsX2luaXQgaGF2aW5nIGJlZW4gY2FsbGVkIGl0IGNhdXNlcyBhIHdh
cm5pbmcgaW4gX19mbHVzaF93b3JrOg0KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9hbWQvLS9pc3N1ZXMvMjQxMQ0KVG8gYXZvaWQgdGhpcyBvbmUgY2FuIHVzZSBkcm1fa21zX2hl
bHBlcl9wb2xsX2ZpbmkgaW5zdGVhZDoNClNlbmQgYSBzZWNvbmQgdGltZSBiZWNhdXNlIEV2b2x1
dGlvbiBzZWVtcyB0byBoYXZlIGdhcmJsZWQgdGhlIGZpcnN0IHBhdGNoLiANCg0KRnJvbSA1MWNi
YTNhZTFlOWY1NTdjY2E4ZTM3ZWI0M2I5YjkzMTBkMGQ1MDRkIE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KRnJvbTogQmVydCBLYXJ3YXR6a2kgPHNwYXNzd29sZkB3ZWIuZGU+DQpEYXRlOiBUaHUs
IDE2IEZlYiAyMDIzIDEwOjM0OjExICswMTAwDQpTdWJqZWN0OiBbUEFUQ0hdIFVzZSBkcm1fa21z
X2hlbHBlcl9wb2xsX2ZpbmkgaW5zdGVhZCBvZg0KwqBkcm1fa21zX2hlbHBlcl9wb2xsX2Rpc2Fi
bGUgaW4gYW1kZ3B1X2RldmljZS5jIHRvIGF2b2lkIGEgd2FybmluZyBmcm9tDQrCoF9fZmx1c2hf
d29yay4NCg0KU2lnbmVkLW9mZi1ieTogQmVydCBLYXJ3YXR6a2kgPHNwYXNzd29sZkB3ZWIuZGU+
DQotLS0NCsKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiAr
LQ0KwqBkcml2ZXJzL2dwdS9kcm0vZHJtX3Byb2JlX2hlbHBlci5jwqDCoMKgwqDCoMKgwqDCoCB8
IDcgKysrKy0tLQ0KwqAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYw0KYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCmlu
ZGV4IGIzMjVmNzAzOWUwZS4uZGM5ZTk4NjhhODRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCkBAIC00MTQ1LDcgKzQxNDUsNyBAQCBpbnQgYW1kZ3B1
X2RldmljZV9zdXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgZmJjb24pDQrCoMKg
wqDCoMKgwqDCoMKgaWYgKGFtZGdwdV9hY3BpX3NtYXJ0X3NoaWZ0X3VwZGF0ZShkZXYsIEFNREdQ
VV9TU19ERVZfRDMpKQ0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBEUk1fV0FSTigi
c21hcnQgc2hpZnQgdXBkYXRlIGZhaWxlZFxuIik7DQrCoA0KLcKgwqDCoMKgwqDCoMKgZHJtX2tt
c19oZWxwZXJfcG9sbF9kaXNhYmxlKGRldik7DQorwqDCoMKgwqDCoMKgwqBkcm1fa21zX2hlbHBl
cl9wb2xsX2ZpbmkoZGV2KTsNCsKgDQrCoMKgwqDCoMKgwqDCoMKgaWYgKGZiY29uKQ0KwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcm1fZmJfaGVscGVyX3NldF9zdXNwZW5kX3VubG9j
a2VkKGFkZXZfdG9fZHJtKGFkZXYpLQ0KPiBmYl9oZWxwZXIsIHRydWUpOw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9kcm1fcHJvYmVfaGVscGVyLmMNCmIvZHJpdmVycy9ncHUvZHJtL2Ry
bV9wcm9iZV9oZWxwZXIuYw0KaW5kZXggODEyN2JlMTM0YzM5Li4xMDVkMDBkNWViZjMgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3Byb2JlX2hlbHBlci5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vZHJtX3Byb2JlX2hlbHBlci5jDQpAQCAtODQyLDkgKzg0MiwxMCBAQCBFWFBPUlRf
U1lNQk9MKGRybV9rbXNfaGVscGVyX2lzX3BvbGxfd29ya2VyKTsNCsKgICoNCsKgICogVGhpcyBm
dW5jdGlvbiBkaXNhYmxlcyB0aGUgb3V0cHV0IHBvbGxpbmcgd29yay4NCsKgICoNCi0gKiBEcml2
ZXJzIGNhbiBjYWxsIHRoaXMgaGVscGVyIGZyb20gdGhlaXIgZGV2aWNlIHN1c3BlbmQgaW1wbGVt
ZW50YXRpb24uIEl0IGlzDQotICogbm90IGFuIGVycm9yIHRvIGNhbGwgdGhpcyBldmVuIHdoZW4g
b3V0cHV0IHBvbGxpbmcgaXNuJ3QgZW5hYmxlZCBvciBhbHJlYWR5DQotICogZGlzYWJsZWQuIFBv
bGxpbmcgaXMgcmUtZW5hYmxlZCBieSBjYWxsaW5nIGRybV9rbXNfaGVscGVyX3BvbGxfZW5hYmxl
KCkuDQorICogRHJpdmVycyBjYW4gY2FsbCB0aGlzIGhlbHBlciBmcm9tIHRoZWlyIGRldmljZSBz
dXNwZW5kDQppbXBsZW1lbnRhdGlvbi4gSWYgaXQNCisgKiBpcyBub3Qga25vd24gaWYgZHJtX2tt
c19oZWxwZXJfcG9sbF9pbml0IGhhcyBiZWVuIGNhbGxlZCBiZWZvcmUgdGhlDQpkcml2ZXINCisg
KiBzaG91bGQgdXNlIGRybV9rbXNfaGVscGVyX3BvbGxfZmluaV9pbnN0ZWFkLg0KKyAqIFBvbGxp
bmcgaXMgcmUtZW5hYmxlZCBieSBjYWxsaW5nIGRybV9rbXNfaGVscGVyX3BvbGxfZW5hYmxlKCku
DQrCoCAqDQrCoCAqIE5vdGUgdGhhdCBjYWxscyB0byBlbmFibGUgYW5kIGRpc2FibGUgcG9sbGlu
ZyBtdXN0IGJlIHN0cmljdGx5IG9yZGVyZWQsIHdoaWNoDQrCoCAqIGlzIGF1dG9tYXRpY2FsbHkg
dGhlIGNhc2Ugd2hlbiB0aGV5J3JlIG9ubHkgY2FsbCBmcm9tIHN1c3BlbmQvcmVzdW1lDQoNCg0K
DQo=
