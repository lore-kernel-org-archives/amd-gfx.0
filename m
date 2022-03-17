Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B98BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 20:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E5610E799;
	Thu, 17 Mar 2022 20:30:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88AEC10E799
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 20:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/85/0eAQVmN+RDFrK4yk7fX763DHfG/ED69R82+w4QmXPWsedymKSKF3HYC7/gERrAxslGcqslJV3jSX0fo28KK3cXnAT5XsNQwG3+4QPefyVF4WCiwTN6jSsV5mTFq98vPiquLI09DmNc310f3VdDJ6zPkc7sXPsnVKy7SGi/SFrWFesJ6/sUZ1dlFHkwElT903A+ofCGTaA6ZdiaAX4DAha3PfAaEQwxnRFhs3zNhnHE9sFhKbq0QPQiezeEnUhcKSq8iby3ncreVD4rQhTy66bk9V4z80dMExY4AOoVZZ/kAQCy1USIXrtsoMgsbhvbHJlbf0gEThWXeurczug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ7kvJ4khV9e2rrLCEXn42wWYEfLBVbYvqziv9kXKnM=;
 b=dZfkuMo3XzTHF0/pVQvUPg83qO7w9MFQGDAn7KVIVyymoRRFmQnwVJuckU2CQN/M0mDKFnHZJ8XmOoMjJLUbEMtb+Ympfe07/vrzW8ouoXiqc52pfG5r6JLS2Fmso/JGRb4pyPAtGbctSVwqV6ZaQkczUUNV+hYHJ5xWeRq+8ksU+xUuvFIPWTB3vAbtcr0IDdnwYgDS58Mku/Fe8K00stWZGPUXLBk6GrQIeluDmKifd7MByyj2V/JYdAKkiQuPhFFhsng3R9ACZohQ6XgJ8Z9MN6GQEbXq/daAfhtHY2Pjpsc8F4k6JUJbdZvNh1BvOVR4PeSm5lwBg1gotTCpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ7kvJ4khV9e2rrLCEXn42wWYEfLBVbYvqziv9kXKnM=;
 b=JXCwTGMrFTpqn8B+Xpc9VBqShlmeW0VrtI6qfDZ9beNLOMJFBaS0OPOhsiEgPxhnWHBPnFwf4XaJwDLOnfyfa3mha9Tl9xFLHPdUBW40gg8FBig9QadhiSCH2VHTkzMJ/7E8cbolwBT8krsXXIKwRfDHUK53UsaDAKs6PWUrUS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 20:30:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 20:30:54 +0000
Message-ID: <a72953b6-995c-30b0-91bf-3b25206db5a9@amd.com>
Date: Thu, 17 Mar 2022 16:30:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Removed dev_error message for incorrect VMIDs
Content-Language: en-US
To: Tushar Patel <tushar.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220317202415.129865-1-tushar.patel@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220317202415.129865-1-tushar.patel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83acbf00-67ad-4d39-1036-08da0855089e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41248BC713D9480F8964D22292129@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5LEcp7pR1QHnXhNpNXOWXQ9vz6ouDUFguD4MOsHy/amvhJcl0EwP3UCFhZzTn+Fwu/CbNlCL8oHkZg0IjASkuKJxwDcwMmA/7v4RocHXTS611812lHg4HAMZwkcCqK73YKFh6XUJaSvYbOLH5Oniw7jQJSkBkQd2MTw1b0Y5LcLXj/WIu6deHrZ4VnuARcEEnagTFYfgh0nqMh7oc10JS1+EEKgRKhDJVZ8MuzVQNkumVSGjOasx4id42iZOpqBK+yAu0LSO7L9+xS1srcndRy9OoFssFJS2ljj/otq1xLa0Zy+onkaGDqycB7ep5rGzsNsKf3UzAjAK0UZIdElmE0M/b07rgnbpkVRDot6pIEYdrVe5ztOizLDO8pEiqSzMoFQUqrK8O6rS2nQ+uJ8+oMdzHpMlH9ku28L1jK0vle+TT6TmZcWjPNmXBKmZanpGVB3nRRtAMVTy2wt5Po/DZ2D21MTPNzfFf6gYQUTt190km4HBOTWRwJxnfO8Yuq9rKOxevrm4Bii1D67t8FS2aQE7vRp3Zb0+w/5xTZDDpYSmeH97Wfj++WjMQ6WcV7Wy6eahme7fZ3o5huOGZSNdgKyrM/34voAqyGy8RGINhzbp76yenDCRvRZE+OPFFrcEepZlp75kWTXW6HT6qqKe6fd4pb1JvntsQRaT8h7cLxpGyPk+ilD5y+b+e+2JHFOCZebXV+abgY4B6/vcXIHJhwGDtRwZ6AWWrD7YhtjYoo+hl8ncA/P/Pk1lcXE9/9U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(66946007)(8676002)(66476007)(66556008)(83380400001)(15650500001)(8936002)(2906002)(5660300002)(38100700002)(86362001)(316002)(31696002)(31686004)(6512007)(36756003)(6506007)(6486002)(26005)(508600001)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdPenpBUkVVaFdBQTVOdWYzVGVjTWV6N21qMUQ3cnF5ekxyOUVFMmJHTmNR?=
 =?utf-8?B?cmhEemlZWGdNN2VSZW9LYjhKNDlkUDM2L1g5RksrMFdkNzg0N0tQeXYxQTV3?=
 =?utf-8?B?LzdiS0RQSThFV1orMWpkRzc2VWpjZHh1MVNjc1h1YTVtMURWYVBsQWV5VVJt?=
 =?utf-8?B?NnRFTmQ1Z3p0d3JSSC9ONE92T3cvdklYMnRPMVc5VVVJbW5XQkdmZVRDZmNC?=
 =?utf-8?B?VmpnQ0FyZ0hNaGxwd09qaEM4YkRscS9DVUdsOUI2Y3FLWUFPNWVRY0cxbkpL?=
 =?utf-8?B?ZEh5SGYyeHJWWjY2ZUFGUUlHcFdWWTRpRGpRK0pPRzBxUENwcmdFUU14MzhD?=
 =?utf-8?B?RVMwa3ptd1pRZkltMkxHRXQ4azNJRUFTNEFHQ3d6cDRNSGI3MHBPVEo0YmVO?=
 =?utf-8?B?aTZsMm5jVmtaeXRjM1NwUVFpUEFqTEpsdmJwZ1k0V3FRM2ZHaDI1bk9ibkZj?=
 =?utf-8?B?ZFgzWmVUR2JCSFE3TmdYVjFpZkRvYVhzS1dPZ2ZGUy9BTHE4WFJ4OHFqV2VS?=
 =?utf-8?B?bHVpbmRlOTJxbEd5dG1Ec1lXcVEwZEVlRXdFbnlUaXB5b2Z3WkdOOS9ZLzNW?=
 =?utf-8?B?dlUxR2EzbTFISmpYR3NIRHloWDZUR2tVL0UwM0pnQ3NiRzUyMlpwMGFXbktD?=
 =?utf-8?B?SWRSS3NlYmhMU3BRL0FQQlFrWTVERmgyTGNReXVBUFc5YmRmN0dKUldCdCs5?=
 =?utf-8?B?SGUvaDRWQnRxeDFEMEg4QkxRWXI2a3VFb2JYd1oyN1R4eHNIZXE3ZmU1aHFl?=
 =?utf-8?B?VGU1cld5UERuUUtrVUN3WjhYcGdaZ29YR1VtZVd4NVlXNkhaRTRkWVpwdEdG?=
 =?utf-8?B?dG45RS85dFVNbHp5TzZBRWx6ekZXOUFKSnRGUkxjcTBBcERSSU80aytJcXJi?=
 =?utf-8?B?N1F5eWhZZVR0NTBNSmNySE9EcnVwZ1ZqU0VWVFFqQVZBUG1FVVVDNUZHd1Vh?=
 =?utf-8?B?NGRCSTZXWVJadFduZkZvNG01SW5MQ2hVMlZ5L29jcFlXdituNVJVN0FZcWNZ?=
 =?utf-8?B?czI3S1FsNWovenViWkx4dFBwTnNCZzlyTEdpQk5TWmFDRDVKZE1KTzMzUGkx?=
 =?utf-8?B?aEI4M205TkNON1JzVWlPMlNvR1g3NWhFTldsd2U5OFBMNzFQd2xwQ1pXUkEv?=
 =?utf-8?B?akE0SmUzQUo3RVNHUTdkVHRCTHRKU2w3T0h5NENNbTAzQVBYT0dTU3dIWFh3?=
 =?utf-8?B?RW84aHRVOWt5QWVTbHIyZldhZncybFR1ektUdUpBZEJ5dU5XQlFqV29pd2Mz?=
 =?utf-8?B?WGZCcEZYNW5DcGhYUUhCcUlaaEkrdjhRTW9mT3NibVU3bDZQTjFwQVJVTXEy?=
 =?utf-8?B?RjVIUlZFNWtlUDEraS9mZi9ZZmJDM2p1eEUzZXEreVVJbS9wSEF1TTBKTHN0?=
 =?utf-8?B?S0Ntc0h6SWpQUlNRNnJSNU1JNTNvVVVCM1VtZXA0c2xvQmpTOFd6Wk94dzU1?=
 =?utf-8?B?YWVGQ3ROZ3ZibHBETi8rYkFtbkFxRWM5SWw3ZVMyWG45WkN4R0pBSkQwUWF0?=
 =?utf-8?B?dEdUZW1ZNlhZcWxIRGpHQ3E1V2RIYVIyNzV1RmFFNzQ1L0F0cUZkNTBqQStZ?=
 =?utf-8?B?elN6YkRZWndnUkxHSzdpTlpNU0U3N1RWaVpWUVh3dnJnQjFZU3JaY2JlZGdj?=
 =?utf-8?B?OG1tL0RwSm1lZnh2TTQyUHRRa0JEcXhQSzBpNTd0RytXL3VoZ25pZG5ZRXZo?=
 =?utf-8?B?cks1RXZrWTFwbmt6OFJpS0E3amV5MUh2QUJOSWxZQzJEdnlvbVZlbFVMamxp?=
 =?utf-8?B?ekZBSkk4Sno4ejgrNXhqWnJlUkYxbGNUV2JpRWIwWXNyMWhEa1JZbitNelZ3?=
 =?utf-8?B?bUEwZ1orbzdiaURjSlBibk80amQ2M2xJQ3R2THl4QWJreDB6RWdONlU1OWJQ?=
 =?utf-8?B?ZGV1a2d2L0NOWmRVR2ZWRll1akluWTQxOXRRS0dPTUtvaVFLNWxDMmZDTTdT?=
 =?utf-8?Q?O5339ZQLolk3+OWUL1mJJJxMF2Tt9om7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83acbf00-67ad-4d39-1036-08da0855089e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 20:30:53.8664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc0CgOoUxXtQ3K+sZVfSh6fyS6O5UNQAX+SgnjetVS14r3ZPpnxRyFcOy9FTwAK+NBz85nT03VuiYAiosj9C+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

Please squash this with your other patch. One more comment inline


Am 2022-03-17 um 16:24 schrieb Tushar Patel:
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 39073f72fe5f..f95904d38d24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -485,15 +485,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	/* Verify module parameters regarding mapped process number*/
>   	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
>   	if (hws_max_conc_proc != -1) {
> -		if ((hws_max_conc_proc > 0)
> -				&& (hws_max_conc_proc < kfd->vm_info.vmid_num_kfd)) {
> -			kfd->max_proc_per_quantum = hws_max_conc_proc;
> -		} else {
> -					dev_err(kfd_device,
> -				"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
> -				hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
> -				kfd->vm_info.vmid_num_kfd);
> -		}
> +		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
>   	}

You can remove the braces {}.

Regards,
   Felix


>   
>   	/* calculate max size of mqds needed for queues */
