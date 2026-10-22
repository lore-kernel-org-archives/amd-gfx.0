Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C5606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y/4sHBEt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0A810E34E;
	Thu, 22 Oct 2026 14:19:38 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4765C10E34E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 14:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1JfnllO9gC6W3IA6DOJYYt3IHS5fasBRpR+9+Z+UJMLC0nlE4/6kozJXCf0wWQpg500NMpCIkMCFNZO4Cd99PaNOlFjoxdoHioV7K5EmFuwQ//CB6cUOYYd3P81SRcpPSCs+V8tB1yPEIlZj4u/wGu10+S6KB254eAP5WliMYK46uP9whooARTsjwl6Rg85m5Fgo0qZTl/ShxaNnCnsdXxFR6OkCoZbdq1O/WeDN7udXLZ9OoR4Y0h/OZbgrRPLM+qnPWeDkEjh3lRCt+vklOkAbsxr4Ovj79iDevVVGShCQBIi9auUIV2pTpZEr7+K7zX/2W8GVH7T7XfaOID/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux67W9DTLhBLi6z95jqhfVfizIjsODjQ1ch+wvCIEO0=;
 b=FJl4xXa2iUMoiYB0PYBG9OEKp4A6xcQpdgSZyhUlrJUCwi0HrDuQqr9x5KDi4BOY8a/ukuHlupfd/SmcNZOoOlgPdP4zZwoNMzZ44WkumnOAPK1kkS4rmCold1r7VK7RIZA6XREEklxYsarGYDiIGVWGlx4Qs9LhSKWRzudydhLojTOVjaKavzzuMAoLs+RU+FsYfjhN6ZNdQcsaRYG+YC91gNFH4LgTPoWAnY59ipe+ePcyIkLj7ZFxbCVVh3N/2/5aM/L61XP7suO7oUkdV06wr4wh/EJJGQCiHc7Cb2kQ5NOuMErcL7CYgwP5QTXy7qe9EseBhh7sNAol1sdsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux67W9DTLhBLi6z95jqhfVfizIjsODjQ1ch+wvCIEO0=;
 b=Y/4sHBEt76vLw2/XTILGbxqW/Dq8lkm41HAeJwtfRlxOBQwk8+SRX8LbhGJDqh/38oDzbVb72HUD+/qrGlqTmSq6hvQpqd5fsU9O8gHRerQs3+++AKOZn5fEFIu3dUMpnX8foMg2/OCMn6/NmQn5qmn4MvK5TA+1N9fPUCMnis4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by LY0PR12MB635447.namprd12.prod.outlook.com (2603:10b6:408:3b9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:19:30 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:19:30 +0000
Message-ID: <c7772c1d-a6ba-4c5a-848e-eeb35e38c702@amd.com>
Date: Thu, 22 Oct 2026 10:19:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu/mes: skip unmap queue notification during
 GPU reset
To: amd-gfx@lists.freedesktop.org
References: <20261022083331.3019779-1-Prike.Liang@amd.com>
 <20261022083331.3019779-3-Prike.Liang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20261022083331.3019779-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|LY0PR12MB635447:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab8b855-6831-4e57-432b-08df30477c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gUGDsSzeaYMVd+fjVO7Iz6Rf1MDKxd2KcIamdnGTLu6nm53JYsqgKsWKTuuU+T0ZZ/bwejPsYNh75Y5/OkbLCqd5CtY9lfU7SH+ckhzR/vAfdvgakm5mffuSBA2exjtZkEq9TVrgtVchIEgW2jwxlvXHc+1xqzdQ6mFk85fSsakbqYQnMQ8Ak6y8hlr5vsKQ/MgPFuqPjvAz9oWOVZIVYnyA7QqKcRYfgpoAuyibikTOd+x4JrpI5yY6MFobn1I3UK6We0FkXZ9iREyNzL41Q9wahAisSBFq1TZBWcAn7pb1rg1IF9RGNO753/zUfYKkeUX7fuhZ21iaIBQRiSKbRku6sUZJ3YPB4iGbI42mxqgq0FKa04mKKRd2nL46+6XZaC4yL/TKYmT3AOqTsY6VBt66IQva8NdBk/OwNjTy3K+qoULK4fKGDMw6pIKyV+Oj71Y/Q2eh4647H5l7Fn+tlTVW2CkAMy3VciebKxIDdWTS7dspcItBgUdpK7lxy8DfGFgjLmcjn7hrTp5AKAYRUEx2J2fqawAbMAQlkhTbiK3zZJwLAfarFsGfO0lgWNVPmm1DzrzfWZgTjoU4YcLBIwut3OuOM7evGjWeWdjqdWjEUUs0l2X8jKHTM2jP2GFkDm4imEmbM0PUJEzU7WUB6GQsJ6RGlnbjHQOzgqn/l4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk9HN2ZFWkVoZm1JcFZxZGhjVmczV0MvMy8yZEFOdmxjTlAzWStPZ0hjZUZH?=
 =?utf-8?B?d2I1eW8zSU9oSVArY1Z3NG9uaTQ3cjJZZC9GdGduV1lFTGNlUEV2UEM0bmtu?=
 =?utf-8?B?d1pNcmZZeTk1NUhjTUdjWUlYYjFDdkl0c0tDSEJMVTVzNjlKTGp5eFJTYjR3?=
 =?utf-8?B?NGVwTmx3UzdTdkR1aWFLSXFwdisrM2NWZGJPTjNBby93RzRTNUJKelhETm43?=
 =?utf-8?B?bW14OHlmWVF0RnljcW4vUTNOVUdpcDQ4d3JxZDlsaVlLV3NIbHNvOEVGWHhR?=
 =?utf-8?B?aWw3blc0ekVobWRrSkEvaXZ5SC95SW1IMjVJZGl0WWlSRVV3SnJEOVRKeDli?=
 =?utf-8?B?SFhrbnlZbXF5VUV0WXVEN2VEdE40YXF2ekRRb0dmb2o0V2lTV3RYK2wrcGpy?=
 =?utf-8?B?eUkwcjlFZGJWL2VQRjA2MDZRbGRQOGxqRU1QTlNWT2VVTzhaMDFDckdnYnUx?=
 =?utf-8?B?TmlxZlh3SG9nQ1VaUE5mTTFrWHhUZGI2MXRRTkpUR3U1ckpkUk91UG9ZWWNW?=
 =?utf-8?B?ZE9OTGtPRThlT3lpRjRVQ2I1K056N0ZCZnA0cDduOTRncGxYd3J6ZXhpTER1?=
 =?utf-8?B?cUxlRUhHdjFYV0taQWVsQW9JZTlrU0czQkV1WFRnaXlRZWs4TnB5UWRhOCtZ?=
 =?utf-8?B?ME5ETm5GaVRhSGUxRnppU2RQaldOSlpXNHY1YWlCTDlVczAwSUZxUkVKTTI3?=
 =?utf-8?B?a3FZVEZ2Yk5SaFRoUysrRXUxN1hSSlNlWXBUUHZnT1pZT3F3TURhaHZCOHVL?=
 =?utf-8?B?L1lSUFJ1L1QzSEVzTkJjSS9xa3BMdGphRDN2TmxCODhNaXU2UVhhQVZ4SVdY?=
 =?utf-8?B?Uit5bzlPb3VYYU0reTRPVlpQeS9LMURKZUhab3NEd09ESXFaL1RVUGpJNlFT?=
 =?utf-8?B?WkJFZVVYaWtHcHdBNThmNGsvbHRab1Fwb0lMV2pHUEJFVFc2c2Z5NnhDWVR4?=
 =?utf-8?B?M1VFUzZZNUg1M0thNkdYYVl2WkVMVDBkTWE5SHhvd1U0QjB1OUJqV1ZLam1P?=
 =?utf-8?B?WjV2TFd5QjJPdWsxZExQMlN3bEhJdGNVYUpmTm9tOUNQZ1Y1Vk5LN2lWYklF?=
 =?utf-8?B?VW14WitpTm5IcjRqd1JvcDVIaW1Vanp4UFFVamplRkhzMTdWZ2Mzbm9ndDNt?=
 =?utf-8?B?b1JFTkF4YzdZYUc4Smprd2VHS2I4Sjl5RjlPaWUrS3phdnM0WlBjelBEa2dx?=
 =?utf-8?B?Q1hXVGhvU08xTnVvVDhFTFhLc2JJWjBmM0lOVGhDVVZ3RmFqTGl0alo1S0VB?=
 =?utf-8?B?aFpEMmd3cVhRLzM1eDFUQStFZ1lTaVc4OVhHOHhqeFNpZUpGTFhsM0hLcEVm?=
 =?utf-8?B?dFVDVE50WSt5UWl5d01KZVkzTS94VnZuenYzZkJkOERMcE5hTVoyNHVHU2pn?=
 =?utf-8?B?RS90cG5aNmRSNzErTFpXMjd3NElvU2lRR0JqWEdPYnM1YjJONWpyQUE3akk3?=
 =?utf-8?B?TDdQekhSOFZJT204SlJNNVlCVTBOVk1CcUFvWGI1QVVEaE5uVkptei83VndK?=
 =?utf-8?B?UVppdDkrWDVxWSt4Vk13ZmkrSXVZTVBwWHU0M1dZSmQwNmthb1JnazllVDIy?=
 =?utf-8?B?YVU3VzBwam1jUUlMV2RFcUZBVTF3R1QyMUhBZkRZMjBmam1ObWxpSldMNVVz?=
 =?utf-8?B?Mk9TVFdta253ckdoRWs4bzUvcmdMZDhPa3lWNjNlT3JWOStiTUFoaUVqRjY2?=
 =?utf-8?B?ZGgrSFZvV2JVTll0emZnUGRlcWk3RXo1cVU2TE5ZaGkycmF5MjNHRkpFdVpZ?=
 =?utf-8?B?RXJaZ2VndHlhd2ZneXZyNzlSbXExUkJ0Z3puME1USlY5MmNBaDgxK2luZVh2?=
 =?utf-8?B?RFVnOUpjTlJqVm0rRkNmVXMyNThDRTUrMFgyT0FVc1BIcUVJc0NyWnI2MFVH?=
 =?utf-8?B?OFhhQXNDS05TTVYzRi9JTTdBN3hNVGFLZVBoM1lWM1FjV0d0ZGpBTmZyY0Ez?=
 =?utf-8?B?Z2V4cUVPejJaSTNCazNDV2JzRm16MXNkNlJCOTZXM2hCQ3UrWnVsSFJWMFk5?=
 =?utf-8?B?cURJL0U4a0JhbG9ML3ZuOGkwbUQ1SnpMak9oSjREUitOTWJBdW13aWNqai9i?=
 =?utf-8?B?c3dLNzJkQy9mTUlscFdNU0NLeGNtRmI0UncvRjY1MTlvWiswSEZlRXBnQXBw?=
 =?utf-8?B?NzdCczYxR2lUcUlRVHRwb3hiWUJSdlFUaldIM2pXUVVrS2VKTk5nWjhpSWdQ?=
 =?utf-8?B?ZnJ1NU1DejFZNStvNE9zcDVKeThDNEFQSm5rdHdmQ05rVlNPdU5BM2hvbE45?=
 =?utf-8?B?OHArbmx0ajUrWG5mTkxKaEd6blZlKzdOSkt1RTFJbUhEY25Xck0wMG1VWG43?=
 =?utf-8?Q?1VdoH+r0wKZtUj5iLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab8b855-6831-4e57-432b-08df30477c89
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:19:30.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9D4h3NV2X9EmAWQafYTdF6Nvg2A16wt9CUxGl9utxpMMX8GdZrQxgGfxgG7HhVapfRr143VaCBRm5wv4JCt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB635447
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


On 2026-10-22 04:33, Prike Liang wrote:
> amdgpu_mes_userq_notify_unmap_work_handler() submits a MES misc op
> without holding reset_domain->sem, so it can ring the MES doorbell while
> the GPU is being reset:
>
>    WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>    Workqueue: events amdgpu_mes_userq_notify_unmap_work_handler [amdgpu]
>    Call Trace:
>     amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
>     mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
>     amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
>     mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
>     mes_v11_0_misc_op+0x8b/0x240 [amdgpu]
>     amdgpu_mes_notify_unmap_queue+0xa3/0x110 [amdgpu]
>     amdgpu_mes_userq_notify_unmap_work_handler+0x24/0x70 [amdgpu]
>
> Only send the notification when reset_domain->sem can be trylocked. The
> work re-arms itself while the HW queues are oversubscribed, so the
> notification is retried once the reset has finished.
>
> Fixes: a3e112968588 ("drm/amdgpu/userq: create the same workaround of oversubscription timer")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
> Cc: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 05bbbd1afb63..f573453415bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1191,7 +1191,11 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>   					       userq_notify_unmap_work.work);
>   	struct amdgpu_device *adev = mes->adev;
>   
> -	amdgpu_mes_notify_unmap_queue(adev);
> +	/* MES is unusable during GPU recovery; the re-arm below retries later */
> +	if (down_read_trylock(&adev->reset_domain->sem)) {
> +		amdgpu_mes_notify_unmap_queue(adev);
> +		up_read(&adev->reset_domain->sem);
> +	}
>   
>   	/* Re-arm if still oversubscribed */
>   	if (atomic_read(&mes->userq_hw_queue_count) >

