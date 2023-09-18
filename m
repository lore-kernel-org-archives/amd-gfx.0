Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849C2C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 13:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC8B10E010;
	Mon, 18 Sep 2023 13:27:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394AA10E010
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 13:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhOfnaZ40UWRO49ACLMdiweI1UXrngExVcOY7SrbYyqy4XvdR1MAXHY9/tFJFcknA68iwK4lqiPH58bGqJtG3/dIM0iO4j3o3wcqENYyEb+bcYUoBauwZUnrPFfB2ul8UeRFqySNgOZUGzAulWuTDhpKWLq57ybDRwVt6XKLZw5ChZp9LRg9DjDBeZc3KuKPHV8jjKAxfAlFyEihifmyw4mxWzYa+FMVEo9rwubjdk4HCSPRN1ocFUmShhSgf4Zx+fDk7079I1cWCtxEcB7Xih6nv9Odah5KHR5G52xfhh3B7/jADxJ2Tg39J/bApeEozzkkVlLmyVBkr2l2Kw/9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmy7KSb+OneiWv9b0d87tyFOoDzDpb8Yec7ae8lfHH0=;
 b=KUVtXhzaW0hLZa9tAZpFYQd0fp01JNR8PVA33g8HKWbtinFyZIzGs4Ri2nBYQXWOND93IinElEco5QKqgYZXIOt9dBw5gE4B2ezQ2iC+Fa2UqqhM4bWI10OQO7nAxsSIFw3ntftuP7jd1HtOmaJWGBxod8q4CT9PP2WQ9msXBAnf1PQW9gVIJiBfMVNA0By9bt5tjLtv5rC/fkeaQ7sI2sXwPAcdLKefQAFO6uSllnSZjlC5plMJe0vo3uLEHqexGtOjKUwUw62rlUXDlVRsI9ffNMmDBT+xgUhBMzz5uMIEjIdyOetjWVCbjqBr5IWVvp2WDcTrZ1Sdi7fHwUsKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmy7KSb+OneiWv9b0d87tyFOoDzDpb8Yec7ae8lfHH0=;
 b=hRUl3FF0Ig+DHBwBN3TYNDoPZxFuQfdky2McqiL09C9HyUwRAbd3W0wZObX1VmqL/xqs1I7waSgvV8jov+ArfwJIGEGLfNIqnNUJAxzfCejTkVSLlmlJGes3aVd4qdCo1gSVRyMYD7jx4FAOA+GBIXM7g/eZ5DHPle6tDOMycDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 13:27:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:27:25 +0000
Message-ID: <b47831bc-ed6a-a316-f9d9-205abab8edc2@amd.com>
Date: Mon, 18 Sep 2023 09:27:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230915132804.20813-1-Philip.Yang@amd.com>
 <28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com>
 <5ee60075-10a2-e3d5-4e5a-538fca90bc58@amd.com>
 <a01a8dd1-c4b2-b632-1116-40836d2a5007@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a01a8dd1-c4b2-b632-1116-40836d2a5007@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb935d6-6617-4ffe-11dc-08dbb84aff3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is9YnXSArQ76oyvZC3b4vVbSjWTIbWlHmqy9HyFncGfnHRvQ6QJ46stBSYbg+C4mUrGt1rZdFL+iPqUxo6YdR8nSgXZV7Y3f1jDtEnPMaR32kbOFDKB/t9xHeMdsAlqS4dbIpY0w8gxfpYfbFr6cbpU/JJD3bVUzthNvGYCTvofntL86sj6Ertfu6vneQbSXdCxroQQ72qnD4tmAtpbQNFguaP7bl26LF/+K1vsb2X0W/xqbkuw47ybg9siutvUDBvPjEc3hqtbZ8hEcUnkv3clAs5RzzuQQ4w32UEjRZBwHbeGzzC6sDtg5RCaop3Hf3C8fLuZeKblrawJbB8u/BNp0fy/0H4ZS2fBK8zVkZ0xThKIhgXtYOWV2m3fdlz9We/+yVqmF3NVTwsQfV0vzRJHcFaKGLWPw5MktY9Vkz4lzcsNN0rnQPcLi5e5ApmbuuhZpgGXphXdJozYmQZZn9GHR8OLAAA6EZU5BiBFHCFxXonU5ZnmamNPIy6nnopjhNX6aSCnwyNc57V6EX+ifpreVlm3dA4Y7UJAkij7PNVc4K2l6A19mEI1kkwtjkjh4KvWPqz9TYwjMH9Z/J1+cX4w4AzGezlBVL34s06ITKlrG1zQ0QRjjDBsFruBvcbT6PlEgzkLyUk+PC83dINOvDY6b0XyIzQD03mO4w/1k6/XPJeVSAwPEoUawvMC4zt+c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199024)(1800799009)(186009)(15650500001)(316002)(66476007)(66946007)(66556008)(110136005)(31696002)(31686004)(38100700002)(2906002)(36756003)(41300700001)(5660300002)(478600001)(6666004)(53546011)(6506007)(6486002)(6512007)(4326008)(8676002)(8936002)(83380400001)(26005)(2616005)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09MS0QxYk1pZllBRFFLcGlZS2paRDJhS3FNdHRoTGgzWXdkbzhqZUxuNGtw?=
 =?utf-8?B?cENZK1V4bEdLVFdIdXZoR3B3RW5UM1VscENZVDIra1hRdnZ2NVFLM1d2Zjl0?=
 =?utf-8?B?TytCWmUxcGM4d2NVODJ3TjN2U0ZybEdEU0xBVEd0VHZ6d3hKMERqQWErNGJk?=
 =?utf-8?B?QTNqRWMxREtnUHJVVUZDVEJvMXJBKzRRQXJUNGp6T2QrV3VHWTcxK2M5REJK?=
 =?utf-8?B?bTlWMVRCTnlTR0kzSUJSeEVkSFoxTkdJY1JvaHJIVytPTmxkYmQ2ZXgxSG1s?=
 =?utf-8?B?Qmxvbjdzd2FRUW1mQ0dZdmJHK0ljdk0yZjJJT0lSTFI5ZjRRN2ZDb2hJR21R?=
 =?utf-8?B?MGorUG9VdmZEZ0J3VzQ1UGJ0Rm15a29KWlphYWw0cXpRR0NyOEZBZ3VnQzJH?=
 =?utf-8?B?Zm5BcCs5TElqWmVtcEhQVE9Dc20ydEVHK2xvMVBxTGNsY1NKazJPOWpKZngv?=
 =?utf-8?B?Rml2MVNibkFNZG13RFdPSC9FbEJ0M2xLbVNNRmx6U0lwM21NVUZSUkpJRlBw?=
 =?utf-8?B?Wmt3ZWxIbUxDK2paRXh4Q1ArRXpEdUZRVHZUZ2dDek13R0NXV1k0YjEwekRG?=
 =?utf-8?B?OFA3Vks1ZlNsVno0K01sVXo5Zk9SLzNYTC9XMkN2dVIwVTRrK3J4TjBZbHFG?=
 =?utf-8?B?Nk9zM2VNV0FJVFZydEtzcUVvaTlJeGU3MHdZdUpsTzlET1c1UlhCTUhOWmlr?=
 =?utf-8?B?elJEOGU4RFVJY2l4QmpNTzh0SFgwZVR4bHdhNm9NMUxrdjBvZFhHN1BFUmR4?=
 =?utf-8?B?Uk1RZTZmMCtvTGplTzNjazhDaElNdlIwRE5lUFVYc3hIcEQrRjFSUWpUNURq?=
 =?utf-8?B?dXdDemFRS0ZTQmpJUSsyV0VjMzMwaStJTDNaMC9NSzkxRzBqbGJ5RHNoYXFE?=
 =?utf-8?B?bWlMa1Fzc2g1RHRCQkcvMy90M1dJbHJLVzBiQmVLK09CVnBHSDZBZ0IxQnVw?=
 =?utf-8?B?Y1lRQWpFcVcwLzhiaEJhSzBzaHRGaElpYmNGbVlwVXhkYjR5TUdkSm9KUFhV?=
 =?utf-8?B?SmE4REdNbFJ2RTB5ZXZKdlR2MkMySHNET2g3eitBYXRaY0J6dElzQVpvYW9h?=
 =?utf-8?B?YUw3ek91T3VwYlk0eUY2M2RtSC85WVdvRUVhYmJxbHBhUkw3SjZ0QTRMQXhN?=
 =?utf-8?B?cWpydkt3Q2wrbmRvQUZEMDdUMlJObTROV3NOMDU4dWJNcWt4NnMxL2FIQ1pO?=
 =?utf-8?B?eWpWK1libHFQaDYreWw0cG1HRHlqckppSTdqTjFuY1B2bXFaM25IQzdzMzRC?=
 =?utf-8?B?UXZMejVubFYvQURvSUZXYmlLWDM3UFdkNmhGcU9heGFaaTJZOGFqanQ4R1BD?=
 =?utf-8?B?V01LN2lpRWRJT2p1ZU9jbDN4TnpKYmE1UnRNT1NQRFRZeTBCU1pxcG8wQVFW?=
 =?utf-8?B?cEZNV2lXL2dZRWE0VzE0aVpBN1RDU0I2NEIvQS9IYTRTaFIvb1VoaFVwVHIv?=
 =?utf-8?B?RnN5bHpKYXA0R1I2MjNtRThTajUxZjdyNTluckZrRkJHWjNDc3ZYdE5yZks5?=
 =?utf-8?B?UGhQYmc1U2t6SkNjUi9XVVBydDgrL2RqaVMzZFd5VDFwZkwyWmVZazdwMndk?=
 =?utf-8?B?eXlJb3JFYWpFN3V4UzZKOW5yYUFMeFRJZEcyejlWc3JqSG9DdkpFUFRBdWIr?=
 =?utf-8?B?Uzc4cm9jZ3EvazhXditDWWV5R1dRdUxraSt6aUlQUnh6cWRURXFwZnU4QXVU?=
 =?utf-8?B?bXJkZUlzemNmUHZPc0RnZGlRTjQzSkh4STFVKzg0Wkd6YldHa2V5UFhRbmRN?=
 =?utf-8?B?NmdsYUVkblV3U3NqRTVYclRIejVjaHR5NEI4dmNpYkZnaDlzeVFiVTc5Mng1?=
 =?utf-8?B?Y0hEM2dLRzVCdjNOQUpDdk1OYVFtUksrMEZxeTYyeWRFZ00xajk5dnBuK2c2?=
 =?utf-8?B?eXF1MlBYVytYZXVKdnFkY21GbzM4VkpPSlMwWVIzNkwvZnRwN3lQU3dEK0Rw?=
 =?utf-8?B?TFlkSTI4QndmaU5LeEZRb1ZJcXBXRG9UL3BtU1BuR3FZaUxMZmwvVDlSMTNV?=
 =?utf-8?B?d2g1YUVvVEp0YlRUMkp0Mmxha0svdFM5WDVIZXIxQ2tQU212QjNqS09JWUE4?=
 =?utf-8?B?c1hMbktvalA2aG1nRjFlSTZXQ2xoMExPVXZDdEh6dG5qaEltUVZkbnppOC9l?=
 =?utf-8?Q?mvYM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb935d6-6617-4ffe-11dc-08dbb84aff3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:27:25.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfIArhOMHqrCDH9PlSg/eGMSYqh4Kt8lV4x1EWv0VXy6OHZ1XsuL4bu/C4leKKGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-15 17:33, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a01a8dd1-c4b2-b632-1116-40836d2a5007@amd.com">
      <br>
      On 9/15/2023 4:20 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2023-09-15 17:06, Chen, Xiaogang wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 9/15/2023 8:28 AM, Philip Yang wrote:
          <br>
          <blockquote type="cite">Caution: This message originated from
            an External Source. Use proper caution when opening
            attachments, clicking links, or responding.
            <br>
            <br>
            <br>
            If new range is splited to multiple pranges with
            max_svm_range_pages
            <br>
            alignment and added to update_list, svm validate and map
            should keep
            <br>
            going after error to make sure maps_to_gpu flag is up to
            date for the
            <br>
            whole range.
            <br>
            <br>
            svm validate and map update set prange-&gt;mapped_to_gpu
            after mapping to
            <br>
            GPUs successfully, otherwise clear prange-&gt;mapped_to_gpu
            flag (for
            <br>
            update mapping case) instead of setting error flag, we can
            remove
            <br>
            the redundant error flag to simpliy code.
            <br>
            <br>
            Update prange-&gt;mapped_to_gpu flag inside svm_range_lock,
            to guarant we
            <br>
            always set prange invalid flag to evict queues or unmap from
            GPUs before
            <br>
            the system memory is moved.
            <br>
            <br>
            After svm validate and map return error, the caller retry
            will update
            <br>
            the mapping for the whole range.
            <br>
            <br>
            Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle
            errors from svm validate and map&quot;)
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18
            ++++++++----------
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h |&nbsp; 1 -
            <br>
            &nbsp; 2 files changed, 8 insertions(+), 11 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index 5d7ba7dbf6ce..26018b1d6138 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct
            kfd_process *p, struct svm_range *prange,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !prange-&gt;is_error_flag;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
            <br>
            &nbsp; }
            <br>
            <br>
            &nbsp; /**
            <br>
            @@ -1724,20 +1724,17 @@ static int
            svm_range_validate_and_map(struct mm_struct *mm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap,
            wait, flush_tlb);
            <br>
            <br>
            &nbsp; unlock_out:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = !r;
            <br>
          </blockquote>
          <br>
          I do not understand why set prange-&gt;mapped_to_gpu here? It
          handles one vma, not for all prange. If there are multiple vma
          and first vma handle is ok, and second vma handle fail at
          amdgpu_hmm_range_get_pages or svm_range_dma_map, you would get
          prange-&gt;mapped_to_gpu be true, but only part of pragne got
          mapped, right?
          <br>
        </blockquote>
        <br>
        If all vmas map to gpu successfully, prange-&gt;mapped_to_gpu
        set to true, otherwise, prange-&gt;mapped_to_gpu set to false,
        and then svm validate map to gpu return failed, the caller will
        retry if error code is -EAGAIN.
        <br>
        <br>
      </blockquote>
      if second vma handle got failed at amdgpu_hmm_range_get_pages
      prange-&gt;mapped_to_gpu would be true since the code would jump
      out of the loop, right?
      <br>
    </blockquote>
    <p>You are right, the goto error handling inside the loop jump out
      of loop is not good and will cause trouble easily later, I will
      refactor this function, send new version.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a01a8dd1-c4b2-b632-1116-40836d2a5007@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          <br>
          Regards
          <br>
          <br>
          Xiaogang
          <br>
          <br>
          <blockquote type="cite">svm_range_unlock(prange);
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr == end) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr == end)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validated_once = true;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp; unreserve_out:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(ctx);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;is_error_flag = !!r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =
            ktime_get_boottime();
            <br>
            <br>
            @@ -2106,7 +2103,8 @@ svm_range_add(struct kfd_process *p,
            uint64_t start, uint64_t size,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = interval_tree_iter_next(node, start,
            last);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange,
            nattr, attrs)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange,
            nattr, attrs) &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start ||
            node-&gt;last &gt; last) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range
            and its attributes
            <br>
            @@ -3519,7 +3517,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *next;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_mapping = false;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool flush_tlb;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, ret = 0;
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx]
            pages 0x%llx\n&quot;,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid, &amp;p-&gt;svms, start, start
            + size - 1, size);
            <br>
            @@ -3607,7 +3605,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
            <br>
            &nbsp; out_unlock_range:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            mutex_unlock(&amp;prange-&gt;migrate_mutex);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dynamic_svm_range_dump(svms);
            <br>
            @@ -3620,7 +3618,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx]
            done, r=%d\n&quot;, p-&gt;pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;p-&gt;svms, start, start + size - 1,
            r);
            <br>
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret ? ret : r;
            <br>
            &nbsp; }
            <br>
            <br>
            &nbsp; static int
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
            <br>
            index 9e668eeefb32..91715bf3233c 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
            <br>
            @@ -134,7 +134,6 @@ struct svm_range {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validated_once;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_error_flag;
            <br>
            &nbsp; };
            <br>
            <br>
            &nbsp; static inline void svm_range_lock(struct svm_range
            *prange)
            <br>
            --&nbsp;<br>
            2.35.1
            <br>
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
