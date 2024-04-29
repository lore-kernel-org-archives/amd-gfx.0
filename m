Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39354C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 08:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A665C10FDB2;
	Mon, 29 Apr 2024 08:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSB3OBLt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4D310FDB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 08:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K91RoZlK43EeUBvnB++D+DbEDIuIerUW8KdQrkf+P1IypoPcTb0aZcGz6G/78bV8RwMlAAuz5C9cClCvvrJ7Mqn0+OBYjHWuG4jdgZ9i3mE4oJ0gVLsyb0baw38nNth3jRLVlh2v13gjZhal/41Ot1dKA/sExF4hFdyFq4ispafpisWIAYcaqB73nVcTHeRTDUFt+3vy/o+FYSIh6+gwuoIv847TJfPoGIyIQjeH0+KGhZmfMr+jrpRIsn2SwQAHicNkL7Ze+N68eTUI+t63+Ablt5P4NmbCFZgVzseFqfvtIr+JbJgbC3HHBpde4Ek23MYmPqISe4Ptuy9XPH1SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXLplNTZPHgPCgLSIQ0CsWliGhdEpzkvSUrlu1Ybk/Y=;
 b=Den6iQ6KaygxL5R/grwhKyzXMCEFYjZeew7Bk8+ucBd5ndgDeScmwmwJ218qz+7bywUroeNH4lPJgbXMZ0iAIw6fT5bh7r2lvwgRbgGWwsPilg24VtQFxm+zHht8rPDel2oFpEBZ0SCJZrZq5UwfAd7JQi8lwt+bXbu0Wi8Gy3H5vIfT5v9OUEqKfZhosEJdb7qaJfJCct8z+DhmSYAx7lO4+Uh9j9MHg7QQP5ABe2lNG+5xwONTTidTZ7VQcJnxN/+y/o05iREtuJfOYLW8/TE16zsqBdouPHK+etcztKyQmEmPeJnfH6LY2lOyTxwOhPYD0935kJXZ7oE5kfhc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXLplNTZPHgPCgLSIQ0CsWliGhdEpzkvSUrlu1Ybk/Y=;
 b=pSB3OBLtXFCtpSkwM+3jRTvJWu9d8Tque9X1nCfp0TRNs8osO5ExlXVsV1Vsr9HIiWWLFrBbd/wdPhnG1kTVSjFQ1+SRkuTeZyAv6V+xmBouaROOc63Dfuz00ewomsvd0o+eojDFh38S8aeKeZauBx2VEXQTmwlMEx2xKHBGfyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:04:58 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 08:04:58 +0000
Message-ID: <c227314a-fffc-4817-9e32-b66fea085706@amd.com>
Date: Mon, 29 Apr 2024 16:04:49 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com
Subject: Re: [PATCH v3] drm/amdgpu: Fix the uninitialized variable warning
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240426093749.21707-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20240426093749.21707-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c88d5f5-f9cb-453a-33f2-08dc68230fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGpBajdOZzNaZjVFNWFUNUEvellRWnQ0QjVoYUxUYTFVTzhlMFNuWXdGZGRV?=
 =?utf-8?B?NmpTMTlERSt0ZGR3UU9rYUhiREpabHNrdGZyMEN4eCtHZGFXdmZ0TENjWjk0?=
 =?utf-8?B?OTVJUUd4V2VZM2JJZFhWZldnUFlTOTBRaXZqZEx6d1g2RXZBaGljYXRGSC8r?=
 =?utf-8?B?VElXSngybzBoaFJBa0c5T3RrMzBGMDUwdVgvZ1JTTGtnMWFpbVN5QzlZSk1R?=
 =?utf-8?B?OUxnWUdjZ2ZTMHRaZk9hUFp3S3RZSS9HNVdtdFBpbGpxWnFobzNJZ293WkxZ?=
 =?utf-8?B?VkRtem03NnV0bWRRVDg5UFJ6R25zMUdOSVovTStMMUIrOFE0VFVFMmdRNE1k?=
 =?utf-8?B?Q29pdHlXejQ4QWJ1MWdyYjNObXdBci9WalhKRFZkVVJMdU0vTjhlc3hDUXZl?=
 =?utf-8?B?VEQ4SnUzc1FvSlE0UXM0bFFBL3VZbnM5TExYbzNvNHZrRE1Ub2p6UFBDVU1t?=
 =?utf-8?B?WEdRaVUwV2lpQStMR0k4cXRQdlJpZmdhdnExcmxPRWovSWVjdVdONzVpMk9N?=
 =?utf-8?B?Z2JRUGUvc0grYXhYaklZY2lEY21FUkdqSk05YWljUlltMVlyV284bGljczRx?=
 =?utf-8?B?azMxODUvUFg2bFZhbnBMQVpHcEIxZmc1NEUyU2p6WHRLT1FLaHNyUmN4Y3Bz?=
 =?utf-8?B?dS9JQVZNUEFYcFhMeVE1am8xR2xYSlIwT2U0TGUzaVc4RCtUUEZsYUpVZ0U1?=
 =?utf-8?B?RCtnaDVKUFJnaFFmckpiOWdwZkVTdTFPYXBzMjB2R0NWWTd3Qk83UDdLbFQz?=
 =?utf-8?B?WWZpNFoxY0paZlpha29OeUltYTIvaEhPQXI4bGpiTVNjS0hRK3BCbVUydE5G?=
 =?utf-8?B?bjlpZlR0aGlPM2dSQzI0Y0JmMFVIekwzU0htdkZZRlExRFlUVHg1b1FhWldl?=
 =?utf-8?B?RnFxRHV5TkRxR2MrZ2d6WnNOSWN0b09UK3FkY211VEROUTl3SkRVN1BxYXEy?=
 =?utf-8?B?cFFVOHQrc2dyTTE1aGJCUEpwbjViVGlZK0c4QW44T0pGZm93YkgzclVUUGhx?=
 =?utf-8?B?cyt5aWhCQ1NiWUt2ZEdXYUdRUHJmaHA3bW5uMjdvK29iOFcwQThkcnFLOHdY?=
 =?utf-8?B?M2lHc1ZjWkNyNjI5eEorcGNtNkhxdlhXNCtyYStLSzNsZ2p0UjQ4Smh0aWhZ?=
 =?utf-8?B?NjBuaTFCR2Vrc25QYVh4UVhnOERxdkpxSEhqS201bEVLUFM5TTJaMFBKbnFE?=
 =?utf-8?B?NkxQRUhBZTM2U1orLzZMckFuaTdHU2tTRHdOUGY5RUI4cGg0Zi9OeFpGL2RQ?=
 =?utf-8?B?NkN3NHRaNmpOeGpnaW5PWU5mNnhmYTFvbHJsVVgzazl1RjJZMzVicGZwYThR?=
 =?utf-8?B?ODE0RnRobUVEVFdHc3YyZlZPdkt1Qnk1bXdQSndtR2wwKzVVallzSHJweVNW?=
 =?utf-8?B?SjkyVGhUekpWTTdnOEJvb1plRFVOK0NZVTFjS3ZMV3BnR05WRTJwVXJJSlFv?=
 =?utf-8?B?RlRXdDNZdFJaTml4dG5VNUM1V0xnRHptRU0yNXhxbFQ5MnEzd3hRd0Z5anhU?=
 =?utf-8?B?UDAzVTNwYlRIOGhqbUV4WlhEbE92TGh1TWJqTWM1Y0ZWeUNMd294eE1HelBv?=
 =?utf-8?B?SlNFMmFEWmp6U1V5b0FpemhpUDJMWWpLOHBEcFFlVDNZSkt1LzJ1NWl2ckQ4?=
 =?utf-8?B?QjNBM3dXSEcrOXZQSXdicU9rWFQ3NXFZTnV0RHI5VEk5VWQ3N1F2Mm5ZNFA1?=
 =?utf-8?B?U3EzK3huV0EyQ3NRQTZjbVI2UU1XVEN3aHJ1NlNTbVdvYjllQ0J6WmdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxGSVdJYVRBdjJjSFBzV0xabE9sUWUvek9sL0FmOTlpL2xVbFJNUHdoVlIr?=
 =?utf-8?B?Si9wTkJyWldmSGVwQkFROTE5RHZKeThHNVlyZldqeU15WnQ0ZmlJd2VKejhk?=
 =?utf-8?B?dFF2YlZvWGpJZjYyMkdGZkV1UE0zclZxRW1ack9RcUtPTEdad1VZdnczS1F0?=
 =?utf-8?B?elNRSzJHT2ZCWHpyN0FhSkxLUFRNbE5xbWswSjR1QXFsUkZIWXFmVkhwNDM4?=
 =?utf-8?B?SnZaWlZUV0pWUjlUVXpaUWRNbXVGazBYODdDbGE5UW1qd0lLNDJXZk16NFgx?=
 =?utf-8?B?aXFsYk8xakN0cHBYVTBjcGtjY3VFYmJiaTBPOElieVJuTkZ4RjM5L05xT1hl?=
 =?utf-8?B?SzYzVW95ZGZyQ1NIcGNhQjVTYm4wUWhyMHIrcXdkNSt3TWJJcm4yOUVGR3RE?=
 =?utf-8?B?NHRjeHdUTXFIcStDY3BuWVBQMytDbk83R3Foc0tzcDdwMmdheUR5djJIYnJO?=
 =?utf-8?B?M0cxUHZjWnFIVnZMbkh2clZCTVpITVdnVnFTbjZpZnVtcEZQNnFtbDVhenVD?=
 =?utf-8?B?ZlhveHBNY3JrZ0pMTUhjU0FYK0FKTndtL2p2Q2pzNy9abTExQ1NMUU43MHJk?=
 =?utf-8?B?M0lCdUZ5SXMyclpjWkl0RFhoUENBSlF4RUhOeXd4UjVkS0RZNTFGbEx2eDhQ?=
 =?utf-8?B?UEZSZzd1OEdGQ1VwcXRnZDdqNk94OUg5N0k1RmhJV1BYN093YXE0NlJadnpm?=
 =?utf-8?B?NkxYSGlDbzdVOGVGazFQbTRWZkNyQ0F2RGt4WDBSK0IzT0dRbDUyQnFWekxt?=
 =?utf-8?B?cjdzR1ZKZVk4bkttODg1OWpzbnMzN3FQOERtZzNBK2tVY25DdzlITjdERVdQ?=
 =?utf-8?B?Z0lhVDVhcjlidjJBZ0lOK3VtVTZDVms5dnpCSkFFTUUxS3BnLzhPUFQzZzRa?=
 =?utf-8?B?VDZlSW9ncXlKYkp4dTVpRjRWemdwcXpaU25LZmt6aVAxWCtwSnpVQlA0S0Fj?=
 =?utf-8?B?VlIrRmlvbHNreEVpbEFUajh3MlFuRWkxdGhpQ2U0K0tIODdNM1IwTTZWZElN?=
 =?utf-8?B?MTdmTlhIakcvV1YwRnhqWjkwc25MY3J1bEo1T0RPOWZVdXh3dUora0V6TGRV?=
 =?utf-8?B?bnhYKzFzUDZwdmx4RENFQW9nNm9JRTgxMWxocEN4RDQxdjJQV2krL0d6T3Bk?=
 =?utf-8?B?MUFVelJPeDBwVW0yNCtvZG1RQU84enhnYlFpTEd1cWc0SFBqUXhDbnNLVFYx?=
 =?utf-8?B?VzhyL00xRHVxcnlyaldHOC9LSVA5UnNDMlI3QklJT0RicmJRbEpKbk5ZR0s4?=
 =?utf-8?B?aGJnRDVjTDJUUlRZSmtGaU5JRU1nWmhGSUlCdG5VTEFzVEVXMUs0OEovMTBC?=
 =?utf-8?B?VnVBUTFDOTI0bUcva1BPMW9GZTdhVG1ySm1udHhOaDlIWURxKzVNMVFVMitM?=
 =?utf-8?B?bXIwd2t2UCtRWlVBM0p0VkxaSnpxbmVOMjJBcDRsRHk3d2VZR3NsQWlyMzVM?=
 =?utf-8?B?a2g5MHkySFRySEt1SkVWUVUwSjNnRUhBRVpRSnNwUGRVdjA2SzA2aXVWSU1Y?=
 =?utf-8?B?dFlLVnB5THM4RmI2czV4bXpTOXNMRStzTDVVdkk4N2srRU4zcEJVc2dlWEdo?=
 =?utf-8?B?M1l4YzE1WHdoem1wbCtEeTU1eHVSOW9mRThLaDNjSUVTR1F1TUFhbkV4aGoz?=
 =?utf-8?B?cVJXQStDU1hhbW5vUVVPeENhRTNHYklNS0c0Z0Z1aHNENFZRakRzeWM0anpN?=
 =?utf-8?B?aDkraGxkamJyWjZHNnBTM25oSWNwOFcrTmxJNTNTOGY4WENvMUE1SXBHVXZp?=
 =?utf-8?B?S2RpVmcrbW5RV29NL3cyYWM4S3Q3NUpLZlF3U3BlUS9BcVdBOGpjbjY5ZE1D?=
 =?utf-8?B?RTVvY29LQUVzSXZOSzB3STJYdHhjSTdvR0N2b3RMa1o4ZllkVmI3MXVtcW5l?=
 =?utf-8?B?d3BwNk5JZjVZK2NLUWxnaXd0REZwbWI1Zit6NVJ4QUpTMDRqN0VCNFh4UjVY?=
 =?utf-8?B?OHFHSkVSWkJ6dlc3QVdtZkhqNSt0eXR5T3BvaXYycXBBWHN2UkR3VWNaaktl?=
 =?utf-8?B?MWM1ZTBydDM3NDF3YW93UDRWK24vN3VTMzNNbjJaeUNPQlo1c2RGcEhFUnlZ?=
 =?utf-8?B?czJZbFU1M2grWnJUVHp4enhMWm94NkVGQ1NLQ3V4MWdidUZVcHFha1VBdE9J?=
 =?utf-8?Q?mHm1x78QzeTXydNTux8q7SNi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c88d5f5-f9cb-453a-33f2-08dc68230fda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 08:04:58.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSsVtsGUz32YPz5JBUYfPXqDtFsP5ga+d39x6f/kMFFXsU3oiukolfHiyo42U5Pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

ping ...

On 4/26/2024 5:37 PM, Ma Jun wrote:
> Check the user input and phy_id value range to fix
> "Using uninitialized value phy_id"
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 8ed0e073656f..41ebe690eeff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>  		mutex_unlock(&psp->securedisplay_context.mutex);
>  		break;
>  	case 2:
> +		if (size < 3 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
> +			dev_err(adev->dev, "Invalid input: %s\n", str);
> +			return -EINVAL;
> +		}
>  		mutex_lock(&psp->securedisplay_context.mutex);
>  		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>  			TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
