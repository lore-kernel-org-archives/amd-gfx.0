Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10434C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 21:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33B66128A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 21:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33B66128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDA96E8C5;
	Tue,  6 Apr 2021 21:22:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141A26E8C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 21:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmT9NVQjujh1KXUJbVDeV4dlyFcT2naR3piPxEIfTqvhq2jw80FkmQX0SoC219KPXAAooWal77AryHpS7FOm8tuJD6CUA/VoGKvZTEt/JjI31Q8AEI67cmBQCil/l2y15lpKdD/zTo0rUXm8/mDX1sjCho3fggSwFZfP96Pm5Ln4ylmD3FZ35PnDidYxmNTh5zV7aZXeOydutKbQXptJyiktwvc8agUQA4DVduwudjk9VzJ0KXX2kP3IMuhKQ/Pn2iKvB9w+olF0RHIQlOVSzRrIMaINpsb8lWOdCdxq//wLmlI3wo47rNCfhGTowGnUPrXLfzdzOzXrZ0OZ+2/FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jywlj6n/ph+ninxw729cbwtTC964WE4/PCWbEav/4YE=;
 b=K9yQDhupz8rcfx2q7Bkb6EOEwTxEv1AwSNcLs2qpVtALgA6ZLV+aEJDvzgldK2pRExvO6vOf5smZk0OJbYoaC5NArzsJb5JxpzDRE8UdxDT0o45lNCTNG4oldcb6Ua712pUPIxYwQ2S8D03o9BwjGQ19+qgYEk78uL/6XDF3KWeA/RA2LTvCz17q7rH+WkGped9/GuZtojLC9mDy4GKsMHheztt7Wl+OeeShzVJL+Ciy1pfoAecaHucgicvVp5+H+n4EiliTuVf6PF/QZC+Jkc3vp7o4PGO+fBMI+Ftsm3WX46MWUW18opfQny8L6wxDmJ5PUZ1iflq9eWHiiFzPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jywlj6n/ph+ninxw729cbwtTC964WE4/PCWbEav/4YE=;
 b=Vyvsh62lJZmut61b5C3w74Ga/iJ9Xz0SFVft/PpGWSEJF5gFqDKjP9HEtQyxPyImvOS6OKpcdQ9AqEfOjvaxAIffL3MxxvgeMniPg/w+l6QBpCIVAB5L/iO6iTTnBGjC2JUHvyLwB/tMur2gNpwHYAK+G7R6G6oewLkieEMEU3Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 21:22:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 21:22:11 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
Date: Tue, 6 Apr 2021 17:22:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:1369:1e4d:c302:bc30]
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:1369:1e4d:c302:bc30]
 (2607:fea8:3edf:49b0:1369:1e4d:c302:bc30) by
 YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Tue, 6 Apr 2021 21:22:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4625dacf-d11f-4b76-d47b-08d8f9420a42
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27650B52547C41791FC88625EA769@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXPkuvWglVeX7bpMLwk+vQKY00uuTEvR1kL1Qbv1ITUSCtqWQCtNmOQObfDoku/4/FXC/M5sUPCTDPMbpk4LYyTVM8OlzyIoVmngKKoPsLWNe/p3bW3ksmRMWLSkInXItNNSL3aWJkWUqR17squ1Dd3jlFlh7fNNglJYzPC7z/XF++VSpiOhEuSxiJ2TuKx5GNxN9xlChZtx1YdxJOfsy/Wz3R4U3z6yb5xelxupzaWJldt4aexZ4Zm0Fv0+XndoG9UNMhEX3XJLyQ09drIDfhx7XVztgorp6z67Ld1bf8hooBVRPYmz+sxF1CY0l+alpoZgQkRne6CUkVDxn7UTuB5gKbV5NDMYfObHnGNrBF/+deSl6ijNMUDdLV4K+qWiaq9wNt3G/qyVK6UJCOUs5OgbHharv/i0rXAweO6TQZ/TuiEzsj4WbrQraheqwPY1hGWcJH4y1lvrmhQpqwdgqyt3Z0RIeEv3w0Ye9R7o8GuN4vMHMQfyXOrH3o0USxglOoHYNge+NfLoLypnrns8POrUofIdi4Ry2Bc/E8rWpHu+ROl51o37x8zfFahGhZZOsKsFoYWZglprRElEmDvnAAmeEQ+nY5053+xjRo1ixZCGmblJm87Bc0Zbm0ieffbw9dW/MA1v1EZzFG5A9loakR2NHmMOZQrrzhZ7vzUtXwXZA5MWtEscM1+ngEiCEODZBXWF7hA4IvyX2Ox6Je1wvf40nzeoP0ZcQofElfsMwxqk1ekH0IpTna3vb8h8MMPdsZ7md6Hjn4NxBSD+/2rlBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(478600001)(16526019)(186003)(21615005)(8936002)(110136005)(31686004)(166002)(83380400001)(66574015)(2906002)(38100700001)(921005)(966005)(6486002)(36756003)(52116002)(30864003)(44832011)(66946007)(316002)(8676002)(6636002)(66476007)(66556008)(5660300002)(53546011)(31696002)(2616005)(33964004)(86362001)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c3F4NmFMU2M3cGFhRnVYQ1htaDFqbWc3Tng4TjRoL0JTRitNdlZaNE5sNXdD?=
 =?utf-8?B?NlQ3TWpOQkF5bVpvaUI4VG15U0J2TUdLQlJtOHB1WnBUa2haTUJXUDAvTjlx?=
 =?utf-8?B?M0pVVnJlQWw0TmJuQ1FsdXExL04vaEdQV3hsYkNIc0lNb1FjamZxUlZ2NHpN?=
 =?utf-8?B?SGxDTE51MDNjMUtrYi9ZWFErbGpxQ2J2Qnk3amc2RXBRd0pzbmQ1WFg4Mm16?=
 =?utf-8?B?K3pmSU1qaWVCaCtnVWNtY295QjNyUTgxdUNZSXEzMnRJbWxlcDNPcDhhMWtC?=
 =?utf-8?B?OVhhd1JqSUJVd1dSQk82T3MxS0lkR2dQclhlaS82d2VNUVp6cGp1d3FUanlr?=
 =?utf-8?B?dEFWOTJqUGZRTFhrWTRTWTByNnl1SHIxeDZMa3JXMHRiSlZuWTJDM0JkbEFy?=
 =?utf-8?B?ZGllejJTeG5NeElXbHZQNXdiT09GVjBITUxjeVNidTliRTdiWEZkamlWTjl5?=
 =?utf-8?B?aVBtWnp3UWdlTCs4VXlYREpNOHVvRTZpVTdJVm9zMWtpUmYzL0l3NTQwb01z?=
 =?utf-8?B?Q2dnbVlBeHVvWEVGNHl2eW93WFRLMlFDbXozQ043NXNtNmJ2Q0Nva2dia25O?=
 =?utf-8?B?ak5WQUM1OWJ1YnByU1k5WU1yMjdHei9vNS8vS0M3Mzl2aSs4Wm1lTndhdGRx?=
 =?utf-8?B?NzAxOUxvSytqdDBCWUViVnN6UnZNYmJNTUlWa0hrbWk3STRKM0w0RCszK1V1?=
 =?utf-8?B?M2FBMEJIUFA4elM5SzArb2F5U3JjdmR0WlF0UXRZU2hLOGp0MWtxRTB4Zlg5?=
 =?utf-8?B?WExnQStIaVRSSkNVSVliMTZFYUFMc1oxckJrZHBhZkZkMERwa3Q2OHc4aUtD?=
 =?utf-8?B?Umx5ZnVnT1lDcHVVVHRXdVhWRVFYTk9qU3hFK3g1OUxQMVJSNXd6VC8xNHJp?=
 =?utf-8?B?NXArYzVNWlkwSGNtMlJIeEY2WHN1TUNETnBQNmdvU1R0eHNFYmtaZVVTbmY0?=
 =?utf-8?B?dmdFbmswaFl6VzJBWnlxZXBRYzBaUmZWT3BZelVjbzBPS09xNUt1MzhoTzNk?=
 =?utf-8?B?b1AzYlZ1ekw5ZlYzM3gvbWZFYUl5VCtQMWJlUHFmeC92YzV1N01HUnBlbGZY?=
 =?utf-8?B?aVJEb2h6WVBDbWdaYlFhYll4VW4xYjZOMkFJZlBDYm9RRGkrRDdpaUtvb2py?=
 =?utf-8?B?Q0dOakdjRlJBRW9YSm53SzFFVmlPV2M5VWI0aWxXWWlYQkp6U2VGcHhBVk5E?=
 =?utf-8?B?NUtCMkcyRkpuSlBwZzhwQllZckRwMytubjdHMkFpRnplR2xGQ3phMW1uQ29C?=
 =?utf-8?B?K0hPclVacVNWclFzT1NhdG55S1l5Q1FveEhLUytJN0c2Z0RRTVdEU0JvOERE?=
 =?utf-8?B?bG5uUlRwUTBEdmx0dFBTNjVuWjVNMkFycFRWeGU0Z2hKaXRBeVhwZkNDOExl?=
 =?utf-8?B?dk9EOXVLbXkwdzkzM0o2M2UzN0NWb3poSDRhOHRQZW9Xc3Z6c3dLOUdpazFI?=
 =?utf-8?B?MzUxR2ZER1pSL2FWaXREbW1tZGFpbzhWaHh0UGI0VVV5REUwcE0rTkw5bmFL?=
 =?utf-8?B?U0tkOUZWVVNEdkZMdzlVZnp1bFUwUzB5cU1xVlhmbHpqUFp3WkJrQzNCdU9K?=
 =?utf-8?B?c1hTUkE2eXVKanh6YS9VQUdKNWtTYnVTZ2RNOFBza2kxdVpiaGNKYWl3ejEw?=
 =?utf-8?B?VlVIS3BiTDZMUUhEdTdwS2pIdnlxMFVDeXBUNGhMemVKRzBraklHRDFxb0h6?=
 =?utf-8?B?VlN5N0VjMStrOW9qM0syT2JsdW9hY1JhQ09od2RVcG13bWgxSVQ2cVdYbE9T?=
 =?utf-8?B?YW5SUUdZUnNJOEVReHRXb1dsY05Hc3c2ZitMbTRzTEZ3N1Rpci9JWGdKdk0w?=
 =?utf-8?B?MEh6THMydERBbzVKN2VNd1MxMUhjOHBhdE5LRHZTRTFqWjNOZnB4NnB0L20v?=
 =?utf-8?Q?YT4G/21bJT9vJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4625dacf-d11f-4b76-d47b-08d8f9420a42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 21:22:11.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAhPzA9av+V5jJROTdnYcmRUHLMpw1WJghkiV6GKSaBDS75ZHeJQkhDR6PA6koPp9ms2I76v3CXUcExCipb/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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
Content-Type: multipart/mixed; boundary="===============0270902172=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0270902172==
Content-Type: multipart/alternative;
 boundary="------------1AF1FBCB2CF8CD2F6B5B0AFD"
Content-Language: en-US

--------------1AF1FBCB2CF8CD2F6B5B0AFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Christian, Denis, see bellow -

On 2021-04-06 6:34 a.m., Christian König wrote:
> Hi Andrey,
>
> well good question. My job is to watch over the implementation and 
> design and while I always help I can adjust anybodies schedule.
>
> Is the patch to print a warning when the hardware is accessed without 
> holding the locks merged yet? If not then that would probably be a 
> good starting point.


It's merged into amd-staging-drm-next and since I work on drm-misc-next 
I will cherry-pick it into there.


>
> Then we would need to unify this with the SRCU to make sure that we 
> have both the reset lock as well as block the hotplug code from 
> reusing the MMIO space.

In my understanding there is a significant difference between handling 
of GPU reset and unplug - while GPU reset use case requires any HW 
accessing code to block and wait for the reset to finish and then 
proceed, hot-unplug
is permanent and hence no need to wait and proceed but rather abort at 
once. This why I think that in any place we already check for device 
reset we should also add a check for hot-unplug but the handling would 
be different
in that for hot-unplug we would abort instead of keep waiting.

Similar to handling device reset for unplug we obviously also need to 
stop and block any MMIO accesses once device is unplugged and, as Daniel 
Vetter mentioned - we have to do it before finishing pci_remove (early 
device fini)
and not later (when last device reference is dropped from user space) in 
order to prevent reuse of MMIO space we still access by other hot 
plugging devices. As in device reset case we need to cancel all delay 
works, stop drm schedule, complete all unfinished fences(both HW and 
scheduler fences). While you stated strong objection to force signalling 
scheduler fences from GPU reset, quote:

"you can't signal the dma_fence waiting. Waiting for a dma_fence also 
means you wait for the GPU reset to finish. When we would signal the 
dma_fence during the GPU reset then we would run into memory corruption 
because the hardware jobs running after the GPU reset would access 
memory which is already freed."
To my understating this is a key difference with hot-unplug, the device 
is gone, all those concerns are irrelevant and hence we can actually 
force signal scheduler fences (setting and error to them before) to 
force completion of any
waiting clients such as possibly IOCTLs or async page flips e.t.c.

Beyond blocking all delayed works and scheduler threads we also need to 
guarantee no  IOCTL can access MMIO post device unplug OR in flight 
IOCTLs are done before we finish pci_remove (amdgpu_pci_remove for us).
For this I suggest we do something like what we worked on with Takashi 
Iwai the ALSA maintainer recently when he helped implementing PCI BARs 
move support for snd_hda_intel. Take a look at
https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=cbaa324799718e2b828a8c7b5b001dd896748497 
and
https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&id=e36365d9ab5bbc30bdc221ab4b3437de34492440
We also had same issue there, how to prevent MMIO accesses while the 
BARs are migrating. What was done there is a refcount was added to count 
all IOCTLs in flight, for any in flight  IOCTL the BAR migration handler 
would
block for the refcount to drop to 0 before it would proceed, for any 
later IOCTL it stops and wait if device is in migration state. We even 
don't need the wait part, nothing to wait for, we just return with 
-ENODEV for this case.

The above approach should allow us to wait for all the IOCTLs in flight, 
together with stopping scheduler threads and cancelling and flushing all 
in flight work items and timers i think It should give as full solution 
for the hot-unplug case
of preventing any MMIO accesses post device pci_remove.

Let me know what you think guys.

Andrey


>
> And then testing, testing, testing to see if we have missed something.
>
> Christian.
>
> Am 05.04.21 um 19:58 schrieb Andrey Grodzovsky:
>>
>> Denis, Christian, are there any updates in the plan on how to move on 
>> with this ? As you know I need very similar code for my up-streaming 
>> of device hot-unplug. My latest solution 
>> (https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
>> was not acceptable because of low level guards on the register 
>> accessors level which was hurting performance. Basically I need a way 
>> to prevent any MMIO write accesses from kernel driver after device is 
>> removed (UMD accesses are taken care of by page faulting dummy page). 
>> We are using now hot-unplug code for Freemont program and so 
>> up-streaming became more of a priority then before. This MMIO access 
>> issue is currently my main blocker from up-streaming. Is there any 
>> way I can assist in pushing this on ?
>>
>> Andrey
>>
>> On 2021-03-18 5:51 a.m., Christian König wrote:
>>> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>>>
>>>> >>> The GPU reset doesn't complete the fences we wait for. It only 
>>>> completes the hardware fences as part of the reset.
>>>>
>>>> >>> So waiting for a fence while holding the reset lock is illegal 
>>>> and needs to be avoided.
>>>>
>>>> I understood your concern. It is more complex for DRM GFX, 
>>>> therefore I abandon adding lock protection for DRM ioctls now. 
>>>> Maybe we can try to add all kernel  dma_fence waiting in a list, 
>>>> and signal all in recovery threads. Do you have same concern for 
>>>> compute cases?
>>>>
>>>
>>> Yes, compute (KFD) is even harder to handle.
>>>
>>> See you can't signal the dma_fence waiting. Waiting for a dma_fence 
>>> also means you wait for the GPU reset to finish.
>>>
>>> When we would signal the dma_fence during the GPU reset then we 
>>> would run into memory corruption because the hardware jobs running 
>>> after the GPU reset would access memory which is already freed.
>>>
>>>> >>> Lockdep also complains about this when it is used correctly. 
>>>> The only reason it doesn't complain here is because you use an 
>>>> atomic+wait_event instead of a locking primitive.
>>>>
>>>> Agree. This approach will escape the monitor of lockdep.  Its goal 
>>>> is to block other threads when GPU recovery thread start. But I 
>>>> couldn’t find a better method to solve this problem. Do you have 
>>>> some suggestion?
>>>>
>>>
>>> Well, completely abandon those change here.
>>>
>>> What we need to do is to identify where hardware access happens and 
>>> then insert taking the read side of the GPU reset lock so that we 
>>> don't wait for a dma_fence or allocate memory, but still protect the 
>>> hardware from concurrent access and reset.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Best Regards
>>>>
>>>> Dennis Li
>>>>
>>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>>> *Sent:* Thursday, March 18, 2021 4:59 PM
>>>> *To:* Li, Dennis <Dennis.Li@amd.com>; 
>>>> amd-gfx@lists.freedesktop.org; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>>>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> Exactly that's what you don't seem to understand.
>>>>
>>>> The GPU reset doesn't complete the fences we wait for. It only 
>>>> completes the hardware fences as part of the reset.
>>>>
>>>> So waiting for a fence while holding the reset lock is illegal and 
>>>> needs to be avoided.
>>>>
>>>> Lockdep also complains about this when it is used correctly. The 
>>>> only reason it doesn't complain here is because you use an 
>>>> atomic+wait_event instead of a locking primitive.
>>>>
>>>> Regards,
>>>>
>>>> Christian.
>>>>
>>>> ------------------------------------------------------------------------
>>>>
>>>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>>>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>>>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>>> <amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> >>> Those two steps need to be exchanged or otherwise it is 
>>>> possible that new delayed work items etc are started before the 
>>>> lock is taken.
>>>> What about adding check for adev->in_gpu_reset in work item? If 
>>>> exchange the two steps, it maybe introduce the deadlock.  For 
>>>> example, the user thread hold the read lock and waiting for the 
>>>> fence, if recovery thread try to hold write lock and then complete 
>>>> fences, in this case, recovery thread will always be blocked.
>>>>
>>>>
>>>> Best Regards
>>>> Dennis Li
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com 
>>>> <mailto:Christian.Koenig@amd.com>>
>>>> Sent: Thursday, March 18, 2021 3:54 PM
>>>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>>>> amd-gfx@lists.freedesktop.org 
>>>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>>> its stability
>>>>
>>>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>>>> > We have defined two variables in_gpu_reset and reset_sem in adev 
>>>> object. The atomic type variable in_gpu_reset is used to avoid 
>>>> recovery thread reenter and make lower functions return more 
>>>> earlier when recovery start, but couldn't block recovery thread 
>>>> when it access hardware. The r/w semaphore reset_sem is used to 
>>>> solve these synchronization issues between recovery thread and 
>>>> other threads.
>>>> >
>>>> > The original solution locked registers' access in lower 
>>>> functions, which will introduce following issues:
>>>> >
>>>> > 1) many lower functions are used in both recovery thread and 
>>>> others. Firstly we must harvest these functions, it is easy to miss 
>>>> someones. Secondly these functions need select which lock (read 
>>>> lock or write lock) will be used, according to the thread it is 
>>>> running in. If the thread context isn't considered, the added lock 
>>>> will easily introduce deadlock. Besides that, in most time, 
>>>> developer easily forget to add locks for new functions.
>>>> >
>>>> > 2) performance drop. More lower functions are more frequently called.
>>>> >
>>>> > 3) easily introduce false positive lockdep complaint, because 
>>>> write lock has big range in recovery thread, but low level 
>>>> functions will hold read lock may be protected by other locks in 
>>>> other threads.
>>>> >
>>>> > Therefore the new solution will try to add lock protection for 
>>>> ioctls of kfd. Its goal is that there are no threads except for 
>>>> recovery thread or its children (for xgmi) to access hardware when 
>>>> doing GPU reset and resume. So refine recovery thread as the following:
>>>> >
>>>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>>>> >     1). if failed, it means system had a recovery thread running, 
>>>> current thread exit directly;
>>>> >     2). if success, enter recovery thread;
>>>> >
>>>> > Step 1: cancel all delay works, stop drm schedule, complete all 
>>>> unreceived fences and so on. It try to stop or pause other threads.
>>>> >
>>>> > Step 2: call down_write(&adev->reset_sem) to hold write lock, 
>>>> which will block recovery thread until other threads release read 
>>>> locks.
>>>>
>>>> Those two steps need to be exchanged or otherwise it is possible 
>>>> that new delayed work items etc are started before the lock is taken.
>>>>
>>>> Just to make it clear until this is fixed the whole patch set is a NAK.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> >
>>>> > Step 3: normally, there is only recovery threads running to 
>>>> access hardware, it is safe to do gpu reset now.
>>>> >
>>>> > Step 4: do post gpu reset, such as call all ips' resume functions;
>>>> >
>>>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads 
>>>> and release write lock. Recovery thread exit normally.
>>>> >
>>>> > Other threads call the amdgpu_read_lock to synchronize with 
>>>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>>>> release read lock if it has holden one, and then blocks itself to 
>>>> wait for recovery finished event. If thread successfully hold read 
>>>> lock and in_gpu_reset is 0, it continues. It will exit normally or 
>>>> be stopped by recovery thread in step 1.
>>>> >
>>>> > Dennis Li (4):
>>>> >    drm/amdgpu: remove reset lock from low level functions
>>>> >    drm/amdgpu: refine the GPU recovery sequence
>>>> >    drm/amdgpu: instead of using down/up_read directly
>>>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>>>> >
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |   6 +
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  14 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 173 +++++++++++++-----
>>>> >   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |   8 -
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   4 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |   9 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c |   5 +-
>>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c |   5 +-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 172 ++++++++++++++++-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |   3 +-
>>>> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c |   4 +
>>>> >   .../amd/amdkfd/kfd_process_queue_manager.c |  17 ++
>>>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>>>> >
>>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------1AF1FBCB2CF8CD2F6B5B0AFD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hey Christian, Denis, see bellow - <br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-06 6:34 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com">
      
      Hi Andrey,<br>
      <br>
      well good question. My job is to watch over the implementation and
      design and while I always help I can adjust anybodies schedule.<br>
      <br>
      Is the patch to print a warning when the hardware is accessed
      without holding the locks merged yet? If not then that would
      probably be a good starting point.<br>
    </blockquote>
    <p><br>
    </p>
    <p>It's merged into amd-staging-drm-next and since I work on
      drm-misc-next I will cherry-pick it into there.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> <br>
      Then we would need to unify this with the SRCU to make sure that
      we have both the reset lock as well as block the hotplug code from
      reusing the MMIO space.<br>
    </blockquote>
    <br>
    <p>In my understanding there is a significant difference between
      handling of GPU reset and unplug - while GPU reset use case
      requires any HW accessing code to block and wait for the reset to
      finish and then proceed, hot-unplug<br>
      is permanent and hence no need to wait and proceed but rather
      abort at once. This why I think that in any place we already check
      for device reset we should also add a check for hot-unplug but the
      handling would be different<br>
      in that for hot-unplug we would abort instead of keep waiting.</p>
    <p>Similar to handling device reset for unplug we obviously also
      need to stop and block any MMIO accesses once device is unplugged
      and, as Daniel Vetter mentioned - we have to do it before
      finishing pci_remove (early device fini)<br>
      and not later (when last device reference is dropped from user
      space) in order to prevent reuse of MMIO space we still access by
      other hot plugging devices. As in device reset case we need to
      cancel all delay works, stop drm schedule, complete all unfinished
      fences(both HW and scheduler fences). While you stated strong
      objection to force signalling scheduler fences from GPU reset,
      quote: <br>
    </p>
    <p>&quot;you can't signal the dma_fence waiting. Waiting for a dma_fence
      also means you wait for the GPU reset to finish. When we would
      signal the dma_fence during the GPU reset then we would run into
      memory corruption because the hardware jobs running after the GPU
      reset would access memory which is already freed.&quot;<br>
      To my understating this is a key difference with hot-unplug, the
      device is gone, all those concerns are irrelevant and hence we can
      actually force signal scheduler fences (setting and error to them
      before) to force completion of any<br>
      waiting clients such as possibly IOCTLs or async page flips e.t.c.<br>
    </p>
    <p>Beyond blocking all delayed works and scheduler threads we also
      need to guarantee no&nbsp; IOCTL can access MMIO post device unplug OR
      in flight IOCTLs are done before we finish pci_remove
      (amdgpu_pci_remove for us).<br>
      For this I suggest we do something like what we worked on with
      Takashi Iwai the ALSA maintainer recently when he helped
      implementing PCI BARs move support for snd_hda_intel. Take a look
      at<br>
<a class="moz-txt-link-freetext" href="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497">https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=cbaa324799718e2b828a8c7b5b001dd896748497</a>
      and<br>
<a class="moz-txt-link-freetext" href="https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440">https://cgit.freedesktop.org/~agrodzov/linux/commit/?h=yadro/pcie_hotplug/movable_bars_v9.1&amp;id=e36365d9ab5bbc30bdc221ab4b3437de34492440</a><br>
      We also had same issue there, how to prevent MMIO accesses while
      the BARs are migrating. What was done there is a refcount was
      added to count all IOCTLs in flight, for any in flight&nbsp; IOCTL the
      BAR migration handler would <br>
      block for the refcount to drop to 0 before it would proceed, for
      any later IOCTL it stops and wait if device is in migration state.
      We even don't need the wait part, nothing to wait for, we just
      return with -ENODEV for this case.</p>
    <p>The above approach should allow us to wait for all the IOCTLs in
      flight, together with stopping scheduler threads and cancelling
      and flushing all in flight work items and timers i think It should
      give as full solution for the hot-unplug case<br>
      of preventing any MMIO accesses post device pci_remove.<br>
      <br>
      Let me know what you think guys.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com"> <br>
      And then testing, testing, testing to see if we have missed
      something.<br>
      <br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 05.04.21 um 19:58 schrieb Andrey
        Grodzovsky:<br>
      </div>
      <blockquote type="cite" cite="mid:1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com">
        <p>Denis, Christian, are there any updates in the plan on how to
          move on with this ? As you know I need very similar code for
          my up-streaming of device hot-unplug. My latest solution (<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html" moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
          was not acceptable because of low level guards on the register
          accessors level which was hurting performance. Basically I
          need a way to prevent any MMIO write accesses from kernel
          driver after device is removed (UMD accesses are taken care of
          by page faulting dummy page). We are using now hot-unplug code
          for Freemont program and so up-streaming became more of a
          priority then before. This MMIO access issue is currently my
          main blocker from up-streaming. Is there any way I can assist
          in pushing this on ?</p>
        <p>Andrey&nbsp; <br>
        </p>
        <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m., Christian
          König wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com"> Am
          18.03.21 um 10:30 schrieb Li, Dennis:<br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <meta name="Generator" content="Microsoft Word 15 (filtered
              medium)">
            <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
            <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
            <div class="WordSection1">
              <p class="MsoNormal">&gt;&gt;&gt; The GPU reset doesn't
                complete the fences we wait for. It only completes the
                hardware fences as part of the reset.<o:p></o:p></p>
              <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence
                while holding the reset lock is illegal and needs to be
                avoided.<o:p></o:p></p>
              <p class="MsoNormal">I understood your concern. It is more
                complex for DRM GFX, therefore I abandon adding lock
                protection for DRM ioctls now. Maybe we can try to add
                all kernel &nbsp;dma_fence waiting in a list, and signal all
                in recovery threads. Do you have same concern for
                compute cases? </p>
            </div>
          </blockquote>
          <br>
          Yes, compute (KFD) is even harder to handle.<br>
          <br>
          See you can't signal the dma_fence waiting. Waiting for a
          dma_fence also means you wait for the GPU reset to finish.<br>
          <br>
          When we would signal the dma_fence during the GPU reset then
          we would run into memory corruption because the hardware jobs
          running after the GPU reset would access memory which is
          already freed.<br>
          <br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <div class="WordSection1">
              <p class="MsoNormal"><o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains
                about this when it is used correctly. The only reason it
                doesn't complain here is because you use an
                atomic+wait_event instead of a locking primitive.<o:p></o:p></p>
              <p class="MsoNormal">Agree. This approach will escape the
                monitor of lockdep.&nbsp; Its goal is to block other threads
                when GPU recovery thread start. But I couldn’t find a
                better method to solve this problem. Do you have some
                suggestion? </p>
            </div>
          </blockquote>
          <br>
          Well, completely abandon those change here.<br>
          <br>
          What we need to do is to identify where hardware access
          happens and then insert taking the read side of the GPU reset
          lock so that we don't wait for a dma_fence or allocate memory,
          but still protect the hardware from concurrent access and
          reset.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
            <div class="WordSection1">
              <p class="MsoNormal"><o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p class="MsoNormal">Best Regards<o:p></o:p></p>
              <p class="MsoNormal">Dennis Li<o:p></o:p></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Thursday, March 18, 2021 4:59 PM<br>
                    <b>To:</b> Li, Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                    Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                    Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                    Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                    <b>Subject:</b> AW: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Exactly that's what
                    you don't seem to understand.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">The GPU reset
                    doesn't complete the fences we wait for. It only
                    completes the hardware fences as part of the reset.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">So waiting for a
                    fence while holding the reset lock is illegal and
                    needs to be avoided.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Lockdep also
                    complains about this when it is used correctly. The
                    only reason it doesn't complain here is because you
                    use an atomic+wait_event instead of a locking
                    primitive.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                    UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
              </div>
              <div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              </div>
              <div class="MsoNormal" style="text-align:center" align="center">
                <hr width="98%" size="2" align="center"> </div>
              <div id="divRplyFwdMsg">
                <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
                    <b>Gesendet:</b> Donnerstag, 18. März 2021 09:28<br>
                    <b>An:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                    &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                    Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                    Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                    Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                    <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability</span> <o:p></o:p></p>
                <div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                </div>
              </div>
              <div>
                <div>
                  <p class="MsoNormal">&gt;&gt;&gt; Those two steps need
                    to be exchanged or otherwise it is possible that new
                    delayed work items etc are started before the lock
                    is taken.<br>
                    What about adding check for adev-&gt;in_gpu_reset in
                    work item? If exchange the two steps, it maybe
                    introduce the deadlock.&nbsp; For example, the user
                    thread hold the read lock and waiting for the fence,
                    if recovery thread try to hold write lock and then
                    complete fences, in this case, recovery thread will
                    always be blocked.<o:p></o:p></p>
                </div>
                <div>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                    Best Regards<br>
                    Dennis Li<br>
                    -----Original Message-----<br>
                    From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                    <br>
                    Sent: Thursday, March 18, 2021 3:54 PM<br>
                    To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;;
                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a>; Deucher,
                    Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                    Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                    Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                    Subject: Re: [PATCH 0/4] Refine GPU recovery
                    sequence to enhance its stability<br>
                    <br>
                    Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                    &gt; We have defined two variables in_gpu_reset and
                    reset_sem in adev object. The atomic type variable
                    in_gpu_reset is used to avoid recovery thread
                    reenter and make lower functions return more earlier
                    when recovery start, but couldn't block recovery
                    thread when it access hardware. The r/w semaphore
                    reset_sem is used to solve these synchronization
                    issues between recovery thread and other threads.<br>
                    &gt;<br>
                    &gt; The original solution locked registers' access
                    in lower functions, which will introduce following
                    issues:<br>
                    &gt;<br>
                    &gt; 1) many lower functions are used in both
                    recovery thread and others. Firstly we must harvest
                    these functions, it is easy to miss someones.
                    Secondly these functions need select which lock
                    (read lock or write lock) will be used, according to
                    the thread it is running in. If the thread context
                    isn't considered, the added lock will easily
                    introduce deadlock. Besides that, in most time,
                    developer easily forget to add locks for new
                    functions.<br>
                    &gt;<br>
                    &gt; 2) performance drop. More lower functions are
                    more frequently called.<br>
                    &gt;<br>
                    &gt; 3) easily introduce false positive lockdep
                    complaint, because write lock has big range in
                    recovery thread, but low level functions will hold
                    read lock may be protected by other locks in other
                    threads.<br>
                    &gt;<br>
                    &gt; Therefore the new solution will try to add lock
                    protection for ioctls of kfd. Its goal is that there
                    are no threads except for recovery thread or its
                    children (for xgmi) to access hardware when doing
                    GPU reset and resume. So refine recovery thread as
                    the following:<br>
                    &gt;<br>
                    &gt; Step 0:
                    atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0, 1)<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a
                    recovery thread running, current thread exit
                    directly;<br>
                    &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
                    &gt;<br>
                    &gt; Step 1: cancel all delay works, stop drm
                    schedule, complete all unreceived fences and so on.
                    It try to stop or pause other threads.<br>
                    &gt;<br>
                    &gt; Step 2: call
                    down_write(&amp;adev-&gt;reset_sem) to hold write
                    lock, which will block recovery thread until other
                    threads release read locks.<br>
                    <br>
                    Those two steps need to be exchanged or otherwise it
                    is possible that new delayed work items etc are
                    started before the lock is taken.<br>
                    <br>
                    Just to make it clear until this is fixed the whole
                    patch set is a NAK.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    &gt;<br>
                    &gt; Step 3: normally, there is only recovery
                    threads running to access hardware, it is safe to do
                    gpu reset now.<br>
                    &gt;<br>
                    &gt; Step 4: do post gpu reset, such as call all
                    ips' resume functions;<br>
                    &gt;<br>
                    &gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0,
                    wake up other threads and release write lock.
                    Recovery thread exit normally.<br>
                    &gt;<br>
                    &gt; Other threads call the amdgpu_read_lock to
                    synchronize with recovery thread. If it finds that
                    in_gpu_reset is 1, it should release read lock if it
                    has holden one, and then blocks itself to wait for
                    recovery finished event. If thread successfully hold
                    read lock and in_gpu_reset is 0, it continues. It
                    will exit normally or be stopped by recovery thread
                    in step 1.<br>
                    &gt;<br>
                    &gt; Dennis Li (4):<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from low level
                    functions<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU recovery sequence<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using down/up_read
                    directly<br>
                    &gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock protection for
                    kfd entry functions<br>
                    &gt;<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 6 +<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;
                    |&nbsp; 14 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;
                    | 173 +++++++++++++-----<br>
                    &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 8 -<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 4 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 9 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 5 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 5 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    | 172 ++++++++++++++++-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 3 +-<br>
                    &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    |&nbsp;&nbsp; 4 +<br>
                    &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp;
                    |&nbsp; 17 ++<br>
                    &gt;&nbsp;&nbsp; 12 files changed, 345 insertions(+), 75
                    deletions(-)<br>
                    &gt;<o:p></o:p></p>
                </div>
              </div>
            </div>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------1AF1FBCB2CF8CD2F6B5B0AFD--

--===============0270902172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0270902172==--
