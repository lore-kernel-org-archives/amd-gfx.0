Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD4EC2D0CC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 15:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F8810E0D7;
	Thu, 15 Dec 2022 15:05:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98A110E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 15:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7ZesMupyKhmxbyEhN/xQW99m1F26jjTKlHj958gOwwBwqn8rU3HsXOcXlIaXbqz1HRJEMizJD6izf8dPPHPz4sOKM1PY07zP0I7kspkpN3bqi/vz4rgfP7w3u9PROn8hVuvzzxMGuk/hlxxQtABrOa+Fh83cRxpDStcAAI6DBQ3ae4D37YAW5qL0M8POUAaD/E2t8N9ALJi3QD7+vWG128bjJRtT4Uxw2NpoNJFscsSF2GerkMVSVFlQDBSiJicBc7avjZhfU91tRvv4FTTOQsEHiMxwxMa3yRFi/zjGlrVJ6SbAotZUM6kTQQqavNmHvmttavAD2cRwcQzmbFk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s27M4cHbq9TeiKxddn+C+L2rM2IPTONTZ98lMteWIM=;
 b=mMT3vqmJGVgIjCiT8dIvDY7JNVhEMUU6Bsr6j0wIogl/8IKbw4w7VaIWH1i2FvVvMiiI8oIJB8hOrpvi/Vj8HLNa1CdJbAf5b4GQhGT5v+JXgvHz77cIBQn5EzBLLs8PQwbkCnhjUXTGHN7tjLNdRcu8jb/jEr07ccTIyFLHWIlJYzf1MXW7+KRDeQvHz+xYndGn9CI/UGdRBNjSy9zQSfVBDv8iHVoiGQSNLVtFUu03xdOSH9xGkltoZpwblVCQGNPZ3TzbZ2J6YfuboAHVUO9ksBYt4KJZEtDVNEfICyzStIInoXCONLPrqBEZUzIUd2Mtu4vljGRxzCNX07GrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s27M4cHbq9TeiKxddn+C+L2rM2IPTONTZ98lMteWIM=;
 b=Tum8szYopduuiksj9rE5jUsVwM63dzxRi8cCvPuy2nY1WvTnYutEGyzkKCNmYGk3eGcvxAq3cIhK2OEjodQbVhd0l52p77iI6ekOHbZirs7u5FPZ2guLMWDulr0E5vOxhYE3ZCMbKKvy9Euy4LkbL4v/G2gIsuLEucdXu7Aon4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.12; Thu, 15 Dec 2022 15:05:37 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::b07:2f2e:459c:3e02]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::b07:2f2e:459c:3e02%9]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 15:04:53 +0000
Message-ID: <867ec798-828e-a946-0d1a-50b2c23990c1@amd.com>
Date: Thu, 15 Dec 2022 10:04:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
To: amd-gfx@lists.freedesktop.org
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
 <20221214221654.1625194-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20221214221654.1625194-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::37) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: eecf72ac-a8f0-434f-0508-08dadeadb854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKOGKx/5yoH64D4bl+sAKs6u+phiwTcOm1w49WII/ZVsrpe5C3r8gvCMBNh9srR9UrIdoVshvG5khiEuiQ0zYAfHcPvkBZxgJhdc+naecSCR1kbvjB5qH+BfrbS1xwtoBQe2zDFDeNO3UzQryFWIXxy+ZekdLuHpgxZipjZ2wIg9Y6kpxwrPZwzIj6W+DVgOOjBuCHsoNKxZEDyoI1TixpiHp4nZFpUQtTOzngMy/O3G4/gc/K1UoPe6Rs2OUDs/i3q2o0XsHafe4KQgpEJXPQO5clET3EETqvM1xM7OwKDtADkyParqH8Gu1JFUDo7oZU/LGWGnzgOIXG5mspl11JNDUoEe7OihKpmyYn89m6WyJmpHnKVoLL6MFkMWbD+B3LQDAvdmajRd9/w/WRCZip8NBnNiqnTG9AvIF0kZrT6pdW+d0uq7JGiG531hoVk1LNgLebEk8BfM+qR2IKKdBuH90n1GHj7s4XcqWd4GNK4lJhiBZyj6tjU6eYFX2c7C/Lyl/pKZ7pKiUbMDgQrRFq53bp7C2/1UsJD2NOL+saV+lkQNfAC0SjUDHijBtXtFaJCGZ2KxPGdNtrLYceFqOhe40NgZahHbZN0W0tRuGHZO0gQLHCyle4wqdQNiIDFkc+n1/MY0IPKMW3NTGAdOksR78VFRjMOvHbKkTvTdDUk63fjKIn1s1L42rBKEN/9swgFyZWQBtSU9taV7LSM/rF3/UhTAjKhNdO9OXF4sv4Pt6yxY4J22dIBfW4UaCLAtRL/OfMr50QRlAzZW4MctkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(86362001)(31696002)(66476007)(66556008)(8676002)(66946007)(26005)(186003)(6512007)(2616005)(41300700001)(478600001)(6486002)(53546011)(6506007)(6916009)(316002)(6666004)(38100700002)(8936002)(5660300002)(2906002)(83380400001)(15650500001)(31686004)(36756003)(32563001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJvaXZZb2JHQndub2U0dTNxRTN1MEdwY0xWanZHZ0FjTEtGaDNwdERqUjRC?=
 =?utf-8?B?a3o0bjZtck5WeWJ1SXZDalN5dzlad1U3ekRlMTc5ZnQ3c3QzQWVXSi9PZzVJ?=
 =?utf-8?B?QUdBU25CR1k5L2ZSeHdySXphb25YU1VObithd1dyU3N5K3FUMmNVVklpOTZU?=
 =?utf-8?B?OExZOTZDRE5nV0hqR2laTkgwUy9UaTdiTm1KaVB3d2dJaHZ0bjk1YnBYdmox?=
 =?utf-8?B?MkZJK1lHNzhlekZZT04rWFFKb2hXbW9nMTVUV084a0V0a3hFakRYODh4UWRD?=
 =?utf-8?B?TmR4Njk1Q0xyd3gzY1NSelFqVEhPWkMyVTQ2eitsc0x3eVFJQ2FCVkxVU3dz?=
 =?utf-8?B?OTdJV3l1d3hrVWdCQkpXQXBEaFgxRGp6ZDBTdHlEbU1DL213V21xYWozQndl?=
 =?utf-8?B?cWxqNHJQYnZmbWp4MlIyMUFjcGhIcHYwdkpvMUdqdmk3QWpiYjgzMzRrc21T?=
 =?utf-8?B?clQ1ZVErandoVGdNMGo3d2VMV1FlRWtTQ2ttZWpoV2o1T3hYWXRZTUp4TUtY?=
 =?utf-8?B?dlVNNjBES3Rzb1hIUm5mWW1mZDZranlWUDRNUGZidWgxZ1Q5QkNYU3htUVl6?=
 =?utf-8?B?ZDNKOGhRNWJ2dGxLbTNOVXlWUUFyNXdFWmFHblVuT0tNY0s3VENHVmM1ZTZ3?=
 =?utf-8?B?NHVhT0NaUW9vVHAyVzhtUkx6UlNnSnQ2VG1RVkk2VmZ1RER3Snl3YU5RSito?=
 =?utf-8?B?ZUNIVXlxNjAxZTBqblNCTFY4b2ZMdE5lWWcrMzVSME53alRtTWNjOElpcWdM?=
 =?utf-8?B?ZVhCUUh3ekFLK2ZyZ2Z4TDJ0Y3JBdXpKSGFQWGFZYlRvczB3aGRkN2hiRXJX?=
 =?utf-8?B?UU9Pc1phYXl6OFd0dEtlNzdISzVJUm1YaEhJYUQ0WitocHE0dFBjRmE1OTBM?=
 =?utf-8?B?MWtsZVorOXVXYnE2QWhYTVF1dDhCSUl2bWxqeHBxQUtGMThSMGtZYW5OUXFi?=
 =?utf-8?B?YmI4YWRUSEVHMUNMNjl3MVhKLzFmaVdCYmFtbllOTVR4blhCMzJjZlNtc0RI?=
 =?utf-8?B?NGlYekpWd01sVWpQMlhsT3NXdXBvWXo3NnBsRGJYTXN2eHJNbGU1NG9ZeHFP?=
 =?utf-8?B?VUJsWTBSc2s5RjFZVTlUSy9SQkxDanpvbzdERDA2Y1NwOHVMbGgvTHhKUDBn?=
 =?utf-8?B?bkF0NXhKMS9oRFdRd2hXTDBOZUM0RTJtSUcxUlA0TE5iOENLSi9NZDM5bGpF?=
 =?utf-8?B?TEtyczF5OWpvcVlHdzQrcU1vY09iL29DRmtXa3B1Zjlob3VGQUNFa0xiS2ds?=
 =?utf-8?B?MTlWT2VvV2ZZSzRkOVh2bDh0Y3NscmNCYUFVQlYyQjB0UzJXa0RtTGtnZDNm?=
 =?utf-8?B?Z2ZFN2xSYVNxdVFVcCthSGpLUDFpUmt1QnFrdmVNNGhZa0RweW52bHZMR1pv?=
 =?utf-8?B?eS9ZSTdMZ2VQYnBreGNMdWtSN1hqajVGN2hkcG5veDFEaGhvbXNPU3N3dlpZ?=
 =?utf-8?B?SXQ5QUU2UHZlY0JXRENsYVpKcGIxa3kzcE1hNTVma0VkRmVub0RJUHNJYWFw?=
 =?utf-8?B?WW96ekN5aUxJSXNuVUhlYUhDZHZYNnNhZEN4Q25qQytoTGMwYjYxQmMvcm1i?=
 =?utf-8?B?c3QzdzJCS1lGMkdKeUJVK1VpellwRFhRREVxMzlCS1R0M1g5WWZsTkcxeW5T?=
 =?utf-8?B?aHJVUUhrRktzcnZTdmNudFh3RTlNREZjeERYR2szQjRBNzRQZ3JOd20wNzZ1?=
 =?utf-8?B?K0tWQThYVmpka1E5TDFIcVBNY0lZR2lTNm50UWtOSUJYZER3cU5IeUU2SVdK?=
 =?utf-8?B?OWhrWkhjK0V2VnZxVzh3ZUMxVDJyZWRHOWJPOE82c0RrcUpCaU5JbHZGSGFW?=
 =?utf-8?B?dFIxRDh3SVVjZGRLNGRrd1h5czhDcFZSVWs5SVNTWjdaV2ZFTjBBalc0ZXF2?=
 =?utf-8?B?WitMTmZYemgyL1NGaG0wVHlxdnpEVnVvcFl0eWVNZGhwemZidzJ4UitUV21V?=
 =?utf-8?B?b25WM0RPT3I2QmpKWVEwenRxNW5OS01MdGkrSHh6MXJqbWw1RjFQU2dDakl6?=
 =?utf-8?B?MlIzSnZGMHFOL3VuNHo0MWpLVEhVWEJ3VlBSSjdkcm9ZMU5pS21qMDRHRVgr?=
 =?utf-8?B?cm5kaDJOL3UvS1VkV3dYaXdFVW01M2pxaHdZOHVrVmRiQU5QQVZPY2hjRkRu?=
 =?utf-8?Q?mGxLib0pRvTR2LxfwsGCJyq0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecf72ac-a8f0-434f-0508-08dadeadb854
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:04:53.1132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD+8N0Ma1BPJ3HZYYEOGct9Cw5I3LlpXIs5L8qONqF9SOq6saYDk+Mal+oZu+HoL48JuIe3dkcYlnlLPAIkSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

Don't we need a similar check on resume_phase2?

Other than that, looks good to me.

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 12/14/2022 5:16 PM, Alex Deucher wrote:
> SDMA 5.x is part of the GFX block so it's controlled via
> GFXOFF.  Skip suspend as it should be handled the same
> as GFX.
>
> v2: drop SDMA 4.x.  That requires special handling.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a99b327d5f09..5c0719c03c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
>   			continue;
>   
> +		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
> +		if (adev->in_s0ix &&
> +		    (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
> +		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +
>   		/* XXX handle errors */
>   		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>   		/* XXX handle errors */
