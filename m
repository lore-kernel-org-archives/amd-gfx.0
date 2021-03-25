Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF9C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238A61A0D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238A61A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C032A6EDA9;
	Thu, 25 Mar 2021 16:10:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3A96ED92
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCq87m0vT8q8qyJjyZCEHzQuy52JO+CuzoVUa0wioQCxSajIeU1Vbqt8WcaDAJOqEtmA2SZpNZ/AivTFZ9ZK1baKxuUEgB/1tPqWGs9syL29PpLnfPsHluPvh+dazZHSEif6nH0RfMgIEUtenJMmLuU34OtU75pufrcgO9TwjItVdIgRO2C/Ire5j+5oLZwF9poBJ2eZHwDZ6orHBmcRYHzQragkwDtEp7Swm88J1NBPg5gpo29B9lBWqQx7xBbuFQSRnyaCuuc3tuCfjueQ9VHcWEgZ7jvTzzbcVhUc/pl+elfuQpI/BPQZQgNwYX1DwcBob2NgNYzLXreZ03RHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgRPu3TwYMaksfN03UDRQka3JX/dV4S5OE8vOnosU/Y=;
 b=ct2WzbsXmWJ1SABxcvZRUVVxBVEJ2TlmcrJb88c/2ciyw2nkYXE/SQj3ikueAXgaQntSIgED0TLJO1HJ0aMRzebIy19Ry4nsBVc9Z3ZYFhZjCLFz2rckew5s959wvOkTSeFMZel9kSmjY/FGLbmJ/EQoyWdWd9pJrxYn3b5r3exN/vslQhY9ThyJ74Te69eodejtVmCTNy4mxXpa6KC6w4vXSX1SumYAUlUbLco6v0wTMeiR12tjGaGkw0YKMQnW3Jdb9jBaJ0yxJoCB+0pj7MOjS9xG1wVvXMEgMU+J1DtK2t0T3CVGtW9DmEN/vtYMEV5jF33V0j5PCL9X8tMBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgRPu3TwYMaksfN03UDRQka3JX/dV4S5OE8vOnosU/Y=;
 b=BptVxsL95W4gOhXpceFDeXw/NkK1UOJHzQCJkC+YUDJYzTcBf5hMNOvSWNcNpT+xloiKOKkkLXgrSueE8xzjyLDMmWj32V3zXcj3Dmsqr47/x2cGsnfWanK8+uWIOYdKoqegPRpN7tF8c2dGE0cpSPSdULSIcn85JBpThBwnQEE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 25 Mar
 2021 16:10:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:10:53 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
Date: Thu, 25 Mar 2021 17:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
X-ClientProxiedBy: AM4PR0101CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:52c7:fa7f:c799:1b6d]
 (2a02:908:1252:fb60:52c7:fa7f:c799:1b6d) by
 AM4PR0101CA0068.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Thu, 25 Mar 2021 16:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b7f7e17-d92c-4c51-6353-08d8efa8904b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB496226D94F44B4015752269483629@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDPzG3rJupTZDd2dfLSWKduQQjgbPDCatyBkk4ykJ8bJzzj6F9yqOKHHraClJzex9WY1DJhD366MUcGoiDVbMHawhPhAXwM3xahAYewbmEF1xUlAxk7bWyfH3Oz21U0qB3Ty/pzWdQLQKyMaSrgO3OQHN9fNCe1hBQsdgCG4N5WrGaZWZfb2bRt5zO/Hc9w1imcDassaKNDo6DjgwBvHWQBqxwW2rx7woBCsiYEtawrLqXo4EkBxfO9n/zM3eOPEepAj5wl9vv2CoTWCLS02Hcgzo1SfK5p7FRgHrOxJ+ZofE8GMicp8QkKUu4AWbvQxuL8WSngz+FP6MZNOkNZ3XONY2L3Xs5mZzCFwYuHFPdFBGEZoeb4HV0T6Dg2TSeiCQJFmCb7LaAHM+UwXxuaRrpnYMtXT54eJPuo2LgG5pTbuAkQKZ1F/FfXKfSLPmTfBmeuJQAVXWueFTSwGf15ZeKGEY8DNEJS/QaCw1rRfQ8KZoXs1FNozTczT9gA4iyEBWWGcFkiTFdJwRCqem/MQE9bWX2c59EjyPzywZ3Mkcc/tIgKbVeHMeDZ3nY6ygvmKKpecmFrChsnqhehke5OFsZtY3eXC+k4OR5MfMBC7DBVX67WZx3ZdZQ7LsrCLXZn8hQLD5iQIjdEC8CXG5BVDtieWGQ/Kn4R0noBus0VL0ORrcUqJEacfC3rHzyg2Dxgu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(5660300002)(16526019)(38100700001)(36756003)(31686004)(31696002)(186003)(2906002)(6486002)(66946007)(2616005)(478600001)(66556008)(52116002)(66476007)(316002)(110136005)(8936002)(8676002)(6666004)(83380400001)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YjFUeWFJWGJlZVJLb2dKTi9EM01iTWF4ZUdJczhydHY1dzlCaUFFYU54VnVB?=
 =?utf-8?B?RUJvMkZVeG1KMU16Mm1zRGowZGZWYUIvM1ZwRGo4d3VTbk41K1ZiTkpIeno4?=
 =?utf-8?B?N3ZYVituTEMrM1pxOTMzcEwyMEZySjVtZk1haktTVW5pRWlwZ0N3Y2FtV3ZY?=
 =?utf-8?B?eE5rSzYvTVNsRm12Y1d3Tm9VTXRWVmtVZXNnNERqNW9sWE8ycFFiblRrQmZN?=
 =?utf-8?B?Y2llQXJNNWMxaktsZFEyMU5jV3EyOEdESmFjSHlmS1BMUVJrRU1ZWFIxamlI?=
 =?utf-8?B?U3plTnVsZzJhZHQ0T2I5N1JpRHZLUWE0M3IwcmthODgrSzBrYnQxZ093RFFi?=
 =?utf-8?B?UnJsR3NPWHFOT0R0Ulk2RVFkYysxemlJQ1kwZFlqMlFhcjRmQW5rMVlQSnkx?=
 =?utf-8?B?SURaaThyMVNsdHZBL0swUS9iMDVUV2kvTHRGZy9lbFRIRGIwRnJqMW8yTzVu?=
 =?utf-8?B?eDdrMHNjcUcvUjlEVXdyMEpQNlIyUk13NnJIWjdBTnpjeUQvM0VKTlFrMGE4?=
 =?utf-8?B?dElIcWlmL0VoOUFhOHpYODdHVGx0eWhMRGtIZzZDbWVpVVJrbmlCdFZNUGVL?=
 =?utf-8?B?NnVKZUllLy9WR09WSFFFaFdneEd3b0VwT2JjdEgwZ2NkK2grL3dCMVRMcWE2?=
 =?utf-8?B?bGtwNGJMREIzT3ZYTkorMGRmZVFrMkxMMW1tN3VMVHdOS0xBZEsza2tvM2J6?=
 =?utf-8?B?dGNDblVLRzVDbmQ1V0MzUVgrN3dCU2w0bVBXMkIzbHk0RUhmYWJ5M3ZRR21K?=
 =?utf-8?B?SlNLSmZxWlJOSm51ZTRaZWRkVVhLMENHZnFBYzJVWUhPNUozbnNnZk1qdzFs?=
 =?utf-8?B?aThHMEtkNm5vYnB5WmlHcFhnRWdIR0JwYkpDYVRiWDJKVFhaYUdOUkg1RWNL?=
 =?utf-8?B?aFltcXhZWDA5cVZ4b1RtRVR0bHc3WUhoOTI0TlhHWlBEZkpXdFVFZVVrRTY1?=
 =?utf-8?B?a2o4TnVyRElwWGw2WkhXUXdXSzlxM1dnWVBQcy90ODlJOGUyenRVZUpPbUVM?=
 =?utf-8?B?aENaNVJoM3FhYjRUK3RWM25vcGdraCtOTEVTZFNMa1V6QnRBWWRpV1I4cEZG?=
 =?utf-8?B?TkQwWVVlOXkraStnZ3NSMnloNjhqOUFZYytlRXBkWTRxTXB1cHFOZTArZEZX?=
 =?utf-8?B?R2tNQzIreEc2RUZhTkMvdW52UWc5YTRxaXdjd2R0SE82Y2k5SUlPaDRxSTFt?=
 =?utf-8?B?K2h2bGhYTE9CaEIrMUl3MVUwbElNYXlVMm5Od2VSWnpmRUpGZEdsUVg0Qmwv?=
 =?utf-8?B?aDR5T1JPV3VVOTdLSDBEYnpvYjFnQlM2UC9HSExST2VHdnRUaVp6K1dZQ1Nn?=
 =?utf-8?B?OTd2Qy9DVkVGRGNhRzFPdDY4OHhyaVdJeTNRdU51VnA1QW1sZ3hFR0xocFVh?=
 =?utf-8?B?dmhXN2s2NVgvc003eDcvZVhvdUJrcDI2Qnh2dElSbFRhZHUrM3gvWkZQbmQ4?=
 =?utf-8?B?cngrbVgwdkYyY2toNGtndXFhbFRKUU1WMlVoaXlyVks0YmVCV2wzZ0piODJz?=
 =?utf-8?B?WXF1OElnRnZOQ00wUFErdGg4K1JuOWhRUHlHMzdtbSszYS82bDhEWXJsQWMv?=
 =?utf-8?B?MXI2d1FncUh1R3V2aFNDQlAxeUxLS2tHNncrQm1NRUxqMG5HRmhHdU5lQVVU?=
 =?utf-8?B?VklaaW5ndi9pNjVHMXhyTCtxQjBqemhLWE1ZSlM1dituRmlhaWxGRlc3UGRp?=
 =?utf-8?B?S2IxSzBCUldWK25FbWxpNERTdzZSamJONjEvYWFVbHFETHZONzc5MXVpT1ox?=
 =?utf-8?B?UnBNblYrMi9FQ1dYN01CV3NtRmFKYklGajhKdVhrNThwZG5nS3VEVzBEWjkz?=
 =?utf-8?B?empVTVByWnIzekU4cExjRGQxNmxVSWk1WnA2WkpTWVVMVUU3UDU0UmJQY0Mv?=
 =?utf-8?Q?8fChUYvZSnc/f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7f7e17-d92c-4c51-6353-08d8efa8904b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:10:53.0337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RsJ/JyrgHJMUJtjpSPU0YKLT9gzJU+h3LL22s4M6ayEUcNj5WUFthXn/uDrbhYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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

CgpBbSAyNS4wMy4yMSB1bSAxNzowMyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEhpLAo+Cj4g
VGhpcyBpcyBhIGxvbmcgb25lIHdpdGggYSBwcm9wb3NhbCBmb3IgYSBwcmV0dHkgc2lnbmlmaWNh
bnQgcmVkZXNpZ24gb2YKPiBob3cgd2UgaGFuZGxlIG1pZ3JhdGlvbnMgYW5kIFZSQU0gbWFuYWdl
bWVudCB3aXRoIEhNTS4gVGhpcyBpcyBiYXNlZCBvbgo+IG15IG93biBkZWJ1Z2dpbmcgYW5kIHJl
YWRpbmcgb2YgdGhlIG1pZ3JhdGVfdm1hIGhlbHBlcnMsIGFzIHdlbGwgYXMKPiBBbGV4J3MgcHJv
YmxlbXMgd2l0aCBtaWdyYXRpb25zIG9uIEErQS4gSSBob3BlIHdlIGNhbiBkaXNjdXNzIHRoaXMg
bmV4dAo+IE1vbmRheSBhZnRlciB5b3UndmUgaGFkIHNvbWUgdGltZSBkbyBkaWdlc3QgaXQuCj4K
PiBJIGRpZCBzb21lIGRlYnVnZ2luZyB5ZXN0ZXJkYXkgYW5kIGZvdW5kIHRoYXQgbWlncmF0aW9u
cyB0byBWUkFNIGNhbgo+IGZhaWwgZm9yIHNvbWUgcGFnZXMuIFRoZSBjdXJyZW50IG1pZ3JhdGlv
biBoZWxwZXJzIGhhdmUgbWFueSBjb3JuZXIKPiBjYXNlcyB3aGVyZSBhIHBhZ2UgY2Fubm90IGJl
IG1pZ3JhdGVkLiBTb21lIG9mIHRoZW0gbWF5IGJlIGZpeGFibGUKPiAoYWRkaW5nIHN1cHBvcnQg
Zm9yIFRIUCksIG90aGVycyBhcmUgbm90IChsb2NrZWQgcGFnZXMgYXJlIHNraXBwZWQgdG8KPiBh
dm9pZCBkZWFkbG9ja3MpLiBUaGVyZWZvcmUgSSB0aGluayBvdXIgY3VycmVudCBjb2RlIGlzIHRv
byBpbmZsZXhpYmxlCj4gd2hlbiBpdCBhc3N1bWVzIHRoYXQgYSByYW5nZSBpcyBlbnRpcmVseSBp
biBvbmUgcGxhY2UuCj4KPiBBbGV4IGFsc28gcmFuIGludG8gc29tZSBmdW5ueSBpc3N1ZXMgd2l0
aCBDT1cgb24gQStBIHdoZXJlIHNvbWUgcGFnZXMKPiBnZXQgZmF1bHRlZCBiYWNrIHRvIHN5c3Rl
bSBtZW1vcnkuIEkgdGhpbmsgYSBsb3Qgb2YgdGhlIHByb2JsZW1zIGhlcmUKPiB3aWxsIGdldCBl
YXNpZXIgb25jZSB3ZSBzdXBwb3J0IG1peGVkIG1hcHBpbmdzLgo+Cj4gTWl4ZWQgR1BVIG1hcHBp
bmdzCj4gPT09PT09PT09PT0KPgo+IFRoZSBpZGVhIGlzLCB0byByZW1vdmUgYW55IGFzc3VtcHRp
b25zIHRoYXQgYW4gZW50aXJlIHN2bV9yYW5nZSBpcyBpbgo+IG9uZSBwbGFjZS4gSW5zdGVhZCBo
bW1fcmFuZ2VfZmF1bHQgZ2l2ZXMgdXMgYSBsaXN0IG9mIHBhZ2VzLCBzb21lIG9mCj4gd2hpY2gg
YXJlIHN5c3RlbSBtZW1vcnkgYW5kIG90aGVycyBhcmUgZGV2aWNlX3ByaXZhdGUgb3IgZGV2aWNl
X2dlbmVyaWMuCj4KPiBXZSB3aWxsIG5lZWQgYW4gYW1kZ3B1X3ZtIGludGVyZmFjZSB0aGF0IGxl
dHMgdXMgbWFwIG1peGVkIHBhZ2UgYXJyYXlzCj4gd2hlcmUgZGlmZmVyZW50IHBhZ2VzIHVzZSBk
aWZmZXJlbnQgUFRFIGZsYWdzLiBXZSBjYW4gaGF2ZSBhdCBsZWFzdCAzCj4gZGlmZmVyZW50IHR5
cGVzIG9mIHBhZ2VzIGluIG9uZSBtYXBwaW5nOgo+Cj4gICAxLiBTeXN0ZW0gbWVtb3J5IChTLWJp
dCBzZXQpCj4gICAyLiBMb2NhbCBtZW1vcnkgKFMtYml0IGNsZWFyZWQsIE1UWVBFIGZvciBsb2Nh
bCBtZW1vcnkpCj4gICAzLiBSZW1vdGUgWEdNSSBtZW1vcnkgKFMtYml0IGNsZWFyZWQsIE1UWVBF
K0MgZm9yIHJlbW90ZSBtZW1vcnkpCj4KPiBNeSBpZGVhIGlzIHRvIGNoYW5nZSB0aGUgYW1kZ3B1
X3ZtX3VwZGF0ZV9tYXBwaW5nIGludGVyZmFjZSB0byB1c2Ugc29tZQo+IGhpZ2gtYml0IGluIHRo
ZSBwYWdlc19hZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIEZvciB0aGUKPiBk
ZWZhdWx0IHBhZ2UgdHlwZSAoMCkgbm90aGluZyByZWFsbHkgY2hhbmdlcyBmb3IgdGhlIGNhbGxl
cnMuIFRoZQo+ICJmbGFncyIgcGFyYW1ldGVyIG5lZWRzIHRvIGJlY29tZSBhIHBvaW50ZXIgdG8g
YW4gYXJyYXkgdGhhdCBnZXRzCj4gaW5kZXhlZCBieSB0aGUgaGlnaCBiaXRzIGZyb20gdGhlIHBh
Z2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGluZyBjYWxsZXJzCj4gaXQncyBhcyBlYXN5IGFzIGNo
YW5naW5nIGZsYWdzIHRvICZmbGFncyAoYXJyYXkgb2Ygc2l6ZSAxKS4gRm9yIEhNTSB3ZQo+IHdv
dWxkIHBhc3MgYSBwb2ludGVyIHRvIGEgcmVhbCBhcnJheS4KClllYWgsIEkndmUgdGhvdWdodCBh
Ym91dCBzdHVmZiBsaWtlIHRoYXQgYXMgd2VsbCBmb3IgYSB3aGlsZS4KClByb2JsZW0gaXMgdGhh
dCB0aGlzIHdvbid0IHdvcmsgdGhhdCBlYXNpbHkuIFdlIGFzc3VtZSBhdCBtYW55IHBsYWNlcyAK
dGhhdCB0aGUgZmxhZ3MgZG9lc24ndCBjaGFuZ2UgZm9yIHRoZSByYW5nZSBpbiBxdWVzdGlvbi4K
CldlIHdvdWxkIHNvbWVob3cgbmVlZCB0byBjaGFuZ2UgdGhhdCB0byBnZXQgdGhlIGZsYWdzIGRp
cmVjdGx5IGZyb20gdGhlIApsb3cgYml0cyBvZiB0aGUgRE1BIGFkZHJlc3Mgb3Igc29tZXRoaW5n
IGluc3RlYWQuCgpDaHJpc3RpYW4uCgo+Cj4gT25jZSB0aGlzIGlzIGRvbmUsIGl0IGxlYWRzIHRv
IGEgbnVtYmVyIG9mIG9wcG9ydHVuaXRpZXMgZm9yCj4gc2ltcGxpZmljYXRpb24gYW5kIGJldHRl
ciBlZmZpY2llbmN5IGluIGtmZF9zdm06Cj4KPiAgICAqIFN1cHBvcnQgbWlncmF0aW9uIHdoZW4g
Y3BhZ2VzICE9IG5wYWdlcwo+ICAgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIHdp
dGhvdXQgc3BsaXR0aW5nIGl0LiBObyBtb3JlCj4gICAgICBzcGxpdHRpbmcgb2YgcmFuZ2VzIGlu
IENQVSBwYWdlIGZhdWx0cwo+ICAgICogTWlncmF0ZSBhIHBhcnQgb2YgYW4gc3ZtX3JhbmdlIGlu
IEdQVSBwYWdlIGZhdWx0IGhhbmRsZXIuIE5vIG1vcmUKPiAgICAgIG1pZ3JhdGluZyB0aGUgd2hv
bGUgcmFuZ2UgZm9yIGEgc2luZ2xlIHBhZ2UgZmF1bHQKPiAgICAqIFNpbXBsaWZpZWQgVlJBTSBt
YW5hZ2VtZW50IChzZWUgYmVsb3cpCj4KPiBXaXRoIHRoYXQsIHN2bV9yYW5nZSB3aWxsIG5vIGxv
bmdlciBoYXZlIGFuICJhY3R1YWxfbG9jIiBmaWVsZC4gSWYgd2UncmUKPiBub3Qgc3VyZSB3aGVy
ZSB0aGUgZGF0YSBpcywgd2UgbmVlZCB0byBjYWxsIG1pZ3JhdGUuIElmIGl0J3MgYWxyZWFkeSBp
bgo+IHRoZSByaWdodCBwbGFjZSwgdGhlbiBjcGFnZXMgd2lsbCBiZSAwIGFuZCB3ZSBjYW4gc2tp
cCBhbGwgdGhlIHN0ZXBzCj4gYWZ0ZXIgbWlncmF0ZV92bWFfc2V0dXAuCj4KPiBTaW1wbGlmaWVk
IFZSQU0gbWFuYWdlbWVudAo+ID09PT09PT09PT09PT09Cj4KPiBWUkFNIEJPcyBhcmUgbm8gbG9u
Z2VyIGFzc29jaWF0ZWQgd2l0aCBwcmFuZ2VzLiBJbnN0ZWFkIHRoZXkgYXJlCj4gImZyZWUtZmxv
YXRpbmciLCBhbGxvY2F0ZWQgZHVyaW5nIG1pZ3JhdGlvbiB0byBWUkFNLCB3aXRoIHJlZmVyZW5j
ZQo+IGNvdW50IGZvciBlYWNoIHBhZ2UgdGhhdCB1c2VzIHRoZSBCTy4gUmVmIGlzIHJlbGVhc2Vk
IGluIHBhZ2UtcmVsZWFzZQo+IGNhbGxiYWNrLiBXaGVuIHRoZSByZWYgY291bnQgZHJvcHMgdG8g
MCwgZnJlZSB0aGUgQk8uCj4KPiBWUkFNIEJPIHNpemUgc2hvdWxkIG1hdGNoIHRoZSBtaWdyYXRp
b24gZ3JhbnVsYXJpdHksIDJNQiBieSBkZWZhdWx0Lgo+IFRoYXQgd2F5IHRoZSBCTyBjYW4gYmUg
ZnJlZWQgd2hlbiBtZW1vcnkgZ2V0cyBtaWdyYXRlZCBvdXQuIElmIG1pZ3JhdGlvbgo+IG9mIHNv
bWUgcGFnZXMgZmFpbHMgdGhlIEJPIG1heSBub3QgYmUgZnVsbHkgb2NjdXBpZWQuIEFsc28gc29t
ZSBwYWdlcwo+IG1heSBiZSByZWxlYXNlZCBpbmRpdmlkdWFsbHkgb24gQStBIGR1ZSB0byBDT1cg
b3Igb3RoZXIgZXZlbnRzLgo+Cj4gRXZpY3Rpb24gbmVlZHMgdG8gbWlncmF0ZSBhbGwgdGhlIHBh
Z2VzIHN0aWxsIHVzaW5nIHRoZSBCTy4gSWYgdGhlIEJPCj4gc3RydWN0IGtlZXBzIGFuIGFycmF5
IG9mIHBhZ2UgcG9pbnRlcnMsIHRoYXQncyBiYXNpY2FsbHkgdGhlIG1pZ3JhdGUuc3JjCj4gZm9y
IHRoZSBldmljdGlvbi4gTWlncmF0aW9uIGNhbGxzICJ0cnlfdG9fdW5tYXAiLCB3aGljaCBoYXMg
dGhlIGJlc3QKPiBjaGFuY2Ugb2YgZnJlZWluZyB0aGUgQk8sIGV2ZW4gd2hlbiBzaGFyZWQgYnkg
bXVsdGlwbGUgcHJvY2Vzc2VzLgo+Cj4gSWYgd2UgY2Fubm90IGd1YXJhbnRlZSBldmljdGlvbiBv
ZiBwYWdlcywgd2UgY2Fubm90IHVzZSBUVE0gZm9yIFZSQU0KPiBhbGxvY2F0aW9ucy4gTmVlZCB0
byB1c2UgYW1kZ3B1X3ZyYW1fbWdyLiBOZWVkIGEgd2F5IHRvIGRldGVjdCBtZW1vcnkKPiBwcmVz
c3VyZSBzbyB3ZSBjYW4gc3RhcnQgZXZpY3RpbmcgbWVtb3J5Lgo+Cj4gUmVnYXJkcywKPiAgwqAg
RmVsaXgKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
