Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D58C46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 06:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC56910E061;
	Wed,  4 Jan 2023 06:21:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0B910E061
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 06:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiWoc+/ZFw8dLZ66YxEerT9qDtG8YC8O6PbuH4rLGJ66bcly99pQdGuxFCa3zrCpZGRVLtKIxteQ40ZG5p6dqxgaW6Qev/pCV89ejRHfMROaLcRX4FaG4XH/LZA7K4+5z5CXXOJp+MUo+iAGuF0lkYYTwVPOeL2MohCuh+3AvgJ75XGRaHnPv9yjPbpdxE4b4LoiYzOu6g95LjBbhyyIOwX2o9VvaECS+7uVkhe1l8jsNMVwNI+txdAxDorMy09Qw10k6zgc9Uc7hBaQwXfqVGzGRpsNLBVGrh7U0/dSr5lXMrIZUD3BrNMa0UfOc1t7DxTNPWqJ1lBn3CmZfR9aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IJVMbgJ8xqTfY13Wmc/yUEaoTkFs27LrZkWBdGXJhk=;
 b=UZ9148d6l52qNCHUOfJVJ2LZa0a/W/rJZjT6PTxFse+gDvOYWQiyNled7utvdgSwQyUkIZPj+MlpDMLLpYNg20L41jQTsLlmZLrik9YZHvQVls5N+5brrirnFJko7RYuoi2nbVYlqdT/MydYtsSy9yuWDbao/fkURbP6CO1Pdb9djtNwbsbtlxrEOpZPiXdTLrDTU5Ny70/024wDXzJCW5D0JwZflOd8Jrr1KM67jUiMZ6iKrN3ZTXRsUdAND1B9IjWHPKd3IQvOSp/J73iwmSyqLa0MGasjQl91T8lYDPuOaE/mEPRiMSYQ04UzhAK1R5MV/YxEyDv2G8OdVFdf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IJVMbgJ8xqTfY13Wmc/yUEaoTkFs27LrZkWBdGXJhk=;
 b=s5+uqAwb3iHSmUvf3ipu94den5GXU0hEZq1hpiyDvyyZnpWDjc9T83GUQtCaVA62snZdIt9Kj0yUROl9x2yVYFNkgRMcfc9+NxrYZnduvnb8ngbvtJMmyiCTltutdySGxTucFVvpM1kyp7xBeIGNO5D1Q8apQC3XbP1Z+5TuvaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:21:44 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::d197:9c96:338d:c848]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::d197:9c96:338d:c848%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 06:21:44 +0000
Message-ID: <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
Date: Wed, 4 Jan 2023 11:51:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
To: Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvyadav@amd.com>
In-Reply-To: <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To PH7PR12MB6000.namprd12.prod.outlook.com
 (2603:10b6:510:1dc::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6000:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 966b33f0-819b-4145-6771-08daee1bf32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6ch01BNKauclru7PL5+JOFe3LMyHhJTGN3MnGKxmAPGBcTBMCX5UjRWJr0t13TbmomSbLv8iXnSmnPuuemVT96TFTNiyw2rJG/iCpvEw1q6VUFrbIl2XBKavW6/Wc1z3CQ8XlD1d8hzdwonsjoBl8Ik37QwAEresabzZHUjnyVRvRMy3wBjUDwj+ScGuflOuHz30lJwTT1JuWu/8SoKH806RaitFSdduw8cWfKvDZwh7esg3bHkGwAa3s4Eoj69fQHSHbDDtoGOe0xyxCetEHbGeF8EiR7isxm/UKFftP65WXAk8ZVrsSx/6bRxhazUvdItcO7isn6TnEENNCOfymqD5OwFexY+sAKu7qCpSznS9Mxdd/2J0du1h8AWMV5c9UGgjUOSoDTArWfe2i3zKgzEFSaPqm0FiL5793M/iQphq6i+1WpQZUuwxkhUGIm4tsTFMgbzQMKtyJHUQ+kD29KHMaK3YSXqMS/gYbtDkqw5M2mYcsdntqphZ/oNq4bVGTWYAKmujuP7hENFB6VRbZSjy3XSgYYLZVMolVjJbiQHsxgZN+zgOg49atubdqs1JuY+vMAJEMopYTCJYtjySWXeHFk5cJZEmV1K49dC0iDvQHZNYC2ppUSQervQhrFTzEUqKcWQYQ4nbpdqSEkZIsMn7qIdHbeO82cpURyOAroI5y+5S8WG37WV3pnwmzBg9MKPFojrHtyzx9Iuk7SVOApkGLrgRNau9W+3pt7QHOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(31696002)(8936002)(2906002)(38100700002)(5660300002)(41300700001)(66476007)(6506007)(53546011)(4326008)(2616005)(316002)(186003)(6512007)(26005)(6666004)(478600001)(55236004)(8676002)(66556008)(54906003)(110136005)(6486002)(66946007)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3pDSEhaSGJ3Tk5Uc0dxUDhhblY2UE9JV2wyYUg1WlpoNFFZdll2NTRaa2hS?=
 =?utf-8?B?T3hSdVQzb25USDRLaU1xTGF2ZkNJNkVUMGlUS25DT2FrNVMxWll1Y1RjdVpj?=
 =?utf-8?B?ZlV6TUFBeHVhQ2NOV1RtdWxDbG1nM1dlZXF1N1k0TTNHeVhPK1o3MlM1RzBq?=
 =?utf-8?B?WU14a0hocVplOXRMVStnYU1Qd1FlL204K3JtZVU2b2srNjlnN0VxaFZyU3hF?=
 =?utf-8?B?azNmOFU1ZnJDNlh4YVJrbkpwKzd6Yk5QTHBVU3hKRTZqTjdjeTBscnVqVEd4?=
 =?utf-8?B?MWozWnpoUWcreGFOM3hVYTRuVXNiYWFObzZLRUZINTFKNHphcVhlZ01BSGZG?=
 =?utf-8?B?MEczSjdkVjV4M25admY2cmtxQ0w5UzBEbVc0UWFMTis5cHpMWlV3bnVXKzZ0?=
 =?utf-8?B?ZjIzbnJOUDZZOGtEOTRpSkt0V2crUW9iKzZOOEwweVZ4Y0JEQnZsRndhSmhU?=
 =?utf-8?B?TzFRaGtIQU1wNjBjNFVhY1V4aXZ1NmFiQ3RZWjlCQ2tIcWs1SDNZSTdSSWdx?=
 =?utf-8?B?V2VjZDhGWW5vK1h1Wnh5aVNsT0x6M00wMGhyeGxKYzNLTVU0a3ZNZXlQRzk3?=
 =?utf-8?B?YnZzSEpueVpqK1djbnZRelN6b29qQVJrWUVRZlB6aGtZRnVsekpKdC9DcFpN?=
 =?utf-8?B?ZUQ0TVlZSEhMU1RaTXNuYmlaYVdUUnRBaGwyekNUWkVvb2MyN2ZGNEVIaHZ2?=
 =?utf-8?B?MHIxUEVIUXdSODFQOHp5eGdOcWhXT3VFd2FGUjR0c0U0ZSs5YTM4ZVBIYUdu?=
 =?utf-8?B?N29YR0l1d3RGdWJQaG10MWZOb1BLM1lvT0tqZm1IdWc0ZWFMWFdCMTE3K3la?=
 =?utf-8?B?SFIrWkREdFdXUUVMTlJPVWJZOFBIRVVwYXY0OC96OG1GSHlsNjZsVW9rZ0NE?=
 =?utf-8?B?bjlybXk1bXlmMDhJR0VDYjg4dzZjN2hlQ3ozRUU0YnVCK0R5RUhFWXExT3Y0?=
 =?utf-8?B?SjlVazNpNmU2aHJodWc5cTliT0FYdWNya05rcmNIbGpXZHl5ZllOUGhYUTZL?=
 =?utf-8?B?Ky9YZ2NmSWNxOXBWQWpSQ01TS3l1T3BrVWVTbkpBZHdxMlkxOWhDVERLbWJX?=
 =?utf-8?B?UEV0dkYxSXdRclZCYWVQRm9zZFk3Y09tZEU0R2pGUzU5VHI5SHZ3eWVGb3hv?=
 =?utf-8?B?QWhCcWxYK2w5NXhwUXVaUlM5cVl6elJCYXVSVW1LVkxKbHZpWnJVZVBKc3Iy?=
 =?utf-8?B?YVRMTElYekhaSFJQK3hYSkdmVGZsZWo5WTg1YXYxbFYwbkd4QzczMkZXZklO?=
 =?utf-8?B?ZytOS3BwaVZ6SVZyZVlPeElOWnN2d0VSTXRmR1VKWjJPY25KMGpwM1I2WGg3?=
 =?utf-8?B?ZmJ5bVZIcSs1UFZWUGlLUThYK3dic0FtaFBuZHM3aTlwWWtaUXoxV0JBSFM2?=
 =?utf-8?B?ZytDN01RMlNtSHRndDZjZTZFVWpQRCt3dFdDR1JBUU1zTEJhUkQ1SEsxaW00?=
 =?utf-8?B?WEdYalpoTEV2cHBZUzNSMHZjMkRIWWFEc2pqRmh1cFJEUVJuUTEyUStpMHJE?=
 =?utf-8?B?YkhacmRnS2I5MGlVRXFaRkV1TU1QQ0dzUXVZSVpnWE05cGFXL21iZDVCQ2dH?=
 =?utf-8?B?cUhkMmlQendSajlWSVNQRXZqbk5BK2E4ajBhRi96NGtFNWNzR2tlVkUwYVpF?=
 =?utf-8?B?eVRZcDZHSnZGelBSK21nSnNEaHlQTG00Z21lM1ZQWHpVenNBTUcyMDFrTDhM?=
 =?utf-8?B?UXY1MGkzNThpcFJ6RGtZaFcwNSszRTlsNTJOQzZ6ZEJBYmRaVUIrejgzMWlF?=
 =?utf-8?B?bjREV2ZzZGxZdzVUSTlTWktUOVp6bEdvdVVwYll2cTBwVmd6YXhvY1g2OG5K?=
 =?utf-8?B?eUNBUEVncHJYWWdlekJlc2hJaDJYb3hpWWVyeERkdWlKbVF1TW1hb2x0ZnQz?=
 =?utf-8?B?VDEreEtiMnFHRFd2V1BYd2kveGhHWnMrRFZOVGFnWEdlTWNjdEZ6QlUzdmVt?=
 =?utf-8?B?czRNQmwwdjB5U1BtQzlsaDNPMEdHZ3VyTFJMSTJyaThRNHJFeWFqaFRGeFlj?=
 =?utf-8?B?VHl6N3BJS1F1OVNaaU1tUjdQanczMXVXbTFFUWNhUUJPNGEvR0RmdW5HVWV5?=
 =?utf-8?B?dXZJWmtjcWdGZjVpZ2VDeFlKYTNiRDV0dmx3SDFpbmxzSldyVHdOa0VVVHU5?=
 =?utf-8?Q?dS38Z5ZLIA1ADWmvjmldrBr/2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966b33f0-819b-4145-6771-08daee1bf32c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 06:21:44.1240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1+WDeYZy62izzEGTcnPNaz9UNM3ltXMMlbAHEKdLgiHq1SxhmsHC9ofP7cwXQQZFDyI16A+hTzvpyiocIIUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/4/2023 12:07 AM, Felix Kuehling wrote:
> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>> /*MQD struct for usermode Queue*/
>>>> +struct amdgpu_usermode_queue_mqd
>>> This is specific to GC 11.  Every IP and version will have its own MQD
>>> format.  That should live in the IP specific code, not the generic
>>> code.  We already have the generic MQD parameters that we need from
>>> the userq IOCTL.
>>
>> Noted, we can separate out the generic parameters from gen specific 
>> parameter, and will try to wrap it around the generic structure.
>>
>> - Shashank
>
> Is there a reason why you can't use "struct v11_compute_mqd" from 
> v11_structs.h?

Hi Felix,

Yes,  V11_compute_mqd does not have these below member which is needed 
for usermode queue.

     uint32_t shadow_base_lo; // offset: 0  (0x0)
     uint32_t shadow_base_hi; // offset: 1  (0x1)
     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
     uint32_t shadow_initialized; // offset: 6  (0x6)
     uint32_t ib_vmid; // offset: 7  (0x7)

So we had to add new MQD structs.

thanks

~arvind

>
> Regards,
>   Felix
>
