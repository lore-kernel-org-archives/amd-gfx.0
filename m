Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620B8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 05:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0DD10E4E9;
	Wed, 23 Nov 2022 05:57:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40B010E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 05:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrqVgQOTAb0aeYQGJ+GTmsPFzo1M/qvkdEOAopiz5shmfIpThyMIAbdcZTU1hsmP9x51gpBQsVo+n+KDMiBUvtKX8KtIGsaHQAJ6acawfGzVtwQZXmKRTs1e2+8rk6mXAddoBmPGWPpn8QJE4xW4Kcx/1khgwLFKHrjyyqdRfhFe4+yiuoYHNGv9tcNhhUk3/vFJ3mYqSPaIsYKrdhz9ywB6+vDxZd3kgUShX96oJoij2Pfdsk0F2bC2+jffcPVMuYxWr27y93KlkQB07jQ/bU0AyaWqXbwSBFy5k4TOVcALMDRxurw2ELamnfMkDmasC8wp8gznI8eiwrfNyKXeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUyIr+XOui9AEFze5wyg60h84tcLyLI3Qk0TY7mjtTI=;
 b=VTOc2yM9qhf1aok7Z0tG9ujf2PuPDtVxfo4Njd826uE14Go3v1yGpjVj9DXM3r8LmGjXb7WTj4fWN7p3Onf17CvOOCCzKqMtxp/Wf/SAvR7kR0ygu3XqilqvJApYem19N4JjRAYsqzZiZkbeoh5FwyaUvE9er7hVXzA4yWqYQ/gHKeZnBOd5Sb5MUHRH7bNrZo9zorHN2LsuBsTc8O1W6z8ws9QFs17OllpL5GCoN1OOBolHG8kIs1ACYbi0VAHTUn6iwHCzRjP6Is+A6Ny66oZs3NI1bnt875pP4AZU7Uiyro0I4D2SZmUpTKIU6R3PspX5UsbJQc274OUd7+zZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUyIr+XOui9AEFze5wyg60h84tcLyLI3Qk0TY7mjtTI=;
 b=pInnS1CgRNqCLnfPuoRn1n/+qVGI4Ge69ttw0ctNYzkpsDp/QmTQKiJclVDD6CxserMMxs3lun0+LHAgD89mBhyOW1c2DkdehC1yl3vmZooj4XSszjRPxHeRoY/gbVoV25tI3tVTaw85O5ELh6m0KIMD24SRQdHeWb0GThYMdb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 05:57:47 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3959:cdff:85bc:f148]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3959:cdff:85bc:f148%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 05:57:47 +0000
Message-ID: <24eb1835-d49f-f938-c0cc-ac8cfedaba4b@amd.com>
Date: Wed, 23 Nov 2022 11:27:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] drm/amdgpu: add printing to indicate rpm completeness
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com
References: <20221123014408.263645-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221123014408.263645-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 097952fa-a68c-4641-2eb3-08dacd17a570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VR6D8NO1kfMKfEQa15USqG9AdOJqC+UC884PXtSQUfXIpKxNkDIaVz4elKnu2xDVGh1kXD08jIkLWKmzxwIr5hkq1dOD/i0JzdmaSKNE45XKWEj4hB6aBCsZtJMUTw5sIhDhCpkmukEGWcZhZAO6JNe6aq/AKHESYzIZih0cEZ0zX2HaTXFYqCt5UMRbHPMtvOJsTxWF4Nvy3kcV00LvomAtB9e2f+D4baSf6ncT2rZ00DMRC7TCcfVxKxc3VrmjD1QfLceF9aaRU2MmvTJ3ilQttHe94Wp8uD0Vi9sPcV0nUioGNEbpJYwMmDAoEdDpyomfKLScn8fvsOhfvOd8BsHxFIQ+U2RaMQTZAy5OdyTwoIA+rDZx4ZGGpQ8rwnoJfIwifhrOljs3uZLYKYTzJ5GbolkZSduqBES0l2t/LHTjcRJ7yP/A8P+LbtlaLl/2ieERf+/aHVfgdo2NWWRsocd1s+1dQkNrvtl0A4TIqHbr/CRrtJaJ9ijowNtRdjTGZIc/RCLSowZvpZc5RCPC42VG22IXxm7NK93Oh/7Ti7C1cqPOy+p6IICCW3Cxg8qSIbSDOeQHSatRMekKuUF7Aoprmh2AqHaFWiWCOAngVczIeUjmr0yjNvZFXG77dlXn9s5WDBdI9tyYhnh1XkJm/U41mHse4xAstXIqtrUxIqJPqyQ70xk0jdqetFqNyHHT66N9Vxkdma2nQaL0zcIMqd+wz/ZWQq20rtTBA96GOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(6486002)(6512007)(6666004)(6506007)(53546011)(26005)(186003)(36756003)(478600001)(2906002)(38100700002)(83380400001)(31696002)(86362001)(2616005)(8936002)(4744005)(31686004)(41300700001)(66556008)(66946007)(66476007)(8676002)(6636002)(316002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JRZk02TUF4UTVRK2FwTnh2dU1qV2ZoTWZqQ1g4cnJybElOOEh0NERMblNX?=
 =?utf-8?B?cSt1dWtLQVVCL0REQWQ1QnNYbG1CdEl6UGZJVkRHNitkZWFmUTVaMnRNSllC?=
 =?utf-8?B?WVRwcTlzcnRuaGw5VjJGMWViR3p2UnJHV0ZTSnNrb3U0UDRIZWIxMEJzd1Fz?=
 =?utf-8?B?TU84MVZlNEJrQjE2b0J6WDFiV1ppdFJyRmdCcU1DMkM5anlNdkFWZmQ1MVhJ?=
 =?utf-8?B?UURZV08xYTVqcUtUbityMjdWbGtCN0h4RGJiSTNEUGxyaTR6Zjl1YlZiVjVB?=
 =?utf-8?B?OUFCNHE4NkdLV3BtRm9wSm1UaXlkRzhaNU93bVRCVW1iNkJOUnRjanV2aS82?=
 =?utf-8?B?SlMySUV3Q25VV0piRm9WdVpPMlpybEorWVV2dWRqSDJYTmxwL1RyblV4OGR3?=
 =?utf-8?B?bDBSa0Yxc0pweG51T1VjV244VkI0Zm9nbFlpYUM4cjBJb1lBM3FqU3dnZS84?=
 =?utf-8?B?TDc4NDJscXgzRUNETkJlQzIzNFFyNlpvN1pra2MwZnNTVlRmRVlDNmE1QXVp?=
 =?utf-8?B?SzRMREFhdVo3cU9sRUQzVi85WWFNYlRKQ09DdUUyMFhPSnVNRWI1N2NpeC9Z?=
 =?utf-8?B?SU0xOURTRW9TekhodVJrQ0pqNDJiNGFxY1dFMy8wMnNxdzIvZHRsNXA5MldS?=
 =?utf-8?B?bEhIWDltV01kS2kvbWc5elpESDhxRmd5bjk0UXA4aFFNRkNETnZvM3gzOVZn?=
 =?utf-8?B?bUlZSlVkanpTQTVkQ2l3TFVySGE4eTRpaHZZUldnaHQ2ZEVHNVc1cUxtVS9m?=
 =?utf-8?B?TTl0OEFwTGIvTTZwRGhTWGx2M3dtN2tGVDRYQzZlTHlkeFVjWDMzTTk5REY2?=
 =?utf-8?B?RkNTVUxEWm5iVGJXb0RpMitEaERqMDNCUEE1WXVHMU84NUhXOXR4S2ZpWnZl?=
 =?utf-8?B?aEQ5MlY2WVBpQXRtZjExbGFpcHlxTGMyeE4zNlVwTzJQU0kySWx5RGNtRnA4?=
 =?utf-8?B?cUdTVThldkJ1V0lZMkRwSkk4Um1nZ1NCRnRRSlAvV01QdUlOZEZvaXNrNEtV?=
 =?utf-8?B?ZllKek56Y1lMWlNieExNb3RlRWphTk1pYTBObG9vcThDQmlMSkZjK1FhUjRh?=
 =?utf-8?B?eDZ6SWxTMkhlK3BIVjZzOXV0NTFYblQzbXM0REhVd0NuZ1dMVEcyZTRXNWdL?=
 =?utf-8?B?UkpRZm1lbkRhRUpTWHRHWWozbngxOXN0ZzZQVjgwYXFuRGZVQnhSMHhCK0RD?=
 =?utf-8?B?a0t1RTBZVk5qc1o4U21sdEtBdHV3NlhUdFRzNlVwcDIyQ2taMEs2RWhDY1BJ?=
 =?utf-8?B?QVc0bXlNdlJzNlpRQkVScFl3MXRXQVgwSEl2RWxaQ2VxV0Q5L2J6SVJ0a2N6?=
 =?utf-8?B?Uy9YK1dmMUwySndPUzEvbVlQTVlOdzNidDFzcDhXUnNWREJwQzl2ZVBkOEov?=
 =?utf-8?B?bDJyZ25wTDNtVjZJSGg3Zlg3U0dNSjkzR1J4SXBmM0U5SXJUYXVwSjJNS0lI?=
 =?utf-8?B?T2krdTBadDJiZUhDRUN3UThZNStjd0hUcXIwZEtwWCtWQXBxdC9QYUVaSWRj?=
 =?utf-8?B?MTNtbnRmV05JNy8xUkt5YmFCM1JMeGxTeEFveXl1SU81Y1BtakNtT1E1Qjha?=
 =?utf-8?B?bWtodnhMUkdzOVZtSU9Gcm0xaWt2dHFHbkY3dkJTUHVzSVRUOTFpeUcvV2tm?=
 =?utf-8?B?NzJVd044SkxPSlMzMXhaSDFIdmpPelh3TjQrUnRnRnhqeWVLdFVEeTFBRSsv?=
 =?utf-8?B?Q013aC9sdDRCRDFZbHVDYVYraktlMFRWbW9ERDQyOTAwWmZNSFNEWG5JazU5?=
 =?utf-8?B?d1Rad2Fjb2hybFVSVmxsOWtWeS9OWkdXK1NMK3oyd2dMK0QrRmR1YlJyRjgy?=
 =?utf-8?B?MUtBN0ltbHhHL3lramRjYlY3eE9waDV4NEtIUS9CNlMwNHNnYnVkT0QvL05x?=
 =?utf-8?B?NXBJc0hZbGdyVW5kZ1MwRExCNjJlYTJhKzNJMWkyT25JZmFIdFJHMndqeFhv?=
 =?utf-8?B?R3FsS2I3YzBnOHMzcXM3MGJMUmNYNTdpQTJMd2laK1A2TWFGcnJJcjZLRW81?=
 =?utf-8?B?dXNvaTJ1d0hWSElwaWx0SXkzS1ErWVZmbHpoQTl0aWExcWY4amZYVG00YVBR?=
 =?utf-8?B?aXpKZU10NzI3VHo5L0R2ZjBJelR6dzFoekhMM252bHYwNS9QaFJxdFhSNUl1?=
 =?utf-8?Q?ZCv9J0jvHAd+plfxg7AG+WaIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097952fa-a68c-4641-2eb3-08dacd17a570
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 05:57:47.3786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D379Evc5eVAiVC2TXTZLbKTlqu27ZopiJ0hlt/LsMQIgea9ef4+RHg3aDX2wrvsh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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



On 11/23/2022 7:14 AM, Guchun Chen wrote:
> Add an explicit printing to tell when finishing rpm execution
> in amdgpu.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bf2d50c8c92a..fa42c0fcf848 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2572,6 +2572,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   		amdgpu_device_baco_enter(drm_dev);
>   	}
>   
> +	dev_info(&pdev->dev, "amdgpu finishes runtime suspend\n");
> +

This may be an annoyance. Maybe dev_dbg?

Series is:
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	return 0;
>   }
>   
