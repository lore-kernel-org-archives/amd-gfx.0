Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606E606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LJjvW3BB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26B610EA25;
	Tue, 20 Oct 2026 11:36:22 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B267610EA25
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 11:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFZvmyMKXPLw+OZL6M7JBSS00WuehyYRvD0LVq3qhWLjLKgxsC4Y/9M9jmoFLSh8uoC6fy8/H4W6Ku/ws23Ur7nph1P2HgrKcfXsdvSU+qA28qz1rtaSQ04iNuzpzet/NdkdzJmjTaoaJDm1pJgMs84YqpGzW7isAj2uJIc0b1arN1KwBRgyg78rl1hmEpKXB/OodusDI/JwgWfmFLlbNK37A3xKaLNhNgT7L1ceO3uk8RbazE2Q2OSBtq1p80lIvKUfjDTNJTHShRr4+OEKTjqR2UU42VIOzLjDXiLIaXFr2aBov1lawAwp4+/9Fmf8HRdsBLyWMPRmkocw1EQd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG945UDGRZXWBcvHXl8MLOpduFrUfaw9CEkJazirtp4=;
 b=x85rXqfFmfm9/rtOSfaF/Xys00IoI6YlayE31RsTgCAWdnomPUztSZnoCo7yCDGIuDHwX8R7L1kgyj1R8qMbmggjg/dGF7N2j7qpfbQIiP5XNwehR7CfQYss9wh0gLND8k5Tx83fCZzT2XfJ+7cEjTAeCsLBdU7x/hXene/kRZoqUZZQAKfYFqmZJoWxyUfHN9DSOOw1m3ULnYosU/WLjxmtPInH65Roz6GpkNsEx3vZ0Z/PxzQwOgJx73W99ywDvCh6N3i2OSxp1Mkk7wW0pxhouEKI/ouDyJZ3VGlmiewSKmgkmb7buTTYNJv9SFzFGOjESTnFJ+TmjR16IK9L2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG945UDGRZXWBcvHXl8MLOpduFrUfaw9CEkJazirtp4=;
 b=LJjvW3BBwRhSy0fpJYKNWIERdAtLyPgEizU4b3g2qY1mQV1UM5qq5/XInJD3jZ/1LcSZqjldP+2VqB69bHb+siGNi6XyFQBClmoH0NLtANYsH3VxPda1f2M1JKyC1XQXFRXf11eaa5A0Nkq33jyX6QMs3W8USmO76wMTogHo/GM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:36:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:36:14 +0000
Message-ID: <de4a16de-aa61-4c30-bb8b-7d391c1651aa@amd.com>
Date: Tue, 20 Oct 2026 13:36:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: reject CS chunks too large for kvmalloc()
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
 <20261020083804.2777099-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020083804.2777099-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bd5234-60c0-4cce-5045-08df2e9e58e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wPpdWyAY8XKUCBMifxeoBtk3RCwCp31z/gbEJcn6CnMBf30AQMbAIRYbHL+88YelIlYd6gesFz1+f1G+9Mb3/5WjxhB7MyLSFTyRSJL5ejTY5eM4W1LcTE/Er7QutKQ1bJeYuQKplGDqoYWoz8k8S9HRttoUIMNok/c7KAiEx5Or0joeMsLS2qiV+BKTfYJPYUv2+SJQNydkGBms0UQwnYllupVfv2yVCufUzlUVIyMz5xozMaZLSNu0QZ99F1557rg78BPwLpg7DkGRozusmovRjRAcYtnJktrR0aNzn6VG0FY6o57cfVexYeI2NONu6elzzJmQKk3EO0I3QGdTKniAJFv7YAMO4T9P/3x6JKj1iPVyena6NVtPSifPwJCzaMsAyi5pJexRPTS6OxS5RLGQ6FPMK60RAXqXzvFzax6Gl7jd3C+6IVrQqYyKqOaEcRPZ/MG7/bJuajLPQNBDRD6EWp2H3q61nLXo4BxPumRifttZFGppd0x0xGaYg9Bls0/u6Tn+ahhKL5Cfg027ETgSYYRw0G0NUXW1wybSSa9xRfQ7nkZKHrZYaPMxc+u1PUt4GHB2DW7h+WcaSRViJZB+cXT+fQBZSnrP8j8TJ9D0RfEVZV24KQ8f2jVEWoTe9ENW1stfRGASRvh3pAz2b2N3oCcIea9D6UGDzJ51/Z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUEraWZ6UkZveDJ0K0Z4eHJtOGdKMzJTa0JJdHlRSENTek9HQXVvVzl6YjFk?=
 =?utf-8?B?ajg2MUc3SVJkKzA4U05rUXhJUGl5QjB4ZWhnMThRTmpKKzhiZm11d1FWdEhz?=
 =?utf-8?B?ZXRwVllvMDNIQy8vYkE0bENhNXJXYVBkR0N2cHdrRUNHckE2SlhBZVZtdGly?=
 =?utf-8?B?Ry9WQ21vSVNiWWNDVnhNREZuYVRjTDJUamNhOGJxT3JENFVWc0EvakR3Rkk2?=
 =?utf-8?B?aHFYMzNZZzNXbU5ieUJOcDhPd1RxN3NGcW9FWnRBcDk2cTlrQ0dNN05RMDUv?=
 =?utf-8?B?d3ZMclpXOW5JRlFXOWl6Rk1pM0RLckdxYUNaQTdTSVQyUGZMYURKMUs2Z2Jo?=
 =?utf-8?B?SzBKOW0wbUtrUnlrWGZTNGRDLy9VZXdtaXFZbUdvUXFWUU5xNHl0ajF1MXJy?=
 =?utf-8?B?YWRiQWtoNm5CVExYRUt3eVhibzNlTEpQNjYyeFkwZ0t0UnFCTlRXWnU5cjgw?=
 =?utf-8?B?bW56RSt5cXJ4Q0hHblkwUDNhNE01TzBVRWtLQTVxN2lxVnVTdVUzZFdMc3Nj?=
 =?utf-8?B?S3ZaNXkvbFdjV0dKaEpLMEM4MlhUWE12dUIrMHJsVWNIU3R1azdqa2FKZVBz?=
 =?utf-8?B?M2JOYTZVd296aDVZK3pJZlUyTS9Wa2JXbjN5d0hpc3VrNUw2U1NqRHVxeWV2?=
 =?utf-8?B?VElUSm5uWW9tN2RPcmxnRm96bU1wcWhuUUFYNnhXa0Y0L2MvM3V3b0RSaHdK?=
 =?utf-8?B?N3BIR0U0b2l4VnlCMUNERHY2R2FPa05CY0FkTXRRTGtEL3d6K29WOHFwTzBj?=
 =?utf-8?B?NEF6OVU5Z0RmM2dxQTYwU013Qkt3a1ljOU1QUXptZnhyb1ZjSmw0TXNPSkJI?=
 =?utf-8?B?b2F0RFV0TTBkQit6ajh0MWZmSUVKbTZKdXhac2NqeXZTWEJZOU81RDh4NmVU?=
 =?utf-8?B?R1VKQm5PRXJHb0dTTGVjMWdCTCtGZFlRTWtsMStiUUNBWkwzNmZpdjFNOUFE?=
 =?utf-8?B?NUYxYnBnVkdaQ29NV0lEait2MmdWRnJlaFNJSE9LZkQzZnhSa1BzR0JCUXRj?=
 =?utf-8?B?V0pTb21vWkFvOTV3STlXVEI2VnFDbHNlazdXdm5Na294OGZiVnFQWFNmT3ox?=
 =?utf-8?B?QlVJQXZaV0xoaVhVQU04Ykoyd2luZUVKWVl4cU1MQUdFcHcvM3VhdFdyV3VJ?=
 =?utf-8?B?YjdreGlVSmdKVW5BU3UxVHNucGtITjBrMGxXVHQ3L3pJWFc2RjUyUm5LK0V4?=
 =?utf-8?B?eld5azRmZWJPdlJ5T2NzM3N3VExxaUFzVElab0tWWmF2bmFVQUp5STNCVUI2?=
 =?utf-8?B?cXR5OWdMNFY2Q1ljeEVaRko0cE9kNUN0bnJUREpIU3J3UDJYV3VGK0cwcEtV?=
 =?utf-8?B?U1h2VzhmQS84U05GVDRqWUJMd2xCcjQwRWVNenFUSVFhYmYyVHk4OUN2aFVJ?=
 =?utf-8?B?OVZvNGFzMkR2MVVvRWRtaEpjSjkvaUNXVDF1NE8vcEdxK1hVa1hHUjRrWmJw?=
 =?utf-8?B?TmlDSUdWU2lGbk9hZ3M4cXJOSHoxS09jTjJkSnE3RVZZbjRzR3c5TnV5UmVO?=
 =?utf-8?B?R3dRVFpEeGMzWU5DZzhhMU9odlVia3BKRTFhT1lWN2U5N09wb3RhLzJCUmlR?=
 =?utf-8?B?YzBTbmw5NXVvV3l6cTdESmEyM01lTWlCMjVpSVVRTUpUUUsyNUtDT3lpMXl3?=
 =?utf-8?B?eFFJNVpyNUxXb3V4NGtTL0tLc2FxUU96UzkwczVNcFp6dzhidndBQW84VE1Y?=
 =?utf-8?B?enRuM1lrckRvRE5ZMzQ0RFN2a0crVmhqZkd2YnRHUmJaZUx2UmdSTWk5by9N?=
 =?utf-8?B?a3pOMFdxbDkyVW9CTjAwcmZLbndBUmlvMjJvckFncTlPdDQzYW9WYjBDNk1u?=
 =?utf-8?B?NHlKZzRqUmkyK3ZtdmQxNFFkZkU3RzNTS0g3RlpZOWVub01kT29rUHRObURX?=
 =?utf-8?B?RzNjaXZaYml2WUVuVzNzMW55QXQ5c2JjL05GRWkzNGlta2RSSXRNblB2YjRl?=
 =?utf-8?B?UFk5M3FMbTRyZ0I1aWgxdzZSUjJpSUNGNmh4OHZudmVlZkQySFdFMERqaFBF?=
 =?utf-8?B?aUZ0Wm14dC9QUEJiK21iSnJ0cU9kMW5TL2dDQm1GN0pyWTBJQVR5RXBPUkcr?=
 =?utf-8?B?SlB0T2R0ZjVIdnBXYzA3ZEIyRCt2S293ZnRPQ2Y1c1pVWXEybHVkdTNqMlFE?=
 =?utf-8?B?d2FtN0dXVEozcWZISzdIVHNkUWZyOVBXSmJ0bGdRdUFQUEFHZWlMVHAwbUxz?=
 =?utf-8?B?cUZXVXdCcGpLcm9LdHZsNlEwT0x2ejVKRUpkUDFrdTZRMTdPVGtYM0ZmMDVJ?=
 =?utf-8?B?eFh4L3VkeXdUb2F6NVVaV3BPNEc1ODVRYUYxU0RjVlFQSDkzcDdjd2xJZlpW?=
 =?utf-8?Q?2++aM+Ye8/+dbFoGR3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bd5234-60c0-4cce-5045-08df2e9e58e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:36:14.3179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0eszUhVaEkwBk7t1TxfYPhhyTMEpm2JrW1bk93ja6nZEJjrtVQii1H+WpSukvKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 10:37, Jesse Zhang wrote:
> The CS ioctl copies every chunk with vmemdup_array_user() before it
> looks at it, for whatever length_dw userspace gives. kvmalloc() warns
> about allocations above INT_MAX when called without __GFP_NOWARN, so any
> process with the render node can trigger a warning. On navi31, a CS with
> a chunk of length_dw 0x20000000 returns -ENOMEM after:
> 
>   WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0
> 
> Reject such chunks with -EINVAL before trying to copy them.
> 
> Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 62758866378e..649bf0947e68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -221,6 +221,13 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>  
>  		size = p->chunks[i].length_dw;
>  
> +		if (size > INT_MAX / sizeof(uint32_t)) {
> +			ret = -EINVAL;
> +			i--;
> +			goto free_partial_kdata;
> +		}
> +
>  		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
>  							size,
>  							sizeof(uint32_t));

