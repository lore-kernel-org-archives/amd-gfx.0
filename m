Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FDF60E76
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39FDF60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C73C89CCE;
	Wed, 20 Oct 2021 11:12:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 694D889C33
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 11:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LegAuJnmR65Fn5kNYaUq6mu4pQcVlwbFAdyDkE8qmX3/cyvtq3zvyPbNvN2nVCnJ2GmAwu7Xtf/dS9NvbTe2LWeQWPjdlhADH6pPT7W40FvhQldVeMNejOTRu/6JNlHRLtCauY61qpe7h5A/0GA7/whAdQjBreZeomewo6SnW+sZaZ09s4W4YLW5zB4wWODkIB7oLnKICPPOpuFNvrWY94IslqNz/5/2/M8xi383Qv1D3AM1rnsT+XrvJL23LF4UQq0Q9V4sKeLWfAenLdEV+wxp/vC/rNu23owwzxayPC+MAN0rY2Cou+IuYIaDfL5XbEKMkTRHTOO0ywScKS65Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXKSZwFOMXZnQKiGGXg/vnEs3V76ziCrcJwCou9Mx4Q=;
 b=cbDGZMbtRYt3C3uyZFPfa9O182iYOHzZNeJHPr3VM8+yNTEU7Rmk8U6OhDL8+FiTmw2yvcv7XxN0LAdA9FTQIHEsuYdYOGvFP5hcuHH8a0nj6/c00sxeqAQ8XqY+bphW+o6EJLAMiT0gMVK1p+p1zOzeN0Wj3Ei6VXATnF3BWtXCUkoqRaV+ju4o9LfcyNI4vEhnkHkm8QfO/Jrt09h74PcHhEk8bjVKXSDt03UnnSA4o13uIb17S8L00X3i0kyzlKLAMud90DEK51j7dAmsloZOoJeQuUkk5zGoz367hZI3Vo24Tk6te1xVAIdlqzIewE8vZdQwme4vCVBFHm2t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXKSZwFOMXZnQKiGGXg/vnEs3V76ziCrcJwCou9Mx4Q=;
 b=npa30CSfolDtIK1HSviTA6mFeiUNUA7zrrVgc/tvglKsY34UavCoK8bvmIM/+0F5yz2FiAlZ4eTcG10CKGdnJ6wHeZjOgdZyJQOJzNLddA3sesYY4sS9hSDNn86sL/JVrgI4XktFcMMGRPmoKAz+bKOUdPHQwbET9y+T3zpjM6Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 11:12:19 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 11:12:19 +0000
Message-ID: <80997b49-77bb-ea45-24ef-04a1d1ca44c7@amd.com>
Date: Wed, 20 Oct 2021 13:12:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
 <0cff2a61-0637-cf31-2a60-5326c6bd40f7@amd.com>
 <9737857e-99a2-682d-35ea-f8e5737cff40@amd.com>
 <42e31246-5b59-b806-9eac-b2a95a821fa2@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <42e31246-5b59-b806-9eac-b2a95a821fa2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0123.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::28) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM6P193CA0123.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 11:12:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e88102-8be6-4920-0ad5-08d993ba7b5f
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-Microsoft-Antispam-PRVS: <DM8PR12MB544641BE7CAD0BBC52D7AAD18BBE9@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNUawpSBEkzAxB/KzvUpwRBgTv3YqtHa7ngWvt2zblc7ozlXDEim+KuXR7EqfJJ7O2Q+zRreiltI+8HGGP5oFA2AvwJ0PjmMnfsmE7mw33anuL7+aKKXLKZKoYn9Ym10oJUBJ+6OXQmHKIBArwa8Cns4ctLce6SJ0P3ifCD4MaPNp0lWoUt6usVvAmnmRDiLrnz6yNO+HYoKUXRFyLrju8BVzNhFqER1kazxuxqLBnN+k5A1ttGibBJCGFwNRbtlYwBiRAl1vtssq6g2Kk9iZNjayWX04vIwxfNbrqQWpwYpvGP6tywXfXqkb349nUNnoVW8F0jZFv4F5Rtwu00KnBNJmYOcyF1uVhco3dmk7B8FSshPC1yZ00lFDitNjiMbywnEhNJufCxarLx8lhuICpBZs1wXw9d/4wsHaKsKFU4tAxzvye2Bw/eSdd5ke3SIDCvmsCfeAzDKT2ff84VAlAfzAqprHdk9XtTM1kZUzp+b1U1JBhCx60BMx6o27+1liEnwvo86VP/yKZYsBd1X83xO377MmTf/rmqbXDf6/NpnIF0N9gL1xqL+nQuqiOz8rRy/e4Y4zoNVD5S1uNQhQ1e1BfsE2bB2WFwNRtsafPh+jsmwnkRzLCDo9X7WL+wwMsrBsvx0LSvdsu9w1dMtjeEdAlruaD9ZrSw6ydVhyqpoQxOvoNmNrq3Thgw4uvQDhRrDaovKNfC6jRmYRRMhZHNxyMsDfMfHZ8qlsKoiURc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(508600001)(110136005)(8936002)(66556008)(86362001)(2906002)(6486002)(66946007)(66476007)(26005)(36756003)(316002)(5660300002)(2616005)(956004)(66574015)(83380400001)(31696002)(16576012)(8676002)(6666004)(4326008)(186003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjB3YU5hTUxwZnN0cUlNbjB3VGhHam5ZZkh2Q2sxalNMWDRmYUNQZkxVeDdk?=
 =?utf-8?B?M3hXK0xkc0NhREFIMXFvQ1J3cUhOOFIweWtNRGNTZG9MSlpkck1sTERmOStI?=
 =?utf-8?B?VGZYUnBLYkFDNE9JbHNLeHYvSXlqZHZ3ZzlZY2tRYXcxcXcxQ1FBdVhJU2pk?=
 =?utf-8?B?cE1lWnNvTW5XYXNudXNQWE1QL3JMV0pmalpNV2I2aWl4SUNqWjZQckRMMTFE?=
 =?utf-8?B?R1ZCeXpTZUFPYnNFVmtsaWRVY1R3TE55bzBKWVN4ZDBVRUxPRlBIQW1IUnFL?=
 =?utf-8?B?RERqS1c5VXlkRTJGYTExeFRLckMwa21nTnNEb1FHbWN0Z1lvTFJ1eGdybFhK?=
 =?utf-8?B?bHl3bDRmK1JZVFFNdGNNYys0Vk0rWTdzMHY5WWtSMnRqc2tZMlZFRXFjaHps?=
 =?utf-8?B?RFRJaFhQUEFxUjVPNk8vYzFrVzNaQVQ5OWdySGFNQzlQMXI5SUZNQmt3UFlr?=
 =?utf-8?B?M3QzUG5xVUZDYmVwYUJpKys4cTBTeDdVTzlhbGtUaDB3eG1DMFZ5V1RJQlRO?=
 =?utf-8?B?TElVT0FTczZyclkvdVV0eHpYUDNXcTBiUVI4ODdtQ21hYURGUjI2eUVDRHU3?=
 =?utf-8?B?L0c3QmhBYldLOE1Bbkxrak5naVM3Wld1WlFXejNIUk9LbENwVU5ld1U4aTFm?=
 =?utf-8?B?RzFYZDVxdnA5cXZ4aE4rZlhUNjA0U3VjNzNGeG9RckhrL1dvRU5Xb1QzV3Bs?=
 =?utf-8?B?emZNNzNZaGV4a1d0NzZTVGVEM2tWaXk2VXVkUkRFZnBxNjVNb0ZSRFBJMmFM?=
 =?utf-8?B?OHBhRlJLRmlsaVVtR0FKRXhRNkhDZWVWUU5lckpGYlVuRjk0VHpXVnp3RHhW?=
 =?utf-8?B?VWEvZlRoMHVXeXhyWmxtY0ZQdUt2b2NmNDcxV0NkZDBocnM5U3BGOUxNWGs2?=
 =?utf-8?B?ZlArN3ZpK0lqbE1VdWtpWXhNY0grWjB3WDB3ZFhxNDZHQzI3U3R0WUZCem41?=
 =?utf-8?B?bHlyNlllaWFCRk1yb2NqSzBRYXE5NkJZMkh2UXJVenVmTDhKZm5GdUlib2N6?=
 =?utf-8?B?WG9BMlBNb2pCbExpbThmZlNzK0tMcmgrS3JxaVFGckxEQWRWeGtVL292SFVu?=
 =?utf-8?B?YWp6Q1NISmpBUEgrUlE4NnkvTElqdU5sYmZlOE1rOTVaRk5vQ0pzQzZ0R2xy?=
 =?utf-8?B?YVAvZExoMHJKWXp2Wk5NL1lLeVdsUVB5VWVJdWw2T29mZEU1cU9lK2lRZUc0?=
 =?utf-8?B?aUhDZTY4WXJ1c0xta1pkZW55QWdNZWNqYzVwdWVKU0dwVy9IZE9TTENhcEYy?=
 =?utf-8?B?SmFjZ2k5OUxpUDhhNUMzeThveURTblpIcFZSWk43OVVpcmFRTnd4VGZkV0lh?=
 =?utf-8?B?WUVSMmhFb2wrK0VFZldaQjFHTEYrMEJWaWZ6SW5PWkdSb0xzWkdOQkJvN0d1?=
 =?utf-8?B?V1pkSUtEY2dXL2dCVUVYb3dFdHNpV2xpK3hOSUZZenRDZUxSK1V5Nk93Wmpo?=
 =?utf-8?B?OGFTcVliMUJHSVNmc3pzdnQ3UW45dmJYOG5jOURHd0RQWXdINmo4R3FCNmQ1?=
 =?utf-8?B?cGhJeDNJNDVWdExaaDhlaXlWdFJWY0hqRFNoTXorMml3ZXV4MUFRdVBKMFpB?=
 =?utf-8?B?WVpEUGVwZUcvLytDeW11MmJNTXl0OXJDUWdjSysrald3ak0xZlhwQko5eHlh?=
 =?utf-8?B?eE16SGcrL0V3MkFhY3JLQVdOWlNlNm9waXRsdzF5U1dmZVMrN3ZjNStBcGVS?=
 =?utf-8?B?VlBRRFl1QzR4bEpaZDl4VFVXVFlMc2ZieEQzeHZGYnV0S3dUckprVkVkRXZX?=
 =?utf-8?B?eSsxcDhESDlIN3k2SjBOR1FLTDlRUjVjTUZBdkhmY1dMbmsya1ZHNjZBYlJ3?=
 =?utf-8?B?anE2elFmcDdmUncrR25RUEdxS2NwMXFidGJBSFUyMGxTYWpreVh2MzZYVzZZ?=
 =?utf-8?B?VE14Vng0WHpZWjNtbE02RVBaRm9kL1p5SnVjSXBZUHZncVU3YUJYM05lUy93?=
 =?utf-8?B?RjJHK2s2QjF2VVZUYjdaQ0VmaEdBK2cyb2pBcUhsemJzeTN5dFFUYU9EV3NS?=
 =?utf-8?B?aEpnTDIyOU90Yll6TnhiUUlwcFJXbEN2N1dKaE0xL3gwcS84Z0ozSDErNjAx?=
 =?utf-8?B?T2VyVDI5dE5ZcDlLeWdrVHQyS0NabEtVUDRLSnpiVFBEM2ZEeGt0SEkvck0v?=
 =?utf-8?B?UjJ3REtjcnc4U25FU0h1ZmJKL1U0MlMrUGp5aFY3UTMwRjh2OWQ2YmtlbnhQ?=
 =?utf-8?Q?efvECjHglluPF5eO3v0ndEY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e88102-8be6-4920-0ad5-08d993ba7b5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 11:12:19.5141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T5R/oB3nO0V5QM+Jnn+nZ+81efF56yDYCAXoLxxkVSDCIgCi/+xCul31UdY73TWh6y/Fwy9kXdjRFM+sSPZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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


On 10/20/2021 12:49 PM, Christian König wrote:
> Am 20.10.21 um 11:19 schrieb Lazar, Lijo:
>>
>>
>> On 10/20/2021 2:18 PM, Das, Nirmoy wrote:
>>>
>>> On 10/20/2021 8:49 AM, Christian König wrote:
>>>> Am 19.10.21 um 20:14 schrieb Nirmoy Das:
>>>>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>>>>> any ttm_resource_manager pointer. Also there is no need
>>>>> to force other module to call a ttm function just to
>>>>> eventually call gtt_mgr functions.
>>>>
>>>> That's a rather bad idea I think.
>>>>
>>>> The GTT and VRAM manager work on their respective objects and not 
>>>> on the adev directly.
>>>
>>>
>>> What is bothering me is : it is obvious that  the 
>>> amdgpu_gtt_mgr_usage() for example should only calculate
>>>
>>> usages for TTM_PL_TT type resource manager, why to pass that 
>>> explicitly. I am trying to leverage the fact that
>>>
>>> we only have one gtt/vram manager for a adev and the functions that 
>>> I changed  work on whole gtt/vram manager
>>>
>>> as a unit.
>>>
>>
>> Don't know about the functional aspects. From a sofware perspective, 
>> amdgpu_gtt_mgr_*() operating on struct amdgpu_gtt_mgr *mgr seems more 
>> logical.
>
> What we could do is to pass in amdgpu_gtt_mgr instead of 
> ttm_resource_manager and then use &adev->mman.gtt_mgr.


Sounds good, I will try this way then.


Regards,

Nirmoy

>
> Regards,
> Christian.
>
>>
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 
>>>>> ++++++++++++---------
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
>>>>>   4 files changed, 24 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 41ce86244144..5807df52031c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct 
>>>>> amdgpu_device *adev,
>>>>>         amdgpu_virt_init_data_exchange(adev);
>>>>>       /* we need recover gart prior to run SMC/CP/SDMA resume */
>>>>> - amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, 
>>>>> TTM_PL_TT));
>>>>> +    amdgpu_gtt_mgr_recover(adev);
>>>>>         r = amdgpu_device_fw_loading(adev);
>>>>>       if (r)
>>>>> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>> *device_list_handle,
>>>>>                       amdgpu_inc_vram_lost(tmp_adev);
>>>>>                   }
>>>>>   -                r = 
>>>>> amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, 
>>>>> TTM_PL_TT));
>>>>> +                r = amdgpu_gtt_mgr_recover(tmp_adev);
>>>>>                   if (r)
>>>>>                       goto out;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> index c18f16b3be9c..5e41f8ef743a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>>>> @@ -77,10 +77,8 @@ static ssize_t 
>>>>> amdgpu_mem_info_gtt_used_show(struct device *dev,
>>>>>   {
>>>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>>>> -    struct ttm_resource_manager *man;
>>>>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>>> -    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
>>>>> +    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
>>>>>   }
>>>>>     static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>>>>> @@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct 
>>>>> ttm_resource_manager *man,
>>>>>   /**
>>>>>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>>>>>    *
>>>>> - * @man: TTM memory type manager
>>>>> + * @adev: amdgpu_device pointer
>>>>>    *
>>>>>    * Return how many bytes are used in the GTT domain
>>>>>    */
>>>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>>>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
>>>>>   {
>>>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>>> -    s64 result = man->size - atomic64_read(&mgr->available);
>>>>> +    struct ttm_resource_manager *man;
>>>>> +    struct amdgpu_gtt_mgr *mgr;
>>>>> +    s64 result;
>>>>> +
>>>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>>> +    mgr = to_gtt_mgr(man);
>>>>> +    result = man->size - atomic64_read(&mgr->available);
>>>>>         return (result > 0 ? result : 0) * PAGE_SIZE;
>>>>>   }
>>>>> @@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct 
>>>>> ttm_resource_manager *man)
>>>>>   /**
>>>>>    * amdgpu_gtt_mgr_recover - re-init gart
>>>>>    *
>>>>> - * @man: TTM memory type manager
>>>>> + * @adev: amdgpu_device pointer
>>>>>    *
>>>>>    * Re-init the gart for each known BO in the GTT.
>>>>>    */
>>>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>>>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
>>>>>   {
>>>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>>> -    struct amdgpu_device *adev;
>>>>> +    struct ttm_resource_manager *man;
>>>>> +    struct amdgpu_gtt_mgr *mgr;
>>>>>       struct amdgpu_gtt_node *node;
>>>>>       struct drm_mm_node *mm_node;
>>>>>       int r = 0;
>>>>>   -    adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>>>> +    mgr = to_gtt_mgr(man);
>>>>>       spin_lock(&mgr->lock);
>>>>>       drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>>>           node = container_of(mm_node, typeof(*node), 
>>>>> base.mm_nodes[0]);
>>>>> @@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>>>> ttm_resource_manager *man,
>>>>>                    struct drm_printer *printer)
>>>>>   {
>>>>>       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>>>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>>>>> mman.gtt_mgr);
>>>>>         spin_lock(&mgr->lock);
>>>>>       drm_mm_print(&mgr->mm, printer);
>>>>> @@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>>>> ttm_resource_manager *man,
>>>>>         drm_printf(printer, "man size:%llu pages, gtt 
>>>>> available:%lld pages, usage:%lluMB\n",
>>>>>              man->size, (u64)atomic64_read(&mgr->available),
>>>>> -           amdgpu_gtt_mgr_usage(man) >> 20);
>>>>> +           amdgpu_gtt_mgr_usage(adev) >> 20);
>>>>>   }
>>>>>     static const struct ttm_resource_manager_func 
>>>>> amdgpu_gtt_mgr_func = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> index d2955ea4a62b..b9b38f70e416 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>>> void *data, struct drm_file *filp)
>>>>>           ui64 = 
>>>>> amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, 
>>>>> TTM_PL_VRAM));
>>>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT 
>>>>> : 0;
>>>>>       case AMDGPU_INFO_GTT_USAGE:
>>>>> -        ui64 = 
>>>>> amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>>>>> +        ui64 = amdgpu_gtt_mgr_usage(adev);
>>>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT 
>>>>> : 0;
>>>>>       case AMDGPU_INFO_GDS_CONFIG: {
>>>>>           struct drm_amdgpu_info_gds gds_info;
>>>>> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>>>> void *data, struct drm_file *filp)
>>>>>           mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>>>>>               atomic64_read(&adev->gart_pin_size);
>>>>>           mem.gtt.heap_usage =
>>>>> -            amdgpu_gtt_mgr_usage(gtt_man);
>>>>> +            amdgpu_gtt_mgr_usage(adev);
>>>>>           mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>>>>>             return copy_to_user(out, &mem,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> index 91a087f9dc7c..6e337cacef51 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>>>> *adev);
>>>>>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
>>>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>>>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
>>>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
>>>>>     uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager 
>>>>> *man);
>>>>
>
