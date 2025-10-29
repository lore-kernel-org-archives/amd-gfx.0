Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1794CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B5310E056;
	Wed, 29 Oct 2025 11:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mOtW/CzJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F05A10E056
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evd1N2w85y5DcPiJPqp9csBFNjS57C6UFfK4D8cZIO8dLmRs5y0lIwB0U3XUckGkx6yNI+Evg7b4KT9RDPXEZ5wKglSD9QKRvEvVjny/ZA/3RpE5FzzeGTf5322ceEwFYetKgEfuoYC/gSqBct9Pr6G7qqoi7+AEWCxUhWmwHZZuac2etLfoDfH0IhbV5L7XXqiq1RlcfTovKMaPv9IT8v091mFiw43Bcfat/uLczkOFgnSMVbMDPdyNu/29lGd10PmEYds0OyY/wZy3U4FpWMn9e1e8kmPqei62bN+zRGnDNLh8YF4OuFYLcNYTE8DGRClZ0FDYiOMvtBNm6FfbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5ib4RI3klb8j8S6zCZKBy9ExVTG7HCVp3sCs3TvbQ0=;
 b=grkyBtDXp4V+MtSXeAkonEEEgDWFT0q/8BK3gEr0su+alPl3LHEdxFW3lfz6vt8iHJL+LtBIj+cH1VnoUh+6FdczfaNnddg5lYkz9ClGgbgp6sypv35SuDttIBxrIb6IQL67ZuT+WDaAHV26eM+fyfmAgJamWCfQiB34ZPfdDX8sZdi1iQqklOxVG4SW9yfdYoHvAMa84U3XJ671SSZK7D3CkymxuetdWFe3DP5f7qY5tEX/zbViR+0QOJsRIsU0bJiF4X+hYtgMPURELqZxjrtmxNOD8HfgCJQ7B1q+5BG99fut3R2phuLieT8MgIQFHQLaIWqPXsWKd0stIUcM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5ib4RI3klb8j8S6zCZKBy9ExVTG7HCVp3sCs3TvbQ0=;
 b=mOtW/CzJDJFKRwbsOVLPcCC77u4DZQDoH5oJwi051f5+zf3wchS7fm9x5NzVgCkT8H4fT5RAWU5wDyXm8yBP3W6AJKPyatbBRiGMTvJ1IDYQQbj6a8NEbiwXh6oWPcTvKVX1TXIHyUGNfC28hnkeCelK6u8rhimmpN6RyvtQ3Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:23:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:23:28 +0000
Message-ID: <b2b0d1fc-f145-4de1-aea0-de982151a996@amd.com>
Date: Wed, 29 Oct 2025 12:23:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] drm/amdgpu/vce1: Clean up register definitions
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-9-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-9-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5177d677-418e-4a27-5651-08de16dd950c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ZpRG1aSUh4WXFES0p0aUxaM2pSR2x3WW9xWU1XVkFvdUczZUs2b2lqVUo5?=
 =?utf-8?B?NkhQcWhua3YxQmk4UTBXUEJScXhUN2lGSXJhWVpCR25sbk1NSk5FMW9WNlVR?=
 =?utf-8?B?bGpzVlNRNUFjdXBDK04vU0wvSzIraFpNRFUzeVpqMGhDT21Xd1JTNGZObVZu?=
 =?utf-8?B?Yk1FWkJiaWdPY2Q0UnRocy9wREU1UmNNNjZLZTgzellDUnB5RWlDbUFXdWZi?=
 =?utf-8?B?a3lQVDNpendQcGJFYzN4aDcwZmUzN0NSUnU1bTY5RDl0aXk0ZmJySk5TVVE0?=
 =?utf-8?B?M3RvTjgvVStESWc5U0doSGlGYTNTazYvaG9PV1d0LzFkS29sSStOSCs1eUxU?=
 =?utf-8?B?OW1RbFZQUXc3UG1ybmtFcWtUbzBMMEpUU1dDdU5LOTFoTmRzcndPRjVwOFE1?=
 =?utf-8?B?N2laNVV5ZnlQVTd2ZDBrdjIyQVM5SXVHVjVSZ1JGNFhZTE52UG1MTFdnY3Fq?=
 =?utf-8?B?bmFZdDhwVHpKOFVSVitYUjlia29hQ2hCcndYV0ZkNXVWVjA5Q1AxeE42VXgr?=
 =?utf-8?B?SFNqQ0RDSzZEUUJJQlRicnJxUG1yUUF1ZHZQRFVENW04V2h5ZEs5S1JWS0dX?=
 =?utf-8?B?dVRkS3lhQmhEMHc5QWN1am91RndOeTdqZVJ4amNiS3BJek5rcXZsWlNRUm4y?=
 =?utf-8?B?ZEZWdjY5Sjh4eHFIb3JnWFNhb1ArSWJhcHNxVHRMUXNlY0dVUzlIaXFocXNR?=
 =?utf-8?B?WTFOd1BGMmI5VVAvZFFCVmZyaVhweG1zMldsVWVxN0xpQkpVUDhkdjZFN0hs?=
 =?utf-8?B?WDJzaDlGZDk3bkVsc3VSUGhGQ2l6RVBFVDRYa1pZTXljV1E0SXhXR2dSLzdz?=
 =?utf-8?B?YWt5UEhieWV2eHNIM0hVTWpReVRMK0w5a09zcndXWWEwVExOemUrb3RjcEEv?=
 =?utf-8?B?Wm9wU2dVWHVoNmFucFFSV0ZFRlJrOXRsWmtrcWYxeUFuamFtU2JZSUFrZmR6?=
 =?utf-8?B?RnNFVXgzUXdwaG0xSWZjUWhsZ1hNeW1HSXFtb0lMQTdPNC9Zd2w4Sk1iZEZ5?=
 =?utf-8?B?UFV2T0xZaW1ydStVZzFhOTFPYW5CVW1jNHhRdC9YZEVMdVAyTm8xNG1GTHRs?=
 =?utf-8?B?SVFZcld0bkYxMzBtbGJoRkxlc3lrUER0aExXWEVscDN1R1Zyc0VwbndCNnRF?=
 =?utf-8?B?UEVadzU4eTJCaUV2bjMwVFUwRlZ4T2xacU01MUxvbTV6VFRJTythei9Xd1pK?=
 =?utf-8?B?S0xhNzB3YjEyaVkrQjdzclNKeS9kaUJJWHFGUC9hanA4aGdabzlpWC9XQW5P?=
 =?utf-8?B?RElvRW9qOGxiaHA0L0x2V3VReHRVQVcrRjhxNVlsTXNtRnoxTzIwUEF5RWlU?=
 =?utf-8?B?K0wwb2dzR0lJemltRlZtUUJXTnNyYTdPelQ0bnZZckxZVmZpUUQwaW1mNnJS?=
 =?utf-8?B?dVdXZFZDUlh5TG1DUzBnRkt1L3QvTWtMM2g4M0VzVVVrdWtrOWY5b1dGQTlL?=
 =?utf-8?B?OHYySTZFOU5YUnhuOW1TQnQ2M01ibDh2K0UxeXEyZFZ1ZVlKZkx3SW1Dc2pn?=
 =?utf-8?B?SURLMEhUaCtuSTh6Sy9JVHU4OWdUUURDZEZ0a00zRUhjZTVCeHk4cnVtd2Ra?=
 =?utf-8?B?NkdqMlBwdk83bmVQWXlDV0E0dkk3blhKNUpMeFVza0dBOEs2UW5jdnZMdnVG?=
 =?utf-8?B?Q2ViQWVaOVI3QUVQYzlJSkIrWkFETTk2a2RnRUR2WVljNHRNakZPNWFLRlk3?=
 =?utf-8?B?bFBpc3NVNVVOd1o4ck5aY3MzazBMeDl1M1pkU1FDb3NtV09jYXg2eVZoUlZy?=
 =?utf-8?B?dHlONkJlSUNlaXowd1lrS2kraUZLZlFYUGxkOUdwVzRHT1ZPTzNkUGlxOWZB?=
 =?utf-8?B?LzZSLzI2bHRhdHZWNTNmZFhhRjZYbjE5MmxYTjZpR09sMVZUSXh3QmFiVTht?=
 =?utf-8?B?QmRDTHRBMHMxTURXL05aZjlOK0thTXRwTWdGUjRQNExXc2RFRVNoZlNnOWE4?=
 =?utf-8?Q?c8G5WTrPbSmTobg5XeHc0nngPMS1fikd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVc0NE5Vd0o1alhRem9lSDFHZmxNemVySGxrOGg0Yy9mQkVveTBIT2RUTExp?=
 =?utf-8?B?cHNHclAxUDhxbXduQ0hHSGhDUXVvUTN1cEZGYmJFdjRndDZwWnFuRW9BWWk0?=
 =?utf-8?B?SVBEWWF2V2YzdVh4aVAxWXd4OFZiK1BrS0VJaEo0MThpUUJSVkV5R2dRZUw5?=
 =?utf-8?B?UVFpM2dLK0haWm1RVDd2V3VlV0E3S0tDOGJZL1ZtbnRLaGE5aWhTZGdQYVZw?=
 =?utf-8?B?Tmw3dHMwK3BZdXpjTHJpM1loYzVLV3lha3dESzRYaHlNYXFONlNjWHBMdjFK?=
 =?utf-8?B?dFNUaHliekFsRE1JS0xrOTY1RGE2NmQzdGE3dVpLWlRyaHZid2g5Nlk2K1JZ?=
 =?utf-8?B?REl5bU5NY05kY0JqNmJEcjl2cEthcEw3WW5KNVdwUGtKUDAzcC9Wbnp2REwy?=
 =?utf-8?B?ajl2WFdFcDJPUWxPS2QyaGF4YzlQdlZOSVR1c1R1eTJTUzFVelU4YlJEM0NT?=
 =?utf-8?B?ZWJKWkxUZ2VKcnJZZkp1Tlp6M0tKazltZm5PNkh2YWJISjNvZUdCQzBwYUl2?=
 =?utf-8?B?NmhvQWJoQkRTYy81c2h2VnIzeXdlallKYUhjMmdWK0NGSE1XcHQ1Vm8yMngy?=
 =?utf-8?B?N282NG9VNk5OY0E4RngwT3R3RmJleE5lc2haV0JTdExOU01QL3NKNE1kc2Jl?=
 =?utf-8?B?UlNmY3V0NFVTR1NZVW95RFpKdWlCVDBHZnVjbFhVMUkwM08zbFZCV2NYbXRt?=
 =?utf-8?B?L2EydTBVbUxUMU5kcDR5VkhYZkw2K3JnOWMvNHJsR3E1NktlaGRTNGtlTHBn?=
 =?utf-8?B?UDl6dUV4alhEelM3S01ENmxoYmpKaGllZ011T0FMMURBSnlCcWlsMnEwMmdD?=
 =?utf-8?B?eWM0aUFWSEhyOTBnaktKNFdhekltUXRKa0V3M1dLMG91ek5ENXNoWTYvYklE?=
 =?utf-8?B?bWJtNUdvclVXdU9lcHBSTEZyVE40bDV6Q2VsTlFLSTYxSmd3S2FJZVdZSU4y?=
 =?utf-8?B?RzYwUzhSQS84ZzdpSkZpVzRnRi8rOXRvNmJLT0FLNklvbG92ODg1eXQxTVpS?=
 =?utf-8?B?eGxaZ1ZJaVQyN2xVb2w4U1EzNUROYkxld0wyYjBTbUFGY0JaY0QvVFBadDNT?=
 =?utf-8?B?KytDTjZQandCNDQ5SzhaZHRPUHVZUSthTlBjSlRXczFlUnM3NmViTFk1cG1v?=
 =?utf-8?B?RU5CSHdNWWw1WWxGSnB0Qm1rc3d5NTgzQ2thdmNvQ1VtaWlZaWFBWlI5NWFv?=
 =?utf-8?B?bWJSTGkzVVluRHZrTXkyZjVtTFlvMHc2UkowOGY5ZHRMSDBKeURVUVc0ZUxp?=
 =?utf-8?B?VGJLWUFUUmRPUVh4aFdoQUtWbjJoVDlzcVZ5UmN3aXRzQjBJcUdNbXFmTmFE?=
 =?utf-8?B?Si9DaFlkdnBtemNkMnJJVS9DbWNSeEdXdHIzckZxeWZuZjNmWkZOOXFFWmtL?=
 =?utf-8?B?KzVpZEo2R01ZczNWYkNBK1FTblVOSWRpU0cxaTAxWHJua3g5anZldHRON2d5?=
 =?utf-8?B?WGc2RmRETG9KdnhoZXJkcU1pR01qUm56V2drVkJKeFdPajJHZlJNc1V1VXh6?=
 =?utf-8?B?dlpKZG9LeHg0MDZIMklDeVRhVFpzN1RlVDlXY1dDZ29vSFBhcFZuRW1yS3NI?=
 =?utf-8?B?WHhFSmVBMGFHZVhJUzl0am5OSkRmMGlNZnZxenA4UFJRZUNWdm5zUmNGc3F3?=
 =?utf-8?B?TmpvRCtGZXc2SENIejFVYTJSMWFQaHRkYzJ3R1ZpSTM0L01pbVU4VEhwUEgx?=
 =?utf-8?B?OWNybXpadE9XSHkwSzZ5K0RkK3R2VEwzRHpWR2lTODhRRTFwNmJEcTNNYlU0?=
 =?utf-8?B?Nml1MUFDR3o0cTVPdTdRenJlcWVDYUZadlNkZ0pqT3FMeDNBRURQMmZiRkt0?=
 =?utf-8?B?MVVYMHA0ZTJkQm5zaW0zNjlYU1F0c1NkL096ZVh3Tlo3RVpRckRKMUQySDla?=
 =?utf-8?B?RU1KRGRUblhzS2VBUmdMQ1V1TU80ZnZ4WjFZTFVXRTJGRkxGQVAybHFOZVc4?=
 =?utf-8?B?MWlvaFRMMzhKWHBHUnhNajNGdGtHUURGN1U5bDBsUUhpazluRW04YjJWS3B3?=
 =?utf-8?B?UTNabHVWdThsK0dWcm8rTktacFFtZXFvRFlyVnZSKzNnSDlJTHlvVkRSUEMx?=
 =?utf-8?B?d3dXY0VqY1h3MjMyemVlbmVraGdQM3E1VExEUkpuMW56dXExRjNUakJKaVB4?=
 =?utf-8?Q?Vb1YKjWu817H9ITZUR5ogwulV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177d677-418e-4a27-5651-08de16dd950c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:23:28.2222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kmBTudrCAwKyMP69dH12iiR3BKm1A85DQgYtCMWFP2mAjlBULijG9NJVJhquTMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

On 10/28/25 23:06, Timur Kristóf wrote:
> The sid.h header contained some VCE1 register definitions, but
> they were using byte offsets (probably copied from the old radeon
> driver). Move all of these to the proper VCE1 headers.
> 
> Also add the register definitions that we need for the
> firmware validation mechanism in VCE1.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sid.h              | 40 -------------------
>  .../drm/amd/include/asic_reg/vce/vce_1_0_d.h  |  5 +++
>  .../include/asic_reg/vce/vce_1_0_sh_mask.h    | 10 +++++
>  3 files changed, 15 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index cbd4f8951cfa..561462a8332e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -582,45 +582,6 @@
>  #define	DMA_PACKET_NOP					  0xf
>  
>  /* VCE */
> -#define VCE_STATUS					0x20004
> -#define VCE_VCPU_CNTL					0x20014
> -#define		VCE_CLK_EN				(1 << 0)
> -#define VCE_VCPU_CACHE_OFFSET0				0x20024
> -#define VCE_VCPU_CACHE_SIZE0				0x20028
> -#define VCE_VCPU_CACHE_OFFSET1				0x2002c
> -#define VCE_VCPU_CACHE_SIZE1				0x20030
> -#define VCE_VCPU_CACHE_OFFSET2				0x20034
> -#define VCE_VCPU_CACHE_SIZE2				0x20038
> -#define VCE_SOFT_RESET					0x20120
> -#define 	VCE_ECPU_SOFT_RESET			(1 << 0)
> -#define 	VCE_FME_SOFT_RESET			(1 << 2)
> -#define VCE_RB_BASE_LO2					0x2016c
> -#define VCE_RB_BASE_HI2					0x20170
> -#define VCE_RB_SIZE2					0x20174
> -#define VCE_RB_RPTR2					0x20178
> -#define VCE_RB_WPTR2					0x2017c
> -#define VCE_RB_BASE_LO					0x20180
> -#define VCE_RB_BASE_HI					0x20184
> -#define VCE_RB_SIZE					0x20188
> -#define VCE_RB_RPTR					0x2018c
> -#define VCE_RB_WPTR					0x20190
> -#define VCE_CLOCK_GATING_A				0x202f8
> -#define VCE_CLOCK_GATING_B				0x202fc
> -#define VCE_UENC_CLOCK_GATING				0x205bc
> -#define VCE_UENC_REG_CLOCK_GATING			0x205c0
> -#define VCE_FW_REG_STATUS				0x20e10
> -#	define VCE_FW_REG_STATUS_BUSY			(1 << 0)
> -#	define VCE_FW_REG_STATUS_PASS			(1 << 3)
> -#	define VCE_FW_REG_STATUS_DONE			(1 << 11)
> -#define VCE_LMI_FW_START_KEYSEL				0x20e18
> -#define VCE_LMI_FW_PERIODIC_CTRL			0x20e20
> -#define VCE_LMI_CTRL2					0x20e74
> -#define VCE_LMI_CTRL					0x20e98
> -#define VCE_LMI_VM_CTRL					0x20ea0
> -#define VCE_LMI_SWAP_CNTL				0x20eb4
> -#define VCE_LMI_SWAP_CNTL1				0x20eb8
> -#define VCE_LMI_CACHE_CTRL				0x20ef4
> -
>  #define VCE_CMD_NO_OP					0x00000000
>  #define VCE_CMD_END					0x00000001
>  #define VCE_CMD_IB					0x00000002
> @@ -629,7 +590,6 @@
>  #define VCE_CMD_IB_AUTO					0x00000005
>  #define VCE_CMD_SEMAPHORE				0x00000006
>  
> -
>  //#dce stupp
>  /* display controller offsets used for crtc/cur/lut/grph/viewport/etc. */
>  #define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6df0 - 0x6df0)/4
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
> index 2176548e9203..9778822dd2a0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
> @@ -60,5 +60,10 @@
>  #define mmVCE_VCPU_CACHE_SIZE1 0x800C
>  #define mmVCE_VCPU_CACHE_SIZE2 0x800E
>  #define mmVCE_VCPU_CNTL 0x8005
> +#define mmVCE_VCPU_SCRATCH7 0x8037
> +#define mmVCE_FW_REG_STATUS 0x8384
> +#define mmVCE_LMI_FW_PERIODIC_CTRL 0x8388
> +#define mmVCE_LMI_FW_START_KEYSEL 0x8386
> +
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> index ea5b26b11cb1..1f82d6f5abde 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> @@ -61,6 +61,8 @@
>  #define VCE_RB_WPTR__RB_WPTR__SHIFT 0x00000004
>  #define VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK 0x00000001L
>  #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
> +#define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
> +#define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
>  #define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
>  #define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
>  #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
> @@ -95,5 +97,13 @@
>  #define VCE_VCPU_CNTL__CLK_EN__SHIFT 0x00000000
>  #define VCE_VCPU_CNTL__RBBM_SOFT_RESET_MASK 0x00040000L
>  #define VCE_VCPU_CNTL__RBBM_SOFT_RESET__SHIFT 0x00000012
> +#define VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK 0x00010000
> +#define VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_SHIFT 0x00000010
> +#define VCE_FW_REG_STATUS__BUSY_MASK 0x0000001
> +#define VCE_FW_REG_STATUS__BUSY__SHIFT 0x0000001
> +#define VCE_FW_REG_STATUS__PASS_MASK 0x0000008
> +#define VCE_FW_REG_STATUS__PASS__SHIFT 0x0000003
> +#define VCE_FW_REG_STATUS__DONE_MASK 0x0000800
> +#define VCE_FW_REG_STATUS__DONE__SHIFT 0x000000b
>  
>  #endif

