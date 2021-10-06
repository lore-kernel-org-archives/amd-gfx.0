Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA85C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47A56113A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E47A56113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F456ED98;
	Wed,  6 Oct 2021 10:14:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69A96ED98
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 10:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqS8IAdttFKWoh1vY7Ty2VYBtXNBARXgYzb4ZNtORfEV5O758I+pv17ptqaI1iNnNt9cM15heV3SGPjqiH/qnkd4F4M/dwiPg9ij+9f3t5U9vrPUDvcKiIg6g+SamtHduQEUmkpQzm77FBLHSwbxh7tkpJWRs36a+xu9L9prCxvZrRPQ9YjBl1KQRlp6WMJGpUblCZb8qd7aE/NYoUZhlD/bOpzTT7QuqGH6VE4ykJkKRmYwRW7OddgRormz6voG+NAkBAY/XmWkNooKKLYS2MRax0w2AtmtWm07nc2ubbQ2jvqpc0bmpDYMLItE+p5YNdpppWeul/QvCHgNzk9WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SgILdItIJ/91SrTc7A/a9RQOfwrAvxKrlK2b2l6vGg=;
 b=U74sM2i6aPOggYhAYjaryPImNuxErcnqSVIl5+LS1H+jdrC7QLmtJ4r7EpmiybpeCm/x/9joGC8pPOF/9FSQUTqZbbHnQc/NXFazI3E6bNye5mBmLHUdH1Q9vZrehh9f//xB1UwH9qdJLmgM98+D78jLRXDl6bCDn0D6nG3iz6odPA0LVkhrR00w0+LQ9Y5+Rj4ti+RHin3VLsgeUfCy3SBSs9WKPgqTgNytFJeO4zg3nyZ2oao7xr64XPu3yItuMTW6hB/N/z1QkrNI5r8/DKJsaFIwJVUTgHZqqJxJnhsyUJrrqUywKNH6uPLGdVszgME+rTXGDILWCiOFJVoK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SgILdItIJ/91SrTc7A/a9RQOfwrAvxKrlK2b2l6vGg=;
 b=jldbXLy+GSYrJPa52umoepmjYEIklt/VRnkGtQzM7BsIBZrVQYRpkX7T7mWIVw5vQkvfaUZuKGemHbHqe3JIcLTDdfE0t3vPdNvhnZYVf2+xW5Qj/wMNs75ss1Fi4DTOAh+weMeck+dZBuv+oVIS+ZbsgTWXSkvL2zPkawoQkrI=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 10:14:40 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c%2]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 10:14:40 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "Shih, Jude" <Jude.Shih@amd.com>, "Kizito, Jimmy" <Jimmy.Kizito@amd.com>,
 "Somasundaram, Meenakshikumar" <Meenakshikumar.Somasundaram@amd.com>
Subject: RE: [PATCH v2 00/23] USB4 DP tunneling
Thread-Topic: [PATCH v2 00/23] USB4 DP tunneling
Thread-Index: AQHXub3vBTZPYdha7UGtGEx4n/8UQavEpUEAgAEWcYA=
Date: Wed, 6 Oct 2021 10:14:39 +0000
Message-ID: <CO6PR12MB5489516F02B4B72A9ECE7033FCB09@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <7553d620-78ec-8c3e-590b-ace7e44f9b93@amd.com>
In-Reply-To: <7553d620-78ec-8c3e-590b-ace7e44f9b93@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ec30f623-8825-47da-bded-3a29f1f0f2cd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-06T09:50:33Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1cd3971-7163-4407-ac9b-08d988b21bc8
x-ms-traffictypediagnostic: CO6PR12MB5396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB53963DB4389CCD0198AA4378FCB09@CO6PR12MB5396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BWJy80Hf1XEPztJKAUcTH5fWQT+ypAWFC3/gnmsnQPh4svOP3hl+8i8tbqydzOct+ar++r8FiqQ9EuO0X8Fg1/1JAmTPVd6/r/7hMfxDirUfTS59LEIPX4JjJbNTi+FrlXnDjXhZzg+eVRLi+GmssvXg4qZLXQWkWJyp5/r51lJKybWUzXQkZCQuGY1/BceznMEYGPRL2kf0c5MP3h6/PhYMa61ogbicstFlspzPi+zYm/nrh3piL+/qLs5/0LU+PidFxPv/eT2WjdMXdBk+D/TpUTkclMt5gQzPDV70GoUvScKua5PfL+50lp/i6TLTWNukSMkmmRcpDDrMLViwA9So36hfreRuYFFCgTAcnheCuqVewuK3fdFmywz7SkYfw5yKZvBQCDCTeNAFJ0bLO4uOvSY4XCJF4xvovIuOepcn5+OovfnH8qp6SAeaghvU2eNTXaNon+1rLu2mNdB5WvLp2ssl3ogUhzi7/pj9x/G8yEII10D4RkyD8hW2XZM5Sp+dikFNlk0cbHqO1nnvtmlkqZD8qwIShjwf74tMcj4TBa0MPDsXaBo9UZcobbmbL3ePmAG6fb8xEaokR7zo1wixjmSxTaUxvj5DOC/1siCySKPxtRbdmQzPKFxau31z2S1+QI2fmn/QFA1px6DlrH1ols41rHERt0aPneq+raFlqoOqqDPqCNpvFpzHpjRVmvIoNiop7AENptQ3DWFFdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(38100700002)(8676002)(33656002)(76116006)(508600001)(66946007)(66476007)(64756008)(7696005)(66446008)(66556008)(5660300002)(4326008)(110136005)(54906003)(316002)(86362001)(52536014)(2906002)(66574015)(6506007)(53546011)(83380400001)(186003)(71200400001)(26005)(122000001)(55016002)(38070700005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2s5MVBCazc5ZnVDZjdRNE1oanRLT25NVWhFZHVBV0ZnNHhMY1JCd2puNUwv?=
 =?utf-8?B?Q1ZlSTF2NFgvdDF6cytXcG5NUmtVb3NXWUFOK095QURhMUd4ekh0MnYwbVp2?=
 =?utf-8?B?eHdTTXdZbG8xdnRENFVwd2o1VUE4N1FYdkZ5QnJTdUJML21lUE1VckI3WVF6?=
 =?utf-8?B?NkRla0Z4NURaVFh6eWVDV0gvTkxSd0xoZHV3ZGd5UXlWZFVJN1djZG8vWDV5?=
 =?utf-8?B?OGg4YW4zTWVNajMyT2FSNW1mcEdCUE5kUE5mVUpEQmRmeHRFazR1L1NOT3VH?=
 =?utf-8?B?cnJXTHErclpyZjMya0RCbnoyOFhsTFFOWDRmTTcyQmNVUis5RVlQZ2RqL2Vn?=
 =?utf-8?B?RWNqczF2OEo3YUJBeml5YUoxVzZMbDNhd1Qzd1hnWW1SaHFpTFJIWnhNREll?=
 =?utf-8?B?WmorOE9RZGs2eStQcFhOQnBlRHA3UHYzS3pHdXVyZ3J1R3BOc0ZKVElwQlRX?=
 =?utf-8?B?R3VpYjR0WVZNY2JoY0YrcjBaUlQ4VU1MQytzRk9oZTlCOG95U0dZYzNEQXE3?=
 =?utf-8?B?NjIwN29FbmpzZmdjUm10S2FQaTJSMnN6U3JGcHRrRVJKUVJkMEVnQ0Ivamcw?=
 =?utf-8?B?QnpkY05hWGtXVG9FeXY2REc4aUJzMmxsZGVrNkcxTThDMk1BWE9FYTZOV2hw?=
 =?utf-8?B?bGZOa1BQZ1R4NlZrMkFQYzVaRlRYSmVZZGVCeW52M0F2NWlmRlQxeko2ZVV6?=
 =?utf-8?B?OU92QmkrOTJkQjcxVXBZM2w3dGhDKzY5Qi92TXN1K1pnZHRXaUl4VGJPNzRN?=
 =?utf-8?B?dGNCRmJNRmQzbHFPRjRsbGVFRmIwSFJsdjh6MEU5MTdsN0JycW5qSGtuakJY?=
 =?utf-8?B?ZExxSmNyMzRMVlYvbGdVdUQraE1wTWFUbFFWM3V6dUpvTlV1QkF6YXhkdTUv?=
 =?utf-8?B?U2QvaEFOVkF3UmYrRHYwTjd1bWcyelYydjJFWE4yR28rQmFkUWxpOTdYSWtY?=
 =?utf-8?B?Z1FNYmtvUFN6d3FqVXRPbWx1aDFJdDZMaUFqSWs5a1hKN3NtQVpuSmtnVTZJ?=
 =?utf-8?B?ZmI2Wk9uekRmTlBncEJWOWJ4REhsVXdRSmt2RG95N3dOTzhrRnl4R2xhZHlI?=
 =?utf-8?B?ZUlYK1N1ME1nck9wajZQU1dMYWM3QkdFamJsNzJ1d24vVFNFT2ZKdmJFZGtR?=
 =?utf-8?B?MlBwZUYrdVRsRDFFS3FhbkxXYVMxT0JvYVhzU1EzbGM2T0JmNUhMU2tYMXNR?=
 =?utf-8?B?enNyaTZZQm5SRXNhbTF1QkJFOFlyRUtCeE5XWHFkdWwvNkM3SStUL0ZLbmRs?=
 =?utf-8?B?eUpVM0RQak9aMXBlOFZHYk1KQ3VPSFVmKzk0ZUIyMHRvSGx4c0EzODlzOUdq?=
 =?utf-8?B?SXFqQVFhWklXaVdYU3hNM0xyYjc5RjRIeUNheWdGQ0k3MmxDaCtqb0NTVkdS?=
 =?utf-8?B?SkRTaEJ3UWZSSEZXWXZzWmF4bWpRMm9hZFgwMlBYYitvVnR6T3Y4MWIxNDR1?=
 =?utf-8?B?OVdoTm03bGpOTDVxSWsrb081RmR6Y3R2ZTRQRTJ2VlllaUlGQUtJQmtJSWhz?=
 =?utf-8?B?R1dJRERSVHdLWDFzdS9VUmZqSjkyMDlIbTBlYnJNQVlKbGxpZTBHYXppT2JK?=
 =?utf-8?B?dStnekpnNkl3UVlXQWlYTFZrQnpXelpKRlZ5TzlNN0d0eWJMOXUzMm9tdUw2?=
 =?utf-8?B?R1hqVHlMR3RyVWV5Rlk1M3dNK0NyQ2NJbFRWZTlrcFdKNkI5bjViU3hJbkFk?=
 =?utf-8?B?ZU4vOVFJMjlGaFMwK0ljeVlNS2lFQkljRUsxWnhIbmhTQTFKa2YzdFJFYk1M?=
 =?utf-8?Q?bwmDGDUS/2/t281886sLIGwApKiMfcFKU81yued?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cd3971-7163-4407-ac9b-08d988b21bc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 10:14:39.8291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kVzIWffijXHOns96VnxXpgF1AdtT4JoROussHzYG46P6X0vL3ZXqJxwAyEuMp9JEO9iOv8XKS+qxdNcC4oznQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0
b2JlciA2LCAyMDIxIDE6MTQgQU0NCj4gVG86IExpbiwgV2F5bmUgPFdheW5lLkxpbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNo
b2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBTaXF1ZWlyYSwgUm9kcmlnbw0KPiA8Um9kcmlnby5T
aXF1ZWlyYUBhbWQuY29tPjsgV2FuZywgQ2hhby1rYWkgKFN0eWxvbikgPFN0eWxvbi5XYW5nQGFt
ZC5jb20+OyBTaGloLCBKdWRlIDxKdWRlLlNoaWhAYW1kLmNvbT47IEtpeml0bywgSmltbXkNCj4g
PEppbW15Lktpeml0b0BhbWQuY29tPjsgU29tYXN1bmRhcmFtLCBNZWVuYWtzaGlrdW1hciA8TWVl
bmFrc2hpa3VtYXIuU29tYXN1bmRhcmFtQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDAvMjNdIFVTQjQgRFAgdHVubmVsaW5nDQo+DQo+IE9uIDIwMjEtMTAtMDUgMDM6NTEsIFdh
eW5lIExpbiB3cm90ZToNCj4gPiBVU0I0IHJ1bnMgb3ZlciBVU0ItQyBhbmQgY2FuIHR1bm5lbHMg
VVNCMywgUENJZSBhbmQgRFAgcHJvdG9jb2xzLg0KPiA+DQo+ID4gQSBVU0I0IHJvdXRlciBpcyBy
ZXNwb25zaWJsZSBmb3IgbWFwcGluZyBUdW5uZWxlZCBQcm90b2NvbCB0cmFmZmljIHRvDQo+ID4g
VVNCNCBwYWNrZXRzIGFuZCByb3V0ZXMgcGFja2V0cyB0aHJvdWdoIHRoZSBVU0I0IEZhYnJpYy4N
Cj4gPiBGb3IgdGhpcyBwYXRjaHNldCwgd2UgaGF2ZSBuYXRpdmUgRGlzcGxheVBvcnQgYWJsZSB0
byBiZSB0dW5uZWxlZCBvdmVyDQo+ID4gVVNCNCBGYWJyaWMuDQo+ID4NCj4gPiBFLmcuDQo+ID4g
RFAgc291cmNlIC0+IERQSUEgKERQIEluIEFkYXB0ZXIpIC0+IFVTQjQgaG9zdCByb3V0ZXIgLT4g
VVNCNCBwb3J0IC0+DQo+ID4gVVNCNCBkZXZpY2Ugcm91dGVyIC0+IERQT0EgKERQIE91dCBBZGFw
dGVyKSAtPiBEUFRYIC0+IERQIHNpbmsNCj4gPg0KPiA+IEJyaWVmbHksIHRoZXJlIGlzIGEgQ00g
KENvbm5lY3Rpb24gTWFuYWdlcikgaW4gVVNCIHN1YnN5c3RlbSB3aGljaA0KPiA+IGhhbmRsZXMg
cmVsZXZhbnQgVVNCNCBjaGFubmVsIGNvbmZpZ3VyYXRvbnMuIE91ciBETUNVQiBpcyByZXNwb25z
aWJsZQ0KPiA+IGZvciBpbnRlcmFjdGluZyB3aXRoIENNIHRvIGNvbnRyb2wgRFBJQSB0byBlbmFi
bGUgVmlkZW8gUGF0aCAmIEFVWA0KPiA+IFBhdGguIE9uY2UgRFBJQSBnZXRzIGludG8gUGFpcmVk
IHN0YXRlLCBEUCBzb3VyY2UgaXMgdGhlbiBoYXZpbmcgYQ0KPiA+IGNvbnN0cnVjdGVkIGVuZC10
by1lbmQgcGF0aCB0byBpbnRlcmFjdCB3aXRoIERQIHNpbmsgYXMgdGhlDQo+ID4gY29udmVudGlv
bmFsIHdheS4NCj4gPg0KPiA+IEZyb20gRFAgU291cmNlIHBlcnNwZWN0aXZlLCB0aGUgVVNCNCBG
YWJyaWMgYW5kIHRoZSBBZGFwdGVycyBhcmUNCj4gPiBlaXRoZXIgdG90YWxseSB0cmFuc3BhcmVu
dCBvciBhY3QgYXMgYW4gTFRUUFIuIEJlc2lkZXMsIGR1ZSB0bw0KPiA+IGNvbnN0cmFpbnRzIG9m
IFVTQjQgcHJvdG9jb2xzLCBBVVggdHJhbnNhY3Rpb25zIHVuZGVyIFVTQjQgbm93IGlzDQo+ID4g
aGFuZGxlZCBieSBETUNVQiB0byBtZWV0IFVTQjQgcHJvdG9jb2wgcmVxdWlyZW1lbnQuDQo+ID4N
Cj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICogR2l2ZSB0aGUgZGVzY3JpcHRpb24gb2Ygcm91
Z2ggd29ya2luZyBmbG93IG9mIFVTQjQgRFAgdHVubmVsaW5nDQo+ID4NCj4NCj4gVGhhbmtzIGZv
ciB0aGUgb3ZlcnZpZXcuDQo+DQo+IElzIERQLW92ZXItVVNCNCwgb3Igb3VyIGltcGxlbWVudGF0
aW9uIG9mIGl0LCBzcGVjaWZpYyB0byBBTUQgSFc/DQo+DQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2Ug
dG8gZGVhbCB3aXRoIERQLW92ZXItVVNCNCBjb3JlIGZ1bmN0aW9uYWxpdHkgaW4gRFJNIGNvcmUg
aW4gYSB3YXkgdGhhdCdzIGNvbW1vbiB0byBhbGwgaW1wbGVtZW50ZXJzPw0KSGkgSGFycnksDQoN
CkluIG15IG9waW5pb24sIGl0J3MganVzdCBhbm90aGVyIGNvbm5lY3RvciBpbnRlcmZhY2UuIExp
a2Ugd2UgaGF2ZSBtdWx0aXBsZSB0eXBlIGludGVyZmFjZXMsIEhETUkvRFAvVkdBL1R5cGUtQyAo
RFAgYWx0IG1vZGUpLA0KYW5kIG5vdyB3ZSBoYXZlICBuZXcgVVNCNCB3YXkgdG8gbm90aWZ5IERQ
IGhvdHBsdWcgZXZlbnQuDQpEUElBL0NNIHJlbGV2YW50IGhvdHBsdWcgZXZlbnRzIGhhbmRsaW5n
IHNob3VsZCBiZSBVU0I0IHNjb3BlLCBJIHRoaW5rIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gc2hv
dWxkIGJlIGZpbmUuDQo+DQo+IEhhdmUgeW91IHJ1biBjaGVja3BhdGNoLnBsIG9uIGFsbCBwYXRj
aGVzPw0KWWVzLCBoYXZlIHJ1biBpdC4NCj4NCj4gUGF0Y2hlcyAyLTMsIDktMTgsIDIwLTIzIGFu
ZA0KPiBQYXRjaGVzIDEsIDQtOCB3aXRoIHRoZSBzdWdnZXN0ZWQgdGl0bGUvZGVzY3JpcHRpb24g
dXBkYXRlcyBhbmQgUGF0Y2ggMTkgd2l0aCB0aGUgRENOIGd1YXJkIGRyb3BwZWQgKG9yIGNvbmZp
cm1hdGlvbiB0aGF0IGl0J3MgbmVlZGVkKSBhcmUNCj4gQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KPg0KVGhhbmtzIEhhcnJ5IQ0KDQo+IEhhcnJ5DQo+
DQo+ID4gLS0tDQo+ID4NCj4gPiBKaW1teSBLaXppdG8gKDE0KToNCj4gPiAgIGRybS9hbWQvZGlz
cGxheTogVXBkYXRlIGxpbmsgZW5jb2RlciBvYmplY3QgY3JlYXRpb24uDQo+ID4gICBkcm0vYW1k
L2Rpc3BsYXk6IFN1cHBvcnQgVVNCNCBkeW5hbWljIGxpbmsgZW5jb2RlciBzZWxlY3Rpb24uDQo+
ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFN1cHBvcnQgVVNCNCBmb3IgZGlzcGxheSBlbmRwb2ludCBj
b250cm9sIHBhdGguDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IFN1cHBvcnQgRFAgdHVubmVsaW5n
IHdoZW4gRFBSWCBkZXRlY3Rpb24NCj4gPiAgIGRybS9hbWQvZGlzcGxheTogVXBkYXRlIHRyYWlu
aW5nIHBhcmFtZXRlcnMgZm9yIERQSUEgbGlua3MNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogU3Vw
cG9ydCBVU0I0IHdoZW4gRFAgbGluayB0cmFpbmluZy4NCj4gPiAgIGRybS9hbWQvZGlzcGxheTog
SW1wbGVtZW50IERQSUEgdHJhaW5pbmcgbG9vcA0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBJbXBs
ZW1lbnQgRFBJQSBsaW5rIGNvbmZpZ3VyYXRpb24NCj4gPiAgIGRybS9hbWQvZGlzcGxheTogSW1w
bGVtZW50IERQSUEgY2xvY2sgcmVjb3ZlcnkgcGhhc2UNCj4gPiAgIGRybS9hbWQvZGlzcGxheTog
SW1wbGVtZW50IERQSUEgZXF1YWxpc2F0aW9uIHBoYXNlDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6
IEltcGxlbWVudCBlbmQgb2YgdHJhaW5pbmcgZm9yIGhvcCBpbiBEUElBIGRpc3BsYXkNCj4gPiAg
ICAgcGF0aA0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBSZWFkIFVTQjQgRFAgdHVubmVsaW5nIGRh
dGEgZnJvbSBEUENELg0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggRElHX0hQRF9TRUxFQ1Qg
Zm9yIFVTQjQgZGlzcGxheSBlbmRwb2ludHMuDQo+ID4gICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBk
ZWJ1ZyBmbGFncyBmb3IgVVNCNCBEUCBsaW5rIHRyYWluaW5nLg0KPiA+DQo+ID4gSnVkZSBTaGlo
ICg0KToNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogU3VwcG9ydCBmb3IgU0VUX0NPTkZJRyBwcm9j
ZXNzaW5nIHdpdGggRE1VQg0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBEZWFkbG9jay9IUEQgU3Rh
dHVzL0NyYXNoIEJ1ZyBGaXgNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogRml4IFVTQjQgQXV4IHZp
YSBETVVCIHRlcm1pbmF0ZSB1bmV4cGVjdGVkbHkNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogVVNC
NCBicmluZyB1cCBzZXQgY29ycmVjdCBhZGRyZXNzDQo+ID4NCj4gPiBNZWVuYWtzaGlrdW1hciBT
b21hc3VuZGFyYW0gKDUpOg0KPiA+ICAgZHJtL2FtZC9kaXNwbGF5OiBVU0I0IERQSUEgZW51bWVy
YXRpb24gYW5kIEFVWCBUdW5uZWxpbmcNCj4gPiAgIGRybS9hbWQvZGlzcGxheTogU3VwcG9ydCBm
b3IgRE1VQiBIUEQgYW5kIEhQRCBSWCBpbnRlcnJ1cHQgaGFuZGxpbmcNCj4gPiAgIGRybS9hbWQv
ZGlzcGxheTogU3VwcG9ydCBmb3IgU0VUX0NPTkZJRyBwcm9jZXNzaW5nIHdpdGggRE1VQg0KPiA+
ICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgZHBpYSBkZWJ1ZyBvcHRpb25zDQo+ID4gICBkcm0vYW1k
L2Rpc3BsYXk6IEZpeCBmb3IgYWNjZXNzIGZvciBkZGMgcGluIGFuZCBhdXggZW5naW5lLg0KPiA+
DQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEw
NiArLQ0KPiA+IC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaCB8
ICAxMiArLQ0KPiA+IC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMu
YyB8ICAxNyArLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvTWFrZWZpbGUg
ICAgICAgfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYyAgICAgIHwgMTc5ICsrKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfbGluay5jIHwgIDgxICstDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfbGlua19kZGMuYyB8ICAgOSArLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYyAgfCAgMzYgKy0NCj4gPiAgLi4uL2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHBpYS5jICAgIHwgOTQ1ICsrKysrKysrKysrKysrKysrKw0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdGF0LmMgfCAgIDggKw0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgfCAgMjIg
Kw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZHBfdHlwZXMuaCAgfCAg
MzEgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaCAgICAg
fCAgIDEgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXgu
YyAgfCAgIDMgKw0KPiA+ICAuLi4vZGlzcGxheS9kYy9kY24zMS9kY24zMV9kaW9fbGlua19lbmNv
ZGVyLmMgfCAxMjYgKystDQo+ID4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzEvZGNuMzFf
aHdzZXEuYyAgICB8ICAgNiArDQo+ID4gIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzEvZGNu
MzFfcmVzb3VyY2UuYyB8ICAgNyArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kbV9oZWxwZXJzLmggICB8ICAgNSArDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9jb3JlX3R5cGVzLmggICB8ICAgMyArDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2luYy9kY19saW5rX2RkYy5oICB8ICAgMSArDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2luYy9kY19saW5rX2RwaWEuaCB8ICA5OCArKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvaW5jL3Jlc291cmNlLmggfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaCAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9kbXViX3Nydi5oICAgfCAgIDMgKw0KPiA+ICAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX2NtZC5oICAgfCAxMTMgKystDQo+ID4gIC4u
Li9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMzEuYyB8ICAgMSArDQo+ID4g
IC4uLi9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnZfc3RhdC5jICB8ICAxNiArDQo+
ID4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZGFsX2FzaWNfaWQuaCB8ICAgMiAr
LQ0KPiA+ICAyOCBmaWxlcyBjaGFuZ2VkLCAxNzkzIGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9u
cygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfbGlua19kcGlhLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvZGNfbGlua19kcGlhLmgNCj4gPg0KLS0NCldheW5l
DQo=
