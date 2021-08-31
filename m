Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D290C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 03:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDEA61029
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 03:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FDEA61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AA18973E;
	Tue, 31 Aug 2021 03:24:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5E68973E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 03:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8uUwinG8ZSp07bMn4lCn6YXUpD2in12M74W2A1/GUYvmuMDJZd47d5YCaD32dgWrxOm6akt9DMWD21wWb32jwICy7u0B8gS01FjFtfG8TGHyd3/oPvpZVSxNEk+/1L98wWNZIhnktcjhx9irNbOwtVESWEz36aXvw6pJcvHk19oginC8tguZNwHRxh3RrKtGqymqJ0olsySFOMavRYQkoDwwBgpSUUL5oIY/sPVfX5qaSIbFIAzt7wsMKISOf/5tH7H+deNmiLRqb9qwhrLP0hvFy8yv3LlU0vv6qbuSHr4GYlUpfjWZtCaZh8LVxLfjqlg2rfI2aQ+apDCFuqOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNgywWSXlptavE7GMM0vFnvddrz0u7+6T1A4dB2R/lI=;
 b=MUtlHR454RYcctW+WbJ5039ALV0rzpKxkH4q0Z9CfbKwONcTKg/A3lWCm08kXCYooAZY+hVmPr48UNaJ66R0Vds5zDulgazmDiDiwInGWofGQXq98L5GMOCmCSTckmZebSkGteTYxwAz574ZgiPkTdBAxCjaqeEQ2/apeOZ+aeuRrQFfZ54W6okakm0C+XIPJxN/LgFNLJw0+X49H71KsQUjiAkodLv+eZERQyhLA1aCvjk2T3Y6DuYSVqbgz83VQ9pSneFpFANMnmP+zgU7oAi6qto42v/3OlxNaSXhBxA+gMyOgxyE5dp5WDLKcXErHsZtsDGgNG3gQfZFKE/ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNgywWSXlptavE7GMM0vFnvddrz0u7+6T1A4dB2R/lI=;
 b=f0AiNmoOf/JFrptPwVfGSImzur8p07Xql68/mS/p2jPWI8pTlskVTp6r5vkcVJ9S37nT9JZTO1Engf34mSjl8G3eEdf3iQFv+sXG4GT6KP4K0uMBxwlZMqrPQyQ1xCeXSS4gNjW+hEsc++URTDZvjSKAZuShP5xde5cLT2TUFfw=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18; Tue, 31 Aug 2021 03:24:18 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 03:24:18 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object allocation
 fails
Thread-Topic: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation  fails
Thread-Index: AQHXnhaNGvIF9ZCv4UOuvw8RU5G9JA==
Date: Tue, 31 Aug 2021 03:24:18 +0000
Message-ID: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-31T03:24:17.215Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172c0068-2e60-4e0e-2303-08d96c2ed150
x-ms-traffictypediagnostic: DM4PR12MB5360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5360364D8F73A2B748EE13FF87CC9@DM4PR12MB5360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cji+anHmYFnICXTumB3ggOv4hTlOctL7puOfLd7mnuie/Ys3EFqz7/qovSdy7Lq/Miwym8pXaOspOFpWY3msfOeq+D1ga5/vIOay4XWluNy3Z0QsfGu0oKDfHwE0eHSlxWuZtKtY1VXOrFxgrDSf8HmNnNtfiQyaxeZZfppJQUUGZ45iXoqn06++6JFoS1x9gmcJw3qwiO1NVptXcdq9zB4+A/G8i6YBI9FrvfgSrmhwpnnD30Xmfb29mmEKsFyu/8qef9RcaWage31MIw2SA9wfkiE8kNY0RkMBX21SvbWR3dv54EJ0tb9ToQ6mU0tJzRoHB4nqs+JmW3jGxCV9EoUc184p4tSa190xiTQMKxN6SBM6w7Xyjvv2lpLA3qk+HQs4YPBEfeH8DKBTwYoCgQ6NGIQdXyuTV8x27ODoThfqHmWnKOyj/RNoGgOLpV5nu3IM5URYU9FC8YP7Z2BXlgOqP06iE+VJVlz1oke+O6rOTnIbttIeL75NsxH4OzvjuEtZxJ6uvP6vSyNH9vDRhGgguKbS+sQ+E9ehatEWxeffUivYZDVOs5lW6xdJuAZPm8o3/5G3PoaxnHZdAaZStp8T80Hascp2FPtOf5BdTEuX1X5OVqoTaM0v9lJb2RlCEaXynMBbG89U2X95GnSSUD9CyYy+qOavwv+RPQFsSGlV/URN7KkaodQB+Jkk3VC/+c8kRT2LfPvvXCGXSTNEKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(76116006)(91956017)(66946007)(86362001)(7696005)(38100700002)(26005)(8676002)(478600001)(5660300002)(6916009)(4326008)(6506007)(38070700005)(9686003)(122000001)(66446008)(64756008)(66556008)(55016002)(33656002)(316002)(52536014)(2906002)(54906003)(83380400001)(71200400001)(186003)(8936002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WVZOOVZFL1V6V2xGcVZsdUpkTlZMak1yU2hTRzNrRWpqSkp6M2NuWU9zOFho?=
 =?gb2312?B?M2E5bWlzdkVYZ1ZzQnhKYXliYmVXT0ZGdGlzRnJEZVdNRUtFRlRtS28xN05h?=
 =?gb2312?B?b1FEY3ZIMGdUek95TjQ0Ny9FMStpeWlWUTRFdmRpVURvNnU3TktDZmYwdmlp?=
 =?gb2312?B?N0h6WW5JQjA4TnYvcmRIZjI0SHZ5M21BdlFuNUpaNjA2V0RYY0lFc1Y5M3hk?=
 =?gb2312?B?T0FFQ2pXaFFKbzFVdmk4ek9LcS9GeEZ4dDEyaDBUcnl5R2Q0Z3ZQbUZlOEpL?=
 =?gb2312?B?ZWhVR3cyVmJUM1JFOXF1dkhtdW12VWtjeDYwVVk4QlZsb0tBdFpYSlo3Nk0w?=
 =?gb2312?B?QkFud0dxNHplVDZNSmJRVjIvMEZYUnBrRFp1UTdoSVFsUDJMM1VVVHFiTjNV?=
 =?gb2312?B?dkNUMndMaWJrdlFTR24xUzZ4L0hsZ3FiWWVGM2kreG5rdnBiRVJ3ZThMQlZT?=
 =?gb2312?B?ZmoxZncxSTJYNk9xQjBqOHhTQm04bU9ha3M4OHFOVmdkczRqMGI2ak9ocm5t?=
 =?gb2312?B?S1VtY201VG9rSWR1d3JpR1NWRU1RM0p2K0h2Nml6c01ZbFU0bnQvWHZGQW80?=
 =?gb2312?B?WWM5UW9tL3F2UnNNQk1KNDQyMXBnTlVpQjhjanUvQkpGMzVDWGZ3ZlNwVTZn?=
 =?gb2312?B?M1N2QlA2QU5BNFUvR0VBeHVQNHVNT1FMSFVOQUthQUZCU0g4SVlZRnFVaXo2?=
 =?gb2312?B?QzB5OUZBQjZ6UFdvb21XSTd5amJhbWljcUZoOWFscTVoOS9rZ2dObzQxcmtT?=
 =?gb2312?B?STZxZkdndzRBNHYyQzlXeFhRcGp4c1NBWlE3V2pOM29NNDlZQlExZE1vT2hh?=
 =?gb2312?B?ZTRRU2RaZ2VPZUxiRklZM1liUkI5NmJTTWlqeWErcjg0dDZNZnJsM1hNQ1k3?=
 =?gb2312?B?Uk4vK0FOWnA4aHlkbitROUsxeUYzMUFYZGJhbWRjeFNIM2FaUjIrSWVja2xs?=
 =?gb2312?B?RWNZSWlURnlrWXlINTVaMzNOV0loMVZ3RUwxYnZKcEZpaEVMM1AzNWZ4RDFH?=
 =?gb2312?B?U3NESXBweDB2d1RGZ1JNVk8weEMyZGtneVRWbnhDQUlzcHEyMXhlQmhDTnMx?=
 =?gb2312?B?QzVpOHNFU2NiMHZJUlV1K1FaUWFKQTBFVm5Beis3TXFzSTRvSkxORzh6UTdZ?=
 =?gb2312?B?TDZyaWtibTZQdmxUUlkrUWprZXZhU0VWWkdhS0lRZXlDR3k1aXNxVjRTeGls?=
 =?gb2312?B?b1NIcGdqZFFKaCtVNGUzb2c2YVFVLzdhTW5iMi9QWnE2aEozOGUxRkZFak9G?=
 =?gb2312?B?N3EzUzZYQklySnZOeVBVNmtqaVVPOEQ2WDBBT01pYlVtUUtCT3JFYWZoanM0?=
 =?gb2312?B?M2xxSG9LYUJmOU5pendCMFIrVm1ldDhjMFd0V2NyMHlvQklZMUs3bjhOVXN3?=
 =?gb2312?B?REZYSGhDRjk0aHNSelo1Vm40MjNwV3JieEJHZERrcjFwQ3luSDRuQVlhd3hu?=
 =?gb2312?B?WkRML1NmOTVJMWxhaDRqakVpS2tob09ncjcvS2hXVlNrNno5N3pIMDV4V0Rt?=
 =?gb2312?B?eURuTk45TUgwZFVmTy9ISkpiNmdUbGxQbGhSWFYyb3dLUHJ4RjNCci9KbXFq?=
 =?gb2312?B?cmVRRE1wQUMyMGYwTmU0bEJ5OGFlNkFYVFhUcjZCQUQxT3BHTkE4ZFNWMXcw?=
 =?gb2312?B?S1JxK3Z0Y1JuUDE0Y1M2eVBpWEROcnJOWWdmRGMzckx1aWd4UkticE1JRjVi?=
 =?gb2312?B?azFkcnVyVm10SEhBamlwN09Oa0ZoaXk2Q29ZdHJ0aHpHWmxMejdjUHludk9i?=
 =?gb2312?Q?zEL59kmbbzkKNpjWDE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172c0068-2e60-4e0e-2303-08d96c2ed150
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 03:24:18.3122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNNCSE8JEZeZacSHtN4AtX+DXARnq2JmXsMjNodYO1zOEgCzDp62SAWPenHEn3/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVW5yZXNlcnZlIHJvb3QgQk8gYmVmb3JlIHJldHVy
biBvdGhlcndpc2UgbmV4dCBhbGxvY2F0aW9uIGdvdCBkZWFkbG9jay4NCg0KU2lnbmVkLW9mZi1i
eTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgMTEgKysrKystLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jDQppbmRleCA4NWIyOTJlZDVjNDMuLmM5ZGI3ZDJjNTgxNiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQpAQCAtMzU1LDE5ICszNTUs
MTggQEAgaW50IGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
IHZvaWQgKmRhdGEsDQogICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoIkZhaWxlZCB0
byBhbGxvY2F0ZSBHRU0gb2JqZWN0ICglbGx1LCAlZCwgJWxsdSwgJWQpXG4iLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemUsIGluaXRpYWxfZG9tYWluLCBhcmdzLT5pbi5h
bGlnbm1lbnQsIHIpOw0KICAgICAgICAgICAgICAgIH0NCisNCisgICAgICAgICAgICAgICBpZiAo
ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WTV9BTFdBWVNfVkFMSUQpDQorICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHZtLT5yb290LmJvKTsNCiAgICAgICAgICAg
ICAgICByZXR1cm4gcjsNCiAgICAgICAgfQ0KDQogICAgICAgIGlmIChmbGFncyAmIEFNREdQVV9H
RU1fQ1JFQVRFX1ZNX0FMV0FZU19WQUxJRCkgew0KLSAgICAgICAgICAgICAgIGlmICghcikgew0K
LSAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYWJvID0gZ2VtX3RvX2Ft
ZGdwdV9ibyhnb2JqKTsNCisgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICphYm8gPSBn
ZW1fdG9fYW1kZ3B1X2JvKGdvYmopOw0KDQotICAgICAgICAgICAgICAgICAgICAgICBhYm8tPnBh
cmVudCA9IGFtZGdwdV9ib19yZWYodm0tPnJvb3QuYm8pOw0KLSAgICAgICAgICAgICAgIH0NCisg
ICAgICAgICAgICAgICBhYm8tPnBhcmVudCA9IGFtZGdwdV9ib19yZWYodm0tPnJvb3QuYm8pOw0K
ICAgICAgICAgICAgICAgIGFtZGdwdV9ib191bnJlc2VydmUodm0tPnJvb3QuYm8pOw0KICAgICAg
ICB9DQotICAgICAgIGlmIChyKQ0KLSAgICAgICAgICAgICAgIHJldHVybiByOw0KDQogICAgICAg
IHIgPSBkcm1fZ2VtX2hhbmRsZV9jcmVhdGUoZmlscCwgZ29iaiwgJmhhbmRsZSk7DQogICAgICAg
IC8qIGRyb3AgcmVmZXJlbmNlIGZyb20gYWxsb2NhdGUgLSBoYW5kbGUgaG9sZHMgaXQgbm93ICov
DQotLQ0KMi4yNS4xDQo=
