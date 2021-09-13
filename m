Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8DB60EFF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A8DB60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4176E0FC;
	Mon, 13 Sep 2021 06:55:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898DA6E0FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+M/0C2HGFVIYC+qpx9y7Ccz3uh2ClskQPqVzoA7Vuyd7Mrj51+CZa/2ZcCbhbZcpMyjnpkYYx3r8ACEVhSPffrMbbmT/NrbURxSPgWXebhdtJKsV+r11+ZO2/FhPoNO1Nl6sj5+cdVLZDJ5L50vvuYUZMnx09h7cfN9vR/gNJe0kT3hBHWtcZT1qdGI2PYcHYr1mPOWkINRp6oudymB/Tc0YK7lXHEZHyRjR37qIcVwz59bldkknulXdmDTpGJFIuLn7zEjXa9kMm00nZswAwLJvVZpr++k5qL5AdvTRKLZzNn04y9DCuFu4B5o2WK0KsvCjwkmNOJBwJ+9updXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lMQecZHFM89+gSNJAzpcDBUDHUDEx5197ZYjpMK4io8=;
 b=irC4RHwY/uMoQ3IibaOw4AiJ/Au1nKM9xcF+bE8gAERjI0sa+hmgQwQTQAtr8thsPHC/vBY8Ivt8gftJzdGWubpC9ib72TPCwF7XshXMdjkbHTla5alUgkpEbtkJUZGTBzWexMUaS8JjG/FVCx96nxY5wU/EoCNnWbFCe0o+7qx51z7086HP6P5nQxyvevAQCvrKk5RaKtfbRPj+Y7IGXZXcRVaJGV+O4tvURsNHGAr5SAhDZ2BxG1n4pgUZm7FtIbXxPEFu+Rez+rv8+88byoG0ySf8QVAkqetWitOpBVUFOgmg9Yde+If77kd4Fip/4hYfKJODGBxfdab0xMyMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMQecZHFM89+gSNJAzpcDBUDHUDEx5197ZYjpMK4io8=;
 b=d9ZH/jv2WfX2B913XWjlgj1judtEXv5zby9tTSvqYmnk14RUk5xoJrmczdExmxlSfdrgzJ96eVSvBVGFjVVJ9GMLuQ/DqS9lSkUuifYUamNNsSl3X8Oa4fiFsgxGJyWAmI8nRaPEdqJOLlpCvLmGTb+2G6U366ih9NRr3Vqledw=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 06:55:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:55:27 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IGEgcmFj?=
 =?utf-8?Q?e_of_IB_test?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBhIHJhY2Ugb2YgSUIg?=
 =?utf-8?Q?test?=
Thread-Index: AQHXprAdInfvMoj8KkCgP9SSUR/1jKuedKSAgAAe60uAAu2oAIAACS24
Date: Mon, 13 Sep 2021 06:55:27 +0000
Message-ID: <DM4PR12MB5165B03844A88C4E5BB3D3A087D99@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210911015513.3822-1-xinhui.pan@amd.com>
 <d983949c-6386-cb32-d361-c70efc206e2c@gmail.com>
 <DM4PR12MB5165351AA7C45CCDBD15AAC187D79@DM4PR12MB5165.namprd12.prod.outlook.com>
 <91fd7ad8-b4f0-b30e-9f3e-eab229b7375e@amd.com>
In-Reply-To: <91fd7ad8-b4f0-b30e-9f3e-eab229b7375e@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-13T06:55:24.130Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 07d06a93-17f7-a134-d30c-f7af0df9e3fc
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baeeb1b7-3a14-4c5f-0dce-08d976837814
x-ms-traffictypediagnostic: DM8PR12MB5447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB54476448641CFC266C84678587D99@DM8PR12MB5447.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2DVOj9FLj+031BeW04AnWPjmow7NTL+DYdQMZklpdfmwwBufv22Gt6T0HbBqEnd7h0d1dMy9wMf6PxfHxtpiCU9+pWnV2joeTE75Gs2YyJgDIGfNt0J6uGI1iHsB2o73RG4D0Re3MzMovb0AayOxcU7T5Uo6cESSfEni1WhoAp7ERiEUjFBHoQKvLg1mhzW68XgydSfVGLjVs5JL//G9rn0UxJTVeRpeyhSp4yRsr29f5uvHXmhx8yvMIOKtVrjlgO6cyEPkgY8SifYazr+diwuaE+iUKm6lXrMTJjxxgsqME3gPK9C9cFV8/SVCyeRyxg9n+rt4Eg7+GFa3CeNatSCtYUa0IXNWh86TDsTyJScMQ31RzgbiGpL8upMguylR07Fjff0GhoHtsAYX48VeO+9DmLsscjSnrwSBMDMFhanz7hsjbUIkyRX6aseKhWdzBSq3FWewseIADpfTYEsMbmi1TqCH1Wo3lMEGI/jFmTCLovC79nFLRMonjpy6jloi6PsCWQQ5uf8mlfX+bqpzy8kF3Uq2HIEq8mE34O7xJfpZp00dqEAg4K5IxWbnh7M0ODalTfE/jevpUhd/yNwTGHtrBs6D2niIMIodIZWRNCx6VswKstKG44aD2PlG4sEbNnzmmKUuAXwExxkihwpa61+KKGZ3SAduXVp68aCioFg7pAfAUVRSMKNYHYnxBh9wOidqmGFK/vXB2W3I3mA4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(33656002)(110136005)(6506007)(66574015)(224303003)(83380400001)(38070700005)(9686003)(8936002)(478600001)(186003)(7696005)(2906002)(66946007)(71200400001)(55016002)(76116006)(64756008)(4326008)(86362001)(91956017)(52536014)(26005)(38100700002)(122000001)(66446008)(5660300002)(66476007)(66556008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emZkd1lmclMyTFFSMkxTUVlkUVZWMjB2aEo3SU9iZFlNWUhQbjNpMFBjeFlS?=
 =?utf-8?B?b2FEakpManJkRzlqOC96RlcrN3NKZjE4WVZpOVlnNzFndEJQUTNPVkNGNWpW?=
 =?utf-8?B?QTBBYk1EMEtwMmRDMlBuV3lCVmJKeXNkRHdZVlhPUkYvMUV2bTJwbmpKZGNX?=
 =?utf-8?B?VCtRcVNIV3ZFN2JuNTRoSmNyTzBrYVEwUDYrUWFYajFXa0M3TjcxUlpHOHJV?=
 =?utf-8?B?NHc5MkIzZ3hYUkJmdlE4V21ieUdEOC8wZTJrYm1LMjBkY1FNRUlLVXU0RVZS?=
 =?utf-8?B?S0JUZ2hNSDZkYmhTVW1XcHBCZWxxZWc5RDVLdEk1bTRqRjV1V0p6eUFkK1pw?=
 =?utf-8?B?eXNyemVEVlNiaXhLTWRIWDhFU3h1L1M3OC9sYkN5aHkvSnROQld6UDlsYWZt?=
 =?utf-8?B?NC9YT0dtTVZJKzZvVEhJc0RNR1hBRGhNSFE2dVkzN2V4R0QwYnAwT0U3NUlp?=
 =?utf-8?B?VXZqZjJDU0N0dXlxOStJbVhpSVhDWkpuMXlwSEFFb01XVjdwNnI5UW9mcEYw?=
 =?utf-8?B?MnZ4ZlZuREhpWng3WVV2NVNaSFR3bVNLVldUOTcvZmF0Y3I5MmxoVDdEdm81?=
 =?utf-8?B?aFd1ajJJYVV0ays2SUxGY3BvYlpYWEUyR3Q5cHNQVi82NXk3NFlSclFEc0VF?=
 =?utf-8?B?OUlwbzk4bnRzcE50U0tGZHl6MUJON2YwWUliMjczdFVHTjBsNnhXYW1XclhH?=
 =?utf-8?B?ZVY4clJoalZxZytpUlhCVTVEbFR2MnB0T1ZaL0xTQS9Ha2ZPNFh6OXdlMGhs?=
 =?utf-8?B?czFJQXBsKzNLczdMNmpFUVNwbGxjamdKeFQyWVVLL25qd0VaWW1nOERrOWZr?=
 =?utf-8?B?UjJaRUhramhqMnZ5c0dDc0lVRUlxeHB1V0ZjaUtHODlYVExoWW9ueUQzWUxI?=
 =?utf-8?B?NlFHampPRGRKc3N3U2V6WVhUUWFBRmZBNGN5NHliSXJWS1lPMFhXUGp5TkV5?=
 =?utf-8?B?czh2Z2J4dzE3ck1sblhXMERKWno5VTQ1V0hLUkxtekp0bURWcE43VjJWaXFR?=
 =?utf-8?B?bDdYREZJT05RZE5vNk9qM0lRWmJoRkJveC84WnhhRXk3elQ3dnl6dnJBVFFL?=
 =?utf-8?B?QmQxZk1iUmZQV2pmMGk5R0R1SnlncnZHRitXdTVqUDdZMktIQVp1YU1Ib0Jy?=
 =?utf-8?B?Vm5OcFV6Nk9GcVNtWlh3VmpWMFBlZ3JUWDZPektsMXUvSk5KU3Y3Ym5nVUly?=
 =?utf-8?B?TWZBeUl0dDV4ajg4cUNPVW5Ld1JZT0s2cGhIL1RqNVMveitxQWxYZmpacjBQ?=
 =?utf-8?B?UVVJWjdpUkdVN0tQei9vRWhLR1JFZ0JLMzJYY1g5UzYvU3JzSzArcUtUYWdV?=
 =?utf-8?B?alhuRzd5R2F1N21abkh0TGFZVTJwRGUxTGJFd1dDK3VzV3ZzbWRxWWxWeld2?=
 =?utf-8?B?aEdlWmlXVUFXY2kva2RxNXN4bW5QYnlXczBiZSsrNXc4Qm1pRHA4NE5seEx5?=
 =?utf-8?B?Z01GaExObzA3WE9saWwwSGVBYWxQaWtNRzB1UnBsM2NqR0Q3b082VU5xVklJ?=
 =?utf-8?B?NEhyWE4xWTRiejRmQ1JRdmJwTmQva21SUlpOWHFCNHd5amFNZC9DQm54SEVp?=
 =?utf-8?B?bVo5US9RaDRvOEhOaWc1NlpKdTN0R0lZTDBUYlpjdGFERVdQVEZ3Wk4yQUtH?=
 =?utf-8?B?b2NsSWNJMjlKYUFDRnl1TTZ3WTFJSzUzVm53K0M3TDlKVjlTcjhJVjllVm1K?=
 =?utf-8?B?cEFnWFRmOGFiZ0xaQzFuaG9vNWt3eGt5TkFzSDFjR1gzQzdsS2FlMFVieUll?=
 =?utf-8?Q?kY0gfVVLquRfANiszgoyPlILTrkdptUN2LJq9GE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baeeb1b7-3a14-4c5f-0dce-08d976837814
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 06:55:27.5844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D21JISzhaVWVQTo7N8RMDw0FM+b2CbzSaQ27cDRD6g7r5Jz/8E5EA3rxwoa6sTnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhlc2UgSUIgdGVzdHMgYXJlIGFsbCB1c2luZyBk
aXJlY3QgSUIgc3VibWlzc2lvbiBpbmNsdWRpbmcgdGhlIGRlbGF5ZWQgaW5pdCB3b3JrLg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K5Y+R5Lu25Lq6OiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K5Y+R6YCB5pe26Ze0OiAyMDIx
5bm0OeaciDEz5pelIDE0OjE5DQrmlLbku7bkuro6IFBhbiwgWGluaHVpOyBDaHJpc3RpYW4gS8O2
bmlnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K5oqE6YCBOiBEZXVjaGVyLCBBbGV4
YW5kZXINCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggYSByYWNl
IG9mIElCIHRlc3QNCg0KV2VsbCBpcyB0aGUgZGVsYXllZCBpbml0IHdvcmsgdXNpbmcgZGlyZWN0
IHN1Ym1pc3Npb24gb3Igc3VibWlzc2lvbg0KdGhyb3VnaCB0aGUgc2NoZWR1bGVyPw0KDQpJZiB0
aGUgbGF0ZXIgd2UgaGF2ZSB0aGUgZG93bl93cml0ZSBvZiB0aGUgcmVzZXQgc2VtYXBob3JlIHB1
bGxlZCBpbg0KdGhyb3VnaCB0aGUgc2NoZWR1bGVyIGRlcGVuZGVuY3kuDQoNCkFueXdheSBqdXN0
IGhhdmluZyB0aGUgc3luYyBiZWZvcmUgdGFraW5nIHRoZSBsb2NrIHNob3VsZCB3b3JrLg0KDQpD
aHJpc3RpYW4uDQoNCkFtIDExLjA5LjIxIHVtIDEyOjE4IHNjaHJpZWIgUGFuLCBYaW5odWk6DQo+
IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+DQo+IEZvciB0aGUgcG9zc2libGUgZGVhZGxvY2ss
IHdlIGNhbiBqdXN0IG1vdmUgZmx1c2hfZGVsYXllZF93b3JrIGFib3ZlIGRvd25fd3JpdGUuIG5v
dCBhIGJpZyB0aGluZy4NCj4gQnV0IEkgYW0gbm90IGF3YXJlIHdoeSBkZWxheWVkIGluaXQgd29y
ayB3b3VsZCB0cnkgdG8gbG9jayByZXNldF9zZW0uDQo+DQo+IGRlbGF5ZWQgaW5pdCB3b3JrIGlz
IGVucXVldWVkIHdoZW4gZGV2aWNlIHJlc3VtZS4gSXQgY2FsbHMgYW1kZ3B1X2liX3JpbmdfdGVz
dHMgZGlyZWN0bHkuIFdlIG5lZWQgb25lIHN5bmMgbWV0aG9kLg0KPiBCdXQgSSBzZWUgZGV2aWNl
IHJlc3VtZSBpdHNlbGYgd291ZCBmbHVzaCBpdC4gU28gdGhlcmUgaXMgbm8gcmFjZSBiZXR3ZWVu
IHRoZW0gYXMgdXNlcnNwYWNlIGlzIHN0aWxsIGZyZWV6ZWQuDQo+DQo+IEkgd2lsbCBkcm9wIHRo
aXMgZmx1c2ggaW4gVjIuDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4g5Y+R5Lu25Lq6OiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIx5bm0OeaciDEx5pelIDE1OjQ1DQo+IOaU
tuS7tuS6ujogUGFuLCBYaW5odWk7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IOaK
hOmAgTogRGV1Y2hlciwgQWxleGFuZGVyOyBLb2VuaWcsIENocmlzdGlhbg0KPiDkuLvpopg6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBhIHJhY2Ugb2YgSUIgdGVzdA0KPg0KPg0KPg0KPiBB
bSAxMS4wOS4yMSB1bSAwMzo1NSBzY2hyaWViIHhpbmh1aSBwYW46DQo+PiBEaXJlY3QgSUIgc3Vi
bWlzc2lvbiBzaG91bGQgYmUgZXhjbHVzaXZlLiBTbyB1c2Ugd3JpdGUgbG9jay4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQo+PiAtLS0NCj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA5ICsrKysr
KystLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMN
Cj4+IGluZGV4IDE5MzIzYjRjY2U3Yi4uYWNiZTAyOTI4NzkxIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4gQEAgLTEzNTgsMTAgKzEz
NTgsMTUgQEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc190ZXN0X2liX3Nob3coc3RydWN0IHNl
cV9maWxlICptLCB2b2lkICp1bnVzZWQpDQo+PiAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAvKiBB
dm9pZCBhY2NpZGVudGx5IHVucGFya2luZyB0aGUgc2NoZWQgdGhyZWFkIGR1cmluZyBHUFUgcmVz
ZXQgKi8NCj4+IC0gICAgIHIgPSBkb3duX3JlYWRfa2lsbGFibGUoJmFkZXYtPnJlc2V0X3NlbSk7
DQo+PiArICAgICByID0gZG93bl93cml0ZV9raWxsYWJsZSgmYWRldi0+cmVzZXRfc2VtKTsNCj4+
ICAgICAgICBpZiAocikNCj4+ICAgICAgICAgICAgICAgIHJldHVybiByOw0KPj4NCj4+ICsgICAg
IC8qIEF2b2lkIGNvbmN1cnJlbnRseSBJQiB0ZXN0IGJ1dCBub3QgY2FuY2VsIGl0IGFzIEkgZG9u
J3Qga25vdyB3aGV0aGVyIHdlDQo+PiArICAgICAgKiB3b3VsZCBhZGQgbW9yZSBjb2RlIGluIHRo
ZSBkZWxheWVkIGluaXQgd29yay4NCj4+ICsgICAgICAqLw0KPj4gKyAgICAgZmx1c2hfZGVsYXll
ZF93b3JrKCZhZGV2LT5kZWxheWVkX2luaXRfd29yayk7DQo+PiArDQo+IFRoYXQgd29uJ3Qgd29y
ay4gSXQncyBhdCBsZWFzdCB0aGVvcmV0aWNhbCBwb3NzaWJsZSB0aGF0IHRoZSBkZWxheWVkDQo+
IGluaXQgd29yayB3YWl0cyBmb3IgdGhlIHJlc2V0X3NlbSB3aGljaCB3ZSBhcmUgaG9sZGluZyBo
ZXJlLg0KPg0KPiBWZXJ5IHVubGlrZWx5IHRvIGhhcHBlbiwgYnV0IGxvY2tkZXAgbWlnaHQgYmUg
YWJsZSB0byBwb2ludCB0aGF0IG91dA0KPiB3aXRoIGEgbmljZSBiYWNrdHJhY2UgaW4gdGhlIGxv
Z3MuDQo+DQo+IE9uIHRoZSBvdGhlciBoYW5kIGRlbGF5ZWQgaW5pdCB3b3JrIGFuZCBkaXJlY3Qg
SUIgdGVzdCB0aHJvdWdoIHRoaXMNCj4gaW50ZXJmYWNlIHNob3VsZCB3b3JrIGF0IHRoZSBzYW1l
IHRpbWUsIHNvIEkgd291bGQganVzdCBkcm9wIGl0Lg0KPg0KPiBDaHJpc3RpYW4uDQo+DQo+PiAg
ICAgICAgLyogaG9sZCBvbiB0aGUgc2NoZWR1bGVyICovDQo+PiAgICAgICAgZm9yIChpID0gMDsg
aSA8IEFNREdQVV9NQVhfUklOR1M7IGkrKykgew0KPj4gICAgICAgICAgICAgICAgc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07DQo+PiBAQCAtMTM4Nyw3ICsxMzkyLDcg
QEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc190ZXN0X2liX3Nob3coc3RydWN0IHNlcV9maWxl
ICptLCB2b2lkICp1bnVzZWQpDQo+PiAgICAgICAgICAgICAgICBrdGhyZWFkX3VucGFyayhyaW5n
LT5zY2hlZC50aHJlYWQpOw0KPj4gICAgICAgIH0NCj4+DQo+PiAtICAgICB1cF9yZWFkKCZhZGV2
LT5yZXNldF9zZW0pOw0KPj4gKyAgICAgdXBfd3JpdGUoJmFkZXYtPnJlc2V0X3NlbSk7DQo+Pg0K
Pj4gICAgICAgIHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5kZXYpOw0KPj4gICAgICAg
IHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldi0+ZGV2KTsNCg0K
