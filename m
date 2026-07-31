Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF33C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 20:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D736E10E25C;
	Fri, 31 Jul 2026 20:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nbd0sPSP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E64410E25C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 20:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujClNbIENTJwRNGEo2OdzlWzHbRDuSgh+qmmIIp4lxnBD92g7oQhlos4AKgCD9+CiZs+YC6eQMxZWcvy8IZC9jSt4H4ni1hPWcBG47SrOF5tugSZu0Z35OCIWTqtumbcUgXWwnhR8PnvVPO17BdP00SwhVKlHavz/I+WWLGjD+W8EFY7XnNZ9sAeFR8OejEdzhXBmqBCksKQ3TTtBe1MXHxWvdb5jjyLnh7jwc5pD5Bz+pAeaU5XPoBOQ1fvUFRwdKbMvrL/1/QuXQhlXXHEi/Q+iCNPUxwfIhjHqXLrnDoHW0I0OVYWS5DSnVqkSYW4rWwwTYUPws9dQ54zfXwXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bf5FOowmvLDPQGxH4JoqhlDGkxdjlhngPVTtbauvGU=;
 b=vJaAHAWJaSwg5NVYnvhOGrj4ZXkKYniDukCgw0TSIWM2wPzyGsG9U3xyW6FkJb10M4WgY/27f1+yvX0HXZ98RFb1FMDoBes9Lluwz7LZOB2dHIS9p85CQ14vFXY/7H4KQ3OrwaUtQ5V62JXUV3XcqCCXcjnTmxPsaX8CGEAtjsartxomr7a7/Fn2uLFuPIeJKmQTprUv1F8Z/M8jDNeRub84qLm7AM3mHvyy7hq4jZk44duqGYpvjyBmKBe+DvL3cvHSW02r+mql3XzzG7PR14Ax1DEU9kfWrfzu2brSq5S5OIfcdYmXtvnM5uBHAB+I2x2hhQBIDWdm2fmFk7JvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bf5FOowmvLDPQGxH4JoqhlDGkxdjlhngPVTtbauvGU=;
 b=Nbd0sPSP/u1O2x1UFs/CB1tM36BTYShMr3tA8UVMZTS4qSRVDcqcJjZE9MnTbzjaugkGbXC3Uzyksa5bXABYZUORjYJrs+Tqp2CIiKkQ5MJvaF14Uc38L/ZIhMjqFtYNOZa8nB6sruDLgGDbqFgFb5qtfNw1rAKGLtNWQ/FsMKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 20:11:28 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 20:11:28 +0000
Message-ID: <dba8b2f0-ab2c-48a7-b842-4ffdc7d467e9@amd.com>
Date: Fri, 31 Jul 2026 16:11:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amd/display: Add HDMI ALLM support
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260730171754.704049-4-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730171754.704049-4-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::11) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2078e7-3bc3-4fad-2288-08deef3fe7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|5023799004|56012099006|22082099003|18092099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: xUEmgneFquSiMeb6zv/kGvTlfK4FdPPP3QqQ9cnu/AvtenW7el30xF2Rcoiyzjkho+XGOrR4Z3Js6EdcQ0VYmNPn5H9jHISjy+xN6ptqnc7jCtGlrn7fqbOusqcr2pEqNvvK8s2LVexPZruXBykRN5acE7Gm2OubPPBRU/wkGL6IPp6za4ShU0otgyIWUnAV0eXHD2KsHZegpCN6IB6LnbGU0Gm9/j0yJ3Z5X402FOMZmHKXZBzmHOrrqS9NfxCFr3e8afjrS96MzUjEs6FjiL/+3BQJpXtLS07f5Zi1cL4xWNwY6zJc6RTYDYB+84cqUO7bXzHf1y7EBuKIM0/qgzHm6/HMbY2jbr3RN8+OS5Dso0E2Db4CET6/Z31cCrOlvdNXBflFfElDxGwo6IuYdshXSrN4L9buUsIQ0si548ZahhL6w9lTfZuF5Y4qaPk0JNqHM5CnwDsczGZQpsS89yxa2TZh9E3ZzOJhcYBYD/HambIHOiRlNtjtsy5syaCEVWnKRazBg5/DGrxsoCGHh89hQixLmkb85/HF8LPeOHRU0sCFVkF7NmOapxWuSfXE+cz6VqqrygpNVH3zIOAGPohANhxJjmy2BXstTfTiysqvhpbsTZ7+3IOALqzSPAZ5qr6Un9DTiCLEs1x0+aXDFS6Xkfvbp8Lsu4TBoaWFo7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18092099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09PYXdjSEVMMnFaQUsvR05VWWlLUi82cGlLQTBZODd3R201c2VsZlpNSlFS?=
 =?utf-8?B?Z05scE1mK1JGOGM2b2t5VHN4dUs5UnBIcW9iLzk2UEdNZ3J4UVNWZXpFcC9S?=
 =?utf-8?B?QzVadWMrcFAzSDNJZDVLM1l0TWZvWTIwY2lJUE80OWZLM3NGS2JNSk5oRjVD?=
 =?utf-8?B?RVdObHFzWnZiSXQ0dmpMYkwvTEsrZEJNeHcybnFLMjh5eUJzQ05GSHk4NVJ4?=
 =?utf-8?B?ZlJjR1BGcXBlb2ZqUHM0cmt1YU5KUG1Hd3pDNFZyOEJRUEhobmRqRG81aTUr?=
 =?utf-8?B?dzhNVUtteXRCbmEzb201ZlV4bHBrVnVaTkhGd3Vrc3F1cytSRFM0eHNBMXNU?=
 =?utf-8?B?ckdmRVUycnkrNnhPNnRxZzcrcXdlUnVlRENEb3o0NWw3bUdFQzhPcTkvc2xr?=
 =?utf-8?B?TGlwRmQwNEkxS1dwL1RMOXVmLzV1NFVLb09nb0RJei84dUNQV0s0Z2F5cXdp?=
 =?utf-8?B?dWRvdUwxdCtmSmFiV0RqazN4MGlKM0Vyc3dYeld0R0Z2aHExODlJY0lkQ1pS?=
 =?utf-8?B?WE95QTNqU2xxdi9vZlFCQzNBeSt2N3dhRVZNZEQ2L2Q0MzFlNVBheC92Snp4?=
 =?utf-8?B?L3g1OXlTOUZkbi9KQjlYY01yZkI1SUhjdzhnR1pIVEhyYWNTaFRMcmVzdFo2?=
 =?utf-8?B?UzYyY3Y1TFprZTl5ei9DVWJRZ3hzQ3NzeFR3TDZEcXJBMkc1S2g4M3JDMkFD?=
 =?utf-8?B?Y0pwaEc4YUkzM0tSd2hMR0tFczdhdmJsRjJuT3hlekpDaVNRblpqUkFzUTJC?=
 =?utf-8?B?SFhxMnVTN3VUbWhtM0pwQVVITkZkSGQydk5kN0wwRjRUb0NmUy9BcERQRmZM?=
 =?utf-8?B?YXBTWjF2aXJwNTFYMzBNMTBmYVZVejFVTkpmdWs2bmlPcTdqYmVWKzZuc3BT?=
 =?utf-8?B?QTJPaVBpR2pvVVc1Q3dJQkpXczlCY2dseTRVQXZrVXYzbHJNZWR5MDdsK0Vj?=
 =?utf-8?B?bTYvUW03RzdwUTQwR0FYd2FsTnEzSGlIMXhONDFnVDg0Z3lKYUY2WUdTYXVw?=
 =?utf-8?B?M0lKMHVodEx4MVRJc0ZQc3l6UUFNa0VvaGp1US8xMXdodllicTkxb3krTE9T?=
 =?utf-8?B?THd3cXFHOEN0SnBOQ3pBbGdOMTQ5cWF4Y01xdGt0RzRkeHBOUlNkN21pT00x?=
 =?utf-8?B?RkVWU25aL2lxbWsrZDFPRlduNjdwNDBOekRmcHp4aFYzcVFQcS95ck11a21p?=
 =?utf-8?B?VlQzNFpJajNvclBUV0pRVmNRbG10U3RqYXRJalNqL0labWZ2RXovT2VYZWxn?=
 =?utf-8?B?c1B5NUhFODdXSDg3TUQwanJRcDl1UGdReDBoaE94ZkQzUElzSHk4VEFQdDBn?=
 =?utf-8?B?Z2pUcGl6UDRJUGN6VTdydDRkczF1eTNGZWxONy95ZjhjVzgveHlUMXBhK1Vo?=
 =?utf-8?B?ZXpqWUt2amVKYTBvSjJ1MG9URndZMUtyNjViOC9PcGJxTjNzUUVMREpqa0pD?=
 =?utf-8?B?YUVNTUVnbUNTTmNEZy95ZmwzSnVaNVNjZE5JbUg1a3AvbEN5NVJNZ2duMDV0?=
 =?utf-8?B?eVZCelY2eVgwUkY0anFWUXFtREUrVXcvRE1QTDlacWNxUFRVZi8yZG0wajAv?=
 =?utf-8?B?bFN4ejRMVjhVeTh4U0c1K0NIV29HSW5oVVVNZTd4NTkvNXdDdDcvbGxuTTNW?=
 =?utf-8?B?RDd5VDZlZklxbGtaekRZSUNHM0VpWE1RaWM2eEZrM3N6M1k0NDdKQkJwVFlE?=
 =?utf-8?B?NWxKcWFHdjhUVmd2RWtXYk1KRjRKT3FzZW93My8rRm0rOUIvT0JmOFdDbWFn?=
 =?utf-8?B?SU11cVZlRytPWk9zWVA0SXc3VTNVb000R2dRS3Zsdis3MmlkWHhOYUVqZ3po?=
 =?utf-8?B?TEJVeFhKMjFseVovMGdEa3pXZ1hiMHM0OEQ5bGZhWmhxRmtOd3dwamhmTHR1?=
 =?utf-8?B?akNwSkNacHpPWWtxNTBxYmR0L2N2dFhBdHhtYXZwV1pmR0ZyZ3BPRHdobU0z?=
 =?utf-8?B?TFMyNkxpYlFub0lsM0IzajZEclZYRXc1QXJMZ3llSmdBS083SHJqR2dCazU4?=
 =?utf-8?B?UTl3bnlBL2tycmhjL3NDUlRkUTExTlFibHlIeXhVL2VBNFFhaGFFVjB4TW5o?=
 =?utf-8?B?a214UnVOaFN1dDZVM2pIdTg1VnpRN1FOMzZ5UUtpNSszWTQ3c0EvMHZMZVhL?=
 =?utf-8?B?RUd3V2RpSmg5ZVlQcTdVZUpObEVuUzlIS2ZoTzg1S29FUlV4UG83MTZyekZF?=
 =?utf-8?B?QlNwclFOWk5IVGRLSnJhbTVSUkdWN0ppa2lCMDhESWRxZ1k5Vld2YlRsMmsy?=
 =?utf-8?B?NWFsL0M0YkJkV0lSdUUyM1FDZUFabmNONG5GU3dQeTlYb3Jtbll4U1d5YmZN?=
 =?utf-8?B?RTc0aU1WekF4dHJTaFZtUVg5c2wyUkwyOWlpeHM4a0JGTFBkTUR1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2078e7-3bc3-4fad-2288-08deef3fe7a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 20:11:28.3338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfXOuyj0NgV7vYdsq0CMIwS60DU15HfiBLAcD2+Hj6UwGzfjJUHHV6GYDzvA3nt09JX0RFXkGFWGiKRGoaH3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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



On 2026-07-30 13:17, Fangzhi Zuo wrote:
> why:
> HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
> low-latency mode through the HF-VSIF. amdgpu never set ALLM_Mode in the
> HF-VSIF, so ALLM was never signalled to the sink.
> 
> how:
> - Add an allm capability flag to struct dc_edid_caps and populate it in
>   dm_helpers_parse_edid_caps() from the HF-VSDB ALLM bit parsed by DRM
>   core (connector->display_info.hdmi.allm).
> - In create_stream_for_sink(), build the HF-VSIF with ALLM_Mode set when
>   the sink advertises ALLM and the content type is Game (content-type =
>   Game is how userspace requests low-latency mode, HDMI GCTS HF1-56).
> - In update_freesync_state_on_stream(), also set ALLM_Mode when
>   Gaming-VRR is active (VRR_EN=1, HDMI GCTS HF1-58 step 8.3.1), and push
>   the updated HF-VSIF (vsp_infopacket) as a stream update.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++++++++++-
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 18 ++++++++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  5 ++-
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  3 ++
>  4 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 223b562f7005..fc3005ecc681 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3895,6 +3895,36 @@ static void update_freesync_state_on_stream(
>  	new_stream->vrr_infopacket = vrr_infopacket;
>  	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
>  
> +	/*
> +	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
> +	 * advertises ALLM in the SCDS and either the content type is Game
> +	 * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
> +	 * HDMI 2.1 7.6.6.
> +	 */
> +	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket = {0};
> +		bool allm = new_stream->sink->edid_caps.allm &&

We have an `aconn` in this function above, so we can simply get the allm
bit from the connector:

		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
		bool allm = sink_allm &&
			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);

Then we don't need to add a new allm bool to edid_caps.

Harry

> +			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);
> +		bool allm_changed;
> +
> +		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
> +
> +		allm_changed = memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
> +				      sizeof(vsp_infopacket)) != 0;
> +		new_crtc_state->freesync_vrr_info_changed |= allm_changed;
> +		new_stream->vsp_infopacket = vsp_infopacket;
> +
> +		if (allm_changed)
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "ALLM: flip on crtc=%u: sink_allm=%d content_type=%d vrr_state=%d -> ALLM_Mode=%d\n",
> +				    new_crtc_state->base.crtc->base.id,
> +				    new_stream->sink->edid_caps.allm,
> +				    new_stream->content_type, vrr_params.state, allm);
> +	}
> +
>  	if (new_crtc_state->freesync_vrr_info_changed)
>  		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
>  			      new_crtc_state->base.crtc->base.id,
> @@ -4429,9 +4459,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  		}
>  
>  		if (acrtc_state->stream) {
> -			if (acrtc_state->freesync_vrr_info_changed)
> +			if (acrtc_state->freesync_vrr_info_changed) {
>  				bundle->stream_update.vrr_infopacket =
>  					&acrtc_state->stream->vrr_infopacket;
> +				bundle->stream_update.vsp_infopacket =
> +					&acrtc_state->stream->vsp_infopacket;
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ebead39939a6..430f1628ced0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1511,8 +1511,22 @@ create_stream_for_sink(struct drm_connector *connector,
>  	update_stream_signal(stream, sink);
>  
>  	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> -	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
> -		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
> +	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		/*
> +		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> +		 * advertises ALLM in the SCDS and the content type is Game.
> +		 * Setting content-type = Game is how userspace requests the
> +		 * Sink's low-latency mode (HDMI GCTS HF1-56).
> +		 */
> +		bool allm = sink->edid_caps.allm &&
> +			stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
> +
> +		drm_dbg_driver(dev,
> +			       "ALLM: set mode: sink_allm=%d content_type=%d -> ALLM_Mode=%d\n",
> +			    sink->edid_caps.allm, stream->content_type, allm);
> +
> +		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, allm);
> +	}
>  
>  	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
>  	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 42f5673acb4d..e69ce0a1b4b4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -197,7 +197,10 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>  				  edid_caps->display_name,
>  				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
>  
> -	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
> +	if (connector->display_info.is_hdmi) {
> +		edid_caps->edid_hdmi = true;
> +		edid_caps->allm = connector->display_info.hdmi.allm;
> +	}
>  
>  	if (edid_caps->edid_hdmi) {
>  		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 3edeb94fba23..ae409cc59ae4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -226,6 +226,9 @@ struct dc_edid_caps {
>  	/*HDMI 2.0 caps*/
>  	bool lte_340mcsc_scramble;
>  
> +	/* HDMI 2.1 caps */
> +	bool allm;
> +
>  	bool edid_hdmi;
>  	bool hdr_supported;
>  	bool rr_capable;

