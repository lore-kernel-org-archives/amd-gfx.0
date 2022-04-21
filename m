Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52552C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 10:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCCC10EAB4;
	Thu, 21 Apr 2022 10:03:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B117110EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 10:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYVNZOG68hmVXEKI5mA0apibTkK/14Mtz99h3b6SlXcqxkTiX/4PVQSoBvJr2C1xmQXl5I0oiXt3GROotb3bY3Cxi97zOY25DIPNZMx8pN1Kok9CNzD0E9cKMGilNWNrtAHu8BVyPNRDJr1vIkJ2D6Rux8pG0uvUIiASw9QhKQOYRWgsLz/qE0tk5Hv/RMoX3fmspFSy/8aNeBknbDM16dehi9yPpIrbP/VYKNs6md4MdIPdbyV09ZcQaudH2sTfVWLSQNDdOAb4wN6TGitTLMPjft9zpBOUpK0Z+cQkEOoHth+sEG51EzC5STPaNta/38dLJ51JTCqvaz/H94opmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enh3qNmJjfrCG4Ty8kfmTUTWiG8izdntNWkXfpBWmws=;
 b=QBCgcTIhqelmftV/AutiS5QgKhPEOCPF1Ca7jcp4ToZ2MGSs2ngoruT+N9ZgFgnrulQaPVlT5pMg4PYF3WX4R0AMDLtzkaqUYkbcHIRFUqMhOYoxCVaewnNvMW8Q99Di7HA/ds0rNc/WXKsyHDqlOG7GMAcfM2q3mkfsajztHSpRKFto/oOXNhM01gACGondx342JyOw6IMObLb+BfM4fBTtDOG6r7SV5TJaAx6dG91iAFWmMbNq0jZU1L4KYu8jWU2V15kMMq6nj6yt/3kmhTkhUpNLVmZjjsPi3HXvUoKiPBSZmaJ/HQW8+k/otdNbTfdoPuL6kctgfMtjrJITbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enh3qNmJjfrCG4Ty8kfmTUTWiG8izdntNWkXfpBWmws=;
 b=U7XfavGRmN6/0CUYAcbo5zrvIYawf8blB6+eiCgNxVnwbG9k8lUDTQ9+h4dn6Rwn95D1doIv0wRG9vFfCFDc/QIGGCCQXS4iBhgeQM6reBaxqqKLdj8Xs6OiLcuebSdcHERbhj9AYyWxNE+Bi++gmjGaYtm67NbT0Sglp+NSg38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 10:03:32 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 10:03:32 +0000
Message-ID: <17ab42d0-2629-21ae-0bdc-ddbc50acf6f6@amd.com>
Date: Thu, 21 Apr 2022 15:33:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Content-Language: en-US
To: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220420111357.9488-1-candice.li@amd.com>
 <20220420111357.9488-2-candice.li@amd.com>
 <a48beb99-5843-b457-9382-dd46d7b50ac5@amd.com>
 <CY4PR12MB149687204F4D9F1E7DEDEE3D91F49@CY4PR12MB1496.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY4PR12MB149687204F4D9F1E7DEDEE3D91F49@CY4PR12MB1496.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f61a2f-ef37-4a20-21b5-08da237e30de
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5673B023C397C0535462E4A597F49@SJ0PR12MB5673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcf8c+/+voTJoOgS2gUoksSRRNwW1TnQE3SUgR7AF8A/ziqXHc0ebjJ1ewOr7M7AWLkEmg2GbP1Pr8r+WBVaJcxJZNJTar/X5h3uzzDACMyodyLKhjCUiElIvBWqa4PyyJwd0y2F6om4CacjT3nPCBXHHMe/QmTIZOn+czd6mX4O8Te9zBDHbwxcK8p3WGzDJTrABnEv2wGp0Da+uzW/g2ZSQmRBEXwImuMibMhT2OyAuNHKa1SWeZb0WMDwxReaKbh29Rdltb7jdpaS/Gg2k0OP5bWRWuie8kC3prs0GtTVO8kYXv6uZCg2xO526CtOOEgYrZ7z/tt/i/14w/vZVB9ahoz9McksrsvDDHBiTb9JkDdB7Enrv8bBUusYPBPqU3i4U+891TMcTPsgp9CmyAJAyn86Ttiy1CzL1PqDBly3sS/pqEaT78t9AFtVH5zAk1da6mvJjRpyjI9fzPvebDbxUZEilSv12zIPsI7yvc6Qf/WFUqn6XXMVeuga0ubZJEQmbEcDkElV2cr8cAUcRbS2KeXBJKarhUjEs1WrkDU9ZJQ3S5+qzKaaCqUCDE3rzgNqgcT+rhGsUSbRgyQrU95s8gJ27nsDLjuodtlZcteUMZtnzyocIEpzq42JC3x3k8EMlP/xzexJM7hkI+EkaIYwpzANa0RV9ktky8MVPXbZRm0gyUnd5PoLmJjrEBloBUZXDqlpKu1en2LLoe/c7OT6XmETarRG25iQLiJKlU9IMCLyAnrOLMCcpaWe7AgTmYluobPm5BbOm8SmDUSokg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(8936002)(110136005)(6486002)(316002)(30864003)(186003)(83380400001)(5660300002)(8676002)(38100700002)(6506007)(53546011)(86362001)(26005)(66556008)(2616005)(508600001)(4326008)(31696002)(36756003)(6666004)(66946007)(2906002)(66476007)(6512007)(461764006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzc0dmVMSXJ5VlRMYUJ1RDZIb0p2cFc4bkNjaGtyemhoQVcyeFVmVTVueFlQ?=
 =?utf-8?B?UmNMSmhPR2dVb1hydmNhMGQrWDQ2UDV3SHZzVWRLMUhKSDdqZWtEc3V5YUdr?=
 =?utf-8?B?ZVB5aVhtbzlxOXU3dldLMHpmNkdhNG5yekEyTFRTSTE4eWFBSWFHaWxzUFdV?=
 =?utf-8?B?VmpsbUp3a3BQbkdEd1JKTVl1clNYYzlNbVlmUUcxdDREMVNyVmM1QVRyZ0xF?=
 =?utf-8?B?YlJGdzBXbjRHaDVlNXQ4SDU1V1Z4cEVrWUZZSEwzMlZSVG9EZnBkN3NPT2FZ?=
 =?utf-8?B?eUxmaTBZdTRaRlF2UXF2THFFbXJxRFJxM2hJcTl1SVNiNVRCNXA2dW5GSmFG?=
 =?utf-8?B?cVZhcWluWHE3QVBDTlZIcnIwenhSRmVGczJud1dMQm1NemZ6UzFOVDZoREZX?=
 =?utf-8?B?Z0RXMGdWVE50TkFQWEkvUU4yUStZV0hvSllhVnB6YUpBbUxtVmR2dllXMGZS?=
 =?utf-8?B?dTVoeTQvWUFMS3FqbE1sUmwwYVFERmJGbjlGS3I4bWZ5Z3VGY241MWNGWUZs?=
 =?utf-8?B?R2dLSzFjeXJwaWw2VTA3VTJkRGlodzV6WHpBUFo4c2xEcTZGaXo2U1dhcmpY?=
 =?utf-8?B?QTl2SVJsQnBtWThZVkJwT2tJQllCTnljY2pZUkUzYmFKWHdLcDR3UDFIV29P?=
 =?utf-8?B?cVdWUXhmcDNJRzdmOEFIRkVPVkE2VlAwM3BqMFpzT2dFUCt3OTBxQU81RWs3?=
 =?utf-8?B?OEgvTlBrM3pBODJpWG1kc2pKSHoyTzBndUk0dms1Y3FiRFhwL0dPT3hZU2g3?=
 =?utf-8?B?NDd0anFpVWdrVHJiNUR0NExMR3gwWmVneHhTV3Fka3NuQ0RKbHE5cm43SklS?=
 =?utf-8?B?bnNuTFhUelVpTzBhSVV0TzlwNVNDT2h4ZDk4T01XY2xuQWdrR3h1SG5uVCtB?=
 =?utf-8?B?aldCT2FRQ0t0UnpKdml6d0dJMTU0Tmx0Zk5jZ1B0MU84elhmNmlQSVAzV0I3?=
 =?utf-8?B?VkVjWllQUlFPUzl1WDhlWXAvemVyTUJDMllMemc5R2dRdGpVNXU1S3huQ3dM?=
 =?utf-8?B?ZktVd2kxeUxIaTZ5QzAzUFJ5a1Eza2hPYjF2Z1FSYm1sUVhOREpBS0MxK21H?=
 =?utf-8?B?KzZJTEUydVFBb1lRZlVvZVhpdlZJeGVCR1hFZWNPV3FSeG1MMWdkeW1zSG5B?=
 =?utf-8?B?N25KSi9OMkIxSi9wUDhqTGhjdjhaRjExNWFFU0gzWlJRdWRsL2dnaGRybmk3?=
 =?utf-8?B?cWtBRTdjVERxa0ZxYTFvODY4UGE3RkE1ZE1YaVI2OXk3U2RaQlF6SnZxSmI5?=
 =?utf-8?B?eVBSSm1hZ3BTcWNNMzlQM2RaUE9LdkZya28zOEtCS0twYy9Eb0lIY0hYTlZP?=
 =?utf-8?B?WmNLdkJPcitIbVlscVNIVjBZb1lXVWhrSWtyZmRzbmIvZi90RlhzVXdiYmRt?=
 =?utf-8?B?cHZCcHRhajU4ejc1cWFGalduM3kvalZyejBpMmsrYjZuNUhkRkFDKy8wbHVh?=
 =?utf-8?B?dS9sUk54a0NrRUJ1OWQ3TWVRb2tuZWRsWmNqNWhQRTBzVEhlbExuczhyTG9K?=
 =?utf-8?B?UWFKNnVqTDY1WXdxVS9oc3k3aGNIeEpYemRlYUc4WXBvN0k1c3BXWDY3TmRB?=
 =?utf-8?B?aDhQRFRtTXBEQjNQMlBJaE5kSldZVXBxZ1NCa3U5a042QWdoelNtejNIV1A5?=
 =?utf-8?B?WHRGWmRWQit4T1pPaFdxdGJKVEdNSXEwQkdoZE82c2pReUZ6cmxvbFVaUW5C?=
 =?utf-8?B?NkplMlkvd0xxYkNiRlRGVnBzNFR6aWVzbGp1SEJRSWcyMk1ZWjJJaENzMm9w?=
 =?utf-8?B?U29GbmM4Y3VIQ1puRFgzbGZpaVJXT25keEFNRytMaDk2a3R4S0t1RmRlZHJl?=
 =?utf-8?B?SXhSUEpyampMWE1qb2NlRjBBelZ3Q2Z2Rkd1eURoSERvaGtLc25PNjJGK2VS?=
 =?utf-8?B?VDhIVjhZZVZmTGNDNWVmQkk3ai9XejF4N0RFZ0dtdkdkdlVYNmJVS3VCTmkr?=
 =?utf-8?B?b3VIdjRGQ05uYSsreElJUmEyaS8wNkFnTThpc2dBanJhQ3cyYTdUOWdaWUxI?=
 =?utf-8?B?cDZjUlF6dTFzNXAyYTg4WG80RnJoWHdhV2EzUk1FbXE1TXlkdFZXR3RGaVBt?=
 =?utf-8?B?SHNudnNVc1JjZ1ROdVdzR05Yb2RsbGluQmVRdlp1aG1qZHpRVmozVng5M3d3?=
 =?utf-8?B?Zjl4b1RGV2pWSHlhTlpjSzkxWU42Tnk5YjBwbmpXQUtYai9PeUdMNUttKzlv?=
 =?utf-8?B?MGVkdU50UGlVQ1M0UFFjRGRwV0R5bWtubVRBSE01VnhOajU2VVFpL2g1a2ND?=
 =?utf-8?B?MUtISGZnZ3BsTGtqejh4S29ad3EvcEgrTHJpLzFaWjVFazYxUDBKVWJ3bmhN?=
 =?utf-8?B?Z3hWUExRYVdEM0x5SjYyRGxGMkVkOUJpZDB3OUVMeE1ENndyS1o0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f61a2f-ef37-4a20-21b5-08da237e30de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 10:03:32.2811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXUyghYRQcpKGU9HdPLAlHB+8AwuS/vUKc21I3+nyk1+Y6yivT7jISsS7APgMGqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/21/2022 3:28 PM, Li, Candice wrote:
> [Public]
> 
> 
> 
> 
> 
> Thanks,
> Candice
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, April 21, 2022 5:23 PM
> To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>
> Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
> 
> 
> 
> On 4/20/2022 4:43 PM, Candice Li wrote:
>> v1:
>> Add debugfs support to load/unload/invoke TA in runtime.
>>
>> v2:
>> 1. Update some variables to static.
>> 2. Use PAGE_ALIGN to calculate shared buf size directly.
>> 3. Remove fp check.
>> 4. Update debugfs from read to write.
>>
>> Signed-off-by: John Clements <john.clements@amd.com>
>> Signed-off-by: Candice Li <candice.li@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308 ++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
>>    4 files changed, 341 insertions(+), 1 deletion(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 7d7af43a258f83..b525f9be9326f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>    	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>>    	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>    	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>> -	amdgpu_eeprom.o amdgpu_mca.o
>> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o
>>    
>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 13e4d8f9b87449..eedb12f6b8a32d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -38,6 +38,7 @@
>>    #include "amdgpu_umr.h"
>>    
>>    #include "amdgpu_reset.h"
>> +#include "amdgpu_psp_ta.h"
>>    
>>    #if defined(CONFIG_DEBUG_FS)
>>    
>> @@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>    		DRM_ERROR("registering register debugfs failed (%d).\n", r);
>>    
>>    	amdgpu_debugfs_firmware_init(adev);
>> +	amdgpu_ta_if_debugfs_init(adev);
>>    
>>    #if defined(CONFIG_DRM_AMD_DC)
>>    	if (amdgpu_device_has_dc_support(adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>> new file mode 100644
>> index 00000000000000..247a476e63544c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>> @@ -0,0 +1,308 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_psp_ta.h"
>> +
>> +static const char *TA_IF_FS_NAME = "ta_if";
>> +
>> +struct dentry *dir;
>> +static struct dentry *ta_load_debugfs_dentry;
>> +static struct dentry *ta_unload_debugfs_dentry;
>> +static struct dentry *ta_invoke_debugfs_dentry;
>> +
>> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
>> +					    size_t len, loff_t *off);
>> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
>> +					    size_t len, loff_t *off);
>> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
>> +					    size_t len, loff_t *off);
>> +
>> +
>> +static uint32_t get_bin_version(const uint8_t *bin)
>> +{
>> +	const struct common_firmware_header *hdr =
>> +			     (const struct common_firmware_header *)bin;
>> +
>> +	return hdr->ucode_version;
>> +}
>> +
>> +static void prep_ta_mem_context(struct psp_context *psp,
>> +					     struct ta_context *context,
>> +					     uint8_t *shared_buf,
>> +					     uint32_t shared_buf_len)
>> +{
>> +	context->mem_context.shared_mem_size = PAGE_ALIGN(shared_buf_len);
>> +	psp_ta_init_shared_buf(psp, &context->mem_context);
>> +
>> +	memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_buf_len);
>> +}
>> +
>> +static bool is_ta_type_valid(enum ta_type_id ta_type)
>> +{
>> +	bool ret = false;
>> +
>> +	switch (ta_type) {
>> +	case TA_TYPE_RAS:
>> +		ret = true;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations ta_load_debugfs_fops = {
>> +	.write   = ta_if_load_debugfs_write,
>> +	.llseek = default_llseek,
>> +	.owner  = THIS_MODULE
>> +};
>> +
>> +static const struct file_operations ta_unload_debugfs_fops = {
>> +	.write   = ta_if_unload_debugfs_write,
>> +	.llseek = default_llseek,
>> +	.owner  = THIS_MODULE
>> +};
>> +
>> +static const struct file_operations ta_invoke_debugfs_fops = {
>> +	.write   = ta_if_invoke_debugfs_write,
>> +	.llseek = default_llseek,
>> +	.owner  = THIS_MODULE
>> +};
>> +
>> +
>> +/**
>> + * DOC: AMDGPU TA debugfs interfaces
>> + *
>> + * Three debugfs interfaces can be opened by a program to
>> + * load/invoke/unload TA,
>> + *
>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
>> + * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
>> + *
>> + * How to use the interfaces in a program?
>> + *
>> + * A program needs to provide transmit buffer to the interfaces
>> + * and will receive buffer from the interfaces below,
>> + *
>> + * - For TA load debugfs interface:
>> + *   Transmit buffer:
>> + *    - TA type (4bytes)
>> + *    - TA bin length (4bytes)
>> + *    - TA bin
>> + *   Receive buffer:
>> + *    - TA ID (4bytes)
>> + *
>> + * - For TA invoke debugfs interface:
>> + *   Transmit buffer:
>> + *    - TA ID (4bytes)
>> + *    - TA CMD ID (4bytes)
>> + *    - TA shard buf length (4bytes)
>> + *    - TA shared buf
>> + *   Receive buffer:
>> + *    - TA shared buf
>> + *
>> + * - For TA unload debugfs interface:
>> + *   Transmit buffer:
>> + *    - TA ID (4bytes)
>> + */
>> +
>> +static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>> +{
>> +	uint32_t ta_type    = 0;
>> +	uint32_t ta_bin_len = 0;
>> +	uint8_t  *ta_bin    = NULL;
>> +	uint32_t copy_pos   = 0;
>> +	int      ret        = 0;
>> +
>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>> +	struct psp_context   *psp    = &adev->psp;
>> +	struct ta_context    context = {0};
>> +
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	ret = copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uint32_t));
>> +	if (ret || (!is_ta_type_valid(ta_type)))
>> +		return -EINVAL;
>> +
>> +	copy_pos += sizeof(uint32_t);
>> +
>> +	ret = copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(uint32_t));
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	copy_pos += sizeof(uint32_t);
>> +
>> +	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
>> +	if (!ta_bin)
>> +		ret = -ENOMEM;
>> +	ret = copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
>> +	if (ret)
>> +		goto err_free_bin;
>> +
>> +	ret = psp_ras_terminate(psp);
>> +	if (ret) {
>> +		dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
>> +		goto err_free_bin;
>> +	}
>> +
>> +	context.ta_type             = ta_type;
>> +	context.ta_load_type        = GFX_CMD_ID_LOAD_TA;
>> +	context.bin_desc.fw_version = get_bin_version(ta_bin);
>> +	context.bin_desc.size_bytes = ta_bin_len;
>> +	context.bin_desc.start_addr = ta_bin;
>> +
>> +	ret = psp_ta_load(psp, &context);
>> +
>> +	if (ret || context.resp_status) {
>> +		dev_err(adev->dev, "TA load via debugfs failed (%d) status %d\n",
>> +			 ret, context.resp_status);
>> +		goto err_free_bin;
>> +	}
>> +
>> +	context.initialized = true;
>> +	ret = copy_to_user((char *)buf, (void *)&context.session_id, sizeof(uint32_t));
>> +
>> +err_free_bin:
>> +	kfree(ta_bin);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>> +{
>> +	uint32_t ta_id  = 0;
>> +	int      ret    = 0;
>> +
>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>> +	struct psp_context   *psp    = &adev->psp;
>> +	struct ta_context    context = {0};
>> +
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	ret = copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	context.session_id = ta_id;
>> +
>> +	ret = psp_ta_unload(psp, &context);
>> +	if (!ret)
>> +		context.initialized = false;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
>> +{
>> +	uint32_t ta_id          = 0;
>> +	uint32_t cmd_id         = 0;
>> +	uint32_t shared_buf_len = 0;
>> +	uint8_t	 *shared_buf    = NULL;
>> +	uint32_t copy_pos       = 0;
>> +	int      ret            = 0;
>> +
>> +	struct amdgpu_device *adev   = (struct amdgpu_device *)file_inode(fp)->i_private;
>> +	struct psp_context   *psp    = &adev->psp;
>> +	struct ta_context    context = {0};
>> +
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	ret = copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint32_t));
>> +	if (ret)
>> +		return -EINVAL;
>> +	copy_pos += sizeof(uint32_t);
>> +
>> +	ret = copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint32_t));
>> +	if (ret)
>> +		return -EINVAL;
>> +	copy_pos += sizeof(uint32_t);
>> +
>> +	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
>> +	if (ret)
>> +		return -EINVAL;
>> +	copy_pos += sizeof(uint32_t);
>> +
>> +	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
>> +	if (!shared_buf)
>> +		ret = -ENOMEM;
>> +	ret = copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len);
>> +	if (ret)
>> +		goto err_free_shared_buf;
>> +
>> +	context.session_id = ta_id;
>> +
>> +	prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
>> +
>> +	ret = psp_ta_invoke_indirect(psp, cmd_id, &context);
>> +
>> +	if (ret || context.resp_status) {
>> +		dev_err(adev->dev, "TA invoke via debugfs failed (%d) status %d\n",
>> +			 ret, context.resp_status);
>> +		goto err_free_ta_shared_buf;
>> +	}
>> +
>> +	ret = copy_to_user((char *)buf, context.mem_context.shared_buf, shared_buf_len);
>> +
>> +err_free_ta_shared_buf:
>> +	psp_ta_free_shared_buf(&context.mem_context);
>> +
>> +err_free_shared_buf:
>> +	kfree(shared_buf);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
>> +{
>> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
>> +
>> +	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
>> +
>> +	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
>> +						     &ta_load_debugfs_fops);
>> +
>> +	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
>> +						     adev, &ta_unload_debugfs_fops);
>> +
>> +	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
>> +						     adev, &ta_invoke_debugfs_fops);
> 
> This uses global variables, is this tested on a system with multiple GPUs?
> 
> Thanks,
> Lijo
> 
> [Candice] Yes, it has been tested on mGPU system and works.
> 

Did you also cover amdgpu_ta_if_debugfs_remove() during your tests? I'm 
wondering how it removes the directory of all devices as by above logic 
'dir' will always point to the entry of the last probed device.

Thanks,
Lijo

>> +	return dir;
>> +}
>> +
>> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
>> +{
>> +#if defined(CONFIG_DEBUG_FS)
>> +	dir = amdgpu_ta_if_debugfs_create(adev);
>> +#endif
>> +}
>> +
>> +void amdgpu_ta_if_debugfs_remove(void)
>> +{
>> +	debugfs_remove_recursive(dir);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>> new file mode 100644
>> index 00000000000000..883f89d57616d0
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_PSP_TA_H__
>> +#define __AMDGPU_PSP_TA_H__
>> +
>> +void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
>> +void amdgpu_ta_if_debugfs_remove(void);
>> +
>> +#endif
>>
