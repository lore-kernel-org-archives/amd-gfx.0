Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D02BC64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 15:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80DB10E00A;
	Thu,  9 Mar 2023 15:24:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3336010E00A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 15:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvFf0BLJs0Q7VN4RXUb/uE1MW1QpNVM/qnurxpFwplL8DY5leYT29exHWHTP25hnyGWzEwL3lGXpRaExeJIFn39ndK2hBw55mh6Mufs2X4hz2YVaztiWNiDAqo/tEUSGxztGuZ0sYjdTsid6KbUZAqn+bzo1EgOvoHHTqr40t0BNAxCQ7PNF0hu1XwytMMMAxwYlPJK1ipJ3ZGCIJ7AP1A2YHJOrZ0MpINj0k4tZXcL86sHtUaqPaz1lza7OfpIqL2SEUczmsw+ETQP3oA30z76So9rcIhixgCrW4U32+Ch2R+SHMutZ2KT+30c0He2U1bX3R9WAFk6l7s7ZaT65zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF1OPTFJVSCmzsndkyiIWe8mOeT4uYMy8wklVkfi2TE=;
 b=NLnwEmdAZJDhF/hfMtFJAIL5oMYpQh1GjRBspnu95Y65h0BjyuPKHJWp3FweijnlEcOpEzE/xgz0gYWeYm1d4kcErCiip34TtMPScdW5PLbphtRhqgNvFAeg2VsU/mdCE3Gmoe3ut9o8zpLao2AHoHz9deYZl5qWgMmTDjUo6Q17gbrEYbwacOsNGKWBF3ED6vTEmcT7wBqqyrtO7UPun3NaY7w3qE/Nxe6kYKA9AzaTQSm2kq/Kwuqbs5P1LEUfbM3ETRUs1LgS9dcw3IWyOyGHbF0oiRMkLFtHFi8WzMB7tPg928i76iAp6vTXKS41krp1DKjeA+n/fsJ2RUaKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF1OPTFJVSCmzsndkyiIWe8mOeT4uYMy8wklVkfi2TE=;
 b=iSDiZO52wlxV/gviFgje1JoBLDdyOawsFUDKvlIop4Ln4F78XetLDfCi95VwLuIOCyvTDIlqrhUgQiKtiHbw+df95vIOI2saPdpJmwxjheFfuUcGbewEmckNgOIlA72xW0bv/k6TkuZP36lRvfgMBFEhfclB4X3lL9tjonXtww0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:24:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 15:24:36 +0000
Message-ID: <03369e60-870c-79f1-3b6e-aa3498c2b286@amd.com>
Date: Thu, 9 Mar 2023 10:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Get prange->offset after
 svm_range_vram_node_new
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230308074509.264478-1-xiaogang.chen@amd.com>
 <35f07147-85a0-a204-b0b1-394459e2c728@amd.com>
 <5725a5c8-6fa9-bf48-4c7b-ec3b34d495a0@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <5725a5c8-6fa9-bf48-4c7b-ec3b34d495a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff1b89f-def5-4117-2c0c-08db20b2640e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb9zX4X0sF0+f/ilDUOl5j/InFvSlWP0cAONVuEnyfzl5kQxOVD8Xj2AlT2lxrfqdpbC7FVmM1BQgyTeII7IPDqz2Zh3Aq0MRrUy+zp1pN7pW3Z22YWHez7yDVMdJ+gPMzK33qBua9SGHfKt2XQBAfw0/8Mug6B8VaM2UesGh3Qssqz1sNhYopDMT9SU5Otj4Bc54MfpDlzqB8qxYHeXgrhsNgA6Te6/umufSGefQkpvNOYDXq6/4YlQYRDHoo3L1sCJTK06Fte236Ka6+BUoa8J5bpx5HnBsiphhseaQzZoHSoD7Y93nlSNp8R+U/MFvksMJzGG294+zlvBaap0AMWaoRMSlOpT8vwcV3AhlDjt0sNPTsYwBgleNtw+HR9ng65rZydkoGvfSgCrxw1hMH9XqhA96lkpsaMULGNaljN3mg90pXOjpg2WKynEUeCP2rgjourUAjqEbqRI5Gpdv7m94C6I/FjOlH12+iJJxT2TusHYeUjEUrShKvf4DRQa82PaDyPdJ/OFgzTK9XP+Xu1WXqxOKJOKWEUI9xVzuphTSnBiU6+St3SsUTMmPg2VZSrd5lvh5aQZtI4grU5J03jtvD/d4mnbCCIv1hjeunrJntm4VDr32LoLvXgB3GdyxSx+8vnogWsEayrBpzbLzWR/53A7zAvcet/QglQrDkJ0rA81j6EkdYmShE6udbLvXOwHXsAciRrSl9uGek+I5oeZ1zY/T1heChfMZVNjz+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36756003)(6486002)(186003)(53546011)(2616005)(6666004)(83380400001)(6506007)(26005)(6512007)(41300700001)(8936002)(66946007)(66476007)(66556008)(8676002)(2906002)(5660300002)(44832011)(316002)(86362001)(38100700002)(31696002)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZrcUZKcnEwL0pqNFNmY2RacXY1d3d6ZDdMT3B2MWR1SWJwOUdHSi9tL1c4?=
 =?utf-8?B?UFhBZ3JtRVZXd2hibHRMTlg5WExpT1B1NVFmRjU2TnRMTkVaWFI3bEFKR0tB?=
 =?utf-8?B?cXpPZXc4V0M1SW1DR3N6ZnFHYzJOM2pQZGxqUmFxa0t0OHJvaDBwZFZzUVVF?=
 =?utf-8?B?MnAyQnpvQmZJMVNnd1hMa3B1eGJaNjErTE5pbHI1Y0lEdFd3UEl5VUN5L0hR?=
 =?utf-8?B?NHY1QTJBdlV5ZHR0NDZKeERGUmEzMzViZytVSTFNVlVZUVNYRGJSSWN6TlBr?=
 =?utf-8?B?RG9mMXJuNlhNSWkzaWNkamdJbDNJYXZLYlQ2Nm1GWEt1TE5FWFAvNE1WeHkr?=
 =?utf-8?B?M0trcXQ1bmVVcEhvOHMvWVZCaWc1YnJBZzBUYmFBT0lEUWRrbjB4NlczaHhQ?=
 =?utf-8?B?bWExcFcwMkhObXFhUk42TkpnbGoweEE1c2JSeURoelYzTEU3OExrQlZxRC9B?=
 =?utf-8?B?eWVoSS9hL2xvMDJNa0c2aUpXWXZTMCtMYWthTlFYbWRhdkhsd2hGQ1ZTRVFi?=
 =?utf-8?B?cHlnT2VCWGVveDh2QjBLbSszb1RUT090bDBWRGs0aXpUb1FoWTVsdmxySXl4?=
 =?utf-8?B?VzRXeGo1eFBpSHUxbHJKWC9NdUI2YVRkS09JRU9GNTVIUGRRc0s0S1NhR0xI?=
 =?utf-8?B?Y0oxQnIzUFNKODRpYnNBMXdZazJDS3dxNlZReUNwaVNEa012NEZCSXQ0clhK?=
 =?utf-8?B?aTVGdVBLbkxvZ0E0RHVkYzBhck0wL2lUVHY5aU9jWEEycmtuU01iZUM4SU9U?=
 =?utf-8?B?cnNEMnFaTEdtTDNkek5hNTdjR2dtaVJVSGNiU254N1o0R0MrU2NDeCtqZWMz?=
 =?utf-8?B?a0xhS01NUjZrWFRKUGdZc25HYWZiRG9QTFo0MUNPTDgxM00rRDdaYkV3blJm?=
 =?utf-8?B?MEswSFNQN2x1RnpjSjlZZXltdWVhQURDb05aL1Y0Z054YzBYLzNINXAzc3pa?=
 =?utf-8?B?RkpRL2V2SWtBekczSU40K3NaWjZSZWI0a1ppUTJwNStvRUgvSlpVSFgwYWpK?=
 =?utf-8?B?cXZ2YnRxUk5wNmxFRTgzZWE2andsN2R4ZVg5L1dpTnEzWUJ1cEJHVHZKUzJv?=
 =?utf-8?B?WjJUcWxLYXZBRUl0TE14TVNWRno5TjdCdTJ6MWZ2VUN6TkdMYy9vNGx3Y1Fn?=
 =?utf-8?B?ekpsM0JUOXdwa2Vldk1lelU5QjRxUlJJY2p4VXpsU2RkSUZxaW1pTjJrZVdj?=
 =?utf-8?B?S1JudHVaN01wSzVaUWVLbGpYYmw0b2lDSFhkZTJFNk9yRHduMXVWdldNb3k1?=
 =?utf-8?B?OE9Hb2ladHM2eXczUzhsalFiSDhKMlVGUk5wb0VTVENQN05BSFhycTBCZTdB?=
 =?utf-8?B?d1hFLzIwakRrZWt3VWVFNXhXb1RaKzBiM05BSjJsNUVzR1hQdFY2dmo4amNp?=
 =?utf-8?B?eXIrTjQvQy9BSURJMktpVDR3Sk5NSjNxeHVaditCN1c5Z0lRd2x0NDRqUnlB?=
 =?utf-8?B?Z0wyVS9JUUluNUxCSWVMNzcveDB2clVPd0RZdUlGaEVWT2xVcGdoekFtNTdx?=
 =?utf-8?B?M3AxejlScC9TMVRHVzBqNStEK1J4Mm1JYWZ1eWx4Z3E2L2ZKUEpvT3dGZ0hJ?=
 =?utf-8?B?ZCtsQXpFT1BNQlNoRFo3d3dCMmVuWk0vSnZrOGZJWHdGMWNCN1VUSXpYRGVV?=
 =?utf-8?B?UE1QeEgwVnkwK0dla0ZwTGE3cnhhaU9XSDUwL3BPK1lxdHlDSCsxM2JleEEy?=
 =?utf-8?B?KzlWZWV0emEwV3h4MlZlQjR6VlBaTHRqc0d6ZW1pYkpITE1QQjE2ZWU3bW1I?=
 =?utf-8?B?ejVpYjl0aVo1ODlFcUdycWdsVFdGSjA0MnhScXV5VUxmakdGOTJrb01UN1dk?=
 =?utf-8?B?TFJOM0lYQkU4d1FITFNDSVo3UTcvUUI1RlVGV2Y2c00weUhTS3JYeUxMdEVy?=
 =?utf-8?B?YmNadURrdER4b3ArdzQ0RDByRzN3b0NlYnUvUU1Bdk56UmNoeDMvaWd6TmE4?=
 =?utf-8?B?SFdzdWU0VWdiZGx4MGc4Rit1dlRyRUp1U3V2aG10N1hyNVFHS1V6MjYrMU5i?=
 =?utf-8?B?MnloUnBiNm9oZzRrOXlZL3p6UEt5WkhQaWRYNXBvQjVaWEQrMnhkMjd1dFVE?=
 =?utf-8?B?RjhTWWNHYldyVE02K3FFQk1RRkpCSTZITXpqTFJqZG84TWNIM29Mck9PYWVv?=
 =?utf-8?Q?uvQYrH4Zc56001sGgtIKcimwf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff1b89f-def5-4117-2c0c-08db20b2640e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:24:36.0018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZyNtBMINqxZHAnrVXStGyLPbmbf2c4IjVOLn2biXSGWbg6sJSJIV7DRrLZslQsBMO1MzAKkseWTmJWH2BszBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

Am 2023-03-08 um 13:39 schrieb Chen, Xiaogang:
>
> On 3/8/2023 11:11 AM, Felix Kuehling wrote:
>> On 2023-03-08 02:45, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> During miration to vram prange->offset is valid after vram buffer is 
>>> located,
>>> either use old one or allocate a new one. Move 
>>> svm_range_vram_node_new before migrate
>>> for each vma to get valid prange->offset.
>>>
>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>
>> I'd  prefer to keep svm_range_vram_node_new in 
>> svm_migrate_copy_to_vram. Logically the memory allocation should be 
>> after migrate_vma_setup. If migrate_vma_setup finds that there is 
>> nothing to migrate, we should not allocate any memory.
>>
>> Does this fix a real issue, or is this a theoretical fix? I think it 
>> should probably work correctly without this patch. 
>> svm_range_vram_node_new sets prange->offset to 0. If no VRAM was 
>> previously allocated, it should already be 0, so nothing changes. 
>> Maybe we just need a fix to set prange->offset = 0 in 
>> svm_range_vram_node_free.
>
> A real issue is same prange migrate vram->cpu, then cpu->vram. During 
> vram->cpu pragne got split, so prange->offset got changed, then vram 
> node got freed by svm_range_vram_node_free, but not update 
> prange->offset. It is the case KFDSVMRangeTes.MigrateTest. I will 
> check by set prange->offset = 0 at svm_range_vram_node_free.
>
> In theory, getting prange->offset after svm_range_vram_node_new makes 
> code logically clearer? svm_range_vram_node_new handles different 
> cases, we are not sure what prange->offset would be before call it.

I think you're right. It's more complicated than it appears at first 
glance. Even if memory is already allocated, it may be on the wrong GPU. 
And svm_range_vram_node_free doesn't really free the BO if it's shared 
with other pranges. svm_vram_range_new can reuse the existing BO if it 
was still referenced by other ranges. So we must remember the 
prange->offset even after svm_range_vram_node_free was called.


>
> If migrate_vma_setup fail for a vma, we can svm_range_vram_node_free 
> the vram buffer got from svm_range_vram_node_new.

I agree. There is this condition at the end of svm_migrate_ram_to_vram:

         if (cpages)
                 prange->actual_loc = best_loc;

You can add

	else
		svm_range_vram_node_free(prange);

With that addition, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
>>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index fd54a00e7229..15791490c23e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -310,12 +310,6 @@ svm_migrate_copy_to_vram(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>       src = scratch;
>>>       dst = (uint64_t *)(scratch + npages);
>>>   -    r = svm_range_vram_node_new(adev, prange, true);
>>> -    if (r) {
>>> -        dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
>>> -        goto out;
>>> -    }
>>> -
>>>       amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>>                npages << PAGE_SHIFT, &cursor);
>>>       for (i = j = 0; i < npages; i++) {
>>> @@ -525,6 +519,12 @@ svm_migrate_ram_to_vram(struct svm_range 
>>> *prange, uint32_t best_loc,
>>>         start = prange->start << PAGE_SHIFT;
>>>       end = (prange->last + 1) << PAGE_SHIFT;
>>> +
>>> +    r = svm_range_vram_node_new(adev, prange, true);
>>> +    if (r) {
>>> +        dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
>>> +        return r;
>>> +    }
>>>       ttm_res_offset = prange->offset << PAGE_SHIFT;
>>>         for (addr = start; addr < end;) {
