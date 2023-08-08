Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C11C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 16:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9F010E15B;
	Tue,  8 Aug 2023 16:27:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BE810E15B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 16:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqlcYxY4oFZ6McCTC5Ux/l/M7SE6sl6GW4wZ4w5VBgp7vm+LIa0qfLxvxSi6MG6czFkwiQ/RJUdi7QaGS1htB2Refw4fc1VLm5/0/BO6o0Hbv3x62dZqKnFrvtwQTKWjuvnUM++6jSinxu2nk5bqhrCxgxMQocELjUlzodfimdI8l9/Zxc3WfETVMq5jllPR/1XDpnFZWuAsBSPkli06aKLYvyh9wmATksx9oUa3+ACI0PfessKu48SUiYnm4RgKhRgzqzfl0kmNauWIITQS6Us+Wn/E+58pciVcGOVnPcHS/6lsWlkW/sMQ8hl6MIDjd4DYJu23K6OISnKWMhk2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PAKDCK2wlDNQCSogJNF1xg68bgGQ1wnoxMPAMIK8lY=;
 b=dsAutcqJEPopOLaAI1bbD4nOHXKcZS31pvsTEfyei+iuMict978Fk3dlOhBcaqDUjNVs26AQjZkbBxMtGNT6xSdmtdQVPxPg34Y+XaHzE4M6CSoICYH5HSFt1wI4+TW4rW9yvA5aG09zBvDaPvdu5vi7EtH7yLT50MBHn3TOW2LenXPKqO6hGPzNskAeXMZdtqBjmS/zuH0xeLZxlgqubIbwiK61siYzvW7Ry+0LGAeUtN5DUk1B9r8E+6iuLRQa5rPylmvXjnqqEOrmu+VXv+Xo3n9cH03eEi/LVkUpQpNQUeBogzLCw4qckeXfpqptRBEg6lGG2Dp/UhomGtLXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PAKDCK2wlDNQCSogJNF1xg68bgGQ1wnoxMPAMIK8lY=;
 b=HtW4FfGhLkUWnBeUqB68wm59cGL6p8YLgh5XEV36M94TkIhtlxTRJIrGtLQ0Jm/02LsZQRVQ8R5poRrAb/L4o/vlrgQYucSZ0toxdfdtqgAgK+CROd2rDwVaa9vMIgMtJfcGcUDfLhcDRsIQdPOaKASqEaki+j97dh3U7AcUZFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:26:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:26:56 +0000
Message-ID: <44795e1c-b82b-48ed-9c8b-fd85df2470b2@amd.com>
Date: Tue, 8 Aug 2023 11:26:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: fix debugfs access for discovery blob
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230801201515.26789-1-mario.limonciello@amd.com>
 <CADnq5_Pwn6r3FZPtz9CeSr-M1Bhey8SF2ojDa09yeneL6e9=nw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Pwn6r3FZPtz9CeSr-M1Bhey8SF2ojDa09yeneL6e9=nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:8:55::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 804a3d6c-13b4-44a1-370c-08db982c4851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mh2dIeNhLSZrVdg6vSSeyqUuM2GU3sh7Ad4ZBlUzH31uv5fDMfOOXWFAAvCoZ90EZHABf1eizpPdOnqQY8ZzDDiagwOUrlN7LBevq35bAhKg/ttmjjA3oZ+DPVmLhdnlPV/VeaYZGGULc75puvGxuvD6ErSjeeXJmii4MinmyrKd5ylwid1jwVcY8xQjZ20dDm6BbtmCebbWt3CVSFDoRpiPrWpyh6ByVlhbh7+8RMpM3zskqcsO+g0W7P1sL3Zb+EZvCwQjrAHKMbIAsjZ6XF8bgzAEKY0Zv3ZgkiaTS1EcOUq1bg24HwRU18zxuq2MqvRYpdfzH8xj+0LhR7Y/fGl/3e0/q+libJGy11ghVC2BOXSI0rX0iTprf6Ix1+HCVg4A/WyPLJivU/oomrYX4iA6UoqdExOiYJqsywJLbhnJqnUQjJ9NE08Q3rv8nQd/nYS6ASMJaxhMhFZOYvY2HzOXjruUXe6maXh6BjYkG2LmkEk/7iZiDAvcVauhGrByAayPNXMhOkRw6uq55K9107hLboHufKTazDw8RGbr+ZehKPyr9aslS692SKMTnw67ChQj+gV0GDs5Gj8JOQui/T+MgBOCkw8SOMglDUbQshHQfGYlxlmHlpDL6R5v+5IY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(186006)(1800799003)(451199021)(2616005)(6486002)(26005)(36756003)(6506007)(53546011)(6512007)(966005)(478600001)(38100700002)(31686004)(66946007)(66476007)(66556008)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(6916009)(83380400001)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNNbWpGTUN0bjR3cVBaVVkvZmozZllkMHRiMnNPaGtkeEFWeGxWdlBsTkpV?=
 =?utf-8?B?U1ZJZTcrSEV6dEkvNm1HN2EzRmx0S0tFOHdzYlFDdk1jZlRpejA0Wlh2QkJM?=
 =?utf-8?B?TXNISjNrMHBFZ1hXMXA2VmlkWG5sbE9xTks0MEdmaWR0WWlqT2RiQkUyTVcz?=
 =?utf-8?B?Y2pXVDFJTEhMVkZETXpOSzF6SjA3MlZhRE9xUk1mY3IwODkxQk45djRGWWFV?=
 =?utf-8?B?a3A5SkJTb0p4OXpmckE2ZGJBY0NIWWpKblI5R0JDSlk4ei9EbHNXdzYyMmhp?=
 =?utf-8?B?VmVhdVBnT2tZdU5tbXV2aVdIQ1BSYlk3eU1qQnFvaDJnZWhnTHhjWEk0VXln?=
 =?utf-8?B?aERkS2NzVkJUSE5MbkRldjUwTnYzUnZ2aDRiRkhsa2FMbkdHUDVoSnFyYmtZ?=
 =?utf-8?B?ZUFwYmVEQTcyTHhDWDdDdDlmQWJJSFM2UUVJSWx3NDFUYyt5OEtPK2s2blRK?=
 =?utf-8?B?MHlWS1BZbTVYTUxYYjlNdmNzV1h3Mi8wUzRwNG81cEIwdDRFZFNOekxZd2pT?=
 =?utf-8?B?Y0F6djZISFVUdTRWWjNSaUtxWEtMVE9nUmZQR0lUaEZNaDh1eUVFMzZQK3Q5?=
 =?utf-8?B?NjJ6N2Y2Ni91Y2JVZnJNZ3Q5ay9IVCtqYTlVR2R6d0t5MTRzZVdKT3AxdmhT?=
 =?utf-8?B?cnMyN1BIc1BaV1NQLzRKbXhYSDRuZlJpbTQyU2VZY3dqSHJNMjNzYXppMkpM?=
 =?utf-8?B?OEk4U21yUmU4VEZBUmVNNy8ySGJ2bTR2REowMmQ5RVlIdVJ0czg4UkJlUmlO?=
 =?utf-8?B?WVFZZXY2MnF0QXo0SjNCMFZsV29Lb1lqbk1sTnpDcTExNTBCRmUyTTU0UXI2?=
 =?utf-8?B?SUwvTkphV1VmZEhrK0s2ZEY2MzRTSzlaSlp2N1RuaTMwSWdxUmNiSTdjZTR6?=
 =?utf-8?B?clFoYnNrTEZhK0NoRjhUQVowaTlHUHE2bG5HdXQ4dzN0bWRwbTR3dlNFNEMx?=
 =?utf-8?B?d2tpeDg1T0I1UlRmRzNjNEgvcHlQaE1oZ3RMek5XditHNXNKWE1xZ0JXYmI2?=
 =?utf-8?B?d3pYSHMzSUt0M2JkdTlEM2w3Wk5RUFYyWWUrWUplVjhKdlFlYlczTkhmVVEr?=
 =?utf-8?B?NnRiaEExbk9tUjA5NThxNWp1bk5rUUFLK1ZDVzlmeER2SVJ6YnIxSlJjdG8y?=
 =?utf-8?B?TVVUTnhORndFUFdKeksyRFZGbWZrZUdOKzd5VEs1TVhnZXZDWDJCc1ZpQm1Z?=
 =?utf-8?B?THMrYzhHakQ1Q2I0OXZYQTZwWXJKQVNqdUtRY1FZanlhNG50TDdJREV0NGJx?=
 =?utf-8?B?UVQ2dVUyMXZmTjJXT25KcVdOR1RHbjN0U1VqY05qL3g1R052eCtwYVRxU2M0?=
 =?utf-8?B?WG5RbG15QnA2anI3R2dUaUN2bjBaTUhnRS9HLzJWNU8wTW9kUVg5Wll6Y25t?=
 =?utf-8?B?Tm16TlVCZzNWOGlOWmdiMW1uTmhkbnYwYmZHQVl0UmdSWnlnN1RFem5yNHB3?=
 =?utf-8?B?cWliUU95VnREVFlwU3M4a0pHeDFZS3E2Rm5UVmNONER4bHEreU95Y08xWGpk?=
 =?utf-8?B?WFM4NTFIV0MrdHhJZXc1ZHJYYTVoVzlvOVk3NmNaQTVHU0pnc2ZDcm1kTUhP?=
 =?utf-8?B?ZEVuaVdJVDdocS9NNmdkQ2pVbDdZb0p4aGh4aE9CM2xUUjN3OWNQQ000SGpt?=
 =?utf-8?B?MmdNbTdvSlpwZ3Z5bVZrNk9vZ3FUSHJKUjdXc2NHcmF4dVEwSlVRZUY1WXFH?=
 =?utf-8?B?RXBKUnRVRW9hcjVqRnk2dFNyenVYRXVzSkhESTg4UDJGY2VnN3ZUT3ZhSE5a?=
 =?utf-8?B?RlJjdW82eEZjTGZTSFJmMVZZck9LbU1SWk5JemwraStwU2tVbDRDSGZpZzZG?=
 =?utf-8?B?elVwTzB0VmJXUXhVNUpNcVNGRm9qanVIdVlaT3ZWdTVNT0lMWDM0dFh6Si8r?=
 =?utf-8?B?cHVxNDcrSlNJTXQwRW43TU5XMGpjbWRQU29xMGxaYWZ5OEc0MXBjRU41YzZa?=
 =?utf-8?B?TDFSTG1qT0w2cFVzOFVMU3B5V0NDY1ZtOGViVCtJMmFycitWRXNiR3drTTdR?=
 =?utf-8?B?b3U5eXBzV3RHQk1IaDYrQW1uUktkQ2ZacUh3RkVkUUhqK25BNVhMc1V1bFhL?=
 =?utf-8?B?UFgrRHlSSk5GdVhuWmVZM1RSSGpzQzJNc1Nzc1NRcXd5RHJwN3FwQnJyK00w?=
 =?utf-8?Q?FdMwpXnSSUAitcUhrMMU39SU1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804a3d6c-13b4-44a1-370c-08db982c4851
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:26:56.4270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfiRxDEZc1s7UaBmEmqOmzQfSqZ88RuzBqJqp2MoPQteOYv369Y28cEJrsIUARQvZj8+pstwPk6BobxWfV/Xsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/7/2023 10:20, Alex Deucher wrote:
> On Tue, Aug 1, 2023 at 4:15 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Accessing the blob for amdgpu discovery from debugfs triggers:
>>
>> [ 1924.487667] kernel BUG at mm/usercopy.c:102!
>>
>> usercopy_abort() explains that it needs to be solved by creating
>> a cache to store the data.
>>
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748#note_2023519
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
Although this avoids the issue; I've concluded it's an inappropriate fix 
and will abandon it.  It turns out to spit out 64k discovery blobs that 
should have been 8k.

6.5-rc and ASDN already picked up a better solution.

db3b5cb64a9c ("drm/amdgpu: Use apt name for FW reserved region")

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  7 +++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 17 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 ++
>>   3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a3b86b86dc477..66a2251bdeba4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -791,8 +791,11 @@ struct amdgpu_device {
>>          bool                            accel_working;
>>          struct notifier_block           acpi_nb;
>>          struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
>> -       struct debugfs_blob_wrapper     debugfs_vbios_blob;
>> -       struct debugfs_blob_wrapper     debugfs_discovery_blob;
>> +#if defined(CONFIG_DEBUG_FS)
>> +       struct debugfs_blob_wrapper     debugfs_vbios_blob;
>> +       struct debugfs_blob_wrapper     debugfs_discovery_blob;
>> +       struct kmem_cache               *discovery_blob_cache;
>> +#endif
>>          struct mutex                    srbm_mutex;
>>          /* GRBM index mutex. Protects concurrent access to GRBM index */
>>          struct mutex                    grbm_idx_mutex;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 56e89e76ff179..55ea5be14b188 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -2180,7 +2180,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>          debugfs_create_blob("amdgpu_vbios", 0444, root,
>>                              &adev->debugfs_vbios_blob);
>>
>> -       adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
>> +
>> +       adev->discovery_blob_cache = kmem_cache_create_usercopy("amdgpu_discovery",
>> +                                                               adev->mman.discovery_tmr_size,
>> +                                                               0, 0, 0,
>> +                                                               adev->mman.discovery_tmr_size,
>> +                                                               NULL);
>> +       adev->debugfs_discovery_blob.data = kmem_cache_alloc(adev->discovery_blob_cache, GFP_KERNEL);
>> +       memcpy(adev->debugfs_discovery_blob.data, adev->mman.discovery_bin,
>> +              adev->mman.discovery_tmr_size);
>>          adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
>>          debugfs_create_blob("amdgpu_discovery", 0444, root,
>>                              &adev->debugfs_discovery_blob);
>> @@ -2188,6 +2196,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>          return 0;
>>   }
>>
>> +void amdgpu_debugfs_fini(struct amdgpu_device *adev)
>> +{
>> +       kmem_cache_free(adev->discovery_blob_cache, adev->debugfs_discovery_blob.data);
>> +       kmem_cache_destroy(adev->discovery_blob_cache);
>> +}
>> +
>>   #else
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>> @@ -2197,4 +2211,5 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>>   {
>>          return 0;
>>   }
>> +inline void amdgpu_debugfs_fini(struct amdgpu_device *adev) {}
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 0593ef8fe0a63..1a3b30dff5171 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2276,6 +2276,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>          struct drm_device *dev = pci_get_drvdata(pdev);
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>>
>> +       amdgpu_debugfs_fini(adev);
>> +
>>          amdgpu_xcp_dev_unplug(adev);
>>          drm_dev_unplug(dev);
>>
>> --
>> 2.34.1
>>

