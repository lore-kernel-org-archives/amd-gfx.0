Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D3EC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 21:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDFF10E027;
	Mon, 15 Jul 2024 21:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGWQyMWZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39A010E027
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 21:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYvPZrQldJRo1z3qicGoRElUDpyr5v5c5rshxP+t6CuGp/NlvQZR6tfeeS6vIaeHw2dteY/ATlZVulvFVHIhojCL2QIjNXzCOiQWeeENbiUy8S3tyJ6IsZqsKMYIVzUuSFTBlJx2vJsK6faLnK0Gql/SDNk6wgX3AFTwPVflRak4E3wt2hsM3ZHv8S1RSsQV8SfHCZ/+i03vv1DV8YbGnJaCs8dsM7B+MHD+er9dcreY4Pla1oHa6Cs76zOui+7BtqGKTlvDFtTpfwZx6XEQfAg0J6rBbclYgwdwKj9AuOuoKAbJFkdZfOjrR1rGkvtsJ0slgyq8GqtAdeKTLNj40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iye+J00rfK4FWzujtcPAib8bZVnsm9PnBeBi/Wufv34=;
 b=WjsfBIqDuI3RReItXtQCV8obfHCUFbm2/yQCiADg9Z6fyRDRTObXxpf8G3496XSG4oIXQrk5R/ROsu0gROotHnKbvFy6yyoABm4ntB5FobxdDixq5PL9aX+MnGF2Tn+3AmQ5JFUfoU3VWTBIBEA0OWWyYQysWO0LtS1B9se7Dt/Y7Ew3Taclis7V5s2SmjmndBp4SnHIFZLYCzg8omA6SmmucvmY1dpPkKP49erxr4FT+u7/fGQTDvmUaghVrvAUeXiLDHUANqg2KuTmrabN6n/JSKWQhc5ID6EIqE198wh0MFJvjHBZekNej6VnHzVowHDw0CozsrwVWR0WYFkKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iye+J00rfK4FWzujtcPAib8bZVnsm9PnBeBi/Wufv34=;
 b=KGWQyMWZupx/n4GMiotZKMZaoQF7axVVJYtlYtzv6B+3FgUBCwIYEaP19woTVqOvTBIpqBUgiyhsDC2NjRuUPEbxtf0pCSZWQYHL9oVYGM7yt1sVU5ffP6/hPKnAa+h9Wi9kAGwixSxi3oljnkOAS3tTTYJpTOvWvg53WyBIjOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 21:06:02 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:05:43 +0000
Message-ID: <ba597263-0fca-4fe0-8741-644cebd17888@amd.com>
Date: Mon, 15 Jul 2024 17:05:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add function banner for idle_workqueue
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Rodrigo.Siqueira@amd.com, Alex.Hung@amd.com
Cc: Harry.Wentland@amd.com--dry-run, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240715205715.358444-1-Roman.Li@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240715205715.358444-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdaf19b-9327-41f7-4515-08dca511e371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTgrSWI4QzZ6MVRqRzJZMXF2MkduUHN2eFVsbHFaQ0RwMFdRaGpzVm5oRzVI?=
 =?utf-8?B?dldNSUU3ZUxId1ZZVmczK094SktlK2RPVG1ybFdTU2xxS0YzL3ltUnBvdUJZ?=
 =?utf-8?B?Q1NtQVA5YlZYSWdJQmF5ejFDZzVNY2RrTk1hL01OTnhaQjAwSm9qMjdWR0RE?=
 =?utf-8?B?SDdhMEI1MDNibHdjVzlSek1DTzNVdUthUDE1Z3gvMVFLbUZ1VWNlNFcwR3dJ?=
 =?utf-8?B?dkNlL1JVZmdwZFRzV2pPQUJybTNvRXhUNmRoUlpWc25yWGYySFlHTVdxWGs1?=
 =?utf-8?B?NGNhbUxCZVRkQlZoOVUrZjgzVlpvSlpVOWZnU05qRXhvejA3SUhNeXFrMDRa?=
 =?utf-8?B?NUFoc3ZuK0FIcy9iYng4SVVHTGtkYm5Ca3hleDJSRVphK1BFZitQSm11clFy?=
 =?utf-8?B?QzJGRUlhSi9EK3FtbXE5WFlhckxlNUpMRGxpdzR0RCs1ZzBneWw0L3JoajVN?=
 =?utf-8?B?eGpjNnRNWGVDazNubjJlQnpLWi9GZkluNjIxbzd0YjNpa2Q4SkNPQXA1U1dY?=
 =?utf-8?B?QzUzQVRvOXAyNitzamQrNGxTRytoVGlBc3k2WG80M0NBczROTGIrV0FGRkdl?=
 =?utf-8?B?RlJ1eXE3dEtVMlRFSGVIK1B0RmlYbFdaWlJsWmJpS1duVWM3SFFsbHNsSDNN?=
 =?utf-8?B?SkJ3NE5TazlZcks0c1FuamFlZEpLMFgycXVIdEV5QWluQjRyY0Q3bThLbDdJ?=
 =?utf-8?B?LzQ2YytHREhldHg3V2lSSnMyQ3RMRmw1VzNrUVpmWmFVYjJZQTVQdW5LTjNt?=
 =?utf-8?B?ZEk2UnVtUVk2QVJjWFAyY3BpT1duVVB6TlBjZ1U2VlpmbHhsL204NER3UkIr?=
 =?utf-8?B?ZGxtWlNrU0plU043RWgwZVdGUEV2dUFRVE1WUFZNeDRFeklBWWZBcjNzMEd6?=
 =?utf-8?B?NmRxVW9xcmQ0aCtkdmQwbjU2eTZZVzAzeHFxdnJkVUtNUGNFditGNjU0a0lQ?=
 =?utf-8?B?Y2hnUFozK08vaHlpVzkzSGF1MlBsdjQrWWg1aTRTRy80Ty9ESlFuRy9CN25j?=
 =?utf-8?B?dUFjaVUrR0YxWG9NazlNbnBRMzQwb2NrMGJyNXd2QW5tOFhtQ3UzRllOUm55?=
 =?utf-8?B?akk5SGN2WFYwdkg4UjRRMTNYL1JaMmFvcmFyQThBKzA4Q0NyMVFySXNjeEdK?=
 =?utf-8?B?ZkVnczFrbDBnOFhBS0doMXNhUEZMUEcrZDE1aXhsbVhXcExJZ2lhUlRmVEd3?=
 =?utf-8?B?ZStBYXJ6U0tvSC9pTzQrektmeTRLNXdLVXB0R1R5ZzBud1RFdERib2wxWDNS?=
 =?utf-8?B?emQxVGJ2SGdPa2syRzFlNmZrVDVwdDlZQXJkUHM1cjczbFE1VzM1L3FMVXZk?=
 =?utf-8?B?RDlyYmJ4ek0wVElVb29wVG5Sa09SZENyaDM1TnVKdXRIYmVtNUUrZ2ZZaEVz?=
 =?utf-8?B?TU5aOHJyK2hnOGJOUnlOdnFsTDVJRFZNMWYzdGRHcEpmZUZDK0gydHZXRVQ3?=
 =?utf-8?B?aVpwWU5WTU1YOVdiYnZraXMrMUVhbDF5V1lsSzg5Q3JHcy9ZUmZUd3VUY2h2?=
 =?utf-8?B?OUtsNTIra2hMeGEwOEdyZkNvOHRLMjMzWTZUa1pSK0JHZ3VUbWNSWkN1WXlo?=
 =?utf-8?B?N0ZGYmhDd0grdTZUa1c4dzRXeURJK0tPTktkdHhRbjB3MWErZ2h6NGNWR245?=
 =?utf-8?B?WmFZMXZLZjUzTldLbWhGeG01RGdkWG1heHltMWdxc3JJMlB5RndSLzdJZ3lB?=
 =?utf-8?B?Z3IyTEFUTkdmSVJyVWZ4OTB2cmpXZ04zVzhsSlVsMFVuVWhYZDZoVHUxcW9H?=
 =?utf-8?Q?Ppq8Pf8BXQfISGvBJE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFXaG5DYlpzRk5aN3hLdC8vMk83anZycWhNSFZSQ29DNTVsbWtMQ2trcTVu?=
 =?utf-8?B?ZTNjNTdlRnk0RWZrM2VjbUtKdWI3RUQ1eDlIKzlBRmhZcUtQWDZKdkh5UjEx?=
 =?utf-8?B?Y2pYSTE2NEg2NElmWUxCT0tDbDU1V2JFa3BzWmhYaElzZnY4L1ZxWTNyMmpD?=
 =?utf-8?B?bVducFc2QjFjR1FOckJETnkxeStLREZ0cGhJVnN2eXo3dmJJY3VEMHVWR3Jo?=
 =?utf-8?B?VmhFL1lxcTE4N3RKTzZSQVpsOU9XK0V5aHFxVzVNRkwyV3kxeUhicGNFNlJm?=
 =?utf-8?B?SE1qWUtRT0N6ZHVGeDBwNmlqSVIwY1RPeXZYdktTdE1WSU5JQmE1Wi8yb29z?=
 =?utf-8?B?NnZFMnJER0pHcE8zTGtPTEQ3dVAwVGNibkFGeFRmemJBc1ZSbEN0K2xUSCtu?=
 =?utf-8?B?STlwaWpuVWNzeCtQczVYSGJDUTNYV016M1pxdVB4SlQzeHBQUWpiY3pjNktj?=
 =?utf-8?B?MnZTU0pLWEx1L0ZpdjV2eURxWEovS1licW8xNnhzNGJzWWFVcEtZUy9LNSsy?=
 =?utf-8?B?RTdpcWVhNE53ZGJWQ0VtczBkT2x5QWlZWDVyZEo2UHBXcS9iREh3UUZhQ2tx?=
 =?utf-8?B?ZGpLcFMzaThRM3VvaTNHOWhWcDViNUpWNXVkTU9qblMxb29zWmVwaE5lVUp6?=
 =?utf-8?B?WTlJQ1ljRUVuc05ZWlE5NGNYOTY4TWtINy9nMmN0Nmg3RDBrRWdTYUcyZzBw?=
 =?utf-8?B?VE91elV1SDRUOTRDUUIyVzQyS0U3Qll3eDU0SHVOc1RweXZmZkdDRGY5WHQ3?=
 =?utf-8?B?cXdVZHk0R3FZbnAyWDd5Z204aWpsWnl0TGhzd1NPelNFYm9IWWdkcUMxODBq?=
 =?utf-8?B?SVIrVEFIYmNrSU4vSy9mODZscUg4ME9VQ0dqclk2Y2JNUmVQajg3RVR3RXFP?=
 =?utf-8?B?UkUwdGJLOVZhQUhwYUZyazFJUFFNMG9ySlp2elUxWG5DOTBCRVV5bWFWcmYz?=
 =?utf-8?B?Zk9lVFhIeFFPVjZlWEJweVg5T3JoSDQzbHIvSUw0bStvR0twTDFkaDVvclFh?=
 =?utf-8?B?VFY5Q1F1Vk1manFsTzBxRlBWY2tsSXoyeGRrdTgvN0hMb0pwbzZmTE5HVTc5?=
 =?utf-8?B?NXJYNkNydGZSRU0vWFRFM3l2bHR5M0ZpOE1nWnRMbW53Y2dRZndRL1Q3b0Ey?=
 =?utf-8?B?YWdGOUExUHlON2hyOHVPMXR3UzE2QVlsNW4vZG9RZWVGOGZ6WFhIMkFMNlpL?=
 =?utf-8?B?L2VkZ0FJNlZ3T3NzMlpoVk92VmdhbHpWQ3djTTRvT0lRL1ZKOVdCcjlQbGR5?=
 =?utf-8?B?eHA4dE1Yck9PdEZCeSs0YkNobk4wS0poaEFkWmtwQzdnamdMenRENkpoWGd1?=
 =?utf-8?B?Mk8wU1A3alVDa0pFalREMDBGS0VJMFNjRVIvS29pSVNnNjQyQUVmTmZLenpk?=
 =?utf-8?B?aHdSNU9nSmZLSlMxOWQ1SC96T1B2WCswUWtKOWgybk9IejVHRzFpSzlNL3FT?=
 =?utf-8?B?eHJTVXNTOElYbnNzWGJOSm1ZbTZnbzZzRkhXdTdqZDNSVG5uTXpYUUYrcndH?=
 =?utf-8?B?SEJJZDNKWTk5dHpSRFNrV1Y3N2RPTDZuSGROVFNaZ1JvQ1EvV0IvNGREMVFX?=
 =?utf-8?B?cEYvT0RvaGl4dWVhLzFrdGwweVg4WUlhYit3bHdLZ0J3TDhBRWlNb0R2ZzFG?=
 =?utf-8?B?REo4ek5paEIvUFEra1cvVG9KamhUMnFIMzc1WHhRWks2VjcxL0lpcm9xMjZh?=
 =?utf-8?B?ekNQNlhKQmZlajZ5VFJaTWlqTTdvOGtYa2RwRGhuZUZrdDNNaklWeTlmZ2ZV?=
 =?utf-8?B?TmxiQ05UVVJESDhnZnphNVVKZlJ2bTBoNTJFckx3ajZmdkhhWlRoR0hUNng0?=
 =?utf-8?B?Vk96RzF5d1hJNExhRXMyZUdpcUVBRUFZa0xxQ2p5bU9lb3VkUEJlc1MzQ1Ar?=
 =?utf-8?B?dDBSWUFacEZRNDN6QnVUbmdoUjhna25HWngrUmp4V1A1Yk54SXpzZElFZkd4?=
 =?utf-8?B?eFlYZktjUFIyTFEzUEdtcFNtdllTcWtRR1h0NTZ5akxsdjEwZjc5UlBUNjYz?=
 =?utf-8?B?VGk2alFHSjRvemFhZGlnbHBIRTFqUWxPYmloRFVHdDBSZ2I0QmtzVjBmRWxj?=
 =?utf-8?B?TFArYlQ1VW1tdU5rSnVITjRRUVluYXVRSWxMUmYzaGtWV21FM3dDQkdhUkRx?=
 =?utf-8?Q?vBymjXKQhuFYz+kgBbKiu+VIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdaf19b-9327-41f7-4515-08dca511e371
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:05:42.9891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5D2Vfk2HlJFqfzwZBfLncz1J5kcO67xzVrbgEvxsr0o0yXvXd96IseFCS/VmvBDixUz96zWO0riJ31txKhSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 7/15/24 4:57 PM, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> htmldocs warning:
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h: warning:
> Function parameter or struct member 'idle_workqueue' not described in
> 'amdgpu_display_manager'.
> 
> [How]
> Add comment section for idle_workqueue with param description.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/dri-devel/20240715090211.736a9b4d@canb.auug.org.au/
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 369159c29bbe..2d7755e2b6c3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -137,6 +137,13 @@ struct vblank_control_work {
>   	bool enable;
>   };
>   
> +/**
> + * struct idle_workqueue - Work data for periodic action in idle
> + * @work: Kernel work data for the work event
> + * @dm: amdgpu display manager device
> + * @enable: true if idle worker is enabled
> + * @running: true if idle worker is running
> + */
>   struct idle_workqueue {
>   	struct work_struct work;
>   	struct amdgpu_display_manager *dm;
> @@ -502,6 +509,12 @@ struct amdgpu_display_manager {
>   	 * Deferred work for vblank control events.
>   	 */
>   	struct workqueue_struct *vblank_control_workqueue;
> +
> +	/**
> +	 * @idle_workqueue:
> +	 *
> +	 * Periodic work for idle events.
> +	 */
>   	struct idle_workqueue *idle_workqueue;
>   
>   	struct drm_atomic_state *cached_state;

-- 
--

Thanks & Regards,
Aurabindo Pillai
