Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A9D20776
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C676E0F8;
	Tue, 19 Jan 2021 17:09:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621AA6E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 17:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB46LN31tS9L1++zwYj0lJrRBJf7d660fMnaEJs90Kn0L+QrMB+A885bC28jeQg5UVIoaWdk4bEJt1edN6j9a7gzAXfqDSKcmlMVZQdjCnHm2xKN8LFXleMAsXEvkoaljJIcs/mXtQa7OtwyvgaIVujF0x9vm+fT5N+/fo2cqoLiy633G+SQAe3+CZOqkE5f9LC7dxguq+aGVz/nxVtBjV5OkXdFxC5hx/VCA+NdHTEXCa7t+GDYL1ksyr48y6NCWT/ZJw3ziBJsrhb2tQzjYw5gl1HdM1EPEULkgQMMCgg4uELq36N1nPZj3ZvCpEMYWNVEfOuS0wAWGlcC2CBrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWZ8omBBqwoUXIP5G3w5+oWJiMYffkkHGKp1Zl8BtBI=;
 b=JQTFhEdGCxZYMjeAJkD8z+GZ+Wv20lExDW67C0+eN+vzT54Qby3bg6dkSCFMeAp8k/5Ps3zhtLKJwUJ8HWs0yxC+0/Jn60kmyXdX5G/wdFrqMEu68+od7F/KQJiJR3oLlvEhmp73R/tnH/wd/gD2HUojzGAFX2NSqgFuFQg6d2N9GXA94viYP786yKhQEfKbKx8xi6kvsuiuueoEkFqqtrfJ9afi9UD8PYNIRXSowGuoQYWct0+i+m4Q6RPnTIR2lKReGlk0d2o/CcaVjsIco0mDfenxB6YHjaXD+2vF139vxzRtC6u7suV4EOrIRvLPnjX7xEeaurvBItRa7HfqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWZ8omBBqwoUXIP5G3w5+oWJiMYffkkHGKp1Zl8BtBI=;
 b=AWyWN78M2nWd+7CmYs3geIlR2jP99564hLpD/fbTmnlMVIwVSkIhcBzMe2Z+A1yEumooWccqAuDrhjPfW9tEA5/IAF6CvHrzU3tlPKAJ8ULyuxrRI1NzWoKFwJun/HFhCaChKsm5dNmlqnf/D//R6O/PiGwXMcOHJsxgjXi3zj0=
Received: from CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23)
 by CY4PR1201MB0021.namprd12.prod.outlook.com (2603:10b6:910:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 17:09:16 +0000
Received: from CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0]) by CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0%9]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 17:09:16 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogcmFjZSBpc3N1?=
 =?gb2312?Q?e_when_jobs_on_2_ring_timeout?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogcmFjZSBpc3N1ZSB3aGVu?=
 =?gb2312?Q?_jobs_on_2_ring_timeout?=
Thread-Index: AQHW7l3KPN/nhp3RQUq08BpKjF1LaqovA2gAgAAdf+OAAAr7AIAAAeRw
Date: Tue, 19 Jan 2021 17:09:16 +0000
Message-ID: <CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
References: <20210119122236.8039-1-horace.chen@amd.com>
 <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
 <CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com>,
 <bb133853-4291-1c6e-36ee-1eb05854c56a@amd.com>
In-Reply-To: <bb133853-4291-1c6e-36ee-1eb05854c56a@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-19T17:09:20.210Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [61.152.208.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92e191df-6dba-4cec-cd5e-08d8bc9cf3e6
x-ms-traffictypediagnostic: CY4PR1201MB0021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0021038088181751F92B7C91E1A30@CY4PR1201MB0021.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OgTgYo7K6y/mLMBefxzkRUQUOt/pjHE94PLed5lHjIAFasWu9wTWm+eUH7pls3gWx914wLIS0BGvRSGjV0Fht2y1YF8SIIBsJ5UofQh+3E3feusbTx/s9cN6JiUbdihPhWlfj+PfSUN0bFedz6yOvEW5DjvngSHo8w++v1lYpMf8rU8sdeG9N713Esgbsf8QwkiAnHiiRhBs7SY/VePicbevFn3BKEvtiyIvDJU6SnNwmDPOyAp2hIDU5uLfoC93vqtg88lyVftomCQdIDVNZiAwt9SJBoUirMI8q9JjnjWWqIptko5lCxbQNjTOhIWnkLx03vHCiM9r2FVSG3Gav71bkLnwyGebPe2NMZeEDcaTV3yNiJGileON7aTRT86EgPpWSKzIFb7A6pBHgI+kEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1573.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(2906002)(316002)(110136005)(33656002)(83380400001)(6506007)(4326008)(5660300002)(76116006)(66556008)(54906003)(71200400001)(53546011)(86362001)(91956017)(52536014)(9686003)(186003)(66946007)(478600001)(66476007)(7696005)(19627405001)(66446008)(55016002)(64756008)(8936002)(224303003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?ZWpqcXRQY2tDcW5lWENkZDBwUGZ3UzFpZGtvbnhLR1Z3cTNZMUMwdnp1U05l?=
 =?gb2312?B?K0tCSmVNVTdpTzlMQm5ITUMwc3p4Ui83NFcrSk95c1JPU3FUbklhUk9jdUpB?=
 =?gb2312?B?MERmWS8wMUUzc2NXV29qMjFpMG55Tm84MDlwVDZyVnYzRGU0RzFwRENZcTlp?=
 =?gb2312?B?MDZEd3lCbm9EUzlKZFk5UmxzNmlwSnF1ajh2WWVYaGJ6aGJ1bjQ1WE5iaWYw?=
 =?gb2312?B?OXZzL2s5TXRKSStLSjJmeWFHUTNJTkJQOWh4cm11cEdDc1REU2NlZ1NjcnpR?=
 =?gb2312?B?ZlZSQ21GZWtjSU9RTThNRGgvZGhsZXpPaG9DYkhtQTBwTTNJaDY2eUo1YVkx?=
 =?gb2312?B?bXpmbGVvZjI2YVl6dEpURG1RcFpSL2YwUmgyTFY4eVF1OEc1LzFycWJkNmRH?=
 =?gb2312?B?RGZCTktpOWlYRjdienpTZVY0MFpHeTNWMVFnMzRaMXlQQytUaXllTTNlaEVI?=
 =?gb2312?B?SFpSWktmREROL3VTa294TndFUG51dVB3RmFmdzJ2eGZna0MvcUE0SGpYVk05?=
 =?gb2312?B?RC9JamJlRVBMdWh4SzV2MXJ2UDJBc21QM1cvRHJibmJIK0RBL0xuRCtMQm1y?=
 =?gb2312?B?ZXZocFZEbGw4dFNMOHpQajFLVmo3OW9lYkR0NllQR0EwOWNYY2dBRXhxUThz?=
 =?gb2312?B?ejlGb05IZjcvVDNYQ1MxZ3BWc3JRQzE0eFRENHlyMER1dVpYR0ZzZWZaMjl1?=
 =?gb2312?B?UmZTQ1dQU3QxYWp6c1FaQnFKeUx3dU1yNm1aOW5xem9XYkkvZDJOSjBrMi9p?=
 =?gb2312?B?VXJkK0dXYjdiRjZWUXBVbjBVTUt0azNXaERMSERneXY0R3R4WTcxay9DZU9p?=
 =?gb2312?B?dU1NamVsMnRWUi81MjlHNk9Sbm5ycDlEaFd4dHJGcHl3c1lTRi9CT2h1aGNt?=
 =?gb2312?B?c3RXL1ZwcGRKelArZEF6NVVBbUduQVpocE1XdUhlU2tmUU9Lalp6cmFRazE5?=
 =?gb2312?B?Y3hVUHZ1UGUxWTFwSEdGT1Bmc1N2c3RqWG1zWVZRRHpIYnAxUUpEU2VMQkFY?=
 =?gb2312?B?YlNoOVAwelBpc09KUElmaUIyeWhlUk1FTjlJUGI0WXp6RS9CNzdPb0xZdWE1?=
 =?gb2312?B?Z1dDeGdNYkI3Y0xwOEFlMHFMSG05dHdqNDVWaTZ3M3ZmelBCS3gvRnFLTnFt?=
 =?gb2312?B?MWhuZ1M1bGxDd2RPbWwvZktwQzZudmpBeWpRQWRQL0pycms2aDZoZ3d3a2ht?=
 =?gb2312?B?bFpyQ1RqWVBvL1ZMeDBSL1NxeFlVYklSZFBDMGo3ZExuejNNcGpzWTg4bUsx?=
 =?gb2312?B?Z3BwNUhGNlh6NjI0NEhJWURjV1JDbmVBSVRyY1pTcStTMWM4TGh6NWkyWXNG?=
 =?gb2312?Q?oyFd7zAZCmnrQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e191df-6dba-4cec-cd5e-08d8bc9cf3e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 17:09:16.3165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjG5dYBsf8+SpCQ3nyGz1b3q060aXamnRiTBngT7P+oo+ou/UgGf1Do1Efa5DkFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0021
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0292449839=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0292449839==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30CY4PR12MB1573namp_"

--_000_CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30CY4PR12MB1573namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpP
SywgSSB1bmRlcnN0YW5kLiBZb3UgbWVhbiBvbmUgZGV2aWNlIGluIHRoZSBoaXZlIG1heSBiZSBs
b2NrZWQgdXAgaW5kZXBlbmRlbnRseSB3aXRob3V0IGxvY2tpbmcgdXAgdGhlIHdob2xlIGhpdmUu
DQoNCkl0IGNvdWxkIGhhcHBlbiwgSSdsbCBjaGFuZ2UgbXkgY29kZS4NCg0KVGhhbmtzICYgUmVn
YXJkcywNCkhvcmFjZS4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7I
yzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPg0Kt6LLzcqx
vOQ6IDIwMjHE6jHUwjIwyNUgMDo1OA0KytW8/sjLOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVu
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+DQqzrcvNOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IFR1
aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWmhhbmcsIEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtl
dmluMS5XYW5nQGFtZC5jb20+OyBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPg0K
1vfM4jogUmU6ILvYuLQ6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHJhY2UgaXNzdWUgd2hlbiBq
b2JzIG9uIDIgcmluZyB0aW1lb3V0DQoNCg0KDQpPbiAxLzE5LzIxIDExOjM5IEFNLCBDaGVuLCBI
b3JhY2Ugd3JvdGU6DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmli
dXRpb24gT25seV0NCg0KSGkgQW5kcmV5LA0KDQpJIHRoaW5rIHRoZSBsaXN0IGluIHRoZSBYR01J
IGhpdmUgd29uJ3QgYmUgYnJlYWsgaW4gdGhlIG1pZGRsZSBpZiB3ZSBsb2NrIHRoZSBkZXZpY2Ug
YmVmb3JlIHdlIGNoYW5nZSB0aGUgbGlzdC4gQmVjYXVzZSBpZiAyIGRldmljZXMgaW4gMSBoaXZl
IHdlbnQgaW50byB0aGUgZnVuY3Rpb24sIGl0IHdpbGwgZm9sbG93IHRoZSBzYW1lIHNlcXVlbmNl
IHRvIGxvY2sgdGhlIGRldmljZXMuIFNvIG9uZSBvZiB0aGVtIHdpbGwgZGVmaW5hdGVseSBicmVh
ayBhdCB0aGUgZmlyc3QgZGV2aWNlLiBJIGFkZCBpdGVyYXRlIGRldmljZXMgaGVyZSBpcyBqdXN0
IHRvIGxvY2sgYWxsIGRldmljZSBpbiB0aGUgaGl2ZSBzaW5jZSB3ZSB3aWxsIGNoYW5nZSB0aGUg
ZGV2aWNlIHNlcXVlbmNlIGluIHRoZSBoaXZlIHNvb24gYWZ0ZXIuDQoNCg0KSSBkaWRuJ3QgbWVh
biBicmVhayBpbiBhIHNlbnNlIG9mIGJyZWFraW5nIHRoZSBsaXN0IGl0c2VsZiwgSSBqdXN0IG1l
YW50IHRoZSBsaXRlcmFsICdicmVhaycgaW5zdHJ1Y3Rpb24NCnRvIHRlcm1pbmF0ZSB0aGUgaXRl
cmF0aW9uIG9uY2UgeW91IGZhaWxlZCB0byBsb2NrIGEgcGFydGljdWxhciBkZXZpY2UuDQoNCg0K
VGhlIHJlYXNvbiB0byBicmVhayB0aGUgaW50ZXJhdGlvbiBpbiB0aGUgbWlkZGxlIGlzIHRoYXQg
dGhlIGxpc3QgaXMgY2hhbmdlZCBkdXJpbmcgdGhlIGl0ZXJhdGlvbiB3aXRob3V0IHRha2luZyBh
bnkgbG9jay4gSXQgaXMgcXVpdGUgYmFkIHNpbmNlIEknbSBmaXhpbmcgb25lIG9mIHRoaXMgaXNz
dWUuIEFuZCBmb3IgWEdNSSBoaXZlLCB0aGVyZSBhcmUgMiBsb2NrcyBwcm90ZWN0aW5nIHRoZSBs
aXN0LCBvbmUgaXMgdGhlIGRldmljZSBsb2NrIEkgY2hhbmdlZCBoZXJlLCB0aGUgb3RoZXIgb25l
IGlzIGluIGZyb250IG9mIG15IGNoYW5nZSwgdGhlcmUgaXMgYSBoaXZlLT5sb2NrIHRvIHByb3Rl
Y3QgdGhlIGhpdmUuDQoNCkV2ZW4gdGhlIGJhZCB0aGluZyByZWFsbHkgaGFwcGVuZWQsIEkgdGhp
bmsgbW92aW5nIGJhY2sgdGhyb3VnaCB0aGUgbGlzdCBpcyBhbHNvIHZlcnkgZGVuZ2Vyb3VzIHNp
bmNlIHdlIGRvbid0IGtub3cgd2hhdCB0aGUgbGlzdCBmaW5hbGx5IGJlLCBVbmxlc3Mgd2Ugc3Rh
Y2sgdGhlIGRldmljZXMgd2UgaGF2ZSBpdGVyYXRlZCB0aHJvdWdoIGEgbWlycm9yZWQgbGlzdC4g
VGhhdCBjYW4gYmUgYSBiaWcgY2hhbmdlLg0KDQoNCk5vdCBzdXJlIHdlIGFyZSBvbiB0aGUgc2Ft
ZSBwYWdlLCBteSBjb25jZXJuIGlzIGxldCdzIHNhdCB5b3VyIFhHTUkgaGl2ZSBjb25zaXN0cyBv
ZiAyIGRldmljZXMsIHlvdSBtYW5nZWQgdG8gY2FsbCBzdWNjZXNzZnVsbHkgZG8NCmFtZGdwdV9k
ZXZpY2VfbG9ja19hZGV2IGZvciBkZXYxIGJ1dCB0aGVuIGZhaWxlZCBmb3IgZGV2MiwgaW4gdGhp
cyBjYXNlIHlvdSB3aWxsIGJhaWwgb3V0ICB3aXRob3V0IHJlbGVhc2luZyBkZXYxLCBubyA/DQoN
Cg0KQW5kcmV5DQoNCg0KDQpJJ20gb2sgdG8gc2VwZXJhdGUgdGhlIGxvY2tpbmcgaW4gYW1kZ3B1
X2RldmljZV9sb2NrX2FkZXYgaGVyZSwgSSdsbCBkbyBzb21lIHRlc3QgYW5kIHVwZGF0ZSB0aGUg
Y29kZSBsYXRlci4NCg0KVGhhbmtzICYgUmVnYXJkcywNCkhvcmFjZS4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQq3orz+yMs6IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdy
b2R6b3Zza3lAYW1kLmNvbT48bWFpbHRvOkFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+DQq3osvN
yrG85DogMjAyMcTqMdTCMTnI1SAyMjozMw0KytW8/sjLOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5D
aGVuQGFtZC5jb20+PG1haWx0bzpIb3JhY2UuQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiA8YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+PG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCrOty806IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjxtYWlsdG86RXZh
bi5RdWFuQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT48bWFp
bHRvOkx1YmVuLlR1aWtvdkBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT48bWFpbHRvOkNocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT48bWFpbHRvOkFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNvbT48bWFpbHRvOkph
Y2suWGlhb0BhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT48
bWFpbHRvOkhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT48bWFpbHRvOk1vbmsuTGl1QGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNv
bT48bWFpbHRvOkZlaWZlaS5YdUBhbWQuY29tPjsgV2FuZywgS2V2aW4oWWFuZykgPEtldmluMS5X
YW5nQGFtZC5jb20+PG1haWx0bzpLZXZpbjEuV2FuZ0BhbWQuY29tPjsgWGlhb2ppZSBZdWFuIDx4
aWFvamllLnl1YW5AYW1kLmNvbT48bWFpbHRvOnhpYW9qaWUueXVhbkBhbWQuY29tPg0K1vfM4jog
UmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHJhY2UgaXNzdWUgd2hlbiBqb2JzIG9uIDIgcmlu
ZyB0aW1lb3V0DQoNCg0KT24gMS8xOS8yMSA3OjIyIEFNLCBIb3JhY2UgQ2hlbiB3cm90ZToNCj4g
Rml4IGEgcmFjaW5nIGlzc3VlIHdoZW4gam9icyBvbiAyIHJpbmdzIHRpbWVvdXQgc2ltdWx0YW5l
b3VzbHkuDQo+DQo+IElmIDIgcmluZ3MgdGltZWQgb3V0IGF0IHRoZSBzYW1lIHRpbWUsIHRoZSBh
bWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyDQo+IHdpbGwgYmUgcmVlbnRlcmVkLiBUaGVuIHRoZSBh
ZGV2LT5nbWMueGdtaS5oZWFkIHdpbGwgYmUgZ3JhYmJlZA0KPiBieSAyIGxvY2FsIGxpbmtlZCBs
aXN0LCB3aGljaCBtYXkgY2F1c2Ugd2lsZCBwb2ludGVyIGlzc3VlIGluDQo+IGl0ZXJhdGluZy4N
Cj4NCj4gbG9jayB0aGUgZGV2aWNlIGVhcmlseSB0byBwcmV2ZW50IHRoZSBub2RlIGJlIGFkZGVk
IHRvIDIgZGlmZmVyZW50DQo+IGxpc3RzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhY2UgQ2hl
biA8aG9yYWNlLmNoZW5AYW1kLmNvbT48bWFpbHRvOmhvcmFjZS5jaGVuQGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQyICsr
KysrKysrKysrKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMNCj4gaW5kZXggNGQ0MzQ4MDNmYjQ5Li45NTc0ZGEzYWJjMzIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTQ1NDAs
NiArNDU0MCw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LA0KPiAgICAgICAgaW50IGksIHIgPSAwOw0KPiAgICAgICAgYm9vbCBuZWVk
X2VtZXJnZW5jeV9yZXN0YXJ0ID0gZmFsc2U7DQo+ICAgICAgICBib29sIGF1ZGlvX3N1c3BlbmRl
ZCA9IGZhbHNlOw0KPiArICAgICBib29sIGdldF9kZXZfbG9jayA9IGZhbHNlOw0KPg0KPiAgICAg
ICAgLyoNCj4gICAgICAgICAqIFNwZWNpYWwgY2FzZTogUkFTIHRyaWdnZXJlZCBhbmQgZnVsbCBy
ZXNldCBpc24ndCBzdXBwb3J0ZWQNCj4gQEAgLTQ1ODIsMjggKzQ1ODMsNDUgQEAgaW50IGFtZGdw
dV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAg
ICAgKiBCdWlsZCBsaXN0IG9mIGRldmljZXMgdG8gcmVzZXQuDQo+ICAgICAgICAgKiBJbiBjYXNl
IHdlIGFyZSBpbiBYR01JIGhpdmUgbW9kZSwgcmVzb3J0IHRoZSBkZXZpY2UgbGlzdA0KPiAgICAg
ICAgICogdG8gcHV0IGFkZXYgaW4gdGhlIDFzdCBwb3NpdGlvbi4NCj4gKyAgICAgICoNCj4gKyAg
ICAgICogbG9jayB0aGUgZGV2aWNlIGJlZm9yZSB3ZSB0cnkgdG8gb3BlcmF0ZSB0aGUgbGlua2Vk
IGxpc3QNCj4gKyAgICAgICogaWYgZGlkbid0IGdldCB0aGUgZGV2aWNlIGxvY2ssIGRvbid0IHRv
dWNoIHRoZSBsaW5rZWQgbGlzdCBzaW5jZQ0KPiArICAgICAgKiBvdGhlcnMgbWF5IGl0ZXJhdGlu
ZyBpdC4NCj4gICAgICAgICAqLw0KPiAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0
KTsNCj4gICAgICAgIGlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7
DQo+ICAgICAgICAgICAgICAgIGlmICghaGl2ZSkNCj4gICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT0RFVjsNCj4gLSAgICAgICAgICAgICBpZiAoIWxpc3RfaXNfZmlyc3QoJmFkZXYt
PmdtYy54Z21pLmhlYWQsICZoaXZlLT5kZXZpY2VfbGlzdCkpDQo+IC0gICAgICAgICAgICAgICAg
ICAgICBsaXN0X3JvdGF0ZV90b19mcm9udCgmYWRldi0+Z21jLnhnbWkuaGVhZCwgJmhpdmUtPmRl
dmljZV9saXN0KTsNCj4gLSAgICAgICAgICAgICBkZXZpY2VfbGlzdF9oYW5kbGUgPSAmaGl2ZS0+
ZGV2aWNlX2xpc3Q7DQo+ICsNCj4gKyAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHRt
cF9hZGV2LCAmaGl2ZS0+ZGV2aWNlX2xpc3QsIGdtYy54Z21pLmhlYWQpIHsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGdldF9kZXZfbG9jayA9IGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2KHRtcF9h
ZGV2LCBoaXZlKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghZ2V0X2Rldl9sb2NrKQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCg0KDQpXaGF0IGFib3V0IHVu
bG9ja2luZyBiYWNrIGFsbCB0aGUgZGV2aWNlcyB5b3UgYWxyZWFkeSBsb2NrZWQgaWYgdGhlIGJy
ZWFrDQpoYXBwZW5zIGluIHRoZSBtaWRkbGUgb2YgdGhlIGl0ZXJhdGlvbiA/DQpOb3RlIHRoYXQg
YXQgc2tpcF9yZWNvdmVyeTogd2UgZG9uJ3QgZG8gaXQuIEJUVywgaSBzZWUgdGhpcyBpc3N1ZSBp
cyBhbHJlYWR5IGluDQp0aGUgY3VycmVudCBjb2RlLg0KDQpBbHNvLCBtYXliZSBub3cgaXQncyBi
ZXR0ZXIgdG8gc2VwYXJhdGUgdGhlIGFjdHVhbCBsb2NraW5nIGluDQphbWRncHVfZGV2aWNlX2xv
Y2tfYWRldg0KZnJvbSB0aGUgb3RoZXIgc3R1ZmYgZ29pbmcgb24gdGhlcmUgc2luY2UgSSBkb24n
dCB0aGluayB5b3Ugd291bGQgd29udCB0byB0b2dnbGUNCnN0dWZmDQpsaWtlIGFkZXYtPm1wMV9z
dGF0ZSBiYWNrIGFuZCBmb3J0aCBhbmQgYWxzbyB0aGUgZnVuY3Rpb24gbmFtZSBpcyBub3QNCmRl
c2NyaXB0aXZlIG9mDQp0aGUgb3RoZXIgc3R1ZmYgZ29pbmcgb24gdGhlcmUgYW55d2F5Lg0KDQpB
bmRyZXkNCg0KDQo+ICsgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIGlmIChnZXRfZGV2
X2xvY2spIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghbGlzdF9pc19maXJzdCgmYWRl
di0+Z21jLnhnbWkuaGVhZCwgJmhpdmUtPmRldmljZV9saXN0KSkNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbGlzdF9yb3RhdGVfdG9fZnJvbnQoJmFkZXYtPmdtYy54Z21pLmhlYWQs
ICZoaXZlLT5kZXZpY2VfbGlzdCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfbGlz
dF9oYW5kbGUgPSAmaGl2ZS0+ZGV2aWNlX2xpc3Q7DQo+ICsgICAgICAgICAgICAgfQ0KPiAgICAg
ICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICBsaXN0X2FkZF90YWlsKCZhZGV2LT5nbWMueGdt
aS5oZWFkLCAmZGV2aWNlX2xpc3QpOw0KPiAtICAgICAgICAgICAgIGRldmljZV9saXN0X2hhbmRs
ZSA9ICZkZXZpY2VfbGlzdDsNCj4gKyAgICAgICAgICAgICBnZXRfZGV2X2xvY2sgPSBhbWRncHVf
ZGV2aWNlX2xvY2tfYWRldihhZGV2LCBoaXZlKTsNCj4gKyAgICAgICAgICAgICB0bXBfYWRldiA9
IGFkZXY7DQo+ICsgICAgICAgICAgICAgaWYgKGdldF9kZXZfbG9jaykgew0KPiArICAgICAgICAg
ICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmYWRldi0+Z21jLnhnbWkuaGVhZCwgJmRldmljZV9s
aXN0KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGRldmljZV9saXN0X2hhbmRsZSA9ICZkZXZp
Y2VfbGlzdDsNCj4gKyAgICAgICAgICAgICB9DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICBpZiAo
IWdldF9kZXZfbG9jaykgew0KPiArICAgICAgICAgICAgIGRldl9pbmZvKHRtcF9hZGV2LT5kZXYs
ICJCYWlsaW5nIG9uIFREUiBmb3Igc19qb2I6JWxseCwgYXMgYW5vdGhlciBhbHJlYWR5IGluIHBy
b2dyZXNzIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBqb2IgPyBq
b2ItPmJhc2UuaWQgOiAtMSk7DQo+ICsgICAgICAgICAgICAgciA9IDA7DQo+ICsgICAgICAgICAg
ICAgLyogZXZlbiB3ZSBza2lwcGVkIHRoaXMgcmVzZXQsIHN0aWxsIG5lZWQgdG8gc2V0IHRoZSBq
b2IgdG8gZ3VpbHR5ICovDQo+ICsgICAgICAgICAgICAgZ290byBza2lwX3JlY292ZXJ5Ow0KPiAg
ICAgICAgfQ0KPg0KPiAgICAgICAgLyogYmxvY2sgYWxsIHNjaGVkdWxlcnMgYW5kIHJlc2V0IGdp
dmVuIGpvYidzIHJpbmcgKi8NCj4gICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYs
IGRldmljZV9saXN0X2hhbmRsZSwgZ21jLnhnbWkuaGVhZCkgew0KPiAtICAgICAgICAgICAgIGlm
ICghYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYodG1wX2FkZXYsIGhpdmUpKSB7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICBkZXZfaW5mbyh0bXBfYWRldi0+ZGV2LCAiQmFpbGluZyBvbiBURFIgZm9y
IHNfam9iOiVsbHgsIGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9ncmVzcyIsDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgam9iID8gam9iLT5iYXNlLmlkIDogLTEpOw0KPiAtICAg
ICAgICAgICAgICAgICAgICAgciA9IDA7DQo+IC0gICAgICAgICAgICAgICAgICAgICBnb3RvIHNr
aXBfcmVjb3Zlcnk7DQo+IC0gICAgICAgICAgICAgfQ0KPiAtDQo+ICAgICAgICAgICAgICAgIC8q
DQo+ICAgICAgICAgICAgICAgICAqIFRyeSB0byBwdXQgdGhlIGF1ZGlvIGNvZGVjIGludG8gc3Vz
cGVuZCBzdGF0ZQ0KPiAgICAgICAgICAgICAgICAgKiBiZWZvcmUgZ3B1IHJlc2V0IHN0YXJ0ZWQu
DQo=

--_000_CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30CY4PR12MB1573namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
OK, I understand. You mean one device in the hive may be locked up independ=
ently without locking up the whole hive.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
It could happen, I'll change my code.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Horace.<br>
</div>
<div>
<div id=3D"appendonsend"><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Grodz=
ovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2021=C4=EA1=D4=C220=C8=D5 0:58<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Chen, Horace &lt;Horace.Chen@amd.com&gt;; amd-gf=
x@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Tuikov, Luben &l=
t;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Xiao, Jack &lt;J=
ack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Liu, Mo=
nk
 &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevi=
n(Yang) &lt;Kevin1.Wang@amd.com&gt;; Xiaojie Yuan &lt;xiaojie.yuan@amd.com&=
gt;<br>
<b>=D6=F7=CC=E2:</b> Re: =BB=D8=B8=B4: [PATCH 1/2] drm/amdgpu: race issue w=
hen jobs on 2 ring timeout</font>
<div>&nbsp;</div>
</div>
<div>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<div class=3D"x_moz-cite-prefix">On 1/19/21 11:39 AM, Chen, Horace wrote:<b=
r>
</div>
<blockquote type=3D"cite">
<p style=3D"margin-top: 0px; margin-bottom: 0px;font-family:Arial; font-siz=
e:11pt; color:#0078D7; margin:5pt" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Andrey,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I think the list in the XGMI hive won't be break in the middle if we lock t=
he device before we change the list. Because if 2 devices in 1 hive went in=
to the function, it will follow the same sequence to lock the devices. So o=
ne of them will definately break
 at the first device. I add iterate devices here is just to lock all device=
 in the hive since we will change the device sequence in the hive soon afte=
r.</div>
</div>
</blockquote>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">I didn't mean break in a =
sense of breaking the list itself, I just meant the literal 'break' instruc=
tion<br>
to terminate the iteration once you failed to lock a particular device. <br=
>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<blockquote type=3D"cite">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The reason to break the interation in the middle is that the list is change=
d during the iteration without taking any lock. It is quite bad since I'm f=
ixing one of this issue. And for XGMI hive, there are 2 locks protecting th=
e list, one is the device lock I
 changed here, the other one is in front of my change, there is a hive-&gt;=
lock to protect the hive.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Even the bad thing really happened, I think moving back through the list is=
 also very dengerous since we don't know what the list finally be, Unless w=
e stack the devices we have iterated through a mirrored list. That can be a=
 big change.<br>
</div>
</div>
</blockquote>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Not sure we are on the sa=
me page, my concern is let's sat your XGMI hive consists of 2 devices, you =
manged to call successfully do<font size=3D"2"><span style=3D"font-size:11p=
t"><br>
amdgpu_device_lock_adev for dev1 but then failed for dev2, in this case you=
 will bail out&nbsp;</span></font> without releasing dev1, no ?</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Andrey<br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<blockquote type=3D"cite">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I'm ok to seperate the locking in <font size=3D"2"><span style=3D"font-size=
:11pt">amdgpu_device_lock_adev here, I'll do some test and update the code =
later.<br>
</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<font size=3D"2"><span style=3D"font-size:11pt">Thanks &amp; Regards,</span=
></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<font size=3D"2"><span style=3D"font-size:11pt">Horace.</span></font><br>
</div>
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Grodz=
ovsky, Andrey
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Andrey.Grodzovsky@amd.c=
om">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2021=C4=EA1=D4=C219=C8=D5 22:33<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Chen, Horace <a class=3D"x_moz-txt-link-rfc2396E=
" href=3D"mailto:Horace.Chen@amd.com">
&lt;Horace.Chen@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>=B3=AD=CB=CD:</b> Quan, Evan <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:Evan.Quan@amd.com">
&lt;Evan.Quan@amd.com&gt;</a>; Tuikov, Luben <a class=3D"x_moz-txt-link-rfc=
2396E" href=3D"mailto:Luben.Tuikov@amd.com">
&lt;Luben.Tuikov@amd.com&gt;</a>; Koenig, Christian <a class=3D"x_moz-txt-l=
ink-rfc2396E" href=3D"mailto:Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander <a class=3D"x_moz-=
txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Xiao, Jack <a class=3D"x_moz-txt-lin=
k-rfc2396E" href=3D"mailto:Jack.Xiao@amd.com">
&lt;Jack.Xiao@amd.com&gt;</a>; Zhang, Hawking <a class=3D"x_moz-txt-link-rf=
c2396E" href=3D"mailto:Hawking.Zhang@amd.com">
&lt;Hawking.Zhang@amd.com&gt;</a>; Liu, Monk <a class=3D"x_moz-txt-link-rfc=
2396E" href=3D"mailto:Monk.Liu@amd.com">
&lt;Monk.Liu@amd.com&gt;</a>; Xu, Feifei <a class=3D"x_moz-txt-link-rfc2396=
E" href=3D"mailto:Feifei.Xu@amd.com">
&lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang) <a class=3D"x_moz-txt-link=
-rfc2396E" href=3D"mailto:Kevin1.Wang@amd.com">
&lt;Kevin1.Wang@amd.com&gt;</a>; Xiaojie Yuan <a class=3D"x_moz-txt-link-rf=
c2396E" href=3D"mailto:xiaojie.yuan@amd.com">
&lt;xiaojie.yuan@amd.com&gt;</a><br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 =
ring timeout</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText"><br>
On 1/19/21 7:22 AM, Horace Chen wrote:<br>
&gt; Fix a racing issue when jobs on 2 rings timeout simultaneously.<br>
&gt;<br>
&gt; If 2 rings timed out at the same time, the amdgpu_device_gpu_recover<b=
r>
&gt; will be reentered. Then the adev-&gt;gmc.xgmi.head will be grabbed<br>
&gt; by 2 local linked list, which may cause wild pointer issue in<br>
&gt; iterating.<br>
&gt;<br>
&gt; lock the device earily to prevent the node be added to 2 different<br>
&gt; lists.<br>
&gt;<br>
&gt; Signed-off-by: Horace Chen <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:horace.chen@amd.com">
&lt;horace.chen@amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 ++++++++++=
+++++-------<br>
&gt;&nbsp;&nbsp; 1 file changed, 30 insertions(+), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 4d434803fb49..9574da3abc32 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4540,6 +4540,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool get_dev_lock =3D false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt; @@ -4582,28 +4583,45 @@ int amdgpu_device_gpu_recover(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Build list of device=
s to reset.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In case we are in XG=
MI hive mode, resort the device list<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to put adev in the 1=
st position.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lock the device before we try to ope=
rate the linked list<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if didn't get the device lock, don't=
 touch the linked list since<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * others may iterating it.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_l=
ist);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_ph=
ysical_nodes &gt; 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!hive)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-ENODEV;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!list_is_first(&amp;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_li=
st))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_rotate_to_front(&a=
mp;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_list);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; device_list_handle =3D &amp;hive-&gt;device_list;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_list, gmc.xgmi.head)=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =3D amdgpu=
_device_lock_adev(tmp_adev, hive);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
<br>
<br>
What about unlocking back all the devices you already locked if the break<b=
r>
happens in the middle of the iteration ?<br>
Note that at skip_recovery: we don't do it. BTW, i see this issue is alread=
y in <br>
the current code.<br>
<br>
Also, maybe now it's better to separate the actual locking in <br>
amdgpu_device_lock_adev<br>
from the other stuff going on there since I don't think you would wont to t=
oggle <br>
stuff<br>
like adev-&gt;mp1_state back and forth and also the function name is not <b=
r>
descriptive of<br>
the other stuff going on there anyway.<br>
<br>
Andrey<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_is_first(&amp=
;adev-&gt;gmc.xgmi.head, &amp;hive-&gt;device_list))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head, =
&amp;hive-&gt;device_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =3D =
&amp;hive-&gt;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; list_add_tail(&amp;adev-&gt;gmc.xgmi.head, &amp;device_list);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; device_list_handle =3D &amp;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; get_dev_lock =3D amdgpu_device_lock_adev(adev, hive);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp_adev =3D adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev=
-&gt;gmc.xgmi.head, &amp;device_list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =3D =
&amp;device_list;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(tmp_adev-&gt;dev, &quot;Bailing on TDR for s_job:%llx, as anot=
her already in progress&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jo=
b ? job-&gt;base.id : -1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* even we skipped this reset, still need to set the job to guilty */<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto skip_recovery;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and =
reset given job's ring */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, gmc.xgmi.head) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_device_lock_adev(tmp_adev, hive)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;d=
ev, &quot;Bailing on TDR for s_job:%llx, as another already in progress&quo=
t;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ? job-&gt;base.id : -1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Try to put the audio codec into suspend state<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * before gpu reset started.<br>
</div>
</span></font></div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30CY4PR12MB1573namp_--

--===============0292449839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0292449839==--
