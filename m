Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06984C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 14:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CA910E553;
	Mon, 28 Apr 2025 14:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3K14b/iR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC7310E553
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 14:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2/X+IPnx+deBCNF6fSuseLSQuC4KqHuINgWwkZ3YF4aQw9yhZWfEohn6hXHuO37iwTv0BkvXMjnPbJy0VbeLwv5x9SEnU9xW7dZDM3M/pQQ0VJGGsq+NYMokYB+q6UiFsOT0CWoI7pdFEJwvzIJGM6xgLGWfKL4+cXQiNXO2GYAGZMrc15LahAtG6KqAHrOiTcXixZmCEdJ2WDA3kz0y8bRMvXVx2RDOXYE+zeq997X/FLRg2HM+M6ve1JaEkpYs/NlrWkpq6s2P0V2gWO5m0dLp6KJ/vZ7Llr8kn3Qeuf8i2xbTSEdOZ7VsVC9VVAnN6EjJ8dRzp1ejH9eQpltLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Togl/zipXA6M2vfhRZXTVmHj6mMtFqplnXYPSOC3C2Q=;
 b=hWVDNCr/EVynm5yw8bo84TkZr3+uL+2DzVp9VGL9HyRcjHyZS91rETuzxWYrGWqUMVxtltec55jB4Sx5wPFegEDB59SgvNSJqnGJI9IsXrovXNtfsLpCHWCIjEREo38BSpHRH8WGNIVFFPPr9jO7Pyh53V+6ETR9IT5inFdx0URnuNnro5irIjOeTXK5Ru46JBs6mLvuopGkb9HRG+10loru543Mw4wLzcx4iKZ3vqtXbUcY6xGkfVW5MW7EimjaI8ix8kqWFQqmMvBtrU1OrGqOM/hG1ukhmfj/0XqPhbieoY6vyhoXlHLO7DrKuuSkv51jZ7suxvx+Qa0q1odr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Togl/zipXA6M2vfhRZXTVmHj6mMtFqplnXYPSOC3C2Q=;
 b=3K14b/iRHL+rJZtTrCLawEd6W4W+t/Q9OAoqmUAvL5xufaopkFF73VXtGmexh0mi5IeD+AydYvFMQ7yuHKcqLamKvNvuJLPTlHveOi40B0KxkyP8Qa+0idDGZ0YX6hkhecCASBt8sSNrKMeJn+QiRUjF2Dbbukghb4wkqDgwgi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 14:29:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 14:29:04 +0000
Message-ID: <8fb7f933-45ef-4824-8477-1bb6a80d9a72@amd.com>
Date: Mon, 28 Apr 2025 16:28:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
To: "Liang, Prike" <Prike.Liang@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <b7011f0d-cdda-9318-ddd7-6c36f6581ad9@amd.com>
 <DS7PR12MB60058C12C12F37C34ADE31E5FB842@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005A31931084FC36F628C8BFB862@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005A31931084FC36F628C8BFB862@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: b0832786-856e-488d-e0d4-08dd866106bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blNaRnhpUlpJSjFiSEZwMEN0NHFKUmx2R2p5SW1scTJOeHVaNlVNcG9wK0px?=
 =?utf-8?B?MVA3ZDRoQmNNU3NFMEZ4TE9JcnlZN0Y1Tmt5bmdMNWd1em1Dbm5udCsxK1NU?=
 =?utf-8?B?VmJ2cWtqLzJKSithWVpGWE9lTit3eDNJeDVnZTFyMzJXRUFwb05jcFVJcVhz?=
 =?utf-8?B?RmkycFRzZ090T1IzeVRlMExCeFZSeS9Fd3gvZ1lkakU0SzIzNFhCS1lvYU9U?=
 =?utf-8?B?QXFwU21RdWVaU3c1YlFXbU1QU2J1YWpqdnAvd1Y0WkplMFMzNTROR0M1Vk9B?=
 =?utf-8?B?dE9wcjE2WmQ1NitxWW5XV29qSDBvYmpZSmM4UjFGMlZ0TjREQVNvNkVtWWJD?=
 =?utf-8?B?NUdLK3FZTjEvM21wcTlpNWZ1VTEyTHJPVmthMnlMQXlRMjBlUE1CZEZrdTRi?=
 =?utf-8?B?WENiWnp4eEdiazNEM3g2bFhGdFYrZ2M4bHhHTzhsK0VXcFQ0Nm93ZVZnU2FC?=
 =?utf-8?B?Q2MzQVhHaFUycndvTis0bGFucHIwcDNLZG1lTisrZGZuMVRhaTZmd05IaHZQ?=
 =?utf-8?B?Z0gxWW9LVDNFYzZ5NEVhbUlsVm1WM0lCK2VzQU1vZVFYY2NzK213eVU4MFBh?=
 =?utf-8?B?ZVR6d2VJR01UbFJaMGFlYXdDSDhTWTZRYWpXb0dYM0YyNFozT3dLK3lScmo0?=
 =?utf-8?B?aW95aDJMV25ZbkRmNmJjSXhEVXFFRzdmV0NUUEhWTkVwWUlCTVl2ejNlNjNX?=
 =?utf-8?B?azVOU3hPTXg4VEx0d1FTb3dvTUlQalU2QkFLZ0dzcEI1VVNnc2pYWnNxSUhB?=
 =?utf-8?B?UmxvYWc0MFRqV3M5WnhiL0V4MFBhU04wdG80NzU3QnJpNFdOYnE4R1JaNm82?=
 =?utf-8?B?T0hPQUFxcm5ub1ZRR2tnNjlidnowQ0pSRlk5ekdKUGYwM3NPOUoxaW5sWXEw?=
 =?utf-8?B?ZTQvUUt6ckF1MFZoOGlDT0d5QnlacUlBR2dSc1RGZnNvQjVySHR2dW8xVXh5?=
 =?utf-8?B?OEVkY2VoOUg2SFg2VFJKcmN6MEZjd0dwYzl1YXhwYVdIWFFmUnl6M0Q2SVVh?=
 =?utf-8?B?V2d6SkYrSGFYSlNWT2xDaEg2Vzg3N2ZBaDlPcWVmYXdkOTY1akpmTjNkbDY3?=
 =?utf-8?B?SkppcUpwUk1tQUVwUGIwZHk4RWZVVmhsVTF1VWlZOHg4VThVZWFWK2JQaWdy?=
 =?utf-8?B?d0QwT3pERCtVd091M0FQSXE4NFdISTFCVXBJblBKM3FVNkxNNkpGQWpNc3lS?=
 =?utf-8?B?bEtpaWNTTmJPRy9IQVFaVEZQb2RNMGxyc3dSY09VQTY4QTNGQ2x0SE1YdkFm?=
 =?utf-8?B?SFRJQlZ0L3pKUDNib25oM1BmeDl3VzRLL1VzSFZtZFZrS3JwZWxzSUowVlBu?=
 =?utf-8?B?cnppTkxNT0xvVHVCaEo5cnJHdDBNTHR1OGFIVnM1YUQ0TnRtQ2FIbzRIMWZL?=
 =?utf-8?B?czJ0b2JCMjNnYWFuQXU4VzRHTjZzSDdYVVhDMnFteSs3RFBUOEVJSVBlNEVp?=
 =?utf-8?B?bnJDdThoQ0hPNlNzL3lJTlVHcHlvYlNvajIrcEM0eFF5N1RJN2JWanZ6Nyty?=
 =?utf-8?B?czBZMWErakwvUkVuNHdTNXhwK0xGdk5icVhrYklMYW5TZ2E5MWg2SkRsQk1p?=
 =?utf-8?B?RDBuUVdnTjRlZHIwTitKSThjWS9rRU5HUUFjWHFtS0NYVFBjenlGQmkzMzRP?=
 =?utf-8?B?V016bkc4bEY5WE05c2NjQUx4Q0JrRHVDZnRybFJLWVhIQzZJUUhlbytjQ2ZR?=
 =?utf-8?B?SmdudjZvWkhZUlB1Q0FnQ1lKOE5obmhDbjJFQldKUzdqcUZ4QUdSV0VYVERi?=
 =?utf-8?B?NG9nTUZtVzZjaUc2MFQxeW9IbDc0NDA3T2kxZVpsTHN3Ym82RFlhMEVlZEpC?=
 =?utf-8?B?anVJOXUvT0RQd0NqYnNIUUcrak9Jc1ZNa3B0dXRtcGZxYVljOVBUUkR6dFJ3?=
 =?utf-8?B?bVVyWkRhemswdlJHSXRxTFlMKy9IdDdlejVtT3BFVkJXSmdkQm9SRTJOdmZG?=
 =?utf-8?Q?UgxV74uxChQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBHU0duM0Fsclo2TnNxOWtUSWlKSUo4WUdYSk9LRXdTZGRtVjdKRWVMSHBQ?=
 =?utf-8?B?MHVCUXVvUHBWL2s5Mkd2Z2ZUK1VzVHpib0d2TzVXemU2cW5vVlFnLzdWdnps?=
 =?utf-8?B?Y0NCRVBsaGV5alhQU093UTBOUVVoN0FiejUzOUJ3TzI5Ky9BeC81QUFad1Mr?=
 =?utf-8?B?U3lmRUN1WHVBVktWb0J4VUxMbTBxbjh1REcyMTYzVU9EcU9Jc1YxRHJIL0No?=
 =?utf-8?B?byswK011NWRDWXJueGM1c0h0WVdWWSt1bjVpUFRWM2FaZkFMaGZmSlBES0I3?=
 =?utf-8?B?dXV4bEJ4VDY0bnoyNFU0ZWppempqN0JCUllidnhTek1OL1g4WjRFa2lsVzJz?=
 =?utf-8?B?RGhvMDU5bGR4a0E3Y2h2YVNHYVhXY2FmSHlLZm9kMjFYTUlDU3lSbWdBcmdI?=
 =?utf-8?B?clFYWnFVWHJVRFlDY3pVaVA3eVBrMVNvUktsSnNEMWJKeVU2SGE5aFlPYzV4?=
 =?utf-8?B?YlQ0SGxDNDUzNTJJWjBxZk5aOXhZMEV5M1BGRS9ZYlE5M0xiU2lMemJ2NmVB?=
 =?utf-8?B?Z3JrM0lMT0laU1VpN0c0WkNTRFFZMWYySllkcjdlN0VzWFVoNEZzMXlTT2RV?=
 =?utf-8?B?UGxCQUtJZlhWR0J0Q2J4cFE1R25IZXAvNEhBa3FNVTdpRjRvVk8wMUNTOEJv?=
 =?utf-8?B?dThsOFRMbFRNQVY4TmF3VGZmanRQaXVvNmNtUk1TdEg5VW13Q2R6SlM3UlFH?=
 =?utf-8?B?b3NacDlPTUNEUSt6UWxJcDcxa1lwZUNTTmhINGdIdTg2N0pqa3pSSWZrM0Fj?=
 =?utf-8?B?YUx1TFU5OWlXMkUvTHFCMEYvRWNCQmY1a3praTJGN1kzbmNpczZZaUdlTEl2?=
 =?utf-8?B?bFAvcTZXN1YxYTBGNlAvS2pWeTZDWnY4VmFLallvWnpXV2NtZ3ZHb3dtTWhU?=
 =?utf-8?B?Wk5LVFRPbmtualhFcmFLSnZnamFDQUNiU25LMEFZK0VGKy9YUWlEYklzcGxa?=
 =?utf-8?B?RjVqY2FVVEtwOTJ2VTh1SWJQejUrR29XamJ4cTM5enljc2poUTRabGcvMzFq?=
 =?utf-8?B?b0ovd2xzNFhXSlJTRTE0MlVDS1M3bXZWQVVJVDd1RzR2MXp2S0pZays2S3Qy?=
 =?utf-8?B?bWQ4QUpKdXhWc1BYNVJhWUJGeWlqZVhjckp4ZzVSc0xjdTZTYUUydDRxek9L?=
 =?utf-8?B?MVpiRTIyeDZXa2JqajkveTdkdjEyWTFzdUJtdnlXUGcweGFGaitJLzRQY2lW?=
 =?utf-8?B?cXNxRDBFUmNyTDN2TjMwUGVGcE5IdUpLZXhueFY4SnNXbWowOG1hWkhMMHFX?=
 =?utf-8?B?R3FXYzNZWXVORm9BZ1dwdHJlb1kxdmxLLzZ0MGJpckV2amxCK2Y1VEhobzZl?=
 =?utf-8?B?VFVNalRuYXVTY21YeTJKWXd4UCtQc3BSdlpOaEF4Y0NXUytDaENiemdsSUlD?=
 =?utf-8?B?Mnh3UE91TWNLcEkrZkJhVFJhSFZDYk1JUzNSL2pZSHMxSHhLN1BtVWRLVStY?=
 =?utf-8?B?TGpXc1JpQnoxU2EvaW1wb0VvTXNaYmhmTEpoN1hzQUQ4VVNjUFpQaUxkK0RB?=
 =?utf-8?B?YTFMTjVsS25jb1VZbnJ1ZWU4K3BHNWxtZjNhbUp4T1RscDB0bDRNd0E3U3Rn?=
 =?utf-8?B?TXZPUFhPcDBRc2ZVaHZ6cUZoMVJpMTJvcFNUUlQ0Vkk1MUMwb1g5VkRXZ3Vz?=
 =?utf-8?B?Q25NSHcvWjVnWDVmUE5XZEphaFU2NThrZWJiRjJFay83SU82Rm5ZRDlIK245?=
 =?utf-8?B?V3RwcFl2SGkyS3o1aHJMclNlb3JONHZwYzJCUHhEdFgzbTBXK0ltZnExcUxw?=
 =?utf-8?B?aXNRU1NtZ1V5SExxRnJhdnNTY1ArZHZJTHFpY2tmZWtWZU1VY0ZZYXJjeDNz?=
 =?utf-8?B?eWZhT3E4eGRoblc1TWhXSURKN0NDK0I4c1lRV1VpSVllSHZoVEhRd2l2Y1U4?=
 =?utf-8?B?cUM2Y04rOWYyRi8zTVpKaFV0RDJ3STgzT3NmUWthVjAxcFBDSHk3NktFQlhv?=
 =?utf-8?B?ZVpsN0hOdDYxTzMxTkFtOU5uQmI2U1R0aDFiTFZ2MG9XV2Y5V2IyeGQ4S0VF?=
 =?utf-8?B?emhTb1Z2cmJVUEhaeENIWHBycHRoTE95eGJEUlRZM3ZYRk1YQ2thcEdsZWx0?=
 =?utf-8?B?ZG1XZElJYVdpeDhxU3c2VlAzMS9HMFppVHVTWVlYVVZ3UzRIWVdZeVZuc3cy?=
 =?utf-8?Q?WpY9RAhe+fQut3FZbb7LNtyqQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0832786-856e-488d-e0d4-08dd866106bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:29:04.1877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa0ZtLu5i9JAhtpiSE9tVCV0JW89h6WtmezW9cZvbN/3dMoHY3loUqxUeoSf5zj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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

On 4/27/25 05:20, Liang, Prike wrote:
> [Public]
> 
>> From: Liang, Prike
>> Sent: Friday, April 25, 2025 3:44 PM
>> To: Yadav, Arvind <Arvind.Yadav@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
>>
>>> From: Yadav, Arvind <Arvind.Yadav@amd.com>
>>> Sent: Friday, April 25, 2025 3:21 PM
>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent
>>> read fences
>>>
>>> This is problem for TLB flush. We should not do this changes. Here we
>>> are utilizing DMA_RESV_USAGE_BOOKKEEP due to the TLB flush fence
>>> associated with the page table (PT). We are ensuring that no page
>>> directory (PD) or page table (PT) should be free before flush and ttm
>>> bo release and delete both are also waiting for BOOKKEEP fence. Please drop
>> this changes for eviction fence.
>> Thanks for sharing the background. So, we may need to test the fence whether is
>> an eviction fence in amdgpu_sync_test_fence () before added it to the VM sync.
> It looks the TLB flush fence only added to the VM BO reservation and requires a sync at compute VM.

The TLB flush fence should always be explicitly synced to by the KFD.

Where do you see that it is implicitly synced using the amdgpu_sync objected?

Regards,
Christian.

> As to the VM reservation sync whether can return and sync to the DMA_RESV_USAGE_READ, and I will
> further check it separately with the eviction fence release. As to the eviction fence sync problem issue, I would like
> to put exclude the eviction fence sync at amdgpu_sync_test_fence().
> 
> Thanks,
> Prike
>> Thanks,
>> Prike
>>> Regards,
>>> ~arvind
>>>
>>> On 4/25/2025 12:37 PM, Prike Liang wrote:
>>>> The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
>> usage
>>>> fences, so here only return and sync the dependent read fences.
>>>>
>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> index 5576ed0b508f..4e1d30ecb6cc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>> @@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
>>>> struct amdgpu_sync *sync,
>>>>
>>>>           if (resv == NULL)
>>>>                   return -EINVAL;
>>>> -
>>>> - /* TODO: Use DMA_RESV_USAGE_READ here */
>>>> - dma_resv_for_each_fence(&cursor, resv,
>>> DMA_RESV_USAGE_BOOKKEEP, f) {
>>>> + /*Only return and sync the fences of usage <=
>>> DMA_RESV_USAGE_READ.*/
>>>> + dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
>>>>                   dma_fence_chain_for_each(f, f) {
>>>>                           struct dma_fence *tmp = dma_fence_chain_contained(f);
>>>>

