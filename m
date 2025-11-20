Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E326CF8558
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 08:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19FA10E279;
	Thu, 20 Nov 2025 08:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4LpfOse";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727D910E279
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 08:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ocwn/BbrSXcU1ftz4GkLjFC7cri3vhz7lKV9jV7n/19Htz/RfkKToDVb5VvMSkR1fSd9ce34J/hksul8LOJwswJHH1qKe1UT3Fe3Y6HCrxnQ7DQRZHdClofjeZEoJOQlx1/NgvJqoULTflX9uq9OR0d+OzS/+bBAl7H/1xn6UPYbOxaCAgo839LwB82h4CsCynlI1TI2oLW6EQLZh3D7MMMWoY0xbPmWOAi/xl0WX4XOXhJLnZ0aJS2HWxbP4FzYyQJ+eR46/cNCK0Z6hq2moSMqPfR36o3ct85ATsJYX4cDZgGwLusf/t2wGx5we9qh5d0Npi1SGXMsvlZ8aNtKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B09wwLWe33bBJdEGM4w+WwOeZThIkXD6T9IKKqPpPvI=;
 b=CvugDt3BHX3CTOrb/V1kdQG9EtiZjGaWwXKNEEpaA9UU9mGGnji0fnghZVYWYRpsE5n7uYr5fu7hgkAq6GV0EKdemZHMVsTCMUmWld65ZdQClagz+63r4b4jgjJNaiwJExFgNvQUfkH8uliA/wiZOzQ1tGLvUxAD/DgXPr31xC5Ut8xyBK4Wo/uyA2fCSOaZHUeE2tGvbptM/zXwMjr5rKzLJx+GwcsyxMSEjCofWsT9Pd/+gbHxnyHQllD2EkcW30h+Ts/CZqJceeJrQK4W88wWIe/+A/SL71rFtjIpT83nxYgLFuxsM0oy0jWLXSvwohV/PK4uJgZ8/zLnIIKjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B09wwLWe33bBJdEGM4w+WwOeZThIkXD6T9IKKqPpPvI=;
 b=L4LpfOse6oyS8PJ3vfK+m44ytfzPDbcf5sTDsimvhzYG0/KA/1Pm1V9+NLLLRDSZFeEHXTyYbR1P5sJBN63y7+fiuHrxht1BFv7HmxeZ24S6UivBBKElMV5BNQA0vaJXX7jVuvlVUa/VTMGnfoMLJ6RzunXHySlPiAnVWZwMMWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 08:50:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 08:50:32 +0000
Message-ID: <2d7196f0-0b30-491a-adbb-619369da26a0@amd.com>
Date: Thu, 20 Nov 2025 14:20:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: adjust the visibility of pp_table sysfs
 node
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251120083425.2765422-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251120083425.2765422-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: f635ed4f-7a67-4874-562d-08de2811dcd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlJXS3JaTyt4a2tQMDJFc1N1dDg5QjQwQ1QrNHJUQ0FMVGlrNlhSQnVVZDdS?=
 =?utf-8?B?WUJVRGsyNlBGd0dWNElIdlpxSGJiTjVLcmZzUjhHVTdrTEVoSmxUVkQ2akEv?=
 =?utf-8?B?V2t2OGltdUdxMjlJWE5YZEtzN0duTm9EWHU3NzdHdC9HK1FLNXBtUVFQL1J2?=
 =?utf-8?B?MGlxYzhsaGpGdWJ2bnBHNDN1QU5idms0QVRtbDlBZnh5Mis2RnVkV0NSZWU1?=
 =?utf-8?B?Q1JQbWVoSlJkU3VxYjhOZXJ0THJqYUxITkkvbzJyTks4SU9ZcnY3SmJHYmRt?=
 =?utf-8?B?bFRBU1ZMbWV2QVlYKzVQSjA3RlAxZkp0NUl3SzQyMlAwV0FsWG4zSVc4NG5r?=
 =?utf-8?B?S1YwM1huYXNXOEhVQ1NuRzlaay9pd1hxSlRZSHBwMDhPYXA0M1ZqU1pqMll5?=
 =?utf-8?B?VkozSmRtWmtnRjhCMVNTVWI5UDAyTTFKb0I4VGJMOG85TlVqUmlseXdyOFZJ?=
 =?utf-8?B?VWJ0REltNjcxUkJ2T1NrcXI5ZzBVOTMrZDhRb0NNdDBBSXJmM092U1ZVcjVQ?=
 =?utf-8?B?V3M4enhKa29jYXhkQkJBdDM3ZUtzWFBxOFV3Um5rQmFZTjVEaHNieHZuTC9K?=
 =?utf-8?B?aVUzbEprNHAvN3kwYlM1QlhvR0tzWFEzc0QrWTFManB4cThzM2FlQ3hKTW5P?=
 =?utf-8?B?amJtZzJ0RTAxMHJxaHV6VndUODV5QVBZU21MTjIxaTVRK2RMTUZSZXd2Q1ho?=
 =?utf-8?B?TmY3b1UzVVcyV29uMm1XOExkWlAvaUZrNGYrUTN3Q2RBMkp6UlpnRGVjWEgz?=
 =?utf-8?B?NERjK3IwMCtFWHY1VVYwcFErSVJTelhMcWdyZVZvUm9MQSt3Rndtbk5lRXp5?=
 =?utf-8?B?RlcybHhuQThQbm83WWtmODBKdHRyaE5iOGJqb3lFbWtkQmNkcHYrandUenZH?=
 =?utf-8?B?ZFMzQmkvS2NmVVc2amZHaWxOK2VhelNNSFF6VU1SbXdxWDdYUUtEVldDYmZa?=
 =?utf-8?B?WndFN3ZpTkJsL2psZ1hnZDRuYkdRUDVTVis2SDAycWd2djNWdG9KdGRNNUp4?=
 =?utf-8?B?ZGhpQm94NUdkSDhSaEN5MUVvQ1M5WVY3ZW5yNThCeGdDMng1Zzc3U3FQKzBP?=
 =?utf-8?B?M3dIc1FPdWNvYjJ0ZmZZU1F3dW1jQVRWYTRpV0tLWE1nS1plRW5ybWdFOUph?=
 =?utf-8?B?dmxVZm42TnZYQTJsWDRiUkxHOG5zRzNwbmdmNEx2Q3Y1bmtmWFJUeWRpdmg5?=
 =?utf-8?B?dVhqdlVtb0JHaC9iQitQVGVEVy84Z3BNNUlQam1ZK2JWUVpVaU9mYWFQWUE4?=
 =?utf-8?B?S2VOcy9iU3d1NzR3d2RwcFBTSDRjUWRPR2NPdi94VExwVTR6bWNJRXRWNkRv?=
 =?utf-8?B?akJDMXlRMEhnV3d1OGxsM01GRFAxS25XdWxZcHlWN1pId2UwOE9zeWxpUGNq?=
 =?utf-8?B?Q2hscDZuL1BibktlT2I2bzdqQWRGMzIvcDYzL05Eb1haeWplMCtXTFJCTlB2?=
 =?utf-8?B?ZFFrcUwxeTU4WjI2ajhWQkk5bWo4ZHJkRjZINDFPNXIzMkhtcTJiNFFNbEpp?=
 =?utf-8?B?bG1mcE5HYUhqd29zbFVrTkJnMmhuY3pOZVRsWVQ4eHdheUtLUmt0dGtLQmJo?=
 =?utf-8?B?OHEzQ3BiLzZaYWxRM2s4a2xucFQxQUVGcHpOU1h2bWpNclNUTWlKeFh2akh1?=
 =?utf-8?B?R1NadVg2Yll2RFNZRUhYRzdLVkNWNmZuV3dKOStHSXBZY0YzeWpqa1FoZ01r?=
 =?utf-8?B?Skc0VE5rQjFybjd5Q2ZjWXhucnhYTmZ4SmhGbFhSVnRwSXlVUW14V0wxek5I?=
 =?utf-8?B?Z2FPcHVRemxjWUlEM2VGblpkam9LRFRRMStjQ3Y0V0x4d2g5dENHZ0RGWlhY?=
 =?utf-8?B?VjlPU1pRNWtIblFZUG5mUDVkV2trdmRabmUvc05xeTI0dkJBSk9jUHpQSHdV?=
 =?utf-8?B?RHBDaU9HZUZyUlpYbGxvQzdWcVJSMDNZZUJjcDRaWlZpc1UvcUYrcE9pU2Fo?=
 =?utf-8?Q?tr1Kwvw0/0tkm5dTXX0XLB0PchqZu94g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNFL2JhL2JMRTV4K3lLd0p1UjMwV0dhN1BnSTdYLzhjNEFHd2dvMkMyS3B0?=
 =?utf-8?B?MVpkNVBkVXhOTEdOSzF2cFJxV1RpMG5BWi9EaG9NYTQ3WWdmWjZTQmlrM2FH?=
 =?utf-8?B?eklvcjhRUG80NmlQbUx4MFoxbWgxM2hEU3FHNWlXbTJBNm1iQWJ0a0JEWGhk?=
 =?utf-8?B?SzZiU0RSYW12em1MdnV0dCtTVm5BVDljSjVrd0x1S2tSZWFrRUY4YnU5bjcx?=
 =?utf-8?B?YkVOYlZwZWtYM2pFOHVJS0RDTDdFZnM3Y1VsaTQvUzhpN1ZXTkRpZU4vaWJE?=
 =?utf-8?B?eExxUS9SZ1p4Q2RtZHhpVHJ3VTBNcnc2SEk5YjlkajFRZzA5eXNBZkY0V05y?=
 =?utf-8?B?TFZsSGY3UVlMckZWbWRqV1c4ZkhWYTFWTVRZZ1ZpbHdvMVNmcGVNTzk1RVZP?=
 =?utf-8?B?VUQ1M2UyY2VsNnlTbXE0ckY3T0M4UHp2U1dZYXY1S2FudHEzYzNUTEMwd1Vr?=
 =?utf-8?B?a2hnNG13b0ZCYXQ4dTZhdzd5NUlkR1BOOFIyNVQxK2dRbU1YbUJmN1o2Qy9T?=
 =?utf-8?B?RzBGSVdacVRQR1N1SWU5UW1QRm8yUHRGOG5SUjM4L3ErWWJsdEdjOWtKbG5j?=
 =?utf-8?B?dE54cFRYMVVRenVRdFhHaFhUOXU1SkM1QjEvb2tkbE56ZHAxSlNMc3lIamlQ?=
 =?utf-8?B?azZERTFCd2x2YnVWVVdoWGorM01MZGU3V3NzMk9hbTVUai82NlNmSE1ZblNn?=
 =?utf-8?B?RGk5TVN3SXlRMHRYclRjKzAzWmhiVWN4b2JWZUVQVnI4OEdxTTVkc1VodER3?=
 =?utf-8?B?dks1cUNIU3JObGxVMGpTREovQUJiOVZsWitTaUdPZlRCVUdPTDl2cWUvZCtl?=
 =?utf-8?B?bFc0R2lndzJibER0SmN1OFNGQjJtcE1UNGozMmhuSzZHb0d2bVpkbjVxRjAv?=
 =?utf-8?B?b1hleWp5bkp2YllRWmpON0Qxa1lrZVdOOS9zN1pHYWlleExaWWcrb1J1b3ph?=
 =?utf-8?B?aUh1STNaNlorc2ZuaEdpQm9tUWdldjd0MHpGaWtiQU40bHk1NFd3dDR3K1hR?=
 =?utf-8?B?M0FIWWM4d2krNGtsaU0vaFhybHg0Y00wSmEySUx5MGJHVFIyaXRmYTBvWDR3?=
 =?utf-8?B?ZjllZ09Pc1BpV0FubnFuUmNybElsVGJUNDhrMGloOUZZd0Q4dk1oSXYvUkpw?=
 =?utf-8?B?S1BKcGVTRGhvZ2VJR1cvaHB0Wll0K05HcmJ0V3ZzMkhmanlXZWFjOURFeWhX?=
 =?utf-8?B?TXFaVTNWcVdVd1hwVmpkdEdGM1ZZVnMzNXhJK0wwNkMxVHRRZWFpS25uWm1z?=
 =?utf-8?B?Z3VadnlnQit6U3hpNVhPV2hLbkk5bjJJYkFjSnhUdXYzNFFFY0JwSVpSUE13?=
 =?utf-8?B?SUhkVFBuU3doajEvUEdreFg0S3A2MXkrcXh2MXh1cmliYUNITW15aGMxK1JL?=
 =?utf-8?B?cmtMbmJGb004UXdUU2hCWEFqSjEzcEp4TFY4WUwxQ0k3M2VKNllCRE9WcjV3?=
 =?utf-8?B?MVlaUHVCZEFQY3Mvb1NPckwrYVhTS1VpSDNlMFhrb1N4N0JwMmRvejVtWTRy?=
 =?utf-8?B?aDh1OVlWUUwvT3FEZWZjT2p3NTBzYS9TS1dSa2xGamNCUmEwSGdjVDZkQ2p0?=
 =?utf-8?B?Y2Z5ZkNlQjJXbi9pNyswMVFDbHB5akhpUGJTaFRqeHQ0TStFVXRkcWt6SUZE?=
 =?utf-8?B?bEExeFl0cGtHMXRnWXgrK0xRRGc3c3Z2ZExlbnJ5YW5HSTBOU243QXRpNFFC?=
 =?utf-8?B?cXorNHNPWURnOHBpY0Ywa2Jpd0piWVJCR2VoU05vcFlrR3VNRXA0MjgySWtl?=
 =?utf-8?B?Zk02WHhINC9JNWFLaVl3M2hUaFdXekFnMDhwbjlJMHdIRVVSU20rL2VnY2dG?=
 =?utf-8?B?OVhNaWllK2pTU2t0S2sydXZOYTdGQllDQWZmK01hYitLTWEyOWp4Z2lrSmto?=
 =?utf-8?B?SWZwaXcyN05OaTRhRUpqRnN6R3k0RnZHTXpMK1ZMdDIxd21scU80VmUwWXIw?=
 =?utf-8?B?QkF4OVNsZTFlOXNYcGhTTTRhWEJKbS93RW0yNUpmbWw2aW1aU1oyRWJmU043?=
 =?utf-8?B?T1dMWG1MTkR3ek9ISEtBZUUxZHZiamNYVXF0SUNkQ1ZjakwrbDE2MHhINzVk?=
 =?utf-8?B?N2g4eS9Qcms2MGRvUzBDQlh1T1ZJcmt5dVRId04yN3FHdHVhdWozS3Z5NHZH?=
 =?utf-8?Q?7vKtvy1FvWhfUD3+089RvbZ6E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f635ed4f-7a67-4874-562d-08de2811dcd7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:50:32.1900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsPaCMsW3Tjk6bRYWl7aYUKfybL5/aZ9tTdgDqTr+KGaavRQhGItaxeDbHJHu8i7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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



On 11/20/2025 2:04 PM, Yang Wang wrote:
> v1:
> - make pp_table invisible on VF mode (only valid on BM)
> - make pp_table invisible on Mi* chips (Not supported)
> - make pp_table invisible if scpm feature is enabled.
> 
> v2:
> move pp_table invisible code logic into amdgpu_dpm_get_pp_table() function.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 12 +++++++++---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c  |  8 +++++++-
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index c6f55d3522cd..79b174e5326d 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1187,8 +1187,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret = 0;
>   
> -	if (!pp_funcs->get_pp_table)
> -		return 0;
> +	if (!table)
> +		return -EINVAL;
> +
> +	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
> +		return -EOPNOTSUPP;
>   

!smu_table->power_play_table && !smu_table->hardcode_pptable

!hwmgr->soft_pp_table

I think these checks also may be required in smu and powerplay manager 
callbacks to return -EOPNOTSUPP.

Thanks,
Lijo

>   	mutex_lock(&adev->pm.mutex);
>   	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
> @@ -1715,7 +1718,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int ret = 0;
>   
> -	if (!pp_funcs->set_pp_table)
> +	if (!buf || !size)
> +		return -EINVAL;
> +
> +	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&adev->pm.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 2a9467fe86db..cbaa6cd1a983 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2560,7 +2560,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>   	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>   	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>   			      .attr_update = pp_dpm_clk_default_attr_update),
>   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
> @@ -2692,6 +2692,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
>   		    -EOPNOTSUPP)
>   			*states = ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_table)) {
> +		char *tmp = NULL;
> +		if (amdgpu_dpm_get_pp_table(adev, &tmp) == -EOPNOTSUPP)
> +			*states = ATTR_STATE_UNSUPPORTED;
> +		else
> +			*states = ATTR_STATE_SUPPORTED;
>   	}
>   
>   	switch (gc_ver) {

