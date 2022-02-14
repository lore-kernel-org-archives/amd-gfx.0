Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA66BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 13:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D5C10E58F;
	Mon, 14 Feb 2022 13:15:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DF910E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 13:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyWwtv2UEQU9iejbtV2GkYtp+AAs7A4wIH7N9PsKR8eo30pNVTxZuDlV5+L5ENydT/dbuck92JOFYBHWTRhVAGZw9LUiMbhpvH40ZZYbyFfc/yMiOQTCpgP2taV+ErPj5iOKqXJP3zGVo2EriNIwN1WRm1s1j2sCq4PJM64+vS9yw6ZAPF0u1J5kvUwzaONCTzSMosP3OkzbZ+uKtpCC5SAiDL1zBQbP7rN3efbmAqCZq6/5jy4Bei3yB9ce8FP4wX2s6WEipShM66WyRRSJ5OZ2WG3TSCOEXl4SnPBUXy1yueMhdRJXI5hOcch5ScBfQLgEZKhAlOl0N8BHqwoKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufGSAMEiwxf4h2qFzsNrL+jYu6JZU4d4v6FsCWJyDw8=;
 b=RKbKEcIFCFJNsSVmgnk68coAgTp49ve1cy1tZ1thJsRAQyT2tO0FkSaUoycuSMh4rd+mAIgakQ5Ax5uAoxwvHTE5hMLBNo2TAzcWmxNS5gM+MFTb3qdFhZD7R5Khx9qBs4oPG/dgN4TR+4phw6PBRjkHavrcESeqX6OyXC0vjo1GBp+4pirRcYKgjDksah/TJNlizH9DhsvjW3+06dl3Z1IWafggieY5nw3NDPhV91AEQHohuXk90mF8RrZHNqo+HG+FdD7j7GmCSoJ7jbklbauxLardCeI3wYB2T3FF/oStWZfkdGLetxtD6Lnmhra9WfMMGIiJ0kKbOnreJnFaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufGSAMEiwxf4h2qFzsNrL+jYu6JZU4d4v6FsCWJyDw8=;
 b=t020qq8ZKONM3++yvO9unWKb0JpY4Z69WyiMqd4CxzPjWeB0cLe5P7djkNc9FrI+xBuTwog7D//e7wOp4G5oHdj1URr21fHTo9lhIocuVJeNr67yHNuxYOrHln+LnH4/7T5RQJlET54RaDuc4X8VsoZnNxQLXrZid0REw9Sytcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 13:15:19 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:15:19 +0000
Message-ID: <38f77045-7a4d-6d89-7cc6-9b1dcb6c24b3@amd.com>
Date: Mon, 14 Feb 2022 18:45:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
 <3a99c1c5-0eae-74a0-58e9-3477387467d3@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <3a99c1c5-0eae-74a0-58e9-3477387467d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caaaef2a-425d-4d46-7134-08d9efbc0c61
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB235901A884C17A7CB1F5650EF8339@DM5PR12MB2359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K63Smwq9QIa7hCxlOIiddBo+fjo3LOAmTqK5wSy0FGWZU3qSwMN/Run0iSxTtxxy1A5MFDUw62WPGC0l7RigO0j/0yWe2LVgolYJeTjnKzCJOlaMvTDOYTUZJP6xUG6U1zzR+lniCUoa+QJdK/eeID2QqK/ztUhuPaMwpcdoBy0RU46g2ApG1hXpdLv1BGN12yLgUj8yeTfZJrit4vYrYAZ2VLw0P/lCuW9ZGWWoDLwkQOS8LGG+cEgFaQL2IBl/1NYEq80zjH8kjpKQZJDHCc8K61fWegURBP8GAt6yBTZZeZqNOPADUqCspZzEN7J7cNaZHZE7dWDKOVI0amJ5VbsXrMdaTcC+iQve/q1Dwy8fMRVrKG0G8azFRc+Nu5LP/3opWC37wDCnZ8mPe8BK4oU+m6sMAezo6MasQUK1dh8AijBetm+YpItf9DwQ72U125zTVUjFkZ15n6yELDqI8e+gZW/pA3J8rite1ZuuhX0NbEk+fqwFVHF5zWBGhj7bhij+9gtMQAeOa1IpsVF/zKmXzLaluUK3CDw4QSy5UQkE9hYTsE9jiWgOHEp8ZzAlA+FuGAIxZ7d/cpV2FtulDdXybOncxO47iaGOvtDVYu3JsKNFdxByrOxQnsH2S2cjZNGYP++Xx+Sabq6Wr42JneA7KsnGV+Dj9Ha/2wWNN4AJWNZcqnZ/736j7vohkTPsIYrV0DKOW2b/Vpi/zsN0TFA2jyN+GrV8h5sH/IZYzO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(316002)(31686004)(4326008)(38100700002)(8936002)(66556008)(66476007)(66946007)(36756003)(6486002)(8676002)(508600001)(6506007)(2906002)(53546011)(66574015)(6666004)(31696002)(5660300002)(26005)(186003)(6512007)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdZUkFqTlh2eDRsaXgwUGg4YlR4OTd5ZmhXbnV2TEp6VzYzNFRpZU5lTVZN?=
 =?utf-8?B?c2ViQzBjMU5hV3pNbkkzZzBJVlowaWRQN3BIM0RUdWhRNEprenh4SzUvTUlh?=
 =?utf-8?B?dDRoeGdJRHVEUkVTcElnQ3U4Lzg0WmlvMEtMZXp3R000Ukd1NGNCY0VDemJ0?=
 =?utf-8?B?dWh1QjcwdWZxTmlRdmRMb1hvbkJLZ0Z0YjBYMy9XWjVWb3ZWSVUrYXZZV1hj?=
 =?utf-8?B?VkkvTXJLVVI3bDRCN2cyc3RqY3l6SEVHRlc5ZVhhZndSQ1dCOUE3ZitWcXQ3?=
 =?utf-8?B?Zmk2c2RNS1J4SzVaNmpsbkdPZk44UW51VHQxR2twNVRyZTArWVdvd3E2UWN0?=
 =?utf-8?B?QTczSlVJK0kveEFXaDV5NUprTnhUaFplT0hNQndLVTFWZDQxT1JtM21LbjFC?=
 =?utf-8?B?bm5KajFuRTYxZkx3THAzQ3VJRG5ZcDVUSlU5OGVnOE5ZUWQ5bWt5YTVDS0Jq?=
 =?utf-8?B?YnpIYjBnMENwejBPeXQrbDJ6TEZkNDJQN1R0ZThDcXVocjNkL3lDeFFXOVVj?=
 =?utf-8?B?UERlZERFc09odjk3OGQyZEJZS00zZ3E4Nk9JYWJJYVBycXJ3RS9nV3RVdHND?=
 =?utf-8?B?b1hzd09WN2o0TXgwUFhyOUhZUXg0WUkweStuSWwxWkY4d1d3djRLQVFFU3pk?=
 =?utf-8?B?anlodEtPa1JFd1EzVXl5Wml3SjE3RzZOQUM0UXIzUVVpenBUcXRvb24zaUEx?=
 =?utf-8?B?NnJ5SmFMeTZqSWxneDdQSmFqWVBDNTMzc2NjQ2d1eDRZRDdFMndtUEsxMXRs?=
 =?utf-8?B?RXpYQTNmZkkzVDRsQXY2WCtyWlpEVmtXRVBXdUlaRVBwVjhybXZHaEpwNkJl?=
 =?utf-8?B?dE5kbHIrc0gyUXJsNXBwSDZXbGtXanNWVE9uNEdoL1RWSGZFWkdWQ0RHSlZK?=
 =?utf-8?B?anQ5VEF3TVJta1dWY0xEdjliYkpNY3VyQzRXUGV1ZUc0WHY4VDFXeHdTaGZv?=
 =?utf-8?B?ZlRJQVNsMFZWVllJY3R1Mzdja2ZLWnFGcUZ3UnpNZmJObEJXTXZrUWxacHda?=
 =?utf-8?B?RjJSNGVOd1VuTm4wNU1LK2cwV2o4eExEL0ZUZWtkTkdPTlJ5TGt4UStMVzk5?=
 =?utf-8?B?RzBDOTVXWEdhSnpmYzgxYVdaT3hUQkhBdVlZUU1TY0F4Z1FEUXU0ZjBHRWtw?=
 =?utf-8?B?ejRHN2NkNnExazhNdGVpUWtQdllSUTdaUHJRak8vck96VW9rcjUya0YxODk3?=
 =?utf-8?B?bFh3Qmx0eCtQUDVTTXA5NVFvbWV1SGZqRmVDWE5VeHZwS3BwUjNiMnNXN09r?=
 =?utf-8?B?OGlPMGJCT1VUNDZyeDQ3T01kRHd2UzhDZjQ2UyszSkdYUzRuSTVDQkFyU2Ez?=
 =?utf-8?B?ZWR0bUNacFJyZW9CZVdWOWhKOWQxREVIRUxlYzljbS9ZNzUrc3Z6NGpsUWRN?=
 =?utf-8?B?elI1QXBJbkZhN0dOVnZuTzJaZmx6UkVIL3NqbUREaEF1TkovS1Z4cnZ0dUFQ?=
 =?utf-8?B?ekxVYnRwNDJvYlppUDZxT1QyMFdkcjBKTE1ZQVNvbHR4Z1dZZ2VwMS9GVHh4?=
 =?utf-8?B?dEtRU1dIWGVMYnE3QTdoWTROZ2pyazFkT0U0bTVNVHJkWjNtbUxvREJEZDNx?=
 =?utf-8?B?NE1ITUlUaC9XZDNtOVBNY2JOUFQvaC9TY2xtUWFuY01DZDl5Zi9tSVI2QXpG?=
 =?utf-8?B?ZWE5NiszeFNGWXpDaUdXOTQra1llTnR4cUp2U2IwQUFFYmx1TVU5ZXpWcjk4?=
 =?utf-8?B?TXFCV25KYzJPNmFXNWVoaGtaajVZdUFKTkpaT3B5S01rNjNUTTc2N0cwQ0Ro?=
 =?utf-8?B?RDUrcGx2cGl5K1JRdzV0Nm16OEYzRWlOa2VlUi8wNTI2SC9nUmtSRmJCL21m?=
 =?utf-8?B?dDJiU3R2ckE4akV4cm5YWkpLd3dwM3Y2cVJmY20vZ3UzWUEvRUszUFZmNWJ1?=
 =?utf-8?B?WkpSS2hhQmJ4eEdiR3J2Q0I4djl1b0lOQXMwaytUSEd3dVRrZVo5STBrYmhn?=
 =?utf-8?B?SjkxTFc1V2swQ2JseHpLNzNIM3VUR1VVckRpSWI0eWJraisrR0J6ZzVVb1J0?=
 =?utf-8?B?SUpKNzE1cHB0Q2pWOTVPR1lPeUtBNHltRzhiRU1ocXllUHQ5U0FPV3l2Rlpw?=
 =?utf-8?B?U0VQNEFadVJmbVFVLzdXVG5ycHMyZ1BTdnlwd0xTbUZJamwrc2J4Q3ZmZFlP?=
 =?utf-8?B?ZTlrU1JJT0FIN00rOXd1VE9pNGlHWWc5Umw4aXlYVDk3S0F3a0FtZ09EdEN3?=
 =?utf-8?Q?i0+S6hHrjWz5GeJF2Le92vM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaaef2a-425d-4d46-7134-08d9efbc0c61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:15:19.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbUcnBGpihbEXdogf1/YJaFFkXri2Qom4CMF/cCW/Mtgbdd54/WEuJ+CLTNPxv+CwrYp7Pje7FPjucsfttmm+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/14/2022 2:59 PM, Christian König wrote:
>
>
> Am 14.02.22 um 10:16 schrieb Somalapuram Amaranath:
>> List of register populated for dump collection during the GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 +++++++++++++++++++++
>>   2 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index b85b67a88a3d..2e8c2318276d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>>         struct amdgpu_reset_control     *reset_cntl;
>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>> +
>> +    /* reset dump register */
>> +    uint32_t            *reset_dump_reg_list;
>> +    int                             n_regs;
>>   };
>>     static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 164d6a9e9fbb..6d49bed5b761 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1609,6 +1609,84 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>> +                char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset;
>> +    int i, r, len;
>> +
>> +    if (adev->n_regs == 0)
>> +        return 0;
>> +
>> +    reg_offset = kmalloc((adev->n_regs * 11) + 1, GFP_KERNEL);
>> +    memset(reg_offset,  0, (adev->n_regs * 11) + 1);
>> +
>> +    for (i = 0; i < adev->n_regs; i++)
>> +        sprintf(reg_offset + strlen(reg_offset), "0x%x ", 
>> adev->reset_dump_reg_list[i]);
>> +
>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>> +    len = strlen(reg_offset);
>> +
>> +    if (*pos >= len)
>> +        return 0;
>> +
>> +    r = copy_to_user(buf, reg_offset, len);
>
> Maybe better copy that to userspace one register at a time. This is 
> not performance critical in any way.
>
> Same for the write function.
>
> Regards,
> Christian.
>
I tried to push all list of register in one go, so that the list can be 
overwritten/updated (every write makes new list)
if we add one register at a time from user-space the design will change 
to appending the list and cant be edited or updated, it should be OK ?
and don't see much use of **_read api (as we can see the list in trace) 
i will remove it (debugfs interface will change from string to uint32_t )!?

Regards,
S.Amarnath
>> +    *pos += len - r;
>> +    kfree(reg_offset);
>> +
>> +    return len - r;
>> +}
>> +
>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>> +            const char __user *buf, size_t size, loff_t *pos)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>> *)file_inode(f)->i_private;
>> +    char *reg_offset, *reg;
>> +    int ret, i = 0;
>> +
>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>> +    memset(reg_offset,  0, size);
>> +    ret = copy_from_user(reg_offset, buf, size);
>> +
>> +    if (ret)
>> +        return -EFAULT;
>> +
>> +    if (adev->n_regs > 0) {
>> +        adev->n_regs = 0;
>> +        kfree(adev->reset_dump_reg_list);
>> +        adev->reset_dump_reg_list = NULL;
>> +    }
>> +
>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>> +        adev->reset_dump_reg_list =  krealloc_array(
>> +                        adev->reset_dump_reg_list, 1,
>> +                        sizeof(uint32_t), GFP_KERNEL);
>> +        ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>> +
>> +        if (ret) {
>> +            kfree(adev->reset_dump_reg_list);
>> +            kfree(reg_offset);
>> +            adev->reset_dump_reg_list = NULL;
>> +            return -EINVAL;
>> +        }
>> +
>> +        i++;
>> +    }
>> +
>> +    adev->n_regs = i;
>> +    kfree(reg_offset);
>> +
>> +    return size;
>> +}
>> +
>> +static const struct file_operations amdgpu_reset_dump_register_list = {
>> +    .owner = THIS_MODULE,
>> +    .read = amdgpu_reset_dump_register_list_read,
>> +    .write = amdgpu_reset_dump_register_list_write,
>> +    .llseek = default_llseek
>> +};
>> +
>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>   {
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>> @@ -1672,6 +1750,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                   &amdgpu_debugfs_test_ib_fops);
>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>                   &amdgpu_debugfs_vm_info_fops);
>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>> root, adev,
>> +                &amdgpu_reset_dump_register_list);
>>         adev->debugfs_vbios_blob.data = adev->bios;
>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>
