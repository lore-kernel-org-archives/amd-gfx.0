Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AABC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 13:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D159C10E42E;
	Tue, 11 Jan 2022 13:42:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0879910E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 13:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1EgxZMfmIoiUXXp7cnLEDnr/BjYZIhpDv/HQ4aLwcXjcK/1QG7cI0h6UA+RWDiBvq9iR4JNXhHkdeN5DwNCmqYmmACrmk0hWP7UHVRoSqezvBRZ5OWn3Z5YwnZVlgS2MUn7aVyi0ZMNMtDO7rRv+vfDcY+3PT4JlsfTeg6+9aa1RJszzGkAGJKF8LqNM83ELd0Vfmv7rSMgiE1MGqMm2zR+1uOvFcmm0W/Q+/blA8Fh5PBZ87qwJRXfOpPbiG9O8MnCPKj8FgbMH4F9+R/7VHf4PH5s8FzTBAXp+MVIEJB2GVpnyXZbcGw6P/GW0xelAziOP99v1hEJd8A1yzodww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+ZKN6ylA1pxIOtKMqlBMRBWO5Oy39kxrDba25jzeXI=;
 b=EcZMz+/BCZWrzQZX7PmJY/4/+Ll70E+gtsD9sYP/oIM6bLI9tkrDYuDqZinzF/ilHKmaixBWNUzIYKQA4xPKLuheOLHTuNrQdGPB+1675cqVf2YMkCdBW7kiZiLNVUjTtoi3TxemGBbFal2Gm36s9wMNGAiu8mn7ha8C2nM9prPDWU0sdfkS6HSjQe26Ker/NQu0O8UpJpFOxmUrzKzJzxPjmASqi6+pip+L9wCnKJXGFU9JK5t0k7Oa4aQKSDvJ20VmVKRviTF+x0zMMEi3ModI/2xbAaQTCjpxcAiXKYpoJ4KyFxrwl3So17u6eZBvHTK2/mQOR6jHiaVJD+xAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+ZKN6ylA1pxIOtKMqlBMRBWO5Oy39kxrDba25jzeXI=;
 b=T1dYy8WiJP1SsBqjZvvRZNaIHzA8BnGOOZUtEC8WWaMMLW3NTUOpTp5OktKtIHhLZy8U977HEKE279sIggLX9Nq4zQrjiZjZOBygNWm9BJGQLoej0Wdpg5FnxX2wTna2wdaQSMtt4fqreTLyUoevBZH324OEe15X3XbUbn6iam4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 13:42:29 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 13:42:29 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: Treat warning as an error
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
 <20220110233906.1178021-2-Rodrigo.Siqueira@amd.com>
 <3bfd4b1f-effb-e16f-8282-628fe2e6089b@mailbox.org>
 <bead9711-fe1f-730c-0daf-7e5f4fb533a4@mailbox.org>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <e920bd9b-0f56-a424-b3ec-33ac45aee844@amd.com>
Date: Tue, 11 Jan 2022 08:42:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <bead9711-fe1f-730c-0daf-7e5f4fb533a4@mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::19) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3083ce7f-7452-4605-e243-08d9d50835dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3053:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3053F27C6E0A6658EF211EE198519@MN2PR12MB3053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuC2hj1x49aEXcY3psLnAcRlLpSc89am2S/HjN4x6bVdpwb2RVNUSugUEQxQgZjbA82PGV+TugXkMiQQ1OZSHqWWDucw777VrtjHCxSCjvI/zozvrvUy4Lor1DFxied3FsTatGMtE8za03lxmypP2gvmBnW9homN5uhxSbuQoXHLGKM18G+xMujxBsWPnoIyrqLMVF3PGWULmiKlLdrIDkIAedPpftWfx3IRvgUoKlOHz2wxtMAOlkI+ZJL5OeX+JwzbvjZi0XOanjphHdyk6fETfFP3Xkf65TEFbGtar8hmhelNf9R03no4NxC2IBYt0XVjHDjmIVGjd7Vr9j/g9pJerh9IuMfOWGQLc5DsaQTE8goDbV/h18+1AsAMn5JeDidp8beQ6oFLEn+gGRXOBf1SK8HRNFsbz0bZG/S7TRa9Wqcw0zOZ/drcqly+dfcHnk76BXOyUPM+5LlBhqN55In6Jgf10/J/Qajs0PTNycKGf5rCXIMQQP4budLlzjtegZtMJHcv/qN5Bq9Yiy8pIjCUk5GwLwh5VWevE8RCdZ60jk94SFwmnUdslHZC52fxeWjEgDEUh8DlL83gOozADMVkaATEEIrsq3c6bK1RrKArA/JuXjw6oI1y9Gv+DqQesF3YB9+2/qvXxaqK//Fag4MS0kGeYhqG1uzp/uYa49W6oPfKg6NPpXeWVbt0vX8+Hb67cZvcq/TrEqG8NnOcfOAOON4jolI8Z9sWBabrRDUHdDuIZ1U7QaOwd88lFMfR9cXvjXdrcq1sMGbFNzuzWMH7+zK1vcaek5/wv8ivg7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(316002)(110136005)(31686004)(4326008)(6636002)(83380400001)(66556008)(2616005)(6486002)(6506007)(508600001)(186003)(53546011)(66476007)(66946007)(5660300002)(6666004)(2906002)(8936002)(8676002)(66574015)(6512007)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVDWTFzTVozbEVPQU1wa1lIWmh6RU5wcDJzdkJnQUIyTGZqM3Ftb3RLUUFO?=
 =?utf-8?B?T0M4Y21nRmVmWmJTSU5mN1NGNEIvTkQ3Z2JRaFExRlpqcG1DZEtVZXpLTWV6?=
 =?utf-8?B?STV3T2wrNVNGMjl1TXZJb3ArWUk4OU9oYzBzcmFiV0JPR2RSb3Y4Vks0aWZB?=
 =?utf-8?B?cHFTYWVFcjREdWhhM3NoK2JBTHNCK2NVVmZJM1Q3Sktwb0JEZm92TmhDdVND?=
 =?utf-8?B?R3hzNjFmZzdScXVxRUh5R1pRYUtNZEpmeWRWd1dubWs0T1owWEJMRlp2cVBE?=
 =?utf-8?B?TjV5cGpCbG1yRFMxWGVsQmx4dWNpMUZYb1FnaC9hWjdMWUUvSEhFeXBLWGl5?=
 =?utf-8?B?TXFGblJhY3hzckI1WnprUkErclM0MUpxSjI4Q0kwRVY3UW04WlFKcUFYOUF3?=
 =?utf-8?B?MTM4bTNZOW1CRmxKaHlWSGpqTERCcHlGUXFUTDVvamZOanhUMUdlTnJxSlRD?=
 =?utf-8?B?ME8rRlJCZEpqcklSMjZWU3kvcnM0S29JaDBOVjF1WDRuR3krV2NUZnBuWnRF?=
 =?utf-8?B?ZkpXTGQzQmpKWXYyZkdtNldaMHpvbHQrOGZYVkh1VG9paTVOY1dleG5nNCs1?=
 =?utf-8?B?aDNadnZzSjJQSzIwaXNqUGJraEhWZXNkSUx3aUJYaVhrditSSEJjZFFrV2Fs?=
 =?utf-8?B?U3lhVVQ0Mk0wL1ByNDV6cXFLcE1BOGIzK21YTDBhSE5nK3BCdWtpckIzU2tB?=
 =?utf-8?B?ODZOZ1VCUFRyanlMak9IbyszZXVzcUQvcFBSZCtuMGdCKzQrVXVMNWFxZUZp?=
 =?utf-8?B?TThqaFloSTJxbFFSUVZEK3FZRkVEcmoxamZoOXpXRHBLUVZqdGlCTFZSZkRY?=
 =?utf-8?B?OFowMHpXQ1dtY2l5akl6ZDJTNDI0SzJCRXIxQWlGS1NVaVVUTU9pM0dFOFJW?=
 =?utf-8?B?Y2l6REs0OWdDWUk2ak9NVkRtbC9uRkcwR2JJMkEwbDVNcXYyWHdIcW1MbUh1?=
 =?utf-8?B?eGRzN0lXTlplV0tGaU5QblRqUHpUN3BLakJXSXErWHVuUk9XQnFNRVdqY3Ba?=
 =?utf-8?B?Z1ZwbEJIa2Z3eVo0THNSQjhvdVhwNUVVK3pMR0FkZTh4cjIvV1JxcnRtNXkz?=
 =?utf-8?B?Vlc3T1p5V1NBWU5pT3pWMGJBTjhIYTlxbk85bGIzbVd2b2dJUVU4Nk5aVlVv?=
 =?utf-8?B?MjBqWVpwWXpRQUo1U3dyRzY2bUYzMjRubmJERG1uV0R6QThEKzVnQzNaOUhu?=
 =?utf-8?B?NnVMMlh0MzIyMFBlSHZUL010UVVjSlNEUDNpRndFNlloZ0E2NDBLOEpFRlFB?=
 =?utf-8?B?U1Q4SjJaNWZKRjZ1NEdyQThhc05hS1B3V3NXc3RvZGtoSnVTcVlqdXNHbi9i?=
 =?utf-8?B?cFNwaFhkdG5UU3pZbkd6QjQ1alhQZmRpeC9YL1dsTDI3bGQzTHRFYUwzN3Fx?=
 =?utf-8?B?TDViMFg5VGVlK3R2a3FmSWROL0Z5OXFqdTdJcWtFNWIvRG1ZM1RTZDVzbDV3?=
 =?utf-8?B?WG9JWXMvSXAveUhqdDJMOW8zandFajYyZVNKRzRJZjVnQjMwOG9IU2dqM1Rl?=
 =?utf-8?B?YXNER0pBbjdDcXdiM0VBRlE4em5ZcVcwOERQZmpWWTFqUmlMK25LU1VidGtj?=
 =?utf-8?B?bDc0Unh2OEpGZlZreW94c0JVMWh5VmRFdzUyTVBmVDd4MkdPa3FkQk15Ulh0?=
 =?utf-8?B?ZmpaVUFLb3RTbXhnOEJRczJzNXBma0lWeUxrZUhNa2dmN3EybE5hVE9aQUxC?=
 =?utf-8?B?NUJLM3RleGRncmFkeW9mK2ZmeFU0enRLYlRXNDhzVlY3UTYxZUZRa29URmdJ?=
 =?utf-8?B?NDdoUEpSYWRtcDVKL0J5bzU3cVlvTmZ5VzdRVnByd1hjS09tL2NYdG9NUElw?=
 =?utf-8?B?R2dFd2FkOWpCZTk4VVNJRnkzRFh4YUh5OEJsS09LNlFnRWd5RjIwRUtNV1lP?=
 =?utf-8?B?aXlRQVJ4U3pqS0U1cDVJU0kramY0MEdVYWh0TG5uS1VzMDJUSUdWenk5Tmpv?=
 =?utf-8?B?bnIvTVdBWFhIWjF6amF3OUppdWhJWEd5QmdUQ1prdUFwaTZSS1diamVReS94?=
 =?utf-8?B?UzFOajJLd1g4K0NLVFJmeDlxV05ITk11UXlvZmFxT2ZiUkxFS3FLWGQxRXo2?=
 =?utf-8?B?QW5KdDhDWlBIQStoaGNQdTc3VmgxVmxUNS9taEZsSHRLOFBEc240Z3dCMGlm?=
 =?utf-8?B?TUJOTWYza1JCVmxFdG9JWGRWVmVrdThNWkNhL2RJTUpGbnFSbWZNNnlwVE96?=
 =?utf-8?B?QVpYNzRZUGtMQ3l3c0tPMkdYM0NTd0tRSnhPSFdlczROMVlIc3hDVGRoY1Bw?=
 =?utf-8?Q?CiUyfSnwkLatlTZgWVVDJdsGRMGzp46EtvQfv1+ibE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3083ce7f-7452-4605-e243-08d9d50835dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 13:42:29.1997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IgbXEpq+wv5JrhIaF2IcG1rg8ItEEtJRJcR8EJjajyvuAhn7jhhw3KsXGuQdaiLTfDVGUpks4lMCB163go8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-11 6:00 a.m., Michel Dänzer wrote:
> On 2022-01-11 11:41, Michel Dänzer wrote:
>> On 2022-01-11 00:39, Rodrigo Siqueira wrote:
>>> We have one internal CI that builds our kernel with the -Werror flag; as
>>> a result, when we try to sync our branch with amd-staging-drm-next we
>>> get some failures due to warnings. This commit tries to alleviate this
>>> problem by forcing a warning to be treated as an error.
>>>
>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 7fedbb725e17..158f427c2f2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -27,6 +27,8 @@ FULL_AMD_PATH=$(srctree)/$(src)/..
>>>   DISPLAY_FOLDER_NAME=display
>>>   FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>>>   
>>> +subdir-ccflags-y += -Werror
>>
>> The problem with this is that different compilers, or even different versions of the same compiler, can generate different warnings for the same code. So this will definitely result in some people hitting compile failures for no reason other than using a different compiler (version) than the code had been tested with.
> 
> A corollary of this is that your internal CI might still hit compile failures due to warnings, if its compiler (version) is sufficiently different from those used by the critical path of maintainers for merging amdgpu changes.
> 
> Since that CI cannot prevent merging of changes with warnings, it cannot enable -Werror without risking this.

Hi Michel/Alex,

Those are great points, and I did not think about the different GCC an 
config versions; I tried with GCC and Clang, but the version can 
definitely become a problem.

Thanks a lot for the explanation; I guess I need to find another way to 
handle this issue.

Best Regards
Siqueira
