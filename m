Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E72EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 17:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43F910E2E0;
	Thu, 21 Apr 2022 17:12:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219A710E2E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 17:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuN+eIr6rB7eiPRBmAFOgij7t6qVfRuwfN9Zhc239orjSBOm3t0n7dGRC1WG2MiivHT7JwSNJdpRYv4tDcUgOMGdZrULuKP1QcB+NIyFQpYpVRvqYSre9FMwYof0P9OoA9vh0cHCd1pkB67coUVz1wmOT+16zWsgjo4xYfggrd3LsLjwpB4Pj1VsFnLqYQUjPuKGxBKAIOAaffKxVejbqRFWmGb1SCorP7VPqGzWQJU8IQHtqR8N38Dr9NyhLhhFU2N4SuofOCa38mS23NFyu16CWJd+57ja+d7Wj9noXp4Z1WA0eaEds7b3g/rLLCgP5CT9w7aqrJd7tjZORBMcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxnHczfoOjtXfWHZ3N5FR1eOu0P0Y75jyOCU78veaUY=;
 b=e4429s9aqGdLxHLP+wpbV3KiMhD1X4TlOxy8zF7MGpbsfdS7TJB243tUIy/ll0QlmpuuoPHTgPzLtgYrAOi+R/9jniI2iYeM80tYnVFw4MO1ml6Z9xmQ9KGTgaQ0G+G0TMvnH9sbIqHLuYeQo4vHseGVjJTMjrS/KKHjgi1k9WihN4V5AxHVKV3sKaE2TwB2J7z7Uhws9USRMQlgEwGgr1cFf4INRMUJYlTQ+O9qLuK5/Man8DwStHxGiYq7NQp/P6kx/IUvnUyMLWCFz5A2qrSdEzr+imMcB5F8lwbikOOeNKCLGYDMZF1sleAhyZ+lLeMOeqhd43gxjCVHiY1ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnHczfoOjtXfWHZ3N5FR1eOu0P0Y75jyOCU78veaUY=;
 b=NvfBjDke5ZSulWeKMijMNvAOHGzBqYrtpeL9DshGJePPviiJogcrwuK6kJK0jT63Yz0CCjse7jrOBA56MJscWvgTOCxjUiUsR40w+MPLfLe6wUEswfNZ9+ZsvwKy1c2Agntv0quttS1CpF44zGl9wQQprTZC50Jcz5yeQk1y4Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3271.namprd12.prod.outlook.com (2603:10b6:a03:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 17:12:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620%9]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 17:12:18 +0000
Message-ID: <98af64d4-879b-5a8b-8452-ff85e38b753e@amd.com>
Date: Thu, 21 Apr 2022 13:12:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu/display: make hubp31_program_extended_blank
 static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220421141032.3012374-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220421141032.3012374-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1226a5-4903-4c0e-a337-08da23ba16fc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32716AB890482AF7DDF522B18CF49@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuYOeG9FDiLe4tSa4ywD6eluZ9av9uYyVuPABHhmsbLgGfkvEA2FyzngWtS8WaYt74L25SiRGUACzcvZGVwZydbedtXZ47nGRexcY0IDsHlyXCQzGaSQ4O5U/PzkMe7TiEr/kiyHsiYzBcudiwuBAxZtPNlGsmgbpl40uvcm41Rn/3wSTELOrq16jAYeTyHVlORrlc+SUr64YN1p9Lrt8LI/+ATiuf10Hl0Wp7JRjo62SUMBE043MidMPuSPgnIYPwFdHBeo+tefoMGjNoxvKjNIKvkp6xq8PZm6XLBM5aHIxPuOjQKQF5COPauLmUpEpehKDjJxk5HXKKdj14U2BahaSmd8yRed+co2q1uFmo5dUqHrfVkPAAu9wOxEGxhtgThcbgTvZ7y+4rkkjPt0SjXXHPnLBk3//HbEMSm2RCy7mwHuQ/NNBqe8cnJ7Zi60Wnpvh6oav5eiE7bZEsifoSa9OgvPBdUldxcaHHaRnmTxyHk9stETbvG8EU/+gLgx+MwNgrJ7iwOHx6IzgJZUl26XWX5yH9ltpo/2+tCosmkztUF8KSra/YTP3xL4Ez7XExmIQZXwde+IFE8GocJ6f134sojT8iKaXWonTa7PFhChHuJoH386yA09DC8BSqnuw6bsKj+0H/8HATTPgBgFm7KPez8WvxMLk2HMpQkVg6SaUywtqXZzZSfZdXApMYru9KNIAyYapAwZ6+yzyIGnqxp6YeOz1+TY96+zDkATgFwbQOCCwhhhJLhdDoox9cGr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(8936002)(36756003)(4744005)(2906002)(66556008)(5660300002)(316002)(38100700002)(8676002)(6666004)(66946007)(6486002)(53546011)(31686004)(86362001)(31696002)(508600001)(186003)(26005)(2616005)(44832011)(83380400001)(6512007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9lb2ZnRVRVYWZUODkzeUUrOStubC9mT3pXTWpJbTE4SU1DZjZKTFpwWEVo?=
 =?utf-8?B?QTg3QkJtOVFDUUZRNnU5R2dTYms0blpMR1N3RjBPTDB3L25kcy9lU1hqU0xF?=
 =?utf-8?B?azRtaGNXWGc2TGtQVi9WM2xrYmdySFBNVElYUnVTcnNBODlNRW9FUEFWRzVz?=
 =?utf-8?B?SzRmZmVFZEZhTytza2huR3M0K2kzTERBWW9LUVlhOXVlR3Yzakx0d1kvYWI1?=
 =?utf-8?B?Rm82NFR2bVAyM1dLcWE3MWxubmZxaGZqc3RvSEdMNUVKenZzbjFvK3Fma3pU?=
 =?utf-8?B?RFF3ZjJEK1VPcSt4K08yVWtwdzFYZXpQdGVKek9PcXZ0MTQ2c1NQT2NucEk5?=
 =?utf-8?B?dExrRFpYSWJkVnQ4SlQxWmduYk5VSDFwTnM0NG0zTGsyMmxOSVlTd0tYajZS?=
 =?utf-8?B?dlFpSHNOcU1ZdVA0SjZtR1BjZ1FjS0RuM2Z2b0RQaEJQYnowYUdXQW1Pb3Az?=
 =?utf-8?B?M1BqWFpwRXNoSW1IOUJpcFc4R3E4Wnd4c2doeTQxWkhlRGlVSU0vSjJPb3lG?=
 =?utf-8?B?MHBtUU1KSXpqZVR3MndEbzNmbU5ocXJQNUQ2TXZNTVJON2UyaDdCUFpQNG5J?=
 =?utf-8?B?Qk5ZTzFRU1J5Q1pjMXFqOUEzdDVNbUNBRzhQQmx4VWFPQU8rcXRXS0l4aE1u?=
 =?utf-8?B?RjBwK0lFUXhwUGJpdnZXcmpwZmtRVjVKSVo1QWE3M0NPWjhxS2hPK2l1dkd2?=
 =?utf-8?B?NG9xU2NwSUUzc3h4dDRrd1J4NVk1N2FYam1GZUtqcXlQRlg3TmxVajU5LzFQ?=
 =?utf-8?B?SHJCbWJibzkvTjgzVEJsWC9YbndkVmFHdlRrZDFSdWg5a3ppOWlKTGhVcVRI?=
 =?utf-8?B?Q3VONnpIZnpwYjRJQ21sd04wc2w0djJPZHVqbUk0Vm9yMDRBdUg5d0hPSWNn?=
 =?utf-8?B?NERaU3QwMDVCS2h0MlRzZzRFM01GQkViYTlWcDAyc0hkS0FJK2JxR25KZTF3?=
 =?utf-8?B?Q0s0MXF6SEMwM3p3cVBtRElmM3BPdm1VS21tdTkydTZzTzYrZ2tDK3UrdGVE?=
 =?utf-8?B?ajE2NStvQ2QrZjRia0NMaTRHcFh2aGF3QjIwZHY3UGlTaXhIcE1rOEJZZEJ0?=
 =?utf-8?B?QVZGc0VjQWRuWG43UUEzNVk3L0tWbS8vRFM4QWVWR0ZXV3BWbiszNVdWZXBT?=
 =?utf-8?B?dXdTZ0JXWkw0K3psKzVwdktCbkptb0RnZC9sRUdiRjhON2lOMTVtTk8wdmpN?=
 =?utf-8?B?Ym5LZmIzbWtWQ2ZvVWF0UWR4bW1OUmkvei9FUlgzRUovSXhxaEw4ZlVRNDZV?=
 =?utf-8?B?Sm9LQUgraDRma0ZwOWhBNDMycTBEcWllaUM3NGhwc0s2ZEZjODRtaElOMFZF?=
 =?utf-8?B?cm5qVEhFQUMzeHpwZnU3eldicVNCbWxTdWk0a0tZWkNUWWVIU1NweEFsdWdH?=
 =?utf-8?B?Zmx0RGJoQ0lYdGtzV0cvYUduaU9DeWUvOW1GeDdhU0JqeG0zY2NTWkRKQTMy?=
 =?utf-8?B?Y0F2RTMrbW4weHVJcE03VTFPUnNMbG9LV2Z6WTk4cXNQTGhZT0I3dlR1UjZJ?=
 =?utf-8?B?bnF6Q1lTWkIrelc3WFA4NndpMTdGSC9RNEZWYTFLdWJHWDZoOVpWSksvL3lO?=
 =?utf-8?B?dDkxOXZ3ZGprcU83cWRhUVNmZlRWdnZMUW9Tck9yREFQM0U0a3JROHhUYkI5?=
 =?utf-8?B?V3ZwRm0rc3RDSkRPSWd2dkplRDBXVWFsWVZZbmFreVFzK2FjVEJwazJUWVVG?=
 =?utf-8?B?RStmSjlWZW9Pb2VQbWdVaS9ta1hSTlVaeWNtcXd5VTN6TGloazJmT3pLbVNq?=
 =?utf-8?B?OHVaSkxLZUZBQlpoZGNvNG1neDUvREwyMEFCQS90YnIxeDl1SVBiNVhLMzVL?=
 =?utf-8?B?MllyNFVEQmh6bTRGRkFhVnQ4TWxOdDN2RVNmMkdDQnZtUHMwM2R1Y1ZmdEVZ?=
 =?utf-8?B?UHJxZGMrSVU1MUM3eWordWlSYUFjNko5ZmVUMlM1SmpOUkVFaXByeGs0b1VD?=
 =?utf-8?B?MkxVVjJVVHJ6TjNnMkJmVHoxdVVpem1Ub3BINVpLeG9rbnk4M09PTDhDd2ZR?=
 =?utf-8?B?ZWk1bkx0QkRselVSZ3JJUDV0YllDck1rYWZrN3E4M202dlprNVc1VDk1UTV6?=
 =?utf-8?B?YW1sNW1nT2lodkZDc1J0V0pyUTFxY1M2VmwwM1hCSHRvc1BHa2cyYmI4ZVli?=
 =?utf-8?B?UWpSVUMyVGE4dWZRRnpFSHBFVks1MCtMeGZaMXhybCtHQUd0ZU13aXB6S1dG?=
 =?utf-8?B?UFRhZ1ZWN1M1NFYyZXhuZ1EwMG5USTBUanlBZVlQK3BPcXl3TzZpYVhXODVS?=
 =?utf-8?B?VENWTmNMckg5dGp2V0dTcHo5QlFBd0VERFNYYTNiYzBXdzRFOFpORHVHWDVr?=
 =?utf-8?B?SU9aYnFGQklCVjZIUTFJeDhPMjJ6MFoyNjFDMk5kbzRJVDZmbVE2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1226a5-4903-4c0e-a337-08da23ba16fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:12:18.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQjRdtPpmJQV2kaGbahBzTX25wk2f2ru+9lR3VFMufMkUYe9AgcfMkW3ygGW1V3tACwpcTwgcdxi2uZiZTLfrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
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



On 2022-04-21 10:10, Alex Deucher wrote:
> It's not used outside of dcn31_hubp.c.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
> index 8ae6117953ca..197a5cae068b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
> @@ -54,7 +54,8 @@ void hubp31_soft_reset(struct hubp *hubp, bool reset)
>   	REG_UPDATE(DCHUBP_CNTL, HUBP_SOFT_RESET, reset);
>   }
>   
> -void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
> +static void hubp31_program_extended_blank(struct hubp *hubp,
> +					  unsigned int min_dst_y_next_start_optimized)
>   {
>   	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
>   
