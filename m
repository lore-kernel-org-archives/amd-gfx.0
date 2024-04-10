Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC0EC67861
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 00:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E35710E35F;
	Wed, 10 Apr 2024 00:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+VFgThP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6E310E35F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 00:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mydd5GluibsfZLX94ySzowyGaAkk/NBYuzY9Sh2rHMLqFdgIj0Nw/nZXUU96W1rKiu/iVOQHv+dal0orH5VoFpkR9zt0zWoNcLdglzFpHjih3WBXHHFJAis9Ve94SXVfYltoLvX0CKU0AApeuxU3YPvvsSP3It/4OHih3I7T7vnUrLMOpc0/2FzNeOt2ig/+nsmWVGxkk6+avhFJuV+AVptfT5+vE8z2cjy7Yu3HUkKz/uMLsIacIkX0CzauH9DIEvW/AGAQww/gePT6CcwxtblViAA56urMS/1nXQkYKVpvKQGQ2fUyRNtSGhHD01Gp2gxiBszNLZOJWUKq1GVg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l13haOv6+kpxAFHOf/m4YLpIJXIoXJ6i3IJDrelhfiY=;
 b=PhcUoTRM454UOQ36EAY81hd9QIQPMqiskBcPhFTY24Tmyk52Tbr1MgHS4Jh9MJVHQl2ZhnxOzZKX5oSSKBUt9XH63wZlQws8nQ0QfSB9pRIhfRnpHkFt9h838FsDYGBW+w2fwAP5SgDdr7bvExOxU3cvf73Q0vDw+oMGOfRulf8QMh7A7YURq9lNT0pby+QNxxzmbafJZkcVcy3XGMxLVIegmsUQFRty8WB0EXsNgt31qnypzeXHWpy9hcUz5mtpnBQZXQZ1XdlHUD99K2PgqPhgZLw5b+bdfiIKCozUY73sxojQwiWqr4qSQf+7kRDV6NyLmJe7JAPbJ9KvYCbxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l13haOv6+kpxAFHOf/m4YLpIJXIoXJ6i3IJDrelhfiY=;
 b=e+VFgThPgRZZ8Oi4EtCh2Bn0sBbpRY3VyvnUkVXe32ILVfWLtZS8yWZgHhU6YXL5GTtXu85AxkLVm6Goq2G+dAN7JrPH5DUzjKWoogZeDY5yqodtWJLlkHAw8vJtwClFqpPQup3bTZ3ihueB57hOJ0K12UfxlFerhAY5KDRdd0E=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 00:32:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 00:32:28 +0000
Content-Type: multipart/alternative;
 boundary="------------RjbEc3ANCLCzJyxrgLSDVTs5"
Message-ID: <d7c92064-1d7c-4e3f-8592-f81dfa8593d5@amd.com>
Date: Tue, 9 Apr 2024 20:32:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: make sure VM is ready for updating operations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240407045236.3487634-1-Lang.Yu@amd.com>
 <0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com>
X-ClientProxiedBy: YQBPR0101CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8292:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j11RJ/pYNuu6cu3Zt5is4TxpIUIMi4HAfAm2I91db3ZkRNUlRFpcv/I53OqZ1C/YvYx8X4fi153i7MkI4QmaSR/4qREvnDAN5Khuo+khwGjR69AsCM4arxTqd6vUtlHhwkkvMxuOopMNDMVvP5YuhAPe03lEZClCgOMsY0yJ2WBzQ79nJlTMDUTEM4ijmwtiiViX2gIhJQuX3Z9cEjd3EbfIK6KUNoGPPvLvNj4OeLc1iTyht70Xk/0Gxz9jayQE3di9rIAg7eMyPp/m8laoJe9c+FosZPVq6NAYFMS7JjonADortItopTH5MlBtpmVhvDjZlMQXgILs+0RXHgzbEt0OB8L3YRj9UuqhK2ZGaaCL0jfkAqzHjw2eXpmVYekkuDxdfz1VAGfAjs0/wWebucowKWoBQ3TDScclPWEcNdK2OTO3u197t7T3Pc+GidxgjWfshGpLzTwyPGkUWJLlkZ5HL04gqTMfd/cT4UcghOvIjOsGFBiHCDWkSDry4Wt0ziuz5MC9Ov1J68c/NPCuCaQAo75rWQ830MljdhXEYEWfU5UjGz4LTvJA/GUiee7W2SVOz45+klYDW5TU5SDMVZsKe3SIf6xQeQvR/0FU21ufPKcDUm8bJbycqLUEKwZzm2utHoe0fIwQOflYgqdjSEPzTHFxsEMcpZOxj7i1/xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhSZXlxUVFWRk5vaWYzaStKbUM4UGw5NGlraitvVHFkRUlJQlp6c25oZS9B?=
 =?utf-8?B?aW03SmdrQWxBZ1BmYVZKbmtpMU9nQVY3VHJuOWNVNllsc25iS1ZCeVVUQ0Fp?=
 =?utf-8?B?bmFuVG1LQ1ZBTkh4ZDFMWkN3WWI2cjVDU21aUVA4SzhFbW9aY1U0RkNQQjZp?=
 =?utf-8?B?QysxaEtPVW1NL2FFWjkzSmRlUkdvRndEazYzZjFnbGlqNmhSYXQvWHFWeWZ0?=
 =?utf-8?B?cVhnZ241RVQrZTk3TitDQ0IvVWFaTWhIa0hKNHFRdDdYMVJNekNCSzMwRmVX?=
 =?utf-8?B?ZmwyUjl0SHc1UlBKQ3pmT3BDVjVvN1FxZ2QzaWVERXhoTUNTaU5zd3lpbWox?=
 =?utf-8?B?SVNHR2EvNlova3NhZXpPQ0lqbU1vZ0JRTHp4aml6OWpWK3hycVFScnVMeVB6?=
 =?utf-8?B?TWkyVW9WNGRpRFdqWTd6eURGRW80UiswT25TSHZ0TkF4bFIvVGxCbVVsb2FI?=
 =?utf-8?B?Y2lBQmNyaGoxTFAvTWtaWTVDY1JwY1hOdWJzU2hBNGZQYWRveU5oQTg4eVNT?=
 =?utf-8?B?RUJ0SVJONkdLRVozeEpod0JjZ0w5NGgzZHpOMlNqYXZSNFo4eUJ5eGtuVU4z?=
 =?utf-8?B?SS9SdUo1ejlxSXhCNDNMZ1ZBYUhZbG4rLzVWakxFQmpsRXhSeXZwTllXRzg2?=
 =?utf-8?B?K0l0VGI1RXhib2FYWTNlbHcrQVJXbWwvTW5ZQlBEVldoSTZyMEtmR2IyOHI5?=
 =?utf-8?B?T1hzb1BQSTBlRUp3WEF6ZEFhUEJ2YlZISVU0bWhTQWZuS0p5dGptNEpwMVBW?=
 =?utf-8?B?YzRCWTZuNkNaZnV0MG5UYklKVXZqUUZaYTRlR2ZodTFVOXZzTUs3Vzd2Ym5I?=
 =?utf-8?B?b09heTZUQTlhc1lpcVVTT3ZtRi9TVy9VSjdLdURJNm4vbkk4WmlYdGRwMXMy?=
 =?utf-8?B?QzV4bW5PazdUencrZFdZNjFJZmdGUjk0MGlCeXBDQkg5WHA4WCsyVVhvY1lv?=
 =?utf-8?B?ZDc1aUg1UHZkQ2diQ2Q0R3dGQXFLMnBScDRjUUZ6NExaQTZvQUFPOFluRUFx?=
 =?utf-8?B?UW0ycFBtUG9yT2UvczFKdDVBNVVlQlc0UnJjaTU2dmJKUnFoNFJ4TXJCeFJv?=
 =?utf-8?B?YmtuNUZKYzFQb2JBSDIzMEU4c1R0VlJqNjlWa2xCSldEb3YvSkcxVktmSmRa?=
 =?utf-8?B?d3d0a3lpSkxtTkQzN1hYczRWU0tVcE1OQmY1L2I1TlNPOGFML0ZCbjdUeXpN?=
 =?utf-8?B?bkN2TVpWMjhwR1RydXlxVzJEVHJiWDR6eDN5eHhpOFJ6WHlLVWJQRktFeWtt?=
 =?utf-8?B?SHVlWnR5bkxLcXpKWUM2TGxFcXdVdUc4RGZzQU9HZGdnWjhqVENNcEd2M3lu?=
 =?utf-8?B?Tmh2d2JjL2Q2cFNKS2VIK1M3dUJGbTh6c09hcHRVWkxIdkJKaDM3cmRlZlJx?=
 =?utf-8?B?VCtOcEg1RXRBYmREenlHWjl3cTVvblhsbmVCRGFJNlZxMThUNGJFTW9HNFFt?=
 =?utf-8?B?Sjl3TkFGSmJIRTB3ejVYVC9rYzJ5bjlHOFlUVVFiSnYySk54WUJGZjRnTmNj?=
 =?utf-8?B?M01KVkZQTzZ1QU5ublkwSS96K2FyNmFrWEtlZkE2NjRvcXM2YXFac1VMamJY?=
 =?utf-8?B?YjZWb01yL2lYMlFFYVd0Qlg3RkM0K3VBUWJKR2oxYXpXb2pBMytVcy9QU1E1?=
 =?utf-8?B?QmdqYmZFb0E3OWhIOTY2ZU42L3ZUQUlRcVptTG9vTUV4b0lUcXBtOEc3eENv?=
 =?utf-8?B?bTdFWWp3clJIQUZyOFNYakFrWW5kMHp1Ym9YRjc0UTFkMDAwWEk0MGEwZEcx?=
 =?utf-8?B?dStCR2tjUkN0MUZCNzNiZk9SektJQmpMNitYKzh0TG15a3c5anFweXk0dU1P?=
 =?utf-8?B?a3hnRDB3d3pDSy9VY0VxcWhrVm53eDdDRjkyZENmMkVDSlBYeXZQUmtxSElq?=
 =?utf-8?B?Qmp1MHlpV2Q1NExWdVRLbU9TVElhUEIxWmhKSXMyTVNnOUlTdnNIWmdyZkU4?=
 =?utf-8?B?aGg5UWFJUGRJT294YktTM3RIdHlwN1NmdG50QjV5S2tGaDhTN3ZjVDVmSzMr?=
 =?utf-8?B?SWZmcXJwZEJmOGpKckY1S2FIcmluL2J2QjJOZjRDZkgxVDZkVXROMUdKT0tJ?=
 =?utf-8?B?eGo3SVpoMUliL1dzV0xpWHZ2eGFCcjJ6bDlpandKbldsMkUxMkFScnlhcGJL?=
 =?utf-8?Q?79heYiHyB4znWlhJT+MrY8f1/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ec1d6a-4c0d-4050-01ed-08dc58f5b38c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:32:28.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57hhn4c1YMjbfPd0KayZaMtMTL9RT6kIznut0z4T5QUxS5JM3/ymAxrOkZdUme79jagoOD35AfYSm3blP+WDww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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

--------------RjbEc3ANCLCzJyxrgLSDVTs5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-04-08 3:55, Christian König wrote:
> Am 07.04.24 um 06:52 schrieb Lang Yu:
>> When VM is in evicting state, amdgpu_vm_update_range would return 
>> -EBUSY.
>> Then restore_process_worker runs into a dead loop.
>>
>> Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in 
>> compute VMs")
>
> Mhm, while it would be good to have this case handled as error it 
> should never occur in practice since we should have validated the VM 
> before validating the DMA-bufs.
>
> @Felix isn't that something we have taken care of?

The problem I saw when I implemented Auto-validate was, that migration 
of a BO invalidates its DMABuf attachments. So I need to validate the 
DMABuf attachments after validating the BOs they attach to. This 
auto-validation happens in amdgpu_vm_validate. So I needed to do the VM 
validation after the BO validation. The problem now seems to be that the 
BO validation happens in the same loop as the page table update. And the 
page table update fails if the VM is not valid.

I never saw this problem in my testing, probably because I never got my 
page tables evicted?

Anyway, I think the solution is to split the BO validation and page 
table update into two separate loops in amdgpu_amdkfd_restore_process_pos:

 1. Validate BOs
 2. Validate VM (and DMABuf attachments)
 3. Update page tables for the BOs validated above

Regards,
   Felix


>
> Regards,
> Christian.
>
>
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 0ae9fd844623..8c71fe07807a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2900,6 +2900,12 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>         amdgpu_sync_create(&sync_obj);
>>   +    ret = process_validate_vms(process_info, NULL);
>> +    if (ret) {
>> +        pr_debug("Validating VMs failed, ret: %d\n", ret);
>> +        goto validate_map_fail;
>> +    }
>> +
>>       /* Validate BOs and map them to GPUVM (update VM page tables). */
>>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>>                   validate_list) {
>
--------------RjbEc3ANCLCzJyxrgLSDVTs5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-08 3:55, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com">Am
      07.04.24 um 06:52 schrieb Lang Yu:
      <br>
      <blockquote type="cite">When VM is in evicting state,
        amdgpu_vm_update_range would return -EBUSY.
        <br>
        Then restore_process_worker runs into a dead loop.
        <br>
        <br>
        Fixes: 2fdba514ad5a (&quot;drm/amdgpu: Auto-validate DMABuf imports
        in compute VMs&quot;)
        <br>
      </blockquote>
      <br>
      Mhm, while it would be good to have this case handled as error it
      should never occur in practice since we should have validated the
      VM before validating the DMA-bufs.
      <br>
      <br>
      @Felix isn't that something we have taken care of?
      <br>
    </blockquote>
    <p>The problem I saw when I implemented Auto-validate was, that
      migration of a BO invalidates its DMABuf attachments. So I need to
      validate the DMABuf attachments after validating the BOs they
      attach to. This auto-validation happens in amdgpu_vm_validate. So
      I needed to do the VM validation after the BO validation. The
      problem now seems to be that the BO validation happens in the same
      loop as the page table update. And the page table update fails if
      the VM is not valid.</p>
    <p>I never saw this problem in my testing, probably because I never
      got my page tables evicted?</p>
    <p>Anyway, I think the solution is to split the BO validation and
      page table update into two separate loops in
      amdgpu_amdkfd_restore_process_pos:</p>
    <ol>
      <li>Validate BOs</li>
      <li>Validate VM (and DMABuf attachments)</li>
      <li>Update page tables for the BOs validated above<br>
      </li>
    </ol>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:0bc7bc06-0df8-4b19-b4db-06701c2fa9d1@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
        <br>
        &nbsp; 1 file changed, 6 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 0ae9fd844623..8c71fe07807a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -2900,6 +2900,12 @@ int
        amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct
        dma_fence __rcu *
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_create(&amp;sync_obj);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; ret = process_validate_vms(process_info, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Validating VMs failed, ret: %d\n&quot;, ret);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto validate_map_fail;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Validate BOs and map them to GPUVM (update VM page
        tables). */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(mem,
        &amp;process_info-&gt;kfd_bo_list,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validate_list) {
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------RjbEc3ANCLCzJyxrgLSDVTs5--
