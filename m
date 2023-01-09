Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F65EC5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 20:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36A10E502;
	Mon,  9 Jan 2023 20:34:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BF710E502
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 20:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjWlyF2TM/Tsix05z2M+FSectqKn2CqMN6q+0R0Xoc5nXdmGQ4VBd25P3s3xiMYktXI23qikRC65DOEHq+f4vuqJhAbCBLrIdSrXAkgKgoNJVosggkMTPVjH7X/Gv8/+ZDwG1s1H3Bpi2qnzlBoPhh+1LExBvtBjexJs/xq40N/7udCRE691ZxLHDtcH0QiXXocp/oahxg1IG4j0JdOScCZIZ7w8ZOyI9K0cOVG2BgKCIC2DPVae+0TZHt/ZgNuje5nsh/DGWh6ofmewoyeyaP21TiehkxPz9MEbRHetUaesmGUYoOdo+8kakOGAi8dq2rHQZLOlqrqX+c8xN/fOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aichDluIcXeOk6KX+Rnfy6xw/OgDY3p8Jbw8MAA3PaE=;
 b=Nz24sYnkABj+ISH6dOKPFpWfoHBymC09KKwebPIXdQ6pZkwnUVNq+NMVtiULqgn0qT3HY1sODw6Lb5XlwuwHfNC3Z8aWJgmYQ7cfAOWkLj679YLu9BitYeBm5OeN8inVVqH8yeHrEqPNRHq3dXwQFfaKeF6a3+697uv7kyg87YqVEKT7z+VRSqawxkceSQEE13dhX7niWkSPSkLJTssiOOhvpSlrYIPqQwyK0HmpfatnetjzX/KgvWKluBoubcV1IqQJwJBhj75QN2QgvCSxUjDcA834GQ+AKRcQMJs55fU6Y3JGdsLIZwA5FOLlrvTuZBvY3Q5inEn8ovshYSOAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aichDluIcXeOk6KX+Rnfy6xw/OgDY3p8Jbw8MAA3PaE=;
 b=xJ+y74hLKdcWpXWXos5125qCmJRBbwZG4lE3xBni80Z67HG13kG1F/2/89SxNg8H819DBSyFpSyxaX1FFR5iVNdCqj0q6wYO6P68rUAqFCQtRgFOaMtbx7PeGL7jGysCnJ7hCmM80MaQC854aX2wszi02GE55uERGit3gbIA4sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:34:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::82c4:6898:1cf7:12a1%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:34:19 +0000
Message-ID: <960183db-9c65-74de-3600-f9568b15579c@amd.com>
Date: Mon, 9 Jan 2023 15:34:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Add sync after creating vram bo
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230109192743.133767-1-jinhuieric.huang@amd.com>
 <ebef9ae2-6b9d-7bd9-5b30-8935009b3260@amd.com>
 <e8d73f0b-8b99-2f5a-4eca-bf9453da58dc@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <e8d73f0b-8b99-2f5a-4eca-bf9453da58dc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c3b2c1-ad09-4bdc-7500-08daf280e23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Yh93flqLuoY4y8/ittBSCKsj4sXXOm2TcuIAwViOnEuGpxtJbHSPBICIEcuqt/1CVD/Fv7IEvBz5E0O5KW7rTy76XTv7fbjL4mrFULUv1elHYoZ7RkrwdITFaLDOuyo/eVSvMCM85aI+f17E17rhv4t/hcsJZHSno2mjsaSVgNPDGWi8lnJ9pv2TBk/9IpuogyUoQt5obIqEznm/Z5behTdYyJqtQuEr7HfnP8v4/DtYpmqW4zkRIFhjBNzo5+SfzgTLUm/sPeuBrJ0eLim/YcLn8VVVmtyG2E6JWO3vA7f6SK9FydY4BtPol9ookuFMkWCBtu1unP03SY9ynG0uq1VIUE9f3Phn5WmU8YVm0gq5qO9JMNpFL0vOEBEqcGzw4ZXrqDx8S79w8KI6ctHpk4zJKa3ItorXwnDR+4DQYutW6AaBH9Z/RbGLvQyYBdo1Xp9BPFBs0KbQEt4b9yySk7WNR9UD+V9cFWe8/GHT+qtryxEeGMbxs/MYczFT8m46q7YkTS/+sQ5mYntEy95xMsKtaXsOFaN3jeCaw+BJG259uDMIrocjmx6exGLcucQOtOniv5A0lisj1yR2kU/UQ+9NVGzA/F42Kz5npYhO/ZmhgvK5aNLAueusAEd8cDgjv57XCuAr4JNEs6kw9h/bsYUZbXAvvpHl+D6hmga6f72whcUk1VJfUX6zgIlcacTN6qX0uuiBsC0Rxlf3ePzPlHofw3zrrm2mCI+m1f9Kg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(41300700001)(110136005)(316002)(2616005)(36756003)(66476007)(8676002)(66556008)(66946007)(31696002)(38100700002)(5660300002)(8936002)(2906002)(6506007)(53546011)(31686004)(6486002)(6512007)(186003)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNib0V1LzJZWUpldHdEWUp1VzBIYXN1Y3h3bnZkM3FNQ1I2bTcrYUtZZmxN?=
 =?utf-8?B?Vk9YSnZQN2F1cUk5Z0pQSFN4aTJiSzdiOWNRVWRsMXMyMmhmU1pZRC9QSVF4?=
 =?utf-8?B?citWdzg3WE1TYWJkN0t1bmxOOGFmbllxUmtDMkE3eHR6NVNKb254YllmWWJE?=
 =?utf-8?B?VEQ5YVNZR2hoNDZzTkR2QWZEMXorS3R0Z3ZxUjdrSkFCcVBoTlVJUXc3RVVv?=
 =?utf-8?B?cTZZbTRhZDhuQnhicjhXYSsyK2YvYS9SMjR2WEw1ME4rcVU1MG1kSDdNd28v?=
 =?utf-8?B?T0F5TzJKczY0YjlwdmJXanQ3azE1cWdqU0NEMWh4UkV1cDU4UkRtbVZmRkhP?=
 =?utf-8?B?MTJweDhEeFJNMVBQRU5yTGhyM1c4RDZSV21rOFBIVzlEdTVoNlU2NW1xeS9Q?=
 =?utf-8?B?bTBSVkk5b1VpRHBGQkZWRk5URkQycHFIQ1VLd0Q0RnpWdXo2LzQ1c2RLeFBL?=
 =?utf-8?B?R1dyVk1peUJVT1dFTzBXYmp4ZHZvbGJyM3pDZnEvdlVjREQ2SmU3WWdRdEtk?=
 =?utf-8?B?ZXVYSUdFSXBLWGZGcUNnYnpKUjhrL0c4VmlOWDROVzBta1ZxSmdlYUhlYWlB?=
 =?utf-8?B?bFZBTkhMV3JHdkQxQ1pRa3FGckNHNXlBL1RIMnJBZXlyYWJIV2ZCc3hJMDQz?=
 =?utf-8?B?UDEvLzlzRDlpdU16b3R5YUlPOWYzeUxGMVhpMEYyeWRXZjVEb2lMam4zMm40?=
 =?utf-8?B?VTNqMFd4VnY0ZWRycENTYXVJc0lMbXBDcHp0VVhRRUlXd2srOUlRbjlWV1Za?=
 =?utf-8?B?QmNPa282aWF5UEhPcUpieCtNYWUvakl5ck5qWmVCTGxuM0NGbTZYV2VnVXdI?=
 =?utf-8?B?M3dYZXJXWWE1L1pmcmJ5Z0ljZVlXV0EwMjd4UnFKTUFiSzBhTVU1bXhyVUxl?=
 =?utf-8?B?NXlPc1NYQ2VoNlh3TERuUGJEanBQK2J4NHVsVU9sRG1TSHB5aG1aT3Axdklh?=
 =?utf-8?B?ZHlMdWhCS0hSNmIyb3pKckpuMWVsL0tQZ2Zyd0IycXRXNml3OTVHQTZTbUFy?=
 =?utf-8?B?cDFWSDhWRk5DSWQ3K1pseGVzZ2lFZFQ3ZERMYWYxTS9ubUtqNGtjaUR1RzJq?=
 =?utf-8?B?ck5pRHVoSjRENTI3UDQwM25Lc0VqYW85amdmN3ZaWUU4WThyNS9vVEdpSXgv?=
 =?utf-8?B?ZTdXY2E2NjZJa3RSSExlZFVyTHo4a0NRc0YwZjVyOEdrZTlnTDNuL0JYeFBu?=
 =?utf-8?B?OXcwVklUN2h4Yyt6Y05KWkR0YkFxZjhadWNHbGx6OGpnYm01ZDQ5OGZ1Rkdn?=
 =?utf-8?B?OEtJNmdWL1V6SEN2dDZmV3pYNlJGbnM5ZDAzSTUwWWRhc0pwU2pkMFJLQ1E1?=
 =?utf-8?B?c1RUZENyTFdhRHJEMVIyc2dlcW5lR3ZXY2FWSzZjZGI3WXVMVWI5KzRMZXNS?=
 =?utf-8?B?ZWJFdnB4aWtVSzZFcHN0cmNOSFRsY1Jpb3IzUHNWRFpMbjVsUDQraTFjUGk1?=
 =?utf-8?B?VDFncDgvNWx2TG5zVFF5VVpQWEVJK1ZCaHFPSkgwLzJBSmJnNGlsM0plREFM?=
 =?utf-8?B?WWtuWFZMbHFEWFQyQjd5RG5CQlhGWHpuNXY0Yk1OK1RFVFh2TTBrSUZBZFNu?=
 =?utf-8?B?RmpQbGx4a1RVMkQxYnI5TkdEYW01OFlnTWU5WW1mVStKRG9TT2trck5yUHor?=
 =?utf-8?B?SFFrMDArZXlkOU5CdjdhRVRlbEpCTXFXUTBIWGx0emkzRUxaWVdVYUxySisx?=
 =?utf-8?B?bURnMkxHSWR6NW42cTl6VGtLeXBJVUwvclg1UzVHMjJWN2ZVcllBYmZQQkFV?=
 =?utf-8?B?ZS82azdkckpJaVg3UlBXUThwSGVwNkRqcmZjSUNlOUJiOE1DWVBaRkI5YkdU?=
 =?utf-8?B?K1V1emVyRzh3Tm9lZkplUjlETi92NmVBbEl4RG42N3JDdVFOV2JyaFZvOFR4?=
 =?utf-8?B?ZGdQcEo4WjZBY1dhNUMzV0lmb0cvRnREaXRWeTFoNFpWMDhkdGhFelhkMjZR?=
 =?utf-8?B?LzhITUtmbStYdWF6TVNBbEFRK0pTUHJTVWl1NjBMb3RKWHE3VlJwRnM4aGZi?=
 =?utf-8?B?WjNnKzUySnBZVXlzYy9RaU8yWDVYYU5vQ1lVLzJRTTNIMUU4dSt5UUZ6OUw1?=
 =?utf-8?B?elU0Sk0vTHBiWm5ZNXNTbU9XVVM5ckZBK25PSThNaHVJVGJkMWpLMmJLNmZE?=
 =?utf-8?Q?VC0A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c3b2c1-ad09-4bdc-7500-08daf280e23c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:34:19.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+eVbL07EFa5UEA7PA27yDgHZPLKfiZxYE79w+dElNvtHD1/LoeuyQmXCd184oMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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


On 2023-01-09 15:23, Felix Kuehling wrote:
> Am 2023-01-09 um 15:18 schrieb Philip Yang:
>>
>> On 2023-01-09 14:27, Eric Huang wrote:
>>> There will be data corruption on vram allocated by svm
>>> if initialization is not being done. Adding sync is to
>>> resolve this issue.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index b8c9753a4818..344e20306635 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -574,6 +574,13 @@ svm_range_vram_node_new(struct amdgpu_device 
>>> *adev, struct svm_range *prange,
>>>           goto reserve_bo_failed;
>>>       }
>>
>> Thanks for catching this bug, we could optimize as clear VRAM is only 
>> needed for partial migration, ex pass the clear flag clear = (cpages 
>> != npages) from svm_migrate_vma_to_vram -> svm_migrate_copy_to_vram 
>> -> svm_range_vram_node_new.
>
> I only see one call to svm_range_vram_node_new, and it passes "true" 
> unconditionally. What am I missing?
I just realize that if all range pages are migrated to VRAM, we don't 
need clear VRAM before migration.
>
> That said, if VRAM is not cleared, there will be no fence to wait for, 
> so the amdgpu_bo_sync_wait call is basically a no-op with a little bit 
> of overhead for creating and destroying an empty sync object.

We pass true unconditionally right now, change it to conditional for 
partial migration only, then sync will be a no-op if all pages of range 
are migrated.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>>
>> Philip
>>
>>> +    r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
>>> +    if (r) {
>>> +        pr_debug("failed %d to sync bo\n", r);
>>> +        amdgpu_bo_unreserve(bo);
>>> +        goto reserve_bo_failed;
>>> +    }
>>> +
>>>       r = dma_resv_reserve_fences(amdkcl_ttm_resvp(&bo->tbo), 1);
>>>       if (r) {
>>>           pr_debug("failed %d to reserve bo\n", r);
