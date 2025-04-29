Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FB4C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 13:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B45210E4A0;
	Tue, 29 Apr 2025 13:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ptW5qk7t";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B004C10E4A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POAMjKwG38xjSvIgTDRNvBSvB779SjdIhcJbSNll+nFcaBfbmzYruImIR1nuVJNGe3mv4cxPIqiiw+Ay0s3ZVmu76yOPZCMaaQiukWb1J/o9UAzyTRFXrqG1MVZnDQbuzobZsTMqdwK0wQMwTLyLjyFCN4G7yrxj1SoOp2DXLAnwwUr2kQtRfeWmkY7fDurLwZ20R3jh7gkUdCZXYk+3fpK4oITZnSglAo6rLh+/JxF/Ys7pyJ+sNG1ISuAHmMD3QrzTIwZlw8LuOGrri066BHsYt/iebt5n5T29OdX1GJ96xszKRsljumtfg4+OH2prR/RTnqyfiKdVGSxorPIE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ke/Y1CRoNHNTxNSflEaOmaTWvDxd77hph5rqTZUPrk=;
 b=O0IyE+t2evqb6jgxbVEplNcmUE8kpvh5ymK2yDwGAiYlo5Frj5Ji7hjAXgwGvyboUTSXBk6zJjMr2kuARbI8RjyS1qatx72U6nUNNQXxmZbT3KsYE8e+086gVfpGgZO/ht4ZscmGuxUgG9SovDMmSAioalIuNLZ8ACaMPNJRfB0J8Ilc4iDTTILaB1tsIdYxiubUJiiq69DZzYRKDd9w4K69jK6EvqzDxwzSCSCasvmEN3Zn++VyC6VuCd+7UBMGeW+p7WTyL5fV89Md68K7i/y3uyjTUdplYFPVX1V9VVB7IJhdmk9Ljw40HJHcpbm2jW7cSqZ4AU8Hp0mKuxPdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ke/Y1CRoNHNTxNSflEaOmaTWvDxd77hph5rqTZUPrk=;
 b=ptW5qk7thWGtykk39/TunRyBITCDYtgxwe29/y9OGbL03owveRzcxp/aSU2riZaLvEks4aMbUhaoQZAgbaWORvUjM2XZ7sR1ZBEgpyQzh2XLs8H1/cgAXzeDseyAwWTUcSqwt7jeqrWBBvqG5lrTD/LaqdsRR0JEbZj/7LPTPNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 29 Apr
 2025 13:59:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:59:37 +0000
Message-ID: <cf0a18b0-9a4c-4c91-af81-267c0b859b5b@amd.com>
Date: Tue, 29 Apr 2025 15:59:32 +0200
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
 <8fb7f933-45ef-4824-8477-1bb6a80d9a72@amd.com>
 <DS7PR12MB60059FA9861ECA2B7355E189FB802@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60059FA9861ECA2B7355E189FB802@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0411.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 900fc09f-ff3c-4bab-9e34-08dd8726140f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RStyTDlBWXNHUlN3ZWhqSFpxbjdhYkNTZ2YreVVBNllVSWQycHRDSW9jYVNE?=
 =?utf-8?B?Q1NsdksyUHJPb0pxSDFyOFoxRmVBaG9QTHJOdktlcE40d0cvRUpFWUxhblZW?=
 =?utf-8?B?WjdyQlgxV3JRSGZvU1dpc2ppck5mQnNvcytURTJ0NmN4QnQyU0p4RmIvUW4r?=
 =?utf-8?B?VWNoM1lTalZqWlJsQ0t3Y1NYSzJLT0owdzlhYlpJczI0UkJBNmF3VDRlS28r?=
 =?utf-8?B?VjFQZStBUTZlZWhzcjZidG1aUHVHaUtpbE14R25RN0JSK3Bwa3ZPNGRidVNO?=
 =?utf-8?B?c1ZvdDlsNHkxdG9vR29ZSERwU0JDdi9pdmRvVm1NdWtySFNxazlGTmpsV3JY?=
 =?utf-8?B?V2RRdW5NZC9TSXdHZ2hnK04zN2hCUkRpQTJlaHZQbmE5YW50YUROM3hJa1ov?=
 =?utf-8?B?YUxHV0p3YWtMd1R0cjhCV2ozdDNNanBFbDN4VThsYUpjL0RSdmhwQyttSk5z?=
 =?utf-8?B?bjRHSXNzWFUvQVhOTUMyNWRFYWhoWGxUN2EyMDZwL2lBbnF5UHVCQkZhdHJE?=
 =?utf-8?B?R0k1WlZxS0pYUFh5M1BXKzVNczNKVzZtS0RVZW82NDk0TEMxSWdiU3JkV2Y0?=
 =?utf-8?B?bUs1by9wWkc1bGxjWkVpQ240bHVjQm1QU09tU1k1bWJVb2FHeS9vS2NxY1Rv?=
 =?utf-8?B?bitLZUNaRFhoOGVDb2dpQkVnc0kyMzAxOGRoVU1CVEZJUStsNWFRaXNBM0ZG?=
 =?utf-8?B?RzhaYlBMWjNudXl5dVpJenpRUWo1b29BdlI5dVdnMVNCL0RlOFZ1WDEwMmht?=
 =?utf-8?B?aWhFbmVJMms4WG94K2RrTjNidFY2NnZsMHZJaXE5alRMUU80aWV1bG9WZTZn?=
 =?utf-8?B?TGJyN0xaVkczSTRPdXBqdUJDREd3RHlVeXBhdGMrV0tYQWh2R3NmbTV6NFpi?=
 =?utf-8?B?b2dhVXp2WXUveC93b2xKanlBK0Vpa24yNVY1dDBBY0ZNYUQ3cUJ2U3R3dllB?=
 =?utf-8?B?OFZkeWhkc1JQa0MxaVkybkdyYXc0UEc1cTBkSFcrTXFaVUg1d2c4YWxuOVN5?=
 =?utf-8?B?b01iYkkwa2NOSDZlTXRhTlk0T3lxVTFPYUt6OTk3RmJBSkhTRFlHTTZuamNy?=
 =?utf-8?B?ZTVaTWxVM3RZS3VObHhsMHhDaUVlZ1JEczhKdm1MTHhzb01VblZ1NWRrNHVh?=
 =?utf-8?B?QWwxa0V1MkZHa1pQb1I3WUZzUm9mOGh3RFpMdHk2SEpIU0tmRHRBdkZCdFVE?=
 =?utf-8?B?MzRYTmFyTGkzRStLdTM1YVp6T2RBbGw1UlB0ajJFbUlxT081MGNrSmg5THU4?=
 =?utf-8?B?b2cxRnlFYTdMaU1lelhjRlpCM21VT1Zhc2F1R1hYeCtuYjZWVmtxZjdldWlm?=
 =?utf-8?B?L2toSVkvQ2lTWEN6dS9WQUEzQW5INVBDTkltODZHOEQxUklzblVMLzN3c1or?=
 =?utf-8?B?akR2ZTVPT3Z5K3RmZWx1Y0lwT3A2UTJjUHZOK3Iwdkoya0ZtcHlPSVJtekNj?=
 =?utf-8?B?ZnJGNldhK0E1SEUyN1IwQk9zRmF4ODd1aU1pM04vV3M1QVpkMHNXcmM1SXlx?=
 =?utf-8?B?S1FPZUdTSEJYYVB0Snkrak1uUFAwd1JwY3F1Rm1FUUdybDN4T2ZMaWduQ1l2?=
 =?utf-8?B?eUJvbE1tcWF6VHFOemVTVks5S1JKYXEwV25UUUovbFg3Q1pIYmt2TUU4KzNu?=
 =?utf-8?B?eDIzUUdzMi8rUGkxQnBOUTl5b2hOaThYWHJDS0RSRkQzelZGUTZnaEduTGxr?=
 =?utf-8?B?R2xabDBubGlhckcraHkxbjRCdDRuUEdwY3p4c3drN1RvNGZwalN6S3JYMVBv?=
 =?utf-8?B?VXNST1BseHZMQ3NQNnBWZEhMZVAvdEtQdkhaUXBGeHBZY2hLczVYNDRkcnBV?=
 =?utf-8?B?ZmxOTVZqMFBHeUxvM1IrdmtLWlJKMnBqbVpRamZhczBySHU3Mk9iMzd3aFdM?=
 =?utf-8?B?RnY1SndaTk9FdE9UZWNwUGFJL2VEbGRMNDRWTXcxVzR5M3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXdhS0ZmMmwybHdaaHZZL3JEek1Pd1RZSHlYUkFLWlNKWVNhMEgwL0V6UCtx?=
 =?utf-8?B?dzFTbkxRQTlGbHpGT2FML3pMem91S1pqMFF5UEZ6RElVdWV5dks3VWUwSkd5?=
 =?utf-8?B?MXJRanBtYURESFkwSWorSFFPZUw0ZjNnOVA3ZGI1NkFJcXpyRHRWZkRpdVNx?=
 =?utf-8?B?Znl2Z1NaSHk5L0EvbFYwNGpNb0tWY1dWeXBzMEEzOGkzZDh5Q0UvZkhLSDc5?=
 =?utf-8?B?RER1aE1ZSUt2SXVpRkpnOEFsdG9vKzVmSS9lNmJKb0RGOVFtdWtKM0tYc2tR?=
 =?utf-8?B?MEhTRjRHeTNkZjN0cnhIanZJVGxKTjQrRmlZdWlJQWVYUkJvbVJVS0RiZFFG?=
 =?utf-8?B?VVhmekQ5dlVGaS9Wbk5yL3BycWdaSk5EM0ZGUlhuVkNyakdrcTlHRFhsdUFp?=
 =?utf-8?B?VFVpcWY4QUxhYlRLTnBCN3djTjVCZDhmQ2hONGNFR2Rqd1d1WjA5R3pqTmlZ?=
 =?utf-8?B?c0xLc0pkVGFMUVFHR0U0VExjYzZrZ1U3RjJrY2thN3Z3d3ZtdWRkUk9tck16?=
 =?utf-8?B?VnhhUVhZRXRtNDVIeUpDelAwdE9NcGlvUTNqbnpROW5vNDljeWVaa1hRTGpH?=
 =?utf-8?B?cExYM213N0lKZ1gwazNqVFl5d2paUVdjVGhKT29RZ2V4ZmlHN0pGL0dtNEpt?=
 =?utf-8?B?K1hqUUpLU0w0NGtyRXlOTzN4QklMUlJ2cWRsdFhWRVR4UHZ5MEZQQU5NSks3?=
 =?utf-8?B?bEJDQ2lJOTVBMTBUNkgxWXk1cGoyU1laU2Rmd05CbW95VW8xS25SOVEzODVJ?=
 =?utf-8?B?T0FPMysxWDBDcG5mdE5US09RK1pjSE5CMkNiWlVUMXdWWDdBS0VNV0ZkejUx?=
 =?utf-8?B?UDJ1cFF2Smd0dzRhdkozTjdLTWVUcERrYVdMS2Z6c3MvR1JYWTRtQXdpZ3NP?=
 =?utf-8?B?MENXWlhjYk9oUTNDSGhCaHRPVnE3aVd0bGl6NHhpbmcyelJ2ZGw5Y3lqZU0w?=
 =?utf-8?B?ZUY5azU3U2FMSEZnRHBtekxLU2ZWeW5zTU1Xam90UlorSkpnYW9vNExoVnB2?=
 =?utf-8?B?bWlnK0Y0THhMWWRoOXlDbFNSYzAxQ3pIWkxqd2VMTFkxR3lMWG5TdmY2SEtQ?=
 =?utf-8?B?Zy9OQlRHTVZkZlMrcEpaRU1JUS9LWTJ4bldiRTc1Z3A5KzhaUWJJa21aZThk?=
 =?utf-8?B?dFZCOHMwN1JLVEUrdmMrZnJ6RWJoY0FsQW10UFl1aW1sZ0RCVDNaK25UU3Ji?=
 =?utf-8?B?L05qVDdoekFFcmF6SnJ6SVBORmRBRUFZMlhJMk56T3ZuOFN6WkdVbkdCOTcx?=
 =?utf-8?B?MmVHT05kRnBDS2hqTHF1NlZWV2RzMGtwUDVoNkxMNG9xMUNidXZhL3BrTmdJ?=
 =?utf-8?B?b21LYi9XUkdCcE9YQ3FUVUFoZmp0emo1R3NqTkZxcGxaYThTRndkMEI0Y0Qz?=
 =?utf-8?B?WFBreEI0a2RyTzNpRHY2dk4rTno1dXN6NkYxNnhXR3VrTHV5Q2l3NjExYVEw?=
 =?utf-8?B?UjFvbVF3d2t0ekU5U0RMUEdMT1hSSERjMzg1MnRIUlNCN2hocjc1TDdpaVB2?=
 =?utf-8?B?V0cvY2dHM2I4R25TTGZ3NmY2RWlSZTFGZmcwbmk1aEo4L0lzYUljSS9sRG5x?=
 =?utf-8?B?ZE5qNjYrWTVSamtlYzA0VmRlQjBJbHZ2TE8rMzJBWWR1RkxjZ0JnQWN4RUlh?=
 =?utf-8?B?OWhIRGE5QVltZG1qQVVBR0FMTDRlOGM1NHBCMHBNUXlnV1kvR3F3Skd3UGZI?=
 =?utf-8?B?cU1RQWYzWC9pMEhxcE9Tb1ZCck1Gd3Z5NmJQNnJCVDdYV2FZd0tIQmFRcVZy?=
 =?utf-8?B?YlVOVnlaQ1dhQzhRSlhlVTlrdUdWNjBSVlZEN0p0dlJJekFLNUEzanZ2M1Zk?=
 =?utf-8?B?cGtxMEVxdlRKOGh6eGYyYk1DRGxDcFlneVQvZmZTMEpsREpxM05vck1EcURV?=
 =?utf-8?B?S1BmS29hMm1UdVMrM215ZjdPY2R2aTk4WndYQVg0b0NSVllrMGdDUk4zOWIz?=
 =?utf-8?B?M3k0dWZlMHFPdTlkckdNeWtZdmo4NmVsMHF4Z09NQUVMcHNMNkI0akc5VFZV?=
 =?utf-8?B?OVJlVFczSkp2aE53QkhoRDNYN3loOG9BY2lMMXZJNndLM2JiNnc4cTRTd0lG?=
 =?utf-8?B?ZTlxcmFpR1JYdmxsVWVRdkgyVTJRY3c4L1RuZzlTbFBjZmZ4emxTS1gxb0ZW?=
 =?utf-8?Q?Uow/bDogrNWPVLO04vqAzRx+E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900fc09f-ff3c-4bab-9e34-08dd8726140f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:59:37.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AOdfjG3WbZ6MCSyi67SZU6b//YZ8IlDImf2y1t/ChANCN857/pBuxj65ffUtCSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

On 4/29/25 11:02, Liang, Prike wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, April 28, 2025 10:29 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Yadav, Arvind
>> <Arvind.Yadav@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent read fences
>>
>> On 4/27/25 05:20, Liang, Prike wrote:
>>> [Public]
>>>
>>>> From: Liang, Prike
>>>> Sent: Friday, April 25, 2025 3:44 PM
>>>> To: Yadav, Arvind <Arvind.Yadav@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>
>>>> Subject: RE: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent
>>>> read fences
>>>>
>>>>> From: Yadav, Arvind <Arvind.Yadav@amd.com>
>>>>> Sent: Friday, April 25, 2025 3:21 PM
>>>>> To: Liang, Prike <Prike.Liang@amd.com>;
>>>>> amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
>>>>> Christian <Christian.Koenig@amd.com>
>>>>> Subject: Re: [PATCH 1/3] drm/amdgpu: implicitly sync the dependent
>>>>> read fences
>>>>>
>>>>> This is problem for TLB flush. We should not do this changes. Here
>>>>> we are utilizing DMA_RESV_USAGE_BOOKKEEP due to the TLB flush fence
>>>>> associated with the page table (PT). We are ensuring that no page
>>>>> directory (PD) or page table (PT) should be free before flush and
>>>>> ttm bo release and delete both are also waiting for BOOKKEEP fence.
>>>>> Please drop
>>>> this changes for eviction fence.
>>>> Thanks for sharing the background. So, we may need to test the fence
>>>> whether is an eviction fence in amdgpu_sync_test_fence () before added it to
>> the VM sync.
>>> It looks the TLB flush fence only added to the VM BO reservation and requires a
>> sync at compute VM.
>>
>> The TLB flush fence should always be explicitly synced to by the KFD.
>>
>> Where do you see that it is implicitly synced using the amdgpu_sync objected?
> 
>  >>>>>/* Prepare a TLB flush fence to be attached to PTs */
> ->>>>>>>if (!params->unlocked && vm->is_compute_context) {
> ->>>>>>>->>>>>>>amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
> 
> ->>>>>>>->>>>>>>/* Makes sure no PD/PT is freed before the flush */
> ->>>>>>>->>>>>>>dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
> ->>>>>>>->>>>>>>->>>>>>>->>>>>>>   DMA_RESV_USAGE_BOOKKEEP);
> ->>>>>>>}
> Yes, the TLB flush fence is explicitly sync and the flush should be performed after the dependent PD/PT fence signaled.
> To the Arvind's concern on the TLB flush fence should be handled properly by explicitly syncing the TLB fence, so it's
> ok to promote the implicit sync to the READ fence from the BOOKEEP?

As far as I know yes. The TLB flush fence is only added as BOOKKEEP so that we only wait for it before we free the VM PDs and PTs.

Regards,
Christian.


> 
> Thanks,
> Prike
>> Regards,
>> Christian.
>>
>>> As to the VM reservation sync whether can return and sync to the
>>> DMA_RESV_USAGE_READ, and I will further check it separately with the
>>> eviction fence release. As to the eviction fence sync problem issue, I would like
>> to put exclude the eviction fence sync at amdgpu_sync_test_fence().
>>>
>>> Thanks,
>>> Prike
>>>> Thanks,
>>>> Prike
>>>>> Regards,
>>>>> ~arvind
>>>>>
>>>>> On 4/25/2025 12:37 PM, Prike Liang wrote:
>>>>>> The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP
>>>> usage
>>>>>> fences, so here only return and sync the dependent read fences.
>>>>>>
>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
>>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>>> index 5576ed0b508f..4e1d30ecb6cc 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>>>>>> @@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device
>>>>>> *adev, struct amdgpu_sync *sync,
>>>>>>
>>>>>>           if (resv == NULL)
>>>>>>                   return -EINVAL;
>>>>>> -
>>>>>> - /* TODO: Use DMA_RESV_USAGE_READ here */
>>>>>> - dma_resv_for_each_fence(&cursor, resv,
>>>>> DMA_RESV_USAGE_BOOKKEEP, f) {
>>>>>> + /*Only return and sync the fences of usage <=
>>>>> DMA_RESV_USAGE_READ.*/
>>>>>> + dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f)
>> {
>>>>>>                   dma_fence_chain_for_each(f, f) {
>>>>>>                           struct dma_fence *tmp =
>>>>>> dma_fence_chain_contained(f);
>>>>>>
> 

