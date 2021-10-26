Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB48C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B90660F9D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B90660F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43206E869;
	Tue, 26 Oct 2021 20:06:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163386E868
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 20:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6I1oFiC4+iK1Vn77bEM2eUiYbp5Q59v5G2dOmPBtpVIpH3RfttUi1ch2xnmM9yrGFB779Ejw6BvVHryIfJO2If+FZ8yc/XZ0V/hqEsDCicTPTRhZMzv3Fza1moukpTy/iRbW0lfCdXjEnGTOxHs98cKx44QI4kDT6DPPAbQZJaHW6V1Xgba2EYU2gucS8YXnpefGy79US1Ibqr9k2Af08wtmqPo0cVNpZu0an/xKWtTtOFiSvCQYjKND6RjKlneYA01rsLaSIgood5PXdonavcenyEMiTkwt93H6aLx0p4YIQm6ue9hF/w4Kf7RX7vav03H41e0ev8U7PfV9YMvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaGzUfe61ux4BSw8a0XoF3CbvBNHXIR/AEm8Kig305c=;
 b=kBIv8DBw+uxnlpJqi5BGxzxoMkHSS6DKe9wKGMCHzPPTeyxxuHiHsM2khNwJwqiptJnz/GTefaJSMWjTgtAJ1pp+vGOIJ/m/wPu1/sa1LHmJ8khjg6AXHPwmC4MCKHDzm1dW114wmQxHhPGilGreqrXbH/G8XmmqNjg2hYTLCGUOD12yEvDvW+TTxeWEy7wcTWaEMql6EVUHlR4ZBVt5gUgKioIjDsfzPWTqs+JsgFXY1QGMIeESp6raTNZKic/LVue/vaIKHWpq/4eCK5RVdgpRhAHgCTwthJSI2CImNncNud1E1TVBpgvratpf9nM21pxYnIXuE6DfColBnUHaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaGzUfe61ux4BSw8a0XoF3CbvBNHXIR/AEm8Kig305c=;
 b=na/24jgZj2nteJv7ZbeJHpPs550xSMouW9WngAuUKZxD06qY2EAzsSQuH9J366kYTAeCukYelHCuiBmYhadCresWvR9YkGkfXmoZahod64KI5jqaAjdVAWUqohj7VotekQawyDLfHjEeHMfNZADgvhsXe74Dg86KAHhBN04oxik=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 20:06:56 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 20:06:56 +0000
Subject: Re: [PATCH 02/13] drm/amdkfd: replace kgd_dev in static gfx v7 funcs
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
 <20211019211334.1552825-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <03de6841-ab7c-dfee-824a-09499e986608@amd.com>
Date: Tue, 26 Oct 2021 16:06:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019211334.1552825-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::44) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 20:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b736a5d-78ac-4317-aa2e-08d998bc28f9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16580AFAF0D4AB8C0441864F92849@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xOmAkefm0OYdrbSL7wgPW9mfzAUEwnJFqGeTi79+7Vx8e3FhfikNMZCddCR6TnO9eNVSTwSrl379U5py5fz7G3cpFMNuECbL026zwY3L0PnuykRSqoCp4gCtC47RTaBX0yUjql0eRzNU014M8mVhBV02hEoYD1jHRG7BcjIEUtgMn7RsQ8mppmYRJs5TUv4xlTJ2iId00ng+qmeL6k8OYC5RQ1UHkidk8tPag/gcfSTeAAMOBJ127gy6iFzXKMHJrtFAwdZPtZdYxsLhIMLT3vL35k5KwfAvlokEUg4wS3KZXdv0S9MXpgmJt9rFBw20j30aUhRPXmvQMvwnbaY4k/fsEolpdb/S7K4bqe3USkRLpYwZZticL0dHDk/yxFbl8r/BVEOprn7vF2jEjXmZNIHYyQsvRjVFRXxUZZCfMLKRbGK0bkTvj7hRTyKndXCqMb8ZNqsWmw22cfVdsD8L3AtV71/brgpgk9X4g1ufGGYE6rpu5sW2G/RgPOk5+fKszdaWRsTSAqzU5mzKWNtGT6WAzy4FLRFZf+Ow6amfCgQtpzuga7UoxHcyBEy72BXFV2Tx14CLa47Lls/ifgTImtLQbFFZQR/e5P7W5JYNoLIbZCLCgFTMlOru/ZFM0ruJEBI3Xaw6IDbcsCIVLp+UhIK0c/hF/121RRFir50xTQhjCbx+g1O5ox77OWMS60hgOVw113I8jEhOKHYphY/FaPu5e1wgwF0pvDhBsrLe6sjA4Hghxf4cjCPESHzXb1yp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(31696002)(5660300002)(956004)(31686004)(2616005)(4326008)(186003)(4001150100001)(66556008)(86362001)(6486002)(508600001)(66476007)(66946007)(16576012)(36756003)(316002)(8936002)(26005)(83380400001)(38100700002)(8676002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNqWDZ1YU9YN1oxelEyTk4rRmxmMWk3c2RsTHFnTWhIV09oczRqMy9XT2h4?=
 =?utf-8?B?UGFjMm44eW9SZ1l0OGU5Q1g2SndoT2l6c293YmxSS1h0eXpxSFVPeEFWVVhF?=
 =?utf-8?B?dGVNRUJDb1FSUElGcTc0VHg3K0VxOTZYRzdjOTU0YldNclhpOGhlY0VWb083?=
 =?utf-8?B?TEF5RGN2V2Z6cUhlcEVvc0srZEk0Q0t4M3I4YkI4N01TaUl6SjNZWDRPTC9k?=
 =?utf-8?B?TGRuYlNaVHZ4Y1hNUUU5NHJwSVNnUVlVLzlSbytCbCt4Z1FDRHE3SG1hSCtz?=
 =?utf-8?B?b3VJTFJDMnBsY0pXblBmL2ZDdHVxeHpqMXFweUNZL3JOakR2TkhEUWZIR2dp?=
 =?utf-8?B?enFVbXFBMVN4OGtiY3E2dnNEeUUxYUpGa0JKdFdrUU0yNlBkSmRRRzVqVG9t?=
 =?utf-8?B?NmpRNm81Q2ZpMEZwa3lJSUZ6VHRJazlpWFdPdnF1WjlPUy8rYnkyQTN6Q1A3?=
 =?utf-8?B?YUVOS1F6dUdzeU1EaHhHb0g2b05HY2JpVE5sM1BLTWwySU45c2FzcC9QUlhT?=
 =?utf-8?B?WVRvS2E4QTVSMTBYZmVFU3daSXVUOC92RXJIQmhJZXNidUZPdWJmdTkvTmpB?=
 =?utf-8?B?YVp3NmluOXJCT0F4WmdJNlRmUVJHYUVyejFsN1A1N3FIUjUybTRqK0Q3amQ0?=
 =?utf-8?B?RVBvaHBieWdiVmpUU2w1cHpQTmh3ZXkvbC96bTNVUmZzeG9sV0VMbVl0OFkr?=
 =?utf-8?B?d3pyR2d2MmZ3NHZRR2pIWk9kTFJabE5sV0lIMjBVQlNHTE5uM2I4RFR0NFNN?=
 =?utf-8?B?eWxrdDZoNFpkL0V2cWl6VDBJQ3N5SHNvYzRMRyt4U2IwUUtpanYwN2hrbmd3?=
 =?utf-8?B?UHdyVldQNVNzUjZzNmZ1MjdJc1pYeU4vWW9XM3BuNDJ3ek5SMzZPbXlyR1Bq?=
 =?utf-8?B?MitzUXp6Y2s1bkxCNFE0MjdPR1hSZkkwRzBsZUZRRFRQdnYzbWYyWEE4WktX?=
 =?utf-8?B?UWlna2NxTGFnTlRvcWVYRnBUdmRPaHUwb1JqbTV0S1NzWjNlcDZGSHhKK1pU?=
 =?utf-8?B?VE51Um1MSTdyQ2NnRCtEWC9NZ0RNNUlUM3Qyek5OVTBHeFVZV09aQ0NjaHhm?=
 =?utf-8?B?ZU1RMjlzbGorRmNpcEh0SGNnekZWRTUzRU83V3VhMjIxbkY1QVJoQmdQZWVO?=
 =?utf-8?B?R1IwSU9mVDJSZ1Y4WXBiOGJjRlQ1K1g2UDhMbmdMaDVOUHJTcmdxOE5lTnZO?=
 =?utf-8?B?NW1HQVV5YnEza3J5cFJrL056WUs0UFB6Q3ZyTndZbXdVajBGNG12Vk1kazVh?=
 =?utf-8?B?VDR0VzR6N2FBczdBbjZleGM4dHkxWDM1ZGU3MkVyUy82WU13S0xUeEI1cWor?=
 =?utf-8?B?TkR4andzTGNTaG9Ob2lXYVJoWWs3dnA5VDA3OEprZTlBdTlIaTB5bk9SMUow?=
 =?utf-8?B?S2p4b2JOUzFRd2VmcktLdm9WRmhzMnpEd3hGUW03WFdLWVBxVnhhSmZDZm1F?=
 =?utf-8?B?Yng1ZEUvTGJLSE9IZnFmU0NRRVFGVWo0SjRES3ZZRmpWalFocW9wa1MyeUdC?=
 =?utf-8?B?ZEFTV2xjZHN3VVl2aW5NMjdsckMvdTUydFFWVjErNC85OW1XVm5zWk44blE4?=
 =?utf-8?B?VmMwT2JiNzJPSmdGVGFhRFI1UFgvVGV6YUUrbTRQYUtWYjEzVEZGalg2SFMw?=
 =?utf-8?B?U1p6YTN4NEJiQ2NPejBhSWJCK0crUzFLSlBXZkZVNkhCcUVKSTA1ejdKNHpB?=
 =?utf-8?B?aDFSM29kTlZqZnEra1JiMzI2a2d4M25nVW8rb3VtWVM4Ri9zWWdPSnBzNVJv?=
 =?utf-8?B?Q1NCYVlxTUIxSkhMWVM5VEZoRzNyTnZMWEZ2cHpxSEhYMjlMWWl1RE5iTitI?=
 =?utf-8?B?WlRzS0xESDFJcTNFRWp2cWZDYm5XNXhVZjhVYU54Z3FvSzhCQ2FBVFNjSGZD?=
 =?utf-8?B?VDFhWUNMcjNGM0dsQjBLVkwvbWt1bDFid3BBcjEyNzZHd0JxenVock96dE1I?=
 =?utf-8?B?N3l2S0tqRDNIaEpoYnNkcjNINkdlZUJiVGR4WldNaVRKM2VJMkJ4L3p5VWpw?=
 =?utf-8?B?UVNqUmxtOXVuWmlHeGo0RjdlMHR1MUJsczhOaHBBT2h1cDFIZTFkZzhFSk5t?=
 =?utf-8?B?ekkxY0N1a2dENXY2Kyt5OUZaOE5hMDY2ZnpzMmg4dDBiVXpMNWlIdVlIZm9X?=
 =?utf-8?B?Yk52UlYyMjB0ZnZjZW8wZmh4Z1h2b1gvaFppdUtRUkZNd0FGUytnb2t6eTcw?=
 =?utf-8?Q?hYeFAnqVfJK1Ov9GEBRZ9D4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b736a5d-78ac-4317-aa2e-08d998bc28f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 20:06:56.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3FAU3VEG7AED3p21HNE+IqzyWXiz+Tj0s7rKjjc0R8apInq5kR6XSrBf80KaFb2Qmtx+dZ23QmilcyuLCSNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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

Am 2021-10-19 um 5:13 p.m. schrieb Graham Sider:
> Static funcs in amdgpu_amdkfd_gfx_v7.c now using amdgpu_device.

Doesn't this cause pointer type mismatch errors when assigning the
function pointers in gfx_v7_kfd2kgd? Those only get updated in patch 7.

Regards,
  Felix


>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 51 +++++++++----------
>  1 file changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index b91d27e39bad..d00ba8d65a6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -87,38 +87,33 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
>  	return (struct amdgpu_device *)kgd;
>  }
>  
> -static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe,
> +static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
>  			uint32_t queue, uint32_t vmid)
>  {
> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>  	uint32_t value = PIPEID(pipe) | MEID(mec) | VMID(vmid) | QUEUEID(queue);
>  
>  	mutex_lock(&adev->srbm_mutex);
>  	WREG32(mmSRBM_GFX_CNTL, value);
>  }
>  
> -static void unlock_srbm(struct kgd_dev *kgd)
> +static void unlock_srbm(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> -
>  	WREG32(mmSRBM_GFX_CNTL, 0);
>  	mutex_unlock(&adev->srbm_mutex);
>  }
>  
> -static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
> +static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
>  				uint32_t queue_id)
>  {
> -	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> -
>  	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>  	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>  
> -	lock_srbm(kgd, mec, pipe, queue_id, 0);
> +	lock_srbm(adev, mec, pipe, queue_id, 0);
>  }
>  
> -static void release_queue(struct kgd_dev *kgd)
> +static void release_queue(struct amdgpu_device *adev)
>  {
> -	unlock_srbm(kgd);
> +	unlock_srbm(adev);
>  }
>  
>  static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
> @@ -129,14 +124,14 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  {
>  	struct amdgpu_device *adev = get_amdgpu_device(kgd);
>  
> -	lock_srbm(kgd, 0, 0, 0, vmid);
> +	lock_srbm(adev, 0, 0, 0, vmid);
>  
>  	WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>  	WREG32(mmSH_MEM_APE1_BASE, sh_mem_ape1_base);
>  	WREG32(mmSH_MEM_APE1_LIMIT, sh_mem_ape1_limit);
>  	WREG32(mmSH_MEM_BASES, sh_mem_bases);
>  
> -	unlock_srbm(kgd);
> +	unlock_srbm(adev);
>  }
>  
>  static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
> @@ -174,12 +169,12 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
>  	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>  	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>  
> -	lock_srbm(kgd, mec, pipe, 0, 0);
> +	lock_srbm(adev, mec, pipe, 0, 0);
>  
>  	WREG32(mmCPC_INT_CNTL, CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
>  			CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
>  
> -	unlock_srbm(kgd);
> +	unlock_srbm(adev);
>  
>  	return 0;
>  }
> @@ -220,7 +215,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  
>  	m = get_mqd(mqd);
>  
> -	acquire_queue(kgd, pipe_id, queue_id);
> +	acquire_queue(adev, pipe_id, queue_id);
>  
>  	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_MQD_CONTROL. */
>  	mqd_hqd = &m->cp_mqd_base_addr_lo;
> @@ -239,16 +234,16 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  	 * release srbm_mutex to avoid circular dependency between
>  	 * srbm_mutex->mm_sem->reservation_ww_class_mutex->srbm_mutex.
>  	 */
> -	release_queue(kgd);
> +	release_queue(adev);
>  	valid_wptr = read_user_wptr(mm, wptr, wptr_val);
> -	acquire_queue(kgd, pipe_id, queue_id);
> +	acquire_queue(adev, pipe_id, queue_id);
>  	if (valid_wptr)
>  		WREG32(mmCP_HQD_PQ_WPTR, (wptr_val << wptr_shift) & wptr_mask);
>  
>  	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
>  	WREG32(mmCP_HQD_ACTIVE, data);
>  
> -	release_queue(kgd);
> +	release_queue(adev);
>  
>  	return 0;
>  }
> @@ -271,7 +266,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
>  	if (*dump == NULL)
>  		return -ENOMEM;
>  
> -	acquire_queue(kgd, pipe_id, queue_id);
> +	acquire_queue(adev, pipe_id, queue_id);
>  
>  	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE0);
>  	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE1);
> @@ -281,7 +276,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
>  	for (reg = mmCP_MQD_BASE_ADDR; reg <= mmCP_MQD_CONTROL; reg++)
>  		DUMP_REG(reg);
>  
> -	release_queue(kgd);
> +	release_queue(adev);
>  
>  	WARN_ON_ONCE(i != HQD_N_REGS);
>  	*n_regs = i;
> @@ -380,7 +375,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>  	bool retval = false;
>  	uint32_t low, high;
>  
> -	acquire_queue(kgd, pipe_id, queue_id);
> +	acquire_queue(adev, pipe_id, queue_id);
>  	act = RREG32(mmCP_HQD_ACTIVE);
>  	if (act) {
>  		low = lower_32_bits(queue_address >> 8);
> @@ -390,7 +385,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>  				high == RREG32(mmCP_HQD_PQ_BASE_HI))
>  			retval = true;
>  	}
> -	release_queue(kgd);
> +	release_queue(adev);
>  	return retval;
>  }
>  
> @@ -426,7 +421,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>  	if (amdgpu_in_reset(adev))
>  		return -EIO;
>  
> -	acquire_queue(kgd, pipe_id, queue_id);
> +	acquire_queue(adev, pipe_id, queue_id);
>  	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
>  
>  	switch (reset_type) {
> @@ -504,13 +499,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>  			break;
>  		if (time_after(jiffies, end_jiffies)) {
>  			pr_err("cp queue preemption time out\n");
> -			release_queue(kgd);
> +			release_queue(adev);
>  			return -ETIME;
>  		}
>  		usleep_range(500, 1000);
>  	}
>  
> -	release_queue(kgd);
> +	release_queue(adev);
>  	return 0;
>  }
>  
> @@ -651,9 +646,9 @@ static void set_scratch_backing_va(struct kgd_dev *kgd,
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
>  
> -	lock_srbm(kgd, 0, 0, 0, vmid);
> +	lock_srbm(adev, 0, 0, 0, vmid);
>  	WREG32(mmSH_HIDDEN_PRIVATE_BASE_VMID, va);
> -	unlock_srbm(kgd);
> +	unlock_srbm(adev);
>  }
>  
>  static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
