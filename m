Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1C606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xttlLcDS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A073210E254;
	Wed,  4 Nov 2026 15:50:17 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E449810E3E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrxcyxX4faV+ZsGgDdJ4DnQBMVMrHYjjjKs6y9KoaEn51lBVDOdBZtoQZlKuLWBWZWa5Tge974xVjzk2pLUWWKG70XsZth1Qr+ZZuNWQje1bXVWwpHu5zot+B+2FbbY9OyITLhZ3KPMkHSntTtQnH2GxmajVyqP6+oB81g6RhZoy5kgFQkJfz8gYMMGvgsNcV7FHezMXt6kquaNH1nR8aZo0LbZ4YF84jrEyh8jKAOJ7GBAib+vDRC2pUdWTeMiLLCsRgh2utkoCUNee3f9g2VjnGsL+czSazgJUH+MkpSHmmrF2ufFczLBHWTjW35igvXJcFabQC72ImG+OVWNG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR2c+1HuvjdIm/XOogMW9wZF1oVSSv6JT3LJTlMVlOQ=;
 b=t2xYFEkNM5x7vK4thoog6qcbfsWep2b+UmZHVzFznN0kt++04mkS6Gp9k53sFtOVQA7cUs6iTJ/SVimwI0s7NxFFRN91ocZBh6f7H5UwVgYFeLnpmCBo7F6bjPwkRqWr1FpG8PCJqnSZnWm8wg6Co3EjbvS8O1DVl2Suoo9SIX4EkXNOAZh0OlesW2AqsJZWy9+AABaH4dvgRw23zfpCLAOpoYA5QpBXrdZfhLyP1fFU26qKZnlFhhuk+Dg9pHIWQgptIaN1yswsOxxpAOcOAGjss6f7uyu1Ja8U2jABqSAoiuyty6P/rfqFov+hqXU/gUroqLn/f1Rly3n6gH3W7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR2c+1HuvjdIm/XOogMW9wZF1oVSSv6JT3LJTlMVlOQ=;
 b=xttlLcDScjm+kZNeptdWAfa+nFujMs0a0skZilawqigEU32ggrcNdtyt1QAKkj0ttLMgsUO2kJaL8dMOq4g3yy4pxiGSlNf3OcgiSdKHxe0Ov3vzgrMYGp2zeyaX/XqDtEcPtkLlyF+r6lSO1H/2Lg+gMmeP794ftzlJK8OBZvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 15:50:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:50:05 +0000
Message-ID: <94f93ec7-a584-4a98-9c1d-a23056b1af43@amd.com>
Date: Wed, 4 Nov 2026 21:20:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM
 aperture is missing
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-1-Chenglei.Xie@amd.com>
 <20261029180652.213481-2-Chenglei.Xie@amd.com>
 <3a518d91-c6ef-4fbf-8525-5a762d465ccb@amd.com>
 <SJ1PR12MB6121D39D1B80B22A317CD00B806A2@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <4a704ee7-01ef-40e0-8256-d0321914d27a@amd.com>
 <SJ1PR12MB612191850F1E0392C85225F880682@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SJ1PR12MB612191850F1E0392C85225F880682@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b45a61-1127-4dbc-f180-08df3a8b4bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|5023799004|11063799006|18002099003|22082099003|261102123227099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: kdTs6+Lp0qnEXGWOVvnBbAfgMVrEFF180SnWKUVSBMjZNai+LkVYqV93xiVgDhZ2eFMjoL0RhcWUog5A1ahb6qkJujT8kRgCwDv3dVbG/y0MoZnihdNLRM3/NVAmSRwzu8IDHkFwo9flezws/Gj02L8UpmxcuTOAaRBhwNxmwVmfHjTZlOPeNLBDTzFR4m7ImepgWgC0+mXZRiWjk7f2eIWqNopOtIDQwylMnW3X05NgowPM6WsBJJk526O68SZHd4hDkgvJ02JiDXBKrLhtn+am8uf3QlF7E/+ZaEYvQ7QfcC6axHrcSyDtyPIQaxnopj2Gu2DUAGL2FXXa+RSzH1qWVjGFD0G21Un8mlctFFTvwwF2tIQJl+9r4t8oNvc1V6flUgwvTwP8SPnGoOQj+Gh1maVmsGpg8ri6Uc7UkfQFNnBoJZ3EOy8M/vALiWl12jg9gdUZ8q8hQXJkjqVkGJLltr2UfytdymLLc1Fd6yMS2EtPhigfnKFNqul2TEEAfavPMAheBp8qMlHRS4mI5mTDwjjmAXLe+NaC68SF9Yepo1KUthBqPLTG84ElttpKjumaGYNSxMrfHTWVFW2Z1iakIvbfSGKEqzhI2aO3lZixtlEqLvZIfHlMU0PiEbDgYzJ2lGnYTVSJDyJ3vzBTrvHM1Xl1mbPnWxAA9xR22Z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(261102123227099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVPMitNT3lxSXJKTldrdlY0a0xyY3NBQ2VsRkxaQXJjQTBlMEROb2FVSFpO?=
 =?utf-8?B?NGRyekRvTmpYZUNyeW8xSlYrbDE0T0V0cWM1eFBhcUtRdnFCSXZuYWRTd0Mv?=
 =?utf-8?B?b3d3bUFYS0VzOGluTkxzTTZaY2JYWDF6Vmp0aEI4SkNicnpmUjhLYVJxZXZY?=
 =?utf-8?B?QzRTbGlEZzVEMTdwMll4MW9qR2xNbnFGUytDdUh0NVIrUjd6TDdRRE1mUjFZ?=
 =?utf-8?B?U1dONER1YTAyR0oxeEw1ODJrODRtNkVyc09nV1VVYTFXbDJXcm84OGpwYVlI?=
 =?utf-8?B?TXpDdVlVNjhrVW1JcGZFYXZ5aUlRbHBTRHBiWUQ4cjk1MjU3Um92MUZGVkJi?=
 =?utf-8?B?d1M0d2FJM1crQWZCaU05aHlhN0RtYXFlbDhYdnRtNzRhVDhGc3BVR0UwL05x?=
 =?utf-8?B?UTZIV0RxQzVuNmJqR05PSUhJU1NkKzdNdCtKRGNUd2IyTGQ5MlpsV2YwK0I5?=
 =?utf-8?B?TCtQOGw4L0tCeVA0OForREpTNWplcHNKWlgyZzNtTm83T2ZpUlo1NjNUNXgz?=
 =?utf-8?B?VnkrUDdSaTkrKzd3TmNBSzU5MGxFOGVrdDdKQlEwcEVZWnlvVHlGbjRiQStS?=
 =?utf-8?B?cVVuMTJWWllPcWpCMXlXQ2M0L2FHSS83cDNOaTVvbFpMcmxBM0pKbWtzWGRn?=
 =?utf-8?B?Sjc5dmpVQ2Z1NDhPZzlYY2VJenNBMDZESG8rNkg1TFpVKzBOVG1ocGQ0d1la?=
 =?utf-8?B?Q1dTRWgvbFdJTzBPNFNkTlV3VmdnNjErMy9ZOFB0ODhQUTUweEZUSDlRUXRi?=
 =?utf-8?B?ZjlQemZHSnR5dDdTTlcyTlRiTWF4TlBvRHBqRHlER1h5L25jZjYvNXhxYWJt?=
 =?utf-8?B?RmR3ZlVFMVBxWUIwUGw3cy9uMVA2T3oxTGJpMWREM3dXRTNBVU9MKzNQYS9M?=
 =?utf-8?B?WURHSjU1eUxMbnl6NlQ0dlZ5TzBOa1lvUWFOUW4zRFVoREhhbUZGZ0gxMjdr?=
 =?utf-8?B?WndTMW5OdTZEamtLVjhXQ0hiOUEwUmZQakU3Z2N2cUxJenBzSFpDZERkZ3c0?=
 =?utf-8?B?Umgra01hU2V2dW9BTWpuS0RuNWxvdzRvMkNtK1NiUTNTdUZybUtjL3JaZHpw?=
 =?utf-8?B?ZlhIZ3dJRk9CN1N0aHZDeUtrY2g5aG1wYktTdGg5ZzlMUDJ4T1R3ak5ZbVVt?=
 =?utf-8?B?SmVmNWo4aDFBeWZQWksyTENyNEFQRmxpdHoybXBMeE5rWWhJbVB2L3lNYXM2?=
 =?utf-8?B?ck1PMmQ5WUVKbzQ2aHcvYUtaSWxRRyt0M1BBS2RMRUdYVW9OQ2xtZEplWkVE?=
 =?utf-8?B?SHcrTmRyZUF5WGlZV0hpQ0RKb1BZTXE1QUNKbllLWWQ2K3pieTV0aG5Id2JI?=
 =?utf-8?B?eE9oc1RzS251azZBNkxQQVVzZDgyT1EyKytVQjZnRVRCNGZJZi81aUVybU5C?=
 =?utf-8?B?TDhPa3Q2UnJVdEVzbElUY1BOcnZZY1VVcG1KcW9keGc4RmhoMkpoaVFDU0wz?=
 =?utf-8?B?L1FvdmZUdnNtS3BQZUdqRzV0R3JYWUduVnJqUDhxL1F1WGFldW1HK1p0R3Fw?=
 =?utf-8?B?cGhSWEZJV0dvTFVoNmtsa2k2YmNUQzdXQitFNEJ6dkRGS0t0cmV2QllaNU1o?=
 =?utf-8?B?dTJFYjFqb2xYcGtpRmdUeUhySEtNM0h5NGJqelU2OXRUcmQwNTduQ2VRTkx3?=
 =?utf-8?B?ZTlRSk85ZXJaVlVuYlhWVjg0ZTMzOTNUd0FndkJwSWEvTndHSkQzcTJxKzds?=
 =?utf-8?B?aU1FV01OZWl1M0ZjMjFTSVlpdFE3NE45cnZwdk9wWWZGR0dyM2VpOHIwbjVp?=
 =?utf-8?B?bmc2dElDSHRYMFlSSjBiSFpuNGxDdnNDaDVaV1VGaDJ1Qi9aZm5YQ01wNU4y?=
 =?utf-8?B?bkZnOExGdkNjL0ZhRkFnTmJpTHY5N0tycXdKWlRmU1pFTGhubUc4amliZnZO?=
 =?utf-8?B?OHU5YUtEVjA0UVlyZzVVRWhNYnpDRWhWd1RHY1NyYXVzL29GWXdQejYxRXpU?=
 =?utf-8?B?aVhQUVB1QXBzajB2WlgvdERJVW1hU3FNbjRFNnJRMTRoeGZlTE9kSmw0ZlZK?=
 =?utf-8?B?YVRYYjhPQ0MzeWwweTlFS0diOUo1RjdycUk3Q1BFREpqd1RQQU1NbnAzb3hi?=
 =?utf-8?B?WnVMZ0FuOU93NUZiUjROcHVRZzYrdXRFbjREWlJZeFQrcVBlMmN0NEV6eWpm?=
 =?utf-8?B?ZDNBQzZjZXA5V1plTUR0VU1CeFU0ZHBqc201NjNSVnAwUU1TUlQwbUJUcndk?=
 =?utf-8?B?YUlOZE9nWERwTjM2ZWk1eU9kYnM2NXJDQUQ5UmJVVXN1elFSVjdCbGdyQkc5?=
 =?utf-8?B?V1g0N1NUV3pUQnpIRnNNekJwNEVlL3lsKzhxUTNZVFFNL1d0SGJVS1MwWHU2?=
 =?utf-8?Q?+p3FFvF6mPXJtbxgtl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b45a61-1127-4dbc-f180-08df3a8b4bc5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:50:05.7958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEs+7Y+MWc9AoWc7xH0AI+ZtuU7R16+6RaloHYKJyRTiVUtmaSG8myL08RFMpruc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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



On 04-Nov-26 8:44 PM, Xie, Chenglei wrote:
> AMD General
> 
> On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
> 
>     AMD General
> 
>     +err_release_full_gpu:
>     + if (amdgpu_sriov_vf(adev)) {
>     + /*
>     + * Release the access the host is waiting on so it finishes the
>     + * handshake instead of timing out and FLR'ing the VF.
>     + /
>     + if (early_full_gpu_access)
>     + amdgpu_virt_release_full_gpu(adev, true);
>     +
>     + /*
>     + * Mark the VF inactive so the later fini path does not send a
>     + * request the host will never answer.
>     + /
>     + amdgpu_virt_deactivate(adev);
> 
>      >Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>      >early_full_gpu_access case also?
>      >Thanks,
>      >Lijo
> 
>     No, it should not be called. If amdgpu_virt_request_full_gpu fails,
>     the VF holds no access as the acquire handshake never completed.
>     There is nothing to release and RUNTIME was never set,
>     so the amdgpu_virt_deactivate() has nothing to clear.
>     Jumping to err_release_full_gpu would send a release for access that is
>     never granted.
> 
>  > In that case, this code needs to be changed to just return immediately.
>  > if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>  > r = amdgpu_virt_request_full_gpu(adev, true);
>  > if (r)
>  > - return r;
>  > + goto err_release_full_gpu;
> 
>  >Thanks,
>  >Lijo
> 
> No, the goto is needed here because we need the amdgpu_virt_deactivate()
> to prevent REQ_GPU_FINI to be sent inside amdgpu_device_fini_hw(). In 
> amdgpu_driver_unload_kms(),
> 
>     void amdgpu_driver_unload_kms(struct drm_device dev)
>     {
>     struct amdgpu_device adev = drm_to_adev(dev);
>     if (adev == NULL || *!adev->num_ip_blocks*)
>     return;
>     amdgpu_unregister_gpu_instance(adev);
>     i f (adev->rmmio == NULL)
>     return;
>     if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
>     drm_warn(dev, "smart shift update failed
>     ");
>     amdgpu_acpi_fini(adev);
>     amdgpu_device_fini_hw(adev);
>     }
> 
> it checks if adev->num_ip_blocks is non-zero to proceed with the 
> device_fini.
> In the early full access case, it runs before IP discovery while 
> num_ip_blocks is still 0.
> So the amdgpu_driver_unload_kms() returns before the fini. But here it 
> already passed
> the ip discovery set, so the num_ip_blocks>0 and fini will be executed.
> Also, release_full_gpu is correctly skipped since early_full_gpu_access 
> is false in this case.
> ]

If deactivating is harmless in early access also (looks so to me), 
suggest to make the behavior the same in both cases for the sake of 
consistency.

Thanks,
Lijo
> Thanks,
> Chenglei
> 
> 
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Tuesday, November 3, 2026 1:35 AM
> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang 
> <Zhigang.Luo@amd.com>
> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM 
> aperture is missing
> 
> 
> On 02-Nov-26 11:11 PM, Xie, Chenglei wrote:
>> AMD General
>> 
>>     +err_release_full_gpu:
>>     + if (amdgpu_sriov_vf(adev)) {
>>     + /*
>>     + * Release the access the host is waiting on so it finishes the
>>     + * handshake instead of timing out and FLR'ing the VF.
>>     + /
>>     + if (early_full_gpu_access)
>>     + amdgpu_virt_release_full_gpu(adev, true);
>>     +
>>     + /*
>>     + * Mark the VF inactive so the later fini path does not send a
>>     + * request the host will never answer.
>>     + /
>>     + amdgpu_virt_deactivate(adev);
>> 
>>>Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>>>early_full_gpu_access case also?
>>>Thanks,
>>>Lijo
>> 
>> No, it should not be called. If amdgpu_virt_request_full_gpu fails,
>> the VF holds no access as the acquire handshake never completed.
>> There is nothing to release and RUNTIME was never set,
>> so the amdgpu_virt_deactivate() has nothing to clear.
>> Jumping to err_release_full_gpu would send a release for access that is 
>> never granted.
>> 
> 
> In that case, this code needs to be changed to just return immediately.
> 
>   >        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>   >                r = amdgpu_virt_request_full_gpu(adev, true);
>   >                if (r)
>   > -                     return r;
>   > +                     goto err_release_full_gpu;
> 
> 
> Thanks,
> Lijo
> 
>> Thanks,
>> Chenglei
>> 
>> 
>> ------------------------------------------------------------------------
>> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
>> *Sent:* Sunday, November 1, 2026 11:32 PM
>> *To:* Xie, Chenglei <Chenglei.Xie@amd.com>; amd- 
>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Skvortsov, Victor <Victor.Skvortsov@amd.com>; Luo, Zhigang 
>> <Zhigang.Luo@amd.com>
>> *Subject:* Re: [PATCH v2 2/2] drm/amdgpu: abort SPM VF init when the HBM 
>> aperture is missing
>> 
>> 
>> On 29-Oct-26 11:36 PM, Chenglei Xie wrote:
>>> An SPM backed VF has no FB BAR0 and gets its HBM aperture from the ACPI
>>> SRAT. When that entry is missing, amdgpu_acpi_find_gpu_memory_in_srat()
>>> returns -ENOENT, which the early init IP loop treats as the GMC block
>>> being absent. Init keeps going and dies later with a confusing -ENOMEM
>>> instead of the real cause.
>>> 
>>> Return -ENODEV from gmc_v12_0_early_init() so the probe aborts at the
>>> point where the aperture is actually missing.
>>> 
>>> On a legacy host the VF already holds exclusive GPU access at this point,
>>> and the early init error paths returned directly without releasing it, so
>>> the host timed out and FLR'd the VF. Route these failures through a new
>>> err_release_full_gpu label that releases the access the host is waiting on.
>>> 
>>> Add amdgpu_virt_deactivate() to clear AMDGPU_SRIOV_CAPS_RUNTIME and drop
>>> adev->virt.ops, and call it from the same label, so the later fini path
>>> does not send a REQ_GPU_FINI that the host will never answer.
>>> 
>>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>>> ---
>>> v2: Move the runtime cap and virt ops clearing into a new
>>>      amdgpu_virt_deactivate() helper and call it from the label. Drop the
>>>      redundant SRAT error log already emitted by
>>>      amdgpu_acpi_find_gpu_memory_in_srat().
>>> 
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 49 ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  7 +++-
>>>   4 files changed, 55 insertions(+), 14 deletions(-)
>>> 
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3ced5c18daaa..3b6a3d86348c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   
>>>                r = amdgpu_virt_init_critical_region(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>        }
>>>   
>>>        switch (adev->asic_type) {
>>> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>                adev->family = AMDGPU_FAMILY_SI;
>>>                r = si_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>   #endif
>>>   #ifdef CONFIG_DRM_AMDGPU_CIK
>>> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   
>>>                r = cik_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>   #endif
>>>        case CHIP_TOPAZ:
>>> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   
>>>                r = vi_set_ip_blocks(adev);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                break;
>>>        default:
>>>                r = amdgpu_discovery_set_ip_blocks(adev);
>>>                if (r) {
>>>                        adev->num_ip_blocks = 0;
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>                }
>>>                break;
>>>        }
>>> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>>>            !amdgpu_device_get_rev_id(adev)) {
>>>                dev_err(adev->dev, "Unsupported A0 hardware\n");
>>> -             return -ENODEV; /* device unsupported - no device error */
>>> +             r = -ENODEV;    /* device unsupported - no device error */
>>> +             goto err_release_full_gpu;
>>>        }
>>>   
>>>        if (amdgpu_has_atpx() &&
>>> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>                if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>>>                        r = amdgpu_device_parse_gpu_info_fw(adev);
>>>                        if (r)
>>> -                             return r;
>>> +                             goto err_release_full_gpu;
>>>   
>>>                        bios_flags = amdgpu_device_get_vbios_flags(adev);
>>>                        skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
>>> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>                        if (!skip_bios) {
>>>                                bool optional =
>>>                                        !!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
>>> -                             if (!amdgpu_get_bios(adev) && !optional)
>>> -                                     return -EINVAL;
>>> +                             if (!amdgpu_get_bios(adev) && !optional) {
>>> +                                     r = -EINVAL;
>>> +                                     goto err_release_full_gpu;
>>> +                             }
>>>   
>>>                                if (optional && !adev->bios)
>>>                                        dev_info(
>>> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>                                                        adev,
>>>                                                        AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>>>                                                        0, 0);
>>> -                                             return r;
>>> +                                             goto err_release_full_gpu;
>>>                                        }
>>>                                }
>>>                        }
>>> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>   
>>>                }
>>>        }
>>> -     if (!total)
>>> -             return -ENODEV;
>>> +     if (!total) {
>>> +             r = -ENODEV;
>>> +             goto err_release_full_gpu;
>>> +     }
>>>   
>>>        /* Request full GPU access only for the remaining SR-IOV init work. */
>>>        if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>                r = amdgpu_virt_request_full_gpu(adev, true);
>>>                if (r)
>>> -                     return r;
>>> +                     goto err_release_full_gpu;
>>>        }
>>>   
>>>        if (adev->gmc.xgmi.supported)
>>> @@ -2184,6 +2189,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>        amdgpu_smu_early_init(adev);
>>>   
>>>        return 0;
>>> +
>>> +err_release_full_gpu:
>>> +     if (amdgpu_sriov_vf(adev)) {
>>> +             /*
>>> +              * Release the access the host is waiting on so it finishes the
>>> +              * handshake instead of timing out and FLR'ing the VF.
>>> +              */
>>> +             if (early_full_gpu_access)
>>> +                     amdgpu_virt_release_full_gpu(adev, true);
>>> +
>>> +             /*
>>> +              * Mark the VF inactive so the later fini path does not send a
>>> +              * request the host will never answer.
>>> +              */
>>> +             amdgpu_virt_deactivate(adev);
>> 
>> Shouldn't this be called when amdgpu_virt_request_full_gpu fails for
>> early_full_gpu_access case also?
>> 
>> Thanks,
>> Lijo
>>> +     }
>>> +
>>> +     return r;
>>>   }
>>>   
>>>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> index 576a818db522..a4dd0299fe11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -135,6 +135,18 @@ int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init)
>>>        return 0;
>>>   }
>>>   
>>> +/*
>>> + * amdgpu_virt_deactivate - stop driving an SR-IOV VF after a failed init
>>> + *
>>> + * Clear the runtime capability and drop the virt ops so the teardown path
>>> + * does not issue host handshakes the host will never answer.
>>> + */
>>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev)
>>> +{
>>> +     adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
>>> +     adev->virt.ops = NULL;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_virt_reset_gpu() - reset gpu
>>>    * @adev:   amdgpu device.
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> index 3971bcc1ed11..3520af170278 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>> @@ -471,6 +471,7 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>>>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>>>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>>>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>>> +void amdgpu_virt_deactivate(struct amdgpu_device *adev);
>>>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
>>>   void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
>>>   int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index cd276a138e10..3bb13cfed92f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -667,8 +667,13 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   
>>>                r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>>>                                                        &aper_size);
>>> +             /*
>>> +              * An SPM VF has no FB BAR0 and cannot init without the HBM
>>> +              * aperture from the SRAT. Abort this GPU probe instead of
>>> +              * limping on as if the GMC block were absent.
>>> +              */
>>>                if (r)
>>> -                     return r;
>>> +                     return -ENODEV;
>>>   
>>>                adev->gmc.aper_base = aper_base;
>>>                adev->gmc.aper_size = aper_size;
>> 
> 

