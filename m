Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA031062884
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F2910E8DC;
	Wed, 11 Mar 2026 12:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DmLJnXkO";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8157B10E8B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 12:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvK24UMHgd2xDalaU6a7q4t6sAguBM7R0V3syKTlEJMClDru9dqDKz8Y8Jnb9Gv8y42ck/6McvtJ+MDW4si9A9q5/rZuvZsef9PJW7L8s02tivVfvvVVR3UC/AO+xQfPFn5c2Hu0y5cTYg2VScPKgAkPSfuirFeSp2k+nTQSU600rkKMA5ONyduL5H8pSC/RP0bMVDnbnGtZvUbEIiMIQ5SDXZbxeUkAjLmHyQcwh16o/EWHwQWaDDl53jfNZ4R49HpRohcyn9Vhu2EEpCIGTlGpCciNwhYgtF4oYXKMs35plfub8J0H0ZVyk/DlZUPtdN3oWMf4emd885tS0SSvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLBYpLz0LutTeI77MxvgySGNCe2RIdQHqPwKx5poHIQ=;
 b=rHw/N3ayaaRr0WZ1zqT/gsJRHqh0OvjNjkBBDpxGL5tPyaEpombBgj1pXKYi1wuSWs7ZIVFVinr50aSUeHuFYXag9Zkri0nw8e0hj1mBTn6z84CJqh7Q/GEubS1YKVW8hx4eVNxcm7AcHAH2iMVcgS1dh0gbn85qYkR2N/gr9MRjy6gsnaw3nXjIgKo499sNxSHirPO5ov2HNWtXDYqRYOZvgJCQWk4Yje/NMViq20ihPlFDpLeDi3fXGdmpFjvseNUiinpmq873kyCI4tednyEZhvMS8DtWOegD0vulaA0JLAz99iBwVGNCzJ9iFxDykaTJzbxk8SPPxxXyiQbVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLBYpLz0LutTeI77MxvgySGNCe2RIdQHqPwKx5poHIQ=;
 b=DmLJnXkOcXEX1ccP/yF9M7X+S2RFYvOI2TnrOtLE4Z6tCsF3Lzi1n4o7qt1lCBBlpo06eX1ZBsExw3WujCQ+1m9CWJq8FgyHgb6SHX/USi4UIIdvy19Sn9ya9dTN/DzgeIYBzgh7SISA4c7B7ZKsKZU6u5DV5GKLCdLuy5IHYb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:27:05 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 12:27:04 +0000
Message-ID: <bd511d12-f07e-4277-b5ec-270578ea5b4c@amd.com>
Date: Wed, 11 Mar 2026 17:56:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/amdgpu: fix eviction fence and userq manager
 shutdown
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-5-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: eceef37e-e899-4e40-a0cd-08de7f6980f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: QdtG6CNxpAsWCp5v9wcRQPw/to88As/X8Tigc7uWv8Yi4uJ7slno/YnT/4e8ES3noI1JIZA9J4dmoxOP9fAJcZeW2kGdHjG42YN+pTetqVonxezW9bbkHSUQ3XCWK6lhPNdfni2JnRqbBI5X88KmTEm2veFYW709h9YX/z1H/qjs4A1m9wqQ3RHfE3qNgPO4juxKJDKiWy7FwEg6ZcLib0ZWiXlnZ0mn/fqJ2TlP4499u2uAUIlpyJxjCRO+FWryz3RtpsT8fgqL0scfAzWAo/rJIJD/o6HztquAOWlp9JO2azMf7ZlD++dKtVM2jKrhbNT1Yuo11dOaDZm9Bv27eWVR6QjgGzSwee7bqhzgBORMMh/ZIeWiCirUYatTUdxqUINfYpIpxfkU4l81LnGm8rmItJPpmbRb37M28uo+JR/0pOIFg516tv/DjkBPwepcz6owASBHAbooOnuGy0HClz8PQbVIENTEedDG8glrsAkZDHGXbyItBEFmrM/FOEy0VaXKKaj9lg1xUWTxi5jmu5Y1YkDXBjm66uSb8zUYGyy/andx/I5pq6Uh61a0lNIPjdiAc5NZrZtU7d7DM6CAuVcs3PMs92mzFHz7mIRoFj7HZJh0uxPR8czpIh4YEe1fe5c65KTqd6jmoWAC6vqU2HZlOjAmKOGAp5zG23yaT+binXwy/dRVxJmWoxaCFHKR3mis9rvSAefLztUzb3gSwCk8DL1I+FzMj2kBkj64P/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFoczA4V1FzK21qTUpjaFMySVBSak5KSmFpRHJkTS9iRUtZOUNrdCtoS1Nq?=
 =?utf-8?B?cUxpYzN5Y2ZFekE1MzlsWm4zWDBCTEk0SWQxQUR6LzhOUTM5R1BsaWRvY3FJ?=
 =?utf-8?B?dUFLQzA3Q1ltS0I5RzVHNnFBQ2dBSmwxZUZ5QUJFVmRGZHBMTVI5aU1rN2gz?=
 =?utf-8?B?bDdCSEdMUHB0VGhkQmJwMGdjdThVMHNBejg3SkJlTTFkdSt4cGZqemhPMys5?=
 =?utf-8?B?RnpBOVdwb2w3MDBXOVhCekFVQWdmbW9TcWxwVlAxNm1YVW5NVjhEcFlZR3I1?=
 =?utf-8?B?Z04zWlFWbnlWclF6T0xzSUdKekFWcit3Z2lQRnNEMmhUZWRwMUdMMW5Idm1s?=
 =?utf-8?B?WGxVa003emEzWHpTRTBNckRCUnJFSHUySFFUUEJqcGdyN1RqazI2c1lmOXpx?=
 =?utf-8?B?ejI0WmtGTnhQZTZ3dHpYa1J3eDBWdFlHOGZkSm53WGpxSU1VUk5FMDVha09m?=
 =?utf-8?B?SUVDM1dxMitMbkk4bEMvYzhYdy9GcXZmaXdvZHpXOXpZRjhoNERzZHBPY2ZT?=
 =?utf-8?B?TEV1RVhVa2VOTEZFT1NTM0laQ0lEN3RDcGo3ejNDekFLMkI2K2lMVlVNMHpQ?=
 =?utf-8?B?RGdwZmtUTzdiSTFteEgrN2F1RFJKemFwejVTczYwbHRkbW9Tbjc3V0hid2pD?=
 =?utf-8?B?VTlrTXdoVlV3RE14UjZ5QkJwMUk1M1BFSlczemc5SVQyV1ZCWVNQN2RtR0NW?=
 =?utf-8?B?c3BHRmhpN3d4QTZFcHR4WGhZbGtCcXk2dDZ3ZFREUkd1VlRvVjhCZ0lPNGN2?=
 =?utf-8?B?akFsQXVnaTlnUm1NZzVsbURLVWFXajN4UkJPaTMzUGkyRHZwM2xVU2lQeHBs?=
 =?utf-8?B?eVZQdkFoczdKeGFqVzM4MmY1cGhKbjB5djlBekJzb01GTTN1RTRzZ2ErMzNF?=
 =?utf-8?B?Z3VNMTkrcnFINXlJSW11ditNVzJVZzV0SVBnazJ6K2RzSERUdHR5b3pDbzRj?=
 =?utf-8?B?cEsxQmpqVUtFeDFhdjdNa2tyWTRPTHByc2l1ZnJwa0U3eFNBcHVjcFhzNlMx?=
 =?utf-8?B?aXg5Q2lSWlFHTUViWEg3UnQyaVlTL1JIYlJ4aGlnaDJNVVpteHpaaktsSkRR?=
 =?utf-8?B?Ymp2NFdEZ3lmUHhtenJEK0F4L0dUbWZXYUZxZys2N2syRVRkOU1vTHhqM1Jr?=
 =?utf-8?B?SDBId3VRNlVaOXF3RnFXODVSWjV4R2JSKzNzU2doc1ZCWWNhU1NhcFVwTXFa?=
 =?utf-8?B?Wk5tZUdkNWNiZUZnMHk0ZVNIWXF3emlVYW1ONlBjQ2dyVCtFVlBQa0NBMDc4?=
 =?utf-8?B?T3ZXbmRGdVdMdkNYZEZIR2xndVZFdDlLZ1BEblVSd01qSFR0Vm1tYzlnejJt?=
 =?utf-8?B?clllZHlUdlp0dER3dVBxeGFkYUFOTWZuK3hGdkdkYlNodWhZaUU4M1g4Z3kz?=
 =?utf-8?B?a3NpcW5PY1VIbEdYekdsT0kzaWpYL29saDV4emd2bktUa2ZCdUlrbEFSSzVs?=
 =?utf-8?B?LzBDN1VKZ2dVanVxZ1I0T2hsRkhaWHRGMVI2RnNpOGZsT0JWMFlqcGFNYUlR?=
 =?utf-8?B?dXpwOXhlL0RWVUNXOVFsckJDTUdwMG1aaHhwRlFMekxmZHJCOTdHbmkzSlc4?=
 =?utf-8?B?UXNuRTFVZXZJZUxHUGRTclFUMWhyT0h0ZFpjZk1taFhzYXdrR0NianZFMnVE?=
 =?utf-8?B?R3pOUENkWFJXbEhWYzRPOHZmdEtpMmJyRUxwYTZyZFpDK2pWWmdBTkRXNUVN?=
 =?utf-8?B?N2h0NTcxZ0Q0eUs0cXM3WFJKZDVZTGFKU0tJZTFpa2ZMMnVzSUxBaXhWeVZr?=
 =?utf-8?B?a1ZKbzZ0WnBDRi9nS2NOekNTdk05dGpScDZLMW9YdUY3UUFTSml5Z2pYQnBJ?=
 =?utf-8?B?MFRNTVViWUdldS8xQy9jUmhvSXAzRUdjNGRydmVJZTZVV1E2VTA3K0lTcUJo?=
 =?utf-8?B?L2hBTzRTTy9XWXBYTWlCSi9DUzA2KzFDSFJvSFl1dE1mWUlEN3ZxanA3S0hI?=
 =?utf-8?B?Q0NIS3lZcVBWWisvb3d6dHE0RjhqNTBaVWRDTmR5TGdWMStEQklvc2FlVHZJ?=
 =?utf-8?B?bmFHcFpWaytYUlh4TWVxQzYxcXVBTWc4MzJVZWNDMlg1SGozUFVjSDJFY1BV?=
 =?utf-8?B?RmsvWkJ0ZytPVWdXTVVZSE9ub2tRZWFZU0tMdVVrUVdYbHIwd0tTVFhTY3pF?=
 =?utf-8?B?UUwrQXNsNUNYbGJ4d3hEUVZiUkJxS3o0dVVVeWNkUzRPZjBvVzlScGpTaG15?=
 =?utf-8?B?blhPT2t1c2ROVEVUeXdJMmM5aDh3SEl1MGhEWHBvb0lyTXJNbHQ1QWlhMW8z?=
 =?utf-8?B?b3RaR2x5SEZsZmRVblQydUpEckhCUFhURzkxamxzRWhoeXFETnNUVDBQZHZZ?=
 =?utf-8?B?d3RMOXlwVE0ydkdrQU84UTQ1Wit6ZGM1LzRPNVh1R0NGWlZLeGtQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eceef37e-e899-4e40-a0cd-08de7f6980f7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:27:04.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoSqaBhngGC3S0kqQYX023Y3Y4f13TCjhi6wU8YAI7YQ4xxyQQagNlO8Kzsa2f1y4iRsB62Si+vzKIUzEF7NcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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


On 11-03-2026 12:43 am, Christian König wrote:
> That is a really complicated dance and wasn't implemented fully correct.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
>   5 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 67b8c33d5ee3..d99e80aa3204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2953,6 +2953,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>   
>   	if (fpriv && drm_dev_enter(dev, &idx)) {
>   		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
> since we are doing flush of the suspend work in amdgpu_evf_mgr_flush_suspend, we could get away with the shutdown totally.
> add the flag of shutdown im flush_suspend or something like that in one function itself.
> +		amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);

Should this be the first thing we do even before evf_mgr_shutdown?

Regards
Sunil Khatri

> +		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>   		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>   		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>   		drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 8fe9f91f9551..ef4da6f2e2a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -146,13 +146,19 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   {
>   	evf_mgr->shutdown = true;
> +	/* Make sure that the shutdown is visible to the suspend work */
>   	flush_work(&evf_mgr->suspend_work);
>   }
>   
> -void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   {
>   	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>   		       false);
> +	/* Make sure that we are done with the last suspend work */
>   	flush_work(&evf_mgr->suspend_work);
> +}
> +
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
>   	dma_fence_put(evf_mgr->ev_fence);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index 527de3a23583..132a13a5dc1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -66,6 +66,7 @@ void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
>   				 struct amdgpu_bo *bo);
>   void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>   void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr);
>   void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 67ba46851c2b..23e4c5f99f67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1344,6 +1344,11 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>   	return 0;
>   }
>   
> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +	cancel_delayed_work_sync(&userq_mgr->resume_work);
> +}
> +
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   {
>   	struct amdgpu_usermode_queue *queue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 82306d489064..f0abc16d02cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -123,6 +123,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>   			  struct amdgpu_device *adev);
>   
> +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>   
>   int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
