Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C134C83F09
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 05:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC93D10E581;
	Tue,  8 Jul 2025 05:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpQ90ody";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFCC10E581
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 05:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUbk2jskftr9DWfDsWqfz4dqNVHaMYTurVdYPigZhzS8qDkl2kuT8WCSTv1TEez5qyfjWcOBuBADYec7mfy17Me1hjen1Uk2jilGPRnvLnXP/xqIwjyyn6sFymWBXs8f8nq4AgeG9PA0+mj5zcxQ88kfemOH8Xx8KJu0P9aL1X7XLiQJRGkhxul7nlSHYhaO7mOiA6V7klA+EU+FydxvHYV3FhpvONck5Q9Q5QmGtbmyaTlLJvo5N849D45Fb47ifVr244OMeZa4y8dq/C+0rWCQUhf117qowDAOo41IYyopb0CPuPSobxKP+09xDKdI7m4kRhnO/BjSniISIxXbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4+omke5eC3aYS+D3x0F1lIdJm5h5hrFOvRQShizlXA=;
 b=uvO+pDQLdsiUAFwY644Yc/+igTDcu/B+5ZLTh85DxPmlxiz8C0PtvSUTuX51y7UiWPuiGuN1CjF3zB4u2H27c8uayQnQjr+TUZADlILn/pfNYgok871QiT+Hn9fyeDVFohKnne2JOk+utaByrYYCwVqDlP8+jgvPpOCzI9X8MjjZu/T3N/ybqmK1jxNha3OLa56uBNK5VT3TqMbMUYbTOZ4s8lybyNTRjVw7e6l11mPIAOAN4+xOQPlVE4MzYaChayfRu2b8J1w2WEn5BT+r/+nGRPSJYuF+NV0MUaKl8/DlngSgqI6j6BNKCXJc/l1zM0hp2vYeUpo+OZdLp7m4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4+omke5eC3aYS+D3x0F1lIdJm5h5hrFOvRQShizlXA=;
 b=OpQ90odyuk5D204CBYNozPADWj4fVOvxAiL1e/fEQo24a3aiPgf4gaUydVK8Yrdi2z6uSYfro3+1aPWK+PV67oj/AHwfNmqPstV4GDwuz8+JfVmmEJ8IwzEnXFa8Wgkya5g45wOmGeBfKVEIc/m9lXI53DtrqTNP+5CQRIWKi4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 05:01:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Tue, 8 Jul 2025
 05:01:26 +0000
Message-ID: <2aeaf60a-58b2-44c3-a127-db26d13beb68@amd.com>
Date: Tue, 8 Jul 2025 10:31:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use cached partition mode, if valid
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20250705042435.1359695-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250705042435.1359695-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee859c7-a86a-4daa-2aca-08ddbddc7d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aklCbVNadmkwM3VTVzBGcEtmTkd5NFA3a1d2UzlpN1pON3hvUE8xOTAvNXZt?=
 =?utf-8?B?czRLb3Bhdzh6Qkl2cnUxcXpBczBSVzQwenZRdnhyS0FTeVAvY2dxWVZlMjR2?=
 =?utf-8?B?ZFZ6VjJEN1JjdExNMDJYaGRvdzY5eGd4eWUyaUttUm9qWEx6QkpETDliSmNr?=
 =?utf-8?B?aytQRjVSQzNjb2VMOWZ2ZWw0WVRDZ2lhK0RPVEI3V0NlcG9WMXJKVFo0MGpx?=
 =?utf-8?B?ZXZFUzZRTW5nZVJrMkp6dzBlMzV6a3VyOVdmMmhzaUEzb3pWZVVKajBFQmtZ?=
 =?utf-8?B?NTJ5K1dHTEpJRGZYWnNlM05ZVzJEL3dVQjB3VEdaL0QxbGk4L3ZpeFdSYngr?=
 =?utf-8?B?c0g5OUlsSVhnS21la09kSkIrT0tRQmhKbSt1dXBpUTMyU05HcCsrb0szSXVG?=
 =?utf-8?B?RnVNVFY0NHFobHUyZVg0ckRUSGVXRTRCV25BOTJBVVB3Y1RObXFQSUVxcnJh?=
 =?utf-8?B?THcrdnk5U21LRnBoZkF5NjNaaFFZSlMraTU5VWF4SU4zcUI5RDhnVHh4bnpS?=
 =?utf-8?B?MHpPVXNFeFNlckZLdXM4Nk94Y0gyWTZiSnExZ0wwSUozOUJLUU0zaytSKzhw?=
 =?utf-8?B?b0lQNWZYbytGN0M1RFpIUWZvMHpucUx6eUlvSXYwMDBVOW5IR21Hb1U5VFE5?=
 =?utf-8?B?VzZIQmU4cnNsU3BKNDRkNWpzQjFhdVJleEF6L3RsY3BFMGR4R1RNR0xqQjZs?=
 =?utf-8?B?bkVlSEFTdnRkdWR5alIvY0RhWlVwbEx0c0p2c2liWUlmSDFLbytvVStIU2dB?=
 =?utf-8?B?bW9yR0p3WDNoVXBzMU1SZUREQjhFc1JjajVZL2Z3ZGJlMUhicGtIcTZab3pQ?=
 =?utf-8?B?Wk5JNmljeVp0QTJ4S21JMGM0OWNpemM2Rm9XMmRPR3J6T0hnUlpHZitTUjNJ?=
 =?utf-8?B?dGsxVU9PT3FzNnhRNUdzeDV4Q1UyWVJKcll5c3Y4YUlZSXdjcFVRKzFNNkVC?=
 =?utf-8?B?T1NkeCtpV3RhZk9yTEl3N0xlREdSSnZwM1RUQVV4NUR6bDN0bFREQ2V3aHky?=
 =?utf-8?B?N3NHVUkrUGNzOGtFUzJ4UHBkOFNZTmcwMTVLbTV4YUJ2bzdLZTcwdEVrbTQw?=
 =?utf-8?B?MVFJYVFmZ2k2eHVoVUJkNnhjM2hKcHpiWFFac2lUSGxUY3J0RXZCVTlGUWFu?=
 =?utf-8?B?b3pxWjB3c25ZYVoyZDVqMSs1dHpjUlFnNFdqR0Y0Y3BReDB5ZmVyb1p0bUJD?=
 =?utf-8?B?bFY2RFByR0kzUWFrMzh0bDhVYmY5ejUyZys2dC9yL2p6a2RUZlFNbVNOVlFR?=
 =?utf-8?B?cExwdklxbzdSK0ROQk00ZncyWTdidjhhYzlrdUZDajNjc1krcmNpekRCM1Y5?=
 =?utf-8?B?YU5heDRjY1o3eWlhVm4zekRjeXBtQURRdjFIRlo0WWQ2QnQwb0pxVnFMOE56?=
 =?utf-8?B?eEJzNFBrK0JZRUJzS0xlc0hxRWJRb2tJemFwNDhpcmxlWVg5ZlNqK1lkWDJH?=
 =?utf-8?B?UkNLSW5NeFNrMzd3cWRiL0ltTUt3bUpicFZNV21wa29lN3hIM215WFRybzRS?=
 =?utf-8?B?U3IrZ2NtdnRTbVBoTXV4eGVmZkc3N0RxSEdCTWEvdFJ3Sk9mZzFlN3VYbUdk?=
 =?utf-8?B?ZHVteEVxSVlXOWNHdElwbWVXVkU2cG8vNVJVWEpsRm9RT2JWWkRKQUFPZm1B?=
 =?utf-8?B?c3lsYXhpUzNwZHZIRHZJUnBrRFBHc3NvRUZXcExWbTVzM0R6Z2RPRmM4LzM5?=
 =?utf-8?B?cDl2c24vR1EwUHN1SlBBRHByN1htVzVBTlNQT2ZXa3Fuek5nN25FekEvdzAz?=
 =?utf-8?B?eFdCVWVEMlRpaGlPeWkvdVhyQmd0N3E3SC9TUG9GUEtLNDhSdzV4VUhFdFlP?=
 =?utf-8?B?SmFpSlMzSkRJTStSbDFHMnJPcGpyR1JQVHN4NlpqeEV4cm90b2NGQWgyQmFt?=
 =?utf-8?B?U2d4MWlZUnA5S2F5M3Q2WTFDbzBWSHVuYnVPQlJFdVF6emJzSnJVbThvcXVN?=
 =?utf-8?Q?WdavhfDoGGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFJyV3Y3RWZVWXowOVZ5VkIwUHNveThZbDI2b2lhcElqRWkwZWFBd1loeFFO?=
 =?utf-8?B?RWVWd3dyVzkxMFhaWW9QalJ5UkVyS01Pb05tT2ZDMkgrQnI4d1B3WjRaQlM4?=
 =?utf-8?B?clZZTDQrWVkwTzNXclBDUkg3RGl2UkQwMWpXRVBsc2cvRWplZlpwQXpOd1ox?=
 =?utf-8?B?K1g5dDFtREZPZ09jVDZzc3RVZDN1QVR1MGRma05UaFlYL2E4ZFAyeVhac2tB?=
 =?utf-8?B?dXc5TC9MYU45Ymwyck9vbm9SZUxLc25ibExiWDZvaUROekNCRXc0QUw0MSt1?=
 =?utf-8?B?bkFWSS9uRitJVHQwK0ZoQ2drMlhGMktZNHZqVDd6bDJ6OFVEL3B5T1FHZEVC?=
 =?utf-8?B?WUM5a1AyYXdVZjJsazZ4dVB6L1o0ZVdWWU5EcWl2WWozZ2pNVU1kMkdQdHBZ?=
 =?utf-8?B?MXQ2QWlOWVR5UVlXc3Fob3REdC9aUkt0OVgrQTA0ajJFOEhRVHpRWkRBVWw5?=
 =?utf-8?B?U0tUaXNjYU84N2l4SFZnUllxdG5KYlQ1THJ3N0J2S3ZZTnF3RWFTQkxERGhG?=
 =?utf-8?B?Vnd6Yk5RMml0UWtEVWRsWUE3WUdDeXhkekJYN3FzemE1ZlVPdGhkTUk5K2l6?=
 =?utf-8?B?bTVqQUExQmVKbjhUcTRhZVdMRnZVdXltV3V2L2huUXdtS2hjSkJMN0t1Nkpm?=
 =?utf-8?B?emlPT0hRMlVoMHJZRVRuVlRlVXM3VnByT3JwdW1UQm9pSnJ5a3Y3S0c4dnJP?=
 =?utf-8?B?Vk5OK2ZjQ1MzcnZkb3hIWHU0b3hIcm51S1YyazgrTW5lZkxwQXZzWXdZek9q?=
 =?utf-8?B?ZHNoa3dRMFRHRlFXeUxkenJpTUEza0VTQjA1THp5NENtd3lBSHVhMkMySFRC?=
 =?utf-8?B?d1dITnp6NmtQTzMzN2lOS3RXSDB4OWRpbDV4V2Q3QUFWSHdoWVVKeS9LcFQ2?=
 =?utf-8?B?bS82N25HbUdpR2oxRXBieDNxT3VBTTRXWXlsMlI0dnc4SmJMQk9KNmNKU1hz?=
 =?utf-8?B?dkxuaS9BR3hNU3EvMVYvVlRPYmRRRXBSdERMWFBLbml3RllVVFZvY0x2eSt0?=
 =?utf-8?B?eVZOUi9INlNISmppaXlIS3d5bE9vT3hhdEVhUENJeFNEOWtJK3lPTk9iaVFh?=
 =?utf-8?B?SldSSXZ4UnJCbEJnYjk3WjFQaFgrYXZ4dUthRXljY012NGthNHBGaXR0eExy?=
 =?utf-8?B?cVVZYjBXN1F4VFAyOU14M3VQemM5VUIwcnh3UklZc1ZIS3k5K1J5V0wrNVNC?=
 =?utf-8?B?bFhlZldEeVhCamlCL2xFQ2pTSVdJN083MnNxbVFDdk9ocUpGZHRnNk9IL2ZY?=
 =?utf-8?B?RHJBZU10bFhIWkhYcnpuSHZtRjZvdnQrU1NERFROb21UYTFCVXN2eHJnUFIx?=
 =?utf-8?B?UzB4NnJDTGtUSzlhQU5Yb0dzYkFVc0ZQSzhyZW5HY0RpNVdhR0tRUUxFekVV?=
 =?utf-8?B?WDB5ZEtpS2FnNU42Ry95ZWE1bjlJVE8wWHoybkFoWDZ6UjFueDdjQ0pRU29i?=
 =?utf-8?B?K1ZZeW1NRGI5TkFKRUF5RW1pYWtmdWN3NTdvaG00TlpoRjhOMHZjaHIrRTBw?=
 =?utf-8?B?b0FBM1pudmw0VUxjVGtMMld2SmNKc3Nsa2RtdlV6R1VoL1lOdkZySzJibGVC?=
 =?utf-8?B?SUlzZDZhQkYrSTlaWWI3THcrNGpwZElzYko2U21jVEFYSmZkMkllYUsvcFJy?=
 =?utf-8?B?TSsySklKOHBYMlJtb21DWG03WCtNNWZXSXBFRU52V1JDL1VaWnVkcTNoQjJG?=
 =?utf-8?B?K1pCZUZPRjFMWE93R2xHNXp1K09SQUdvU3Q5a3htNmVqaC9KVVFwTmRBdnVL?=
 =?utf-8?B?cUVzNkk0UjNNVDVTYmRrT1JJam1NWnlQaE0yWU9DUm9TOFEra0xmTVZKbUpJ?=
 =?utf-8?B?N1pCdjBlUTRqVkRnY1hLTmpJTG9VTTVKWEVlSFVkajZjU3VxQW1lUjRiVHpw?=
 =?utf-8?B?UUplN2JwdWRmNDI1NTFoNFdqVVNXbzcxOW1WN1o4SXV0UEdWUmltMG1hVFJE?=
 =?utf-8?B?RnlPZUs1ZWd4T2hSUEszRWFuOEFROEJSMWhnS2lMQlJwRGxWVUNhZXFkOVRu?=
 =?utf-8?B?VzZiaEJtM1ZraHZjdWtQRDJsSytWV2pBaXdtdldYbktXOW5SdE9JWUVWNEFk?=
 =?utf-8?B?Z2kxOTd4STJaTkI5M0daaEVZWjhQcnJ1ZDZoUFYwVTgvbitXNytvd1dmNVZI?=
 =?utf-8?Q?dDUq/0LyJwMhV/yvopAxm4PKS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee859c7-a86a-4daa-2aca-08ddbddc7d93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 05:01:25.8940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6YO9LTm6FyXHbZ1PaWwhwYyU1NosQDurHlVYcQdtu5EykqhwQIpLiUKMXD9NuSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

<Ping>

On 7/5/2025 9:54 AM, Lijo Lazar wrote:
> For current partition mode queries, return the mode cached in partition
> manager whenever it's valid.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index c8fcafeb6864..c417f8689220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -218,15 +218,27 @@ int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
>  	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode);
>  }
>  
> -int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
> +static bool __amdgpu_xcp_is_cached_mode_valid(struct amdgpu_xcp_mgr *xcp_mgr)
>  {
> -	int mode;
> +	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
> +		return true;
>  
>  	if (!amdgpu_sriov_vf(xcp_mgr->adev) &&
>  	    xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
> -		return xcp_mgr->mode;
> +		return true;
>  
> -	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
> +	if (xcp_mgr->mode != AMDGPU_XCP_MODE_NONE &&
> +	    xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS)
> +		return true;
> +
> +	return false;
> +}
> +
> +int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
> +{
> +	int mode;
> +
> +	if (__amdgpu_xcp_is_cached_mode_valid(xcp_mgr))
>  		return xcp_mgr->mode;
>  
>  	if (!(flags & AMDGPU_XCP_FL_LOCKED))

