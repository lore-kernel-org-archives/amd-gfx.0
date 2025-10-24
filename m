Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AFDCCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 11:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C4110EA3D;
	Fri, 24 Oct 2025 11:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFqJPnLo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BD610EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 11:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcxU4UWLA0zqRVS2tgeJuwavAkiXvSmHp2fMP1E5p+y7exvDotybpoUV16Oo9lIhA+gQOsH/Jk3+Mkjq/zm6sgxKvmWvQP+YRtjdOGCqG3V9zMdEgQ2bqs31yEjr53/4fSjx2VOljzp76cP5LopTSwtAKe7vBlxYpirwFslna3CMXrUnSnFP6B8c/OT3o02s5SjX+GcfCKjIHWCEun8xjlC8vycNYSAqY4a3RCGxcph+cg0WfHhvcxxocMUzUh6TdYuDAU/oJzrAs6H8OccVEkySAQ0fyopqKbv9w7d5nzkfCq9y4Fc+zD6dk769I0EIOuDQwMMYfJlmhDVKXjQyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76a2murj6pqdax1YxI8aK4THUbXZvQRGzX6AuDHn5y8=;
 b=McvzWvsYCd8c8EQ49NVhbCgiS9Izjn6XMG2HpWDWJQTNBkoaz5B15je1FhziqGuomskUUw1POWgEmzm5nd13zeKf/tBEIKkum19J9srPpg5X5jPVevpXyPKvh7lsjK/Xh4l37aVFP//6rWuP7Wgednaxwxyl2sLjULYpXjv+u0x7QmG3tq1xtI717/wl57bxq7yVZyDcVyA9jUnji6kRlv+ck0bL9MPrUYIRMM9N4Mj6RShYsS81mR+u2HeFWLkMS5bLq4FgYklQSgdfkloGzfhjotv1/7mmBwiZw5vpOm7kKwExUDCfEHsKMmMGrm7qu/xrTWUHZVqZs2bhGv6e/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76a2murj6pqdax1YxI8aK4THUbXZvQRGzX6AuDHn5y8=;
 b=tFqJPnLoNsC12JA3ifP8dgFdT9t3nm5qouhb3y26jVAB9VVscEvscYiOFQKIYUAS14h2m3GctoAyAdZZlMi+ZA+0p7qyihUr5W3P6qpI5/JwYrE2SmZikWV56+Rezh63RsAD884odeiEsbGTZ4WbDrlNUhd+I1kAAyjBGZonbwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:09:43 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:09:43 +0000
Message-ID: <f8b2a650-ab29-40f3-9e12-2fdbdb287fae@amd.com>
Date: Fri, 24 Oct 2025 16:39:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdkfd: add missing return value check for range
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251024044720.1971409-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251024044720.1971409-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: cd219cdb-5ad0-491c-8340-08de12edd540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akNFV1NXUFFzQ3QvUURYNjE4blBaMW5oU3BGejYvVEpkYVptS2E1aTNUVWwy?=
 =?utf-8?B?WW5LQ3BNS1pmL0dEY2hLN0NrbjAwVlFVY3o5UEg3V1BDd0NsQU51UjV0TVdU?=
 =?utf-8?B?dWViNXl2M29oOGhpMnB2d0RQK3ZtUndlbm9ESlNlN0dZbFRtMnpQaTBMWVFQ?=
 =?utf-8?B?eGVYOS80aG1xM0tBMXdvVEQ5S2NNNFdhM1I4V2VRKzk2YVRMTGNRSlFEMUZE?=
 =?utf-8?B?ZXphQ1ozRlFHcDM1NFJUYXhTckVycnIwMWdaMDkzYndwaHBjVW90UHN0YTBW?=
 =?utf-8?B?eVVKbUpNU0FJc0gyM0ZkSEc4aWNLKzhEM2hMck5DdXRBbUVVcUtSUmR1NHBO?=
 =?utf-8?B?KzkrdmgvUWUzQ2hza3h0Ti9PcDgvK0VTWTg4VngveHFybFEvejd5RU9GUEpx?=
 =?utf-8?B?OXhrY1F1bTdNZ2pTenRacDBXUU1mWGtEcmJzZkltUnJKcCs3MlBibGxUVERQ?=
 =?utf-8?B?andHTEdtZW9yRTFkV1hwWWs5cUREc0ZFZC9sVHM4SzM3dTZwY2NGOEJseWIv?=
 =?utf-8?B?NmFJSEhXNGtFZ1NlTzRCWDdobFdGT2UxTmZqVEtPV2gvN2lhRWkxb1hHRHAx?=
 =?utf-8?B?SmJUSSs4UGU1SE9nUE9YVDJoelV6UlBucGVCZ0M4Ykg3d1p2eWFDQkJkREpz?=
 =?utf-8?B?dnZIV2xzbVFzMlZmSFFHaStHQVZrVWtxNTlrbjlLSVBOcFcwMGhCUmR4L3d3?=
 =?utf-8?B?WVpyeC9IZFZlemJ4TXVFdW96Uzc2ak1QZGtad3V3azl5Um5ySFFGNFl3Q1Y2?=
 =?utf-8?B?SVk5Z3IxSkRvWmh3V1VyRTlad3hmblk1ZUpNdDU0aUlXazUxdjdFMEVNK201?=
 =?utf-8?B?YmtMS2U4ZTFmYWxKcS9NSEhvOUlwNlh0SlZyWFRwcTBKcVIzN1Z0ek5yR3Zs?=
 =?utf-8?B?R0l4eWZmYXRDL3pyYWYydURIbGdmZ0pkU01pNjI0VlVsdTMrSUYvQndxdmto?=
 =?utf-8?B?cDEzR2pSWHMxRTJ4bWJoVk91SFdGT3VHTmh4QWpOYmJKZSswVndDWjUzbExh?=
 =?utf-8?B?RHZiN2N0ZWk1QnE5K3J2eXpVUjZ4SUJFTFM0QW91RisvUktSd1gwVlVrcmpJ?=
 =?utf-8?B?RXhKY3BEZGV2b0FRSkQ5Z2lCTVJsSGE4dmljcVdvSlZ1UVVNRlM0YzczQmZO?=
 =?utf-8?B?UTJqcmxlZlRTeU1KTGhMOEJBNVBGYlUzeFJBbUY5a2pBT0RleUVyekVoaVhQ?=
 =?utf-8?B?QkpjQTlCWEkreU5ZL0wxNWx6YllyN3VPNmFabGd5ZHB6cTNVTksrM1Q3bVpB?=
 =?utf-8?B?RXhHUlhxNExsemtqWGxHNG1aeFJ0TnVDaVYzdEU4U3Z2YjJnSWRoQUh2dFRR?=
 =?utf-8?B?aTJKZHA5MUJRazRCUEJZM253U3B3a2J6YWtkNGRZR2NSeUtMck4xbER5bjZH?=
 =?utf-8?B?S3Z1SnVhbHhDVU5JZG8rRCs1QURDa2VRTWhOODR1REYxMFZYUC9MdDhlTjN1?=
 =?utf-8?B?R0RGL0dRL0Juc1BIOEdZWVNaZWNlY0k2SGZmZklNYmhxMW9pZHpRcFFoN0Jo?=
 =?utf-8?B?aG5BdHJ6bXU3OEtCNWcvbCtWbEtJTDhKVHV3dzlmb0IzNXdjNEdQcGJoVDZO?=
 =?utf-8?B?WGIxUm55U01MemZLWEphTDIzcFhNNE44VzZENnJxdWJVZGE3OHRIVk1sYkZF?=
 =?utf-8?B?QlNyN3VDYW8wa1c2MEJZck9DTFFDeERCQ1FpWVFSQlFBdGticTNZNWM3amY4?=
 =?utf-8?B?Ung3RjcvR3RCaTBYczN3WFZZZ1ZrWmRJY2U0MlJqSXVET2dlN3NXYXdrcWw1?=
 =?utf-8?B?Y1FtZjI3MERaaFUxZzd5eDdwSmw3Q0ZKbko3M3NXVjQ0eFN6Wms3TmdhYjBF?=
 =?utf-8?B?UGR5VHQ3ZloyUm9aRXlhcStSNkNZSm5HQ05JbmVaYkZtZUZ2c2c0bjAvUUI1?=
 =?utf-8?B?KzZ1OS8veWtSMVAvTWx4eTcwdk85TE10dVJkODdlRlh2ckF3cGVZdGprbHYv?=
 =?utf-8?Q?OA3EAzSwNc1HL6gSP2tj1370kUN6zPW0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czV1ZndsQSs5UEdGZzhOUnlXRkorUlBmMXVrZVdRcUtzU0ViTUFlSzlYR2tC?=
 =?utf-8?B?TUY5QmRqNzBoVDVFVDRORHRWU20zRlp1UWY5cXUwRWV5Q2dNc2ZwSC9yMWJ0?=
 =?utf-8?B?QjFzQVhQR0pURGViVWw3dTFTSE5pTVVVdGxpeTNlNHhFODFwYzZCbDA0MjdQ?=
 =?utf-8?B?T3E4THhkMHAyWEVlbnIvNnZHa0VYQ1p2dHN6ZVZhVG5RUHE1L0FldE1Tb3VN?=
 =?utf-8?B?Nm1hUU5VQkJEZHkxUFl5U0R1MzB4c3YyNnFLem42R2JlQndqcklGS3ZyR1Ny?=
 =?utf-8?B?VVdwcnpVd1JRVFUvRDBhSThpYnk4YkhWZ0cxSXRJUTE2SSs3cGE4ODRKYkVt?=
 =?utf-8?B?ZHZlZzdTYmFOalhOdnVlZnRQR0x6ZVNWeVpqOVFJR2dPcEhSaW9iRUNIdk15?=
 =?utf-8?B?clk1eE9HdjlQVlgycm9IRVJuZUVsR056RkFSU2p4aDRMd0Q2MzBVdEwyRUF3?=
 =?utf-8?B?Tk1FUjBPMWtsL0RWaTVWbjdhMmNKWjJ6SWw1Mi9zQ2s0eDZqTUxneVV0NnRU?=
 =?utf-8?B?NzR3UzRWQWFsT1docXlMOERHaTRhME8vbGNDdXhaUWZidThKQ0hFdGIwNktq?=
 =?utf-8?B?L1pBRGR0aW9sZFdLVjUvZzZjUWhWZ05yQkI2THBHUEEzTHYzNUVNZzRNQmxE?=
 =?utf-8?B?WnpuZmNCTXpGUnFQR0NpQzNuZ1ZnODRTNWdIeFdUb1g2cGQ5UHgwd3kwL1BN?=
 =?utf-8?B?Tnl2aXo1cDFZb2FTR01tZ2x5YUFJZFI4SjNBZVNKamgxMDNRb2NISVhuUXBJ?=
 =?utf-8?B?TjduZkNkaGhSU0tnelJ2Y2xzSmRlRTFqU2RHSUVQejA0bWNtNUlHWThXQzBU?=
 =?utf-8?B?UXBza05ML28zZjNHaFg5c2tmNHhVOURHY2h1YmFwNnZRQzRKODBpYXRqam9F?=
 =?utf-8?B?MUtqRU9PaVVuaEJNdEU5L3UzMEJCSmZiYTcrZThvSFNKblcxbm9HUk5VQWlE?=
 =?utf-8?B?L25GdXRyTlBVb2pYY1RKYTFnVTBJbFVCL0E0TGN6SWZvWWdiN0s3T05la2dj?=
 =?utf-8?B?WkVBeHdoY085L2VGK0FMSUp2cFlSVHdldW1STmJsdHBCeEY3M0p4b3FvaUNO?=
 =?utf-8?B?WkVObWNUemdkQWRHQ3IwcHZXaTlSd2JxTHJuc3VRc1RHa1BUVUhKWGhJMExh?=
 =?utf-8?B?YWNPeC95MktNTTNaR1Z6MWRsUVZqYkJPOFdlSVhHWjkwWi9rYXZTdis5c1lC?=
 =?utf-8?B?RGJjM053NnA2Y1RjS2ljQzJiM3NTTTFQeXZEWVRtSUYxV2JXUjJ6Y1gvalhp?=
 =?utf-8?B?eUJDNmp1S2FUVEk3MmhjTnpRRExSTWYwMjhWdXhWRmh5U1EyRmtOSVJEQVR2?=
 =?utf-8?B?Zm1DSWNFYml0N2EzSHYrT3BFSHMrT0ROV3lVcGQ2Q3dnUVNWb0FCaFB3NFR3?=
 =?utf-8?B?cWc0aGNrUC9WM2pSUmRCMHV4N0xWc0VNS3Q5Z29EYUVKTFVXeVhTK0FrM1VY?=
 =?utf-8?B?VWJ4TEFUc1pDVzRFOUd1ZVhVbkpCK2xWK3ozdDFvTmFUVlhla3VXLzlsV1Zh?=
 =?utf-8?B?NWg4SEZ1ZFd3akF6aHhDbVZ0Y3JJb05Wc0lDa0RYcXZDQURSNi81NmFZV1J2?=
 =?utf-8?B?Y0NMVWZ6cWlRV2krdkQ3anZkcjVjUU5LRXhGMm9pUHhVUHBRRlFXZUJnTXRP?=
 =?utf-8?B?cXJpL2JJOW12WE1sSW1XaituVnZ5TnFEWmZMME1Kb1I5bUkrbGJwODBoUldx?=
 =?utf-8?B?NDhnWHNVcTFZOHd0T0xUdVdJNWlHY0RxUzlZQ2h5OUdJSUZlbjV2SlU5dUVk?=
 =?utf-8?B?UWtaMkppMEhuWDQrRS9YMkM1TFloNmd4REtETWNFZExNUWRPNlZhbHBSaHNo?=
 =?utf-8?B?WkJyU2hKK081NVFROUZWUGcwb3FMdkorL2EySlFQZUJ6VUdSM3p2cktEd2Qr?=
 =?utf-8?B?bUEvL09PNWxrVlYrVzVyTTJFMlg4aEJPaDMxajhlTHVSZVcxZjNVQUZ1ZFBQ?=
 =?utf-8?B?aUFiRFgxdTM2VnlWNWZBRTExZGRIbVVaOUdOYnpmU3lSU2xUeWFROW9GVWFk?=
 =?utf-8?B?RjBlaDRGZExzYlI2RDlGemR6ZUhTKzZwdkoweWFqVEVlQkNuNnF2VWVqWXVu?=
 =?utf-8?B?ZHBUSDNGNVZ6a2pZZU5Oa0VoVkpXb3lWdSt2U2Y0VWU5K3pPMjR1ZWVFbGtN?=
 =?utf-8?Q?Xh2KItJSNIBHZE6HXuF97D4kX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd219cdb-5ad0-491c-8340-08de12edd540
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:09:43.1311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlsEzdB5HNTwtVySCrexa8P4zD7i6Te1lk7zUA6s16eHVICPy/CcS6YyEATIQEkKyh4BYSakA1Pz3jdIyCrPtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
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

+philip

On 24-10-2025 10:17 am, Sunil Khatri wrote:
> amdgpu_hmm_range_alloc could fails in case of low
> memory condition and hence we should have a check
> for the return value.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f041643308ca..bc07aa3af2ab 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1738,6 +1738,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			range = amdgpu_hmm_range_alloc(NULL);
> +			if (unlikely(!range))
> +				return -ENOMEM;
> +
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner,
>   						       range);
