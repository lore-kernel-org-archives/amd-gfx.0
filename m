Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524FFCA1001
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 20:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3530310E506;
	Tue,  5 Sep 2023 20:13:49 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8087010E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 20:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGWIWVQy3pHSpyz9UrPSLoO4yU0hcHAGpBZ0+EgU+7CeLxn6PJRYghhqkVXXJcnapZkJ1Fs80p1vcUPIp5vS5L0ac80aDfHC0x9C1XgRTGjaVMuuwUMYE37iv7dOcD8osMEUoCXWzK6uMBlAunG3NvDwB4czCFR7w4gxJekK1V8KCTG7GYaNiVpH1JlTZT0yHwMdmgtfu+MtsJaVDfM7SDVQVB4gnUehk3Knfo34/YX2ik4Tr2wO17B6hMvEL3AQgQlRDBdgvbNrHnW5Z+RWHYKSzmKdAo5Wfq4Mz+cEQFsDd9qW49HQs8OG/X1IzUW0sDlN8vsr3iqoG5HN9RdhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFLrsPc49s5rWmsXBbDTw4dMzLcLhsiOnOHtd7DPd28=;
 b=Qvv5+s8vlW3QpDQ9p3bZpw9sb+zE0eWEncg01c0TvG+9XGyJ2R2qqb+GH7+nQFujjZhmg/wUBFDP9Q04Sm1x6qDwR9OR73MkkYyVDrbKj//Nc+hZBrcHZ764WiB+bp2qB5pEEAa6RM03VwnTC6kZ57Loi/RHNqY9SbI8+k8C8Y860x5By1I96yJvdKKJg4Bq+48CCUSS2s9ekuQ90RdHbIX7uFf1DK5in+jIB72YTILXeADpC+ued9NfJ7Nxm9hOJn55yxNlency9G821LoqOoCcG7wJEsRC+mAjt7AYhsCZlJO3TAcFRBA+bMox6jkwYu/3Svpb/OvqVyq2K/zZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFLrsPc49s5rWmsXBbDTw4dMzLcLhsiOnOHtd7DPd28=;
 b=Jn9IHcMr9U+lIxMbleZFX2ZoU/rMY/1vmCgGqYWlmMfz1LfUAUkmnsxJgfK6zW684MFFaMYRx/nfdtc23+tjvKKpAiMeqVbdYSb+21Tr9AuD+a5S+aFnpRDEDZqr/ZaOS8t+0f8MKQWKDbBPcx9TZYGEWgBdAzSlLd86ji33eSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 20:13:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 20:13:43 +0000
Message-ID: <e6a7c26c-be62-43f0-9f37-0ae9b87d958c@amd.com>
Date: Tue, 5 Sep 2023 15:13:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer APUs
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
References: <20230905192600.32449-1-mario.limonciello@amd.com>
 <20230905192600.32449-5-mario.limonciello@amd.com>
 <BL1PR12MB51442B9145F7143B49458E78F7E8A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL1PR12MB51442B9145F7143B49458E78F7E8A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0165.namprd02.prod.outlook.com
 (2603:10b6:5:332::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f2da94-bb33-4902-6f4e-08dbae4c9a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIhdCUvk9L4vrCcT0oWRDEew6nl5Y8UK09bfMwLtPrxo+21aVS8kyQKiTZri0eJIaNTb4jXC1mTf8QfpJuQ+O/gJ3qLlGRBbk1JAtASO7NaUq74/t4lU8Fg+9Ib5ZuF9OKDJ4LG/9x6RehyEhNZi1ClZoTacBUqCv8YHIDowc+V8RXJYtHzpjSZ/rTWbA/qv0efVS2eiVM8EX10OXrp4Aa1+cwdIhkLzN6V8tjrWHtGd3Qr9XFCOethZld/RGWXUM24QSg5zAFTqisLcx2jdvxdDbqlAC3wWrhKfwzpRt/3BdkSQyPMCyRs3y9CO8RJjX5sBw3mEhEQvMj6viU1b7UClSGDaYdSYAlG3gIww6wCPc2btOXlFtU/DNeVIRNHarXjLQn3S5YvzvFPd7/XmH/d2I8pcwKY2Ac+kqh4SvHkH6eQ2XluNBhgUwYlJfHALFZ0vJ36Fvi715+VmjD5iL7EFX//hSCjnuMAmRXWChJMa43vjtDMO24yfUVaOiYhziBOg+Eeny7uTebCWFhNEyu8BLjqAckgCJjGYWrgFuqtOjdzBcr5n2bxF9hfy55u3f5MBo3RN9yC6sSLxqWaVXhnXzGUPESyEwxAfRTYwnrGffewJaj+3mR06oHZKlmTck452ouTCrFZ8JYOiwu6E8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(5660300002)(26005)(53546011)(2616005)(44832011)(66946007)(66476007)(316002)(6512007)(6636002)(6506007)(110136005)(41300700001)(66556008)(8936002)(8676002)(31686004)(478600001)(6486002)(83380400001)(2906002)(31696002)(86362001)(36756003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hxV25IYWtQZ0pKY2R0aldMWWlXRE5HanMwNVBjYyt0U1FrMVFsWUdSTm8z?=
 =?utf-8?B?YjltUHVJdFNTaXRrTDFWVnQ1dmdXaTlhenFscXZSTUxWeEJMZGhKSU43UUJC?=
 =?utf-8?B?Nk9mUWpSbC9vTVNuMlVaSjJWRW9QOEQxZUxiNEk1Snc4ZmlZOEpuQkE2YU5S?=
 =?utf-8?B?aldNc2ZEUXdIamlVUnVCMnExR2VXZXNjcEpzaXlyZjY5NVY5QitNVEJ5aVZI?=
 =?utf-8?B?Q0J3ckVXUlpsSUlqUitPU2NYVnZMbit2TFVWdHJydHlKMDZiZ0I5TkxzM3N0?=
 =?utf-8?B?TTBPaWRDN3BtR2Z2K2d6azRCQzJUemhGZWV6WUZWUTg3QmpLL05wMEpBYTRV?=
 =?utf-8?B?WU52RGtWWFZlbTUxNUZUYUpmc0VYamlTYUNqVTkrbDVMMUNqNVFZRG4wWlNB?=
 =?utf-8?B?UVlUSkhlVFZzdEN6d2NiL1NxZzBWVW91cmdhRGRlNXVHUWRPQVRRT0QvT1Nl?=
 =?utf-8?B?WWJwYUdOdUd6ZHZPT0pMeUFUcnR0NXVPWHdVK2ZzMTl3RVhXZHNzWDgzZDFz?=
 =?utf-8?B?THVXWGFRcHJWOTBGUFpEM1dsTm56K1RZRUFHNGI0QlZQYmx1Rmw3N04ySDdk?=
 =?utf-8?B?UU1nNjRFam81TWxZWmI0TDlCTWpuS1F2Nm5TejVhMHIwUWtyT3ErdkdxOFUv?=
 =?utf-8?B?Q3BXRWN0alJxaHR4TzZUTHk5NmJWbnp0LzZCazJZaUVpWlduU1ZkWVdBUi96?=
 =?utf-8?B?STR5MUxWTnJEQjBGSzNVK0k3dlZVMTNpY05nUFZzVVBqdzZ2L1cyK2FYc0Y1?=
 =?utf-8?B?WjBMOVZIdGxEWXYreVRsUjIzWXk2dlhSNjBFSjQ1bzlPZkFER05Mb0dkY04w?=
 =?utf-8?B?bHp0NFdZQzEwYkFBTEhmR0ordUF0dDR1YnoyQ0VMc1A1V2dTR1NVWFdoUDJl?=
 =?utf-8?B?MWRnRUFVdVRsVGtobkU2L0plb1RDK29YSWZ2ajc5QTlGRHhhZzhNbGRqUnZN?=
 =?utf-8?B?aFN2R004RkxjU2xwQjFsQ1YyVGxJRkczdENQeWJSUHh6MkFSSmkvRTZaTWFX?=
 =?utf-8?B?Q1E3R2hNSlR0WUxHeHVUOHBrdDNHUnZPcFVtdmRVQzFyZVRwd1BUQURqclhN?=
 =?utf-8?B?NlZPaHk0TUNseUZHVjlaQzJydWdiYUxCbmVXOFIxVGhFQjhjZmpQMThjbGxS?=
 =?utf-8?B?SW5VWVZnYU1ucEhvbFhHQ3N3U1ZRVkNNcVlWWkJPNllSMDJaNll4OUNId3FC?=
 =?utf-8?B?VVo4QWpZdUFJTEFVSEhETCtKSHRzaU9WOW1kMUp3UmJjdllGbUpMd1MrdWl6?=
 =?utf-8?B?emkzWThyaFp3SHJZQzFCTlRWRTlRRGJUbUx6Y0YrMkExQTdaSkJxLzRWWE9R?=
 =?utf-8?B?Y2J2VGIxaXlvbDBrdkp0RlZUQTQ5MUVVbDExKzdtMXpUVnBKV0xzTXQvRk1X?=
 =?utf-8?B?dnN5cnRVNEZSeFVpOUo4WDRoT3NTRVNMbDBsNmhBYk5wLzV6ZnNQRGdLbUF2?=
 =?utf-8?B?VWdZRWdWL21SOXl4RGJwczB0UnRreWdYTENGQ0N1S0pKZ0dUQXZ5VFowb21K?=
 =?utf-8?B?eWxzZGtRWkJObDlXOW56VWowSGp0NGpxL0dmbFdmbGNZamxVVWllUU9KU0JW?=
 =?utf-8?B?WGVud3Y1VFNwejRQSGNWaEhrQjM3ZWlsbjRaUU81SWVmcEkvT3dQQ2VnVHJi?=
 =?utf-8?B?RGE3VHIyaDFJNVRTdDN6aitNbWtJZkx3SVVDczFPSnY0WUh4MGkrRlVwSmRM?=
 =?utf-8?B?T2owL3dOUEZBWjBGcGJ5QWJtcy9tS1gwUndUY3F5UUpVSTNmWXozNG92Y2Vi?=
 =?utf-8?B?bGVWbG5KaEVCVkthdlp3Vmp1RUp2SnVNVG1MZ2hUZXRHbnVOdmNUYWhPbFVq?=
 =?utf-8?B?dGNzT3JMRHVhOVFyMnJySHVNbEVIYnlhRUNUTzZqeHBNeXJUZmMySXIyTDhE?=
 =?utf-8?B?NEZhZ2E4U2FJZnoxSmFtTjNjejl2SkFobitYL3dFUmV3NDcrUjZmcEFiazhx?=
 =?utf-8?B?ell4RmVnZXVSTy9WRkxPRmgzRFNmRjJ0RnF4WFd4UFRCWUtRK2JtVWZwTitN?=
 =?utf-8?B?MHV5c0lpYnFHQWZUeUNKamgxOXVrYU9zWEVKb2d3L3hNQ01mVkQ3QXV1YVJs?=
 =?utf-8?B?Y29wdjhNaW1QckhDeWxycjdQYkpEajQvaGRtNVZZdE9ML1lESHJ6aVJEakxi?=
 =?utf-8?Q?qK7q7Urx3FIK5QzDbaK/STpZz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f2da94-bb33-4902-6f4e-08dbae4c9a8d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 20:13:43.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWZgSJ9wpxu2xPonFyYrvjEN0q3/hJHS1af+yQGW8MD9eRiynazw+SFkZZfwbQuLXQORI6JSQN4FG4h2IJk25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

On 9/5/2023 15:07, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
>> Limonciello
>> Sent: Tuesday, September 5, 2023 3:26 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Subject: [PATCH 4/4] drm/amd: Enable seamless boot by default on newer
>> APUs
>>
>> IP discovery is a good line in the sand to expand seamless boot to more ASICs.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 9159a7b993ab..19265dbe592e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1296,14 +1296,10 @@ bool amdgpu_seamless_boot_supported(struct
>> amdgpu_device *adev)
>>        if (adev->mman.keep_stolen_vga_memory)
>>                return false;
> 
> This probably needs to be revisited too.  I don't know why this is an issue.  This flag just means the kernel driver keeps the stolen VGA region as reserved rather than releasing it back into the pool of available memory.  I don't think it should directly affect this feature.
> 
>>
>> -     switch (adev->ip_versions[DCE_HWIP][0]) {
>> -     case IP_VERSION(3, 0, 1):
>> -             return true;
>> -     default:
>> -             break;
>> -     }
>> +     if (adev->asic_type != CHIP_IP_DISCOVERY)
>> +             return false;
> 
> Probably need input from the display team, but I think a number of the older chips we'd probably want this too.  Maybe base it on the DCE_HWIP version?  DCN 1.0.0 or newer?  Or maybe  DCN 3.0.0 or newer?
> 

I think it will only work on the older chips if the 
adev->mman.keep_stolen_vga_memory check can actually be dropped as some 
of the older chips explicitly set it to TRUE.

There are other non-obvious dependencies too like:
f0882d3afb9a ("drm/amd/display: prevent seamless boot on displays that 
don't have the preferred dig")
6349c73859cb ("drm/amd/display: For ODM seamless transition require AUTO 
mode")

So I was trying to be cautious in just enabling a few more things right 
now.  I think essentially this "only" enables for for Rembrandt, 
Raphael, Mendocino and Phoenix.  I tested it on Phoenix and Rembrandt.

But the module parameter is an escape hatch.  Let's see what display 
team says.

>>
>> -     return false;
>> +     return adev->flags & AMD_IS_APU;
>>   }
>>
>>   /*
>> --
>> 2.34.1
> 

