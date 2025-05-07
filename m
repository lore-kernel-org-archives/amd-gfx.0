Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A57C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C7410E830;
	Wed,  7 May 2025 15:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKPeNILI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA7B10E830
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo3WtXekwTo7fPSWTzHWYi/3mIASHn1RJYckHq6qvPIbkR1VKR+treDZGAoHp4w8sXcKToLBVuLOFdIiZyl4cR5XOfOAUEncbDtMcs+nnFlflpmGbnrktd1KcPmxMOsbBi3/Z0VHgN8zfytWgdXTO44Q92C3Fpr/eh7WGYfH0QvwtqdQVB6cR62zmhvY5wxYLrbJGymVhLQxuYt3Ok9WlSqoJyDodQYXFpVxyVx6mwBY/DKTn3xAUoVpnSZ8XrlCb6NrX1XM80022NLK7NFuBXfD3IdgT0AWg1mm60gG/4mIYs2TNQ1q9yD/ZJI/lohJgg/vm9QUdRo8lrBYMnHDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz3Ctz4kq1iRD0ft/LJ0ak3besoGKBr+9Z3XcuxDvlk=;
 b=XJr7S84RS/dHzpSWyBycqDk8A1/1bmIcRjw9FwlqkIpbcHYotl1I0FPCMZ0ZUiokb9onwDau+vPOK7DIcMh1YBSd6C6kPWc/MOuGMsoW1lQBf/EiTehHH6TRX7Mew7jpRUOIuISJpkQDqKvNHd2Dgw3dENy567EuIsI9hlzey8OkmynxhpLjTJ0E3g+QiV7NWZrV6muPvfkBlvPzWfOUF5m7HQMQGpQQfXqWc39+i7fK6tOGxjACt1k264i170RTSGQWeV1qmhbDJfHge4gApNMWFNe4mRZod/w7uW5JHO4n1eLj0+Be2iv3N4bHbTBL3aa4rvZ80r1pXqtl8h4nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wz3Ctz4kq1iRD0ft/LJ0ak3besoGKBr+9Z3XcuxDvlk=;
 b=GKPeNILIng0WMyEx188LziyHG5lrStLLBHkDKTG9JWZnG4m0ZpIBHv+HzJFnBATLZzzJ41YUyYEb9nbASJzNkGsEIMblfRr1C1Uu5CzGIZfFtNZOcmAtqMY2GNGHfk0q2nkOm/+C4kAZ4a1LoGHDdN3RGjfueLjQ48ZDgIkGR70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 15:20:50 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:20:49 +0000
Message-ID: <39967d2b-0de0-442e-8feb-13a046ac186b@amd.com>
Date: Wed, 7 May 2025 20:50:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd: Add per-ring reset for vcn v5.0.0 use
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com
References: <20250506204948.12048-1-mario.limonciello@amd.com>
 <20250506204948.12048-4-mario.limonciello@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250506204948.12048-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::13) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0f856f-8b7e-46f3-ade7-08dd8d7abf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2taYmlpOU8yb0w4Tm9qOWEzeisySG1KL1d5TnU3Sk4zbjRPRGRTaEdSOU9q?=
 =?utf-8?B?NjNoc2V5VTFsUU5WMzNEaThBd0pMa2pRT1ZSV3BSOE4weUt1YVh4NVBRdWxk?=
 =?utf-8?B?cTJPMkRtOHRDbXU2MlN5NGh2UW5FYXNSRnBnYzQzWm9IbUZZalg1WjRtcmlL?=
 =?utf-8?B?M3l6T3kzK2dkMXYxQUw1Q3ViT3pPdEt2RkVuYU5BNUovQldGaE5QYmIvVlhR?=
 =?utf-8?B?UUlzcUppUnJzb0drNVhqSHpncTRxc3hnOHRzRHZTb3FnUmYrQ3hWZ3JVMjcv?=
 =?utf-8?B?Yk5jdmJ0dGpxamlKOVNMbWR3UkdrR256M3NZa01FUERaZzFMYXExU1dtdnJo?=
 =?utf-8?B?QnFJYVRkbjRLMThsY3N2cXlyRTJZMGNPbDNFeC85L2plQmxqWlpnN2NGZjJw?=
 =?utf-8?B?UWRDRkI2QjRhMnpUK1J5TDNRSVpuV3Rqb3k2ZnVLVGtCaHZFb2NYY0tUODVC?=
 =?utf-8?B?eXZHRUxIZkM2VnZGOFNZL0ttZ3daallLTFBSY2xuUDhTbHNDZnl1ZUdlMjlx?=
 =?utf-8?B?N2tmbnE1N2ZpV2VnOUtlUnF2OGNjQmVGeG5JbWJScXVrb0Z6RmEvL3crTWtI?=
 =?utf-8?B?Mlg4TWd5eXZGaVYxWkF1eW0rQVNxcnRxT3o2bTVFaWJnRVV2Nmh4eHY0Mkpn?=
 =?utf-8?B?L2dBVlpsdmZFR09VYTJJeHdWVnkzbWpTZlBvUGNYUzB2ZWxUK0p5UzJEVS82?=
 =?utf-8?B?bFduRllmU1BuR1RINlRnQ09NN3ZQSk81VE9qaVhRVzJYSmQwY015eVJER3J5?=
 =?utf-8?B?NVdmaURCQmMxZHVic3h3VVZxeTMvL1lhd08zSFd1V1hnNDVWbk5tMVZZWDFF?=
 =?utf-8?B?Yllxb0NzNGh4UWFod0daeTdKMmhsMDVUencwcy9tOEJqNndPNU5za0wrYWJU?=
 =?utf-8?B?MTBNV2NuOVZnQTAyK1NqUFhKQTlQMitsMG82MzBtUkpXL2M3clZjdUxRVTRW?=
 =?utf-8?B?dGxEazhlVFN6cmJQS1RZc25VTTRBQWlSQU9mMklUZ2EzUjhoSkt4WExjMzhZ?=
 =?utf-8?B?ME5IdmxBeEptTjVRNGJmMmxKeG95NzNWNXVyZmxTaUR1K3pQMkxuOUVyUFl6?=
 =?utf-8?B?aEFIQ25rVXZ4c3lZaFkwTzRTRGJMbjdvemRRWkpCaDlCU0MvNWM0Z2ZvMDVk?=
 =?utf-8?B?WU9QdWxPV3FzNGZNdytROEdHQ1RrTkhZSU9wckNEVFBOSzMxRlpUQUVhNmh4?=
 =?utf-8?B?SGVZTnZ4STQwWlNwelNhUjF1Sy9PdEtKeEpFVHFXckZSSis2OUlsU29ZYnFF?=
 =?utf-8?B?SnRxanppcjBuMk9HbnBUazR6ejVlVjRmdkFjTmlPa2dsdVZnaCtPMHc2QTVq?=
 =?utf-8?B?aUVmREduZE9RVVc5RmZpRDNBRlhPRmJiZ2xRTzErbGM5c00wSHVzUS9hU294?=
 =?utf-8?B?YnpsMDRFMHlkb2pGWEoxUGs1M0lmb0ZUcGFXZjRnMjVWbkxKWWlYanZ6UmQ4?=
 =?utf-8?B?em05NUM1QUxWOFMvdUU1SUdndk9PYTYvWkxCYU9CYlVneGU5R3VVQ0psSmxN?=
 =?utf-8?B?a2hoeXFiTFVyd2lCRVRtNS9RV0NHSFk0dHZ5dkZ3NVpLSGZrUnNlZ3pQbVRh?=
 =?utf-8?B?NUp0VHViOForZ0w3TFlnM1NwK2NaekFlaUxzeUJHMU00RmI5d2F1bFY4ZFg4?=
 =?utf-8?B?OFZUVHl1ajFMTnF0MnFLQ0xyUlpmZUVhczFrc08zcFJla1JNZWVwVy9Ta09q?=
 =?utf-8?B?Z2Urdm04TTIvaXpjNm9aN01oUGo4bkxnV2cvblY2U2MzOXo5TE9jK1FDWnV4?=
 =?utf-8?B?dmlmL0NtWElLVndCcnBYUVlSSTNvbWJlV3VHeFg1b1NNeXk1dUp3Q09vNm9N?=
 =?utf-8?B?TDJpZVFpRzBqaUxicFlhbTc3V0Z3YVk3WFFENk11SjRmaUJ0Umh6ZDJBdm5k?=
 =?utf-8?B?bWczR0Myemx4ektmV2FQNG5oV3BLZy9WVnFxYm1yWjcwMGJJRmhiQThvMXgx?=
 =?utf-8?Q?TqCsOeUGMTs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm90TWcyb1A2WlorS05oMGdUdlBVdHFObENCUG1VR3VrV0VEdTBRbHdOa0JC?=
 =?utf-8?B?QkxaeG01N2hRQ1FwVkZnZ1FvRG1NRC9EdUFhNTJTUEE5a1ZWR1E3UytLVm10?=
 =?utf-8?B?RTJEbjVxdFN3VmxHQjFSWCtEMmZBU3Y4dHpZd3pjUFAwYmtIQWpqdndodGox?=
 =?utf-8?B?YnRiU0lUSFNKNk5kWFhqa0xQOGhRbUlTK2hTYnhrYWt6RVFOUkw5Y2RvODVQ?=
 =?utf-8?B?WVdycFFQMVl0V25NcHg0bWxlTWxVU29mc1BvNmlIWUI2R0JQckxBUmt6MzZh?=
 =?utf-8?B?NHFPenBtdWttWWNtcHdDeVFvWkYzM09zaEJoaDBIcHZvVlI5RzIrNDBxM3l0?=
 =?utf-8?B?ZHhkMVNtd1BCNnFFd2FqSldDQldvV3lldmhwUnV4UEpMWG83VXZHSGxqWjA1?=
 =?utf-8?B?TDh0ZWlkU0hzd3E0R0dEeVBzdjRCdlRjZGZLWDJmSlZZbHV4ck0yT2ZLWnI5?=
 =?utf-8?B?MkJzOTR5NWZZek04WWkraHRZK3dJeFVzZ2U3cFRpREZwL0M3Z0J5VmgrS2Ft?=
 =?utf-8?B?ZHl2Tks1dHFSeHFiaXJSbkZoZ3FUZjJHVCtMcTd6cjhJU3hKUk5ockFkaGxq?=
 =?utf-8?B?MDNHK0NxUWRzOGREWSsrTUQ2cUx6eVNCL1EvSFdVQ2lHN2N4RVJFdWY4TUxv?=
 =?utf-8?B?bFNtMzluQXVFQk4vSWliRVNYVjdPNlJoQkFJTWVwdkVQb3BpOTU4MUpwZFZC?=
 =?utf-8?B?amN1ckF2NXBZbG5haXNJRzkzU0NKOHl5RU91WjF6c0gwcmJ2NWdXWkppL215?=
 =?utf-8?B?aWhHZDFEUjB1bE9FTjlCM1YvejR4eVZMdDdvVG8zLzJWV25BdlRpdjhyYXB4?=
 =?utf-8?B?RlBBQ3JWM1BVUWxaYmgyZXJlS3A3MTlPWSt4dUVHUlFRakpyWWtZMUhnMUFh?=
 =?utf-8?B?QjMzbGQwZHdkYVF1ajl1UG55YmZhd0RXNTlZN1VKR0pvNnU2UElNY0RvaDcr?=
 =?utf-8?B?NHo5MVFZb0pBOCtybE5RdVBWZEJnODVuOVUyTmxScm9MQWJRbmdjcWhlbmM4?=
 =?utf-8?B?L3BtVGxGa3Q3Yml3SUpZMXhpcm5xNVE1NmxPNjdWU3duUkpSVldsR2EzYit1?=
 =?utf-8?B?WC9hZjREblErSE9NQnVtSlFEMUxRY1hBNUtxNWQ0T2UxcVNaV3lwdk94aGtt?=
 =?utf-8?B?N01YeEdFdE9kYy9KNWZzbDdNQzVrNXgvNGNTbmdGMEZtMW5lSS9rUXQ3VE80?=
 =?utf-8?B?MjRUbkk1Y0o5ZEFmRWgzaXBTZG9rbFM3S3ZPbHBkMStkTEMvc051RVVndXJm?=
 =?utf-8?B?b1BadXJmL25RQStua3ZtVU45K2I0K095SEc1UXNoZjljeEtzUzdHQ0l5NXl0?=
 =?utf-8?B?c29CZ0pJbXFuUlVGRkExTUVUVUFYL09lNGZKZVg5WHQ2V2JScWJmQ0N1RENp?=
 =?utf-8?B?SlZqR3VCaDlBV3dZbTBTekNyMmtYNDdFbnF3WmgwbzEveWc0TmwvcjhsYWsx?=
 =?utf-8?B?VjV0cmNqSFoxWldpWC9Xcm05b2VyY2dWVzViMm1JUmZYM2VEQTgwNXBnb1RB?=
 =?utf-8?B?Q2ZlRk8zR21qak5xRnd1MVAvc2pNaGRKY1hZSW5UYjV2NENmWU1BcDFCQVBs?=
 =?utf-8?B?Nkh2aUdqMUJzcGRaWGJCUGh5US82U3pZOUNGRE93NllMc3VucG1aQTViZ3Aw?=
 =?utf-8?B?ZUwwVHdCMytOOXkvUGxWV0dDbXRjMXVCdjlya1JsTW5xM01Lc1N4VEU2V0k4?=
 =?utf-8?B?ZHpOclpkaDFvanAxbFlpVVVjUWtXL0x1U2RoSVErT0dWV2VGdW03YVQ3NUdQ?=
 =?utf-8?B?cCtLWlR0TDQ4RHExYzR1dU40MDFPZXlJZFBONTd3OWtjOXJhVXNXVXN4aDQ5?=
 =?utf-8?B?WG1RZUZoNlJqcyt6N1dYV0poVVJiOXZPYnFoNVg5OSt4VmovRWpRQmYwMThl?=
 =?utf-8?B?bDU4dmpCM1IrdlVYZGVTQk02WEE3YlNIOXp0T1dRcUgzR0I4ZldYM1BpSUVP?=
 =?utf-8?B?QVZmcFF4ZTlPMG8xMWhpcm5OdU9mRzBjWFRHQUp2a2pwQitvU0RPc0pQVzFF?=
 =?utf-8?B?R0hyUHh5RmVvUVNjcHY5OFJOYnpDVUtkUkZkRmFhVDE4ZDNtL1dseVlONDcr?=
 =?utf-8?B?a3g0QzFvTXdnMDZRSnREbXhsTlE3T1ZjMkZjTTJ2QUVMV1JiZXh1RjQ4L1Rs?=
 =?utf-8?Q?/9ci7YkxQgHU/y5UwdYfHswso?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0f856f-8b7e-46f3-ade7-08dd8d7abf8a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:49.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQAyYjhZ7q+VSIwuTkrbPlCB57ta39kq2Iny3v57sNVTsEyu0+m2F5Na7vGRMrodNMPlR+HsbtFWSSoRLWdClQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

This patch series is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

On 5/7/2025 2:19 AM, Mario Limonciello wrote:
> If there is a problem requiring a reset of the VCN engine, it is better to
> reset the VCN engine rather than the entire GPU.
>
> Add a reset callback for the ring which will stop and start VCN if an
> issue happens.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index b90da3d3e140..27dcc6f37a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -196,9 +196,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->vcn.inst[i].pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
>   	}
>   
> -	/* TODO: Add queue reset mask when FW fully supports it */
>   	adev->vcn.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   
>   	vcn_v5_0_0_alloc_ip_dump(adev);
>   
> @@ -1172,6 +1172,20 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> +
> +	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
> +	vcn_v5_0_0_stop(vinst);
> +	vcn_v5_0_0_start(vinst);
> +
> +	return amdgpu_ring_test_helper(ring);
> +}
> +
>   static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> @@ -1199,6 +1213,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
>   	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = vcn_v5_0_0_ring_reset,
>   };
>   
>   /**

