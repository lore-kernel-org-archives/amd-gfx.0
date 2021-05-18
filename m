Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA6C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A4F61185
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 14:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A4F61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E4E6EB85;
	Tue, 18 May 2021 14:07:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3CD6E886;
 Tue, 18 May 2021 14:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/p708UUb6ag4v+8eC3+Yo7MiG29/HvwbCr+xGP4DuOiol8WzkyXI5pZrOIWbSZl8DpQgLOJDCWKWGejQgemKek2ys5mmbAKWbNVfWkMTGdTUvIjhokIJz4TNw87l2nj4photyAZ3M+oRaKUlRTx0feR+mCaH5Tv51fRp6B7TfuI9JrvdA7UZodkYBmC+0nIVs64l2fS3yKNWlhVkRWmGL4/yd6GN5DLYlw3I40nzursEtExvzdszXjWT4hmTubjwhX5jnjugKddrmMhjwa7z9eb936r9UcRjSZ0enl3FwWgPIGwNHX4aABtGmkJgCOsBWGmdxJ2tl2LTTO/aef5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+IJX4IDtvED7MY5nHKkjIZccVh61sf1mqI0D3UvcM8=;
 b=L/g+n383x8THcE/rPnwYr5fir77NeY45f75CVWKZXhzvk8UdMjHev8uwZX8tJDWKSFLZlwlEj5HHf1dBVO3FSYuC7U7Xo3VxPvFzNgvFGmnLAQo4r7n8NAo7y6u7VbrMQKUknLz9JDo+ytmpnqpGpR1CBZHJAM50+d5RgwEHpnRZ+SQTzR4MZDaTuq6OYx+XxEymWwCJIbV3Hj+psB0S1BAtaAsZMci/SelLdyOHNE2Unq/xfpHYkqkBkvClC4HJMoVxtgf1is7TKJk5JPjdgJhdczmz1k3+A5ouNEiVQ29jANKjS37sBr+OIi5vmhXPTHUW6J+ctYpJajhRlCkMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+IJX4IDtvED7MY5nHKkjIZccVh61sf1mqI0D3UvcM8=;
 b=WSIMksnlhn0OcOQ406hoGDYZT9EDkfhi9sD41guaOVwJmowmiBjM4sIX/bpa6cHojwYnCjPe0GXLVrIOhiSDrA2pryKR+roJtJRTvqUQDES0FOVxgPpTSEXUiTfaIUauFiKtJt3lyevuh0erJafKjjuVcXFXDd4Q1YzvpeF4k3c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 14:07:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 14:07:40 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
Date: Tue, 18 May 2021 16:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210512142648.666476-14-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3b27:1830:9671:4cc9]
X-ClientProxiedBy: AM3PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:207:2::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3b27:1830:9671:4cc9]
 (2a02:908:1252:fb60:3b27:1830:9671:4cc9) by
 AM3PR05CA0128.eurprd05.prod.outlook.com (2603:10a6:207:2::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.32 via Frontend Transport; Tue, 18 May 2021 14:07:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f978b66a-e13a-4046-5fac-08d91a064c0e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39366F77D445B576BA5E4CBD832C9@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJA4EKLIWzkydGFhy81ZbOuNxtqYhctq2A8xKslZNfjBjff3JUbhUv9fSqI02Nu0o2K1ccaSn5LUpN1YGqiFOL6LyzFqYY7yNvkjM8ll0Oz+Yyxg4K9tpBWJJWriSvFteS9qOLoaqaH4e0LNNXLAS4kA9/Oz3zHWn+d6FvUARO9CofX6aklNcDpdPYtkPRJT3ghH04Lemu++wgg3DUg4KCQutcbGj/nlDU2sr+VZ7EIUr/6OKkw9Gs9zpgvhluLhY65no+mRWD4r3R8U00wKDXbcuPWXYDu8Iei52RDte1emqdDJtUISSoTS8jMJsz2NTih1c8mGS3tFNH7yXFX49ogGuLkopBe/uRk3DuD9oT/J+MOzb/7FwSXfou7DUPriK7qa59t0U/7yYXh4rQ0JVw9QfIeInQ21fIT6YAebSoiTRFeDdxt+gGJzl5FPDqqa+Nl7pcHCznge9DZKavR8XeML8zxSdkmJAkCka+AasZXTkTUrMXflftiTIfMquRFBvMXZxcH8c0mI6UGhvuhLAJZ1w3tM3u26ShfZ/ZUjBTC3dnvgXDQcWmhY3xcY7Rxh3xw7nZuxku1EPmmiKK003CdiIpOjHk7ZbbO5I01uqQ+H54+hMkcIGETCQbJ9OL7EXyNmZ0FXs9LDARrgS86uXZwJtsAvuu8evnDK8U6Exd8o6yOCBnh1BPHuGw9CGSa+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(31696002)(83380400001)(316002)(66574015)(52116002)(2906002)(4326008)(478600001)(66476007)(66946007)(66556008)(6486002)(86362001)(5660300002)(8936002)(8676002)(6636002)(38100700002)(2616005)(16526019)(186003)(6666004)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUdvSWJxNGtMQWpJYURxUW5QekhnR0llZTg4bkNUeVBkWW04cHQwTTBOcWVm?=
 =?utf-8?B?cWtDS091NHBDNlA4bzE0bnNaaXdMcFRHTjA3MVY0Z05tNzFWdmRjaVUwSXNS?=
 =?utf-8?B?WExtbFNpUloxc2FKYzVkVGpJeHFZYVVxNE5jQktzajZicmxPMHAzdTRTWWJ2?=
 =?utf-8?B?SlI1a0UzM3IxRDU5QkZzY0JTaHZpM21QZE9xOElwMVR2ZStkM2hHY21KZGtU?=
 =?utf-8?B?MmU4akZiRVZxVEhKTmFvOHBhR01HVERMV0RRRThJRFdrRU55SStjK1Z1SXpD?=
 =?utf-8?B?eHVMMTZsRmY4ZXdOeUVnajJvOW0wMTg5eHlzY1VkbEJDQzdPWWR5SDdNQWZK?=
 =?utf-8?B?aWRhcGdVOGVpcXc5clFEdmhVVHlXWlJYVE1jSC9Sb2l3cWVONWJVaWVldGl5?=
 =?utf-8?B?eElsdE5yUkdCNlpwV1JKQkRBVW9lOFJjZDhxZjNSQjUrZFBqdlFGWUtrc2o5?=
 =?utf-8?B?ejlBZnB6MmRLRGNCa1ZRV3Nab3V3QjdlU1BaZ1FDSW5jWmUzQWs4aElYaXVW?=
 =?utf-8?B?TGVhd2grZGs5Q25yTjJFdXIvQ0tCRTRDNUNzanRlTldLeGMwN3FUZ0VrdXVY?=
 =?utf-8?B?eFg0UHdFcmE4RUtkOTRrbkMvbWRXQlY2TklCbktvRGpGVy9CTy9TQUY3czBF?=
 =?utf-8?B?MkNUZ1lFaEg3d0xacWN3UE1zSlV1N0F5dU5yTWlXSzdVdmFMYjVMazFneHhY?=
 =?utf-8?B?bHdpdy85MVZaUWZra2N1bjJWTGhwekpDRHcxWXg2ZXgxZU5XN3ZDWHJSK2Ru?=
 =?utf-8?B?dFNNa0l3dnlFN2dFeXIrNTZRa2ZURmZWWVFIVU56M1MrS0JKZ01mNGl1enNK?=
 =?utf-8?B?Z3UzUFdzUXBBTjZJU1YrMVVUa0c0WnpjbGJMVy9WcWlscHIxa21yNmZDdE5q?=
 =?utf-8?B?TmJHU2tjdzliMU95a1A3bkFGWjc3aENYSG1lL3QraEt5cldQbnRkZzRDZ20z?=
 =?utf-8?B?VVNqNnV1eW0rTEVhUXRUU3c3MG56STByTnBlUzc4YTZjLzUrcThzVWZkRE1i?=
 =?utf-8?B?b29ScjZxTEw3a2o0UGhqTnA1YkpzZU9oN1JwaXdOb0pYNEQyYzNTR1R2NzZu?=
 =?utf-8?B?WTVIblVxRkswczFEMmE3SkRaQVo2NHNXZGNKWEhlRkUzYVI0UGUyNG9rOU05?=
 =?utf-8?B?K1BzN1FxR3RRUUxWYWo2WXZkZUNicE5vY0xHaXNQOHRNclpxZjd1dk1YUlRS?=
 =?utf-8?B?bTBGb0dVYzdGem8wNHBkbFV6MWk0U09BQzJBQkNRajBMWWdFM1dJazdyUGpP?=
 =?utf-8?B?MXZ4Ukd1YXpUZ3dVcGJFUThUQ3NqVE5va21lbk1QRmNDRm85OXNKMk1DYnFL?=
 =?utf-8?B?M0dUbzBiOE5qaS8rNVhFVSs1SWYrOWxVZkVOR291YkwyeWxLckcwZEVobTVp?=
 =?utf-8?B?RnZtS09JcTlTRXZwVEtEQXpWVDdMTTdVTk95elVNZ1BMSlJYSWlnbU1wMS9E?=
 =?utf-8?B?WC9iU0NSb0Z0U3BkN1hUUVR1MTlMcStsNUxrOVBhRXJGR2dTS1o5WkxncWo2?=
 =?utf-8?B?Y1RTMHZOUUU3eDFkeVluMFd5dU90OER2Z3RnYVZTd1g5cnFMdlZ6M3FLcFR1?=
 =?utf-8?B?ZGhFTEplc0ttQ05sSVkwWXBIQk5lcXZpVEtNd0lKeCtlVXRuOXVnclB3MVpk?=
 =?utf-8?B?WXordjR5dWNEVmhlaXVHZU9jMUN5Wko2RDlOb3g0empKVkQ5TWtEWnkvSlIv?=
 =?utf-8?B?aUhoa3BSWWdnbkJpK1U5cTFWblBIN2RUcXoyamxKN2U5Y2lRWGx2Y1pMNGFR?=
 =?utf-8?B?d1Zlb1U3U2FjK2NjeTNFVUc2Q2NHWVVRL2ptK2Vmcko3SStDcm41dFFqMG1I?=
 =?utf-8?B?aGJpdTdyVXBjUXdPcU15Mk5JY04vQkdkWDlaUkUvWFcwelp4VGNCWGNBcDN5?=
 =?utf-8?Q?e+sr9xuWQodkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f978b66a-e13a-4046-5fac-08d91a064c0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 14:07:39.9061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ9xESh7bPqPP46gnUi3rQoVs0x0EtVoRcnoEmtUbSvpoMGxzPYNVhzmB24JH4rE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
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

SW4gYSBzZXBhcmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9yZSBpdGVyYXRl
ZCBvdmVyIHRoZSAKZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhlIGNvbmNs
dXNpb24gdGhhdCB0aGlzIGFwcHJvYWNoIApoZXJlIHdvbid0IHdvcmsgcmVsaWFibGUuCgpUaGUg
cHJvYmxlbSBpcyBhcyBmb2xsb3dpbmc6CjEuIGRldmljZSBBIHNjaGVkdWxlcyBzb21lIHJlbmRl
cmluZyB3aXRoIGludG8gYSBidWZmZXIgYW5kIGV4cG9ydHMgaXQgCmFzIERNQS1idWYuCjIuIGRl
dmljZSBCIGltcG9ydHMgdGhlIERNQS1idWYgYW5kIHdhbnRzIHRvIGNvbnN1bWUgdGhlIHJlbmRl
cmluZywgZm9yIAp0aGUgdGhlIGZlbmNlIG9mIGRldmljZSBBIGlzIHJlcGxhY2VkIHdpdGggYSBu
ZXcgb3BlcmF0aW9uLgozLiBkZXZpY2UgQiBpcyBob3QgcGx1Z2dlZCBhbmQgdGhlIG5ldyBvcGVy
YXRpb24gY2FuY2VsZWQvbmV3ZXIgc2NoZWR1bGVkLgoKVGhlIHByb2JsZW0gaXMgbm93IHRoYXQg
d2UgY2FuJ3QgZG8gdGhpcyBzaW5jZSB0aGUgb3BlcmF0aW9uIG9mIGRldmljZSBBIAppcyBzdGls
bCBydW5uaW5nIGFuZCBieSBzaWduYWxpbmcgb3VyIGZlbmNlcyB3ZSBydW4gaW50byB0aGUgcHJv
YmxlbSBvZiAKcG90ZW50aWFsIG1lbW9yeSBjb3JydXB0aW9uLgoKTm90IHN1cmUgaG93IHRvIGhh
bmRsZSB0aGF0IGNhc2UuIE9uZSBwb3NzaWJpbGl0eSB3b3VsZCBiZSB0byB3YWl0IGZvciAKYWxs
IGRlcGVuZGVuY2llcyBvZiB1bnNjaGVkdWxlZCBqb2JzIGJlZm9yZSBzaWduYWxpbmcgdGhlaXIg
ZmVuY2VzIGFzIApjYW5jZWxlZC4KCkNocmlzdGlhbi4KCkFtIDEyLjA1LjIxIHVtIDE2OjI2IHNj
aHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4gUHJvYmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVh
ZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hlZF9lbnRpdHkKPiBpcyByZWxlYXNlZCBhbmQgZW50
aXR5J3Mgam9iX3F1ZXVlIG5vdCBlbXB0eSBJIGVuY291bnRyZWQKPiBhIGhhbmcgaW4gZHJtX3Nj
aGVkX2VudGl0eV9mbHVzaC4gVGhpcyBpcyBiZWNhdXNlIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRs
ZQo+IG5ldmVyIGJlY29tZXMgZmFsc2UuCj4KPiBGaXg6IEluIGRybV9zY2hlZF9maW5pIGRldGFj
aCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPiBzY2hlZHVsZXIncyBydW4gcXVldWVzLiBU
aGlzIHdpbGwgc2F0aXNmeSBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUuCj4gQWxzbyB3YWtldXAg
YWxsIHRob3NlIHByb2Nlc3NlcyBzdHVjayBpbiBzY2hlZF9lbnRpdHkgZmx1c2hpbmcKPiBhcyB0
aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNoIHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBi
eSBub3cuCj4KPiB2MjoKPiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50
aXR5IGFuZCBtYXJraW5nCj4gc19lbnRpdHkgYXMgc3RvcHBlZCB0byBwcmV2ZW50IHJlaW5zZXJp
b24gYmFjayB0byBycSBkdWUKPiB0byByYWNlLgo+Cj4gdjM6Cj4gRHJvcCBkcm1fc2NoZWRfcnFf
cmVtb3ZlX2VudGl0eSwgb25seSBtb2RpZnkgZW50aXR5LT5zdG9wcGVkCj4gYW5kIGNoZWNrIGZv
ciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
eSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIHwgIDMgKystCj4gICBkcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyAgIHwgMjQgKysrKysrKysrKysrKysrKysr
KysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0
eS5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+IGluZGV4IDAy
NDljNzQ1MDE4OC4uMmU5M2U4ODFiNjVmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jCj4gQEAgLTExNiw3ICsxMTYsOCBAQCBzdGF0aWMgYm9vbCBkcm1fc2No
ZWRfZW50aXR5X2lzX2lkbGUoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPiAgIAly
bWIoKTsgLyogZm9yIGxpc3RfZW1wdHkgdG8gd29yayB3aXRob3V0IGxvY2sgKi8KPiAgIAo+ICAg
CWlmIChsaXN0X2VtcHR5KCZlbnRpdHktPmxpc3QpIHx8Cj4gLQkgICAgc3BzY19xdWV1ZV9jb3Vu
dCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCj4gKwkgICAgc3BzY19xdWV1ZV9jb3VudCgmZW50
aXR5LT5qb2JfcXVldWUpID09IDAgfHwKPiArCSAgICBlbnRpdHktPnN0b3BwZWQpCj4gICAJCXJl
dHVybiB0cnVlOwo+ICAgCj4gICAJcmV0dXJuIGZhbHNlOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXggOGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+IEBAIC04OTgsOSArODk4LDMz
IEBAIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+ICAgICovCj4gICB2b2lkIGRybV9z
Y2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpCj4gICB7Cj4gKwlzdHJ1
Y3QgZHJtX3NjaGVkX2VudGl0eSAqc19lbnRpdHk7Cj4gKwlpbnQgaTsKPiArCj4gICAJaWYgKHNj
aGVkLT50aHJlYWQpCj4gICAJCWt0aHJlYWRfc3RvcChzY2hlZC0+dGhyZWFkKTsKPiAgIAo+ICsJ
Zm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5UIC0gMTsgaSA+PSBEUk1fU0NIRURfUFJJ
T1JJVFlfTUlOOyBpLS0pIHsKPiArCQlzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9ICZzY2hlZC0+
c2NoZWRfcnFbaV07Cj4gKwo+ICsJCWlmICghcnEpCj4gKwkJCWNvbnRpbnVlOwo+ICsKPiArCQlz
cGluX2xvY2soJnJxLT5sb2NrKTsKPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNfZW50aXR5LCAm
cnEtPmVudGl0aWVzLCBsaXN0KQo+ICsJCQkvKgo+ICsJCQkgKiBQcmV2ZW50cyByZWluc2VydGlv
biBhbmQgbWFya3Mgam9iX3F1ZXVlIGFzIGlkbGUsCj4gKwkJCSAqIGl0IHdpbGwgcmVtb3ZlZCBm
cm9tIHJxIGluIGRybV9zY2hlZF9lbnRpdHlfZmluaQo+ICsJCQkgKiBldmVudHVhbGx5Cj4gKwkJ
CSAqLwo+ICsJCQlzX2VudGl0eS0+c3RvcHBlZCA9IHRydWU7Cj4gKwkJc3Bpbl91bmxvY2soJnJx
LT5sb2NrKTsKPiArCj4gKwl9Cj4gKwo+ICsJLyogV2FrZXVwIGV2ZXJ5b25lIHN0dWNrIGluIGRy
bV9zY2hlZF9lbnRpdHlfZmx1c2ggZm9yIHRoaXMgc2NoZWR1bGVyICovCj4gKwl3YWtlX3VwX2Fs
bCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQpOwo+ICsKPiAgIAkvKiBDb25maXJtIG5vIHdvcmsgbGVm
dCBiZWhpbmQgYWNjZXNzaW5nIGRldmljZSBzdHJ1Y3R1cmVzICovCj4gICAJY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCZzY2hlZC0+d29ya190ZHIpOwo+ICAgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
