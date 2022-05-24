Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B61C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 11:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDAF210E2DF;
	Tue, 24 May 2022 11:57:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA3D010E9A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 11:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht4wdVd98HDm+TqZusou3kla2utSS4SEs7yyy0zjKgi6ul/shf4e0Uf7uyPUH/m79LQw2uj2moAasRoM46H1MumuqTCyMoLBhwXnJ7BsqSjYRVy+cZKWleWawZhbc+l2wy9Pr5PnGVmCGUt4ARppoAf6mbC0cMxgKi98cQlUpReDfkiVooUSo1IdB9irF3HA35eAkHxzTXqZd5Lxi3NwNN+YX2dsBUZtOX0UtAd4eCL3A3yPJRQ2N20C20+ST1O8K3l+K5vFyt8rwX9TrASr9baq1esuTICnm9pnKod98RhET0gIVPnF5DBwf3oSP4u5N9CQrQCzYyIREVdyBlMv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ6ljluwZ2BXhPjmiBpsQZOkIGaqFSHTUlTVKjYfdzI=;
 b=EF/u+B23IDgjlv+GyiNaGQlCOc+AYiNzXrpuSzHXUbWn7deTbBq0b/G4pn8eGC8GTCbZCDv74NjE/kB6JFT3bVu0TqTBpZHCavzuy8R22D1YhViU7CbXc9TT+lK+xO2nqAiOvWgAb1L12P1D3m86cybo8JGB9SXWIT1fHl/EuF9gMzeTOXGdrqGMJ625SbUrDUZLsgOPY94Y1yEfzK5Pj7hcvpNzyir+5JGIU8C4MODY7BwBpVwsL7Wlt+2Oj/Y29uCNlaZgkkqTcAltjiHAEG/j6uUOBLLSQy8Y2P0140HpGoa7yMF8hY1iL+MSbAs2EdOBokWHkh/140dNax++MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ6ljluwZ2BXhPjmiBpsQZOkIGaqFSHTUlTVKjYfdzI=;
 b=kQQohGbC8PprKcpsZmOBMtEJbHFeyQFw7igpaaLnUeS73XNRaCDmy5oXZ9P2Qo9poCQuMJQsqmYlG69OnjC+zAC2IrAFu7wc7b40dBuXD2XO5FsJTPwut+RDsgJ/5EvY4vZTfv/+B3F0uNrFkJNs16ue5njRcBZSEmorfisiAB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:57:36 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 11:57:35 +0000
Message-ID: <4274f56a-9044-7ba8-bce8-66033239b7e3@amd.com>
Date: Tue, 24 May 2022 17:27:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <1b19f85d-0ac7-3559-92a7-f7c7c6571512@amd.com>
 <9fdbe193-b65a-a429-09a1-107b00313891@amd.com>
 <8e23dc2f-f365-1f0e-8ce8-f9f5b1405a1a@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <8e23dc2f-f365-1f0e-8ce8-f9f5b1405a1a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1286611f-3bfb-40ff-03b9-08da3d7c9788
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5453:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54531E876AB8711A991B5EEDF8D79@SJ0PR12MB5453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dtq4rnFxhLLoW4G50pFdAAWb7gZ7sknbUn2i486GkdcKCWGriDg2Ddf5BAhpQqOecPBIjiX2RbSqzjWO5wmauMCEE81eR9oh4o8ToBvDydqq9DN5AiMcXJ5opKqqA3tqkwt6xlZwdtpi9Y4mCTZVaQA7K1X0qHdI/pF29qrC+FIRBMb8NZXi4EAfalKE2MRG9co1pAxOwT5KN+h7I7+R34gyIbGqFD7kLfzftsbUnRBLnWHuma7Vx9uceSe8x6+7cQggZWlrsmr7DynoO4DNTWFbADYTmhDlvhBN5wMIAF1VomOX5as9sDEdQtvE/DpKYcZG6GCShvPFhjGegZ+7BXvHGtg4PtzAcUHI0GowSXxL4/vGp/pWtftzV4XcaiFoPNR3VPji0Ca1wZNZTda/lNAPw43VuvN2fzKoFlFZIoDHgEpudMFa806xrj8FMxLaO5iYTp5vKxJYP/n5Pk47bvzi/L+0ovI8NWGCWH5K2CwV61RBWdyRTCArrrwDXcf5Ty1hlBTdzFrLZT1YH2qaUXzG6qHSm3qcPR25kAU19/dxGZ0zsM1V/Vs5DDZGFVro+9qfV1wvPdhgRZQ5F4PhhyHo9qRqq0epTvKEnSByw5DG3vcHrbjhqdHFSS2jXn3QVF5qJNdDpVWC74H21oD2Vlknbkn8vTWMtsjTvtuz6Kkh0g4IkAerrow+vfLVQu/uSpfs4jSXtn8pVJnvq0ZGL7+48k9fzHR4Cm4wUNVXv/U21rWj9GoO2jpUnpUNdf8R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8676002)(5660300002)(110136005)(316002)(83380400001)(4326008)(36756003)(66946007)(66556008)(2616005)(186003)(31696002)(66476007)(508600001)(26005)(6486002)(6512007)(6506007)(53546011)(6666004)(8936002)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFnYUFFOTV4VHlPUXNUVGpwUGtVY1JmRFl5cytOOUV6NWFIZ1NSYi9JaUI2?=
 =?utf-8?B?OVdBRXIwWnFVZk1vbGVRRWZGSmlkclBJTkh0blczaUVmRkRDN3RDV29neGRJ?=
 =?utf-8?B?ZzFTMmV2SHVzMmppeWNzT3h2Qkd6aHhWbDJBTEZqVW1kbUROaWlFeUxTZmUr?=
 =?utf-8?B?U1FJdURyeVpWNERsNFFFSUFKRmsyNDR6K1l5OEU0ZGdUbUJheXpZdzhXekJT?=
 =?utf-8?B?STRwbDAza1Y5VFNBSVhFZDFJRzg4S1hMbVZXRVpPelUvVFlrQytYS0JFMHpX?=
 =?utf-8?B?Yzl3YUVlTmQzYmt2ZExSSytyT1BieStEakdiUWh4NVRLS2VIdG5IQnpXeEZW?=
 =?utf-8?B?WEtlaXN4YWM1SURuUG8waTY1UnpwQmtFenZzd29yR1M2di9iakdwNmFST1Ji?=
 =?utf-8?B?VThpVUNrVU9KV1pZa1lpOUdmbGtoU2dyaW1OQlc0UWVHYVBtdmlxQ0lGRWRk?=
 =?utf-8?B?K3Jjd1UwN3RJYW5SbUc1cGQ3TE85blNNWWk4VmpPZGk2MmdtUGF3emM5RmRB?=
 =?utf-8?B?eFRuUjh5QWNZQTAzZUgyZm8vTm52MWJac3dvb1J5alBJdzVLRkpCYllKQVc0?=
 =?utf-8?B?NTdvOGF3TmpGREY2K251ekNDQmZub2l1VnU1S2dGYTlpNGRheUo4Wm40dnJN?=
 =?utf-8?B?UUpNSjVKMjRHZWRxc0ZGYkVyWmY1NHdQRUpCSmhoOHFTd1BYZG9QL04vR1R2?=
 =?utf-8?B?dUVUWmExQUt4RHhDQ3hETmJVa3pjSGxRS0FQUnFDZ1FqTnhzbk85b3ZJMW4x?=
 =?utf-8?B?Z1Y4SXBXeWhnK2RPUC9Dc1dTaTUzSUFwYWhWVXhuTDBIbS9oZktaNE9zSFJl?=
 =?utf-8?B?Qm5DTjI1WGxDeWRteDNEMTFFY2o4Z3Y2a2pENmh2RzV3MjBtRG9zOTB2NmtP?=
 =?utf-8?B?eG8xK0xDYlhZZXBhbUYvS2F5aW9OUnBWbXpyTEV6OCtHd2V2RXNhVHZkQWxx?=
 =?utf-8?B?d0VvQndhalhTbzBpcmR2cUZvbGVibDZoUU5GS0JtWExwdmZlcDRjb2s0bmY5?=
 =?utf-8?B?OFpGSGZQeG5IU0dGNUo1elRmekNtWnJsNDRsZk82TktNMis3bTB6aU1BRnVz?=
 =?utf-8?B?YUptbU9rMFRJQlkyZ0IrMkZuWTJZeStocHhXa0ViazFEWk83ZmNNaVY5K0ZO?=
 =?utf-8?B?RUpLT2VJNDR2Ry9YWXFYUGtEd08yOEUvVzJIcW8ydzF2UmkwTEs2LzM2aGty?=
 =?utf-8?B?SlQ5QUc1QkQwWG9jeHBnNTZnTlpqY24vejVreTk0NmtNVTh6alVaWVB0THI2?=
 =?utf-8?B?a3B2MzlkRTFsaTZoYUZPalh0YUpNVGZxSWJwZ2V3TkpGMUREOW1LQUpiZ0JK?=
 =?utf-8?B?c05BeHBkTFNQaFF1VXRtbzMxcE1xeTczTjVZNWx1THk1cXZBYm1vbDlpL0VD?=
 =?utf-8?B?dEw2d3U3WllQZVFSeWxWU2lwSkFjek1mYkZOUEI2c0F3SDZXU1RhcjBzdXFq?=
 =?utf-8?B?Z3hsYTlNaTJ4TWNCcEFVN28xTk9qeGdZczNPM28xRXNIN1o1cXRyYU9YUTJ6?=
 =?utf-8?B?S285Tjl1WTI4cGh6UXpIYndOWGF3Y0I5R3RTYk5jc2t5V29HSHNaSnYrUExm?=
 =?utf-8?B?WW42WjAwREtXZmhYRHJZdDBDTW4zSkhxVjVocUQxZVlmNU0wdldlRGU4cmlT?=
 =?utf-8?B?VnVYb1ovYUo1c3d6WUJmZkx1YUxoOWY0amZLWjJmN0o3Um12ZERYZnhrcTJi?=
 =?utf-8?B?RElsNEFMRk5jaTFPMGFRcHlWNlU0YTM2b2Q5a2c4REZGTjlHeHhpYmovUUcw?=
 =?utf-8?B?cklmV09mWGZweU5DTXh1Q2RKZE41cWY1cURnWWRmeUl5Y2d6QzdobUtHNmNU?=
 =?utf-8?B?ZDlxazBkSjIvZ3BoTFdSRUlQUDhTNmdoYlp2NVpvdWZVRklzRFplYS9jaGVE?=
 =?utf-8?B?alFhUTJXVlV3cEFnK1RBOTNJZ0UrSjRGUTgrRVlORS9zb1JiTWpEQUhBQ05r?=
 =?utf-8?B?MFZJQUxIZlFMZGpicnN0N0srenVHZWdnK0hIcGFjYjA4WTBHVXUxWENlUGhM?=
 =?utf-8?B?Uldicno4ZW9RcDNRUlVuVjF3Q2lnTVQyOVJYRldIeUJuU2FWemxTaEFHbVZM?=
 =?utf-8?B?VWhZVmtHQXNBT3RlUWg0VENxc01ZMWthNS8xdzZ2SFdwdktjbFF4RHU0TlVj?=
 =?utf-8?B?MHNTT2lUdTRmUFNXMmNjcnhKMVMwVTVJbDZoTFY4WloxM2VRYTlCV2hycFhK?=
 =?utf-8?B?aElrcThPc0tIZkVxaTFpdmV3RkJIKzJRVGxmOVBOSENYQy9Tc0dzTk5qUmU3?=
 =?utf-8?B?TG5RVm1ZU3RxZ0xtT01qTytseHYvQjlnL1F1cUlwZkhBUDBscFE5SVJFYmNZ?=
 =?utf-8?B?eVQxSVBFNTFmS3JXV2ltTFZWSGE5MjdQSVNhRmNuYW45dU5uM3U2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1286611f-3bfb-40ff-03b9-08da3d7c9788
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:57:35.8702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDiEs3y0uxmgnKzsKZLaARrg9GokldyEll5iNEm9GzwGeAGf+GwGooFGBEcpL9MTxk53W8hVZ1bXXHlssjiFTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/24/2022 3:25 PM, Sharma, Shashank wrote:
>
>
> On 5/24/2022 8:12 AM, Somalapuram, Amaranath wrote:
>>
>> On 5/20/2022 7:36 PM, Sharma, Shashank wrote:
>>> Hey Amar,
>>>
>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>> Allocate memory for register value and use the same values for 
>>>> devcoredump.
>>>> Remove dump_stack reset register dumps.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 7 +++----
>>>>   3 files changed, 12 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 76df583663c7..c79d9992b113 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>>>>         /* reset dump register */
>>>>       uint32_t                        *reset_dump_reg_list;
>>>> +    uint32_t            *reset_dump_reg_value;
>>>>       int                             num_regs;
>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index eedb12f6b8a3..942fdbd316f4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -1683,7 +1683,7 @@ static ssize_t 
>>>> amdgpu_reset_dump_register_list_write(struct file *f,
>>>>   {
>>>>       struct amdgpu_device *adev = (struct amdgpu_device 
>>>> *)file_inode(f)->i_private;
>>>>       char reg_offset[11];
>>>> -    uint32_t *new, *tmp = NULL;
>>>> +    uint32_t *new, *tmp = NULL, *tmp_value = NULL;
>>>>       int ret, i = 0, len = 0;
>>>>         do {
>>>> @@ -1709,17 +1709,24 @@ static ssize_t 
>>>> amdgpu_reset_dump_register_list_write(struct file *f,
>>>>           i++;
>>>>       } while (len < size);
>>>>   +    new = krealloc_array(tmp_value, i, sizeof(uint32_t), 
>>>> GFP_KERNEL);
>>>
>>> tmp_value is initialized to NULL, which means krealloc_array() will 
>>> behave like kmalloc_array(), is there any particular reason we are 
>>> adding this variable at all just to use krealloc_array(), and why 
>>> not use kmalloc_array() directly ?
>>
>> I thought of using kmalloc_array() (got little confused on next write 
>> cycle), I agree to use kmalloc_array().
>>
>> Regards,
>> S.Amarnath
>>>
>>>> +    if (!new) {
>>>> +        ret = -ENOMEM;
>>>> +        goto error_free;
>>>> +    }
>>>>       ret = down_write_killable(&adev->reset_domain->sem);
>>>>       if (ret)
>>>>           goto error_free;
>>>>         swap(adev->reset_dump_reg_list, tmp);
>>>> +    swap(adev->reset_dump_reg_value, new);
>>>>       adev->num_regs = i;
>>>>       up_write(&adev->reset_domain->sem);
>>>>       ret = size;
>>>>     error_free:
>>>>       kfree(tmp);
>>>> +    kfree(new);
>>>>       return ret;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 4daa0e893965..963c897a76e6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4720,15 +4720,14 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>     static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>   {
>>>> -    uint32_t reg_value;
>>>>       int i;
>>>> lockdep_assert_held(&adev->reset_domain->sem);
>>>> -    dump_stack();
>>> This should be a part of different patch, where you can give some 
>>> background on why are we removing this.
>
Will make different patch for this.
> You missed this comment.
> - Shashank
>
>>>>         for (i = 0; i < adev->num_regs; i++) {
>>>> -        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>>>> - trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], 
>>>> reg_value);
>>>> +        adev->reset_dump_reg_value[i] = 
>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>>>> +                adev->reset_dump_reg_value[i]);
>>>>       }
>>>>         return 0;
>>>
>>> - Shashank
