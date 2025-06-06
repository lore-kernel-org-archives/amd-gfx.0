Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1741AC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 14:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B0910EAC2;
	Fri,  6 Jun 2025 14:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/opa9Ya";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E59C10EAC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 14:21:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T58V3bYxrbHAoOzhTpMcUo5jHBiF5YrE2LC7O5dKOse2Jvp3LLNJr0gU5YfV4J4BuaCTd8eHm0MSR3XVwGbwtRKYtlsyA/icncnUrR7HLLatMzhJrBjxwOzvvv/LWg8j7c5Eevt5OIC+mBjTs1fTdWIU+cBkqc2a4auA3HuIf5k2bw7x+FoVvElp8jMl7SOjOWVVZDt5fNUUmsPLsLsx4PgRuyyPgB3h6/lnAr6Upu9UAKT0zmdOTi3N8ScT6/rlgRs7rUmUHRoN5XeN+eszzOdBu4b/7wLQLYPZlpLp9AFUq+0OmKcPaHse/Pyd3gAqrcddt/JHFDEwhmpmGdD4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LxjlqjZjJBvIG7syqyzW14jykK8x53X88aaupV78MY=;
 b=iBwb+1jJ4hE0qmQzMwTfGaKORQ4zxWOq7UTkeYNqdvFAaqS31EJExjHgZu2plMPn8TVdC6MjRlzvPKnppxPIT9cME5bAChNWVzlhbrB1CtB2WMEHCZkEmeAwJ0hqXRfEQMLXuP2gpLTmw3y/MHgnePE7O+k1TvLGQUQJpeZhqYe+uJ43nQ0rXsQq7IRy63M/t9fD+4lfVouy038R+aN+BMHpWwKMryaZ+F3PCoktvFIljisC1jPfOHCNEDibFXF2E+9ZnTSEBFkrE95UQcPyjRdxYumg8FLfyGNfF8uZYdKQJHMbLc1IyQ80gWX5cq1T+8lioTFg6youFfYIje0WIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LxjlqjZjJBvIG7syqyzW14jykK8x53X88aaupV78MY=;
 b=z/opa9YaqJ7zcnVD+uVsj4GHUsaQT5yLLLF3Nr/S+9kunClo/mRUX02Ik5qW3v8D5eC612D0T/8csmD89GXP4/kb/P+ZFSlmadWJw4ptC4RI0HI8EtnoQcEQYzJclb/ymfrWY1gtiV2gA+xHEjuim/Z1jZvriXWRwpw3wsR8EM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 14:21:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Fri, 6 Jun 2025
 14:21:46 +0000
Message-ID: <2f4b8804-21bf-4fbf-8e67-31a659195d4d@amd.com>
Date: Fri, 6 Jun 2025 19:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Move the process suspend and resume out of
 full access
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606100826.2064143-1-Emily.Deng@amd.com>
Content-Language: en-US
Cc: "Joshi, Mukul" <mukul.joshi@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250606100826.2064143-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c28b7b4-6c5c-4b79-ca23-08dda50577c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cndVR2orbktIdHZacmZsYkZwd2lkUnp4ekYrOXVRZEZMQ0swUUU4V1FsNVFM?=
 =?utf-8?B?Mi9xaTRiekk2dFBZS21KQ0F1ZXovTVdidFJ1N0UwNi9NempEVUVTSDZlc3Rp?=
 =?utf-8?B?UU15Tmd5Z3hXZFc4dU5NR3N3SHZsMVp4TlNzdmQxbEQwczhvaU9kSk8xVDhp?=
 =?utf-8?B?QThUU2pXVm5yUFE3ZllJMXBBclJmOHViSHVQSUZ4aXJXNUhialpBMnNOamQx?=
 =?utf-8?B?L3EybEpFYTFrYjRMTVh0U1NqbXNNTXAvbzlINFJBTEJlc3djMmlyUXZsaW9H?=
 =?utf-8?B?L3QxbXFBeUV4bGRTcG9XMEM1aHVSQkJXTGZGcGlUSHp3Q1pXQys2Njczb3JY?=
 =?utf-8?B?M3JZT2M0cTVnaUtnYTZZSUNIVFovWnVISktwNmNHVTlvakR3QzN5MHBobVl4?=
 =?utf-8?B?RlFOcDUydGo0azY3dFdQUnpHL0J3L2xBYkVvRC8xU3FxbzdlN3MrU3BYakRj?=
 =?utf-8?B?cEhZSGRrTEtMdU1DTHZ1SlRmZFRQYW5WTkxvVnVkVVZIcGg2bGU3am5qSDVG?=
 =?utf-8?B?N1RzMk9scGc0OE9Icmc1SE53Q2kySnprbTQyamZLTzdLRm5VTlFBT3VhcmQ1?=
 =?utf-8?B?cHJuNVJnSnpGS0U2TTNSWFlycVMyRldwalRoZGVaOVAxc2ZpakNkc3pxTUJB?=
 =?utf-8?B?WDQ1R2FRN3VrdzBBNndPcFZLblgzS0RzaHB0WURhQ3NLUmhOeHV1bE9VSHM5?=
 =?utf-8?B?OGt6bi9qNWhLbXU1dml3QkFOR0NzeW16VnhGczN6Rzc0aXNVdm9XVnpoWDR6?=
 =?utf-8?B?ZmdEdktheW01SmluaWZBS0NWV0lENmpsZ1V2cUZjOTlNYkJEWXNiUW53MDNp?=
 =?utf-8?B?TnEwVXFLUXk2WUxSVG1sQWFxY3VFUm1RNFJVSWIxcVQ3K3dhU2kwT3ArcXNO?=
 =?utf-8?B?UkowbThjYzBQSlFITWJqUnpmRm4zbkYyZXBxMmpGbitGRWY3RGpnOUJMdHBE?=
 =?utf-8?B?ZlVnU0JoQmt4ek01T2FkOXN4TEc0RTFGV1QySGQyaXcvQmNTdEQ5b3JDYy9y?=
 =?utf-8?B?MERzcXNVMFNkaU5sbHJyb3BFbnN6aXI0c0NxMDV1V1kwMVl5VzRsdXdUMmFX?=
 =?utf-8?B?UWlPSVRCNFh5Zk9SaHB0TVVDZmc2M1dLeEs5eXZlTlltN3grODJVcEMvd0cv?=
 =?utf-8?B?d1h2cndPOVRGVHVJN3FEakgzMC9BaVNraWRKb1llb1ZVN0xxVlhYQy9GUkE3?=
 =?utf-8?B?U25DaERudUZHeXZBK0ZsQ2hMVWgydmFLYVZkSEZ0ZWxzZm9nM2VzWEJGdG1Z?=
 =?utf-8?B?a3ZyQ3dsNlBpQWJzcHErb1V6YnYxVnlsNDJieHRDclczQXpnSXE2c3NxUkxV?=
 =?utf-8?B?SHpEUkNzeUlsS1Vmc29BWVhLOTJwZW5Telh0am1hc0pDU3NNTzQ3ZzdHWVFk?=
 =?utf-8?B?Q3g3cSsrNHFCQzdDVXRaM1RqbTBsakZmV1JCMzhnREoyTlF1dG9ySWo1d056?=
 =?utf-8?B?dDRHemVlaDlLK1JzRTk5eEppS3Y0WlI4UERzcWNPaWRjWGxLZDJuVnVFNUdW?=
 =?utf-8?B?TFhuR1FiSkZOYzJPWTVHL1FvaUJwNzNrMU5KUERYSUphSnBIVEQxOFE3K1kr?=
 =?utf-8?B?V29GZlZldmNhbzVSWEkyOGRBOUxneGlIWTFsMmZteDhkTXZFU0FDYnMyUzky?=
 =?utf-8?B?QWVUVGRzYjQ3anM1a3FRcVFGSUJTOUdqRDlKb2NjV1F6VllpSmE3S2gzbzhs?=
 =?utf-8?B?aFYwQWN0RGRFazBwU04xK3NLcEk5OXo3RU1tdUQ3T2QvWUVRMFJyWXdMYk9J?=
 =?utf-8?B?endXM0pyK2d3YU45bUhCVkYxZTZJS1JBMDlwTU8zUGFGK1hPOS82NW5XaDYy?=
 =?utf-8?B?ZVlBcVJXM1grS0U1Q1ZKeUV4R3V4VkFzQmhPL25ZVldQdTc0c21DVnpIRVNt?=
 =?utf-8?B?dXhUbDF1M05tUmVLZ3d3dHdRMHFQRVFWOU4rVUJFNkNLaHZXL1lMTklYQ3ZR?=
 =?utf-8?Q?m3DNIzagqlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnB5ZXlseTRKSWF5a3hRSUpuaE80UW45ZEFwM2FCQ3lMb0c3TndTNk1LT3Yr?=
 =?utf-8?B?eC8yQ0hxVy95U3B4MVpxOXpCYko5NlEzc0tUYmlWc0FvdlY1VjN4dnBoWEJz?=
 =?utf-8?B?dkgrZ0hJSG5KaG4ydzNXMGtyR2lTUnFBSDEyVWlJaWJ1RWJvY1NEL3JTWlhl?=
 =?utf-8?B?ZVd4eHd5L3JIOTRlWFdkRFhDeEw4cmxzVDRSRWczTUZKeFMwdmlydjZET2Yv?=
 =?utf-8?B?TC9ETTVmSUNER2Z4emFLZGllQmNhaXY1TGNwQzVxakNlVk5lYmx5Nms5WFBD?=
 =?utf-8?B?UUd6cTRpWVVtM0ZIclZYNzVxOHNiV0tlU3BpYzVEZGZrN1JHam9OY2w5UHNk?=
 =?utf-8?B?UHRQMUZGZzJIWFBYanJ4LzhWdzkvdDRWMmFNanArblplaGQwOStjTEJpbXdJ?=
 =?utf-8?B?bEl2dzhYOGlwaUY0QzMyWmdSSUtFYmg3WFhWcFV1c1JvdkZscTVVdWpYbTQ1?=
 =?utf-8?B?amZ0TXRCdnNXdzBkNVFYbkpoUUhvMzcrRTBYZEFzOUlJQ09qS1dWS2ttK2I2?=
 =?utf-8?B?SkdyTVl2ZmVLeW5qdkZ1T3JONTJYLzhEWjM2RzJrbnA0dGloMkJSS0lHd1ZX?=
 =?utf-8?B?T2ptUzBmMXk3dmlRSkMvMWpyYU9sOWdwMzJiYTVEYWpKMmJnSUtieEJFY0xJ?=
 =?utf-8?B?akduRzNsTWVHSm9tZkF6N05mMjF2REtoRkJ5dTJLanpyWjRxM3J6VW1hdzZm?=
 =?utf-8?B?V1Q1WHJRWis4Y25XNzd2MFpJY1YzWjdjUWxnS0I2RTZPQkZ3SGJBdDlCUFBX?=
 =?utf-8?B?dlJXTW9QZzJlUDk1Z0hOa1BrTGVtUHkzN3oxVWFSWXNKbDA0cDUrYjlJRmh1?=
 =?utf-8?B?MzFROTlqTnduRC9ZMlFVRkFYa1c2T3RuSDZ5OWhEaDRkZmltc2pxUDRTRGs4?=
 =?utf-8?B?dU5QR2FXUFR1N2RVQ3RrTUpMK2xFcGJJUHJFcDRjNzM2Q21CdkZSVzJqNVJt?=
 =?utf-8?B?NXNOc0NEOHBrREZweGVTck1GeUthR0lDenR4UDZCU1lQNWZUMDRlN20xcFdo?=
 =?utf-8?B?RW9HK3BBdGgxMUlNTXh5NFJsTWh4Z1RpYjg0dmRKdjhWQTFvK0ZiVm5BT2FN?=
 =?utf-8?B?UWtoOTkyREp1MEQxeWswc2h5YWcwMzNGR1J4dU44N0psQU0rTXhLM3VjVmMz?=
 =?utf-8?B?OTE5blBrbExWL3dDQlZxaHIvQUwva0N2WXJmS1IrUU5oRndvclJwWjRtdGpF?=
 =?utf-8?B?VTF5ZmR5YUMxNTlSK1BiOE11UDFCZFBteDFpaHZLOGw0UXZ5d2FnWkdheEZk?=
 =?utf-8?B?QTgyamcwbi9VZUdOV1lLRStEV0pNZ3VnL0NpTjdBZk5pczZXZDZvNnhaekNo?=
 =?utf-8?B?Znp6UWliaTlRR1I4VWxuK0o2Smg4MlBncGNOcFJleGpMTWVNU2ExWUxMM2E2?=
 =?utf-8?B?YW1PWjkzMVlaajZmaUFTWDFrZGtDeW1BUGZHellmZmR0RnBRc1dsQVNYTThL?=
 =?utf-8?B?bUVPZ2E1Q1lwREppbkNJNnR2YnV5WW9IN1B2QndaKzhTeFFzREdEemd4aVM2?=
 =?utf-8?B?K3krYVNiVTJLazFySHU4K1RKRDBMSDF3OGVsdURvTStXQnRuY3hpaHNWSGZs?=
 =?utf-8?B?QmdjOWlKcThoZ010ZkVXK09JNVh4Mld5d3BNOHNNNXQvNzlhT2tDT05Qd1RM?=
 =?utf-8?B?Z2lNNHRRbjZJc2xLYUJCVnJTUHYxRW8zczhEVWNSVDB4bUc1YTVTRkpwMGg0?=
 =?utf-8?B?UWh2TS8vWXlaNVd0SzJjekZzU055azNneHlCOEtlazhpVWR1bUpWT1dBTzlu?=
 =?utf-8?B?SFVqZ09ycVpZR2lMM3ZHc3o4NjdBeDZlZTh6cEliNFlXMjhGYzE2UG5Gbjlp?=
 =?utf-8?B?L0xsdkgrdVhYRkNwc29QS0trdHV6SnBKNjVnTzBqZDE0YTlaTWM1WmxPelB2?=
 =?utf-8?B?NjFpQzVGTXJuSkFSclJvZ0NRaWFRTTJsYzBiWEozTDNIaEZ1QStDMnYwalBJ?=
 =?utf-8?B?RUdMV1p2T2FVaXlqQTQxTGpqcFlVZG5NUWxkL0wyNWZyODV3S1NGbWozRkFH?=
 =?utf-8?B?WEJyUGFTaTc0NzRzWUV2c1dTZ2VmbTFqVUhhQThHaEU5UklieVA4OGVDSmV3?=
 =?utf-8?B?NlRUNEd2cml6VUJBRHVjT00rTkxKVkR5SEwybStQN2ZvM29ld0tjSWhod2E3?=
 =?utf-8?Q?eH8FBtLkT/yXgq0JM+CBFOc/D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c28b7b4-6c5c-4b79-ca23-08dda50577c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:21:46.0907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hynaH9tmnxgCDEUUey6c346X0L7Ufqr4r2OfTJr6l8GQQNkLmwNgwq+3i/POZD7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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



On 6/6/2025 3:38 PM, Emily Deng wrote:
> For the suspend and resume process, exclusive access is not required.
> Therefore, it can be moved out of the full access section to reduce the
> duration of exclusive access.
> 
> v3:
> Move suspend processes before hardware fini.
> Remove twice call for bare metal.
> 
> v4:
> Refine code
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

cc: Mukul/Harish to take a look.

Thanks,
Lijo


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 24 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 ++++++--
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 11 +++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 57 ++++++++++++-------
>  6 files changed, 89 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d8ac4b1051a8..fe282b855734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -248,18 +248,34 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>  }
>  
> -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc)
>  {
>  	if (adev->kfd.dev)
> -		kgd2kfd_suspend(adev->kfd.dev, run_pm);
> +		kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
>  }
>  
> -int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
>  {
>  	int r = 0;
>  
>  	if (adev->kfd.dev)
> -		r = kgd2kfd_resume(adev->kfd.dev, run_pm);
> +		r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
> +
> +	return r;
> +}
> +
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev)
> +{
> +	if (adev->kfd.dev)
> +		kgd2kfd_suspend_process(adev->kfd.dev);
> +}
> +
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	if (adev->kfd.dev)
> +		r = kgd2kfd_resume_process(adev->kfd.dev);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b6ca41859b53..05ecba2a85eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -154,8 +154,10 @@ struct amdkfd_process_info {
>  int amdgpu_amdkfd_init(void);
>  void amdgpu_amdkfd_fini(void);
>  
> -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
> -int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc);
> +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev);
>  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  			const void *ih_ring_entry);
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> @@ -411,8 +413,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
>  bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  			 const struct kgd2kfd_shared_resources *gpu_resources);
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
> -void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
> -int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);
> +int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);
> +void kgd2kfd_suspend_process(struct kfd_dev *kfd);
> +int kgd2kfd_resume_process(struct kfd_dev *kfd);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  		      struct amdgpu_reset_context *reset_context);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
> @@ -454,11 +458,20 @@ static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  {
>  }
>  
> -static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> +static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
>  {
>  }
>  
> -static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> +static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
> +{
> +	return 0;
> +}
> +
> +static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool suspend_proc
> +{
> +}
> +
> +static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool resume_proc)
>  {
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index ffbaa8bc5eea..1105a09e55dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -320,7 +320,7 @@ static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_wai
>  	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return;
>  
> -	amdgpu_amdkfd_suspend(adev, false);
> +	amdgpu_amdkfd_suspend(adev, true);
>  
>  	if (suspend_resume_compute_scheduler(adev, true))
>  		goto out;
> @@ -333,7 +333,7 @@ static void set_barrier_auto_waitcnt(struct amdgpu_device *adev, bool enable_wai
>  out:
>  	suspend_resume_compute_scheduler(adev, false);
>  
> -	amdgpu_amdkfd_resume(adev, false);
> +	amdgpu_amdkfd_resume(adev, true);
>  
>  	up_read(&adev->reset_domain->sem);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5289400879ec..e8b500c266c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3524,7 +3524,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>  	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>  	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>  
> -	amdgpu_amdkfd_suspend(adev, false);
> +	amdgpu_amdkfd_suspend(adev, true);
>  	amdgpu_userq_suspend(adev);
>  
>  	/* Workaround for ASICs need to disable SMC first */
> @@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	adev->in_suspend = true;
>  
>  	if (amdgpu_sriov_vf(adev)) {
> +		if (!adev->in_s0ix && !adev->in_runpm)
> +			amdgpu_amdkfd_suspend_process(adev);
>  		amdgpu_virt_fini_data_exchange(adev);
>  		r = amdgpu_virt_request_full_gpu(adev, false);
>  		if (r)
> @@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	amdgpu_device_ip_suspend_phase1(adev);
>  
>  	if (!adev->in_s0ix) {
> -		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> +		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
>  		amdgpu_userq_suspend(adev);
>  	}
>  
> @@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	}
>  
>  	if (!adev->in_s0ix) {
> -		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
> +		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
>  		if (r)
>  			goto exit;
>  
> @@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	if (amdgpu_sriov_vf(adev)) {
>  		amdgpu_virt_init_data_exchange(adev);
>  		amdgpu_virt_release_full_gpu(adev, true);
> +
> +		if (!adev->in_s0ix && !r && !adev->in_runpm)
> +			r = amdgpu_amdkfd_resume_process(adev);
>  	}
>  
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c169112a5e7..48e2d67273f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1676,9 +1676,9 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>  		return -EOPNOTSUPP;
>  
> -	amdgpu_amdkfd_suspend(adev, false);
> +	amdgpu_amdkfd_suspend(adev, true);
>  	r = amdgpu_sdma_reset_engine(adev, id);
> -	amdgpu_amdkfd_resume(adev, false);
> +	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bf0854bd5555..6a832f3c2518 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -971,7 +971,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>  	}
>  
> -	kgd2kfd_suspend(kfd, false);
> +	kgd2kfd_suspend(kfd, true);
>  
>  	for (i = 0; i < kfd->num_nodes; i++)
>  		kfd_signal_reset_event(kfd->nodes[i]);
> @@ -1019,7 +1019,7 @@ bool kfd_is_locked(void)
>  	return  (kfd_locked > 0);
>  }
>  
> -void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)
>  {
>  	struct kfd_node *node;
>  	int i;
> @@ -1027,14 +1027,8 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  	if (!kfd->init_complete)
>  		return;
>  
> -	/* for runtime suspend, skip locking kfd */
> -	if (!run_pm) {
> -		mutex_lock(&kfd_processes_mutex);
> -		/* For first KFD device suspend all the KFD processes */
> -		if (++kfd_locked == 1)
> -			kfd_suspend_all_processes();
> -		mutex_unlock(&kfd_processes_mutex);
> -	}
> +	if (suspend_proc)
> +		kgd2kfd_suspend_process(kfd);
>  
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
> @@ -1042,7 +1036,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  	}
>  }
>  
> -int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> +int kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc)
>  {
>  	int ret, i;
>  
> @@ -1055,14 +1049,39 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  			return ret;
>  	}
>  
> -	/* for runtime resume, skip unlocking kfd */
> -	if (!run_pm) {
> -		mutex_lock(&kfd_processes_mutex);
> -		if (--kfd_locked == 0)
> -			ret = kfd_resume_all_processes();
> -		WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
> -		mutex_unlock(&kfd_processes_mutex);
> -	}
> +	if (resume_proc)
> +		ret = kgd2kfd_resume_process(kfd);
> +
> +	return ret;
> +}
> +
> +void kgd2kfd_suspend_process(struct kfd_dev *kfd)
> +{
> +	struct kfd_node *node;
> +	int i;
> +
> +	if (!kfd->init_complete)
> +		return;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	/* For first KFD device suspend all the KFD processes */
> +	if (++kfd_locked == 1)
> +		kfd_suspend_all_processes();
> +	mutex_unlock(&kfd_processes_mutex);
> +}
> +
> +int kgd2kfd_resume_process(struct kfd_dev *kfd)
> +{
> +	int ret, i;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	if (--kfd_locked == 0)
> +		ret = kfd_resume_all_processes();
> +	WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
> +	mutex_unlock(&kfd_processes_mutex);
>  
>  	return ret;
>  }

