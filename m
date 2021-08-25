Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE9EC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54CC61176
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B54CC61176
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F29F89D67;
	Wed, 25 Aug 2021 08:39:10 +0000 (UTC)
X-Greylist: delayed 1139 seconds by postgrey-1.36 at gabe;
 Wed, 25 Aug 2021 08:39:08 UTC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700B89D67
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 08:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/tB3JbHKO70OBwHZhywpKsJeRBsoj0A7R7SKtJezOITuDKk5ztrtL3SAYsrerU8I1LI7a2KFIYL12FUoiYQmaYONtfVAYOjIgrJum6TAo6ejXNQqAHFJlypdY1dJ3slIxAV3fOxT1PQEyjgAWvHY18lU+5tms2pZs1AsVdJWYdNIKqUqSXyZ2LUeIKQQ0GRh5J/K1mzPbze8JvLj3cxZx+IFh0p+9WJ9YQ7XldUkD/+PYbvFKABpZZShe4Crr5yENe1HbzDesDJ+VYGPU5m/CEy2Dwm0lNxnhOMfjRnV3BtBy8nCu3daTwpibjAq6TqyTxPnaD0FvlvPNjr7IeB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64wByvwRp8aaYftcmENjqKEz7Ocp5Q2CbXTVmRfl0ko=;
 b=AhqUvI6CX/WBaj7e3LIeRwh3GfUF4zIUwe1L383eKWXzTzdOEa/NKrayrVzMqwRRwNsRODohHfUKzX77b2WZ6POkeOkOTPihu2f7FofU51Lq5ofngb9zqf2Tng0ao71DW0rlaSh2ZctfjuMmSq9ATkSEZooqDoiyhz8Sls/KyhJS8gxVg2dsME+P1SM/Bd/TZj8qHqGi7tAePOFX2elPa9tz9fMle2EbS/Aa5vqTkGHNSw2TyDetmm50ePyGP1/oz9Qg8llZFTD6o06beGu9wlabg05h3hf90clwPRoUZL0bj9vu0TpFf+HHNZKoWFdCX9nuuy3ligC3SOmQD7GEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64wByvwRp8aaYftcmENjqKEz7Ocp5Q2CbXTVmRfl0ko=;
 b=uDMahPEbfbyHY3v9APsCGZeyaqztz1AtZfCNHrvsxt6qPXrmOndEBVuLU98PwYdMtpVorwgasxga3mM9cudHioi4itl7maQzw8UfBADtLrUhgiaJ+/yIki/l6Fsr9qjICu0/L7dGBUIODf4jTY0rK72t9L5Yp8zev5f7Fpu8uM8=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (20.178.196.138) by
 BY5PR12MB4936.namprd12.prod.outlook.com (52.135.40.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Wed, 25 Aug 2021 08:04:36 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::68c9:ebec:60ec:f7e8]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::68c9:ebec:60ec:f7e8%4]) with mapi id 15.20.4457.017; Wed, 25 Aug 2021
 08:04:36 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
Thread-Topic: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
Thread-Index: AQHXmYUKewvhqTD+Y0uHRugcnYW7/KuD15oAgAADJ6A=
Date: Wed, 25 Aug 2021 08:04:36 +0000
Message-ID: <BYAPR12MB3416E666FED01B9C65A6CFBDC1C69@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210825074424.170859-1-yifan1.zhang@amd.com>
 <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
In-Reply-To: <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-25T08:04:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2a76dec6-dd12-43fd-a3b5-b2a4329ebfee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03bc6c58-4dec-41d8-7ec8-08d9679efb02
x-ms-traffictypediagnostic: BY5PR12MB4936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4936BF7B6D880A0EF265354CC1C69@BY5PR12MB4936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5dY8ZU7dkI2cyK03/6I7vZhPcrcZud97Z1I3y20rvQqrAjfWiFUOa097QVHB7NF0B2yl70rgT8LU38EQxj/hLB4yH8g40QksRtADAKiliXYM3ME/zA7MbyojAVHsVbtStIqeU+CHDrVB2AArMTxTiyPvXi3o2Em+oPKnQN55MNhbazeGy8Ik5fYxM2+PzkI+gXXP8R4m28w2eorQ3MloHleaOV3Ib+rCkbb6AN12P9QmPfpLaqKaho7EaJZIUxl3jH3rVr32Ji4jZmwalb8CXqNRy/bjhDxyRDbEgI/5dtA6qAC96XB97a1Cjx2/wVGh9oh+34eJ73P6r61vIu7n9fXi0YX2dc/XmtnyVmCfNHTCyHp1m71Ohn2bNRNsF9p5eZgGHcnKX/6EYHVh2L6zAyJSCgxBUtLTwf94RatnAVlUQLQYWAmqLyejONsydGKTjkw6Py9UxZdTpYahwfM/3/aQg7gmIMmjimeKLawa2MRWIYCRiBN9acoVO+LpiP5PjXkzEuyyly+3NBX34QqMJ7dgVJnpefSj42jRrVI1RWY2wVyizwdoHRnV/XoIfZybcj9v+gPHhawlyMcgKAeN8TQllvBQlr7kCtFr035KVmkqdpHeJeHauNdGMdFeGCfpwBwaylRzkwaFWpmpUSW/Bugbu5uMaktYLf0axpVuKIHAOfEpuYXOjtZEDmWUPDrgAsJJ7SMCSdcPccjrs3cDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(8676002)(76116006)(71200400001)(64756008)(52536014)(186003)(66556008)(66446008)(2906002)(66476007)(66946007)(55016002)(110136005)(5660300002)(9686003)(86362001)(26005)(6506007)(83380400001)(53546011)(38100700002)(33656002)(122000001)(6636002)(316002)(478600001)(7696005)(8936002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWxxa1ZHRy9IODBsRTh1c0JwdTlnU0NsODBqYWZ4WTg0NHNsT28xY0thZWJO?=
 =?utf-8?B?YTllUlFqYmxXbXNuRnJjdHNtTEtMYjZTSE9KVjlNMjJrNXF3MmdHcnRwcWll?=
 =?utf-8?B?d3VTT1RWTllKL0JjY014THFSVW16WklRRVRzaGo1UFMxSTdoQTMvSHhkbjdt?=
 =?utf-8?B?bnV0Z2QzQlp2M2I3eVM4c245TklxWi9jVjQxMGRPZWU5eTd6dUROc0Znamtu?=
 =?utf-8?B?TWg0S2Joc01NODF5WDIyNTFqQzlVL2RQY1ZmQ25WN3JEOWJDcGFwc3IyZXRh?=
 =?utf-8?B?SjRDUjlVcDBqTUkwS1Q3Ri9EbURzRmNmRUZiQXRHVzhzblpQWTkzS0k2RGtq?=
 =?utf-8?B?d25lSVJycmZnOTJNc1Q0Wks5dXpOVXdQaFlNT2VRL1NrMXdHcjlCajVzOGU0?=
 =?utf-8?B?dkFPSlBqaURXSXNDalFVQzg5L2J0OUl6YTNQbXc1dVJQeWdQYTJ2SFQwKzA0?=
 =?utf-8?B?eWdWTXBNeFF5VXRrZ005cUxtZHFkUmFOM1EyQVhlTk84WWhxRExGbTlicy9C?=
 =?utf-8?B?Q1JoWGNkVGJjWVpEbUNGNzlWT2pqTTZxVXg1ZzJEMkpidXJ1bnlRdk16aFhm?=
 =?utf-8?B?WVVpQ05mdVlTdkdyQXZOdTRjd0Q3S3A2ZjFheXRFN21KaVBGT2xVZExrZklu?=
 =?utf-8?B?OXVFSitJSmphcUx2VXh4MTVUNFFJTEtmaCtsYnB5Y2FVeVB2S2R4Rm5kWVVC?=
 =?utf-8?B?N0pBWTNPN2kxMUVFY3kwZmZKNm9NZVZ5WCtaVXlsU0hlV09FeUxwYkVONW1B?=
 =?utf-8?B?Nys5VDRWQ09lSFRadWNxNnprWTBhT0VyNTNIeUQveDNBdWI0MklYemdJbndJ?=
 =?utf-8?B?K2Q2bmVvSFMvVFpSaW9IV1Nrcit0RzQySzVoNlcrek1wdXN4bzFBNmlRbEhV?=
 =?utf-8?B?MU1yTkthdzRWV2tQcFZjSXcwYlZLeGgzaWZ2VEs0R21jVEgwRXB5Nlhsa3lw?=
 =?utf-8?B?M2FmdkhNbXFNZlVRNWc3NG00WmdJTmg5MldIbkR3UTVoVGN4aWRIUE8xaXZJ?=
 =?utf-8?B?YU92QnpKMUJuNTJKa3V0WDVWY1N3R3lmVXJlQ1lVT291VVc1cFFiYUJzMnBO?=
 =?utf-8?B?NG1ldDk4MWxNT3dvU2o1Z2NZNmJuYnhvSENGNEdNbXpCS1o2Tk8xcWdUZUE2?=
 =?utf-8?B?dnd0OFkzWS9YUHlJVGtVaVRnT0VTaEZCU2gyb2haSGdmOWFLbTBvRGRTTGo5?=
 =?utf-8?B?bDdsNXByNE1BaUVEMjRHSDdHa1Njbzg5MmFJdEhheVBhOFBYTlJ1UmNrT3VG?=
 =?utf-8?B?MlE0MzYvRUxaT0doemY2Qi9EQ0lkNlRtYnNuS1BFd2JDVHF3MCtlVVQvcEx6?=
 =?utf-8?B?bVZkci82NjZqbGMrYnVvK2FaMGl4N0RDai9ZQ1VZZ0pxNnhCamt4cmRzbWxQ?=
 =?utf-8?B?eHFlUkc1RmNqN3RSL2RTVGkzaWRHa1RTZlR5bXlHckdtTW00Z1BrSS9leU1t?=
 =?utf-8?B?bllhbThzWXRBbDEyY0FkRzFwM0ovdmVreFBLTDJ2N3kraHZrc2Z3b3FjanVH?=
 =?utf-8?B?S0dnN25xckJOdTlDa0VvdnZFb1JpajB4UlJxTTF2bTF4eWRDSmN6ay9lVEN6?=
 =?utf-8?B?UEUvOXlqVm0vV0RFQ20wUkhtMERJd2dPNS9GYlhrQ2l4WDBoRnkzeXlOZGU0?=
 =?utf-8?B?OXRyN2FkMzVjNlI0ZElkSU02b2xaTlVoNldLcDQ1T0Y5YXV6RjZHbTI5b2tC?=
 =?utf-8?B?K01TOWNnRGIyMnVvMG0yYWRLK0JZRC9vbEdTUW5YV1g3SVNJOUVZakhpMTBa?=
 =?utf-8?Q?fPishmQPmlDJqDtkWNcnKYVHwrQWPHwGqS83Ra6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc6c58-4dec-41d8-7ec8-08d9679efb02
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 08:04:36.2035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17nvwTRaxxNjmzUyGWWXkBc8/OSzCJcin1CD1m8mEjrxf2VrZBs/gRTi78YHo5Vj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuLA0KDQpPSy4gVGhlbiBJIHRoaW5rIHdlIHNob3VsZCBt
b2RpZnkgdGhlIGRvY3VtZW50ICBmb3IgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfcGluX2RvbWFp
biBzaW5jZSBpdCBpcyBub3Qgb25seSBmb3IgZGlzcGxheSBzY2Fub3V0LCByaWdodCA/DQoNCi8q
Kg0KICAqIGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3Bpbl9kb21haW4gLSBnZXQgcHJlZmVycmVk
IGRvbWFpbiBmb3Igc2Nhbm91dA0KICAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVjdA0KICAq
IEBkb21haW46IGFsbG93ZWQgOnJlZjpgbWVtb3J5IGRvbWFpbnMgPGFtZGdwdV9tZW1vcnlfZG9t
YWlucz5gDQogICoNCiAgKiBSZXR1cm5zOg0KICAqIFdoaWNoIG9mIHRoZSBhbGxvd2VkIGRvbWFp
bnMgaXMgcHJlZmVycmVkIGZvciBwaW5uaW5nIHRoZSBCTyBmb3Igc2Nhbm91dC4NCiAgKi8NCiB1
aW50MzJfdCBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9tYWluKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGRvbWFpbikN
CiB7DQogICAgIGlmIChkb21haW4gPT0gKEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVf
R0VNX0RPTUFJTl9HVFQpKSB7DQogICAgICAgICBkb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9W
UkFNOw0KICAgICAgICAgaWYgKGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSA8PSBBTURHUFVfU0df
VEhSRVNIT0xEKQ0KICAgICAgICAgICAgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsN
CiAgICAgfQ0KICAgICByZXR1cm4gZG9tYWluOw0KIH0NCg0KQlJzLA0KWWlmYW4NCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI1LCAyMDIxIDM6NDcgUE0N
ClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlbW92ZSBwcmVmZXJyZWQg
ZG9tYWluIGp1ZGdlbWVudCBpbiBwdC9wZCBjcmVhdGlvbg0KDQpBbSAyNS4wOC4yMSB1bSAwOTo0
NCBzY2hyaWViIFlpZmFuIFpoYW5nOg0KPiBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9t
YWluIHdhcyBhZGRlZCB0byBoYW5kbGUgc3lzdGVtIG1lbW9yeSANCj4gcGFnZSB0YWJsZXMuIFNp
bmNlIHN5c3RlbSBtZW1vcnkgcHQvcGQgaXMgZGlzYWJsZWQgbm93LCByZW1vdmUgDQo+IHByZWZl
cnJlZCBkb21haW4ganVkZ2VtZW50IHRvIGF2b2lkIGNvbmZ1c2lvbi4NCg0KV2VsbCBJIHdvdWxk
IHJhdGhlciBrZWVwIHRoYXQgYW5kIGVuYWJsZSBzeXN0ZW0gbWVtb3J5IHBhZ2UgdGFibGVzIGFn
YWluLg0KDQpXZSBzaG91bGQgcHJvYmFibHkgYWRkIElPTU1VIGNoZWNrcyB0bw0KYW1kZ3B1X2Jv
X2dldF9wcmVmZXJyZWRfcGluX2RvbWFpbigpIGFueXdheS4gTXkgbGFzdCBzdGF0dXMgaXMgdGhh
dCB0aGlzIGhhcyBiZWVuIGNhdXNpbmcgcHJvYmxlbXMgd2l0aCBEQyBhcyB3ZWxsLg0KDQpBbGV4
LCB3aGF0IGRvIHlvdSB0aGluaz8NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSAtDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jDQo+IGluZGV4IDBiODkzYWEyMWZmZS4uNzY0ODIyZWRiYTE4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBAQCAtOTI2LDcgKzkyNiw2
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3B0X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwNCj4gICAJYnAuc2l6ZSA9IGFtZGdwdV92bV9ib19zaXplKGFkZXYsIGxldmVsKTsNCj4g
ICAJYnAuYnl0ZV9hbGlnbiA9IEFNREdQVV9HUFVfUEFHRV9TSVpFOw0KPiAgIAlicC5kb21haW4g
PSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOw0KPiAtCWJwLmRvbWFpbiA9IGFtZGdwdV9ib19nZXRf
cHJlZmVycmVkX3Bpbl9kb21haW4oYWRldiwgYnAuZG9tYWluKTsNCj4gICAJYnAuZmxhZ3MgPSBB
TURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgfA0KPiAgIAkJQU1ER1BVX0dFTV9DUkVB
VEVfQ1BVX0dUVF9VU1dDOw0KPiAgIA0K
