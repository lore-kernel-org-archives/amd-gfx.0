Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33436C3ABC6
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 21:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700CD10E13E;
	Thu,  8 May 2025 21:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="336aglil";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93B210E13E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 21:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUTc+eq0N6ORWsFC+bXst2RPVA7MwP2KiPhmE4V41vLAyII7gcWVnPfTyU6T6vTYEUFNeOjrwf++ce5X2qAarTWpcNAYfoQh1MySVU+QsMUxtbTAs53cEh0a+8uUDYDYBEG3QrIh9Sb5bJxnKKSOeP/3h2v88SiCg4UaLBtxSXISxcbhVgtUCH0yUFm6ckV5gJDKD3c+AWX1SMc5kHfrIyOKv7HM5Q6OG/hGxll186qvSUdHWFtmwI04yuSN69J50Wojj0JkNPRgg5PvVriyan6CA2ehlaChojb8LihkTQtqnzvWjP9PTAX0v8WB7SErGjpZTltnbcDAvR0ZS/DA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MICkAs8otgsLfU7mzboyVb07PRZ5qU+7EBPqDCdMQsE=;
 b=QAgYfDohO2duJZtFtQ+d7/XQtVLf0YAilnBrdSHsmzu/Mta98Ws+GxUHq7mTTmAPWIllrnFV8XttTFhUcF2E6SRVvUjzNqUjyluIJc+lUK1XvRNPQ2LK5CWM5vJAyvpL1Wttp1VUVw5gQ7orhP3RXVc4IHKwTkm4Ym7gFO5gtr2N3NiYLpqIUZrQqFdNx/UuzdkYSFV57uqKipwMRsMvVNh8ziYpgzS+fy2mHo+CN/2Nifxg8iPiRK/fc3Z9+lD7dJjKwRZihw+t1gLTjbxpOqRbeOePM3uuypcrurPtEbkCXuLVsNnsD4TmhlSCYa5eDAzgkOf9V7WUYO924rCPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MICkAs8otgsLfU7mzboyVb07PRZ5qU+7EBPqDCdMQsE=;
 b=336aglilY3yt5lidjwkKQqADSLor4P3EWYfbPpDeom1vFEAZmqjM3PSKuYRIMQ8aVKtdEnElMKl19xk2KmBjLdE4IvCqOm5HJ463kd3p7Cy8Dlztdme3aVGL065Zi6iCv6AjtQvkn1+jfA3Lew+JWgXdtFYclmB4wj0N1iNGhZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 21:54:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 21:54:59 +0000
Content-Type: multipart/alternative;
 boundary="------------UdzxH7ZZwbFu9G2CvpJFibvy"
Message-ID: <cf8cb7d6-44a1-4732-a411-1caa7206b4f8@amd.com>
Date: Thu, 8 May 2025 17:54:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: jamesz@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
X-ClientProxiedBy: YQBP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3dffd2-f6c6-486e-726c-08dd8e7afa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U251UUorT0JmUTk2d3Vwc0l1bkNlTzZ6eEdtL1B0d1Z1UmhKaWR2UjJscTRm?=
 =?utf-8?B?RHZrSnFRRkJBR0Q2OElrWGZvWGpIdWhyL2J3cHpMZmJUTVZVMFU0ZE1NSk1n?=
 =?utf-8?B?UVlTYXpMaFlNV1dlcTZiQURIRTBYazBmS0JuOVVtUEpWeTkwUVpBaWtXZ2pu?=
 =?utf-8?B?WWU0RTdZMUhBL25QT3BoQTBwVWlGMHJKUit4WlhYTUR4eXZvaGpZQ0dXaFc5?=
 =?utf-8?B?TmxBcnh1VW1qc2g1R2tVTWJRWm55cUxueVNsS2t3aEptZnNTMUtVV0VFTkpX?=
 =?utf-8?B?REk5cjJIUGdLTU9IL25OblJNQ29ITkhmOEJBRS9yRU5OWk5xSitWT0xYZ0E5?=
 =?utf-8?B?RUJ3MjBScmdUOWVjOEhUbC9Bb0I2dVFCUDlYNmx4RUN1cXpzRUkyWU4veTVm?=
 =?utf-8?B?VGNOVGZWVGFXOXZkV1lQZVBJMjZ2azNOQTdCNklvZGVBUlNJMXRhM3RFdGdI?=
 =?utf-8?B?b2EzNFc5RG5GL2Z5WUZsa2M2U08wdklmYm9wZzFNNWtNaG5GR2VxMDdwaDBw?=
 =?utf-8?B?UmRFbGxJQUJpbU1pWUVsWkZhaTJFTjVQMjNWa1dQK0piZ1JCZzJRby9qZHF0?=
 =?utf-8?B?dEdRU2dvYmlLRGhnWjZKT2RGZjl2ZElTb1BqS29tTEJMT1VhWEljQVlsWTVt?=
 =?utf-8?B?VENmQ1VRMmpCTU5BZXRBMDN5dFpKRnZRYlJqcVJHOHNUV3B4L1JwY29uaE5s?=
 =?utf-8?B?WGl3aFhCTDlTQVM1N0JYWTNhdWFRT1F3LzZIYUZpY2JCSjFBcWtWbUx0Zm92?=
 =?utf-8?B?YUx6eVVEOGhNdUlsb1VwMGpTbGUrTFlxbzB2RGZ3bnNvYk9QU0NweG5aWnZJ?=
 =?utf-8?B?dW05RFBWSG1HVDQ4SnBHbDc5TDI0NXc4QWxGY0JTWjJMSWZwcy9EU3BtS2Vu?=
 =?utf-8?B?ay9rRXdvKy83OGdNdXIzaXR2aXlmeWIweER3Vm1hd2hlcGk3eTFaUHhIeElK?=
 =?utf-8?B?RUtqa3lZUlo2dEpkWmphYzB6MTRiZnRPS0FRK3ErYVN2ekt4Wnl3WVBVY2ZU?=
 =?utf-8?B?aEszWUo1NU1LZjJ6OVkrbDUrRy90Zm5XMWVEK21CNzdUUHcyajlQZCtoK3ZX?=
 =?utf-8?B?bHZkMUc4RWJGSzNwWFpjN2N6c1c3QjZ6NTBCdkhad0l3SnBOaGJvRGZ6eHBm?=
 =?utf-8?B?N3JkT3lyZmhUTHl1cVNuNXFsL25wQ0VZdTU4NXRPbng5OFBGZ20vZm04VHFU?=
 =?utf-8?B?ZjB1Vk5nNHRDZ2kvaUlBbzFCRUlmZ1NVV2tsemRoQURudGx4YXYvdjRzd2JM?=
 =?utf-8?B?UTVaZWt3aE02OU1VWGJ0aVQwT1dpZEs1MGFZbG8veEROcUdQcFcyRGRKUnpl?=
 =?utf-8?B?YzBBRWtFWDdBUTNqSElUbnNheXNhYnB3UXNCbkV2eUJWTWRvZVVpNmJlaWY4?=
 =?utf-8?B?My9IVjNTTFpEU211K2pRSi9CWERmNDhKOXN5UjE0SWhsVVVERWNHLy9aMDlY?=
 =?utf-8?B?YVdkOXZwTXQ2TjhPbVgydExpM0RpUG1PTTIvYkxSamZrZGRJQVI4dmJ2YzNl?=
 =?utf-8?B?VVdkT3VZQWYxbWVBT1c2MWN4dGprbzkzTW1YVSthNU1NUlNnaFd1Vml6YTlW?=
 =?utf-8?B?K0NmbzNvejZMNGl5R1ViNU9MUmIyQldLUGF3bnhiL0hjcWtRWE1nZDJDUVll?=
 =?utf-8?B?U3JybHlrQ2pJZDNmMjJUZExJaGFlS2xWVVhoNmoxa2h5K3hucG9sTldjcEYx?=
 =?utf-8?B?NjFVTWxVdlZMd2hGUmY1UzAvN3dKNlN6a3NxTWcrQnVRTVU0VGJtMkl3bW92?=
 =?utf-8?B?d3hnWDFLOFdoeXVzTUZFaEpLYU13dWMraXdIVjIxUHZmMWhORVhpNlhTV05R?=
 =?utf-8?B?T2FRTmlwTDYvdXRQemhVVVJaL04zYVZuejdWVDMwVDY3Q284bURLalVONnow?=
 =?utf-8?B?TDhidEFHVmFIdWxPMW9aWk9WSU5zZGdlaC9yaTBheFM1eGtpdG5UWnRTT2c2?=
 =?utf-8?Q?Vk0QpzEIavQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3oxWFJNMmJQcUlEUytVNTR0alptc3M4ZlVGdjhvV0dPbEF0Vm84NEIvRXg3?=
 =?utf-8?B?TEQ4bk5aTUxiV0VJVVBtMG42UG5pUG1jc2V1azZpbG9WZ3ZtbmtRRmZDZDJM?=
 =?utf-8?B?VlJuUGVDcEdHYUVjYVhDdlFoYjN2c1hyUFpDV0xnZDdoQURzbEEvS0ZQbms5?=
 =?utf-8?B?R3FhVDBqZzRsbGM3TzJQVktlb0xkcWVEbkRrZ1IrTUNXOE5zRVdGc1MzNVpo?=
 =?utf-8?B?alBodks3bmNVTVpPcVZTaE5UNEtHQ2dTSnl5L2xKemliS0p5bllGNjduSFlK?=
 =?utf-8?B?NG1CVUNibk1KQWlSQlpFNElOdXdJSWZFcWtteHh4Q09lakE0TVZJeWtCL3Jj?=
 =?utf-8?B?OEF3ak1lcmJxeW8yczhIZ2h3bW9UZGZxZFdyeVA1M2pCZlpqTHFTaU5iZVlv?=
 =?utf-8?B?akZOelphY1YwRVBEVzl1bklpL1NLRHFTd3hwazZFUHh1WU44b0V5RUc2STZC?=
 =?utf-8?B?Ky9ZRXJJeTBtcSsrTGtmZ1k3RVltelp2UmlzbGl0ZWJwVmQ0NFFYK0NhQmp6?=
 =?utf-8?B?MnRWS1NhbS93dXlKa3hPZjQ2Yk1MS3hqYTIxdkMzTms3SklzRlp1UUQ3OStr?=
 =?utf-8?B?Tm1kbE12dDlHTkxzUXpYS0tWQThMNGxMaXZjT0RvRENISDlucTFkakVNRGxs?=
 =?utf-8?B?RjJyNkdyTXFjcjNzKzN6SmdxcStQVTNLUlc3OVNXUXE1UG84emJ4RUF5aEVU?=
 =?utf-8?B?NklXTzIvTDU2NTFvTVFTc3RYQXQ4Rk1xUnFLa1FmOWx1OEg1YTczSDI2ejlk?=
 =?utf-8?B?NDJRRmdML3ZRVUV1eER1QXpWNDZCYTJ0T2gyaklTb0k3dFBmS29adjlqdW1S?=
 =?utf-8?B?YTRUdE1zVFRzWUVQblZkVGowd1AvZGJMbFBleUFpT2JYSFRDTVd6M2lQSVJN?=
 =?utf-8?B?R01iS1BwUTYzUzZXb29hYWRqWm1wR2k1N0RBaHNvV2U3ZlpLcG5tWERFL0Yv?=
 =?utf-8?B?MFpzYXpBVDliNjNWcnB6czdnTVhJaW5zNnQ2czdiRHg0ZnFJaWxjUjkxMFBp?=
 =?utf-8?B?MlYyTjZzVld0cXYzWDlQMVhSRjVCUHorMkEzdlptaE90QVFqUmlwRE9qTTZS?=
 =?utf-8?B?ZmZrRk9lMG1LYmVBMXRCM2xwSjFDNm9QMk5sUlhrcWVydE1SSHQvR0ZKQmFm?=
 =?utf-8?B?ajR2VlFQTnlla1VuRXFzb3JGSWpIZGNDeDJZRzVuYXR1R29zVkdKNWRyRjAr?=
 =?utf-8?B?bjZtMU1yaloyTzU3Ty81b25RVVMrZm41Ti8rWFJTa0FUK3hneVpwbjVZOXh6?=
 =?utf-8?B?TGNTS1IwdGxGWkZsVWRKN3J2SnFoYjd4TUZKcGFUSmhBdnF6ZGxLSTdyaXRJ?=
 =?utf-8?B?K3laWnQwczk4NXFWVTBuOGhUMk9IMHFFQlBEK2J6REUzQ3VRQVBFVm5UOTNs?=
 =?utf-8?B?YUphaS9wM3hJY092VGp5SXNYS1VYQ1ZwMUV3NU4wSDRTeUZVVWhnZjZFVHU2?=
 =?utf-8?B?WktKK0czR0I5YWhOT2pOY21MOEpKajZxaGQ1TW9mRDAya3JYb1BXcDRxWHRX?=
 =?utf-8?B?QWt3cVFMZGcvdDZBK1l1cGQ2cVpqV3ZDUC9vZmgrakNXbjFLWnVjcCt6SURp?=
 =?utf-8?B?QXBLdmlWeUhvVmVEVklJem5Vam1zSjJkd1BscGFwVGo5QjVKRU0xV3FvcEsz?=
 =?utf-8?B?WFVzMlZBT3laQ21JTVpUOHhHLy93alF6QkhtYWlxQzlSL3I5TDdpVklVK3lY?=
 =?utf-8?B?VzhJc1lWeCs3N0tBSWkrcXVTbkpsbWVLWjgyanBndGFwRlJqdE1uRGIyNmJY?=
 =?utf-8?B?QUZkL00yd3ZJajY0YUtVaUJ4ZkxzVndHWlJraUp5dU9lL1R5UGs3Y0txRFlC?=
 =?utf-8?B?MnhyT0RWSytURnV4cGtqNS9td1ZCSENkUUg0ODFMdVRvNTBoYnVLRFNEUEw3?=
 =?utf-8?B?cS8rSDh6em9OemVwMEpXb3QxWENIeTFPWlpSdWlJQnp3WE51OUtZdk55WEMy?=
 =?utf-8?B?K2xJSEhsY0ExRW16dStkNU55a1ZXNGQ1ZUV4Mzd4dmhJdjZScTc4U2Q0bCtL?=
 =?utf-8?B?Tktjb1A3ajlFSHZvQ0MzRUJBd1NJUE14Zmh3Ym1xVm12Q0ZQekVZZ1Vhb3lU?=
 =?utf-8?B?WE1LU2lkRzR0eWxjWjdjYUxacXN0V1E3MXlFR0laRDdRUzJLSU5TbVJjSG9G?=
 =?utf-8?Q?ldrXmIytFGXxhFB1c8GMfgfQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3dffd2-f6c6-486e-726c-08dd8e7afa46
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 21:54:59.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5ir6Pl5uIFHu+BHtmwnXRX3Xlq2rmztqhTbd8AeklmU8fNZb+JAivgpJ8xi98RE//HMQNpR2eRLpiVk3eewhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

--------------UdzxH7ZZwbFu9G2CvpJFibvy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-08 10:50, Christian König wrote:
> On 5/8/25 16:46, James Zhu wrote:
>> When XNACK on, hang or low performance is observed with some test cases.
>> The restoring page process has unexpected stuck during evicting/restoring
>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>> 1. when xnack on, retry pagefault will invoke restoring pages process
>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>     B. if there is no enough VRAM space left, searching resource LRU list, and
>>        scheduling a new eviction work queue to evict LRU bo from vram to ram
>>        first, then resume restoring pages process, or waiting for eviction
>>        timeout and try to schedule evicting next LRU bo
>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>     queue eviction will be triggered.So restoring work queue will be scheduled.
>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>     restoring pages is completed
>>     step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>     until evicting bo is completed
>>     step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>     write after the above two mm->mmap_lock's read are released, and in the
>>     meantime which will block all following mm->mmap_lock's read request.
>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>     restoring pages request, everything is fine. if not, which means that the
>>     mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>     eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>     the second and following LRU bo's evictiion work queue will be blocked by
>>     tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>     process will be stuck here.
>> Using down_write_trylock to replace mmap_write_lock will help not block the
>> second and following evictiion work queue process.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 72be6e152e88..5f6ed70559b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>   {
>>   retry_flush_work:
>>   	flush_work(&svms->deferred_list_work);
>> -	mmap_write_lock(mm);
>> +        while (true) {
>> +                if (down_write_trylock(&(mm->mmap_lock)))
>> +                        break;
>> +                schedule();
>> +        }
> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>
> As far as I know that is not something we can do so easily.
>
> Would it be possible to wait for progress instead of calling schedule() here?

I could think of a few other higher level mitigations to avoid getting 
into this situation in the first place.

 1. Give BOs allocated with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED a
    higher LRU priority, to make them less likely to be evicted
 2. If that doesn't help, set bp.no_wait_gpu in svm_range_vram_node_new.
    This should avoid causing evictions when trying to migrate data to
    VRAM in the page fault handler. In this case, migration should fail
    and the page fault should map data in system memory

Regards,
   Felix


>
> Regards,
> Christian.
>
>>   
>>   	if (list_empty(&svms->deferred_range_list))
>>   		return;
--------------UdzxH7ZZwbFu9G2CvpJFibvy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    On 2025-05-08 10:50, Christian König wrote:<br>
    <blockquote type="cite" cite="mid:e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com">
      <pre class="moz-quote-pre" wrap="">On 5/8/25 16:46, James Zhu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">When XNACK on, hang or low performance is observed with some test cases.
The restoring page process has unexpected stuck during evicting/restoring
if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
1. when xnack on, retry pagefault will invoke restoring pages process
2. A. if there is enough VRAM space, simply migrating pages from ram to vram
   B. if there is no enough VRAM space left, searching resource LRU list, and
      scheduling a new eviction work queue to evict LRU bo from vram to ram
      first, then resume restoring pages process, or waiting for eviction
      timeout and try to schedule evicting next LRU bo
3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
   queue eviction will be triggered.So restoring work queue will be scheduled.
4. step 1, restoring pages process will hold one mm-&gt;mmap_lock's read until
   restoring pages is completed
   step 2B, evictiion work queue process will hold one mm-&gt;mmap_lock's read
   until evicting bo is completed
   step 3, restoring work queue process is trying to acquire one mm-&gt;mmap_lock's
   write after the above two mm-&gt;mmap_lock's read are released, and in the
   meantime which will block all following mm-&gt;mmap_lock's read request.
5. in step 2, if the first eviction bo's size is big enough for step 1
   restoring pages request, everything is fine. if not, which means that the
   mm-&gt;mmap_lock's read step 1 won't be release right the way. In step 3, first
   eviction bo's restoring work queue will compete for mm-&gt;mmap_lock's write,
   the second and following LRU bo's evictiion work queue will be blocked by
   tring to acquire mm-&gt;mmap_lock's read until timeout. All restoring pages
   process will be stuck here.
Using down_write_trylock to replace mmap_write_lock will help not block the
second and following evictiion work queue process.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 72be6e152e88..5f6ed70559b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 {
 retry_flush_work:
 	flush_work(&amp;svms-&gt;deferred_list_work);
-	mmap_write_lock(mm);
+        while (true) {
+                if (down_write_trylock(&amp;(mm-&gt;mmap_lock)))
+                        break;
+                schedule();
+        }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Oh, stuff like that is usually an absolutely clear NAK from upstream.

As far as I know that is not something we can do so easily.

Would it be possible to wait for progress instead of calling schedule() here?</pre>
    </blockquote>
    <p>I could think of a few other higher level mitigations to avoid
      getting into this situation in the first place.</p>
    <ol>
      <li>Give BOs allocated with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED a
        higher LRU priority, to make them less likely to be evicted</li>
      <li>If that doesn't help, set bp.no_wait_gpu in
        svm_range_vram_node_new. This should avoid causing evictions
        when trying to migrate data to VRAM in the page fault handler.
        In this case, migration should fail and the page fault should
        map data in system memory<br>
      </li>
    </ol>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 	if (list_empty(&amp;svms-&gt;deferred_range_list))
 		return;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------UdzxH7ZZwbFu9G2CvpJFibvy--
