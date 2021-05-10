Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A41C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 06:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBCC61409
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 06:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBCC61409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC6989F19;
	Mon, 10 May 2021 06:53:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91DE89F19
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 06:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZIhs84eqavpsNWfXd6bjonsKKZft67QeZZ447jOx6VN3OKufNOCsADj8wPKzOI75NSVizkDJcpiyfWSZ1h+uhVgmImd+PitDSoY0X7xdMa30Z2YCmfvj/WBMLTGJYC/IN2Egpv08nFWNBfJ5f9SQr3CHLaMvv9zzq/kJInESLAsEUYy/qyVgdlA51knYBH5R+B6t+Z8ePu4nZOMyGLeT1k4VrFAk/T1zPd1ETullZvSxV5F0IYAcwQAtQ6D+yq+JdVB78HovOCYml6tv+p2i7qQc83hTbGA2oUWz9l6NAC8SbS0i3zsx8Iw6SU1Y+wpLiby6tVxTolWM7Ev2bYgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPmb4B2wqk0scmqGLhAh3/cB3gTLNOf7OlvbIi0Qj5g=;
 b=UEOy4D4Tg6kxnhsYMikJyltuuYkabC4rkS8QeYL/CnpXkddAlzNWC5PdZgMkPCtxGOyYZngQbCXjiLhM1wlWV1FPDsm9bltyGmIb6dbSOwycKzwsvZCX8FYmD5mPmPZGRX/3l3mpLthVW5a+KpsO7uJ873MRJ57G3B3fbwONp7ZbvEIg1A66YCP/sJtqbolpPYv6RwabZZivx2qGDGXWHoG/mLcc7HrOS3h/sOEF0L397WyAznwv+oYaz0mboStdNNHuqgXqPrE6jE6brPGr/WJKhnFMHBptWn1YA2QTWix7Thyfep2798dUaZJE7hIfKkdnrPMtkw6Sfz3AtyxKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPmb4B2wqk0scmqGLhAh3/cB3gTLNOf7OlvbIi0Qj5g=;
 b=FIsV6woEAV8EOoVv4F7gYDL17s1GrVN/U9jRnHReqPdB3hLO38+NbZY1ko4/bN+kf7UOw+TVYVBdQWeH7diai9I2N/Pe6bzxlUTq8eC58G9ZZCWkW92nWQL0BB4PfjBAYNNDGVx5YthHRC7Mpmw/7hSeBWEZmX8D6Wvg/M5RQRY=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Mon, 10 May
 2021 06:53:21 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 06:53:21 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7Q==
Date: Mon, 10 May 2021 06:53:21 +0000
Message-ID: <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>,
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.143.192.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41048386-bbd8-4bf3-9dca-08d913804cc4
x-ms-traffictypediagnostic: BY5PR12MB3778:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3778B7A11937FCA26A637363F4549@BY5PR12MB3778.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48ntEu8IVNCSxO1jhlcrr9JmjJ2V5kTUpOFkg6K+bQmncGXL4DRl7DFZj43R1ZdYiruAbl0aECbVxAtDahhCisstLdYRxXlW9bGxVOVOc4g5kazgGJUHpZMBzkII+vKoiDnlDFsFvHWiY4uVKVlPSpV22UIBRcRmCkUb0zf5B3kE8FQL1ZbX56IkPw6Ta25hd10jtRv98z5fA1Tf2dizbu6V4FwZ2P6Amuv9zZ91zOF84FEJGmX94bWt67C6sX+Zz1FQ1F1BT8uYHH7ZcsR1qJ6257wh/9x8JkudJxkzpB1iKGCfk5JsFJ8f9PAu5Jg2l4GSMR89bg8KjqGZYgOXWxcS9u7VmpAzoCUqUHgTMMSKTHpZ10LHph/sRJ8KRURDbMOpuTHJO6kuLV5eGdsgnR4Qr4Z0w0mJbN96J+qiaUC3atRWngEiDn3y57tCQ+Q8rUwnioNRou0odSoLuJMxKczAVDanF+Y0XxL19I+dgBdaohBsq4m5CIS5U4aUITEnNJLvW7ZND3L9ZZLUti1O4kHbCa7527uAZaqXF/K/UJ9ju8ErgnA2u1UFBqScRaSNlGb3GRe/FGfYF626c3lpeNaph7mQst1uZU8iJvoZUqAFcccCrK8WpC464S4R5rpD6Edff2F695MAUavWl9/GQC6VcBV2N+c1Ay6hh2Z4rKeWNvVITeB00tSglW/8c5rDuFRLOOYO1iN+mUX/tIB14MUDPgOLThptNbZi5scDD5o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(6636002)(6512007)(2616005)(2906002)(76116006)(186003)(6486002)(53546011)(6506007)(54906003)(66476007)(66556008)(64756008)(66946007)(66446008)(36756003)(71200400001)(8676002)(478600001)(33656002)(5660300002)(37006003)(316002)(8936002)(45080400002)(83380400001)(38100700002)(86362001)(26005)(122000001)(4326008)(6862004)(966005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFpDUFFLY2NkdkN5cTd1WmJ0WENjWXFzcFk1bzNsSHBEdWpZc0JPT0ttZm5K?=
 =?utf-8?B?dThzaG1Cemx6L0xzMGhSdHBkQm1GR1BBYkpRZUQ4czJraUtOcE9XYzF6Rm5a?=
 =?utf-8?B?UkRLNjBHM3FDRSs4NFFINXJoOG9OYkh5QmpnV01zOWJhWXdscFRaY0NFQ0Rx?=
 =?utf-8?B?YzRoSnh6Z0ZzbWNLeFVYNCtUWVBYdUNXWUYrcjhyTWREQmhDSlRxaS95VnBQ?=
 =?utf-8?B?LzZXWFhSdlV3WXlCRVRKaDdKeGZqdFZrdXdCRll0bDhqOGgwQy9MTjNKVkRt?=
 =?utf-8?B?Qjg4SlFGK1ljU3BXT0tFOHplbFlDaUNGMEkzUUJRYU1mM1djbU53am1YNFc2?=
 =?utf-8?B?TnlQRlgrRHZ2S2xBZ3pVcTlVZDNPMkwvdFBxS0h1MXczVjdkU2tQaHhhenk3?=
 =?utf-8?B?K24waFVHSUZESlJqS0tsMWNzclFXdTVZSkh2RS9UV1hWQmh6bnhIdTVicEhM?=
 =?utf-8?B?NWs5cDh3dG1aSDF1dUdVdVk0UjEvMEN0V2FMRjVUc2VFc1Z1RlAvYVpmTmZ3?=
 =?utf-8?B?WGo1OXNPL0J2YlBmWU9rb0RGY05Pc3FEdyt4THJUQzVLOTMwSHNyL3ZTOG9L?=
 =?utf-8?B?TXBibk1WeU1QZnBjT2RGbUtGUjVxd1hDR003clIvZ2ljbE0vZzR5WFdpSW1M?=
 =?utf-8?B?S3pzRDlsQXJtTldZaEltRC9EUlV4eWhpMWV6cjBNVEJxT21WSC8yZm9HZC9D?=
 =?utf-8?B?VWJOZU1qRGJXSUU0VWVwMUNTOEZ0bDNiWnNUZDJTbEFmRFFEcyt1NDl3U0Zj?=
 =?utf-8?B?bkF4MmZJVi9xY0tEcW56OE9xZ2RTVTR4VGx3MWJURkUvQUhjNFpMYlVtVmFI?=
 =?utf-8?B?cjNCa3kvM1dUbXpZWFFMWktGNGEzU01qR3V2RWpRVVZVblo1K3R6WFR5RjJ6?=
 =?utf-8?B?NkZyU1EwcGtDa1lwYnJYZm9IazhvSi9qUHNoWHB0TG1nSFNxbzJPV04rV1Ry?=
 =?utf-8?B?bG9OS2M1czlWV1lPQ2JDRGd2cEM1QURyQ0tiSGJwYThtMFRPZnBnRzRJZlA4?=
 =?utf-8?B?dVJMT1dxWjRSRlUwTGIxUmxxWkl0TXZlclU4Sk5sS1pCdmM5U0xjdi8yc1ZO?=
 =?utf-8?B?NFFObjBRaldBNDJ4SXFiRFQraVUzYzBQWVJ2TnNrNUczaGRnRmp4MERFajFQ?=
 =?utf-8?B?cG56STIzb2I1Z1pIbU8rcklYNlpObXZaN1N2bmIrWjhWT3o1OE5PT0JwaENv?=
 =?utf-8?B?OTUvQytCdzJ3aUdLTERZdnJkamt4WFVsVjI4N0RHQS91OHNYNlAwOTJkektX?=
 =?utf-8?B?QllXOHBzZEhBalQrMDVjRzNyWkVZaDBwVWVtcVpiNDVRdjJXenFPeVVUem5s?=
 =?utf-8?B?R1FiTCtPMVFFQ1hyU2JLQ0xkMk1zM0tUR1dvcFNYbDZRc0x0emV4MmpPSmpW?=
 =?utf-8?B?ZXFoeHIvSjNOMXM5Tlg3dGtybE9lc2p5OGlVSlZGSFloTHY2QjNqQ2J6YjNL?=
 =?utf-8?B?WTdia3E3STFjU1pldk1LbitpdXdjTktLeWJPdlhXaG8zUXpORE1xaWVzKzhv?=
 =?utf-8?B?M3RPTzFiUXRlenJzN05wakxVRFFZZUtXNFJTVEREM3JBOThSMG1pUDNQcnBQ?=
 =?utf-8?B?SnV4RU91TUxOY1VZRW5pUU9vdEhybXpjc0RMUDZJWkdlcTFpbDNMSFRGL2gz?=
 =?utf-8?B?eXd6Qm9pTzY4MDdEME1Oay9WN0swaml1amlaR2Y3U24yU1VWUUl1Nm5sSnFJ?=
 =?utf-8?B?KzJZTGZJU3dLMDJHS291Q3JyQlFGak9lOTViWkI3dUJVZGZaVk1IUGxaU3Z5?=
 =?utf-8?Q?BlCE2iofQ3m1f3GaCVWenw8sydB94CObaJYgHOx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41048386-bbd8-4bf3-9dca-08d913804cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 06:53:21.3301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCE6GDMs+elNhY3Dn74rVe+YgP3Vcx9bqXYXzWcWmcCdyHRldkMyBspSDOySo91k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3778
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm8sIHRoaXMgc3RydWN0dXJlIGNvbnRhaW5zIGFsbCB0aGUgZGV0YWlscyBvZiB0aGUgdmJpb3M6
IGRhdGUsIHNlcmlhbCBudW1iZXIsIG5hbWUsIGV0Yy4NCg0KVGhlIHN5c2ZzIG5vZGUgb25seSBj
b250YWlucyB0aGUgdmJpb3MgbmFtZSBzdHJpbmcNCg0KPiBPbiBNYXkgOSwgMjAyMSwgYXQgMjM6
MzMsIEd1LCBKaWFXZWkgKFdpbGwpIDxKaWFXZWkuR3VAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiDv
u79bQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+
IA0KPiBXaXRoIGEgc2Vjb25kIHRob3VnaHQsIA0KPiBfX3U4IHNlcmlhbFsxNl0gaW4gZHJtX2Ft
ZGdwdV9pbmZvX3ZiaW9zIGlzIGEgYml0IHJlZHVuZGFudCwgc3lzZnMgc2VyaWFsX251bWJlciBh
bHJlYWR5IGV4cG9zZXMgaXQuDQo+IA0KPiBJcyBpdCBmaW5lIHRvIGFiYW5kb24gaXQgZnJvbSBk
cm1fYW1kZ3B1X2luZm9fdmJpb3Mgc3RydWN0PyBAQWxleCBEZXVjaGVyIEBOaWV0bywgRGF2aWQg
TQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBKaWF3ZWkNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiAN
Cj4gU2VudDogU3VuZGF5LCBNYXkgOSwgMjAyMSAxMTo1OSBQTQ0KPiBUbzogR3UsIEppYVdlaSAo
V2lsbCkgPEppYVdlaS5HdUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz47IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBBbGlnbiBzZXJpYWwgc2l6ZSBpbiBk
cm1fYW1kZ3B1X2luZm9fdmJpb3MNCj4gDQo+PiBPbiBTYXQsIE1heSA4LCAyMDIxIGF0IDI6NDgg
QU0gSmlhd2VpIEd1IDxKaWF3ZWkuR3VAYW1kLmNvbT4gd3JvdGU6DQo+PiANCj4+IDIwIHNob3Vs
ZCBiZSBzZXJpYWwgY2hhciBzaXplIG5vdyBpbnN0ZWFkIG9mIDE2Lg0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBKaWF3ZWkgR3UgPEppYXdlaS5HdUBhbWQuY29tPg0KPiANCj4gUGxlYXNlIG1ha2Ug
c3VyZSB0aGlzIGtlZXBzIHByb3BlciA2NCBiaXQgYWxpZ25tZW50IGluIHRoZSBzdHJ1Y3R1cmUu
DQo+IA0KPiBBbGV4DQo+IA0KPiANCj4+IC0tLQ0KPj4gaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmggfCAyICstDQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5o
DQo+PiBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGluZGV4IDJiNDg3YThkMjcyNy4u
MWMyMDcyMWY5MGRhIA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdw
dV9kcm0uaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4+IEBAIC05
NTcsNyArOTU3LDcgQEAgc3RydWN0IGRybV9hbWRncHVfaW5mb192YmlvcyB7DQo+PiAgICAgICAg
X191OCB2Ymlvc19wbls2NF07DQo+PiAgICAgICAgX191MzIgdmVyc2lvbjsNCj4+ICAgICAgICBf
X3U4IGRhdGVbMzJdOw0KPj4gLSAgICAgICBfX3U4IHNlcmlhbFsxNl07DQo+PiArICAgICAgIF9f
dTggc2VyaWFsWzIwXTsNCj4+ICAgICAgICBfX3UzMiBkZXZfaWQ7DQo+PiAgICAgICAgX191MzIg
cmV2X2lkOw0KPj4gICAgICAgIF9fdTMyIHN1Yl9kZXZfaWQ7DQo+PiAtLQ0KPj4gMi4xNy4xDQo+
PiANCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3QNCj4+IHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3Rp
bmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDSmkNCj4+IGF3ZWkuR3UlNDBhbWQuY29t
JTdDY2VhMzE4MzMxODRjNDFlODU3NDUwOGQ5MTMwMzYwY2MlN0MzZGQ4OTYxZmU0ODg0ZTYNCj4+
IDA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1NjE3Mjc1MjM4ODAzNTYlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2QNCj4+IDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MNCj4+IDEwMDAmYW1wO3NkYXRhPWtBSmlD
NldvSlVUZUV4d2s2ZnRyTGZNb1kyT1RBd2c5WDdtR2dKVDNrTGslM0QmYW1wO3Jlc2UNCj4+IHJ2
ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
