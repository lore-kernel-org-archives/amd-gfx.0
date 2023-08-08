Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DADC001DF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 10:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF92210E008;
	Tue,  8 Aug 2023 10:26:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735410E008
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 10:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H42zlZegP6vcUp0ztVae49S21059OzxXGXssdZKc+f5iQ+bLavB8gj+cupGkIpLELQwrMUPdgpotnNRNKvOQcYek91vsF2GMdcapwhRQmq5BEWA6HGK1ZOSpiFkxRS+QZPc6r5JKiJRIQYdSrgz6dxkjBH93zx7YT3jy1JL0IVHiAOlTSWgaFm2cBr8p9azsOmTQ+ZJRb0kHwT0pkpXaSiDtsAvk6Fd80VK01aLECktqKmJFHtuLiy2vhM3hd5Wwit3HqQnZ/NsTpo4MMUQbhP+JI2aniHjDWXh51jZaNmSEVZREsBq+dLdPo8nx4evYaisACduNzFgewSuLeueq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmuFno7z3378QDWkC2Q9b3tSZ3A13vbV5jah+AT3ANE=;
 b=WMDk0Ql22pl0mvZ1WGOWtfj5FMUr19PPAidfVZ1HeMXdJRYLsZHAYZTH+fdIWZ8PVEOkzCgGSRwYt/SG/FlYSmg5TZiOrbRKuBCb3dPs4nxOny35bB4amznczk7dzKC5E3u8ASw5kwtB1Tb+kT7143ngCPI6LgOL4i6GSE16tTwCxrjLXc1MehziIUHeyKXKMj96cNxmKc93immK93Dn9mvKcVTPuPdRdv4WblMNQ9wSTTac6kFtZfaylR1hsZEofdKDOtLhNLYH/EOCWrnceJGub5wjPUZUZUFu4aqHyfdkQs7V+Yu1xzCuedPKllWa59virCZwcL7rc8zv1YCIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmuFno7z3378QDWkC2Q9b3tSZ3A13vbV5jah+AT3ANE=;
 b=UniV4lS4pZxbewlx4xwMzab+LIjBNlFuJYJW2dEasTLlzMa7MZ4pJlLlKW2K9Yrl2GqhlAOv3B7hPWHhxOBh42aIMB/dPMvDmCtH8FLBnzgtbDmsD188HWWoFfMUBW3i6hXmfzWRJ0moRF03V9EVofc8DGHogjKztg8R/bTuGjk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 10:26:17 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::c377:a09d:c286:5835%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:26:17 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan
 on smu13
Thread-Topic: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan
 on smu13
Thread-Index: AQHZyc0xx4HF4TE4zE6EJaBC411Ydq/gLgGAgAACWRA=
Date: Tue, 8 Aug 2023 10:26:17 +0000
Message-ID: <DM4PR12MB516542C45FA8B45093D22C468E0DA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230808075150.227155-1-kenneth.feng@amd.com>
 <16b7e768-dbb6-9e6b-e6a4-80c683a11461@amd.com>
In-Reply-To: <16b7e768-dbb6-9e6b-e6a4-80c683a11461@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ac436aa0-2008-4f52-ba6f-58790a2eee06;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T10:20:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB6851:EE_
x-ms-office365-filtering-correlation-id: e3ba369c-4f01-4f24-ade2-08db97f9e6a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SV6fqNWzIJDeVDTMwy3TXbjPpzS5v77OKHBoREwE37csdIP2gg7w2ki11/JTGl+kbX3nwbhgggsIVNvB+67AcxfxoKkYsATDsRs59/5PyOlnJYGE2F7C3N6cuSYxMcO6/6twzNper21nEWNiKfNJsVif/KfjUwIfqwvsbUsYEkISOB5ZW3vO6P+9WLxqLQocV5gq6GiLZSwR02jdYyxCt/bokVduktdYZtRcbe5AX78rDdpfc+kZTFxVvNQQCdEuZmU1V2nWXc4nVgiFRYVQM6lrwUpZ5lLCAGK07JQh4Hat9bbArNIOsuuWDiDqbWkd98RUTYslTCzoUPvKYYyZmUL5b0hgQXD1XWkNQcxw65ghcIvJl5KJECoYD3a7Tg/4rqguDP6KbKLFFn0qlWWFcYZ+Sc6BeWHsz97Ju9H+T/sxUKfGXYNVv2TCQe4N5MhC6kWnbpD/D+FZ6hh7QynmbxyWc6GhdlAQoMVuV7C/Sb01zp9U2TCsFqmHbQn/+hLrAeOrFSJedhEAylbBlcUsEbU51y6KtUNDgcSO+xgBSZBcrF5px0pcUQnEVyv1CPlIaMXzi2tT0BveELEkloc+rrQ7EyBy0tLpJx/QeIaS8FxCrh7B+Wz/CVh9f/SoH2GT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(1800799003)(451199021)(186006)(2906002)(83380400001)(5660300002)(71200400001)(38070700005)(110136005)(7696005)(66476007)(64756008)(66946007)(66556008)(76116006)(122000001)(66446008)(9686003)(33656002)(4326008)(55016003)(316002)(41300700001)(38100700002)(86362001)(8676002)(8936002)(26005)(6506007)(478600001)(53546011)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtSWW8wdG8zbDNFMmEvS3Jqc3JRQWRFZTNmSmp4blpWVGR2ajRXb3kwdkxK?=
 =?utf-8?B?RmFIbUMwZG1JdTZkZmNnRjl6czRBZS9Xdi9WeUNETWc1YzVhS2RtU0JlVTNL?=
 =?utf-8?B?dG9JS3QybFdqQy9MOWJDd2xkQUZEWFc1ODRRWGRvRHcwTDYxVHlubjRJUEVX?=
 =?utf-8?B?alBpVGV0bHF3eEhRUHZrSXFtdXpFbHRwdml5dEtZWGlLVmg5Wk5ValB5MVho?=
 =?utf-8?B?TXFMSXUwa2szZlpnM1RCRG5nQkJycHNGYk9uMjJaYzMrcTFpMTNuZ2YxMTRi?=
 =?utf-8?B?QXc5M3RXUjZrUEhEbm0vTDYzNTFhdFYrRXE2RitCRWZhWW5RV1JlSlhnYlBJ?=
 =?utf-8?B?MTRldWZvR0tSWEpYZXpld2J0Ty9ySk1TanV5bG51MnpMNkdxdWlOM0l3d1lU?=
 =?utf-8?B?Y1BhaU83bnl3UG1JaUYxaXBJeG1EUFk0WEtsbGVPREx4Vm1PVWdUMVh5YUhP?=
 =?utf-8?B?QVFsZEx3b2Z2TEdpeTNWaW96MmtyTDgvckt0UVhNT3pqMFVVQjI1TkxEN3Bi?=
 =?utf-8?B?TGtoUWxqR29SUG1paWtrQjRNS25WWTBqVWZCU3JsN1E2QXIwWEg4WHRneW4y?=
 =?utf-8?B?RzJJNG0yQUZtUXBlUUtuR2tZMHFrODNKajVlck8zdHpkRVp5VlVrei9ITU9Y?=
 =?utf-8?B?TFVyczNzd09Tczdrc1oyVzdRcGpuM3QwRzh4NEdibVR5TVVtQWFEQVRiY2hY?=
 =?utf-8?B?SUM2am4xV051MHp4dTZEYU9zSTU3N05KYlNqOTc3QVVsU1d5QUgyOW5pZ1F5?=
 =?utf-8?B?cjZkRXd3WWZVYk04SEZXNUQxWVB6bGQ5ck56SUNIZ2ZzTXFOMmJ0S3YwdUY4?=
 =?utf-8?B?S05HelRxdlloWEZRV0VIbGY0Y1hqOEx0cUVGSU03QWNyL1VlOExULy9Yejcw?=
 =?utf-8?B?VVNqY0pwOEE5ZjI2b2xodUhTck95YmIyWWFUNUh4dXZ0dnZhTFV5MGpzSjR4?=
 =?utf-8?B?Z0lkaDYvNTJUWSswTUNvS24ydmQzTWpJa2lseWJFeEhFNHB2RTgvWGZZa0VR?=
 =?utf-8?B?aXdlQVM3aGR0eWxjbkdCbnBadEI3cm5jNmtmbWFHWWxtNi80cFNhQVBIcnd6?=
 =?utf-8?B?QnN2UVFNcHhST0xsaXZjT21PTmpNSFZiQzBVMjBwU1RCVDRZREIxbkJRTk9t?=
 =?utf-8?B?eWZIQXpsZXc5TVdxRFdQRGJXUVlTdFZIbFF4SzRmamsrdm9YZVZTYUFtREZa?=
 =?utf-8?B?em9HSTBrL3NiaHcyblJSdjYxUlN5Ym94YUdjVHNuZXNSdkxCNzVqN3poaTdJ?=
 =?utf-8?B?QlhNM1RxcTVwYlRzOU5najR3enZia2R3L0p1VHRHemtueTF3L0dpcm85a2N0?=
 =?utf-8?B?eWdSVnUzUGd3U3U0L1daSk9SM3pNd0xtYzB3c3pUcm1LNzVFNXRLVVZCb2Vt?=
 =?utf-8?B?WDd4RHlzaVI5WEhpMnVKcGh3ZEJaVmFwU0FOTnBSLzhaQnd2NTdZYmozR0NS?=
 =?utf-8?B?bllIM1lRdDAxYkJ4a1FrTWF2YnBUaUl4aWIvQWNDSlVQd2NNTUhuNXhsaFZR?=
 =?utf-8?B?anFoVnRCOTEwejRpUEhVcFNvR3FUREdTK3ZLRzdPMFVNQU9jUWVEVWkwZkZk?=
 =?utf-8?B?U3IwLzdLbGRJWXByOFBLRGVEQ2FGNXNvOUNPRXlSenZHb3FVSXhsK2Y5Z0x4?=
 =?utf-8?B?OEcxM1ZzS1dtb2JPTDQ0MFNvWm9ndG1naUFPZUpMWFNqSkFiNDNzYVZveWIv?=
 =?utf-8?B?NXNjTkRtWFp5QmVNeGE4WDE1RDB2OGs5VlRzUmdVZk5ieWcrMzY3NXluOHRa?=
 =?utf-8?B?ZzJWdnJpRXorbHVOcEdNT3cyV0E1VjhJYko3aFMrU1NLZnBFdWMwRnVrL0tV?=
 =?utf-8?B?U0hkMnVRdjhyT1E4QThCN1dlYnN6SldoZG9UU1Z2Tjk2bVM0NkMyYnRVMm9a?=
 =?utf-8?B?amFCQUpSYXRIdUUwaEhkeG9HSTRXeVFXbHQ5SGRvSmo1NzU3bkhsMUtDUXk3?=
 =?utf-8?B?ZnhiZGN3c293dGNob295dE53dWEyYkZEVE05L1grMEIwTysrajNvMFhzblNq?=
 =?utf-8?B?dUgvQVVMM0NTVy9wNEs5ZUl4ak9KeHJLYUVwS0l6TWxCZzMzTmdpNnFvR0pQ?=
 =?utf-8?B?QzZleUxZRzRnMm9PVlBZMnRvUk0zbE81SlJWTDZOVzFWdU5TeEdrVzVuNEhh?=
 =?utf-8?Q?0g40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ba369c-4f01-4f24-ade2-08db97f9e6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 10:26:17.4787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX7wIGLl90gDkJlQ6LLvd9w+G84YRWG0N2KZJVIdus/Afd3/iMDD/AVk5rHghbhd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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
Cc: "Arif, Maisam" <Maisam.Arif@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkN1cnJlbnRseSBub19mYW4gaXMg
ZGV0ZXJtaW5lZCBpbiBzdyBpbml0Lg0KICAgIGlmICghc211LT5wcHRfZnVuY3MtPmdldF9mYW5f
Y29udHJvbF9tb2RlKQ0KICAgICAgICBzbXUtPmFkZXYtPnBtLm5vX2ZhbiA9IHRydWU7DQoNClRo
aXMgaXMgdGhlIGNhc2UgdGhhdCBzb21lIGJvYXJkcyBoYXZlIGZhbnMgYW5kIHNvbWUgZG9uJ3Qg
aGF2ZS4NCnNtdS0+cHB0X2Z1bmNzLT5nZXRfZmFuX2NvbnRyb2xfbW9kZSBzdGlsbCBuZWVkIHRv
IGJlIGRlZmluZWQuDQohc211X2Ntbl9mZWF0dXJlX2lzX3N1cHBvcnRlZChzbXUsIFNNVV9GRUFU
VVJFX0ZBTl9DT05UUk9MX0JJVCkgaXMgZW5vdWdoIHRvIGdldCB0aGUgZmFuIGNhcGFiaWxpdHku
DQpOb3Qgc3VyZSBpZiBpdCdzIGJldHRlciB0byBkZXBlbmQgb24gcG0ubm9fZmFuLg0KVGhhbmtz
Lg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgOCwgMjAyMyA2OjEyIFBN
DQpUbzogRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEFyaWYsIE1haXNhbSA8TWFpc2FtLkFyaWZAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IGRpc2FsbG93IHRoZSBmYW4gc2V0dGlu
ZyBpZiB0aGVyZSBpcyBubyBmYW4gb24gc211MTMNCg0KDQoNCk9uIDgvOC8yMDIzIDE6MjEgUE0s
IEtlbm5ldGggRmVuZyB3cm90ZToNCj4gZGlzYWxsb3cgdGhlIGZhbiBzZXR0aW5nIGlmIHRoZXJl
IGlzIG5vIGZhbiBvbiBzbXUxMw0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLZW5uZXRoIEZlbmcgPGtl
bm5ldGguZmVuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMC5jIHwgOSArKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gaW5kZXggOWI2MmI0NWViYjdmLi4w
OWVmMGE3ZTc2NzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvc211X3YxM18wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzAuYw0KPiBAQCAtMTEzMSw3ICsxMTMxLDkgQEAgc211X3YxM18wX2Rpc3Bs
YXlfY2xvY2tfdm9sdGFnZV9yZXF1ZXN0KHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPg0KPiAg
IHVpbnQzMl90IHNtdV92MTNfMF9nZXRfZmFuX2NvbnRyb2xfbW9kZShzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkNCj4gICB7DQo+IC0gICAgIGlmICghc211X2Ntbl9mZWF0dXJlX2lzX2VuYWJsZWQo
c211LCBTTVVfRkVBVFVSRV9GQU5fQ09OVFJPTF9CSVQpKQ0KPiArICAgICBpZiAoIXNtdV9jbW5f
ZmVhdHVyZV9pc19zdXBwb3J0ZWQoc211LCBTTVVfRkVBVFVSRV9GQU5fQ09OVFJPTF9CSVQpKQ0K
PiArICAgICAgICAgICAgIHJldHVybiBBTURfRkFOX0NUUkxfTk9ORTsNCg0KSWYgdGhlcmUgaXMg
bm8gUE1GVyBmYW4gY29udHJvbCwgaXNuJ3QgaXQgYmV0dGVyIHRvIHNldCBwbS5ub19mYW4/DQoN
ClRoYW5rcywNCkxpam8NCg0KPiArICAgICBlbHNlIGlmICghc211X2Ntbl9mZWF0dXJlX2lzX2Vu
YWJsZWQoc211LCBTTVVfRkVBVFVSRV9GQU5fQ09OVFJPTF9CSVQpKQ0KPiAgICAgICAgICAgICAg
IHJldHVybiBBTURfRkFOX0NUUkxfTUFOVUFMOw0KPiAgICAgICBlbHNlDQo+ICAgICAgICAgICAg
ICAgcmV0dXJuIEFNRF9GQU5fQ1RSTF9BVVRPOw0KPiBAQCAtMTE0Myw3ICsxMTQ1LDcgQEAgc211
X3YxM18wX2F1dG9fZmFuX2NvbnRyb2woc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgYXV0
b19mYW5fY29udHJvbCkNCj4gICAgICAgaW50IHJldCA9IDA7DQo+DQo+ICAgICAgIGlmICghc211
X2Ntbl9mZWF0dXJlX2lzX3N1cHBvcnRlZChzbXUsIFNNVV9GRUFUVVJFX0ZBTl9DT05UUk9MX0JJ
VCkpDQo+IC0gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+DQo+ICAgICAgIHJldCA9IHNtdV9jbW5fZmVhdHVyZV9zZXRfZW5hYmxlZChzbXUs
IFNNVV9GRUFUVVJFX0ZBTl9DT05UUk9MX0JJVCwgYXV0b19mYW5fY29udHJvbCk7DQo+ICAgICAg
IGlmIChyZXQpDQo+IEBAIC0xMjA0LDcgKzEyMDYsOCBAQCBzbXVfdjEzXzBfc2V0X2Zhbl9jb250
cm9sX21vZGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+DQo+ICAgICAgIHN3aXRjaCAobW9k
ZSkgew0KPiAgICAgICBjYXNlIEFNRF9GQU5fQ1RSTF9OT05FOg0KPiAtICAgICAgICAgICAgIHJl
dCA9IHNtdV92MTNfMF9zZXRfZmFuX3NwZWVkX3B3bShzbXUsIDI1NSk7DQo+ICsgICAgICAgICAg
ICAgaWYgKHNtdV9jbW5fZmVhdHVyZV9pc19zdXBwb3J0ZWQoc211LCBTTVVfRkVBVFVSRV9GQU5f
Q09OVFJPTF9CSVQpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4g
ICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgY2FzZSBBTURfRkFOX0NUUkxfTUFOVUFMOg0K
PiAgICAgICAgICAgICAgIHJldCA9IHNtdV92MTNfMF9hdXRvX2Zhbl9jb250cm9sKHNtdSwgMCk7
DQo=
