Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3011BC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852E710EAC4;
	Thu, 20 Jun 2024 16:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iaacWnUu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8D210EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqESt44lhvkcASuSE2XB4juuESHKRe1Gtw+af5FPHKZDam4FLZUgQ9EvYTj1MpCwlt9Yc3mZu/DRNWKkK8zuPwFfa0uKwmftx30sbtd1p9Ih8C2GoQjl8tE60UDZhugQDLxMgULV3zdmXUYvtsC5Lo8dZGIHbmUOPbhYmrl1XGmU1seALDobH8RrZk25PcKrrQNEsGWf7IBS1c237VkM3d3StzxNU7OhPJap+LcoPgP5YKCiWkLVpjhEq2WuGPVSpKIk7gvd5t6vjLe8Jb79L58eJPX0IOnqtGCnGkb8UMt5SWJYWbt8caQsLtc6ZxxETb8Xa17PsaBh0l+NxbtrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2fAKXWEiXoNBxMG3W40eKgHcmT1xmmBABO5zsh2cqE=;
 b=f3vf18r4OEHWY8eOdOiA0r9bNdqGZo9enRMkmhJ6D7Olp7n439+B/TC8Uta/Fd3TwExX+UBLT8V2mvbFMbi7K5CcoW6Jo+6YXRkBKQi3HIy8NB/l5OHMNBPXHOFKM3qls7PjOzCwrnNDskrNQNfmDKPIkQywVuQkYMyUxEW9x33EDLOcqVc4gj+aOw+yZT7wO0DR2XuUsNcyvFJ3cKqC7edrQrmogV1jf/63l5NWD/nBeGp/rALubvWCIdok20HwzgiOt4hIB+tWBUZxGN6wlQTiPC5vHONFHRIB3LIUWlHyf+YERNBgzgDT3A77g/WiCygIsK0RV3U3Qn3jE4RJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2fAKXWEiXoNBxMG3W40eKgHcmT1xmmBABO5zsh2cqE=;
 b=iaacWnUux2F84khOFEEUM4o/BanR2qEH8KBpa9sH1VevdeJKlXGrLzMpjxFsR8eTwCGKMrQAURPjWMDxVH6WfpnIX6eV9ie76/SMPm3cHNaFyTiP18J852UK2gUml2uzaNjbVaxthFh/Eiht8zgae1bC0PkcVCygPrfjNJbjISU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 16:02:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 16:02:37 +0000
Message-ID: <66664c43-8beb-453c-89cd-9128491f3ac1@amd.com>
Date: Thu, 20 Jun 2024 18:02:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear IH_RB_W/RPTR during enabling interrupts
 in sriov case
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240620135521.230223-1-danijel.slivka@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240620135521.230223-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e40f90-281c-436c-3b6f-08dc91426752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkUyU2xybUtpeEQyYnl1WitscXlEOWwrQ0Rsb0hlQXN6dnliT3MwKzRoQitT?=
 =?utf-8?B?NDhocHVmR0FxT3IxenlaaEdQL3A2Rk14S1BqWjFQNE9iRkpPNTlxT1EzaGpM?=
 =?utf-8?B?SzVhdEU2SWtEeUN1b2pSa3krSURrTjQrVmVlN3EydDVmOWZSODMrUnYyNWRx?=
 =?utf-8?B?Kyt3ZmJEcXQ0endzUmZSTmtINHVaUzVXeE4vbDBvb2d6VkFNeWg0QUJ1MTRi?=
 =?utf-8?B?eE1nOTdGbEhEbS9aVFFXVEtSVzEwSWhvREVUWXlocmoyQ0dFR3MyblpzanVa?=
 =?utf-8?B?VFprVVUwVU9kbVVHbXVUc2ZlcVVDalRLZ3BlcUJSeXlVWFNieGw5aXhqekQw?=
 =?utf-8?B?OXRjVnpZeFJ4Z3g3TGc5UHFIZUp2WFZuZnlMbWdDQWlSb3Rqb0hNRFNxQnY1?=
 =?utf-8?B?K2VaYUZxUm0yWnEwWGZIZHN6VGlqKzBwbW1IOVNucTkyV2dpSTIvY1hjdVdW?=
 =?utf-8?B?SStyUXQ2cWdNa2xpWjhFa1oySXcxNDQyd0ZKT0txSWM1WEs0TWF0R0NGcUlT?=
 =?utf-8?B?aGdGY1lRSzhJK0FlTjVBSkUzaUl0VVVQYmNQWFpLSEY5WGZ5OVhPdnF5K2dr?=
 =?utf-8?B?VHlhcFpES1BOUHlMb0RKUTF2Z1BIYml5OERncFI0UWNsRHhFQVNQQi9rczZv?=
 =?utf-8?B?S1ZySERIOFlUNmF2dFRzVVQvckNNS0g2ZjNEYk52TFNZYXVEM0tmNVhSRFEr?=
 =?utf-8?B?c0JlVk5mTURKajZtb2hqak1QWTlCQzdhY29CSGtjUDA4dExvOElmOW9WUHBE?=
 =?utf-8?B?TEozMlljM2ZXMGtvaDNoRjUrQUVZSU1HQzUyYVN0SzRrZjNoK1l0OU5Pd0ht?=
 =?utf-8?B?RlE0eUltRWpJMXdZalEreHhycm1XbzhKbFVwamNkbUcyd3FiM0VMNFJDaFhp?=
 =?utf-8?B?VVl3aXJBNnloeExabUlDOGFWd0lKOG8wNVdhYWlydEtDNFNoRnd2SVV0ZXFX?=
 =?utf-8?B?bmJhbksxcTgzd3pqR25rRktHWjZ5emh0Q016YVQ2Z0owSXoyWXBMd3FpNVZx?=
 =?utf-8?B?U1lieUdteUhyWllySGJjTzVVQS9xYkhWQmJpOU0zbjg0K1d0UG10czB3dGxK?=
 =?utf-8?B?Q1R0RWZxTmZuMFowV2xrWFY2amdXRWpQMm1OWGxwMjZJS3JpamFmYzJ6NWpN?=
 =?utf-8?B?eElHS0xsL1R4ZjFLQXhrOUQwYWwwam9yL2hlbkJqVUJSTmZUMkorVGsvcGE1?=
 =?utf-8?B?ZzBhMDl1eDEyWGpiMVQ4N1hPZEMvSi9WWWhVNkVSRmtQODZ5NU5sbVFyZ3lE?=
 =?utf-8?B?cDFCMkVua2VlQTI1aXZFMXBPcmd6L3FvRWx4azAwSUZYbjNlUEYwUUVTamFw?=
 =?utf-8?B?NkZ5S0VRMEdhVkI5M3BubEJrR1BvOHI3YmhXUFFjK3ZqN3dxUENuSXZaY1pV?=
 =?utf-8?B?bU1XQTdpbjBsb3dPWExzZDRiTXZhdHdRMnE3ZGVUUUxjRzMwUmNlNHVYMVpC?=
 =?utf-8?B?ZTNtaUJCYVpqYyt5dW9UK3N2ZndLb1J6djB1NUV0bHBiTTFCK252cURUdzFI?=
 =?utf-8?B?bTd1QXJGNUpmUWVWYS9xZ0ZGTHRrRC9OVkVkMU0zR243ZkZuQUhPVG4zOVJP?=
 =?utf-8?B?Ky9kQ29Jb3RPVlZhMnNna0RQQk0rUWVWV29IbU9PY3ZybUNMOTIrZHF1ODZs?=
 =?utf-8?B?dlRWcEZBRDNTN1BtTDgzQkxzQm1UZ3ZuT3d1dXRIcm9WOW12dEtDR0RXZUdy?=
 =?utf-8?B?b1hvNlhzZDh5akNBT00yQXBwR0laUVdXclBVYnVldHE5c0hRUTdnZCtpTHlH?=
 =?utf-8?Q?QX+hZIzCcHk3h5jIfJJ14FPiNE+qfF/AD4tH9W5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDl3aTlYb01tVHkxemV6bkhXNmVWS1VUZXdBWkZEdk55elBVT1hlemhJMjlU?=
 =?utf-8?B?aE5KSjk5UGpWcjVwT3JHS3pwaE02SHBaemxMZGxjeFpYUnBkaUMvOC8vSmE3?=
 =?utf-8?B?WUdnV2VQL1NidVRsRTBzTlJ5SzV3NG13YmVhbGZYZVB4WUQ5dXZxOXZRUnM2?=
 =?utf-8?B?TmtPZ2k5UjlnV0tMUVNDU2hCSjhpL2tVL0drT2xkM3ZnekYwWi83aEh3d0kw?=
 =?utf-8?B?US9CbDkrSTNXM3M0YzVtVnI3dzRvSXM0VVQzSXdOZHFQUDl6ZmlkeWZkcGFD?=
 =?utf-8?B?QmhpdnB1UUV3QzlHL3FPc0lyNDRFdnQ3KzhuQzhGZEh4ZnRXamR5ZGlZanFL?=
 =?utf-8?B?dUk3Q29GM2t3NEs3S2hCRkRBSEhpVnlMWlpQc0loa2xpaTRHdXhmMGM0WWo0?=
 =?utf-8?B?SThtQUhTYWNPMFZ5MGU2dVhuL09YQnFGTlJTbnluaWlXSTAvZzBZeGh2aWlj?=
 =?utf-8?B?OHllY003bFRDaUM2Y1E1VlBDVFQxdTJhRTJRWnZDeHYxOHBqMlIwUjcrbGxj?=
 =?utf-8?B?b0lkVFdnMEptZzU1V3M4ODBiNlBicStQSjY4VkNPUHlXQTZ4MWJNS1pSUnA0?=
 =?utf-8?B?ZzFiWTJlaFBDU2VsMnRYYXhwRXV5aHFwTmZvUDg1MHU0b2J5OU5LQWpWZzJS?=
 =?utf-8?B?WTU5MmdhQ3JuQlRob3lpa2lEMGJLSXEvMFoxUTRoUWlTR1RuYUhYZWJmNjlG?=
 =?utf-8?B?blRVM3NRaTlWY2s1WUdJbWlERUpKL2NjU2JMaHI2aTNmdjliVnpZcEdEUkxq?=
 =?utf-8?B?V2ZTbWxHc2pMcmJjdXRLanFGYjhQWno1MGhsS0FLbUhKN2pJQjZBaGk3UWNz?=
 =?utf-8?B?SFk4RjN2eTVYNndXcTdIclRUZDJ5REsyMnZsZWRQbko4TzFjZmt5NXk1aHBD?=
 =?utf-8?B?YlhvQlljMTMxY1NVU0JCOEN0WXFZTFV1a2hBYmtCME1uVklkeEllRkhGOFdV?=
 =?utf-8?B?Y0srK0dtOU8wblZHc0VGd3FCUVFjRFlDUy9mUmsyWXFoZzlsSFRwNC9tK0o4?=
 =?utf-8?B?YXRLeFIvb1FYZWx4K2FqVkRMRU80WERCVlJIVTVGTklPS0NCRjZ2aGt0ZVNH?=
 =?utf-8?B?aTVKbWNEanlIdXNNbjdKS05PZEZpeEdjN1A4WjR2aGxhTVBEVXZjbGwwZTZz?=
 =?utf-8?B?L0dRUU9ySnltejVzSTY1a3ZrbUF4S3p1M0FyamxJSTVYdWpsM0J2VngrZjFT?=
 =?utf-8?B?MVArSWhWVm81aFNKbW53L2MyaWs3dFFGMTdvZ0VoWGpHV0tQNjVuSlFaZVBz?=
 =?utf-8?B?WGhKTmRkdEVrNVFJNDNnODVDWU9OR1BxMklJN1hHUWt0blBiNjNNS28xZ1lZ?=
 =?utf-8?B?cHNLYWx4MGJoVDNCWmpITG50aHFHTXU3cWROL1ljaDhXc3lnQWNtVnhRVXN4?=
 =?utf-8?B?dnQ0WHJnWEFoWFp6amxQRUkySXpwYVZhTmhWVURjQXBQTkZhc0dUcUtiMmVG?=
 =?utf-8?B?dXh5K05OdW91TitzaTAxQzEyeG9HNkI2RDJNUnZNajF6UXhxRGtMR096eUJV?=
 =?utf-8?B?WmFyUlFuTWpGYWNaNjJCYU9rcWNmYmJLV1RWRWJxdWJWcjF3NWpxMnhJQzZa?=
 =?utf-8?B?MmpVbldvNTFlSXgxbXoxNVVvQWNKVmtZUG4xNGp2aUhLSXhUR1hTNzVIZjZv?=
 =?utf-8?B?dDZLUTJYcVEvT3VyZW1tU0xhdEl3TzF4RXh4T295Slo1Qmx1eTZIUWMxMmY3?=
 =?utf-8?B?ZDFlNlI0c2FRS3FEQzJpUS92ejRiMjRvR2IrVEJnWDgxZkZDNXRZTlNJMVNY?=
 =?utf-8?B?RXl1aDNvU016RGM0c3ZLSUV6cERVeGtta1IxTEo3cVVCV1NSREtoNjJBUStP?=
 =?utf-8?B?UXQyMTFDNVlocjJNdytBOWVhWkFZa0t0M29RS21MeUNES3JvL1V0WU9ackhk?=
 =?utf-8?B?bHE2WTZ2TkJ0aGwyd1RtS1pGc3V3SkxSZHUwcEw4elR2MnVMNCthUTRaU2Za?=
 =?utf-8?B?TjFwRWplQTNZS3R5d1ozNG92TjBZQndmZnR5dkhFbDRaUGpHUS9CNVhLMlUr?=
 =?utf-8?B?VWQrUWpKVytUYk52eWF0bWR6N0lXRVo2ZFFMZ1dqZGxBS2xQRzFSbjVuZ245?=
 =?utf-8?B?K2JnOTJVY1IvdWowanJPTkw5NlFJQ0NmejZQTnBKUE5LQnhtTmZMZTRianRz?=
 =?utf-8?Q?KQfviH5R/pW3a9v4JNJ8T/yFa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e40f90-281c-436c-3b6f-08dc91426752
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:02:37.0616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpmLEFe1JeHt0bqNunnK1hygaCrIySvMTQXuOxSRoKZHe5FhS8/SMLAsaXCWneky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

Am 20.06.24 um 15:55 schrieb Danijel Slivka:
> Clearing the IH_RB_W/RPTR during interrupts disable is not clearing
> the RB_OVERFLOW bit.
> Adding workaround to clear the wptr when enabling interrupts in case
> RB_OVERFLOW bit is set.
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 3cb64c8f7175..d6212a98ca99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -147,6 +147,12 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
>   	}
>   
>   	if (enable) {
> +		if (amdgpu_sriov_vf(adev) &&
> +		    REG_GET_FIELD(RREG32(ih_regs->ih_rb_wptr), IH_RB_WPTR, RB_OVERFLOW)) {
> +			/* clear rptr, wptr*/
> +			WREG32(ih_regs->ih_rb_rptr, 0);
> +			WREG32(ih_regs->ih_rb_wptr, 0);
> +		}

Well that change doesn't really make much sense. We disable the IH ring 
before we do any initialisation, see ih_v6_0_irq_init().

That in turn sets RPTR and WPTR to 0:

                 /* set rptr, wptr to 0 */
                 WREG32(ih_regs->ih_rb_rptr, 0);
                 WREG32(ih_regs->ih_rb_wptr, 0);
                 ih->enabled = false;

So why should this be needed here?

Regards,
Christian.

>   		ih->enabled = true;
>   	} else {
>   		/* set rptr, wptr to 0 */

