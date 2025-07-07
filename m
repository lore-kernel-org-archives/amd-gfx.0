Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD3C83F03
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 01:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EB510E0E7;
	Mon,  7 Jul 2025 01:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zx98ECu5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CD110E0E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 01:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3N0i9VpbXMts9b48O5qFeHBK9XzdF6kwraWH7BZDX+mCwXvm5UudLg48eV3Ft0ynl1L90SAFJVPQSHra3WBGKXJnQUzpcfRq54/3NRl3snvgEIKoyn77cq477Y4sfehgGvQ4MmQY5EdzTYNMvTLSp0SMJBQxSfxVohMHO/9SUIHwRk/DbY90qjE1HslGdppWlmo93N+ADet9dT1kvJewuLtrEq9jkSfgeaY/f0pAZdBxnBsfyYhJBIzY8KMnTmfc8vJKDXDAlfqJsm0k3LS8ilbH7xsZiH8P0VYkketUeXCGfmXs99cG4MJ0mlHn8BKEYtTyOnG+YX1ZhhNykyJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fjD/3v5oKew1Rpd+KfyeAS2NKP64Y8Z4cgKWYmpWeA=;
 b=XdQfu+mgerAGxJHCo1OjdOQyE868AMLFgCuI5PTIdg1hJLZDp6MI+2Ya16G7BQp3puNFCnVGPGNb94p8wtWrkaABkbVx+nUDSYCgdssok2UhIYFymgrpVLIOFwywHFPXWl381QhSC/Ta0/8a/nKFPCQa3rDoqisIfmpILs2y3BIIDK46uDMuxjmVjl3oVqoePYaEsuuTS747jflpWhBYSj83kI4FnfhTFXluClWaO1KuQmbjzcKOxoNN+TTvdRe43rA+F/7A9u2GTZtEm6VLLt9ihqhPC430rEsa5ApbWquIQmIXVgwaBOi34Ab9oD1YHTuN2L5RSCo9NF6rU0nM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fjD/3v5oKew1Rpd+KfyeAS2NKP64Y8Z4cgKWYmpWeA=;
 b=Zx98ECu5aa6u+5Hn7kXBy69ghMs7Dbe9rbpo+ieCFnHRFFhLiTkfv25fRHmAJ6IiXNyOwB9VYn12+YccW1eBuqx5S7RCpxZKf1PqvwBkeQyg6Z9LhWnX+iESKNjXfyrpb7Xn4YFrjrcPUxscby1He2t4oz9ScXn3dWxeTIs3yG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 7 Jul
 2025 01:56:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 01:56:28 +0000
Message-ID: <f5bdade9-97f4-4f02-9ae3-9f68b2f186fe@amd.com>
Date: Sun, 6 Jul 2025 21:56:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd/amdgpu: Add helper functions for isp buffers
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com
References: <20250630213607.1849629-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250630213607.1849629-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: f9115034-7998-4391-67c7-08ddbcf97cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVGYm1nak9SS25OdlpxeDUvcFdUZW5kNEZ6Y3MzRWVwZlg5cmpmSmtCR2sz?=
 =?utf-8?B?Q21kZ3hhNmlrY0hkY1NaVWVMaGMySXRPTW5PVVpCYWZJeGJ6bm0rZ1hnaXlJ?=
 =?utf-8?B?Mng0bHpGWVRvMUs3QkZWYVlxdytCV0o3RUdrdHB4My9uTXg5S294R0FlUEF2?=
 =?utf-8?B?M2JUamhlMThDRnIwQzM4dHdsYXU4cnh2RnkreFJJWEZPU3l1d25NbTFTVHB1?=
 =?utf-8?B?MFNLNTdLYW5vZGd0WFBabG5qbjBjNWJXTzBZU1RFdUtTalllQlNDZklnQ2R5?=
 =?utf-8?B?WmVWSlNOMms3SWd1RklDMTNCRVdvRG9MNStzT3c2MWlPSlVNMjhDc3QwRTFr?=
 =?utf-8?B?bG1tVml1MEVyK3lCWE9qYllMOHFCVGtiaUdmWmRUS3BhQUo2d1FDU3JtWWJ5?=
 =?utf-8?B?RkZjdXhWd0lZUWFXK3llSnk4Y1dRcEFIVGRWYmo0Vysza3cvMFlpQXJ5emJD?=
 =?utf-8?B?bWlCdmtiNExvbENYTEovWlVIV2duRUozMFgyZlpJSmQyNzJ1VW80Z3p3TkJQ?=
 =?utf-8?B?QjBqMmFvZGtpbUhmSDNyZnp5NE5XYUJIMFVYVXpCYldEbHF6MktxVVpreFdz?=
 =?utf-8?B?S1B2NEVZS1dpalJvZUpQai9UaGhLbzBZa000UnB4YlY2NTB5MkU4dlhwdlRD?=
 =?utf-8?B?T0VQQlFhRDBFTHhFaVBoTHRFUkFlQkdPQTFQQmVmMlYxVWRhOUg1UWFyQXdo?=
 =?utf-8?B?MmVQcUFuRWQ2Tnk5UDVYWjQwVFhQTEs1dXNkVDZuMVFmRjBIV2puUDJ0QkRn?=
 =?utf-8?B?amREaFBWUlA5dDNCNVV0TDZZcWY0SkIrZWdEdUpYMEJsMEVhU1Vlays2TmxY?=
 =?utf-8?B?cUF2TmdPRlZTeDJ2cE5CUVpVWldWWDhSaEtIRXVkVFphb1V0SXQ0OVVUM2V2?=
 =?utf-8?B?UWttdWNyaUZPaXhyYzhkc01Jd0pHdFh4MGlQbEVtS0pWQ2d3OWpsODFrT3Mz?=
 =?utf-8?B?WmNMa01aUXRCZWdkb1E4NTI0TndSK2dmK0JBaW9QSnBYOTU2UmdrMnZvT3FV?=
 =?utf-8?B?ZUJwdDBnRW5SbFlpZklJcG5ML21vSUNUSSsra3I1T0tOZENwK0paRGY5WGtX?=
 =?utf-8?B?SHkwbURhYUxhNUNuUDczRzBXeXZFRVo5NE8zZUVZU3dVMVFRek9xRG1nNFp2?=
 =?utf-8?B?aTlqNXV4SGlCWjdlUDkwOUx6UHdTRFR4VEdPR2x0K1FpOHFVVUhlbE4vWVNW?=
 =?utf-8?B?SjhVdkd6a3NsSGRJR29scU0rd1oyQmkvOFZFaW5RVkplTDJOV0l3VjRtTFFm?=
 =?utf-8?B?djRObG11MkVlRUZieEdyS1ZwSndyQzlxWEtQaE9vdDV6NlNlcmVKaHEzajgv?=
 =?utf-8?B?Q0lzaXBjek5OSXVWNzZjNk4ySzF1U3BBUGpEcHdxcW90VDFSME9ha2hXU0pV?=
 =?utf-8?B?SHIxQmM5WS9mS2pmOUR6WUU3c1V1VWVZekF4T1pMcG1peUdVMXlEOVUyRXNM?=
 =?utf-8?B?RlB4WnNlVjQxV1FZSytYb3hJNGp2WEUzMm5BMVJ3OWpEWG5nSzQySHdXRFhU?=
 =?utf-8?B?ODhWTHVrMXdERkdPaEVKT2RBd3d3QUV1TWsyY2pLUUFnbHJYNEZCVGYrTC81?=
 =?utf-8?B?bTJoMktYektoSDd6WjFwRWhtWDZuZHRXYjl0OUZIaU5SZENqUEtBSGpKODJa?=
 =?utf-8?B?eFNZek44bEtoVGJOQVhWSFRRQ0lMYmp1d2N1QmIrMytUMUxieGF2UkRqdEVh?=
 =?utf-8?B?dHlTRXhqU0lETkFlZDBzbTFpd1BtVUdFT0N3cTlqbGVsOUZKcmZsZ0QyV2lS?=
 =?utf-8?B?dW84RWU2Yks5eFI2aVZBNDQzaS94alNkY0k5c2ZqUndvN2ErL1dXalYyTWpK?=
 =?utf-8?B?d2Y5djAzdHJ6b2c1TFNCdHdqa2x4OEtjS3JGUjNFYjY4SE81Um15Uzd3Zis4?=
 =?utf-8?B?SUZ0c3pjSlZsNUlrNGZwaGhNQnlteDVsdkJLYjQrMHp1bThqaXB0Q21reEs2?=
 =?utf-8?Q?xeKIVb37JMk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTQvTms2NFIzWTk1NzhJalByZzZNeTJNOUVRUGFabGlaTktUT3ViMEFuaW1Z?=
 =?utf-8?B?Y3BTVEozZlpUVUdCUmljbGRMT2FCd3F4U0NXbFpvY1RKMkU2V013YXNNeERK?=
 =?utf-8?B?aytyNG4yckxRT0tzcFFQUkJQdlhPVmg1SEZNWlo4Q3gweENXMzJad3dCRmtF?=
 =?utf-8?B?ZHVkbExEWlIwZXlBNC9adzFmUExjcGpCYytCaGpUcm9XNXhSTVI2TnI4RXlz?=
 =?utf-8?B?VGdqck80djhBSEZib1pteXV0NVpiYXp3bjAva2hLRDlOTDdJTmlxd0J2RFFw?=
 =?utf-8?B?eTNFT1FRVjNVSU8vand1NTdvVFhUb0JGNVlVRjJvUUlLL09UVzhhTUdacEo1?=
 =?utf-8?B?K3dLczU1dVdxU2pvVUJpTmVON1RlSTBLek1hYVNJTHg1ZlNFVDB4eGVjRGhq?=
 =?utf-8?B?MjIxR1VjeUNmT1lVdHYvQlRuR3ZCRlJLVGlzYUVPU200cDllZk0vc05TY2Rn?=
 =?utf-8?B?WkdjQTlTMU5ROXZ0c3l2ZzNzYkhVb1I4b1lDSXc4QlZjSWJJUnBVZ2ljMTVy?=
 =?utf-8?B?ZytHa0hNT29VT3NzRCtWdktxdGdKdVZJZlowa3FqR1lFK09UTUV0RElCdmRm?=
 =?utf-8?B?VlZDR1p6R0NWT2pMZHJ6OVB0dnhVOHhKT3c4Y3RKUDg3Z3BmTzVsTWpielhV?=
 =?utf-8?B?Qmt2TC85QUZ0SW1SbEVtT1o4ajVKTnFUdyt3b1NMeE9pZHUyUXAwWDVDeVJz?=
 =?utf-8?B?TkM5Q3FjWjJlcFVjUlpFeFNFUTdxUS9Ua3FnYnNlSlB3ZFgxNlJtVUNtNXV0?=
 =?utf-8?B?WWxlT2g1UDUybkVLanp6bHgyc0xaMGJ2bWEvNGFnTjNSYlFsdkYrWkNhcmhp?=
 =?utf-8?B?WlNDY2lrbjIyOW5pczFrZCtjKy9JMG9DbHFSK0Zqbmo3MVVCTUFSN0N3SVNN?=
 =?utf-8?B?TkY4K2JiUmR4cGladjAwU3VORnVOQ1RWSHpGSzdFeHI1ekE4Q2wxZDBVUERI?=
 =?utf-8?B?Wmo2YlVraWtCNldvUksycnFoKzlYUmdWSnZTWkhDVWxLSDRXdnlyTVFmdm5q?=
 =?utf-8?B?bHpleVR4L1FHTXRkWWZpb1hta3lvVnpuNGZtY2g3R3dJSG00RHhRL2tUdyt3?=
 =?utf-8?B?K05UYnhjLzZaYkw5UlBlV1gxV2owS2xKWUVhWWVhWHZFL3VXRnBhTzg5b3ZT?=
 =?utf-8?B?Q2srY1ZrVEdDbFM3ZEhwS2Ird3JPTE9BRzhObktZaG9KSWZaczBJOHJjVGJ3?=
 =?utf-8?B?NGJVbWZ0dDlOWDVIZkF0UVJyaVN3TDBJUGpFTUtBdlgrTXVkSnlPZlJGbTF5?=
 =?utf-8?B?a2ZBL3FGTDRyQTlWM0o2Q3FIQzFvVTE4OHlhUzNSQmp5bHY3dFFkNDdlY05t?=
 =?utf-8?B?cFBhSDZsNDVKVldmcmVSSG1RUmdZWlZrTzJYWWpFZDBJbnpnZGFpMzFDZFFS?=
 =?utf-8?B?WTdrazVJeVVHbGN3c284Y29ad1BQVVZ5bERtR1Q1VTJnYi9TOWVEQzNJR2la?=
 =?utf-8?B?aHd3OGwzaWR0RFRyZjdxZnFxUXlZK0U0R1NReDNBUUVEVjNYMTd2d2pXeloz?=
 =?utf-8?B?Vlh0NnBWZEtuWUt6dDQ0SWhXZUVGeUh2dU1DeHUweGlzMWFWTDl2YndJcWRU?=
 =?utf-8?B?WUZWNUptYVRKcjJkQmFMcVF2L2NwYTFqV1BLMjJCVHlKWktWOUJRNDBtc3A5?=
 =?utf-8?B?VDZveWcxWDU5NGo3Rm5ZeENxMVhHT1BhaDJKUmN1d0JZM253Y29EZGwxby9I?=
 =?utf-8?B?UmFBd01VT2p4bEcrRHA2VHpmQzQzUVlwbVFoSCtFdVVxc0ZsTXdWdXB3MUN2?=
 =?utf-8?B?L1lDMWg2cG5kenJVOEhFUmRGYUwxMWJGQVk2WHIzaWtNdFNaeVZQQzJtd2ow?=
 =?utf-8?B?VGVyQ29BeDNpaHdsYUN6T2ozSktKbUR0V3cwNkwyQ3ZubVRiMTV1bkRxMmV3?=
 =?utf-8?B?WEZaek5Kc0hxRFZoWlEvY1BlcnpJRHNQVys0V1RpbGRCZkQ0VXBrV0dUWEdm?=
 =?utf-8?B?d3hyNXlSYmc3YU5ONW5QdkVBUnJvY0lBaVdXbVlGUzd0U0Y5S09VbWhQWWY4?=
 =?utf-8?B?cFlFc1ZnbE1kY3NtTVl6bTFDalBFMnEya2IrZUV5YkF5TnM1SUtiZkZ5bWh2?=
 =?utf-8?B?MHhuVERlbk1MdjNrM2RvWFFReGV3OW1OamVkM09tOEswQ1ptaVBFYTZ1L2F4?=
 =?utf-8?Q?8XR7PmuVimW5U6UCTZDlZPwxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9115034-7998-4391-67c7-08ddbcf97cac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 01:56:28.3117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrVmYrvGdM61Us5yeu7Mg23Ys8qLAkAGhtnA3C1YBeuQBVgadyoKN2dZP64uf37f22/B154jQLO2WCqRWWplPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

On 6/30/2025 5:33 PM, Pratap Nirujogi wrote:
> Accessing amdgpu internal data structures "struct amdgpu_device"
> and "struct amdgpu_bo" in ISP V4L2 driver to alloc/free GART
> buffers is not recommended.
> 
> Add new amdgpu_isp helper functions thats takes opaque params

s/thats/that/

> from ISP V4L2 driver and calls the amdgpu internal functions
> amdgpu_bo_create_isp_user() and amdgpu_bo_create_kernel() to
> alloc/free GART buffers.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

No need to respin for the typo above if this is the only feedback.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> Changes v3 -> v4:
> 
> * Remove unrelated change in isp_load_fw_by_psp()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c    | 175 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h    |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 -
>   include/drm/amd/isp.h                      |  51 ++++++
>   4 files changed, 227 insertions(+), 10 deletions(-)
>   create mode 100644 include/drm/amd/isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index 43fc941dfa57..f9cabeae1c71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -33,6 +33,8 @@
>   #include "isp_v4_1_0.h"
>   #include "isp_v4_1_1.h"
>   
> +#define ISP_MC_ADDR_ALIGN (1024 * 32)
> +
>   /**
>    * isp_hw_init - start and test isp block
>    *
> @@ -141,6 +143,179 @@ static int isp_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +static int is_valid_isp_device(struct device *isp_parent, struct device *amdgpu_dev)
> +{
> +	if (isp_parent != amdgpu_dev)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/**
> + * isp_user_buffer_alloc - create user buffer object (BO) for isp
> + *
> + * @dev: isp device handle
> + * @dma_buf: DMABUF handle for isp buffer allocated in system memory
> + * @buf_obj: GPU buffer object handle to initialize
> + * @buf_addr: GPU addr of the pinned BO to initialize
> + *
> + * Imports isp DMABUF to allocate and pin a user BO for isp internal use. It does
> + * GART alloc to generate GPU addr for BO to make it accessible through the
> + * GART aperture for ISP HW.
> + *
> + * This function is exported to allow the V4L2 isp device external to drm device
> + * to create and access the isp user BO.
> + *
> + * Returns:
> + * 0 on success, negative error code otherwise.
> + */
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr)
> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	struct mfd_cell *mfd_cell;
> +	struct amdgpu_bo *bo;
> +	u64 gpu_addr;
> +	int ret;
> +
> +	if (WARN_ON(!ispdev))
> +		return -ENODEV;
> +
> +	if (WARN_ON(!buf_obj))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!buf_addr))
> +		return -EINVAL;
> +
> +	mfd_cell = &ispdev->mfd_cell[0];
> +	if (!mfd_cell)
> +		return -ENODEV;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = amdgpu_bo_create_isp_user(adev, dmabuf,
> +					AMDGPU_GEM_DOMAIN_GTT, &bo, &gpu_addr);
> +	if (ret) {
> +		drm_err(&adev->ddev, "failed to alloc gart user buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	*buf_obj = (void *)bo;
> +	*buf_addr = gpu_addr;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_user_buffer_alloc);
> +
> +/**
> + * isp_user_buffer_free - free isp user buffer object (BO)
> + *
> + * @buf_obj: amdgpu isp user BO to free
> + *
> + * unpin and unref BO for isp internal use.
> + *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to free the isp user BO.
> + */
> +void isp_user_buffer_free(void *buf_obj)
> +{
> +	amdgpu_bo_free_isp_user(buf_obj);
> +}
> +EXPORT_SYMBOL(isp_user_buffer_free);
> +
> +/**
> + * isp_kernel_buffer_alloc - create kernel buffer object (BO) for isp
> + *
> + * @dev: isp device handle
> + * @size: size for the new BO
> + * @buf_obj: GPU BO handle to initialize
> + * @gpu_addr: GPU addr of the pinned BO
> + * @cpu_addr: CPU address mapping of BO
> + *
> + * Allocates and pins a kernel BO for internal isp firmware use.
> + *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to create and access the kernel BO.
> + *
> + * Returns:
> + * 0 on success, negative error code otherwise.
> + */
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr)
> +{
> +	struct platform_device *ispdev = to_platform_device(dev);
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +	const struct isp_platform_data *isp_pdata;
> +	struct amdgpu_device *adev;
> +	struct mfd_cell *mfd_cell;
> +	int ret;
> +
> +	if (WARN_ON(!ispdev))
> +		return -ENODEV;
> +
> +	if (WARN_ON(!buf_obj))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!gpu_addr))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!cpu_addr))
> +		return -EINVAL;
> +
> +	mfd_cell = &ispdev->mfd_cell[0];
> +	if (!mfd_cell)
> +		return -ENODEV;
> +
> +	isp_pdata = mfd_cell->platform_data;
> +	adev = isp_pdata->adev;
> +
> +	ret = is_valid_isp_device(ispdev->dev.parent, adev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = amdgpu_bo_create_kernel(adev,
> +				      size,
> +				      ISP_MC_ADDR_ALIGN,
> +				      AMDGPU_GEM_DOMAIN_GTT,
> +				      bo,
> +				      gpu_addr,
> +				      cpu_addr);
> +	if (!cpu_addr || ret) {
> +		drm_err(&adev->ddev, "failed to alloc gart kernel buffer (%d)", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_alloc);
> +
> +/**
> + * isp_kernel_buffer_free - free isp kernel buffer object (BO)
> + *
> + * @buf_obj: amdgpu isp user BO to free
> + * @gpu_addr: GPU addr of isp kernel BO
> + * @cpu_addr: CPU addr of isp kernel BO
> + *
> + * unmaps and unpin a isp kernel BO.
> + *
> + * This function is exported to allow the V4L2 isp device
> + * external to drm device to free the kernel BO.
> + */
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr)
> +{
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **)buf_obj;
> +
> +	amdgpu_bo_free_kernel(bo, gpu_addr, cpu_addr);
> +}
> +EXPORT_SYMBOL(isp_kernel_buffer_free);
> +
>   static const struct amd_ip_funcs isp_ip_funcs = {
>   	.name = "isp_ip",
>   	.early_init = isp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> index 1d1c4b1ec7e7..d6f4ffa4c97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -28,18 +28,13 @@
>   #ifndef __AMDGPU_ISP_H__
>   #define __AMDGPU_ISP_H__
>   
> +#include <drm/amd/isp.h>
>   #include <linux/pm_domain.h>
>   
>   #define ISP_REGS_OFFSET_END 0x629A4
>   
>   struct amdgpu_isp;
>   
> -struct isp_platform_data {
> -	void *adev;
> -	u32 asic_type;
> -	resource_size_t base_rmmio_size;
> -};
> -
>   struct isp_funcs {
>   	int (*hw_init)(struct amdgpu_isp *isp);
>   	int (*hw_fini)(struct amdgpu_isp *isp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index c5fda18967c8..122a88294883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -352,7 +352,6 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>   
>   /**
>    * amdgpu_bo_create_isp_user - create user BO for isp
> @@ -421,7 +420,6 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
>   
>   	return r;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_create_isp_user);
>   
>   /**
>    * amdgpu_bo_create_kernel_at - create BO for kernel use at specific location
> @@ -525,7 +523,6 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>   	if (cpu_addr)
>   		*cpu_addr = NULL;
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_kernel);
>   
>   /**
>    * amdgpu_bo_free_isp_user - free BO for isp use
> @@ -548,7 +545,6 @@ void amdgpu_bo_free_isp_user(struct amdgpu_bo *bo)
>   	}
>   	amdgpu_bo_unref(&bo);
>   }
> -EXPORT_SYMBOL(amdgpu_bo_free_isp_user);
>   
>   /* Validate bo size is bit bigger than the request domain */
>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
> diff --git a/include/drm/amd/isp.h b/include/drm/amd/isp.h
> new file mode 100644
> index 000000000000..ec868288abf2
> --- /dev/null
> +++ b/include/drm/amd/isp.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __ISP_H__
> +#define __ISP_H__
> +
> +#include <linux/types.h>
> +
> +struct device;
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +int isp_user_buffer_alloc(struct device *dev, void *dmabuf,
> +			  void **buf_obj, u64 *buf_addr);
> +
> +void isp_user_buffer_free(void *buf_obj);
> +
> +int isp_kernel_buffer_alloc(struct device *dev, u64 size,
> +			    void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +void isp_kernel_buffer_free(void **buf_obj, u64 *gpu_addr, void **cpu_addr);
> +
> +#endif

