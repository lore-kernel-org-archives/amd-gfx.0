Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1EEC48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CBC60FF0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CBC60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DDB6E984;
	Wed,  9 Jun 2021 15:32:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FD26E984
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 15:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECoRkWTLi+9IHLSDrEbA9jhNiZDZQktn233fjQypdsn6VRSS5TkkaKWY7m8dc9RAXKPKDPUyQy3Jwus85nOLf+4SHd5zEv64B9pa+X1kiwBr4ZVsbWyUY2yiCDu7luTLI7cRp9yvjo8l0id6+M3+Yy7NIiJdn2iZNeJ00sZCDIYWpWnJZRC/RIgjgdGqM1IwJpziA7AIOrW8/EzCfAmgYmca3G30srR6+6OfGocJ8g6URgh0feLtWewDpb472J5lJDO+bckjVYJJWI+LRkPj8VPqigy1fMNQ7LXawcDZUMKrNvRTRfEKkGT3lse/tTHWU/QEetqRrRY6P+Br/YyS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5EN4X2vF/cy8sHIqC/2WAV56GFGDi73yuFlUzX9HLk=;
 b=J96TVCxxkNa+lOaA7cDqcIIY/f9D3d+Av77CTPqkDLy7idIQLyJ7h3SiH3o/7d5YiRy/XnGWHYQ9yDt/hD4OG1SzGllpUifTVWLa3tdyvWZs/0M/oIe2IKGcJsB6iyGl9FfewIlAaXIhHX6qTD+Ma8KlqfcEP9h8bQhD1ohDjn2eTfIvcmk0Ze0teT26HLe4xBgB1+Q9TMHAOeqJXN9oyVS9/VOpTuLsHS3M8zJbvRr1dPc8h5FXrkd1Xiep9LWTVkTWiLjhzs1TImqV2zX3uwEJyu8/TJzAC7KpRQQjNuLbl21DT4ftKiBDqxaNacd6tvN1Y7Xz5PHwS9vLTnHA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5EN4X2vF/cy8sHIqC/2WAV56GFGDi73yuFlUzX9HLk=;
 b=ZBf7voVTW8aDRS93rtvx/K7Hj3LdQYbwl4ZlMRPdRJ2eN2/fQkJZUGMejuqn+IBp2TwJNj9qhOoRsiPphWXqsyF7ukS2nEU+Q5EsXLQ7My4jgn4ChEI6hrMkNbFmGC8t5M/Lb6Gp5B+9lEiL8YmW+PVqhUD+hrKVbcpHiUMhICc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 15:32:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:32:13 +0000
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
To: Luben Tuikov <luben.tuikov@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210609092323.32650-1-guchun.chen@amd.com>
 <ab48ac1a-16a4-3bc2-13e4-bb3c1fb6a3ba@amd.com>
 <59df3448-f49c-1390-5031-327293bc1f38@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b8747525-02ac-e41c-c0e4-1b8a7bcd4b7b@amd.com>
Date: Wed, 9 Jun 2021 11:32:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <59df3448-f49c-1390-5031-327293bc1f38@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YQBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::29)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YQBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 15:32:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8451cd9a-3c9a-48fe-0881-08d92b5bc152
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52892A0276003A0E3173665192369@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlytWU2dpkix8tjOdBHwneo6AZrizV6xajT1N9RbynBywSCKEvsiv2Z7OyFWEMcwsaca+VHfwOje9WVfEgWDuTC1RYiCku4QMRJALDys1JMtkEJ+Wj4ZNjuQSeeSI3JNkhdtrcHE6f0Drk0AzhAe5l1UhklzJ6zjWlVtK14qpr4Qi/wC8+UXHERSu6mRWy9stmXRgg1ff896cDiiswnYj0Y7VAODZFn8w5bCnmuYVPPHKl46J2DmKrLBgAUbjaDmbJ2v5LxxfTAjh/eaz/To9kvbE5E/dU2FddmlusmSAEXcT6STujIl+X06i6aXK1fNqemvnXywqUiZIcaTGL1uGeBb6GwHIlHtB75LjUwN4Kk3+xyacj5bfApAHMyAmq5F/tyF7ANMfE6bmSDBDmpVK1t3jNaT1XSm1y+wbZlbrYC4bxRhoJQFYzd559Tce/gSeds5rMLJerwRHoF26NNCk0UX1baXP19+DT+lqgjAPtt992JAcroZoMJCdQh+HfT7PJEve+ozVOToXTxfM/2Kizx1BCPH9IgW6l0W6tsm1ygtkQTatPaBY+PJCttSCN7N2dOT/fXDg7dCfDtWfKjaPVGEUbiB9uZyjtFC3wgzmQd+AM3ibSN6Z+nZLZHEQV97wEl9RikSqzKt3ft0Qy7JxgU/QYmoirut9PywTvNu1MU1Vu9jXy2ABlpYH42u430f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(66556008)(36756003)(186003)(66946007)(478600001)(31686004)(16526019)(31696002)(66476007)(38100700002)(8676002)(53546011)(26005)(83380400001)(956004)(110136005)(86362001)(2906002)(5660300002)(8936002)(2616005)(44832011)(316002)(16576012)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1UxNGdvSVRPTFpuc2EyT3I3aEZmZjl6WkYxb0hnMS9rSWt0em11Q0xnUG5l?=
 =?utf-8?B?L201QmtsbnlUTXBrR2thVm1SK0VmNWU0S0ptditzK1BEWVVjNnZUZzd5VHNM?=
 =?utf-8?B?a2hSbDd3TjBtSHBtNW9Hcm1BRXZyYXhnakV3T2hBMVVyeFM1WlllNzNPaVRP?=
 =?utf-8?B?aDRmVFNhVkhxS2xZdGNBNGJ0WG80bTBZazhrR05uVXFyV1NNRHdFUXhWb09t?=
 =?utf-8?B?eVd4MWxxcXVLK1N4TFdIVExwNFFPYzJGMmFUTmRLdzY3Mm55cTdJRUhnMEw3?=
 =?utf-8?B?bjUwMzE0WmxYRDVWRFBIUVV0RzJoNVhFZS9IVFZ4VXZiWnVvd1JxdmFwZVgw?=
 =?utf-8?B?d1o2aitqVlExUTBSMG8rT0lJQTFtMlVqOFhlTDIwcFhKTzR6bmFQdUhLZzFw?=
 =?utf-8?B?OUhNczZLc3BsYi84MGtTN296L0xWQUhyV1BYUXo2K0FHU3JUbEhreUlrbWww?=
 =?utf-8?B?Wld3bCtXOEhlTmJ3eElGRWJqalNvWUVsN1hiQlhYTDN1WDQ2cGNnNFJaK1Z4?=
 =?utf-8?B?QnpwR2x4MjZneXBqakxBQjdSRTNOS21TNmpXdzBoYWNkenR6VzVSN0l3bEpE?=
 =?utf-8?B?NU9Zams0NkVpVFJjdkEwSDFGL0UzUFEvb3FVQkd3NmF6N2RTaTc3eEpQOTRF?=
 =?utf-8?B?SHNSZDR4Rlh3a0h4OXlIejRvV3dHZ0hMMkQ4YTRsc2FValZwOVc5L3VRUWhW?=
 =?utf-8?B?cFMwYlFvY2V4THlwWHcyVTdXQk5sTHYxQXNHdkVYNzRCb09MVDRjS1NwYnU2?=
 =?utf-8?B?dURCeStUb0ZlRWdUaW5Na05sRkNrc0hpaHF2M3N5Y1hmODhURXV2UGRrU2pE?=
 =?utf-8?B?bHVwY2JSbW05cEg0alZlKzIrblZOZUgyb2ZwYmhpQnN3bjFneU90dHNxd0Iy?=
 =?utf-8?B?WmY0djVTU1FMNUtVQkhxMUlvL2ZxWXRwUTgwMW94dUlmUEhSclU5eFR6amhK?=
 =?utf-8?B?K0YveGN6bWdYTmp3YUJUYytLaXNyUzl4dk9hSUVDSVQ5eDYveHU2Z0dUU28r?=
 =?utf-8?B?eTNuenp2OTB1aXcrSDVmRGxpc00yL3BVMTFPUi9vdDFPTERIaTdtczZMb0Vi?=
 =?utf-8?B?TFBKNlRGY0xyNnRHQWN2V3dHK1EzeWRWcHN0NEZvVkJWUktkQ2NpaDNIWmZD?=
 =?utf-8?B?djdRM2ZzL3pIbXJ5Y29yTmlOWG5kVWw2N05vbWppMkF4cmM5WFpSNWljWEJ5?=
 =?utf-8?B?WUFYZnVOM2hXWWFna2draWhnTFcxc3Y5SG5hYWozQ3RwS0IwQVVDc1U0VjJG?=
 =?utf-8?B?Q0lyTUFmNi9HL29aK2hpVVhSVHVEN0dweGt4RHY2NWhTZWxhblBrNlVaMTBU?=
 =?utf-8?B?ZUc0TGJZREV6WUdvcjk0S1FNNFRGMm1MWjkvSm5MNGRpbVh5NGxlMWFFYVhT?=
 =?utf-8?B?UnlBUGJIbVpobEx5aFNDdlZZeTlWYTlySWVGYkxqTzYzSkticGNJS2E0aGY4?=
 =?utf-8?B?ekIrRU1iVUV4SmQzejZ4T1JSWTh3dUVETDg4czU4VU1Kc0dWeDNrZ1ZBTCtD?=
 =?utf-8?B?UFZ5VUhxQXE5LzBpWWdPNVBRNCticFlyWXd1T1IxM08ybFYwNGN4SkFTVERk?=
 =?utf-8?B?Ni9LRXQzQVNDZkl5bWt6RGdWakxVRFYwU28zZzhkUHlTWUVDRU12dEozNmg2?=
 =?utf-8?B?ZU15RC9Fd0RYYXgxMnVoZ2FRWTM5WXNDSVNJd00xcEtXNmZSbE1HVFh2Ly9h?=
 =?utf-8?B?SktMYzJibjB3Qjk4ajdEWi94ZU5OVTRhM1orVGFFNWxRVHJ6SUIvMVVObU1q?=
 =?utf-8?B?eDJvZU1BQVEyVWtHOXZEWmRVK0lDVFhNSW0xTytVdWtMQ0RyeDJtd2VOUTFI?=
 =?utf-8?B?OFZ1OTg1N0FkUDgwQlZkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8451cd9a-3c9a-48fe-0881-08d92b5bc152
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:32:13.6028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkXrg8/6PhbDLYApcwn5XlEkPIjO3+BclfuP8WBVyr+oNGeRND16spN4336qQGnOaBF60F7MiZ2bvxJXLCPvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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

QW0gMjAyMS0wNi0wOSB1bSAxMToyMCBhLm0uIHNjaHJpZWIgTHViZW4gVHVpa292Ogo+IE9uIDIw
MjEtMDYtMDkgMTA6MDEgYS5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4+IEFtIDIwMjEtMDYt
MDkgdW0gNToyMyBhLm0uIHNjaHJpZWIgR3VjaHVuIENoZW46Cj4+PiBGaXhlczoKPj4+IDlmYWYy
NjJjMzJkMyBkcm0vYW1kZ3B1OiBBZGQgRE1BIG1hcHBpbmcgb2YgR1RUIEJPcwo+Pj4gMDkwZjNh
NjBkN2U4IGRybS9hbWRncHU6IFVzZSBkZWxheWVkIHdvcmsgdG8gY29sbGVjdCBSQVMgZXJyb3Ig
Y291bnRlcnMKPj4gQSBGaXhlcyB0YWcgaW1wbGllcyB0aGF0IHNvbWV0aGluZyB3YXMgYnJva2Vu
LiBIb3dldmVyLCB0aGUKPj4gaW1wbGVtZW50YXRpb24gb2YgYWRldl90b19kcm0gZG9lcyB0aGUg
ZXhhY3Qgc2FtZSB0aGluZy4gSSBkb24ndCBzZWUgdGhlCj4+IHBvaW50IG9mIHRoaXMgcGF0Y2gu
IEl0IGRvZXNuJ3QgZml4IGFueSBwcm9ibGVtLCBhbmQgSU1ITyBkb2Vzbid0IG1ha2UKPj4gdGhl
IGNvZGUgbW9yZSByZWFkYWJsZS4KPiBXZSBhZGRlZCB0aGlzIGR1ZSB0byBzb21lIGNoYW5nZXMg
aW4gRFJNOgo+Cj4gOGFiYTIxYjc1MTM2YzMgZHJtL2FtZGdwdTogRW1iZWQgZHJtX2RldmljZSBp
bnRvIGFtZGdwdV9kZXZpY2UgKHYzKQo+IDRhNTgwODc3YmRjYjgzIGRybS9hbWRncHU6IEdldCBE
Uk0gZGV2IGZyb20gYWRldiBieSBpbmxpbmUtZgo+Cj4gSXQncyBnb29kIHRvIHVzZSB0aGlzIGlu
bGluZSBmdW5jdGlvbiwgdG8gYWNjb21tb2RhdGUgbW9yZSBmbGV4aWJsZSBEUk0uCgpUaGFua3Mg
Zm9yIHRoZSBleHBsYW5hdGlvbi4gSSBmb3VuZCB5b3VyIGNoYW5nZXMgYXMgd2VsbCBhbmQgaXQg
bWFrZXMKc2Vuc2Ugbm93LCBlc3BlY2lhbGx5IGZvciB0aGUgREtNUyBicmFuY2guIFVuZm9ydHVu
YXRlbHkgdGhhdCdzIG5vdCBhCmp1c3RpZmljYXRpb24gd2UgY2FuIHVzZSBmb3IgdXBzdHJlYW0u
CgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPiBSZWdhcmRzLAo+IEx1YmVuCj4KPj4gUmVnYXJkcywK
Pj4gwqAgRmVsaXgKPj4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4u
Y2hlbkBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jIHwgMiArLQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYyAgICAgICAgICB8IDIgKy0KPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+PiBpbmRleCAwMTY4MTViN2E3NzMu
LmZiNmJjYzM4NmRlMSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+PiBAQCAtNjM5LDcgKzYzOSw3IEBAIGtmZF9tZW1f
YXR0YWNoX2RtYWJ1ZihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGtnZF9tZW0g
Km1lbSwKPj4+ICAJCX0KPj4+ICAJfQo+Pj4gIAo+Pj4gLQlnb2JqID0gYW1kZ3B1X2dlbV9wcmlt
ZV9pbXBvcnQoJmFkZXYtPmRkZXYsIG1lbS0+ZG1hYnVmKTsKPj4+ICsJZ29iaiA9IGFtZGdwdV9n
ZW1fcHJpbWVfaW1wb3J0KGFkZXZfdG9fZHJtKGFkZXYpLCBtZW0tPmRtYWJ1Zik7Cj4+PiAgCWlm
IChJU19FUlIoZ29iaikpCj4+PiAgCQlyZXR1cm4gUFRSX0VSUihnb2JqKTsKPj4+ICAKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPj4+IGluZGV4IGVjOTM2Y2RlMjcy
Ni4uYmZiY2I5ZmYyNDUzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMKPj4+IEBAIC0yMTIyLDcgKzIxMjIsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFz
X2NvdW50ZV9kdyhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+PiAgCXN0cnVjdCBhbWRncHVf
cmFzICpjb24gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9yYXMsCj4+PiAgCQkJ
CQkgICAgICByYXNfY291bnRlX2RlbGF5X3dvcmsud29yayk7Cj4+PiAgCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gY29uLT5hZGV2Owo+Pj4gLQlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0g
JmFkZXYtPmRkZXY7Cj4+PiArCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBhZGV2X3RvX2RybShh
ZGV2LT5kZGV2KTsKPj4+ICAJdW5zaWduZWQgbG9uZyBjZV9jb3VudCwgdWVfY291bnQ7Cj4+PiAg
CWludCByZXM7Cj4+PiAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
