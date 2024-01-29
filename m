Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56051C47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 20:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE15F112AED;
	Mon, 29 Jan 2024 20:46:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA9B112AED
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 20:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY8R2+alUA4KD1Po0MnUTLXLPJ0Fec/A4ym9wlma80pjKJWAVjV3vTJomOy9g8s1uZJJcrRwW3nvhwHewIN25S5qShEAO9NZVYnhSsbKWLw/JhkEjxoFVqiaXObmyayhn5rIWCLncRlpo7k6+GK04qJzxKegJ2maB7A8vgKLJBPM2buxdFbHvJfhHg4rj2Im3p0RWuV/tuuLCzydnYI6IXBg9DwJ535S00pW3szCOTWbgUeKseQUVe9v6QxmdCRyECPU0ZRQXFNU9bcRATEtMDGEhj3MOe8TDIBt6dx0KXHxGlJfmagNLuUu+Cfu+ReWHJcUomiBDtWblfqIYU0wTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBMCcVyxkeYV9a+4ae3LmvCWjpruTiF7qMThANNyw0s=;
 b=McJcHdMCNF7JsxQPlSSMEWmczz7nr+qpDPCDRBlZHw9Mu4yVoZkFDyQvsmROpnXnjLvVZQRR1yJtNKDe+8SVzvTzPMBGhPLA1JQ0sf2VqKUXQoTamQ9reKUqUKDyXkVDQYb/8577Yh8wcyOluVRR9N5/z3eghmlMDLj+ECaKhdga+h1iAu5VFHeueLV54jqanimAI7qrET5CsFAL1Xo+5a9Fy78vwukoz7XIePuAzH8w7LbHT5e4+6lzGFT4N2egzjNogpO/4bC0KRqpFUxCUSglt/nxXJJCeVu2PGUieYO4Jjy487kvkNUmeveRXQ3A0qMkKSwLvOJBQ5RxGAbPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBMCcVyxkeYV9a+4ae3LmvCWjpruTiF7qMThANNyw0s=;
 b=d1CLI/OYtPvMa80dAVVV485KUHcpr58TaAUTxGiRxfdaDFLh+cb1fE3FF2OSiAPF49sFis/NjxOaoajbLi+n03Bx3p0mWp45ZEL9IRbZ5uc+vbKLcSZROvgZS5+B0k4B9PJJPTi+vtxXd1flVoRqwMcYMlTEUps6K2pPR929mC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:46:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:46:32 +0000
Message-ID: <bd7b16fb-987f-416c-a454-c424b95ed07a@amd.com>
Date: Mon, 29 Jan 2024 14:46:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd: Don't init MEC2 firmware when it fails to
 load
Content-Language: en-US
To: David McFarland <corngood@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20240128161803.1224103-1-corngood@gmail.com>
 <20240128161803.1224103-2-corngood@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240128161803.1224103-2-corngood@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:4:ad::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 345a7fe0-bc61-421e-b1fe-08dc210b6010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bks9S/iKLemB23ODBuMsJI//Z1CtXVI4OT1/JfFLPgw3zApAWgTVo9aUsNjrpw2CKf3FxTeR9j0IEqR9rpxho2Do8akA1b4d4snhWNqb3TjFYr1UWwr2KAYc7mIwQtMp8VFZe+ex9cYc8Q8JRpuSccMtVBuGNX5lYLywDNKh+OPSEjL4XtLs/cbVdiU8Kw2wQ9TqdIBUgseh6+So8L/yQiKOQ2oYDhZPwu0ckbAVHK3kTagubVuPhYqSU4Aj4J/nty/0mCPV+KiHCVCFDuaUt2QEYT09qrLLFeyQslm8robnM8xN4HyJWXm8ZTRJwt8fJxgjOupyLKk3q6qkfca4pce45SJKMv6MzY1RAjcFBP17Ojg4pJtDnK/yhfFvUytOULwpE+nNH1MvvdPE/HgdpPKO1fLcAIJbnjRr2jh8L4VkZyt4vPcYd6jQ1PIVSP6czr2gW402o3vnp1mFpE1M0LANcmsL2E5tRdyHDAK2VHirAUHBYdynKAw5rzTwY5EVZkHyi72brBKDgu1iuU1fX1URAiGR6yigPuBQkh1lkCYFx/juKTIaFFWDLB9Wjpki57NwijL+oLznjc8G9n7B1FnJMLhvy5oiPLEXIeNQeKg72KFrgjsdSALhC6R16MMjA3ILczecxOTK/zVVYehThQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(83380400001)(6512007)(6506007)(53546011)(36756003)(31696002)(86362001)(44832011)(8676002)(8936002)(41300700001)(5660300002)(66946007)(478600001)(38100700002)(316002)(66476007)(66556008)(6486002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEpUMVo0Mnp6T3VuZEpIN2Zndy9MeDZFUUdlcWt5aS93UVBFWjJxMW54byt2?=
 =?utf-8?B?aTZKa1A1WEJqcG1KaW1hSGsvdEtWdjFDQjRlVVZYS3V3NDRtUThCUFdCK1o2?=
 =?utf-8?B?SlM1MktvZk83a0Y1dVJPSFhzQ0J0ZlVVOG10c05ZcjNOeDZLOGhqZ1QyUG5J?=
 =?utf-8?B?QVUzYU1CMStzOExyUml6ZzhXKzQ3Z2RxeVluQnFYSEdIMlduQXdxWlRkRzJM?=
 =?utf-8?B?Q2J3Q2JGeFBlbzJHazJJZ3FhczNieUhhc2RMbVJVY3A4cVEzY1dDRmo5cVBK?=
 =?utf-8?B?U25pcVdvTEdDZkhKanVWdHRsYzJtallSOGlYb0pQK2RJK2JjbzVBa3YyYkxX?=
 =?utf-8?B?VnY4WnJleW53WlVxUkY1S0JBdUYvRjFjcnF6ekFYVm45RzY1Y2lkWmw1dll6?=
 =?utf-8?B?NDZNS1FRK09TeXFkLzg4RU5CYTVDMnp3ekhmdTh0a1hpeTB1NEtqU0NGUC9R?=
 =?utf-8?B?RFBDSTJJODgyU3hzUXA4cTYwYUFlcjBwMFZqMVJaQlM1WFp2cGFMZVdyYS9w?=
 =?utf-8?B?WDFnMi9DclhYdFdWTmpQZWtwUXRQUzBqWXlBb3hYRFNVUWJtOC80VlpCYzVU?=
 =?utf-8?B?S0Y2ZkJtOHMwaHVEck5kdkh0enpLeW9TY0hOTFBLanZoaFo3dVRkVzlFTC8v?=
 =?utf-8?B?dmNKcFVkUXQ0am9JWm5mMjBBcUhhTVRIT3FERUhrWXV6dFlKVitjclJIT2pi?=
 =?utf-8?B?Z3AxZ25iK0NyRnRmNnB4eHAwNU1RaWgxQjNveEU1TlR6dzBXaGJocHFtcnhy?=
 =?utf-8?B?ZHZuNTZicHpUSmM4T1pjQTJBU042OG51d0lYRkJMeGVCOTg1bjVkUlR0RSt1?=
 =?utf-8?B?SmhKSDVRRzZYdGhIcGlRckhiSHV3N1VWdWFnK0VRdnNGeUo2YTQrMVFWemJj?=
 =?utf-8?B?WlVKSGZSNU8walJ3RGRIaGlORnVEd25zWmVrSUp3QXZrQk5wMDhFK2VoWHJV?=
 =?utf-8?B?RFdRdkYrZWJBR3dRSHRRbDBzczNzU0pDVmY1QWhoWi91Y3drK3JYY3FHNEZs?=
 =?utf-8?B?MnFCSUtTSkFudUp6WXVzcnc3NW1nNnNSZjhOK1IrOHFza1RVdm50VE5HRzV1?=
 =?utf-8?B?cXd2YkpoMVRncHBGTHpaZ1N0akw4eVNpUlh5ZkNPV04yZ0dmNS9Pc1R4K2pj?=
 =?utf-8?B?cVFhS25aSVIwcGJpa0NiL0VyQjB6OXpZSDlLMGo0ZlNDTWFRcjRzbFZJaGl1?=
 =?utf-8?B?MC9oOHZNTklRK0Q0VGhTek9kaWd5Vng5UjBCMWtCWmFSM09lSWxxNFNqakJY?=
 =?utf-8?B?bUVkY1g4ZjQrdDZuYlNZZkFsOC9odjB3MGJCWTNNOFBIMGM4WkplTVgzZWV5?=
 =?utf-8?B?Q3hQZGxhRityZFM1czQ3L2JvdkRzNEZyNWpHOGxweUFrbXlhN3ZucU51eDNV?=
 =?utf-8?B?MWpzTlVTR2VPL001SmNPOVJXd2ZFTEFpTk1OR1pZUExVMzVOOUxrYTVQSndx?=
 =?utf-8?B?SFQ1QnYxRFR1NnlnaXk3bUV5elAyMExlOC9KcEEzbVk5R01MbXJmcjV4L2FJ?=
 =?utf-8?B?UUx2LzNydUIrRitWSWEvQk9HdW0yckQ5c2JrSFZ1czdjWHROQVB2MHpjQmdm?=
 =?utf-8?B?eVlkNXk4MGp6dVFhVGZyZlVCeTVldG1tYWFNSlA0cERFZmEvODU2UFJla0Fv?=
 =?utf-8?B?UjIrT2ZkSDIrcHkrUEd1RWU0ejNqQUFVRW5yQ1NiUGUzUGxJbFJzQk9ic3B6?=
 =?utf-8?B?SGhhNlo1VTBWTmpWaTRtbm56S0ZWdjV5VjA0eER3eTNhdHFpdlFSVnhKT3Ba?=
 =?utf-8?B?aU4vWnhwN2RQVUZSWFFhMHNiN25PbEdRZ2dkT25qOUdrb0oyQmkzWksvVzJh?=
 =?utf-8?B?QjYrdWt2ZWFXM1BkWjF1aDcrV1VvU25EakN4ZDZCaXhIaGRhUS8rMU5DVHhx?=
 =?utf-8?B?d2g0ZURqdXVsU21EL0lwY3dqRmJBZVRueXZxWWYyamNHTWllK1JjelRhL1JY?=
 =?utf-8?B?RExqRXZ0KzRZanlnUUNtY3YyL2RvWW1IdkNibjBKaTRjVjJxZFJMVmtWMW51?=
 =?utf-8?B?UzlJRjZ6aVZ6M3JBSE90ZjhtTGo2Qm1RZytEZlhpMVBZNVBWLzVra24xMTkr?=
 =?utf-8?B?cnBjTG5ZN2N6ZDJxM1laWVFWVlhqRVlLQnpEUFFobjF5dUw5N0F1bEwvQ1gx?=
 =?utf-8?Q?dtoqXj0cOeb11u2R7XWujJDkB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345a7fe0-bc61-421e-b1fe-08dc210b6010
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:46:32.1269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp7oYm2dUSVOIO6tiTd8bk4OMKOusMguGFeBJ6FG0GiwYA3vEK1fnDsB2MdL9KOE/Dh2gOPdYqrt7TaNRrg/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

On 1/28/2024 10:18, David McFarland wrote:
> The same calls are made directly above, but conditional on the firmware
> loading and validating successfully.
> 
> Fixes: 9931b67690cf ("drm/amd: Load GFX10 microcode during early_init")

This is a great find, thank you for the fix.  I'll apply it to our tree 
and Alex should send it in a future fixes PR.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d63cab294883..b0ba68016a02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4022,18 +4022,16 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>   	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
>   	if (!err) {
>   		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
>   		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>   	} else {
>   		err = 0;
>   		adev->gfx.mec2_fw = NULL;
>   	}
> -	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
> -	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
>   
>   	gfx_v10_0_check_fw_write_wait(adev);
>   out:
>   	if (err) {
>   		amdgpu_ucode_release(&adev->gfx.pfp_fw);
>   		amdgpu_ucode_release(&adev->gfx.me_fw);
>   		amdgpu_ucode_release(&adev->gfx.ce_fw);
>   		amdgpu_ucode_release(&adev->gfx.rlc_fw);

