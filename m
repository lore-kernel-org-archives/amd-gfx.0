Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25787C83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 12:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E5C10E5A3;
	Tue, 15 Jul 2025 12:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6cZFVug";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDAC910E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 12:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogK+yUzUVK5gDO68wWBDysFMvdxr76DjdOXn2uhhv9gJIJ/P88my0nrCjljcYYNWw9SGimpy0YWTSSf7o/UsGsRdpPEEEWa54OS3VwIKhdk19QSXf704p+XkFRdF3HPpYS/S3joo4vhXkwp1BL1HDJG+3rzfnxx7/ZwyNXvw1XN5AqIBDc9V2UTbKP2Xbl5wfJHZaRCNwzV8fdbWOod48PYQAZPLU3gqKAUPxAyxzk5I0jdpNopGExY0QbUECqbEprxfZB5L8WI+8acl6/B6EI2ndgt1XFvXUqVxVvLx9gNocL1eIlTrRY1f6zp5wkFUa1KLWxN8nx4bFemqaVUNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmyJzCK0h1ZsSu1VGovdftmRjRMspg6zFeDvrLJJHXY=;
 b=oPM9pejQKV0+TqmYmMLjkWtcDdQvzoSEGk4JMedu30wYlfb3Z9+vVn+5mTr1mC0vcnRMzGRreZfSMBSHP591X7LkdJO0esLpfRQUhTrxZq9uu8fGfUqqohAg2Datkn7ncUONsWf/slwDOz8oDEg1+RLuEMblB0aJAQequ9iFquaSGT3YBp4eOAQ7p2CJlMK0NJN7mxsmcsbi6heA7L8Irtk+UMo7PxkJlYjenC5jHBmRe750epwlNOQDAVu3apAQGE/1ES6GjEkQZrAB+5F5GKlEWky4LRmt1d7JRRd6ghNwAxG3jf4dXKGF7U8YyxNcE21gfpjbwK72l+K9nQqb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmyJzCK0h1ZsSu1VGovdftmRjRMspg6zFeDvrLJJHXY=;
 b=s6cZFVugrijvTAAdXmiwAJoXr9m+t3Pleu+l0UgdmQgJC8YgBSw8WNY65wPouDvSKMNZq4LidRMnNUrbKw0dZ4ynGWyxzY6DhaooRSYxYfedidz7F85s25pp/FbpFpE3GITBXEOoOl+jQnbZ2rc6cx6sZXNE6iHEUmb64Jzelbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 12:15:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 12:15:14 +0000
Message-ID: <0c83e6be-66ec-4dba-bb8e-c00e6fab7541@amd.com>
Date: Tue, 15 Jul 2025 14:15:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior to
 destroying
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-7-Prike.Liang@amd.com>
 <4e9bb1f8-2c73-40c2-96e3-cc186a476a5c@amd.com>
 <DS7PR12MB600519342AB474F08F21DC0EFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600519342AB474F08F21DC0EFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: f15298bb-3b1f-4194-4c8b-08ddc39940cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1A3dU05VXlibTIzVEJ3aGVlVGdYY08vYmQ3aVNMbEJXMTFyeW9OeXhWMVhV?=
 =?utf-8?B?aGZLdEsyU2JGWWNLeXJCUXNsT3lYT3hlTk5aS2xVWjgwTHVEVzVFM3pySHFV?=
 =?utf-8?B?TG54NkVBYW9vMkVsUDZDdWg1MGxBMHpVMnA3Z0pLWm9vTGF3Q2s4MjhVendy?=
 =?utf-8?B?cnY5a2c1MGsyd05yQWp3Sml6dlVncHljdEtBWGZUdFBtRENBMWZLTzl3eHBG?=
 =?utf-8?B?cFU3ODc2VkFETVVNYTM2cDlkUm8ybjRTd0R5UCsxL2JRMWFFSnJJL3VxaUpO?=
 =?utf-8?B?c3FkbFV1TFdGUjVBcUlteHZiaS96ZkpGS09qdEl1VDhiQVcvUlMyMUgxUzFB?=
 =?utf-8?B?RnhyRlc3dHQ4NTNmWWJVVTlqUVhGK0t5anZNNFJTa2ZDbU9vZ21wdjhxUEhw?=
 =?utf-8?B?UEZvbzFRRUt4c0g3WEZOaWtoaUx4LzdwWVFzYzN4NWxMVDVzZC8rRVVFRjM0?=
 =?utf-8?B?SXZmSHdyUEFuTmdkQ1BOa1lUTUhuc3dOZjFzRElPVjZHL2RaY3BvaFJReE1r?=
 =?utf-8?B?M0tYZDlIZ1llcVFLaU00RlBIRG9BRGlPRHJibXdXUnExbHl0TDVOcUN1T2Z1?=
 =?utf-8?B?MHUvVFkrQ2lWYVBLYW0yMllSWDJPTXdxQTRTTFdESjNvdXRuSEM4Q0dyK2ln?=
 =?utf-8?B?a3BMeTAwRENCZ2JlUFhnSlRUOEZMNkl5Mzh1dlBSOWhKUXBtdUszYll3eTBG?=
 =?utf-8?B?ZlhYVmVPdVNQTUczcElyQ3JNV0RjNEgvRUF3NzNUYkkzL2liTHUraWpmOE1o?=
 =?utf-8?B?aDFRNGdPVFgyWHIyU1EwcU92aUtWNjhsTFg5OStMa2V5Z0UvYlExOUxSYXkr?=
 =?utf-8?B?eWFUZ3BTV3pqTmwwd0MxRFJGMTBiYkJ6cWNCZkU0WnZiaGo4aWVCSTJxK2pY?=
 =?utf-8?B?NHhndVRPYUhPWWpxdk81Wnl1R2VWNzhSazNQblBCZmFWbjBuOHFTY2tTYXlz?=
 =?utf-8?B?TlhQU2ZvZ0J1LzVqQ1Y3Vnp0dGdMRWx1VE1RSUxBY0o5STIwckR3azVwSWtN?=
 =?utf-8?B?eUp1dWpsbTVacjlWRXN4Q0ZXa1NNcE1LR3pyRENKNURtZWVyS1I5NGhJeHRF?=
 =?utf-8?B?ZEwwT1F1cHdnenRBa0xIOFBGMVQyWHdnUk9hdCtha0NMTndvb0E5RzFMbmY5?=
 =?utf-8?B?aXZSUTVzTmFRdEpFdmkyT3dmekJCanZDd2JWbWJ2K250ZWNaOUIzVHluTGdC?=
 =?utf-8?B?M09VQlN6aXZSZWJyVTZGeGxidG5yWmRjdlhHZ0JqYTZ6VnU0dXlSbFlQbXJX?=
 =?utf-8?B?M0I0b1Yvb1IvTDAyQUU5SmRkR3RzQ1dmeWh5bUhHY1FzN2kyVy9jYWlWMnRU?=
 =?utf-8?B?SXNwTk5KbXRtdDY0aDVXNUxxOU9aeDBaaXpWbFhiaGhIdDRZMFNHSysrSUdL?=
 =?utf-8?B?Z3dRWWdrQ21pWEtVZXM2aUI2Z0ZCcW9mZ3VZUndDcy9XU3ErTUQ2RWJPdGtC?=
 =?utf-8?B?WmlHTEpzMlRhOFFqekF4T2dabWlEU3labyttTHF3eVFiRXBHWkIwNkxoMXA3?=
 =?utf-8?B?N3NycnRyYUUzWEprUGM4SHlyM201OWdCdGdjVk4zRHdOMFFzb2lyczB4VVJ2?=
 =?utf-8?B?TnJZU2h5UXhKTnE3QzZKVjJrV1Vrd2FTZ1VFYXNGSi96aHBOVEh4dFZQcW93?=
 =?utf-8?B?NTFpYS91Y1MyMWNqNVhNbE1jT3BBZEQvYkk2c2NJQkN3b2ljY2VxaFlwYnlV?=
 =?utf-8?B?bWYwTWZ2MFRJZTkyeGtPUmVpRnQ3YVQvd0dtUG1iTmxDSUFqaTVMWVJLZFRZ?=
 =?utf-8?B?TjJrckRmUWc4c3IrdTNTWm5iRFZVU3k2UGdRNUkxaXNwbXlEYWZaNlRocUFi?=
 =?utf-8?B?SGZGTTJ4bVlFQm1GY1Z3NDEyU21adXZub3BaanNYQSsvWEphdnUrMWUxSElL?=
 =?utf-8?B?TUQ0OG9UdjRHUTNxSTEwQmx6ZklMcUlyR256Q2haK1hQRElJc2N0eTVQeTRV?=
 =?utf-8?Q?h9bAFRgjbZ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTBDa0JRaSt6VDFyTUJtaHpoMzVIQml2UUNDUEZGYXMvc3hDZzdVQW5hNTN2?=
 =?utf-8?B?UzhDSWhyL2pMbHNIMzdBaWlBQ2x6d0NGQVF3SzcyTlJtTzNTcG9GN3YzSFl3?=
 =?utf-8?B?aTBCV2k0blBvbEVySW1vRFU1ZFl2Y24zaVErMzJGeDg1aGgrbFpQdlM1aDFI?=
 =?utf-8?B?Q3pmdThpQXJEcHVwQWF2d1N3QTdqMCtMZ3JIcnFDVVJFQnBlTkxHMzEyQVh3?=
 =?utf-8?B?Z0ZnUDdQMjNCQ3h1QW42ajVIQW9PelAwTnlKUmdyK2toUEczWUZET3d0M0pY?=
 =?utf-8?B?bWQ3UGlXODNkbXZJSmlINzJpRGQ2Mi9VZmRoa0tNV3luRkpEU2ZnT3g0UEx5?=
 =?utf-8?B?TGluVXE3UWVMQ3dZWDVVLzJOZFhXenQ3Rng0VHZ1VmN6dWtpeVkzVzJXZWEr?=
 =?utf-8?B?dmxCWHBKdXFZVyticm9FNWJNRzlrRXl3R09NR1N3anpvbk9PODJkMVFobndU?=
 =?utf-8?B?SkNLZXlCdko0UTJpWC9PK0Q2TUdhL0Fwb0oxQ2JneG96OVE2UWFzZlVIWWF4?=
 =?utf-8?B?ZGppdEJxNzAxZFpHQk9jODBoM3VoRzhnZXN1U01JQmVFOVA1bXM0czZQcGRT?=
 =?utf-8?B?aXFSdjRBY3Fzc0UrR1RVNjlUNW14SE96T1NZeWUrUTZwYit1a1E3RHp0VW9L?=
 =?utf-8?B?QnNNSldERUx1MHBleWI5T2xpS01ZeVRGWjlkb0YydUZMcDdoMEY0M3hXSUdC?=
 =?utf-8?B?cktlaGpuL2JVQWo2SDJmanNsK0pNMEc3S2hXRDB0MHFzeEVLUkxOZjZZUCtK?=
 =?utf-8?B?cDR5NzVaWjJueXlGRUZJR29BUkx4dktSaEhKMjlBamU2UXlnUVlNK0pDTnRK?=
 =?utf-8?B?Z0RpNWFIajhYN3hDcHA0WlVQa1dpSEFROW03MGZhU3grTVdBeDNsVlRqTzJH?=
 =?utf-8?B?SS9jQXRhYWsxUXMzMlZndDFjMHBOcUhra3BHOWhrMFF3bldCaERUZENKY1Rq?=
 =?utf-8?B?bzQ2MmZ3MURoNEVvNzJTNkQzS3lBY2puTUZ6ZFpZTElHOU9VdENKV1FCZEwr?=
 =?utf-8?B?Sy9DNWhDOW5XRnhCTEZrdnVISkNWaUhvM1RxT1dxZm9jcy9GWWEzeDhTaEVI?=
 =?utf-8?B?WGpkRHJTWi8rWStBWVNvN2thMG9XOUdMdG5IdC9VamprUGpPMk9WMkRWSEF6?=
 =?utf-8?B?OVZ3MmlVd01qZlBOVmhNVXpjZUt5amsrc0pIdFV5YkVWcmZhOGUzc2tZMzZn?=
 =?utf-8?B?dFJOeXB5Rm1GeXQzOVErSjBjbkxwRE85aWI2dWc0NGU5R1pGM1UySHRMbG5Z?=
 =?utf-8?B?STBDOW1OMlJoUDdSV2VwcUp3NkxlSGhsZ1FsN2hZL2N1UnNHT3dBY29uR0FI?=
 =?utf-8?B?N2pocnBGeURJR0VjWFpWRVJzTE1HMUtxR1FqSnpXQXRLcUYrOU5ZSFNqd1Bx?=
 =?utf-8?B?VWxYZ3NXeldXZFFQbE1oZEpid3pta3R0aHJTbEVxNk9zVTlZQVdYdVVvNnJV?=
 =?utf-8?B?eWhVU2VTWDJhTys1a3BMd3g5NWRIbjF6RVNjUnRsSVQ2djNoNktqaFdpTjBU?=
 =?utf-8?B?MkJGUDhIWi9KSHYxeHJqNWplNXJyYnBoM1VtM2N0VU5aSHdnZDVqVnBXRnEx?=
 =?utf-8?B?VTB4ZE10YlhiL1Q0ekRMK1phaWxlMHREVi9zRnZWNWRWeHVibURJVTNoTVow?=
 =?utf-8?B?c1l1VG1yVU56T3dxc0EvNklXS2pZalZBSVNRQUEwOEROOGNjOE4yQXQ1dTAx?=
 =?utf-8?B?ZzUrMEdoUGRoVmRIQXJxVW1Hd3VhaXpMWC9hWWF2SEcwbkJ1YmlaWjI5MVZi?=
 =?utf-8?B?Z09LQjE5eXJmaEkyMkV1T2FNekdmcnd3L1lCTXMxUHJBcm9DRWdtVEZNMnR6?=
 =?utf-8?B?YkFxRlJaODVvT3pGdkorSVdQcGVWNlFrYldtSHhkR1lBSEpDSmYrVjE3anhl?=
 =?utf-8?B?WGx2R3ZIUGFzTUlIc21DdzhmaU94R09Pa09GLzErdHhXeDc4cGxtNW1sZ2cz?=
 =?utf-8?B?QWdIOGpqa1JOUEJwT2Fvd3czcnBsNmVldEZ0dWVFNS9BdkE3bSs3dmI3dFhQ?=
 =?utf-8?B?NS9vNGxSK0F3aDZBUW9CekxBK0lYdGZ4OTVWc3MyZnR3SFhpYTA5aG9qdGVi?=
 =?utf-8?B?T3drN0xyNmJiZHhYMEJrWW1qbGl2amFYMkkrK1QwQ1Q0TzRNeWF4ZmRZdWRB?=
 =?utf-8?Q?dC4jf3TU/84K8NMHafBEb37Q3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15298bb-3b1f-4194-4c8b-08ddc39940cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:15:14.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtY6ZpvD13iVj4omkOEpV8ypV899TtPvlJYZylB+KKw++RbMBS2sTqGdFDuuQS1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
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

On 15.07.25 13:50, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, July 11, 2025 8:13 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v6 07/11] drm/amdgpu: validate userq's last fence prior to
>> destroying
>>
>> On 11.07.25 11:39, Prike Liang wrote:
>>> The userq requires validating queue status before destroying it, if
>>> user tries to destroy a busy userq by IOCTL then the driver should
>>> report an error for this illegal usage.
>>
>> Clear NAK, destroying a busy userqueue is perfectly valid!
> Yes, the firmware should handle such case something like as preempting the queue.
> If we directly unmap a hang queue and may further cause the MES firmware hang up,
> so, do we need to detect the hang userq here by checking the userq fence status and reset the hang queue before further performs the unmap queue?

No, waiting for the last fence should be perfectly sufficient since the hang detection is separate from this.

BTW please remove the 100ms timeout here, we should wait forever or until the hang detection has suspended the queue and signaled the fence with an error.

Regards,
Christian.


> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 81fbb00b6d91..bcbe8d3f66ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>     return r;
>>>  }
>>>
>>> -static void
>>> +static int
>>>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>                              struct amdgpu_usermode_queue *queue)  { @@ -
>> 290,10 +290,14 @@
>>> amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>
>>>     if (f && !dma_fence_is_signaled(f)) {
>>>             ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>> -           if (ret <= 0)
>>> +           if (ret <= 0) {
>>>                     drm_file_err(uq_mgr->file, "Timed out waiting for
>> fence=%llu:%llu\n",
>>>                                  f->context, f->seqno);
>>> +                   return -ETIMEDOUT;
>>> +           }
>>>     }
>>> +
>>> +   return 0;
>>>  }
>>>
>>>  static void
>>> @@ -509,7 +513,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int
>> queue_id)
>>>             mutex_unlock(&uq_mgr->userq_mutex);
>>>             return -EINVAL;
>>>     }
>>> -   amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> +
>>> +   if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
>>> +           drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy
>> userq\n");
>>> +           /* For the fence signal timeout case, it requires resetting the busy
>> queue.*/
>>> +           r = -ETIMEDOUT;
>>> +   }
>>>
>>>     /*
>>>      * At this point the userq obj va should be mapped,
> 

