Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDEC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB03613B6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB03613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4176ED24;
	Thu, 13 May 2021 16:01:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255BB6ED23
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 16:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njrgv3s4PFeBqa14Jfx0NMb1/+vuxkc2fJ/CIqGnWYk1OkB69jdYmTpngr/KBBHBDHnGMxhUnhG9+euuL2AakiZ4ftri9nxo5YPaer5g3PU2rwHEwNlK3fa/KRCKkj3FO1jPS43sIxbxozf09tXZbETHpnsYefPaP0vbAwRGZ6Szy6+PoVaSp/sRq59QsG3ltTPFecrBoOFxa9LMqJde+qx/+DvRK3PQuWnuQ0veRJwTmAaJK5wCMVB4JjzQ7BUsjqvzdTrsY8ij8TWT2lCukFqwnBQkfBeFN2NAxwbwSZH4wtoOCqkRuLIHIIVjgwnp7cNvI94m7dn0ccrEYeN9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hbrCAwgjDwha6SCR7e7Sn7a3fQb6YA86ulVKWPDGng=;
 b=bvMM5KX8gfY20WqNkjBHu8T8NS17FfxLMuxz2qgJYPOaGZ8lkhjpMhlZz8IHfsKKdWP6ZDaIJeWA+U67mhURu13sZnyoUKnMIzl78qx9cqYKO7qm9DR+ACx7n2y2Yujjin2LBlfffAbTORsOX/JJw74QoP+XFJZBT458qzwRCz785T/+pTLy2uMwFMnmYWQlGJlAyiII8cu91HdTrNOyTU3D0xFH47DUreQQ40wVrZr5geooB34BhUn+0IXDIWASjus14HuWf20AkdhV4j9Wzh6T5UU9FxJqDhWnG47GGWX/i4IRtVCf7UGCVGoDzok1sJk5JFGGYTfgXT+Nz61StQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hbrCAwgjDwha6SCR7e7Sn7a3fQb6YA86ulVKWPDGng=;
 b=k641mmj2aLKsgn6P7xMjRhuWILaNBzgDx+2Uo1zKDvKnuIVjWhcakNkH/BQMAWhDZbcH7CScr6DVORVqmlNt0bfCj2TKLOsjfsEjKfLwA4xOsUwk/eLYPXUkOzzbHSDevV/fUUTRZfUdDMALXr694BsGvp3MCt2+Izcl+XoXmMk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 16:01:42 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 16:01:42 +0000
Subject: Re: [PATCH v2] drm/amdkfd: disable kfd debugfs node of hang_hws on vf
 mode
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513080839.35077-1-kevin1.wang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c5a43b1b-cb2b-fc17-c956-166abdfc2231@amd.com>
Date: Thu, 13 May 2021 12:01:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210513080839.35077-1-kevin1.wang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 16:01:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a0bce4f-432c-4a84-380c-08d9162866a7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5196C1DD918A4E3B811F689092519@BN9PR12MB5196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4TkDBdDn667BYUTnWW6gBze+hpT8E8CKNsWtN/wUEBB34vE8Je1VmNXi05z59b4KH+2+oY2a1A3z6HrB3qOGSw8q/wgra7jTR1sL+i8GQS0TRm7cFgjlOVpCDl9rpDiM5JJTKcul/wbSbM5W5LcNIesQI7FN1Lj8LTCaejkpu6emmsEntQmiDo9pd1KEWSrtc7+WZER2BtmsZY80NdKQ94rogqvhkgIKnXEdn68Gg9ZFSsipHG4GbBr/B+OUV4QbQJrNT8+rP3h0CcknJ1mtXtRgU/Vh5oUPXssmikOdC6C5qSX2fCcdjo9gzhrDgHIfyZCikh0uQDHfXsyUTydzkD7CiQSQuEfC0/Yr0zvaBlE82IBa37CH3/egfYktPpghtpzxAhpcodJyCIweKBMr+tC9K/gd9fj4mEgaOfGxVKB52LRQsZUsPlR++Ft6KQJpr9T03xLWTz1m9vABngAcNuPU+bFK9C5+ptfMBTAyLW4ePthe0eLvWQuy03Pv2PTAGkZxSEidOgyuN20x5CFy/o5sxi4BLtj8ePiVD7jajCIjEC5YOOPTw6CRmFRvllOjlbk9HzG+jGlHPdMeRKlX9YS5PkFIv1j/+EhHn9WEINCvlxN4/1YA7fQdn4GkGoU9HjjPMcw4xx8lbG8xqyljVZDCuOaZONxCAH2prj6on0+TVAgF+DlLH0cH6cNLwjF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(956004)(2616005)(36756003)(44832011)(26005)(31686004)(16526019)(316002)(5660300002)(86362001)(66556008)(66946007)(4326008)(186003)(16576012)(38100700002)(2906002)(83380400001)(31696002)(478600001)(8676002)(8936002)(6486002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vk1aY1B2R2M1dkQ0RFZRcW04T2RBVDBJRnJKdUs5dnlVcDRxUGYyOWc1YmZV?=
 =?utf-8?B?OG1NK0JhcW1IdGJlSzhYUGhjaFBtY2pJNmMvUFpVYTdxbEp1dTVOZHNlSU9B?=
 =?utf-8?B?ZXZ4STJnL0tMMjhIREJYVEsveDQ3dmdPVmdYNGFDSi9TM0Rhc3IwZm5nU25o?=
 =?utf-8?B?OFlSK01XTlJnZ045UVNxUFQzdmV6aGNMQTBHSU40aENGS1NGYldlbFVZOGlM?=
 =?utf-8?B?ZWdyd2hvVGM3NFh2cUFDSkMwNVBiSTBMdFA0cURzYlZlNDF3ZEZqaDlEcWE5?=
 =?utf-8?B?TVk4YUVqbFlQakNUdTJXZGFaWlNjWmRYbkNkZTlxMWFGWFQ4Y1pwRlZ1Wmo1?=
 =?utf-8?B?MUN6bFRBS2Q5Wnd1OTJENlZuV1NrZDRJbk9TZHZjWkJYbUc0ZWNrYWI2S0FX?=
 =?utf-8?B?cTNsT3hYWlk3bGh1UThPSEx6dmlJV3FJZW1PNjFtOG9LQ0tmd0pxbE5RdWZQ?=
 =?utf-8?B?aC9kNURtcjZZcHBNZ3pLSDdoUEZURDVFdEs5ajdaQUg1R1NOZTc1QTQ1aWxQ?=
 =?utf-8?B?SDY1OXFWSlRFK1A1TlltcGVEY1ZJVm01N0RvOVRmaExzYlNTeFBncnhDNlM4?=
 =?utf-8?B?NWkwVE1OclhyZFV3UU9zZFdrVTR4VmJOUU9HUmYyQUMzUmFKZG1mNU4wUElW?=
 =?utf-8?B?TTVFalpxWHJEbHY2Q1g2ajBmdXFCUzVIZytDS1RNeVNJZEhqd0kwdVRobitS?=
 =?utf-8?B?dzRsNzUveVF3RlJ5M0hKb3B0bWVEK0VVdzRMbjA4aE9EdzZNQjRtTU9XUVFw?=
 =?utf-8?B?VVp5Rk51a2dnZjBCWWRoWWpYOGdsN2EySzNmVXloK2JDZ2Q1cHBkRTdTdEs5?=
 =?utf-8?B?UzhCRjV1T2pPblRQUGpWandLQitib1UyaEZ3eUxDdFdNanNNYS9MaFE0MFJj?=
 =?utf-8?B?d01pemF1UjVXdHViWUtEOFRIU2wvM2xHRVlmak5QSUZ0eElEM01yenVjd0ZH?=
 =?utf-8?B?OCtDZDdtZkdYOU83ZnhKQ3NoeXI2eGQ0WncvQ1VnSVhNSHpGTnpWalE4Nk8x?=
 =?utf-8?B?YnlRUGlTTkM4M3M5dEV5ZHV5UGk0eGZUTmJRdE1oNjE2a0RmN2V0WUM0UUwy?=
 =?utf-8?B?N1ZyVGpWU1pYQjhmYmFpNGpKWkdVNnFQZHNxVWVRMm5CV0RlaW90dnZZYjJv?=
 =?utf-8?B?VnpKdWVreCtTNm9vNjdaVlUyV0pGbXhZZ2Z6M1ZZOTFlR2MxQjBtcGE5R2pN?=
 =?utf-8?B?SmF2VDlqUms1ejNVYk5CN0NkbDlsUFFYM2VSb2lPVXpSckpJOFNmZHY2UEQz?=
 =?utf-8?B?bytHWmJJbWxZS3VUWStvTktoWG1VRDNFUkJDSVljZk5uSWQ3dXcyYjN5K2ov?=
 =?utf-8?B?OUxWTkQ1TTZyNmJvOVRrL2JVbEtPZi9KTXR5QmJtbWwvT21MU0I3T3BocmJT?=
 =?utf-8?B?cEkrNGdEUFBMMXV0UWd6bXpab3d6VmJwRVJycWMzT21aSERMbzNjUkxaTWlt?=
 =?utf-8?B?djVodE9yTDMwKzhKUndKN1BNaENkaEpiVnZmVUp1ZmJ4NDE4QmJzQjBuQTlV?=
 =?utf-8?B?L1dxSjRPbWE5R3ZZT204czh4VUxsNWNieVJkSlMwY2ZPeVVrUWRMOUZMTDBC?=
 =?utf-8?B?S20vbS9MZTYvNTk1ZkZ3MVAwbys2UVl1Sk9WV2hhMlZLYWhPUDhMQjNHZ25E?=
 =?utf-8?B?VWRKYXpUeUhMQUh3WmRlSlIvSFNMWE9RVFRUMHZPSGJtRnZMdktBZUlydTdX?=
 =?utf-8?B?SHZacDVEY2xLTEhYMDFvNjg5TDYxL05WVlAvdXgyY1BPSXkxYXFjR2RHT1JP?=
 =?utf-8?B?QTJuZkozUVpybmlnSVVQTXVFOFM3VnVxV3lOd0dYSkRRRU1ZQ24wVjlCM1hP?=
 =?utf-8?B?OEpKbTFqREFJRmV4Zm1KQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0bce4f-432c-4a84-380c-08d9162866a7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 16:01:42.7349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuZbuCJDvvnU2F4e9dFJ4IOqJMbK4OBbIBwqBLaEkYKcOo7xXPFhBqg6O732TQ0p576jKCXMo2cKyT5gf7FQIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: frank.min@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyB3b24ndCB3b3JrLiB0aGUga2ZkX2RlYnVnZnMgZGlyZWN0b3J5IGlzIHN5c3RlbS13aWRl
LiBTbyB5b3UgY2Fubm90CmhhdmUgYSBwZXItR1BVIGNyaXRlcmlhIGZvciBjcmVhdGluZyBpdC4g
WW91IG1heSBoYXZlIG9uZSBHUFUgdGhhdApwcm9iZXMgc3VjY2Vzc2Z1bGx5LCBhbm90aGVyIHRo
YXQgZmFpbHMuIFlvdSBzdGlsbCBuZWVkIHRoZSBkZWJ1Z2ZzLiBJZgp5b3UgaGF2ZSBtdWx0aXBs
ZSBHUFVzIHByb2Jpbmcgc3VjY2Vzc2Z1bGx5LCB5b3Ugb25seSB3YW50IHRvIGNyZWF0ZSB0aGUK
ZGVidWdmcyBub2RlIG9uY2UuCgpUaGUgaGFuZ19od3MgZmlsZSByZXF1aXJlcyB3cml0aW5nIGEg
R1BVLUlEIHRvIGl0LiBTbyBpZiBhIGNhcmQgZG9lc24ndApwcm9iZSBpdCB3b24ndCBoYXZlIGEg
R1BVIElELCBzbyB5b3Ugd29uJ3QgYmUgYWJsZSB0byBoYW5nIHRoYXQgY2FyZAp0aHJvdWdoIHRo
ZSBoYW5nX2h3cyBpbnRlcmZhY2UuIFNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGlkZSB0aGUgZmls
ZQphbHRvZ2V0aGVyLgoKQ2FuIHlvdSBleHBsYWluIHdoeSBoYW5nX2h3cyBzaG91bGQgYmUgZGlz
YWJsZWQgZm9yIFZGcz8KClRoYW5rcywKwqAgRmVsaXgKCkFtIDIwMjEtMDUtMTMgdW0gNDowOCBh
Lm0uIHNjaHJpZWIgS2V2aW4gV2FuZzoKCj4gdjE6Cj4gdGhlIGtmZCBkZWJ1Z2ZzIG5vZGUgaXMg
cmVseSBvbiBrZ2Qya2ZkIHByb2JlIHN1Y2Nlc3MsCj4gaWYgbm90LCB0aGUga2ZkX2RlYnVnZnMg
c2hvdWxkIG5vdCBiZSBjcmVhdGVkLAo+IGFuZCB0aGUgbm9kZSBvZiAiaGFuZ19od3MiIHNob3Vs
ZCBiZSBkaXNhYmxlZCBvbiB2ZiBtb2RlLgo+Cj4gdjI6Cj4gYWxzbyBtb3ZlIGtmZF9kZWJ1Z2Zz
X2ZpbmkoKSBpbnRvIGtnZDJrZmRfZGV2aWNlX2V4aXQoKSBmdW5jdGlvbi4KPgo+IDEuIG1vdmUg
a2ZkX2RlYnVnZnNfaW5pdCgpIGZ1bmN0aW9uIGludG8ga2dkMmtmZF9wcm9iZSgpIGZ1bmN0aW9u
Lgo+IDIuIGRpc2FibGUgImhhbmdfaHdzIiBkZWJ1Z2ZzIG5vZGUgb24gdmYgbW9kZS4KPgo+IFNp
Z25lZC1vZmYtYnk6IEtldmluIFdhbmcgPGtldmluMS53YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Z2ZzLmMgfCA3ICsrKystLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICB8IDMgKysrCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1bGUuYyAgfCAzIC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgIHwgNCArKy0tCj4gIDQgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGVidWdmcy5jCj4gaW5kZXggNjczZDVlMzRmMjEzLi5mOWE4MWYzNGQwOWUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnZnMuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Z2ZzLmMKPiBAQCAtODgsNyAr
ODgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBrZmRfZGVidWdmc19o
YW5nX2h3c19mb3BzID0gewo+ICAJLnJlbGVhc2UgPSBzaW5nbGVfcmVsZWFzZSwKPiAgfTsKPiAg
Cj4gLXZvaWQga2ZkX2RlYnVnZnNfaW5pdCh2b2lkKQo+ICt2b2lkIGtmZF9kZWJ1Z2ZzX2luaXQo
Ym9vbCBpc192ZikKPiAgewo+ICAJZGVidWdmc19yb290ID0gZGVidWdmc19jcmVhdGVfZGlyKCJr
ZmQiLCBOVUxMKTsKPiAgCj4gQEAgLTk4LDggKzk4LDkgQEAgdm9pZCBrZmRfZGVidWdmc19pbml0
KHZvaWQpCj4gIAkJCSAgICBrZmRfZGVidWdmc19ocWRzX2J5X2RldmljZSwgJmtmZF9kZWJ1Z2Zz
X2ZvcHMpOwo+ICAJZGVidWdmc19jcmVhdGVfZmlsZSgicmxzIiwgU19JRlJFRyB8IDA0NDQsIGRl
YnVnZnNfcm9vdCwKPiAgCQkJICAgIGtmZF9kZWJ1Z2ZzX3Jsc19ieV9kZXZpY2UsICZrZmRfZGVi
dWdmc19mb3BzKTsKPiAtCWRlYnVnZnNfY3JlYXRlX2ZpbGUoImhhbmdfaHdzIiwgU19JRlJFRyB8
IDAyMDAsIGRlYnVnZnNfcm9vdCwKPiAtCQkJICAgIGtmZF9kZWJ1Z2ZzX2hhbmdfaHdzX3JlYWQs
ICZrZmRfZGVidWdmc19oYW5nX2h3c19mb3BzKTsKPiArCWlmICghaXNfdmYpCj4gKwkJZGVidWdm
c19jcmVhdGVfZmlsZSgiaGFuZ19od3MiLCBTX0lGUkVHIHwgMDIwMCwgZGVidWdmc19yb290LAo+
ICsJCQkJICAgIGtmZF9kZWJ1Z2ZzX2hhbmdfaHdzX3JlYWQsICZrZmRfZGVidWdmc19oYW5nX2h3
c19mb3BzKTsKPiAgfQo+ICAKPiAgdm9pZCBrZmRfZGVidWdmc19maW5pKHZvaWQpCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IGluZGV4IGRlZGI4ZTMzYjk1My4uYWE5
MTU0YTg0MTBmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+
IEBAIC02NDksNiArNjQ5LDggQEAgc3RydWN0IGtmZF9kZXYgKmtnZDJrZmRfcHJvYmUoc3RydWN0
IGtnZF9kZXYgKmtnZCwKPiAgCj4gIAlpZGFfaW5pdCgma2ZkLT5kb29yYmVsbF9pZGEpOwo+ICAK
PiArCWtmZF9kZWJ1Z2ZzX2luaXQodmYpOwo+ICsKPiAgCXJldHVybiBrZmQ7Cj4gIH0KPiAgCj4g
QEAgLTg4NCw2ICs4ODYsNyBAQCB2b2lkIGtnZDJrZmRfZGV2aWNlX2V4aXQoc3RydWN0IGtmZF9k
ZXYgKmtmZCkKPiAgCQkJYW1kZ3B1X2FtZGtmZF9mcmVlX2d3cyhrZmQtPmtnZCwga2ZkLT5nd3Mp
Owo+ICAJfQo+ICAKPiArCWtmZF9kZWJ1Z2ZzX2ZpbmkoKTsKPiAgCWtmcmVlKGtmZCk7Cj4gIH0K
PiAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1bGUu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1bGUuYwo+IGluZGV4IDVlOTBm
ZTY0MjE5Mi4uNmI5ZjczNWM1NWVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9tb2R1bGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tb2R1bGUuYwo+IEBAIC02MSw4ICs2MSw2IEBAIHN0YXRpYyBpbnQga2ZkX2luaXQodm9pZCkK
PiAgCSAqLwo+ICAJa2ZkX3Byb2Nmc19pbml0KCk7Cj4gIAo+IC0Ja2ZkX2RlYnVnZnNfaW5pdCgp
Owo+IC0KPiAgCXJldHVybiAwOwo+ICAKPiAgZXJyX2NyZWF0ZV93cToKPiBAQCAtNzYsNyArNzQs
NiBAQCBzdGF0aWMgaW50IGtmZF9pbml0KHZvaWQpCj4gIAo+ICBzdGF0aWMgdm9pZCBrZmRfZXhp
dCh2b2lkKQo+ICB7Cj4gLQlrZmRfZGVidWdmc19maW5pKCk7Cj4gIAlrZmRfcHJvY2Vzc19kZXN0
cm95X3dxKCk7Cj4gIAlrZmRfcHJvY2ZzX3NodXRkb3duKCk7Cj4gIAlrZmRfdG9wb2xvZ3lfc2h1
dGRvd24oKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
aXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiBpbmRleCBkYWE5
ZDQ3NTE0YzYuLmYzZGRkOGM1YjExZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcHJpdi5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaAo+IEBAIC0xMTc0LDcgKzExNzQsNyBAQCBzdGF0aWMgaW5saW5lIGludCBrZmRfZGV2
Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oc3RydWN0IGtmZF9kZXYgKmtmZCkKPiAgLyogRGVidWdm
cyAqLwo+ICAjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpCj4gIAo+IC12b2lkIGtmZF9kZWJ1
Z2ZzX2luaXQodm9pZCk7Cj4gK3ZvaWQga2ZkX2RlYnVnZnNfaW5pdChib29sIGlzX3ZmKTsKPiAg
dm9pZCBrZmRfZGVidWdmc19maW5pKHZvaWQpOwo+ICBpbnQga2ZkX2RlYnVnZnNfbXFkc19ieV9w
cm9jZXNzKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqZGF0YSk7Cj4gIGludCBwcW1fZGVidWdm
c19tcWRzKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqZGF0YSk7Cj4gQEAgLTExODksNyArMTE4
OSw3IEBAIGludCBkcW1fZGVidWdmc19leGVjdXRlX3F1ZXVlcyhzdHJ1Y3QgZGV2aWNlX3F1ZXVl
X21hbmFnZXIgKmRxbSk7Cj4gIAo+ICAjZWxzZQo+ICAKPiAtc3RhdGljIGlubGluZSB2b2lkIGtm
ZF9kZWJ1Z2ZzX2luaXQodm9pZCkge30KPiArc3RhdGljIGlubGluZSB2b2lkIGtmZF9kZWJ1Z2Zz
X2luaXQoYm9vbCBpc192Zikge30KPiAgc3RhdGljIGlubGluZSB2b2lkIGtmZF9kZWJ1Z2ZzX2Zp
bmkodm9pZCkge30KPiAgCj4gICNlbmRpZgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
