Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EF606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dSlXvTuE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9311124C0;
	Thu, 29 Oct 2026 19:27:53 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B181124C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 19:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSmUZvdjZfZhzeZ/EPPoJ0PQsE7hjPkWxaCysxhW6mi4Ndsq8ukVnAUrbSY5qTXp05VXsxJHqA4jpTOcwGr1c/0SnnhY+WtaPSAvxlurAvoAegWWyNU533YW55cW/RSWVlnpKBB6CnC6IFpCBYBJJNdpLi+GeJ6g+JKMgN1iHaOOtAIxURXhaaFcDMJkEmyY8sNfxqHpyil5j5vqsePcxCx9OKVC/dUWGJmZf8PicKkFUbotn5+qwcc+UqkjqlUePPWQots8+VEeXmhVBV2jqYOx5rjVrGKq/JkQ8QJMfG+E1IhbYWr0rWnm4tyBQkSlyN56M64V5o7Vix+aKeMwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx1U3LyrQG9YuItb7Q5T92driJaTbo/Yqqeo1m2R30U=;
 b=dGUk/q5t2P8dWKqY5bFahKwVlj5EjjmA9kOK3cS9TtRbELQd/Rfa9FB8xzmP0isp0JkS0pQbgp91gfAzyMot6hPNVZwfKgvANkWjiseSG6sZMWRZZkDG5/LdfBuRmxqZCD94Ri0MC8lfd7vnYAkKXc5gfMid0aAeJjfrptoTxDgscJowUH1BEd+gXbpFu3XIQ1BhL0z/beST1G4cHGIEdS+12cQaiOV1BHU0c1f1YWGKX9GJZYvS6UVEip8niz4LnOFLahyAWyCEeK6DfdUSmzO8rWTbEOlZjhcuQJmhKnXuFUHEvIOGAZznnXeYf3dK2qu3o/ItcJTfv0oXCb465A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx1U3LyrQG9YuItb7Q5T92driJaTbo/Yqqeo1m2R30U=;
 b=dSlXvTuEPcCRtSmpSuJk+bFlQGX5/FkRn8NiXdtzwKXe9k0D+XdzLI4z/93mXs4Bv+7RjTvVwhScmLAcV8qbPRhinLpuBnKVjMycR9r9egNgEdrt6OMx7dRiqMDuKtldD3IxlbbeihXYq04abXoD0vnt3qs61IrpfWECCFpHQUk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 19:27:43 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 19:27:42 +0000
Message-ID: <835e1b39-9e39-4bb4-868d-3aecc242dac2@amd.com>
Date: Thu, 29 Oct 2026 14:27:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <PH7PR12MB60006BC07B279A62753C9F4EFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <PH7PR12MB60006BC07B279A62753C9F4EFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:610:4f::26) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 604d44ce-b75d-4897-efb0-08df35f2b37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|261026140227099003|11063799006|261028144727099003|10067099003|56012099006|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info: BIeaa8WaKyuJI/PpM6rAd2F5P3C6PVucKW8hobw5osVaDJjVFBXedgT2WB8XlXTUbDb424T456fmUFJtLH3ibLD0P59w/zjBrKEo2bUGLFKYYWwzhtB29v8Baf3MB3CaLkSMFBxnujYPRUkxLR/94lGkWHx6PvJ1x83a8lFfx4cCXenPg4esa+ANK2d4C3xXOhnc/us9HWqNjpfdLyiGFs6q6+kCt1F88iqiBt2oQhIEzDVMLSOFa8vojr9XzmeKgeNJ/du4sKgslbaZL3BLojjSPsPd46eTKd8Ud7lbGf3advj+NixLcFLSCDzVU66zKZPSb0ywdtmu6Um65MCbfzdKq+5AfCTqLZMSJ8WwRqj2+BnXdOX8MJ7BSDtEeFto2Wm2+EXAFVBZxfTaEWKvaXpfZ3E4o9ruPCVQhHKgGIHK4dWLBAQsjSgWNm/w0GxM3wSYDJZfTBQueHL2QCuY4T4siwO3pr6Nu90o/igK+3uUGqUpv8/KCc1v9ke6mOtqiMa+3ErS9h+zPdlnzWpeAmrEjYljD1+ArCbS3V6zTNf23EPo7hWFMfgEuEEKUjkU/sacC/Z7eVfA5/zE8cuKcE6DQJ4/whLNB0dZOH62yuAR2dpSVsfRCMfvrEwtBGQBTxIOB9C64jH8P7is7pihAp2khxZoUaez91De7LuWTuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(261026140227099003)(11063799006)(261028144727099003)(10067099003)(56012099006)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(22082099003)(261026121527099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y012aEZxQlJydU4yM3ByeDFNSFg1bG1qZEwvOWVvK0UzN3pGZllRcm4rbTY3?=
 =?utf-8?B?TXBJQ1IrdHh2SnYwWE5EMjhPQS9pSituQUk0a1k2bjRoL2p0NzNsc0dzVVlN?=
 =?utf-8?B?c1lHcFpwKzduMHhOSklydXhBc2QxK2s3VFRDUll5QmVWc3FlYTFFMUwvWE1s?=
 =?utf-8?B?U2htS2syOGxackRKL1ZadG9HTXllaXVmL1NQUGtCK2VDRW53UFh4V3NkMUl2?=
 =?utf-8?B?MGh5aFBUbkYrRVRJak5NK25PWm5Kc1BlOUxOQ3Q4RjlPSytrSE12M3oycllW?=
 =?utf-8?B?UmlQaWdYNThRdkUweFFmMGEvNUlJQzdqTVdzMkZIV3ZmU0V3K0FPandmSTZL?=
 =?utf-8?B?QkttV20zRVN6U1ZnR0htOWdaWk9mZWRQTWZTZmhHNnF3SW5WcEc1UlFXUDVD?=
 =?utf-8?B?SzJOVTFqMGtnREFaZi8rK1VnOXZWSzl4czJ1Z0pOeW4zcFpCQm1qYXR0Ull3?=
 =?utf-8?B?Ly9semdtT1diZ0hYdmZrdTFkNVNKTTFpQlBtdmtuWW9kWSs4M0xGT2l2TlFG?=
 =?utf-8?B?VU5xemJrdUpsVnY0NTQ0SEJsOEc3N09WemhQRUdyL2d3Vnd6R28rMm1WcCt0?=
 =?utf-8?B?OFRsL0trc2t4Z0Fzam5IRUk3TnBteWlTN1lVQXZsUWNUV0wvZEM3Y1pZQ1U2?=
 =?utf-8?B?RGZHcXdaZ1RJVTg0QjMxN1F1Nmw1Zm9FWWt0UXgreUlxN2Z0NmM0djRUT0Zy?=
 =?utf-8?B?TXgwWVlJdW0vUFFadE9CMC90blczSSsvRVFiZDFZRHREV21SbU5wRURZWWFj?=
 =?utf-8?B?cWlheU5FQmdac3dHYURjS0hrRW12R29KZ0d3LzB3WHkzTGlIWk9CQko5VnVh?=
 =?utf-8?B?U1BHT085RXV3a3pMbUovUHY0dS9ZaDNYUTBhMEF2d01TUW5iZEZSU2xUOXpE?=
 =?utf-8?B?a2RDcGhITjN4RnBzTlRBVklhckdNVmRUem4raEs4N3ZXeVI0RDl2NnpVcTk4?=
 =?utf-8?B?WTlHdk44K1Z4a29lcnR4bk5aNUZWZEFtYlI5YjF5aTRaaFdHMERmN3JXSzRL?=
 =?utf-8?B?cjZqRlRReTc5ODdPZVd5RzBMTWJMNVkxOGRsZ2haYkJETStNWjNRWmV0cXJU?=
 =?utf-8?B?MkpiamdnTThndXlTeTNqSkgwTEhDN0ZndTFKeThIYjdnRVJMekFQb0pHUTV0?=
 =?utf-8?B?Ylk2QUlTTE9TS1VGUzJ2WUM3Ry9HRWZYL2d5N3JxbjhlRjBVVHlsQllpMnBq?=
 =?utf-8?B?ODBQeFpVWUQyQU40U3dCNGw3REl4R0JKMkFONEg5RlRuSlR6QkkyZzZseG5z?=
 =?utf-8?B?aVY4bTZGR2pZWVJHTVEyRVphK2pFOXUvNFp0SHFJWTB1ODREYlE1dTcrZVcr?=
 =?utf-8?B?MWdDOUYrRXpvaGRSTkQyQnFrbVU0dUZ5REhuVUJVdStZb3BJY2ZSbm9EOWNG?=
 =?utf-8?B?aGxvSkVNZ1FjZHlOVDBRZy9IRWxGYU5zcVY4a1QvOWJCeXlNblpYVCtpT2hj?=
 =?utf-8?B?Ylo2MVhpV2tJZ1Q4bXJ6Nkdvd0YwUjg2aFBXUFQvdU8vUm40NXJQUmFacTVZ?=
 =?utf-8?B?QXlhTDllNi9RTW1xN2lnNGtGSDZYTVFqUFJya3FTdERoZ0FmTTVaM0pXSUZm?=
 =?utf-8?B?Q0NUZWxrQThIaXAyb1RmQXgxem5qZ2NOYzE2dUk3SGs1SDNGanpQd1Z4aHkw?=
 =?utf-8?B?V0RKQnJUbEVkYTExdlovcVNMWWxLUDFrS0RIMFg1SlJlMjlvOTZyZUlZN0g0?=
 =?utf-8?B?aTFuN2VpTmZWbGNKTUcvODFUbjRjWmEvRStJc1BWR21BVStXK3pPcXdlQkZW?=
 =?utf-8?B?eHRtQWtLOFFaN3M1QWdUSFFaaGRFck1TNWgzbFgyN1h1RGpSQ1pocHdkcmpS?=
 =?utf-8?B?U0FWZzU4RlB0Wnp0NFJ0VkNEYkhZRlRGWkVwak9ueEZUNTUvNTJYUWJ6NTVT?=
 =?utf-8?B?NlBFYXJpdDMycVF0b0xGd0VzZFZ5MmxFZ1VKZU0zSVZMcTlOOHhkSVZKT3hn?=
 =?utf-8?B?VnJiRWZxei9EdzlrVjhhZk1SRlJzYmJQcnRRVlJMakNER1ZFbGVBMVN5cjBp?=
 =?utf-8?B?VzJtWUZacXV6YmIrWUtDNTJpQ0FocWpWazB0TUFrS2lScnpoWUV6QWdIUk82?=
 =?utf-8?B?VDFwcStFRzFKbTUwSENZNkVjN2hqWDFpU3ArZ1RseTNXSlZtMlFKYnBEbGVG?=
 =?utf-8?B?ZDJ5bzlLVkp3RS9mcGZ0ei9VUWNNM2lGNGk4OGNFakZsekJhempWVFhhdG9R?=
 =?utf-8?B?ODFGQ0QwNm53cDVoM3pEc1lQYlMybHhnLytMZm8wTTNza3BNNVQ1TEFZaHZO?=
 =?utf-8?B?RHhsT05rV0ZuaTBmM0NzdGMxS3JNcUxScWpkbXZrSG9zcWorUGVwMmhSWW9W?=
 =?utf-8?B?WndvMERqOHNkVkNTcE1EUThYa0dFTTIwRTRaK0NucW9VOUtib3JlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604d44ce-b75d-4897-efb0-08df35f2b37e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:27:42.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0/1TslKH1GP/A9OM/frgm/hDA3Pg00YGCJpPquG88APBhZFkWwJDtxZKiIVujeqOAE9imdGvDsWVNdFxqcxTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 21:17, Liang, Prike wrote:
> AMD General
> 
> Adding Mario for his insight on moving drm_mode_config_helper_suspend()/
> resume() out of GPU recovery, where they block waiting and allocate reclaim under
> reset_domain->sem and can deadlock with userq_mutex.
> 
> Regards,
>        Prike
> 
>> -----Original Message-----
>> From: Liang, Prike <Prike.Liang@amd.com>
>> Sent: Friday, October 23, 2026 4:34 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vitaly
>> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Li, Sun peng
>> (Leo) <Sunpeng.Li@amd.com>
>> Subject: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system PM
>> path only
>>
>> amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
>> suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
>> and drm_mode_config_helper_resume() from them makes GPU recovery take
>> clientlist_mutex and the modeset locks and duplicate the atomic state while holding
>> reset_domain->sem. Lockdep reports:
>>
>>    Chain exists of:
>>      &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
>>
>> VKMS has no hardware state that a reset can lose, so the reset path never needs
>> these helpers. Call them from amdgpu_device_suspend()/resume() instead and
>> leave the IP callbacks with only the hardware init.

As you mentioned when pinging me there is the reclaim/fence reasoning 
too. It would be good to include both in the commit message as well.

I definitely don't think we need all those blocking helpers in the GPU 
recovery path at all.

 From me this patch looks good.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I do have a small nit below (feel free to fix while committing).

>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> Cc: Sun peng Li (Leo) <Sunpeng.Li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
>>   2 files changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b74f9136aa2e..406c5f2fbee1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4568,9 +4568,16 @@ int amdgpu_device_suspend(struct drm_device *dev,
>> bool notify_clients)
>>
>>        amdgpu_ras_suspend(adev);
>>
>> +     /* VKMS modeset state is saved here, never from the reset path */
>> +     if (adev->enable_virtual_display) {
>> +             r = drm_mode_config_helper_suspend(dev);
>> +             if (r)
>> +                     goto unwind_smartshift;
>> +     }
>> +
>>        r = amdgpu_device_ip_suspend_phase1(adev);
>>        if (r)
>> -             goto unwind_smartshift;
>> +             goto unwind_vkms;
>>>>        amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev-
>>> in_runpm);
>>        r = amdgpu_userq_suspend(adev);
>> @@ -4618,6 +4625,10 @@ int amdgpu_device_suspend(struct drm_device *dev,
>> bool notify_clients)
>>                return r;
>>        }
>>
>> +unwind_vkms:
>> +     if (adev->enable_virtual_display)
>> +             drm_mode_config_helper_resume(dev);
>> +
>>   unwind_smartshift:
>>        rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
>>        if (rec) {
>> @@ -4717,6 +4728,12 @@ int amdgpu_device_resume(struct drm_device *dev,
>> bool notify_clients)
>>                goto exit;
>>        }
>>
>> +     if (adev->enable_virtual_display) {
>> +             r = drm_mode_config_helper_resume(dev);
>> +             if (r)
>> +                     goto exit;
>> +     }
>> +
>>        r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev-
>>> in_runpm);
>>        if (r)
>>                goto exit;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> index d6b51b3f216b..6de33f14d909 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>> @@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block
>> *ip_block)
>>
>>   static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)  {
>> -     struct amdgpu_device *adev = ip_block->adev;
>> -     int r;
>> -
>> -     r = drm_mode_config_helper_suspend(adev_to_drm(adev));
>> -     if (r)
>> -             return r;
>> -
>>        return 0;
>>   }

With these changes I would suggest you just drop the callback/function 
entirely from amdgpu_vkms_ip_funcs since the function just returns 0 now.

	.suspend = amdgpu_vkms_suspend,

>>
>>   static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)  {
>> -     int r;
>> -
>> -     r = amdgpu_vkms_hw_init(ip_block);
>> -     if (r)
>> -             return r;
>> -     return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
>> +     return amdgpu_vkms_hw_init(ip_block);
>>   }
>>
>>   static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>> --
>> 2.34.1
> 

