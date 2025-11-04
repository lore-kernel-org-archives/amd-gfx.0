Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55284CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27EA10E5D8;
	Tue,  4 Nov 2025 13:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHhCjPz0";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DD410E5D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgJIxwNcoXUVQvAe494+Ko7xTWM4Zn+G6sUaXr031urzHLsV+eZJc34Yh39pSAwphK8j/kovmsHcStck49MRfibZX8Zf8LSOYxHLkIivOe7W5eoF4QfNRkEp/lIBmZJgCtINuipdfdPf9WmzAyzOq8iAPT8Yogs7wN3yR3MsSsYEQ23mTAOdj2MUUaaj2vxnLrLsd1gnkbQL9ijPBg3M04HoU5JWPgauyewr/2pXCrLxioqI4LulaoR3ub01q0mC7sn4JwZH+uSvDlFPzSyy2WSo0doUxKRDD29Pv0c9W9edU0lxLzmE+COAYzIMJ6Abz3ChZj67KbzqICspb0Vv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkw3f6DLuHx6lnFAzT9xBqeJ7joHbYz7z8Xnq1RtYqg=;
 b=AsTfddiwLlC6/YK7bdNGFdww7lsUGnvrKhrkk/krVjqWTbFso+OBiObNTG9E3OWvhB2TRhUo8xhQa+foNc134FJ/75geSCRmZ1hh96i72AgVZzyEFbv9DC/VnL+UlGXK4fijP8rp3G2vzfBsYmxKrel+2EwpUtO7bwEa2DYDVUp5kniuKL8aukeoGWlTDl9UmXDwo8jpULP/lLejRS90k/TYUhGDhG+8Vy9iUErezg3GlFh9+pRXAuHyZ94nfOBlJ5vpB6MdFch1dBOlwbPgNah+o1q9itvnFVSKJ8PNFMIRUboa3iwdz1yVzWRh1GXJmP0MWEYB10xUNmrCg5MXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkw3f6DLuHx6lnFAzT9xBqeJ7joHbYz7z8Xnq1RtYqg=;
 b=gHhCjPz0BktXnsfpXpVVYzrWLm0oloL+qwAVhKwP61teWIGgm5fnnd23EnPVZsTf4SKnV0h2id+aS/6zPAVzhJkhnGmjSAMLIIVnie25HQdAPiQpD5ntAhjRY7UzFnGDJc3xdMSVWo767h6mzpVJZjaT7ZWJ7P9dN91t0UvHPdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:50:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:50:37 +0000
Message-ID: <956bb719-8982-47f0-b8d1-f782ba67be3f@amd.com>
Date: Tue, 4 Nov 2025 14:50:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
References: <20251031174308.5234-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251031174308.5234-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 60036cf3-8710-4e58-a156-08de1ba92233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RExhbVJSWHlyMXdnSWlJRGUrcStpQUkvZEFQWHh2VWF3bEowcWUzSlFFMCt6?=
 =?utf-8?B?Q25kamdvK0pJRk9TREFPaWJBU1BaUjhOM3FXdXMrK3lteUR4U0oxVExBcjdZ?=
 =?utf-8?B?alNxNGtvWmdEejZwWkRJaGwzb3RDYU1sVG11T1hrMlFObE1OLy9kaEtCaTNG?=
 =?utf-8?B?SjVsYitEaklWeVRHYUVPUU5BcHlwcjc0dGtpcE5YdVhuTWRSY0ptcENya2cv?=
 =?utf-8?B?NzkrNjhhMjBmL1owazlhQlc2Z3ZuckhSOWdFenpFUDJsbFlCM2kwdVd0dUNw?=
 =?utf-8?B?SVBXczJiUHc5SnpERGE0SnZQd0dldzJwb2hTRENDRlJGUGNEWFAvaDZHdHg1?=
 =?utf-8?B?YkEzQTBZMnNEOHAzT09YOHJTY1YybXpjTlQ4TkdOcDljbm1mRUhrcWN3QVNO?=
 =?utf-8?B?R1BvNkFXdTAvc3ZyTnU2REVFTXc2ZElDYmNWNkswVHliaGhZbGJQYjd0Z3hO?=
 =?utf-8?B?b2hoOXdIQlVsRUE1VEsrcksvcjdHZjd3aWRjcmRCTUFQbVExMzljRXVYRS9D?=
 =?utf-8?B?RWxvZzF0U3dhMmVLTzF2dXBzVnZtZUVVUXBRS2h0bHEwUzViWk5ZbjZoTkRw?=
 =?utf-8?B?eHpjb2pUWkZZRnJKZndzRXZIWkR2NnFpZzFMMFpuTDZmcUkydDlENkFtVzJj?=
 =?utf-8?B?SzlNSWYrcnBpeVJ5RCtrcmNQWDhOblZUMDlvaFJoZ0hxZ3FxS1NvRFZ5a0lI?=
 =?utf-8?B?QlFpbmg5QVBPMngrWHp3amdTb3hheEc3dE54M2h2UWVqcU41djFMM1J4UW1u?=
 =?utf-8?B?SFZzUWFnRE9kZHFHVjNtVVJIZTN1dDBScUFYRGZrR1BUMW5KWWxQd1JHYlhL?=
 =?utf-8?B?NDlTUUxwNndQanZkU092a3RtNkVsemx2bGdYMUdranJCNnJaQllmZklqOERa?=
 =?utf-8?B?b2tWQ3FGTzR0VjROYm5qcHZjcnJ4cm1oK0g4TnV1dW90TkROMEYwVHlDSERZ?=
 =?utf-8?B?NlJyTjJpQzZ3NjBJRlV1eHpNQ29MSXA3TDhtT2JYT1dWSXBPYlpFTHlJY0xq?=
 =?utf-8?B?bFVsb0VtQzgzL1dZQ29yZGt3RHBWUWZFcnRRMmNabTh1S01ZLzhvNkR6ZHhn?=
 =?utf-8?B?S1N2b0xFMVBNQk5XeDhLalpVM21GS2E4Q3F3TjY1TE02WWVWank5ankwVDM5?=
 =?utf-8?B?bEJxZGpmRzNER3c0SkhNREZabk8ralpkbFZDS3NGQ3FYTjNhbitJV0ZIbzVa?=
 =?utf-8?B?cE1lUG5PN0k2WERpK3RxM2hBbmdJbjRJdndha2J1aGQzcnNiQXhKK1hWS0Y2?=
 =?utf-8?B?Q2svYm1hbERrVXVMOThtN1YzSlpORzMvSjQyQ0lFME1JVWtpMWxmc0tLK3lk?=
 =?utf-8?B?SXdWNmFlSWJqZytLckdxU0dBVWRHc0k2cmVSSE51NTNrUmY3dmhZcmQvd0dZ?=
 =?utf-8?B?K1dMTXgrMXpjcHpLRFNZdVduUzJEYTkyUUxmR08vcnVxczNlMzA4MVJMUzls?=
 =?utf-8?B?SXBtWjJRcWRqVzRNTDlveHdlRkhEWU0yUGFUMGpkWVB0QUVRNDNYV1ZNOGo5?=
 =?utf-8?B?K1VmV3lHdUdlOS9hbUxzNXJuYStPUkZuQVdDQkZDdmhpdVdBM1lORjVpdDd6?=
 =?utf-8?B?aElBeEU3em53R0NHcDJFVEdJR1pOWUxTMGh0eTlQR3E4clVScDNFbWVNbW4r?=
 =?utf-8?B?VVlZS05kZ3h5UklZa29CM0w2L2xGRXJaeS9iRks0cmRTekw3cEV6L3drSmtR?=
 =?utf-8?B?VytIQzhwVGx6M3Zid2RkZjlxZFZBVmZvY2UxWVZHbXJZVXNRdlQ4ZkhuTGdR?=
 =?utf-8?B?YXhBSXM3MW8vUUxST1hlUjN4Z1M2dERUTWhLK1poaFBFZVZyQ0Z4UnZJbWpS?=
 =?utf-8?B?eEFORHFTUFpUcThsSWYrM0tuZnhJWDl6VlVmai9kSHBIRmJieFBSME56ZVNF?=
 =?utf-8?B?NHk1YjFxWU9JeFI3dzlRaVQvVzgvRnlYTXhDTm9sb2NDOTZtcjEzMDBBYVZo?=
 =?utf-8?Q?0CIVLdQgslZ9VSizphmqglb/MnF2cJ+O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU02UERlbFl1ZHV0STVpQ0p1bVRTVnRnaVEyb01FVVhVSUtjQyt0TmN0NkZ1?=
 =?utf-8?B?M3NsUFdGUHdNck16L01XTk51TXhtNENDRGovVFEwVWFEZUtiQUhjN2FhZ3RU?=
 =?utf-8?B?eEJ3eWlwQ01DT0ZYeFp5MUp6ektoNkF1OFpuSHZMMFhzUVJQMUNMcC9jaVBB?=
 =?utf-8?B?ZFdtQ2lhc05Ha0orNklHK3RNOEFUc3h6RlFYVlo2S2RheVp6a1JJbGQxWE5U?=
 =?utf-8?B?Wndqa0tneTAvSCs4SlRNZG9KbzV1dklsL0RjT3l6eU9abER2U1VrM01EVU1R?=
 =?utf-8?B?Qjc2RGZOTzc5d0dENXJHVnhiYVFRaWFCWVRnbDZKeTBoYTM3WFpmUFNlN1ZP?=
 =?utf-8?B?ME03UU9WSHArallXMG4xU1R1TmhIMHV3c1FTOEtISnNsRCtaQUpVU0pWeHM3?=
 =?utf-8?B?amhrS0JON3cwQXpMM1hUZkcvb1d1NWhHZ1ZHY2g2eEV2MWpMczc4VllzMHF1?=
 =?utf-8?B?OUxSRkgwVWEvdm1tU3RDUEViVko5eTdGQVlpMTN4c3F1RXk1MTlUTVArbStv?=
 =?utf-8?B?S2hmRllsTlVjSWZjN0tMV1VPVUppYkdGZkVtWnMwQWxQdFFxWnozU2RuRG5q?=
 =?utf-8?B?WVFmTHJFWDlsVFhmcmJBczY1TEN5WEJUaXhvdWl1cjRBYmYyWTZRTXdtcUNN?=
 =?utf-8?B?RFp1N0thQld5bEpjMUQ4am02UVByblk3U2NUdlVtZ0lQaFNDZktadERDV1RQ?=
 =?utf-8?B?eE9qM1pGL0lWWENOdVBITDB5ZitrTE8zaTFhbm9PZU5keVB3VU5BYy8xRXc1?=
 =?utf-8?B?RUgvUkdrajVlQjNHWDBoUTAzTzZGcnpMbFBWYWFIYncxL3hOOStWSVpLQmdm?=
 =?utf-8?B?ZE4zVkZnck41di9RcTBGRmZ4NERUbFFySm1TYXhDMjJRM2g1ZmR1Nm1OVmdu?=
 =?utf-8?B?YVhyTTFhckZLUWlRUk9kMlpyenRSZUNRY2Rpb3NmcURPY3RyZ3dvUGZhZTRm?=
 =?utf-8?B?N2liTlRjd1BFdy9TSUs0SXBtam1OenhSOFUvWkpjb0F3bHl0RlJaK2xmTW50?=
 =?utf-8?B?ODhUV3ZkVFRPOFFGU1c1Z0k0R2J6UzZRNWJxZW5Zd3FuZVJQSXFsbG9vNlNx?=
 =?utf-8?B?V3ZVNFZUU3V2ajF1YWNTVm1RT0c5ZGMyZUg4UW1YZ1NIZStEOXNyOWR5RHQ1?=
 =?utf-8?B?bG1kNHpJT3l6ajFHc1pVQ3BZSXVOSm1KVjR2czlIZTNkNTRBRzdFMTNSR21N?=
 =?utf-8?B?MUhzTGtaSWdWMFJKeDVMN0IxYmlVN29kN3dGdVFEQ0gvazlDeDNwK2djTS9J?=
 =?utf-8?B?enB1VkdWUXlxYlFHejdSdEs4djNKbmpXYmlNeHhYMXROUnpzTXAycWtyZTR0?=
 =?utf-8?B?Wk9MQmE0YUtwUnh5T2JkZVk0RVYzaXBzanVrYlYwdkFXVjkvRmxSczBJUnVp?=
 =?utf-8?B?Y3JrNjJrRERpSU1yMkpCOTFtNjBBMkFsOHZCY2U4SWVDMGluRldJMkNtVzhy?=
 =?utf-8?B?K3RVZ1R2a00yenp3T2ZpblZRbk9HQ0JSNkY3UjhHM1g2NjJibWdYMDRCZE0w?=
 =?utf-8?B?T1gxSTVkQ1dORW1nRXlxdkQ4WkswYWppaGNPQk82aFQveS9pYlVONTkxdWJv?=
 =?utf-8?B?NGxyRHpWMzFQMHAvOU5ZT2FscFpIKzZpOVVZTjhlRjRpb0s0bWxJMlZQYVRo?=
 =?utf-8?B?bXpCTkI1ZnBKNmwwY1VDRHp3L3BVK3kwME9Tcm9KMmJ4SzR1TmJFWTJaUGdx?=
 =?utf-8?B?aDZDeGdReEs1Uk53VHJHaXd6SktZdDQ1TDhNWGgrRCtvZTI3cDhRcXJrSUJF?=
 =?utf-8?B?YnlZMHNVUDVIaVJ6YUZDR3dIdGM0T29qaktKUU1QUCsydHc5ZERVQzR4cEgx?=
 =?utf-8?B?MGdxdG1jRE5HTGxlMTFiV2Z4eG9HbWF5WFZVdjZVU3BKOFpMMnBZcWxJdEJ4?=
 =?utf-8?B?VDJIRUNGbUlyWnVDUXMrc1dJK3BVQzBKUzgvTzExaVNEQTh2VDNYd0NwTS9V?=
 =?utf-8?B?TXRaOUtxc2ZpaTMycTZIWVFuT1ZIV0svbFFuSnVoWUhpUnhybTV3dU5CeVhK?=
 =?utf-8?B?cmxIbW82VlpIdG5UYXVtR3I4ZHRMWHVTWEhESS9IeTVqNjF6eHJpaUxJSUFs?=
 =?utf-8?B?MGJ4aEptK3FyLzFQWkNETml3VFFyYTdJcEwyMGR1Q3FVTjFrbEZHdFBDalV4?=
 =?utf-8?Q?VQ/CmBnBFBN7//PhexFBl+7sk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60036cf3-8710-4e58-a156-08de1ba92233
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:50:37.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ1l23XrhYvQn22X1FsphlAOCz1lJf0UAD3r33goyS1KKtfKjb3+RtyCDXbRoiI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
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

On 10/31/25 18:43, Alex Deucher wrote:
> If we don't end up initializing the fences, free them when
> we free the job.  We can't set the hw_fence to NULL after
> emitting it because we need it in the cleanup path for the
> submit direct case.
> 
> v2: take a reference to the fences if we emit them
> v3: handle non-job fence in error paths
> 
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 19 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 39229ece83f83..586a58facca10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -176,18 +176,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	if (!ring->sched.ready) {
>  		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto free_fence;
>  	}
>  
>  	if (vm && !job->vmid) {
>  		dev_err(adev->dev, "VM IB without ID\n");
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto free_fence;
>  	}
>  
>  	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
>  	    (!ring->funcs->secure_submission_supported)) {
>  		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto free_fence;
>  	}
>  
>  	alloc_size = ring->funcs->emit_frame_size + num_ibs *
> @@ -196,7 +199,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	r = amdgpu_ring_alloc(ring, alloc_size);
>  	if (r) {
>  		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> -		return r;
> +		goto free_fence;
>  	}
>  
>  	need_ctx_switch = ring->current_ctx != fence_ctx;
> @@ -302,6 +305,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		return r;
>  	}
>  	*f = &af->base;
> +	/* get a ref for the job */
> +	if (job)
> +		dma_fence_get(*f);
>  
>  	if (ring->funcs->insert_end)
>  		ring->funcs->insert_end(ring);
> @@ -328,6 +334,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	amdgpu_ring_commit(ring);
>  
>  	return 0;
> +
> +free_fence:
> +	if (!job)
> +		kfree(af);
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index fd6aade7ee9e3..efa3281145f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -293,6 +293,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  
>  	amdgpu_sync_free(&job->explicit_sync);
>  
> +	if (job->hw_fence->base.ops)
> +		dma_fence_put(&job->hw_fence->base);
> +	else
> +		kfree(job->hw_fence);
> +	if (job->hw_vm_fence->base.ops)
> +		dma_fence_put(&job->hw_vm_fence->base);
> +	else
> +		kfree(job->hw_vm_fence);
> +
>  	kfree(job);
>  }
>  
> @@ -322,6 +331,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> +	if (job->hw_fence->base.ops)
> +		dma_fence_put(&job->hw_fence->base);
> +	else
> +		kfree(job->hw_fence);
> +	if (job->hw_vm_fence->base.ops)
> +		dma_fence_put(&job->hw_vm_fence->base);
> +	else
> +		kfree(job->hw_vm_fence);
> +
>  	kfree(job);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c3dfb949a9b87..82e897cd5feac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -849,6 +849,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		if (r)
>  			return r;
>  		fence = &job->hw_vm_fence->base;
> +		/* get a ref for the job */
> +		dma_fence_get(fence);
>  	}
>  
>  	if (vm_flush_needed) {

