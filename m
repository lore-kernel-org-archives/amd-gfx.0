Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB2D5B870
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 03:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D76710E592;
	Tue, 29 Oct 2024 03:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpRee4hx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9BF10E264
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 03:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry8rBnMb9UzBMn1RskmUyEFlJat+7KHPLTbNg48cih1dPUV53ulHe/z5eNOeM/c27/o5qZT4g5d4ZcU2maGFLQrhurUYNe7P8tdvgkZcu1qaEOawTjbunXcRMIWCfrlxzNzQcoQQS7K+TNlg13naut7CLVpc70UNwDS7mgRMNhfApqe8T3UhxvRGyk5VB5Dy430uPzNj4hOwmeu5UsHd0DSav1fzJn4KvfoWgzzpTca1Rl6ZGvzWxm3SLWvrghda9LZdoEIL/l3BXhlrKOsUa604T5SIm3eTnUCFk2Qb2rPRfOYweRADkXYAr40dLPbnkY8vfg05tQVyopNfnoGPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryNk3Ua03tluvt0lvY+htvCmrYs0jvDccq1Sty3plG0=;
 b=ChvFdJtB4jYNXLZObtYZ1ybpqylidkrraoq0XS8xFozR4RxcKbsWWXx6nqcbfnK5U198Ok21uxyNLCftbAELTTMee/qhMsAoC4SP8BWeD5E5wmKv/Bz7FbelOiP6TdMCopnJ+/1SAW+wxAzlDECB6/rXd405gtPe/tQVsmTgVe7ZULUhGOwZoAQwuyL4ItGJVuzMphdVzE25vEQuCfgrDQ9tluh4PbZ6WwuKZtaMGRSt+wYFKf9DlllFZbEZhwuDs9QOR7YW1bAaYsVPrzr2rlxQTByLI+JIdjLyPbeWrWdSExJfzyaNNiWRHav3OZt5JnXISWH11dgJgWL7CcSqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryNk3Ua03tluvt0lvY+htvCmrYs0jvDccq1Sty3plG0=;
 b=TpRee4hxjAVjBcrZ9z/9bKrUx1dhY3LXeQH7O8bOFuZ5CLzwEqdqBF5REH46uMBq3Ob3awCTD37vMD8+A8MqSqTbetfd5qz2KH+RsjYkAnn0PXGvRZuzqv5lkmR3xhLIT/cCR5QdbK1xDY0yVN6QTDyxHkfbw2688oib5bKO8MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 03:48:20 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 03:48:20 +0000
Message-ID: <9c8d4065-fcd4-4a91-ac18-08a66c5ed12a@amd.com>
Date: Tue, 29 Oct 2024 09:18:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: correct the workload setting
To: Alex Deucher <alexdeucher@gmail.com>, Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20241024085926.25349-1-kenneth.feng@amd.com>
 <CADnq5_PYPN_B5pk3MrsYf6Q0A5GHNKZXkNjzZRrW_JVqvbxd5g@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PYPN_B5pk3MrsYf6Q0A5GHNKZXkNjzZRrW_JVqvbxd5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: cf30f0b7-4b6e-48db-8f81-08dcf7cc87da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE5JcnBabXdnZnNVYmFZY0F4Q3lJeTZoQkJock05VXRqWVozcVZncVorVWhH?=
 =?utf-8?B?UU1Rbjkrb3FFZy9JWXRZWkFVWHNNMDhMdG1URVV3SVEza1ppMjlHWnBXb3B4?=
 =?utf-8?B?MlA1UmxGRTVKMjdsRlFUOEtCSmY3NXo2VzQzN0piUlBsMVhNK1hqZTNXUkNB?=
 =?utf-8?B?UjhKakdvZGlnVEt4bE9lYXF1cU9tSFNrZXZuZllJTWZpUnZHWmd6QjVjMjlm?=
 =?utf-8?B?RWJYR1dwNjBpcEl6SGZGdUJTNjg4NUwvMDdXODZveEVCUXBTS2xUUkx1bmRV?=
 =?utf-8?B?TU5lT25VRFhoZkNDdmZZcVF0enVlZmp3dmgvTEpvMlZXUHBSVWd1N1BMK05u?=
 =?utf-8?B?SGlqRm1QSUtvS1V4SkdwQldGYVBWUS9pSk05MDVIUEJSSnFlUFNlcm44RUU1?=
 =?utf-8?B?UEVLaHJSSDV4UTgvV3k1RmtvNG1GVThXaGJCZFVRTEx0ajN4UzVBanQ0RHlv?=
 =?utf-8?B?d1BlTkd1dWMvMER4anRseDF1MUdSTUNrZjE2Yjc2bmZobHpoZEpOYXhBZlJQ?=
 =?utf-8?B?NExUQTBYYjZGcmxqclRyWGlERGYzajBzS25pZ0dYUCtSVllUcUNudHZBVWdv?=
 =?utf-8?B?STBnR2c5dzhVUXdZTkx1WWcwRzJ6enp1YXNGeHZCUE5jUjdDRmJKd2ZiT3RC?=
 =?utf-8?B?RGZDR1A2ZzY4bGdZbTlVcHFFTFROdEVtdURFSW5oYitJQ0plYlVkUWxMZ1FP?=
 =?utf-8?B?a1VvL01pWTkySVN4NUlJbExDYTgrOGlYZkllR3gzVVVrV3gvQkJNQmlIZkoz?=
 =?utf-8?B?RnpUWkVQMG1SN0tVSmg0bWFpQ3hGY1NhQUkyUXRDZnBhUWp5V2lRbmhSYUxm?=
 =?utf-8?B?NG5lNDBjSFBTMUw2QnVWOURocllscGdoTi91ZUZtNUdCcWJDM1gvVEViVmxK?=
 =?utf-8?B?S3MzL0dwcVVrUkZzNTNycDlGT05UY3EreGpnbk5ORERrNlZHYkZrZHVqWW8z?=
 =?utf-8?B?TTVpeWlsY3NhR3dHU0FmQTVVYW5TekYwcG1EVGtCQzRVenJtWDFvR0x6WDA2?=
 =?utf-8?B?cEZscXJyU25nYmJub1hpUWRoTnlQWGh0LzViVEtpRzBWcDEwakxucGcwckV2?=
 =?utf-8?B?WmViSG55ME9zL3lHL1JxbUtwd1dUWndhbWtzeEt0aTVkWFdzQlFLY2dmQVpl?=
 =?utf-8?B?dnM1Zkp3K0hibWxQOFkzY21ENi9yOHIrTlVOZFUxQjhzcjV2QThsYTAvdGpn?=
 =?utf-8?B?YkZFelFpVHdXRzFJdHBaVDUvcjZpYjl5UzhOV0ViaDMrQmdLb0l5MlpCQ3NX?=
 =?utf-8?B?dW0wUEQrQjFoSFN3MkVUbm5hSEJjV0VOdTJGNnV2d2ovSmVhSTZiUzR3emJm?=
 =?utf-8?B?ZDI0bSszUmk5RlpTNENFcjloaFcrbm85WlRuaVV6UjJJNDBxR1FPS0VVUVBh?=
 =?utf-8?B?ekJOU3NDUzlFa0xIWTArY1pETkVBRlZTRmVueTJpZStCSk1NTFcxamx5eGhh?=
 =?utf-8?B?d1A5UnZYOU1oYXQwTFliRjZoWmZkWUxOaEpGbkc5amNoS05GaFEySUlqWEh4?=
 =?utf-8?B?VXpkdE9NbktjYnF5aU9aNlJRVWhzbUFFWktZK2M3T2F1VlJYWUZLY1Rzb0Nx?=
 =?utf-8?B?WndGUHZIaERuZVpHM3VhV2IxaTFkTVViQno1NHllY0lybWE2RG40a0x6K013?=
 =?utf-8?B?dGM4cnlzVGhuNFZEYUMyZC84T01vazRkbzRWWWhCYVQydlduL2FiYkFKTm02?=
 =?utf-8?B?QXN0OE1jMklFSkR3bjRobjg3eVczcDlrdnlEdDdqZ3dHSlJ1SVJrNlpzUVI2?=
 =?utf-8?Q?XAB6g7gpykLSDZI2PBilJmmAqP5LrEVCMJuKN/2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzV4R2NCc1lNek1RZ0cwbk9GN016L0pwdkxldmZTNEYxblZkLzBnL0RyZGk5?=
 =?utf-8?B?akwrY05qMzJTQ3JnV3pWc2V0MVBVc2ZWYmhDVDJHVUk4RlUyR05xL25qS3FX?=
 =?utf-8?B?QmZZZ2xiQXY4T0J3YmRLK293RVJKbUdvVzhVekdSb3NYOWJnbzNLYVlOZEpK?=
 =?utf-8?B?bWNSaHFaN29zTjlsS3JSeEpJM1JRUFp3TmtoMFQ2WjRxUVhLSzE0NXZzU09i?=
 =?utf-8?B?aUJEU01vSnRRbXJRRVcwU012TWpWTXZITTY3bjNETzZORHhrcHplMnRXRjhF?=
 =?utf-8?B?QUUyaS9tbGJVN0RMcHFOS2pVQVl1ZXhvclo2M09wUEg5L2xDNGswTDB4WER6?=
 =?utf-8?B?MjVpR2pMd2c4UWkvTzNmK25xamlsODlGTmZWTmh6RGFLYkpPdFpIaHgrOVlG?=
 =?utf-8?B?L2FEQytaQlFwb3A3Y3htOWhMN2lFYitUM0d4a3FQbUcrUXVWdDRQZU00NndV?=
 =?utf-8?B?V3RpeUNlYkREK25DNndJQTkxeDhLelNWOGVBT2gvWFBnaVFCbWZYMWFOOWJu?=
 =?utf-8?B?WXExVEdJRC8yaTVVYWVJaGZ6NmZha2hHbXoyR3FwZ2ZZbEpKREZoZm1hYkpk?=
 =?utf-8?B?clFYTVJ3R3ZzbkQ5MDNBQUdlK1pmekE1elgxWUN3UVF3RkdVWEVuRGpzdXJu?=
 =?utf-8?B?QlkwWlB6bTB0R1J0OFVWRTVNZUgvaDhnbjR2MGxzb25SQ0JhaVFNQWY2cjR1?=
 =?utf-8?B?QkFQaXgzelJCSjNkRE4xbmVnT25WaVJNYjEwYlJxSkRwdWZhdHZJUVY2OHh2?=
 =?utf-8?B?VDgyRHVSeFlvcTlVMGNRK1JNSkFzTjVZdHpEcUdTUER1akJnQi9mTnVpZkNZ?=
 =?utf-8?B?OVJHRkZlS1JveHdiZnVqS0tLN0l2N1FUZ2VPck1RK2lwV2UxVVlxY2hpNmFh?=
 =?utf-8?B?VlpWakxuc2FseTIrWVM0N1BMSEVkbVEwcXYzK2RJd05uS1JKZE8xWWZVRkx6?=
 =?utf-8?B?ZWZHNXY4QWdzZ0pGek5vRGdMUXFMVGdpT3B4STlhL3BBblduTExJVmxlakcr?=
 =?utf-8?B?R0JOajcweXJIVGpldEFGQ1pyelk4TlBadHlwVld6S01vOUFXN2N2Y2VzL3hK?=
 =?utf-8?B?UVNyK0huNkdOM0xJZEI2bHFTeGV0dDdCbXo3NDF5b3Niam14b3VlN1pHZnk4?=
 =?utf-8?B?Qnd5UWI0RnlWQnRlYkNsaDJsYURPaWpzbm5IZ0g5MGQxSUlxWUV6TEpjbldo?=
 =?utf-8?B?ODdWTmNwblVMZm5zR1Awdm1HOWw2MDNPQ3lSdWJBZkN5d3VZbXdDWnhMYnZF?=
 =?utf-8?B?dnVJRnRlenNwT21LS2s3N3lRSnNTMHdBS1NHaTM1Z1VCeEk3eXJ1YmErdExy?=
 =?utf-8?B?S0ZTVnVBQlJYM1lScWhkbS93V2lpa3RXdlhHYWNxU1YzeDFKa3hQKzZlUWxK?=
 =?utf-8?B?T1BWNWVSYVJuRlQ2a0JzUXN3cXZORGpiay9pZ09ZL2JlNWVhTDVYZGo1ZG5j?=
 =?utf-8?B?bDJLNmRUMTUybHdtVWJUTU5rbmJ2VUNoamkxcS8xWVdId0hpNjZFWVFjV2VD?=
 =?utf-8?B?ZHplQWRRbjd3a3psbU9JL3RxSlY3c1YxdG1xdy9FUTR5NmVBZ25JRk5KK3k5?=
 =?utf-8?B?TVA2WkVrQkpMRHBXTkVhUWwwbFozY3dxWGJJdHQzMXZTMTR4K1NQaURxYUJD?=
 =?utf-8?B?V0VPcmVDWTBQbmRwQWFuTURJbUtCY0dlUDRHQUlReENzZTJQMVIvWUxYVGdl?=
 =?utf-8?B?QTJKRks4cy8xdmFJQzk3cGFJdWk4UGx4U3RhUlVmWGdqLzlMRFNVSXRlUEE1?=
 =?utf-8?B?akNaRStSVjdNVHdOTE1JSmhBQ3ljUXIyd2tmaHNFRFhZQWlsT2hHS040ODhx?=
 =?utf-8?B?Z2l3WHQvcG43UWhNUkMrNW11ZVFqbHlvekdNV1VuNkpqNkt6UjBYVG1sOFlp?=
 =?utf-8?B?TFh5ZXJyZzErZnFJRlNBSUw4aVdyUHY2cElSSXoyaUR5UCtqTlFrNHM2Ym81?=
 =?utf-8?B?U0tvbjNYOHNUTFRxc0ZjMysxVFloM29zZXVBWlpLWStYRnBReE5UQjRpSmc4?=
 =?utf-8?B?Qzk3eVBxNTVjZ2ZMRkRlaERSaklnN0J0VExNR1gxS0c2dUt6aVhaQzNFRi9F?=
 =?utf-8?B?cDdWU3A0SWhSTm56SUlWekZkYUk4V29JdFdEYkNhRnZGNXZkQThTTThuSEln?=
 =?utf-8?Q?jEF0dx2DKD/ErfXosybROZPSE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf30f0b7-4b6e-48db-8f81-08dcf7cc87da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 03:48:20.7761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SquZd8yqCMqXpX33xRXJ8VvlGvMtUWEbtwN8KnRe0LjTlv3UpQWBgbbCcw4+IFh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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



On 10/28/2024 11:42 PM, Alex Deucher wrote:
> On Thu, Oct 24, 2024 at 5:18 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>>
>> Correct the workload setting in order not to mix the setting
>> with the end user. Update the workload mask accordingly.
>>
>> v2: changes as below:
>> 1. the end user can not erase the workload from driver except default workload.
>> 2. always shows the real highest priority workoad to the end user.
>> 3. the real workload mask is combined with driver workload mask and end user workload mask.
> 
> I think this can be simplified.  We just need to store the user
> workload profile and the mask of all of the currently active workload
> profiles (the user selected profile and the any transient ones like
> COMPUTE for KFD, VIDEO for VCN, and POWERSAVE for SMU13, etc.).  At
> init time, the driver sets the user workload profile to FS3D or
> DEFAULT per the current logic.  Add a new parameter to
> ppt_funcs->set_power_profile_mode(), bool
> update_user_workload_profile, which we set to true in
> smu_set_power_profile_mode() which is used by the sysfs code to set
> the user workload profile, and set to false in
> smu_switch_power_profile() which is used internally for KFD and VCN.
> Then the user workload profile would only get changed when the user
> changes it via sysfs.  Meanwhile KFD and VCN can add their workload
> types dynamically at runtime.
> 

I think this approach doesn't work if we want to restore the user
settings after a suspend/resume case (unless we expect it to be user
driven).

Thanks,
Lijo

> Alex
> 
>>
>> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 44 +++++++++++++------
>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
>>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
>>  5 files changed, 106 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 8d4aee4e2287..1de576461a70 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1261,25 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>>         smu->watermarks_bitmap = 0;
>>         smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>         smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>> +       smu->user_dpm_profile.user_workload_mask = 0;
>> +       smu->user_dpm_profile.prev_user_workload_mask = 0;
>>
>>         atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>>         atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>>         atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>>         atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>>
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>> -       smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
>> +       smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>>
>>         if (smu->is_apu ||
>> -           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
>> -               smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>> -       else
>> -               smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>> +           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
>> +               smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
>> +       } else {
>> +               smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>> +               smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>> +       }
>> +
>> +       smu->driver_workload_mask = smu->workload_mask;
>>
>>         smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>         smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>> @@ -2354,12 +2360,14 @@ static int smu_switch_power_profile(void *handle,
>>                 return -EINVAL;
>>
>>         if (!en) {
>> -               smu->workload_mask &= ~(1 << smu->workload_prority[type]);
>> +               smu->workload_mask &= ~(1 << smu->workload_priority[type]);
>> +               smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
>>                 index = fls(smu->workload_mask);
>>                 index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>                 workload[0] = smu->workload_setting[index];
>>         } else {
>> -               smu->workload_mask |= (1 << smu->workload_prority[type]);
>> +               smu->workload_mask |= (1 << smu->workload_priority[type]);
>> +               smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
>>                 index = fls(smu->workload_mask);
>>                 index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>>                 workload[0] = smu->workload_setting[index];
>> @@ -3054,12 +3062,20 @@ static int smu_set_power_profile_mode(void *handle,
>>                                       uint32_t param_size)
>>  {
>>         struct smu_context *smu = handle;
>> +       int ret;
>>
>>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>>             !smu->ppt_funcs->set_power_profile_mode)
>>                 return -EOPNOTSUPP;
>>
>> -       return smu_bump_power_profile_mode(smu, param, param_size);
>> +       smu->user_dpm_profile.prev_user_workload_mask =
>> +                       smu->user_dpm_profile.user_workload_mask;
>> +       smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);
>> +       ret = smu_bump_power_profile_mode(smu, param, param_size);
>> +       smu->user_dpm_profile.prev_user_workload_mask =
>> +                       smu->user_dpm_profile.user_workload_mask;
>> +
>> +       return ret;
>>  }
>>
>>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index 8bb32b3f0d9c..88294d986b36 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
>>         /* user clock state information */
>>         uint32_t clk_mask[SMU_CLK_COUNT];
>>         uint32_t clk_dependency;
>> +       uint32_t user_workload_mask;
>> +       uint32_t prev_user_workload_mask;
>>  };
>>
>>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)      \
>> @@ -557,7 +559,8 @@ struct smu_context {
>>         bool disable_uclk_switch;
>>
>>         uint32_t workload_mask;
>> -       uint32_t workload_prority[WORKLOAD_POLICY_MAX];
>> +       uint32_t driver_workload_mask;
>> +       uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>>         uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>>         uint32_t power_profile_mode;
>>         uint32_t default_power_profile_mode;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index 3e2277abc754..0733fd3efd8b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>         int workload_type, ret = 0;
>>         u32 workload_mask;
>> +       uint32_t index;
>>
>>         smu->power_profile_mode = input[size];
>>
>> +       if (smu->user_dpm_profile.prev_user_workload_mask !=
>> +               smu->user_dpm_profile.user_workload_mask) {
>> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
>> +                       !(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
>> +                       smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
>> +
>> +               if (input[size] != smu->default_power_profile_mode) {
>> +                       smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +                       smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +               }
>> +       }
> 
> This is repeated in several places and could be split out into a
> helper function.
> 
>> +
>>         if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>                 return -EINVAL;
>> @@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>>                         workload_mask |= 1 << workload_type;
>>         }
>>
>> +       smu->workload_mask |= workload_mask;
>>         ret = smu_cmn_send_smc_msg_with_param(smu,
>>                                                SMU_MSG_SetWorkloadMask,
>> -                                              workload_mask,
>> +                                              smu->workload_mask,
>>                                                NULL);
>> -       if (!ret)
>> -               smu->workload_mask = workload_mask;
>> +       if (!ret) {
>> +               index = fls(smu->workload_mask);
>> +               index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>> +               smu->power_profile_mode = smu->workload_setting[index];
>> +               if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
>> +                       workload_type = smu_cmn_to_asic_specific_index(smu,
>> +                                                              CMN2ASIC_MAPPING_WORKLOAD,
>> +                                                              PP_SMC_POWER_PROFILE_FULLSCREEN3D);
>> +                       smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
>> +                                                                               ? PP_SMC_POWER_PROFILE_FULLSCREEN3D
>> +                                                                               : PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>> +               }
>> +       }
>>
>>         return ret;
>>  }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> index 23f13388455f..2323c74ee50b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> @@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>>         DpmActivityMonitorCoeffInt_t *activity_monitor =
>>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>         int workload_type, ret = 0;
>> +       uint32_t index;
>>
>>         smu->power_profile_mode = input[size];
>>
>> +       if (smu->user_dpm_profile.prev_user_workload_mask !=
>> +               smu->user_dpm_profile.user_workload_mask) {
>> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
>> +                       !(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
>> +                       smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
>> +
>> +               if (input[size] != smu->default_power_profile_mode) {
>> +                       smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +                       smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +               }
>> +       }
>> +
>>         if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>                 return -EINVAL;
>> @@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>>                                                        smu->power_profile_mode);
>>         if (workload_type < 0)
>>                 return -EINVAL;
>> +
>> +       smu->workload_mask |= (1 << workload_type);
>>         ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>> -                                   1 << workload_type, NULL);
>> +                                   smu->workload_mask, NULL);
>>
>>         if (ret)
>>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>> -       else
>> -               smu->workload_mask = (1 << workload_type);
>> +
>> +       if (!ret) {
>> +               index = fls(smu->workload_mask);
>> +               index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>> +               smu->power_profile_mode = smu->workload_setting[index];
>> +       }
>>
>>         return ret;
>>  }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> index cefe10b95d8e..c2fd47f04e2d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> @@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>         DpmActivityMonitorCoeffInt_t *activity_monitor =
>>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>>         int workload_type, ret = 0;
>> +       uint32_t index;
>>         uint32_t current_profile_mode = smu->power_profile_mode;
>>         smu->power_profile_mode = input[size];
>>
>> +       if (smu->user_dpm_profile.prev_user_workload_mask !=
>> +               smu->user_dpm_profile.user_workload_mask) {
>> +               if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
>> +                       !(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
>> +                       smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
>> +
>> +               if (input[size] != smu->default_power_profile_mode) {
>> +                       smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +                       smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
>> +               }
>> +       }
>> +
>>         if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>>                 dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>>                 return -EINVAL;
>> @@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>>         if (workload_type < 0)
>>                 return -EINVAL;
>>
>> -       ret = smu_cmn_send_smc_msg_with_param(smu,
>> -                                              SMU_MSG_SetWorkloadMask,
>> -                                              1 << workload_type,
>> -                                              NULL);
>> -       if (!ret)
>> -               smu->workload_mask = 1 << workload_type;
>> +       smu->workload_mask |= (1 << workload_type);
>> +       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>> +                                                                                 smu->workload_mask, NULL);
>> +
>> +       if (!ret) {
>> +               index = fls(smu->workload_mask);
>> +               index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>> +               smu->power_profile_mode = smu->workload_setting[index];
>> +       }
>>
>>         return ret;
>>  }
>> --
>> 2.34.1
>>
