Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3BEC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 11:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19FD6E7D9;
	Tue, 30 Nov 2021 11:18:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B096E6E7D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 11:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGOMjXuNhk6GPv5N6L0GBBquEfm/Dp+lPR0LGZ+limOQ7gJdQ1VTg6OLdTNEnubE2hzlgLoE0hT2hPb/AHjn1iGJOT55zTSj8yfx2OqOKv8UksQ14wKSXrhVB1C8csDDxNem0TrItJC0uoaeFJYLJbjYdk0nN0j0M5lfYsGaYO3GiQ1eBJLyX3ZjnRBTtrdVIoEXpgKc+pRMzLGQ3JXzHiAX7e+0paFXYV61vqv98G0OZwgCdTE07klnK8elY+rrz7poLZ3rZgNzqL0n77Qu4D9kHM+2uqRkP7wZSlM8JYb/Oprv276pIx0B0fT5euUvFX3TGmus1Q4vzAP8Z8fSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9bSkrnecjOv6PO6LvdlRlnjSj8oTbZyJkm4wkt4aH0=;
 b=k7PnXI7qdRhE1RGhhpX0LCgPrPK0nNPh6o5QBiWhamKaJBNw79m22utf0mYgZoJgZCUn1VgDx5BKqHAu5Dl4PzcnLHLYqbm0spPBDclIPFCeDwrWw29Hz161ySGv4ynK/P0074zmAwQxqeMF4ooO0FfDDYVuUmFECAJW65ZqRS4I6EmajKCT2ZeNJJcOrzLaAh0qjOZrhcArL5OG/lsZz66xsznmovoYOovsLLLluYlMZCYVdbQm7HOTukVgGUgT0skYsbumHoNHrf+Xj0BWCICbmzxicCUt6LGb4SGjOA1apwIr5g8AIx/ujI1FvIwemS/kqeHty7+hDWB+hD23UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9bSkrnecjOv6PO6LvdlRlnjSj8oTbZyJkm4wkt4aH0=;
 b=lm3vktdAu3ISq9X6xMkFCnC/IzsaMozwo4XCjdVjrMybd2xRBbnj+kBGFCdphvRSLUipHAp5yjiJuiMjFy3CPS+HDkPzYaXIldSERZSqqrbrnAhWdk5co8qWIaSJRsaIRTf/SrbpGsjMZ7vclL6FkD1geLxvA8iH2Izo4RRkJPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1341.namprd12.prod.outlook.com
 (2603:10b6:300:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 11:18:45 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Tue, 30 Nov 2021
 11:18:45 +0000
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130051721.3192979-1-lang.yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b4cc4c24-e273-6e82-4baa-48505b38e27a@amd.com>
Date: Tue, 30 Nov 2021 12:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211130051721.3192979-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0156.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::11) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:fa20:e17b:e063:b6d3]
 (2a02:908:1252:fb60:fa20:e17b:e063:b6d3) by
 AS8PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:20b:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 11:18:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35aa95b2-fb7a-4026-80e5-08d9b3f32c29
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341CA139FD592D9FEA73AD583679@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uI06Nq1jib5qtO+Abvf+4q9NdIG+9rjjuVQrrOFAxMqzyfAjmXXrSLPSvNs9KY/+peT+qQQeVRhiaiKqaun6xEo7Pw7drFbXjqoEXgpK/8/kCdF4fdt4U7pYK4X2pMsXtFtXviKtFaeFleTkT38z44LoxuZ2dVMjZQss5/m7dwOAWMSWxR8Ufegtx02zZGavsiueQQtZ7k45YzDF2bw4yLIeMGdOPrSMIslxxja23obCRPhqc1F5lJoxSBvoO6r4SGoRH5l5yHx4bJmwwXCKCnNNnym6jRagtEZtwgAJFpVbdjfltKmL4FkMi3+vmVEcjbzJ4zlwCowwTODWkpZc9ucl/KCJHED4nl5HBRvM1s93J3oiE9rcKTl9VMAxiCXmsfNsQp+dKm9N4LNRLns6OlRMQiGIci7hZ1ZbleZ95m8h3411nEXA4D4fCGgm2DbspiteJww2VeEFVwv+t23r1fROfcOO8uXbxAMN1Gk+OsYOMcVEgpSeBeaMT0la2N40luQ2A1I3XYvq+ZH3ra9cim6A1wnMmth1emt1DLFx1N6Q47ZlKGqKnuR3rBUZlG91ludO7gcqEC5OvJyYAJrZtFeLVod7f4ZQgbHKGWsB5wSNExPuVboNoNXoLXOL0KrlQbUa+LpFlm7W/PFwrFyjEb2eBc40D8nxdSWtVmERfy2QrER680CI18jn2aAK4FKjMefNZqLiampt65pGGQiejJIK1cdHivg2jvVN7IISv42zL/Ei1ei4/YtcurhAYEnH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(31696002)(6666004)(186003)(66556008)(66946007)(66476007)(2906002)(8676002)(38100700002)(8936002)(36756003)(6486002)(83380400001)(498600001)(2616005)(31686004)(5660300002)(54906003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZyaGYycXFoTmNHaEo1UWV0WVBTVjZ5bjVDVUJGWmpmMjVEdWpPNDRGdVhV?=
 =?utf-8?B?STMvclUrVkdxeE5qaVVqY2VEZEhVVUZKM2VnbEorV2ttcGdYUy8vMWNwZExJ?=
 =?utf-8?B?eGJLeHFBNEJqNWxxbG91RUdhc0dRMlpqVU5TdzlUaFpSUjlDR05VYktTWnpm?=
 =?utf-8?B?cG5lQkxydVhRRExXcSs4d3dob0x3dnhTQUo5Q2NCSUNGUkhkdWdrM2o0Mnht?=
 =?utf-8?B?Qko5Y0FncUlpTmVydGNxNGhWVVJ5bEhCcndXM0lPNHZ6UCtxUG9tU2o0UHAr?=
 =?utf-8?B?cExZZlcvM2dOeW1EU2ZwYVlxeWxYcEhRTUtGUVRuM1hIalF1OHl5QW9ZbUM1?=
 =?utf-8?B?MDRvR0YxS3gvTTFNbUpyUWdlelpKR2Y1YkNMQ0tQS2NmdUZUS1ZHM1JIUEVP?=
 =?utf-8?B?YzlDZGlEQ2ZGanJpYmZmNHJMTDU3NHFid3J3Yk5CSjBhSjV2b0pUUERyZFJW?=
 =?utf-8?B?cVV3NzVSdkhoUms0cjNoakYrakFrcE1kbDZjUGdVUkFSdVZ5NlJMMDIvMTdR?=
 =?utf-8?B?c2VMdnAxSW04M29VRXZlYy85UUNXZVVZdkJLSnpXTjZpQ3hwOWl5Tzd2bXdK?=
 =?utf-8?B?QTR0ckloM25DT0E2U2pwOWNsY2RwYng4Z3JYL1IxT1lrVSs2c0xJeENEZEVU?=
 =?utf-8?B?ODlPSVVyUHJRbnZCVEhMZ290dTIwL2VjeW9Xd3F6VTZVTzZZZ0lFUldOSXdD?=
 =?utf-8?B?aVc5K0F6OUdCM1RBcnpRWGp2SGwvbGw0eDF1MFlvZ1ZJZlVCWXF3OUFUNlVl?=
 =?utf-8?B?ZUxEZGN0TG5BbWx5bUQ1TnZQNDNaTzJIV3JqeCthYU81N1R6MWJIL2t5eVhl?=
 =?utf-8?B?ME9hWlo0dCtnUFNOUVVPSkFTR2lFYm4yelNXV24vK3p5cU1QZWVzVWh3bWRT?=
 =?utf-8?B?QW42SHRBK29VY0d1aHRpS2lPUmJpUEVySk5kazQwSVdtOGh3UHNiTDlkTnk1?=
 =?utf-8?B?M2V0cFZVTTNXVFRUNGJBeEpTVmlZNSt6Y2VhYktGT0hVRzFGc1EzSVJ6bUlV?=
 =?utf-8?B?ZlJLOGR1dnljdUQyL1FiL0ppRlFWVlRxM0Y1NzBPKzdFdGNQem9NTG95MWNh?=
 =?utf-8?B?ZVR6QkdOMXJPNzJzU2tHNy93a1U4MTloWEZEczJDK1FReU94YzM2UjJJOW42?=
 =?utf-8?B?RFNnbjZOWVBEUTF3bCt3amc1TmtXSjNvUDNaVExmVG5ZRkZ6TFM0SnhsUksv?=
 =?utf-8?B?STBNdXZaUm50Y1c5dmpuL3hpbGZaaEpjRm5iVGtWZmZ4VXlUa2hIcEhyRDhX?=
 =?utf-8?B?b2c3VEZTNGdZYTluN21kVEpkY2JWTnZqNnNDdmsrTXViUzJxRG1UK09xOFY2?=
 =?utf-8?B?cVdYYUF1c0srckxPeXI4TFdhNzI1eEs0WkIycURxeWF4MmRHZ3VBOHBWN1Bw?=
 =?utf-8?B?MG1SUkhMNjhlV1FKbVNOZUpVeEo1aGVDWHRnUFVRMEVLZHBYTkwvckxBVk85?=
 =?utf-8?B?Y0NOeTZxa0NLTDE1cVZzNWdFdDdTZ01xSUY2UVBOQm9EbmVYczA5WHFyMEtU?=
 =?utf-8?B?blluWTdiZWZobFEyZldBa0tYaEE3VDdyQjBPM3MyV1dseHIyTU1JUHhKM1c5?=
 =?utf-8?B?TWdvQVM4TmlQa2FDQUhwQ0VoR2s0aHVDODFnenFBZzVTeHdPSmRWTVNkQzh0?=
 =?utf-8?B?ci9hM3A4ejYwWTNGM0lLOTBzc3pmeGNPRENrNVVRaVVHbitldXRIU1lhclZk?=
 =?utf-8?B?LzN5T0RQdHV0MXJ3LzRjNHAvclJJajZsSVpsSlpSdm1HS2ZlMVJxVWRxZzFS?=
 =?utf-8?B?RFRJaEkzR09Lc0NhZlR3YWp2cjZudkczRWtlRGkwYzRlSjFQcis0SnJwYzQ0?=
 =?utf-8?B?b0dLdVFEdmZuUDU2RkMzUG14dkYyeGNueE54S2s4TVRqRUR2S2xwUlZraXZy?=
 =?utf-8?B?ei92UGI0ZGYzM1FPOVNudW1FYkxkbWEzZ0JJa252YnVkS2N3OUNoS015c1FT?=
 =?utf-8?B?bko2U3JDeGgxR2xDRXhKd3p0TGVtcUdZdEc5R1FNb1UrRUlkQk0vT1FSUGpq?=
 =?utf-8?B?d21LZ0RJM1Zkd2sxbXNtbzEyQ3NEWGU1OHUzSy93ZmhjM3VvdnZnUUNOc2l1?=
 =?utf-8?B?Tk1DeXJMTU9rT3JOU3pkQkxOcEdNTnJ1bk1hcTVuWVhTNjJKRzRUWmVkak5h?=
 =?utf-8?B?N25ZMy95NnVjWHdjOG1EUnFSRjNxZndaY3VKZUdwNW5VNEY3MGtidGtRd1Ru?=
 =?utf-8?Q?E4uyt+TNxDOMeG9H+cAEcN8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35aa95b2-fb7a-4026-80e5-08d9b3f32c29
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 11:18:45.1247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haGEQa0kDGRujnu0PgLS7jlGsojrtuKIjnZDtklQk9gVHlQ+rPYG8p2+F+Jp7poT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.11.21 um 06:17 schrieb Lang Yu:
> To maintain system error state when SMU errors occurred,
> which will aid in debugging SMU firmware issues,
> add SMU debug option support.
>
> It can be enabled or disabled via amdgpu_smu_debug
> debugfs file. When enabled, it makes SMU errors fatal.
> It is disabled by default.
>
> == Command Guide ==
>
> 1, enable SMU debug option
>
>   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>
> 2, disable SMU debug option
>
>   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>
> v2:
>   - Resend command when timeout.(Lijo)
>   - Use debugfs file instead of module parameter.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32 +++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39 +++++++++++++++++++--
>   2 files changed, 69 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..f9412de86599 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -39,6 +39,8 @@
>   
>   #if defined(CONFIG_DEBUG_FS)
>   
> +extern int amdgpu_smu_debug;
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1152,6 +1154,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>   	return result;
>   }
>   
> +
> +

Unrelated change.

>   static const struct file_operations amdgpu_debugfs_regs2_fops = {
>   	.owner = THIS_MODULE,
>   	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
> @@ -1609,6 +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val)
> +{
> +	*val = amdgpu_smu_debug;
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val)
> +{
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	amdgpu_smu_debug = val;
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
> +			 amdgpu_debugfs_smu_debug_get,
> +			 amdgpu_debugfs_smu_debug_set,
> +			 "%llu\n");
> +

That can be done much simpler. Take a look at the debugfs_create_bool() 
function.

>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return PTR_ERR(ent);
>   	}
>   
> +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
> +				  &fops_smu_debug);
> +	if (IS_ERR(ent)) {
> +		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs file\n");
> +		return PTR_ERR(ent);
> +	}
> +
> +
>   	/* Register debugfs entries for amdgpu_ttm */
>   	amdgpu_ttm_debugfs_init(adev);
>   	amdgpu_debugfs_pm_init(adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..b3969d7933d3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -55,6 +55,14 @@
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	#type
> +
> +/*
> + * Used to enable SMU debug option. When enabled, it makes SMU errors fatal.
> + * This will aid in debugging SMU firmware issues.
> + * (0 = disabled (default), 1 = enabled)
> + */
> +int amdgpu_smu_debug;

Probably better to put that into amdgpu_device or similar structure.

Regards,
Christian.

> +
>   static const char * const __smu_message_names[] = {
>   	SMU_MESSAGE_TYPES
>   };
> @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   	__smu_cmn_send_msg(smu, msg_index, param);
>   	res = 0;
>   Out:
> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> +		mutex_unlock(&smu->message_lock);
> +		BUG();
> +	}
> +
>   	return res;
>   }
>   
> @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   int smu_cmn_wait_for_response(struct smu_context *smu)
>   {
>   	u32 reg;
> +	int res;
>   
>   	reg = __smu_cmn_poll_stat(smu);
> -	return __smu_cmn_reg2errno(smu, reg);
> +	res = __smu_cmn_reg2errno(smu, reg);
> +
> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> +		mutex_unlock(&smu->message_lock);
> +		BUG();
> +	}
> +
> +	return res;
>   }
>   
>   /**
> @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg)
>   {
> +	int retry_count = 0;
>   	int res, index;
>   	u32 reg;
>   
> @@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>   		goto Out;
>   	}
> +retry:
>   	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		if ((res == -ETIME) && (retry_count++ < 1)) {
> +			usleep_range(500, 1000);
> +			dev_err(smu->adev->dev,
> +				"SMU: resend command: index:%d param:0x%08X message:%s",
> +				index, param, smu_get_message_name(smu, msg));
> +			goto retry;
> +		}
> +		goto Out;
> +	}
>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
>   	mutex_unlock(&smu->message_lock);
> +
> +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
> +
>   	return res;
>   }
>   

