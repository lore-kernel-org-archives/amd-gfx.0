Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2ECC77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 17:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BC610E260;
	Wed, 17 May 2023 17:58:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206110E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 17:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JToH3lZ6+y/ZB6T4sfP8A4t4dC3Vf/4Nn6q73zFesDah6LtxxG0+A5ojPXtP6oRP4VwC7wTC8k/1A2EfuB4KSV/lLXFe8TmZiRvsd5MjbxPkOjoklLNBDYpjE6phfn8uALS3YXTc/KDibuZBt16rv0k4EPS9Bm5ITEknXXjTCoOi0+nkffV89aIU6g0Jv9liRmYUviwErZMo7+S42zkkNM2CRoYcoRgDy98DcgoW+B3co8kUgLKhP+UFZ7GBS3gmo/oB/S/h2u9RxoDyDmD6YBuWD2kA4NmBvwmdizYQNWZoiVTFVkAhp6/K3Cz3MP8HuAlSrmkj/LH1lzZ6cXogAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AEiGm6Bw3x/cP5hog4+flRzLBdwwLbpk5JArCYx9N0=;
 b=jZmKJweknC+Svtuk4QzVhju9KszNh2wePXpRujrW1A5vL8p8m7zUrj9Es3uqfXF/QECo3yE2Zn9RPUhwFPVUj1p+teSXM93GLWP4p6iNZ8g2ikuHe2VX5nwLUkj2Ifl4A5tkzfXaLRLSzSqPV/ntVmL47Taty4SzIRDfGzi5yZfKrTWXsfib47Pw5ZT+1nsDzXRFbBQUA68Q62mdq1Q2BrR3d44/oUtRybuAgDjS6dVhg0FsRBcfA1o5bw8vajIzTywpDfdWHk7NdErHsXjNrMeQ293dL1iyxngPcNZ2Gu2b3rRuIHeNwKPBN4aUFHyb+tPuMYeTc9Y9cNLwUSBOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AEiGm6Bw3x/cP5hog4+flRzLBdwwLbpk5JArCYx9N0=;
 b=NWtexJtN+NxzHAkYZZd2YUdeb/cFtGWYGyaX/ZFyEvSjyk7QaKHU0kUjAvGc2LCje94m6SbfReBcn+G5SqeKnN3j4NpgcUvPjz6Uro4JuFxNCmH4S8ulp/NfyBrHuEaqcoirxpOoxlBEwelSmyNZwBeO2yAbL+CaU3YX1AUzYLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 17:58:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b62:38ab:7af2:a4f6]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b62:38ab:7af2:a4f6%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:58:06 +0000
Message-ID: <d2a79c9c-039f-7ba7-6198-4c8db7a3d8bd@amd.com>
Date: Wed, 17 May 2023 13:58:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: disable extra gfx943 legacy flush on rev1+
Content-Language: en-CA
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230517161909.359715-1-Graham.Sider@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230517161909.359715-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::48) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc71592-1262-4593-588a-08db57004458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Op60iNAeLpKBXc4tUcM7vD6ztp0aLs4L+Fx6W0fI/hxOCYYnOiFoM1gFZ/oCTImwYsBz2QAe9vua0nofzcXT6uqo6oPpRfgoqIccdOiQiabAWb4rA4Eo2U+m2jk5MhXyhXy8yPJPo04zqkc2f3Pq2bX7j9cjttdwo6OSLVeD+y+Rm1RSoHH5/77jfHLBwvexzg9PY3qXOctS1LjT3GqFPMw4FXGijTAUoTa427ujwcSkrNgpnOMfWMP59jL8UsnHuAaOrmanPsDvbmUUxsxnag++zZIR3wsDyXLM+0VuPZnnXOwZxSJriWJT82TkGAUHhHFUQ9RFmv0j6Z3NtYUYhZoDcREHk6AtgYoSmhEzGF5hXnfEJAdCb75FAIG2nxpcAjLH+cngEMnxa+40uVc8awaR7j/5+/vGu8bBcUqVddefgfXm9SztMInlwYcsAgpvkNBbBWq/EtpVLeTheZ3x0dqx7uhUxHBYWa3OmXbTjwsbV8MiutGyqqwBsh+s5n46l3NPAOyO6PTBYeDPjRajuCMmxCKmeqpnooYLQdIoruUdGiTg6Sy4lKRs1zq4j5WSmUkRxEXHIfHTl6CWml6kkUUissmtC0bSMYZSKKUsM4Y4QOrw82JY1qxMw98Z5coxKlWUkM3pWmMYKV46UoM0sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(53546011)(36756003)(83380400001)(2906002)(2616005)(66946007)(66556008)(66476007)(316002)(6486002)(6666004)(478600001)(31686004)(31696002)(5660300002)(6506007)(26005)(8936002)(8676002)(186003)(41300700001)(6512007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhjRnRkdktVV0RQakRLbGJZTThVK0pIZmFHYS96aXEzS2VxUmpUSDhzQXJl?=
 =?utf-8?B?ZHgxQ2ZOcm1KYmJqYVpUaC9ZRXJTd1V2ME5nMlNOd0xta0NMb0dUYzRLWjR0?=
 =?utf-8?B?ZmR5WUMySmUzWDBvc2YvVXZRUkRpWm1YWGpSN0tUVFY3VFJsbUIxM1J2UW94?=
 =?utf-8?B?Zm00Ujk5ODlreGE5Z3RSZU9xbjVyKzBpUHhFQTNMSXN3dGhYRlNBRkVJanAx?=
 =?utf-8?B?MlBPZnNhV213Uk1jRkZ1WGU3THArY1ZoNFcxdCs2ZkY3K0tZb1R5S1JEcWRZ?=
 =?utf-8?B?UkRQend0ZnVHRis5a0RscGtWeXhORVlwUElMNVFqbVdoZzVhakpYRW1vNzZL?=
 =?utf-8?B?bWJSaHM3T1JTQmJnQ2lVeHF3Um5XMmNCcFBVaGEwN1dOS0FXTmtZdytXRmhU?=
 =?utf-8?B?REhCd3puN0hzNDdvd09wWWFiSDJtRXVWYm1rVWVENFVUR3YvdW5WcHJ0VFla?=
 =?utf-8?B?SDE2Q20vS21yN2tMelBaQmx0czV3a2h5aWJFdGZTc3ZENDh1N0tHWjhOSCs5?=
 =?utf-8?B?dlMyY1R2V0hBUkdBSVlYWmloSzlyczgraDh0M01JN3YzTnhEdm5Ia3VHUU4y?=
 =?utf-8?B?U1BXYzF3NkZ2aXpiY00yMm8yNk1vbDNEWE43ZEluSFlFU3VwbWRKV3cyeWw0?=
 =?utf-8?B?VjZoMU1KaWxXVmdXbXR5NDBIZnJQdnNEMXFsUlJWWk13ZHp5dGhUWEZEWTBz?=
 =?utf-8?B?Vk9qR1Z4NThGOVBiUW5VMnozRjJ2R09UUlFWTnNYK09SSGtNS3Vmdk1lbzhL?=
 =?utf-8?B?bTd1YUtHeDZDNmtVTVRrbGZhTUFmeHVtUDZybVI3WXBQSU5EVng2a3JlTUZS?=
 =?utf-8?B?UTcwVjhScWk0V1NCZ2poYS9pN2F2UEF5aFBJeEhMN2R5OFlQM3BJY0ZEZkRZ?=
 =?utf-8?B?MHpQYlZJMkM4Q0tZYktTNUc2YWV2N3VvSGJDc09CZ2dla01Pdk96clo5QjZI?=
 =?utf-8?B?UlZJdG41NVNRSGowbXd4RnBTZTQvWStiZ0x1bWpHVWRua0RZZUV5T0FSclFU?=
 =?utf-8?B?ZTB3UFpWM21wNkozdjZYZVhYYWlRQ1Fxb1dodVRXUVBCU1dPMmt0WnJyQU9F?=
 =?utf-8?B?Njg4NnlMZWFBTkpjazZBeE80OWYwRC8xcHpiSjBmNUdKQjNLQk51ejcrM2Nt?=
 =?utf-8?B?VVJpU2ZvcHVCQURoSTdybm1MN1o2d2d4VmFDT3NyeHpOYm85bms4ZXlUMms3?=
 =?utf-8?B?NVcwU1FYZFpoamFsYUVQMk5OdDByV3U1S0h5VGhodEdiVnBxTGtjME9ZQTVs?=
 =?utf-8?B?SzNzZWpnZGFlVHNtblg2UU1MdzNMdlhSVkQ4dzVSb0dhUjdURCtzTmp0S0tz?=
 =?utf-8?B?cDFQemVVZlgyOWV0Z2xFd0kwYlBaNko3S0tkMkVOSHorWHd5dzZXTW9MYzlu?=
 =?utf-8?B?eXVVemhYU1pKUUVrMjdFUDBLQ2h1TDRBaHRVSHR0K3JkSktGREdmTi8wUmc5?=
 =?utf-8?B?bkZvcWZGN1JGZE5HZ3FvdGxhSTZZZkRCVExWOG4waSt2d1lWanBHSU9UclVj?=
 =?utf-8?B?eis3WGg2cHBHMXVIRFNxMlVVdHBuZm9tczhVdUV5cnRuNU5NbnZjTFQycXR1?=
 =?utf-8?B?Y1NPakZ6YUFObjNHUlhiSGIxK1p3UnRaSmh6UlFJRVBkL1FxM0FxeDZSMXlj?=
 =?utf-8?B?RDRrWmxibEtJMVVBN3pUSFRsYjBqWnRQV3g4azFoc1VEd0VDN01sK211WmY1?=
 =?utf-8?B?ZDFiU1o2dU5mY3ZsSE9pZGxsVWNiTmJZQlRRb2NPSkNKem1DRGRPb3Vib2Na?=
 =?utf-8?B?VE53em5yNFpGWW1PSDJadlVVQVN5dWIrMFFRRmdCaEFicUNLeTRyTHVrdzM2?=
 =?utf-8?B?WTREaEtwWmZJU0V1SEZpK2NyblY2SndUcVlBZGJHamM4aXdZdEp4U2g3WTdX?=
 =?utf-8?B?ZGlWM1hsaEsyRU5EenA4OVlBcmN3UmI0UVdkTHRKUzFtaFAwaVc0dkt4dGRJ?=
 =?utf-8?B?Qlc5bjdsVXROWUt3V1F5TEJCSjdMVHJ1QXkxWE9qMVE3NEg3T3c3YmpIaWNw?=
 =?utf-8?B?VmYwM2FXSFZFQW1pUWVZcG9oQTQzdVRKTTFHSmZNTGUzTzlaWktGNXI3bGtu?=
 =?utf-8?B?TS9HUWxKMVpNWlFBTnB5QWRMR2NMc0RUcUhBazJGak5PZnZ2YlltT3EvbXNH?=
 =?utf-8?Q?QoWM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc71592-1262-4593-588a-08db57004458
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:58:06.3221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6y0ncPHL/3VudpoHWymcTkQCymH/bd4ZS5VrskKdRjrqCrnbiapVvQITaRW20NjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

Reviewed-by: Philip Yang <philip.yang@amd.com>

On 2023-05-17 12:19, Graham Sider wrote:
> The extra legacy TLB flush mitigation is only required on rev0.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 38e4828f574e..ba8251b6b279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -844,11 +844,8 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
>   		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
>   	} else if (flush_type == 2 &&
> -		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
> -		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
> -		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
> -		 * stale translations even after TLB heavyweight flush.
> -		 */
> +		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
> +		   adev->rev_id == 0) {
>   		inv_req = gmc_v9_0_get_invalidate_req(vmid, 0);
>   		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
>   	} else {
> @@ -993,11 +990,9 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   			kiq->pmf->kiq_invalidate_tlbs(ring,
>   						      pasid, 2, all_hub);
>   
> -		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
> -		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
> -		 * stale translations even after TLB heavyweight flush.
> -		 */
> -		if (flush_type == 2 && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
> +		if (flush_type == 2 &&
> +		    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
> +		    adev->rev_id == 0)
>   			kiq->pmf->kiq_invalidate_tlbs(ring,
>   						pasid, 0, all_hub);
>   
