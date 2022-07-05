Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ECCC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 19:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E93011299A;
	Tue,  5 Jul 2022 19:02:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A5F112942
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 19:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCGyVBKjEpP8GQ729SzRmia1+b4mTi43qts7WaKaySeaKnZUBsoxxg6RgIDORVFRNVcLaa3sIcnMak4ooDcH3O7PrulzOibwZ7EHzjLuebiRqvVFMcvFj293QVOyCDCqC8ZocWhpI/KhyHWgPfy5AEVz+15HMF/oz3Y+iU5cD8NYD+lo0aRLRmloAsummy3pHsuIH2akguMRWeurgcuunzVU4cyCMTb+B7TLHI/IVvg4/0oYlPZWyNixU4E5Oas6aPmFfbnBJqhsWZmmHgOOYvsbZMUbvGKw9TdmI+VBcu3eoTPvfjKKNAr4Pg3WWdRqR9L5aBklR3/XH7OsWy4bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9SGbJ5WDSz2GiW/S7vi0pFI+KCzP80rkwQJ27q/ntg=;
 b=czFA0MYPFK62nYR+86iyoGpkwijQYUi6eluDDTnyT+lJd8JSdjN+OTAh1PPgiSwTXQ2TlFdEGVkJzXApii8fDCDDAWAcCtiWKkzKfUY++uEq0FLMOJRkn3Mfv/S3gAWU794niNz6TJq0PtR6i3hYTaQZEdVDk4d4fNQQUgoD8K6pllwKAPkEgYnHTKYgpvLpsxrgb8SjDm8xxQ4Pd1JL8yZpdAiOwbY6368pi2VbCw1iGTBB5MGuW+UVRjbFk9CfJ1uZtFTbWgUvAuJ8ZlIcEoAutKVlhU1lQrWDNHkx+3miF3tYBQjGR5euXRkACaylR/3FC4jlUAYbCU4uoOSn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9SGbJ5WDSz2GiW/S7vi0pFI+KCzP80rkwQJ27q/ntg=;
 b=OTHHChHAtoRN2GpwNKHmbOoY0mnl4A3Cr6ZaNrhgIjg0ZQm0ztxy/K8wgp63WxunpIU+xDnufg4keJoHN5/1uNzV++qU/gsKuJiTXsLU5fTzjUEL2h/N8bBz6wksAxd/YkU7d4sEf+Wl4Wy6ZDF+LRXH5huZ97UOciSuYKBhU8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN6PR12MB4768.namprd12.prod.outlook.com (2603:10b6:805:e8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 19:02:39 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 19:02:39 +0000
Message-ID: <2a06bc46-1b6f-c3c3-a842-d49ea4980391@amd.com>
Date: Tue, 5 Jul 2022 15:02:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdkfd: Remove queue sysfs and doorbell after
 unmapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip Yang <Philip.Yang@amd.com>
References: <20220611010334.23401-1-Philip.Yang@amd.com>
 <2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:610:b1::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c8d8fb-9a78-473f-491d-08da5eb8ee3f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4768:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 432aXVkIdHIWvxD3ehe+jeHs2+qTCMPZ55VBCiC7flu2fTbS+O/qqBBrF7r6oqw1Z5odPFsaLoPSp/wfCPFQ6Pa6Xl8YZCJwQIRJlMC48tsaaN0gw6cU3Ifzi8H9hJ7Fcn3XQqEfm85Co5+dFaxqbA8rw42g4FWljJfeFCoL8wYsjhBgQLez+LCgIMBaOq9e76GBFju7ZYSTkDuIjDKRuep9vVjcr5RL7GKphDyMYOnPprrOG3W1hP5BkweQDf8lSBJrrcZQTRYhlIlrhkrMg25VMs98qWFxVbUUiaLasHJENlzW5u2c28qmR9m+FoaGBUr7Y3j/cn9+xQTs4ixyQubS89k35GaYNt3mMmb3KyRsj16M55LoxlET4iuG9a4SpFhHMg0HMqWsgim+LDsnH7PxrZrnsgo7+MrJkgFUIVIe97zlp19YTC+62nEMWlh7Ot0oHh5+yCVaWyheHzDcqYpZFuaYQXB/foJ5mTeuBnWcR8NNNpgz3hClkThccCqcKVN/xlqaWiez58NW0bRvMFgsyuEzOA91+q/PJUb0KbyeU4PWIKbWiYPAqzWofMoTpn57Fxxr0Lf9Q8k31B8AaYB+nL2f8tHjQVcxho4yz3lfsnjUqIrpBBQRVhR+3gaDHG1BqLlb2Tz3mIOAi0WcVvoyblBKMJ9vrYFARVpYW7wIz5qum8N8geMZbN4CvBCA3UMjDlBn3Qs21kIjiplvSAZ8x0m31UIulGzwnYSPmCgb9JtslFzM1L0kH/QnOVc6TsCuEODCIujc8YQ5kZqATc7HOOHon4MAURHhLuUSRBstQxa3KvPnrb+p8ykt4fADqUnDKyzcqESoyZZinfmrPXhqStJGj+iMpVb1BFNmsm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6512007)(6486002)(110136005)(6636002)(316002)(186003)(2616005)(31686004)(36756003)(38100700002)(66476007)(66556008)(8676002)(41300700001)(66946007)(53546011)(31696002)(8936002)(5660300002)(83380400001)(26005)(478600001)(6506007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpsckdVU0hOQU9JZSs0WktYckhkZWFRY25GTVgrMy9UcDZScWFBamRiSkFN?=
 =?utf-8?B?Nmg3UVhvU283RUVQU3pTZHhQY2J3Z0VmeUptL1dBaXNLREZoc2ZnTCsrdE5I?=
 =?utf-8?B?U3A4aWt6bCtRTWZFUE1BbUJXdmMxR2tqeDgwNGVrUFFUVDdwUG0wNlhid2pR?=
 =?utf-8?B?SUdwVmVibzNWbU9EbDJhRitmWVllbTVrdDNQN1JDLzhLbjFpMDZZamZ6OGpJ?=
 =?utf-8?B?aFkzZ3RxaEg5cktJSmxVOWZNWGdiamNFaW9nMy83ZUx0bnh5eG1URVJZMWtD?=
 =?utf-8?B?ZzJNeFIxbVUvYWxJR2E1M3BOcmg0YXYxbXpmMVpVUzFWK0Z3aExYNnJMU3dt?=
 =?utf-8?B?dERuRkFZTUp3MUM4V3RTdC94NVEwUEJPbWN0TVpJb2gxa3FQdWh2aWZpUWJ6?=
 =?utf-8?B?bUljMnVGVTM3bUluWlZlYWtZdElkbVA4WEpkQVl3STg5RXpKSjNKdGN2K3Fi?=
 =?utf-8?B?bVROdkdmbkppeFczTTV4aThmZHk3L3A2MVBWRHFlU1E2QjRzcEFhVCtDeVF4?=
 =?utf-8?B?TlRQeW5NTWUxQVFOaTJWdEhRN2JWVEJOL1lGSFZ6UjFmNmRuVC9kcXRNWVZG?=
 =?utf-8?B?QVN6LzNnY3FFVTRwT3VYLzZvMktiZTkxeG9TQ2IwRTBnR0xVeG45aWUvWUFM?=
 =?utf-8?B?TGtBS0tSL0doNDNGRjdRZ3dMYzdOcGhDSC9FTXJWS1dnN25yT1F6eCs3ODVo?=
 =?utf-8?B?anV4Qkt1TmxudWVtZkxiNTdJNHgreC9JbHR4dnVlQkVyMzA0NzZhczFQeWIy?=
 =?utf-8?B?RFlqeVgrdGJsYUtLRHZKREExQ1NjSUpzVldoS20vanBOTitVYzkrYjJid1JV?=
 =?utf-8?B?eFFWNXVzdW5XVVM4NlZidi9LM2doT1ZydWNOSUczZmY1bzJmVXV6djJOaCtX?=
 =?utf-8?B?TWZLem15K2ozbVBLeVBnajNjczZDSzBOYjF3aFYrTzJrVmxyMXhmNEdLU3My?=
 =?utf-8?B?T3hEaW9mTEM1dzNYNkVRRVBXMTgvTlpudHVsbW9lekdLOExhclg1bXFUM2FC?=
 =?utf-8?B?bktoUGdrNVRad05Td2JSelhmMmZ4WFJGa0g0UDFtWldVYUZ6eHQ2WWw0M3RG?=
 =?utf-8?B?dFZmYUhma3FDQklTNVNhVVF2Rjk1UDdPOFRnRjFnc2lFTzFQZEt4ZS9lbGZh?=
 =?utf-8?B?OTFjREowS283VTBwRSt2YXM2TFlSbFA5VXhGTXk4WTRCODFWYUNqRUIrc3JC?=
 =?utf-8?B?VGVZUFVZOXRaSjR1T1h0K1J6ZWhvQ29hRTlyMVZzS2RuQUdHaC95Z1NSQmcr?=
 =?utf-8?B?RThwektWZE8wSHVNeUQxdEJ2OEU3eWl0eldUNDNqNTd0cklaelBKL21CU20y?=
 =?utf-8?B?VHNLTnRFdU1XTlpROHdLT0FsbTJxSXUxVTlnTjZBSkxxYTF3bVNhb2k4MklY?=
 =?utf-8?B?S0ZHbWI0SDRmL0JmVVY0bHBZVFZtb1d6Sk5VRTZrV1pFSDd4eFZFSmcwU1JR?=
 =?utf-8?B?RWQxU0ZOc3YvQy9ZM2NxaUcrTnRicm5KL3BSVG1HM2Izc0Jrd2pSZWR6TVgy?=
 =?utf-8?B?WktTVGUwZUZJbHJyOEFySU10dnFKUXRqWjhNUXJoTFhnVWh4NnZzaVVqUEYw?=
 =?utf-8?B?Wnp1djhmUU9LWFlUNjBScE1lRy9aSzlWV2tyTjNPSCtabjN2Z1hlaFpMRkNn?=
 =?utf-8?B?UHpFZ2l1bkpHcThNU1VGdWdUZEcvWUQ5NFJYQXFqUi9mVFlYaUE4YVhnQkw1?=
 =?utf-8?B?SGFIQkpLdG85bWlicUZDUW5pcDl6TFZFeVlQTUVqK25hclVKU2RadW4zMDNa?=
 =?utf-8?B?R1gvcEc3emhJN1Y4V3lRd2tLdThPbEFBL1BIcEVOdVBxTmMyd3B3SzZqMnBG?=
 =?utf-8?B?dzNSZnRMTFBpbDNOWVlCUWc1U0w4dnMvMDRiQkd6Ujk0eG5pNmkrZ3h4eHdO?=
 =?utf-8?B?TUdhZ0hEdnJkUFIvcWtmcTdxcGNGaVBRb2ViREJLZCtPVkc2YTlsWWQ0S1ZV?=
 =?utf-8?B?S1grcXhpOFdONjFJQ3NOYk4xTmM3RkV3YXA3SWdPN014WllKaTFCQjRJaEVE?=
 =?utf-8?B?bms0YndOeVUyZ2FHcjdMREhzTUN2UTZrZUw3bDRKbXJXRFE4MWV2ZnBFcVVm?=
 =?utf-8?B?SHVjYnRIS2NpM0M2dGIweGN2QjBZcHJhUmNzZDB0cG1NRmVFK0xEU0Z2Yktm?=
 =?utf-8?Q?8wz4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c8d8fb-9a78-473f-491d-08da5eb8ee3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:02:39.1402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYt5bHb1NbU5bPILmaVZPB+QP0mxc1u//Fb4geFXSV6YWVr0ftocXgPDmJERD6QX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4768
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
    <div class="moz-cite-prefix">On 2022-07-05 14:48, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com">On
      2022-06-10 21:03, Philip Yang wrote:
      <br>
      <blockquote type="cite">If destroying/unmapping queue failed,
        application may destroy queue
        <br>
        again, cause below kernel warning backtrace.
        <br>
        <br>
        For outstanding queues, either applications forget to destroy or
        failed
        <br>
        to destroy, kfd_process_notifier_release will remove queue sysfs
        <br>
        objects, kfd_process_wq_release will free queue doorbell.
        <br>
        <br>
        &nbsp; refcount_t: underflow; use-after-free.
        <br>
        &nbsp; WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
        <br>
        &nbsp;&nbsp; Call Trace:
        <br>
        &nbsp;&nbsp;&nbsp; kobject_put+0xd6/0x1a0
        <br>
        &nbsp;&nbsp;&nbsp; kfd_procfs_del_queue+0x27/0x30 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; pqm_destroy_queue+0xeb/0x240 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; kfd_ioctl+0x27d/0x500 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; do_syscall_64+0x35/0x80
        <br>
        <br>
        &nbsp; WARNING: CPU: 2 PID: 3053 at
        drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
        <br>
        &nbsp;&nbsp; Call Trace:
        <br>
        &nbsp;&nbsp;&nbsp; deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; destroy_queue_cpsch+0xb3/0x270 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; pqm_destroy_queue+0x108/0x240 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
        <br>
        &nbsp;&nbsp;&nbsp; kfd_ioctl+0x27d/0x500 [amdgpu]
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp; | 4
        ++--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
        <br>
        &nbsp; 2 files changed, 3 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        index e1797657b04c..1c519514ca1a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        <br>
        @@ -1876,8 +1876,6 @@ static int destroy_queue_cpsch(struct
        device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr = dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((q-&gt;properties.type == KFD_QUEUE_TYPE_SDMA) ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (q-&gt;properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deallocate_sdma_queue(dqm, q);
        <br>
        @@ -1898,6 +1896,8 @@ static int destroy_queue_cpsch(struct
        device_queue_manager *dqm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; deallocate_doorbell(qpd, q);
        <br>
        +
        <br>
      </blockquote>
      <br>
      I'm not sure what this change is meant to do. I don't see an early
      return in this function, so deallocate_doorbell will always be
      executed either way.
      <br>
    </blockquote>
    <p>If app destroy queue deallocate_doorbell, but then unmap queue
      failed, app will destroy queue again when app exit,
      deallocate_doorbell second time will trigger the WARN backtrace.</p>
    <p>As queue_count and q-&gt;list is used to alloc ring buf in
      execute_queues_cpsch, so this change causes regression on gfx9, I
      will submit new patch to handle unmap failed case with MES and fix
      those issues.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:2f71d9b5-59aa-45cb-0245-7dc139f108b1@amd.com">
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unconditionally decrement this counter, regardless of
        the queue's
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * type
        <br>
        diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        index dc00484ff484..99f2a6412201 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
        <br>
        @@ -419,7 +419,6 @@ int pqm_destroy_queue(struct
        process_queue_manager *pqm, unsigned int qid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pqn-&gt;q) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm = pqn-&gt;q-&gt;device-&gt;dqm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm-&gt;ops.destroy_queue(dqm,
        &amp;pdd-&gt;qpd, pqn-&gt;q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {
        <br>
        @@ -439,6 +438,7 @@ int pqm_destroy_queue(struct
        process_queue_manager *pqm, unsigned int qid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;shared_resources.enable_mes)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqn-&gt;q-&gt;gang_ctx_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_procfs_del_queue(pqn-&gt;q);
        <br>
      </blockquote>
      <br>
      This part makes sense.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uninit_queue(pqn-&gt;q);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
