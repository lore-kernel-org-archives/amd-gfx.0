Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 00:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A95960E8C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 00:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A95960E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B086E17E;
	Tue, 26 Oct 2021 00:10:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFF36E171
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 00:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvdcuawpgYREKvXQKOsOYAHY7F0SDq+qWw8HO9Rln6z5jfgFAL1bfTM5QWVWn2moih31dcnLlWQGfIgymgTt6Fv+uYNb6xSuL/zohsZGOru54rkQo4+iA3J5migeMBtNzlf9wepxCw22d9Pv+jHBWQOsZGwBgRaB3aC3ffAemaZt8yRum+u+dbBPSeE8MMVPnJ8nVUQacMIaG+qjEuQlgWRrJiO1yc4ft3PW/uzUH/LyIWqEFagFOBUVSfMXikntGB7MxDlTwb5OyBu0t3QCDtRP+dp01pH0JnG9vPQEiCy9rZMTFboEsPolNeZOMxrXSg5VuGdBMyPna/1bBlmLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42aY1nBcvIoCAKvZ9WTr2zn2DVG9jYB6TJpLx9LpEzU=;
 b=UNwkwrvU9oz17fF9Uf+Mnyc/YLS8KvTqOcY11ragOhihdd05g34CrQnhEyMXpcrl7rKHU28GwXEe+AjHj3j0A/t6Fbd/hy4rQnezWuJCj37COWeHxaziUpC5NF1SylhlR33Uo/RPG1niiPOxbZqy7NR5XVNH6FMopCC8Qbka3jxv/EPzNQUVrE+ZUrmy2on0JybbGjv/TQ4rg3Ln6AZ7l9dkc9BFur3PJCy/FMWmXS0RfbzZXGoVIgEBPrNrUL153QG4/JhgwjnJObJA2gxVvRfocw6o99amQef/bdUD0tkEO/3WNSCFbVtlvdubZntphVZn+xRSG0Inf4wOkzA61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42aY1nBcvIoCAKvZ9WTr2zn2DVG9jYB6TJpLx9LpEzU=;
 b=hI56vBxQ5g7W6r2mkr6uhpaPd+CM/7aSKf5n/RN5Y+Ox6YrPsB8UVU0NEgO2ripGt0S9HfKIjSDfVdFSnMFvv9C7x7h+WCycpn1CRNx07vd7oR5z/b716LJqh8x+m6rZv3ZCDuiSL/F1aU8GrXnoB/HViRdlWEkm8P2v2VxCRRg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 00:10:19 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 00:10:18 +0000
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Remove cu mask from struct
 queue_properties(v2)
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211025095822.207721-1-lang.yu@amd.com>
 <20211025095822.207721-2-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <15b5bab3-ea50-a118-00c9-fe598ef7b73e@amd.com>
Date: Mon, 25 Oct 2021 20:10:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211025095822.207721-2-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::9)
 To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 00:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c32c3d1-3d78-44bb-300e-08d99814fe80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43560FD27F6C8E94E7D9FEA892849@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VYqNZfr++4lMy5Q2pAo9/OOeefMrnYZxKSzJiRHSmPpBQLYeUjzZd56b1nBK/HGdhbU5YR2iLv7FEhyvFjtcLmwJiaQ7dhYUqdh9mpDiirly+g3rAH6wCdpfoFwmJ0LqnMjxOOGLntPntcnXivH/+BSw/9sFOPgnaUe7u9T3uXPj2wzHqZrjCie+NHKenDrVvFDbsWufLrWpY/ZidG/xGL33eSd6ohqVNjO9DrLmx8gD7V6bso0Vz9JJl/5y8mYoOZDFmpjwQV3Dhrf4mgnvazjwW7VNYHDRId9NL/tsOdSLz0TizHwalah3vs3xRosA32FYCKCbV7P7FY/UuxKckxSLZJi6cFKbN7PWyQvniYwEwXiDCyY8xKHjFIwXk4b0mfZO1hR1hA5ZDKUuQjPhh4Jb2Q25/p1BKMXxUh0+bjeNsGXK8aFe++qvtwxmLVIJxGv5EN0cdOfpAnuvXsU/gEaA53B4SjVKASfpt2/umfUyOrs8uB+KbaINEzKtMsseoCocdsu+73IceXCspHgpMF5h/dzy+kGqB4SrJPZk7H9GpxDwx6XCXFaBkwFsBeKgsNJ3bUHKq/SQ1pA/9pomPiQaKL9yd+tDCIbugna2qa9f2nYrOipWRj1conrdaHBbd86rqXIRUA3bfDMdY4eJpaVz+M2j1+2blACrl28S0c61R6T9HyaMZ3gLI8nmN0pnfdnasykxNsL8g1WhGx0ii2ZBwsjdwfFwsHpvzBxkXtEzuadKUFkVnfAA+ps4vpo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(186003)(26005)(38100700002)(2906002)(16576012)(54906003)(316002)(5660300002)(36756003)(66476007)(956004)(66946007)(4001150100001)(66556008)(44832011)(86362001)(30864003)(6486002)(508600001)(8936002)(2616005)(4326008)(8676002)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1iNCsrdHBGUU9rYjF4NjViYUFFaXVLMWwyZk82WHJadDBseUpLWURtWEI0?=
 =?utf-8?B?aVFEeU51NFEwTU9KYWZua210Nm5PSS9PVXBwZUhLUzN5RUs0clM5UjlEOUlW?=
 =?utf-8?B?a2lvWGdIR1NnbnRWTTJwVEVKZ3FrUm80a3lPTWxnd3JsMkY2VU5TS3NNbGsw?=
 =?utf-8?B?QzU1K0dONU9acWpEZUlycmJUWW9sRys2ODBvU3ZSVTNJQW9HbGNxdzh3L0tP?=
 =?utf-8?B?ZkNYa0l1cCtlWEhqcjlkMVVEUlA2aFpHd0g4M09seUY2WFYwMGxtbFlmV0dY?=
 =?utf-8?B?ZUdPdDZlWHNrTmN4dGwvb1JzcmpSdzh2QzR4UUdqNGtWcUpKRWZmMFc2V3c2?=
 =?utf-8?B?SnAvalZnSi9vVDZtcU1taUVsQ3BpN0E5dTFoNFkrTFFZdURTYkthZk55bCtS?=
 =?utf-8?B?dUpJQUdDNUxQRjB0YkhFSnkxdzRYQzY5MlphSEJHYkdDN2pFUmxMTUFCT2w0?=
 =?utf-8?B?b2N6eHZSK3orOUtRSHgwL0ZrQWpMdXRXRktKVlVaTHVSalMxT0FUdmtZSDJD?=
 =?utf-8?B?NDB6TGJTbDJqTmhZSWI0N1U3U0RVc2I0Zmh1ZndKbG5sSVl5dG1VUGdNKytj?=
 =?utf-8?B?eThoNCtBR0JyaUpnQlF0YW93YkRSUEMrZE1DQmE1MHRYUzVERUQ4SVFQL0ti?=
 =?utf-8?B?cjZvdmtmZzFNUTZGYy9MNzFxL1ppWkY0ZGhkQnhvMFRTemFCd1ZzWURVbHg5?=
 =?utf-8?B?dmdRWjRrUExnNDVLM0NZS1ZuTzVYc3BjNG84WTdPcUdJWmpWWTV4ZGU1ZFhk?=
 =?utf-8?B?a2ZpRm10R3lmQ2M0RGM5M0pDdVlFMGxTcVQ1bmpMQW9xUjRRbHd5MndkODNC?=
 =?utf-8?B?TXd2b3RqVlhUaXR0UDdycnRiVko3NGV6S0pmRXl0NHFyUzNxM0hFdVJpRWxD?=
 =?utf-8?B?MEJ6eUJIODZBRVVKUDVlRm0weUJtd29ZLzJlQXFkSTFnTVo2WHBwM3BieWRi?=
 =?utf-8?B?blBlNDJDS1dzbUhTc2tCVThpTnpBK3RPWHZPTWE3NExzT215UW5VUE5Zdm10?=
 =?utf-8?B?TXJNblVRTXYwVDRIMzE2TEVTS2ZlWVV5ay9hMExqVklzV2x0S2pOWkJiMGxt?=
 =?utf-8?B?UFBCZFVwVVVUUGR2YVVsUTZlYXhtd3RvZTU5b0hzNmpBeVJCNE5HMjEzNEZq?=
 =?utf-8?B?QUw4Nll4UDhBWXc3NmtLMHhEOEo3Uk9MWjM1R0NVMnl5V3JhaUVmWTJ5SFdt?=
 =?utf-8?B?aXVUMFprTEhiOG9IcDdzYjFyb3J3WkRIU1cyRjJPTmxWQ3E1M0IrSVQzRlZ5?=
 =?utf-8?B?eDRiNDZQNVJVQlNjWXRhK1R3L1FqQndDUGpVdVhyUGV3VXJ5UGZiTFpiNHFj?=
 =?utf-8?B?RkxhR3lEZjJTWHU2K0F0R0Fsdy9oSE5yaTdPYTZiaUNjMmxQQ0lYZGNlMkIr?=
 =?utf-8?B?N2tQdVAyUXU4bHZ1RSt3Vko1Vkg1ZXlJeTR0MjR3ZDdwUFRlNkJ3b0UzSDNa?=
 =?utf-8?B?U2NmTEN1K2tOT0lmN243NjhWRVcrd1o5Y1JQMzIxSkYvWjFqdXZONFZmM01s?=
 =?utf-8?B?TkNyaHIzbk1HR2psZDhza1drQ2l3RWxoT2o4ODAvTk9YSUZ0dVpoSElnYVhI?=
 =?utf-8?B?c0k4WnFRRm1xMTI0VUhMb084S3RiQldQTllaOGhUdXhYOUYrOWtIWWNXL1Fp?=
 =?utf-8?B?MHlSYm8zRkFSZWVyWFJrYzlrUzBhUXQ3WnltU0t4N3NxemJvSXN1TE1idTNU?=
 =?utf-8?B?bmcrWmYzaGk2RnV5TStkZXdKUWR2VEJ3emdWMGJTVE0yaE01RWgvYVBYOFp1?=
 =?utf-8?B?TWhnL05XNFBDVUNFSTN4bmxlRnY0eEhPajYwWEJOQ2ZZMEwxZFpkSGVQNlhT?=
 =?utf-8?B?NUtCaTdTL1owaHhtUElYNDhuRlJDOERYWW8rOGhKc3NYeW93THhKTWtUTVNn?=
 =?utf-8?B?TDlyTXl0Y2tJU1VTTWppY3JlOTBaWHIxbjJMN3BGWmpzRytNZHREY0RJTWt3?=
 =?utf-8?B?ekVGMEczbVRia2UvNStlSGVtSEZuL3F5V2xySWlDdDQ2RC9QRWZmNkRmM0Fs?=
 =?utf-8?B?Y2sxamtDZ0FkMCsvZXVrYWp4bFhSeHE0bWI2RUxCNVpkQkxPU2Vmb1NSLzcv?=
 =?utf-8?B?ZzkrSmIzQ0plTXBMRWpySUJzay9WK3FVcnJicVVaMk96WVdOVXoyaXBQdlox?=
 =?utf-8?B?SjRWTnB5c0p6b1NWd3pNa0VWQUZhMmxEZUdteXg0K2VQVGRDVjFBR3prRmpw?=
 =?utf-8?Q?IqjnVVS4yjJFDECzBTWfkzw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c32c3d1-3d78-44bb-300e-08d99814fe80
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 00:10:18.8186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2g0PV6bFwERTYo9G7f2/yTt9sA827jOpTH65tUFTm9dp+TWWzmhz6XbnN6AtapprVvTVmdTQK+Cm0idoXzgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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

Am 2021-10-25 um 5:58 a.m. schrieb Lang Yu:
> Actually, cu_mask has been copied to mqd memory and
> does't have to persist in queue_properties. Remove it
> from queue_properties.
>
> And use struct mqd_update_info to store such properties,
> then pass it to update queue operation.
>
> v2:
> * Rename pqm_update_queue to pqm_update_queue_properties.
> * Rename struct queue_update_info to struct mqd_update_info.
> * Rename pqm_set_cu_mask to pqm_update_mqd.
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 31 ++++++++++---------
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  9 +++---
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  9 +++---
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++---
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  9 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 23 +++++++++-----
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++---------
>  8 files changed, 57 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 9317a2e238d0..24ebd61395d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -405,7 +405,7 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>  
>  	mutex_lock(&p->mutex);
>  
> -	retval = pqm_update_queue(&p->pqm, args->queue_id, &properties);
> +	retval = pqm_update_queue_properties(&p->pqm, args->queue_id, &properties);
>  
>  	mutex_unlock(&p->mutex);
>  
> @@ -418,7 +418,7 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
>  	int retval;
>  	const int max_num_cus = 1024;
>  	struct kfd_ioctl_set_cu_mask_args *args = data;
> -	struct queue_properties properties;
> +	struct mqd_update_info minfo = {0};
>  	uint32_t __user *cu_mask_ptr = (uint32_t __user *)args->cu_mask_ptr;
>  	size_t cu_mask_size = sizeof(uint32_t) * (args->num_cu_mask / 32);
>  
> @@ -428,8 +428,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
>  		return -EINVAL;
>  	}
>  
> -	properties.cu_mask_count = args->num_cu_mask;
> -	if (properties.cu_mask_count == 0) {
> +	minfo.cu_mask.count = args->num_cu_mask;
> +	if (minfo.cu_mask.count == 0) {
>  		pr_debug("CU mask cannot be 0");
>  		return -EINVAL;
>  	}
> @@ -438,32 +438,33 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
>  	 * limit of max_num_cus bits.  We can then just drop any CU mask bits
>  	 * past max_num_cus bits and just use the first max_num_cus bits.
>  	 */
> -	if (properties.cu_mask_count > max_num_cus) {
> +	if (minfo.cu_mask.count > max_num_cus) {
>  		pr_debug("CU mask cannot be greater than 1024 bits");
> -		properties.cu_mask_count = max_num_cus;
> +		minfo.cu_mask.count = max_num_cus;
>  		cu_mask_size = sizeof(uint32_t) * (max_num_cus/32);
>  	}
>  
> -	properties.cu_mask = kzalloc(cu_mask_size, GFP_KERNEL);
> -	if (!properties.cu_mask)
> +	minfo.cu_mask.ptr = kzalloc(cu_mask_size, GFP_KERNEL);
> +	if (!minfo.cu_mask.ptr)
>  		return -ENOMEM;
>  
> -	retval = copy_from_user(properties.cu_mask, cu_mask_ptr, cu_mask_size);
> +	retval = copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask_size);
>  	if (retval) {
>  		pr_debug("Could not copy CU mask from userspace");
> -		kfree(properties.cu_mask);
> -		return -EFAULT;
> +		retval = -EFAULT;
> +		goto out;
>  	}
>  
> +	minfo.update_flag = UPDATE_FLAG_CU_MASK;
> +
>  	mutex_lock(&p->mutex);
>  
> -	retval = pqm_set_cu_mask(&p->pqm, args->queue_id, &properties);
> +	retval = pqm_update_mqd(&p->pqm, args->queue_id, &minfo);
>  
>  	mutex_unlock(&p->mutex);
>  
> -	if (retval)
> -		kfree(properties.cu_mask);
> -
> +out:
> +	kfree(minfo.cu_mask.ptr);
>  	return retval;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index a2b77d1df854..64b4ac339904 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -136,7 +136,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
>  	prop.write_ptr = (uint32_t *) kq->wptr_gpu_addr;
>  	prop.eop_ring_buffer_address = kq->eop_gpu_addr;
>  	prop.eop_ring_buffer_size = PAGE_SIZE;
> -	prop.cu_mask = NULL;
>  
>  	if (init_queue(&kq->queue, &prop) != 0)
>  		goto err_init_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 00bcaa11ff57..8128f4d312f1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -42,16 +42,17 @@ static inline struct cik_sdma_rlc_registers *get_sdma_mqd(void *mqd)
>  }
>  
>  static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct mqd_update_info *minfo)
>  {
>  	struct cik_mqd *m;
>  	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>  
> -	if (q->cu_mask_count == 0)
> +	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
> +	    !minfo->cu_mask.ptr)
>  		return;
>  
>  	mqd_symmetrically_map_cu_mask(mm,
> -		q->cu_mask, q->cu_mask_count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
>  
>  	m = get_mqd(mqd);
>  	m->compute_static_thread_mgmt_se0 = se_mask[0];
> @@ -215,7 +216,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>  	if (q->format == KFD_QUEUE_FORMAT_AQL)
>  		m->cp_hqd_pq_control |= NO_UPDATE_RPTR;
>  
> -	update_cu_mask(mm, mqd, q);
> +	update_cu_mask(mm, mqd, minfo);
>  	set_priority(m, q);
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 7f1101780135..270160fc401b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -42,16 +42,17 @@ static inline struct v10_sdma_mqd *get_sdma_mqd(void *mqd)
>  }
>  
>  static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> -			   struct queue_properties *q)
> +			struct mqd_update_info *minfo)
>  {
>  	struct v10_compute_mqd *m;
>  	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>  
> -	if (q->cu_mask_count == 0)
> +	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
> +	    !minfo->cu_mask.ptr)
>  		return;
>  
>  	mqd_symmetrically_map_cu_mask(mm,
> -		q->cu_mask, q->cu_mask_count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
>  
>  	m = get_mqd(mqd);
>  	m->compute_static_thread_mgmt_se0 = se_mask[0];
> @@ -219,7 +220,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>  	if (mm->dev->cwsr_enabled)
>  		m->cp_hqd_ctx_save_control = 0;
>  
> -	update_cu_mask(mm, mqd, q);
> +	update_cu_mask(mm, mqd, minfo);
>  	set_priority(m, q);
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 152f29b28a79..4e5932f54b5a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -43,16 +43,17 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>  }
>  
>  static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct mqd_update_info *minfo)
>  {
>  	struct v9_mqd *m;
>  	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
>  
> -	if (q->cu_mask_count == 0)
> +	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
> +	    !minfo->cu_mask.ptr)
>  		return;
>  
>  	mqd_symmetrically_map_cu_mask(mm,
> -		q->cu_mask, q->cu_mask_count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
>  
>  	m = get_mqd(mqd);
>  	m->compute_static_thread_mgmt_se0 = se_mask[0];
> @@ -270,7 +271,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>  	if (mm->dev->cwsr_enabled && q->ctx_save_restore_area_address)
>  		m->cp_hqd_ctx_save_control = 0;
>  
> -	update_cu_mask(mm, mqd, q);
> +	update_cu_mask(mm, mqd, minfo);
>  	set_priority(m, q);
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 4a8f3a06e6df..cd9220eb8a7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -45,16 +45,17 @@ static inline struct vi_sdma_mqd *get_sdma_mqd(void *mqd)
>  }
>  
>  static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> -			struct queue_properties *q)
> +			struct mqd_update_info *minfo)
>  {
>  	struct vi_mqd *m;
>  	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>  
> -	if (q->cu_mask_count == 0)
> +	if (!minfo || (minfo->update_flag != UPDATE_FLAG_CU_MASK) ||
> +	    !minfo->cu_mask.ptr)
>  		return;
>  
>  	mqd_symmetrically_map_cu_mask(mm,
> -		q->cu_mask, q->cu_mask_count, se_mask);
> +		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
>  
>  	m = get_mqd(mqd);
>  	m->compute_static_thread_mgmt_se0 = se_mask[0];
> @@ -230,7 +231,7 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>  			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
>  			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
>  
> -	update_cu_mask(mm, mqd, q);
> +	update_cu_mask(mm, mqd, minfo);
>  	set_priority(m, q);
>  
>  	q->is_active = QUEUE_IS_ACTIVE(*q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d758a57b17e2..4104b167e721 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -472,9 +472,6 @@ struct queue_properties {
>  	uint32_t ctl_stack_size;
>  	uint64_t tba_addr;
>  	uint64_t tma_addr;
> -	/* Relevant for CU */
> -	uint32_t cu_mask_count; /* Must be a multiple of 32 */
> -	uint32_t *cu_mask;
>  };
>  
>  #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
> @@ -482,7 +479,19 @@ struct queue_properties {
>  			    (q).queue_percent > 0 &&	\
>  			    !(q).is_evicted)
>  
> -struct mqd_update_info;
> +enum mqd_update_flag {
> +	UPDATE_FLAG_CU_MASK = 0,
> +};
> +
> +struct mqd_update_info {
> +	union {
> +		struct {
> +			uint32_t count; /* Must be a multiple of 32 */
> +			uint32_t *ptr;
> +		} cu_mask;
> +	};
> +	enum mqd_update_flag update_flag;
> +};
>  
>  /**
>   * struct queue
> @@ -1036,10 +1045,10 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  			    unsigned int *qid,
>  			    uint32_t *p_doorbell_offset_in_process);
>  int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
> -int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
> -			struct queue_properties *p);
> -int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
> +int pqm_update_queue_properties(struct process_queue_manager *pqm, unsigned int qid,
>  			struct queue_properties *p);
> +int pqm_update_mqd(struct process_queue_manager *pqm, unsigned int qid,
> +			struct mqd_update_info *minfo);
>  int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>  			void *gws);
>  struct kernel_queue *pqm_get_kernel_queue(struct process_queue_manager *pqm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 37529592457d..3627e7ac161b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -394,8 +394,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  			pdd->qpd.num_gws = 0;
>  		}
>  
> -		kfree(pqn->q->properties.cu_mask);
> -		pqn->q->properties.cu_mask = NULL;
>  		uninit_queue(pqn->q);
>  	}
>  
> @@ -411,8 +409,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  	return retval;
>  }
>  
> -int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
> -			struct queue_properties *p)
> +int pqm_update_queue_properties(struct process_queue_manager *pqm,
> +				unsigned int qid, struct queue_properties *p)
>  {
>  	int retval;
>  	struct process_queue_node *pqn;
> @@ -436,8 +434,8 @@ int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
>  	return 0;
>  }
>  
> -int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
> -			struct queue_properties *p)
> +int pqm_update_mqd(struct process_queue_manager *pqm,
> +				unsigned int qid, struct mqd_update_info *minfo)
>  {
>  	int retval;
>  	struct process_queue_node *pqn;
> @@ -448,16 +446,8 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
>  		return -EFAULT;
>  	}
>  
> -	/* Free the old CU mask memory if it is already allocated, then
> -	 * allocate memory for the new CU mask.
> -	 */
> -	kfree(pqn->q->properties.cu_mask);
> -
> -	pqn->q->properties.cu_mask_count = p->cu_mask_count;
> -	pqn->q->properties.cu_mask = p->cu_mask;
> -
>  	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
> -							pqn->q, NULL);
> +							pqn->q, minfo);
>  	if (retval != 0)
>  		return retval;
>  
