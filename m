Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E6C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 20:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCC410E5FA;
	Thu, 10 Aug 2023 20:04:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9037510E5FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 20:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O42DJJNr9Cgof3xtyjkvhsWAOPftFKEXEuCxJ57/lO8k1o8qo9wZAGQb7wU6XP7Mo8E0h6+RpytzcPUp7BpR4IFnIFyrwlhA9TCDm11rwZLu7q7K0g+1vUdoNzJhAJnwxJlKMlgirj6JCG5kr2EY2P3bRe4I2xy0z9P6Su2wMpuV0B0M8HSJecRKP7oax9QsP8Zv8pCFVjkYuGGtUoK98P6SFuMSKXeLyNDAQBMIHfwgE0Fx7kigO5d0TISs9kJ2RgqUSoJItIIYshKlgqRTFiiCzPaIAX495NSzuq0oHruZ8fPHzta53PB3tIEe4FSW8bUjxw4zwrKZFvSCodNQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e774sgwOwO+HM+5OnZmtav+LGsiZwhXQ25fIjOAM+w=;
 b=fFuTOuKJeEQmH4/EoOIhdu5ugJMgvwKnCLvZ8YtaCqaurysA9cb2V95z5JEhtERQzJG/ecwILdDIhUSUAAhmLSt+eyucvFyp2JPHCvn5qdZ8aoTeMxcn5l9AIr1pwp9EZM+Q8xT50YnmB/fakF9+kPrAd660Wx0hK5T/RLW6BgoHztDhIqIClRYeXUsohrpe1C2f1s6bv/bsGkiMwychk+42fLAPVzg3rQRbehbCsdDC01uoQs4TwyUTm2rRZw39xx3zxBJdNXIHSjBnkS+VuRsETRhAHSOqvJIDs0X5HXEUUmtDel0QTJYPmrxHec/sPe1kdVmh2HdRdnPr3hIaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e774sgwOwO+HM+5OnZmtav+LGsiZwhXQ25fIjOAM+w=;
 b=2uIpMADNg9IWt8BKWzULRbH91zXUoVsZwWXCvidcyH8hALbmgR2U0EgSUYA4VJkGkjoT67Ax0jmtLBmv3G4IdC2m95HLyBSS3AV07Ro6NCi6RRIP/EZAlIqOCOePVVvbWW++v48YxVLO6pPQA3RF9agtqROSqkULKPwF/Px7msA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 20:04:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 20:04:43 +0000
Message-ID: <08f4806a-64df-da4c-aada-734919eec559@amd.com>
Date: Thu, 10 Aug 2023 16:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: fix double assign skip process context clear
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230810190317.3819769-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230810190317.3819769-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbf3c6a-0def-430e-ce18-08db99dd09bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dScSugNEntj8i2Xa6Mp1sFX7aZ1f2sT9Yb56H1LsZvF/I6fq+Gag1yPo09S68M3manvsX1ix7jrfyemXL5gs9gtFH4RQsH74Y+xIGxkr36NN5uE3hHY/2JaDCG005v/8wjXew9A4sZOyTqftfc4h4R5rf88O+EXESMb5IxX9TRbq+EqS1DnnVU6kyN1JUf3PRdHRki9o1Lozkb+JaJHZ+K+EYmXoFaLoCoJGEIngaZy/KERb7aepC92OO8RqUwOfQBCZ8fX6ycJ67VB5ihmeyKHbCKgTmuU4WlFQv+3ZshLHvfgv7z+xLjIs1SKx5N/y7yTY5NWQtcfTjBgvGy5YgPxECfwnqcg8AEY3MAFBV/kfVlydLb4u0k7/ulxyDBb3GhrpCNO9sJLL3ibbOKeWaJ32IBeZjXxk30wkfy3BA5dRTTJ+R2o4/0PTwrWbAJdvkTnHdy6yXrCJae5MPhpXhAKxvJ4wI9rGDVhN3nD6C3wTjF1pMe5sGlIn0v9ZLGO92tZfJILq+UVclJsaqAUYdvHWtqPkjbqW1bGPy63nh4r8eYusmOiyRjxWEhv5vKhD2j1stEwu4Ud24v1mEPjZM4+LjBGxJjFnfaf7j2ZB84cMsyAUOsdtepHBeQGqLZNakwFuYzs/7Yug7u1zTPwjkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(186006)(451199021)(1800799006)(36756003)(53546011)(478600001)(66946007)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(44832011)(8936002)(5660300002)(38100700002)(8676002)(31696002)(86362001)(83380400001)(2616005)(36916002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1ljTXVBeUJMd2EwQ3BVU3pTVlN2a0FXZ0hyNWZNNDI0aVlCekVoUUllUTdM?=
 =?utf-8?B?Vkk2cHoyQzE1OGxkb3FiWDNicE9sMGhLaXZnQlVDcG95bmticTJyQytYS1Ni?=
 =?utf-8?B?akFFUmVJbzdCZlJsZi90QWFFemtlN3pEZGQ1ajFpMmJDTXdpaHgzejRuUk5u?=
 =?utf-8?B?NGl2WEdDcVhFdFdTMU12d0lsZStsekJ1UFBLRXh4cmE4S3BINkJubituL1BR?=
 =?utf-8?B?bTY2OURiQ3RWT0J3cldxejdla3VUbnZud2xMUGkxenRWNHhTNWsrMzNGdGZQ?=
 =?utf-8?B?OFg5SXdybzVvWFBGK1hRWGNaSUp0QlR5QUdBYTZHbnNtZGhhNmF5bVA0dGNp?=
 =?utf-8?B?SFVNWWd0Q1lNVm1pbXdDUDNraklHMk1yMVFja3l1NUVOT1lrYjc4VU1LbTYy?=
 =?utf-8?B?RFI2UDlKSlg3MVBOMncrMXFEeXN1ZTZFSEtJNlpKZE1Ra0dBQkpmem9UQXhn?=
 =?utf-8?B?bks5ayt0V01BVWJleUVLMENjSFFGWU01UVFYZTVxZ1YwTDBqYlBWVjN1TU9T?=
 =?utf-8?B?RjV3bFJ2YWRvMW1KQ2J3WGVSN2JoNGRsWm9PdXliNytqNEx5aFZ3WnJVbUFS?=
 =?utf-8?B?aWhEUnkzYUZFQnAzRVEvQ1YxM1c0YmhxajB3ZFpBZnNvVHBlU3hwak5yQlRR?=
 =?utf-8?B?LzBiRUhQUmRpY3VrZWx4L2tuS2w1Wms3RUovb1VMVXVlVzhYU095ZnhaMHoy?=
 =?utf-8?B?aGZrNGRhN1Y1d0d1dHJIRDR1Q3VncTV6V3JVSnNia3JQMVlReTIvV3NuT1Ba?=
 =?utf-8?B?MW1CZUF6WlFHdXdTam16eVg0TXFJUG5PREY2amp6V1Q0cXNSaVNUaE84U3VC?=
 =?utf-8?B?elBuODA3dmJpYjdqOXk2bi9IbG54cTdvaVIwVjB0cmF6alRGSlFtamlDUHFY?=
 =?utf-8?B?dGZ0ZFp6eXdxU0ZZNVFSRHpIa281SkY5YjEvZldIY25WRzNzV21TVnBMcCs3?=
 =?utf-8?B?ak82MlZJb1JQdHIxcWo5Wnp2SEkzZEE3L2ZrYlhkSGlZbWdFd0pvb0lqN0RB?=
 =?utf-8?B?cTRQWVE1SlhjZENLTGZYdFVlU0p2VVFuWWsvelBTazF6MFp5cWMyTmxCNU1S?=
 =?utf-8?B?dWdyL21GZG9YejVjQnVqRmdTTDBiZ1ZncWdxSGlUZ0U0QmZNd3lLRnNzUkhk?=
 =?utf-8?B?QjNiaFJNa1R0MXU0dGxnS29hWDhDMk9zYzJZQzZlU2JsZEVBMzFydUxrMmUy?=
 =?utf-8?B?NFNzRVRnRURiRjdETzY3dEpxWlR5MkV3RkdGNEdWakJDeFlhcXB3N1Q3WHBU?=
 =?utf-8?B?VVpxdE0zbnRvSzlKdjgyNDZzeEowTnh1dGRKUURTRFhHQXVOZnhVTVlaTlg4?=
 =?utf-8?B?a0dDM2cxaWtPMjlITlBRZ1BmSzRzOHZSeStjRVlCSjVnMmI4RUpRY0lteWky?=
 =?utf-8?B?bk8xWTBnbW1ob2JLYnFKTGxUU0tBVFZabFl3MHJTMVBYWk1wZXJwNEU5Z3o1?=
 =?utf-8?B?aEMzcTMrdWV0ZktjYkozSEdSMHk0TVpnVFlhbTdXb3Nyd3BkcEFwTnBNSXJ6?=
 =?utf-8?B?dE9QRGtVUjBNbkVjYzI2WURsODhBTnphYVFFakd0US9iRURCR0xOZkFiWFp4?=
 =?utf-8?B?bThSNTFxMWpiVXNBTnY4a1UwYlBMK05OV3M2emgzV3ZpcnZuOXR0ZFo0NzQ3?=
 =?utf-8?B?VE1Yd2t1TUlTeXNhV2NHczl4a3FuZk5zTG5UUHZmbE5Pdm1BUmUxY1NKMUQ0?=
 =?utf-8?B?SDlsYmtadDNwRm1KczdZTkJEQ1lGUDBOSzJBTHZIZFZMdXZCTFJzVjdLK2ZL?=
 =?utf-8?B?TjJlRzNHd04vUUpOY0paUnkvSDRPVTlOS2ZXZ0RGTVZDY2ZPelNJMktlMGo5?=
 =?utf-8?B?M0w2VlM3dHRBVmwvVldqVG5WalVBZGJmNEVxT0I4OUs4SVNIWTBoZmZwMm1B?=
 =?utf-8?B?MldKellaSU9DTmptV0kyaHp6NVlTanYwZmQwUkg0Rk1LWk00TVRmNmJEbE90?=
 =?utf-8?B?bzA3blJ1L0Jrd0tXZkhyaVArZW1pbXJrN3o0V2JGWGtsKzZJb3VsTDBJbWFE?=
 =?utf-8?B?MkpzYzdleXhRSUlZYzdXcEtnQ1RQS0N2SUtqUmE3YzNOMTZMRlg1MTdHM01t?=
 =?utf-8?B?L2NaQm9RNUluRXJUc2UzZThmY1M0Y3RSQkxpckVYYVBpWEloa0VlbGF6SllO?=
 =?utf-8?Q?DUm2Z9YRO6ojPb3Lwp53396a7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbf3c6a-0def-430e-ce18-08db99dd09bd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 20:04:43.4544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKseeck73QgfPN1/AbKFsVUt12fYRz7FKcOlkVDC9E4IjHUxwCURSI63wFfHfYIGhDpbrpN+hSX28L/jtSZW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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
Cc: JinHuiEric.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-10 15:03, Jonathan Kim wrote:
> Remove redundant assignment when skipping process ctx clear.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index aa5091f18681..89c2bfcb36ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,7 +227,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
> -	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
>   	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
>   					     kfd_dbg_has_ttmps_always_setup(q->device);
>   
