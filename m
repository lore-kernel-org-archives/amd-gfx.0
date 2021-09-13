Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 04:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3AA60F6F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 04:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E3AA60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2336E07D;
	Mon, 13 Sep 2021 04:42:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDDB6E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 04:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtYXac2E6Fe3c2X+DqlDW+Owv93FEY8dJPYL74KZbVgUGBaywhDifH5iV1LZRopjhN6pQun2pMW5UAa3qVvN0F3iiqUloIe7n19ZxvifPIxAgBeKgSDwA3/tIaqNC7iGNE0okHtquwVYIB8H36OYA0CHox27ezFqdovi4BZWw5WN2PBdUWZz/rbohIyTpuFwgaYUSjLnAvhidjhq9oe4eg3ko4rNalXyBSJvkdDgvM9/7DUAInpxUyynrazoPUyEweUrroSCdqRY50/BJgnSq2eEXbCdQA02kbXuZDwW5ohcK/tdBbIKkkkwEFORoq+pd7NkvT4QnSLN/Zxte9nRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNijY6u57074xoiQCxRKkMM1yYfiqxFEYf6RXS7jje0=;
 b=fGbHzvOLVx99leR4hJjbGk1zTUnfqWdF52K6/1KwT6atrKbX5Bebx9FL+UBpXESvqH3sIzA4xlUIkKi4Gsol3rsjmtV7mo3lIn7LSofUlDc+z6zGSFyaKJ6PDsJG3U5PQiqwqWyxonuTEVCB0mKl8UY+DyeCeGzBA85EuBKZLG+EGEBDeVXD4ixA/8VTBmQ0FL8KZmxRWezjbVNq0Z2/rsCAY1dPCP3k5nu6zry+Q/CWg5asnqCgWjJVNSotYOtczjFqxcPygsnP/kuBcxmOQXRE2xGWyra36R09T5hZ1E1RlY911zAVciwl9WGa0tzXcvVdEclPOf66WxNUFziU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNijY6u57074xoiQCxRKkMM1yYfiqxFEYf6RXS7jje0=;
 b=1+l/rKbxL+xQv2hAShFiD0nD2OmbNpfJrfDSnj7MItWE2PJU+m4iiAgD+I0+iwRQ7Hzwn2xLPgb7go+n0rg0dG4+g5ji7KdFzMOS9WoyZVTeLfgitptAwoIoe7RCIrN6T7wFJVLaT3Ma4WeWCEXwcgnR8qXUm6HjqjNHG7pTFMg=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Mon, 13 Sep 2021 04:42:47 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:42:47 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXggYSByYWNlIG9mIElC?=
 =?gb2312?Q?_test?=
Thread-Topic: [PATCH v2] drm/amdgpu: Fix a race of IB test
Thread-Index: AQHXqDC1tfre4WneykiL5yOc18hRmauhV3eAgAAK63M=
Date: Mon, 13 Sep 2021 04:42:47 +0000
Message-ID: <DM4PR12MB5165E20BBBC6E7BF30F3DE9E87D99@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20210912234817.13051-1-xinhui.pan@amd.com>
 <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
In-Reply-To: <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-13T04:42:44.425Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 9ae99e28-cdfc-1e11-a1e7-127641e7de23
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4fda34d-d28c-4a44-c0c7-08d97670ef95
x-ms-traffictypediagnostic: DM4PR12MB5357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB53579DB3EC0C7D99C752DBA587D99@DM4PR12MB5357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YsnDUrwQBS9rU/0ddDwMtV/rTOwq1axFPhPDdKoYCuPCZJXxDVlX5NGA6mPwqfeu5l04vBWB6pfbg+mhBWzS1acyAPU5zQ4iSQXxFkelOZYYvpCnZqwwfYmcJAtGKJUgwbptnYaGgAXXS7ccbtQ9stDinnM6gOgegwjBhhDHH1j6mi9uhQUK+wT4bGQR04EZ3giY6QiCRfZca+jqaPMH0O4p3cGR+KC2Zz85PvBYQES+Hcw0o4cj+3uY3wKQSZoNUmH6jx+/TVUAIUArmcpXoqdJ4KGyr/qX0WVyzswJNPSAaj8TOfVw1MGjaS0DvAo0JZj1BP3haTY1a/8isBnf5cnupUxD97GrBruWIYzgM8aqzdjMhcvrYwX6md0EmfcOv436sYbdIRev2a07RuDSRnvNjtOx4dNHnzKACRCZrfUMnOftuR33JbIjz32KNAcv1sqi7BoEfhDS7xNBIFe+AB0oFMceZLr1VzSUi6RddqExjUGw7MKa88Wxx89vTlrgM3fduoyslyfjShadZTRXVDHUHf4qBX7fEOqK9j8Q5wickWYxCIBxneOz7gthUuvmOaz7hFzuw2vJhhRbYvo8sXQ3clf5XIzU/DeLYr0Q8rcvu8Q9URH302KtSXHiro3D7U2FEnrfUx5BP/Ar3pz/fANeI+V5LtJ7oell1/c3hxO8n2POdQV/ErOPSKg7n6qudcmMWKoJlW6AjxbeEFn6QA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(83380400001)(33656002)(91956017)(122000001)(9686003)(8936002)(7696005)(6506007)(4326008)(224303003)(66556008)(5660300002)(38100700002)(38070700005)(64756008)(71200400001)(53546011)(66446008)(52536014)(86362001)(316002)(110136005)(26005)(76116006)(55016002)(66476007)(66946007)(54906003)(186003)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R0RFQ1lSQVU2SEJFSzkvbmgvemFPYkJSd2hEWU9YL0R0eDZDZEN2ellsQTVS?=
 =?gb2312?B?cmRRVXBmSWh2VFRnanhDc1lnR01GV0xZay82QUVDTlE4REJ0WUxXTytVOWFk?=
 =?gb2312?B?bHZBUFN4cEZ3T1hPZGlONzlCUlEyZGE1QUFpZHBiK2hneTljK3VzL21oNWto?=
 =?gb2312?B?b21BTWFUVkc2MWI1czJtM1pYRUtOUlpvM2ovTVJrU1lIRnBYTEE0MEFjNUtV?=
 =?gb2312?B?c3JOYUdZR1RCLzcrTjk5b3N2dStkWlAwYnd0MTVyVmdvWjNjUk5RUG4vNFRL?=
 =?gb2312?B?K0JKdW5uaWI0alNoWFRGdTZaQVpKSTNYQjE4UzNMa3VSeHB0aVQ0a0tSUXov?=
 =?gb2312?B?L0xFY08vdGZrOFBDN21ueVNKWXVxTmh2RzBXcTlrTkpUVWFZcXB1SFppY1Ez?=
 =?gb2312?B?RTV2VCtmV1hOVm5HTUk1WXZ3ejhsUlkrZHUwRk5NYit0OGVOR1FZdFplUnl4?=
 =?gb2312?B?T0hEaFZwcm81QUR6MUFxRHFVRTdTZDNvcWFrc2JiODRMbUU4ajgybHAwTU1j?=
 =?gb2312?B?ajR2dVkrNzQ1Y3QycTVOQzhtcXNrNlBMVWFPMHNRaG1TbnZOSnYyZjlzTGN5?=
 =?gb2312?B?S1NON04yRU9LYWZIQjJjSVZtQWlseS9zNlI4NmJJZkdtdkNpT0FabjBmZUtt?=
 =?gb2312?B?OXA1cFA1TlppN0V4VXVmTlBJcHBJSnV4RXFaMnBaVkVJdkhraExjS2krcm03?=
 =?gb2312?B?clQ5OHJmRmt4bEhEOVlWbFRvMzg0eVJneFMrenVqVk80d2ZrM0tXVzMwTGV6?=
 =?gb2312?B?eG9nTThQSVdxYjN5Nyt5TkhBdUIreWRmTmMzZkIyOXFzV3QrRGV4TmcybzJn?=
 =?gb2312?B?N1YrMm1HN040ajdLVThTd2Q4R0Ywa2p6aUhvWUF2aFlPUThKQnkyQVpKM3l6?=
 =?gb2312?B?alp3LytIWFdQY3dIMitrTURDMHVKNFc0bWFyQllNcFN5RnN4T2FvSzVwUFhM?=
 =?gb2312?B?QWFnbzFTY1NrRTB2QS8veGpsWVNieHZMcFZpYWVlQldUWkhtSUpuclNlRzBD?=
 =?gb2312?B?MjhaN2JMN1dQK2x4MzUrUFBJUC8zOWp6YXJjOUZBNmpwZ0xYei9kRUpSMitG?=
 =?gb2312?B?RWNhUjkyT01udFRKejVzR3pFblJ0UkZJT2lHdkN4ZndpeThOcG1SWVhZS0sv?=
 =?gb2312?B?N0VlY1ArZkVzUzNQSVZZZVQwNUkxREo3Qy9GV0ZlVzR6a29qZ0xGS2QyN0Vk?=
 =?gb2312?B?YUJHMCt3TDIxSjBYWnAvT1lTUmtLbnd1amJTTC9NTmlmSFJITm1KdnRvTkdO?=
 =?gb2312?B?bGdzQUpFNEJHNFVnaU9wcmhSMjJyN3NLR2UwWUQ4Ykc5RHpwdExGemlJQkdT?=
 =?gb2312?B?YXp1UFpvWHMzd0Z2TURpV0NybU5tMVE3RWkyRW5LOE9xRTBlbVExSTNMYXVV?=
 =?gb2312?B?RmJNRWZqRzFRMmdUY25DWDJjQkRwV0FLM2t2cFd4OEFlRFhacVptSSt0Y2hQ?=
 =?gb2312?B?YU1peSt1dGJVTE85aGlYNWc4bGxsRjcydktHRVg4NzVoNGY2amZXMTJUZFhB?=
 =?gb2312?B?WHVuOXA1YTAwTkhoTS8zOXdPREJ4bU9yY0Y3enZ4YUdVRFBpTHJXc0g4c2JS?=
 =?gb2312?B?MzZ4L3pueDUxYmRVdEZCSEZUcVdiQUt1QVlvZXlyY1A0WmZRNnBmSUl5bnJn?=
 =?gb2312?B?NkQzZTVEWld0UFRWbHJXU2NraC94OHhDd0JTZzdLWGs2ZjkwV1ExZ1ZhT21T?=
 =?gb2312?B?OUhrUy9Lc0JIVkpjcXc1bkVOYXh3VTVyL0QwUXNPZFZNWTlWWUN6Y25TdTFv?=
 =?gb2312?Q?agHWz9yCvgGYXfohbQZvKmp2cf2fFRspSMWoEwZ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fda34d-d28c-4a44-c0c7-08d97670ef95
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 04:42:47.6972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m91iug7U5nsHTvNRPN9QmmPKQ9rI38yz26hafSQc7lIZnEL/KF1zohbS3KPnRG6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KeWVwLCB0aGF0IGlzIGEgbGF6eSB3YXkgdG8gZml4
IGl0Lg0KDQpJIGFtIHRoaW5raW5nIG9mIGFkZGluZyBvbmUgYW1kZ3B1X3JpbmcuZGlyZWN0X2Fj
Y2Vzc19tdXRleCBiZWZvcmUgd2UgaXNzdWUgdGVzdF9pYiBvbiBlYWNoIHJpbmcuDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+DQq3osvNyrG85DogMjAyMcTqOdTCMTPI1SAxMjowMA0KytW8/sjL
OiBQYW4sIFhpbmh1aTsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCrOty806IERldWNo
ZXIsIEFsZXhhbmRlcjsgS29lbmlnLCBDaHJpc3RpYW4NCtb3zOI6IFJlOiBbUEFUQ0ggdjJdIGRy
bS9hbWRncHU6IEZpeCBhIHJhY2Ugb2YgSUIgdGVzdA0KDQoNCg0KT24gOS8xMy8yMDIxIDU6MTgg
QU0sIHhpbmh1aSBwYW4gd3JvdGU6DQo+IERpcmVjdCBJQiBzdWJtaXNzaW9uIHNob3VsZCBiZSBl
eGNsdXNpdmUuIFNvIHVzZSB3cml0ZSBsb2NrLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkg
cGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gaW5kZXggMTkzMjNiNGNjZTdiLi5iZTVkMTJlZDNk
YjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1
Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
Yw0KPiBAQCAtMTM1OCw3ICsxMzU4LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGVidWdmc190ZXN0
X2liX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp1bnVzZWQpDQo+ICAgICAgIH0NCj4N
Cj4gICAgICAgLyogQXZvaWQgYWNjaWRlbnRseSB1bnBhcmtpbmcgdGhlIHNjaGVkIHRocmVhZCBk
dXJpbmcgR1BVIHJlc2V0ICovDQo+IC0gICAgIHIgPSBkb3duX3JlYWRfa2lsbGFibGUoJmFkZXYt
PnJlc2V0X3NlbSk7DQo+ICsgICAgIHIgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZhZGV2LT5yZXNl
dF9zZW0pOw0KDQpUaGVyZSBhcmUgbWFueSBpb2N0bHMgYW5kIGRlYnVnZnMgY2FsbHMgd2hpY2gg
dGFrZXMgdGhpcyBsb2NrIGFuZCBhcyB5b3UNCmtub3cgdGhlIHB1cnBvc2UgaXMgdG8gYXZvaWQg
dGhlbSB3aGlsZSB0aGVyZSBpcyBhIHJlc2V0LiBUaGUgcHVycG9zZSBpcw0KKm5vdCB0byogZml4
IGFueSBjb25jdXJyZW5jeSBpc3N1ZXMgdGhvc2UgY2FsbHMgdGhlbXNlbHZlcyBoYXZlDQpvdGhl
cndpc2UgYW5kIGZpeGluZyB0aG9zZSBjb25jdXJyZW5jeSBpc3N1ZXMgdGhpcyB3YXkgaXMganVz
dCBsYXp5IGFuZA0Kbm90IGFjY2VwdGFibGUuDQoNClRoaXMgd2lsbCB0YWtlIGF3YXkgYW55IGZh
aXJuZXNzIGdpdmVuIHRvIHRoZSB3cml0ZXIgaW4gdGhpcyBydyBsb2NrIGFuZA0KdGhhdCBpcyBz
dXBwb3NlZCB0byBiZSB0aGUgcmVzZXQgdGhyZWFkLg0KDQpUaGFua3MsDQpMaWpvDQoNCj4gICAg
ICAgaWYgKHIpDQo+ICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+DQo+IEBAIC0xMzg3LDcgKzEz
ODcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX3Rlc3RfaWJfc2hvdyhzdHJ1Y3Qgc2Vx
X2ZpbGUgKm0sIHZvaWQgKnVudXNlZCkNCj4gICAgICAgICAgICAgICBrdGhyZWFkX3VucGFyayhy
aW5nLT5zY2hlZC50aHJlYWQpOw0KPiAgICAgICB9DQo+DQo+IC0gICAgIHVwX3JlYWQoJmFkZXYt
PnJlc2V0X3NlbSk7DQo+ICsgICAgIHVwX3dyaXRlKCZhZGV2LT5yZXNldF9zZW0pOw0KPg0KPiAg
ICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+ZGV2KTsNCj4gICAgICAgcG1fcnVu
dGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2LT5kZXYpOw0KPg0K
