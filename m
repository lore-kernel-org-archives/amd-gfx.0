Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C459CD37B0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 16:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2EB10E013;
	Mon, 18 Sep 2023 16:18:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A16010E013
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 16:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxQFjidz/izWl8s4T12uKSUsYxJlqOtqf8+yOdXdIKlBpQ9nGfO40AlVAVX8wz/1h0vDP+g1bF6WKOeSCxCN+7edvLug/lU2Wi6S8pYqp5T9rDdsA5vBw+FdDUmpyPpydFOGi6nZG6Q4THn8J5kb7dHfDKIpQUWNYURDirY+GaF2gvFgbb02Bq1ZZgMVDYjufQr4T+6F9Dk7i2jtMgh8y8xD0XhUakudHDtnC+K7YTI43/Ukmj3DhAxoZxWtp6lHUbm9y0eGh5IV/5n7GHjLO5KMUOpKpy5wuXYf+Xyr2LBYFGNVnHB0VmdbLiiUJUEklFzVABT/GrWCi3ShWSBycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vBBG11i+zzgACwxb8rQfOxADRrDTLW00KxlbmjITWM=;
 b=MEWIc23hgPlqvRBwMS6skBghpnW4Ig54mUmFEznI+zqBu6FVY3lhFRi2WUPDhAvxNHL01od5DPRwplrRsDIAcxCi65bzrY5Y+R7jt9tldgvZU2KkeoTFpOcnBPBLXRs0zhJX6uu20guHFY/uIcCrFih3vXZs7kxLr+cV9Un+ys5/kiiVnA8GaEj74FLZqOXCjOW1oIA0EJGoA4Pe+um0GKR+SanXOcNRU73wIhUI4q5ioyWkQTUrJ3+TYQSmF0TzKRFHKB6U3bTmTDJp/cXKFPfmYIIM34fkaR327PB7DHtZ7VtR6htM4Deq1OcVEWXRBKmYR8KJ1kfeOdHMCQIpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vBBG11i+zzgACwxb8rQfOxADRrDTLW00KxlbmjITWM=;
 b=XTyaqolm9OKeeNv2nYCH7MHjUHEM5fqFbKQ9yeC/yBCP8Zj/HGC77eJjQz3lD767wjA799vNit2lYeQfP/FUVp9vhh6FxpwOE5A8S3wEdPwMIp9bx1SMPe8Znrb+/1ADMhWRjFU/Crzw12RYKyiwo1fzAJPjkj8zwLWOzjpxY7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:18:25 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:18:25 +0000
Message-ID: <543d8e9d-cf26-4f7a-15a3-e6dc41415dad@amd.com>
Date: Mon, 18 Sep 2023 21:48:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: update IP count INFO query
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
References: <20230915192421.3602660-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_O6VkW+EGmXrAiMFeFb9yasPB_6cetRZ93JacFNfw2FYQ@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_O6VkW+EGmXrAiMFeFb9yasPB_6cetRZ93JacFNfw2FYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 1190cc07-c9d4-4c44-9be4-08dbb862e2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w5HtG/J1puUhkjRVc/uF64CEg2wqRVO6Rh0iRm7C2SennbI8cdodsqsqIs+upjs1spnPubX/UsgMsRAFemKGjpMW3ddchVMbr5jy3ruMJoXmvtJ0PR+VHmYdjzHba64//Ulw5tYmxoGyXN9NdaQ+C1SsxxQS+w55n7BTpMTF3G5K+YJQosssc6V1xK8WuDJRgpDGQrZl6pLIaLyDFZpjFPgmm6SnUSKQjs9C3KZfDZMjSyiLLmXq3U4lJ/OSpdvUDJXOT7AXeryRSZz4yPtMmb/gH4jDyJuKYDzFVbCyseaG9OJj8O8iihcFsfb3g6bGjFHFqZuH5tzWD+lETa1IMzeUKrtZ8413ymDMk+wTyIG6iXSntDcvk5CV6CWERmy48lGURRzSrwVLFfw9NJ3Ai3R7n3qpzguGYmK7ndx3AkeBTvHoHV8HpSxLb2/vxoOwRbCIRCCTFta9fc6AjmyyNj/uxxqjwZDkBWG3z2Y4QmfX7BYogMqK9zWWgDyrhfSfPdi3jYMzXCX97yxMHg4BMv4zpSJi1eB9vhdw+CX/JkptZvvqUOmdbQ8Mo/Nch7CzS2TflBNfL6QNzDWZhL0BB1SRsON3bXRUjdWW5ul9nDVx9V98P7bXoPI2VLj6CqagKr6vf47QkY/vUGTfLa60g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199024)(1800799009)(186009)(66946007)(53546011)(6486002)(6506007)(110136005)(66556008)(66476007)(54906003)(6512007)(316002)(6636002)(41300700001)(31686004)(478600001)(6666004)(4326008)(8936002)(8676002)(2616005)(26005)(5660300002)(36756003)(38100700002)(83380400001)(15650500001)(2906002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZEQklUWE5lQm9XYnJnc3pFM25xUlN0Ri8rTi9zdXRabExoTnUvTm96Y1hv?=
 =?utf-8?B?VENPL1hHcVgzZ2FCNjlTVDdZMVgzQXVEL0p0R0NNZy92L2FMd1YrVElQT2NM?=
 =?utf-8?B?K0dhelQ5UDByaXRTV25XNGVkZXUxeHdhNjFnODdwcjJTWEhkMElGTVFtTTJi?=
 =?utf-8?B?a1NCbHFlSUJKb3NXMm9yR0tOTkR5ODJQWjgyR0xqdmFmSDl4NjVQTXRLR29I?=
 =?utf-8?B?aTZHSEpEdTV5ZkRWZ3ZySDAvWEkyK0ZoT25zeVJmSEoxaDZadnpncjdUelYr?=
 =?utf-8?B?T1E4S3JOaXFWVmM3UmdhT1NrN1N5cnRjMm80VzZLS0VybXYwVmtVaXdBWUlj?=
 =?utf-8?B?OGFIYWhhUHhTK1BtdzgwT3R3bldHZmZPU0pJbnF1SlRMMTIxaG5aRUFJNFY2?=
 =?utf-8?B?UkdGV3k1UTVkdG9oYjllbHFpWEFqazhrZWNiVElMUmpIWnhnaTVCaEphVjkw?=
 =?utf-8?B?a3o5Vk56THVSQjZXYVRjNTJTc1lwWERvZmwvdlNUQWhFZTJKWlQyUFFlenBa?=
 =?utf-8?B?T2VzOGZFb1lFRWlXcXJFT2dia1RsQnI4WFE1MS90L2xta2xQejNhSXlkcFI0?=
 =?utf-8?B?R3g3SlFoNnU3SmZIYTFHS0FGbm92ZXhqTWx1TWEzYi9yVGVwWUtDYng0WkJR?=
 =?utf-8?B?eDJBQ1gycjdRdUtOM1N6UVRmeC9Dc243RCt0YWxnQ1lOeFg2eEtYSE9qaDF1?=
 =?utf-8?B?aHkrNVY0Qm5kd3JxVVc3cmE1bmN6dUlNUDhYdERMU0JNblA5R3NuL2M1emRx?=
 =?utf-8?B?SkVLQm1mTjBoMTR2TVVZcWFCeFUxcGN0dE1YTlZwdldySTdCWVQyTjljZFJh?=
 =?utf-8?B?YXI5SFFHNEwzTTNoV3YzUFZZL2NlbFUwWVF6SnRyUnVINkVOckhneGQyRlZu?=
 =?utf-8?B?eVdWWXh5Qy9SNE9jcU8xZXhTcHVTeCtNMy9ZOWI0enpPaXArSWFDVHJreFRZ?=
 =?utf-8?B?T3kzLy8vdFZvZjNTS01JcHllVUc2TUVnb2dkYXBSaFZDOVJtb2ZiU2E0TkVl?=
 =?utf-8?B?ZTdpOWhHUjcvaE9RSnJpUzZKZHM1ZW0zZUdiZVJUM3QwYUhJQkNLNU5MbFZY?=
 =?utf-8?B?UmlWZ1ZBajhzRGxOUXBLallUeHVIaEFxa3N6cXovMTYxdmpIWDRNVGw3b3hX?=
 =?utf-8?B?Y1RDeERCYkpnajJLMXk0R0kxaHUvbTdLT1E0NjEraWlKOTd6VXZMTzhKL3FX?=
 =?utf-8?B?eEIyVjRMUzIxZzV1YjRKTUQvdHZwMy9lMDZTSXJyVytKZE5wM1RhSm1EWlU5?=
 =?utf-8?B?eXhuRm1UZWRrcVFkZmdUckhFcVNwcmFNMTI0TzFyWHdjdzlrM2NkOE55S3Fa?=
 =?utf-8?B?KzZHVXZMTURLVzZmRnJVWXVENEsxUGp3NEFKSFRHcFpHN2Vnc1VZang1SDdF?=
 =?utf-8?B?TU9OTVZTbllsdDM4RTUvdVVldjZDamNUbDZzUUZ5cTZoS3NXSlBuMGpPT0JF?=
 =?utf-8?B?Y1E0K0R6c3RPMDNnUVpGVUN6cHErZDd6UzdDOEJ2UlZKcm8xeXJiS3ZNNlhE?=
 =?utf-8?B?cVVlekJVYXFPRmRDZ2VxcFYwTWswVGtZQ3dETzRrRjdiSDBEcHR4eEJhYVUx?=
 =?utf-8?B?eGhjS2Z0YVAzc3hKMkQ5SS9aM1d0M2VxOEt4UXZxRkNJRzhjZHVtQUY0QjJ6?=
 =?utf-8?B?ZmdmSjMrUWpYdHZwU2xRUWZLOHlKOW5VS1BwTE1Bdkd3eGN0Ylg2cGtQbWRZ?=
 =?utf-8?B?K3VwdWlvOFRUb05LYjJieHJzSTY0TCtFcFVpUm1PM0IxSG9Xak1BL3hQQ2w4?=
 =?utf-8?B?dUl5dTNVVk5WTVpxTlZ3eWl1dmx1ZFJVQmJsSDM0Q1VZM0tSdFR0RndKbzgy?=
 =?utf-8?B?cFhoQVRPZ0Zaek5iVklxWUd3TjhERXRDbXQrMWlkSDg4ZmlIeUwwbXlaZkhn?=
 =?utf-8?B?WXM3NjJKaFQ0VVQyaXFCaEhwdUd2SGkvVUF5WGd0Zk9kWmlZelA0blFyV29y?=
 =?utf-8?B?Y2xrYndRV0lzNE1xWlBBczFCVG5nZktjMnRUcnI2QmhqZEtJRFFoZGpFSG5D?=
 =?utf-8?B?ODRJbmJMbWVPMHk3UmRBSDF4V1d0QjZBbFZGdzVsdTlXWXgyWEtaRTByeXdV?=
 =?utf-8?B?WmRlNnhlOTU4TlArOW9nTWI3SjRtWXg0UUlrV3lHbGw4QUY4bXlXSllLODVO?=
 =?utf-8?Q?TyeRDIcWxBRV8NQhpsa1c8zQp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1190cc07-c9d4-4c44-9be4-08dbb862e2a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:18:25.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35bhM3HZMqzRixArO6HfenYXoIjV5Aj+8sihD6lwr0pDZGoR2JCBRjnW2Bcm9BRYfRl/8d4aSEUhXxm3qCiJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/18/2023 7:57 PM, Alex Deucher wrote:
> On Sat, Sep 16, 2023 at 11:01 PM Sathishkumar S
> <sathishkumar.sundararaju@amd.com> wrote:
>> update the query to return the number of functional
>> instances where there is more than an instance of the requested
>> type and for others continue to return one.
>>
>> v2: count must reflect the actual number of engines (Alex)
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 92 +++++++++++++++++--------
>>   1 file changed, 63 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 24d866ed5922..56273a7c9028 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -200,6 +200,44 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>          return r;
>>   }
>>
>> +static enum amd_ip_block_type amdgpu_ip_get_block_type(
>> +               struct amdgpu_device *adev, uint32_t ip)
>> +{
>> +       enum amd_ip_block_type type;
>> +
>> +       switch (ip) {
>> +       case AMDGPU_HW_IP_GFX:
>> +               type = AMD_IP_BLOCK_TYPE_GFX;
>> +               break;
>> +       case AMDGPU_HW_IP_COMPUTE:
>> +               type = AMD_IP_BLOCK_TYPE_GFX;
>> +               break;
>> +       case AMDGPU_HW_IP_DMA:
>> +               type = AMD_IP_BLOCK_TYPE_SDMA;
>> +               break;
>> +       case AMDGPU_HW_IP_UVD:
>> +       case AMDGPU_HW_IP_UVD_ENC:
>> +               type = AMD_IP_BLOCK_TYPE_UVD;
>> +               break;
>> +       case AMDGPU_HW_IP_VCE:
>> +               type = AMD_IP_BLOCK_TYPE_VCE;
>> +               break;
>> +       case AMDGPU_HW_IP_VCN_DEC:
>> +       case AMDGPU_HW_IP_VCN_ENC:
>> +               type = AMD_IP_BLOCK_TYPE_VCN;
>> +               break;
>> +       case AMDGPU_HW_IP_VCN_JPEG:
>> +               type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
>> +                                  AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
>> +               break;
>> +       default:
>> +               type = AMD_IP_BLOCK_TYPE_NUM;
>> +               break;
>> +       }
>> +
>> +       return type;
>> +}
>> +
>>   static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>>                                  struct drm_amdgpu_query_fw *query_fw,
>>                                  struct amdgpu_device *adev)
>> @@ -600,45 +638,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          }
>>          case AMDGPU_INFO_HW_IP_COUNT: {
>>                  enum amd_ip_block_type type;
>> +               struct amdgpu_ip_block *ip_block = NULL;
>>                  uint32_t count = 0;
>>
>> -               switch (info->query_hw_ip.type) {
>> -               case AMDGPU_HW_IP_GFX:
>> -                       type = AMD_IP_BLOCK_TYPE_GFX;
>> -                       break;
>> -               case AMDGPU_HW_IP_COMPUTE:
>> -                       type = AMD_IP_BLOCK_TYPE_GFX;
>> -                       break;
>> -               case AMDGPU_HW_IP_DMA:
>> -                       type = AMD_IP_BLOCK_TYPE_SDMA;
>> -                       break;
>> -               case AMDGPU_HW_IP_UVD:
>> -                       type = AMD_IP_BLOCK_TYPE_UVD;
>> +               type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>> +               ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>> +               if (!ip_block || !ip_block->status.valid)
>> +                       return -EINVAL;
>> +
>> +               switch (type) {
>> +               case AMD_IP_BLOCK_TYPE_GFX:
>> +               case AMD_IP_BLOCK_TYPE_VCE:
>> +                       count = 1;
>>                          break;
>> -               case AMDGPU_HW_IP_VCE:
>> -                       type = AMD_IP_BLOCK_TYPE_VCE;
>> +               case AMD_IP_BLOCK_TYPE_SDMA:
>> +                       count = adev->sdma.num_instances;
>>                          break;
>> -               case AMDGPU_HW_IP_UVD_ENC:
>> -                       type = AMD_IP_BLOCK_TYPE_UVD;
>> +               case AMD_IP_BLOCK_TYPE_JPEG:
>> +                       count = adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings;
>>                          break;
>> -               case AMDGPU_HW_IP_VCN_DEC:
>> -               case AMDGPU_HW_IP_VCN_ENC:
>> -                       type = AMD_IP_BLOCK_TYPE_VCN;
>> +               case AMD_IP_BLOCK_TYPE_VCN:
>> +                       count = (info->query_hw_ip.type == AMDGPU_HW_IP_VCN_ENC) ?
>> +                               adev->vcn.num_vcn_inst * adev->vcn.num_enc_rings :
>> +                               adev->vcn.num_vcn_inst;
> Is this correct?  JPEG has a 1:1 mapping from ring to engine, but I
> think VCN is usually multiple rings per engine.  Shouldn't this just
> return adev->vcn.num_vcn_inst?
>
> Alex

Right, I am sorry I misunderstood this and made the change, for vcn it 
must be adev->vcn.num_vcn_inst, multiple rings here do not represent 
separate engines.

Regards,

Sathish

>
>>                          break;
>> -               case AMDGPU_HW_IP_VCN_JPEG:
>> -                       type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
>> -                               AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
>> +               case AMD_IP_BLOCK_TYPE_UVD:
>> +                       count = adev->uvd.num_uvd_inst;
>>                          break;
>> +               /* For all other IP block types not listed in the switch statement
>> +                * the ip status is valid here and the instance count is one.
>> +                */
>>                  default:
>> -                       return -EINVAL;
>> +                       count = 1;
>> +                       break;
>>                  }
>>
>> -               for (i = 0; i < adev->num_ip_blocks; i++)
>> -                       if (adev->ip_blocks[i].version->type == type &&
>> -                           adev->ip_blocks[i].status.valid &&
>> -                           count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
>> -                               count++;
>> -
>>                  return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>>          }
>>          case AMDGPU_INFO_TIMESTAMP:
>> --
>> 2.25.1
>>
