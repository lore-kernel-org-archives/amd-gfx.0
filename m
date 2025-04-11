Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C41C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1E410EC0D;
	Fri, 11 Apr 2025 16:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fM0xatn1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1357C10EC0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTax8odK9KAI0q4eQ7C+h5rOzDMiSvJKWvkDkzIMcirAiQ/oRaKf+TzJlbJqAVrNWNyUCg5BAC5jR16l/Xd5YzPM3XQGRX8rL3SF8VqWLenp74O0g1RCiMIFqgDnTTISri2ZccmHYsfY6hnKT9PJ28KJ7a0kGhkC8HReeS1OFQDjgwEN5iwnkPJBV9E+Fe2GVSt8C6x/4Lm5GWEnn8fOc5TdnHQ5ytU4v+nbjde5WkrLxWoWd42WSne3XY5WseXqz/veMIhGPCF8aJ0jVRWWUlNsJ2x3eEI19J1NfLv7TtV8cUZzw9GTAKEZUSVygQWPJHRoR9QDooNLEqLeXeVy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GefFBzGwuh2HElZB+6jRKk0hfdofgd+YY2UPHiTlAqs=;
 b=uxV283cGLfQMih7JBEQHqRCc0UJwLY2lc+pl+ifMVG3q1Lg6wdoCvs9Z6ZNk+st0TwQl/TqtBIZ1f/fp0KMStcqEq/E0bA3Py3kppigLNhWzGyCizE3KWRQmR1DOLogIgD3OgN9FwuSqzhUuVnr2FwnnjyPyVrnnCHJjS65Gh0zZeFGy7OVLO+qrQ7cyz4R0783qsDaPN6Lx6a1K3vAWxNnzY/evvx+9ssDrQ6uTBBlhjtU5iDtqyQPRngJUEykbs4Roido0vVaAu/951Ziu5fei8h6RE9iJMOUa1XerIk0wHjVKngaAtH6ZGnqoLlgccUtC/QNWSjsU7MRnhWAMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GefFBzGwuh2HElZB+6jRKk0hfdofgd+YY2UPHiTlAqs=;
 b=fM0xatn1RZ2WHHxzwjYUggr4S+BUNzQ5Cwr29fchtqsC2hRT0nWXNgWMJgFQThQWlchVhPPuFYeRx+HXOg8UYhS2CGmhocSd1s3XqIUM+7SsFkopO6eZ22byeAyVzdokmpMqE2amOW0glu7DhfH3lyq6eaXXuRAy6Ka3/6cYpo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:02:24 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:02:24 +0000
Message-ID: <2f74a26b-732e-4ebc-b8e6-80b0400fc484@amd.com>
Date: Fri, 11 Apr 2025 21:32:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/9] drm/amdgpu/userq: properly clean up userq fence
 driver on failure
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411141228.2722962-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944fbc7-ad2e-4b5c-b1df-08dd79123fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajlWc3Q1QzhSYitXeE1QUnBMSWlINDhJaExib1A4VkJTR25Fa0pYTnFsY1Bx?=
 =?utf-8?B?cEFuMFVwbHlNWFkwMHQ1cmREZWs4N25ZV0pFUlhOU0lNeVZBUUtsbnJMczUw?=
 =?utf-8?B?U29nQVkrSTE1NGNGWk5ibm40MVpJd1A5ZEZ6bks5VmZQY3VMaVhmRCtzRUkx?=
 =?utf-8?B?M01LbnZ1TFFPRUw2UkhPUFRkZmlIWmZ1dDZYamRtdFB4QXduaTU4UWZWaU85?=
 =?utf-8?B?M1RlOUxZcFY1bFJuUFlIYkpiYlpQT1FxTnhWVHFobkJjb0FGUWVpSmVTZ2Fu?=
 =?utf-8?B?cDVMWi9rOWpta0dRZFpDMVYvTXdnMFhCTVN2WlNpR2dsN083aWNRU1hVWjVa?=
 =?utf-8?B?OEhaR01MSEk5a3ZZL1BLVUtyWnBSRjd5R3N3T0pwZkl4VXhvL3R5MnNPak1G?=
 =?utf-8?B?dmFsUHBHZ1ppT3ZUd2RYK0U5VWpaeFQyWFBocmNjbFJkSmpPYlh0RjEwazRz?=
 =?utf-8?B?QnhSMlgrZHFVQWJ0MGNIZ043KzNsazhhTXVXMlRiWnBhUGFRZ0l3Q3kwRlV3?=
 =?utf-8?B?NlNqWXFvUWxKT2dUeGE2NlV1TVduc3VzVmpUa0Z1ZHdLZCtHaVZqOUFZekc3?=
 =?utf-8?B?bUZDUVdwRjcvQlZFZVhUMjNnZk81NUNvdkxjcHA4VG11UmFpTlN5UGtGRE5Z?=
 =?utf-8?B?T1lMelpZb2d1UTJra2VnbXJnN3ZjQm1IVEFTVXZXOXJjZUt0V3cvd1JvdjZI?=
 =?utf-8?B?enZxWEVCaDJWS3V6cHhBMEJCdTR2Y1JQanhZNmUyVXJQampyS0FSd0NHNGRG?=
 =?utf-8?B?UG1xUVlCc0pBQkYzbTF1TFB2bWl0elpCeis2b0ZLemRBMHhlRjhHSzRlcDd1?=
 =?utf-8?B?UXhNc045Z3VCTm9rQWNsMDdRQzI1azMxTGVIdzVsZHFJdHhVdklhOE9SSjZC?=
 =?utf-8?B?eHdaVk9jMFhmWnBTZlBoRHhXWDcxVDcveVV5ZzZWcXZoWklyNjFYR3JMaXFC?=
 =?utf-8?B?V2w0NGoyS2ZiUlIxTU1yVWkyWmpiUFBOVS9ld0dDbW9MMDhYVk9LYTBFcmdE?=
 =?utf-8?B?U3E5MkFsWUI1V0Q3QnJBN0ZTcXhSNUpmNFNqSjBBeGFLSEhrUHlFcTFEOFV3?=
 =?utf-8?B?U1cvazFIRTlaVGhGcVRwSG10NllQdGtUQXB0YUpoWTRXekRZZE03S0Z1blU4?=
 =?utf-8?B?VzgxZk5LdFczZW1kMTc5WFhjVEtYNk1SYzRmMEpzS1QrZGJZQzA2akNlSHRa?=
 =?utf-8?B?OXZ6U0FlcjhVTVZJTndGUkFZOS92NXRsazlFZVJ0R1lOWTVsTVFONWthWGU3?=
 =?utf-8?B?ak5PVHRmTk9lQ1lqakMzNXh3QXF4a3VmWjVBUmVzL01ydGpYTE9CMDJSYWlJ?=
 =?utf-8?B?TysvQWhPZFVBM0I3QWVEYTJBRi9md2JzRVJ6aS9aVkU4YzlyK1l4VlRWWW5h?=
 =?utf-8?B?cGFoVHVwODkxT3hwRHRDeXExUFdYTElHNVVpL0V4WjVBVkh3N0RnY1FQUE82?=
 =?utf-8?B?WEkrRmFvaW5RVjBycE4yVFMvUXB5WnJGOW9aQm1wdmpsSG91ci9HUnE0QURR?=
 =?utf-8?B?WXI2YUxOQnZXMzNpendGTHIrQjVrR3F1N0piUG5TcGd3cjNDU282cnNTdFVL?=
 =?utf-8?B?YVZUQ0pUTHNoRC9Rd1RmeU5kdzkrcG42aEFmUXJ1dVNMN090RDhQa0c5WS9C?=
 =?utf-8?B?SGhTR1VBUkpVM2t1YzA3MnhkTUE1NENPNXhBUGZnTmc3UjdzdWpYVFVqT0h3?=
 =?utf-8?B?NndMUDljc3NhTG1LZ21XT3lZZ1NOd29Ob1dEcEJuZUcxMVJ4eTUyRmtxbW8x?=
 =?utf-8?B?SmNxbWs1R0pORlUzemZ1SGhOeEpWb05RQlZHY3RWdGIzbXA3VWd6VTkreCt1?=
 =?utf-8?B?VE50NXg0c2VQLzhxMmhRTlJBUGxFV1haWk92dUh0S3A4ZmlzSStua29JZERR?=
 =?utf-8?B?UHluYy9zZWJnU3ZxMHVwbkVOTUFwa2hFeWNKVVhJOUlrUUxEemw3TGZaUklt?=
 =?utf-8?Q?hMrcgRTxzpw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhEK0hsNXB1QXM3cGJ1N1Zhem9HL1Vjb2RjLzQ5bW11N3Awa1Y2Z2JjdmJR?=
 =?utf-8?B?c1hCRnhrT3FtYjhsUVNzRDE3RzVVTmo4a2FnSjduRitnV21uSEhvQURvb1Fh?=
 =?utf-8?B?amZzVWJTQW5iQzdqVytpeXloT0pXeEtvb2c2NmlKOG9KUzg2TXNNbzFmY0o4?=
 =?utf-8?B?VUxQdGd0MXA2a1k5Q3hVbkF4Z0N0NG1jaUtjUXhzMnRSRVBTeXFYeWVvenFF?=
 =?utf-8?B?b2ZJSVRMVVBadDJXUFZONXB0VkR5ZFIyQmJybnA2MzVudUxyOGM2dGg3N3Yx?=
 =?utf-8?B?WVJReEZZSkpaZndDL0FRTGtPa2tHU3dSWGVoUk05NDlsYWpYOG52bklzNDh4?=
 =?utf-8?B?REM4UitkNXZzaGM1UjVqZHFBZWJmUFV4L1lBTFpGRnpIZUNqZjcyS0pSNWlz?=
 =?utf-8?B?NHNnWXBUa3VQYVQ1ZCtBWXRpQjZ3N1BZZm9sVUJlVFFKUzlPRSt1NXBNOWcx?=
 =?utf-8?B?ZEFLRzFqeG5FbGYySXVPemNSZDdFRnZQSnQwZ0JZTkNKNmlzZlN0SUc5NTZ3?=
 =?utf-8?B?bnFxMmdvYlFnaStOcERWTEFub3EycEwzcGlSemF5L2ZpZ29TM2k3ckZad1Jn?=
 =?utf-8?B?Q2hSQ3R3cUVncUxCTWlGQW53VlZYTC8yMkhrS3NQUnorYmpEN0tLVUpNMldx?=
 =?utf-8?B?SmJ4RlVXUUtORkcrcTZjUlpzUVNpa29wSlNXVzBhYUVsTC84dGg0dmxGRTFR?=
 =?utf-8?B?MXlrMFByMFA5eTNHSXlGd3ZHZjZMQWcvVnlXbnYzbW13NEEyck13ZDAzcFhP?=
 =?utf-8?B?UjBiNXY2VCsyZW9RaDJCcFA5dXM1WEkzVE8yVjNjMEF3VUdlV3RJQlZQbko3?=
 =?utf-8?B?MkswMkFwZEFqUS9UbHFmbHVSdmMzbE93WFppdlNwUXJqNHFVaUVBR3NoSUJy?=
 =?utf-8?B?OSsrYXdDVWtpVmtOY0JWRy9NU1JIOXhIU2dUb3hyQUlnM09iUElydXlLMG9C?=
 =?utf-8?B?d0hTTkk1QnpVVGpwSERKWGhTam9HS3Y1dVVySngrdDQydGdra3RNZ0xkeFEz?=
 =?utf-8?B?cHBtdTI3WURqNk5JU1BDc3ByMUNwRlV3OVNFZ2tGaFRVT3Z0MmYzVGxFU3lU?=
 =?utf-8?B?Mi8yaHFidzhrVWIzWjVySjZZM2Y4L3IwUEFxamdnS2wxejR4cGIyTFUrWC8w?=
 =?utf-8?B?eFlaUkhTL0dyem43Ti9uNy93LzJxbjN1azQ5U2dheUpOaXlMUjg1Y2VVWmJE?=
 =?utf-8?B?Tld3TisrcVNpdXBEN2JNandiclF4V2ZUNmZ0YmVSL2RWZ2xJT2x3MmZ1RFV0?=
 =?utf-8?B?UjNyN2FSajdQbWcrV2VISWQvSVpyem5zU1Y4NW1nbTR5cGpLV2dxTCtVbnJJ?=
 =?utf-8?B?SWFyTHl4WmRla21XQmIzRjJEY2ZaeE9CeDR5dzA2bDNBWDYyT3RQSy8vdDBH?=
 =?utf-8?B?Z3YzQUJOWWNrYUkzRm5UTFBHS3llNlZNbXlsbkErMmhVL2cxNEpFRkxHa2RV?=
 =?utf-8?B?VG9TS0lsTXkxUGpjODhPK1hzclF0QVNwdkRTU0d2NXRnWG9lcTRIVEQ4N2l1?=
 =?utf-8?B?d09tSmZsbjVRajVWN2FhRVVyK1hhMzBEOTdzT25SbmFVa3pFaWVjNXBRVWpX?=
 =?utf-8?B?M3c3c1FVRkFSYzFITi9qeGV0SWhoa2RvWXBEd0EvUDdLMmpLYXR4S1MxVlBC?=
 =?utf-8?B?TlUyRnExdE16TGhTSlNVOXQ5aTEraG1ieTJYYVkxTG1ienZJN29IL20vU3l5?=
 =?utf-8?B?ZXZ3UDRaYXVUN2VqWW5jbnhINlpTUHJaSUNlK0VZYXJJQVllRDRab1Z6SzBs?=
 =?utf-8?B?WE84OFYxY0FHQndwUTU3cFcvU0dGaXkwRUhlRjZZa0tJaWY1S24ybi93NStJ?=
 =?utf-8?B?WmlnOTkwRnBJZXZhdEJpR1AycktRamVsSENDMkFwbjM1dXU1ajdEUjJLZjdZ?=
 =?utf-8?B?ZklNQk1qeWhiQS9FYlZTVzRidXRVajhPRFEvQVZvamFWUWg4R01hb3U5cE9u?=
 =?utf-8?B?UUowOGVFMGp3dzZpcWtSeUhoNGhoSXNCN2szN2JhUXR2aVdZVUdwT0loNkRx?=
 =?utf-8?B?M25ubkJpUnppbjNHb252bDAza05SV2pZdFB5d3VBeXdSK3p0ZHVMRW5YQVF1?=
 =?utf-8?B?MmxHMllCTFBkSUx3UHZxNENMMGoxMGVLcmV1VE5XaTdWVCtVQWswZEtxQ2ZY?=
 =?utf-8?Q?cH+lhAggD20xPvwRLa05YaPbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944fbc7-ad2e-4b5c-b1df-08dd79123fc3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:02:24.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaTSf3f8widUzO1axZJSPblNzP1zAUaIyIDZ2wUebg22PI91NL11ngtdEJjp096GM/HId9LcLucDhafo8Dml3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

LGTM, thanks Alex
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 7:42 PM, Alex Deucher wrote:
> If userq creation fails, we need to properly unwind and free the
> user queue fence driver.
>
> v2: free idr as well (Sunil)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 79f4df4255c50..41a095c12f956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -330,6 +330,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to create Queue\n");
> +		amdgpu_userq_fence_driver_free(queue);
>   		kfree(queue);
>   		goto unlock;
>   	}
> @@ -337,6 +338,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>   	if (qid < 0) {
>   		DRM_ERROR("Failed to allocate a queue id\n");
> +		amdgpu_userq_fence_driver_free(queue);
>   		uq_funcs->mqd_destroy(uq_mgr, queue);
>   		kfree(queue);
>   		r = -ENOMEM;
> @@ -346,6 +348,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	r = uq_funcs->map(uq_mgr, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to map Queue\n");
> +		idr_remove(&uq_mgr->userq_idr, qid);
> +		amdgpu_userq_fence_driver_free(queue);
>   		uq_funcs->mqd_destroy(uq_mgr, queue);
>   		kfree(queue);
>   		goto unlock;
