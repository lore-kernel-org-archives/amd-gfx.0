Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C633C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 07:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9131210FFC1;
	Mon, 29 Apr 2024 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGr/xNET";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2583810EFCD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 07:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU9/9hwMGL4w99Sj74wFcN3PWT9Y7vQJEInJTyodfSUu3uehrwbZZowIObdF4XHdSofF8Zpa8YkQamdxt4BEBkyUlutCO4S7V8OuDCbsUSzrcaumBiOQ2JCdP9RUXXPLzcOUmsXJi3dbCbVA8VpOByrZdxaRcOUI+Jk4u6Dc1HzIQwYKqZoe4iPKbwftmuReznoSXwOLVi2+vQNt93A+1MCW4zK/Sqo9al4hTDyT4Ywz37DuugXkehAl/Sj0HKV9gc3qQIZBEZJLb+LM8D05pwv4ID6lgY8JSUmt/nrLACclO6W83a+JSwQNBolyZTJCfmoG+H9bFz2lt81GDH1ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNdSMW7dsWFsZFF5bsrPWkmRm6KrddpezjJqos8Iws4=;
 b=TyS8hXaDxiJ3Z+OpX7Fbd3b9kyMRDXnMqUM9U4ZZa6LDkNcCieTjNDI9COURJ6Snsp+OX3vmOdEAPOqFcqT65S0cgSp6AZptxRrThoDw3MdsDFOy5RgjjSTuvYS400OW4YYXqJSOr3QPgxiawABOvKGUfVcZAqapugD47eLTyhyjKFl4HjHe67v8bznB89N4wRhXBiJxScAbb5k7aIPCmZmTpqnX+nluyBa9xJ9uBrwyMy1e68GOyotnrlX64ye2Tead02zbszLUvR2bRvoCCqIPXy3cmTandDKO292nfyE2wVs/BWYBjtcCFq6Isfx2OSm94pirfQdF7F4kBhPf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNdSMW7dsWFsZFF5bsrPWkmRm6KrddpezjJqos8Iws4=;
 b=ZGr/xNETnvRFfjh5bUCOaOiO7vKDe1HPtTQkvATCfe0mNOKOWsMdac6Q+dti1bLE5nxeh2pvR6tcQSXDUkS8LSjBegMBgridMYuEEswd4xIkes0B+IP8q1P2toQJwjwxIJyzR99mVY/5YN1KPieqrvWML0XY4sUCzsD9hiKF4Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 07:30:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 07:30:48 +0000
Message-ID: <9befea1e-3811-47c1-8a4c-47fade1a4347@amd.com>
Date: Mon, 29 Apr 2024 13:00:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240428070801.376129-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240428070801.376129-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f83db5d-97d6-44b9-7f40-08dc681e49cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXBtYk9saU5ycWJqNGt2Wk0zTmx5eWZIN0p5K0c3cWZkWlhIY2Raemt5M1E4?=
 =?utf-8?B?aDNmT1k2Y2ZyMm04Ymd0eFNIOFdJMklhVUh3eU1FaDdaMDlOdUMyZktCK2hD?=
 =?utf-8?B?KzdjYk16bWMxZGVlbHFUaWZ0cm1yelJFY2t5YzRPQzRqOStjOG4yRU51VjVq?=
 =?utf-8?B?MnltMVFUaFhlOWNyN2dUZTNqNVN1dFhPUkFVczBZL09VU1NwNC9sUVFEc3Zv?=
 =?utf-8?B?Y3E2eHRPVlNmY2t6eHJ3czVqL3E4RlJ1WWdaeUlyR3JzclNLcHp0M0YwU08r?=
 =?utf-8?B?ektzd2Q3WlppcnNwUnFQR2QzL1haMVVqdmhac3hBVDNYN0p1UUhtdm9SaEpB?=
 =?utf-8?B?QXY0ZlVUdlFpVnovWUt4RnRSTkpJWk9SeCs5N0pYUm9ReFNIZFRhRTUrWHBV?=
 =?utf-8?B?RnA0NTFjOGZ5aFdmdlRQQ2cwcGJiSC9IRW8xNDBiSHBnT2xrUW9aSVlJNnRx?=
 =?utf-8?B?emFZcE1uT1FPODhkVUxmcmF0cTFnSDRDbHUrL2NCREdBSEpnR2ZCbjZYZ1Ji?=
 =?utf-8?B?em40WHJtUzFCQU1TV2RtbVBCZUl1amV1YTlCNjZmRXd2dUNMWk9ENHB3WE44?=
 =?utf-8?B?eVV0OWlCbVJpRnlHTVlJcm5CMndBd0JhdkRYZDZ0RC9VUm02L2Nudnd3MFVX?=
 =?utf-8?B?dWVoak53WVdlRC82OVFnTWk3N3JJMmx1aldzYURTanVUSTlpNlZSRS9aNnpL?=
 =?utf-8?B?cjZzZnRuUWVsNTBGYUZ0K2RxNlhCZ3lMMnM1bHhMemFndzFzSVJNL29uck8x?=
 =?utf-8?B?WVV2STdtTnkyeEdLTnhKY05FNXhidjdBOGN1dkZOemg3Z1AwWjQyVWlzOWVT?=
 =?utf-8?B?QjAxSzNNT0J2NE9aQXQwTy9CZmJWVzM2RkU2RENucmlXR0FQZ2lnbk5zbk5O?=
 =?utf-8?B?RlJFazk2NkZhdnlJV2ZCR2RJMHlEdEtqREtWblpvWit2dmRFTWw0bmxRTjJD?=
 =?utf-8?B?U1lsMGlVdytNRzFBQWJHb09Zd3FSNEFMR1I3UVBtbmROTkxSREdJRUhyeWxS?=
 =?utf-8?B?RUxDUmpUTmNTT0VZZDRTVEpEL21IZzdsR2Q3VmdzaE9TUlZuUHdrM20wcWps?=
 =?utf-8?B?NFpab0htQXI5S1c4RXl3ekR5Vm9RcjQycGl1SU91cW4rT09vcHFHVVRjTm1H?=
 =?utf-8?B?RjNkdWRxSkROVkhuazN5d0NmTk9UdnFNNEVwRFFZTE1ZeGlXUmdZRS9CV2pJ?=
 =?utf-8?B?TC8zcHc2dG1CK3F1YnNzS2owbk1uWjNUS01Lcm11dmNYMU5mV2dnbmYwS1F3?=
 =?utf-8?B?eEg0S0dJeFNCbmlacCsrZTZVY1BWZGdBeVpNbVF3UWF0d1llSVZSNVE0TnRk?=
 =?utf-8?B?Y2FGaWhLSzZhcWp4OURJamgwb2p5WVgwemFjUHBLYUgvOXFWNVlLMEt0YlMw?=
 =?utf-8?B?ZG02UkhlN0ZMVzVNdEtoR2pIRUJWMXRSUlkySmVVSVNPMEdTMHcvOG9hTWI3?=
 =?utf-8?B?L3dMU2NlNFhPNG9YWWtHV0RIKzJrNFh5YUp0aDB2dkNKaWs5SGxBaFpLZFh5?=
 =?utf-8?B?NThoNStQY0VFY09BVDZFeXVqRldHRHNEODBHVEZkd0hFMnh0Y0JHREkzWHdK?=
 =?utf-8?B?WndVa2YrNkJINytyT0tRb1RwSTJOWmprZ0NGQ0hSd2dUSmpCK2hxRUZzNVdN?=
 =?utf-8?B?bWNpZEVpRWRlOGJsVnVYYUgrWGtxY0ZReFpJR290SmladU5Oa2pXdGR0cjdk?=
 =?utf-8?B?djZjbmduTmtMekxEeUpyOHdFQWI4UUlnaXRWYlhpWGRHSjVMZnlsMHlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRnNkhodGx4RnJUeW1jcWcvNlo5cHJRejFjK2Y2cjhMdEd5ZUR5QzQ4Zml0?=
 =?utf-8?B?V3Y4Y3k0dUFyTTZaVXRTeEpkdHUzMHhscTRUS1U2SFFnTlMrbzJTUmhzZXBp?=
 =?utf-8?B?c0I0TjRlVzQrS1lNQTN4bExubCtPbVFIZU5kcFVtTVAzRmNDeVdsZENZM1NI?=
 =?utf-8?B?akpLZ1dhSVVKTU1rd25MRDFoTE12RC9NeUNEMlREU3VkcnIySWJUbWVKZkJu?=
 =?utf-8?B?MXZ1K2o2UHRFWStDa1ZrTzR2Wk5FbzIrYXduOGEwcUxOVHNLeDRJV0FZS21V?=
 =?utf-8?B?N29HM3VuMTBZdkF3UlRzb3E2R2RWOU5UTittTFpEd00wanJ2S1pSV0d4MS82?=
 =?utf-8?B?SHpIMVh6Rk9LMWQ4L2lvbkZwWHVPWXFwWkUwRGtYaUZUOXZDQ2pvUXdIbm5m?=
 =?utf-8?B?L1F1SHJqQ3ZBc1dwV3J6Wm9WTTJDRHVZU1RaR2hCRi85Zi9qdUJMWW5JMllo?=
 =?utf-8?B?VEFHZzBQdjM3dE4xVzF3RjlMbDFzellsY0doNnUyV1hpWXkrR3pqa3c3YWU2?=
 =?utf-8?B?OU1oS1BNM2NZU1pZTmRVUjNTVHlyNUdzWmhLcGE5aGE2bXVzeTN6c3FzTFZO?=
 =?utf-8?B?WWVXWVNWWWNUa2t2TlR5SFFyS3JkTS9lb0N4U25za1FPdGZFK2R4cjExRjdX?=
 =?utf-8?B?SXlzTExVYlBycGtuWUpscjVuSlB1dXdUUXBQQU11K0FiZWJDYTZhODN1dmhp?=
 =?utf-8?B?Q3Nub0VJRTVlZ0cweWpodFRZV0RZNjhyVXg3VUpuQTRieU1DdlJubjNKY2ov?=
 =?utf-8?B?emJMOGZ3dG5FTmFIcFlZY0o0SHhRSElVbEJOOWNwVzBXSUhFRTR5RTFyczRW?=
 =?utf-8?B?SnpKV1YxcjdjVW9hVzZrNVVhUkJrWHBGQ1h2eGNFOTE5dTU2NDRlWDZtRlJJ?=
 =?utf-8?B?aW9DZ0prRE5TdC9YU3U0VnE4RzdKa050ZHBGaU5OMFI2RStPWHdnSzdvdlhl?=
 =?utf-8?B?MGFpd0JLenY4Um5OdW4zeHppSG5OMy9kNjErNWt0VzloOEw2QWlmSlBjNkpF?=
 =?utf-8?B?cmEzZGRnQ01LNXJhSjByVG9UWUhDSzdNSW5CRXhvakJKc2NMSGd3RHEwdGlm?=
 =?utf-8?B?UHNsY1RIZE5zemVCWXhZZ0J1N1hldit1UTI3YTZkcVZHa3FSQjJ1c2R0em5O?=
 =?utf-8?B?V2NhVVh1RHdSU09nbkkrVUFEaHhYSFZtd000UTduWXBqOVpqUnJlbXFNQ2dl?=
 =?utf-8?B?MzM5UDY4M0EydnRyRHR1SklTMGljZXlvTVM3clZ6dk5nVjM0dmdiVWFVc3dU?=
 =?utf-8?B?bGc0alFwWmJMMTFZS2hCRTRHdkpvSW9yUml1cGJsaC9LVkYvR3hzUldDNExw?=
 =?utf-8?B?bFlvMkxiNDAzZFJBL1AwSzdEOUdWNTBBQnB1TS9MMUlCaDVtZjgxemNiN3V1?=
 =?utf-8?B?VHVzSmM1bDFyYkFGYW1HeHpyRzVJVFFMRThQd21XRThPUWFNMEZINTZ4TUR6?=
 =?utf-8?B?VERVOHFLK3JQZm5uT1pXbXZKQitoY3RUdG45a2dVNERHZjd2UEUvQXBnV05X?=
 =?utf-8?B?MHV4VmEyTXhEaE1MbTJzQ08zMUk0Q1lvdnd6OFdpdVpBUytkek5ncmdkUkha?=
 =?utf-8?B?Zk1HSi9mMDBKOFFKOGdyOXhzMW9qbFlJY0lickEwajBmSzN6ZW5hb1lOdEU0?=
 =?utf-8?B?ME1ITFZZM0M0QXhyaUpTdUVpZHhDYm5RUkg5V1JBQU9zRlJoV1VmaFpGblpw?=
 =?utf-8?B?U3JjaDZtNGRaMmJDS1JVYmlLTzBjZ2dxd0ZiaG1Lc1JKbGNwRVg4SW9TcFpX?=
 =?utf-8?B?SklhdmM2L1Fjb0wzQ3hHeDRiZ1lHallhWEVNM1FrZXZzT1R6WURhN2Vjai94?=
 =?utf-8?B?YmZLaEYwT3RzeFp5OG04eVE0cFJVYThRRFhCck1zOWJTZHRkMXBwK3A4VU9v?=
 =?utf-8?B?UFN3SkpEcW5CakVmcGpBekF5U1V2NzAvVFgzMG03RDU2Q0diOTNrcG1tMHNs?=
 =?utf-8?B?VlVqWm9XY3lzMGRXVk5rajd6aFVKblVRZXo3bUlpRlBwbHI5c2dTNkFMaGZ6?=
 =?utf-8?B?UE1Lc3JHa0tWNGtFTVdZYks2OTI3YkdiUDZKeUdWMkNMZ2NDNWNGWTloUnls?=
 =?utf-8?B?ejErQWNPRitIWEZqV0NUVCs1UmkxMG5pWlVOWEJueWJ2NjUvN3A0QUVxM1lM?=
 =?utf-8?Q?MmL6fo+bP1N9g7q51yPMtb69x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f83db5d-97d6-44b9-7f40-08dc681e49cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:30:47.9936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysGuLQHafs3qdR48Omb/cNFZSXkMTI6LxIW+HwlqL/ydBZdVDZWkuZpASwC0moIz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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



On 4/28/2024 12:38 PM, YiPeng Chai wrote:
> Add mutex to protect ras shared memory.
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 121 ++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
>  3 files changed, 84 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 5583e2d1b12f..fa4fea00f6b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1564,6 +1564,66 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
>  	}
>  }
>  
> +static int psp_ras_send_cmd(struct psp_context *psp,
> +		enum ras_command cmd_id, void *in, void *out)
> +{
> +	struct ta_ras_shared_memory *ras_cmd;
> +	uint32_t cmd = cmd_id;
> +	int ret = 0;
> +
> +	mutex_lock(&psp->ras_context.mutex);
> +	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
> +	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
> +
> +	switch (cmd) {
> +	case TA_RAS_COMMAND__ENABLE_FEATURES:
> +	case TA_RAS_COMMAND__DISABLE_FEATURES:
> +		memcpy(&ras_cmd->ras_in_message,
> +			in, sizeof(ras_cmd->ras_in_message));
> +		break;
> +	case TA_RAS_COMMAND__TRIGGER_ERROR:
> +		memcpy(&ras_cmd->ras_in_message.trigger_error,
> +			in, sizeof(ras_cmd->ras_in_message.trigger_error));
> +		break;
> +	case TA_RAS_COMMAND__QUERY_ADDRESS:
> +		memcpy(&ras_cmd->ras_in_message.address,
> +			in, sizeof(ras_cmd->ras_in_message.address));
> +		break;
> +	default:
> +		dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	ras_cmd->cmd_id = cmd;
> +	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
> +
> +	switch (cmd) {
> +	case TA_RAS_COMMAND__TRIGGER_ERROR:
> +		if (out) {

As NULL check for 'out' is done before copying, better to do the same
for 'in' also.
> +			uint32_t *ras_status = (uint32_t *)out;
> +
> +			*ras_status = ras_cmd->ras_status;
> +		}
> +		break;
> +	case TA_RAS_COMMAND__QUERY_ADDRESS:
> +		if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
> +			ret = -EINVAL;
> +		else if (out)
> +			memcpy(out,
> +				&ras_cmd->ras_out_message.address,
> +				sizeof(ras_cmd->ras_out_message.address));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +err_out:
> +	mutex_unlock(&psp->ras_context.mutex);
> +
> +	return ret;
> +}
> +
>  int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>  {
>  	struct ta_ras_shared_memory *ras_cmd;
> @@ -1605,23 +1665,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>  int psp_ras_enable_features(struct psp_context *psp,
>  		union ta_ras_cmd_input *info, bool enable)
>  {
> -	struct ta_ras_shared_memory *ras_cmd;
> +	enum ras_command cmd_id;
>  	int ret;
>  
> -	if (!psp->ras_context.context.initialized)
> +	if (!psp->ras_context.context.initialized || !info)
>  		return -EINVAL;
>  
> -	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
> -	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
> -
> -	if (enable)
> -		ras_cmd->cmd_id = TA_RAS_COMMAND__ENABLE_FEATURES;
> -	else
> -		ras_cmd->cmd_id = TA_RAS_COMMAND__DISABLE_FEATURES;
> -
> -	ras_cmd->ras_in_message = *info;
> -
> -	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
> +	cmd_id = enable ?
> +		TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_FEATURES;
> +	ret = psp_ras_send_cmd(psp, cmd_id, info, NULL);
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -1645,6 +1697,8 @@ int psp_ras_terminate(struct psp_context *psp)
>  
>  	psp->ras_context.context.initialized = false;
>  
> +	mutex_destroy(&psp->ras_context.mutex);
> +
>  	return ret;
>  }
>  
> @@ -1729,9 +1783,10 @@ int psp_ras_initialize(struct psp_context *psp)
>  
>  	ret = psp_ta_load(psp, &psp->ras_context.context);
>  
> -	if (!ret && !ras_cmd->ras_status)
> +	if (!ret && !ras_cmd->ras_status) {
>  		psp->ras_context.context.initialized = true;
> -	else {
> +		mutex_init(&psp->ras_context.mutex);
> +	} else {
>  		if (ras_cmd->ras_status)
>  			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
>  
> @@ -1745,12 +1800,12 @@ int psp_ras_initialize(struct psp_context *psp)
>  int psp_ras_trigger_error(struct psp_context *psp,
>  			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask)
>  {
> -	struct ta_ras_shared_memory *ras_cmd;
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  	uint32_t dev_mask;
> +	uint32_t ras_status;
>  
> -	if (!psp->ras_context.context.initialized)
> +	if (!psp->ras_context.context.initialized || !info)
>  		return -EINVAL;
>  
>  	switch (info->block_id) {
> @@ -1774,13 +1829,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
>  	dev_mask &= AMDGPU_RAS_INST_MASK;
>  	info->sub_block_index |= dev_mask;
>  
> -	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
> -	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
> -
> -	ras_cmd->cmd_id = TA_RAS_COMMAND__TRIGGER_ERROR;
> -	ras_cmd->ras_in_message.trigger_error = *info;
> -
> -	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
> +	ret = psp_ras_send_cmd(psp,
> +			TA_RAS_COMMAND__TRIGGER_ERROR, info, &ras_status);
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -1790,9 +1840,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
>  	if (amdgpu_ras_intr_triggered())
>  		return 0;
>  
> -	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
> +	if (ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
>  		return -EACCES;
> -	else if (ras_cmd->ras_status)
> +	else if (ras_status)
>  		return -EINVAL;
>  
>  	return 0;
> @@ -1802,25 +1852,16 @@ int psp_ras_query_address(struct psp_context *psp,
>  			  struct ta_ras_query_address_input *addr_in,
>  			  struct ta_ras_query_address_output *addr_out)
>  {
> -	struct ta_ras_shared_memory *ras_cmd;
>  	int ret;
>  
> -	if (!psp->ras_context.context.initialized)
> -		return -EINVAL;
> -
> -	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
> -	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
> -
> -	ras_cmd->cmd_id = TA_RAS_COMMAND__QUERY_ADDRESS;
> -	ras_cmd->ras_in_message.address = *addr_in;
> -
> -	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
> -	if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
> +	if (!psp->ras_context.context.initialized ||
> +		!addr_in || !addr_out)
>  		return -EINVAL;
>  
> -	*addr_out = ras_cmd->ras_out_message.address;
> +	ret = psp_ras_send_cmd(psp,
> +			TA_RAS_COMMAND__QUERY_ADDRESS, addr_in, addr_out);

return psp_ras_send_cmd() will do.
>  
> -	return 0;
> +	return ret;
>  }
>  // ras end
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index ee16f134ae92..686023918ce3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -197,6 +197,7 @@ struct psp_xgmi_context {
>  struct psp_ras_context {
>  	struct ta_context		context;
>  	struct amdgpu_ras		*ras;
> +	struct mutex			mutex;
>  };
>  
>  #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index ca5c86e5f7cd..87f213f92d83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>  
>  	context->session_id = ta_id;
>  
> +	mutex_lock(&psp->ras_context.mutex);
>  	ret = prep_ta_mem_context(&context->mem_context, shared_buf, shared_buf_len);
>  	if (ret)
>  		goto err_free_shared_buf;
> @@ -366,6 +367,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>  		ret = -EFAULT;
>  
>  err_free_shared_buf:

This error label is used at other places as well and that happens even
before acquiring the mutex.

Thanks,
Lijo
> +	mutex_unlock(&psp->ras_context.mutex);
>  	kfree(shared_buf);
>  
>  	return ret;
