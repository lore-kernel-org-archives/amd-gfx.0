Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 20:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FEC10E4F4;
	Wed, 16 Nov 2022 20:49:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C034710E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 20:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2nCJDevynZTp57TGLgjOz1HUfd/EdOE0X5ox2gYlftGBh/InaDto1OPYD4/dnb6Y+lHLwIb1qlEDfsfcNhtF7IanJGdHP8Ek+GaYh0OrWbgf9TVX4wTWYM2twHCOVXjMkz9ueYX4fKm8Nqlam0yoUlqVA+TVqaMQrL2/qQ/KpnEN9DfCPfr0AsUHrbNTth5AytqRocRab/b/AACBO3R9UkvzkGLHf+YfmNDFXI1dCPdWgtgIzZksbjJUK6kEo6uLQx/bFdS0eZzofAE1X5WvnwZ8UHIoqc05b0/T+hlFPdUd2Gx7Sgw2fogeu5k1EanE22GF3r7df45EAtxJoBGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kBna20kqh24kLsazrQNU5NExWgIXSEOpTxmN9CeY84=;
 b=YZwUtKq4msZRa5GeW8Zszgc5vGvAG0NwFwdOmezJUCL3XATlH3d5j38NyNFqst4XQj1Tz+fe08kHtRh1PUhjOmAlhV5edpI1W7XsIgOQsoY/ypzJa6q7KNucmpi9Rj0IMrloATXbVvtfvs5WqpXabk3h3AjCEuehgJj3Z5uaU8uryWos5urJFi57PDmzFr2MkudnoPcjxVPrerkmecVrBkqVExkeSOG+R5448D0S6NCWeyXmeQoy4FK/nyIo6WC4sLXRr1OKuMYOM188baPqGy6VKX+DDFMIlMoxb4RDma9EuzkvF0R6wPds1TS/Xl/ZyW5Fnkn1fLWDJw2l6ypkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kBna20kqh24kLsazrQNU5NExWgIXSEOpTxmN9CeY84=;
 b=P2IRaHutGzLePSoq/0PRzMJVT3cmwXNt7lX+tTYKZ6+GpM0POZqBhvAp0Se9cPzKEbsHPsosBIXUwpp8/OXts7DzoS+z4BGYbQGh9ynVqSZV7OFkkm3mkZl9Tly1XufVp1/HgJlccGLJ/FeHfRoI3FGQDE1a9M9ryPgpubn1j6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 20:49:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 20:49:21 +0000
Content-Type: multipart/mixed; boundary="------------2Cp9HPAUBEDGUVh1HToGRqWm"
Message-ID: <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
Date: Wed, 16 Nov 2022 15:49:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Release the topology_lock in error case
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221116080415.593223-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221116080415.593223-1-Jun.Ma2@amd.com>
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3088c9-7371-4599-d587-08dac81409cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05ZPIMvr5zlX7LwS9YsgwdYyolB88I99MkBv3p/wyXOc76GiJI+FZJnXGUN/rwdneqPvyKvg9NTTPMI1yTwv9IQLD79CEFQ1spfelJVd0BxY+H8kJthzMBcX8T3C2Cn8RRQRIo60XqB8kTN4mBarE9CO5CnNp5c7NiahIC/4HisnrcFgzMZYigw3kIxPZraIZcUSE2JofO2Cj/AlPXeyVsD3AKEwIqCRQEagubmRVgHnXeMUlr7vlkrIQYwYLExkwLXMMBPQSF/W/dn18naRXro/66jASxnmEhGS0KhBsPflFkvdH7MEyCtmmwzV4VgUQiCck0xxPcVX2qfnnVYztmsEjxwPNTxuF0QcC67cStiNJw+rmH27RwrJFeSJ6RRRnzVjZhRBC4+L73VWloosg1mhFbCJEJhD072sfL0H3W6NBpVGHgXglekg5SBOZwylIbYo6lUDUDBCq6JHDlLxsPJZRiDNBkiK50584q251CV9MDukw2vHEmMJUa8+/xzb87s1jBLoGw07GGBnrxSnizOu0VnQlk1iFYOP3yc9pg7nNBRpuqsQ6yX1YCGcnKYoy8PNRJj0n46T5o3+2x75YRWNUFtzX8LG4fJcDfM6fWJ/3rKsxxM8ploAd33IZrjiPHiHExwRantW5UH5HgsIrYSkBkSxnO+qFrzCl2x2/scykFri/A2EIhp9VqIAx5odTtH5o/+uSaq4P7Ay+zAakunfjGI6jmcGTB2ZYIGvK69jAgOUjkwXh6RzWUjCliY5QCgdi1fd7/n12NZsW+jh0qhFlM1jwfO5J0zOrgTO32k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(41300700001)(31696002)(31686004)(478600001)(2616005)(4326008)(4001150100001)(2906002)(66946007)(66476007)(66556008)(36756003)(6486002)(8676002)(6666004)(186003)(44832011)(83380400001)(5660300002)(316002)(6506007)(86362001)(33964004)(8936002)(6512007)(26005)(235185007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRXRTNNQXBUa1hTaEsvR1plU3ZnZkZsUmRIOXVFNzhLZHYrenlPeHRYUE5P?=
 =?utf-8?B?eUthNEtBS0dHc1VibnduNmhCeUVCOHIzYkFLRHg0TEFsRklxMnRkV0pJaHl3?=
 =?utf-8?B?cjZ3c0x6QkVuS0NHNzJDMzNkcEVSRzY3bkl4VzhxYkxsU2UvaXc1Z3YrU1pG?=
 =?utf-8?B?NGtqVDNoelhVdmZwT1dabjREY1d3M2UrTThTZjVDdlhsRHY2cThXcGsyVlhR?=
 =?utf-8?B?cFF6RG1BWEVBbVIvN202MjIrMEZaSDRxVDR2UkphWkUxbVlhMmdRKzUxcGtx?=
 =?utf-8?B?YS9pY2ZWZ2N5cGVwNHVlYWNQWkozb1R2eE5ZNzNtQkN3bGpBbmp4dG9aY3ZK?=
 =?utf-8?B?Nk02R2JQeElhdG9LalJHWEtLMXRwK3BNOGZnSGNPZGFqRXVuNGFYUDVTT0VO?=
 =?utf-8?B?QVZRdmk2RVlXbmNtL01hVldTU0k0TlM5MlVSTVkrc2ZmUkVWM3lDRjF4RkZ6?=
 =?utf-8?B?Z3pMMFFpVHdudDMramtYZkgrOUtEQ3JlSkxQTTBNV3J2Vm4wUFo2L2FwTzE0?=
 =?utf-8?B?OXdTMjZMc1E5YzB4NGdncGk0a1NjQzZqcDBSS1BkanBlUklCb2VWRGRHaDFV?=
 =?utf-8?B?M3lCMlZsYXJyQnRVZnA1YThXWlFiT05YSXdVU1hrSTRmNVRub1k4Z21pdkp2?=
 =?utf-8?B?YVd2V3VxeS9sN0tTOTQ5UFJocmxKc3U2amI5bUNmUDA2QmQ1dU1xajNWc2ZU?=
 =?utf-8?B?SG1DcFJ0VG5Vd2s2ZnlOU3JCQTc2WE5mMkVGZ1E0bWJMWXBORVZpRW5acml2?=
 =?utf-8?B?VTYrRmdlYkdFYlgvK0RUUjE4K3U0RnhnOW0rdjRvcjNIUklwckpmQzhFM0NO?=
 =?utf-8?B?Z2tBa2oxVmRHcWJCZVRUSzJCakRQYjF2T3NGWXZ3SWNkOVR4WHZFN3dKZVp6?=
 =?utf-8?B?QlJoc1YyT1F1NHdnRVM3NEExMVBsSC9YMTI4Z1grYzU5OTJwNGlUTlVPdklK?=
 =?utf-8?B?Q09YakRJVEN1TCtsQW43eUlmQjdNeHF0YUJGOUM5cUYvZUpTNzdReFpmQysw?=
 =?utf-8?B?WkhLVFd2d0t5UURNWW1QN0lnemZSRU9jS1hNRDhINFZ5K1VYSWdETFFTc1U4?=
 =?utf-8?B?bTBiOGt4d1BIVEwvYy9Wek40L1BzS2ZXaDBDak9SNkZjUEs4SEZpNkNyWDAy?=
 =?utf-8?B?cDNyelN2VzVKb2o1L081cGt3MDZtdGRyVm4wZGhlaWErTG9kM3FSSXk2Rkxx?=
 =?utf-8?B?RDdnR05oWWhRVUVBeHJPZ1NKVjdMWmk4WSs4dFQ5TjlDaitRcXB4d0xUcnBZ?=
 =?utf-8?B?Q2R1d1c5NWRwYlNlQ3V0S0d4TXEvdmRRczEzdGt4eXdqMXQ3MjBRZnVSakgy?=
 =?utf-8?B?dnd4VmUyM3hWREJTSTJlUmU3dThGbmFQQzhidHRFcXRoU1VBK1dhb1pPQUM0?=
 =?utf-8?B?NU1OTFExOWJ2Y25seHFLeE9hUVJjKzkwdDh5V3NiZ1VkTEFxSFZwNDQ1bng0?=
 =?utf-8?B?aHhEb2FVMFNaZTIxOFo0OXJKK2luMmNTUFlXaHYyM1dzeUhLcm9tQ1RNb25m?=
 =?utf-8?B?emg4eHl5d1ZITDYreFBqWTFGbThabEorTENZY1hIdVFhUWNaeE9LOWlMNGg3?=
 =?utf-8?B?MWRBeDNQVTl0NFNLL05ISW9IVUZJOUkwUlpCdmVXS01qR0k2TzFva2RMUGNz?=
 =?utf-8?B?V0xKd3dhbml0cjNmcXN3OEM4dFhLVDZjbFZOWFZ2NDllOVAwWkRBSW01OXdu?=
 =?utf-8?B?WXNTYTZmVUFVOGFpUTRWZFNnRzJ4MnFuV1pKQVp4OXVCRmZTZmxTYVpadVps?=
 =?utf-8?B?eCtKWU9XN1BGSGlaalBjb01WQmk5VDhzSXNDeGVtb0lwT2VTdU12R0dtLzBt?=
 =?utf-8?B?K21rWnd0RFArZEFUenhuekFWZmEzek8ySnRLK1pzbUZ5OWdHU1hLSXoydXJ6?=
 =?utf-8?B?ZWdrb3BieVFLTXZwYWhyb3d4ZWVBUkdYcVZFWVJHNW5CY1lzVnhiekl3UUE1?=
 =?utf-8?B?cllWYWdOM0xFb094dDdpUnBJUGNKRlVWd2N5b3NJZ3dUTjE5ZWZnUEpqeFdV?=
 =?utf-8?B?SFV4UW96ZndUNTBuSk5jaUZCOFJYcmdHeVJoREd3Q2VuQWl4cWpsbGR5VXYy?=
 =?utf-8?B?aFo3MjlnclVHTnJvbFU5TlZKWW9uWUZORzFHU040L2xTNVBsc1ZXRjhuUlVT?=
 =?utf-8?Q?crqRDJvOI13Hqd8QhQPmrQxMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3088c9-7371-4599-d587-08dac81409cc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:49:21.7228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiYs1L4iJazleceiEayf81YEzvUTV+04/ImK7kRPZ7vSAN060dfDCIx1cJgqZO6A0svMV856DjdqnUe7RWLMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>, error27@gmail.com,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------2Cp9HPAUBEDGUVh1HToGRqWm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 2022-11-16 um 03:04 schrieb Ma Jun:
> Release the topology_lock in error case
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
Dan, did you change your email address, is this one correct?

Ma Jun, thanks for looking into this. Some of this problem predates your 
patch that was flagged by Dan. I would prefer a more consistent and 
robust handling of these error cases. I think everything inside the 
topology lock could be moved into another function to simplify the error 
handling. I'm attaching a completely untested patch to illustrate the idea.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index ef9c6fdfb88d..5ea737337658 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1841,6 +1841,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
>   			topology_crat_proximity_domain--;
> +			up_write(&topology_lock);
>   			return res;
>   		}
>   
> @@ -1851,6 +1852,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>   			       gpu_id);
>   			topology_crat_proximity_domain--;
> +			up_write(&topology_lock);
>   			goto err;
>   		}
>   
> @@ -1860,6 +1862,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		dev = kfd_assign_gpu(gpu);
>   		if (WARN_ON(!dev)) {
>   			res = -ENODEV;
> +			up_write(&topology_lock);
>   			goto err;
>   		}
>   
--------------2Cp9HPAUBEDGUVh1HToGRqWm
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amdkfd-Release-the-topology_lock-in-error-case.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amdkfd-Release-the-topology_lock-in-error-case.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSBjZWI3OTk3MmNkZDQ5MGRlMTgxYTY4OTU4MzZlNDBiZjRlOTNjNjMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDE2IE5vdiAyMDIyIDE1OjM4OjQ0IC0wNTAwClN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZGtmZDogUmVsZWFzZSB0aGUgdG9wb2xvZ3lfbG9jayBpbiBlcnJvciBjYXNlCgpN
b3ZlIHRoZSB0b3BvbG9neS1sb2NrZWQgcGFydCBvZiBrZmRfdG9wb2xvZ3lfYWRkX2RldmljZSBp
bnRvIGEgc2VwYXJhdGUKZnVuY3Rpb24gdG8gc2ltbHBpZnkgZXJyb3IgaGFuZGxpbmcgYW5kIHJl
bGVhc2UgdGhlIHRvcG9sb2d5IGxvY2sKY29uc2lzdGVudGx5LgoKUmVwb3J0ZWQtYnk6IERhbiBD
YXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGlu
ZyA8ZmVsaXgua3VlaGxpbmdAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF90b3BvbG9neS5jIHwgMTA5ICsrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCmluZGV4IGVmOWM2ZmRmYjg4ZC4uYjU2YmVhYjcx
YzViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwpAQCAtMTgw
NSwxNiArMTgwNSw2NiBAQCBzdGF0aWMgdm9pZCBrZmRfZmlsbF9jYWNoZV9ub25fY3JhdF9pbmZv
KHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYsIHN0cnVjdAogCXByX2RlYnVnKCJBZGRl
ZCBbJWRdIEdQVSBjYWNoZSBlbnRyaWVzXG4iLCBudW1fb2ZfZW50cmllcyk7CiB9CiAKK3N0YXRp
YyBpbnQga2ZkX3RvcG9sb2d5X2FkZF9kZXZpY2VfbG9ja2VkKHN0cnVjdCBrZmRfZGV2ICpncHUs
IHVpbnQzMl90IGdwdV9pZCwKKwkJCQkJICBzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqKmRl
dikKK3sKKwlpbnQgcHJveGltaXR5X2RvbWFpbiA9ICsrdG9wb2xvZ3lfY3JhdF9wcm94aW1pdHlf
ZG9tYWluOworCXN0cnVjdCBsaXN0X2hlYWQgdGVtcF90b3BvbG9neV9kZXZpY2VfbGlzdDsKKwl2
b2lkICpjcmF0X2ltYWdlID0gTlVMTDsKKwlzaXplX3QgaW1hZ2Vfc2l6ZSA9IDA7CisJaW50IHJl
czsKKworCXJlcyA9IGtmZF9jcmVhdGVfY3JhdF9pbWFnZV92aXJ0dWFsKCZjcmF0X2ltYWdlLCAm
aW1hZ2Vfc2l6ZSwKKwkJCQkJICAgIENPTVBVVEVfVU5JVF9HUFUsIGdwdSwKKwkJCQkJICAgIHBy
b3hpbWl0eV9kb21haW4pOworCWlmIChyZXMpIHsKKwkJcHJfZXJyKCJFcnJvciBjcmVhdGluZyBW
Q1JBVCBmb3IgR1BVIChJRDogMHgleClcbiIsCisJCSAgICAgICBncHVfaWQpOworCQl0b3BvbG9n
eV9jcmF0X3Byb3hpbWl0eV9kb21haW4tLTsKKwkJcmV0dXJuIHJlczsKKwl9CisKKwlyZXMgPSBr
ZmRfcGFyc2VfY3JhdF90YWJsZShjcmF0X2ltYWdlLAorCQkJCSAgICZ0ZW1wX3RvcG9sb2d5X2Rl
dmljZV9saXN0LAorCQkJCSAgIHByb3hpbWl0eV9kb21haW4pOworCWlmIChyZXMpIHsKKwkJcHJf
ZXJyKCJFcnJvciBwYXJzaW5nIFZDUkFUIGZvciBHUFUgKElEOiAweCV4KVxuIiwKKwkJICAgICAg
IGdwdV9pZCk7CisJCXRvcG9sb2d5X2NyYXRfcHJveGltaXR5X2RvbWFpbi0tOworCQlyZXR1cm4g
cmVzOworCX0KKworCWtmZF90b3BvbG9neV91cGRhdGVfZGV2aWNlX2xpc3QoJnRlbXBfdG9wb2xv
Z3lfZGV2aWNlX2xpc3QsCisJCQkJCSZ0b3BvbG9neV9kZXZpY2VfbGlzdCk7CisKKwkqZGV2ID0g
a2ZkX2Fzc2lnbl9ncHUoZ3B1KTsKKwlpZiAoV0FSTl9PTighKmRldikpCisJCXJldHVybiAtRU5P
REVWOworCisJLyogRmlsbCB0aGUgY2FjaGUgYWZmaW5pdHkgaW5mb3JtYXRpb24gaGVyZSBmb3Ig
dGhlIEdQVXMKKwkgKiB1c2luZyBWQ1JBVAorCSAqLworCWtmZF9maWxsX2NhY2hlX25vbl9jcmF0
X2luZm8oKmRldiwgZ3B1KTsKKworCS8qIFVwZGF0ZSB0aGUgU1lTRlMgdHJlZSwgc2luY2Ugd2Ug
YWRkZWQgYW5vdGhlciB0b3BvbG9neQorCSAqIGRldmljZQorCSAqLworCXJlcyA9IGtmZF90b3Bv
bG9neV91cGRhdGVfc3lzZnMoKTsKKwlpZiAoIXJlcykKKwkJc3lzX3Byb3BzLmdlbmVyYXRpb25f
Y291bnQrKzsKKwllbHNlCisJCXByX2VycigiRmFpbGVkIHRvIHVwZGF0ZSBHUFUgKElEOiAweCV4
KSB0byBzeXNmcyB0b3BvbG9neS4gcmVzPSVkXG4iLAorCQkgICAgICAgZ3B1X2lkLCByZXMpOwor
CisJcmV0dXJuIHJlczsKK30KKwogaW50IGtmZF90b3BvbG9neV9hZGRfZGV2aWNlKHN0cnVjdCBr
ZmRfZGV2ICpncHUpCiB7CiAJdWludDMyX3QgZ3B1X2lkOwogCXN0cnVjdCBrZmRfdG9wb2xvZ3lf
ZGV2aWNlICpkZXY7CiAJc3RydWN0IGtmZF9jdV9pbmZvIGN1X2luZm87CiAJaW50IHJlcyA9IDA7
Ci0Jc3RydWN0IGxpc3RfaGVhZCB0ZW1wX3RvcG9sb2d5X2RldmljZV9saXN0OwotCXZvaWQgKmNy
YXRfaW1hZ2UgPSBOVUxMOwotCXNpemVfdCBpbWFnZV9zaXplID0gMDsKLQlpbnQgcHJveGltaXR5
X2RvbWFpbjsKIAlpbnQgaTsKIAljb25zdCBjaGFyICphc2ljX25hbWUgPSBhbWRncHVfYXNpY19u
YW1lW2dwdS0+YWRldi0+YXNpY190eXBlXTsKIApAQCAtMTgzMSw1NCArMTg4MSwxMSBAQCBpbnQg
a2ZkX3RvcG9sb2d5X2FkZF9kZXZpY2Uoc3RydWN0IGtmZF9kZXYgKmdwdSkKIAkgKi8KIAlkb3du
X3dyaXRlKCZ0b3BvbG9neV9sb2NrKTsKIAlkZXYgPSBrZmRfYXNzaWduX2dwdShncHUpOwotCWlm
ICghZGV2KSB7Ci0JCXByb3hpbWl0eV9kb21haW4gPSArK3RvcG9sb2d5X2NyYXRfcHJveGltaXR5
X2RvbWFpbjsKLQotCQlyZXMgPSBrZmRfY3JlYXRlX2NyYXRfaW1hZ2VfdmlydHVhbCgmY3JhdF9p
bWFnZSwgJmltYWdlX3NpemUsCi0JCQkJCQkgICAgQ09NUFVURV9VTklUX0dQVSwgZ3B1LAotCQkJ
CQkJICAgIHByb3hpbWl0eV9kb21haW4pOwotCQlpZiAocmVzKSB7Ci0JCQlwcl9lcnIoIkVycm9y
IGNyZWF0aW5nIFZDUkFUIGZvciBHUFUgKElEOiAweCV4KVxuIiwKLQkJCSAgICAgICBncHVfaWQp
OwotCQkJdG9wb2xvZ3lfY3JhdF9wcm94aW1pdHlfZG9tYWluLS07Ci0JCQlyZXR1cm4gcmVzOwot
CQl9Ci0KLQkJcmVzID0ga2ZkX3BhcnNlX2NyYXRfdGFibGUoY3JhdF9pbWFnZSwKLQkJCQkJICAg
JnRlbXBfdG9wb2xvZ3lfZGV2aWNlX2xpc3QsCi0JCQkJCSAgIHByb3hpbWl0eV9kb21haW4pOwot
CQlpZiAocmVzKSB7Ci0JCQlwcl9lcnIoIkVycm9yIHBhcnNpbmcgVkNSQVQgZm9yIEdQVSAoSUQ6
IDB4JXgpXG4iLAotCQkJICAgICAgIGdwdV9pZCk7Ci0JCQl0b3BvbG9neV9jcmF0X3Byb3hpbWl0
eV9kb21haW4tLTsKLQkJCWdvdG8gZXJyOwotCQl9Ci0KLQkJa2ZkX3RvcG9sb2d5X3VwZGF0ZV9k
ZXZpY2VfbGlzdCgmdGVtcF90b3BvbG9neV9kZXZpY2VfbGlzdCwKLQkJCSZ0b3BvbG9neV9kZXZp
Y2VfbGlzdCk7Ci0KLQkJZGV2ID0ga2ZkX2Fzc2lnbl9ncHUoZ3B1KTsKLQkJaWYgKFdBUk5fT04o
IWRldikpIHsKLQkJCXJlcyA9IC1FTk9ERVY7Ci0JCQlnb3RvIGVycjsKLQkJfQotCi0JCS8qIEZp
bGwgdGhlIGNhY2hlIGFmZmluaXR5IGluZm9ybWF0aW9uIGhlcmUgZm9yIHRoZSBHUFVzCi0JCSAq
IHVzaW5nIFZDUkFUCi0JCSAqLwotCQlrZmRfZmlsbF9jYWNoZV9ub25fY3JhdF9pbmZvKGRldiwg
Z3B1KTsKLQotCQkvKiBVcGRhdGUgdGhlIFNZU0ZTIHRyZWUsIHNpbmNlIHdlIGFkZGVkIGFub3Ro
ZXIgdG9wb2xvZ3kKLQkJICogZGV2aWNlCi0JCSAqLwotCQlyZXMgPSBrZmRfdG9wb2xvZ3lfdXBk
YXRlX3N5c2ZzKCk7Ci0JCWlmICghcmVzKQotCQkJc3lzX3Byb3BzLmdlbmVyYXRpb25fY291bnQr
KzsKLQkJZWxzZQotCQkJcHJfZXJyKCJGYWlsZWQgdG8gdXBkYXRlIEdQVSAoSUQ6IDB4JXgpIHRv
IHN5c2ZzIHRvcG9sb2d5LiByZXM9JWRcbiIsCi0JCQkJCQlncHVfaWQsIHJlcyk7Ci0JfQorCWlm
ICghZGV2KQorCQlyZXMgPSBrZmRfdG9wb2xvZ3lfYWRkX2RldmljZV9sb2NrZWQoZ3B1LCBncHVf
aWQsICZkZXYpOwogCXVwX3dyaXRlKCZ0b3BvbG9neV9sb2NrKTsKKwlpZiAocmVzKQorCQlnb3Rv
IGVycjsKIAogCWRldi0+Z3B1X2lkID0gZ3B1X2lkOwogCWdwdS0+aWQgPSBncHVfaWQ7Ci0tIAoy
LjM0LjEKCg==

--------------2Cp9HPAUBEDGUVh1HToGRqWm--
