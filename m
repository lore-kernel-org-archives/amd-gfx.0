Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB2CEFB7F3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 04:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A63310E270;
	Tue, 24 Feb 2026 04:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F3NyxWqV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE8710E270
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 04:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOEr+O5G2OEoVDnz3LmvbRCdnZYNNhb/PPDLTJAG/DgfdsdemoGah3tfxZXhc80gKzPWbpGlyGLqBXRUUJuf6urdFhuyHmZ4sD/oo+Mj/xK78cu+e9Oq/AghiQsnEyQ87S3MJECiD0c6DkGz4DIJHonnEXwQb567fr9xagf7Og0noV3pGN/1E5HTITZ8WjxAB1IcBeeAgckDRoAQukQ7YXg4VrKfB9+Nc2eP5HH1qbtl2kW75dY/MBqzac+kiUJbJanr0xNABXZCp7i9GMZ/G3q01IwbAeFRyyktDPv5OMQ90wkapqoLmUtFVLCJKMQaiuyoNKwTibBtT9ePsYuAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPhT8tESxSw0oQmsyKkUWhsgyzkFzGmzfcmH5ypZI08=;
 b=jGuC/b3als6JK7xvBwv1Yi8P+bd3f+9SdqwvyFGQ+Y4GzmaUPRBTgNGWCtsuIJB/Z3OGPcFmlBKSKTHTNeyq8FcgqVyFezXyzOaQT7iEqUt1E4sE8M5Z/+Dcw8MZiIekxrVUHzH7RJrvjed7EvMbh6cWiHyXrb59DhKVyI7Qvaj3GJaf4K8/Zn6XYjHHcfKidPvTra/ytbp+Zoa8VlVkrVAmZp7/5QIzFtyy+Pc1Fmdejls4TERuUdkIu4AxOiUmh12y6okxX44/ldgZTCA6a5URfOXKyqcpKJRTPFALUVCbrsIwNBflz1k6P65M7CjM1dRANafVaAKAzVi+/HrAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPhT8tESxSw0oQmsyKkUWhsgyzkFzGmzfcmH5ypZI08=;
 b=F3NyxWqV1vyl1DXjpDxDe5HXGCQCRNea/fuGLE0p4epBFrLKTyK1hFcuTG33nTwabkNOLK7fytqhgoxt7V9CAd3u3qOwg/jkZ3AqDyjGCzdA1z/+r8xmXP33uYwaNPwdBfmSXIJT0JpTvCtK3wmcjXQMUS0KtqBVN0rusAh+qpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 04:25:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 04:25:46 +0000
Message-ID: <8d69c6bd-a214-4b3e-8602-c68343582c5d@amd.com>
Date: Tue, 24 Feb 2026 09:55:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add an option to allow gpu partition allocate
 all available memory
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260217162424.991875-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260217162424.991875-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: c00a9988-e9c7-4368-9c8b-08de735cc79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVdHQU9wTlhVeStlRnFybUdJc2psL1B4ZjBQZkhpaUNTQzcyOTZtU09MalB4?=
 =?utf-8?B?c1Z0NFcySkJSTTBLdUlQWTBrSEEzSFlhclBBNnJsR0o1M3RoZHZtK3ZpVHkw?=
 =?utf-8?B?cTJRak02c2tGV0JBVEhFQWdEdjVCaDZNeUJQZjlpS3hBNzZMZVh4NXk5WGs0?=
 =?utf-8?B?c0VuUExBS29PRzgwWEJ4dnN4SlUzQy9HREphSzI1Y0M0SnFLY3ZDcytPY0dQ?=
 =?utf-8?B?eHQzQmtYNDFOTDBUVktmUTRJUVUzWUZiMnk4N0pZTEFoM3dOL0V2czJxT3ZX?=
 =?utf-8?B?azVmRU81Tnczc3JnVW1sUzZnNTZyTVJzOVN6WkFPdGtFV2l5K3A2K2hzdm95?=
 =?utf-8?B?Q0phRnpOeE5FQy9qbXlmdktPTDJWUnJzOXNhZ0RFZ0hlM1VaNmhBaUtld0Rr?=
 =?utf-8?B?cVJlNGR4VkhDUmQ5QWRGWGFEVU02RmpuR0hXYXZnaGgxS2prdElXdGdRMVRK?=
 =?utf-8?B?OFpNMURxTGViT1hYUVZMNWp5dURmRUJUVnVVUEVjYk51MGZwKzRZWWFHVk85?=
 =?utf-8?B?Yk05MFc4ZE5JUWRjc2NiTG95QUIySmlqSkt0N1paeWY4Y0JyK29IZFdRMmly?=
 =?utf-8?B?NWJCblEyTFo2WGkwUU43cStoMzhoSDNmM1FrWUx5YjZYdWZmeEJuY2pKNmFM?=
 =?utf-8?B?dnZhOHJNbFIra0pWREJHNm9mVUR6VmFZZzFwUFk4OElpS2R4SFRHVGRtRytF?=
 =?utf-8?B?QW90b0wxdkRCK3RHTnlTeVlUMWhtaE0yaDY3NU44RGEzSnR5Rmc3NWFrVXcz?=
 =?utf-8?B?QmZKZUJyNXpqb3pDeFM4UlBmSUhJU3J3L3NFbE8wN2ZvTzNpbFhHNTdXSEF0?=
 =?utf-8?B?S0RYK2k3d2V5YzlLUUtSeWsvTmNHOFVrQXRNYTJtRFB6Q2tSUmI2WEt4Z295?=
 =?utf-8?B?NEZBY2lXajh1L2VONkFxN0k2TUQ0Ym9IWEljL0tINmIxNlBmUktHMjA4WGpG?=
 =?utf-8?B?cnRidnllTzg5b01VSlZvTVRXZTlBMjQyVCthZy9yd29HTWx0Z0dFYlMvQXR4?=
 =?utf-8?B?KzhFQWp5dmVsNEVXajV4cnFMQ1JvRk9zRHJ0b3JvdEZYSHJkaVdKeU5peHFj?=
 =?utf-8?B?Zjk5aVVnaEYxZmEzZzd6Z0F4a1lZdUlFSy95Q0xkRFBJL054djFVSjgvcEJs?=
 =?utf-8?B?YkZ1Lzk4aVFpaHJCb0hCK09YaVJTbzZUQjEzQ2phOGs3L0s0TzV0ZURXaGd5?=
 =?utf-8?B?NEtwSGkzUmZJUElnekpSckFIVjMzMjB1aTZhRkxGa3pyWTlrZmY1VzhBc2ky?=
 =?utf-8?B?SWl5c0Zvc0F1RFdXZXJpSkpSaFNYRnNhTGF3RURlSkgxdWlHUVBzQUZNZ2lq?=
 =?utf-8?B?NHh3Nm40SytiSCt5R2FmQktQemRna2hSU1dyS3hxd0dCSEtTUTYxbGZ2aEJP?=
 =?utf-8?B?OFJqd3ZLL0FSMFJ5WFVobmRuZ294dU52d3JWM0hLWENOOWorVWxrMHRCay9Z?=
 =?utf-8?B?UGFWbEUrUmhuODFBMTV3eTQrWk5WRURNRkNFZnJhbitJa0RCbFRYTlh0TEVw?=
 =?utf-8?B?TTA0a0l4MkY2NDZNc0xwdHhKQU9INGY4S3FKdEhRMmZBeTYwL1B0ZEFrMjFN?=
 =?utf-8?B?THdGTHVkK3NLaTI5MHc3U2tPRE5oYmsrUjZ2eFU2eWt2RzNKOEJmWU1jQ1NT?=
 =?utf-8?B?NGkrZVoxVi9MRHJNd21BNXdMMHFTaUF0ZVhHSFp6c0dybTRQS2k2aVJsTURn?=
 =?utf-8?B?RHppMlBpTXdsL1ZjYnlnUEo0UVBibXh2cGRyZG50SDkvRHlhcnlTdmNXY3cv?=
 =?utf-8?B?cDlWS3o0cnpoRHJhY0dtVTlUeEdrS2lRM3d1VnJVSXorSFA1cWYwSTYrV2dR?=
 =?utf-8?B?V01KdktlejhUMTdLYXJTeXJJR3oySFJtaVRIUll5OS9UZVUzS3N2b0RNcytw?=
 =?utf-8?B?b1dCUzM2b2xjSC91UzhURzZTOE9xdGtyU3haM1VXNEcvVEhGd0ZhRUtwNGJ0?=
 =?utf-8?B?NXRPd2E4ZFdha3p2SzRrdHY4eG1xOEV1TUpDTWdKNGNUcmZieEVpcEZBZ0o5?=
 =?utf-8?B?cFJsQzFDaW55Nk8wbVBLR1ZZV1V1ZG5ROXphUVF6eEVvZTZRVEY4eG9CbzJC?=
 =?utf-8?B?anhKdW50M0pyNFVDMHUzczBkb05VcWZPeE9GYlM0UjV0TFkrd2VGTmRDV1VG?=
 =?utf-8?Q?x4HI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTF0ZENHaGJ0MGdyQ1Y2cVRsYWVxRXNFMDhJdlVnK1ZVQkE4Wnk1bHlkUThC?=
 =?utf-8?B?Tmc1a0k3dHh2cC9USElEb0s4MmljQVk5MlRCWDlnU3ZhMGtKazZBVTY2UUgr?=
 =?utf-8?B?MVhDN0NMeEVUR1JkTERycGNhK0FzcG0wanJsNnZOVWM2eVhObjA5UkVZVU0y?=
 =?utf-8?B?bUhPTDFkcng2ZlNHU0taQlViNUc0RDZXOGQyWm9kZENSbnlVY1VqWm5KRU84?=
 =?utf-8?B?K3BGazN4QWhYY1Ayc0IwOEM5bVhld0loOGtZL0RFcHluVTl4U3Z6M1JvMFdt?=
 =?utf-8?B?WDlRQ1ZHL0IrbUQ1SDJGSWRDdTJta0dFZEdyc1g4b01WSGxPcWFJU3Q4WWIz?=
 =?utf-8?B?WjNYVllXczNXbEI5ZFJEaEhyZ2tqS0VxVTlGazR0YUpBRG1ya2l0eEtQYzZ0?=
 =?utf-8?B?WkwwOFhmcFJkOE9Ib1BaZU9oUnk4bDBVblZ0cnNiNDgxZXBOVTlacUdEUGxm?=
 =?utf-8?B?cXY5ZG1HWXpJYjJQd0E2alR1S0VGa1RaaGpwTUVxbm1ad2JMd0pIUkVWeTNy?=
 =?utf-8?B?U0JQVktza3o2UWhIcmUvUlBvRzU1QkdKUGszbU9kZHBTL3F5d2k1Rm9Ucm54?=
 =?utf-8?B?NjB3cUQ5RXdHa2lOTUpDSlZtU2tFTXp4R0xqd3g4dmY2b05nb0I4VElEN202?=
 =?utf-8?B?RHVHVGxFOCt0NGYzaWlrY1AxTWtOV1RTZU5kREpNMEhaK0FSVE54ZzlLMVpk?=
 =?utf-8?B?djlPZ1Vsb2hLTlBmSVhQNU9YZVlXS1pIZUF5MlJINys0U2RROFk4VkVZVjZ5?=
 =?utf-8?B?MWxGOWQvVmpGUEdCUFRJVVlaVXM1WGVGVUdkczc5UUQ0cW40YVdiR1BHcW9R?=
 =?utf-8?B?NS9NWWVyN2lxV0U0MVp6V2hjK0tnaHo2Q1RON2tTMkF2STFyOERCVlZCZGZ1?=
 =?utf-8?B?TVZTYWpDODA5NTVMNTRpd0NWRTkvbkl0T25TOXFKVjFBcFUyZWtMMVVJWk4r?=
 =?utf-8?B?SW1qaW1LS2x2eFNLRHJrVjU2ajRRaDkxdDNDWlFXNndQSGZDR08yRUhhMnBi?=
 =?utf-8?B?VUZHTTlrWmtBSXJMckd0L0krOW1xUEZFeTFaSXp2YitLNjI1RGtKRUVvRXNv?=
 =?utf-8?B?Yms1R1RWUVRuNVV1QkNlTUduSGx0THhjZkhqdUxnZmVzRld5VEVOWkYxd3hh?=
 =?utf-8?B?OG45dVhpQ3RFOUVYN0VRdUxLOGlCczZqamZpQ3lyMlNwc2FUQjRPcjBQSWVD?=
 =?utf-8?B?eXVWWnZxb2kzblg4MEdWd3FHTGJvQnVScHZYNGlST0tXUnBJdE5lN1RyWlRH?=
 =?utf-8?B?VTNJTmhkV2pSK0dDUVZmd29ZTUNsODM4dnhleEV4bExFZ3FGZTE0ZHZaaWs5?=
 =?utf-8?B?NzFRdm5hcndDNEF2N3NCbHRsNlVFZnJKRWtPTFdvVFNtYUxUWGxUbThWcGMx?=
 =?utf-8?B?VnQ5WUNzbzV2QU9sd0p6U01qazNqeGVDeTNHL29wMDVNVkhzZjRmc0NLd1F4?=
 =?utf-8?B?VHlzNWRuTjZGWlkrT3RLK21aaWpKdU54Ulkza2ZnOS9uc00xbHRrV0UrUEJI?=
 =?utf-8?B?N0xKSkdhNU9jYUYwVHpNUXFJcHdKTUJxUC9SVzlzdkZqbjhIWUh4OEV3eEg3?=
 =?utf-8?B?VzIwOEpIa3MzdG5BaXJzVUQwcmRGcm1ON0lrK1hTVURKZEg3bFIxcE4xOTJD?=
 =?utf-8?B?MU9sdGxmU0RKcCszdUdQbWhrUG55a05zZTJ1YlZQTXFuMGNCTE1HWlp2SUlL?=
 =?utf-8?B?NjIvUVF5K2NyQlRIYmkvaklmRUpUQ00wM05mQ0xEMFlGUjVuRWFkNUFydm1S?=
 =?utf-8?B?ekIvUXBsTUpFT0lSZjJ2MnkwKzF2TGhpMVpNOGJ6YThmWHBpNk4wMW52aHd2?=
 =?utf-8?B?WUVBR25Ra3hCUklZZW5ZTUxHWTNSdVBKK3VYazBmckQ4a2tnb0VKQVlMSmd1?=
 =?utf-8?B?WEhvdll4N1FDWlFPdXUvdnE4K0Jkd3pDZmlnT2c1aXl6WlFQTitQTzJvN3RJ?=
 =?utf-8?B?d0lnMjlzVXJnYkp1WDFjQ2NvcndxVmxhaUdIYmc0MGg5YXBic3d5VnhXLzFF?=
 =?utf-8?B?eXlvZFlBSTlTaHZkQUY3eUpjMlQ2Rlo2bjRlTjYzMVo1ZzE2T0NweFZxUzQr?=
 =?utf-8?B?RGg1cnZMV2kzMXRsajYvOXRhbGhpM0ZQWTM1NTRvdjdId0JXSDZFSVJ5QU5p?=
 =?utf-8?B?aUZ2V2s4UkJqQW9reTNHMUJBeDNsc2pJREpFbnlhYTZtY1B4R25tZENaeGVw?=
 =?utf-8?B?d1FCc1MvRGM3RzRXSjdNODMwbkQ2TENCZXgwcTBEN3A4ak43OTlYTG9iME9V?=
 =?utf-8?B?dlZxWkliV0QxY2NzUm5INTdBY1I0UW9NalhQNmZ1QkhTcXJUYVhJTHpZMWhx?=
 =?utf-8?B?Y3dSa3UrWm1QTWJWOHdkNC9HSlZnUUJhaC95M0J0eFk1MU1Ed0tmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00a9988-e9c7-4368-9c8b-08de735cc79b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 04:25:46.0235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OKjiPEccRc62psMWOr26tt+Dr9k0KgsWbDSn2SlThsaf5VC0A5YU/e1LJ+IGW99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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



On 17-Feb-26 9:54 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> Current driver reports and limits memory allocation for each partition equally
> among partitions using same memory partition. Application may not be able to
> use all available memory when run on a partitioned gpu though system still has
> enough free memory.
> 
> Add an option that app can use to have gpu partition allocate all available
> memory.
> 
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
>   5 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3bfd79c89df3..006883c31342 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   		} else {
>   			tmp = adev->gmc.mem_partitions[mem_id].size;
>   		}
> -		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
> +		if (adev->xcp_mgr->mem_alloc_mode == AMDGPU_PARTITION_MEM_ALLOC_EVEN)
> +			do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
>   	} else if (adev->apu_prefer_gtt) {
>   		return (ttm_tt_pages_limit() << PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb..1da46eeb3f2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int mode = adev->xcp_mgr->mem_alloc_mode;
> +
> +	/* Only minimal precaution taken to reject requests while in reset.*/
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
> +}
> +
> +
> +static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						const char *buf, size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (!strncasecmp("EVEN", buf, strlen("EVEN")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
> +	else if (!strncasecmp("ALL", buf, strlen("ALL")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>   static const char *xcp_desc[] = {
>   	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
>   	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
> @@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
>   static DEVICE_ATTR(compute_reset_mask, 0444,
>   		   amdgpu_gfx_get_compute_reset_mask, NULL);
>   
> +static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
> +		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
> +		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
> +
>   static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	r = device_create_file(adev->dev,
> +			       &dev_attr_compute_partition_mem_alloc_mode);
> +	if (r)
> +		return r;
> +
>   	if (xcp_switch_supported)
>   		r = device_create_file(adev->dev,
>   				       &dev_attr_available_compute_partition);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 720ed3a2c78c..f5713891f205 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
>   	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
>   };
>   
> +enum amdgpu_gfx_partition_mem_alloc_mode {
> +	AMDGPU_PARTITION_MEM_ALLOC_EVEN = 0,

This is not perse "even" allocation mode. This is more like local vs 
remote. The NPS region used by a partition also has implications on the 
MTYPE usage, hence it more appropriate call this an allocation from a 
region closer to the compute partitions vs expanding to something like 
device_global memory region.

Thanks,
Lijo

> +	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
> +};
> +
>   #define NUM_XCC(x) hweight16(x)
>   
>   enum amdgpu_gfx_ras_mem_id_type {
> @@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>   	}
>   }
>   
> +static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
> +{
> +	switch (mode) {
> +	case AMDGPU_PARTITION_MEM_ALLOC_EVEN:
> +		return "EVEN";
> +	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
> +		return "ALL";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 73250ab45f20..a2d50f90a066 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>   	}
>   
>   	xcp_mgr->num_xcps = num_xcps;
> +	xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
>   	amdgpu_xcp_update_partition_sched_list(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 8058e8f35d41..878c1c422893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
>   	struct amdgpu_xcp_cfg *xcp_cfg;
>   	uint32_t supp_xcp_modes;
>   	uint32_t avail_xcp_modes;
> +	/* used to determin KFD memory alloc mode for each partition */
> +	uint32_t mem_alloc_mode;
>   };
>   
>   struct amdgpu_xcp_mgr_funcs {

