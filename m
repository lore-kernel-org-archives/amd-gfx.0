Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821DAE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 06:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A9810E2D3;
	Thu,  2 Jan 2025 06:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vl562dXB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0263910E2D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 06:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCB7hKLqfcGekMzfl909wc/y51/853Yo9zcmOwCN8sQcAsQRPAfrg5bqW8QfyYt5u5G7NiOdmJ/hOSc+XR6JY8bF0eO+l7RgHKGTgEyNtadH4R7nszC5nuOX9ArNMwZnFMkXVIitlHahJ8gVH7g7wCk93/Tc39w7KWMjFWM+3LtTvAcjdLkEU2q1f814Jrx/i2M1mJLcsn17AHvOd5PDPs/Ozi2RYu4+/KZ94yzZEdpP+UilZb3nFea6k83fZgLgIhUht1DUU0RJHzd3EQEOcp5r1rMzGMTt4z+ex6RO3gI9+SzqrmDXoMR4kzpRPqsddmyXiSvmpJO2uHrO//HqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs8NHKnowEgWoInAwEE75nAHteLLFO3JM0wYovJHj/I=;
 b=ocJ5adkr5Qmr+gIUmRH89OmM6QXVrT+PUhPDLRahc4HHbaqRXMJ1Kws5qxdxtmY+AicRyARrXQhFFOoNYnyHG8vzEJJ0ansbOOzwpI6AzVQPTskAdQSAERnJKzpyvhs3q2TFKrwZMKKjTukFrib0eI0melRQ3rR9H4qVALx8MwjxUZSOJ4LZB1LgOnJTeqp/CguKFSfHR9A7yvPtPYt8fPTyRFAq+UhkmHbVuhSkuwWXZuA3Nq2sDl88rDjSETvKNVVsV0Ng2Qg70U7+mVv9uyqqMTLgtmwA5GLBDvu8SPSR5At1YrkbuxqCDP/CADh/6Ng/IAdJLKL6U48IxNZd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs8NHKnowEgWoInAwEE75nAHteLLFO3JM0wYovJHj/I=;
 b=vl562dXBKHfdIo4XaIAFHTJ+YW4K29aAx2kni0A8pmkFZzsqOyeMpUZr6xZlRTpFBhKlvoQD5WTCg7hNH7qldEzwqnHrFkouaRYZA39QMHkLwKfGrpXbT5GCFiBVe3mZZnYPeRd1uEETR62xf/KXKBxS+ynUiNELruAlYcFu+ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 06:01:19 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 06:01:19 +0000
Message-ID: <090c35e3-f1ec-4586-8854-a7eb2ba568ba@amd.com>
Date: Thu, 2 Jan 2025 11:31:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix error handling in
 amdgpu_ras_add_bad_pages
To: Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <yipeng.chai@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20241213121019.1385312-1-srinivasan.shanmugam@amd.com>
 <20241217093858.2867451-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241217093858.2867451-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001B4.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8cc275-f16e-46bc-1cc0-08dd2af2e08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkpXVXRqdDVDWUxKa1NFanV0Y0xQTDIxV09rMkxmaEdUZjFWc2VqdXhhcEg0?=
 =?utf-8?B?TCtrTVpxLzM4Z0JBbzA4b1JzZWIraDhHYVFDUCswK09DWVo1V0RYT2Rwamdn?=
 =?utf-8?B?TU9MTU1pRHByZUlCVjh2QUFGdm5UNDJaWlpoNFdLYWRFWFBORzVoVUhtRlZz?=
 =?utf-8?B?NEkvd3Y3S0NOYndZNU1GTzNocEtod082UlRrYm1nRTlhMndUb1NoVkJucDRW?=
 =?utf-8?B?aUpVZUJCbXZHYzdOelFubGJhbXlWTmlJRTBVMUxJZ2RXNWlXZ3ROSS9mYkV5?=
 =?utf-8?B?YnZYTUZkcU9zdDZKM1RDZXdMMGZiWkQzWDJOVTkwbjg3Ty9ZT2xnaFFBTnlw?=
 =?utf-8?B?Z2liTURxWFEvZFIwNVNjVVI3bFFtaTFOdGpRSFo4VGlLaGI2TmlCWExlbi9j?=
 =?utf-8?B?bG4xTWlOdHpLbzM2K3ZORkc4Q205aFlzbkdNSjViMGxyMitHdHpCL3lkVmFZ?=
 =?utf-8?B?TGd3bDZrSGUzcTg2eXJNNU5wVkY2Yk1HeHBKMTRDcDVzdkJVNFh1eksrK1Fv?=
 =?utf-8?B?UXplTE9zM2hOVnVOWnYwMjFaYjdFdjBvSndNUmR0dmZERUJIOWFtL24yNWRt?=
 =?utf-8?B?VXg3V09NYko2ZE5NMGowNllBdE1rNkEvWW5vRVNKTTJXdkFYQXpVWVhYTkd5?=
 =?utf-8?B?SUVhY3g2TkNIdDNDNmRwdU1RVWNhdjJwcUhYamFyUmw5UEhRRGgvZXltVUZN?=
 =?utf-8?B?NGFBQnArMnF6SmhyYzRieVhOTzdWeGkrQlhrdmpNcnFrL2pMZWQ5U2k5YmFD?=
 =?utf-8?B?bWxYOFhiL1RpMUVvZGpOYWl5Y1FKQlpPZTBjeUNGa2NsMVpLUmFiMFBZVUJX?=
 =?utf-8?B?OERHVTBhNklmbkY2Q1plNlIxVnBOVmtUM0wvUXlHamZ3MUFXTkVsTllEWnRu?=
 =?utf-8?B?UU1PRk1MVGlIdTgvQWxDMkpIQ1pya3V5YlNCbHhwRXRHQy96bjMwOGJ0bTRQ?=
 =?utf-8?B?ZXMwTnBtaktLMjI1aXRCNUxqdndaSFl2SStxYkpQNlo2RkNmdEI0UzZzMzV3?=
 =?utf-8?B?S0orTEhKNXJ5M0N1S2tXUTZDa0pTa1RYTlIzK09lUis1cmtFME5GekIweDVl?=
 =?utf-8?B?a2ZpTWp3ejNVT3JjMkpVSlNzMmtXbEREazFNaWRtdjFXbERkdi9tTjNHZkVX?=
 =?utf-8?B?anhiYnBIS3dnQ0o0SnRBRjdJNkxwTCtlQ1ovRytOYjhiM1JPdGRGeExXS2NY?=
 =?utf-8?B?azM3azU2S3JrNVQ5RkVhZFhaSkhhNzEyQ1RvM2pnV0JoK2dZRjcxaEVRRXJV?=
 =?utf-8?B?K0JWNklMcUJOZXlJWmtlVWxUQ1RXOVkzWnBzbUE2Tm5tMmViUDNmSHVLaGN6?=
 =?utf-8?B?NVF4NVdVTE5QUG1kQmNGejMyNHFuTmJSVzVFRS9pV1VSRkYwZ2p2ai84L3Z5?=
 =?utf-8?B?ajNxUE5Sc0hYNU9VQWpjVzQ2MUFvYWtOUThrNkR3dTB4NkJFYVpBZ3RFVXhY?=
 =?utf-8?B?ZytOWGZZR3pIT2dJbFVwKzRTVmlLZDVBd1pzRWlHRmdEa1lEdkQyVFFUVFYr?=
 =?utf-8?B?WkpJTzF2N2JBQ2xLakhNY2laNG1oVngrR24vR0JyditaRUtDaDV3RGkvaVpr?=
 =?utf-8?B?M0QwZC9heHJEWnM2NlR5V1RoUHpKcENVMmhoVCthMFd6YmRzWldhbzl4dnlN?=
 =?utf-8?B?SUMzQjIybDF3VmhyQmhRTFZYbEEzUUdEMGtnN05IWE8vMVcramV2MTQ0Z3M1?=
 =?utf-8?B?S0VwcGZsUnJIb0hUdmVNcEZpR3VCbHN3eFBYcjFKanUrZU02ZWFBMWp4UkFw?=
 =?utf-8?B?ZncrNEtrb3VMWkxpRUJaRE50T28zY1NGQVRyZ2NlbUd2bTRWQUR4WSthZkx3?=
 =?utf-8?B?b1dzZzFXc3hMNnhkQ2YvZkZuMi9tbkducnQwOXdsbDBtQTBUZ2Fac21mbmZN?=
 =?utf-8?Q?J83dfOHgilKiT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExaN2k0YTcyenNYbjVyZHR6eE5Cb0lSbWdzY0lHOFZvWFlDVW1mRXZLNm54?=
 =?utf-8?B?SEFjTVE3RG9Fcks4cG41UllwaEtTb0x1K3U1eHNld0NXZGJMeEd3UkxKaUJ4?=
 =?utf-8?B?ZVZLeG5FZDRrNVplNEQzKzdtaFI4UEVMeE1NQis1ZEE2N3JYS3BzZjJzT1Q2?=
 =?utf-8?B?OTJzVXhjYmFrdDBsRGdCK2VURDBJMDJTSi81SmNubi9KcjVTK1RUaXNpMENz?=
 =?utf-8?B?YzlZR3RmdUNDRHVEOVpybzYrMWZqM3NqNzE1Mk5JMjZFZ1NkWDRSaEVmZmoz?=
 =?utf-8?B?bVA0eTcrRmFqU3Q3eXVCVS8vVWtudnl3RUh3VkFzYkV4TjUvUVN2Tnk3c3Fy?=
 =?utf-8?B?TENnMkV2UUM0VjJnWVNZTzJvV3VzUGVoc2QrdUIrRXV5VFNtMEVERkxhUWE2?=
 =?utf-8?B?bGpsTDNtMHd0UW8yYS8rbStiTlE3ZjA0ZHlyVVdSS2hsSGJrZElqOUhwbVZL?=
 =?utf-8?B?clA5YlpWL24ybmtFOEJ1eVVEZFprV3JjOVFONFAxSktYZlFGK2VzZEhIcmRE?=
 =?utf-8?B?Z05kN29SUXJjN0tZZnB2Nmt1Mjk0RVMvTHd2WnVITXlXSloyUHRiQmoyY0JJ?=
 =?utf-8?B?alBubmVlSDNiMnJ3WnRJMWQrWTB1N0JINEM0dDZ3L3B5dVo3US92MGxFT2wx?=
 =?utf-8?B?L2pKeWt3ZjJrWlJXeEthR01YMGhybDJ0YmhYY1I4eUZKT2l4NmxKUFVucXoz?=
 =?utf-8?B?TlVrTjYxd29hbTZCaU9SY092a1FBdTBsTlgxNUpvaDNDQWIweWdoV09RQWFO?=
 =?utf-8?B?c1R2ZGw1Tm5nOGs4ckJHRVJ3b2pqczRMUnNQZXJJbjgwOGlrelgvb0Q1QVlK?=
 =?utf-8?B?bXVLZlo2c0NrQmQvWjNxVzRuTlBJVVcyWmxoK1RHZzdaTXhZdHNDRWU2NTRa?=
 =?utf-8?B?cEx0c1RNN0tlbHZBc1dNZk92RTQ0U0JBT21wZU1FM1RlN3I4WnlWYUdoZWRv?=
 =?utf-8?B?cVhBbHdReWNuRXFoSTY1WTlEelYzSS94azdzdy9KendpUjl4VlVQZytCRDg1?=
 =?utf-8?B?bEhhZWRLOTR2VWhMTXhlMzl4N1FtTkV0R3JzMDNjVnp0Nlh6STBCOSs3RkdP?=
 =?utf-8?B?Q3IzOGZLZ2pXQWFmL0pGR2U1bkt6a2dSVjg1UTFHNHFXRUZLWWdhMGhINC9t?=
 =?utf-8?B?TFBlWEhpQ2lVYldoZVVGNDl3SE5uSGVzSEhKZGdVU3dGSXUrS3kwc3VGaDJl?=
 =?utf-8?B?cGdSakpvd3ZCeXBWVGU2OUVDaWs0YW1jUmhMSlBLOENEUVprRFFURVA4TFJK?=
 =?utf-8?B?Uy9jS3F3Nk5VWXF0ekVOVUdNUWxtVCtOdjR5NExOS25qNVpwak53Nk9xZ2k3?=
 =?utf-8?B?R2NDRUtWL1RWMWFpVnlBR0pWOWx6TGJ1TWpPYUc0R1lPSjZSd0FTRTZwdy9C?=
 =?utf-8?B?d2lZczJrS2thdDJjdCtFS1E1SFhTUnY5YUdYK0NFME0wUlh3ZmdMcWRhWlps?=
 =?utf-8?B?dDBUb3QwTDBGODlReXR0bFdxWWoxMVY2YW41dlZDSkYyN21kVExmNEhoc3Rm?=
 =?utf-8?B?dmI4UGU2dGxhSkRXY3pJUHBXK3ovRWM3ZWdEdlNEUGdkRGovclBlVVI1SkRl?=
 =?utf-8?B?OFQ4THJEZkZSdlVJT2JRd25zdFVUUmtML2xpa1R2ektNYmI0anFTblVOanYr?=
 =?utf-8?B?Q0NYQjhudHhQcXc2OUdCY09iVmN3MlJsbWkvUWdYSFg2SzBjLzhJZFNabjZQ?=
 =?utf-8?B?c0pmQzE1eWNSWjZEbEkxNHVYSUZzK3U3ZGtWVTBYME1OTVczZnAzYjNUWWR6?=
 =?utf-8?B?V0Q5YWdsTlFzd20ydTg2Wk1ISDNrM0Q5eTBNbWl2V0liU2g5dlpCZXo3WmlP?=
 =?utf-8?B?OU1ibDlZZCtFRDh4dG94dTkvSDBKUDFBVkxFdHNlcmdxbmIrZHQ1czVnNHFR?=
 =?utf-8?B?c3BORUVpeEpPckNzMytYRndNWGVWeHArdzVOZnFOMWRuc2l2RDZCMGJ3dGZW?=
 =?utf-8?B?NmNrRmtZMkJoZGJHZDd1UVAwMDRwRllqa0RZd01ZZmpreThmeEJYQmU2SW5U?=
 =?utf-8?B?Q1VNcUpMZzh4YmhSWnlVYndYcWYzbDAvL1pYLy9SUjV1SU9ZOVFQZ2I1NEpu?=
 =?utf-8?B?Yk9ySVJhMnR1amt5dUpVYkxSNjZaRFpLaERjWnhPVWUrYkR6ZHFERmZGWWMy?=
 =?utf-8?Q?PSm4qZdNmqmhpzhv4dYciH/zZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8cc275-f16e-46bc-1cc0-08dd2af2e08c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 06:01:19.7546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/+w3pOQqZcyttcq89VjiNLEPP/SIwPVcZQrjybBdl3vA1eAw2cyUZkE6mJrb9tGqt3/EMVb8aqxyzoxuNM7bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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

Ping!?

On 12/17/2024 3:08 PM, Srinivasan Shanmugam wrote:
> It ensures that appropriate error codes are returned when an error
> condition is detected
>
> Fixes the below;
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2849 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_umc_pages_in_a_row()' failed.
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2884 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_ras_mca2pa()' failed.
>
> Fixes: 9fe61c21405a ("drm/amdgpu: parse legacy RAS bad page mixed with new data in various NPS modes")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: YiPeng Chai <yipeng.chai@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - s/-EIO/-EINVAL, retained the use of -EINVAL from
>     amdgpu_umc_pages_in_a_row & and amdgpu_ras_mca2pa_by_idx, when the
>     RAS context is not initialized or the convert_ras_err_addr function is
>     unavailable. (Thomas)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 01c947066a2e..f1371d1f8421 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2832,8 +2832,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   
>   	mutex_lock(&con->recovery_lock);
>   	data = con->eh_data;
> -	if (!data)
> +	if (!data) {
> +		ret = -EINVAL;
>   		goto free;
> +	}
>   
>   	for (i = 0; i < pages; i++) {
>   		if (from_rom &&
> @@ -2845,26 +2847,34 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   						 * one row
>   						 */
>   						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
> -								bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> +									      bps[i].retired_page <<
> +									      AMDGPU_GPU_PAGE_SHIFT)) {
> +							ret = -EINVAL;
>   							goto free;
> -						else
> +						} else {
>   							find_pages_per_pa = true;
> +						}
>   					} else {
>   						/* unsupported cases */
> +						ret = -EOPNOTSUPP;
>   						goto free;
>   					}
>   				}
>   			} else {
>   				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
> -						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> +						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
> +					ret = -EINVAL;
>   					goto free;
> +				}
>   			}
>   		} else {
>   			if (from_rom && !find_pages_per_pa) {
>   				if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
>   					/* bad page in any NPS mode in eeprom */
> -					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
> +					if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
> +						ret = -EINVAL;
>   						goto free;
> +					}
>   				} else {
>   					/* legacy bad page in eeprom, generated only in
>   					 * NPS1 mode
> @@ -2881,6 +2891,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>   							/* non-nps1 mode, old RAS TA
>   							 * can't support it
>   							 */
> +							ret = -EOPNOTSUPP;
>   							goto free;
>   						}
>   					}
