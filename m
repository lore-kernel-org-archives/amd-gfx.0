Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFD6C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BE82184D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE82184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E08489F35;
	Fri, 15 Jan 2021 13:59:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0068D6E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 13:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBoz59b6NkjZ+5dYk98cPTc2X2Wqtp+H+ggO6hc9fPvyK82m2bbtEz33as/eFL3xmn7KzXRlq2kGJzUlggwRYmWnPnFLGNJB3o3rNpvEKlDDjWqq5tWJ+pK/S3oY1x8RCLzYmIUiG9sUb14BnmaiFTx8oNmC+zPrd1M+1Yiks+K/Fc1T+9NPmA26w23jogoyOuO1ZGrP8Ch+tmHaO0unHA4ZBhO23ez9lA1+9nugQ6Cw8OXtUvXRZ/kExOUbNoRk3DCAsX5llpUnbPjNgdnmofKwFgDjksGUQvIOTRQiT5L5g+BDV/nA+QBcyjHWn3D2hc8QKfOPbZl9AK0u8/dsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJAljE5PMG/VPzngTBxZosk3PZ9uZ+wlbkstta0LFw=;
 b=VMc8rWPpU28nOtuIUUFAk6Cuv5Dh3ds7qoxUySlX1xgCGOrlmyVgTqrmoPINVOd7mvxBUO7vywjQTupW4pSmj5eswSU0WDPP5SwxtOSz8ET1/wGvukXj4KShpwug9X1eVfGEt9xUyFY98XLe1xogjmxIO8EwfXwY8At5aEwez4ehbmraKd/ygNActuOvouUBMsJT/+yYtobxGwAsVTQYawN9MbD5PCSGxrnYRehqez0sGDHsljUYYiNVzseN2Nnqvqi7bwnvIA8rU320E4kRjoyo5q4N6OAvUzjC4jUh7kVTNVstNNKO5LeOFMBGtL+KWT4lAfiQ/6CgxHTryZCEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJAljE5PMG/VPzngTBxZosk3PZ9uZ+wlbkstta0LFw=;
 b=SC5GixDvn96kY4dJoSPd1e3PFrlty/77I+RRb3uZMYvvSa4vVdNA8tnKTeNsv8TwqP8Ftii2S2Ve39zoLbJpOeAZ0+4tkgOH88O+jbG/h25Hx1f2HGZjbdq5Yvg5yJDAfthAlZjT/3XjDfh0vD7hEUFpT3CkOtsX3F4SaTTlzzY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 13:59:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 13:59:30 +0000
Subject: Re: [PATCH] drm/amd/display: fix the coding style issue of
 integrated_info
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115215423.525965-1-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e14afaa8-5e5c-a16c-b6bc-e8a6e792a3f4@amd.com>
Date: Fri, 15 Jan 2021 14:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210115215423.525965-1-ray.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:205:1::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:205:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.5 via Frontend Transport; Fri, 15 Jan 2021 13:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01ec7fa1-88fc-45fb-d38f-08d8b95dc775
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4192510FA9B4556D7B9A5B7883A70@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1q99msHZ+jmo1jfbVFMdHmw9RbQn7K8/zfnX3DaOpr7CsCyY3uJmkaV6MHYFbZdastzloOrbgKydLYICqEgdfXd9+iX/ShHmJQ78YCmAPf66YBsGjycMDVBHlt6OVNvnK5f3K3gPYRcI6JGrl0r0Tm4bBQwhc6zVXwfYMI5Wvzt5H7QC68JWFyk8zHc5KZbnxfMeNtCGT/VoXT5jo4aM3V2+THyQslABbXabaAkREF5wwUPyCbzFFbrG87LS/++Xm76BPL0IU/9UIKJBMjkHSnf5IImsxkEuZRCnk+yo5GGGNmI929prU4N6UjodEsNR7w96P4D13rS+vEvx6z9s2CqV6W7K8gFQJjgl7Yd9eqdtEvM17fWrQzaNCzbd4r/cp83FXqP0D55xZkfdAxPetQOwCTl0oZP7lMZ73ttaIpVEfsEGqmmbsXfb+3Ptj0mz6SKnANsUu4SoiZsTqzw/ExPvIg3mPAx4moLWY5Vohw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(6666004)(52116002)(86362001)(66946007)(8936002)(36756003)(8676002)(4326008)(2616005)(66476007)(2906002)(66556008)(316002)(54906003)(6486002)(31686004)(83380400001)(478600001)(5660300002)(16526019)(186003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUFsdTJybGZGV1doU1E0R3NHbzZuSkRzRmRkcEJkMzVHVU5hWm5rYTl6K09T?=
 =?utf-8?B?UjB0ZGVDR1RiUHYyZXJnSzhGL0hHUDZNc0NSSVZMVXpSWnhTelIzMGNLWmlj?=
 =?utf-8?B?Z2xUYjVoUkk4am1WUUN4QlNaazlxRGEvZC9ibEJwTkJ4V0NXQldoM3RlNXZ3?=
 =?utf-8?B?NVJqVzRybHhJQVZqY3QxTS9uc051cEY5UGEvQ0w1QVF4Y2xKUVB6Q1djYlVF?=
 =?utf-8?B?dUh3clJSZktEcTNubWcvcnRrV0l6TW9SNWUydzUvalFWZG9ZVVBUUEdocUdH?=
 =?utf-8?B?bE1lRWNCOFBmZlh6WkcyUm9nUjU2aVp1SXNKWjNMV1UrVHhvaW5CSkxtWFc2?=
 =?utf-8?B?M3dOUWl2OHZObytSeXNiY1l4R21rRjVMNjJuL05FNkZJNGtsRzBZbUx0WXRL?=
 =?utf-8?B?blBHSlljdjF2OElXSHRGdE0rMXRWdlQxdTU3REdYVjcwTWxOSjh0M2lZSDBu?=
 =?utf-8?B?TUJXdm1iREtUU0pxQTlZWXFFTU5GZjZzSEdpVndlMnY0SzBMMHZmMnM1V0h6?=
 =?utf-8?B?TXBTWm5wS1lBZDJJaGsxQk15MkdZSUoxRVNkd1BndlcrM3VNN0ZCNGpYallj?=
 =?utf-8?B?bC8zemxScThRcnFTTk9rREJpbnhpY2FocmlORXJBZmZhQkw3UHFIVWprY282?=
 =?utf-8?B?VzhjMXRkcWs1SnNDREJnYlRIZVZsYm5LZG1pcVMxeC9oNjJjajVBeTVFckwv?=
 =?utf-8?B?a1dvOERYQTZMT1VzdkpwU0k2K1oxL0twckhnVzNOOVpsNUNVRGQ2VWY5aXB6?=
 =?utf-8?B?MUpMdFVlUFVhNlhkcFdsbmxRU1Y0ZFdUNTV2aDFNbXk0V1FhLzYyQ0ZWVXpj?=
 =?utf-8?B?U0VBSTJ3Z1hIdFE2RkxjaldkQ1pYcFRtSkZua1o1QU9hbUhldCtFRVVXMXBI?=
 =?utf-8?B?blh0M2ZFY1pDLzI0STRsVlJwdmd0cnFGRnhTTG9BYkNRSi9QY2FXTU5RaTZu?=
 =?utf-8?B?ZFFHazB4bHRiVUFIdzVvZHFadVpSMnNUZUtRUmNhS09OdEVaelk2dGJqRVd0?=
 =?utf-8?B?SXNpUFJWdE5xRVRyeU9hcnlVMWh3cTZnajY5QVdTV2VONkd2RFR0aVNob0J0?=
 =?utf-8?B?eWRocWtjZmJ6M0tiVXFVSmdSVG9WQkkxL2NQUHdScmdTSHBzZ1RKWHRYQjVY?=
 =?utf-8?B?a0JzYW12R3hCQ0JuT3BWWFNEZ0hmNFBSNXVPZTVZZUkxN2NBM1duMmtaTEg2?=
 =?utf-8?B?K05wR3pvbFZhZlA1em4wNDMxTG9rRXJNdFhQV0EwYTk2K0xBa1lESFptODVB?=
 =?utf-8?B?WXRTQ0pBZ1RTbGhJUWVEVHV4bzA0cFBjSzhtL25TSnNZNVdrTmVKVVFRKzZ6?=
 =?utf-8?B?RHZlZEdXZWl1K0RlY21VbExYZnYxZEo4MjBaK01hT2E2czJyMHNhVERHZjJS?=
 =?utf-8?B?dWZZL0pOM2JKdlMwVHI0VTRidXpvSXhYZGpONm5HTi9VaFlMb01vRHNWTEhM?=
 =?utf-8?Q?4gx3GLvg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec7fa1-88fc-45fb-d38f-08d8b95dc775
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 13:59:30.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubRfDztiq6ma7h7JfAmZpjUBRFzMc5JERxRy1y6MqBI2JTs5DBCwyTCU7poDghT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>,
 Jiansong.Chen@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDEuMjEgdW0gMjI6NTQgc2NocmllYiBIdWFuZyBSdWk6Cj4gRm9sbG93IHRoZSBjb2Rp
bmcgc3R5bGUgb2Ygc2l6ZSBvZiBhIHN0cnVjdCwgY2hhbmdpbmcgdG86Cj4KPiBwID0ga21hbGxv
YyhzaXplb2YoKnApLCAuLi4pOwo+Cj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVh
bmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfbGluay5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjX2xpbmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmsuYwo+IGluZGV4IDczMTc4OTc4YWU3NC4uOTg4NWVmMjFjYzA1IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+IEBAIC0x
MzgwLDcgKzEzODAsNyBAQCBzdGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNf
bGluayAqbGluaywKPiAgIAo+ICAgCURDX0xPR0dFUl9JTklUKGRjX2N0eC0+bG9nZ2VyKTsKPiAg
IAo+IC0JaW5mbyA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBpbnRlZ3JhdGVkX2luZm8pLCBHRlBf
S0VSTkVMKTsKPiArCWluZm8gPSBremFsbG9jKHNpemVvZigqaW5mbyksIEdGUF9LRVJORUwpOwo+
ICAgCWlmICghaW5mbykKPiAgIAkJZ290byBjcmVhdGVfZmFpbDsKPiAgIAo+IEBAIC0xNTQ1LDcg
KzE1NDUsNyBAQCBzdGF0aWMgYm9vbCBkY19saW5rX2NvbnN0cnVjdChzdHJ1Y3QgZGNfbGluayAq
bGluaywKPiAgIAl9Cj4gICAKPiAgIAlpZiAoYmlvcy0+aW50ZWdyYXRlZF9pbmZvKQo+IC0JCW1l
bWNweShpbmZvLCBiaW9zLT5pbnRlZ3JhdGVkX2luZm8sIHNpemVvZihzdHJ1Y3QgaW50ZWdyYXRl
ZF9pbmZvKSk7Cj4gKwkJbWVtY3B5KGluZm8sIGJpb3MtPmludGVncmF0ZWRfaW5mbywgc2l6ZW9m
KCppbmZvKSk7Cj4gICAKPiAgIAkvKiBMb29rIGZvciBjaGFubmVsIG1hcHBpbmcgY29ycmVzcG9u
ZGluZyB0byBjb25uZWN0b3IgYW5kIGRldmljZSB0YWcgKi8KPiAgIAlmb3IgKGkgPSAwOyBpIDwg
TUFYX05VTUJFUl9PRl9FWFRfRElTUExBWV9QQVRIOyBpKyspIHsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
