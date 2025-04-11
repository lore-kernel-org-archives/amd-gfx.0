Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116C6C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44F410EC3C;
	Fri, 11 Apr 2025 17:13:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DV4eyk6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEBF10EC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zT/EFL2iPs8iJpzPPnq+CDZ6qLuYzrlTCvkq/+p1vxIQ0CyiUtFMUYgd53Aphst2FsMirF4Afy6NcaksghJw365v4ATHwUV7cRPAQSwGcOfpYomI+r5HtamT1iUug9bmZHtQMTB1QhmPiGbmaFzxEqA8nVgILs2QDHKsNaFaEyR95pbAmqCeIVqaYfuFcKaMIlku2QjyzM7LwV+mDGZbv9utUCu7MUNeC4ETQX7v7KdzZh+26LJHfXqZio+Nx+TxwWyvtgNLItx0k6n+aX/IrrB3X1aXIYLWpQ9ic9TmWQ+Gkx8kKZJdFhBRs7whcAh44+zCYBAs22W2oN8QdRe4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAWstVkY66ZgjMtxbX9Ib6UhpF1EiPiQGyIGMJ8OPfQ=;
 b=zLah38hZc51bXDCWJHCO/gxOsGDzoTJivtUsRNzYmzIeFWEsPtzZaQrUTdwTRVB1B3ylfZHDlYFSd1fMZF7xJLc5MRpK7W4OAZ0n7cZX+djMDfS3ajniuEwmqQtVQeIHIcZkNsQiS3FxmBNCioEAG8xFGisFmRbCGVGDrUvrJ21qTvxNwCwNcoCKDRY0iibZBXaFug08NIovBCoieUi7EM2U8hXpKdhrlh4Kca65QZYi+D+aVJTWIouxFo8Oh5c//9B+CxpjvWAk2LEcuq5KoiW93PWb4O/Rx68LeaDyl5LMbPvbTTJpgGr/m8DCeQu6DoC1kl7em04MRcu6K0UWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAWstVkY66ZgjMtxbX9Ib6UhpF1EiPiQGyIGMJ8OPfQ=;
 b=1DV4eyk6Z/ojMYy69+Pk3eyjpH9eK/5TISFufkYdx5CLiAewz3bSvjjmt85SwgY6ulIojiPMt7/XxgvqaPCG1KYWauWNWuuqknkZIbzl7OzuuI5ZXZV6xQ3fnGdQKXcvi9yAAtwlQSQWWELVPtOq/80/tAOzCGburnN6BWiJTZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:13:49 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:13:48 +0000
Message-ID: <37157578-c733-45d3-a5de-006b61ce2856@amd.com>
Date: Fri, 11 Apr 2025 22:43:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] drm/amdgpu: add tmz queue parameter to mqd props
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f14cb5-29c7-4553-2eb3-08dd791c3959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTRGeFR0VkwrZEZjWngvcHY4ZWY3bUNieWp5L3J6TGQ0b2R4djZxTEo0VW9Z?=
 =?utf-8?B?TFJPR05yaXJtclJXK0N0YTRiZ0pOOUZKbEw2aWRWQzN2c2Q1RGlZL3FTMzds?=
 =?utf-8?B?UGJnU3NCemlSWE1UZmFyY3p3dWFNeStNVWMvUHNmdEVvbFNiaHpqRjZxa2RV?=
 =?utf-8?B?dk9WWkdkd25FTjZxVWk2UnNCakJ2MUV3VWo0MkFNMjB1ZE1lejgvWDJLejVD?=
 =?utf-8?B?a0xlVnkzQUtMS2lDZ2hhelIwZW4vbllpdlBTQjUwQm12ZjN0TW9HSitNWHRS?=
 =?utf-8?B?YW9IZzF3MUpWSFNuSEtIS2dBSDFEbnBuckZTZHdQWlFlTy9HZjJnMmFqTnh0?=
 =?utf-8?B?aW1MWkZIZHl0WUpZUzFtRnpidUNPMzFPeTlETkpwb09wWVZtT1dVL2pDcERm?=
 =?utf-8?B?T3ZaZ1gvNVoxSlFXNWpCOUVWM05LcElYMzdrNXZzQ0h2RGs5YXZIVGRFT0tY?=
 =?utf-8?B?RlZPZFZyZkp6c3VveUZ3V3BrZDJZQVoycmcxeHh0WjNKTTd5R2lmM3ZUdlBD?=
 =?utf-8?B?MXBESXV5TjdWQk5mcmt0VGdJc3dRNXdnY3ZQN1dFcUVWbGdGTWVEV0Z5QlUv?=
 =?utf-8?B?MkI2MXNZMDNYam1DSFVzQUN2KzUyZFNkQnFLemEvRFRwcW1ZTld6QW5vU3Yv?=
 =?utf-8?B?UkYzcEoxTmdGOHBaanBKeEJNdTNUTWk4QWRGejZFUENHNlByZG5CM0o5ZHgy?=
 =?utf-8?B?RERuVXovRnZPRjhQeTlUZ2pGUXlFK0hCeDQxd0tuK1I5RFJGdkliMlgyMmFt?=
 =?utf-8?B?QVZ0bGhzM29nc2pQTkJUNE9hd2paUlg3cVNZdlMwR3B5WWIreGZDcjlJZmpS?=
 =?utf-8?B?a1NQTFhGYTNicjZWZ3hEajJva3ZrZlpJY1N2bGVsem5xTFBDZXFZWUZIQ2hm?=
 =?utf-8?B?TUNHR0t0dnZQakhoeWloQ0ZvdlpYZFU4MkZEcFlzOXB2VDZsQ1d4WXRiR2Fk?=
 =?utf-8?B?TU1WVTZFTnRwYlQ1cXk3MFkrYjU1YWxUV3d1b1Y4WWNiMHdsc1BaajR5bHF4?=
 =?utf-8?B?Zlg5bURjNUIwYTVkRjJhRUFKUVdweXpYVkd5N1liSU9EM3c1ckZvTmlrMDRB?=
 =?utf-8?B?ZjE2eXdaMTBFV1RHWEl5YXJ0Z2pZeTJnTlEwTit1V1NicWpXeXNPV2NTd0M4?=
 =?utf-8?B?bVlvc3ZvUkN3Vk9CMlFkMGxUb084bEJlSkZyTmxncXphTFJDdXZyN3lWWjQw?=
 =?utf-8?B?QzRhYlpVcXpsK0ZWcU5TS2hsU2JxUytYYU9GV29VTUVRUE8zR3l3MEphQ2k1?=
 =?utf-8?B?Vmw4RXdmVGxsNGpBUHZEMFRZNHVuYjZaNWVhb1pQckkvT1VMejBnOE1ka2Iy?=
 =?utf-8?B?M0dUK01nQWJIcHJvL0x3N0orMUx1S2NJVkprUkVkR2ZxZDdPd2lnbUVaSEkv?=
 =?utf-8?B?Y1VjSklOaHI0eGJOL3lSNFR2V283L01ydWtpQmdOVFc4MDR4ajVwVHFFSVhr?=
 =?utf-8?B?blBEbWFsdkVVUXBYSzEyWFFQVzJhNmlZa2JQbzg2YlFsVmx2bkRCdWRHYmlo?=
 =?utf-8?B?dFZtaGZib3RCVWoxcFI0ZmFQejJNbm1Ja0ExcjRFc3piU1FDQ0hlRXNRbFBX?=
 =?utf-8?B?VDBpUFR0WFhqMDgva1kyWEp6djZpMTFDd0FBZXpDSVVpcjNZRFJ2cWRuSy9V?=
 =?utf-8?B?c2JVdkh1aGdWZUFzd0RrMDJEVmJVZEZwSG9IQXQvaFh5RDBjam1aMkZuc2ps?=
 =?utf-8?B?R3BpaHhtTW9jK0FFUDFrQjhuU2hSVi9Kc2REWkozVUhIRkwvUGp6a3h0WWU4?=
 =?utf-8?B?UlJVVmtOQTFneTRmQWRMNEROdEh4R1VPWE5kanRhRmdGWDRhanRHN2w3S0dO?=
 =?utf-8?B?cWdJTGNGNUtocXB4V3lxU1JtdWdGMVE2UGlXMDZFL2hwbHRxUDBDbElNd2Zi?=
 =?utf-8?B?aDg1d1BXM0poaS9GTXZYeEZMNnFKazVBdzdwNENvWHV1ZUgrc1NBN1dKSXdI?=
 =?utf-8?Q?NiNV0o7Vc2I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhGb0JUemduckI3NkdZRk5QQTlVNktzQ1ZXRGVGbHVJVHZra2t0VndHSGhN?=
 =?utf-8?B?ZSt1bUYraWxVZVNMK2g4dS9kNlJoY2FPcjBzdlFGZ0RsUVI5cU9YRjV0a0J2?=
 =?utf-8?B?UGdNZjBEbGVQc1c3YmltTUFKUTIzZVlSWnBhbThEUHRBSW1pTllOK1RtelI2?=
 =?utf-8?B?VldNQ1NpSXFaUVF0NHdyQkxYaVBJU1dQcis5UVpHSis5TzhsbDlnR0haL0tV?=
 =?utf-8?B?Q2s4QzM4RFJzdjExU2NxbkV3L09UTDlMZGoxczk4WkxCZzJjMFowKzNBTk55?=
 =?utf-8?B?dHd4QXpFODdRMDRtVHllSFpiTG9KOE5zQ0F5MkxTVFVCMHVMZkNpQjk3SW45?=
 =?utf-8?B?Yk9hUmtZc29QZTdIckNubVBNYzBubTFMWDlzZzlqcGtFMUxEMnRpclUxN0R1?=
 =?utf-8?B?NmtvNkc1VjRHeDdJR1N3YyswZTc5M3I5d2JDYXJNbmtZR0tWcVNxQ3FMREty?=
 =?utf-8?B?bmFGd2pxK3gxWEZqWklnSFhYNE5GR0wzS1JJUWJ6TStHRUdqZVU3dWhCL3Rn?=
 =?utf-8?B?VEVuNzZZRzUycnpQcnNpb3pRNzFzZlc5cDJucE5BZ1NPZFV2eks1alo3OGwy?=
 =?utf-8?B?YzJmZ0p6Y29JMTFVdE1RcFFwU1ZaYU9xL3JubEdVMnlXVkdmbk9BdGdURkNB?=
 =?utf-8?B?MHdqSC93RVJIUjh2WEdyTlAwOWpyTUVLcWZXd0MwTE5ldkpNdmlad0dCYVR4?=
 =?utf-8?B?bXhCd3g1bk4xYlVhdUVBZkRtUXR4MXNWWExDM2M1YU9jalhSekFNNUh1ZzRi?=
 =?utf-8?B?UWFSZHhDV0U5QWtSaGx5TUNZOTNOZUNrNjQ5RHZMOHphVVBYempZbzZSbXZ4?=
 =?utf-8?B?cnVoUHZvdG5aaGdOYTBTdVBpN3gzcVJUZ29HZzhqZ3BUK1RmcUNXRkF5TXgv?=
 =?utf-8?B?V0ZWZDZvTVRIM0xxaGtPWUpKZWZobzJvOEtnV0ZqU2s0ZkIvS3dxQjNmeTlI?=
 =?utf-8?B?azR6a3V5eUE0V1FGa0M2SGdCSlhuNmlDMnJXSWMxQWF5TzVYemFpRGR4SFBU?=
 =?utf-8?B?bHBLQmt1ZEl3Q29YeGk3cDU1UWVWTXVJV1paODVsWjNnY0J4bUhrWmZOSTIw?=
 =?utf-8?B?aEVFUloxQTZTdi9lcVhSaHUxd1FaWUliMHdreE0wbDJKd2RhOTVVVGFyVExh?=
 =?utf-8?B?elF1L3oyQm1mNjlZLzlucWVjTDZVY05Xa3krdVFMM2dPdlVHNE9LelkzMjhx?=
 =?utf-8?B?Mk9xdlIveTZTbGVvRUVFWmFLdU02V2diTlJacENYbkxHa2JvYnJuWktNTXYy?=
 =?utf-8?B?ZGRGdWExbFFoTDVELzdwSnlZVmhWUkQzbmhlbGltTXpJdmlBTUVONTdTMDU2?=
 =?utf-8?B?aEdiMXBPek5tSHlXZkZUMjY0VFQxRFdkQ25PdTBnNHBQdFAyRlBMQUt2Q1Ev?=
 =?utf-8?B?V3NIZ2syZHM4ZFZFcjVWcmhJQWd1R0EwaExPNTd3a1RWR1FwRkJwNFRVVFdo?=
 =?utf-8?B?cXZTQXl2SWdSSXMreVlIK25uS2ZHKzQ5OXhJMGVKajBQSStMR0dWTkRPM0do?=
 =?utf-8?B?QlhWM0Z6ZDBEZVdHSm1VTE1rdUpONnA3YjNSa09mWm4xSkVnMS93Ujk5Z014?=
 =?utf-8?B?d240WWxuMnp0aERXQm81Uis5ZkE3b3BuY0hjdm1PbitFSFlmNjRONjdEV2dl?=
 =?utf-8?B?Z3hXVkVwbVpvU0hVczM4Z0hoTjJNdU54dmhBbzhxMTJrbW42bUo4V21scDU4?=
 =?utf-8?B?N2lab3lWRGtoaFNhVFNrczdxVklkMEZHd2JSSktROFBSQWwxbVk2VnpLUXdn?=
 =?utf-8?B?Q3dhM0hZaHRDYkVnTmNyb2o1bmY0OHBJVGV5cklLbEZqdWRSb2R1UzlycS9Z?=
 =?utf-8?B?cmhiaFVzYmdBTk44TGJIckM0cktQQ0lkY0g0TDF0cWJyR01xblhVcmcxSWQ4?=
 =?utf-8?B?bDByV3ZlS09WMWVGK21adTMzeEhESkoxMTBodkVia0h0S3ZXdU5FZnE5eTlO?=
 =?utf-8?B?VkdxcjNaV3pEOExyaUFnWWZTYjBtdmFpTTM3YTNSbUVTajU1dTRVblRvdVNq?=
 =?utf-8?B?Yll5RFNWVDVoMW5iSTEwK1JvUld5emRrVFdJc3AwY0xDNnVDakFNdjlJNmp4?=
 =?utf-8?B?aEJEaC9FRlhYcU8wVFppQi9FSXRQUWRNQ0RpTnZGSEtYeVZWSXRPQWplQTE0?=
 =?utf-8?Q?d7A+Wziob3U5O+SxumKxqr/mS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f14cb5-29c7-4553-2eb3-08dd791c3959
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:13:48.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhLv+jGUV/LAo+7UCIvbuyXbdFSF/EtZzIgzWZDJYLWtR7vx2v+YfG7mZJHMU1C8U9HYzlWsBZ3+5I5CjBc6lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Use this to track the whether we want TMZ for queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b818ad63dc84f..364a65524cfdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -835,6 +835,7 @@ struct amdgpu_mqd_prop {
>   	uint64_t gds_bkup_addr;
>   	uint64_t csa_addr;
>   	uint64_t fence_address;
> +	bool tmz_queue;
>   };
>   
>   struct amdgpu_mqd {
