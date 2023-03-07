Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E8CC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 23:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2722010E2AA;
	Tue,  7 Mar 2023 23:36:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865EC10E2AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 23:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3UeVwNiCqrDnqT6HnVZLH87n//1fzCV5L+UjkVJm0TfY5Sa8/cCm6Jc/AAaKfGQrsfi1t+AMqOOZ7KdkC7UOEkiyshud8SaX2jx/TL+Swmy/WjiUxrDagyzV+4xAZZiRZSmsbNzttSZrACZRDtyZeWXice2HGsbe00xpTkds9Lt3L9vfFQwtXir8wQV6RizyJdSWsC/h07SkuSfLU8x5ZFWJ2auAzGHZQ+HdbgV2AfjsvqAMGQ0gQUa91u342rSUay5Jc2yJjx3RacECwo7BnhlM4cqMpXhbM/w2rI6j9aRrUsm4cE/Vo1giIRB68s2v6XnMzgVvUSXml0E/t5AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48BBv8J3mneZJsUJ9+hI74BxF7G4slCVqciBLf5s4Kc=;
 b=eD4zBycZmqlx/lTqPx2pyGCDy4V+6tbFx1gw/DB/LUcU8MdY+PgXFfFjv6F6aJFXxwuGapNvq9LBTa+t1TX6JCA5vGBqnwNBKDSQ9ZnqSgrkxf0MgBQZ3s1uPdb54TvxifKwIG6VDYmtNsujvl3nfEnWKdFVn5Pwkjnn2iMoqFu5ncmN4pvND003D7l0hknbsDIhAupu19ZkvJDDrJq4694PzY+9OtoL1J8OrKxkskpxZJE+jCNui0MhOvsKvpRdQVZY8s8DR/iXZI6PW4dardmiGeNVc1NbiBU/fPF9JqI7knMBJudvNfU19gzppZpf0XC0155grX4hNsHzc1/YHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48BBv8J3mneZJsUJ9+hI74BxF7G4slCVqciBLf5s4Kc=;
 b=yJg+yz826igCRrAEZmxybEMANR7Xr7CNitkb98W1mZxf4YEEd5Z078qiH/jajy//pmXS6/aOGyiJb5m8NR9cw3cvT4/GzuqdSq68YGfhVKl9VRkd5OLvOSZN0+GJlNL4IFUFJYBs5ruWrOjXK++e0WXydc8N5AqwtKM6eQRhUro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 23:36:41 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::699d:42b8:93ed:76da]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::699d:42b8:93ed:76da%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 23:36:41 +0000
Message-ID: <bbed4930-680f-a73b-3c8a-bb745c5f16b8@amd.com>
Date: Tue, 7 Mar 2023 16:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Revert "drm/amdgpu/display: change pipe policy for DCN
 2.1"
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230228195443.10758-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230228195443.10758-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 938a9ec5-178f-4e21-7d4f-08db1f64cda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujI7hQUk0UkjUM9xeSG7WUZwZNcvfzIBFMaaPfQDPCPTKIZhW7ERyCRlnxuu/G/rWVdrF1e4irauXTrk4P4BYSaoKrn2zHfBdRmznG3WxYV3RhwBdbrBMyNRMt3wIZEFcu9HWiWwjUX7Lp+0a1jXz2iOMitw+fpO4Px5lsAxJRtPetIKgrPHDAsvlUmY+4jjphX9SQqMDNe5D/aQMqdJGjWJbaBTxvsJIrccJtxhJOmqWLMGgH6HIFU9x3iRSS071DhA0hBqVsXaONN+05KZdclygnWcqwHVXDXKGmVrFvJPmhQTvDUKU/dByH3WWjLp1Am8CikogE8Oq6m6uu6VazE5KSEu/fn+f/jsi1WKXZ1HqvBAXYgCXRZ1SmN1z7hZ4jF40nYpK7HAgHPiEPZbsGOOeYIVebG+eBGHvG6najRALxfttXF90yVLIIXq2k0f8TKhtg8vgQDT8QuM3SsiGnxhIAwYsMj+trgj40vbUaFimP1As0MLdY5B1yR6d6BcYkJODaa2Qu9U2wikohiFnUqpg3DarhaCbKCiMv8RUpm8WNGgNwqLtNsEsNsZ2gr9ctpwoL+NXm2ya1ZXTg9ct/DOHBwoEmTDxNPc3tO2mNU991vK2HriC/wCbPpo6XEqMZSU9ZYHfLEmfQN/R3uNVSjXUaZ56nHuzv3nBtVRjQrk9IAdRfFrC8ORv4nTAbA3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199018)(316002)(6636002)(478600001)(37006003)(4326008)(83380400001)(5660300002)(6862004)(36756003)(8936002)(38100700002)(8676002)(2906002)(66476007)(66946007)(66556008)(6666004)(966005)(6486002)(31686004)(6506007)(2616005)(186003)(53546011)(41300700001)(86362001)(6512007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklJZ3dYY3k0WHlIMm42QjVRVXA2QVdYTDBVcm54LzJFbkNuNVd0aFpZbmVt?=
 =?utf-8?B?b2VNdHA1bFFHamllWFZxU1Fjc0ZVZFp5Tkc2VVAzMjVrUVBWcXI0aC9tUWZM?=
 =?utf-8?B?Nm1kVFRLaTExMXg1UnFBdGZGYmpITDducTBwVEZHdHhPWE5JZVNDNFNNWHJF?=
 =?utf-8?B?bGUzUGlTR3NjUVhqMm9YS3I2K3FrMnYzSDk1N0lGMkJKTE9FejB3STFSVE4z?=
 =?utf-8?B?TlUrM3doTTBOeE52ZURON3I0YnRTelc0eTdsbHJxMTc5cDJnd3Z5OXY0TmVa?=
 =?utf-8?B?bXJlWEdCdjZsbVk3NEpPTVVocnFUa3pOZDRPVW9QWTFlcEpuZS84b0N4dGpF?=
 =?utf-8?B?TU0rREdSbUM3Zk0yQkt2QWZ6d00zTEN3Q3JMK1NyUHdQMkl5eGdIb2JjM2Fo?=
 =?utf-8?B?aGVJZzIyRk9xelJBRDQva2tlN3hXaVhFbWZiYW4vTkk5NWNSRzFoM21FSHRt?=
 =?utf-8?B?b2NsY056M08vdE10RDBvaSsxSzl0Q3AxR0NtZVRUOHVjOWJOQlR3TFh0ck1a?=
 =?utf-8?B?cWZQeGY5dGZ6bGNUa1c4dzYrREQrNjREMWxpMlZkc2JhYXlpajVNNFdicVNN?=
 =?utf-8?B?bUthazZ5N2x0STBtb2xOd1U3WHNzYzN6SXBxeFJES2EvNjBUYnNiT2w0QXpa?=
 =?utf-8?B?MVltVEV1NVJSY1Q3QW5ucE1jR1ZOYnRCakVuSUV1NGxtb1lnZFdFbFI1OGZ3?=
 =?utf-8?B?a1dWaHRmbDN6cUVISHNyU05teHhHU0pmdU1mS3RhYjRmSWM5YXdKb0RwbDV0?=
 =?utf-8?B?R1RiWXlkSlgvaXQvY1dtTmNHQTFQTXIrODV5OVZtcGVRekJSQkR4TlorR1Rs?=
 =?utf-8?B?MzlvTDdVbEhCcnRURGZRdHhiM1NKdlBTKzlFUmsrZ1BxOGJFUDVIU3ROaUFJ?=
 =?utf-8?B?SzMzQTNEMGppbUlwRnBOZUYvazdQbTdOUUFZdERudHJHVFhBWm5yZzlPK3Iz?=
 =?utf-8?B?WG9KcUxWY3JzM09nRGtRU0c1MVQyMW9VT1MxaktYRW5sV1B4QzV1WGVpL0tO?=
 =?utf-8?B?OHJCS1R5dERXdWZ2MUJjd0p4M3ovOEFXRm5aSngyOEt0V0R2dG9razVtRHVM?=
 =?utf-8?B?c1JvZ2p4M2VQbDlneW5TVyswalJNUTVacDY2NEZvcGl6QkJNcWJHYXBzM0Zp?=
 =?utf-8?B?QW82dHczUDZIcEpPbDQ0cGRzcVFiekJjTmUyQ2syUjZQcm44OHljREdvYVpK?=
 =?utf-8?B?cDNMQmpZZFhENXc5ZVlBZ2xDejBGRUVCVUFweitTME8zUVlLd25nSmpLUjNH?=
 =?utf-8?B?N3VKNmpzRUNhakVGUkI3eksvMElHVEQ3VUtycHVJZlZUWk9NRUlCTzhiakth?=
 =?utf-8?B?YmUvc0VpeUEyMTRyejdOUzFkWUdEYktTd0JCT2Fvb2NmNDRaL0RtSkNJOU9R?=
 =?utf-8?B?aHk4U3VYM05OUXR2M2owM1FEektBaUpQZHJZbm0zTzhYekE0dDBIYmdwRFBP?=
 =?utf-8?B?eEpUN3owRVRpeUdLVTlwbWJxQkpuZ2dPUGt6WmxBUVpnaEJ2NGZxQzVwa2NT?=
 =?utf-8?B?N05rNDlwYUd0V2pyVXhXeEdUL0E1TllibkwvU0V0ZHpNZGI4WXV6dG1CMUlt?=
 =?utf-8?B?dmM3V24za3RqNC9GTDg4ZlBSLzd4OWJMZm9HVy9VbE1VVlB0UGc2eDBWeWl5?=
 =?utf-8?B?dzRnUUdERXdZaWNIQy9ZYTU1M2hJRGozaGltUGo0SHF6ZTNXLzN3QWJ4M0lh?=
 =?utf-8?B?SFpRaThRdjl6aWdqa1pvd0lzSExlSVY3Vm1rM1hPY1JFTXNmRTNoa0s3MXZm?=
 =?utf-8?B?T3p0RktTSUZweU1veDdkRzNlT2VIbzlJRWlFV1M4Tkp5WmwyZVdOTGZsaXdU?=
 =?utf-8?B?S1BlMFlieWhoZVZEU3QzOTBHMjYrZUlzWllsS2xWL1dXdkp6NXQvcXc1THpp?=
 =?utf-8?B?YjhiU0dMaUlkWG5xdjJMSEhYSTFjMEIrK3BtRFVselExV1d1ZkJPbmRFTnpn?=
 =?utf-8?B?VGN5M204ZENHS0p3UnhqRlpvVkZST1M2SUExaTVHVm9qVzJRSXdnc0NrekUy?=
 =?utf-8?B?Y2x4Nys5QVpIZFVnTGo4dElpS3Y4YkJNb3k3NGQyczZlQ21leXo3S1ZLd1BP?=
 =?utf-8?B?ZGlOMXpocG1tQkhabHJQQy80L1BueTVsb0gydlZhZ0FpK1NIKzNSYXBYWVJT?=
 =?utf-8?B?c1Z0T3hHTlZ1YkdOK3FzSng5UmM0SXE0SGdJNTFma3dUS2VEaHhrQzB3NndX?=
 =?utf-8?Q?tMeB0UYxLu/F/HYkNid8/bGvRcDXBmaYFP++AQFtzUPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938a9ec5-178f-4e21-7d4f-08db1f64cda9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 23:36:41.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS/GiAuNq05LbvyMccWZXUvPU2KEMNsYBDQ6qO0fVsJwd9kvryEq7TYbo6pXcV/wFkTo3+OXZJDY6HoP5lLGaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/28/23 12:54, Alex Deucher wrote:
> This reverts commit fa458eb10dc7218146a84e6d2e072424e64d188a.
> 
> The issue is no longer present even with this commit present
> as verified by the original reporter.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1849#note_1759599
> ---
>   drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 8f9244fe5c86..c10ff621cb1d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -642,7 +642,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>   		.clock_trace = true,
>   		.disable_pplib_clock_request = true,
>   		.min_disp_clk_khz = 100000,
> -		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
> +		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
>   		.force_single_disp_pipe_split = false,
>   		.disable_dcc = DCC_ENABLE,
>   		.vsr_support = true,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

And change merged into amd-staging-drm-next.

Thanks
Siqueira
