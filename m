Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7FC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 14:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983BD10E5E6;
	Tue, 15 Sep 2026 14:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtYt2ksD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE4D10E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGAY3OSRBsP/kZxqDEMIf6F1VJSiTS4hwLhYpy+UD3TwRWNDzenYgEZvQEySEdJzxppvkBVAObTaRG8KGN6IEKVewDCQq3JskQndudYymNgkRvuHNWdfOHJaFvFUcrEKlwt0vZNboKjqFOrAe/DXhaKzdQTOsqp00HJ9FT01Z1wEfQNBDiUeq8DqhBQN8GomJEU8w87HBYIFQOIMlcQ3fVpPCqdwe3K/zEZ+5cd5wzdTZMTUngL/0mWu72k2BD+XpgOSracAMNFMVZpCqFPoRMl+ArTZfPxwO8EtgJv9ECmD6pzEjbqG93DlpK6Rs+AIdm8RvW9JOeeYwFvU9VzvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7rKam6YeYTFWT3F1YhKp1KML2opZzMY+Ei24lBoI4k=;
 b=KfzAhRMag6CmDNk3h/4wgWtjPROUZoZFZF0EQ4eYfGzArPmQ9Z7zPjSfT28X5dFSFT+ZMr/HMuH5J3QHE7Z/s+2bX4OnJYjNwhApNYfmawZOWmv8F07OlnsCFzm6L8Qp5DoUUtweegNDGI0+uC2ZzKUd4vqNQq79Iqimpo5dTWHZA0IGaul00/+9To7JARaH0lFHbeLrlK34w+ImMNNvKr9RoUp2Nuibe9t7gjcXg7DGOXIt+3+S5iSI4s05M+x6vzlDPqDQPScboRyIqzLwldrcAs46ZYnHOJBURaG98JkIgGRRXh42+wwUBSsxFZP4VvqgAORU6RlOfm1Y5towng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7rKam6YeYTFWT3F1YhKp1KML2opZzMY+Ei24lBoI4k=;
 b=mtYt2ksDEPo3cyhO9KYD0kF6yMiJGREYkKQgfbU51xHVnY51K2Hw9oqfKY2915pdua+j9Vt4vdB/XaxTrYlOhfYssHuAiw2d4u9XbQLhVZPJ06ub14i0cQPvrrowbKTz8XwdJTknxxCSgiExcHBd9GY3kDxmT8BPFxQZwJojgRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:02:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 14:02:38 +0000
Message-ID: <633738ea-bde0-4658-83e7-9cdf0f47c2e5@amd.com>
Date: Tue, 15 Sep 2026 16:02:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260915071946.710846-1-Prike.Liang@amd.com>
 <20260915071946.710846-5-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260915071946.710846-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 7682ef54-e62a-4af0-3ce6-08df1331ffdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|10067099003|4143699003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: eqQH0waag4E6nuJDS8raN7RtLue0f/ajPRzUK8oJzSXBODB+3/EPb6chXIKO9NQK5bl0NCDAkfDeidKF1K9f+TbzSzYF9C0vHaROVyojYp+6qF/9LzRK2J00qXijx4IdYcFTfdZLa+67AMVFBGICxIZUNFF+kWHj3p3rAZSwQ3gDBQefIbIC6Jar1PuqGdQiG+Mdn4SzMTz4MPvwCG2F7uN+I4rv7ooDgT1MdPRQ/Ils+nj2p8t2PowOoWwzOJyIZwJ6dssttD0G8UqNfuktcGPxsok2LaOacc2CLrzGIqPqke54KQcmsQXRLtaRU/yk5V9OqlBRdHX8KK8qVSyih4CvFY4HtmGwEIXZ/L0bxn2pH1jneNy6e+Ds6Nvil41RO5qkm9XfnoiEZQZeL+Kqk8HDQoPM/wQWpfIOTCHmIf1KoXJXQmLNzM9zJ5zZxO/rFIS3aYtjgjsfMhqdW9BdcqXTMO/P7e0LTrXmCWwIZUlU5BPzp98wXGUjYnWPUUuLeVa2A7tIHUpiOZpu+Rl8cjPKy30bbQfOaYzqCsxVKiDYvNixmGLAnBH2alh5NfRNyM7LKg7yjpAb2A1O3ztwfnlj1iUiU0G6lkN/NqZBYCffqu+Wqe6BvVctpK09a43qb6yONRcNWBevtOLsHwwlHv+6as1tjFHlb5nAI5T4qw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dFc2RuTHBselpnRWd0WjJZZkxNeUxFWDRmdEdWdkkrMTJUcUNEc0NBRzhr?=
 =?utf-8?B?Q2hwMWlNWmx6VFdiUUwxaCsxaWdRRGxqMmM5VUxHdXZ1THcvQmMxaDVITVMx?=
 =?utf-8?B?bmJoSVZnMWRMQkFCOHd4L09qbmV0dmpIZDcxcDdacER6Y3A1bmVNZzJCVDk5?=
 =?utf-8?B?d2doN09aVmtHc1czYklveWF3cTg2dVhybnMweUxVWEdsM3F1akdlSlVzUTdY?=
 =?utf-8?B?WUJiQ1RTQktRSjBmd3RlTnJQZWpBSHNDZmVqK0traHVSMWZKbUd1VFVlZVhk?=
 =?utf-8?B?NEhRNkxUZDYySEx3ZitiNmdBMUh4Q3VlUFRtUFNuVkwraWFGS0dOd1orZktu?=
 =?utf-8?B?S202Ny9pYUEzOUI3ZnhyVHhwcDl5enlKVi9ZcHZRMGgwendiT3FHTWFKTFlX?=
 =?utf-8?B?Um1mL2N0T3lCeU1hR20xTjFna2Jqcld3S2FHd1plb0pMNGtkMzRxYUI4NUtF?=
 =?utf-8?B?c0o0Z3pxU3NRNisxMStzak9oRXU5RUhMZG5MOXFKM0VURitUZHYxeUIwSUxw?=
 =?utf-8?B?ZFFVMm1kaEkxclZaVkRpMEx2aURsZVBjeFM4QXJnZ2xUcXc0bHRvcVZEaEk5?=
 =?utf-8?B?UnNMRmEvclg4NDA1cHlRbXNLYWtPNnhoVmxjcjZyeW5hYmxIWXdrOFpJTGpu?=
 =?utf-8?B?Z3QycFJFQ0swWE5kVURxZmZDSkVNaW1zbmhWTWcydDU3aTlxLzg5NllnV2hR?=
 =?utf-8?B?QWR2UTlWTVpiUjJrYW9McEQ5RWRyd3ZiSWhRYW1sUXROa2tjWEFsRHdMenJE?=
 =?utf-8?B?RXRnbnBpTGVzQXNIUEZjYUZYRkdITGdGOE5WODBCL21DRWlIdFJkQnYvYk9i?=
 =?utf-8?B?Tmh3RHpsYk9raTJyc1N4M0d6Z3J3SUdWUkg3NTNGOW4vbUdUbkp1TzJqMW9n?=
 =?utf-8?B?RW5US3pJZjdBR1h4Yms4K3dRNm00UTBRVkdiMkR5UURUbUQ5Q0VkeWVmNU5N?=
 =?utf-8?B?elVyTU9ZRk5KSk5ybEdabWJBWk4rRVVOTmdra1hqMmx0REFVVjN3TnJmeHp6?=
 =?utf-8?B?MUFJRmx1d3QrckxHWHhQaTJvVTNlRGxQUzZtQmFTZzRIdFcyT1ZHYmlSNm15?=
 =?utf-8?B?MEVCbEl5VXUveCtsTTVnYnBGWUtZZW9McnJmTCtxVG9xelVhbGNoRTI0MzRH?=
 =?utf-8?B?bkVCbHoreTJYeVhrZXg1YlF3VTgyZ0R6N1pZWE9QNk1tZzRGMS9pQ1FZM0do?=
 =?utf-8?B?VWx0NWVpNTFPSmIyZ1VaQTNjb1JHUXFlT1k0WThFTUUra2Q4OEhKNXBYVkpR?=
 =?utf-8?B?OStIMGhHdlEvRmxFKzE5UEsyQzFCZE9WY0lwc2lCRHNWOGZBQ3QxVGY4Y1RQ?=
 =?utf-8?B?eS9mcitCSEl2Q29uM3lSb0Y5cUgwem9CdmVYaGhOTTR1MmdZKzBGTkY2N2dX?=
 =?utf-8?B?RlZmMERReElxWHdqYXU4N25Bc0dJbWUwdzhxcjlZQldzdzBVb3RnZHNUbSs5?=
 =?utf-8?B?M0ZBRkQ3MElWVGZiekVsRGJoQjdVdW5FVFZEM1JSbWdEMlNaNWJwdGE1NTFO?=
 =?utf-8?B?T3c5RnIzZnRqSXdwSm9BVnZlUlE4WklwcUdubzJWM1ZLbHpJSmt5Rm9JUUlq?=
 =?utf-8?B?ZU84YmxZcXNBeWxxck1oTGI0a290ckhxeUdqbzM0SVV3RmFPb2ZDV2dQQlhT?=
 =?utf-8?B?UU4yRjNIeVE4VmVWeVhpWkpzSnhuOEFZdmwwSXdhUzR1aVdUN2kvdTFwZ0Nr?=
 =?utf-8?B?Z1BiSUZpTWV1TE5EQklEU094QTBVQUo3LzZaSzVSdkxPZitULzhSYXcyZ0Jq?=
 =?utf-8?B?RDF1RCs5b0dtK1B6SlNUYU0zUDk2QWVySFRTNnhPSEZ0dlQySTYvcGpIMlRK?=
 =?utf-8?B?RVd0OEt2SHdIYzVzZVN2aTBXNHl1NnhGcGhYTGM1a1o4YW9tTk8rOU5RWXZp?=
 =?utf-8?B?QnRGTW01UFBldjBWWHMvdllDVDQwOEVmSjRqOUEzRkVyVG42QTMrTnhOUjZQ?=
 =?utf-8?B?UlRvYjFLVFA0ak1EWS9LZmptNUtNZmQrSkYyZExmNEdnSXUzZmt2cENESTB5?=
 =?utf-8?B?Yzc2YXRVdWp0TUY5U1hlTDFHQkh6aktZaUxrcXNzUzBGOEkwVW5iQnpxdFBy?=
 =?utf-8?B?MkZHRXg3VXdVM01pemIweklHemlDWm5UcjBpeXNaKzE1SzFPNkhDV2xPcVNY?=
 =?utf-8?B?aDhlamdGdHFrekpLRzBYYmtDcG1TeWRYVWQ2cThVMFhnV0FRM2hyVUpTeXZU?=
 =?utf-8?B?WkNscTdqcXZpaTFnUXZJUlRnNVkzbzlqMnlkbHdqOHFLSGk0U2VKaXJhck53?=
 =?utf-8?B?MTBYTTJFVFhuSEtWSWdtekh2c0I0ZndjN3RGcUdJYWN6TXFmSDhER0xod1E0?=
 =?utf-8?Q?uvm8Ib8m2YgQwq0sLj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682ef54-e62a-4af0-3ce6-08df1331ffdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:02:38.0338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9rF2dLhGGhiRe9vtsnXZwMLe5qLY0jQy3F5OYxpDLBeP7pjWdio3OQ5Ne6aVzJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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

On 9/15/26 09:19, Prike Liang wrote:
...
> @@ -132,7 +134,8 @@ struct amdgpu_userq_mgr {
>  	struct drm_file			*file;
>  	struct mutex			proc_ctx_lock;
>  	struct amdgpu_userq_obj		proc_ctx_obj;
> -
> +	/* Set when any queue owned by this process is reset guilty */
> +	bool                            guilty;
>  	bool				proc_ctx_allocated;
>  	uint32_t			proc_ctx_array_index;
>  	/**

Again, clear NAK to having a flag in the queue manager as well.

We should not track that here, especially since there is no way to reset it as far as I can see.

Regards,
Christian.
