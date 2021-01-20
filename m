Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF60C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 14:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652332336E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 14:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652332336E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E669989F8E;
	Wed, 20 Jan 2021 14:45:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D9C89F8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 14:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkEn9JCYqDm0E/MkXQywSgJV3KtpPnvUSQRLbubowKDs9AJ6eEZY+W1/4VvnCdvYjeb9UZFQDSps3IrdzMi0DpatoXaKo+fzimTiK0abBm4DBKKAjRTY7eAG15aDboSQkz2TUCn6PRkjMv60NaYoYzWsL5bO9RASsUCQP8ns0tIci6XsI0l1k7wxNosgkh6Vs6sEILP4Nnog8n7V6iyHn8FZISRIXnD3Uwasyu7s5lv37oTxOhcb0RoM4PvEDwcFZ5h50Oq/74e7YzFII7ASZnOCBMHOGareJUyYHnbWiBIn1L+JLRqCTcvbjA4v504/XcFq6IvznbZpXdB/Ekn0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trSJyFFZ4ONUg+tMA4ohI06+tSMt7XK7Yy64ZuEnT4s=;
 b=h3myVu/A8YIFwjdcdIbXtM+0/Ex8iJuIQl0XKut4jwYeCyietNyhf2jyYdSR++Wb5rTaIqxnS7CO0ow5aOvQUk5jI7sHYDond/pwZ08vQuXYdxA7jwU3y9JcJ7FsMrs9kcR79Vad1Uz5I4HhgEedF/v69SHOI/zRabBcBTkT5msfLcRSwZEAsYW4m0V61vPcwioTMsqf8rLW2Rrrvv1JNX/E3wmC6xIsw955Y6D5qj6aWK+cazLhwoRG40sXcD9s2GkGicOfvrJUGX6v0eFssZuQe6s6zczURLi5DRy0qmmQg8QjScfKCdiSn8gKL5nl1z/ayzpIOZjGUwGdrGcE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trSJyFFZ4ONUg+tMA4ohI06+tSMt7XK7Yy64ZuEnT4s=;
 b=uXIPQX+Z5tQ795NWf+Upgl6PGE7L9l1ZSFp0Zwn2mPewe7e14cmahEfaT3Xh4Jeuai3W+olBIZRTFu4/sGDyPukIp4NOlBHif/BVIIRA/7PF48oxuD3SmWnJAUa6nm9471YnnRhIH5qFjgQRvB4MW0bugQc6lQqbY5wvzHHkm8g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 20 Jan
 2021 14:45:08 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 14:45:08 +0000
Subject: Re: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
 <fab8baec-78fa-d816-3e05-ad94215c83f2@gmail.com>
 <557da931-da68-2867-6f0b-611e1c4cd70b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <853286a7-8de6-fa09-25ea-4724d8acb8ff@amd.com>
Date: Wed, 20 Jan 2021 15:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <557da931-da68-2867-6f0b-611e1c4cd70b@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:208:d2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 14:45:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5b6d59a-85ed-4824-b717-08d8bd51fb04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43207E1C3F00BE892ABFF82B83A20@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nWf1CmLcItnPHgt6MWN6xP4sBmWbG1JuPTwLuRTG2LdWHz0J0yYRaxRtKV1gSSSv2nlKv+WbYw1oaJUIOgJk5oSXCDuLatO8z9Pb255brNHm8OwMc7ws9IE0cpRtAvctCHvmdju4hbOrPNlxT/bfIA4dvQV/bQKMCXBHU2ZpqfjRxYr2Lr2tEKLu0MsBHsRhYhoocumCF+x08UNhiPO3uysw2YsxLa99gcGT2fglz994NXy1eqDVlgeHsObQlm4EqXn2fCEP9VpTjdy6QdHwXkhCAlh5q5iy/G/uhjJoyvN3OBeO8VvKWRcvyjgH3SirrHSNdAj9qosjiA1qddrETNsJ8df8eXrYSfswip/BdoZ0x5L47+PJLR1M7jFY/G60OrxCMl4uUUgGNIKRLgI6ExRk2QApcWFnm3/kLMaFppHfpG3ds8Mkrf5GijPcTXYqqQhY2KPT7WVBR/kdRWD2Ea5z7MQy3Bdj2prNd8bykfcuMm34urMolhY3uNyeW7ZQM73XX7FG57gN7tNMh0YMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(53546011)(478600001)(6636002)(966005)(66476007)(316002)(5660300002)(110136005)(45080400002)(6486002)(86362001)(66574015)(2906002)(8936002)(66556008)(2616005)(83380400001)(16526019)(186003)(31696002)(36756003)(52116002)(8676002)(66946007)(4326008)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dDNMOEg0WjNGcnJIM3dWSXNiOWthRSt5aWgrV0w3NHgzVFVUYWwxV1dmdFZP?=
 =?utf-8?B?QWpqeHRwcDRCV0YrWkQ3WXh3VVpJMTlDdlVkSEwzSE1JQkNqNUt6VW1zZmpq?=
 =?utf-8?B?dndyU3UzUTJQdjF5NE50ZDRXaW5KVEREaGRFTHA5VGdLSUdFZkJJeVdSK3dX?=
 =?utf-8?B?UlNSelZEM05zZVlISDl1ZzVGbEtWVjZOSTVUaGdodWNtVXBsemZNbnNzVHdI?=
 =?utf-8?B?SzZUV3lub1NBczJueXhsNkJxazlFcHZkM0dLTlpSVmh5cFI3c292QUgwYVlo?=
 =?utf-8?B?T0ZxZEhJZlcrOVVPOXBVWHY2cHBXZ01xa2dTQ3N2d0tPL3Z4QXEwNSsxYm03?=
 =?utf-8?B?RHB3UzRPbmo5ZGFiL0FqT09EUUdZVmRVUnZlVElGa1VySlRIR3BBQzVKRGNO?=
 =?utf-8?B?RnZ4RXYrWk5vNENrMVVUSGt2QmR0d3NBZ2xHM3FlUk4zYW93NXFUSjhwL1ha?=
 =?utf-8?B?SjNNQU9EMzRvb21LbHZmTUFiR0tvQ3dzR01hV0dhYVVGUjA5bHJWM1ZLYnkw?=
 =?utf-8?B?YkZlL3dFa21ESzY2dUcxdEJTbnFNT1JDSnpyVmhlZmVlRWdYMTFWVUZ3RCtU?=
 =?utf-8?B?eno0ZCtGMWZvbG5aM1B3ZUh0WlUwb29sdlZkandxd3F5cVdaOVhWMzk4dnR0?=
 =?utf-8?B?TVB4Q2RnMjZXamd0THRzTkxxUUErTFlud2FwcmI0NmNzWU5WTVhEK0k4aE5s?=
 =?utf-8?B?VDRlMHR2QUNCcWwwbXBTSGlpbUtQRUJsZkZvODlhT0lnbW5vTC9DVFkzdTg2?=
 =?utf-8?B?djB5Y2drbnljRXlqdmxWeHhOOVhJRFhXbEUyR2M0Ui9YczE1bm9sVHpXVFM2?=
 =?utf-8?B?cDZEdXNUT1ovMDdyZ2RQUWQrczErVW5qVFN4T2xMc0RFMmhZbTkwRXd0eVhJ?=
 =?utf-8?B?Rlc3dTlpbXQ0eGtVd1RmMjhpQ1VhVFhrRW5Ta0QyQ3prTGQ0S05EdWJRaUdJ?=
 =?utf-8?B?VTNGT1d2T0h0c3lwdkF5MVN5SzdWbFkzVEREd1c2YnQ2amlxbVBzMWl5dlYx?=
 =?utf-8?B?MjMySFBOVFZXMXpodWNGd285cDlHM2N5V1VIR3lsbzM4Qkcyc3VjS2dsU1ZL?=
 =?utf-8?B?T1JzbXY4TFJweHhKd2h2V0dGVGRPYWlzc1U1Znc0WXhVdFBJeUJGZWVtQ3pp?=
 =?utf-8?B?a1NzdkVpTGp1M0lZdmRKQlZVRll5cFZmWkVVRm9pTUd6QTY0N0p3SlY5OUNE?=
 =?utf-8?B?eWt2NFE1dHgxQUtoM0d1Q09adzh0Yjh3Mm1yVlVMZCtjN0F0MUlrU3ZYNUhS?=
 =?utf-8?B?LzFhWjIvdlNZb080NGp4dUNzRkszWDhJTUtDUFNsdkF3bm9mazRzSisxVmJh?=
 =?utf-8?B?RjNsKzdlSWlHN2QxN0xSbGVxVVBIa3NmNFlRYlovV2RHdmFRaUFUV1RhOWdy?=
 =?utf-8?B?QXVlZmJrdWp1Q05KZ05FallWU3F6bC9OL1lZejBMUzMrRk9mRUFDQjdIUXhF?=
 =?utf-8?B?UG1FQ2FtNGhDaXZTdmk3V0N3MEwzTFVIZzBETUNZSk9zMGwyTnhYYVdHY1dT?=
 =?utf-8?Q?EjgfD7LDli6tjZAuW2BR7hgK08R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b6d59a-85ed-4824-b717-08d8bd51fb04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 14:45:07.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xipPJlS+SuCzi+tBfGWLUzcikpjumWzFaS/RfaFTuk96GdrKtCMb9me5ELzTO5lx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDEuMjEgdW0gMTU6MTYgc2NocmllYiBLYXpsYXVza2FzLCBOaWNob2xhczoKPiBPbiAy
MDIxLTAxLTIwIDU6MjYgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTkuMDEu
MjEgdW0gMjE6NDAgc2NocmllYiBCaGF3YW5wcmVldCBMYWtoYToKPj4+IEZyb206IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+Pj4KPj4+IFtXaHldCj4+PiBEQyBuZWVk
cyB0byBjb21tdW5pY2F0ZSB3aXRoIFBNIEZXIHRocm91Z2ggR1BVIG1lbW9yeS4gSW4gb3JkZXIK
Pj4+IHRvIGRvIHNvIHdlIG5lZWQgdG8gYmUgYWJsZSB0byBhbGxvY2F0ZSBtZW1vcnkgZnJvbSB3
aXRoaW4gREMuCj4+Pgo+Pj4gW0hvd10KPj4+IENhbGwgYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwg
dG8gYWxsb2NhdGUgR1BVIG1lbW9yeSBhbmQgdXNlIGEKPj4+IGxpc3QgaW4gYW1kZ3B1X2Rpc3Bs
YXlfbWFuYWdlciB0byB0cmFjayBvdXIgYWxsb2NhdGlvbnMgc28gd2UKPj4+IGNhbiBjbGVhbiB0
aGVtIHVwIGxhdGVyLgo+Pgo+PiBXZWxsIHRoYXQgbG9va3MgbGlrZSBjbGFzc2ljIG1pZC1sYXll
cmluZyB0byBtZSB3aXRoIGEgaG9ycmlibGUgCj4+IGltcGxlbWVudGF0aW9uIG9mIHRoZSBmcmVl
IGZ1bmN0aW9uLgo+Pgo+PiBDaHJpc3RpYW4uCj4KPiBGV0lXIHRoaXMgaXMgb25seSByZWFsbHkg
dXNlZCBkdXJpbmcgZGV2aWNlIGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbiAKPiBzbyB0aGUgb3Zl
cmhlYWQgb2YgdGhlIGZyZWUgZnVuY3Rpb24gaXNuJ3QgYSBjb25zaWRlcmFibGUgY29uY2Vybi4K
Pgo+IERvZXMgQU1ER1BVIGFsd2F5cyBuZWVkIHRvIGtub3cgdGhlIEdQVSBhZGRyZXNzIGZvciB0
aGUgYWxsb2NhdGlvbiB0byAKPiBmcmVlIG9yIHNob3VsZCB3ZSB3b3JrIG9uIGZpeGluZyB0aGUg
Y2FsbHNpdGVzIGZvciB0aGlzIHRvIHBhc3MgaXQgZG93bj8KCk5vLCB3ZSBvbmx5IG5lZWQgdG8g
a25vdyB0aGUgQk8uIFRoZSBHUFUgYWRkcmVzcyBwb2ludGVyIGlzIG9ubHkgcGFzc2VkIAppbiBz
byB0aGF0IGl0IGNhbiBiZSBzZXQgdG8gTlVMTCBhbmQgdGhlIENQVSBhZGRyZXNzIHBvaW50ZXIg
aXMgdXNlZCB0byAKanVkZ2UgaWYgd2UgbmVlZCB0byBrdW5tYXAoKSBvciBub3QuCgo+IFdlIGdl
bmVyYWxseSBzZXBhcmF0ZSB0aGUgQ1BVL0dQVSBwb2ludGVyIGJ1dCBtYXliZSBpdCdkIGJlIGJl
c3QgdG8gCj4gaGF2ZSBzb21lIHNvcnQgb2YgYWxsb2NhdGlvbiBvYmplY3QgaGVyZSB0aGF0IGhh
cyBib3RoIGZvciBEQydzIHB1cnBvc2VzLgoKWW91IG5lZWQgdG8gcGFzcyBhcm91bmQgZWl0aGVy
IHRoZSBCTyBwb2ludGVyIGRpcmVjdGx5IG9yIGEgc3RydWN0dXJlIApjb250YWluaW5nIGl0LCBi
dXQgdXNpbmcgdGhlIENQVSBtYXBwaW5nIGFkZHJlc3MgdG8gZGV0ZXJtaW5lIHRoZSBCTyBpcyAK
YSByZWFsbHkgbm8tZ28uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBOaWNo
b2xhcyBLYXpsYXVza2FzCj4KPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFu
ZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgLi4uL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHzCoCAyICsKPj4+IMKgIC4uLi9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaCB8wqAgOSArKysrKwo+Pj4gwqAgLi4u
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jIHwgNDAgCj4+PiArKysr
KysrKysrKysrKysrKy0tCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4+IGluZGV4IGU0OTBmYzI0ODZmNy4uODNl
YzkyYTY5Y2JhIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4gQEAgLTEwMTcsNiArMTAxNyw4IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2RtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+PiAqYWRldikKPj4+IMKg
wqDCoMKgwqAgaW5pdF9kYXRhLnNvY19ib3VuZGluZ19ib3ggPSBhZGV2LT5kbS5zb2NfYm91bmRp
bmdfYm94Owo+Pj4gK8KgwqDCoCBJTklUX0xJU1RfSEVBRCgmYWRldi0+ZG0uZGFfbGlzdCk7Cj4+
PiArCj4+PiDCoMKgwqDCoMKgIC8qIERpc3BsYXkgQ29yZSBjcmVhdGUuICovCj4+PiDCoMKgwqDC
oMKgIGFkZXYtPmRtLmRjID0gZGNfY3JlYXRlKCZpbml0X2RhdGEpOwo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggCj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmgKPj4+IGlu
ZGV4IDM4YmMwZjg4YjI5Yy4uNDkxMzc5MjRhODU1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAo+Pj4gQEAgLTEzMCw2
ICsxMzAsMTMgQEAgc3RydWN0IGFtZGdwdV9kbV9iYWNrbGlnaHRfY2FwcyB7Cj4+PiDCoMKgwqDC
oMKgIGJvb2wgYXV4X3N1cHBvcnQ7Cj4+PiDCoCB9Owo+Pj4gK3N0cnVjdCBkYWxfYWxsb2NhdGlv
biB7Cj4+PiArwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdDsKPj4+ICvCoMKgwqAgc3RydWN0
IGFtZGdwdV9ibyAqYm87Cj4+PiArwqDCoMKgIHZvaWQgKmNwdV9wdHI7Cj4+PiArwqDCoMKgIHU2
NCBncHVfYWRkcjsKPj4+ICt9Owo+Pj4gKwo+Pj4gwqAgLyoqCj4+PiDCoMKgICogc3RydWN0IGFt
ZGdwdV9kaXNwbGF5X21hbmFnZXIgLSBDZW50cmFsIGFtZGdwdSBkaXNwbGF5IG1hbmFnZXIgCj4+
PiBkZXZpY2UKPj4+IMKgwqAgKgo+Pj4gQEAgLTM1MCw2ICszNTcsOCBAQCBzdHJ1Y3QgYW1kZ3B1
X2Rpc3BsYXlfbWFuYWdlciB7Cj4+PiDCoMKgwqDCoMKgwqAgKi8KPj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGFtZGdwdV9lbmNvZGVyIG1zdF9lbmNvZGVyc1tBTURHUFVfRE1fTUFYX0NSVENdOwo+Pj4g
wqDCoMKgwqDCoCBib29sIGZvcmNlX3RpbWluZ19zeW5jOwo+Pj4gKwo+Pj4gK8KgwqDCoCBzdHJ1
Y3QgbGlzdF9oZWFkIGRhX2xpc3Q7Cj4+PiDCoCB9Owo+Pj4gwqAgZW51bSBkc2NfY2xvY2tfZm9y
Y2Vfc3RhdGUgewo+Pj4gZGlmZiAtLWdpdCAKPj4+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPj4+IGluZGV4IDMyNDRh
NmVhN2E2NS4uNWRjNDI2ZTZlNzg1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZWxwZXJzLmMKPj4+IEBA
IC02NTIsOCArNjUyLDMxIEBAIHZvaWQgKmRtX2hlbHBlcnNfYWxsb2NhdGVfZ3B1X21lbSgKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX3Qgc2l6ZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBs
b25nIGxvbmcgKmFkZHIpCj4+PiDCoCB7Cj4+PiAtwqDCoMKgIC8vIFRPRE8KPj4+IC3CoMKgwqAg
cmV0dXJuIE5VTEw7Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY3R4
LT5kcml2ZXJfY29udGV4dDsKPj4+ICvCoMKgwqAgc3RydWN0IGRhbF9hbGxvY2F0aW9uICpkYTsK
Pj4+ICvCoMKgwqAgdTMyIGRvbWFpbiA9ICh0eXBlID09IERDX01FTV9BTExPQ19UWVBFX0dBUlQp
ID8KPj4+ICvCoMKgwqDCoMKgwqDCoCBBTURHUFVfR0VNX0RPTUFJTl9HVFQgOiBBTURHUFVfR0VN
X0RPTUFJTl9WUkFNOwo+Pj4gK8KgwqDCoCBpbnQgcmV0Owo+Pj4gKwo+Pj4gK8KgwqDCoCBkYSA9
IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBkYWxfYWxsb2NhdGlvbiksIEdGUF9LRVJORUwpOwo+Pj4g
K8KgwqDCoCBpZiAoIWRhKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+Pj4gKwo+
Pj4gK8KgwqDCoCByZXQgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBzaXplLCBQQUdF
X1NJWkUsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRv
bWFpbiwgJmRhLT5ibywKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJmRhLT5ncHVfYWRkciwgJmRhLT5jcHVfcHRyKTsKPj4+ICsKPj4+ICvCoMKgwqAgKmFk
ZHIgPSBkYS0+Z3B1X2FkZHI7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChyZXQpIHsKPj4+ICvCoMKg
wqDCoMKgwqDCoCBrZnJlZShkYSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4+
PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgLyogYWRkIGRhIHRvIGxpc3QgaW4gZG0gKi8K
Pj4+ICvCoMKgwqAgbGlzdF9hZGQoJmRhLT5saXN0LCAmYWRldi0+ZG0uZGFfbGlzdCk7Cj4+PiAr
Cj4+PiArwqDCoMKgIHJldHVybiBkYS0+Y3B1X3B0cjsKPj4+IMKgIH0KPj4+IMKgIHZvaWQgZG1f
aGVscGVyc19mcmVlX2dwdV9tZW0oCj4+PiBAQCAtNjYxLDUgKzY4NCwxNiBAQCB2b2lkIGRtX2hl
bHBlcnNfZnJlZV9ncHVfbWVtKAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gZGNfZ3B1X21l
bV9hbGxvY190eXBlIHR5cGUsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqcHZNZW0pCj4+
PiDCoCB7Cj4+PiAtwqDCoMKgIC8vIFRPRE8KPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBjdHgtPmRyaXZlcl9jb250ZXh0Owo+Pj4gK8KgwqDCoCBzdHJ1Y3QgZGFsX2Fs
bG9jYXRpb24gKmRhOwo+Pj4gKwo+Pj4gK8KgwqDCoCAvKiB3YWxrIHRoZSBkYSBsaXN0IGluIERN
ICovCj4+PiArwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkoZGEsICZhZGV2LT5kbS5kYV9saXN0
LCBsaXN0KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHB2TWVtID09IGRhLT5jcHVfcHRyKSB7
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmRhLT5i
bywgJmRhLT5ncHVfYWRkciwgCj4+PiAmZGEtPmNwdV9wdHIpOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbGlzdF9kZWwoJmRhLT5saXN0KTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGtmcmVlKGRhKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAgfQo+Pj4gwqAgfQo+Pgo+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDEl
N0NuaWNob2xhcy5rYXpsYXVza2FzJTQwYW1kLmNvbSU3QzY1MDk2ZjFhMDViZjQzNzljMWNkMDhk
OGJkMmRkNWExJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzQ2NzM1MTg2MjYyMzgxOCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT1LcmYzZXBaJTJGc0FXT21IUmhVU3VrcUVqS0pKQkx3dEtORWU3R1dZS0JHMXcl
M0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
