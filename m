Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E29106F2F3
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 08:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E9310EA29;
	Thu, 26 Mar 2026 08:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b+dSvJ01";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BDC10EA29
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 08:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgI/MWAglhqOvRCeCouXI+1rkmCW8X+3Uo/JQ184m72WwwOzq0LbKG9h4VgFyAoHEj+ZM/u9NTFolccVChKpeKRzB7A+aD0ts4eC2EB8nDRlDdfm4QNqZBHIqhVQSKzRf40aj0bP9SqFJVg5Efi6HmHnzlQROSe4HDr+YU4j4//E2rcav5Px3+WtH6msApKfSfGPAmxeDFRD0FbNrw/qrL8TOnpPzmVw/WBZ8WKBIX71VRnS4dDHRTACuF4VmGolINzxAmZVF8wL9Z5A4/yyHtObTNzMIx8FUd+th5BwlByjO26cIlTy3HPrUzNaDUJAF3/ezHpawZyBYNalv4FNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68dWni8gChwf/2gYKn4aU3e+zQD7+7Ag8e0OULp/H6s=;
 b=yzhfNF/vI3cmHAEmnk2tYxYbtZOO4Z+twj9/kLozT6pWEnzv4hZSz4yTxaWSYE8q9LKPf0a5UIkjYm7ArtVORHLiEZb6k157/c6egt5ExJ7xmZ/8BbI4C1/m7XWUmg1XJxiYK65T9mO6V/KEzBHqZUbTgZY6yxp+6Oh1jLNQrsZNOmQAK8NO83rKeZYlsPMBijirVITCVK51aTCeAJA4HyVX7TmOdlT+aHeyLpMSBLvTf5sKegyb8YS/H2nnoVxeP1KQ0mZTAIR20IicrKxIsK50iHkwor3Cnb9V5eCMSyxVc+ZZWJ9zs7gfKljW0H8DZoF6795pnJ6xFLMZ+Lii9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68dWni8gChwf/2gYKn4aU3e+zQD7+7Ag8e0OULp/H6s=;
 b=b+dSvJ011p8s+ODm3pWyQ4lePq25z0nERuxhWT0DOX8aCNWAeVBCVRLxWo1NVU/4/AN75MFWrO0msSYSgtPcggCVjwMhScKKV1lUEzfsL1d4H+QmWsMRl6drygFCeYODDbvIUyYFfes0U657kjE5hNmWIsHKtjmHBr6zaW1wBBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Thu, 26 Mar
 2026 08:14:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:14:01 +0000
Message-ID: <e85e3cae-7f40-41cf-be7e-e3d540ba8478@amd.com>
Date: Thu, 26 Mar 2026 09:13:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/vcn3: Prevent OOB reads when parsing dec
 msg
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
References: <20260325175135.3326685-1-benjamin.cheng@amd.com>
 <20260325175135.3326685-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260325175135.3326685-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f83d97a-f8e2-4280-5c43-08de8b0fa323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: zxa1kzOt5wzu2zGGW+IWTS0NUSsONqqDTvrXsFYfvtGDbnVD1o3plEhqW8Jrx7wcO8gNj747fm6qz4LeY3gynr4F1zSxp8JNPOb9Z3bp8VtxUn7xkKkWFVWXL/kXNz8O8XZE5fzXzBp4LgjtpokC1zWQntcVz8Oen0OtlAlxBmgw7qk/W3ZR6kSNogwA8XLdTrMJdSs/hw1Ixvfhl+OaqPIh5D1BtBacY3IaIOIU7uGAL9hk//626baUMhI5tkpG64UO/T5DbZ7IZroWEo7nGM7gLicHPidYRbej6NppRYT0vZIkP4p+22BkuqP5yYjol644y33eKP7QNE7EaGl/NUItNt0TcvotdhMYB3d1RgahQNz6e+/OajLJAyGEqwUeIdEqM+vrCH0bGJXZGeJFR+3e/Xheiij82AFdOOSsM0Mu5wdyqvMjUI7o6eeEUs0UzlrWYnNqI9PpE1C2s2fOLCjP6uLBvX9rsOZvi0J4nbp1JQo8ZQij1RSJOWmOlIcMnQmus5vMrpevudcATqXDNG50q9UIbT1bGrOKX7iLbtUEf+Bs9b5E0dtFf8ph3D+wDVhChu7+LHUnVeRJrYBMIwqw3w0I/0J23IDwo9RyNAmsAQcqveAXvOFyG5tP0mbxAQkIye+ZeistvSZzt0oH4kyMZNUgKRURyW2t1mGaTpC+KSIP4DydxBofJU2Dk36VmlCDbGBjU9mKqZawMB8kRyyFRFUgK4J5rEA73j3QsFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRsTXpNckNtZ0NCcEVUSHVIZUNxZnJQZVhxcG1vWHJBKytFNzZpZzNoTzgy?=
 =?utf-8?B?UXhLSGkzK2VQNEdiK2NPZ2Q5TnhmeTBUUzAvQXhkVnNqeUZJTmNXaGY3ZWlt?=
 =?utf-8?B?U0hzNFpLWXRTSVVFOHR5NlRXbjVPZWZJbVVaSDNsTVZoUkJLZ1N6RWxtR2lS?=
 =?utf-8?B?TUJNcmVkL2w3Q2RSWGtJc3ozNjEvdmlMczV6RlZ1a3ZNeFB5MEQ5Z0x2TnFw?=
 =?utf-8?B?cTJlQzR2cGoxeGUya3RaT0liYVJrcjEzbDFDaGt2aHZLelFQMHBUVVZyLzkv?=
 =?utf-8?B?MmtLV0kvRzg0RzJrdVhvbGVRazlDbzNUK2UxdzlWaVFtSWxvcjc2TWRlTU0v?=
 =?utf-8?B?LzZoejFrS1c4TzdGbzlOYlNFNEtnc2ZqbmlhdWc4cWpoT2dvV2ppZ3ZPQW80?=
 =?utf-8?B?a3BxdEh4eGNGNEt4bUl2QWdSWjRJZFFsdlBrREd2aXloOUxjd3ZOZHk3aFpO?=
 =?utf-8?B?REtGZUZKZjVGQ1JRTC8wZExYU3NUUlM3REpmR1VqNVpjbDdpMk1CaHpBdUZs?=
 =?utf-8?B?MG1mTGErK0VWNCtpZElTWXg0a3FLdGUxREZOUTFVT0U1M3RaNUIrbzlmWHJz?=
 =?utf-8?B?akxlNXZTVnZWSnNUOHZYWHptdHBtbzdaS2NVQVc0S3gzamowRzBwNmtDRHFZ?=
 =?utf-8?B?T1dueVRJaGp2UXJ2VjFoMnRvZFJXbjg4VnQzTTNKcVVnTVZCVXFZSjRIMjVT?=
 =?utf-8?B?NW9mazljOHoxUU82dUNJcnZycjVLOG1Qd2NYMjMwUkpnS0lVakwvclIwWVZ5?=
 =?utf-8?B?VHk4RXJrckt6T09aeFgydk9hdDJXQXlJVXBtOExnZjZLRWhVRmdTTDg3bFNT?=
 =?utf-8?B?Z1F0ei85MlI2MDlYSk90bjVvdGlyaE5xWEFDKzJYWEJ5a0J2ZGhXMVRoc2dM?=
 =?utf-8?B?aDBYcFFNK29jVkxNVHo5bzQ2a3k4bFRyWU9tUlppVkk4T29udUNNSGpjV0c1?=
 =?utf-8?B?OVNwT0gxaDRHOWhTOWNjL3cySUt3UzgwRXhLVmFVeWNsQUFLNE81aTF5ekNm?=
 =?utf-8?B?UTlRdHpMQzI2VzcrNXBHNjJiZmdJa3VNMGhXZFVheGthaXFBRk1qb1ZoemU5?=
 =?utf-8?B?eU43V0ZHZDlzNHEzRS8wYlBBUG1IR1czT3pERHRNNExIemZobFl4TUxSOW5L?=
 =?utf-8?B?QnI0SjlHb2czMVQwc1dzK1BKY2pXcEx6aFNNSWVjSE5JcFdvczdXU1VXeTFq?=
 =?utf-8?B?MVNYTDNFdUh1dVRBVWdXVU1TdXA3YlhUaVZGU1pwcFh1M3F1clRLbmRJd1pa?=
 =?utf-8?B?cXR5R0JHWjZteG1jaHIySkdKNFBjaExWZ2NveVh0TUZsVG54QkY4elRYSHUr?=
 =?utf-8?B?YWgveng5NWh4RVlMUFpvc0lleUI2eDFJSWlsNlJ5SVloVURRVlRKSml2ZDE4?=
 =?utf-8?B?UVl3OXBXSmttQkJEOXBndWY0b3hWckcwRWlkOVptRjlmVm0yMkJ5OWtxY0ky?=
 =?utf-8?B?UGhYaGtHZ0tkdXlLRzNCZVB0a2l5Y01WWFR0SklYTVA3Ym1tQVA4Um94c1BC?=
 =?utf-8?B?NFZMcVp3anlDRytvQnM0emEyRGVKb2pEYll4SXZ3Y3pkZHVYWmprYVBNcVRX?=
 =?utf-8?B?OWZyV2kwMlhjME02OW0wL1lrWkU0SEgxUmFzSXRJL01TMFBlQTNmaExxc0Jv?=
 =?utf-8?B?U3Y5U1p4SmhlZXJHdkZJdFY0OTNyazJvc1hPWDNSV0x0VmtXWFZQSURKRHQr?=
 =?utf-8?B?dUpBZ2tleFozQnY0d2JaKy9Qb1ZZOG10NzFBa1puSmVGMWUreEZFZ1VpTUxs?=
 =?utf-8?B?R2RXenNsNGZHalRUUWV0c0psNlJ4ckpoYXNUaXJJbHp0cHRIMG81b1Z3dml5?=
 =?utf-8?B?TGE1djgzL1RoZkZ0QnRPT0NOSFhaOVBrejdqMnZZbDFLR2xGcTlDVFlMZkZt?=
 =?utf-8?B?Rm9zSFlMc1VRajJGQ2VkWmczWk1KT3VJTFJodm5ldStoVTdNaDJmOWRnWldT?=
 =?utf-8?B?a280NnZFTTZ4WTN5b3o0QWd4MUpQUktXL3NQUkhVQzB1eTErVHRMVDA2VXdB?=
 =?utf-8?B?OFdaTDlTeDcrenBTRFpxN1NaSHZYT2t5MFdST2gxSTFUZGliUTFyME5rcERM?=
 =?utf-8?B?MjVXTTFTNjc5QmdMZVU2U0doYXJSK3ZJRVdlZStYLzNOcVBlUUprcjJvZVp3?=
 =?utf-8?B?Njc2RWdqMXptZGlKdUx0NFVBN3lTU1hUZEIyYk9Wamk0MCtjZXlQM04yR2hE?=
 =?utf-8?B?eVlEaG5zTWU3RWUrVGNnN0JPZlZ3THRUOXhrZW5UZjJqOTRhNWhrQ2tXMHNL?=
 =?utf-8?B?czJyYlQ0SlVVakJTMENrSk00SmdiUGNyblUrem1SM3p0djZHRG9relViQ0ZD?=
 =?utf-8?Q?heMPDG7tRK7cBoXMjo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f83d97a-f8e2-4280-5c43-08de8b0fa323
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:14:01.2826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28lBBSNwiV/6LEq9N+IQuA2jcY0Jn7v9LP9ohAOGwX19HqrXGNEIEmw6zB9nJ3S2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7
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



On 3/25/26 18:51, Benjamin Cheng wrote:
> Check bounds against the end of the BO whenever we access the msg.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 02d5c5af65f2..500a337e8987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1909,7 +1909,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  	struct ttm_operation_ctx ctx = { false, false };
>  	struct amdgpu_device *adev = p->adev;
>  	struct amdgpu_bo_va_mapping *map;
> -	uint32_t *msg, num_buffers;
> +	uint32_t *msg, num_buffers, len_dw;
>  	struct amdgpu_bo *bo;
>  	uint64_t start, end;
>  	unsigned int i;
> @@ -1946,6 +1946,12 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  
>  	msg = ptr + addr - start;
>  
> +	/* Make sure there's at least 4 DWORDs accessible */
> +	if (end - addr < 16) {
> +		r = -EINVAL;
> +		goto out;
> +	}
> +

That check should come much earlier, directly after we calculated end.

Apart from that looks good to me.

Regards,
Christian.

>  	/* Check length */
>  	if (msg[1] > end - addr) {
>  		r = -EINVAL;
> @@ -1955,7 +1961,15 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  	if (msg[3] != RDECODE_MSG_CREATE)
>  		goto out;
>  
> +	len_dw = msg[1] / 4;
>  	num_buffers = msg[2];
> +
> +	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
> +	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
>  	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
>  		uint32_t offset, size, *create;
>  
> @@ -1965,14 +1979,14 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  		offset = msg[1];
>  		size = msg[2];
>  
> -		if (offset + size > end) {
> +		if (size < 4 || offset + size > end - addr) {
>  			r = -EINVAL;
>  			goto out;
>  		}
>  
>  		create = ptr + addr + offset - start;
>  
> -		/* H246, HEVC and VP9 can run on any instance */
> +		/* H264, HEVC and VP9 can run on any instance */
>  		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
>  			continue;
>  

