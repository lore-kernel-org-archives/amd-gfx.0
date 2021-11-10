Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2321C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E64F610A5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E64F610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECD46EB4C;
	Wed, 10 Nov 2021 16:22:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7747E6EB48
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 16:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeWie0P9mUx59mMKAn/9UXlWLzabzInFAtmenEPDhA8ZWN211pt4Ij2/u3y9ng8wDEQcw7GXlTtM3gI2Zzu+Io3/W9BcRqYOIh6kprHoJHlc9FFDlmY6SO4j5yYb/F83BINT+E+IdD6BjCZnrD4lXftLwpDBpwTKNmzb8A2lcSjii3ur+0IRdjPcM6jZWoErF9gD331gSb7O0L7UPQfDinhxJGRyfOBVxW5FJ4kdPn7dscVJBTLizMkhk89MmGRbNAS0f5S1P1gZOqkmvcnANuJZ/oZWFh2yOXIngLRk5sZIIc/X8OZq7/tCfHsypT7Hp8UlzMYuUdPg6JI9bKIm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZkHoFNDu/4wH8PZwszect2PMLspAOSG3V3Hu6sF0kM=;
 b=Bso46aRME21AMPAKcqhuk6M4oQe1tfXb8TOCJpI3Pkte5p6V636soap/z2ly5u1O5JRNgZtJVRxDGgctIZ4tpUqn2kPqdXPGKBFVs0DNUzN7KsMJQ8NbM04cpPe0zVy8RSfiBw+Rlwc16DgVfW4/9l8NdYtWZf+7Ss7T/oeiUylxnyj2mF7D5Ze8rI4mBxRJpJ4kS/iFDU16bZZYkrQ3jPikaVAtsQCB3UxhwmJQcC4NRaqu6opGUX7TJk5dsim2nMqXHbAz/NZTDnzN9zCvRiLjoGfkS2qqs+caHRcwUnAGozchd5iHuWrQEkO7G5uSeDL87eHEeqwg68cfWcU4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZkHoFNDu/4wH8PZwszect2PMLspAOSG3V3Hu6sF0kM=;
 b=XlINf1fYpxR/MUewFmXyvVm0MK0joJGaiZL9nPddSJIF6SFjlc1k2qwTVFnqKuLwWtA80u+ELPPC3BNRhIJf7pOxjDVoADIs4fDcn7kgKMjrOJ4MYzHxXBfWjWxAp47j5XKz4H35roDCzi5YDxhe2UpvxOYBsbNnUDi5bxWR1i8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 16:22:26 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:22:26 +0000
Subject: Re: [PATCH v2 1/3] drm/amdkfd: convert KFD_IS_SOC to IP version
 checking
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109224251.3484398-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8b80910d-b3ac-42b9-45bb-b6343d7d7fbd@amd.com>
Date: Wed, 10 Nov 2021 11:22:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109224251.3484398-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 16:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5259d98b-f041-41d9-d8ca-08d9a466488b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53011D9EB7F7DAEC34B710BC92939@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsBDrxxUWQl9iv4+CB84or7y9LWs4hKpz0GjssXb0K6jE8DJrdLbs2iUTfgNkLRtByhhWKJkwzlTT3JCyFToOBFDyl7eTyxJr6R5nFJM0xSU7rvjtYi5U76ohXR+CojAJ7asXasL1V2Uu0SQ0fc1ws0rrDfN/wcnwxWVTgCAARPXmO+xhba5ngNSvWlL7cbfnbDl2CF5h/j3UEG+64BU7/L52Myrzd9oEU7YKdayXN067071Wg0k7MgnTZpWgmhtxQMrHSrIGQK5+iaphIzlSXOaYoP1qduOql9d0+cGqzBeMRixECOUkPh2J6GxqcpAcLLDV/Ub+SfNl1DJD0/iz5ACKwvm3dJ6vVSaJ7X8zFGNlqzA79X22LeUNuaMsjREtsRKeXoynbTMCbCglYmKTVABhVHG6bbWwjDP8n6gWNKRtxeoznNJucPRTvRD00HR1JFwzi2R/gyctuOYC89EsmynBL9E37/bGKQhBTRNYPSJ1BrKaedbQrLJDEjYVLqgZ0hB5OYC+k1fMh8UIKJfJInyvAfSvKLcylStrtnughAGb4bPVSJvzWQxsYlTTauQUeewvNdkItsNdkuVC9YhUqKwZbyvtkzyhBOa592cJPed640LOYXa9HIIAkWDSu061g8HFEA95YXgR8uGbp12H0BV1gpfoTHLancNc+aBv9rD3x/ZF5MfjBLn/3mFXHlFx/nC4LW+bCOhqF1IJ7Q60ew1i8WzV6HgGxx1CbHa0r0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(26005)(316002)(8676002)(66946007)(6486002)(186003)(31696002)(16576012)(5660300002)(508600001)(2906002)(66556008)(66476007)(4326008)(2616005)(44832011)(38100700002)(956004)(31686004)(36756003)(83380400001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNJOFRGMGp4UVl6UUh5bjNBNGNzcXJEc2NsSlVXUStsZ1JWTjMvVUlFZncy?=
 =?utf-8?B?elRoUjhjdlJBengvWlp2eFJJZEd1NVVVMkg0d0ZrQUlpaFFHaUNtZHBGT0ZK?=
 =?utf-8?B?c2x2eWhDYkp0Si9tSFM4OFRFZUlTQWZUZjZsNThOWnlVVXlvd2ZUaHpBaDRZ?=
 =?utf-8?B?QXNTOTJHS1RtdzBjZ1lzUTFKMkl6d3VLd2c4Y2tSSzdadFhmVTRLb2xKMThW?=
 =?utf-8?B?MVVwUXBIejg1dWdJT0ZvcXhLcDZza3NKVTk3U2JTbkUvTkQrOUFKbzB4RUFz?=
 =?utf-8?B?NHlCcHU0eFFSOXFBc3lOckNWVk5KZlorNGtmY2oyeGJOTDBLZ3BZajRJdE12?=
 =?utf-8?B?aGhQMS9BYmZmdzhmMndFRW80VXRpOUZ2R0M4N0pkVUl5NlJsYkdlU1d3cHY5?=
 =?utf-8?B?R3Zyc3dvb3I4Z0l1dHU5bDJWaXF5c3R2eURkSTM1OHJmUDcyTTZuSkc3aEt0?=
 =?utf-8?B?eU1waWpnMkFxRzJiQWZySlNIZCtJQjc3NEl5VFdxQ2pyQjJ4dWp4Y3NVU3RR?=
 =?utf-8?B?akFCVjhQT0plM3ZCTXBPVkFlR3R2NUhXdDc3dndPZ0dSN21YTmMzWEJNOW9a?=
 =?utf-8?B?cm56dWw3SGhQQ2xVSy9temdJN3llazhubGM5NSt4K05LZ0IzckJHSHBhNXdp?=
 =?utf-8?B?YzRaVDVndEpmZllNeFAzcUlqZmVYbmNOUlptd3l2MUZaa0ZmRWNnaXcyd0ZE?=
 =?utf-8?B?RHhwVXNrRmlwRllLUnRzWFJNSEI3cHhNMEdxcmpaMlFBZ1hmVU42bjk0MldV?=
 =?utf-8?B?bGFiemZlb0tNRFBRUHpDRDFBTFZiWHpITDcwai9VY0paeUNVMXlnU2J0bG1M?=
 =?utf-8?B?Vjc4MkxCMnBWYy9OV0YwSWxtTUZFTmluQ1VrNjJ2VVRKMUFJSUxtZmlCQU9S?=
 =?utf-8?B?Q0d3UmRVUjNDR21IZTd0b0haNjI5T0M5VFlZckVFNHdLbzZFQzMrSTA4aDFr?=
 =?utf-8?B?TWZxS2ZreFE2ckNXV0hZT1ZrejZVY2p4SW5IaEl3VHFvZTVyS1JCM21GMEYy?=
 =?utf-8?B?WXpjbXRrMG5aYkhxcmRDb2ppanJmVnFqZlEyY0lWTGMzdUNFZERQcjMwRUZN?=
 =?utf-8?B?VC90clRZSzk5UTB5eUFwTEpsYjU1YXQ1eklrSFZKc2JibCtSNmtmSmNvMG5D?=
 =?utf-8?B?MERjc0tURkkxTVZFQlBFUzBHamVzY0UwbEhSOXNYRElOVWNheEJ0a0kzZW1Y?=
 =?utf-8?B?OWFRMEhHY0FiMHJ4YUx3aG05K0RVdnREdzkwT091U3lLdjlyZWxLZWJJSi9Y?=
 =?utf-8?B?a3lFNWNVem1ZM3RWWW1JUXphVzV4Nk41MEZaNWhEWmNDbVRvV2ExRGNrNGlG?=
 =?utf-8?B?VTFtRnpkdWRadENJMncxTVlBVXlpdnhlcnRvQjA4NG11ekd4U1hGa2l5alZt?=
 =?utf-8?B?WTFBNll4Q25PWW41WG1oWHJGdEVFbVk0WlRBRUJjUDFsNVhoajNnUmVzTi8w?=
 =?utf-8?B?V1NjODNLUi9PdXVNK3RHdGtXMkJjUjR2VHIySXlJbWRHZ2N3QXJtM25TNmY1?=
 =?utf-8?B?cVVUUWx3eUcrZlhKWHdyQ3oyTE5SSmQxenN1Um5jODdIN2FtZ2crSlZPQ3RY?=
 =?utf-8?B?bXBOT1J4QS9XMGNPQjY5czlEVHZRQXc2eTdtaUxxK2VJc2Q3bEJYT2tyd0d1?=
 =?utf-8?B?dXhrZSt6RkhpM3o3ZWhCU2VITjJlN0NlYlB3M3dTcm5ya3lYeVNVakNnbzFO?=
 =?utf-8?B?emZnaWthY0JFSzVaYTJBYXR4STQ2UEs2UGg5Y05IQ05Rb1lpQWl0MW1mUy81?=
 =?utf-8?B?c0NOcGZSdVNWS1pqVEViWjVOcndiTm9zcmU4enlIdXY3QlFqMWd0NXEzTlFo?=
 =?utf-8?B?K0E3QU9FTGtpQzh0dmh1MHRSa05IWjRyR09uMDczTU9jSGE3VDNWV1BYb290?=
 =?utf-8?B?dElQTkh6Zmo3TlFBTmxFMm5iS05JZUpqY2JRU09ZK3RlZWZwTElyc0YxcWE1?=
 =?utf-8?B?Wk00a3Q3WVlvUmo5MUpJcm8zVDRpZjFtbzY3endvUUd6YlRtWTNDWUhjamZ0?=
 =?utf-8?B?YUYvd2dUaVFLdWlnNnZLV3N2czRFK2R4L2I0QkZUT1NvaWU5YmxPTTRoTXRK?=
 =?utf-8?B?cUtDSE9oTWxsMm9hYzJIdFdFbmJYR2dhYlNyUFd6YWxJV3lYUm1pTFpkRHhs?=
 =?utf-8?B?RWlhbFQ1ZURGZEZUWU40QkJCc2lIU3NzQ2ZFMDJOMFE2MHlNVFNLenBtOGpR?=
 =?utf-8?Q?xeTYn3OKvN4XmxgUd4XG+Q4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5259d98b-f041-41d9-d8ca-08d9a466488b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:22:26.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wvIMRam9oJA9zTvtfNeojCCTOOQ4tgSzCUp4Vz9DI64y0p+3v3WEYaMOJ5t29J9tztrpkCOc9kYEEHabxLGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Cc: Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-11-09 um 5:42 p.m. schrieb Graham Sider:
> Defined as GC HWIP >= IP_VERSION(9, 0, 1).
>
> Also defines KFD_GC_VERSION to return GC HWIP version.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Patches 1 and 2 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Comments on Patch 3 in a separate mail.

Regards,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2e3d74f7fbfb..2466a73b8c7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -321,7 +321,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  	/* Return gpu_id as doorbell offset for mmap usage */
>  	args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
>  	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
> -	if (KFD_IS_SOC15(dev->device_info->asic_family))
> +	if (KFD_IS_SOC15(dev))
>  		/* On SOC15 ASICs, include the doorbell offset within the
>  		 * process doorbell frame, which is 2 pages.
>  		 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0a60317509c8..4f7aec6a481b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -157,7 +157,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
>  {
>  	struct kfd_dev *dev = qpd->dqm->dev;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family)) {
> +	if (!KFD_IS_SOC15(dev)) {
>  		/* On pre-SOC15 chips we need to use the queue ID to
>  		 * preserve the user mode ABI.
>  		 */
> @@ -202,7 +202,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
>  	unsigned int old;
>  	struct kfd_dev *dev = qpd->dqm->dev;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family) ||
> +	if (!KFD_IS_SOC15(dev) ||
>  	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>  	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>  		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 78ae96fc8a6a..352709034acf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -183,7 +183,8 @@ enum cache_policy {
>  	cache_policy_noncoherent
>  };
>  
> -#define KFD_IS_SOC15(chip) ((chip) >= CHIP_VEGA10)
> +#define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
> +#define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
>  
>  struct kfd_event_interrupt_class {
>  	bool (*interrupt_isr)(struct kfd_dev *dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f29b3932e3dc..fafc7b187fad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1431,7 +1431,7 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>  	int range_start = dev->shared_resources.non_cp_doorbells_start;
>  	int range_end = dev->shared_resources.non_cp_doorbells_end;
>  
> -	if (!KFD_IS_SOC15(dev->device_info->asic_family))
> +	if (!KFD_IS_SOC15(dev))
>  		return 0;
>  
>  	qpd->doorbell_bitmap =
