Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08161C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C428261264
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 21:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C428261264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8204F6EAA5;
	Fri, 18 Jun 2021 21:02:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C2D6EAA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 21:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsCqE5FFNI+c+TuQz1i+KiBZP954oH0dAzKcfs83h8EoJWZYkQAoVKS7H3AFg5egMXCCZhvdbgqZEzRVJ1pvsYbXWAYybNMXL40jfTZvma23NSVSsC0axrOTi+6Qs+pn9/PPp+Wub1txj25c6C9m7/vBfjub5cOQp5B6Ln4gEVwtThvC1e5UFSI5h7INBWgJ2THIPxQ2Oddkf51dfA67fEw2X4LO3a1YHkk6Ef1XPof4l5G+YYcW7TkduAs0eSKVTcWC36MTybSAXIZh1ObyZ1i7YQerCBAt5dRelO2DoTV6FeYUHIobTQ2C/Ge4jRaH5oL2sqVeph7166M6iXGb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLhVlePnh8lXPGtXMx7vtAdmn3FeZasHW+gf6xvjPKg=;
 b=fX4UmQo/cJTVonHcLpmajGUPAlgyjOKMJTE2WiZwI/mpep+/RWQOwAU0eysOI6EQQegV6GzUKrj7RCJL7JoAieTcsNcH2rxm7ug3yerN42PJP59oUZtZjspaSo1vMhGVy1e6gGM1qg0686GjC+lG999AQaEyvd6h6LvbU0HKY9uOmgxWqRhPTuB8MxOcKBRFtwTXiB/iTBeyRYZc64CRgRPXm9i+iemqDZCmksE6tEM3qrWaQa1fz7kCpAZxv++et/duQcjnUbvLpSv2IESNVgdiMzYQ9AQAR650EN10QgExJ2xuHxNjaIhpPO7Fldh2tShofH3HOFPMHZeVNEClvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLhVlePnh8lXPGtXMx7vtAdmn3FeZasHW+gf6xvjPKg=;
 b=Hv60lxfTSmw0NOinMYvi0OfCj2rIf1NIpEWOqclWVKQGdSuBIS7HHqAaAs6u2H32Mj5OQvX4HwZ8Nqdp0cH16QAkRL/gxJczJBKqn3LDXdLM/pcLebu/2wjQY7xy0UO6P+YecTdudkd5flQZEoNV370FekpylhJIFgmQr48iQls=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 21:02:17 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 21:02:17 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Fix some double free when destroy queue
 fails
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210618060215.8142-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8727a4f2-f776-2362-d9cf-0d48fe7cf738@amd.com>
Date: Fri, 18 Jun 2021 17:02:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210618060215.8142-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 21:02:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c4971f-f896-403b-5e2e-08d9329c5ad8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196C9A431423E048C6F70D4920D9@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgLDUEepu5PR681aV8MKe0jZnfr//GK2jJHbvYouERVqL1KU7cQmaTt8zk8IDsDIUYMJrzNn1zxLboljnCEmZo1tY/vBygje9Us4+pRn98TLdsPIx6tAAgWs0fHUlrvU9rVMZ18Suwj67v7ZqC3oGu9S5Kp7GlHh3qR4SOuWIEjsrLkTNXSll5AafSJ8Kzlfmz1xtXdW1vIuI/6otrrZshSxEHPuiWSmJjuAVmGiShScJZwJrCCovuvuQwlcKI3nyrxDl95V4+i4RWQZX+jGVlVtNF/oueqEHwSatfNoD5Ujjv/ARagRuFtenS1ARIUjIZXzrTWoO+IwcwJH2e2fozDhzbHJYFHCls6G4Edf9JveGck97PNe3O3FGu0BWtt9GMz1MsppIOA+dYK8bAyXZCX/as4LY2zwOj/9ELkM60o+9ltq1vo9vzX/7kVDn07B5fU+ki4x9eqMYkYV2eWyKJGxLqpNAKpZv9LT2YfBSQSL92zIym8VX1xYBFGYUaZZyEbCsqyokoD4nEnxnHJOqKbcjGSiuGDbMPGM2jviDzHXZFGYcMkPkSM4xHpupSW0lnVat0rwYj7WB/kBxXQENMamKMa3l8KziZkT5TRGZpKQz1cdtUp88pH2hMs/0wRkt9BsjbA8bDlzzfNRdVgb9FZffo0Ew2x2tVUX7FvUE5JxADC1Vpc290Q/KuWP9vkU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(83380400001)(4326008)(31686004)(38100700002)(5660300002)(186003)(16576012)(478600001)(316002)(16526019)(26005)(8936002)(66556008)(66476007)(66946007)(36756003)(31696002)(86362001)(8676002)(6486002)(44832011)(2906002)(2616005)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZIVXk1amw3Rm9zTEkvRDlFT3hyS3dGTDdkYUIyOXliUGlPZ2krQXdiVW5I?=
 =?utf-8?B?VWgzVEd6VFcwMGtVTGhucWxwKzV3cXl0ckpVRzNVV3JpaEZjNHE0TG5jakxH?=
 =?utf-8?B?VTMvM0l4VENhaWU4bGxBeVRBRVNxNUo4Q1V0YjFUQ2tPWUk0THA0US9LWlBo?=
 =?utf-8?B?OUlnNXFwM0dOZHBIeVVwV0lUTnNzM0ZvbmNuNmpJaU82V3R6Yzd4N2hFckxK?=
 =?utf-8?B?MDlsVVBNbnQ1aFRiR2tPUVFwdkNRVnVpODcrcmprU0FxSUc4ejRZQ1VRUUc5?=
 =?utf-8?B?NXlPYXV4U3lHZ1N5dW1FOFNVcGd1NHptaFVQT0dsZnVHTWlCSXAxZ2ZNbWZp?=
 =?utf-8?B?bjI2RkpGbUZWRFNGVUZBc1d5ZS81TGMxMG1jNHByb0dUVDhqbE02Z2tSekw0?=
 =?utf-8?B?bzg4K2JBd3VRWTJ0c2F0VFpBUWZpNmpOa2dPRUJPSFl4Y0lEbWc0TlhqV0Z3?=
 =?utf-8?B?bWRzOEE2YUdwbFB2d3dzL1o3VlU5Wll2ZEpPRU9CNnFMb3FwZ2NCZ3A0aEFV?=
 =?utf-8?B?OGdkWWZuQ3JLNFBPeTZRYTl2SEQ5NkluUVovNE9OWUJJVEhqZjVWTGtwUW54?=
 =?utf-8?B?bmkzUFhybTEvR08yejZYWHZkbXFlRmRsT3RPL3B0MjNJdk1uckpWRHZJM3N2?=
 =?utf-8?B?RjBkRVZYTzhhMjFKeUk4WVl5bDhEQTlLbjFiWk1yRldUTTFVUjFjakFRSHFn?=
 =?utf-8?B?OVhoTjdwd1hSNnpXSWpicWxUaUJFSW9PV2FSa0VXaGVDNVMxQ0NoUHZPMVR3?=
 =?utf-8?B?WFJQeDdXNXBHN3BqOXEzVFkwZzJIaTgxQVNVZCtvWURURVVvcGs0Q1BrY2J2?=
 =?utf-8?B?S2haUkxFanY0MjFQZVZYSVBzb2N1aktOODZ5N01wZVJuaWdwQU1XVVIvaDBa?=
 =?utf-8?B?cDdJMEZKblB1S0tqUWtSUE1kWTVNQ0NZaVJuMkthL3JTbWN1MWk4Y2h2ajZw?=
 =?utf-8?B?a1JJZmYrdUZHYi90ZW5HZnNZN2hMVFNHUjI3MGN6bVRtVjI4Sncwd3pvcGIy?=
 =?utf-8?B?UHd3Sm4wOW85eWFQWDk2dSs3ejFnL3I4aVRNcXg5STYyV3RIQ0VQdW1xZDdp?=
 =?utf-8?B?RklzK21VQlNoaW0zRzhiMmhZTjJTNXRCQW1Cb2RDWmVCak5IWnZLeE9zcUhR?=
 =?utf-8?B?UTliM3o4VS9HUHFCNlMxNDdCM0hYYjQwU2hKejNuK1ZRY0JYU2FUcWY5RGh1?=
 =?utf-8?B?VXVlRS9XK3FQeThFckJ6bTJiTlF0bWdTVk9Bb0x2NDNPVDFteFE5dUwwTHov?=
 =?utf-8?B?MW1EcDcwUlJoWEVTTmtLK3RrUGRrTGhaeXYvaXJlbGVOUk5MdVF3dDJIYWZy?=
 =?utf-8?B?OU1uSzE0T1VvR1d4aVhkVklxNklmNDZYMUR1ZXJYbEd6aE1KQWw4c1d1bE12?=
 =?utf-8?B?WkNXR0VkZ0Uvb005RXBLUFJPZzlFcEgvUnhPeE5sZUc5andrWVpXM1U4M09B?=
 =?utf-8?B?NUxXdUV3Zy8ya0JOd2JzUE9PQytaM3M3M1NpZWdxK05hRUtyQ1JpZEZPMG9r?=
 =?utf-8?B?bkluTnFXMDV2QzJxZDBVQWlvRE9pV2hWYlYzLzVTS3FWdjFhUHlDWjJPOUoz?=
 =?utf-8?B?ME9Ib0ZpZHFQaWRhbGVuSWJKVzlUcWo4SlZYWndDbkdSaUtUTThMZUtDRkcv?=
 =?utf-8?B?elFxR2JjMlZ6Y082Wm8wZFdrTmpqOEIyWWFQMGpvM3pVRWoyYzFtVG1kSXRW?=
 =?utf-8?B?c2EvWmI4MmZnUzNleFgwbDhBb2dzT2svR1ZGZzdWWS9BSHBYd3FDQTFra1RC?=
 =?utf-8?Q?af0mS86hLVRF7QzEtPBpxAoA1vqIuq2k4Prb21t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c4971f-f896-403b-5e2e-08d9329c5ad8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 21:02:17.2222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sGX4xKzLK6kYklMHbCVLMlLFuUOFfRbfncdUneMwnFOrjd2580IpGG9oSAtrmlGEZ1TIzwxYmy2x7bl341RXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xOCB1bSAyOjAyIGEubS4gc2NocmllYiB4aW5odWkgcGFuOgo+IEhhbmRsZSBx
dWV1ZSBkZXN0cm95IGZhaWx1cmUgd2hpbGUgQ1AgaGFuZy4KPiBPbmNlIENQIGdvdCBoYW5nLCBr
ZmQgdHJpZ2dlciBHUFUgcmVzZXQgYW5kIHNldCByZWxhdGVkIGZsYWdzIHRvIHN0b3AKPiBkcml2
ZXIgdG91Y2hpbmcgdGhlIHF1ZXVlLiBCdXQgYWxsIHVzZXJtb2RlIHF1ZXVlcyBoYXZlIHN0b3Bw
ZWQsIHdlCj4gYWN0dWFsbHkgc29tZWhvdyBzdWNjZWVkIHRvIHJlbW92ZSBxdWV1ZSBmcm9tIHJ1
bmxpc3QuIFNvIGxldHMgZG8KPiBjbGVhbnVwIHdvcmsgYXMgbm9ybWFsIGluIC1FSU8vLUVUSU1F
IGNhc2UuCj4KPiBGb3Igb3RoZXIgZmF0YWwgZXJyb3IgY2FzZXMsIHNheSBFTk9NRU0sIHdlIGhh
dmUgdG8gc2tpcCBjbGVhbnVwIHRoaXMKPiB0aW1lIGFzIHF1ZXVlIG1pZ2h0IHN0aWxsIGJlIHJ1
bm5pbmcuIFJlZ2FyZGxlc3MgdXNlci1zcGFjZSB0cmllcyB0bwo+IGRlc3Ryb3kgdGhlIHF1ZXVl
IGFnYWluIG9yIG5vdC4gV2UgbmVlZCBwdXQgcXVldWUgYmFjayB0byB0aGUgbGlzdCBzbwo+IHBy
b2Nlc3MgdGVybWluYXRpb24gd291bGQgZG8gdGhlIGNsZWFudXAgd29yay4gV2hhdCdzIG1vcmUs
IGlmIHVzZXJzcGFjZQo+IHRyaWVzIHRvIGRlc3Ryb3kgdGhlIHF1ZXVlIGFnYWluLCB3ZSB3b3Vs
ZCBub3QgZnJlZSBpdHMgcmVzb3VyY2UgdHdpY2UuCj4KPiBQYXN0ZSBzb21lIGVycm9yIGxvZyBi
ZWxvdyB3aXRob3V0IHRoaXMgcGF0Y2guCj4KPiBhbWRncHU6IENhbid0IGNyZWF0ZSBuZXcgdXNl
cm1vZGUgcXVldWUgYmVjYXVzZSAtMSBxdWV1ZXMgd2VyZSBhbHJlYWR5Cj4gY3JlYXRlZAo+Cj4g
cmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4KPiBDYWxsIFRyYWNlOgo+ICBr
b2JqZWN0X3B1dCsweGU2LzB4MWIwCj4gIGtmZF9wcm9jZnNfZGVsX3F1ZXVlKzB4MzcvMHg1MCBb
YW1kZ3B1XQo+ICBwcW1fZGVzdHJveV9xdWV1ZSsweDE3YS8weDM5MCBbYW1kZ3B1XQo+ICBrZmRf
aW9jdGxfZGVzdHJveV9xdWV1ZSsweDU3LzB4YzAgW2FtZGdwdV0KPiAga2ZkX2lvY3RsKzB4NDYz
LzB4NjkwIFthbWRncHVdCj4KPiBCVUcga21hbGxvYy0zMiAoVGFpbnRlZDogRyAgICAgICAgVyAg
ICAgICAgKTogT2JqZWN0IGFscmVhZHkgZnJlZQo+IElORk86IEFsbG9jYXRlZCBpbiBhbGxvY2F0
ZV9zZG1hX21xZCsweDMwLzB4YjAgW2FtZGdwdV0gYWdlPTQ3OTYgY3B1PTIKPiAgX19zbGFiX2Fs
bG9jKzB4NzIvMHg4MAo+ICBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKzB4ODFmLzB4OGMwCj4gIGFs
bG9jYXRlX3NkbWFfbXFkKzB4MzAvMHhiMCBbYW1kZ3B1XQo+ICBjcmVhdGVfcXVldWVfY3BzY2gr
MHhiZi8weDQ3MCBbYW1kZ3B1XQo+ICBwcW1fY3JlYXRlX3F1ZXVlKzB4MjhkLzB4NmQwIFthbWRn
cHVdCj4gIGtmZF9pb2N0bF9jcmVhdGVfcXVldWUrMHg0OTIvMHhhZTAgW2FtZGdwdV0KPiBJTkZP
OiBGcmVlZCBpbiBmcmVlX21xZF9oaXFfc2RtYSsweDIwLzB4NjAgW2FtZGdwdV0gYWdlPTI1Mzcg
Y3B1PTcKPiAga2ZyZWUrMHgzMjIvMHgzNDAKPiAgZnJlZV9tcWRfaGlxX3NkbWErMHgyMC8weDYw
IFthbWRncHVdCj4gIGRlc3Ryb3lfcXVldWVfY3BzY2grMHgyMGMvMHgzMzAgW2FtZGdwdV0KPiAg
cHFtX2Rlc3Ryb3lfcXVldWUrMHgxYTMvMHgzOTAgW2FtZGdwdV0KPiAga2ZkX2lvY3RsX2Rlc3Ry
b3lfcXVldWUrMHg1Ny8weGMwIFthbWRncHVdCj4KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFu
IDx4aW5odWkucGFuQGFtZC5jb20+Cj4gLS0tCj4gIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgfCAxNSArKysrKysrKysrKysrKy0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyAgICAgICAgICB8ICA0ICsrKy0KPiAgLi4u
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYyAgICB8ICA0ICsrKy0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVf
bWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMKPiBpbmRleCAxNmExNzEzODA4YzIuLmYzOGYwMTFlNmY5NyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdl
ci5jCj4gQEAgLTE1MjgsOCArMTUyOCwxMyBAQCBzdGF0aWMgaW50IGRlc3Ryb3lfcXVldWVfY3Bz
Y2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4gIAkJZGVjcmVtZW50X3F1ZXVl
X2NvdW50KGRxbSwgcS0+cHJvcGVydGllcy50eXBlKTsKPiAgCQlyZXR2YWwgPSBleGVjdXRlX3F1
ZXVlc19jcHNjaChkcW0sCj4gIAkJCQlLRkRfVU5NQVBfUVVFVUVTX0ZJTFRFUl9EWU5BTUlDX1FV
RVVFUywgMCk7Cj4gLQkJaWYgKHJldHZhbCA9PSAtRVRJTUUpCj4gKwkJLyogQ1AgaGFuZyBhbmQg
YWxsIHVzZXJtb2RlIHF1ZXVlcyBoYXZlIHN0b3BwZWQuCj4gKwkJICogV2UgYXJlIHNhZmUgdG8g
ZG8gdGhlIGNsZWFudXAgd29yay4KPiArCQkgKi8KPiArCQlpZiAocmV0dmFsID09IC1FVElNRSB8
fCByZXR2YWwgPT0gLUVJTykKPiAgCQkJcXBkLT5yZXNldF93YXZlZnJvbnRzID0gdHJ1ZTsKPiAr
CQllbHNlIGlmIChyZXR2YWwpCj4gKwkJCWdvdG8gZmFpbGVkX2V4ZWN1dGVfcXVldWU7Cj4gIAkJ
aWYgKHEtPnByb3BlcnRpZXMuaXNfZ3dzKSB7Cj4gIAkJCWRxbS0+Z3dzX3F1ZXVlX2NvdW50LS07
Cj4gIAkJCXFwZC0+bWFwcGVkX2d3c19xdWV1ZSA9IGZhbHNlOwo+IEBAIC0xNTUxLDYgKzE1NTYs
MTQgQEAgc3RhdGljIGludCBkZXN0cm95X3F1ZXVlX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVf
bWFuYWdlciAqZHFtLAo+ICAKPiAgCXJldHVybiByZXR2YWw7Cj4gIAo+ICtmYWlsZWRfZXhlY3V0
ZV9xdWV1ZToKPiArCS8qIFB1dCBxdWV1ZSBiYWNrIHRvIHRoZSBsaXN0LCB0aGVuIHdlIGhhdmUg
Y2hhbmNlIHRvIGRlc3Ryb3kgaXQuCj4gKwkgKiBGSVhNRTogd2UgZG8gTk9UIHdhbnQgdGhlIHF1
ZXVlIGluIHRoZSBydW5saXN0IGFnYWluLgo+ICsJICovCj4gKwlsaXN0X2FkZCgmcS0+bGlzdCwg
JnFwZC0+cXVldWVzX2xpc3QpOwo+ICsJcXBkLT5xdWV1ZV9jb3VudCsrOwo+ICsJaWYgKHEtPnBy
b3BlcnRpZXMuaXNfYWN0aXZlKQo+ICsJCWluY3JlbWVudF9xdWV1ZV9jb3VudChkcW0sIHEtPnBy
b3BlcnRpZXMudHlwZSk7CgpZb3Ugc2hvdWxkIGJlIGFibGUgdG8ga2VlcCB0aGUgcXVldWUgb2Zm
IHRoZSBydW5saXN0IGJ5IGRpc2FibGluZyBpdC4KWW91IGNhbiBkbyB0aGF0IGUuZy4gYnkgc2V0
dGluZyBxLT5wcm9wZXJ0aWVzLnF1ZXVlX2FkZHJlc3MgPSBOVUxMIGFuZApxLT5wcm90ZXJ0aWVz
LmlzX2FjdGl2ZSA9IGZhbHNlLiBZb3UnZCBoYXZlIHRvIHVwZGF0ZQpkcW0tPmd3c19xdWV1ZV9j
b3VudCBhbmQgcXBkLT5tYXBwZWRfZ3dzX3F1ZXVlcyBtYW51YWxseSwgb3IgbW92ZSB0aGF0CmNo
YW5nZSBiZWZvcmUgdGhlIGV4ZWN1dGVfcXVldWVzX2Nwc2NoIGFib3ZlLgoKUmVnYXJkcywKwqAg
RmVsaXgKCgo+ICBmYWlsZWRfdHJ5X2Rlc3Ryb3lfZGVidWdnZWRfcXVldWU6Cj4gIAo+ICAJZHFt
X3VubG9jayhkcW0pOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfcHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+
IGluZGV4IDA5Yjk4YTgzZjY3MC4uOTg0MTk3ZTU5MjlmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gQEAgLTYwNywxMSArNjA3LDEzIEBAIHN0YXRpYyBp
bnQga2ZkX3Byb2Nmc19hZGRfc3lzZnNfZmlsZXMoc3RydWN0IGtmZF9wcm9jZXNzICpwKQo+ICAK
PiAgdm9pZCBrZmRfcHJvY2ZzX2RlbF9xdWV1ZShzdHJ1Y3QgcXVldWUgKnEpCj4gIHsKPiAtCWlm
ICghcSkKPiArCWlmICghcSB8fCAha29iamVjdF9nZXRfdW5sZXNzX3plcm8oJnEtPmtvYmopKQo+
ICAJCXJldHVybjsKPiAgCj4gIAlrb2JqZWN0X2RlbCgmcS0+a29iaik7Cj4gIAlrb2JqZWN0X3B1
dCgmcS0+a29iaik7Cj4gKwkvKiBwYWlyZWQgd2l0aCB0aGUgZ2V0IGFib3ZlICovCj4gKwlrb2Jq
ZWN0X3B1dCgmcS0+a29iaik7Cj4gIH0KPiAgCj4gIGludCBrZmRfcHJvY2Vzc19jcmVhdGVfd3Eo
dm9pZCkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3NfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3NfcXVldWVfbWFuYWdlci5jCj4gaW5kZXggOTVhNmMzNmNlYTRjLi5jNzk2Yzc2MDEzNjUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVf
bWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Nf
cXVldWVfbWFuYWdlci5jCj4gQEAgLTM3Myw2ICszNzMsNyBAQCBpbnQgcHFtX2Rlc3Ryb3lfcXVl
dWUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQgcWlkKQo+
ICAJCWRxbSA9IHBxbi0+a3EtPmRldi0+ZHFtOwo+ICAJCWRxbS0+b3BzLmRlc3Ryb3lfa2VybmVs
X3F1ZXVlKGRxbSwgcHFuLT5rcSwgJnBkZC0+cXBkKTsKPiAgCQlrZXJuZWxfcXVldWVfdW5pbml0
KHBxbi0+a3EsIGZhbHNlKTsKPiArCQlwcW4tPmtxID0gTlVMTDsKPiAgCX0KPiAgCj4gIAlpZiAo
cHFuLT5xKSB7Cj4gQEAgLTM4Myw3ICszODQsNyBAQCBpbnQgcHFtX2Rlc3Ryb3lfcXVldWUoc3Ry
dWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQgcWlkKQo+ICAJCQlw
cl9lcnIoIlBhc2lkIDB4JXggZGVzdHJveSBxdWV1ZSAlZCBmYWlsZWQsIHJldCAlZFxuIiwKPiAg
CQkJCXBxbS0+cHJvY2Vzcy0+cGFzaWQsCj4gIAkJCQlwcW4tPnEtPnByb3BlcnRpZXMucXVldWVf
aWQsIHJldHZhbCk7Cj4gLQkJCWlmIChyZXR2YWwgIT0gLUVUSU1FKQo+ICsJCQlpZiAocmV0dmFs
ICE9IC1FVElNRSAmJiByZXR2YWwgIT0gLUVJTykKPiAgCQkJCWdvdG8gZXJyX2Rlc3Ryb3lfcXVl
dWU7Cj4gIAkJfQo+ICAKPiBAQCAtMzk2LDYgKzM5Nyw3IEBAIGludCBwcW1fZGVzdHJveV9xdWV1
ZShzdHJ1Y3QgcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyICpwcW0sIHVuc2lnbmVkIGludCBxaWQpCj4g
IAkJa2ZyZWUocHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2spOwo+ICAJCXBxbi0+cS0+cHJvcGVy
dGllcy5jdV9tYXNrID0gTlVMTDsKPiAgCQl1bmluaXRfcXVldWUocHFuLT5xKTsKPiArCQlwcW4t
PnEgPSBOVUxMOwo+ICAJfQo+ICAKPiAgCWxpc3RfZGVsKCZwcW4tPnByb2Nlc3NfcXVldWVfbGlz
dCk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
