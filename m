Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF96606A890
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ItmV82X7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA70510F48E;
	Mon, 16 Nov 2026 22:11:50 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B418F10E477
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 22:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5HmHht6sRadL1/569L8ulZ7P1xGaIPm9MHkGd8JDpc2dtXh0WjBJPi2WSDn2NtMEUSgsMSNKeBzJKZ3tdRsuiEB+UX+CCsuCEFQGVvu178KI8H6GjrFybuAdRLKVFWDLORkYtNtJQD6IXkvbTKu34JU9OXyqNOG7ju/nn8rflhT2+ClCBsHx5+SOxdJBwK5rRml7mGuXrz2twQaV7YjinbcV6Y8KiU6e+bmiicFhFxdeDXQJQGazL0vjJXeGgB2dF6knxBb7Fp1TW40AFYma8K4KnGvR1+1aL7mX82xLyBGQc8piZ0EYY6F8bQWjOu6Bd9o3E+AJf01IHZFk8zO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2c65H7QiYaxzWVn6GWjO5NwXuc2rQrV+UAMtE0irUk=;
 b=IHQx3271QrJ7hbbtZH4ux4ydRZPjfP+Ez4f8iJnY8SNqz3XzaXkdPo/R1nCi7K4AZ4bbAdiHSDg2zog6xdGTt+k2ufGofuMU4wY2DSAXU9LlaPCS1gSK0DoUmt0HpW1w6+uj8al2Le7Y8krqrv7tZdIi75vlPUbmhmkh6ZhC8qL897EdMQ7D75mTYBoMdEcPes+Lg1lSN/y2sCgGC3QhTPz9ufNsY0xm6/EfHxe01Va4F4GNictKLL8oMu4CTBs61iFyn3lrITO4qAPSY+TDbyFOL5JR1PwBUEE4zBFsp60nIVFJgdjbXYeZfM3oyJ0QfYP34PCvWkGb0jZKM1zxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2c65H7QiYaxzWVn6GWjO5NwXuc2rQrV+UAMtE0irUk=;
 b=ItmV82X7bGURumRa7u6Bp9JBGfvDhDPhBJKF8m4HvPFkM/KyHuX37mX3bSSEL/9gtnGWkhx7XjEzn/k7+/2ByclJ6x6gQZOssQV2WAXWgDJjfg5WQLCEZEBM7jcxk8MNwX0jOGXH8lCkmCvXJowa6p0LL5X3/t+DnQCeY7WU+uo=
Received: from SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 22:10:40 +0000
Received: from SA1PR12MB7152.namprd12.prod.outlook.com
 ([fe80::38d1:d01a:aed2:5052]) by SA1PR12MB7152.namprd12.prod.outlook.com
 ([fe80::38d1:d01a:aed2:5052%6]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 22:10:40 +0000
From: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Perez, Randy"
 <Randy.Perez@amd.com>, "Chiu, Michael" <Michael.Chiu@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
Thread-Topic: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3
Thread-Index: Ad1ziz2v3uv7wCayROSuZM3Cl7nD5QCUJEwAAACvY4AACQUVgAAACH4AAAUONvA=
Date: Mon, 16 Nov 2026 22:10:40 +0000
Message-ID: <SA1PR12MB71525D6082DCD47B7C7E4204F87C2@SA1PR12MB7152.namprd12.prod.outlook.com>
References: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
 <835ebb0f-126c-4d30-b5d9-14f1950da83b@amd.com>
 <385b0781-f3f1-4819-a027-d6e3f5532783@amd.com>
 <e32c1312-8823-4c01-8b31-c4385614141a@amd.com>
 <36ed0af8-d640-4b2a-9c57-7b39051945cb@amd.com>
In-Reply-To: <36ed0af8-d640-4b2a-9c57-7b39051945cb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T22:08:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7152:EE_|SJ2PR12MB8829:EE_
x-ms-office365-filtering-correlation-id: a862a6cc-9e12-445b-24dc-08df442e7377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|6049299003|1800799024|22082099003|18002099003|6133799003|4053099003|4143699003|11063799006|56012099006|261102123227099003|10067099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: Z6S0DnfU7HXJwNQDqAU8LpSzpjXRdGChI7KJZsoS8XYg2Ou9jEkZealnHKFQGi/b65kbDynfJclt/cUnZ3m4v7hKpIxNbSnzcLP6r53uSSYwf7heg0mVPabY34VRa3cwUOzpinRngfN/apfGJ9fz8LGYZgn+faoEp6YQCaSfNPtk7Nu/O7VCZFGeS+41Tn5nIv2efmLLlQ1iCcnAssXoGlQrJR0mZoc4m0bwbeh74EfzzgJnbXfv9/pk8CAXL0z/HYIukh3dIC5+djIxPEoB3yxd2MlH6D88ZBr3lrjUoRESAd9luO4lDSFbZLhIfWbdAtKztJMyK9AthDZZEUZ30i6jkm4slnIJxCIPeHp1L4cEsWZRJXO4dGGv4jQ1NJfXCVjNJLAho85Ff89FfiYkNnlUxz1CuxU7KfAkhY82WjZfuoI1wtJMwmjhhSa8NTGhd68RUvW44SHa4OJFOFsu1YNpIidltdpuPMchVb/WPbBjAVyaqWjkqGba6k+HI0RMUNORk9L06ZG/qyLMopm+U69MpIMAuLsjGAqHCrFF7bl+EYM+rkARBZlDOAdvc9V7MNVy798LLXnYZ/Ucbu2nLqAUByI9HREEWY6Yx5zpFhmIJJxl+cFwbcKOcoaUVDtHbVg6HyfvzSdxERlfGoou6YekEum7MOLcIANceSSwDKlE5Y0QFwP8oG0CpdJiU0IzfL9pvx/qQofY0EvJP28y4UpGbk687brZrsGTLJaps3g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(6049299003)(1800799024)(22082099003)(18002099003)(6133799003)(4053099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1FmSGlBRHlHbGgyeWFtdU9ucHZXT3J6Q2plRzZrL3lFSG1qa0w5N0l4Wnl0?=
 =?utf-8?B?OW11aWNvd1BTdXpnLy9pcy9ielAvbE1sTU1weDVSY1diN3ZiWGZHd0haSlZI?=
 =?utf-8?B?Z1ZJZk1TalF1d0lFeVVSS3lrWFl5YWlvTXo4SGl6S3p0WDRKRTlreU91TTBU?=
 =?utf-8?B?UkZseUNCT0hmNnpwOWlCR3VVUTJGb2pUSDhQOW5udXlEVk5OZ0tlQXljN3E4?=
 =?utf-8?B?YmJMakxCaXB1UWQ0cm9KdERCNHRxbmVLQVZNd205R3ZwcGd2amhrVUw0b0JF?=
 =?utf-8?B?MUQrWVlJMTNxT3NZbm8vL3JlNHN4MlI4ZnJOWnFtSUw5M3g5VkJOd3Z0QjF2?=
 =?utf-8?B?bWQ2NVhrdDdJY1dBRlpqMGxPN0MzRHdyZFhNR1MwY25HK1V3OVNnNlIvQ2VO?=
 =?utf-8?B?RVpSMVlHL25SM1lGZkQrVSs3WTRwMHJqMW1iaTREOHlzMlE4Q2xXdFNkMnR0?=
 =?utf-8?B?MmJoMStDUm1QdmY2RjhlZ1hHOUx2V2s5a2haL3QxcXNtVXozRmpIam1NbVp4?=
 =?utf-8?B?T0lKSVRjREZQekcrYXdEaE9mZWgyYUNHakErcE02dDEzdklON2w2QThSOUhK?=
 =?utf-8?B?cnNtSGdMSWdGbE01SUQ4Q014WVBFUGhHY1pvd3hLR1FQRGlyUWtNZWhZRW9z?=
 =?utf-8?B?eHhFUnNUZWtLV3I4T0M3a1BTQWF1Y1pRSU1OcVpkdzZYQzRsN0ZuU3pXNEZk?=
 =?utf-8?B?bWJWRkdHZDROUXRVZjJMam5Zb3AwTElrWFZSZk9sSStxRHlFWnhPempjTkNO?=
 =?utf-8?B?aGRWM252cnNsb3E0NUZwak9Mdi9SU29tN1B2MVFDQzJtNXlrZzliU2txN2Zv?=
 =?utf-8?B?WTk4N1lIOVNOSXloTWl5SldGSkIxY0hzNURReUxtaW8xM29SY0Z2RTc3SllS?=
 =?utf-8?B?dGY5SmlUeE9OWDVEZ1FMVWN1a09tTkFQV1dqSGRjNmw2dmQzT1RGbXZFSmJh?=
 =?utf-8?B?SmpjVmo3UHc5S1BDZW50SnpOdEl2emxLa1Q2VDRHbDBBUDI3VnZNSFB0S1VM?=
 =?utf-8?B?UkNXc1F6dDU1di95WUNHdTJ2NTljbHprOCtkKy9wekhYYzYrNE9QNHNMT1dt?=
 =?utf-8?B?UGd3ekNYY1ZlY1JjUzNnRVN5SDVFV3FUbGVPVHdqTkhjaTFaenMvTUFsdk5h?=
 =?utf-8?B?cGJTZ3R6ano0Zy9xN1AzZ2VTR2ZNVlR6QStCbE5PUTRkVlhVVXNBTGhYaHE0?=
 =?utf-8?B?Y1RKQXErVDlhVEtPWlpjejRqbWw1cGkzcDljSitJMnRXOGNoYXh3WVh6b0pi?=
 =?utf-8?B?WnRRSGpSbW9URFkxbU93eWVybEFERzFaSjk3YXFBMGU0dmVLQ2VIWkNVS09m?=
 =?utf-8?B?QkRNdmNpamdYaStyWThuakZhWjhLS0tkYVRtaG9GZ0VFSHV6Rld4QnhOUXRN?=
 =?utf-8?B?cmo4OFBqaEduZFVWM0g5REsvWHRJNHFaVnlkaGllTWFkK3NJSUZxeGRvczVp?=
 =?utf-8?B?TDlNT3FnNzJEYjJKV2JGZVd5NVRtVklHVjRiMVBWMHZvOTdJdkMrV3hDbllG?=
 =?utf-8?B?cGZEcVoyTkRsTTFaYUsrVGpZQURjMXFCU1lNUWhtNGJ6dUNJbmxiY3N2Q1N2?=
 =?utf-8?B?QkhIb0FHUkJYOTh4NThySGRwL2xxVXRwMXNGSzRuM0tJa3NraGNFTk5ia2Rs?=
 =?utf-8?B?bHhOS2RINk95enZrK2JWS0FNMzMvN2RPeVY4bmtNd3JIbzJwTzh6K0FHbFQx?=
 =?utf-8?B?NUZoaCs1RkM1UTJRZFVISHV4Zm5zcU9CUFdyTWpVNUxVdHo5Qmp1VE8xZHAr?=
 =?utf-8?B?cVdUVzF0czk3UmwxUkdmQWc5Um5pOTBiV2lqVFYvNzBSWmI3YjFaeC9IS0ln?=
 =?utf-8?B?M0wvbjVhMGkrVENua1NwTEFJUjFOd3lFV1dYTnZoZytyZVU1aU85dlpRYkRu?=
 =?utf-8?B?QjdHWGJhSm5xSHJ0dXMvUzVNRnV5TmV1UW5HNndOYlhRcysrQnZHbXJNZnJy?=
 =?utf-8?B?NWQ4dmcra0NMVGtMZm1hTGl0OGkzM1R5WEJCcVZyR2NqQnVnT1o1M3M5Z1JY?=
 =?utf-8?B?YVVhM1hpS09kUEd0aHA3QldNeFIrRnMxUTg2NHk2YjV2N2V4MHEvc1A3NHRk?=
 =?utf-8?B?RkdRRjlJOEhRekg4Y1ZBZVJrNWFtM0hUZ3FHSEJuOXNLc05nRmFVSk1tVEdj?=
 =?utf-8?B?enZQcTF5VDVGaE5na25BaHkwWjhVWkdjbU5aSUhZL3IzbTVlZmd1U09kWlZ6?=
 =?utf-8?B?ZTZtM0NRVXQ4WldFOFR3aSs0Sys1NC8yRzJ3Ymd0WmNpZ3dYNmVocUlVZFRa?=
 =?utf-8?B?VGh0aEl0NUpNcExkZzFaNVBtZW1qcElrOEhnM2pMY2lXUkkxS2RkZDBKZDE0?=
 =?utf-8?Q?PDE8ZvMUO0TrlYLuC2?=
Content-Type: multipart/mixed;
 boundary="_002_SA1PR12MB71525D6082DCD47B7C7E4204F87C2SA1PR12MB7152namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a862a6cc-9e12-445b-24dc-08df442e7377
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 22:10:40.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwahIeVN8d0wycvRP/+/9w4eyRodxWLk/76xfCPK0355KzdCnn40uHIwc+6JnOJRoJoQP7hL5x97UEnYPQrFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_002_SA1PR12MB71525D6082DCD47B7C7E4204F87C2SA1PR12MB7152namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQpQbGVhc2Ugc2VlIHRoZSBhdHRhY2hlZCBw
YXRjaC4gSXMgdGhpcyB3aGF0IGRvIHlvdSBtZWFuPw0KDQpUaGFua3MsDQpUaGFyc2hhbg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJp
by5MaW1vbmNpZWxsb0BhbWQuY29tPg0KU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNiwgMjAyNiAy
OjQ0IFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IFRob3RoaXJhbGluZ2FtLCBMb2dhdGhhcnNoYW4gPExvZ2F0aGFyc2hhbi5UaG90aGlyYWxpbmdh
bUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBQZXJleiwgUmFuZHkgPFJhbmR5
LlBlcmV6QGFtZC5jb20+OyBDaGl1LCBNaWNoYWVsIDxNaWNoYWVsLkNoaXVAYW1kLmNvbT47IFBy
b3N5YWssIFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBkcm0v
YW1kZ3B1OiBQYXRjaCByZXZpZXcgZm9yIGdmeCBoYW5nIG9uIHN1Ym1pdHRlZCBqb2JzIGZvciBT
Mw0KDQoNCg0KT24gMTEvMTYvMjYgMTM6NDIsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IE9u
IDExLzE2LzI2IDE2OjI0LCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4+IE9uIDExLzE2LzI2
IDA5OjA0LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPj4+IEhpIFRoYXJzaGFuLA0KPj4+DQo+
Pj4gdGhlIGlkZWEgbG9va3MgZ29vZCBpbiBnZW5lcmFsLCBidXQgY291bGQgYmUgc2ltcGxpZmll
ZCBhIGJpdCBieSB3YWl0aW5nIGZvciB0aGUgVk0gdG8gYmUgaWRsZS4NCj4+Pg0KPj4+IFF1ZXN0
aW9uIGlzIHdoeSBkb24ndCB3ZSBhbHJlYWR5IGhhdmUgdGhhdD8gT3IgZG8gd2UgYWxyZWFkeSBo
YXZlIHRoYXQgc29tZXdoZXJlIGVsc2U/IEknbSBwcmV0dHkgc3VyZSB0aGF0IHdhaXRpbmcgZm9y
IGFsbCBzdWJtaXNzaW9ucyBiZWZvcmUgUzMgc2hvdWxkIGFscmVhZHkgYmVlbiBpbXBsZW1lbnRl
ZCBzb21ld2hlcmUuDQo+Pj4NCj4+PiBBZGRpbmcgTWFyaW8gdG8gYW5zd2VyIHRoYXQgcXVlc3Rp
b24sIGhlIGhhcyBiZWVuIHdvcmtpbmcgb24gc3VzcGVuZC9yZXN1bWUgcXVpdGUgYSBsb3QgcmVj
ZW50bHkuDQo+Pg0KPj4gSSB0aG91Z2h0IHdlIGhhZCBzb21ldGhpbmcgbGlrZSB0aGlzLCBidXQg
bG9va2luZyB0aHJvdWdoIHRoZSBjb2RlIGJhc2UgaXQgc2VlbXMgbm90IChvciBJIG1pc3NlZCBp
dCkuDQo+Pg0KPj4gSSB0aGluayBpdCdzIHRoZSB3cm9uZyBraW5kIG9mIHBhdGNoIHRob3VnaC4g
IEkgYmVsaWV2ZSB3ZSBzaG91bGQgdXNlIHNvbWUgb2YgdGhlIGV4aXN0aW5nIGZsdXNoIGZ1bmN0
aW9ucyBhbmQgZG8gaXQgYXQgdGhlIHNhbWUgdGltZSB0aGF0IHdlIGV2aWN0IHJlc291cmNlcy4g
IFNvbWV0aGluZyBsaWtlIHRoaXMgKGF0dGFjaGVkKS4NCj4NCj4gUGxlYXNlIGRyb3AgdGhlIHRp
bWVvdXQsIGtlZXAgaW4gbWluZCB0aGF0IHdlIHNob3VsZCBhbHdheXMgd2FpdCBmb3JldmVyIGZv
ciBkbWFfZmVuY2VzLg0KPg0KPiBBcGFydCBmcm9tIHRoYXQgbG9va3MgcmVhc29uYWJsZSB0byBt
ZSwgQ2hyaXN0aWFuLg0KDQpPSywgSSdsbCBwb3N0IGl0IG9uIGl0J3Mgb3duIHRocmVhZCBhbmQg
ZHJvcCB0aGUgdGltZW91dC4NCg0KPg0KPj4NCj4+IENhbiB5b3Ugc2VlIGlmIHRoaXMgYWxzbyBo
ZWxwcz8NCj4+DQo+Pj4NCj4+PiBBZGRpbmcgVml0YWx5IHRvIGRvdWJsZSBjaGVjayBpZiB3ZSBo
YXZlIGFscmVhZHkgYSB0ZXN0IGNhc2UgZm9yIHRoYXQuDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4g
Q2hyaXN0aWFuLg0KPj4+DQo+Pj4gT24gMTEvMTMvMjYgMTc6NDQsIFRob3RoaXJhbGluZ2FtLCBM
b2dhdGhhcnNoYW4gd3JvdGU6DQo+Pj4+IEFNRCBHZW5lcmFsDQo+Pj4+DQo+Pj4+DQo+Pj4+IEhp
LA0KPj4+Pg0KPj4+Pg0KPj4+PiBQbGVhc2UgaGVscCBtZSByZXZpZXcgdGhlIGF0dGFjaGVkIHBh
dGNoLg0KPj4+Pg0KPj4+Pg0KPj4+PiBBIGdmeCBoYW5nIHRoYXQgb2NjdXJzIDIgb3V0IG9mIDQw
MCB0aW1lcyB3aGVuIHBlcmZvcm1pbmcgUzMgY3ljbGVzLiBUaGUgaXNzdWUgaXMgc2VlbiB3aXRo
IHRoZSBrZXJuZWwgdmVyc2lvbiA2LjE4LjggYW5kIG9uIEFNRCBoYXJkd2FyZTsgUGljYXNzbyBn
Zng5IEFQVS4NCj4+Pj4NCj4+Pj4NCj4+Pj4gV2hlbiBnb2luZyB0byBTMyBzdXNwZW5kLCB0aGUg
ZHJpdmVyIGNoZWNrcyB3aGV0aGVyIEdQVSBoYXMgY29tcGxldGVkIGl0cyB0YXNrcywgYnV0IGl0
IGRvZXNu4oCZdCB3YWl0IGZvciBqb2JzIHRoYXQgYXJlIHN1Ym1pdHRlZCB0byB0aGUgc2NoZWR1
bGVyLiBBcyBhIHJlc3VsdCwgcXVldWVkIHVwIGpvYnMgc2xpcCBpbnRvIHRoZSByaW5nIGFuZCBh
cmUgbG9zdCB3aGVuIFdQVFIgaXMgc2V0IHRvIDAuIE9uIHdha2UgdXAsIHdlIGhpdCBhIHRpbWVv
dXQgZm9sbG93ZWQgYnkgYSBoYW5nLg0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGUgZml4IGlzIHRvIHdh
aXQgZm9yIGFsbCBzY2hlZHVsZWQgdGFzayB0byBmaW5pc2ggYmVmb3JlIGdvaW5nIHRvIFMzLiBJ
IHRlc3RlZCB0aGUgcGF0Y2ggYW5kIHRoZSBpc3N1ZSBpcyBub3Qgc2VlbiBhZ2Fpbi4NCj4+Pj4N
Cj4+Pj4NCj4+Pj4NCj4+Pj4gVGhhbmtzLA0KPj4+Pg0KPj4+PiBUaGFyc2hhbg0KPj4+Pg0KPj4+
DQo+DQoNCg==

--_002_SA1PR12MB71525D6082DCD47B7C7E4204F87C2SA1PR12MB7152namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-drain-queued-user-submissions-before-suspend_6.18.38.patch"
Content-Description:  0001-drm-amdgpu-drain-queued-user-submissions-before-suspend_6.18.38.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-drain-queued-user-submissions-before-suspend_6.18.38.patch";
	size=2829; creation-date="Mon, 16 Nov 2026 22:10:15 GMT";
	modification-date="Mon, 16 Nov 2026 22:10:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMTI0N2IxNTM5NzBmMzc1YWU4MDdmZTQ2NGJhZjljMGZlYTNiN2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMb2dhdGhhcnNoYW4gVGhvdGhpcmFsaW5nYW0gPExvZ2F0aGFy
c2hhbi5UaG90aGlyYWxpbmdhbUBhbWQuY29tPgpEYXRlOiBNb24sIDE2IE5vdiAyMDI2IDE3OjAz
OjEzIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZHJhaW4gcXVldWVkIHVzZXIg
c3VibWlzc2lvbnMgYmVmb3JlIHN1c3BlbmQKCkF0IHN1c3BlbmQsIGFtZGdwdV9mZW5jZV9kcml2
ZXJfaHdfZmluaSgpIG9ubHkgd2FpdHMgZm9yIHRoZSBsYXN0IGZlbmNlCmVtaXR0ZWQgdG8gZWFj
aCByaW5nLiBKb2JzIHN0aWxsIHF1ZXVlZCBpbiBhIHNjaGVkdWxlciBlbnRpdHkgaGF2ZSBub3QK
cmVhY2hlZCBydW5fam9iKCkgeWV0IGFuZCBzbyBoYXZlIG5vIGhhcmR3YXJlIGZlbmNlLiBVc2Vy
c3BhY2UgaXMgZnJvemVuCmF0IHRoaXMgcG9pbnQsIGJ1dCBzdWNoIGpvYnMgY2FuIGJlY29tZSBy
dW5uYWJsZSBsYXRlciwgZm9yIGV4YW1wbGUgb25jZQphIGRlcGVuZGVuY3kgc2lnbmFscywgYW5k
IHRoZSBzY2hlZHVsZXIgdGhlbiBwdXNoZXMgdGhlbSBpbnRvIHRoZSByaW5nCmFmdGVyIHRoZSBo
YXJkd2FyZSB3YWl0IGhhcyBmaW5pc2hlZCBhbmQgYmVmb3JlIHRoZSBJUCBibG9ja3MgYXJlIHRv
cm4KZG93bi4gT24gcmVzdW1lIHRoZSByaW5nIHdyaXRlIHBvaW50ZXIgaXMgcmVzZXQsIHRob3Nl
IGpvYnMgbmV2ZXIKc2lnbmFsIGFuZCB0aGUgR0ZYIHJpbmcgdGltZXMgb3V0IGFuZCBoYW5ncy4K
ClRoaXMgd2FzIG9ic2VydmVkIGFzIGEgcmFyZSAoYWJvdXQgMiBpbiA0MDAgY3ljbGVzKSBHRlgg
aGFuZyBvbiBTMyByZXN1bWUKb24gUGljYXNzby4KCkZsdXNoIHRoZSBjb250ZXh0IGVudGl0aWVz
IGFuZCB0aGUgVk0gdXBkYXRlIGVudGl0aWVzIG9mIGV2ZXJ5IG9wZW4gZmlsZQpiZWZvcmUgZXZp
Y3RpbmcgcmVzb3VyY2VzLCBtaXJyb3Jpbmcgd2hhdCBhbWRncHVfZmx1c2goKSBkb2VzIG9uIGZp
bGUKY2xvc2UuIExpa2UgYW55IHdhaXQgZm9yIGRtYV9mZW5jZXMgdGhlIHdhaXQgaXMgbm90IGJv
dW5kZWQuCgpTaWduZWQtb2ZmLWJ5OiBMb2dhdGhhcnNoYW4gVGhvdGhpcmFsaW5nYW0gPExvZ2F0
aGFyc2hhbi5UaG90aGlyYWxpbmdhbUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCmluZGV4IGMyMmFlYTQ2ZS4uY2ExOWI0ZDMzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC01MjA5LDYgKzUyMDksMjkgQEAg
dm9pZCBhbWRncHVfZGV2aWNlX2NvbXBsZXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCiAJfQog
fQogCisvKioKKyAqIGFtZGdwdV9kZXZpY2VfZmx1c2hfdXNlcl9zdWJtaXNzaW9ucyAtIGRyYWlu
IHF1ZXVlZCB1c2VyIHN1Ym1pc3Npb25zCisgKiBAYWRldjogYW1kZ3B1IGRldmljZSBvYmplY3QK
KyAqCisgKiBXYWl0IGZvciB0aGUgc2NoZWR1bGVyIGVudGl0aWVzIG9mIGFsbCBvcGVuIGZpbGVz
IChjb250ZXh0IGVudGl0aWVzIGFuZAorICogVk0gdXBkYXRlIGVudGl0aWVzKSB0byBydW4gb3V0
IG9mIHF1ZXVlZCBqb2JzLCBzbyB0aGF0IG5vdGhpbmcgY2FuIHNsaXAKKyAqIGludG8gdGhlIHJp
bmdzIGFmdGVyIHRoZSBoYXJkd2FyZSBmZW5jZXMgd2VyZSB3YWl0ZWQgb24gYXQgc3VzcGVuZCB0
aW1lLgorICogTGlrZSBhbnkgd2FpdCBmb3IgZG1hX2ZlbmNlcyB0aGlzIG11c3Qgbm90IHRpbWUg
b3V0LgorICovCitzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2ZsdXNoX3VzZXJfc3VibWlzc2lv
bnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJc3RydWN0IGRybV9kZXZpY2UgKmRk
ZXYgPSBhZGV2X3RvX2RybShhZGV2KTsKKwlzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGU7CisKKwlndWFy
ZChtdXRleCkoJmRkZXYtPmZpbGVsaXN0X211dGV4KTsKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGZp
bGUsICZkZGV2LT5maWxlbGlzdCwgbGhlYWQpIHsKKwkJc3RydWN0IGFtZGdwdV9mcHJpdiAqZnBy
aXYgPSBmaWxlLT5kcml2ZXJfcHJpdjsKKworCQlhbWRncHVfY3R4X21ncl9lbnRpdHlfZmx1c2go
JmZwcml2LT5jdHhfbWdyLCBNQVhfU0NIRURVTEVfVElNRU9VVCk7CisJCWFtZGdwdV92bV93YWl0
X2lkbGUoJmZwcml2LT52bSwgTUFYX1NDSEVEVUxFX1RJTUVPVVQpOworCX0KK30KKwogLyoqCiAg
KiBhbWRncHVfZGV2aWNlX3N1c3BlbmQgLSBpbml0aWF0ZSBkZXZpY2Ugc3VzcGVuZAogICoKQEAg
LTUyNTMsNiArNTI3Niw4IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwgYm9vbCBub3RpZnlfY2xpZW50cykKIAlhbWRncHVfYW1ka2ZkX3N1c3BlbmQo
YWRldiwgIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYWRldi0+aW5fcnVucG0pOwogCWFtZGdw
dV91c2VycV9zdXNwZW5kKGFkZXYpOwogCisJYW1kZ3B1X2RldmljZV9mbHVzaF91c2VyX3N1Ym1p
c3Npb25zKGFkZXYpOworCiAJciA9IGFtZGdwdV9kZXZpY2VfZXZpY3RfcmVzb3VyY2VzKGFkZXYp
OwogCWlmIChyKQogCQlyZXR1cm4gcjsKLS0gCjIuMzQuMQoK

--_002_SA1PR12MB71525D6082DCD47B7C7E4204F87C2SA1PR12MB7152namp_--
