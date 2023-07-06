Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61C9EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D45710E42E;
	Thu,  6 Jul 2023 16:53:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EA510E42E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMZSv6MHsjf5GpVQM6D5t1FQ38iQsqMYyWkV76ymXRVQGX92rpXMoNIDwn0mDcMybMHY6prVFZuPzQY9L0F+fi8hdJUdXpRS8A9rZaxf3CMZ7BiLQb5jxy+lzHLFOxszyjqPpTB6JnMwEGMG5bSiedahbIC4PoxOgpll94//poTDAA3VmydDZPLhDztDGookVPANFuLuvKy69mrg5wFQQ0wf5Bgb+g0fkdQtM+dMLthtDIjUtdlHkRxkmeOhH837a4MFK1a8EOr2zVUOnsREs8RMcQInaZgQZdScnKjfdrz2Sf29yGU6+TdsqkZfm+FDMOIaYBF1I0XCyfGSqKuYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET3y6kUnsQ7q6HW1nALfeGwsHu4fY6CVll29Jpx7q48=;
 b=gOKVywOE89eMpeZpVmdQaPC2PzWW7SegB+pzE2+ahHT8WoK251ySlqIAcwL+RH5mkuEomgkiwJIen5nPjrndRcS3ndMfFZwDtFO/dAbTvziJS8mXbX5LQ0VOoGvFI79b95Mcm0MZdfNkPH+BB6+jFBDR2W/OKf22bs7125+AJmweDP9Zq6kDJlE+ih3Lu0GpCr3I71d56mllpr9V0ZJyHtUKFwx+vjstu8q0/6Kt0bdgi4vHGjeudLtj6uUFLApZWW+AyIv83XN+z4Ag0xcdfAeyOembKcHV+pzCq3tQgoVUY50yYI1yoSkHUAlspvmqCV55l7QbO1BB1UkdrzCilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET3y6kUnsQ7q6HW1nALfeGwsHu4fY6CVll29Jpx7q48=;
 b=D5HwXy9ufQ2OmmJrE8HkEcQKOrQltMyhBrxy/4v/uzEocsfkvA24yfl2yivHhm8FbIBpX8kXFPzu05u0abseA72QC7/8XLit5ph90WzbGeOhXbSjLcIgSR9Ugs9NGTQr3q5j7DDwTS1rxbNOopEoslR8STH+g72X9fFsydl7bBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:52:56 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:52:56 +0000
Message-ID: <c1ed28d2-cfb6-031b-95af-86f5da85b342@amd.com>
Date: Thu, 6 Jul 2023 18:52:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/10] drm/amdgpu: add usermode queue base code
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-3-shashank.sharma@amd.com>
 <CADnq5_P6pHZVOOgRVd51rUfxf7+BxZt62Ty818670quuAUETFA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_P6pHZVOOgRVd51rUfxf7+BxZt62Ty818670quuAUETFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: a6317469-674c-477e-b65e-08db7e41728f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVTDGmhLokvhecyWTILo0yviBirXsOgUu/yabKzuquygwFlUFOOF4KPNZXoSiXXgZ8OtoMpIKP4YizHhZN6p6lWUOgFEGt4Eco0Gp3TkX0srFI8c3AW3UyePQaYKkQZDDWPlwylsUhYG0qsdBbK7HFgdSeGgBFynr8hOnNjMMwHjY8CICiezpgTZf7vb/aaEC4vw6sN5xQtJsFFoDTr0dd5f01SrBRUyy6GHuBPLL+OsA1+3d/m1tg8b9rp3ECHsf5SbBIQa3PEKqTip5VgqZwikmuUBHmLkZFo+Wj7oz1RFsv2RUqTqvKBBMrQD+XtoudDn8JQjKIS07MfkDTbW63tYq46zR0uepF9muIaj/gmu5Rsz+K18EnMwpon6tbwYwy692B/otraAYMKjjysuvP8X2m02JyHuGkLHqQtjv8Peb4PAGo73p+pl2+dwTeweIfHf3BOVyA+D1EVwgf9JMVn00ez6W3URa6Hbf5rWZ4daN6jObUlJfdFjlUU84lilMz0ldosd3hCufOl7sHz5FtqIQcbyjwCEr4IS8MuUc1jmSV4K7Etc8+YUsv9KDraMymQeiH9Saxdsu5lKfZIeEYg+45/k5plIZUo06W3JkjuzO40FZ4OfnpClsuKpTfxB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(66476007)(54906003)(478600001)(6512007)(53546011)(26005)(6506007)(186003)(31686004)(86362001)(2616005)(6666004)(6486002)(316002)(83380400001)(38100700002)(4326008)(66556008)(6916009)(66946007)(5660300002)(8676002)(8936002)(30864003)(44832011)(66899021)(41300700001)(2906002)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVcyV3lwclB5UmEwWndQZUVNMUsvSkJHb2FsSWhHeWpQcnQwYlBJY0o1aVds?=
 =?utf-8?B?Tjh4cm55TmUwZ1RYbkZGb2NNaEVUa285bzg0MHJUeGxMaDhtUDF2Ymk4S0l3?=
 =?utf-8?B?NXgydVlGQkIwaVYrUmlrY3M3MG92YkF5RGN4KzUrN2laaU9keDZrKzUrOEVs?=
 =?utf-8?B?dWxzNUwwaER6VGplMGw3VGxZWjlVSmNrSTE1WkU1TFNwdlQ5SjhHVmV4akp6?=
 =?utf-8?B?Wkc4R1ZTTVJSTTZ2ZVFEQlBvZWxTTlR1dDhwcStPV0hhVmk4a0Z3bndXOThx?=
 =?utf-8?B?d1VtbUF0eEVRbEVlVmk0cW5vWkpLQU00RDFqdy9UM1Z0SDMvOHpNTHRlTCtD?=
 =?utf-8?B?MnJJRFFyU1dlckplTWlETkp1ZnFwZllUeC9mT2w1YnFNUnpveTJoaEZFaXpU?=
 =?utf-8?B?VlVLbHVtUHJQYnROZS9BT3VQRnpTaWlsRzVXNVVWNXd4cStwYXcwQXVQaFR3?=
 =?utf-8?B?bzY3RFA2QVIra3J4aWxVbUNmQmNvbFh2RXVkYTNBQ3hLeWhlOExrWjFwS3Qz?=
 =?utf-8?B?Y1RBTW1CMFFjWHJwOCs0eWFhUlJRM2hEWlhFb05uQTJUSm1Wc3pFclZZN1V1?=
 =?utf-8?B?RnBwK25rZG5hOVNpVmFKUFk3MjFETzhKMTNaeWw4WHEzMjRlQ2VDR0tMME1K?=
 =?utf-8?B?eTk1eDJGYW9nS3p0VFlLcGFsQmVWbFAzL2V2NFUvWHJOWVprWjZKSmxWcGJC?=
 =?utf-8?B?b1RTOTRGY3FQWUdLbHk2NnpyM05RMnZsMldpWTBpb0hyNEU4VjN5VzFnUTJN?=
 =?utf-8?B?alc2bUdNZFlPai9uc0Jjd1ZTWXp1dXU5YVBrZnl6cDArYmNtMkpKQytIbi8r?=
 =?utf-8?B?NXdrNmJyY0dCdzdWUE85dGtHcHU1THpxLzNNOE1qRWwvelQ4R2M4aG5ySGpH?=
 =?utf-8?B?RGhPbWNTM3NXcnJRRnJlZWlHYnNSVzlIVUk4TElWcWdHZzRXWFF5dHpuT01a?=
 =?utf-8?B?RSt0ZzVtTDlMVzJvTm1PNHVGRTRVVWx5NTRPYzJERVRxcmpkNmZ2WEpDQ1By?=
 =?utf-8?B?Z1NSazVraStTSU01blM4d21ieDZ4S1VlQVJpOWE0SkpMVWZxTkJTaG41TUdG?=
 =?utf-8?B?WS9PQXNYU0NvYStYN295RG1SYnRua0Q1ekEwR2QzWVJpMDhNbzY2R3RnZmN1?=
 =?utf-8?B?RmhrcXdXRld0Y2VVbkxUVy9USHphbjRXa3NzUkJvblZ0N1VYY2NUNHlkTE9v?=
 =?utf-8?B?VnNybEZub2pTeEl5RDBzb2JTWjN3L2lyRCt5MGdlZUhIZ1gzZWk1czk0MStW?=
 =?utf-8?B?SXk0ZWV1V01TQk5IRkViR0lmUHF6a2hMZVZtTXkyTEw5d0hpZE9XUGRFR28x?=
 =?utf-8?B?RHBXVWhUNDFGRlZHNWQrd1JSV0kyNnVtUWRpaXhSdy9ySXc4RnRGOG50eUxQ?=
 =?utf-8?B?TmlJMlcxWFFGOUgxWUdocUtGOHgwb1pUSEFSaTYyWW5ZNU1CT0xsK3dNRlVv?=
 =?utf-8?B?N3dOcUcrSndxRmVXbFgzbSsrUXNCeG1QNnV0Wk1QdmJTWWZuV0gwOE1tS2Jy?=
 =?utf-8?B?Wm9yaEJydEpLVGdRSnRuSlF6TmQ1bmxRbUpCTHArenFHMmFDbC80YnpsZjRI?=
 =?utf-8?B?TEhheUFXcFNQV3RCckN4WGNudUhsZE5Qc0lVdi9ma0JEWjI0dERKcVZCd01R?=
 =?utf-8?B?QjZuVFBHLys2UUdoQkNmQUFVU3I5a3FkR3RINDk5dk1hVXMvT0xkdDRjakF4?=
 =?utf-8?B?RlM1a0RLamFweTB4ai96NmxreTVOc041KzJaT3h2M2FsUE92SE5od2d1Wk5p?=
 =?utf-8?B?elNQTXhUMHI0dmUyMy9TR3gxbElMaXkrVEpkNzVYSFozWnVDdG1IeHJva2Rr?=
 =?utf-8?B?eS9jdUVqMGtJN3lwakFYRXBnTElIOWpzdGxBTlJlOCtVbzRaalhlVU1QZGpn?=
 =?utf-8?B?U216UXZDRXBkYTloZklpWDhNOEpJMHJRTWxxQkZvMlNiS0VuQlFQSVV6bm9B?=
 =?utf-8?B?ZEsxSmFpYUFzVW00bzFsNEFsbG5DUCtkOUt5Z2VMeGZlblBEcDkzVTlMek5B?=
 =?utf-8?B?bjhsWFVuK2V3S2JHRnBsL1VrMnNmM01PRC93Vi8zZ09CeEIzRkRNazJPQUx6?=
 =?utf-8?B?Y3BCam5Va01BYlAxRDJ3aHBHbysrNnpPZVNNMmZaWS9acTIxQnl5d1NwOERY?=
 =?utf-8?Q?qWMkq+T65G/EcPuvoI23Fy8TL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6317469-674c-477e-b65e-08db7e41728f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:52:56.5789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptUNQfQCv3sRDrMQXm4n/hUKaEnNmJvedpEIXXM0HUPYku3aicNnLlOt6EygNgr6z9PAUOzWJDA3ZACFhyNeUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/07/2023 18:36, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 8:36 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds skeleton code for amdgpu usermode queue.
>> It contains:
>> - A new files with init functions of usermode queues.
>> - A queue context manager in driver private data.
>>
>> V1: Worked on design review comments from RFC patch series:
>> (https://patchwork.freedesktop.org/series/112214/)
>> - Alex: Keep a list of queues, instead of single queue per process.
>> - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2:
>>   - Reformatted code, split the big patch into two
>>
>> V3:
>> - Integration with doorbell manager
>>
>> V4:
>> - Align the structure member names to the largest member's column
>>    (Luben)
>> - Added SPDX license (Luben)
>>
>> V5:
>> - Do not add amdgpu.h in amdgpu_userqueue.h (Christian).
>> - Move struct amdgpu_userq_mgr into amdgpu_userqueue.h (Christian).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 ++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 62 +++++++++++++++++++
>>   6 files changed, 113 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 415a7fa395c4..4b9bae995094 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -216,6 +216,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>
>> +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 02b827785e39..fab842138cd5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -107,6 +107,7 @@
>>   #include "amdgpu_fdinfo.h"
>>   #include "amdgpu_mca.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   #define MAX_GPU_INSTANCE               16
>>
>> @@ -463,6 +464,7 @@ struct amdgpu_fpriv {
>>          struct mutex            bo_list_lock;
>>          struct idr              bo_list_handles;
>>          struct amdgpu_ctx_mgr   ctx_mgr;
>> +       struct amdgpu_userq_mgr userq_mgr;
>>   };
>>
>>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b1ca1ab6d6ad..4c5e44d41652 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -50,6 +50,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   /*
>>    * KMS wrapper.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 0efb38539d70..68e5375b648b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -44,6 +44,7 @@
>>   #include "amdgpu_display.h"
>>   #include "amdgpu_ras.h"
>>   #include "amd_pcie.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>>   {
>> @@ -1234,6 +1235,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>
>>          amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>
>> +       r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> +       if (r)
>> +               DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
>> +
>>          file_priv->driver_priv = fpriv;
>>          goto out_suspend;
>>
>> @@ -1301,6 +1306,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>
>>          amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>          amdgpu_vm_fini(adev, &fpriv->vm);
>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>
>>          if (pasid)
>>                  amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..effc0c7c02cf
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>> +{
>> +       mutex_init(&userq_mgr->userq_mutex);
>> +       idr_init_base(&userq_mgr->userq_idr, 1);
>> +       userq_mgr->adev = adev;
>> +
>> +       return 0;
>> +}
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>> +{
>> +       idr_destroy(&userq_mgr->userq_idr);
>> +       mutex_destroy(&userq_mgr->userq_mutex);
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> new file mode 100644
>> index 000000000000..79ffa131a514
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERQUEUE_H_
>> +#define AMDGPU_USERQUEUE_H_
>> +
>> +#define AMDGPU_MAX_USERQ_COUNT 512
>> +
>> +struct amdgpu_mqd_prop;
>> +
>> +struct amdgpu_usermode_queue {
>> +       int                     queue_type;
>> +       uint64_t                doorbell_handle;
>> +       uint64_t                doorbell_index;
>> +       uint64_t                flags;
>> +       struct amdgpu_mqd_prop  *userq_prop;
>> +       struct amdgpu_userq_mgr *userq_mgr;
>> +       struct amdgpu_vm        *vm;
>> +};
>> +
>> +struct amdgpu_userq_funcs {
>> +       int (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr,
>> +                         struct drm_amdgpu_userq_in *args,
>> +                         struct amdgpu_usermode_queue *queue);
>> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
>> +                           struct amdgpu_usermode_queue *uq);
>> +};
>> +
>> +/* Usermode queues for gfx */
>> +struct amdgpu_userq_mgr {
>> +       struct idr                      userq_idr;
>> +       struct mutex                    userq_mutex;
>> +       struct amdgpu_device            *adev;
>> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> Why did we decide to put these in the userq_mgr rather than having
> them in adev?  I tried to find the original v1 thread.  It just seems
> like extra work to assign a bunch of pointers every time we create a
> userq_mgr.  I don't see a case where we would ever want them to be
> different per userq_mgr instance.  It also keeps all of the IP
> specific knowledge in the IP specific code.  E.g., if some IP only
> supports this for specific versions, we could assign the pointers to
> adev in that IP's code rather than adding a bunch of logic to the
> generic userq code to know which IP versions may or may not support
> this.

So far we have been discussing on why not to keep this whole structure 
in adev, which was as discussed due to a previous review comment (want 
to make this data specific to a session between open() and close(), and 
also not to overpopulate adev), but we do not have a specific reason to 
keep these function ptrs in uq_mgr. I can move just these function 
pointers in adev and we can initialize this once during the IP init, the 
small cost to pay would be right now all the things related to usermode 
queue is at this one place, in the other case it would be scattered 
across two (Which can be ignored, if we prefer :))

- Shashank

> Alex
>
>
>> +};
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> +
>> +#endif
>> --
>> 2.40.1
>>
