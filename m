Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC7C55178
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214A12242A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yy9/x8lO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214A12242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9F16E99D;
	Wed,  4 Nov 2020 10:40:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70866E99D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 10:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoPl1SuG5b/haGewuGBaH/rbA2Ysg5GVQrdzFoBQT/UblEFQvx8M6H+pHf3i4v8CMX2erZyM+1UdDiGsR4ItT30Rwl5ZiZiOApzlA6NeCcxoe4vkYYJh003bu9muRynhHABVI6zzvuxsGPsxVmiD2wEJIoSQa5n4Hn7b5BHtLXIyW8rqG/MElkNwQmNbkseskRGEs/fN2BEzj20LCAN8jp2fc4cTBOwbRJtFJ1yE/9EqZ721yPHdGFZ0yW2uBe1TRJ13SnWqXvgziGnDcuS9Ugrlx0doysQwP9rpRB506CCv+pvKK8EJNu3rAdb9meGXnfwJzY+eOUingZe6ly8gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts/WMx2ebY8bsKykTla/OESRvCXwIs/WPqJbLs4beJQ=;
 b=W980Ormo92Lqf3EOVZ1cxdvm/CE3z4vRKlWUoPqpVc9SQ7+Edt33rsKP/qH0C0HPzcSfQGEwI9zqEHvHWGTPdb591cMqlK9qSzie/Fa8frP3ruwagcCcbC9x/lMbg1PEkCsyXktN5d4ll5oIwTOO1WItyjmMLLSdKSnEIbi2wvqQGfuRGjLdxnkSOFFBiwT04PJPHLYAGGqtUDe9p9NafeieFIDX4TjVV+L8v9RrLUBWIOl44Wisbx22TH2FVKl47j+OJoMWJwstEXxEhsKZNm5SVQBHQBzpS5PTRPRD9ytMTLsCAmjRuJrKADZgJ1lwZl+w1zywRjR6fqw8N6Dmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts/WMx2ebY8bsKykTla/OESRvCXwIs/WPqJbLs4beJQ=;
 b=yy9/x8lOk4+0rxA1AjJdav28uJwAd3yynaDle+SLKbF42TGSZFHBO/aDaKT0f9vK+Sh6UMJw5wYFjMOR7dHpQNZf9P/uB6gcmeQ+Z7+XQ0aFvyFnBRZy0gxWifYijahjGcYQmNZKWvz52KkS6C5ls5yI1vp8hT5iBQQxcSbgO3A=
Received: from MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 10:40:40 +0000
Received: from MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135]) by MN2PR12MB3133.namprd12.prod.outlook.com
 ([fe80::9102:eadd:7252:9135%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 10:40:40 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: clip the ref divider max value at 100
Thread-Topic: [PATCH] drm/amdgpu: clip the ref divider max value at 100
Thread-Index: AQHWsgS8irnGhXyBSkCqRwvFlFJIYam3v/AAgAAI6DA=
Date: Wed, 4 Nov 2020 10:40:40 +0000
Message-ID: <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
In-Reply-To: <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-04T10:40:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=03920e19-33e6-4a0f-b031-0000d0dc57eb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-04T10:40:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 909a230d-b027-4d05-a1a2-00001048bde8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-04T10:40:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f9213131-72fa-4b50-8b02-0000673085cc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [106.51.107.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1edfc1f0-634d-47ae-9dd2-08d880ae130f
x-ms-traffictypediagnostic: MN2PR12MB3294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB329459C657FEC2506FF77BBAF2EF0@MN2PR12MB3294.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyi4EZA/YNWvP8LTaDU+z225n9riJiGgWOqG5UruYeTjYLjyn4cdGoGhpH+1AKYmhhLK8/AvglPMljVnEguqG7Rpw2g7ya9In0PLSDQU1dVK44BQ10PWcLEHQ9lilA1v9sm4M1Dm0L/iv2UfPOTwYMtx60v0EgO43CCErH1qLHwoKr+NLfK2L1si7FnXM1gHLrmkSchkpS5p0lGYzOiqTCiFXQAZWd70GA7QuZgSLlGNSlLAK4rjFUMX5uzK8NXYuGaVJXlICKSsiOAwN3R3v1gUhAmvCtjz6KwIXhT20fc1VcGRul9nTsWU9jujqhLWPiF0cLPCDj+fxxaD/F3DZVrd8DSVmB1i5KNDwNuL/b9vH7tjtMLZCdmKUtAhrF8ImGX7m94fyeYC07Yts5+WMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(83380400001)(9686003)(2906002)(66574015)(33656002)(54906003)(66446008)(76116006)(316002)(71200400001)(64756008)(66556008)(66946007)(66476007)(478600001)(86362001)(5660300002)(4326008)(8936002)(966005)(52536014)(7696005)(53546011)(55236004)(110136005)(55016002)(8676002)(26005)(6506007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Rsjvb7i3ubEI9K1ROSa5D9OXxeBIcQ3KkJblcd/m9M3DpC7VEYm/RTE53wBJLjz1kTrO+ixKnmS3QFRJmaEjTXzRyhsMO1yo9aaFZzeHX++xfKPiR9XtHHhvyD5hLShEI4ZyRqWW0D4Z+EVsMZ23PbQnMlzq/Ab0yMIbQr5fbk4C6LqHIfeS7/ofQ7a4lmHB+C0Rqv4ysMAVIADmndawXYQ8jYik76zU/Pgyvo8rnRTvDTprfExswLmhzeQrhpu4/zVVm3VCQ6LOg3O287j8DKM8EuM5PMcuMrHvCvPpXIRnX1ygecTw1CqtStGbNpxaR6QvJf+/8w+z4l1/ffVl8LAiIYWz25twu0nUdI0eeLqMFdDol0VERqv/W8E1t8aRwmmgCtNcrk5wC4sUltRXivk+s/3VEYCOo0V3pjdN23OKEF//hk9pnUQAyS/T6PReCuoLYiKLZ2N7/m9lzCRifGjNP5fc+w/nG8yCcPcig5CWvtKvn1/8BgbXFH/X1MX6k6aUyVxDESpQ4h02PXfmwfKQU6XyA1BGHhdhxmYi7fi7VNGYeTJOOYkztiX9ZmwpUc/mOm/+QIiOeoQ8RJedUQHCCHBhMlLlY1DivsrdkZplFT38rK65FaVbkKEpIgKwOdmd5FKFp6ze28y/xZut/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edfc1f0-634d-47ae-9dd2-08d880ae130f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 10:40:40.4620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BB5a1WPeLW3e7fMMhDvK2FxzOE7AZC3+dCUP2G8C/JviZ8hQWxG+LEDayvElU1IK0WXe4NTmJ0QzMCu3kugilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Qin,
 Eddy" <Eddy.Qin@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpIZWxsbyBDaHJpc3RpYW4sIA0KWWVzLCB0aGF0IDEwMCBpcyBo
YXJkY29kZWQgaW4gUmFkZW9uLCBhbmQgZ2l0IGJsYW1lIHNheXMgaXQgd2FzIG9uZSBvZiB5b3Vy
IHBhdGNoZXMgd2hpY2ggbWFkZSBpdCAxMDAgZnJvbSAxMjgg8J+Yii4gDQpXb3VsZCB5b3UgbWlu
ZCBoYXZpbmcgYSBsb29rIGF0IGNvbW1pdCBpZDogNGIyMWNlMWI0YjVkMjYyZTdkNDY1NmI4ZWNl
Y2M4OTFmYzNjYjgwNiA/IA0KDQpSZWdhcmRzDQpTaGFzaGFuaw0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+IA0KU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA0LCAyMDIwIDM6MzUgUE0NClRvOiBTaGFy
bWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgUWluLCBFZGR5IDxFZGR5LlFpbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogY2xpcCB0aGUgcmVmIGRpdmlkZXIgbWF4IHZhbHVlIGF0IDEwMA0KDQpB
bSAwMy4xMS4yMCB1bSAxODoxMyBzY2hyaWViIFNoYXNoYW5rIFNoYXJtYToNCj4gVGhpcyBwYXRj
aCBsaW1pdHMgdGhlIHJlZl9kaXZfbWF4IHZhbHVlIHRvIDEwMCwgZHVyaW5nIHRoZSBjYWxjdWxh
dGlvbiANCj4gb2YgUExMIGZlZWRiYWNrIHJlZmVyZW5jZSBkaXZpZGVyLiBXaXRoIGN1cnJlbnQg
dmFsdWUgKDEyOCksIHRoZSANCj4gcHJvZHVjZWQgZmJfcmVmX2RpdiB2YWx1ZSBnZW5lcmF0ZXMg
dW5zdGFibGUgb3V0cHV0IGF0IHBhcnRpY3VsYXIgDQo+IGZyZXF1ZW5jaWVzLiBSYWRlb24gZHJp
dmVyIGxpbWl0cyB0aGlzIHZhbHVlIGF0IDEwMC4NCg0KTWhtLCBpcyB0aGF0IDEwMCBoYXJkIGNv
ZGVkIGluIHJhZGVvbj8gSSBoYXZlIG5vIGlkZWEgd2hlcmUgdGhhdCBpcyBjb21pbmcgZnJvbS4N
Cg0KQmVzdCB3b3VsZCBwcm9iYWJseSB0byBncmFiIGEgaGFyZHdhcmUgZW5naW5lZXIgYW5kIHRy
eSB0byBmaWd1cmUgb3V0IHdoYXQgdGhlIHJlYWwgbWF4aW11bXMgZm9yIHRoZSBQTEwgaXMgdG8g
c3RpbGwgcHJvZHVjZSBhIHN0YWJsZSBzaWduYWwuDQoNCkNocmlzdGlhbi4NCg0KPg0KPiBPbiBP
bGFuZCwgd2hlbiB3ZSB0cnkgdG8gc2V0dXAgbW9kZSAyMDQ4eDEyODBANjAgKGEgYml0IHdlaXJk
LCBJIA0KPiBrbm93KSwgaXQgZGVtYW5kcyBhIGNsb2NrIG9mIDIyMTI3MCBLaHouIEl0J3MgYmVl
biBvYnNlcnZlZCB0aGF0IHRoZSANCj4gUExMIGNhbGN1bGF0aW9ucyB1c2luZyB2YWx1ZXMgMTI4
IGFuZCAxMDAgYXJlIHZhc3RseSBkaWZmZXJlbnQsIGFuZCANCj4gbG9vayBsaWtlIHRoaXM6DQo+
DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxQYXJh
bWV0ZXIgICAgfEFNREdQVSAgICAgICAgfFJhZGVvbiAgICAgICB8DQo+IHwgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ICstLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxDbG9jayBmZWVkYmFjayAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICB8DQo+IHxkaXZpZGVyIG1heCAgfCAgMTI4ICAgICAgICAgfCAgIDEwMCAgICAg
ICB8DQo+IHxjYXAgdmFsdWUgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+IHwg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+IHwgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxyZWZfZGl2X21heCAgfCAgICAgICAgICAgICAg
fCAgICAgICAgICAgICB8DQo+IHwgICAgICAgICAgICAgfCAgNDIgICAgICAgICAgfCAgMjAgICAg
ICAgICB8DQo+IHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+
IHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8DQo+ICstLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxyZWZfZGl2ICAgICAgfCAg
NDIgICAgICAgICAgfCAgMjAgICAgICAgICB8DQo+IHwgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICB8DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rDQo+IHxmYl9kaXYgICAgICAgfCAgMTAzMjYgICAgICAgfCAgODE5NSAgICAgICB8
DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxmYl9k
aXYgICAgICAgfCAgMTAyNCAgICAgICAgfCAgMTYzICAgICAgICB8DQo+ICstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+IHxmYl9kZXZfcCAgICAgfCAgNCAgICAg
ICAgICAgfCAgOSAgICAgICAgICB8DQo+IHxmcmFjIGZiX2RlXl9wfCAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICB8DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0rDQo+DQo+IFdpdGggcmVmX2Rpdl9tYXggdmFsdWUgY2xpcHBlZCBhdCAxMDAsIEFNREdQVSBk
cml2ZXIgY2FuIGFsc28gZHJpdmUgDQo+IHZpZGVtb2RlIDIwNDh4MTI4MEA2MCAoMjIxTWh6KSBh
bmQgcHJvZHVjZSBwcm9wZXIgb3V0cHV0IHdpdGhvdXQgYW55IA0KPiBibGFua2luZyBhbmQgZGlz
dG9ydGlvbiBvbiB0aGUgc2NyZWVuLg0KPg0KPiBQUzogVGhpcyB2YWx1ZSB3YXMgY2hhbmdlZCBm
cm9tIDEyOCB0byAxMDAgaW4gUmFkZW9uIGRyaXZlciBhbHNvLCBoZXJlOg0KPiBodHRwczovL2dp
dGh1Yi5jb20vZnJlZWRlc2t0b3AvZHJtLXRpcC9jb21taXQvNGIyMWNlMWI0YjVkMjYyZTdkNDY1
NmI4DQo+IGVjZWNjODkxZmMzY2I4MDYNCj4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4NCj4gQ2M6IEVkZHkgUWluIDxFZGR5LlFpbkBhbWQuY29tPg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPg0KPiAt
LS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMgDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jDQo+IGluZGV4IDFmMjMwNWI3
YmQxMy4uMjNhMmUxZWJmNzhhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcGxsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BsbC5jDQo+IEBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9wbGxfZ2V0
X2ZiX3JlZl9kaXYodW5zaWduZWQgbm9tLCB1bnNpZ25lZCBkZW4sIHVuc2lnbmVkIHBvc3RfDQo+
ICAgCQkJCSAgICAgIHVuc2lnbmVkICpmYl9kaXYsIHVuc2lnbmVkICpyZWZfZGl2KQ0KPiAgIHsN
Cj4gICAJLyogbGltaXQgcmVmZXJlbmNlICogcG9zdCBkaXZpZGVyIHRvIGEgbWF4aW11bSAqLw0K
PiAtCXJlZl9kaXZfbWF4ID0gbWluKDEyOCAvIHBvc3RfZGl2LCByZWZfZGl2X21heCk7DQo+ICsJ
cmVmX2Rpdl9tYXggPSBtaW4oMTAwIC8gcG9zdF9kaXYsIHJlZl9kaXZfbWF4KTsNCj4gICANCj4g
ICAJLyogZ2V0IG1hdGNoaW5nIHJlZmVyZW5jZSBhbmQgZmVlZGJhY2sgZGl2aWRlciAqLw0KPiAg
IAkqcmVmX2RpdiA9IG1pbihtYXgoRElWX1JPVU5EX0NMT1NFU1QoZGVuLCBwb3N0X2RpdiksIDF1
KSwgDQo+IHJlZl9kaXZfbWF4KTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
