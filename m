Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BC0C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 16:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE2910E179;
	Tue, 29 Apr 2025 16:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="du4NmzMR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B3A10E179
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 16:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY8oTWpI2ycdRbCfTTDx2+dv83T5yjIaaf+OgYNxYNqxjAz8nrrxpRqQ+Sl8fkd8PXXRYZpjPpY2FNW9gvzXqCijrXUAye9FGatvwDtJSXp10t5rvK5A7qeq2XJzu473eS98Z4siphvwk1RSJzOmvUd0XEm2PVNEO/wWPSUG6rw4C2qlSwa2tJnC02hDic4bT+M4KCvIfNid2OCJ19gxBhRCK2wckxtFN2q4kLDmGV/FGuKAovDY3fVA1hc6d/Uyjhqe56ZUpjKouRUgogUC49jKAYiuweKx0KNZn+9psgnutNN2/6ki4fYDWmVan8bPwlzdW+lANj6bz0KQuPO4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+C2abO0aLQtlhXJeEGFtI/kYfGGO2MGwzPsMNIWCIs=;
 b=mu7clTLT34qFKVXHdAH3M6PHSzkmCDVKAz2b/ZRi7rYWWpdEbVx+DiI5Z1O3xnoWgnipmV/t4RKZUhWNwtCbbA+5EqkKVYi92YaY/l2BKzaHAS8zuDnPA0pqkAb4vG8N0squHirpKHOqSp/rwk5F+/mu86vImpkTHLYtZlLqiDhwal04f/kz+gBOf+UOuclIITPrh/eYRBMx2GVyuOQA/XhnjjV1iNy6tekztIF0y6n3oJPi3op5MZg/TOZrjSj4aLRG8+a+lfOnpg3UX7pH3PcnLmRvhlWBgdP90/Or9/CHDvyt6lFXzgGJsawB3kMqwqXsVKJgf6zZULql6yv2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+C2abO0aLQtlhXJeEGFtI/kYfGGO2MGwzPsMNIWCIs=;
 b=du4NmzMRH3TjSmp2dVvpMCOncQfJjXxbZkRdPLnI2g5BHR7xswmxw1834lWyQxr03QSpwMDoiMuS98MFqAxEn8fCZYqessJSz46QRKeqEOeugQpJZHQAbhA/meqHnBInihMu0uwqTrhtILLfkKB7eS7B7ZwYmIzgZKKmUyBbmrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 16:57:22 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 16:57:21 +0000
Subject: Re: [PATCH v3 1/2] dma-fence: Add unwrap mode enum and macro for
 in-place deduplication
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250429152448.205212-1-Arvind.Yadav@amd.com>
 <a3dfe7f7-7ea4-4c30-abb0-93c5965b71f3@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <056f84d9-673c-50be-47d1-3cfff8f07b09@amd.com>
Date: Tue, 29 Apr 2025 22:27:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <a3dfe7f7-7ea4-4c30-abb0-93c5965b71f3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 20553ba2-b203-4f36-f3b1-08dd873ee88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnRHWDR2TGdvWkN1YU9aSVNXRUJnNWFWN2cyTkIyTDMxNE8yUktsU2xUZ3ZV?=
 =?utf-8?B?ZFpyNXJQYkt1UWlwY2FCTjc5Yk5WbmRrYUJUdkFaYUxnUkFzck5DMWJlMWdV?=
 =?utf-8?B?RCtveXV5QmtGYlNyWnhQUXM3VHRHNURzeCt5NS9SVmRzc1dmeThqYVhPN2Fh?=
 =?utf-8?B?bVpFd1hSdGkrUWVhSS9VejQwU1hsZHMvdk5pSEZ5QjVTcFBGNXVWTGdPcWJu?=
 =?utf-8?B?ZnhLTm5KYkgzNWMxMG1IWkdwbDhVd0lLV1RObS9UR2c0NHplMkQ4SkJOSXd3?=
 =?utf-8?B?S0VvekxjVmR6ZnNxNHE5YjJ1Wm1yM2FzZGpVTmVEN25qSUprbnBBdFRNZlpu?=
 =?utf-8?B?dHZYVzE2UTFsUFlqMEhzSDE0YkxYd1JYeTdBRDN4OTQ0SU1WVWJIbTVseFFu?=
 =?utf-8?B?eE14Vk0vUFFBWDZnTklQSjNBbWlEUFVVSE5KUEhpL2FrQ1VjMTdwRVNDaHNj?=
 =?utf-8?B?TmxzUWtnaU9GR3oyK2ExRTRsc1ZaV0ljbEdsb3NTNDlyNlF4U0xxTlZNNFVC?=
 =?utf-8?B?SFhvcjhFUWZVbGZSOFdpZTkxaHZVd2RMRnBoUXZJV2doMWRnTUFnVDF1K2hy?=
 =?utf-8?B?MDVPZ014RUZUR0tucmJla0hUWjAwdTZOUmRNTHRXdGF5Um5zNEtIWVN6U2ph?=
 =?utf-8?B?OTMvMUJhUFE1S1FxNVZVU3QzVkZ6Ynh5UHNlaWtnNjFSZ0J6UFNDNWNLWTJ4?=
 =?utf-8?B?RUxZVjdrVnVYMDhLWjBhT2RYdGFaRzllRlYwbVBCQU9Pb01yVkRYbEYxVVVE?=
 =?utf-8?B?RGxMenJKaUwvOGxZVXV3a29OektpK1o2OFM2WWlmelNtbll6aXRhb3lHNTY2?=
 =?utf-8?B?MTZ3bFkrQTBsdUJ6b1ozY0tINlloOTk0SndJR1FDZDdWUXNEL2t6eHZrSWtS?=
 =?utf-8?B?TVFnTDVKeGF5aXcyWTZ6bmpMbXZCZWhZSnJIazl6Wk84WUpNcnBBK3Q0WjNP?=
 =?utf-8?B?NUx3VW05dUEwczQ3RkZqaTNMNTRzOFJ6UE96SFVmU0JNQlBwdnk2a3VqQVJX?=
 =?utf-8?B?dDJNVk0vblpteWMvcnRpcEZ2TVU1dHJyTWYzQUFyMmtPMkFReGxzZURRYjlD?=
 =?utf-8?B?a0g4aWNNV0VrbUp6Y1F6UnV3YmxTTnExQWhoTGQ4dWFwZEZ2L0M2VXZwTnhq?=
 =?utf-8?B?SU9lUUtBYnljRDNmd21lM2svUVlxOVRkNFUzbWhFMjBLRmp3bWRaNlJUOUha?=
 =?utf-8?B?cXlXWUsxRW4xdHAvSlExeEJiV3huZHZCdVIxdWlsbm54cHIrbmJQdFhVZVBO?=
 =?utf-8?B?bkZCblpMNXFMNlRjMmFGTzhJTDBzUVRwZWFGSGhPeE1EVjd1N040cGNsdEFt?=
 =?utf-8?B?a0x3bVRVelJDMzdXQTdzWm9CYmpnNUovVk50bER5Tk56WE5jTE1aRnZWL0s2?=
 =?utf-8?B?UmNXcjV3dFpzNHdDNkhub2xMNmUxY21QNmttWmtOa0dzQVQvdjBaN3VZM2cy?=
 =?utf-8?B?ZW9KVHpWL3RvNDFoV0lOYUVrVUsvVzlSTGpVR2xzNFNWdnowbU03WlVSYkR6?=
 =?utf-8?B?MXhzNWF3NnF4WTM1L3NVL2xici9KN1hubEhZRm9RVUJaWnhOS0tEN1oyOEt4?=
 =?utf-8?B?Vm9BWVluTFNsblVEeUR3amo4Qk1jR2gzT0FQcWdZOXE5VW9VN2N1Y1NLcUlM?=
 =?utf-8?B?MzY0K0JQL2ZkSFh6ZW81R01DQjlBdGMzNjFMMStaYjE1QjNxdlhnTUx4bFRj?=
 =?utf-8?B?aWdDRmJGYXdzRTV4QzdHNWxvMGllK1NDV3Ruc0k1MW5YNkRMRDNkTERncUE3?=
 =?utf-8?B?TU1WQVhWbmhSblJZanhadFRmc01VQkxoc1JUQTR1T1FkUGtTdUZSOTRyY2Ux?=
 =?utf-8?B?WXJlQ2FVUDE5c2MvS0RvVFlNS0NBaUhIdHFmMGVGVXRhcVhtVmpLRnN3UTBH?=
 =?utf-8?B?UVBQUXZNcmNKQWlFYWF4TDRDMC9NazR4aW9GSGdnN2ovMm14RXZpaGcyNzFM?=
 =?utf-8?Q?g7a40laMmAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNMZE1RSHNRUkY2K3l1VktLQnBKMFYrbXVXN21uS1E4TnlPYnNJbFpaSU4z?=
 =?utf-8?B?SEpZNFFBOFNkbzk0VmdxV0VYb0NObUlaZk5FRU9WWkxXdEUzRzR6NmhkYjBV?=
 =?utf-8?B?RmdJd285TDFuT2dUeXJxbGlqQ3BXa0RrVlk0bW1NV0MyQmZLWURybDc5TThW?=
 =?utf-8?B?bmM1NUdsQVF2V09FeUNYWnJLRWVtcFZDeTluaWc0N2FBSi9oWGhjL3hvSVVY?=
 =?utf-8?B?MXJhdVVMUGpsOFdReXFHYnJUajVvMFBFaU1KMjM0clY3TE1Ga0J5alR1NSti?=
 =?utf-8?B?cWpHeXNua0lnSnZLZTJNaUpEUWo5RUFkZHVDM2R5QTFxR1Brc3VIN25jc3Zz?=
 =?utf-8?B?d1JncGVpQ0ZNd1drM2xueFZ6YjJPaTZMNmJrZ0NvV3ljSU9VRHBiaUZ3bHBx?=
 =?utf-8?B?QWZ1bUhOMHhxQnJmOVpRcjd5OGQ1L0VhQVF3SVdjVW9UUTJlMVgwNGV3ckFQ?=
 =?utf-8?B?ZEMwb1NkM2VvMDJwVmErTUVxdVNLekZzanAzY1lDcUdxWTdXMTVRRUVCOEx5?=
 =?utf-8?B?dHpnRFlUL0tCOUt4cGRjeDVLWHVSdUZHcGhIUkRhUnJHRnNHdUpVQnM1WXJl?=
 =?utf-8?B?OTRsS3I0anZkRXZuODVCZUw2L0dLWldSY1hXVXZhdnF4c0kxYmpUQUhmYno0?=
 =?utf-8?B?eXFyNGx3RWNuR1BQOW9aV20xTTltSldVSEV2WlQ0dWw3ekVHTmpGcGIxYVdM?=
 =?utf-8?B?bGtRdmRCSDNuTVI0dFFtUTJHS09OSXNmdDQvcVVDQjNtVDdsc1pIbjZ5WjB2?=
 =?utf-8?B?QXFzK1U2azg2KzR2bFVJU0NuUDlnNWEyREloRnozdWp5MFdVZGxzczE3N2RF?=
 =?utf-8?B?NFR0OGVTaUttYVhtbk5DWjZoMVFVSUc2cGVUbGR2VFFLWlFjNFFJZFdXT2hK?=
 =?utf-8?B?TGZsdWdpdFcwRHd6QkJpRVdsbW91ZDBreXh5SEdFK05BVHk5bXJMcWFEVGdo?=
 =?utf-8?B?ODdMSG9abkhScHZVc3JKWnV2dTlWN3A1NCtrdEQ1cU5JOEhzU1p5bld3dyt0?=
 =?utf-8?B?U0ttaUFHanVrWThVckR2amJtY3psZFZ6N2g5a0dFMFRiTXJzYUQrUlZVazRJ?=
 =?utf-8?B?c0hGaFJKL1FrWEJrNWFicDJ0Y1Awa3BGSjA2UFFpNVo2aHJnMzlCQkxWU29k?=
 =?utf-8?B?dWx3Q2dKeDdxOXRZRU5QZVc2YS9NeHoxalFHYWhTREFYOUtpUW8ycVpjNDJY?=
 =?utf-8?B?eWg5TFpWeG9HRDh6a1VjR3lmV2lsU3RwNHEwYXg3d2tmZk4wU3VVNzUxUHNu?=
 =?utf-8?B?aFowNktVdmdETWNJNUUxN2pBMzN3N1kzdmZxTDZoMWp4cndtb2ZxOEtYbWJr?=
 =?utf-8?B?MDVJZHhmSTZNSlhCRmd5YnJ2MnlnbGtuMGx3ckRyL3NLaDZVV3dHSnNmaGIz?=
 =?utf-8?B?VlZid2pTYWVLV2krOUNTZVpodk1xTU0xNGM1R3RkZndSOG5hUWlMSmxUUUdL?=
 =?utf-8?B?cUhLNGd4cVdDR2VwK1ppL3dySUVJNlNxVGJleG5mSkJnd0FYNE12NzF2cTBX?=
 =?utf-8?B?Q1dybmFYdFpYY3NkVlBiWStQeEkxbThrdWF6Y1UwMnlPWTZCbVdUT3ZyOGEx?=
 =?utf-8?B?QXFDYldxY0JJQWE0SkNZdFo3c2FoL3RlNWc1TUw5di9qQWw3U0hjN01KRW1Q?=
 =?utf-8?B?V0w2ODkxTVpLYUszT1d4RnVpK1JLeGRJbWw4ejk4NTVvR1RqQ2pOR3R2L2pB?=
 =?utf-8?B?c3Q4OUdIeFZTY2dwdEx3S0RHNGNLdFJDdVNSNWw5Rm1Zand2NUgySm1sUWhz?=
 =?utf-8?B?YjliYUZaMXp4b2JkSUVQZk8zd0JYOWl3ZHRBQU56L2FDYkZYL3FWV2NNQi9T?=
 =?utf-8?B?MStwajBmRXNxRktJMmlMbzlpNGRIQVQ4UHVzNnViU3Z3Tm1FcVJ2dkpDV3Z0?=
 =?utf-8?B?M2dQZUVPNGZXMWdHdmlQNXdQbFhRZCtyNld4TmVSZnRKOVprVld0WFFObTVj?=
 =?utf-8?B?bG5IM3NzWjFUaWdJeUw4WGFKRjNDMGYyRDYra0s0cGlCSWxFZG5WbEs2cHhZ?=
 =?utf-8?B?NjNmT1J5eGx1MFlLblcrS2hhSkJzNThZTnZBVzNhdXF5QjRCTElqU3VOZ2tz?=
 =?utf-8?B?bEJjM2F2ekVrSXR5d29PcUNBdXBHTUFDU1l5WUM4WHNPTFE1MFAyZDJYdnpI?=
 =?utf-8?Q?nrzjjhtiPj52QivRNvcqKbnFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20553ba2-b203-4f36-f3b1-08dd873ee88d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:57:21.8883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWyJ6fORZIn9TsNwzUIbo3sNhrrBh6ru8BSCxhvwbPHYm9roG7nP3N53e/Pd3oyDAFl9IQXnJMJWTxUJrAb0NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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


On 4/29/2025 9:38 PM, Christian König wrote:
> On 4/29/25 17:24, Arvind Yadav wrote:
>> Introduce a new `enum dma_fence_unwrap_mode` to support multiple modes
>> of fence unwrapping and merging behavior. This lays the groundwork for
>> more flexible and efficient fence operations.
>>
>> Add a new macro `dma_fence_unwrap_shrink_array()` to allow callers to
>> unwrap, deduplicate, and sort dma_fence arrays in-place, avoiding
>> additional memory allocations. This mode filters out already signaled
>> fences and keeps only the latest fence per context.
>>
>> To support this, refactor `__dma_fence_unwrap_merge()` to handle both
>> merge and shrink modes through the new `dma_fence_unwrap_mode` parameter.
>> The sorting and deduplication logic is extracted into a new helper function
>> `dma_fence_unwrap_dedup_sort()`.
>>
>> These changes allow clients to efficiently compact arrays of fences with
>> minimal overhead, improving memory usage and performance in common
>> scenarios like command submission or dependency tracking.
>>
>> v2: - Export this code from dma-fence-unwrap.c(by Christian).
>> v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
>>      - No need to add a new function just re-use existing(by Christian).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>> ---
>>   drivers/dma-buf/dma-fence-unwrap.c | 54 +++++++++++++++++++++---------
>>   include/linux/dma-fence-unwrap.h   | 44 ++++++++++++++++++++++--
>>   2 files changed, 81 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
>> index 2a059ac0ed27..f389c37a0eb5 100644
>> --- a/drivers/dma-buf/dma-fence-unwrap.c
>> +++ b/drivers/dma-buf/dma-fence-unwrap.c
>> @@ -79,15 +79,51 @@ static int fence_cmp(const void *_a, const void *_b)
>>   	return 0;
>>   }
>>   
>> +static void dma_fence_unwrap_dedup_sort(struct dma_fence **array,
>> +					unsigned int *count)
> Just call that dma_fence_dedup_array() (e.g. without the unwrap).
Noted.
>
>> +{
>> +	int i, j;
>> +
>> +	sort(array, *count, sizeof(*array), fence_cmp, NULL);
>> +
>> +	/*
>> +	 * Only keep the most recent fence for each context.
>> +	 */
>> +	j = 0;
>> +	for (i = 1; i < *count; i++) {
>> +		if (array[i]->context == array[j]->context)
>> +			dma_fence_put(array[i]);
>> +		else
>> +			array[++j] = array[i];
>> +	}
>> +
>> +	*count = ++j;
>> +}
> Instead of making count a pointer just return the resulting count.
Noted.
>
>> +
>>   /* Implementation for the dma_fence_merge() marco, don't use directly */
>>   struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>>   					   struct dma_fence **fences,
>> -					   struct dma_fence_unwrap *iter)
>> +					   struct dma_fence_unwrap *iter,
>> +					   enum dma_fence_unwrap_mode mode,
>> +					   unsigned int *out_count)
>>   {
>>   	struct dma_fence *tmp, *unsignaled = NULL, **array;
>>   	struct dma_fence_array *result;
>>   	ktime_t timestamp;
>> -	int i, j, count;
>> +	int i, count;
>> +
>> +	if (mode == DMA_FENCE_UNWRAP_ARRAY) {
>> +		array = fences;
>> +		count = num_fences;
>> +
>> +		if (count > 1)
>> +			dma_fence_unwrap_dedup_sort(array, &count);
>> +
>> +		if (out_count)
>> +			*out_count = count;
>> +
>> +		return NULL;
>> +	}
>
> Completely drop that. Just export the dma_fence_dedup_array() function and use that directly.
Sure, I will export  dma_fence_dedup_array.

Regards,
~arvind
>
> Regards,
> Christian.
>
>>   
>>   	count = 0;
>>   	timestamp = ns_to_ktime(0);
>> @@ -141,19 +177,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>>   	if (count == 0 || count == 1)
>>   		goto return_fastpath;
>>   
>> -	sort(array, count, sizeof(*array), fence_cmp, NULL);
>> -
>> -	/*
>> -	 * Only keep the most recent fence for each context.
>> -	 */
>> -	j = 0;
>> -	for (i = 1; i < count; i++) {
>> -		if (array[i]->context == array[j]->context)
>> -			dma_fence_put(array[i]);
>> -		else
>> -			array[++j] = array[i];
>> -	}
>> -	count = ++j;
>> +	dma_fence_unwrap_dedup_sort(array, &count);
>>   
>>   	if (count > 1) {
>>   		result = dma_fence_array_create(count, array,
>> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
>> index 66b1e56fbb81..b5683b024548 100644
>> --- a/include/linux/dma-fence-unwrap.h
>> +++ b/include/linux/dma-fence-unwrap.h
>> @@ -10,6 +10,18 @@
>>   
>>   struct dma_fence;
>>   
>> +/**
>> + * enum dma_fence_unwrap_mode - Mode of operation for fence unwrap and merge
>> + * @DMA_FENCE_UNWRAP_MERGE: Merge all unsignaled fences into a new dma_fence object.
>> + *                          Returns a single merged fence or stub.
>> + * @DMA_FENCE_UNWRAP_ARRAY: Deduplicate and sort fences in-place.
>> + *                          Returns nothing, but updates the input array and count.
>> + */
>> +enum dma_fence_unwrap_mode {
>> +	DMA_FENCE_UNWRAP_MERGE,  /* Return a single merged dma_fence or NULL on error */
>> +	DMA_FENCE_UNWRAP_ARRAY,  /* Return deduplicated, sorted in-place array */
>> +};
>> +
>>   /**
>>    * struct dma_fence_unwrap - cursor into the container structure
>>    *
>> @@ -50,7 +62,9 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
>>   
>>   struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>>   					   struct dma_fence **fences,
>> -					   struct dma_fence_unwrap *cursors);
>> +					   struct dma_fence_unwrap *cursors,
>> +					   enum dma_fence_unwrap_mode mode,
>> +					   unsigned int *out_count);
>>   
>>   /**
>>    * dma_fence_unwrap_merge - unwrap and merge fences
>> @@ -58,6 +72,9 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>>    * All fences given as parameters are unwrapped and merged back together as flat
>>    * dma_fence_array. Useful if multiple containers need to be merged together.
>>    *
>> + * Internally uses the DMA_FENCE_UNWRAP_MERGE mode to return a single merged
>> + * dma_fence (or a stub if all fences are signaled).
>> + *
>>    * Implemented as a macro to allocate the necessary arrays on the stack and
>>    * account the stack frame size to the caller.
>>    *
>> @@ -69,7 +86,30 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>>   		struct dma_fence *__f[] = { __VA_ARGS__ };		\
>>   		struct dma_fence_unwrap __c[ARRAY_SIZE(__f)];		\
>>   									\
>> -		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c);	\
>> +		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c,	\
>> +					 DMA_FENCE_UNWRAP_MERGE, NULL);	\
>> +	})
>> +
>> +/**
>> + * dma_fence_unwrap_shrink_array - Deduplicate and sort an array of fences in-place
>> + * @ _num_fences: Number of input fences
>> + * @ _fences:     Array of dma_fence pointers to be deduplicated and sorted
>> + * @ _out_fences: Output variable updated with the number of fences after deduplication
>> + *
>> + * This macro unwraps each fence (handling dma_fence_array if needed),
>> + * filters out signaled fences, sorts the remaining ones by context and
>> + * timestamp, and removes duplicates (keeping only the most recent fence per context).
>> + *
>> + * Internally uses the DMA_FENCE_UNWRAP_ARRAY mode to perform in-place filtering and
>> + * sorting.
>> + *
>> + * The result is stored back in the input array (_fences) and the final count
>> + * is written to @_out_fences. No memory allocation is performed.
>> + */
>> +#define dma_fence_unwrap_shrink_array(_num_fences, _fences, _out_fences)	\
>> +	({									\
>> +		__dma_fence_unwrap_merge((_num_fences), (_fences), NULL,	\
>> +					 DMA_FENCE_UNWRAP_ARRAY, &_out_fences);	\
>>   	})
>>   
>>   #endif
