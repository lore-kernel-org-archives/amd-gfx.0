Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C92C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 07:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA1610E2EB;
	Mon,  3 Jun 2024 07:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1CjzCry";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3D610E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 07:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C23EyxrUrlQy4kVdy24fiegw0JMwF3MiSFr6nSIfHt4bOU2GTwEusq1Pe5XYdWTpgmTnsrdgSF5MTMokQEk8b4VaZR8C9/UNxhPuZooKtqRPC+O42foRQaIGRpWQE9w71gGeY3ZJ116ZMLRMKzApwxRcRzffs+NUMqXlMkoK+VAB+6zjzI8BUFfM/1a35MakeU2DeZN/QTOa3bElbmf+xerJ7UkGAHYVlSH+fXz8zQ9J6NMQ03DogZqm3+U8Is8E9zm03Zl8x79MvDLzU28BCUy7zhRevl+p9PktbhnDhD6FUTn6pjYqMPumNntyUXdqlKrsZuQj7qVB8SSZJtLzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w1eTDyz9K5sm4jfbPId0Upn3MuBzh1xa5uGDhXStfo=;
 b=gh5pM0igps97Ms53BtMxTuJ127qK/kv9Ucd5ygKTJBuDeOu4QKH1peutwbs1KyOQiJWvrunElI3d9MMqqp4Xv5iEXWlrygwkk9djtFOrmYUEgT9Ix6tzDCrY2y75tUxEQ6058UbxE6hS9m9Zh3DvngXv+8KCyoE7dX+EeXesv5+cs8G1EFZ+P/f1VDf6RJRNDveCyR4Rw6Y/h+A8sos6DX3xb7ywSeA9E8PC7cWSO+PjX1Q1ZxyXf+EiPoLmWQG1JLGz+zbMNvL8NzQ0cyNdTgivmdP6VigWpINuqa/8pPFwWirVtGk9MKprtU+xzT5nkWodACQqNMmBDVih7LOVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w1eTDyz9K5sm4jfbPId0Upn3MuBzh1xa5uGDhXStfo=;
 b=V1CjzCryLqGUiiPf6e+/FPZ1xek6H/8SNtHxcUgIii+TznihegoDywHIsZZfMUa5bSVtfMiGNZjrWl2Jd5pYYsU5WrgEMXrgYfe/aRZtpLmGtwdGSfJ0CWo2IGIddyCGO5Z+LDBFpeymHSCfDCapBYEsoNqQfXdwvk+U7oDzS40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 07:56:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 07:56:33 +0000
Message-ID: <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
Date: Mon, 3 Jun 2024 09:56:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, jesse.zhang@amd.com
Cc: alexander.deucher@amd.com
References: <20240603055925.353172-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240603055925.353172-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bcd9b4-ef61-4166-6c84-08dc83a2af68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFFsWjVGRm9VQ2ZJRVVWc2tKZUxMdWRXNUJFUkhxb3BMQTBQd2tGVi9NeEE1?=
 =?utf-8?B?ekU1Z0FBRHJ5bWQ2R2FGNkFmcUhkVWt6RkRmR2RKUzVtTVN5d2NNdDF5YmFa?=
 =?utf-8?B?MFIyZTlqcStmc3M2empTYVM1Z3cyZEd2NXh6eDc2NHVSSURQVTRMMWh4L05O?=
 =?utf-8?B?Ym1nRyt0QmNYQXRhNGphN0RmZUZ4ZFRXVG4xUDlaR3U5b3I5OEF2Ry9tVk4w?=
 =?utf-8?B?eEU4cFRURFVaUUVOUlFYY1E0UEhPREwyTlIrNWIvMDI5TTgwQ0F4OTV0MlVH?=
 =?utf-8?B?dDBMUDdSZ1A4QzIxZG8yS09wQmhwZ00zcDdWeTBSNU5za1FtS3FCazhaZCtS?=
 =?utf-8?B?QWNnUkN5L2xSQ2ZkM05uZmc2UkxaaGhoSG9veTVEUDVpVGFJMXlBaGtRamhO?=
 =?utf-8?B?ckdvNDdVc2hNV1NkanNFQlI3MG1YOUIvNnI1bGNoSTJHck1yaFFaY3BSM1NR?=
 =?utf-8?B?NzUvQVdQVWMyS2NPRStRdzd6b0VmL1llL0txNk1XYTMvY0pJciszOXhZSG5v?=
 =?utf-8?B?b255RTRhdS9KQ3JyQzkya2l1RFo3MXI0cE05ZSt1cVVhVmZRdkU3QmVWWksv?=
 =?utf-8?B?QzI4Q2FsV1RDUFp5WWdITnd5bEQ0ajJacWZqMGIybzRkekxQM3h5aVBPUG5K?=
 =?utf-8?B?WGYxSFVYbkdaUjJ4dUMrc0l0WDZ2THhvYlJxL3NqUGVDcUJGYm5ubW9OY0tX?=
 =?utf-8?B?T012MklwYTZsOUk2VlVRNURweGprWHZTd1U0TkNVZHBuMURVc0FueWY4SU9K?=
 =?utf-8?B?b0RBY0xmdG01Y1hPeFBmR1dUQWx5Z0c4UTJPRW12WENRNWs1MTkweGJRZXdN?=
 =?utf-8?B?VThsb0lnSU5qTkcwTWlnUHgyanZRaUZmQlNqNUNkL1hRQUx2Qk5WKzBXREZN?=
 =?utf-8?B?UXVUL0xGbzVscnQ3NlI4NHpaSXg1VFhwNlA0K2ZoSm9CWnBsY0tsVUxhMklS?=
 =?utf-8?B?elRQNUZEeFc5SFBsRkpWUjk1Mmsxd0phdFducmpLVnpoOEE3bXIydldvR29X?=
 =?utf-8?B?OWs3Q3dKZ3dYd1BEcXR3UXBOUHh1VXJEcDJnd0EvamVkYTZYOUI0SVpxNnNl?=
 =?utf-8?B?SUhnR2N0SzNrRzJSOXR4T1ArdERkcVNCR1g3NFZhRE5uYlFVRjhMQWptemZv?=
 =?utf-8?B?WFBXUWpDYllidnBXMWlLV3ZhbUR3OHVncU95bVc0QWs0aXFhOGIvUzE0UWx1?=
 =?utf-8?B?UHBUNGZMdm4vNm9UcUJUZTBhWGRCL3ZZbDQ0d2FYdGVTREtlMGtHTzQzKzh0?=
 =?utf-8?B?Z3lIWGsxcVhyVGcrTy8rVWd1TVFBYW5RMUJpcFNyY1RFY0MrYjVmcHl5NzU1?=
 =?utf-8?B?QmZlem90SVhmaEFUdDRNTi95NUpXL0dCdlNKdGFsMXBrZjZXZXpTUnJPeXJF?=
 =?utf-8?B?YThiNUc5dlZOMmdnMEs1MmQ3ZEI5enc0UkZydVZkVjdsSFpJeG1YdnRNcnQv?=
 =?utf-8?B?elNkMEQxSUJIa0RjalMxYWw2OWlIbWxneXBoU1AxOS8zQ1I1WGZVbjBrR2k3?=
 =?utf-8?B?bnlmS2NiN1JnQ0psN0tiTnhKYzhMU3R1MWRBdUx6bHl4TkdGVmQvZmFESm15?=
 =?utf-8?B?QlEyeWlKa3I3S3dVdDBQSXhhc1A1aXpBajZ4YUtGcWE3VUVKNjQyM1BDd0dP?=
 =?utf-8?B?K3BYR0lGbG11dVJJdWxTUDU5YWlwUGkwWnZPZTh2S3c2bytBVkN2TUoxaFpk?=
 =?utf-8?B?WW1FVUU2YTRLd1lDWmtFbTFTa25vd1k4aVhZWEVnK05oQ2FUSnBNcnNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy96aVBjRFFpQ1FhSjYrMi82dW5yTkRIbXhJU201eDQ5Q0VYSzFqNnQ0SUQz?=
 =?utf-8?B?NmlEaXp6L1AvR2tpclM1TnB6cVhNdllqT2xJUlpyU0VhR1F6bTYwYW9oRlZo?=
 =?utf-8?B?c3kxSkVUZTN3bHBRM1BsNUczZytOakVZUlhyOGhPa3RxcGd3VUxROGJLQkF4?=
 =?utf-8?B?VFZ2YmxJS014L0xCeWUwM2VUdzhadFJRQnZVbDlIOUpHc3N3T1J5TUlIL1Na?=
 =?utf-8?B?dW5BQmdzWWJ6SWhLTmhsKzJvV1hTOTNhQzJtUVg4NlJZdjZMQmkwOHUvVjhX?=
 =?utf-8?B?R2dqbk03RUxhaFI4OFdvOE1aZ3phUEhnck1DM2ZPTmhGOE5PVjAzbnM5ZFNx?=
 =?utf-8?B?UVRNcEFteW5PR3BwK2crWDdpak01bzZpY1hva3V5bmVuNU9oMkU4ODlBbUt6?=
 =?utf-8?B?Y2duZVJ2SHFOWlNmaklDZTNjVExYVEowUy93K3lNNitielQ1ZVpSTDBXeFdN?=
 =?utf-8?B?WExjM0VqL2c2dlVOeGpQcStNai9MSVM4VGFtRmxaYTl5RUMrVm5JNGVxMmRI?=
 =?utf-8?B?c2E5S3p4OVY2UU8yNXJ0Wk1ZcFdvY0RQOFIzT3FIbXBINnlycm5nditpZmR4?=
 =?utf-8?B?c20zZVZKNE84YzU4Qyt6NUxScUhhWEVZQ0owSHJiUkZhbWkyY1hzVXdnUmxY?=
 =?utf-8?B?QitSN1RIWHFkTG5WdWpYNTlsUjlYWkI3WVB2T1pFY0U0dmtiMUFIN3M2eEpz?=
 =?utf-8?B?c1I2NGlTdGtlY0NrejhNbWZUSVFyclprZHRpbUwxc0MzQ0czT0NvVks5eGtq?=
 =?utf-8?B?eWI4cGJQZWZPbkpITFNoVDJQWC9tTTh3QjVLQnl6WXUyV3AwaldoNU5PVXBm?=
 =?utf-8?B?MGJHSHJTMmJjRC9wTzBBOXNnTTJlbFd0M0RVZzRxeU9sZWpqL1FNODMrMWEy?=
 =?utf-8?B?MHRGVUJ0VnMyRGNMdks0b3NZeDJ5Mml1OHprd05zM0hESk5zUTdUSDRvM1l1?=
 =?utf-8?B?aDh4YWptMTYrd0UvbUhuTDBJWHB3eGYwOWV0MHBLdFlFMXF1NU9rVmVHbDZU?=
 =?utf-8?B?LzcxZWUrc2kzL2VhWWFSUEtnT0wzWUpxYktIM1AwUy9TTS9HZGZiOCtmazEx?=
 =?utf-8?B?b2Mwd1hhaEc0NytkVlZGb0lrN3Y5M1dhUW9FeEtURG5UQ3NBdWNHNmdyWkRq?=
 =?utf-8?B?L2dBR2lUVThHTVc2dzdxYXZaUWtvS3owY3E4MVBSbGd4ZHd2WXRKY2UrcDZz?=
 =?utf-8?B?Vkw2a1BtM0VuTzJTOW5jV05TSGo1U0pjRDVZbEdaY2pGTUxNZk9GMWY5eWE5?=
 =?utf-8?B?MWEva2hYdzd3Mzhkb2lyeXNmR0duUWVtRThOeWd6OEdieHBmSjRrY2x2ZktI?=
 =?utf-8?B?Mm10WGlTVnpwR2tTRWdxd0tLYUdDSlkxZXpVSXVOQkVaYmNENFlXbno1dE0z?=
 =?utf-8?B?alFOTnNEZktYeTlheVkzbEsvTWtKNi9oOWh5dlUzWXFhbnk2dkVINFJyU1lY?=
 =?utf-8?B?VWNLbnZGNHNMTGF1ZkdTdERuYjJxWXhzbmhNRXd3SkJ0eFRYY3lUeXRNTm1X?=
 =?utf-8?B?MC85MEVTREV1c211WG5hRDlKblExV1lyN3Jta09XK0dUSFZFZXlRNHYvVGds?=
 =?utf-8?B?L0pKbEtiTWQ4RHJwYVJWMXp4NVgxZWhIYUlJY01qaGhnZFpuNU9lYnZ6aXV2?=
 =?utf-8?B?cXJxZEJnbXlzWW9iM2FZenJ0aUZRUWlCdHE2emRjcGFiMnM4a2xQdG9Db0Vy?=
 =?utf-8?B?ZVVXZzFRb2NvelpGWGlmSXNEWEkrckMwbFlUQ1FhN1kvUVVhL1NiR2crL2Vs?=
 =?utf-8?B?K1pxcDJDVzdWYk5mODFrUFUzUVFwRDBxQXpPbnZPS3gvTDR6YnlhdEdCa0Fl?=
 =?utf-8?B?T2R0bnZKai96TVNqVmJGYXBjTTlKbTFYUW10NXpoUUJBZFc0K2lCM1N4TjMv?=
 =?utf-8?B?UStnMTMxTXRxNk5yc3U2Z25DaU9Nek55elFUU0M1aXRBMnA4NlV6SG1xeSt3?=
 =?utf-8?B?NUtPT2JTeE9wS2F0d2k0T08zUzZ3VHV6U1NneVdla296V2RBcFRDbFJZVllj?=
 =?utf-8?B?SU4rUnVKUHpPUHpnTEJjSGFCQmRFZmRqTDdaZjJoVHBUMUFyNm90YnRyVEJQ?=
 =?utf-8?B?U09DUEhKdjFJcHJoQ2RXWW13ejBodXFpTkNDMzBKbStTR2lTOGRwZXZxOHZO?=
 =?utf-8?Q?VWIkHZmCHos1U0PQW2s9DHAvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bcd9b4-ef61-4166-6c84-08dc83a2af68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:56:33.4543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE4UUBhdyv2imDDOSIx8gPuzAMUszvRUxqFOuR4JLMgjkwYBD57wgOxF9c7wA9WS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

Am 03.06.24 um 07:59 schrieb Bob Zhou:
> The return value of RREG32_SOC15 is unsigned int, so modify variable to unsigned.

And why is that an improvement?

Regards,
Christian.

>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> index 0c8ef908d112..2d6f7549c2af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> @@ -119,7 +119,7 @@ static int imu_v12_0_load_microcode(struct amdgpu_device *adev)
>   
>   static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
>   {
> -	int i, imu_reg_val = 0;
> +	unsigned int i, imu_reg_val = 0;
>   
>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
> @@ -138,7 +138,7 @@ static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
>   
>   static void imu_v12_0_setup(struct amdgpu_device *adev)
>   {
> -	int imu_reg_val;
> +	unsigned int imu_reg_val;
>   
>   	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
>   	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
> @@ -157,7 +157,7 @@ static void imu_v12_0_setup(struct amdgpu_device *adev)
>   
>   static int imu_v12_0_start(struct amdgpu_device *adev)
>   {
> -	int imu_reg_val;
> +	unsigned int imu_reg_val;
>   
>   	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
>   	imu_reg_val &= 0xfffffffe;

