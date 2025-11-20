Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61149CF64BB
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 07:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BC310E702;
	Thu, 20 Nov 2025 07:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkGDh+69";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5A810E702
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 07:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME3eCkJzFgHePU0bdC/G/GS/wCuOBCm+qR5WWpcibuWzunBouRAGLvptmcqnmmaZa3y697v3bKhI/izVRd0xstLdxpRpuYXMJe3vNV8e2gq815Knf2OrlF98UJg3qMMTfBqcjPYyzTIFU65HhbMh03grlcK0/cBFMMR4PEZm4EBg+yA6v5GF3fbD9lO2PIBkccIGewl7szPJZ6uWmRzuq/tOGlN892TtLQi4VPslCp6kKRRGtubBGKkyda3ipHDYGZDWmd3Mfm+N2EnFN4/NzcRPHw2msKOxClVGF0o6V+poZZKhWLVoe6yqDm+l0hGUacuEmU93R4V2/R+S9jo28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19gY7+sLfoq0rKxSa72njJKPzqS/5Q3GOEbhQvfDg+M=;
 b=RLlRl+YI6/zn/Sd57vR6gFftClKkQ9bpK1dS9jDZrCgGxhsqqwT5DU0AJkaEHcQvb9awXcNYNJnZumVetKEn2jA86gguihb1Bq7xfi+5R7+MQMUuKLEY3A9bOKLwzBJwkGba10S5egP/DUngUh4MLyoc/2ub9lM37bLNgsdChClXW3y97MGhYaKStCoLLWsLblBzPW8HvHaWW1pZ+Hc09r0iJwwPv1cxMjuWIimEHVFqjPo4cEjC2nOtVEPBpnClhS8HLpwUM6HQiNw5dF4jiMvPKVuMZzLsOQsw/5dCh0pn72Yld940+l4TLh8D0VeWD3ibfthyaTaG6RJ3IN3KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19gY7+sLfoq0rKxSa72njJKPzqS/5Q3GOEbhQvfDg+M=;
 b=jkGDh+69aEpAxDTge/4MB3x58BhmtQIDb+C2NOsONHHVLLBw6CmE4+8mkvB8rpnmQKDavGaMRvXaUtc20qnji1cMqAFjR28uj5NVRdOQeU0U9pjwHYl+z8grYFBA6+zl+mbhxnxU8EfApnDzimReHL+8IU7vzfjjPJGS6fCRv60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:40:56 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:40:56 +0000
Message-ID: <2775ac42-de6d-40c8-ac72-5e3070529d3e@amd.com>
Date: Thu, 20 Nov 2025 13:10:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20251030011651.1433120-1-kevinyang.wang@amd.com>
 <DM4PR12MB6012F6F0A577D1D47A950B9082D4A@DM4PR12MB6012.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB6012F6F0A577D1D47A950B9082D4A@DM4PR12MB6012.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 229c1999-b0f6-4dd0-99e9-08de280823ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3dKUlRmcmdaY3dDVUVDb0c4eE1uSk5tdnNOU3BpU3ZXN1Z0RThuVmF0K24y?=
 =?utf-8?B?VnlsTnVFNWtDRWNVVmJNMVI3Wkd1Z25lMUdmWjc3S1BpVzNtcW5lSzAveThI?=
 =?utf-8?B?UDQzTXhCbml3cG04eEhCelFqMFp0NmlPU1RqRUJaMzlCRXFqOGxlVVhUSitr?=
 =?utf-8?B?S0xVMjY5TWFEbWxiczFoZjhlYlg5TU04L3hwMlJ2QmR6TUtZWUZCUjlNT29n?=
 =?utf-8?B?SHA5YzIxaG9vZUttZlhpQlFvTzlWUFlIL0pjYW5BU0tVT0FqRmFESnpDZzV1?=
 =?utf-8?B?QkVReWRpaitZVzF5QzNycXl2ekVDcG1Qait1NkpZdlNlUDBNSGNFSWxOT2tS?=
 =?utf-8?B?TFhndXBiUnEyRTVxUnpackM1Nkp5YjZjZXIzWkZqdkd0R0NWUVNUSENsMS9h?=
 =?utf-8?B?dGkwa2lSZXl2L0Fmank2dGxDM1JVRVVNQXpjQUxISnIzUnJ3THA5cmJ3NnBm?=
 =?utf-8?B?THlncGdnbEg4RVMvWXZ3YjdWRzNSS0I0bmhFWENMQlkyeHRRclpIVkx6K3Ro?=
 =?utf-8?B?c1NzbEhCNkJJcjdxWFpyd1IxS3pVL2UzTmhyVnViVnFSeGZkZWRtdnNRdTFW?=
 =?utf-8?B?NkVOV2VSUEd6YjU5REE3RzZOa2UrRkVoTisvNmd3Q01wMUZDbHRvVmhYdkVX?=
 =?utf-8?B?Ky8wVTRRK2loOU5DM3pVWkhWVjUxdXBnT3M5UzE2M2dFNUM2Vm9md3lFeU9q?=
 =?utf-8?B?b3o2a2ZmZmczTVJycjZ5bG1Qd0NGQlpRQ0ladDZ1Tkl3S1c1ZStSVDJWNmVQ?=
 =?utf-8?B?T0Q4ckt5Vis1cXFSaVNkRTdvNUFOeFRNbVkxQUdTV21ndStKQkUyQU9HbU4y?=
 =?utf-8?B?MHladmUwMUk4ZGFxSm0yVFYwd0ZrM0pvRG51b2FXbzNvdEhlSk52OUMreCtK?=
 =?utf-8?B?MU8xQlE4R0taTXFObm9vWHRVUjVzeVV4NkhmVUFJUTV4TC9ueEJGYUlxYkUx?=
 =?utf-8?B?ZG0yVjJXM3BjSzNrQmhJYncySXZsSEdKY3gxNXI0YVl2U2UwUHA3OXlSVEZm?=
 =?utf-8?B?ek56MERoZW9JR0ZHWUtiajhWWElsRjU1M1Y1Rld5VVM3RmJySVZ0N3lET2Ft?=
 =?utf-8?B?Sll1ckpIVmRWYnppV3RxbTBPcENYQUtGWENseUZuUGlncTdibU5VWmR6UWMv?=
 =?utf-8?B?UkFjTFBGRzRFRU81OC8zTDBxaUZrRW9Hc2lZVW40WWVQcXJEYWdZUkdBeXBJ?=
 =?utf-8?B?YndaWFdnN1h1Y3lSNU9ONkVrYW1pMC9pZzI0bEUrY3ZvclRQV1ppMmhON1VM?=
 =?utf-8?B?OGJteldKWFNyL1VMZUNuMjVkMjk2bWlyWDNNK1VuTkdGUGd4VS9iTk5qVlRL?=
 =?utf-8?B?NGlnS1U2cHc4M0VmSW92TTZmSWNyMGszRnB4RCtONTNLSmFwVzFYVDRyQUsz?=
 =?utf-8?B?U3ZQT1dTTVhPTGZOVHAvZ1FiT0tpNS8xOExMNElQbGtIaTRGTWxLcElib3Js?=
 =?utf-8?B?SWc0TGxoV2M2Wm5xWXpuVUxSVzdjMHVjcWJZRitYT2ZOQ1RlWlpOeVR1T2Rp?=
 =?utf-8?B?dWxReVFXSFRrdTE2TE4xUFh0Yi9PZDQzSDFMMm5GdFdtNTZBcVZWa296cnNF?=
 =?utf-8?B?Vi9DcmVib0dJNHJ0WDB1azhkMk9WMXVwYmxKS0NuSlBoMGFRV0hSczJpOVB1?=
 =?utf-8?B?Sk9zbnBOOVN6Z291VU1obTNsUXhRYkE0S2ZPczhhZWVhKzB2SDlLbERyL2R6?=
 =?utf-8?B?UFRmbzFlUVF3YllsaUhmektrTjkrRG5SQTI3a1gyYUFKWlNEZ0JVbnZjWWhC?=
 =?utf-8?B?bDZWYlRUVGFYRWY2eVp6Y0NPRUt5OTJNOVFldTNTR3d6SGJEdmhYRitYRm9K?=
 =?utf-8?B?MnJoZ2FpRHZkSE81QXhrdm9TdElrenBoeFZZR2hsRmh3M09tbi9oUVFEUlQy?=
 =?utf-8?B?aU5vSWVhVVVTc043ZHNqRzVRVmFyS1ZWajBMdEdMSEErYlV5cWp5Vnd6eDZZ?=
 =?utf-8?Q?X0VISGr2jzibGDyR4ciMcipzstu4o7Qc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFrT3FWYVdoclUxWjdxSVhnYnU0OHNnNGI1TE51WnVGS2NvaXRaUDVGdDRS?=
 =?utf-8?B?dmtYTFErWXdoVXlucnR2MnFaSTA3T0FWT090dGdXeU82dXFSd0d1c3RMTnc4?=
 =?utf-8?B?ME80ZmE2SE00enVONzBzUDVUYzdvZzhDa0RtUC9lMlpwM2FsYWI3Nkk1U0dL?=
 =?utf-8?B?TmZ5aUpHNks1cVRpek9oVE02Q2hLVUplWTcyd2E1MVl5Y1FmUVZrUi8vcDUr?=
 =?utf-8?B?L2V3V2hUOUVsY3ltY0VvVEVLQmVRbUxIRGszYUQ4MU1wMWt3ZmVnSTF3NlFM?=
 =?utf-8?B?SHdCUGlyb2lrMDBwOUQ1bHI4MWd3NWxhay9EcDFDWW9TQ0hFTDNzRWIxN0xy?=
 =?utf-8?B?RkZzU3RscTlOYXdKWUlHN3hDU05ONld0OVVKMDZnVDVhMmR4MlVxVldaUkRs?=
 =?utf-8?B?NFg2WE9uOGhXWHRGc29KY1hLdFFWY2tVaFBPZnc5YjNrczViN2lLRmE4Qytx?=
 =?utf-8?B?SUtLMktvemlOd280MzhHSE9LMW5qdXB4aGhlK3B2SmhkcEFSYTVObEYvcUJp?=
 =?utf-8?B?U0YvREdydzBnbFBsblYzNW9IQzFVckZEQ1h0bG1WYUhwQy80NVBRYmJEajZ1?=
 =?utf-8?B?dktuVGc0aGNUR25TdzJBUm1zRWZOMVUzV1N0TnBvM09vSTl5bk85TTVBbjBF?=
 =?utf-8?B?MVNvVWhQZWRrWDJJSFBCQnlnSEgxcnVNMHpLMlJ1Q2ZjTkxsRS9zR3JpazdF?=
 =?utf-8?B?em9xV0JialpXN1d3dHd5TDdoTTJMYldJUVJGQ1hDanZIVEwwVjVZTWVFWEE4?=
 =?utf-8?B?UXA3M3U2N2swQzZWbjJHU1ZXUUpva2x2RzNmM3RnRmR2cC9YV29kR2plTnNl?=
 =?utf-8?B?NmJhb201NU1QMDQ5d3Q5VWhaL2R5b1R5TnhQME1kZFA0dHNSblRrVzVRRDha?=
 =?utf-8?B?eVU5Z203VmtFZ0plamoyMTdNTVJGZ1NFb0g0eVBDKzNXa2V0STF5Y2IybE96?=
 =?utf-8?B?aXBDQ0R5Ym5xaTRCMFlybWh6VlRNeWhvL2JCc01WTEV3eTRta1ZyZFhyMkc2?=
 =?utf-8?B?ZWxBaExsRldtRXRhZEJvcGhLa1M1K3hPcjZxMmFseGo1QXowOE1ydE4xRGRz?=
 =?utf-8?B?dUlZd1c4N2t0RStlcGs3SjhySTNOZXpVK1o0VnFjaWdsSDltOTMwS3NGY3J6?=
 =?utf-8?B?RklDNXR0ZXVBemIzRGxDa0NYL0NxM0d4Q1p6d0VwcUZKSmZFNTIvT2RRZU5E?=
 =?utf-8?B?V05oNjVLSkU3eU8vTDI3bnZDQXNzWUFtbiszUWdSbzhCdUZiREVrc3pUZlBR?=
 =?utf-8?B?T1p6T2Fycys4NXdFQTE5NlZwbmRSM1JNSDZBS20yTGZibFFUeEowcDlBZ0Ro?=
 =?utf-8?B?YXNGblNrcXkxY1JZZE5WZWlZTWh3NjhuWElRVHU0cGxUY3llZVR2WDczcXND?=
 =?utf-8?B?ME1Bb0kyTW85WldJcHlwRm5ZS3dZbWlyTEtpZ08ycmJ4SEUzamdWWFNwYWdk?=
 =?utf-8?B?OEhtYXBuVnAzMGVReWpnbklPWkVSYWRxdjhCUmhmWjIzZVp1VmZEVFZxTDJZ?=
 =?utf-8?B?M2JsZFZxOXY4OEp3T1ZyTzhqL25QeXE3NTFEVno0N1BHUW1UcVdqMmpUbHE2?=
 =?utf-8?B?YUQxb3ZhZ3l5bE43aVVHL3pPdzNKd1ZpaXU4eSsxejV0WlVTRVU4Zk9XVXEy?=
 =?utf-8?B?Z2hqZStrRVRsN24vQm1VQUtBL0lSV3BhMmx4U0R5ajlBalZadjdQVGdiUTgz?=
 =?utf-8?B?QWpqTUlzZUt3cDFaY2NOK0srczRmVFRNd0EweTBJcTRlWWxDdkRNcE44NlJN?=
 =?utf-8?B?VENUVXM0UzY2cG1jR0dFbmdnalMyeFlaZUR5NHM4UU5aT3grS2dhNEVrcU04?=
 =?utf-8?B?YzRSVUo3dHlHTXNzT0hKdkJka1QvMkhtdGI2UEpsNDRIUEU4WWlSQ2ppeXJi?=
 =?utf-8?B?V1YxTlB0bW9lV1U0QnVhK0lIUWZFaG82cUNlT1dWM0xSTVlzeEJLd1ZacjRs?=
 =?utf-8?B?bjNueFZrZmxBVnpSeEtndkFkTmZ5WnRGZkpZN1pFQ0puTm40eS9tdDgvcnJY?=
 =?utf-8?B?ZXNVTjZVVFFFYUcxd2o5Z1hzazJBckUwTXJ0YU8rZ3piUjhPWWtWWUFqdFF6?=
 =?utf-8?B?dlBlQnVTR3FjWWVLNFA4d3g5d2dIRDZESUVIL1FZL0gvY0xJaWU2Y1pGekxR?=
 =?utf-8?Q?7VIF5lMn2M1+dItS2mULdLxt5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229c1999-b0f6-4dd0-99e9-08de280823ab
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:40:56.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/x497ZwWON90VPRsWtDfQkiwaxj/YbQ6XtCCspruCDaO4xSoXA+mtuOt5iy/hZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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



On 11/20/2025 12:11 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Ping...
> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wang
> Sent: Thursday, October 30, 2025 09:17
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
> 
> - make pp_table invisible on VF mode (only valid on BM)
> - make pp_table invisible on Mi* chips (Not supported)
> - make pp_table invisible if scpm feature is enabled.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c83d69994380..3a14e0ff38ae 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2507,7 +2507,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>          AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>          AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>          AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATTR_FLAG_BASIC),
>          AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>                                .attr_update = pp_dpm_clk_default_attr_update),
>          AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
> @@ -2639,6 +2639,21 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>                  if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
>                      -EOPNOTSUPP)
>                          *states = ATTR_STATE_UNSUPPORTED;
> +       } else if (DEVICE_ATTR_IS(pp_table)) {
> +               switch (gc_ver) {
> +               case IP_VERSION(9, 4, 3):
> +               case IP_VERSION(9, 4, 4):
> +               case IP_VERSION(9, 5, 0):
> +                       /* No PPTable support on Mi* chips */
> +                       *states = ATTR_STATE_UNSUPPORTED;
> +                       break;
> +               default:
> +                       if (adev->scpm_enabled)
> +                               *states = ATTR_STATE_UNSUPPORTED;
> +                       else
> +                               *states = ATTR_STATE_SUPPORTED;
> +                       break;
> +               }

What about using a dummy check with amdgpu_dpm_get_pp_table(adev, NULL)?

Thanks,
Lijo

>          }
> 
>          switch (gc_ver) {
> --
> 2.34.1
> 

