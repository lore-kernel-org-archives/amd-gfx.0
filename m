Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EA6C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 08:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5541A10E27C;
	Fri, 17 Jan 2025 08:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mke9wRTD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D8E10E27C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 08:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtpE6Mbc6gcECzZRh1wwzjS2L2R54ewrd/soUaWwAdJZuyt659TBRrBiYpIE6B2bnKnaLze+VYQJymOTx7pHzdBY6t1EyikC0iHRmaNwcLlnZ9zvqyuE3q2x2yQ5JavWF730mM49VpImy/hp+mAkEe1NRzbm9u3qbCIRbfzu5I+Xj4T6xyP4y7zgCXEK4XXFjNDbZTqx3mk5e4IARuplBkoSm4oPubMjis7a4hmHpX5TEGGHFD0uV+1p0O6puM7Sv0dppw59EZprYMP+pdlAcb12lDC3tOxaaekZFaQ6HLjrx8eqzVTp4u9TeNO4QS0zQMe5pfieQdDUi8wcUrcrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hVUmpcmrGHbZEyja6EMMXowOPVy0usFUxacTdkqnTY=;
 b=q5i39SBdsIcorLIqrpeTRzCrsynmDvdd/vq/kBaWbmfIvpOVlxdys0fwtan+C2fpsBECmkTfvO+tZtBjBs5O14/urIQqlFqY8WTcf/4J7IKjcqbsBA2w8adKlnSy6FfDPTMChVH+CCqdpGgVU01V9JSyJGmsnZr6xdYAaSAQJk2yXuH6DtHhd2f8BNGcNXSTswK4QhxyNdUS/3oyB2VFuxBYNBpDxcwiyMZPdeRhz6Pr0NHVYBdx0Sd6g4vT/MyF6iKOFF8/aG1ks+voHfWzyFZdXSkoynDmsUHuWvrTqV+U4sIzfmY4K76z0oxsegDSvh7NJhd6AT6lnKmUvCs2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hVUmpcmrGHbZEyja6EMMXowOPVy0usFUxacTdkqnTY=;
 b=Mke9wRTD1KHLx7+JpUFwbCfc09PFkQ8UqSJz5NAE5O7578iqhR4hqvYXK8TQ7JENlNQH6PZJgXpNBq+Fpt+78w77YBgsoHNdRBKPPS9nhxQiq9T0avnRPzrIkU25mLP2baFX4p3hQusH85nCrorpv8D9KA1soyNnRUa4zlGcuwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:37:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 08:37:11 +0000
Message-ID: <ed1bf88c-aac6-44de-8dbd-78cc205e4374@amd.com>
Date: Fri, 17 Jan 2025 14:07:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bb0d7e-0209-46c2-071e-08dd36d22270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDhKa3pwbHJlZzJtRHV3V0lzVXhWRkl2QzhBZ0JjL2xIOFVxbEkzcEhVWVhx?=
 =?utf-8?B?MzhwM0lZZkRiVnZoa0NLcWtaREFUL1NFZUtFb21hbzRqd0hwa2txWk5nYU5O?=
 =?utf-8?B?Yzd0VTRwdU5yUzJiWGFKd2syY21yNjZZczVHOFRzNURnc2FyWFB4MGdLV29W?=
 =?utf-8?B?dlIydnNMN01mRnZHcjVYZUZjYkFMaEl3WWZhN1owU2RCeDlqU1ZkM1U2ZWF5?=
 =?utf-8?B?SktwRWl2QUN2R0ozZloxdm8wQVJINnMxbjJFSWFyMEZPeWgrQUovRFk5bDdI?=
 =?utf-8?B?eG5yL0FKOTVmQTlLS0k5NkVaREtqNitTcEpyRjd4ejgwQ3hTM0g0SDlWNnlt?=
 =?utf-8?B?WjhYRzdOUWRNaXV2WVp3YlJPdUFJcU1BSE5sUUVaV04vS3QwR3FPOGxKcmxz?=
 =?utf-8?B?V0s4ZXZUTDB2OFNUMVJlWEZhZy80aVE5N3VDMUNsRzJMbHd6SE5VWXFuV1l3?=
 =?utf-8?B?ejFNNWhYdlV5V20yZzR4dHM3KzVrb0paRzJXQ3FiS0h3SHVBTTRFY0lmZ2Jx?=
 =?utf-8?B?bXBpQzBJM2hZc1RNNFBJRWxHakpGQWFPQmQrZGFLdWVLaE1rTkY1ZHFSeEpU?=
 =?utf-8?B?T0pzZzlhQ3lxZTY1bWw4ajkyZHYvYk1UNTFHUS9ZQlU2a1RLTjc5K0szdHIw?=
 =?utf-8?B?WTN1VWdUSTlzaVRJeWF4eC9TcGlkeUlFSVpIbDBkZmxNRXB0RWc5K3lxOWx5?=
 =?utf-8?B?YVF5ZlZhQ1JWWTdtdFJjb0tJWUQyMFBhM3Q4YXE3S1hPUm9XWi9zMzErTEJV?=
 =?utf-8?B?WXp5akJVenl5eVhkeGNGaW9ncHMwcE9LcGNtblpMOEVaZTlFN1pYS29zSkx1?=
 =?utf-8?B?Z1Rna0Y1cElYc0xENi90LzhDa0o2MURnS1doMDVuUUVNVjEvaEd5UzZKelk1?=
 =?utf-8?B?eVFoZkNjbGd4anc1NnNRYVBFellPWkFxVHNtMm5qckovNzhGVnFvYXhKYmxh?=
 =?utf-8?B?Y2ptM3dudjhFeFIvRSt1VVJ6aHNFQ0NESlJRcFhSOVVuRnFiSGV4Yy80T2NE?=
 =?utf-8?B?clZmYnc3djRLUGRmdTRoQUp6ZDhBWkxWZXFxZVhKSEJURUdIQmlFZ0V0a21y?=
 =?utf-8?B?V0U4a3RGNnVkZCtXcVpmamdYRU04OENNRXlDNmllY2JVSEpxQ3g5MGdkNWl5?=
 =?utf-8?B?R25qbU5XT0RydWxhdmpLMnJtTVhnRWY3V25pZVM2eXhXMS9GTzRpMS9vWSta?=
 =?utf-8?B?dU1QUEVPNXdKb1NKcmVEY0p3UzEwZk5mWnNGSWpOVDVZMzZYK2x0bnJhOFRX?=
 =?utf-8?B?U2c2UytueVVaNmlzM05KanBNeHY3YnFJcm90anRpNDZMSEhJemcwUGdLVEZi?=
 =?utf-8?B?YkVUSnJPdy9mOWlWdFg4bThBcUtsQnJKZjB2cHNwQmV5SmE1M2Jrbkk2c2Ex?=
 =?utf-8?B?czNLOUV5SVFWTmZnQ1E0RlJxTnNMRnB2MWdBS3pEY2lOMkdUK1JBM0dkdTNY?=
 =?utf-8?B?d2ZRbHRqZlZ1MFlpcjgzellIclBpbWh1Vi9uSHhWSUhOZk1XRiswWmhReHhR?=
 =?utf-8?B?aDNOR3RqMnlGUlVjV2JubjJuMFQxdkNrRERkL1M5U2ltelJlQzZubFZNZDlm?=
 =?utf-8?B?UEQ4WjRqWGZOQVFaMmFSS25WUE1kNFViM3hqVTFzWElHUzEwSzNmcVlMd1JD?=
 =?utf-8?B?VFZMd1lnRCt2dkk4dHoxbzc0VHBJYU4rMTFTU0ZyZUhuWGtYMGlNbXBFdFdu?=
 =?utf-8?B?cm9TY1JYYlN1UEQ5QlFTay9YT2FyMG43bEtheXAxYVhySktpS2pBeUpZVEds?=
 =?utf-8?B?ZVdESzAzRnRxV05sc1RTRnM1cmlBTFNTVlU4N211U2RpWjhXRzBCa2RTeDdP?=
 =?utf-8?B?KzltR3J6aWZWdTFZMUh6WGpRN1pNTk1KamE3aVNHcDV2RmhVczQwNVhKSnI2?=
 =?utf-8?B?U0d6ajJPRG9EZlF2RTJsMXpJU2VzQmxzV2w1cmQ3NFcyZk1SdTRqVEV6cnBR?=
 =?utf-8?Q?m/z6fpijk2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NLc29va29YWDRvWjlPMHJUNHFoK2tHdVRzSmxJckh4N29Cdk1Wb21xMCtt?=
 =?utf-8?B?dEU3UHQ0OWdSeU5oWDFkRXdQaWtOdXhidjFDYnAvck9JZHpmYWhzaGtWQyt2?=
 =?utf-8?B?djR0cjVzMlgwUXVSSGwwaHpMSTlkdGFJaXl6MEl2KzFhZm5MY3c2RnhZaUdR?=
 =?utf-8?B?eTk1ZktwWm43QUxaTUVKa0MycjVWUC9USUZKVVFyK0c1NmdhU1V3MUVJNCtz?=
 =?utf-8?B?TXcvSFdoVFJydHZ3RHI3M0Z3REpNWERjaXc3NU5BdGtsSlhRb1JHNGNVQWNv?=
 =?utf-8?B?SVltTzUzZ0I4N0JnQVVGT2l5WnBpUC9sdkk2cC82MkVtM3kvd1JZTnBuY25k?=
 =?utf-8?B?bGtCcnh4MVRiVk1meFI3SS9sRmNrUXJMNzlWQVk3NzQ4M1VMY1dJdFFkdSti?=
 =?utf-8?B?QVZnRUcrQzZxamc4cmpEY0VqWlk1Q1U0MmFRU1NZZXUreHN4bkJSeGJ5enl4?=
 =?utf-8?B?blBjSStkanh6SFUyT1BjL1lmaFFZYUMrUU5ZY3Y4b0lySWlNT0hreStHeGtj?=
 =?utf-8?B?aVJERGdueWJUSFJnVEp5cHJqK0dmWEQ4U2hXVzNCVC9KNDVxTDZjMVI4a1Bl?=
 =?utf-8?B?SWFMTEFod0ZhR1Y3OVdTNGxTUHQ2djRSdzhxalhrRzkxaHA5ZTNVdHA4dk8v?=
 =?utf-8?B?ZkdwQ01tTUk5TlEvd3RKdEFpSnhnVmcvN1MrMGVZTjVlWnd0cSs1QndYR0o4?=
 =?utf-8?B?MDc2T1Y5c3dZaTNJTGZ6V2xPK3VEZ2NoOUpYZDNZcnRjTjFiTFd1TW9ROTdu?=
 =?utf-8?B?d0VKcUJtcnpHdllINk1XRnVLQm1ST280amN4b1ozR1h0Tm1rWkZYc0tjVUpH?=
 =?utf-8?B?N0h2aTU3SXNzNEw4Zmc2MjMwWUFlM2duRG1WeUhxSVVsSVVjOUpETFFqUTR4?=
 =?utf-8?B?Q1E4akJTNkJKSDJwQ1hRN284ODZ6YkJGRzNVWkFwYmdSeTVXa3hBWndVOWdO?=
 =?utf-8?B?ZURaSlRYVWYrRUM3eVBOMEhBWUxqb2RqZjc2dWdLWm1HS0hrVjduOEN1d3Vl?=
 =?utf-8?B?dzRZNld2Q2xkZ0hhdTBoNDBHVG5KYXJiZmI0bzBzZnh3azFxMmc0R2ZnZWlj?=
 =?utf-8?B?S0gyaUFRZFNSNVVOWmJVTGR4d1FFNklCMHlyNEthUkxPb2dqUHNYNnk1TVBI?=
 =?utf-8?B?QTNIUGZJOTN5cDVTSEpxNldOKzFhK0tKRzh1bVpOeXJFdi9ueDFZQkNxam45?=
 =?utf-8?B?eVh0QStsWmIydFZqNUE0LzhVMnBiVEt2Wm4rSk5jbHd5dUhvYU5MUjVPRkVB?=
 =?utf-8?B?WUZSa2xWZURYemwyYkFjd2svS0pCVjNaVDVVMUdlRlUyd01jcEc5NkgrOEF3?=
 =?utf-8?B?MlRvanJOQjdVRzBkMVdUSWlxWm05eDBTNi9HZVZKYTV0MDdGSSt3aGllRVRX?=
 =?utf-8?B?NkpoVlRKWk1TSzRPdzNmQ2Nmd3VDbmlsQTFkb2ZqSi9uemFsdEg3Y0dUMkJ2?=
 =?utf-8?B?cjFOcHVJWkxtNWpNUmpHT0MzamxPbnR6TlNxeVRNZ0dSdkNhNFRKSENzMTlY?=
 =?utf-8?B?YU0vS295Z2IvelFHZGxtVTlYaDVzMDNhczZsYWw1aVQ3aWE3dFZybXl3Mnd6?=
 =?utf-8?B?M05lbWxVM0d0bVBqMks1QUp1VnoxUndrK1FvOXk0VjJ3bENyMVk5RjB0YmlG?=
 =?utf-8?B?VFdVRm1hSHlyeGhqYUQ4bUp6ZE53bDdQVDdWS0xtejdlNjJMVnBRanZBZTZI?=
 =?utf-8?B?ZkdGSjNIQXgzR0s2T3NWRGN1V1JrWUdKZ1EwM2VKWW9kOGJ5eGw4dDRaN2ZQ?=
 =?utf-8?B?VnUyV2lQd05RZXIwRkxxdCs5Tk9oTzRYUXNSSUd4RDhPZjFWdW1GcGNMSFJU?=
 =?utf-8?B?Wlc3b29GeFN3cTlaMVoyYm41M3M4SDdGcGFuelRHdUhEWkg5dVBhaU9pSU1z?=
 =?utf-8?B?TVBPc2xvZ0JqbHl4YlZOZ3RHKzRNQTFwVS90MkFPblVtRTZHcGVwTm5vZW9a?=
 =?utf-8?B?Mkl6Vkp4L05xSlRUU3preFBiWU93bFBjUU9ESHEzUFpnVTlZMGQxSlNQcHRm?=
 =?utf-8?B?SnJVZ2ZMK1lkemxVOThKbk42YTJZWWZlM09BdUhSSkJQK2k2UDlRbWgrU0dI?=
 =?utf-8?B?d0tZQTZrYm1BYzhaRExleXdZdGxJTk1udFc4NjYwSFZWaUExQXdWMWFIbjdz?=
 =?utf-8?Q?qagI+rJTJuAbD+1vdbHgtnX5z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bb0d7e-0209-46c2-071e-08dd36d22270
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 08:37:10.9212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMKkOaSU/8bFdTuXZP59n3UTmDbrbxc1upzg2mHDtysPUIU/TlEHNWF2LoHbDfxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini(), to keep same
> style with other code.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  2 +-
>  14 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2bfe113e17c7..6cbd19ad0fa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4613,7 +4613,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  release_ras_con:
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>  	amdgpu_ras_fini(adev);
>  	if (amdgpu_sriov_vf(adev))
>  		amdgpu_virt_release_full_gpu(adev, true);
> @@ -4705,7 +4705,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  	amdgpu_xcp_cfg_sysfs_fini(adev);
>  
>  	/* disable ras feature must before hw fini */
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>  
>  	amdgpu_ttm_set_buffer_funcs_status(adev, false);
>  
> @@ -4922,7 +4922,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	cancel_delayed_work_sync(&adev->delayed_init_work);
>  
>  	/* disable ras feature must before hw fini */
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>  	amdgpu_ras_suspend(adev);
>  
>  	amdgpu_device_ip_suspend_phase1(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6d5d81f0dc4e..2e7c09530ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -918,7 +918,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>  
>  	return 0;
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index b6d2eb049f54..80248930082c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -300,7 +300,7 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);

This feels confusing - calling early_fini from late_init

Thanks,
Lijo

>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index d085687a47ea..c75ce91f94ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -71,6 +71,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
>  
>  	return 0;
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5ac63f9cffda..b11e3eb2b100 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4124,7 +4124,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  cleanup:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
>  
> @@ -4135,7 +4135,7 @@ static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
>  }
>  
>  /* helper function to remove ras fs node and interrupt handler */
> -void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block)
>  {
>  	struct amdgpu_ras_block_object *ras_obj;
> @@ -4156,10 +4156,10 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>  		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
>  }
>  
> -static void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
> +static void amdgpu_ras_block_early_fini_default(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block)
>  {
> -	return amdgpu_ras_block_late_fini(adev, ras_block);
> +	return amdgpu_ras_block_early_fini(adev, ras_block);
>  }
>  
>  /* do some init work after IP late init as dependence.
> @@ -4267,7 +4267,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>  }
>  
>  /* do some fini work before IP fini as dependence */
> -int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
> +int amdgpu_ras_early_fini(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct amdgpu_ras_block_list *node, *tmp;
> @@ -4284,10 +4284,10 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>  		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
>  			continue;
>  
> -		if (obj->ras_fini)
> -			obj->ras_fini(adev, &obj->ras_comm);
> +		if (obj->ras_early_fini)
> +			obj->ras_early_fini(adev, &obj->ras_comm);
>  		else
> -			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> +			amdgpu_ras_block_early_fini_default(adev, &obj->ras_comm);
>  	}
>  
>  disable:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 35881087b17b..3a6f70b75e47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -711,7 +711,7 @@ struct amdgpu_ras_block_object {
>  	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>  				enum amdgpu_ras_block block, uint32_t sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> -	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> +	void (*ras_early_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
>  	ras_ih_cb ras_cb;
>  	const struct amdgpu_ras_block_hw_ops *hw_ops;
>  };
> @@ -825,13 +825,13 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
>  /* called in ip_init and ip_fini */
>  int amdgpu_ras_init(struct amdgpu_device *adev);
>  int amdgpu_ras_late_init(struct amdgpu_device *adev);
> +int amdgpu_ras_early_fini(struct amdgpu_device *adev);
>  int amdgpu_ras_fini(struct amdgpu_device *adev);
> -int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>  
>  int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>  			struct ras_common_if *ras_block);
>  
> -void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block);
>  
>  int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 174badca27e7..1a1834e47b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -116,7 +116,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index eafe20d8fe0b..dd787f5f2f23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -336,7 +336,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 83faf6e6788a..3ab80399d2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1248,7 +1248,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 74b4349e345a..825c331f48f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1174,7 +1174,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..ce70acfbf22c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -5080,7 +5080,7 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 88f9771c1686..28bc2f946e91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1311,7 +1311,7 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index e646e5cef0a2..467283165a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -789,7 +789,7 @@ static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index ecdc027f8220..063b3bafd134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1996,7 +1996,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>  	return 0;
>  
>  late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>  
>  	return r;
>  }

