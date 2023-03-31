Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84607C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F7E10F0F4;
	Fri, 31 Mar 2023 06:34:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6DE10F0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrPTSsKwkLXMwnXixOXHV8uHqyCF2ZfMzPDd5hiNNfKe6rvTrGiUWvSxNby+V4Fdd8B5if6dy2tVJ3IEcuO+rA0OyFNkAZNbikzzkYzqEqWBLdYyJvm8pwWkaPdHczzqvpEpThEt3bfsX2SD14MBMPJ6hZZRUxaPgGUoTz5W+VvLtiP8p3moak1lnnVyZPZ16SNmqGBXX8cGuGavoYPc89qLghtDDHpBtc18sx6D5sjKbe91GfU1/5bDF4aBCPycuifwUIPAq0Wms7Hwd0493YRlX9WebM4YzSErvWtU6RCfDGLAqsvwoSmYhrHAsW2FwJL0CBJfTMPiYVpmc2huuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYkmyEDzUAWmNHIgfYq7/rtum9CX0eUp9bH/1IWP3C0=;
 b=h6Tm0uq/a2XM+nnIaNpzJKJE/gtXWuOU8WziHw4GUMOYi36JpnHvI9Kly9ZufnlUOoKUR+RoaLiPMaG+Zna5zxhDVl9ZrnNtQeXA/tfJ85VHNgvrlRQ+VQs3HN7eDsnTEKTotCK6QX7U/3C72fSJHIos6fg0FZFl02vJx/ZRRR4KtbRuxGKywOFV23mA39fBV6jFDWv2G3XR4CvEIZaNT+j/tAMVc9uBPPD1gIw25254/lD0lu+EkXySTD+8jMg+ZR1VPWPxJG5ehuJnCVJOzduehJj8GuEFgyQSYUW4jI4/DGobpiBOD+x1ia/12yU04ONHV+NHO8pioH21Bc6CHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYkmyEDzUAWmNHIgfYq7/rtum9CX0eUp9bH/1IWP3C0=;
 b=GRkrisE6CxbWzW2BiT+njpTffLH2d5mNgj+bNVC+tgshiUhZHNCS7af+lU4L/I/3Ij6xccKwpCXjmygEBuXXqCgGR29n8eorz10Ba2Ia8sWkcJX71f7dsVTPsF5s+U/5VEWXWYFJfxxlOMWMo6EXXzqrmFA7HLARbLmofEQh384=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 06:34:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 06:34:51 +0000
Message-ID: <ecf2a379-4b8d-a168-f555-26f66d5d5e9b@amd.com>
Date: Fri, 31 Mar 2023 08:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/13] drm/amdgpu/gfx11: check the CP FW version CP GFX
 shadow support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230330191750.1134210-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c58665-a0dc-4a49-6ee2-08db31b20804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcbnTzkd3IaoRcJ2poUlkbIzj5iQsqWWBB+cj6sZ2XcvhJTR1ltg7XhifBb9EjpjB09f/2QdTKAcXlzhLsAY93AuP1gKjKDQoZlp0jFSEL4Xw/82GMuSiWzX4Fe/7qCEvPBOwtrgrIiBJ5RsOOuwZtbo9sqYqnYAEdQ0i3kgd3c1abHNQezi1onZshVaWL5h/wHZpfAoC4Zd/eT3OGI2ndKxTYz5qlxVGXdmfrNDkJZfvCwvEpmG0A/t9ggRPBw3ZIEqSwfBGW20W3MQrCtD3ijUsl85saNVvlCdvxFywZHoRKqV1WlFpKVkpHK39Tlrhh5ERxwWhk9XKN7f+3uJdXHjXXp8GtESG5ErpyISpjB8d/DwFoM2yIlXVPZ31il/KK/C4HxS5yoZlk6YKx19DGeMRFVr+kYD82NIowQ0MpEMFGvlyv7kirKP7nFOQd0+vZNLzB1S5nW23rjirswCGCdC04QwEwiWkIbJhk/OMA2yBQ6P8QPg9SgBDtLUgw9zJclexJDldDtAXtds+LorJp+4RjrIuqcVACIPdEbBlWLw5ew00W9U+K/mt2lYKPyN8qqoZb0pMPzZVOtrAZtqylKRR3U+9sM1bP3fM6XSzEsvswwZkYid/N5Gg16Pyr5MBplBYoeRvUD8DmNT2RPgdXrlHPJkxOWyIvbi4aHiYok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186003)(6666004)(6512007)(6506007)(26005)(41300700001)(2616005)(66476007)(66556008)(478600001)(66946007)(316002)(38100700002)(8676002)(2906002)(36756003)(6486002)(86362001)(31696002)(5660300002)(8936002)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNYUUlUNU91NWl5NkZ4aXRXMHdqOUlwYno4cm9MV3VlbWpINW11M05rMGpK?=
 =?utf-8?B?cStXYng4V0lYbVdTMGF3aUdhak5IUDdjdnd0eWVtMjN0S09JdTJjSHdYZXlo?=
 =?utf-8?B?M1VsWG84VVFFc3d1SE5taDhlRnVMQXVQc1hFbGxFWVhHYXBCMjdVbWRQYXFM?=
 =?utf-8?B?bWI2L2x3Y3A2bklIZm92Z0ttdHJldTJOcXhpVVNhSk1yQWpsM2tMSEgxL1dI?=
 =?utf-8?B?OG81ZjV6QXJwcXUyT1hkeDMvQnpzVFgvdnBSK0NVT0xoNDdXa3A3bDNMd0lC?=
 =?utf-8?B?dldvSHhnS1prZFcyVG9GS0ZHaUVjUVZ6bGNjK1JwdHRBRkJoaFBUb0pPcktO?=
 =?utf-8?B?TjdLUEw4biticlQyWHhzWnZDUnl1cVM4ZnUyYmVYNURBeUc2VHVyNE0vZWsx?=
 =?utf-8?B?R0tvOXdrUWRDbmloemdIVFBLWHRBdHkrUytuOEoyVWFaZTl4bllwUHBzcTY1?=
 =?utf-8?B?bFhzS0NQVUVOM3JJQ3lLS3BWeDA0UVpSc0xBcXAvT1NCMTdEYVpMT0hvckN3?=
 =?utf-8?B?ZERaRjZXY3lTdG0xMHpMc2c2NUszODNUOHFKWjV4WjRQUzUxRFA5dmVROUQv?=
 =?utf-8?B?OWRuUEpST0lYQU4yVzIwb3liMVh4NlFEYWJ6dHpSc0JlQ2RZZlh5dXd5NTlY?=
 =?utf-8?B?T0dEbDlPZUY1M0I1eDMyV0dGakZQcmE1MWdyTW8zVXpwRGo5ZEUzL1ZHMzlL?=
 =?utf-8?B?VWVadkhreXRZcGYyWGZCUWZJaDZ4VWF5MmJLVnJoTnJDbHNlOVp0eUJ0dGtS?=
 =?utf-8?B?VkNXOUt2ckNCQ2pkWnBFeWNWWkdaRDlFRnMrdFV3bHRKNG81MFViRWJBZ1hS?=
 =?utf-8?B?OHEwc2p6R3o5cHFUOVZoRFNWdnRXV2F6akR1eS9oK0MzTFhFcFJUV29KM003?=
 =?utf-8?B?ajdmcVpwVE9CRU9BWkNyRGNlTkJyc3ByWU41TVZaYXpjQzVQWllKTnZjOG1W?=
 =?utf-8?B?eVlYMHNkcFhpOXRFZlRma0Q0cnBCc0IySi9wKzR0UFdZclhjOU9wczk0UTRk?=
 =?utf-8?B?SUpWT3N4RE9DSFphQkYvaGpsMGFyV2dibnFzQkZXUDdTNkd3aktOUUNkSjdT?=
 =?utf-8?B?Nlh3OVBlNkxncU1LeTJQYTY5bm45NDJwdGcxcFdjczJXQmVhTHFLYUxJK0R5?=
 =?utf-8?B?bnluYWt5R1JVWldFSGZETHF3MFlCdDJYSUVVYzVHNmxwSlZEbG5NbnNZbEVp?=
 =?utf-8?B?a0ZMM2QxRU10VjJNWnp5a01sc2FieGZxVnNLTVc4djloQ1JOTGtKZUtjWTE0?=
 =?utf-8?B?YS96Q0xSdFJ3Qjc0MG5US0J5N0hQWmFnM0Y5aHp0TS8wRUdhRHJkMmlIMDQ0?=
 =?utf-8?B?OGsvdW5Xbkk3YzRqaGxiaEw1UjlXb1BVaXZzdi9LS3lHNlNtTWdZU2RsVlpR?=
 =?utf-8?B?Z0pEYzFVYWVPYlZlaFlZWUkzM3hySjV1OVp5Rlp2dXEvT21EQlBxN0pjMWRp?=
 =?utf-8?B?SzNJa0gwbTVtQitBWDBkY1hzeVZHZVNtL0pSeE11Wk92anBBa0NtZVRCa1c4?=
 =?utf-8?B?RXdDVEpUdzhjbHZiVEdxMFovSVMxUlkzQTgzcWdjNnpRcEJBMktETTRBY1Mv?=
 =?utf-8?B?R2Z2STJvQmZhZW85aXZBRGNsN1RHS3FTRHdGWGhhM285L3FJcnVnUWJOTERZ?=
 =?utf-8?B?MTUwTnVsVFBEbGpzR2VaVm0vcHFnTGFwTGtiV2d0cU15WmtUMXB6OFJKZTV4?=
 =?utf-8?B?Mk82MDhoR2xJL2FBZUk5WTc2aG5HNHlKc0wxQW1RY3VSeDVoNmNYWUpuUGVE?=
 =?utf-8?B?aUdZZEt3K0orekxJc1hXbTN2NGdQa0p1ZXlwOXczL2tiZjRsVTJzY0xLVCtE?=
 =?utf-8?B?eVpKeXJhS2p1cTJkcldXVWdUN3VSRTNOTG41czROMkNiN0FpYU4yUWVwb1lh?=
 =?utf-8?B?MUVIakFROUNxbFNpSkRpdlpBU3J5SCttb1pqelJLR3ZvaWwvMkxCUWY0U2NS?=
 =?utf-8?B?T0gvTzNmTTZ2SGpHYmM0WXRYYm9qakZBcDhTN2dSWUY4eVRLb0grakNENHBZ?=
 =?utf-8?B?TGlEM3FUZ1d5SFdQeDJOVGh5eHpzYlBvclpNMk9oMDkxclh2WjJkeTRUQ2NF?=
 =?utf-8?B?NVV2c1VCbHNKODg0WDd6MGhveTNhMUZiNzZIYytnRXhrVzJVbHNvaFFMbXZH?=
 =?utf-8?Q?mCXQTW7eFpdOsw2HfhlVkpoX+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c58665-a0dc-4a49-6ee2-08db31b20804
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:34:51.3726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DxX24If7p5lm9oGd79j1qo8yMZoruOd/DCpJntLr4AEreJR2TahZQTmLy04MLif
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

Am 30.03.23 um 21:17 schrieb Alex Deucher:
> Only set the supported flag if we have new enough CP FW.
>
> XXX: don't commit this until the CP FW versions are finalized!

Maybe commit the rest of this series and just hold back this one?

It should still keep everything working.

Regards,
Christian.

>
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a0d830dc0d01..4a50d0fbcdcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 0):
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> +		/* XXX fix me! */
> +		if ((adev->gfx.me_fw_version >= 1498) &&
> +		    (adev->gfx.me_feature_version >= 29) &&
> +		    (adev->gfx.pfp_fw_version >= 1541) &&
> +		    (adev->gfx.pfp_feature_version >= 29) &&
> +		    (adev->gfx.mec_fw_version >= 507) &&
> +		    (adev->gfx.mec_feature_version >= 29))
> +			adev->gfx.cp_gfx_shadow = true;
> +		break;
>   	default:
>   		adev->gfx.cp_gfx_shadow = false;
>   		break;

