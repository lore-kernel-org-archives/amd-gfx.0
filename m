Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B563CDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24EF10EA1E;
	Tue, 23 Jun 2026 08:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nL0NwPG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC10310EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKIoJub5XgGIySJAJ1VwZ7N8ubTm6BmDXjYeUkqUs1eunY1iGUo76uGzdLtBBzESQ+fBeC1u3oTOyvRsmcFLD/hbbvD1ma53FgAD9dMR/qEhC7lcVK8GD7PCjp2KOPCdkf9aOGnkuijsxEEhWAg3V320idtsZxt5UQnx+C1zB99geDvkKaKxxYwvqRVeyWpD27RIFe/qqaCBfmaVm617PhfXsdChBKnwOV5fxxp964qgFG7wztsJH+EOilC9xV3m6WQusK1ooG1LMI6CC6H2aj9cBurIYOoW+cqc47FZ/HQh9KpRaJ8jzSHB6j6Z2wj5xnegK0WKy5PFuONPwVS9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfDxASUi8bHaLsqWYfscg9oWJW0d7WD3ijfEP1ksKRg=;
 b=jMRIgqWD07qoQp/APhZQ5K2dkH0lo9vumh7Z9qPo+AJbU0Q7/ol9OEhXv6gBT+nCMUMXadASnKdQ55agD4ntSigqDfhvxz9lPuUKEjc/GJWqe2gcm3lkD10JZnyktPXeAG1C1db6P3dvRGLhmnpFs9FslFPk5it71+0C/dkflv3wMfnQNcXvS/IcDr7fNP5lEz75CeuG62FrqxFelElKBrN2Bjh3pLXWdTN79AW/zQnq73h+ZWiAHjc6ikhCSBJrc9wNxDpg7pGSENRX1GuopgZ3ZGtOB9PR7DrofVDBWbhSah/GIfQAHXTtXtonbpkOr8vYYsCxOD/I9hBX664CoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfDxASUi8bHaLsqWYfscg9oWJW0d7WD3ijfEP1ksKRg=;
 b=2nL0NwPGesPWeb9u0MIb/jGNLTMPg6rizPAiAXE3S/dmTlU2DbWJhk2AY/A64x5NrhNX3JM+6xyon+hgyR9xkMQWiftr6XugxA1GDMmiGs4ksahjr3xfp5aLLXtWkLsgkmeBFStkh7ZVCEnPeTgRoHDK+Uuu32HsTu1lSPIL+f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:52:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:52:58 +0000
Message-ID: <3bfb3c43-bd9e-44b0-9dc1-a0d24ad305ed@amd.com>
Date: Tue, 23 Jun 2026 10:52:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] drm/amdgpu: move struct amdgpu_wb and helpers into
 separate files
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622195729.181216-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b2009-efb0-416f-5ce2-08ded104d2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: SuyM9pube+P742YfKcVLQIdVa1+FoTlVd9D0dH15ikZ3exTehaUJQ8DJjY42B50iPGYzyyUSEFroZjz6IaKtrv6SihW/fT07DrzSsSNLxwAnKoD7IvJa/4udI4U8/BUfajzzDdfmXDFVHBXtbXOdZpIoPoJUcIRpKGvG0EiGRCpoiBhuNiOc2PsqYdlne+W4w0DREqyob6xPLVrOdsKGipvhg8PsAVrs3C2Q1jYlCC1Z0AmJPqKFRgW2fDXLG8OQeYUyw0mZSiPxoq1UWOiiVJ1d5yRcvNZGCZUzixIu33InPN+2YZNqL305fM/3QMjsSGYYa6g2gShC8taQeOjbf1SSXSCnT+Q5j8emtkxYYtWse4u40qNWKHLjMfp6xL9u78ccnVNAv4srOUEmoXTj+MW+F/759sfNH4YV9Dwuz6T8ktRp0NBEIFiZMxCVxr4EyZ3CBUREK8wPmqaor50s86oRmGGfEMDXp0SASX/+xdSJKVW6HZJk6lLLnVU4f+nKXgefHl7jpf5pRYAUBeMHgy6ZxgBQ1DF7RNYAacu5bnnhtd9q9SBc+mN24kqshj37PK/Yrs51bMrmSNecGW+0oxbwDBBbg4fhrY5HkNAYPIcnMwedXUwfwTAFxDO1NRjzHLz1a4qY9e/IgU963PSqebx1hYrqrJtDX1U5PPF0vD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdkYy9GeTBqWDcveTNpaG1Dai9kTC91RVBSbWhjeEEvVW81b2tXWm1sYURp?=
 =?utf-8?B?SmVKa2o2YU5IR2hGdVI5ZWpmeXdxZnJSazAwN3V1eUZyMWpGNVBacU9Xa21P?=
 =?utf-8?B?bkxwN3NwRC9XeVI1U0NjUnRITGVQV0dHeGthRUd1V0l6QzBzcHBMd2xxQkVK?=
 =?utf-8?B?Mm5qejlIY2dPdm9jaHloYjV1MHh1NVE5ZWQ2OUsrUUQvNm1wLzZLL0N6YWFo?=
 =?utf-8?B?U1FvWGZEUWEzZHgwKzM2bUVmelhoSjR4Qm42bkRMYi81WHhEWTRwN3FhVXdi?=
 =?utf-8?B?dnBGRkRJRmgyaUdjbytURGxqb3NxQUpmelM1ek5lWU56VWdsY2ZFU2hBS2Zm?=
 =?utf-8?B?MEVXa08zdmpmZzk2LzZsV3hTenJ4YXhHOU5WTzZlNTE4b0VzaTgzaWNXQm1W?=
 =?utf-8?B?S0NMc0F3K3dhREhwcWxYTXlHUzBwNHhhMytWTnI5ZTVWMmd4d0VDUkppbXph?=
 =?utf-8?B?WW93Ly9KN005SGxZSXMzbVZHelJRdFVrTGdDS2hCZkthNTJxSU1DcWYxejNV?=
 =?utf-8?B?cytpZm13dW5YbGlURzR2aHdzTEdoOEtLeXdzNnpBU0dlNjhLcHl3QnpQZERh?=
 =?utf-8?B?ZVZaQXMyVzZldkpiMG1YeGp3V2EwaVlvMmNQeUh1THp5WGZ1VEsyc0pFRXND?=
 =?utf-8?B?c25lRUsxaEZScTJLSWFyTXl2ZUJGTm9wckwxb0k2aWJFM0E2Z2x0MitOOXNp?=
 =?utf-8?B?QWxmcXNoTHhITndsQzY5Sk9hc3BEN2xvcEtCdXhhODNDQ2JoVklhR1lqb0NI?=
 =?utf-8?B?NXhWa0FwM0QrTXNyQlNtQ0hYMjQ5ajJDdlJxazhoM01haGJZcStzcnBBTTdz?=
 =?utf-8?B?NUsrUGxsOGlTS3lMb1JCQndqdmEyajczU1lpRHk0d0FiOW02STVrclVaeXF6?=
 =?utf-8?B?UTFRV1VPVGdHMHZncGIzdjR2NmZNQllzUjlKblluZjBiN09qQU13VzN5UGFp?=
 =?utf-8?B?V1dFdnd1cGdiVmFGQ2NIU2NLd3E2MTl4NkJLaElick1HT2tNN2JjZklvRlg3?=
 =?utf-8?B?dUx3cWxaa0JpODVteFllcFhTMmx4THNLV1hQUXljZmJheG0veGFrajdCWE8r?=
 =?utf-8?B?c1hmZ3Z5ODN3RTdsZVllY0RremRoakF5NUhXSDZzYWhxbStkVFdPZ2Y3MW5Y?=
 =?utf-8?B?YVFBcUNJMEd0Y2NqZ0VhYXcycXVMVmh3YnEzTFhCbk9EU3FZSFF0UytSRjFa?=
 =?utf-8?B?UXdoT0U4YU4zWDZHR1E1Wko2R1doblh2SHovWnhabTF5dFFqcjEvYUhqaEhi?=
 =?utf-8?B?RHI2MHFUOVVFckNnYlFab2pvQ2FIYTAvcUxKUTVVY3loamZxek52Y3VNOFRN?=
 =?utf-8?B?YU5zN0JlTlh5aG1ZRGZMbU1SbkdwdEtaTmRiUzc5MWhnTVVEOExwNTFiYjB5?=
 =?utf-8?B?WVlyT0ViNERmQzB3RFpyN24zT2czN2hLcVRaK0dMeXVsNG5JbEMzTmE3SkFG?=
 =?utf-8?B?WVJJb3pieVFxYzg4cW9IT2pYdzc1MDdTV0swQXJSNjB4bndTY2pSS2x5dUc1?=
 =?utf-8?B?TlQrQlJvaEdRMFFMeDFjZTNUOU5rQldVUG1KbERLYURuQjU4SnRkVzNSRzVL?=
 =?utf-8?B?V29vZ2w1WVozUXMvQWdGUlRlcSswN3g1WEp4aW9BQjc0UmN4SlJoV3VidXZp?=
 =?utf-8?B?aE8vbkJOYlRlYkptcURORk5OZWtFdGpSOHpBanlNWFc0U0N1UUJuL1dvOFFE?=
 =?utf-8?B?WW04UGFBRnV5cnNSVUNOV3VWdC9CdDZrOVYweGFoQU82amxUWDdEQVlUNlUx?=
 =?utf-8?B?bEtNeTJENTBSaWpKYW1CbUlVeTVXdm10RjliU1BMNzVTemJhV1Q4b0pwUk5G?=
 =?utf-8?B?Um5uVnVvV1N0Mk1PWVg2QiszN0ZTMlhRY0xzaDJuZUhnQWFxQXV1SHl5TmJQ?=
 =?utf-8?B?bXpTMG1qUW1KOEIxdzZINk1Ka1YxNkJ5RWo2VXdETWVsNzRNQ0xPUG9sQ1pU?=
 =?utf-8?B?ZXpOclcvT2UwOE52MlFYbXQvekExczNIUVBkSjdJMmRVbU9BUGNqMDZBZjYv?=
 =?utf-8?B?a1U5VTFmZHNCUmlXYmdBL3pnbXdNcWNua3VDT2daMTcwWnNUeDBObUcydjRv?=
 =?utf-8?B?SWpVOXNwTGNsR2VpZnBSeEdqZmd4bnRnR2JiVlIzUGN6M0F0QU9LWkJXaG9S?=
 =?utf-8?B?VUR0ZktlbEdWZ0h2M3A1L0xzSHU0Y1dmYmk4NEdicHhoZHBLTHNmQlFZN1ll?=
 =?utf-8?B?MnNQWm1wTStjajdPNm5UYmxCbzJ2NHBhdFJSZlcvc29GdktOVkYwTm15QXEw?=
 =?utf-8?B?VU0wTXQ0VStYazBqbjhWenZ3M2VGSStCMS9CR1lkZ1NJYXc1ZURNNS9LS09q?=
 =?utf-8?Q?gy0ZnQOO35kGJwyRn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b2009-efb0-416f-5ce2-08ded104d2e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:52:58.4269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQUYEXEttffLcwePATrhSPeHTvpbcyYXjkGPLh7C+D0mviOPsc1r8xcgQ7otn8BH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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

On 6/22/26 21:57, Shahyan Soltani wrote:
...
>  /*
>   * Benchmarking
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5442a1fc1c37..d6931e1184d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1063,51 +1063,6 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
>  	return 0;
>  }

I think we should move amdgpu_device_wb_init() and amdgpu_device_wb_fini() into amdgpu_wb.c as well.

Apart from that looks good to me.

Regards,
Christian.
