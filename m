Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AD0E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D78310E2D3;
	Tue,  3 Oct 2023 16:22:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C256310E2D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5T1ZYeoHlLIOf10Bsa/Kkr9cPR1C8YBnkSso93HRipkuhiAPC0mCesfa1g2Me85OxotFGNDRTumQi6rCw44GHLT5YedKoPC5qVmeLFGTVMGmADCLaBTUP8LV4oFyqRTSQKWJ+Qy4mGWCGjbu54UhbIcq2s/5HwMerqDXBgpgIC6gCHc6NTJOW8hiK94kcJs89is8bCrgY+TElA8+gw/Gbkt1j8VV31WF8JHhwQW5TB7B+3GYbfqByI048dgAzWLGtl4zRvjHQzk5wmDwZUufJ6LXZgX9bZ8BdR7NR5ktl6ctUTbrpOrVQZ2/In2H9XjIsrWN+LlcFuuELL51oNBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT/LO7JSjvib3IlX6Tznfl1ksgggO81P/hjvb6vYo+I=;
 b=JHy2bN/6wxsB6Y8RZeaDRNEdspKUJuje0oM2DHPp5JFS0taAYGmUYLeY37TXs/68+tPu0QLvIL2YFeHsHFhAe13DqcWNWXST01wZDcfqx8k9LF9lptTGSpWgYIvreOgrGatW8Yw1ft6RbgV71dh7+pyWJW1SUeM/bQdQ9pcGBaxrcRN2CNoRmFr3O4cKgAZaDe90eIuz1X0AmH6GahW+HQHXiEdQn8No3Pr+mS2zBgOfnS1jz2Wtl0Tz5LQriaQVseVnlvWwqWf+bZFgoTEUSDb5PRxsZlNitolfLUbDzqkxSQrT8mArrFiUL4Cc1S3RAElLs4TWisBNDaRBY4r9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT/LO7JSjvib3IlX6Tznfl1ksgggO81P/hjvb6vYo+I=;
 b=npbSN6tbaZ2myQTX9Udkt93BK4NYQxWZvIW+aCDMCeuwPnlbH1HqjGPZHSULWqgE3rMN8fLZV0amIhoy+Lbu0Cqq4PNOR5gSO8VKD3gMhqf8CrrrX/XXIghi002FLmXGpH3mNijoT5jiRcYnC1YUvLouMRSHqJNAPumc49tESHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:22:49 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b%7]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 16:22:49 +0000
Message-ID: <d96ed183-6806-c2a8-7972-fab3944aa02a@amd.com>
Date: Tue, 3 Oct 2023 21:52:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: d7110ed4-e9d6-4b41-ffe0-08dbc42cfc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJIFRoeGg9o0jvoE8DClTZSAz2Ow4phj+MqDzgMYDJQzDdWsufaglW4vrQ1D3b1Cmvmd6EZsRHi3F61f7IjPBMpWqrup+chWM01Ja0Vs7isi+DzroTp6oRx90eDvH2NpfzIuZjMAtbwSVDT/0+mclczhx1tkZTqzS18AcENqU+VutZ9yd2g7TLHdY7qihAUw7aFRUFsYuXD4b/YE1MpaZBNvaer1uTSmZcnBRhEKkStKIJ+N236bL6Pkp+f/1DPFj44p8ZZB1FQ0GiDrYLW+y+9/BgambtW++DJQX9Ztni1HrqLlXKciReIh+5U6s/jGPOGYU6UHAuqfDuKbG6UzIiaw429Zxnj+4ORKkArvZKn/LlEa+CDd1efPuZTU60oed+QxMiqChaEhj3k0xMZZTG6g3toUyP9ZNzJth/5Q3PErN0k4s1XS1ZeeReTbxl7z4/PFQtvt5+G8PL6L59116E+5tibFvV5uyuahX3kDfJ+Kh0KlA1q9X21pEGGlnywo/V4W+BAv7yrGyFxaXzwk6DKs6occVXe8X9Z0fMl+UXYjMZ4KfffH17z6oCU4evngb3Nz3sF8tWc5z0BrXBWs8o7ErptBeGtrzvlVvQ/mu8/i1yjy1JTps0Zzbi6r0Pggs8aKkfQR3LE+faBOiKZ7RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(66556008)(54906003)(66946007)(6512007)(2616005)(316002)(41300700001)(6916009)(5660300002)(6506007)(53546011)(31696002)(2906002)(6666004)(6486002)(478600001)(83380400001)(4326008)(31686004)(8936002)(8676002)(38100700002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29qM1BJMW1hUGxsTnpYMDZ3Uk1GSkF1L3FXZVd0bnZ0eUpnV0pKOXRRUHRD?=
 =?utf-8?B?dk5VOVhSMklyUHducE1QRkNnQktYTTFoWDdDM1RJYS9MRUphN3l4S01mMUNo?=
 =?utf-8?B?VVN5NXp0Z0lieUJ2U29FOEhaWlVGa0N1SnBNbkN1K1BxZWN6OHlZWmhIYjhU?=
 =?utf-8?B?TTdjSHNBTDZoTHlGR2ZUSzVaRVNFK01MZ2RDblV5YzdxTy8rZGwvRTVwRkMv?=
 =?utf-8?B?dG16cmJRYmI5OGN1WVB3Z0xYRSswYjV1a0tFWlgxQ3hPRkR3MVQ1amRNMGFZ?=
 =?utf-8?B?WGRneU1FZWZFbUduS3BYelZiU1VTUlN4TlJ1SDFudTg4TkxNL1hYV25nUHNz?=
 =?utf-8?B?WHBzbzdKVDJYNlRSbVBqN3JUSUlaK1A3TVo5TjhxQWhhckhWdCtMOEYzWHlC?=
 =?utf-8?B?SzZHK3RLZThFZjR3VERrZytqcVJZcXc1cTQramtLUkp4akVKRW8rSVd3dXE5?=
 =?utf-8?B?TjZ4SGJOeVVFUEVhZEg1U25LYTROMC8rei80M1VUaCtnWUlrU0U2eUM4dUFO?=
 =?utf-8?B?ZmViWWhzcmdYVDdYazY2WUUwWlIzaE9ZVTB0czI5bmZmNlZjRkFqZlFKQW5W?=
 =?utf-8?B?aHJ3d0w2Z24yOHFpR3pReTRrVFo4bDd0UFI4cW9YcUhxVXNCUllpMnlzaFlN?=
 =?utf-8?B?bE8zMmI4M3I3RUMvd3dFeGVvamFqRS9GdUxOclNtaHdoNklITHM1cm1sc21W?=
 =?utf-8?B?UUcxZkRKT1ZpV3VLZGI3OGduajErNWFEVDllRjBBQmR0UURUT3lTaERySElu?=
 =?utf-8?B?d2Y0Rm1FbnhpaEx4RGg5Q01uNnVJMGxkQlJXWW92bTRsSlo2eUR0WldEZXd4?=
 =?utf-8?B?cnBaTVQ3WnNzdExpODNxRXI4cnJBcmJ4TGpmTyt2L050eGFoSFU3TGgwbWc3?=
 =?utf-8?B?L05kNmhITVZpV1J0aDFyU0c3cWVqU1dnSHN1TmpkejNRemV6dnlSSmJaQmR1?=
 =?utf-8?B?bXpJT3VQTzl1MEFyNzlnZHFSeWZrVHpKV1dnZGhMd0FKVG9tSVo1OGw4bllI?=
 =?utf-8?B?R1IxN2s1djJUUlBQd2xDcXhrSTBmQmxua3k3RHFFTUxnb1VNUVZHVHZxOFc0?=
 =?utf-8?B?ekFXNmhCOVdGOFZYby9CN0NlZEd3WnJ0a3JJYklKRUVOa3JCQUVyTTdWKzlq?=
 =?utf-8?B?elg0SWVDbzc0ZWc0amYrTjErcGZVbVM4YmpNc24yU0MwY0JVOGhGUkQxTndT?=
 =?utf-8?B?UGd1c2NMQ0QweUMvQVJQWm4wenhOVWVFK0YvRnZ5Mkt5VWI1TnhObkx2SWlK?=
 =?utf-8?B?U2xNbCtpTTIyRTA1Rm8zd1ozNnlCOFF4NmZFYUh0ZXhPUnpRaXlRc2tKcEJn?=
 =?utf-8?B?SDRubEp0YmsrQTBwTnNpOUg4OXlqN1RNeksyQ3BBQXJMNnI0bFE4ZnR5bzJ0?=
 =?utf-8?B?R3pyeStsd2JXSU5CcDRLTGt5RWJhNEtncnN5ZGdYeitRM0VXeEN3UzFtWGtq?=
 =?utf-8?B?SjVaYUl6bTVJL211STRDbm1OMkNIQjd6VHdYc2Z2M1VSQ2pjT0p4RVhuMzQ0?=
 =?utf-8?B?Sy9NbjFqMUUrNDBzWU9VT2tncWEyS3pvRGhhM0RkZXozYnBlRjFXKy9rY20z?=
 =?utf-8?B?RWZrbFVBOXB5aUFqNnJXUE1QTDJsUGJ0QUpQMzdXeElCQTYxRTlJK0pGQjU2?=
 =?utf-8?B?RzVyVllhekpVV2UzbmxUK3BOYzRmWUxEbWxHSVQ5bUdVL1d0YXI0R1Ztbktv?=
 =?utf-8?B?RDNBUVVRUm4zNXlTN3p5eTRHUEVHSnczYUtwMzFKTUJRZEpzSzZkclROVTE5?=
 =?utf-8?B?dC9OVFNaYzVQblBJZGRGcEtaRHpTOFNxZ2hGNXlvUDFrbEo4SkR1U2NkMkpi?=
 =?utf-8?B?bk1xSzBzSEU0ZVgxaGNQbzNqOWd5cUxhZ1Y1T1pXY1RqVy9seG1rRHQwSkJQ?=
 =?utf-8?B?ZEhDdXl1ak5uNnkyVXQ0RzMycTl5K2pxZnFBZ0FIU3MxNmpFRWZHMTdDanMz?=
 =?utf-8?B?LzNtZHlUem8rNFY5aHZUTzIxZVJDM0hTT2VzV3BpNnFrckRtb2RxREtjbG5T?=
 =?utf-8?B?NjhDbGZxSGE5VEM2cGswU3lENWRGRXhuZFBJWjZUdWlTUmYrTDQ0dGREb3Fx?=
 =?utf-8?B?WktvdjlYZFBuSzlYUlpCVjlyUjFWY1RMNG1WbWU4d3FFbnFiN1VrNEJKUUI0?=
 =?utf-8?B?QXBMajUreDlMVll4QndzZWdUbUh4bVRtZk14RGdwdGVSSkJJWGtpV3dGU2Jw?=
 =?utf-8?Q?Sc1OcQfJOJ+ZqSVkYTeYRuF8LY7fFHqk4Q69llQ4Serv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7110ed4-e9d6-4b41-ffe0-08dbc42cfc2c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:22:49.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+58IsoXNo6aekwc5p+IhK70OBEmbogY6FToiQclO9J1dTPr7BfbAtBSrX8jSYwBJrAoU9LY97OwgXvUOwVUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Felix.Kuehling@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
 James.Zhu@amd.com, "Liu, Leo" <Leo.Liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>, Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi ,

Kind request to help review the change. Thank you.

Regards,

Sathish

On 9/21/2023 8:17 PM, Alex Deucher wrote:
> On Thu, Sep 21, 2023 at 9:07 AM Sathishkumar S
> <sathishkumar.sundararaju@amd.com> wrote:
>> fix wrong ip count INFO on spatial partitions. update the query
>> to return the instance count corresponding to the partition id.
>>
>> v2:
>>   initialize variables only when required to be (Christian)
>>   move variable declarations to the beginning of function (Christian)
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 081bd28e2443..d4ccbe7c78d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          struct drm_amdgpu_info *info = data;
>>          struct amdgpu_mode_info *minfo = &adev->mode_info;
>>          void __user *out = (void __user *)(uintptr_t)info->return_pointer;
>> +       struct amdgpu_fpriv *fpriv;
>> +       struct amdgpu_ip_block *ip_block;
>> +       enum amd_ip_block_type type;
>> +       struct amdgpu_xcp *xcp;
>> +       uint32_t count, inst_mask;
>>          uint32_t size = info->return_size;
>>          struct drm_crtc *crtc;
>>          uint32_t ui32 = 0;
>>          uint64_t ui64 = 0;
>> -       int i, found;
>> +       int i, found, ret;
>>          int ui32_size = sizeof(ui32);
>>
>>          if (!info->return_size || !info->return_pointer)
>> @@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                  return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>>          case AMDGPU_INFO_HW_IP_INFO: {
>>                  struct drm_amdgpu_info_hw_ip ip = {};
>> -               int ret;
>>
>>                  ret = amdgpu_hw_ip_info(adev, info, &ip);
>>                  if (ret)
>> @@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                  return ret ? -EFAULT : 0;
>>          }
>>          case AMDGPU_INFO_HW_IP_COUNT: {
>> -               enum amd_ip_block_type type;
>> -               struct amdgpu_ip_block *ip_block = NULL;
>> -               uint32_t count = 0;
>> -
>> +               fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
>>                  type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>>                  ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>> +
>>                  if (!ip_block || !ip_block->status.valid)
>>                          return -EINVAL;
>>
>> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
>> +                       fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
>> +                       xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
>> +                       switch (type) {
>> +                       case AMD_IP_BLOCK_TYPE_GFX:
>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
>> +                               count = hweight32(inst_mask);
>> +                               break;
>> +                       case AMD_IP_BLOCK_TYPE_SDMA:
>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
>> +                               count = hweight32(inst_mask);
>> +                               break;
>> +                       case AMD_IP_BLOCK_TYPE_JPEG:
>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>> +                               count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
>> +                               break;
>> +                       case AMD_IP_BLOCK_TYPE_VCN:
>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>> +                               count = hweight32(inst_mask);
>> +                               break;
>> +                       default:
>> +                               return -EINVAL;
>> +                       }
>> +                       if (ret)
>> +                               return ret;
>> +                       return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>> +               }
>> +
>>                  switch (type) {
>>                  case AMD_IP_BLOCK_TYPE_GFX:
>>                  case AMD_IP_BLOCK_TYPE_VCE:
>> @@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                  return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>          case AMDGPU_INFO_FW_VERSION: {
>>                  struct drm_amdgpu_info_firmware fw_info;
>> -               int ret;
>>
>>                  /* We only support one instance of each IP block right now. */
>>                  if (info->query_fw.ip_instance != 0)
>> @@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>                  struct drm_amdgpu_info_device *dev_info;
>>                  uint64_t vm_size;
>>                  uint32_t pcie_gen_mask;
>> -               int ret;
>>
>>                  dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
>>                  if (!dev_info)
>> --
>> 2.25.1
>>
