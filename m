Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB16BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 19:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C04310E152;
	Fri, 16 Dec 2022 19:48:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EAA10E152
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 19:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2Vg+joHCCHW38fZszh00If8rqqetaDV8dpixH2bHmStkCVvha3NoPx9xdrRNKyqdh7rbsXPFXQbKugn6zCkxhkq3UkdG7hjeJloOa/3dFTP803iu/2flQpJVHURuxyJuyXKiYeLUv9HP94r68xUNX8MhPq5vzTf25MHZj0hL4A4Ud2VibGvvVzKApLm1eLIOJebgLgrAcWiqlXgzniXQnMz/R/bVaPGSVbY64zdoWzbfUZQ/roNbk1rREYtdBl7DPM3xYXanMSuf14oS/WjWI7z7W8/rb5J8h/HBCRCCU6nPaMWx0vRRg7JLVNObKo8qIiRn3O0eZDcu9RoVnj/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVtBG4oLC8pCacNLOxI6b4cAPmRZ6zvOQh6SZC/ZoKk=;
 b=l0YckxCC9tkiNeMpyzxyYvSUf0iJoA43Ua58Tu1vzL9mDrq8jf1mNIAYUMJnLtUv/oQlz26CjeVLwnoZjZQCSew1QzeIgVT+XQOVLz5Ywavdn8Dlh7sg2ZCrtgh9A/pI8oOX8r7/1Me5SrUUwbO0S1sTHjcqI9EpZyXiua55J5QCi8wg9nqd97xf1VGWebJeeBymmeLFXh3uiRQv7rXs6k0NvKy9t0WzxDQ5yx9w+pDaURaGuSPY3ENNInsTnXm1D0ORnNOHYoMCVT49ENIhb8Z7g6DjD3KrQh93MO3wQ4eaNfOiWZRY5yfmd5G5GT9MKYrxnFzeLmXmMakF6fE4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVtBG4oLC8pCacNLOxI6b4cAPmRZ6zvOQh6SZC/ZoKk=;
 b=3UdWBvO8B7fE7ffm2e2KNBHB96gJJH3Rg20GS84LD9ye7NgzaswSdpbVqw8SmZNRtKGWJGlYaS7FCASDZJLhLzM72FbsD+sS/Law2UsAedF48FD/Z19x4J0O8FJSw3G6nvkScN9qdBaVGzrIofcTVOYaD4larzh3vi2pNdtmL3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 19:48:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca%8]) with mapi id 15.20.5924.014; Fri, 16 Dec 2022
 19:48:02 +0000
Message-ID: <df9211e8-f692-61cc-b06d-7c8d565e7160@amd.com>
Date: Fri, 16 Dec 2022 14:47:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Hung <alex.hung@amd.com>, =?UTF-8?Q?Michel_D=c3=a4nzer?=
 <michel.daenzer@mailbox.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
 <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
 <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
 <e2337d02-594e-9c69-d8a4-b046fc9c221f@amd.com>
 <e8801420-3212-702a-93dd-1b3f323bfd87@mailbox.org>
 <636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com>
 <ffd8a259-d3ec-b2a0-ed59-62727e08998f@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <ffd8a259-d3ec-b2a0-ed59-62727e08998f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::31) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db937c0-8da4-430a-56e9-08dadf9e7105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh+DZcZuKrCj1RbTYEnerhk/goyRfbI+wxsDvJg23pdxUgrc6hx1N2hKoi+bjKHLiXLPJsW7/PIiH9fdIB0GtfIEC92GHV9Me76KxCJ+YWhxoj4bjVm9pWX6lOZ8EX9rqCdZZ//Y/+oEhl4clzh3tS8vWHb1RiIqts4gQW/N9NoS6fqW2+s7dlIDn0qKu6OgJ6f0a4CYY4Igmj27GCTfb6wxM4TU+zr061rw1X5u0Psri2Le5zM+UBGY0/TX81VtWhf/Bl6UWWnHlEF0/SfA2lJvtLeuPB5fQK9xW3Hl0RVlNzetFqEC+kdkcLqSWutSE1S5boLx320ce1o3C0hVcEKOXFUxgeuJPG2dxHzPFebe2Zg53Tla99xJyv64lao3zCPLGS4nNEYa6bc5u36j8ebI7T6ZYV2d2n0tGQBnaO5hVXZwJKcjRnYMT3qDAYNNg3ia2QlETItyo9b3Rox+14R/u3QQSNt8lQFA3pTlGwXpooQiSp33LIwHddYA2pRWlyISbv4izEmXPTlWImf89aoOKnMs4CT3Qhva4q6iQubc5eli7V/q6+7Cqo8FrSuY/7Nx5jkUXs1IEO341EJ0T5fawHq8gHPhQ4hftkZ2ab6oLkXQECtMqG+9a/ebjY7IYTL89NLj9Mqv4zzfnTtsILEkxifjpNloh6N7ODg00tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(31696002)(478600001)(86362001)(66574015)(8936002)(6666004)(41300700001)(6486002)(966005)(5660300002)(31686004)(4001150100001)(38100700002)(6506007)(53546011)(66556008)(6512007)(66476007)(4326008)(2616005)(36756003)(8676002)(26005)(66946007)(186003)(110136005)(83380400001)(2906002)(316002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0k0SVh5aGQ2ZVBBcXNDbUtUdmpZaTMzL004bTB1UnNMNVFaOEZtODNMNjAz?=
 =?utf-8?B?a3d6M25RVGNycjFaQmNmU01JbVdteVJLN09ucUg2am9DWUJhYXRZaG5wYWhq?=
 =?utf-8?B?Q2tiL1BydGtERUJKNGU3bjQvSTBBOXl5TWdhaDNMY1RtbHc5RmlIaTJQaXI4?=
 =?utf-8?B?U1BiMnRJMlpveDF0L09jN25zSVJ5WFBiZWN0K01aNGMyQVB6cHpxNDh2VGxG?=
 =?utf-8?B?cVhvUllXK3lZOXMrSkR4ZVJpMjM5Z1BpejRrejVEbHM4Z2xOY20xNHVBeE5I?=
 =?utf-8?B?ZFdTREFjQllFY2pMTHhrUlRtbncyRDNWZG5tdWRyZlhqZHdtOXZTZThzOXE0?=
 =?utf-8?B?SFlYV0pQU2ZDc1ExRUFnSmtoZ1RqaFB5a2VPQlQ3NGxpdnFVOHk3TElZWkg1?=
 =?utf-8?B?WVE2NVZ3Y1dRRkhKVFpqWXhQbzJyZXgxVVZyMVdCZFY5a0hHK0t4czdWb2lK?=
 =?utf-8?B?YjI3bjFBSklibXhydzM2bytWT1pCSml3UTF1WUJEbk1WTnV2TlBTOTBjM2h0?=
 =?utf-8?B?R3R5eHVOMjFqNnRYNkpZOEUra2FTcEFjd2RhcXo5MHk2UmVlSzczdGQzWTUv?=
 =?utf-8?B?bjVub1d4bWNPdjBwdUtOS0o2b3BXanhIaVBYSXJWVjBWSHF2SEFPR1hQNG5U?=
 =?utf-8?B?Ykc3bmVIUUxEUUFMMDNnWFRaOFB5dDFVemFQdWorM3dWOHBmcC9MbkpIeTBl?=
 =?utf-8?B?NU9sRU1sM1Vtem1ZSmJWMTBpY0NrNmxXNllSSlc2OW4vQkF3a2w5WjI2a0ll?=
 =?utf-8?B?MldpS2NQVmNDTU5TTE5vZXFXeG5oRENnd0lIVUNBejNGcy9Yc2dxUW40cjhT?=
 =?utf-8?B?Q0ZGN245a2czTEdod2dpT3h1a0Vybkh0SnVkYzlzc2REeGE3cnp5c0kzM2JV?=
 =?utf-8?B?YXF2Y0RzbGZTaXQ5OUl2UW5tM1RQcTF0SDVrN3Z6d2ovQlZHRmhDOUFJaEJZ?=
 =?utf-8?B?a3RGSGo2R2RTTFdGMnc3TTR1NGlNRjViVENYOW4xb2JEbUZLY081NEwzeHN0?=
 =?utf-8?B?cWJ1SWZCbFc1djZXbTB1VVJjTVM1RGpjMC9BMDdRSTVQcFR0dWVENC8zdHc4?=
 =?utf-8?B?U2FHenduK0phbDg3eEFrSEl1Ry9YRDZ0ck9SNlY2N2JCQmU2QThjbElKanJP?=
 =?utf-8?B?WWZQSTlOaDc4UzRwOUJQRHFyQVJHY21vN1EvUW95Q0wrYWUvTmlrT1FwQVA3?=
 =?utf-8?B?c3c4WUlueDIvSHp5OHBtTjhyUFo3Nm0xOFMyOVBpdW9TdjdrRDhXa2hhZnIv?=
 =?utf-8?B?aHRzOU5mVGtLQ2tiT3VmTHpTaXYrbU4rUS9CekNpWXQ5U1JJODFNWWpKcmJF?=
 =?utf-8?B?L1pFWmFzVW15SU1qSXJjbnFkbnlYRlRMOHdINm12STk0MllIVFhBalRaTXNr?=
 =?utf-8?B?U3ZsV0JUQy84dUtZTXZoT0h3WHh5QkI2RWpIQXlkRHdGZkF3czNsaS9XS3pm?=
 =?utf-8?B?THZBUVlUcXYzeWRFTTVPSjVvclZIN0JEQjV1UGhlUWhKYjNMN0NTU0pnL3Mx?=
 =?utf-8?B?UmhZYjZBRHAvZTJ2MURxRnQ5UkM3azlBVEVXUXpSaWFuRVBzOUo0ZWlyQ0VP?=
 =?utf-8?B?QTdLMmtLZFVYdjB6dkR1L25MRU8xVTdHTGdHVjNCeml5UGtwc3ZGMVVENkR1?=
 =?utf-8?B?VFhJMzEzUXRaMmxyQTVub2Y4alhGUTJTeDVWNERXcmhYbFpzQW81cGRhVm1v?=
 =?utf-8?B?N0hDcGRkSGc5aTRodFhPbWtXd1A5cXExSldVajROcWFpZ0lYNms3WGtyOERj?=
 =?utf-8?B?WloyN3hISmxiSWt3T0Vsclg1K3NZTkNkdlhDeE5vNDJZNHBSTFIydXdBNFUr?=
 =?utf-8?B?V1JWZ1g5a0VPVW11b29QSWlPWjYzTDRqaU9kVVUxZFZ3Sk1Vc3FmWHRlNWox?=
 =?utf-8?B?djdpcHA3QWFUM1ZSOWxuRlJsQSs2dGI5U0YrR1hBT2hSTGtyQ3IxVTJvTW4x?=
 =?utf-8?B?RG5RRGM5VWJ2OWh3MElsUTNkeFVleVZKZDdURzZVamlJaFJEOFBxZmNPMU55?=
 =?utf-8?B?MUkyMmlyUkZWaGNCbnpERmhieG50SGp0VHpBdC96MmlxcGNkcjIwR0Y4Rzgw?=
 =?utf-8?B?RGhxdk5JdFJyZ2FYUWVMQmdyYUkrdnR0UHVvRzVsS21TWHowZFFJUHBGcTlF?=
 =?utf-8?Q?vMUH9+SsWy2stT+L5iTVM6Xy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db937c0-8da4-430a-56e9-08dadf9e7105
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 19:48:02.3004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr0ciFLMQP+3vdIo70MD3aoJi6blLwjvlu0Qjz1idtiQkxAzN2STRT/cqV+FAlpYREZVuxpjih3/Umm3+nihjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/15/22 16:02, Alex Hung wrote:
> 
> 
> On 2022-12-15 08:17, Harry Wentland wrote:
>>
>>
>> On 12/15/22 05:29, Michel Dänzer wrote:
>>> On 12/15/22 09:09, Christian König wrote:
>>>> Am 15.12.22 um 00:33 schrieb Alex Hung:
>>>>> On 2022-12-14 16:06, Alex Deucher wrote:
>>>>>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>>>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>>>>>>

<snip>

>>
>> It can come through handle_hpd_rx_irq but we're using a workqueue
>> to queue interrupt handling so this shouldn't come from an atomic
>> context. I currently don't see where else it might be used in an
>> atomic context. Alex Hung, can you do a dump_stack() in this function
>> to see where the problematic call is coming from?
> 
> 
> IGT's kms_bw executes as below (when passing)
> 
> IGT-Version: 1.26-gf4067678 (x86_64) (Linux: 5.19.0-99-custom x86_64)
> Starting subtest: linear-tiling-1-displays-1920x1080p
> Subtest linear-tiling-1-displays-1920x1080p: SUCCESS (0.225s)
> Starting subtest: linear-tiling-1-displays-2560x1440p
> Subtest linear-tiling-1-displays-2560x1440p: SUCCESS (0.111s)
> Starting subtest: linear-tiling-1-displays-3840x2160p
> Subtest linear-tiling-1-displays-3840x2160p: SUCCESS (0.118s)
> Starting subtest: linear-tiling-2-displays-1920x1080p
> Subtest linear-tiling-2-displays-1920x1080p: SUCCESS (0.409s)
> Starting subtest: linear-tiling-2-displays-2560x1440p
> Subtest linear-tiling-2-displays-2560x1440p: SUCCESS (0.417s)
> Starting subtest: linear-tiling-2-displays-3840x2160p
> Subtest linear-tiling-2-displays-3840x2160p: SUCCESS (0.444s)
> Starting subtest: linear-tiling-3-displays-1920x1080p
> Subtest linear-tiling-3-displays-1920x1080p: SUCCESS (0.547s)
> Starting subtest: linear-tiling-3-displays-2560x1440p
> Subtest linear-tiling-3-displays-2560x1440p: SUCCESS (0.555s)
> Starting subtest: linear-tiling-3-displays-3840x2160p
> Subtest linear-tiling-3-displays-3840x2160p: SUCCESS (0.586s)
> Starting subtest: linear-tiling-4-displays-1920x1080p
> Subtest linear-tiling-4-displays-1920x1080p: SUCCESS (0.734s)
> Starting subtest: linear-tiling-4-displays-2560x1440p
> Subtest linear-tiling-4-displays-2560x1440p: SUCCESS (0.742s)
> Starting subtest: linear-tiling-4-displays-3840x2160p
> Subtest linear-tiling-4-displays-3840x2160p: SUCCESS (0.778s)
> Starting subtest: linear-tiling-5-displays-1920x1080p
> Subtest linear-tiling-5-displays-1920x1080p: SUCCESS (0.734s)
> Starting subtest: linear-tiling-5-displays-2560x1440p
> Subtest linear-tiling-5-displays-2560x1440p: SUCCESS (0.743s)
> Starting subtest: linear-tiling-5-displays-3840x2160p
> Subtest linear-tiling-5-displays-3840x2160p: SUCCESS (0.781s)
> Starting subtest: linear-tiling-6-displays-1920x1080p
> Test requirement not met in function run_test_linear_tiling, file ../tests/kms_bw.c:156:
> Test requirement: !(pipe > num_pipes)
> ASIC does not have 5 pipes

Does this IGT patch fix the !(pipe > num_pipes) issue?

https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/commit/3bb9ee157642ec2433f01b51e09866da2b0f3dd8

> Subtest linear-tiling-6-displays-1920x1080p: SKIP (0.000s)
> Starting subtest: linear-tiling-6-displays-2560x1440p
> Test requirement not met in function run_test_linear_tiling, file ../tests/kms_bw.c:156:
> Test requirement: !(pipe > num_pipes)
> ASIC does not have 5 pipes
> Subtest linear-tiling-6-displays-2560x1440p: SKIP (0.000s)
> Starting subtest: linear-tiling-6-displays-3840x2160p
> Test requirement not met in function run_test_linear_tiling, file ../tests/kms_bw.c:156:
> Test requirement: !(pipe > num_pipes)
> ASIC does not have 5 pipes
> Subtest linear-tiling-6-displays-3840x2160p: SKIP (0.000s)
> 
> The crash usually occurs when executing "linear-tiling-3-displays-1920x1080p" most of time, but the crash can also occurs at "linear-tiling-3-displays-2560x1440p"
> 
> ============
> This is dump_stack right before the failing msleep.
> 
> [IGT] kms_bw: starting subtest linear-tiling-3-displays-1920x1080p
> CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted 5.19.0-99-custom #126
> Workqueue: events drm_mode_rmfb_work_fn [drm]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x49/0x63
>  dump_stack+0x10/0x16
>  dce110_blank_stream.cold+0x5/0x14 [amdgpu]
>  core_link_disable_stream+0xe0/0x6b0 [amdgpu]
>  ? optc1_set_vtotal_min_max+0x6b/0x80 [amdgpu]
>  dcn31_reset_hw_ctx_wrap+0x229/0x410 [amdgpu]
>  dce110_apply_ctx_to_hw+0x6e/0x6c0 [amdgpu]
>  ? dcn20_plane_atomic_disable+0xb2/0x160 [amdgpu]
>  ? dcn20_disable_plane+0x2c/0x60 [amdgpu]
>  ? dcn20_post_unlock_program_front_end+0x77/0x2c0 [amdgpu]
>  dc_commit_state_no_check+0x39a/0xcd0 [amdgpu]
>  ? dc_validate_global_state+0x2ba/0x330 [amdgpu]
>  dc_commit_state+0x10f/0x150 [amdgpu]
>  amdgpu_dm_atomic_commit_tail+0x631/0x2d30 [amdgpu]

This doesn't look like an atomic (i.e., high IRQ) context to me.
So it's more likely there is some race going on, like Alex
Deucher suggested.

Harry

>  ? dcn30_internal_validate_bw+0x349/0xa00 [amdgpu]
>  ? slab_post_alloc_hook+0x53/0x270
>  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
>  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
>  ? dc_validate_global_state+0x27a/0x330 [amdgpu]
>  ? slab_post_alloc_hook+0x53/0x270
>  ? __kmalloc+0x18c/0x300
>  ? drm_dp_mst_atomic_setup_commit+0x8a/0x1a0 [drm_display_helper]
>  ? preempt_count_add+0x7c/0xc0
>  ? _raw_spin_unlock_irq+0x1f/0x40
>  ? wait_for_completion_timeout+0x114/0x140
>  ? preempt_count_add+0x7c/0xc0
>  ? _raw_spin_unlock_irq+0x1f/0x40
>  commit_tail+0x99/0x140 [drm_kms_helper]
>  drm_atomic_helper_commit+0x12b/0x150 [drm_kms_helper]
>  drm_atomic_commit+0x79/0x100 [drm]
>  ? drm_plane_get_damage_clips.cold+0x1d/0x1d [drm]
>  drm_framebuffer_remove+0x499/0x510 [drm]
>  drm_mode_rmfb_work_fn+0x4b/0x90 [drm]
>  process_one_work+0x21d/0x3f0
>  worker_thread+0x1fa/0x3c0
>  ? process_one_work+0x3f0/0x3f0
>  kthread+0xff/0x130
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> 
> ============
> If msleep is replaced by mdelay, the dump_stack is almost the same:
> 
> $ diff mdelay.log msleep.log
> <  dce110_blank_stream.cold+0x5/0x1f [amdgpu]
> ---
>>  dce110_blank_stream.cold+0x5/0x14 [amdgpu]
> 
> 
> ============
> If the IGT fix is applied (i.e. no crashes when removing buffers[i] reversely by "igt_remove_fb", the dump_stack outputs are the same:
> 
> $ diff msleep_igt.log msleep.log
> 2c2
> < CPU: 6 PID: 78 Comm: kworker/6:1 Not tainted 5.19.0-99-custom #126
> ---
>> CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted 5.19.0-99-custom #126
> 
> ============
> Note the msleep doesn't always trigger crashes. One of the passing dump_stack is as below:
> 
> [IGT] kms_bw: starting subtest linear-tiling-2-displays-1920x1080p
> CPU: 6 PID: 78 Comm: kworker/6:1 Not tainted 5.19.0-99-custom #126
> Workqueue: events drm_mode_rmfb_work_fn [drm]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x49/0x63
>  dump_stack+0x10/0x16
>  dce110_blank_stream.cold+0x5/0x14 [amdgpu]
>  core_link_disable_stream+0xe0/0x6b0 [amdgpu]
>  ? optc1_set_vtotal_min_max+0x6b/0x80 [amdgpu]
>  dcn31_reset_hw_ctx_wrap+0x229/0x410 [amdgpu]
>  dce110_apply_ctx_to_hw+0x6e/0x6c0 [amdgpu]
>  ? dcn20_plane_atomic_disable+0xb2/0x160 [amdgpu]
>  ? dcn20_disable_plane+0x2c/0x60 [amdgpu]
>  ? dcn20_post_unlock_program_front_end+0x77/0x2c0 [amdgpu]
>  dc_commit_state_no_check+0x39a/0xcd0 [amdgpu]
>  ? dc_validate_global_state+0x2ba/0x330 [amdgpu]
>  dc_commit_state+0x10f/0x150 [amdgpu]
>  amdgpu_dm_atomic_commit_tail+0x631/0x2d30 [amdgpu]
>  ? debug_smp_processor_id+0x17/0x20
>  ? dc_fpu_end+0x4e/0xd0 [amdgpu]
>  ? dcn316_populate_dml_pipes_from_context+0x69/0x2a0 [amdgpu]
>  ? dcn31_calculate_wm_and_dlg_fp+0x50/0x530 [amdgpu]
>  ? kernel_fpu_end+0x26/0x50
>  ? dc_fpu_end+0x4e/0xd0 [amdgpu]
>  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
>  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
>  ? dc_validate_global_state+0x27a/0x330 [amdgpu]
>  ? slab_post_alloc_hook+0x53/0x270
>  ? __kmalloc+0x18c/0x300
>  ? drm_dp_mst_atomic_setup_commit+0x8a/0x1a0 [drm_display_helper]
>  ? preempt_count_add+0x7c/0xc0
>  ? _raw_spin_unlock_irq+0x1f/0x40
>  ? wait_for_completion_timeout+0x114/0x140
>  ? preempt_count_add+0x7c/0xc0
>  ? _raw_spin_unlock_irq+0x1f/0x40
>  commit_tail+0x99/0x140 [drm_kms_helper]
>  drm_atomic_helper_commit+0x12b/0x150 [drm_kms_helper]
>  drm_atomic_commit+0x79/0x100 [drm]
>  ? drm_plane_get_damage_clips.cold+0x1d/0x1d [drm]
>  drm_framebuffer_remove+0x499/0x510 [drm]
>  drm_mode_rmfb_work_fn+0x4b/0x90 [drm]
>  process_one_work+0x21d/0x3f0
>  worker_thread+0x1fa/0x3c0
>  ? process_one_work+0x3f0/0x3f0
>  kthread+0xff/0x130
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> 
> 
>>
>> Fixing IGT will only mask the issue. Userspace should never be able
>> to put the system in a state where it stops responding entirely. This
>> will need some sort of fix in the kernel.
>>
>> Harry
>>
>>

