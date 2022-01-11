Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22657C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FCB12B3C5;
	Tue, 11 Jan 2022 07:52:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD60012B3C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp4BdxUnNoJsJEdlLzK+ihIsYG5XTzF+UX9u3hAv6qHC7qfgH2lQjxrsCI0ndtnm3G7FlJOmwQ8PfjGyLtju7VvUNRwsr+epZdbq5xRy2oVxtIlaiEsiw8KMXnddntvEsMdJrAWBloc82HgK19w0BA6HChMntQ6BCIpPhaW4Ggt99sl9XwVC2KYbcvrfAXrd2QKIZB1A0emMS+5cvg2xhVNoLzL5qmGKqH7GoUoWg8oTWozUhgi6nYCPttzADMXFtEhYvO9ScepC2rQWs4cWW1fXCBLPtFcBA7IAR2w4RBvg5kF7UP5SHUOqcLnwp/Nloo9296btB/KO16U2KZO/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxgVsvxmkpAHjLpGZpJR1W1yUWArT02Q/7rM+covZIc=;
 b=Nwz2eatxW5ezHIvFVGnoY+5F4VqJGWM0DE9aEPLkfSdDfASMsWRSbqj6dXnMyCnTRa8TxLAjVGL4j/oAGLLmbWVhCvf4peccKN02mS3KRpVIDSiGlUAwZ/JF7GQaJV0eDXwg55PYoGewc1DP4UMtr3ZM4XjP1vj4jl8kU3ySU/GDYCAcsB+vDZOVfCeWOP3nl4qUX4kJezRc0aXdD+QBrmSTWt0cPrkKE3egeaX4XACCDNzZaExGNshjZ2RTpO/rK0zUktoWWyoYOQbVT2idrmGv3DyLhk/z+p6YzUCkKFlZhvFQvBVwWf/8fd0MKBNChRwKI2MVZEnjmGrunGop2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxgVsvxmkpAHjLpGZpJR1W1yUWArT02Q/7rM+covZIc=;
 b=hZrksF+MpvOsJZD6ncq+j5+37REbb3YWiTQiy090OHzb4Hfq/IeuWHzaYMfh8OzcJvGRVnOhvjUBABuWcNx4vP0d7+BuKT57lzP3BNY5uYqh6BKBHDHpUjGLHutmhKoCql9tUlTL3fAQXvsnJiJuuYFdIRaSWGkIaHStiPmvR3Q=
Received: from BY5PR12MB4643.namprd12.prod.outlook.com (2603:10b6:a03:1ff::28)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:52:33 +0000
Received: from BY5PR12MB4643.namprd12.prod.outlook.com
 ([fe80::4443:ab92:2d4:7f32]) by BY5PR12MB4643.namprd12.prod.outlook.com
 ([fe80::4443:ab92:2d4:7f32%2]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:52:33 +0000
From: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Topic: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Index: AQHYBgFyW6apt73fO02h9f8bOAIVnaxcc1WAgAD8jEA=
Date: Tue, 11 Jan 2022 07:52:33 +0000
Message-ID: <BY5PR12MB46434EFB35BC0F88E63B30E3F2519@BY5PR12MB4643.namprd12.prod.outlook.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
 <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
In-Reply-To: <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0419c4c-7b74-4de7-59dc-08d9d4d753cb
x-ms-traffictypediagnostic: BYAPR12MB4598:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4598A14C76A3642CF18FFD74F2519@BYAPR12MB4598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gceCwrFmIQk9Qds9/ws9d87gqmDzpRb7JPxbGbmvsupSbL8cZ9UCKzrGtV8m7lGuT7K9sibGn3rkOqRqZCvZLUCyb0W9qsfR5H1pu2zoXsgXfWf/erIYSJ4bbNvbZLrBE54mzz0t/HJIIIcRYv/ZIfFuQL7wufVR9FedD9XHiIlWS2YN0UhzmBdGE93HIWkTm0ooTUevHd2KDpIbw2/fXJzgU0xg/yyYtft8Um6cBmqjxO27neT1bXLkKe4MYhEGZC6zEcbLE67VBftEVWNMBWmGKSz5dYFz5aN0PjgOk+oNVyDL9ht+KJssQ/U2UwNnQmEP9OBVO2rTmFAcny23l3uqecKYeUYleK5PlqLBGMkqPoVpY5ppIQokk8oXxnEWfDPofWtX3GOl3YMxHPeim955hICT/iBOdc7clSpxp5tIHzv8bieTwFbXaLUU2HVjXKyhMwFQHl/1yOe5LZdRAvM6T+9+DcGqxi02wbXLfjuwiB3T/mLuZ17Y29sU0q59gtgMt8HXQGwkSOtPLvH12RvMMdlKX9ZfTIGa1bwH6e9+Ub2sDbK/UDBFhIxrPPxn8fsOfSMXPvRxjcM6HlLRvYqZXYWb0jdNxpoxoPkQaZWCh8MY3jDx7+qY06PyQSUclNl9Z7dEYGjlxwH/ZYIxZJkVfV+pG35pmxuAsXXqnUv7TZdKRdp1wzeANFIdP7i2SL96Ew1sJl6cr/m8Pp+QhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4643.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(33656002)(83380400001)(122000001)(186003)(55236004)(6636002)(53546011)(316002)(66476007)(86362001)(110136005)(6506007)(38070700005)(8676002)(66556008)(26005)(5660300002)(8936002)(4326008)(508600001)(2906002)(76116006)(66946007)(71200400001)(54906003)(7696005)(38100700002)(52536014)(55016003)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk9oZ1I3a01CQzdyVTlWOTRRd2JWM3lSNG5NT2U3cGd4Y1Vqb2NBaFZsUUZ5?=
 =?utf-8?B?cnREM1hDZ0dSbktMbWtsZmltV2VMRFRrWmYvNlBPMXNzeFcxK29meUNSNk1o?=
 =?utf-8?B?OU5mRXVQRXYra05LZklXUGp2NEozcVlGaC9xSS9SNVc2c3hlUGFZaGdzR2Jp?=
 =?utf-8?B?cTJBYUFYdEYzZitkclVEM2Q2VnA2Y2c2UVZMbkcyTmFrZElldno2eXNaVmx3?=
 =?utf-8?B?cUN5Z2M2OHVCWlBDQWdOVkl5T05VUzlXVmdtNGpyTFBuSHVFMU42WXJtVitK?=
 =?utf-8?B?cmovVUZNWmlpenByd2ptVVdiSGJtS2pxaEtzb1piTytoa1NQTzRTaVBaNXcx?=
 =?utf-8?B?Nlc0cEJkV2x0VzYxR0VzdEh0Z3laUEdMQ2JkWGFVdFpQOXBNVXAyL2lvMmNs?=
 =?utf-8?B?eVg1YUpLckthNEtpaHN4UHU1SjRkWGV0M01CZDZ6cmM3aHVqcDg2cFdkbUVG?=
 =?utf-8?B?UzZLdnFTMWFtTkRET20xS1V3MWU1anhTdVhXdFVyK01mWGJyZ2VkQS9HSWdr?=
 =?utf-8?B?RXJVclJrWVJmQ0poRHBrd1pMOWVVRExuWnZEdDVsb0oyT2VXRTdZdnVNZEJI?=
 =?utf-8?B?WmRwS2duYmJLT2NzYU5Fcm85RlZqU1haY1FTVGM5aG9TOUVjczZhUUozaGE3?=
 =?utf-8?B?NHo4S1gyQXJicW5OQk4wY2Jrcjg5MXJGdXRMU3pQQThDK0U4eDA5SytLRjVq?=
 =?utf-8?B?bzBJL24yNFpKclk5Qi8wRGJ5Z1NxRTA0Y2ZEcGQ4QmpqUjZ6VGFkeE54U0gw?=
 =?utf-8?B?TG9SSkt6OXRiL0djQUlubC9YOHV4cXdPNzdPbVlZUDM2YjJUejBEalVuOXg3?=
 =?utf-8?B?cDBsN2p4R0o0UEN1MWRhQnVTNkhaYTJ4Wlg5V24xRFJzcGlmZ0RMVTU2UTYz?=
 =?utf-8?B?QUNuQU1aVjUvTnFPYkdINllMWmRzRUppZXl6c3l5RjFVa25FR2dkQTRNYTlY?=
 =?utf-8?B?Qkg3eFJIOHB6WEJnd0VpNkp4ZU9iZC9IaHY5cWZYNENsTjFoOXZuNXVCa3VH?=
 =?utf-8?B?OFlzZGtET0o0clprYWRGT0ZZRGp0cnJZSnJLMjNrb2ZvYXR4KzRvWEJFNEFr?=
 =?utf-8?B?SDdsKzdkbUJ5V1Noemp0WDdEam5NR29SZUVMY2srVy9Va2dqMmNDZTdhRWI4?=
 =?utf-8?B?dmhhaU96Wk14MmZ5Vk5nc3o0a0Z5UzVuTldBUFJSV1haZUpmeDhTSVlNRmZI?=
 =?utf-8?B?a3U0OUd3cEFUM25ET2RKZnBkRzI0Y1ZzWVJ5T3A3cStWdEJBQ2JvOFBXSm1v?=
 =?utf-8?B?VU1FZWRZK2RCdUYzb0VSMFgzd1R5cjBpSWl6aFpwbEc4UjZGOXhmODkrNHZy?=
 =?utf-8?B?c1l2ZGphckRHRkJja09JNkJzcUxJMDVtdFVBN0hXVEV0MFRYdExucVQ2WlBl?=
 =?utf-8?B?WEE1Z2tDcWFuK29xR2pQRGpqV0VtcTM3SnVIL0pYRVc4cHNENTJCMUZidXJE?=
 =?utf-8?B?RVZSMG9ueStjbDZQQzZCemMvU0sxVVhzMStNcmU4UWgzcmZxY1FpOTU3Skp6?=
 =?utf-8?B?N2w3cmp4cEhlT2pRL0xxemR1V3ZiTG85cTg1OXZUMGlDSkN3aVp6VmpJQVNO?=
 =?utf-8?B?VWdrRkh6VFoxc2ZiQWZiaUY2YjdXWGpHYUxrbkhJV3k2Vzc3M1J0Wkk5dDdM?=
 =?utf-8?B?aEdzVnRHTDFzTEcxWDYzMHdJVU1OeVlHRkJxUndYNm0wOXljNDR0ZC8rUlhm?=
 =?utf-8?B?bzZlQ1NXVC9sZXFnZTh4bU1NV1NRNmFYOE8yUHEvYnBmczlTaG9IY0crZElN?=
 =?utf-8?B?anllL1cxSmN5bHAwKzFMeVltRVF2Vi9RNHpiMjN4dUR0TVRzWU9kQjdzWE9t?=
 =?utf-8?B?WnA0Vkg4QktFUjFWNiswVVpjSU5RWFRZaG52U0NrdDYzcDd2Rk85MWNBMEZi?=
 =?utf-8?B?ZndZWmIveld3cnFOZk9tZlR2VlBBVTB5eGJaMnlzdng1WGhjVmJxV0xjTWNY?=
 =?utf-8?B?NmcvdGZZNDBZT0xMQ3JNYlpybzBnWXpCNS9tVXhoM3FrY2p0eWI4WUVxODJR?=
 =?utf-8?B?RXRTY0RCZ0xCaHpMeWRpSXJHR0QzNklqVkZaeXp3UU5WQlpaNkk3WnIxWjdH?=
 =?utf-8?B?bDFmU1NHNXVsR2FrZlNZVGlrTG5VYlZrMGhxaW5SN2RjbXRUSDZGaVpXRUkw?=
 =?utf-8?B?eFBMT2RWRXN3MzdLdmpNekovb2JYRVlvdW9jNndZdndNanJaVlRUcnFjYWNO?=
 =?utf-8?Q?WSYgd1dpuaoubTVgHBLREn0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0419c4c-7b74-4de7-59dc-08d9d4d753cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 07:52:33.5872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDH+Ij4ISWffbit9ah5xu2SarwAKa2ISyQaqVcQ/fKLBHMXJbMe+Edbr4MGk90M1VVG6yWwKQRcNjJ1Vp+wIPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEgaXMgbm90IHNwZWNpZmljIHRvIE9MRUQgcGFu
ZWwuICBJdCBpcyBjYWxsZWQgZnJvbSBib290LXVwIHBhdGggYWxzby4NCkhlcnNlbiBXdSBpbnRy
b2R1Y2VkIGl0IGluIHJlc3VtZS1wYXRoIHdoaWxlIGVuYWJsaW5nIE9MRUQgcGFuZWwgZm9yIExp
bnV4IGluIGJlbG93IGNvbW1pdC4NCg0KU28gaGVyZSwgSSBndWFyZCBpdCBieSBjYWxsaW5nIHNv
dXJjZSBzcGVjaWZpYyBkYXRhIG9ubHkgZm9yIE9MRUQgcGFuZWwsIGFuZCBJIGNhbiBnZXQgYWR2
YW50YWdlIG9mIGFyb3VuZCAxMDBtcyBmb3Igbm9uLW9sZWQgcGFuZWwgZHVyaW5nIHJlc3VtZS4g
SGVyc2VuIG5pZ2h0IGhhdmUgYW5zd2VyIGFib3V0IHRoZSBpc3N1ZSByZWxhdGVkIHRvIHJlZ3Jl
c3Npb24gZm9yIG90aGVyIHBhbmVscywgd2FpdGluZyBmb3IgaGlzIHJlcGx5IGFib3V0IHRoaXMg
Y2hhbmdlLg0KDQpjb21taXQgOTY1NzdjZjgyYTEzMzE3MzJhNzExOTk1MjIzOTgxMjBjNjQ5ZjFj
Zg0KQXV0aG9yOiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1QGFtZC5jb20+DQpEYXRlOiAgIFR1ZSBK
YW4gMTQgMTU6Mzk6MDcgMjAyMCAtMDUwMA0KDQogICAgZHJtL2FtZC9kaXNwbGF5OiBsaW51eCBl
bmFibGUgb2xlZCBwYW5lbCBzdXBwb3J0IGRjIHBhcnQNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+
IA0KU2VudDogTW9uZGF5LCBKYW51YXJ5IDEwLCAyMDIyIDEwOjAzIFBNDQpUbzogTWFoYXBhdHJh
LCBSYWppYiA8UmFqaWIuTWFoYXBhdHJhQGFtZC5jb20+OyBXdSwgSGVyc2VuIDxoZXJzZW54cy53
dUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTLCBTaGlyaXNoIDxTaGlyaXNo
LlNAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogTm90IHRv
IGNhbGwgZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEgZHVyaW5nIHJlc3VtZS4NCg0KT24g
MjAyMi0wMS0xMCAwNDowNiwgUmFqaWIgTWFoYXBhdHJhIHdyb3RlOg0KPiBbV2h5XQ0KPiBEdXJp
bmcgcmVzdW1lIHBhdGgsIGRwY2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRhIGlzIHRha2luZyBl
eHRyYSB0aW1lIA0KPiB3aGVuIGNvcmVfbGlua193cml0ZV9kcGNkIGZhaWxzIG9uIERQX1NPVVJD
RV9PVUkrMHgwMyBhbmQgDQo+IERQX1NPVVJDRV9NSU5JTVVNX0hCTEFOS19TVVBQT1JURUQuIEhl
cmUsYXV4LT50cmFuc2ZlciBmYWlscyB3aXRoIA0KPiBtdWx0aXBsZSByZXRyaWVzIGFuZCBjb25z
dW1lIHNpZ2ZpY2FudGFtb3VudCB0aW1lIGR1cmluZw0KPiBTMGkzIHJlc3VtZS4NCj4gDQo+IFtI
b3ddDQo+IE5vdCB0byBjYWxsIGRwY2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRhIGR1cmluZyBy
ZXN1bWUgcGF0aCB3aGVuIA0KPiB0aGVyZSBpcyBubyBvbGVkIHBhbmVsIGNvbm5lY3RlZCBhbmQg
YWNoaWV2ZSBmYXN0ZXIgcmVzdW1lIGR1cmluZyANCj4gUzBpMy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFJhamliIE1haGFwYXRyYSA8cmFqaWIubWFoYXBhdHJhQGFtZC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgMyArKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+IGlu
ZGV4IGMwYmRjMjM3MDJjOC4uMDQwODZjMTk5ZGJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+IEBAIC04OTIsNyArODkyLDggQEAg
c3RhdGljIGJvb2wgZGNfbGlua19kZXRlY3RfaGVscGVyKHN0cnVjdCBkY19saW5rICpsaW5rLA0K
PiAgCQkoIWxpbmstPmRjLT5jb25maWcuYWxsb3dfZWRwX2hvdHBsdWdfZGV0ZWN0aW9uKSkgJiYN
Cj4gIAkJbGluay0+bG9jYWxfc2luaykgew0KPiAgCQkvLyBuZWVkIHRvIHJlLXdyaXRlIE9VSSBh
bmQgYnJpZ2h0bmVzcyBpbiByZXN1bWUgY2FzZQ0KPiAtCQlpZiAobGluay0+Y29ubmVjdG9yX3Np
Z25hbCA9PSBTSUdOQUxfVFlQRV9FRFApIHsNCj4gKwkJaWYgKGxpbmstPmNvbm5lY3Rvcl9zaWdu
YWwgPT0gU0lHTkFMX1RZUEVfRURQICYmDQo+ICsJCQkobGluay0+ZHBjZF9zaW5rX2V4dF9jYXBz
LmJpdHMub2xlZCA9PSAxKSkgew0KDQpJcyB0aGUgc291cmNlIHNwZWNpZmljIGRhdGEgb25seSB1
c2VkIGJ5IE9MRUQgcGFuZWxzPw0KDQpEbyB3ZSBrbm93IHRoYXQgdGhpcyB3b24ndCBsZWFkIHRv
IHJlZ3Jlc3Npb25zIHdpdGggYW55IGZlYXR1cmVzIG9uIG5vbi1PTEVEIHBhbmVscz8NCg0KSGFy
cnkNCg0KPiAgCQkJZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEobGluayk7DQo+ICAJCQlt
c2xlZXAocG9zdF9vdWlfZGVsYXkpOw0KPiAgCQkJZGNfbGlua19zZXRfZGVmYXVsdF9icmlnaHRu
ZXNzX2F1eChsaW5rKTsNCg0K
