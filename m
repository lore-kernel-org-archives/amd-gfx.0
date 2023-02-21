Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641DC636D7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 13:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78F710E178;
	Tue, 21 Feb 2023 13:34:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E0510E178
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 13:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krwxfuX3jcoGk764g7j6mZB39u+bkVCEIrMmVC74HQ8+CYqadTzw9qPvHSxnViA1IVwqSYMpua20eRHk3kEXfPLV65WJ2AB13T7zinOMv5YRMw5kMVtqhL/+pgm7dQTOC6VG35dDLryEAWCeu/4+iTk8xeq+cTgG5wvlhcgUZjZdkkGVEujpKmMOVeFSxbGFqPpxuDvt2VTmplh6VOm8wKHB+sG/ze3CLB54/VUFxfzmGH9YLeDRNexoAAVyzM3yMQpFudUlNA0yFsYO5Om5YSdZ6RGK1KkKcrv3w3n2ugqYlCB1OxNzw3jEWooH5TxuZYsq+44/ZnJJ6beKkEgzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAlrPc5cAeAkXkzU6/sNl4edUQjKbS43WH+MXdjD++k=;
 b=k3r8RfDIB4vzwVoAPHD08JQ6N7SPAHuJfupdDdhRO4o/T9ig2ev6cnmpUQX/PKrCeK7GvYqkVvWy1/XqT75kQq2pxiyZ1kwK9NDfm5fPwa+yFx85rR8ElyG65XI2fDgjGIknQeF8QgPTvHzqHCqJUKLz8J7GokbtJy5ZDcqbSx2Dy7cMAFFa83c9P0fo3t6zay0weSv31OqKodHF1p5X1anut3maGeA1f/v0ezl2sVceocehxMMXPZhlaetEgqbZhIMsULJJIOCWKyEGZO64OJZTRqeDcAziJHAMMDgZgA8j510w+qn6/v4Dh4h68/WXtBUuTPZn7yFe5Ux2Z4WPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAlrPc5cAeAkXkzU6/sNl4edUQjKbS43WH+MXdjD++k=;
 b=mswZkz1hqfOjW8BlM10P8XLiNMheM8Ss1U7tpRxYSlKxYwqZPuQ9lQNpNyXJZoSd69rWmRkudXA2Z1jPASQ8qBorEuoTF3UMVngatTakAoFoSyQeMDv8+FYCgqwzHNjYxRiBWegJe+k/8xjbfEXwZWujXIUG0v4B01z+x2zSPUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5293.namprd12.prod.outlook.com (2603:10b6:5:390::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 13:34:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:34:48 +0000
Message-ID: <20120c9b-8f4f-dbd9-2bef-527b044f32da@amd.com>
Date: Tue, 21 Feb 2023 19:04:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-4-mario.limonciello@amd.com>
 <ebeab4bf-4394-0638-1ab5-697e1bc24a27@amd.com>
 <41674c0f-9c63-fc9e-9d3f-0b777924a7e1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <41674c0f-9c63-fc9e-9d3f-0b777924a7e1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 240abd9f-d8e7-4707-1c3d-08db1410668c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMJ6lbaXFjUGphdDeq0hrHC+i3e6kMNLcy4MiIIO/y72uAAPkjnX4Aj1VKNurcHHm3FDILYw4fRO4UjrgqEbIWUlYLzjSyV9uMfKTO1henpRAzH0AP0A9Et8dzkljPf1NirDc2ASMBK86TpPGAjLlo4/TVlwIaGz/cZY8VqbmjPLBM+nO27OuYg2YVfF0RCtdQk1cvzBfQkhrIOGwyEs3Fg25SgcKHoWKhnsfd/R8W5kTuqOG96Q+VsnFZ8t7N+kFt3kghJPPGoZV1p3XiCIwhG6IIlEpDL1cTnwONx7sJjtrSmGXBfODvcfms3eWsfBQWiAHJQj+o5OovNMUotOOr+8LNgxm4uNP8Ub17hZJvHPcsKWLPXhrSt8hcTaZU93tFjPrWjvupcR4+EtPi0VvvQRLFChEPnC5wlgvq1LzPfhkecA4dzLH7zUBY5+RJ4+rSevYaf/QRkJD+8ZPhtJoq7S7MERJYMI+MkX/R3wL2GmjwBpZqvfZ5oVeDia2A/emvnYscbAYNlTtZz0lIElwLVs5N4VRxJ6ABupXTV61TUSc/yFAz2pUpHZKyk+yQy7LlU3q8GCtEQSr8dFHKNLmHhzYI4OFEIejCWzw3plvbz7t8pcncl0ONHElSJJbLFFTYRHZND2S16gdSC3QTyD90SJVVH76yQoJa9cSwJ6bPZW4AlORd4TE00VCFjRKew4KaghtMmvqQ3U4LBQP2PizDg+7Q9qmv3F+bvPEAqKC9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199018)(8936002)(2616005)(5660300002)(66476007)(31696002)(66946007)(66556008)(4326008)(8676002)(36756003)(83380400001)(86362001)(316002)(478600001)(6486002)(41300700001)(26005)(186003)(6512007)(2906002)(38100700002)(31686004)(6506007)(53546011)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTQ3NnFxQ01pYkdIdkJlc1J4WlFjVGVzTlRUOHhyU2ZCQjAvaHJWRk1Dc0NS?=
 =?utf-8?B?QjBHQ1p1Q2NON20zcjRFVjl5YWphanZPVVN6V2N5bG92WFVpamQzL0pLWnYv?=
 =?utf-8?B?bGI1bTZsYXFXSzViVG1pSExwL09lYnNCSitlZTkrSDJFNGtkM1Rqc0tLTXNE?=
 =?utf-8?B?bDZIR2JhZ0JaQWhLUlJYSnFUZXFiUitlWnFrSEE5ZytnMlhCS0pRajZWbUZD?=
 =?utf-8?B?QmRJcy9Ha1FXL2dzdWtUcTBuUVo1NHpvTHE4Q0gxSEJ4Nm5SUkpHL2VpdEFX?=
 =?utf-8?B?K09YU0kxN2RsdXF6aTE4Y2FYSy9Tc3BEWWp2K0FtNFNhWHpGaFVCcDlCb0hl?=
 =?utf-8?B?SWN1cUNxc005OUtRRGZWQ3BnbU4yajlpZXEva2VKZDNOb28wQkdoaWZyNC9r?=
 =?utf-8?B?SlZtcndHcmRYaFVucXZxSDV6Wm82enlRcWhyUTdFTTk5RnViY3k5M3ZabVha?=
 =?utf-8?B?STlJb3Npd1hHWXhpNlN4V3lGL0twMXBiNTV3OS8zWXdYWVRoYWxKNDJuZzFu?=
 =?utf-8?B?TTJTZnBkSnQxY2ZuUS9xeFdmNEZJOWs0cmdaRkkySEpoaDZHWUlUM3QrNHBs?=
 =?utf-8?B?b1JseTAyaUZxUTladVU3akttMVNnT0xJSGJScUkzZngyeFFjc2J3Yi91anRI?=
 =?utf-8?B?OEtWcE12bERsNllNa3oxVDBvQVFLdkU5OXVjaWNoMHlEeGJIbDlONUJOd0tW?=
 =?utf-8?B?bzV0ZE54WEhmLzZMQWVHS1hsWWhoVEY2S2k3RWlYWktCZjNoa0xqSG90QnVl?=
 =?utf-8?B?QU1IMm9QbFY5QkN0bVlrQnFRTklEamkwQTYzNGhyTjVha3UwYW5tczdQMHVn?=
 =?utf-8?B?VVdmZFZ5SUZJbzAyRGlPeGd3bXM5bEsrencyYjZ5UHFDbWJTdnhNS0xRdS9v?=
 =?utf-8?B?R2JHUEdUck0rVE01MjFxSWpwdEcvVjl2d1Z5SC96RDJUZmpaanNlME5IOWhH?=
 =?utf-8?B?cG82U0NLRlFqZEFSZk9iajMzbEE4MUhRcVg5TUNaK3NtVTNicFZYdzZhQm1N?=
 =?utf-8?B?d1Z3YzFEblRKUkh2SmhWOE5CdncyZ1ZoVjJRdkRGK3NtUTFENzh0VDhmNGFa?=
 =?utf-8?B?b2dxY2c3eUVkbkhybmVaTmR1bVlrZ2FyUXRPZkMvc2RFeFZwZXdHbUVoZ1Zq?=
 =?utf-8?B?b1ZEcW4vWlk5Z1hQL1d4aCtBRmlFSEluQ1FKZG5rcVg4QVBRYy9uZ043NVI0?=
 =?utf-8?B?MlRxQlYzTEtTQnppMUUrYjZXRG9TREhtWW40Q3JuTyt1dnRLSThaaXdZQUpL?=
 =?utf-8?B?YVViSWYvUzdnK2VjeWp4NDI4dVd6Q3RWb1hQT1FuWFhHd1Z6WG9JS0NWZUZh?=
 =?utf-8?B?R0EyU1ZiUXhwVXV4SnpubVFKdkRHbVZDeXp4TENwcHJvK0xxVE5nMFRCMGp2?=
 =?utf-8?B?WlBXaVEzOE9GaFJyVnYyTHEyM2F6d21DSHI4aUJBNG9zN2h3dytTL0w0Mk5o?=
 =?utf-8?B?eWJRMFlqbHVzY0c3VzVkMTNxRmNvKzZSZy9TenJjNkdENm9TSjhIcjVwclo0?=
 =?utf-8?B?cDY5Y1pMUUFhOG9kRjZjQVZXSDlsTmhlRjNFT1hsT3BIakVRcXRDSDcvUHpn?=
 =?utf-8?B?cUhBbHhvZ0oyTXBoS2JNdDBQOTcvWFk0Y2JMVHlIelZkUjN4MXRkWGZRa3BT?=
 =?utf-8?B?ZUY3OVFkWXlteUNiSzVuZHZ0ZkR1SXM4Mm5xZjdtNFQrdmNXUi8rMjZwN0p2?=
 =?utf-8?B?cFJnSkduUy81WnN0ZmFMeEd5VHNUQkRnQjJvZFBHbUN6YlRxMVZrS201M25n?=
 =?utf-8?B?TTZrYkZFUHI5eEY0VjBYSk95QVg1a3JOWklaVlZuL00wZmRUWmpBMG9rMVFX?=
 =?utf-8?B?SVltZ2F6d3gvQm42ZjhNY1FGbXlNeTBCblpWUFVzTEU3TE5uWEVYSTNQU1Jk?=
 =?utf-8?B?Zk41M21vTXA3TU9HcU56a2lYWDduSGJkQVMya0F5RmtTTjZHRjJTY1U1NzQ2?=
 =?utf-8?B?N1dlcjVCZnVlalA1THBHb2ZpS1NXNGFCODlHRjRhWnNXemE0cGY1WmVMRjRX?=
 =?utf-8?B?Yk1BS2docDdBa2JzVE5TS2EvNTkyelBBb29ZT0R4c28yWTdlV3FjY1lIWDd1?=
 =?utf-8?B?NlZtWUtYRXhFemtKY1hZMS9jczVqRFNSR0RCSGJ3QTZhdmNHQURZcjlYYnJt?=
 =?utf-8?Q?HLuFTl7Wisj4yk35EmVPsqKHw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240abd9f-d8e7-4707-1c3d-08db1410668c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:34:47.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYnfy8diAfpTTUI1u27rH0+Uaxd+vKRudDBVTkwWRGCwZerrsnOhjpTRjsCU3yOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5293
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/21/2023 6:57 PM, Mario Limonciello wrote:
> On 2/21/23 07:25, Lazar, Lijo wrote:
>>
>>
>> On 2/21/2023 1:46 AM, Mario Limonciello wrote:
>>> dGPUs that will be using BACO or BOCO shouldn't be put into S3
>>> when the system is being put into s2idle.
>>>
>>> Cc: Peter Kopec <pekopec@redhat.com>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> index 25e902077caf..5c69116bc883 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> @@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
>>>    */
>>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>>   {
>>> -    return !(adev->flags & AMD_IS_APU) ||
>>> -        (pm_suspend_target_state == PM_SUSPEND_MEM);
>>> +    if (pm_suspend_target_state == PM_SUSPEND_MEM)
>>> +        return true;
>>> +    if (adev->flags & AMD_IS_APU)
>>> +        return false;
>>
>> What is the expected path of APUs which don't support S2idle?
> 
> They should staying powered on and not running any suspend code.
> Since they don't support BACO or BOCO I expect the call to enter 
> autosuspend to be a no-op for them.
> 
> This was shown to improve power consumption for such cases (a reporter 
> actually measured it).
To clarify on this - someone tried s2idle on an APU which doesn't 
support it (no FW S0ix support/PMC driver support) and the power 
consumption is better for the APU. Is it because the peripherals went 
idle now, but in earlier path APU prevented S2idle entry altogether?

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>> +    return !amdgpu_device_supports_baco(&adev->ddev) &&
>>> +        !amdgpu_device_supports_boco(&adev->ddev);
>>> +
>>>   }
>>>   /**
> 
