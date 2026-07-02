Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E3C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3546710E4BC;
	Thu,  2 Jul 2026 10:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snDghXf9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F5110F2BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjldzjVPBKvL6HXG7fjOn7Xwr/6IYbDmXt0moPDMYRVPeGzuvkKGFcNLovr/gIejL8Y5z7Xm4FgiumgZXCBA4tjJgKdUKBIKEQAKc0vGv/mTQI6qKMAR9/zJKOovT9N5/yuYupXJ6aqqXONARQxwaY8P6aBMc4etNVmwygtre8jaRKjSwJeO+IPvtfWi1NNSGW+QK9jxzlcKRG7MEgUKd/xFuEUHvpTUNu8iikQCABSe5zG76u20TVLUwNY9VgHLLofEvBLWPiYnoTBy36CZhEAy2xuuXfdhR1Sfr1RuP9E8slBjbKdp03BwqDtk0rxmFeBdv470sF4MgrAmk0uyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+xPSC44xFSUqPWvRddwLCRe2+yrFk9zNPokx5qDzr0=;
 b=IuaTCUIyHAoBedThRPxiwGzvnUb+F1NElxeA/8+sDIAK4kqZ1K6/0CBUw9ZdZ6JrSNgDdBOnA6a1L2LyNGF3otMWl5uAGXXPMhN9OET260O0keHALmVVimCEXBLgyXAQgrtJFGxjOkAFw0JdMHOQclEM9T6IEZOnP7DiXROpX9uLisKpa83WGJMhY9gMEc6Fnq6YPsgfQ60ZFeHi/TnmA64+J3FocAAcAJCP+9TQb0ryIKux4L66cxuh0rBgmeTEYvamjQPiIhCIo2jr4i8wGq91p8QxRxI+zCSpvkJ6zCxWG3JwIBJHhyZjlVW+KibvL8kQz8kLu45Oi/otoBJnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+xPSC44xFSUqPWvRddwLCRe2+yrFk9zNPokx5qDzr0=;
 b=snDghXf97uIMhL6MBPiyEmnWwnj3qvhtLlydOE3dwg4V5BeTjx93RGR78502hUqPN1tV/3TK3WYD0ctfI7wumL3wUijb3VNK0KlwFYnHBPM284GWMXz9JQoMV6QDwlObldleoOkktY9A/xzqYUR0qRpu4Qp0H7AzaQfZtgjIo9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:38:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:38:18 +0000
Message-ID: <dee4f6f3-0494-40e6-94d9-e0249633d0bc@amd.com>
Date: Thu, 2 Jul 2026 12:38:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-15-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-15-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4076dc99-6547-4368-ec49-08ded8260754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|921020|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cUargHdnX/JSLaGSIJhLFkw75+hN3xcG/T/6OPiTkymmGE8gJhRcav3KOOt2EfpMl1ame8t8dv/JavfSnp/aEUf4xgDAWvWbXK/irzperHsimvArr/5/X6Sy5T+pMYTYA3/zPzcjUSFjU0VvEyKX9Egdl622lzkq9dEenzJP7ejqxj3n/66JahU+QjeHYJScsLCxqInGbwjlkB1Ldvu4ROgMHAqgS3DX0tQ+WUCxqPYuSxSv+6KNPlai6IjalMSpdz3BQ+5AC3bk5C/BnEDP66CYPjAKLoVoMOBNPC5tSsteeOBvnFIFjRIEOxLPT8m/dzTZCWXtc+Tv0Cpp6FlsAEDEovn11wWmeFRwCSQO77mvC/vM7UBf6NJx9Dwro/SCwryfQm8NSrrZEzVLcXLU6V3Tyv0Sy24MHFjj78cMUBC7nltZbhkObimgVOj8hUxV8RVqHH5lF+IFcKH1druwLRMa5ucU3/vmUW+GTyg7Xoc+GT3XF8PHBcIlOCcf3NkhoWGHaja2hU4/qKDwmI/nDWqNH0Eh+hABjzDMNNt+RT56YZ0RGpf+/AZCXfUhWotubU1KLq65ZI98rVSPAVe9xFHe/qj72m7jTS7I+aAOTl6+ez6pxa/y9XNpDJ7iYQd2HNZF0HQ2xeV4UezVU6rR9zr1fiMcIF0+PSxnWrbYJI9tXwuLUJ5RV1+uySmnbLC52DEN7JXRa+2Bid5c4KLn9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVtVzg0L2I0d3hITUg4Z1RKWHJMK0VLeHVoQTRLK2hady9EOTFGNzU0NEM4?=
 =?utf-8?B?VzdoWDJ4SHVkMm1zSDNKaVZNQjdZcjFVOUVEamFGd2Rmc2JmVzhySTNzVkZM?=
 =?utf-8?B?QkxjV2NYckxWcWtwNjFiemYwc0dEMkt6U0NTYkVzWnVCVFRXSStncVJBYkdW?=
 =?utf-8?B?R0xROFFaSEw4NVhra0pZNS9jNFlRNFlpK2Vyc3l3MDEyK0RGRUFIa0Z1NitS?=
 =?utf-8?B?N25hZmhpcmpPRGFRTFhnbzNDQW1wRXJ6UjUrL3doOVFIbmtrKzZoM093L2c1?=
 =?utf-8?B?Q1UzdjZCMjFHemNzZTNYcGltTkZuRlNPWCsrMmJleWtpdzFkNVB4STZ5blov?=
 =?utf-8?B?RnNta3A5Z1o0WGZldnRzRmt3K0pBanJJWW11dGFjVmVVZm1ZRVFnRHNicVRC?=
 =?utf-8?B?UXdxV3M2OFFUR0hBWmpRcy84YklLczRHODVxNTlZc2JiSkpRYjJkcG1ubGZZ?=
 =?utf-8?B?Qnp2UkVBSk9QYjJJaHBXNlpNclN3QnRCUHhmZkpLczJWejVWY2ZVaUt4Q0Vh?=
 =?utf-8?B?YmlBNEp0cU5tSlFZY3JUWUN5TW5pTWxCRFN0d0VPd2RkdlFmdnhEYTZGTTlM?=
 =?utf-8?B?NXZiOG56ekVVR2JQTWRQODNCeTdHajFLVUJkTUNkSkpxWkJ3SlNreUxHRjIv?=
 =?utf-8?B?Wi84UTdSUDJMVTlCVGxOWUZwK0dKQitmODlRUWZMV2xBdWxWQWxIc0JJVlds?=
 =?utf-8?B?Nk84cmdvTVRIYVE3eEVHcHNhanhTc2c4MTgxVlhKV3FLK0VaOFZ1WmQ1NGph?=
 =?utf-8?B?U2N6L2tSMnlCUlR1QkE4WFp6T21Td3hQTnkxU1hWaTNjWUdsdWE0RlRZNG5k?=
 =?utf-8?B?K0oxeTV0SytLcldyMythNVNtdXNJZGpRL2wyZHRrcWc4TmxxSzhxNmpobzI4?=
 =?utf-8?B?T29QdnIweXNaTEw0ZlNGeDNlNVBteVFHVW96OWxyMGQrTy9PZ2tNVENSTDF2?=
 =?utf-8?B?cnF5WnBhZTJBOUZGbjh2ZmZLYnNDQ2JGYmc5aVU1NFp5TnQ3ZzVYdERnQWRl?=
 =?utf-8?B?K0Qvc0JYSjJ6ejZ5QjlXZllVUk9Pa3VzSXVORU94Z2RydlFvUGRBY3hwTHN3?=
 =?utf-8?B?bVZYZGNvV3NDdWM1MTVDS0JlM0sydnA5NGVjeXY4OWV1T0FWNUZTOW83T3h6?=
 =?utf-8?B?ZVUxemxuTlJXM0F4OFQ5aFBCSWRzTEcza0prU2pTTlpsMExYVmgxR2VNQ2N3?=
 =?utf-8?B?T1VrWVRhQkNHbkdtZGNpWW0vWHlHRVl4TEpSTjVsdzNyb1orV01kS3M2RUpa?=
 =?utf-8?B?dDJ6VG9BVURmNU1yQnJhaEJiUWl3T1RlNDE2bUw4bDViZTRoamlKeGpUSUpN?=
 =?utf-8?B?d3YzM2w4ZWhCeU9kSGY3Y0tRVDdCVXIrLytMRzdhWE1GUlk3RGpZUzNRN1No?=
 =?utf-8?B?dUNGcGtTTFhFdS8zM0IzelUrVGdKcWlUZS9kb1pqS2Y3M3RoM1pLMVhzWjlW?=
 =?utf-8?B?c1BEMitNNzJmY3ZtNWlXRmdQU2NYQzFMT3VFeTkrTXh5dDc0V3dodGJXd0F2?=
 =?utf-8?B?b1VJK3ZQYms3QUtWRE5paWFDLzZ5SzlKK28veVA5UGJxMW5DL1djazRhdW9Q?=
 =?utf-8?B?SDRYcW5CT0RKc2V4eUkxek1jWjFqN01FSDJnNmZWZW1QaVZhLzJGRDBxaEdS?=
 =?utf-8?B?OHkyUFl4aDE5WC9lMWw0V1JEd1B2dmhubVhYY1d6YWJuaTllWFlPekhsNUc0?=
 =?utf-8?B?S0ViRjNsZXNTcTIvelRCYk5odlVIZTR5YkhEUWpMYXdjTFpPemdGbnFhZm1x?=
 =?utf-8?B?Qm16eFNlQU1mVjNETmN5cEdIVDJMS29VN1VqdEhxam5FN2NOWkVTdHJzRVNp?=
 =?utf-8?B?R1Y3SVlLZmQ5L1EyS2dLOStIVkNaY3VaZ25rRW1lYWpGNUpsV2g1OGJmWWxF?=
 =?utf-8?B?NW4rN2hnVldmM0hhc1JSbkQvQ0t6Z1JDTVN4SUZFdWczem9HWHJpL1BPS2t6?=
 =?utf-8?B?bDdjS0ZTaEhPTzlYUkJWcmN6NlJ6UVk2NUNwQ3M5OVAzTkZEOWVTNG5wWmFr?=
 =?utf-8?B?dHVQOThKUVgrdXdUZkZQdnkzbVJFTDYyYmpZQ2xUMnJmclc2VmRRRnhMRlJK?=
 =?utf-8?B?cWMwdHlCYTFRUFZJY3B5b1pFRHVvcmZuWUhSTTc5eUIvT2dDaWZtOFVTdmQy?=
 =?utf-8?B?RStvV1RiWmc0RnZCcTRHY0ZRMWd3N0xTZGxtdjJQYk1VNnowaXE1NTlGUXdk?=
 =?utf-8?B?RHVzQW1OV3VTd3BaWENwbkRVTXk5dFJVTGN3Z25QaG52Y1U1KytJTit1cUlZ?=
 =?utf-8?B?N00yaEtMSDlaYlpLVHlnMzkweXRaOERtU1pXUVVaRTZwVGlNbmxwRFYzckly?=
 =?utf-8?Q?CeAh0lxYQdzYVJPj2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4076dc99-6547-4368-ec49-08ded8260754
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:38:18.1502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25iHlYhI5X8fQ4g0pHXzB5svvgiALqllsPLYw+N/nVRF7on/jEBD8m/gy5aqukcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

On 7/1/26 18:17, Timur Kristóf wrote:
> The retry CAM can filter interrupts which occur repeatedly,
> such as page fault interrupts when retry faults are enabled.
> This makes processing those interrupts much more efficient,
> because the CPU won't have to deal with processing the same
> interrupt repeatedly.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 291326d2ee8b..ec0919fa8254 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
>  
>  	pci_set_master(adev->pdev);
>  
> -	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
> +	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0) ||
> +	    !(adev->flags & AMD_IS_APU)) {

I think the check should be the other way around.

In other words we can enable the cam on dGPU or APUs with IP version 7.1 because that one has the CAM as well.

Apart from that looks good to me,
Christian.

>  		/* Enable IH Retry CAM */
>  		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
>  		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);

