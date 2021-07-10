Return-Path: <SRS0=7Jcp=MC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83346C07E99
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 00:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FF061375
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 00:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF061375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E366EA97;
	Sat, 10 Jul 2021 00:29:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FA66EA97;
 Sat, 10 Jul 2021 00:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFyJuGQRgWxSE2WxyTUrYuDRwyrZORhFLka1ezx3yjJG/41zlXCGC7iruuzrVHOK+gwiBq0tJMEHQM3yazPY3kIbLhhzlChADGlFLC3em048j9fAXGCwS+hGjtzaKuN5kqluQIJNNAjYV+z9vTNdHWV2jezQAfiRzncd8n5yJjTpG25OeM1Vd081N2ggYBP8/p553JB240j8SBT8sZErTHSJNjFqCNkztfblXmDUzJkfNX5Ab9ErAmoXAxvuZyZ6Q7CTAeU3GI/uQHb9VOpUu3bI5km6kGYRsUt6HE5tcDoGAiOHoAcmyDgPVRLwmr8FZYEPrtLZOpEjLm//+/QzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEi9hS8cRwFrqDkZucGtCz7MjYwXrPHRModazDy3ovw=;
 b=Neii1qTI51GYF5M7O8DGeZuy1Sr/nMtODofrt/2FtT8Ytp0pIqBPKfy3u4QPegxbn88F7lLnMjWKHY4pF06kKSqgPEt97+f3gLB8un3bgNQZU23Htu4eK37Tk80p3/2+rrUwN73illvsJWxA4tFIl1Y/EN40V0uY9dwIKnsP3TiY0RLbUiF4Vb7LI0MjH0+szSFk0uUL1SjHZAI/dD+IAO6xrWRkggpotsxqO3gc1ztMWB5+nuM1vDWXSixc9OVrVPyrIoqi5lEjSi0MpFClF/GYJZPw3RTpZITvzmXrkXPJ2PtxYyJXU2L0JzuEzeIEJrO8f+rgIgXcNMrU7xUPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEi9hS8cRwFrqDkZucGtCz7MjYwXrPHRModazDy3ovw=;
 b=lMvtEDRynxj3tp5FvyB9cyOzIWTyZUeExpqvky5EGZku2F1ZiVQTbf5cyDR8O4PrSh5wpPeTgLxM41AfLT/DXbsILQcYSkI69yTyUGoqIoEbyyyIjS9FSjYX/P/RoVnb3fkP20PFUulGmW0vmlXxIuly7xEeTHp8At5RWGRhdwc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sat, 10 Jul
 2021 00:29:33 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:29:33 +0000
Subject: Re: [PATCH 2/2] drm/ttm: Fix COW check
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20210708193621.2198733-1-alexander.deucher@amd.com>
 <20210708193621.2198733-2-alexander.deucher@amd.com>
 <a25f93e7-8c03-542c-f594-64a7c1fba292@gmail.com>
 <2fd0006e-f005-b11c-3918-a9d690a1831a@amd.com>
 <19fbefce-b9c8-8f22-2789-0eee8f58c61a@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <98be904c-0bcb-fab2-8cbf-978aa161dc5a@amd.com>
Date: Fri, 9 Jul 2021 20:29:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <19fbefce-b9c8-8f22-2789-0eee8f58c61a@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19 via Frontend Transport; Sat, 10 Jul 2021 00:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04059e20-90df-4a50-d5aa-08d94339ca16
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51168F716F3FD03F5E8BC8E692179@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crsHW0yE0R49bna5/JGlDfNp0Vo/N7tEEtDBKTOkFDxz3tbOamxYVOxOxhd0117U63fr8VpU2BY/qQbQHlTWiWF2PWZZvFDMdWfqFnTTLQyL4Y8fP10KK7cYNsQFvERSo8lh8wfWCh5xKBb8tNDpVqPVp9GwlcttWYckcA+Vyhm2aCkXi53SvCmwKZjW78bKFwXjn2iZmfUhwlpLPMNm5FHPNbL3BeV5y14Q03n2SgFfB5eY8ohZux6X8/uIP/wNyr0HavMoOsZ2BYyBv/jnxh2h95RfKDzJUpzQsJ4/WcuSi+ujObqVn/Ldk4XfkWZWuJ4vR5l2EP+C6IU4thXd+Unf4YJLQYF2XCYqm6lXCuFrcB2q0kvigLsaWRjlnfEY7hXbFljmsP34d85Ua+pWGEBtnN1JZ+XDjjKasFWVdqDCUQm8DB9B49JYpHXcn1oiCaH4QsgT7EVoDq9/+UxQvKtBxoN+ipK/xMI3H9MMtOosCNoSERP2fqRvODeaM0jn06DhCsVlIOHcOfQjUSqSDVyWeme9zRfSBNDoZ2uqPWWNJaGV6Nx7QIJw3Gzo2s2EFxZrks8SI/svQdgqKHavRl7O8GC1ED54c5vJQOc7a6T3pJLP207sIton5k2dkGjXjidoJmrinUeWitJZL/2aHhZbwtBHamYGHb+djcCZ67vqgcOazVWygFkjJVMnS6xfjylr4NBOebJs0BRtQEAkqMvQxQNzw7Hl+nTZUe1dmNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(6486002)(8676002)(36916002)(316002)(16576012)(2616005)(66946007)(31686004)(478600001)(956004)(66556008)(66476007)(8936002)(38100700002)(110136005)(66574015)(83380400001)(36756003)(44832011)(186003)(5660300002)(26005)(2906002)(53546011)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZwbHFLY1ZiZUVRa1RnSG9sMUNrc3RNWURPeGpCWjhwR0o4cFBtWTNIRS80?=
 =?utf-8?B?TzI4eDkzckpQL1h1ajYzbGF1MmJzdkZNTzNSUnRjRENTbXYvL0pPYkhVVlE2?=
 =?utf-8?B?SzFZbXVKempEUk0zN045bVNkb1YrOFVFVUZJZjBhZDRxaVFVelF2YUFGb2w3?=
 =?utf-8?B?NnNiaUYxaVFjdDE0RWw0Tlg3UGV0UEhleEtyZWZSTGU5a2hJWE5MVEN2bXNM?=
 =?utf-8?B?aUFsOTVFWDdCUDJEUG5Md3FUbkJHRy9xcGp6T1lYOTJZVHRXTEgzdXFGVW5C?=
 =?utf-8?B?QmNyelJRSHBzYlREZmM2ZzE0OWZHc0hONndnNFYyNzhmUHZVNlhUZDhaZFl5?=
 =?utf-8?B?TW9Idys1RkFMTGJWbHlOSlJ1anUzL2lROTZXRDNITlduSndUdDhLd2xIb1hp?=
 =?utf-8?B?M1p4WGRiUXUvTlZnVFpmSGw2NlNRQnFrYk82YnhEMzhCMVRrQ1hNNXkyMHN5?=
 =?utf-8?B?VGJ1c2xJYzRMb1J6UzZYRjFnNmxkT2JzcFVDK2s4dE9CbUtqRVF4TUZFQklV?=
 =?utf-8?B?WnI2NmpwYk5tTGE0NDdlS2RRREV0Rjl1NU1Ba1VXK0UxODdtaHdsbU4zQVdS?=
 =?utf-8?B?bHF1Qk9CUmg2cXhWSHh0d1pmZGJJRjJRYWxXbVRGN1d0eUFhY2dQUHQyaEY1?=
 =?utf-8?B?Wkd3NGZ4MzJTVDJOai9MRUorRzNlWnJuMXNGSm0zVTVaTmNPVjI0Nkg0OFl0?=
 =?utf-8?B?eG5SdWx1VGpVT2owV3JST3FVYmdwZG42ZENydTZXeExJT1RMa3pzalJuc0l4?=
 =?utf-8?B?a0QzZFVEN0RHYlU5Y0I1MGo3S2tndkZSYlh6K0VrZG41QStLMGZock5ndnd2?=
 =?utf-8?B?bjBjYUZVdjhyWVE2Q0RzLy9CRTg1YzJpV282RXM2RnY4QXRmaktwNjlBSmpw?=
 =?utf-8?B?QWFtZG1udmtEa2pkYnk4NXFGWHpwNlU5Mi96VU0rcnhnSzZQSW5iZFdLdEl1?=
 =?utf-8?B?a3hidS9kRFVvVEgxS3NqU1NJRTB3TCtvUHpzdVZpYVlmdHJVdElMRlI1RklB?=
 =?utf-8?B?R2VoL3pKNjVPVGhiQ1lFKzNxZGZqNjljSXVpUHRDN3VmZWgzUFhNbk1XQ3Mw?=
 =?utf-8?B?b2hiaTF5cVlzUzdLbWZ2U0VWeXd5L3JsYmxXcFNsSFM1MG5uaTg5UzR1dGc4?=
 =?utf-8?B?dzFnNDlsdjdiT3FOUWN4ampha1pQZVNjTmd5c0FReUxIWkkvZmU3WTlBaXEr?=
 =?utf-8?B?ZTl1QnBMT05NclFOZStET1p5NEZhaDNEMVhWZFpmNUFLL082Ly92QWFTYnJ1?=
 =?utf-8?B?UXRFZW9CWVVJS3A1eWV2ZCtjS240Y2l0RUVoUHBIdHFmSUhwNmNCTUUrZkM1?=
 =?utf-8?B?S1RlQmtyNTVSeGh0Uk1VdzlxVldCRHNVYjgvYUdLUFJKRHB1d1p4NXZPR1o2?=
 =?utf-8?B?d1o1bnh5RjkrajZUVGY4ejBqdklSakVlVjIvTTZRdFRnWkRmNmc4akZYMTBQ?=
 =?utf-8?B?dG1FQ3ZPcEJneGVwT0ZmVnRadFBDbkpkbEJOTUIxVUQzV21XRzdyNmlMbXVS?=
 =?utf-8?B?ZnVFTUtoNXJJY1JNTUpCWHFIUU04QzBZSk9KOVg4N2hPeXVaeVhwa2R6S3FM?=
 =?utf-8?B?YUswdmhEL2VTUm01ejJ2c0lReVptTVhhQzdyeW9CSDdJT2Q2T2JaNUwzRlFO?=
 =?utf-8?B?aTFvR0IzTWF6STVLcForRFVFS2xGeG9ETkhCTDk0cjNMOGNxZ3FXeWl2K2dQ?=
 =?utf-8?B?NnE5VVFXdVU5RjhqakhuOHVuQzJsM01PMTExTE9sMmpHSjc2dk9IVW9PNnQz?=
 =?utf-8?Q?mWh2UePjLJw6SUSNG2mKqD/tOqu4+pK5FIjpHP8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04059e20-90df-4a50-d5aa-08d94339ca16
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:29:33.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYwJSB1qEWmurfoxyoR8lY50pXiLotpxANVhcr8dR0t1r9HZx1U/FAtSQDqntrMIO84CHxdSDLKS1Som7ZpA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDctMDkgMzozNyBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA5
LjA3LjIxIHVtIDIxOjMxIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IE9uIDIwMjEtMDctMDkg
MjozOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4KPj4+Cj4+PiBBbSAwOC4wNy4y
MSB1bSAyMTozNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4+PiBGcm9tOiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+Pgo+Pj4+IEtGRCBUaHVuayBtYXBzIGludmlz
aWJsZSBWUkFNIEJPcyB3aXRoIFBST1RfTk9ORSwgTUFQX1BSSVZBVEUuCj4+Pj4gaXNfY293X21h
cHBpbmcgcmV0dXJucyB0cnVlIGZvciB0aGVzZSBtYXBwaW5ncy4gQWRkIGEgY2hlY2sgZm9yCj4+
Pj4gdm1fZmxhZ3MgJiBWTV9XUklURSB0byBhdm9pZCBtbWFwIGZhaWx1cmVzIG9uIHByaXZhdGUg
cmVhZC1vbmx5IG9yCj4+Pj4gUFJPVF9OT05FIG1hcHBpbmdzLgo+Pj4KPj4+IEknbSBwcmV0dHkg
c3VyZSB0aGF0IHRoaXMgaXMgbm90IHdvcmtpbmcgYXMgZXhwZWN0ZWQuCj4+Cj4+IE5vdCBzdXJl
IHdoYXQgeW91IG1lYW4uIERlYnVnZ2VyIGFjY2VzcyB0byB0aGUgbWVtb3J5IHRocm91Z2ggdGhl
IAo+PiBQUk9UX05PTkUgVk1BcyBpcyBkZWZpbml0ZWx5IHdvcmtpbmcsIHdpdGggYm90aCBwdHJh
Y2UgYW5kIAo+PiAvcHJvYy88cGlkPi9tZW0uCj4+Cj4+Cj4+Pgo+Pj4+Cj4+Pj4gRml4ZXM6IGY5
MTE0MmM2MjE2MSAoImRybS90dG06IG51a2UgVk1fTUlYRURNQVAgb24gQk8gbWFwcGluZ3MgdjMi
KQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPj4+PiAtLS0KPj4+PiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIHwg
MiArLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMg
Cj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCj4+Pj4gaW5kZXggZjU2YmU1
YmMwODYxLi5hNzVlOTBjN2Q0YWEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0
bS90dG1fYm9fdm0uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMK
Pj4+PiBAQCAtNTUyLDcgKzU1Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9u
c19zdHJ1Y3QgCj4+Pj4gdHRtX2JvX3ZtX29wcyA9IHsKPj4+PiDCoCBpbnQgdHRtX2JvX21tYXBf
b2JqKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3QgCj4+Pj4gdHRtX2J1ZmZlcl9v
YmplY3QgKmJvKQo+Pj4+IMKgIHsKPj4+PiDCoMKgwqDCoMKgIC8qIEVuZm9yY2Ugbm8gQ09XIHNp
bmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3IgCj4+Pj4gd2l0aCBpdC4gKi8K
Pj4+PiAtwqDCoMKgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSkKPj4+PiArwqDC
oMKgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSAmJiAodm1hLT52bV9mbGFncyAm
IFZNX1dSSVRFKSkKPj4+Cj4+PiBpc19jb3dfbWFwcGluZygpIGFscmVhZHkgY2hlY2tzIGZvciBW
TV9NQVlXUklURSwgc28gdGhpcyBoZXJlIAo+Pj4gc2hvdWxkbid0IGJlIG5lY2Vzc2FyeS4KPj4K
Pj4gQUZBSUNULCBWTV9NQVlXUklURSBpcyBub3QgYmFzZWQgb24gdGhlIFBST1RfLi4uIGJpdHMg
dXNlZCB0byBjcmVhdGUgCj4+IHRoZSBWTUEsIGJ1dCBiYXNlZCBvbiB0aGUgcGVybWlzc2lvbnMg
b2YgdGhlIGZpbGUuIFNvIGFzIGxvbmcgYXMgdGhlIAo+PiByZW5kZXIgbm9kZSBpcyB3cml0YWJs
ZSwgVk1fTUFZV1JJVEUgaXMgc2V0IGZvciBhbGwgVk1BcyB0aGF0IG1hcCBpdC4KPj4KPj4gSSB3
b3VsZCBhZ3JlZSB0aGF0IGl0J3MgcHJvYmFibHkgYSBiYWQgaWRlYSBmb3IgdGhlIFRodW5rIHRv
IG1hcCAKPj4gdGhlc2UgVk1BcyB3aXRoIE1BUF9QUklWQVRFLiBXZSBjYW4gdHJ5IGNoYW5naW5n
IHRoZSBUaHVuayB0byB1c2UgCj4+IE1BUF9TSEFSRUQgZm9yIHRoZXNlIFBST1RfTk9ORSBtYXBw
aW5ncy4gQnV0IHRoYXQgZG9lc24ndCBjaGFuZ2UgdGhlIAo+PiBmYWN0IHRoYXQgdGhpcyBrZXJu
ZWwgcGF0Y2ggYnJva2UgZXhpc3RpbmcgdXNlcm1vZGUuCgpGb3IgdGhlIHJlY29yZCwgY2hhbmdp
bmcgdGhlIFRodW5rIHRvIHVzZSBNQVBfU0hBUkVEIHdvcmtzLgoKCj4KPiBZZWFoLCBidXQgc2Vl
IHRoZSBkaXNjdXNzaW9uIGFyb3VuZCBNQVBfUFJJVkFURSBhbmQgQ09XIHJlZ2FyZGluZyAKPiB0
aGlzLiBXaGF0IFRodW5rIGRpZCBoZXJlIHdhcyBhIHJlYWxseSBiYWQgaWRlYS4KCkhpbmRzaWdo
dCAuLi4gV2hpY2ggcGFydCB3YXMgYSBiYWQgaWRlYT8KCiAgKiBDcmVhdGluZyBhIFBST1RfTk9O
RSBWTUE/IFRoYXQncyBuZWNlc3NhcnkgdG8gbGV0IHB0cmFjZSBvcgogICAgL3Byb2MvPHBpZD4v
bWVtIGFjY2VzcyB0aGUgbWVtb3J5LiBJdCdzIGEgYnJpbGxpYW50IGlkZWEsIElNSE8KICAqIE1h
a2luZyB0aGF0IFZNQSBNQVBfUFJJVkFURT8gUHJvYmFibHkgYSBiYWQgaWRlYSBpbiBoaW5kc2ln
aHQuIFRoZQogICAgcHJvY2VzcyBpdHNlbGYgY2FuJ3QgYWNjZXNzIHRoaXMgbWVtb3J5LCBsZXQg
YWxvbmUgd3JpdGUgdG8gaXQuIFNvIEkKICAgIGRpZG4ndCB0aGluayB0b28gbXVjaCBhYm91dCB3
aGV0aGVyIHRvIG1ha2UgaXQgc2hhcmVkIG9yIHByaXZhdGUuCiAgICBFaXRoZXIgd2F5LCB3ZSBh
cmUgbm90IGNhdXNpbmcgYW55IGFjdHVhbCBDT1cgb24gdGhlc2UgbWFwcGluZ3MKICAgIGJlY2F1
c2UgdGhleSBhcmUgbm90IHdyaXRhYmxlLCBhbmQgd2UgbmV2ZXIgbWFrZSB0aGVtIHdyaXRhYmxl
IHdpdGgKICAgIG1wcm90ZWN0IGVpdGhlcgogICogSW50cm9kdWNpbmcgYSBDT1cgY2hlY2sgYWZ0
ZXIgbGV0dGluZyBpdCBzbGlkZSBmb3IgMTUgeWVhcnM/IEl0J3MgYQogICAgcmVhc29uYWJsZSBj
aGVjay4gSW4gdGhpcyBjYXNlIGl0IGNhdGNoZXMgYSBmYWxzZSBwb3NpdGl2ZS4gSGFkIHRoaXMK
ICAgIGNoZWNrIGJlZW4gaW4gcGxhY2UgNCBvciA1IHllYXJzIGFnbywgaXQgd291bGQgaGF2ZSBl
YXNpbHkgcHJldmVudGVkCiAgICB0aGlzIG1lc3MKCgo+Cj4gSSB0aGluayB3ZSBoYXZlIG9ubHkg
dHdvIG9wdGlvbnMgaGVyZToKPiAxLiBBY2NlcHQgdGhlIGJyZWFrYWdlIG9mIHRodW5rLgoKUmVh
bGx5PwoKCj4gMi4gQWRkIGEgd29ya2Fyb3VuZCBpbiBhbWRncHUvYW1ka2ZkIHRvIGZvcmNlIE1B
UF9QUklWQVRFIGludG8gCj4gTUFQX1NIQVJFRCBpbiB0aGUga2VybmVsLgoKSSB0cmllZCB0byBk
byB0aGlzIGluIGFtZGdwdV9nZW1fb2JqZWN0X21tYXAgYW5kIHNwZW50IDQgaG91cnMgZGVidWdn
aW5nIAp3aHkgaXQgZG9lc24ndCB3b3JrLiBJdCBicmVha3MgYmVjYXVzZSB0aGUgbWFwcGluZy0+
aV9tbWFwX3dyaXRhYmxlIGdldHMgCnVuYmFsYW5jZWQgYW5kIGNhdXNlcyBzdWJzZXF1ZW50IG1h
cHBpbmdzIHRvIGZhaWwgd2hlbiB0aGF0IGF0b21pYyAKY291bnRlciBiZWNvbWVzIG5lZ2F0aXZl
IChpbmRpY2F0aW5nIERFTllXUklURSkuIEkgY291bGQgZml4IGl0IGJ5IApjYWxsaW5nIG1hcHBp
bmdfbWFwX3dyaXRhYmxlLiBCdXQgSSBkb24ndCB0aGluayB0aGlzIGlzIGludGVuZGVkIGFzIApk
cml2ZXIgQVBJLiBJIHNlZSBubyBwcmVjZWRlbnQgb2YgYW55IGRyaXZlciBjYWxsaW5nIHRoaXMu
IEZvciB0aGUgCnJlY29yZCB0aGlzIHdvcmtzLCBidXQgaXQgZmVlbHMgZnJhZ2lsZSBhbmQgdWds
eToKCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKQEAgLTI1NSw2ICsyNTUsMjAg
QEAgc3RhdGljIGludCBhbWRncHVfZ2VtX29iamVjdF9tbWFwKHN0cnVjdCBkcm1fZ2VtX29iamVj
dCAqb2JqLCBzdHJ1Y3Qgdm1fYXJlYV9zdHIKICAJaWYgKGJvLT5mbGFncyAmIEFNREdQVV9HRU1f
Q1JFQVRFX05PX0NQVV9BQ0NFU1MpCiAgCQlyZXR1cm4gLUVQRVJNOwogIAorCS8qIFdvcmthcm91
bmQgZm9yIFRodW5rIGJ1ZyBjcmVhdGluZyBQUk9UX05PTkUsTUFQX1BSSVZBVEUgbWFwcGluZ3MK
KwkgKiBmb3IgZGVidWdnZXIgYWNjZXNzIHRvIGludmlzaWJsZSBWUkFNLiBTaG91bGQgaGF2ZSB1
c2VkIE1BUF9TSEFSRUQKKwkgKiBpbnN0ZWFkLgorCSAqLworCWlmIChpc19jb3dfbWFwcGluZyh2
bWEtPnZtX2ZsYWdzKSAmJgorCSAgICAhKHZtYS0+dm1fZmxhZ3MgJiAoVk1fUkVBRCB8IFZNX1dS
SVRFIHwgVk1fRVhFQykpKSB7CisJCWludCByZXQ7CisKKwkJcmV0ID0gbWFwcGluZ19tYXBfd3Jp
dGFibGUodm1hLT52bV9maWxlLT5mX21hcHBpbmcpOworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJl
dDsKKwkJdm1hLT52bV9mbGFncyB8PSBWTV9TSEFSRUQgfCBWTV9NQVlTSEFSRTsKKwl9CisKICAJ
cmV0dXJuIGRybV9nZW1fdHRtX21tYXAob2JqLCB2bWEpOwogIH0KCjMuIEltcHJvdmUgbXkgcHJl
dmlvdXMgd29ya2Fyb3VuZCBieSBhZGRpbmcgYSBzaW1pbGFyIGNoZWNrIGZvciBDT1cgaW4gCnR0
bV9ib192bV9vcHMubXByb3RlY3QuIEknbGwgc2VuZCBhbiB1cGRhdGVkIHBhdGNoLgoKUmVnYXJk
cywKIMKgIEZlbGl4CgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMs
Cj4+IMKgIEZlbGl4Cj4+Cj4+Cj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4gwqAgwqDCoMKgwqDCoCB0dG1fYm9fZ2V0KGJv
KTsKPj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
