Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B99CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 21:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5F910E8D9;
	Wed,  8 Oct 2025 21:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgNcqQ76";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE9810E8D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 21:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah5VBljcAzcQ9mBDJ2vm0t7hk69AAQLDUF40Ys5PiedF5+1Bpor4q0Q755ZeTi/gVrlLiWkX63xugYiBBil09JoiAI3b1l3QoYnCi1awsBZAi7LcSCVUJNxsQCfHbyjUJdTRTvGWlseMTM2ITVjfgQ6SDqaSzJv/htldYQEBwxYdPciSmRwAzrloAyhg1vPIqKpZcuYirJmwVWHh94eSibMdBxrVW8WeltKc25b7/g14+I7I/l/oQGT8gX2ipIuEMtWq+NBbbWFI/6eV5woDRI8m6kat7xIUFSgpyytHVveaBLMwVu+cbhISEJrORl1Q5g5TXgDoAnataDXvLyibUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fua475NOYxhJPXK3CPSqYrpupitfbRpL29v4m+jwPHI=;
 b=r5ot5ods4SIa7xOufghZ17111rq+hSfEEejKlrpOAUiw9HaTXlNxBnJmG4O7opQvguqev6j+yNgY9+w0xZBCxdwYvPySr+99CcTXPd710grYuXqpvaieosFYahwsGuibvuaSv4TTVvhuC2q2zKhSPkQIfnZr9RaUS5umhk1b1UeFsUsipVILD8BleDSPXJAshJJXCexQ/Y/C0dvfrCz/oGkMdYOfBT0tapTMbZ11B7r4DiUtJ2gZXOLkniqqBfWin14zHlF8OGQUhJohSfJ9MdFHj2T8yaWO9Vz6iRvRm1pojiVzXPzWt5iw/+/2akbh2EnTlj895B6KIFRzYNEmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fua475NOYxhJPXK3CPSqYrpupitfbRpL29v4m+jwPHI=;
 b=sgNcqQ76aHrTS4sXIzi7JP+tDMA05D9HpLsxNCkMc60F8hGAWDSfyH9qChcoWGBOkSl8A6A+aBig2B6pYyFTIxSv7tkGj45RupIJS9R1fN5d254fVgCDQR77pNFK7jqKPHd0GvUtvSYKdQv578Yr1YppBdpTlplkoe2pP3oBO88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 21:11:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 21:11:43 +0000
Message-ID: <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
Date: Wed, 8 Oct 2025 17:11:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com
References: <20250926180203.16690-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: a57beeed-908e-4d7f-7ab8-08de06af4857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TERONWtaM0xMenpNc1huQmFXVWg0TjdIT2d2VDZUdnNneEhNWEU0MXN3Z0FF?=
 =?utf-8?B?WjNVYkluSk5zcHdpaDFmWUExdXlJZVNuRjI3QTI0dStHR251UVl5NDFpU2M1?=
 =?utf-8?B?TFBZYm9VVEpkSWpuaCtaK3ltUDZvTjdZUXFYVk9qVGtwbC9CSWJrM1NIVWtH?=
 =?utf-8?B?YVdUdDh6cWZjK1VWUWZGVWFweTM4YVhVVVRvdzFOTitYTGRDQVZGWmRwbVA1?=
 =?utf-8?B?R2w0blRLNzFqQ01USTVwaHNMcTRFUG1YeWFsMVk3cG1tOU1JWXFuejljN05Y?=
 =?utf-8?B?d1B2ZERkSnhaQm1ZMGg2d1ZVTzJoM2lYQTJyZnhIYXNRNnpXUGJCNStUb1Fh?=
 =?utf-8?B?RmoxcEZXemJLcTJaMFd2S3JOYmVBS2UwdHI4c3N1Q3dubktRc1hmanAvWVlE?=
 =?utf-8?B?SzBackZxczNNNGpabjNCWTdGbjhsMmtpWnJ1VXI0dW1UNk1QdHVhdlV6K0hY?=
 =?utf-8?B?VnFkSUttSk01TVVtZG53ME5NdEtrMGtkTC92WENWV1Bxbk5XSGloQmRNam1G?=
 =?utf-8?B?UnliNjVJZGV4N3pmaU9Qd0drUkNoK2RPREtVOHoxNVkxU0tYd0pGcDY0Z0Ez?=
 =?utf-8?B?by80TlpWOXJyNEVxQjRQeGFra0NWU3J5NWdyMlhTYTY0WXR3SitMVVkxcDRt?=
 =?utf-8?B?dmRIWEk4dkxNUkh1WjNkTVVMeG13L2h1SlRjTTBuUmxKZ01oakdISXV6Q3Ir?=
 =?utf-8?B?Z1hFMEpGMkd2Wk1ZWVg1VzZydjVRY2pPd2FyYTlmZHYxZS9peHBVQnRUbDlj?=
 =?utf-8?B?RDl2QTNRczgxRCtGSWR4RjdTN0p1b0RoNW42aVo2Z1c5S0ptOVJNNE1tdHN4?=
 =?utf-8?B?WHRDaUsyNFhYREM2dFJ2RHBLWHlIdm9GakxjR3FhQ2hkOTMxeVUvU3oxUUFM?=
 =?utf-8?B?dnlmTFV5YUFlcHZNTStHTDVSeTdaNkY5TzJBY21CV2YzS1F5SjBtWHRKYzJn?=
 =?utf-8?B?aWg2eE12QUo2ay9LU0lCNU93akZIQWNPNXZMZk5RV28ybGFDMjZMZ2Q2RSt1?=
 =?utf-8?B?ZjJ4L2Z3OGJaTzhoa3hxSUZHWDBBTmNYaHBIREcxTkVQd28vSzk5eU1nUGdK?=
 =?utf-8?B?L3hqSkpiUXB5N3pjZ0x0RU5mWTNNRzMrbkVNcFlwTS9rTmhFTXN2QUJXc01V?=
 =?utf-8?B?ZmhydDQrYlR1UHZ2YVBpU29BN3A4S0E1c1ZGWFhKVEF3TnpOVzFNaUlPR1Nz?=
 =?utf-8?B?QTZOV3FHSk5Dc3FpYy9NMytiSGFmMXdwYnl6amdvY0F2akZVTi9CcklUUHZ3?=
 =?utf-8?B?Zk5jWGN4S1NrVmJKUzgzay9IOEdKbXRjZ0Rwa21sOEJ6M2tOUUc1Z2Y0enZZ?=
 =?utf-8?B?SDRqMUJiaTF0VXZTUnd2RTBzK3BOMDl4TXI5azg0U2lvYnEvM3RxR083akc4?=
 =?utf-8?B?Y1FnYlo3OFVZS09HTlF2cUxHQ3dHOUNJcGNqNjJET3p6VEhQNElaS1UrZ0Y2?=
 =?utf-8?B?citOUG9zRk83MGNWUitMRThjMXVwcXFLdlR6VFNIVHRKcmVsd1NTZnV1RGha?=
 =?utf-8?B?N2Zwejc3TmhOWEQrMlBPVkFyOGExcGJXeG1ydUQwOG5yclQzeGRxTGxRUGZQ?=
 =?utf-8?B?N3JkUVpzUndzUkgvOE1pY002bGlGQldVNHRRL0djdzk4NExpdEswekJ0NTZK?=
 =?utf-8?B?eURVSDdnWlk1Ykh6VU40WXdsazNjOHl4Nm1ob3dMVmxzZmp1and2b3hZUEc0?=
 =?utf-8?B?Uzl4SlROUmduYXVjUW1mZUpQaFJNNDRYeEFHS3FtQVFSSG5mRWNJc1U4eHJT?=
 =?utf-8?B?eDNxVWpBdENkN2wrc0JWdjl4K2o2cmFvYWU0WCthQnBuT1N0di9pT0NheEE1?=
 =?utf-8?B?MklTTldEdHNZSkp2RTBxQW9TMmhiS3UwYW9oc2Zlb3NhM0xBd0xwQUc1SnBB?=
 =?utf-8?B?TTBaUTVCNVYwK2dvalhEclBnaFA0ZGJ5WVFub2hwWU8yN01TN0FrclA3d3Z2?=
 =?utf-8?Q?6681ykU61uOoHrDzqtLjjOOzaMRJJdRF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFpnZDlGS1lKaEEzc3pOR2FXT2h5dnRTZ0VQTUpkU2NXUlNBS3FTUTJweUkr?=
 =?utf-8?B?LzZxd1FWd1dqcThPQXl1d29Mckp4V1huUzd0NDBkT3ROZU0wd1FSYlZvNVNK?=
 =?utf-8?B?S3ErM1lvaGZTYzVDTTZOQVZObGFvejR4UnJXMGNwRGdOZGQ4R0ErVDB6bzc2?=
 =?utf-8?B?RnZNTzlNL1BlZk9xTHpROG9XUFBCdFRrK3M5Q3pscldzK1NyM1dlc0VLcWpZ?=
 =?utf-8?B?cFk3bXhhbFdOQXhRQmJNOER0TFJ1TnpwVjVxTnROa2JSWmN0S1ozVWNlNGVj?=
 =?utf-8?B?bjQ2QzJXUFEzc3k2S09TNmtra2ZXdDdtM2toWUhTSnpvWGhHODI2SGt0QlQ5?=
 =?utf-8?B?NnFiVlhSdFJWOHVCZGJocmFEZXpqblF3VTB5d3RjaUtNbWdodHVKR2pSU2dk?=
 =?utf-8?B?UmxsV2l1Nm1oZVFmZ3phVUYvOEFrU29LZ21pdEpXTnBRUlZmQS9LZHJERnVK?=
 =?utf-8?B?NUdVNlFuNTVHUE9GV01hZ3pNb1lPYkx3aXQ2eVV6V3h2d2xPdmR3SUI5cHE0?=
 =?utf-8?B?bk5QQjBHZ2FjcUlXNVc0RE5rNFp1QU8ydmRiaHBlOEVZYXJDK1hFUHdVM2hZ?=
 =?utf-8?B?VjRncEpNSE5Ja1dWV1lRVld3TTcvSFdTQXNhZkdZSzVGZG5RY3hLb2FQR0pa?=
 =?utf-8?B?OTRqSmJXbjhoK0NiWHpjbTcrYis3TnJOdTNkRVBGZ1ZvZnpObENsM1NGUUov?=
 =?utf-8?B?b2dhNTV2N3RqckFmaVNwYjBMRVI2cHR6M25tS0JQZVpWYU1xeFl0UGM4OGVu?=
 =?utf-8?B?Y1RHVnNDdGRqQ2dwWGZ1eGo0dmpQalNLaTFKWkpEM3JybnNCMWdoZUliSitD?=
 =?utf-8?B?K21RZGJNOE5CZzY3Um5vUFUyd0VMamhSS2xvZDl0YjZsbDdVdHVaMUE4SVRp?=
 =?utf-8?B?dkJrdXptZGFpR2E3aHNMd1VSSmNWV1RWWHRwSDlSbmNUVjJVYVgwUytVRUti?=
 =?utf-8?B?SThmMlB5eTZCdm5ucTFRY3g4dkxiZ1ZPY1FCTnE3SnBnWTdRcGlnUkxYMDc4?=
 =?utf-8?B?RXkvRWIyK05ySkpGTDB5aUg5U010OFB3NDVLanAxcksramVCMXlTaXhIT2xq?=
 =?utf-8?B?N0dPaGNTbnlFclBHelo0d1pzRk13Y2FxWExrMW43T0ZtVHY4elBxR1B1dSs0?=
 =?utf-8?B?c0NxM1paWEY1QUpEWGoyVGRQUDRMVDcyVllTVE5qME1DMGsvNkxZemFURjlh?=
 =?utf-8?B?OU9lR005SFFJSzFxYi9VbUVVU0QzdlREUWFIL1NOamRxOWFDOGFtQXRUUjAw?=
 =?utf-8?B?YWZPdnFoaFFPN1JrVzFGN2p0ekxQMUI3OHA1c2xnb2EzOWlxNGNlTVBBZVpj?=
 =?utf-8?B?VVBQVGpLRy8xSkRaWjlvUHFkVXVrVzd1MmlnTkkxRjNQMGQycmx3ZUU0WllN?=
 =?utf-8?B?RHJNUVhFRHVzME9BODNkZ01HVi8ydUZuTmc0V3FxenNvVThsK005eEJMRnVP?=
 =?utf-8?B?QWpOM3ppTFhPZG9zbHhMZEg2UXNTM2JJOVo4N0tjT2Y5RGhBV3MxL2ZLQkx2?=
 =?utf-8?B?VkpUajRkWkR3bm0zdEtzdmE2Q2dNbXVhTkQ3OW95ZVErTUExTnpSZmhDS0t4?=
 =?utf-8?B?dGtSeUNHendZQWlNM1BqaFl5YzR1U1hiRUtiNzFyVVRWL3RrQkcvNlZDR2k0?=
 =?utf-8?B?MHZkbmttMi8zeTM4bklXZ0R3eHB4K0tmdTBWSW8xeHhFMnBOUXc2R2hwZTN2?=
 =?utf-8?B?UGc3NzVYYXBiMzdrbXNSU3RObzZjNk43TkZUZVpvVnQrTG9Ia1BZUmJESHNF?=
 =?utf-8?B?czRvdWlJN25SdzIzYU40WUhSQzBYTDgyeGI4L1N6TXJaTGZGVmJrOS9hOXlK?=
 =?utf-8?B?MGp0YmRtNk1DNHE0SW5zcW4wbUlBVStPUy9WWmN5TThWNVpaNk5jMzdmWHdi?=
 =?utf-8?B?UEN5UTErQUlMMjNrK1dndW96MVFvOUZPeWRCU2F5K0pzOEFYUWphN1VHckNI?=
 =?utf-8?B?blRlNXhFU0dwREhBWFRCZ1V6c28wUmdTTmJnZDZoWHQvQlZpajdBMDllNWNT?=
 =?utf-8?B?Ky9lOGxJWVllcTczQ3BhdndPTzhqdVFWekNMV0NKRWIrdTNxVEpvUmh2TGk1?=
 =?utf-8?B?UDhMK0MyRmphU3RUZ2k4RjNWcHdzZm92MTZwZnluenJ1RFNpdEYvOTRDTEp4?=
 =?utf-8?Q?8T3WaCDafp4kdFyi7b407mVow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57beeed-908e-4d7f-7ab8-08de06af4857
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 21:11:43.8138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNyrP6Is2C+TB8ak84JxV8Lg4sN0aw8TpeEZ1DTLF3XmG9NmgITQ1Uzal15PCU/MsMJykZZkskL9VxtVp1RyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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

On 2025-09-26 14:01, Timur Kristóf wrote:
> This series adds support for analog connectors to DC for DCE6-10.
> There are two reasons to add this support:
> 
> 1. GPUs that already use DC by default and have analog connectors.
> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
> and their analog part doesn't work with DC. This functionality
> regressed when switching from the amdgpu legacy display code to DC.
> 
> 2. GPUs that don't use amdgpu by default yet.
> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default
> yet, and missing analog connector support in DC is cited as one
> of the main reasons why not.
> 
> Before starting this work, I asked Harry and Alex about how best
> to do it and we agreed that we'd like to use the VBIOS to set up
> the DAC. So I used the amdgpu legacy display code as a reference.
> The first few commits add some minor changes to DC to prepare for
> supporting analog stream and link encoders, then analog link
> detection is added along with polling, and finally DAC load
> detection support, which is useful for old displays and adapters.
> 
> With this analog support added to DC, we could already fully switch
> CIK discrete GPUs to use DC and switch them to the amdgpu driver
> by default. This series switches Bonaire to DC by default, we
> can do the switch to amdgpu in a later series.
> 
> For SI dGPUs, there are other pending patches to make DC work
> well, afterwards we could switch to DC by default, but missing
> VCE1 support is the blocker from using amdgpu by default.
> 
> For GFX7 APUs, further work is needed before enabling DC by
> default, specifically with regards to the TRAVIS and NUTMEG
> external encoders which are not supported by DC at all.
> 
> Changes in v2 of the series:
> Fixed regression on RDNA2 and newer APUs.
> Fixed flickering caused by polling analog connectors.
> Fixed crash on Kaveri.
> Fixed bug when HPD was high without a connected display.
> Reduced code churn by reusing same link encoder.
> Addressed other feedback from the review of v1.

Thanks for the series.

Patches 1-13 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

I'll hope to find time for the rest tomorrow or Friday.

Harry

> 
> Timur Kristóf (23):
>   drm/amd/display: Determine DVI-I connector type (v2)
>   drm/amd/display: Add analog bit to edid_caps (v2)
>   drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
>   drm/amd/display: Hook up DAC to bios_parser_encoder_control
>   drm/amd/display: Add SelectCRTC_Source to BIOS parser
>   drm/amd/display: Get maximum pixel clock from VBIOS
>   drm/amd/display: Don't use stereo sync and audio on RGB signals (v2)
>   drm/amd/display: Don't try to enable/disable HPD when unavailable
>   drm/amd/display: Determine early if a link has supported encoders (v2)
>   drm/amd/display: Add concept of analog encoders (v2)
>   drm/amd/display: Implement DCE analog stream encoders
>   drm/amd/display: Implement DCE analog link encoders (v2)
>   drm/amd/display: Support DAC in dce110_hwseq
>   drm/amd/display: Add analog link detection (v2)
>   drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
>   drm/amd/display: Poll analog connectors (v2)
>   drm/amd/display: Add DCE BIOS_SCRATCH_0 register
>   drm/amd/display: Make get_support_mask_for_device_id reusable
>   drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
>   drm/amd/display: Use DAC load detection on analog connectors (v2)
>   drm/amd/display: Add common modes to analog displays without EDID
>   drm/amd/display: Don't add freesync modes to analog displays (v2)
>   drm/amdgpu: Use DC by default for Bonaire
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
>  .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
>  .../drm/amd/display/dc/bios/command_table.h   |   6 +
>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
>  .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
>  .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
>  .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
>  .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
>  .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
>  .../dc/resource/dce100/dce100_resource.c      |  31 +-
>  .../dc/resource/dce110/dce110_resource.c      |   2 +
>  .../dc/resource/dce112/dce112_resource.c      |   2 +
>  .../dc/resource/dce120/dce120_resource.c      |   1 +
>  .../dc/resource/dce60/dce60_resource.c        |  29 +-
>  .../dc/resource/dce80/dce80_resource.c        |  26 +-
>  .../amd/display/include/bios_parser_types.h   |  11 +-
>  .../display/include/grph_object_ctrl_defs.h   |   1 +
>  .../drm/amd/display/include/grph_object_id.h  |   7 +
>  .../drm/amd/display/include/signal_types.h    |  12 +
>  35 files changed, 1117 insertions(+), 86 deletions(-)
> 

