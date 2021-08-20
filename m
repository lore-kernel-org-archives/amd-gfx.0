Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F1C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CBC6112D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61CBC6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5926EA39;
	Fri, 20 Aug 2021 08:55:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B4B6EA39
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 08:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAOTGiOKjcQyMzP1kCAAPbVolsBscFcpTHqfMxdP2IirKawz2YweJXaY9XHD56pDeCAUvRebQRBI8M8yPgeZVUlsW++69ma3KWUkDBqE5/RzKByRIu5RNtDbcWHjg/3xLScTPoVwYIRljm3hk/t54DeFGb99Abv2umal4wxNhY9Sfmgil1GuHclH/7HB5QEO9Pi9omPrr6M2lVSjBTChNCncGMQvzmiiBaHEF1uPY/YIQ+1URsxpx9g3+qjxSBv8tU5poiOt3hzmpqEUtWxVxN2/PqKhbaT/7A9lCYWAUeN0gkC4rP4vQARMcrHmxozJ1u5W1nm7kstDVU2ICWMeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDERwnnBT63kuruN/sIA3tveG6oJlbIoRAcVrs5aOzE=;
 b=aqlKw7o87X3Sdbzi6pfZS/IbUEITTUbhsxb86SNVXfGGiKIv6kA8SB6Vmg1Yt+YcQvDSZteC42Y012OWJWHZu7M5G7Be7FeupyhKF/0GHPoP82l2cl0LZaD2/FTK09D2w2PqhiS0Qa5QhglSyJSenJ01iutx4LlUy74ndBv8XwzlGORHowjXaBRxRXK006zcvTqfb+jhbXg5pRTJw49yIa5zp3iauqMVs85P8yEBfT3Cz0u02RovKHP8H4lrRCUGEaBwLJ7K381gSib48Gh+SQH27l9GEOpI62FEHIMI3sIwt084bTcQbBdsi8xldzMq9sTeU0vozcdIDarkU8A5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDERwnnBT63kuruN/sIA3tveG6oJlbIoRAcVrs5aOzE=;
 b=KWvqrpR41t6qY5Q1lnFa62I764kExxuH3jhJtx6oRqElcLLA9Uxdhi5y6Gvww5xzlP/HRFsEtvh46nBbFWZDs2eMCP5TAholdSJtFOVPXrv0oCazEPLqBvd/a7HMZj1kmzCjab/4xX7/Eqq953JXLsxKjasGsNuG4212eh/aQvI=
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 08:55:34 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850%9]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 08:55:34 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use the preferred pin domain after the check
Thread-Topic: [PATCH] drm/amdgpu: use the preferred pin domain after the check
Thread-Index: AQHXlZ2nPTd6Yn17Z0OjYRmj7G+Obat8FuSQ
Date: Fri, 20 Aug 2021 08:55:34 +0000
Message-ID: <DM4PR12MB5040F3DA363D28A88038E59CF2C19@DM4PR12MB5040.namprd12.prod.outlook.com>
References: <20210820083031.1533-1-christian.koenig@amd.com>
In-Reply-To: <20210820083031.1533-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-20T08:55:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a08c1567-6824-4c81-9c4f-f24703e9bc51;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 183cafde-77ae-4b80-3e0a-08d963b84589
x-ms-traffictypediagnostic: DM4PR12MB5103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5103FFD4668852B68366FD05F2C19@DM4PR12MB5103.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XRvcPNLuQwxBkWwBOnEnCyG9uEVUfEw2j67FmpN5DM+2T9eqQGv7ppIbEhHyz6PxQAQi3FovYtbR8wSbD4IQdFZiOL4+1YWtEBgtjY47V24BHr1THZYDS1LNr8FgQF7PCE/66HPHR/njH0WZzPgQwOe7/iTlDzgUxjUmuIfBtMxGQewZRnKCVJbKnRWc3pOmLhtvhZ5KfzLBpMXjf3Y5A5a4BOHgu+s5Q1/n7oKm31uOxbiZeZ7MXZUD07e9nvXmr1Wt8rj8x/37QjqhK0yjEn3CTjjxjI9wt2wMwOHeZBeJ/WPTOi9/45zRw/i7EtM5uikNQvkzF36dJuyHDJL5d0sufSlbIWEYpl11LcS7f3LHZUFUCnDVmjoKh8e3Zw/dGBVER4wjWbqc3rxajgZHOsocm7f/uVa37qFdQ3SYq3L8OrHmYI4OagX6cY6X9ocikEpZgjCS1hI+O8fGiWgVqxH6snDFWLNLjsmcMK+AdI4LZWGdC0ijafR/efZKI+b0sF5bvQaUPKy8jFJghJJIbv+VuA9Rq/TkrMnBlqxBCmbYn/y17iCMBT5WNJt2j8/5KA5jzhJcsCPrSYx+mBaLf8W5mkIMA5DJqKZzyoMn3R0lgM/tmg/giLSkFqTQlmQwF1UlrC3qUd5lZCHC+zVMtGlBbt+rLAYXyzs90Zk2fram/u6mZrBAshgr7y5eo2l+7+jDHblDzPyv0R+gelUig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(346002)(136003)(376002)(66476007)(86362001)(66446008)(66946007)(66574015)(64756008)(55016002)(52536014)(2906002)(122000001)(71200400001)(66556008)(38070700005)(8936002)(8676002)(110136005)(7696005)(9686003)(55236004)(186003)(33656002)(38100700002)(5660300002)(76116006)(478600001)(83380400001)(4326008)(6506007)(53546011)(26005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0VvYzVqUDRhNWM3UnpONHhkSlZSVG1NVTBmU0NpcUlMMTRyNi9ySkFIVEgz?=
 =?utf-8?B?bEp6STdQemNqZ1EvOWJVYXRqaE5JRDQyT2NQaE1LbFE5Y2NJV0RiZ3VjWGY3?=
 =?utf-8?B?WGFTN2pGYXc4M0x3b1Z5M1IyckxXL2ZZUWxOM3RIbkpwUTRyWTBhTURnemdR?=
 =?utf-8?B?TUFXKzBvNXVYL1hIUVllaG80eGRrRjk2MXhkV2h6Wm9vVzlyV2tMSUdIbFhk?=
 =?utf-8?B?M1ViYnJoOElmVnRKb0d4U1dQbjhIZWJnL21SSXlPSlg2OTRLVlFSSnNERWdG?=
 =?utf-8?B?aVVDcUJUeVFoZU1QRUlpTkh4enNFcjdGL1ZyRlM0ZlRobkkzempLNHpiblhQ?=
 =?utf-8?B?M0d3L3ovTXdkT0Voem9VRUhNbFZoTkNUWFhRUWgwT2lCRWxra1NFNXlnUXk2?=
 =?utf-8?B?VmhBMlY2am9sU1hUSWNGejkxSi9BbWpGZ2puZFp2VGl6aUtWMC83dGl5QUh4?=
 =?utf-8?B?TmE1amRGd2c3dFBJcDl2b1FPVWI2cllkSHhjYVUzbFVIaVl3dEhPUnZwVTc4?=
 =?utf-8?B?TnRYQWl6cFpxQUdCUGF4d0pLNmhUQVNkQVFyS0s4dEpsYlUrTzlTZDFSWWRk?=
 =?utf-8?B?NndNOFdkZDRSS01NcUtvV3NsejgzRnBZR1c5YTFETVdsY0VuRFNGQVNOM3Vu?=
 =?utf-8?B?ZWV1cHhBWnVkd1RzRDFqVnB3cHlIYkZFTUNEODVBcURYaTNzUjdrSVk4WUlP?=
 =?utf-8?B?Q041bEhUWExkSWV5YmVyUnp6U0lLMlJlK0Exd3BXb3doSWZrbWpEZkhKMlRV?=
 =?utf-8?B?ZUZ3blFvM2VUbER5Z1c3YmVkd0w0YzZiNVR5L0wrKzlKdTdNVytiTDhOY21h?=
 =?utf-8?B?VGtLVGM3Y2lRdnRpNDJaMVh0dmsvOS83amt5MlJnV2RqbXNUTCtMT0pVenFi?=
 =?utf-8?B?TzBJREdqWXk1UHhiaDdueXNPZE9yQkRsYXBSYzRSZWxkcHpLUjFKYXlnRzY1?=
 =?utf-8?B?SmJZSFRlNGdZL2tXSFovL0IvTGZibTEzSVVEVDBvcjBiYmx6amk3MDRibFU1?=
 =?utf-8?B?c01OQjdiaXRNRHpYUkxHeXpveFZaZnhaTUZ5Vk0rd25UZEtQb0t5Ty9CU3hi?=
 =?utf-8?B?eGpvbloydkQrVnQ2KzlJQXlwc2FHNnJEd05LMWNvRUwrNCtCNUlSU0Nhb3RD?=
 =?utf-8?B?TEs5RXVEMGdQaTNURUpoaVNxNUxHSk5sZ2I5MklvMnZ4ZXdqamsveGFKSVdX?=
 =?utf-8?B?N0ZLSEtobW9adzkvOVhjTks1NTJpNS9HS3lOU3JkNVdnTFNVa2FUQTJPWHJT?=
 =?utf-8?B?Z2x5bC95di80aDhKblgyZWV1clBvQlBYa0F5Q1JHZmZkaVBtNzIyRzc4MWpP?=
 =?utf-8?B?R3ZMS21pdCs3SVdLclJEY05URkdhcmZpUDEyd2tTMXhCK3VGUlExeDM0Mjg5?=
 =?utf-8?B?L3NoaCsxdkZMV0FNbVBLSWluUVVSbzh6TDFjYksrZmJMYTg5Y3dLUlIvQkJT?=
 =?utf-8?B?bEUyTS9yUWdXOCtyVDMvaG9KNXc1VTlkLzRHSmp3bUpWb2dDNVN4NEJqN0Q5?=
 =?utf-8?B?WXFPVWtGMU5nalZBUThaUVRGMGIyL1M1NFY1VXM5N1BDZVM3b1llUGRFRUR2?=
 =?utf-8?B?QVp0QXYvakVWSU9SMmk5SFhiM2lyN09VNTFha2NOOUF3Qi9DSitYV0ViRHgx?=
 =?utf-8?B?dlhjbW1XKzB0WWQvcGZTbkhoZmlFQUhnWi9QeFVaNjJOTnhjTWZIdldqYVgz?=
 =?utf-8?B?dHhpbXFkalQrNlZ4anVMZHk3L2Y1U1ZNa2licTN6b3h3US9Pa0FZN2FaN0pp?=
 =?utf-8?Q?xOwVBa0bK+5r1bAZ6FEDDDJmnXBDxc+lu0EBj8U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183cafde-77ae-4b80-3e0a-08d963b84589
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 08:55:34.0255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iplUwvvJoJ0BYmGFYJ3kHoAbtzeUduRSFiueN6DdmFFvNGqr1hvwhj7bN/sdAljDJjF4d2xa7KJuI0jfZMDYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUGxlYXNlIGZlZWwgZnJlZSB0byB1c2U6DQpSZXZp
ZXdlZC1ieTogU2hhc2hhbmsgU2hhcm1hIDxTaGFzaGFuay5zaGFybWFAYW1kLmNvbT4gDQoNClJl
Z2FyZHMNClNoYXNoYW5rDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdm
eCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENo
cmlzdGlhbiBLw7ZuaWcNClNlbnQ6IEZyaWRheSwgQXVndXN0IDIwLCAyMDIxIDI6MDEgUE0NClRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTog
dXNlIHRoZSBwcmVmZXJyZWQgcGluIGRvbWFpbiBhZnRlciB0aGUgY2hlY2sNCg0KRm9yIHNvbWUg
cmVhc29uIHdlIHJ1biBpbnRvIGFuIHVzZSBjYXNlIHdoZXJlIGEgQk8gaXMgYWxyZWFkeSBwaW5u
ZWQgaW50byBHVFQsIGJ1dCBzaG91bGQgYmUgcGlubmVkIGludG8gVlJBTXxHVFQgYWdhaW4uDQoN
CkhhbmRsZSB0aGF0IGNhc2UgZ3JhY2VmdWxseSBhcyB3ZWxsLg0KDQpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAxMCArKysrKy0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KaW5kZXggNzk1ZmE3NDQ1YWJlLi45
MmM4ZTZlN2YzNDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYw0KQEAgLTkyMCwxMSArOTIwLDYgQEAgaW50IGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChz
dHJ1Y3QgYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwNCiAJCQlyZXR1cm4gLUVJTlZBTDsNCiAJ
fQ0KIA0KLQkvKiBUaGlzIGFzc3VtZXMgb25seSBBUFUgZGlzcGxheSBidWZmZXJzIGFyZSBwaW5u
ZWQgd2l0aCAoVlJBTXxHVFQpLg0KLQkgKiBTZWUgZnVuY3Rpb24gYW1kZ3B1X2Rpc3BsYXlfc3Vw
cG9ydGVkX2RvbWFpbnMoKQ0KLQkgKi8NCi0JZG9tYWluID0gYW1kZ3B1X2JvX2dldF9wcmVmZXJy
ZWRfcGluX2RvbWFpbihhZGV2LCBkb21haW4pOw0KLQ0KIAlpZiAoYm8tPnRiby5waW5fY291bnQp
IHsNCiAJCXVpbnQzMl90IG1lbV90eXBlID0gYm8tPnRiby5yZXNvdXJjZS0+bWVtX3R5cGU7DQog
CQl1aW50MzJfdCBtZW1fZmxhZ3MgPSBiby0+dGJvLnJlc291cmNlLT5wbGFjZW1lbnQ7IEBAIC05
NDksNiArOTQ0LDExIEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdw
dV9ibyAqYm8sIHUzMiBkb21haW4sDQogCQlyZXR1cm4gMDsNCiAJfQ0KIA0KKwkvKiBUaGlzIGFz
c3VtZXMgb25seSBBUFUgZGlzcGxheSBidWZmZXJzIGFyZSBwaW5uZWQgd2l0aCAoVlJBTXxHVFQp
Lg0KKwkgKiBTZWUgZnVuY3Rpb24gYW1kZ3B1X2Rpc3BsYXlfc3VwcG9ydGVkX2RvbWFpbnMoKQ0K
KwkgKi8NCisJZG9tYWluID0gYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfcGluX2RvbWFpbihhZGV2
LCBkb21haW4pOw0KKw0KIAlpZiAoYm8tPnRiby5iYXNlLmltcG9ydF9hdHRhY2gpDQogCQlkbWFf
YnVmX3Bpbihiby0+dGJvLmJhc2UuaW1wb3J0X2F0dGFjaCk7DQogDQotLQ0KMi4yNS4xDQo=
