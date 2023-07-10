Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E6DEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 22:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FA210E2EA;
	Mon, 10 Jul 2023 22:28:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1080510E18A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 22:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJeHxKQvYDfZRboIDd6zBUE8xx9bJQNkN6AcxFbbPE01+ntgjO8RIp3DjvmO3PFIIWN0dVKkk7m3I6lsMkytEW6eDdXw+x3KF2qhkRRnOEUanr4FsmsenM84rn+/7+g9pa36/cg6VZIOklksVUwx+D/QMBtH9189dxRsov8FFoND9t0Mb7fLVcpmWDl4r2G9gCbG28pynRY8zq2jUI+HgzigdYijNavGrzZJHa8gDN/25ZjY59HpFXLBER1YlpjzwpUkmJWtxUQ6kCyg8npyaU4UBNdzyp2Muph1soKz+1Q9CqKcvE/1BtmwJ/p7UVKwv4S82aT6tdGDPITMJlJQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLsSJ6RkLNiLW+EEJSJvGi4hzvmqZ/ZqTTlfQK9wX10=;
 b=U4X4YgGhkc7FBx63kGFrkzBDVOvBZeL9tOgbcUezQG/8orjnS0Fk+TFyECx0AVVCtCNm68ynPW5tPKrxC1Z2zDXVIbsaVFAIew8HxPftGQFi8NhBJ2ucDwtoSYn1IS/h+BnF+Q+NMfdBue5h3SZJrd7m4jcHaoCNIWInwcVWhNz7USAvfkxjpSAG+UYkYPE9PPgtO8oWI/AXTJkpLmkB/4cMn8H3ah1kHtFGoOcJ68aFdvQfqR4KYViuj1RjojVwYBBMDzggweufTdkNvO7WcC3eiC1xv1f2cCjmtW4h+hPK6q4Y6KjtFkyB0eamGM4z4AdX3580gSGIOb9Op4n57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLsSJ6RkLNiLW+EEJSJvGi4hzvmqZ/ZqTTlfQK9wX10=;
 b=PfG7ZsisrnmDMJpN8iNxpozPDXPtitSfqYjyPtRG+werhyY++HjdE+GNYeoVRmzalHPp0e3IGOO6MYozG4+N1cKTWzgiOWGVLoLgUP6QnGeKL3RI+9dcJm8Nz5XyaGsMR6sUtMlyaw2tZ9uPvjfgTGn7P4n2O596h0Co7KI3TV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:28:02 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::b6df:8b5f:9e94:f4c3]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::b6df:8b5f:9e94:f4c3%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:28:02 +0000
Message-ID: <2f6bc7c8-ff88-53d1-cf33-dcfa530e2cab@amd.com>
Date: Mon, 10 Jul 2023 18:27:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: enable grace period for xcp instance
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230710194530.214865-1-jinhuieric.huang@amd.com>
 <BL3PR12MB64252080596A0A4C3E3B6960EE30A@BL3PR12MB6425.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <BL3PR12MB64252080596A0A4C3E3B6960EE30A@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:70::14) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cf6835-2fb9-4d77-3ced-08db8194ec18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TS7riq6jVqrDHxa7QWrTNzQ9G+XMEG1pDLAL3Gi8WhM3ZrsJ/z4HvRFDeaFkXzBqd5C+/Rd+ttFx+V4M+kwTJo20FsbCB9SmYi99brlSATM/UWSQHQOEN3WUFRGaLI/MPleQTE3u+7T++BA2N+gUxL5u034Tw4rjSBrzweNchmpKq6Z3s89eg8tBzwtAWkhqXv8qDMIdi0zvd1JS424L4XPbTwDCmGezLJhj7sWu0Wc+2u1XjlITJiv4w2cRlJ4l0EYHiIKVYKEjhnishBQeyaHVVWt1gAP4elZzIdIHerrVlswPnr69rs5jRdEWpX36BNM8AsCvLobezayBAlBlmhDc2hOsGDjUQnkfe42iVIxmBR8JsnszavtN006ye2bac4RqoHfPTK/OpEdIOyIT3RsRSFC9bpU7ypY3CvmzWt0/UIfzuYKIuXF1VgBlzNgec7F/oikQ7Tk8abqK/xTnjyzCCXoLMINeDM56OXbTwUViB6GunkMfcke9HuEpnlbMLd3Di44hQr++Edtmp5eeUyz0Xt/zX+8fC7VdO+Jm5KIgeLVUQzNRi6hU3m13SztnRkBzT4luoGmSDFkdm6IdV4dd74bnOv7HpWaEAuV+atKYctP3nl5MFJ8eLeDVp+2KaB4ljn+lK81DgM2rzW8aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(110136005)(478600001)(26005)(6506007)(186003)(6512007)(2616005)(53546011)(5660300002)(66556008)(316002)(2906002)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdkbVpocEN4ZTZXaFdXWEpnZG5DY3pDb1didDREZzhhbVVRMElTMmJyaUI2?=
 =?utf-8?B?K3lFUHhHekZpYktWSUs4V1lBNnhQUXNQUkNpN1Y1QTM2cWpuTFdJWDVFRnNM?=
 =?utf-8?B?cEhZV3luSWVkend0WnJYVzQ2VCtJS0dGejMwaTZ0YUxXcWhNaVlSRWtQeTZU?=
 =?utf-8?B?RkRodU55U1dBVDByU241TmhTeUVMbzlac09kS0cyRjlYWmRYeVZFOVlHYlpM?=
 =?utf-8?B?dXlmdC9UWUNhczllQ1FsbklNNy9pWitoSTJRSEJlVTJJY3BSdTFOdFhHbk5K?=
 =?utf-8?B?S1JJZ0h0QVo1V1UxaHArcm1qVy91REkraFUwVVY0bHUydjRuOFpZamh5aEtS?=
 =?utf-8?B?N1lvODIrSWtmWDZmZllFVFBCTlVUamZmYWdQYkc0WjJQWkhKVnBoL0pNYTZB?=
 =?utf-8?B?K1lvZmpVZk9QcUxYdHNITEdXdGh4Y0JlTWlLM3Z1ZE9RQTE4U0xhYmE3Mzlk?=
 =?utf-8?B?S3cwVXdHek5xKzcxenVZUUxvT0hCMndoRWhwWFdSL29WTmF5amREN1QvbEhy?=
 =?utf-8?B?bHh1MzYvdlhjVG9LRGZtOHcrUGtFL2wrU3IxT2l6bHFKc3NxSVEvVE1maHpJ?=
 =?utf-8?B?SmhjNWd2TXBpTy9CRGF4NTMyM3BqRkxQWlVoTkNsZ29TdmY1N1BRWFBvY1ZD?=
 =?utf-8?B?WlV5MXdHLzZwcCtNcDQ2OEF0bUhHS0x6L2JuT05vWXRyQTFidkt0MUhQN3hu?=
 =?utf-8?B?T0R6anhUbWYzVWxhVzFJMjZtdFpOeGV3dlRKQnpLMUJucklEbXZEQjZKVWxn?=
 =?utf-8?B?R2tPNWh2azh4dHJpVk10OVlSd2ozL0VodnZyaXZJQk1RY3UvRThHdTRZRHdN?=
 =?utf-8?B?VW1GdnNybWxCWUUrbnl4b00wWjkvNFVBU2wyUlVocHNpWGxDdzBySkZxTUgr?=
 =?utf-8?B?emNHaGRDd1VGSHQwWS9BcHBZelU5UzVZNE9uM0pqeTNaN0IwcG1hK2pHVCtt?=
 =?utf-8?B?ZWxxdStFT0Y3YjJJSUtrbzQ3MlY1cHByL25JT1BTR1MycTV0ckp0bnRjZTBa?=
 =?utf-8?B?MklIb2taUUQ2bjBIS29zTlJtSFBDU2ZoU1VyeW5pbUhhSk55SkN1TWtxRm93?=
 =?utf-8?B?K2FCL0tNNHdDSGFKQlhzVTc3U3FEMm40S0Z3OXlFYU9Scm1pTEdwUmFRaE5j?=
 =?utf-8?B?M0FLd3VZK0NPbndhRHM5VktBMmNma0RvcWNuYWZtNWJZUDMrYlNyTk5ZT1d1?=
 =?utf-8?B?ZWxnMDM5UDErVk4rbFYwVHpLSmpiT3dZWWhnVTBNQVk2dWFYZG9XSVZCbEFp?=
 =?utf-8?B?Q0Yrd05xWnljRmJ5eTNWazJhK1o3S1hmRXVjTmNnend2NEc5WERWdlY4VU9h?=
 =?utf-8?B?MUJmQm9Ub0pUdk5mQlpwN1hyWnc2VldzSHVreGYwNW1kQlh6cHlQUC96UHJ2?=
 =?utf-8?B?NWtydUpxdWY2bXNTb1huM3VPVjg4TXNWSExpZW1BNFpKRlBlSE5SckxvMTRY?=
 =?utf-8?B?S2xNcFkwTEdjamRBQnROdDVIR1NqK2YvSzFtRUlxL1pFQnlYVm90c2FtNTFL?=
 =?utf-8?B?ZzZubkNoMkxqQUVNQVdtd1NQckF2SjJjcGZiNVhRQjVRODlUVTJKKzFtckFv?=
 =?utf-8?B?Q0dTMHFrem5tM1VGQytpV0lxR1NHV3dVa2JsU2YrZUxjRHpJVmNGSXRZdlBB?=
 =?utf-8?B?bUQxRUhPZXkrZHVKNkhIVVJOVU44N1dXa2tSdWJYZ3NtZFU1NzJaSmQxS3Zx?=
 =?utf-8?B?MzM5WkxnVll3ek03Vi83UWYzS1kreG1xSlllRzRQN0FhUktUem5DMTY2MHNr?=
 =?utf-8?B?d1lteW9NOXVTRHNtanN1bEFNSWtrd1gwUS9KQkRydkVoVVRKOHBYakc5WTZl?=
 =?utf-8?B?SmxJSDlqMXRTUEtLQjl5Q0JjcitIMDYrbXYybXhXK1V6SHRKbVlaRytGRDV2?=
 =?utf-8?B?d3NmbFozWDZVNiszKzhrMnh2OXdoaS9Fc3VFMnZ0NFZrYVJXWjg0Y1VVUDFM?=
 =?utf-8?B?RWJKdUFuai9NSjFWSnFZb01oam1JMVk5T2RvNXhzbm9HNkJvSkdmK2xLY1FM?=
 =?utf-8?B?VWtvVEplbXpoa0dQdGhUMHNkN25qNlV2QzVSeVkzVFkvYk1vaUZoNTlibllX?=
 =?utf-8?B?QVlwRW1nL1BPTWFNTHViV01PTnBpNStFenZwN0FnTkZlYWU2TE5MMjNoYVVX?=
 =?utf-8?Q?gIzVPypiJVVY0XH5MygOCBxns?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cf6835-2fb9-4d77-3ced-08db8194ec18
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 22:28:02.1008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/OAUw97V3L1dKcc1Jl4R4br/zB1cS56vnPjaWmZxrq2dYalwrxWKXkvm0e+x7EM02W3AZTC7ivXdXTrHFKgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK. Mukul, I will resend this patch based on top of yours.

Regards,
Eric

On 2023-07-10 18:24, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric
>> Huang
>> Sent: Monday, July 10, 2023 3:46 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>
>> Subject: [PATCH] drm/amdkfd: enable grace period for xcp instance
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> Read/write grace period from/to first xcc instance of xcp in kfd node.
>>
> Hi Eric,
>
> My patch, "drm/amdkfd: Update CWSR grace period for GFX9.4.3", which got missed during the merge
> should handle most of what you are trying to do.
> I will push that patch. Please add on top if there is anything missing.
>
> Hope that works for you.
>
> Thanks,
> Mukul
>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11
>> ++++++++---  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |
>> 2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++---
>>   3 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index de83eccdd9de..a95bcb91dc09 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1619,10 +1619,15 @@ static int initialize_cpsch(struct
>> device_queue_manager *dqm)
>>
>>          init_sdma_bitmaps(dqm);
>>
>> -       if (dqm->dev->kfd2kgd->get_iq_wait_times)
>> +       if (dqm->dev->kfd2kgd->get_iq_wait_times) {
>> +               u32 inst = ffs(dqm->dev->xcc_mask &
>> +                              (1UL <<
>> +                              dqm->dev->xcp->id *
>> +                              dqm->dev->adev->gfx.num_xcc_per_xcp)) -
>> + 1;
>>                  dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
>> -                                       &dqm->wait_times,
>> -                                       0);
>> +                                       &dqm->wait_times[inst],
>> +                                       inst);
>> +       }
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> index 7dd4b177219d..45959c33b944 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>> @@ -262,7 +262,7 @@ struct device_queue_manager {
>>          /* used for GFX 9.4.3 only */
>>          uint32_t                current_logical_xcc_start;
>>
>> -       uint32_t                wait_times;
>> +       uint32_t                wait_times[MAX_XCP];
>>
>>          wait_queue_head_t       destroy_wait;
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 8fda16e6fee6..dd50164c16cd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -292,17 +292,21 @@ static int pm_set_grace_period_v9(struct
>> packet_manager *pm,
>>          struct pm4_mec_write_data_mmio *packet;
>>          uint32_t reg_offset = 0;
>>          uint32_t reg_data = 0;
>> +       uint32_t inst = ffs(pm->dqm->dev->xcc_mask &
>> +                           (1UL <<
>> +                           pm->dqm->dev->xcp->id *
>> +                           pm->dqm->dev->adev->gfx.num_xcc_per_xcp)) -
>> + 1;
>>
>>          pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>>                          pm->dqm->dev->adev,
>> -                       pm->dqm->wait_times,
>> +                       pm->dqm->wait_times[inst],
>>                          grace_period,
>>                          &reg_offset,
>>                          &reg_data,
>> -                       0);
>> +                       inst);
>>
>>          if (grace_period == USE_DEFAULT_GRACE_PERIOD)
>> -               reg_data = pm->dqm->wait_times;
>> +               reg_data = pm->dqm->wait_times[inst];
>>
>>          packet = (struct pm4_mec_write_data_mmio *)buffer;
>>          memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
>> --
>> 2.34.1

