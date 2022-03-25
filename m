Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FCBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 07:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E650B10EBD9;
	Fri, 25 Mar 2022 07:58:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D11710EBF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 07:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCLodvLEokTe+jnO8FJqMsqkHLcMyCZLY+/LeHiZlwBhAhBUaORlxO0QcGbLT1x6P0qugb7m1ubtPuAyW5I1z4I7YDUhy29MklBKM+Z5FpVZbvwy5/a+IjetotRq+8ryf6QOzmEY6UyFhK+zHTpRFFit+OPjN7HSqQ9nNfVN5+9U10CHl+mLe3e+T02hXqxAG2VFslzsCWCrE7SUrv39A78Z771y/ebTitTdOck90hBmI/CL3hkiAYrzP1dl/FnNEuIPM3uARWGFo9FeiFyWKc2rtbIbiW+K/rqggapuNJxozzjfoSSdLpKIq6QKaeiL2UWimgl7psKuNL6YIuGx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9yX+4laUjkgTZCRtuvWUauRfdPj+5sp0fY0laYc4v4=;
 b=mh7K09ezdGafqsVXg52bPKwFXzMR2YQc98qVwz6d4zmT1tGlVkZ1D4CtWgbK/LhOnemye3T3IDdl5+Wiab/QYeDheIq2+JjvYxjawuvDhm1ufdKz6izTenYMUdSrj03mR96EMwVkYsl081bbCq8AIOA1HWD/yHwpL9e2aFPNWw4uk7trOlr5xZnLxSqg//GgExMpdKSXKNFPJixGN5KT0kkPxL/Bl1llAP3KeAGg/wlfVr6ie/Yqs38ChzQ6m+bSy7AxarclcD9YV4+3GCICaPu1PGz35WN8LTRtv0nTCdKZHMNHSjdqQBzNVpZCF1nxFGT01pyGUPGYSCnnn8la9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9yX+4laUjkgTZCRtuvWUauRfdPj+5sp0fY0laYc4v4=;
 b=xmhUSgLzCejIlgkYVAto2bRb+IYk3KR05Se8w6to/iaqgMb7zee3BlUopparrD1bkQEsFluH85fd63b48hPOkh+KaTPZYrFGuxBXfSAhYpuT7i0mM72ZuSXsp490/HrzBbbjrPbIna73JSq3dHUdmNztGmlIJFdrTrtfAlukxfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:58:55 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.017; Fri, 25 Mar 2022
 07:58:55 +0000
Message-ID: <b575304b-029a-77bb-5bb0-6d8fca54051f@amd.com>
Date: Fri, 25 Mar 2022 08:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: fix comparison warning with min() macro
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220324213156.574719-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220324213156.574719-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0049.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f599a6-d4ed-45e7-394e-08da0e354f06
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311263216848FEF44A3EFA4831A9@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l4hyRqf7JWp/26gBiMfARXQk9U6H5/UE+gZWK/P4MZObYfIxVqLvePYkQtlKjiYkcJfcz/HJnDDd2WoJLbjDOBHTk4uB4J+07BZpniOv7T4CF6rQ8BzQ6ztSSOiZNgexaKY9gJRNeiDaeClQfcSrTd6OHMhSL2CMAY8BQhs2Gj0ImY2v0ZRGp+ba8gjX09QZdpA8XSVd9awAIvoN2kfpo217572lP9WVUDqlJFJSUz8oNpBRKHlXF9zx/pqRVWv0aVgP5kQBakSonsHo4Foi1ppdIpS5h4Ezve0qKE1PUCvg6pcRhwj0yXC366C4iva5WClkdoIer+8We04Uh3LCWPuCIakU3fM/YGli13mmTzFsL+JeT53gcpHKz6ZBcXJE/msj239L875WHiXNK7Errgh6F9DlArXTv1AP4L09BYFiwqXHmQRkzuPtf74WuBrpZCVbP1W34fLDytzmarGbCslfQhpDoQp0Uvkn6ccuoCQmT23U1NvjEzZ0I3KHXI7yifTyRYnPSdQUEQIglxdzpCeOO75TYmx3nCp8PFmPhbKWxThi0xh9Iy0MHKDwgbBXtMIOA5k8gWyeE300+fO0dMm+VMS0jJEenIuDUsV2STr7aGJ23GLV2dTrg9RnO6cDZS4HTU+Dp3AxtobodOckD1DoZzNCA2j+SK5ztdEuKXNdUOV2/wsXQs6Ma2GA4IoROWHfZLO32IIEAZ+JlDJOtDTfG1+dWpXKwl+v0k6cRiFxCYXL4ruy8CHLiOiEYEY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(31696002)(86362001)(508600001)(38100700002)(316002)(66556008)(66946007)(66476007)(6506007)(2616005)(6666004)(6486002)(6512007)(83380400001)(26005)(31686004)(36756003)(8936002)(186003)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmQ5Q2hObTZrcVBEamY3MHQyTHlWSVUwamwxaTk5OHpHQlR5bTJqU2RZZnNq?=
 =?utf-8?B?bFkvVnVxcFdaMG9mNm1HaGltSThxbWx2bHI1aTlqcGxKT1oxZ0F2L3dnaGIr?=
 =?utf-8?B?amJFNzdGSlR6MCtkOWtSL25kdmRyU1F0US81NWFDcEdtYmUyZ0JzSHJSNTRw?=
 =?utf-8?B?bDJ0QmNqT2FteTJUNlRnWTNhU0hMaEQxV1RPWE5SR3lNdHRSVHhaMDFJaTlB?=
 =?utf-8?B?OGN0WjdPVThmZ3lWaWVyWkI3dlRhTW1Ob2Q2aVViZ29KYmpyMWU5RC9BZ0NO?=
 =?utf-8?B?K3BjMVB0UDBVZU1GQTVNR1dOemNtbkpXbXd2Z093SXhPVzhOWlErNy9iRngw?=
 =?utf-8?B?cGovNzRTdDViTGxZK05HajdCbDRqSFdKTkdBemFFNnlicm9zUHpNZTZXVUsy?=
 =?utf-8?B?dlUxK1NMVm40ZUVqbzhvbTFlcE5pZWVCNU5CUlBZVWhjOHA2TkhYdmlhbWdj?=
 =?utf-8?B?Q29HUE50WnJMTlMxY21iSjQrUjZNdS8wYmhUU2QySml1ODBzREpWTmhtL2g5?=
 =?utf-8?B?bjV3YnE4eFNaUFpRaEw1bGp2YkQwaG9jNHhOcXdxZGp6bEhrZ0hCblZzNjlV?=
 =?utf-8?B?bHhoM3JQbE52NzVsNVhlZkdNWEhzbWg2dlNRaFVvZitQaGd0VDNPK3ZRb3hE?=
 =?utf-8?B?Q1ZHS1pWWVZOU2hEc0I0MEI2aWVIOFdyaWE0blVYRTNoVGZNSUxNTHNDOUpG?=
 =?utf-8?B?cmN1Z0tZSnpwK0JYT0l3Qms2ZkFsb3VDQmVwMEZaelg4VkFpZWZqS1JPYllx?=
 =?utf-8?B?QkVIa2cxbGU1eFRXWnppNmF5bTBEMm5ZaC9ib1Fua0pxeEpyY2Nna3NIRVU3?=
 =?utf-8?B?RUFGNWNrUTZEMDhoSk1pM3MyeHd6NURMUElQeGV2elBHRmlIaWF0ZE94N3Jo?=
 =?utf-8?B?RzZvTXZ1M1k0T2ZvdTdFM0d4czcreFNsV2JHQ01rbHpXaU9KcWttNVk2WSto?=
 =?utf-8?B?U2hWWVB2QVZvZkg4b1F4SG9wTDJJQnBhbElleTZBRGZ3TFZzSDI0V1MyUjVE?=
 =?utf-8?B?SjFBa1FNc0tyWW04dEVpQ0hSNEJNTUZIZjloUlhiMjZBMEJYTlU2VWhwR2hJ?=
 =?utf-8?B?NkdQWXpoZVRqOHFUcDNzT1UvNEUzOFRGZEc3dHJybmhDWDlPdzQ2citxTHRh?=
 =?utf-8?B?QUNxdXlYcHY5ejNFZjJNQ2JIUmRwOWhibUJiK2I2TkhSUlJ0Qzd3K0NZV0pH?=
 =?utf-8?B?VVRQNVZHSk1DbmN2RTlHZE9HRU1meVROdGwxeDIxeVNrSE9FYUxibExqbTI5?=
 =?utf-8?B?MENIdmhSQkF0QU4relFPaThuRUhjaGhZTHQvSk1HOXlZTHZOTGx1MFVJRHkz?=
 =?utf-8?B?dlZmWkpVVHRVY0NkdzNNMlBFb1FFUzNZY3V0N2M0L2F4MC8yamVsbUVwOExi?=
 =?utf-8?B?QW5McFM4MVNIaWFDRkU4YnpVU09jQlcrQmFUUUIyRHIzMTVsYy9OTVBkVG1W?=
 =?utf-8?B?WTBOMzR2QW91MytEYU9YNENCZEEvd0ZwUDVjdFo5YVVUOCtabm9XNVRYaWxo?=
 =?utf-8?B?aG43WnNpejdLa2MrUW1GdTUzR2hOQU9UTjVxaDZOSHNaMG1BQTI4WHczSCtQ?=
 =?utf-8?B?dU1YR3ltRmFVVmIxZ0x6aHJEajZuTVZOMzRSK2RiTUpTcmxDWVE1akloWEcv?=
 =?utf-8?B?dHJSZjR5Rmh6R0JGTFo2cXZvMW9JWTNGeW1qOHF6dWlEcnlHbTJOVS9LQ2d5?=
 =?utf-8?B?Yi9oYzdpWmZNZ2V1eDhIUm1oZVF1TC9WZXA5K3BVNnlHbG5jenhDSzBjSWl1?=
 =?utf-8?B?UENuYi80Sm9pazBwaFhUcDFvVzR0OTIyd1gvMVg3KzdjY0p1NlZDYmtSN3NJ?=
 =?utf-8?B?Zk9xL0VLK0ROS3dRYUdTcjRlZ2c1K2Z5WXpGdll4Z011bS9ETU5lR0JVUmRC?=
 =?utf-8?B?ZUdMc2hHb1hGRjM5NmwzL1J4dW9vdWZjTldTY1ltRk9mdUcvbFJma0FpNEJL?=
 =?utf-8?B?WnUwVS9ybUJKRU9BaTYxREpxNVA2VTR1WkZjTzlLRGdFcmx4dngrT0N2SFgr?=
 =?utf-8?B?cTdteklmd0lEM2tyUi9Nby96MDdjOFU2RXZ3VCtrVEtoTmFDSW8rbVNJNHov?=
 =?utf-8?B?WXVzK2htK0xzaDZUdStnRHBlMEVmcVV6czI4TWZnOWRPV20zN2tXbjVIRTJU?=
 =?utf-8?B?R2U4QXpoRmM4ODVBWHl5OFlmTFUwT090VFZxOVFKMTFqdTdOUkFkN1M4bFJ5?=
 =?utf-8?B?M2hzV1VSaW83YVBSMHpsNGFxNEtVTEFpd0crYXgvZ3VrMUZ5VHVYUTF3ZmY0?=
 =?utf-8?B?L0hKREl6SDhuYzRzMUQvL1d3T3ZmSTMwRWNad254NmVLMWtEZG5xSEgxMU5W?=
 =?utf-8?B?UG9zQnJZTm8zdkVxcjZ2OU0rWkZDUC8wWTd2VjBLU01SdGJzUFNpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f599a6-d4ed-45e7-394e-08da0e354f06
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 07:58:55.5396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQD842YkCnkFK3g0lernA8hhc8A5ekKIYqhmlAbHXswbnM2XTLUYQD7s4UySIaou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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



Am 24.03.22 um 22:31 schrieb Alex Deucher:
> Properly case to u32 to fix the warning.
>
> Fixes: 83f1287c57228f ("drm/amdkfd: Fix Incorrect VMIDs passed to HWS")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index d70f787369a0..62aa6c9d5123 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -484,7 +484,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	/* Verify module parameters regarding mapped process number*/
>   	if (hws_max_conc_proc >= 0)
> -		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
> +		kfd->max_proc_per_quantum = min((u32)hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);

You could use min_t() her instead of the manual casting.

Christian.

>   	else
>   		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
>   

