Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654EB106F2EA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 08:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D7210EA42;
	Thu, 26 Mar 2026 08:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZBk87Oi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C819010EA39
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 08:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC1jfvSISgYsTfs0LN+rGiF70pWRsZskOZKaEyP6J2XoKhe+MMRtHsax6inX8l5XNVTlFjmSG5GuQzslfUd4h7SpNVWR4vA5avsU+HM/LZBNakw66gdDlSZtnP4SiWijRBVdePm2ZMrL7/f0Ffyw1XBdoJb7nwuKIbkodaHvHYzVnCBBWOVp3TYZR5MR4zAmqAhH7HvNK9N7bEUjjE3G6TdQDtqE7xnKpKX4ek+XFscb0CoNqsoOonlOg1xamaxjWoRHZt2y14n5v13rEbamrNX1PPzAk+cxLmfoNYgrugg0++mojd8h+4UHWcZwiiozWakm3rvk3c0Rc99CGEJa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TevYgI1MjRZV9elBinpWQRc3yTrKjsezn+lpE5IBnE8=;
 b=LGVY6Tvs0doRswxIV3Z3FEnLT0O4E6M4He5IT/n+MtXjHVZ0BqzlvbcXrVsJIX0LIjRn67rN3K1B/IHSpqZLAoa5Nlt04U/8wICFDSq9Y+uFIP/i+9/pbpTEFqmDGeBbSGeerKW46LzjV/veNsBLAZYwcsQYF4OZaDnep9iJfDZz6iMJOx0C6zPhZ1jOqyYpMnOtjO0fSDa/7AF4qBurO4AHzIHDp0gQvpALCrVTDC6WggrFR95Iwhi/HxRcwjUjka3LzCP4YhRuIZFflgRILVtqzYu/QJoI/jJzDBLoDqi8EZzMGRE7NOKjF9rIRRWK9a0r+i7M19V/davRokgMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TevYgI1MjRZV9elBinpWQRc3yTrKjsezn+lpE5IBnE8=;
 b=IZBk87OiaKlMkZYxjt07aL+o2t2Nhtg1OHqFKPD5Imk4sIWGean2e9/LD9hYd7NeuMEdO2aqR40Wx3G94pHTiyYwbaqbY5wlXVuzeWfA/launeooTP64pzNDK9HFcQ1yeqBdqyOHH3HFiaGM5OHBP19thQjkKmbg2oIYjyp6XqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 08:16:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:16:23 +0000
Message-ID: <9abdf60f-1ccd-4c00-8cf5-0fac6db1822c@amd.com>
Date: Thu, 26 Mar 2026 09:16:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
References: <20260325175135.3326685-1-benjamin.cheng@amd.com>
 <20260325175135.3326685-4-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260325175135.3326685-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 130616f9-5eb8-4d15-d07d-08de8b0ff800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0KkbOu4GejPPlVbYyGp3Oim7ayGFM7FnaxFfbu/Ny6AGWkFPNhAzm3Zn45Bbut495RyC446U/6FR8/j1Byr46FpA3HWYCfGA6KtTQnUD2S/I6ud/H2NvQDOoX5QAJxALlEe4u54GuMKmbT+sDpTMqRGB3BPO/d8Hwnz7upPZTmgXu54dSQGtw6gg5UZMIxjW/8O/RvpkSmltDIt+ICO5mjOn/04vt5KhUVhkcgduZse8+KTXJNmGnrqWwR4gqvIxZk7PHKF/P1tN8XZ1Sj6xk8SCC/rm1SQSRo3V6hbi/NH9VFng5e8bidJExHAlVkJI/l9XJV9VoahjZonShU2XqRO2nJrAe5c1cekEfl/QxcjQBZedDMnG9bsyj8AHiFhpL7gGpGQJROeTWB+fIAypti/p8ryW7/4hk6WUR2CN5HKGfIRjHc/iRhUOKTpkMxC7hx7u/e6Z/gv1/15qBIjF7005ixasWnxxPpx4SKG0RTeW6JE0Cd0B5ZAauhrP4OnyM1wUYo9HpxyuDOfKyORvIyxWEbafwm8GxJcgGGu8snvdWdtVtNIqa9fJY41vr83gymOYSQucE5DmwXRewdlNrKkh1ykckbKpJwE38gtZtiMzJOnONVD9c05Y9Ds0nk3Fjg0VjNBmFIDJI0KUxMCYaRoZRItIzCwoUdNyqQ0LO7/DflACmFVGyPVn1oBB4yO5PZAB1dvyx6J/R9x0NDvgOKNgmyM35t6X2GesRNgiBAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnc0VWRHRjRUMmlPeFdqdHZKS0VLZWVpNm0wUWsraXkzMU90WjNjd3Q2aUpu?=
 =?utf-8?B?SEVkbCsxcXp1bmZNRUplVzlsSTFJTG85SDZVOHZwSGZhYXM2akZpQlJ1K3Iv?=
 =?utf-8?B?THo4VjVMb2NBcFBzR2J4VUVvcVYzbUVBdDVjRTJJZWU3d2FyMjJVKzE3TWhI?=
 =?utf-8?B?QmpoL0hWemxnRlFWTm9JbzU3dVVwRTdrNDVKRFQ0MFA5L2I1Z0pWanVkY2l5?=
 =?utf-8?B?dncvY1dYTmE3VUF3TjBmb3Rxdmw5M1pqSitXejRuTWdTUmhiOE5iVUNEaWdX?=
 =?utf-8?B?c3VwZXczV1JqWCs1OEkya1gwZW5QMTVaMGkvdWxNZVhlNlQ0ZFpSazhpQ0tD?=
 =?utf-8?B?eW5tbExqbHE0RmtIeXpFWlBwZGtmb3BVY3l3U1FQKzMrYUNyMlQwRXJnVnpQ?=
 =?utf-8?B?eEJtRFdGY3ExZVBCdXJJYXl6SXFMdkxnLzFlVWdCYXNRcDVtL3psTlBYL2Z0?=
 =?utf-8?B?UHBhSm14V1N6NFpvVk1ydEphUXhDWjQxNUREdTFWZ3RaajVpU0V2cmp1UndX?=
 =?utf-8?B?OGdxOVJzNnh5L3FxZnFBTmlVY0ZOVDJWTGhsY05aR2x0TkZGVUNjL0NPTjZI?=
 =?utf-8?B?WXpUdVBQNUNJWG9SazlHRTRGeG5tNlV5WVpiT1ZjZ0ZaYXZtbkxvc1ZOTm5L?=
 =?utf-8?B?R0ltdFNobksrbTkvVjhxdG5Fazdxem9qUFVrdDQ0WDdnYlVSMHF1TEtQMFFz?=
 =?utf-8?B?cEVoRmdVMDg2bGdWd0RZT1NGSkttS25nSHZPL2I2QlF4bFM3RGdnYTBiSjR6?=
 =?utf-8?B?SVpwb1dudXZ1RTFYN2xCd05leThmZWp0aG9nQkFkQVd0NXZYSjAxU2R2QnJD?=
 =?utf-8?B?bWsyeGE0cGtyMkhoRHZHckZZQk5BLytMUWNKclBuQWxUYnhoZW9jVXhabUo5?=
 =?utf-8?B?RjRrZDFwWmlPNzUrb3VLVktXaS9CNEhoTHF4YSs4YktlU0xFV3EzcHBQM3NR?=
 =?utf-8?B?VmthNFJnb0JWL1VKdXRRdjdycytFSFBTOTlHMUc4OW41V0pJZENjQk9idGxR?=
 =?utf-8?B?SXBqeFRNR2pSK1dqY2FjSnhYZTJBOXlZRmp1TzQ2clVjbXMwZVJubHpsTTJ6?=
 =?utf-8?B?ZzVVaGRUYnpYU1hQT3R3Y01vV0szNVQ3NmhXSDBNNGVpa21rZHEvYXZ0Z3lC?=
 =?utf-8?B?bVF0cGRDK0lxQ0xobXR5Y2JSTFdJNy83OURJMGlVNVVPL1RGMWxZZFFIcURL?=
 =?utf-8?B?UUcvZjE3NldhMStIZjJPMjJQNlFXZmtFWVZIeUtMdTl1RnJDZ0F2SDdHYVZo?=
 =?utf-8?B?K2NPeWMzUW5KWCtNUFpBbkhXQlY0OWF3SXlYKzczeWJpK0o3NzZhRTFCT2NP?=
 =?utf-8?B?Zjc5aFJzTm5ialE3bHVrVE1YSDd2dk5mMDZ4N2JXK0U0cUNzeDVwZHQ4dUFH?=
 =?utf-8?B?NnM4UjF2T3QvcXRnVWtRMUxkVG9PZTM3ZHloOG5BQ0FuUXRULzQyc3pmUTFH?=
 =?utf-8?B?Tms5Z3ZMRDVYUC9XRlZ2cGhOZ3RNRTduMDIzQllsV1hkbWV0VlJaK2dqb1lN?=
 =?utf-8?B?a3lkWHl0QkcwWXBmWHdlblI2b0QwRFM2ZmtZK2dkUHhEQldudCt2TVdNVkNm?=
 =?utf-8?B?aGFCY0pzUVQrN2R5d2MvaERNOU1nWDNGS1ZyOElJUmdnNlFXb2NoRU5aUzhY?=
 =?utf-8?B?MW1wbU1FTVhZWWJ1NU5Zd0lkZTE2V2tHNDZ1aW9Rd3Y2ZWdpL205M3E1UXdn?=
 =?utf-8?B?U2FKN3pyc0pTeGJkcTVjak04ay9rNmVxQWxLYnZUQUtidWlzZjBKWnhtanp5?=
 =?utf-8?B?bGJQUlpuMm1KMFRKanJPSzJ0RmNCb2xRMTNVSHlhZ2o4alVXVXE5SFBEUXFj?=
 =?utf-8?B?K1ZRQzZVNlArZURhRWlCN09DUmNtNzJoWjd4TjhNZnFGTkN0eldld3JGQW1Y?=
 =?utf-8?B?SmhVeWljQnJRUFRmSkdLOEhiSERUTWlNQWM4T2VJVnQzemZwWGdzUWpTSzhZ?=
 =?utf-8?B?RW0xQWpqVG96K045ZzhXQ0oybkw1dWQzQnRQNHpndDd4OHh6WFByeHhYRnZt?=
 =?utf-8?B?VElFU0V1a0U5QmdONkZHOEVPTWxvQTVKYVBXVmU3eU1YU3FTcnZad1RJREM5?=
 =?utf-8?B?d2xTb3pEazcxaGFlV3VoWHU1dUhFeGpCb0pzVVdFS3NRSkRtUGlLN1hKZ3Jk?=
 =?utf-8?B?alV1Z25WcVNTa1ZzRFlZM2VGb3htMVpyUUZMYUZKenAxdGRKVmQ1eWFXS1Vs?=
 =?utf-8?B?S004VHgyTmFzcmIxQ1hlZDl2NmovRStFWjlQTG83cGF3NXozUUlybG0xMmFW?=
 =?utf-8?B?SHVNNVJTZSszMDlDN081OHpCdG9JaCtLUWFwNVdTVStGZitMVE1GRHN1OGNI?=
 =?utf-8?Q?q07WYosUht4CE/Z9mA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130616f9-5eb8-4d15-d07d-08de8b0ff800
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:16:23.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZwzD7ZlPPTjqVUCgwyNng7IO6ra8OQkjOawUkddH5B5norNfEAQRvz16qiMhp+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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
> The code accesses the IB without using amdgpu_ib_get_value() so we need
> some additional bounds checks.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index f0f492777b09..1485d92800be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1928,7 +1928,7 @@ static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int sta
>  {
>  	int i;
>  
> -	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
> +	for (i = start; i + 1 < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
>  		if (ib->ptr[i + 1] == id)
>  			return i;
>  	}
> @@ -1952,6 +1952,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
>  		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
>  		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
> +			if (idx + 6 + sizeof(struct amdgpu_vcn_decode_buffer) / 4 > ib->length_dw)
> +				return -EINVAL;
> +
>  			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];

We should probably rather stop using the struct here and directly use amdgpu_ib_get_value() here.

Regards,
Christian.

>  
>  			if (!(decode_buffer->valid_buf_flag & 0x1))
> @@ -1962,6 +1965,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  			return vcn_v4_0_dec_msg(p, job, addr);
>  		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
>  			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
> +			if (sidx >= 0 && sidx + 2 >= ib->length_dw)
> +				return -EINVAL;
> +
>  			if (sidx >= 0 && ib->ptr[sidx + 2] == RENCODE_ENCODE_STANDARD_AV1)
>  				return vcn_v4_0_limit_sched(p, job);
>  		}

