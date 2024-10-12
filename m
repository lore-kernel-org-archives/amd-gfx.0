Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84134D1A42C
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Oct 2024 02:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3155A10EB60;
	Sat, 12 Oct 2024 02:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dc0uoCVg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F4C10EB6C
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Oct 2024 02:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq/byJzqlWqaqlWfkxbprmx5wu18R62V2AESMWpSFS0NVpksIl/EBKcrUpxASHUSkJQV8S6GL44XqwsP4bSatUMtrd13dxG4wrNmKiG69xQ35xQMy1L0a0KgwX1ybgBLHl+jIUGbpNsOAjSatB5yGd3J40e7ZWG7gJzEqwNVmTek3FCnlViait7sdEbc3mffPXpzm/+bdiAz0ilhsH6Se4NBgBAtwBv12NGHS/i+jVx5a4BGDEerei5HdX1VNqhEufObEcJh+WnreLmVidrqBE8pqXEAPRtulvBLqBftp5mgXpbghR+RgRHx6xjrwnh3W5C+wq8vjDhHXOQqibKA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSWUQEkjhUt8M494p8KfdDgbbQxlWEpTOQkq/YqO+ik=;
 b=aFVYCVyfngEYvgK+6GVqh0mAn/1ZdUxf23OWa92UbgqxMAZ/3TvdZ6THatQQQbLfIyMPnC/6Da4RK8XwSKgIKUtjKgj2qcn5tmppuTmvuXR9QrPKGUKefNIxGabHDo9xpj1t+fRU1ihZsWuOkxY8qj8onv4WURTQ0lQ62+Uddw5hcS7nnk7UIOm6AXB5NzQ6yLnhYJp+j0V2GaeviXl+TLi/aH2ol+GKXzESNAStP7l799zcrgwwFiMOlfQQqxMcwQUDp1vSao/IypD8Z+GhMs6GqF0qkjoZrdUyfZc94M+zBtGthzZ+qnCDC+kmsbuj3ftPcHS5zJgYZHB+/6LUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSWUQEkjhUt8M494p8KfdDgbbQxlWEpTOQkq/YqO+ik=;
 b=Dc0uoCVgy8/OVdmt3pKmREgc3jRdhAwxb6md5UofwOhMNFQqkiZz/fSP1OIpF954CWQcDu4nuqgysKN4d5R9hp+p0lCJ1Y4yLKEeDlp+B7s2Z/tWPQ/GtRazSND23P6p4+MTMPUJfxEqWK3WBA5yt26YO2EZJX5UTNEtc1nq7uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 02:56:44 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8048.018; Sat, 12 Oct 2024
 02:56:44 +0000
Message-ID: <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
Date: Sat, 12 Oct 2024 10:56:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <20241011144155.120290-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1c2cfe-ba93-468a-9e30-08dcea698140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXJaZGsxWmN5VkpDRWFkR0VtZWI3R0I2ZmpuVEVVSUxhT0U0a1h4MzNyOUpr?=
 =?utf-8?B?K1FTUGE2VitmYlhqVVhmUnNmcVY3R0M2VUMwZkFFZFpFc1JHQnMySGxDbEZS?=
 =?utf-8?B?bXFmYm1PQWtmYlZ5S25Yd0RBUWlXdFI1SjlMWFQzWmZsY2t0UC95NmZxZnhE?=
 =?utf-8?B?RzExa1gxaUJTcTd3WmZmVFRuckx1QmlUM2hpdmVkWENUY25TYW5EbGQyY242?=
 =?utf-8?B?NDEzYVJvSjRqUDlGeW01MmUvbUdnZW1uYWtEdHpQdXppSGhmT0JpVVQxRmd1?=
 =?utf-8?B?OWl4anRBRktyR3h4cm84bStwdlhyYTZHTXJMRUNvTjJTak43SzVveHJEM3Z4?=
 =?utf-8?B?RnFOdE9EOXFzbHBpNnZwSy9rUld1aGJ2ZUxPa0ZmdFVrM3Fpb3ZFbEdJUWUw?=
 =?utf-8?B?bW51VTRmSXdhcDgyWXhsR3Y1U0N4NDU3L0x4bEpSOEpxWTBMSm56c2g2M24w?=
 =?utf-8?B?OE5CTjZuR1d3UkpWYVI5Q2lWZkZobEZ2MHExUmtpUzZTekovbXNyMGZrU1d1?=
 =?utf-8?B?d1Bydm9oMlNWL21EOTRWK095WVhUYTF2NnVwKzZIaEk0UkJBU1J6VUE5LzRS?=
 =?utf-8?B?czZTdHowODk4TFk3dWxYZnZCdFJVcFVyUnZKaWdRQ0VlWEFLVThpc3RQK0li?=
 =?utf-8?B?VDY5SWMwMytDeUUvQnlIcXBqV3hFc08wTTRsOTdRRnczcEl1U3p4N0JVaUxJ?=
 =?utf-8?B?aVpiRmw1YjdCdW4yeFRPWFVDQyt0YWg3N2dSeDlOaHg4WW9KS1owOWU0K0E4?=
 =?utf-8?B?RzREbDNlNGs4SDNwaGNYdlQyY3hVazFDZklkRzl5SFluMVRHcHdZUEF1Yy9T?=
 =?utf-8?B?b05IY2d5RkpXb3dTdFhJOGhKNjE3M3V3QWhJSXNCejcrUFFYSjBDRW5nSUc4?=
 =?utf-8?B?Sm1uQWlvQ0NKMW5TU2RJWmlqL01MSUJiZnZJMXJSOUVpaVovSjVkQmRnc2Jn?=
 =?utf-8?B?R1h0UE9XTitVTHF6MjdhK3JyaUQyYS9iQjE3elJDN1c1ZnVNTkE2eUMzNng0?=
 =?utf-8?B?OUdtcnZwOUhrUVZOMnM0Vm01MzF1NFUvWUVWMnZMeXVOaEt3N1R5RnpiOGM2?=
 =?utf-8?B?OHVJQnVBVFJKNmcyZkhRWDg0T0pjOWhKK1E2TDE4N1JGbC9Kb0pSTHZOVXkv?=
 =?utf-8?B?RWRORFFDUjRYc2lpZ3BCREJETkJSY2hyMlV1OUpiMGJ1eStxMW1SS3ZZT1JY?=
 =?utf-8?B?RC9va2Q0NmtOR1V4akJ6L1ZqcmZUN05MZm53djZZUm52UExlcEJ2UmZKZ1JD?=
 =?utf-8?B?V0lDMDBuajFQOGExdUN6VDg4cjBZVXBCUGd5YUNrQW9IS1Q4YzN3L1RKZ0Rj?=
 =?utf-8?B?RkZ1S3ovZkVnNTF0UytuWThrVTM5QW44b2hzQW5VdVlLK0owMU5KU01CTVA2?=
 =?utf-8?B?RjcwY1Z2U1pjTmtDaENsVFE0LzZzOUg0ZlNsbHM3L3R5VjlWeWZ0MUE2alow?=
 =?utf-8?B?MzN5ZUdJSzBVZDdBWnZVaU82QktHOXJMQWtINFpGSkFpN1RIeUljazJLdndi?=
 =?utf-8?B?U3hPVlYwaGZxdVBhTmtGOCs0VXBEU2FNSzBEeXZQYnJyaE0zbjNGbHZxVHVV?=
 =?utf-8?B?aWM0UTRsQzdSNFRxNGp0WmRTUWpjdStFUlY2YlFYaVp5TytoTklvZkJWYlFj?=
 =?utf-8?B?K1FFTHBSQUdvSTVUeGt4dFV3Y1ZBT3ozd0I5OVR1bUJXS054em9QRWhIQXNn?=
 =?utf-8?B?T1l6MDdQQUFRNW9iUWtBbkNzZEE4V0lPbWMrU3BpSjIyTmVWSUx1Wmd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG8rV2RudWhvd2tOWnJ5bTE4R0l4RjZHRnlORFN1SVc5YXFvYWNpdytqbnpn?=
 =?utf-8?B?MDJXSXQ2Tjc5cHBxZ2o0MEFWTUdYYU1TcWMyd3QrVnR2TGNFWVlja0h6R21V?=
 =?utf-8?B?Rll3NGZnczd2RFlEL2tHbVh4S3dRdGJ3c0pDWDV5a3pIUWJYaFJBZ2hxOEdp?=
 =?utf-8?B?WHhLL0NSeEsrS1NRWmF3ejcwQXVrc1pTV052Mm5nMnFXZjhldS92R2JSRURE?=
 =?utf-8?B?cWdiZ2syb1ZRNEYzUWFYQ3BvQWhEcHNYaVIyYmxGSkJLdTZSS2ZsdzFPRHE4?=
 =?utf-8?B?UEo0SFh0dFhjOVNpR1RPSE0vR0pwTmlQa3Z0KzI1bklsdFVzTXFsSVNNdXh4?=
 =?utf-8?B?YmtqQ0F3MmlSdlBIZmhrWEhlUDJXMmpkWUxYaXdPeHNMVWdLdHUxSmh1MjVG?=
 =?utf-8?B?WXZLVHhDSFd5Q0dOUi9sbXdrL2NYUk4wdG5uK2UvQUJmNXVSS2JnNWhUYm1E?=
 =?utf-8?B?TmlqTVlNS1psK2orK0p0MGM2d2N5TmdlR0FPVmNhdW9UaGNHRVYwRkxmWGtT?=
 =?utf-8?B?WmNIZEFyNkhiRFVFSk40VnpzNlB6Rm9YSDhHR1lPSlFFT0hqRnN2RnAwSzM3?=
 =?utf-8?B?TFgzcEJXQ0E2OUhBSWN6RlA5cUM5d2xhSXROa2QvRHpsRFNDTEt6QmNqS2Nu?=
 =?utf-8?B?dEZJWmMrNzZMRUhuU1JjOExFVkpaTndOK3J0L3lsTFpzQW1maSs3MFBGLzVQ?=
 =?utf-8?B?UFBocG1GVVZ5dlJOMytEU0RMU0JnSHBNRG9FajIwRUgzU1U1UXEzYkhabGxm?=
 =?utf-8?B?L3YwdnhsWWkxU2VzTXdzS1JTcGJ0VE8rdlRRRlpKeUowdWtRVG90ZHFQODlI?=
 =?utf-8?B?aWI5R3dCR2s1YUxiVnlxN3Z2OVZMSmdadDRVVEJHZDMzSENqV0R6M245aE9J?=
 =?utf-8?B?NS9KQklRSE90NW16dTVnY21xRFlnYldUdE9KdzgxeGVSNTZpSzhrR0h1SGQ3?=
 =?utf-8?B?ZlBCSVg4NEdKSDkzYnRkc01GSVplcWwxcTh6V2RuWHNDcFBpenU2U1hFSDVl?=
 =?utf-8?B?Mm0yLzVnaW0xSXhoNjBGYks2VTBPTU14MjVnMG9VbzhPb09oZWdsOFA0NUth?=
 =?utf-8?B?UFIrZDlQTnBQU3NmTGFoaXc5eDFXSFRzUnQwZnB6ajZMdHdkWi9ZT3Q0anJy?=
 =?utf-8?B?cjZNZE5UYmphQXRiY0tmK1Jtc0RkdHdaV0Y5QTc2TFhEY2tkbUY4ZjRaSG5N?=
 =?utf-8?B?dCtweTc3UHRQc3l0QWhxL3RWQ2VFdlFaYy9hR09sREJZZUY2MnZSSUhHd01i?=
 =?utf-8?B?TGdMejMzT2ZNaVVER1luaDNtMmdRaWl3ZzIxYmZzYkFQV1NTb093bDArSkpa?=
 =?utf-8?B?UG5LT3lGMmR1UnhEaGxTdEo3UmQ2OHpGbDMwdDBpSDQ3OVlEbFkyN0lMRUhp?=
 =?utf-8?B?eitZbFF0SzVDYmdrMGVlZnJtNnNYVW8xWXVjL2p6eU9qWnZRMVZQRjJya0Zu?=
 =?utf-8?B?RWtoZEN1OElzYXZRb2p3MlRsczNPWXdRVG9QejdBc2RqZE9nZDFKbmg3TXNk?=
 =?utf-8?B?WHIxK0xRN2lsYkpDUW9tMFVBdkdkMmxuLzQwVTEwVGRReE9uT2Z5NjNhbTZi?=
 =?utf-8?B?U0xWdzRYNGFTTjFFaHJESUhsTGlMTktUR0ZtMTNmRTFWeHZQb1d3S2pKWjZh?=
 =?utf-8?B?TWZ1SDNGck5vSk1DLy8vUWNpQnVtK3lYVjlvQkwvQzJHaVZEQUI5c0FpM0d5?=
 =?utf-8?B?Yjd6elI3QXI0NWwzQU1vM0UxWXBLUWdlU1ROeXJhVTl6M3EyTzFDSmQ0dm5M?=
 =?utf-8?B?dTFMT0VDVzgxNGJPY0c5N3FwbWtneGpTOUJFTnhyWDFMTEd3TTdPWXc4a1Mz?=
 =?utf-8?B?a3VidVNQQkVocG12ZWhoWlROUWh6UWtIL1dXVUNOWGQvSENvZXYwSWFqZURo?=
 =?utf-8?B?N0NKMlZNUVRqT1FxYjVrajJJUExob0IxcEFEQ1lTN3NqTDdieGJ4Q3hxK0Nu?=
 =?utf-8?B?UklsWFB2VkVzeDlYS1JqbDUvTS8rMjdySmh1T0podDVkeGEwd0hlOXBUclQ1?=
 =?utf-8?B?MmJXTm44ZzNHYWZCZnRkMGhIZFFYc2VEbkF3ZmtRUEtvdW5DcTB4R2ZGcjY5?=
 =?utf-8?B?cW8zdVRZZDZaRTdjZlg0dk9uT0lvK0UxKzlLRHd6UHJaOFl1azhmK0dSaDQz?=
 =?utf-8?Q?z6K8WYIYd9ANNyzvlX0sX0nBo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1c2cfe-ba93-468a-9e30-08dcea698140
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:56:44.2805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQR+dOAnmSb+7HdCVE8DZW3gq7cYD1OhNjHnZDQeGAXyXNovuKKk3uUNUk/0lo7ezG4Sgs4TEGGVup65CcQJmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
> it is created not need to increaes its kref. Instad add kfd process kref at kfd
> process mmu notifier allocation since we decrease the ref at free_notifier of
> mmu_notifier_ops, so pair them.
>
> When user process opens kfd node multiple times the kfd process kref is
> increased each time to balance kfd node close operation.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..78bf918abf92 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>  		goto out;
>  	}
>  
> -	/* A prior open of /dev/kfd could have already created the process. */
> -	process = find_process(thread, false);
> +	/* A prior open of /dev/kfd could have already created the process.
> +	 * find_process will increase process kref in this case
> +	 */
> +	process = find_process(thread, true);
>  	if (process) {
>  		pr_debug("Process already found\n");
>  	} else {
> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>  		init_waitqueue_head(&process->wait_irq_drain);
>  	}
>  out:
> -	if (!IS_ERR(process))
> -		kref_get(&process->ref);
>  	mutex_unlock(&kfd_processes_mutex);
>  	mmput(thread->mm);
>  
> @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>  
>  	srcu_read_unlock(&kfd_processes_srcu, idx);
>  
> -	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
> +	if (p) {
> +		kref_get(&p->ref);
> +		return &p->mmu_notifier;
> +	}
> +
> +	return ERR_PTR(-ESRCH);
this cb should only allocate the notifier (here it returns an existing notifier ),
so I am not sure this is a better place to increase the kref, it seems coupling
two low correlated routines.

kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.

Thanks
Lingshan

>  
>  static void kfd_process_free_notifier(struct mmu_notifier *mn)

