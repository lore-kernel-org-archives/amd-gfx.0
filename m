Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD4C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 19:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CB510E753;
	Thu, 17 Mar 2022 19:45:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119F510E748
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 19:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlNObutqr7DU7+r+YrWC2COoXk2g4zqgVPQSLjfdQ7MeQ6DdmEiPnXmBJ+JBnZImhXwKNSbcP+m9ngMq3gLjbOUWKO7sM1U/7+fF5kIMbuyV1YLdqIiq+HhF1dWIhqQQ4tQeoKRUEpxGBYKyYTCxqcm2q+TVpeKSn6SgRU5svW8lTX3Cjh68/tK7AYv0s/IrHTrknAPOSz3y7soBwXrFjrpMVoy78q9vuZiaDU3QkV1i6r+kFgka4HRiTEukJetil4riuk/xMujmknQweTILOc/S+fa8hgBha4GRl/V+tr7xdh71/gZWxgpMfS/WPuRm3LzEIKw0+qGlXLovqVk9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HJHqFb5rRooSGPyHypGcK7mYxjryeUrLR5FoW/SE8c=;
 b=dkNRmf1CSwUWsUvvLK3cB0NC1unIH0eNMdWeyFqq4PPCZm1FcEtnyhciEni5Y+K/d5gL4OjnGASjjTtnOsqvfoL9WicCA6LmXh0DCAXW6GLTcggva2wFvV0G/VUVHltA8X8VwhAgME3Ud49P0RzgcEoEL8fpHF7/KHIV2oZ4MP1hqmSaQ6bVr+AT7XXRbszp1CXQESS+mBX3RXLsNZdAewJbwmIUxNi4Cyn9eFK1XTZzaBB4FvkR/YDJwb0AodHd4eoOwJ8UOYQx12ID5XEZPpAY4JOK9RqiR01o6kLwb71HVamDZbiLGTYAmvzvqjaIGoJtBEFdpktdVGTVnuVacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HJHqFb5rRooSGPyHypGcK7mYxjryeUrLR5FoW/SE8c=;
 b=AM+Y6uiSSAbu1Agm/QRIYF33tP70NuW4Y9udaihHd2xIIn0qcw60VrjSn0gHwGXu5a0PPlTfzn2bHluQ6I/4kTFbCAEjjWSwyAm8dHyp4fjeZC17mbl5s8zXY/w+dhYCn6dPE5i+4fRZRTlsVMCZ8XnQHaD/fGuTLU6KpdGrTU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 19:45:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 19:45:42 +0000
Message-ID: <48fc1485-900c-d27d-82fc-57bb2917ce30@amd.com>
Date: Thu, 17 Mar 2022 15:45:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Fix Incorrect VMIDs passed to HWS
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Tushar Patel <tushar.patel@amd.com>
References: <20220317193723.128232-1-tushar.patel@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220317193723.128232-1-tushar.patel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb504c28-881f-4e10-724c-08da084eb890
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2528D25472355957BEA8DF0D92129@SN1PR12MB2528.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQGv5fNsKxnrHfa0I/CS69M7CZ4qJ/yQIItBgwWQApFLSobjJj4oiSdjTlm3TFtYFQbSgIWrt0/0Kjt3Awbm0dxD8Eo0/nXJQrPjmtgylRmUNGlBi/06DNnFNEQjNdUN/0ky6mgVigYpRZw+xxHRq99EmUsh+6jvE7Cg20iv7M2eGnGKID/3vdQ3PtDzgqhslrp2mWsdMlVOLvTfHSsZ7VfabwrdZ0M+V907LRZn2OTsTPq7ikSj+5Ac2aiRlbpJtXaaQtKM93cv5ufuUmqo++hObDdwcEK9NUq0yY875Fe9FI3n5Iv5EWnDpGABCp8ED8+xJ+nm/1iL/kKedaaHgmKhw9SKjP6K1HDDsppcn+6mldFE++RMtQEEUKllmOF64oDadpu6sBJVOyIIfoT2mYpOvOmGcAcKAKyqWLYQD6p6LYa5HLaLxYpxBkbZGtu1Zuf8uPbmQq3mMX8g5Z7Fqz1Qj/jK0LMmnRTn4bUy5lvvxEgbQB8bcfsMbfo5+5Bx/Bp9O0ps5VdV9FMNdYwal+jEIj1Xhj0e1VNvp3sdG7o/MFFG0m4Kn3L4fY4g9mnj/fCmksadjnYYpnAJE77CdNu0XYt0OHAh8sz/DiBJny/nlnkd+3fT7/YjVExWmrKf9h4f4j/9vy7DvFNKCplp2vln9qVOon6WTuIexVjuKZv+NRnnc1i+MVXzegKfndfSUHZ/v0ECcHE4WalfhRxR0ewP7Om6A2CatUHCeMxtvIxfVnD4hzvWXYh+OevsA6we
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(66556008)(66476007)(8676002)(66946007)(38100700002)(6862004)(8936002)(6486002)(37006003)(6636002)(6506007)(86362001)(316002)(508600001)(31696002)(6512007)(83380400001)(2616005)(31686004)(2906002)(36756003)(44832011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUl3Zy9IajJSZGkvSzVrYUM4Vm8yWEJReHIwUHV0WDNIb3I1ejBidUJCaEF5?=
 =?utf-8?B?WUltZWk5Tlh1SDY1TVMvcWRVbGV4cVZYVWY2Tm53dXFqaHdhMzBYYnNoaDF4?=
 =?utf-8?B?Umg4NmwrQk9UaTJmaCtIWXd5bHR3NWsxaGJ1eWpLS2UxcUloeTBmVDlaZEVE?=
 =?utf-8?B?eW9ZblBYdWJPaS8wTVJQeXhZNGQ3ZTdyVEdTQTNEL2hMSTFodkZHNTNtMTh6?=
 =?utf-8?B?TENpWjY0U3NYUjYrRzFyYmZPSk5DUFprTno3S2FVOS8rRlNVRC8zc1ZKWVQz?=
 =?utf-8?B?Q09qYkpvUW4rMmdobmNtbmZteDl1ZGVsbDhIN28vNFk1a2tHalRQT3BtNzNm?=
 =?utf-8?B?YThsV095YTZkYmMwK1U3UlY4UldhWTdPR2FjZEJkSURBZGllbFpKcXBPWHRu?=
 =?utf-8?B?YVpLOFF3by9lcnlmVXV5eFNuU0JGNjQvd1lSdWFSdllkVmxjcU1IUGdZd3Fl?=
 =?utf-8?B?RUdBMzVVamFpazVuYWNqdEgyTUJTeFV1UE96NXdRVW5FcUh1aFV1R3hYYWxl?=
 =?utf-8?B?ejdFa2Jkak1XdmF5S1ZNMisyYURMVTBYQm8zdDNWa0tTMU10QW9IOVlsd3Jp?=
 =?utf-8?B?UkRES3dldS91MFFMUFBla0o1Z3czODJLZGFyWjgzdG1wcE9iS3dMV0lTUlhZ?=
 =?utf-8?B?ZlNoUEJlbkNlUWdUSTRsT0szb0dBdS82dVJCM0VYaUZmdGdPNmE0blozelBW?=
 =?utf-8?B?ZGF4dnpEcFJKUXZ5eXZrOWttamFLYXJoTm1IdjF4aXNGczBXWHROZHc3UEhV?=
 =?utf-8?B?Y1FCNGxTdjA0dUp3YnorcDV3OGZOenYwMzBRK2xDOW15WWhKV3NFWGQ5ek0v?=
 =?utf-8?B?a0pCcE9WeGh1UjNwVW9Fak1ZbjArU1p0YW5KVitSdkZkQjNTSjFoM3FQSlJH?=
 =?utf-8?B?VW4xVjdicUpHNUF5YkU1UmtLUzdoYnZ1NEM1eW9hd1hYdVJKbmpkZmMvZ1Az?=
 =?utf-8?B?bnV1cDVIdWM4bU5BTSs0ejhBVWtvRUVQcGVGWUVYNUVrSmZ3TTBuWTdvc1VJ?=
 =?utf-8?B?TnBnSzB4WEIvb0hoWFFFR0RUelRjVE9iekRITCsrYzhBNzI2Uy9FUXNnL2VD?=
 =?utf-8?B?QTdETDlZN0Z4L205aXRCTENycjVJZXVqQTNCQUNoMHVGZTJZeUNpQlI0dzly?=
 =?utf-8?B?OWQ2Z2F0QXN3VjRsb2hxZlcvL2tsR1VOVjNCVStXOGtMSHZBeVFQeXZRUm93?=
 =?utf-8?B?My82c2ZHbWtSaGc5UXZ6R2luYlg4ODErRGNGQ3dWb210Q1owOENQYmV3TFV4?=
 =?utf-8?B?NG5NcERobHBxZFJibnhBdzl6cHlJOFUwbGFGdFkzK0ZYTHdNWkNZelByc2pu?=
 =?utf-8?B?SEorKzMyY1pRRy94WlNPYjF4OGNqNjZPcnA0WXI0YUMwQnNCdmhSTTlHM3Bm?=
 =?utf-8?B?RFVxVjhTM2VMUkxnUktDZ2xNcEw5Q2tnVkViSElQWTZDbFRsclFEendYeDlh?=
 =?utf-8?B?bFV2d295bFR5d00rVm53TUxiVk4rLy8zUzZNRlNOZWJGemkzQjBLaHc0MHhS?=
 =?utf-8?B?SFNkc0lKYUlWcDBScGVLSHZkYjZ2SFgzeXF5Y2xGcWZacXZvSDBpaGVQbWpJ?=
 =?utf-8?B?Mk9iUGlzZ0krcjhMVmhWZjcvUzZxWlo5UTZxVDI4ckNjbkw5UW9Wb00rdFNo?=
 =?utf-8?B?d3pvalI4YXU2a1Eyc1BYVXBrM2VOeFZSRHRWK0VZS1Jla2N0cXl3cXBQbmpU?=
 =?utf-8?B?bjlKclNtOGQ3ZWtJTTUwSDB4RXVQMCtSWjZXR3Vqc1Q3WSt3RExMbTZmQ0N4?=
 =?utf-8?B?dUNVOUc3aERyanVRWUl3WUFtSWFKckZTUWt5OWdDM2lrc0gvQmpFNzJ5Zk56?=
 =?utf-8?B?QWpsOWZTelBxZUhsMjFCaUNqT2pwY3dIREJOTkhidCtJMWtobXlCbGNSSVNO?=
 =?utf-8?B?OTE4S3V3TWkvTVRNaS9EL0FWdjVCN0R3OTBTclRVQkYzSFRnU0NzMVo4cGx6?=
 =?utf-8?Q?LclyaCo3kdANFr4aJPWkBxYC0bBuiyfg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb504c28-881f-4e10-724c-08da084eb890
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 19:45:42.4073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1tEHv+DaxL42194wIBEvN6+xN0fpPPW/uoAPSZEFuBQVQqEh+mZGtYrCXsRyDiiZ4TJQPBpnN1alJvRz6o14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2528
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

Am 2022-03-17 um 15:37 schrieb Tushar Patel:
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 ++++++++++++---------
>   2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4c20c23d6ba0..bda1b5132ee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -680,7 +680,7 @@ MODULE_PARM_DESC(sched_policy,
>    * Maximum number of processes that HWS can schedule concurrently. The maximum is the
>    * number of VMIDs assigned to the HWS, which is also the default.
>    */
> -int hws_max_conc_proc = 8;
> +int hws_max_conc_proc = -1;
>   module_param(hws_max_conc_proc, int, 0444);
>   MODULE_PARM_DESC(hws_max_conc_proc,
>   	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 339e12c94cff..39073f72fe5f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -483,15 +483,18 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	}
>   
>   	/* Verify module parameters regarding mapped process number*/
> -	if ((hws_max_conc_proc < 0)
> -			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
> -		dev_err(kfd_device,
> -			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
> -			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
> -			kfd->vm_info.vmid_num_kfd);
> -		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
> -	} else
> -		kfd->max_proc_per_quantum = hws_max_conc_proc;
> +	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
> +	if (hws_max_conc_proc != -1) {
> +		if ((hws_max_conc_proc > 0)
> +				&& (hws_max_conc_proc < kfd->vm_info.vmid_num_kfd)) {

I think this should be <= kfd->vm_info.vmid_num_kfd.


> +			kfd->max_proc_per_quantum = hws_max_conc_proc;
> +		} else {
> +					dev_err(kfd_device,
> +				"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
> +				hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
> +				kfd->vm_info.vmid_num_kfd);

I think this error message is the wrong approach. hws_max_conc_proc is a 
global setting that affects all GPUs. Different GPUs may have different 
numbers of VMIDs. So we can't treat (hws_max_conc_proc > 
kfd->vm_info.vmid_num_kfd) as an error. It may be an error on one GPU 
but perfectly fine on another.

I think you can simplify this if-else like this and get rid of the dev_err:

     kfd->max_proc_per_quantum = min(hws_max_conc_proc, 
kfd->vm_info.vmid_num_kfd);

Regards,
   Felix


> +		}
> +	}
>   
>   	/* calculate max size of mqds needed for queues */
>   	size = max_num_of_queues_per_device *
