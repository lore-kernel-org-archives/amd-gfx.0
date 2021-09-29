Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EA161506
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 17:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39EA161506
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED17F6E1E8;
	Wed, 29 Sep 2021 17:55:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE53B6E1E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 17:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1SeKDCGOkm3lSLhIacZoUmccHYJ4wvSJ3tJyuO61DzgUoWnrQhQVZyfcd8WuWI2j2RAIlD3WtGbnVm1DEG/xTD2Uh7ynFOfDhUAgDA2uN2aU0V9D1FaqV9wdmQQjkl62wc9CtHEJSvKas292H288ucMC1dLLLRP3bVe15b+GWYEPXxflf3pVS9+o81MnaGDqFhPFD96+KcZTPHgaFfD1hmbWkYpYbr7NY+u2kZtC8eeZSRIyy+Ac4OP9b2bIgKlSzdvla8NCjH5LHD8T3wnJsqSgX9nIZxyRS2XUOsmEN82TeucTmu4Q+Q6W8aaHx/CjlNa6KjOwvHnk4MJcBVqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zE+uQ/gvSB7u+ib2Tgx+JPPKmv1s9FASiZRpePDcmIA=;
 b=l2BJmdswhhXkY8e9Ql5qNnf6gGrpzxoKrBw9ZUt6xr3c8j8It0BxAnTk/D6WZ8mQn/VGADa3fXJXzI+a1ePgMYdqPwnKFqPCo0EkkZXvYZi2JZ8qy6Qi8ckX0ZqP3GoyDMkq9IkhwGdx9BGZbWcMzmupDjhBXnTfc6fPLbgZnfVGUEC67ljG6UZzFd8RUeDMNV1oQwO/nlUhKPo4p6xyu2hu7d0aCnVAWPHNYgFayQ/8iJiVcdbpCErDzz9F1bVfn4YCAVHc75Z60ZQWZxNGb9KGH7EV4byY28j8EcPrn7mGTo5JGOzQUGB3FG5NPDDoPSrqML13mu9YupAK/HbTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE+uQ/gvSB7u+ib2Tgx+JPPKmv1s9FASiZRpePDcmIA=;
 b=fQzTWC9qp8Rln5ecIwUYYymIjm/zu1CuOzvGWkJhyuWrlyIazcKFV0IdtWwZyOvQtM6w++A9O2ghubkee9g3INworhJlWFQYEX2QksNHvdkhA8z+wM6hNvtTs+sLSgsczp/XXa5XAszJon+7Zbi6Pef9cTRUhPRUX/tGIDD38t0=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 17:55:37 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::f8f5:5c09:6c41:e962]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::f8f5:5c09:6c41:e962%9]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 17:55:37 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/display: remove unused variable
Thread-Topic: [PATCH] drm/amdgpu/display: remove unused variable
Thread-Index: AQHXs9MEygKIkjea80CccXz5y8bjEqu7TDmAgAAB+yA=
Date: Wed, 29 Sep 2021 17:55:37 +0000
Message-ID: <DM4PR12MB50382D376C34C0D5BA31E61CF1A99@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20210927190746.675991-1-alexander.deucher@amd.com>
 <CADnq5_MiXM3LGLi=427Wi7DUm4UwtNp7hBBA9Z6ri20KHXCw3w@mail.gmail.com>
In-Reply-To: <CADnq5_MiXM3LGLi=427Wi7DUm4UwtNp7hBBA9Z6ri20KHXCw3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T17:55:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bf3db936-50a2-4688-8bd1-428b0fe75164;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0afaf35-5d55-4c76-284e-08d9837257c6
x-ms-traffictypediagnostic: DM4PR12MB5278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB527829596064E6047C6DF194F1A99@DM4PR12MB5278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WJwRSbvAnBAxNwaGVxLsC2f9IgbZU0bRQ9OchRtWte1kgclng9HTCx92tHUbNZB3Z4PNASeyxv6TBQq+pvGXO17cM2ZBCElAHGROiQppRrb7h2Qb/gXHTAUpXumqjBzfGWjywVZXpWX4/pi73FpD5Os0j7Qhpk33RCMVvzMEIVagzvgwFAsl1tcrunXrgWE04R4hJznn8ce229X0JBK0l2vZtYgubv7uHJlE1FOhDKgy9NOQgvYvVBwovOtz8ldhMqVZGA3ieHsNLiYXT2ccwNplHiRvqhx8W2Yk4DLBDJ2RaBkEy/OdPQfmH7V8wWhkF4yOOazMse7B25p/Sz+/fr/8MDNCMO/ryxe8bMHkElyikX2l9sxJkkfSjE9/u+07opvU1lbrW1tSdsqJDOcfSAxzhQyrJNe9P4fZbiQ/oC6JkJZPbEXK+rv9rahPgE02kSvBK5K30Kig5/uJoO3DBwp92oIeiUxOhfqXF+OGntsmuEe4dc6TAEZq0yYAVtwBg2JUvu5ZSvJJvSyiFkXYA8RbGL0fXGqjl/cssdGVx7mXrho8nBMmESeRVTF/hXbjb6ZEf9JNVT+fPs65ExLcW/j8EDIfLPcaEBDqw1Cmi2ZFQAji65n16uSykPwP4AzXx6KcmmzsvecJfPBKbGY8rW5tqmjWBax6vDXrd/upse9oeC4jBD0JLO2o52h8eNT5OblLzh1OwfJ3k/sUVNRiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(64756008)(33656002)(4326008)(76116006)(66946007)(508600001)(83380400001)(86362001)(55016002)(66446008)(71200400001)(66476007)(52536014)(9686003)(2906002)(186003)(8676002)(316002)(38100700002)(26005)(8936002)(110136005)(6506007)(53546011)(5660300002)(38070700005)(7696005)(6636002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkIrSW1rZ1JUVjQ4dzc2a0x6blBTMUFxUWNyMXM2YmlkTEtTbFBGelc1b0tE?=
 =?utf-8?B?SEIxcWt4c1RIVzdPZVplMVNyMUpjQTFWT0dWbXZrcFNnSStSTkphTVprWTVK?=
 =?utf-8?B?YU83WFBiNGtSNjhoNlJ4Uk44Z2pHY3VvMStjdzIyY1dLcldqQnk5czhRNUo2?=
 =?utf-8?B?Y1hWaUY5aFV0Z0RRR2gxSHR3aHRKTUR3OTRhRkRmMzVrRUhXaXRJN0pvUXpN?=
 =?utf-8?B?Z25xVmlnQkR4OWdURlg1QlYwNHY3U0d2anlFb0JMRUIyblE1UEhmWXVzZ2c4?=
 =?utf-8?B?NU5BMTFhL0NnQ2d0Y1IvMldIT2hYajd4ZmJ1TGRkVmZ5ZXNZbTlLRlR0MFNU?=
 =?utf-8?B?bHJOVGIrcWdFV0JQaDBGd3NESmQ3dGxPd0JmYUZLTDlwVUFkQ09TR29NR2xX?=
 =?utf-8?B?Zk40QnF4NXpTUkwvUWwrU2hkNFhsVnAzS3JRbmQzZkdQRHBwMEFEU2tSYmdz?=
 =?utf-8?B?clZxR29YamorTDJ3VVlCVHNjSE1pRXVSbFFwa1hQUGJYbzQ2b1MxektuSUhw?=
 =?utf-8?B?VURXMkZobGVtYU5ZTUN0Vy9xUG9Kb1R6QlBwNzkxOEw1T09UMFdJUjRYdHAw?=
 =?utf-8?B?bEZjblpnOWY5TlhWenNTQVl5cVdxdXhlNHRqWXpkYWlkZlRubGZlU1JqUGsz?=
 =?utf-8?B?aFN5dUkyaE5pWWprbk8xcmJVcUJ4bHNLdDRld0tGUkRUeXFFcTFuY0kzUUtT?=
 =?utf-8?B?bEwwVEYxZ0FRSzFaMUpJRG05M1RmVmwyb3VHTUtiOWphc295M0cxcDJTL3dv?=
 =?utf-8?B?MGd5T2I4dXlMNEZla3RmN1Y2M3NoNm9XYWUvQ3M5ajRiVEY4ZGMzbm5CMHF6?=
 =?utf-8?B?a2tPVGpHUUNiSGdDc1JCRWpaUHZBb0hwdUFSaXB0Q0tsaFFMaERnY0lmT0FW?=
 =?utf-8?B?cGdOWm1qZEMxZkxDYlVNK0lEMWQyRjRnUkxRT1QwSG1tK1lTUk43TW9VSW1S?=
 =?utf-8?B?OE5ybHFZZWpjR1lrVHZtNjFxSnBxcjBpTHpjdUZmRE5sSTVsaDBYblpHV3pt?=
 =?utf-8?B?YUlueGpYMXVERGZOdmI3L3RleDNmRmF1bS9VaEU5Vm8vbmc0MXJzZlAvdTJT?=
 =?utf-8?B?dFUvRm8zUVhQSyt5SW1zY3h4RW85VzdNcVU4WklsbVJlanZuaVBCUVkrR0RV?=
 =?utf-8?B?dUxtakZNeStLZ3padHdpQ2hTZm5yeFhPRGxxbTM0YTdtbzRzOTdDNi9wYnNN?=
 =?utf-8?B?NEp2TmV0RWRMQlJmOTZkdnlhaHFsWmY2UUlQNkgyaktjb0V2d0trdmVKQkNE?=
 =?utf-8?B?NDFDYURIS3JTY0xEZU5JWnJaUWFGU00rd3VTaXpZcmM3WUJvZ0cwR3BOY3cz?=
 =?utf-8?B?eGJvVlAwRGhlMk9LTVJwdDlSSmtuR2Z5VHU0YWVBK2o3SWNTWm1BZVQrZUha?=
 =?utf-8?B?cE5KaVlHVEpTV09kQVZVMm1hOS9hcUNWd2c1blRmVzhwNGZ1NlRVTGJyc1VM?=
 =?utf-8?B?enJIbC9FWFd4cCsxWm5xSEhTOHd2UEFnTXZwN05ZV2E3UzhxOWhpMjF0aldN?=
 =?utf-8?B?RWIxeTh5S3p0a3pNV3M0aTMzb0tIK1pqSk5DczljczRXNW4ybnZKTGxNclZU?=
 =?utf-8?B?ZlBhcDUxWnVIcENScjdQUXlOb3hlUUxHMEpWMEdLNzBlS0dFdmFNRjBHQjg1?=
 =?utf-8?B?VzdTNGZmVjF2NC9yZnhhbzJIVWd0bjlYelcva3RJN3RDS0hOL1Qwdk16ZFBS?=
 =?utf-8?B?Y3h2Z3h3eTV0WXNnbnVwQllvUk5EcnhadlM2bDFrOFJLZ2tqUU9XY0tTdlJJ?=
 =?utf-8?Q?L2UB/aAJy0hgGHhwYGRsmN0r/lSTFWf8+XxUvxu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0afaf35-5d55-4c76-284e-08d9837257c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 17:55:37.0635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moLqM02HtGnOUwq/9HY2cFan6LJPYZe3XL6T3R7wKC88Aztgr3TtOG2o/qox9nJkDUogJ5dLK4NJS8fsCFLO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQWxleCwNClRoaXMgbG9va3MgZ29vZCB0byBt
ZSwgYW5kIHRoYW5rcyBmb3IgdGhlIGNsZWFuIHVwLg0KUmV2aWV3ZWQtYnk6IExlbyAoSGFuZ2hv
bmcpIE1hIDxoYW5naG9uZy5tYUBhbWQuY29tPg0KDQotTGVvDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcg0KU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjksIDIwMjEgMTo0NyBQTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9kaXNwbGF5OiByZW1vdmUg
dW51c2VkIHZhcmlhYmxlDQoNClBpbmc/DQoNCk9uIE1vbiwgU2VwIDI3LCAyMDIxIGF0IDM6MDgg
UE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3cm90ZToNCj4NCj4g
Tm8gbG9uZ2VyIHVzZWQsIGRyb3AgaXQuDQo+DQo+IEZpeGVzOiAxZTA3MDA1MTYxZmMgKCJkcm0v
YW1kL2Rpc3BsYXk6IGFkZCBmdW5jdGlvbiB0byBjb252ZXJ0IGh3IHRvIA0KPiBkcGNkIGxhbmUg
c2V0dGluZ3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfbGlua19kcC5jIHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19saW5rX2RwLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
bGlua19kcC5jDQo+IGluZGV4IDAyOWNjNzhiYzllOS4uNWViNDBkY2ZmMzE1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+
IEBAIC01MjAsNyArNTIwLDYgQEAgc3RhdGljIHZvaWQgZHBjZF9zZXRfbHRfcGF0dGVybl9hbmRf
bGFuZV9zZXR0aW5ncygNCj4NCj4gICAgICAgICB1aW50OF90IGRwY2RfbHRfYnVmZmVyWzVdID0g
ezB9Ow0KPiAgICAgICAgIHVuaW9uIGRwY2RfdHJhaW5pbmdfcGF0dGVybiBkcGNkX3BhdHRlcm4g
PSB7IHswfSB9Ow0KPiAtICAgICAgIHVpbnQzMl90IGxhbmU7DQo+ICAgICAgICAgdWludDMyX3Qg
c2l6ZV9pbl9ieXRlczsNCj4gICAgICAgICBib29sIGVkcF93b3JrYXJvdW5kID0gZmFsc2U7IC8q
IFRPRE8gbGlua19wcm9wLklOVEVSTkFMICovDQo+ICAgICAgICAgZHBjZF9iYXNlX2x0X29mZnNl
dCA9IERQX1RSQUlOSU5HX1BBVFRFUk5fU0VUOyBAQCAtMTAyMCw3IA0KPiArMTAxOSw2IEBAIGVu
dW0gZGNfc3RhdHVzIGRwY2Rfc2V0X2xhbmVfc2V0dGluZ3MoDQo+ICAgICAgICAgdWludDMyX3Qg
b2Zmc2V0KQ0KPiAgew0KPiAgICAgICAgIHVuaW9uIGRwY2RfdHJhaW5pbmdfbGFuZSBkcGNkX2xh
bmVbTEFORV9DT1VOVF9EUF9NQVhdID0ge3t7MH19fTsNCj4gLSAgICAgICB1aW50MzJfdCBsYW5l
Ow0KPiAgICAgICAgIHVuc2lnbmVkIGludCBsYW5lMF9zZXRfYWRkcmVzczsNCj4gICAgICAgICBl
bnVtIGRjX3N0YXR1cyBzdGF0dXM7DQo+DQo+IC0tDQo+IDIuMzEuMQ0KPg0K
