Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BB606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wt1aFmW+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A8510E776;
	Mon, 23 Nov 2026 09:45:31 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393FA10E776
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 09:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEnSNS2ac1SbycVoT7qqLKDMiU3VZlWLmOBg1AvC6N8G1YTzzoYk33KUvcbKznyGV67LpZraex1XHV1IYmLPJyI0Uz5fmAjoUICb21iuASWXpjCwCKMYl8+MOkv2WruqesBIiLBty2iZRZrAqbIi1Mty3hf8qA7+xCgiHbB5hJwiyU+pLJO5tgcp46TH+Lqae9gBQiRutbx/w19E/pIM6UgGolWfbYUC594WAbUa0ESlrq3+5LStjczeIy84JxNJx8xYssIQk1B8CAsZQaH5BSG+PTCkj+qDQttQR8KsKXen2vOa+dOYhQH0TK68DeYYRsskNB0MASCBTv5/0OTQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tX9rrgApLYyf0y/V93WOHqTMZVWSjTL9QSOVN+fKWI=;
 b=Bm4ieYqgu6Z1UloDtIdBR4zPkdwXJXyK9Gx1NGOGAbU2Ar4VE7TK0axIsehdQ3Sq+IVzBtCjfmrDCGlLM85scmuAujdO9lDRRWT2HYfsTAk/PHAaLR3lzVVo6vHlSX6XvK6avdWYYeDKUMsYB5eRcwbk4vBvZfbYHknsprRCwqykSHELpny9t5p3YpWvL/fr9YSQEzldirPuOh96hZ1Clm0GA0fp5YYV9rh9O67qHdd7cQdxGNdfnmk3njP5ktU99j4cM3nvFv2Zg7yMz4xg0sDgVzQ8/sYScePNLWAQPQb2riK3TJ9wT3+gXp5Xx6m1X8+GqymVvjOLT/5BML+NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tX9rrgApLYyf0y/V93WOHqTMZVWSjTL9QSOVN+fKWI=;
 b=Wt1aFmW+fBqzTJiZ59EDTQ3YGYgugLB1tqkHDn+8TQ3fgWWxgQqjSv6kKrol0l8UGzaQuSHyl8CXdc8RywooSUNH4RRKVHs0yQICV174vjJREVzncE2haPTixpGxjksIKE6UXrVt3+L/XLDiKgPpCQMj6bWblQCxpf3+wzSKA7g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:45:22 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:45:21 +0000
Content-Type: multipart/alternative;
 boundary="------------WBA8zeMSQ8X54PQ0yoXICGG5"
Message-ID: <53aa579b-18b1-4052-b004-b674fcf96ee5@amd.com>
Date: Mon, 23 Nov 2026 17:45:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: don't map SVM ranges to a GPU without a VM
To: Felix Kuehling <felix.kuehling@amd.com>, Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20261120091638.20608-1-lingshan.zhu@amd.com>
 <ccae1602-9922-450f-b5c9-385459a94baf@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <ccae1602-9922-450f-b5c9-385459a94baf@amd.com>
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e15dff-9202-4aca-bad8-08df49467db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|261022075727099003|261022105027099003|261021135927099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: ViFZkacZtfngN1RKiks4BVDaTcbbbStS6E8T10l12xi7uTVSgFsqQcfvgtfO/cBqxj9WSm4RnVWxxOeFolkdSmc1c5ZeCQCBXOuLlMCvo5NSdp85etWqgBSlYZEQxrbYTUPJGoj4EbxpCS5NThC8659YDxLvxi6kTlZKFxjWi0sv0qErb0vLY9ZmI9mkKQ//SRadvjnpkpRDaDXHEfCIaVEbIMLLod5jO3/dQ3TxNMOfQmy+Sfb5/KolF3xQThw7PF1m1K9P495cOK2DQDyl5wP+VQssNUX0/bgjWOl/qevNI1N63IAQd1YHcoGe5qRjDdJcaDd521GM1v72/BKNI1JAmj/hLmW22ncl/qiheYlbp5BCHLHfKzjWgCOjQqLzFdYnfTJkLzRzEZSkxp7BhGsojy/F+jETOENheo1H9b47YjSqj3xcdCkjcFfLkMBfU0lfMkuslb2A4bLRtdNmSIL7GbrPBfL4QmHhPEj8PRB6D8dQor92XfG4T/9gLzjO36gjXTIwLoFyH5wV2ZcrXyA6IhMyJx2rLX0L7Hnm1OGHCL3Hf7YLoq877IQ/mBfXESS1CoI6bIaWcuGfdIxwpjJnc84VHUn+ub4HD9CnMfOFXVfajBiKhLBDORO7mcdQBQ/uXkddNos6RXXtqdcilYDhn1jjx4uA162tIeH6O0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021135927099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5rUE8yWDdmZzdTUERXSUgvVUlkQXV2NmNaRFhjMWlVR1VQaVZCQ3QrMVBF?=
 =?utf-8?B?WnJEcnZFaEptWWZ6UjhDNVNybnNZTmplSTJjUlBQblVXYjNCZWtnN2NGWWxU?=
 =?utf-8?B?TkZSdUtzSlY3L09IbGJWd0Q5czdYdi9XNERYRDNBUXNlT2lDc0ZHN00zV0lY?=
 =?utf-8?B?Tkt2TnppdUY4QWcyUnZPRG5pK281cjJuOUpCb0ordGEvUWRYT0hKbWR6dWNa?=
 =?utf-8?B?WjdwaFFzUEIwNGlIdlE3UmFJc0VoVUhqaWFDeTZLbUlnamRwVjMvNDRVNU1s?=
 =?utf-8?B?Q25LekxWd0NlZktTZTB4c1Rmb0JFclpZYkJvV1JlZHZhVEJvSFBJTHAxckdR?=
 =?utf-8?B?VmFoRjJKS0NWUm90K0RPQzF5UHFsQUkyMFEwS1MxM0RBREtwd0hTY2xpakVG?=
 =?utf-8?B?NXpvZVdJYXZhQjVPaE4wNXNCeTR3OUN2cm81aVA2bmdDUmFDY0xFZWwreGRZ?=
 =?utf-8?B?Nng3aDM4dTlYWnZHUGYrZDY5RjlRTUpBaE1Hb1J1S3Jxak5FUTQ3S0FqTlcw?=
 =?utf-8?B?bmMxd05XZVMrS2syMVJlblZTQWI0RURxRGhxRi94UHkzZ1BsMXNPRDk4ME5a?=
 =?utf-8?B?bys4SmRkcW5tRmJJaG1IMDdnd1owZ1RRTFAyUmNVUjRFSGdROEQvUHRVcFdT?=
 =?utf-8?B?WnNpYWFoNkd4bktIQTlITHJ5SzdDWVJhYkkxQWpXTWJVVDJMM0ZEb05mclpa?=
 =?utf-8?B?Nno2S28velZLNHcrNzRySzBnVTU3NHpMZUJjYmJiS3p3M3RSeGZGMnJnWHZr?=
 =?utf-8?B?dllLMjlMVG5UVVdOK3ZqSUQzL09OTzhiN2grTVV3OXQvNVFvMW03S0QySjBD?=
 =?utf-8?B?MXVRa0pIQlV3eXBIOUhRZ3Q1TWMvOEZta1hHRG0xMUFvcGVrVkZHeHV0UDRI?=
 =?utf-8?B?aTV6TkVtZnVzMEp1QVBPUG0wbHNnT3A1U09ySm52N1FkSStKM2o2SE14WE8r?=
 =?utf-8?B?eFJIYm1GVlhaakFwTTZsN3FSbVIrYTlOeXpqSyt5MU5Vd2RqNGpHTkNNdWlF?=
 =?utf-8?B?MnJQd2s4V1ZFbUFHaHR0NkRIWTlSbldaSGlWZzFWei9kMnJPZ3daK1NYUnZ6?=
 =?utf-8?B?bVdBZ0xLam9FMEdVU3AwYndHZVNEaUlGbzJHN3dWWDBUcG96Sk45djhJak5Q?=
 =?utf-8?B?eGJwN3hhbFQ4VmY1b2JiWnZsOFlBOG9qdjl5Y1NGV3ZxaytpeTVJMzJYSWNN?=
 =?utf-8?B?OHRETkdwY2pwTmswQThnMjRucktHR2pPUjJpYTJoU0tvaGhBM0FQaXhBMWRE?=
 =?utf-8?B?MEtVdHYxTnZCcXZqYWZSTE1sdlVGUVMxdWplWEVSSjMrNk02WnV0VjdTa092?=
 =?utf-8?B?QVFqME5ha2N6b1oyOUhsdXkwaDcxU0lLSkZ4MmthK3BodEhFdzRSdUFYQnZv?=
 =?utf-8?B?TThEaEp4a3JncmNwSnhxd2VHNUhRTDlHZis0UktFNjVvdVh6MktiOGptNExj?=
 =?utf-8?B?R080MXJ6SW9xWWNNWklkUG51RXo0eUlrWVVCM3FGZHZHMjFxanpDSll0aDNq?=
 =?utf-8?B?aWFyNzVGY09QcFFDdk81d0VuRk5BQ3VzaE5xVjNqalB6ajl5K3Q1UUJXU3BH?=
 =?utf-8?B?YXJiUXA3MSt3UnlCVU1ub2dRQmx1VGdxd2t6SVRDNVZwZ3lRaWNzK2J1MGIr?=
 =?utf-8?B?cGlyb1lvaHhCY2NHdjg1YjJFMko5SjVXbWVVbTkxc0JWUk5LajcwaHNlVGlh?=
 =?utf-8?B?NGJUOG5VdTR6SmExU2VuWlFSMGhnemk5NXhteVU2RitjUUE2RHdieWI5cFJn?=
 =?utf-8?B?bTROTFkzN1N3N2tjdENmT2NEcjBGdjBhaklWWm1TRFpvSnpNM05vSFczZWg0?=
 =?utf-8?B?cGh5TjllM1c5V2o1WEZ5QVAzRjRFYVlzdFZIc3ByY2swcVhFVm9kOUtJYmdR?=
 =?utf-8?B?Z1VVL25EYlh1SWJuNGM5KzVjOWNlTHVVZ3JQZDhLUWlZSjU5RGdqOVdOSXIy?=
 =?utf-8?B?dm1WMEdiM0RlL0JKaDZuU3hzTkRuVmVVOGk1RzBxS2hlVjgwOHhkMjZhL2lx?=
 =?utf-8?B?ZUdOZ1hlVmNLV2U0Kzc0eFpyVDNnVjREbno4NzB5NWJKWkk3T25tUDBSbWNa?=
 =?utf-8?B?OUtNL3ZST0VENWQ5VG53UHcvWXVIb3RhaVErNllBN01sMCtYYndTMnNFNTFP?=
 =?utf-8?B?NmtBWTVuWHN3WE1vRjlTdFN6VDk3bE9wTithZlRRQ2FRYS9DRE9ZZkovZ3Y5?=
 =?utf-8?B?OVlPZ2MvVklxM1NxRHRRVlNzR0FBMUYyZC9PemRnclNOQmhxdTRpNnd2RUZD?=
 =?utf-8?B?eFNyMWl6YUsxTWxoUjVESlZUZ0lFc1hiYTY2dUd0M2xvcnJXQkxwWk9WeUtD?=
 =?utf-8?B?YTA3RWRRMFlwc3hnMHE2SFA5VDBEVldEVk9iTStkOGFqWWU1ejBKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e15dff-9202-4aca-bad8-08df49467db8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:45:21.7802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp9Ie3Hdpf59IRFk+G7wql6b/BH41oXbWHoiBw6088IPSy/xBQxma38NMXtD81oJZE3Xi22babm8DHl0BDNtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------WBA8zeMSQ8X54PQ0yoXICGG5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/2026 6:16 AM, Felix Kuehling wrote:

> On 2026-11-20 04:16, Zhu Lingshan wrote:
>> If a kfd process does not perform ACQUIRE VM for its
>> kfd_process_device, the VM of the pdd is NULL.
>>
>> svm_range_validate_and_map does not check whether pdd->drm_priv
>> is NULL before accessing it, and may cause kernel panic.
>>
>> This commit fixes this issue by skipping any GPUs
>> that haven't acquired VM in svm map.
>>
>> This commit does not return an error code when
>> pdd->drm_priv is NULL to avoid endless
>> rescheduling of restore_work.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 7401b7fdcb57..b5175f346351 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1818,6 +1818,14 @@ static int svm_range_validate_and_map(struct
>> mm_struct *mm,
>>                 prange->bitmap_aip, MAX_GPU_INSTANCE);
>>       }
>>   +    for (idx = 0; idx < ctx->process->n_pdds; idx++) {
>> +        if (!ctx->process->pdds[idx]->drm_priv) {
>> +            pr_debug("GPU %d has no VM acquired, skip SVM mapping
>> for it, please consider acquiring VM for it and perform SVM unmap and
>> map again\n",
>> +                 ctx->process->pdds[idx]->user_gpu_id);
>> +            clear_bit(idx, ctx->bitmap);
>> +        }
>> +    }
>> +
>
> I'd put this check in svm_range_check_attr and svm_range_new (where
> prange->bitmap_access is initialized for the XNACK-enabled case).
> svm_range_check_attr gives user mode feedback when they're doing
> something wrong rather than just silently failing to map memory.

Thanks and the new patch has been sent out with title "[PATCH] amdkfd: don't give a GPU access to SVM ranges when no VM"

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>       if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>>           r = 0;
>>           goto free_ctx;
--------------WBA8zeMSQ8X54PQ0yoXICGG5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 11/21/2026 6:16 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:ccae1602-9922-450f-b5c9-385459a94baf@amd.com">On
      2026-11-20 04:16, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">If a kfd process does not perform ACQUIRE
        VM for its
        <br>
        kfd_process_device, the VM of the pdd is NULL.
        <br>
        <br>
        svm_range_validate_and_map does not check whether
        pdd-&gt;drm_priv
        <br>
        is NULL before accessing it, and may cause kernel panic.
        <br>
        <br>
        This commit fixes this issue by skipping any GPUs
        <br>
        <pre>that haven't acquired VM in svm map.
</pre>
        <br>
        This commit does not return an error code when
        <br>
        pdd-&gt;drm_priv is NULL to avoid endless
        <br>
        rescheduling of restore_work.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++++++
        <br>
        &nbsp; 1 file changed, 8 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 7401b7fdcb57..b5175f346351 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1818,6 +1818,14 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; for (idx = 0; idx &lt; ctx-&gt;process-&gt;n_pdds; idx++)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx-&gt;process-&gt;pdds[idx]-&gt;drm_priv) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GPU %d has no VM acquired, skip SVM
        mapping for it, please consider acquiring VM for it and perform
        SVM unmap and map again\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ctx-&gt;process-&gt;pdds[idx]-&gt;user_gpu_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(idx, ctx-&gt;bitmap);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
      </blockquote>
      <br>
      I'd put this check in svm_range_check_attr and svm_range_new
      (where prange-&gt;bitmap_access is initialized for the
      XNACK-enabled case). svm_range_check_attr gives user mode feedback
      when they're doing something wrong rather than just silently
      failing to map memory.
      <br>
    </blockquote>
    <pre>Thanks and the new patch has been sent out with title &quot;[PATCH] amdkfd: don't give a GPU access to SVM ranges when no VM&quot;

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:ccae1602-9922-450f-b5c9-385459a94baf@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bitmap_empty(ctx-&gt;bitmap,
        MAX_GPU_INSTANCE)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_ctx;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------WBA8zeMSQ8X54PQ0yoXICGG5--
