Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E43C02187
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 15:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F9110E9AC;
	Thu, 16 Jan 2025 15:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeHwwghM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE03710E9AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 15:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHJTM/tjrBdIg68g7knbsg43tc8gY042I2zk7XegfXQKeH+vnalTrRjyM/WTrDeWlwcneBYNIvsxcJqkRlLTFy8fUy4SrgnYAk+fv513bwnUSIq0S0586AMfqfc7IWTm8Sr7RQCSeFap57N5weW9mqgxsur35LX+1NntmYZhKuVZ1AalE7bBAphopiyEgC8vJK+8LRTWwymFc4oz0r7idGVLGtwkMiTnuFq8FUEs+wzfkhRAhJ/ZG9O2VBQQcTyfLTlDEa663EKZpb254dehaZAhaSlWnUInFXvzG5ZTab7hRXkUqU6qhSZcpWBFrr3Fl+skGfy1oGv3ukYx/FQLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqhwTz1COdaXYzBZ2trF4YHV+Rqw53RO5g7kCP9ZqQE=;
 b=s13Wl6oggFWKo2sjTgraaQDbwplSZrr4FZASqZc17GTxM0TWrn8zSl7PTMpdiy3H3ecgYyVrW2sy3sqi5nDpPBh/5BIDjI7ZVF8/7JPTd5TdjHjA9Byc+LIr3il8Vcp1kLORgGzF3EFrsXoYoFjGtsN5eTuzZKLJlNaxo4dJ7IkGyHns8+EhnQ8dLaYyMTKjq20X5LVh4KhBdFWAyxnYl3AQHxdAQSyNwdeFvDgxuxb42M4rkK3Pi6qyHSTqHNLr6xC4H7U/RuEI2YInnjXHLqipIW/ggfFJFXucvQ8g34kGZ/1NSSm5cZHlJDUGfSY60lKKZMPpmD//WfDGoH3B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqhwTz1COdaXYzBZ2trF4YHV+Rqw53RO5g7kCP9ZqQE=;
 b=MeHwwghMbmYd646657E41M2MsxVFOdcKaHQj1yKnT02N7W0Lee7EqMdjKpxML0X8m/N/RGWW8oefK+2LtL+FT0d1fOvZNaHcGpCP87OOR+Ou0tYrIXS/l+t8bezkqQpVRM/vDOxylZhBCak4IG2KWzXYmfDAr72RbRr3Nb7GLzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:25:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:25:42 +0000
Message-ID: <a571353a-f321-4b8c-9998-28e36b818be1@amd.com>
Date: Thu, 16 Jan 2025 10:25:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix CEC DC_DEBUG_MASK documentation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kun Liu <Kun.Liu2@amd.com>
References: <20250114193715.3662180-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250114193715.3662180-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: d09cae17-e177-4248-ae9d-08dd36420a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1lGc1lyaGMxZ25DNkNoTlhBT0pEcG51dnllSXBmMzFlRDVpcCtXRDFPd0ds?=
 =?utf-8?B?NHQ4TnNibG9yVW1SbUpjK0lhRWp6QnQvUlhyL2Y1M01XUUN2aEdtT0RuUlY3?=
 =?utf-8?B?Ump6ZkJGbTNrM3BzYy9VNm5aRVRMUEJNRVE1aFk1elpROGVjeWlZMXg4MkRx?=
 =?utf-8?B?TGNIT1BzRkJTSHdBMTYyWUJqVGNWQjk3SWVyc2VtY28rOWRyRHJKa3JMc3p2?=
 =?utf-8?B?RlhDQ2J3a1JTY2wwQnpNN3EzVm9CdFlUMDFQOHgwRGhBZUppaVN0RXptR3RQ?=
 =?utf-8?B?ZDAyaVpFSjNlMDAvY3R4L1YvN1ZQMFQ0Y0J2bUZET1pMVnQ2SlQrQm5veGhC?=
 =?utf-8?B?VXNVT2FYUXd3TzlpQjhLdHpkdDJyR09HSjlyWkNnYlNzNHc0RGxyc0trU2hY?=
 =?utf-8?B?eEZwTnovcWV2Z3Q5QVZtWk55UnhReFNCOTgzcmR4S1Q4QXk0QUhHV2FtbUpZ?=
 =?utf-8?B?UUtIVGsyRDlBNTJUejNWMjlOTzdlRHBwSERtOVMzK0t5QjREWkdVaSt5NUFB?=
 =?utf-8?B?QWx6MUYxejFqem5FQjV3UnM1Wm10UERhVUJvY0grQVpKaFdqMU5Sbkk1SU5l?=
 =?utf-8?B?YnhCME5NYjN2aXJnTGtVVVh4QmFlSEovR0lQekU2MENQMm1ieHZRMk83U1VD?=
 =?utf-8?B?cm9tZW1YRzFhQ3hKLzFBUHVBVDA5ak5HQm5CcUx1N3NuSjVsaGJCeTBhSmZl?=
 =?utf-8?B?NDdFV0JudmE3RFhKRFpQZXp0Q2RwdlpoRXRDNDROUDFNOVYvKzJ3REQ1Mmdv?=
 =?utf-8?B?MDh1Q2M1di8xLzJBN2RuamtpTHNEYnZ6OVVMVVlTUlg3YXUwMFZyU2Uvd3VT?=
 =?utf-8?B?YUc1TG5LOFFlUXFmWUJLLzJ4TFNRcHVYbjZ4blhOVW92Z2hMNWdNSmZrbU1J?=
 =?utf-8?B?NXFtUXRFVXJDV2FNYlFmdE9GNFpTQ0I0aTRuK2g3MCtkS3hzWVlyRm5Jb2FE?=
 =?utf-8?B?SjBzQWpUUGNqcVkyejV6Wi9qVGZZTGhGWUgyTkk1UEk1WXcrT1ZjSjdST04r?=
 =?utf-8?B?QklXSFJKTzdWK051dUwzbHF3eCtuNGs3SVVKMy9qcFdVWW1aUEo2Z2c0TUUw?=
 =?utf-8?B?NUNYZXBmMEMrWGNWaUMvOTB5MGU0ajRsMzAwdUdwVkc5NGlZdTR6ZWFWUmxO?=
 =?utf-8?B?YTNVTnppQk5acHZOYTBBc0xQeUh5T0RDUjJsamtlbmJpaG54NmpGbnJMVWdK?=
 =?utf-8?B?RkF3dzZxYS9Eam8zRGluN1hyTVRMY0tSVmpWNURtWE1WVUlaUU5CNWZGbnE3?=
 =?utf-8?B?RDZOZWhUbW5qVk5xcTRyaUNWWmQ0YmlqTEdET1pYc3ZjUGQ0ckVqZVNzM1B0?=
 =?utf-8?B?aTZYb2JVcVpMdUxMM2FaQ1BrVExmYk1uS3NhaCtETWdIRDc2NHZFblBQcGxx?=
 =?utf-8?B?cFhnRlBRTnNTMStKUWNYVkpLQk5pNlVXSmdJUlhWUW51NXVzRWhiYXAwZmxU?=
 =?utf-8?B?V09CSzh1aVNnOXF0T2VlaG1aSkNzRXVnZFN2b3pOUXIwNlhsZDRwQ0tybEZW?=
 =?utf-8?B?S2xJWFRMMjQrelErZnVwcmpSREJMR2czRXVHSm5tOU4vcC9qcnZ5THY1dC9r?=
 =?utf-8?B?VFR3WEwyaHNzWkQzQUJ2WUhQSlUxK3RjMGJvd2NuNzl3UHRSaVNGUTM4SUJs?=
 =?utf-8?B?WUtwYm02K1VVS2pLOWdqVWd4UVdMa1psb1lKWmQ4NWhyM0hZWUY5VVF5dlJP?=
 =?utf-8?B?MWY0ZjJxZWxSK09nY1VHbHBwUVB6NnVpNXdLVEN0aVNTdHkzM3Z3NnNsWUVD?=
 =?utf-8?B?RDI3bzdPK2dtQ1FET1kzeWdWRFVJY0JGWTdYYkNocTdCM1JGc2liS05Wa2NZ?=
 =?utf-8?B?MStpVWNTcW94R25HUXFGeEE1M3lvSUVPNSttbW9NUUx2RG1mZzBReEREZE4v?=
 =?utf-8?Q?0ogJCLXmPOSrP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjUzdnFTOElaYVo1M29QTGYxZnRkbCtCOTVMY0srcTl0ZEsrOVhBajRBMUVy?=
 =?utf-8?B?MitzWXBFOUh2Qjh2SXlYTU1yd2Y1YUU3aElreXFLUWxZUHhYaUVld1ZzclZn?=
 =?utf-8?B?RHpVMUorOEFxZXJydkFuQkdzaURVTGRSK3E2dHlGdk56SVgyNTJERUhMV3cx?=
 =?utf-8?B?NzM0MVc4cW5VbU44VzNKRGNsL1dWS2JOamF5d29VZWJ2UHdhbDZyaXR2QmY5?=
 =?utf-8?B?dGROc04zanZ0NlZ6SVN0ZDR5WVppTHJvcll4Sk96SkFtdjhrME1zOG1hZmJN?=
 =?utf-8?B?Uk1pdGF0c3lPNnFSNkQ3ak11cmNRMk41VWVBdjdnUXprQ2p1MnhsTTR3WkUz?=
 =?utf-8?B?M2Y4a0RvTXZtYlpNditzeG9VNlFGdlVQNEZldDNmOWNyb1VyZ3diVTl6OS9Y?=
 =?utf-8?B?V3BZdFU0THFLQlJ4eUxYM2c2ME9zNm01UTVZVitNV0tTU3NaaEZ3OExPRXFE?=
 =?utf-8?B?bkpvQlZNRGdxc2lGQjBVMkR0aVMyejhtU2lMOTFab1k4azFDN1QzYlhKaE95?=
 =?utf-8?B?UDZLUDZHaVluV2E4OUQwU0JjUVNkTkRHMzdFTklOUXh0Vi9sRmlnd0ZEVTJi?=
 =?utf-8?B?cGJRS0VxeTlhYW5RWitKK3c0emh5NW9Gb1JiT3pPYUhlOEg0YTV3aGwvWWh5?=
 =?utf-8?B?bWtZUmFMVXJqQ0VKSjVvOU1JVTB2R3ZWdEdCZHI0MGpsem1HRU92NmQzR3JX?=
 =?utf-8?B?Nk45U21wT1lKSnVVck9ybDQ1WFdFY1VlZG9lakxrM2kwSnhTRmd5MjJqQXJR?=
 =?utf-8?B?Rk5FTjlYbm1WaEtvRHgzenBGS2lRNC9SZDBlY2phZndPTXFlVUdZL3gvRmJl?=
 =?utf-8?B?TmtjOUlkU3diZm00NmVGVW5jTkpSSWxWbVNDL3IxUHdrL3BPaTJwVmZDLzA0?=
 =?utf-8?B?eHJleC9CUDBDbjg5bWlaYkxtc3E4VjFJU05oK2RWd2pvdmV5RlIwaDFoOStZ?=
 =?utf-8?B?Z1JoOXh5bllzYlhUYjBoTk1URWUxUGpFYSs4UXh6dmlQRXF3dWVrcU9Jdkt5?=
 =?utf-8?B?VHZHUlkvdkx6a0VHaUlGLzI3ejNyLzRFcGtZaDExcTFtN2ZZbzYwLzVRbDNM?=
 =?utf-8?B?TXNRWG5qMUFSZEhiN1M0akh3TEtPTXc2UDVEZnkxU2JkcUhuV1ErbDZtUEo5?=
 =?utf-8?B?N1hkL3ByT241RTRlMFA4WFZxWEoxMWQvSE9SUlRDZGphazUxblNBcHZLYUhI?=
 =?utf-8?B?d2NWSUxtcEhzaUpNT2lUNTZRL3NOa0UwK2plcE1nbTJta3Z3cVl0bEtDRDZT?=
 =?utf-8?B?MHVndmdqQU5sS3czTFBXL09NWlo0aytucFFQRE5vNXA1dXFENGcvMkxVMnNE?=
 =?utf-8?B?bUp2TnFCMk5DeGlpMmwyamNjZ2JXMU5uUGtEcHFsaUxoMkJJOExyUThDNHQ1?=
 =?utf-8?B?bUY5TmhURWV6WFFjZWFTNnVwZ0FvcWd1NmlIejVoY2M3QWRjc2RQc1dyd1VB?=
 =?utf-8?B?YlBiYXJTdldYSElXNDc0cmpZektmNW12TkVlRktpTUZESStpQk5JWExZU3Yv?=
 =?utf-8?B?R3diSTVndnZxQU9DWlFxWlNSczJ2ZksyNHplMU1vUkE4UDliR1VyUFlleFpJ?=
 =?utf-8?B?SlYxQ3UwUnphVTc5clJDOVZMSFZPWVByeE1VQWZCL3ZDb2ZTdDd5Um4xWHlE?=
 =?utf-8?B?UVpaQlJZc0RIZkpoUUhmTnNOY1VSYXRvRXpsdEdWWFViV29paGNYdDc4YVZu?=
 =?utf-8?B?Qy9xRmZpT0hmdnkwNXM5YzJDMEhaRlpERlZJZ3RlTXVFV2NRMzZvZTlWTEZv?=
 =?utf-8?B?K1V5S1hYWXNyMDVkZk55RWVrRG9JNFkxeXlPZk9Oak84bXJvc0o0TlJBRUc3?=
 =?utf-8?B?YmhkV2dhRXFOK2JnRnNxWlYxQlBxQnRyNmxxMzM1Z1QrT2s2dkYvR0o1V3E2?=
 =?utf-8?B?VDVGSStvL2pmZzRoOTFPTlQwZy92dUNrU2hDRVpVQ1NKTGlBTEp1U1Z3SjU1?=
 =?utf-8?B?bFNRYmhJaURyTDVSbnRWZENTclNGaXRJYVg1REpWVHpjenVuUFdDYzJCeUhJ?=
 =?utf-8?B?aHVzcS9qY2oyUFBRdTcwamJ1VExQM2l1MS82cWdRNklTdlY5U29xYnRwRDUw?=
 =?utf-8?B?L0JkcEUycTVIeVM2M2hXeHlkczd0a08xNGlJamdLZnZ1YTRUOFlvaG90Z0JK?=
 =?utf-8?Q?oFB2MBYOpnVrAcM5SaYgP0I0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09cae17-e177-4248-ae9d-08dd36420a03
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:25:42.3164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTBJ8IgFeS8yoq8Z7qvuebzxel3qYHMEXwcVSRii4zMxPE5k+BAU/JRRH/IrQGwMuF6LI42Md7VUscMbLd9LXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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



On 2025-01-14 14:37, Alex Deucher wrote:
> This needs to be kerneldoc formatted.
> 
> Fixes: 7594874227e1 ("drm/amd/display: add CEC notifier to amdgpu driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kun Liu <Kun.Liu2@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 05bdb4e020ae3..030d99a873a71 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -345,7 +345,7 @@ enum DC_DEBUG_MASK {
>  	 */
>  	DC_DISABLE_ACPI_EDID = 0x8000,
>  
> -	/*
> +	/**
>  	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
>  	 */
>  	DC_DISABLE_HDMI_CEC = 0x10000,

