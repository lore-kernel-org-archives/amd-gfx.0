Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD1CE68968
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 09:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF0B10E84D;
	Thu, 31 Oct 2024 09:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqYBTMBa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654CD10E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 09:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf9FiwTtA6CL12bkd82BGaBE0zsc9ExdQ7lnCxCJUb4BkygcBLUJgVoQkbVkgVstCVcyKvcLuusjOdaO9b3VjpVet3hU1+9+hz4t1rM/2GIsPEVxiq71yjq5WSHPO60fIQzHmKEl6NAeRsW1qNnOXCle/RdwXSXXUlqmCoDGY2npqxLjwbkahgQN6wU5AU3fQDET3vnFbnrsZLn3xY+CbT/YWzPqB4h4fEjpMwi+2GQJXSuqZsZpgpVlg5Tke0hWmUwe+SMRdnNJIzbMHpHF3WDXxi6Tapx1HqnDw0rO1Xt/QmSm+DJCfS6JIAGH9otWasKT4a5lK0Bv9ZyUFsdurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7mSHdeyHWXiM5s2lSaMJot/XPCIvjVf+UJg1z7igbs=;
 b=EVR74aac1vQWMCygPfwmvMtaGh8zsCTFUH6S/MHrMIg0R776ZkRVU59gOeDBgWNV8ByfCTdBjPNualfaud4VYfe9T9PzpQ6ksL+9W+Y0B8PbFVYBDQCrYO+z6Jb5WdWQLbwSv51/hSgvDuJCAjAyX3Nlpy01OBHMSDZd0jiGEIZn8ucvHnmH5O2eboxq+IC1GK3zIyNqd5qhsjBpr/7IdtYYQKJyk8KKTYJCLHMwe50Hokua6jM/o7ylxTax1TAl85xTjj0UZHHJfSDszGd8oqvCLoE3v8W5L9LQgXgdnTnj5m9qmcThM6oSi/lB4SQHUhJc+4JTJuxHDQ0lcVUr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7mSHdeyHWXiM5s2lSaMJot/XPCIvjVf+UJg1z7igbs=;
 b=SqYBTMBa3dntChtbFWKQ2BRHtYuAanjA/rFedtjZ39DI4MMLLaWmPLCyHYX4WX2hLVD+j1juk0w+dIWNFPUO/ELJHrmExbx9s9PimePJs0dTgh0dc762y5y6fVHYX4H+5U0o0cwQ7z73+BWKGZENL2cJ8Wp4a2EG1PFRW3Xoq3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 09:47:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Thu, 31 Oct 2024
 09:47:02 +0000
Message-ID: <446d84ed-9a45-4125-8618-9a1ad3dea5f5@amd.com>
Date: Thu, 31 Oct 2024 10:46:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] drm/amdgpu: update vcn_v1 devcoredump on per
 instance basis
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241029135020.2494491-1-sunil.khatri@amd.com>
 <20241029135020.2494491-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241029135020.2494491-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d7bba0-ed42-4623-ebb4-08dcf990f8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUdleUFveklFTVdkNUtZTVlLdkNTYXFSNWRja3MyK2pvRHMvbmJrYzF2L0tx?=
 =?utf-8?B?a1hWSStCYnhlNUNPYWdKei82ZzlqR2t2eG5IVGMxdDUrTUQwcGRKdTN0elZs?=
 =?utf-8?B?TjMyaVdIYVlQMTFOQm1vK2dwN0d0QWlZT1JRM2hwUGFPa2NaMUIxQ3U1K2dD?=
 =?utf-8?B?MzFnZ2ZUU2ZsbXhJeWZrZlFhUUJKbmIvQ2pGdk9JcnN3cnptbHg5bWloSlMz?=
 =?utf-8?B?eW1MOVNJT2dOWmUxejFBZWY4VXl4b1pQbW1XQ2U3TVdXQUhISWV0TTlUZW1Q?=
 =?utf-8?B?cjhMbzR1ZitLdnhvN0tKSjE0bitsK0FKUjA2ZTcwR2RWZTM2c1J4T2RscmEv?=
 =?utf-8?B?bmJJNkt5N1AxK0l6QXJCV1hxd1IyY0lKTXo4Y3piUmswQ2VqRThBMDhVL2ZD?=
 =?utf-8?B?NUFISVhrZmR6OFh1Z2I2N1RsQkpoQTRBVG1YbFg5RW1WVHZnOTF6WitjOHBn?=
 =?utf-8?B?TCs0L0FiV3dqclBJMjNIbTMySmkyeTVJa2tMQXJjSVZZN3AwRHRROUF3Uis4?=
 =?utf-8?B?Vk14U1lpTjRiUU1XdFdsTFowdDRJS3dDdUhDak11c3FnU2FqTEtMMGk0YXB1?=
 =?utf-8?B?SkJ5Qm9qSUFSTzN6LzNuMXhoNXk5YUZyL014OElQYXZ1WW5tZDdETFoxV2dF?=
 =?utf-8?B?Z0pRcHZOODhYMkpYczVuU1B5em9MVGVjWjZlcmFMSk5mMmR1S1NoMW5qaUlC?=
 =?utf-8?B?NzY5Tll2SkY1SEJ2K1VEOERjM1RacWdUMDR1QytBTUFzYnJncU9kSWxmcFFS?=
 =?utf-8?B?UkpJTHRQVktPT3VodFBJR2daM2t1UjVjSUROcHJIdm5IWmVESlB0ano0dmpi?=
 =?utf-8?B?ZjlhU3VIRXJiZG05VksxeHNZckorUVlXeW5FMUdSN3htNkVUN0liOGNjUUZW?=
 =?utf-8?B?cGhHTlV5eDNienhSR2FTUEJRSVRIcVkvMEkrT1U4aURJRFRPNUE4cWYyNFB2?=
 =?utf-8?B?T2dBQ1dYelNZeEREYnBTQ2NsOEE0aHJiWXIzZnJGZjJlZU9acWRCMC9EUTFh?=
 =?utf-8?B?N0h3WGVsWHBiYkhZbVJObjE2bGFLWmp4Q25OdFYzZEF3NnVmVWZrbGI3cmxv?=
 =?utf-8?B?WWcyNEU5cDFsN1ExMUUvblU3V1k3ek5DVmF1RnRiL1NuT3VSazRrMDZ5dEpw?=
 =?utf-8?B?TkwwSThLekVkTGJlR2NteWtqWnhjaGxLMFdkb09IR2pvQ3RPTnFEVElYQXJG?=
 =?utf-8?B?UlYrQTl0elRBMk5TWUgrK24zbFNnSEJCajJUY0JZc0FTellqSW9lYXBLZUJ5?=
 =?utf-8?B?NGpqS2hmSEpmZENTRXBsbjEwN0NST0MveGpOTmxUc2dhNU5uYnNwSWl3TmY2?=
 =?utf-8?B?NnpmYk43bC9jR25VeGpFR0pvVnFURmRlUEJKT3d5UUZ1RlNlUHNYYjlOMTVN?=
 =?utf-8?B?YTBLR1VHd0owSGszSGh2elpaTW9TU2s1Z1p1UTR1cENLazQrWG5EVWxYWnZ0?=
 =?utf-8?B?d3J6eUJQNnRxenpxbENjVzNjQzRUb2lsVXVjZHUvODAwcnFVaG9IQ2thbEVV?=
 =?utf-8?B?ajk0NWl6UFBUcVJQREt2YXlIR2QzdVZ4QTIwNmwvZHk4VXd5czlNR21EYzhv?=
 =?utf-8?B?MUpTa0VJcUE2aFB3dFFiVHo3anhaZHl4YnNRcUVpYmlMUWhRM1FacGJOL3hQ?=
 =?utf-8?B?RDZ1SytMM1FyQzRJK1BKR0dnbWxvRE9abGpTcFdJOHZidUNtZGxJOXdZQlJZ?=
 =?utf-8?B?Z0lQTEpqOHdncUhRSFFnd20vVDgwM1k0Yk92Sjc3djF6cWdISG9BRFdZYTUy?=
 =?utf-8?Q?b82NafmjD5fVL09mPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXoyeWxZNnFidVBWdXJkbWEwUGIyZVVpZEtScUk3WmwwN2lUYUdrc0gwRnFK?=
 =?utf-8?B?em5iOCtvRGFKTlo1ek14K3gzV0plUUtsK3NNMmF4US9qU1E3VVpkd2xlUVlq?=
 =?utf-8?B?SzVMNUF2Z2R1T3hHSklJeHozeEROYlphQ2tHVDZ3VG5IV2Mvd3VVampqZUFM?=
 =?utf-8?B?eEcya1Qyd0xhR2x4VjFpdDNaMXdaQ1o2T0FPYTk2NzZKa2lwaS80cWNoMEh1?=
 =?utf-8?B?cGY5NnRxVFlCcjZIL1B4cGs1NzNjQmN1VTQzdWdMUEhJenNOdVljNXMrT3B0?=
 =?utf-8?B?em1leUlZSVlicDZucG1nWGIvZ2ZDcXAvRGlwNnlrY1RtdjRIUmRGS1p0a1Ft?=
 =?utf-8?B?U3E0M2ZlanBuWG5wZUxacFZZWTk5Nzg1dTJUYitESXM5bmVpTXEwVGVlSW1o?=
 =?utf-8?B?Q21ZZ0xwWmhTV0RNOHRqUEx0SEhmQXhwZldPdllwWWxkNlNCRWNPR1BXRGZz?=
 =?utf-8?B?a2d0UjFTRWo3Rzc4dzBiclVOZTEvM3RnR0N0dW5ORGhRN2hTZko1TE83MHgw?=
 =?utf-8?B?VU1Ec1NkTEZOTTBTWm5ydDAxWlBsQ0FieE91RXBNbUFNSWZHZGVJOU9XbENH?=
 =?utf-8?B?U0hKcUhncmNBODlSTWZ0L2srTTI2Y2h6aGZNYjBmMXhtbE5PRVU2Y0toMDBs?=
 =?utf-8?B?YXp4RGxWMkNWbzRIcExYbVArdzlHdTZXUU9COWEwZFc0ZU5GMFMyNGpaK3hm?=
 =?utf-8?B?OGhlZUY3bTVqNUJCS0xENkM3Rk5iWXJhRG9vbms3Yks3dUxLOGxHUHBJQUpW?=
 =?utf-8?B?MUpzSWdlOTBQM3N4dHFvb3NIbE0yVnJrbWhWM1dHN3JGNG9ZU3FmTDlyVG1v?=
 =?utf-8?B?aGRBd2p4VHgvcGNxdXJUQ1piQ2FjaEFzajNMT3NtejdlR01TWlJSU1dtUDZN?=
 =?utf-8?B?a3NYdUxKbytEZjFObjg4ZHNOaXlDUGNYL0diWGliQ3g1OTZRUlBtTlgrQVB0?=
 =?utf-8?B?VVpjSEQ2SlhmT3NhVVZtSzhQRklqcmJnL2FkVmdTbXVXTEN3YWNJSDQ0YzVv?=
 =?utf-8?B?Q0tocHRTVXFTaEsrZkVHNm5RTGVJNmRCcDVaODhuUVk5R0JYeG9wd0JJbUVx?=
 =?utf-8?B?d3QvVUVjL1ROMTNsRExCWGxnYUF2dnRkbmlYVHB0U1RqdElUazBNNzFrVzRn?=
 =?utf-8?B?MWVZODdPVUprRy90QTNaODg3blppSzk5QkIzVDZBS25IanE4SjI2dGNPYU9v?=
 =?utf-8?B?Rk9jWDBkNlF0QWhLczlERExHc3FUeWkyTnVkWk9kNzhIQ1kvYnUzdXZRTHV1?=
 =?utf-8?B?bEdUbjBhMUNNeWdVSWpyMEMvRXVoRjlyWjZsbjRwZGIrV2ticUdteUFUZWVX?=
 =?utf-8?B?MlJGOXp2OWZZSXc3OU5PQVBTRWx0WUVad003UitXWWFEV3o0bmVhWXNXejlt?=
 =?utf-8?B?MjB3c0prNjh1d2FBL3N3RTdIRHh5NjZ2Tk15NHFnVzFHb2VHQ1lqOHY2Zm1h?=
 =?utf-8?B?WEM3RHBkcWczSkUxS2dZQnRNbVc1RElIdTdHdUo1enc4Nm1teHpYOWg4OHYv?=
 =?utf-8?B?NUFIeTd4d2ZVVDlDblYxd0dNVEVmZ1NFUW1hb3AzMFpqZ2xqSko3QkZoTFJ3?=
 =?utf-8?B?TlJud0xreFEwSi9PeDRqU2dZOEtyMkswbjcrL2RDbWVZNHp5aFhSMkZyWXFj?=
 =?utf-8?B?aS9ycHZmc2hzaTNpZXEzT1drQ3JKOTFVVGdnL2JUQmo2Z2plaFdHSm1jTHA4?=
 =?utf-8?B?TGdtc1l3d0FtenA1ZmxyMlB3ODhnanpwZGNKWkpiVExBbVUrRHg0UXIzYjNN?=
 =?utf-8?B?NDZ0Mk5sRnhOVkZ1ZTZkZlltVXdBVm1kZmRWYjFGakRBajI2TnJMemtKRFRm?=
 =?utf-8?B?WVFjRGswNEwyU1FXTE93OFgzd045YjM4d1hTeGR5R1NkcldXdWZ0MDJVbzJL?=
 =?utf-8?B?azlEdE1uamthZUZlWTUvRU5NRUtTL3pGc0ovUlRKeXV4Tm1SL0tKWlpybEND?=
 =?utf-8?B?aCtFNUdzMTl2TjdmSXlkMWx1YlA5WVk1bzBUR2N1VmVHbXp6aXI3Rkp1eXlU?=
 =?utf-8?B?TlN0MHVaUG9iejZMM2NXa0lZUGw5S3hwQmRDWEYwcjMyTEdScnJzRFVMRU50?=
 =?utf-8?B?c1VQRVAyQmdZTVZGejVhQUZjMXFJV1pkMURXZ1IzT25rZkQveFM2TzZycFJs?=
 =?utf-8?Q?ui9qtuljamqduez45w4VaLP0T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d7bba0-ed42-4623-ebb4-08dcf990f8c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:47:02.6389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX/sBlnWSBjVdJavGCBzS36TiFHqjTeeyvH0l45bJxnTeLH86+EVmrWn5hbgdxv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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

Am 29.10.24 um 14:50 schrieb Sunil Khatri:
> vcn code is restructured for per instance basis. Each
> vcn instance is represented by an ip_block and hence a
> need to update the dump and print functions for each
> instance as an IP.
>
> Existing way was to capture the ip dump for each instance
> in a same memory dump but now each ip_block of vcn is an
> independent one and its memory is independent and handled
> within the ip_block now.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 77 +++++++++++++--------------
>   2 files changed, 39 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d4c8cc3c1730..ef564ddcfcbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -392,6 +392,8 @@ struct amdgpu_ip_block {
>   	const struct amdgpu_ip_block_version *version;
>   	struct amdgpu_device *adev;
>   	unsigned int instance;
> +	/* IP reg dump */

That comment could be improved, something like "Memory to dump IP 
registers and state in GPU reset handling".

Apart from that feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com> to the patch.

Regards,
Christian.

> +	uint32_t *ip_dump;
>   };
>   
>   int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 7638ddeccec7..f31fdd620c86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -203,12 +203,12 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	r = jpeg_v1_0_sw_init(ip_block);
>   
>   	/* Allocate memory for VCN IP Dump buffer */
> -	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
> +	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
>   		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
> -		adev->vcn.ip_dump = NULL;
> +		ip_block->ip_dump = NULL;
>   	} else {
> -		adev->vcn.ip_dump = ptr;
> +		ip_block->ip_dump = ptr;
>   	}
>   	return r;
>   }
> @@ -234,7 +234,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	kfree(ip_block->ip_dump);
>   
>   	return r;
>   }
> @@ -1933,61 +1933,58 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int i;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
> -	uint32_t inst_off, is_powered;
> +	uint32_t is_powered;
> +	int inst = ip_block->instance;
>   
> -	if (!adev->vcn.ip_dump)
> +	if (!ip_block->ip_dump)
>   		return;
>   
> -	drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i)) {
> -			drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", i);
> -			continue;
> -		}
> +	drm_printf(p, "Instance no:VCN%d\n", inst);
>   
> -		inst_off = i * reg_count;
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	if (adev->vcn.harvest_config & (1 << inst)) {
> +		drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", inst);
> +		return;
> +	}
>   
> -		if (is_powered) {
> -			drm_printf(p, "\nActive Instance:VCN%d\n", i);
> -			for (j = 0; j < reg_count; j++)
> -				drm_printf(p, "%-50s \t 0x%08x\n", vcn_reg_list_1_0[j].reg_name,
> -					   adev->vcn.ip_dump[inst_off + j]);
> -		} else {
> -			drm_printf(p, "\nInactive Instance:VCN%d\n", i);
> -		}
> +	is_powered = (ip_block->ip_dump[0] &
> +		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +
> +	if (is_powered) {
> +		drm_printf(p, "\nActive Instance:VCN%d\n", inst);
> +		for (i = 0; i < reg_count; i++)
> +			drm_printf(p, "%-50s \t 0x%08x\n",
> +				   vcn_reg_list_1_0[i].reg_name,
> +				   ip_block->ip_dump[i]);
> +	} else {
> +		drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>   	}
>   }
>   
>   static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i, j;
> +	int i;
> +	int inst = ip_block->instance;
>   	bool is_powered;
> -	uint32_t inst_off;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>   
> -	if (!adev->vcn.ip_dump)
> +	if (!ip_block->ip_dump)
>   		return;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return;
>   
> -		inst_off = i * reg_count;
> -		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> -		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
> -		is_powered = (adev->vcn.ip_dump[inst_off] &
> -				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
> +	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
> +	ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
> +	is_powered = (ip_block->ip_dump[0] &
> +		      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>   
> -		if (is_powered)
> -			for (j = 1; j < reg_count; j++)
> -				adev->vcn.ip_dump[inst_off + j] =
> -					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
> -	}
> +	if (is_powered)
> +		for (i = 1; i < reg_count; i++)
> +			ip_block->ip_dump[i] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[i], inst));
>   }
>   
>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {

