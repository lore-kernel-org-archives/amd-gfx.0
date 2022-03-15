Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1440AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037810E3FE;
	Tue, 15 Mar 2022 07:22:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5D310E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiyGW0i9geyJh7wQoCZcTfuy0V2xQ9f71fECQxwlP+cV4UaaxCqcweLdQSqiFnmkxe4B/p5JxCA9J+IAfVfoI5wwwkrZLPuOyGxY4JSRD2lR1af15jWX26h0kMfBfw/mVgyimihJ33okrmCBGA3UcuGB5qQGBsENBxlXRE2V8Xb+Bm6tgzmO+QlXkILiiYu688cvPgyI4LpCViX8HgNenUrah3/usv3KxvolLI4yLx7nIak8WdXy6iWXu4Uiww99ew11PzC6tHt0GmZKxRZNQdupq64eMMzWrY3BM9aQp0RkQFtPUrvBqwwanAjBLjmiSAL7LTcZVIasSRmuU60YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFn4zAuHsfI/TeOWFwtX8lGWuQDrCn/ZMAjNnWcFpTM=;
 b=YZuRtuUuHn6zo3hcW6dP8RGXEuVlgas2dxBvhFcpOra6yWAhVvDT0Ap687d8UteC46GV82r0SoiBxrwPES6vqHTqDnDhKu2LT9IU6TZwMRLNDf8y6aoXc8u9nC5/SoYFmxJHtec3tmUwg5mcqU02vZWBv8yJAyayf2ieqIvJzri6RxTevChyzIVGV3vThoSFDLRkFcls17zi2xoxD5gepXBcuZEIiNSrZ9Qo9dhTTauelvzIC0yTLeCdOv9vjuUXFIzh/CO/c1tSMXh7HMydxMDSG6dpZcvNuUCSko3erN/FqI87ylPoLc241gMsJfkGWavN3zKuVao6yaSBqOjwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFn4zAuHsfI/TeOWFwtX8lGWuQDrCn/ZMAjNnWcFpTM=;
 b=1l46lZiUVRfKxefXFwgCCcA4s1Vu8MRD96fKSjrDYS6l1KTgFVhm9Rk5Ch+l9L9t9vu2ntLy/ji/qxU2RulSVmQgo0OVvguh0GZHlvp5XtSR8rT/1xi7j9dbSp1kNo37sbNNZb8ERvU2CdF1UC0EVu5p8W1PO94cHPnPrrRSNoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 07:22:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:22:27 +0000
Message-ID: <b0849888-2880-ef1f-67df-b6b89463b60a@amd.com>
Date: Tue, 15 Mar 2022 08:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pin count leak of PDB bo when unref
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20220315071102.9773-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220315071102.9773-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0356.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a2c3f9c-3310-4020-9edb-08da06548f0d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB414621F95BEAE0E74F681DE583109@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVIekmZ3KtG/eoUfdSIdvyc9xhjJkJuX7GZ/JYinXb/3neuefahQ+uZ04fSAv2hqiyyjw6q3QmhV800oQn0Yo26gecmzE3TF8ZsfvmG6aDXr1xYKkcCf05iv7+6cvoJvRRYAMmALPoy5DbLpgVaWwTcIKMVmowzMuLnZalSJc1chNHw/tIKnJBL/lxIEDzJo5fO4zFhkWvbTlpFF+rXUjTQGzWVoiOTbi4ePRAXDPxR2JDysN9xGbYsLc+ULBZjoiVlh3/tBhLSvsO17x/JmxetTIRf+TqgpsPDXojWwy92PMviYF8dgARj+sFsk055qZLNqCP/1yHpKzzi7GqjyQqGf+TbEkTf2N5dbYfJKWJUPLsWJ299orVCi+mwiN2u40K9BMoICiKw29jg5JvKwtggl06m/VpJVEu3EfO9grzut4KKtH+o2Ao0Exo7QoQ+o7yaM3p6eqHPYxtFjBC34ESi8d7XCSUWKcGyLn+zS+JG1KGoDidL+Ar0LGOCcMGEEhQHdwF2wTUFvvjBV1eVhhceE8qVOp7ZD8j6z79YWZoYgf8xjD+ZRXDP1yIQbNtNkBK21aCB86ybR1VB41nxiCr3Pp1hj7/Ilw9B3TaVJ/xk60EsT843zfsmpl1k/l8D7neC2zJI+5a504aYY4bP/ajPrQCCpNFtjeHkoamGwQNUIw8vXuhooJK9iJpcDIFvPzqBhXFlth0hQMdZs7DqHz2W04GxW5JGxvHzdqPi7s5TnYCnZoFFk2NfpGydUh5/G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(66574015)(8676002)(36756003)(508600001)(66946007)(31686004)(66556008)(6636002)(66476007)(316002)(6486002)(6506007)(38100700002)(5660300002)(8936002)(2906002)(2616005)(86362001)(31696002)(6666004)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnI2Vk9scUx6bGtKaVc2VlJhUG5Jb0luZjc3eWpyNjcybmU5d29RcFltZ0RV?=
 =?utf-8?B?TDFlRDB0QlBscTV4TnNBMVR2amRpVnZGWDNuT3JUOTQ1RTRzN3pCUzF3a1do?=
 =?utf-8?B?bkpUeDd2OUsxSjFSQVY0RFJjcy9ldmFLZmYxQU1mQWdIMk9Qb3dKZXY3a0JT?=
 =?utf-8?B?TVlVQWhuTHYvUnNObVBVaFUvTzRxNHhsMWlLWU5JLzhVYlNRUjhXbmxneEhq?=
 =?utf-8?B?bktMM3RHaSt3bXRacEdTTGlHYXlIU2F5aWM5RDRreXZ3UlZtNEdERTk5eUdU?=
 =?utf-8?B?Uk5IRkZYOHZ5TVBoSDU0M1hLNDh3bW5Odml4YkM5QStEbEVDWFpnNGRaSFZq?=
 =?utf-8?B?QnBXNndrN29OcWVEUmI2eTFpdTZtWlRIZFJHSk5yb2kvQjNub001a253THJy?=
 =?utf-8?B?RFI1UnErcWtzcXNkRVlVRE9IVitDdUh2SXpPZHZkRlUzS1cvVWJXbG1aS2ZF?=
 =?utf-8?B?cnd1YTh0cUhGUFJtUUlGczJiWlF2b2FXZkRzd3RNWnlpZVIzRGNuNVpmWUN1?=
 =?utf-8?B?dHVqbzRTVGp4NjNYT0EwdzdTdC9mZHE4bXJrMjVmRXFjcEg0bXluZ3FUNXdB?=
 =?utf-8?B?V0RpbU1uY3dNd3JQa3k4MFlrOG9oS3VobUNqRWpJZ2ttbmRYODdSWWw1Y2Fj?=
 =?utf-8?B?K2NBTThPd0dFanp0OVJleDB5UE4raUhPTHJRMUp6TlZ5Zzk1ZE1ZUm9WaEdX?=
 =?utf-8?B?Z1lwdGk5alIxR29hT0czWFBhWmo0cTFPalQvTUJnY0tPdVo4SUpVTmxtMEMz?=
 =?utf-8?B?VnhEV2duUzBKeEpFamh2Vmg4ZjMrR1hncEFrb2hHNG9YczN4aUhwVUtpbjdP?=
 =?utf-8?B?ZkdPMEZqcmVMeEttWE9ENWNWdEFVZVUwL1JIYkJYa3lFS1EwRk52d0VTWFFN?=
 =?utf-8?B?N01DU0JhbDZ5a2pCYUh3c2FTZDN0SERxVmNJOG5tVzkzay9oTUEvUDFJWnJq?=
 =?utf-8?B?cnVzcVl0Mnp2cHMxdnVGT0xPaDYrUmVPYjhndUdlQ2ZUUVc1Zm9OUUxKMitT?=
 =?utf-8?B?VlZmU1VFa3RzY1V0ajRZRUhvd1gyQmZWaXQ0Qmx4UG1CMmNHTnhmR0pXdVlC?=
 =?utf-8?B?QWRiS05FL0diYy9LeXAwbUZsbzloK0ZrZEN6bVdUTjBBR3gxbzR4T0hxN3Ft?=
 =?utf-8?B?OWZuYjlUM2xJVmRLTFJJU2FyMGxMYWhSUEFsR3pNV3huckM1NXpmOCtXT01N?=
 =?utf-8?B?c3ltT3JTMGwvZ2Nsb3pwS3pLVGdmUDh0Q3FieHdMTUFpcVZXZmZQZDFxYUg0?=
 =?utf-8?B?VjBkU3BpRTlocFJQOWUxci9MWThvWTE2OTZBQnJ1elpGY3VEYUZRZS9HMEdx?=
 =?utf-8?B?c1lFMm1jcUJOU1dDM2FjeHFtekdlVzFQT1JQNFZBTVhRdGlpcVlCNU5yci83?=
 =?utf-8?B?TW1HNncxU0daN1ZPbHp5cklLZDlYUG5PQmV5MzBtTURJdWg0K0pYRWV5Zmgr?=
 =?utf-8?B?K3lsVjYxWDR1YVQ5VHltNzJld3lYb3VwQ3FSakdzQlRpWEkxb0p0NXdHMk41?=
 =?utf-8?B?M29FbHo0UVRnMVo2MU1Ha1AySHdhTmNXMUc0c0RlWWE0MUwybVhOWW8rWSs0?=
 =?utf-8?B?ZzFJUmo2MGNBdy80UTk2UExRM0JaaWQyUHF0WXFXcWc2ZnpYNlRua1BpbVJG?=
 =?utf-8?B?NjdEa0RxTVh1K1o1WFpwUXB0ZHNkMDZOdTRJVUVrUTZ1NGJQV3grdU9pYXVs?=
 =?utf-8?B?ZFFuVXhoWEhMa1dRV3RhUlF6QVpvMUVQSTZjNnR5S1YvV3h2bnVld3pLeGRn?=
 =?utf-8?B?TkNhd0lzdnJGU2NWaHlpZGFSVkc4NHlqKzB0bG9LdElVYytpcStXUDNCMlc5?=
 =?utf-8?B?ZmdHK1FrM08xU1lPVVY1Y25mSnNDMjd5Z0NNTW0weDBDT2Z6YmpubWNGSGRI?=
 =?utf-8?B?ekpoUlBEdGsrL0MzaC9nTEIvUjlUNnZzalZhek1sODI0OTBDK0U1WlBpKzMr?=
 =?utf-8?Q?6YKNsI0uyrx8DAOrRUNKyeghmD2H12a4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2c3f9c-3310-4020-9edb-08da06548f0d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:22:27.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp6HqhuiJ1SXjRLc3e6g1Npx7VE3FYU3GLIqQyshgtYQ5wJ2RV0BC95OWdANB0is
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

Am 15.03.22 um 08:11 schrieb Guchun Chen:
> Use amdgpu_bo_free_kernel instead of amdgpu_bo_unref to
> perform a clean unreference job.

I think the subject is incorrect. This doesn't leak the pin count, but 
rather produces a warning that the BO needs a proper cleanup.

> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

With the subject line re-validated the patch is Reviewed-by: Christian 
König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 431742eb7811..e4e7e6dbc6fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>   	amdgpu_gem_force_release(adev);
>   	amdgpu_vm_manager_fini(adev);
>   	amdgpu_gart_table_vram_free(adev);
> -	amdgpu_bo_unref(&adev->gmc.pdb0_bo);
> +	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, adev->gmc.ptr_pdb0);
>   	amdgpu_bo_fini(adev);
>   
>   	return 0;

