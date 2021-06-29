Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E9CC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D262461DC2
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D262461DC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889216E852;
	Tue, 29 Jun 2021 11:09:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B596E852;
 Tue, 29 Jun 2021 11:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK2QeM0VjAxkfy1YmNknq+yIWhk4UejEzCaxQ5EGV4DtD3RwNeeFEvEM16M5O1GXVaqhYwa3b315W5q6vAFqJJwz0vrb4LZ5q5XH4g4Ig9sS+v5kVD0HgW2Ki5+sK3T50OXaEHHYhdp0o1NC2Hb33Faz8s2iav6n6UCTRaOrp3OCjOrrMuWTpQXbEPFRMJE4KacnvbmFMXNAlSEeAqkiT3p+tV4+fsXTzlWTzqqddRDW51nfOweO16YavYY+Z56jtLltUmZ39yqFD60Xo6L8xDjHNeStGT2axtQb/oOJYU1yKBkvlVavEdr8n5l3BKw3qpQBzZh9OFVYte4f5wPhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weOQel+TP8ktZ7jUE4Z2m87I+i++P0T2xFL+2VyoMRI=;
 b=BUB1gOGInD1rncE7xwMZCUloNbIpNr0EiSJHJbV7GDdTn5QKGOe+KrWcC25dPXB/4ElVWLgplryyIZfQXqpCqq/kTGXc404/3t4a+e9A1nD3O2iJlcTJVLaC6ZyE3kYyQ7igCLXLqFE4cHSesfC+xb2eZJ1qF5asuSw/8HjvpJ7ubbep1Uv96/EhsWmkSqhxKvkd2FhYXH7kFRrvoghAY6dnla4j+BAJBjVGlebaUWtFAy7Eg71vuSYxOwdKl6l82j6MlgpKzzy4A/f6XWq1vhy6/NAgfj0VawpwgrmMQNWVLsaKqLHGuSm74Rr/8k6n7NQJvJDdrBuh0O46Nw59HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weOQel+TP8ktZ7jUE4Z2m87I+i++P0T2xFL+2VyoMRI=;
 b=j8DxXei8WdYfDHq1yAHr6FnQevaEMRcShKtHJDWgtlFmq1v367uPWVvc8hZ9HZ6PTAzrAOzlOlP0MbTZFb8iugRsIAgtoGqlNR7ApkNGw4toxwbQCMWAOQ5V5/quXp5E3zy1Miuah16SqkRcPnwI+AtfxR46dRV9/ktbCWAa0Is=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 11:09:22 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:09:22 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: return early for non-TTM_PL_TT type BOs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
References: <20210629073629.3069-1-nirmoy.das@amd.com>
 <844ab0e2-ccea-b2a3-cbf4-744726a2a026@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <39f27a82-d831-1aaa-6741-89cbe5c6f422@amd.com>
Date: Tue, 29 Jun 2021 13:09:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <844ab0e2-ccea-b2a3-cbf4-744726a2a026@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f27:5d00:9499:a270:2927:4d86]
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:5d00:9499:a270:2927:4d86]
 (2003:c5:8f27:5d00:9499:a270:2927:4d86) by
 AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 11:09:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d47d355-0262-4e9a-35bd-08d93aee595b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5294BD386FA7F52B9587D80D8B029@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvVOXV5NdCNbrbwrB+GVwdWngWvZVFmNOsIz6Kalh7E2v/cahuTCOfysyHgBNhE+9mz9k54y920cm2us5N+yGhO93dCVl1hviPOHAv+64IgBEd0fZtoD6ts/66fFlulOLJn3K0Gee5AabfRFUxRC8bzmYlrNc4FjdtpgE51T9FN52meyO5IrDewHbEzvoQjhoQuKa4Sys9+14G+SVoO3/VA4cYJF7Ka0vppGx7fvO4DdGn59JNrBilH28iHo82TWT30fYOnb6r1SUDVWS0IFJm052KaGpjg8eHrbL03HXPux8fn79/2Nnw2mGfWltQkvMssVWXfA0pB1oZQcye30a+HgqIW5tkYi5twj9LWzVl1qBj7Roe/OESUxBlwkRh2dZ2sjrvGUN2vqS4kow2mnlkOW4ddCKMZtunSGaaa8JbUlNH+4pzLjwJvf6slwAABY21PuMO8IYFGCMGbmm4o//gzLzlrADylGqcHo8XTRXDwDHip+RCIlVqyJX02udXmnZzxBO0GUXtZE2aosmtWmWccu4s2QjSW7gjud6Lkcbmf4gY/DHOOFvqs+eznNCbcHDR3HGCYubmm1oYiScexR8EhCxKhJpKWzkwXW7qeb4IOuKWfkaaOIaTSUfts96xJ4QerB7UP03pVGEgQ1GRl4yl79LfkbCNdDlgbqQrLjMKY4t+utM/mxDjtcLhSFBCsDFa4s2qi2oVEnSKNv/KNuv5xCJIiRQD2HmWIRAnx0LTwp3OY7lWvRbEoZj4pTgu/t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(66574015)(66556008)(66946007)(66476007)(38100700002)(5660300002)(52116002)(83380400001)(16526019)(31696002)(186003)(86362001)(2906002)(450100002)(36756003)(2616005)(6666004)(53546011)(8936002)(6486002)(316002)(478600001)(4326008)(8676002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNpZTRzQlY0aFFYOGZ2M3dRK2FTWmRtWkczWERDdStqWU5Zc2Fjemhteit2?=
 =?utf-8?B?Wk9TSnZ2eEtnM0RTVnBKYUkwYW90SlhBZmdGd2xhMGsyNWV6eTNlZGcvMEFw?=
 =?utf-8?B?RHFNWkVJRUF0Y2pLUTR5eVpJaUpRaXlCd003Q04ydy9ES0lwR1hCVDF0dXNh?=
 =?utf-8?B?QjlFd214cFYvRGFMcUMxS2hBWmw3YjJJeVFxN3dXWThSbkNiNGpFKzJWSEZR?=
 =?utf-8?B?cGJjQnpxaHNSVXBrTlZuQ3RLTUFTQnlDc3V6VHZtUm01czFVZWlnWDhXbnFr?=
 =?utf-8?B?Z2xmR1MrV1Q3WVlzbEhHZ1JGUU5wYjQrTkwyZkdPWHZSK1ZaWTFrSU5idmNX?=
 =?utf-8?B?RGpadHhSQWJxRTRYUUozbEJlcURsSXMzRlhGSGp4MWNyWFBtdUlrQzgwb09w?=
 =?utf-8?B?RUJDN3hPQTNybDRubTNSUE5xSkppN0s4eXBkMTA2MXJoa3B3NGwvQ2JIUUlQ?=
 =?utf-8?B?QWl4UmZmdHpjaXRRelh3OXdhQ3h2cXdEbVBjRXBhd2tpWExWUXZvN01zWEN6?=
 =?utf-8?B?WkhFRTIvbmx1YVdUQTZsOG9aRUQ2YjRBc2kxaDVaSWVFWFJ2OFowVHRWanBk?=
 =?utf-8?B?VVlmZkRTZWxETlA5VkpTdjV0bnlSZ3NZbXhqSjhJV2MybzlmQTZCMzUwaGRV?=
 =?utf-8?B?M0x2NUxMcW0wRXJmaEw3NGJBQ3hkNnVwSmR1MkJuTDBhSWsrc2ptekVIOEFw?=
 =?utf-8?B?V0dwVzVLcHZRZmRpOHRFMFhQWGNaUW9XaEhXbmFXQ3c3L1V6bk5iaUwra1Va?=
 =?utf-8?B?dGNwWGdmamc2YVhkL3pDdmUwNDZWQklGQURKMytLdlkrdVJRYmhxclROMFN0?=
 =?utf-8?B?bmFIanVTVDZYejdKSkM5dGZMREQ1L0txTWJiU0dzN1piU01DSi9oRmNVdGs0?=
 =?utf-8?B?azdLcHVrRWtvajl5YmtNNzFVTmVmN285MkRTU1cvODYyUkFkZWhubmtvc002?=
 =?utf-8?B?QmpSYU1jVzZ3SUlUUmRVc1VSbWs0dGt0WE9GMWFSSnlwNkxCOVd6OTRLVGpH?=
 =?utf-8?B?UGxFaTh5OGpXcWF6RHoreG5SZzU1ZEcrTVVQNWl6VU9xRXpua1dnWXRWV2JR?=
 =?utf-8?B?TmtiSXRaTS82OC8rVzVISU1PMEdHM2pmamloTjN5djZzVW8rNjMvZGZ0cVhK?=
 =?utf-8?B?YVc1MldWYVJoZGtvMGhmYW1rbVBBclZDUlVVSXRxR3NqbEpOQzZwQm55b3o3?=
 =?utf-8?B?UmphMmZmQlRoL3YyUGRSNFRjVEdPUDFCVE54cENGOHZIdGpGV1ltWjA4ZEUx?=
 =?utf-8?B?RzhsdUsxdHA4cndUT0dGNXZxTVZKMHdaR09EKzMwYlRBQmdNMnpQOS9SdmJW?=
 =?utf-8?B?elRLTzFaejQ2dWVQcFFDVTNRcnprQ21kNTRldkNwbElCTEVHSmpQRDkxSjNT?=
 =?utf-8?B?NUR0SktXWWR0a0dtZGRqYzZWRSswelRtTFdaUWQ1VUpiSXVyRlowdFB1TXEx?=
 =?utf-8?B?YTd6YStqUlhacktUR0lqZjdMcm50azRFMElOMWpweTN4SzB4WktETVJnYjJa?=
 =?utf-8?B?QkM1TkhFalorUnlmVjVqRnBGZzVhWHdhcjlKQ0gxSjlDWjBlVHp3K056MHlN?=
 =?utf-8?B?SERCMVRIdTNTS1ZsQ3BaaXZKWDl5WGl6MlR2VlZMRHZ4Z2FoSUhrMHdrS0hl?=
 =?utf-8?B?ZnZQWmNkNFBveDlFVi9CSHFJOU1yc1dFYk8rU0M3Q0RHaHBISE8vT09JZUFi?=
 =?utf-8?B?aXdkTkxrbkR5cWdrZmYyQmlMZy96Z3JrZHk3a3c4a1VuZ21BQ2lmVWVCeTNN?=
 =?utf-8?B?aXJRWDd6SEZaRHRPaGM0NDlyQWRhaE56TDM0SnlYSmp3S3M1RGlQN2Z4Z0sx?=
 =?utf-8?B?M1JMV2VNT2VQdHZSZWxrcEdDbVg0WDQvaTBrdFBIWm5UR0RleGVxUVFIMDBB?=
 =?utf-8?Q?D1O9kMSM/Bxfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d47d355-0262-4e9a-35bd-08d93aee595b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:09:22.7135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2DPFHyatf4G0UU2tFmTLjn6hSg6JhKpKjxJeS2oHVZe5isV/VVcL3gBlGj4++R2DqIO++mgymY2359xKrdBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMjkvMjAyMSAxOjA1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDI5LjA2
LjIxIHVtIDA5OjM2IHNjaHJpZWIgTmlybW95IERhczoKPj4gUmV0dXJuIGVhcmx5IGZvciBub24t
VFRNX1BMX1RUIEJPcyBzbyB0aGF0IHdlIGRvbid0IHBhc3MKPj4gd3JvbmcgcG9pbnRlciB0byBh
bWRncHVfZ3R0X21ncl9oYXNfZ2FydF9hZGRyKCkgd2hpY2ggYXNzdW1lcwo+PiB0dG1fcmVzb3Vy
Y2UgYXJndW1lbnQgdG8gYmUgVFRNX1BMX1RUIHR5cGUgQk8ncy4KPj4KPj4gdjI6IG1lcmdlIGlm
LWNvbmRpdGlvbnMKPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0Bh
bWQuY29tPgo+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMgfCAzICsrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
Cj4+IGluZGV4IGI0NjcyNmU0N2JjZS4uMjA4YmMzZWMxYWZmIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+IEBAIC05MjYsNyArOTI2LDggQEAgc3RhdGlj
IGludCBhbWRncHVfdHRtX2JhY2tlbmRfYmluZChzdHJ1Y3QgCj4+IHR0bV9kZXZpY2UgKmJkZXYs
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBib19tZW0tPm1lbV90eXBlID09IEFNREdQVV9QTF9PQSkK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pgo+PiAtwqDCoMKgIGlmICgh
YW1kZ3B1X2d0dF9tZ3JfaGFzX2dhcnRfYWRkcihib19tZW0pKSB7Cj4+ICvCoMKgwqAgaWYgKChi
b19tZW0tPm1lbV90eXBlICE9IFRUTV9QTF9UVCkgfHwKPgo+IFBsZWFzZSBkcm9wIHRoZSBleHRy
YSAoKSwgYXBhcnQgZnJvbSB0aGF0IHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogCj4gQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKClRoYW5rcywgSSB3aWxsIHNl
bmQgYSBuZXh0IHJldmlzaW9uLgoKCk5pcm1veQoKCj4KPj4gKyAhYW1kZ3B1X2d0dF9tZ3JfaGFz
X2dhcnRfYWRkcihib19tZW0pKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBndHQtPm9mZnNldCA9
IEFNREdQVV9CT19JTlZBTElEX09GRlNFVDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAw
Owo+PiDCoMKgwqDCoMKgIH0KPj4gLS0gCj4+IDIuMzIuMAo+Pgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
