Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB4C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 07:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088E410E588;
	Wed, 28 May 2025 07:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVg2WsAk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629510E595
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 07:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIYSe6ZqsRwEFVQnFT4sd8oUkl3dQi/74AZh5ak7iKpT3qf2onIlH4iqWA3+e0z1Qd87FYY77UJ2jZE/r5xnr0kfFWSkfeZBwgS6chhuh+0T4mlR5ceP3eupOt1gi+ZylnT61mkvjPAyXFnVTk3tl8vI+jT7Bv12JDe523B5zjy9bMcXQZe6MM8261hU5c5jj/tb0SZmIrSeYW/BTBmbPTaueDJcMb45ogDPax2phzvLSr1hscxDaZb3sfTqwLGPEjzYlyqa4xB5eVRJa1GKWWw/DtC2rnCElkRse83CNLAc6S36cc6V1dLZVHaJljFPeGg3AxDOuaA+iVFjIyjlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcQbcZHXbh2dxDmqDExZ/smSfON/5E1fgXN23o3O/WQ=;
 b=IiSwLmRW/JaznIXWZ+PFpzUri0t/3exwwec2z30gdp066G9HCx784rgIJmm6Q2dLF339nROl/hX8p4ssucJiSn7XcKhTf2Z2EKStlVJmTM8/+wTdNNQhgMKeNhWFSECgAw06e5I+7LBc/mR5hpBPsAWEYBChSm0wXiGXtG/DHQQapN1jFAvAP64WXePg3SRAy4bUDrUCGP9YuYXFf1JVR1SmSUTMZKox2TCQqNRKhMyG1X+r0Ox0TtZQbLXNnCxgdpVNQO43hW7bElqfgrXJAYxBSYB3os3jvS8Yb/82Z2m7eRJ8aUDKIT+T19ZrmMBb+4+QXK1Z/epBK8P/bXo1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcQbcZHXbh2dxDmqDExZ/smSfON/5E1fgXN23o3O/WQ=;
 b=dVg2WsAkxLjPJEKdb1Jrb82MAzMhSM6Ujnqpv3AJmDFKmpOBvpBOcQxdTd4QKIsMqWnzhiKJjzPqoUizn55OK4poy43MuwjVRZAM9gbrs2d0xWYbVH5Mvl7ydx2/6oQxOZwk0QsI9kpEvg33/h+aaHwj9phrcXbW72LojPCBLp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 07:48:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 07:48:18 +0000
Message-ID: <61a99144-1128-411f-be3d-e72dce99c9a7@amd.com>
Date: Wed, 28 May 2025 13:18:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm/amdgpu: update xgmi info and vram_base_offset
 on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
 <20250522104048.569456-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522104048.569456-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 69596e5e-cdcd-4f67-1a3d-08dd9dbc02a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1pGL3NPZUlVUjdpdlNPZnVkOTJxQkJhcTRvK3ZVNnZRNE1RVXVrWmpNdVN4?=
 =?utf-8?B?R1RRcEN1MkdlY1U0MmViRDFLRXBDQUdQWXFuQkZFWXI1MjM0cEdPQWdIcDBl?=
 =?utf-8?B?d2tjczlybzA3c1ZyaFRlMUFXT29Fa1l3ZjNzcFNFTEhRTnk0MDNOM00rU3BB?=
 =?utf-8?B?b3dDL0lEWlJ0Y1EwU01SM0FvcnhJODVBbWd5RHpGd0diYUNSd3lrN3p4U1Qy?=
 =?utf-8?B?MmZmcmdvSW9ISm84YzBWNktDczNFQlJYcUJBRG5RRjBOcURscHg0WFd4Nkcx?=
 =?utf-8?B?alJ3cWdKdkZwYTAzb0ZFNW5LQzY5VUlKdjNlS3g5bDdpWVlpMzg4Zk1pYjVG?=
 =?utf-8?B?Tyt3djVNTVE1bHhlR2hONkxlNENzWjM3VEtyOHRDSUE0clJZaUUwR09tb3Ro?=
 =?utf-8?B?SVBIUndwT2REU1RpeTZ2UmVqSmxUQUxEWHg2Qis0dW9NR1NkM0xYbzNaSE5B?=
 =?utf-8?B?OURqc0VTR0lYV3E5aEVtT251ZGhxa3ZNdWZFVm04cnc5ZzZ3OUpzbUZLbnNB?=
 =?utf-8?B?dlN0R3RhdExXZVNQN2pnbVd0aTMzbU8vd3Q0QVlLVThTUklHQnJxQ2JsS29h?=
 =?utf-8?B?VWpWUysySnBDR2N5eUMvcjk3dks4MVVNVldRRHFKZmIrZlFsOUVibVR4c0hn?=
 =?utf-8?B?UVRMeXJ2ZDlHeDVvajUrR3h0MkNnWlBXQVpZY3RDcjlZRHdaeHREdGJlYmtR?=
 =?utf-8?B?a2E2ZkJhQXFwUHVIMS92enovMkxUbitFbDlnMWx6SVExam0yZ0NqQ2gvZGFG?=
 =?utf-8?B?OXg4SlZBMXpxM2RHbHgrc3lacTg0N0oyYkdxOFkwNUdSVUtsVFl0RHZGc1Yr?=
 =?utf-8?B?V0FXNVVyMDhnR0QxdDJlejg1Szc2MnJrU3NXVXVYSHBCRXJDeisvNkZoRHl2?=
 =?utf-8?B?QVdiVzJYZ3Y1RGlvZkdTaWRBQ0FOaUl6QXFSZTI1cEpMMFlVS3hKSjgxNTdV?=
 =?utf-8?B?V2dlbi9FQy9RL3FyMnZsWkVRdFpvOTVSVUxhR1c5eTZYd3h5eDhxZ1ExdGN2?=
 =?utf-8?B?bVZhOW5ZY01NTW1mdE5ydFFscEYwbTYxV3JoY3R2eDFvdTZjRUZIMkdYUGlJ?=
 =?utf-8?B?L0tZbDM3ZlA2MS84bVJTNXVXaHhUUXVZN1lYOGhSUWk2VVo3YW1YTG1JV3Za?=
 =?utf-8?B?cEthNlJDTzBETURaSVJBYzRkYjVUQ29QUmM4RUZsbUFJNE1SZWpmL3pWU1c2?=
 =?utf-8?B?ejBWZTUzK1BVaVJ0UW5hK2lJZURQcnNqdmNrd1FMT3FOODNJcWJiTTEyZ1Aw?=
 =?utf-8?B?ZVB2bW9Tc1pTYTU2V3Y0SGFnODJGelhlbEdOaFFSdXNsYm41TlNYc0RwcUJP?=
 =?utf-8?B?QVh4NFJ5RlVnd2oybjJWTXF5Q0ZjSTNTNzFKdWNudm1ZdlZodHpwUnBocVNK?=
 =?utf-8?B?ZGlPWU9DS29lRkJlZFh5RmxUQ3Ixa1h2RGRUdzdkM2x4elBqSVk2eGF6QmIx?=
 =?utf-8?B?K0duRThrTHFNTXMyMmR4Sml6OGx2WENmUjFRdGVmclE3NXZjYm1sOHFldVdQ?=
 =?utf-8?B?RUFVeStNYkE1a1g4VmZCd1FoVXFkTldhZU5UdDJST01DS3BBM1JSMU1kckRp?=
 =?utf-8?B?RmovcXZyQkFvd1ZjQmpiNUlKRUlOeXFzOGNuS0RNVFRJaTBjK0g0ZElpd3hX?=
 =?utf-8?B?dyswbjhxVnhLUFFvZmJTT1Z6K3YxVHl0N243RzBWTTd5U1N6MG5QMElES0J5?=
 =?utf-8?B?SGdYOXNKRGd2elc3VEN6T04zSmdrMUw2MzFpcWVSRWxnMWlEdDRBSzM5TklY?=
 =?utf-8?B?bGZSZmRDNjByb3BxVm05YllOekdxY0I0dFczMlBnb2x6VDhybVNVZ0hrelFP?=
 =?utf-8?B?RzRPYjhMc1h6T0orMXNVZHBDRVZOMzZFNjJQczI2ZDY3S2tYRUI3aGRGMGlE?=
 =?utf-8?B?VlpGZkFTdDhtMVdtZjJjRmNEQ0JJQ3g1dWswUVNIZFdwdU9XNzNBV05oQVdE?=
 =?utf-8?Q?/bhQATw2ts4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnl1NEdleW9RSXE3dFVJd2NROHNpQzBZWHpNcWJQUHRmYmlWRjU0a3RyRTNu?=
 =?utf-8?B?TU9oSTN2RDE0STdLQThRZ0M5Y1V4VmZEZWZXL29obEtZa2V1Vm1oRVJwS1JJ?=
 =?utf-8?B?N0V3bks2UkY0UThDaXV5Y3M3aWtVeE5xOUlHV0JzWGpqMTlXam1abE8zc2hj?=
 =?utf-8?B?R3pYQm8wM281VDhvM2t6YkVLQllSRkJoWEdDVndXVU1SbHZ3Zk05TGJkUHhp?=
 =?utf-8?B?dUdjSjl4eEpYZ3NhQUJFSTN6OGxPL1hpRC9qYnc5L2RJdG1BYVpNa09NVEo5?=
 =?utf-8?B?bS91Rksvb0YxRjMxV3BObnNvWGpzNmVKM2JjU3hVNy93YkFyeHlSekdWd1pE?=
 =?utf-8?B?T09vL1ZjbStXK2I4R1BuSXNGVEd6U2FLK0xDZXdEM0tXU0RHeGl5ODArUFZs?=
 =?utf-8?B?cU52UUJrWFREUnJOdkNPM0hpdmZPVmxvNEZwMGhGWFpncHNIWjByeE9wUDJv?=
 =?utf-8?B?NHZIa2NuRkUzM3ZCcjh1WWNxdThNSmFLQnJqMVlsR3l6ZjloZUJRQXZISTNH?=
 =?utf-8?B?b1o5Q0dMd3k3TXV1c3BsL2w0UVBYR0Y5R3dxdjB2YzJERHlQWFE0d040clhZ?=
 =?utf-8?B?eXRUOGZuMnMxRnFWeUFva2VwV01manZSZFhCMENiSmJRUzJxYkVJL1RjVDNq?=
 =?utf-8?B?VWdxN0FnZzJWWE9qck1INkZNQnpvU2w2Y3g3ek51VUJWREpTdHRlUXNwOHBx?=
 =?utf-8?B?ZTRhOTVZcmorTjhHblh1TUVUSlQrMDlIbmtJUkFjOHM4Q0h0Rkl0Zk5ldE9s?=
 =?utf-8?B?S2oreFZlaThmRzdMaHVlVndaREFQUkhvUFdIdDhrd21DaFR0YldMalcvYWdm?=
 =?utf-8?B?SEpCQzQxZzRwZ3ZTVlJoc0RYSlJzUlhBNGRrc0pKQUhVRWoxWThrdzYxZXdH?=
 =?utf-8?B?WVJQOVhDY21oYWw1ZGdVb2pFalJSTjhqbGpCME04Z01NN2F3aVd3VmhxVWNZ?=
 =?utf-8?B?LzkzT2ZRa3JTVFJobTdQMG9zVzZHM2wrSE5ra045RVhzaHlNaVZrRG9QWmdO?=
 =?utf-8?B?YWM3ejMyQVRSL000bHY1bWxnTFQ2aStyclJYNVIwMGhqcnVNWTJPWWNYVDZa?=
 =?utf-8?B?K2p4ZFpHR2lFNzVORG9TRzhYQkpncUZlR1dTRXRNVEhVemZubXFJSUUyYzlE?=
 =?utf-8?B?Qmw1NHpMUTU5ZU5vc1ZnZTRWQUFaRzJzSlRZNk13cFdNUTQ4NnM4SFdmY2ta?=
 =?utf-8?B?WmJJR0N3Z0NFdjlaVUZOV2RZN2xpenlpeDc1cUJlZlUzdGdMUDA2SmZ4ZkZs?=
 =?utf-8?B?SWEvZVRJbFFnY3VUK1dISy9JTFk0QmtabEk5RlpwNzBkVmdUUmJIYm1tQ3Yr?=
 =?utf-8?B?SmVLVmdENEJZaHlIYWxqcGZDditQVGtEb3I1RFM1Zm1MdWp0V0JsbGM0NWRq?=
 =?utf-8?B?a09SQ1NVbzFCa1RSeWM0TjVMRUtFYXduNW5EeE8zeElySFNwSVlJYmpaMVZt?=
 =?utf-8?B?dEFTby9NVGc2WXZ1TlJ1Smd5OWhNMm54U1pKb2dXZWNNclY3MWZPcEhuWU5t?=
 =?utf-8?B?aW5ZTEp5QzVwWW5EMTF5OHdCZ2FxaTlhbzZOSlVuVE12dk42dGtSUUhCYXE0?=
 =?utf-8?B?a3B2cW5tNFZuRzQ5V21Tb21TbGUzZHJlbFF5YmZUUHVtSExrU204Wlg4TG1u?=
 =?utf-8?B?bklTSmwvN01zZmhNNkVIY2FBQktYVWhIZ0NtRTZKRHRRNjB5L0M1aGlTRnQv?=
 =?utf-8?B?STRlMjllZDlOZVRrL1Z4UWVYMUZJSEVTYktteGdpQ1I1U1hDVS91WUx2VVNq?=
 =?utf-8?B?alJUVXpya2twbzdjTE5HR2Q4YjlCNTVrc3JId0FDS1ZLVDZWUzlFcWdoc0tD?=
 =?utf-8?B?VXpVWktFL2Y1N0IwT3dOSXM0bHRtcDFweUxYL05ZRFc2T3I3RUpSMnhyMFdq?=
 =?utf-8?B?d29ONDVCODVlb0MyKzJhTTFHRTFPcHNCdXpiRzhvdmZTTFBqZTE2MDFlOGFy?=
 =?utf-8?B?YUJnZ2RjWmNtOHU3ZnArZlB6bFJMWHRwbi9TSVRVWjFzWGZhbWJqSGdaZW1i?=
 =?utf-8?B?Nkc1dDVDTExUd0V4QzJKRjkyc3JuRTl1T25SKzNiczN0dGZMSVZ0N2IxdkFO?=
 =?utf-8?B?bWJCYUdWQ2dIaDNTRWpGMkpmZFhNdmdSNm5nK0ZTYzRjMVNXcXhSNUZ6Vzhu?=
 =?utf-8?Q?N15PYCM81JheMSsTvbB+qabkN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69596e5e-cdcd-4f67-1a3d-08dd9dbc02a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:48:18.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC224h/Jg/9NBYy3FA78cBM1q2XsF/fKna5YuhcHqF2LtMH1YlDypWwh9/6AbB0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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



On 5/22/2025 4:10 PM, Samuel Zhang wrote:
> For SRIOV VM env with XGMI enabled systems, XGMI physical node id may
> change when hibernate and resume with different VF.
> 
> Update XGMI info and vram_base_offset on resume for gfx444 SRIOV env.
> Add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..0246a33b90af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2732,6 +2732,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>  		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
>  
> +	adev->virt.is_xgmi_node_migrate_enabled = false;
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->virt.is_xgmi_node_migrate_enabled =
> +			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
> +	}
> +
>  	total = true;
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>  		ip_block = &adev->ip_blocks[i];
> @@ -5040,6 +5046,25 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +
> +	r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +	if (r)
> +		return r;
> +
> +	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +
> +	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +	adev->vm_manager.vram_base_offset +=
> +		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5061,6 +5086,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  			return r;
>  	}
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		r = amdgpu_virt_resume(adev);
> +		if (r)
> +			goto exit;
> +	}
> +
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index df03dba67ab8..2a37d568ed27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -295,6 +295,9 @@ struct amdgpu_virt {
>  	union amd_sriov_ras_caps ras_telemetry_en_caps;
>  	struct amdgpu_virt_ras ras;
>  	struct amd_sriov_ras_telemetry_error_count count_cache;
> +
> +	/* hibernate and resume with different VF feature for xgmi enabled system */
> +	bool is_xgmi_node_migrate_enabled;
>  };
>  
>  struct amdgpu_video_codec_info;
> @@ -376,6 +379,10 @@ static inline bool is_virtual_machine(void)
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>  #define amdgpu_sriov_is_mes_info_enable(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
> +
> +#define amdgpu_virt_xgmi_migrate_enabled(adev) \
> +	((adev)->virt.is_xgmi_node_migrate_enabled && adev->gmc.xgmi.node_segment_size != 0)
> +
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);

