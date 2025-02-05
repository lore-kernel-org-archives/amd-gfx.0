Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34796C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB0A10E204;
	Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hR6Hz6xH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D04B10E1CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxECWwplhxHKD2s6+C7W3zU+jQgWH7rMrvCSCzSSHWTKxegeM6XBehxfk7tXXWT+Kn2RfECKE7d+WdYmg/RuCWF8hP7QwxwtnPQ6TXzeFSkzqDNn38N3VhS7xwoaqh5eBzFcNjCMeGr/U73MyWsNdL0lCsQptfBHCLs9mIBv8PSwAs95l2ptggrRo4boSq20+YTs5ssd2jlg2R7+K257zqejNTB5Ll95ayeG58KlVF1fXz9WSP953aXFm02Meh78Q3ezd+Tf8Q/kmHp23hNWqPkdAreuRhJ+WjT7diOnMjctRa0G4YC4Lpv7SFsPr+MJIxuTjMBYdNRM+kpGkf5zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdjWS1HPbovf//xBzsi9ZtjDGIZsLzAsaM5xS+TWvFg=;
 b=d2Xa+AcAizNRydhjDzTrMpnkfoESn3iCIw7kflAsjLUuLznCpAuIDUWV24HoVgCrdITXNZvI8vrThazSWSvY76t/Zc1fAPQSj2bMQ7eKc1RU7SEheAcOFL+KUeDFJJtnw+3cZFZiqKFrbK4mC1FzHYH6CeC7wtYidrOH7hkA0jRHYLjab+gCF4TyUGeokgjUYz94IOSOKTf4hSgLCyVZTKyO4df0JORsCnq8KwFjz8OzIScB2NK/tkdseLZZ1gDXquxsMMifKJcL7YeWLmBNMHcDZSFEePgqZlxU4wURups9NSu2/CXJLR0VSWGNgG60BTPlL2vAPYI0JVMgIUDL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdjWS1HPbovf//xBzsi9ZtjDGIZsLzAsaM5xS+TWvFg=;
 b=hR6Hz6xHdleOKlI85JDzwphW8pbAOQPOvHbB29W0KxUNZrd4ZuTOZmD+P1dftaykhnlgRca5RS83OSbBBej79C0m47y3Rlt8NOaLEhiIyYN5zwmLhTMZ4Aai+X40gg0RLQJ3Wz/iD0OBpcFNiyGkPDJKR4Bxwup1MCP6NZBxRfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:00:37 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:00:37 +0000
Content-Type: multipart/alternative;
 boundary="------------tQJWNPGRv3CgCmEAUEQUih96"
Message-ID: <d95d4cf8-6ba5-4113-b3ce-03ed84ee7694@amd.com>
Date: Wed, 5 Feb 2025 10:00:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/44] drm/amdgpu/vcn3.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-13-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-13-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::6) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: d04ce449-fd0d-40f3-5731-08dd45f5d915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnRIdmNMeksvalZDMldkc0JKYVcyckw3aTVkOWFXQko5VEhyZFY2d2U5VEph?=
 =?utf-8?B?dC9kTndqakc2MmhtTU9wMTdwKzdrV29reU8xV0NucEo4ZGZKejVpRFcveU53?=
 =?utf-8?B?UTJ3cEpBbGxnOFFGWUdFWnV3aTc3QUtTVWRISktZb3MxYS9QMjNIZUJZWWlG?=
 =?utf-8?B?dm9BTE1ielgxSHVVS2NzVnhqblRtQTVsM2h4WTVGSTRqdHRob1BEOU9WMGlN?=
 =?utf-8?B?Q0ZrSnhyazlES3ErbWprVzBLSEpER1BuR0JzcE9sWHNNNk5CWndBRm1FZnVY?=
 =?utf-8?B?TlJ2eUZPMDNvcnBkSWtycDZNbDNvTldWa0VpM0hoN2FEL2VsM1daZUwrVG1p?=
 =?utf-8?B?WCtIRWlqV0I1citKNTllZzVzN3htbWw5a3FlYkprMkpLS25pVDhDVkRjS2lO?=
 =?utf-8?B?T3FaaFlHVzBwcXpFZFVIUWhVb2wzS1lIOEYwemNVTHVHMGM1ZnBhK0t2dkxW?=
 =?utf-8?B?WWc5S2l3MnA3azMxT1RRa05TbFNsNDhHTVBFU2J1OTR4NUxJU0lRbWhRWnVu?=
 =?utf-8?B?YzBaSDUwZXJLenljR3hxR3hrUjBkNEVlc1RvUkgxM2cvRG9jNlV2NU9WVCtx?=
 =?utf-8?B?Sk56cjhwRFJYYTNvL0ovTC9FM3djcENZZ2FPYVJScjMzZ0p0V3FsRXkxbnA5?=
 =?utf-8?B?SnZkc2V0Lzh6TzAxVjVadHJWRndjQ1orSk9uUFFaNUpxVkxDL291L25HNXZv?=
 =?utf-8?B?S0JEN1hqNXE1azcwb0NvdjRWUStCK2NrTGR6U0RaWFE1NDJZK21hRUVzUGZ5?=
 =?utf-8?B?WHBCV3VZRWNPZVl1UGNZYWRWN3IweWpPQnhObkJaVXVkallmR1VkWUtxZlkv?=
 =?utf-8?B?WWx4SFozajdpMGQweGlSaDMvc0Z3dk0rVVZqNmM2U1pSVWdYbHVlUHUzRWsy?=
 =?utf-8?B?cldSQmxPcFlHdERlK2ZWVncxNTkvY3VKSG5iMk12TmNXR3g1UVViV0NVazlB?=
 =?utf-8?B?eXhVckMycTVyVTZLNkJsRjBCWW8xYzhwTFhZZkhxNXJKYVRXV2xna09vVC9y?=
 =?utf-8?B?U3dkRzVkR2ZTMEw4aFpPcWlubUw3Q3RwOXl6bG12c2NTcTlnaHB6TXM4Unk2?=
 =?utf-8?B?bm0vSzloSSt3REtXNVBUNGRpTFZYUzE1b1luQVBqQUlGalFvbTBJUTBEd3Nm?=
 =?utf-8?B?ajd3SFRvakJFTHVSc0o5bWNLUW9SWW81WDVGVTNEc21QRVJuaXFGQmlSb0dh?=
 =?utf-8?B?TnQxOG9XL0dURkwwaTMzMDFHbDdaTG42eWlKUWdxNkc5c2hYWnJUUkQ0cG5h?=
 =?utf-8?B?TFRTRWVySkxMSWJqSTFCSjh5TUxsdzRDWHpGckNCZERIc0VkN1Q5QmliczRp?=
 =?utf-8?B?cDZzdkdDWXdIaENiUDlnU0RhcnR0SGxQZGNpSll5ZlpRblVuOFAvazB6R1RH?=
 =?utf-8?B?eCtzZHB5aDY1ZVdSck1lRGFmNDh2a2hxdUEycDlFWmNZOXRNdXUweWp0N0JQ?=
 =?utf-8?B?YW9ZdmpteWduV2pETE91emhUUStaM2FRb0xFUE1EZ1pqUWRwRTlyejZHRlIv?=
 =?utf-8?B?MVZlNVpHRWR3a2luTWJ3MERPMmZaOXVNamxmTWJIdTlzYnBxVFVLTldtbDNI?=
 =?utf-8?B?M1pkWGYzY0FOV2gxM3hTYm1uUjVhUEhEVXYvSjRtMEZiN1NCU3JHVmpNSkY0?=
 =?utf-8?B?U200eGQyZzFDeUhUOWJPS2F5ZVZRUlFnYTk1UTlDb0JzTWJCQXIvTVI1RlJF?=
 =?utf-8?B?UHpkaklybkdOeUVGZ0lub05FbGI5dmdhSjFpdW1tQXh0aU1hOGZGS0NPQjc5?=
 =?utf-8?B?WDVCUjBwZC96dFhZUFJJMHBpQ0lnNWlpZ1JYaXlaSjJqOWJyRG5GdnU3aDNF?=
 =?utf-8?B?T3ExYWsvQjhjelJ1K1FDYndXcGxTcVZwK2ZzNkdYT0hpVG5MbmpkbFJBSFZa?=
 =?utf-8?Q?mkuE7G7MWmicK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUgyUHFGaUFGVVY3T25YdmZRUlNtc1pVQVR1T0VrTkt3ZWFsVWNMeTlpbERa?=
 =?utf-8?B?Z1R3cEEvT1FTOFFIaUNUazI2Mzg5TExpeXY2ME9HZVlSdmxHZk12NC9UZnoy?=
 =?utf-8?B?MkVYTlBmVmJJdlVqMEEraERRNUU5NWRjbUpndmFRc3dNNmFUTGM5K3hZVWhV?=
 =?utf-8?B?aWVKS3podHd2WHRQdUJpUHdHckdJbDNoeWxBWGowYjJLZ1VlaUdwdmRWL0hU?=
 =?utf-8?B?ZXNLbmpRU005ZHNkYVA3TTdQbUNyUUFVQkNiYmEwd1R3VW5EWmdSSzFKdjlJ?=
 =?utf-8?B?VFd4b1Bvdmxaa0J1R2R3aFBYL3VnbEFtbkR6anExOTdNNWRTdjZwVlpnQzhY?=
 =?utf-8?B?bzd4YnJIbHQ0UHlyU0wxeFBoWXNJYWd1bWxpaXN3S3lMeldzUGdBSGFPdmFZ?=
 =?utf-8?B?OTlZQ2ZtdTlYUUhKTlVWdmNNRjErNnVydXlUb0lxaTUreElYS1Q4K1J3dEhl?=
 =?utf-8?B?U2FURVBGc0JSdVV6NTRtbUV0eVhlY0tLTTJ1d01WNXBqZ01zVEJQZ0NxZ3Z6?=
 =?utf-8?B?ckU2V01nS3hSVk5OZnFvKytCdmJxV296YWl5K2hNTW5iNHppWjlpeGwzTVpN?=
 =?utf-8?B?eUgvdWNCRFZ1Q05GSlZUd2ZVdlhvMWhZbWNNVUFTMk9RR1VGdTZCaHBiWFpN?=
 =?utf-8?B?SW90aTY0amRpenN3c2ZVWFpjQ2xpOU1pQUpURHdZM2Z5TFIybWpiWnh1NHpp?=
 =?utf-8?B?Vkx3MGozdlhZNlBjSkx5dDlsY0dkSEQ2R3VhUi9GQnM5Q3p6amJiVUtMRGNv?=
 =?utf-8?B?SFcrbGNqczduSjk3cVAwMmlTVHl1S0RYbWRzMFdiaVdjVWVOQnVvNjdObHRj?=
 =?utf-8?B?aDhpa1FlMzJXYmowT2RtbkJnRzBlN3VFWGI4SW5pTmcyTW1pOWN2WnEvVUts?=
 =?utf-8?B?M1Bia3BFSzVRVW5XcmJaRlBRQ2QyWWlMYnRzc0FEOEFBVG9yZ2M0WW5odHBU?=
 =?utf-8?B?eS85WS85MkRkV3JDMXNKQ243ZGJDZTlOZkpZaDNXRnZIT25rSU1mR08xVTR3?=
 =?utf-8?B?a1Q0bEFCd2R0dXNLNzVXcEdnK0NQWmhoQ0lpSGV1QlVRZVBoRE5ScUNFcjM3?=
 =?utf-8?B?T3U4T1pvbDNZNjk3cGE0MSszUkhxR0dyb1BKZ3V4OE1FTE1jZHFONXFUM1Ax?=
 =?utf-8?B?cmh4Y0JmdlpENC9meHJOZzZHRGpkZXY4aVloY3ZjTG1HcndJdHQzYmxWWWVu?=
 =?utf-8?B?emRhRzZIR2Zib3M5c003S24rcHZSTk4xWUovOWs0YkRCVFE3dVRtenhPWWE0?=
 =?utf-8?B?ZUVrV2duWlk2dXJzUXppZmkwQmpzSDVoUndiWWp2K3FwYmFjdDNpenlMYnVa?=
 =?utf-8?B?VkhHT1F6elk2ZU1qUG1TWEl3YjdESTBFeEwzYWVrQUVIVjY2dnRsSGEzSHhk?=
 =?utf-8?B?VytQV0xCL0ZGOWVLREZEUzhzT2RzNlZEWGM3YldUT1QzM0IzVEI4c2VERE5T?=
 =?utf-8?B?aVVPNkkyRHRvQkJRLzZmVy9DU0RLYkUxSXhUQnRnWi9rWTU4UVFLcUgyTUx3?=
 =?utf-8?B?d0M2ck1Jcjd0VkRRSzV1dVliOHFWMERTYkJhdXczS29QTnVmYzhGalI0WUx6?=
 =?utf-8?B?T3RkV1NjeU5QVktVckovSDEzN202c3FvMjY0UGVrWG1QTjZYYy82eFNGY250?=
 =?utf-8?B?U29KaHB5RFJFQ0hoQm1MZ09PcDJSaTlackg3K0N0OFdQNWUwVUFEcXJvSjE4?=
 =?utf-8?B?QzJpQnU1d2lmaHJJMVZmYVhtSTdpcTAzYjNCRWNlTjFBdDErcjVOM3pSWDIv?=
 =?utf-8?B?Z1gxbWwwWWd3R0l4Zkl0ZlNNeEJoSkNTZHowRWZIdUsybDBZNy9xeE9BNWRO?=
 =?utf-8?B?d0pyY0FLMnJPR3Z6d2ZmUmF1Q291WjJwcElkU2lMS3dqWDhBcjMxSVUrc1NR?=
 =?utf-8?B?Wk9tVi9UdTNGSVl2Y281cUZZd2MxU0h2empiQXFuaWplQ3cwbWhQMndYdURZ?=
 =?utf-8?B?ZUFrRnNDNEhCd3Q2SURpNFpHZVdDNllUd0h5TEQ5Wllndzdram1zYUdHUllr?=
 =?utf-8?B?ekxrRFJkcHkvcWNhSXBrb3RUU05ma0tRWGdEV3p2cjU1MWNWZGJjajBva0hL?=
 =?utf-8?B?V3hENjhQS1VNSVhFQ0FwM2Nnd2FmWU5SSzdDUlJ6STdZMXRnTjJTNWxtZ0Fh?=
 =?utf-8?Q?JIyjWTRNge6J74CKKyN+eb6b7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ce449-fd0d-40f3-5731-08dd45f5d915
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:00:37.0802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Odw8R9RKyT27tKO5RYCqQnvI918jKwKigvLiKP0HFrnjAurwlpNgAjeV26djrZbMQY88RgAiGogONzBbhZfx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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

--------------tQJWNPGRv3CgCmEAUEQUih96
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 79 ++++++++++++++++++---------
>   1 file changed, 52 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 724f36467b068..f6f4f04d74339 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -510,13 +510,14 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v3_0_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -565,8 +566,11 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
>   		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
>   }
>   
> -static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -661,8 +665,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
> -static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data = 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -712,8 +718,10 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
>   	WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
>   }
>   
> -static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
> @@ -765,8 +773,10 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	/* VCN disable CGC */
> @@ -893,9 +903,12 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
>   	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
> -		uint8_t sram_sel, int inst_idx, uint8_t indirect)
> +static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					   uint8_t sram_sel,
> +					   uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   
>   	/* enable sw clock gating control */
> @@ -949,8 +962,10 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v3_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t data;
>   
>   	/* enable VCN CGC */
> @@ -1009,8 +1024,10 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> @@ -1028,7 +1045,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
> -	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
> +	vcn_v3_0_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -1077,7 +1094,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v3_0_mc_resume_dpg_mode(vinst, indirect);
>   
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
>   		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> @@ -1161,8 +1178,10 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
> +static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> @@ -1175,17 +1194,17 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v3_0_start_dpg_mode(vinst, vinst->indirect_sram);
>   
>   	/* disable VCN power gating */
> -	vcn_v3_0_disable_static_power_gating(adev, i);
> +	vcn_v3_0_disable_static_power_gating(vinst);
>   
>   	/* set VCN status busy */
>   	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>   	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>   
>   	/* SW clock gating */
> -	vcn_v3_0_disable_clock_gating(adev, i);
> +	vcn_v3_0_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> @@ -1238,7 +1257,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
>   		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v3_0_mc_resume(adev, i);
> +	vcn_v3_0_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
> @@ -1555,8 +1574,10 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> @@ -1586,8 +1607,10 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	uint32_t tmp;
>   	int r = 0;
>   
> @@ -1595,7 +1618,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
>   		return 0;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v3_0_stop_dpg_mode(adev, i);
> +		return vcn_v3_0_stop_dpg_mode(vinst);
>   
>   	/* wait for vcn idle */
>   	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> @@ -1646,10 +1669,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
>   	/* apply HW clock gating */
> -	vcn_v3_0_enable_clock_gating(adev, i);
> +	vcn_v3_0_enable_clock_gating(vinst);
>   
>   	/* enable VCN power gating */
> -	vcn_v3_0_enable_static_power_gating(adev, i);
> +	vcn_v3_0_enable_static_power_gating(vinst);
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_vcn(adev, false, i);
> @@ -2159,15 +2182,16 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v3_0_enable_clock_gating(adev, i);
> +			vcn_v3_0_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v3_0_disable_clock_gating(adev, i);
> +			vcn_v3_0_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -2179,6 +2203,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -2194,9 +2219,9 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v3_0_stop(adev, i);
> +		ret = vcn_v3_0_stop(vinst);
>   	else
> -		ret = vcn_v3_0_start(adev, i);
> +		ret = vcn_v3_0_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------tQJWNPGRv3CgCmEAUEQUih96
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-13-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-13-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 79 ++++++++++++++++++---------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 724f36467b068..f6f4f04d74339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -510,13 +510,14 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v3_0_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[inst].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -565,8 +566,11 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 }
 
-static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[inst_idx].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -661,8 +665,10 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 		UVD, inst_idx, mmUVD_GFX10_ADDR_CONFIG), adev-&gt;gfx.config.gb_addr_config, 0, indirect);
 }
 
-static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data = 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -712,8 +718,10 @@ static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int
 	WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN) {
@@ -765,8 +773,10 @@ static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	/* VCN disable CGC */
@@ -893,9 +903,12 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
-		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					   uint8_t sram_sel,
+					   uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -949,8 +962,10 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v3_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t data;
 
 	/* enable VCN CGC */
@@ -1009,8 +1024,10 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1028,7 +1045,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		adev-&gt;vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev-&gt;vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v3_0_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -1077,7 +1094,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v3_0_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -1161,8 +1178,10 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
@@ -1175,17 +1194,17 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v3_0_start_dpg_mode(vinst, vinst-&gt;indirect_sram);
 
 	/* disable VCN power gating */
-	vcn_v3_0_disable_static_power_gating(adev, i);
+	vcn_v3_0_disable_static_power_gating(vinst);
 
 	/* set VCN status busy */
 	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v3_0_disable_clock_gating(adev, i);
+	vcn_v3_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
@@ -1238,7 +1257,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v3_0_mc_resume(adev, i);
+	vcn_v3_0_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
@@ -1555,8 +1574,10 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1586,8 +1607,10 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
+static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	uint32_t tmp;
 	int r = 0;
 
@@ -1595,7 +1618,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 		return 0;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v3_0_stop_dpg_mode(adev, i);
+		return vcn_v3_0_stop_dpg_mode(vinst);
 
 	/* wait for vcn idle */
 	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
@@ -1646,10 +1669,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v3_0_enable_clock_gating(adev, i);
+	vcn_v3_0_enable_clock_gating(vinst);
 
 	/* enable VCN power gating */
-	vcn_v3_0_enable_static_power_gating(adev, i);
+	vcn_v3_0_enable_static_power_gating(vinst);
 
 	if (adev-&gt;pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
@@ -2159,15 +2182,16 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
 		if (enable) {
 			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v3_0_enable_clock_gating(adev, i);
+			vcn_v3_0_enable_clock_gating(vinst);
 		} else {
-			vcn_v3_0_disable_clock_gating(adev, i);
+			vcn_v3_0_disable_clock_gating(vinst);
 		}
 	}
 
@@ -2179,6 +2203,7 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2194,9 +2219,9 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev, i);
+		ret = vcn_v3_0_stop(vinst);
 	else
-		ret = vcn_v3_0_start(adev, i);
+		ret = vcn_v3_0_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------tQJWNPGRv3CgCmEAUEQUih96--
