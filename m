Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F4C678DA
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA4510E2A6;
	Tue, 10 Jun 2025 13:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eBz4M9M8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79DC10E2A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 13:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZvlR/SWHl23L3yh38/qGpF8jGazdRlBQnzbjOLXlruW4BsfAoOTV7pt9faSrj0PE/QgpxX0SHzFkfvl6Slt79JAPjwHSZNdvyVyi0pmuA6/pw+EEKeRDi9Ps/+Pnr/8McdybjBZ3MfV58u7Zuk5LP+oA/qH4J+s/4IQZ5TSoo9ufvGoVFTU9pIpKDR279DMm6pHObg7qKLPtmA94wkm3RTR2xDN5T+2tbHDp/SWcFsJ16WxBqcwCHcEJSzJ9QLPDFr4jZ3uj2i0kMN8Lq9bXHBik8+ysc1QFkHMYXgsM/J/BBzdpK2PZvEy0h7+JFsx2Lp3RgLCYB1c2PR8UXaDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoR6JuLhd+7bgGt/nxvy09v3XbN3cAzLHWdBh2ZFFPg=;
 b=a9tvTRKq/YE9PGWQKKzWSocNcCpTH7I35EzguRfUoZfIguZi70IFP4JXxCIi2dXxlgV1CohZfE/4RfB+uOlMVMXr4PGvD0vPN7vV3JeW2PXCz2oEw26InEX6NpHdaRTfRiFafsngJy/SZJf9sUD7HFIQSYuE+dtetlJHIVHT3WZsRCECWu+EYPp25thDyi6fLg8SHHyKo7makvevdm7yaNSOY9aDvNIIodtvNzjpnqZOKMTTlM67aZciW558bIEg8Cw/tmLHXG0ktE1XJlSgnNdnBRnBhnZcxuddnmvqUCSReqef5Dd3l10slPxaiPQW9CqJLVkwQ+uiUvcqgA476Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoR6JuLhd+7bgGt/nxvy09v3XbN3cAzLHWdBh2ZFFPg=;
 b=eBz4M9M8mI0MC88fXf2q8yoWn9fkHZHEaKGaRl0XB/DqaVV7PBjkRtG1wZqL/nsVCwN5dXlFfg6iTevmY/jLvqunBhusXX3IJWyqASQAvHmpe/wGfmlKSmPEK4/C3I9HYMCvt0adXXzl4kg1K9jeNBVgu36g2UQDVM/kbw/Ugsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Tue, 10 Jun
 2025 13:05:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 10 Jun 2025
 13:05:38 +0000
Message-ID: <2cefb0f5-3820-4828-8360-ff8c92e21aa6@amd.com>
Date: Tue, 10 Jun 2025 15:05:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: give each kernel job a unique id
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c67dd58-b733-497d-c540-08dda81f7e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtYVXg1anRFNzNGNDhzakk2bkpTUFphV3ova3lISmc2K3V0SzlBeWREamlt?=
 =?utf-8?B?QTQ1ODlVTjVlYUt4QWhxL2hiTFE2WUovYUl3N2dDN0dvWUFmU1I2ek5vQWRU?=
 =?utf-8?B?K3FwMmlGemlxeit5UTZZajhjM3VyV2V3OGVvS1BFbDYyNkV0M2VVbUp0N2VM?=
 =?utf-8?B?R28vWnFyZWlRNkNrK1hnbHRoYmQ1MFo3RGJ2UFFvTGg3bDA4dXkwSGUyNjQ2?=
 =?utf-8?B?dTRnU1AvdDJiUmJPdytSRWUzbnlrTkcyVGtkVFpocnpEcDlORlN5ay9hODVT?=
 =?utf-8?B?Zzlselh3cjdoUDdRT1pxaUdwdyttWGl0WG9PT2VZMytvRDRpN2FwUmVOZTFy?=
 =?utf-8?B?SHB2L0F0d2NoMkNtaWhYcDRnZ0dUVEdSd20xdE5GaVF2WnlJamlBckJMcFlx?=
 =?utf-8?B?RDE5OVI5RktOWTBjWHlPRlAxN0JNWFlhVXVmcjA3cSszVjFrbWJqL0NmbnMz?=
 =?utf-8?B?UDdUNk82SmVib2Rrb0R1VVF0N2FrL3NLTlhlNTlUUnRsRXFFNEIvbnh0WTJi?=
 =?utf-8?B?VmpIUmVYbHBBeExzcXNQbUptVERFcTRucHl2dU8zOHp5YllmelgyK0RRa1ln?=
 =?utf-8?B?ajBibk15cXZtWWQ4bm1YcmpPSmNxaUdQdmRKYWxHdEFrUjJtdXpUd0U0WEVm?=
 =?utf-8?B?QkV3UUhteVQ1ektzQkZYck9admtpNGw5cmtYNjdYcVh4ejhIL0w4Skp4S2hC?=
 =?utf-8?B?NnZ6ZmxHN0huWGFTTjRrczF5NXlkOUxrb0xOUHVwN1cyTTB0dmczbStzRDRi?=
 =?utf-8?B?TTZ6ZkZ5T3AzYWJYdWV3eTljVEord1UrQ2RQQWVad3c2blRXdXRxRTEvWUtw?=
 =?utf-8?B?VGJiK3AxRUNCcXU2czdhUWpVV1p2MU5NRHpydm83eGhwRS9BTllEZ2p6Vm90?=
 =?utf-8?B?SXcxUFFmZDJvTW56czkrc21OdWxmdzhUQnJMUmtSYm5ock5aa0lpVjJIcmsx?=
 =?utf-8?B?OFdiVjdSaktiRSt0YUVHTEQxMkZTQlJNS0YyV293bTk1MERXZUZUVlVNSXZF?=
 =?utf-8?B?dXNCeERTdHZzOTlrOE1Gc3RjTU1JTUhxMnZIU0dLS0RKVjRNUWFMT2J5U2R6?=
 =?utf-8?B?WSthbVhjcDgrdzQ5Q24yUUVtZjUrdXlqWkJFVVB6aURRcmk5OTI0TXJRSjN4?=
 =?utf-8?B?WmdjL3Juc01qLzczRWtEeXZyejhqaUJiVUhSd0JWbm8zMGdzeW9QaU80dW4z?=
 =?utf-8?B?VklxUFdYN25keHl3aG1ZQ0FJbFJ1eWFnSEk5V2k0QWQvYnlRRDFVUU9qTGJT?=
 =?utf-8?B?dWE2aWxzYjRJSHBaR21NT3BYai90RWI4UytHNTBlKzhWMU1BRHl2UVJPc1Ns?=
 =?utf-8?B?REtBUjdxMkhLcXJkSzhUdUF0b0pWSk05UTU0ZCtNdGdST0JaK3hUUVBSWFE4?=
 =?utf-8?B?aktXSlM0VG5tbG9hZlE1NDBzT1kxQ25FbFdhMm9LenN3VCtUOXNzTVJYWGRW?=
 =?utf-8?B?L2FOUS9MeC9ReExBV0JwYnRPSHJnVnEvNkZPcHRmakEwcW9JdnlPbk00a29v?=
 =?utf-8?B?TkgxVHlUbFlKcWZpRC9nVWNlWDNOUTNuWEkxbWxZM0k1NFU1YzlQbCtjRDhz?=
 =?utf-8?B?WGNmNUJwSEk0T28zQUJPNzFTd1Q5Slg3N3VaUFk1OEpnR0RTQzl4aENjWWht?=
 =?utf-8?B?WXFscDlwalVvOU5rblV1NDN1andnNjdvYzJtaUJYSC93Zi9CSElySmxISkk0?=
 =?utf-8?B?UmZjRDlsWjVacWJ5cHhlY2hOSEozZGdoeFdURjFFMTNtZTBta3BIV1p0Mkxn?=
 =?utf-8?B?Z0JaT3dxd3dHUDA5di80bmU5UDR0SU9kd2doTk4xSXBERXZ6ZnYwbW1ybXhJ?=
 =?utf-8?B?RmVybDRKMm5EbW5Uek1jd1djSm9oUjdQMU9mR24zdG9mMTM3NVB2ZVQwcjVM?=
 =?utf-8?B?eks5V2lPemNBNFB1QW1BSUN0UTNzVVV5OTUwN2UxY2hZZmEzRGZvME5sTnRO?=
 =?utf-8?Q?+jhrs//Cb3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGg5ZHppck8vNnpQMEJ3WTl0c1NjT1JKdXRiWG96eDZ2cmhpK0w4cDRheWNO?=
 =?utf-8?B?MDlzQ0pXbTdwZFlHbzhoYXBwbjJYMFEzQithUlVyQTNOeUo1T2VrMkxMSk9p?=
 =?utf-8?B?dVJjOVlMNFZIUTZ1Ni9zdjE5b2JEZEtBaldUVS9PditaeTRvMFhtMUkxVHRx?=
 =?utf-8?B?UDVTSTBQcnNtZ0tHbXBIcHJVMjl5ZXZUYlVjQnVHMng0WmpPQ0U0dSt5VzYx?=
 =?utf-8?B?YVdWbHYyVElJWnJwT01abndNOHZyckNCOWxiL3BaYnFxK3NEMFZuNFZsRkpm?=
 =?utf-8?B?WDQrNmtWMFRrNHVkWXVoNTlKczc4L2dCNHVmKzVSSDEzUWNRODZvVklhVFhH?=
 =?utf-8?B?YitNNkdlVno2VU1zb1ZVVWhvc1VlNnYyNnRlZTZWTkpRT21rd3lTNEdMWGlz?=
 =?utf-8?B?K3hCWXVjY01zMk1pRjlHVHJaSS9veHp1bzFOaVp0eTh4ZXJlOGdXK0dQZVE2?=
 =?utf-8?B?Ry8xZHRaT2laNGxvMG9XY3gzS0RoaWlLODVKdThsTlp2NUt6d3VrVnFsN29j?=
 =?utf-8?B?OW5QSENzaGM5OG9VOHZPRE03WkFyL2M4Y0Mxdlc0SDNWSG9UMk5HSzNvejlk?=
 =?utf-8?B?NVRIaGg1UkQ1ZFRvZ2ZxcjNYcDhLUyt0RS9GN2RzZU1sWWZQeEJVMG1SNWI5?=
 =?utf-8?B?Rkdud3NJV0JsK0plbkpLOGRzVDFaQlhrMEs3YnNPbnNKYy8xLytSaTltcU5T?=
 =?utf-8?B?cHdGVDhBT1pKTXQyYVpERFUza05TYkZWcDlwQWJkZ05tSUp0SkR5VG5SVk42?=
 =?utf-8?B?SS9yTXljcE10VWpGQWNVbEVMaFRCdmRuL215WU1Wc05KR0RBSE1pSmszRThP?=
 =?utf-8?B?eDB4Tm85a201L1dSSWZDMTdJOHFxaG5LTmdxS0FzV3gzYTBOZ0tpWXlNblFt?=
 =?utf-8?B?bWlEdW1yajBPUEtUN2Z6WGlQMVliUktmU3JDdnhjUi90SGFZUi9yeThHRzR5?=
 =?utf-8?B?STA4cEVvd01oQXhKL0ZLaGxkUUQzWG9UVWpiUmh1WENPdERxMEJYVWkyOTdU?=
 =?utf-8?B?aGlHOWV4VCtMblUwMjBJV1M1ZEY5K2c4amV5K1ljSTBiS3RMdDJPU0JaMkpq?=
 =?utf-8?B?d3Q1OEk2N1F4NXdkR2hSbDNuUHhJczNwcG11dkppUGdmY0dGOVlSZ0psdEk4?=
 =?utf-8?B?YUhZYlZmb1JEUG5qTmh6VGZrbUFla2dQMXVGYkgwcGE5d1A5TGxLSUMwSFUw?=
 =?utf-8?B?ZnFKNzVXNXdTSDZzNmhGOXE4andqMmhlZ09oc1V4RDRHdlhoVHNwcVpOckJP?=
 =?utf-8?B?Rkh6dEJmRndmTlM2QWc4c2p1bzViRDZvMzZ2cFZ4YnFvdFVOeHpiOFpKcjVr?=
 =?utf-8?B?VytLUEhnUjN6c3FVemdZV0xkZSthZFZpTHB5Sk9HT0dJeFZNdmtLTkc5K1ZH?=
 =?utf-8?B?TmdaNFFvU2h6Z3BSV0NYUnp6bXJtUm04bktMYjJSeTd1MG1kcjQ4Vzc5WVVR?=
 =?utf-8?B?K2owYlB5dk1MaTdkdWVlcXlneUlBYXhOWmR0MHVISktPbE1EV2FSUDE1QkRJ?=
 =?utf-8?B?c2xTNkx4VXJUNkk3RXRoUjB4OW50d0k1VEJ6NGFWMENMZDY2Ri92SUg4dW0w?=
 =?utf-8?B?Qkc1OVZNUCs5bWxDRmYyVnNmZW5HMG1VMHNPUVd4blhDQ0QyaWFmTHBLT3Bh?=
 =?utf-8?B?WWxub2xVNDlFWEZRekI3RWlVeUdpUm80YmhTS1lUOThVRDdvNU04QjJOY1do?=
 =?utf-8?B?d2RKNlpJK3hPMUdEQlk0alk0TEdPTVdSTm54SVR0Q1lORnZzaGgzc2E2UzB6?=
 =?utf-8?B?cXRjcURBM2VrVzZPbnZBWXJWa3AvKzNvdlcxTVBFYVNpMmVPQXdydkJUeDhS?=
 =?utf-8?B?aEJEVm1DdlhoYjI3OU5rY0RDOUIxQkhsZ0hSSkRCc1VmVmlZSjdYSXpISVZ6?=
 =?utf-8?B?SWlOUWl6akduUmRiWEtRK2Y1TTlZbUxTR1JSUTJhbnRoVGllUVhWWi9PTnVz?=
 =?utf-8?B?K3p3R3hBQU96bGwrSTNmUXBPZTBvWmswTEhkZC9QM1MwWkhzVG1reE5ZV21r?=
 =?utf-8?B?TU4zS2pnTmdHWGs2MUNYemcxakkyd2puYVVlYVFqcE92RFdIV1ZTNVFOSURV?=
 =?utf-8?B?MVdZRXB5NHVJeThhRTBuVTgrK2FoZVZnRWk2UWg2eVAwVTd2WkpkSzlvNWd0?=
 =?utf-8?Q?a6/iSBtdzm3YOsN7eVy8Tk/d1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c67dd58-b733-497d-c540-08dda81f7e83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:05:37.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzVLUqp3px6CpmOzcQUWEBrcLVHVr7LDGNcSjbfXRbm++GcfWJt0aGKKsMoFAhjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
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

On 6/4/25 14:28, Pierre-Eric Pelloux-Prayer wrote:
> Userspace jobs have drm_file.client_id as a unique identifier
> as job's owners. For kernel jobs, we can allocate arbitrary
> values - the risk of overlap with userspace ids is small (given
> that it's a u64 value).
> In the unlikely case the overlap happens, it'll only impact
> trace events.
> 
> Since this ID is traced in the gpu_scheduler trace events, this
> allows to determine the source of each job sent to the hardware.
> 
> To make grepping easier, the IDs are defined as they will appear
> in the trace output.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 19 +++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 28 +++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 12 +++++----
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  6 +++--
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  6 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  3 ++-
>  19 files changed, 84 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cf2df7790077..adc151183e83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1461,7 +1461,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>  	owner = (void *)(unsigned long)atomic_inc_return(&counter);
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> -				     64, 0, &job);
> +				     64, 0, &job,
> +				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
>  	if (r)
>  		goto err;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index ecb74ccf1d90..66e762c1e43c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -674,7 +674,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB);
>  	if (r)
>  		goto error_alloc;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 75262ce8db27..9fd5387a0cd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -230,11 +230,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>  			     struct drm_sched_entity *entity, void *owner,
>  			     size_t size, enum amdgpu_ib_pool_type pool_type,
> -			     struct amdgpu_job **job)
> +			     struct amdgpu_job **job, u64 k_job_id)
>  {
>  	int r;
>  
> -	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job, 0);
> +	r = amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
> +			     k_job_id);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 5a8bc6342222..6108a6f9dba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -44,6 +44,22 @@
>  struct amdgpu_fence;
>  enum amdgpu_ib_pool_type;
>  
> +/* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER        (18446744073709551609ULL)
> +#define AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE       (18446744073709551608ULL)
> +#define AMDGPU_KERNEL_JOB_ID_MOVE_BLIT              (18446744073709551607ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER       (18446744073709551606ULL)
> +#define AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER         (18446744073709551605ULL)
> +#define AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB          (18446744073709551604ULL)
> +#define AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP           (18446744073709551603ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST          (18446744073709551602ULL)

Mhm, reiterating our internal discussion on the mailing list.

I think it would be nicer if we could use negative values for the kernel submissions and positive for userspace. But as discussed internally we would need to adjust the scheduler trace points for that once more.

@Philip and @Danilo any opinion on that?

Regards,
Christian.


> +
>  struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
> @@ -95,7 +111,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>  			     struct drm_sched_entity *entity, void *owner,
>  			     size_t size, enum amdgpu_ib_pool_type pool_type,
> -			     struct amdgpu_job **job);
> +			     struct amdgpu_job **job,
> +			     u64 k_job_id);
>  void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
>  			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>  void amdgpu_job_free_resources(struct amdgpu_job *job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index dda29132dfb2..41e083ed0758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -194,7 +194,8 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
>  	int i, r;
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
> -				     AMDGPU_IB_POOL_DIRECT, &job);
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0b9987781f76..0ca8f0362354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1315,7 +1315,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	if (r)
>  		goto out;
>  
> -	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true);
> +	r = amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true,
> +			       AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 53b71e9d8076..72db29906c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -226,7 +226,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>  	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4 + num_bytes,
> -				     AMDGPU_IB_POOL_DELAYED, &job);
> +				     AMDGPU_IB_POOL_DELAYED, &job,
> +				     AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER);
>  	if (r)
>  		return r;
>  
> @@ -405,7 +406,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>  		struct dma_fence *wipe_fence = NULL;
>  
>  		r = amdgpu_fill_buffer(abo, 0, NULL, &wipe_fence,
> -				       false);
> +				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>  		if (r) {
>  			goto error;
>  		} else if (wipe_fence) {
> @@ -1509,7 +1510,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
> -				     &job);
> +				     &job,
> +				     AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA);
>  	if (r)
>  		goto out;
>  
> @@ -2159,7 +2161,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>  				  struct dma_resv *resv,
>  				  bool vm_needs_flush,
>  				  struct amdgpu_job **job,
> -				  bool delayed)
> +				  bool delayed, u64 k_job_id)
>  {
>  	enum amdgpu_ib_pool_type pool = direct_submit ?
>  		AMDGPU_IB_POOL_DIRECT :
> @@ -2169,7 +2171,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>  						    &adev->mman.high_pr;
>  	r = amdgpu_job_alloc_with_ib(adev, entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
> -				     num_dw * 4, pool, job);
> +				     num_dw * 4, pool, job, k_job_id);
>  	if (r)
>  		return r;
>  
> @@ -2208,7 +2210,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>  	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>  	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
>  	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
> -				   resv, vm_needs_flush, &job, false);
> +				   resv, vm_needs_flush, &job, false,
> +				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>  	if (r)
>  		return r;
>  
> @@ -2243,7 +2246,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
>  			       uint64_t dst_addr, uint32_t byte_count,
>  			       struct dma_resv *resv,
>  			       struct dma_fence **fence,
> -			       bool vm_needs_flush, bool delayed)
> +			       bool vm_needs_flush, bool delayed,
> +			       u64 k_job_id)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	unsigned int num_loops, num_dw;
> @@ -2256,7 +2260,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
>  	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>  	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>  	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
> -				   &job, delayed);
> +				   &job, delayed, k_job_id);
>  	if (r)
>  		return r;
>  
> @@ -2326,7 +2330,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  			goto err;
>  
>  		r = amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
> -					&next, true, true);
> +					&next, true, true,
> +					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>  		if (r)
>  			goto err;
>  
> @@ -2345,7 +2350,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  			uint32_t src_data,
>  			struct dma_resv *resv,
>  			struct dma_fence **f,
> -			bool delayed)
> +			bool delayed,
> +			u64 k_job_id)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> @@ -2374,7 +2380,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  			goto error;
>  
>  		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
> -					&next, true, delayed);
> +					&next, true, delayed, k_job_id);
>  		if (r)
>  			goto error;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 208b7d1d8a27..57a1e0b7c1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -180,7 +180,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>  			uint32_t src_data,
>  			struct dma_resv *resv,
>  			struct dma_fence **fence,
> -			bool delayed);
> +			bool delayed,
> +			u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 74758b5ffc6c..5c38f0d30c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1136,7 +1136,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     64, direct ? AMDGPU_IB_POOL_DIRECT :
> -				     AMDGPU_IB_POOL_DELAYED, &job);
> +				     AMDGPU_IB_POOL_DELAYED, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index b9060bcd4806..ce318f5de047 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -449,7 +449,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>  	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> @@ -540,7 +540,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4,
>  				     direct ? AMDGPU_IB_POOL_DIRECT :
> -				     AMDGPU_IB_POOL_DELAYED, &job);
> +				     AMDGPU_IB_POOL_DELAYED, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 1991dd3d1056..9fc0f7ff6c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -600,7 +600,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     64, AMDGPU_IB_POOL_DIRECT,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		goto err;
>  
> @@ -780,7 +780,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		goto err;
>  
> @@ -910,7 +910,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> @@ -977,7 +977,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
> -				     &job);
> +				     &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ce52b4d75e94..a33b177e1d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -965,7 +965,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  
> -	r = vm->update_funcs->prepare(&params, NULL);
> +	r = vm->update_funcs->prepare(&params, NULL,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
>  	if (r)
>  		goto error;
>  
> @@ -1134,7 +1135,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		dma_fence_put(tmp);
>  	}
>  
> -	r = vm->update_funcs->prepare(&params, sync);
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
>  	if (r)
>  		goto error_free;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..c1a3257463d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -309,7 +309,7 @@ struct amdgpu_vm_update_params {
>  struct amdgpu_vm_update_funcs {
>  	int (*map_table)(struct amdgpu_bo_vm *bo);
>  	int (*prepare)(struct amdgpu_vm_update_params *p,
> -		       struct amdgpu_sync *sync);
> +		       struct amdgpu_sync *sync, u64 k_job_id);
>  	int (*update)(struct amdgpu_vm_update_params *p,
>  		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
>  		      unsigned count, uint32_t incr, uint64_t flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 0c1ef5850a5e..22e2e5b47341 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -40,12 +40,14 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: sync obj with fences to wait on
> + * @k_job_id: the id for tracing/debug purposes
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
> -				 struct amdgpu_sync *sync)
> +				 struct amdgpu_sync *sync,
> +				 u64 k_job_id)
>  {
>  	if (!sync)
>  		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f794fb1cc06e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_job.h"
>  
>  /*
>   * amdgpu_vm_pt_cursor - state for for_each_amdgpu_vm_pt
> @@ -395,7 +396,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  
> -	r = vm->update_funcs->prepare(&params, NULL);
> +	r = vm->update_funcs->prepare(&params, NULL,
> +				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
>  	if (r)
>  		goto exit;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 46d9fb433ab2..36805dcfa159 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -40,7 +40,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
>  
>  /* Allocate a new job for @count PTE updates */
>  static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
> -				    unsigned int count)
> +				    unsigned int count, u64 k_job_id)
>  {
>  	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
>  		: AMDGPU_IB_POOL_DELAYED;
> @@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>  	ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
>  
>  	r = amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNER_VM,
> -				     ndw * 4, pool, &p->job);
> +				     ndw * 4, pool, &p->job, k_job_id);
>  	if (r)
>  		return r;
>  
> @@ -69,16 +69,17 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: amdgpu_sync object with fences to wait for
> + * @k_job_id: identifier of the job, for tracing purpose
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
> -				  struct amdgpu_sync *sync)
> +				  struct amdgpu_sync *sync, u64 k_job_id)
>  {
>  	int r;
>  
> -	r = amdgpu_vm_sdma_alloc_job(p, 0);
> +	r = amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
>  	if (r)
>  		return r;
>  
> @@ -249,7 +250,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  			if (r)
>  				return r;
>  
> -			r = amdgpu_vm_sdma_alloc_job(p, count);
> +			r = amdgpu_vm_sdma_alloc_job(p, count,
> +						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 1c07b701d0e4..ceb94bbb03a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -217,7 +217,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
>  	int i, r;
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
> -				     AMDGPU_IB_POOL_DIRECT, &job);
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> @@ -281,7 +282,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>  	int i, r;
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
> -				     AMDGPU_IB_POOL_DIRECT, &job);
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 9d237b5937fb..1f8866f3f63c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -225,7 +225,8 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, u32 handle,
>  	int i, r;
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
> -				     AMDGPU_IB_POOL_DIRECT, &job);
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> @@ -288,7 +289,8 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, u32 handle,
>  	int i, r;
>  
>  	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
> -				     AMDGPU_IB_POOL_DIRECT, &job);
> +				     AMDGPU_IB_POOL_DIRECT, &job,
> +				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 79251f22b702..683ff02c45af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -68,7 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
>  				     AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4 + num_bytes,
>  				     AMDGPU_IB_POOL_DELAYED,
> -				     &job);
> +				     &job,
> +				     AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
>  	if (r)
>  		return r;
>  

