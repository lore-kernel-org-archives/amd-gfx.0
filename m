Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ABBC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC1210EAF1;
	Thu, 22 Aug 2024 14:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmW7DM1J";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D9610EAF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Slobr5KwnDIc0lgvptdKTzhfd9hxcffLF7xKAG21vK+nr0D5+rtf+E+p+1rWQ/ZBsVMdQpCmwkvmJLWZh/4+01AtKvWiq0IWTTO/a34Npe8JYOVMrr3IVCw6uxkFFNuvtB5Ag6wUYJyq9Ml3CnCA8T874vYmt8trMNEY2u8k9C0JfR5oiEtcGdudxqyfEJ/8M0NQyQs1G0jaMD+VB7Z5KK1xfcpuGaEx4yBlImCemV4rSVvnayRnfsrJyRwW/X5y5UwFm8wP4l4/7mlXy2PmuYmzVFys78aP5Wep0KuypLnID7wKR5XAiPxBYEB7rH3cl1ci8bcfX96vkLq25InUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awtIG8BOb/mNuRQPxFTDfwaQ+AWzLJDB8WRzYDkdPGI=;
 b=Kx9hAdnjkC2mGEt1jlgQUs6LbElYFlX2ePP6XjP7Qtbtj7JUY2acAQw6Uq1bc2OjfN9h63E1BjsKXG2/vOHYGw+2fuwMvmm5vrlzChQBaSx7Xz20EeTQtD2tIKOnERzRNikHsnK1IxxeJLTlFxeG5fldp0QFVidpKBwGdDvpEouIrt6AyjIG+zblTkPOHlIaNCuebnSAadzwakAkRyNnK1gNW5hsVvIr/DWgDZ88dGtYKRai+mcYgqs5IjNQq1L4nxTphV+89yMKUyS53KGijZ6HSpR4lePXYh3iOcJemz0Od3VCGcE0S9Ta1iit8f6qAOjEuaupJTn84HPBXwOrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awtIG8BOb/mNuRQPxFTDfwaQ+AWzLJDB8WRzYDkdPGI=;
 b=XmW7DM1JlDDvycQqQljBJz69epZdmq+gHUH5tLRJYqIjH82WwJ2MVaB8diWfNghH3NfH0zSKqjYn1KfIljc7w4wZNMFYqWLF6z6bCA4zc5jXhdLdcgFoVPE8Da3CDmtkzh+2olvwditJG2lBVWHLKWURA7TuMTd5JVXbxSkykuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 14:33:45 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:33:45 +0000
Content-Type: multipart/alternative;
 boundary="------------zjNluxd4CmtEOKpppTFpeLbT"
Message-ID: <a2a196c8-7861-4c0a-92ca-d082f7ff3fcd@amd.com>
Date: Thu, 22 Aug 2024 10:32:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Document and define SVM events message
 macro
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240730201547.13590-1-Philip.Yang@amd.com>
 <20240730201547.13590-2-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240730201547.13590-2-Philip.Yang@amd.com>
X-ClientProxiedBy: YQBPR0101CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::26) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 49816c83-2f94-4d85-258b-08dcc2b76d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bng4NGo4Zmd0N1I1VDgrWHU5UjdFcGU0YjBwTisybjdvckpkRGx2S01xUlVE?=
 =?utf-8?B?bXhVZFNKUEV6eksrd3JKRkVJYmNlU2tabTI2RmlRTHpUVTZueUhJd05veXhP?=
 =?utf-8?B?elpwdTdkM3RSWDVxK2liQjgveDdNL1hLL3lVeWhwRmR1TGNyYy84a1ZzRUJ3?=
 =?utf-8?B?THdFUHcvVXd5cVlHVzhZVXNBcWpyb3M0MHpwcVZkZ1l5UHpVcTJSMDY3cE5I?=
 =?utf-8?B?TEhybUxGVDMwQWczcU9RcUI4ZVhxcjYvTEdpSXdlNW9DanFzWUNJbkpTUWVk?=
 =?utf-8?B?MmEyUWpYcmZKdjIwR2RYb2h2MldQOG95YXRnaVBhQnVjaVdlaDduY0Q0TnlO?=
 =?utf-8?B?cGs3WU9id2tWa1Fzc21OME9pSUszVy9ZVVg2WmdoM2JuTURhMGFsVHRDcDBV?=
 =?utf-8?B?VjVoS1FRRUhnUTdPMUFZSE1CVnBORlRqenRQUkhVQjRQd1ZZLzV6eVJhV1pw?=
 =?utf-8?B?V3ZZMVlLSnBQbGV3UU4zNFFDVnY1SDB5elQ4VmtZejZTdVFBQkxMSDk4TXM1?=
 =?utf-8?B?ZEZYamtRakFmV1ROYW5nL3ZGYkw2aWhqMGhMVmJhcFA5MHB4bHVzaDVoZDZ6?=
 =?utf-8?B?WEtaNUF1NXlpenRmTnhubkkxRXFaN0FzcFdZSFJzWEk5KzAydUJvWWlzNS9P?=
 =?utf-8?B?WGJOcFRrTStIYS94UXZPajFjRFhNeEo2QitmbDhDbjlLNGI2c0hxaU5sS29h?=
 =?utf-8?B?dWFUU25SbDBKdTZBQjhBM1VHRDdVR3RZeGtTeHg3SDhnQy9MOHZsbWM2ZlNp?=
 =?utf-8?B?a2IzQlU2Q0x3STNBZkN5VjVFb0xWTzBVaVV5ZE5rOU5ocmhEWVBoQjJrRkdP?=
 =?utf-8?B?UTZxZ2lBWWhxRVozd0lxaTN0T2lzZWNBYnBkY1JkYkpqMUoxUmpOeXNxZXk5?=
 =?utf-8?B?YmJvRWJKSE5yVWZPN000QllVa0ErZ0tHOXkwRDh4aCsreGs4eXgwdDhaMFVD?=
 =?utf-8?B?aUd6anFmdlZvS2xJb0V3V3YxdVJZU0t6YTlQQVJoL2lYZUpGamk1NzhrNEww?=
 =?utf-8?B?VTdQMlNWTUg0YU5VamRvc3VaZkFVYkk2VUhnQXVuK2MwM0JQYWRBQ2lMbDU3?=
 =?utf-8?B?cVdRcEYvUzRVMnR0ZG5BZXo1RGsrMGxBNnhhSnFPQVd3UGZiYk9RUkhYUHdS?=
 =?utf-8?B?RVF2VE1IM3NHYXd2VkQvcFM0dVBJVllFRW15N0FpYWNrVVl5d1d6dkFTelNF?=
 =?utf-8?B?M2twcDZnb05jcWFBSElUNXE3MFo4d0dzcG44ZHA2bUJnN2MvQytZT1V3dUVY?=
 =?utf-8?B?WG11NjEyT3k4U2RpNXRidDF2SXVUWVg0VDIxUVd6Rlg2V25wTWZTTEREOWdy?=
 =?utf-8?B?RSthVmRwNHZseWpRWXlTOXIzbDB3cFdjRTNPN2s2SmRnYkhxTEZNV29FejZa?=
 =?utf-8?B?dzgyK1o4OUdnWHQ3eUpkTWxldTZCNUNxVE5hcm9OekdsaVlHLzFySGE0NXVk?=
 =?utf-8?B?MXB3bzJteUV0QzVBcTVrTHdBOGM1eHVlR0lrbTlUeUpNZ0VBclZJWlozK0FQ?=
 =?utf-8?B?TjBqVnVzUXVrRGlkTTRKbTh2YThVVThURTIvQnhyRzN4S0dnOWxTYjdpMVZu?=
 =?utf-8?B?bWR4L3B0YmVrcHk4SVVmVXBZL1hQNVlZaU5LaTBCdy9EKzdKZTFjS05yNXNN?=
 =?utf-8?B?VDJKeFdDZ3ExOUZtSGZ2MzdEcXFKZFhZN1RqaVNwOEVUUXlnSy9XelZzakg4?=
 =?utf-8?B?UXh0eFQyeWN2NGFtQnNxb2NUMXlQSVBlaFZtZUdYdWt2MjFjQlFqdVFBLzBO?=
 =?utf-8?B?aERtNWUwSEk2ajgvRTdhbWJ0Um1tSjJHS0kvUXJyZkttRWtLYVhtRFpTdXpL?=
 =?utf-8?B?aW01bEE2WndDY0tPclJIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdCSjJuY21KenY1YkxDWFZsa05KVlhLT3dIL3VIa2swK21QNE1uWmEyWlVh?=
 =?utf-8?B?Tk4wODU4RTNjU2lpeXlxYWRUZ1owZkhEK0xocmVnSDE1eUhySEl6aFhjT0Zn?=
 =?utf-8?B?ZkxOcmx5cTZtcUNFbzdZaFE5T2sxSXZRUjBENGdzQ3E0d2lVRzB4Z3JYV1pQ?=
 =?utf-8?B?TWczU200YlZ1aE10ODJ3SG5XWkptOWR2ZHVpK3JoMnZRNHZjdGtQZ0xxWmE3?=
 =?utf-8?B?UnFFK3ovcmFVUldWVzRia01lUDNKTlB4Nmx6V1ZTaUczc1FYajZBSExhV3JN?=
 =?utf-8?B?bUovdW5CcmNrMUcyRTQrM1ZTUnpnNnlEWUJ6M1gyaXFITjhoOXJzaEE3SktG?=
 =?utf-8?B?SnF4SVUySHpDL014TEY4dUc5cEtjYlBHTXRhQ3didkJpK2xqNTFuOFNEOXh3?=
 =?utf-8?B?elFPaFYzdjRJN3ZCbTFDWW1PQWcwQTBqa0hTSkgvWWRiZElPK1M4UkM5cnIy?=
 =?utf-8?B?djU5Z25tdGloRXpIWVk1aHhvTXcxMThiY29ya0hUMU1sd2RqYktSVkpJVCtT?=
 =?utf-8?B?YnJSUFRwV2RmM3JXMExUakZmbDk2QVliL2libnF5dURHTk1VN2dVSVIzZmNm?=
 =?utf-8?B?dU9vMDRNQURwdlk1YXhPTmd6SFdFZ1F6R2dMbEF0LzNtdEJjOG9neS9pUWxX?=
 =?utf-8?B?SjFhWE9QSFM1cXZidTlIZmVFTmM0N0hhcFJJOTlaWXRNelZCRDRxOUNuTVd2?=
 =?utf-8?B?eFVQV2tRS015LzkrcVlXZ3djK2thZmpRaW85K1BvZmQvY2ZrRFBCYU5jVUhv?=
 =?utf-8?B?QUFRZlRLN2lCRE5RcHNFVDN6VXpnRVpiM1hZcm5DcUt1emtsS0JDRFp2YWdQ?=
 =?utf-8?B?d3hjN3lRelZ3bS9ZWEtrZXRjN3BnTHRpMXgweDhBemJiNlpiQVVSQUE5WmJx?=
 =?utf-8?B?eG1ac3dzSm5mZWY1OVNIZkVZV090QVRiUkIvbGpETnYzazRoRFYvcjJaZjdY?=
 =?utf-8?B?YUpjVTN3bG95TkN1Z2hUNHRDUEJ0RXlQSnlQUklSczZQMEF2M3pDYldCYnBC?=
 =?utf-8?B?emhsa3BDM0pZSW9hTjhOZ2c5a05TSURGUi9CdzNqV1R2TGNuMERWQU1TUExr?=
 =?utf-8?B?ZktqZjZMdXZodFkxZVdEK2c4WkVVN0dpNkdkTXp5eWliZURuNXRtS0o0YStk?=
 =?utf-8?B?c2NXOWswM2dGOHIyN1BiWUlicXgxRU0wdEUxWUJNajBlcGxKRGJ3SlIzOE5k?=
 =?utf-8?B?REx2N0pHVjNnR2wxOWtCb0lXWXJrRDkzak9vd2dST2g3QStsN1VISnlONUQ3?=
 =?utf-8?B?b2k4T2M3WHEvdjNGV2VUVHRGM0wvdFN2QkRWTjlnRkZYOTd5Qnd6UjhaUmFv?=
 =?utf-8?B?T2RlUTNsMTJPK1NyOExnODA0RVVBMnBobjlBcUdXYnFyRjcyYkVQc0EvaExi?=
 =?utf-8?B?MFBZVTh0b2hONlRwYjZhL0NQZjZ6QTRGOWM0YVo5TytHeEpTbHd2c2t2ME41?=
 =?utf-8?B?MEpzM3R0bXdhMDVnVHc2SGFsVnVWU1ZCMUh3ZU9xRGlRVHQyMm1WcjdUK0o2?=
 =?utf-8?B?cVZ1QVpxWDQ4dDhtWG9pQVBBQWJKNlN4TGZDRHJLQ3hoYnRQdElWWHRnWFV5?=
 =?utf-8?B?UWY2UWJyMERGMTlOZWVPTUNTVE5Vd1NRZUY5NUx1UmVsNFY4ZEdzNzhnaEds?=
 =?utf-8?B?aWJBSXJKRUhuSmJHR1FleDgwM1dOTFd2LzNtUmVQZGV3c0FuRG9QTDZaM3Zz?=
 =?utf-8?B?ODFzcHIvOXA4SGVpR0hUSG51RzMzdTN2NnNVQ2ZkV0NJM1AwSjR4eWk3bHNS?=
 =?utf-8?B?OFVBS0szK3l4TUxFVkJZSkF2dTNYUG95QTZ5KzFOc1RzUGxaOFRDbDJpdStx?=
 =?utf-8?B?Z2Zvam5ZaTAxUHZYMEdlendQU0ZaYks0RE0wVzNObzdVdm5wMzFLb1poM3Jj?=
 =?utf-8?B?aDl6Y0VOVHBzTmVlU2FyQVh4YVp1cHlOUmIySUkvK05kU0ZuRE05Q2g5azlG?=
 =?utf-8?B?SDAwQUQzUktLVWZpY1B1bGF2Y0ZTWFpaVm9yN2lvcnpLTkM4NGUyRVNucjNi?=
 =?utf-8?B?aHBZbllaWnRhMy9GanVqZWtyU1BQLzNnTGNtQzJvTmRidUlHU3YvWHJLbUZY?=
 =?utf-8?B?a1ZBOG90ZnBXWnZybkNpK1lvd1IvV3hzUDZpakNLYk1RcDZMeGkwOEF5cnVu?=
 =?utf-8?Q?WjEuQH+WJ/JJL332bj2aqLqpC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49816c83-2f94-4d85-258b-08dcc2b76d82
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:33:45.3881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTD0QJT8u5kVRT7JnNuov7JHlq3zzbtN3atqT2G0zJrhTLAWcDl0KeKTAfWFYBID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

--------------zjNluxd4CmtEOKpppTFpeLbT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-30 16:15, Philip Yang wrote:
> Document how to use SMI system management interface to enable and
> receive SVM events. Document SVM event triggers.
>
> Define SVM events message string format macro that could be used by user
> mode for sscanf to parse the event. Add it to uAPI header file to make
> it obvious that is changing uAPI in future.
>
> No functional changes.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  45 +++++----
>   include/uapi/linux/kfd_ioctl.h              | 100 +++++++++++++++++---
>   2 files changed, 109 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index ea6a8e43bd5b..de8b9abf7afc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -235,17 +235,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
>   		amdgpu_reset_get_desc(reset_context, reset_cause,
>   				      sizeof(reset_cause));
>   
> -	kfd_smi_event_add(0, dev, event, "%x %s\n",
> -			  dev->reset_seq_num,
> -			  reset_cause);
> +	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
> +			  dev->reset_seq_num, reset_cause));
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask)
>   {
> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(
>   			  throttle_bitmask,
> -			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
> +			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
>   }
>   
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
> @@ -256,8 +255,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>   	if (task_info) {
>   		/* Report VM faults from user applications, not retry from kernel */
>   		if (task_info->pid)
> -			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -					 task_info->pid, task_info->task_name);
> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
> +					  task_info->pid, task_info->task_name));
>   		amdgpu_vm_put_task_info(task_info);
>   	}
>   }
> @@ -267,16 +266,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>   				    ktime_t ts)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
> -			  "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
> -			  address, node->id, write_fault ? 'W' : 'R');
> +			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
> +			  address, node->id, write_fault ? 'W' : 'R'));
>   }
>   
>   void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
>   				  unsigned long address, bool migration)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
> -			  "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
> -			  pid, address, node->id, migration ? 'M' : 'U');
> +			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
> +			  pid, address, node->id, migration ? 'M' : 'U'));
>   }
>   
>   void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
> @@ -286,9 +285,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
>   				   uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
> -			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
> +			  KFD_EVENT_FMT_MIGRATE_START(
>   			  ktime_get_boottime_ns(), pid, start, end - start,
> -			  from, to, prefetch_loc, preferred_loc, trigger);
> +			  from, to, prefetch_loc, preferred_loc, trigger));
>   }
>   
>   void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
> @@ -296,24 +295,24 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
>   				 uint32_t from, uint32_t to, uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
> -			  "%lld -%d @%lx(%lx) %x->%x %d\n",
> +			  KFD_EVENT_FMT_MIGRATE_END(
>   			  ktime_get_boottime_ns(), pid, start, end - start,
> -			  from, to, trigger);
> +			  from, to, trigger));
>   }
>   
>   void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
>   				  uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
> -			  "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
> -			  node->id, trigger);
> +			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,
> +			  node->id, trigger));
>   }
>   
>   void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
> -			  "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
> -			  node->id);
> +			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
> +			  node->id, 0));
>   }
>   
>   void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
> @@ -330,8 +329,8 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>   
>   		kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
>   				  KFD_SMI_EVENT_QUEUE_RESTORE,
> -				  "%lld -%d %x %c\n", ktime_get_boottime_ns(),
> -				  p->lead_thread->pid, pdd->dev->id, 'R');
> +				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
> +				  p->lead_thread->pid, pdd->dev->id, 'R'));
>   	}
>   	kfd_unref_process(p);
>   }
> @@ -341,8 +340,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
>   				  uint32_t trigger)
>   {
>   	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> -			  "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
> -			  pid, address, last - address + 1, node->id, trigger);
> +			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
> +			  pid, address, last - address + 1, node->id, trigger));
>   }
>   
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 71a7ce5f2d4c..c94182ad8fb8 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -540,26 +540,29 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_ALL_PROCESS = 64
>   };
>   
> +/* The reason of the page migration event */
>   enum KFD_MIGRATE_TRIGGERS {
> -	KFD_MIGRATE_TRIGGER_PREFETCH,
> -	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> -	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
> -	KFD_MIGRATE_TRIGGER_TTM_EVICTION
> +	KFD_MIGRATE_TRIGGER_PREFETCH,		/* Prefetch to GPU */
[JZ] could it be per-fetched to system RAM also?
> +	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,	/* GPU page fault recover */
> +	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,	/* CPU page fault recover */
> +	KFD_MIGRATE_TRIGGER_TTM_EVICTION	/* TTM eviction */
>   };
>   
> +/* The reason of user queue evition event */
>   enum KFD_QUEUE_EVICTION_TRIGGERS {
> -	KFD_QUEUE_EVICTION_TRIGGER_SVM,
> -	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
> -	KFD_QUEUE_EVICTION_TRIGGER_TTM,
> -	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
> -	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
> -	KFD_QUEUE_EVICTION_CRIU_RESTORE
> +	KFD_QUEUE_EVICTION_TRIGGER_SVM,		/* SVM buffer migration */
> +	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,	/* userptr movement */
> +	KFD_QUEUE_EVICTION_TRIGGER_TTM,		/* TTM move buffer */
> +	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,	/* GPU suspend */
> +	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,	/* CRIU checkpoint */
> +	KFD_QUEUE_EVICTION_CRIU_RESTORE		/* CRIU restore */
>   };
>   
> +/* The reason of unmap buffer from GPU event */
>   enum KFD_SVM_UNMAP_TRIGGERS {
> -	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
> -	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
> -	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
> +	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,	/* MMU notifier CPU buffer movement */
> +	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,/* MMU notifier page migration */
> +	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU	/* Unmap to free the buffer */
>   };
>   
>   #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
> @@ -570,6 +573,77 @@ struct kfd_ioctl_smi_events_args {
>   	__u32 anon_fd;	/* from KFD */
>   };
>   
> +/*
> + * SVM event tracing via SMI system management interface
> + *
> + * Open event file descriptor
> + *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
> + *    descriptor to receive SMI events.
> + *    If calling with sudo permission, then file descriptor can be used to receive
> + *    SVM events from all processes, otherwise, to only receive SVM events of same
> + *    process.
> + *
> + * To enable the SVM event
> + *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
> + *    mask to start record the event to the kfifo, use bitmap mask combination
> + *    for multiple events. New event mask will overwrite the previous event mask.
> + *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
> + *    permisson to receive SVM events from all process.
> + *
> + * To receive the event
> + *    Application can poll file descriptor to wait for the events, then read event
> + *    from the file into a buffer. Each event is one line string message, starting
> + *    with the event id, then the event specific information.
> + *
> + * To decode event information
> + *    The following event format string macro can be used with sscanf to decode
> + *    the specific event information.
> + *    event triggers: the reason to generate the event, defined as enum for unmap,
> + *    eviction and migrate events.
> + *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
> + *    addr: user mode address, in pages
> + *    size: in pages
> + *    pid: the process ID to generate the event
> + *    ns: timestamp in nanosecond-resolution, starts at system boot time but
> + *        stops during suspend
> + *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
> + *    rw: 'W' for write page fault, 'R' for read page fault
> + *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
> + */
> +#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
> +		"%x %s\n", (reset_seq_num), (reset_cause)
> +
> +#define KFD_EVENT_FMT_THERMAL_THROTTLING(bitmask, counter)\
> +		"%llx:%llx\n", (bitmask), (counter)
> +
> +#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
> +		"%x:%s\n", (pid), (task_name)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
> +		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (rw)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
> +		"%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (migrate_update)
> +
> +#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
> +		preferred_loc, migrate_trigger)\
> +		"%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
> +		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
> +		"%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
> +		(from), (to), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
> +		"%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node, rescheduled)\
> +		"%lld -%d %x %c\n", (ns), (pid), (node), (rescheduled)
> +
> +#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
> +		"%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
> +		(node), (unmap_trigger)
> +
>   /**************************************************************************************************
>    * CRIU IOCTLs (Checkpoint Restore In Userspace)
>    *
--------------zjNluxd4CmtEOKpppTFpeLbT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <div class="moz-cite-prefix">On 2024-07-30 16:15, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240730201547.13590-2-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">Document how to use SMI system management interface to enable and
receive SVM events. Document SVM event triggers.

Define SVM events message string format macro that could be used by user
mode for sscanf to parse the event. Add it to uAPI header file to make
it obvious that is changing uAPI in future.

No functional changes.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  45 +++++----
 include/uapi/linux/kfd_ioctl.h              | 100 +++++++++++++++++---
 2 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ea6a8e43bd5b..de8b9abf7afc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -235,17 +235,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
 		amdgpu_reset_get_desc(reset_context, reset_cause,
 				      sizeof(reset_cause));
 
-	kfd_smi_event_add(0, dev, event, &quot;%x %s\n&quot;,
-			  dev-&gt;reset_seq_num,
-			  reset_cause);
+	kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+			  dev-&gt;reset_seq_num, reset_cause));
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, &quot;%llx:%llx\n&quot;,
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(
 			  throttle_bitmask,
-			  amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev));
+			  amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev)));
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
@@ -256,8 +255,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 	if (task_info) {
 		/* Report VM faults from user applications, not retry from kernel */
 		if (task_info-&gt;pid)
-			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
-					 task_info-&gt;pid, task_info-&gt;task_name);
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(
+					  task_info-&gt;pid, task_info-&gt;task_name));
 		amdgpu_vm_put_task_info(task_info);
 	}
 }
@@ -267,16 +266,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    ktime_t ts)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
-			  &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_to_ns(ts), pid,
-			  address, node-&gt;id, write_fault ? 'W' : 'R');
+			  KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
+			  address, node-&gt;id, write_fault ? 'W' : 'R'));
 }
 
 void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
 				  unsigned long address, bool migration)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
-			  &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_get_boottime_ns(),
-			  pid, address, node-&gt;id, migration ? 'M' : 'U');
+			  KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
+			  pid, address, node-&gt;id, migration ? 'M' : 'U'));
 }
 
 void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
@@ -286,9 +285,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
 				   uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-			  &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;,
+			  KFD_EVENT_FMT_MIGRATE_START(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, prefetch_loc, preferred_loc, trigger);
+			  from, to, prefetch_loc, preferred_loc, trigger));
 }
 
 void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
@@ -296,24 +295,24 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
 				 uint32_t from, uint32_t to, uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-			  &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;,
+			  KFD_EVENT_FMT_MIGRATE_END(
 			  ktime_get_boottime_ns(), pid, start, end - start,
-			  from, to, trigger);
+			  from, to, trigger));
 }
 
 void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-			  &quot;%lld -%d %x %d\n&quot;, ktime_get_boottime_ns(), pid,
-			  node-&gt;id, trigger);
+			  KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,
+			  node-&gt;id, trigger));
 }
 
 void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-			  &quot;%lld -%d %x\n&quot;, ktime_get_boottime_ns(), pid,
-			  node-&gt;id);
+			  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,
+			  node-&gt;id, 0));
 }
 
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -330,8 +329,8 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
 
 		kfd_smi_event_add(p-&gt;lead_thread-&gt;pid, pdd-&gt;dev,
 				  KFD_SMI_EVENT_QUEUE_RESTORE,
-				  &quot;%lld -%d %x %c\n&quot;, ktime_get_boottime_ns(),
-				  p-&gt;lead_thread-&gt;pid, pdd-&gt;dev-&gt;id, 'R');
+				  KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
+				  p-&gt;lead_thread-&gt;pid, pdd-&gt;dev-&gt;id, 'R'));
 	}
 	kfd_unref_process(p);
 }
@@ -341,8 +340,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
 				  uint32_t trigger)
 {
 	kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
-			  &quot;%lld -%d @%lx(%lx) %x %d\n&quot;, ktime_get_boottime_ns(),
-			  pid, address, last - address + 1, node-&gt;id, trigger);
+			  KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
+			  pid, address, last - address + 1, node-&gt;id, trigger));
 }
 
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 71a7ce5f2d4c..c94182ad8fb8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -540,26 +540,29 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_ALL_PROCESS = 64
 };
 
+/* The reason of the page migration event */
 enum KFD_MIGRATE_TRIGGERS {
-	KFD_MIGRATE_TRIGGER_PREFETCH,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-	KFD_MIGRATE_TRIGGER_TTM_EVICTION
+	KFD_MIGRATE_TRIGGER_PREFETCH,		/* Prefetch to GPU */</pre>
    </blockquote>
    [JZ] could it be per-fetched to system RAM also?<br>
    <style type="text/css">p, li { white-space: pre-wrap; }</style>
    <blockquote type="cite" cite="mid:20240730201547.13590-2-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,	/* GPU page fault recover */
+	KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,	/* CPU page fault recover */
+	KFD_MIGRATE_TRIGGER_TTM_EVICTION	/* TTM eviction */
 };
 
+/* The reason of user queue evition event */
 enum KFD_QUEUE_EVICTION_TRIGGERS {
-	KFD_QUEUE_EVICTION_TRIGGER_SVM,
-	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,
-	KFD_QUEUE_EVICTION_TRIGGER_TTM,
-	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,
-	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,
-	KFD_QUEUE_EVICTION_CRIU_RESTORE
+	KFD_QUEUE_EVICTION_TRIGGER_SVM,		/* SVM buffer migration */
+	KFD_QUEUE_EVICTION_TRIGGER_USERPTR,	/* userptr movement */
+	KFD_QUEUE_EVICTION_TRIGGER_TTM,		/* TTM move buffer */
+	KFD_QUEUE_EVICTION_TRIGGER_SUSPEND,	/* GPU suspend */
+	KFD_QUEUE_EVICTION_CRIU_CHECKPOINT,	/* CRIU checkpoint */
+	KFD_QUEUE_EVICTION_CRIU_RESTORE		/* CRIU restore */
 };
 
+/* The reason of unmap buffer from GPU event */
 enum KFD_SVM_UNMAP_TRIGGERS {
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
-	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
-	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY,	/* MMU notifier CPU buffer movement */
+	KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,/* MMU notifier page migration */
+	KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU	/* Unmap to free the buffer */
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL &lt;&lt; ((i) - 1))
@@ -570,6 +573,77 @@ struct kfd_ioctl_smi_events_args {
 	__u32 anon_fd;	/* from KFD */
 };
 
+/*
+ * SVM event tracing via SMI system management interface
+ *
+ * Open event file descriptor
+ *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
+ *    descriptor to receive SMI events.
+ *    If calling with sudo permission, then file descriptor can be used to receive
+ *    SVM events from all processes, otherwise, to only receive SVM events of same
+ *    process.
+ *
+ * To enable the SVM event
+ *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
+ *    mask to start record the event to the kfifo, use bitmap mask combination
+ *    for multiple events. New event mask will overwrite the previous event mask.
+ *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
+ *    permisson to receive SVM events from all process.
+ *
+ * To receive the event
+ *    Application can poll file descriptor to wait for the events, then read event
+ *    from the file into a buffer. Each event is one line string message, starting
+ *    with the event id, then the event specific information.
+ *
+ * To decode event information
+ *    The following event format string macro can be used with sscanf to decode
+ *    the specific event information.
+ *    event triggers: the reason to generate the event, defined as enum for unmap,
+ *    eviction and migrate events.
+ *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
+ *    addr: user mode address, in pages
+ *    size: in pages
+ *    pid: the process ID to generate the event
+ *    ns: timestamp in nanosecond-resolution, starts at system boot time but
+ *        stops during suspend
+ *    migrate_update: GPU page fault is recovered by 'M' for migrate, 'U' for update
+ *    rw: 'W' for write page fault, 'R' for read page fault
+ *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
+ */
+#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
+		&quot;%x %s\n&quot;, (reset_seq_num), (reset_cause)
+
+#define KFD_EVENT_FMT_THERMAL_THROTTLING(bitmask, counter)\
+		&quot;%llx:%llx\n&quot;, (bitmask), (counter)
+
+#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
+		&quot;%x:%s\n&quot;, (pid), (task_name)
+
+#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
+		&quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node), (rw)
+
+#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
+		&quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node), (migrate_update)
+
+#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
+		preferred_loc, migrate_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;, (ns), (pid), (start), (size),\
+		(from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
+
+#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;, (ns), (pid), (start), (size),\
+		(from), (to), (migrate_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
+		&quot;%lld -%d %x %d\n&quot;, (ns), (pid), (node), (evict_trigger)
+
+#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node, rescheduled)\
+		&quot;%lld -%d %x %c\n&quot;, (ns), (pid), (node), (rescheduled)
+
+#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
+		&quot;%lld -%d @%lx(%lx) %x %d\n&quot;, (ns), (pid), (addr), (size),\
+		(node), (unmap_trigger)
+
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
</pre>
    </blockquote>
  </body>
</html>

--------------zjNluxd4CmtEOKpppTFpeLbT--
