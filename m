Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468C1CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 18:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CC010E2B9;
	Thu, 30 Oct 2025 18:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F1UNqjaA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA73510E2B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 18:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFfEyBBdH+xOVM7sVbylCSpa23LefUwXobt8XrY+oB12lp99BrsOWoYNKZwZ47p/4x5z3Pm+MZ7Hivf1FBfuPbKoXpu9dTr8zz1c8KfiydVDRkts/GI1GrlCD9jJaZY4b7+WekhBQIk53OsvNH6nnnq8GDjiu53a4trUxez8q5yVeCSair5cK7g+1YbrD/34jY2FCyqcZr8ZaLCX7cZmhxsCtzsRM/hs6wrxH7dGy6TbhlQ3z446Yx84Fq1BldN52Wklf2+UlNM6G0QnLSFQCeARTwBFTc2Lq1mIYGolI+kJXRhYl94fNtsH7WoYT20TgPbpmtkSXCd2kfSnYbzwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqa3Z9i25Y+tIfbhESdhMv043m8/Xl93S0JJeS8UsxU=;
 b=lJDnYg5XxUrOg/ieND4z8BxmWh5UDcd0A+emzQoztz915zLQnoipjT91JIGCsdUNwxxdeuBesSr2UlDVWdAjZbqAh05kpv0s3fQp3UA/QIdonPVQz4kEkEEG8pg6xcvv22pS1q1pNVuAWTgF82GF/PhM8ULWZ/nuLn+niXRmEjjR8DeAIaKhLq1Fub7/hYxTf9HlglP2mVg/Xwd6NNlmboPQd2CsgiI3qQ1nAm/8UGZA4gchfdJ2AsFB5A14fkA8RSQILJC6L8UJL0jDjgVNLWo6OWZiMA1iM/It/Je/uF9BYGRArY1ZuOHKBpBzYLQ1KWg1ysjwsUEyoRBSYhmDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqa3Z9i25Y+tIfbhESdhMv043m8/Xl93S0JJeS8UsxU=;
 b=F1UNqjaAm2tqfpjp+jVBdwe8O2EFEXWNGhWnx1I2XRzhfaM+EHtaEq6bxV488qeAf8CaRHSdXSXW7x2N+X3nSOLAMsx4YsYYYhlWJCtlazpbQbL/OxxlEGupPBoHb3hBjOMkoTyx0eQGUFwtJKj6QGlYRZbjfn0zK4NGjH3kWIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 18:32:16 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%3]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 18:32:15 +0000
Message-ID: <5b0dde88-7623-45b1-9f48-b17cf97cea3e@amd.com>
Date: Thu, 30 Oct 2025 14:32:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20251030034536.11356-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0216.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::27) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 546ec177-a401-4f4e-ca55-08de17e2a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHJBTnZpWlBPRUU0TGFPbHhicDArZExwak5pZEh5QTB5andCZHBTVXEwVU1a?=
 =?utf-8?B?Z1NrdGtDRWhMeDkvT0VSUHhKeW5ZcUdVY09ZRnF5NituUGJhOHBCU01DZjZN?=
 =?utf-8?B?T3Z3dE9KYk04bmF2dEprVFVnREo2WEZoeGF1bnhCNFRNdHI2dEZ3d3VxWjFy?=
 =?utf-8?B?N3hWdW5PY2lYaStrVEd2N3dpMThlKzZlOG1jNFUvNFRXbitOT1dxb0tVRTg2?=
 =?utf-8?B?OFNnNllPRXU3Z3FJaXZFVzdOajdSWEcyaWFNN05RdlRtOHFUeXRMVE96bks4?=
 =?utf-8?B?bjB0SE4zRERidW5hZUpUaTVyeWRGdTIrVUtKVUxRQWJlSHUyaGdpRlRuT2Qy?=
 =?utf-8?B?MHpuT3FQZjQ2T3FaWTlqTjU3Y3UxVittdUY2UVVpZ1RBU2RyQUxaRzlOSzBu?=
 =?utf-8?B?M3VZU2FKUVVhOVovd1h0MDlURkxvWERNYlZ1dVpMZWhjOUZmUkFvbVF6RFpS?=
 =?utf-8?B?SHhwZGkwbjVZdXJ5ZytpcWhSUDV1WkYzK0NoaDV4MWZqU2VpRVkwYWhuOVg2?=
 =?utf-8?B?MU40cjRvRU1nWFVBWGtaL3JwMzhnYnc5NEJKejZraDg2ei83anRvc2lpbGJn?=
 =?utf-8?B?NTAvOUZISlZleFVYUC9halFUbkE1SS9NTG92a0lMSTdGU00rRzNTVTFyT3ZK?=
 =?utf-8?B?Nm9iM1pOcHRwTy92U2J5TnlSVmRpVEJtR01ZNnA4ellJbDFtdmJ4KzVFekxR?=
 =?utf-8?B?M1ZYVVhiQUVFR2YzazFKVkVZVGN2dis1T0VCSytVWkZpZE5LZk8xaDYxd3Y5?=
 =?utf-8?B?WUc1dDI2dFpkd0NybDVwSVlGWGJPV2d6a20razV6OUdSdUVlejJPbGZqT0t3?=
 =?utf-8?B?a24vWTU3MmpKZ1I5SmlqSndFV05kVG1iY3AyT2ZtOEQ4Tnd4TWthY0syKzBk?=
 =?utf-8?B?V1JqeUFqL0h4aVU1U1ZQTkY3ZkFkbDBKRkFsaktkS0VBTzRDeTJFbUo4QlFQ?=
 =?utf-8?B?TnZ3Y1E1bmRsLzgrQ3gyNEJZWXJqaTVoclE1Tld5bm56YUh6Y2xxU2d0aHcr?=
 =?utf-8?B?VTZ2cUtqVnMzT3lZVHJid2ZsM2VPZGd4eS9XNStPQk5wZnZrbjJ3STJvS3Ar?=
 =?utf-8?B?VllnTk1SVGJ5Tm82ZlAyTG9IdGlBbU1zSWFraFFCVFJFYkhhQTVrVG9USkk3?=
 =?utf-8?B?VkVCRGU2NGVyekc1eTNmeUdhTzlVOW10blpha21jSTBRZ3A1bUYxRWJvcTBY?=
 =?utf-8?B?STFNRCtiNkZiR2RRTDhYUUxEQ0FIQkNyUU1YOFFtRjM0NWNGamU1UW9ycFVF?=
 =?utf-8?B?dHNpbnNRRUJXT2JxVDlvbDhDSERmcmRZcDRNeWQrUEJBanovWlhIUllMWVRm?=
 =?utf-8?B?OXhZcCtQVHQwZFg4TlZjRFVCZGlVQUM3Mi9WanNqRHdRMWtJSC9YVS9LSlFv?=
 =?utf-8?B?bSt0SmNPeE1QVTRuMjFGWnNvcmRNbjZzeHVzVTN6WHNiQUNldDRKQ2Rja1k5?=
 =?utf-8?B?NVQxR21lS3lBczEzWXVsaG4zSjdkQUVWRWxjeVU4SlBCbDFwQkxpelpIQ204?=
 =?utf-8?B?TVlaeXJPbmxDTEtWcktLQTdzcUUwQkU5ajd6OStqSVhieXREbE4xVU9ObnR5?=
 =?utf-8?B?SUYrNlhkYjdpbFphN0lBQ00zMDlOazd3YUg1Y3FTOWozNWpwT2wyMGpLWjVB?=
 =?utf-8?B?ajZtaEZyUzdyVVZOclh0T0ZCTldxYmw4VXdxM2h0Rnp0WkkyejIvVzVhb0FO?=
 =?utf-8?B?OEtNbnZVRDUyTEtBcHRZZlg2S2RvYzd1QVdlTzh6WXc0Rkp1ZmpBS3lhVkhr?=
 =?utf-8?B?NjVvclpWU25kZzAwSnBsOWZWd3ppRDcwWmY4UFZMYndxNUo5L21mREhqYzc5?=
 =?utf-8?B?Mm02OWRKT053bUI4cVQ4RWtPTWhEZ1ZHSTJVTVlXUGJESmlsNVI5MXNzd3lD?=
 =?utf-8?B?c0RxVzQvdVN2TTZpamMrOVE2OWFlUUpDam9nZlVqSVF2alF0ckV4K3o1V01E?=
 =?utf-8?Q?bZz+os6671oteHp9URcFfuVD8+st2n5l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3hjODZQVmhVeWZ0V2RWdzdYcWtpZ3lyY2c5TW5FV2p5bUVsZHBWMExIdmk1?=
 =?utf-8?B?YlMzZE1Ba04renVKak4wMUJuaVVrQTFRWGdMaHdQUGdwS1llSS9iNEk1ZU95?=
 =?utf-8?B?TEJzb24zZUx4Y1FyS004WmhBWnl4RXdjRlZGQlJHaFh2WlFjUkVZK1FSOWNh?=
 =?utf-8?B?cENZNjRoYmh3Ny91Y09UdmNDSTNMRjhDbEZEVnRXZDlGVmc3Z2ZBZmxmaW9y?=
 =?utf-8?B?Ym14YnZOZHZDSTlkSnBkR1U0dUIwQWs1NXcwSnc0WUxqcU9ROWhvSU1NUHNR?=
 =?utf-8?B?QUg5UE5Vby9PYXJ5eWsvY3pRdkRNOXdabXV3S2F6SVZzbFNESDV1UFB3ZW9j?=
 =?utf-8?B?U01OYnZoUnRwczdORmVTSGhXUXk4RUN1RDV3MUhvcS9Uc0xoSVJuTnRvVW1l?=
 =?utf-8?B?RjROMzd1Z3VzLzVKSlAvekJYT2JXeTNOai80MEtCZE5iczZUSG52ZXRwTmRR?=
 =?utf-8?B?cHJ4dXk2ZmE0OWRxVFVHVEZHcXhxN29TTW5BaGI4T2RBR3l3SnFhSGNMUk40?=
 =?utf-8?B?eWtDN3haSlZpc0Zrd2pDQlhRL3kzWDc3eUVKZU5WVVZPNThCbW00cXJDS3Jw?=
 =?utf-8?B?cU14K00rRXN1NW1ybXF1ejhSdEwxL3dnT3AxcmNYdm5nSmxML1dhdG11cXJo?=
 =?utf-8?B?ZmJjUStDM0RyZm5mTlNnZG1pRW4rdVlQMzlhT1djRGx6MFYyWWJEb21INHpH?=
 =?utf-8?B?VWJqTUFMR0pUb2RESytGMGZ2SFkxcFpuTzR6aE0xdDJtcklkMkR3VnVnbHZR?=
 =?utf-8?B?WGh5ZW5aWkVlc045NnFTeWRrdlQwNk4wbWE0U2N4VWt0ZnlxNm54OEJjMG4z?=
 =?utf-8?B?L1ZkazNsenBEdmdBbEM3QVk4ZURGUXFQUTdiVGEzU2Y1dkZTQkw1MzNtVk1T?=
 =?utf-8?B?ck5aTHhFQVNaeWNCSk05ekpVMnVzTzdxUFYxMTdwakYyZ2hiS3RPYmVVR1Q2?=
 =?utf-8?B?blZkdWNQQlAvUkttSmxDRzNqbnRaRlQxbHZLS0RhbXFpeDE2NkEyQmR2N2dT?=
 =?utf-8?B?djA5V21HcERoMTRaTTkzQnJiVkFQTDBqQm1BZTFtM3B0cWRMM1VYSXhlbFZl?=
 =?utf-8?B?NHpoZ05lM04vRWNwUDlLRFJNeDUyeGl4ZXh4RUp5UXpmRWUwWm5Qakw4UXAw?=
 =?utf-8?B?Tmc4VGNjQWF2RzJtODdQZmMzL3Jnc0R6ejgzMDVZTjB0RXArakxlTlJHa0Vv?=
 =?utf-8?B?RUxGRDAxOTRXSHZ5WE1kUzBGNUFBSUhmZG92L29NYjFxTVNVZVpuM0xZak1R?=
 =?utf-8?B?NmxxU1BTWmMrQ1FtOXJ0QktMWURSWHNmUG50K1MrWDcvUDI3OCs3cS9kenpw?=
 =?utf-8?B?dG1DZEsxbGk4NkVoOTdmVlNsTTdTUi84M01UQnphbjdzbWNjT2U1YVA4L1J1?=
 =?utf-8?B?aktNeG1kZStQUHJmaWpyZjVCd3krSDk2MGIvWlZhOTVZUTNMREM0WVJsL2xv?=
 =?utf-8?B?Z2xpc2RTYisvY1Q5azNEQmpubHB0eWp4am0rVkdIazFWWFZvNEo4c2g0MS8v?=
 =?utf-8?B?R2w2RHN5S25vcHBmTEpROFcyTGd1R24zbWQwWXNMWTY0WnBHdWpCNy9YNGMz?=
 =?utf-8?B?UlFWU0hTTzJKVFJXeUFSQ0FGMjNwZ1NhVVJCTnNqRUxaMDNJd1BmMUlydEVx?=
 =?utf-8?B?clBKcjRJSzgxa1kvTkJwRzZhZWNKQXg4cFh0QndSVlAzdmdOaXhKbTUrV3pC?=
 =?utf-8?B?WFlCQmpDNXd3cHBMUjdIRFdFb2xjQjVpQVRRS2YwOFRmeVRBcnJQR0RSUGp5?=
 =?utf-8?B?aDJtYlI3RWozTFM0eWEzVnEzbVJFQlF2eVNMK1ZrWjBjRkdWaDBhT0JUN0hW?=
 =?utf-8?B?WElPeFZpKzBsOW4zT25KVUZjeXBYbnVTREpYc2xSNC85QXBLVm8xSUpXVS9X?=
 =?utf-8?B?Y1luNjQ0b1ljbU1sSUduSmJmcHJxckxxK2xiZEI3elV0YzN0WjJNb05ORmUv?=
 =?utf-8?B?VmR5dXUrR05WRlNOVTlIVHUxTHhuZzc5NFFjSVltTmo5VFlZMUlKTnByendX?=
 =?utf-8?B?SU1vZ000ZW1KWnR5dnJja2xWZGlTVEZXcHl5UjArUHNzOXU1bkp5Smt3M1Nu?=
 =?utf-8?B?MGJiV2I5dHU1QnRKbzJzbHFLa2lCWUZZQ2RnOE9hRmhCQTNJVjcvY1FzVU1a?=
 =?utf-8?Q?mncZLxmP6sAXQzRwlejwxGG5I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546ec177-a401-4f4e-ca55-08de17e2a660
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 18:32:15.7202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5QbkzRwVuYSZGumuK4tvnnamCEhSpZZW0kyKStt7ksro5ydSHCazUoW8PxeXShHg/9Ph0YW9+44xBtiB3ynMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

We already have pasid in debugfs under 
/sys/kernel/debug/kfd/proc/<pid>/pasid_<gpuid> with my patch 
"drm/amdkfd: add pasid debugfs entries", so what is the point to add it 
in sysfs?

Regards,
Eric

On 2025-10-29 23:45, Zhu Lingshan wrote:
> The pasid is a per-process-per-device attribute,
> therefore this commit implements per
> struct kfd_process_device->pasid in sysfs
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>   2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 70ef051511bb..6a3cfeccacd8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -864,6 +864,8 @@ struct kfd_process_device {
>   	bool has_reset_queue;
>   
>   	u32 pasid;
> +	char pasid_filename[MAX_SYSFS_FILENAME_LEN];
> +	struct attribute attr_pasid;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -983,7 +985,6 @@ struct kfd_process {
>   	/* Kobj for our procfs */
>   	struct kobject *kobj;
>   	struct kobject *kobj_queues;
> -	struct attribute attr_pasid;
>   
>   	/* Keep track cwsr init */
>   	bool has_cwsr;
> @@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   					int handle);
>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>   
> -/* PASIDs */
> -int kfd_pasid_init(void);
> -void kfd_pasid_exit(void);
> -u32 kfd_pasid_alloc(void);
> -void kfd_pasid_free(u32 pasid);
> -
>   /* Doorbells */
>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>   int kfd_doorbell_init(struct kfd_dev *kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ddfe30c13e9d..24cf3b250b37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0)
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> -	else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strncmp(attr->name, "pasid_", 6) == 0) {
> +		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
> +							      attr_pasid);
> +		return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
> +	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   	 * Create sysfs files for each GPU:
>   	 * - proc/<pid>/vram_<gpuid>
>   	 * - proc/<pid>/sdma_<gpuid>
> +	 * - proc/<pid>/pasid_<gpuid>
>   	 */
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>   			 pdd->dev->id);
>   		kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>   					    pdd->sdma_filename);
> +
> +		snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
> +			 pdd->dev->id);
> +		kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
>   	}
>   }
>   
> @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   			goto out;
>   		}
>   
> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
> -				      "pasid");
> -
>   		process->kobj_queues = kobject_create_and_add("queues",
>   							process->kobj);
>   		if (!process->kobj_queues)
> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   	if (!p->kobj)
>   		return;
>   
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>   	kobject_del(p->kobj_queues);
>   	kobject_put(p->kobj_queues);
>   	p->kobj_queues = NULL;
> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   
>   		sysfs_remove_file(p->kobj, &pdd->attr_vram);
>   		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
> +		sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>   
>   		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>   		if (pdd->dev->kfd2kgd->get_cu_occupancy)

