Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B56C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 10:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE7760EB8
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 10:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BE7760EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1A96FEC3;
	Tue,  2 Nov 2021 10:11:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA966FEC2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 10:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSagSTBLds3sWp1mBoPfJZYFh9a/SwIvd4KlqRAfsZxYbcukg1mUb2cZj2YylASOGwkuK3LM3YMl13whaKSytTi066v8AvjOu/jiWUjBwEFQ3R/t5+r+MUC/Qg3imEz8Bis5NgcnOSTdPhWMHkogm02Z99Sx9irCYYTva6826TTJQ+ScoY8KOaO57pXqmDXXEsjQEwi262pOVPnSuadgeTDA19KgnSyVo4rW5+F3tdts6+KcYZbp/+dldTDIVMwd+F1YLDaeKCM0Lm0W73bjcEP3xAtoS9IFJZbExAUzjvmcZeaLglB5Y9YUcUSqd3OJW7tbrlzTjL58dLK+G3M4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ3Zd4XC88fbe2mbI/DnIJSRxkOl1oelfSpjOxf6ylg=;
 b=CybjzYSJZXVTtdr6CM/h2r3tjSjEfp7SMVM7lwi6vo8DGRpD136+6fZdDN4cuxYpWXJP1LGqLMmfBgyK4aUU+moQ3KKnWNRn95GgBEQlFo9JmpsXWDy3zMaOgc+qvWEBucAWCI8U2jpkfa3ubv9gOEjGs9KBKs8xFUEQlhhxhmF3htFiA/XUEpURdrXgllMhdudA5hpcsU4bBbsUerRqff/ayOKiydDG8GuF0GP2T7imGEhPG8dMGRxUpvXOmKnG1zrtxTAOLrK/1r45LVv82VH+p3+sn7XTaQKxh6Exlq2wEQdo2OSRUsReAHUIlK2Pi4NVqOf2UL1grdLUDZsEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ3Zd4XC88fbe2mbI/DnIJSRxkOl1oelfSpjOxf6ylg=;
 b=FL8snJq+bgFNSIfvK+86jhYHfLrZuPsNFyNbSPyLWh6X+yhTWwHicbTMnyZfhMlb448CMmYQa76RpZwZre7IgGPG37Wzf2PEJnnlonMbctMHJJO81WSAUPGlHlkZ412UJ6eV8OIDzTVfyQZPuIuhLvDzJzfqzhPRcIk+848ucXI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 10:11:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::e95d:8a23:c590:e07a%7]) with mapi id 15.20.4649.017; Tue, 2 Nov 2021
 10:11:50 +0000
Message-ID: <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
Date: Tue, 2 Nov 2021 11:11:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
 <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::20) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.123.158) by
 AM6PR10CA0079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 10:11:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed74133-76c1-4417-5d63-08d99de92fa9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5359:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53590824D251E1973DEF6CE38B8B9@DM4PR12MB5359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: la9zNUBUPNv0f+6b+DXSZ+lcfprxaaLzm8tKPAKFQ8GZQPQXSw+ZpSnz/NF78TNjWy/cr3efzce/bQbYAoe2nH9H78I5x9GKWyjUX++i1zUQOEN5PMKvWr0THAiG8OysAiXoElP0mWx6EHYvK9JANmdJxf8IbGEKb2k57ZPXKorJKnZouZmrYtMuBPF44vuZy3Jv4ZOJJrAMZaZ6FcPpsSQ2B/78fhObxiZcJuu8eVapqv8YaHe7ExAAAU7jS0p/PrIHFwJLbLFNQT0llR4Xvpnk1B2ACVFSzDEbuVSX0w0ut4SpnZxNng/ByykmX29H4bk2A/Az6YM2w7Rd6gcn5CDBVhtXtnMjuMkaXsk12jwK95GKh3daxDRzhnzchC22ktelScUiJNpQkUzzrhLCjPUqjudUejq7MNPoRZDSNPpIqHE5jD6R+hYbp7wPyXt0JFtGLfSWD9A8OPstnL7KxDA0vFLw18If1JS9bk4/0KQbJyMoz3WELfxDnCs5AJtulY3KO2w0rSQx3Ri6aqDhS5ZyC/6saCSU/GgVDWoxYbo3fwUM2d9UISMjPekdmXCB8FF+K70ClvGmDOoRLM4vne22B5UmnRaHA+PnpJlmanYEoQwSwGtLZcm5rNQFOvm9nv1MWUe5BRlToNxZR2zrSidmkHZsc4rPFuzMqE8fGJyNB7Q/R/N6Th6avbplx0Uz/mNbwzabn/A0XDukzEBoQ6KQOsaPLOPxl7BhUgaQ57M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(8936002)(508600001)(36756003)(6486002)(5660300002)(4326008)(86362001)(31686004)(26005)(316002)(31696002)(16576012)(2906002)(186003)(53546011)(2616005)(66476007)(66946007)(83380400001)(8676002)(956004)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm16bnV0U05MS2RMRGtsdUhwV2ZLVm9QVjdya3pZYUZUOVFQRE4wTUtMMGhM?=
 =?utf-8?B?QU5GaC9WR1YxcTZ2S1RwQ1U1MUhqdXdSZmxydXdtK1JLTkN4THFKc2M5dENx?=
 =?utf-8?B?RGErV1pTcmk1VnFuVEorSlhFakVweSttcVkzeU04eUNLdGJTalcxb3JEWTNv?=
 =?utf-8?B?MStySVdwMlVKeUY4NHAzajRlZTYxTWhOM3FwbFRzcXFJUGJRSmUvS29ENi95?=
 =?utf-8?B?ZHJ2Ky9NN0daVnF5eGQ2aXRqY3ZSZHhzWHArRE5yODdKdjQxRWp6UkliWlZ5?=
 =?utf-8?B?Y0czMk4rblRxNXhseXgwMk5WWm5XSjhLenozNmxuK1EyaGNuRGY4THJEMk4v?=
 =?utf-8?B?aU5VenE3THVvN0Eza1FhTlQ3d0JGeklFL3dPYlhya1RZYUUwMWlDRHRCcWFm?=
 =?utf-8?B?RlVjOFRMZ1JUY1JwNzNtMHFlTy9xTEE1TG9kc3lkekpNWVIxYzcvQlJ0ZWN2?=
 =?utf-8?B?YlpUcUZNTVNteVgxVE5JU3prYllXZmN1MzN6cTVEYTh0TnFhTGdIN2hER0ZM?=
 =?utf-8?B?ckVDTWFTd21XMWRzeDFlSzZHWDFNOENIMWJlRWU5Nkk2aS85bnBlVUlKcTJX?=
 =?utf-8?B?QnVicmNEYlI0Umo3VEpGT2xmVFUyVDZYNEJlckMrMFN6QjNITXpRUk1adzVI?=
 =?utf-8?B?SkszQVFLWWNPWURzYXZZRXd3TENJMDhpRDh1QUV1WU1JdEhqTnY5dWRuN1JV?=
 =?utf-8?B?UmxocGZET1l1Y3RBYzZGSHhNMTZtdTUzQUMwOXpZTUt4OTRleUFrTTF1bTVN?=
 =?utf-8?B?QTRhYm9CTWxLZHBtS0toeWxQVW8zWTlNQitLY0tadVBoT2R1UWtGQjRmN3pa?=
 =?utf-8?B?Nkh1UXNYbXFZaFlPWVlXS3dpOVZlUDhKUFRQSVA5d2o1S0FwankxelFVdHdj?=
 =?utf-8?B?RXJuMFdwYk5hY29abS9ER0tzcjBaamJGZW4vdHBia2sxSWlaajdhSm1TUUhq?=
 =?utf-8?B?dXd0bURBWkhjVzVXNUlSTXkwN0hIN2hqVlRRWUFSTkxuRDBHWm1GV0VHN1Qr?=
 =?utf-8?B?dXFXdDJrZyttRkU4cysvL3VkYnlhVFBHOFUxU0ZxQm1jdmgwU05mVSt6NGcr?=
 =?utf-8?B?dzRYakI2cFlPMXc0SzVTYVhVRFpxNUNDN0RzdnhpWlJIcGI2VWgrL1FvM1o4?=
 =?utf-8?B?OXlZSlpxUVdhZEhiekt0UWZRcEdZQlJyYjdoMUxhY0JOaXBTc3o1RVVwYkVF?=
 =?utf-8?B?UUJjRkQ5a1UvcHlHWktxL3dGZS9PclJESWE3WWZSR0JldmllY0xUSGpyMy85?=
 =?utf-8?B?NjYvUjVKTE91TllBL09QWS9IaGtVMTUzbGRVeUNMV1UwZ2p0dnpDbGpxVk5O?=
 =?utf-8?B?ZC9jbkZQc2sxbG9kWWlpWTNOWjljcEEzNmVmRjFvV2hnNms0NTVwTE1OSXJW?=
 =?utf-8?B?Z3Q1VThIOFZNVEx4NkdlaEtDUHFHNlFraDRpS1J5SituendMemwzRnRnNTY2?=
 =?utf-8?B?c0RkTFpyNGhzbXN4eDd1TGgwVXY1L2lSZkJJalZUQmNodTdpU2lGR2RGN0dJ?=
 =?utf-8?B?Q3lPd1JXM21KZE5Tb1RlQ0w0RGtLYUpwVkpzdVJBenVxOTZsRXhFNjUrVWRn?=
 =?utf-8?B?R084aExGZ0NrcXkwcGdVMmt4cyt0M090NVk3RElHbDFkcitpaEN5OTI5bC9G?=
 =?utf-8?B?Y0NISDBSZS9QejJVU1NBbGhVWXE3WURRc2RvSGtrRHNkaGYycWx5Z3p2djFR?=
 =?utf-8?B?TmJzTUdlTlJQb1RYV3U1d0cxZUNvaUMrdlpvSWpPSHd3Z0g1UGdHSDRzdnZx?=
 =?utf-8?B?RjBiQ2VJdDVvNHU2Nml4WEVHRXYwcGpqUEQ2RjBHUnNUTmUveE5ReGQ2MWZV?=
 =?utf-8?B?SjRQRjFOekV5NFRlTkdoMFdtbzJVK1lwYVVNeFJpd2dacHhhRDZLN29zUHlk?=
 =?utf-8?B?cXRKK0Z3VStJdVVqdVFmTzkyQ0cwVWk3N1U5dkVTTkFSanlHUUI3d0lxVFRx?=
 =?utf-8?B?ZVZkNFQ5RWVGeXlLZ3lBSVF6dGpJVmtORFRSd0RtQk5Ec2VqWVg3b1lhUERt?=
 =?utf-8?B?aWhBVmhoSHl2cllhSjlvbGVzZHZSM0VlOW0va2Zob1AzQVZtRWNjTmJ5QzJU?=
 =?utf-8?B?bjhMMFBGeUVrUDBJaW5iek5pcmxPeldjNDh4NXlyQk5SY0VRdDZENnAxU3Jr?=
 =?utf-8?B?VDYwSDE2OCtlTVNhRmVNM2xPOE5JalpiZmd4V0padWVuNU4wcFZMM0tlQ0p2?=
 =?utf-8?Q?WFODPDr5NsL4ho9r9PC6tSU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed74133-76c1-4417-5d63-08d99de92fa9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 10:11:50.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sE94zxnJqI5W0addaZ7bdC50xUylkFVHDQElqJlNBc9XWxXLcrHC7rQTHitmunin7O99wa63b109Cb7rj9nZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/2/2021 9:00 AM, Lazar, Lijo wrote:
>
>
> On 10/29/2021 8:39 PM, Nirmoy Das wrote:
>> We set WC memtype for aper_base but don't check return value
>> of arch_io_reserve_memtype_wc(). Be more defensive and return
>> early on error.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 073ba2af0b9c..6b25982a9077 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>>       /* On A+A platform, VRAM can be mapped as WB */
>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>>           /* reserve PAT memory space to WC for VRAM */
>> -        arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>> +        int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>                   adev->gmc.aper_size);
>
> BTW, isn't it more appropriate to use visible vram size? There are 
> cases where pci resize rounds aperture to the next higher size > size 
> of actual VRAM.


Good point, I will update this one and send again.


Regards,

Nirmoy


>
> Thanks,
> Lijo
>>   +        if (r) {
>> +            DRM_ERROR("Unable to set WC memtype for the aperture 
>> base\n");
>> +            return r;
>> +        }
>> +
>>           /* Add an MTRR for the VRAM */
>>           adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>>                   adev->gmc.aper_size);
>>
