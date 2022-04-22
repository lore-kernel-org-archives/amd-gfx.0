Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B241C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 12:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D9310E61E;
	Fri, 22 Apr 2022 12:54:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A361510E469
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 12:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gii+xQTdiEipO3qWVyZ+onWD469M9llILLo39DFBAt0YX2vEIam5Mr7hgWJbVNc7cm12O7oNXF+lbTbW5Q5HroGBzF1UF8xgS89veZyo4fwLAlJFALwmiY3gUHT7NqDnfWfbhV8UfTK8JvqLKH//0cgZUlT7myaIo2076fDGFnmhpicv+TDOceLWIpJo+o3Wi3IVE/5lMNZFyQH8HHlgbGXWYeh/gdmY6rHGE0SYd1gcRYcHCZvfyiU3X10oAVN8dTAvGvm9FwYAMuj75QEgqepc3LP8UiqWSvrq9/CZB7amGEGHPqJ5JoTIfLfBOwsw0Hc9BDMstW1dd0MCxsnGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glb8ck+2ly53XmRU8xV3gsWKRvHor3Zw7lTjiDJ6BJ4=;
 b=CMag727CFzaPG5S1FBTc0YXlkbmNwTn+mtT+QVXLC7ZRX2H8f+qlO+BkacDE3/9kituvl5+gYaj7Iw2hHs4kH1nWRm8ZhJllphkhczX5BJUtzULIvTc0itIkClzIeL5GLT2vv4GUevsWAX/enfNi0mxrSZPX5W17hY7nZ6DsdAYPlyfVx3/SaT/Y9/G30A++416LLz6Q0FBcF9iCUpSMrn8Q1hhTNCEhPAm5fDiriVrkEKUlldDEAfQKoDMskUx/kJQWP8yNxT7ktA9bukO1Vzk6PDg1n6KCFu6hwQb3q/JDhEOm7jNDLMIeIRGDwhvFDobdyGKqAaLPjbXw52Ga1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glb8ck+2ly53XmRU8xV3gsWKRvHor3Zw7lTjiDJ6BJ4=;
 b=np1MGmmCHq2JYD70POlTf+2+7JKdOp6EfTQtPZo/aAkPy5Ge0pi4MdaC3vga6QkZuUhzKrQMXZjwVni2LE/nEoFxxhWJMtnztSaeypRY1PMd3Y6WldR0DSKmw0CotWkSfBpIIdm9DX3JQd3dAHdvF0Ylgd8Ba34DRO6uAz/ovXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 12:54:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f88b:ac30:de18:39df]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f88b:ac30:de18:39df%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:54:44 +0000
Message-ID: <98a0aa88-dfa5-a3a2-5b4e-b13b7f7f9138@amd.com>
Date: Fri, 22 Apr 2022 08:54:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdkfd: Update mapping if range attributes changed
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420004742.8780-1-Philip.Yang@amd.com>
 <20220420004742.8780-2-Philip.Yang@amd.com>
 <8c272923-ddfa-9151-4efe-cf8127ea995f@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <8c272923-ddfa-9151-4efe-cf8127ea995f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:610:77::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7f918d-41af-4041-4a9a-08da245f45e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB446856518324C742FC82F566E6F79@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyYCsonqFG+t0kp4vwM2XKjauNt0z4JdiGWlJ31/dWBxUj+4xqlE3t6Wa59j2e/7U7NwEkkJfbTEtGHs4yBbR6dfC6iCUreUUYPB9krDlL6D1Y0LGc7CJZTEtTgKo+2qkUzsvW1Y+jG8/jctBrcUksBuT7rMdIa+nIu7WfbDQMaJaWS4kQ76O+wvonBQ3PVR9O7SHFYHDAHwgPMDL8FbQh+GlVBB1TtYEswSu9AZmw/PSxlo/I8hgqEcJqpaBDPhrspgprFmO/Fxqn6/TBjxz4Ieoy7qx9o148b8wFNqdsZcyrL3k9GqlubI6SPTUVCGys0ArYc9qMVnrnIOgVVIow9p0NGY1hHZhtRLODRlVLriiP0FJMZCMA1/jgfqghKUMXlima6oa4AwHLIxRpM29LF8zv4ELXMnP/S2csq2Hai7i600Prpoc3svqLLOW6tQm22gR1ptAWrv2LG69sBrPdRGRX5VCenxdiyWFauViK4C///14VMNJSV/U5swsL6+Xr/IXofvy3qAe2wt+AAGPee3/m9s2JuJ1EJFM9Q/NUi6Dz1c7nm9iVMvg0yvTAhSiEvVMr1YA4FjmoBEk4aWa0leSiSKI/9cd0h/iqecwbdAaTPr6qShFQV2aUvytNOaSpD0fJzdJJMkD2Ge9YMtbist8zFmDnCB02u7YotC+2UMVkmGnUlYDw+bHede2x/tRln0arU91s8EntUw7/V3twR4iom3z6sOBUTdwbd+OPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(66476007)(8676002)(186003)(66556008)(8936002)(5660300002)(66946007)(6512007)(15650500001)(6506007)(316002)(2906002)(53546011)(36756003)(110136005)(31686004)(83380400001)(26005)(6486002)(31696002)(508600001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smt3QTRveS9MVjl0bHVvbzl0TG1OVy8rc21iSUZPVWFhQWpjOW1GaG1pTkJI?=
 =?utf-8?B?MGFtQTgyQUphaVhvaGJlNitrblVuRlVyVEdPY0RtT2N6Q25lWnY3bDJRVEt5?=
 =?utf-8?B?TnpZbnhJeVJXNndnUDNZUHhTMXN2dkdwQTZEbTRGZU9KdTdhV3pKT05jZFZS?=
 =?utf-8?B?eDlTM0Y5RlpURXJjNWxnSUFQT3VKeUhGbUcvbnFReDFmcGVXVURiRkUvd3ZL?=
 =?utf-8?B?Nnd2WVFkdkZ4NGhCUEwveEp6aTRzcE1SMjdLelpCellacmIwNnZoMGRabC9Q?=
 =?utf-8?B?YXMvaXJ6WFhFQ3BjN2FQTHNlRW93L1hvcEpYSHJNWUQvTlRGRk00SE9mc096?=
 =?utf-8?B?cDJpZzV1MHBKelR1SktHbXZQcXFuTmNjeCtPTW43d0ZzSUJDdEIrRmhzY1pt?=
 =?utf-8?B?bVArWEl2ZDVZMjdqUy9WWWp3Sm5UUjc5MFZ1WGJtQ0tVS0VCNWw0TTFxRzdG?=
 =?utf-8?B?M3FhUUVaVkZvQnNxQnROTGR2ekhIc0JQZzI4ZUIwM1NKWjgwTmxoRDc2cWtH?=
 =?utf-8?B?T0xlOU5WK3pCZUtYTnFVQ1lTWXM5WXNhS3k3YnJFc05oV1BwTlY1R2ZWV09m?=
 =?utf-8?B?bmU1K0w2MXJJVkM1elFxK2g4ZVpZMVA0WXpHQmh0QzVScnk5NGRHcjdhcmx2?=
 =?utf-8?B?UUg5S2w3eExtOFZ2VWJiYVl5ZnVTNWdXOFlzNnlrZHRmUnNTekdCUklUclNw?=
 =?utf-8?B?d3VUV2UxRmZJZXY4bXA1Qko1L3F4RnZEVkRkNCtvSmtsNjFzVE9TbVE0Y1lk?=
 =?utf-8?B?aFd4dmFzSUdrcm16Y1kvU00vNEM3QVVhd014aFpSR3VmNmlVS2RHTEU3b1Zw?=
 =?utf-8?B?Z2Q4RzBlR2FSbGYyNk9sUkdIUk1paUhKU2NmSUtVcVBrTlV1WTArV2xHWFQ1?=
 =?utf-8?B?WFNReDQvVkRUTXNjQ2s2SERhTXc5a3dJd2p0aVkwNE1mMVRDZE93UGhzU2JV?=
 =?utf-8?B?dmpTVGJMNlJLYWpITGlETFVOcHFIY0tsWjNiaUQ2QVd6eFd4RTg2ZU9HaXEy?=
 =?utf-8?B?Zlc0eVNJWUlUbTRuQ1BNR25BZFg5cWlBVDFTc0M2VmZNSjdlaWNRUVB5b0xH?=
 =?utf-8?B?cUY4a0NtZVFmK2YyL1c0R0VtTDlzQlhkc2N5aURLT0Ewa2xPc1ZMM2c5cEIz?=
 =?utf-8?B?RC90RDNNZzJxWnJIVUphMTBUczJ3MFp3MUd4dVFseGR2NG1QNytBdVVraGlD?=
 =?utf-8?B?T1dVSzY0eU5nTUtDOUxkbzgwZitVTWx6VWg3QTJJdkhSU1FJTFNOd1B1K25F?=
 =?utf-8?B?VmRpS3JXS3B2Z0kxaGJyMSsxMUpJNUFnRU5XQmZRb2Z2eFJqUjFLcDhMQ1pS?=
 =?utf-8?B?R09RcEVFeHM1ZDZtdDExaXRRWjlMWkdJL0xVMlVJM0pHL1NsQ3N3dHVDRlpQ?=
 =?utf-8?B?WGVSYnR3MmxzWGN6Z204SzJEVk9aUXdMSCsraFhmUnhKYWtVVVJIR1NsdXBU?=
 =?utf-8?B?bUJ6bW01aVhmNTB1YUhXTzl0ZTc4T2I5RVc3dW5UOWZUQ1lvK2NyU3RQbTBY?=
 =?utf-8?B?bTRtQ2FjM2srVzlDR29FdTlJZWZDZnlmSDF3THo5MktmbDlUL0QyNlg0OXpn?=
 =?utf-8?B?RUVaZXlPK2ZRNTlYcFNkUFVYOWV3TGpXYnFFY0dGZ3Yva2hwZHJ4QmVKQUNs?=
 =?utf-8?B?VzM4L05McTNZWEwvbkRNWXlxZmtrWkVFOUYyWkxMeTJWOEt0eEtKREowUHVT?=
 =?utf-8?B?T201ZnN6VzBUWVJNS25vR05xNDBhRnRyVEJpbnZTaGJtbzFOS0cxRWRZWFpJ?=
 =?utf-8?B?ZWlNNTcwWWFFaE0yMmczUTI3S2liSGtJU3FCTks0S1J6dE9wd1hJQ3JMR0lL?=
 =?utf-8?B?dTRUbmsxd3F4U3UzUlFCWjdrTzZ3MUhmQldGcnc2eVk3UXF0dWlCY1MydmNz?=
 =?utf-8?B?cTcvZzhDNUlyMDljWGJWdVBlbzhBaU14UXJsZDZNdXJFRVZNMVFVNElOUC8z?=
 =?utf-8?B?SmR1N1VMWG16QmhjRXJBT3RxZGJqODFCenViMG96dDZaMHNkSGIxMEd1VWgx?=
 =?utf-8?B?MGRnZmxwMWRvZkpSK1FxMVlCREtZKzUzdzkxL08rWml2ak9NLzZqK2llMFQ0?=
 =?utf-8?B?OHQrclh6L3lUZStwNm0wZkR2NFppVDU5S05wWjFSRit2QWYrd3FvRXhkWGhq?=
 =?utf-8?B?TkRUNVVCWTJERmg5alorMkgxRmpMNnhQSkgyWi9OY3NUemJFY0ZyQ0o1b25G?=
 =?utf-8?B?V2JBaEFsazhQMVVMbXFkdE55ajlHUERRQm0yajJXRGpZdVFWdUJoNk1TdHlP?=
 =?utf-8?B?YzhsUGdTRnV2Zm5iSkt4Z2lWTTRyQTVaem5WRFc2c3h4MTJvN3UrYjI3eVNp?=
 =?utf-8?B?MnRJZTBzbG9jdUVaekFCUDBGem1TUEdJbEZhN292TG40OFBra25rZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7f918d-41af-4041-4a9a-08da245f45e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 12:54:44.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzQt6cqfqyioGr46AD7ZBtbgwOqGx8Z+Rs7CkVnQaEtVvinBGdEkdQVUxU1koM6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-21 16:17, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8c272923-ddfa-9151-4efe-cf8127ea995f@amd.com">Am
      2022-04-19 um 20:47 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Change SVM range mapping flags or access
        attributes don't trigger
        <br>
        migration, if range is already mapped on GPUs we should update
        GPU
        <br>
        mapping, and pass flush_tlb flag to amdgpu vm.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 41
        ++++++++++++++++++----------
        <br>
        &nbsp; 1 file changed, 27 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 6be1695f3a09..0a9bdadf875e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -686,7 +686,8 @@ svm_range_check_attr(struct kfd_process *p,
        <br>
        &nbsp; &nbsp; static void
        <br>
        &nbsp; svm_range_apply_attrs(struct kfd_process *p, struct svm_range
        *prange,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t nattr, struct kfd_ioctl_svm_attribute
        *attrs)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t nattr, struct kfd_ioctl_svm_attribute
        *attrs,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool *update_mapping)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int gpuidx;
        <br>
        @@ -702,6 +703,7 @@ svm_range_apply_attrs(struct kfd_process *p,
        struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_ACCESS:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *update_mapping = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuidx = kfd_process_gpuidx_from_gpuid(p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS)
        {
        <br>
        @@ -716,9 +718,11 @@ svm_range_apply_attrs(struct kfd_process
        *p, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *update_mapping = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;flags |= attrs[i].value;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *update_mapping = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;flags &amp;= ~attrs[i].value;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SVM_ATTR_GRANULARITY:
        <br>
        @@ -1253,7 +1257,7 @@ static int
        <br>
        &nbsp; svm_range_map_to_gpu(struct kfd_process_device *pdd, struct
        svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long offset, unsigned long npages, bool
        readonly,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *dma_addr, struct amdgpu_device
        *bo_adev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, bool flush_tlb)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = pdd-&gt;dev-&gt;adev;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);
        <br>
        @@ -1291,7 +1295,7 @@ svm_range_map_to_gpu(struct
        kfd_process_device *pdd, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
        false, NULL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
        flush_tlb, NULL,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start, prange-&gt;start + i,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start - prange-&gt;start,
        <br>
        @@ -1325,7 +1329,7 @@ svm_range_map_to_gpu(struct
        kfd_process_device *pdd, struct svm_range *prange,
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_range_map_to_gpus(struct svm_range *prange, unsigned long
        offset,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages, bool readonly,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *bitmap, bool wait)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *bitmap, bool wait, bool flush_tlb)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev;
        <br>
        @@ -1360,7 +1364,8 @@ svm_range_map_to_gpus(struct svm_range
        *prange, unsigned long offset,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpu(pdd, prange, offset,
        npages, readonly,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;dma_addr[gpuidx],
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev, wait ? &amp;fence : NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev, wait ? &amp;fence : NULL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp; @@ -1481,8 +1486,8 @@ static void *kfd_svm_page_owner(struct
        kfd_process *p, int32_t gpuidx)
        <br>
        &nbsp;&nbsp; * 5. Release page table (and SVM BO) reservation
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; static int svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t gpuidx, bool intr, bool wait)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange, int32_t gpuidx,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool intr, bool wait, bool flush_tlb)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_validate_context ctx;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, end, addr;
        <br>
        @@ -1521,8 +1526,12 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE))
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp; if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;mapped_to_gpu)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(ctx.bitmap, prange-&gt;bitmap_access,
        MAX_GPU_INSTANCE);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc &amp;&amp;
        !prange-&gt;ttm_res) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This should never happen. actual_loc gets set by
        <br>
        @@ -1594,7 +1603,7 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset, npages,
        readonly,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.bitmap, wait);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.bitmap, wait, flush_tlb);
        <br>
        &nbsp; &nbsp; unlock_out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unlock(prange);
        <br>
        @@ -1690,7 +1699,7 @@ static void svm_range_restore_work(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
        MAX_GPU_INSTANCE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, true);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, true, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map 0x%lx to gpus\n&quot;, r,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start);
        <br>
        @@ -2828,7 +2837,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange, gpuidx, false,
        false);
        <br>
        +&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange, gpuidx, false,
        false, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to
        gpus\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, prange-&gt;start, prange-&gt;last);
        <br>
        @@ -3241,6 +3250,8 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *next;
        <br>
        +&nbsp;&nbsp;&nbsp; bool update_mapping = false;
        <br>
        +&nbsp;&nbsp;&nbsp; bool flush_tlb;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages
        0x%llx\n&quot;,
        <br>
        @@ -3279,7 +3290,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_add_notifier_locked(mm, prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(prange, &amp;update_list, update_list)
        {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_apply_attrs(p, prange, nattr, attrs);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_apply_attrs(p, prange, nattr, attrs,
        &amp;update_mapping);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: unmap ranges from GPU that lost access */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(prange, next, &amp;remove_list,
        update_list) {
        <br>
        @@ -3312,8 +3323,10 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = !migrated &amp;&amp; update_mapping
        &amp;&amp; prange-&gt;mapped_to_gpu;
        <br>
        +
        <br>
      </blockquote>
      <br>
      Can we skip the validate_and_map if update_mapping is false?
      <br>
      <br>
    </blockquote>
    <p>Yes, if changing range perferred_loc or migration granularity,
      don't need update mapping, we can skip validate_and_map, will send
      out v2 patch.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:8c272923-ddfa-9151-4efe-cf8127ea995f@amd.com">Other than
      that, the series looks good to me.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
        svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, true);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, true, flush_tlb);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svm range\n&quot;, r);
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
