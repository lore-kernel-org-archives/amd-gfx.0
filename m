Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD4C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 07:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB9F8BB4B;
	Mon, 22 Aug 2022 07:00:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E245910EAAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 07:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbDA1G0UwxUia/c5icKkpkN2pzdMSh5pHVBWme1/yuovlKntjJWhKS17xe+jJ7UB9imkpZfJ3JIXn70DC51T1PX1lil36BsUiXoczKxLjyGzZEc4aLw3d7mORkG6x8kmyuG8Ch674Ajq9nEC48W8Gj3zh5PJDtv7zBEgtFMNXR+8AGFKVOIW4INEjO5lC3pORxyS4qGRRIxUqyMM/OLeahqrApt7JyyxxtqS8whX6N2CeYhJrk8ApZGQLbu7lOc5bsvz6dpeYaGbUg07qKTBYYzFR67kLi/ON4g51mZv6nmlxEBRRD8qNF/NFr61XM9W/AX0AD5WaiFfWW+iZxLBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSjrwD5hNLPcgZtdzInzuAv+woiJycmdNmfzfWQs32c=;
 b=Ytz67JpDznCT2sX46TIstJgbvEDhIB4jaJDqZgSCF7EDG5EjSthiGo4FQmMMBXRl0q3IiccLCBhKnaAD5bVOSHSwgK6EWQeapSBy8WWBwCdUxfq9GaTqGIxvuJQiIovKus9lFh1PfwVdsfTNtCaC314FBx2HgLUMD3oHwPU28V5LxDog3fzZYRoI9HsXsKI3eWl4Mj/ulPnP3LNRFn7HyFvdZv6XPQo6HRFnJSOyhS/V2tRhNeoZ0uxzFQhm2rvVJYh9+map2+pmx3zYDDtwErJJy/BSHEGkWyoiZqnQE01MqIzP67Reb7MqoMkQf9mk6Kpmk7U3kE7Ws4ulg0JCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSjrwD5hNLPcgZtdzInzuAv+woiJycmdNmfzfWQs32c=;
 b=nVrq/76bWeOh3X/OU2m+1KZW0/7go6Qo6kKTV+JljpPZFAZT9dhdpRp93wikIRAX9OmHBKhwjPwNDmidEh4FksPSbR2hOzgXZuAKpjbK6ko/5K4ApBieoh+eCCajhAAsw/kG3y4tITwieEEFLit/awz8QozB3BCkfdTYhtszRHU=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 07:00:42 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%4]) with mapi id 15.20.5504.028; Mon, 22 Aug 2022
 07:00:42 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add sdma instance check for gfx11 CGCG
Thread-Topic: [PATCH] drm/amdgpu: add sdma instance check for gfx11 CGCG
Thread-Index: AQHYtfGuXSKDR0ltKkevX/oebcyGdq26fS7c
Date: Mon, 22 Aug 2022 07:00:42 +0000
Message-ID: <CY5PR12MB6369B0D3D8FFB6BD0110D1F3C1719@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220822063641.67974-1-tim.huang@amd.com>
In-Reply-To: <20220822063641.67974-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-22T06:58:07.9926955Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81986f62-30f6-4a79-1f5b-08da840c0763
x-ms-traffictypediagnostic: BN9PR12MB5244:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXZ48m85PuKFt68LnKwk66qAlmhrijNHwmrIX16M+l48OQcHMlAIs7v4n701Hnbb5N8SF//bUo/1nKprxr/VvIO6w3FdRYhqtQLfvEDxohExurWPMhegfVYWIcmLUZ76gM4nm4XVY+BvS9bDS1Cexkj/n1r376zBDoUgYQYPa9vMj8FLwXWea+4Wb4YK1yh4Xaspg81Z9MyyeHlrNMCMjUDtvi3/DqNm9kM3Yq+3uELMcPsI7flMfQmInP3VY+MPkthjZ/OIOX5dCeyXr4w62kncUXkf2IvCZ+2vJ67uIP3ZnFfPA6ICmMJXVe54wHGc8dDSA6Q5vRik2rZ0eFI2I8v+IpLCplJcdEkT20zUPwO9QDBykcMU1BTlOAUh5ugpEcdaa1cwHS7u4rGinBi+yradXCZIehtveigUbDaXS9CjALrDKIBDXR3UVH5o464RTMKi9MnqfW2zh46rF+o3Bz1KGSFIO04ygfQviQiDMDnCheRK0w1YK2VF+7np66brvgrwgFJO6dPWSovioHoDWBYVqExw7DSnexPA7hdbvesoeP+Gx1p69skIYrGo5BrgLXahq5e6du+ScVq+TfLkdweHzgeUiqfJjMcFzbwnGzPmmlsKn19/1APdFadZMsr8uT6KNTjlcOSLakRCMNcNOEQ3SDpBy3C8wx4rysU4JMqIveTMjB7qcT13w6L0DX9jlWwW1+91yJFqbpCD1ROchnEdXWKwj0QmjvBS9dsBAMOJEVq20d7a/MSGyPGCT9iRQjMVt8/2Omi0fUWX6pSjqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(55016003)(38100700002)(83380400001)(38070700005)(64756008)(66476007)(66446008)(66556008)(76116006)(91956017)(54906003)(71200400001)(110136005)(316002)(4326008)(66946007)(8676002)(9686003)(33656002)(2906002)(7696005)(6506007)(5660300002)(86362001)(186003)(41300700001)(478600001)(52536014)(122000001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cnZBQlNnSWFZM004dlRQTk9FU0g3R2U3VjFJRGRDVWdrdHMxODdnaktVZUEz?=
 =?gb2312?B?OGh1NDRXWVViMHRPMmRnV0ZWMlZKbHM0cUZnditRd2I2WEhvYzVtM0xQSHJk?=
 =?gb2312?B?d0RPNXBWa3dWbkZSampsVVR0NnZxYjRoQWE1cEUxVG54M2dWd01JOUtXODVt?=
 =?gb2312?B?QXVXQlVlSk5IVVFKRGdpRmdDSytjWnZkenVyMnVkNzFVL2dMODhZVmJtN1RY?=
 =?gb2312?B?bjAwTjRuc2JUZWgzZUxnd1NtUjVWMzlucEpBVGF1NHJmdGNVYTNSN1RMMCtq?=
 =?gb2312?B?MlFqUzcrcnZzZ2J0bzVOa0J6b3ZxYjBlMVFJdDlyWEs2eVBkc0VVSlBvU1Yx?=
 =?gb2312?B?R2phZVp2SktpT3p2YXViOXQ5SnlzNHVFa281MDRqTEZ3STh1dXZTNXkzNjdV?=
 =?gb2312?B?RVl2Z3Zvdm1WaFU3NjUxVCtPUldGWEROeVZwY0hYT2l0MXpMRVJrRVBwcEVT?=
 =?gb2312?B?MkxHa1NLaEJZcVFzVFR5cmJackJvMGhkMFpSRzVUcVljbTVxU2V3UzAzRXRU?=
 =?gb2312?B?aGhIRlI5R2w1Umk5bGJuZ2hJQ21WSit5b3pwc2RabjB2RWEzemhNeG1udURk?=
 =?gb2312?B?bnN2UnpYWmZDQjZuYWVELzQxU2FzR0xQcEVabUhGc0Y4RzhTUmFlNmhFS0cy?=
 =?gb2312?B?QmNncGJXRkRIZTBSQlJpUHFMVWZ2QnJtYUo2VWF3YyszdXBUeThvWGp4T2hW?=
 =?gb2312?B?UlpGME9jVDRGVkIvc2hNZ0hmUDJieHdkbUJqbmZwTS9mWms0NkFpTHVmd1A0?=
 =?gb2312?B?SndDOXc2cUZRTmxSazdVVG5GLzhHbkVUMFdZaDl4WFlkbk9GTnZvZU8xQW5X?=
 =?gb2312?B?N2VEMTR2UHUxdVltU0dsN1VWQ2tYNkVWQmxQdkVuSEVUTHcvQjNXQ2JWekho?=
 =?gb2312?B?dTVRYzFZMVA5M3VIeEZnSFgrbzhaN3NSNGJiQ0FvWUZVYUM1SzFHSGtldjNz?=
 =?gb2312?B?SXBLYWdWRWI4R05mSVB4U0xiRm0vZEpJVFVuY2RDWHlNa2k2YjVBNk9pbnhj?=
 =?gb2312?B?Sm9aOXpxVUcrd3pLNzRCZXNuMzlUUmJBS2hRbDNSUlR3WVQxaDFUTXQzdGRv?=
 =?gb2312?B?VjVLQk5pL2Y2TFRlNEZpU3BRQXdEVVVFTVFpWTlHcGwrUWxvUlEyNEtwY2Vt?=
 =?gb2312?B?cU1hSEVWUytyc3I0ZDFHbTJHSkEzSjJidE9iMEhJVFp1cll6L2FSYVBCeXNI?=
 =?gb2312?B?Q2dpenlmV1c5dUhzNXRkekRVOXdwaStscVZvOFMyZWJ5YXFNZmNxS1BaeUNI?=
 =?gb2312?B?U1EzMlhsNGtOV1BhVzc5czhia2UxTGFqa1N1WkJ6Y0NaN2hweEtSbkc2aWlm?=
 =?gb2312?B?SWgvcWwySmpTQnlZM2lhYjF1R09JOWsvWkZTbFJOdlJsYWZqdkQzd0NGNXgw?=
 =?gb2312?B?bUZVL2l1dzAvdEFJLzZ4Zi94ZUpyQTNNL2twNzB3QlN5U083aGp0VU9vQU5x?=
 =?gb2312?B?d2EyOTB3b2FHbXdxMGkxWitJQnV6MFd1bVlhcFVWYXJpeStqUnYvd2FrRDdn?=
 =?gb2312?B?R0x3b3BTTXFtYXdoeHl0Ynh3dEgxYlJ4a0doQ1hIeW5qNEFlRVZWbVFkQlVP?=
 =?gb2312?B?cjZsUXo4VHNhTWI5L3ZVWWpIYjFsUjR5WDV3VEtEY2xUNXJCaXVkUHkrcUJp?=
 =?gb2312?B?RHB0WHg3ZnltdGN3Q3ovRWovY1hZWFV3U2pOZit6Y1l3cG5XOE5rb1lUSFd2?=
 =?gb2312?B?djJ2a0YwSmxiRExZL01TamUrbkFoNHJCS0VQQ21LQ3dsa01rc2MxdUNQK3FQ?=
 =?gb2312?B?aVpBOFNxS2ZzTit0c3JBcnM1ZS9kY1FlUFV4dVdPakd4Y1BCM01ZQm9ycG16?=
 =?gb2312?B?V0hRQm1UZGI3SmVXRS9ZSExvbGNaM3JYckkraGladUxuUXZLckFCcXcwbDNZ?=
 =?gb2312?B?OERESE9pK0dtQkljMHhsVXBCdmRmQkVlajdvc1pQVll3Rzd1R2JnbG9TTk4y?=
 =?gb2312?B?bWY1S0cvZzFyd2NZa1YzZHJkMElQakQ0c1BvY3hwWTFCTlVVRjNlMjhMenlX?=
 =?gb2312?B?TExjajlEdGFsa2g5OG5tZitYQXZIcnl5QUtjSE5ERDdNa0lYQVZTV3RyaVcx?=
 =?gb2312?B?WERabXl4OHZRZ2tuQVlMb3kxZVRmZVJoaDVKdlBmRDYyK0pmSm9wa25Wb2xV?=
 =?gb2312?B?WXp2VEM3aXJQU1kySDg3dC9HS3lVaTRnYjRVTGZ0a3BvTG1hTTkzYUFLbE0r?=
 =?gb2312?Q?PmVhAETu4WkCnLmYRwhYw5RueVhaa4PFXo39ObY+A+iR?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369B0D3D8FFB6BD0110D1F3C1719CY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81986f62-30f6-4a79-1f5b-08da840c0763
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 07:00:42.4600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOpJQmza6/+oPUj0XkR5AlSFD6SQON4QBlIJqYNbQo0Jgs+WC00gX/eVER1ZcaXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Wenhui.Sheng@amd.com" <Wenhui.Sheng@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369B0D3D8FFB6BD0110D1F3C1719CY5PR12MB6369namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgc2VyaWVzIGlzOg0KDQpS
ZXZpZXdlZC1ieTogWWlmYW4gWmhhbmcNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCreivP7IyzogSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+DQq3osvNyrG85DogTW9u
ZGF5LCBBdWd1c3QgMjIsIDIwMjIgMjozNjo0MSBQTQ0KytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQqzrcvNOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgWWlmYW4g
PFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFdlbmh1aS5TaGVuZ0Bh
bWQuY29tIDxXZW5odWkuU2hlbmdAYW1kLmNvbT47IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQu
Y29tPg0K1vfM4jogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgc2RtYSBpbnN0YW5jZSBjaGVjayBm
b3IgZ2Z4MTEgQ0dDRw0KDQpGb3Igc29tZSBBU0lDcywgbGlrZSBHRlggSVAgdjExLjAuMSwgb25s
eSBoYXZlIG9uZSBTRE1BIGluc3RhbmNlLA0Kc28gbm90IG5lZWQgdG8gY29uZmlndXJlIFNETUEx
X1JMQ19DR0NHX0NUUkwgZm9yIHRoaXMgY2FzZS4NCg0KU2lnbmVkLW9mZi1ieTogVGltIEh1YW5n
IDx0aW0uaHVhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTFfMC5jIHwgMTggKysrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTFfMC5jDQppbmRleCBmNDVkYjgwODEwZmEuLmU4ZGI3NzJlMDY4YyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KQEAgLTUxODIsOSArNTE4MiwxMiBAQCBzdGF0
aWMgdm9pZCBnZnhfdjExXzBfdXBkYXRlX2NvYXJzZV9ncmFpbl9jbG9ja19nYXRpbmcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZQ0KICAgICAgICAgICAgICAgICBkYXRhID0gUkVHX1NFVF9GSUVM
RChkYXRhLCBTRE1BMF9STENfQ0dDR19DVFJMLCBDR0NHX0lOVF9FTkFCTEUsIDEpOw0KICAgICAg
ICAgICAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ1NETUEwX1JMQ19DR0NHX0NUUkwsIGRh
dGEpOw0KDQotICAgICAgICAgICAgICAgZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgcmVnU0RN
QTFfUkxDX0NHQ0dfQ1RSTCk7DQotICAgICAgICAgICAgICAgZGF0YSA9IFJFR19TRVRfRklFTEQo
ZGF0YSwgU0RNQTFfUkxDX0NHQ0dfQ1RSTCwgQ0dDR19JTlRfRU5BQkxFLCAxKTsNCi0gICAgICAg
ICAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ1NETUExX1JMQ19DR0NHX0NUUkwsIGRhdGEp
Ow0KKyAgICAgICAgICAgICAgIC8qIFNvbWUgQVNJQ3Mgb25seSBoYXZlIG9uZSBTRE1BIGluc3Rh
bmNlLCBub3QgbmVlZCB0byBjb25maWd1cmUgU0RNQTEgKi8NCisgICAgICAgICAgICAgICBpZiAo
YWRldi0+c2RtYS5udW1faW5zdGFuY2VzID4gMSkgew0KKyAgICAgICAgICAgICAgICAgICAgICAg
ZGF0YSA9IFJSRUczMl9TT0MxNShHQywgMCwgcmVnU0RNQTFfUkxDX0NHQ0dfQ1RSTCk7DQorICAg
ICAgICAgICAgICAgICAgICAgICBkYXRhID0gUkVHX1NFVF9GSUVMRChkYXRhLCBTRE1BMV9STENf
Q0dDR19DVFJMLCBDR0NHX0lOVF9FTkFCTEUsIDEpOw0KKyAgICAgICAgICAgICAgICAgICAgICAg
V1JFRzMyX1NPQzE1KEdDLCAwLCByZWdTRE1BMV9STENfQ0dDR19DVFJMLCBkYXRhKTsNCisgICAg
ICAgICAgICAgICB9DQogICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgICAvKiBQcm9n
cmFtIFJMQ19DR0NHX0NHTFNfQ1RSTCAqLw0KICAgICAgICAgICAgICAgICBkZWYgPSBkYXRhID0g
UlJFRzMyX1NPQzE1KEdDLCAwLCByZWdSTENfQ0dDR19DR0xTX0NUUkwpOw0KQEAgLTUyMTMsOSAr
NTIxNiwxMiBAQCBzdGF0aWMgdm9pZCBnZnhfdjExXzBfdXBkYXRlX2NvYXJzZV9ncmFpbl9jbG9j
a19nYXRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZQ0KICAgICAgICAgICAgICAgICBkYXRh
ICY9IH5TRE1BMF9STENfQ0dDR19DVFJMX19DR0NHX0lOVF9FTkFCTEVfTUFTSzsNCiAgICAgICAg
ICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdTRE1BMF9STENfQ0dDR19DVFJMLCBkYXRh
KTsNCg0KLSAgICAgICAgICAgICAgIGRhdGEgPSBSUkVHMzJfU09DMTUoR0MsIDAsIHJlZ1NETUEx
X1JMQ19DR0NHX0NUUkwpOw0KLSAgICAgICAgICAgICAgIGRhdGEgJj0gflNETUExX1JMQ19DR0NH
X0NUUkxfX0NHQ0dfSU5UX0VOQUJMRV9NQVNLOw0KLSAgICAgICAgICAgICAgIFdSRUczMl9TT0Mx
NShHQywgMCwgcmVnU0RNQTFfUkxDX0NHQ0dfQ1RSTCwgZGF0YSk7DQorICAgICAgICAgICAgICAg
LyogU29tZSBBU0lDcyBvbmx5IGhhdmUgb25lIFNETUEgaW5zdGFuY2UsIG5vdCBuZWVkIHRvIGNv
bmZpZ3VyZSBTRE1BMSAqLw0KKyAgICAgICAgICAgICAgIGlmIChhZGV2LT5zZG1hLm51bV9pbnN0
YW5jZXMgPiAxKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBkYXRhID0gUlJFRzMyX1NPQzE1
KEdDLCAwLCByZWdTRE1BMV9STENfQ0dDR19DVFJMKTsNCisgICAgICAgICAgICAgICAgICAgICAg
IGRhdGEgJj0gflNETUExX1JMQ19DR0NHX0NUUkxfX0NHQ0dfSU5UX0VOQUJMRV9NQVNLOw0KKyAg
ICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX1NPQzE1KEdDLCAwLCByZWdTRE1BMV9STENfQ0dD
R19DVFJMLCBkYXRhKTsNCisgICAgICAgICAgICAgICB9DQogICAgICAgICB9DQogfQ0KDQotLQ0K
Mi4yNS4xDQoNCg==

--_000_CY5PR12MB6369B0D3D8FFB6BD0110D1F3C1719CY5PR12MB6369namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr"><span style=3D"color:rgb(33,33,33); font-size:14.67px; lin=
e-height:1.5">This series is:</span><br style=3D"color:rgb(33,33,33)">
<br style=3D"color:rgb(33,33,33)">
<span style=3D"color:rgb(33,33,33); font-size:14.67px; line-height:1.5">Rev=
iewed-by: Yifan Zhang<span id=3D"ms-outlook-ios-cursor"></span></span><br>
</div>
</div>
<div dir=3D"ltr" id=3D"ms-outlook-mobile-signature">
<div dir=3D"ltr"><br>
</div>
</div>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Huang, =
Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Monday, August 22, 2022 2:36:41 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd=
.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wenhui.Sheng@amd.co=
m &lt;Wenhui.Sheng@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: add sdma instance check for gfx11 =
CGCG</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">For some ASICs, like GFX IP v11.0.1, only have one=
 SDMA instance,<br>
so not need to configure SDMA1_RLC_CGCG_CTRL for this case.<br>
<br>
Signed-off-by: Tim Huang &lt;tim.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++------<br>
&nbsp;1 file changed, 12 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index f45db80810fa..e8db772e068c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -5182,9 +5182,12 @@ static void gfx_v11_0_update_coarse_grain_clock_gati=
ng(struct amdgpu_device *ade<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SDMA0_RLC_CGCG_CTRL, CGC=
G_INT_ENABLE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABL=
E, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Some ASICs only have one SDMA instance, not need to configure=
 SDMA1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;sdma.num_instances &gt; 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_=
SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET=
_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, regSDMA1_RLC_CGCG_CTRL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Program RLC_CGCG_CGLS_CTRL */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS=
_CTRL);<br>
@@ -5213,9 +5216,12 @@ static void gfx_v11_0_update_coarse_grain_clock_gati=
ng(struct amdgpu_device *ade<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~SDMA0_RLC_CGCG_CTRL__CGCG_INT_ENABLE_M=
ASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data =3D RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data &amp;=3D ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Some ASICs only have one SDMA instance, not need to configure=
 SDMA1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;sdma.num_instances &gt; 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_=
SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~S=
DMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC,=
 0, regSDMA1_RLC_CGCG_CTRL, data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY5PR12MB6369B0D3D8FFB6BD0110D1F3C1719CY5PR12MB6369namp_--
