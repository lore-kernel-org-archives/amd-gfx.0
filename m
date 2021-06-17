Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE912C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 16:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BC361003
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 16:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BC361003
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93336E1E6;
	Thu, 17 Jun 2021 16:19:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0E96E1E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 16:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXSNmwUyBt/DfuAMnIl+0OSNBvYUjQ1wclppQ8VCboWzVu6LSXUZlqZPTM5snYflRLLDhjXOG9eh6z+CiYV2wGeh1zMypmVtrBdIkoCDVNLWIeaD7DVzJtXGvLRrurQlGhO7UABsSsz7BNgjY83XJf1ZKryiuTL9VTZJyuWgNX2vIkAFy2XJbpyPR0QVlqsrYo1vvPZfZSdO1OnzZ5AOWQkfXPrHeE6/kjqQuFJqBFbxpyCCF9nMzjTqln8D2zY04LpeU5EaBJJQi8sZm6AT7vo1toLR93uVJL7hAcYAHcH8wEX1PTWAoC/7e2u8Vz8pCmmwhUDL/FNdRy9p2ktWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPA/U3kr/DRirCdPWitdDBqnJ7ABaT/RSPCuVk07I2w=;
 b=jQw+4GLVFIBqQwYP/iHRJTIamFRhOA79lmqb0t5UmcAc7Yqy/qQpECxGaA/DqrcjR6kGE8cMPGr+5nRsFm9fWY3r8suSY/dxSach9/DTk4eaGEN59/+kpxrJ4yshEbl/Qog5MJlTZer88RZ5vxuOd5q0TV8sydEP7sqnT1VVpEk9rtrbfHm4DtsdFzml9vUQPSSG3nhqdhgIkxSCFbu8joIfoie20XCZDMSDlO1WRpfT1bt54AaGbDkyAConzZkQgPShlEtPJ5sqOjoi8SToug2p7IVhyoAOGqRS9xysOJJ3PxZg2sz2i4zCHJaq0Nzq2zM3nFcFA6Wrh/pO+XxoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPA/U3kr/DRirCdPWitdDBqnJ7ABaT/RSPCuVk07I2w=;
 b=2+fwwOz11RsI0Jg6ltosFKa4PillZQUWE1F4DFRhTW5LdGFGiCE9mhKMU8OomF0H8MUG3A3bmQ8BXGOGjfUD+yZ0gXptGWVm7IULZbSUpNHs4ubDDe4/NX9WPnAN3ogyANDWTHue4w0Ta1li3obrH4d73avj7CZIFXqb5dNWRx8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:19:04 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:19:04 +0000
Subject: Re: [PATCH] drm/amdkfd: Set p2plink non-coherent in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210617142059.400829-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <118a7111-430f-f408-2114-eb56194144ea@amd.com>
Date: Thu, 17 Jun 2021 12:19:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210617142059.400829-1-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19 via Frontend Transport; Thu, 17 Jun 2021 16:19:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d575926f-12b8-4b24-00e1-08d931ab9fab
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5132ABAF02A69178BA9E2FA3920E9@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZIdxHKVr7Cwx5zqXdvSx+NdkXt+EDcroG6mnJFPqajM7ZJIQ4qfgzjtTTdZeO5xKAMmZlDftCFTrztOmXT9K6hlm9QzOgcF3ivJr3E0GmVL1WSB2i4Hx3eEQ30MiK0g+dZvQi7JPusKxbrrDBhqWBx9JGN4OtRu/FKYgEiDesjatbxpzwcY0CY9wbRy3hW+eWEwji3uYhT3EGRZssdaQWHzhnxIoGIr7wLZHxsRB/vfBn3q7Wkp7Ci3fVs1n3A4etCaZG7juqWu3Y7N5XcC6nipjK5XUGPF/9Gs9MM2GSPkEDFTX9gW/R2NYr22hWbW4kwUNeLQS6UWz8mJxoqKiczPxgLW4ggFWktB9V3YrsqTw9ZZb0TX4f2PLoeKt7aCMGUvPJkoD9eE+J4H4IxXSBFrNhQ3jrDpom9gtvFwiLz5+t1RmtZZNv3FCqxiL93NCUK0iwFhR6mMi/FemiWw6vqDCJqDlrMvtf2UO5g+6wSz+6YjSxXFJk+zOdFp1wRO3Nz2RO/JlzEa5pDawY3PjCEzFANsKKtU33ESyxM5WSryh9NAR21C/VXAsDXg2tjN0/8Ecq1DK432kNUZCqxBiPAt8ZRZpPUHZbEcGTQ+BKkSDBTtgW/jJrjoaV8uTkxNjhJ9ZTkESnhOg6vUf2+XjVCVwMWu+/g//yu05HMolfhNz0l4FRgSG4ijlJ1P8qrm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(66476007)(66556008)(8936002)(66946007)(478600001)(956004)(5660300002)(86362001)(8676002)(38100700002)(186003)(6486002)(16526019)(4744005)(31696002)(36756003)(2906002)(16576012)(31686004)(26005)(44832011)(316002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnEwV3pLcGxTT3ludEdRcG5XaTNRVFpPTmFpMERzS3FwT052cFo5NGI4cE83?=
 =?utf-8?B?dzcvZjNGQzhVMy91UDhGYUtFR1pMQ1VnTE05dTNtR0FqWXdrS0lBQkNocHkv?=
 =?utf-8?B?elV4MEszMW9XRVEzdHZ3SnNPcUVvTFIwZWlVbVRoZjh4U21EZXVRN205d3VF?=
 =?utf-8?B?cFBQcWxQWUxyaDdxVC9sRU5HWDZWbWFnaFYrY3hvbGtLWFFwNk8wUDNJTHJs?=
 =?utf-8?B?cXI4QXQ1TFg5OTFkYnJvUjVsMHR4eGVpdTI5K3hlVkpvVkgyWCtFYjBxbVB5?=
 =?utf-8?B?Z2gvM04yZkp4U0xucjM2a0hGczBDMDhZQXF5ZDVhTHdLUlYxZVcxVWdDWUFZ?=
 =?utf-8?B?bXFLdVZaOVpnZEZqQzk5cWtIa3lzaVNCV3BycFlNSVBOUWhvczRENFJIRHlq?=
 =?utf-8?B?aFdJQ0lVMkJaVkpENUp0UDJIeWhKZEpvZHFNc1FmQlVHTWR0dkVUQ295UVl4?=
 =?utf-8?B?RHJsQjE3eHdPaGRiRDlkU2ZxWnVaMlVROTMwVVNEUlFXT1hUaFUwd2sxdCsv?=
 =?utf-8?B?ZWg5bXE0RVJQUytMWXRLRGhmcGJNNlB6TGxMT1F3ZlRiVlMwZnJHOGhoZDZp?=
 =?utf-8?B?WEdTR0l4V2loR1pHU1V5Y1hick4wRFJxVjNES1FQNndmdjFrT3F1cFU0Mm1W?=
 =?utf-8?B?SFQzdDIwaXVJZ1prYWJ2QnpRY1NzTnBLb1RHYjhnK3FaYXByWmZvQTV5ejc3?=
 =?utf-8?B?K2twbUpRdXhOaVVGL1N4aEFOd0hwWkgreGNTckJ5aWt3VEhHQVF2ZTM1MlRm?=
 =?utf-8?B?T3BPakVlVm0vV3FsMGQ2c2hKd3pETVJUcG5SVEM0MnpoSG1rL1M4NVZwditD?=
 =?utf-8?B?MUxiN2lVQVkydlU2dlFEYk9VK3RrVlVldGN1dkdLeDhnN1FEWHJib2lNYk1S?=
 =?utf-8?B?OFY1L05zQXBmTm45Y0tsc3puLzhSTmJGZE4yem9WSloybnRNdUFJVnNhM2hL?=
 =?utf-8?B?eVpjalJlbitIVWZick92djNIUlpGeWJmUXdxMVZ1djd0bDJSWmNSREFuQUEz?=
 =?utf-8?B?T25zRDAzY3NtNDlYeGp4dXVQWWxoT0lwdzV4TysyYnBZc2tFUC9uY3RZaTNP?=
 =?utf-8?B?VmJjd3NVaGVIVVpBcDBKUGs3bHVqcVRBeHYxN0lKWFRDQVM5cVlxWnV1TzIv?=
 =?utf-8?B?UnlxUFJjZmUzVUNEVCs2dkV2VzVFaUl3VG1kN1RBRUs1akZ2Y1F2YitndzVT?=
 =?utf-8?B?QjZ3NVhWUFdXcEFhTmRGUFU1TnNTYmxPRnlkUWN4bkMvZ1RRdUNHb0xnQmZl?=
 =?utf-8?B?NXBQdVo0UWpmQU5hcCt6U3FTZDVVYjY5OWxEbkhmc2pHdVN5Z2pKTU9wUk1t?=
 =?utf-8?B?U3FlbTNjU0FyTjVXK3RXR0ltVE04cEt0M3ZCWTNVMTJTOUYrUGhwY2JwUzRp?=
 =?utf-8?B?OC9WUTFxem1OYmMzOFdDZ01LY1hsREtSYXdXT1ZGelRpdU5wcUV4VXZlazQw?=
 =?utf-8?B?dENNNjZyT3hqU3ZOdWJVQyt1MHduclFDNnY3QXdrSDUwMXNZalk0Q3hpRzcv?=
 =?utf-8?B?T0Zod09JUDRMMmlnQlJ6VzBxVmN6MXhMRGorQzVPV2dMNDlaNGNwK2JjU3No?=
 =?utf-8?B?YWFMYXU2aFE2NHMxTzZvY2w0ZDI0M2c5bUdLNHByaVgweURVU2I4alBpcnFZ?=
 =?utf-8?B?WEs1RVlkdnNCTU1kV2lnSEJ0WUNNUXRHcSs1QUJTTWZOZjlleTJXbk9BaDI5?=
 =?utf-8?B?eFY1VE1pRTJ3WGwxMG83Q1pJY1dUcjdXeGxibG5lTDVwNkY2eWNzZGJnRGQw?=
 =?utf-8?Q?h+oi9djgQaTz5Y48HLeIWNumrOTzw6NaXsirETr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d575926f-12b8-4b24-00e1-08d931ab9fab
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:19:03.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e86qbRBIRhDHzrtzEEZhAdCEIi7w8fMLiFlP9aIN/uG90gsjF3o9rmeZm67qE5YFH33B3tKT3RoqSwf1028Rjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWYgdGhpcyBpcyBmb3IgdGhlIERLTVMgYnJhbmNoLCB0aGUgcmV2aWV3IHNob3VsZCBnbyB0byBv
dXIgaW50ZXJuYWwKcmV2aWV3IGxpc3QuCgpSZWdhcmRzLArCoCBGZWxpeAoKCkFtIDIwMjEtMDYt
MTcgdW0gMTA6MjAgYS5tLiBzY2hyaWViIEVyaWMgSHVhbmc6Cj4gRml4IG5vbi1jb2hlcmVudCBi
aXQgb2YgcDJwbGluayBwcm9wZXJ0aWVzIGZsYWcKPiB3aGljaCBhbHdheXMgaXMgMC4KPgo+IFNp
Z25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgfCAxICsKPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfdG9wb2xvZ3kuYwo+IGluZGV4IGQzOTBhYTM2OWY3Yi4uMDcwNWZmNWVhYTI2IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiBAQCAtMTQwNCw2
ICsxNDA0LDcgQEAgc3RhdGljIHZvaWQga2ZkX2ZpbGxfaW9saW5rX25vbl9jcmF0X2luZm8oc3Ry
dWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldikKPiAgCj4gIAkJCWluYm91bmRfbGluay0+Zmxh
Z3MgPSBDUkFUX0lPTElOS19GTEFHU19FTkFCTEVEOwo+ICAJCQlrZmRfc2V0X2lvbGlua19ub19h
dG9taWNzKHBlZXJfZGV2LCBkZXYsIGluYm91bmRfbGluayk7Cj4gKwkJCWtmZF9zZXRfaW9saW5r
X25vbl9jb2hlcmVudChwZWVyX2RldiwgbGluaywgaW5ib3VuZF9saW5rKTsKPiAgCQl9Cj4gIAl9
Cj4gIH0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
