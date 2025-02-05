Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91423C02196
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F160E10E72B;
	Wed,  5 Feb 2025 03:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njoWoGUm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D84D10E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFgsswl4oh5fRF5TUJ6m+2lttFhvgVMi0q5kge0WjM8lWt1nrCI7F531ePcdYHX4ghcL2JxE9w7HjYQG9HUgqYBVxgqATg3eSF7uryqfhjxx2QjUXW+urJy2aU7fpQTtUAvnLKeSMhxo9UhslzwpxLsW5/FdCGf7XeuyvH/jLPu/qF8BW0vKZMro0DbYxthiEAn3PKfyoeQkfWp9Q1nzt1yLrVKkJQCMyO79UrLvZ8UKSUN6Zb9lNYkwkncWK639AtVL03V+Dv7C++nC4B3eyJUJr36kJi0wlZfJOzXxxWQ7GyURm0/uvUGJ6OBRn2trm29EOd6ijb8aMKxgH24cXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgZNn+26Fbe03VMHWRnN/MP5pCHcDbKPJRj0+jIZXiQ=;
 b=ZRgkQEVcR1+K9085/7KEw13d/3tKHLJV1RIJ1Pqjjj7QEBCZvTQjFq3rPQ5ZF9H9WfBcJflBot9CKf7jRO5jWxWOMgCegwtTRBvlNXi4WfIlmxgaq7V6rx5S+mRNpYC7PqB9NTHdFrONtRVbfVBYhtkaZbKVUVKBgxyqQHiA4CXxLQo0E+L5VC/dj6YZXG9OHPTvJ0wlZ/w/9JozfwdK8oOzwDKqQW48uNulFXW7rhra3n858OzyXqPTCDkIHlo7Ls66wSbve3refcXA32PgcbC966h+sR7leSeHlOa03N5lE1PZzvlQfX9VpsAhJNWdOZW5UXsxI6TFaT2VjbypfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgZNn+26Fbe03VMHWRnN/MP5pCHcDbKPJRj0+jIZXiQ=;
 b=njoWoGUmb3YsKlXxVeOILX2oY/hJiFNMz/4onltWbuiVtRsHpBFcgbEs1Rd0YvkcmJFXKUiHPFe+zQKcK0C3VD25l9fubcvlilnUymWLAdKjGU7mzsQ0NFP0isvVGNTPqjq25h6s7wHVqx/vqz6bCmlDOnIBEzuGl9iV2pJK9W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:06:50 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:06:50 +0000
Message-ID: <a034d63d-503b-41ae-a549-206ed0033640@amd.com>
Date: Tue, 4 Feb 2025 22:06:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/44] drm/amdgpu/vcn: move more instanced data to
 vcn_instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-11-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::11) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 53390933-7588-44b3-1bde-08dd45922267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmxZOWxuR2s0SGRjb291Uk9pSEYwaHkyTFFnOWt6Sm9ybE8xV0RYaUVNUE1r?=
 =?utf-8?B?SG1tWjdpQjhpcmpuNldsV3luUXh0RlkyYmRTanR1eGt2K2dNVE9HR3ZOMkxG?=
 =?utf-8?B?dy9PNlVzbThETFBRUU5mZXEwM01mTEJmb2p3dER0YnNMaVhTMG5xKzlhekNL?=
 =?utf-8?B?M2JYOHc0QTFkdG1oV28zSDkydWpya2JLempPcnNjZFVnN3lRMHFVbDhHRE05?=
 =?utf-8?B?Vno1ZVFVTTdkSnJJQ2JmTmM1ZEJHQXIreHNaazV1Wk10aytKUURFcloza1BI?=
 =?utf-8?B?NWFsZUNTM2diZklqV25hS0xoN00wN0ZxdU9IZy8zbzV1TnRCZGtFZk01ZkMy?=
 =?utf-8?B?RE53S014YVRzSGRIdm9EQ2pNL1RoY2FVZmo5amhlN1JoUUJ5eVY4alpGanBU?=
 =?utf-8?B?aktkUlkzSW5pRm5LN1E4QnBTSEZlUS9ZbTBFRmpaS3pqWDFKdmt3UURHSGVk?=
 =?utf-8?B?aWdqUk1tUi84VWcwYjVxQTc5eG52dEsyUnRNQ0x4UTE4YVRWejgrL09kVDlo?=
 =?utf-8?B?QzlDMkgxSEJ4RTM3VkU1VThEZDJuUTNZVXFmeVBBZFQ3bmNWalFhYlZvQkV3?=
 =?utf-8?B?ekdjc3I3OWNqWlljYUhBRFFPNGtXdEFhTmtNbVh3MHh3TWM1MnJpaWNrODM1?=
 =?utf-8?B?UGFrNktGWU9CUXNCNzVYM055ek9Td3JIUmdvOWFaU20xNHVFTVNQSTVwKytO?=
 =?utf-8?B?ek1CNjAyMXNKQUVBRVNydlZBVmhUcXJ1ZzlZVnBjWW1TSzNPbkQxVTcremIz?=
 =?utf-8?B?Z3lEcks2S3Rxb3gwOENscyt2Z2JtUEZEMWd3Ulg5c0djYkRrcE9iM3ZRSGsr?=
 =?utf-8?B?YnZ2N3ZjUVVtZmRMTTY5aDhqVkFBV2hMM3dXampQcmFiWlpRcjlra25HTWNK?=
 =?utf-8?B?Z3VSbjVNOUVWSithNll0NE5RUlRiaGtUalY0UFo4TGlranhzSGZCbEVGTUNh?=
 =?utf-8?B?WGlGUDJMcXVIbUNieXpEdk1COU9uR1lmQWJCOUh6SmR5dkU4cThlblc1K040?=
 =?utf-8?B?UjJsZmtueTdKSGRxNkZzTmF1TkRPVTE1cE1Jb3RXeERmcWEzUGplaUJ4bGJ3?=
 =?utf-8?B?Q1ZCZnAxeURiZTl3Q2l5TEliUGdaOHVhWCtmeGNhT3VqTEhEUVpzK2xFQi8w?=
 =?utf-8?B?OGtuRVdyNVFCdGNEaVNVNDlSM0RjN2JVaDdwNzJWM1ZWQUhmVWk0YzgrbGFE?=
 =?utf-8?B?ZnlMZSsvb0xaRHUxS0JUSXp1N2pRRmg1MHZoeE02T0FjaVdrNWN5ME0rdFRT?=
 =?utf-8?B?ZVdyendUZFNrZVBEcXRMTlA5OVI2d2VNSUpWempQN2s3eXhRaXZUODNIZjA2?=
 =?utf-8?B?QTE1ZzhlZCtSb2x2Y2tyZlh4UTcrKzBjMFhaT3p4QVY2TDdQTTd5bVI1SWZi?=
 =?utf-8?B?S0UrNm9EQzVGekZsSWtTbUxCeFpscUV0TDhrWWRjRnRVcm9rOFdhak1aN3FR?=
 =?utf-8?B?cTBJQ2NteVQveVNDR1ZLMVhZWSsvdCtrQzVnVGpsTlcrSzRVNVJkdDNIZm1X?=
 =?utf-8?B?U2tIRFdGc1c2WVNNaDNqbzFHdTF3Uy8vRTFhdHBibXBtU2VjV0VqcXQ2Nm8x?=
 =?utf-8?B?bGhkRUhma3RiQWVGT2JMYlJOYUR2NE5ycldoZ3pyOVF4cUJmakF2czROVU1o?=
 =?utf-8?B?NkIyYWdlZm5RMkJkTGtIdFpDQldBdnRJcW9VSFNubi9YMHI3NGtwUEpCZ2Zp?=
 =?utf-8?B?T0dyekI4b0VHelNrMEovN1BHbjRvSWljeWJ3ell2aVBmczJSNitPMnR5U3FF?=
 =?utf-8?B?VFU0TW9CQkMwbTAxWDVVWTVrdzVKa0FHeDVHOVY3ek9GRmY2c1oxZzFiVWVU?=
 =?utf-8?B?bGRheTFWSlRtWUMrVEhNQktVSkRYcEVqcXFHcGIwNXZBZmNTckJCc05YNVNW?=
 =?utf-8?Q?UCyx575VHCuhg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUF5WU1ZTXhGdVZQVWNObllyZW9qeWVJWURKbjV0T2lSZkk4ZXA4N2xCWXN0?=
 =?utf-8?B?enNKTERZMzYyamE4WlNLNDdaUVZKT2JKcWxlWHltMXQ0TUhTMkk4QUxEa0cv?=
 =?utf-8?B?cU02QzNDUVBNN3NOaU1MeElOdUwwSStrVXFTMXplTEw2eHU3NmpQalVvdnVB?=
 =?utf-8?B?RndqWmNVOE9xdUVQRWpOcnUvb2xZN0t2ZUF0UnZqSkpvVEtxd3YrQjBoRml2?=
 =?utf-8?B?TUY2YTdhRUplS2dtN0lHNm9PQWtuVXVVc3NDcXZQazZRdHRxeUY4WnU0dTV4?=
 =?utf-8?B?c1UyN3dyMExJZGZoWEZEZlhidjF3a2dhRURGc2IvUGpOVW04dTc2bzVsZkRm?=
 =?utf-8?B?aXJ6YWNjOGtYSDN1Mk5nQm4yS1o0Qi8xcVRnREJ5eXZtSmJVbmNManZCemRZ?=
 =?utf-8?B?TStIUmZKL1doOWhJWDhwbnRzMHM1Q2crSVdmakVlZGhuM3BTRHJQb0J3MDNi?=
 =?utf-8?B?TzYxWUVESDJ0QUVyNUlhSVNqZWN5YnlvNUtaMnFiMk5uN3dQWURrb2ROYXd5?=
 =?utf-8?B?TjRlYU5SRnpZdE1qR3hWbm44MHFDV3Q5WHRYdkpHaFRSOURGSWx6ZmVxelhC?=
 =?utf-8?B?RFRodFFsZlIyQ0ZjSmJKZWtZZzVxNFZzOGVJK2NraFI1aDRpYlM4VFhrV2VZ?=
 =?utf-8?B?MkpwVm13QTljbmRWbUJmSjBCZkdXL3pTdXF1TXZlMDZRc1FBMDJaR3pPNVRF?=
 =?utf-8?B?QzRyaVBlMmNMSTNhYWJ2ZEh0bVFwVHFHYkdNeG5icUQzWHdMMU1vaVpPZ2Ju?=
 =?utf-8?B?ajFXbThLMG1qL1FxdVBRcVpjYlFVRUI0bnVWcVNKWUJ5ajBWY0pSSjdpa0lC?=
 =?utf-8?B?aDhsaE81SWJTakduK05tMTJoSWRQNGVLaWorU1ZtSVVZcDFWQ2FBQkhCZUc4?=
 =?utf-8?B?d2FHbUlDNGh0T00wN0ZuQ0IvSm9oNkp1VXg0c0dOVTBYall2ZXhjem50aFpJ?=
 =?utf-8?B?RnZmY3VRSGdiTlFqTTJYOVFDODNiTy96WkphT3NqL2pPakFXNlRuZEJYOTQ0?=
 =?utf-8?B?VWNBUlVKc3RMZUxvSUZFWVkwQ0REN1VmVEpqcEZyQTJDNHlWSUZmWTBsUXdF?=
 =?utf-8?B?YlNZK2RLd0tJV0huL2FhdklQQnZ0MmdOZ0FaNUM5VmlkcVNEVkUwTGlNSFVu?=
 =?utf-8?B?dW9ZNHZYOThjWXluT281TC9pSDIvc0t6ZzhFZ3JIMmlOaEJ1emdxMTlsTGxm?=
 =?utf-8?B?Y0RLTHFTL1RyeGdscjBVbzhNVmVnZFhWeVgzZlNTT2RXMUM4emYxamlIakdG?=
 =?utf-8?B?U3NPQThRVTN5S09XaEl0NnlWMDllQVAxSnFld0drME1zeVg0S3J3cWI2U2VI?=
 =?utf-8?B?UlBpZWw5VVRMMVpOZUhxa0hqSkVFcmxhUE5ia2RCcC9ibzdPeFhQZFR3bVU0?=
 =?utf-8?B?YVBxMjJXbUxUNnVKaUp3M0hxZFdjeUV1czNrVXI4KzdWelpydXBzY0Z1UTBU?=
 =?utf-8?B?eFo0VHNSZ29oRWxQcGUwR3FBd1dKOGc2MHpHMUREVVJMeXFDT3VsL2lnYUY2?=
 =?utf-8?B?eHZDS3RsVW1YQ3hGTStsZjBmbnJ0ckNOQWc4SHpqZm5HdUpEd2p4R0FBblY1?=
 =?utf-8?B?a1EyaWptZjlGNGhvZDN0RE1ZMTc2Q1hpUDdHVmhkZWF4N0o4RU8ySnNIWlNT?=
 =?utf-8?B?UE9IamhjZUVPMjZVcm1VZFM4UnJyN1pzd0tKczB5SjhtVW14aG1EeHFKUm5j?=
 =?utf-8?B?U25iUmQwWjdHWTlNdXRYSThmVUxNVkIvaFlXcHgrVUQvZi9YUm1ia2UvQU9V?=
 =?utf-8?B?SnRCSDdSaFNWeldCODcvNVhSd1VGVE1MblVGMlpPR2hka3pPQ0ZmSVRKTDFk?=
 =?utf-8?B?a2J5Uld4dUlLRTRXeUlEN1JiWlJyTmdDLzJXZzBPZFlPYjhvRlJIa2JVZGR3?=
 =?utf-8?B?bG9jaGlNdVJocjZ4YWc1S1NuMUxLUWhobDQ0N2x0TkxMY2djZlJ5eWZ4WFc1?=
 =?utf-8?B?TEt1cUVoMmJyQnlhVkE5aXhxS09YRGo3NG1Bd0poU0ZONko4RlAxNnVnU0lF?=
 =?utf-8?B?MWZycUY0NDc5RURmNUdsYnQwZlR0ZlNOdnRRU2c2TkRFUHVGTys5Rzl2eVlW?=
 =?utf-8?B?WWhmV0x1TzV0MTJ5L2RDOVYrZ1BFSW9CbkFsd2lrajBVN1pIdjhrNnhRUUtD?=
 =?utf-8?Q?wVoek2ytTZjefJQpcClym2Ena?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53390933-7588-44b3-1bde-08dd45922267
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:06:50.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5E9JSr/fJwb6pwL7+rNwLQ4PJzM4hrW6GGNz78nT2jlZ/batImD4iq6oIEK8bznzR5H992w7kYHJ9HoG3S8hZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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


On 2025-01-31 11:57, Alex Deucher wrote:
> Move more per instance data into the per instance structure.
>
> v2: index instances directly on vcn1.0 and 2.0 to make
> it clear that they only support a single instance (Lijo)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 196 ++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  17 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |   4 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  42 ++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  92 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  51 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  67 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  19 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  14 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  18 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  16 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |   8 +-
>   13 files changed, 279 insertions(+), 267 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 2c76bc5e25d92..5ee2ae66ed36b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -480,7 +480,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->vcn.harvest_config & (1 << i))
>   				continue;
>   
> -			for (j = 0; j < adev->vcn.num_enc_rings; j++)
> +			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
>   				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
>   					++num_rings;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 0c3081a198d9e..9901b8e17f305 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -127,93 +127,88 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	unsigned int fw_shared_size, log_offset;
>   	int i, r;
>   
> -	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>   		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
>   		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
>   		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
>   		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> -	}
> -
> -	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
> -	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> -		adev->vcn.indirect_sram = true;
> -
> -	/*
> -	 * Some Steam Deck's BIOS versions are incompatible with the
> -	 * indirect SRAM mode, leading to amdgpu being unable to get
> -	 * properly probed (and even potentially crashing the kernel).
> -	 * Hence, check for these versions here - notice this is
> -	 * restricted to Vangogh (Deck's APU).
> -	 */
> -	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
> -		const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
> -
> -		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
> -		     !strncmp("F7A0114", bios_ver, 7))) {
> -			adev->vcn.indirect_sram = false;
> -			dev_info(adev->dev,
> -				"Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
> +		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
> +		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> +			adev->vcn.inst[i].indirect_sram = true;
> +
> +		/*
> +		 * Some Steam Deck's BIOS versions are incompatible with the
> +		 * indirect SRAM mode, leading to amdgpu being unable to get
> +		 * properly probed (and even potentially crashing the kernel).
> +		 * Hence, check for these versions here - notice this is
> +		 * restricted to Vangogh (Deck's APU).
> +		 */
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 0, 2)) {
> +			const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
> +
> +			if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
> +					 !strncmp("F7A0114", bios_ver, 7))) {
> +				adev->vcn.inst[i].indirect_sram = false;
> +				dev_info(adev->dev,
> +					 "Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
> +			}
>   		}
> -	}
>   
> -	/* from vcn4 and above, only unified queue is used */
> -	adev->vcn.using_unified_queue =
> -		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
> -
> -	hdr = (const struct common_firmware_header *)adev->vcn.inst[0].fw->data;
> -	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
> -
> -	/* Bit 20-23, it is encode major and non-zero for new naming convention.
> -	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
> -	 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
> -	 * is zero in old naming convention, this field is always zero so far.
> -	 * These four bits are used to tell which naming convention is present.
> -	 */
> -	fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
> -	if (fw_check) {
> -		unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
> -
> -		fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
> -		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
> -		enc_major = fw_check;
> -		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
> -		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> -		DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
> -			enc_major, enc_minor, dec_ver, vep, fw_rev);
> -	} else {
> -		unsigned int version_major, version_minor, family_id;
> +		/* from vcn4 and above, only unified queue is used */
> +		adev->vcn.inst[i].using_unified_queue =
> +			amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
> +
> +		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
> +		adev->vcn.inst[i].fw_version = le32_to_cpu(hdr->ucode_version);
> +		adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
> +
> +		/* Bit 20-23, it is encode major and non-zero for new naming convention.
> +		 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
> +		 * convention. Since the l:wq!atest version minor is 0x5B and DRM_DISABLED_FLAG
> +		 * is zero in old naming convention, this field is always zero so far.
> +		 * These four bits are used to tell which naming convention is present.
> +		 */
> +		fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
> +		if (fw_check) {
> +			unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
> +
> +			fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
> +			enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
> +			enc_major = fw_check;
> +			dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
> +			vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> +			DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
> +				 enc_major, enc_minor, dec_ver, vep, fw_rev);
> +		} else {
> +			unsigned int version_major, version_minor, family_id;
>   
> -		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
> -		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
> -		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> -		DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
> -			version_major, version_minor, family_id);
> -	}
> +			family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
> +			version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
> +			version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
> +			DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u\n",
> +				 version_major, version_minor, family_id);
> +		}
>   
> -	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> -	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> -		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
> +		bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> +		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> +			bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>   
> -	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
> -		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
> -		log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
> -	} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
> -		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
> -		log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
> -	} else {
> -		fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> -		log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
> -	}
> -
> -	bo_size += fw_shared_size;
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(5, 0, 0)) {
> +			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared));
> +			log_offset = offsetof(struct amdgpu_vcn5_fw_shared, fw_log);
> +		} else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0)) {
> +			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared));
> +			log_offset = offsetof(struct amdgpu_vcn4_fw_shared, fw_log);
> +		} else {
> +			fw_shared_size = AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared));
> +			log_offset = offsetof(struct amdgpu_fw_shared, fw_log);
> +		}
>   
> -	if (amdgpu_vcnfw_log)
> -		bo_size += AMDGPU_VCNFW_LOG_SIZE;
> +		bo_size += fw_shared_size;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +		if (amdgpu_vcnfw_log)
> +			bo_size += AMDGPU_VCNFW_LOG_SIZE;
>   
>   		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
>   					    AMDGPU_GEM_DOMAIN_VRAM |
> @@ -239,7 +234,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
>   		}
>   
> -		if (adev->vcn.indirect_sram) {
> +		if (adev->vcn.inst[i].indirect_sram) {
>   			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
>   					AMDGPU_GEM_DOMAIN_VRAM |
>   					AMDGPU_GEM_DOMAIN_GTT,
> @@ -277,15 +272,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   
>   		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
>   
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i)
>   			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>   
>   		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
>   		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
> +		mutex_destroy(&adev->vcn.inst[j].vcn1_jpeg1_workaround);
>   	}
>   
> -	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> -
>   	return 0;
>   }
>   
> @@ -404,12 +398,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> -	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>   		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -	    !adev->vcn.using_unified_queue) {
> +	    !adev->vcn.inst[i].using_unified_queue) {
>   		struct dpg_pause_state new_state;
>   
>   		if (fence[i] ||
> @@ -418,7 +412,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, i, &new_state);
> +		adev->vcn.inst[i].pause_dpg_mode(adev, i, &new_state);
>   	}
>   
>   	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> @@ -456,7 +450,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -	    !adev->vcn.using_unified_queue) {
> +	    !adev->vcn.inst[ring->me].using_unified_queue) {
>   		struct dpg_pause_state new_state;
>   
>   		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
> @@ -466,7 +460,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   			unsigned int fences = 0;
>   			unsigned int i;
>   
> -			for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +			for (i = 0; i < adev->vcn.inst[ring->me].num_enc_rings; ++i)
>   				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
>   
>   			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
> @@ -475,7 +469,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   		}
>   
> -		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
> +		adev->vcn.inst[ring->me].pause_dpg_mode(adev, ring->me, &new_state);
>   	}
>   	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>   }
> @@ -487,7 +481,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>   	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
> -	    !adev->vcn.using_unified_queue)
> +	    !adev->vcn.inst[ring->me].using_unified_queue)
>   		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>   
>   	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
> @@ -511,7 +505,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	r = amdgpu_ring_alloc(ring, 3);
>   	if (r)
>   		return r;
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.scratch9, 0));
>   	amdgpu_ring_write(ring, 0xDEADBEEF);
>   	amdgpu_ring_commit(ring);
>   	for (i = 0; i < adev->usec_timeout; i++) {
> @@ -576,14 +570,14 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
> +	ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
>   	ib->ptr[1] = addr;
> -	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> +	ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
>   	ib->ptr[3] = addr >> 32;
> -	ib->ptr[4] = PACKET0(adev->vcn.internal.cmd, 0);
> +	ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
>   	ib->ptr[5] = 0;
>   	for (i = 6; i < 16; i += 2) {
> -		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
> +		ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 0);
>   		ib->ptr[i+1] = 0;
>   	}
>   	ib->length_dw = 16;
> @@ -746,7 +740,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	uint32_t ib_pack_in_dw;
>   	int i, r;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -759,7 +753,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	ib->length_dw = 0;
>   
>   	/* single queue headers */
> -	if (adev->vcn.using_unified_queue) {
> +	if (adev->vcn.inst[ring->me].using_unified_queue) {
>   		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
>   						+ 4 + 2; /* engine info + decoding ib in dw */
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
> @@ -778,7 +772,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	for (i = ib->length_dw; i < ib_size_dw; ++i)
>   		ib->ptr[i] = 0x0;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
>   
>   	r = amdgpu_job_submit_direct(job, ring, &f);
> @@ -876,7 +870,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	uint64_t addr;
>   	int i, r;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -890,7 +884,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   
>   	ib->length_dw = 0;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
>   
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -912,7 +906,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	for (i = ib->length_dw; i < ib_size_dw; ++i)
>   		ib->ptr[i] = 0x0;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>   
>   	r = amdgpu_job_submit_direct(job, ring, &f);
> @@ -943,7 +937,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	uint64_t addr;
>   	int i, r;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_size_dw += 8;
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> @@ -957,7 +951,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   	ib->length_dw = 0;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
>   
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -979,7 +973,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	for (i = ib->length_dw; i < ib_size_dw; ++i)
>   		ib->ptr[i] = 0x0;
>   
> -	if (adev->vcn.using_unified_queue)
> +	if (adev->vcn.inst[ring->me].using_unified_queue)
>   		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>   
>   	r = amdgpu_job_submit_direct(job, ring, &f);
> @@ -1396,7 +1390,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct amdgpu_device *adev)
>   	struct dentry *root = minor->debugfs_root;
>   	char name[32];
>   
> -	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.using_unified_queue)
> +	if (adev->vcn.num_vcn_inst <= 1 || !adev->vcn.inst[0].using_unified_queue)
>   		return;
>   	sprintf(name, "amdgpu_vcn_sched_mask");
>   	debugfs_create_file(name, 0600, root, adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 0bcf4d1c7175d..3b059f51894b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -322,6 +322,15 @@ struct amdgpu_vcn_inst {
>   	struct mutex		vcn_pg_lock;
>   	enum amd_powergating_state cur_state;
>   	struct delayed_work	idle_work;
> +	unsigned		fw_version;
> +	unsigned		num_enc_rings;
> +	bool			indirect_sram;
> +	struct amdgpu_vcn_reg	 internal;
> +	struct mutex		vcn1_jpeg1_workaround;
> +	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> +			      int inst_idx,
> +			      struct dpg_pause_state *new_state);
> +	bool using_unified_queue;
>   };
>   
>   struct amdgpu_vcn_ras {
> @@ -330,24 +339,16 @@ struct amdgpu_vcn_ras {
>   
>   struct amdgpu_vcn {
>   	unsigned		fw_version;
> -	unsigned		num_enc_rings;
> -	bool			indirect_sram;
> -
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> -	struct amdgpu_vcn_reg	 internal;
> -	struct mutex		vcn1_jpeg1_workaround;
>   
>   	unsigned	harvest_config;
> -	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> -		int inst_idx, struct dpg_pause_state *new_state);
>   
>   	struct ras_common_if    *ras_if;
>   	struct amdgpu_vcn_ras   *ras;
>   
>   	uint16_t inst_mask;
>   	uint8_t	num_inst_per_aid;
> -	bool using_unified_queue;


unified_queue feature is determined by VCN IP version, so the "bool 
using_unified_queue" should be a generic value for all instances. Should 
we still need to separate it for each instance?

Boyuan


>   
>   	/* IP reg dump */
>   	uint32_t		*ip_dump;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 8031406e20ff9..9e428e669ada6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -607,12 +607,12 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   	int		cnt = 0;
>   
> -	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> +	mutex_lock(&adev->vcn.inst[0].vcn1_jpeg1_workaround);
>   
>   	if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_dec))
>   		DRM_ERROR("JPEG dec: vcn dec ring may not be empty\n");
>   
> -	for (cnt = 0; cnt < adev->vcn.num_enc_rings; cnt++) {
> +	for (cnt = 0; cnt < adev->vcn.inst[0].num_enc_rings; cnt++) {
>   		if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_enc[cnt]))
>   			DRM_ERROR("JPEG dec: vcn enc ring[%d] may not be empty\n", cnt);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 757cacf11a817..c870d9ba64c69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -105,7 +105,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	adev->vcn.num_enc_rings = 2;
> +	adev->vcn.inst[0].num_enc_rings = 2;
>   
>   	vcn_v1_0_set_dec_ring_funcs(adev);
>   	vcn_v1_0_set_enc_ring_funcs(adev);
> @@ -138,7 +138,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	/* VCN ENC TRAP */
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN, i + VCN_1_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>   					&adev->vcn.inst->irq);
>   		if (r)
> @@ -166,18 +166,18 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->vcn.internal.scratch9 = adev->vcn.inst->external.scratch9 =
> +	adev->vcn.inst[0].internal.scratch9 = adev->vcn.inst->external.scratch9 =
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_SCRATCH9);
> -	adev->vcn.internal.data0 = adev->vcn.inst->external.data0 =
> +	adev->vcn.inst[0].internal.data0 = adev->vcn.inst->external.data0 =
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0);
> -	adev->vcn.internal.data1 = adev->vcn.inst->external.data1 =
> +	adev->vcn.inst[0].internal.data1 = adev->vcn.inst->external.data1 =
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1);
> -	adev->vcn.internal.cmd = adev->vcn.inst->external.cmd =
> +	adev->vcn.inst[0].internal.cmd = adev->vcn.inst->external.cmd =
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD);
> -	adev->vcn.internal.nop = adev->vcn.inst->external.nop =
> +	adev->vcn.inst[0].internal.nop = adev->vcn.inst->external.nop =
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>   
>   		ring = &adev->vcn.inst->ring_enc[i];
> @@ -189,7 +189,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	adev->vcn.pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
> +	adev->vcn.inst[0].pause_dpg_mode = vcn_v1_0_pause_dpg_mode;
>   
>   	if (amdgpu_vcnfw_log) {
>   		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
> @@ -253,7 +253,7 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> @@ -1833,7 +1833,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   	struct amdgpu_device *adev = vcn_inst->adev;
>   	unsigned int fences = 0, i;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
>   		fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1849,7 +1849,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
> +		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
>   	}
>   
>   	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
> @@ -1872,7 +1872,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   	struct	amdgpu_device *adev = ring->adev;
>   	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
> -	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> +	mutex_lock(&adev->vcn.inst[0].vcn1_jpeg1_workaround);
>   
>   	if (amdgpu_fence_wait_empty(ring->adev->jpeg.inst->ring_dec))
>   		DRM_ERROR("VCN dec: jpeg dec ring may not be empty\n");
> @@ -1898,7 +1898,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   		struct dpg_pause_state new_state;
>   		unsigned int fences = 0, i;
>   
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +		for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
>   			fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_enc[i]);
>   
>   		if (fences)
> @@ -1916,14 +1916,14 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
>   			new_state.jpeg = VCN_DPG_STATE__PAUSE;
>   
> -		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
> +		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
>   	}
>   }
>   
>   void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>   {
>   	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
> -	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
> +	mutex_unlock(&ring->adev->vcn.inst[0].vcn1_jpeg1_workaround);
>   }
>   
>   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> @@ -2057,11 +2057,11 @@ static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   		uint32_t reg = amdgpu_ib_get_value(ib, i);
>   		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>   
> -		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> +		if (reg == PACKET0(p->adev->vcn.inst[0].internal.data0, 0)) {
>   			msg_lo = val;
> -		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> +		} else if (reg == PACKET0(p->adev->vcn.inst[0].internal.data1, 0)) {
>   			msg_hi = val;
> -		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> +		} else if (reg == PACKET0(p->adev->vcn.inst[0].internal.cmd, 0)) {
>   			r = vcn_v1_0_validate_bo(p, job,
>   						 ((u64)msg_hi) << 32 | msg_lo);
>   			if (r)
> @@ -2146,7 +2146,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>   {
>   	int i;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
>   		adev->vcn.inst->ring_enc[i].funcs = &vcn_v1_0_enc_ring_vm_funcs;
>   }
>   
> @@ -2157,7 +2157,7 @@ static const struct amdgpu_irq_src_funcs vcn_v1_0_irq_funcs = {
>   
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	adev->vcn.inst->irq.num_types = adev->vcn.num_enc_rings + 2;
> +	adev->vcn.inst->irq.num_types = adev->vcn.inst[0].num_enc_rings + 2;
>   	adev->vcn.inst->irq.funcs = &vcn_v1_0_irq_funcs;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e55c1f8f260e9..b0a957664250c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -110,9 +110,9 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
> -		adev->vcn.num_enc_rings = 1;
> +		adev->vcn.inst[0].num_enc_rings = 1;
>   	else
> -		adev->vcn.num_enc_rings = 2;
> +		adev->vcn.inst[0].num_enc_rings = 2;
>   
>   	vcn_v2_0_set_dec_ring_funcs(adev);
>   	vcn_v2_0_set_enc_ring_funcs(adev);
> @@ -145,7 +145,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	/* VCN ENC TRAP */
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>   				      i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>   				      &adev->vcn.inst->irq);
> @@ -175,25 +175,25 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>   
> -	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>   	adev->vcn.inst->external.scratch9 = SOC15_REG_OFFSET(UVD, 0, mmUVD_SCRATCH9);
> -	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>   	adev->vcn.inst->external.data0 = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0);
> -	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>   	adev->vcn.inst->external.data1 = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1);
> -	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>   	adev->vcn.inst->external.cmd = SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD);
> -	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +	adev->vcn.inst[0].internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>   	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>   
>   		ring = &adev->vcn.inst->ring_enc[i];
> @@ -210,7 +210,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	adev->vcn.pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
> +	adev->vcn.inst[0].pause_dpg_mode = vcn_v2_0_pause_dpg_mode;
>   
>   	r = amdgpu_virt_alloc_mm_table(adev);
>   	if (r)
> @@ -292,7 +292,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev))
>   		ring->sched.ready = false;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> @@ -981,7 +981,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   		amdgpu_dpm_enable_vcn(adev, true, 0);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
> +		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indirect_sram);
>   
>   	vcn_v2_0_disable_static_power_gating(adev);
>   
> @@ -1421,9 +1421,9 @@ void vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
>   	amdgpu_ring_write(ring, 0);
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
>   }
>   
> @@ -1438,7 +1438,7 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[0].internal.cmd, 0));
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_END << 1));
>   }
>   
> @@ -1458,7 +1458,7 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>   	WARN_ON(ring->wptr % 2 || count % 2);
>   
>   	for (i = 0; i < count / 2; i++) {
> -		amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.nop, 0));
> +		amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.nop, 0));
>   		amdgpu_ring_write(ring, 0);
>   	}
>   }
> @@ -1479,25 +1479,25 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
>   	struct amdgpu_device *adev = ring->adev;
>   
>   	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.context_id, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
>   	amdgpu_ring_write(ring, seq);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
>   	amdgpu_ring_write(ring, addr & 0xffffffff);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
>   	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_FENCE << 1));
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
>   	amdgpu_ring_write(ring, 0);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
>   	amdgpu_ring_write(ring, 0);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_TRAP << 1));
>   }
> @@ -1520,14 +1520,14 @@ void vcn_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
>   	struct amdgpu_device *adev = ring->adev;
>   	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_vmid, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.ib_vmid, 0));
>   	amdgpu_ring_write(ring, vmid);
>   
> -	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_bar_low, 0));
> +	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_low, 0));
>   	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_bar_high, 0));
> +	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_bar_high, 0));
>   	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring,	PACKET0(adev->vcn.internal.ib_size, 0));
> +	amdgpu_ring_write(ring,	PACKET0(adev->vcn.inst[ring->me].internal.ib_size, 0));
>   	amdgpu_ring_write(ring, ib->length_dw);
>   }
>   
> @@ -1536,16 +1536,16 @@ void vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
>   	amdgpu_ring_write(ring, reg << 2);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
>   	amdgpu_ring_write(ring, val);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.gp_scratch8, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.gp_scratch8, 0));
>   	amdgpu_ring_write(ring, mask);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_REG_READ_COND_WAIT << 1));
>   }
> @@ -1570,13 +1570,13 @@ void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data0, 0));
>   	amdgpu_ring_write(ring, reg << 2);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.data1, 0));
>   	amdgpu_ring_write(ring, val);
>   
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_WRITE_REG << 1));
>   }
> @@ -1777,9 +1777,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	r = amdgpu_ring_alloc(ring, 4);
>   	if (r)
>   		return r;
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0));
>   	amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_START << 1));
> -	amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
> +	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.scratch9, 0));
>   	amdgpu_ring_write(ring, 0xDEADBEEF);
>   	amdgpu_ring_commit(ring);
>   	for (i = 0; i < adev->usec_timeout; i++) {
> @@ -1863,7 +1863,7 @@ static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
>   	adev->vcn.inst->ring_dec.wptr_old = 0;
>   	vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		adev->vcn.inst->ring_enc[i].wptr = 0;
>   		adev->vcn.inst->ring_enc[i].wptr_old = 0;
>   		vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
> @@ -1989,7 +1989,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
>   			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
>   			AMDGPU_VCN_CONTEXT_SIZE);
>   
> -		for (r = 0; r < adev->vcn.num_enc_rings; ++r) {
> +		for (r = 0; r < adev->vcn.inst[0].num_enc_rings; ++r) {
>   			ring = &adev->vcn.inst->ring_enc[r];
>   			ring->wptr = 0;
>   			MMSCH_V2_0_INSERT_DIRECT_WT(
> @@ -2178,7 +2178,7 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>   {
>   	int i;
>   
> -	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> +	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
>   		adev->vcn.inst->ring_enc[i].funcs = &vcn_v2_0_enc_ring_vm_funcs;
>   }
>   
> @@ -2189,7 +2189,7 @@ static const struct amdgpu_irq_src_funcs vcn_v2_0_irq_funcs = {
>   
>   static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev)
>   {
> -	adev->vcn.inst->irq.num_types = adev->vcn.num_enc_rings + 1;
> +	adev->vcn.inst->irq.num_types = adev->vcn.inst[0].num_enc_rings + 1;
>   	adev->vcn.inst->irq.funcs = &vcn_v2_0_irq_funcs;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 1d3780a2d8513..a3bac39e4c9db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -121,11 +121,13 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = 2;
>   		adev->vcn.harvest_config = 0;
> -		adev->vcn.num_enc_rings = 1;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +			adev->vcn.inst[i].num_enc_rings = 1;
>   	} else {
>   		u32 harvest;
>   		int i;
> @@ -134,13 +136,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
>   			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
>   				adev->vcn.harvest_config |= 1 << i;
> +			adev->vcn.inst[i].num_enc_rings = 2;
>   		}
>   		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
>   					AMDGPU_VCN_HARVEST_VCN1))
>   			/* both instances are harvested, disable the block */
>   			return -ENOENT;
> -
> -		adev->vcn.num_enc_rings = 2;
>   	}
>   
>   	vcn_v2_5_set_dec_ring_funcs(adev);
> @@ -176,7 +177,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		/* VCN ENC TRAP */
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>   			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>   				i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[j].irq);
>   			if (r)
> @@ -205,22 +206,22 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
> -		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> -
> -		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +
> +		adev->vcn.inst[j].internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
> -		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
> -		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
> -		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
> -		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +		adev->vcn.inst[j].internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>   		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
>   
>   		ring = &adev->vcn.inst[j].ring_dec;
> @@ -240,7 +241,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>   			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
>   
>   			ring = &adev->vcn.inst[j].ring_enc[i];
> @@ -268,6 +269,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -276,9 +280,6 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
> -
>   	r = amdgpu_vcn_ras_sw_init(adev);
>   	if (r)
>   		return r;
> @@ -369,7 +370,7 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   			if (r)
>   				return r;
>   
> -			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>   				ring = &adev->vcn.inst[j].ring_enc[i];
>   				r = amdgpu_ring_test_helper(ring);
>   				if (r)
> @@ -1018,7 +1019,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable register anti-hang mechanism */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> @@ -1746,7 +1747,7 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
>   	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>   			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
>   			adev->vcn.inst[j].ring_enc[i].me = j;
>   		}
> @@ -1917,10 +1918,10 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> -		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
>   
> -		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 13b9ed96cccda..fabe4d75a7f6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -127,11 +127,13 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>   		adev->vcn.harvest_config = 0;
> -		adev->vcn.num_enc_rings = 1;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +			adev->vcn.inst[i].num_enc_rings = 1;
>   
>   	} else {
>   		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> @@ -139,11 +141,13 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   			/* both instances are harvested, disable the block */
>   			return -ENOENT;
>   
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> -		    IP_VERSION(3, 0, 33))
> -			adev->vcn.num_enc_rings = 0;
> -		else
> -			adev->vcn.num_enc_rings = 2;
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
> +			    IP_VERSION(3, 0, 33))
> +				adev->vcn.inst[i].num_enc_rings = 0;
> +			else
> +				adev->vcn.inst[i].num_enc_rings = 2;
> +		}
>   	}
>   
>   	vcn_v3_0_set_dec_ring_funcs(adev);
> @@ -198,22 +202,22 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> -		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> -		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>   
> -		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
> -		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
> -		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
> -		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
> -		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
> +		adev->vcn.inst[i].internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>   		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
>   
>   		/* VCN DEC TRAP */
> @@ -227,7 +231,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		ring = &adev->vcn.inst[i].ring_dec;
>   		ring->use_doorbell = true;
>   		if (amdgpu_sriov_vf(adev)) {
> -			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
> +			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1);
>   		} else {
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
>   		}
> @@ -239,7 +243,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
>   
>   			/* VCN ENC TRAP */
> @@ -251,7 +255,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			ring = &adev->vcn.inst[i].ring_enc[j];
>   			ring->use_doorbell = true;
>   			if (amdgpu_sriov_vf(adev)) {
> -				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
> +				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.inst[i].num_enc_rings + 1) + 1 + j;
>   			} else {
>   				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
>   			}
> @@ -277,6 +281,9 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -284,8 +291,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   	}
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>   
>   	/* Allocate memory for VCN IP Dump buffer */
>   	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
> @@ -373,7 +378,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   				ring->sched.ready = true;
>   			}
>   
> -			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   				ring = &adev->vcn.inst[i].ring_enc[j];
>   				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
>   					ring->sched.ready = false;
> @@ -401,7 +406,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   			if (r)
>   				return r;
>   
> -			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   				ring = &adev->vcn.inst[i].ring_enc[j];
>   				r = amdgpu_ring_test_helper(ring);
>   				if (r)
> @@ -1153,7 +1158,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
>   	vcn_v3_0_disable_static_power_gating(adev, i);
> @@ -1433,7 +1438,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   			mmUVD_VCPU_CACHE_SIZE2),
>   			AMDGPU_VCN_CONTEXT_SIZE);
>   
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   			ring = &adev->vcn.inst[i].ring_enc[j];
>   			ring->wptr = 0;
>   			rb_addr = ring->gpu_addr;
> @@ -1921,11 +1926,11 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   		uint32_t reg = amdgpu_ib_get_value(ib, i);
>   		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>   
> -		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> +		if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data0, 0)) {
>   			msg_lo = val;
> -		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> +		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data1, 0)) {
>   			msg_hi = val;
> -		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
> +		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.cmd, 0) &&
>   			   val == 0) {
>   			r = vcn_v3_0_dec_msg(p, job,
>   					     ((u64)msg_hi) << 32 | msg_lo);
> @@ -2089,7 +2094,7 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +		for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
>   			adev->vcn.inst[i].ring_enc[j].me = i;
>   		}
> @@ -2255,7 +2260,7 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].irq.funcs = &vcn_v3_0_irq_funcs;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index dbbeeffc90726..ee87594fafa60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -129,8 +129,9 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	}
>   
> -	/* re-use enc ring as unified ring */
> -	adev->vcn.num_enc_rings = 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		/* re-use enc ring as unified ring */
> +		adev->vcn.inst[i].num_enc_rings = 1;
>   
>   	vcn_v4_0_set_unified_ring_funcs(adev);
>   	vcn_v4_0_set_irq_funcs(adev);
> @@ -214,7 +215,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		ring = &adev->vcn.inst[i].ring_enc[0];
>   		ring->use_doorbell = true;
>   		if (amdgpu_sriov_vf(adev))
> -			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
> +			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i *
> +				(adev->vcn.inst[i].num_enc_rings + 1) + 1;
>   		else
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
>   		ring->vm_hub = AMDGPU_MMHUB0(0);
> @@ -226,6 +228,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		vcn_v4_0_fw_shared_init(adev, i);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
>   	}
>   
>   	/* TODO: Add queue reset mask when FW fully supports it */
> @@ -238,8 +243,6 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
>   
>   	r = amdgpu_vcn_ras_sw_init(adev);
>   	if (r)
> @@ -1111,7 +1114,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
>   	vcn_v4_0_disable_static_power_gating(adev, i);
> @@ -2172,10 +2175,10 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
>   
> -		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 8396ef6831b69..35854e074d142 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -114,9 +114,11 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>   static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	/* re-use enc ring as unified ring */
> -	adev->vcn.num_enc_rings = 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		/* re-use enc ring as unified ring */
> +		adev->vcn.inst[i].num_enc_rings = 1;
>   
>   	vcn_v4_0_3_set_unified_ring_funcs(adev);
>   	vcn_v4_0_3_set_irq_funcs(adev);
> @@ -194,6 +196,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		vcn_v4_0_3_fw_shared_init(adev, i);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
>   	}
>   
>   	/* TODO: Add queue reset mask when FW fully supports it */
> @@ -206,9 +211,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
> -
>   	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
>   		r = amdgpu_vcn_ras_sw_init(adev);
>   		if (r) {
> @@ -1138,7 +1140,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	vcn_inst = GET_INST(VCN, i);
>   	/* set VCN status busy */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f6b347fcdb7ed..0700a5f96084c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -115,9 +115,11 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	/* re-use enc ring as unified ring */
> -	adev->vcn.num_enc_rings = 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		/* re-use enc ring as unified ring */
> +		adev->vcn.inst[i].num_enc_rings = 1;
>   	vcn_v4_0_5_set_unified_ring_funcs(adev);
>   	vcn_v4_0_5_set_irq_funcs(adev);
>   
> @@ -173,7 +175,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		ring->use_doorbell = true;
>   		if (amdgpu_sriov_vf(adev))
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -						i * (adev->vcn.num_enc_rings + 1) + 1;
> +						i * (adev->vcn.inst[i].num_enc_rings + 1) + 1;
>   		else
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>   						2 + 8 * i;
> @@ -198,6 +200,9 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -206,9 +211,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v4_0_5_pause_dpg_mode;
> -
>   	/* Allocate memory for VCN IP Dump buffer */
>   	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>   	if (!ptr) {
> @@ -1014,7 +1016,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
>   	vcn_v4_0_5_disable_static_power_gating(adev, i);
> @@ -1624,7 +1626,7 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_5_irq_funcs;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index c5d59edf3a482..eeb3c9875ad50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -98,9 +98,11 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	/* re-use enc ring as unified ring */
> -	adev->vcn.num_enc_rings = 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		/* re-use enc ring as unified ring */
> +		adev->vcn.inst[i].num_enc_rings = 1;
>   
>   	vcn_v5_0_0_set_unified_ring_funcs(adev);
>   	vcn_v5_0_0_set_irq_funcs(adev);
> @@ -184,15 +186,15 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +
> +		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +			adev->vcn.inst[i].pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
>   	}
>   
>   	/* TODO: Add queue reset mask when FW fully supports it */
>   	adev->vcn.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>   
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
> -
>   	vcn_v5_0_0_alloc_ip_dump(adev);
>   
>   	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
> @@ -791,7 +793,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	/* disable VCN power gating */
>   	vcn_v5_0_0_disable_static_power_gating(adev, i);
> @@ -1367,7 +1369,7 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
> +		adev->vcn.inst[i].irq.num_types = adev->vcn.inst[i].num_enc_rings + 1;
>   		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 51a2d70a65c9e..f428d23eb2857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -58,9 +58,11 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	/* re-use enc ring as unified ring */
> -	adev->vcn.num_enc_rings = 1;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		/* re-use enc ring as unified ring */
> +		adev->vcn.inst[i].num_enc_rings = 1;
>   
>   	vcn_v5_0_1_set_unified_ring_funcs(adev);
>   	vcn_v5_0_1_set_irq_funcs(adev);
> @@ -586,7 +588,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev, int i)
>   	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> +		return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
>   
>   	vcn_inst = GET_INST(VCN, i);
>   
