Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D4DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71EB601FA
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 20:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C71EB601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB346EA1C;
	Wed, 15 Sep 2021 20:14:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DA96EA1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 20:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRM4U/0v6ZTwYni9P9L5jrX3ep99krN66ngYgJNHHiq5Fz4x7JZZ2RllNnEwDcx5A8VvNunN7ZqdzMv4ULrY3PcF5hCf/Kth06+uEXZ/OPkxXYC6s+1YOjr5C8J7uFVoRnkSyBnxpdRQKkuSpA8nHC4pVme8nWYbkXL23Qb1ds3aUlBoV0ylwNt3wQnirqkZ5ntue9CG/w1hCBky6dUiiffdkU3i1rtUbf+2Hz2LyP6cTJMtwaOO2Q4Dao1ab+EvktWNDiwo4xoMjYPSNKjbgxglzsXsAK93XkZ62FSRjXWkNmOjSGNp4TAsMxjyk4p6qqdtfSx4vA7TwXnC0a/ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=PQqt0IJo8+D0owOQ7pAf47uchnI8Ug2kNwxlG3rRQ2E=;
 b=c+g6zbmL09IUp/8CDxJIXEyGWW2XGRjeFO6AQU15JQDrCrYPz2Zw2hxBXbgc0I78dkZGvpV3JV8KnYSmRH0t73MVqIggququsMn9H4tYSeGVfdxTdL+rE6mqNgWOzB+yM8qcdQZoJpwcxNpuyJQJmnlvPP0rcMEDdzE6p9KFIRjBVrkEnwFB0dVCru7AavfW4ITYrXVXXFQQDq9zUeLmZcbQZZDgeLV4TtAN+rU5sKUlSidx18kt/59qxdMKuSs342Q9oweyAVjs3VTJKeMZQhW3uVVEQpFAIVo8aONje/Cgm2dGKijcylfxqeZJMJO97kyBcOnz6biazR2SFMqefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQqt0IJo8+D0owOQ7pAf47uchnI8Ug2kNwxlG3rRQ2E=;
 b=uZw4rTtiZOaZeHVYpCr+Tt/sy04ziTw42SnnkkRwCyqQbBWL9d+C+GGdK+11JZM+WC5QCGIEhZy3eiLns0lDo5JO3+4Bnz++9mLLsbM+BsTcW2puoKMoDsISLREILvmhsEaQEAUsJ4ey3j6LJjH9wta4693Ug+GvlCKNOgyIQng=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 20:14:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 20:14:39 +0000
Message-ID: <6aa67ae1-0f21-73ef-d8e7-7d1b58826f10@amd.com>
Date: Wed, 15 Sep 2021 16:14:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] drm/amd/display: Fix crash on device remove/driver unload
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: nicholas.kazlauskas@amd.com, alexander.deucher@amd.com
References: <20210915201150.476919-1-andrey.grodzovsky@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210915201150.476919-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:408:f8::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.38.13] (165.204.84.11) by
 BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16 via Frontend Transport; Wed, 15 Sep 2021 20:14:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c8e33b-1397-41ad-7966-08d97885721a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5476D1B0E414749293C6C9A98CDB9@CO6PR12MB5476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5xSewWO3VqCCAA4HMDKuccMY9RyjlJe5JFoVxa8+WOP1GaDAImzayrFZjsAh+kTW3qMQk/sMjUCrV8v7xPgO3Glctf4lbnFZ7MelUBvlDgGaPXYW4Mfj4OWNguL4A7J7MNMBzGWQoz52q4rb79MNR6+j87OEFgMNtk6DxRGhSeHCBtYHobf9F9rsPRkrzQ3kLpglJTlW8ySUutf31lmzuLFokwBRw1zmbz1z9tXqDIwBOthToaa5QKGLy48p9hcPRp2njJ3ErpLRHYmBVE4RH2XQB3oz5P9XDfOizswJdRrT7GlSIaLt8SimnZDkWWxma4Z6A8rDZkQain4UjecpiW3mPyKsrVm6QcPO9b1tZMpp2LMGJctDe1c0FgghvmQb1ogBd6IfJUbYLT3gekirWWhPWDyTQisWvjZSoRTH5xrJff/S0rYj2NxhHHj0KOIXnRTvXIiXZvwCA+XYlbk5jrxI7oShSlRTVlVkc6xiaa43lOxtWiuG22KwE5OHQKYqUh5XT9QMqOr6seH+npTEk+0Dixwy0zYgrHQQH94kNchZFBDjItGwczbft1OHJXwYDFyePrKG4/E1Hk4AmfYWNkJq9wWYWzfNgrVQg1cTlKrmrsovri5mglddWWJ1JJ1uF77oKp6SbqCQjXjvGlQzMjXqpLTYLX8sPz1tkzmSGvp+QNHMwMn46dxjkxbZz/6kKAvtLvX8QUPIucvkrXjdUoCgU3vnRt80bn52V9VqLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(31696002)(66946007)(956004)(66556008)(2616005)(66476007)(86362001)(83380400001)(36756003)(38100700002)(44832011)(8936002)(53546011)(2906002)(8676002)(4326008)(26005)(5660300002)(186003)(316002)(31686004)(6666004)(6486002)(16576012)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FEWkxYb0pheUNpbjRoOUlyV08vUUNvVUV0ZVpQeTNPNjN1cjE2ZkZOUGIv?=
 =?utf-8?B?dEMxdFd4UEd5TFIrRnQwL0ZJb3JYRTNGNCtoUnFhUUJJQ1p3Y1QrMzVjVDRC?=
 =?utf-8?B?ZWM4UWhPR1dtZXVPb3Z6eDBYamVmV1ZzdE5mR0xNc1dlUmpGbzBBN3p0YmF2?=
 =?utf-8?B?OXA5SUx3TzZXVStWWmdpQk5mNDFDRTRzbGh4d2JZWWxMeEY2YldaanN3YXVq?=
 =?utf-8?B?ZHZoSkdpbTVzVWJHRUdpendsejl6ZFVNdlRwV1NzbWJYQ0tKejlTdXk5SGIr?=
 =?utf-8?B?U1U0bExuNjhwVUdNVWZpR1JpdFJZanNuSmJnRzNocWpKb2J0Y0JPems1VWlI?=
 =?utf-8?B?Nmp0SFQ1ZHhVQWZFQzJJYW5sSXRKUVhBanFmL2RuUGRBSXJHNS9BWThIQWhr?=
 =?utf-8?B?Zk1kQW8xTWdHNlBPVkNPanBWeVlNMEVCaGpLVWJLYlJGdEQzZjZMeWVncC9h?=
 =?utf-8?B?MStJVGdTTUhhSU0rWThUdkVDOXZPSXFobTZyVVIwN0FPTFh2VDVNc1JsbWYr?=
 =?utf-8?B?a3lxWk8xSDIxOUExT29mQ3BmemxkN2xqN1E1c1hGYUc3Smt0bzVPQVdZMnda?=
 =?utf-8?B?ZGFEVW1XSVd4WEI1WlpXR0JlMm9wL0tJcDJ2c3RtQlc4b3JxSVdSTGU4bmdn?=
 =?utf-8?B?QlBhaE13cENrQWVIMEgvRlJBUHVPd0xaTVpoYk1pd3BVUlQ1dis1L2wvVTFn?=
 =?utf-8?B?YjVEYVFYZGs3Zk5MRGlka1VNbDA5bjhXbGtzVkYzd0FSbHJhbUh4QVp0QlRN?=
 =?utf-8?B?SVV1bExuUFVEdVdWYTI1cUIwWnF0K1BZdHVFZUF6d1lCZTQ2cDdMU3cxa0Qz?=
 =?utf-8?B?SmtFeURRRytpNVJreXo5Z1k1S1hCUUkrMTYwM3lkN29wYzV1bTJvVWNEOWZQ?=
 =?utf-8?B?ZTR5cjZTTVFwMW90VVkwSGNCZFh0czBiUWI4ZkRJNTJtcCs1a256ZmF0ZnVs?=
 =?utf-8?B?Y3h5TjJqaFFmM1Z4ck5Yakg5UU11VFZEclZhZ0l3VGNJTWdSd1J2aktqS2FD?=
 =?utf-8?B?bERKbE0rRDVZdmljUW5DeDEyN3dlbmhHUmtRdUJQZ0QzZjRveWFRMGU0eWVE?=
 =?utf-8?B?eW1lU0M3QTNybGFUc2RBWFNrQjB0RE5VbUwrZzZycGs2WW5YeHZGRTBib0dx?=
 =?utf-8?B?UU9xYkk4UWw1N2hNZ0V3cGZPeGlsbjhoeEZkZjEweHFGZW9PN2pQOGV5NGpq?=
 =?utf-8?B?bEx5V0JGdG1LNlJ4RlBmM21tRklvUXhJQVdiZ1VRK3M3Y0ZKWWJrN0JvS1ZC?=
 =?utf-8?B?cnM4dWJuVlA2bStaTVdocVZRdXBiM2lQZjlwSStIR1FzQ0xMempPSnF2UFhs?=
 =?utf-8?B?UlpEbExnTVhzVzMrd3l3RngvTS82YXF5MkFibUludU4wTTBXTXNmdEdKcDZX?=
 =?utf-8?B?REwvL3pqZFU1WnJKRlFBcy9RaGtKeFZNZHUwTGN5WURlSzZxdFNVTTlES0JK?=
 =?utf-8?B?SVZzUWtEZE9qcGJsSUFXTG9lN09FT01KN3pnVmx6d1V3bFVub2dPMmNXb3ht?=
 =?utf-8?B?aXB3dUsrbTFYMkhFYzhJenJnQU1ORmhnczA4TFBsUEJxa1BwZVc5TFlQTGU1?=
 =?utf-8?B?Um9lUkY5UzVQMGpNamwyeE1sU21CejhFL3dVc2VDWEFoOWJzNzJTVG14SzJa?=
 =?utf-8?B?b2FmZTM4djdkTy96VEVLeVcyTklScjhhamhZQ1dvTFdETnlBRjM0YTZFK0FD?=
 =?utf-8?B?dDhORjhVa3k5aWt0dkJjcEJYUC9KZ1V2Z3lPUmdvSjlSejZ4NTdDWWRRb21m?=
 =?utf-8?Q?fQTk35xfCUseMLfdnKgpZqGEu6DkicdUMAt7s0i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c8e33b-1397-41ad-7966-08d97885721a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 20:14:39.1291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt92Lhx/xe/K+otse/nDjf6X9mwUY+4bxt3f/nIYKF4fJ8V9hLoV00Q70ABsFOEjhIhZXWsBUFCGG8FYQebluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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

On 2021-09-15 16:11, Andrey Grodzovsky wrote:
> Why:
> DC core is being released from DM before it's referenced
> from hpd_rx wq destruction code.
> 
> How: Move hpd_rx destruction before DC core destruction.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5d3679bd6b29..1c0547bb09de 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1572,6 +1572,18 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  				      &adev->dm.dmub_bo_gpu_addr,
>  				      &adev->dm.dmub_bo_cpu_addr);
>  
> +	if (adev->dm.hpd_rx_offload_wq) {
> +		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
> +			if (adev->dm.hpd_rx_offload_wq[i].wq) {
> +				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
> +				adev->dm.hpd_rx_offload_wq[i].wq = NULL;
> +			}
> +		}
> +
> +		kfree(adev->dm.hpd_rx_offload_wq);
> +		adev->dm.hpd_rx_offload_wq = NULL;
> +	}
> +
>  	/* DC Destroy TODO: Replace destroy DAL */
>  	if (adev->dm.dc)
>  		dc_destroy(&adev->dm.dc);
> @@ -1590,18 +1602,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>  		adev->dm.freesync_module = NULL;
>  	}
>  
> -	if (adev->dm.hpd_rx_offload_wq) {
> -		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
> -			if (adev->dm.hpd_rx_offload_wq[i].wq) {
> -				destroy_workqueue(adev->dm.hpd_rx_offload_wq[i].wq);
> -				adev->dm.hpd_rx_offload_wq[i].wq = NULL;
> -			}
> -		}
> -
> -		kfree(adev->dm.hpd_rx_offload_wq);
> -		adev->dm.hpd_rx_offload_wq = NULL;
> -	}
> -
>  	mutex_destroy(&adev->dm.audio_lock);
>  	mutex_destroy(&adev->dm.dc_lock);
>  
> 

