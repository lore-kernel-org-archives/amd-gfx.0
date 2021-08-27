Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB50C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 14:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE8A6101B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AE8A6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D473D6E980;
	Fri, 27 Aug 2021 14:32:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E3C6E980
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 14:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQOsHTWI73evx95a7YSqPNKsQo0wJn/e/Ilif0P3cf9cTZLPjZit3adK6TAn0z5Mar9mtvHl2l//iOv817cuzgmgwMA0NS3qypb2ROCy18WKS57esq4uCOmz5HdqocEx2q1EP3g1ooY4BkiHm40/ewsO721aAV6LEAUfnIxtNNWY0Q4gHcCTXUZHf7glFGIpm8aDZeZTXuEM06YW/OBo5KHwbT9chyWVIqtmjfZNq97nQ/QBeKsxgdNjXkQ8WgwAgA9SEvJiwtPJZ06YKZ4vfJGjB2CFT7MawDhLKLNW5kIkWxA4nSdexaVCjKW+S4/nOeOsaqdS6QDGagikxVZ6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB9we3MOFAzjq6LEJhui9TjyXlI3MsYv1DC4fQOzJYE=;
 b=alkvaMou1vZe/NOEcuFUnceh8of4mkfTQQc/dos03hgCWV3p8xoUL8NPj0pVNi4ycHO/OMFa0e6bU12UYn7Fpy4SoRASDIk5ZctRFYLkuRrIf65j1teeVvZLo6TMK7M6tWEDq+6zZ5CHT9G2mMFEN16qXq6Bk9xQ11zZK7QPTqwEALPIbuZaKKn+oitzTRIll5ealg9CM1H5OU8G9cH7EgiGW5rk2hv6sygXPV+uzQ4ySy25cR6YWfGw1j5A8vtjxPdg+NlraJdBmW3Ahj71vxB2caKXOHlnCEB7W5S8IeAsS+06KTcEUDVF0WHkvwmF2Fqy57vLCg/8h/5cJGTphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB9we3MOFAzjq6LEJhui9TjyXlI3MsYv1DC4fQOzJYE=;
 b=KGoF97cwRevAHFxKddHC27BMeQuXjEYrhVt0UwrplFAL0RwVHcA/w0V8h1U6smrLfHWdWvfJ2t5QGuKsfO2G5PS0R4gGCUzrq8PJDtjUJ5hacYmdOTsM5MejjTwUX65nZFGRlb1GcHPhQDGa0gjdW4n9yJbmQ/eSI52BvUUUHtw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Fri, 27 Aug
 2021 14:32:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 14:32:49 +0000
Subject: Re: [PATCH v2 1/3] drm/amdgpu/vce: set the priority for each ring
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com, lijo.lazar@amd.com
References: <20210827124300.14593-1-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <04b17c20-8c0e-a2bc-4e70-c1cf24799c8e@amd.com>
Date: Fri, 27 Aug 2021 16:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210827124300.14593-1-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1ea5:a2d5:a05c:1ebb]
 (2a02:908:1252:fb60:1ea5:a2d5:a05c:1ebb) by
 PR2P264CA0044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 14:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b17e2b0-f815-41b4-70bd-08d969678b34
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486810736B0EA574CECBBA6283C89@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyh88YjpWvwSPSclagMf0l4RjyMyu5vJSochlJ6BAj7b0MYVi9fGzjMLQ97IWNiguJPexln1Ck5UR1w9lK7yekSBNDBJXCm8tnFCt86RWiqE2OXSSYWUgM1oKKHgaPMTUDCAVjsiIv4mmZFtq4/YMC4oRSNLK2n+izAbktGRnB3QNK03HK4F3QZP4XXvSCtfnj3nBhzYTkJim4ULu1l5rX68CM2vy6QJ/gkpLO6ChJ2pmPvl0Dg8PpC3FZBq8YZr9MQdV3uiB5SPNTsH89HuPIOh/tdrmPaU4a5Ceq9esrYVGyC3zPM7gjmVW+nx1fT6RDvaxBf/jO/0Ar4xUKw4EBv1faj8ZQIdOJDWNwMFu7fy1cFIDEYk3N9JvoKZz+n8dltBdnSu8i8atSTGU8dNYuHLRkU98tCXcKD+3CmU9IeJnhx8FGux3c9SdwGKjIBPOt8U1CCqAxN4xxzVEEQd/39F7VN8lJgAb6Y+3uLaa1JPzvoaWhOG+QUtvPTEYoG84wQPYCaW9n+ZYAwjgGKysVmVs4zNa/Qu4ktHzDiSNaJEslwR8ts/r5XtmofRfA0DlTTxueTpnoa5rAblJvXNPTUD7ldqIrjNECgmbPGXRU5Ccaxgz7p3jtR9OpFi/d8EODaV659QMYiJcl9noNAg3pL7CXkfgnAFMG7Won2GfagxtUpwTsx5I/01LYccm44Z/G14f1jOaBz/AlMfRnYwrWG0q7Vp+hp4J4UzlFhDR8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(5660300002)(36756003)(66476007)(66556008)(6666004)(6486002)(31696002)(86362001)(4326008)(66574015)(2906002)(478600001)(2616005)(186003)(83380400001)(38100700002)(8936002)(8676002)(31686004)(316002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a096ZXNDWStZaUVOR2x4UUxEYkhSRytQeEw3TStLNG9yd09KQXFMR0IzdUlT?=
 =?utf-8?B?ZllKaGw0RVU2R2w3dGdaaC9sbUhTeUxMZ0pDMFhueTZoWTFzVDdTcUdjbGM3?=
 =?utf-8?B?eHlxUWkyRXk2d0F0REhzR3BtbFN0a3ZOQWNPNXFFaHpGVXdqcWNnVmJNcFlk?=
 =?utf-8?B?aTN2elNXTVg2YzdjRmZOc2VhTzhhL3NnRHBnUVRJeVVucFBFcnJXakkvUUpW?=
 =?utf-8?B?dG9Tdjg4bU5LbCs2Mml6SjgxeEYxQzV6azZxZ2luRFNJSzRyNHJ1RTdPcUNM?=
 =?utf-8?B?TkxRWUQ4UEFRM2VyQUE5Q2p2VmJxMUE2eWVlNHc5OWZjZTd4MTZZQ1BjTzJJ?=
 =?utf-8?B?ZjZka21XK3liVWRWTmM1THRXenVOOWRQZXQ1T0M4aE1JcGd3T1k0eENFOUc3?=
 =?utf-8?B?LzE3dFBRakRRYW1mTmpaSGQyMjUvellBUEhUbmpMM3hZcnUvVDl4U3dyazNZ?=
 =?utf-8?B?b3FEVnpOcG9scDVielVkUE1lSEg1cUFnVFMranNHQXE3WTlOWDFlT1BmWGk4?=
 =?utf-8?B?MWRQVk0yNlNORFd1bE0wOEN5RjZ1T1JaSU9KRmlpWHVENVR6MG8xR0UwWHZo?=
 =?utf-8?B?dHlPbHJvNy9lVHRnN0JPRzMyVk1uMTh5eDVpQWxPQnNPK2dTT29XbW9wNGVl?=
 =?utf-8?B?SUwvMnNJTEx0ZEQ4TGpPSXkvUHpXQnVFbFdvcXFvT3BjUzdkVkhRdzhIQVZh?=
 =?utf-8?B?czhlayt1cUV5bzVGSGZXRXpWNDZUaFNLYk5KcEtIUjNZWm1QWUZkS28xd2ZQ?=
 =?utf-8?B?WHU4ckdsNEJZYlhmUjNlTkpjdDZyQ1dKY213QW1xYldJVW5EZnJWSGJGeEpT?=
 =?utf-8?B?QmY1UXdaanVxSjArNXNqVkJTS1o0MjFNZVlGdStjWVFBa1czWUd0OE5ScEky?=
 =?utf-8?B?ejhURkNkM1MxNDlPOUV3Qk53ZU1tbmJwdjRhd096VGJmTmM3cXY2ODFndUJ1?=
 =?utf-8?B?cUlySXVScll3cjdFSEVQRG4wRndMaFk1Z291NzNvbDIxRmJGd09hWWI0Ymts?=
 =?utf-8?B?bjlwQzByTEFPVXh1MmZzQSswQTNFczk3QzZHVk55N012aHp5cmlNdzlJQkht?=
 =?utf-8?B?L3dMRFBDNHFmd0FVVTMzWjh2MmYwd0tkcWNoT0UzZloyaXJYMWFadkMzVXVI?=
 =?utf-8?B?WkNPeTRWTHU2aU4rOVNXQllhZXB3Wkw5UFFGc3QxWEJqaDdGRC9tOGtMTG1x?=
 =?utf-8?B?cXJoRXhjNVhjZ2F4UmRFQkFYVUszNFJlb2NKempkV0MxMnZDdURDVEdLVktj?=
 =?utf-8?B?Q0gwRU5DYVdja2NDRDBwYm1pTW5LMEVxYTVaVURYNU1PVU45d2psR1JIWFdh?=
 =?utf-8?B?dEZ3RUJUOFhaVkdjbWl2NngwV0M3VzVka1R3WWRVUUVjbEtEeG1qbmFtbDhp?=
 =?utf-8?B?dUpFSm9lY3FDMkw5eUFlVXI0T0ljMCtQL3VmVnRwUWhQVzBCOHc4Y0xTY2Jv?=
 =?utf-8?B?eGoraGord1pIcDQvTmNDVDJnYXlFYTFMVlBqeHlvVmkyMUZMeGIzU05rdTJC?=
 =?utf-8?B?aGQvYkJKZnY3ZUp1S0treWxVTzl4dGZPNGtrOTNKQWZ0ektjRGI2TC9PTlMz?=
 =?utf-8?B?SEZndjZvRGZaMnFGL3dlTEp1UXU3V3VKL2tMS0k3TEVOdGJmQTQyOFVDRExD?=
 =?utf-8?B?Rk9COFYwOEYzeHB6K0lHSUdRR3pidTl6dWxVOHRDTUF4UVdLZlFSbVI4T1Rs?=
 =?utf-8?B?T2ZFTktlLzdGYW1BcXBFcXlJOHNhaUtNWkR2MGg0cjUvdkFGY2dGUUdsL0o5?=
 =?utf-8?B?UVlnNk9HZVgzOUcveXNhTDBwWndqSkQ5K01GbngveGRmK0FZdDlXZVIrTXBp?=
 =?utf-8?B?RmhKY2s4dHdCeFU0SnF5c0FsSE1UMm9hSWxpOVgvbVhtbDhZWEorWER2cFBn?=
 =?utf-8?Q?WFBmHMOMvkcth?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b17e2b0-f815-41b4-70bd-08d969678b34
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 14:32:48.9622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViXxFx74xkaJwRpbn9dtyNEbUAUiXQUYaRSnlNccbb+YFvE0Ye+bzRTW4UGwyr/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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

Am 27.08.21 um 14:42 schrieb Satyajit Sahu:
> VCE has multiple rings. Set the proper priority level for each
> ring while initializing.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |  4 +++-
>   5 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..c07d973a2946 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> +
> +enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring)
> +{
> +	switch(ring) {
> +	case 0:
> +		return AMDGPU_RING_PRIO_0;
> +	case 1:
> +		return AMDGPU_RING_PRIO_1;
> +	case 2:
> +		return AMDGPU_RING_PRIO_2;
> +	default:
> +		return AMDGPU_RING_PRIO_0;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index d6d83a3ec803..be4a6e773c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -71,5 +71,6 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
> +enum amdgpu_ring_priority_level amdgpu_vce_get_ring_prio(int ring);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c7d28c169be5..8ce37e2d5ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);

This could use the enum name instead of unsigned int, but that's only a 
nit pick and not a must have.

The patches now lock really clean and simple to me now and the set is 
Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3b82fb289ef6..e0bc42e1e2b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 90910d19db12..931d3ae09c65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>   	}
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = amdgpu_vce_get_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		if (amdgpu_sriov_vf(adev)) {
> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}

