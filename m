Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27201C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E1160F45
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8E1160F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256A26E829;
	Thu, 26 Aug 2021 12:19:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C316E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2T0icz5zn2J+PYzT41GY6iWAHWLeXmXadbrBxZUI3n0+anGFgJ6NEbfvCbpeOa+dhf45OvuX8RrKWToDJXbsd5Kv/20l4PxcXej35oDtEYbOuyc+WJbG//Z2RLulvOCpM+Foi+ev19b+SqCHwUtLByi41ZMb0VdnLPnQFkva11jEdhKBuzwC7JycN7tN629eEwangeEQYAkUQ+yg674hEEOiOB12pMsFi3pIL5pGZSqolKkTagoUfvWm47Xkl1BbVrB1v63Db6onVfpmuj8umdYonz4ITGU5WpykKPGKRKcqoWCAAytlkdWdlOOBalutsw4r0MPWYH2mVc7uVBoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Lko17CXFkNoRxj6MzTRRRvdxGlO5z7/V5paPH4MBM=;
 b=cDGxgC7af511BXUz6cEMxvD1nkDROjMSNDxwENasmFdEaea5F+ScQGyz4Jpt/AVZjbkpKxUn/xHHqBP48gKY6VVDUKGvrP4v5kH4C7Iry9V2FMGcSAtORi0+ieUmWeUBcu+RXDRnZxpbsmkqQzO13CGYc1K1OcJTh0GKh/maxQ0idDF4U4n87UN8BRvfZjpoK0oHGSDdE1XPN4D9K239+eEzlwCaRdqrA7/3OCMdmBzrZLJnbXHJD/2cWKHJ6YaqM75jRuYt/2+1MlLzFsoHPVFsJzMFufeB9lphz+kggMfkOLc2XgxqaMzO6DhHT4WnsW18UANRKkY4CPC450GKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Lko17CXFkNoRxj6MzTRRRvdxGlO5z7/V5paPH4MBM=;
 b=bhxEKpYKvA4IgSk15ebmO6j1yUMeIkJIWbT1Fg9fWhcmVJlS00Sy4WkMVIAmW/ZxB+XjhjZ/pWrSKnReHh3DO2tK26YQxHexDRKhjq/a+2pgZBbhSCxi128AgKR0GEyDubq3J2uQrKxcx+/GqL3O+6XA9XPWH7/GWX+lc9HbZOY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 12:19:30 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 12:19:30 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
 <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
Date: Thu, 26 Aug 2021 17:49:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::11) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Thu, 26 Aug 2021 12:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be788f2b-fc3f-4608-1681-08d9688bc176
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505A9CD1E867478F93BF55097C79@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2mk07ZCyUv/wIh9OmZaVgSUFdOST4H9SZ5SNytTsGhclR2+fiZG9nJR9MlszbyCGgNL+c7Xpa+K/BCULK59fgyMsE/H3j0dZTsxm5eIWvmRcEp73W2d2VVEzqvIPiED/xwYnH5RrAGV+X3yQ8Oq7pAHgcZycGaTYYh+H9zUGp6cidnh3OWAzS1Z++A4FzfrEHyB/nXF1iTFCrXbnn5b6jhcsuaQ+nTzvZgxAUSi7Celw1ORe9ZVKw+mwwD3qZWvf2nb7OL3fdPHFKHmoZNdDM1NB2G+DIntV6DM0YzkDFBogHJbP0t7Jndvk/xg0I4nyBdiRe28ysWP3t+nq+jAJs8ZEY+yfCnm9ZcwevUSMch8OlhsvgWOILxPeRzKdGau5ssrLRBvpNRvb0GakmbJHtmqVshJDTCVDtKUrk7S8aOrI+Dnt0szdaegmJerfeRw2901G7OIXIkwpr63eFh2SxVBLpGoCri7VILhSQgmqYcgeTx8yX3cp4/AHiEFNusHTKzUSt0Cm50RgNGZkfIl26YXPmgOAiPVVdYy1dGAivrXs2B/wY4girbQPSMJ/ljgCx5cYGWd4mIDsDihuWEhKIJSYW7J50kSHQi3MKSETZqSn44xLNhRAoXpu4YJmZ4YPHEoqP1miOGaW4Hh3kaxZNbsuctQg6XAODvra2bvh0pIVti/edYlxjgq4G916CVUpnbjI+nvvVv6x8ZMZMEXiJhxHx3U3EI8ZQI88ODv9fI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(6486002)(36756003)(6666004)(86362001)(2906002)(30864003)(31696002)(110136005)(316002)(16576012)(66556008)(66476007)(66946007)(186003)(83380400001)(38100700002)(31686004)(26005)(8936002)(5660300002)(478600001)(956004)(53546011)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZyVklIanc4Yi9Ga0JvMmZkVWxrck5LVEZCejRHRlFCcWs1ajBLQ1IzMWI5?=
 =?utf-8?B?RlQ4MmZHeVkwdHFiS1JLYlkyayt5YW5OY3RnS1dneGtrRGlRMUNQMGRIVFYy?=
 =?utf-8?B?c1V2NWY1Mit4aTBjSFZJYkprR1ErVUt4WEhGRTlxaFB3cXpJZlVycHVyWXVM?=
 =?utf-8?B?N2NrS1ZpRW1hcS9mMmw0UzZXOGwzOTJrek5SRmw4eVd5eDFlWERZUWhURm1x?=
 =?utf-8?B?YzN5dklqVUlYZmtGbm56dTN4RVU0UlIzTXNyQXZxVVp2NTA5QS9kNG5WemhU?=
 =?utf-8?B?TGVKVittUzQ0RnZNZkFtTmRkY2gzMElvMzVGZjNqL1FPcEhBRnVSWG5abTVB?=
 =?utf-8?B?YzNrWng5NG5sbzlaQUV5Vk1KQW5qdXlKR2ZtNTFPMzNRZnZyN0ZiMjIrNGhz?=
 =?utf-8?B?Nnp2YUFCcXN0aHJmWkFlSXRRRGpRRUZIUVJzR1ZoREFIaTBQdkxHbkVoOUl1?=
 =?utf-8?B?WjlmQTg1UlFIT0hXSW00cWg5bHAvVytpQ1pKWEsrZlBCcEtPQW9rc1BJS2dl?=
 =?utf-8?B?OXVTREFhSGxaeGFkNmdqc1hsT3c1R0J0RW5UMElHY0dmSEVwbXVKem5Mcmlo?=
 =?utf-8?B?Tk84Rk90ZWkrTG9LSXZsL3JJbVl0b0xWSkRWczlXbFkrUXgzdXd6NEdHbmR4?=
 =?utf-8?B?aldFRUo3eXVFWGRLNFJsc0FqSmdRQzFSbTZhY2ZBbm9Zd3pFZllqSytUVWEy?=
 =?utf-8?B?Z0o4aWZKbVlCcTkrZmc2bXlCQ3JSNTRENHlleG14NDFuL0NXWVdNZGtPcHBv?=
 =?utf-8?B?ektYZUpEbWJTREVPaU5UaFd3NVBSaHhCWVlNMDZtWVhCMFdJTnA4Si8zMjBP?=
 =?utf-8?B?YmNmWEZwMTVINVhxUnRuQlI4Q2VxSjIyYnp1UTd5MDRnTlVwSFZGUFVhU1pz?=
 =?utf-8?B?Yi96bzZMRnorRVpxa25BWUpYUy9xUHpVL29xTlVNaVl1S29wWDFQTndsUk1C?=
 =?utf-8?B?YmYyMytWV0h1VU1TUUFQV2tlZ1VBeUJucVhBNG1nQlZ3MTJkcnFkVHZXWkNm?=
 =?utf-8?B?WDNQSmZ1UHgwc2cxLzNuOWxGQWJtMGczeVhwU0hocUFTRW16dGJWUGdCUVFC?=
 =?utf-8?B?YTJNbUQ3Q3Y4bmVZTFNSS0tmWlkzTDlFOHY4TXFHaFgrTFVZRVJsRUlwQk1x?=
 =?utf-8?B?ODZtSlFKNVlOSGRUZkdjTnI4NVJOODhHZ2dkeXRLWk5LcnRIUkhUR01FZkpO?=
 =?utf-8?B?SHNCZ25nSENCWFFjYjVUN2QrbFdqZmdPZUFxR1NFYXUyRmR5YXAvVkJvbkQz?=
 =?utf-8?B?ajJhTmgwdEc0cHFhT05XWWpSNTNpMmNXRC9YSmJDMFRLelMxd00xUVFsRlJU?=
 =?utf-8?B?YzAyYnZocmRMc0NFdmJrNHZJekc1M3JUZUprZXZqUy80dExiTzJSSTZrbS9u?=
 =?utf-8?B?cFdqNjRkbzJqRkgvU2tDaWF4QWxhcVNqWExQMHM3Wm5Oekg1K0NnL0tTZlFB?=
 =?utf-8?B?Qlo5bmJtWmJuemVEeWMvbmV4cTNiZFNZS1Y5MCt3MEZDSmJXcG9UM1JQelhn?=
 =?utf-8?B?WlJhNE10Qm0vc201UkJUZEl1YnhaK0NYdlJ4QkJXSnVQaFgvamdXY2liT2xO?=
 =?utf-8?B?bW1HOGdnWGR6bkZjSE5WaU9zaDVmMjRnSjJUcU8vbk1jQ2NJQ1FXK1AyUm9i?=
 =?utf-8?B?NzdQTVdTakMreldjV3Fic25ZMkpGWldHNUN2Znl2L3dBT0doak5BNzBSWmtC?=
 =?utf-8?B?TS9mMHFoSXN4eWlKWlVhaU9hSjJHM1VvdzFlUXp6cTErRzYwWlA0RXpkSTRQ?=
 =?utf-8?Q?knAg6uEGd+U2wQGhghmsLx3XyRzwjwGMztxnE2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be788f2b-fc3f-4608-1681-08d9688bc176
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:19:30.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB25OzFyKnMBEoEKk7f7Fcy+CMfLvcfKS6fgc6ErTsnwfw1RE7lRs7y9m17X+j99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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

If there are two threads using the same fd, I don't see anything that 
prevent this order

	set_state (T1) // State1
	set_state (T2) // State2
	read (T1)
	write (T2)

If there are separate fds, I guess the device level mutex takes care anyway.

Thanks,
Lijo

On 8/26/2021 5:45 PM, StDenis, Tom wrote:
> [AMD Official Use Only]
> 
> While umr uses this as a constant two-step dance that doesn't mean another user task couldn't misbehave.  Two threads firing read/write and IOCTL at the same time could cause a lock imbalance.
> 
> As I remarked to Christian offline that's unlikely to happen since umr is the only likely user of this it's still ideal to avoid potential race conditions as a matter of correctness.
> 
> Tom
> 
> ________________________________________
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 26, 2021 08:12
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
> 
> 
> 
> On 8/25/2021 10:56 PM, Tom St Denis wrote:
>> This new debugfs interface uses an IOCTL interface in order to pass
>> along state information like SRBM and GRBM bank switching.  This
>> new interface also allows a full 32-bit MMIO address range which
>> the previous didn't.  With this new design we have room to grow
>> the flexibility of the file as need be.
>>
>> (v2): Move read/write to .read/.write, fix style, add comment
>>         for IOCTL data structure
>>
>> (v3): C style comments
>>
>> (v4): use u32 in struct and remove offset variable
>>
>> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>>         instead of 0x3FF, use mutex for op/ioctl.
>>
>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 ++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>>    3 files changed, 201 insertions(+), 1 deletion(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 277128846dd1..87766fef0b1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -36,6 +36,7 @@
>>    #include "amdgpu_rap.h"
>>    #include "amdgpu_securedisplay.h"
>>    #include "amdgpu_fw_attestation.h"
>> +#include "amdgpu_umr.h"
>>
>>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>>    {
>> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>        return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>>    }
>>
>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd;
>> +
>> +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>> +     if (!rd)
>> +             return -ENOMEM;
>> +     rd->adev = file_inode(file)->i_private;
>> +     file->private_data = rd;
>> +     mutex_init(&rd->lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
>> +{
>> +     kfree(file->private_data);
>> +     return 0;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>> +     struct amdgpu_device *adev = rd->adev;
>> +     ssize_t result = 0;
>> +     int r;
>> +     uint32_t value;
>> +
>> +     if (size & 0x3 || offset & 0x3)
>> +             return -EINVAL;
>> +
>> +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     r = amdgpu_virt_enable_access_debugfs(adev);
>> +     if (r < 0) {
>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +             return r;
>> +     }
>> +
>> +     mutex_lock(&rd->lock);
>> +
>> +     if (rd->id.use_grbm) {
>> +             if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
>> +                 (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +                     amdgpu_virt_disable_access_debugfs(adev);
>> +                     mutex_unlock(&rd->lock);
>> +                     return -EINVAL;
>> +             }
>> +             mutex_lock(&adev->grbm_idx_mutex);
>> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
>> +                                                             rd->id.grbm.sh,
>> +                                                             rd->id.grbm.instance);
>> +     }
>> +
>> +     if (rd->id.use_srbm) {
>> +             mutex_lock(&adev->srbm_mutex);
>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
>> +                                                                     rd->id.srbm.queue, rd->id.srbm.vmid);
>> +     }
>> +
>> +     if (rd->id.pg_lock)
>> +             mutex_lock(&adev->pm.mutex);
>> +
>> +     while (size) {
>> +             if (!write_en) {
>> +                     value = RREG32(offset >> 2);
>> +                     r = put_user(value, (uint32_t *)buf);
>> +             } else {
>> +                     r = get_user(value, (uint32_t *)buf);
>> +                     if (!r)
>> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
>> +             }
>> +             if (r) {
>> +                     result = r;
>> +                     goto end;
>> +             }
>> +             offset += 4;
>> +             size -= 4;
>> +             result += 4;
>> +             buf += 4;
>> +     }
>> +end:
>> +     if (rd->id.use_grbm) {
>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>> +             mutex_unlock(&adev->grbm_idx_mutex);
>> +     }
>> +
>> +     if (rd->id.use_srbm) {
>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>> +             mutex_unlock(&adev->srbm_mutex);
>> +     }
>> +
>> +     if (rd->id.pg_lock)
>> +             mutex_unlock(&adev->pm.mutex);
>> +
>> +     mutex_unlock(&rd->lock);
>> +
>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +
>> +     amdgpu_virt_disable_access_debugfs(adev);
>> +     return result;
>> +}
>> +
>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
>> +{
>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>> +     int r;
>> +
>> +     switch (cmd) {
>> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>> +             mutex_lock(&rd->lock);
>> +             r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
>> +             mutex_unlock(&rd->lock);
> 
> As this is a two-step read/write, I don't think there is any protection
> offered by having this mutex.
> 
> Thanks,
> Lijo
> 
>> +             return r ? -EINVAL : 0;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
>> +{
>> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
>> +}
>> +
>> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
>> +{
>> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
>> +}
>> +
>>
>>    /**
>>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>        return result;
>>    }
>>
>> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
>> +     .owner = THIS_MODULE,
>> +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>> +     .read = amdgpu_debugfs_regs2_read,
>> +     .write = amdgpu_debugfs_regs2_write,
>> +     .open = amdgpu_debugfs_regs2_open,
>> +     .release = amdgpu_debugfs_regs2_release,
>> +     .llseek = default_llseek
>> +};
>> +
>>    static const struct file_operations amdgpu_debugfs_regs_fops = {
>>        .owner = THIS_MODULE,
>>        .read = amdgpu_debugfs_regs_read,
>> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>>
>>    static const struct file_operations *debugfs_regs[] = {
>>        &amdgpu_debugfs_regs_fops,
>> +     &amdgpu_debugfs_regs2_fops,
>>        &amdgpu_debugfs_regs_didt_fops,
>>        &amdgpu_debugfs_regs_pcie_fops,
>>        &amdgpu_debugfs_regs_smc_fops,
>> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[] = {
>>
>>    static const char *debugfs_regs_names[] = {
>>        "amdgpu_regs",
>> +     "amdgpu_regs2",
>>        "amdgpu_regs_didt",
>>        "amdgpu_regs_pcie",
>>        "amdgpu_regs_smc",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index 141a8474e24f..6d4965b2d01e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -22,7 +22,6 @@
>>     * OTHER DEALINGS IN THE SOFTWARE.
>>     *
>>     */
>> -
>>    /*
>>     * Debugfs
>>     */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>> new file mode 100644
>> index 000000000000..919d9d401750
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * Copyright 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include <linux/ioctl.h>
>> +
>> +/*
>> + * MMIO debugfs IOCTL structure
>> + */
>> +struct amdgpu_debugfs_regs2_iocdata {
>> +     __u32 use_srbm, use_grbm, pg_lock;
>> +     struct {
>> +             __u32 se, sh, instance;
>> +     } grbm;
>> +     struct {
>> +             __u32 me, pipe, queue, vmid;
>> +     } srbm;
>> +};
>> +
>> +/*
>> + * MMIO debugfs state data (per file* handle)
>> + */
>> +struct amdgpu_debugfs_regs2_data {
>> +     struct amdgpu_device *adev;
>> +     struct mutex lock;
>> +     struct amdgpu_debugfs_regs2_iocdata id;
>> +};
>> +
>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>> +};
>> +
>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>
