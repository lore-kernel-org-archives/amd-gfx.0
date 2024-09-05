Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2984ECD4F5B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 07:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A2E10E722;
	Thu,  5 Sep 2024 07:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N2f2BxRA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E44710E722
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 07:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgnQmKjcpJwo7dh/amHz3XaPxYcJfSqYAKP9kO49vi+drVQodRUwSuU1PclXTu7aj69U3dlFONvwMMWSueKDcDhaFUkmfLeZi5crZWRVxP/m4gLvUf/F9BPVvY3bQjfjN5RROBwtZlTRpMjp/wuon3ZF/oPmbmC6Y/0+EvIjoNSatcMvLQ7Pl5JdMcQ0gb8xDLfu0Wwar9sTZkav9Cu0fdpZXPd+WyGQzaYTE5t33dQe5vEf+1tEK0RJvUPCC+Z5WrTVr6FmmEYD/pqW0gZLkyTDAYWFpe3F0zJCRmX3b0bDwoFHHUi3NdictSjDuMYNmehQ0MKv0uqEo2IY+7vn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ3HKzRf0fAocIrPyOyopitaCpKrGEmiXmWVyMNU5Qk=;
 b=r+8DREqJ6GUDonT0ew1rv1rLT5+l3RGKa5My63XY53LDo4YBY1IwB0qaRMo5Vq/NPITzxhh3YC3a4oM8R2vK7luo9WVCQPyh2Odcl/B+UpA3aqjbM6V9/Q3p+fOo8hq6hVDBuKFVu269KHj01Bgti9bkedaEBq7WI+Uhs1n6tABZxijWkDQ+kabQ1W/B4G1OpEZfP21YMsBjBsDW9/QVUc07YH921kT06tO7HsqBH7uZBZZDPS+l2GHMl0UuHnSFf7iiHTwTPy1k2G6vyzeDr09cmjWAX1gmpY73ATzLZrjeVQbdxGGPHdBjZYXqBUdzjljYdz3xMzZ7Y/keHhPsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ3HKzRf0fAocIrPyOyopitaCpKrGEmiXmWVyMNU5Qk=;
 b=N2f2BxRAfTsN7++Hf7H5bNtoXipLSMfM0p8myHtgXlss2nDQxTzSsVxXs1KX+Exne1E2xZdiBfB2Y7bQz0qq3P0tZLmJzzXG8DeD4VIsk8ielTF92OAZp+PAs3RifQnPRbpgr93yE6yxve5nBtLRkoVEEAepl8hx1wDl27LnYqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 07:41:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:41:55 +0000
Message-ID: <67910b74-8b62-40b3-9f65-e59e64ab4f0a@amd.com>
Date: Thu, 5 Sep 2024 09:41:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/: Add missing kdoc entry in
 amdgpu_vm_handle_fault function
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "Xiaogang . Chen" <Xiaogang.Chen@amd.com>, 
 kernel test robot <lkp@intel.com>
References: <20240828030926.4065919-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240828030926.4065919-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 404fecd0-350a-46e3-16d6-08dccd7e36ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjZsaXh5WkRDT3FtQ0tPWUg4TUZLdjh3UnR5TXVSNkZGYmlaQTlWaDNFVzlU?=
 =?utf-8?B?czUwOXRuVzlEai8rK2owN2F4amg1aVpvMytXSkhvNy9wV3FZWVV2THBjbjYz?=
 =?utf-8?B?TWNTMTYwNTlsSUpXTEk1c0VONUlPUFB4UUV0TDVnbUhoSkRNc2xrSG9IbUp5?=
 =?utf-8?B?VGh4Ynh2empLVy9rNlBiRnAxa1pEL1hXN3JXeWZRak5LZ2N0UzYyS2RPVHRI?=
 =?utf-8?B?Q3ZUVk9SZzB6RnVaZzRCUlV5cGFIOGxqMlF0aWJtRHBkVStBRW05SmI3bkRV?=
 =?utf-8?B?RndtbzFBOHlaTHFvK3F1a1BuWW5nSDB2ejJCSllpTTEwVjNIS3NadERlOWk5?=
 =?utf-8?B?UU9JbllIWEh5YlFVRTcvVUhMRVpCSzIxU1hTU0JFVlpNVytNK3BYVmNtRGJC?=
 =?utf-8?B?T1h1Wk5kWEV4OFFPVmlnUkxuZnlwNDNtK2Z0RGJpVVMrRVdxYjd1d1FzeDRp?=
 =?utf-8?B?WjFOcXZNU1pLbUYvNDZiK2dqb3crY05MNzhxVFREMlEzZEZKNjFlNWw4RjJY?=
 =?utf-8?B?dVAraFNoUHJmT2MyUEFONlExNEtROE1hTWMwaXY3SVNKa0wrRnNpbllyWEU2?=
 =?utf-8?B?MVpBbXJ6czBHZ2VHVUUwbkVSaFdYNDIyQjZQb1VUelRCSTRxL1A5Q242OVM0?=
 =?utf-8?B?Qk5rbXR5SUV2MVdBc3VDYXI5Z0xxV3IwL0t6UE1oTWVUN0dmZysrcXpOQnNC?=
 =?utf-8?B?bkRnRm9VMjdZSmVzYUxOMHFINHRJTXp3ejBaWmJocGwwcmVHb0pmNncvUTRt?=
 =?utf-8?B?d3JlNVhxSGV4ODB2blhlamZQampFa05FVHNTemErMDh1OUhyZHlLRnA0Q3BJ?=
 =?utf-8?B?WC9JQ3Y4Vnp5MTRkWkM4M0lIalB4L2JudUkwY1dQTGhYdDZOdHhEeEVUMmZu?=
 =?utf-8?B?OFlpMHVFZjgxbzJ3cnd4UDkxRGVzNi9sV3dMenpQWUQwK3lVZ3B4enRuT2R2?=
 =?utf-8?B?TElGMURXU2tYa3V2N1ArZE1NdTIwSWpOeFJjbnovbTVmaDlKdThicnU4NWVt?=
 =?utf-8?B?bzBORFp1bkJlMkZkS1Y2NlBpdDJLblk2TDRrN1RoT0NzZ0w5N2FoaXZpUG9s?=
 =?utf-8?B?MlR2bXJLMGlwTWFFeUhseTRld1UyYjFoQlE2Z01CNEhWa1FvQmdIdUNmditm?=
 =?utf-8?B?UXhSTlRBWllxWnV3MzNmdzRwMXpzWlJGbEZCUjBYZzFLOHY5Tk9PMXBFQmhS?=
 =?utf-8?B?QldPNFd1UDV1ZlBVa3RrdGkrNFY1NDBndHdzRHFFWVZxT3ZyZGsrVGYxUnIz?=
 =?utf-8?B?aTZKNEVwcjQ0ZmRlc1lOV0VLcEhDYnVxeit3bEVocnpHNWswSkVoOGdjc1hv?=
 =?utf-8?B?S3JHbEpZNFVJZFdwT3kxM1NiWmdZb1JycWZzTVlXazdGbDBVRTl2a0Q5SWMz?=
 =?utf-8?B?RENjTVZrSHEycXJIdVJRK3lTUTdpQUNFbUZabWxZMkhpSDgzN2g0T1YvSlBO?=
 =?utf-8?B?cWZPM2g3U1NDZW4yTlV1RmdGNFVHUGxUQVhjN1MwMnB2K1VKSTVmdlNHdE9q?=
 =?utf-8?B?VkpIZHQwelp2ZGtmRDZyM0x1OUFqbTd1S3p0OXdhQnkyZEtXUWNDV2VJZ2I1?=
 =?utf-8?B?REcxRkVnV1VBRzZvVHdHN2ViY2Q3am02Rm93YlVvLzBnN2JDdHdBb1YxZHJl?=
 =?utf-8?B?UGxENWZmZnhyTHhHWkc1Q0V3SGdRdlplQk4weVkzclh1YUdsR3lONk1WVVZu?=
 =?utf-8?B?MzIvK1ZTSEZGdFk2aEVYSDRTYmw2UFE4QW5pck9Ka0Z1am1wV1ZrbWxVZS81?=
 =?utf-8?B?NklnN2VTRkRJMEROMkhaTkFkVlczOG0wakkvN1BKZUhXZWtLME5IbWVkRjJY?=
 =?utf-8?Q?UCLlG0NEkoksQMwM8Fzt8n0aKxBHCQVNwNdC0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdEb1MzRnJub2FjREhPMjhIenViY1pwWU1VSm5tdndmVGlTVlBpNTV0NzZS?=
 =?utf-8?B?eDN5Ly9ZaXIrOFI1ckhYMTgvNmhJOTdGU0VBb1hoWnVzSTgwZWdkd1RIemlH?=
 =?utf-8?B?a2RCQWdQcUtLdThzSkxvUUQ1SVN3U1d3TmdTdlV6Qi9rRDRnQTQzWHFBdUw2?=
 =?utf-8?B?dEUwVUVQUDA4UlFEVDM3LzJocXdvL21nejRBL2VIejdpWURLR1AzWEpGNFIx?=
 =?utf-8?B?c3JMVDRUS1orVmNLbGZLNzhOQmJzblNtUnFiUkZyZ2VmY0ZuY0dNT2tDbG1L?=
 =?utf-8?B?a3p5TW9NT1gzQmtJeEwyZ0JpOVVoT3ZhcTVZL0w3bzFZckFuTWVLQ1RWQW12?=
 =?utf-8?B?bGl0QjhTOHA1UjYxMWU2NWJuWi9xZFlyZDliYkZ5ek9xcTdMYys5bmZaQ3h3?=
 =?utf-8?B?Tkxhb3A0akltdGZyckJwb0hsa0JwK1ZkcmNzemV1N3R6dko0WUMyWEpCWExL?=
 =?utf-8?B?c1lacTh0VHBiT1RqVS9KY010dEJ1NHA0eWNWNUI1d0ZWTCtYd2JuZXdxZzg5?=
 =?utf-8?B?SWNwVjNJNWo5MnE0RlZ5VHcyUklXV0RFM3hqdkFldjBzU0tWaEtIMjFwejlW?=
 =?utf-8?B?Z0Yyc25DNHlaTHN3SEhpK1VCYStKZWYyb2g1eUJKZGovMHErckFMVUZyVVNK?=
 =?utf-8?B?ajJXTU43bzkxaEc3R1NtQVJrRUthb05LS0s3c1p5OHZZa2phSmx6TXNrV3B3?=
 =?utf-8?B?azZRNGJvUURVSVJpVklNcUhxNy8xR2l6NmJHcElRbElUdDllMTRJRmcwcThw?=
 =?utf-8?B?OXVDUzJOdTByMmFLZzhEYTZNVXRieTRmMWhmZUNnK0hNdFFZbHpiaStNWE83?=
 =?utf-8?B?NU5EV3Z1NHFOQ2pBbm9pYTdTRG9hMDcvQ0hPcmdaSDRxOUJkVEN2bm90WjdU?=
 =?utf-8?B?NnJ0V0dpUjNJNWtlZHF1MmdXSWxhS0ttNEx4bDFlMHMyejI2WTZTNi8rejM2?=
 =?utf-8?B?S3lWdmVaZVlCMFZVRkt5b3NrU2E2VVppdFp6SE5mTXNPQ3BlNlVzajAvNmZQ?=
 =?utf-8?B?SjhjNlNIS2hjek53YkJsRE1qNGQ5QXlWazNIN0tQOUZBdDlRbk40WVM0UXRt?=
 =?utf-8?B?YW9RMkZSVlprSWtVdnZWblJBMTJFZDBXdHB1dm5uRURzV0RBYWVhOUx4dHhF?=
 =?utf-8?B?TlhXOENMZ3dxbU1OQnNsUGowR1VtVEJhREJuM2RmWW01Nlp4VFEyT3pFUjdW?=
 =?utf-8?B?aDNVdVVGWS91NUdrZ3lrRDhJU0VEbXBXSGtMM2JSUk1yRFBwWHlwVVZlRElk?=
 =?utf-8?B?THIwLzZpUU43RXU2aTAzZ3FsYmdPbjAyVDkxdDdrWXJteC9BYXRmODBtcVNr?=
 =?utf-8?B?MUlpMDZtQmZpTTJMVGR1SmZQY05Ia2U0dCs0SWV1aGluL25rRExvZnFvUUFJ?=
 =?utf-8?B?Wk5rNzJEbzdJU3hDM2hxN3pZSStzZEU1eklLakZKbER2QmJwaXd3aG5LbVY2?=
 =?utf-8?B?UndaSXlGY3JwamZacWNOZnlZVU9oMlVxQmdiTVRDQmxTUlFtcnhSYkJoRGJr?=
 =?utf-8?B?MjdwUUN1Sng2UWFidkNDY0NpVXV1T2pveExuaVFZTFFyZXRFZkhmRFZ1cUdq?=
 =?utf-8?B?RHBHQ0RCaisxYkpmc2lHWGRBS2FmejRLbWF3SzIra04waFhtVVRiaWRSTE4x?=
 =?utf-8?B?VFpreFZuVXRnL3pWU0RzN2tndGtQdkcyUzJaanJjNlVuN21CcWF3Sk1rNlVO?=
 =?utf-8?B?WFNlMkg4YXpuNURYYzJOaHJ5aXNraW1tVStDUUhKQnJnUnprMXBJUzg0YzhU?=
 =?utf-8?B?Rmo3OWRiYkdJOW1Oc0F1RnB6QzJjR0lqV1NMRUpxNDZzbVdRdzYxZXdlZ285?=
 =?utf-8?B?Z2pQY2haaW5kMFAwVG9tZVBuZUhPQ1Q2ZS9CdGdCWVd3YjlNV2NKYy9pRTM4?=
 =?utf-8?B?eGhKY3NJS09seGsyU1JlaWp5cHNWbEtidjhmQkduL0hoRlZWQkFaUXdaRFZJ?=
 =?utf-8?B?ZUtZcklzczBGLzJCU2h1ajJtR0JFcmNVN1NTeGxUeGkzTHNKNzZDcVVYMWlJ?=
 =?utf-8?B?NEt2YzNGUmFnNVNkNDY1VnZ5YXRVeTk2eHh6NEZ0cVJoTFNOdVNFSExGMW96?=
 =?utf-8?B?OGtnTkVvWFI2bE12dDF1RVExMXY5WFZWWHRPa3hOcnhBcDN3NGN0KzJtdm9o?=
 =?utf-8?Q?8TkA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404fecd0-350a-46e3-16d6-08dccd7e36ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:41:55.3438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdLTiD2XtIZ/F9F9Xr6pRlJoMq5Pu5aSdOSVLIDWmEltIdy2rr+MIzZM4W/Tjhuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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

Am 28.08.24 um 05:09 schrieb Srinivasan Shanmugam:
> This commit adds a description for the 'ts' parameter in the
> amdgpu_vm_handle_fault function's comment block.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2781: warning: Function parameter or struct member 'ts' not described in 'amdgpu_vm_handle_fault'
>
> Cc: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408251419.vgZHg3GV-lkp@intel.com/
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2: Added Reported-by (Xiaogang)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ad2e469548c9..0fa165e8fb40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2766,6 +2766,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>    * @adev: amdgpu device pointer
>    * @pasid: PASID of the VM
> + * @ts: Timestamp of the fault
>    * @vmid: VMID, only used for GFX 9.4.3.
>    * @node_id: Node_id received in IH cookie. Only applicable for
>    *           GFX 9.4.3.

