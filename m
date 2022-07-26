Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286ADC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 17:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DBD8BC0E;
	Tue, 26 Jul 2022 17:10:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1514C11A056
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 17:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs9EF1LCDGhQINRlYeXOgXRrZ6GFXuYI6AZc0j0CzBY7+h3SQTYWcp6uRFQtWcjJzAYCKJAgo5ZtlktN3WPEBKGCqCkpAAbGjDn5O0ISoIuta/34IGcSQ+xMEy91gCQyyCtzK8EmURTentTzLjam7xulDnhUrheObtIsTSDe72K5eM5nj3etu+hE2gGAuIm2Mb39xbWCtqg5XN8HLYbWwG2EvCL8Gxu9TCjGFJ0uWe+cPj9pdAnOuTGrI/CkVpgvZWup/P8pW8lmWL2G9LmQWOiWWfI8Gedb5Z6ZXMvBYzYDqEnaRvtmO9/7dSfjptuB2mmXJhpHHwC3UxbQZ4vKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN6cb61E6zu6+5bVt5Do+fVgPB3EGwketdghZDfDujo=;
 b=n5S3mg3XT8jg63l8Nma41hWtAkamcOEFhXGSpclrlx+cxgFK0kC26HG+Ok4oekGH+4PE/wsoIa9IDQrmcZLGADHlMud25bGdUgzdEUAKJ9tZNPgdz/7QaZPE0mf5YS3R1XoWuocs4uV6q7ASOB/gBQFX948RN7B6iQJ2hnb1IOxREGGXbSZ3Ao3b+L1g5xAy524hUpwmjSHHtU4bDPxrZRv+JZYgM7cC3xyp+N51W0S3N2tGAOSYL1lieRtUJtF3jqt9ZYUuS7WBGq4tYbzZOeVpOF1wAXUEuzTgoMB3InFVul3TukwtqIOXhb8yIWsMBksXNc6c/3NnKS+sbaUCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN6cb61E6zu6+5bVt5Do+fVgPB3EGwketdghZDfDujo=;
 b=KgLsjsCv0rjKzgq1Glyv6N/MGdHTfwwNqcCgbdXNEXY+cL10v2UHmAGmDRWr+XWnk+SCXd4ausd+00+F+2uJ5C3LQZ9d/ssel3xpkjmDh7PvtX1QQeb9vbQPM7zygxE21Rjk3RKSvpXrp6jgdyWuZfG2s0QS3Bz7Vsv25M+b3u0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 17:10:55 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 17:10:55 +0000
Message-ID: <7f3e2f3e-bd8e-7971-d85e-616ecd858323@amd.com>
Date: Tue, 26 Jul 2022 13:10:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Crash on resume from S3
Content-Language: en-US
To: Tom Cook <tom.k.cook@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAFSh4Uw776o-kySa+=VGY=Ejnt+kgj_HU3DpDT96AMzRwUa0sQ@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <CAFSh4Uw776o-kySa+=VGY=Ejnt+kgj_HU3DpDT96AMzRwUa0sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce95530-7a0a-4f37-1063-08da6f29ccf3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4232:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2CTcjTjtOopEeI8A5KNj7bBWQqGTgPIQnCTNboLYHCUFlftBmczsbLbPw2uYCviVIQQ7NZYcgwYeUZ8lO9iIgb5T5k8qiLh53iuyfd1yjs8Wf79yHjhWbymTu1OumrZY2ZpPx4kqmiRq8Fi9zIHhMaYA+AHCKT2d91zzibv9h0zh3Wjk10PXJJHp9OZ02RweCZf4zPCFhuSLsRDI3WZ+APxEpQpJoNGbndkgsZADoDt5w8GY+FFUqHRwGjjykPu5KC2XykdCV/RClws32T9ioFq7Z0lVFNxOd5r0QDi7tsR0E+LIdOIelAPc85k8GTeUGTo3zghZ+UJ+X3csO8aqJqWoUWbITM31hrEupUaOr5vcXM4jMmBI+LqH26al4u8TphdPYJfhL1ONhbpTKYSSlIN2gp67zlYFhedGUVnOGdryKW6sz/1JoDZEnTcOlBH/oGrJXdk0Q6SKNinF7URiYX339O0nsQvs9OSwma4YnvqJy6nmry0oXOnmzErKSRBdImKlZGo5e+xVj1LY6mwJ46ErC4+7xv3WoeY1W8gVgMzZ3c7PzQHxaM5S0IRCpM00s55+R6PVUzftHopC5l0rkx+73dDCe7kF55uh6mJ4a2hOcFhztRk9dGhBvEHd8XGBhCGLawxBsNDWv1pi+vTwSArVdugpPLJ++aXNfeW+6WLN5x7BpIR3iON0J0MNHGrxanoku/4FQTYxBhM2qEJlrn7NYUo8TJkygoExPigL2zJG5W2VHCx0mHgQRTg1zqOlNvsrQasJ8J8lfabzg7IxlLsNIsbmWBJXEaZs3Wtbn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(478600001)(83380400001)(8676002)(186003)(66476007)(66556008)(53546011)(66946007)(31686004)(6506007)(2906002)(36756003)(2616005)(6512007)(316002)(31696002)(38100700002)(86362001)(5660300002)(8936002)(41300700001)(44832011)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTYraytPSGhQVEIvdW5JbXBlVUM2cEFlQ3dLelhDMWFEMnY3VldBMTN6M2dD?=
 =?utf-8?B?MVpzNG9qR3RYWm85bVhCb00yMElieEI0QVNTYXQwZjl0cnhvZVBxSlcwYmps?=
 =?utf-8?B?Z1REUUN3V0NlM0hBdE9tN2Qzeks4Rzd1MzJPYUJ6bGhpU2NjbjRSeE1PSjNh?=
 =?utf-8?B?MWVRdTRoOFpNQ05IaENjMHBEbUozSnVMdEFxRGlJSngxK2JmQnpFK1krL0JK?=
 =?utf-8?B?UjEwM0JzbmhSZnF2aHIrQ3hhWDUwRWZmVDlKQ1RGaEdlZGRSeTZjbzJ3aVJT?=
 =?utf-8?B?dWw1K1R3ZGozVi92YVBXY3RVYkdIVFJUMDRldmR2RmtnT05uTUdVQ0FnaWFz?=
 =?utf-8?B?bk9CQ0pXdFBsbWdDNm15UUV1N0ZSdm9hQmpGdW4yb0NzQ1R4ZGtUSkhzUUVi?=
 =?utf-8?B?S2EzaUFIeXU0cUhSdXlZZXlOY2VBZVpkRHB2NGxTajJKY2pGcVVETVJoRnZz?=
 =?utf-8?B?MkhhZzlXdmhYSFRJYjRBVmFUdXQyWmFMa0pZRmdJcDBQSy83ZjRUVG5aRm9F?=
 =?utf-8?B?QzFOT1E5akUzdXRlYXI1UVdxZGZFMTJkbjlRSFlFUW9qTVczMVN0NUpHbVA1?=
 =?utf-8?B?d3RpV1JDQTUyMXh1enNtNFhsZjZvbVZUbVRFWXlLY3o3N3NGYnZzcWZ5YU11?=
 =?utf-8?B?N3RsQk5Zbi8wQTFtVWxqWTVreHlyRU56ZTliOEpaY3hGUnRFZC85Mm5XMTJu?=
 =?utf-8?B?eFVkelVJQnpiOFVKMEhHNUxXcURuSW52ZkUxSW9WN2hGK1JpcnFlNFBRaGZK?=
 =?utf-8?B?NTNTRUwxNU93Rkx1SVdHNDJkbkxxWDBsT3hjTDhXRnVSbzU1MzREWlgralNL?=
 =?utf-8?B?K0ZxRTd1dUw0eUUrOTlnTzlzREwvaHJuVmNCV2NpVkkzRVJubGdUbHJOUFhP?=
 =?utf-8?B?a25nZEY4ZW9OZW9lR3pneFBmZVR4Zkw4R2dSbjkxa1dBMHdOTVlWY3BjSE5O?=
 =?utf-8?B?NDMwUmh6RUJQY09TMjlQaG96ZVc2bTJaWSs5dGFVajl0VU16akpXaWtrYUt3?=
 =?utf-8?B?MlFoYzF1a29zZzhPQTVWblE5TFA5RmlnV1FGejZ2L2RuektaNlZRZVFkS3ho?=
 =?utf-8?B?ZjhYUi9WMFpDWE5QMEU0Q2ZiTHAxaGZCNEhaZFkvTkk4ZkxhTFFoRnRQdTV1?=
 =?utf-8?B?T3Rhdjc5eHFxb29TTTExTGxJK0pCUHRIT05uS2RBRHdKZkwvUGNQYjZmU3gx?=
 =?utf-8?B?UzVtSmdVamxBV0RRTmp3b1RpVnY0dE5ZZGRMUEFFNHFyVWY0bWRVQ2pqa1J5?=
 =?utf-8?B?UDJjeVdQYVpQUVVsUnU4WTNhNXBJeEozQVYrRWk5QkFSYUVkbDQyaDZJcnZu?=
 =?utf-8?B?SHo4RWFjWmcrNmFUTm9KNUkyWjg2T3pHNkI0SVRnWGMzSm1OanNLZjhHYVFT?=
 =?utf-8?B?UzdXQU1KZGN6NVk3ZVhmWWN2TWJubTU2dlg3M3ZHOFFOWFFvMzVUM1FLQlFS?=
 =?utf-8?B?OG5Oc1NOTUxoRnpKN05nTSs3b244TWFTRyswK2xIMjRRYU9TeW1VdDY1Y2Q0?=
 =?utf-8?B?U3BNTlplUmczUi9lekRBNTkxOUF3RWI1TnFWVTdmK1FtckwxTUdNSUowd1NW?=
 =?utf-8?B?d1VOSUprREMyMDBRQ0dXdkIwS1hXWFNYcXMxdHF1cEVSK01TSVYyVmsxa0NB?=
 =?utf-8?B?eUdaUlFaTmY2UTgvYVcyYk16OE0wdENVZStpZ0xMSDdYUW1adGlCNy92UVZn?=
 =?utf-8?B?U1cxZVQwUmpraXQ1MmVJeDYrek5aODFKNEZ4Y3k0eHplOUtFTW42Tk4wemJW?=
 =?utf-8?B?b3cyTHNUZ0VpY2tEeldrcDUwMkk1eCtvUWE5bDNDdmEwNXVmTW1hUnp0c0R2?=
 =?utf-8?B?bjVEY0wwK21ZaEFaNmRmcTU4c0d6WkZPM1VNdk1tc3RkZGE2Ulh5T3puc2FB?=
 =?utf-8?B?dGw1SW9xeVk3S0dZYy9DSEZHK1VQT1VCMVgrZEt2VmlKWkZ4c0FBd2QyZkl0?=
 =?utf-8?B?OGVOejJLcDhmdVBVWFhIZWtrNTgrWW9ZbE9CZXdQWWxlSFpUOWdSZFlZQzFt?=
 =?utf-8?B?YkJUTS9nR2dURjBWNjVQWklXZURqTE5XN2cybFNiOTlqVVg4M0ZJSDgySU10?=
 =?utf-8?B?ZU5pM0swcm5ZVjMydWtqc0J5SENBeTNkNlhsdzY4cUlxaFhwMlV0U004Z1VQ?=
 =?utf-8?B?akZKSUR1enkydGlkSkZTWHZ6enNGT0crVUl4cVNsVXd1Rm9USkRzeFhhNlU4?=
 =?utf-8?Q?cWl/p6z1f35V9VcBqJMpUo+olQOcj+pVLYca5VQWO3hv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce95530-7a0a-4f37-1063-08da6f29ccf3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 17:10:55.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1ixT+wcOn2Z98HtqfmL4Ezt3RLH78a4M1NPahTQNLziPvE/mbdLphE1lXTokyBH5PwxupWhxLbZDUbhyWEUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The stack trace is expected part of reset procedure  so that ok. The 
issue you are having is a hang on one of GPU jobs during resume which 
triggers a GPU reset attempt.

You can open a ticket with this issue here 
https://gitlab.freedesktop.org/drm/amd/-/issues, please attach full 
dmesg log.

Andrey

On 2022-07-26 05:06, Tom Cook wrote:
> I have a Ryzen 7 3700U in an HP laptop.  lspci describes the GPU in this way:
>
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile
> Series] (rev c1)
>
> This laptop has never successfully resumed from suspend (I have tried
> every 5.x kernel).  Currently on 5.18.0, the system appears to be okay
> after resume apart from the gpu which is usually giving a blank
> screen, occasionally a scrambled output.  After rebooting, I see this
> in syslog:
>
> Jul 25 11:02:18 frog kernel: [240782.968674] amdgpu 0000:04:00.0:
> amdgpu: GPU reset begin!
> Jul 25 11:02:19 frog kernel: [240783.974891] amdgpu 0000:04:00.0:
> [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test
> failed (-110)
> Jul 25 11:02:19 frog kernel: [240783.988650] [drm] free PSP TMR buffer
> Jul 25 11:02:19 frog kernel: [240784.019057] CPU: 4 PID: 305612 Comm:
> kworker/u32:17 Not tainted 5.18.0 #1
> Jul 25 11:02:19 frog kernel: [240784.019063] Hardware name: HP HP ENVY
> x360 Convertible 15-ds0xxx/85DD, BIOS F.20 05/28/2020
> Jul 25 11:02:19 frog kernel: [240784.019067] Workqueue:
> amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
> Jul 25 11:02:19 frog kernel: [240784.019079] Call Trace:
> Jul 25 11:02:19 frog kernel: [240784.019082]  <TASK>
> Jul 25 11:02:19 frog kernel: [240784.019085]  dump_stack_lvl+0x49/0x5f
> Jul 25 11:02:19 frog kernel: [240784.019095]  dump_stack+0x10/0x12
> Jul 25 11:02:19 frog kernel: [240784.019099]
> amdgpu_do_asic_reset+0x2f/0x4e0 [amdgpu]
> Jul 25 11:02:19 frog kernel: [240784.019278]
> amdgpu_device_gpu_recover_imp+0x41e/0xb50 [amdgpu]
> Jul 25 11:02:19 frog kernel: [240784.019452]
> amdgpu_job_timedout+0x155/0x1b0 [amdgpu]
> Jul 25 11:02:19 frog kernel: [240784.019674]
> drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
> Jul 25 11:02:19 frog kernel: [240784.019681]  ?
> amdgpu_cgs_destroy_device+0x10/0x10 [amdgpu]
> Jul 25 11:02:19 frog kernel: [240784.019896]  ?
> drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
> Jul 25 11:02:19 frog kernel: [240784.019903]  process_one_work+0x227/0x440
> Jul 25 11:02:19 frog kernel: [240784.019908]  worker_thread+0x31/0x3d0
> Jul 25 11:02:19 frog kernel: [240784.019912]  ? process_one_work+0x440/0x440
> Jul 25 11:02:19 frog kernel: [240784.019914]  kthread+0xfe/0x130
> Jul 25 11:02:19 frog kernel: [240784.019918]  ?
> kthread_complete_and_exit+0x20/0x20
> Jul 25 11:02:19 frog kernel: [240784.019923]  ret_from_fork+0x22/0x30
> Jul 25 11:02:19 frog kernel: [240784.019930]  </TASK>
> Jul 25 11:02:19 frog kernel: [240784.019934] amdgpu 0000:04:00.0:
> amdgpu: MODE2 reset
> Jul 25 11:02:19 frog kernel: [240784.020178] amdgpu 0000:04:00.0:
> amdgpu: GPU reset succeeded, trying to resume
> Jul 25 11:02:19 frog kernel: [240784.020552] [drm] PCIE GART of 1024M enabled.
> Jul 25 11:02:19 frog kernel: [240784.020555] [drm] PTB located at
> 0x000000F400900000
> Jul 25 11:02:19 frog kernel: [240784.020577] [drm] VRAM is lost due to
> GPU reset!
> Jul 25 11:02:19 frog kernel: [240784.020579] [drm] PSP is resuming...
> Jul 25 11:02:19 frog kernel: [240784.040465] [drm] reserve 0x400000
> from 0xf47fc00000 for PSP TMR
>
> I'm running the latest BIOS from HP.  Is there anything I can do to
> work around this?  Or anything I can do to help debug it?
>
> Regards,
> Tom Cook
