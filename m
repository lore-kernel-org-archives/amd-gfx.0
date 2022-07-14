Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22B6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 03:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735F792450;
	Thu, 14 Jul 2022 03:15:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECC791573
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHsIEqiWTMPqGsTKRPLH30AJhBf8g6TBCQG6J6FY+5pFA0L53jxYgJxu8cu1fbsYkWFQ1n0RxXYeccGJWrCKFN5ypfGvgGrF6nBnMoPqoAvS3vC9PDU2Sv+5z/dkeFbjnrDh5CYDrFT6jvrJtLrpy2TzxdQCwTOBS3h9mz7TakmJ48/zQwq7UflVe978N/cLaxpoEOLgBbRgp3bdVJegnTW5ejDGz598c3+NYQAyE4XtXyQ8FuGrB/XWHOO+LsJjMP/2IkrfGllL7QGfn38bPF4eDgj8XVvhg0B0XGBQxoSzFQ7SaxrGFwjZMs9MKUGfphj0SOCTOcu8zM9ddEARBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOoVA5gMvu7J5EBmVu/XxpuK7S2H8D6Z135zXO11//4=;
 b=UJZbJ0tYcQDIrFp3Gx7YaK7JghgUCVSd5710/FdSGmrmvQjE3aemboT1yt69bvSTG2uV7sKtySywWrN63E7yTO6UhFgkZObmN6UzyT56X16GcWoBfnhdMfLJskC5XPdEpgj9QdTEMIoppr5Sex0HZrLoMYinWvRLwHbJEDdsph7G+Mf09cx1jhyXO+8MoXxz+a+8bIOs2ide86HDuf3gKobd0HBFIWHwiO8ammKRLaHDQXd4fghtkZrAd80CjGm8Kb6ALdC4u+qMBgQ2bohOgHj6ituSX93bT9FIr7k+uYpXQqIlAk+AtKXqIBsoJpM60B3eexk/2t2nHipgSJaalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOoVA5gMvu7J5EBmVu/XxpuK7S2H8D6Z135zXO11//4=;
 b=VPHUdRVWh0ZGcMDbhJXX/ZDZKvBcu+u8F6EVR3aki5f+/pBQ609T2rL0wHfYXcO/LWBPW3tUuUkKr/DyOccr2iUKPg0m4ee8HOYEpiOkhyioKUtTa+2rvjUgkr3nrB/rOjLaNFRP8E+JyixbrTt0lj+nPNDcCa3O2/YZXcfxBxU=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BYAPR12MB2967.namprd12.prod.outlook.com (2603:10b6:a03:d5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 03:15:07 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::d43e:54f8:f7ca:f94f]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::d43e:54f8:f7ca:f94f%4]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 03:15:07 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Index: AQHYlmcZeWo9gpDXJUqkKZdiV7L/ca18bl4AgADD3DA=
Date: Thu, 14 Jul 2022 03:15:07 +0000
Message-ID: <BL0PR12MB2465F64BAEAED76DD32EE204F1889@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220713031704.2004-1-guchun.chen@amd.com>
 <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
In-Reply-To: <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f39b3439-f319-42b0-1ed5-08da65470dfa
x-ms-traffictypediagnostic: BYAPR12MB2967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5GyPtrzS+eyS5qNnLERkBh6CgpOLKMw2i43XL8VDVQBnUQwUcTMA4dozxDS3ktwPmzIA7SOn+BQFg1JtJK88a0N3RlSq3IfywBdLNkTtoTTg3qhwEVZKu/Ny9pyHAfc0EXsfRqDEzpUtC/I/Cehe5dK0Ym0LjtDwGPVhC4ro572B6Ch5rlW100ODJB+N7mUCGNLMp+KL2a9FX6LWxB1Q7kC6QzoZTwJw82yqoLHTYSaxQNhMNU1zTgoTiNn7WJBYt6mzBxnoDBS5R1v+ICq5g51h+aSnkHOmu/bvkE0S9DwLwxlMpdMiO+9exWU2AA1ekxG+oA48XSG3gEBgWydYkvf9KawAzZ/+LD2Vpb+ZyADWKMySjtE8dJUWMAu+vCHmRP+SAAj8gcZm/NUdz/WS0rPilxFuccYH68VlMa8jGQ/Y0tJdHp95F3MdL2uC6TdkMLGh4rIAzVGTV9kPNgH5+U3LfrHuVvON+mP2rXaN/qwusxQrJlYCk8A6Rzh1rRor1WfKyiPxVJhlfXGz4onGo9GXd6tjbDgjdhPIY+Whfi3EVaNXoIlAnNgkbIuPgsGAq7YHrl/GxwGW0H3LUQIIuL7kPlxWLta+ZnTv6Y1bpxUv1dlYUNT2rjE0boSv8uT4kXZ636FTMoRnyamDR05W+B8vAmRURj/VreK+OkbX8RHxHIlWoskW8ms+PqQybqeR9aBZ/YXjGagW5WBUJzwxexuWONLNmGh43G6OFqd5lOOs9aHxaLZ49llZH33xBTYoyrM034qH75jND50X+QzTwehw8lN4qJYU9keXUDnJGkWzuMIgGuGJEbcUU05yoxt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(5660300002)(122000001)(38100700002)(316002)(66556008)(52536014)(55016003)(33656002)(8936002)(83380400001)(8676002)(66476007)(4326008)(71200400001)(86362001)(6506007)(9686003)(66946007)(76116006)(7696005)(2906002)(54906003)(66446008)(26005)(38070700005)(64756008)(53546011)(186003)(41300700001)(478600001)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djBGK3VBSkFMYjYydWpTd2Y5bGNDdlY5VFNnYm9iWVFzWXloak9mSm9WeDEr?=
 =?utf-8?B?Ui9ra0xXZmZHUWZBTmU1bFZGU3I2VlBSNWtLQmFqRVZMQS8xTHpYMjUxdXdl?=
 =?utf-8?B?cDYzd1RZdG1vRlhaeU1HbWR6UGM4Nm9laWZQRW1HV3BWVklrcWE1RkJMbXVX?=
 =?utf-8?B?dDNyRGpFd3hkc3BvdWxpVlJad2VsbklIbkNLWnRPTThhU3g1aEczNFMzM21Q?=
 =?utf-8?B?RFRxa04wdktoWmlubkM4dXVXdGZYOURtMGFtQ2NjTjNoMFZ4ak1mNFR6UjdY?=
 =?utf-8?B?aFF0RWxXODZEWVlndEo1c1hWQ251MXI3SXMwK254Y0R4YWJUQkxrL0V5dmJS?=
 =?utf-8?B?TFZkYnlVc0I1aDVvUHI3WW5icXdydEVTTVFKSmMwby8xT3E5Wkd3UmZ2UHpS?=
 =?utf-8?B?NnU3bkFMY1NqMWNnazFLY3hrUzJQYWFBcmwvcXpNRjFTYXh2bFRJOVFVTzhr?=
 =?utf-8?B?Q2NxeGs2M1U1MWdDMmxMdHV4djJCbGM5YXhTQzNlK1FqdzhZNGNRWnRWQmV3?=
 =?utf-8?B?KzEwZ2NES2t4Y1ZMU1ZKTWVDK1FPWlVRQTEvOVZHQ1Y5UHRjT0VNN2trdTlT?=
 =?utf-8?B?RXo2eHJmT08xaHU2L3lHVkFKNkFNSm1CK24yRXZqOWQyUld4S0FWU2lFV082?=
 =?utf-8?B?QWFtYUR1TjFFVm1jWm9jSnB1ZXJFejIzZkFUYmViZDhSU0NBQmNnWnY3SUNT?=
 =?utf-8?B?K050b0ZERTRqWWZsbFl2NEhMcHVWdW02M0xXUnJicTBZMVZFNnl5VUREb3RW?=
 =?utf-8?B?Y002QVloUG82UGx3RDBxZkRMcmppYzNBL29tV25OMGRvSTRYWXhHeTNFRHJH?=
 =?utf-8?B?SHphZnkva0Z6RmNiUU9UVUM3NjNzdG80bjlVaHdZYm9DNE1lMCs4NFdtcS9t?=
 =?utf-8?B?MFlTSTNOazNzZEljd2wrRGEyZ3FYMWQwVkhWMWlsRGZzd1FLQmtQeTNXTU5y?=
 =?utf-8?B?WUxSbXl3UFlEVCsvMEYvam5lVzlJU2NpeWZiZGpxL3ltNUVxYkxYdFYvb2FO?=
 =?utf-8?B?S2MzcG90WEJMSGRyd2FtczhWWVdUM0MvaE9iQUQxT3U3dTArNnNwWXlrem9i?=
 =?utf-8?B?bkJZOWpVOXJDS2s1NzVXOTJCZzcyQ2tLTktiSTJCK00zRHdWQXNYaC85WHA2?=
 =?utf-8?B?NHkzZkpEang5Sk03cnpISmE1Vk1RQkJRSUJxUFl4Zkd6ZDQycmJJQVZsMVc4?=
 =?utf-8?B?M2Y3ajM4d210dk1RRmNNa0prcUI0UUY0YldNeGpNT3pDYWJPTjloZ05kMmlu?=
 =?utf-8?B?THk1Slk0R3FQVXg3NExnMnVBbzFpKzRqRVZBemlTd3ZNUHUzU20rQitBL1dq?=
 =?utf-8?B?b2QyMlQ0eUlmRTVMa3dtRWsxcy94U3N4c2E2ejAxanJ4MDVoQmVuTXFuK0tY?=
 =?utf-8?B?VEF2aTdDMC81Q1czeVFQbC9JOUxtRFN5cFNwRVpDRGRxcHUwVEpVTEZWK0pG?=
 =?utf-8?B?ay80cERmMDc4WTExeEpubVI5QzJwdVovcjBKd2tyWlhSdXcydE5IaGhMOXA2?=
 =?utf-8?B?b1NvTFJ5aWttQ0MwVDRRRUlOb3RieHJNVDRKalEvNEw4NTg4NDJRNDkzMVpu?=
 =?utf-8?B?YnAwOG1xbEc3RVVnWU5YekdRdFAvSnR4Q2FIQzdyUmZWcjEwand6ZmgxaDQw?=
 =?utf-8?B?VWQ4ZFQ0bkRCOWhQTHEwenIwcUxSa0E2Q1hTYUJqQ01qYm1LYmttL1hGS3cy?=
 =?utf-8?B?WW5CcThWUU1RZDFBc2tEcng3T0xtTU9qelFNdnd0Y0RLZ0U0dHh2ZkVkNXFD?=
 =?utf-8?B?bWJxZTY3MmhsZ0VWbmdYanVVNEJQV0RmUDFmWkVCeTd2dTJscE4wU0U1aWtE?=
 =?utf-8?B?SmRGV3NYYjFmV1JlLytta3FqeHJpZTJKbXduTnB0VmxlSEtRdlZQZjBQY3Vn?=
 =?utf-8?B?ZXZKbmZkdlJTT0E1VGU5TGlmeHJKR2IyR21IWENXT0hDOVVXRWZTamZvTXU0?=
 =?utf-8?B?YThDVlRzZFRxb2Q1L0lxSFFCR1lpd29reHF2ci9SNXRNOUNWWXBLVHBXQ1hu?=
 =?utf-8?B?VW5EU3Vadk1IL0cwa0VyQWwxZ3VDV2hpc1k2Z2d3UDlORUc2NFd4TVByMUhU?=
 =?utf-8?B?em84cGU4T3JtUDNaOTdRbWtVV2p4RmVkaGdhQmJRa1hhaGpQcFBGbDN1VXhQ?=
 =?utf-8?Q?P5IgikSGu5SK2lAMvV6OzHrR1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39b3439-f319-42b0-1ed5-08da65470dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 03:15:07.7456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72DBqJlog0jIU1VagIvSGKnPgxWJY/t0CYgEajt5RC+spabmvQ6cb5Q/a1ox/rFnpwAvv0b2iUvRj4Byi2mBvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2967
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, 
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmU6IEkgdGhpbmsgdGhpcyB3b3VsZCBiZSBiZXR0ZXIgYXM6DQppZiAoYWRldi0+aW5fcnVucG0g
JiYgKGFkZXYtPnBtLnJwbV9tb2RlICE9IEFNREdQVV9SVU5QTV9CT0NPKSkgb3Igc29tZXRoaW5n
IGxpa2UgdGhhdC4NCg0KWWVzLCBwYXRjaCAyIGluIHRoaXMgc2VyaWVzIGFkZHJlc3NlcyBpdC4g
UGF0Y2ggMSBpbnRlbmRzIHRvIGZpeCBTTVUgcmVsb2FkaW5nLCB3aGlsZSBwYXRjaCAyIGZvY3Vz
IG9uIGZpeGluZyByYWNlIGlzc3VlIHdoZW4gZ2V0dGluZyBmZWF0dXJlIG1hc2sgZHVyaW5nIHJ1
bnRpbWUgY3ljbGUuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6
IFdlZG5lc2RheSwgSnVseSAxMywgMjAyMiAxMTozMSBQTQ0KVG86IENoZW4sIEd1Y2h1biA8R3Vj
aHVuLkNoZW5AYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+OyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IEZlbmcs
IEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJd
IGRybS9hbWRncHU6IHNraXAgU01VIEZXIHJlbG9hZGluZyBpbiBydW5wbSBCQUNPIGNhc2UgKHYy
KQ0KDQpPbiBUdWUsIEp1bCAxMiwgMjAyMiBhdCAxMToxOCBQTSBHdWNodW4gQ2hlbiA8Z3VjaHVu
LmNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFNNVSBpcyBhbHdheXMgYWxpdmUsIHNvIGl0J3Mg
ZmluZSB0byBza2lwIFNNVSBGVyByZWxvYWRpbmcgd2hlbiBydW5wbSANCj4gcmVzdW1lZCBmcm9t
IEJBQ08sIHRoaXMgY2FuIGF2b2lkIHNvbWUgcmFjZSBpc3N1ZXMgd2hlbiByZXN1bWluZyBTTVUg
DQo+IEZXLg0KPg0KPiB2MjogRXhjbHVkZSBib2NvIGNhc2UgaWYgYW4gQVNJQyBzdXBwb3J0cyBi
b3RoIGJvY28gYW5kIGJhY28NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVh
bkBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMg
fCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+IGluZGV4IGU5NDExYzI4
ZDg4Yi4uZGU1OWRjMDUxMzQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jDQo+IEBAIC0yMzQ4LDYgKzIzNDgsMTQgQEAgc3RhdGljIGludCBwc3BfbG9hZF9z
bXVfZncoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICZhZGV2LT5maXJtd2FyZS51Y29kZVtBTURHUFVfVUNPREVfSURfU01DXTsNCj4gICAgICAgICBz
dHJ1Y3QgYW1kZ3B1X3JhcyAqcmFzID0gcHNwLT5yYXNfY29udGV4dC5yYXM7DQo+DQo+ICsgICAg
ICAgLyogU2tpcCBTTVUgRlcgcmVsb2FkaW5nIGluIGNhc2Ugb2YgdXNpbmcgQkFDTyBmb3IgcnVu
cG0gb25seSwNCj4gKyAgICAgICAgKiBhcyBTTVUgaXMgYWx3YXlzIGFsaXZlLg0KPiArICAgICAg
ICAqLw0KPiArICAgICAgIGlmIChhZGV2LT5pbl9ydW5wbSAmJg0KPiArICAgICAgICAgICAhYW1k
Z3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGFkZXZfdG9fZHJtKGFkZXYpKSAmJg0KPiArICAgICAg
ICAgICBhbWRncHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oYWRldl90b19kcm0oYWRldikpKQ0KDQpJ
IHRoaW5rIHRoaXMgd291bGQgYmUgYmV0dGVyIGFzOg0KaWYgKGFkZXYtPmluX3J1bnBtICYmIChh
ZGV2LT5wbS5ycG1fbW9kZSAhPSBBTURHUFVfUlVOUE1fQk9DTykpIG9yIHNvbWV0aGluZyBsaWtl
IHRoYXQuDQoNCkFsZXgNCg0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gICAg
ICAgICBpZiAoIXVjb2RlLT5mdyB8fCBhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkNCj4gICAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPiAtLQ0KPiAyLjE3LjENCj4NCg==
