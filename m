Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B2DEEE270
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 23:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8000D10EC7E;
	Thu, 12 Sep 2024 23:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPYuDG/H";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6322C10EC7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 23:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3dRy56P4MvuNPqkRfIun/5Na5gbusWPltxeMNeRHT0aw2BbJACz9X7+2GEs/2aXaekb1UCn8nC8FWYgUZ+QVG4fD13fd8ial8XsUPllD/TTiTekyy5tpkTduNpst4fPTk8wBrCx3YQLn8MEemMLPZdc6pa4CT0lpfUBjfsjbfvXTotwUxQYAUXHu8yaBDeB2TerZsQLpkCxsuberYm+aF3bubnBSm68KhDB8LkOBTfEcnzbj5R9cXaeA5y6TNGumakhoJJvGYuUpkfY5lAxDthtJmJStUdURKAaIRdsGOyaOF4dftot9fXWJv40QX6LKvEJ86UT9PwrgXUnjQYd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbIxiMXOQOCl6wqsh/N9JqLf0fgVc2iDp+vEOf6TXk=;
 b=ddqBTAw0p9xTBs7JAABiwoCQBYjjsamKh7JuiHoIc6BQ3fqF2IfCq58UupcCMx/Dua7+EebKvRsONHAwedwKVUogTEslku3rKXJIrayQS4laF2A3VLQSI6oAqtST0b85766Pb6+y6V5Hh8jqponYyDNx6k8ToFrE9Bt1Kse2O21sH79518pbJhT39Z2Z6YuKK74wP+Ad7xH42srv6tgW9AO+2GB37iypOtfPikx4kMO0XFXhHckt3AtGmJfY/kGKtinZhPIZcJ6CzkyAwumxBLb+Ii+EMeFxK7Kg50OCSxbtvOBGUZQGzaP0sWXRYp09hfzX4ucoepg2bihSlfWb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbIxiMXOQOCl6wqsh/N9JqLf0fgVc2iDp+vEOf6TXk=;
 b=pPYuDG/HzaEAwY0L2fsHKEYFTm7HcqeaZIzjDuy2t4D+sVkGZGVsHk7IbgaxaxXqoeSt8jNqnuRIFgjyxJnnwDhHzO8UpEWw86Cg1/lz65DH5OTMrOnuC7jetQTHOVi9G+lqzxMZkFjbjclQvEWXhWPaJcTi1Lh5UPHhJMR3yQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 12 Sep
 2024 23:34:57 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%6]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 23:34:57 +0000
Message-ID: <bfaf653d-cd8f-44ca-a0af-858c8360ef85@amd.com>
Date: Thu, 12 Sep 2024 19:34:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9.4.3: Explicitly halt MEC before init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240912232924.2489214-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20240912232924.2489214-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::16) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf8c6d8-053e-4b7f-56df-08dcd383830d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXpOeVJDT0NYQURkeFlVVzRodGVvNDBqUnAyUnkvNlA2RmFyd3dGOHBWY1VW?=
 =?utf-8?B?YU9ndGpheGdwUFZGWGFDTlhlTFhVLy9aSVRCOFc0TmpTbnVJdGhpb1VEMTRr?=
 =?utf-8?B?WERSMzNYNU9GMkMybHZ3NG9rTEMweHNNTzlCMzgzeWpVRTdKZFdvSUp5aUg2?=
 =?utf-8?B?S0wrdnhlcVczOVBqV1MxVExaYzhndXZ4b1FzaVMyQVNOaVJiRHBQNm1zVHNp?=
 =?utf-8?B?T1ErRC9RSHdVa2NsMGRyMG9sajg2RGc0VGFZVy9jdHhDcDJ1NGQ3N25nY0hK?=
 =?utf-8?B?UnBQN1BCVklrUUU5M3F5dmY0Y0dNYWNKT1IzSFZlMG1nd04wL3VGNEFVSmU1?=
 =?utf-8?B?Z0VIQ09keDBOVENpVGdZSHVvK293aHRXQ1oxelRGRlBjQU5zNVBiR3BuVjNX?=
 =?utf-8?B?aEFBazFrRExtOUN0d2RWbHdoVkQza1BJamt0blhidGdNV29RRDA4SnF0MUtO?=
 =?utf-8?B?RHI5RDArelNXMkk3U3BBckhHemhpVlpLc3U4b1c4UW5qcG9SQ21PU3g3TVYw?=
 =?utf-8?B?TnptWFY2NEFCVGZHMUJTM2FZTDkvbXlpMkxPUkZLa1NIdU5heWZkSVh2M3Zh?=
 =?utf-8?B?VGhFY3paYy9jZTU4blllWFVPWFZYUUdveEw2Q0xacUdqMmRCbE5rQUtBc1Nq?=
 =?utf-8?B?TE1yUDN5c1NmMEZSSDZWRW1VOVkxQzlqRUNXK1dQeE5sbFo2aFg5RGkrdmNx?=
 =?utf-8?B?dGswQkc1dXdPSGluSjJycDJ6aXlWNVBOdW1KdERHSFp2dDlrejEvNnBwWklB?=
 =?utf-8?B?ZFVQRGpHOWlHNURrc3pka01aVWlBTFhIb1VTWmw4MWpWc1FmRXliQmtDdDU3?=
 =?utf-8?B?ZCs1U28xWXdFV0xxU3o4NXpRWGlRMGVOZmRVS3lxT1VxdFFab3o5Qy9meGs4?=
 =?utf-8?B?cmlZWEZtOUlWOHZmRlkxdTlDQjNqck9TdVdjdU1DaEI1ODdrVW5zb0FEN3k1?=
 =?utf-8?B?Y3dWbXZ4cGoxblBtUzk1Wk5ZWDhNdEEwTmczQnJFTDdFZXpSMVQ0YzRwaW5B?=
 =?utf-8?B?YllKZDNkV0ZibGhsRHNyRndGL0VqZHNtRzh3cVBZQXN0OTgvN1VnQlBqc01Z?=
 =?utf-8?B?Y0pMeDljT2VBZHNnUWxKOTk4NDVhazFWVEUrdnFSME1tSlQ1NGFjaTBrSTB3?=
 =?utf-8?B?TGlrZUpDa1hhUDBZdDNCQ0p5ZjFTbHVtTCs4VWJmRStuRUMwOS9nNnVtZm51?=
 =?utf-8?B?cjRScHUxRSsvNllPWHo5K0MwNFZpUS9rbFhIcGxjNnFNcTBxbXF5K0hqaGlD?=
 =?utf-8?B?b0xxQ3VSM3c0S2F1NE9Xc1QxUnBJdzNPMmFOWCs1UHVMdm1qblFFTjE1TkpW?=
 =?utf-8?B?ODcwK1Z1RkV0RGptNU04TGwwT2QwN2I1bUc0cEtZbHJrTExTNGdKNzhJTDNN?=
 =?utf-8?B?OEt4WTZNOFBWWlR1SjlnNWxScnRybFlndzlJMUhGTnlmL0FINldxM3NDVFRp?=
 =?utf-8?B?TTJRdmtDM01la1BaQXpSS0ZXWjhNNlJKekQ3aGY5RmpTM1BwdVRoRGVNelR4?=
 =?utf-8?B?cGZHbkdzdVVBWTBoalg4RXc5SXZVNG51aVZEdDNjWGFoOC80UWw4aml3ZlVT?=
 =?utf-8?B?bTRFQWk3cWQ5VDd6N2lYdVlwTFZwenh4UHMxT1hFTTQ1dk5oRHF3WFB6QkJ2?=
 =?utf-8?B?bnl2Y0dFeW04Uk13bmR2L2FVZlZDa2VYS3NLRXRaeEhLYmZVQnlkbEU3TSti?=
 =?utf-8?B?LzhkUjVuY2NXU2ZISU1pVGI0NDM5TVVUcncxdm8vYnJ5a0xkUG0yUzZ2REI3?=
 =?utf-8?B?VWgzZjVBT3k1dzN2VFd2TXNNVUNFTnRIMXdmL0dYUThxMWs4dFRDUmRSRVdq?=
 =?utf-8?B?d1dqazRRTjFDampPb3NRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG52alJSVCtLQVl3dFJPdTZ3ZWRQcDAwdUwyaHdEVm5kM3pwbHd4QzhpWU9Y?=
 =?utf-8?B?aTZkeTF4dEl0L1N6YXEwV2RYeG5ubkJxRU1iSlpYTHF4TFQ0U1hBSXVUTUU4?=
 =?utf-8?B?OWF2YmkrcTNpRW01a1FBdko1ODhTbmVSeTVJUURiZ0dTVm13VG1TUDZHbGlM?=
 =?utf-8?B?RzhJbElyVHYzM3FEaWh6N21YWEUwVFdaUXJjSWJxOTZnUC9FM1RiTytwQ083?=
 =?utf-8?B?emxVTUhQS0ZDQlYwWWM4NFRLV3lKd05ab2RaNjQ0TFVyT1g5WE95a0Zpc0JH?=
 =?utf-8?B?ZWhPbDk4aXN5MUhNbXR5cWZWU3JZYW5TWXFxY2JDdVJMTnRkaVBIOWkyeG1Y?=
 =?utf-8?B?K0F1alVlS2h0MTAvUkVMVHB2Q2FPcXB4UFZMWkZDemcvSVpuWm1JMU1pQ24z?=
 =?utf-8?B?dUo2Uk90RW1ZaEVPTkJnZFp1SnVveWk3RVkzeFdFQlRxN1RkeTRVM3RIMUJD?=
 =?utf-8?B?UVlrcDUrSjZHQ2hvS1ozQk00Y3J4UzV2QkNVdWxQUWoyb04wakR6VW5NT2Z6?=
 =?utf-8?B?TGwwUDNNVlM4SUYzd2lJcWZOc3o0eWQxUWhTUldDZVFPSEpETDl4cUxLSFh1?=
 =?utf-8?B?MlJOTlBZK1VqTS8zQy9kMk05UitVM0pnNUNKNmpPYnAxdzM5STJrQXkvbDdQ?=
 =?utf-8?B?OXdPU0pDeXVpbXhITFZpcjA1K3dDNEFOL2J1dytIM2kvUXJFQUJzdVNKTVVU?=
 =?utf-8?B?dGtHWGpHOTZacUNFN1JZTzFVVXkvbTM4aFExbFNDVXYxNHB4cUVHbUk2NklI?=
 =?utf-8?B?TGhCY2NUUjlCV0xEaXh2N1NRMkZZV2tHdllCMDg2TmdDUnlZY3hSMzFIclFr?=
 =?utf-8?B?RGtrdVI1TGZKclY0ek1QVEFvUEs4VzFPeExGd3dJOWx6OU5qYlRmaVl4cytG?=
 =?utf-8?B?bXdiWHpXL01qVkR3STlEWUx4NkpScDRORlkrUTJnelNwNG1aZnpuamV4T3N5?=
 =?utf-8?B?WTNwK1FZcXlwckRwUER1aVE1YmxGdjV5WVhGTkpEZHI1TEZoMlZnUjBYbkFy?=
 =?utf-8?B?R3ZaN0VVTkcvU3BsNU1VR1dqcUhXZVJaSW1zQjAyZXkyUUR1QlE5OHhjV2lE?=
 =?utf-8?B?RVF4YS92WVgvMWtZMEFpaGg4dnhjbnRxQVFBRnNqcDZWM0QwTXUrdGdCN29l?=
 =?utf-8?B?OWN5RVFETG5xTGhHSU40MHpSendFaDdvTWh0d0s2QVVKaWtWcDZxZUkxdkxV?=
 =?utf-8?B?MWJUVENiMnh2QU51eEhxWmM0N3RCTlpFTmtFenZvd0JFSk9xTG9meGJGQTF0?=
 =?utf-8?B?N3c0TUgzbDhjQXpsN2JHWWZSNHdVR2xha3R0bzBUT0EyTWxYMEtLeFBxcXdV?=
 =?utf-8?B?alpTVlN6TDBaYzVkM21yNno5YndPTEFsTnh5TmNLQ3c5NjhKRlVLbUlxYnI0?=
 =?utf-8?B?Zm5FZ1YveWIzMzdRTXN0bm82cDRCWlRoT0FHVFloMDU3SXgvY05JQ3c2S1pE?=
 =?utf-8?B?YzVqM2RyRjVOQjVJaExqWWtLZW9xMlROR3A0UVJiMG5rTVE4MXN3L1ZVOUk3?=
 =?utf-8?B?WFhFTGdRVXNBNkZHRVhvK0JaM2E2b2lwdHl4K0xBN00ydGswTjFjSEMrM1gw?=
 =?utf-8?B?UkRRbHpPTE45OUJsUm8zbmRYeGtQN0JSbERvWGJUZklPRGFqdUFCSGFDMnVu?=
 =?utf-8?B?ZTNaa0daSEZVdUM5eHRpNHQ5T0dONkEyUnpiQ0o4Y2NvRTBJNS9XNThNZy9E?=
 =?utf-8?B?U1Q0bFNDdDNmU056ZVpGa3pqdEVOYVpCMnZ6U3JBVUFQckVIZmdzT2d6cjBy?=
 =?utf-8?B?SmVtWHNEZkc2SmVwMktiR00zNi9qYnZOQ2J2VzkwWDluZ0V4UjRyZ3pUejEr?=
 =?utf-8?B?K3RNbVd1aGxyYTBRSUxjQW9QVzNPcFhpRlBqQndoWmJTOGg4dGxjYjlsVzlO?=
 =?utf-8?B?Zy9jNERoU08wV2RGRlRPNkxXT3lBSmVPNHEyemY4andMNjVjSWx4aVc4dFQ1?=
 =?utf-8?B?eml5a2RVa0lsT3ZTUlhENmFvaEdzN1BDYkQxM1lvK2dTQkVrWkxZb3RrdjFC?=
 =?utf-8?B?WHIvSnRVSGttb05NR1dtUDJ1ektWa1p4OHRRSzQzblpIVkdMR2l4S2ZLWU9m?=
 =?utf-8?B?bHNjMThaMFdFT3ZmOU9MRGZpTHNhUFppbDcyV3ZsODJ1bDhmbjBVeFk1QnhM?=
 =?utf-8?Q?UkSD6s9lh835dNFRY3/Jhl0IF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf8c6d8-053e-4b7f-56df-08dcd383830d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 23:34:57.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xz0LFWUPJ2YtZdiRoXg9V5FyZaM+yLmj40JNEboh/dPuyWEH3crIW4olRQvmioZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

Tested-by: Amber Lin <Amber.Lin@amd.com>
Acked-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 9/12/24 19:29, Alex Deucher wrote:
> Need to make sure it's halted as we don't know what state
> the GPU may have been left in previously.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 611659404703..c100845409f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2248,6 +2248,8 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
>   		r = gfx_v9_4_3_xcc_cp_compute_load_microcode(adev, xcc_id);
>   		if (r)
>   			return r;
> +	} else {
> +		gfx_v9_4_3_xcc_cp_compute_enable(adev, false, xcc_id);
>   	}
>   
>   	r = gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);

