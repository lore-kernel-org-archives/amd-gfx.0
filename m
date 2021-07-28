Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE8C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0477A60F45
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 11:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0477A60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4036E8E6;
	Wed, 28 Jul 2021 11:14:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D246E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 11:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2EdNIY9cMBWr1rWES/LIlF+jmVUvk+hvy1YbKz4UA7Givw1NCKWlbT3/nJV85lhKqk6dqDRfa3XRDZlT1n8jjtbf6T0sK77QA2D4g0+9vSicHKnL1erkrEQ/7e0d+N81IvYMtZqCmLJUwQde7j0sLU//KbxsgvWa8opJ1Ek4eNBYgZYBqMxEEG4Ly1ahRF4oymjGNhx9VcOglNAd5Tl47p2upNIEHMLiUyPzQMbNsBPS0Dd987gvJeVQqtHn19bkVlCO93nPL09gqJH/D5KFksGqlUvYszrM+0HZAcZLRCdoaESAD4rUKDNpvqD7Hrepv3wcDkcYfWpw2a0aCzhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rVp3VtCLA/4kRWtj7Y2dI4omPxNmDKEz2XR2HV2ykE=;
 b=OODNvEkxBPpcCoK3HLNkq79wVVxO0L4bPkUAZ/B6UTzjUgXK+ScxBQZTS0T7jl9E2+njWWHk5m4yCkvBR/YI8bmoLHo76wAjhzwkb267coj1qCf8yvl8K868u6oHZK/gyfrUXFkMlcd3H+El66qBSpAKrt1oGoajkUDhSWOtzhis/92RXTi1IxJlUirE0syBcaNq4UKL36Qs/TdgPtSafnbJ4cnZW8rPaKXNSyhg3YIUbY2Mt/ih+2a+brlhBIJscuhbrY0mqf+w1dI9GjuHWZMPtWTT8eXjwgE+RQB75RsL3qvWcswITGpTneNa1gxr6SXckrJwXTRcoUCrU7pOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rVp3VtCLA/4kRWtj7Y2dI4omPxNmDKEz2XR2HV2ykE=;
 b=eU2Yuvnr1nAOW7zgGOUsndbWYGgc2r85bTyNYxVeVRUY9jSs89dXYwybkSNLMuQ59x0BLe2zv46yNKXKyDcn1jOLbBmCulRXt/hX/3T3xhZvN55Ta4I4grNvO/6i3nZuJZ2ozngHjKXXg8c3+Wzb75b6+5yKn3aMJxnLgSOJYko=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 11:14:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 11:14:49 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix out-of-bounds read when update mapping
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM4PR12MB5165A564AE14CAFBDE8C948B87E99@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <14248cac-8578-d192-9a9e-f3801ffe1406@amd.com>
Date: Wed, 28 Jul 2021 13:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM4PR12MB5165A564AE14CAFBDE8C948B87E99@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0268.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6a5d:b580:2891:cbac]
 (2a02:908:1252:fb60:6a5d:b580:2891:cbac) by
 PR0P264CA0268.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17 via Frontend Transport; Wed, 28 Jul 2021 11:14:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f472ed-7ee6-41d0-37c2-08d951b8e9cd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42057220BDC7E07396E39A8283EA9@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ykYZ6y3bO4Z6BuYD6wAUFtnEZqFl1bXXyxtQT3Uq1+KPYjkKfMSuwxwsEl3okHfspzIm+fUIAgNewFa3Y20SXmLU6otQYHWTw/+ghGHtpBbL8mtgNOnG4j22Z+ZwUq0cqte9P9qQaIbXXIwRkYOKXmSFPCU68ZEjJQzIIfTJfGSWfjqXXLMvTwVBJesCttkeZBTUYtKdalcf8QIIE+XtW8Sl5uMbpDXaRl50ekBx28I54hIO3TMrJ6UjsjwvkNFaYYWBnzw7i8ZlbA6CD/EIoEdXgCsfXkXLVK2ESzQTFwgMMENKcX0NnP9f7cERXWYC/hvGsQmgH5F5iT9FDp5U1jSgyaaqU3QPIm2mR2ynRJWH1xj3AnMgq+ORz0P/HZpu1QL/8EPl3ljK/EEXi1H/iH1VTjtu4+W5IaO8X3pa6if3J0+KzQTlgS7a8VDyJanX7k1Jxh0JQkLm7KFsXF+0QAT8U0KHwcHwk4U0XorgfIr2jQWzEWvbinEP+KHHc6godCkOT4HUChSG4YZr4V1dkq3LlA9jtLcl9QQScn5fixSI9TA0wn0gfz04AS2mPfQdWgOu8FIUg+pYp3Jq1Bm3z8ifUojFn9iFqzYrgXSiDuj5Yi8DrwpHrm1l7mb2CG4exdjbBOacSnPYqJy1noDn7hI2NexWetrKlmGWlhj155NcLp2NzIoc02b2gSNHfZHpe5qvl9UDnuSDpq1XzsGU8/aeUcDQF9iUGD82poumZaAChy9JUxrl/vLH39fqlUz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(31696002)(6486002)(66574015)(66476007)(66556008)(66946007)(86362001)(478600001)(2616005)(2906002)(4326008)(31686004)(38100700002)(6666004)(110136005)(5660300002)(15650500001)(316002)(83380400001)(8936002)(36756003)(186003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2g3N1VmMG5MMUNRQVQ0MVV1V1lTTjRwajFNRHNZYzY2ZTFkeFBXcmJlbHRi?=
 =?utf-8?B?N013UkV5bi9xWDFrOXVOaGFOcnRWVU5FSjZzYWxwWm1HSFhETExpSXEvbXkv?=
 =?utf-8?B?S0VaNytxVmxScFhzcUtkRXMyQ20xazJla203U1U5OFZMZTBLbW1Bb3A3Umlo?=
 =?utf-8?B?WGRzZHR0ZDBVQzdYZ2NGZHhVRGlRbkRMS0x5QmFaYzZJWEYzUElNTEMvM0Vk?=
 =?utf-8?B?MGw5eisySytrMXBDMEdiSWlObi9mYy9rQjFMcnlGUXhKZllkdS8yNE5LSTNx?=
 =?utf-8?B?Z1pNR2NQZnJDM09VLzViRXFiRzdLSTFOZmtKYi9JTEJMamZXSENUem1jWDNL?=
 =?utf-8?B?WTF5ZllXRktUQ2gyems3L1hlMlpnOGJqLzh4TFgzRFJqU0Y5d2ppTS9CWkJ2?=
 =?utf-8?B?TWpjYnorVXNjTXpZLzc1TTdERWRxMVdCSExzVFUrbUFaaDJKRzJxbjFBQkpw?=
 =?utf-8?B?bzA3Sm94UVFqWWlScVVtOUYrUnEzcUMzR0JMWE1KMFlRa3ZFVjF2SkU4eE1i?=
 =?utf-8?B?YW56bUlEVjZYcU5iZVJDUWdKY3lVek1kS0s3T0NFMHIyOER4NmNRUXZ3ZlZs?=
 =?utf-8?B?OWwvVGkvSlZaVkx3YVRmcG1ocnA0eHl6bXhWa3JpdlhrT0ZTclFub3hrYjhm?=
 =?utf-8?B?N1RFVURHeVM3L0JSWlNjMzhTTUpkRzgzcE13UmJPaHVGNWdnR1RBYjVBTFR3?=
 =?utf-8?B?a3QwcGF6TU9qeUoyNTlCQ2VMVTRvZWVBSHVjVTdGVEM5ajJVVmtGWTdvaERm?=
 =?utf-8?B?NkZtR2lETHNzMmlQZ2hLdzJQV1BBaUJTWGcreDV2L21vNmQ4U1dKUTlXNjhL?=
 =?utf-8?B?eTVxQUozMnJuV29vSmdlWmtDTVorOE9hZTVncFBKVmozL1RENWNvR1doUFZ3?=
 =?utf-8?B?UW8vU3E4M3ZobE5wTTNXcjdrRVRSMy9LVkM0akMyanRlVGxCT3VrQ25wR0Z2?=
 =?utf-8?B?RTZ4MTRUeFJxbmxvdDgvRDU1ay9jWDBGWStzMXkxQnpjNzF6bTM4NTFIWXpM?=
 =?utf-8?B?R3Zsc2w1V1h4L0VXdFZva3l2US82dDFncWFkZ3kxcVgzUVg2cWNUY1YwMW9Z?=
 =?utf-8?B?MXhxWHJiYTZWV2tMSGtiRS9YQ25LUm04aFlnblFXUkFmNXZFOGd6Mk9ZRlRi?=
 =?utf-8?B?ZU5EM3k4WW5LMGZwSFdoZHJHYXhmdlJpRHNJby9WSWx1Smg5cEVMVW52dWZv?=
 =?utf-8?B?RG1RdlJCU0c4dnE0SlNPMFA5Z0RKWHFocDg0ekVRVUtianAxa1FpMHBnNUpl?=
 =?utf-8?B?dlVhVVRZRVdmQ21EWkl1RGs4bTF3RzFzWU1vYWFXZklHTC9yeis0bnFhMVFv?=
 =?utf-8?B?dnNDMEgzRTZveHlZaklkUjB4Sm43dFhRcTRtMmtFdDlpRVFjdG92WXNpTVpG?=
 =?utf-8?B?b3dzVFhRcDlDd05FK0xqK3J2ZjBFdW1CZUpJTTRDQ0lVNVp4aVA0S3NrM3NU?=
 =?utf-8?B?dzh0ZFZlODJsQ1BuNHE4ZWN5bC9adVJDNEZQcmlYVzJiNW96TnJCK0wxWDB0?=
 =?utf-8?B?TlIwT1ZSRnVYbWRUL2k2bmEvdnBoTTZ0Q1hFbFVPNjBZWHc2d2xOMVF1RnFZ?=
 =?utf-8?B?cjVocngrd0FqeHRRUEJwL205TmdCQkR2MW1PQzVrZ1pFdSs2dmVzaEZuK1Ba?=
 =?utf-8?B?R2Q3cWNGd2ROdmQrZUI2SnN4aVZob21MYjBMMHBvTm82M2VSWktWWjNnTUly?=
 =?utf-8?B?aERReE5kcU5qL0hOZGRRZGN4aDcweDBwSzBsU204UzhYMU1rRnlHTjFHSEZr?=
 =?utf-8?B?R0daYjE5cTgwZTV0Q0FCbEtHdmtUYUFQMEg5QU9SeVBhUEVCUHVvNmNXTUht?=
 =?utf-8?B?QXNheWdZQmx5VzN6MEVtTlBmYkdzYWR1ME9TRVFZaGszSmZSdDBweVFnK01P?=
 =?utf-8?Q?SPwIs84kjSALs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f472ed-7ee6-41d0-37c2-08d951b8e9cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:14:49.0297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tH6GsVALeeRzCWC/sv4iatNc2w/J/eaqtqMAS7bMvbVm1bIO6kJ0ADtUfnPH1v5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDcuMjEgdW0gMTI6Mzcgc2NocmllYiBQYW4sIFhpbmh1aToKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5XQo+Cj4gSWYgb25lIEdUVCBCTyBoYXMgYmVlbiBldmljdGVkL3N3YXBwZWQgb3V0
LCBpdCBzaG91bGQgc2l0IGluIENQVSBkb21haW4uCj4gVFRNIG9ubHkgYWxsb2Mgc3RydWN0IHR0
bV9yZXNvdXJjZSBpbnN0ZWFkIG9mIHN0cnVjdCB0dG1fcmFuZ2VfbWdyX25vZGUKPiBmb3Igc3lz
TWVtLgo+Cj4gTm93IHdoZW4gd2UgdXBkYXRlIG1hcHBpbmcgZm9yIHN1Y2ggaW52YWxpZGF0ZWQg
Qk9zLCB3ZSBtaWdodCB3YWxrIG91dAo+IG9mIGJvdW5kcyBvZiBzdHJ1Y3QgdHRtX3Jlc291cmNl
Lgo+Cj4gVGhyZWUgcG9zc2libGUgZml4Ogo+IDEpIExldCBzeXNNZW0gbWFuYWdlciBhbGxvYyBz
dHJ1Y3QgdHRtX3JhbmdlX21ncl9ub2RlLCBsaWtlCj4gdHRtX3JhbmdlX21hbmFnZXIgZG9lcy4K
PiAyKSBQYXNzIHBhZ2VzX2FkZHIgdG8gdXBkYXRlX21hcHBpbmcgZnVuY3Rpb24gdG9vLCBidXQg
bmVlZCBtZW1zZXQKPiBwYWdlc19hZGRyW10gdG8gemVybyB3aGVuIHVucG9wdWxhdGUuCj4gMykg
SW5pdCBhbWRncHVfcmVzX2N1cnNvciBkaXJlY3RseS4KPgo+Cj4gYnVnIGlzIGRldGVjdGVkIGJ5
IGtmZW5jZS4KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KPiBCVUc6IEtGRU5DRTogb3V0LW9mLWJvdW5kcyByZWFkIGlu
IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZysweDU2NC8weDZlMAo+Cj4gT3V0LW9mLWJvdW5k
cyByZWFkIGF0IDB4MDAwMDAwMDA4ZWE5M2ZlOSAoNjRCIHJpZ2h0IG9mIGtmZW5jZS0jMTY3KToK
PiAgIGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZysweDU2NC8weDZlMCBbYW1kZ3B1XQo+ICAg
YW1kZ3B1X3ZtX2JvX3VwZGF0ZSsweDI4Mi8weGE0MCBbYW1kZ3B1XQo+ICAgYW1kZ3B1X3ZtX2hh
bmRsZV9tb3ZlZCsweDE5ZS8weDFmMCBbYW1kZ3B1XQo+ICAgYW1kZ3B1X2NzX3ZtX2hhbmRsaW5n
KzB4NGU0LzB4NjQwIFthbWRncHVdCj4gICBhbWRncHVfY3NfaW9jdGwrMHgxOWU3LzB4MjNjMCBb
YW1kZ3B1XQo+ICAgZHJtX2lvY3RsX2tlcm5lbCsweGYzLzB4MTgwIFtkcm1dCj4gICBkcm1faW9j
dGwrMHgyY2IvMHg1NTAgW2RybV0KPiAgIGFtZGdwdV9kcm1faW9jdGwrMHg1ZS8weGIwIFthbWRn
cHVdCj4KPiBrZmVuY2UtIzE2NyBbMHgwMDAwMDAwMDhlMTFjMDU1LTB4MDAwMDAwMDAxZjY3NmIz
ZQo+ICAgdHRtX3N5c19tYW5fYWxsb2MrMHgzNS8weDgwIFt0dG1dCj4gICB0dG1fcmVzb3VyY2Vf
YWxsb2MrMHgzOS8weDUwIFt0dG1dCj4gICB0dG1fYm9fc3dhcG91dCsweDI1Mi8weDVhMCBbdHRt
XQo+ICAgdHRtX2RldmljZV9zd2Fwb3V0KzB4MTA3LzB4MTgwIFt0dG1dCj4gICB0dG1fZ2xvYmFs
X3N3YXBvdXQrMHg2Zi8weDEzMCBbdHRtXQo+ICAgdHRtX3R0X3BvcHVsYXRlKzB4YjEvMHgyYTAg
W3R0bV0KPiAgIHR0bV9ib19oYW5kbGVfbW92ZV9tZW0rMHgxN2UvMHgxZDAgW3R0bV0KPiAgIHR0
bV9tZW1fZXZpY3RfZmlyc3QrMHg1OWQvMHg5YzAgW3R0bV0KPiAgIHR0bV9ib19tZW1fc3BhY2Ur
MHgzOWYvMHg0MDAgW3R0bV0KPiAgIHR0bV9ib192YWxpZGF0ZSsweDEzYy8weDM0MCBbdHRtXQo+
ICAgdHRtX2JvX2luaXRfcmVzZXJ2ZWQrMHgyNjkvMHg1NDAgW3R0bV0KPiAgIGFtZGdwdV9ib19j
cmVhdGUrMHgxZDEvMHhhMzAgW2FtZGdwdV0KPiAgIGFtZGdwdV9ib19jcmVhdGVfdXNlcisweDQw
LzB4ODAgW2FtZGdwdV0KPiAgIGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZSsweDcxLzB4YzAgW2Ft
ZGdwdV0KPiAgIGFtZGdwdV9hbWRrZmRfZ3B1dm1fYWxsb2NfbWVtb3J5X29mX2dwdSsweDJmMi8w
eGNkMCBbYW1kZ3B1XQo+ICAga2ZkX2lvY3RsX2FsbG9jX21lbW9yeV9vZl9ncHUrMHhlMi8weDMz
MCBbYW1kZ3B1XQo+ICAga2ZkX2lvY3RsKzB4NDYxLzB4NjkwIFthbWRncHVdCj4KPiBTaWduZWQt
b2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpHb29kIGNhdGNoLgoKPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggfCAz
ICsrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vy
c29yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCj4g
aW5kZXggNTllMGZlZmIxNWFhLi40ZDgwNTgxMjE2NzggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jlc19jdXJzb3IuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKPiBAQCAtNTQsMTEgKzU0LDEyIEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBhbWRncHVfcmVzX2ZpcnN0KHN0cnVjdCB0dG1fcmVzb3VyY2Ug
KnJlcywKPiAgIHsKPiAgICAgICAgICBzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGU7Cj4KPiAtICAg
ICAgIGlmICghcmVzKSB7Cj4gKyAgICAgICBpZiAoIXJlcyB8fCByZXMtPm1lbV90eXBlID09IFRU
TV9QTF9TWVNURU0pIHsKPiAgICAgICAgICAgICAgICAgIGN1ci0+c3RhcnQgPSBzdGFydDsKPiAg
ICAgICAgICAgICAgICAgIGN1ci0+c2l6ZSA9IHNpemU7Cj4gICAgICAgICAgICAgICAgICBjdXIt
PnJlbWFpbmluZyA9IHNpemU7Cj4gICAgICAgICAgICAgICAgICBjdXItPm5vZGUgPSBOVUxMOwo+
ICsgICAgICAgICAgICAgICBCVUdfT04ocmVzICYmIHN0YXJ0ICsgc2l6ZSA+IHJlcy0+bnVtX3Bh
Z2VzIDw8IFBBR0VfU0hJRlQpOwoKRWl0aGVyIGRyb3AgdGhhdCBvciBtYWtlIGl0IGp1c3QgYSBX
QVJOX09OKCksIEJVR19PTigpIGlzIGNlcnRhaW5seSB0byAKaGFyZCBoZXJlLgoKV2l0aCB0aGF0
IGZpeGVkIHRoYXQgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+CgpDaHJpc3RpYW4uCgo+ICAgICAgICAgICAgICAgICAgcmV0
dXJuOwo+ICAgICAgICAgIH0KPgo+IC0tCj4gMi4yNS4xCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
