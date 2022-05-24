Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D18C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6943D10E315;
	Tue, 24 May 2022 15:19:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78E010E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 15:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtiUclwSSh1ag/U6oSfmyLF1JP9P9FaBYBVs4CwT2d/E2JXENqsOOKYVLEWLQ+HMZQfwxz/G/kQZFtgz2ipxBgVVlk+2yJdQRiXOhT7Z402l484U+avFwpVJn3/Lqy72hh9ZyomAMMQuZh4jmirPl1QpFgcly1FAOt01diaEyWep2hY+mclfsMq4JBupLrHiX5TBFaFySJkgDsqZocgBqcQKF5d4dvxTnma9BmDrTBDtMNv8cOJjc8+V11vQGlCSIRtY8Kcf7QdR3Vsa1w/qpvdakYKqeT4zOMeCeqtX2XvTLdPGnNkF/Nm2HSn55DK2gpRx3nP9yF32/7VTXtG6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ/hrFCdQabhLh/MDotb0qbAYPqNvjmuav4QQF4qkSI=;
 b=hUeXP26t6Q2ik63Q8Wd1SkXxlJDxeSopGOhtizebYNgFaOq8trSm+xYK151M0ceGu+nBMQo5z0cCG/OPuqU/4OUyZ7eqX29b8vgKWzb7RCpYWpLatqrF78/pQx476t8H4uDRCh03YEFY3ClXz35DI3l0ko3riPowM9ZuIYkilhUHCGFYxkv3D8zJh21eqAV86a+PamLO4o+lxylgHLD5k2eB+f89wAL+A0A4orXIbyzcb5J/knQoNhEgFfz3oT42+LFaj6wTL0JOgBPyNN21A+OkLjEJRErty/MPBW4/Td5ppm0Zooypp2VMXWArS2kie3LgkQM98xqdauE09Ff6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ/hrFCdQabhLh/MDotb0qbAYPqNvjmuav4QQF4qkSI=;
 b=gvH5XayJMN16toPOCbDglwFSMDlpT06N9ict+Wwns6E4lvQzmJNO77w9pjh9FbT2jwCzHx8zoWz8yFACrC+PInKbNjLzUZOQfpNU6B95I/NSkPnEVwhXfG8Onxnwdb3rYjOcQ70SZQ+Ha575+hDOpXxLYY7xyyjvoxh4kzThF8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 15:18:57 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 15:18:57 +0000
Message-ID: <ed9a32cf-1cf4-2fdd-1e8d-5904c4d24837@amd.com>
Date: Tue, 24 May 2022 20:48:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
 <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
 <ae53629c-7922-6a17-c162-e9397386106b@amd.com>
 <2fb3744b-f23a-ebaf-98a3-34b4eb12df80@amd.com>
 <ee0413a6-c1bc-f927-92b9-d5b0ae4499d1@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <ee0413a6-c1bc-f927-92b9-d5b0ae4499d1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::14) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40635dea-1a23-45df-cca2-08da3d98b8d7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49023B286F5853B139DA8B72F8D79@BY5PR12MB4902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avR9t8ibxmFcwwfSDgZRWYRE0w6MG5IQkePcxJn/bkYclVFzHogct6t/5U8SNzWfnCAZVx5oS9L2QXzlvUTerS/beBLx/MxqxWyIyuywCWsOJ2zptgGOxIuVBmPMA8uf+BxOZAatNfvvo/qmbqhcCSGBVfBMRImNaSlr90nirpw5nTzbmfCgmU18ZFhFoWNFUObupYD7yANJoz1O2Fk6ki1YH8e/ltZQ+EI1CtoERF9AmxwJqLKeMLbrxhay66EIUEK2Ojo2zvHh3Jfq5WZS8WnqYtqu3SEytD+VW3yVZsjQmLdGL6nhaylWuhTFeaCfI444rhfGIGJR0ib+20lMw8J5IlY+iqSyWmvk2lbSkT+HX/WjY0mI+0Z9NEwCwD+TwKQ+2hu2AUySNRn+J6LrqPhtFsFwQeeQRJYGYAm0SWOeHeOafcm3MnZLNeFttCgg2O1OJosd99K96aEqjfJ8zx8l9BzYZQRZlzP+DcDtf5lqAKEwjjhp6rGkO6S4w9amy8ZqpqyHoozsleaIlDmYyhnhaU00HhifZLHiYH5XBqHQefxkLGSb8DgausbqMs7lNCQc3HeHLRmTiporteXOiXhMG8EwfjDvR6e+BgEP/8XZ+qhWHoO/xDe4R3lPOzkJdpD99YV8iAO1tuvkUU2S1KV0EbBXBzVJIpDTEXrlW6bYBAc9/l5nCLDEgpNXEr1PCrplePASw9kVqclKnWz7I/YDnxyhBOxLZO9RF5xLeqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(316002)(8676002)(4326008)(2906002)(31686004)(38100700002)(66946007)(36756003)(66556008)(66476007)(110136005)(6506007)(5660300002)(8936002)(53546011)(6512007)(26005)(2616005)(508600001)(83380400001)(6666004)(31696002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpqVThycll6OHp6L0orZnN3MnpEZUZ4cWozRWt2WjVaYWRnSHBOYitZSGky?=
 =?utf-8?B?MGVjZ1NZaXBnQ1hiVVlhRTI5TU5xbXNKTlREdFdRaERsSEZ4dzhrdGFGeWZD?=
 =?utf-8?B?NTF3dXRmU0NySnpCbkVZZjY4d1lsMjhsbHFqeDY1cXorVmNkSVkrSjZtWWpU?=
 =?utf-8?B?VTUzOU1BYitiYlNJaU1YOU05UHlzNTRiYk5hdEFWSFZhMlg3S3htVWg4Y2xw?=
 =?utf-8?B?MEtiSWtIVUMzcmJTeHQrVjI5L0VnK3ZDNmZKM0VualVrQUppeXJmUmVmb1pJ?=
 =?utf-8?B?R25Rc1NHdndPY1ZXNVNWUjc5YUxTdEZFeVVOT3I1QUxhUjFIWE9HT0lCL21B?=
 =?utf-8?B?MFNOTWlZbG5seGpCZHdCUEE0ejdQRWhPamtpSVQ4TWlNWlVxZ1BVOXlYZlVl?=
 =?utf-8?B?Y1hpc2xKakh0cGNQalVUQ2dxemJnSEo2UDBGdXczMzNEZUIzZ0YrMlhRcGJY?=
 =?utf-8?B?bVY0czQvWCtrSll5QkhCUXFyU25yWWkyOWo2MEx1QjltNjAyZDJ6S2VBbmJW?=
 =?utf-8?B?YmNib0wyYjIyNGdtb28rTzFqcHJjRkJBQW9IOFBaR084Y1FSK2pRNjI0bDdu?=
 =?utf-8?B?T2pyT1krVThqRDdVQXpBamFKeXIxMjVjQngzdUVNSWlwM2xaNWEyOGtZNStt?=
 =?utf-8?B?dGdkK0JxS0Y2MjM4Q2dJdm91ejh3Q1FPYnJ3K1VRVUNaRDdQdWNZSGliOWps?=
 =?utf-8?B?MlJGMWtOanlpc0NjWW9WZTRWZ0xIdG9VVjY3RE5LZFBielUzNk8xdWk2OFdM?=
 =?utf-8?B?NUJIZkdIblg4MnNsVyt4RURnd29ORFliQzV3Tm9OMjg5T202UHF6eEcvRUJH?=
 =?utf-8?B?MXdkd2MxcGtLWEh1dHRWU1dJZ0dsbmsyemN3WWhTNlZSOWFKZEhvUHFwSzdH?=
 =?utf-8?B?WmJWdG13M1pMbnRrRGxqelNUNEkvcHlpVFFSZHY2bXBOYjZmZjlLSFBYMWJ1?=
 =?utf-8?B?QUlDNzNmdWV1ZGxxQml6ejBrVmJZVGpWQ2I0Q1JxWEpoRGFKdERZUDYxeVVr?=
 =?utf-8?B?K1M1Vmd3SXczUkM5U2tNOEx4M2xaQkh6WVRybTZqbzNXMFRGMnljLzZYQmhx?=
 =?utf-8?B?a25JYkhDWk5XbzZpSFJGUlk4VzlPeTdSN2Y2cXhkaUNTMWMwTFd4cCtiRGtP?=
 =?utf-8?B?NDB2S0VodW0rRmtVOTlBZmZ1ek1ZUUNsYVUvQzhOUWU3YnRVV1QwejV4SUxR?=
 =?utf-8?B?OWJHYnZmNzNQYWZ3OWN2anVHL3FEb01JSkFaczdORUh5TkhMVFY0QmszbnBG?=
 =?utf-8?B?YTk2eXVldWxXSzJhZlNQaGsra1RwNWVCVHNFaU1yMTQzeS9CUnVEcGRFRjl1?=
 =?utf-8?B?NWdZVlFmbFIrY3lGOHozRDBLRHYzbHhhcHg4UkFPNkxneTY1Ym51WDRNRFVQ?=
 =?utf-8?B?OE9DMzZJUDJlZm5SNW1kVGZIbllPWnZwZ2FnWmhDMmJ5Zng0elc1UXJaNU9O?=
 =?utf-8?B?UFh2QldsMmMwQjBqamVGc2djSlA2bmkwMy8waFQwZm9KK09LTTVvZjRvOXpk?=
 =?utf-8?B?akYvOVhmei9aUFhsS01DRnR5bEx2eEd2OFhZSytsbEY5aXcrUUlKZVljWWxm?=
 =?utf-8?B?SUdYdGFZNVVWVks0ZXg5cktiWXU2K2dBbU5XQlNpQ1NNY2dpUTlBN2xROXVX?=
 =?utf-8?B?YWxaR3JSUFViVWJ2alZzZ0pGRTBsWFRWUm9idDdOR3lXV2w4YldPaWxzS3JM?=
 =?utf-8?B?RXQ5Z24xZ25ZcHE0a216S2hPZWpiZ21lUUxiYlo4NW9nV01QUG9pUlF6Vm5x?=
 =?utf-8?B?THBZempmcUxLVG91SUtzNm9YczVOVWdlR1hELzlHWHJVL1JHS0pOQzRTcHdI?=
 =?utf-8?B?Q3QvK3lya010bjEvOFdyZkZFQzBPU2hsQi94TG9iWi9PNnlpZEJhSFJsbkFB?=
 =?utf-8?B?d0R0YXRLRnpvYzI1Qk5wcVZESWV5L1FWdmw0RjgxajdXZU9aMGd0OTQvbzhG?=
 =?utf-8?B?VnFTTnYxL0RwQXVRVUpUSExORkNmWGZ1NzBzV3NxWjRWNnBRVHFaL3dUTE9D?=
 =?utf-8?B?Wi9FZGRYOXN4UWkwelhidDFYS2hiVHJzdS84d0ozWUNqZzJWNFFIRlRzaGhV?=
 =?utf-8?B?UUluRHpqa3lQcEVBV1hyaHFhbDFkVjhWb3BsVzA2dmVxdXRydFArRmRDU1Js?=
 =?utf-8?B?U1VBUktaN0ZDMU5PbUt2ejJiajdscGhIa05adnBCRnZXL3NXZW55YVhPalRh?=
 =?utf-8?B?SWpVdWtmOFFuWkVkazRLcDc0M1J1aXhrOURjaW9lWHJGalZRbkF1V2E5QlVo?=
 =?utf-8?B?KzhTRjRMK05kaC9RU1pWbVZKMGVBWTJ3OWwwK3JZQnJGWjloQTBTQjFmWURv?=
 =?utf-8?B?ZlQzZDd1UXJhUlpJKzlRTVQ4dnlCcjlQY1h5eFJwcFlOODc4UFJqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40635dea-1a23-45df-cca2-08da3d98b8d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:18:57.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPY1dkjWYqD2j+Si8U3Ib3FxmBPrT5B8QyCAiFgoTlU2ZS92Tvu/X8KMiEMjLJQm8V99G4gZBm42oh2xzkMHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
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


On 5/24/2022 8:34 PM, Sharma, Shashank wrote:
>
>
> On 5/24/2022 3:18 PM, Somalapuram, Amaranath wrote:
>>
>> On 5/24/2022 6:20 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 5/24/2022 2:10 PM, Somalapuram, Amaranath wrote:
>>>>
>>>> On 5/24/2022 3:23 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
>>>>>>
>>>>>> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>>>>>> Added device coredump information:
>>>>>>>> - Kernel version
>>>>>>>> - Module
>>>>>>>> - Time
>>>>>>>> - VRAM status
>>>>>>>> - Guilty process name and PID
>>>>>>>> - GPU register dumps
>>>>>>>>
>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 
>>>>>>>> ++++++++++++++++++++++
>>>>>>>>   2 files changed, 62 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> index c79d9992b113..f28d9c563f74 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>>>>>>       uint32_t *reset_dump_reg_list;
>>>>>>>>       uint32_t            *reset_dump_reg_value;
>>>>>>>>       int                             num_regs;
>>>>>>>> +    struct amdgpu_task_info reset_context_task_info;
>>>>>>>> +    bool reset_context_vram_lost;
>>>>>>>
>>>>>>> How about drop the 'context' from name and just reset_task_info 
>>>>>>> and reset_vram_lost ?
>>>>>> OK.
>>>>>>>
>>>>>>>> +    struct timespec64 reset_time;
>>>>>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 963c897a76e6..f9b710e741a7 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -32,6 +32,8 @@
>>>>>>>>   #include <linux/slab.h>
>>>>>>>>   #include <linux/iommu.h>
>>>>>>>>   #include <linux/pci.h>
>>>>>>>> +#include <linux/devcoredump.h>
>>>>>>>> +#include <generated/utsrelease.h>
>>>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>>>   #include <drm/drm_probe_helper.h>
>>>>>>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>       return 0;
>>>>>>>>   }
>>>>>>>>   +#ifdef CONFIG_DEV_COREDUMP
>>>>>>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t 
>>>>>>>> offset,
>>>>>>>> +        size_t count, void *data, size_t datalen)
>>>>>>>> +{
>>>>>>>> +    struct drm_printer p;
>>>>>>>> +    struct amdgpu_device *adev = data;
>>>>>>>> +    struct drm_print_iterator iter;
>>>>>>>> +    int i;
>>>>>>>> +
>>>>>>>
>>>>>>> A NULL check for 'buffer' here could prevent a segfault later.
>>>>>>>
>>>>>> Agreed.
>>>>>>>> +    iter.data = buffer;
>>>>>>>> +    iter.offset = 0;
>>>>>>>> +    iter.start = offset;
>>>>>>>> +    iter.remain = count;
>>>>>>>> +
>>>>>>>> +    p = drm_coredump_printer(&iter);
>>>>>>>> +
>>>>>>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>>>>>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>>>>>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>>>>>>> +    drm_printf(&p, "time: %lld.%09ld\n", 
>>>>>>>> adev->reset_time.tv_sec, adev->reset_time.tv_nsec);
>>>>>>>> +    if (adev->reset_context_task_info.pid)
>>>>>>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>>>>>>> + adev->reset_context_task_info.process_name,
>>>>>>>> + adev->reset_context_task_info.pid);
>>>>>>> Please fix the alignment of print variables.
>>>>>>>
>>>>>> I will cross check this.
>>>>>>>> +
>>>>>>>> +    if (adev->reset_context_vram_lost)
>>>>>>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>>>>>> +    if (adev->num_regs) {
>>>>>>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: 
>>>>>>>> Value:\n");
>>>>>>>> +
>>>>>>>> +        for (i = 0; i < adev->num_regs; i++)
>>>>>>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>>>>>>> + adev->reset_dump_reg_list[i],
>>>>>>>> + adev->reset_dump_reg_value[i]);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return count - iter.remain;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void amdgpu_reset_capture_coredumpm(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>> +{
>>>>>>>> +    struct drm_device *dev = adev_to_drm(adev);
>>>>>>>> +
>>>>>>>> +    ktime_get_ts64(&adev->reset_time);
>>>>>>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>>>>>>> +            amdgpu_devcoredump_read, NULL);
>>>>>>> instead of registering NULL as free function, I would prefer you 
>>>>>>> to have a dummy no_op free function registered, which we can 
>>>>>>> consume if something changes.
>>>>>> you mean something like this (function without any code):
>>>>>> staticvoidamdgpu_devcoredump_free(void*data)
>>>>>> {
>>>>>> }
>>>>>
>>>>> Yes, precisely.
>>>>>
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>                struct amdgpu_reset_context *reset_context)
>>>>>>>>   {
>>>>>>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct 
>>>>>>>> list_head *device_list_handle,
>>>>>>>>                       goto out;
>>>>>>>>                     vram_lost = 
>>>>>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>>>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>>>>>> + tmp_adev->reset_context_vram_lost = vram_lost;
>>>>>>>> + tmp_adev->reset_context_task_info.pid = 0;
>>>>>>> why is the PID hardcoded to 0 ?
>>>>>> in case of reset context reset_context->job->vm is null 
>>>>>> (possibility that reset can be non VM related).
>>>>>> If we don't set tmp_adev->reset_context_task_info.pid = 0, it 
>>>>>> will show previous reset valid PID.
>>>>>>
>>>>>
>>>>> But when the VM is not NULL, are we updating this PID somewhere ? 
>>>>> I did not see that happening in this series.
>>>> This is the only place where PID get updated.
>>>> For example sequence of operation like:
>>>> 1st reset:
>>>> -valid VM and tmp_adev->reset_context_task_info.pid is set to some 
>>>> valid PID
>>>> 2nd reset:
>>>> -invalid VM
>>>> -tmp_adev context will remain same (adev context will be same after 
>>>> successful  GPU reset sequence).
>>>> -tmp_adev->reset_context_task_info.pid will be holding 1st reset 
>>>> PID value
>>>>
>>>> if we don't set it 0, it can give wrong PID.
>>>>
>>>
>>> I get your point, and agree, that when the vm is invalid, PID is 
>>> invalid so we should send pid=0. But where are you handling the case 
>>> when VM is valid and pid is valid ?
>> valid VM check in the below condition:
>> -->if (reset_context->job && reset_context->job->vm)
>> reset_context->job->vm->task_info will have the required information.
>
> And how will that reflect on tmp_adev->reset_context_task_info.pid ? 
> The point is, if this parameter is being set to zero, means it is 
> being used somewhere, so when and how will this become non-zero ?
>
#ifdef CONFIG_DEV_COREDUMP
                                 tmp_adev->reset_context_vram_lost = 
vram_lost;
tmp_adev->reset_context_task_info.pid = 0;
                                 if (reset_context->job && 
reset_context->job->vm)
tmp_adev->reset_context_task_info =
reset_context->job->vm->task_info;
amdgpu_reset_capture_coredumpm(tmp_adev);
#endif
tmp_adev->reset_context_task_info refers to 
reset_context->job->vm->task_info,
i am not setting PID and process name separately, instead i am having 
the reference to the reset_context->job->vm->task_info on valid VM.

Regards,
S.Amarnath
> - Shashank
>
>>>
>>> - Shashank
>>>
>>>> Regards,
>>>> S.Amarnath
>>>>>
>>>>> - Shashank
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> S.Amarnath
>>>>>>>> +                if (reset_context->job && reset_context->job->vm)
>>>>>>>> + tmp_adev->reset_context_task_info =
>>>>>>>> + reset_context->job->vm->task_info;
>>>>>>>> + amdgpu_reset_capture_coredumpm(tmp_adev);
>>>>>>>> +#endif
>>>>>>>>                   if (vram_lost) {
>>>>>>>>                       DRM_INFO("VRAM is lost due to GPU 
>>>>>>>> reset!\n");
>>>>>>>>
>>>>>>> - Shashank
>>>>>>>                      amdgpu_inc_vram_lost(tmp_adev);
