Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D71C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 03:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934C710EFC5;
	Thu,  3 Mar 2022 03:16:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D3110EFC5
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 03:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wybx8DdsFBFcUBtBHC/nWglHUhFUlx9dtoS8hH9NsMUC9LUro8aGcNZdg94aAGG3EVd5/c2xnrrOQmjXZEU5h5eon8eGQsUW/DpLNBRk1tDFDpES0nRRwYM/u81SbEonkdg/Nlrei6TfO8Pjg7nb2jisg1bpC52Jk3Qw++N5YOM8HniY5zRymEv7/2J66NKaQ80k6m4xfwJ6N5cNab4sQkSAtSy5SGp7Fxo7vjvA7+lAM91z2w4tnuxyV3OLOxnfxnX1bEpm6bb1CCGTcQPxhWGEI7gwG07s78cjtOMFSrL6JnVLYXWz7ht8SNHmDSEUjiGftV/NXpHmmDTV6D4Afg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el4zHjBNyqW7w7b3ZVG3uM81Lq/lZlTgBTiu5IpV0IE=;
 b=CaoHKkk1jAMaj3HcQZxQo9/pPuBt7G2hl1OEwmUi069C6oaVYxHoE9/MzBOnVUI777AjyM1d10v2D08Yo5BhkAvUR6JTfHaof46g2tU/O3B+vOg0+xQKPOFIdTWl9eoVMBV2e4B+ExPb2ZzYyXq2YZNDIYx2H3X7Je1H05j+eAadNE9WhdxRETg4HJJ1j3rjQz2FGG1GzZeRhl2+I6NTHYryDOMBDcWzBEfOsjUvbJQRMj7UTBs7ij+ptIv2+TqhQfG2al+vLpEEhPsvpWriXYYWSg7yV1X+6Jv83zMSvGR5/JCS46bPWUNdG4t4zR8RlNjZNN/BmnMDE67sZxWU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el4zHjBNyqW7w7b3ZVG3uM81Lq/lZlTgBTiu5IpV0IE=;
 b=2Yjhf5Z9cHyU9qNfe1ANQuaZNWur0d6W5T58HeF03vO2pFHdooeVF1NtH4M9vGYEBv+9EAwOq952iA7fBMfYFLk4na9dgQQjcGeeQq6hgDmgENiNl2L1vgRMCbi9cnk8fZ4LDBOtprz+92krsRBA7uzqiI0qhUls/Jfa5Tni/Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 03:16:52 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 03:16:52 +0000
Message-ID: <7e9dc4ea-3665-7632-280f-9e8ed8948b45@amd.com>
Date: Wed, 2 Mar 2022 22:16:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Content-Language: en-US
To: "Chen, JingWen" <JingWen.Chen2@amd.com>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
 <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
 <C3715E75-B013-409C-B2A3-E10CD79FD027@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <C3715E75-B013-409C-B2A3-E10CD79FD027@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd752d62-2e2d-4eba-e760-08d9fcc4428f
X-MS-TrafficTypeDiagnostic: PH7PR12MB5617:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB561778C7F30764D6FC465D9BEA049@PH7PR12MB5617.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OvUNgvPZt0i/IJ6TCzWCFp78fWqJ3LvqWCJDXOVPFboCb9XLucz9aSgsGhBsozgtM3W9Qhj2/Kx6QFR8q6wXnqNpm7AK71q0DV15+WXfB3O75bur/8Sppu7dEbooq1KI3RHb8Pe7UvpV+2w1uyqoKezMN6ypWF27pkVh8UDCUZdSwn3lIUl3KZWGwV1lXDijB83G1MXy7yxxG31pC6566GWa1FBUg+w2WkscCy2rNOwuddRyAdScsPyP5qx+csue1M/DVhZuPVEMyJ/Hfl2UvNMmzgGiRKkMH+g+46QBtjzJ14uz4EOvCKayU3eKYDXvzE2SNJbBK1d5qUpNqu1so4jeLyiEzJ+HYmVasnOPaKwZoXL4gHdWPMDcat3fU+lx8nlH50Y28C2GQoHKHjBIGonGDACJSbKQPvz922soTyDtF8Gc53GDNK6Lmv/79hMtYKKZaOG+M8jlOFjGQccqhX3kS/J7npd9K55TvRJ/abJ4vx8EU/9VXuPgQqG+6QjoEJkOz1zkAxIoTJBnQx57IuMtqqjHr9yNExbW7yM2YvDdkcnoo6UWrGAKrIBSwSRXemFr0ewHx8FmMvu+8pW3WOihQv1V63q7P7pM3LE7jC+gOGphCkbkmQGf4KC+jxM6SWbNrm4r4fI0VmK2aIBdwamaLB/pkKvI5NrLPTgp+4qPFETRj68aZez6mBzd94dN6aXCaZAJz33R7rJCAkWxsZwLUJkbUwiTmwjOu5IIY+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(508600001)(6636002)(54906003)(37006003)(6862004)(8676002)(31686004)(4326008)(316002)(31696002)(66574015)(83380400001)(86362001)(36756003)(6486002)(8936002)(186003)(53546011)(5660300002)(2906002)(2616005)(66556008)(66476007)(44832011)(6512007)(66946007)(6506007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZsaVFqUENiRXNuaUVIYzhMd1pkM0xyUDN2ZVp1aTZRMURUSVR5eCsvUTlT?=
 =?utf-8?B?MXd3Y0dZekVCMnp0aWlkN3o3amVBNHJrdjFrR1FzS2J1NGhIS3NiMzZqcW8z?=
 =?utf-8?B?b0lOQm9PVnU4U0lGeUFQcDBJZUN6MDdiVGlKR2ZyWndwK01GTXZQV3lkNXNo?=
 =?utf-8?B?ekxOMXRLKzdYYk9jMExkN0hhSVNFclZTeE1DNHJiV2tYUXdCdEFVS2t3Nkdn?=
 =?utf-8?B?RFRJWGE4dG51NTl6bkZFcjVTN0FiOE9ZVHhzUnU1eWViT3AzWFJqa2dnSU9j?=
 =?utf-8?B?bUloWTQ4dTFacnlXVHhQUGlwTGlwUUJuNHRjbDFXS3FQZStOTkxZM0w1SHk3?=
 =?utf-8?B?dXJpUmoxMm5QUC9uWjFoU0Z5azY4Mnd2Sk81bW5RbU9ybXplTjFraDJnVFFJ?=
 =?utf-8?B?cXdRYUdCMkhod052UW1zRWVLTTR5VzFZbFpVT0JOV3NUQWNXSjdWdytlRHU1?=
 =?utf-8?B?OGV6ZVBXYjgxejNlTzZUWFBoaU1FdC91Z3ZDcTBSTGJ4NmluVWU2eWYzSGhy?=
 =?utf-8?B?NzhGUlJhTTV2RW5wVTdBamRoMTE4OVp4RXgwL3NyeldNcE1xcXB3SFY4QUpO?=
 =?utf-8?B?OVlvUmJDOWJzM0hGaW5NQzJmWDdZK09xWlorc1hGMVZCTDRwVXRiZnIxUnA5?=
 =?utf-8?B?Y2RtcXRKTFYybFRqcDRkbHp3ZWZXRThZc3lZNUZRb1hpdkpXWEUrYVRCYzBS?=
 =?utf-8?B?dkgwZDRPUnlWRkUwUFk3Rlk4QjR4MUdjMmNZSzF3S05GNUV6UTJPeTZJM2Fv?=
 =?utf-8?B?Tm9qaVlFSGYwVEhEVE1zcW53Z1Ric2svL1RuazlPNnhLMG1OVitoSTRrd0lJ?=
 =?utf-8?B?bytXVWRndzNZVHZ5ZjF4WFh6TnorWjdmSllGSTc2LzFCVUxCaG8wKzRwTTlC?=
 =?utf-8?B?S1ByeXZ6YXBRa0N6Y0NGV21hYXpyTUNsUU1LYlMwaVZIbThJNi9yL0x2azJo?=
 =?utf-8?B?MENwK3hxZzZyb1lkTnhRdmZ3eEJNQVBaUU9NT2tXQ3Bwdm9tYlljT0VqeUVo?=
 =?utf-8?B?TGRtYnZFZ3pKSDM5ZjlpWDQzQStRNUtxSWpxbXMzaEFSSnFMamdwdUEwVUoy?=
 =?utf-8?B?TzZxTjlOdk03QkE2L0ppYUxQV3VxbEhXS0tHMG5oRkxLb1ZmQUwya2ZQdzlE?=
 =?utf-8?B?Ymw5dUducFFQK2VwdTVKb1VwT3lwRjQ5Y3hlL05WTmFyRHdCbUptSFdaREMr?=
 =?utf-8?B?QktGNjd2alJ1YVJGdzZpS0VteHBPUnMxN1pnWWdZdm1ZR3doK09mWWpCdmU0?=
 =?utf-8?B?alZVenRiYytveTVrWnA4aVZOczRyWFg0a29xc0EzS3VLWTVsUEZ4SG5DZXpC?=
 =?utf-8?B?eFE0OGVJdldaTlF4VmlHOWI1RXJ5MEswTGpLZEtJZGJyMEJseWVWa2NZQ0hP?=
 =?utf-8?B?TmdjaXQyZzBWbDkzNy9DSkNuS2pTNEFaYzlJWFc1a3o2Ny96d0p4WEl3d2Va?=
 =?utf-8?B?V3lwaGRVVGhCWmllVUhtOU9rdWpNYUlOR2xyeFdlL3pDZzRhRDVyOERSdTU2?=
 =?utf-8?B?VENrYlZYZFgyTHRRRnRBakhKRDRlWjFaTHdXblJCVis3SFQybzIwcFRkNnAw?=
 =?utf-8?B?RFZDMTM1U2RXcE9QbjMyMTNWbHUweDlYV1pjYUFTMlhTNHIzSWZkVEd6Nnc5?=
 =?utf-8?B?QXI2SUVBU1c4enFjM2lDYkZSaHc5dEJKZlBHdE5ZWndEdVZHQzJ3TUhuenQw?=
 =?utf-8?B?WDV2SVo4cHEyNVRKRGZrRDBTYW9WajJDTTlSaTlXcGRBUzkzd0hTOEhSRnpq?=
 =?utf-8?B?RmN6NWVpRzJYbzNMUHdBVnhWZ1U1NWxaeisxWlllNUZVWG41bW5CNC83eWRu?=
 =?utf-8?B?eDlidTZOenhzMmRObkViTThmdlBOdlVnU2xmRERhZy92eHZQeHFIaFlJWlV6?=
 =?utf-8?B?QTIxTDNwVnEwcjk5SjJuRjMzeXMveVF4Mzczcm41YzlBQjJuTGJ0TUNXREdC?=
 =?utf-8?B?b1lPN3pWT3NueW9nWU40V1UrMHQxM3lmNTdVYlZDaUxCdHdiUzRBQnErU256?=
 =?utf-8?B?OVFsUWl2SDhlR0JPbUxYRzEvelZ2RHFXczBNOEFycnVzWjYrUjBBQTlkZHJZ?=
 =?utf-8?B?R0p4UDR1bGVaU3c1N3RFWFRVbTdOUXBMMVR5WVpZVVhubE5LZmZzd1phSkZi?=
 =?utf-8?B?TktQaXcyWGxYdXdYaG1oWXdaV2JlQ1QxR1hNelorRHZqSVp5MC9zZ0NYekVk?=
 =?utf-8?B?TWZpZWJCTTYvR2ROaVVCZVR3WmxJRGdKRU9vaVpvRDFSUDQ4eDNoVXBESDRq?=
 =?utf-8?Q?IIdQbwjDCoDYPmXc6NHYCtd9zjIN4vaPBuZPHpfNWo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd752d62-2e2d-4eba-e760-08d9fcc4428f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:16:51.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25t9UwJm5uAnXyOF7mN5NROJFJ/5bYvr5zQTbvLKetuqwPJGW9D1XFgPr7YIFrtID1nP5y9JhsdK4n9RfgCYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK, i will do quick smoke test tomorrow and push all of it it then.

Andrey

On 2022-03-02 21:59, Chen, JingWen wrote:
> Hi Andrey,
>
> I don't have the bare mental environment, I can only test the SRIOV cases.
>
> Best Regards,
> JingWen Chen
>
>
>
>> On Mar 3, 2022, at 01:55, Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> wrote:
>>
>> The patch is acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>
>> If you also smoked tested bare metal feel free to apply all the patches, if no let me know.
>>
>> Andrey
>>
>> On 2022-03-02 04:51, JingWen Chen wrote:
>>> Hi Andrey,
>>>
>>> Most part of the patches are OK, but the code will introduce a ib test fail on the disabled vcn of sienna_cichlid.
>>>
>>> In SRIOV use case we will disable one vcn on sienna_cichlid, I have attached a patch to fix this issue, please check the attachment.
>>>
>>> Best Regards,
>>>
>>> Jingwen Chen
>>>
>>>
>>> On 2/26/22 5:22 AM, Andrey Grodzovsky wrote:
>>>> Hey, patches attached - i applied the patches and resolved merge conflicts but weren't able to test as my on board's network card doesn't work with 5.16 kernel (it does with 5.17, maybe it's Kconfig issue and i need to check more).
>>>> The patches are on top of 'cababde192b2 Yifan Zhang         2 days ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.
>>>>
>>>> Please test and let me know. Maybe by Monday I will be able to resolve the connectivity issue on 5.16.
>>>>
>>>> Andrey
>>>>
>>>> On 2022-02-24 22:13, JingWen Chen wrote:
>>>>> Hi Andrey,
>>>>>
>>>>> Sorry for the misleading, I mean the whole patch series. We are depending on this patch series to fix the concurrency issue within SRIOV TDR sequence.
>>>>>
>>>>>
>>>>>
>>>>> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>>>>>> No problem if so but before I do,
>>>>>>
>>>>>>
>>>>>> JingWen - why you think this patch is needed as a standalone now ? It has no use without the
>>>>>> entire feature together with it. Is it some changes you want to do on top of that code ?
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>>>>>> [Public]
>>>>>>>
>>>>>>>
>>>>>>> If it applies cleanly, feel free to drop it in.  I'll drop those patches for drm-next since they are already in drm-misc.
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>> ------------------------------------------------------------------------
>>>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>>>>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>
>>>>>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is ready
>>>>>>> No because all the patch-set including this patch was landed into
>>>>>>> drm-misc-next and will reach amd-staging-drm-next on the next upstream
>>>>>>> rebase i guess.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>>>>>> Hi Andrey,
>>>>>>>>
>>>>>>>> Will you port this patch into amd-staging-drm-next?
>>>>>>>>
>>>>>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>>>>>> who helped reviewing.
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>>>>>> domain are we in - for single device there iis a single
>>>>>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>>>>>> reset wq is per hive.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>>>> One more comment below, with that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 ++--------------
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>>>>>>>>>>>       3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> @@ -2287,6 +2287,47 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>>>>>           return r;
>>>>>>>>>>>       }
>>>>>>>>>>>       +static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>>>>>>>>> +{
>>>>>>>>>>> +    long timeout;
>>>>>>>>>>> +    int r, i;
>>>>>>>>>>> +
>>>>>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>>>>>> +
>>>>>>>>>>> +        /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>>>>>> +            continue;
>>>>>>>>>>> +
>>>>>>>>>>> +        switch (ring->funcs->type) {
>>>>>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>>>>>> +            break;
>>>>>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>>>>>> +            break;
>>>>>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>>>>>> +            break;
>>>>>>>>>>> +        default:
>>>>>>>>>>> +            timeout = adev->video_timeout;
>>>>>>>>>>> +            break;
>>>>>>>>>>> +        }
>>>>>>>>>>> +
>>>>>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>>>> +                   timeout, adev->reset_domain.wq, ring->sched_score, ring->name);
>>>>>>>>>>> +        if (r) {
>>>>>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>>>> +                  ring->name);
>>>>>>>>>>> +            return r;
>>>>>>>>>>> +        }
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +
>>>>>>>>>>>       /**
>>>>>>>>>>>        * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>>>>>        *
>>>>>>>>>>> @@ -2419,6 +2460,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>>>>>               }
>>>>>>>>>>>           }
>>>>>>>>>>>       +    r = amdgpu_device_init_schedulers(adev);
>>>>>>>>>>> +    if (r)
>>>>>>>>>>> +        goto init_failed;
>>>>>>>>>>> +
>>>>>>>>>>>           /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>>>>>           if (!adev->gmc.xgmi.pending_reset)
>>>>>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>>>> @@ -457,8 +457,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>>>                         atomic_t *sched_score)
>>>>>>>>>>>       {
>>>>>>>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>>>>>>>> -    long timeout;
>>>>>>>>>>> -    int r;
>>>>>>>>>>>             if (!adev)
>>>>>>>>>>>               return -EINVAL;
>>>>>>>>>>> @@ -478,36 +476,12 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>>>>>           ring->fence_drv.fences = kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>>>>>                            GFP_KERNEL);
>>>>>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>>>>>> -        return -ENOMEM;
>>>>>>>>>>>       -    /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>>>> -    if (ring->no_scheduler)
>>>>>>>>>>> -        return 0;
>>>>>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>>>>>> +    ring->sched_score = sched_score;
>>>>>>>>>> Let's move this into the caller and then use ring->num_hw_submission in the fence code as well.
>>>>>>>>>>
>>>>>>>>>> The maximum number of jobs on the ring is not really fence specific.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>>       -    switch (ring->funcs->type) {
>>>>>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>>>>>> -        break;
>>>>>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>>>>>> -        break;
>>>>>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>>>>>> -        break;
>>>>>>>>>>> -    default:
>>>>>>>>>>> -        timeout = adev->video_timeout;
>>>>>>>>>>> -        break;
>>>>>>>>>>> -    }
>>>>>>>>>>> -
>>>>>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>>>>>> -    if (r) {
>>>>>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>>>> -              ring->name);
>>>>>>>>>>> -        return r;
>>>>>>>>>>> -    }
>>>>>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>>>>>> +        return -ENOMEM;
>>>>>>>>>>>             return 0;
>>>>>>>>>>>       }
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>>>>>           bool has_compute_vm_bug;
>>>>>>>>>>>           bool            no_scheduler;
>>>>>>>>>>>           int            hw_prio;
>>>>>>>>>>> +    unsigned num_hw_submission;
>>>>>>>>>>> +    atomic_t        *sched_score;
>>>>>>>>>>>       };
>>>>>>>>>>>         #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))
