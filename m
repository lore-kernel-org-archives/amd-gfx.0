Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A9CC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D57B10E2D5;
	Mon, 31 Aug 2026 15:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWfu9GLj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B9010E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdqu/c5M8YCFfRKKO3joV3GJlnNDcl8UE8/eysZF/lCyeGmbyqlNDpG6+0HDwdo3n2gaj2UZvX9Sq5A7/08uRTnAK/ubx2liqA3ssol4EMewxOlsnxvz2XYb6waZQYnUP+4ujyT2t1faqkQLsRaCxR5Oeeu+UEAHM2rUXt0QvgLFnoGaOJE79fXBQszHUl8KST7wCViLoN0sCmyibbnJ1yBZRU1hlHeVB4wpa2t/dqj8TiSBkgEap8KOvwjTxeID9iMbkwAoRQf2jr0TY2hOBtqyAeCNsIof3qeodsonvIr2U1ulRsi9TVe8Pkwop2XaMaVYMRAwpXNP46wHGg3Dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duZEHRcG/OsH2j3sNvYkbUtBLkph44I6k6DgFW1AAMc=;
 b=liLtzsi0QPon4RW0vFXdo0IUUgNA3u7Jf8vM7UERRWpFZ/Cm3g5wlRFsKoPKTewDEk7cr4CILflmMStiKpaNZ12Ki4xAfxiZ0m4ZABTGhXnLJV5hcW5oWWMroE1qLmBjF41v5GKZ5l228DvSOIp6jAcc5dr4LOfMIo6k1Ueuv9K9tqiWyRz0T1AZDGMTZ9bLS50JfYjA0Qb6Rmkvwj1ZwGuuldoyrHwTxEQDLBJLnP8CuIgobHntq2gU8z1nMKz58ZBF35Dn67xMqUASF4I819T3zJtjMieWG63ie0uZCiTgiHD4gZhSgs27xjoeXEtYAD081nRHRCehtecveJFZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duZEHRcG/OsH2j3sNvYkbUtBLkph44I6k6DgFW1AAMc=;
 b=WWfu9GLjFShzOQZnB6wzrIGUwnayy805mVj4D6xn60g3tDnPO/iISIh8+PSg8S2mPLT1+uWCJF6pK8tKmj+d+cPTwA/0l5hO7z+DwgYHGixFao/WwCvVXA/u/+pbXj4nVbkwZss0ZaBDwFJfYNJUdgHxcO1C4ZmosxqLJ+pJrTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:09:10 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:09:08 +0000
Message-ID: <9b43b1a0-0184-4a05-be45-98d4a83eb302@amd.com>
Date: Mon, 31 Aug 2026 20:39:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix byte/dword unit mismatch in coredump
 IB dump
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prosyak Vitaly <Vitaly.Prosyak@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827163746.1085495-1-sunil.khatri@amd.com>
 <05f31596-69b2-498e-99b2-32c086698660@amd.com>
Content-Language: en-US
In-Reply-To: <05f31596-69b2-498e-99b2-32c086698660@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: b987b468-11ff-41e9-a7ef-08df0771ce16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DYpNmx4nthJXg8sCc4/4jLrGdL+zL8jHEKrouexfaWwmFtisIHIZ9lPWO3R0ZbdL/Ak5qlgrqasf69WyQZLJYag0539X28Gv2zsXN/pGp3IFI7xa4ZoqTYLv/29XLJ5EbxaTOpwAlgptyVENdBBRXsAEZjz1CK7G4P8/ijDFKEQxP5vaORfQ1b7Jg82tkxTBIwCI1ITDdzf0prtlQNu78mErHzSmFJaJMMC5imUcHMGc4lIcb43pYiaQYUun8C5Ag+qm5IssesEJKLxRC8r9JGXZvsQR7pt+iVFwJui7A/WMKgOQifMapakSOwWHLu7TgpE5U406POgpjW7N7XLhHL23eKm1Mz5oZOEtEiiEYCMdPp1P23MBo+0TrfsRgSA0KEG6Mcon8cpIOOvotyf+vVQyE+LTGKj8caZS8raDVYyfCD+KPNCN7iWfpkqIVZsoBmzypspzyLqWWbNtULtGilZ/OHtx9O1H91yHxxCSPvS6FeJliU8TpW3ksFB95OpcWRZYRCzzqu0HydWoiDBq1bIzGl11VbQB827mC/yougJWE9keVeYSoxL3rTucW/JbDYs5rq+GaHi8hdfkxGE4EaxSyJeNR/FN0FBPsw1okU0W4esZv+K0uUYt24UjsczysbqrMBUI5migsfX7B/W7HuBs5WNMxtitQg+J3TMZmJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTc2NlY5VHJzNGhjWVlDdi91NHdKc3BiVXp1d0p4UUlEVWZUcjNmSDFveW5V?=
 =?utf-8?B?SGlqLzVrZ0xGS0JrVVVRK2R1cTJ3SlUvbXNxclhHUTRpZEJIMGhlTmtOZ2V3?=
 =?utf-8?B?eXBwRTVxZXNLNDJnUVB6Nk5ybTk3V2FjVkNGSGNLSVVja3ZFeDBDTmdlWFdZ?=
 =?utf-8?B?ZzFkdHpSMVl5VWlxVUhBbnhSQWxpTk5NaUw5ZGdzSUg1ZWgweGFTeEk1L3lJ?=
 =?utf-8?B?UHZaNnVMWFh5NlV0NzFNR2ozbDZBRE9mZzhBWEVOWHJ5WkpwcGdBTWhwaXRs?=
 =?utf-8?B?cUxpMHpyUG9xcVA2ejR4MlJMR1BULytZYUtjRWM1UGhCaFduRDQzaHVCTzk4?=
 =?utf-8?B?dlYzSENlMTFHaGpMR3VrS1RvanZNUkRydHdqcmhPTFRNSGdNSHV6MHNjcE0r?=
 =?utf-8?B?cDVyeEFtekZtQVpZbkQwYmN3UzhSQUMyQVdxcGk1SVBRejQ4bjJMVUpUUFlU?=
 =?utf-8?B?eGI4V1JtYlQ1bTVyN1R0SUJRZ2xINmdEUDVoU2YwV1NkWmRhS2RYTXJGdkVr?=
 =?utf-8?B?eE5aVlZ6U0JUVUE1V3RSZWRrelQ0cVEyaEFMekxSNmI1QlptcDBGQXdxTEtu?=
 =?utf-8?B?UlMzZWt5T0FwL2hzVjEybW5SQ1g0UzRMTlcrSTlZMk1ZdkdiYmZZTVNEV1Y2?=
 =?utf-8?B?eUFxS283ZGZGN1BueVBGbjRrT1FYOHpwK1E3bUtlTE5wVHVrSEpKZWxldEtZ?=
 =?utf-8?B?L1NnckpwVmFzUW9UWFllY1pPZm84aWJWaEFOMUVPbm1hUyszZVA3YTR3Tldn?=
 =?utf-8?B?MHN2U01MTFJXZE4yeHQ1RzVKYTd0Q2M3RjNVK1NzTUZhUlJpSDd2QnRXSTBh?=
 =?utf-8?B?NTlxZ2xCMkd4b0xlK1F5S1pHelhpN0crUEpQY2NpUWpqVHJJK2VGNnhNbFRK?=
 =?utf-8?B?dllyVkpjcXpjZ0hLMXJJd2RGZEFIVmoxbjVtdERYU21ieGRLL3lUTFoxam1R?=
 =?utf-8?B?SjVGWmNWNE9PTzFsZWNnSDJySUIveUZEY3BNZmZTSm5WQURkLzc2ejJucml5?=
 =?utf-8?B?dGxqTEg1RmhKV0xFcUpqdlVBWVpQZThkMTJkOTJETjF4bVplWlZhS2JVYkov?=
 =?utf-8?B?L1RXNUthSU5kY2FzNGxVTkZ1VUFYNHllbXhma2FMV2NOUmduWXJqYXVDMXJ2?=
 =?utf-8?B?Qm1sMllaLzFKUXRRYTBzN2lvRC8wdVJ0NXJjV1h1eUpUeHpTc0NsR01la3hY?=
 =?utf-8?B?WWcrWVJlY2syYmVjbFBoN1pUbkZ3Qzk2V3Q5WjJlV0VIbDhVQVpycTVxb0M5?=
 =?utf-8?B?UlEyTis0SDB1Y0tLQXpwWXVJOHR2bVB3UEFWV2Z0TG5tT2FvOHRubkZHT1V1?=
 =?utf-8?B?NUROVGhOZnVhS1poYWtuSGxaTEJVd3lsalZjY1R2Um13cWRRY3RLdENjemlW?=
 =?utf-8?B?YkUzQW5FRUZhTjIyNG94cEtxRTMzVElxVGkxQllRMHFOcHF4QnNpNlNybjJN?=
 =?utf-8?B?by9EZzFUODE2dFBXOXNZUVh3d2dqN21BL3IwTDJqdnZZbjluNldPd3dHem1L?=
 =?utf-8?B?d0RlU3craVN0d0JJMTJOSnkzNWRURzRMb0FmZjNDWStiaERCSkhRUkpOV0N6?=
 =?utf-8?B?Sk40SnVDNHI1RldJWmpRajdrd1Fkby9ZaFlYc1pWRkJ3SlZkbGMraVYrVHk3?=
 =?utf-8?B?MUZSSlc0dTgxQ2R6TExjclBwUkx6dHhKSkpvRi9vQlNyUlV6YjVZdTZobmln?=
 =?utf-8?B?OGRwSnZkME16WW5obVE1ZHpWc1Q1d0VVcXNYRUk1RkpUSzhKb2Y1K3I0SDBS?=
 =?utf-8?B?NXlkNDc5SlFMcnMwWmtPSGx0U3BMNkRqbklmRnRjNkM4a1VubGdBMEEvK2or?=
 =?utf-8?B?WnVjOXNIdlFwSjJoVEl5VlpwcExiQXU2aTZqOE9wZzI1UDlmYnliaDVxZ0RR?=
 =?utf-8?B?L1NHczRkbERJVTlBdXNIbXFzWE9QUjMzZEVRaUdIUXlMd05wOHdhZ05uaTkv?=
 =?utf-8?B?UUZGL0l1dGFRdmJFVkUrSDAvRG00SWVqZFg4dEZ0V09hdSt1bFdqUnIwcXl3?=
 =?utf-8?B?NWV3bTg5S2NHSTVEdW9TU0MxNDRXNm5RdnkrOHZKVEdUZGdMNGZCSEdxWEZq?=
 =?utf-8?B?VkFOYXBoNlo1SUhjYndycG1aUXZZM3dVU3IreFpZK2d2RGdoNkF0cFVsMk9x?=
 =?utf-8?B?MHpPYnhUY2dWWFBWMzZtdmYyUjU0RkdpZVNZOEF5TDlKczZxWWM1anE5Vk12?=
 =?utf-8?B?andnMVpEQlNHMXZ3bTdnN2MvYzl5VWEwTlpvOS9NNEFPU1FmaHJTOXpHaHdu?=
 =?utf-8?B?Y29FVzJGdE4yd1VTSExTelZxMWwxZzcxR2hLNGsyRmRZVVErQXRYTWU2eWZ2?=
 =?utf-8?B?Nk9PR2x5bWU0ZTMyV3ZYQm5BWVVpcGZhSEtSeTZ5OGU1Y0xwQllUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b987b468-11ff-41e9-a7ef-08df0771ce16
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:09:08.5059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaFg145Alph4FwZYd4r4UFkDQgeIEh6JZPwmGI6nFl23hDFkoJbhKSb2UZ573blNyhcmPX5WVtlJSF1Eg+M3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

Ping for review please.

On 28-08-2026 01:55 pm, Khatri, Sunil wrote:
> + pierre-eric
>
> On 27-08-2026 10:07 pm, Sunil Khatri wrote:
>> In amdgpu_devcoredump_print_ibs(), the NO_CPU_ACCESS VRAM path passed
>> cursor.start/4 and cursor.size/4 to amdgpu_device_mm_access(), but that
>> function's pos/size parameters are byte offsets/lengths (confirmed by
>> amdgpu_ttm_vram_mm_access() and leading to wrong size calculation.
>>
>> Similarly with that change the off index needs to be calculated
>> based on dword since that is a u32 type.
>>
>> Fixes: 7b15fc2d1f1a ("drm/amdgpu: dump job ibs in the devcoredump")
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index 76771ad30c41..2d3fb87af00a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -297,10 +297,10 @@ amdgpu_devcoredump_print_ibs(struct drm_printer 
>> *p,
>>               amdgpu_res_first(abo->tbo.resource, offset,
>>                        coredump->ibs[i].ib_size_dw * 4, &cursor);
>>               while (cursor.remaining) {
>> -                amdgpu_device_mm_access(adev, cursor.start / 4,
>> -                            &ib_content[off], cursor.size / 4,
>> +                amdgpu_device_mm_access(adev, cursor.start,
>> +                            &ib_content[off], cursor.size,
>>                               false);
>> -                off += cursor.size;
>> +                off += cursor.size / 4;
>>                   amdgpu_res_next(&cursor, cursor.size);
>>               }
>>               emit_content = true;
