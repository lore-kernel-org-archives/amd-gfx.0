Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C063CCA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4FE10E4C9;
	Mon, 18 Aug 2025 20:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="evST/wcd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B62610E4C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNMTLrZ07NFDWeLhKibfVHFl68bHyw9URn8dwgUfUnm6HuQ1lDDx1OJjlcyaHQHDhSjavnZ3ukCmMijVOt8tAZzWnoX84kTeaPd9085nak+MkfCKmvWQb3qDItwKr1HMpLjwTKcUqReJ1ETOQR/E3A90vEIMF9MfPBTjjjoFZp92FtNdrp4qWkV/uvUnUgZJ26AMEy43qA1M+sSsChQ21UDmISkn7E7seDKf8UDY988CtvS9G5gzBCxskhTQVdwp1PI73RISbNOzPn3Qbs8fTzT0qNmNWJqY3z2rXv1ew82mEhIFaSGhZkUimz9262a87yE7mBvcO9DgtSQjH6ZaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwhcrgHECRKomSH3eKafwm9GTD+cdscSx27YxfkhBX4=;
 b=X5OHaGRfTV+K60hruzAbpfoHrXlDPT/To9WubV3ZIOKWWgn8CJzt9Oz8u8ySrz29Ou2EqmHYEGY5kQ0lsMz9EiPyJpBbanQX5uH5uNIeW+s7vzoxuQOH652zrsUqZMlw9F4HN0bm7FgbSRVnCw/AI2KR+djiuxhgSPkS1sMkPeKhErXU8sQAxYdA7l0Z4N9CGfNIrDqYQsnxHnYDmnsuYA5JOmfneijflwW2hFzJVaM9kL4AQPgI+7C4E1wOqjOCLQQ55JvXdhFPAJZ3ad34+l9Jlu7+d5jR4EqCb29f96WWCe5tV0egue9lmqcoLd/H1ptChMfg62yqIaWOSbhYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwhcrgHECRKomSH3eKafwm9GTD+cdscSx27YxfkhBX4=;
 b=evST/wcdeUS4n60pUezwh8tjksAX+Rrck8VJ92Z9d14fZEy2yN1bKL6hqXlhXodp7sWhGOnSpV0159MHNoaW52Qein3UgRmMukjTt8aHSGvnRrNG+uWZWE7xru7Hsl5R/K2XSLI97wbzxBPeNiv/H9pr4FWBidSrAuWyVz4NZoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:11:49 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 20:11:49 +0000
Message-ID: <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
Date: Mon, 18 Aug 2025 14:11:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250802160602.12698-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0a4cd8-d423-43b5-f648-08ddde9376f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW5MSnJaeGNLN2EvampvbGJ1emFzZk5KRm9JT2VyUXUzdFFEbW5VYTFyVEhH?=
 =?utf-8?B?b3EyN3phOTUzYXZFMTRUNFJkTXNFNjY3QTlXbVBhQSs4WWtveVFSVktlUEFS?=
 =?utf-8?B?cUhlTUM5L0hVR2tCZjNrbUlnMEVZeU9jMitnemVoZTNSWmlGNTI1ek1GSXFs?=
 =?utf-8?B?cDFSOVZMQ3BGcWdOZmJpRW5CQm9wRkxyZlR1bUg1UTM0c1NyVmpyTVBINkln?=
 =?utf-8?B?RUJ5TmNLd3k1L05UR3lFWDBNWWM4eFhUTnhvOC8zT09BZ1BYblZjREdyM2Q5?=
 =?utf-8?B?cnpvYS92VHB4MkVTRzNxTWdSanBjVVhTVmVsVWY3anlZdW9CT3hyK082dXFY?=
 =?utf-8?B?eXB4dTN6WERqTmZ4RTdIa2ZTeFhZa3EvUk5mOWh4c1VGTitKbjhLQjVyZnZk?=
 =?utf-8?B?V0QzTkNVc2tpa0lNK3NaZFN3ajY1bDZkd0ZDR0pHNEJDdFNuTm41SXB0bHdU?=
 =?utf-8?B?eUVRVkVUUVZncUpMM2wvR3hmb2hHaFZ6VTM0QmNDZWZZb3FLUGU4b2o0SWxS?=
 =?utf-8?B?R28zcCtKVVZsSWxselBLMVF5T3pISUlBUmdmRlptOHVWUHpkTXE0b0p0NHp1?=
 =?utf-8?B?eVh3T2I0ZngvMmNJU0Yrakp5TEd2ZE1mSHJQaUUycDlSSkZlSzRlRzcraEVy?=
 =?utf-8?B?OXZQZUJ2N3FDNmt1ek9MTmo3ZDVoY0JxT1FMUU5jTi9WRFBMdW9VWXM2ekdN?=
 =?utf-8?B?czVtbEUzSHAxdmg5MmV5YmRIaGFmZGxJWVBEcGRrU0xEN0YzYzJFN3NqY1FH?=
 =?utf-8?B?QnJYV2YrQ1V4V0hjaE11M0xnYTBMNFhYcEhpeGhwcitYd053YnhlUUYyK0Ur?=
 =?utf-8?B?bytNejNRcEtrMElFVmFtZjlOUVd4dUhEb1FKd0V3SFQ4UUNQUEU3K0pFR01R?=
 =?utf-8?B?QkIzMXQxY01mMS9FV0F5Qm9RQjlEbGNjSjRGWmpvcmpiRk5nWGhRdDNReGFn?=
 =?utf-8?B?KzJWMzljUE1FT0VrTy9yUzV6Nm8vU3pOaUFHU01hNXRsYXhndm1KRGZEZnN6?=
 =?utf-8?B?ZmtTcW5henBzL2ltYkd1M3hsak1lc29sNkdQd0N3OTZoTVB2alErOXFpa1Q2?=
 =?utf-8?B?dnZwc2JJR2tmMkt1a2lVeEVzZWZLcE83UDVJK0lyYkYvd2h4R0RwMi9hWHpR?=
 =?utf-8?B?cmJ0b2I3SWhCSG10UHhySUZ4WEk1T0g3dGlzZWZTM3MwaXlmVFZnLzd1K29y?=
 =?utf-8?B?N0NPV0w1ZlZvTjRFMDJZUG03alpCQlpyVXF5VGhWVGY2elBTb1REa1NiNlUy?=
 =?utf-8?B?SXExd2hjYndUU3dhZlJEK0JqMWlNaDZmamN3SDlmM2dWdXo4b1ZVamk4alJF?=
 =?utf-8?B?ZjJ2WmVJNm5xd3hKa2hiZ0hGL21WNm01cFQ1aU5XMjFPeEtzSXZneGVpbXVz?=
 =?utf-8?B?ekdObUNjZEpKcnk5SmRHdFoyRzEwWHlmSUU1Rkt2T0VSOHZmY2theGh5eTYw?=
 =?utf-8?B?eVJBTko1NUFCb0lHOVJHalRZZFVhYm0vSk56MjlzUjN0YzZQMkZ3aFlBaVpJ?=
 =?utf-8?B?WmFVRWdkdHB3b21NeUtrdTRTY1RmWWN6eGtsZ1FWaGFzZU05SExyL1AwMlc2?=
 =?utf-8?B?Zk1MWHdkNDBTdStlVkJTc1BCWk1sc05oeCt2MlFmVE5uK3FHK1hGdmdxQS9h?=
 =?utf-8?B?MU5tQ1VkVnNGdUpHNyt6WmNxNGNwRUJLRWg1VXluYzU3YXJza1hibHdlZTA4?=
 =?utf-8?B?MERXQWxTS3l2K0s1OWxQVEZUekUwMnNTaU90WVVMSGRqS0dYVUxxbTBjVnBB?=
 =?utf-8?B?NTlVR1lqc1B1RldmY2xXR2xLbFdwUzdUWUtvcUVTK3k2U2ZQaXBrWk5jeXRz?=
 =?utf-8?B?ZmZnZWdzeTZEU0tKa1NLVW5ta1d4T2JqTmJ2bUFVRG1zSWtITGR0bS9HM1Vl?=
 =?utf-8?B?bkhCd25XOXJ0Vy9SWGRVUDFiQm5wMFlQSHRoY1NSRDRTVEROdU4yWmh0WlFa?=
 =?utf-8?Q?2Rb+N/4ODoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk80ZG5kZE9MYUlvRitUcE5PajcxOVlMbE5LMDd2NWxTKzB1ZHFiTjVYMGJD?=
 =?utf-8?B?VHlMNlV2N0JuTFR1S2RaTmcrdENMa3NRb0k2OXdQSG1LL0I3b0RXckVXaWhs?=
 =?utf-8?B?SElvZzJ5anJneGxOWjVjVlNRQVpkZE5OOWRibVBWbnN2WjJxYWJkOFpaS2Nz?=
 =?utf-8?B?TEgxRUptcXlqWjBUUVdWMWo5QS84dnBuL2dNRFlLWVRoOGMxbUhMcVdUOUdu?=
 =?utf-8?B?d2xwSERoSXpDT0lHNkhnTGc2WDR6eG04MFkwbEV2MnpBNi8yL3lGb2VuVnBn?=
 =?utf-8?B?OEZnN2hPLzlqdG5oN2tuZzB6dmRZaVZJVy9xeWZ1NHhPemQxem0yeWs4aElo?=
 =?utf-8?B?VUhUay9ONW1JMTZLN2Myc3FCTnBOdUMwS2N3L1BZOTdKK09Fd3RrQVE5SHAz?=
 =?utf-8?B?RWxzK1VwZnZpRTh6SkQzVWFsZ1RWRzJUTnRvRlF1U0xmdS9VbzZaRGdrTmxp?=
 =?utf-8?B?eWZ2VmZ1K2ZldEx3MitOakU5RFB2WWhwU3lwR1VuNnJueDU0V0xVNHg2YWVT?=
 =?utf-8?B?cGovdDhWa2E3cjc0U1ovSHJTNlFXaDg1SS9XREhOa2xCcERRZUFHTGtvRWFp?=
 =?utf-8?B?UVMvUFR2a0kzUWEzNWEwUjdCZG9ZcUJJdjNRY2Q4b1h5M0U3cXZIMVE1MG1Z?=
 =?utf-8?B?NFh4SUpPd2krUmE1V2NSdlBiaWFpOHpkZFYwdFdtekc2RDBFeGVsSFR3ZEJj?=
 =?utf-8?B?NUVySGo5RnVHSHBiaVhxTVpnRmJPRkFBVlhjUVpsOGlXNGtrNVp5Z01HSjlk?=
 =?utf-8?B?L0R1N2pTa2c2Z0NpbTYwOE9Ub1FSQS9SRkdKMWhlbGxKaG1LenVyZVIrRmx2?=
 =?utf-8?B?NG9YWjdQTEZtUEV6VmdsMllSbGw3RTYxSW1PaTdId0ovUEg5YnRydDcyRE5C?=
 =?utf-8?B?cDk5bi81UlpGV1JrYXAyY3BOQUVzYmxVd1A5YW9FK3hrd2RORjU3dWljRHZO?=
 =?utf-8?B?R2cvckIvQ1M2OUl1dFBhSHYzcEhOc3hUUlQrSTFqMTd6U0NDQU42bjAvWCtz?=
 =?utf-8?B?YjlHTzBIenZwd0plYVBIRVpTNEFMaFdhZ283Uk11ZGdkNkxqS0tnYTFISUNI?=
 =?utf-8?B?ZXdJUFNjM0VORll0YjFzekxIL05DblhYNGJZOXNULzJNZzRjcWdQUWw4cFlD?=
 =?utf-8?B?bUxKWkVsVHhWaDZ4SXRhaStHSGRZcEcvK1FPSTVJYmlJdTA5VTRFd0drUVNa?=
 =?utf-8?B?OGtsMUNWY0p4OWFjWDdBOTJ0SmRQd1pZZmJzazNnOUpMWGJ4MjFaR0hVRXV5?=
 =?utf-8?B?YTBTeElPTjdhYjhvdUd3d1Ewdy93YkZNMXhSQzBqWXhBa25PdWs4N1JUWHdu?=
 =?utf-8?B?dXp1TmxzWm9CTXJvWGk4bXFaVWVzL3FTYzNubXQrL3ZBOVN2aTNuQXFQZ0V1?=
 =?utf-8?B?blZUelE3ajN5TmlQTjVNTlRxTkkxWGZlRlBRRXZ6d1hRT1FwbjYvaVpxMnBK?=
 =?utf-8?B?MzlYbHQzL3JVc0s1MGlQcFNscU5yekpnUER2Q1h0YktvblVDeFp2d3dLdko2?=
 =?utf-8?B?ejZWUU5GMXlBeTVyRG9GenJFZklsTmE2UXdGNmlSUGJ4SU9pZFlxZ1JXejY2?=
 =?utf-8?B?WFRNQy9FTGdhY2xaODF1SzYyb3hiRkFQTHBrNEpYNS9JU3FxMzRiTCtMWGU2?=
 =?utf-8?B?SzhmYXlPcjNSZzYrVVNTSUJHZVA2OEJsY2E0ZkxUR1g1M0pYRGtkUEpnN29U?=
 =?utf-8?B?SXpZUWZ4a3VDZnpaWEtoNHN5N0ZidFZqUU1jcnBEbExSQjRSMEcxd3JIRmZn?=
 =?utf-8?B?Tjdhc2hKNk5OZEVnZ2hkeE9vTzVXNlc1Z1ZlUkJXQkxOaUlhZXBPT1lmb2t5?=
 =?utf-8?B?bGJvamhrdTJ0d3RHQ2FiUitvVDAyMFJFeklyT3lnZGkrSXJLU0paSDFla3BD?=
 =?utf-8?B?QXd4eXgzeHVDM3UwUUltZHFiWFVxT0JMdmRvZ3lRdEx1dDVDNllQaUxqRFhI?=
 =?utf-8?B?dXEveVFGTDd6MVFlVGZ3OGNrV0ZOOE1peWRtRHZvcHNUd0lXTkRBSnJ2Ukhv?=
 =?utf-8?B?d3h0ejB2enZWMHZFVFFDalB4Vm9CUXlZbXpSbmVZNlRRY0taYkpnUkx1Z3pI?=
 =?utf-8?B?ZUZQWUxvSEloa244SC9Ub3V5ZnBRbmQwTDk5K2FFY2VFTFhWdmQ4NXpXWEYr?=
 =?utf-8?Q?4v2U635PR+n01Ag/QI2v8hjjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0a4cd8-d423-43b5-f648-08ddde9376f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:11:49.6344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tU5N49aMpMs+0LMPLozDyj7YXYJj4ZB87vtsRltRMMknRIROKi8NqI2v7fP0D2vOj5tB7XVOR25OGCTRm9wXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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



On 8/2/25 10:06, Timur Kristóf wrote:
> The VUPDATE interrupt isn't registered on DCE 6, so don't try
> to use that.
> 
> This fixes a page flip timeout after sleep/resume on DCE 6.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++-------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
>   2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 470f831a17f7..e8d2ba58cbfa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>   				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
>   					 enable ? "enable" : "disable");
>   
> -			if (enable) {
> -				if (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
> -					rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
> -			} else
> -				rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
> -
> -			if (rc)
> -				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
> +			if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
> +				if (enable) {
> +					if (amdgpu_dm_crtc_vrr_active(
> +							to_dm_crtc_state(acrtc->base.state)))
> +						rc = amdgpu_dm_crtc_set_vupdate_irq(
> +							&acrtc->base, true);
> +				} else
> +					rc = amdgpu_dm_crtc_set_vupdate_irq(
> +							&acrtc->base, false);
> +
> +				if (rc)
> +					drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
> +						enable ? "en" : "dis");
> +			}

Hi Timur,

There seem to be conflicts to amd-staging-drm-next. Could you please 
rebase and resend? This helps make sure new change fix the problem you 
observed.

Really appreciate it. Thanks.

>   
>   			irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
>   			/* During gpu-reset we disable and then enable vblank irq, so
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 2551823382f8..f2208e4224f9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>   
>   	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
>   
> -	if (enable) {
> -		/* vblank irq on -> Only need vupdate irq in vrr mode */
> -		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> -			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
> -	} else {
> -		/* vblank irq off -> vupdate irq off */
> -		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> +	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> +		if (enable) {
> +			/* vblank irq on -> Only need vupdate irq in vrr mode */
> +			if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> +				rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
> +		} else {
> +			/* vblank irq off -> vupdate irq off */
> +			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> +		}
>   	}
>   
>   	if (rc)

