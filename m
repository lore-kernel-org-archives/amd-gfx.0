Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF4AC6FA86
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 15:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F3910E6DF;
	Tue,  6 Sep 2022 15:34:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E019810E6DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 15:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE2DtSaYXYxF372Nqz6ZJ0SvpSIxbMOW0WD/PXfAOezMEnkM7b9EsKBbvnMoGqFg27nqRIEwIR1Ny4v47nv+TiAHqIQAav4Ifsa3czcssPvFHSkwc33Mb498cYPYbYsbGZrSsNEopW9eqK6GbHTqgqLyWJBiP/2fF+im1YJf39/PW94vAquTIzoLctkkXGy4ZwSCGvJScRpLd7g4ljEVElf4AK71J/zPTmA6lmDYMy8U/HMfn4NpWDrjJPYxfAqC5va+yB+c14G7ygjgDbv5zMqol1q+iPyyzjJfACV8JtrRdKVqR8tlS2DuwvjKLSTiU7G2O8+S1lNuHX/WBOi2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUubmPGDFQMTzWJJyYFBkTniy2idd4qLUKHzdA+uo/M=;
 b=J3aJLkoTUhOn9XsXH+TYW2KDHVmLLl8hksJQJE5MQy064JoE3Z+gIJx3aopPC1GKvWrK9PRXJ9nmLwS4g+dcia5SgKz1R1KrxRQvNn2Avty2cvkRZtZMfVrDBYQ6dnueog0YNY/zhDYExQ2I1m4ejEJ0OZyfDdVP53J2Wc1VQjfRVIr4giTB7dQUEb69opaFWgftGcEtUy9WH0JX3/weeUkHVqwA7kvEuuy7L2C1hSA8g+bO/ghyVdJNyLZGph6jWrZlrZGzfiPYrz8R7DSs77ptv82REqIr3IsxO4uzEUZP528DQr7qi6TTFAI9ZDQSlymC9ORsjUbyOV87mSV2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUubmPGDFQMTzWJJyYFBkTniy2idd4qLUKHzdA+uo/M=;
 b=CxCTugC2/jZFT3lMJa2xNCif/jJpaY8D5P/CBvU26mscEZBgm6nxSrkY+ZUteq2OSu0BCBM8GGofqwy+OQsliAqaRn2VhDYw2E5uh4CsZcnGCOk3XbKRC51xps8PZpK6jVj+MMoUxFjEbb3q+ecAbsqzviA79fRBFIKkWCSmCSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 15:33:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:33:53 +0000
Message-ID: <b90aa6e9-138e-4e8f-14e1-0279a8d8c605@amd.com>
Date: Tue, 6 Sep 2022 11:33:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: print address in hex format rather than
 decimal
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220906054607.67959-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220906054607.67959-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329fe136-7f7b-445a-208c-08da901d3474
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dobelexGekwu7SRpIYbpIdEX3kAmrcM6KiKsz2ySeB1TKWAfwL0x8E+RW78nMsycwuRW1gCKS9v2urbw+qTxuZUUdnH4Uh0NnkwN+WsDMkgqD5JqxVQZyhp6y+XsZ+hKSG9P6S0xibob4GHC6c5PLfQsJnecxeGgJYcC1c2P/OwTJbcPQbZk8hacfhCeJ+KWM7SNhylqXJnHYN1YJAqY0MdN5cUODknePgj5I2DEEruOznbzmmikQjeN9M43xNuow32+HpCs2QfNPes47wPyWFVzWq7WAK18vdnH8b3aQz0Wvsval68Tx4VbEfmYFLD7rwhEHJPERxpauy4VQcrWiB/g1R03CI8X6eQ/nybZTA7CPrHIPqgel65MBTqZ+H+mKHhLSUStisce8ApBtZssY3xSvc45Eexwc3ktTIf8e6JXAQgd6lS8Nq2EfXTycqfy/NaReY4q3UZmnv7R+eh5BCMPAAsFjQ+A82tBVyI/MWnbogGjzbnTDGnZ6hz2dhp8+Rlf05R4IzZ7G4Q+uhMXScESBmqRr/bvrGB+GFA+gXXDRrGSXymUSYZkfGcT5l78dyTbPd5Ss7/hjI10y7PWPpvHzM10hyna816+XXn4HG/eJQCDde286P/m94EQVS3Yo+0F9qAci2FrAPrcQxYPg1OiqJG0pR4jRx0fpbo71WLqBQ2aiPZw4wqjzhfMrmiPikXSQmdGdcz6s5wfhRTx3OivyjGtMXO06/v4HA6v8HU0HsYPMQvUGgO083v8Dl36CD99zPy+YRk4AcdUhBOztd1qpIWz3laC/aKDXKBD6eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(41300700001)(8936002)(5660300002)(44832011)(2906002)(6512007)(26005)(31696002)(4744005)(6506007)(86362001)(36916002)(53546011)(38100700002)(2616005)(186003)(83380400001)(6486002)(31686004)(66476007)(66946007)(66556008)(4326008)(478600001)(36756003)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FkM0paS0ZMRUs5THBweHBiR05EUDd6aDRtZWdSV2Z1ZUdaWHBsVWdBUUI5?=
 =?utf-8?B?NVlOcTZicFdNQ3VQSFNaZkhZQnBSWXVMOUJvckJlS1hyWnNIZFltOHZyb3k2?=
 =?utf-8?B?VWEzSmY4YkZrYXpmZ3NSTzQ3VlhxV3cwOURSMXZYZEhpYVNWdjlxaHdIRVZx?=
 =?utf-8?B?czk2TS9oQy9qd1ZkdkVmVGxGa2xjdkRJYXRNTjl0N25jUDBDNDRvdysrSDgr?=
 =?utf-8?B?ckpsMmJhUVBXdGNFZFk1Q3dORzJBTnVtMUlpQko1Tk45elY2c2pRYkhIVmMw?=
 =?utf-8?B?djhJdXhmekRiTFZlY08xWDB1cksyS2NpaWdPcFpBQWxJQkhJQ2tHVU4zL0Jj?=
 =?utf-8?B?cHUwNWlSek9JK3BPUi9meExTdVlYMExjQitxdXZ3a2NaOG9yYVVUS09YMTdF?=
 =?utf-8?B?eC90QURQQmRyMThMckdHSjN1RHZYTndVcHVJU0xlbmFrcVNJTTZxU1lDbTRK?=
 =?utf-8?B?WklVeEJxL25RYk9wMmdLNWpOMm5EMkUyNGRiY2dJSTc0bFJSWU9rdFY3V1Fy?=
 =?utf-8?B?TmFKSlpuSUYvV3k0N29zTHU3cGVDUEtqVXFXcjVQZ05MVXE2c2pnU2Z5aWR0?=
 =?utf-8?B?N013Ym1JOENjazRoNWx2a1c0aXpLQ0hvT25KK2t6bE9jOWl3TG9BMTJZdTFs?=
 =?utf-8?B?UmxZaGZyVTY3QWU5ZG9UcDVNVWxYdGtJMVFDMWtBbndzZGd2UmlsWnlYOGJn?=
 =?utf-8?B?TXRnWXY5c3VweExQZ0NWYTRzZTNpd3dubFB3dUpGdmZ1NnZZNkFkanNKejNN?=
 =?utf-8?B?dWRubTlFVjNyZHpaNVdrYWhhdHFhSVYwNmJLU3piMnpCeFBUNHdJZTlxaTZz?=
 =?utf-8?B?ZWk4UGFvRFM5RW1yNGNMR0hXdjM3WjhZdTVCWW9NS3IvbHBRKzQxMk1YcGVG?=
 =?utf-8?B?NDM5NHREaUdTZUdzWHlhdHJEUFRNSEdibmR2YmQ5WmhCODZ5dytKZVBMQ0lx?=
 =?utf-8?B?dGpxc2FhRjNVOXRRaXNnYng0Sm9MTnJLY3BlcjdOSmZIbzJxNXNudGgyR3ky?=
 =?utf-8?B?Ykt0My9GVEl6aEFLOFBReDRaM0ZoMXlhaWxHYVVWS2h6M2ExQi9rQi9oc09q?=
 =?utf-8?B?TzlPa1lXc3lTeTYwZVFwNXZQSU1YSm92UDJiQnJiU003SDJWVWt2RVh6RjhD?=
 =?utf-8?B?MElKMERHbFM3RDhPU0FIRUdteGtmUkRBZFNKTVJGQzcrV3hkZzA0Q0Y2eGFX?=
 =?utf-8?B?Q0JYK1ZBdDZhY3ZZbk55QWVkWkhrckpnMWp5ZVh2MjlTNmZIL2prcHNsQ3ZO?=
 =?utf-8?B?SS9pWVdyZHBMVHowczI0b25pOHFMaXJibnk0UTdHY1FKdloveEdJSkd2YjJR?=
 =?utf-8?B?MEVvM1JqTzJVd05xVXpZcnpPSGV4NHJqajN0RXZzbWJrNkZKQUQxRDZoZU0r?=
 =?utf-8?B?NXl2SnU4UEpneUR4YnRsQ2htMHI3Nm5ZZlNsTnJieWZWNFMzVHZzNFVsWElw?=
 =?utf-8?B?VkJqS25xYnhFVGpGSVJ3Z2ZoNHltdzBjY2xUc3dJRUR4RXRPamNadkxpSkhr?=
 =?utf-8?B?c3ZWQW5RbkpGeTRaTlR4MTVQa1Y0dFZXY2tIcDE3a2dOb2pHdXdsMHFQSFNy?=
 =?utf-8?B?YTM2VUN4eHdIdWNJeDdVL29XcnRHYm8yRFk1UWRzV3ZvdmJuN3lqMXFmbjVV?=
 =?utf-8?B?TmpQQ0VUSDV1ZmQwWHYyMTBxeDVOZVprNi9MU3NHM1pRQlRhWTE5c0VDOXpZ?=
 =?utf-8?B?ZXYvZW55S2xKMk43aHlpY1FUV2RXbTB1VkZMRlhYdjZKTGlLeGduR0c4Qklk?=
 =?utf-8?B?eGRvOGFTUTE0L2RRZWhGd0did1NXdTY3NXFtckxsTlA0WDF3MjlLN1E2QjZD?=
 =?utf-8?B?Z0R0WDFxamZsRnBwalBkYmx1aFFZdzFLRHB3MkRMcTBFUml1WW9oTXR4czhm?=
 =?utf-8?B?NE4xYXlqdktLcFhFNThTSmVwWFNFelRRb1VrOWN4RzRUNnF1TkZ6cE5Qc2ZI?=
 =?utf-8?B?REJHTTE0am9rTzZKU0kwOHNRWi83eG5tVmsxVGZyZHFxV2tZYjJJTkwxcHRW?=
 =?utf-8?B?OGZxbWRJTFFEcm13bGs4dWxUa1ViaFZzNkY4Zzh6Y01tWW9FOHZYbHV0S3ov?=
 =?utf-8?B?YnJWbEVaVFhYZVNxNXBkS0hnRE5neERkMjFzNjRlK0Z5aGtEb0VJMUhFMmh6?=
 =?utf-8?Q?xJ5D7aTSzn1dlGBE0Hjt5HwfV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329fe136-7f7b-445a-208c-08da901d3474
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:33:53.6385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNu26V1vDVibzK2GaxBVJQxggbxRbJGWvvaI2YXFOrr2uzRByJ/xioGso4x0th6c5sX6kSC8suHm18+2kvNNxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-06 01:46, Yifan Zhang wrote:
> Addresses should be printed in hex format.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cbd593f7d553..2170db83e41d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1728,7 +1728,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
>   
>   	if (user_addr) {
> -		pr_debug("creating userptr BO for user_addr = %llu\n", user_addr);
> +		pr_debug("creating userptr BO for user_addr = %llx\n", user_addr);
>   		ret = init_user_pages(*mem, user_addr, criu_resume);
>   		if (ret)
>   			goto allocate_init_user_pages_failed;
