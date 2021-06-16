Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F577C48BE8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC076109E
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 04:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC076109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DB66E49B;
	Wed, 16 Jun 2021 04:01:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDC06E49B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 04:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grWVKZ1DczwXaLqY0BDMMdkR8rUUsEPS3cJZEb0wabWSVmttWd4bLN79T8HHln8vwCeJNs9bSyhOV93fY11ewMV8DXh5Uf3LEI6J3G/1J8Lpoxe0TFFTmEWjJ5NdBzwqwuJdwCS8kytuVFk3rFOXMR2+KcvqA3c+6lu67v54ahByfiugtB0CQnqB+WC4t20tmxUrDB0JVLeK6NsyFTVihUhivYs+0y719QT12k5rz5oYs8z+NobbFNYrZPO0u3Fmo4WCGqZLnljoZyevlVMES8JvKrv54HhibKTRUBUIYLLOelXMV+a1L1PQrT5ExNfnIFGWKU/Ct14OP3a8qXRvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FH2149SK0zxT9SnyUbI2vQL+gjCxKT7Zi6BPx2SFbE=;
 b=CBiZb1Y+llWtZcqUPcT/V9DocUCserMdqGDF+Lf/zd2oG1HqGYb6sK2CJky/oAqY18rahNafEOxr5njfw/jOO/oVA3NX2AzO67N+nuufOXGTUvVMFjcJ9+1Wm3jjIYY+hU+qHiUpbxjAivKJkGKMUmtCb/7T8q20MGG9Cv0pBxh/cbLowP65RlvvnYcgWQFf1Owy3jZlsQZpK9pqlJ+bJHNMdJ4NNfHbiX3WrFXKDnqqUL+rftEAtZA2u16wSa2ek9p3SuryrjEA1OY7/I2FARIL+kd7+DNrtKwD7Ypamtmhoen9yVe7411nidDAySz56lklhV3pUqlp1MgEkc2BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FH2149SK0zxT9SnyUbI2vQL+gjCxKT7Zi6BPx2SFbE=;
 b=0aTgsg6rkAxilUyWIGbZkYb0Wis3OvU44vxDs6YJclUQ6UoYNljLjMiy/LhAWMcx+ES3BtBx+Dr8EuMmZcpPmN50ZLGEyHlxX0nJ5JNQTORwNXItxQxjxTvdlc6ydVw/CCfENNFXVo1NnymSG21IPVCdATCr9iOgxBoVwJlIhws=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Wed, 16 Jun 2021 04:01:00 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 04:01:00 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
Thread-Topic: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
Thread-Index: AQHXYg8x1bmtZ/i+xUS0qLZG7FM1C6sVYqMAgACfLYA=
Date: Wed, 16 Jun 2021 04:01:00 +0000
Message-ID: <A1E8DF67-7630-4F63-BB42-F153E3405112@amd.com>
References: <20210615175049.18382-1-Amber.Lin@amd.com>
 <a933d395-621b-52ab-da31-9e8de8525772@amd.com>
In-Reply-To: <a933d395-621b-52ab-da31-9e8de8525772@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d6cbeb4-1afa-4b9d-4e8b-08d9307b5a72
x-ms-traffictypediagnostic: DM4PR12MB5069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5069A67D92BACE196735C139870F9@DM4PR12MB5069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFvSsqwDga4VD40gpXV8mHn67MIBth4mbxFm3Uwjhh7KCpoE+dpN1VvMel2/gunkcNdqUeflZCfURye+hWvRcUNxNdS30x38G/lZO0beIFu28cUQ2xNlTN1cTPj4psXCARWNxj+2P+LjHS2Oz2FJeeld6scPYhC87YhWBOkbyav+QPH2LfcUwgPKird7kldciKDo8/t4Ov+paoxmR6uiVOeJozKI90BW7diR0z7nP8NRXp9CY8zVtBe0Lv03F4XOEeq4W8opMKO7kT0K4f6NVxjEp6zsHuBXfkH5qWYVf81J17hAMOG1R2cpAEfBYFqsYfnul34d0RCNZYonQlz+Z+16n9fs1E6YLLSmsWhWwFC2bTzA5IXpwCRYsV+xHskRG3oZT9MuPGnBENcyDK52ZBg4WMgNV53nahHTWzs7M3UqlMdyupTu/LlHnnMP/EMpWf7sW6ruXMPkggcjAWdU7xUWvScpRoo/KoaDQr716gTi24myJ6kwtzYUgTce/GgvAPlfyi9SCyINjUYH53qrPrvvXksJiQNql+SD8K+1k0RnC5hY06doiTASJKObeBmqbTprr93oEdDh5Eax7f4laFyr07DZXoRFEhpJDDqntBIq8qXGbfnWoJfHP1L3w1RhYvFJ8apkWIlDDqiCu+z/ww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(66946007)(83380400001)(66446008)(71200400001)(36756003)(64756008)(37006003)(54906003)(66476007)(76116006)(186003)(5660300002)(66556008)(26005)(6512007)(33656002)(6486002)(6636002)(316002)(91956017)(2906002)(6506007)(8936002)(2616005)(6862004)(38100700002)(122000001)(86362001)(4326008)(478600001)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dFWThseXB3YXp2d2ZpZ2J5Q04wTUxmUVNnS0ZDbUxjcXVyazBQL2hZaGY1?=
 =?utf-8?B?bVF5M1FHMTJMQnZVYXNRTFpyT21OOVFuZURoREpsWVJiQVhLOTBoK0xRemZi?=
 =?utf-8?B?eWVLMVFmdTJkT0VHTkFKYlBPZERTQmgzT1BHdlNRZm9VWDlUWXJxaXVYTVNk?=
 =?utf-8?B?Ym45UTcrREV2MVIrL0ZUSk1reFV4bjJWQUZkdkgzeTVDWDZmN1VjTEtDaFF4?=
 =?utf-8?B?TFQ0S3FPcGdsWGVnYjZob1llQ1RRRGtFZlFxV09SdGp6WitnM2oramg5WkVS?=
 =?utf-8?B?S0ZYMlpFLzlBMnV1bzBRU0ZwbENZUEJtV3o5YXVSemdrcTQ1RGNZV3I1ZGh5?=
 =?utf-8?B?V3hsWDhaQXBsLzZ1SFpockxEcXpRb0JSb0UwcFlRMjBWMGhTR2s1aDgwVzdJ?=
 =?utf-8?B?YXRyKzFBWGFJVStoMHJNN1llWitncmRCeXBpR0Zac1RiV3A3ZlZRNThXV3VO?=
 =?utf-8?B?THJpZHExcXdjRTNxQ2o4cHo5MFJjMzJCRG83dVdKUHFxcmUwR2QrSnQybmk2?=
 =?utf-8?B?a1hqTEx5V1VTY0txK1FhbElGeGM2RFlCclBOc2N6bGltakVLaExnZUc2MkhQ?=
 =?utf-8?B?OEYyb0srb253eE50MWlSNmdFc0dLdThCYTVvSzBWWVdJZFJheHRydlg1M2Mw?=
 =?utf-8?B?aUZHUW5iRUl1d01WYWdLdGRxS3JCL1lNVWlGVlhuNW16UEx2aVQ0MUpyNFNZ?=
 =?utf-8?B?bHM1YVFMYWJkUzlhejZTMFFiVkYwa3h0eDFXRXVmaURjU1A1cnErRVJvQlZM?=
 =?utf-8?B?dDRaMitCN0hpTWlEMC9IZjlqTlJTN1UwdXNEVW5Xblo3UzQreXVhRkZjY0Rk?=
 =?utf-8?B?ZVpWdFdTa0FtMFNpTThoS0dPeTFDSE1xY1VabmNIV0lvMFB2Mk03SU10clpr?=
 =?utf-8?B?ZjlNdzNmVGFQblRqdWVEWS9iQy9oSmpqTFlpSzlYQS9PTWQrOUd2RFVaUU5V?=
 =?utf-8?B?TVBCNlNUNExkY3grbjM2NGgyMVg4TmxET3dhQTFvckM5enQ0b092cjlobWxs?=
 =?utf-8?B?dzBrSlNXSXNGK2NNZlZ4eWtBVFB2UUw2d0xONVhOeXcwT2ZQNk9Rc3dOVHFX?=
 =?utf-8?B?d2FTeGw2L05BdTd6NzdhbjFFV1V5akYxRmpJZHBhaDI1OEZLOVlnVGgyMGNK?=
 =?utf-8?B?dnhHRERpb1ZoWDZZbEpMNzljZU1iS3JhNFFxOXpYc0dlcnVnMlNYdEdDYkxB?=
 =?utf-8?B?TSs1YzJkRXV5aUhzV3psdTJjLzNBeEJSdGNFZ2FJQUFYSEQva3lmbHkwL3Zo?=
 =?utf-8?B?c0tEb1BsNDQxWW5tcWhTOFZUeFZqK0VOZFVXeGd6ejJxSkh5MHl6aVh0VXU4?=
 =?utf-8?B?WlFiSGhyTGkzWGJPQS9LeUd0ZHpJKzNISlYxeHFBWEVQZGo2d0dKeTBzcFgx?=
 =?utf-8?B?VGVhMkwvNGxnek9Ha0c5UXUydjdQcDhTdGk4L3JlOUs3K2NmVnRaOVVqcDlo?=
 =?utf-8?B?ZmRyblpPTW0yUHdVWVpiTTlrM2lmZE9NRFh5Rk9yWXUxQUlXVGxkdlA2aTc4?=
 =?utf-8?B?czM3VmVNL3pDSitGSGF5WFh2Q01vNHYrSTg3dUR5SllVOFlabHhmcGhQTUFP?=
 =?utf-8?B?V2FYMWtKS0xZa0JGOThMZDNpSXo5bnQvQkFZUmkxY3NVaUZ5Ukk5UDd6cDRj?=
 =?utf-8?B?TWI3R0xMaWVyc01nZ0pDWTgzeUwvOHpSU21rTUVQV0Q2aHhLM1BFLzJwY0c3?=
 =?utf-8?B?d01zQnVpSFRDSVdBcm8wYURTOXlPaklZNERpSmFDcDdkZzJ2L1JDTklnbklo?=
 =?utf-8?Q?1VM84U3BNzPHpHEEu7GJWO8TwefgRvr8sA1bV0k?=
Content-ID: <E14465CE484BA14DB9015403CA6EC43F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6cbeb4-1afa-4b9d-4e8b-08d9307b5a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 04:01:00.4345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K27I767f7+ekQ5DArIyQYLXVF1IxALkvJD4zqs33P/bln/f9AvhnpE/Nc8PGUv05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMeW5tDbmnIgxNuaXpSAwMjoyMu+8jEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4g5YaZ6YGT77yaDQo+IA0KPiBbK1hpbmh1aV0NCj4gDQo+IA0KPiBBbSAy
MDIxLTA2LTE1IHVtIDE6NTAgcC5tLiBzY2hyaWViIEFtYmVyIExpbjoNCj4+IENhbGxpbmcgZnJl
ZV9tcWQgaW5zaWRlIG9mIGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQgY2FuIGNhdXNlIGEN
Cj4+IGNpcmN1bGFyIGxvY2suIGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQgaXMgY2FsbGVk
IHVuZGVyIGEgRFFNIGxvY2ssDQo+PiB3aGljaCBpcyB0YWtlbiBpbiBNTVUgbm90aWZpZXJzLCBw
b3RlbnRpYWxseSBpbiBGUyByZWNsYWltIGNvbnRleHQuDQo+PiBUYWtpbmcgYW5vdGhlciBsb2Nr
LCB3aGljaCBpcyBCTyByZXNlcnZhdGlvbiBsb2NrIGZyb20gZnJlZV9tcWQsIHdoaWxlDQo+PiBj
YXVzaW5nIGFuIEZTIHJlY2xhaW0gaW5zaWRlIHRoZSBEUU0gbG9jayBjcmVhdGVzIGEgcHJvYmxl
bWF0aWMgY2lyY3VsYXINCj4+IGxvY2sgZGVwZW5kZW5jeS4gVGhlcmVmb3JlIG1vdmUgZnJlZV9t
cWQgb3V0IG9mDQo+PiBkZXN0cm95X3F1ZXVlX25vY3BzY2hfbG9ja2VkIGFuZCBjYWxsIGl0IGFm
dGVyIHVubG9ja2luZyBEUU0uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEFtYmVyIExpbiA8QW1i
ZXIuTGluQGFtZC5jb20+DQo+PiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+IA0KPiBMZXQncyBzdWJtaXQgdGhpcyBwYXRjaCBhcyBpcy4gSSdt
IG1ha2luZyBzb21lIGNvbW1lbnRzIGlubGluZSBmb3INCj4gdGhpbmdzIHRoYXQgWGluaHVpIGNh
biBhZGRyZXNzIGluIGhpcyByYWNlIGNvbmRpdGlvbiBwYXRjaC4NCj4gDQo+IA0KPj4gLS0tDQo+
PiAuLi4vZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgIHwgMTggKysr
KysrKysrKysrKy0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4+IGluZGV4IDcyYmVhNTI3OGFkZC4uYzA2
OWZhMjU5YjMwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+PiBAQCAtNDg2LDkgKzQ4Niw2IEBAIHN0
YXRpYyBpbnQgZGVzdHJveV9xdWV1ZV9ub2Nwc2NoX2xvY2tlZChzdHJ1Y3QgZGV2aWNlX3F1ZXVl
X21hbmFnZXIgKmRxbSwNCj4+IAlpZiAocmV0dmFsID09IC1FVElNRSkNCj4+IAkJcXBkLT5yZXNl
dF93YXZlZnJvbnRzID0gdHJ1ZTsNCj4+IA0KPj4gLQ0KPj4gLQltcWRfbWdyLT5mcmVlX21xZCht
cWRfbWdyLCBxLT5tcWQsIHEtPm1xZF9tZW1fb2JqKTsNCj4+IC0NCj4+IAlsaXN0X2RlbCgmcS0+
bGlzdCk7DQo+PiAJaWYgKGxpc3RfZW1wdHkoJnFwZC0+cXVldWVzX2xpc3QpKSB7DQo+PiAJCWlm
IChxcGQtPnJlc2V0X3dhdmVmcm9udHMpIHsNCj4+IEBAIC01MjMsNiArNTIwLDggQEAgc3RhdGlj
IGludCBkZXN0cm95X3F1ZXVlX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpk
cW0sDQo+PiAJaW50IHJldHZhbDsNCj4+IAl1aW50NjRfdCBzZG1hX3ZhbCA9IDA7DQo+PiAJc3Ry
dWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkID0gcXBkX3RvX3BkZChxcGQpOw0KPj4gKwlzdHJ1
Y3QgbXFkX21hbmFnZXIgKm1xZF9tZ3IgPQ0KPj4gKwkJZHFtLT5tcWRfbWdyc1tnZXRfbXFkX3R5
cGVfZnJvbV9xdWV1ZV90eXBlKHEtPnByb3BlcnRpZXMudHlwZSldOw0KPj4gDQo+PiAJLyogR2V0
IHRoZSBTRE1BIHF1ZXVlIHN0YXRzICovDQo+PiAJaWYgKChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0g
S0ZEX1FVRVVFX1RZUEVfU0RNQSkgfHwNCj4+IEBAIC01NDAsNiArNTM5LDggQEAgc3RhdGljIGlu
dCBkZXN0cm95X3F1ZXVlX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0s
DQo+PiAJCXBkZC0+c2RtYV9wYXN0X2FjdGl2aXR5X2NvdW50ZXIgKz0gc2RtYV92YWw7DQo+PiAJ
ZHFtX3VubG9jayhkcW0pOw0KPj4gDQo+PiArCW1xZF9tZ3ItPmZyZWVfbXFkKG1xZF9tZ3IsIHEt
Pm1xZCwgcS0+bXFkX21lbV9vYmopOw0KPj4gKw0KPj4gCXJldHVybiByZXR2YWw7DQo+PiB9DQo+
PiANCj4+IEBAIC0xNjI5LDcgKzE2MzAsNyBAQCBzdGF0aWMgYm9vbCBzZXRfY2FjaGVfbWVtb3J5
X3BvbGljeShzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSwNCj4+IHN0YXRpYyBpbnQg
cHJvY2Vzc190ZXJtaW5hdGlvbl9ub2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAq
ZHFtLA0KPj4gCQlzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNlICpxcGQpDQo+PiB7DQo+PiAtCXN0
cnVjdCBxdWV1ZSAqcSwgKm5leHQ7DQo+PiArCXN0cnVjdCBxdWV1ZSAqcTsNCj4+IAlzdHJ1Y3Qg
ZGV2aWNlX3Byb2Nlc3Nfbm9kZSAqY3VyLCAqbmV4dF9kcG47DQo+PiAJaW50IHJldHZhbCA9IDA7
DQo+PiAJYm9vbCBmb3VuZCA9IGZhbHNlOw0KPj4gQEAgLTE2MzcsMTIgKzE2MzgsMTkgQEAgc3Rh
dGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX25vY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9t
YW5hZ2VyICpkcW0sDQo+PiAJZHFtX2xvY2soZHFtKTsNCj4+IA0KPj4gCS8qIENsZWFyIGFsbCB1
c2VyIG1vZGUgcXVldWVzICovDQo+PiAtCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShxLCBuZXh0
LCAmcXBkLT5xdWV1ZXNfbGlzdCwgbGlzdCkgew0KPj4gKwl3aGlsZSAoIWxpc3RfZW1wdHkoJnFw
ZC0+cXVldWVzX2xpc3QpKSB7DQo+PiArCQlzdHJ1Y3QgbXFkX21hbmFnZXIgKm1xZF9tZ3I7DQo+
PiAJCWludCByZXQ7DQo+PiANCj4+ICsJCXEgPSBsaXN0X2ZpcnN0X2VudHJ5KCZxcGQtPnF1ZXVl
c19saXN0LCBzdHJ1Y3QgcXVldWUsIGxpc3QpOw0KPj4gKwkJbXFkX21nciA9IGRxbS0+bXFkX21n
cnNbZ2V0X21xZF90eXBlX2Zyb21fcXVldWVfdHlwZSgNCj4+ICsJCQkJcS0+cHJvcGVydGllcy50
eXBlKV07DQo+PiAJCXJldCA9IGRlc3Ryb3lfcXVldWVfbm9jcHNjaF9sb2NrZWQoZHFtLCBxcGQs
IHEpOw0KPj4gCQlpZiAocmV0KQ0KPj4gCQkJcmV0dmFsID0gcmV0Ow0KPj4gKwkJZHFtX3VubG9j
ayhkcW0pOw0KPj4gKwkJbXFkX21nci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBxLT5tcWRf
bWVtX29iaik7DQo+PiArCQlkcW1fbG9jayhkcW0pOw0KPiANCj4gVGhpcyBpcyB0aGUgY29ycmVj
dCB3YXkgdG8gY2xlYW4gdXAgdGhlIGxpc3Qgd2hlbiBkcm9wcGluZyB0aGUgZHFtLWxvY2sNCj4g
aW4gdGhlIG1pZGRsZS4gWGluaHVpLCB5b3UgY2FuIHVzZSB0aGUgc2FtZSBtZXRob2QgaW4NCj4g
cHJvY2Vzc190ZXJtaW5hdGlvbl9jcHNjaC4NCj4gDQoNCnllcywgdGhhdCBpcyB0aGUgcmlnaHQg
d2F5IHRvIHdhbGsgdGhyb3VnaCB0aGUgbGlzdC4gdGhhbmtzLg0KDQoNCj4gSSBiZWxpZXZlIHRo
ZSBzd2FwcGluZyBvZiB0aGUgcS0+bXFkIHdpdGggYSB0ZW1wb3JhcnkgdmFyaWFibGUgaXMgbm90
DQo+IG5lZWRlZC4gV2hlbiBmcmVlX21xZCBpcyBjYWxsZWQsIHRoZSBxdWV1ZSBpcyBubyBsb25n
ZXIgb24gdGhlDQo+IHFwZC0+cXVldWVzX2xpc3QsIHNvIGRlc3Ryb3lfcXVldWUgY2Fubm90IHJh
Y2Ugd2l0aCBpdC4gSWYgd2UgZW5zdXJlDQo+IHRoYXQgcXVldWVzIGFyZSBhbHdheXMgcmVtb3Zl
ZCBmcm9tIHRoZSBsaXN0IGJlZm9yZSBjYWxsaW5nIGZyZWVfbXFkLA0KPiBhbmQgdGhhdCBsaXN0
LXJlbW92YWwgaGFwcGVucyB1bmRlciB0aGUgZHFtX2xvY2ssIHRoZW4gdGhlcmUgc2hvdWxkIGJl
DQo+IG5vIHJpc2sgb2YgYSByYWNlIGNvbmRpdGlvbiB0aGF0IGNhdXNlcyBhIGRvdWJsZS1mcmVl
Lg0KPiANCg0Kbm8sIHRoZSBkb3VibGUgZnJlZSBleGlzdHMgYmVjYXVzZSBwcW1fZGVzdHJveV9x
dWV1ZSBmZXRjaCB0aGUgcXVldWUgZnJvbSBxaWQgYnkgZ2V0X3F1ZXVlX2J5X3FpZCgpDQp0aGUg
cmFjZSBpcyBsaWtlIGJlbG93Lg0KcHFtX2Rlc3Ryb3lfcXVldWUNCglnZXRfcXVldWVfYnlfcWlk
CQkJCXByb2Nlc3NfdGVybWluYXRpb25fY3BzY2gNCglkZXN0cm95X3F1ZXVlX2Nwc2NoDQoJCQkJ
CQkJCWxvY2sNCgkJCQkJCQkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlDQoJCQkJCQkJCQlsaXN0
X2RlbChxKQ0KCQkJCQkJCQl1bmxvY2sNCgkJCQkJCQkJZnJlZV9tcWQNCglsb2NrDQoJbGlzdF9k
ZWwocSkNCgl1bmxvY2sNCglmcmVlX21xZA0KCQ0KDQoNCiANCj4gUmVnYXJkcywNCj4gICBGZWxp
eA0KPiANCj4gDQo+PiAJfQ0KPj4gDQo+PiAJLyogVW5yZWdpc3RlciBwcm9jZXNzICovDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
