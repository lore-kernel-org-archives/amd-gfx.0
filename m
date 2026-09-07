Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3769C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 08:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F5810E6E7;
	Mon,  7 Sep 2026 08:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4XhIThy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E4F10E6E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 08:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZUaaUQfe/FjFRoYTItmEbCmoIGxSee66hQlz6oa0fwuu5+9kjKiDivc68NPLppcqlg1GZJJY7wBqIVOckSaXfBB/i7CwsVKAjVG6zu1CEQXGdNxwwW6NYW86kwYGAfL0QuewDvad5gYvPdQokXLMoDfpPwhOeG72PwOB+5ChbmCntuQnJP8YaTXgWqXWzzx2B3pWH3E9wEw+5Y1TSwJkv2Uj5km+TVob0fJaSRD0f+Mp1dfgGEsWMe1Ecvb5Qceo4JcYvK2uCSh0nlzXeoDjEGeCDEu81AKKy7d5oGmlT79nXkMXBEvpjjT4uDw42Pdb07iOUUGmuQ7+UV6JvydKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXKobd3NbGZbzEYeBX7DyecAg2YKpB6FLInNVWF+2xA=;
 b=kkLbWW9fqIJkHul1bD9AYAYWX8Z9bp2GZxpxH+eRBR9INReWbPDA3zkjrUNJe2KXhs5g0B/Kz77s4RdU/MtksPMA9/BnrK/Mt2NGZ8R8kSR6iebSWGECWHvLoKRX+4hu3V3CBf6tPRo9mOb5vauoEIQENmVLXQr76s//kpNa2nzxwmQzbek9RBuhVUdZvCElJmA3ovVKb3CzG2TlqLsvLpgzDno2/uoiLO07JubzP5fp4EApifI3NhcDIa0gFsVpNSjyBA9e4wMynXEjLhjt+m5PretZrtJ0UAZkQe6HlDtVBNhwk7SJy+TXK/uVbzcLTAVzx66ZeFkYUKmyIVslzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXKobd3NbGZbzEYeBX7DyecAg2YKpB6FLInNVWF+2xA=;
 b=Y4XhIThyApMpxQXgLQeZ0+fCvTRpNoEclPN511Y+hFS05y9dioUjtdR+GfDjZNFLCLtyZJmoIZTJtJcXeKU1GvWhfJVGw53INVY5aIODEhMqhkxXPIGla4jF7FGTsMhXmj8g0ueqm0edfR4zPi6/+IO0iqqQyYhVB+oikL3Yywc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EA3PR12MB172729.namprd12.prod.outlook.com (2603:10b6:303:30a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 08:54:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 08:54:02 +0000
Message-ID: <f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com>
Date: Mon, 7 Sep 2026 10:53:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix userq_signal_ioctl stuck in
 drm_exec_until_all_locked()
To: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, sukhatri@amd.com
References: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EA3PR12MB172729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bce4530-7530-451b-1562-08df0cbd9052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3M+MTiR9p+hT1uFMc0ZobxA5SqBrDQLKgKq6q1LH+9HQGtPmFR9NAWM1292hJ7r0WirtLh6uzNOT+DQgEz5NzgT+HNIc1hQnWLvv7EqNR5n/eHhoI5cPCvYSnKzIRcKSNV/WqfYumzc7Q5/zvrG65gKGFyftE/expB9KrMiWtAIyWr/OjaTCgJGE21nfM1zMZ3Ra8C4M6bFIyIHh0jcsV9g5acFPIMAl3GGEpwYoLHa91artF2USApOxS+lxDGXDvyprW7FyBZooUBaHA15JxUs+URzpttBG2FsalvJXYLRMiRPJ3uWVjlCl/Z2Z4rsKdY4rDKJAdN4LZ95f05HGVrWxgLKsEQ2t0M78MZrLRbwYVz1fgsMMOyD3zBivkRwV2Ook6a5sqpuAKZsmEM6msfrlgxRVwHZPCX71beX3PkfyuSVcejU2vl4EPb+stIOHN68XwqOeyb4YrDxT9r11kGpv+J/sPzAk9AuatKb1eqCC54cxIC74VRpFkKhi6atcrttkqnoqMkw7obDldyuHBETzApfePTca9YD8B8mdA/ESzdSuj3J7T2JT5j6A38mJyJCkJrP/unF6dmWCr8Jibn1M6dbwbBmCYOSmw7PZpvlEdGpFejXoZol/rG2aXPEO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFEwVEZIVWlYVlBHRC82Q3NabTdwUjNUTUtmbFJ5SzBiVlhmZ2c2QU15cVlv?=
 =?utf-8?B?OXgyeEM1R3pnWE1JaHVBbFlhcHl1VXJNakFhSGRFcmlxUmVDcURmbW1qOVJD?=
 =?utf-8?B?em8xR0JYS1lRTHVYREZoWjFxeUZqeDQxZTBOc2VicTlxaVBCTm1qU0dGRGsy?=
 =?utf-8?B?dVRrbmhuanovU0pZMmcxVUFsU2N6dDhIOXVyQ2pPazhHc3lza1BSQ2NGRkhh?=
 =?utf-8?B?aGlmdFRrYkNxTnlSZlJva3hVbjhEMXh2YUhMV1R1ZjhJRGIvZHJoWU51TTc5?=
 =?utf-8?B?K0xaaUUxQ0tFRVpFL05jRnVSTEFSM3dMbndpT1cxc2RQRXpicmFPZFdpSi9Z?=
 =?utf-8?B?Rk1LQ2Z2MXVDNS9YcXRBeHRyQ0F2d3UyelpOKytLdWFIY3Q2WmtTMnZjeVYw?=
 =?utf-8?B?QTZTUHNVd0t5TGkzRDYybkdCQWMzek9Iek9mL3pkS1ZtZkZlUVpYd1grNWVq?=
 =?utf-8?B?TmhJSVU1N3pJOWpCcjV4emZvOWRpSTU5Z3o3SHlzV0lkVDM5eUl3NDZmdXV4?=
 =?utf-8?B?RDRaUjVOMGtNOXUwaStqOXUvL0lxQVBLeENJZytUS1BxZGlvdHlBR21BbktM?=
 =?utf-8?B?OWMvVzA1S0dhVVdwcGxDRlBuc0hwM0FLWVBQUHErNWRVVU5UN1Y0L2thOGxP?=
 =?utf-8?B?YXI4RW9ZWEtEWlIraG1WcVJncENoMDcycHRxTG1xUnc5QjdFeG1TTzdxcHdq?=
 =?utf-8?B?VnJ4V2hySnhRYjlxRXRpckFySFRsVzZzamJvSVR3V05MeVd0aWJSUE5jTVZo?=
 =?utf-8?B?Qjhsd2hsMHpFSWlYVXUvZXdIbzJEM1hSNlJXY1R4bTdDSzE3Z05Id2crUUZ4?=
 =?utf-8?B?LzNmL095QXA0Wi8wYjJEclFlVTAvQm81L2hoR2duVG1ValJHdUpnRUo4QnZD?=
 =?utf-8?B?bWpBZGtMKzlQMU1GczF5TmRuNVZjem5kWXVSTGMvTzFFck5RRUNWdWp2bVpa?=
 =?utf-8?B?Q012RktyNG5XUnhFQ1ZDdmk2WUFIYnc1dCtLaFVremNONUxCUEdYY3N1WEhW?=
 =?utf-8?B?ZGZLMkd3d0ZWb3Zmd2thbGtyeWFibXlPREFHRzR4MThBRlN1MEl6dmJITWRs?=
 =?utf-8?B?M0JsU1J2cEhFMkowb0tURFhRMitYM2tSNVVpM2hXZ0RFK253NlZFOWJMNDcx?=
 =?utf-8?B?YTZkNGVHTGlHMXkwYjAzUVNsMXJXNllZSjQxdUJ0VGdZQlphZEFxcW9nenF6?=
 =?utf-8?B?OGxUKzRNYlBVNmF5cUg4UGhlcG9RR0pKd1pIeVQxWExTdjNNbEtZbWVKRnBR?=
 =?utf-8?B?LzVFQVc0RlJMYzg2RFJXQnZIbDF3S2hRUkZ4NjZSUVdlTXh3c1h1aWhUbnNt?=
 =?utf-8?B?R3ZzazZaLzllaEJNNG1uU240NzJad3lvQzMyOVRiUnNhZitzRS81a3YzWG1G?=
 =?utf-8?B?R2xXYkp4RFlHdVJjNkRYclZ4NEJXb2d0dUxINVc4dVBtTkYzbSt2TTc0U0Ns?=
 =?utf-8?B?dkpmenBGVkgya29HME9Wci9QNjVXVkFKQUZieG1iY3RoQkJWcHlqdjIyMWMv?=
 =?utf-8?B?ZGMxR3l5ZFBBK2xPR3lCT0FCMWtHRkNRZTFlRHdrbGtXOU9JTU9uNitkMjh0?=
 =?utf-8?B?K1RYMlN3cDZtUkZUNU1DcWlmZ2JMRlVJa3FQbDlWQklaSTJUQjZsS0JKT09E?=
 =?utf-8?B?aEw2U1BYVUxhU0FIWCtsWjNLalVGdWFkVkdicnM1Q013V3F5bnpKU3czNFI3?=
 =?utf-8?B?Tnh1ODU4dTRHNi90dzRPejJTUjBBZ2RKSmhDelpYUHZ4V0tuMndiRS9GdUcv?=
 =?utf-8?B?aDFWZzZydEEzOVRXYTNXbnZUeWNVN0hBTDYwWjlBQlRDRDdvdzR2VGdheThC?=
 =?utf-8?B?UkdGT1RlczZpVE93bm9BWEZOSjJRdFppMkRNYUZVYTdXM0NKUTNiM3ZLODhF?=
 =?utf-8?B?aTlBMVptNmJSK1JiVVpnUzlFQkFENmkvMzdCTU1hSUdDaWNYY21lbis4aTgv?=
 =?utf-8?B?VG5Rcnp2V0M5cWtwa0hkOVU4c1duZzRkUXBRVy9vck55OGtOMVdOSVZnUVB3?=
 =?utf-8?B?RXVqdDNLN1h4WEZjZXIwWWlvK09YY0xYbG5nNFBOZmNUWUphVS8yLy9hWEJB?=
 =?utf-8?B?RlRQZDZqZFI5V0xuS3RKb2kvV0M0b2c1WkV5THJGd1hVWmUvVHNjQkY3Qko0?=
 =?utf-8?B?YnlsWVFPbDBWY2lyWUNqLzdXQWdmaVl3STd0bUhLQmZibGlXUEYrWmRqeVpG?=
 =?utf-8?B?QXZuTm9LNGJtZ3VlY0VuQno0Q0hvRVpFSFFxL05yWXhxZUtPaXZINzJMaFd3?=
 =?utf-8?B?cHFRcnNHK05TSGdSdXBEeXJUaFcrM3RxMERQTEJyZTQ1T3ZmMThlbGdHTzBG?=
 =?utf-8?Q?yFS9/mHY+rWKSECzhD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bce4530-7530-451b-1562-08df0cbd9052
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:54:02.0974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEoFBvsbFfT+CWcfKqDbvegS+sBmXw8HUAK6rW56t/zSFbEVVbypeX1DXgXif2M3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR12MB172729
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

On 9/7/26 10:47, Yogesh Mohan Marimuthu wrote:
> If in userq_signal_ioctl only bo_write_handles is passed and
> num_bo_read_handles is zero then if there is contention the code is stuck
> in drm_exec_until_all_locked()
> 
> This happens because read bo's are handled first and then write bo's in
> drm_exec_until_all_locked loop. When there is contention in one of the
> write bo, exec->contended bo is set and the loop is retried, but
> read bo is zero, still drm_exec_retry_on_contention() macro for read bo
> is executed without drm_exec_lock_contended() getting executed.
> drm_exec_retry_on_contention will keep going to beginning of the loop
> causing infinite loop.

Well that is a really good find but clear NAK to the solution.

This if this causes an infinite loop there is a bug somewhere in the drm_exec object.

My educated guess is that drm_exec_prepare_array() needs to call drm_exec_lock_contended() even when num_objects is zero.

Regards,
Christian.

> 
> Fix this by only locking and reserving fence for bo only if there are
> bo passed userq_signal_ioctl.
> 
> Observed this issue when testing with MR
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
> 
> Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c270635c9..135e77837 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		      (num_read_bo_handles + num_write_bo_handles));
>  
>  	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read,
> -					   num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r)
> -			goto exec_fini;
> +		if (num_read_bo_handles) {
> +			r = drm_exec_prepare_array(&exec, gobj_read,
> +						   num_read_bo_handles, 1);
> +			drm_exec_retry_on_contention(&exec);
> +			if (r)
> +				goto exec_fini;
> +		}
>  
> -		r = drm_exec_prepare_array(&exec, gobj_write,
> -					   num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r)
> -			goto exec_fini;
> +		if (num_write_bo_handles) {
> +			r = drm_exec_prepare_array(&exec, gobj_write,
> +						   num_write_bo_handles, 1);
> +			drm_exec_retry_on_contention(&exec);
> +			if (r)
> +				goto exec_fini;
> +		}
>  	}
>  
>  	/* And publish the new fence in the BOs and syncobj */

