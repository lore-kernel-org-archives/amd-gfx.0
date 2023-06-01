Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E4C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 21:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946A310E5D4;
	Thu,  1 Jun 2023 21:08:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBCF10E5D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 21:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne7ml0SiVjHHfhGNhbljiRui7DOEAQUT1nvN16P4uj9jKAJM18mNNcdMSLnXxZIX6yRa6OGHw740B9ZGeW3YNc4/ciVcVmr0g82TGAyKHc2ef9p4yhix+cf5A3bpSMIVIf/7RYlSpPywWP36hiYA42VMUpCKWiAFtxfgrdKTMs6RtdHvgQRoUGs2kbGpm1Ukf/skDhqmDz8lrk1xMEO7uxw+zCVc+F8S2A2MdaLC1Z8vXesYiKMjmmgPwSRI9smHvtehI8NRw+jNpaRAO0ZmovvwcLgAI894Qr4CdSXk+v7VZTQeiOdvmnfFzvxZbV7OJLEhcMXp+xvVYCas9tbtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QGmxJ49HV7M2whcdHviWxlJcSjUhbjQTusqS5PieSY=;
 b=hI7K1SUdtN1y/3mEbbKZLguOSrybZN9Curh8qJo70nGztON/zdMi5SuSVvQ2ZygKEfyzPW76dYD29AoycTueN/3PJ6LXIOH84pIohWYouThaeMZENtpKawZe66vtGskmXU9Hcco4NubWfWipryaD0og/fFu4yWSdDMHhVAHBDl//Ak80ZUQ0gGGDde6eKQkMLRbOuS/BDf1ZqbKHYahqRY3scVThVwgX8wWe8Y+uW3CeVAWhKZvGVWt6DBY1ay+xXPjKEjbD3cTkA6d4owz0Q8hhPjNq9o1igTvQf5BTWf9ko7FlSBrQ/2RyphNFqZyIamgdTNI97l/PnfZkqFU0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QGmxJ49HV7M2whcdHviWxlJcSjUhbjQTusqS5PieSY=;
 b=fAP55cuovr9j9aKBwGbxc64taxWWof6Ni3xhJ1XyBz+Z6HIJXalgFgqPf6J+ZN81bmGefl0Iud5USjOL1vWJkF5TYGVujfS6GdFQpo160A7Y/MAPTz/Pl+Q5CLo900g3VmxKepXnK6DF5c+s8qnSNe8lDUeiZMELBbSEHcTbN8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 21:08:13 +0000
Received: from CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::de84:8cc:ac46:12fd]) by CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::de84:8cc:ac46:12fd%9]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 21:08:13 +0000
Message-ID: <d65f86a1-c1ea-be6c-6a3f-099a324cee6e@amd.com>
Date: Thu, 1 Jun 2023 17:08:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add event age tracking
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
 <17389962-dd68-fbc5-c523-0b47d9381a8b@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <17389962-dd68-fbc5-c523-0b47d9381a8b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::13) To CY4PR12MB1750.namprd12.prod.outlook.com
 (2603:10b6:903:11c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a0ac6b-2cf5-4aa7-2e96-08db62e44f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goGu8QOa+YNjsMmFoLWBpAqBH3u4h/3z0hC1PGDTjH1FebJwCUqq2OK5/casa7HeOADsMkHvhgcnz8GqbEr70YIaFbGU7tnMcaT7u8Z7GPMg/tVDci1XVGp0vFbwRD9cXA2cEAACyE7CCtPWtxy6r9Xy1Jg2wCEblrMn5oSoQ3IW2RFynle++DZH/WjvJqI2rRRAGM3GMu8fCLOdTlu50QWiZQ+XjZz8d3t+CxrrQc18ZOEKatLdLlE6RHb96wgYpFIE2RdvjCeHqz8fZ20hD2MsTElCn5JHJovvHCUZVMZV44jsSAQZi2BtRtxEiD0Gnn/MoiuIx/OxUV0gVBvkjkpW7pVtWv0ZQ92xFGUi5rWvdELxW0xkf70bsblGMZwiISsEgmWhDn89z/oSBofUGj01y7KA8qHM/4el5ovw0tR86A1h1Hrl6EAAgxWYKRQQyd5HT9TmnRrKgHRNOKaTyW/97Fu9y13ds1zeUzrYWo8xUHig2ukTiysZGzD55z9U5wd1Eet0kicLkkyxQ90SpQO5I0vv5cvWqw3sJ7bJEt8WK5tTX5ttbB1gaiF+XOB1b4mG/zz/a0eriN8YSCjHCvkUnAaasWyV5CLHdCZBNX4r41tRyrOihRtkEMv1Y0d95t6+dUGoaDARN2+jy0RAdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1750.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(36756003)(38100700002)(31696002)(31686004)(8676002)(41300700001)(26005)(5660300002)(6506007)(6512007)(53546011)(66556008)(2906002)(186003)(2616005)(83380400001)(6666004)(36916002)(316002)(6486002)(66946007)(110136005)(478600001)(66476007)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFDMjhXZEZHWkJVVnpxWmdqaVdnUFBYMjhGRjNSNGF0NzFiaTl3ckcyblhS?=
 =?utf-8?B?a1ZBRTZYdEZFZ1VSRUpoMEhNOUJVdUdvb2pOTEd3MDJEaVVFRTNRTDhsbndh?=
 =?utf-8?B?aFFLMFVzenBSc3AvTkJXaDdJNVVvZkJxemZNZEFGcFFGMnh3TDQ2ZFZaMzB5?=
 =?utf-8?B?NXZVblBCK1RRNm4yWUJHYkROYitQYy9NWTd1SjlJcXJvNzFnZ2ZDdUxxZENL?=
 =?utf-8?B?aFpmNGh5aFNzcTUrd1FTTmJUZUF1QjM3bXlqK25BcjhGd1hSTzM1QkVMYUNh?=
 =?utf-8?B?cWVGa0haaVRXNWVzYkFFQVo3NndTcGNZSi9JQlRwM2NTbE52Tnc4U25zRzRZ?=
 =?utf-8?B?MDVBRDZCc0JwNm9XKzZpOGlyUDgxNDNNR3hsaDdkcDA5dzVIODYxbjFTOWpm?=
 =?utf-8?B?TGZCcEVqc0YrQytRV2hsS3lFSEhqMDYydVNKZnRlUi9sc0Z1bTF1YkxoMVhW?=
 =?utf-8?B?OFRhdzN5czFNbEpCZXduQXpkTU5zekM0WkRoajdqZTZSOTVnWmJTRGFXVnVF?=
 =?utf-8?B?eFJBeW5yczhETndrcVBuMjl6M0EvMmYvMU9BekVic2lxcEJzOUhCc0oranJm?=
 =?utf-8?B?QmY2dDFtV21FVnRZWG5JOXU0OXZkcTF6ekgyOWVqeWZGZWtISW81eW5zeGVu?=
 =?utf-8?B?Y3JKRE0zTFE1ckFhQWg5K1ZkZHN2K25vWTd2SUZrcTFhZk5tY0NTVlM5RVpy?=
 =?utf-8?B?dUl6M1I0ZFRuZWhhajhLZ1BWSC9GVFArNnhycWhmSFR5cm9zZDVoUndVOUdz?=
 =?utf-8?B?Rk5SREhNOWcyN2NKblZ1dW54aENGZ200aE4vQzNDU3pURjVENVgwRWZlRzNC?=
 =?utf-8?B?SHd1RGFpZEowNk1TRnJKMWMzN2IxZGxVTjE1cFN0cFp3Q0tyV29JYmw5MnVQ?=
 =?utf-8?B?MFNkTEIwWUNYQ1NQUzRuRzF4TTFTR1hYS2R4aHAzbGdJS1IwblV6dUJaYUVq?=
 =?utf-8?B?NFU4UVNXMGJDQ3IyTmZQUWpvblV0cCtRQnNsZ1hEZm0veVNHNllzUm4yZ2hl?=
 =?utf-8?B?NTNHZks2ak5qbmQ2TjU2OEFwVHJFUGdzZS9lYnVwcHRpMk5rYlpiRFlVbmE1?=
 =?utf-8?B?WkpXMDRRaUFOa2RMMmViQzg5ME5CSmJWOVpHSkxVanNSK3F5MzNrUGdUWjd4?=
 =?utf-8?B?bE04a1J5TG9FajdNWmhmMWlqWUYweWhORGpmVWdvSm80NG96QzY2Y0RCbDht?=
 =?utf-8?B?cFViRWN5TW1tVWdQQXE3MEhBL2dYb1FYa2lIR1MxZkcvNUwzWFMxYnk2V3g0?=
 =?utf-8?B?TjhON1JDTTVnWHBhUENLMndXekV2bVFJV3ozZ2dwaXR0OEpEUlhDVTFHTTQ2?=
 =?utf-8?B?K3RLK29nNFdURzlGRHFWd0lGRzhidXV2YjhXcGtwNEVDTkVhVlh4anp3S255?=
 =?utf-8?B?ZkEwYk1sSFBLUWR6cnFuaHA3VzRmRVIxb0pCSmhWWkVqS3grUjY5bVV6N2xH?=
 =?utf-8?B?VlVZaEVnOFlPckF2MFhNVGE2dkVZR0VOQ2ozdU14VVVOMk94akpoR1pieXg4?=
 =?utf-8?B?VTNGSThXeXowR1l2eGlLZG82eFg3VzkzdmtWb0lIeFordmJoVC9hU0J4SjU0?=
 =?utf-8?B?WDNCaEpJTUJvSU9UNGRhekRhV3FONUVIbDVRNDFGUzNRMTQyYkJoME5BQ1hB?=
 =?utf-8?B?b3ZQNFErVmdacmp5dkxUV1dQRzR4Vm9UUXI0YzRESjNUcGhXUnNkMnkxRW5v?=
 =?utf-8?B?aDE0cUFWZXQ2WWNKaW1pc01lZCtlTkF3dGh2S09DT29zbEwwZWlFc25BSDBk?=
 =?utf-8?B?bkNMSXlUbGtnTEo4STVEZDF5M1czNDdzeklpdC9PelpkcHQrUktybDhSeDh5?=
 =?utf-8?B?WkhoZ2FwbjR1My9rVjUzS1pybFZhZVliVnFOV09aTENXSnFqNVBRdm9vYXh6?=
 =?utf-8?B?YWwxNmlPemxGVFlDN2tBU0lGRTh1VDdoa3dEVkUydTQ5NW1UQTJsdXdXMk1r?=
 =?utf-8?B?TnkxQXRQSFRmbGcyNTBwUG83UHY2RGlZdlRRSE1aeUJ2MnZpVGRVR01jWHQ4?=
 =?utf-8?B?ek5wOUVhaHhCdFN6dG91Snp5RkV3SlVsMzlnbFlRWEZxL2dYYi9OcFVnUWpu?=
 =?utf-8?B?ZGgxNWJJa0MxdGlmazJTVC8rSlgyOFhNTmcyVXh4Z3JWSFNaYVZtZ04rM0wx?=
 =?utf-8?Q?WejmLv5XLRDbV8zagZESsP6QX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0ac6b-2cf5-4aa7-2e96-08db62e44f5b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:08:12.8752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgV6RfVNj7L8z/2ZDklbZqMVaJsh+l9H1FqWsMVj48x/EOdpzKBscsBdWFXwQDKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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


On 2023-06-01 16:58, Felix Kuehling wrote:
> On 2023-06-01 16:47, James Zhu wrote:
>> Add event age tracking
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   include/uapi/linux/kfd_ioctl.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_ioctl.h 
>> b/include/uapi/linux/kfd_ioctl.h
>> index 7e19a2d1e907..bfbe0006370e 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -38,9 +38,10 @@
>>    * - 1.10 - Add SMI profiler event log
>>    * - 1.11 - Add unified memory for ctx save/restore area
>>    * - 1.12 - Add DMA buf export ioctl
>> + * - 1.13 - Update kfd_event_data
>>    */
>>   #define KFD_IOCTL_MAJOR_VERSION 1
>> -#define KFD_IOCTL_MINOR_VERSION 12
>> +#define KFD_IOCTL_MINOR_VERSION 13
>
> I think minor version 13 is used for the debugger changes that are 
> making their way into the upstream branch right now. You'll probably 
> have to rebase this and use minor version 14 for this.
[JZ] Sure, I will change to version 14.
>
>
>>     /*
>>    * Debug revision change log
>> @@ -693,6 +694,7 @@ struct kfd_event_data {
>>       union {
>>           struct kfd_hsa_memory_exception_data memory_exception_data;
>>           struct kfd_hsa_hw_exception_data hw_exception_data;
>> +        __u64 last_event_age;    /* to and from KFD */
>
> It would be better to create a new struct kfd_hsa_signal_event_data 
> for this to make it obvious what type of event it applies to. And to 
> keep the union more uniform.
[JZ]Sure. I will update it.
>
> Regards,
>   Felix
>
>
>>       };                /* From KFD */
>>       __u64 kfd_event_data_ext;    /* pointer to an extension structure
>>                          for future exception types */
