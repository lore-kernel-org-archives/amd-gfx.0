Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01BCA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 13:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C7B10E2D9;
	Tue,  6 Oct 2026 13:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ur2scY4r";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8EEA10E2D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 13:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpR9HlmNEXNOeo+S8WJr7fVS57nHWIupQG0H//GgOfmxkJcjJ8OL/GoH0yEc6EiKicLm3lLBX2JzgpQVtOHo7oaW1blYqnz90VYjRdGg/AGBrlzMHUOna7Uk6aFPrpXaQShFbxSMt/hd1fREe78aU9I8ZqKX/r1B0Mcb4rM2oD0gG21zQBxi2Icz7DMnID3cqBpnMwpXIp6+pHJdmULJr/Y8IKYrBo/PjG6OIihtj/cdkfWMfX36NXQyHdK/BOCczl2SG55HY5uYeodoqmnu8dV4tw33qZhL+LJ1wqDQ0jB3Qka3GCz7jlz7Qxn1W4CFcxX3F07Du+UxTYXzFn6Fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWwyzabqk4qho6R/DTkEDXSHIAcI2m+VslR4pFGax9Q=;
 b=xBD7G9RmRz7HJ6R6PAMz0K7HfT4C/wy9DQ8HLzPibUFlFwxQBD8TDaZclsKa9gTOgJCvfeivWrb1lSDsXd5MHYAb1gRrwdkEszv1ijH7RNUL3FNYk3rQnsjBl89ajvpAscPCIbb+kgAjstZ2lG7KW5Iry3QODK5ne/LkPT0ZuzAT3j3LpuEIT70hNkMkdqSqbHi7rRgqqkSdZVks70eu4tghJIyy0VAoF0aYaZprrZuLrWSM2QLAfcxtVi0MabIbYCslvEtjofOlHEOUpM1WOS1bE1N07+E/NTVzQ0pIwTPoUeiZ78N9xiAF5QHUIuV0joaq1HCprlNGS4h0+cIFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWwyzabqk4qho6R/DTkEDXSHIAcI2m+VslR4pFGax9Q=;
 b=Ur2scY4rtsDN6L7iAoGmvqIlHjW58rbxKACEjQU6IODsIjuUiQC0rFTbMOY0kaNVmwmMniw9deNS2gowYmnv398HlXQ3zbjqESvCda0My+TLjuTa9Ns+Ada7Af+H71PSWQsrhm5HP3Q6Gok8uigC6A4nrkwWjhHcXtdST3gsBWo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:34:33 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:34:33 +0000
Content-Type: multipart/alternative;
 boundary="------------iZ6jtybFh5nRfZ1R6vT00RMP"
Message-ID: <cdc09891-d062-4956-bfdd-c98ef0983015@amd.com>
Date: Tue, 6 Oct 2026 09:34:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261005203247.1363226-1-Philip.Yang@amd.com>
 <c98c7828-738e-460a-8fed-9ccf4b591240@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <c98c7828-738e-460a-8fed-9ccf4b591240@amd.com>
X-ClientProxiedBy: YQZPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::12) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: a451a547-de9a-4357-7fc6-08df23ae8e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: ai4lOJGtayJbPPSUBqXaOYKAx3vuAWJMnSXedTc4pSW67rF+RX8XarZ1pzFq5gO0/d+bBrDE8VdtncJ1sMid60EQms5pXpBrYfC4nx9rc0p4FwPhIsxOY6pKbtP0HvpM/rEy3xQ8umyWJmekTQ4Z1e5oMHQmlqdAR8hzfu/YpyW2Kl5gaYYakZHZLT4/tpYtQpICGJ7Rz1U08UxPyNLjmBFW5aDuAGB6j1eQpLgksTK8/Tb2Jke/++URQ9K+H3rrCHaa31ysvmlWwqueHdNCuAuG7KqJ5bnEIjI4iqv41fX7da2R6h/8QH2ioqvvIReQN6owigrbEk2wD6AuiSm0XAcAclI4vLh9+M4gV7aOHj1cxYrLPnknMF0AImxrNwKNaEM0P9D4bq0OdvrauhBnVejpL0Zsd2/XWwVhIp02Dgy/Mqonv/dHHg1MBBQxCGe3VKRZMkukA5fiCys5b/Z00A4rVB8NhwPwwPiKlbaVojlTCGsirbTpkKNwjGX9tXiXIWwYLjycOb0rb0WylkCeQCE5CqwjWQ52LfFRt3RVfZ9+NEXZg+zBErIS5ObSuBccVt4+CHa3bA0QfuIBONhS4sIGHveYBwqfqwq38qchzIzIAyq5WH62IedvkD1NRZYrCig9NqAE8aMs0HYuAkCUqrCxKA/BCclvktCgI2LplDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lWMUNZeDZjQnNYRWc4cmtSc0ZOblpJNzh6NzFMYUJiVzd3SG5DdlJLZktF?=
 =?utf-8?B?dnV6Z2RFYkM5a2MybzAwbFpUcUx0d0VYYkJaazFyZllScGJWeWI5N3A0eVFS?=
 =?utf-8?B?aXlaVHlORlV5UFg0SFJLKzJKK0pxMk1JQ29hQ2M5bTRQRlIzMncxM2t4dW00?=
 =?utf-8?B?RjA1Rmt2eXdyazhpeTg2ZlNFZ0YvSlVEOFZZTjNZTTdWZDhIS2hKdFhGb1Iz?=
 =?utf-8?B?MUFVZkhMYUxLZktQNGJFN1MyOVY4WUdJNWRwdWxOL2tBSnBMNlZFZzBYUDg5?=
 =?utf-8?B?TE5aa2orQmdmdDZnUFE0ZHlZVkhCaWNkTG5MVEppbGhjUHJ2MzQ5MHFHNUpj?=
 =?utf-8?B?ZzE5UDM5d2U3YTl4WWtDaVlUcTRqWDc5aWgvbFJJQll1N05KMUNDa3VWOWJV?=
 =?utf-8?B?RkVJbDNwYzFlVHFaNUtaWFd3bHFvYVhKOHY3aW1yU0JLaVZMbkxOQ2RUb3U2?=
 =?utf-8?B?NElzRlRyeERmbVBCcUQ3VkhpTGtnd0xKSXNSZDIvb1VsT2lPSnBWTlM0NDNJ?=
 =?utf-8?B?dUxybDZTVko1NWR0SVZBNC9IZHhsMnZWaEJQT094N3BOMXZPYW1qQytlVW96?=
 =?utf-8?B?ZnFrV3cvbDd4WTE3QXNZZElQczFqa1ZqOUR0THY1SHN3eU5Sa0RrcGpTSUs2?=
 =?utf-8?B?T1BWUmhtTTZIc0RSRDdQeERWMGI2ZGE5eGU5M1g2NkcyMEZwUmFlMnI5cElX?=
 =?utf-8?B?ajlYSmg5OVlydkYvOTM3dEpIeG9FU01oaS9WSFd1ZzFJeEhSTkdpdWUrQ2Ri?=
 =?utf-8?B?NGEvQ09Ea1EwSXpUTDBWandJOWN6MVIzbVF3cE95Qkg1RGlLdER5UW9LaUdn?=
 =?utf-8?B?bjRuSWRLRzNqeUdRd3NhZVk5bHdnMURkWmNtQW5qOWFCTzB0aUtaV3VWUERa?=
 =?utf-8?B?MXkxa0hEekFQRkNJVTRyb2NEcUNrM2Q1Q0JvdFQxMHRpeFNmQUo5a1NiNjFM?=
 =?utf-8?B?ZHRhcVVCWVVqRUl0ZkN3Y0krS1VaZ1FvRVI3ek5yckVRbHZMSFl6VmxYSDVy?=
 =?utf-8?B?ajF5WExZRWcwZkdBM09JRXNDN0F1dkZVaFNKbGNBZ2haeVU4bEZ2VG9XZE5B?=
 =?utf-8?B?VTlzZ0kyU1lBMmFHTjI4aUJyZUIrcG9sVGxySlVqYmRDQmk1WGFhSVk5VW4r?=
 =?utf-8?B?dnFmMS9tdCtmbzdTQTFkN25leVo4OUNvV0k2SEhYenl0SlhYdXVlcmt4YzBl?=
 =?utf-8?B?MTRrUVBESGI0TTJRYVZrOWdjNFNTRDZqczBBV3NWSmdiR2g5cmdNVjR3cTR3?=
 =?utf-8?B?UTJxeDgzZjlqTnYzTGlscW91U1FvcDJRcURja3g4SDEwYkhZNVo5WXRxOFov?=
 =?utf-8?B?V0srbjZnWDhCcFVweXZqMEczNVFVU29FRXpFWTBIcE5mT1lUMU5MbVBZS0to?=
 =?utf-8?B?aklTSG9KRkF0SWM0eENlNXU3ekhFOG82dlgzUFBVTkZUZXJUREUxYjQ5ODhv?=
 =?utf-8?B?Wjg1MS9mTkpLdC83Mk5TWjUvTXdIOW9DMStzcnBFZGNMSkd3SVFnaHRjUWdN?=
 =?utf-8?B?YkJzTUhNZm5FQVNpelFiSVdoSndTbHZVd0VSNE1aM0c5WTNKY21kT2xqVnh0?=
 =?utf-8?B?VWFsRndXV0FLeGsxUDl5dHJFVDFFNUltVzVjUUhNSzBnMDNQcDQrZGxJcXBw?=
 =?utf-8?B?by9SdFd2S3B6dUFCaDRQZjBnQ2txUm1FWGY5ZUZERGUvRnFlVHhtRGkxQlg1?=
 =?utf-8?B?ekx2Wk9TWXdHSm96VlQ1emtxMktEWmlaMVNRSEtXbTB5ZGdJeTVaejZnOTVK?=
 =?utf-8?B?c1JoL3FsL3Zjb3VTd3l0SXl4bTNPaGc1NmxOK0RYcWd0TWVzMU5IKzR4azNQ?=
 =?utf-8?B?dDZHVzhZV1R0Y3lKOFF3ZHU0MlQ4VUVraWV1Vkg3c3d3SXZiMHg4Wm5NWWEv?=
 =?utf-8?B?ZDk0S29VaXBnZWh3bHd6TERIZCtYNGJMTW5lZEZmc1d4K050dElaaFdMZUhr?=
 =?utf-8?B?bmsveW9tQnJSc2xRSy8rTGNidUhBWEh0YUF0UGJPYUVzR2FXTWN1Y1pKM1Rs?=
 =?utf-8?B?aGI1NkFoK1NTMjV5M0NPQVlpN2xTbzdxU3ZqWmhnaHdoSFU4ZjcvM1dvblZK?=
 =?utf-8?B?OEhoK2lLV25TVFRtY0JjM1lPMDIzWkF0ZWE2VjAydWxxdG1qaEVzRGRpeDRq?=
 =?utf-8?B?L05rUENLcmgzYytNTkxDOHlvV05ENHYxMnVEWlVQdGVmTTV6TnJnazQ4cDBY?=
 =?utf-8?B?QmNWbHZEMW1zUDQwRjV2NjJlMi9QS2VHM2Q4V2V2akxpRmMzc0U3TU1PQmV6?=
 =?utf-8?B?c2MvNzJURWx3YTFvcW9vdSt1Z0JSY2VjK1hJbGRMVVhqSTBLRXo3c2REMngy?=
 =?utf-8?Q?ETsEUtaj93fXrlreYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a451a547-de9a-4357-7fc6-08df23ae8e8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:34:33.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqed0dKBP5mPILilqBgGiQOSBlZu4jEHJIGbk8bOggLegwWZ/atrjPxo3CLjCXGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
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

--------------iZ6jtybFh5nRfZ1R6vT00RMP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-05 17:05, Chen, Xiaogang wrote:
>
> On 10/5/2026 3:32 PM, Philip Yang wrote:
>> prange->svm_bo stays set after the range drops its reference in
>> svm_range_vram_node_free(), it is only cleared later by
>> svm_range_bo_release(). Taking a new reference based on old->svm_bo can
>> therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
>> pending, leaving the clone with a freed svm_bo.
>>
>> Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
>> it is still alive, same as svm_range_validate_svm_bo() does.
>>
>> v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
>>      sharing the svm_bo when the range dropped its own reference 
>> (Felix).
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cfb428c72686..7ffc31df3b87 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2158,14 +2158,19 @@ static struct svm_range 
>> *svm_range_clone(struct svm_range *old)
>>           svm_range_free(new, false);
>>           return NULL;
>>       }
>> -    if (old->svm_bo) {
>> +
>> +    /* old->lock keeps old->svm_bo alive while taking the reference */
>
> How old->lock can keep old->svm_bo alive? This lock protects old 
> prange's data from accessing.
prange->svm_bo and prange->ttm_res set to NULL under prange lock when 
svm_bo is released.

So holding old->lock while taking the reference guarantees we read 
either a valid svm_bo pointer
or NULL; the structure cannot be freed between reading the pointer and 
kref_get_unless_zero().
The lock protects the svm_bo pointer, not the svm_bo lifetime itself.

Regards,
Philip
>
> Regards
>
> Xiaogang
>
>> +    mutex_lock(&old->lock);
>> +    if (svm_bo_ref_unless_zero(old->svm_bo)) {
>>           new->ttm_res = old->ttm_res;
>>           new->offset = old->offset;
>> -        new->svm_bo = svm_range_bo_ref(old->svm_bo);
>> +        new->svm_bo = old->svm_bo;
>>           spin_lock(&new->svm_bo->list_lock);
>>           list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>           spin_unlock(&new->svm_bo->list_lock);
>>       }
>> +    mutex_unlock(&old->lock);
>> +
>>       new->flags = old->flags;
>>       new->preferred_loc = old->preferred_loc;
>>       new->prefetch_loc = old->prefetch_loc;

--------------iZ6jtybFh5nRfZ1R6vT00RMP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-05 17:05, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c98c7828-738e-460a-8fed-9ccf4b591240@amd.com">
      <br>
      On 10/5/2026 3:32 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">prange-&gt;svm_bo stays set after the
        range drops its reference in
        <br>
        svm_range_vram_node_free(), it is only cleared later by
        <br>
        svm_range_bo_release(). Taking a new reference based on
        old-&gt;svm_bo can
        <br>
        therefore hit a svm_bo with refcount 0 and
        svm_range_bo_release_async()
        <br>
        pending, leaving the clone with a freed svm_bo.
        <br>
        <br>
        Use svm_bo_ref_unless_zero() under old-&gt;lock to only share
        the svm_bo if
        <br>
        it is still alive, same as svm_range_validate_svm_bo() does.
        <br>
        <br>
        v2: use svm_bo_ref_unless_zero instead of checking
        old-&gt;ttm_res, to keep
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; sharing the svm_bo when the range dropped its own reference
        (Felix).
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
        <br>
        &nbsp; 1 file changed, 7 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cfb428c72686..7ffc31df3b87 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2158,14 +2158,19 @@ static struct svm_range
        *svm_range_clone(struct svm_range *old)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_free(new, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;svm_bo) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* old-&gt;lock keeps old-&gt;svm_bo alive while taking the
        reference */
        <br>
      </blockquote>
      <br>
      How old-&gt;lock can keep old-&gt;svm_bo alive? This lock protects
      old prange's data from accessing.&nbsp;<br>
    </blockquote>
    prange-&gt;svm_bo and prange-&gt;ttm_res set to NULL under prange
    lock when svm_bo is released.<br>
    <br>
    So holding old-&gt;lock while taking the reference guarantees we
    read either a valid svm_bo pointer<br>
    or NULL; the structure cannot be freed between reading the pointer
    and kref_get_unless_zero().<br>
    The lock protects the svm_bo pointer, not the svm_bo lifetime
    itself.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:c98c7828-738e-460a-8fed-9ccf4b591240@amd.com"><br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; mutex_lock(&amp;old-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (svm_bo_ref_unless_zero(old-&gt;svm_bo)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;offset = old-&gt;offset;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = old-&gt;svm_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;old-&gt;lock);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------iZ6jtybFh5nRfZ1R6vT00RMP--
