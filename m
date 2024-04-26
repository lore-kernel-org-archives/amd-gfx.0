Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63679C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 22:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02C311AB1B;
	Fri, 26 Apr 2024 22:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gwI7gi0j";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F5D11AB1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 22:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvxQ87AhHytX4tbXlB4JNI3vAanLrPD0c+HR1afcXLZ7Ldp4iw+GdoF47ZJ+JM8e4xJdGgJOhJkPNOc+QF1+rx1MKH6VQVJDGChbyBSDnxtxQ9DB4Xr0QT2qLK1ZPqvI2F7AaS7P94cbxYLgPo3pdiRtsa5WdtO3GPIeI1dulsP4Jo1qbFXvWz10HNlEyfGlEcDKR+TsFq0kVzYMQqbs+yxIW54XQrQAJHeWXQAD30HHWdlo0lz6ULNVtV6/aD/NP/8huEFXUUes6kvYZ/rFa1rQgJ/tWNOxNLvLFYeu1iPz3Yh5ayGzd4c5ZWXSgrvN8z2D9Xo1ujHESI96AiR+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlad+79r1rm8oHZtEjKCdrMtix+0uHwacWCeJ4wyEKs=;
 b=KO6IEorIQHw3ZjIIrHpSRGAHl+aTjbEvgt5FD/2xGK2U199GekSy3lbmU9N7W5xNwPReheMzgQXsR/qdJAvxzT65QOyRLyf0yPNc0Qob72inzP04T6d3p4HgjEDYP4nRKO6Jcdkk5bhjVvjhqDFkHQVZIVXiSteOJTyKG9A+11qrw7jV6dBZz08fNIdon8mi5WfQUmSp3gi3kAeNjydGmqT8C5E3jlptthjN1EybVUWneCp/20buV3XJdBhypsKVQxsyCemLLO0FAl4Eu8BIZwdxcTiuwDuWb9t1h0aiC/AVtF5kovhqSaG1+Mhy0zi5s8ex+xe3bVV4y3ql80sVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlad+79r1rm8oHZtEjKCdrMtix+0uHwacWCeJ4wyEKs=;
 b=gwI7gi0j7PVJNRxMyxgqx2vpBAekx73NkiYlFFHGPrO/arGQm2cCbNnx34rzOjQnzqx/QXi5rLDWEBXJ0CL7JRRbbnNe9BK7RxQ28rJQyKYVTtwShJ9ZzZSw0xBAs4IqNp/OPqUegj/tpTSadZCdVofl0eDgkbhPu1BRVzGrIho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 22:51:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 22:51:50 +0000
Message-ID: <a121a72c-b441-4f42-94a3-4597b7f19e7d@amd.com>
Date: Fri, 26 Apr 2024 18:51:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Let VRAM allocations go to GTT domain on
 small APUs
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>
References: <20240426083750.485808-1-Lang.Yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240426083750.485808-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbd813d-8e1e-4acd-ffdd-08dc664375fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThHQVhESFVaa29FMGR1WDVLQ2tjN2tWUGRyTEhlMjJNRUc5eVY3aUhaVzJp?=
 =?utf-8?B?N2QvRzJaWWRXWjNZb0Rjd2lzSW1MT0pJUVpPSWxKSC9Qc3hCd3dUR0pEdFlF?=
 =?utf-8?B?VElhSVNmNCt0RnQzdElVQ2o2MVNLdWpRRWI5MUpoRndjdnE4d0lTSHdhdWNw?=
 =?utf-8?B?ck90WDUxRFk4bmxXU2tiZ3MvMjFMeVF1T0NDamNoZlZRRFd2Vm84Rk13cjh5?=
 =?utf-8?B?cXJkSHFyMTlZWjBKU3RETHFPT1BuQlpoakphZnJyOTBjV0MzeVFFa0VEL2VZ?=
 =?utf-8?B?c1RVRXQ5ZXQyTHo2ZnIxVVU1bmdtOWx0L0pIUnh5SlF5VG94V3dFMlpkd0Z4?=
 =?utf-8?B?Tnlmbk9BWGRPZVF6WFlGZllrcm5mZGtvTzRWUWdha0R4b0drMlJtaHBkaEFm?=
 =?utf-8?B?R2xWbXIxdktqZy9hMWUxOUdaNDViN0FYYkFIQmdITExwQzYrMEVNeGlVVXNa?=
 =?utf-8?B?cThJYVNJUHZmSXhya0d1enVEVFJaT2J6elpLR09WOGpwbjZUcFhBYUswRGlT?=
 =?utf-8?B?ditSaVZVRkFRY3pQWk12T0xtVGNnKzZ4Z2F0RWg3L2pXdmN4S3JDQTR5VVgz?=
 =?utf-8?B?cTU3UmZiWm1BVzBkaEtCMDJHc0tZbURYVlJPRUVyVEFHaU0za0MxVEhEa0RB?=
 =?utf-8?B?a2Q2dVc4RnZPNEJ2L1I0a2gxWGxackQyZ3Q5ZE9tRWlMcVE3MWJhREVrb1ZB?=
 =?utf-8?B?K1YveUFYdmxvVG5xWDBWYlVCL0RnVmNDWDVSazd1QWtkOVc3Y3JlQVVQZUtL?=
 =?utf-8?B?SEN4K0JwNnh2Ry9PbVVsWlJwT3dqR2M3NFdjaEVvWEV5VUxnWGc3ZmltQnFK?=
 =?utf-8?B?aUZ4TjBsV1c1bXFOdXdXWDZpczN0SmRick5rdC9zaHVlWFhCTE1Jd05XYlN2?=
 =?utf-8?B?bHJOTlpmWnlnOHlmelVUTnpvY3U5d3NFUUlJbzJwdWVHYWJQbjFpWWFtQndZ?=
 =?utf-8?B?V2ZQYmJ4Nk04SysrL20yeTFaM0Y3UmFSTW11RG42OGYvWTIvRkJtUFUxcDVk?=
 =?utf-8?B?aTZ3WmVsUFhnTy90QmY2azdrOGRocW16dTNYUVBKZ3AzRkFadHdONmZXd1pL?=
 =?utf-8?B?RlJqTE50ekFDZGg2THhZY0dDWU8rZmRyMXpuTTExdDRhajRFSzZrY2NJQ21S?=
 =?utf-8?B?WHl6ZnU4d3dERi9wWTg1Z2VTSnlJa1BURVltWmZBN2JTNjVNUlR2aWsxSWds?=
 =?utf-8?B?VDdXNWs1TDBzYnluOHhjODFVaTNXSVdiL1lxekJPRTd1R3liajcrNC9xV2Vw?=
 =?utf-8?B?cmw3cTRnVHl6TlU3cEo1Q0Zpd2JkOEp2aWJsLzY0dnlnODlqZlZiUHY4V3U2?=
 =?utf-8?B?TndaSU51N3VQQ2gySndPL1dpM0VDNWVOMndEWkwrMUxvd3lGTHA2Wm5kRlhm?=
 =?utf-8?B?ZjdlbHV0ZnZ0QkZFMHJwS0hERkNqZm9qcFRpcUkvY09QTzEzR1FIU0pVbHN0?=
 =?utf-8?B?c0R6UWFEREJiSE1xdFp5RVpUaTQ5N29ZK2JXMXdhM0hkY3JGYmM4WUtnTmJO?=
 =?utf-8?B?VnM5Y3RVcm96YnAwZW94U3QyOEh4Z2NPdEovQStJMDhOaGNLU2I3MkViSDZL?=
 =?utf-8?B?aWVUSkdwU1ZSR01OT3ljaG0rWm1lQW02dk1jcXV4SUsxK0E1bVhmdHNjTHYz?=
 =?utf-8?B?ejlVQnBseVBIeCtXaVZUTkFrdzhBbkNFV29ZaVczNTZDbVkzVXBiQ1F6ajd0?=
 =?utf-8?B?dld5azZQL3BlTWs1UTJ4bkdZNzZCZUdrQUpJck9FV25nTGYzeEVZOStRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJYNENiZWhSOUVyeTQxOW12Zm9HaFlsRy8wMUFuT2kzRG9oUEtXMk85akxv?=
 =?utf-8?B?U2xhRmxpRldwTXFwTElwNk05Y3ZYeWtEQklWSzB1WmpRM1pmQU1uK2QxTXky?=
 =?utf-8?B?d25JMGJKTzk2K0NGVklpaDVMbytQQk1qTnFSSHdUWTdsNEhXL3VuUEZkbGZQ?=
 =?utf-8?B?M1dvMXhOM1lKUlFTa3hJTlNvYURFTFM1VFlUa084TjYvelJqWnZQY0xVb0xY?=
 =?utf-8?B?Kyt5TVoxb3pkK2NUZ3dHVG9YT2dwZHFuK1F0U0w5VlNFd2VpV2NWQVNDbkVa?=
 =?utf-8?B?VjYyRGNVQW5CZUdjbCthZVhSSUVKM0VwZmRrZHF1eHR2MVZpUm9jRmhEdzBh?=
 =?utf-8?B?L1hOQ1NLWk9LUUxWU2JxRGZIS0hXZjZPUE5NUUlJdU82YUpPRTByYzNCNGw1?=
 =?utf-8?B?dk45MVQ1V1dXeklkdVo4Tkt5NWVNYnZueldpOTY4ZE4vSmVsWHVBVTJGS1k3?=
 =?utf-8?B?WWFhdkQ2b0FEVzRERTltT29RWG5icWs2aWM5eE1DN2VJcGxTYWRYYzZTN1VN?=
 =?utf-8?B?VVZxb1BUSEdGKzdZMWF6dWNkWnJuNkdhcFF0dzdxVmhoTUR4aW5lNTBhcnhT?=
 =?utf-8?B?L1hTaXB0bzY4TTZBemg1NGdKcEZETGVKZ0FlWVZOUUx6UDFKSWRmNXpLTnpL?=
 =?utf-8?B?TlNJYVJXb0xoVTFBSTdmWFc1cFR3OGxRak9FN1ViN0hBeE9ZOGUzcCt3bUE4?=
 =?utf-8?B?dG50ckxZQzFEbzJSSUlXLytLcUpwQXZVUVVVVXFmTzZ1R0pqRGlEc3ZhSFJY?=
 =?utf-8?B?RUMzU0Q1RytFYmVGdmVPUVAvNEViZEl5dDZJV0pPaEhweXo0ZDIyVjVFY21P?=
 =?utf-8?B?MUR0VUpISzlzRzM0b3V1ZWdWQm4wK0Y2RDJ1Um9xeFM4WU1NSHQwY0tycG9P?=
 =?utf-8?B?RzkyYTNBcEpiZnM5MmNzRjcxS3NxNVY4UjN2MTU3TkgzbjMyeUNmV1hQVzNj?=
 =?utf-8?B?RlIzL3FKRUsyelpLYm9Ud0FUOWFad0Q5UDNYd25JeXhDc2czVXhIZVZZcWpa?=
 =?utf-8?B?aHVpTHpaL0I5Z1pLNGw0blVzOFFDUWVoMUxnd2NzUGthWXZBcTlsZ1RTQkl1?=
 =?utf-8?B?UDYrS0xkL0RaR2xJWmtqVWIvVFJiVTZDNE4vMzBrVnR4TElGaXMyRnFXNjRw?=
 =?utf-8?B?TVJabjJOMDN6Mlg3TzFZL3Y1dzJmanZGOExCZW5YUStpOXp2clcrc21OUnhY?=
 =?utf-8?B?V0dYNE9iUDBWdnhEMERtVHI3UnlLK24za0VodEJ0c1I1a0NSdGFPSUw4NFVx?=
 =?utf-8?B?cjJVYTZ2L2lEUEMzMDZqK3FUTy9hSmZDR1M0cy9mTWVxajljU2FNTUwxZTQv?=
 =?utf-8?B?TVF3RXRhN3dXVFBPTVJrc0FOWFk3cE9lc1l5SUppVmk0Szl3RVkzenZ3M1la?=
 =?utf-8?B?bGxJSk1WT2Y5cVBnWFBaYjBWcFU4WHlQTXdWT0lNNkQyUEJ5a2ZDaGZXbSt4?=
 =?utf-8?B?eS81amZvb0F5RklyMVRBemx6bnlTaG0vaXBKTFhocm9ZeFhxRFFqZ0c1UVBK?=
 =?utf-8?B?LzZ2UlVVWi9WWHM4YWc0ZGdWRUQ2S1A3aW1xMzFSQmxVUGNjaTVtWU9KeFo5?=
 =?utf-8?B?dlJ1bXdZcjNwSGRQUW44bTQ0VWNhR3dSRFZJZW1BQWx4bE9vd3gvK1ZVS1No?=
 =?utf-8?B?ZVJDc08xN3loNEp2QWJON2FuQjZyWThjNFJaOXR0L3dBdVgzMVhVVjVqbmxj?=
 =?utf-8?B?Q2NxZFlsNXJHL1o2VWJ2cVR4WkdvWW9vaTRFSS9OWWpEbVg2V3VoVHhnT3h0?=
 =?utf-8?B?Q3E4TUdiZVN1VlRkK29UU3JWQ1NKbUNlV20yRGxMTS9SWWc0S3YrZmw1eVVL?=
 =?utf-8?B?Q2VSLzRlMHFSM0laMzlzcnJUaG55VDlDM3h6ZlVhMS9vRDZ4NWM5SzlqNnhw?=
 =?utf-8?B?c0Fxa0NRMG9LbWhUcGE5L2kxT0JQMzBnODc3TTNTS2pIOHlacE12UmZEem5j?=
 =?utf-8?B?N3JSM1IraEVuV0VCR1Jyc1ZYTGsvcEticTRVTWhxUnJXNUJCWFkrVnp0QzhT?=
 =?utf-8?B?bGp2dHZSS04zY1Jjblg1cWNOVmFFb3FpYjFTOGhyOEgyaVhEUG1PQjF1WDdM?=
 =?utf-8?B?VWhiQU9BUnhURkRST2xOK3lodngzS3JvS2hyd3FnZzhhczJnTVgvdk5ZMXVS?=
 =?utf-8?Q?RstwQinXq8aNoHSz72c7vG4Ti?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbd813d-8e1e-4acd-ffdd-08dc664375fa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 22:51:50.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jom7aBvlBh1w+eYVeAGzw/H7/SBsrHgprt9YvlDBeiTekUsx2J9Qlqnooky2SBMo8qp+9Hmxa9CrM3klylD5dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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


On 2024-04-26 04:37, Lang Yu wrote:
> Small APUs(i.e., consumer, embedded products) usually have a small
> carveout device memory which can't satisfy most compute workloads
> memory allocation requirements.
>
> We can't even run a Basic MNIST Example with a default 512MB carveout.
> https://github.com/pytorch/examples/tree/main/mnist.
>
> Though we can change BIOS settings to enlarge carveout size,
> which is inflexible and may bring complaint. On the other hand,
> the memory resource can't be effectively used between host and device.
>
> The solution is MI300A approach, i.e., let VRAM allocations go to GTT.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Two nit-picks inline. Other than that, this patch looks reasonable to me.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 +++++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 +++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  3 ++-
>   5 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7ba05f030dd1..3295838e9a1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -456,7 +456,9 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   			mem_info->local_mem_size_private =
>   					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
>   	} else {
> -		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
> +		mem_info->local_mem_size_public = adev->flags & AMD_IS_APU ?
> +						  (ttm_tt_pages_limit() << PAGE_SHIFT) :
> +						  adev->gmc.visible_vram_size;
>   		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
>   						adev->gmc.visible_vram_size;

On an APU the private size should be reported as 0.


>   	}
> @@ -824,6 +826,8 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   		}
>   		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
> +	} else if (adev->flags & AMD_IS_APU) {
> +		return (ttm_tt_pages_limit() << PAGE_SHIFT);
>   	} else {
>   		return adev->gmc.real_vram_size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c4f9960dafbb..7eb5afcc4895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   			return -EINVAL;
>   
>   		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
> -		if (adev->gmc.is_app_apu) {
> +		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   			system_mem_needed = size;
>   			ttm_mem_needed = size;
>   		}
> @@ -232,7 +232,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		  "adev reference can't be null when vram is used");
>   	if (adev && xcp_id >= 0) {
>   		adev->kfd.vram_used[xcp_id] += vram_needed;
> -		adev->kfd.vram_used_aligned[xcp_id] += adev->gmc.is_app_apu ?
> +		adev->kfd.vram_used_aligned[xcp_id] +=
> +				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
>   				vram_needed :
>   				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
>   	}
> @@ -260,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   
>   		if (adev) {
>   			adev->kfd.vram_used[xcp_id] -= size;
> -			if (adev->gmc.is_app_apu) {
> +			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   				adev->kfd.vram_used_aligned[xcp_id] -= size;
>   				kfd_mem_limit.system_mem_used -= size;
>   				kfd_mem_limit.ttm_mem_used -= size;
> @@ -889,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	 * if peer device has large BAR. In contrast, access over xGMI is
>   	 * allowed for both small and large BAR configurations of peer device
>   	 */
> -	if ((adev != bo_adev && !adev->gmc.is_app_apu) &&
> +	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
>   	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
>   	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> @@ -1657,7 +1658,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   		- atomic64_read(&adev->vram_pin_size)
>   		- reserved_for_pt;
>   
> -	if (adev->gmc.is_app_apu) {
> +	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   		system_mem_available = no_system_mem_limit ?
>   					kfd_mem_limit.max_system_mem_limit :
>   					kfd_mem_limit.max_system_mem_limit -
> @@ -1669,6 +1670,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
>   		available = min3(system_mem_available, ttm_mem_available,
>   				 vram_available);
>   		available = ALIGN_DOWN(available, PAGE_SIZE);
> +

Unnecessary whitespace change.

Regards,
   Felix


>   	} else {
>   		available = ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_ALIGN);
>   	}
> @@ -1705,7 +1707,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
>   
> -		if (adev->gmc.is_app_apu) {
> +		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   			alloc_flags = 0;
> @@ -1952,7 +1954,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	if (size) {
>   		if (!is_imported &&
>   		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
> -		   (adev->gmc.is_app_apu &&
> +		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
>   		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
>   			*size = bo_size;
>   		else
> @@ -2374,8 +2376,9 @@ static int import_obj_create(struct amdgpu_device *adev,
>   	(*mem)->dmabuf = dma_buf;
>   	(*mem)->bo = bo;
>   	(*mem)->va = va;
> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) && !adev->gmc.is_app_apu ?
> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> +	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
> +			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
> +			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>   
>   	(*mem)->mapped_to_gpu_memory = 0;
>   	(*mem)->process_info = avm->process_info;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 4bcfbeac48fb..4816fcb9803a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
>   		return -EINVAL;
>   
> -	if (adev->gmc.is_app_apu)
> +	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	pgmap = &kfddev->pgmap;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bfab16b43fec..238ac11bb97d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2619,7 +2619,8 @@ svm_range_best_restore_location(struct svm_range *prange,
>   		return -1;
>   	}
>   
> -	if (node->adev->gmc.is_app_apu)
> +	if (node->adev->gmc.is_app_apu ||
> +	    node->adev->flags & AMD_IS_APU)
>   		return 0;
>   
>   	if (prange->preferred_loc == gpuid ||
> @@ -3337,7 +3338,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>   		goto out;
>   	}
>   
> -	if (bo_node->adev->gmc.is_app_apu) {
> +	if (bo_node->adev->gmc.is_app_apu ||
> +	    bo_node->adev->flags & AMD_IS_APU) {
>   		best_loc = 0;
>   		goto out;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 026863a0abcd..9c37bd0567ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -201,7 +201,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>    * is initialized to not 0 when page migration register device memory.
>    */
>   #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
> -					(adev)->gmc.is_app_apu)
> +					(adev)->gmc.is_app_apu ||\
> +					((adev)->flags & AMD_IS_APU))
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
