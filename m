Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 15:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21D10E2EF;
	Wed,  2 Feb 2022 15:29:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A688389FE8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 15:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8Qm9Be8ScDkvxJJyMbyV2/MIccaStdo6f0BCo0YZjxYZMpS/mOeNcqevKsGJfhslyKTeQy+qoU3WF6zuP0O5FFbM40fEmCdMHyKXvT1AIy6IFpRbPhzwAZ4U87B+MrGXnkxLIylw8r/kiY6ClbaedVuDli3HNmODIgeKlStlYbHycXaU0lMI4tMwdSSR0FoYbqPuxtVuDF7ycPN/x5m7RstsgKfp/I0xaRxjT5eye95GcvnBfqm5wAuqKAeYm/+3DDFL3ioBVO4msu4eiOIMe1VGn1gqsdB76fo0srClHQ98+OdklI1tBEQ22xXjUBR3NLEgFkkBDCjVA6LI+wKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBuGDaqMe1FKc7DsvTN0hHYegDJR3d4BvG8e5/bX9vw=;
 b=fIdlwHqTwiNiQhZm6KOy/z+H+m/1wdioz5VFYPshZxkFOkIoyE7wc+eAWcyuSnKk2KCCP70IZzJmCrFKIn/i+w6Xc1Yw8qT21pcLsGnOvuH8SeL8L1k3PfpyRWZfojDlaMEd8E4+GJQwPRKxSWxhhIGvt+yHDW3KeCvxUHLr4oEGpedR4oz9WOR1EgU9aWcAsoSNzHowLz6tZ6+394qLliLjV5cd5TsHEq2++0brc7wh0EEcmQUmab/5+MLfQ3Qt5S+fyjlftvM8nuC6ReQMIgMF2LnxZtXxWGmoNLTkAnp+5wiaOVtYqBYOZ8QVtQnBOWzbUy7Bg6kORy+hXhsEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBuGDaqMe1FKc7DsvTN0hHYegDJR3d4BvG8e5/bX9vw=;
 b=kr9bhHo/eSJtGoaxW/AJ7O3Z4LpQNzClwwj1JmUTL3YKABvZgYYDcrnneuX15dQm5D6FKQIHGn5z9qqZqFW5kDAU6HV86DzTQfiGZxyuNLt68oWn+OUG12GNSGJXWH5kc3pS2XOrjzStV7J/MOKGpk55vkfPo2weE3cbzFvv1iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 15:29:20 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 15:29:19 +0000
Message-ID: <da52e706-ea62-8362-f658-7d34e0ed0e31@amd.com>
Date: Wed, 2 Feb 2022 09:29:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: skipping SDMA IP suspend for S0ix.
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Rajib Mahapatra <rajib.mahapatra@amd.com>
References: <20220202090644.1031115-1-rajib.mahapatra@amd.com>
 <CADnq5_OhwAXQgNFAmavobSbYEyv6CJ2XeKQ6etot=VqHuGnCjQ@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OhwAXQgNFAmavobSbYEyv6CJ2XeKQ6etot=VqHuGnCjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0442.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::27) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc227d6-88db-48a9-ee6b-08d9e660c7d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4862FC537A37A6A66E39F933E2279@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcUqByFn3eh74n5bLb/h7TflMTPJqmGA1Y3726fFuM53AolQg4qnss0VE6ZE8Co3VcIX8VHGqrsrtNcbF43kx6dIUGfoKNqO0pf6W6jmDtveISof8mhm1jRbCLHvX1/i+6FLw+G2OkWn8R/Ovxayxcnwy2N/f+SsEPrT+yChbLJzUdo2VQq8KSPbznlnFit2I0p5UZe0JoFOnMIX1PxVjAMsxpcl1KlJ9lfqmgyLRG4FmZJBSAHOMReQH1k/YjcozPgnCmytfwARuEwlP/JPHQP7jXmK7hptSV3yJ5+aanbIwjf30lS/tJOLiDEv/GBOQCegxYdYzoaOfVFZYjB/JUP86Ri3rtO4pDigEqs5a2wKXXbCMN9O2h3eeZjc9eSFx+F2spD7hLa9gGdUOOO9pwNvy1RU0VQgiKgCCDoFnqrTE8KINDRaLE8QoSoswWBSvSeS3iR1P4O/uCDHo9SbZdjbdxeNATl0zjbrRdMmpms+LZxZjWq+FelVdamaPAP1j1lKnm9WoaMmMdtrk9Co3MFLMAtARgSFLmVTiPGJsilzvXNRlQNTdk9HODBNMlJ6BMHPFlwL1PO0WeZCzyzMlXE+kIfVVLNyfmzo3+i4CUcQWu2p3l4IkXs40ntMoAs714gt6GBsdMW/f29LzQwDS6RAXGLaWKOAWbiye5ToJihwMUSmTLJrr+y103Es2MEndwdFsK42wQ2jsZzML97FsaXbrovuGGCTSQeE9VfRGKJZbNGoRqbxLA/oBKA+1iikdngjoPwcvRO9HP3K42OGZ8kOO0KNSNIxaKVVDAy1EHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(508600001)(4326008)(8676002)(316002)(6666004)(53546011)(6486002)(6506007)(54906003)(6636002)(31686004)(110136005)(36756003)(66476007)(8936002)(66556008)(66946007)(86362001)(15650500001)(2906002)(31696002)(38100700002)(2616005)(26005)(186003)(83380400001)(5660300002)(21314003)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWNXdVF5a1hWNysvTVgveDlTbmpmalJSYUJYQkxHa09uNlBwUFo3ZFZSV1lF?=
 =?utf-8?B?ZGEybUdwdlYrUkxEZlJGZlNRenRFeG8zbmpFWnFkbWJzZVpibXFKS1NOeitS?=
 =?utf-8?B?NllJcmY0ZU5MNGlWYi95bks3Q3g0eVlFRGFmbnlpaEVrbTdIZkFDL3ZRN1N4?=
 =?utf-8?B?Z3QzYk5DMlZDWDBwRmVLQ2FrUk5tMHlOL3dVVmkrVGl5WFVzNlpCa29PdzlX?=
 =?utf-8?B?Rk9OenNXR0tLMVIwZU02dkVnZVMvRTRSWGZiRlV0RVorYzFzZEVUNWZKM1BP?=
 =?utf-8?B?V1p2N3FZK1lqOEpkVDd6b2MxeGptc2ZuRWxRZUk3UEppZ3JqSUlpUWc5cFJO?=
 =?utf-8?B?YnFQZEhONzBMM1FwZG1ZcEhaeWZyZlJPcXpwY1ZEa0MwMmE3QTNIUk1EL0w2?=
 =?utf-8?B?b2hXbGVLa0hkeFVQMXhCK1hyOVlyNGtjMEF1WUJ5TDQ2ZTFCWkxoUGFrMjk1?=
 =?utf-8?B?a1hTQ2xhRk5JVFZaNWhCUGoyUW5MWktVYXR2Q2dCK1R0TEhXVFlJZUd3dVFF?=
 =?utf-8?B?ZXFOZ1VOUURZMm05RHUvWHpwRnNIY3diRVArRmp3d0ZpZWxhUVUvQTlSWGxn?=
 =?utf-8?B?MTRJRFZaaVkvd3JDaW1PU1E1SktpNSs0bjkzakRsczk4bmRMRlB6SkN4WFBC?=
 =?utf-8?B?TkF1M2xwazIrRzAwclVtOWtxN0ZRd0xJbFVNc0FHeDRkSFhJUG8yb3M2Y3N4?=
 =?utf-8?B?eUFiVGpKZUw3RTM3T1doUklJdmFCd1gzZ1FwL3ZoVTBFZWU5bVZ4MlhrZmE4?=
 =?utf-8?B?VEhraVVEcXpBcy9ZWHlJbk9DYlN6RmRFK0JJY2FNcTNpZzZCZE90SnNTYmcx?=
 =?utf-8?B?WjVqSGcrTFV2RDd3aTE2R1dHcEdHcnF4dnVQUTRhR2tJdi9GTGhJZ3RFOEFM?=
 =?utf-8?B?S0s4NEs3YWVZNWwxOXErU3YySjBTV2ZzQW9jcXZQdnZnTXNScmR1WE8zajFj?=
 =?utf-8?B?WElSbHFTdU13ZHZhMXk2MzRNN2dNVlJtRmxZY3E1TDk4OUs3bHo5RXY3OUNH?=
 =?utf-8?B?a0thRE84aXhwQjJlSEhHUDZsaGZObXBpWGRpeTVqb25NTEh5cFBNZjZzNjZH?=
 =?utf-8?B?NDdNSEdZT2FReWV1Y0lqdWZFOThkaXlyNFFjUkpuZmM0WHN3bzZkTlY2eml6?=
 =?utf-8?B?OGtBVXNCZVVqWmVTSkVsa0tCb0xaME5VMnlDL1hMNkxuOTdONmFqZDIyMTJl?=
 =?utf-8?B?T0FZQkFJS0I4dTQzQXdtU3VlbVZPRU5rdm1RT0pXY3ZqNkwvamJjT1F5cjVh?=
 =?utf-8?B?N2YvT3FDN2JnSnIxZnVGc1h2SjVKMkJzK2pwaE5iWnZCU0Q2WXRVRHZIZWFy?=
 =?utf-8?B?ZS9BSVNNWnF2UDFwYk1ubTc2bnF4dWtITGl0SVA2NFNLclg1MGpvZGpkVDdr?=
 =?utf-8?B?LzVYbEpxaytjLzIwNnZpMHFpVVlxZ1pWckZTWHh1eHZZVE1lR243Mi82a0pQ?=
 =?utf-8?B?eXZ4d3YvUUpIUUt6NHV0aTJrcVowTy9WTW5pMTdjT2ZoanFDSkY1L2JCaThU?=
 =?utf-8?B?RFJCQW9QL3o4T0JoQWtOTStvUWdMTTU4K2xKTlBna1RJSW40YmNrWmI2NVdq?=
 =?utf-8?B?Y2hUMEVwc3hwMm94UGp1Z0hiNlR5dmxpdUtXbnJYQXJrcldhNFdXK1dMMTBa?=
 =?utf-8?B?Z3ZXRkR5Rmhvb21xczNJN3ZCaSs2K1BDMTFLRDY3Q0UzdlFQcmJScjFocENR?=
 =?utf-8?B?ZDhlTi9wT1B6emxNNXFwdlFtOS80VWprd1U2dG1HRTRxR1ZoWTh1NVRGTFhl?=
 =?utf-8?B?YkowNzRzeWxmV2VEQkZaNzdwcmlSRGQwNzVmMjRVR0lETzlLRXZYVlU0aDZj?=
 =?utf-8?B?dkw3anFLTUhPSE5Yd2VUZXRON2p4bWF2VGk5RDJibXYzOGdBSXBvRFMvY3lS?=
 =?utf-8?B?elVvV3F3Z3NEd0FGeVJidVp2N05xdzZqSFF5cCtIUVVleWpPZ0pja21hY0pn?=
 =?utf-8?B?VFJjMEpjWnFzVEJ6TlY3VmJYbTY1Q3pQeVQwNCtQWjJhM0RCS1ByYjJ3NlFH?=
 =?utf-8?B?Mzcxd3pBVzg5c3lMcHZCeWpHelp1OFFGV0w2bVo0UlR3NjZ1ODBYMkpzWE1K?=
 =?utf-8?B?OEt5N2JKYys1Z084b0hoTDBMQlRUeWNxMEM4UnRRbDhFaG1sTk10SnBCbnc0?=
 =?utf-8?B?dCtsWTR6aEJ1b2VEalp6b3VLdCt2eFZUWVFPSGRnY2Q0c3RkREFCVWNKWmpp?=
 =?utf-8?Q?jQ0xi2NQN1pHnwvDK8gm6Yw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc227d6-88db-48a9-ee6b-08d9e660c7d6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:29:19.5667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BXYCl1WtvmfKZgZqLKKd86nmB1EdAp9r/n39CpjKUtCk0w6Rt7uiTbyhjLM80PbYgcNg6ZBGk1WKqcmZ34nfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "S, Shirish" <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/2/2022 08:16, Alex Deucher wrote:
> On Wed, Feb 2, 2022 at 4:07 AM Rajib Mahapatra <rajib.mahapatra@amd.com> wrote:
>>
>> [Why]
>> amdgpu error observed if suspend is aborted during S0i3
>> resume.
>>
>> [How]
>> If suspend is aborted for some reason during S0i3 resume
>> cycle, it follows amdgpu errors in resume.
>> Skipping SDMA ip in suspend solves the issue on RENOIR
>> (green sardine apu) chip. This time, the system is
>> able to resume gracefully even the suspend is aborted.
>>
>> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 7931132ce6e3..f01b1dffff7f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2927,6 +2927,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>                       adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
>>                          continue;
>>
>> +               /* skip suspend of sdma for S0ix
>> +                * Resume has issues if the suspend is aborted during S0i3 cycle.
>> +                * Skipping sdma for RN/CZN/BRC chip - green sardine apu.
>> +                */
>> +               if (adev->in_s0ix &&
>> +                   (adev->asic_type == CHIP_RENOIR &&
>> +                    (adev->pdev->device == 0x15e7 || adev->pdev->device == 0x1638) &&
> 
> The check here seems to contradict the comment above.  Is this all
> Renoir based APUs or just green sardine?  If it's just green sardine,
> you can check the APU flags rather than the PCI ids.  E.g.,
> (adev->apu_flags & AMD_APU_IS_GREEN_SARDINE)
> Also move this to sdma 4 code as Mario suggested.

Both RN and green sardine share the same flows for SMU, I would think it 
should just be match (adev->in_s0xi && (adev->flags & AMD_IS_APU)) when 
it's moved to skip suspend.

> 
> Alex
> 
>> +                    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
>> +                       continue;
>> +
>>                  /* XXX handle errors */
>>                  r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>                  /* XXX handle errors */
>> --
>> 2.25.1
>>

