Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA39DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 14:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532B910FF98;
	Thu, 14 Apr 2022 14:32:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6187010FF98
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 14:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EijR3GrVqqbxjQ2OUWOSgEhHqm6w07Z3IbY8vbFxDJeHfXPE8aefivImo2vKNS6CUmuaQ1gTZFO332pMluyL1nwW7MatLPl+Qkn2sJxn6kaxlRaOxhP9ET3UsDAV9t3COxnEl0wXZeq7xiA5v1sj1SxO5m2v+gVc8+yNWB8iyOscsjkTT+rvWadq9nouVYUQbm+WS3HAUR5uDAbFAq0oXK27G+lgfrc6eSFE2R/QfVPZ7/DUsS9ykeEIGqWqoiegr3VkhKjdTjChY7Er0wxtjmOHO6nUiilAZJxJARIKtk6jjWWTD4kXFMF856z5EA8QkJFSPchSe9+CV51Rmr0FNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1wE3IVwzeNh467C6GvCwAqRZTeV0ZeALPOAIjJI2fY=;
 b=FeeY3Uy6MNx+yX34ZKpurTKR5cklbsRGV4VjWWo3iaQLlQYRKIOBrNdN4elRiv7KOd1JVJ478zh38aqOflIg3FA8JsXvyIH9HEVK8APTA3YoWH1RfHIuF6oQjfMoCY4zf4D+Fu9r3Kxn6qV+ubvdRoA9PpdM9BoA3T6zE29976z86bPaAh9t2pa4+Bwj9fychuvdcqAP9j+rXo1B7P4DQms0iE11tEAyKUhXA/k/aTJ71jbtWxhKxVU8z5LfmiRQf0Bvric/1hqwPYCnZ0x350DS/bQT1+zgoZqwVhDyYZfcABOA+a9Vs0WElGxT2DV4gZ+aawsNZbEAupi2mlr9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1wE3IVwzeNh467C6GvCwAqRZTeV0ZeALPOAIjJI2fY=;
 b=wAxm7zwJepZiVlATS7Rt5KxDkZFUmrNx/r2s8bO1JdyRacQ5J9At+aKiOIoGD8BzjethHe/xFY9n2dVJlyYRI6jZ3s83C5AWizVHNwqojIEJJoEY54Urbba4QCIKxMvW3M/1xEwOsUaxEa9yHYZyb/KzjcvIxvfvvn46LL6ikCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 14:32:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 14:32:23 +0000
Message-ID: <5a9f81c3-3889-a9ca-1faf-407e4455e780@amd.com>
Date: Thu, 14 Apr 2022 10:32:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220413193100.154102-1-andrey.grodzovsky@amd.com>
 <378bf20b-8888-2efb-44c7-9ec2d28ff01d@gmail.com>
 <BL0PR12MB24658257A9A31C1C69C38745F1EF9@BL0PR12MB2465.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <BL0PR12MB24658257A9A31C1C69C38745F1EF9@BL0PR12MB2465.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281afabd-0fea-4272-f699-08da1e239707
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1890B070F6CA71AE47600466EAEF9@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNO1+9ap5YFiPCUfU/OcQL8RqpEVfaByD6zjmmo0l1bmUO2ZXUL4hBI5rGglJPXeddboxAyD05tRtwYC4s82xOoiI/ea9IeGyrLM+cf/LjrHIEchHh8ZeHRtkzfAlJYR5udJwklT9DXv/NkTmdCnaxNXxbyfYBDstPHuwPOP4iKnV8Oz/ZtyQnSeTv+/A6lZwOh22pEL2MkCcn5l99T4XakbTCRddDkCVaJUAVlEn2rf/DdRaNp3vC+ECDlM0vKmQeV9Wm4yQ5aDmnuD3F2PRGjsB8tB4vYSWLgKE4zeUZnBCUtXA+UJsPVfDZRox7DoLK7qqaWe81hwAVoTuewOP6bsP0WFmyP2p7Xx1BOXz0IqLgHT22rK5JfRJ0lDPymCBTZMFivlASkDverfcKKDnqSANi6b9sHdhWCLEfjXe+MnVNNxvWMUy+1ilAJITIVfai+PvjaC9nK/4XJYleejD/jswtoJSZBa9NsFa3XR52VKoW88/Be4xoDdDfCQ3XfNXNZZgNTCjQTx5/nnJbsr6Hjfxa1STgebZV7+UzGMSkQPND1FotmcxY8EfPxbc8k31qlU47EIkKwkbKOgeMSVS0/Qd/baUfv2p9csqpT4GOqFgexzp1UhxVmg1rCUJf3wkYLUBYEsWAWhib1ii3bPl4CouK/GhAUprysxUjkTH5e/45AAP27wOlG6tRROLDkK/2rNxhRlu9MlHNR0rkkrLR9Ir/Yik8QLxN1j0wec5QN31kg6TWVqTh/F4J8wyf4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(2906002)(66556008)(66476007)(38100700002)(66946007)(110136005)(36756003)(6512007)(53546011)(2616005)(186003)(31686004)(6506007)(83380400001)(86362001)(66574015)(6486002)(316002)(508600001)(8936002)(5660300002)(44832011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFzOWZFakwwYU9WQXFMbFlaejhNTURDeklZZ2ZIQm9uMlV2RTJzblUzYlhr?=
 =?utf-8?B?YWdLQmZKOGthbWtRZVRRTTNrVWcxWi94VVZibTJJbExZRWd3RFA2dGJyZzZz?=
 =?utf-8?B?dWM0UzZFaEV1YnRXOHBOMkdSbFQ1ekd3SHlOeXZheW8rUldsamlwR1FIMHZw?=
 =?utf-8?B?dWQ0MlhQUGU2dWIrc08yM3pSeWpBNTJrblR1c0wxNm5jaUlzdmRocStWYzlR?=
 =?utf-8?B?YjhKMlN0L082SkdTQ0dFTU14RXBVbjRHUHdzc1g0bDhiM1BiTDlWSUVvdjBR?=
 =?utf-8?B?amlBc0tGcktOZUtodlphdmhEVGxJc24wcWxKNDcxNm45cDNPdTdkS1VOeTYv?=
 =?utf-8?B?c1ptNUIrVXdRdEE3L2xsUDV5M3BWT0ZOWVlLVE9wNlVQc0tXZUVyanB4amtH?=
 =?utf-8?B?YmplenRrc2lhMWwwbm5CRDBiMjduanFXUFlONElaaVlhUmYwaVFSbUNESlIz?=
 =?utf-8?B?NVl5VGRJTDN4TU1aemhLWXdnMk1PeU9PYTNZRTdKZDlHb3ltclUrSGgrMHhv?=
 =?utf-8?B?T05HbzVrZ05SZkEzajM1a0FCQnA0VWpyMW1FbTg1UEVwd2JqSGJqeDY1N0dX?=
 =?utf-8?B?TUNNM0UvQ3lxejFnR3BCYjJ0akM4SHdkVnZXMDNUcGozT0FaOGdPRmtUWUFu?=
 =?utf-8?B?VnE1QmhmbFkzdnZiYm9zb05rY080b3dnYWdwVm81L2p2dEVUb2VuMXlFVVRt?=
 =?utf-8?B?VjdoT200RFo1bnM5VW9WR1BGUGF6VHNsYXpRSWFHaWZuOTdXRTVrZ2RMSGRx?=
 =?utf-8?B?RzZ6bmtWK2hIL1F1ZUxsb1VuZjFEWnBqWXRKeTBHWVU1V2FFeWpERExLcEpK?=
 =?utf-8?B?a3pKUWVnbTRRcXpoY25nQ3pFSWZTTVAwSnNzN0xCdjg1TmxZclJ1UnhneFpT?=
 =?utf-8?B?RXYyNElhT1F6QVRsRU40cEhCWG9sVjJjVHRqb1FqQlpJMTlnZVluaFpOdm1D?=
 =?utf-8?B?T29ISFV4d28zanREbXBwa3VjWUVuQkpLam5BeldqUitXa0dlc2lBVVhpMURU?=
 =?utf-8?B?cmJQYU5VRWJPaGhCT2I2eUVyd29uQUttTHdGMlQvUnV6L3FXbnU0cERGSFlK?=
 =?utf-8?B?UG5PZXpJV25WZkFvay9JMmJuUWJuYnhIUjVLUkl0OEdySEpTUlltNHJNYWdl?=
 =?utf-8?B?MGt0elI3dUNVUVhvdFV0M2M5Vi9XaEhSNWUrWkR5WXFkR3kyYzFDVmV3Qmpk?=
 =?utf-8?B?OGZjc2tRbENtYWROdkZhVVdZb20vUVlabmNhZmMvWTZTUHlUOUNBeEt2RnNs?=
 =?utf-8?B?UVpLU1RjVkZ6QjRTRDdBdS9QVzZCQTk0RnlheUdjdmt3amtuUWJZQnYrOHZv?=
 =?utf-8?B?TXVnQXdRbDliYkdXNS9HZkxWeGRsa3Mrcm54VlVNRDdlSGY3N2dNaVJ3Z24x?=
 =?utf-8?B?WVpWOFR0MUFFc2Y3eUllM3FXbzhER3M5OFRtYU54RDBBdkZuQTJZWmtvcWQ3?=
 =?utf-8?B?cW5nd1pVakdjbU9zYlFHTzE1aUc5R29waW9uL0VQUElOUzdzcjNPYTZiMTRo?=
 =?utf-8?B?c3lKa1p4b2NRN0h5Q3ZyTnJTQ0RXVllEZGxDY21LYlIyeWRTSGZiUEl0WVds?=
 =?utf-8?B?U3BFK3I0aXRtTHA1L0hEekRRNmFaRTd3aDMvZzRSSlg0SzFDYlpzRjFEZHlU?=
 =?utf-8?B?L1RXSTM5Z1dXUC9kRW5RM3p1WFBiL3hBalZ5L2d5Tkgvcm1JM29wdGxRaHN3?=
 =?utf-8?B?OTJsYlc5ZVhSaER1K3h2YnhDWDNNQ2psVkt3ZmFwT0wzU3NpeUNVN2U4b0RB?=
 =?utf-8?B?dGNZNWpyWWZDbTAva0Vlb2lkbTB3ajkyRXhHYXM2M2lmY3BJd2xCSDU3UDhp?=
 =?utf-8?B?a1R5ZnMrSGorZnVxWlNMRVdYWEVDRDRCWFRFbjZIaUx3SEFPN2ZiaHk3T2F2?=
 =?utf-8?B?d1RabVJ2TlVKdjl5Q3RVcGg2cGhpR1VZT2JlNkkzVFNITWt2a21NazdESFRW?=
 =?utf-8?B?eERxcmkreFdZd3NaT1RrSDAzUm9NSUFmOGZDb29PUk9XbGRGVC9IUHc3azZR?=
 =?utf-8?B?THpCSGhyOFNyTHZtSUd4VFlSWGhMYTU5bEEzQXVYaVNPVHorcndrYlE0cEEx?=
 =?utf-8?B?YS8wSk1pS1ZRN0dmM0o5L3YrR0JTNFp4dFN5U2h5UEhINEM2cmNJZFdXd1Fm?=
 =?utf-8?B?M1lVTWdSM2RrS055YWhDeUg0ajdGZEpzQVNUdkVJV0JsL2FHR2UrWWFMRUJP?=
 =?utf-8?B?aDlVdm9uWGxaVVc0WmRFM3dpV2xnR0ppTFNUZEVFTVZvSy9oQkZIeldhYUZp?=
 =?utf-8?B?Y0cwOHhyOHUyQkdTZFY0bnNoM3FVMlVRdWE4MENseEVvOS9wZnhHVTM3TUcw?=
 =?utf-8?B?aWRJa0NDZDRuV3YvVkNIeEVuZndHM0VFcHcvVDJVejIzRm8zR1k0VTM2VnZP?=
 =?utf-8?Q?WtDB36pX+4j2AEeNsg9RRsxEbDz8j5j6jzyp+l7wJzbKD?=
X-MS-Exchange-AntiSpam-MessageData-1: TjTUGA0V1j2aZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281afabd-0fea-4272-f699-08da1e239707
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:32:23.4010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBovlDbcrb87kSl8+UnS62U2Ue75YtllRkFQ/rukkCspm6kPB6X+rhi508n6QuWllP9HPU9qUtufcuyX9f084g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
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
Cc: "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yea, i need to improve it a bit, ignore this one, will be back with V2.

Andrey

On 2022-04-14 03:12, Chen, Guchun wrote:
> It's in amdgpu_pci_resume.
>
> Andrey, shall we modify the code accordingly in amdgpu_pci_resume as well? Otherwise, an unset/unlock leak will happen when pci_channel_state != pci_channel_io_frozen.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
> Sent: Thursday, April 14, 2022 2:40 PM
> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Antonovitch, Anatoli <Anatoli.Antonovitch@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Move reset domain locking in DPC handler
>
>
>
> Am 13.04.22 um 21:31 schrieb Andrey Grodzovsky:
>> Lock reset domain unconditionally because on resume we unlock it
>> unconditionally.
>> This solved mutex deadlock when handling both FATAL and non FATAL PCI
>> errors one after another.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++-------
>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1cc488a767d8..c65f25e3a0fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5531,18 +5531,18 @@ pci_ers_result_t
>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>    
>>    	adev->pci_channel_state = state;
>>    
>> +	/*
>> +	 * Locking adev->reset_domain->sem will prevent any external access
>> +	 * to GPU during PCI error recovery
>> +	 */
>> +	amdgpu_device_lock_reset_domain(adev->reset_domain);
>> +	amdgpu_device_set_mp1_state(adev);
>> +
>>    	switch (state) {
>>    	case pci_channel_io_normal:
>>    		return PCI_ERS_RESULT_CAN_RECOVER;
> BTW: Where are we unlocking that again?
>
>>    	/* Fatal error, prepare for slot reset */
>>    	case pci_channel_io_frozen:
>> -		/*
>> -		 * Locking adev->reset_domain->sem will prevent any external access
>> -		 * to GPU during PCI error recovery
>> -		 */
>> -		amdgpu_device_lock_reset_domain(adev->reset_domain);
>> -		amdgpu_device_set_mp1_state(adev);
>> -
>>    		/*
>>    		 * Block any work scheduling as we do for regular GPU reset
>>    		 * for the duration of the recovery
