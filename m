Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584FCD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DF711A888;
	Fri,  5 Jun 2026 13:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iaLhs5N8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBE811A888
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOTqm3UGRijmUBozVEEBpWhpn0+Vxf2n8SUyPuQ4MOe72dvFApod+oh9TJ5IoudTpiHLqS5qWJeR4Dlf+r/1WYYp5aA/ikpjgR7DkUuryzPMuNa0HoHLyPvCyiWR3vycO5VR0y3BsQVKPwBnFd9GcUtXz9htUK6J1CJave2VUuxZuVTYZfx23od1SmuKDJfupSc8/x572ekun9+1mOitEeBKBnvDP1sl0Ut+v9XMHsKF6svwMG9bSDjZTLA+m17hq5DDLf/rzYNb+d9m8Iuaco+W7EVlUbrVTRkPBVMkn0ZqSkbPudG5uaKzlsfWO59OtKbqgqlOtzZAoTu7HjtRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEp2WVmCI9F1tinjZgwX3+AdMbIPaViFA+cU+5cse94=;
 b=PRRtg5Oavrxs/vDA96OT4olLqqIht4XsWOsqBfFip3G6beTzLcDEYz+abf/2Hu8NVlG8R636Vq4FYBPFHhBqq7EWD+4pYXEGgHeEMUv7gRTaQ+GZIpsGcIeOT49OILFbzdISYbYrjY8YiFB2NWM3SJ9AbwNgBH5olnPQ4VXg/IrTP7I11cAt27XlSsxRYoyV85FZOjjutLyar3MqpH4fXb7ZR8Iartr7oDehtET5L426taa9rVu3xBS9MtE/1+MDm/vmGTCEQOuo/9kFpYV99IQ/swiQPthMA5hpHZcIlkkqp4Ai5/uoo49NL6jXJqOyybc6FHDNxB5N/FR6b1zs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEp2WVmCI9F1tinjZgwX3+AdMbIPaViFA+cU+5cse94=;
 b=iaLhs5N8WJfgG2gPCM8kkeOO1KiKcBQovi4UxB7wSRyCQVrAjWgVtLItTtjU8vr9GuphhiJEsPLlcFbNNEHpYU/hfW0/Y8s4TF7ZFJXKouDEWbJS8GTrO+Id6iXiQVdV3rtmSE0j3Ov7TcrSYwj13e65pPx/exVBzJU1/CvF7mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:27:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:27:36 +0000
Message-ID: <a24d8e19-ce83-4509-9833-ead485120879@amd.com>
Date: Fri, 5 Jun 2026 15:27:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/11] drm/amdgpu: Store user queue qid in
 amdgpu_usermode_queue
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 516e3e10-d640-4961-617f-08dec306354b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ThvaisocuywwIaUWN3tc74tcjT4DsHvAU0OhFEo4D3LedhZ0JvqFaTXJ1BuldtWvvNvtynNG2Aofrvke8cStQByns8KhG6vnt5U8gj1Jqfl7WOURReTDytqYjHQ+cABGXX9uwoca5hnHwnMiGLg2/DIQkiGNf7qG7p+XSrj2KD3cWL+LOvEERuIYSlFJhSLXUSvZR9TuikZwgPAJ4fVGuHYUUnbWyuHvJ3H/tIWtpIblEzqP73k7KBc4wj/5AX+StgVW2PoAjblcYouUddJcD6lY8KB5BENuP5oDO5B1SBtjGD1OlIe8J+vv+8CrnMw+LiC0G6IdfV+z6J03Xx2DJ/0g1zkN9NFmZ3ofCTssRczbMcru0htUzRrLYYu/qR83UvX73hmOmmbrZ4mCXPAjpbIv94MgrXIwhmLD/rdcMV4s+epSmopjl4msrkgD4sbNJkXRr8s7JpZVB7AOyf2+sfAwCV0YVSNIentOIQQApZg079sNzyvYt65rmp92EwCi3FOZpgo2EXRuXC3P8oBBC+cCX8vjPEGw84+pwfvrvXKo50sm7lQ3Zl/lS8sswzai7SCtL6Pl2ge2D5kdid1B4AMhTgdQOSbEdU+kEjFhKj5Hu9mTzAxoa98epTNHnkE0T1DQ2K9fBCZMD1yAPPbI5RCiw04Q9QrWMPURt2DOikQZOHV2f63KYbgeMgK0Jwgc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGh6NHlQRWpQNTNXWG1rMFhFMXQ1eHN5VE1YaTJvQm5WcU5Va0I5bDk0ZWFT?=
 =?utf-8?B?VDgwVnZTVG5oUS8vQlVlaThhazBhTUUxR3ZueEptaFNhN0lwWHRJUVU0R3Rr?=
 =?utf-8?B?aWtRMDgwTjBvOHo0elIwczUvRDAyMllpazNYN1VZTnlUUXV5c3VEN2tIVGwx?=
 =?utf-8?B?ZHhwZ2dDL1NWNnVkMGtVSEg2SXlxaUlNakdjZjhCekxtK3ZwYWF2Wit0TnZi?=
 =?utf-8?B?S3FmMGkxNklBZlVnK3hyZ2l0Nit2WVpqT25POXc5TDF0eXV5UVNlclNpMUwx?=
 =?utf-8?B?dEZvNzFzUjI0VTJiVGdvbll4MTZweEZQRlFjZlJuSlY2REpLOFlMRXZ6dFF5?=
 =?utf-8?B?TlZ0b2VJRmRBOUxpRXJibGxVS3E1dVNNdTlmMlNEbnczK202dCtVVXZueFhQ?=
 =?utf-8?B?MGZ1M1YzSTBSMmhVaUMvUmIrcnN2eXpjM3pjZlJLY1JUNzl2ZFFaL1U0UkVz?=
 =?utf-8?B?ZUlEQUZ3QS9wdjJONHNJTXVBTDMyZ0tKUnQwbWZuZHdjbVozWmNqdGpaMXlm?=
 =?utf-8?B?dVBxZWg0QXR5ODFoNE81ZkFTQmwxbytxTGtOTWdzNGx1bTBYVTBnN1NrcGNU?=
 =?utf-8?B?eXh6RlQvUGdManVLT1VkTndCUkdvaGFTZlBzT0lGL3QzWldGRmdCMENxVWJV?=
 =?utf-8?B?dUYwKzlrZjZvNUtWeXp1NGJDekgwQitaZDRYNCtGUUp4b0gvdDBoUSthOWpM?=
 =?utf-8?B?cjh4eFBKTy9Bd3lRT25YMlpQL3RHWm14VjIwU2hpZUtTbmI0eXB1a21HUE5K?=
 =?utf-8?B?SktiMytKdUtueDN1amo3aUhjVzlUVGFUM2pFcm1SKzhwYmhTbU0waWY3Y2Ro?=
 =?utf-8?B?RnZKZVpFVUJRUnJFTmFadUF1WmdGaDhxaEFIUy9TbkppUzhFSFZGMWJTNzE3?=
 =?utf-8?B?TVpNTTlybW9BcDRBOWVGanJnQTZtc1BiMm92eXdoTmtjQU54R05BWG1zRXND?=
 =?utf-8?B?dFVCcFdsa2lwclhkNTc3WDlKb3JmQnJLOE4weGhQYVNuRmxLcm5xZVpSZ0po?=
 =?utf-8?B?TmhUd044aFh1NndFMFNLZXJnck9WMkx3UEtOZFltUXc2bm1WUWpYVHI1aWJO?=
 =?utf-8?B?aDBVcGhlSE85a1hlV295VkdSVDRzUlhJc1NwVWx5QnpnN0NCTkc0aE00b3ZD?=
 =?utf-8?B?S1lKYXlqWERNM2ZTN0N4RzBvc3Jyckh1cGc2Tzc3a1YzdXRQR1ExWDlNcDQ0?=
 =?utf-8?B?bXJDOTJOL3lWSFFmS2hab2cxMUtueXNsRW1hRHJoYjc4a01Xa2x4TWhQMDlU?=
 =?utf-8?B?OVhURlErVUMxWlNDV3E0RCthTGRWNCswREUyTEd2YitWUkJzUXgrOXhQd041?=
 =?utf-8?B?NWdnaC9lNHBwdnVFbFJNcnFWQUNYK0FFMnBoVVdCVnZ6VTlCdmVTWlFHbXUw?=
 =?utf-8?B?bjZRS0Z1aXEzV1pPRHhtSWJxSkhvcGJzQ0gwWmJPeDYzcXFQQzVja0VObHBk?=
 =?utf-8?B?dmhPNzBWODdUMkpEQkFDTGdpMTZjMGNQc083cFpoMHA0Vm85NVhrSE1SeUY2?=
 =?utf-8?B?d01CV2h2QnB0QmVjN0MwVm5lR2NCZThZNmwrWjN3K29nUzloZmFIekJtL0w4?=
 =?utf-8?B?ZlZxdFdLeGxMZ3VZRjVnVkdwUjUvMVpTYlpBeFBaNWpNYTYxYlR2TFowTitH?=
 =?utf-8?B?dFlrWnNEcG5BdEV5Vml0VmFTN0I3VFlweWNqQmhUKzdWUmtCQXZwbG5FVWpy?=
 =?utf-8?B?M2FtTlRjM0lEMFEyU0Z6bkNhUDdNMGlYY1NncEtFQ01EUGVmRjN2U0tRemhV?=
 =?utf-8?B?aFQyV2V0UGVsdDFQaHZZbzJwY09RYWgzQ2c2U2JUb0R4RXNJNVMzMXg4NDRC?=
 =?utf-8?B?R0lzYWxGQWdBajRQUTd1bkJiZVUrYWhqTXd3V1VXZlBWWHdHbjdiaUZPdTZy?=
 =?utf-8?B?eHFydlpFNkQ2VDZ2bmlvam9id0xYNDBQbnlyOWUzUXpNOHR4VVBieEYyTklx?=
 =?utf-8?B?cmRDNXc3M3JhU2ZPS1kxdWNZNm9wRVIrYXFGNncxQ1JWdHAvWUk2bXlNRG01?=
 =?utf-8?B?WS9EK2JaQlJZWFBHWUs2emc3YkNWc1NOYStZNlp1OWtLSCtCUVdLUVVVZnc5?=
 =?utf-8?B?THhHUDUzb1pjUkhZRWVTemtqTXBUWDZwVWE1MFpwQ2NxOWVFYW1ZM0g2TXJt?=
 =?utf-8?B?T0o5OXRBaHlGMjVTUlJCMXVPMjRDVEsvOC9GUU13bkR1andyYUJubzMrUWVH?=
 =?utf-8?B?Y2RkZDBZNVB4TDIwZXRzVGtQQVdyM3lFYWZDYUo1c0VJeVNhRHBSVzAwUnZX?=
 =?utf-8?B?clBnL0ZTNUNTUURqaytjZ0F2N0NUMkU0cDc0TFVHaTJMWFVET3Y1Y0p1K0l6?=
 =?utf-8?Q?jzNeZaGIh/6TnKVV9V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516e3e10-d640-4961-617f-08dec306354b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:27:36.6643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TBAJd88diPewbF61WzRagOGPDukFb3Q7j9zvXuq9VTjPZvfdoXk+cAWwIGyWCI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
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

On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> Store the queue id (qid) in the queue object during creation.
> 
> This keeps a stable queue identifier instead of relying on
> doorbell_index.

Exactly that's the point why we don't store the queue id here, it is *NOT* a stable identifier and only suitable for the UAPI.

Regards,
Christian.

> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 93e9cef9856e..d5ea69e7a67c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -720,6 +720,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		return r;
>  	}
>  
> +	queue->qid = qid;
> +
>  	amdgpu_debugfs_userq_init(filp, queue, qid);
>  	args->out.queue_id = qid;
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index baafa066097e..185ba0d76aba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -54,6 +54,7 @@ struct amdgpu_usermode_queue {
>  	uint64_t		doorbell_handle;
>  	uint64_t		doorbell_index;
>  	uint64_t		flags;
> +	u32		qid;
>  	struct amdgpu_mqd_prop	*userq_prop;
>  	struct amdgpu_userq_mgr *userq_mgr;
>  	struct amdgpu_vm	*vm;

