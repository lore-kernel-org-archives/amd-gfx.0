Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEBEC282EC
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 21:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA44910E02C;
	Wed,  5 Mar 2025 21:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OfdeC/D8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE49D10E02C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 21:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSh5GszgS0TpSO7eEOov+Cngis8nWnwn0ehrhPClk58F9X7IRV2m41dnouG1j91syyLx5R9Ou2PLoYnXEC0F6GNNEODqqZVaSqgq2av/v0c2RG029tAVO3erhsTc3kfuwlP9qdRe75U0dpXnRgeZ9Ggcdw6eM8M2ddlbnXMuBAXPEn93ThxX4QdCeBPJOvS5NU84QM5iEkfCpBGc4yn8bopUl0stEwfRyhf34543Sw7Bwoh7Bb7zMqIp1x/AKgW1mXMXFiiO3NbXdhXhi5tOa7Tgntjh9nj/BqDocwzSPxiruQtiWKGRJefaR7XeDlONfJ85Fm+/QosO6Fi2klmnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZhzJSjQpfTSz+a0w8dagz5bb7cWy44XheAmNf0Quzg=;
 b=i9lm7YlU6lSjxnSIzm2P+trz9w0WYZYelgZjJ8XALkvGJmffqMGUuiIbv5JjrkeH9xs1y5FWfHo7IJvt0mHH90d2wdy/iMWeA4C7CoJZk27+M1vz+p+igRkvZepu3sbUo4Z8Cp3IVpmRlax8x4OGJIYKOdDcOK9GxbCjeCtgrucMGPuDL5jtY5ts5k/vlT4lGSNhQ4KYTwF5fUBYXAlLOp6u17KwgHz3ye5DeJqsKWEVjEl3bloWWX5s2ZopJgE+ErGGvCup1WgAFKPDBzKpWf3hYbYkEnoCJhecHUqBpurA59RLSGGFqBreHPPexqSAVK6HSXzSWVn8PRW8Oa11tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZhzJSjQpfTSz+a0w8dagz5bb7cWy44XheAmNf0Quzg=;
 b=OfdeC/D8e0rWYw2w2VIgYH0JTrsVD1UIAju6/wnPgyrqWyeP21AnVKAeHhZnmFhh2jaY+eyBUyEWeqGf3rRfIcW95Y6IN6afCFVGgAFqY4zIuyGPdZDz7/EjNsQaT8Gf5LneikVaiNoatXmCBzuB08j4m4hbjes6KiX0Bie45p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 21:44:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 21:44:51 +0000
Message-ID: <5f8f95a9-ca19-4d28-82fc-7445e2be24ba@amd.com>
Date: Wed, 5 Mar 2025 15:44:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fail initialization earlier when DC is disabled
To: amd-gfx@lists.freedesktop.org
References: <20250305213742.13559-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250305213742.13559-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 397b717a-9896-4767-12bf-08dd5c2ef5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHVMWUZ4bWpvUlB2VXRBQWdPT1JzbGlCcGkyWnU5M1ljUDhGcHZiK1p3RERs?=
 =?utf-8?B?OFBWdjdtQUIycFNWdlZaZHdaa2lRdlNmT251WUYvbGl6Q2pPQzRab1VVVkVx?=
 =?utf-8?B?a211ZklrSVFGZ3pZVXJTZkZkQkoxSCswajNpc3RZeGJVcmIyRDcxV0dMREJ0?=
 =?utf-8?B?djJ3TGRiSWlwRWpOR3NiVVN2RklVb0Z0NHJOMmlJYWlLVGkzeFRFc3RqcTNo?=
 =?utf-8?B?VVdGSE5ENUhHVjYzeHU2T0FUOEFJZld1WXJ5VlA4WFRrUXlDZW93Rm1CREJv?=
 =?utf-8?B?VGZUeVBlN2hWMDllS1F6b2IzNG1HWmZWWC9YcWRSWmJwa2NaQk0yQWZxRXZw?=
 =?utf-8?B?VFRqbVFtLythdWxWV0FnOC9ISVFBVXVMbGdXcmxaSGw5OWs3TzdsZmVwUnkw?=
 =?utf-8?B?Sy9PZ2MweTlRQkRFeFlMRENqZTQwOS8xNjZpMDMwL3ZpdHN1Qnh6eXo5SUl3?=
 =?utf-8?B?M0FHZ3ZOZ0dnd2tHcWN5Y2ppWmVjWUVZVVJidExkVTlnWXNBQ0s3cXJnR2FN?=
 =?utf-8?B?RTRTWnMxSWpiNjFTY2JpWmlBL0ptTmdoTnlMZ2dsL1lBZ3Z3aHU3V1UxSVFV?=
 =?utf-8?B?WnkxNDVESXZ0Rm5RS3BsaU41dlplMVRRTFhxbG96dExRRWVUeWg4dW9xSnVp?=
 =?utf-8?B?N3hpb3ByaTdiSTRaK1h5NWFZa1c2OUdpNDloWDZFRDA3S2NHQVh5bUpId2dU?=
 =?utf-8?B?NUhDTFltSVQxZHFBcXFhMitKK01ldHF4TmpUTS93RVdnMCtQZ1hCbG5yaU9n?=
 =?utf-8?B?RFRVOFJ4NmttbDlJb05sY3hTSlZYM3J6Wk50bnZvbVh2Y2JPN0FRM1owamE2?=
 =?utf-8?B?K1h0U21OK1ozSWRVbW1mNGxCMU82Znl1R3dXUVdCZWt2bklINWlTelBkdk9l?=
 =?utf-8?B?TU5WVDBsZ1FZRnZNaDJTT1JhMTJpNzJlTHFOcVBzTmxJWktoNGw5dXk5MmhT?=
 =?utf-8?B?QTg4ZWpjaGtmelhPTDYvZnhSUXpQUkcyOUl0UUtkUXJxY2p5VWg0OC92a2dN?=
 =?utf-8?B?NWYwN3hZelgySENJRURuUUtkemdnZUJ0dnVQekZka1Z6K0J5MDJsUmJxK0JH?=
 =?utf-8?B?bW15N1JELzFjenF5UHhpejdIM05tVWduUjk0WWFZOFkvQ2FsdllKcDVIbDVY?=
 =?utf-8?B?MFRlTVFnTnVHUkcwRTdiR2tjNFltQ0E2ZEYvKzJ3RzVKY1ozcHkxQzM2K2J2?=
 =?utf-8?B?UHk5Y3UzR3N0OUI5dmtQYUtXN0FEejFTNjVlbmdGdlJONHJUa2ZVZ1hRL1Vh?=
 =?utf-8?B?R2c1eFdSZyt3MkxpUkFYTVY3bVJZS2EwL1BtQmd0RUJyUXV0aXhrc1ZhSGRS?=
 =?utf-8?B?Tkg3alRhN3BsTVhWb05sdlkwblcrYjlLbUZpZ213Zzg2ZzBPa3BIUTZXb3ZQ?=
 =?utf-8?B?Zko1WW45QUl6cFlwVlcyNkZyaXRCVHlsL1NkV1FrT01zUU9oL2x1YjJZRC9S?=
 =?utf-8?B?cXZrOEg3ZjZaTHVuc2VlNmlDM2VvM05JZFJZOVhFWk5DWDBaeXpqMTR2RFhq?=
 =?utf-8?B?U3l3SHNuRXpHc2FuWXo5VC9KY1ZkcVlLSE5qY3FCUVduN2E4c3NZakozVnRz?=
 =?utf-8?B?Y1ZRYmlLdExaT2Q4NjhrZTRoY3RrRGJJNnFQWlpDR2J5a2xBZG9KbXdiWG4v?=
 =?utf-8?B?bWdIT2svVVgwQ3NiMTNOS001Yk1tejRDTDd3UWhwR21Kd2g3OVFNRDdKdlQ3?=
 =?utf-8?B?WHFENE81UFRpYWk4ZHZES3J5alBvODVNOWpoMTRTTFNTeWVIK0FKWFNONWNQ?=
 =?utf-8?B?L3RNTnQyQmJFcFNpdzJXYmFjVGFQSU1aQWhORXkzN214N2FqL0toRG9qcDZa?=
 =?utf-8?B?MEpXaHdrUDJtM1VqV3Fva05jQ3dPbUpCSE9vQTR3SEsxR3JtOUtuUHJrbEtS?=
 =?utf-8?Q?nMPa9GHtvoqaO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RncxazQ4dFhxS2RBV2psNVRSYUQ2Nmwrb25UOW5uS1pqeDY0K3V4Tnp5Qm5S?=
 =?utf-8?B?WmxBSnUyS1crLzMwajdCUlNJWTVkaHBNbmMvK1JiYTZKQmZIKzdERTZyMjZE?=
 =?utf-8?B?dXU5aGt5NjJQSXV1VFo1eWc2ci9GOWw1V2hqMUU5Qk1BQ0x3NStDQlg0VzNU?=
 =?utf-8?B?am9YWnFjUFRYUS9Qd1JROXRabG5ieStwZjBNY2pYZ21ZUDh0dTRIbEswUUo0?=
 =?utf-8?B?ZmI3NFFlYmQ3cC9xVEpJZGRha1hjM2ZwczVpNWFDSWxQdVNmOTlWcW5tdjNq?=
 =?utf-8?B?ODRHZnlFaEdnUThJaXl4ZTVIRWNhSVNxUVg0NEVFdzhQTUpyUzZCZDFDazFY?=
 =?utf-8?B?ekx2V2hnRHNxVnFDSCtpZkNJd3FRZUdMWnZ0bUN2RzdhanpTT0FkNi9aOFpE?=
 =?utf-8?B?NkJhaTVFQWRvcU9KbTZGamcrYTNHOU9YQlVYd1RscUhud3lZWTJHak95ZGtT?=
 =?utf-8?B?UzlqT1h0L3IzaFJNdStJWUk3bXFoSkMrS21Dd2VaS0tZS28vb2ZhWERCNG1Q?=
 =?utf-8?B?OUJUVVI3MEsrSFhYVE94djFBa1J2L0lKaFBFK1FVR1piRmNSNjFPaHFLYlEw?=
 =?utf-8?B?V2pvQlZ1YWdNb3JZTk5neVpNbmczdDhNWHBUeDhWc0F4UGJHSXlaRTAzNW1n?=
 =?utf-8?B?V0djUDhZWS9ObGhVYnNuS0gzL3dLMnc4UnljUnFKZUlKYXBWckNOdUd1NzV4?=
 =?utf-8?B?MWFET3JVS0F0S3lVT1ozWi9GR3BOb05BUmZwWnU2UnVKMFJ1a1d0L0ZxdmJI?=
 =?utf-8?B?dVBGMkhncUpDZFhnZS9pbUNCem85QVFTdnJnRGdENFlZaEYrK2F5cVRJTFhK?=
 =?utf-8?B?Syt4WFp1YWd4SDIzTlpmQzAvckdXQjNaWStTOE80OE5xcFU2U2hvOFc4YmVa?=
 =?utf-8?B?c3Vza1c0c0dJRHAycWpNYm9lYTdCcExXNmNQckZvTkZnbjVSNWNkWW9kenJW?=
 =?utf-8?B?NEZTSzgyU1BjOTh2cDBFcDlCbC80UGhBRE01R3hucmJEOHVxWUZiUTlsSkJY?=
 =?utf-8?B?YXlSSXNEc0l0c3V6TG9hb3lJclA3cjNud3draklJcENqTkJlMk8yKzdRa0k2?=
 =?utf-8?B?bHpJdktWc09VbjAwZUJaZ0oxS2hhZks3SjlrU2R6ZnN2UDE5eWw2YkNRZ2tw?=
 =?utf-8?B?aXQ0ZWltZmFIbzl4dU5JZHl6RlArdm5WNTRHYjJtMmVQQW1YR0t6Tk9CMEQv?=
 =?utf-8?B?ZGpKRndlQ1h2OEQ5RFUzQ1FXZHBkN21KalBsRVFpMWQ1L01OeEYwSmlnSnNq?=
 =?utf-8?B?dVRqclJOa2xYOTB3Q3lqK0J6WTJVSElDNkdyY1lZMFJHc2E4MXFqcnE3Qkpx?=
 =?utf-8?B?U3h4ZDRpa012N213QWJqdHVkMno1bUlCVTE5eWd5bGM1TFdmWms3S3hzdUZJ?=
 =?utf-8?B?UmpwTDFNTHpnQjFIR3N2akpBWFFYVy9tK0YyeERYdUoyY2NMRXZEK3N2WlA0?=
 =?utf-8?B?R0pLcVFvRDE2MDZoOGZQTE9HR1pxY05aWGdiSjZ2L3JHRUg2ZlhzNSs4MER2?=
 =?utf-8?B?VXV6a1ppL01aeHZOdWk5S3pzcXNKZkExbGZGeFREZnNzNkd6eG0zNDdLSzlu?=
 =?utf-8?B?WmZMaGxOUUF6VUV5MjBJRnkrZWo0SEw0QkVTNThDWk1SQXJFdGpNZ3F2VC9k?=
 =?utf-8?B?WXNWTE9WNHRCcGhWR3hmTVA1NVdqT1VFWGFnTzE1T1BxSTRpY3lXWlVQVEpj?=
 =?utf-8?B?cHBzOXd3RnBPM0t1VkVJbE9lZytJTndkU0ZwUWl6WlpqVkRXTW82VWdKRUFX?=
 =?utf-8?B?ZWk3RGRmeE9WcEpzQkNLeWdRNHdyU2dWVm8zMUZMTlF1V055TUN3c1Yra3g3?=
 =?utf-8?B?c281cVB0SlhTWGJHdGFQbURYVGYzVFd6YnBxR24xWlRnb21Kb3RiRTg5RXRJ?=
 =?utf-8?B?UFA0VkNrby9kbXh3YUtSYkhFckdiRTYzRWM5WlJOZXRiWThnUUhMckF2d29j?=
 =?utf-8?B?NUUwMUpmZkVSZjVZTmkrb21pMXU2eUt6Uk1VTy9CcXN3Z2doTEoxWWZ1bnNF?=
 =?utf-8?B?YVg2WEFKOHpmR3h2Wkp1bytQbG5NdERBb0lmRjJON0liaStWZk1lNkZRbWdV?=
 =?utf-8?B?RlB3R0F3RFJPdmJMMGozZlNCdDB1ZmFXN29aQlZNMndrdTVtMDlDSmJnb3ZW?=
 =?utf-8?Q?fXdEi3tRjubvrn7Yi/p562Mz6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397b717a-9896-4767-12bf-08dd5c2ef5a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 21:44:51.7995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTr92YOzpi4tcd5MS+c9KTM+LlVXWw1KaXUds5axfLyIwxhFUKtvr7uqsScnpWuE+skZQqLvUVZhIwPz2FaQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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

On 3/5/2025 15:37, Mario Limonciello wrote:
> Modern APU and dGPU require DC support to be able to light up the
> display.  If DC support has been disabled either by kernel config
> or by kernel command line fail init early so that the system won't
> freeze with a lack of display.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index a4258127083d..c4e1505dcaac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		return 0;
>   	}
>   
> -	if (!amdgpu_device_has_dc_support(adev))
> -		return 0;
> -
> -#if defined(CONFIG_DRM_AMD_DC)
>   	if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>   		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>   		case IP_VERSION(1, 0, 0):
> @@ -2166,15 +2162,24 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 5, 1):
>   		case IP_VERSION(3, 6, 0):
>   		case IP_VERSION(4, 1, 0):
> +			if (!amdgpu_device_has_dc_support(adev)) {
> +				dev_err(adev->dev,
> +					"DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
> +					amdgpu_ip_version(adev, DCE_HWIP, 0));
> +				return -EINVAL;
> +			}
> +
>   			/* TODO: Fix IP version. DC code expects version 4.0.1 */
>   			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
>   				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
>   
> +#if defined(CONFIG_DRM_AMD_DC)
>   			if (amdgpu_sriov_vf(adev))
>   				amdgpu_discovery_set_sriov_display(adev);
>   			else
>   				amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
> +#endif
>   		default:

Looking closer at this failure path I *think* this patch will cause 
issues on GPU without DC support.

In the 'default' case now I think it should do something like this:

if (amdgpu_device_has_dc_support(adev))
	//existing error flow
else
	return 0;

Agree?

>   			dev_err(adev->dev,
>   				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
> @@ -2186,11 +2191,21 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   		case IP_VERSION(12, 0, 0):
>   		case IP_VERSION(12, 0, 1):
>   		case IP_VERSION(12, 1, 0):
> +
> +		if (!amdgpu_device_has_dc_support(adev)) {
> +			dev_err(adev->dev,
> +				"DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
> +				amdgpu_ip_version(adev, DCI_HWIP, 0));
> +			return -EINVAL;
> +		}
> +
> +#if defined(CONFIG_DRM_AMD_DC)
>   			if (amdgpu_sriov_vf(adev))
>   				amdgpu_discovery_set_sriov_display(adev);
>   			else
>   				amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
> +#endif
>   		default:
>   			dev_err(adev->dev,
>   				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
> @@ -2198,7 +2213,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   			return -EINVAL;
>   		}
>   	}
> -#endif
>   	return 0;
>   }
>   

