Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1ADC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 23:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A73461027
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 23:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73461027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB8689AB6;
	Wed, 16 Jun 2021 23:09:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD4E89AB6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 23:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5j2bpRHqr1gzGIEukJj29XODX6ptfl9eZWXYa+dYkbiWvY+Ul4GgH1bw5lrBddboY1mSrMCijSJZzlij+kPJ/l3LPEjem21oKSN+HYoLumz4OPUTCo50KUulbvTqdkwPWhHeSAgXrvcSa3U/nfD+U44qn/hCIhk/Q//j3is9o7Jy21lk/tvcLkA4QlIzVpj1ZGzb0kK3nel9Cjd8jGTAz5iitDNPQ0ShOfNeYeUpP1fqnVIHAFJmlGFp5++u1I9zekEPuyPBsWbYY/7qABFBZwlb6OqprW9Md+Afe6Vzu14zGmrlxg5zs3DG7OTIanGhSvnyy1EbAyrjabSMB69eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHDa4VKS614IZl67gjR37rhCGY1mtlU9Q4t7r5+i+XQ=;
 b=cW4CoApGDdhbqitCoF5dr02wpeoSgXOWrMn9BjfG8Tv5vHCq/FNPZeQwjrrGDmdYsP3Inc7sEFvku9fpCEEg6y1xOijLFC3uWo3+o32kcTQfY20tdVAmcw7HX2phSITB86vGrRid1aNn2WLCecY8OEmaoGMoml+gR6zTmcUmRdy1izIRS/LZzxyIZQRMNqPVo4+P3lPc/oqfZ3IdAs/aeoMIWU2KjQwuxmncEbjsENcsKEib/e20nNG1Xwsg5Xfl3JzWLFUz9JG8NNIokl9wstAMvbz3C796j9QsIswoiBdA6fvsSqELwx8j+2YVm6V28mQ8chqs0d/JRk+nQcRFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHDa4VKS614IZl67gjR37rhCGY1mtlU9Q4t7r5+i+XQ=;
 b=x95nGRjFHKx8uI77BswsgcoNaRee7NY2tNXmso/63tOJ8ZdjkKkoio1tCvgIJFg8bVj9QzeMnKnOmHaKjsax2Ppc0A9j59B9VJxg53YgwXXaMkmojFCCy92gtsdzjFxUM2C/+z3ApB+98N/lD+elBleaepzfXjFXn+nb8vyzFSo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 23:09:14 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 23:09:14 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Walk thorugh list with dqm lock hold
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210616083511.2489-1-xinhui.pan@amd.com>
 <20210616083511.2489-2-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4f9fa596-f64e-8ddb-2c91-5a03bb378775@amd.com>
Date: Wed, 16 Jun 2021 19:09:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210616083511.2489-2-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 23:09:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80a6f338-2488-44a2-2866-08d9311bc227
X-MS-TrafficTypeDiagnostic: BN9PR12MB5100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51002629A8FDE1C83C5EA7F7920F9@BN9PR12MB5100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWpNkIlE/6DknUy3AoiTBGyhK3DwbEfNdafNWHsrR/J1GuqcLO2tGJUNNY2eUdeMtWUKlpJfUNX+2LYvzcHm6hOxOlDEstMWWlZ8k//l9eBg87TPLRca8wjvhO2ezWtrwG+zH0V2bbAJYuhxgNdcWpLJEqH4uFzflW1P0oiRTj3bw/pn7xoBrTZllJ92/gDX2VGS8MHbvpaMJfDerAT1+cexV1AfABBNtDqd735aEp6kQr165Ez8EnF3R468Cr+6M6HX4ChjkxWBxtj631AUWmyxQyEgkt2CCLf0iNSgMaL6Dp5WkN7u3RpMVhWV2+TUwgZ9NzAdcgDDfuIEmyafpsy8kkaqgbC1EGyElpabOUG5zpe4w2lbpUu1Zslqj6VzPcDZnk5XvvFVF0kxH/45ee6SSrcwFwsteFlrOsCTj6J3IIPCYN1BQdrMaMdEjWPCFKu50G6DSuptyFl6c7glo3+WLyy1ZOH/gKymhM/ivqVolFd0eSo/P371WYRhfKRXJdtiZDj7ZhpvzzcxqZ0yumxQc6TkM+6iU7VBo7IsHOL6rVM6k0tkd6dBUUMEmrwuADXMNlBvaTmYv4r9B4iKV/NeDbWKJ215xgHCtcPpqoyAZRzIcB+Qufcswyks2/4593JlZyPpLGN3SIjdyJFbUzG06BGdog2CIF1pAtSwPWfwUHU9eC90WcNB+1qnmP94
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(2616005)(83380400001)(8676002)(36756003)(6486002)(186003)(8936002)(26005)(44832011)(53546011)(16526019)(31696002)(316002)(36916002)(66556008)(66476007)(2906002)(4326008)(38100700002)(66946007)(86362001)(31686004)(956004)(478600001)(5660300002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWwrY0wyNXA3VFZVc1Q2VDYxaFp3bWFPV2haWUlDT2huV0RjTUljZmtDRnZu?=
 =?utf-8?B?aFBIUXNLb0tzUSttWWdkZzA0V0lBUVpBVE4xQlBvR1kvcXQyOG5BaFg5Nmdm?=
 =?utf-8?B?a3crQjdMT3J0UWZUME0ySkNYOXlvVS8wU3ErMXViOEJ0UTVSSEg1QUkwODNC?=
 =?utf-8?B?K0dQQ21UaWJ0ZXdvZ2ZsR1FINEwxSzk5T1NMSTY1T25qTzRqSFMrYXp1RmQw?=
 =?utf-8?B?TmRHei95UTQ4MTUvRTl5Rjk0WGUwTVYzL3QzUGc2YS96Q1RnZFBmWWNqRnpN?=
 =?utf-8?B?S01vQWQrMTFrS25DbDMxTW5kRkV3QUhudE9WQk9vZzh6L0hPVTBOMnB4b3Jl?=
 =?utf-8?B?ZjRtYkIzNjc0RjJFUEtZYzIrNGEzR09KdWpOSWFnWlZPczhyVUtqQWVJS2E4?=
 =?utf-8?B?eVFSaExKWVRpeHk1MDhBWXZQckwzbEE5WFY5YjBhNFZRUmtpYzROVmh4dnkx?=
 =?utf-8?B?czRFRnNDTVpudHExNkxGU2tISTRZWXBWRWQ1OUhFZHBsUDVTMG11M0ZHNUZl?=
 =?utf-8?B?ajFJdW9sN3F0SGFmSGExelJZVGl0czJsSERmUmYxTnN3ckZjakhTWDNiQjZ6?=
 =?utf-8?B?UVBvOFFLczVINnVRSUJtQ21hUnRZdUhQa0JvMTRpSFQzQks2a3hrUE1ZTFZX?=
 =?utf-8?B?djRZYTIybkR6MmF1V0Z4Mmo0U2c5NnFGNnRsMTNJZUQvMTJXV0UrRVlUWUdv?=
 =?utf-8?B?UVdoSHFqeGpxcmpKYjFhUmovT1YvZXkwcVdoN28wVmMrWDZkMzFHa2FQUjd2?=
 =?utf-8?B?Wmh6b3FLZjVDakc2UjYwMmQ3MWNDaE94VGtiNzR2emkyZHJYbXRsQUtuSEVJ?=
 =?utf-8?B?cUQ4TjZib3QwcVF1MU9xS0h2MkxmRjNmQVY3V3ZmR053SDNqMlBBWStndzN6?=
 =?utf-8?B?Nk5GL1o0eWY3T2Q4QllMNDhIbXRsdzFWTzd1SUlhYVd1VldpY3k1V1VBVkxS?=
 =?utf-8?B?eFFPV0IrYUlmWXVna1FnUzZLUVZZRWV4TE9JR0k3OUNXbWZKeUdpNk1vR2JV?=
 =?utf-8?B?eSt3eWExMnNvT1MrVXlKYXo2QjZmZTh5U1U0Vis3TWlUWU03eEplZXNzd21v?=
 =?utf-8?B?Z2FwT0EvdEszbWtlMWVsa3hxYkNsK0t1TE4vUExRZzlPWGhYNi95U1dSMmdw?=
 =?utf-8?B?dS8xUzJNSWhkYklUQXltdmlFaVNqSUdqUDhpSWI3NVZnUHptVnVmK3JDNW03?=
 =?utf-8?B?cnRPNnFDOTd1NmhpdkNSTWRNa1NjR3p4ZVRleDA0QWJBQjcwemw1WUI3WGtX?=
 =?utf-8?B?Qzg0dkVXYmtxbXBGVjJENC9YTnhOVmJxN0gwbXJuS1dXT3hRcFR0cWFmMWdo?=
 =?utf-8?B?VGhPY1Zidkp0bUsybXB1WndIaXhkOENWL1ZnUitoQkQrTnoyQzRkY1djeFln?=
 =?utf-8?B?MWpLZ0VXRGpjSmJRYmJZVEdEaEpNQzBmd3JlRTA0YTlHM2hUUDRJNEFHSDVT?=
 =?utf-8?B?VW42ei9WVEZTc0JFSnoybmZoUlllUE1ETFhtRCtJUnlNM1BvdG1SMWxHN2xP?=
 =?utf-8?B?UVdkem8ra2IzaEdKZCtJLzNzNTRCWnFCMFRnZkpNMCtzc0NyZVNSVlp1TTFB?=
 =?utf-8?B?aSsweVVnTXloNGMwSnZROHZxcFNUbThjd3Z0dVVJSjlmWGV6aEh2VHFTOW1h?=
 =?utf-8?B?T00rbGQ4OXFmQUVaandXaTBBWE1HZVU3OFdjRXBlSU8wTXNzd0lhYUc1REhn?=
 =?utf-8?B?cStlMEtJQWFaSVE5Qm40b0VqVHpLbDZpWGt2dUx1WkkrbTA4eFFaWElSSWJ4?=
 =?utf-8?Q?lPjJnsPAE6Bn+9tu/R2ngL+aAsc2yJjA/lq5HUv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a6f338-2488-44a2-2866-08d9311bc227
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 23:09:14.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkop+zZSaWsfjmramxEKYIFrOuLoQFZUgWOy4TTZPYWc7kUYtyKT9ISRbWu9dRQ6J4m0Lh1GdZU228yPc9KX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0xNiA0OjM1IGEubS4sIHhpbmh1aSBwYW4gd3JvdGU6Cj4gVG8gYXZvaWQgYW55
IGxpc3QgY29ycnVwdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5w
YW5AYW1kLmNvbT4KPiAtLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9x
dWV1ZV9tYW5hZ2VyLmMgICAgfCAxMiArKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IGluZGV4IGMyNGFi
OGYxN2ViNi4uMWY4NGRlODYxZWM2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBAQCAtMTcwNCw3ICsxNzA0
LDcgQEAgc3RhdGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdCBkZXZpY2Vf
cXVldWVfbWFuYWdlciAqZHFtLAo+ICAgCQlzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNlICpxcGQp
Cj4gICB7Cj4gICAJaW50IHJldHZhbDsKPiAtCXN0cnVjdCBxdWV1ZSAqcSwgKm5leHQ7Cj4gKwlz
dHJ1Y3QgcXVldWUgKnE7Cj4gICAJc3RydWN0IGtlcm5lbF9xdWV1ZSAqa3EsICprcV9uZXh0Owo+
ICAgCXN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21ncjsKPiAgIAlzdHJ1Y3QgZGV2aWNlX3Byb2Nl
c3Nfbm9kZSAqY3VyLCAqbmV4dF9kcG47Cj4gQEAgLTE3MzksOCArMTczOSw2IEBAIHN0YXRpYyBp
bnQgcHJvY2Vzc190ZXJtaW5hdGlvbl9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIg
KmRxbSwKPiAgIAkJCQlxcGQtPm1hcHBlZF9nd3NfcXVldWUgPSBmYWxzZTsKPiAgIAkJCX0KPiAg
IAkJfQo+IC0KPiAtCQlkcW0tPnRvdGFsX3F1ZXVlX2NvdW50LS07CgpJIHRoaW5rIHRoaXMgc2hv
dWxkIHN0YXkgaGVyZS4gVGhpcyBpcyBvbmx5IHVzZWQgdG8gY2hlY2sgdGhlIG1heGltdW0gCnVz
ZXIgcXVldWUgbGltaXQgcGVyLWRldmljZSwgd2hpY2ggaXMgYSBIVyBsaW1pdGF0aW9uLiBBcyBm
YXIgYXMgdGhlIEhXIAppcyBjb25jZXJuZWQsIHRoZSBxdWV1ZXMgYXJlIGRlc3Ryb3llZCBhZnRl
ciB0aGUgY2FsbCB0byAKZXhlY3V0ZV9xdWV1ZXNfY3BzY2guIFNvIHRoZXJlIGlzIG5vIG5lZWQg
dG8gZGVsYXkgdGhpcyB1cGRhdGUuCgoKPiAgIAl9Cj4gICAKPiAgIAkvKiBVbnJlZ2lzdGVyIHBy
b2Nlc3MgKi8KPiBAQCAtMTc3MiwxMyArMTc3MCwxOSBAQCBzdGF0aWMgaW50IHByb2Nlc3NfdGVy
bWluYXRpb25fY3BzY2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4gICAJLyog
TGFzdGx5LCBmcmVlIG1xZCByZXNvdXJjZXMuCj4gICAJICogRG8gZnJlZV9tcWQoKSBhZnRlciBk
cW1fdW5sb2NrIHRvIGF2b2lkIGNpcmN1bGFyIGxvY2tpbmcuCj4gICAJICovCj4gLQlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUocSwgbmV4dCwgJnFwZC0+cXVldWVzX2xpc3QsIGxpc3QpIHsKPiAr
CWRxbV9sb2NrKGRxbSk7CgpJbnN0ZWFkIG9mIHRha2luZyB0aGUgZHFtIGxvY2sgYWdhaW4sIGp1
c3QgbW92ZSB0aGlzIHVwIGEgY291cGxlIG9mIApsaW5lcyBiZWZvcmUgdGhlIGRxbV91bmxvY2sg
Y2FsbC4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4gKwl3aGlsZSAoIWxpc3RfZW1wdHkoJnFwZC0+
cXVldWVzX2xpc3QpKSB7Cj4gKwkJcSA9IGxpc3RfZmlyc3RfZW50cnkoJnFwZC0+cXVldWVzX2xp
c3QsIHN0cnVjdCBxdWV1ZSwgbGlzdCk7Cj4gICAJCW1xZF9tZ3IgPSBkcW0tPm1xZF9tZ3JzW2dl
dF9tcWRfdHlwZV9mcm9tX3F1ZXVlX3R5cGUoCj4gICAJCQkJcS0+cHJvcGVydGllcy50eXBlKV07
Cj4gICAJCWxpc3RfZGVsKCZxLT5saXN0KTsKPiAgIAkJcXBkLT5xdWV1ZV9jb3VudC0tOwo+ICsJ
CWRxbS0+dG90YWxfcXVldWVfY291bnQtLTsKPiArCQlkcW1fdW5sb2NrKGRxbSk7Cj4gICAJCW1x
ZF9tZ3ItPmZyZWVfbXFkKG1xZF9tZ3IsIHEtPm1xZCwgcS0+bXFkX21lbV9vYmopOwo+ICsJCWRx
bV9sb2NrKGRxbSk7Cj4gICAJfQo+ICsJZHFtX3VubG9jayhkcW0pOwo+ICAgCj4gICAJcmV0dXJu
IHJldHZhbDsKPiAgIH0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
