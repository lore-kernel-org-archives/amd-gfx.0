Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9CDC02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 05:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671B910EA51;
	Fri, 17 Jan 2025 05:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MrumZIly";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01B110EA51
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 05:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIYMTJfmAl+WkXGwD3v4Q+3wDXCfM4TCCf2yIy7n4C6cupoXVDwTsRcK/2ZZg6767nKiB6mI9GpCuyD+HPrzQVKFDT8vYYLRKtV8SPD2+GKWyJRgYS9y3kJSVDSaMkyBchf1mZCcvkcUzZ5vanpukWrjxQXd81bO5owZLPzgz86KyXS4NGRKA+IQa/XK8vDxeVRUs3BUzYWY+xN20M1y0+YDd7o3MrsnBkENcUM3+ckRCgHRevN32ZvrjW+zftdoIVBmUBdqieY89wQGAl2yiYcz4XABwCApbbuwNSwHnvpRH0nRRHfAcKikFo9KEWlucY8NoQieYFWzywajwlFHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rATinmuR8atjCcIuC1rw4Nk6+CZUoFknFHyaxmB4pQ0=;
 b=tlvc1onhGh7O1TqrICwVr1nZH7w+4wp8Iks336YuzwYnRj/+KP2Vi8DGGF4Bc6ihVn+lBnI07EGU4a1WRh4D56BOcNxcuy+6mgwIvm9cB9m9DoGllBT5q3Ze3YnQrT9JdDInXbF9jYlqCgPGPe/HXXEU8AemOF9V92YHh0NpYdARifThE8I2Wi2dKQ6BqFTLLKHC+YKjzZ1GjDfpn1/ejp1PijCRJZy3Ea/3fgGnlEoMQ4ccf7ipDq36YF4+20LGVAKenYy9QMEmTB+Nek1yIi/p6vxr5nQwmwSUx4x9f3OAsyH9WqI0hTqP/koCvqFqUc5EmI5FStYQazDn46SeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rATinmuR8atjCcIuC1rw4Nk6+CZUoFknFHyaxmB4pQ0=;
 b=MrumZIly0bK3HMygMPgHxkT7v3D8kTGVhv4R+gDpgBxMffCo4xaJlLG6rSrtzV8Jg/MV2OpCzYYEOvMvMX5ILbHlqrd4Qc2RqxeoeWVzhRXEfAcWZQjvHJbRzzaHUvCpqs3Q7H8OUC/Uc/rsTFcT6+Il7IUR+gRFSZvHRZY+UoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.15; Fri, 17 Jan 2025 05:24:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 05:24:23 +0000
Message-ID: <319cdef6-f0f5-4ccf-9378-f242e360479a@amd.com>
Date: Fri, 17 Jan 2025 10:54:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/15] drm/amdgpu: add a flag to track ras debugfs
 creation status
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <f79c15b3eb9c560ba7942c3e7f51dae7d6051fa7.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f79c15b3eb9c560ba7942c3e7f51dae7d6051fa7.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: e58b2d33-ce4a-4832-8835-08dd36b73386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1gvTWhmNDZNSnhoWWYwUU1xUnJKUE84K2Vqc1k0R2pqVkVQRDZGQm1oMWVx?=
 =?utf-8?B?alZzTzRuQk5reXdML2pqUytSY0FDYkxuNm41ZXNyQS8xSlVYeFFJMUJBSjdM?=
 =?utf-8?B?eE5MdHpYTnc3Q01zQzlibmpOci9tK0l2TVQ1UGt6RTFBRGJZSXl5SGpOcUNR?=
 =?utf-8?B?K1VQWHNsUnpsalpyU1k4WnlsTytBb2lpeVBJRnVIdG1pNWZoMFMyR2Fqb3Bs?=
 =?utf-8?B?RjVOUkdWTXZ0YzREdXk2L0pFL3A4QUFSeDdhWVF3UVBydkRGNkxybDJ0aURo?=
 =?utf-8?B?Ny9zSitvY21tTnNIUlpyTUs4cFdUZlYzNnVCWStPMCttTEU3TjQwcjB6eGJm?=
 =?utf-8?B?SlNwOUdGdWpxSVhaMitoUUJXUXpLU1pkZTZlWWxpTytHVVE3eVh1Tmk2OG1i?=
 =?utf-8?B?WmpVNXY1Umkza2cxVTJwRFFHQUV2QnQyVVRUN0plMklzSGk2UjFEMG9tdFov?=
 =?utf-8?B?OGlTNGhTUnBWb0IwM2VTUUxSdWRadXZQQVY1RVlaaDJ4bUdMdjFjZmlYUUg2?=
 =?utf-8?B?WlBxVnFvK1Q1QVpOQzJvcHE0c2lKNDlUNTAyR3Z0NEhQUXZwNWhMVElXK3A3?=
 =?utf-8?B?bkgxcGFhck9EcyswTFpQS0JCR0VDRVdWcTdSOXZYRDJ5ZTRkV0JBK2ZMeldj?=
 =?utf-8?B?N2Radi9YdWFLMkpTQ0JQN1V0TGlmYkkvaVpzUlRYT2RZZThzVDA3MTVVd2Vu?=
 =?utf-8?B?WVI3ZEhLRmRFZDVJQnlGeFM4SEM3M0oxZFk0dm04WHdwSnpXMElZVEFlOW11?=
 =?utf-8?B?QkkyeEIvZGhqY2FZU1BMVmZwSnpSdWQxcnlZU0toZDYzWUJKOUFiTE9NcWJw?=
 =?utf-8?B?NmFEcUc1dWRXbzJWOWtqMHpDTUd6dEQvdHVTK1ErYlE2RVJPQ0pyTnZuRDhn?=
 =?utf-8?B?RUR6b2owcTQyenVZc0trVFhEVFRYaXpUUUY4WXV3b2swcjlscEpDY3JOcnVW?=
 =?utf-8?B?a2NXSmhKajFEMGt6UG5UMGhaa0RYdEtKN2llNVNGMmFRWkpPSngxMDdSSXV6?=
 =?utf-8?B?MmdvSFg3NXVmRnhVbWVGc2M3amdzMk1nSHJteE96MWwrZWZVRGw3TDFaZ0d0?=
 =?utf-8?B?YkZsU3V3RVZycHJCRGpDVko4WVFMQ3lPQ0lWS0YvU1UrVFVYakI4MjB6Mmk5?=
 =?utf-8?B?VmJRUVBFY2JmRUE3blFuTnJpcE5DMHdneEl1VUVCbWwyT25kcVlCc250N0F2?=
 =?utf-8?B?NGllcGd5MW1LRVpET2hGdDZoOUUxLzRLc0hvUnJwem5wRm1PV1N1aHFnNnk1?=
 =?utf-8?B?WXg5MVJlbTlqVXVlSXpndGxtTU5iY1AxcVNnMEp3TEsrUVRYZStWNVU0OVFy?=
 =?utf-8?B?NmttUk9yWndJUUU0OHp3eDVWQ0J0aENWSmsxNExJaEpua2hWdUUzeEJrRzli?=
 =?utf-8?B?dmZqaG1TeWFzMVkyQWNFekMxNmZueExvUU9YNi9qL2kzM3RCQlBHdUhlYWRl?=
 =?utf-8?B?b1NLb2ZwaTlxVFE5aTFHMlJIMjZJbjJSa0FYTEg3eDRxN1E4aE9VOTQzLzQx?=
 =?utf-8?B?QTU5NWd2cDNublRsZVh3WVkwMEtHMnhMZDR1ZWVtM1RvUE9wTFdvS2JEM3ds?=
 =?utf-8?B?SUsrcGI3NHNiUnFZang1M2JjZ3IzblBueGVhdGtSbHZZdEtNVlE1eHRHY0tE?=
 =?utf-8?B?cTRUQUM4N0xJMWVTK1Q4blc3aDVWYUk2VmVpSFViOTJhZ2o2M2g3S1lPTXlp?=
 =?utf-8?B?aUhMWlAyMEJrTUVtbVl0Q04yQU5CSEM5YXFrWm5RNnEyc2dreWp1Ukt0VExO?=
 =?utf-8?B?MnhhVHVNQzR1UGwrUGdYUDI0YWl6TGUzZkNLOWY3RCsxV2VicVhXd0lRQldZ?=
 =?utf-8?B?MmpmaE9YN1lHQ2lDTlZzdTZiVVVSOE1wS1lzVjVYR3l3SWlMbENISHVjVCtU?=
 =?utf-8?B?Qm9aVWdlKzZSZUNDRTNxTFRRcmVKWUJoZXlrWTlkeEJEc2R1RXRjbXpaQzRZ?=
 =?utf-8?Q?G4Q93qeSwP8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9QcHN4dUJwdlBpTlY2MEhleDBhL1lwWjN4N3ZOSEVTREl3RFg2QUxVSjdI?=
 =?utf-8?B?TVRwWUUvdTFLQy9BL3JHbWdiTXlxK1RZUzN0NXYxQXZPcEVmQXB2OGhFMHlV?=
 =?utf-8?B?VVI5dVV5Y09XWGZvZVkwT0VkUExPMlhCbnd5WngzVWdMUnhTVG5oWks0NUEx?=
 =?utf-8?B?SmJQTERPak9lcGw1VENrSW9hUmRTa3hCWFRVM0ordGJxSEpuby82N1JiMEtV?=
 =?utf-8?B?WnF2b1pkcjVPSThVRUJ2alVadkFJbk5sSGFsdlp2NThZdjNkWHd3b0I2elNQ?=
 =?utf-8?B?VGNqU3ltK3hQY1dUZ2E4TnhNMGRaN0lITUZUMFVHVHJrc2dFR1daVWNrMVd2?=
 =?utf-8?B?dnllcjJydGsvb2QrZnd4eEdZTFJKZVBCaFJ2bC92MXdYdThrLzJ4TEtxT05C?=
 =?utf-8?B?ZVgrc2NpU0dmOGRBQXJQZHNOZUEwUlpSL3h4bXlMVW1MSndpQWxGa004YWNo?=
 =?utf-8?B?VUJBM0FrYURhMzFMd05UZW05ejZuKzViZ1k1QjRzbE9TR3JUb1NXVFRrOU1l?=
 =?utf-8?B?aEk4SURvL1ZTb2drZHlkZ2tHN3FhMFJISlhPRGJRelFxNEYvamlKYVJIT3pi?=
 =?utf-8?B?NVF0eDRZMzhmSHJPZTNFaEJ3cGRON0tXRGJjSmYraUF3TlVTRjBKRGl2RlY0?=
 =?utf-8?B?S2FWdEZpdmFGMGExTGtCUkthV0pWT0R2ci9FTkJsdHlQZ01yNktkTWJmSU9x?=
 =?utf-8?B?ZGtZZitENGZCQ0ZiYU1nN3Y0V2UraDlSaXhUOHZ1NTBDZnpQeldNQ2t3aG9O?=
 =?utf-8?B?SnIyOGg4aDVVQ1dsbHMvQzcrQUY5L1lMSTVzcFBOY2VqcURsUUJwQjJrS2xY?=
 =?utf-8?B?cnc1cDJrSjZ2N05iRzRkMTJPVC96M3dtMy9Sb2NpQ01PdjEwanl3NTF4d01O?=
 =?utf-8?B?MGhpTjlaZUNrTlJLUFJ4YXZIdk92STJTVzArbnB0b3B6QU9CV3U4QkNKY29U?=
 =?utf-8?B?VkUxY3pOWDdwRXdOVUNBZkliamd0M3Z2ZG1TWjhqd1BWc0lWRTIzcFZaSTl1?=
 =?utf-8?B?ancwaFBqWW4xc3N0VXFjWFdPNmQxdVpLR3pVdUFtT21nT3J5U05PR1hRVjVK?=
 =?utf-8?B?aFFheEUwZ1ZxT2NYNkZ5NmRxdXIrUWM5cDJMZ0F3eEd0elVmMTFmVHlndW5B?=
 =?utf-8?B?bGlicWRBN0hwdUhPY2ZGaWtQcGo5dUxOUGZkOUMyN0Z3Q2VqMUVTVVdxK0hV?=
 =?utf-8?B?ZUZNanFVL2U1N3d5NDNxalUzb2x2WjN5MUdjbjdRaVVaUExrMC9CV1lwMXRV?=
 =?utf-8?B?NitRSDBwMTNaZi9LTkpQU05ZRWp5dkNnTU9KczBnZU9KQ29EdGxyRWRHS0ln?=
 =?utf-8?B?SFdKVEZKNWJzTVl4azBHRGJHeUt0d0J6cTk2dkx0L013bEJYY1FIb3NRd1pQ?=
 =?utf-8?B?aDdIT2s5RjVuWjhyTE9RWkJmWFRLTG9BZGcvcHk0b0xrZXo2MmFvRlNpWjhW?=
 =?utf-8?B?cnJEZ1hCRjkxME1QaUtaZjdDbGdQQXBCTnkyNzBvb3ppaXVlcXJVa216UVd5?=
 =?utf-8?B?Ykt1LzlQT0NES2pZbDJQOHIzUWxIQU5FeVl4RWJBMFcwL25sQkloV0JlNFkz?=
 =?utf-8?B?V3RoSmE2VnpuVnlwdUcrQVg0eEJMYW9wa1N3ZGZ6OTFUR2N2MFltZVFWODR1?=
 =?utf-8?B?QWJ5K0ZkR0MzV2cyd3dKakQwZHhDK3dXek5FbnJneWhjNmo4cGtjUmdXb3hx?=
 =?utf-8?B?WE5WaVdPQkZ2MnhmWk1DR0lqdXVxWHBQMkJhWXVhR2FLT09UR3daRXB6WkFw?=
 =?utf-8?B?cXdWSnptVEtpK2hHQlhFOEZqQVRxUFdEck1BUmxMR2tpbUtYSEVmeVAvN0h4?=
 =?utf-8?B?bmJiNVpyWnA1WXpxZHFnOWdzRjhJdXBXYm9HQjdwU0JGZW4rdkhQWTExM2di?=
 =?utf-8?B?TzE1enF0eXRCMnF3NjJaVWVWeEUrQlJKZVVXRTFPVlBSeDFWSnRpajBDay9D?=
 =?utf-8?B?Ty9IV1o1SWdLRlB2Z2RCNlJZMUx1WnN4c2tGUEdNYzRBT0N6Y2JGRVFFY3BB?=
 =?utf-8?B?dFpMMGM4YnZEbU5odVVZVnhtSjhsS2JTbXZoRG8vcXJ5RmU4YzNCelZySDZa?=
 =?utf-8?B?c1IvNEQ0aHdyZXVlUTRzTFZxUEdDQXZ4QndZN0RFYmVBejNhL2ZwRmhITms0?=
 =?utf-8?Q?JfWS8ZTVpMuxG7edQA9tt28Ek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58b2d33-ce4a-4832-8835-08dd36b73386
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 05:24:23.1270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52VyV3hgzKpkBRu/b61Cs6YuG5/wp1CU1fIhAD5ScbRoRnnWu7cb8MPmplIEXWJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Add a flag to track ras debugfs creation status, to avoid possible
> incorrect reference count management for ras block object  in function
> amdgpu_ras_aca_is_supported().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f0f773659faf..09b63a622728 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -378,6 +378,8 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
>  #define AMDGPU_MAX_IP_NUM 16
>  
>  enum amdgpu_marker {
> +	// Markers for ras blocks.
> +	AMDGPU_MARKER_RAS_DEBUGFS,

As mentioned in patch 1, keeping a global tracker at this layer is not
the right solution. The expectation is each object/IP block to keep the
state info.

Thanks,
Lijo

>  	// Markers for IRQs, used for both ip blocks and ras blocks.
>  	AMDGPU_MARKER_IRQ0 = 32,
>  	AMDGPU_MARKER_IRQ1,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5e19d820ab34..c10ea3fd3e16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1997,7 +1997,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>  {
>  	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
>  
> -	if (!obj || !dir)
> +	if (!obj || !dir ||
> +	    amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS))
>  		return;
>  
>  	get_obj(obj);
> @@ -2008,6 +2009,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
>  
>  	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
>  			    obj, &amdgpu_ras_debugfs_ops);
> +
> +	amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
>  }
>  
>  static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
> @@ -2136,7 +2139,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
>  	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>  		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
>  			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
> -			if (ip_obj)
> +			if (ip_obj &&
> +			    amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
> +							     AMDGPU_MARKER_RAS_DEBUGFS))
>  				put_obj(ip_obj);
>  		}
>  	}

