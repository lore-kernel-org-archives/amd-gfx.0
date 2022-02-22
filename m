Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56530C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 16:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69D610E32D;
	Tue, 22 Feb 2022 16:04:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F1110E304
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 16:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYWAc1OB+E9YGG5lskvrErLSrLDfhTxCHKiDnCc3tFvGNb27QNiQwJEs4XN4v+Ggk7m/xgiaDJdedpR1RTICvF/3JPn6VumMoeVbK+QOAxvcm45iG15yZyNq9pj0vuTRItMO/K6WfrkAcLZ5HTlgB3DHreMP20e9UneKroDL9T5dUzwG49mah0eaDjVfSenhlVfRGcHNZtCGkKkfzzKKQWY98zE9XXX2UOmZbP1kkbCBEOwA3RdTVtrhHpsqWrbqcB5OrQN7VhGfnuobmpH0vlhSofXCPdHN9AA6tSUcvSEJJ0qbFGJdbR6pN734FzNYp1cAXlwCSBPdStMf5VYNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+rOeD9/9vBa6Grc8+NkDDKuMbujqj+65kUU/o4N0tg=;
 b=kpVJdqBZUO05PyYaiqPcRBSteuuNyk9hCeaN9RSCNxvcf5/isKo6F6pIAUgNfDeY+W+G85s/HevYl5p/nJZlcSEhqLg3zwpWpfXUKdH5XDNgnlMAkkXgn12XcL0FLqNIZizudq2wtnYDN2gy8Ir8N/nozgZ9CtTkd87LE3lSR38qE/zBdO4EWLWFXa4+A5baSNx9VtD0gLg5fVS9uhDPu3Sj41bs+jfsPpcGrl++4/AivIBouDk2gztOnzZnLcv4rNZmKsDFiEbdv6PXoJNl89nMECfeCyAXbs+eCOUOOhsI7SzybUD2Cjai/GNNMff+vg81doym56FhMnvgPrIhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+rOeD9/9vBa6Grc8+NkDDKuMbujqj+65kUU/o4N0tg=;
 b=RIcY7D9d81/A7obYh1vzCwPFMYx1kKbQFIb6+x88cFM9iLT33D8XT67iGnBFMb0ekpp8WA5A33SvKvZTW7pQVWh8V9OQxzw2jhKHx/0aXkYGftjSBrSad1Xu//YOa+j5hdmH9Lfy2y54ro3Htz4ieyZXqOFuvjDnYVHYIn9fjcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB2807.namprd12.prod.outlook.com (2603:10b6:a03:6d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 16:04:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 16:04:05 +0000
Message-ID: <05f77968-af09-3017-6b8e-8a89e5cc4f6e@amd.com>
Date: Tue, 22 Feb 2022 11:04:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: make CRAT table missing message informational
 only
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220218204248.830299-1-alexander.deucher@amd.com>
 <90dd45cd-9cf4-d79f-dc32-76169fe10ee7@molgen.mpg.de>
 <CADnq5_OewXLcg-xD2Dzet_4uCVKoFVzA6ZqXegnQK+aNu_-LgQ@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_OewXLcg-xD2Dzet_4uCVKoFVzA6ZqXegnQK+aNu_-LgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc5f93bb-52d5-4c7a-83e2-08d9f61cf3a9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2807:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28070FE4B10228A677A21CA5923B9@BYAPR12MB2807.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaIcZWrbCJ6zKAVI+KDjO22kh97SUZxSx0d7MTFrfQdjpODd+1Of6NEVU2lTmZVxq0HJO09xgPD+8+sYMFgnsE6K0Bl3VCBy0PRhIQnMVeuG0pYFNnXolYPOgpRSEhDgBQBthiJn1e0CWim+hd5ZBtB8fROyc58nHkILrj1yrfagbpuASh5qE1H2FmTEHdjyxw3XQJizSxhAbUZaT9QZ70urGfNfTrfXOJjDDcEYHbS6bibKsBLaNPNBFIWq8c5pwymasUZjY1Y5H87Cmt624n5G2C/7F9k1lv9ASvoEHKOUopcD572FF6T0MgTMvjtoJLjwo6PoGF6fsSv0y3CSwWdkCYdh0XAztxRxX/7E4c27ToSFdbTpxY6i/29zXrtrbuXTkybuELVfh0qtcM9xcXrzv/1ZL7Jb8jxwkwjSJOmb9m6hPznTrK3aoYVyhYiOLqD1My4l+wxXo4JIbiozvVGmBWRu4M3flaiPG62VV0ygui0MxMUT1f7amVRTWJzMzI20PG1X0DlPoWjqDIQrILxlJ75Z/TXOJouULk0qUM5U6CDW20xE8FwpgwAj9kzS7qOOR7UiBtuZPxZEo18/qhRKDTUwclXvgO/oowHoRd1qfT8QnqLZgYO9TFp+noX3NvG69NhVcW/DeHLWBPpUcw8VriIGLzgE2NKn5oAmC54xMLdv/nyWNhPj2FdjNCGz5t2BcBgZVBWVpp76hHDiZ3B4vthZ+9cGXHJFaMXPmKsuwdKVCqYiRg0zpTvIKbL4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(316002)(2616005)(5660300002)(86362001)(31696002)(54906003)(966005)(6486002)(110136005)(53546011)(6512007)(508600001)(6506007)(4326008)(8676002)(66476007)(66556008)(36756003)(31686004)(2906002)(66946007)(44832011)(26005)(15650500001)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJocnVHVERDNm45V1hMNG1qejVpVlBVSHFHQ251RTV4SGhrMTIvOFkrbUNw?=
 =?utf-8?B?S1NSbk5iQmMxajNTUUxwNkt3elIxWXdWWmdqTUQveWRPYmdZRGg5RXU2bGxJ?=
 =?utf-8?B?UkZsS1E2aitoTVU2Y1FqTm40TXZwcmd5ZmlTcnZoMTE0K3hiR2VLWWpXV3o5?=
 =?utf-8?B?TUFGYjd3Q3VUUEZoWEx4SFhsQVZVeVNSSCtsa21sN3FWaTdFbTNLaWVmMG8r?=
 =?utf-8?B?aHpmTDVvdGpRdGhJZTZoL1AyVS9DYmJDSE5LNGVHNXBoeXFSUjhhSUluV1dw?=
 =?utf-8?B?bHhDTWdrTENrZmxoSkViVVhKRUJZQUlpaUttTFFaS0phYVc1aVorblZWTzVx?=
 =?utf-8?B?cFQ1SEM2eFgvNDFxYnF4SWJZa1ltMWZWc1VNSUlDQUNlMmJ0aVYxMVJ3YjdN?=
 =?utf-8?B?V1laNEdsMURMWFlnRHBUMmdMbVd4eUd5WUNISVYwYzgyWWoyVVNuUHZVSkJm?=
 =?utf-8?B?QmJPS2tya1crcm8yNVpWY29hRURmZVhpTnlQV3dpUFgrWXlpdmhxS2hPS0RK?=
 =?utf-8?B?K2hLR09rTUV5SzR0Y0RpcnhFc0xrMHd5K3REYlhCRE1kVklNaksvWWhDTllu?=
 =?utf-8?B?d0xsdHlYakhyMnlkTTFPTG5BcVhKNE50V3pEdnNudEV2alhIcXJPTHJrWGNP?=
 =?utf-8?B?aVdkUWJ4TkRhSmxGcHdzTkk2eEZURVlZUFFqYk9NQUpXaVlHbVk5LzlQbnBK?=
 =?utf-8?B?eEEwM3c4NDkvUi91OGttc1RBdHJKT1pDQ2xHbk0zazVnaTkvK0JPY1Zkb1U2?=
 =?utf-8?B?ZUVSei9NVEswYmRhTjJoVDJkaS93TGZpWlBkYzE1VG1ZZzdhdUh0Y0xiTzR3?=
 =?utf-8?B?MjBYZkcxMnFXRVZpdjJJTzUzZ05UaFBvNEdCQ09Ya0JrSVV2Tjd3VXdrSnJD?=
 =?utf-8?B?c1RXUklITmRENXNZY2VvRWo4VnN1OWZtLzVSQTRGRmM1UXM4VGpkQ28zUnBo?=
 =?utf-8?B?U0tFVWx4OVlqeXVXRThIbXY4ME94R0d1aE9RS1ZIdTJLY0xOcFVzZHk5eDU5?=
 =?utf-8?B?Vk50V1dQYWg2NGxTZCtEQm5CODNHZ1lSSVd5N0dhYnRSbG9mNSthRE1yVWhB?=
 =?utf-8?B?V3N4dnl5cFBuWWI3dE1LcS9jeHpuU3REQlM0TGsrSUppV2R5Vy9IT0F3WHdZ?=
 =?utf-8?B?Q2s2L3R6VFZKRXdKUFJYeXlZZ0RmaWZCQ091aHY1NEcrZHZob1hSdlg2WVl0?=
 =?utf-8?B?WU1aVTFIME5YQVpPNm5qTTRtR0QxTGU2N0J0bnowdXpXaVVVS0FEbWIwQXQy?=
 =?utf-8?B?ZVErYlJ0aDlycHZoQ0hRWHRRdXllbXZOY0JSQlhlTmpMZVdUNmhCakZwZTNP?=
 =?utf-8?B?Rzg3MzJqeFIvVEtvaUFZOGRIL2t0TitkRDVVWlkzWnRjZkI0WGdUdksrSWp2?=
 =?utf-8?B?OFU1UzRxR0paL1ZOdW5tSCt1d2pLaWZsV2hIMWFqdk9sS0w5SFBuMFBRTjFF?=
 =?utf-8?B?WjNtb2xIRHp5bUQvUlF4bUZteCtIcVJRcHJ0TGtrNXpXRldiazBaTnlTdXpz?=
 =?utf-8?B?d0xPN2QwOCtIWmRHMnZMelJja1VzSVI1ZC94Rkk2OUZwNmhDcDRJTSsyZ1Bz?=
 =?utf-8?B?VTUvK21iRTZ3NkdWVTAwNkFGTUlteDcyek1aZWtrT093OHFIRFAxZStmQmRh?=
 =?utf-8?B?U245UTR4WS9MTEVsb04zNmYrTm1hYzlUTnpiTEg4YlFhaTdQR3BTQW1LRDB4?=
 =?utf-8?B?S2JYb0RCazYrejBGZjZjc01JSFlubUs1VzFZS2NpYnkrU0tuVE9EeHluWk5E?=
 =?utf-8?B?L01taDJrUytGa1Z1b2xlOEMyNUxHd25uOEY1aElvNFhaVUtMVWN2d1dZekZa?=
 =?utf-8?B?b1BYMDZUQXRkZG45Ty9xU1VEYXpBbGM1R2kvM1lTeUx2RjNZSStKVnZOK0Fs?=
 =?utf-8?B?QlNyNlZrdUh0ZWJtcFNtRzlKNmtBdXhGeXhzZTZBSU04M0gyUTB4MkpDZHRp?=
 =?utf-8?B?SVl2b0RnZC9JekFDMGdtS011YXZLaVd1RFROaHAvcFFqODNlS1pwaXVockxl?=
 =?utf-8?B?V2Jna1d0SlF5MGlyV3dZY3BVNEptN2Q3emZTUVhLc0VETXdVSksrYVJZeldQ?=
 =?utf-8?B?cHdZTzlORTBJMVFKQ0h6WmpHL1NFSnhKOCtlOXM2b0dMMks0TkMyRmNlZFRW?=
 =?utf-8?B?djVISi96ZjM3NXpqRXhtWkZSc1F1dU9lUlhXK3BQYWd2V3VmTWkxVTR4aGxV?=
 =?utf-8?Q?mGdn0hXCGyoiQ9VqRj3dQss=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5f93bb-52d5-4c7a-83e2-08d9f61cf3a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:04:05.8363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXMga+6Af6RWcsQa6mpHXDoilsOAOugMe9UBZDlke2CSQub+aFf30ScVJezlBMwggNmYaJW9b1IO3fef5GoBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2807
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-02-21 um 17:45 schrieb Alex Deucher:
> On Fri, Feb 18, 2022 at 11:25 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>> Dear Alex,
>>
>>
>> Thank you for the patch.
>>
>> Am 18.02.22 um 21:42 schrieb Alex Deucher:
>>> The driver has a fallback, to make the message informational
>> s/to/so/?
> fixed up locally.
>
>>> rather than a warning.
>> Maybe extend it a little?
> Done.
>
>> Component Resource Association Table (CRAT) are only applicable on some
>> AMD APUs. The message is perfectly expected. Even on AMD APUs we can now
>> fall back to treating it like a dGPU when the CRAT table is missing.
>>
>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 24898238b024..1eaabd2cb41b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -1569,7 +1569,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>>>        /* Fetch the CRAT table from ACPI */
>>>        status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
>>>        if (status == AE_NOT_FOUND) {
>>> -             pr_warn("CRAT table not found\n");
>>> +             pr_info("CRAT table not found\n");
>> Maybe make it even a debug message, or only print it, when a
>> corresponding AMD APU is found like in `kfd_is_acpi_crat_invalid()`?
>> Especially since Linux logs
>>
>>           amdgpu: Virtual CRAT table created for CPU
>>
>>       later on.
>>
> I think it's still valid so you know that no CRAT table was found on
> the platform.  @Kuehling, Felix any opinion?

CRAT tables are only relevant on some generations of AMD APUs. Later 
developments of the ACPI standards have basically made it obsolete. Most 
systems today and in the future don't have a CRAT table. So I'm OK with 
not mentioning it when it's missing.

Regards,
   Felix


>
> Alex
>
>>>                return -ENODATA;
>>>        } else if (ACPI_FAILURE(status)) {
>>>                const char *err = acpi_format_exception(status);
>> Kind regards,
>>
>> Paul
