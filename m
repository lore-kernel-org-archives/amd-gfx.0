Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0BFC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 02:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D363418A0E4;
	Thu, 22 May 2025 02:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCTtqr51";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD24C14B2D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 02:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoFuJlUW65EQfVVTPgEiq0h0GLb3SQXU2j0wURvXUtGQFNoSnsZIAbmr1KQS0Ptmq+4sg7apfUoQZh+0Gy/Tcwf461Tp/YQoWsHoE/SMe860OvxgUnBtwUPc72on5cIneBBi9/lQj/vIerxDOL1d9+bQld6xI8krsrcxDWtxzK2+R50o65nurpAb6185mij9rXJNgnin5tdjPhp+rkbXTaOI7qXSmaG4rV+qKZkaNlrTwRU6I20xP1e6k16MtaJWOk74SkdHw6gFC8KP+HuDvrw47ajQJp0cqI879fRthUOGqZWB1Okkpm3i09krjrjUurE+qMIS+9rTaNxtO79X+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEaPLhJ1z55JH8x+aVMN/ZHZguWWqbC9QxyiKpEJgZI=;
 b=uP7xDVouIrs9GBU7Nht+cTHA12DLkvYXuKCGT/N3WcAjF+3Fhc2Y3qOQtyQH+g9dYxU8gz9CM/i6dLoDmDYRqq0OJwmnvlS2Wavy2qZd4Wh/KFj7ddBEYHxahI5WlOrYrKjTvpxGoARa7vES5qdMYJK5q+5rJd2UzBcUfqG0MYYsNqJbC2zDXYF/mkSj2w6GxAHaG5m+HKcE2DO4ikSGI++xrytKtuyyo2g2IIHnk2iv+mIdEXLKiHdM4G2VBZzGbopQh8ISPnbWWwMYw9Ad51JggnMSbMjZNAj4lViCPm2I1OENK8CntDF6QkiYgmJsmctBoZFM/u4cX7RKGFXI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEaPLhJ1z55JH8x+aVMN/ZHZguWWqbC9QxyiKpEJgZI=;
 b=NCTtqr51/+8Km1pBIbGSPRM1gQMwv0qc9wbVxiY/J732nVE52v/03xY51O5yZQlsmsRvcQ25aaCJst6IrPsxgynXkVMfYa71YOik/HKoL4wj24QdxeVKlxxjyoeAtVj3YuP9IkgODll0DaoGduldX/KiHcC21Z7STZiu53TC0/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 02:05:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 02:05:50 +0000
Message-ID: <381923a0-7ce6-461c-9dea-fe6710bb52b3@amd.com>
Date: Wed, 21 May 2025 21:05:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd/amdgpu: Add GPIO resources required for amdisp
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com
References: <20250521205906.639718-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250521205906.639718-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcd27e4-a196-4158-b2f9-08dd98d52c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzk3cHFYOGVvMDhrWC9EVVljdXNpVGVGemFIaDg0SlJleE9DWXp2OWo2OElB?=
 =?utf-8?B?LytadnpIQWdsWFUwNXVWemJIakZkd2Q0TExTTFhkYzhpVGQwdkl2SDhQQUZX?=
 =?utf-8?B?ekJEcHRGczNMaU43SkoybWYzSzlVR2dOdjZqYzU0S3kyRXh5bGcxaUxCQzY3?=
 =?utf-8?B?aEpybWFuU3F4N3d3U0Z4Y1d0UjFpM09wV1ZwL1h2ZFY0Rkt3VDBrZUZnQmpv?=
 =?utf-8?B?V1A2dlhVUEtxOGlXbkdta2t4U2FYSjNpak00UHBjb2tyeVhnd2dDbWxQbEQ5?=
 =?utf-8?B?SDJOQWl5TGl1bHltempoeURzWVJtZmZqQWtZNThIcm9OcE0reW85TmFJQytv?=
 =?utf-8?B?Vjl0TDFma0hORUlqZXFQUjVqYXNJSVYzRkI3TG9ob2VxYkVhR29xQXErZzF0?=
 =?utf-8?B?b1J6Z2pRSEdNSUFGRzhKY0Y4WUd5cjJjNUNjVHRTbXpzMm5STktxWmZBV1VD?=
 =?utf-8?B?QVRpdm1DYW0weFF5cEdYeGpYUG9WdlZGMC93a2VITzI2aGNjOS9tWE91eHBC?=
 =?utf-8?B?ZlFPa2d4Y0gyemk2V0I2cERVM0t2bEhseVJQb0s3NURFMXpRYk9TV2t5bkZx?=
 =?utf-8?B?VmczakdGcUtXYWtJSmxVTnY1ZzNrQnF6NmVrSlRSdkpkcGlMQ05CYTFMVklJ?=
 =?utf-8?B?QVlPdjlYTnByNjNNdVhobjZnOG14Z29rc2ppL2g4cTB2N3Y0MjBzWW9sNEp2?=
 =?utf-8?B?ZmZ6NXhpRlZ0dnJzTmdUWmN0Z0Z1RzVxenMrTm4xOVBML0N3c0N1VHJKalkz?=
 =?utf-8?B?R3ZSK25QdE5KZE5CbnBIdEY3RDhzT2gyUDE3a1dMWDdpNUZnQ2hDT1p1aTNU?=
 =?utf-8?B?UWpHUHBiSkhrY0pVd0tySFYxelAzNnE4N1lkVDB6ZURiN2VKa1c5Q3BIQzFZ?=
 =?utf-8?B?YkZrMlU5V1JsRDM3ckM1ZmVnU00vRTdQZFgxZlZmaFBwS1VOTkE0THkxOThO?=
 =?utf-8?B?Z1pJNHNiVGkwU2VGZGRlSkVkOEpoYjN6TXNidGpsWDhPbEJ6YkpzYkZhLzMv?=
 =?utf-8?B?NFYrakFQRTA1NkE4VHBUL3YxL2o3QUlrQ2o5MXo4UmQrN25vSXRZemo3b09i?=
 =?utf-8?B?QmNUbFdBaGtPL3plN1M2QkdtdTF6NVFwcWUwK2Q5VWtMQ0JuYmNYMmd1cHpU?=
 =?utf-8?B?aHBwRjVzUXRPN29IelNGMDQweVFUQmRCTnZBdHZBTnFidEk4TEVqa1V0amRt?=
 =?utf-8?B?N3E4WFdCMDYvSDZueHpCYnZCTk1Ea0Y5TXpqR0RBUDFwSEVWaXdneVBVV25E?=
 =?utf-8?B?b3ZmcWxMYjFaWisvSEE4QnJOV2g5cmxyMklybTVIc3NTN0hVaDRrZmI4Vjgr?=
 =?utf-8?B?STQxYStmY0V6aW56WXozS2NOVG51MG5HZWZEbHZlVGlRL1l0RDJTa095R2dI?=
 =?utf-8?B?SDFTWHNsNVExa0tVdVhzaEd0V01xcjRpbHhxajZIcTZzYjExdTBNNzY0U3hD?=
 =?utf-8?B?bG5vRVI1TlhkMndiS3dsVWhLSXdDT2NMNTJZTlRtUFdjNGhBbUI1Z1Q4cjdW?=
 =?utf-8?B?WldJS0tVVkdFWEhHdzBPdWJaank2dFY0aEoxbk5CYVFPTmRsem5mTktTN01S?=
 =?utf-8?B?SURmZm1WSGd0clRPODhmcGV5RVJIcll3S3ZQdzVIV3hHYS9Bdm53VUlpVy9J?=
 =?utf-8?B?UVNVL0ZmLzhCeE9DaE9ZVDhBaUN0V2I3NTVsWUZrdWFYa1NxQXRXU3BjOXRy?=
 =?utf-8?B?dzJjQVA1SkFXbTc3ZTh5VEtTbWttSVAybzljTkJlMjg5Nmk2azdSS1QzNW1y?=
 =?utf-8?B?ekt5bW02WkZreEh2aTR4NEJuWkllS2Fmd01uRDZReWhoZVlqY2huWjlPOG9w?=
 =?utf-8?B?Z2M0T0hEbjdQd1NaWHhLMTJZamphTHo5WERqVGVoSXZkVXpJVmJ4UDcxMDE0?=
 =?utf-8?B?L0Q5RFVWRGJLYy8yS2RSNXRSa05yWWMyZDNJdFo3VGtpMUxhbjVxTGY4K0RY?=
 =?utf-8?Q?2JQ864fcQFk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5CL1MxK2Q3N2pTaGd2Tko0WlFJTlF4M29ZUjVRejdZMWJTa3pac1kxMGhN?=
 =?utf-8?B?TEJwOVpEMFNabnFKbC90UWM5OUZJZU5wdHRNejhyV2V4OTN1TnptWkpzSEph?=
 =?utf-8?B?ckxSU3p6YnMwcktOUnVBeVZrVG9wa1JTcnI1WFBGMThQdld0WFRPNzd4VWxP?=
 =?utf-8?B?Mlp4WTQyNFVjamdyZllJUGMxQWhnUHZva2oxMnlMeEQvWno0NVpjVWVjSEtt?=
 =?utf-8?B?RFpCSm5BaHJoR2wrUlNPSU5sWmVRMVVmNWt3QmdWY1JiVldRN2c1SFFnVjlh?=
 =?utf-8?B?UzdRMWxDQjQvNnlUWERNejBwQWRsVmJRR2dOVGZ0aGNOZStEa2FzRXBHQTZ5?=
 =?utf-8?B?THoyUWx6bkM0aTVOaWgvREdFV1JxZk9SNC9aS3RTYmhpNDd6dmdEeWMvWkc5?=
 =?utf-8?B?S251M01pMXd5T25KbFZmS3JLM1k1WVQyZ0pqenAzaG5hNTJ1TXUrNVIxeity?=
 =?utf-8?B?bkF3V3FZOFA0S3ZTOGNaK2crRE8yQzdyRkZidmlycWxpRUNlNGhuV0tHbGN1?=
 =?utf-8?B?UFpIUnhKV0ZKdmZEdXpDemczWWJYb05SaFdTeDFreWNncndGQWZmdUJyYXBB?=
 =?utf-8?B?OUNmM1lIb1RpcmFYNHo2MDZLSENsM2ZReU5NaExTTDIxZ2pKbUxFS01YNDVs?=
 =?utf-8?B?Mjd3bWI5MG5QTFhRbHZvNHFmMzlUelNjc3A1YUFLd1Q4NEluY29wVWphM3J3?=
 =?utf-8?B?eVVWT3poUzg3RTdpdGt1dmFQMDFRWVk5SXBGM2VJZ2V4bTR1TUpGUHR2MVE5?=
 =?utf-8?B?cjNTczBrOFRuWEF5MG1lSjFnUDZWTnFxaFY2ZHZ5T1UxRElZTXlzeDRIQkFh?=
 =?utf-8?B?d1lEaFQ4b1pRVVk0TGZhakpONGw1SG91aFBxcjJHTnJLM1pkd2VieG1LYnp6?=
 =?utf-8?B?ZUt2TXEzcTNPNDRyVERaOG53SDB1RllqcXVhMGxzMFNFZWV3cjJrNEphbHJG?=
 =?utf-8?B?SkEzbUtjSFYvZWFlSG82MWg2dW1FMnBGQjZ1dlZpRlhBaGxsMGt6bXVHM1ha?=
 =?utf-8?B?ZFF6d0RzU0tSenppL3VVSHM2MDhqd1JSWjhrR25PMnpIKzQvOFJtMVZ6UEVT?=
 =?utf-8?B?TE5zYk9oTWFhd3czK2F6ZzJYbHZMcFBuVEFHT1ZyTi9BWndpdi9Ec2tmaGFn?=
 =?utf-8?B?a2JLQUhteEk2Q1pGQm00NmJ1cDFxZEJndDNGV1N6dlZIeWNESW9YdGtMQmky?=
 =?utf-8?B?SkE2aVVaMGE1YW9qL2hKQ1B4TW93NnZ2Nm5zcXNVWXJMcWdzL3U4NFJ3U1Z6?=
 =?utf-8?B?cm82UzZUMnNkRWdmbWdGTWxCUDNrdnJaK2dFaksyaCtVMGVXdlZYSmNWZkdk?=
 =?utf-8?B?VjdSS05zNzhHalVZR3RCZGdUdXl1VTZTL1pkOHY4QzM3cmcvYjAxSEc4NzNP?=
 =?utf-8?B?T3UrMEd6b0w3cEpZd2dOWURNZmM5YW9WUmJhenpMSVlXTnpYYWh0eXp4V0Jy?=
 =?utf-8?B?QmgrYThsRGZUMTd1RlVPMkhLTktVNjZRUHRoSE9iVlZYWHpMNk1meDQ2RGRl?=
 =?utf-8?B?VVVHbkNXc3E5OGszMnMwNDF6b3ViRlVhQ0hTbDdjRXZpTkFPWldaYUdTM0xJ?=
 =?utf-8?B?Wmx0di9rWWdQQjQ5S2JMM1VMaS9ubG5YZUp1RURXbWhmb29BN1ZvUUxjcjBl?=
 =?utf-8?B?QW9PWkNQL3J1QjZPYWlPL29RSkFwQkxnY2NvbWg5dWpGc2RBVnUxc2IzUlJi?=
 =?utf-8?B?TDcrWjJucXFCM0dwRzhJS0lhb3hGMTQra09oTzNTVktNa1hLNjBNaE1IeEF1?=
 =?utf-8?B?QllPaDJadG95YWI2elR5Kzk1ZUVJVFJiT251KzFZaWpaSHYyUVV6S2diSFpH?=
 =?utf-8?B?Z0dSYmZRYkNCMkJNSDUzREVLbVBKYzRIUjdYSGd6L3VjUEtETjZoNzZLOERq?=
 =?utf-8?B?TDBabW9IYUoyaGs0OXRQM205TWRGV0kzTVRRSGZUZStKbXpaZkxoTmx3QUZO?=
 =?utf-8?B?SVdJU3FRK29lTVE1Ry83bWdBd2hidDB3MXNHMUFIaEc0bFB5SUFiaExXamNZ?=
 =?utf-8?B?WDJKU2I5bGI3MFRudHVPVUIvZ2pUdGczZU9DZmlJYXkxcC9kMzJJNjQvRHg0?=
 =?utf-8?B?Y0p0Z2JnWDZ2Q0JZM0dvSUxSb21OWEVOV2I0eWVweklPSlVLTDBEZGJ4WDR0?=
 =?utf-8?Q?YBEWLr9W08mmdul/EzaHhE2q0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcd27e4-a196-4158-b2f9-08dd98d52c99
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 02:05:50.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNS5a+IUAD7Gpux1ceDZqAdbDwmLKDMvJ4owJnMaQgXARQJIas2d8RnZ8yqnq6g4WF632cJpp+8XXESQcfYQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

On 5/21/2025 3:49 PM, Pratap Nirujogi wrote:
> ISP is a child device to GFX, and its device specific information
> is not available in ACPI. Adding the 2 GPIO resources required for
> ISP_v4_1_1 in amdgpu_isp driver.
> 
> - GPIO 0 to allow sensor driver to enable and disable sensor module.
> - GPIO 85 to allow ISP driver to enable and disable ISP RGB streaming mode.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Still LGTM, thanks.
> ---
> Changes v4 -> v5:
> 
> * Build errors reported on the platform that doesn't enable CONFIG_ACPI
> or CONFIG_SUSPEND. Include amdgpu_acpi_get_isp4_dev_hid() only when both
> CONFIG_DRM_AMD_ISP and ACPI are enabled to fix the build errors.
> 
> 
>   drivers/gpu/drm/amd/amdgpu/Kconfig       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 32 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 31 +++++++++++++++++++++++
>   4 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 1a11cab741ac..6bd9aa5dbef7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -77,7 +77,7 @@ config DRM_AMDGPU_USERPTR
>   
>   config DRM_AMD_ISP
>   	bool "Enable AMD Image Signal Processor IP support"
> -	depends on DRM_AMDGPU
> +	depends on DRM_AMDGPU && ACPI
>   	select MFD_CORE
>   	select PM_GENERIC_DOMAINS if PM
>   	help
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 836ea081088a..a5ccd0ada16a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1713,6 +1713,10 @@ static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { retu
>   static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   #endif
>   
> +#if defined(CONFIG_DRM_AMD_ISP)
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN]);
> +#endif
> +
>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 707e131f89d2..f5466c592d94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1532,5 +1532,35 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>   	return true;
>   #endif /* CONFIG_AMD_PMC */
>   }
> -
>   #endif /* CONFIG_SUSPEND */
> +
> +#if IS_ENABLED(CONFIG_DRM_AMD_ISP)
> +static const struct acpi_device_id isp_sensor_ids[] = {
> +	{ "OMNI5C10" },
> +	{ }
> +};
> +
> +static int isp_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
> +int amdgpu_acpi_get_isp4_dev_hid(u8 (*hid)[ACPI_ID_LEN])
> +{
> +	struct device *pdev __free(put_device) = NULL;
> +	struct acpi_device *acpi_pdev;
> +
> +	pdev = bus_find_device(&platform_bus_type, NULL, isp_sensor_ids,
> +			       isp_match_acpi_device_ids);
> +	if (!pdev)
> +		return -EINVAL;
> +
> +	acpi_pdev = ACPI_COMPANION(pdev);
> +	if (!acpi_pdev)
> +		return -ENODEV;
> +
> +	strscpy(*hid, acpi_device_hid(acpi_pdev));
> +
> +	return 0;
> +}
> +#endif /* CONFIG_DRM_AMD_ISP */
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index 69dd92f6e86d..574880d67009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -25,6 +25,7 @@
>    *
>    */
>   
> +#include <linux/gpio/machine.h>
>   #include "amdgpu.h"
>   #include "isp_v4_1_1.h"
>   
> @@ -39,15 +40,45 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP411_INT_SRC] = {
>   	ISP_4_1__SRCID__ISP_RINGBUFFER_WPT16
>   };
>   
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "i2c-ov05c10",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>   {
>   	struct amdgpu_device *adev = isp->adev;
>   	int idx, int_idx, num_res, r;
> +	u8 isp_dev_hid[ACPI_ID_LEN];
>   	u64 isp_base;
>   
>   	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
>   		return -EINVAL;
>   
> +	r = amdgpu_acpi_get_isp4_dev_hid(&isp_dev_hid);
> +	if (r) {
> +		drm_dbg(&adev->ddev, "Invalid isp platform detected (%d)", r);
> +		/* allow GPU init to progress */
> +		return 0;
> +	}
> +
> +	/* add GPIO resources required for OMNI5C10 sensor */
> +	if (!strcmp("OMNI5C10", isp_dev_hid)) {
> +		gpiod_add_lookup_table(&isp_gpio_table);
> +		gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +	}
> +
>   	isp_base = adev->rmmio_base;
>   
>   	isp->isp_cell = kcalloc(3, sizeof(struct mfd_cell), GFP_KERNEL);

