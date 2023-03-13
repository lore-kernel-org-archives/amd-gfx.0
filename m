Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8EC7618B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 13:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC82210E516;
	Mon, 13 Mar 2023 13:21:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831BD10E516
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 13:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn/m8PtaqKLXZdKJ5B031Nq2dq0VlY3qpjTaOL2iBwyrNH/q137u7iXdBxbQZxCr405cph0+i1t6h9YXML/viOMeMac8moBCE5tQaBIrq28FHnRuhF4QkXvn7HwPQxQfiH3xhkBPsVCBxkw5VEMRfjdKK64nVhxVDQfvn+sxk4+g06fIqRTXyyrBPQZAcs8IaTwzY+irMHVO7rpOX5odv9cMK5/6h6wK8wNs16BvtGsFbJqzrJ2SdXy+4MsHoexrQn8DiinVkCoRCnM7DJApa+bhAbOoj9zSvA/X/emqX+eDAh9iF8DFZOThjHJe4kNQBKAoAcB/L9OE7GvGE9baEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTHAzDYLNXDmHiJEC8y9c07l8JLZoqPsBD5C8EAWbOw=;
 b=eze/jp25rRfEe+BfRrB1/zIy0SEy6AzjJnw1YfXMUrvOa0+GeknS5lq8UbmMlHugBS5jH80pmMR+xiK8jKqUcu4ugMJRzGsYHVN1FoBP8/2lPIKj3q2a5zNqT1rHoDoPBBzHjKpqd784x+Sz4PlTNKH7oUX5g5jDyUAqxIXR9bnGB80L4fWh/2RZfbA+4kL8GQD6HYYRaHTEq42lxhaQDaWrnc3JqFXqKphbIU4qWFMfQ48H8chYd5DjY0YMLVB2wJqPf5jiBUCZlR7i18t+DT4+VIunGtNqiauk/Hsf/oy3JCuwe5WhPSfkwL3ugtCAnPRmSVZjk18mW0bmHTQ3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTHAzDYLNXDmHiJEC8y9c07l8JLZoqPsBD5C8EAWbOw=;
 b=NGIAnjtY64wRkcKEtjzLdF9r550FXGLqZLSadK7MVM57esgCyh/c5C4Ygr0yFmgbwDwNp2Ou/zm73EJ2PGs5XoXsCdg7bW0C/Ynjw3H24ptA+OqyfrM+ZHDeqk6ZwKCJ5dPr4QikCjxtCjF7jNdwG84aS1S+dawUwVojTFx3Y4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:21:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:21:10 +0000
Message-ID: <24f2b8ea-4e5a-7695-cdbf-cfe7e8109dcc@amd.com>
Date: Mon, 13 Mar 2023 09:21:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/2] drm/amdkfd: Move TLB flushing logic into amdgpu
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
 <e4173da3-5868-3b21-f2c5-20d1645106f5@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <e4173da3-5868-3b21-f2c5-20d1645106f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0016e34a-3526-4d80-cb13-08db23c5cf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjkGPNtN0MbH8slr/o3YhioK7QBuxUwITOfz2gZ2pFjgz1R6P2oQtHZDsXSkLrFNsV7UlnkCr0pHoksBUHQCiP+APx+tkDrKZOe2AVSEhRGAT087nkgfseeTzPOzByQhdra/2j14keEbo04O2z8uUQ0lnQbVqvbXHn/RKelqjisuF82eQBQE0qtrx62msjh1GzmCfOSKBZPJ1C9imaZoSYtUHxpWZ+ZdiWtqmSUlwGqfbGiKJziAT+BYowPr57MWhJPZ1z/LS5ycX+5D+pcWiJ2cQnQ98XDbw1h62BWnnxIzJt5TkUkZrpUaXMbuzWjRVy5w5ghBoS+PVTJjfHpr8DdbYPHMI9fxokbnJX4vKOYygZ/TqboIVPR2wwVLvvzWwT9mYJAJ6dt51B0mPuhcRJ4Jm5DKNFneX0Lgsvo6Ezfe7TzC4wumNA+dPjr7XOpHbtE3JjKOsA7AfxHxFtD58p9yRsCHrXFGmtZ9ZtK3jxvgUljNXp9RsENrWyFu1ULcJlgs3w8XDHSKOpXttYmHF0/+cueIErFjFCSrdazfhYBl8yFwMlxsdm+VsyW6f2PD6DpPWLywafsor49A5bKd7J+MUwNW6e9tJuiUlZ8Bz+tBi02PwAOxnUUNGOG7Gpn5cBcOW+CqveCNefmpFw6pXxYNRnfbCjVtdXS0lOjX6j3BcgYFfxaZxPwqJhQpoI4kPtv6jr4D6guTwal44LgmKOTHM0G5WPzjHaQaWDPzbRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(5660300002)(44832011)(36756003)(83380400001)(66574015)(478600001)(26005)(6666004)(6512007)(6486002)(6506007)(2616005)(8676002)(66476007)(66946007)(66556008)(186003)(41300700001)(8936002)(86362001)(31696002)(316002)(38100700002)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVDVGplZzh6TnU3TUFTYU9wSDhhdVFWQ1orOGdnMElXbzJ1eC9FNllLaHZp?=
 =?utf-8?B?Z0d2RmM4NTNWVzJEYmxCY3FZakJIZTRYTkExcUpsdWsvdXExK2VkV1B2VWRv?=
 =?utf-8?B?dTBoTXlhMzdxTEo2T1lvSEZ2SkpwaXI2V2tkWEtUVHZ5Nnh0eVpSTytPTkVl?=
 =?utf-8?B?eElxcHdvU0g3ai9NMm1Ca3RwTnNJOUpabVl0TTdpSWJLRnJ2c0pPS2FHUTdP?=
 =?utf-8?B?OEo5TVRhakgvVEpXd2U4MXpmdXVaSjhwMlR4WnNPbDlxUFJPU3M5UTlYTndo?=
 =?utf-8?B?WlAzUko0bDVYeURObWcvYmdjZlBtUVh1ZURjbWgwTjF5d2syZTdzOU9DalpU?=
 =?utf-8?B?YXRiRGhDL2ZoOVpzeFYvT3B6WTdta1c5SkNTV3Y3Q2NIUWZrYytYYXJKQUg0?=
 =?utf-8?B?TlBzZnY0NFg2N1BFeWRwYVJXVUpmQmIyY3krTlBQRmpVaGtRS2F5c25DNGJX?=
 =?utf-8?B?Y29KdUtSSGdhOWtWckhUMWh2NzN4cHd2aWsxdEFkT0QyRUh3WVRNMFMvZXVL?=
 =?utf-8?B?T3BHcDhYM3Y2Uk1QOVhQL0VVOFRFYTBJRVgvWmhTeG5RS0FHQUEvVTlIeVlO?=
 =?utf-8?B?M3YwNEszSjJ0WHQ0aWwzUWN2TnQwby92TktRSzluemw2TWQ5RGVjR3lCdnhC?=
 =?utf-8?B?bkYyVk8wY1U0SWdYUy93TnRYRVZ2WEdFamJRcTVrMjdvbG9zVWFuUnBqUWVl?=
 =?utf-8?B?ZzZGSml6Y05pYnlOMWRtZWlHLzV3Q1pNMURXNkNZT1cyMytOREFoUUZ6c00w?=
 =?utf-8?B?VjF4SmhRaHNPWWxsUVRwY3QwM1piT09jT2h1V0hjd0VTSWNyRi9TVm0zWXB6?=
 =?utf-8?B?UzRUSjgzVGFmQWJRRkp0SU04N25wSjcyTWptZm1PZnpTK1B1RVdUQnE1SUJk?=
 =?utf-8?B?VVZXR3ljUDlKY0swdDNKOVNkU1c2Mjd5WllNNjk5dVR3VWFNK3lGRXBqMjNt?=
 =?utf-8?B?UTJDV1h5TzNTQVNHZHdUTUkwU0VuZWpxdTV3ZytLRGNQeFlEZjlSb3EwM3Vt?=
 =?utf-8?B?UzJvZmdSQlBGM29uQmpYb1JQaldIQ1lNNHhQbWNvaDRQU3VFSUR1TTBaVG53?=
 =?utf-8?B?VnUrOWRReEEyN0dsM3BJRDA5OVdUOG5LYW9PaDlVdSthbHF4NG45QXhlUlYr?=
 =?utf-8?B?UWd4NzNqUkNoK0JUS3U5NHhPdm1VRUNwc0MxazZsOTFhMmZzYVVUR2c5d05o?=
 =?utf-8?B?K3dmTFpOLzlKRU9BdUlKTzhnN2xRSnBXNHROWGpKZXU5SnBEcVV1M083Y1pq?=
 =?utf-8?B?QU9BYTlrWlV0WGhMMnJBWTluOHowSTVpZTZYYXhoMGZkbVU3MzJ3QU1UOVFV?=
 =?utf-8?B?eElYZklDd1VrRGZsZ3A3aUxObzFvd1ZBelVyWDlaMWwrVG1iVnREVGxTMXlP?=
 =?utf-8?B?TTNNVXVsaVlEM1Y2OVZNZnhFQ3lYQkJNdEpJK0tmNkJMNjVUemNhMlpRL2dI?=
 =?utf-8?B?REU5aVlPMzBXK3NrQVdMemwzRndBdC9DMEV1d3BUTnlkU0JyanQrYW11U2xE?=
 =?utf-8?B?dlBBa0pDSnVRbXhMUmtneWcxczRjUjJoUnVoeVl0R2FSWDI2V0tSZlFJaWsw?=
 =?utf-8?B?MjN6MkplU21rMlE0WlNrL2plYkFQWTltcjZrZWlqME1tUDQ4Tk10L1g2dnhh?=
 =?utf-8?B?UkIwS2VveDlzS0lZa0NQbktBdlh4VkR3VnlETGR3YjBhQVpTMFF2WmxEaEYr?=
 =?utf-8?B?cGNUaTZmZkRQQ2R0Y20wME1kVzBTUXgrUjNwcFRrU1ZsNGxSa2dOeFQ1d0F2?=
 =?utf-8?B?MThyRjZHQ2pVOGVzWFpqMlo3S2ROemdyTE5CRTZZcStXRjdoY3JJOTVzR2g1?=
 =?utf-8?B?dlpubEdlbURucUQ4OENINzY2Ykd5Rks4STlXZnM1NUNaRW5XSk9nS3VNU2oz?=
 =?utf-8?B?d0hPU2JIMVExR2I2SERZeVdNTTh6MXZIaFBBR1Z6MDJjbVNEeUFSVXdQUTYw?=
 =?utf-8?B?bWk2V0NHVnhSNGhKMHpwUkZobk82Mm5UbURPY3RNTXA2anBzSFN5ZTgwTXlJ?=
 =?utf-8?B?dGFWQzQxcE5sNzBEVUN3NWZLc0VNOXR5bkxQSUNyZFp6RFRaRUZYM2RheDMw?=
 =?utf-8?B?OWlPVUF3YTNlKzZwK3pPYTFQZm52NHN3akRZL2FxRExnbVRUTWNDZUlRSGNj?=
 =?utf-8?Q?5zb84UdHMPSn5xsmCihJmzctj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016e34a-3526-4d80-cb13-08db23c5cf83
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:21:10.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9TE/12sCVzFLhHW69fQBP2SEpCciBan8fFpH1Ng9y4ql+5yp50RXcR9ogxVeqahaJ/Kcpl+J+4WX72vmLXgTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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


Am 2023-03-13 um 03:36 schrieb Christian König:
> Am 10.03.23 um 23:16 schrieb Felix Kuehling:
>> This will make it possible for amdgpu GEM ioctls to flush TLBs on 
>> compute
>> VMs.
>>
>> This removes VMID-based TLB flushing and always uses PASID-based
>> flushing. This still works because it scans the VMID-PASID mapping
>> registers to find the right VMID. It's only slightly less efficient. 
>> This
>> is not a production use case.
>
> On the one hand it looks nice that we can now flush based on the pasid 
> without having the NO_HWS dependency (I hope that this was intentional).

The intention was to be able to trigger PASID TLB flushes from AMDGPU. I 
need it for flushing compute VMs when their mappings are modified by the 
GEM VA ioctl. Removing the NO_HWS dependency was a useful simplification 
to get there.


>
> On the other hand I really don't like to have any variables in the 
> amdgpu_vm structure which are not worked with by the VM code itself.

So what's the solution? Move that code into amdgpu_vm.c? Or find a 
different data structure to store the sequence number? I guess I could 
put it in struct amdgpu_fpriv, which amdgpu_vm is part of.


>
> That already backfired with the pd_phys_addr before.

Can you clarify this concern? I'm not aware of any issues with pd_phys_addr.

Thanks,
   Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 30 +++++++++-------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  9 +++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 28 --------------------
>>   5 files changed, 22 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 8816853e50c0..dcbd28e99b5c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -726,31 +726,25 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct 
>> amdgpu_device *adev, u32 vmid)
>>       return false;
>>   }
>>   -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
>> -                     uint16_t vmid)
>> -{
>> -    if (adev->family == AMDGPU_FAMILY_AI) {
>> -        int i;
>> -
>> -        for (i = 0; i < adev->num_vmhubs; i++)
>> -            amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
>> -    } else {
>> -        amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>> -                      uint16_t pasid, enum TLB_FLUSH_TYPE flush_type)
>> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> +                enum TLB_FLUSH_TYPE type)
>>   {
>> +    uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>>       bool all_hub = false;
>>   +    /*
>> +     * It can be that we race and lose here, but that is extremely 
>> unlikely
>> +     * and the worst thing which could happen is that we flush the 
>> changes
>> +     * into the TLB once more which is harmless.
>> +     */
>> +    if (atomic64_xchg(&vm->kfd_last_flushed_seq, tlb_seq) == tlb_seq)
>> +        return 0;
>> +
>>       if (adev->family == AMDGPU_FAMILY_AI ||
>>           adev->family == AMDGPU_FAMILY_RV)
>>           all_hub = true;
>>   -    return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, 
>> all_hub);
>> +    return amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, type, 
>> all_hub);
>>   }
>>     bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 01ba3589b60a..dcaf69fd833c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -157,10 +157,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device 
>> *adev,
>>                   uint32_t *ib_cmd, uint32_t ib_len);
>>   void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, 
>> bool idle);
>>   bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>> -int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct amdgpu_device *adev,
>> -                uint16_t vmid);
>> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>> -                uint16_t pasid, enum TLB_FLUSH_TYPE flush_type);
>> +int amdgpu_amdkfd_flush_tlb(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> +                enum TLB_FLUSH_TYPE type);
>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 
>> vmid);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 03a3314e5b43..171de7da2959 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -290,6 +290,7 @@ struct amdgpu_vm {
>>       /* Last finished delayed update */
>>       atomic64_t        tlb_seq;
>>       struct dma_fence    *last_tlb_flush;
>> +    atomic64_t        kfd_last_flushed_seq;
>>         /* Last unlocked submission to the scheduler entities */
>>       struct dma_fence    *last_unlocked;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index bfa30d12406b..e029129308e7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -715,7 +715,6 @@ struct kfd_process_device {
>>       /* VM context for GPUVM allocations */
>>       struct file *drm_file;
>>       void *drm_priv;
>> -    atomic64_t tlb_seq;
>>         /* GPUVM allocations storage */
>>       struct idr alloc_idr;
>> @@ -1344,7 +1343,13 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
>>     void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 
>> pasid);
>>   -void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>> TLB_FLUSH_TYPE type);
>> +static inline void kfd_flush_tlb(struct kfd_process_device 
>> *pdd,                             enum TLB_FLUSH_TYPE type)
>> +{
>> +    struct amdgpu_device *adev = pdd->dev->adev;
>> +    struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>> +
>> +    amdgpu_amdkfd_flush_tlb(adev, vm, type);
>> +}
>>     static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ebabe92f7edb..48d7d30eeb24 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1591,7 +1591,6 @@ int kfd_process_device_init_vm(struct 
>> kfd_process_device *pdd,
>>           return ret;
>>       }
>>       pdd->drm_priv = drm_file->private_data;
>> -    atomic64_set(&pdd->tlb_seq, 0);
>>         ret = kfd_process_device_reserve_ib_mem(pdd);
>>       if (ret)
>> @@ -1994,33 +1993,6 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, 
>> struct kfd_process *process,
>>                      KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>>   }
>>   -void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>> TLB_FLUSH_TYPE type)
>> -{
>> -    struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>> -    uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>> -    struct kfd_dev *dev = pdd->dev;
>> -
>> -    /*
>> -     * It can be that we race and lose here, but that is extremely 
>> unlikely
>> -     * and the worst thing which could happen is that we flush the 
>> changes
>> -     * into the TLB once more which is harmless.
>> -     */
>> -    if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
>> -        return;
>> -
>> -    if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>> -        /* Nothing to flush until a VMID is assigned, which
>> -         * only happens when the first queue is created.
>> -         */
>> -        if (pdd->qpd.vmid)
>> -            amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->adev,
>> -                            pdd->qpd.vmid);
>> -    } else {
>> -        amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->adev,
>> -                    pdd->process->pasid, type);
>> -    }
>> -}
>> -
>>   struct kfd_process_device *kfd_process_device_data_by_id(struct 
>> kfd_process *p, uint32_t gpu_id)
>>   {
>>       int i;
>
