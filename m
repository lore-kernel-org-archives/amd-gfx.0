Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27222C02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E01F10E7E3;
	Wed,  5 Feb 2025 15:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c6lO9AZ8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918A810E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUuur9mJtlsUyas7X9pLf0HT02W7CIT2vf8C+tr5UdXt8A8jiyZPXDD//+qN+RF8H0YM4/zKBXRRK9ulqsaM4M9M0YLwiCNBKXT3w1UsMRxLcro1/ydkRK6/vdLA3TwximmZRdOoLTg9AQ+m/5SeGU7E93LFzdemnpMQOWhnSClgcP4UOxwH3zjn1Mygmy3TLznY8yvoO4iQHG6XEm0iEvwyEOjiu2x/pz0KAbGnGQXL5G58543OoICYcnRP244DWlHVhtpQYKAZneuzvmyPJMAGmRLC13RwoiXZeeCuTe5CNaBJ6wSYA+I7ga0JuUY2OnCCgPz2esYJfIKuM/Qigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEvwZA8Iyahl4Uy5VBFQYVlgs28uJUgXIQZ/qGs7LYU=;
 b=zA77IRU/Z1eKPJNNOnsJcyTBzidcPWHSD72I601LkhFIPLryjjL+v8owhBJGlC1muOlVbBiYxasBQzDvS5FaW+sD6RHe/V8qBXzRJfU4M3LmMFnkrjsFk2fK+LTysOOnR7fIlOH9gGRXLUEsVgXYI7tr7efMwSNYJCcj23lUfM/Ex+WBowwY8kqkssJNbGMhf1sT1svAWsBGtO4wguQlVVgoYFM27IK8YUk69jgDfhWDA3qFmy8NHvwCcauPUFg4QM4xAJW97fatVGdgoap6XW9eOHHxmO9fAyHcOjGq1ATmmXfVObr0D42waYDazkgWte6YxNstnZ8fgrDCcgpnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEvwZA8Iyahl4Uy5VBFQYVlgs28uJUgXIQZ/qGs7LYU=;
 b=c6lO9AZ88Mmun7Gs60IJGCVY7KzAR3LJxC/gKq7AcgRL837uoLE/fhi7SUHsa9j8M2iegLYA7B5nguVH5J3NPFtf2i4kGLeYQ5lsQuKE7QetPYm0ELgpoKCEnxq4PpFhTtMM4TUaYxBBgO2MEtKMl8FOMRILy3mczmOQeuG0vNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:05:24 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:05:23 +0000
Content-Type: multipart/alternative;
 boundary="------------inBVmt3usazKebOTtXe47Wxe"
Message-ID: <83cde842-6cd3-49d0-9ac7-a211d40e4a2a@amd.com>
Date: Wed, 5 Feb 2025 10:05:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/44] drm/amdgpu/vcn5.0.1: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-21-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-21-alexander.deucher@amd.com>
X-ClientProxiedBy: YQXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::30) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaa1940-ce32-407d-1524-08dd45f68427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmF3eG1xNUpDeFNHQU9LZTRjdVBZSVlvc2pKUGxGWDNPTW15TzQ3eVZVWnhW?=
 =?utf-8?B?NVFUbko4dW1MWUFWVE1xK1N6V3RkVThjTU55OUNUd3lObEdiMG1oYmRDY2tJ?=
 =?utf-8?B?ZGkySkpVSUNWZjVPcDR0VlE1clR4S0JvYkRVc2VuZ2NTRkVGazdHQmh1Z2F4?=
 =?utf-8?B?TGR1SGlLME02THVkclFyVUh1MjJCNzl2K0dXY3d2VGt0SFUxWDdFaFJma3Rm?=
 =?utf-8?B?NXhRTHFSRHV2bnNZcnltNW9uUzBSMm1iS0pWYXA3ZjJCVkpMNE5rbVRIQUtB?=
 =?utf-8?B?OHprdGxvT3VyTnF0SHNrcXdMajJUdEtieUNLeVl3aWluNzhRYlF2V2J1Q3VR?=
 =?utf-8?B?ZWtSOHFBN05pRkcvUVA3VGZRMjIrRDJsN2tEL1R1UzUzdkFjMzhvZkhRZEdn?=
 =?utf-8?B?dkVnbCs5VllJZ3BYZXdUcjY4MVB5MVZ6bUMvajViZS9qSE51OUUrZUxNZVZx?=
 =?utf-8?B?MEp2VlFYRnIyVUhrMlE0N0pzNkpQMVYzUlZGT2ZKRWxGbnRvSU1YbUtrb3pE?=
 =?utf-8?B?YlFxeTR5c0tNM3ZuQVdqRkE3dEhHYXppU3dQa1FYTGt6Z0RQaDArRmkvckhS?=
 =?utf-8?B?NFlGcFk2cThsa1BGSEI1My9UVlhZMjN0OGhxbVBMKzdtSWprNVJZQm1SZ3F3?=
 =?utf-8?B?NEppOWJBeldEL1huUklZc3UxdGRyRWg2T2lGcDJjaVhqYlJQUmkwdnR3cE1F?=
 =?utf-8?B?cDFNS0xoeGtSUUdxR2RYN2Z0N1ZHaDZHb2ppUDVDUTRaOURXRmZxL0xVOHZI?=
 =?utf-8?B?QlZDYklSSFFIN3pteHpQL3kvNGpuMW9Bd2ZsUHdKT2pRMGhzQ2V4dkJxUy9B?=
 =?utf-8?B?TFc3VFZXQkxDSkJBVHMvdUpPbVR4YkQxWTlhdXdLcDdiZEIvMjJRUkhaUGpq?=
 =?utf-8?B?bE91TGg2U3hUdk94VmZsOVVsVXVrd0JVZ1A0VXJTcENvL0tESDBpaFg3b2Ez?=
 =?utf-8?B?bnVIWU42YjcvVll1eERtL2ZINTJITlV2SHBaQ0g3QUU5S0w1Tkt1SFYrdWli?=
 =?utf-8?B?WEZrbFhrWUpVZDJnTzNPSEh0N3RTNmZZRlZ4eDdtUm96bnJRdTcvRnJESFE3?=
 =?utf-8?B?RzRjckJDTEtMbEFQaGtEVkNoWWwyR2UwV0R6NXZlblJENDFBYjl4WTB4ZEVH?=
 =?utf-8?B?dzg4VmIwV3VrV0ZBSG9qUFVyZGVySkUrcUM2ajVwMWE1YWlhMVBEajlOclRJ?=
 =?utf-8?B?VThBYlVodlEwaGJNWWxBM01IeU1UT0Z2alpyak1hTzRSZytZQ2g0a3JxWi9J?=
 =?utf-8?B?TURoV1RhZE1xUGxhaHc1R1VmUDJvNERabzR4SzhFWEtMZTJyMWIwMytWUlRO?=
 =?utf-8?B?eUszNkw1RlpJRW52S0IzUWNjYmh6WFRYRU95VFdsQUk2RHN5OXJ5Qkg0aldX?=
 =?utf-8?B?Qm5DQnk5TGJFNmtUNXdpUEVmRzJrQ0ZTOXpCN1RqVFYxbXM2ejJaTExiVUl4?=
 =?utf-8?B?VlJrQ2NnSnB5UW9YTFlka3pyOExseDhtTXlwdXg2UG5XVExjeUdMN3ZJY0lC?=
 =?utf-8?B?cjJESi9JMnFrWklUQ2Ywd2duTW5oMjhFOUNuMjEvT0VqWVV6cDQ5ZEUyc3JD?=
 =?utf-8?B?NC85ckorMGQ1VnFjaTVPU3ErWWlCVFJDckNFT1gwc1dWYkhTbjcwL0N3aWtI?=
 =?utf-8?B?N2FKNnVaSmNlcTJUQU80WDFPalg2SXBEdlRWM0RXelc2YWFRSlkwbGR3K29x?=
 =?utf-8?B?V3pQUDJsV2Z6RFFuQUZTUFdBa0ZEQUJHbE50RnBJZFlneW9Eam5iaVdhYVlO?=
 =?utf-8?B?Zi9WMmFnWitVZ3lSMlE5dEpUN0JONWdtSVRTMXgrM3ZZZWxnK2VxYW15STd0?=
 =?utf-8?B?cHhEVGRqNi91S0NDT0kwK0loTWZyMGhrd3pZQUx0dmZqQzJ6U3pqamlkNTZl?=
 =?utf-8?Q?/tAJ2eE4xt8bl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FPaFFQeUpBTERSOXc3M3FPQ0QwVVg4VVp4bklKZGpNT3hLV3BqRGJmeEVv?=
 =?utf-8?B?OXI3VVhHOWk5clhJQnJSMFJYdlhtNHFxazZwSjJTVHRiZkF4OFZaTCthdnN4?=
 =?utf-8?B?SlFNZ2FRTkF5ZG9wdU10eEFLeU9aZ01vek5DMHRkYjlGdVJlZnZZU1BoWG1n?=
 =?utf-8?B?SmkvajRiSU1DL3dldTRkQWdBUTBwUlJwTVF3TTJQRHo3d0dRT1ArODNhWm1i?=
 =?utf-8?B?MlNTdTVqaEI0U1crS1phT2JaUFU3WDRzY1dId0hkTmx6SjFaSmt1ZWZoSHBU?=
 =?utf-8?B?WGpRUVVQL1ZWZ2xYNGJRNHdNaS9KQnZTUGpxVjlhRk9ZenFkYTcrNU0xdkRy?=
 =?utf-8?B?VDM4WExRV2czNXBDQm5MVE0zM3dKQjhGaGZkVjROMTUxZDBISENoMm00TXF0?=
 =?utf-8?B?Q2dQdzBRSDIvQmJaTkRoTlBYQ0VHaHFPVnBxQUFER25Eand4M1ZTOUVyL1V5?=
 =?utf-8?B?SFdPRmdZUWZIQm94aStYeXFMNGpCc3pHUGhZMzhiMVZmL3ZldzF5MnZGVHZF?=
 =?utf-8?B?YTNZT0JySXoxY1I2SGhUbkNEbTZOckdDZ0tsYWJJbDhIUWhveEt6OUQ5N2p5?=
 =?utf-8?B?cCt2YzZTVWgvYnNWTjlQdVB1WkNUWkswNnNLdXdrOXRqQVFZT2tadzNVeUJS?=
 =?utf-8?B?cjlJUUNHQ0RnUFNUOEpXOG5aQjJic2NTTTVvYTFFc3lxb21MdUx6NzNCam5r?=
 =?utf-8?B?RXpNN2hiWklFdTAwZ2JaWDU2ZG9rTWFNRmhBNjVNbGIvU0lPdHJqTDhWWXpi?=
 =?utf-8?B?eEZNSlBnYm1TWmlOSFZYa2xsMFF5TURnVGNGdGFzWVZWbC9yL2V2STE3aEJr?=
 =?utf-8?B?azV3SHpLSDM1TnFjMmFOQjNubmV4Y0MwVHgyMEptNU9xdGVFYnUvV0ZYMDhD?=
 =?utf-8?B?NzRjWkVLTW9kSWE4Y0VhM3FURVE5eGh5VUM1WFI3ZDU0ZmpQZlBURCtFSkFY?=
 =?utf-8?B?Ry9iWmFRTkV5OU9ZdFNEelduWFh1WFJhbGpTakxEcHpsRldlOXFnTHJRMU1F?=
 =?utf-8?B?V21xMDFJTE41RjByLzVxSmJvT0FkYkJsREdIcTJkTUc3V2Q4T0orMjhGVUdr?=
 =?utf-8?B?bzgyb1dWZ1R3NjRVSG5pZ3FJS1J0aEdXeVZycGo0dWZtU1lWVXJMS2JaN1R6?=
 =?utf-8?B?S2l2ejJlaHJaWkRiampRVEFGVGFNNGZDL1c2N1ZHanZteHQreFRQVHl4SGN5?=
 =?utf-8?B?ZzNpWjk5NmdLOWh5UCtGL2poWk1tZFNzZnVQVjNyanlwSG5ZWmQxYlhyQlBT?=
 =?utf-8?B?Z2wrWlNGNUlRemg3V1g1U0I1V0pWNGM5V2dOdVFGWTcwampDS1h4R3A4RUor?=
 =?utf-8?B?OExRK2pwOTlzWFVydTNZWlNpVVFLTGZld2E3VmQ1YXhaN0k1SDZCSHBqN2ZB?=
 =?utf-8?B?SkNHV1o2dEp0RHhrMmtyaTkxM3lXaVNEVW81VFRzbzBtOThQV3BCVkU5alR0?=
 =?utf-8?B?bmc4RnltK2FnSFJMcTA0Rm84cVRFNlVXcUNRWUJaTzhCTm5iYWMveUVIWWd4?=
 =?utf-8?B?OUovY3phR1RHR0owOUF0NXQrQTljSUlKYzc0WGkremtxREdBaG1lSFlpTnNk?=
 =?utf-8?B?MUFYbmloRjhoWEFnQlYwSmRvUVJ2SVhqaGZEampxeU5MbmdGVktuYU1QOEpW?=
 =?utf-8?B?bjh5T0VkR3lUQ2JkRnJCQmJmMW5YTmR0THd4VkJsZm1pWWlERHhnaXpOUGNm?=
 =?utf-8?B?RGp1ZEJuWmtxZ1c0S1RibW54MGNyL20vVVZMdkY1bElXWndPMnRVOWhQMDZw?=
 =?utf-8?B?OHJ5TE12RFhBMEZvNU1jazFwN0xnbG5jeFF0cFBGOWVpYUtwSGgvWDgyK1BS?=
 =?utf-8?B?MGJBb2V6MVpwT0NVeG9aVXNpK3FwNHFCSUxWaERZOThFM0lCREJnRGExMGdj?=
 =?utf-8?B?U2xMNGtTakhZaXJTT1VCME9HOUYzMUwxT3FRRzdsSWhlMVJxNmdkSDFmTzAw?=
 =?utf-8?B?RHFmRytVZlNpcHVySW9NSXhOUTIwMzMyMWJFMVZWSTNFYXNIRFMwT09Qdjln?=
 =?utf-8?B?STd5Tis3YXI2STlWNGl3d1JWTm52bkhjK1FmYmF1QTNFQjMrTzJJWUVLZFpY?=
 =?utf-8?B?MjRQblBWZmxNT0NYWllEaUErUElpMExITkJ5UDRNdUI0Z2I0UGFkSVYyWlhB?=
 =?utf-8?Q?1A4G2E3y/myNxSR0laaoaWvow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaa1940-ce32-407d-1524-08dd45f68427
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:05:23.9073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9chZY89RBE1/I4K2VxXz4no0YCGjaYNFLC3I7BcgiuT8sFkZstbyZXzYRAh20D0tr0/sXtQsd0nRzgHyajJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

--------------inBVmt3usazKebOTtXe47Wxe
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
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 71 ++++++++++++++-----------
>   1 file changed, 41 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index f49fdf2bb6e33..8eccb45b04d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -282,13 +282,14 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v5_0_1_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst = vinst->inst;
>   	uint32_t offset, size, vcn_inst;
>   	const struct common_firmware_header *hdr;
>   
> @@ -344,14 +345,16 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
>   /**
>    * vcn_v5_0_1_mc_resume_dpg_mode - memory controller programming for dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Let the VCN memory controller know it's offsets with dpg mode
>    */
> -static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					  bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -456,38 +459,38 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
>   /**
>    * vcn_v5_0_1_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
>   }
>   
>   /**
>    * vcn_v5_0_1_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst: instance number
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_device *adev, int inst)
> +static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
>   }
>   
>   /**
>    * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Start VCN block with dpg mode
>    */
> -static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
>   		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
> @@ -535,7 +538,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
>   		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
>   
> -	vcn_v5_0_1_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v5_0_1_mc_resume_dpg_mode(vinst, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
> @@ -589,12 +592,14 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   /**
>    * vcn_v5_0_1_start - VCN start
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Start VCN block
>    */
> -static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
> +static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> @@ -606,7 +611,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	vcn_inst = GET_INST(VCN, i);
>   
> @@ -639,7 +644,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
>   		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>   		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>   
> -	vcn_v5_0_1_mc_resume(adev, i);
> +	vcn_v5_0_1_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> @@ -739,13 +744,14 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
>   /**
>    * vcn_v5_0_1_stop_dpg_mode - VCN stop with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    *
>    * Stop VCN block with dpg mode
>    */
> -static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   	int vcn_inst;
>   
> @@ -767,12 +773,14 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v5_0_1_stop - VCN stop
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Stop VCN block
>    */
> -static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	uint32_t tmp;
>   	int r = 0, vcn_inst;
> @@ -783,7 +791,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
>   	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v5_0_1_stop_dpg_mode(adev, i);
> +		vcn_v5_0_1_stop_dpg_mode(vinst);
>   		return 0;
>   	}
>   
> @@ -1005,12 +1013,14 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v5_0_1_enable_clock_gating(adev, i);
> +			vcn_v5_0_1_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v5_0_1_disable_clock_gating(adev, i);
> +			vcn_v5_0_1_disable_clock_gating(vinst);
>   		}
>   	}
>   
> @@ -1022,15 +1032,16 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_1_stop(adev, i);
> +		ret = vcn_v5_0_1_stop(vinst);
>   	else
> -		ret = vcn_v5_0_1_start(adev, i);
> +		ret = vcn_v5_0_1_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------inBVmt3usazKebOTtXe47Wxe
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
    <blockquote type="cite" cite="mid:20250131165741.1798488-21-alexander.deucher@amd.com">
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
    <blockquote type="cite" cite="mid:20250131165741.1798488-21-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 71 ++++++++++++++-----------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index f49fdf2bb6e33..8eccb45b04d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -282,13 +282,14 @@ static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_1_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst = vinst-&gt;inst;
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
@@ -344,14 +345,16 @@ static void vcn_v5_0_1_mc_resume(struct amdgpu_device *adev, int inst)
 /**
  * vcn_v5_0_1_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -456,38 +459,38 @@ static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v5_0_1_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
 /**
  * vcn_v5_0_1_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_device *adev, int inst)
+static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
 }
 
 /**
  * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
 		adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -535,7 +538,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
 		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
 
-	vcn_v5_0_1_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v5_0_1_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -589,12 +592,14 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 /**
  * vcn_v5_0_1_start - VCN start
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
@@ -606,7 +611,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v5_0_1_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v5_0_1_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 
@@ -639,7 +644,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
-	vcn_v5_0_1_mc_resume(adev, i);
+	vcn_v5_0_1_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
@@ -739,13 +744,14 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v5_0_1_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 	int vcn_inst;
 
@@ -767,12 +773,14 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v5_0_1_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
+static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
 	int r = 0, vcn_inst;
@@ -783,7 +791,7 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev, int i)
 	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v5_0_1_stop_dpg_mode(adev, i);
+		vcn_v5_0_1_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1005,12 +1013,14 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (enable) {
 			if (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v5_0_1_enable_clock_gating(adev, i);
+			vcn_v5_0_1_enable_clock_gating(vinst);
 		} else {
-			vcn_v5_0_1_disable_clock_gating(adev, i);
+			vcn_v5_0_1_disable_clock_gating(vinst);
 		}
 	}
 
@@ -1022,15 +1032,16 @@ static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_1_stop(adev, i);
+		ret = vcn_v5_0_1_stop(vinst);
 	else
-		ret = vcn_v5_0_1_start(adev, i);
+		ret = vcn_v5_0_1_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------inBVmt3usazKebOTtXe47Wxe--
