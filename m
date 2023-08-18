Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04123C678DC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0376410E4F4;
	Fri, 18 Aug 2023 11:24:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0962B10E4F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IInVYCV/Hn7O4AIjvyegSX9MJWpyQ1KsJizFTQ7JKWT7Q2EmFgq5iriBECqpFDjZGBmpEwV0mkgcpZu8ST5+CLsOeqrlknypLoUFEni8bnHRj5hTwpLe1CRjEI5B3sKtAQm/D0U3vyYL9dSAuxO5+WcLD7Bugb1VF9kG6fDbTIiXIbuY/sAq/HGczxIfOXpOER+malyTbgBHPVRi0CRk1QnFUCR8cFRedNtTxTHZ9a5FpNTpSquQVaT7FrnD+Aa9ZKvOyEF7iiWMaWAegxjQsXkwypNEnzu4nraG9o1VDxGwMculVDMagf7gtiV8idF0zbZ+bEla2Ubs1O4QyNZYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N8yLmglc/c/XCZLuY2WoH8pjEeaY9vmeXlN6BjNo+0=;
 b=aNR5FZtjVEKMlukYvq6N/XdKwyzyYmqYPGNNG801WYhr7WKaqDfN1RJLWmbosvByd/yelRVysT1hXFaYa/3x1nrfpoj4LxoU+ZmjnJfSZmLmFi2GsyolceTpKkjssQ+DYBbAG3xYUDBKyruNIbfgbW6FITvrzePQPHboHWwqr/EtANeUkGeXdZWozi6IxLQGn9O0wxbkVFtBwxr53drcWHiwBEf58mV34ZfPbYBNA2JqIhjAABXPvCYqyqer82UvvuTmXWcet6egWHLX3g7/IyDPmifOS42jIg016YZx3vhsm5ivsJ+biLp9gptbACz5Ap2kAYJNuG5tpO0WtVr1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N8yLmglc/c/XCZLuY2WoH8pjEeaY9vmeXlN6BjNo+0=;
 b=HTV/EInREhxlR+iG9/IAbJQ536ZmkVe6FP3EydKV3ECscyP0Tj70x/EmbB/4ne9Rc8Hdh2xw/S8gJrFyYfbzERqNT0yHMPmZbcxoGBxksMjW41rz2nU/IHqcCCrHGSDgEclJcnKBQPeuvIXfCapd31AJV49lKhWsRaLGNVu2qZQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:24:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ffd8:4c61:6807:9ec4%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:24:10 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Thread-Topic: [PATCH v2] drm/amd/pm: Fix critical temp unit of SMU v13.0.6
Thread-Index: AQHZ0cNTVgCXm8Bo3kOWhWBD5qEPda/v6Tcr
Date: Fri, 18 Aug 2023 11:24:10 +0000
Message-ID: <PH7PR12MB59976A6294FCED82B853BAAA821BA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230818110055.1231261-1-asad.kamal@amd.com>
In-Reply-To: <20230818110055.1231261-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-18T11:23:10.5593883Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BY5PR12MB4035:EE_
x-ms-office365-filtering-correlation-id: d85ff2c4-c373-463a-9a85-08db9fdda508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbMQHro/onC6LXOqdKtzf3iw57V8f4/FdtiwFZAR1NqGKzdKzClSyG7BXVhJcLp8QyeUh5bX1AGRhc+u3PVnJJNogEaLCIfqbDd4LRdQVmDCgDv/EV/cwcht3oladcCYEl5Fs06Q31quJXZ5sp2rdcRRqUjM8tnXsZ1jncRr9d/YQSAdugswbgy3GMpeXpSZ8c6fUPzzOQhxgZTt909u+aibeyaYDS9rLD1G6rtlBCao8JZkrUy+A390Z0GSl+gTweGOExBY6FYma3wY2/L8+qJhyyKcdhR6BVTqbKS6GUIU0w0zzlEDgKmKdd4Bmk3Mg2griJCmLmQ2aLffRbxnJZvgiDcopVFEJHlF1UOxwUrN89VljBVRVN8uauTxipnKcBAebsrgKxvddm96+uHX/Iaxx3LI0o+3OvF+FZa7gkDBmgKq2lIJ1PgVI6vPcw64aWaJ1Yhw23FmPa8bFJ0KuH/yHEalYZ2ABSgeMpGJEWMJaSb6z+F+Vf6dttzfiUNdrw8zdF103uqL8riLhDYajYW2HRcIo73+0Zy0wWuOfCua88h1+ed8/zDgFiXiaRBqEZTgGug5+BnQ4Orqfhgm969qU4X6f90mpRJgbemT4JGX4BHJiB8X7U0Z214a96RW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(186009)(1800799009)(451199024)(86362001)(33656002)(122000001)(55016003)(64756008)(66946007)(54906003)(66446008)(66476007)(316002)(66556008)(478600001)(110136005)(76116006)(41300700001)(38100700002)(38070700005)(71200400001)(6506007)(7696005)(9686003)(8676002)(52536014)(8936002)(5660300002)(4326008)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VzFYdGJ0bkJoNEozNWRabDREbk9QMnZBbFdiNStsSTNDdTZscUFBU2pLdnZY?=
 =?gb2312?B?T3QwSkFoNmFtQWdZUXNuRU5EM2Jla0QxU1VRcFRRMXBibmhIdVVwWlRBKzdH?=
 =?gb2312?B?R1daTnNkRHFOVGdiajhSRWxQSWlpdXVUbEowTnZ6ZmF1RjVyTDE1cTdIeU5o?=
 =?gb2312?B?aFpXYXdJNWx2Ym4wNjllVUpUTlZJc3Nqd3dWV1BSanZzb3FNN1U0M0hTR0pG?=
 =?gb2312?B?OEVNZVJWaTV4NERBWk9LLytBTU1MUGVJelJmejdDNDFEcXhkSHZiNG1CYnBD?=
 =?gb2312?B?WG8yOWNlSE4rOWdPWnVOWWFDQUxlMTdySlhoUFoyelFMenY2QU5Dam5SQUN5?=
 =?gb2312?B?WUpiVnd6Z204cVR1aGY2Z2g1ZGNIa1VZbTNrREltNHZ3SjhuSm03M21paUNY?=
 =?gb2312?B?RlptTXR1WFRYekwxMHB5TThIMHZsQXo1Zm45U0RtejJEMWNaTjVYaCtPSkRu?=
 =?gb2312?B?aXJrQTR6aHdDQmlrVitMNzBiUkx3bHgzT29RekNpUnRrRzlrcmJzTk9sd3Vw?=
 =?gb2312?B?Z3B6VHYxeXlGQ3FBbnlBZTFFTm95OWxhK0ppNUUvUjB0TmJzR096amYwcmt1?=
 =?gb2312?B?TkpWd3k1MGJzZFRkN1RSbFFZREVTNVhDajRnVEQ3ZkNybTZ6VjhkQ0ZHYmJV?=
 =?gb2312?B?d1h1UlZqVHZTSE4zM3l3VEdvVW85OWhjN1NIUjJtd1Eza3dmSGNaWUE2bFV3?=
 =?gb2312?B?QnJrR0xqeW5rT1k1WHg0VThzNGdJSFRybFczMTVtSDhSVDlGZHlGZVErajN6?=
 =?gb2312?B?WmFWMFJ4a2xIWHZMYk11cWcxSHhMb1lYZ3U5KzBkSDU2ZWZKRWdYWlNFdzFU?=
 =?gb2312?B?cEQxK090dndQTXpRV2cyTGVtVGdCRUZ1S2VYMWIxM3FvRDk4SmFtcjJ1SjdV?=
 =?gb2312?B?Z0VLV0hNbFRwbTIwM3VLaWtoR0YySC93aFZLWHFzWDZPd3ErNEhsSDZ3bisr?=
 =?gb2312?B?OVRuVzJpUXBtZVVGcW9ra3RQRzVxajR6cFY0QVJ5Szh3OUxmNUJRbHhnRldq?=
 =?gb2312?B?SFBNZm5ZSVN5alJWYytHYU4zUXRuTVRVY3VMMC9jUWxTeGc0czh4azBHT2RB?=
 =?gb2312?B?NW9QTzlPNUszZitmY2h0MjhDdDJYTDFZd2MvMm5SLzZXNmZ5aTBGTGdSMXp5?=
 =?gb2312?B?dHhzOS9jcXdtbXJHMU5iREZzRlZOQWJiMHBwdFBrbjhhS1dnUXhGaWQ1L0k2?=
 =?gb2312?B?d2h3eTNoblpmUStnQ2dnZXRnL1RzM1pvci9NTFpHOVdYSC9mTTBLbVRsTm4r?=
 =?gb2312?B?eVJFNVdkZWYwZ0R2ZldmTXFtL2NBMFJzZFFQSlZ0N1ZrUnJHenRRZmF2QndX?=
 =?gb2312?B?NWQzM3lpa01jSU9BQjFsTVlSSVVpcitwWWFLOCtOWDJubklxMVdjdzEvOVgy?=
 =?gb2312?B?K2xLV3B2dENYY1QzU2tXWVhxM3piODNEZmx2RmlHbVNGaWJGUGxDZy9RV044?=
 =?gb2312?B?YzZ6dHdEUWd4VHRBL0trZ2RTZXUrVDhSU2pjdWYvWGc2akdCMFhndmhZYVJi?=
 =?gb2312?B?Y3B6R1plV0puYlozSG1GQjdEWEQzVzFSZUJoTmhXdDJseUhXT2lpZFgwZEZk?=
 =?gb2312?B?b1E1V2oycE8yay96emlYb1Nsb2srSU5IZHorQTVobEh5c3M1MFhtdnE5QzJF?=
 =?gb2312?B?QTluNjdlZHhjdlBnckh5RFZ4YmlVMmtjTmZnZ2ZjS2JEVkhSQTFPUUd6TmYr?=
 =?gb2312?B?dVE0MDYrZnNIV3U0bEY4TDAva2gzYWxXeTBtb2I5UDQxbkZDYWNKdjFWcFFL?=
 =?gb2312?B?cTR4c3RYL3p4R3NGRExzWmM0d0pLOXRZaUh1NFpXVjJnUUx6MlJNTXFhMXpu?=
 =?gb2312?B?ZFFJOEJZanE5cDVVZStSV3hMeXRaTUtZZTBxSUR6bU41Y2l6ekwrWC9zUU00?=
 =?gb2312?B?dFc4eUZxWlBlRDNzSG5NVWVlRkpsbWdPQXk4MXRYRGhyS2pEQms3bWpodU5G?=
 =?gb2312?B?aHZGeXpzNFpMTGVpSURIaXNzcS9NRjE2Vk9yUURacnpBZUdUcmFzMVJrUGZE?=
 =?gb2312?B?akxPUWk2cDVoTzJDbVM0OTRxTGpySEtmTitBTk1MY0ExT1IzMlhKWW9EbW4v?=
 =?gb2312?B?NERnZVp2alhSUXBRUG9zM2U3K0trWGlLSHRuNm0rTDdpeUJqZDFJTTJLUEx2?=
 =?gb2312?B?VEJUT0xHMXBIM3p6SWdGejhlenRIUGtVd2NzQlRocFQwZCtMaTNoNzJCN2JX?=
 =?gb2312?Q?s4vOKVnxLHXrixXmSu0AEkbe8fMskUdyaC98QbVzpKME?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB59976A6294FCED82B853BAAA821BAPH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85ff2c4-c373-463a-9a85-08db9fdda508
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:24:10.7921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jf2SiHjFrCvSEC8YsXtM33FqvCF4AULT/tc7HuIdNm8rWHTGdlAhFwpN5EY8VZyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB59976A6294FCED82B853BAAA821BAPH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBZYW5nIFdh
bmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+DQoNCkJlc3QgUmVnYXJkcywNCktldmluDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBLYW1hbCwgQXNhZCA8QXNhZC5L
YW1hbEBhbWQuY29tPg0Kt6LLzcqxvOQ6INDHxtrO5SwgsMvUwiAxOCwgMjAyMyAxOTowMQ0KytW8
/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCrOt
y806IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBaaGFuZywgTW9ycmlzIDxTaGl3
dS5aaGFuZ0BhbWQuY29tPjsgS2FtYWwsIEFzYWQgPEFzYWQuS2FtYWxAYW1kLmNvbT47IE1hLCBM
ZSA8TGUuTWFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQrW98ziOiBbUEFUQ0ggdjJdIGRybS9hbWQvcG06IEZpeCBjcml0aWNhbCB0ZW1wIHVuaXQgb2Yg
U01VIHYxMy4wLjYNCg0KQ3JpdGljYWwgVGVtcGVyYXR1cmUgbmVlZHMgdG8gYmUgcmVwb3J0ZWQg
aW4NCm1pbGxpZGVncmVlIENlbHNpdXMuDQoNClNpZ25lZC1vZmYtYnk6IEFzYWQgS2FtYWwgPGFz
YWQua2FtYWxAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTMvc211X3YxM18wXzZfcHB0LmMgfCA5ICsrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KaW5kZXggN2Q4YWY5YjMwOWI3
Li5kM2I1NzhlNmJjMmEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jDQpAQCAtMjA4Niw3ICsyMDg2LDcgQEAgc3RhdGlj
IGludCBzbXVfdjEzXzBfNl9nZXRfdGhlcm1hbF90ZW1wZXJhdHVyZV9yYW5nZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBzbXVfdGVtcGVyYXR1cmVfcmFuZ2UgKnJhbmdlKQ0KIHsNCiAg
ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KLSAgICAgICB1
MzIgYWlkX3RlbXAsIHhjZF90ZW1wOw0KKyAgICAgICB1MzIgYWlkX3RlbXAsIHhjZF90ZW1wLCBt
ZW1fdGVtcDsNCiAgICAgICAgIHVpbnQzMl90IHNtdV92ZXJzaW9uOw0KICAgICAgICAgdTMyIGNj
ZF90ZW1wID0gMDsNCiAgICAgICAgIGludCByZXQ7DQpAQCAtMjExOSwxMyArMjExOSwxNCBAQCBz
dGF0aWMgaW50IHNtdV92MTNfMF82X2dldF90aGVybWFsX3RlbXBlcmF0dXJlX3JhbmdlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LA0KICAgICAgICAgaWYgKHJldCkNCiAgICAgICAgICAgICAgICAg
Z290byBmYWlsZWQ7DQoNCi0gICAgICAgcmFuZ2UtPmhvdHNwb3RfY3JpdF9tYXggPSBtYXgzKGFp
ZF90ZW1wLCB4Y2RfdGVtcCwgY2NkX3RlbXApOw0KKyAgICAgICByYW5nZS0+aG90c3BvdF9jcml0
X21heCA9IG1heDMoYWlkX3RlbXAsIHhjZF90ZW1wLCBjY2RfdGVtcCkgKg0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgU01VX1RFTVBFUkFUVVJFX1VOSVRTX1BFUl9DRU5U
SUdSQURFUzsNCiAgICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnX3dpdGhfcGFyYW0o
c211LCBTTVVfTVNHX0dldENURkxpbWl0LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBQU01DX0hCTV9USE1fVFlQRSwgJnJhbmdlLT5tZW1fY3JpdF9tYXgp
Ow0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQU01DX0hC
TV9USE1fVFlQRSwgJm1lbV90ZW1wKTsNCiAgICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAg
ICAgIGdvdG8gZmFpbGVkOw0KDQotICAgICAgIHJldHVybiAwOw0KKyAgICAgICByYW5nZS0+bWVt
X2NyaXRfbWF4ID0gbWVtX3RlbXAgKiBTTVVfVEVNUEVSQVRVUkVfVU5JVFNfUEVSX0NFTlRJR1JB
REVTOw0KIGZhaWxlZDoNCiAgICAgICAgIHJldHVybiByZXQ7DQogfQ0KLS0NCjIuMzQuMQ0KDQo=

--_000_PH7PR12MB59976A6294FCED82B853BAAA821BAPH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div=
>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
<div dir=3D"ltr"><span id=3D"ms-outlook-ios-cursor"></span></div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>=B7=A2=BC=FE=C8=CB:</b> Kamal, Asad &lt;Asad.Kamal@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> =D0=C7=C6=DA=CE=E5, =B0=CB=D4=C2 18, 2023 =
19:01<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>=B3=AD=CB=CD:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Morris =
&lt;Shiwu.Zhang@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Ma, Le=
 &lt;Le.Ma@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH v2] drm/amd/pm: Fix critical temp unit of SMU v=
13.0.6
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Critical Temperature needs to be reported in<br>
millidegree Celsius.<br>
<br>
Signed-off-by: Asad Kamal &lt;asad.kamal@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 +++++----<br=
>
&nbsp;1 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 7d8af9b309b7..d3b578e6bc2a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -2086,7 +2086,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct smu_temperature_range *range)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 aid_temp, xcd_temp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 aid_temp, xcd_temp, mem_temp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ccd_temp =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -2119,13 +2119,14 @@ static int smu_v13_0_6_get_thermal_temperature_rang=
e(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D max3(a=
id_temp, xcd_temp, ccd_temp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D max3(a=
id_temp, xcd_temp, ccd_temp) *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
MU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_m=
sg_with_param(smu, SMU_MSG_GetCTFLimit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_HBM_THM_TYPE, &amp;range-&gt=
;mem_crit_max);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_HBM_THM_TYPE, &amp;mem_temp)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D mem_temp *=
 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;failed:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB59976A6294FCED82B853BAAA821BAPH7PR12MB5997namp_--
