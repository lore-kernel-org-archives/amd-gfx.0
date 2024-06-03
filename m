Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36F1C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 10:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CE310E0C2;
	Mon,  3 Jun 2024 10:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H9kpGqr9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C54310E0C2
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 10:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP5AXHq86rTB6Ld11uAxu9IqV2pTOwdXY8wswxZsfLiThg3ErKvkNo/Dk12y3XvPz937oduylyOJX6zr3b1brn9yNIyUbTqjTgRSlFTUGIAjGg8pw7uNTCOKHLy0zF9+uLRsF3WeHgCXT2yuCztxmqUbrzWSPLLY3szWjW0Bok3JCdNygtu+ErAO8UADX71UvCN+RoJXNjJujLKIo43Lr+CRwAGowanyUNl5fdSyXzMZm3QdEzGeRdyzGu8y0U/o6QBL6Ao8oRv2kH+QtD1k+KtQGPDL9uzPaK3QHnq/fcG2eN4SsYdFaEqMsHH36+IrSVhq1bTT5gUao2TMcfYLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkqttRPDA8JvXSBa/RQENWVLaEgLvLr2XOZQN7uB8ek=;
 b=YskAj1E8ljLpY+xHdFvSYarZa22GP7RZPGUnDaaAHoRRAozpK6CAnNYCYgcB3X8OnbS9RuY9zhhbwYEqeWXIOwGTR/7+56MaM/OQ0Oqx++5377zrTxW57tx4c5HKERIgDi9CTtQPniMlpPtw6US5/e1LoE4YVQKs8as4q19GcoXkkxdXtma8O3wbp7ZyJDZ4z47y1JwmM4a/WYM4wI6KhzC6tpjdEgZA2xtqxUXZqif0JOFL/DyF056grTAKACD1jl7y4FPckCqSSo9iHPl579BSKyZ3bTYKbbCznsfD8NrsLg43vM9PZr56Wozagfbe81VbADxzPBX6vNClzF8YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkqttRPDA8JvXSBa/RQENWVLaEgLvLr2XOZQN7uB8ek=;
 b=H9kpGqr9AK98ogcvrtGNme3G6vQVEBjH2G3aoqD9eSlMTK/XfVLvpevNJ6wwaokiNnmhgMVfl8iYrNXI+N13syJci0SLEBcjms0IprI3fRNrINNPQiHR2K30Gt3Hj0ha4ht2a+1mGHBsx22E6JS3jk0ZmM9nwjG/Ifc1a6vC14s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 10:58:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 10:58:48 +0000
Message-ID: <380c4bd1-ab50-4f42-bb50-69dc0fbd28fe@amd.com>
Date: Mon, 3 Jun 2024 12:58:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xiao, Hua" <Hua.Xiao@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
 <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
 <CH0PR12MB53721A7C3403982035E48639F4FC2@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CH0PR12MB53721A7C3403982035E48639F4FC2@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: cf879a48-2683-4880-21bd-08dc83bc251c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW1mSXZoeXB0UmhLQkNtOFQ0T1Z4amUzMkR2NWxPUVlXZk1wRGxjU1l1amZo?=
 =?utf-8?B?am5wclhWbHlNY3pQY3REYjdYWnVJVkdwdUxmK1d6NkFJQk9KeFBwVTIzRVNL?=
 =?utf-8?B?dzB6cS9jSUdWRTh0bTg5R2JTcTdmYko2blF4a0RsaFBFTFh2OUZkeXVwNlZz?=
 =?utf-8?B?ckpiVElUWEQza09CL0RZeUo2ckRuRTgvc081S3lJN0ZsWGZsM2tHU0xJdFM3?=
 =?utf-8?B?SCtIaDE1eGlnYk91bzVjOE5YM0ZBQlFubitySXJTK1hBSERxcXdwWGtJNGdj?=
 =?utf-8?B?ajQvUHlMUmpmNWU5WmlVeHFvdllxOXNkT3pRYUJmbHZGZWtYYy8rLzFMemUx?=
 =?utf-8?B?TmQ1dTdqWStuTTF6Z1VQb0h3Sk04aGY3VXJIZ0V6TDRFeHUwSlpoUGdOcmFj?=
 =?utf-8?B?RkR3aHpIMUphMkxzVWt4OFZtMXcvOTE4WHNFQ24rVHd3Rm9Nc3BtZVp2VUhH?=
 =?utf-8?B?SExEdkJSVCtMc2lEVFdKWHNGWmFWOXZKbmJLOWJWbldPM3pQK0hkQ0Q5S1Jw?=
 =?utf-8?B?Rkt3bzFFVHFFUVU0Q1ZITm5MemFMSGxjMkUwVmNlc1hrUXZwa1k0bitXUGMw?=
 =?utf-8?B?eHhTeVdPMVlDc1k1cVdUYk1zblM1c0U1eUd5d090VW0xQ0RmZ1J0ZXFEaENm?=
 =?utf-8?B?Wk1hYjE5djhla24zaE15YzFneG8vOTI1VlU5ckFiSVJjZlFoUkRxTThGeHN6?=
 =?utf-8?B?Z0pHZXp3UHN3TWZzSE1kd3ZtcWRHazBWd250aVJGb3BiR2hwd0hIc0dVQWhT?=
 =?utf-8?B?d2xBRjBYMEdkV3lqYm8xbVhJNXp4TUp3Qzl0Tk85cDE3ZEd0ZkFsMmNab2xj?=
 =?utf-8?B?VFFzekV0WkZ5RFhVNEVkTFB4RzJoVTU3dDJPUitKZk44aDhhNWNTd1pkYXNQ?=
 =?utf-8?B?RjFFYVV6MkRwVzR0TTZDeDRYZkJldVJoQTl4TlI0ekR1K1Q0RXB2Q3VraDBz?=
 =?utf-8?B?aXBZY3c5d0hZbjRPQzJUS2MrSjg5SkdaRVlxTWtZa0VtZmM5NDVMbjVMRmtE?=
 =?utf-8?B?RTFYamRKVkhsRlY0STFLd2V4TFZJSUFyYVA2Q3hrbFNINGdhdFJMYS9uWndG?=
 =?utf-8?B?OEVMcVdGK2VMV3RCNGY5ck1YMUZTa2hJMFpHL2lxR1FDNmxiTzBXdnRKSjRI?=
 =?utf-8?B?WklMcGVXSEtDMnRNc2hBYmIwNU5CSmhKSGgyVk1WMXFCaVBmMlhlV2xhbW1z?=
 =?utf-8?B?K2Q1V1pYNGVsaEdFaGdHLzVoQmpPd0owUkZCcWcvT3c3M0xET1doMThxdlgw?=
 =?utf-8?B?MmhsQmNMekFCeWUxRnd3OWtiQUF5aEU0ckViT3JEbnZxVExPWU1VWkdiM2hI?=
 =?utf-8?B?L1RpNEtBZ0RtYWx5aHdNSWpVZmo1STE2OXlCdkwvRGgxZUtUeGRjQ1lWR0tS?=
 =?utf-8?B?NC9aemQ1SUJMakZGQ0hBQmJTbzRzejI3UGZQTGdaL2VpRWNiVldwWVZObDJJ?=
 =?utf-8?B?ZWt0NzlTZ29WSGNzMFVyUVhFc1hoTCtRbXdJTjMrRnB6Z3l2UUd0TVVyQlRr?=
 =?utf-8?B?MzBXUlgva0FPd051N3pDOGlYc2xyOWNjL05odDVPV2lCWVV6ZnpycnBKcDMr?=
 =?utf-8?B?NDd5L25qQlRqVnpVYzZLZXJJZ0tHQUdjazN3eVFFdzlzOS9TMGw1c2NpMUVr?=
 =?utf-8?B?dDF0enZPY0Q5bzVWemNLcGVTeExoY3BrYTJHTnFTM0JibVdCUyt4eE0rYVBE?=
 =?utf-8?B?Ky9iTGJNUjNzWVFVZkRCcGJaenYrUGpLZTBrNHU2dUttOFNMNS9wNkRhUWJ6?=
 =?utf-8?Q?yKqysUoQxLBrYb6ffNqOBzCXdYnEA3j2EvTOpj+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lnT2h2OFZHOGdIMEhmTno5eUk3T0F6cHJhMXpER09VTXJveHFuZDhFSlg2?=
 =?utf-8?B?RkJoeWZQenVxL2VzOUQ1R3BlanJCOW5HdkFRODFhamZmZFBTaW1NYldwbzlw?=
 =?utf-8?B?VVpDZHVEeVhld2dMdUNIV2tEYmRWZzVWcHY5VkJtcisvM1RTNGdHckgxaEpD?=
 =?utf-8?B?SDdMbGxweDVJUTMwNS8xS2hDMEJJTzVDS0MySytQUlVOdXZodnFUcjIwcUV1?=
 =?utf-8?B?QzA3YXJNSXl2aXBQdjR0Ym5RN3VhN3ptRzhQcDJxQUZQMGxHRDFOeElxYThE?=
 =?utf-8?B?OGp1K254K205cHdBU3lGRUxZdS9tWEVTeCsweG93WGFjMVFIRG5OVnlURWNM?=
 =?utf-8?B?ODlBdjRZcWFmdnMzR1JYaGxOR1pCeUREUU9oTkZtaEdDRVJWSkhZcUxNNFZV?=
 =?utf-8?B?ZkFrT0VjT2g1UDVjaHRVejVnMG5RMVB5aUlNWDNBOG1qL0lmNHlVdDMwRnF4?=
 =?utf-8?B?SFhnWXhJVGVnUjgzQlRsK1YzK2ZuUXJLY2hHT0VjNHIwRzU4Vy92V25TdUNo?=
 =?utf-8?B?Rnl5dlBpcUZNUVB6SDhQejR0R3dJSnBGZW5hbEZPZUlDeEo1STNFNWIrOEwy?=
 =?utf-8?B?YkFLZ3FUdXlkbmdKclhLeWNnQXNzaVN6QmNyRHljY28wNDV6WjdLdCtKM29p?=
 =?utf-8?B?UG1wMXlNLzhsV1FLdDVGYS9YMkx6ekllY3dNelZKdWVoaG1JTWpyTXpncnIz?=
 =?utf-8?B?K2wwUU1qbWhMYWp1QVBUcDBINHNnNTlNVHFTbDFGYTJOaVN3Q2FwbHNUdlpS?=
 =?utf-8?B?VjJ6ODBkSGJnTlVDdGRNNjM2Q3dTZEkvVStGeHFKck5ucXhsSlFjcEtVdm5N?=
 =?utf-8?B?V2xZdnV6Rzl6NDJmTEFqaGJpYkhYSHFISFV3MEt1c3VvUC8wNExqenZiSXNS?=
 =?utf-8?B?eWEzK0lpL3V3Vm1nR290Rm05MlN6NHVMV3k3dHRoYXN4UHVPY3llNEhNWVBo?=
 =?utf-8?B?MUQ1NEZOQUVhQU9KdTQxYm1KaDZXeStXOFlQbUZNdGV2M3UyMVNuYm05c1RZ?=
 =?utf-8?B?YytUVjd4SkwvSVZRaTdWQ1dxNWdNZzZxNkVMOC9ZYzNZQkdsZlRuMXhXNkRJ?=
 =?utf-8?B?azdVZWtUeW1Cd0tuY0dXVGsrMnVjdGI3V1cxVS9LU01pZGFzUkRGU2NWVFY5?=
 =?utf-8?B?SkNuRkNZbHZVQzNHZjlTbUdxelZ4QjVNQ29jSXIrNXpHYjBaSkU5ZDcvZVls?=
 =?utf-8?B?ZFBIMFgrNDhLMDFwaVNjQmRBbWRPUjlLSkJYTW9hNTg5NDhGVHdiMjgrMCtQ?=
 =?utf-8?B?bHNXMmZEQ3ZXdVF4UGtvZ1l2RU5LQzhORnJiYmVKNnhBdHF2Q1QrSTNtemtR?=
 =?utf-8?B?QjhuaThvaGZlaWVuZHhGeGRoV1I5S21icVhMd211akNzM29ueGpzUWNMaThY?=
 =?utf-8?B?V01ZWWxpMG5wampGelVEdXRFYi9BTU1VbVJMT08wR1dKeXp4ejd3ZFIzT1NT?=
 =?utf-8?B?NFl4WXo0QTZqUTRicmFESHlPWmQ2Zi9uYm9HRzU1RGJmZGpFOGJnaldkWVVW?=
 =?utf-8?B?cmFXbVQ3WmFBQ0d6UjhWZkp4dG85TDh2aWR5SUhOQkxaT0V5NDFORk5OdEtY?=
 =?utf-8?B?MjhWbit6YVhZeHhGVk5Ucy9kL21XTGkrWUhsdjFIeENGR3hPay83MnMvSTZD?=
 =?utf-8?B?RDFwNTQyTEllVzgrNU5CcWJKTmk3Zmp2ZHNTM0haUjIwanVnc1YyVDdiU3VL?=
 =?utf-8?B?NUZLejA3cDZxNWpXblJISHkxcGI3UDR6YlJ1bmRvVXNSMTRKZ3g5Ti9OcmVM?=
 =?utf-8?B?cHhBMXEvR0I3RFZBcTVmWkVrWmhySTFCVlcyZnhFR2FBOXNBWUNXd0pvcUFR?=
 =?utf-8?B?OUpvSXhzODdHQlJ3V204WTRxcE41UThDbjJKVDNtNFdsRU9DOU9PZHh1M08w?=
 =?utf-8?B?NHdZclRJK3N3ajdXemh3VTVUSHc4d2JjVjBVaTNFNEhUcDRqSVpxb3lCN29C?=
 =?utf-8?B?UktVakpGU1NCdzlHUUl2aG1ERi9EK0FoRk1QL0hMZWo4cWdsNzZEaTV3NHQ4?=
 =?utf-8?B?N1FVdTlDYzJTL0taZWdOTCtxcnE2RXFTUStwT3U4WmNxSWFBdklGbzRER2sz?=
 =?utf-8?B?TklHNjYxOFNwenA0TFp1R2NjUHJFMEJvTnZ0cTdCOWo3cWl1QUwvcVlkWjlu?=
 =?utf-8?Q?p/JZEbLTMThXsNl37f0zuN3qS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf879a48-2683-4880-21bd-08dc83bc251c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:58:48.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ALdmgGNGi1atk6Pwb6Cjtica66n5UNxSmiiIIrDiG9GrJO5CymrFmd5TcHa0fSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

Hi Shaoyun,

yes my thinking goes into the same direction. The basic problem here is 
that we are trying to stuff two different information into the same 
variable.

The first information is if the commands haven been read by the MES from 
the ring buffer. This information is necessary for the normal ring 
buffer and reset handling, e.g. prevents ring buffer overflow, ordering 
of command, lockups during reset etc...

The second information is if a certain operation was successfully or 
not. For example this is necessary to get signaled back if y queue 
map/unmap operation has been successfully or if the CP not responding or 
any other error has happened etc...

Another issue is that while it is in general a good idea to have the 
firmware work in a way where errors are reported instead of completely 
stopping all processing, here we run into trouble because the driver 
usually assumes that work can be scheduled on the ring buffer and a 
subsequent work is processed only when everything previously submitted 
has completed successfully.

So as initial fix for the issue we see I've send Alex a patch on Friday 
to partially revert his change to use an individual writeback for each 
submission. Instead we will submit an addition QUERY_STATUS command 
after the real command and let that one write fence value. This way the 
fence value is always written, independent of the result of the operation.

Additional to that we need to insert something like a dependency between 
submissions, e.g. when you have commands A, B and C on the ring and C 
can only execute when A was successfully then we need to somehow tell 
that the MES. Only other alternative is to not scheduler commands behind 
each other on the ring and that in turn is a bad idea from the 
performance point of view.

Regards,
Christian.

Am 31.05.24 um 16:44 schrieb Liu, Shaoyun:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi, Christian
>
> I think we have a discussion about this before . Alex also have a change that allow driver to use different write back address for the fence for each submission for the  original issue .
>  From MES  point of view ,  MES will update the fence when the API can be complete successfully, so if the  API (ex . remove_queue) fails  due to  other component issue (ex , CP hang), the  MES will not update the fence In this situation , but  MES itself still works and can respond to other commands (ex ,,read_reg)  .  Alex's change allow driver to check the fence for each API without mess around them  .  If you expect MES to stop responding  to further commands  after one API fails , that will introduce combability issue since this design already exist on products for customer and MES also need to works for windows .  Also MES  always need to respond to  some commands like  RESET  etc  that might make things worse if we need to change the logic .
>
> One possible solution is MES can  trigger an Interrupt  to indicate which submission has failed with the seq number . In this case driver can get the  failure of the  submission to MES in time and  make its own decision for what to do next , What do you think about this ?
>
> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
> Sent: Wednesday, May 29, 2024 11:19 AM
> To: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
>
> Am 29.05.24 um 16:48 schrieb Li, Yunxiang (Teddy):
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> Yeah, I know. That's one of the reason I've pointed out on the patch
>>> adding that that this behavior is actually completely broken.
>>>
>>> If you run into issues with the MES because of this then please
>>> suggest a revert of that patch.
>> I think it just need to be improved to allow this force-signal behavior. The current behavior is slow/inconvenient, but the old behavior is wrong. Since MES will continue process submissions even when one submission failed. So with just one fence location there's no way to tell if a command failed or not.
> No the MES behavior is broken. When a submission failed it should stop processing or signal that the operation didn't completed through some other mechanism.
>
> Just not writing the fence and continuing results in tons of problems, from the TLB fence all the way to the ring buffer and reset handling.
>
> This is a hard requirement and really can't be changed.
>
> Regards,
> Christian.

