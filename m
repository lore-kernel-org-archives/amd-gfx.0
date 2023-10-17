Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414A7CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A1E10E2DE;
	Tue, 17 Oct 2023 12:43:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D49210E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZvWEEg/dGYi9bIf/IYC1IeEwBMLkU2YCDYX+s2SLlK+DshSzUBDfJsYc76e/Khwe977nbEtzhcPIvKZMaW7QGqM1R6B2cIxQuW49/tb5sNe25YgBbtgsB1Jr2tmw78N3hc9gwSh+wvIqoClwny8czNdwtHTeeOFz0AV9d5WtsDtikezgoJQYbmdc7y258ogSvE9wqwTWChizwwb4BHMqPEr7lGePWwD+gOMRyAQyYkoDGpxo5LY7R6M/8cOPfcVPwcCfQ5PWAUHaXs2jhpvwyqH5Dq2IRsOFmel5sY0nDor5GduxcOEF2p6AmimYC0ogD7ewqmcLSXxvl4jpyNZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4wBB7HqXXuPumE9TgsVD0CabG/3kkM9POPlvoj/Gio=;
 b=ThumYip067Q1Gkl2867XzrEZ8zSlK39ZspKPiEF7ZShta8nIfo79C09Ew53i3NUfSd4fEQA+GhaB/UNaKK2W46QGoXxxfIWBaKSzu1gDepPhNvdbm26IkDDgvaLM8J8dSca1dQfADIwUNKBWTxbIEeScLMYHEb/gZRcQTTohgkLFB6EtnYpczdNxM1FQ1w4TfUuKBQhebdNWSPLy8I6sDIuj6kAAA4onF26EBoeG6sU55W8CAc/zsy5gldtKIxEDILA8axmpq2UGqYhCSCcNISAZiwS13Dlmj0YO+CI/21ZLPk/UbO6ffFlWxmKrDwUg9EfgdvhUhnvfEyUVe6e+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4wBB7HqXXuPumE9TgsVD0CabG/3kkM9POPlvoj/Gio=;
 b=msexofx798LBvtq9caa5rcHGbgWjpt41YIdKkb1I04xr/HBcumDw8uZEn4M9nh1eC+X+GaQKTdHLaxltUpKrdk3WYyriz5DPhJ5V6/S7U+0y1XrepTeVGZcLaW/QEbCL5kFs9wSixSsz4dhN7QZ8/l3uiGAiVTMZEj/7EGSNfL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 12:42:59 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 12:42:58 +0000
Message-ID: <f7e00a0a-fa67-4391-93fc-402dae14a6ef@amd.com>
Date: Tue, 17 Oct 2023 08:42:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ignore duplicate BOs again
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20231017121015.1336786-1-christian.koenig@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231017121015.1336786-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::21) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: c797c10c-070e-4084-33a2-08dbcf0e97cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKfau8bIVoJjSvbfpR4x1yFEVOM1bWS6JgOd7Vn+wXd62Tqg3wlFJbXCbk7pxarAfwccYFfM3FUUFwKHk5vpCkYvZp8gH4uoXef0rFWmbUvBrOOqSTMoo6UthPK+FhWV5IdDqdgl7eyzqZwWRUfN4LA9A2WvT/LnjgXo0dnrWmNZmL4OmC+Hzs+IxGk/Az45U/JI24S7IGyYki0XVdIAYk1tLorZzxqvlhP40kaX9FXuXKgas4nGdUT2HMDI4FN+GqsX0let2zvJLLchVkh+RL1hsV2XoNy9lUuGW01prXubfXdfAXM8YhN04RER9EHLxvbFUZtAJPWkhKn06v3cJp0n8IZzwWEwChldV1ti591a67cCROapH4TvvwwGLRouRur63acEtIqRtg8AA25KiTjKfLqYoUeqSNhtbxVCzEU8yXQOHVri20zzpHTEztkHef6Mx30H26nhmdpmPywMtOmVbnC6Cve9U9bU+uUrn3FEV3RlXE6Pfg8+tMROykJ5deAzSJttxlvA3Z0FpTal4D8Gya0dLW3b+lZ7dzieyITnFg2hDLt8d5bgEoHwWi/nCk7GtBo1+g4jxOrbRRFPyeObT5ZgISfYn2lLeC43Qr1HXAN6jDA/LxZ6sa/YhAxp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4744005)(41300700001)(966005)(6486002)(86362001)(31696002)(2906002)(478600001)(36756003)(66556008)(66476007)(53546011)(66946007)(6512007)(6666004)(6506007)(316002)(6636002)(8936002)(8676002)(44832011)(66574015)(26005)(2616005)(83380400001)(31686004)(4326008)(5660300002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdsa0VFV3cyWVBsd0NlalgxeFF2dVRnOHBxU0lYdUJhNndPbnlCZkphOXFZ?=
 =?utf-8?B?TVljWkVzNEw4Rkxodm9KWTQ2REZHalJ4NlI0RWFHYUZFb25YUEhPVXF3UU55?=
 =?utf-8?B?RzJnTWFFd29wR0FJS0IzTEZ2TmQvUFZGZmV4cGV3bXVmYTRVUWpzRlBOeEU2?=
 =?utf-8?B?TDJ4ZERRc1phei9CTXhNL2VCY1hSUEpnMFBGQ0crMlBkMXNTV0IwQ24vYVRi?=
 =?utf-8?B?QWhTS3p6V1BRcmt0clFmRzI2WnJ4OWZTdnp1dGVmYUt1MFgvbm96enFHb2Uz?=
 =?utf-8?B?ck44ajFWa3RLUjBJWDdVVnZTNktJTmdTT3ZOZEtpVW9GbGtzOWxvVDhIOExl?=
 =?utf-8?B?TVNmdU5wQjNTUGgxTStGRFBxcUJLZ0tuYVh0UjRnd01tcTFoOENpZjduRFFm?=
 =?utf-8?B?dHN4ZWVMWGNIVHpGSXRmcmNtVGQ3b01MTHZMVE5SK01ZVHRRVEFhVGt3Q1d5?=
 =?utf-8?B?MTFCa3BDVXVyejVIUXpsTjVwK3kzcm02clRqS0FKL3JhNjN6Mkg4Mmt5Y0Jk?=
 =?utf-8?B?cjRsQVZ6WXNLRmlxMGhOdTF0SGV5ZUVPd2VXV1hZdVhMQTNTYmRyWE9DSW5E?=
 =?utf-8?B?eXFQUjg2WDBLRnhlVGsrZ1I1V2hUQVVWVUcwV28yUnlYVmRuMlQ0OWRWc0Rt?=
 =?utf-8?B?M1A2bUJKY1hCWXdoYmxFOVdnNmNqdG90WElhdDNZSitsbmwzT1Nidnd5eSt4?=
 =?utf-8?B?Y3VRZ2d3VlJxalF4SWNJUGZmdkdEUzN5NEwvdk83ZzRsKzMxR3lLRGU2ZDZy?=
 =?utf-8?B?UWUwTGNyZEYyVFhZekR0STk0SXg1TUZoenlwK3A4VHA3aHpVQ0RVT3BVWDBW?=
 =?utf-8?B?VFJIMW45WE5xKzNZa2drSDloejJYOGJPalp1YnVTZUxqbDVLbHZYVWVHc3Bx?=
 =?utf-8?B?UmZrZFlja2ZxTmhxcmxTYVRpaVVlYkhOVld1UzBPMUwyNktkVWQrdGxXbk5n?=
 =?utf-8?B?Sy9aUTJERUphd0JHQklmZVRETHJHLzFlSFM0YTlwVDRpa0lzOE9odVJKYUc3?=
 =?utf-8?B?ZW9iYlFsUkJNQlk4T0h4YUFoM2NDMEhSb3p1anU1SWJKZzV1MmNFU0N5UVg2?=
 =?utf-8?B?Rm5Oekl6WUhta0Vxa29rcXVNa3BTdlVSV1pldGkxVzc2bllEdmtIWUplZXJ4?=
 =?utf-8?B?R1NkK0p4dVVZNSs4SDJuUEJiNXBuMVhSR1dWSHhGcGlrMjlNMmdCeE1YeU1h?=
 =?utf-8?B?WFhQZUJxZjlNUjVTSlhjTEJGa25xdU4waFNOdkFld3VnMWNlblFKbFQxNWpv?=
 =?utf-8?B?MzJxTzFzUk1DV1o5R2REYUZjUExOc3NHLzUrTEhVMEt2ejVPd1FFVEtxOGpD?=
 =?utf-8?B?MlBCVW5OV0lTck9HZm12dHEwY3REWUlxRFZuL1VBSFdBMUw3WXlpWDdEOUFv?=
 =?utf-8?B?TEZ2dWY4Z094MEVFRll3ZGxxSGN1OHJ0cDRVcG1UOWtMTittWGZzMFJuTDFv?=
 =?utf-8?B?c3NybUY2Yk5EcE5ONmxLNjRPcHNzcEZWRCt6LzdFeTVNSVhjT0dIT3gyWEhm?=
 =?utf-8?B?a2lBeDMzekRzaTdEK1FtU3l5VitZYlRGbVgyUWtxN3JBUXRiMlpXWUJjaXBU?=
 =?utf-8?B?Wm9IZnZ0U0VrNFhyVlFJTzZ6cDVzcnc5aFdOQW9RVjljQ2RBUmtwQzNlRmI5?=
 =?utf-8?B?MXVDWGRiWk9WRFZCOWlpVGQweExNc1Jpc1dOd3RCc3lsdjNZcmhJWVFaakZa?=
 =?utf-8?B?MVdrdVd0a2RxZ085REIrdXlROHpmSm8wZHYxaWdJUytBZEhUQWNzUXlKMERQ?=
 =?utf-8?B?SlZNMkpQcDZKWVJBNzMzWTQyZ3Vqb01DR3VBcFF0aVhYSDhjRVdPZFdpMDBy?=
 =?utf-8?B?Zm54S25jdFc5QVkrVjR1aXZ0UmxKUGhORmxhSi9WbHRqaFlMSTVLWWFab1FS?=
 =?utf-8?B?RlA0ZVMrMmFnc1BHdmRSOFVhbjlJNVV6Rk5udWRXWktoWm44RDBpRGVFL01P?=
 =?utf-8?B?cTZsTmovQ3Rwd2JpM2lpcmY2YWgvanFpL3RESWEra3hpTE14SVFxVDBNWk84?=
 =?utf-8?B?NnVqZC9FWDV3cEdYTE1ORzNodG5XVlpaQWpqc2o5MGVHSkJHUXhRQUtqVXFZ?=
 =?utf-8?B?Z3dsZWhPQnFoY1MxK0R1c0JLWTZ6UEkzbUpoVXppc0lQV1NMR2dqV2t5aldV?=
 =?utf-8?Q?ejaCiym2a9b8CmicGHbzVX8B1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c797c10c-070e-4084-33a2-08dbcf0e97cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:42:58.8309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX8VEGlXZpaVxl52O0zA1BQDUlqSUwNuBekWX/L1rIT6oolbb9K42xBq8fHodDI7QKv/nyhgHj5ljWgGqKL1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/17/23 08:10, Christian König wrote:
> Looks like RADV is actually hitting this.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3")

Do you think this will fix the following issue?:
https://gitlab.freedesktop.org/drm/amd/-/issues/2893

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index efdb1c48f431..d93a8961274c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>   	}
>   
>   	amdgpu_sync_create(&p->sync);
> -	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> +	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +		      DRM_EXEC_IGNORE_DUPLICATES);
>   	return 0;
>   }
>   
-- 
Hamza

