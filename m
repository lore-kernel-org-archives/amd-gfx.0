Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41977C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C559510F87A;
	Wed, 11 May 2022 08:42:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF4710F87A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLN2rbNUtis+Ykym78u6YAEobyCvMdS61s2yqs8DGT+HvrxAXwDiOmR8ETz9IMVFHwC6D5Ki9pxJeFxgabwpoqNBpXPsfuxNlFXGHrfKHkQudcpmKP2/IcWfH7ftKfUmVXqeD5kthz2/+QMzk77OrE2VA10nDGmqp9JSHOY1YwskQAwiHV15JiFKs9vulsTemCW9oUdy78o/0XfkI0/CI3qj84mJ35yLXxzLMNmWsp7N05qALKUxke3fbEPFNB97Wpa9cOogXn7uCQ/DIR/Zre6OE+B/1kDnddcVeU63QtprsRrV7nssogGlf6/Mg0KaAD1qtL3H6+NYtMkBblf8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE4SgQAUdQF91WsypW+l+offBmkMelKlISPZQlSI14E=;
 b=KTBnejFl8mT9LFR+0ppjIMuFB3P88RTNHgCNfijyrF1cTS8zEqiw0rJ1WMCjnaqCVWRZqz+uIXrai6jQbRWkPXuJJWiRj/a0IFI1VDeckMvvFplyK1vaWRwL01CGFnulmIqlBy85ShN/biS6dtTo6+GuVoFPZ1Pv6Jr82GLhSWR0lUcy/IC5fpbKOdb2B6cZ1j8nFT6aXMnJPxmLUyP0EtkPJiByQHgXQBaFddI8TDn7Y9nBY/h+sTn3BTCKwypxZgBzKM0P56LlXhK5XsUUaDOUFYek3A6R1SloxiJUDvpCf+CX1eRMvDYAl4fbzyepEK73t73660nJuIR3b+n8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE4SgQAUdQF91WsypW+l+offBmkMelKlISPZQlSI14E=;
 b=FllxGBd7zolQQNapTSQmj0eGU+POklmBnjPf/vnvVOf8OT6rP1swALBdb5Gtlu/uSXFIhrEZ/43uTjZBhjP9YyaXnpr1N5I8lMOx2C4rKocBQxvWdJh9qg4Iyy9uYkukPcEK/C3+m1S9e4gPso5/dDSMTde4yCo7j0KWs65jioI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 08:42:26 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9c68:a1fd:1445:49ad%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:42:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBkcm0vYW1kL3BtOiBhZGQgc211IHBvd2VyX2xpbWl0?=
 =?gb2312?B?IGNhbGxiYWNrIGZvciBzbXVfdjEzXzBfNw==?=
Thread-Topic: [PATCH] drm/amd/pm: add smu power_limit callback for smu_v13_0_7
Thread-Index: AQHYZQT40ZONK5cdokK63mp0E8E7wq0ZW9ug
Date: Wed, 11 May 2022 08:42:26 +0000
Message-ID: <DM4PR12MB5165352C5D7E0F98C7839F048EC89@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220511070121.809540-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220511070121.809540-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-11T08:41:46.2449999Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a888f775-471a-4ed1-90e8-08da332a2d13
x-ms-traffictypediagnostic: DM6PR12MB4092:EE_
x-microsoft-antispam-prvs: <DM6PR12MB409214290324EED5080846338EC89@DM6PR12MB4092.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAU4KQhL55NSKP9f4FIOjBk9QDdVE8/6wtGCnz9IIBwixvwbiTTShHoFCvKUcyer8VuHDtxn2he6Edc6a20ittSk43DAhtuovmBsnDoFHu0ycGEzinbA0D7TQ4VieWN2zSRMk4P8sJtiXlRRi4+2HTiMiZHateVjRGnyOFWMcQPdyMkJc5pU7ZkHgNlPgJx0iEuNqkqcY0JywsgGx2HziowzIp+q1rSChv0eLRB7y3Xof5Uj/5oPgGD1Vz5ZAXotp6yG0gMRXD0sszLC1zAYSFu86JTYCy/sMETg5mt8Oiir0dfZJwKkScTZepgzQK3ByDWzvkzzvFFFK3q88BARIPeWKfMGMSLW/03i/0dVoD+yxV76RfSAHHEsQUKkFd9pnsR/4/rPA1DATiL0PiDQqtiJmoC7zNvvywp4Vu5sUnWRuG0tTKAd0fGcrmCZHWJNR4+7J5kqXfSKs0hM/0zrq2+C+G8AHpR24uDrPUg4s9+ipCuRkUbUjR71CN2KBG+AJn+HkzUDISxUqPoYOScsxbqT5CkGfwbMX6Zhf4/+RRNyx6czY272tjVLJLyPB8l1BQYUce6JkRlEgpnn43w9PwVbcIvdOaPOCGiz7duQ5SXIEo08X/t62bq7fb9d8uZT/FyShMwu5dD/Vf1vFS1aXv80CasCANINMxiglCZtxiGKbNDX5WIC4IrPe2WnhMa+idhoUe7BzYy/PJy+wCubzoKfEHnbRi5vEAoF+Ic4PMpTZsSxHeKmdJ1+TB6Kystg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(55016003)(9686003)(122000001)(26005)(66446008)(4326008)(224303003)(64756008)(186003)(76116006)(91956017)(316002)(110136005)(66946007)(66476007)(66556008)(5660300002)(2906002)(71200400001)(6506007)(86362001)(508600001)(7696005)(8936002)(33656002)(52536014)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z0JaUEZUU1FSN3N1VDJ1OEgxcUN6UmJ2YnJoREltY1ZsL1RwNDRJcEZDWGdX?=
 =?gb2312?B?VWE1Q1B1UVRZSVVhazFJaEpobzVNMFF6cTlHYVF2dWJsdmc1WENNcEZ4em83?=
 =?gb2312?B?aEVaNWlXbDh5cWk3d1FrcTJkTHBuNGp6VWgyeHRFemFKM2RPMHpuTEcxUEd6?=
 =?gb2312?B?SVFuY3Z3SnBSSkRWeWw3UllXNGc5MmJSMFhwRGtHRzFTcC8wUmRJTXVMUjBq?=
 =?gb2312?B?blovNnNMYm9vTmRtQk1nNGl4ekxpenhEc0lza1p0NE14dGZPakZieXlMVjMy?=
 =?gb2312?B?TytrTTNTbTBmcnhHYWh5dVMxb1F4L0c0cG9iekZLZUNGR0pvaGQveXlVbElF?=
 =?gb2312?B?WEZ3anE2aHdIOExXNjQ0VVpvaS9NLy9uOU9YUTRMbWs3eXJablprR3huOVBM?=
 =?gb2312?B?TWg3Q0ZOcHhxYkdvamdVenBFbUFQNlY2c0lLZzdGV3FsR0hDTVNsMjFad3Ns?=
 =?gb2312?B?a1hwdW5hZDZuNE9BRldqODlqQk9ERmxsNm9PcFkzMGVXdjFWSzVRR3RsL0l4?=
 =?gb2312?B?TnFNUjg1ZXRETWNTSjRKRndBUGZtODJUcytZWFNlL3Q5WG82dFNpcU5LS0hJ?=
 =?gb2312?B?MHcwaXI5YTg0L2hxdVVOS0ZabnkxQXFzMm05bWg5UWNlVXRYRGdSUm5JbE9a?=
 =?gb2312?B?c094bUl2S0lvVzZOb29SNFNPQTgwdytQWElnM3o3T08zRnVIWndGMkZBcFFK?=
 =?gb2312?B?NlZRUVpYOUVvM2syck0vSko4MUxWSHpWbTVXeUhPbGtyOW9RaWg3RkdKL3lE?=
 =?gb2312?B?L3B4YmJ6eERIVlJXTHJZa0toV2tIODE5MnVhR1BqaWdYbWFzOE4yWnBDcVpI?=
 =?gb2312?B?U3RqTTlzbEZ2WjFzbnZUT3c3amVuSFBUeHNLODJtUVFFaDdvdTNtSVE1N0Zv?=
 =?gb2312?B?L0wrb3F1SERtUnNueTN6dmM4UjNiTzA0eEJlbEFMZWVFdmpwb1JXK0owMHdP?=
 =?gb2312?B?QVhoNGQzK280OUg1eFhac3lIKzNERWNCQzhWY3drZXg4NHlVY3JLYlhRMEZD?=
 =?gb2312?B?Q1JMV3lMOTZ0UnRBYUZySmpZZmk1bVFWb29FQWZILzI3akdkMEkyWlZmTVk1?=
 =?gb2312?B?TTVzVCsxWUtEZkZZenBhcFVaU2Ryc1VFU0xiVW9BaFF2SUthSklZT05YYTZo?=
 =?gb2312?B?TUNLa3IwbkQ1akhSSGtHYVZhRDRaTm1WMUtqSGRXdnQ4SE41QklSYzRIMVRp?=
 =?gb2312?B?Z1kwUWR1RE9GbUp6bVNMeS9hRWNra2l3SlhDSnJ0c3R5Y1NMUHl4K3J1WFcr?=
 =?gb2312?B?WStHTEFKVkVuUUpOdmtwR0s5V3NkTFJaU1dUZWpRWUw3Rzl6M1Y4a2U3WklB?=
 =?gb2312?B?Y2x2VWtDc0llU3ozamw5M25DWlc5ZWh1eVZRSnJFSTN3UTd2UTF6ek9LdGJG?=
 =?gb2312?B?TGVXekpKdXFMbXNiS0oxSGV2Mk1xQVRWZnBYcnRic211ZmFBZ1UxM1pMTldh?=
 =?gb2312?B?L2svWWdqL3N5ZVdQSTVRTm9DVHMrSk1CSjhWNDF6ZVd5ZTQ2YWdEeGczUUlC?=
 =?gb2312?B?RjZDaFRnZmdZWXQ2dVVxb3FPMGhmVHFDRFdSRjlRUDhTcmJQbDNKVk9lKytM?=
 =?gb2312?B?enJUcXB2UGd4V2JnNFhQd1ZQcUM4MlJxMno5eGVzUjB4RUlBZmRMWlE5TUZx?=
 =?gb2312?B?b2F1WTVmZHl3ZUhGbVYrd3pRWGkyQmp1eEQ0SExQeGliMFNBWGJiTzNPNHQ3?=
 =?gb2312?B?ZG1SOFN1eFRHNU9UbTVONXp1SzBWdHpsU3l1bkgrcTY5V1pNQXpFZWdtR09T?=
 =?gb2312?B?ckZvWkRQcmtVc0ZmbThKWWRVb1FiZ2lWRllrSEJpa1Z1cFRQc0Roc3NXRzlm?=
 =?gb2312?B?UWRxZzlXNU9MS3B1WjdsdG5nRU1kZ3lKSGIrSExITnMwQU5pMTlpcXFpNDMw?=
 =?gb2312?B?TkpraytxVisyVHFkd2JiYzdYdllDUmNYZDJNZUp1K2Q0bEU1TVczTmx4YWxY?=
 =?gb2312?B?bmZRajh6UkNDSUVmT050c1pPZXJyYkxQUGUrTmk1YlhjWkJrOGVCQlVXMUcw?=
 =?gb2312?B?cno5RElQR3Y1Z1NER0F6a2gyOGVpOHA2SG1DcE0wc1A1VTZld01JVUdhWFBm?=
 =?gb2312?B?TFBmaFFkWWFiV0ZXekszSlE4ZmFVSnBJNTVHUzNtR0NNVlZyTXRjSGdsMy9p?=
 =?gb2312?B?bk5Ycm9QRnpwNlFhNk9XOEFmV2tydy96Ymw5Rk83TUZOU0dydUl1dDlRMkJj?=
 =?gb2312?B?QmFMOVllcnFNS0k4cyt3a0JkbklNbU5mYWxSQ214QlJwS0Q4ckNPNHBONVZo?=
 =?gb2312?B?OUhaVFdRQVBkZ0ZWWlpjWkxRRHI1L0tsKzlKS2UvWlJhNVBVTGRHVmhNUDNt?=
 =?gb2312?B?WXhQMVpTNm0rbm55V3h2NDVGUHc0VUVKZ1JickN0QXp6aklJaVlPZ0xYTWFv?=
 =?gb2312?Q?XQZRhJ1eUsLQVMUY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5165352C5D7E0F98C7839F048EC89DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a888f775-471a-4ed1-90e8-08da332a2d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:42:26.3934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFSlMKYbDAWXLx17MpM9O+nRfvwx7uX9IAYwkI+9eNUdJZl7+i18cHu6Bx+5VHWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5165352C5D7E0F98C7839F048EC89DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBLZW5uZXRo
IEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPG1haWx0bzprZW5uZXRoLmZlbmdAYW1kLmNvbT4+
DQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZlbmcNCg0KDQq3orz+yMs6IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+ILT6se0gWWFuZyBXYW5nIDxLZXZpbllh
bmcuV2FuZ0BhbWQuY29tPg0KyNXG2jog0MfG2sj9LCAyMDIyxOo11MIxMcjVIDE1OjAxDQrK1bz+
yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4NCrOty806IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
Pg0K1vfM4jogW1BBVENIXSBkcm0vYW1kL3BtOiBhZGQgc211IHBvd2VyX2xpbWl0IGNhbGxiYWNr
IGZvciBzbXVfdjEzXzBfNw0KW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0KDQotIGdldF9wb3dl
cl9saW1pdA0KLSBzZXRfcG93ZXJfbGltaXQNCg0KYWRkIGFib3ZlIGNhbGxiYWNrIGZ1bmN0aW9u
cyB0byBlbmFibGUgcG93ZXJfY2FwIGh3bW9uIG5vZGUuDQoNClNpZ25lZC1vZmYtYnk6IFlhbmcg
V2FuZyA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCi0tLQ0KIC4uLi9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jICB8IDM5ICsrKysrKysrKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCmluZGV4IDdjOWUwYmE3YWI1
MC4uNGUxODYxZmIyYzZhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KQEAgLTEzNjcsNiArMTM2Nyw0MyBAQCBzdGF0
aWMgaW50IHNtdV92MTNfMF83X2VuYWJsZV9tZ3B1X2Zhbl9ib29zdChzdHJ1Y3Qgc211X2NvbnRl
eHQgKnNtdSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TlVMTCk7DQogfQ0KDQorc3RhdGljIGludCBzbXVfdjEzXzBfN19nZXRfcG93ZXJfbGltaXQoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCAqY3VycmVudF9wb3dlcl9saW1pdCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpkZWZhdWx0X3Bvd2VyX2xpbWl0LA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKm1heF9wb3dlcl9saW1p
dCkNCit7DQorICAgICAgIHN0cnVjdCBzbXVfdGFibGVfY29udGV4dCAqdGFibGVfY29udGV4dCA9
ICZzbXUtPnNtdV90YWJsZTsNCisgICAgICAgc3RydWN0IHNtdV8xM18wXzdfcG93ZXJwbGF5X3Rh
YmxlICpwb3dlcnBsYXlfdGFibGUgPQ0KKyAgICAgICAgICAgICAgIChzdHJ1Y3Qgc211XzEzXzBf
N19wb3dlcnBsYXlfdGFibGUgKil0YWJsZV9jb250ZXh0LT5wb3dlcl9wbGF5X3RhYmxlOw0KKyAg
ICAgICBQUFRhYmxlX3QgKnBwdGFibGUgPSB0YWJsZV9jb250ZXh0LT5kcml2ZXJfcHB0YWJsZTsN
CisgICAgICAgU2t1VGFibGVfdCAqc2t1dGFibGUgPSAmcHB0YWJsZS0+U2t1VGFibGU7DQorICAg
ICAgIHVpbnQzMl90IHBvd2VyX2xpbWl0LCBvZF9wZXJjZW50Ow0KKw0KKyAgICAgICBpZiAoc211
X3YxM18wX2dldF9jdXJyZW50X3Bvd2VyX2xpbWl0KHNtdSwgJnBvd2VyX2xpbWl0KSkNCisgICAg
ICAgICAgICAgICBwb3dlcl9saW1pdCA9IHNtdS0+YWRldi0+cG0uYWNfcG93ZXIgPw0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2t1dGFibGUtPlNvY2tldFBvd2VyTGltaXRBY1tQUFRf
VEhST1RUTEVSX1BQVDBdIDoNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNrdXRhYmxl
LT5Tb2NrZXRQb3dlckxpbWl0RGNbUFBUX1RIUk9UVExFUl9QUFQwXTsNCisNCisgICAgICAgaWYg
KGN1cnJlbnRfcG93ZXJfbGltaXQpDQorICAgICAgICAgICAgICAgKmN1cnJlbnRfcG93ZXJfbGlt
aXQgPSBwb3dlcl9saW1pdDsNCisgICAgICAgaWYgKGRlZmF1bHRfcG93ZXJfbGltaXQpDQorICAg
ICAgICAgICAgICAgKmRlZmF1bHRfcG93ZXJfbGltaXQgPSBwb3dlcl9saW1pdDsNCisNCisgICAg
ICAgaWYgKG1heF9wb3dlcl9saW1pdCkgew0KKyAgICAgICAgICAgICAgIGlmIChzbXUtPm9kX2Vu
YWJsZWQpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIG9kX3BlcmNlbnQgPSBsZTMyX3RvX2Nw
dShwb3dlcnBsYXlfdGFibGUtPm92ZXJkcml2ZV90YWJsZS5tYXhbU01VXzEzXzBfN19PRFNFVFRJ
TkdfUE9XRVJQRVJDRU5UQUdFXSk7DQorDQorICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJn
KHNtdS0+YWRldi0+ZGV2LCAiT0RTRVRUSU5HX1BPV0VSUEVSQ0VOVEFHRTogJWQgKGRlZmF1bHQ6
ICVkKVxuIiwgb2RfcGVyY2VudCwgcG93ZXJfbGltaXQpOw0KKw0KKyAgICAgICAgICAgICAgICAg
ICAgICAgcG93ZXJfbGltaXQgKj0gKDEwMCArIG9kX3BlcmNlbnQpOw0KKyAgICAgICAgICAgICAg
ICAgICAgICAgcG93ZXJfbGltaXQgLz0gMTAwOw0KKyAgICAgICAgICAgICAgIH0NCisgICAgICAg
ICAgICAgICAqbWF4X3Bvd2VyX2xpbWl0ID0gcG93ZXJfbGltaXQ7DQorICAgICAgIH0NCisNCisg
ICAgICAgcmV0dXJuIDA7DQorfQ0KKw0KIHN0YXRpYyBpbnQgc211X3YxM18wXzdfZ2V0X3Bvd2Vy
X3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgY2hhciAqYnVmKQ0KIHsNCiAg
ICAgICAgRHBtQWN0aXZpdHlNb25pdG9yQ29lZmZJbnRFeHRlcm5hbF90IGFjdGl2aXR5X21vbml0
b3JfZXh0ZXJuYWxbUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09VTlRdOw0KQEAgLTE1MzksNiArMTU3
Niw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyBzbXVfdjEzXzBfN19wcHRf
ZnVuY3MgPSB7DQogICAgICAgIC5nZXRfZmFuX2NvbnRyb2xfbW9kZSA9IHNtdV92MTNfMF9nZXRf
ZmFuX2NvbnRyb2xfbW9kZSwNCiAgICAgICAgLnNldF9mYW5fY29udHJvbF9tb2RlID0gc211X3Yx
M18wX3NldF9mYW5fY29udHJvbF9tb2RlLA0KICAgICAgICAuZW5hYmxlX21ncHVfZmFuX2Jvb3N0
ID0gc211X3YxM18wXzdfZW5hYmxlX21ncHVfZmFuX2Jvb3N0LA0KKyAgICAgICAuZ2V0X3Bvd2Vy
X2xpbWl0ID0gc211X3YxM18wXzdfZ2V0X3Bvd2VyX2xpbWl0LA0KKyAgICAgICAuc2V0X3Bvd2Vy
X2xpbWl0ID0gc211X3YxM18wX3NldF9wb3dlcl9saW1pdCwNCiAgICAgICAgLmdldF9wb3dlcl9w
cm9maWxlX21vZGUgPSBzbXVfdjEzXzBfN19nZXRfcG93ZXJfcHJvZmlsZV9tb2RlLA0KICAgICAg
ICAuc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZSA9IHNtdV92MTNfMF83X3NldF9wb3dlcl9wcm9maWxl
X21vZGUsDQogICAgICAgIC5zZXRfdG9vbF90YWJsZV9sb2NhdGlvbiA9IHNtdV92MTNfMF9zZXRf
dG9vbF90YWJsZV9sb2NhdGlvbiwNCi0tDQoyLjI1LjENCg==

--_000_DM4PR12MB5165352C5D7E0F98C7839F048EC89DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
span.searchhighlight
	{mso-style-name:searchhighlight;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span class=3D"searchhighlight"><span lang=3D"EN-US"=
 style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;co=
lor:#070706;background:#FFEE94">Reviewed-by</span></span><span lang=3D"EN-U=
S" style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;=
color:black">:
 Kenneth Feng &lt;</span><span lang=3D"EN-US" style=3D"color:black"><a href=
=3D"mailto:kenneth.feng@amd.com" title=3D"mailto:kenneth.feng@amd.com"><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;c=
olor:#0078D4">kenneth.feng@amd.com</span></a></span><span lang=3D"EN-US" st=
yle=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;,serif;color=
:black">&gt;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> amd-gfx
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; </span><span style=3D"color:=
black">=B4=FA=B1=ED</span><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;color:black"> Yang Wang &lt;KevinYang.Wang@amd.com&=
gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">11</span><span style=3D"color=
:black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">
 15:01<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lis=
ts.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<b=
r>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> [PATCH] drm/amd/pm: add smu power_limit callback
 for smu_v13_0_7<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt">[CAUTION: External Email]<br>
<br>
- get_power_limit<br>
- set_power_limit<br>
<br>
add above callback functions to enable power_cap hwmon node.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c&nbsp; | 39 +++++++++++++=
++++++<br>
&nbsp;1 file changed, 39 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 7c9e0ba7ab50..4e1861fb2c6a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1367,6 +1367,43 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct =
smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;}<br>
<br>
+static int smu_v13_0_7_get_power_limit(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t *current_power_limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t *default_power_limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int32_t *max_power_limit)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_conte=
xt =3D &amp;smu-&gt;smu_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_7_powerplay_table *po=
werplay_table =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct smu_13_0_7_powerplay_table *)table_context-&gt;power_pla=
y_table;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D table_context-=
&gt;driver_pptable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SkuTable_t *skutable =3D &amp;pptable=
-&gt;SkuTable;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_limit, od_percent;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_v13_0_get_current_power_limit=
(smu, &amp;power_limit))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; power_limit =3D smu-&gt;adev-&gt;pm.ac_power ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; skutable-&gt;SocketPowerLimitAc[PPT_THROTTLER_PPT0] :<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; skutable-&gt;SocketPowerLimitDc[PPT_THROTTLER_PPT0];<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (current_power_limit)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *current_power_limit =3D power_limit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (default_power_limit)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *default_power_limit =3D power_limit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_power_limit) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (smu-&gt;od_enabled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_percent =3D l=
e32_to_cpu(powerplay_table-&gt;overdrive_table.max[SMU_13_0_7_ODSETTING_POW=
ERPERCENTAGE]);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;=
adev-&gt;dev, &quot;ODSETTING_POWERPERCENTAGE: %d (default: %d)\n&quot;, od=
_percent, power_limit);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; power_limit *=3D=
 (100 + od_percent);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; power_limit /=3D=
 100;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *max_power_limit =3D power_limit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu=
, char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmActivityMonitorCoeffIntExtern=
al_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];<br>
@@ -1539,6 +1576,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode =3D smu_v1=
3_0_get_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D smu_v1=
3_0_set_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost =3D smu_v=
13_0_7_enable_mgpu_fan_boost,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit =3D smu_v13_0_7_get_=
power_limit,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D smu_v13_0_set_po=
wer_limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =3D smu_=
v13_0_7_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D smu_=
v13_0_7_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =3D smu=
_v13_0_set_tool_table_location,<br>
--<br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5165352C5D7E0F98C7839F048EC89DM4PR12MB5165namp_--
