Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8D7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 22:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A726EB2B;
	Tue,  7 Dec 2021 22:07:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B976EB2B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 22:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSfEyy4GMpYoputVKjiefo8m1dxD/UuxCeYbsemoToxCx3mZQ1FX36/tXOUqDddhDLpnktncmb1BDe2F9hqpzqZb/VBgTuvHeFr5qMp0EP0Q606W8W8tSfpcSzOSmVyHt73esog7VMUGyqkI3r6bEuJXv8dbH+GYTPfq09IUmK6ryMvq55eq/zMWVXwuAIwzb9tP2ufV9D/31WNaV17CL+KCfrutfpXywh4+a6G0UnzWYWZE4h4KshWT+z4RUFYXxY/A6kpg+FwlGJQ5cx4Qgq/9TM/sUfLZ92xku17P6BNb1aMT7WDP4YuC98FTrMVMiaTpBMzJ97nA7fNQgqG7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1KZ+lMaEU6cSLNhxhQL0s5FIEMnEjUjVzUBf8L5fB0=;
 b=FjukYFapvu1PXHpV8vEA1Rwgo88mTlFa8j958Mgo/N0g4Bzny2UgYGVVX7Q4DHEdl0TxnJDAzxDNGnfRHyr73HdhOKVCzV3czTnBMjRzSq42JIxQWSGTbxXdw6VnFhH2UbkdCF3kqFrepUXzxNoqX42PplkdbbYu/ba5+9uTg5i+sMfgGdMCh6sJWBhjdvX7zfvTXLniadX0E7Dw4+PiOMkIF5oSVHKo5TyAk83KRuzHsSQgyM6TpcTDHTGQFBi5YHq+QmvLEC9I1rJq/cdRjF25JLcId/PU4sJ7nvqvLu4TiHasq+LLcOYL80cfTW3yseqQCrW6yg0410yum+2zVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1KZ+lMaEU6cSLNhxhQL0s5FIEMnEjUjVzUBf8L5fB0=;
 b=25+aJOM9fh/1C3HIJy2va4sNCxDFq/+iVf90in7P5KUhRxlqutNazjxbVc+QJ91K+a1CHOFNTMKwlKfEiC25WmhPslAU1wBwsB++B0R91fZDxsX8ijr8BwjcSOczxKnzKX6XCv+dhxKkCZ5XoQ/0IMSF732nvFtXF0OynJaDaeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 22:07:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 22:07:40 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Reduce SG bo memory usage for mGPUs
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211207145911.2690-1-Philip.Yang@amd.com>
 <20211207145911.2690-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <134c0421-aa74-ee8d-c8bd-1539a2bde4b6@amd.com>
Date: Tue, 7 Dec 2021 17:07:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211207145911.2690-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 7 Dec 2021 22:07:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce45a185-138e-4300-d2ee-08d9b9cdfc9a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5383:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53833A40F289D1AF12C0CA54926E9@BN9PR12MB5383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtYe7sIRmNaMDmfuRuZU7nDAcy3ngGQIcwXBv+e+tHXZ1b7Y1VV8LBOBKgD5PBMuD7BdYgC/P8sKgDh5iLJjRpCmdAFj9fqo0xk1MH2zqyqwDDPkIXIQ6suDcfkPdNnHGsHdBuRfM91dZim9iSvQdekKwHAzJWB9t01VdWEuZzqxYCNbKn6sAnFGM4U8l9aCJpHXOh09DNhPIS28RFPNUQFj6r/JVZ9EDA9kATkhGaNiAR6HEoVq1c+4GnmJoYVrtcoBgLK3r7tFGf4JWLEprkB807Oh/jm+4s9pX7g+XTmbofDDzHTUmLHeN2IWe9sx3ExN5Osdmnt2IWSq8I6qUDe3Ra+bz1OmzheKz/9Yax8qIqNZtmec/R42yiXE0jdcw8naP6z/yN7WIPFjoasDifCQPQ5HcI1XrayIaEkumgEm0CJsxiRXny3zhq35vc2kigV2NoxCO/11uOlyxJK0Ii0NqNqXff54vdFJ/xFvu8VeEHwUvHSeo4XdNqX8X2zLLLJH4N+YYd/gl7+2Bg13zs4jO6qwTkoRfdhp0ieCOBqRi8fpxhXTueS1mPUtcS2Gn/q62C7MUBDrdZuj/W78U0mTnBskmMKpqihdxTPyiK7uUUrs0r+mlRCptjCYRQXxdKeisMT6XjCRjNcjo+3CJTAUqwArfdNNbe4XFbJM1s7Vw9tS6z+WEUgMkTUGR0J8Aj4Q7tld5cZXkuaJmxhT151JqC/14gbE/ckIVYW/Wgq0RjNf2oF9+NVwHYtxReeT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(186003)(26005)(53546011)(44832011)(956004)(38100700002)(2616005)(36756003)(316002)(6486002)(2906002)(8936002)(31686004)(508600001)(8676002)(36916002)(83380400001)(16576012)(66946007)(66476007)(31696002)(86362001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9WZk14RFNBU0tZclhDT1BJV21qeEc2TXpGbnVubTdXSzJoZUdXWFNSQzZm?=
 =?utf-8?B?ZHFROEpPeXcxbWsycTllemd1N1h6SCtiSUZ2VmxreHRzQXl4U2dna3JNdnBy?=
 =?utf-8?B?Z0NvSzRObW03YlRMSEZqYXl2Tmdvdlp6VmhqWTJmZHVxNTBGSFVueW82L0Jw?=
 =?utf-8?B?UkE0ZkdDSEFSejdlc0F5dVRsM1BabG5FWSs1K3MwSmE5bDIzSjBQZGJOZjdY?=
 =?utf-8?B?a0JQamtOOWFhRGVtWGNQOS9KY1FvV3ZjV0ZNTG1pb3E0Sk9Ealk4VStadXdE?=
 =?utf-8?B?OVJBZEw1MWZTNHRCbUtuZTAyVElMRUJYQmNQWmg2TFY5R3BwM21RdVZQNit5?=
 =?utf-8?B?dUoxdEJnVVBsU3luL1grQmU5RnZNNHpURFgvSHl1ck52RXdsRWxRaE1qR3Rv?=
 =?utf-8?B?WmNlVVVBeG55d0FtRVREYlJ6dVpGZWVCV21lcHVYU2NZSFV6dGFiU0hFNGpp?=
 =?utf-8?B?STBnM1lmOVpOVjBrSzVzbGhuTmRQMldpS2pFTkZ6VFNpellvK0I3bEplQnNx?=
 =?utf-8?B?dEJOdXUxbWJRQW8vNWorMFdnWFRwWXRGQUZ1SHk1b0pvR21peHlHbmVrTmdS?=
 =?utf-8?B?cFF4ay80T1VzWlBWSjJ2TjBydDFTR2pmaWFGbzhCS2FuS25oaDV1YzhqUzVs?=
 =?utf-8?B?KzVkcHBXWDNLbzV2clFNaFV2cnY3Wk1rVkViRXYwZ0wvRXJNb2p3YW5LTDlx?=
 =?utf-8?B?T0ZTODF6UXJVT1EvbjJ1bXBJeEl4YzRlU280cjNDMEZUaFRWMVNxNTV2ZXhx?=
 =?utf-8?B?aEE2OXlhOVhabkJpaFpsWW9YUXF2VGZoaFAybVpGakVObTk5dDJQYWthZmRT?=
 =?utf-8?B?aW1sL0YvZTdTblB3MGNidk5PQS8zcDZESndFNjk2YmR6ZkhtTmhjQStMVGNN?=
 =?utf-8?B?SThxcmhkRnZweEN1bU9rOG9JMUt4L1hyQ3RWcVAwNERuZ2kzYmdKa2FxUlJY?=
 =?utf-8?B?R21kRTBPMXIzL1hRVVdhb044dzhWZlBxYVRPZjJWdzRrRDA0VGFwKzhjY2pN?=
 =?utf-8?B?bDRNalhyT0JHL3VCanJNNDl1c1VoVTVxQ3ZycUI5T1AwendKeVlyZ0JPbzc5?=
 =?utf-8?B?RDlZZzl4UEMvaTh4RmdacGloQlNUcGFWb2RmWEEyT0Z3M0JFUFQxOGZCSkxG?=
 =?utf-8?B?OXN2Y0grUnBGdlNVS0EwQko2VSt0Z01CZDZSNGJYRjVjMXhyekFpVTVDVGFL?=
 =?utf-8?B?MlFORjRLZnljRGpXZ2c4Zm9nRUt1aE42RVhGeWJIbmc5bXNkMVVFeWd1dmF4?=
 =?utf-8?B?TVVUWGdDaysySDBFZUJGTm5TeXdMeVNXa21GRGRwbHRIWUNlWDF3eHdnVGhk?=
 =?utf-8?B?TDU2NEFxYVU3VkFWZDV2SG5GM0ZZN2dabk5hM3FLNjNFMkorSkxzRFZtRXQy?=
 =?utf-8?B?QkJnL2dQZXZUdkt0VFo3alBWaUxWNENJbjNrUUd4UXNPWitqaUg4MjFFZ0Vo?=
 =?utf-8?B?VGlMaTN4Y1ZpNkZnaXQzY25NSGR6Zk9LZE1pb0tOMHg5WDNFTk9ZdmdEM2FU?=
 =?utf-8?B?K2t0c01qRmFEcXliZ0wrMlA5TUdFM0cxaEpJQjZlWXVXMytjYVVaQjF3YWd2?=
 =?utf-8?B?STh1bEkweHJkVGdmWFZLd1lHUXNVWWRXQjBjdW1NODE5allRMjBjc2dKcnox?=
 =?utf-8?B?ZGhnSnpnVW9jWnROd0p3ZlE0UndYSXROWWFWUjFnRFF6Rm5xTEtRZ0ZkNlJ0?=
 =?utf-8?B?eDNNcll5N2o2NWdKOXo4OEw4djNEd3J4Y0J5c05LZ3ZQZkpLdERmRURIaUxi?=
 =?utf-8?B?UWdxekdXWEMrUS9FU3pwQnNiUTMvWUZEdGRlV0szUjdRZ0JZeTkxSnBSUjNv?=
 =?utf-8?B?eHZKNk1RbUljRThMckgrM0N1ckQzeSs5SkEyUXlVOGlVcGFwOUd3UEhxeGlF?=
 =?utf-8?B?ZDdQeXBWZm82aDF1RlNmbUNXckltelAycVhGL2dtMFdmZVJweGZmekRBTC9x?=
 =?utf-8?B?NGRoVVlLZWdzVTk4dTZjRlcrd0FrcGtFeXhwKzZFUWRCaE1IamJkMXhnTVIw?=
 =?utf-8?B?KzVCRE1JRk14WWl1ZzlzMnoyd1pITVoxSERQcHRSRzNBVXhuMVZ6VG1tMFAy?=
 =?utf-8?B?Wk0yVWRYbEFEcFdsR0hKcmcxdDR6ZmxTbk0rbWZ1NzZTYTd2eXBBVzlHd3RO?=
 =?utf-8?B?WVZ6ZXBQRVBkbmdPYkYyNGl6NUpXeWViOGJLOE5taHMyUmU3NTQ2QTJlNFQ3?=
 =?utf-8?Q?+6QQGqqAAN9tCCwFDcjWdFk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce45a185-138e-4300-d2ee-08d9b9cdfc9a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 22:07:40.8578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMhxm8W8CDL9ilYIvZtkWWbMNFF2yDa6XEuiB5vOqwOfyZFBFLFekWN+wXHyvLrce2yoXFZ6iqdPEW0tYBLqOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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


On 2021-12-07 9:59 a.m., Philip Yang wrote:
> For userptr bo, if adev is not in IOMMU isolation mode, multiple GPUs
> use same system memory page dma mapping address, they can share the
> original mem->bo in attachment to reduce dma address array memory usage.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b8490789eef4..03807ed1f6e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -708,10 +708,14 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
>   			 va + bo_size, vm);
>   
> -		if (adev == bo_adev || (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
> -					amdgpu_xgmi_same_hive(adev, bo_adev))) {
> -			/* Mappings on the local GPU and VRAM mappings in the
> -			 * local hive share the original BO
> +		if (adev == bo_adev ||
> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
> +		     !adev->iommu_isolation) ||
> +		    (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
> +		     amdgpu_xgmi_same_hive(adev, bo_adev))) {

For the sake of readability I'd ignore the 80-column rule here (which 
isn't a hard rule any more). It could apply in the same way to GTT. This 
would be clearer:

+		if (adev == bo_adev ||
+		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
+		    (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {

Regards,
   Felix


> +			/* Mappings on the local GPU, or VRAM mappings in the
> +			 * local hive, or userptr mapping IOMMU is not isolation
> +			 * mode share the original BO
>   			 */
>   			attachment[i]->type = KFD_MEM_ATT_SHARED;
>   			bo[i] = mem->bo;
