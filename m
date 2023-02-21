Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23D6C636D7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 14:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F6610E0AB;
	Tue, 21 Feb 2023 14:30:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DEC10E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 14:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp0Eo3a7gQOAdlZCKfx5+uK+MEIWVDikuzNoYm3R/A2CO+LwJjk7WtjvtPQ6tfn4Ab1FNHxBTmXB6+kroBLNsc4PG4kHIB6Yn2skMf74UOjK3bkb3CHbJ7QcwCKQ7XxaPDP1KorCcHlocITTAoPMKj59jAZVEQdYSKve5iAcu4Y3ulMHZRPP/nswIjzM7WDzIcRMhp045DGTobwjiJyBssPInbgMpm3q79aSa7pT84VjyhMgZI3QaTbmdYJ9pqI55prBoA3PMfyJmbmjsjo8L1e80UDT9rdvhwA9brX6Pj7/uvFiVnCVpIVVYGlaS/wwa9nKZMkgi9RTcyPqQWlc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCVMVvoseKDnVz9qZ8PC3xFA1fksCjNJ6NRQCd/71pk=;
 b=ZhW87bE6x178SLKviZJbGJPaqVkU2m0rSTYHpu7LqMBFphKa5rjJzfi03mPtJC3bQNmcM75rwiW+cL+Z05gxnOorxk8EUyWjXvTVsRS7Z4L2a1Q8HLMkAqpSOo7fp0DMx3RfKZv+498oyfQ+6M3aClQVPqUYuf2SolFbqJ6birquTVpMdBDeKi19jnyAGe8mSPjKRYKfSxnc/bE/xnLslvRyThkiaQIO2dgmWvmFJ4cBdh6aGvnrZBy95hdslLaDyf8a7sgouJNCplzGm53tDcCQXh0+JBBr2Zek9hnB0RfmKoaiSNHx1XDM98DJinN3JekMO2erKx9BMiT88H0IbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCVMVvoseKDnVz9qZ8PC3xFA1fksCjNJ6NRQCd/71pk=;
 b=xZhu55Dk5hJygcWv3fE+th+ABOjVlsaMF8zf/zLHGO/9aqImd+7x8qo6oscrrOBRczeF2hrAfycw0Rb5hPnfBSFI/FQHenKyVaMMU2ELjVJxyyP+shIROEO1rBUuJAMnfzyELfJdGWTwwqqY+CtdvZZbxE7ZpuztpkKuk9JmdbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 14:30:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 14:30:46 +0000
Message-ID: <8a3ba569-6544-b0a6-aa2c-aac74ee7d850@amd.com>
Date: Tue, 21 Feb 2023 08:30:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-4-mario.limonciello@amd.com>
 <ebeab4bf-4394-0638-1ab5-697e1bc24a27@amd.com>
 <41674c0f-9c63-fc9e-9d3f-0b777924a7e1@amd.com>
 <20120c9b-8f4f-dbd9-2bef-527b044f32da@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20120c9b-8f4f-dbd9-2bef-527b044f32da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:610:4f::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d4a5d2-bf00-411d-128a-08db1418386b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuqYQ1lWFbq5eD8Ytnz/oCU+mFUq3H49X0p+uvUqeRbRZKcEt+8eKSvtoySAkIzulLSIMi1hdGzPK2WVsxSu4jqRFQkdP59ZEIOLa6VmK4bLNAI5vsKhuiphpDUg469ult6C4qP6JRQxDahwfOTM2aK0sYLxEQ3zsHGtFWh2uFC+3+BQNZFhAnlIgsWGeyTz7Kg4KCRkK77VVgaTpRjM2QaXY7RiFAbjXixm4x958a2guOWWpE4OnJVmqAP7LQBQ/EzGfro3OiOII4vRdjik3F2kpwWm2Fh2u8BHqvwH6+TFCD4lE42oAujvDRgbPawBYIT1VyNkK6yboKRMM2WRyUCS/qmF/t2yR/t6VpQqtyAHAwBiugS8x/nizFIsRGvOeTelYkcvzPCFYL26qUunMkzBUPeUnYIRMEfKUpjV8TZnx0CNMlB2lEn+0hq3WPFyHH5e5XzvPK8lemhvFt/cqSqkQc9BXzO9BSu5yG94hG80KmdUG+Pijszk+ZBu8j1yT/5L1nuRVTk9/dgFhCOO6/I1IBQxR94ywA3SUlagoyjz28O4Oh50LeZovmwSOxtsz6pu+Oyhhfbk7jD4jrOsLGhgK3lZwdSNwZwZYvkb7ngJlN6ztaJVxr/U0hRZ1ERAKY0n7yyNMsSwk59xGa55tI1uAJADohSI5ahg0ZfIDaoinerjABYrF6uqCTAKIgXY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2906002)(8936002)(41300700001)(5660300002)(53546011)(6512007)(186003)(6506007)(2616005)(4326008)(316002)(8676002)(66556008)(966005)(6486002)(66476007)(478600001)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dzb3pNcmFNYlhMRFZ2KzM1RjFRTFJpcFdSbmUxZkxHTXBDUzhjek4vUHlL?=
 =?utf-8?B?Y3pva2ttSndBYzVMOEw0RnVFV090SlR4SnZUVFA0SkxINkVqY1lRbVBBN0pv?=
 =?utf-8?B?M0twMG1UTlB1dU5tMXhNektHTkpPRkV3bnNVaHNOVTRncVlpTUpLYnFiM2U2?=
 =?utf-8?B?UW1MS1k2YkowL1FldXpUcWpkQ2pYUWtJTk9GaHRoWGRROVEvOG9kMnJFWm5s?=
 =?utf-8?B?Ris5UDI4TEpwVkFtNXBPTmI4K0JFWDlSNUZoZ1BFeDloOUxIMXdzZ29GbVMy?=
 =?utf-8?B?a2h2ZHhhT0lIVEN5N0xFYlpNRWdOMGlreStvOVQyODdXOHozN29FaWVIbFAr?=
 =?utf-8?B?UjE5TVNhanBUSUJyUVlYWllONVNYMUdhZzhXMitiOGxHRVE2UDQxODlhMWpp?=
 =?utf-8?B?VlQ0QktSanV1SDlLeDFySnNYcit2L05zcG1WYVArVmVtQjBkQ1BkTVh3aUE0?=
 =?utf-8?B?SzBlWXdqSlZwSFNOSHA3M1B6bWoxUGpWSnBmMk8zRUxRT1B1SmFvTG9tTmw3?=
 =?utf-8?B?UVRtZFlaTzhhZU4wc1JJRnhxRlQvSGVNcFBCTFVjWWhOQjFobVZCS1hOdk03?=
 =?utf-8?B?RjZlenBvb3gxSkFyZzlIVG43cGl0M21GQytqZnNxV0dkS0lPVmd0UTgwd2hz?=
 =?utf-8?B?SENrdE1peVNsODJGd0NHaDIvUnpZVWs5T210MWlwUTBrSzZEN1RLTW83Q2dF?=
 =?utf-8?B?dXRZVkFXVjJicloyUi94RkthYWdNRitUbHhlT0tLN0hmSVlWaldyL0ZyRTBh?=
 =?utf-8?B?bFdiVjNrbnZOQVBFaXZCR1YxYVRudjdtZkVsY3pBeDRsQ3MzclVJUlJsV2lh?=
 =?utf-8?B?TU9FRW9DSWErQThBL0pSejhGSHZhd0xpclAybUJSVVovMWlDZ2tEOURjR011?=
 =?utf-8?B?TlI2WDFUS0pKNmFTVVNyRWZjTGpVY21pQk1YQTRiaTBabFN1TjQrRUpqNXBI?=
 =?utf-8?B?NittR3FPVERJQmtwL2JMUGxWZUxWMGpidlNSQ2UyN3V5bHlVMVB3dFZSaWVN?=
 =?utf-8?B?ZmtKZ3QvdVVaVzlNZzhXdmx3L3N0YmJjcmwwZjQyMFRLQ0RmbGdXWnFUMC96?=
 =?utf-8?B?U201SW9EMVBNNGc1c3hyYnNIblAwNzQ4Mjc1YVR5T1I5YVpOdTdhWHlnU0Vh?=
 =?utf-8?B?MklwWFNpZWdVYkdkS09jOGhHMllSdXMrVzdzUXU0dGRXMHhXZncyR1U2Q3Mx?=
 =?utf-8?B?RkhsKzBuSXVOQ0h3WGFSMEE2V2l0b25YbXNhSDVab3NZVGVIVlY2akg1b28z?=
 =?utf-8?B?dHBoT0VaZUpyNmEyeEdqbVV5TzIxWGlldWNnZVdEdi9jUU0xWjgyV1RvaUNo?=
 =?utf-8?B?aXV2ZlVFMlRramUzejNsMk1oazZjc2kxVTNBUEN3aVc5MVo3cXh3Nmw5dG1v?=
 =?utf-8?B?Q3dobXZ0RDlIQ29hYnZBdUlmekJHTk9ENzFhNmV1NkwvWlRjTkc0OEljRUxR?=
 =?utf-8?B?dDlQK3FHMTVTSUFob0NSR2hhM3JvdU5QaURzNlNKR3BNbnRnL1M2bjByUmVu?=
 =?utf-8?B?QzB5aHhsYlB5Wm1WbVpQSEl3ZkhMOTlLNTJpQzhHYmkrcVNpZmpBSVRpQ1Np?=
 =?utf-8?B?cHhBV2svQXFNaTlVUi9MT1RIVDU1cW1zUC9SSEk2d2dyRzY3RWJ4MWJJeWJv?=
 =?utf-8?B?Mi93eUxRTkhGRGVlZGlsa2g1UEI5Y1MyRUtrc2xIUmdDbERjTVFkWHZaZWlk?=
 =?utf-8?B?MmRuKzErRUZjN3Q5cDJocDVmU0FFQmJ3VkFrT1JtVkdPd01NWTQ3aHpKa0ZY?=
 =?utf-8?B?cWcydmxOclUzYmhic3hhMzMzamdJMXFEc1JmTk1HY3FwcTRhY21iRml1bGZV?=
 =?utf-8?B?OUczS1dyV0RoaFpER0tpUUJHbXRNUGZkL1lXTzVCOCtkVzFSdGxSaHBITVlu?=
 =?utf-8?B?cUVtNTNUZW9JWEhJS21CTkgreXpQL0dZWnZUL1I1TmpiLzVoUEViU3Z3WnQz?=
 =?utf-8?B?TklUTkJiTlIxVUh6Z1R6UmY5eC90ZzBzSjgyYmZ1bE1qcGlHd3RORzhoc2pU?=
 =?utf-8?B?MktpRlNMTjk1SXdkT1lFSGRRZVBXRjFTckg1NUt3TFdaeVZqNFRyRVR6TTVm?=
 =?utf-8?B?WCs0em1LckJPVDlTL0FaQlFTbjhoVmg0RlQ2eUdJRUxxV043MDVMMVVjMno0?=
 =?utf-8?B?a2hyeFlOcUVIVVJ3Nm1XaGI4Z1JLVkVjOXJHYkVCc2poZG5DaHUvRHQ1d1kv?=
 =?utf-8?Q?A2Z8to4bLRKiW+AeTYJ6Acj9PmXPQRyoyb2s+Jx79BJO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d4a5d2-bf00-411d-128a-08db1418386b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:30:46.2931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq3S1eDMcMubK0oUujwq790Klr8z8apuEXc0QfAvw3ny+bfymOKu2DJgRAu2iyIYlYgECNhp2ABrUBS3uIqu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5401
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

On 2/21/2023 07:34, Lazar, Lijo wrote:
> 
> 
> On 2/21/2023 6:57 PM, Mario Limonciello wrote:
>> On 2/21/23 07:25, Lazar, Lijo wrote:
>>>
>>>
>>> On 2/21/2023 1:46 AM, Mario Limonciello wrote:
>>>> dGPUs that will be using BACO or BOCO shouldn't be put into S3
>>>> when the system is being put into s2idle.
>>>>
>>>> Cc: Peter Kopec <pekopec@redhat.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> index 25e902077caf..5c69116bc883 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>>> @@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
>>>>    */
>>>>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>>>   {
>>>> -    return !(adev->flags & AMD_IS_APU) ||
>>>> -        (pm_suspend_target_state == PM_SUSPEND_MEM);
>>>> +    if (pm_suspend_target_state == PM_SUSPEND_MEM)
>>>> +        return true;
>>>> +    if (adev->flags & AMD_IS_APU)
>>>> +        return false;
>>>
>>> What is the expected path of APUs which don't support S2idle?
>>
>> They should staying powered on and not running any suspend code.
>> Since they don't support BACO or BOCO I expect the call to enter 
>> autosuspend to be a no-op for them.
>>
>> This was shown to improve power consumption for such cases (a reporter 
>> actually measured it).
> To clarify on this - someone tried s2idle on an APU which doesn't 
> support it (no FW S0ix support/PMC driver support) and the power 
> consumption is better for the APU. Is it because the peripherals went 
> idle now, but in earlier path APU prevented S2idle entry altogether?
> 

I double checked and realize I misspoke - it's not that they don't run 
any suspend code, but they handle the s0ix flow even even without 
underlying hardware support.

https://gitlab.freedesktop.org/agd5f/linux/-/commit/9cdb69924f545fdc3086bc8b085dad8146057141

So the path for them doesn't change in this series.

> Thanks,
> Lijo
> 
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +    return !amdgpu_device_supports_baco(&adev->ddev) &&
>>>> +        !amdgpu_device_supports_boco(&adev->ddev);
>>>> +
>>>>   }
>>>>   /**
>>

