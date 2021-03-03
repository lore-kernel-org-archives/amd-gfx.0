Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF716C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7416F64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7416F64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF94B6E3C6;
	Wed,  3 Mar 2021 12:46:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C868F6E3C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 12:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqmZBBI7C8fAmW7IlPa5eiILknpNkkgDezoyCjJprrKFBwrNN/COmGvamA1sQpNM30MuhlA6e+sRDsmQhQcKZNDGrZ/9c0/ecTyaMAuNwfltowTMm4Z0K/2lVLCh92l5WetOvnaQVc5dcycfxVR8pEV7avd6Vs/gcpKlGRmNiec6iKRsYTqplCvN1Nu7x/bj/9DLsKnl/i+MiErjb2/ESoT1Fg1ixC87EJOcXDt+D0kQyTw8xl+DKFOa4Lo9TonbT1qxiFtQLFYC4qbwfWZpk3jF7fUGC36P5+4mctQHZ02VU6GtttRTC5C2aJ7D1KXdR7APAb+H4xaqgPY71HcZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk5Z860YS6TBBZUkMFHDA2FVS+BBKKjEKeXQowjL2IU=;
 b=GzrEvxzIaos5KiKzGUWsRP7c0mEfAc0nRmiD/qKvaxzvV1KZOlM/EdOQ4IvDRIIbt9iSqDcPY9Elg6X1K0WpLbbChCemm7nvCXe0kzRb3WanOARDX/GVS28fKV7Yp++wDFTBetCaQTUeec5P5v9gUd6Bs10wbKOdv9FyN9V6Qv1vFoPS6Tyi7HXGYvWOnPZ15fnIwVv+KVd7lRMiYCbFst2ACzM9mKdMpy3w+kvcUri8MLSezqbDMAoMCBnuQKbCO0LqzABnPo3tN8XH9dGj//0zDXWS7wrpqVh6Z4W4c14krzqJtr+hlnjLbFxxMHW4FXlcDXgxaP6Hv+9hKPtVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk5Z860YS6TBBZUkMFHDA2FVS+BBKKjEKeXQowjL2IU=;
 b=tViUu8Rq0hUozCuYrqQQmVePpD1flrz1BgaSY2cgtLGUFBNaY1DzX5lK4Dn6rblb+UzHcXKa5/tI3YBvkKMnUOSRqd40rHxh/HG1XOAPmiHhsy+UMIhkCOTQTV5yS6wkgAoV53sm80/qcwvfs5Yiz2i3qfh9wfSqzJNfvFHYmjU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4847.namprd12.prod.outlook.com (2603:10b6:208:1ba::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 12:46:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 12:46:07 +0000
Subject: Re: [PATCH v2 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
To: Nirmoy <nirmodas@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Felix.Kuehling@amd.com
References: <20210303092550.110816-1-nirmoy.das@amd.com>
 <20210303092550.110816-2-nirmoy.das@amd.com>
 <eb637494-e025-8231-94c4-46929bc76644@gmail.com>
 <9dd86d5a-4c36-9ce6-f516-d0777259131e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6bb44541-6ce3-fef6-0dd3-48feadca90af@amd.com>
Date: Wed, 3 Mar 2021 13:46:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9dd86d5a-4c36-9ce6-f516-d0777259131e@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fea4:8409:66bb:aad2]
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fea4:8409:66bb:aad2]
 (2a02:908:1252:fb60:fea4:8409:66bb:aad2) by
 AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 12:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0910d3d7-07c2-49ea-315f-08d8de42506a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4847897449B0FEAAA3D1AABD83989@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQJfJpVgH/MTYhWA2tsk3C2JdpCo90alyWIjgsBcEZxar2iT9qt+MCkw4ID5BzZkHxStsq2cd9grhqPfMwdMrMayQor5gZS3cqD1XfsLnor8SLBsHIcSbIPtsBaDo4pGXp42vT2SUXNt29lM1ZPMzEi2vG0NE8UstgVV0iZewrk/IbN64IJU1FSjSwJFi8YEeRdB6ZqwsigPfZgthPfnZAxTZRnklHnui7c2AD6KKKb1jce34MAiSs5ZVuznrWylzn4WvG9PbZWmNoNbkkY+gZO1qeTgFK/eZ1nzpq7Q0N+3NQUNe8XjsWjWMJSpibEW0IDKSw1iLlZOI5J9gVfYITRObIXP7V0in0UtitHAMlMqjVoGkduEQWu2WbG1NjHKZcwZReFaWnCzf2YhKa+bQCulbm+2W4tAng2lu3HcPFqbSXMCB51N9uP6yMAo7hAKGlMLVrXCFSRz3igXL42S4lRD2Khs1YHfi/5gITF6ZWGFa/uGMnCk0YIms6rwZ83QMo86cLpxtNviUqz+4VRUI/paDpZIqAZnoVFyPt78OscyQ31AHIMksARJgMofgJvT3y39Xmem5KOBSj3Iz07VoKsYEN3ko4EQTO7ceUJMfqjfy0NreMM3EMvEvXpvre2z261BkZNNjTMbD6Tl1bVV3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(4326008)(66946007)(6636002)(66476007)(66556008)(8676002)(6486002)(2616005)(45080400002)(6666004)(966005)(478600001)(316002)(31686004)(86362001)(110136005)(31696002)(5660300002)(2906002)(52116002)(83380400001)(8936002)(186003)(16526019)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2txc0F3UURwUGozK0FINXlwZTNXQ3JsSEswOU03N3JXR09JSUlLNVZoY3Zq?=
 =?utf-8?B?RFBOaVFZclpFZWFQWnBZZDYzakRER1UvdjdSZW9Rd1l4MEcxODJLa1drcjlI?=
 =?utf-8?B?SHJGRU5KSlNBYUc2bnJVNVZPeHJQVGlXN0dDemRUUy9CT1dNaEJzQXh0OVV4?=
 =?utf-8?B?eldoS0hNMmt5MHYzaUtyU0diS0ZJRE1XQXhrajNBZkxKcTVTcjJ3ZVRJY3Ny?=
 =?utf-8?B?cU5ZcEFZZmhrRk9VemF5VU5YWjlCVjRMaUFDQUd6Y1BwcDdYOEVrNjZoQUFL?=
 =?utf-8?B?U0ZxWUxsSDZzUzgwcm1RNTZmT2orcEQvV1o3M3dxY2lzUHUvZkZ4WVluNk10?=
 =?utf-8?B?TE1NY1NXM3ZZUGM2TlVSTlY4OEtIdGlEakpjMEZITE1nbGt5NnJXN25ITlJj?=
 =?utf-8?B?V3cvL2R4REYzWFFvYnhVM0orVTFpTlkrdXd6eDFGRlhaYzh4eUl6RDJZZ2V6?=
 =?utf-8?B?RWdXWmdJazN6MnJJZUxEWXNDV1FYTmJ1eXdnRm1jNi9MazJIRHNwbm9PSVk2?=
 =?utf-8?B?VlFwdVFZS3VBYTBJWGNZYjlkcHNqcDMvSDhaTm9BK0pRdFNVa2N0WTA0dE4v?=
 =?utf-8?B?SVZjdksrTlYrSlFnRnJCRDhaMHVoakZPVFpmLzNYSTM1NEVicGNkMFVZTXJo?=
 =?utf-8?B?NkhDdEVmNTdMblBqNVYzd0dGTVREOHp0WnhYaGxCT2dwWVZHQ0poZ3d6UDYy?=
 =?utf-8?B?WHBtbi9takJjWmg0UG9wQnpBdWNtMHJkeC94T25WRGJzTzdoYXZDTFM4WUdo?=
 =?utf-8?B?d3JoU2VqUXdBN2E5c3NoNHJpNG5KdFJIeEdxQmM5MjNGSWxzc05BRTFseFhq?=
 =?utf-8?B?L0s0TDQyVmU2bWdjQUJjZStJc1loaVlRQ2dwYndCK0JSYlJaZnYrTXkwVmZT?=
 =?utf-8?B?WFRmN2RldW14SDNGTWhqdE4zeUtmKy9MUDZpOU5NalB5Q0hSMndHV3IvSGYy?=
 =?utf-8?B?SHVlMUN6UTB1VlFVanVzb0o1VzRCdG9Ka3BBbGRhU2g4dDFhN3hZUjRqOFJE?=
 =?utf-8?B?M3I3ZnltT3FPYXkySFlZanpLQUtJZHJmNFc3d2g2eVpXeFQvVmxaM1ZsVjNj?=
 =?utf-8?B?VWwzdmxUOGZmTis2VTVGWUMzNnRnTTRFek05OUxMM0pUQ0dkSk5VR0N0VEJG?=
 =?utf-8?B?M1p4VExOMlBVek93QXpvd2hldzN4QXdaWUE2c2J5MVo0UjVpQ3ZxcW5LSmNk?=
 =?utf-8?B?MWxwem1VUUxUakxCNUpCWmpUQWo1Q2Y5NExJYm90TjVmYjB2c1J1dlNDSzBY?=
 =?utf-8?B?NGxIR0YrVkRaaEM4MU5sYVFlNnBVVGVZMVE5OWtVeUNWOU5xeVZQeDE1RE5F?=
 =?utf-8?B?NUtNcGNhTEJRVERaNHlCTlhkSGdFQnI0dmRWaUNySy9qOU8yWTNIMGYxSms5?=
 =?utf-8?B?djFydlFyaWQvblJHSkxYMWMzWGVSOGpXWGtJYUNJY2kxbS9EdWh3cEJkRFpB?=
 =?utf-8?B?TzJWY3h2ak03TXR2YVNuSUUxaml6alVXVTFveEoxZngvSmVRU3JhZEtKTnFI?=
 =?utf-8?B?NjBVQ000TUYxM0VCVGpKZEtaR21xTElQd3VjTE5LaVJJSWVkWnlYNFJaclE3?=
 =?utf-8?B?b3l3TFpoc1oycExZbll6eE5uL1M5V3JwRTNVekxXSWQwaUs5NkFsTzVpdmdh?=
 =?utf-8?B?b0gxaG9IOTh1SnNMQXFCUWpFSjlRVHJJRW8wbjFhU3JNRWsxaDNsUXY2WGRJ?=
 =?utf-8?B?bjdRVWN5Q255MHYrS0Q5L2FPUlFTQjN1NTBXZXEveDBaOTlZQUtOcUErd3VH?=
 =?utf-8?B?UGpxbjRTQ25XYlpwTnFKYXovbmJhWll1Y0dPWFgzdjIrNVRCb3ZXbmJzd25J?=
 =?utf-8?B?dVBNbC9ReDVuelhGVXp1V3BOdENmTS9mRkdPQlZYbVRhK2NhQldUaWVWTnZT?=
 =?utf-8?Q?wuW2HcUmOgyk5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0910d3d7-07c2-49ea-315f-08d8de42506a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 12:46:07.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR9ZCmihPBYQggSHXwCgj+Fw+T/U5JZBScWyh2qdZ5gEKuRmBwuuhZz2NhZayjhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwMy4wMy4yMSB1bSAxMzo0MSBzY2hyaWViIE5pcm1veToKPiBbU05JUF0KPj4KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpCj4+PiAr
ewo+Pj4gK8KgwqDCoCB1NjQgZmxhZ3MgPSBicC0+ZmxhZ3M7Cj4+PiArwqDCoMKgIGludCByOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBicC0+ZmxhZ3MgPSBicC0+ZmxhZ3MgJiB+QU1ER1BVX0dFTV9DUkVB
VEVfU0hBRE9XOwo+Pj4gK8KgwqDCoCBicC0+ZmxhZ3MgPSBicC0+ZmxhZ3MgfCBBTURHUFVfR0VN
X0NSRUFURV9LRkQ7Cj4+PiArwqDCoMKgIHIgPSBhbWRncHVfYm9fZG9fY3JlYXRlKGFkZXYsIGJw
LCBib19wdHIpOwo+Pj4gK8KgwqDCoCBpZiAocikKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
cjsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1NIQURP
VykgJiYgIShhZGV2LT5mbGFncyAmIAo+Pj4gQU1EX0lTX0FQVSkpIHsKPj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoIWJwLT5yZXN2KQo+Pj4gKyBXQVJOX09OKGRtYV9yZXN2X2xvY2soKCpib19wdHIp
LT50Ym8uYmFzZS5yZXN2LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxMKSk7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgciA9
IGFtZGdwdV9ib19jcmVhdGVfc2hhZG93KGFkZXYsIGJwLT5zaXplLCAqYm9fcHRyKTsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWJwLT5yZXN2KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZG1hX3Jlc3ZfdW5sb2NrKCgqYm9fcHRyKS0+dGJvLmJhc2UucmVzdik7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHIpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRn
cHVfYm9fdW5yZWYoYm9fcHRyKTsKPj4+ICvCoMKgwqAgfQo+Pgo+PiBJIGRvbid0IHRoaW5rIHRo
ZSBLRkQgc2hvdWxkIGV2ZXIgaGF2ZSBhIHJlYXNvbiB0byB1c2UgdGhlIHNoYWRvdyAKPj4gYnVm
ZmVyIGZ1bmN0aW9uYWxpdHkuCj4KPgo+IFRoaXMgaXMgaW50ZXJlc3RpbmcsIEkgZGlkbid0IGtu
b3cuIEkgd2lsbCByZW1vdmUgCj4gYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coKS4KCldlbGwgdGhl
IFZNIGNvZGUgaXMgdXNpbmcgdGhlIHNoYWRvdyBzdHVmZi4KCj4KPgo+Pgo+Pj4gKwo+Pj4gK8Kg
wqDCoCByZXR1cm4gcjsKPj4+ICt9Cj4+PiArCj4+PiArCj4+PiDCoCAvKioKPj4+IMKgwqAgKiBh
bWRncHVfYm9fdmFsaWRhdGUgLSB2YWxpZGF0ZSBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QK
Pj4+IMKgwqAgKiBAYm86IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciBvYmplY3QKPj4+IEBAIC0xMzA5
LDcgKzEzNTUsNyBAQCB2b2lkIGFtZGdwdV9ib19yZWxlYXNlX25vdGlmeShzdHJ1Y3QgCj4+PiB0
dG1fYnVmZmVyX29iamVjdCAqYm8pCj4+Pgo+Pj4gwqDCoMKgwqDCoCBhYm8gPSB0dG1fdG9fYW1k
Z3B1X2JvKGJvKTsKPj4+Cj4+PiAtwqDCoMKgIGlmIChhYm8tPmtmZF9ibykKPj4+ICvCoMKgwqAg
aWYgKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9LRkQpCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgYW1kZ3B1X2FtZGtmZF91bnJlc2VydmVfbWVtb3J5X2xpbWl0KGFibyk7Cj4+Pgo+Pj4g
wqDCoMKgwqDCoCAvKiBXZSBvbmx5IHJlbW92ZSB0aGUgZmVuY2UgaWYgdGhlIHJlc3YgaGFzIGlu
ZGl2aWR1YWxpemVkLiAqLwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuaCAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5oCj4+PiBpbmRleCA4Y2Q5NmM5MzMwZGQuLjY2NWVlMDAxNWYwNiAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4+PiBAQCAt
MjQ1LDYgKzI0NSw5IEBAIHZvaWQgYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihzdHJ1
Y3QgCj4+PiBhbWRncHVfYm8gKmFibywgdTMyIGRvbWFpbik7Cj4+PiDCoCBpbnQgYW1kZ3B1X2Jv
X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpOwo+Pj4gK2ludCBhbWRn
cHVfa2ZkX2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpOwo+Pj4gwqAgaW50
IGFtZGdwdV9ib19jcmVhdGVfcmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHNp
emUsIGludCBhbGlnbiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHUzMiBkb21haW4sIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIsCj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIAo+Pj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+IGluZGV4IDdiMmRiNzc5ZjMxMy4uMDMw
YmVjMzgyZjU0IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMKPj4+IEBAIC0xNjQsNyArMTY0LDcgQEAgc3RhdGljIGludCBhbWRncHVfdmVyaWZ5X2FjY2Vz
cyhzdHJ1Y3QgCj4+PiB0dG1fYnVmZmVyX29iamVjdCAqYm8sIHN0cnVjdCBmaWxlICpmaWxwKQo+
Pj4gwqDCoMKgwqDCoMKgICogRG9uJ3QgdmVyaWZ5IGFjY2VzcyBmb3IgS0ZEIEJPcy4gVGhleSBk
b24ndCBoYXZlIGEgR0VNCj4+PiDCoMKgwqDCoMKgwqAgKiBvYmplY3QgYXNzb2NpYXRlZCB3aXRo
IHRoZW0uCj4+PiDCoMKgwqDCoMKgwqAgKi8KPj4+IC3CoMKgwqAgaWYgKGFiby0+a2ZkX2JvKQo+
Pj4gK8KgwqDCoCBpZiAoYWJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0tGRCkKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Cj4+PiDCoMKgwqDCoMKgIGlmIChhbWRncHVf
dHRtX3R0X2dldF91c2VybW0oYm8tPnR0bSkpCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2RybS9hbWRncHVfZHJtLmggCj4+PiBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4+
PiBpbmRleCA4YjgzMmY3NDU4ZjIuLmY1MTBlODMwMjIyOCAxMDA2NDQKPj4+IC0tLSBhL2luY2x1
ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4+PiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdw
dV9kcm0uaAo+Pj4gQEAgLTE0Miw2ICsxNDIsMTEgQEAgZXh0ZXJuICJDIiB7Cj4+PiDCoMKgICov
Cj4+PiDCoCAjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRMKgwqDCoMKgwqDCoMKg
ICgxIDw8IDEwKQo+Pj4KPj4+ICsvKiBGbGFnIHRoYXQgdGhlIGFsbG9jYXRpbmcgQk8ncyB1c2Vy
IGlzIEtGRC4gSXQgc2hvdWxkIG5ldmVyIGJlIAo+Pj4gdXNlZCBieQo+Pj4gKyAqIHVzZXIgc3Bh
Y2UgYXBwbGljYXRpb25zCj4+PiArICovCj4+PiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9L
RkTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxIDw8IDIwKQo+Pgo+PiBXaHkgMjA/IDExIGlzIHRo
ZSBuZXh0IG9uZSBoZXJlLgo+Cj4KPiBJIGZlZWwgQk8gb3duZXIgZmxhZyBpcyBkaWZmZXJlbnQg
dGhhbiBvdGhlcnMgc28gd2FudGVkIHRvIHJlc2VydmUgCj4gc29tZSBiaXRzIGZvciBncm91cGlu
Zy4KPgo+IEkgY2FuIGFzc2lnbiBpdCB0byAxMSBpZiB0aGF0IG1ha2VzIG1vcmUgc2Vuc2UuCgpX
ZSBhbHJlYWR5IGhhdmUgb3RoZXIgZmxhZ3Mgd2hpY2ggdXNlcnNwYWNlIGlzIG5vdCBhbGxvd2Vk
IHRvIHVzZSwgc28gCnRoaXMgaXMgbm90aGluZyBzcGVjaWFsIGhlcmUuCgpDaHJpc3RpYW4uCgo+
Cj4KPiBUaGFua3MsCj4KPiBOaXJtb3kKPgo+Cj4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gKwo+
Pj4gwqAgc3RydWN0IGRybV9hbWRncHVfZ2VtX2NyZWF0ZV9pbsKgIHsKPj4+IMKgwqDCoMKgwqAg
LyoqIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHNpemUgKi8KPj4+IMKgwqDCoMKgwqAgX191NjQgYm9f
c2l6ZTsKPj4+IC0tIAo+Pj4gMi4zMC4xCj4+Pgo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Au
b3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbmly
bW95LmRhcyU0MGFtZC5jb20lN0M1YzQxZWU5MDMyZGY0NWUzNmYxNTA4ZDhkZTNjMGM1NyU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1MDM2OTY3NzY0Mzc3
NzMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9MUxi
YW9yNUN1QlVzbnhyJTJCUWdCNnpEWWJSUVZQV29ndGg3Z3BJT2hZUkZJJTNEJmFtcDtyZXNlcnZl
ZD0wIAo+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
