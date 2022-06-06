Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04620C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 10:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA0110E560;
	Mon,  6 Jun 2022 10:25:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AD710E560
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 10:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD0aiID4MpqN3q+5CbGiPl7lDNMTPzM4yKJmx3zIztAn+0ln8ZtYECM0qc+0W6lz4JFw6UBEk8l+5iiu7DIS0ZMbt+QaNyd9/p9ZPBKvt9/6ljLWhvNdEuaMGLees/zXKfEd3BXET2A2Yvm896KqAjcYDG2ikk9XvsJd4m5e4dFs5he3ifQlFk8L0vlsuj24Igd+615WJm8GCjaPPgfJfiN+JfC53yj26QcQA0hreiXojYgh19u0eSi54XYk+zrForKueKjzGTTkHQEjrsJC89XN25eXWtvcKAR23s/BdE0qE2Ib2OQdgGjifqpPf4QaVkdC+G76UiByMy/FiLk9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMrgWxohJp65oa53VT+mqRodADyabkwMcjyScjg4zJs=;
 b=Ymdlxvalc30WsCS6tTjMbnZXszDBnmAAjwPqKXNHAPatcAy3Z+rBNgqcDbXNpprtiIt29LiX7lm4bBJoFjZ3kzxb79ZiaSxZPiik9Zyv8Q1iWZG6bK7Iz7Lnpmg/F2rvkmtBiTdRm6EerUY0LP7ikAAimVqXkqnf8/dGT6k+t6+KetYOvO5c6nhsw8L9E94suKpdrgGBVZ7hteB3m9w9ur6nWHhxfjOSVYZEUbc/blNvxBQeV7PLai/hz183VGnMo5mxeZyOOT1WyEdrKAEmB+xudovicAulB+Fu9Q/gZB2Rl2HqKccf79TxHl2JQLlFzQi7glUl74GgMkcVW0xf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMrgWxohJp65oa53VT+mqRodADyabkwMcjyScjg4zJs=;
 b=uq4MT1w5aCUW06t6FrtRSYzmiTflNauhzNS6XmFZuDX4PBLG6+B20hMPFRY2z1Tr3MKbIbiDqDSsoVLEokOFflRCXY4CiYIUGDLu5c62TZYl6lPAblv10alf0Bw0zN1kcTGjobGsdrLnloTqHtQZHVYbPGV4XBVIr2egPe0SSoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 10:25:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 10:25:16 +0000
Message-ID: <a9d69525-04f0-5f75-b7a6-5a09199deb15@amd.com>
Date: Mon, 6 Jun 2022 12:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>, Alex Deucher <alexdeucher@gmail.com>
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
 <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
 <20220602142254.2ck7dw7u3xlzdnt2@lion.mk-sys.cz>
 <CADnq5_MiQKX4JA-3xbxGYXKHpJqD0Px1NYSiL6yPeTwseoNVGg@mail.gmail.com>
 <20220605220055.cshuzyveneu5a4hf@lion.mk-sys.cz>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220605220055.cshuzyveneu5a4hf@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0506.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 653f477c-b49c-4ef2-d223-08da47a6d934
X-MS-TrafficTypeDiagnostic: MN0PR12MB6198:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6198B2AE4EC3402A5DDA17C683A29@MN0PR12MB6198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxaAMo8GCuXx+W5cLF5s8w3zFBQ2hQwWUjBFvXfNbNMC3MA3QUEYCdSbztM1VkabcOxCye9A6Qfbyp/krOqht53tijYySi0Q4XEFoBZgkv6j77GitcLhmbqi1Uednb7nTucGVjAvqDCTxyGmgSb7aUBuiHqj18L5E57H4K6SfcpRtb1Ursh/x+U1upUlYFntGnMwJwEl394JrVjnX6DF4Ag3v5oB+uaXqHmuuQvS+vfFSCKIzVKJIVgBnQTqQdmxJNonoh+XBe+mWU+aygbBWhseOuLJg96aMP8sVpZvRb+HHDkKA95VVrdcG7F9Mfu6rMUFerKjz/SMRHM6NVqHDJNYOZUYJWG4dFMPvBtWK2FrG+qrHxNhMcE1lc3ciT0X6UC8Lzt3Qjf14XzEOi3Fh/QlaJunA8DJo+PA1nTVTKmDk5HXRWPrLv9o+nL9+RM3omhOUx/sOKYhpAReHZ7FufT6VM/qIG1UbNUT9gENUSsuZQE7S7TPk/mpVkGHZkyzgRDn3qOyPamPEClz9D0oGlH40r1abECMUCzvQAXtgviDZriR5+wx9voNEI765BwACCBK0FlFOFuw3OVtfKx4Mu5Px2WuulxjoRQif4I1YlrLugSehjPZQ3l5tLGQzPyQbTlNCgFH+5uQKiy3JEC+JDRgan51EKXWmHxxrfihM96tG6brYNrPQZhP+mLMmc2I0hDoY0OwrTPoqETCVXuDIbj6npH2gntKZBARppjxlCxixDXzvjNArxYFToIF+JBR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8936002)(6666004)(31696002)(2906002)(6486002)(966005)(6512007)(66946007)(86362001)(508600001)(66556008)(8676002)(4326008)(66476007)(2616005)(5660300002)(54906003)(316002)(31686004)(110136005)(36756003)(6506007)(4744005)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZ1cFhQZEkwczFwa2d6RXJSTFBVdlFyQlFYeXY4N0xMaExrangybXAvclFZ?=
 =?utf-8?B?NGg5RkNISTJNbXJYM2VHek0zL3A5QzVnUC9Mb29QaGlDcXNSdmNjL0dRdE5O?=
 =?utf-8?B?V3pNVU9DekNWYkc4aEZFYmNWYStoWGpjbStUbFJnbWlqQ2haK3Bnak8zTEdG?=
 =?utf-8?B?bWlReHhjTE0rQ3FVTHpkVlN2d3R0Rkw0Q0VRMzUzbUZMMjdxVFd2RnlFbXZK?=
 =?utf-8?B?R2pRT0NFcTMxeGJya2RoTVJPdEtIQm44OHV5NmNCRkNiaTdxd1g4djdiWWxQ?=
 =?utf-8?B?aEE4RUNUWnNSMjdFbWJHR3RWK2hJWjhnY1RObUZBbmkrTkwrVVV6d2JNVnJD?=
 =?utf-8?B?a2p1VWZwVUVqLytSczU4K1dJL0xJdVd1T21IazBmRjdlSkl1ZTd4dnVQYUJ6?=
 =?utf-8?B?cS9CSXpZaVdYUlE4U1BGRDVTcmxablBrVlZWOVQrckxXVkpsekZYdk9GVDkw?=
 =?utf-8?B?WlVkNGc2SGRCY25FUGQ1WUZiTms4N2RpTDBIVGJnVFZmYjM5Uk5DcUl6TldI?=
 =?utf-8?B?dzNtRDVHdDA2UTRocVFENXF3cXZ6T3pNVXUrVEJldkVUWHRYczZyVUlybWt3?=
 =?utf-8?B?RmVkbFdhK2U3Y1RBQXZaYUFLOVlkbTlkdXdzU21ZdHJGMm9WaTNHemdKZmJO?=
 =?utf-8?B?WVBGUUMxVXhWOFZ1UkRZV002WEx4em1yaXQ4Ti9JRWFVSkhreWlrUWpyaVRn?=
 =?utf-8?B?MElrTG9VQTVZRVdSeTRjMUxwd05xTmYzZmY3V0VUTmh2WldZTUVuWVZQQ09l?=
 =?utf-8?B?TDQrbkJ3UU9YN2tlbDRJQkpNb29vaEIvNDk1bU9GRHZiaE8zc2xkMmZWK1FP?=
 =?utf-8?B?ZnVoWDh3QjcvRzhDZzFFK3NpN0hoQ2h1RHkvZVFkSnJzdGYwd1dybkhuNS9Z?=
 =?utf-8?B?eHR2blhNcklBcGVhT09KbVppMnk0T0ZMU3ovbDZnVllKeSt6OWdyUFpqaUEv?=
 =?utf-8?B?WjRiazF0Tkc5R0FzaWhFWlRWOWNSN3hQK01jc1cvRHBQUEJZQXc0TFNNYkMy?=
 =?utf-8?B?aUNMK1lnMzlCdWNoZlJqdWNZWVNjNkQ1ZUpzNVFNTGpjbFdZQmdwWjdkeXcy?=
 =?utf-8?B?VWxwNXo3Y1BQSkRRQVo0TTFDVGJGR1hlVmJNc1k2NzdFMXZPT3NXRFcxS3Y5?=
 =?utf-8?B?c1UzUHVIK3ZtSE15aFNsYVk5TkxnK05uSkY3NG0wZ1g1djdNL0htVGRubTdl?=
 =?utf-8?B?eFRKZlRhM3dPWkpkS2FKTnErTUl2MDFhUyt3WjlXSHZnYlRLWTBVZitRaWlE?=
 =?utf-8?B?bjhzamRZdU9md2IrdER4LzJoVUZDaFpRZGd4VWJBeHlFTnA4a29XV1ZDU25t?=
 =?utf-8?B?cnBGMDNJUmZIRlA5NFVLeUZZZnpMWVZHZCtYbU04ZWFuc0ZiOGQ1RGM0aWJn?=
 =?utf-8?B?OXRjR3djdC9ObGRiNzYwOElmWDRENGloOXlOM2xnWWo4VU9pQUZFeFZjOGJG?=
 =?utf-8?B?Mm53bndlSUVIY0s3RTBGZmxPY2pMTXBxdkNPdS9wNEppYmpSNHlSVTFaVWdB?=
 =?utf-8?B?Q1J6ZDdPZHRCMHZnYmFLa1VOWUZOV3JEK3R3TmtFbkowY1VoTVRYcHRBQkJk?=
 =?utf-8?B?OGFQVVJZblFJcXdHczg1VG0zSUZvQUswR1pwOG9YTVlGUVM1dzdha1hWazZJ?=
 =?utf-8?B?VHBQdEVYeDFjcWxPSWp5RitHTzB2MjVyR2VrRVJGTUNzVGE4VURyaFl3Qm5D?=
 =?utf-8?B?c2ZTN3JWYjhhendXNGk3UjBkTWJhR3ZFNHBhRnk4anBqMXBqeWJ6THJHRUdx?=
 =?utf-8?B?aWxxclFDYTV6cml0NlJ1cjM2Zyt5QUsrUGN3MDBObEpSOWFDTlFibDEwS29R?=
 =?utf-8?B?MzFOd2pGS1hockEvWW1URjJwVTA4MkNxLzBHemRySzhONWNUSGYyTnQ5L0ls?=
 =?utf-8?B?a0xPZ1BHOW1DVlBTTllYQWVWZFQ2MmJlNzRkcnF5c24rcTNKUzc1Zk04ZmQ0?=
 =?utf-8?B?K0dySGk5YXpRak9BcmY3RHcrMFhneDRCbHF5dm9YRUhqR0JHOEpYcW9QcTRu?=
 =?utf-8?B?aEFNR2hTVFNXRmFIZzI4MCtEOWg0dGRSVFB1MVBTb0ZnVFh5RFFXaFllYlkz?=
 =?utf-8?B?emIxZE9mVUJVcUtLOTVnTnF1a2RIaVF5RjZIRG55YjJqR050VDNacUFyS0ZL?=
 =?utf-8?B?WkRMRmlnTlFXN3NUY3N3aWpmbjQ4UElnYVVsR0pLaGFlYnc5dnZtZDlOenB2?=
 =?utf-8?B?cXNaWG9xenRqU0VpTlJsMFgrOGZUT3hxVTdYL0V1cG5UcnpQbitRK1lkQ3l4?=
 =?utf-8?B?KzFYOWIxb09GMnhMcndOZWNpMFhGTXRBWDRpVWlFNEdmQjRYQS84MWhzTHUv?=
 =?utf-8?B?L1Nab0F1VWdwdGNiOHN4aUMwTVRrd3lJUy9iR3BuVldFQk93WmFjTnpSSnVW?=
 =?utf-8?Q?77WXK5/Ubx2bR2/28MsxBdkhmU3zqDXvmgoKRe7j7OmHU?=
X-MS-Exchange-AntiSpam-MessageData-1: yaovGMB8wb3IKw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653f477c-b49c-4ef2-d223-08da47a6d934
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 10:25:16.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laDB6THDHKS0D5dwPspukZJfSmMY7JZoRms2i5ZsQsYA2nAz8VzVFvHpUAUM2jc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.06.22 um 00:00 schrieb Michal Kubecek:
> [SNIP]
>> This patch should help:
>> https://patchwork.freedesktop.org/patch/488258/
> After ~48 hours with this patch, still no apparent issues.
>
> Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thanks, this could be optimized for gfx8 a bit if anybody is interested 
in a typing exercise.

E.g. we only need the tlb flush when "start" or "end" are not 8 entries 
aligned on gfx8.

I don't have time to test this, but should be trivial to implement.

Christian.

>
> Michal

