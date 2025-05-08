Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B0FC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F143510E916;
	Thu,  8 May 2025 13:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fiIS6xJq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E1710E916
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 13:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5At87mTc59/sFEzi8Ul2g06ea2k3SX58SDe77R3coiGVQ/+YPoUxZKubACtI45s/draD8g89AlxTQxpvdfh3I0mT/4XhQJhAcrGOwIkH4CSjLSFE6GpoGdLS8g/9FhNbeVZJ22Q+DRE+4AAozSBRap2FgpE4o+xgUfVal615WHXrJSlhvPjwg1KCGnWawBcWK18v6xOGB+mm6BHoM5UcfXmFheCBI6VDjVFCX9wM1zgZ4h7LBt/Q8wvXkXAGMncVOER/pFeXVLtNiIpQqAfcvDsz9nU5340BlbKMWFMXZG7N+iz0ebB8bb4Na7Sf/CQYSB9rNIg/iTOJf3RUCgEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v20iflGJCO8SKRIViJk/BwJOPhw2gOxnqIjDCP9DYeA=;
 b=j3wb2vDnZxOZy/lWS3emfka/UT7vZktVIHmviQNCj9sKMqYtla/DRfIwZP8MXsyPF66OGhoW0fY4ro93LN2+ZVURXtI0lbF9DnshgFggMUdydmeGaSfJfPWmwKUxpfgfhEUT5YoXntViRjUljuJ3TZKQD4ietG0yCmH0NiCm1QIFqg0JzMyyfbV1dhdney6nXFs+xMo00ZYQHmy54XTj3rcpBv53wyTjyC0wnvmKInxPQ333YeS1aerryX5eV3MhFhhy9Cfq8Cdw9p0VODJOOLqgX4qE5OVvcg8S4gr7C41wlRtVwFAB+wX7Od6MdjesK4jURenL7T2w7FT55Q/g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v20iflGJCO8SKRIViJk/BwJOPhw2gOxnqIjDCP9DYeA=;
 b=fiIS6xJqILVUTHIQBdYEqKNqp2hR2fsOkwEbZ3QDOXQzDHib9scoy8ZdXTu1VeszAYxAyilOFdJsWZW5VbpWjDdGMhaX+hFCwyi79+vUyVBh8jEnfFisOkm0BdgmDxQlrna1KF7p5UZ03A5RAL6/X0Ad7owGOf7Hzie6QZ2baGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 13:56:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 13:56:03 +0000
Message-ID: <d7a75e46-96ee-481b-90c3-eaa514569245@amd.com>
Date: Thu, 8 May 2025 15:56:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: lock the eviction fence before signaling it
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250508134428.383605-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250508134428.383605-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ac1450-0279-4c4a-e437-08dd8e381267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkt4a21MZ2pRVnNRZXppWnphSkNQLzM4MmZRNHo4Q1psNzhLRFZ5YVZQeGo2?=
 =?utf-8?B?UGVPTFgxYUFWMXZ1aDhBTUtHQ1dsVk5QQno3VVhiMytPZFY1dElkeEVYU2Fq?=
 =?utf-8?B?d1dsQllCZTBKWU5uYXFOZVFKeXRLQVFNU3RWQUdIeGVFS1MxQWk2V0ZxYXVY?=
 =?utf-8?B?eVlyUTM3cDRHTk5mZ0xSR01LN2c3Tzd2dkdiWTgvUUQxUFlrVENueWMvS2dy?=
 =?utf-8?B?VU5vRmlHZnJPRTdCUkNFQVNOTjlKV2toZG5pVE9peHNvcU92OU8rdnVwNjhn?=
 =?utf-8?B?VEMxSDFURGdvK2FnRzVKdEpIUEZMbS9ZQklLYklJUm52eTdOaEwvS3UwOE81?=
 =?utf-8?B?NnovL3dxSDdYVm5TSjRUY1c1Mk16WENVOStHUnNWS0JRVmVGMkN0TUdxTDYz?=
 =?utf-8?B?Y3dzRW5nZjFBOWJPcmRjTnFLblZZeFFDejhmWWRhdjRNOGYwdy8xUFZOa3JB?=
 =?utf-8?B?bmhOeno5dlJYdjV3ZzhSamplaVczL2pYNEdyL25QL0RmNWJSVUFDSXd4YVcz?=
 =?utf-8?B?QjZSOFBWNisrQ3FjNVJXQTREQTBkeE5YT3VxZHRFUzJpbmhLRlB5eUVqRmhW?=
 =?utf-8?B?NURjWTlZd1RWbE9Zd2VxOTNvdmhDZkZDSjJFR0JCbzRJZGtBUmtZOHA1bTJT?=
 =?utf-8?B?UWwvdlhSWTJlU1loZlRnMVJiaS9kUzZzSnAxVGhCQ1BDSVk2RCtRWS9CRUd1?=
 =?utf-8?B?ZW9tVkRHVHEzUFZzSjZNWWw0QSt5K3dVcGV2Q3BFTGc0Rmh6VFJHVnU5a2RQ?=
 =?utf-8?B?M1ozODRsMHBnWURtY2REK0xpV0NtVU51THJYQUpVcGVIVFBHUzF4ZVRmVE15?=
 =?utf-8?B?eGhWRkNNbWJQRHdvSUdiT2lXclZudXh5MHlndS92RnpVOXg0VnIza3dvWjlZ?=
 =?utf-8?B?OHhBQURJSWovQjVtWHBkOGs3ZVE2YVB3Q2ZJT1JrNE9IbWJIYkI0TEpOWTVS?=
 =?utf-8?B?cHNDYUxFbEJLVk9KQXNIbjUrME15RXY5enRoamdqYTRISlBFWE1maWl3M2dB?=
 =?utf-8?B?djNyZlgrMXQwakVlMUk5YkdxV2RnQ3NHeXNWcjRpd1cyTElCQVdORGxQNGlX?=
 =?utf-8?B?N05ITGVCLzJoMGg2dmJvcUFMUmJYVjE3TmtkV1VzNEtFNDlBbTNDVjRaWklF?=
 =?utf-8?B?YURQTmpwdGVyUEZhVlFUUlhMNzhwUnRpS0dBdnBiczNyMG9SUlJwY1NYcFln?=
 =?utf-8?B?c0tEMnd3UVdmUDEzdUZVQ0tvekVvK1pSSTg5UU1ab1owNHZaUHVJOUFwZDcy?=
 =?utf-8?B?YUVZbGVGQVFBMmgvUklJb3gxNGNCUmY2ckMyaHVKTm1EOUYxa3hzQVhmVXEy?=
 =?utf-8?B?TFVoQlpaWkkvWkVOdWpmS2N1ajB5VXNwRlozZnhxZlA5L09EQUhYRWJHVi9U?=
 =?utf-8?B?WFlUQitPaVVTSklZM0pLZEVHdlFFYWp2N3VvaktHSlhqbytJT2FaeTBDSzJS?=
 =?utf-8?B?S2tjNkNqUVpzWlFhTmhnSTY4RFF6SE04ZjIxOW9VVDZ2dXIxMktEdlg2RTVX?=
 =?utf-8?B?bnpDdlJXbEM1NHM2ZmZxSlBjV0xuNGozYk9sVDRMVEY0L0VReGYyMEZNbW5Z?=
 =?utf-8?B?WW1hTnNReW5sYlYzZnlFb2dVTGlvalc4REpidVZEakpIWkZKeGFrcEwvV0tk?=
 =?utf-8?B?NTZ6NldJb2VKTENyNEtqamNNY1FjbitDZjFWc3d6VmcwSzZKeGVTSmsrU3Vy?=
 =?utf-8?B?U2NyTmlGUmZOeFphU0J0V2VvVFB4NHcrS0pYZDg2QmwrSWNmeWRobzUwendy?=
 =?utf-8?B?WUJScEhnZ1BFY242endIOHJLUVQ3R0hOeU9jQVM1RG0vTU54cUtQbkxCWkht?=
 =?utf-8?B?Z2tGR0tGbktvdDdYZTFaa3JvWkpGdzFMOVZoTUQzVmt5V0VDOThmYXJGWDE5?=
 =?utf-8?B?Zy8yMHN6OUhMdFVhZHlyNWRPVGFyZ3BOamVSU0tJWU9UNjh2eGpzMXYrSmNk?=
 =?utf-8?Q?UZ4BdPjZVeM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZ3UndIWjZqcVJoeUg3ZzlYWG8vSHR4eGgyU2M5OW0xekJXUVNPNGFiN0p1?=
 =?utf-8?B?bjhQU1RrL21XdHZiODFhNVp2SDZwcGpNK2wvTzZFQ0FqR3ZnT0lxRllTL29s?=
 =?utf-8?B?em1BTjV6MTZmbEQwVTYzZ0hXZ3kzbjNzTHlzK3dHbU9Vc1l3ZkVHeGZYNkFT?=
 =?utf-8?B?cGxqaVRxRldic3VUcXpzbEhKUldHbGpqbVVYdFh3NmFNT3d5U1h6WittWWlJ?=
 =?utf-8?B?WkxKaEVQRTNZS0pRQWRmRUVwc2FVKzFCVzZLUUtKUlhiMXpoeHFpQnJkckVH?=
 =?utf-8?B?Y3d1SFk0c0JpU3NEN1l6bGg1QTUycFRBZWxYTlNTbmkwcytjTlkwNzlOVUFj?=
 =?utf-8?B?MVZSZnJlaXNYakFyZCtrdjZXTW1nNG85Vi85WWpCZnpmZWg5TFJtNnVITWZj?=
 =?utf-8?B?L0RZQ1NVY0l4WkRpQ0crZWZDcXBjdEZsZFUwbGJxTy9Wei9jcVhINml4R0xH?=
 =?utf-8?B?OVVKaHBDWlZtR3c5dlB6Q09tQWxiT1ZoWmJlUUc2TVF2L3BBVCs0WmFXcWs2?=
 =?utf-8?B?a3ZWUWgwM012YnBIZmRuS2QwdFBVVVhlWjA2VjI5VHNDZDNkajlRNkxEd0FJ?=
 =?utf-8?B?RHgwdCszU2tmU3FRRUphcjlHQldQcFhLOWl4dGJGRUtZekFoT2hFa1ozc24y?=
 =?utf-8?B?MFJxSEdJRUljbHZmVGM5cFJaaEFuM0s3UExlMEJyY2M3eHY5ZlJUMXdBY1c4?=
 =?utf-8?B?aEU0c0ZnL3BublA4RDhsRUx5NHZMdVdjNm1CTHlpVWV3MHNFSWxuZ1puZVli?=
 =?utf-8?B?UG15WmhRR1ltbkhvSGxqc2NDNDlpTDNjMytwa1ZLd3cvYkVJNUlvMHVyYlVP?=
 =?utf-8?B?VnFlaXFVWC9hZ1o4MXdldlVWS0tqMWMrSVNBdFFVdXBoUnU5RXBIeGNzb09P?=
 =?utf-8?B?VWpNUWhGeVFyT0VOZ3NxclhqR0F6QlkzVkNRQ1RJd3JXVWh5TzNucXdLQkE1?=
 =?utf-8?B?amhVNEtONlZiekRZckdDbmNCSlljMk1NMzVjVllnRlRwNzh4SHpjUGZuVkk1?=
 =?utf-8?B?V21UQUhTZENuQ2FLajYrbmdnSmZ6WEU2dUZCNVFkRlEyU3NYYzJCT0lXWkgz?=
 =?utf-8?B?Z2pYUGtqMUlUSFA4aWtQbWRSK3VoYjFwWkhBWkg0eVZObDZWeFV3WHNKV1d4?=
 =?utf-8?B?TzdrTEE2bUpyQXdON2RjOXJjMXkvRHpROU9QMm93bTdSTlYvbHoreW9KWGIw?=
 =?utf-8?B?VTJ1U2dzTnozS292K05LdE45UWptcXoyWERSeVBkNjk4U3NhSjhaKzNya3Fp?=
 =?utf-8?B?bDBkWm1QQWJPV295dEpZMmZDM3FMd0F2QUdtZThFTnl2VGRNNGJ1bHlUb2tJ?=
 =?utf-8?B?U00xT2hIQjVzZmJrNmw5eDRlaklkRFg0RHdGMnYxb2ROcVByeU9QMzBObUZx?=
 =?utf-8?B?VEZvNTMvODhuWHFEZmVUcXlHd1A2aFp4YUwzVUlqZ0UrTG83aGlpcit6c2Z3?=
 =?utf-8?B?SlNpZU8xYThLODdXcnZ4d21ndElyM3hvcU1ZM21NZW1uTEhBSnU2NjJyU2xw?=
 =?utf-8?B?Q04xQmI2NTFoc1NsQzNTVUhTbWE1V0F2YUQ5ZWpGOXR5TE8yWXE1ZUxkM2Zw?=
 =?utf-8?B?bnY1OXZPWkZyZWkvNEc1a1JxYjhuZTF1V0tiTUZjVGdaMis3bDN2YkpnMExm?=
 =?utf-8?B?NVY4Q0FyYWNRQ0FVMHR5d3FNVWZ6VGoxRXk3NHBjVGVuTGlveEtCM0J5R3cx?=
 =?utf-8?B?SXMvUVh4Y0dCc3g4cVhsL1RHME1wdHJiUW8xTUtkQzR3b0pTNERDNkFIUUpY?=
 =?utf-8?B?Zzh1dm0yLzlhMmx5WUNrT0NQbzhlS1dXcXQzQ0JhQWYwK1poRSs3V0k3SkJk?=
 =?utf-8?B?c0xwb1hDajFxakI5T3BzQWZrYmxwdnMwYVphbzRJdEF6UUFSRG1NSTlXRDJS?=
 =?utf-8?B?VUhBR29nTzFwTTQvRkxFR2Y5UVp3dGJTZjRwcUcxbS9Sc1dtZDE4cXZCM0sr?=
 =?utf-8?B?bFRsTHFUZEV2UnA0ZTV4eXNKU3Nzblh3dy9mZDdIQnRiVDk2ZU9VeWdUcTJh?=
 =?utf-8?B?REVPQ0UwSXorWEEwZkg5MTFXTmcrdGJhUUx4dktrNHRGMHRHV2FoY0lnejBv?=
 =?utf-8?B?U0FiMHRVcXlzYzBtTERLMThJUGxLb2NVQm0ydTVxYUVsR0Z3ZitHVys4dyt1?=
 =?utf-8?Q?aHbczZzXWL1Xn79kxi4aQmkVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ac1450-0279-4c4a-e437-08dd8e381267
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:56:03.8050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEYipq0jlV9vVeT/SnAtjlcmai6Kxn56u8WpSxK6CWDhzY1lmU8lM6gjv2ymU2Ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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



On 5/8/25 15:44, Prike Liang wrote:
> Lock and refer to the eviction fence before trying to signal it.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 1a7469543db5..dd272c1fcbb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,13 +108,16 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_eviction_fence *ev_fence;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
> -	ev_fence = evf_mgr->ev_fence;
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	ev_fence = (struct amdgpu_eviction_fence *)dma_fence_get(&evf_mgr->ev_fence->base);

That case is not a good approach, instead put the dma_fence_get on a separate line.

Apart from that it looks good to me.

Christian.

> +	spin_unlock(&evf_mgr->ev_fence_lock);
>  	if (!ev_fence)
>  		goto unlock;
>  
>  	amdgpu_userq_evict(uq_mgr, ev_fence);
>  
>  unlock:
> +	dma_fence_put(&evf_mgr->ev_fence->base);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  }
>  

