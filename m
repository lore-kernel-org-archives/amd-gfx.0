Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9B0C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 07:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF19510E414;
	Wed, 30 Jul 2025 07:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4xef0aW0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA4610E414
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 07:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7xVLR5dLv4HS21SkZrqItY9QuJ3+LqDScI4+Oi0bmOeAnTw+YN/B5cZyv42bGckvY7cuU6RBkuV0pnU/0AOe/VNwIdR/b39JuW/dPZuikZhb6yqASOFhVFbC5wWYQTo66gewunx7nf9RuqOKITOuTbdxXsnte4jMzHEL0S6DieWBB97xrfGIdQy7mI3tZpGViD7SZSPyDU//XS2iIJou4/dy5VaMjfwpJ5VzOweDVGr2Vqq983vgUNEiPTwGFxDkVLM8ubcMqB/wXDNgvBzEMydAnnTO0ILlSGnd2PKPVvYyuKZOCyc91wuG50zdPSOpOxTSpj9M+DqFrvXN3zk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UohfdKng2mpirOXASJaKwtLNJ0RMFPJPoRi1QVR2uRE=;
 b=QEqs275FA3gcvVQTrpdJAD3RnhbLXMRhsiP4Op/HIWnqcQWI/AUFqWxcg8vRIm17q112pGBnte1zqBH1hUcVxJgxh5862Z2AABxYe2pRIGFBF5IrI3oZ63cz7pAlAtG6McEKaIHi/LN3ZQ8afjWeM7V/B3zsogbVIgQDV/gCUuMNxc5o29Cl+OaYbebzbB5idx4xynLvokr/9I05cthD+Co7J/a1KbIvA6Rw+GgKFXaRFP5IjEwtr24cdzYlqe4VtEVjhnfTZ3snGSW9OJIS2m7uQF0jm5G4Di6x9JOkwgagq76umEf2mfRh4Op8zG8cJbPhO9UEIhZtBTJ7HbtteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UohfdKng2mpirOXASJaKwtLNJ0RMFPJPoRi1QVR2uRE=;
 b=4xef0aW0O5GGsfyL06yJ+F+lDWPG/fdTX5Rti0BuJLGwAONMkQFzPI3J2Rb+TWHyTZgXoQijw7ZDwaAtqIrulRGZ3l4d8xzFMvmDF2O9OgKtcut2T59sXJuELF2TbA92dXr8dUrnwlKUrOvq+g6TqK1NP0pKKWC9h/HoAbgJWG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 07:36:16 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8964.023; Wed, 30 Jul 2025
 07:36:10 +0000
Message-ID: <887f1792-1d76-454c-b8a4-4fdb0de2c9a4@amd.com>
Date: Wed, 30 Jul 2025 13:06:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Effective health check before reset
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20250729070117.76523-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250729070117.76523-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::7) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 506fbaf0-7c2d-4193-6e91-08ddcf3bc07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0lWbEI5RG9lYW1CWXlvbkVmMkNZNzFwdXp0dWFvdG4zNGJmZ2hBMzV2WXZH?=
 =?utf-8?B?SGlYU21MK1FLMjZ6d0tya1oyOElKY3BRWGk3VHQyUiswUDlZUngyeDVjZW1B?=
 =?utf-8?B?WUQyekxreTRIYTF3U2c5RWFET1BLQ2N2N1l4RnZoZUk2bXUxaW9HR0dYb01i?=
 =?utf-8?B?VTEzUHpDRkdpcVpXdEJHakRudkszRDRLUGR6YkV2eWxGejIxelVZUFl3SkJz?=
 =?utf-8?B?Zlh2WitLd2o2QnYrWTVwM0FBNVFVTU83Q2w2SUdUZ1cyZE5kU2FEeENMWkN3?=
 =?utf-8?B?ei95UGdIMWwxbWhKK2NxeVVRZkFUYmZzRFZnRUhuQnErR2xYaFBFSXVFK3pZ?=
 =?utf-8?B?NmF6UHk0ZXdMSDB3aDZSZkZZdUYvaTA4NTd2VDBQVUN5WmxsZ2hwTmVIQkZj?=
 =?utf-8?B?b0czejB2TU10RURNdDNwZElvOWhqYnl6VWdQQ1ZHN3R5TjVPNTNXbGN3MUdy?=
 =?utf-8?B?YWpGSm5pakwzYmpEbDFJMU9lZjBRb2w2VjJqRkxZQWo2ZHFKOGxSU05LZHFS?=
 =?utf-8?B?ZkQwN0w2Y21DR3czdk5RUVNnRGhCZFhMMTNlem9MaS9qcVBUN3huajJPbmhm?=
 =?utf-8?B?dVRCMFhMWXYyWDhjN08yTVl0MlhzNzBSQTQ2TzR4VHVSc3FSL1AyNTJwNStm?=
 =?utf-8?B?QS9IYzB6WE5oQk1NeUprYTAvUVN5ZGRtUFBZS0xXd0NycXdVWGFWMVozeDdL?=
 =?utf-8?B?dGh3a29QNitiYUxvOVc1T1dDVGdTMTVKSVV1SjBmQWlGVXBGcVcxb3dsdFY1?=
 =?utf-8?B?eGNrQVpta2JjMnRBOU5ROVllNytCckRHUGI5TDlBYUJDcEpUbUpoUlAyYTRt?=
 =?utf-8?B?am9HcSt3TmwxclhGTmJtZXN1ODg5Vjdhd0s3eHNOZkVXZklZYnU1eTArazBl?=
 =?utf-8?B?cnlEMkFlWWJ3NExuTU1TVmRpWThPWkEwZG1zaDdCdHcwdGxuMDNNdWFOV3lC?=
 =?utf-8?B?V0ZjYndwNHExaitDZEZlQ3MxTldRbVJjMnJzK212OVFZSjg0V1cvS0JUSENB?=
 =?utf-8?B?azM3cU9sbE5QKzBGN0tDT3pyMWRFMXF2bFZBTnNZWDJPK1daWDNXYzdwNlVi?=
 =?utf-8?B?NTMrZDhlcVlYSEFXVHo4d21WWlJ5YTFhb1JoelVaYktkZU9xNkNyeWZzMXdX?=
 =?utf-8?B?TnNQeEVPQzYvUHFSYnRDblRQWklHQUZSUjFUM2NBTWhrdGk4MTJkcUlQNWYx?=
 =?utf-8?B?TW1GK3BDd2RnQWk1RXRCbFhiT3JMSU9TWG1ka1VBd1NPc28ySlM0UFVsdlhP?=
 =?utf-8?B?RmVhNllFWFRDVjNnZkFXcjlnNS84R1lWV3FzRFFUYnlEZlZoNEpuWnM0SVhu?=
 =?utf-8?B?MUhoMXh5anphUWl5bGFNZmtyK2NVSjd2Uk9YMXlRdGZxczFYQ1JsdG9oUnFr?=
 =?utf-8?B?SUFjRENKSmtYVTJpZXJjdHozUkp3L0kzdTljZkY3eGdZUUhaMWExdFRaci9O?=
 =?utf-8?B?bFlUL05OM2pSYUs3SEJsbHpYSGNFdUhlMEdwQU5hQmV5c1B2elVvZ1RJNkdR?=
 =?utf-8?B?ZERoUzJ4bi8zeFlEYVFUcjhQaDY3UnVwZXExNGRjZjRnand0ejBtbnpzdk83?=
 =?utf-8?B?QmI4K3J5eVJmN0ZDSFdzbjZacVBFdVJ0YUVmUmUreFFBNGNkWlpFdVVjbjhW?=
 =?utf-8?B?cGhVM3JDa0Y5bUpuQ2U3M3NJRk1GdlR5S1VFaHdaRTZtWGYrQnpRNmRsMWM2?=
 =?utf-8?B?cmtzTG5nVklUVWxtQ0FlZ3crZFp3RmhXSVEzUGxDY3dpL3UyMzVXRlFBOE1q?=
 =?utf-8?B?b2FDNXlCQWhoZ0REZ0dNVkUwVVBSdExvdU8xUmZmamlvMHJGM3pYK1ZQOFhX?=
 =?utf-8?B?QXE1K3JOdUNSZDZJWVdMdjgzWlNicXRpaTREZngwUzZoMnhjekxBQ1krQTZI?=
 =?utf-8?B?d3QwUzhhKzdoNldaMmlmYVJBcUc1bjBNOUhlZGJCUlZzYklWS2dYbThkbUxr?=
 =?utf-8?Q?samxaKex8Ac=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVc5YnFZVHA0THhWZjg0S2NuckkvTGlsRXFWdU5yczh3OWJCUDYwZm1qZGhv?=
 =?utf-8?B?a3h2a0o4NE10RWt3bUdrYVhEUitqaEI4K29tbU1aQm93bDVmNFAwaHlMYjVu?=
 =?utf-8?B?R0orMG96ME1BdURKV1llUloxdFRaK2dQaUVEVThXR0tINXNjQTRBb3c3akxn?=
 =?utf-8?B?cVlMVGNkUE1jSEdZV0ZiMWVCam96SzMzNHZEdUdTS09iTi95c2xkZnl3QVNT?=
 =?utf-8?B?MHRCcFE5cUVaT2dUckYwYUovdU4zdTRydTJwVWtRL0NSWDVsM1hORWlWYkVD?=
 =?utf-8?B?VGZSRmtVeUJ6R2xkQ2o4VVVjNzR5cG90ZkRnWEtHK2dUb0htWG9HaDAzeUFB?=
 =?utf-8?B?dVdFNUdLVWFZeDMwZ3FCaDFxazZZVmFkSFhtS3llbGZ4dlZ3UEdxWTVuL3B5?=
 =?utf-8?B?LzdURkMvNGFuTjBwWG9oZTdwajgvNW1JU0ZPMXVGZ0llcGNZY2dqbUw4bGo3?=
 =?utf-8?B?ZWN5aWluaHdoVDZDZlZuM0tLTkZFK0ZVRC80OVpMdG5xOU5PcTcxUk1tWjNM?=
 =?utf-8?B?TjJaN1o3RkVMZ2EwRUJvbmxNSzNDZ2JUak9QZWE0TVpBRXk0Q3YyNGMxc1Jk?=
 =?utf-8?B?V3hkT0o5VDZOcXRzQ2d2eGIvVVJ3SjIxeldyY09QS1B2T1NvdHJLQzRPMXlS?=
 =?utf-8?B?YktVd1ludnRybE92cUZKbUtvMlhrSjEvTnBtNHJ1YzhtTjNWT0cyL1VFa0px?=
 =?utf-8?B?eEhodnFlZ0xGSGRDWnpvd1AzQ1puVUlDOUk5UmZyemNlOUpCU01sRWlkZWVk?=
 =?utf-8?B?N0xTbEc3ekozQ1FYNmpZTDk2TVpvV1BtME9GcFNscHF6Y2lUUko0MnEva2t5?=
 =?utf-8?B?NFZIQWdkRGJUUUlvTXRxemhrWXQwQk5kQlpFdk5Ba1N3RUpYUjM0bE5sbTB5?=
 =?utf-8?B?b2F2MEtLYXRHcldjb0pUT25kZTN0RThKZmZtUFdyM0dNVmVWMFNCdURQVGNR?=
 =?utf-8?B?dExBNGM5NHk0Wml1dFVWaUxBVy8yeGFCMkxjRmZYOXN4SHRoTWNqYm9TeFJu?=
 =?utf-8?B?MWpRTUJxNERlUzU1MmJGeExiTUxYaFVqMERzZU0walFxV2hxTE1mc1VGc01Q?=
 =?utf-8?B?T21USFN1T2UxLzE4TUxENklpNWI1dTQ4MFY5U2tubDlGL1NxbVlOaUNsN2RR?=
 =?utf-8?B?Q29kNmt1elBEODZHVDdHVEtoYzdZZHhBaE0rRzJTK2Q3VW84WklKYVVBMG1H?=
 =?utf-8?B?STJTcDVlS1BZL3kyVFkvajNhU1pMYjE3b2ptbkhBM3drbEpQWTBZaFpTRDcw?=
 =?utf-8?B?ZmtRb2o5QWVROUc1cFZXc2haYU51akxRWVg5cGhBeUJNWGVlenpITXVoZUlr?=
 =?utf-8?B?dkF6SkY3Z2RuYU1FZkdzajdRMUJuQWRIbWxqOU1iYjBlNVpjL0FrOVMvWlJq?=
 =?utf-8?B?aEZLUklaVUhucDFLbU9PVVhVUkw3b1J1U05lUDJmR2E5T1RwVkxUZ1ptY0pB?=
 =?utf-8?B?eGtCS3dBZFkwWktKSDhVSFRBeWVwVFRCTlZxUHhBa0tkdENudGVTbGhaa2E4?=
 =?utf-8?B?K2VYck93MmFzbm9SS1BVS3ppVkt3M0VBQ3pIdkgrejBzbU1zZnJITzVhZXdl?=
 =?utf-8?B?QzZxdi9YUTRmZ0tydmkrd0hkRXFsVDVYZyt6YUJWVWRtdVJTMzIrK29RR2R2?=
 =?utf-8?B?cjZnNVNFTXhDNzZGaFpKWFY3RXI3TkMxRERIbGIvRmFyVWQyeG5WZHR4aDN6?=
 =?utf-8?B?ZGorVUlTZ2VwT040bXN0RWluVXB1UmpQTXBZME1jb1NGWjBqZU9zcWlmNFUw?=
 =?utf-8?B?VkthWXc2THJyemt1cDlaYUhWdXRoWVM1bmwwTjRXQmhxcWp0OHRtNEp1WUw0?=
 =?utf-8?B?NmNpMUtJTUxRTGFzVnVIZDNIb0lKNDZSU3RlV09aYnBRKzM5Yk5MTWFOdVYw?=
 =?utf-8?B?ZWpwZ0owM3lWcGdkUEFPc0hPWVhoM1p0WmxhbmtKclhHVTEyeTZ5MDhDZXJZ?=
 =?utf-8?B?ODVIR215WGpHQ3dnZm9GT3ZvdktDTnk3Q1krSFN6Z2IyTWE4QlBtNlhTcE5a?=
 =?utf-8?B?N2Iwc3FlTHZwcjhVY0wyRkx1R0lwb2tyL05HTzhRTlgyL2Nrb0tSQkVzSnNy?=
 =?utf-8?B?aHJZZEphaTg5U3BrbEdoajFxREFQM2k2eWljTFRTQ3YwTWJpTEMrZkp6VVhO?=
 =?utf-8?Q?6OKUL1giek8X6Lvor3IqxYxS4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506fbaf0-7c2d-4193-6e91-08ddcf3bc07b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 07:36:10.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9hp4RASCc1LXWVASgs+eFCBWS1iCKM+TCUHypfhGRiuNvfhOoJ3kME3zqzSK+gV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
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



On 7/29/2025 12:31 PM, Ce Sun wrote:
> Move amdgpu_device_health_check into amdgpu_device_gpu_recover to
> ensure that if the device is present can be checked before reset
> 
> The reason is:
> 1.During the dpc event, the device where the dpc event occurs is not
> present on the bus
> 2.When both dpc event and ATHUB event occur simultaneously,the dpc thread
> holds the reset domain lock when detecting error,and the gpu recover thread
> acquires the hive lock.  The device is simultaneously in the states of
> amdgpu_ras_in_recovery and occurs_dpc,so gpu recover thread will not go to
> amdgpu_device_health_check.  It waits for the reset domain lock held by the
> dpc thread, but dpc thread has not released the reset domain lock.In the dpc

This will need more explanation. Health check doesn't take any lock. It
looks like moving around the function only affected the timing and not
causing any logical change.

> callback slot_reset,to obtain the hive lock, the hive lock is held by the
> gpu recover thread at this time.So a deadlock occurred
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++---------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 343155f5375c..efe98ffb679a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6128,12 +6128,11 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
>  	return ret;
>  }
>  
> -static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
> +static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>  					  struct list_head *device_list,
>  					  struct amdgpu_hive_info *hive)
>  {
>  	struct amdgpu_device *tmp_adev = NULL;
> -	int r;
>  
>  	/*
>  	 * Build list of devices to reset.
> @@ -6153,14 +6152,6 @@ static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>  	} else {
>  		list_add_tail(&adev->reset_list, device_list);
>  	}
> -
> -	if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
> -		r = amdgpu_device_health_check(device_list);
> -		if (r)
> -			return r;
> -	}
> -
> -	return 0;
>  }
>  
>  static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
> @@ -6453,8 +6444,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	reset_context->hive = hive;
>  	INIT_LIST_HEAD(&device_list);
>  
> -	if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
> -		goto end_reset;
> +	amdgpu_device_recovery_prepare(adev, &device_list, hive);
> +
> +	if (!amdgpu_sriov_vf(adev)) {
> +		r = amdgpu_device_health_check(&device_list);
> +		if (r)
> +			goto end_reset;
> +	}
>  
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> @@ -6952,12 +6948,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  	int r = 0, i;
>  	u32 memsize;
>  
> -	/* PCI error slot reset should be skipped During RAS recovery */
> -	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> -	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
> -	    amdgpu_ras_in_recovery(adev))
> -		return PCI_ERS_RESULT_RECOVERED;
> -

This is not related to health check logic. This should be a different patch.

Thanks,
Lijo

>  	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
>  
>  	memset(&reset_context, 0, sizeof(reset_context));

