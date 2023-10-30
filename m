Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7993FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 06:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291B310E07B;
	Mon, 30 Oct 2023 06:23:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C98010E208
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 06:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWXNg+Y/NrYvzsenFUEArv1jsRRFAakm+FoL/q6FrgOczS7bULki5kG+7tTvT/ShgcMXHjRts4YA71+wt5xtxy/ZHwY1oRVzzFIbtjJNCmdBqsEH5mqkJsTC9W9U6DIuVCwnw0qryumw1GOOvo2PJE/7+3B6Tzk6eswjRW6rY+C1apI3N4opW/kUsumTydqhViaqGYsfpLajBmeI/KjfPMq/sba7+G/pXJYVF0/XOOQzr0Qf68NTyTGwSFZhKzjT+sM5+BR1J7srzzVPrg496lmh5SHcsQkrQMpYr+1ypM8DRStLCKI7DYaAanzmYe0lhWO+E4cxZXjBqCdOtkxhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/eadp0IERnJLYuU021igvuuqOJp762jrMRgcU5KhOA=;
 b=fVNYJzI0DuJ++d97GtZF6UaFazfMmvYc/abmqdJg90BQmOSfaOY7lsYn10RXms7fRcPMd1JGCpx6My6q/+JGU0AEqsSrLd4MiyxjyaxqPcyUYDLgWhBszO7rka8KwOLrNauR/sLLxbrTOwU6074gzn+LCAopZ/Vr5FWeH93ysEnjFmGCXAu/+WSeZ5sNc7iYm9ZWqDoFhoEEF2fhRt9MTciANoBnMsJhxyHnKSrm32TLRh3HyYr/2OzNnq5frloWZIwCn2GsjyU/W+OGSgsR0h0EUeHjVZ/+4SurPIbGc9Ox0WlTwqu2WfkTBr6A//21CJw2Z2bRoNS45bd9qjjMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/eadp0IERnJLYuU021igvuuqOJp762jrMRgcU5KhOA=;
 b=lOSETpIKmHZzaFKhsYcKGiSALkZVSNoYagj4d7qq0kGV6PJL6uDeGfIBKJN1PES/YSnj4v8ADR1sCAZV0iIqedCu2jtx347OCEEkgZaeJhaoW8IO8CgHmelt6Vv1XQ4ystjFdUE7feCb0/QlLUhvGNMQXcYmV/pge0a8UcTjX5Y=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 06:23:23 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Mon, 30 Oct 2023
 06:23:23 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Thread-Topic: [PATCH Resend] drm/amd/pm: only check sriov vf flag once when
 creating hwmon sysfs
Thread-Index: AQHaB7dEvxPK2qnvf0eztJpsn8O3vLBh3/oAgAADBAA=
Date: Mon, 30 Oct 2023 06:23:23 +0000
Message-ID: <PH7PR12MB599761E6CD88B0D38BD9927382A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231026025033.1469231-1-Jun.Ma2@amd.com>
 <c82e4cb7-627c-a356-5659-0eb63a3e1a2b@amd.com>
In-Reply-To: <c82e4cb7-627c-a356-5659-0eb63a3e1a2b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3efbfcc2-3e4f-43b7-8130-3add63fb1829;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-30T06:20:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA0PR12MB7092:EE_
x-ms-office365-filtering-correlation-id: f563fac0-03b7-4ae6-2e36-08dbd910b83f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekn0iWRPJdyifshM55BEqKSn17UrZX9XTmOa7wfuvJoZk4YC65FTv406KvVu14yW4DfUFhC73I3u5IEGqNuk64lzjZPjvT2uVApexkTKwTVnAPR/3necJlkBaYzMmVkn6CPuQYrScmYFTvWdakJYCteIotwugKbvkOCFhncxgSeFp12sTyz+659UghdGR5RiC6X2JB1TlK3nZ4zNocYyE0b4D9x0wLylql8BvK9cjzlOQ6cpr2Z9GNIHeZRh33BfBif6+czyteiw0PekMmd15YOfcIOgHfUX+TOPbCPa+ODvOWISubVF3UBjb24phh9wABkDslhZ4QKXfsFDfrtX+e1etVxq+u9VtdPMyZuPx5TtmjwxyQk1Sbq9KCZO1VuMEM6cHMhZPozwwZfLHDQ7Gq5GG2gTM/3+cn6Rz8/8wmYN1yhFAnRgHZ55tesErKEjnZEqhpnXbk9UEugZewUJf+n0NOvu14rjftQED6FRWGqVfrK4u7A5lJ0se3RNoBE5B9ud/+1xtjnSNol/z9JOchjb1pFL5ufnzosrLsh6do9gzZb5Tf5h6MvjrG0cbEQPl+LVLAJYVK5aNvgKRqaDHJSTl9xKsWAjdgAqcQTL5Fk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6636002)(2906002)(316002)(5660300002)(55016003)(52536014)(66556008)(26005)(41300700001)(8676002)(38070700009)(83380400001)(8936002)(38100700002)(64756008)(66476007)(53546011)(9686003)(122000001)(66446008)(66946007)(110136005)(6506007)(71200400001)(7696005)(478600001)(76116006)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXNoUlVaTlBDTG9BYytYak9yNE1xN2FTc3ZPQkIzN1RnRkhsbSs2bGVrMGxB?=
 =?utf-8?B?MXBISHd4V1AzRUI2QUpsYm9VUVF6VTc1T3hRYW9WeHJ1bTFnUURXYkt6OVVG?=
 =?utf-8?B?WExFYmJDdHVDY2c4cVI3Z3o5QTNvd0FaYXBrR0dkWmJnZTFVV2xic1dpbGJS?=
 =?utf-8?B?U3pKWEkwWkhnaWxsUENyTDFXVFZSdEJValRxSVJLdWtadWFuL21MdmRmU09l?=
 =?utf-8?B?djdiM3RGaFZvZk93M1hWZTZoZWxZRVJpMVluTVpEeFJDN2Q2eHdRMzhLdEVH?=
 =?utf-8?B?VEZ2ajN3eUJTdm5xeStQUTZPNVAzdWFZclFSb3hST2hEemRzWlAwa2FrMEZF?=
 =?utf-8?B?a1NKaFdvRmhXUUJ3QlF0cVlZcjQxRGJCTFNEUDZ3SU12c0dJNFZ2WVJQUkY3?=
 =?utf-8?B?LytZSlFSR1ZRbytWM29SMzloZGVHVnBHNkthaDRlc2NFSTJQMHB0dnhmaDlm?=
 =?utf-8?B?OGFvMXlNczhzNjArVEIrSDI3eEphWTl4dkgzaW1OejZnc0s5QXo2dWN0d3U1?=
 =?utf-8?B?VmNWSTNPdVNNY0FhYkgzSFlDL0xlNFJtZzd6NmlQS3JsMnlXYngycHlwQjJN?=
 =?utf-8?B?QnpzcUdJSUlQcUQ5UStWZ1V6WWNjQnVkVDluNHFFNlF5SVl3eUhSUERsTkE1?=
 =?utf-8?B?QWhoRWQ1ODVtTXJ2UUFsTGlvNytyTkIwa0tMYXhPNnJUUFlwMFBSUVRlRkFs?=
 =?utf-8?B?K2wyd2ltaWZTcG5adXg1UGRmYmNhV24wbGhqK3dWak1ZdkRMNUFQendRTzgv?=
 =?utf-8?B?d0RXR05YTzdyN1Y0NGw4RFplaHYwdmZLQVJjeVZYM2g4ZjlxbWVJZGJ2TENI?=
 =?utf-8?B?WGF0aU1Gd21EcDZLSkNJK0FVZ0dHRzRIWXZmWm44ajBMOG1xRFgzSGJrWTFq?=
 =?utf-8?B?QWRycGxuTHdxMmhsYjBnNU9TTERZT3RBVExsNHlFNkpMYmpQY0o0dzd0ZDFY?=
 =?utf-8?B?dXlGeFh6Uk1yOXdrVVBnOE8vUHRPNUFITEsxc0dSaWxGa0NiVjl4Z2J2RW5C?=
 =?utf-8?B?U0xtemdyRmpITW1scUgxd1NOSDZtRXdFRmFZcnJnQkxNOGZZZXh1cSswNTNw?=
 =?utf-8?B?WHpTa3BqZjNCZGtLT1lRVWlQd2hZWnVDNkxFYzcvd0JmYUhIczQyTWNmTGhK?=
 =?utf-8?B?MTRSbU9YRktRSUxxbUVOdHk2ZHdZMXZFUWgzbitTdmJtMis5OXVkcnAwYTlG?=
 =?utf-8?B?Mlc1NzJTTmRLR04vZVMxREhCUHRIcnBRWjV4WkVIWGVqRlNadTY1ZWNQbGU5?=
 =?utf-8?B?MlFsRFNqMzUzelppZkpOa0E5NDkzUitBVHp1b2JUU3J4R0tjZnhFd1ZrZkMv?=
 =?utf-8?B?MWRMcEZZVGNHdlkvUHhKaEdKUlBVZEhnODMwK2FZM3Jva0NmODdjbUdjeHhR?=
 =?utf-8?B?UGRIL25BRVpTS3VWT0VFbW1mVDVuMHBydWp4L2NUVERhbWlFQ3FNWDVyM1Zp?=
 =?utf-8?B?TENsRE82UUpwcVlGZWRta3dhTWpKVXZKVUN6VGRFZytibW9DRnBDbTUzQVh1?=
 =?utf-8?B?Y0ZuaWN1TUNWVmNoeHlEaDUyelk5NzE1YXdrRzdOUmxhNDhSb3dQcjhJTWtP?=
 =?utf-8?B?UENUMFArY1dENDhnRDVXeldqWk8vTmxydmhoY1REVUxjRTRvVFdseEV1WEcw?=
 =?utf-8?B?bWMyODV6N3RxcEtkQXFaNFZQMklwNmJXb3E5MndNcVRRR1RoSWhjSzNOVElt?=
 =?utf-8?B?K3BGeEcwUUZxN3Qzc0tNb0QxcURWS2RubUpIQXhkcUNXM3kvbEtaOUNhY0dT?=
 =?utf-8?B?QVR6S2N5Y3g3ZzZDSjl4TFFVNitqMXdFdTdtTWpMSmpkWXZEYXVXNU5odXVF?=
 =?utf-8?B?L0JxTHd2RG83Wk00ZFZNMzJlRFZoamlKVk1vWXRac2k5MTMzZjZ0dnIrSHFs?=
 =?utf-8?B?alY5VjJWU1lzWVZiWjVySHV1SU1Sa1h1VGhndjVGR3JyWFU1TlMxbitqRkhn?=
 =?utf-8?B?dXBReGNSbTRqSmVRZk55TnFPektZaTc5cXhkeTY1bExuZDRlMms2OFJ4ek5y?=
 =?utf-8?B?VWZVOW9ycHJYT24rSGtNV0J1eUlaZ21DMS8rUTJ0c1N4TTlXa3ZpcUZoZHFY?=
 =?utf-8?B?NW5VRHQ2U2ZLb011WWgvbmVqVktmRE9YR0QyMnVvMm1DVWFhaHRsQzB1V2E3?=
 =?utf-8?Q?94A8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f563fac0-03b7-4ae6-2e36-08dbd910b83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 06:23:23.6397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6w/ObnvLSlLl/i+e+EpMyo49FTydXk1/HpnqP2n353PYKvTzCc8Wl0K4ifwnMOBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoZSBkcml2ZXIgYWxyZWFkeSBo
YXMgc2ltaWxhciBjb2RlIGluIGh3bW9uX2F0dHJpYnV0ZXNfdmlzaWJsZSgpLA0KU28sIHdoYXQg
aXNzdWUgeW91IGhhdmUgbm93ID8NCg0KICAgICAgICAvKiB1bmRlciBtdWx0aS12ZiBtb2RlLCB0
aGUgaHdtb24gYXR0cmlidXRlcyBhcmUgYWxsIG5vdCBzdXBwb3J0ZWQgKi8NCiAgICAgICAgaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2
KSkNCiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNYSwgSnVuDQpTZW50OiBNb25k
YXksIE9jdG9iZXIgMzAsIDIwMjMgMjoxMCBQTQ0KVG86IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRo
LkZlbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggUmVzZW5kXSBkcm0vYW1kL3BtOiBvbmx5IGNoZWNr
IHNyaW92IHZmIGZsYWcgb25jZSB3aGVuIGNyZWF0aW5nIGh3bW9uIHN5c2ZzDQoNCnBpbmcuLi4N
Cg0KT24gMTAvMjYvMjAyMyAxMDo1MCBBTSwgTWEgSnVuIHdyb3RlOg0KPiBUaGUgY3VycmVudCBj
b2RlIGNoZWNrcyBzcmlvdiB2ZiBmbGFnIG11bHRpcGxlIHRpbWVzIHdoZW4gY3JlYXRpbmcNCj4g
aHdtb24gc3lzZnMuIFNvIGZpeCBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWEgSnVuIDxKdW4u
TWEyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0u
YyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
YW1kZ3B1X3BtLmMNCj4gaW5kZXggMzU4YmI1ZTQ4NWYyLi5lZTQ2ZDA0NTQ5ZTYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBAQCAtMzI4OCwxMCArMzI4OCw2IEBAIHN0
YXRpYyB1bW9kZV90IGh3bW9uX2F0dHJpYnV0ZXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29i
aiwNCj4gICAgICAgdWludDMyX3QgZ2NfdmVyID0gYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgR0Nf
SFdJUCwgMCk7DQo+ICAgICAgIHVpbnQzMl90IHRtcDsNCj4NCj4gLSAgICAgLyogdW5kZXIgbXVs
dGktdmYgbW9kZSwgdGhlIGh3bW9uIGF0dHJpYnV0ZXMgYXJlIGFsbCBub3Qgc3VwcG9ydGVkICov
DQo+IC0gICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgIWFtZGdwdV9zcmlvdl9pc19w
cF9vbmVfdmYoYWRldikpDQo+IC0gICAgICAgICAgICAgcmV0dXJuIDA7DQo+IC0NCj4gICAgICAg
LyogdW5kZXIgcHAgb25lIHZmIG1vZGUgbWFuYWdlIG9mIGh3bW9uIGF0dHJpYnV0ZXMgaXMgbm90
IHN1cHBvcnRlZCAqLw0KPiAgICAgICBpZiAoYW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2
KSkNCj4gICAgICAgICAgICAgICBlZmZlY3RpdmVfbW9kZSAmPSB+U19JV1VTUjsNCj4gQEAgLTQx
NjIsNiArNDE1OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X29kX3NldF9pbml0KHN0cnVjdA0KPiBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPg0KPiAgaW50IGFtZGdwdV9wbV9zeXNmc19pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiArICAgICBlbnVtIGFtZGdwdV9zcmlvdl92Zl9t
b2RlIG1vZGU7DQo+ICAgICAgIHVpbnQzMl90IG1hc2sgPSAwOw0KPiAgICAgICBpbnQgcmV0Ow0K
Pg0KPiBAQCAtNDE3MywxNyArNDE3MCwyMSBAQCBpbnQgYW1kZ3B1X3BtX3N5c2ZzX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgIGlmIChhZGV2LT5wbS5kcG1fZW5hYmxl
ZCA9PSAwKQ0KPiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPg0KPiAtICAgICBhZGV2LT5wbS5p
bnRfaHdtb25fZGV2ID0gaHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhfZ3JvdXBzKGFkZXYtPmRl
diwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBEUklWRVJfTkFNRSwgYWRldiwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod21vbl9ncm91cHMp
Ow0KPiAtICAgICBpZiAoSVNfRVJSKGFkZXYtPnBtLmludF9od21vbl9kZXYpKSB7DQo+IC0gICAg
ICAgICAgICAgcmV0ID0gUFRSX0VSUihhZGV2LT5wbS5pbnRfaHdtb25fZGV2KTsNCj4gLSAgICAg
ICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICJVbmFi
bGUgdG8gcmVnaXN0ZXIgaHdtb24gZGV2aWNlOiAlZFxuIiwgcmV0KTsNCj4gLSAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiArICAgICBtb2RlID0gYW1kZ3B1X3ZpcnRfZ2V0X3NyaW92X3ZmX21v
ZGUoYWRldik7DQo+ICsNCj4gKyAgICAgLyogdW5kZXIgbXVsdGktdmYgbW9kZSwgdGhlIGh3bW9u
IGF0dHJpYnV0ZXMgYXJlIGFsbCBub3Qgc3VwcG9ydGVkICovDQo+ICsgICAgIGlmIChtb2RlICE9
IFNSSU9WX1ZGX01PREVfTVVMVElfVkYpIHsNCj4gKyAgICAgICAgICAgICBhZGV2LT5wbS5pbnRf
aHdtb25fZGV2ID0gaHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhfZ3JvdXBzKGFkZXYtPmRldiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
UklWRVJfTkFNRSwgYWRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBod21vbl9ncm91cHMpOw0KPiArICAgICAgICAgICAgIGlmIChJU19F
UlIoYWRldi0+cG0uaW50X2h3bW9uX2RldikpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IFBUUl9FUlIoYWRldi0+cG0uaW50X2h3bW9uX2Rldik7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIlVuYWJsZSB0byByZWdpc3RlciBod21vbiBkZXZpY2U6
ICVkXG4iLCByZXQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAg
ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4NCj4gLSAgICAgc3dpdGNoIChhbWRncHVfdmlydF9n
ZXRfc3Jpb3ZfdmZfbW9kZShhZGV2KSkgew0KPiArICAgICBzd2l0Y2ggKG1vZGUpIHsNCj4gICAg
ICAgY2FzZSBTUklPVl9WRl9NT0RFX09ORV9WRjoNCj4gICAgICAgICAgICAgICBtYXNrID0gQVRU
Ul9GTEFHX09ORVZGOw0KPiAgICAgICAgICAgICAgIGJyZWFrOw0K
