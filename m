Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1A4CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4EC10F66B;
	Tue, 13 Oct 2026 09:28:49 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DEA10F66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1NGnSYOCTGOrHctcnW2qn/OuwSiuWHBTXRgdu4GzVlKE7eKKc4QHYcKpmHGGBXvxNIsH5z+zWiN1q+910wN2nc/3hN+XxXcRnFb4i3IfsN0YNqhPSPrSLJqhLPJErYeuFm7HVTXbhqenIYEVziik5Xnf1c5fQhlUvEQOEAD1F9JbFeGaYx0xeetGcOY3cOxSdbqyAVdlWeVVRO5fhqEKwEqRLtdIITA7OMXuS3cw/70TvhQFuh/q9XPRi//wi6lCQBlu9wdUynEjk5LE9sQVdopAuR2KMOHCDzK4E1Aby6BcVmYHfCTR85yjvSJCAT9k6ON6RcqTu3PJfxfktc7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TF4pD/nSt70tk3Zie2KmO1FSyugfqJo+6l9XtyG12k=;
 b=ZRYN9EjIz41HWoe11GePaSWFCsujWrDljG8vpB1mi0YQA/9le6hx/TqST/rRi9O+mqDEuee6odkCOPFxzmCh1fZo8vRD9Xz1+yZa4MTJZi0kFJs6L/+zroK20NNuDSFzd52LiiV1+jjFjZSBDkjZkKajqNUDoiOFELz9fZ7mAWtRBnM01sl5LcUEsDJqk0bi7aXFb6Ew8XRLfwyApFfzxxpU6tazr5LmLfrfNU6/lw25u4UAV1McJU3R7q5WMELM5JkL1Mu8oU6isn2AafNNXAGLzH7XkYVcExGwBm/AhLcOUDPFUCv8fsb6jEFwPrTnFrkPDwg/8KElYrgn9c1ivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TF4pD/nSt70tk3Zie2KmO1FSyugfqJo+6l9XtyG12k=;
 b=KqZ+zYAAZUWWA1MUYHspl8jjWjFjypNK4k1g97rYkTtNz8SIKzcLYcnWzB4Do9H8TAkRKggkQ7j7w08VoLjGQvzqzck701JswEmA+CGCZBzDV06Dahypmp4yDUE83ftVbV9WOK1XE0LVYVfUCe+8FSh2K1AVQOKl2rbkcrmBHjo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:28:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:28:40 +0000
Message-ID: <edf91d9d-e962-4583-9c1f-dbc609d6aae3@amd.com>
Date: Tue, 13 Oct 2026 11:28:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdgpu: serialize JPEG and VCN idle work with GPU
 reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-6-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013082457.2492273-6-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: b30edf1d-e1f0-4d24-9e37-08df290c5dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|261009221227099003|261009223327099003|261009220027099003|261009221727099003|260925021311599003|260925022911599003|260925021911599003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 972MF0W305Iz9/5KpK47n6utpDvgJcJOAiRNm/MfD5qAfUPpVIydPyR8vllHbVjHmdk+jVx/yt84EplpgWwIw0iLmI9TYvQHyEHT1mFkWuQNVe8yaPz0BINGDotEWBbs8fvH238qgfpMxSzUoKkd8JSEF5ajp0HpMO5lZlWj8zmNbGiX/12FUHImPueL1PXCEmxrLfqZbWKJEXbtg+QX+WIQGG2GPs8OlL4voRKF7Enzi9lVP+YaR0ZDnUCZt+Ts74DfkXm8fTtNG2Zxaw+vzVZHdynhNKcW+TCy5Fk86wZxwJ6ZfW4BfSzrY+jXdaxQWI+l896jF9SLbPxA+Q+3IAJOdW0Y/uQrBMAOFaoTAOFSYP6RXwQiVbufWbG/eBLYl9ldys95q9d04X5SaxIu0Z8qMALxHGSnG6yysUYlI/kfpn2Z52MJvlfjGdDQTjRmvEpS2E48t1pA8KbhSWDgCRMzeedrbk0fZsxybBocGKp0zcXqy5Yk1YxiOQxWROiBc0mVcdg7D+COL59ArmTdHUN62ny575ieNMFJnIA7XoHRcJ9TH1j6DLhaUfdK3HdYiS1MTsjDATxqHDW2NmLHoWZD0ov1IeKYseGsQcrc3CbgkWLsOC6RQr2K5tHOaficGALrm/dNEkCa94q92YVUJ5g8lfDeq8vllHWRS9feknQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlubGFpcWxVeFA5NXE2VG00emdBN0JSYXlReDVnNlg5b29aaS9MNjNVTk1y?=
 =?utf-8?B?UHJZRzFLQm9YeU0vaExlZzFhUFNRaW1tOFBKdCtWK3MvU21xODNYVGZhalIx?=
 =?utf-8?B?MkpLbjJHby9sRDdRNjY4OUZ3akJUUmp5bVdTQjJpYUh5dFV2ejU4SkRuZm1M?=
 =?utf-8?B?YnhoWkpXVlFXblUrOWxQTFhjcStVN081Yk9BTWJTSjVCQU9kZ0ovbElxODZU?=
 =?utf-8?B?bC9nMEhGcmJvS2xPbjZodStZTk8zWW1CTXBkeVBkeWZpQkNYSFMwa0pmdlAw?=
 =?utf-8?B?bi9GOEJ2dU4wM2lOczFEaWExTzNnTTg5cno5YjdhUmVjU2hqSnZkaDZnS2M5?=
 =?utf-8?B?VlltUjFPYy9QS05WWDBITnpnSTdWam9nWEw3dzRmSm5heXZkZ1JnNGIwaVNG?=
 =?utf-8?B?VXQ4K0dpTmJ1QkMwekIvcXI5b0VMNDlMSUFDRVYxS2NBSDF4Wk5taEVUSWgw?=
 =?utf-8?B?MWgxVXMxY1BtL0xVeEtSaUxKbzI5SDRiY29DYmFlV0pRNU1DL0d1NFdlaDNj?=
 =?utf-8?B?RkkwMlA2QWVsbE56OXE4eGtXZlgzSFdWUjV5SmR1Z3pXV1lFU3k4MEFEUDQy?=
 =?utf-8?B?cDgxYlBkVzl4S3czbUl4SG1zMllubmxvUUZySlExZGNxdzR6WjR2eW1EZnc0?=
 =?utf-8?B?VzJHQzRMb3FlZmJLSHN5dnVCREhYSFVUaGMzQUlLOFBDZDlxRDQvYkQyaHdH?=
 =?utf-8?B?YmRaa3VFaWxhVjVGcDZJODA3TktjdlZySEU3Wk51MWYvcmxZSDBnN3ZYUHpX?=
 =?utf-8?B?c3RMdWpmcWN4bTFBRHhOSkd4ZTErQkNrbjZzckFUb1VlcEN0NTdHWWdHay93?=
 =?utf-8?B?QjZvVkhEVGVJQkdETUtmSkJ5S1Z4UTFoam1vVWFXT05kT2JGc25BcjJYM0R5?=
 =?utf-8?B?QmRUeXIyeGJxOENTckRkbVVQaXNZM3JobklkQXE2WHFMd0QvdEZmM3dxMkdv?=
 =?utf-8?B?b1pGb2JLRVY1MFJudHpoMkU5SklwTGNNOU9GWTJzbThmRnBXYlg1UXJ4MnJy?=
 =?utf-8?B?eU5Uek1EdE1PeFlyQTA1bjAyK2NJZDRmRWV5VjgwZW9ZeUUzNmpPQUp0OGIz?=
 =?utf-8?B?WFd1T0NSeFV2NUtKNzNqRzNxeEVlVC9NTGQvdkJsYTBpVG1kL050QnlteDN2?=
 =?utf-8?B?WCtGZmg0SDJXRDVQVld4WlhGTnBJeDZjWTdGZFBkYmF3V2szSTdEbmF1QXIz?=
 =?utf-8?B?STNIOWRvcXIrc0J5RTA5OXZzc3NrVWdzUnVkOXc5THdhT0JRalhsMjNOc0la?=
 =?utf-8?B?ZGZ5TXIvZzhDaSthSFo3dU0rTUt5VWRQK2NIQkZtK0h3YVF0TFpFdk5TZ2Y0?=
 =?utf-8?B?eXM0dDZLZmZ6R2U0MlJudEFBdVNUekZRRzBHNEJWS21ZazBjbERTcFoyUFRO?=
 =?utf-8?B?Ump3cjVKRDFDc1VGbkZsSmIxRUpnWlBHM3BrZjVkZENiN2JrZzlYUU4xaHAw?=
 =?utf-8?B?UHJCWjdHZ0dPbGlkU0pSdnVFdktZa3gwY0g2Z2xlbU13TUF5VEdrdDU5SkpM?=
 =?utf-8?B?dWdHUnZ3UmJ3S1FyVU1lcWZlc3RxL2FvOFZKNm1jVUZ3U0dBTjd4RjlINGxN?=
 =?utf-8?B?eDdEN1VWaWNDVi9oMkxub25YRmcrQTlaNjhOd0d4SzFyTlNqVjJYSWhPdXJu?=
 =?utf-8?B?aTNyU0NtaTFWeUFCZnNkWGxWelM0RGM4eWEzN2FFb2hPOWdNMzNoZkUxMytF?=
 =?utf-8?B?cW9VM3czSFVkOFF6Y0FaL1lVdEZsNUZSNDZ5NmlIN1RON3JSVjQxOERuR0F3?=
 =?utf-8?B?VnBuaUlRT2pTcVJ2Mk9ZK0lxVkF1dW1yUGU1S0NNMjBJN0trNXhFOFQyYVhO?=
 =?utf-8?B?RXBVTTdpRVBzSzBFWFlIMGx2ZHVjclYwODMyRWczZG1RbVRFMTF5alJtTXR4?=
 =?utf-8?B?RTkzLzgrQkNVcHozMERycDB5Uit0Tml4MG5ic29zenJGNGx5dDdQKytuNHI3?=
 =?utf-8?B?Z3RESkFKVnVXVmRUYnNHNDgwYXA1S3gyaHpMUFkzak50SlZhUnVCMTg2aUp3?=
 =?utf-8?B?L1djNFMvWlZ2VkNFZ2tLYzd3ejJqRTlDcm1qbjdxdm1ZVTQ0TnhhcTJCaFlh?=
 =?utf-8?B?ZWw0YlVrd1pYVzBlSjdWNnRpdVpyMDdaY1JGRGpQcFFYOEZmSlRJaUtTaFpF?=
 =?utf-8?B?WEs3WWNKR2MxTU5TT0h4WW5yVHFleFFqL0NPUitJQmVLMnZlUmh4cHlia0RL?=
 =?utf-8?B?Q0ZraFU1L1lKaFRJRVFmYU5SQXFHdWFjdkJURlRYbnhXMXlsSlFNcWkzUUJk?=
 =?utf-8?B?WUVHUUZUSzYrV3g4djd6OFRleWtLejA1ZWJoS3lpd2VPUitEY0JaZEJaWk5w?=
 =?utf-8?Q?6K/K3BHBlV9WRd3Hfl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30edf1d-e1f0-4d24-9e37-08df290c5dd6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:28:40.3515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uTJzY5cRI5IXfNvmtafB7scVzti5Zefm04ITMg3+cdB/K2SRod8n7JW7i9usnzp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

On 10/13/26 10:24, Prike Liang wrote:
> Take the reset-domain read semaphore in the common JPEG and VCN idle
> workers so their hardware accesses wait for GPU recovery to finish.
> Keep end-use scheduling, including from recovery ring tests, so idle
> engines can power down even if no further jobs arrive.
> 
> Do not synchronously cancel these workers from recovery while holding
> the reset write semaphore. Use nonblocking cancellation in the common
> ring begin-use paths and during reset-time hardware finalization, while
> retaining synchronous draining for normal suspend and teardown.
> 
> Serialize the idle decision and VCN DPG pause updates with begin-use
> under the power-gating mutex. Check the submission count before reading
> fences, with acquire ordering against end-use, so a running worker cannot
> miss a submission that completes between the two checks.
> 
> VCN 1.0 and 2.5 override the common idle worker and retain their existing
> worker and cancellation behavior.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 28 +++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 32 ++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  3 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
>  21 files changed, 65 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 9887a4f99aed..39b53730f59a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -97,7 +97,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>  
>  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
>  {
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	/* The idle worker may be waiting for the reset writer to release sem. */
> +	if (amdgpu_in_reset(adev))

Again, complete NAK to that!

Christian.

> +		cancel_delayed_work(&adev->jpeg.idle_work);
> +	else
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
>  
>  	return 0;
>  }
> @@ -114,6 +118,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>  	unsigned int fences = 0;
>  	unsigned int i, j;
>  
> +	down_read(&adev->reset_domain->sem);
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	/* Check submissions before fences, while excluding a new begin_use. */
> +	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
> +		goto reschedule;
> +
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1U << i))
>  			continue;
> @@ -122,13 +132,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>  			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
>  	}
>  
> -	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
> -		mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	if (!fences) {
>  		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>  						       AMD_PG_STATE_GATE);
> -		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> -	} else
> -		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +		goto unlock;
> +	}
> +
> +reschedule:
> +	schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +unlock:
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> +	up_read(&adev->reset_domain->sem);
>  }
>  
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> @@ -136,7 +150,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +		cancel_delayed_work(&adev->jpeg.idle_work);
>  
>  	mutex_lock(&adev->jpeg.jpeg_pg_lock);
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 17db7264269e..d37f36d554df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -459,6 +459,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
>  	mutex_unlock(&adev->vcn.workload_profile_mutex);
>  }
>  
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> +{
> +	/* The idle worker may be waiting for the reset writer to release sem. */
> +	if (amdgpu_in_reset(vcn_inst->adev))
> +		cancel_delayed_work(&vcn_inst->idle_work);
> +	else
> +		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_vcn_inst *vcn_inst =
> @@ -466,10 +475,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  	struct amdgpu_device *adev = vcn_inst->adev;
>  	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>  	unsigned int i = vcn_inst->inst, j;
> +	bool idle = false;
>  
>  	if (adev->vcn.harvest_config & (1 << i))
>  		return;
>  
> +	down_read(&adev->reset_domain->sem);
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	/* Check submissions before fences, while excluding a new begin_use. */
> +	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
> +		goto unlock;
> +
>  	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>  		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>  
> @@ -490,15 +506,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>  	fences += fence[i];
>  
> -	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		mutex_lock(&vcn_inst->vcn_pg_lock);
> +	idle = !fences;
> +	if (idle)
>  		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
> -		amdgpu_vcn_put_profile(adev);
>  
> -	} else {
> +unlock:
> +	mutex_unlock(&vcn_inst->vcn_pg_lock);
> +	if (idle)
> +		amdgpu_vcn_put_profile(adev);
> +	else
>  		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> -	}
> +	up_read(&adev->reset_domain->sem);
>  }
>  
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> @@ -507,7 +525,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>  
>  	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +		cancel_delayed_work(&vcn_inst->idle_work);
>  
>  	mutex_lock(&vcn_inst->vcn_pg_lock);
>  	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..a6438950854e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>  
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>  				enum vcn_ring_type type, uint32_t vcn_instance);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..b048fd4b8b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..f6a9258ae3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..922711aa06a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..fe7ab9cb35bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..f4896ad9d1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..5a0132407a30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> @@ -883,4 +883,3 @@ const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block = {
>  	.rev = 5,
>  	.funcs = &jpeg_v4_0_5_ip_funcs,
>  };
> -
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..91968ad26f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..27116d1e9e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..7e068c2d4d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..16daeb61114c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..50378ee5a463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>  
> -	cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  	    (vinst->cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..3e85abd1e82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..5b47a643d725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..5aa09c3bd79b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..9693950cd16d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..0c189063a6ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..3fa553fb41d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..eb13f792e25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>  	}

