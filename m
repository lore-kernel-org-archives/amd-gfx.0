Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5519BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B4E1138EA;
	Wed, 24 Apr 2024 08:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBsTHfEt";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0211138EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju9IQRxTN+/yXL7/L15XpbepdgaUEkiiKlVhVjpFebVjdjT2cLUYcVWL75HwZsE/uo7uzhdTX0cwD/TWe5Wk/jU4xSMtH7gqMJr6cIsC5x3CqsgBSDQ1JC6q8hhlPxQyd9doNAcKuUjsFmxzod8eW2jUVMho2HX8cSEPalFn89zCnnxyV0MpGgx3N6cI054UHHn3xwWJJr5ZtEOUylfS220DUDnOeQg269Ikc2hky1dW64NqZ9QCjMtB8t9Un2bY6q7Dl8MxarNuC496JttrxavHVQtMHYF1aEkva+WNaZ5kGETQO+f5V4Z2uWQBsmk5hmpLxSooXkNA0n9xA8pyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8nGJbKOrzVyNMIP9kzvQsPBUukyKwmYcD3YZy8Np10=;
 b=C7mB6V53MN9mNnDZsulToz0EH1hsEe1fgZJ7HY6MUkvB/nrP+b5KNRUpTHpHCVoSA6BDxMuOy2wIAze194V1+IcaSbYezO3aFcJF/soEw1o+6hnbmwHqFPT/pHVVxv2D72eFAVRU8V9fULTBwKRaaiyBobdHd6zwkXNwvYwqK1UmrQ1GDZXeiFXWtIyJbv8v4LxKbS6joaLLmp9GL6iQKpvrIfbA1Apr2q+/UnWrfftpCM6UlCx3ovokCjYmWqB1zwX7YZQOeodY9URm3m7H8XbZEU0KwCQM5zvilM637Zesoi0cdXL0Bx1+nOSmJvjKCDmJvYXN/m04n8jtDSVY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8nGJbKOrzVyNMIP9kzvQsPBUukyKwmYcD3YZy8Np10=;
 b=KBsTHfEtKeUTd6l2weO/lK1Zpw2yFBnD5i3lnQhrqLwPTljGoZ8naT+boiuo3SOLwJ81iHi+TQ9/i2LO/cEhk+SaYf5AOmI74cOw9dSubwM4yfcpT6CnYt8SWtHQlRr4bXlFABYZTPRo6BX+69c7xqOE0e70OA0NTCMwL7mIBBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:15:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:15:07 +0000
Message-ID: <edeffe65-bcb4-4b7b-9536-05325d8d76a3@amd.com>
Date: Wed, 24 Apr 2024 10:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: Using uninitialized value *size when
 calling amdgpu_vce_cs_reloc
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com
References: <20240424025016.727595-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424025016.727595-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cafff4e-a419-487a-9776-08dc6436a6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDJNMVQ3SXczRnYzVzMrbmdvcC9IbjRiYzZPNks0N3lMaWhpU2JLOVRxT09W?=
 =?utf-8?B?T2dmMzBRTkNDREdtNDlBT25LT1dOaXRkMmpPVVV0a3NzWnNwOG8rZXJuVXY4?=
 =?utf-8?B?TXlGd0FvMXcvcDlNZGppWHprVmR0ZzlLNVBidHUwc3J5VVFHRE9uK3ZCUnJI?=
 =?utf-8?B?QnhkQ2xnSXJXenA3dmFtUmZVTVZQR0tSNUhKT2QxS3RzdXgxdGkxZGpzZnVJ?=
 =?utf-8?B?bDY3OTQ2Z0ovclByUkNSbTNoUWd3bjl6WGIrRGd1Sm12VGl6dExTM3h4cmls?=
 =?utf-8?B?ZUVUMkVkSlNlRGlPb1RYanM2SWZYNEI0WWxybXpNc3RvejdVZ3BMNFZ1em9l?=
 =?utf-8?B?dnJySHIvRDdPdEdRbVpVNjN0Um04N3M0Wjg1ZWNxUGc4YkpjbkxycElSa3F0?=
 =?utf-8?B?WlZFM2M0Y1ZVR01SK3ZzYTR5Vk9xenpFdFpQS1hkM3Y0TFlOaDQ3R0Y1TlZI?=
 =?utf-8?B?QmZiOGtDclhQUGtPY3lMY0JkZzVLNHkzME1ySVJ0ZHVGSTlGS01yK1AvdHpV?=
 =?utf-8?B?SUNaU0IreXVwK1lDTGZYcGxsSHUyeURKNGVLVWRwaEowZ2tuc0ZOYmFMNnBV?=
 =?utf-8?B?UUJ3TEZJMCtER0JSbW1nbWNUL0xKWTBaWkJEa3VSRWJ4WXJiRmh4ZW5oMkt4?=
 =?utf-8?B?RjYxa09za3JEcyt1QmdSdW9tM0tGd0xLbmV1anRwUi9PRDJiNnN0USt3UDlu?=
 =?utf-8?B?NHRyUjFMSU8yTjFXK3NhSk9RNjBmdnhKOHUzOTkxNjhvTHNNczFKdVlOL2M2?=
 =?utf-8?B?QkZsVUpXYTVyU2JQcnh2UmFEOFNTUzkrUUg3bUowdllaclVVQThwV0g5ckFV?=
 =?utf-8?B?THdpcTd6UDl1SHBSMzJhNE1ab0s4bHQ0WjFWQ053Y2tSNW1aRC8zRC8xYkkz?=
 =?utf-8?B?MW5IUmlIV2p4cnJFMXJNNUxiMXBGNm4rbHVWY0N3L1IwSUtFc2NzUWx1QzNW?=
 =?utf-8?B?VHVlYnMrQXdiTHRIYVFtYU9USUJDSXkwaFlKSkFxdHNxZk9NVkdVZStLZFZY?=
 =?utf-8?B?VGtma2liejVjd2pOMUlZZlBSdVZMQVZZRjZMd1pMZWE0Zm5UUjB3QVlTSnh6?=
 =?utf-8?B?Rm5BeURNQ0t5bGIxVngwckhBNEt5ME1DcWpoeTlqTTVudjNXSHhYWWI1VjBG?=
 =?utf-8?B?TExZb05EVEpvMkZLM3k0enVaOWxadW9URlhwSHZObngxcittNlRLNEdkZVhV?=
 =?utf-8?B?b0h5V0NpWlFncHY0WmFJVzY4T2V2am5PWVhzZWxmWFZ0Vmp3eENwRHRKMWdl?=
 =?utf-8?B?NWxkSlJkVEZwZ0Zpc3loVVRISDREb25PRFRhRHRlQ2hQZms3VlFDb3VHMy9m?=
 =?utf-8?B?QzdKd1cyNUpFZWJXRm1sSnZqVmsrWUNKK1VTK0lQQWg4S0diNWdGVWJZcUVh?=
 =?utf-8?B?SzR2Y1pTckNsZ3BKY0M0VmxFMXFTclRkbmZnMkRwQ3kzbUV5b3c0K3pwN1JY?=
 =?utf-8?B?eGhRVkFkaEhJR2tNbHJPT08rRURIYmhTQ0Y1dzhNUE1TcWZMU1FBang5MjhP?=
 =?utf-8?B?M0ZZcThMM3FxSHowZlNiNUZPaWNMTzZMNW1Rc0JVc0YzVU1rOUN4TnArVTFB?=
 =?utf-8?B?MU1CZFIvQ3hGWkdWb0lZMldBMEVqVDUwUGhtc2VWRGRIK090QnlhbmRiVGlZ?=
 =?utf-8?B?V3YxZWpCS2grWUJBZjZiSXhHQ1MzRG5OUFdkcVppSjB1UkcvY3VhcWJPWEpK?=
 =?utf-8?B?aDZoc2s4VzZNc2NRazVPeTBUbkdwSVBrRHhVSW5CNnhNUk5FVG5xTWVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RC93RmJTS0lFazNVY3Mxa2RkY3FWZDM4VnBQeHNWNmdzTGNFVTNiMTNRdVc3?=
 =?utf-8?B?c1k4U0RhalRyT3RVOVk3ZEZ0SkdnYjA2U29RalcwN253a0w4cGx2S2FmRTQ4?=
 =?utf-8?B?am9XN0d1b2Z2RzJOeHdXM1J4UkRXVm41MG9yeDl3UUQ1Mi9KK0d6MitqU1Ez?=
 =?utf-8?B?bUlKQ2FNb01PbXJSeHRYLytRTVdTOERvSzkyWllJZ3lqNDV2V3hGRGVwOGZX?=
 =?utf-8?B?ejRIeWJkTGZwY05aUE9VOGRBaSswb0FxOURTY0RzYndBYWkxbWpLcDMrNGdm?=
 =?utf-8?B?UllKM2ErTy9MV01VS1VOMVNoTWg5cUJHbE8yaWtybXBqM1YxRk1jY09ZTGtv?=
 =?utf-8?B?UFY0V3BWNy9vY3dzaDI1RDJzY1NDSmpFU2plL0xMUW1NaEVQRGIrcWVFL1ZL?=
 =?utf-8?B?Wno0MEhzZDR6aGtzZGdTYUlmMG5lNUxZbUFFc0pFelh1TnJ6R0twbm1kS21w?=
 =?utf-8?B?SUV4NVRXL1RZejJBc2pJWVh0b3BmZ0lZaWxTMUNRZkJ0K2txZXo4emc5S3lM?=
 =?utf-8?B?OENhYkwxaE5RMlRxMWFWQUVsdFlUUkZyV0trRHVqY3AySHFGV3lnd0lteGIy?=
 =?utf-8?B?U1ZzMTZSUjM5eUQ0Zy9Bbnp2VGhlM0ZYZWo2RjVPQnZLUVdQOE9VRkhBY29W?=
 =?utf-8?B?OHdNTXVaUE5aODk1V0xEYlFnUkltWkxoWW53NE13VXBZN2haQ1UrKzFFQ1Zs?=
 =?utf-8?B?RktpOWNtZ1JEd09xcXdCSzNrQlRoYVViWU93Mk1qZFppNlZOVUxNQzEvUWY0?=
 =?utf-8?B?Qm5CNkhCQ3Q3OHJhSFhHSHdZTnp4NTBZSTE3WDVZOEhXSnU3TXoweENKQmNP?=
 =?utf-8?B?ZXJsbWZ3UmVJSWxJOG9UQ2VvcTFDRWdlZ3RrK29TY2djTGRySWZpWm5HM01k?=
 =?utf-8?B?TmVLMXNwUzBQUXI0dEZraVVsWmpjd2RnaDB0Vjk3TWUvaHFqNk9HVEdIbXln?=
 =?utf-8?B?OFF4bUE5empYZExzVExnaGJjOFVETkIvS2ZjTFR3K1BzU3A5SFBoV1VvWkIr?=
 =?utf-8?B?Z1crOFdLRm4xMHNHNS9TTE9tanZoL0dCSWwzQXp5NXFzY0cyWGUwOGZkSHRN?=
 =?utf-8?B?UWFUM3dqWHBpNjVFNVZLcjFtL2haeGJHZEFqWDl3ZlowV2ZHMndEOHk4amhW?=
 =?utf-8?B?dnZCYThPU1A0QVNCRThmS3FuNFk1TyszbUsreHl0b0dTQzhWdkhJSlNVKzk2?=
 =?utf-8?B?VXRGZ1VGa1hkbEQ3NEs5U3RPdkhlelBsditxbHowa085OWFPSTlqYW9nVE1r?=
 =?utf-8?B?Zk1tU1RGY05ZaHBLOTVDajI2c1BrOC83VXlLZU0rVWVWbkRrS0lSclI2SGFX?=
 =?utf-8?B?NkpVeElrbDJSbktkWGhzVENpTkJ6UzBTVGZaaWRsME5oZzNRbDhJRG1KT1cw?=
 =?utf-8?B?Ync2MHl6TXQyeU9qOUQxYzRyU0wzV1FPTXc3SmdvOGYrdU9URTIxTDJoZm1v?=
 =?utf-8?B?eE01dlRvZnUxTStXbGozUTYrdE1DS1ZTOHRMMXJneGFha3dKUEUxL0hTcjF1?=
 =?utf-8?B?UGFlaTJHazBScEtqK0lIMytYemhodTVIMXJJZUhJWnlISnFZczFZVmRmTWFZ?=
 =?utf-8?B?RnZjR1RSNWJyckUveW1DeGMvQ0tLc3o0NjVzV2lPM2RiQWhTWnNqR2NhOEcy?=
 =?utf-8?B?cTNrdDdiMXpaWDJ1ZnY1OG9DTm52dWN3c05LKy90eUJEek1FQy9QdzhaRFFm?=
 =?utf-8?B?aXcweWJUZHUyR3Jkd3l5c2ZFRDZURzFzenczaWhMZ2Y1RmY1T2VTNE9mekpF?=
 =?utf-8?B?SUFMZHUwS0dlSWhxTVhITDVDS2JaTWRDZ2NHS0JwYUZPbXc0UytNWDdyWFR6?=
 =?utf-8?B?RU1peXp6T3lpTWJWQlJkY05iRE5pMk9nSXFYUWhUdlNkZnVWSGJGaHRVZGVm?=
 =?utf-8?B?MFpsK3B1Vy9HMTMxTmNKYXJOYjdpS1MxSUpsYU5LSURuTXJGQyswbnlxTXJ0?=
 =?utf-8?B?aTdtWmtwTTFraXVNUWRPeXdVeUYweDRYMndYR0MxZU5kcURZNHhPT0lBWURM?=
 =?utf-8?B?TnhpR2JFQ2RBNys4SU5jRy9JdnRuMDhKZ2w1aWwybFBlOHpRNks3bkwzUTBy?=
 =?utf-8?B?Y2I5V3ZOWEpnZlBMRFRzRndwdkNRbVpoOC93Y2lIQTFDVEJWTXlLN1BuKzVZ?=
 =?utf-8?Q?Cjs0xlT5vTWZofgeunfcnMZyA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cafff4e-a419-487a-9776-08dc6436a6c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:15:07.1333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXqMU+jIUArELVF73stmwI4Pt0vBg+66x7HcEK4d9na/A2gDk6To9mql8IkbyhHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

Am 24.04.24 um 04:50 schrieb jesse.zhang@amd.com:
> From: Jesse Zhang <jesse.zhang@amd.com>
>
> Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

To really improve the handling we would actually need to have a separate 
value of 0xffffffff.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 59acf424a078..60d97cd14855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>   	uint32_t destroyed = 0;
>   	uint32_t created = 0;
>   	uint32_t allocated = 0;
> -	uint32_t tmp, handle = 0;
> +	uint32_t tmp = 0, handle = 0;
>   	uint32_t *size = &tmp;
>   	unsigned int idx;
>   	int i, r = 0;

