Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15571C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B166101E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B166101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3076ED16;
	Wed, 19 May 2021 11:09:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27E46ED16
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 11:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEQEY6qS7X1kDWyV46AgA7xvz5rRdtE7FkiDKda8DO/mFoaileFlp0DdjfcPjvSPvDjUTZBkMaGO5RtZvuYyTLpuV0SXY6YGdVvkap8KwTBFXC6YVqizwg7DviNCXrGxiHB3w564mw/cokeQTXqTeQxcJyWnqrDmMqYn5apbyHYy/1njcvH1e3h0KyB5wguiV3Yvuy+vzhaBHv7ri2IKHReo9VFhCksDRkIAHBYCbxMEcHi6NLgLRi4TphJSPAe31GvwMdNJGpXFYo/GpNYSiRbK7qEW6q40VtzPg5tZcGG8YyFUExMn/Af5uU7GYDVCqcB2MSfzoT+5tDZ9dJ2TfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvGTAf+DcKX+Qj0Pk/ptmkt+sm44rYJZCsnOH3hHUY=;
 b=hsF78DmOZ46mklSphHmU79bUurcbIWG1yvgXHFG95iBZXX8Kfo2X0DGOhggyI+jk1MNGt1a2LEf799VUXvESmSViuCroi1OjiBRipm0XduJCDzS6SDU76SqbZsQkc1uc5kLtq2wboVNf0j8W04Q/5KHpEbDmJ+2yqYl07nPOmDmePOgyDlxAOmbooa+9E21JlQKcvGZ1GaEvr220m1nGvlBhMsqWKpouPLRcQcTUHZ9byU3C6h+9goq+kW/70uVKF1kzxJU7P3P/IUvsZusaSsm1ONpml1MOZctK+D06WYYr+u5Grxu8Ls1oo63e1BV5F2kcfZlnLCGtxOAC/POAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvGTAf+DcKX+Qj0Pk/ptmkt+sm44rYJZCsnOH3hHUY=;
 b=sBLnKI3Ihqwstkcqk5Ii86NFZ+jARK8ajApWAqpVmhLZMZaLDXy4O4N31m22RiixNsUw1xUDISJTv5kVGOGp49dTtRGneUgL7Mf9+IazOsfVZLMdqTu2B2Tf/bR8bq8+2HEizbpwvLbUiTze07Xl9bSTvMx5f8h6Y4FDqw973Dk=
Received: from CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 11:08:57 +0000
Received: from CO6PR12MB5459.namprd12.prod.outlook.com
 ([fe80::99b0:6022:8a6d:ce2]) by CO6PR12MB5459.namprd12.prod.outlook.com
 ([fe80::99b0:6022:8a6d:ce2%4]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 11:08:57 +0000
From: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
Thread-Topic: [PATCH] drm/amdgpu: Increase tlb flush timeout for sriov
Thread-Index: AQHXTJHba6nbglaPY06ekmeH2Kyd+qrqlK8AgAAO69A=
Date: Wed, 19 May 2021 11:08:57 +0000
Message-ID: <CO6PR12MB54592ED7CDBD40D670A80361932B9@CO6PR12MB5459.namprd12.prod.outlook.com>
References: <20210519093209.888377-1-ChengZhe.Liu@amd.com>
 <b9d6e51c-b172-9627-799f-937c3e94851a@gmail.com>
In-Reply-To: <b9d6e51c-b172-9627-799f-937c3e94851a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-19T11:08:53Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bcd60a37-2d30-4a21-a9d6-f1c5e3e2c629;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16b487c3-784b-41f4-688f-08d91ab67f6d
x-ms-traffictypediagnostic: CO6PR12MB5442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54421FFE22202F65E9D8597D932B9@CO6PR12MB5442.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rtt6XI1/RiLq9DE/lwA6FZEBBPyRBa1WEumTKb0EyObGWuPnW0mvU3F7QOPNB7Gmu/sGMT8dxbOGlLFxUoOmP/5DZHZ/HXTjKwRmHUkM7D19QRYs7CeIq/so9D08Q1alLRo8VTQhXUnklICFh6QcHa7LM3GsfMtZXweXYCwo0vU4Ow5nELQh0sYo5d8Ih1sq2eyR4/dtDHMNHpQDO2zB5EcyVjCGJwLt9F65Ie6Mcd+B7tljjRrGBd2cNPynLRdhMM5BOq9ADOM16+9yddtObglI/jWRnYiIscZh7ph/vT1NxibxjfnrHAaRJroDL7HlMLNuwCQXWgCuu85q+wXOj9n2NnnNB9cM5gGRdQZbqSg/Jbok5hz+0LQWwqsw7niXgiMdPdbKOhJl24RCSg3LdYUzb9qB1M7m0d6hdnscYmdULhkH+hJKh5mm6LqTxkOm3y5MkkjXo4BXSI4s7x1DEpDuREGxuuadcGROfh0x41YrLVjyGasRV9GTaVxaejBTH0n1JNjVYXk/J+Fcjaw+2rBEH5qyfNeP2SO5nX6GuyF3tSq+1Z3CQbuGAMkQWusU9i0eAnVkhwlj4To38pcPpamcSJN7vu8JZrDpGPuY5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(7696005)(64756008)(53546011)(66446008)(6506007)(26005)(110136005)(122000001)(66556008)(5660300002)(66476007)(4326008)(186003)(316002)(38100700002)(52536014)(33656002)(54906003)(71200400001)(8936002)(2906002)(66574015)(9686003)(83380400001)(66946007)(86362001)(478600001)(8676002)(76116006)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkUwTXFNSWZkOUJ6SkJZQXRlYUpmK2pUbkhYUHNYbmtmUHNhdTZCUENISHEy?=
 =?utf-8?B?aHdac2hkWWxFVEg4eWdVV2F2R1pXM1hUcS9wU3dUQnFXQzdKSnJnZUJONXds?=
 =?utf-8?B?M3NJQk14QjdMWXVqMC9BcnEramYwTUs4bDRxWkIyTHRFdmdaZTN6U2JTMFRq?=
 =?utf-8?B?NnUwcWROQTUvMElyZEtxV25ZeVREVlkxSnpJMlZaNUpEQWR0b05pVnlRdHJL?=
 =?utf-8?B?S3RtSTE2QXZUS2UzOWVha0wzeWxXMjRhbTNCclpFYzJiYW03cUcveW1HZm0r?=
 =?utf-8?B?QzNNZHZyOHpoZzhFTTdvVFVvSG9YTnFjSlpyWS9FbCtsOGtiajRmcXFVWTY2?=
 =?utf-8?B?OE9rRXB1b2RRdytUeW1qSzNKZ294di95STdIU3RtcGUzV0VieDhSYmRXZ1pC?=
 =?utf-8?B?QmtFSU5aN2lOeFdmNWZhNjk1dlc0M0dEbGZDNXBZZjRvWklpUTJOSlpORFc3?=
 =?utf-8?B?dEdCWEtMcHZqZjJWd1ZWeXBtNVVYNmp3amdxNlpSNUgzVEN4dXBqZzZrMVVJ?=
 =?utf-8?B?ajg1TDJBbmR1VFpYdzUzdXBuNlE4akxTZFBxYy9VUi91SEU2SWNoeEp3UnR3?=
 =?utf-8?B?L21TU1ZOUDhqUEoxNWx1S29pblV6TndrZURidmlJM1V1TWVRQjNmUFdKWm40?=
 =?utf-8?B?emdsOGhqNE1qNGdWbjBWeWlRMlh6alBiUXdTS0VPZE5BZmRQQkpOMEFMU3Bx?=
 =?utf-8?B?RUpOUE1kOGErbktEb0orMS8xSGNUUGlnNmVMZTFyekp2Y0E4WEFkMGk3Yndm?=
 =?utf-8?B?OTdwS3NkVTM3dysrS0JIcGdlbjl4QUlvR1RlRUtxZVlNY2xkd2hIWFFNajZv?=
 =?utf-8?B?NzB6bXRneTNvcEQ4UVF4WTh5Y3c1akVSdXhpTzNndnNWQkhKaEZUUEhlcTUy?=
 =?utf-8?B?M2lzK0ZwTkNqWXA0bmZuUm5LdDFycTZ5UGx2WUFFbFlYMTBVS2VyRk95azRL?=
 =?utf-8?B?YVNMbjZGTUd5VTVhaExXZ3JLcHN4a2tpWEc5ekJNSXRDR0laQXB2WEdZdUVO?=
 =?utf-8?B?WTcreWFwaHUzT1FFMmJBMzBKTEpUT1UwSExMTVhNTHJ1cy9uSnhLdllDeW4y?=
 =?utf-8?B?VDYvenFlZlF4LzNHUmxkQkFHSDhJUnF0SUVUYkRXVHlNSGVjREpiU2t5OGFS?=
 =?utf-8?B?SkFtWlQ1eThhTXhteE1KZllkRzNycXozTklDQWZMSm9sMWNCc01iTXY3K01S?=
 =?utf-8?B?VDZuMFBla1IxK2QxODFaSEk3Uml4bGp5Rm95UXlxY3dFUk40TytYdzAxVytu?=
 =?utf-8?B?TWJjVkkrL3grcU12SFl5UHEvRTEvaVNNUnVNdU95OUxWNUtNWng0Y0NaRitC?=
 =?utf-8?B?NDdPcGJNSVlPSXYyczkrK2I3RDhJYW5BM0VkdGpqa0lVcWIrWjlXc3Raa01Y?=
 =?utf-8?B?TkpxK1VidEZ4b3pRVVRUWERUSUh0SmhqbG1LN2pLTTErZ01ITUFscUtIZlVv?=
 =?utf-8?B?UzkrNXMyeHhrNkNhalpOdXJTTlZ6UE4xOWpWYWdqMng5Q0VDTFU3SU1DUTdr?=
 =?utf-8?B?d0RiNW50NHRvUnJITktEWGdDTGZqQ3NhWWhwMEVoVTk1cGpwU2lDUktpNllU?=
 =?utf-8?B?RXlvb3F4OHdvWm5ha29ZQnc5RWZuU0o0ajVOTXJsUlVYT05hS2NmTGlOUjY5?=
 =?utf-8?B?QWxqTGQ3a0wxNVMxS3dEZGJnblEzRFFRY010eGVSS1ZMcXMyTUVBRW1HY3dz?=
 =?utf-8?B?Z2l4WlVGaXNMSVU4N2JqOVhyM0hmb3JSdUYzQXFJdUVNOG5TWDBQa1hiNXhl?=
 =?utf-8?Q?ykrUcYFlsg7PlrJIwQQUXQT8cE8D53tXCQP1A3f?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b487c3-784b-41f4-688f-08d91ab67f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 11:08:57.2837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x51UYFgW/Z1fTDkXLpho+gzE8TLynBc4UwCrgE0Bjm2t3Nv0IYAgW34AXLRvo0Bp1EPhaKn3dJ+DwLRTUvXtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen, 
 Horace" <Horace.Chen@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KV2Ugc3VwcG9ydCAxMiBWRiBhdCBtb3N0LiBJbiB3
b3JzdCBjYXNlLCB0aGUgZmlyc3QgMTEgYWxsIElETEUgZmFpbCBhbmQgZG8gRkxSLCBpdCB3aWxs
IG5lZWQgMTEgKiA1MDBtcyB0byBzd2l0Y2ggdG8gdGhlIDEybmQgVkYsDQpzbyBJIHNldCAxMiAq
IDUwMG1zICBmb3IgdGhlIHRpbWVvdXQuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4g
DQpTZW50OiBXZWRuZXNkYXksIE1heSAxOSwgMjAyMSA2OjA4IFBNDQpUbzogTGl1LCBDaGVuZyBa
aGUgPENoZW5nWmhlLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5Y
dUBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtldmluMS5XYW5nQGFtZC5jb20+OyBUdWlr
b3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogSW5jcmVhc2UgdGxiIGZsdXNoIHRpbWVvdXQg
Zm9yIHNyaW92DQoNCkFtIDE5LjA1LjIxIHVtIDExOjMyIHNjaHJpZWIgQ2hlbmd6aGUgTGl1Og0K
PiBXaGVuIHRoZXJlIGlzIDEyIFZGLCB3ZSBuZWVkIHRvIGluY3JlYXNlIHRoZSB0aW1lb3V0DQoN
Ck5BSywgNiBzZWNvbmRzIGlzIHdheSB0byBsb25nIHRvIHdhaXQgcG9sbGluZyBvbiBhIGZlbmNl
Lg0KDQpXaHkgc2hvdWxkIGFuIGludmFsaWRhdGlvbiB0YWtlIHRoYXQgbG9uZz8gVGhlIGVuZ2lu
ZSBhcmUgcGVyIFZGIGp1c3QgdG8gYXZvaWQgZXhhY3RseSB0aGF0IHByb2JsZW0uDQoNCkNocmlz
dGlhbi4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZ3poZSBMaXUgPENoZW5nWmhlLkxpdUBh
bWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAu
YyB8IDYgKysrKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAg
fCA2ICsrKysrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192MTBfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jDQo+
IGluZGV4IGYwMmRjOTA0ZTRjZi4uYTVmMDA1YzVkMGVjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiBAQCAtNDA0LDYgKzQwNCw3IEBAIHN0YXRpYyBpbnQg
Z21jX3YxMF8wX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQo+ICAgCXVpbnQzMl90IHNlcTsNCj4gICAJdWludDE2X3QgcXVlcmllZF9wYXNpZDsNCj4gICAJ
Ym9vbCByZXQ7DQo+ICsJdWludDMyX3Qgc3Jpb3ZfdXNlY190aW1lb3V0ID0gNjAwMDAwMDsgIC8q
IHdhaXQgZm9yIDEyICogNTAwbXMgZm9yIA0KPiArU1JJT1YgKi8NCj4gICAJc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nID0gJmFkZXYtPmdmeC5raXEucmluZzsNCj4gICAJc3RydWN0IGFtZGdwdV9r
aXEgKmtpcSA9ICZhZGV2LT5nZngua2lxOw0KPiAgIA0KPiBAQCAtNDIyLDcgKzQyMywxMCBAQCBz
dGF0aWMgaW50IGdtY192MTBfMF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCANCj4gYW1kZ3B1
X2RldmljZSAqYWRldiwNCj4gICANCj4gICAJCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsNCj4g
ICAJCXNwaW5fdW5sb2NrKCZhZGV2LT5nZngua2lxLnJpbmdfbG9jayk7DQo+IC0JCXIgPSBhbWRn
cHVfZmVuY2Vfd2FpdF9wb2xsaW5nKHJpbmcsIHNlcSwgYWRldi0+dXNlY190aW1lb3V0KTsNCj4g
KwkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKwkJCXIgPSBhbWRncHVfZmVuY2Vfd2Fp
dF9wb2xsaW5nKHJpbmcsIHNlcSwgc3Jpb3ZfdXNlY190aW1lb3V0KTsNCj4gKwkJZWxzZQ0KPiAr
CQkJciA9IGFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcocmluZywgc2VxLCBhZGV2LT51c2VjX3Rp
bWVvdXQpOw0KPiAgIAkJaWYgKHIgPCAxKSB7DQo+ICAgCQkJZGV2X2VycihhZGV2LT5kZXYsICJ3
YWl0IGZvciBraXEgZmVuY2UgZXJyb3I6ICVsZC5cbiIsIHIpOw0KPiAgIAkJCXJldHVybiAtRVRJ
TUU7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5j
IA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gaW5kZXggY2Vi
Mzk2OGQ4MzI2Li5lNGExOGQ4Zjc1YzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3Y5XzAuYw0KPiBAQCAtODU3LDYgKzg1Nyw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZmx1
c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAJdWludDMy
X3Qgc2VxOw0KPiAgIAl1aW50MTZfdCBxdWVyaWVkX3Bhc2lkOw0KPiAgIAlib29sIHJldDsNCj4g
Kwl1aW50MzJfdCBzcmlvdl91c2VjX3RpbWVvdXQgPSA2MDAwMDAwOyAgLyogd2FpdCBmb3IgMTIg
KiA1MDBtcyBmb3IgDQo+ICtTUklPViAqLw0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcg
PSAmYWRldi0+Z2Z4LmtpcS5yaW5nOw0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFk
ZXYtPmdmeC5raXE7DQo+ICAgDQo+IEBAIC04OTYsNyArODk3LDEwIEBAIHN0YXRpYyBpbnQgZ21j
X3Y5XzBfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgDQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQo+ICAgDQo+ICAgCQlhbWRncHVfcmluZ19jb21taXQocmluZyk7DQo+ICAgCQlzcGluX3VubG9j
aygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2spOw0KPiAtCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRf
cG9sbGluZyhyaW5nLCBzZXEsIGFkZXYtPnVzZWNfdGltZW91dCk7DQo+ICsJCWlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpDQo+ICsJCQlyID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhyaW5n
LCBzZXEsIHNyaW92X3VzZWNfdGltZW91dCk7DQo+ICsJCWVsc2UNCj4gKwkJCXIgPSBhbWRncHVf
ZmVuY2Vfd2FpdF9wb2xsaW5nKHJpbmcsIHNlcSwgYWRldi0+dXNlY190aW1lb3V0KTsNCj4gICAJ
CWlmIChyIDwgMSkgew0KPiAgIAkJCWRldl9lcnIoYWRldi0+ZGV2LCAid2FpdCBmb3Iga2lxIGZl
bmNlIGVycm9yOiAlbGQuXG4iLCByKTsNCj4gICAJCQl1cF9yZWFkKCZhZGV2LT5yZXNldF9zZW0p
Ow0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
