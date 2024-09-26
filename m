Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AD1CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC01B10EB32;
	Thu, 26 Sep 2024 09:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1H4z+6W8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1D710EB32
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcxFUU15OeZYOXIMv4+sIYK4vLgce/ny9IefKryQfNSP0IFIu2SVYRTdg3Nt7KOvS1n/FgnFFL3163RDrgqBJNKv/ZVcRvusbnEzqviQv7FoVp+xbkptrekh8qDANIx0FUQF1LhAjsG6/XnChmDyhLmXPyog5Z4AFe0S14cnICcXBCJz7l/IYwNAG6L8W2n1RRgogioh/BNP2RgNNW71hUnOHtLwGHy23WjjVKe3TuXc5ttmA6FdKlAExxsO12vKN8psuP7rWkxfxw4dcBUrnXNFzpIdi2d8d3G83sf4CUPkliOqNr8C126NaeDGhp/treHe9AOciPwx1gs76pK1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cry3XtOB9o+uOAaR9kZgCGZ8J8+6G6JkvE2AN8RkwWM=;
 b=uBiG1ZJYuVJv6dB25uG+z2EbBbLVZL8zZHuKRYkR7ehyEQjVsRKaBIMltslWIq+5zKzWKZB2Y5yssd15mDMUGgAvW973nbJdpIZj7ynguR4PInEUa3o/65QpkZtTSrxBynzlTRicyL8gzj/Pjb4dSWnoyjYquWg/WXKUTC6ds6pRIaTww8msXgAIvbp1pl44PmfuAB9cindsI1faHkYPJI0V+CAQpKggjQRvA7TLq0m/AoFk4wchAM21rNAiNkz+1BTzwCqcysa1d96GFE9Pvm8Ci6QmAxbdENBbRx7oovbS+4mxu2KZS3y9D4enqyu0RWEJ85DfEExWJ2bQnY4zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cry3XtOB9o+uOAaR9kZgCGZ8J8+6G6JkvE2AN8RkwWM=;
 b=1H4z+6W8/M6pUbvvyUeCbiHxzeEe9OjyC+fpCbGK9Vev0vINpzlvuzZgi3a2mygF4M2EV81bY2JPT3X2gzaOytXg9TWzfxbbki1VRo/XaLyYSGrh+23XjP12IT6ZTfKh81CPHSrb8bYsbZe/hVBH6qbUB4ar6lMYMnFMtayOdgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Thu, 26 Sep
 2024 09:27:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:27:58 +0000
Message-ID: <a760b202-560a-4824-8362-1e9a9fde2dfa@amd.com>
Date: Thu, 26 Sep 2024 14:57:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 75574e15-c67d-4ef1-7692-08dcde0d8234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzhrRWZ2dTh3Z0VEVEx5bmhGaS9wdWZoQ3VkRHE2N1d0U2IraUFEQ2ordVdu?=
 =?utf-8?B?MVJnaXJVT0VEcjkwaWs5eWQzQVpFMkdRemhoN0hzMGNGdWF2OEJlZnhQWFdJ?=
 =?utf-8?B?d1RjakhTK0VabFBxL05COXgrcGpNb2pEVEs4NlRSRW5mMnNjdDUzUkJzTVFt?=
 =?utf-8?B?NkdUWEFjbnhMeHBBY1FiczRqN1ZwK3BRTnBWODNuUVBOcUdQaElLcnlPbisv?=
 =?utf-8?B?UU1tbHpZUTNXZmVtTUlDeDV3a3dvUDJUOUJzVW5sZmJ5WEdObE53R2w2Nm5F?=
 =?utf-8?B?dUFDam1CUnF3V08zZ000UTRiaGJpOVlQakRDdmd6LzFmcTVNU1lycXlCUkZH?=
 =?utf-8?B?UUJwY1o2UHAyb3dkTy9OMXJ1RXBucVVUTHBxREdIa092SEVmT3dpZmRKTVBY?=
 =?utf-8?B?cTFsOEJZMTlWUDNFOWdOSHM1NFg1Tm9vbXRLaDBXNWhkQ2NWOUp2R3RtUFI2?=
 =?utf-8?B?aHY4Qi81ZTk2VnY4Nm4rd1EyYUZNTjllaWtabUg5N1NNRnRwcHhrekdkVWkw?=
 =?utf-8?B?RUxBdmpZS3c4cWxLeEpyR2JleWxCQUlyMVpmY0t5alRXR2F6cGpIbU9HZnNE?=
 =?utf-8?B?OVl4RkVKOFg0VlJmVnZNUFF3ZHpNRmdBeUZZQmc1NHNXV0VFaHEvK210eEFK?=
 =?utf-8?B?SlZlVGlueUxWdEVoK0cweHR3RWF4Z09ZbDZaMk8vM044QWg4L21tRVRmcDVm?=
 =?utf-8?B?cDllVnJ6OWE5SGY4QVlDVXpsWlZUOVh0WHl3bmJBYzdiM2R5YU9hb3NnU2lB?=
 =?utf-8?B?NXBVSUl5K0FzVWZSZkJIZWtYeVpqK2M5ZFBOZ2V1NUZpTGYwcHNmZmdXSDNH?=
 =?utf-8?B?WW14cTlOU2cxTlZHdnY3RWlkVytGVk93blh3NzN4OXh4UkluUnl3SmlQaWN1?=
 =?utf-8?B?VFkyYk1RTEtDODJWc2NSWW9RUGdXNTgwQnF3WjVvbS9hQ0t4d2JxbHVnUFJj?=
 =?utf-8?B?U3hjR0tiZ2RTcFBjNFQzbjFPdjl4ZlZiSTAzNjZjV3ZwYjJiVTZSMFVEV1R6?=
 =?utf-8?B?Qjc2QW12SEpsNTFybHhWVVEvZTROaTduQnU3aXhTOTNxWjYrMGtxcFU3VElV?=
 =?utf-8?B?RkNRUU9VcUhpUzlGN2lDUHBKK0FaeUtUYjVCYVdSdEdkZUY0ZUJGK00wV2lT?=
 =?utf-8?B?YWxHQ3VCeWVJcWFiVVBJSkRjWk1ObVV0MXJWcVc0NS81M1NiTW1WYzdSSDNn?=
 =?utf-8?B?MFFQOUVzRUpmekRLbDJoR0RZM2ExZDIxMVF2Vzd6OENIaXdMdmFWejloNDFS?=
 =?utf-8?B?MkZDMHFyb2JrSmQ0UHdGRHhmbWtpTjJOTTlyclcyT1FCNzQrY3NxQk1jMkhM?=
 =?utf-8?B?dlV5b1cvajBrMnU0VjVVbmpBOXhxeDBGUXQ3cG9rVEt3N0VHVGZNL1MyckZu?=
 =?utf-8?B?Q3BPeDdieElEZFpXWHR1SDBDN3B1V3VDSDQ0RG5VUkJicjJwd2tzVXNiUXdv?=
 =?utf-8?B?TGZtcC9rRjNMZEtrSXhaTy9YRmhCZ1YyM0pSdFpVZHc2c2wxUG5HTkZmb2VY?=
 =?utf-8?B?eWRESTR5QXdDMmpjb3RnT0ZVcHJ2ZW5QM2owaUtQeFZqazhkbmZZOFRXQ2U1?=
 =?utf-8?B?Szg5WWhxNDhvOGZldTdUOE1iNFlKRjg4U0EzRVFaRTd2QXRHS1MvRGMxMmQz?=
 =?utf-8?B?ZnhmQktseHdwSzJSY1N5b3l6MU95djVVcE9jZGhCQVN3TmlhQWlYZnQ3cW5M?=
 =?utf-8?B?WENxZXdSK1hoMnZHVGlFVHhJaHpnUjBnMVVLOVh6Q2UwUkcwVG90MHRMZGxi?=
 =?utf-8?B?QnhqaC82MDVrcVdLcXBIaEYwUVBMR0lqUEZxSmcvWFpjUW1tSEk4eDRmTW1w?=
 =?utf-8?B?dlYzTStMTkZrR1UyV25IZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG8yWTJIQmpLeVNqdkcxYWJZVytTTWVBRmVTWmJIVXNpaWE4WnJDYjBBcERC?=
 =?utf-8?B?Tm9kK1VtTDlQVFUvT3RuZjg5QXF3aU4yZTlkTkRxWWJOQTJjOTF0NGw2eGZO?=
 =?utf-8?B?MDc3ZWdhaUNHaXgxY2Z3RHNyalg3bEZaSXRTVFhpNCtiUzZsQyt5b003U2cz?=
 =?utf-8?B?cHlvTmxiUTA3Z0RpYUg2Y3JUY3FBWWZKaDJGVjl1M3dkeFBpZksvR2lqR3RJ?=
 =?utf-8?B?bDg4SGoxU0c2VzJOTkxZL0QzMml4MFdVYU9QWGdWdXg1bjViRWd0Wkw0Nlph?=
 =?utf-8?B?am5BZUtoZHZjS3RPZXUyM2hrbmpZa3JMZmlxTzdTbUNIb0NFVzNtWU5VMkRm?=
 =?utf-8?B?ejY5UjhaRzNkVkpSWmNWMWZXY2UxcVo3ZVprY0h1MHFUT0hwclZSd25hRUE0?=
 =?utf-8?B?U2Mrd1BVbU50NTA5ZXhpZVJsOTZSODc1UWgxZ3lZcEVyVCtZenkvUHkwM0xU?=
 =?utf-8?B?UmM5c2FNWlRBOUpKQ1VWUTlNa3lPcnVxc1lxekRPZFVxWmV0SVBaSXNYMklz?=
 =?utf-8?B?RzJCREc4MDdKb0ZSZlN4NG5pTVZxckxodU9SbnlkWmdJaTAycnlIQUwvcTF0?=
 =?utf-8?B?M3loTnkrbVBxY0xpbmJHaUtHN2x4NDZPUTk0OGtqYkhhTjhGNkczSzN2QXJI?=
 =?utf-8?B?dExSeFNIWTRqREMwUVZ1WGFPaVFoSUFOVDhwQ0F5b0g3ckxITEZYcGdpUjdL?=
 =?utf-8?B?SkQraUhFVkxXT0RhUWs2NHBrd2dYTGh5Q2NicENibTArejh5MEVhTmxhYkpz?=
 =?utf-8?B?bGdTemtTMDBpMG1BWXhNVFY5RzNIR3BxYS9GUWUvWm9BTTdvZXdEcjY2Wjhk?=
 =?utf-8?B?RDhPT0NxRWNrdDBpKzROWlp1bkVTSjdXaWRwM0dOMndLajRwMFgxdksvMnV5?=
 =?utf-8?B?c3VVK3Z6YTBxejlZalA1VHB6S2t4d05FTUlFRExnUklyMzNYY0ZlQ084YlVl?=
 =?utf-8?B?TC9OZEliS1VkTEZwUzJVajR1ditiUU4vV05Dd2w4MHBLQXJMUDFrR3dBek1p?=
 =?utf-8?B?K0IwSVlLTUZpSklZTmxpQXovS1MrQXA0R0Jhd3k5cGMxRXdWNUhIdThZMjdY?=
 =?utf-8?B?eWpTSENFT2szSEE4ZTN5YllOek50Snd5S281bERVK2JWaEVRS093T0h4d3pX?=
 =?utf-8?B?cjVNbC9NZTdnRDJPRDdUM1ZHZTJIYlBmdGQwb1FVcTN4WDQxcDZrc2xlUldm?=
 =?utf-8?B?eCttMzdMZjlnNGRBMEpYRXVrbFBaVmJuVnVUOVlwbmJ4VDBNcTN3eEJqQzBk?=
 =?utf-8?B?Q0xMRk1oWGVyRUxYMHlLd2FRdEs5b2JtQUlvVHFjMXRSd0FMSVYzOW43OEli?=
 =?utf-8?B?NkNWcFJIT0Ewd0NJVUFIRDFGa3R1MHYvR0dNSEVIb0ZSZzY3TWdNbG9YTlNj?=
 =?utf-8?B?NTFSd1ZGb1A4eDlEOUpYdm9OVmJqOFVjSWdwZDhrQTRGSVpOM0JURHNRYXBi?=
 =?utf-8?B?VnhZZTVWZkNxQkVNZ0Z6RCtVUFdCWDFFaUxKbDhNRnB1RVdYQWh2Z3VQTTlz?=
 =?utf-8?B?ajZnWUZuV2ZsT3pSNzFOaWtqVU1CZzJiYlBJbm9aMUlvTDZSTDY5YkRNTE9B?=
 =?utf-8?B?Q1pidHJkQytIVmpjWHF0QUhWLzZKMm9ESmIxdTJNOWFvQ09qeGh1aUlHSUs0?=
 =?utf-8?B?eE45UlZiQ2FHRS91RStsdGtZVXMzck5vT1lvR3VDQzBVRmdoa0gxL1Q5dTNr?=
 =?utf-8?B?T2ZEWlp4bDdFaDc3STIwcmpZcnpxaDg0bEQ4cUgvY1YrVzdBdmNmenBnYmVz?=
 =?utf-8?B?SytSdkRVMUdQY0phSjYwWWszbzBNa1RBWmlLSUN4K1Brd0FzWU1uWWJ6Ukp5?=
 =?utf-8?B?aXViM2lIazZaRzBBQ285SG40aHJlYUY1Q3pUZVU3VjM4SnE1aVVVZ1d6VGpv?=
 =?utf-8?B?UWhhMjZLbVN3QU5DK2JFb09oUXBoNDA5dXR6VlJyUFBjaEpJRjRlRDdNQWdM?=
 =?utf-8?B?WUExQWpDLzA2RW16UFJGaXAxOGdoVlNqVUMvc2pGWDhyMEdUaWZ1YnZVUUts?=
 =?utf-8?B?eHU4WitEUlZqMTl4N3RZTldaeDFVRUJ3M1k2b0NNNW4vY2J1L1d4SFdSOS9r?=
 =?utf-8?B?M3hHckdEWkM2ZlFtWGR3N0pIS09TMC9zZlptVGM3aUROY3BNa2ZPVTY3dHBK?=
 =?utf-8?Q?RPG5pPZdm052WDLd08WHbHNp6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75574e15-c67d-4ef1-7692-08dcde0d8234
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:27:58.3568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg+MA2eZvWcnZx1IDUrz7FuXH59WE0YfUx3oSiIzp8srdzdL2ZBX0pLORg7JCZQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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



On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
> Don't wake up the GPU for reading pm values. Instead, take a runtime
> powermanagement ref when trying to read it iff the GPU is already
> awake.
> 
> This avoids spurious wake ups (eg: from applets).
> 
> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
> about "is the GPU awake?" not about "is the GPU awake and something else
> prevents suspend?".

One possible downside of this approach is - let's say an application
tries this way on a BACO enabled device (device is visible on bus, but
powered off due to runtime PM)

	Get current clock level
	If (success) && (not desired clock level)
		Set clock level
		Submit some jobs to run at set clock level

This type of approach won't work since get clock level() itself will
fail. That said, I don't know if there is any app out there does
something like this.

Thanks,
Lijo

> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c8f34b1a4d8e..f1f339b75380 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> @@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	level = amdgpu_dpm_get_performance_level(adev);
>  
> @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>  		memset(&data, 0, sizeof(data));
> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_pp_table(adev, &table);
>  
> @@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>  		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>  	if (size <= 0)
> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>  	if (ret == -ENOENT)
> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	value = amdgpu_dpm_get_sclk_od(adev);
>  
> @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	value = amdgpu_dpm_get_mclk_od(adev);
>  
> @@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>  	if (size <= 0)
> @@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	r = pm_runtime_resume_and_get(adev->dev);
> -	if (r < 0)
> -		return r;
> +	r = pm_runtime_get_if_active(adev->dev, true);
> +	if (r <= 0)
> +		return r ?: -EPERM;
>  
>  	/* get the sensor value */
>  	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
> @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>  	if (!adev->asic_funcs->get_pcie_usage)
>  		return -ENODATA;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>  
> @@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>  	if (!ret)
> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>  
> @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(ddev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>  	if (size <= 0)
> @@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>  
> @@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>  
> @@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> -	if (err < 0)
> -		return err;
> +	err = pm_runtime_get_if_active(adev->dev, true);
> +	if (err <= 0)
> +		return err ?: -EPERM;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>  
> @@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> @@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	r = pm_runtime_resume_and_get(adev->dev);
> -	if (r < 0)
> -		return r;
> +	r = pm_runtime_get_if_active(adev->dev, true);
> +	if (r <= 0)
> +		return r ?: -EPERM;
>  
>  	r = amdgpu_dpm_get_power_limit(adev, &limit,
>  				      pp_limit_level, power_type);
> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>  	if (adev->in_suspend && !adev->in_runpm)
>  		return -EPERM;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> -	if (ret < 0)
> -		return ret;
> +	ret = pm_runtime_get_if_active(adev->dev, true);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
>  
>  	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>  	if (size == 0)
