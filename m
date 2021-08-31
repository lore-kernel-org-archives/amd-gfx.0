Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE40C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 22:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431F160F6C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 22:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 431F160F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B75F89F8E;
	Tue, 31 Aug 2021 22:09:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1756D89F8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 22:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkQIg0T4HWr0+6RewRsnN9J/eOMcwkgnDWthrgjPqQ4ph3cP04mwh8Omogb0xnR94NNn9ntYdbiqTSO9pfQh/1o6TY+99l4HOKVoQheuFjUdgGQF1YIvgxr1txvuVl6farPes17rZyHH33lbZEXIJDUHKBjoGdCj7qzKo5whmiRUMzlVjcaGGWjsoNpYXUBvso34IlqMqkBV63J1Cd8h4l5kz7BKgccy8ro1sCO+Fg+Ipu/fNjoHg2dky29A3xVee8LDU74aTUvfefKH95ERJ9IE6o/P2knJDXuOiAReXv0RGORGMBpdmayrKfGcPmygWR7WsKMnmcvGCapoOMniBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0X/H3fGKzofPJFnl4bAoP8/lc/2cYaIg9stXQKh2hWY=;
 b=auFrP0e7XICOgClT7V7x5jFW/hO+gjtKgF8hUA1Y902t3rjlUW0Ep8ZC9p55VsQAX/Ct+HIVH4DnqVpjoxUgxe13fjxrwruBPIBo2STYa407ITEYw5wv4N/bkRAPO+NDU9CJPVGzhk9Dl2EYlKR5Vw1gAsudVUFPSU+K9cjWe0ZLGABsK0WBVjUAK1fhIyQ2lPcpF5t0BUoorjXcWH45qKLmpJQhRsVaur8BzBpL+8Buz84ApcPNgkRZUCoRLnngIrCYJvGZeQzGKQ3kANF3AU7BKxGkUlwNCWDvfdAkGUH+MBNYYzukSdH0MmB9c1KTOL8MxAnHwaD0hIV0LdIM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X/H3fGKzofPJFnl4bAoP8/lc/2cYaIg9stXQKh2hWY=;
 b=o8kimXGY5c9Z0OFmULk9FpNmCnbPmGtCcBu1ZplZ8/x8A6ZWaamYTnsMmOq9S99PP2TNvzc/28QPUt7NEPvQK6HXm5KWtCrZw+odsik72ufb3PLjyuZ+ZSyA0SH4yXyXJyf1OPVh6kx/b0vRQ8ChBJZpbC9bnf1h1yrRZFB2xLM=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 22:09:18 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::6958:68e2:61a1:466f]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::6958:68e2:61a1:466f%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 22:09:18 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Thread-Topic: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Thread-Index: AQHXnrMlxMbXCzFXyk2o1vKqkpmPYquN6TmA
Date: Tue, 31 Aug 2021 22:09:18 +0000
Message-ID: <A98C3522-21DE-4872-8FA5-512D65D1A1B9@amd.com>
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
In-Reply-To: <20210831215632.195506-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.49.21050901
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 471df035-0953-4575-aed3-08d96ccbfa3a
x-ms-traffictypediagnostic: DM6PR12MB5567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5567BC83C29885AD04DBC43880CC9@DM6PR12MB5567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuaxlL+q0z8J7SwvF3SS+S58U5DGtvo2n2Mb1DGiNrzLfcUTR7voRKQT5pjxYC5hhEiwAR0w/6PhkMzdOH+/anrjWdYP5j2L+hr29Vrr0h8KV/VpPdHrUWO2I8XD8DzYLtyePekcdmq1ZnC4pu8DjrlgMAHQRo2sBdBoLyyNcifh/dvrRowJ3YXJh+4GndDTqDua6XOSJEg03PWrCaFMD+IipFwcDvEK/LPdAcIsfcLJ8WgK4g5a6Id9qzC44DrSoXGrWgKobtK0RqKVFJRRZMHhbwe3D04Gz6UmyulzUlQFSmU8+2C1FL4eG8tRqiV0e+iasvta2VXcMQku4Kb9KM6FKNOhCJGr0u5f7iDB1c2w9bXAB1JUR7Oq//0I9jwILrdsbBDQ+QjRGbu+zQlayFU4brZseNVRnvACYUWv6L3oAovq29lJTKvtla63gJ6Kj/+oUA2QFQ4+0tNAeMtSs6STS91nj7GrTiYHIYgjJrzw7/vRSKABdpOUrKiA60vnIBqxg4L5GdRqfZorDUiiEWxB3K+FBCB5zPgsjkvag+y7ko/vdF2xGWcvgsy70wCAOEWuvWNsAlXSTFBOExhotM9KKfY5C1pPTMmRM3IN8bMDp7WwzwAG8O3NgcUIlQwhMlAjEKrUbj4Fd8DOV4FX9BKjQbjjUnBQM2Ki2ONqT8B3etUbQAs4n0R2W6waStxEln73TXedix6DnhDSgmKo/eR0tb0ZAR3GG0G55TncXrA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(6486002)(6512007)(110136005)(2616005)(38100700002)(33656002)(86362001)(83380400001)(8936002)(316002)(8676002)(66446008)(38070700005)(2906002)(478600001)(36756003)(6506007)(122000001)(71200400001)(91956017)(186003)(76116006)(66946007)(26005)(66556008)(64756008)(66476007)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWo3R1MxYkxrZXZSRkdxOTdjTkpnNmlKWkVVV1ZHeFBsYzBCRC9GUURXYisv?=
 =?utf-8?B?cVQ1VE1sekZMWmMwbnp2NGRQOE1TRnhvMUt5YUJrTEc3VWhvNFJJNi9sbTh2?=
 =?utf-8?B?d1NXd25hdEEzU1BCQ3Q2S21Lb0FUelU0K0loSVg0SnBpNlFwM3ovUlM0SFY3?=
 =?utf-8?B?ZjFINFBoMktMR1Vwd0tQSFNJSjNMSzV3WWN1TlZuUGhQSHJuM1lUaWxndmE3?=
 =?utf-8?B?Y3YvekdMTmNrbkxNWlpXTFpQeW9YQWo1RnRjUmFPdmhnKzR3UjRSazFlMUE2?=
 =?utf-8?B?aFNLYjQ0cXJIQkZHOWxmbmNNRWZ4UVhua1ZKa1FnMEZ4SWZZaHVIaExuZ3Jy?=
 =?utf-8?B?SHhVSVpEa3I2STdyMjRKWTBiTXoveXZ0UVF1M1VabG5lK0V3T0QwWjFGQm4y?=
 =?utf-8?B?N2pWS2g3SGZwMmpiS0pFYjhndHNYNU5OZ3JyTWxITUl5Q0ZVYjRHQytwdlVs?=
 =?utf-8?B?VS9GeElNbStPcGFZZm5vaG02cklScE5CRjV6NTROMlFhbEVMVzhnTDVPNFJV?=
 =?utf-8?B?VWd2TDNYSElYaVB4NW9Sc0cxcnJYaUlpOUh4b0J4a04vdXJxaFRWcnpxTjBT?=
 =?utf-8?B?b0dSbjE5empiQzQ3WVlTeEE3akxBaVZzQ21GQjQ5aDQwRENzclZHYzNjOGdD?=
 =?utf-8?B?K205aUNaNUF4RlJzZGIzdWxaWU1YRnpkTFhHZmNIR0RwSWNpa2JCVjhxSjVH?=
 =?utf-8?B?aEdOV0JGUWVEd25tWlhmM3l4Q3REN1lGT05YaVlOVTA3aGYycUFSQ2MvQk5N?=
 =?utf-8?B?UTQ1SVE2dzQvRFRIWE0zMnhDSlV2Z1dOSEhqaFQzSEVNYTkzL1RtV1p0am5s?=
 =?utf-8?B?WlBKeVRacTRadncyUUE5VDVVSm96MWFBZ2ZmRHkzV3JxSFBHQ1FkcHI0MnVa?=
 =?utf-8?B?TWFtVEg0a0crQmRmMDBHWjFDL2F3bkdFcHFDVEdhTENkZkJmbFdVL1ZXOE9F?=
 =?utf-8?B?QjZNZXhHMFI4c3ZZOXBhU3hKUWE5T0h4dTN2NXg1WFZCT2NCME1KOEhFSkg4?=
 =?utf-8?B?TDYwbUEwTXlkbCsrdkNTc2VqOTAyeVBIcHZ4akEyNzAyaTJ4c1BXWXBnWmFJ?=
 =?utf-8?B?YzIzSnlOcjV2MU5UTUplM21hRHhMU0JLcU1wUjBUTXR3Q1FjaHd1QnQwMERh?=
 =?utf-8?B?Q29DZGIzZXU3UG9BL2ZGdVZ5cTdWZk5YU3hmMnRTR3FqOE5Nc1EzSW1jK0hO?=
 =?utf-8?B?UWwwMXJaTVZtTTR4ZlRIZWRWS0hBSjNFOS9MSmErRWQ4d2g2MllRRS84c0R4?=
 =?utf-8?B?aEx5QVdOeWRPWkZjUk4zU0JoVGh5OExJZTA4OVJLOU5yRmdEN2N4QnMxa3NY?=
 =?utf-8?B?ZFpmRlp1R2I4TW42UkliaUtzRDdNM1pQamg0NVdTNjZjLzBFdkFhTnRxby9P?=
 =?utf-8?B?NzlaZlptNysvN3NUd2I0UlExUTBDMSt0TE9PUVpVQ3FCVm91TGtCd3RsYXJB?=
 =?utf-8?B?bkVxbFVGZEFkcnQ3M3lTWmJCY0UzRGJtUnZ2dFd6ZTJUb3dQWUhqdkxsRXho?=
 =?utf-8?B?VWxXbkh3TzkyUjZ0YmRDWUpuU2E5MDZFakFMNkRsd21odHZ2OGNqaXJ1Nmpi?=
 =?utf-8?B?L3VScCtham1FL0RtRWlKMlBXVWw4MlpadGZxQ0xjRk5SQzhYSzZWbm5TWmpj?=
 =?utf-8?B?dCtFaGVtV3p6a1JVdzZwMSsxUlBiaTJSZjBPSmJXRDhRMjNUaHh3NVhLTXV3?=
 =?utf-8?B?OCtQVkxQYU1XMVcyUFFJM1h3U3gvWTRVQS84UzVTclBCSS8rUGlWOVNpL014?=
 =?utf-8?B?MmxMRWZBOTQ5MlJCd3N0YncyUVVSNTdwcHpPQjdzYmt6RTNBK2pabmd3SkdZ?=
 =?utf-8?B?MU9XZCtEaFk0Z21JbkNjZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD32DB0265197A439E6FDC49EA806CD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471df035-0953-4575-aed3-08d96ccbfa3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 22:09:18.0393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cW6K3GQ93cEASKPFQPKi2r8bD08hl2A/kwEphG/6CV7zdVhrT5UOtKgXdxJJi945
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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

QSBuaXQtcGljayBpbmxpbmUuIE90aGVyd2lzZSB0aGlzIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBP
YWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCk9hayANCg0KIA0KDQrvu79P
biAyMDIxLTA4LTMxLCA1OjU3IFBNLCAiYW1kLWdmeCBvbiBiZWhhbGYgb2YgRmVsaXggS3VlaGxp
bmciIDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIG9uIGJlaGFsZiBvZiBG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPiB3cm90ZToNCg0KICAgIE9uIHNvbWUgR1BVcyB0aGUgUENJ
ZSBhdG9taWMgcmVxdWlyZW1lbnQgZm9yIEtGRCBkZXBlbmRzIG9uIHRoZSBNRUMNCiAgICBmaXJt
d2FyZSB2ZXJzaW9uLiBBZGQgYSBmaXJtd2FyZSB2ZXJzaW9uIGNoZWNrIGZvciB0aGlzLiBUaGUg
bWluaW11bQ0KICAgIGZpcm13YXJlIHZlcnNpb24gdGhhdCB3b3JrcyB3aXRob3V0IGF0b21pY3Mg
Y2FuIGJlIHVwZGF0ZWQgaW4gdGhlDQogICAgZGV2aWNlX2luZm8gc3RydWN0dXJlIGZvciBlYWNo
IEdQVSB0eXBlLg0KDQogICAgU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQogICAgLS0tDQogICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2UuYyB8IDkgKysrKysrKy0tDQogICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9wcml2LmggICB8IDEgKw0KICAgICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlLmMNCiAgICBpbmRleCAxNmE1N2I3MGNjMWEuLjY1NWVlNTczMzIyOSAxMDA2NDQNCiAg
ICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCiAgICArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCiAgICBAQCAtNjg4LDYg
KzY4OCw3IEBAIHN0cnVjdCBrZmRfZGV2ICprZ2Qya2ZkX3Byb2JlKHN0cnVjdCBrZ2RfZGV2ICpr
Z2QsDQogICAgIAlzdHJ1Y3Qga2ZkX2RldiAqa2ZkOw0KICAgICAJY29uc3Qgc3RydWN0IGtmZF9k
ZXZpY2VfaW5mbyAqZGV2aWNlX2luZm87DQogICAgIAljb25zdCBzdHJ1Y3Qga2ZkMmtnZF9jYWxs
cyAqZjJnOw0KICAgICsJdWludDMyX3QgZndfdmVyc2lvbjsNCg0KICAgICAJaWYgKGFzaWNfdHlw
ZSA+PSBzaXplb2Yoa2ZkX3N1cHBvcnRlZF9kZXZpY2VzKSAvIChzaXplb2Yodm9pZCAqKSAqIDIp
DQogICAgIAkJfHwgYXNpY190eXBlID49IHNpemVvZihrZmQya2dkX2Z1bmNzKSAvIHNpemVvZih2
b2lkICopKSB7DQogICAgQEAgLTcxMyw4ICs3MTQsMTIgQEAgc3RydWN0IGtmZF9kZXYgKmtnZDJr
ZmRfcHJvYmUoc3RydWN0IGtnZF9kZXYgKmtnZCwNCiAgICAgCSAqIHN1cHBvcnRlZC4NCiAgICAg
CSAqLw0KICAgICAJa2ZkLT5wY2lfYXRvbWljX3JlcXVlc3RlZCA9IGFtZGdwdV9hbWRrZmRfaGF2
ZV9hdG9taWNzX3N1cHBvcnQoa2dkKTsNCiAgICAtCWlmIChkZXZpY2VfaW5mby0+bmVlZHNfcGNp
X2F0b21pY3MgJiYNCiAgICAtCSAgICAha2ZkLT5wY2lfYXRvbWljX3JlcXVlc3RlZCkgew0KICAg
ICsJZndfdmVyc2lvbiA9IGFtZGdwdV9hbWRrZmRfZ2V0X2Z3X3ZlcnNpb24oa2dkLCBLR0RfRU5H
SU5FX01FQzEpOw0KICAgICsJaWYgKCFrZmQtPnBjaV9hdG9taWNfcmVxdWVzdGVkICYmDQogICAg
KwkgICAgZGV2aWNlX2luZm8tPm5lZWRzX3BjaV9hdG9taWNzICYmDQogICAgKwkgICAgKCFkZXZp
Y2VfaW5mby0+bm9fYXRvbWljX2Z3X3ZlcnNpb24gfHwNCiAgICArCSAgICAgIGFtZGdwdV9hbWRr
ZmRfZ2V0X2Z3X3ZlcnNpb24oa2dkLCBLR0RfRU5HSU5FX01FQzEpIDwNCllvdSBhbHJlYWR5IGdl
dCB0aGUgZndfdmVyc2lvbiBhYm92ZSBfXw0KICAgICsJCQlkZXZpY2VfaW5mby0+bm9fYXRvbWlj
X2Z3X3ZlcnNpb24pKSB7DQogICAgIAkJZGV2X2luZm8oa2ZkX2RldmljZSwNCiAgICAgCQkJICJz
a2lwcGVkIGRldmljZSAleDoleCwgUENJIHJlamVjdHMgYXRvbWljc1xuIiwNCiAgICAgCQkJIHBk
ZXYtPnZlbmRvciwgcGRldi0+ZGV2aWNlKTsNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcml2LmgNCiAgICBpbmRleCBhYjgzYjBkZTZiMjIuLjZkOGY5YmIyZDkwNSAxMDA2NDQNCiAg
ICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQogICAgKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaA0KICAgIEBAIC0yMDcsNiArMjA3
LDcgQEAgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyB7DQogICAgIAlib29sIHN1cHBvcnRzX2N3c3I7
DQogICAgIAlib29sIG5lZWRzX2lvbW11X2RldmljZTsNCiAgICAgCWJvb2wgbmVlZHNfcGNpX2F0
b21pY3M7DQogICAgKwl1aW50MzJfdCBub19hdG9taWNfZndfdmVyc2lvbjsNCiAgICAgCXVuc2ln
bmVkIGludCBudW1fc2RtYV9lbmdpbmVzOw0KICAgICAJdW5zaWduZWQgaW50IG51bV94Z21pX3Nk
bWFfZW5naW5lczsNCiAgICAgCXVuc2lnbmVkIGludCBudW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2lu
ZTsNCiAgICAtLSANCiAgICAyLjMyLjANCg0KDQo=
