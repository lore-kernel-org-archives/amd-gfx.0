Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3247C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 05:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30E310E00A;
	Wed, 27 Dec 2023 05:34:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E7D10E00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 05:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo81becQpi0VQWwrQF7F0BQlcZzghKiQmpmOfMRP3TBs6qaVu2C/8ojxvStWthg71Ws9jVLYuXrICmcNEy7z98yuQByYTTBldYHObXc142fakYdqBOYVkvgdDPft6ygqwnrbJ3h95yiU9zQ8eNamIJ3eMWtnaz837afzuq6qDxCZ0Vi2NyCpNc4DuAI7C/Rn+FXQ1cAT+r/FPSTNr5TnUGX3/33glJ4LoYmbQdd+jFqHFS0ysLy0d/z8CD9sMxjQABtJw+Tj4wXQ4eekN420yprDRqd72dnH1R7K4tCQ6Ik8Zaq0VDi618T2XtFWjCQ9KM8TGczDslkYNYSWo5arCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nQkHYhp5CUoEmzaMd8THvuK9hXzuS1RLSvzlX0P/FI=;
 b=ON4YfiK5e6v3ySz5WMGUDqSro8uxhHLLtrk0gBo72NkXsFz9hevp/B0hq81FgVEmA9ewY0G/FKWwOH99U8efnDodiODaGsTrlcVRP1KkzdM0rA79RuS/l/QLYySBSXtgXPlSegi4EKmMsV5RGOm5TKkGk9akcYW72+Mi7d6N72nccwDp2qXMQJg6Wn5Df4IzQcXNzBFQ69rHBsQO+vUGzpGV+J0r7i6sBk9EGF8tlZq+pT0osigFnlXhjb1s56DWdZmy9g52Ui3SFkqKfZSQiZLVKZdPvDTe6GEaCGlnDy59ev960fSQMBV/mYfSKcbvBIICLF0StqRbJgCIiAKD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nQkHYhp5CUoEmzaMd8THvuK9hXzuS1RLSvzlX0P/FI=;
 b=EvED3D1xHFUcnPBEwVUmdRpK74+Fh+jwqfnG9tZQfa8uo8MpolvlAZ5QaxAaKMCMrzJTHXwQ/H/h8LqfO0HbfOdeEXWRQJWKwFzz/0pce4i/3i04g2ySu04Oc6rJ5FU84W+Eaufmh0lqugzE7flf+hn2cA+RuofN/jhyZrCefSs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Wed, 27 Dec
 2023 05:33:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 05:33:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Thread-Topic: [PATCH v2] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Thread-Index: AQHaOH5QR35jHIXdbk+OOnaEXc5T7rC8m3+w
Date: Wed, 27 Dec 2023 05:33:55 +0000
Message-ID: <BN9PR12MB5257A4DE5FEF77E85C288CDEFC9FA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231227043634.3413963-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231227043634.3413963-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d8426a4b-00db-4460-99b2-ed9897767fd5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-27T05:33:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7834:EE_
x-ms-office365-filtering-correlation-id: 91b4f9f6-38d8-4f9d-b312-08dc069d6b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ig58/HWAOORglqzWsbzD5GiY2uahe3zPRXG/pk8TUv/chYgFbYCcfqxbZj7o6/x0ELKeoIZjYdptEuI9RWQbykYcofLHT7zlz1cNWiznMwznuvMM0MLufT6xYIh55PAbdpvs5VmHcKcuFSJYCIe1DCSxUkhX2jO9SBUO2EEd/9/J6GOCA1AIRNFGw59GxUVZ2YKocwGHx7ixPT9+H3yllbilc+HiyjJoIEl+Y9Io+mAlFHutvZrwqEO94vCgsPEUi5Y+A+l/Pjxa8ejbxqvxiehZ5Ukpp2oxvuVCzWS1cxExYGiTMGT930rHiRdRfJo2kuAifi7MShIs7bY1NIfTL7qp36Njhy0T4+a+2DbotfpG/zWFe7J1t34k5j0ZMDA5KX9M72BLeUwWGp6KTjkVJPr1yFHYtbgstFCcI5CepldwDVUynhsRT3TtlqkQOrAzqA3Swk8H8R/WiJAuFo4UVj9VGGKbnBdVhWRyjQXzTIyVBwGRkBFRUppmcYnJS/Yu3IRu0YrljIYFmgse9YmPSkD6t/6vIjfL3mvXijZZJ5oG7wtpZICzAgWNv6ZAz59YJzEWqkNo2nR92qJfDETU5NQOo/zmHj/d0jZ1fVA2KMRL++pvEG6DMplGKYuxwywR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(76116006)(53546011)(86362001)(6506007)(9686003)(478600001)(71200400001)(26005)(7696005)(6636002)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(316002)(54906003)(110136005)(4326008)(2906002)(5660300002)(52536014)(122000001)(41300700001)(38100700002)(83380400001)(33656002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUhpSjgxUkl1bmFMUDkyOHpUSm05Q1prUVdnVHhEM2t6ZCtpbDNRM1ZPRHls?=
 =?utf-8?B?L0FuU0VCWWFSVC9qYWlmMENzcSt0bkI3bzZkaHU5dzdzY1ZLaFFXZnprRU9N?=
 =?utf-8?B?eUo2QmNlcGR0RTRtZGVldGtoSGJKQ242K2ZobEdTZ2tReWJVRGlXTXovWGFo?=
 =?utf-8?B?V3R4M1M5Z29PSG1WVUhPQTMrSlkwdWZlTnVValNBNkN3Rk1OcncxSFZLK0lI?=
 =?utf-8?B?VUdyUVdMY0phL0pUNmNOdVd1WFVWM0pabkRaVlpjSFY2bCtCbFM5dDNUbUl5?=
 =?utf-8?B?V1pMeVhYRkpPRUtVR1BLbVlTWFJ6VVlTMlNRQWpEclk5Y1lTSWVRMjNmc1N5?=
 =?utf-8?B?QzVxZTQ2SlVRRmhlVzFnNEZwZHBFUHVyZkZtYU5SRDYzbTBWN0djeENQcDVI?=
 =?utf-8?B?QXdtUk5KVWV5ZjFlaVpmcG9sWVE4VzBYcHkySE1DVDhwenVvWCsyZ3VwQkJM?=
 =?utf-8?B?b0RPbWZadkNoRlBxcGF1TGQxYnMyWW5yc1lJcnFuR3cxOGNZUjF2T3g2eGY3?=
 =?utf-8?B?M21HZzhyN3I5R1VFUFZMak5rS0V0N25aQkt0VHowUHUwK044Z01TY3NhbGxn?=
 =?utf-8?B?bGgrRUlFZ1dRd2pxakNtTHlnVkphL0pJNGhwK2U2NnJzMmRkZVUrZlNOdloy?=
 =?utf-8?B?NnlqdnphekZ1VTFmejBzZEdoMWd1ckdXQXB0Ym4ySkFMemEySUVmVVM2UHE4?=
 =?utf-8?B?N2h0WlgyNmZ5N1B2L0JncS9mRXJaVFZSaktCdTFoY3BwZG9EYXluNFJVY2ll?=
 =?utf-8?B?T2lTOU9jKzJBRnhpemNSTDk1TCs3UGFhWjNTM05oRGczQ1U1eWM4TWZHbHNR?=
 =?utf-8?B?aGxMVm83OUcycHZZZEVwNHVzOC9NUGFzM2lOUjRpU2JWamxjZVZSeUxDS0Vl?=
 =?utf-8?B?bHZlUjdhZUptdjJEU2xUQlFaSVlDM1B0WU5lWXJFMEZaWTBwdnBDNGR1Q1Jl?=
 =?utf-8?B?THh1NHVLOTJzUmMwZndGWExMK1BhVFpLRHZRa3VmaVQvUDl0R0d6Vm1vajZ6?=
 =?utf-8?B?OTdvYVROdFV3Y01DTy9IcDdDa1FyZjBDaWhzZ2s1aXZaek8rS2lUK3Z6QU1F?=
 =?utf-8?B?a04zTVdNdmRHbnU4b3hxbEdNWVgxbVVQcGdWdHVKYjUyQjBDS3FkYWx3TTAx?=
 =?utf-8?B?OEpuL2p4Y042QnZlTGtoeXBoNURaQmtyYkZrUnUyYjlpWUt0dTBUMDJVVlM0?=
 =?utf-8?B?dStzcXZOL1VrSWhJNFI4NUhKUDlGTDQxRWVadjNqaDluaEttdkNqUm96S0N3?=
 =?utf-8?B?RXErU2RNWU1hY3FxMnhScW5raVN0UytQNGMvSUdCcTF4bktZMjJzSTNiWkhx?=
 =?utf-8?B?Sm1rUW9rSVZoMC9rcXA0cXNoUnhXVzJxYlFXVXlmVnA4Zy9Rang2YlkyVjVk?=
 =?utf-8?B?d1dWV2R3Rmc5aEt3NUZjMkJsaFN0ZXl5ZGI5aDQ5WHlSMTBFcG9xa0s1SGth?=
 =?utf-8?B?c3YvT0J2QXJlVzgwRGg1TGc1S1d2TEduQ01rQ3VJWldWaUptcUtkNzgyYXVa?=
 =?utf-8?B?NFk5QVFpVlVWMXpIbEhNZExyK0hGSWUza0dwLy9YS0NmRFZ4YnBtbC9lbTBt?=
 =?utf-8?B?R0V0UVZxd0Q3R0lHdUxsQlh2V3YzbXF4SXJpYzlmUUtiVFBocmkxL0dQQ1Aw?=
 =?utf-8?B?VUYyZTR2a1QySEV6QzNGTE1KTFhsRzBkbFlHdHpRaEovVzc0UHIyc3VQVjR4?=
 =?utf-8?B?VFMvM2k4S2ZxaDZFL3pQVzQxNVpHN0hETnNYZVFBNnF5bDZPZGxpNE91RjFY?=
 =?utf-8?B?MUZHQm9rQTcvd244VHlaWlpWR2VNbXdpZ01xWHhTd1lQZURhcjV0ZStGTS9N?=
 =?utf-8?B?UzZkMi9kZDhIUEFOSlNNV0MrL1Zac0ZrU05PaWNjY0pLNk56MHlFQlp1bVlq?=
 =?utf-8?B?SEsrUVdJM3B5Q1F0T2lWY3JieWZoTnZDL24rUzhacUhGNVpxWFdYajUwVHQx?=
 =?utf-8?B?WlExT3gxZ2Zsb0dJbktPR2cyazVkSmhvTDBkczFYblpTcnBJNnppcmlNTUFS?=
 =?utf-8?B?bzB3WExjdExFYmUvR29MK1BKTElQZkVKTCtkK1lIZjJZV0EzVmpPU3g5YzFs?=
 =?utf-8?B?bnUra3NtUWFvS3JpRkhPRFZTVktncVY0RmJYV3V6R0VZcVRjVjloU0Urajd5?=
 =?utf-8?Q?K2g4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b4f9f6-38d8-4f9d-b312-08dc069d6b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 05:33:55.6269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wEr4X/6BKVExf9kxQ/ee6XChcZZMOv8NW0V+Fbycg4NViI2E/CchFOT2leztgLbrao+1o75NePER66Y7KW87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklO
SVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyNywg
MjAyMyAxMjozNw0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJ
TklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRD
SCB2Ml0gZHJtL2FtZGdwdTogRml4IHBvc3NpYmxlIE5VTEwgZGVyZWZlcmVuY2UgaW4gYW1kZ3B1
X3Jhc19xdWVyeV9lcnJvcl9zdGF0dXNfaGVscGVyKCkNCg0KUmV0dXJuIGludmFsaWQgZXJyb3Ig
Y29kZSAtRUlOVkFMIGZvciBpbnZhbGlkIGJsb2NrIGlkLg0KDQpGaXhlcyB0aGUgYmVsb3c6DQoN
CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoxMTgzIGFtZGdwdV9yYXNf
cXVlcnlfZXJyb3Jfc3RhdHVzX2hlbHBlcigpIGVycm9yOiB3ZSBwcmV2aW91c2x5IGFzc3VtZWQg
J2luZm8nIGNvdWxkIGJlIG51bGwgKHNlZSBsaW5lIDExNzYpDQoNClN1Z2dlc3RlZC1ieTogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KQ2M6IFRhbyBaaG91IDx0YW8uemhv
dTFAYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpD
YzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5p
dmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMyArKysNCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCmluZGV4IGJhZDYyMTQxZjcwOC4uOWM0ZGIwMzFlNWVlIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCkBAIC0xMTc2LDYgKzExNzYsOSBAQCBzdGF0aWMg
aW50IGFtZGdwdV9yYXNfcXVlcnlfZXJyb3Jfc3RhdHVzX2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwNCiAgICAgICAgZW51bSBhbWRncHVfcmFzX2Jsb2NrIGJsayA9IGluZm8gPyBp
bmZvLT5oZWFkLmJsb2NrIDogQU1ER1BVX1JBU19CTE9DS19DT1VOVDsNCiAgICAgICAgc3RydWN0
IGFtZGdwdV9yYXNfYmxvY2tfb2JqZWN0ICpibG9ja19vYmogPSBOVUxMOw0KDQorICAgICAgIGlm
IChibGsgPT0gQU1ER1BVX1JBU19CTE9DS19DT1VOVCkNCisgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCisNCiAgICAgICAgaWYgKGVycm9yX3F1ZXJ5X21vZGUgPT0gQU1ER1BVX1JBU19J
TlZBTElEX0VSUk9SX1FVRVJZKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQot
LQ0KMi4zNC4xDQoNCg==
