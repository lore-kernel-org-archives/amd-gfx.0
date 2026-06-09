Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D7CD8CAA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E2510E25C;
	Tue,  9 Jun 2026 11:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HNcr9mCf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9634810E25C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TppcxMX3HBlLAMxW55YwoVeX5favi7faH2KIcB6ZO7YLFqqxI61Omrfw6G7JS5ajFW+vp7biDPmX2hDG8ZxMip4zwnbNQTYkJo28yJUN6xG0EFVqTvM3jV+V/CxEPdhKzWtcCSYkv/BLequGw1pSgA3t273ZdOXQb1d3stIzOK3T/Mmj3mOs8LwjyvA8tnvOXAX/tzqW4qbpst5/PCTWa4WhNT3XHcETCtS92TCQn3nevmrWyV65yCQPzZMHxY0jU9Z3kNdrVhURCbEmr40F2nAbvt+NnN0A265y47P+bnY7jxE2CAJMLZBXErhWIGvrk4cJfWAfSC4jQIilYIxDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixsDSfXXa7GR37nj4YncMid6cTKw7YSUFomPkOQb0MQ=;
 b=IqQ9MU1kQAbCwuc7h5YcmpyWhNsTU23wAgxixE3LDbnSX5JlwNWQ0LBuDhpu1X080SoTcV/H186bcZiyDfy9SgXpZ78WLt9lkqNr9gCFwQz7vAanKkEibbu+4XN8gqTEJVu0kRiuOHJIGoNZXNXPmlQYF/PdmSVSjO1qiDuCCgQLKyd3fzjqbpfrPYcySIfA3ieN2RAp6zcDSmhpRKu9umAvqiDQNMubTN3Bn5JjRPT0wdlv8WbCzd0g9Uyfq+T3TRjOFCwjnnezfTSJeOqzdVwYu1bW/4C1Ced3HDMH3etW7qRFgxwDiPFJzGyOVSpU5hjziHva1lgdFkB5k91Rjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixsDSfXXa7GR37nj4YncMid6cTKw7YSUFomPkOQb0MQ=;
 b=HNcr9mCfgirT9JixgqXhN6oI1aCAeN8EzbFvC4dJdnT17WReShmjtShig1fld39NeWynlxg51qfdjJOv1xeYgdxt/a1mLalnSnuX9RqQJHJIzUC2TU0CtjKPbfx79r5Mi5fPvBCLyp9lSsDEhCijg9blwePLoLgdiwTsFHpJgCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 11:00:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:00:56 +0000
Message-ID: <6fb687a6-4e2f-4fd0-80a5-1177d2df3b5e@amd.com>
Date: Tue, 9 Jun 2026 13:00:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] drm/amdgpu: move amdgpu_allowed_register_entry
 into amdgpu_reg_access.h
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-9-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-9-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0478.namprd03.prod.outlook.com
 (2603:10b6:408:139::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 650578c0-d987-4d5e-3d86-08dec61661e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: m/LZ19akJUpHxWO7AS23QkbxrEOZv2McJuLxYQR/55FIb7GWAgEzMhQ2Jeux2eCPc5kjRu+t+5d3fKpQ6lkuRLTh6/TIWPHyOMu6b++Q4d9o1CS15tpxDC++RGMqqrhVdrJF4MisOooK1nz+oOsBd6HrZgxxBzzGRJIb8OxZDK0B2T/JNUTGRT2zbxlUVDurV3THdp5mLlahNUBTXZGCadMGKiJX5sjHrSx/jady6eigExTJ1lObV/kyQ6Xnfx5jQozpZk/TSkpXCmUm12736h36KChARKkTuJdBCVFI3szMCv8T8yawRkLtWfrNx+VOjtWXxzL4LuaPFIDT1WS6UhsotPNGKmHQW9ZVcrEAGpl8nhGmIG7HNTSFT6ue2wFgKVQy2/SpSwsWRF12ZPleV0/qoi9IneooB2vx0VYt1CrCrG2cbPzkVD/7mAke4YdPB5MJHKBodwWUPWoqXMRoi0+WFU9ZX5sJS5SmcjZIEk0YhvQECLXbMfOwWyUcxCXBwjRQulWBjjR+scmmESF8yJBNL88AjFeDwUi+TvDG8uczDo/0N9NN67T0XGOpIQqMptrUE7ZAAsMlj4C5k2tXgCAV8O2P6UPIbq91uymmMs7ULZc1xL6iyL81VHUHhRtncHpgbIaZKqDaOjx7F2Ih7+du52HIchs5JBmm8/dDq8ICcAyPtnfNTff4yRYDw66y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellZSjNIemZhTy9NYk9FanBrZzVUWlNPV1JrR0IzNW9sV2ZuNUdLQ1F3bHY1?=
 =?utf-8?B?SHhkMXZkdFFTd2w0STBIbFV6dkw4U1JuWUh3U2t4L1pCeEd6TE9xUGZPRDVp?=
 =?utf-8?B?cGJqdDFZa2U0R2ljNGliUi94KzlLSnRjWmJTWUQ5cXNVeWVnRjg2SDhqTnlp?=
 =?utf-8?B?OE9EcGNZME9qR0pYYXlySXJEVEphdFplMmw5b0RzbHhmUmNWUVFxMFpOZHZQ?=
 =?utf-8?B?U1VIazlJZ0xqcGFtN3piQkI3bDhHMzlsUG9IYkJsT0N4WFk3WWRtdHFpRFpw?=
 =?utf-8?B?SmlFcDN5cGFTaE9mMWtkZVgrcWsyaUV0TW9qZTZNT3J4Ylo2blJkZ2luYUpl?=
 =?utf-8?B?Y051YXVXZmtKS2tYTSt0SVloeUFLNE9OOXp0eVQ0SFpwNnVZSTBBdnhMb2dq?=
 =?utf-8?B?RVFDRW03U0gwRHgyZlI5bVRsRTNxQ2J5QnhmNkppVWpzbHVlb1Z2Yk03b3Qw?=
 =?utf-8?B?aUZrekRMOHg2WmxyMGxnUk5wUFVoNjJvYjVkWmJwK202dW90dmZBd3F6ZFpl?=
 =?utf-8?B?RFIvdVJGV1I5Umptcm9zenNuNGdIRCtTRm1BeFExeXlBakdQaDF5a0pWdXlD?=
 =?utf-8?B?U2poUytkNXUvRTQ5NlMrNnc0czV6QnYwYjRUditIR2luR2Qza1BxZm1lcWJo?=
 =?utf-8?B?ME04bzh2cmNJTmwvdzl5YjNuYXBkRU1ZT21ISDRCMnVzQnBKZFRLUDdmaXZm?=
 =?utf-8?B?ZTc4T1V6cTYyZUxITzh5N0R3V3dJc0dpM2pVUm5HdS9WeUFKS3ZlVDY0U0Fl?=
 =?utf-8?B?cmcvdHFGWXpZTXoxWDFTamtJTXBKY3drbnVIU2F0Y2Y5cHhmUDVTeGk2MGJ5?=
 =?utf-8?B?UGNsTU90d09RRHFsK0NFYXNxY3FBa1RObHN3eXA2ODlRc050K1Z1YzVIMW1X?=
 =?utf-8?B?QmFlY3R2Yk4xM0lxTmRpUWk5MFpDZ1ROcUs5anhONXY3V05LeU16aE16Yk1R?=
 =?utf-8?B?enVPbzhFdjZidWJIZTJ1UHE0Zlk5cHAyZEFKVGFzTU94dkRKNE5pYWJMak52?=
 =?utf-8?B?d0FOVVRUdHpONE96aGJlYitWMG1RNUNGNFdHMzFyUVZ0ZDhqWEVDNmFtd0p3?=
 =?utf-8?B?d2IrQ2NaS2hXY29MS0RaT3hVYUFSb3R6bHFUOG9CREFub3BSUCtJQmh1UTQx?=
 =?utf-8?B?RkgxakM4d2NYL3ZPbU4yRmFnMVc2OEVQa1EyQXNKNVk0QlF6dURmMXZWc3dx?=
 =?utf-8?B?WmRDVkd1QTRqcUl3Qm1xeE1LSEMzR2NPMW81dEppUGpRNzdvY3pBbnJ2Nzdo?=
 =?utf-8?B?b3VRVmpNd3BFRnNiMzFrYmxFVDEyV0hwYWJIdm1aZ0xsaHZxK1RSSFJ2cUxO?=
 =?utf-8?B?YmppRTlHdExGbVcvWHk2b2NqcGUvaVdJczNFS3pIelpnb1NxQVZQbmh5VElJ?=
 =?utf-8?B?NVZuRmsyWGNjVkJqUUx2ancxclAxSE5HQnhoNnZHVTNla1NibHNOSm94SVV3?=
 =?utf-8?B?WmpQdzZXOVM2OWVDNmZ5cU1obVQ5U0NYZzYvZGM2WWpSaFNuUksxRUlNWjNy?=
 =?utf-8?B?cDJ1R2pRTjBvYjFZdVBXTkJqTFUvbFR3bm8xcGhMVHJ4MGFYUXZLQURSWWxw?=
 =?utf-8?B?UmxwZEJkS0Rkeis4ek8vT2FOMTVHcUxlNFZyOUI3WVJ0aWZYem9PQnAwQ1RB?=
 =?utf-8?B?ZllQVm1zcm50VjZHbElYdzJBYWoxbzZzdzZSb1ViUFE0ejFocXZVM0oyZ3Jw?=
 =?utf-8?B?bFlUNTFxaUk0Y0FzeXZsSFlRS1gxSkQ0N21XaFlOU2Y5TWNDaHlxdFJReVdJ?=
 =?utf-8?B?YWNlL1BnblUyVnlHV0hUYlJCdWc2SktVdHFSUGFLK1k3ZHg4L0x0d0xNTjV1?=
 =?utf-8?B?SzJBdnpPZEN5aVgySVJ3YWhnOU9HbFpoeXVOS2UwK3lpNjY1dnFISm5QSUEw?=
 =?utf-8?B?RVNwUCt0U3dLb1NvenNyYUZrRHlZNFp5ZzAyblF1dUYwbVE4cDlNNUlwU0tO?=
 =?utf-8?B?S2tNOTZQcTVJNHFMSnBiMmxaNEhRUzhrbWhwbGhNT3gvdW5rTGhPNmFsbmdP?=
 =?utf-8?B?bFVsM2ZmT2E5NDJqWHFwYW14OUY3elFmTDVWNFNlUkVVU0p6VVEzZDlPei9X?=
 =?utf-8?B?dGJoQWd6bTBXR0h0M3E2WE1BRjkvZ2lZTjc4clVSTVZIYUx5L1hucmhKYlov?=
 =?utf-8?B?TDdleVV6MG9jTE9FQXRzQ3FUSkFWTG1CZk9CZTdFM0dBTG1WTk10dTA0a0Q4?=
 =?utf-8?B?UTMyc3VteFFSTE9keHd0TGZNbUdUa2hYU25OVnlRSERYQjkvSU9yTHR2NGpm?=
 =?utf-8?B?VmFwZjkzeE9aakpEWGxiNjBPV2pqLzlhRjRucU8wOXZmMUQwM0c4Y2NVa3dG?=
 =?utf-8?Q?0Gs6QiaQT/2vWjmPMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650578c0-d987-4d5e-3d86-08dec61661e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:00:56.8697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiSG9rkDhPaFjCWON/Hzloza/BvuWfl+txge2L2N6w+0HgcFY2Vi/H/XERJDpQHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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

On 6/8/26 21:47, Shahyan Soltani wrote:
> Move struct amdgpu_allowed_register_entry from monolithics amdgpu.h file into
> existing amdgpu_reg_access.h file.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 8 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 85d040184d13..a29987567a0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -433,14 +433,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>   */
>  int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
>  
> -/*
> - * ASIC specific register table accessible by UMD
> - */
> -struct amdgpu_allowed_register_entry {
> -	uint32_t reg_offset;
> -	bool grbm_indexed;
> -};
> -
>  /*
>   * ASIC specific functions.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> index a1011af6b52b..320c30ce4a62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> @@ -89,6 +89,14 @@ struct amdgpu_reg_access {
>  	struct amdgpu_reg_smn_ext smn;
>  };
>  
> +/*
> + * ASIC specific register table accessible by UMD
> + */
> +struct amdgpu_allowed_register_entry {
> +	uint32_t reg_offset;
> +	bool grbm_indexed;
> +};
> +
>  void amdgpu_reg_access_init(struct amdgpu_device *adev);
>  uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
>  void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);

