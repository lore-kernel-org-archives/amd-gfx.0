Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5F1D4336A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 09:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E2189149;
	Fri, 12 Dec 2025 09:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axxAw3Hz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF6410E5BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 09:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/Uts8KQGQyz9VZkUt+7/LGp10q5VurumaPR5UgV/i0pQ8OHA9EqWcWZj6nsQrBSmC/JHDlGiqOeehiXnU9LFFnnusSyP7BMpQv4sivTsiG5Qba9y296XlLDwEhtwhaEJXnTa+4qstT0kcWFpd36+kgd6cW+KSqBRRzR6CiVB+t+pdyzvYT8yFDocykNHSeeC4nVTtboMYDZz1Lguh6LfqChOTr0QJFoyVfToAmDeGyrrztKjsaFWj+pZAReW0PRsXO1a6mKk0IG/MfxnFC42gRWy7wQcbfNetfXnh6XXVbzxoREmwrIcx1gLgvuuwEij32eYjEidmZAF4NIa9uKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6nH1tDza1XIXf6RmLWVWiJ1Vt05lejhVJKaGYXUNtY=;
 b=rGKp/wCFUxjheTeofS5GMutDpklqiAOYJYLDSc4rgKDi0AllgecbsYmqEt4ZYozFiuKi+shXN21Bq0NqkyiwKPe4LHDqTiWQ8tjZ8/0X0vFYJwoO6eLgHNZcwe8SGFCwYAOVe4l4X7SwfunXTx9j0Fiy7tbDk0xOL2nx1xMoFF5x8ipc0MNs2eUiaUDaaWibOs2aYYvPCdeWA4ydhny5SwHfyfMTks3GLAny8Bi+XYl4S0Yql8lVXNcwCz9jV/EUN+2La/nMvZEwiwpg+n3DYtS9dclDEi+yE0g7dLzdVGbP8ZTTmyfGBI9vMzY4BFbtr2YbO6EXffGC09I9i9yyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6nH1tDza1XIXf6RmLWVWiJ1Vt05lejhVJKaGYXUNtY=;
 b=axxAw3HzFLq1xOlZ68ZGZee34p5XsaDzZzcPHuuWnoeawBoCDvNBHOGf4B9KsyUl+hoJVQNgmj+Qql4kTIRjUInfG8vdzJxG45EO4jrbRWMsFd8mRzp6atIqu0VcYLyuQobbphPrfZAakMPfRhWQvZeTU+W4BTm3pcTgxEB/4xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Fri, 12 Dec
 2025 09:04:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 09:04:30 +0000
Message-ID: <2a213294-bf56-4ead-9e1f-cc8c3d4003a0@amd.com>
Date: Fri, 12 Dec 2025 10:04:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/8] amdgpu: Align ctl_stack_size and wg_data_size
 to GPU page size instead of CPU page size
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <f7f8f41d58ab2967cd8d077b4937aaa04d58a066.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f7f8f41d58ab2967cd8d077b4937aaa04d58a066.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:408:ee::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d149d8-cf3a-468e-b4ef-08de395d75af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjBUT25LaUtiQnM0SktJaFlBOGhIaXZjVllzLytpUFk1QllhdnNrTEl5RWd5?=
 =?utf-8?B?WUwxSzhyU21BclQ4ZjVoR3d0ZGYyVC81MVBQdGF2TlVaUTV0VEx2cXprSGlm?=
 =?utf-8?B?ai9FNzI0YnVFeW9lUWVTR1lrOTBFc2k2cmwyWG5teTh0ZkJxU2JwUW1ESHBr?=
 =?utf-8?B?Qk9Nb2pzSlNTS2hId2hFd2pFN0dTajNlOGYxblJCYTVBN0k1ejN1NFlDcGVT?=
 =?utf-8?B?L3BuMjNVQkFCK1JZb3RwZVAyYUlaU3RkUEFIRm4rd1Y2OG1kSEt6SDQvZlNT?=
 =?utf-8?B?NGFHMld3NDhNUnJXcG9WM2dFeXZENUZJMGdTeTJtT04zdXhOYnZrcDlqbXJn?=
 =?utf-8?B?SS8vVkZ3a1dEV3J6VlZEQWdJNjVoYmpWTXphR3R0dXkyTmhaUVpnTFU3dGQ3?=
 =?utf-8?B?U2FJMlBmRXdmVnJkK0lSeS9NMU1TbDdGaG5xcHI0OHdHTXQ1SUt4M3RhVEdr?=
 =?utf-8?B?RzZxV0t6L0dCamh2bzBiNVpBbGI0UDB1dS9BODZzV0xSUU9uWWVkVFR2TWR2?=
 =?utf-8?B?YlZ3ZE5CRHJNM2pYSnZxY1NJZHpmeGxxSFRyZzBrZ1RwOURrOHBUQXpxZnlz?=
 =?utf-8?B?aURjKzAvMmY3ZWk1TlJmcU5LamQ1RVVMMWMzTlBhTjJEUUVMWTJJeTJWeVlk?=
 =?utf-8?B?NFFjcDNaRXp1TzRib2Z4bkdYMjVmck9CZTNJVjN4LzRvTXVlekU4OFI0Uzdy?=
 =?utf-8?B?QmYvU1EzcHpFVmRQcTFya0NSeXlodU1pcXdLWlFxbThOaU0vUGVsYytxRW9B?=
 =?utf-8?B?SFN6WEtnZVA0aTNBK2RBSUxoZ2p3YjVIMVF6eU1uNzRhRDFDeDdYZFI4NGRB?=
 =?utf-8?B?b1VFdkRZc1Uwc29sQ0x4K3pWSTZOYUluY0ZvMzhlRXIvL0dGbjlKeTdkNytH?=
 =?utf-8?B?OTZETXJiUENTMDYyUGczL0ZoZ3VyYm5MeUFHNXRhS3ovalpWSnJ0enJiUytO?=
 =?utf-8?B?SWhodWlNTVpqS1hDRnpMRFc0RjNqWjN0Nm1LK1o4Q3ArS2gzeXVXVjZONlpt?=
 =?utf-8?B?M3RNVHJNYUpHRmE2Ui82NVE2NHJmNlI3cEhYSEhlQVFIcUs4aXFaNWQwTTlB?=
 =?utf-8?B?V3dOSlFuTVo2MnRhUVcrb1Q5MnpjS1hzaDVJTC9QcVRzT3Q0M1FVMm1mTk5X?=
 =?utf-8?B?QUJNWXhUemVYZEVaVW9XaUhtNS90V1dqNkhsZmdnYndUYysySURHVndpcUNP?=
 =?utf-8?B?bHk0RzAyRUNEMW5RaVZYNlpTY1VZRDU4bHRSNTh1eGVmNFZKb3NSZERVK3Vi?=
 =?utf-8?B?M0h3Q3lLZXVaS0c0bkR2MXJCT3F0RitnZDZNTytkZ3l5TnlPNXR3aXF1VkNt?=
 =?utf-8?B?cll2emlHSGFodmN3SGMrLyttMmxMeVpPd28vdGFzN2xTcXRmMjBmUEtKZnBm?=
 =?utf-8?B?SDRZS1NjVlhieVE0cXZWUUZVeEhyb3kzdTlmdE9reStzb29LTkR4ZjRONlpv?=
 =?utf-8?B?ejJJVElHMnpsUUJ6eWFIc0pXemZtNGNhZVE0WXpiaUhJVFc3c1pnTTBMMVpS?=
 =?utf-8?B?RGZZaEFRQm15ODNuQVZYMGpwRTJJSlJFUitncHZHV2k1YTUvZ04yaHRDM3Ay?=
 =?utf-8?B?RnRPbS9mZDltREZ6TmlpRW80UDY2ZGF1RXk2alU2cjVKMVlCWnd2SWo0NGI2?=
 =?utf-8?B?QVU0UEhzSy9yRytMMjhOSGFYLzhvd0dkQkQ4YXBibnlybUFPL2dTOUFMVEZp?=
 =?utf-8?B?R2doUDl1R0psQnFKczdzaStZZkZmZXkwMnZXTUlDN1o0dk5yTVhGa1I4MElU?=
 =?utf-8?B?NXVCYThnS0VManNiOVdxNzZGN3ArUWVqdXVBZ3JNK3h6ckt0K00rNGt2RE9y?=
 =?utf-8?B?SElVSEdnMmxQS2ZOcVdqN0sxM3grS3RQV1RhOGRxUnRSLzU1VTRudDU0bmRP?=
 =?utf-8?B?aSsrWVFpbjdFTW5qR3V6TUNud1V5UDFzODN3NUEvNzd4WjM4T0hCZmU2cmlh?=
 =?utf-8?Q?ngjg92oiPT+ERxkRFcXvhYyog8NRJ7kV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tHS0IvdXFrNWVzdW9HYld3akx3RXpIaDB4Wkxub0lUZThDRGdjUUNrMjM5?=
 =?utf-8?B?QlhnZWJ4ZVBwSUhHODZhaHRuNzZJK0Z1NEdxSFpkTlkxaUJhaXNtc3NITkkw?=
 =?utf-8?B?eVdYOEN5aFFPbHhYT0hmV041alMybGZpeFZ1NGl1cE9GelhEdXYxNy9yRHVD?=
 =?utf-8?B?TjA0NEU0SFBzcTg4MmhlM2NyMFo1SENwZzJSazhBNzI3YU1HNWJ0VXV1YTNm?=
 =?utf-8?B?SFNibXI3NVRUT2lVTmJLeVU0T1lJWEJmcC9PSG5jQW0reFhyYjRCdDB3SG4w?=
 =?utf-8?B?TWY3clI2a0pueSs3NTRqS1lkNE02eklHcEsyRTFDbDFpSUJJZWhSMVF4NFRS?=
 =?utf-8?B?N0o4WVBNSU9RcHBEaUo2OWlwK1Z5c2tPc3R2ZEhMU2NHV0hyZXFCV3pvajdm?=
 =?utf-8?B?NlpNQ3oxUE5UZ1B3b3dWNGF0QzdXb1NrK1p3VTNxaXFad2tXczJNRmJQYVlq?=
 =?utf-8?B?RHNYc1lyR01jdkdUTnZFSlFqcGxXRll4cHY3ZU82T00zY09xQmV1RmJhamlh?=
 =?utf-8?B?Qy90TE5VdTUxWUhWK3FoTDRZemxTSjMxNk1EQ1h2MDI5SGovNXM0WjFVbG9U?=
 =?utf-8?B?U1J3RmlKNEtJTFlYZytCd2o0TlprMmV6dXQwWGZZbnYzRWVYS3pzUk1kK3lB?=
 =?utf-8?B?UHBwTW5QVGJoRi9sZkprYTVqZ0IzRkgwMEdLaHJIUEhDL1FQR0YrSE50NEJ4?=
 =?utf-8?B?ZG1pZklRbEx1RXBmZWpNVkRtczNOdFdqdTBPRU8rdCtjOHVudktTSWI5b3pi?=
 =?utf-8?B?UkVTU3RudFUranE5a2krWEk4ZENuc3dSZmZ1UHVsOHplNzAyd1FSYlJ2RWJZ?=
 =?utf-8?B?RmFHS1FNNDltN0h4TEM3bndWMi9ZbStBbGNDWWVtZE1YNkswREVpOXN4TEJG?=
 =?utf-8?B?NkdMWk1TTUlxYk1iTW93V3cydkFRcHhEK2Y3anlhR3hXUFVSWHdvdHZhdUVk?=
 =?utf-8?B?aW9iRUljL25yNjFCUXBnalBIOFJkN3ZhVjNYTStaK2puOFVOTjdtWldsQzhy?=
 =?utf-8?B?RmdPUjNVcnN0TGxoNlJjVEZvU3JjR09YM3NYcURGVUc3ZW5TL3R6MVlkQlZE?=
 =?utf-8?B?S01YVHliZXBwV05sMkJPTGgwMTlVSnBQOTJWMWRvcGRzNm1CRUdJM3h4TUlX?=
 =?utf-8?B?YUlDUWZqQzZZN3U1OTRqNjhBOUJqdE8xVjAzOUNBVE5WMVVUMDhsMWNMT3Bl?=
 =?utf-8?B?L21YOEhtcGRBbEVmdURjTC9nYU8yMDhzdXFLNm52enpkSHlnbWdjSTV0Y3hx?=
 =?utf-8?B?SnlsSVZqem9RL3F4VFovcW0rcXdtcmordmFaTVlJdnVWQUpMclhxWG4zRjI5?=
 =?utf-8?B?bUFrQlpQK3FkVVpmTXdpM0dhUXh4b3F5a1kwbHNXVG9xd2pSRFpsMmRucnc0?=
 =?utf-8?B?R00wZzdrajJzSUlacUR2MmxUQzh5TFhJWnkxOWlXWkxMNzJSdW5DYnRJUVFL?=
 =?utf-8?B?L3VlVEtSS09HYUZ5VzNGQVZpamtsNVR6YWgwZFBFNFJJdVBZTXN0Z2dqRnBF?=
 =?utf-8?B?S1ZLcHhJNlo4eXhTK1JOVFVXa0hPWndZR3Exam5UVStMb2tINmJ0TTM0clBR?=
 =?utf-8?B?RXd3UEphNE84K2RrN1lWbDdyKzdwTTFnSFlLRExKUXhGRGFIa2JieTYxZmMy?=
 =?utf-8?B?S3ZxQmdTdjFSRUptM05Ic21yRTE3SllsbnVDTzNwSXgrT2EvT2FrL1VNeGJ0?=
 =?utf-8?B?anFzTGpQN3J3bWt6RUo0eGVodGg2SFpYbVJERTN6OVBNQUpUd0Rqby9mdmtp?=
 =?utf-8?B?Q21hYTBsMVdiQW13bytNc3FaeDUwTjh0QmVHMytXclllVzZQZHh5QzdHWGc2?=
 =?utf-8?B?aVZwSnk0dURKQXUyK0VFREllN1FVaTUxQWhwcURqTDJXaTdOR0w2b0NhazVM?=
 =?utf-8?B?SmlKTFhUVzFSb094bndVSDNWZ0xzWU42ZUxPRFJvT25mamEwSzFaUWtlSzRB?=
 =?utf-8?B?ckJhdVBJaTliRHI0cVdNZndPYVV0ajBsZmxNVUF0N0IzZFNTSmR0ejJlTXdm?=
 =?utf-8?B?QUlVMXJ3N2xsNFI0Q3R1ZEhpN2ljamNNUDRkcVo5N1doOEUxNFdFZXg3LzB6?=
 =?utf-8?B?d0lja1pSeE1TRkxVM0kvSDdpQlNFQyt1Y0ttN2ZCeitOWllLWWwzVzVaZm5O?=
 =?utf-8?Q?pXs2udXUPU/QTiJioQm1L1XVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d149d8-cf3a-468e-b4ef-08de395d75af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 09:04:30.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Orx35/YlvDITnMpkf/J8m88ywR2P5VOpqupPKtoD6k0ViVxd7nFvujJ9FoMqwwXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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

On 12/12/25 07:40, Donet Tom wrote:
> The ctl_stack_size and wg_data_size values are used to compute the total
> context save/restore buffer size and the control stack size. These buffers
> are programmed into the GPU and are used to store the queue state during
> context save and restore.
> 
> Currently, both ctl_stack_size and wg_data_size are aligned to the CPU
> PAGE_SIZE. On systems with a non-4K CPU page size, this causes unnecessary
> memory waste because the GPU internally calculates and uses buffer sizes
> aligned to a fixed 4K GPU page size.
> 
> Since the control stack and context save/restore buffers are consumed by
> the GPU, their sizes should be aligned to the GPU page size (4K), not the
> CPU page size. This patch updates the alignment of ctl_stack_size and
> wg_data_size to prevent over-allocation on systems with larger CPU page
> sizes.

As far as I know the problem is that the debugger needs to consume that stuff on the CPU side as well.

I need to double check that, but I think the alignment is correct as it is.

Regards,
Christian.

> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index dc857450fa16..00ab941c3e86 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -445,10 +445,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>  		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
>  		    : cu_num * 32;
>  
> -	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
> +	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
> +				AMDGPU_GPU_PAGE_SIZE);
>  	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
>  	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
> -			       PAGE_SIZE);
> +			       AMDGPU_GPU_PAGE_SIZE);
>  
>  	if ((gfxv / 10000 * 10000) == 100000) {
>  		/* HW design limits control stack size to 0x7000.
> @@ -460,7 +461,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
>  
>  	props->ctl_stack_size = ctl_stack_size;
>  	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
> -	props->cwsr_size = ctl_stack_size + wg_data_size;
> +	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
>  
>  	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
>  		props->eop_buffer_size = 0x8000;

