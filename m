Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40021C5321D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 18:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4E510EBD3;
	Thu, 22 Aug 2024 18:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rrhq95Tl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C9610EBD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 18:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIpV5bM3wDyXjB51HFPT1qCiP6jxeM7b4Fp1ibhR22pbNJe48TU3rqICYc3/hkITnIkFwOHkB8cdtOpWi6Mjvf0L1zR/V4hmO3K1rZ6GmpQ4v0RLwOOHNL4bYHpgPpSA7Krdgqx3uvf0S+/xT9KsLYshPhbSseLn92q+MXNZbmcm2gYO3F+wVGVspNjU8UlP4dOvId5Own/KaGa/quzTRo5WVEQOUePvb7sk3ZWGR2YKTWBlbyLC5fcW2qkL11wyk1PRsFoJaa97CuMd6ACks54pWCiECF6FzUqnRcHki8N5eqYJbSEdsTeDJjY6dXER+ehLt83mcU9wLtUUMLnDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rFiYin7FsIDt1zdvHJV9O+0DVVAXGFq2QBX0BjKD6o=;
 b=iFM45MLBH/DoRhPIQ5vEemGTZOfBvKa6B5Zpyr/XL416wO/Y4eKngQSvtNG0KQO2Q14eSKZOYB+ykIE5mLefhJC2ibRODLKAEbZGPzT/XgDN83U7Y1onLKY7Pi/KBNljwpWTokdH0on5uL24AOfL0+cyzqMlTZX1q6IPG0rNUZWFfSxYMJJ/6R2iZVV382IElfq32Aerpq4OcD3hlzSjLeyNupSrmBGuVWLB4lp7x3FO9zUb1ewfwOCMPtHFT6BLUp4rcjJwU1bESuZm4luBfXH3v6uOOqq3Qye1Z6qo9svZC67KJ3WS6weFvtJ+BW5dcNfHlJVR9NaHLM6HH5joZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rFiYin7FsIDt1zdvHJV9O+0DVVAXGFq2QBX0BjKD6o=;
 b=Rrhq95Tl3DsXtF74We3sbJ6anKxXUUaavibHiPK0Cgfn1g0A+aAA6qkIhFaFkyHAkYOYI6zJBIl6zPP5orNGLRltZ7p68J+CQTigYYY54oiwwq2zRncV+JYy+meOhOS3DEXYpUwLYyam0Me9G7fTb1eg+e7aACsU/sk/xRmRa/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 18:55:04 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 18:55:04 +0000
Message-ID: <71e89982-86c0-4881-ac38-243e620885f3@amd.com>
Date: Thu, 22 Aug 2024 14:55:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amd/display: use drm_crtc_vblank_on_config()
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240822161856.174600-1-hamza.mahfooz@amd.com>
 <20240822161856.174600-2-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240822161856.174600-2-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::48) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e15fdd1-baaa-49c1-21f7-08dcc2dbeeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnZhYWFDMDdWcjlobzd2cmQ4bm14NW1LYkxZQlRTSWprK0FmV3BpUmdEYTIx?=
 =?utf-8?B?N044cUhYWU9NdW1RNHBXc2MzYS8rdWFxVzRYeDlKazZxN1pGSms3eG8zTzMv?=
 =?utf-8?B?TGF4Z2FPVTNCZGwrVkJ6UmFJelI4NzBPS1E5YWZrWWVIbElITUdxb2xwY3Nj?=
 =?utf-8?B?TXllSnp2RDY1dUh5MzBDT3JjdDVYZFYwL2pvbUVESVMrTVhFS2tVeEFaN1FB?=
 =?utf-8?B?OWdCSldFYTYxMHBITGoyTGNrTGw1VWtFdytzcytWUGIwUE1BYmxmZUllNzI0?=
 =?utf-8?B?SW1aQ2ZZT2VFQjUyR2NuejlLRDNQM3lzNGNpMWdpeFN1RTRuYm1NNVo1S0NC?=
 =?utf-8?B?bktNelYxbzFNOFpPWjFwdzU2WUFuREw4cWI1NzRRQ09vdjIrWTNaeDRiOUxW?=
 =?utf-8?B?UFdMLy9DSWVSMkJYNUFjRjgwSEZwWTYreFR5R0JSK203SFRvNTZHZzFhNnJX?=
 =?utf-8?B?bFJCdU8xV0Zoa2x2UlhJNU5TS0hZdHM5VFNndGE3SEM0NDVNdVVtWUJHVGJw?=
 =?utf-8?B?T1NsSEVTTzlXTUQyMnJselk3N2xuWVFqRGxTN1ZPcGNUeFAyVEhzU2VUYm80?=
 =?utf-8?B?dHMyOFVoUnNpMXI5K0pQbXNYamRpTzg2Y28zMnIxL3g4cTRmQSsyanQ1R1FE?=
 =?utf-8?B?Wm1Ba3c4enVxNzJoT0lnejRnMnNXWU1UY3VneFJzbHpkRnZSYzNsam95WVZZ?=
 =?utf-8?B?VjFIb3JVK0VhNDRLUG9GZERuZUN5NzhpbWgxS2ZlVXZSVFphMDFITjJiUkQ4?=
 =?utf-8?B?SHV5YnRIcHZva3NXY3NzZVRtOHh5cXU3TDcvZ3ZLK2tRcW80OHVMSGJvTnFJ?=
 =?utf-8?B?Z1ZGMUlYQXljNmsyc1Vra0lrdzI1VFd4bUtkV1lzWmg5Snd1WVBINHllK2FP?=
 =?utf-8?B?enMrVmdwZXdITVRiQ0Zpb0ZuTHltMUR5V1Q0UlJRNXFtS1d2SVN4SVhOQkJh?=
 =?utf-8?B?RjRYR1dadTZiKzZXMTljVXc1N20rMit3SlY5NXk5bDZtWlhpeFFDSEZtOUZY?=
 =?utf-8?B?eFpsbnFvTnBidG5GeDl6dkFEZ2J1TGIvUlBrdjljZ2J5LzBMNndzZGlsZ1c1?=
 =?utf-8?B?cmk4cndDYnB1SXJkMTdoa05jM09Ndk5MY1VoWDVMbGY2a3JLRklvQ25UajRk?=
 =?utf-8?B?aEIyUlJPd0d5c2hWNUoxTi9oYnNrMW9WMmYrV0gzL3kvTUlCY2VmckJyUTFF?=
 =?utf-8?B?M3RwRkthRStMMUg1OVN5R21aVzRsTUtCUVRzVTFFWUhoQy9Wd3ptZW12Uzky?=
 =?utf-8?B?eFBpNExIdWJVVEtvZmhWemtjZnluK0kxbThjeUhwckxic2pMTU5MeVhMTkNY?=
 =?utf-8?B?ejc4NE8ybWdBVXlSRWlmVVJGaGVobHJvczhsS0IxTVJLdkN1N04wUFhuUDlE?=
 =?utf-8?B?amhDMWgzU1dqOGh5TnVUaCtuMzQvc3pYTHIwQ0tiNVpGNXBFNXBTRlNLdGFj?=
 =?utf-8?B?dWwzaTBrN0srTVBrMXFuYVluMXNqYnV0d1BBNUY2NEEySFpjNnpNdENGS0ZU?=
 =?utf-8?B?MEdzdlNXcmV2WWZnbm95YmUxNkl1OFlQaEFhU1RHSHlMemxWYjZ3YkJOMktl?=
 =?utf-8?B?c05ya2hvM3RTZjdNcm9BUWtGRjVLYUord21hWkI0dW1FclY4Nkt0aU5ZWWIx?=
 =?utf-8?B?NlYycXZMZTZwajhLdlFzd2ZBcGVxandsOWEwaElSSElQaGhiVUFqbFlNUkJj?=
 =?utf-8?B?SG5WS1ZsU3BwWXlvVnJaNFpuRDc2R0RmUEhyL3BLZ3BGZEJqdXByc1crZmhI?=
 =?utf-8?B?bnpLTHRSWTY5UjN4MU1jM2tjRVNuKytneFY3SlkwMTlnS3FpK1M4QlMxOCs5?=
 =?utf-8?B?Mno3b0tub1E0MXNHY0h6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFQSTNpUjgrY2cxL0toTGZhSFQ4blBnc0cyU3NKM05keXZsWTdKU01wdUZo?=
 =?utf-8?B?L2lZRFB4eGtCRjI0WDJaUHE2MVFRdGdMOVQ0dGExbVNyRzNNVmR5ZHh4L1Qx?=
 =?utf-8?B?OHpQUWRRK1FxQ3ppdjMzdk1mN0l2bUFlZ1dlTnozUC9PQUF5ZjhWaTU1T0dH?=
 =?utf-8?B?dUtoMkdhUXhpbEpGVjY0YWVTQjdyQW1ESlVCc2FlanZ6dDFiS0lyeFc5cCs5?=
 =?utf-8?B?Rk1oY1hQd1Faa1BVMDMwNmlMNUNuY1RGVzBsSlVsMDcvbkhiaTB5Qnd1d2l0?=
 =?utf-8?B?aVdQck1NalNUYXMwSnJnV05JSlcxYlBzL3EvY2VsbUVpWDdDdHgydDJQcnVB?=
 =?utf-8?B?UFZ6Q2xVTklSTVYvUDU5MWI0bCtMR0liQ1BSTmNsWXIvNlNHdm5ubUE1ODVH?=
 =?utf-8?B?aHhGMDMxK0lyT20ydW9obCtQNjdFdVVaeVMxL1NNTVZHdmV1Z0hXR05LcklP?=
 =?utf-8?B?US83SUZGa2g0MmlzajBud0NjVVFpTFUyUWptdEMzMlA1QVZWdTJHcjRaeElp?=
 =?utf-8?B?N1RHTVlKN2g0VTZIRGw2ckM1ZkVWNFJEWTV3OGY5ekR6TUJoelc3eE14WE9W?=
 =?utf-8?B?aGpFQytJWE13aVlkcnZMUUVFTFlYNm9TVThsaXR3NHRrQll5VWp4cHd1Um5F?=
 =?utf-8?B?ODJycmxKTnRGbTJxMG9mRU53Z3dvdW1EVnJ0MXErb0t1b3ZkTXd0cjQ5YnEx?=
 =?utf-8?B?Nm1sV0UvcWdneXJYTkd2dFl3SDVheGdQb0Y1djFDODhBcUhpZ1Z6SVBNbk9n?=
 =?utf-8?B?YmdpeFZaYTZwajREaUxqeGpjZ3ZrdExMOGE0UDFrUm1UbXVkZERLaTBDeGU2?=
 =?utf-8?B?VVJUQWcwWTUxUTJ4cHpSbG1OYXJMSWwyZXRWWENnbnJwU1ZmT3J6VEhUaEMv?=
 =?utf-8?B?Mm13SWRESVo0S1RWMkNVdVlQc1pNdXZBV1oxUkhRZGhVQ21xZVQ4aDlSL0g2?=
 =?utf-8?B?YlVLWC9sNFcwVFI1WG55blhBRUdzQW5Qb1NGRHZsL1V4VWxvZUQ5KzRoOHFE?=
 =?utf-8?B?L2hMcU9MT2VnU2VSRk1QNGNycHo3Q2hUNjdrd2dmQ1A4R1dzS3Y0ZGxYZzA4?=
 =?utf-8?B?cXA4SW5GMnFFZTR3aXpNVFhFeEk2aXBOSjRkbnM5YnF4QWdYWVRMdDgwTEVV?=
 =?utf-8?B?ZlZyVzhkTjlPQmNOckdPRVJRSmQzWVM3dzBTNVJlSG5pdExBdjZKN0N4NFFC?=
 =?utf-8?B?TS9DNzZ5ZzFkdVJFRmhhRTlNZFYydjl4REZvWTZLV3pBRXE2UnU1U1N4cnpj?=
 =?utf-8?B?QmJSbmhlY1ZrY0xqNXZydGI1YWc3YmxQUnpxakEvN2F4QU1oZUx3c0lnbEZL?=
 =?utf-8?B?b3JLTHp6cjZTdmNGTXkzbFk0Ky9iMm4zbUlyeUNiQVdQUUhPRGNReU1nRWZX?=
 =?utf-8?B?YXl4RkpCWHN4K1Y3Tk8wdDQrYkZVeEZuZE5uRmhDRUpRWDFnSEppUHdqVjYv?=
 =?utf-8?B?SFRFeXphTG4zUm5BdTFDQWNaeGE2V3NHTStFNnQ5Vyt0VTZ3SkFmQnc3WTE0?=
 =?utf-8?B?ck1TV0Q3cGVnN0pYSWdrcUtPU1ZpeGY3ODBkamxQdXU4SHMydGxvT1VQdUJF?=
 =?utf-8?B?UnhEekljdldOby82M1B1VnRVS0JYWDBLMmpqVVhtdWdyMUpndTlKS3llWFM2?=
 =?utf-8?B?aFE2bWNrTHZEQWtobVF0dUd5Tk13L0pwbEVudzlEZ1hIVFRreWFEeTQwUmZP?=
 =?utf-8?B?UC8ySmJaSFRXUWNFblRkeEgxZDA3NUdDcEQyKzV2N0pOelkxc1gwTGdGM21u?=
 =?utf-8?B?eGt6Mmg0M2lsQjJudFVjbUk2c215aGt6bTAvc1lJOEZJRElaUFVQNkYxRVh1?=
 =?utf-8?B?ak1jdEtYckhVTUdaUGdtVFY1OFRBWHFScis5bVNpSmtDeWUwSS9KUUZ3NzRm?=
 =?utf-8?B?aFdnMUUvSENXRlhQYWF1T3ExZ2tyWlBmYWR3RWN2UVdwZ2ZTTkVvbFZnN052?=
 =?utf-8?B?MDF1UU1ISXgzd1U1UWwwNmdybXFnYlF0ZE9WTGVHbTJlN25PQlhiQkxOWmRP?=
 =?utf-8?B?R1o1eEVJOXBpSVZKMmFkQk02cE5qbjJadXBtNVE3Vld4Um5UbFgwMjVOb1Fp?=
 =?utf-8?B?Q1ZHeGxxbDNZUFNxYlYyZ1lrZkIzbmZ4OWZ4YUhXakVJL0hoOXNSR3RrWExV?=
 =?utf-8?Q?isI/EEodI4YlVDHVgIFTMejsj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e15fdd1-baaa-49c1-21f7-08dcc2dbeeb1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 18:55:04.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEEeTKkSjWINMjDvsjar6gRSzciRpV0BedZdGvy9JLMNCuyDuYPMHKuxh1XGxmDJqg+mdHZDVJmnjsZrEDjekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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



On 2024-08-22 11:58, Hamza Mahfooz wrote:
> Hook up drm_crtc_vblank_on_config() in amdgpu_dm. So, that we can enable
> PSR and other static screen optimizations more quickly, while avoiding
> stuttering issues that are accompanied by the following dmesg error:
> 
> [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3
> 
> This also allows us to mimic how vblanking is handled by the windows
> amdgpu driver.
> 

Please call out the policy change in the commit description and title. While
this is using drm_crtc_vblank_on_config() the important part is that this
stops vblank_disable_immediate = false bit (and associated 5s delay) and
replaces it with a 2 vblank delay, if I read it right.

Harry

> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v3: use a less conservative policy
> 
> v4: drop TODO, use simplified calculation from Michel, use
>     DIV64_U64_ROUND_UP() and use a different policy.
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7e7929f24ae4..00d4c97e8d26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4934,12 +4934,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  
>  				if (psr_feature_enabled)
>  					amdgpu_dm_set_psr_caps(link);
> -
> -				/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
> -				 * PSR is also supported.
> -				 */
> -				if (link->psr_settings.psr_feature_enabled)
> -					adev_to_drm(adev)->vblank_disable_immediate = false;
>  			}
>  		}
>  		amdgpu_set_panel_orientation(&aconnector->base);
> @@ -8232,7 +8226,7 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
>  
>  static void manage_dm_interrupts(struct amdgpu_device *adev,
>  				 struct amdgpu_crtc *acrtc,
> -				 bool enable)
> +				 struct dm_crtc_state *acrtc_state)
>  {
>  	/*
>  	 * We have no guarantee that the frontend index maps to the same
> @@ -8244,9 +8238,28 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>  		amdgpu_display_crtc_idx_to_irq_type(
>  			adev,
>  			acrtc->crtc_id);
> +	struct drm_vblank_crtc_config config = {0};
> +	struct dc_crtc_timing *timing;
> +	int offdelay;
> +
> +	if (acrtc_state) {
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +		    IP_VERSION(3, 5, 0)) {
> +			drm_crtc_vblank_on(&acrtc->base);
> +		} else {
> +			timing = &acrtc_state->stream->timing;
> +
> +			/* at least 2 frames */
> +			offdelay = DIV64_U64_ROUND_UP((u64)20 *
> +						      timing->v_total *
> +						      timing->h_total,
> +						      timing->pix_clk_100hz);
> +
> +			config.offdelay_ms = offdelay ?: 30;
> +			drm_crtc_vblank_on_config(&acrtc->base,
> +						  &config);
> +		}
>  
> -	if (enable) {
> -		drm_crtc_vblank_on(&acrtc->base);
>  		amdgpu_irq_get(
>  			adev,
>  			&adev->pageflip_irq,
> @@ -9320,7 +9333,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>  		if (old_crtc_state->active &&
>  		    (!new_crtc_state->active ||
>  		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
> -			manage_dm_interrupts(adev, acrtc, false);
> +			manage_dm_interrupts(adev, acrtc, NULL);
>  			dc_stream_release(dm_old_crtc_state->stream);
>  		}
>  	}
> @@ -9835,7 +9848,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
>  			dc_stream_retain(dm_new_crtc_state->stream);
>  			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
> -			manage_dm_interrupts(adev, acrtc, true);
> +			manage_dm_interrupts(adev, acrtc,
> +					     to_dm_crtc_state(new_crtc_state));
>  		}
>  		/* Handle vrr on->off / off->on transitions */
>  		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);

