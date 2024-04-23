Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF01C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 22:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2A5113726;
	Tue, 23 Apr 2024 22:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTMZHFmK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13BC113726
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 22:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzAtihWG50ph7MXst0OTVdktKfQtGINy0l5gsPsEzQolsafg1oOGOEx5d3WGLaY03SOQFHddxUSuQPsAnMkbIOfzn+X27UJ9srvU/Wihk2YJMlPZ/eSW0tfsgE6CuPhyXl0l+6HSN/bIy8cbmv2rKmFRj0tmfWYf61WPVluPJ0dm2I4ehJywQurORJCD+nMt0torY6na/mZYHgfn1hNfLU87Pzkgp5WP0eT4ZJGE4P308x0vkEuTeUcfsEJFClLIemHAgFA6BKczVAbgqAl6DIpJQfPcgPd02hYJyABM+/VrrZ2z2PgD60yBAjG3Bf5nYD51zqvhYmDisPZwduFOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iILOWs6dNki6gCDEOv1Cf+OVV1h+b874GoYma+fRxnU=;
 b=Dg5CiX2BDItY7x3AIuL9HmAGWbsMnmlCm3tny/4N7n3X0eG4aTnhqBqGlWjWCs7wpXtnMw7d0HXn2HWX2tNurb7O10QmvfiK7/SxeJ9Usql0SMyBf8iNp+vgPq+Ap4QsYJbWR5mKC2nKS3QW4ak4mMjeheDgkfaMKxhtQOEEX3iwEUXB0MsyQg1XcWKzoYeqZIEhPBYmH6579FIPX5YkqKcQDurbstyg3hO7UwG+v9jdneT6Q7bJPVmelZma0jNW0SnpVWDabyykziK5UjA9FgNnzaw6H/OBu98Intt1lZZvobr405LsVmISdIefeM5tDp/x1L5G/1Htvy76jq2m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iILOWs6dNki6gCDEOv1Cf+OVV1h+b874GoYma+fRxnU=;
 b=QTMZHFmKhxRbWtfP4k1b/Rc8/6EyFUyVEyi1ScNU8ibOx0GsY+Q5FTpB5fZi2LafH3HW/FKjlz7kna5mI+sTt2JQFzBbEugrW7xZKCv+MaR4EeEgKG5W5ShY8yASfDuobXL6j3EkbSrqUsG1aXjfFqL++6b/64krdTu7m767zW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Tue, 23 Apr
 2024 22:06:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 22:06:33 +0000
Message-ID: <c561bc63-b0f1-43cd-a940-5931f3a7e5e1@amd.com>
Date: Tue, 23 Apr 2024 18:06:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdkfd: Increase KFD bo restore wait time
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-6-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240423152900.533-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::41) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a49adb1-6d83-414d-cf3d-08dc63e1a2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFJ6bXIzWXVXUVArNDBScTVRSTBIMGVFWTJ6U0FUT2xtalpvaGtWa0FoVy82?=
 =?utf-8?B?UzVVNHFzM1J5K3ZKaFloUDhQUEhPSzcvazBVS1c4MnNmSmxjMUUvR3BjcVk5?=
 =?utf-8?B?aUlZS0xncVBod2k5RHZlOFhEU1htMjRHV2J2aDhEbGJkZjI2VkJMSGVtMnBy?=
 =?utf-8?B?b20vTFV3Rk5RVTVxSjY5Wi9wRDRUR1ZNSGRqNUxoRmxWOFpLak1UWG1JT0lV?=
 =?utf-8?B?aGVWRm1BMXFTYjN0bE1MUDlOR3pIVGh4aUVSUHJta05STGJNKzArOVlJQ2Mr?=
 =?utf-8?B?NXg2NHorQmhFM2FMOGdVZE10K1JYKzN1SHNTTEVmUy95RXpLQlVBQzNOYVQ3?=
 =?utf-8?B?OUl2c0J6WjdTdDJRWGZ6RnBXSWhqMmEvditoVkxMR05oaHZiQkpBbzh4ZFRY?=
 =?utf-8?B?OWhtdTNFd3VsbW1wdUVLVk02UllrZVNodlVFODI2QTJVQ2l1MDByaXhqSjJx?=
 =?utf-8?B?bWR0cjVibGNmZkRTbEdPUi9FUkxUUlFHR0x4cFE1YmlPdEtCdXVBOFg2dlNp?=
 =?utf-8?B?YngvWUIxZGluZ2pGSGhnbTNqYUVCUk9wUWN5NHZtTmxyU1djaWhENW8zSDlz?=
 =?utf-8?B?azhpODUzZzZOQWVJTjJsMjUvbWt4Q2Izak9CcXhsS2lFNndrNnJhTXJqd2hX?=
 =?utf-8?B?ajZmSm55YWM0eUo3RUU3MklBQTlXRkxUUEkwSmU2WUhZNEZKVDFpYmtJYk55?=
 =?utf-8?B?V2dveEZFL2VnTWM1QUdTbVNJTnVRS3J1T2pya2dBTGdUa252R2xPVGdwaExU?=
 =?utf-8?B?TmdCeEFpdnpPVU9PN0dJcDdxRllON0F4OW85MWhVOFZMckNRaS9BZ1NzNDhR?=
 =?utf-8?B?bEZsQWRmMmVvNitGbjB1M1lqRTZlN2ZGQVdRaTNXOU1JVkxqYTRaUFErb2Vz?=
 =?utf-8?B?N1h0WTlSRVlRdTQzK0dzMWZ3b09wdUY2dGxvNnE4UHB2VEJpV0ZOWThKVDR5?=
 =?utf-8?B?cWxFQXdlVG5QMEsyNlpkN0FVY3o0OXJnZFI3WDFHYkE1Q2VpaUdEMHNXNEh0?=
 =?utf-8?B?L2NscmFTNDRoMW85S2Z3WkkzSUhKay9kTzZUM3FNVWFnRHd3YWQvaEdtSHlm?=
 =?utf-8?B?bXpvMmpRdXBJcGYzOGRIUjJTRXBQZzZuenJQay9aSmJLcEdCL0dlOHljbVBk?=
 =?utf-8?B?ZEg2VWczYnpteUtDQ0xiWEtWK0c5eVA3WTJoQW92Y0V2OXMwVys0RHV0UjN1?=
 =?utf-8?B?RlRJRXdxWXRkNXVTVlJhcGNBcVNEMjI4c2FuQnRBQjJwUm9zRXJueEkybFBo?=
 =?utf-8?B?aUE1L2kxdkVkOTVIMnZQLzVhRHplM2FSOGFzRzUvRWxZc2ZiNlg4SVpmNUxO?=
 =?utf-8?B?K3poWHpnSEYvdXY0MUt0WkRrTUFLRVJ5YlZRbnVJcFFnWStyOUZqbzNVaVE5?=
 =?utf-8?B?QU15dTlCTGpMdFB3c1FGdHh0V3JIR0Q3Y0ZOUGxzbmVQWnNGZyt0NkNKblIy?=
 =?utf-8?B?NS9lcFVtY1U3bEtKclRJT2pyWXZQMlREUTFVWHc4ck9oc3N2bG5qV0IxWVZB?=
 =?utf-8?B?aVRVamJHOTk4Y1YrWTZYWFNXNEUyK05nNWIxN1N2VUlkalRNZkNrU3BpUWsy?=
 =?utf-8?B?Y1dPcThvcjZORS9FanR4TGdmeTc5S0JaU3p2RG83SDBwRlUvNHoraldyTFVT?=
 =?utf-8?B?bzU5Nm5qRWI4RDVPaG4xbG54OTlRMDA1T0dBMGFubm0zTEQ3VGx2bW9oU3h6?=
 =?utf-8?B?bThxMExMSkkwVnNEb3dtcjdXUnNOTzhaRGJOTG82OVRQRFdpZWp4aVZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THlxYi9ieXAwaS92Zk94dkJvRys0RzRXV2dNREV6eUJxb0ZFb0N4dFN0RHlv?=
 =?utf-8?B?eERpRkpBcExNMXIyMlZPSmprZjY4b1dtR0VEWlQzNFMraU1NNU5HNHVVcnFG?=
 =?utf-8?B?VTYyd1hRNG1nalRhWEdhVTBnditCdHBjUm5oc0hIRjNQSmdlbXJUV3hWaGxN?=
 =?utf-8?B?ZDY5UTNHZHFPZjJncWg4WThCd2JJeUJVN1N3VFJsY0h6aE1DK3RpRzR5ZmdE?=
 =?utf-8?B?MkI1M2E3NE1ZdFRReU0xVWZaeHJkNUVrZHdKeFBmRHk2QUVqY24yaklxd3Fo?=
 =?utf-8?B?OWlMWlY1a1ZKT0R2ZWJkaWNvV2xzSDJ4d2VsL2MzTmp2VlJQVFpyeEFKSXo5?=
 =?utf-8?B?WTFiNnNLcHF6WVhzdVMrUnhpQWtSRk90YUt3cFRab0Y2UTZYbG5hS3A4Mis2?=
 =?utf-8?B?M0pTN2U5eGpOYXR2Vk1nZFdCTTk1RnVCQWVLVGxVY1p1dmxrRVZyTEI2alJU?=
 =?utf-8?B?QnF5SGM5VnhCUjZFOFFPUnlGQTFRSmNoOEdmcE1wYkZOZWR5OTV2Y055aDFi?=
 =?utf-8?B?MzdBMldpN2pRVVJZYWFkQWZrZ3l0V2p5V1NqazZQdFZXYlQwOFd0RnU0emZx?=
 =?utf-8?B?Zm5TTXBONEZFbk14S0JpNkV0Vk41eGF4TURYRmVSdnZmUUdOQVg5dE5iZ2ZG?=
 =?utf-8?B?VERjUDd6TEROMVEzQVE4d0JIRG9FNzZlRVR0RndpTEtGWGZTQ3JQd1BvWkt0?=
 =?utf-8?B?SjYrK1IzNlJMV2hhWUhMeUcwaUVQQUxEdjF4YkFZckdULzFtUlNkaURGa0Jp?=
 =?utf-8?B?bVdKS095WDhMamxxRlV1eG5KUGFwU2VDekY4b3Q3R0h1R2RLcmIvM2cwVVZO?=
 =?utf-8?B?dDgxVE0vV1pRL0s3SGErRnpwQnNwalRPR3ZzYUxreWxtZkR2dlFqZVhleFkr?=
 =?utf-8?B?L1o0TWRuRnlyR3l2ayttSjhyZTFyY1pxelc1Y3RvcVNhSFJDajZJdGVFRUtT?=
 =?utf-8?B?K094RE1VL0xkYkswMllObUpYTXdIMlhXN2lMUk9NQml2THF6U0tDamJ2UmZi?=
 =?utf-8?B?MVNOMlIxbkdnREVZWkFZMFoxa1dselc2dWJLUEtLZ3FoTEpteGJEY0R3OGtv?=
 =?utf-8?B?bWVhZFpFbzMwWjdGd0l3OUsweGVsQXFpUFg2Wm9seHlmTEI2amtrSEhiSnVU?=
 =?utf-8?B?Z3pJZ2p3MHBPZnp0b1U4dTRKSGdsMWxoSFBxWEhqWUQwQWxqWHVvNXlFSEYw?=
 =?utf-8?B?NEdiVFFlMFV6ZS9ZUjd2bUZ3b2VzRkoxU1NTaFc2ZTJtUEh3YVVoVXIzZEh5?=
 =?utf-8?B?YTRnVWhDaEpYZVVoZjVRN1NRREVSOXQ4dFNKQjEzSGxWeEJDK0s4QlN2SWRx?=
 =?utf-8?B?WDhCMzRtOXQzRkxkaU9hbk5WcC9NbC9SQk9aN3kzRzhQWFNFTllDYXp5eVdD?=
 =?utf-8?B?WXVkYmg5Yk9DM1RpQTkvTDh1WDhPREU2cnREV0xKeW1jZmFGVmROeHFJM2Jw?=
 =?utf-8?B?ZFVkWHB5QjZTTGVRcXdxdCtEOTZ2MitkOEJLLzBvM2lwalc2L2lzbHN6YWNs?=
 =?utf-8?B?TmtkZ1ZCSGhTeEtqVHBXekFuVEJMd1Q4ZlZVQVcwY2RQSEsxcmo0TWZLN0dE?=
 =?utf-8?B?ajdRLzNPbklCd1kxYktFelV6bGxuWE00cWFYd0FuQ2pQRUNJaEJMQWgvNk1k?=
 =?utf-8?B?UXNFSHZscnAyUDQveDl4V2ZZbUk3QWNHU0pUVUFwbFlEcGNpbFl5NVc2UGpl?=
 =?utf-8?B?TzZUQzVyUVBRaGJINDhJSzZPQmY5TEFvMWZIS1p1TTdvektQaTFwRERqQjF1?=
 =?utf-8?B?TXVxdHlRTEtkNkJlbWdwYWFBVmRUMGk0aGI0eFd1MFBadTh1aTZVeWJ0VlFn?=
 =?utf-8?B?UEhsL3h0dFhGZ2tPVVh6T3BwV0FQQUpVUzVHM09xM1hWMWxVUFpFS2RoMXky?=
 =?utf-8?B?aUFJSFVzRFRIekk4ZXVJaVhzWDdSY2ppU0twc2FVb1hjNVBvbGNNK3l3ZU5L?=
 =?utf-8?B?UHEyZllUU01FeVg5aGFUNGwvQnI2UmxMUElJcy8vL2c4dk9OdWoyQVk0Q2FZ?=
 =?utf-8?B?dkJ3dzBYR0hIRGg2YTcwem9CY29ZTFkzdDUvRzduanJrSStrSWluR3JrYU1W?=
 =?utf-8?B?c1o4WDloc2t5ZTdoWEtRM2o5VTdTVFZzK1JYc2dIdU5HYnRKZDBrRkdOMkox?=
 =?utf-8?Q?/cQWwqnr/PyjXFkAEhH+4QfiF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a49adb1-6d83-414d-cf3d-08dc63e1a2b3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:06:32.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Swq/BXnvRfPCUqp3BdiR6afv3goh4/RH7xe5E+vyyOS5fdbsnt27RIs0VP+vEwSSb6cZZuzKqfONaZjOfbillA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

On 2024-04-23 11:28, Philip Yang wrote:
> TTM allocate contiguous VRAM may takes more than 1 second to evict BOs
> for larger size RDMA buffer. Because KFD restore bo worker reserves all
> KFD BOs, then TTM cannot hold the remainning KFD BOs lock to evict them,
> this causes TTM failed to alloc contiguous VRAM.
>
> Increase the KFD restore BO wait time to 2 seconds, long enough for RDMA
> pin BO to alloc the contiguous VRAM.

Two seconds is a very long time that the GPU will be idle whenever 
memory gets evicted. Maybe we need to look for a solution where the 
restore gets scheduled in response to a fence when the migration completes.

With my most recent changes I made to the eviction fence handling, I 
think we can decouple the scheduling of the restore work from the evict 
work. So we could schedule the delayed restore worker in a fence 
callback set up in amdgpu_bo_move or somewhere around there, and keep a 
short delay that starts counting at the end of the eviction move blit.

Regards,
   Felix


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a81ef232fdef..c205e2d3acf9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -698,7 +698,7 @@ struct qcm_process_device {
>   /* KFD Memory Eviction */
>   
>   /* Approx. wait time before attempting to restore evicted BOs */
> -#define PROCESS_RESTORE_TIME_MS 100
> +#define PROCESS_RESTORE_TIME_MS 2000
>   /* Approx. back off time if restore fails due to lack of memory */
>   #define PROCESS_BACK_OFF_TIME_MS 100
>   /* Approx. time before evicting the process again */
