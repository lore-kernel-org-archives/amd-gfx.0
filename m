Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D64C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 08:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8B564F6A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 08:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8B564F6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4598F6E999;
	Fri, 19 Mar 2021 08:17:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFD96E999
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 08:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb1PskmdrZg07YEEhhbbmMKQqzjP/ZVVHsG/C1rNy3pqJnCqtlYWwem3ByRktbzRnRageNbQYpDTfUQ/gN3//nZaVcvdLwfOqBKVDAmuWPH74faSGQpPYqvbcEydVEIqvAmpM6dL+gO0srbYABxjcOQ0ZQelFkGAr0U+GtMH4/Tp2zPJfFb7e+EISNXBCBHW7Wc3wsWnFlZxGjHO2rlKVg+uzXmmZWebXFwge+DaL/qnlnpg5PkRbQGYsBlwIV2E+aZb8kzf3HFs/nKaKM3lzoWzFCYoboOOemsAKpeyDu4IWoJs0Yvo0KWLTm9Mnm9izW/P9vCk39044q5X8x+hYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqtj6MmSeY/4jsXVU1L7V40S1L7pdOSRfdRKUkSHQdY=;
 b=MukZkFbfc6QZCO9AXYVYVygTxaHpnGp7pNjqrBMM9ymOa9bi96iA86du+2RR6/JboPB+M3KfywcNlD+Hdhl0hAxIYCRwrauBdJ+VkVs7y1DNCnL62CMLZ9AvOz2MGSFcejZVzEEei9bP7NhoMopO3KMqEw/6Byz1QONo9DpuXuZOVwnRAmIIxSIx9uG/AVAg7mmaa4PUlLQxhl0svbnXxRhF8a/2At1Go37Qfx3lOunLXzkyOXAsnU7OlUkCZJWo0NA3kGJQpzOvHz+/39bq9UvYXj5XlsO7PpJSdboJsuDwtpUbrrmbY5S4bLOSZaGHWcTeKtk8uuWVj4l82Zh0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqtj6MmSeY/4jsXVU1L7V40S1L7pdOSRfdRKUkSHQdY=;
 b=zp2KImE9s1nRO48JbaIVRDyAkJ6kpBUk4xwP/9rYrquzN92DoSDIkwMbxPKXTQB2RbSw1d0DaHzXH/HT5s3tqoV6Y3ElTzFLUwUlyvfe2eM61kZ/4hnLdt+sXyxx8VhsyMsMF/SeQafaXsOB3tMP8EFFB1icE6PrcRSSWKTpJtc=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR12MB1178.namprd12.prod.outlook.com (2603:10b6:3:6c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 08:17:14 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401%7]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 08:17:13 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the page fault issue in amdgpu_irq_fini
Thread-Topic: [PATCH] drm/amdgpu: Fix the page fault issue in amdgpu_irq_fini
Thread-Index: AQHXG+yhCa6unoCaykSq6jwzYyG13qqJomwAgADm2QCAAG5fYA==
Date: Fri, 19 Mar 2021 08:17:13 +0000
Message-ID: <DM5PR12MB2533DDFD16D3DAB06E3FF811ED689@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210318114812.407295-1-Emily.Deng@amd.com>
 <173acde7-b3ed-9a3f-5191-60158af45895@gmail.com>
 <BY5PR12MB4115813BBC9E921FD6C24AB48F689@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115813BBC9E921FD6C24AB48F689@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-19T08:16:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36afb201-d9c7-4020-930a-f7be769e8279;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ecf7534-b455-426d-27d7-08d8eaaf66e3
x-ms-traffictypediagnostic: DM5PR12MB1178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11785CBA5BB8DFDFC8112244ED689@DM5PR12MB1178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGnvlHbsRpdkMKQQPNDc3ymezfmJWzsqi9C56O7B1K3zPchSvUoHqQ56xcaTzTkzwPrxoo0AfSlyDTDBUfgsODElr0/C7vQn54G+5EGR/SGhFxm0lHH+IPUge2RU27QCKVS5EqW7Ue1zehXlHTuqUDhql/uT++PfevaEaacYWG6DNX/oXHiLFzOKej8RnZbHkuyQ2BGxo/wsH/zjyo0xv41j1IzIYrEwb/gQTd+xNO3WMJdBPMCYxqbDwReq8ozeeGskHfPk4qB+/cWqPCPx3IZVE/kL5YfZBav+o09qx4kMkrElV+SSJfrVwB0vjMDplT3qtjMbzXXx4JtCTMxGzh7ZhFyxbG5OEPD5v/FdeF53ee8AEE9P4O2gT9IPMYZ0eclfv0fCKF7IuOFe1YSaN6uTgmr9FMNqPuy7im1I++r2hOYzbIkxPFmCKtMT1WPsLhCwUGOrwR8qguZhhrIKIZfqLL4kNy8UMJl63n0vwc0cWNQsUTEUISS3KNV0JHT5Bgl87RXBAxJZU1i0YT7hRfOm4XGfoYrHlEejMKQJaELzu9V53CaNSDxWNe8JJay8oGkHkRg+vcTuLV3CalIBkuuBzdeAi7CTxbOhifHRKbCyJ3zpHqoJ+kUU1Jfpu9nIxrmxnsUgB3gaEaFgaWNtu43Q15wELXzlr31oZQAJJDnZkXQ679RYqiil2xokRwv1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(83380400001)(76116006)(7696005)(66946007)(64756008)(966005)(38100700001)(66446008)(316002)(55016002)(66476007)(2906002)(6506007)(52536014)(8676002)(5660300002)(8936002)(478600001)(9686003)(66556008)(186003)(33656002)(53546011)(71200400001)(110136005)(26005)(45080400002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bnV3RytqdnpDWSttZGtkSm5EMEtqQUJKTmV3Q0tQa3IzUnkyUUpabHFQSkpi?=
 =?utf-8?B?djZuODRRQUpyKzRnd3Z3YVlrL05iZ042V242dWwwTExoRHhIM3g3WkNtQ0Vz?=
 =?utf-8?B?TGpLZFFTZFlRSDdhdllqcTdLY05HRlJ6K3dSM2M0d01SWWd3U1BEOXNaelZ5?=
 =?utf-8?B?dzlsR3YxSkpEQ3N3QjNqRGsxOFdFQlVyYTFwemhucGhGTXBQRytxY1U5dFM5?=
 =?utf-8?B?VUxwaFBuUExodWZKcStUVDFRU0ZpUzl2Ykc3b3lWZkFTWHJVVW5nK1NldDg5?=
 =?utf-8?B?L3M1R01oYk9ldXdOSlNNbWRIbW1paXdUcEU2S1VQdXR6RXFESk1rWGxmVTU1?=
 =?utf-8?B?ZkMwWTZjcCtkWlpCc3l4QkRvd1FvRzRkdVU1RERrSlJCYldLSDFpbHJYdThy?=
 =?utf-8?B?OXFWa1c2dC9Tb2RET20rWGwvaEVhNHNPcTBRZFBQaTVoUjVTQUNXVWlrOWsv?=
 =?utf-8?B?OVdBcm4zVHlnRTRsbG5tMzJOWWlYVUV0UVMydGZxY2tIRzZYL1VvTjQ4bGFa?=
 =?utf-8?B?M1lmWmNBc0lpZnZuNVVOdHplVGJEK0xuYW1od2hpR2cyNE9HUUMvRGhjR1Ji?=
 =?utf-8?B?WkFvVnBnK1hSOGVCR3BoWkg2RjRTcVB0Rm5QdnlkMEdHaUdlUXpXcFpzZnNi?=
 =?utf-8?B?czFnUHIxdUxaSHk4L2h1NUFVWWlGM291TTFPbytab3NHOFBZUVVOUHI2V0hV?=
 =?utf-8?B?aG0ySzcxYzJzNTl3SFJxbDVrdkFlbkh6V2E5NTB2L3JEM1B5YUc3OU1SRm1Z?=
 =?utf-8?B?a2R6N2daZ0FGUEdPYmdKRVorZUtHSjI5MGJ3TS9IUjM5VTZrMHVacW83NnJ5?=
 =?utf-8?B?dnpaVkNPN3laMURyKzF0TjIzWWExSTRqNjR2Q1k2MWVQcEdWMWVnN3dZNXhP?=
 =?utf-8?B?UlZqR2hyTEFBcndHQkF0OFJSRU1BaTdrVllHT1lLNE44R3JKL0YyTnpuaTNR?=
 =?utf-8?B?OVNrdEM5cVlSSytQVXdJTDN5YUM4cDlPSkNaQ1BtbkNQdkVpTU5wdWR1d2JM?=
 =?utf-8?B?SnRuUXVYZk5CK1VCbzZxeGZSVjBFZUhqSHEwSDg3bldHMVlHV25meUdpYnZU?=
 =?utf-8?B?djRXU1V0cFJUUGVwNkhzREtyL3JxWWNKZnMyMnBWcWNoOE1pMGdGc3VoU3lF?=
 =?utf-8?B?Rm9kSGo4STNGcFlLcElrY2hoVlRRRnp3SmpEQ2dEdC9SRStyS2tnTHNkbUtF?=
 =?utf-8?B?dkREa0lrZDU4Nm1MRmJqYWZVWS9aU21Rc1M0OHo3emwzeE0yM0l2OG1uQ2h3?=
 =?utf-8?B?anYxZnpIZk1neEJlNm9jRkIzakx1WElKRXhYc1doVzYvdUpjVGloa2cydEdP?=
 =?utf-8?B?emQxRTIwamxsUlpzWkFKRjhVMjFrQlpXRWpxSURjZ04rcS92aUE5bHh6U3Jk?=
 =?utf-8?B?TDRTZHc0NTN1b1V5RVlyVjI4d3hIcGNjYjJYNUl4a0lwS0VkNCt2eGNNT0Vq?=
 =?utf-8?B?OFM3Ylp4bFlEbzBzRHA1YkFiRG5DbW9SV0tUckFHekNOem1KVE15MFQzYnhR?=
 =?utf-8?B?eHJyVW0xSkgrYmM2Y3ZBQnArZWYvWHE1eGZ6bHhoNHhaclk4a0E0cmNhbFJ2?=
 =?utf-8?B?dm5pVjdOUjcweXR2V0wzTFR6RWc2OU5Ec1o3SitkWGZYem83VWtPSVc2Qit2?=
 =?utf-8?B?c3J1UE0xRld5TGV0OG0yNjk5MkZIUTBsNXZ3RG5FVHlweGJBODdUUEVzMkJk?=
 =?utf-8?B?SCtwZTlEWUptc3JKSFN6aW1rM0pBTWF6ZjQvRThaeU1UVzRHVUNjSDVQOWdr?=
 =?utf-8?Q?MGLoXJLQkC/ImP0+uDYbOnkH/OA4Ucw1iNHApta?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecf7534-b455-426d-27d7-08d8eaaf66e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 08:17:13.8275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krTok0FZrqrc6l5sz8dk44GUllbK7Uurcdhti4K4ltH0DrYMTsjJElkwwT0Bo2oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSwgRW1pbHksDQogICAgICBXaGF0IGFib3V0IHJlZmluZSBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMg
d2l0aCByZWZjb3VudD8gWW91ciBjaGFuZ2UgY291bGQgZml4IHRoaXMgaXNzdWUsIGJ1dCBpdCBp
cyB1bnJlYWRhYmxlLiANCg0KQmVzdCBSZWdhcmRzDQpEZW5uaXMgTGkNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRGVuZywgRW1pbHkNClNlbnQ6IEZyaWRheSwgTWFyY2gg
MTksIDIwMjEgOTozOCBBTQ0KVG86IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6
IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCB0aGUgcGFnZSBmYXVsdCBpc3N1ZSBpbiBhbWRn
cHVfaXJxX2ZpbmkNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1
dGlvbiBPbmx5XQ0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0
aW9uIE9ubHldDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENocmlzdGlh
biBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPlNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAxOCwgMjAyMSA3OjUyIFBNDQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5n
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IEZpeCB0aGUgcGFnZSBmYXVsdCBpc3N1ZSBpbiANCj5hbWRncHVf
aXJxX2ZpbmkNCj4NCj5BbSAxOC4wMy4yMSB1bSAxMjo0OCBzY2hyaWViIEVtaWx5IERlbmc6DQo+
PiBGb3Igc29tZSBzb3VyY2UsIGl0IHdpbGwgYmUgc2hhcmVkIGJ5IHNvbWUgY2xpZW50IElEIGFu
ZCBzb3VyY2UgSUQuDQo+PiBUbyBmaXggdGhlIHBhZ2UgZmF1bHQgaXNzdWUsIHNldCBhbGwgdGhv
c2UgdG8gbnVsbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5n
QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lycS5jIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pcnEuYw0KPj4gaW5kZXggYWYwMjYxMDk0MjFhLi42MjNiMWFjNjIzMWQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYw0KPj4gQEAg
LTM1OSw3ICszNTksNyBAQCBpbnQgYW1kZ3B1X2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KPj4gICAgKi8NCj4+ICAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+PiAgIHsNCj4+IC11bnNpZ25lZCBpLCBqOw0KPj4gK3Vuc2lnbmVk
IGksIGosIG0sIG47DQo+Pg0KPj4gICBpZiAoYWRldi0+aXJxLmluc3RhbGxlZCkgew0KPj4gICBk
cm1faXJxX3VuaW5zdGFsbChhZGV2X3RvX2RybShhZGV2KSk7DQo+PiBAQCAtMzgwLDEyICszODAs
MjIgQEAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4qYWRldikN
Cj4+ICAgaWYgKCFzcmMpDQo+PiAgIGNvbnRpbnVlOw0KPj4NCj4+IC1rZnJlZShzcmMtPmVuYWJs
ZWRfdHlwZXMpOw0KPj4gK2lmIChzcmMtPmVuYWJsZWRfdHlwZXMpDQo+PiAra2ZyZWUoc3JjLT5l
bmFibGVkX3R5cGVzKTsNCj4NCj5BIE5VTEwgY2hlY2sgYmVmb3JlIGtmcmVlKCkgaXMgdW5lY2Vz
c2FyeSBhbmQgd2lsbCBiZSBjb21wbGFpbmVkIGFib3V0IA0KPmJ5IHRoZSBzdGF0aWMgY2hlY2tl
cnMuDQpTb3JyeSwgd2lsbCByZW1vdmUgdGhpcy4NCj4NCj4+ICsNCj4+ICAgc3JjLT5lbmFibGVk
X3R5cGVzID0gTlVMTDsNCj4+ICsNCj4NCj5VbnJlbGF0ZWQgd2hpdGUgc3BhY2UgY2hhbmdlLg0K
U29ycnksIHdpbGwgcmVtb3ZlIHRoaXMgYWxzby4NCj4NCj4+ICAgaWYgKHNyYy0+ZGF0YSkgew0K
Pj4gICBrZnJlZShzcmMtPmRhdGEpOw0KPj4gICBrZnJlZShzcmMpOw0KPj4gLWFkZXYtPmlycS5j
bGllbnRbaV0uc291cmNlc1tqXSA9IE5VTEw7DQo+PiArfQ0KPj4gKw0KPj4gK2ZvciAobSA9IDA7
IG0gPCBBTURHUFVfSVJRX0NMSUVOVElEX01BWDsgKyttKSB7IGlmIA0KPj4gKyghYWRldi0+aXJx
LmNsaWVudFttXS5zb3VyY2VzKSBjb250aW51ZTsgZm9yIChuID0gMDsgbiA8IA0KPj4gK0FNREdQ
VV9NQVhfSVJRX1NSQ19JRDsNCj4rK24pDQo+PiAraWYgKGFkZXYtPmlycS5jbGllbnRbbV0uc291
cmNlc1tuXSA9PQ0KPnNyYykNCj4+ICthZGV2LT5pcnEuY2xpZW50W21dLnNvdXJjZXNbbl0NCj49
IE5VTEw7DQo+DQo+SHVpIHdoYXQ/IFRoZSBtZW1vcnkgeW91IHNldCB0byBOVUxMIGhlcmUgaXMg
ZnJlZWQgb24gdGhlIGxpbmUgYmVsb3cuDQo+DQo+QWNjZXNzaW5nIGl0IGFmdGVyIHRoYXQgd291
bGQgYmUgaWxsZWdhbCwgc28gd2h5IGRvIHlvdSB3YW50IHRvIHNldCBpdCB0byBOVUxMPw0KW0Vt
aWx5XSBJdCBpcyBpbiB0aGUgbG9vcCAiZm9yIChqID0gMDsgaiA8IEFNREdQVV9NQVhfSVJRX1NS
Q19JRDsgKytqKSB7Iiwgc2hvdWxkbid0IGhhdmUgYmVlbiBmcmVlZCBpbiB0aGlzIGxvb3AuIE9u
bHkgc2V0ICIgYWRldi0+aXJxLmNsaWVudFtpXS5zb3VyY2VzW2pdID0gTlVMTDsiIGlzIG5vdCBl
bm91Z2gsIGFzIGl0IG1heWJlIGhhdmUgb3RoZXIgY2xpZW50IElEIGFuZCBzcmMgSUQgd2lsbCBz
aGFyZSB0aGUgc2FtZSBzcmMuIEFsc28gbmVlZCB0byBzZXQgdGhvc2UgdG8gTlVMTC4NCj4NCj5D
aHJpc3RpYW4uDQo+DQo+PiAgIH0NCj4+ICAgfQ0KPj4gICBrZnJlZShhZGV2LT5pcnEuY2xpZW50
W2ldLnNvdXJjZXMpOw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8l
MkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NEZW5uaXMuTGklNDBhbWQuY29tJTdDM2U5NGVi
ZjZmMWQzNGUzMTg5OGUwOGQ4ZWE3N2I2MTMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NTE3MTQ3MTc1NDc4MTY2JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPW0yc1FXNE5jdjQwSzk3d3hPZ0MlMkJTRmlUOHlo
eTY5OTZFJTJGUiUyRk1XTG9oNjQlM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
