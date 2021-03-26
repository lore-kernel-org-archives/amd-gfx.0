Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE8C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76B261938
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 14:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76B261938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A036F3D1;
	Fri, 26 Mar 2021 14:49:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169686F3F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 14:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB4PkqwQkzkhrCyipZTKMVPiGoXlNJzp8VaDqWaDHxvlvPTGL06D/aqOf+s8yYehjC3PBoHuGCxQeBrVAq5mTjqL1r3BfVSOi0zZ9TcMuzMgxdQ1ITYBt9EC687Q/Us8EClrdXZcOVE5vpwH402+uRypXbhpxtG4q9sfUFO+1yugR54GzlyrMsjuPc7s1hlC2Rr2z32iHKAXZJEe16gnBT6lXjY3h49H5oz7bIQBVB8huyacYkMXDnQmD+26eZE2XRGTxnJXZA5oz9jGGjXTq6PCozNqlhJPtgwdZKpU4p4ZYYz4RUGLO1mdWEgZUj5vDXF2fTifhQ/FiSUTlKJx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl4z0riYaJ42KD4t8L81ZnSGR1AAKhHbmxVTJH4TTnQ=;
 b=nhiBCAf4NG9vtjoJq5H2/SshHbtyDvUYS1cEiQVAgoE/tZNE9VVdivRdVhqfSDpaYibqzAe6gWcL9lPjGLh65LD23A0IVnsvha3dRAQ0nCdTfhtcxN6lKZs+xOqpg9XNOq25LZoVq++KKf4UoIe60PsE7m6Us9LQEHIBXszOfNF64a/ucjPXk0M9vxYYik9u3itsrAwx1LJ0Wt0rEf2g9LPBDzl5Hv9VlptcplteBJghG0D8jymm9wZHrsYbgsdZxM0dshvQyNfBHLTzoL8AUtm5l7dt1lGTB/Kvtm5j3P6d9JUYCNuvbw3VzYZ3If+tqV7BDN3vVGIUhN8WXOaaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl4z0riYaJ42KD4t8L81ZnSGR1AAKhHbmxVTJH4TTnQ=;
 b=46gt+xjXVv9X4x2GpB4ZQVZNVLgHuF0FeqSmrY9Ee+l2GJmKKrGJmtsv3tIRQhuBhpQ2ly+VHrkmXcWjMsGJG3Ye4uyBZLTnkqGquT03TqBijmFyt5JUPNMSL/Wvxyj++dzprkb8pvWNIQ/1BKlWgLJQjvCTRM5QXBW+TDfkERg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 26 Mar
 2021 14:49:02 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.038; Fri, 26 Mar 2021
 14:49:02 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
 <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
 <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
 <7c4be3bd-8d73-bd8d-3eed-9ddc68a9c364@amd.com>
 <6bfefd19-ca3f-72d4-6d29-34f2f4885aab@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1ce7475f-f52e-e44c-d9b4-3ba1a7b2f0a7@amd.com>
Date: Fri, 26 Mar 2021 10:49:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <6bfefd19-ca3f-72d4-6d29-34f2f4885aab@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::42) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YTOPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend
 Transport; Fri, 26 Mar 2021 14:49:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cad9d13b-b528-40b3-dedf-08d8f0664bfb
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486734E6A94311CBF2F2C9D692619@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03pAJFLiqAg17/Y6sBGMOJVZz9i8k0/sEKfi6vNm6xRXJ0vyEB7Zq3FmVG+KTP9+4DtWyLdzdKpzTOWaVK+w/1kl5n/fA7xugg+J2pOuG8XbH89YwJdfATix5ydTIH/HeH6x5caMkWfd7mUJmhURNKCPsnlRUNu0NU8bQu4MsEYoyfEBYvmgNb8DBH+YQo0NAgThxHc6CR8q0k1ZxZ9DkPGojx4dO1+8CFIlkAzREy6UOEkh9MBEx9wI7K4RHIYHIDKZuabVaQB2rTo8RGfGOWyzUoqEE9S0Apd86lcjv4ndot3e4dkaVYYBtgzuvld/L+AIKFLUfOKWpeFQfFPdspywXAyx7dmim6at7XT2rzCZz3WJa29rss33PPxcENVOne3ku7A+qRhei30amchpRq7T+eBOstTCFTVQMVDIdwHAHC+GWxWB+6etPmNYgkx+LJV9paRYqmpYzAVICBQ1pJ48WVgVGMEjvw55ddJmZrmCskn0mO52ptcENGvSVgWlQ/F6vrxkg9Nbv90HHVPP3UHCSVtodZFvm6GUlDDZqALehPM4ysO7cFj4FRxAFOmbhAGAXWZx9sDptjDWb8iC3x2d3t9jPbrnPTnDYF94kadquR4X0MCVgQr8byUKFf3XUMM+BQO1Nc2jFm12LYE1avDAYVR1RcN/CQOpNHPWCIFdo/zHTU8yT23H1NcC0kt2Z7APirGJmoKHyvzKOPTmEUFm9+FSG6WtuZE2XejDHXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(66476007)(38100700001)(2616005)(2906002)(66556008)(478600001)(956004)(16576012)(186003)(110136005)(26005)(16526019)(316002)(8676002)(36756003)(6486002)(66574015)(86362001)(8936002)(44832011)(66946007)(83380400001)(31686004)(5660300002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1lycUp0N3NLcmZRSW1TcU9oRkRIM1grejluZCt6U0VEZXRpelczeVFOb1pk?=
 =?utf-8?B?bWVVanE0b0VRNlBvOCtpL2txNGhVcm5tam5BcXQwTW9uOXFNZ3NMbXBhcklp?=
 =?utf-8?B?WVM5R2ZhZ1NRM05FZ2oycXNHaUJ1ZkFuNkxxTGY4TXlqQnlDR3ExTithRGhP?=
 =?utf-8?B?bnRXWGxsOUp2Q084T2cvQnlOaW1pM3k1M0w3Z2xmTjAvZ1FISnJqTWR2bjdD?=
 =?utf-8?B?OExDbjRVZTQ0MStyL1o0VzROWElvQlRRWDFYcFd0ci84SzcwL0IyNVJOS3l3?=
 =?utf-8?B?R0hEQTFtOTdkc3FSRDc0RkZYQzN6QnpmemJwWjRoMXpmTXdscGdOK3h4Tk12?=
 =?utf-8?B?OFdteGYvamFuYk5rUVlESVlTeERIL2FKRTBMcGs2aUdrRDAwUmFtUW1RNit0?=
 =?utf-8?B?UnNMQ1REeVFkQXg3dnVwalpFNzZMOG9sMnpscDRJY3ZDN3pIai8zMXB5WFBX?=
 =?utf-8?B?RWhQTEZDWmdJQ1NiVVB0TTFQUWNld0tMdDk5aURhQktOQXZQazlUQUxaS1hP?=
 =?utf-8?B?cmVua3Z0RDhoSzJ4UHBaMWJYcnVtck9nM0pMZG5OdFoxSWFFbXFueFBKME81?=
 =?utf-8?B?ZUx0c2dDdUJCanpIYWlLYzNmelU2V2YzOWNNYjNUMWJpYzEwTmhLS3c4d0wy?=
 =?utf-8?B?Yzl3eTQ3SDFGY0wxSXpPbHBGZGRWMVhYNlp4RkFPU2Rlb3l6MHVIeWc3MWYw?=
 =?utf-8?B?MlkrRmhSSHRIOUhvZjVybXJsYWtiQ3AycUFrV2NyeGxscmxiZnNVWlVSV0ZX?=
 =?utf-8?B?NW9GSUNIUzFLVlNQTVRNUURZTnR6R1RNZk1EQ2l1TE54a0h3MTlQZ29HUmZp?=
 =?utf-8?B?TlhOekJIRUtxVzhYMUZhVkVnZXRaTDFybk9uWXoxOXg2RXFBRlEraU5tZU5j?=
 =?utf-8?B?ckdjTlBPUU95Wm1mVjhRVXhDUFVMbW50b1Yvb3JpWXJBMXhwbStlZVFnQyt1?=
 =?utf-8?B?Y1JqczEreU5LUXlvMnp6MGl6eGJpSzRWbUJoWlYvdTI4NFhlY2RHVUUrb0tL?=
 =?utf-8?B?OURPL0ttM3VYQ2sxRXkzdW9DakxnMk1hRGdHOERMdnJxZEk1VEJWa1QvbzdE?=
 =?utf-8?B?UDMxUWJobklGNlFIT1M0NUtZTklQQWM4MXFkWURzZG94NVZWQU02dkpPT1Yy?=
 =?utf-8?B?ZEV2YndpL2w2MU9XcVNBeCtQQ3Z1NHArUk8vMjV0ZVJsbm9PNU5tUlBIZ0Fu?=
 =?utf-8?B?WTNIMmRWUmJFL3B3Y2VMSEw4YkZhU1ZIWE12aGMwMUtSSVVvQnM4YUY4c0Rt?=
 =?utf-8?B?UUZrOUxJWDdHR1YxY3dodzRTSHBYMmlxK25JSW5hSCtGSkliVWxWb083SHlq?=
 =?utf-8?B?WkFkU1llb3pPQmZmMlFxbWphRTFseVp5cFlrZzZXRktPd0xPb2tIWm5zTkN2?=
 =?utf-8?B?cVFkZEhBK2RtUitqSnplUW1Kd0FaT2RLaGhRVFdEWnVPSUViT1RKL2VneVVp?=
 =?utf-8?B?b1VEMzNxUUtmNVQwTElwN0xiM21YVklwMXZOYk85aE45d05nYmNjejcwRDRY?=
 =?utf-8?B?NXRoZFJWL0RFSUY5ajhXRHBiTWsybThsWHpvL2taMmNpU3JQTTAvamw0SlZq?=
 =?utf-8?B?YndLK2M4R2JQT2xQczlCUVNXSytSUkx2STRHUXN0OS9aK00xWkJZeFRPZEZW?=
 =?utf-8?B?UU56ZGxUdmRkMENJazNCVDl0am5IYW5CYnlKMXRpQU9rYmg1WWtadDZRbnRJ?=
 =?utf-8?B?WEUvVkMzU2dhVjM2LytJTkREL2RMdEIrZ3lPSFc1YkZjaVVxRVV3U3BwdUFW?=
 =?utf-8?Q?hMW1IYwKIKsKEf/j8HFpa4kL0pLtUnKMhhvC6Ct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad9d13b-b528-40b3-dedf-08d8f0664bfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 14:49:02.6556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGT4CSttHIkev63B47SCPpAiCEh+63QAZC7oIEhVCuOMokNkEtrWGXEi//qCqHIdYj0E2XNxA3p1O+MkhA6ohQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
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

QW0gMjAyMS0wMy0yNiB1bSA0OjUwIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Cj4K
PiBBbSAyNS4wMy4yMSB1bSAxNzoyOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBBbSAyMDIx
LTAzLTI1IHVtIDEyOjIyIHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+Pj4+PiBN
eSBpZGVhIGlzIHRvIGNoYW5nZSB0aGUgYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nIGludGVyZmFj
ZSB0byB1c2UKPj4+Pj4+Pj4gc29tZQo+Pj4+Pj4+PiBoaWdoLWJpdCBpbiB0aGUgcGFnZXNfYWRk
ciBhcnJheSB0byBpbmRpY2F0ZSB0aGUgcGFnZSB0eXBlLiBGb3IKPj4+Pj4+Pj4gdGhlCj4+Pj4+
Pj4+IGRlZmF1bHQgcGFnZSB0eXBlICgwKSBub3RoaW5nIHJlYWxseSBjaGFuZ2VzIGZvciB0aGUg
Y2FsbGVycy4gVGhlCj4+Pj4+Pj4+ICJmbGFncyIgcGFyYW1ldGVyIG5lZWRzIHRvIGJlY29tZSBh
IHBvaW50ZXIgdG8gYW4gYXJyYXkgdGhhdCBnZXRzCj4+Pj4+Pj4+IGluZGV4ZWQgYnkgdGhlIGhp
Z2ggYml0cyBmcm9tIHRoZSBwYWdlc19hZGRyIGFycmF5LiBGb3IgZXhpc3RpbmcKPj4+Pj4+Pj4g
Y2FsbGVycwo+Pj4+Pj4+PiBpdCdzIGFzIGVhc3kgYXMgY2hhbmdpbmcgZmxhZ3MgdG8gJmZsYWdz
IChhcnJheSBvZiBzaXplIDEpLiBGb3IKPj4+Pj4+Pj4gSE1NIHdlCj4+Pj4+Pj4+IHdvdWxkIHBh
c3MgYSBwb2ludGVyIHRvIGEgcmVhbCBhcnJheS4KPj4+Pj4+PiBZZWFoLCBJJ3ZlIHRob3VnaHQg
YWJvdXQgc3R1ZmYgbGlrZSB0aGF0IGFzIHdlbGwgZm9yIGEgd2hpbGUuCj4+Pj4+Pj4KPj4+Pj4+
PiBQcm9ibGVtIGlzIHRoYXQgdGhpcyB3b24ndCB3b3JrIHRoYXQgZWFzaWx5LiBXZSBhc3N1bWUg
YXQgbWFueQo+Pj4+Pj4+IHBsYWNlcwo+Pj4+Pj4+IHRoYXQgdGhlIGZsYWdzIGRvZXNuJ3QgY2hh
bmdlIGZvciB0aGUgcmFuZ2UgaW4gcXVlc3Rpb24uCj4+Pj4+PiBJIHRoaW5rIHNvbWUgbG93ZXIg
bGV2ZWwgZnVuY3Rpb25zIGFzc3VtZSB0aGF0IHRoZSBmbGFncyBzdGF5IHRoZQo+Pj4+Pj4gc2Ft
ZQo+Pj4+Pj4gZm9yIHBoeXNpY2FsbHkgY29udGlndW91cyByYW5nZXMuIEJ1dCBpZiB5b3UgdXNl
IHRoZSBoaWdoLWJpdHMgdG8KPj4+Pj4+IGVuY29kZQo+Pj4+Pj4gdGhlIHBhZ2UgdHlwZSwgdGhl
IHJhbmdlcyB3b24ndCBiZSBjb250aWd1b3VzIGFueSBtb3JlLiBTbyB5b3UgY2FuCj4+Pj4+PiBj
aGFuZ2UgcGFnZSBmbGFncyBmb3IgZGlmZmVyZW50IGNvbnRpZ3VvdXMgcmFuZ2VzLgo+Pj4+PiBZ
ZWFoLCBidXQgdGhlbiB5b3UgYWxzbyBnZXQgYWJzb2x1dGVseSB6ZXJvIFRIUCBhbmQgZnJhZ21l
bnQgZmxhZ3MKPj4+Pj4gc3VwcG9ydC4KPj4+PiBBcyBsb25nIGFzIHlvdSBoYXZlIGEgY29udGln
dW91cyAyTUIgcGFnZSB3aXRoIHRoZSBzYW1lIHBhZ2UgdHlwZSwgSQo+Pj4+IHRoaW5rIHlvdSBj
YW4gc3RpbGwgZ2V0IGEgVEhQIG1hcHBpbmcgaW4gdGhlIEdQVSBwYWdlIHRhYmxlLiBCdXQgaWYK
Pj4+PiBvbmUKPj4+PiBwYWdlIGluIHRoZSBtaWRkbGUgb2YgYSAyTUIgcGFnZSBoYXMgYSBkaWZm
ZXJlbnQgcGFnZSB0eXBlLCB0aGF0IHdpbGwKPj4+PiBicmVhayB0aGUgVEhQIG1hcHBpbmcsIGFz
IGl0IHNob3VsZC4KPj4+IFllYWgsIGJ1dCBjdXJyZW50bHkgd2UgZGV0ZWN0IHRoYXQgYmVmb3Jl
IHdlIGNhbGwgZG93biBpbnRvIHRoZQo+Pj4gZnVuY3Rpb25zIHRvIHVwZGF0ZSB0aGUgdGFibGVz
Lgo+Pj4KPj4+IFdoZW4geW91IGdpdmUgYSBtaXhlZCBsaXN0IHRoZSBjaGFuY2UgZm9yIHRoYXQg
aXMganVzdCBjb21wbGV0ZWx5IGdvbmUuCj4+IEN1cnJlbnRseSB0aGUgZGV0ZWN0aW9uIG9mIGNv
bnRpZ3VvdXMgcmFuZ2VzIGlzIGluCj4+IGFtZGdwdV92bV91cGRhdGVfbWFwcGluZzoKPj4KPj4+
IGlmIChudW1fZW50cmllcyA+IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0UpIHsgdWludDY0
X3QgcGZuID0KPj4+IGN1cnNvci5zdGFydCA+PiBQQUdFX1NISUZUOyB1aW50NjRfdCBjb3VudDsg
Y29udGlndW91cyA9Cj4+PiBwYWdlc19hZGRyW3BmbiArIDFdID09IHBhZ2VzX2FkZHJbcGZuXSAr
IFBBR0VfU0laRTsgdG1wID0gbnVtX2VudHJpZXMKPj4+IC8gQU1ER1BVX0dQVV9QQUdFU19JTl9D
UFVfUEFHRTsgZm9yIChjb3VudCA9IDI7IGNvdW50IDwgdG1wOyArK2NvdW50KQo+Pj4geyB1aW50
NjRfdCBpZHggPSBwZm4gKyBjb3VudDsgaWYgKGNvbnRpZ3VvdXMgIT0gKHBhZ2VzX2FkZHJbaWR4
XSA9PQo+Pj4gcGFnZXNfYWRkcltpZHggLSAxXSArIFBBR0VfU0laRSkpIGJyZWFrOyB9IG51bV9l
bnRyaWVzID0gY291bnQgKgo+Pj4gQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsgfQo+PiBJ
ZiBhIHBhZ2UgdHlwZSBjaGFuZ2VzIGZyb20gb25lIHBhZ2UgdG8gdGhlIG5leHQsIGl0IHdpbGwg
ZW5kIGEKPj4gY29udGlndW91cyByYW5nZSBhbmQgY2FsbCBpbnRvIHRoZSBsb3dlciBsZXZlbCAo
YW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKS4KPj4gSSBkb24ndCB0aGluayBhbnl0aGluZyBuZWVkcyB0
byBjaGFuZ2UgaW4gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzLCBiZWNhdXNlCj4+IGFsbCBwYWdlcyBj
b250aWd1b3VzIHBhc3NlZCB0byBpdCB1c2UgdGhlIHNhbWUgcGFnZSB0eXBlLCBzbyB0aGUgc2Ft
ZQo+PiBmbGFncy4gQW5kIHRoZSBleGlzdGluZyBjb2RlIGluIGFtZGdwdV92bV91cGRhdGVfbWFw
cGluZyBhbHJlYWR5IGRvZXMKPj4gdGhlIHJpZ2h0IHRoaW5nLiBJIGhvbmVzdGx5IGRvbid0IHNl
ZSB0aGUgcHJvYmxlbS4KPgo+IEJ1dCB0aGVuIHlvdSBjb3VsZCBhbHNvIGp1c3QgY2FsbCBhbWRn
cHVfdm1fdXBkYXRlX21hcHBpbmcoKSBtdWx0aXBsZQo+IHRpbWVzIGZlZWRpbmcgaXQgZnJvbSB3
aGF0ZXZlciBkYXRhIHN0cnVjdHVyZSB5b3UgdXNlIGluIHRoZSBITU0gY29kZS4KPgo+IFVzaW5n
IHRoZSBwYWdlIGFycmF5IHNvdW5kcyBsaWtlIGFuIGludGVybWVkaWF0ZSBkYXRhIHN0cnVjdHVy
ZSB0byBtZQo+IHlvdSBvbmx5IGNyZWF0ZWQgdG8gZmVlZCBpbnRvIGFtZGdwdV92bV91cGRhdGVf
bWFwcGluZygpLgoKWW91J3JlIHJpZ2h0LiBJdCBjb3VsZCBiZSBkb25lLiBPbmUgbmV3IGNhbGwg
dG8gYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nCmV2ZXJ5IHRpbWUgdGhlIGZsYWdzIGNoYW5nZSBh
cyB3ZSBpdGVyYXRlIG92ZXIgdmlydHVhbCBhZGRyZXNzZXMuIEl0CnNob3VsZCB3b3JrIE9LIGFz
IGxvbmcgYXMgdGhlIG1hcHBpbmdzIG9mIGRpZmZlcmVudCBtZW1vcnkgdHlwZXMgYXJlbid0CnRv
byBmaW5lbHkgaW50ZXJsZWF2ZWQuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gUmVnYXJkcywKPiBD
aHJpc3RpYW4uCj4KPj4KPj4gUmVnYXJkcywKPj4gwqDCoCBGZWxpeAo+Pgo+Pgo+Pj4gUmVnYXJk
cywKPj4+IENocmlzdGlhbi4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
