Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AF4D31A29
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 09:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1DC899D4;
	Wed, 14 Jan 2026 09:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0N2l8RVF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8217E899D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 09:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaNjFy7It8LvtSluKwf4Xv/L+wnVYy/yhNX/Ov8hN4Z0mbrUq5nyfKQLLNSfwkCMfbvOI1rREwOmTqFxvkeQCROGk7iR395z69PeOi24urPKz9Ggl98QlBQB4O3hf8w6SEUfeCy3GlZHeMQIFr9wTmQoyGSl7IxloE94XP4DannLAGy4/OWl/fjlXz+c47mYFDNrinB9+sR6s8gu3LAZKf/u20u3/OTMkXguXhWqSBWrDBXZ/l1+OkADZhtO/gW4vjVGPy3ZA2K7njuSfxkkv8uievEGoJzvkb/WFM6lgXUUvqJTq/WGLyWGvII1QrZVWjcbX38TSCri/7nd3mPMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTy1pISKzJOqCZQdjXJQFLS67skwLVnUv6/3QqvsFaU=;
 b=GfbmAnbDjvs72bWtPqhoDWjuxEkLORb15sV+xaPi/R2XwtdrY2O6DiUu4pmWohbVwufBV0rmA3qrZoDBjFz4op61UxiFJpKidYegUeql/5kLsx6BY4YKj1I8e/BDLBJoYUk2oJa4O2Cuf/3jlm6toRPdMTZURzlwyX9nJ3AKVGnEZcYyH6WujkwvzzL5DiY/uzRsc8zcJ4MK0xaahsD8q5Hq/hdUG7AYgUqHBqmVLc4ddwveP9yMqfuSv1TvsvapVVUXSbe68WQVY42lkiYzELiU8y+rRVfM69I1GVUNsn61y3Mhil3p6kLKvbvh1h0SKpajpMDyAuVgLnFH//ZZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTy1pISKzJOqCZQdjXJQFLS67skwLVnUv6/3QqvsFaU=;
 b=0N2l8RVF45+74POWiieJn53QowLIRCpAUfkCeYsbV60cecg8OhGKIxd7ko73MqRNknAine3RIfH+5Zk8tbps7GcADivjTaebTud8jOSCkQrAxSIHSN4D541ESKJ3sib62a2ZFLn8G50r+RgEBMKTuz/AA1c52+YO4UAwBJyuxb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:05:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 09:05:30 +0000
Message-ID: <e40ebb93-39ad-43fd-802b-5deb89820190@amd.com>
Date: Wed, 14 Jan 2026 10:05:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Add independent hang detect work for
 user queue fence
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260113082241.291255-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260113082241.291255-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 471beb9c-18c4-46df-67b3-08de534c10dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVZDdWh1c29HV1g1ZkhrZmZqbTFNelBBU2lnTnhIeGcyNHdSalhqTmxSZ1Ex?=
 =?utf-8?B?d0Vtb0J0Sm1JdmpidG41TWVMOXZkT0JRWk4yUmlnc1VxSHU4UFBXT1dkcmVQ?=
 =?utf-8?B?QUFjeVFEK0NHSVA0QlNYUFByS2szV2FKT3h1YVRWWTY2eWd3eE83N0FFTHFk?=
 =?utf-8?B?WHJrLzZ4TDZPd3VXUFltaitPY0dSZDAzMWd1QzUweWhDR0lkZlhaOElSTUx3?=
 =?utf-8?B?S0gvd0trY2k3QkdJeTR2L0ZHdStzVkxwUmgxSFdqelEySU43WHhIYVN5RzBF?=
 =?utf-8?B?TmprZXBHZU1MOTRBUCtjQThmSSt2d0M5UE1ZZldKVFk0UHdIdmFqZFhVeEJQ?=
 =?utf-8?B?NzJQOGlmaVdQMWZDNEVqcTIrL09PV1A3eTZZemxYVVpDZ2ZwUDVva2pyVUIw?=
 =?utf-8?B?UisxTEc4cWlSSnJ4dlovM2FSSjBzVVZSNlpGMmdIaHRDbnlrVHEwSUQ1emwz?=
 =?utf-8?B?ZEFzK255QnMvU25rZ2t0Rk53RXN5b3dLYTJsSlV4YnRmMXh2cUNJbytmR2My?=
 =?utf-8?B?THdnTWE2c2ZUbktOS0lxVktwUG5uUWkxTms4RGE0UHd5U05TRkJpbVQwL3Yv?=
 =?utf-8?B?aVFKNmJJZ1FwVE1rL3dWaWQvLzJOZE1TYmtmSG12MFM5NllGcStwMzNhMEVE?=
 =?utf-8?B?Y0N3T3hSRm5QSnVOVWE0LzEwRFFxeTFLb0RZZzM1UnNJdi9FWWJFZ1NQbG1u?=
 =?utf-8?B?c2g4ZTBWYzRaU1dLajE4RUpKdzB0S3gyUUI4cEt3TmRFV1h0VUpBVGgxQUJU?=
 =?utf-8?B?VTl4OU1YNENtdHpWc0RjY2tNWXRKWEErV2pwNXRCYWo4ZE43YkVvMFpaTk5D?=
 =?utf-8?B?MDVDKzUxRGNKZEVEMGNtcTRoOUQ0YW5Xc00ybVMwVWJqUTJKWUl4OUQxY3U3?=
 =?utf-8?B?VGpPZUtDMStqUm5uT1RiZzE3RUNvS1J5UVFFcEpJL0Q2cGRaOXBrSmtUbVVL?=
 =?utf-8?B?bDY3ejg1TG5iQ1dsMTN3MW5EWVd3RjRTWW9oM2E3VTRkYjlwSDZnVkQySFF2?=
 =?utf-8?B?S3NneHlwQ3d3Z05GREgyWUZNM1lHMVkyb21NU1Z3ek9ZQkd1TGNtY29DRUJJ?=
 =?utf-8?B?SmpTWnljNjFUek13OTNoV2xlSE9aNGVHbHp3ZGFKd3pabUpWNnpqSmNjWHNU?=
 =?utf-8?B?ZTQ3ak1la3dKMEVNU29Lekx4SDdLajI1YTU4SHoxckRLK3dubWVER0xzUFJ6?=
 =?utf-8?B?RmpZdDFuQzVoOEZQY2ZaNlpnVnJOR3Z6OGVOeFNROFplUGttR0FqRzBqZlZo?=
 =?utf-8?B?a3lZMkJLcjhUL0FBVFZ1OU5ZOHBoRkdiR2JMdVcxcnNqVEZrQk9JZWxjY2d5?=
 =?utf-8?B?czBmaVRxbTNoc0ZqM2t2alhvcEQ2YVpvaitMOGp1MlJiRGRUVjR1d05JY2Nv?=
 =?utf-8?B?Sy80MnYzTitqYkp5bTlnbVd3dnZEalJ1bTQ5WjFJZDUybVlneGFDZUxFK2pB?=
 =?utf-8?B?OTg3RUlJMDFON3AwRzdtQUJMMk14UjlmdlZxeVhxME9wUCtXbHlKWUxTbVBR?=
 =?utf-8?B?dmMwdjlHeDNQVkZ4TVk3b0lIay8xajloTW04RHppclE4TU16MGdSN1VQYnZs?=
 =?utf-8?B?bXI1T05jczBDK0xTai9MRGVEN3JnNUpFTU0xQTFuRlEwSVdLNjM3dEUrVHZp?=
 =?utf-8?B?SWN0R0VkTTQxUkpXeXZ2QzJmdDVjNGl4RHNwRERialFmTFF3NWNQb1NucHRi?=
 =?utf-8?B?Yk42MEhxZjZ5Ym54UElLY2FIUUZJcVFNQzk5L0NTWVFncFc5ajlnSXpYd0li?=
 =?utf-8?B?a1JVbm9IVTF0aGU1VCt6QnZaUmJJQ3RyVERXbWFOejFMOWhBRVJXNjFtV0hh?=
 =?utf-8?B?YUhRcHQvZG9Wc1N6YmY0Q0VDUms1cS9DVno5YnRMSDFqeHRtOUluamtVTFk4?=
 =?utf-8?B?Y1M1bnpGcE1panhES3Exd1AvRXdoakl2SzZnSVFUWGJBNk84azJ5SEJ4ZjJM?=
 =?utf-8?Q?ZTFv2OK8EA49a7mOKP0UDL0hfaF38A6e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURzWjl1WnQrV2oydUhGTzNIQ0JtTWd0SXVDQTdKNnB4Y3JKdW1HcEtRV2hz?=
 =?utf-8?B?NTRhS0h4MTNJeFNRV3g2STBWaks2dTRDeUpHZ094eFFITTNQRTczbS9mSDNL?=
 =?utf-8?B?bGVxSENVdk92Z0Fnd202S2lPcG5GcUQxdXlSQmxaTnRtYnRKaUZ3NzdkdThj?=
 =?utf-8?B?S1gxeGhMMHZHWFZ6RFdNNlRweHJ2bExqbnpVUGNjdkZtODRQaXRJc2VzZ2J4?=
 =?utf-8?B?MzdOQ1RqcUpqYTRJaE9INnluRlEvYW9aY1gxd1ZLTzNvTGZaSFVEN1hMTjBH?=
 =?utf-8?B?bXhiajdBSEdESGJ2T0xXcUt5R2NFZ25DcE9Ocll2eERidXR1cmdRZWNtbGQ5?=
 =?utf-8?B?ak5ac3FvSDFadVVRdktFVElXaG9POUw4ZG14TmdPL2pscVN4LzdjT09EMjVU?=
 =?utf-8?B?RE5SanMzSmFvZzRCOVhvL0ppWm9TS1JmR3Q3Q2gyR2dDVmkzZDA0MmlrVUJq?=
 =?utf-8?B?bEVlWUFzaERJend5VW1NYjE4Vkp5Ky9ydzk5bVJvc240ZUxlT2YvNnJPNkFH?=
 =?utf-8?B?V1V4aVZPcjk3Y1VSajJvRDJkN1NIV0xEODI4bERpQnVKNUlISnprM0tvaXp3?=
 =?utf-8?B?L2t2T3BZUVZEN29kV3ZLUlNNazFSeFphZzRQWCtSYjdRUktWVDBmYzFvMDdj?=
 =?utf-8?B?aWNsNG8waTJBdlNBb2ZXL1lqZG9TUFB4akdXUjZEaHo3MXhtd1h1ZDF1WWxa?=
 =?utf-8?B?V25BN1E5WUo0Vm1MNktQanpZOWorYW02WnNLSm9DaFI5V1VQc09xYVJvWHNR?=
 =?utf-8?B?WjM4Y2svNWtKRFdvOUIwazJ2NE95RzFydHJaYkxhOUZsUWloK1NGWlo3RlBy?=
 =?utf-8?B?VkxuVHNvck9paEFJVmY4YTNRTTdTN3lHZHpVWDN2K3BMZnNObTRMWmFEUXhO?=
 =?utf-8?B?MHBPMXVZWmNRSXFvUFg5QlZRWnV5UE5QcFNoZkhkY1k2emVWQTNUc2pYbUZU?=
 =?utf-8?B?Zm9OeEFKYTZmSkQ3ZTZSbmUvZnBEVWhSRWNLbVYvRVk5aHB0d3FTbVpJMi9t?=
 =?utf-8?B?WjRmY1RKUlJIbEk2cGRXYy8zeSs1a1MxdVYraDZ0dVJ5b2F4SUpaMjZBSGNN?=
 =?utf-8?B?czllRjlqbGtJd2Njb2JmOU5FOEozZ2hDWEc1c0REWFNHVmdLSlB4MjBTSWNL?=
 =?utf-8?B?T29nRDFhek1yNjFJdjBUN0J1dlpJbW13TTVmNWIzTzd4cEs5cU8zUFpHc2k2?=
 =?utf-8?B?U2xtcFE4USt3alVBOXFwbTY1dW1vL2lhR0xpdTdCbjlYY2lXV01LS2dXUjFZ?=
 =?utf-8?B?NVRXS0RFblJzczVZam5zZmp2bWVBem9UcnBvTFdIRCttT2VKdlNjOHoyYk84?=
 =?utf-8?B?UmpyQlhBT1FYK0ZyVXp6SU9jSXdlWFBtSEVhbmkyR0FzQjM4RTVHakN1SVp0?=
 =?utf-8?B?WEFRbjZNcWU0QTNmSWNidHF4RjBqVFdJbmJDditZeTNIaDdvZHB2T1VJSlZy?=
 =?utf-8?B?MFVuTzRsSjJGMDluS2ZVdW5tbHdzb0hXLzBaV0NEQ3hZUEFrdXZzcktkU3Iy?=
 =?utf-8?B?aXpWeVUxOTl5cXp5RWtzOHg5YU5ueG1MYS9JTFpjd1doemppU1NRbVorTmVN?=
 =?utf-8?B?dUNCaFR2dW1lUGczWGlSSGZnMTlyY0trcTdVeEtPd2FQZWI4bEJ6YW84L0d5?=
 =?utf-8?B?TTNQNFJ4akxWN3pQeFhSVUFFM3dHM2JvSzl3Z0IvVkRJelBVTGxiUjlHdVp4?=
 =?utf-8?B?VkNpakl4ZDNkT05WSVduclhNQXRyc0pDMzFVSWZlSnlOSFBWcjFrYldJa1ZZ?=
 =?utf-8?B?TFVaZEtueFZpa0JaTUNOUFpDTFJySFhGRnAzQjZiUDVmQ1dudWM5NDV0QVFJ?=
 =?utf-8?B?elU1MDVqTUcwSkwrbG5UaWowcnp5MEUyRjc0eHZ1RXZiQnQ2Z3J4WmpoWEov?=
 =?utf-8?B?dnpZL25QOGovYmx2V056aTZFUlNreVNqdU9sU2ZMZkFtWTNWc2tVWDJCMlBJ?=
 =?utf-8?B?NXV3dG9aQTMvK0tMNFJ6SGQwQ0FNaU02a1h3TWdjRENzMUJ1YTN1cGFoYWhE?=
 =?utf-8?B?Ri9NYmRYUVkxRE0veWRRODZJNTZ4WlM2YTczR2FQQTBCTnlDT3l6TnFJU0RG?=
 =?utf-8?B?bHRhSlZaYXU5U2FMcUYwUTVEWWxxQmFaam5sMFlJKzVNWTArNlVCQTU2Ynd3?=
 =?utf-8?B?MDNJSFRkdUxlS2V4K0grSWxBOTFheWFPQnpjSXFZL2R1MVFjZ0NRZ3dWNlha?=
 =?utf-8?B?U2g3ckM1Nk5PUEFuM0puRktTZDNPQUwvWS96WTRPZmtCMzhETWtZbm1pVFB5?=
 =?utf-8?B?R1ZGeVdZOWQvbUFUMkF4dkdDNjdCVXdMQlY5eC9pNnc0SVp3QmltS2dwTk0v?=
 =?utf-8?B?TnpTMVRwS1BSeTFzaEp5TVlCMEl6N1Y0YkxrZEY4RUh3SktPek1wZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471beb9c-18c4-46df-67b3-08de534c10dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:05:29.9835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGxQ6qGL4dn+W0l3DRcjw+44lyWcD1w8w8MUhs2rVAaUYV+4LUWsFiNC3DaGFbB0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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

On 1/13/26 09:21, Jesse.Zhang wrote:
> In error scenarios (e.g., malformed commands), user queue fences may never
> be signaled, causing processes to wait indefinitely. To address this while
> preserving the requirement of infinite fence waits, implement an independent
> timeout detection mechanism:
> 
> 1. Initialize a hang detect work when creating a user queue (one-time setup)
> 2. Start the work with queue-type-specific timeout (gfx/compute/sdma) when
>        the last fence is created via amdgpu_userq_signal_ioctl (per-fence timing)
> 3. Trigger queue reset logic if the timer expires before the fence is signaled
> 
> v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)
> v3: The timeout detection must be independent from the fence, e.g. you don't wait for a timeout on the fence
>         but rather have the timeout start as soon as the fence is initialized. (Christian)
> v4: replace the timer with the `hang_detect_work` delayed work.

I don't have time to wrap my head around all that logic again, but from a one mile high view that now looks solid to me.

Feel free to add my acked-by, if you need an in-deep review and Alex doesn't have time then please just ping me.

Thanks,
Christian.

> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 70 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  1 +
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 98110f543307..664a15278c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -148,6 +148,69 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
>  	return r;
>  }
>  
> +static void amdgpu_userq_hang_detect_work(struct work_struct *work)
> +{
> +	struct amdgpu_usermode_queue *queue = container_of(work,
> +							  struct amdgpu_usermode_queue,
> +							  hang_detect_work.work);
> +	struct dma_fence *fence;
> +	struct amdgpu_userq_mgr *uq_mgr;
> +
> +	if (!queue || !queue->userq_mgr)
> +		return;
> +
> +	uq_mgr = queue->userq_mgr;
> +	fence = READ_ONCE(queue->hang_detect_fence);
> +	/* Fence already signaled – no action needed */
> +	if (!fence || dma_fence_is_signaled(fence))
> +		return;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
> +/*
> + * Start hang detection for a user queue fence. A delayed work will be scheduled
> + * to check if the fence is still pending after the timeout period.
> +*/
> +void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev;
> +	unsigned long timeout_ms;
> +
> +	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
> +		return;
> +
> +	adev = queue->userq_mgr->adev;
> +	/* Determine timeout based on queue type */
> +	switch (queue->queue_type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		timeout_ms = adev->gfx_timeout;
> +		break;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		timeout_ms = adev->compute_timeout;
> +		break;
> +	case AMDGPU_RING_TYPE_SDMA:
> +		timeout_ms = adev->sdma_timeout;
> +		break;
> +	default:
> +		timeout_ms = adev->gfx_timeout;
> +		break;
> +	}
> +
> +	/* Store the fence to monitor and schedule hang detection */
> +	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
> +	schedule_delayed_work(&queue->hang_detect_work,
> +		     msecs_to_jiffies(timeout_ms));
> +}
> +
> +static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
> +{
> +	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
> +	queue->hang_detect_fence = NULL;
> +}
> +
>  static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>  					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
>  {
> @@ -572,7 +635,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  	mutex_lock(&uq_mgr->userq_mutex);
> -
>  	queue = amdgpu_userq_find(uq_mgr, queue_id);
>  	if (!queue) {
>  		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
> @@ -580,6 +642,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		return -EINVAL;
>  	}
>  	amdgpu_userq_wait_for_last_fence(queue);
> +	/* Cancel any pending hang detection work and cleanup */
> +	if (queue->hang_detect_fence) {
> +		cancel_delayed_work_sync(&queue->hang_detect_work);
> +		queue->hang_detect_fence = NULL;
> +	}
>  	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	if (!r) {
>  		amdgpu_bo_unpin(queue->db_obj.obj);
> @@ -818,6 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
>  	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>  #endif
> +	amdgpu_userq_init_hang_detect_work(queue);
>  	kfree(queue_name);
>  
>  	args->out.queue_id = qid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 1eaa94f8a291..06a06272b41a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -72,6 +72,8 @@ struct amdgpu_usermode_queue {
>  	u32			xcp_id;
>  	int			priority;
>  	struct dentry		*debugfs_queue;
> +	struct delayed_work hang_detect_work;
> +	struct dma_fence *hang_detect_fence;
>  
>  	struct list_head	userq_va_list;
>  };
> @@ -146,6 +148,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  void amdgpu_userq_reset_work(struct work_struct *work);
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
>  
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  				   struct amdgpu_usermode_queue *queue,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 25f178536469..374fbd0e859a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -569,6 +569,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  
>  	dma_fence_put(queue->last_fence);
>  	queue->last_fence = dma_fence_get(fence);
> +	amdgpu_userq_start_hang_detect_work(queue);
>  	mutex_unlock(&userq_mgr->userq_mutex);
>  
>  	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,

