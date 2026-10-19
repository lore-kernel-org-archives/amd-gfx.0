Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7901606A319
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AAwyuYcI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D62910E0D1;
	Mon, 19 Oct 2026 20:55:28 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2E710E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHc2TOSnbQQQZ702STWieXtL9/iTc6gx1Tkdd9EYmwpU2O3IfyUQ+2uS8IYYgCQAfqdeA1LXgNW+NML/f8Cg7ft9lW9XEI7X6ATldDN+em3fMRSj71qvQX49K90pwYJEfrkamkbtbVieSE+Pi2QEftQO5bNTbw7zlNc/IUDco63/z5F34xLXPeap9JksqCn0hCXrykQqrP2zpfE0y3n8cvgCbfT3VJ2uC71Bhd0cCr0CVzO/rvrtDHlTih5sdwVVGVvaTZS6nWCkeXm17XLqw0Ki5AJRVioPHM3Pvqg5VltI9/uMy+KMnNIWyIgA7eyQCtGCmm2jpjPHUpeB6muJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZnkU/uJFcpSdPOzBQVdO7pkBc7Y+VevwqcvDbt3mek=;
 b=KqfKQZOirYTi/7Ga836WmDr9fPxQfeLzQ7BpUD5Wu6+S/8cQlSopBbEmcxvJVShV0t8K3SjIkv6Je7VJxTK3mY7x6ov/hfHk+RqPQiQCpHUY9rU5/3qsjSoyO2zVtuXdKPj5x0ywdnbeivuSCMBFTuK+FqEUKR/Ja3zOd886pftl7qHVgFbDc4S7EHuFKSaNr8AokD89C/EOY4hwOl3c8WShfVZTeML7BRAoIOawKsZYt7i0K6bp0gBZW4hxPmMrckC30aYleVppy1Dx3sDGo62FswdQKhzFGuVRXA3ylCxF6g6/YYy8BJz/cUSkS1VONKBZf79SMPcf3y7DvMa8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZnkU/uJFcpSdPOzBQVdO7pkBc7Y+VevwqcvDbt3mek=;
 b=AAwyuYcIeUmiu/hk4LVQ/0RS7c3S5nm4udEml1NDv8DUKnAazelGgA6Oi46LnZvqfJlYC7hbTuKlJBoLikRBK8CEZLp4e1EOtmjMwHXKXDzhwm6o/P6NoA/eJeD77g31j9q8p7SzxAYVd4Q2chwzwG9MIT1XhSC0i63/PXHt/40=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) by
 PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 20:55:19 +0000
Received: from DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8]) by DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:55:18 +0000
Content-Type: multipart/alternative;
 boundary="------------C3zrPXIAL57EArcVScYH11H8"
Message-ID: <7702c525-116d-4ec5-ab55-a93a0a8fd379@amd.com>
Date: Mon, 19 Oct 2026 16:55:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu/jpeg_v4_0_3: set only IB_RD_VMID to 0
To: amd-gfx@lists.freedesktop.org
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
 <20261019200726.15262-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20261019200726.15262-3-benjamin.cheng@amd.com>
X-ClientProxiedBy: YQZPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::10) To DM4PR12MB6278.namprd12.prod.outlook.com
 (2603:10b6:8:a4::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6278:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 644b5148-91d6-46bc-467d-08df2e23489a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|8096899003|6133799003;
X-Microsoft-Antispam-Message-Info: 8yRrio6Ab7JAOE6/qncz3iTAhuKUFYstK55dezIf2DK5QgMZwWao3D/nvCJv3o6mAPp0IyqRQy2zfGv1JD0nFkCFB4ZfCs8s37pvDfhSfKehrfa4GRERJ09S9nTs3qQrIAl3TmMRTM3l4wtP39EHgC2wM9g0cHPjlHFvyv2s0cTxM61//aok33mDpB2lonaPgTWFwixFmYZDkAEiOpqByiFcMkDnVbjtqbELf/S02Non8Aslbq7NO160orMKEg4x1e2uJ9mKre0myhz/q7MYFiGekDqUko8M72vNBBUUcYhvm3ryQ49uFpBzl3XjCDvOGhtSMiCcVrgkg+K4urJH+kPT+CjmUCgaAMW/n3C9h92IhzhmAGtKDmCsWEQN3ZObt1SiRIFBjCLTsvWqxFW3gWWySiG+SCunYYPeW7Y4eMYup7GautrQmHW+6l+dU+mXQohdw3Nv+USuVwJMVkB0S8M0ld5ND0RsJxEiAJyVEh175o044hRrnjzGhaxIu14ozF2kvJY1qkP01o2YKZYFRkZdI3mNXhu7SvpN5NIYmmjRrPV7Wn9DoSgTOWLuDquTVFUiKcupgaWQ1jnseuhQn+2Sf5/tpcmJD/nxFg/eVhjUDb603Fk9yLmfGI1unhoAjqP4+DxLc9KFLO+8hEErg/6G2KAbLQP36AT9lfxwi+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(8096899003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhrSDBFMGhmZmp0L2g3TlpYV3ZkcFN5aGkrQnFtMEhwTzlWWmp4RkRoN1Q4?=
 =?utf-8?B?Wk9WR0NqNTZVbHFOYVFJR1BkbmlObzRQV2t1Snlxa3hCRWZLZERLa0prblBz?=
 =?utf-8?B?QzBOY00rUkw3WWxTTTcrS0s1SWdaRWJNc1RzWk1DUDNOcU1Zcm8zZmRXVnRx?=
 =?utf-8?B?aktCbmtoVnNlR2E3Q1daaHVwYXlEclBIcUdSb2ppR1VWdFJLRUNrQTBsSGpC?=
 =?utf-8?B?akhoajhJMVVaUWRhTDlHK2U1Nm9OQ0Q4blB0Mkg3aVQ5eWVmemU1M29nZXhq?=
 =?utf-8?B?VXg4MTlIdHRXR0pibWg2ZXNIcDdGOEpybmVRc25zZGhYN21DWmJQNEpWclRJ?=
 =?utf-8?B?TDd4U0tCOTE4RXlXSzg5ZFpsSW03Mmh4Q1Z2Y1lCR3ErdHRSRkw3enkydHBu?=
 =?utf-8?B?akFjQmNwb0Q4aWs5QTBVQnEyeklJTDVrbGdCU3lVSktBeVYvRHQ1R01pSkJ3?=
 =?utf-8?B?K0IrbEJta3p4aW5iZ2pvSFhvNXNIbkFoTGNCdWwxRWZBRm9RUUVOanV1eDVE?=
 =?utf-8?B?TG5FMnZ2TXhpRWtueE1KM1ZpaGZSeTNiSmZnd1U3UGR2RWE0MUd3YUNLcStL?=
 =?utf-8?B?QlVmS2JWVDlvY3VtTzZTT2lLU0xnTTJFUTNRZGJpRTZldDNFOW0rR1E1V1FO?=
 =?utf-8?B?UGQ1V1NOM2thbmpEVDdqREZmcUxZQy9oMFcxdUgzYk0zZTE2eGs5ckRxbzVP?=
 =?utf-8?B?YStqb0lFVkRmTzdNSWdTTW5QZFl0ZSswR3hFaFBRRWlaZWdPMVNoM3ExQk4z?=
 =?utf-8?B?SFdvbldWK0F2bDNQQVp4bjJtMUdPTlcxd1F6Tllpa0tIU2pkeUFVYnRYNDE4?=
 =?utf-8?B?Wno5c3RaSHJtZXNKaWJTUDlFMk0rMkVHbUZPdEhFVzhXYWF1R3JrZHlwS3pL?=
 =?utf-8?B?SDZpM3RSb00yUmdycGx2N2NteHBPZUUzU1FiS1VpWXdudm9EYk9YbkxTY1U3?=
 =?utf-8?B?em5ZWUFCTWdXd2N4RGxwUFU3Yk1nb3FLc1pQY1JiVXdGdnZXU2ZpNHpGYndD?=
 =?utf-8?B?ZHljSmpjNkZLY0o2anNtbmhDZWJhKzllQnFXRWdLT2RpYzNmTG1DVGdKSXpZ?=
 =?utf-8?B?WWl3OXZ1OG1hOSszc3E0R290My9QYkZ1MjhSR1hJVzQ3UFdZeXQ3UkVlMG1v?=
 =?utf-8?B?ZFkrMnJxYUs3cjlZSWJycmtVSVdKYzkzRkhScHFhbUlzV0ovN3k3aHNndnZH?=
 =?utf-8?B?Q1NldFFPRlJ2bThNamVkUmxCb2FubWJyWEIzakc2NkhWclhSNTRWUHFkZkYy?=
 =?utf-8?B?RWQ4eS9mSUpyTzZZNElRTUswdnpMc3B2cS9BTmlONk11Vkc2NFQ1NlNPN3Nw?=
 =?utf-8?B?ajROMWVkRU05SFBwTW5IaXhzV1hYeDE0NHRRRStqSnY2OHNxTGUrdTBpSVJk?=
 =?utf-8?B?Z3d0TUtJaDRHZFBTR2FGRTRiUmZiRXZ4SXo5bGd3TXQ0Vmt3QzE3MDA2L1lW?=
 =?utf-8?B?L0dUVG9leTF5Q21aNzFscHFWMFFEU05ScG9WSWZibStRUEg4R1lpTXh5am1S?=
 =?utf-8?B?eGMxYjFzZGdUL3pOdmdMNm9DaElLWXVPWGNPUHhoUEIzSEVvdmVrZjB6YmV4?=
 =?utf-8?B?NjlDTTBUZFNKNzJSMWpnNHU1L2Vrc2FPSlZzN3ZzWXhsTmFCUFd1MFVqZkZr?=
 =?utf-8?B?MkJ2cGlzM1RocGRIYzFvaXA4aURRaDQzVGd3eEQ0Wlk0b2hCK1lNM0o3ei8y?=
 =?utf-8?B?VWJ1V3ExUjBDbEdSRWxpVEw4cXVRZFNkMS9QKzRmdnVMd1lQcmVvZ2hFRTd2?=
 =?utf-8?B?S1dmSzdxSDRlTHNkbkN3QmFOVm92UGxWVkRCUmZNbTJLWXJranJ2bVFqZnA2?=
 =?utf-8?B?Z3FhRStYc2Z3N2FkN1FHMy9ueGtyVTVBaFdSZ3JMQUhqeitoRThxRnpLaXgx?=
 =?utf-8?B?Njd0U0hNSkwzc2VlWlZYenpUYVozc3pJYWNCTG9XNEJ5Y05lZWltNmw2cWlz?=
 =?utf-8?B?N1dXZFRyNGxRdGxubXBKUHBrVm1RckRObkx0dFlxQVBkTmJwR2tjbGQ4T0J2?=
 =?utf-8?B?YzhYbjEveDlqNHBITDA1V1ZVLzRienJOdHNPSnN3TW5NQmxvUG90TlAzR1hj?=
 =?utf-8?B?RlVEcExzMFMrODRyYjZPRCtSQmVwa1M0eE9wcXAxY1IyeE9GYUVtSlZiWXZZ?=
 =?utf-8?B?emo2b2VRRW41VTNCaGpiWW45QVFXb2RlUW8zRy9YNWU0VlYxVW5JQ21GUE5k?=
 =?utf-8?B?S1VLbFdENHVSR2J3TFp2WXB0UVZFUDAwOWE0elJ0UmFJQXlWWGhnL1BKMExh?=
 =?utf-8?B?NFN5LzNGbUd4Y2VwS1hYUGFHazVlWTQ4cEpLNlNNRHBlTkpLZjJuQ3FkWGJy?=
 =?utf-8?B?YnFVUHQ1UHMwVGlLWXJiUDRCNVpDZ3BhQjgrUmNqQ1NINVdJeXcxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644b5148-91d6-46bc-467d-08df2e23489a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:55:18.8486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifq1H3TvAK7hWaBWlI9/k7URX80ELeBEnv2hR/1rhUyehsQZabV+dwqfA/OdnQ1S+ysOnPHAAmFdALfDMTOnNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
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
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------C3zrPXIAL57EArcVScYH11H8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-19 16:07, Benjamin Cheng wrote:

> If IB parsing is done by kernel, the IB will need to be read from VMID 0.
> However, memory read/write operations from within the IB should stay in
> the job's VMID. This will allow us to enable packet type 4.
>
> Signed-off-by: Benjamin Cheng<benjamin.cheng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..0c25ee443fa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -892,18 +892,15 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>   				uint32_t flags)
>   {
>   	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
> +	uint32_t reg;
>   
> +	reg = (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_WR_VMID_MASK) |
> +	      (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__MEM_RD_VMID__SHIFT);
> +	if (!ring->funcs->parse_cs)
> +		reg |= (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
>   	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
> -
> -	if (ring->funcs->parse_cs)
> -		amdgpu_ring_write(ring, 0);
> -	else
> -		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
> -
> -	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
> -		0, 0, PACKETJ_TYPE0));
is this removal of regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET intended?
> -	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
> +	amdgpu_ring_write(ring, reg);
>   
>   	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
--------------C3zrPXIAL57EArcVScYH11H8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 2026-10-19 16:07, Benjamin Cheng wrote:</p>
    <blockquote type="cite" cite="mid:20261019200726.15262-3-benjamin.cheng@amd.com">
      <pre wrap="" class="moz-quote-pre">If IB parsing is done by kernel, the IB will need to be read from VMID 0.
However, memory read/write operations from within the IB should stay in
the job's VMID. This will allow us to enable packet type 4.

Signed-off-by: Benjamin Cheng <a class="moz-txt-link-rfc2396E" href="mailto:benjamin.cheng@amd.com">&lt;benjamin.cheng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..0c25ee443fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -892,18 +892,15 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 				uint32_t flags)
 {
 	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
+	uint32_t reg;
 
+	reg = (vmid &lt;&lt; UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_WR_VMID_MASK) |
+	      (vmid &lt;&lt; UVD_JMI0_UVD_LMI_JRBC_IB_VMID__MEM_RD_VMID__SHIFT);
+	if (!ring-&gt;funcs-&gt;parse_cs)
+		reg |= (vmid &lt;&lt; UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-
-	if (ring-&gt;funcs-&gt;parse_cs)
-		amdgpu_ring_write(ring, 0);
-	else
-		amdgpu_ring_write(ring, (vmid | (vmid &lt;&lt; 4) | (vmid &lt;&lt; 8)));
-
-	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
-		0, 0, PACKETJ_TYPE0));</pre>
    </blockquote>
    is this removal of&nbsp;<span style="white-space: pre-wrap">regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET</span>&nbsp;intended?
    <blockquote type="cite" cite="mid:20261019200726.15262-3-benjamin.cheng@amd.com">
      <pre wrap="" class="moz-quote-pre">
-	amdgpu_ring_write(ring, (vmid | (vmid &lt;&lt; 4) | (vmid &lt;&lt; 8)));
+	amdgpu_ring_write(ring, reg);
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
</pre>
    </blockquote>
  </body>
</html>

--------------C3zrPXIAL57EArcVScYH11H8--
