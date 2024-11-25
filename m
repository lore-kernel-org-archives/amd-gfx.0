Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA3DD58D5C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 15:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05BD10E675;
	Mon, 25 Nov 2024 15:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4nDqsrzt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DD510E674
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 15:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Eg9S6N+8RPd/lCUKcX6JW4qmBgzbBBajGnwMLsvSAuQhDeGUvDdnjloVk9u6o1I338ZydtdQhdZCqS01/2eLVvT5+IkVbAq3voBxVtLwCpIH6FK/zWZ9DFb4qD0lnfRNtFrB4X29Ap5st6uq5TCwBkPLTuERnppUo/IzGyqYR2ci6sIOEqKoUMLAc33mohMbpvFRFct2XT3JHj63nQ/RuA2BK9Ot7ckTLG5qSTfCTtcFyG1ngB6EUBcsyJF8WgAZ+Gv+GTGZocVbUN04qYnO7wCYSHVTKVSAZpePlaxvn/Z5ACR7nYHmB3u4X9MzlASFw4pXK7jPP2eCIPEftv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c83sX7d/+MmFVF1KSyswUE/t52tgofuFKoLLtgX7kXo=;
 b=tuobAg4uMFwAr0P9oYZ1xaNvrm6Mw+qkp5xV/Ge6BXqqmGffm0XRys4o9SVejFPd6zY8/+XYFz2t+eCtZpprgXJCvhEo42v12ws34O1sSY6LlM+JU/sw+qg6euftdYdEnZ5YmWOLwEXDVsTrBIjMlTxu1396XySkzGctredItqEU0jqg5GlVPcCkozZF90VhyXUeAEosWU79+PgtJX0wv3mzDYBcB1dFA2JayZD1KdAuNmu1Ov9JAizbUputnjk8L2lVrV+jSBr0Hw+rjeIikqOG5MHiaAKPljmxyT7EtqqT99T3SEN/sr3yfoOX9USKkOb+rPwM7vxFfILcumli+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c83sX7d/+MmFVF1KSyswUE/t52tgofuFKoLLtgX7kXo=;
 b=4nDqsrztiMkefDPYP5zI4Vuy/NT6q5nUi7gt3KpjJhkRZ9jeJbvYImnAcvTx0Q4aqjDdIq5Pwaz+Yj1zw0qwMIEmj+/wR2JaqBWdcMWu4VUT5AVPzXDrrA7wzARovly0nFaZ9WRdHxImwqfrZzuwYaJbNgqnM4TAK53+9ZsPzC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:00:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 15:00:05 +0000
Message-ID: <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
Date: Mon, 25 Nov 2024 20:29:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241124190001.2633591-1-superm1@kernel.org>
 <20241124190001.2633591-2-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241124190001.2633591-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 099e98f6-3979-4de1-a2dd-08dd0d61d843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3pIelhYOUN5cFdWNUtFQ1NCRWNrSDE1UXVvWmhzV2wxbmtEcnhLc2g1UjV3?=
 =?utf-8?B?YXdIakt5bEVnZmt2aW9mK1dPK0N4YnREMUF6QmR6cWkyb3d2MlpjY3N2aENC?=
 =?utf-8?B?amt5aG1TV01tdk91bUxJV3NpcnJRYXZGYmgzNG9Yc3N1ZmREQ1hlMzF2bkN2?=
 =?utf-8?B?R1FhYjRwZ3hra3JuRU0vWU5aRkZpejVVckdlS2Z5RHg5MHErQlRGRVV4c040?=
 =?utf-8?B?TlByTUJCSyttbG5tNnFqM1RPNHRTQ3pyUEhBbGs0RG1DUXcwNHEyelNvWDVp?=
 =?utf-8?B?M3BycCtxcFUzcTBhSDVqWXFaOC9hZlVLbGJpZ20zSHJROTVtY1NzQjhKZTYz?=
 =?utf-8?B?U0lUMnBBWUhzN1JaRlF6NTc3eUxyUi8wY2JaemRHUkZkbHNYQUozeE5ub0pu?=
 =?utf-8?B?YUxIL1hDNkx3cCtVcUl1ZS9jR290aVFLUkhWTlhWZEJSdzBDc2Q0YVJIYmsy?=
 =?utf-8?B?bDVEbit2bS92eWhQTWJHM2lEOUpwQ1ZJTWMvYkwreThTY1BIUkgwL0EwZkRG?=
 =?utf-8?B?eHl6cGRwNXdCdS92WHpPOTdwb1lpSUIvREdIRXdVWS9WbG1JeUlVa0FtNXdQ?=
 =?utf-8?B?bUt5RzBpT0RMZ1p4TDNaWUMvY3ZGU2lRcHBaekpaVDlzK0JUd0pVSmVESlNp?=
 =?utf-8?B?cHoxTHNlZFI2UUtpbGE0Z3djWHpYZXhjT3p4VnArTmRPWWdVSDBiS3VBb3BU?=
 =?utf-8?B?VU1hSW9lMUpTNE1PeW5SbXh5N3NOZzhveG5Cank2Nk15YkNhUDNRSHpraTJY?=
 =?utf-8?B?SURYRmV5cm4zZnljMk1ESWVOV2FlVk4zSmI0S29HeEozUUJyeHVVaUd1OFU2?=
 =?utf-8?B?R2ZwZmdUYmZBYjN6SXE0a3I4NjFSblJCcUhDYjFGam9kMFdQeFAzQU1uUkNP?=
 =?utf-8?B?QWN2ODZlZEN4dklTSU9KWDZSVFlIZHlIMEZveEtRemg2aGpKd0FsWSsrOXp5?=
 =?utf-8?B?SWNLdWM1anZ4cEdSZFVLQkRCNGRKUmk3TjhTVWtNeG5GaGNGc3h3cFRYWFhP?=
 =?utf-8?B?OUpBWCswVnh4VHFMMEoxazVSMHZaUXY3RExub0ZXUVloMnE1aXY2VExlVUk1?=
 =?utf-8?B?Mm5nUWEwM0NnUzhYSjZGNEh1UlQ5OEFyZE9BREhyZHlNR1FRQkc1bGdLQUdp?=
 =?utf-8?B?allKTTFSR3ZOQW5SMzh0ZXh2M25nT2hZMWcyeDUreXF1dzNieDZscTA4bzVT?=
 =?utf-8?B?MXpNOWZTY042UzF0WnRVZW5TRnB5UzlXTk1YRjYxOFh2K2RMenl2WjQ3aXEv?=
 =?utf-8?B?UnlhV2R4UWIvTjNGeFFVSFRsZ1J5cDJ5SnBJYk93cnJpUnQzWSsxR25sSzlC?=
 =?utf-8?B?Y016NEVzV3ViUG1xTjJiOVJvdXE2a3BNRWMvTU5QUmVLZDhuN0ZDNGxpcks2?=
 =?utf-8?B?cFBRZHpVajNCZHJ5NDlrSnJHbVR5WnkxQk1oRUlEN1Bid2J5ZnJXeElhcGJT?=
 =?utf-8?B?WVhWQ2pMVHNiakdJVi9yQ2J6ZTJGb2x5bGRvaHFaQ2lhMlNUb1Q5Y1F4RTlp?=
 =?utf-8?B?aWc4VzhCNTBFMFRXemJ2eUdwRGZTV25GT3dwb0hUL2pEZXEzSUh6dDJSaE55?=
 =?utf-8?B?M1AwWmdOMTVCd2E4MWJPSk15STdNL1Q1UFdkTnBrcGNqbm1oNWI1NVQ3TDdF?=
 =?utf-8?B?Q2FhZ3dBQm00elZJRTRNNWsvQ2xFRmRBVk5KanI5RTErVnBLODFIN3pBUFBF?=
 =?utf-8?B?YUNka0VGSFAzVzFXZlU1bHc4ZEs2eDZZWjRoTEM5NDZscWNoWFBaU2NjZ3dn?=
 =?utf-8?Q?zxx79HBJs+WFMq8uHqqxPDrpgXKbtH8lDzIZtvn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDJZYzA1VFdTWXhRMnkzeldvQ29mVFY3S2JNK05EY05PcjVKRzhod0o3RTdv?=
 =?utf-8?B?VmJWemVQMXIvQzVKaXB6bk0xbWZRNWxsR0hESHhHNlAxUmZMS0ZkR1NtdkQx?=
 =?utf-8?B?MndycnAxS3NFUmorVU5MZk8wc0pJQjl1VVdXMDFickFDWStOcW1DY0FFS3hw?=
 =?utf-8?B?L3JaWEU2Q2dscVVMem5NeVowYkZNeC9aRlk2aUtuY0RtWTFteHhnWWQwdGtl?=
 =?utf-8?B?Zk03Rm1lWi8wa1VZTXV3Ri9WMG9qQVBnVmFVRWZTLy9QM3FmSElDK25SZU5D?=
 =?utf-8?B?Wjk2ekRSWXZoQTJlL3FNZWlzYm55TndrUjBmQWU0ZmtKTmRzTnVmWXdtSjll?=
 =?utf-8?B?cENFajUrMVBtRTJuZkthaU1rVEVNRU5vdHFqVEdGNGZKVVo3UHh3N0t0Y05S?=
 =?utf-8?B?cU5IL1VaUzloMDZYVEI5Rzh6ZmZ1UTRsQU5YbVpDNzBqSXhub0p3VXZMdk5n?=
 =?utf-8?B?UHdoS0YxR3BVRW8wTU5kQS9Bckh5anRzNXllQk8yVTZISTZ5cXZ3b0gwZHJB?=
 =?utf-8?B?NkxRTHJoU0FvaEFzRStzM1dhWExSNlovWlZhNEZGUzVPb1pNaVZ5TE9ZU0tk?=
 =?utf-8?B?NDJ1OUtQYUhuWmg1RGovMHlaaHR0S0hFbGI5dHpVZDVrUGtJU0JrVW45Y0dD?=
 =?utf-8?B?SUhmSGJ1RHVTOVp2Q21UNXhNYWNTRjYrTlo2WFFRcENqN2lBMGk2aTNoYVgz?=
 =?utf-8?B?WjN1NU1pZ3lUb00vVjk4TFlpd3VVaDV6RUN0ZGV4WXBMcjRZbk1IWTg5c2pT?=
 =?utf-8?B?VEFjK0hrMDNvSnFLc3pyaFE1TWY0eU1UWkpRRytjcEhXQy85UHhVVnVCbXky?=
 =?utf-8?B?eVRxNHhnTzYySFAwS2FqT3ZJdTZkT3FFN01YWU11dnVOdGF3TDVidWlkb1VD?=
 =?utf-8?B?VjN1MDh1bWJqMlpIV0lRTTBMYVE2OXlyRlFFZzUxdGVzTVhhRTVvWWs1amZS?=
 =?utf-8?B?Wm5Qb2dtZi91Y0xjZVN1Z2luR3NFeGNRd2xFWjN4aXppT2N3VU1ueFBOWHU4?=
 =?utf-8?B?Wm9lVnd0cmhGNHYvTHZWMmJCYVRxTlB6K21ZU0lGRUsvSk9VeFVzRjVrMWRE?=
 =?utf-8?B?dmtJb3BEbzdSZjVmUlhoU2RBTmVYbE5mb0FnbDBzdUd0bmZVcVFyYjhaajI0?=
 =?utf-8?B?MnZjNDhTdkNHTHR3UnFtdUpkT3M4U2w4UVREQU9PV0I2cEtVcHZYRWk4ZE81?=
 =?utf-8?B?bTUyMXJvOEJUazZ4V3hlTXBNRXNZUGJJVTBWNk16aUgxWTgwTzgvRmF1Si84?=
 =?utf-8?B?VjRZSUUxMStDMXRiS1c0WEh0cnVSUG5WVlJpV01kNDNkWDF2bXU4cVR1K2lV?=
 =?utf-8?B?N2RDdGxDUlkveHI2dHdVbjZ2WmtEU3NZK3RtRGt6N0FEYnRqYmc1QnZsVkps?=
 =?utf-8?B?NWFMTVVETWxzRjdvNzFOMG1iWTVCNXNKMXJKN2JRTVJMdTl5b2N3UFU1Z2Zk?=
 =?utf-8?B?WDRCdjBqVkl3YzhZYTVoRzRYUkhIQlN4OWdSTUVnSms3YTJtWEJCclY3UkZ4?=
 =?utf-8?B?RXlyVktscjhvaUU5MndUTHhjMVZPY3VBT3hYNXVOWGxJeCtud0RaR0l0eTds?=
 =?utf-8?B?aSs3cXVxZ3hwejBrSE9pb25Nd0t5WVNqandmN1F5VTdiSjE4QThwRU9CK2xl?=
 =?utf-8?B?bjNFQWVPWGU4YmllRnliMlFDK0paWGs2cDNGN1JvbXdYNVRwTGpUTDRGTW5E?=
 =?utf-8?B?M0F6d1JxQklLOE9BU3huS3g4S0JaNm13Y0Z5Z3BTTG54UXp1dURvN01YZVNG?=
 =?utf-8?B?RFZFcEs5NjVudkdYWkFDVTVVSFBQczRNTmxVL0FWYWg1cTNXYUpQa0tNOWpY?=
 =?utf-8?B?d21xYXFqdk03ajlkVWpWUVQrM2xZdDBCaDcrS1hsZnRiUXhmOHRjam5sMVpt?=
 =?utf-8?B?SmZSUnE4OEtSemJXWmhvTDdRejZLNDRNT3RpUVNKY3c5NGpHV1NwcVczU2Nx?=
 =?utf-8?B?Ym83ZzdoelE0MTZvNjdrSk9id0dyRUlJNjZIMUZ5Qk4vdUJHbVdZRmk5Znl2?=
 =?utf-8?B?a2pRREJvSjVwMHoyY05kalhVcEgycG1wWEF0cVFtakE5emJFWE44ZTZjc3lp?=
 =?utf-8?B?RjYyUnRmQzNjdmhPeGpLS2lNdURJcGppZ0Z4bW83UU4yaG1PdUlkTUJrSU4x?=
 =?utf-8?Q?69luUugCGMrPbHPvZ5xHR3pZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099e98f6-3979-4de1-a2dd-08dd0d61d843
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:00:04.9833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOdfvqeNcyHIpBhn0FFPOzMrLTaZPiV+DbhQKWzEb5MZ1tQtvliY7kRi1D6mZGvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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



On 11/25/2024 12:30 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
> In order to make suspend/resume more reliable we moved this into
> the pmops prepare() callback so that the suspend sequence would fail
> but the system could remain operational under high memory usage suspend.
> 
> Another class of issues exist though where due to memory fragementation
> there isn't a large enough contiguous space and swap isn't accessible.
> 
> Add support for a suspend/hibernate notification callback that could
> evict VRAM before tasks are frozen. This should allow paging out to swap
> if necessary.
> 
> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Make non fatal, drop patch 3
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d8bc6da500161..79ec4ab8ecfc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -879,6 +879,7 @@ struct amdgpu_device {
>  	bool				need_swiotlb;
>  	bool				accel_working;
>  	struct notifier_block		acpi_nb;
> +	struct notifier_block		pm_nb;
>  	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>  	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>  	struct debugfs_blob_wrapper     debugfs_discovery_blob;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 996e9c78384dd..56510ab4b6650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -191,6 +191,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>  }
>  
>  static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data);
>  
>  /**
>   * DOC: pcie_replay_count
> @@ -4553,6 +4555,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  
>  	amdgpu_device_check_iommu_direct_map(adev);
>  
> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
> +	r = register_pm_notifier(&adev->pm_nb);
> +	if (r)
> +		goto failed;
> +
>  	return 0;
>  
>  release_ras_con:
> @@ -4617,6 +4624,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  		drain_workqueue(adev->mman.bdev.wq);
>  	adev->shutdown = true;
>  
> +	unregister_pm_notifier(&adev->pm_nb);
> +
>  	/* make sure IB test finished before entering exclusive mode
>  	 * to avoid preemption on IB test
>  	 */
> @@ -4748,6 +4757,42 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>  /*
>   * Suspend & resume.
>   */
> +/**
> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
> + * @nb: notifier block
> + * @mode: suspend mode
> + * @data: data
> + *
> + * This function is called when the system is about to suspend or hibernate.
> + * It is used to evict resources from the device before the system goes to
> + * sleep while there is still access to swap.
> + */
> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
> +				     void *data)
> +{
> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> +	int r;
> +
> +	switch (mode) {
> +	case PM_HIBERNATION_PREPARE:
> +		adev->in_s4 = true;
> +		fallthrough;

Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781

What if this callback takes care only of suspend case and leaves the
hibernate case to dpm_prepare callback?

Thanks,
Lijo
> +	case PM_SUSPEND_PREPARE:
> +		r = amdgpu_device_evict_resources(adev);
> +		adev->in_s4 = false;
> +		/*
> +		 * This is considered non-fatal at thie time because
> +		 * amdgpu_device_prepare() will also evict resources.
> +		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> +		 */
> +		if (r)
> +			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur\n");
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * amdgpu_device_prepare - prepare for device suspend
>   *

