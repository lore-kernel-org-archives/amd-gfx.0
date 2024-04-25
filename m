Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF16C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FA511A1D8;
	Thu, 25 Apr 2024 06:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqo+0FMt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC6711A1D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5DOBVngzMrrR9YCtC7RqvobnyDftzBYpDYJApH4kMux7W9fh+myLKUEeFwFtYl8d0zc4NspplrwzN0voki6VHsjQ972OnwBq+Kp6LZqSILWFk4xq3nMnHcLCOX4SaNBAn8PbD8iiNEJd4Cm9JWii8Zv6x690kHgCgTvgM9vs3g8i5hRkUaiXINDSdbLEu1guAPo+tIt6Q+a7BabH0Ktf3sM9eXV7xGCqmpLfLE2ainTMo3TveyrI73mUGvMg0LODl7i9fnlej4+jnOTlh2SI3sCabi3Npt8cyFuVk+Y4Oy1px9HwlfEjQRu59TwUv/xT8AVwPUvLmZp9B7Mo3NomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zfLPp+ynzrgdce0QHOCuwYtSdR8tf0ZjzkAn3SXwzE=;
 b=i6aH15ztDhhYw3lWq2SgAmi0dsOhJpJ90Dii72K80cbshrSfpKouXJbHstrtxtS8j5PrMQv1nk9U9Vk7TODnppqTHxxi9gB+3SrGWyqqrv4edDK0x97LTjJ1B3TP+ZTSfphAHnEfyVxkjIGljuzhgUha3//v4V7qwOqqsUYTJcbVaxSjSEFgC2dZ1Kd4gyN9wCm3t93wc7+tFU8qnOdrjB+Us2RRqgqBuAoHA9b3L1vJl6Nks0unaZj6+qE35MXM6gAgxG76ir3GlURSxrGpfXBeF+PUZ7EVISR6YDbYHsk61LgXCVD/03e2KomF1hdzc7bmtobpyHr0tP2IcOLh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zfLPp+ynzrgdce0QHOCuwYtSdR8tf0ZjzkAn3SXwzE=;
 b=wqo+0FMtbPWrtHMs0CBvq9GYwvYnT6vkzK8xZDKpl3Ua7XERC0G5bR0kjcY+9ZgB4glFoeoW/ZL7JTCrGuCL7svrI0eeEZfVLBpo41z+326ThlVl4LNXUZXmFLovgLB5gWlHQANmGqBagBrWodYMZ8adoReqBL4NeZQ5RW19cCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:46:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:46:08 +0000
Message-ID: <00c52cab-d933-4622-bad4-d291f680f68e@amd.com>
Date: Thu, 25 Apr 2024 08:46:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix the warning about the expression
 (int)size - len
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com
References: <20240425062035.905275-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240425062035.905275-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: aee8d19a-903a-437b-6101-08dc64f3630b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWZRZzNwTXA1UWh2QjdWRE02SEtISktjVzc0S1l4bzQ1Q09Vd2szcGZUYlBh?=
 =?utf-8?B?SFpTTVRYWU5BYUl5MDBNYzFYeWxVTkd0a0s1dGEyVHUzeUg2Ymova2Zkb3Ew?=
 =?utf-8?B?bGxLbDFpUWEwUE5QZmk2KzI4UWhaZHFZL082NVhhRThyNURnYkdteXIzTEw3?=
 =?utf-8?B?M0dvUHcrL3NhRHVVYnhZYzM2UGxGV2krcytGK1lZY2cyNThvcW1HblF3dWt6?=
 =?utf-8?B?NXc1M1JSNklhZUtNeXFXdldqbkhtM1hTdmhPdXM4WWczSE9zdFY0NFNJa1V5?=
 =?utf-8?B?K1ZlSnhpNk04WlZobi85MTFGampNM1RUaURRWDVBUWNZMFBNTERNT1dzQUhE?=
 =?utf-8?B?OEpwbkNaVFhNUjZOeVhOTXlwY1I1bUd5WkplMzdPQ3BNYWQ2RnJVQjloMzh3?=
 =?utf-8?B?NFRYak9VVVM1ZGxGUlZqd0syVHczbHpBNVJNUlIyQWRrVGE3TFZ2aWhLZEEy?=
 =?utf-8?B?QUFaYWJLSUo3NVp0VDBRTkY5Z0JzcnlpU0lsMVFlVSs4TmRqcHZHYXlOTGkv?=
 =?utf-8?B?bFp0dzR3dUI2NDM0QjhzeGNRQ1F0VVBWbVR4MHBJa2JzMzZxakc0K3pBWDhM?=
 =?utf-8?B?ZjkvZXIvd3I5MkROOUJpV3dEMTlibnVGV2pjQ0JYQ1JMM3haWXhoUVVhWFRy?=
 =?utf-8?B?WVQza1VMaVF4dGZiZC9HWlptbDYyRnlMWVEzNDdGcllSMUVuYXB5M3ljTlI5?=
 =?utf-8?B?VHBCNmZlVm5oRGNFcHk4MTl3d1NqTlNlcS9jZVc1cGJhMnpjeUlEM3JGSlBW?=
 =?utf-8?B?UGkyZHdKblVzTXRSK1lCU2tRR09haEd2bmx1aVJiYWRNcE43RzYyT1FBYnZo?=
 =?utf-8?B?RFNoWVpZMjQxMERpZ0s1MkZuTVRhNVpTc3BDUmQ4Sy9DcHRnOWgydFVZSlBF?=
 =?utf-8?B?Q0pzVGc4QXMwazVSWEMvaW8vODhncnNtdW5wNktLL3JPQy9pMWZoNTM0UVYx?=
 =?utf-8?B?NCtXa2I3cU1rbmNDSldqbXptV1VrVXFJNVdPMk5JdHp4TzMvbGVlTzA0bnI1?=
 =?utf-8?B?SXZwY2ZSazRYWTJQRjkyT0hoV3ZINVphUmJQQ0JPL2MzVG5SUmVtN2JRRjJu?=
 =?utf-8?B?c1RJUlIzN21lbFhzeE1IZ3JXUnZuVWg0V3N1UTAxSkd5S0Z3YlAyalFiWmFv?=
 =?utf-8?B?TGJqb0liQVBpZnRHMm01SkpNMGkzcXNyTW9BTFJycXBFbTgrMEtGdTVHVGtq?=
 =?utf-8?B?Z0lldTQweHhZTEhXZk1GRkVpNitDZnlNck1NeHl4dFdIL2c0TVZtNGp5Y3ZX?=
 =?utf-8?B?bk1mRTA3U2xuRHlPOWs1RUpjMEJIUmFTY1MzREEyZ1dVckF6bnQyUVNjdStv?=
 =?utf-8?B?MDRtb1dOTU02SWpOZkFKM24zbUN0SkZ5YTFGTEpod1k3MEhzQkludE45RHBr?=
 =?utf-8?B?OVJnbmR1UkVjZ0w4SGo1WjE0N2x5VnVkajNTaW04aGJLK01vNTU5RWZIVDd6?=
 =?utf-8?B?Q1JOL3JmVkJtNmtZenpVaHoyRWpWajd3WHJvSS9CL25xQWtXaE9WWXJzajFC?=
 =?utf-8?B?QVJDbCtnMXUxWkdHTHd6TlMxdzdJMWhvUVVQSGlYNG9ZZUM4WFFYemdObGFB?=
 =?utf-8?B?SzVqcml0ZWpiUzlVRDVvR3hxT1gyQWZFMmV1MzFvK2JXeVhWZ1lZbXdmNFBE?=
 =?utf-8?B?ZlZuNXVjRjAvYm9yWGk4UEVITDQ3ZlFsQlVCaVZWYTZ3aGl5NGpLL2ljclNU?=
 =?utf-8?B?R3JFZC81dmFFSHZJMFVGUjB0QnYvb1hLTWNPNXNQcHk4ZERzSHZHTHhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmo4dWNNNmRERFhwU1pjOFFKU1ljVnBFR0pnR1VwSGhFd1R3VjhKVUNndnQy?=
 =?utf-8?B?M1c3YnFpanNpQkVOMnIyS291dTZGODZVcjBhNkFVR1BwUlJoRW00d1Q5QlJk?=
 =?utf-8?B?dHNSc3Z0bWREN3lxUkVyb0dYQmlteFNsbXVBRGhCNHd0N3RyOWI1THhuQUdX?=
 =?utf-8?B?cTBVb2hoTWwzTzNhcDMyQi9scVBFTUc5YkJtRzNJUUhkWFNLUE5jNVBra3F0?=
 =?utf-8?B?bW8vMHlXdi9pL0pvcXIxQWw2bG94QWxkTWhweFVQV1VRdDVUU3lSRURjZ3k5?=
 =?utf-8?B?aE1WRkRaQk9QeVlORGVOVU9ITGhrQkpVUTh4Z2gzVm5wdU9kczNEc1pqbmhH?=
 =?utf-8?B?SHo3eUJFVkdiZ1JYNnJVQkoxMDEzNnRGVDJWZ2xnM29rb1E4ZEtpYnR2bE4y?=
 =?utf-8?B?OHFjQjBjUUlHVWFOV0F5VzR0RjExd2xiZ2RvTlJ3QlNoeUpndnVQZi8rOW1z?=
 =?utf-8?B?cGhCdjRHc2Q2N05rZzFGNHpKWWVlME9McUdteXFjNGlvZTVKazQrRFhVYXBH?=
 =?utf-8?B?NjRoZXZ3LzRlOTZtQTdYbCtsWmxjMG9JUWNRNVFka2FsL3VYNjZseTJHNCt3?=
 =?utf-8?B?NmJGRTVTNDY1MlZmQ2xtbjJCcm5RMzJUWkFFSnpSaU5mRnByMnluVlVkVGc5?=
 =?utf-8?B?TGszQmVkMnZnT0JNMmZEMHlYL0xmUUh0dFlHYWp6b3FKRk5wcEx5b1NIOGIz?=
 =?utf-8?B?MkwwQUUvWS9SWDRYZHl0MW5pYzBtdHhBaUN6YkNlaHlsa0I4RUltbGFFUjA1?=
 =?utf-8?B?T2hSRFgxSzZFTVFQNU9aWnlnUytjTU9lL3RlNHh5RmlKYzRhOURLcWFIY3lF?=
 =?utf-8?B?NUI1TWg3NlJENTVqVjM4eHV5dFUwMVMyditzMjZ5alJNYi8yamlZbGhBcitW?=
 =?utf-8?B?WGVTMExVS2FXUEZaMndFVGhidmFXbHQrMVVOQ21NeGZUOEZyWGIxNmlBK3RZ?=
 =?utf-8?B?bWZJcmkzSXN2aDFOc3dobnJVMll4MTZodFR3WlhmNU94SENQRjZLbXI5OTQ2?=
 =?utf-8?B?bGhLTVlHejdQYW1PaDNTNkdXRENmZHNJQUMycWNFMTkvbTc4V3BSM1hra2Ri?=
 =?utf-8?B?Zmw2UWJTRzdKa0VtNzljeldWWTZXV1N5alVwTlZlODZKQVJ4MW9WcTRMNlNi?=
 =?utf-8?B?RmtnZDFVRGVhSkROWEZDYjhVaU5DVnJzQ00ybk5wTktwVkphVUtsVFZEUjZ3?=
 =?utf-8?B?UjloSnJPbHJkNHQraGZXbndoT1R2RXpvWjZTR3BHL1U2emhyOW5IUnlpS0JQ?=
 =?utf-8?B?bDg0d1BVOGlwdlRLYXhLL25abzljZHM4czljUkUrMnhWb2pSdHV0Z0VOMFRO?=
 =?utf-8?B?c0tYSTBBcUQrNElYNnJGVk5CSGFZT2lPNmR2M2pmSEUvSlBIYXNNSlJraHVp?=
 =?utf-8?B?SWNkZ1pLZnBLUUZhVUhTamhneUw5UVdIYW5qdjJxWlNuVE5hdDU2VmdYb3I1?=
 =?utf-8?B?WWppZUt0UjVpNFg4U0trejlhMVlxZXMwcEFmRW1LYTZ2RjZ0dE5ubm55MWR2?=
 =?utf-8?B?bDlOWWpJNEJMcXdublFqMDc5WHFPa2crUzYvWFNpU0hBMGk3alFrTkFtbW1C?=
 =?utf-8?B?d0cwd21OV0cyMEFlSjRsTThTSENBZkJoaytjZVV4Rk1Fc0k0QTVSS29QUmxn?=
 =?utf-8?B?QUNuZ3JpMjFzaktDZmFRR0owMFlQNTE0RmV0M0VxNTgvRFgxVm8zdVdtSHV5?=
 =?utf-8?B?eG56ckYrSzVUOExQOEptTnUzdHBlM2hCek4xdDhHRUtDOFAxakt2eWVPc2Rx?=
 =?utf-8?B?RVE4Uzl2aHdiVzEyMWxGT3BqR0gwUk9PV09pWDcyMUN6SlEzTzhqV2hwYVVE?=
 =?utf-8?B?NDUrdmIyYWhwbVQ1YU03ZEx0NDk2MmY0YWtvTVlNei93RjM0UTRPOTlTTWtT?=
 =?utf-8?B?bGQzdzg1WHlWZVpiaTJDam9IeEtZRWpoZnVKQ2hXRldPczJHZDd5MUhtbnF4?=
 =?utf-8?B?N003aDFKSzRqMFh5YnQzL1dEVTlIRDArQXFDR1N2MUU2TmhleVFMcE5hbnhj?=
 =?utf-8?B?Y2tvZ1Z3N3BreFdIRzNMUUxUV09NYnhUUHUyTmlXZE5tblJPSFR5d2pRUjdC?=
 =?utf-8?B?T1FIZFdNTm41MkI3S1JLVjNjMTQ5YWk4OGtHK2E4c3RVY1RhSnRjZU9Ca24y?=
 =?utf-8?Q?y8uyAk6uPQeEx1fi1w82ht6ru?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee8d19a-903a-437b-6101-08dc64f3630b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:46:08.3690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1QQUx1PtRvycTdpw+mhBiUlniuThrFL0Wsmj70Ffa8BLJ2/mgDj5u+QzPN6IDhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796
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

Am 25.04.24 um 08:20 schrieb Jesse Zhang:
> Converting size from size_t to int may overflow.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f5d0fa207a88..b828aad4f35e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>   	char reg_offset[11];
>   	uint32_t *new = NULL, *tmp = NULL;
> -	int ret, i = 0, len = 0;
> +	int ret, i = 0;
> +	unsigned int len = 0;

Please keep reverse xmas tree order here, apart from that looks good to me.

Regards,
Christian.

>   
>   	do {
>   		memset(reg_offset, 0, 11);
>   		if (copy_from_user(reg_offset, buf + len,
> -					min(10, ((int)size-len)))) {
> +					min(10, (size-len)))) {
>   			ret = -EFAULT;
>   			goto error_free;
>   		}

