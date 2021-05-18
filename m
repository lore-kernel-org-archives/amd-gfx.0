Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0103161074
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 17:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0103161074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7036EC54;
	Tue, 18 May 2021 17:43:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23E36EC51;
 Tue, 18 May 2021 17:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2HkNoXrJLbpbkkiOLEPoNqsBb3NZXt4q+IM1/nAqnF73Vhj6HSU3OSYu9sIaFJyGKZk8at1U2uWecG8//mEcgR85BU0L2NSHid3EFCNIrfXoWVJBjMP7x5nq0mBe9oVMR8kra856URCQs9Yx0h9Fxd7O32EUHOUr2pUtXPi1YB8p/bbCreVvd3PdCIDdHjHiyHdMKEmGDEwVHZmmGDA/DgEX1ex6IEvZA2x63w6Wb7pv1sKJOgmZZYYyaTErczeOxuIYk6T7QUqRrsE5UJ/p4+eQl86P6+TgyEc7Aqm93ROaaLMh/vhC3FDL5AZl9miJJgHO9U/y9l9mpIYMUqsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9L7RuK6eCW5VqUYX/8FyWgf8HfnYbt0wE7Ddukaavc=;
 b=eCooIxLK2pLhILd4B/UAsYOr6HuiYzy06bm3w2i9LZ0258swDGgC2bpgWYai4A3Cx0W5sG9AHx/dWXn/rCGmZ9uF6dXX/nZp0W+symYIJCSE5V9t9SisR6UAsShAiR3UBrQGlghrIBAaf6MmbPPWcsBBL55zxILbK/YuHlIe9SoVXqZMUuYql2qop95X6n6lwndax+2FM/JBRDZgpGre5i+c5ycHc4cwjo0XInT1X2iNRxl5v/CxZJmYb9jQXL2hfWUsqke6177CosgwtKVY675+dFfmhWfg7xvQvlIuk/Soj/23o3plNIMowFlcGJ0+3XRP0qhOgGRNNXdM9BSYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9L7RuK6eCW5VqUYX/8FyWgf8HfnYbt0wE7Ddukaavc=;
 b=uZtIGN1ruDF+8/OYDKLnYL+2r6zHhDpsxRnfL2oomUp01W7abBrOlbz1xSP1QlNa5nvn2vfTtPU/ezREjI6Xioo2SDPPhuBwJHPxKrgUT0gwXksELKkMuEetq6+wGuY3w/CKujLZg+yt2v6DgvkoiLuKIx7LzYWRwX4zgzwURGM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4591.namprd12.prod.outlook.com (2603:10b6:806:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 17:43:56 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 17:43:55 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
Date: Tue, 18 May 2021 13:43:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024]
 (2607:fea8:3edf:49b0:f8d5:c6ca:4eec:9024) by
 YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 18 May 2021 17:43:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6dbc476-2091-4a71-d809-08d91a248208
X-MS-TrafficTypeDiagnostic: SA0PR12MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4591D1504DC3E29EA4C49C30EA2C9@SA0PR12MB4591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrT43gFjdt+2nx9Cmr03Hxv1/UyDQFcd18wBLyitihfEb5h+B4i5nGrtW5jZ7zV1XOOxj5RfZlwhzADfeSiwvtLUfYCwXy7EoSsyeC5/H3B36XW+mOIlWLsJATb1R2uOUkaHhCICv+VNGuA2WDMaf5ETRojHvFr0kYZ+/Yfm5nWcyXl+BFEhkIco3Aa+uZYNgRpo31OR3aAl8QzZT8h5YC4JVRbYHSOdmmN0BkTpXJnDsUdcVFl2PFEnQxSSRDVU/gq/IOLzjIeLQbXMIE4BlU6HJ2A0u1DViAv10PqD8Iw4H7aiI1G2qFQqYu4daeSM9mPRfiH1MGy1ulqGa0klgdSCoruNkWytOfutILBKjqfTt8Rerarw0TsFmsErM3Gjy9vke4xRFDVDneIjDSnUVkb5J4DtV8ob2SdNHzcaW89Vy3GJJnoM0nMXRyN9PKBRyieRPyIwEFyCzRJGbMFTXAgnHkKHOrbl2YCPwKWdVzotxfhmqVf8YgfqnwbwM0PUv24b+qw5eNdU2JhYyh5Epiuj7hFFB7q109Kn4EUCOsDAULjkjFQ7gaMZ9fhn/v/E+4ez/oWbDdDKjyi9/yfKoA4qBg/+W94OeYw3l+KtV0aqiXNpuLgHa5S4me/mnxEjwCtHKDfTaoarqn4/GbhtpupLkHyfOo5Me4Mgp3YA6Wstdj2SkAsBFtwSLFnnz3dY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(66574015)(83380400001)(16526019)(478600001)(53546011)(86362001)(2906002)(5660300002)(38100700002)(6486002)(66476007)(36756003)(316002)(52116002)(31696002)(8936002)(8676002)(4326008)(6636002)(31686004)(66556008)(66946007)(44832011)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VzN4K1lEamdzaDZFRXhzOGh1b3krK0E0TE14V2ZaUHZPTzgzUENSdUZqSnBN?=
 =?utf-8?B?TmY5TkFlK090N01oeGw3RXNrODNQbkJhcDQySUlKVUhHc2ZubHoxY0loNjFT?=
 =?utf-8?B?OUxHUnNubWlPSHZzUU1zTVJGd0FLWFJCSjVYQndnSk1aUXQvSFhaZElJblFl?=
 =?utf-8?B?cnVuem50WTdVdkNaMXJ6UFlhVDFOcVRtOXNFUjFjekQzVS9IVm04K0JRRkdS?=
 =?utf-8?B?a1lzcCtHalhaM01WalE5MUVwU1gza3lWNXpvNFFNR21ETitmQ0hVVkl3UkY3?=
 =?utf-8?B?V2txeUpIZDJwSUZrZmtlZ0NOT2dkWTRQNDU5VjlGdi91MFJNWEhNRldIUnor?=
 =?utf-8?B?SzFEM2JJTW9ZVG5YVTlkcU9aejgzaCt4Z1ZmK09wY2tCNEtuOW4vemIzYVhi?=
 =?utf-8?B?VDVwaEFybmx0UWRPcWI5RThEcTRVWjhhd2I2N01oYXlOUWZINGNxUFEvcVFB?=
 =?utf-8?B?ZFFXMG8yMTIvNUdORWx0QWdBUmdhenJaYVRXdy9tbzFBUVFGUG5CdUlmUUw5?=
 =?utf-8?B?WjdaY2RrcEVBRVIvTnd0TWFmTDdZZ0Iybkk2clNRRHlYN1didFR1dEZOSFhU?=
 =?utf-8?B?VjduV0VRKzVkaHRvaWc3QzIraUY2RTFqUkFsQ3ZFNGpBR0VTNVVlYjk5MG45?=
 =?utf-8?B?TnhIdkZib1I1TWZ2dEE1MjU3aFAzZWp3QkhlMmIrNG53elNMZGtzMGxLZTlN?=
 =?utf-8?B?d1o4RnpNdVhmLzQvYlVmVWd2K0xOWm1kQ1RKZDJPMmx4cjE1WkhWZHRCeG1w?=
 =?utf-8?B?ZG5CZWJ1czZ2Z3ozYis5eDNIM2c4YmJZSGNHaWJYOHowOFpBR1FYdk5OVm9l?=
 =?utf-8?B?TTJoRE1zaGhFL05uQTFURFA3OXE4REJsa2cwOG1FdmpKYVl3cmRmelFBa0tZ?=
 =?utf-8?B?R0FQb3JaU09tODB1RzBIdFlzUkFMUVNGbVRIeGFjS203eU9rMmlFR3lwMWRS?=
 =?utf-8?B?T3ZXU0p2dkh4bWNDa3BjR3JGTExoM3BIYXJvZ1kyL3ZSYjhxcy8yRnRmYmJO?=
 =?utf-8?B?OWZOcFFpaHl0RkE0eEcvR3MxRmtvbUQxVXE1SkI3aTVMVEExdDJPZzNvampM?=
 =?utf-8?B?WGdGbkNjZ0FQaU5KdCtBanIrclRVVElOVk5TQlBZTEFUWjgzaHhGdUJOTmtp?=
 =?utf-8?B?WEptZThtWXFpSk03cDAzbkxQRjNpNzhFRG91blcyb2ZqblV5U3FaRjdsY2lB?=
 =?utf-8?B?UEVDUks5TGYxamJyM3ZBRmt2UXNqaFFhWnluOUxFNGhHV2xpMGNmS29na2Jy?=
 =?utf-8?B?NUEwbU1tRjJNeEVXTDJaU080Y2tjbkZRYXlNUjVrSXBtZGp0bXlYK1lKZk9v?=
 =?utf-8?B?alpMa2VHUTFVd3ptZkVXcDBJSmRMMzVhRFhKbVFMM1NnU1k1U2dLRENZc3ly?=
 =?utf-8?B?Snp3Rk9aVVorK0RTU1hYU285VTRZM0JiSmNwSzFpNGdieTkwdnNTL3ZTRjRh?=
 =?utf-8?B?cXZOSEtWODJzaFhocVdzZUtyM0pPQm9LSENQRUpENmprZU8zaEhBQ1ZkQWhl?=
 =?utf-8?B?OWxWd002YmRXOFBwejlSVkQrWEsyblhMcHcxcC9hT0V1dTh0TUNSeitIaUl0?=
 =?utf-8?B?WTJJNjdUMEFsTUx0cWc2SU04djl3ZE1Yay9hVFk1VGFXRHdDOUg2cm00Q3ps?=
 =?utf-8?B?ZjFLalhJVWJyMVN4NEhCenE0TmpYN1NpMHkvK3BXWG5QNTNyR0EreVRQcEF1?=
 =?utf-8?B?RW8zK2VqaXhUMmtRaHVUMHJkMEloUEh1QTczOFdxK1RXZjBBMU9aNzRQZGZx?=
 =?utf-8?B?Sm5lRlFnbGxGN0dYeEpmVVZGRG9XL2lwbnB1cmJKa0pTL1FiZUoxUGdZTndy?=
 =?utf-8?B?SnZLaDltRTR5RlJ6VDBwMUttRXJTK1d2MXoyS2R4bE5JOG4xQ1FseEphNFk1?=
 =?utf-8?Q?syA4qtFx9JhfC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dbc476-2091-4a71-d809-08d91a248208
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:43:55.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuxN5yrnmXvap/Fi8r4rKtpqWytJ+pTMRPN/3xPfpu+6gWLuSNSaENCOg14sORDCq/1ccZfbCBiJ0emodiMJwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4591
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDEyOjMzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0g
MTguMDUuMjEgdW0gMTg6MTcgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4KPj4KPj4gT24g
MjAyMS0wNS0xOCAxMToxNSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTgu
MDUuMjEgdW0gMTc6MDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pgo+Pj4+IE9uIDIw
MjEtMDUtMTggMTA6MDcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gSW4gYSBz
ZXBhcmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9yZSBpdGVyYXRlZCBvdmVy
IHRoZSAKPj4+Pj4gZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhlIGNvbmNs
dXNpb24gdGhhdCB0aGlzIAo+Pj4+PiBhcHByb2FjaCBoZXJlIHdvbid0IHdvcmsgcmVsaWFibGUu
Cj4+Pj4+Cj4+Pj4+IFRoZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2luZzoKPj4+Pj4gMS4gZGV2aWNl
IEEgc2NoZWR1bGVzIHNvbWUgcmVuZGVyaW5nIHdpdGggaW50byBhIGJ1ZmZlciBhbmQgZXhwb3J0
cyAKPj4+Pj4gaXQgYXMgRE1BLWJ1Zi4KPj4+Pj4gMi4gZGV2aWNlIEIgaW1wb3J0cyB0aGUgRE1B
LWJ1ZiBhbmQgd2FudHMgdG8gY29uc3VtZSB0aGUgcmVuZGVyaW5nLCAKPj4+Pj4gZm9yIHRoZSB0
aGUgZmVuY2Ugb2YgZGV2aWNlIEEgaXMgcmVwbGFjZWQgd2l0aCBhIG5ldyBvcGVyYXRpb24uCj4+
Pj4+IDMuIGRldmljZSBCIGlzIGhvdCBwbHVnZ2VkIGFuZCB0aGUgbmV3IG9wZXJhdGlvbiBjYW5j
ZWxlZC9uZXdlciAKPj4+Pj4gc2NoZWR1bGVkLgo+Pj4+Pgo+Pj4+PiBUaGUgcHJvYmxlbSBpcyBu
b3cgdGhhdCB3ZSBjYW4ndCBkbyB0aGlzIHNpbmNlIHRoZSBvcGVyYXRpb24gb2YgCj4+Pj4+IGRl
dmljZSBBIGlzIHN0aWxsIHJ1bm5pbmcgYW5kIGJ5IHNpZ25hbGluZyBvdXIgZmVuY2VzIHdlIHJ1
biBpbnRvIAo+Pj4+PiB0aGUgcHJvYmxlbSBvZiBwb3RlbnRpYWwgbWVtb3J5IGNvcnJ1cHRpb24u
Cj4+Cj4+IEJ5IHNpZ25hbGluZyBzX2ZlbmNlLT5maW5pc2hlZCBvZiB0aGUgY2FuY2VsZWQgb3Bl
cmF0aW9uIGZyb20gdGhlCj4+IHJlbW92ZWQgZGV2aWNlIEIgd2UgaW4gZmFjdCBjYXVzZSBtZW1v
cnkgY29ycnVwdGlvbiBmb3IgdGhlIHVuY29tcGxldGVkCj4+IGpvYiBzdGlsbCBydW5uaW5nIG9u
IGRldmljZSBBID8gQmVjYXVzZSB0aGVyZSBpcyBzb21lb25lIHdhaXRpbmcgdG8KPj4gcmVhZCB3
cml0ZSBmcm9tIHRoZSBpbXBvcnRlZCBidWZmZXIgb24gZGV2aWNlIEIgYW5kIGhlIG9ubHkgd2Fp
dHMgZm9yCj4+IHRoZSBzX2ZlbmNlLT5maW5pc2hlZCBvZiBkZXZpY2UgQiB3ZSBzaWduYWxlZAo+
PiBpbiBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9icyA/Cj4gCj4gRXhhY3RseSB0aGF0LCB5ZXMu
Cj4gCj4gSW4gb3RoZXIgd29yZHMgd2hlbiB5b3UgaGF2ZSBhIGRlcGVuZGVuY3kgY2hhaW4gbGlr
ZSBBLT5CLT5DIHRoZW4gbWVtb3J5IAo+IG1hbmFnZW1lbnQgb25seSB3YWl0cyBmb3IgQyBiZWZv
cmUgZnJlZWluZyB1cCB0aGUgbWVtb3J5IGZvciBleGFtcGxlLgo+IAo+IFdoZW4gQyBub3cgc2ln
bmFsZWQgYmVjYXVzZSB0aGUgZGV2aWNlIGlzIGhvdC1wbHVnZ2VkIGJlZm9yZSBBIG9yIEIgYXJl
IAo+IGZpbmlzaGVkIHRoZXkgYXJlIGVzc2VudGlhbGx5IGFjY2Vzc2luZyBmcmVlZCB1cCBtZW1v
cnkuCgpCdXQgZGlkbid0IEMgaW1wb3J0ZWQgdGhlIEJPIGZvcm0gQiBvciBBIGluIHRoaXMgY2Fz
ZSA/IFdoeSB3b3VsZCBoZSBiZQp0aGUgb25lIHJlbGVhc2luZyB0aGF0IG1lbW9yeSA/IEhlIHdv
dWxkIGJlIGp1c3QgZHJvcHBpbmcgaGlzIHJlZmVyZW5jZQp0byB0aGUgQk8sIG5vID8KCkFsc28g
aW4gdGhlIGdlbmVyYWwgY2FzZSwKZHJtX3NjaGVkX2VudGl0eV9maW5pLT5kcm1fc2NoZWRfZW50
aXR5X2tpbGxfam9icyB3aGljaCBpcwp0aGUgb25lIHdobyBzaWduYWxzIHRoZSAnQycgZmVuY2Ug
d2l0aCBlcnJvciBjb2RlIGFyZSBhcyBmYXIKYXMgSSBsb29rZWQgY2FsbGVkIGZyb20gd2hlbiB0
aGUgdXNlciBvZiB0aGF0IEJPIGlzIHN0b3BwaW5nCnRoZSB1c2FnZSBhbnl3YXkgKGUuZy4gZHJt
X2RyaXZlci5wb3N0Y2xvc2UgY2FsbGJhY2sgZm9yIHdoZW4gdXNlCnByb2Nlc3MgY2xvc2VzIGhp
cyBkZXZpY2UgZmlsZSkgd2hvIHdvdWxkIHRoZW4gYWNjZXNzIGFuZCBjb3JydXB0CnRoZSBleHBv
cnRlZCBtZW1vcnkgb24gZGV2aWNlIEEgd2hlcmUgdGhlIGpvYiBoYXNuJ3QgY29tcGxldGVkIHll
dCA/CgpBbmRyZXkKCj4gCj4gQ2hyaXN0aWFuLgo+IAo+Pgo+PiBBbmRyZXkKPj4KPj4+Pgo+Pj4+
Cj4+Pj4gSSBhbSBub3Qgc3VyZSB0aGlzIHByb2JsZW0geW91IGRlc2NyaWJlIGFib3ZlIGlzIHJl
bGF0ZWQgdG8gdGhpcyBwYXRjaC4KPj4+Cj4+PiBXZWxsIGl0IGlzIGtpbmQgb2YgcmVsYXRlZC4K
Pj4+Cj4+Pj4gSGVyZSB3ZSBwdXJlbHkgZXhwYW5kIHRoZSBjcml0ZXJpYSBmb3Igd2hlbiBzY2hl
ZF9lbnRpdHkgaXMKPj4+PiBjb25zaWRlcmVkIGlkbGUgaW4gb3JkZXIgdG8gcHJldmVudCBhIGhh
bmcgb24gZGV2aWNlIHJlbW92ZS4KPj4+Cj4+PiBBbmQgZXhhY3RseSB0aGF0IGlzIHByb2JsZW1h
dGljLiBTZWUgdGhlIGpvYnMgb24gdGhlIGVudGl0eSBuZWVkIHRvIAo+Pj4gY2xlYW5seSB3YWl0
IGZvciB0aGVpciBkZXBlbmRlbmNpZXMgYmVmb3JlIHRoZXkgY2FuIGJlIGNvbXBsZXRlZC4KPj4+
Cj4+PiBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9icygpIGlzIGFsc28gbm90IGhhbmRsaW5nIHRo
YXQgY29ycmVjdGx5IGF0IAo+Pj4gdGhlIG1vbWVudCwgd2Ugb25seSB3YWl0IGZvciB0aGUgbGFz
dCBzY2hlZHVsZWQgZmVuY2UgYnV0IG5vdCBmb3IgdGhlIAo+Pj4gZGVwZW5kZW5jaWVzIG9mIHRo
ZSBqb2IuCj4+Pgo+Pj4+IFdlcmUgeW91IGFkZHJlc3NpbmcgdGhlIHBhdGNoIGZyb20geWVzdGVy
ZGF5IGluIHdoaWNoIHlvdSBjb21tZW50ZWQKPj4+PiB0aGF0IHlvdSBmb3VuZCBhIHByb2JsZW0g
d2l0aCBob3cgd2UgZmluaXNoIGZlbmNlcyA/IEl0IHdhcwo+Pj4+ICdbUEFUQ0ggdjcgMTIvMTZd
IGRybS9hbWRncHU6IEZpeCBoYW5nIG9uIGRldmljZSByZW1vdmFsLicKPj4+Pgo+Pj4+IEFsc28s
IGluIHRoZSBwYXRjaCBzZXJpZXMgYXMgaXQgaXMgbm93IHdlIG9ubHkgc2lnbmFsIEhXIGZlbmNl
cyBmb3IgdGhlCj4+Pj4gZXh0cmFjdGVkIGRldmljZSBCLCB3ZSBhcmUgbm90IHRvdWNoaW5nIGFu
eSBvdGhlciBmZW5jZXMuIEluIGZhY3QgYXMgCj4+Pj4geW91Cj4+Pj4gbWF5IHJlbWVtYmVyLCBJ
IGRyb3BwZWQgYWxsIG5ldyBsb2dpYyB0byBmb3JjaW5nIGZlbmNlIGNvbXBsZXRpb24gaW4KPj4+
PiB0aGlzIHBhdGNoIHNlcmllcyBhbmQgb25seSBjYWxsIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9y
Y2VfY29tcGxldGlvbgo+Pj4+IGZvciB0aGUgSFcgZmVuY2VzIG9mIHRoZSBleHRyYWN0ZWQgZGV2
aWNlIGFzIGl0J3MgZG9uZSB0b2RheSBhbnl3YXkuCj4+Pgo+Pj4gU2lnbmFsaW5nIGhhcmR3YXJl
IGZlbmNlcyBpcyB1bnByb2JsZW1hdGljIHNpbmNlIHRoZXkgYXJlIGVtaXR0ZWQgCj4+PiB3aGVu
IHRoZSBzb2Z0d2FyZSBzY2hlZHVsaW5nIGlzIGFscmVhZHkgY29tcGxldGVkLgo+Pj4KPj4+IENo
cmlzdGlhbi4KPj4+Cj4+Pj4KPj4+PiBBbmRyZXkKPj4+Pgo+Pj4+Pgo+Pj4+PiBOb3Qgc3VyZSBo
b3cgdG8gaGFuZGxlIHRoYXQgY2FzZS4gT25lIHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIHdhaXQg
Cj4+Pj4+IGZvciBhbGwgZGVwZW5kZW5jaWVzIG9mIHVuc2NoZWR1bGVkIGpvYnMgYmVmb3JlIHNp
Z25hbGluZyB0aGVpciAKPj4+Pj4gZmVuY2VzIGFzIGNhbmNlbGVkLgo+Pj4+Pgo+Pj4+PiBDaHJp
c3RpYW4uCj4+Pj4+Cj4+Pj4+IEFtIDEyLjA1LjIxIHVtIDE2OjI2IHNjaHJpZWIgQW5kcmV5IEdy
b2R6b3Zza3k6Cj4+Pj4+PiBQcm9ibGVtOiBJZiBzY2hlZHVsZXIgaXMgYWxyZWFkeSBzdG9wcGVk
IGJ5IHRoZSB0aW1lIHNjaGVkX2VudGl0eQo+Pj4+Pj4gaXMgcmVsZWFzZWQgYW5kIGVudGl0eSdz
IGpvYl9xdWV1ZSBub3QgZW1wdHkgSSBlbmNvdW50cmVkCj4+Pj4+PiBhIGhhbmcgaW4gZHJtX3Nj
aGVkX2VudGl0eV9mbHVzaC4gVGhpcyBpcyBiZWNhdXNlIAo+Pj4+Pj4gZHJtX3NjaGVkX2VudGl0
eV9pc19pZGxlCj4+Pj4+PiBuZXZlciBiZWNvbWVzIGZhbHNlLgo+Pj4+Pj4KPj4+Pj4+IEZpeDog
SW4gZHJtX3NjaGVkX2ZpbmkgZGV0YWNoIGFsbCBzY2hlZF9lbnRpdGllcyBmcm9tIHRoZQo+Pj4+
Pj4gc2NoZWR1bGVyJ3MgcnVuIHF1ZXVlcy4gVGhpcyB3aWxsIHNhdGlzZnkgZHJtX3NjaGVkX2Vu
dGl0eV9pc19pZGxlLgo+Pj4+Pj4gQWxzbyB3YWtldXAgYWxsIHRob3NlIHByb2Nlc3NlcyBzdHVj
ayBpbiBzY2hlZF9lbnRpdHkgZmx1c2hpbmcKPj4+Pj4+IGFzIHRoZSBzY2hlZHVsZXIgbWFpbiB0
aHJlYWQgd2hpY2ggd2FrZXMgdGhlbSB1cCBpcyBzdG9wcGVkIGJ5IG5vdy4KPj4+Pj4+Cj4+Pj4+
PiB2MjoKPj4+Pj4+IFJldmVyc2Ugb3JkZXIgb2YgZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRpdHkg
YW5kIG1hcmtpbmcKPj4+Pj4+IHNfZW50aXR5IGFzIHN0b3BwZWQgdG8gcHJldmVudCByZWluc2Vy
aW9uIGJhY2sgdG8gcnEgZHVlCj4+Pj4+PiB0byByYWNlLgo+Pj4+Pj4KPj4+Pj4+IHYzOgo+Pj4+
Pj4gRHJvcCBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSwgb25seSBtb2RpZnkgZW50aXR5LT5z
dG9wcGVkCj4+Pj4+PiBhbmQgY2hlY2sgZm9yIGl0IGluIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRs
ZQo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXku
Z3JvZHpvdnNreUBhbWQuY29tPgo+Pj4+Pj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gwqAgZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8wqAgMyArKy0KPj4+Pj4+IMKgIGRyaXZl
cnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jwqDCoCB8IDI0IAo+Pj4+Pj4gKysrKysr
KysrKysrKysrKysrKysrKysrCj4+Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4+Pj4gaW5kZXggMDI0OWM3NDUwMTg4Li4yZTkz
ZTg4MWI2NWYgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jCj4+Pj4+PiBAQCAtMTE2LDcgKzExNiw4IEBAIHN0YXRpYyBib29sIGRybV9zY2hl
ZF9lbnRpdHlfaXNfaWRsZShzdHJ1Y3QgCj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkp
Cj4+Pj4+PiDCoMKgwqDCoMKgIHJtYigpOyAvKiBmb3IgbGlzdF9lbXB0eSB0byB3b3JrIHdpdGhv
dXQgbG9jayAqLwo+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAobGlzdF9lbXB0eSgmZW50aXR5LT5saXN0
KSB8fAo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9i
X3F1ZXVlKSA9PSAwKQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwc2NfcXVldWVfY291bnQoJmVu
dGl0eS0+am9iX3F1ZXVlKSA9PSAwIHx8Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5z
dG9wcGVkKQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+Pj4+Pj4gwqDC
oMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jCj4+Pj4+PiBpbmRleCA4ZDEyMTFlODcxMDEuLmEyYTk1MzY5M2I0NSAx
MDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5j
Cj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+
Pj4gQEAgLTg5OCw5ICs4OTgsMzMgQEAgRVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfaW5pdCk7Cj4+
Pj4+PiDCoMKgICovCj4+Pj4+PiDCoCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1
X3NjaGVkdWxlciAqc2NoZWQpCj4+Pj4+PiDCoCB7Cj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBkcm1f
c2NoZWRfZW50aXR5ICpzX2VudGl0eTsKPj4+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+PiArCj4+
Pj4+PiDCoMKgwqDCoMKgIGlmIChzY2hlZC0+dGhyZWFkKQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGt0aHJlYWRfc3RvcChzY2hlZC0+dGhyZWFkKTsKPj4+Pj4+ICvCoMKgwqAgZm9yIChpID0g
RFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5UIC0gMTsgaSA+PSAKPj4+Pj4+IERSTV9TQ0hFRF9QUklP
UklUWV9NSU47IGktLSkgewo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fc2NoZWRf
cnEgKnJxID0gJnNjaGVkLT5zY2hlZF9ycVtpXTsKPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoIXJxKQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+
Pj4+PiArCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZycS0+bG9jayk7Cj4+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShzX2VudGl0eSwgJnJxLT5lbnRp
dGllcywgbGlzdCkKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogUHJldmVudHMgcmVpbnNlcnRpb24gYW5kIG1hcmtzIGpv
Yl9xdWV1ZSBhcyBpZGxlLAo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGl0IHdp
bGwgcmVtb3ZlZCBmcm9tIHJxIGluIGRybV9zY2hlZF9lbnRpdHlfZmluaQo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIGV2ZW50dWFsbHkKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNfZW50aXR5LT5zdG9w
cGVkID0gdHJ1ZTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmcnEtPmxvY2sp
Owo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+PiArCj4+Pj4+PiArwqDCoMKgIC8qIFdh
a2V1cCBldmVyeW9uZSBzdHVjayBpbiBkcm1fc2NoZWRfZW50aXR5X2ZsdXNoIGZvciB0aGlzIAo+
Pj4+Pj4gc2NoZWR1bGVyICovCj4+Pj4+PiArwqDCoMKgIHdha2VfdXBfYWxsKCZzY2hlZC0+am9i
X3NjaGVkdWxlZCk7Cj4+Pj4+PiArCj4+Pj4+PiDCoMKgwqDCoMKgIC8qIENvbmZpcm0gbm8gd29y
ayBsZWZ0IGJlaGluZCBhY2Nlc3NpbmcgZGV2aWNlIHN0cnVjdHVyZXMgKi8KPj4+Pj4+IMKgwqDC
oMKgwqAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZzY2hlZC0+d29ya190ZHIpOwo+Pj4+Pgo+
Pj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
