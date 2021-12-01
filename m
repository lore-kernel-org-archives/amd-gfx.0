Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839FCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 09:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0676E4CF;
	Wed,  1 Dec 2021 09:30:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBE46E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 09:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgvPiGE17rUUAmY/iCUEwyqAXy+ZLChQExWE30H0cyOrJk/v2VoTG59TKi6a943A0ueJQ2HyalJnkl8T/13SPFxyI18up1PL3iCS8fXPXf/Qb2r/4P5dyxxKBYQXZPDoH+4JTDBPbUd6A5EVlk1enS01wJqFhIFOXEWQzK/zRyxVNFJa9NMI3B3wm5Xsvny/ODxb4OdYMbVA0TjKW6wRDCtD7aFrQZ746RkM3QFYn2u0ANGnyEMZWPjvSVlWPN/UDctUFic9n3oGwYpEvAmGBE+KMYNIxCl9AKnu2fPC44PU/B2zecO0O9w9m3xOgmw+hu/udbJ73uPQ9oLIRIaPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kivPRU0IK9FKwCkmMkrLxhfMcs6emXl3zb0XDK04Kbo=;
 b=oS+Y9tid9iyvonzhDRXsXzvsGOI+WCcLzb/WwM857fDu/UJDObDQscaBS1nMZaI6MuChqn9kRR1Tqxr4Q3FEziGg5LEdi1FsvJrDSqT7mkXx2BKMgXkRU25UxiciG99uomtfuwvRKymqEukbqItHT1mLn7soLAdZ8j2KLxXnpcwvK0HzDywZfyYt6SQbEM/Im/tQBOsh96f9FoYhbChhYFc1tZIpXVATnOBHMNLyA6EKNM2x6cmniC1oVt4oY+pvgQL9rL78DyiUPDh/uJk4LErnsMR6s8L39wFS62fjoKtsqPSpzpnl0WUIN0aD1BE4loMoPWUCUwFzZo80E/Inow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kivPRU0IK9FKwCkmMkrLxhfMcs6emXl3zb0XDK04Kbo=;
 b=WVrCCbXmfj+5AmgiJBDfZ+Cu3SqYlWx3Vcl7F5/vV9eAl37EW/zXQYMp5qJ8M9RCEERcXlRXkDhE4sQlpO/6D/4U0XFU4AQSF5Z9iRpTVEpMstvT0VgxMXrixCMhg/iQ1uMsvRk32XKYWpp0u9iVwZUqE2roWjWEU+HYpnSWK/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0078.namprd12.prod.outlook.com
 (2603:10b6:301:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 09:30:06 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Wed, 1 Dec 2021
 09:30:04 +0000
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211201092458.3348858-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
Date: Wed, 1 Dec 2021 10:29:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211201092458.3348858-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0329.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::35) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.183.123) by
 AS9PR06CA0329.eurprd06.prod.outlook.com (2603:10a6:20b:45b::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 09:30:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd45fe9-f281-4cf7-987e-08d9b4ad27e0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0078:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB007890017368A8422DE0C30383689@MWHPR1201MB0078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbC6VC6HV4M0+U0uHKf8oStmixQpy7AAgdIDotdX6uo9xUg0uZr1ABuvej9FcQ5CvVt7CwRYN8mHXjD4iMnjBfBCZEKXSyO89pheE46c+gCqM+H3F8HxjQLwoFx2U7vuN45saDeSeR1an829DecLru3CeBdpyfP+327hchz/huJ2pTOdQBCGKyWt+pCcggNKwM52mWfygKft+Ohsa0g/KB28s0amcJKWg/ZyfI4FMJyf8gJ+RMhXnh8L0TW+wR4TAUdYg3ZZu5xAUIyMtsAOwvzq8+KfRW14Vp4jbiIbITHkhdo9nrxbHAuNwFPEyxr7qBtkALn2GlBqwILMG5PSm3HN25mn+tJvzPK3eePuqeJJaXbeiosXGDipgZHF6xgYbV3K0erOPXRXoi0fB2s6DtA6UYMenqkYc0kjQLyllGUxM3x/Ykwl/6NQKtOCpP/EMRMJqW1w+QPduqbWXBz/KryW9eP0+gm/3Dhh13SKG/+GcnjscgjK5rfVzRjn/xXcf7cp9ItTjqsDKM5mLCXFSEbzSoxdK77e3VI3sPYGYd60QetYDjV7koQ5S3qvag1MlbmqBq4k/3hZ7C2I2ua1LRc0+AGVrjw4qSNnRa0Rt0oKYCXPW9k8Asu09sgEULYaS5vNLUXQAa9wwpRODreRkLjEhVzQryUyqMsp7uNt8WbYNylLWYEgQA1xi/NYpNhyRVsIFOyuXqm2sVDWFtGc1XfYwzjWb17kU0nvx0PX1E2ihhfyBa/OovcGU8tZh7Or
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(31686004)(86362001)(2616005)(956004)(38100700002)(8936002)(6666004)(26005)(186003)(83380400001)(36756003)(2906002)(8676002)(6486002)(316002)(16576012)(54906003)(66556008)(66476007)(66946007)(5660300002)(31696002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVphcC8yaVhRMlVFZ1ZncldqU2RVWndvVzh3Z1l3Ym5lMG5lbEd0ZHZyYVYr?=
 =?utf-8?B?dzI3QmY3QnJVS3dNS2piMngrK1NPSWZaQzVBdE1Db3dNTkNFWHVmYjVDeWVB?=
 =?utf-8?B?SFhHMlVuWkh0ZWZvblVQTnM4WGhOWVE0OTQ0L1Ivc0U1QU5oSnFiV2k4bDJU?=
 =?utf-8?B?Ym8yRzJvMmR0OUF2dHJXck9oNFpEeGxuN0ZlSzNUSXZLYmVLaFJoMHErNElD?=
 =?utf-8?B?SFBQbm9LLzBCenQ5TThnK0JVQXk0eTU5NEd5VjltMm5PMEgvdllBS3hMZzZQ?=
 =?utf-8?B?M1hnUlNLdlJtV0pXOUQxa2hicTI4eXN3R2R6YS9lUkNlWEVEV2JFbGFrYTlv?=
 =?utf-8?B?MGQxTTI3TjA0ajEzL1RLVm9iMmlaS1VpMEpHU3ZiMWZhOXQwYmlUT1RDYTc4?=
 =?utf-8?B?U2tqdEhsWnVPL0w0MFZubERMdmVyVWFVU3lJK3gvbm9vRENZdkxSL0RDWmtq?=
 =?utf-8?B?cmhLVGtNK1dKbXRjSEsrR2N4RmJ0TUlxZnE2RWptNXNKZDB5SnoxOGJCVVFS?=
 =?utf-8?B?ZGJVVDBkQ3dyVmRtcFk1RUw0NWExQzRIWCs4b0czWXRJbnpFTkhtdGI0OTl0?=
 =?utf-8?B?QUZJTUYrb2NhNWloaEgwNmREbzJGdDZWRE1QMi93OUhHWEZvL29iZUdLbWJP?=
 =?utf-8?B?djJCK1p5ZFY4MGlnVDhXbm5NWFNvQ3J4NWJpdU1NV2VaTkJxSTF6MnVyZUsz?=
 =?utf-8?B?UEFOT3JDVVdWZDUrQ0llZk5RZW8xakI4bDBEbGRZMmpPQXhQMU5wYWpJK0Y1?=
 =?utf-8?B?SGxycEUxNlY3WEYvai9iVnZVYk5JVWNQVWNJaEpiWnVrUHRleFV0TzNRc3dO?=
 =?utf-8?B?UFFVRDJHMUlzU3NENVRST0lZOW16bHh6YVZ0a0wwSk1MNncxWjlsOStxRlIw?=
 =?utf-8?B?eVp1VjFyaVZJQ01xOTJoQWFucHBjVzV4TVdaVG5zOE5zdmFLS3NqeHdOYVpN?=
 =?utf-8?B?NE9IQjE1N0gyekFkdHJPK0d2MitkUXF5YWhCZk5KdkxsWEJyWno4di83ejBt?=
 =?utf-8?B?cjFMZUVlTjV1bGdKempzVDI4bnc5YUh0NnRsclpTbjQ2VTgvSUR5WldXRUZS?=
 =?utf-8?B?cmIweUV1RXozMWduYkFQQ0lqNHFQVkRJcnA3aHFmdmVSSXc0YWZTY3pGdHha?=
 =?utf-8?B?UWhsWFl4dDFkZFYzemk2SDIzUG42NTlWaEgyTnVKUmhnQ0hCc3dVSTRhdTZo?=
 =?utf-8?B?NkpYRmU0NCsraFpiTmdrdDVsc3pYODZEU3NZejIrb2NsQXQ4WTRSN0pWRFFG?=
 =?utf-8?B?M1FhT2R4Q3NDMmJWR1FrZDN2Y1JkZm9Vclp4WjJUaVBrcEVuWEpudFh0ZjRv?=
 =?utf-8?B?dWl2aVhRdG8wWDl1bXBxZE5BVUdVV0duaURGMFQ1c0lGNmk0ZWEra0pvMkYw?=
 =?utf-8?B?YmFuazdyYTJna2gzTmd5MWtHNjJaTlp1YUFWRXh5NU9uNmFRZjQ3MGhGNlQ0?=
 =?utf-8?B?L1c2alRJRE0vUGgvY1R1YTQrTTVubFdWcUp0Nm5RajkyeUIybDNibXlhL0Rw?=
 =?utf-8?B?ekVzamFQTURkcTZFTmRHM2Y1V25iN0dDNmtzZ3c0UkxLTkhRUmZMMkdBL2c1?=
 =?utf-8?B?cWcrWC9nTDQzbThWem4xaU9JSzhVVGZQTnB1UlVGUmE3WnE4dWg0OEVkMDM4?=
 =?utf-8?B?MmZNejJudEU5Qk16dEZyZTFyd1Z0M3pUSVZWVStJSWpQTS9PTnNhd2RPL1Q2?=
 =?utf-8?B?eENBS0RLek4vZEdzU0RPZU1Tc1M2bS9GQzRhejdmc3NXZy9tUzBnZi9zRk5U?=
 =?utf-8?B?L05wSHNaTDhsajZxc1Q0Ym5zMnI1NGgxRXhjTUFVcjlhMTB3WHVZazdSZTdo?=
 =?utf-8?B?OUVKZStaTkcyUVlBcTFNTTlSZi9sRjdWSll1aUxYUm1ncWs0bW9HRDJxWE5O?=
 =?utf-8?B?MlBQOFNsVTVuZWdhT1YzTWlEa0hGVk1kaGs2UGV1aFh0ZjRKekhLeXM4RVNr?=
 =?utf-8?B?amdSbkhvaVVobGlnbTlIdFFLMDFOamY0ckw0cmdzU083K0I2MHJjSWFDNG4v?=
 =?utf-8?B?SmxpQTF5TVhzOFQ5Zm9HMDlJQUp4YklQRjJ0MXBsblB1NlBvVzdYcnNkZ3Jj?=
 =?utf-8?B?SnNBWGJvQWpJWE04Ui91eVZ3MnJUL3h2clF6RDFhWnp4dExiRFF2WXpna1lj?=
 =?utf-8?Q?GL1k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd45fe9-f281-4cf7-987e-08d9b4ad27e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:30:04.2977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx+Vjn3fhnJMHXsQRhKWu+OXInbNbxw1zsQTySP4w+n6kjxafl9zi1LyrIkJe0sO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0078
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.12.21 um 10:24 schrieb Lang Yu:
> To maintain system error state when SMU errors occurred,
> which will aid in debugging SMU firmware issues, add SMU
> debug option support.
>
> It can be enabled or disabled via amdgpu_smu_debug
> debugfs file. When enabled, it makes SMU errors fatal.
> It is disabled by default.
>
> == Command Guide ==
>
> 1, enable SMU debug option
>
>   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>
> 2, disable SMU debug option
>
>   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>
> v3:
>   - Use debugfs_create_bool().(Christian)
>   - Put variable into smu_context struct.
>   - Don't resend command when timeout.
>
> v2:
>   - Resend command when timeout.(Lijo)
>   - Use debugfs file instead of module parameter.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Well the debugfs part looks really nice and clean now, but one more 
comment below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>   4 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..86cd888c7822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	if (!debugfs_initialized())
>   		return 0;
>   
> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> +				  &adev->smu.smu_debug_mode);
> +
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..50dbf5594a9d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -569,6 +569,11 @@ struct smu_context
>   	struct smu_user_dpm_profile user_dpm_profile;
>   
>   	struct stb_context stb_context;
> +	/*
> +	 * When enabled, it makes SMU errors fatal.
> +	 * (0 = disabled (default), 1 = enabled)
> +	 */
> +	bool smu_debug_mode;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..d3797a2d6451 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
>   out:
>   	mutex_unlock(&smu->message_lock);
>   
> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..9be005eb4241 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>   		goto Out;
>   	}
> +
>   	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		goto Out;
> +	}
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
>   	mutex_unlock(&smu->message_lock);
> +
> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);

BUG_ON() really crashes the kernel and is only allowed if we prevent 
further data corruption with that.

Most of the time WARN_ON() is more appropriate, but I can't fully judge 
here since I don't know the SMU code well enough.

Christian.

> +
>   	return res;
>   }
>   

