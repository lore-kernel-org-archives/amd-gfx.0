Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7354C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 18:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6A310EFCF;
	Thu,  6 Jan 2022 18:58:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7660010EFB8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 18:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieC8Y8wxEYbZiqAfoQ7MiWXHG0MCy5kCn3BHzwHxUv106BbjlwPy4cR3NxdccNO50cHzQX0cRYRDNIbf5G4pEmgotb6FGpyEoHhNtoAKfJpSLENAh3QUrXGMdRxf+uxawQRa+kyQE0V/iMGnrSqIwJQCQonlDYi+WPybibyzih+FY3z675gB3JEfEbAC8ZriSLQQgdqCWtEf6ZLQXMl3x8pvZnzEVAPY0JBnxkBhuwKYFHThrrrgbAG3UoarJ9+fkagNeGp8LrKVqVXpO4LRqPD8EVt/U3Nvir8cwo6wRb7TztIkiURl0YKz6pfmqaZNfGJ8wuAB4+2yxEKSl9oMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R26dLg9Kn36Ii2Tkz24rQ0YiO+Sw9ac28ehEGuKXKYo=;
 b=RaRyuGFdeBXFel+0dYK7mOENOCXEhqHmySo3+oQCx08hhWXzV/P5fWHJc7jXZUeDHheqcj2VmjQug28OOhIsJRXrZgeSk4454isg/A8p1bvCAeN/LYpH/SBs1eI1kP9PSWZ1KTZtps9+c2ZsDz2H9kswX9rMnBzgtvTEYrsHoNexGYf6OrT8OcZX8CpTobFAVXz+GzhAUlNxKV8ESF9kGyqC4Tszo07twcRcZv0k8isMcItmYQwlSRoir3HH2kEQUALblO8LumOtuJWFMorovViqUBNBG+LNihBCxFYgQNtvAO40VsF3WQKO0BOBl989WEfwUR3yVZyMMMR36a2vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R26dLg9Kn36Ii2Tkz24rQ0YiO+Sw9ac28ehEGuKXKYo=;
 b=uVzqES3ipr1pgvQb/fEI/eOHVwP5qMNKdJUuQW4P7CKJc1qZF9jn3dJq393pGw+SaqnOjt/sg73nUEnaOxdvErCzFv92SelIXHBYHY1YZXlr1ovb1pKbm3i6dnaKkQc0R+1pPkQuTCNm/nL63UcDGWoilX9LccxEu4krVy3fn7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 18:58:51 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 18:58:51 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not
 unplugged
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220105042344.988200-1-Yuliang.Shi@amd.com>
 <36b4daf3-c18f-b860-4f82-646731be9fc2@amd.com>
 <CO6PR12MB5458950D4F580F8B6CA08785E04C9@CO6PR12MB5458.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <b4854c22-1463-5030-4886-3b910259a298@amd.com>
Date: Thu, 6 Jan 2022 13:58:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CO6PR12MB5458950D4F580F8B6CA08785E04C9@CO6PR12MB5458.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::10) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41c1b7d6-f381-4d3f-02d2-08d9d1469411
X-MS-TrafficTypeDiagnostic: DM6PR12MB4044:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4044B94FB90306492CB7AA40EA4C9@DM6PR12MB4044.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIhEkex78BRWQj81Oxe/3hmlmcr/1Cs9VMLD5Woa22jyBqltIMOKIeWgVq6k1SC3xlMxG84T71zrK4V9ot6SYW+q10xuFNszCldt1D53Yxg3v0gtRo0LUKrJMe0BGHr9gm45Bwpfqy8AoZZXqfgbhDwfUU3CYa0ZuRoyaTAZzK+4pj+ik5rQhJdGG9UoqjpA+NqyK/hKCOfp1CAEM3u6kPsLkA3YiJU6dZSHJ93PnLerrx1Vt0tz8D8mPwlaG+6ITkWsUlXTwe3sP4w1DT0/Y4luu6ZEs/+djRi29lpy8Hln8K2LelSYv3DwqoI5UHvXwt2sCSB1hIb2RpCb1hw7tf/61Q/QWS0OVMSfuYUKrEUaeoZ5yLsjl4MQYmjXwG1dp4Gl9BKAtDCAXR9mevfuC9J+vr6FVnD+Sl2DtPMD3DGKwcIQ/9KLjhtDYe+/ymxXqXchNRIGGoh2gbSygArU7t72QD81xy20QgFdPgTmQ1/zQwTuXoRuhtM4B0EYWGSaqHvOLWUoTnnM2yKAxRg/HyNy3T+yyDh/uGdcI56CdC7rcP8Db11k0DqlrWcjzpo1eiN+UQMOfqCIVxYpdxWgiIPoGohkm2gY3wFaoOnpkSrsVitA290I0xTw/7JisV/mB8loMbpzVNzxKQf65Pc93z8OieEdsQPN5YnXCuAQeOJWI2g5a38GKVXobrDK4uAOrmZ6+XowIAk53A3tNxBSRpNr8+1bqDIcvl4Q0rnkSGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(5660300002)(66556008)(36756003)(8676002)(66476007)(6666004)(66946007)(316002)(6486002)(2906002)(110136005)(8936002)(508600001)(6512007)(86362001)(83380400001)(31686004)(53546011)(6506007)(44832011)(38100700002)(2616005)(4326008)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWF4TzJYNFlWUDZYQVVvZVBVTjZPMnRYL1RSUzZYbzVmOVFiNzdnd3hTaGxl?=
 =?utf-8?B?UEIwVWtYdklJZERMOUVCN05sVk16NXVuM1VLVVdwT2VzZ3dVbkdFb05qcER1?=
 =?utf-8?B?dnhxYTBqV0ZNSC9EQVJkQitpSzliSGp0TlhYMnEyQ3NFSE1HMThlY0VkRFJI?=
 =?utf-8?B?Wk9ZNG4vUEN6cm5ITWRBUThxaDN4NTlxQTNzY0pWa2RISTI5UnR6OFh0TGY5?=
 =?utf-8?B?ak41aDdGczEvakI3djJCSFNQd1huQUoxYXVMbWI2bzJpOHVIems2U1FITjVq?=
 =?utf-8?B?MzhjbExZcEVOTHNFRXppeEdTSEdQcHQvN3RHMFBNZElVMnh6MVBDcWlabXd1?=
 =?utf-8?B?M2VxaUl6WmVpSE1ndWZKYkJVWUNSUXAxWXpLTVJNdi9CelhKS2JKWGx4N1Ey?=
 =?utf-8?B?K0FnSnpqd3NwKzhtQ0IvRmt4QXRyT0xubDZiMjBzeWFBSUxuQ2FsbkMrYk5I?=
 =?utf-8?B?djVUWENRZnFvRFR6eDZiMmJEZlpaNlNXaUNnWFpzOExCeU9oQ1lyM2tyMFlQ?=
 =?utf-8?B?TEo4NnlOUlg1V1ROL0Eyb0VQenpJUlFQWGFGUW1VclpIVG5ZSjZsVksra1Fp?=
 =?utf-8?B?S3hsWUZsOUlIb2svYlJxRGRGQ2dSZjF3MEk2eHNJeGZaaW9NWkZPdjBPWmtv?=
 =?utf-8?B?VkFJTUlyWTdUeDZmRjRKT0gxUlNnZ3JIRHVVaEpLUFF1TklIMFVUaEt4ZTJy?=
 =?utf-8?B?WmdvT0pMendXbE81c3JsZmZNZzBhVnBUNnpoK1ZyUitSQTQvM1ZRbkJhNGty?=
 =?utf-8?B?TUp1RlZjeVNXc0p0cW5LTHA1c21NU2hCeE5kWXM0bjBxQjdIQm1uY2RvZThU?=
 =?utf-8?B?RW9wUG13OU00a3NRTkRLd3QrcDlEZXoyRThIOEQ1SUlweWdsZkZJQ2tMaTVN?=
 =?utf-8?B?U2dGNHRzSU5vQTU0eTJTVGJXQkZpSFo1Wk9EOXpscEM3ZWJvWFRrYWNvVm1O?=
 =?utf-8?B?ejJaQ2g2KzJSTVdwYVdRTmFLZUdmS2Ryc2ZoWjdCR2Q2cmNZSHpMZ2ZqdnJi?=
 =?utf-8?B?cUMvUTBZRUZ1MVFSbnBLR0s0ZkhYY1k4WmVJVFpXVFp6aGtxbExzWWxjQ3Vm?=
 =?utf-8?B?ZmRpZEpGN0tLOE1SV0YzcjJUNW5wNEJ3ekpGZjBvZldWS21mZXZTZDh1VHF6?=
 =?utf-8?B?cnpqSC9jZHVIdzY4Q3hwcjZBVnRQL1BhRUo1cU9tWEhjemZNOGhGQkxZNGRu?=
 =?utf-8?B?SHJ2eWpha3U2ZDU2MkEzV1hHeG1NSDJiOFliS1U1ZHpDSVRjUWZ2SklCM0tS?=
 =?utf-8?B?RVZWUnpYM3R2dnl3eDNzRW1mNlJqbzVucEtFMXE0YThGYnUxcE5QSFZjRWVa?=
 =?utf-8?B?YkRRQUIzaFdJbzQzZGN5ejU4VkJieEhhZVIwUXNkNk1uTmNITW9JcENnV3V5?=
 =?utf-8?B?d3RzeGlKRkNDdmRDWG5ORStLZEdnUFdIMDFuZWpITU5VbENHcENGa1lMOENO?=
 =?utf-8?B?ZlZxQUJIOVFWeEdTejUwWitQbkV3T3VtdDlQN1lNRGEwTTFNd3VDVnhUQ2Jq?=
 =?utf-8?B?N21nWVYvV2ZWUDhhK0pWMEhVS3g4a2pQekVTcDhuVFBTUEozcDVMYzBJTklT?=
 =?utf-8?B?SkhsRFhxOUY0eVdYUDBtNkFYbTJna1JVQ3BXTDRIYUl3OU1mRk0xWi9TV0s2?=
 =?utf-8?B?V3F1RVpJcUxtQ2dKZHBEdnBkeW9SdEtwaEpMMEZSMlFkVjdyU0hXQ2M5aGpT?=
 =?utf-8?B?VGhuSWtPT21pQndDUUh1U2RlNnY4a2t6eG9hYS9iYzVDTjZIaTllL3FDdlRr?=
 =?utf-8?B?L2tGbHZhUWJjNDNuQ01PQVVvdHBBYWRBUXlNRzh6NWxYekgwQ25DR2s4OXhR?=
 =?utf-8?B?K0hZcTcrVU9mM21tOU1rVTN4ZWR5YjVJb1Axc2ROQzZhUURLUUV6M2tHRWw5?=
 =?utf-8?B?cmlNMzdyNWdKM2VsVUtzakZTOVdnWEJoRnU5VC90MHYzODIvQnFzRkt1ZHdQ?=
 =?utf-8?B?TDhSMUlCZEVBMTExQlJNOWFSOE9pN2psVTluMnRJd1hrdzk4Q3QxYUFPUGVE?=
 =?utf-8?B?NEFQNXlGYi8rdGNrTmNDNnhNNXFwYnhWVUx3KzQ0b0RYK0toaXRTOFZnQ3E5?=
 =?utf-8?B?cTMvclFiNTUxVWlOWmJrQmhmM1JuOGlrYzNoa2xRcFVranNMTHZUN21tVVc3?=
 =?utf-8?B?ZzBUNGpjRXBDSTd6NmUrbEhtSnp1QU1hV2lXZmk5TWw1SCt1Ti9WT0pha3pr?=
 =?utf-8?B?NWdiZjI5SVVGZ0lVRmlMZEpuaDRicTd5RkV5Vkc1TFFUMllITEppQUJvY2hE?=
 =?utf-8?Q?BIRFBD/Qv1Mx+jcUpQ9I6CF6S+gREsR+d/8UTgeOZc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c1b7d6-f381-4d3f-02d2-08d9d1469411
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 18:58:51.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZXfhxhtsoI4O9qJGloIgmdhxc/h69SZ20iynTA3vQTWDnIoqgr1CfEYxSuXFBkbw3ma8YCM/twx4Pm4ZCRihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Got it

See bellow one small comment, with that the patch is Reviewed-by: Andrey 
Grodzovsky <andrey.grodzovsky@amd.com>

On 2022-01-05 9:24 p.m., Shi, Leslie wrote:
> [AMD Official Use Only]
>
> Hi Andrey,
>
> It is the following patch calls to amdgpu_device_unmap_mmio() conditioned on device unplugged.
>
> 3efb17ae7e92 "drm/amdgpu: Call amdgpu_device_unmap_mmio() if device is unplugged to prevent crash in GPU initialization failure"
>
> Regards,
> Leslie
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Thursday, January 6, 2022 2:22 AM
> To: Shi, Leslie <Yuliang.Shi@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: Unmap MMIO mappings when device is not unplugged
>
>
> On 2022-01-04 11:23 p.m., Leslie Shi wrote:
>> Patch: 3efb17ae7e92 ("drm/amdgpu: Call amdgpu_device_unmap_mmio() if
>> device is unplugged to prevent crash in GPU initialization failure")
>> makes call to
>> amdgpu_device_unmap_mmio() conditioned on device unplugged. This patch
>> unmaps MMIO mappings even when device is not unplugged.
> drm/amdgpu: Call amdgpu_device_unmap_mmio() if device is unplugged to prevent crash in GPU initialization failure
>
> I don't see the 'call to amdgpu_device_unmap_mmio() conditioned on device unplugged'
> part in this patch
>
> Also, please add 'v2:bla bla bla' part in patch description telling what was done in v2
>
> Andrey
>
>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 12 ++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 +++++++++++
>>    3 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 412f377f80b1..16dc16c860cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3832,6 +3832,7 @@ int amdgpu_device_init(struct amdgpu_device
>> *adev,
>>    
>>    static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>>    {
>> +


Drop the new line

Andrey


>>    	/* Clear all CPU mappings pointing to this device */
>>    	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>>    
>> @@ -3912,6 +3913,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device
>> *adev)
>>    
>>    void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>    {
>> +	int idx;
>> +
>>    	amdgpu_fence_driver_sw_fini(adev);
>>    	amdgpu_device_ip_fini(adev);
>>    	release_firmware(adev->firmware.gpu_info_fw);
>> @@ -3936,6 +3939,14 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>    	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>>    		vga_client_register(adev->pdev, NULL, NULL, NULL);
>>    
>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> +
>> +		iounmap(adev->rmmio);
>> +		adev->rmmio = NULL;
>> +		amdgpu_device_doorbell_fini(adev);
>> +		drm_dev_exit(idx);
>> +	}
>> +
>>    	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>>    		amdgpu_pmu_fini(adev);
>>    	if (adev->mman.discovery_bin)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 156002db24e1..ff9dc377a3a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -33,6 +33,7 @@
>>    #include <linux/slab.h>
>>    #include <linux/dma-buf.h>
>>    
>> +#include <drm/drm_drv.h>
>>    #include <drm/amdgpu_drm.h>
>>    #include <drm/drm_cache.h>
>>    #include "amdgpu.h"
>> @@ -1061,7 +1062,18 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>>     */
>>    void amdgpu_bo_fini(struct amdgpu_device *adev)
>>    {
>> +	int idx;
>> +
>>    	amdgpu_ttm_fini(adev);
>> +
>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> +
>> +		if (!adev->gmc.xgmi.connected_to_cpu) {
>> +			arch_phys_wc_del(adev->gmc.vram_mtrr);
>> +			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
>> +		}
>> +		drm_dev_exit(idx);
>> +	}
>>    }
>>    
>>    /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 367abed1d6e6..ea897feeddd2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -42,6 +42,7 @@
>>    #include <linux/dma-buf.h>
>>    #include <linux/sizes.h>
>>    
>> +#include <drm/drm_drv.h>
>>    #include <drm/ttm/ttm_bo_api.h>
>>    #include <drm/ttm/ttm_bo_driver.h>
>>    #include <drm/ttm/ttm_placement.h>
>> @@ -1801,6 +1802,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>     */
>>    void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>    {
>> +	int idx;
>>    	if (!adev->mman.initialized)
>>    		return;
>>    
>> @@ -1815,6 +1817,15 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>    				      NULL, NULL);
>>    	amdgpu_ttm_fw_reserve_vram_fini(adev);
>>    
>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> +
>> +		if (adev->mman.aper_base_kaddr)
>> +			iounmap(adev->mman.aper_base_kaddr);
>> +		adev->mman.aper_base_kaddr = NULL;
>> +
>> +		drm_dev_exit(idx);
>> +	}
>> +
>>    	amdgpu_vram_mgr_fini(adev);
>>    	amdgpu_gtt_mgr_fini(adev);
>>    	amdgpu_preempt_mgr_fini(adev);
