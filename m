Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084DCC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 08:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB543238E2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 08:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB543238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5556E51B;
	Thu, 21 Jan 2021 08:04:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B686E51B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 08:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyWvNEfi2RJXeYbFa90PFycsV2mj5EFMtWvYPnekcnv/rq5jfd87RqGFkA5q3c0nzzorK9vk8nj2egGERyCq2RjGjC0Rg4JpP1PUGJTdXiv5DH4sNu29XROOzvoE4MR2QercIGwJ4I2yeKNpWZbO4dXpLMcLwvtyTHEIFX9F/Vkjsbw5z2xZct2so6geF91bTp80wZDDyGGUpfUhb7EzaXWRPNODHPGRdo/ZeHt73f9Qx1dEon4GuHBTVKql2LbKcMYWLfzr4fFfod97SyaCYNTShdvGgAKY05OqkO4o2szLZx/ogKCW5/hZGhuM+0YueG28SebshDzOxAFWlr21hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kz2MTzymsuGpHWhgKnfDUvF4mLXuNom9BYl4QG2o8I=;
 b=CypHu91Bu+k7BiKfXlhhCad/zX4ZxZoI7WlOEflyG6lpK8go3A0sN/rjJMxjAGrTgQpmcYdLp6vaDRE3elx0eHXi3e5WQS75BZMYaLQlRxYzujdqrUSVbKz9h7kLsx069+QxXgqY7tBNz/Zo6+XlXIKMNYVgs5Cb9BVZKjnvXqsMIRpb38Hp7uDc6hpbhRhjZQ0dG9QnbdRdjj44wEyLEtfgdhM35JprLhNA7wS987Uw4zzBW7K7XEQ6ZOYq81eFsZwURab5RFkrqNszafoC7/PF9e5HIwEjYtGv3jtsYcV6lJmdRu8gJNpvU819kImrB0YpaQ+lq3xzLCEAUcwfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kz2MTzymsuGpHWhgKnfDUvF4mLXuNom9BYl4QG2o8I=;
 b=fIGT/d+UcxxCiZuwWzSsV4E1+xtK94VgX9vbYE2XebCqkaKaGfiYrYuvlZWu3nwZuCRLAk/qKyAmFPToqJ4aEXA4rDfQffSqfYZsb3a95cMeInOv9ZA5b4Qk28n/FmXCruty7WBBqI5Nw4GwXuudUwOHKg8i8aViQRXbvMmGgjM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 08:04:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 08:04:03 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Make contiguous pinning optional
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210121050830.30888-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6fffd201-4fd9-255f-9449-e1d6c7904fa8@amd.com>
Date: Thu, 21 Jan 2021 09:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210121050830.30888-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM9P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 08:04:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2e84140-dd56-4e5d-2d07-08d8bde31dd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3951E5952EAF441F8A5C071B83A19@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuJ5d4faUKlbmuRPxNOj0AweV/mmG3NRSSNubnVNkDyOvvd8Vr1lBGS8JCbY18FRQspvQiFH7fvM/Jp0iEKc1zboa0fYM0qYOw/vTDD8ZZ+Vwjs8+SPW3rqWfi2mtlfwip8+AAmDhKuKYyojH7f1UVzlR/AOIcWuDEe7fv5YmW5BHjqMcwXgljaMEkRUuo6zV4x87qV1BxV4k7CluEg3w4n5Q6RjNc8jOIke/6eI4QbUpWX6Aij6wpLqs50KjVfhYqwI5qv3gGMCr4khQ7G3X1ekS1YKaPWVPLZ3IU1RmSl6vYCy+3NTPdknOl4WLjXLp6q/TipZHet1+6K5l4OBy388Hb47x9l90iwf0K0J9PoJjVcQ3XTgDJ+UWoEdxMBp4MEZMJ+7t6buqDJ4mYllD3MxnpxkA3ExsTiLI7zxth5o+gHxRDJMUocqxz0r47P7IfOZU7HRlPvF8RIQGhyB0tPw9kRSS3ixMmR9ucPq9NFn1hQ3sEKmPFuP8WFC52PeV9jGSPsc0iqatlWd94K2pww/CwC2y1+K+/LP/qDV61dfjAonKyvLSyMCQfQzuVTs3VkZ8c0NXvtx28UorPEkdTu9XJaegxeFOV9Ls3O/DaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(316002)(86362001)(83380400001)(2616005)(6486002)(66574015)(186003)(478600001)(66476007)(16526019)(6666004)(8936002)(31696002)(66556008)(52116002)(5660300002)(31686004)(36756003)(8676002)(66946007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mkt2UmRXb0o3Q2pMWVpZVTA4bUFsWWNvOVk4OWhDWUQ2WUE4UGlUNHVtN0s4?=
 =?utf-8?B?VncwK0d5YkhsczlmU1hiS2NXUUcxaVNIWFBBeXJnUE5ON0JUL0FXZ0RvM3NX?=
 =?utf-8?B?ZWdlVm1IKzVDMGhYcGRwTDJsZHdCQklKdTBybDFJZjlDSWdMNko0VThLUG0x?=
 =?utf-8?B?YUpkVW5UNHhWckVkRy9WR3FONjVjanNrRVdWbExGc3hlRFdvdW16TVBZOTgv?=
 =?utf-8?B?QjVKVVlqNWptc09TOGNpcGFhRitvT3B2Z2FReFA1cm4vbmpld3B2RkxDTDdJ?=
 =?utf-8?B?dFc2QmVoSXpTWFRjaDNOUC9YU0toQmxCOUhvZjBwby85M28zK2FOakh3NEFB?=
 =?utf-8?B?Tkxkb1dpNzhmOVl3a3ZJU1NIUFNNd2NjZmtPMjJDY2xwVWVmMFE0MjhhMDNi?=
 =?utf-8?B?RG05OVJkUHVnNnpGYzVMcXRCNExGbjBYLzJ2UkZxS05nOGVQRUtFK3hwMWdO?=
 =?utf-8?B?UElra01CQ3hNd3oxUGtONzVYZXZuRGJsdURkb1E4bzBqZXdQZWtMRkV4OHZQ?=
 =?utf-8?B?VzdVL0xoMVUzNHpiTXV1elZMbVA5UzV0MTNMeGFYelRSRVpaZFBZMzJJQWhI?=
 =?utf-8?B?UmNaRUZISUZ4K09tYStEdUhOamZvcVJaQTg3dWk1bXI4KzdKOTN1cm0ycTc2?=
 =?utf-8?B?NVU3VXdUWGViQVFZWGtUZ1hpODNXNWVNYUoxcG5tVXNzY1l6TEwvTzNGTmFJ?=
 =?utf-8?B?Qkp3VVE2M3V1dmZZODFuUkw0YW9CbmhZZ2w2VVlRd0lnVXJPMVpCNmtOL2FJ?=
 =?utf-8?B?RmhXMTFqMVhjalM0OVFZUUtIZ0VxV3JCb2FENEdRajEyUkJaOEJyUmNSellh?=
 =?utf-8?B?ZlhUYmkvS0NyeHNlWmlUZmZJZ0d1aE1nL0JaTmxPOEM4RkNiWHF3ZUJMeFgx?=
 =?utf-8?B?a3F0NHd3TXJ6eUtIemRkdmZlK2l4WlY1WVpOcitHWUJoeC8zclhMbGdJUjk0?=
 =?utf-8?B?YTVFTGlFVER3bUxXSGJhUTg2QU9mWW82elluYzFWTnBNWis5MktNbVBCbm80?=
 =?utf-8?B?VWd0eTNZWVVqTjNkd2lQOVNTQnR4T0xKY0doMWtNNWhFV05SSzlQSGFaakRw?=
 =?utf-8?B?NXloL0JPVUdNYmp3S214eWxpVCt3dlVyMDNzR053SGZoUG1rUnRZZmZYd3Y2?=
 =?utf-8?B?STJnTisycE96QnF6RzErYWQ2WnBNRUV1cllPU2NBOTkyZGZKK0lKVk54ZHJs?=
 =?utf-8?B?YnAyVU9Uek5nckQ4bG93WmR3RzVlU3A4R3Rya2F0R043RW9uS2JObnc5VGhF?=
 =?utf-8?B?RzRwZ0tYWXNKMnJ0akFuWGF1ck5sRzh0c1JGQW5NYXlqQkZQb0gvWXZkb0xU?=
 =?utf-8?B?VndvMlhGdHN4VEt3U2pwQ1NyK2V5NHlmN3NNYnNLWFRDZ3VBQXEyMTNrbXdO?=
 =?utf-8?B?RlErSysvTXRmZUxmSk9WTldVQ05PQlh5NlAyNmtzbk1abnFGdkw0aEcvcHFL?=
 =?utf-8?B?L0sxOUtqQjd1WktxTXIrOHpkZ09FTkdXMGpSUWNXYWp2VTFrbnZ5bkZ6WHBp?=
 =?utf-8?Q?vyOygj+6NA3ObaPHjloB1IpNY02?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e84140-dd56-4e5d-2d07-08d8bde31dd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 08:04:03.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT30laZ7gHgEmxxOa1ioDiLnWIQBwv5UAbvvUKtbyo8jbv9KK9Romstc1/0Fdnfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
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

QW0gMjEuMDEuMjEgdW0gMDY6MDggc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBFbmFibGUgcGlu
bmluZyBvZiBWUkFNIHdpdGhvdXQgZm9yY2luZyBpdCB0byBiZSBjb250aWd1b3VzLiBXaGVuIG1l
bW9yeSBpcwo+IGFscmVhZHkgcGlubmVkLCBtYWtlIHN1cmUgaXQncyBjb250aWd1b3VzIGlmIHJl
cXVlc3RlZC4KPgo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMgfCA3ICsrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMKPiBpbmRleCBkMDI2Y2VmOGU1MjAuLjEzN2YyNzVmOTBlZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBAQCAtOTE0LDEwICs5MTQs
MTUgQEAgaW50IGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChzdHJ1Y3QgYW1kZ3B1X2JvICpibywg
dTMyIGRvbWFpbiwKPiAgIAo+ICAgCWlmIChiby0+cGluX2NvdW50KSB7Cj4gICAJCXVpbnQzMl90
IG1lbV90eXBlID0gYm8tPnRiby5tZW0ubWVtX3R5cGU7Cj4gKwkJdWludDMyX3QgbWVtX2ZsYWdz
ID0gYm8tPnRiby5tZW0ucGxhY2VtZW50Owo+ICAgCj4gICAJCWlmICghKGRvbWFpbiAmIGFtZGdw
dV9tZW1fdHlwZV90b19kb21haW4obWVtX3R5cGUpKSkKPiAgIAkJCXJldHVybiAtRUlOVkFMOwo+
ICAgCj4gKwkJaWYgKChiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VP
VVMpICYmCj4gKwkJICAgICEobWVtX2ZsYWdzICYgVFRNX1BMX0ZMQUdfQ09OVElHVU9VUykpCj4g
KwkJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAgIAkJYm8tPnBpbl9jb3VudCsrOwo+ICAgCj4gICAJ
CWlmIChtYXhfb2Zmc2V0ICE9IDApIHsKPiBAQCAtOTMzLDcgKzkzOCw2IEBAIGludCBhbWRncHVf
Ym9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21haW4sCj4gICAJ
aWYgKGJvLT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNoKQo+ICAgCQlkbWFfYnVmX3Bpbihiby0+dGJv
LmJhc2UuaW1wb3J0X2F0dGFjaCk7Cj4gICAKPiAtCWJvLT5mbGFncyB8PSBBTURHUFVfR0VNX0NS
RUFURV9WUkFNX0NPTlRJR1VPVVM7Cj4gICAJLyogZm9yY2UgdG8gcGluIGludG8gdmlzaWJsZSB2
aWRlbyByYW0gKi8KPiAgIAlpZiAoIShiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9OT19D
UFVfQUNDRVNTKSkKPiAgIAkJYm8tPmZsYWdzIHw9IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NF
U1NfUkVRVUlSRUQ7Cj4gQEAgLTk4Nyw2ICs5OTEsNyBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0
cmljdGVkKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1MzIgZG9tYWluLAo+ICAgICovCj4gICBpbnQg
YW1kZ3B1X2JvX3BpbihzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbikKPiAgIHsKPiAr
CWJvLT5mbGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVM7Cj4gICAJcmV0
dXJuIGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChibywgZG9tYWluLCAwLCAwKTsKPiAgIH0KPiAg
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
