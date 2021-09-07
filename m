Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BA8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 22:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFDC6103E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 22:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DFDC6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777216E0DE;
	Tue,  7 Sep 2021 22:20:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8181F6E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 22:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuBuK0ushGbOKMkMdt/pQks6Q10LQIVLFEgMU+K/1PQb41jEZ6OgJZVYN/ZLIOftfElivXDsTlX6fJdg+TBOoaptIWjQtsxbnpATL2T+ZN4ON+V/S1eoiCnY6SMqUqrzjGx6GVsY6aPjgcWaVYeycf7Dux7HVef8zcrJj00q3amTM2qHzhR71xCrkKEqqt0/3jSX6NiRZL3/Ejf5iP8rzdtQy4xiuSRkUkJrVmCX/iMX4G+bK8A0L/Rrnvsfc2wITS31KpMxeOZPI+j97JkKHBgqq8gSNQwoyGTXgJWnpnG3nRNb3Kffw7wOqSnEEzXHo6CjIJfAtErll0Z4UrGEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NE55jqpvvSQ44QPPBTzJeb+jt5SGYJl8rT/WPYHETOE=;
 b=NglzboQ8IrrTs+Ed2E+DIr5IuA8+BnIRiV57XNQOnJjSoZ/ErLuqcMi7ZukJqEfQqdjpWNERacjJL6HJP3v9KRS9DNptmSmNfcTlxAMeUwCjrdvDYiH48Rfk1q1oZyKKcYtuYVMMPTW5yWIptBn+vuxUFJmBKs64AtVJSrdcbjVD9GY0bSRb1x/AJ6G4kOasjPaZp5xGp/O6FGDZKvq0m3f5yFg19Mr/JzWaLP8+9XY+KQ06zfJaSYmaiHD9Kvson+PUE746j7AoSqUhQHJahfC98Fvve9m8ujXN9tL/yQo0t4/3BL+Qf70RWFP1rmU8MkAPDtkFPC/oJgJKz1AcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE55jqpvvSQ44QPPBTzJeb+jt5SGYJl8rT/WPYHETOE=;
 b=G5/7yvzrrKDBgOTZvct3ibj3CKd441ptcGCnSNOdhoebSy5VAdiFMlqPdHWJHN4cDLjfJKXjg23IqE5NMFd8waDsxCu+SCTf1WUQytXRyCCbJDrGZhLfH/itrv+BoMuatXTWXdBhS/J8hkpP3rjbmA5frUP00exySWRPstF0wkw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 22:20:16 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 22:20:16 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
 <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
 <3c196bbc-3799-44ff-d5f8-ade4ada89d93@amd.com>
 <ac2bef7a-d70c-8ede-bcca-d8e27a8fdcb6@amd.com>
 <48cdc3d9-341a-2415-ddfd-fd3b31228000@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8d26e2ce-5161-60fa-9c0e-3a87431f57e7@amd.com>
Date: Tue, 7 Sep 2021 18:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <48cdc3d9-341a-2415-ddfd-fd3b31228000@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Tue, 7 Sep 2021 22:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a6606a-1e45-48f5-8527-08d9724dab57
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5308A06257757ED20C8E7EAD92D39@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Btij9mJI6isLvR5A1poEd+O1HkBNPU8CuGPVaqKyrr5PvAzncLJ+/gCbshk0Q1T1ej/fGpWDefH8jrk+QTDJnnDKt3jUK7Cm7TyxiVqyOQsVuDROmAJ6zp1N6P9Rh9FSsJOezgTHAtFf5cHte6xlcZ54LnLrNNk5diIezB8peabH99JV8maNMIRBnS15vVFqD0TKPRXteHQhNlGEmGVBM5YdtyfeQ/Bff0JCejQmBmYcvSTVpPytBMV0NaisEhBHuQt1MaxFrkUDZV9ZF0bK2U8K5BIL9n4wEYyQphkmvTuBA4OONrl5ht5UM6OzGC8EyEXbfU5yQ3N8DowM8MrYmF4N5uw4GnJLA7fqm3Cbobr5B3KTm9Mn8Mlwj1H7rrUYD9mTaIJtkFaiCjmYIkRf+Bge/LlJnLe1ipqLTKYTyuIynL/mUuwXJN485VjBL97wOfsTp5Zk2fmrqlFi7izNKpItEf5bo7OwY3xKhQogOzCpqhvGbJhS3TyQXHrL274lMjvS7twabX3X/zEMRK172aPmBLBljcgqsfJqEnPj0BwlBS12YLq6J5a5cphxOQkHI7xCNrM1IMRUWbl3kwClL8Q0Zn/Rz2yKbndlfjpIe5B+lcLX0buF+dxejbv8n6hzJp94E9gjTlK76A0cLhTh8q2FEiUviFXBQhO/fBQStkZDqsoLgsVr1FPa7AIGeORhlfuSzs9gbsMWQlBgbif5a8tjN2lnOiyjAfzznLuS+d9IQe+bfXFNY+rLnJNbxHWSSgdwvHMVecVv0kHezBkNgXjBxn8dLUJRXnpcLLrLmA4J0Tx+RYJITskGKAeNnWGg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(66946007)(2906002)(66556008)(16576012)(4326008)(86362001)(110136005)(30864003)(38100700002)(478600001)(966005)(6486002)(31696002)(5660300002)(8936002)(31686004)(66476007)(8676002)(2616005)(956004)(83380400001)(44832011)(53546011)(36756003)(26005)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGcxRFE5amV5NjcxbVBrbUFxQUt4ZlhYbUN3bFFVTkUyRHVBdU80MmttNXE5?=
 =?utf-8?B?bjBxWEUyUTRINHVPVDZNNlVhZHlxV25mWStJTzZUUllwMWdkalRhek5RN25i?=
 =?utf-8?B?alN0dlE5dGJNQmQzVGY3UmxWWmlCUHZNTFRFVHVMRGlHczF2eEZVSVIxcDB2?=
 =?utf-8?B?RnBsRTcxR0ZWWTY3T3d6NmNKUldzQ0ZvU0tpTWRFYnZQWjg0dXZjb1Q1Y00y?=
 =?utf-8?B?MEhmYnhSM0tzQm5Kb09TdlFySW1iMTVoaVQ2M3FiSzBoaDBJOFoxT0NJMTc0?=
 =?utf-8?B?NDBNVGg3dGRDQ2FHd2Zua29GRHRRTnlIZTE5MCsxSEt1ZzN2cU13TVJrOVpN?=
 =?utf-8?B?Nkp0MndaS0dnMHFNU0tJUlY4Y0Z4cFExcjhyRHFRQkNEeS9jdnJxbkhjQi9Y?=
 =?utf-8?B?L1dRcGhtdlpId1owZGNmUEZDWmtFNTRvcmN4OFc3K1gzL3FqUExLbnFWMk9y?=
 =?utf-8?B?SHphRzRsd3dkOHFYUDkwRE1pVzdCcHk0SmU3ck9CelIwZmVSR1hud01VZ0Mz?=
 =?utf-8?B?QXdWNkdVSkU1R01TMnZvS1lSOEVJQVhtajdSRzJQUjZZWHk5UEx4aVEvRkp2?=
 =?utf-8?B?SFBsN2s5L0I1Z1BzYmppVVltbi9nSFZYcm9sdnlFOWUvNGEreWx5WHBsODRG?=
 =?utf-8?B?bU5oT1g5NzFpVFV5K2VCL0VLUHJPYTZLd1NLOXFrSFNBYmgrdkJHUEk1TEJY?=
 =?utf-8?B?dXk4RWZjcnZsUExvdlhyUFJCS3U4SG5NNFRIazVGZzFydG1QZXRHMEQxWC9o?=
 =?utf-8?B?S0lwSHljTWlENEhyQjRmS1gxaDM0VzBFUFZuQUkrV3dsbHNvNW5JVjFLd0VG?=
 =?utf-8?B?S014RFNDaG5FdFYrVFBxSVFOeEFGbDBYNUoxZHQ0Z25uWkREVTdySVZZUmlt?=
 =?utf-8?B?SDJIYVFZcFg2VXF3MG9Sa3FzbW5kZS9FMExPSVhWeEl2aDBzMFdTejhqTlRR?=
 =?utf-8?B?aHRFZzBjdkVFb2s1K01DVmlJQ3dnSFRtbnlXMjR3UktNelk0cFhiK05FZnU3?=
 =?utf-8?B?aXBab1NvTk5YQzFiaHV6dEZISUpZd095ZVU1SlI1UXhwbGxuTFJDaU01UXVp?=
 =?utf-8?B?eVhNeFpXS0pCOUVqQmNRbTlTUE1DSGtTVnNtdlA1U2p4YUF1WjMvVDdneHZq?=
 =?utf-8?B?U2lBdERtamF6dC80R3I5MTE5SlpuMVdvL1NKQTRpd2RGYWIwYnlPQmlmaGVN?=
 =?utf-8?B?ZHFuRVZlMCtidW1tNUY4Tm1zVDhkUzk0ZlNvQW5lN0w2L1E4WHl3aXJMc083?=
 =?utf-8?B?OWp2UzlORmRCWTlESTBZT3VkbEZJLzVaU0o5UWJic0R2c0EzQUFqc2VYVEFn?=
 =?utf-8?B?QlFiZXdlN3dpUVcvODIvNE5KbC9BOStuSjhWajFmUE5DeXRLbGM4L3JieG9W?=
 =?utf-8?B?UHE1TDJOeXJSOTRpMml1K0dXYzdweldpYnM4QWR6MlZVYjhvUG5xNVczdy81?=
 =?utf-8?B?SXEvdC93RHJGaXF1SjBQSk00MkpENFk3Z2hLaWk3V0RxRFJlSnpGUjhKVkNu?=
 =?utf-8?B?YjBpcXdxaStYOTk1SU5mdEx0UjJYdEFCVE9VeUxUVzRwZ2dEMzdGNXVLNUhB?=
 =?utf-8?B?QjRXSy9oMXR3ZlhYS3RHWVFBVHZ0MHZXYnVoOUNOV3ZHR2M1VlZQckViaTE4?=
 =?utf-8?B?U3BHOWhCUFk4K1lWZ2RZa3ZzamVUamZpNDFkeUozdkJlUFhmaGRjcDdzUVZy?=
 =?utf-8?B?QVZlRjBXYVJmMi9oTU9UR2RVU1lKMGoxeVkvaHdIVk9LckQvQWVpVXNpTDZE?=
 =?utf-8?Q?G9lxrpHSHU7IrwZy2MrGo/ibQRV29qhDr71p643?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a6606a-1e45-48f5-8527-08d9724dab57
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 22:20:16.4603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcA6mC7AjR2SPIoRwROeMywG2zcReJXburbCNiSY5CXID4Ht9SQgKo3AeV+FRhRn1SW2nK1z7sXKj4XuwgbzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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


Am 2021-09-07 um 4:30 p.m. schrieb James Zhu:
>
>
> On 2021-09-07 1:53 p.m., Felix Kuehling wrote:
>> Am 2021-09-07 um 1:51 p.m. schrieb Felix Kuehling:
>>> Am 2021-09-07 um 1:22 p.m. schrieb James Zhu:
>>>> On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
>>>>> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>>>>>> Separate iommu_resume from kfd_resume, and move it before
>>>>>> other amdgpu ip init/resume.
>>>>>>
>>>>>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
>>>>> I think the change is OK. But I don't understand how the IOMMUv2
>>>>> initialization sequence could affect a crash in DM. The display should
>>>>> not depend on IOMMUv2 at all. What am I missing?
>>>> [JZ] It is a weird issue. disable VCN IP block or disable gpu_off
>>>> feature, or set pci=noats, all
>>>>
>>>> can fix DM crash. Also the issue occurred quite random, some time
>>>> after few suspend/resume cycle,
>>>>
>>>> some times after few hundreds S/R cycles. the maximum that I saw is
>>>> 2422 S/R cycles.
>>>>
>>>> But every time DM crash, I can see one or two iommu errors ahead:
>>>>
>>>> *AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=****
>>>> flags=0x0070]*
>>> This error is not from IOMMUv2 doing GVA to GPA translations. It's from
>>> IOMMUv1 doing GPA to SPA translation. This error points to an invalid
>>> physical (GVA) address being used by the GPU to access random system
>>>
>>> Oops: s/GVA/GPA
>>> memory it shouldn't be accessing (because there is no valid DMA mapping).
>>>
>>> On AMD systems, IOMMUv1 tends to be in pass-through mode when IOMMUv2 is
>>> enabled. It's possible that the earlier initialization of IOMMUv2 hides
>>> the problem by putting the IOMMU into passthrough mode. I don't think
>>> this patch series is a valid solution.
>
> [JZ] Good to know, thanks! So amd_iommu_init_device is for v2 only.
>
> And it is supposed to be safe to do amd_iommu_init_device after amdgpu
> IP init/resume without any interference.
>
Yes, it's supposed to. But with your results below, this is getting very
confusing. It's as if the IOMMUv2 initialization has some unintended
side effects if it happens at the wrong moment during resume. If you
want to debug this further, you'll probably need to work with the server
team that's working on the IOMMU driver. I'm not sure it's worth the
trouble.

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>>> You can probably fix the problem with this kernel boot parameter: iommu=pt
>
> [JZ] Still not working after apply *iommu=pt*
>
> BOOT_IMAGE=/boot/vmlinuz-5.8.0-41-generic
> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
> modprobe.blacklist=amdgpu *iommu=pt* 3
> [    0.612117] iommu: Default domain type: *Passthrough* (set via
> kernel command line)
> [  354.067871] amdgpu 0000:04:00.0: AMD-Vi: Event logged
> [*IO_PAGE_FAULT* domain=0x0000 address=0x32de00040 flags=0x0070]
> [  354.067884] amdgpu 0000:04:00.0: AMD-Vi: Event logged
> [IO_PAGE_FAULT domain=0x0000 address=0x32de40000 flags=0x0070]
>
>>> And you can probably reproduce it even with this patch series if instead
>>> you add: iommu=nopt amd_iommu=force_isolation
>
> [JZ] could not set both *iommu=nopt *and*  amd*_*iommu=force_isolation
> *together*. *(does it mean something?)*
> *
>
> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
> modprobe.blacklist=amdgpu*iommu=nopt amd_iommu=force_isolation* 3
> [    0.294242] iommu: Default domain type: Translated (set via kernel
> command line)
> [    0.350675] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
> counters/bank).
> [  106.403927] amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_resume
> failed (-6).
> [  106.403931] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -6
> [  106.403941] amdgpu 0000:04:00.0: PM: failed to resume async: error -6
>
This is weird. Is this happening during resume or driver init?


> *iommu=nopt**: *Passed at least 200 S/R cycles
>
> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
> modprobe.blacklist=amdgpu   *iommu=nopt* 3
> [    0.294242] iommu: Default domain type: Translated (set via kernel
> command line)
>
Interesting. That's the opposite of what I would have expected.


> *amd_iommu=force_isolation*: failed at 1st resume
>
> BOOT_IMAGE=/boot/vmlinuz-5.13.0-custom+
> root=UUID=030a18fe-22f0-49be-818f-192093d543b5 quiet splash
> modprobe.blacklist=amdgpu *amd_iommu=force_isolation*   3
> [    0.294242] iommu: Default domain type: Translated
>
> [   49.513262] PM: suspend entry (deep)
> [   49.514404] Filesystems sync: 0.001 seconds
> [   49.514668] Freezing user space processes ...
> [   69.523111] Freezing of tasks failed after 20.008 seconds (2 tasks
> refusing to freeze, wq_busy=0):
> [   69.523163] task:gnome-shell     state:D stack:    0 pid: 2196
> ppid:  2108 flags:0x00000004
>
I've never seen this before.

I think if you want to debug this further, you'll need to work with the
IOMMU driver team.

Regards,
  Felix


> [   69.523172] Call Trace:
> [   69.523182]  __schedule+0x2ee/0x900
> [   69.523193]  ? __mod_memcg_lruvec_state+0x22/0xe0
> [   69.523204]  schedule+0x4f/0xc0
> [   69.523214]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
> [   69.523225]  ? wait_woken+0x80/0x80
> [   69.523233]  amdgpu_ctx_mgr_entity_flush+0x97/0xf0 [amdgpu]
> [   69.523517]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [   69.523773]  filp_close+0x37/0x70
> [   69.523780]  do_close_on_exec+0xda/0x110
> [   69.523787]  begin_new_exec+0x59d/0xa40
> [   69.523793]  load_elf_binary+0x144/0x1720
> [   69.523801]  ? __kernel_read+0x1a0/0x2d0
> [   69.523807]  ? __kernel_read+0x1a0/0x2d0
> [   69.523812]  ? aa_get_task_label+0x49/0xd0
> [   69.523820]  bprm_execve+0x288/0x680
> [   69.523826]  do_execveat_common.isra.0+0x189/0x1c0
> [   69.523831]  __x64_sys_execve+0x37/0x50
> [   69.523836]  do_syscall_64+0x40/0xb0
> [   69.523843]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   69.523851] RIP: 0033:0x7ff1244132fb
> [   69.523856] RSP: 002b:00007fff91a9f2b8 EFLAGS: 00000206 ORIG_RAX:
> 000000000000003b
> [   69.523862] RAX: ffffffffffffffda RBX: 00007ff11ee2e180 RCX:
> 00007ff1244132fb
> [   69.523866] RDX: 0000561199f5bc00 RSI: 000056119a1b0890 RDI:
> 0000561199f2021a
> [   69.523868] RBP: 000000000000001a R08: 00007fff91aa2a58 R09:
> 000000179a034e00
> [   69.523871] R10: 000056119a1b0890 R11: 0000000000000206 R12:
> 00007fff91aa2a60
> [   69.523874] R13: 000056119a1b0890 R14: 0000561199f2021a R15:
> 0000000000000001
> [   69.523882] task:gst-plugin-scan state:D stack:    0 pid: 2213
> ppid:  2199 flags:0x00004004
> [   69.523888] Call Trace:
> [   69.523891]  __schedule+0x2ee/0x900
> [   69.523897]  schedule+0x4f/0xc0
> [   69.523902]  drm_sched_entity_flush+0x17c/0x230 [gpu_sched]
> [   69.523912]  ? wait_woken+0x80/0x80
> [   69.523918]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
> [   69.523928]  amdgpu_vm_fini+0x256/0x3d0 [amdgpu]
> [   69.524210]  amdgpu_driver_postclose_kms+0x179/0x240 [amdgpu]
> [   69.524444]  drm_file_free.part.0+0x1e5/0x250 [drm]
> [   69.524481]  ? dma_fence_release+0x140/0x140
> [   69.524489]  drm_close_helper.isra.0+0x65/0x70 [drm]
> [   69.524524]  drm_release+0x6e/0xf0 [drm]
> [   69.524559]  __fput+0x9f/0x250
> [   69.524564]  ____fput+0xe/0x10
> [   69.524569]  task_work_run+0x70/0xb0
> [   69.524575]  exit_to_user_mode_prepare+0x1c8/0x1d0
> [   69.524581]  syscall_exit_to_user_mode+0x27/0x50
> [   69.524586]  ? __x64_sys_close+0x12/0x40
> [   69.524589]  do_syscall_64+0x4d/0xb0
> [   69.524594]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   69.524599] RIP: 0033:0x7f2c12adb9ab
> [   69.524602] RSP: 002b:00007fff981aaaa0 EFLAGS: 00000293 ORIG_RAX:
> 0000000000000003
> [   69.524606] RAX: 0000000000000000 RBX: 0000556b6f83f060 RCX:
> 00007f2c12adb9ab
> [   69.524608] RDX: 0000000000000014 RSI: 0000556b6f841400 RDI:
> 0000000000000006
> [   69.524611] RBP: 0000556b6f83f100 R08: 0000000000000000 R09:
> 000000000000000e
> [   69.524613] R10: 00007fff981db090 R11: 0000000000000293 R12:
> 0000556b6f841400
> [   69.524616] R13: 00007f2c12763e30 R14: 0000556b6f817330 R15:
> 00007f2c127420b4
>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> Since we can't stop HW/FW/SW right the way after IO page fault
>>>> detected, so I can't tell which part try to access
>>>> system memory through IOMMU.
>>>>
>>>> But after moving IOMMU device init before other amdgpu IP init/resume,
>>>> the DM crash /IOMMU page fault issues are gone.
>>>>
>>>> Those patches can't directly explain why the issue fixed, but this new
>>>> sequence makes more sense to me.
>>>>
>>>> Can I have you RB on those patches?
>>>>
>>>> Thanks!
>>>> James
>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>>>>>  1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 653bd8f..e3f0308 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>  	if (r)
>>>>>>  		goto init_failed;
>>>>>>  
>>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>>> +	if (r)
>>>>>> +		goto init_failed;
>>>>>> +
>>>>>>  	r = amdgpu_device_ip_hw_init_phase1(adev);
>>>>>>  	if (r)
>>>>>>  		goto init_failed;
>>>>>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>>>>  {
>>>>>>  	int r;
>>>>>>  
>>>>>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>>>>>> +	if (r)
>>>>>> +		return r;
>>>>>> +
>>>>>>  	r = amdgpu_device_ip_resume_phase1(adev);
>>>>>>  	if (r)
>>>>>>  		return r;
>>>>>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>  				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>>>>  			} else {
>>>>>>  				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>>>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>>>>>> +				if (r)
>>>>>> +					goto out;
>>>>>> +
>>>>>>  				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>>>  				if (r)
>>>>>>  					goto out;
