Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC71DE9B262
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 12:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6955310E57C;
	Tue, 24 Feb 2026 12:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2qU+QP2r";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8B110E57F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 12:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0zCfrCL1PH9Q8bGbcymaWgY3lsNhCc7q+BaXnoGV+FleAIIr+lMf3g+7IRScn4Z577CTsl7fE6u/CN8p2i7OSzHhZFgdNu8kled2FTreI2vcTBg3UaKES5OT2lGPCy+HgarDw2TQgEW8SY8BNi2lg5p6UUKNQLfmSp44L5KydQZwCg5IVu6zj1oTiVZ3VpV9J5HDB8UbL1EfwAp0DAv5yhAkWAvQPAGemiPB5MvPJC+9NBrefQ/kmxXWdrqCjGXC0TfsCakNT8pUcgK8BGYmkGnoPJh17Kl3ZMSlZpwXcIk/xmNyA3zVdlHLH+My4wEUuweKszK/8w6Jr1dxnWRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRjUD337JXro+KyESzFx958xH4RZNq7V26qMt7IAQgs=;
 b=dpoy4BxZfpN7U/w9Ri6Z68NjQAMSrUPH+TRfUih9Ogrw70OaOaw+HpkEZfYLM40PmqE6Y/RolOKG8EeBM2BguLE2ulzNBKVLM/5SrgVfBprTcmwTEvoGr2Q5ww7ocZDX78ITAL5Rg2bGWaCKdjhXrPvg6nRMOsoPtWCJuJOue4lOMT85dbx9qTxqHEpdEgomOAWwSznpecJlPA40kBaJpJDWFTa4mm9SS3vGPOy1QGxljWNYWCY6wugIUXvwaPJNTe4GD1ePYksbNa378FHUPC/8qZSukhX8P6IB+F3YJim2IsIxNJZqG0OoUpBnf9i2YE40/c+ZTrGX4WMjncLPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRjUD337JXro+KyESzFx958xH4RZNq7V26qMt7IAQgs=;
 b=2qU+QP2rIRXph9l4Gz7whgbe4wbKGBY8VewJSN/DUk59nRoWk6CDef0DXvmk2zXfPqn1jCth3KDkU+vdMDT7tEB6DXJjJ6xhK9yRIgMO/2mFRmqEtCyC+ncNWcUhOESbiiWUECVz2Mj4sJGi3Ra/+kg5EIL8WW25gU38MkusOk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:57:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 12:57:31 +0000
Message-ID: <ba10fefc-e5c9-4b09-80f9-e73211031c11@amd.com>
Date: Tue, 24 Feb 2026 13:57:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
 <20260224091118.4017760-2-sunil.khatri@amd.com>
 <062ce56e-5d80-47c6-88e7-c45f5f72dec9@amd.com>
 <3dbe7fa7-e498-4cab-8b96-2cee679e0eb5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3dbe7fa7-e498-4cab-8b96-2cee679e0eb5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b41c044-1dfd-4998-1a85-08de73a445af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3B4SEtQUTBkN0xObXRwSURHWHRLUXNjZEtFQUp1MnY4cnNIOWhxbjVGMW1h?=
 =?utf-8?B?TlVXcHhJZndoZ29yUC9ianp2T0ZXNHJJSE50cVluRFNQL3NzVWF4aFZlZXBS?=
 =?utf-8?B?MXpNaVhXUzVJUE85RXFFL1VQcmVyZ3AxcWEyWUMzYndGZU5rVzk3bHBGMWpR?=
 =?utf-8?B?aTdob2VPcWh2TmNBeFp1MUVNbTlvTGVhUnU4OVdML05Vc0pJeHFnT2hLVDF3?=
 =?utf-8?B?RXVCMUtNWkx2SVkyYnNXejBKNHNMTkExOWNGVXAySlNGMmxLL3dDL2VNcVhF?=
 =?utf-8?B?eC94RnZ4RGhraUpXQysvQkdSaGh3VnRyeGdtU2M2b203ajdiT1VYN2lTSXR5?=
 =?utf-8?B?QVNLbzZWTUN4RThFM3o1Tmd3bFJWa2hvT1A4SGJ3R0RsTlJXUXRHZ0lEM0hU?=
 =?utf-8?B?RFR4SHhldDUwNDdFUEVoTi94NTIrcERBYkNTVnBrRDFlSkhmU0RsSG9yM0lM?=
 =?utf-8?B?aDRGWkZsUjd2ZnBRRE1Ya3dHaE1OUXNiUS90YzZYdWZ3WGJQNEo2MjQ0cyto?=
 =?utf-8?B?bTlOUEF0MlBETWthdTkzUE1wc0t0YStWUVpITGJwaks2TjgzMWZzejgzWWVl?=
 =?utf-8?B?V1FWSGRtaENvdWJySm9zN3o2QnBvam4vS1Q2QTRoRnJFS2VteldxTUFjeVF3?=
 =?utf-8?B?d2tWVUd1a1FYYWlxS3BQNHhBQ2kraDBPaFdKaUI5blZoYUROOE1nUnlDYzRm?=
 =?utf-8?B?QlB6d3lXYjFUQU9ZTUpQajloK3NsYy9HQ3JNbWcvV0ZGZDNQaWdjaGp5eEFH?=
 =?utf-8?B?N1hhbnZ6aU93ZXI0UXNreGxNZ0FXRmlXb2l0UGlBK2NEK1VKam5KWitGK2dw?=
 =?utf-8?B?QkJ6NGlZVzhtMDI4ZEdmUGIwU21sT0ZKZWwyQTQ0K0hxVG4xTi81eUJjNy9P?=
 =?utf-8?B?OWViMnMvUFlNZ3V4Q1QxZDJ3eWpvZ1NnaGJzZWlYQk91NU9UTzBNY01MUnpR?=
 =?utf-8?B?Nk5YQm5wUHBCb0F0REE4YzVPblA3Wnhld1VMQTQvM2R2SXpLR1F0M1FDd3J5?=
 =?utf-8?B?Y0VxRHlHT2RHUmUvTDhKOWZvTGlaWFl5NDM4c1BWQUdsWFZKa1BFeHQ0UHlv?=
 =?utf-8?B?UGljK1FhOWJ0ZTYxU1dYSFpMcmlvVU93QTNkTE4wYUh6NU8xdHhneFlnK2s4?=
 =?utf-8?B?MkVhb25zbHVRNVJIVFEyWWtqYzg4L2xCRW9UeG5mcE81Q3MwT2NZMUJCNkl3?=
 =?utf-8?B?Tjc0RWc2VHlxaXFkZWt5RWxHUDJXY1dQM0hMbGxTWjk3QmxrWnZLemRrbTNI?=
 =?utf-8?B?SjdrZVVzcDVRbjBTd2FjZTlmcTRGNUFkaTkvaXJpNlE3QVBzWVpYUVc4SzNj?=
 =?utf-8?B?eXZ5OEZ6SDFxMjMzKzFPS0d5VmF5dUo0NmhLNjVmN1RQMkgzTjBwbzVsWTY3?=
 =?utf-8?B?RXI5dVJKd0VISllEU3pLWndydXBzZnd3YXRRZEJHQnpUMUdieCs5ampCZnFM?=
 =?utf-8?B?aDE4U3pvc3FZcXZPZDZ5WWxXRGtMOWtQNTNyTTA2SHZKSnh0NTJXSFRpc1Rt?=
 =?utf-8?B?Ykg3ajMzQ0VlVFlqUWFhSWdnd242bk5GcXpCNkNGc21UMmczb0p3UHkxTkNO?=
 =?utf-8?B?NmdhNzBqTE9BRXk0cWRrRGd2MW04elFmNHpJM0VpSnZyVHh1V3hYUU1MNTZN?=
 =?utf-8?B?bTZPbnhzWUdMb3dYU1J0cy81SUszYlM2b3ZFeVlNLyszcEEvNDFQMVltMjJB?=
 =?utf-8?B?TmwxdzlKUzA5MEcxdFMwM2lhTHoyWTFNRDM1L3VySitJOXJNYmcwZlU4SmJV?=
 =?utf-8?B?ckU3dmhoR2JTSlhocHZPRExCQklub0FuVDExaE56ckZXaGFiMTU3SHB3ZWlT?=
 =?utf-8?B?SUdLenNYTzZyU3RTVTZ2UWtlV2xBUnFqalFVdnJaNWlSZFJuaHJ2aElWV3FM?=
 =?utf-8?B?NnF4QjJwMVUwTnFVRjZBQXAxeEtFUEZaaUdhZkE0YUs4WmpmR0g0S0dIcDVP?=
 =?utf-8?B?MG44VzIyRCtpME02SnVaS3BxemQwS0wrVFkxclBCcG1XNXc4YXJpc2FEck53?=
 =?utf-8?B?UGI4Ti9FSzJVVlBVdDBuQmxvT3QzR3JWaWEwZFk3SWVybXg0T1F6RmFhUk5B?=
 =?utf-8?B?MWVCamdmbWIydTh6M0xVcUpVR0c4cy9JMFBTQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBqQnpiWG5Ub2ZwU0haLzh1NEJRSVJWVVh5YkxJeW14QXc3SDh5ZllBV080?=
 =?utf-8?B?dER3d0ZiNWc5OFNyK0cwRGx2azhjcThSaTJGSFZnQVlxY05LSzNsUkF0MEpq?=
 =?utf-8?B?cktzK3JCVkdCdDBFYVp6WFRMUHBRdElxVUxubzV1WHFDVmNiVkxNR3NNdlRy?=
 =?utf-8?B?T0F2aS9XUzdKWVJJOGlJMXBlaHRITlpNMWJ3RVRJeHFhK1FxQTdVd296MWhO?=
 =?utf-8?B?MlRpbExIeGNwNno4U3VadjJ4YXdEbUI1b3NlSEttVkt2bFVxRGk1RVpEZUIr?=
 =?utf-8?B?US8vTmFPUDBzSkE3c2FkdDhITEpId1JjS1VkaE5JOWE2YXg2UUxBdS91cVVu?=
 =?utf-8?B?Z3JOaUx5VUROekFreEp2MnVHNVJCQ1FIWmh5YlVqNnpKNjJMQVZkd1daa2lk?=
 =?utf-8?B?WEt1Z2tjVDZaUk5iZGJkWjVmY2d4Mk1zVTNqVVZrYnBtUVd5WGx5WGRLMDRr?=
 =?utf-8?B?Z0NJdmxzME1FUzlMK2FlNVJaYVhGMWV2QmxZa0tJZzY5QUQwWHBiYlYxYWQ1?=
 =?utf-8?B?Z1pYRFdrb0NKL3o2TmlYMGRUZ1ZpR2lXTi9xUlBNakRBVlRvVUZHMEpSTTlh?=
 =?utf-8?B?SXlEaU5uRVJFendTSkFaUTNQc08wMnFaZkl5ekJBRVlBMWMvejRXNm5LNlQy?=
 =?utf-8?B?VE5DSjRZbGIxZG5IVDlHN1lic2dSK1F5b2lzL0R3Q2dFVFVQMWZBWlZlRnR6?=
 =?utf-8?B?V0s1SmV5ZlJGeWN1NXIyZUl3b3drMExhaHN0WXpVaWw0Q3NmWkRjZTNzckdM?=
 =?utf-8?B?Ync4L0xtMDFlM3BPQk9ISnhtVDlDRERLQzd6bnhmVFA1aU5xSmRhTll3SDZr?=
 =?utf-8?B?RUJHQURDbnZ4dCtLVXU1M0hwMnZwUkFDUFp0emdzaTlFMldrbGJhZW5zMlpW?=
 =?utf-8?B?Z2dQSEt0TlJJSkc5S2VwUi9vK3lCS29pd3QzKzhRbW5jbGdEN1ovTmlLa1VV?=
 =?utf-8?B?cTJQNXJmV0hBbWtpbExrcnQzdFBMeTFTdUV5UDIyaGFMUllEdDRiZHpHWGtS?=
 =?utf-8?B?bE54VVBWRm05SWpyTWpPM0hzamYxM2lKcGVWbndxS2c0em1RZUNsK05rOTZr?=
 =?utf-8?B?NkdRVkJDQ1ZaaWdub3FUYk1yRHNvU0h4VGJnMkl5bytRclhXOXlBaWRVcFdM?=
 =?utf-8?B?YXRqNERZZ2piNTVIV2VURlpqNWNHUVJtOTl5QllkU21YY3RzdjdSU1BKSVEz?=
 =?utf-8?B?YzhOTnp5MVJuNGwwajlJampuK2llY1B5ZmNIWm02MzlUWjRFRy9IVGw4Qlc1?=
 =?utf-8?B?ZG1YY3lFNTF6TEpqcCswMGFnR3FUSkw5UEdUdkZtUkZWT2UyaXphNnRtZXAr?=
 =?utf-8?B?citIRkh3elc1MXRlTXpqNVRuMmVMVUd3RERMV240V1pDbkR3cWpydGwzL25j?=
 =?utf-8?B?ZFJTNDFYNkRnZXJNVEx5UDM5V2tXaVBDc2YwOStyQ0F1ZlpnOENTbE5sclo3?=
 =?utf-8?B?R2tDU2pza0RWaElwSXg1dzVselpkKzlxUGRlckEreUY5dm4za1RBTnJOMzBR?=
 =?utf-8?B?dzA5VDNIdHA1R0ErNy9BRndpMnlvZU5DM2hRQ1haU1NFc0UxTEVkOUJWY0hI?=
 =?utf-8?B?Q3NjUDB1Ly9ZSzM2T0pkVGV1RE9SSlR6UjJhajJGa0djZmpxbHRoQ0pxS3VL?=
 =?utf-8?B?UEM3NU90YUN3bzNHdnlVZnhIUWV6RkpSOFE3bUUzc0JudUxsbmowbWNsdjR6?=
 =?utf-8?B?ZXE4Wk82SnE0S2dDYlFSN1dqVHhKblFVM2dST3JKZGpqNU43ZUExYXNXUjVC?=
 =?utf-8?B?UjhScEVsSnhtMDliMlhDZ1B2UFh2cUlUdkJUcDdqUUl0NkkwcG4zMlVIMHhS?=
 =?utf-8?B?N3NXTTVFTHMwM1RrMTMyblhMN1pTNDdBQkEvbjJJMmtXVFlXMFljaVFDeDlZ?=
 =?utf-8?B?bVF0YjIxSDZHa3N6d1FuWGtVZk5GQnNIUmYxMGhScXZKL2lxU3NBTVF6UVVG?=
 =?utf-8?B?dmk1VzhNcHU3N0wzNjNUN0R6RmdaYUxSRUUwZ3p4UDhYVVloNVJ6S3BQRWVD?=
 =?utf-8?B?Nyt2R1UxTm45Z1pxNmhKZEFuL0MxdldGY0Q0RmR0bnorUUErSjVWV2lIbmFD?=
 =?utf-8?B?bDhMQU05ckZxeHdLclh0NzI3MTRLSHk4TVlYcUdiM20yVERWM2RCd1RyakRV?=
 =?utf-8?B?QjB4VFczaS9SNWN0dldQN3M2WGk5cmRmenFGdmRZcW1QdTRpcDVncE1NNFRy?=
 =?utf-8?B?b1dTZGZ6ekg2YytFV3dtUjl4SzZLdUd1M3ZMMlhvandRRm1oZFpRdEhyejFv?=
 =?utf-8?B?M0dkZTd0TlZ0N1hqT3B4VDhxdnY0K2pDczZtejRvZHBldU0zbWh6RGVsaUpL?=
 =?utf-8?Q?+puR/N06hACAAoah9n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b41c044-1dfd-4998-1a85-08de73a445af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:57:31.6723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrlC1/JSkcx1+ElNdp7i7iOhE/dW6C9ryaHKqR3QO+Uh13bCwCpbHE+SjHEpzjzR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

On 2/24/26 13:50, Khatri, Sunil wrote:
> 
> On 24-02-2026 02:58 pm, Christian König wrote:
>> On 2/24/26 10:11, Sunil Khatri wrote:
>>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
>>> remain uninitialized and during free cause a fault. So to handle such
>>> cases we better set the gobj_read and gobj_write to NULL.
>> Yeah that still doesn't looks like a good idea to me.
>>
>> We intentionally avoid nationalizations like that if they aren't necessary because that allows the compiler to complain about it.
>>
>> Christian.
> Sure Christian.
> @Alex, can you pull in the drm-misc-next to have the fixes in ASDN, or if it is supposed to take some time then in that case i think we need to push the change no 1 and 2 to ASDN as signal/wait IOCTL are broken right now.

We just need the ack from Alex to cherry pick the patch from Srini over to ASDN. Should be able to do this by tomorrow.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
>>
>>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 18e77b61b201..e53e14e3bf2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>> -    struct drm_gem_object **gobj_write, **gobj_read;
>>> +    struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>>       u32 *syncobj_handles, num_syncobj_handles;
>>>       struct amdgpu_userq_fence *userq_fence;
>>>       struct amdgpu_usermode_queue *queue;

