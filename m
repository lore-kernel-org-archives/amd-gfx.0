Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BCC61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 10:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62A010E762;
	Thu, 12 Jun 2025 10:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9R30BS3";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39F610E762
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 10:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQNvsnKsUw8lD+p9X8147/V+wJZI6pqUe4g/CvasryGNaGf0t4uFQuTntQke+ZCpZoghh3RMGGI87C1IAYNJBlHxP8+b6HVcSXe81CXfyjjpKWZlDrtg6hzfa6rJb24zJq0lSEizoNNSJahtqh9+dfN9UgRMwxsRzc5uUPl5k7inmT/APn0JmJmi8QMRElHVkDDQGsaj4qQyxB+dX2p0im3kq1Bt3Tck34psdTFGsm+aDsMqBrSDUdU17VREYqPOUZQ8NL+moP3kOeh0sVUlOfvae5i9JzY8hAFBHndOCdmbOFgfNATCfph8cK+Ffxu5p4pPlksfcassnAMSY/1Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgPRmLV8fWhodiSfL1ccNxEt/+UnqSp1Y2+Ndbh8EBg=;
 b=EzxgUjQ0ft0zJFvka2Mw5yz9Fnf3FwUcBesJUVknsaoK4KYnW1S2NKTaTh0lNzJCPAzRFu1/WnDLsVXUEobM1sGxHLeyCHN68F3GMeH/WTVLbRrB0a2SswwElL+tlY2wcgeWdYXxXuftibwEdNP7XvORpM8AQv9VK7KUqxEPruw8ZKnw3xqiOZBa4nZ6FzUtMPU2X2D2uJsXSsyj/0d7nPHxg79B3baAU/nTPA8CZKTkULVpGAw9apKHgrOB1ICCBE9g99R80TXm1wiaavInSdt+vu081SoYrrMHKqjmf0hQN2RpzQoqnjzRsgP8hniIQS36/BSTy4Un4ekccHw7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgPRmLV8fWhodiSfL1ccNxEt/+UnqSp1Y2+Ndbh8EBg=;
 b=G9R30BS3MWN9gUj8fEZzK3qxwnTWGqt6EJdfX786/OqVg1qZK8e8Ygva2ky1GswkkvbjjV8wcoFxn44iU//dhyq/f+HTxYJ0C+VjrXPVBwd8QJtwmR8rqk1VV0kHlCIhl5IlQTW7MKzru2L8WH1q9eRjwZ2VqqSB67tCreDItso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 10:07:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 10:07:54 +0000
Message-ID: <a37ffb70-6a1a-41df-9682-defeb0516af7@amd.com>
Date: Thu, 12 Jun 2025 15:37:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: update pcie dpm parameters before smu
 feature enablement
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: KevinYang.Wang@amd.com
References: <20250612080132.433434-1-kenneth.feng@amd.com>
 <20250612080132.433434-2-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250612080132.433434-2-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: b46955d3-fa9f-451b-2889-08dda998feea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnV2VCtIclZqRkJFL3U5QllCZU4ydTFzWEx6K1JKTXVJQ0U4WlhHOVlkc3Ra?=
 =?utf-8?B?Z2FZZ2ZLTXBZaGZyNzFkTU5LZHpWRkJkTDNzcjF2emxsS0M4cnFQMTAzK1pZ?=
 =?utf-8?B?STNHUURUT0V0ZXRZS1NzRTUwb3czOTAyalVKSFlaeUJIbFNLU3gwRGg0SktU?=
 =?utf-8?B?WXNvVjFSK0QxUGFGME1WcjVwOU5WY2lDNXlSSXlvcmU4a0ZSVW5pMGNrVUpu?=
 =?utf-8?B?NnY2TkIzdFZ1N25URFNRSG9XWnd0Q1BldkEvU1J2S1NBeTZ1OVFuV3o0ZDBz?=
 =?utf-8?B?dTBXNG51MXlIdFJWV2dEUjVSa05wZnF0bnl4d1lURE54a0wrYys0UW44bWdZ?=
 =?utf-8?B?UU5QWWpjL3dwSlhhTS9BVDBDVlU2MmxUY0kxYnlBTUNCcktsN0tqM0VmQWlK?=
 =?utf-8?B?VTRzNXhHdnI4MjV4akJGQjFMTG5JZXRpVTZvb1c5d1RZUmFqdTY3Ui95bEtE?=
 =?utf-8?B?WFJrdmFNYVhEcEMwb3ZxdEhyem9oejhhMVhyUFk0TnU4VDNkSStTRHEvZzZ0?=
 =?utf-8?B?VVJHTUh5eVE5djBLRkxJNy9GTUNLVFI4VGNmTGhmZUozVlNxRE4wTTdJbVgy?=
 =?utf-8?B?ZGZwNURTRWNHdGEvd2kyZnNMcmpyaGIrc1RmWjNHZFBYSzVpRnZoeFpNWGtv?=
 =?utf-8?B?dHRqaThVTHRYQnZKR3lxUWRWZDEybi9qK2lOUkJrTUU3WVlEYTJTczZaRXQ3?=
 =?utf-8?B?TFNZQ0J0V2M1OGF6R3d0V1ExNC9sOXRvajUrdkMwU0hxMGQzeWwxbWxtOEVi?=
 =?utf-8?B?TE5JMzVVQ2FmK3FJTmI3Rm54NUM0R09pNWNUclhVOFVyRkZsZVhjcjlPMFJr?=
 =?utf-8?B?U21GY0RzSzhHT0xVdzU4UFJodmZJMmV5L2tvaEhreEdKT2ZwcFpOVW94UzVm?=
 =?utf-8?B?ajlJdWRsZWI1TUluWnpoSEdBRVBqMEZBVlp1am00OHlGQzlQM3BtZ0E5VjVn?=
 =?utf-8?B?SjlaTDNhbGphK3J4M0FxUGRha0JvSHBVT2hoRzZqL1BsZXFKbDVvMEhFS3hk?=
 =?utf-8?B?QXNYQ01yU2pJVmNJb3czZStCd1o4NG9BQ0EvT0c4TS9yWXhjczBmaHlMU2lJ?=
 =?utf-8?B?d3NtamZzT2Z4RnVKYlBvMk9VZnRQMzEvdDFCaUQ2RzM5OGlCeVdhTUtQMHhD?=
 =?utf-8?B?UlpXY21YdHNSalBNNjBRK0FvbW4yV285OVRwWm9UYmlja1JtNitQZHlCaWJK?=
 =?utf-8?B?d2V3TTZsUzFRajVacjd2ayt2MkRvWlRCcjdlbG82MTFzUGZZREI2QkdaVDk3?=
 =?utf-8?B?NUZza3JQZHJtNzUvNHdmcEVnQkpuWXdTNkp4QVRzVm1jM1VZcG44MjZHNWJS?=
 =?utf-8?B?SnZ3bkxiZC9ZeU1zYjR1NUo4MGt1YldiV2t1ajA3UEx4MzFpaW02YjhPY3hk?=
 =?utf-8?B?TDBFcHlKbWllUTBTZE8zUW15NlY2VXI2ZHFrekJ0VmxTaDlSdkpYM0ppR215?=
 =?utf-8?B?eUw5eE9YZ3hiU3ppd2dnYVV6UmFkaW9DSThOSFJ2ekhaR2RnYnk3NFBKZFFn?=
 =?utf-8?B?a004THNzd0hMV1U3VnlNanV5NThQYWVyZHFiemZ4VTMxSnkxU2xUWmZ6a1Jo?=
 =?utf-8?B?R2ZNQXB2UTFTZTJDcHk2WCtoWXFKL1ZSNDYzbTVXU0dxTVdpWGNZTUFtUjNV?=
 =?utf-8?B?R2c0QTVwamdYRFZJSUFZeHpFT1hzenU5MFBmY0xpYUFtc2RHaGtBU1pwRWx0?=
 =?utf-8?B?aWhVNElHbm1Xei9iS0VDcFhzNzViNzFDZUhtTGtpeW16UVhUT0pGWGl0NXVl?=
 =?utf-8?B?ZlViNWhqazZvV2tENGl3d04wN2xrQVNVVGdkdmtvZm9KUmY4QW9jRXVVSXlW?=
 =?utf-8?B?bTVBNkZsRis0RTF5ZmlYRzBIV2czcUE3cGNVK0NFR0RWQVF1Mytyb04yZndo?=
 =?utf-8?B?WFZWMGF0VjRXQkVHNjUxL25oN251OURSM0s5SXlYeXg3MkFjTkpMQTM2UjY4?=
 =?utf-8?Q?aAadY/2O5/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXl2Nk92cGdWZSs3NWZBZG5iSGxoSWdWYkoyYVhoa3dvMjFHMWdyYTNSQ3lN?=
 =?utf-8?B?VFQ1bzE1L2V0cE9YaWxRdkZhSnBhUlZWakkzT1FJQnF3QmJKd2EzQUdpSUhG?=
 =?utf-8?B?bjkxWU5tZ2VVUmNjcDB5S0oxSEQ3bEd4SDhtUmZXeWxaQ3JBeHJXUDYxRXZ2?=
 =?utf-8?B?dUg4MnlyV2lWTnpMa293a203Tk8xeFBLWnhFL3A4SHlsODMzaHErQTRUSHoz?=
 =?utf-8?B?RGlkNTB0cGNHV2xPTUYwRXNUQ042Tm1lelVsdHhDYU1vdVdMbm12Nzl0emQw?=
 =?utf-8?B?VTFzYS9GRTRJUVZlbCtTdlovekJmQkZ3STVqV0RxWUtqWTgrYzNTalFyZkRC?=
 =?utf-8?B?YVBXdmNZYzBYM29McmlsamJPYk5QZE9CRm9nZzBEam9TVVFxMkdaS1cyYTJF?=
 =?utf-8?B?S2s0ZmZXdU5pUmZPa3lxTmdBNld3cUN4Rm1YZGd0M0tUeDhlUGtIRjNoK1Vr?=
 =?utf-8?B?WkZPaTQ4ajlBN2EwbE5IY25Qd1U1QWdxN2pLTS84Vm1STFBUQWl0aGoyQzlv?=
 =?utf-8?B?M0hHVTE3dWV4SkVNcmc5aG03RXZ1VzRmdkI0SzhYY2J1MTRZTm41VDNGSWQw?=
 =?utf-8?B?b256dFd3V0FDdWhmZmR1VEdnWTd4dzYxckhLUzZ6eS9KaG5RakxuN21BY3JW?=
 =?utf-8?B?bmN0RG5ROGRLL1JHOW9SelFnd0sxTEN2NDM5K3VhZ2cyTDlrSEdxQy9vdXd0?=
 =?utf-8?B?RWtQWmNzWFJLbE0vOXkrempvRnhuWUk2UnFqYzVMb0NhRFZZeTJKTjdrTGRP?=
 =?utf-8?B?U0l1UU9IYkRuUHFLc0pQdTB4SWo5Y0ZPUmxNS1h6UXdXYzNSV3ZScURDakdW?=
 =?utf-8?B?aEVpclBmZzdyekh0Nnl0d2cwSzE3eFhCa2NqWWNxYVRzSUpmOGY5UmQ2NlEw?=
 =?utf-8?B?d0JhYk12WktXMDl4Vk5pdE9GamtZajh4WGppUUZlajdIeW9jbWgwc012aE5H?=
 =?utf-8?B?aXV3V1pheW5oYS92Y01Gckxia1E0ZDBCWERncStmR1JGVHNoZmxxNEpsUTE5?=
 =?utf-8?B?NDBzL05FRkY3NXl4ekpGTnNTZllYSTVTM20yM2J6RDkvMUQ0YnhReFc5YVJy?=
 =?utf-8?B?N004WWgrS0FUL0xCb0pXakN5NUtROE15bEpkL3VPdFhkOEl6YXpNdXNvT29i?=
 =?utf-8?B?NWZ3c2hkd0czYk85OEVFd1RWVDNXckVlUW5Iak00dm5tcmpVR3lpY291NDgv?=
 =?utf-8?B?Y1JuV3dnSTR3SDdTd1l5cWxJdEEyZ3hzTitsMFJ0a3pLdVZwbEJtT1JHWkZW?=
 =?utf-8?B?aVNKMVNhYURpZ1duNTNsZnNtTlo5NUswc0NZUVBvcC9OVFZBQTkwMUlXYnNV?=
 =?utf-8?B?ek5xWkgxRm82aFV4RHhXQVVwVmt0MjVUYUxibXN6RllCMkpqeFZCQlRmRzRM?=
 =?utf-8?B?dks4WForeXV3aloySHZYSkZUWTBWL01XeVZLd2dPRDJXYWNkNmZEanhFSklX?=
 =?utf-8?B?YmVrY2xUcWJ4R3FTNkx3ZjNYTE02dmI5WUJuZEVjZkhiQUhSa1dEVis0MTJE?=
 =?utf-8?B?UUY3ZkFlZlF1SlZoSU9FTk5ZcHBGSW5tdytZRlN5ZjcwNmFqSllORnhyM3lN?=
 =?utf-8?B?VXJJcDBBaDdnQUxuOGJXOHBkQVIrOUp5S2NKaThZdU1uZEI4NU9CMW9SS3lX?=
 =?utf-8?B?VFE2RTR0eU9QbVl2SkN0ZG5TUVpGWHRwZDJHR2tKNmZhdzhXQTYrMDRpSS82?=
 =?utf-8?B?bGRmVjBYaUhMSDA3YndXb3ZnOVdvZG9WNmYwejVyaHZ0Y01pdDZVSWlRUEhH?=
 =?utf-8?B?c1phMytNNitFb240cHBFYyswZ2dZSmRTbXc1eHlrRHdMam9KUXNlWFBpUU9N?=
 =?utf-8?B?TlFKK1RkbVZ0L1dZYWo5Wmt1WVJKa3lIbUtWNDFOQ0laS3pCTnI0WjErdnR0?=
 =?utf-8?B?ZXE4bHZRYnFycVIrYWgrYkR3ZksxNERKbkw1VCthaExMTFMwelZwOXI5YTVt?=
 =?utf-8?B?MUxLcEx4eDJLbjZZd25VWC90a1JmeVpjZERVSzNaQnNCNHVQTmdlekFNcjJ0?=
 =?utf-8?B?eDFMazMrOFBoSzA3blZFdjVQOEo4MzBHWmVoZlEwTzl6UTZFVG5jQzhMTk1k?=
 =?utf-8?B?bmdkd1Q4MSs5ZExLeUZiSm1QY0V5aVdxZXNvYTBRdDJVcXhWd3hrUW91ai8v?=
 =?utf-8?Q?oOZjsoktXRt10sTTN/7TKF8cZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46955d3-fa9f-451b-2889-08dda998feea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 10:07:54.5802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCxWPkqpRevQd96LXQmdALLEYkpwdKv267qptokIDfTZtTRbuSjGUTBz5z59gviP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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



On 6/12/2025 1:31 PM, Kenneth Feng wrote:
> update pcie dpm parameters before smu feature enablement
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 +++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index aedb209c75da..824fcc6dd32a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1687,26 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		}
>  	}
>  
> -	ret = smu_system_features_control(smu, true);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
> -		return ret;
> -	}
> -
> -	smu_init_xgmi_plpd_mode(smu);
> -
> -	ret = smu_feature_get_enabled_mask(smu, &features_supported);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
> -		return ret;
> -	}
> -	bitmap_copy(feature->supported,
> -		    (unsigned long *)&features_supported,
> -		    feature->feature_num);
> -
> -	if (!smu_is_dpm_running(smu))
> -		dev_info(adev->dev, "dpm has been disabled\n");
> -
>  	/*
>  	 * Set initialized values (get from vbios) to dpm tables context such as
>  	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> @@ -1753,6 +1733,26 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		return ret;
>  	}

This doesn't work for all. smu_set_default_dpm_table has dependency on
feature enablement. For ex: SMU v13.0.6 expects
smu_set_default_dpm_table to be called after smu_system_features_control

Thanks,
Lijo

>  
> +	ret = smu_system_features_control(smu, true);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
> +		return ret;
> +	}
> +
> +	smu_init_xgmi_plpd_mode(smu);
> +
> +	ret = smu_feature_get_enabled_mask(smu, &features_supported);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
> +		return ret;
> +	}
> +	bitmap_copy(feature->supported,
> +		    (unsigned long *)&features_supported,
> +		    feature->feature_num);
> +
> +	if (!smu_is_dpm_running(smu))
> +		dev_info(adev->dev, "dpm has been disabled\n");
> +
>  	ret = smu_get_thermal_temperature_range(smu);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to get thermal temperature ranges!\n");

