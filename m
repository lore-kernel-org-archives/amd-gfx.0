Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B2CCF9EB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 08:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC0210E340;
	Mon, 27 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSxx80FG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A714E10E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 08:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbEs0dsvjbLEzWUvd5y0CWvHtLuHgOX+DYW/96GgWpK3QJQnE4CjNQOpdVnP5qLokTh1Rf1ck8tqkqjDP9aR63ojL3D9dw4SewXVNgygE9x+O/ZZmEwqwLbskRwUMBqnz1zUXsutHMiZpV3vUaQUV7mXv0GbAFMOBSEqDv3eKAlgeNR3Y3/ng4fJE+LyILwXf0oC5x9YpOT+XxGZi5yzSr9Uj6gLFXkGU2jvXW0OtqPXmdmqqFR7k1LJYdK0ImBW6d6QlEwpzRuba0MoVEVpJzNp1Azwonf5irvJ5FupwppK6L57iBawgTHPg2/rgNdvb42/zVu5+wSEDIKo1KMpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBxxss1+G8aNFvm61x44cbspbMv0SA4Wjm95xeuC6U8=;
 b=D+AbGjvyxM0+arUAa+/WnRnTuXYi2Az1u7KYTQHqDDpeFsPNz/aPsGYCT9pfIu87owQMGhDsHHqX9MlKeZxE9QYvBKac6dVqJZEGlm2fdza25efZ6BMrdc/L1/FUzf9PWZuVeCQzICKR1EhL4h8QizgEyZ6PyYT+SvBFgdUbOGQV2gDjFgVi4lVSyOaFQSE1WjdKFx559iPXkJc3Bg68ZkrhDEcmSsbLEjTttB2pQx+skvbF7ZY2PKv1hUtKbKboJq+QiH8WpYt4kcuVyT4wlCFRhdw1bUZ6fR+DPP1qouyrWZqdCLgr5T+DqdeutzbwyXQChTAI7uAzapYu7/ZTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBxxss1+G8aNFvm61x44cbspbMv0SA4Wjm95xeuC6U8=;
 b=VSxx80FGwMOa6yc+wNBnnKdyhf5N2JHxQSgp2uQfWmZCzCB/K5WVm0MZAftYq6qFzdT/++zDHm6kDudnsf8qC9DrO8TkdemgHayWHZ1Yfp0PxaKpN+JAyleNIay5nprKBpMnMw46AQD2jNgls5abuw8kP3x430a+JTU5xR0H7MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:06:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:06:23 +0000
Message-ID: <5378ea6c-b122-4f87-9cdc-980763234258@amd.com>
Date: Mon, 27 Oct 2025 13:36:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu
 v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20251027072757.1267995-1-kevinyang.wang@amd.com>
 <fc5a13a8-12aa-46c9-a660-12ea7e99b3b4@amd.com>
 <46213d03-25e7-4c29-82b8-2c078990f524@amd.com>
 <PH7PR12MB5997017BADC8B6DA24161F8182FCA@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997017BADC8B6DA24161F8182FCA@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0e9736-f987-42fb-3e7c-08de152fb84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUVCaGpQMytOZVlnZ3B4bi9OYVU1TVZPQUZJZmp4Z1lRNjhqUnV6OGMrR1JD?=
 =?utf-8?B?dXd5bjBiYTVsNFFvYXUrNmhPVzF2UGJzV2hsL1lIWGg4S1Zsd0dLNlVLQitM?=
 =?utf-8?B?Q1hDWTJtZ1JJWTBqdXRRSU5pQ2hZV2pBWUlxNjRqOG1JbVAraUk2VENKR2sy?=
 =?utf-8?B?UnoyeHFDL2RZRytkbTB1eEpJTTVhWGxVT29jRlNiYVZxa3piVzBlaDMyZlR3?=
 =?utf-8?B?TGZFd1ZJL2hyTGNDOUJrZ2lTNG9oMldXdnlNZ1NQcHBacU1PcXdoVFRKc1JN?=
 =?utf-8?B?dmF0Z3pEZTRidmppNEM1b2VKdlU5Qm5BNEVLcXJPa3FxbUFBekxaQmluVEF4?=
 =?utf-8?B?aWYxbnROeWUxZnREVTRRZU0yVWVvV2JqUHJMK01DaE5YL3cxM2M2ckIxc0g3?=
 =?utf-8?B?THZFcFVST1lSYWh6MUdXMlc5Y3JoUG1Lbm4ra0Z0RFNvTHpKeDhJeFhNelNS?=
 =?utf-8?B?YnFuVDBEakRuSG5ZVk02SlZDdXdPTjdSOW5aZkdhQm96U2Y0NXJyQ1p4RWw4?=
 =?utf-8?B?elNFMVBSWnY0OG9hRmVkS0ZmMGNaSzZSd3JXL3lpRnlqbWZsb3N2Y2xPTGRR?=
 =?utf-8?B?OFN2Rk5nbll3MnN0Wk5BQSs3RVA2ak9XdU1NRkRIdVl4dmVJWk5Va2dnMjVR?=
 =?utf-8?B?Q2c1NitpUklxV250NTNSQW1idloxWUtmOWRIMmljZFNxRHZjUTAyOGdsL2tB?=
 =?utf-8?B?TExEcGRMbXNhVllISjZhWFhBb2ErZkZmMjlCOUpCZXZ2ZnRBUFd0dmlCNWwv?=
 =?utf-8?B?Y3pTL01sdGhSNmdDV21YY1VaeHcxaE9zbTd6cTFmV09GcnJyUGVvVHg1R3dD?=
 =?utf-8?B?Yi9ZMmMzZWpONE9NVVJpMXpFcjBIbGRsOGpKdzg1TzN2MXB1NWpmd2p0cXR5?=
 =?utf-8?B?WDBXaDJPVy9rNzJSTzZRb2h6cGg5T2x3bGtmcEZkakd5NHRxZVYzcVRlRFov?=
 =?utf-8?B?dGFGWHY2NSs2QVp0STh5MStPWHpqOXAxMHVwWGlNVEdGNjhSdFV0ZWhrM1BU?=
 =?utf-8?B?Y1ZKYVVQV3pZTXg3cEdUT3dESmVlbTNxdExsVVRsSWwxQ2xKeHVYakNuYy9O?=
 =?utf-8?B?R0Z1UlFQM3pYL1VBQmlCeWhtRU1lODVuZFBjbzh2dGloOU9nTXQwLzk4YVJQ?=
 =?utf-8?B?VDN5NTAwOEtOUmFXMU1qRDZGK0oxN09pSDZvYTVqM1pSaElTaUJEdzh4QzNi?=
 =?utf-8?B?dURmVTFBdGlXZHVqbzluRDdxblJOeGJPem1TeFQvZ1dnc28vTGJJSGQ1OUJQ?=
 =?utf-8?B?MVVZb0ZDOTVraGtkWWZsTUVrakV4Y2JnVU8xbG9FWXlTTyt5WEZ6RG5HaCtm?=
 =?utf-8?B?Z0EvSjBKYUZNaFVRVU1mK0h6eTRWN3ZOZGlMaW9zR2ltK1pSb2YwNEtOckNp?=
 =?utf-8?B?MWVjQzc4SW9tZFkwUVlLdVdnSHJUcDB3VEl0WUFqbmN4S1k4NHJSblFwcXgw?=
 =?utf-8?B?UEM4MzhsVTN6SFZoaFQ4RWNBUzU5V21rMklLZGhGVWNSR3N2WlVzOHMzOTdo?=
 =?utf-8?B?bzFCd25DLy9uN1MyTGp6VndHSEx1bC9PRFRKWGtsRzB1TjBjSThiTTJiZ1BZ?=
 =?utf-8?B?bkl6YWRLUThXNU1vbDU3cVBVM1R1VTJKdTZZQ3FIeXYwUEx5ZFJ5a1JSOVdT?=
 =?utf-8?B?WmRDd3p1VzhkRjZBb1hiT2gyUWtXTHkvTTJScS95ZUFobjFOQ0p0UllTeEN1?=
 =?utf-8?B?S1FLWmpVSUFpS2NTVjQ0Zk1OVGFMR01iT1drTmxnekIyTTUzenZPTyt6bDQ2?=
 =?utf-8?B?WXFaYTNnZTR0MWhvNzF1ZCtVdFdFM2pGbWYvRmZZYm91Z01BU0lRN1JaSmpZ?=
 =?utf-8?B?RExPTlpjRWhMbzFOL0tsUkYwdm1WNldpVVA4K1VZOW5zQWh6bnpDYjR0WUw2?=
 =?utf-8?B?ZGlJeXBNS3FGUHRRblBobTFCUG9jaDlWZlE5MnBnTkZWSlVaU2M2T0NhVkt1?=
 =?utf-8?B?TWNiN2ZBK29xb1NqMEY0Tm1SNFRlT3paUjN3bXlMQjR1aE5IQ0xZUXhtdUh1?=
 =?utf-8?B?b1FoK05oQlpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhwdDAvcTczRldSMUJwdFp4NzJMUnJZSTVEcU1ST0gvYkhCdVJtRDhDODhC?=
 =?utf-8?B?SHhFVlY3aE9zVndXS2NQVVA0SWJhaWRoSnZVZUhoQkdHVWlVbk03Z1V3ZVVM?=
 =?utf-8?B?cDJxR1labjh1WjlTOWlCMlp6U2pNbEpuYVgvVXcyTlNlMkpmYVJHcUR4YUpT?=
 =?utf-8?B?aDQzS1Jkc08rd0I0MThMWW00cGpsNmdHWjQ5emcwbWViakdZTGVZSDhzSDc0?=
 =?utf-8?B?YXlkMjZJeGc4ZVVBdDdadnc4VUw5enNUZFZnMWhkWDdiVWxabjJsRmhZTC9X?=
 =?utf-8?B?bmtsbC9WM3A0K3FwejhKUFBtTGJrS1NiUis2TDd5QnljT28xOExSRGh0K0lu?=
 =?utf-8?B?V21OYWNFL002MnAvWmpEcHRCWGwwSUN6MkY3WE4rbGczOXAvODk2SmRUYk1T?=
 =?utf-8?B?S3ZGcUQ4WWVTZElRTjhjNFVudklva3NVYW9YQWF0U2VOQk9qT2liTTJIaGYx?=
 =?utf-8?B?Y2UxOHJ3MUhIT3FMT1ZHOU9YQzEvelZwOWRkNG9QNkR6ajI4cXJjcDk4LzMr?=
 =?utf-8?B?YnhlMzcrdk1XY2tVVkN1aml5RVp0U1MwUG9NeFFuWDlQWTlvajZ6RzIzYUp3?=
 =?utf-8?B?Wkc1ODB6Y2Y5TitDcXE3NWEvWGFxLzRFaDJvOWZIS2VVMmhtUHRjcit4Rktq?=
 =?utf-8?B?Q0psakxRWXY1ZVVXUVpjL3RrZ3hNOWJjOUlxM2hIajBaSzJoeDcyUEhhd1A2?=
 =?utf-8?B?ZG5ZM1B6aVNPbU5HcS9YMEJyME54OWFWNnJENUJoQ3YwQWd5dTFBTVhoOWdT?=
 =?utf-8?B?U2lvc2tjS1llSXVTMy9OOEtNWHhJYzJRNFVmMXRPbFMrM3FZSEJ0VTdoaWw1?=
 =?utf-8?B?cVFSNm85YStqUFhuZ1VndkxiU3l2ZDFyQnFvYWJjWmpYU3AzY1ZZOG5GVHBE?=
 =?utf-8?B?MFBscXlkaldKaTZEdjB2N2VOMTVQQVpXNXd6ZmtJRnFSVlI4VzBZQVNnd3p4?=
 =?utf-8?B?RGJ6Y3pGeWROeWpJUTlOZUFpVEZ2MStkazhMZjhoTjNWUTUyTnA5Z1p6eFlF?=
 =?utf-8?B?eUNnUnRuLzF6SkFWa01CNm93cFNRUGdmNW5RN2RUeEhUajI5RVd6SXFLN0JX?=
 =?utf-8?B?VllrQzliQU15VXZSKy8rdzRBRHlDZWt0MElycUdHcGdCTnJGeGJRT2FFbGda?=
 =?utf-8?B?Y0Yrb2N2bzJGZEY3ZzJEOSt1V0ZocU8zbVFqWjM3VGJvTFRjcWM5c3BWMWtE?=
 =?utf-8?B?aERLMmkxeFBHMjVmSXpjR095d09qMkV1OFlJTGdDR25zZ2tqSWJBMUN5YVFx?=
 =?utf-8?B?ME9TMHBFK28wRnJudWc3Mm9pNU4xc25lVDRYZDVXM3VqVS9yR3BJbURVbUpR?=
 =?utf-8?B?Y2ZnbEZUbW9lQ1pxQVJTb3lVQU1uWm5HbzZqY3A5bjBabU9GUHNYd1BPbVR5?=
 =?utf-8?B?SVlOZmZ6UDRSVjRuRGYzenpROW5hakYxY2dGc05tc3RqOUZ3eWptZ0RKRExB?=
 =?utf-8?B?ZjRDaTlpRWxienVqc3Rnay9iY1RDK0FkZWpFUWpNanZsVlZRZXRQd2Vpc2lE?=
 =?utf-8?B?bnl6NEZnbEhvd3R0NlNVeFk2Z1NRaGE0TlZ3Vm85L2hLQUdMbEtoMEplOW5D?=
 =?utf-8?B?c3pic1N0cFIxeW1vRmlCd1VUMHJ5Q2d3cGJDWG5zbTgxYjJsZTVhT3A5clA0?=
 =?utf-8?B?d21ueE9BcnVmdlN2VEpxVUZYclE5a25tMmlFVFZNTHljT3VueFlaZkhVdkV4?=
 =?utf-8?B?bHoxWnpEdktlTXkvMUJQd1pxZVJEY1VjbzJBd215OVZhMS9wME1odjYrY1pw?=
 =?utf-8?B?Y0xncGYrYmZMaG9Pc0xhaVplSDN0QkRHSTlVcVNTaURmSXllRWRsM28xc2h1?=
 =?utf-8?B?dEd4SmJCZ3RhMm1FWnRrN3BDWWd1dXlSR2FrMllsRGFUWExzWXRBNVBIdDZJ?=
 =?utf-8?B?NjBUdmpLYlArMEJnSmlQSmpaUWx1SzVxaEppQVpST004QStqQ2FjSkY4cFEx?=
 =?utf-8?B?NEVRSHZRVytjZjN5bGpOQ3ZnMlBFNHp4L1FvWUhYdlM0VUNsU3Q3aldLN040?=
 =?utf-8?B?c0grNDk1ejNreXhwMlp4QUNBTTNnVzVYYXhPWVlZWjB1aGZVZTNZVTBLTTBM?=
 =?utf-8?B?SC96M010aUlTZkVCTm9td2dtckpGUDlyUEJlUHlsaFAxYkRsVllvNldNcFpP?=
 =?utf-8?Q?woekK6//qNEQwLOO4Ol+1W8nA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0e9736-f987-42fb-3e7c-08de152fb84f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:06:23.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xknj83jyDMAYC1+pl2M6rlhbBCyWVxfYyLP0mMmt0FIXZoF7nARMK2UbY7tKR9lJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619
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



On 10/27/2025 1:26 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>>> Probably the fix needs to be in smu_v13_0_6_print_clks?
> 
> I would like to keep the current code design where there are centralized exit points for called functions to match the kernel coding style requirement..
> 
> https://www.kernel.org/doc/html/v6.16/process/coding-style.html
> 7) Centralized exiting of functions
> 

Not seeing a case for cleanup or multiple unwind steps in common exit 
point.

Anyway, if you prefer to keep this style, below one also needs a fix 
inside smu_v13_0_6_print_clks()

         if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD) {
                 size = sysfs_emit_at(buf, size, "S: %uMhz *\n", curr_clk);


Thanks,
Lijo

> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, October 27, 2025 15:46
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu v13.0.6
> 
> 
> 
> On 10/27/2025 1:13 PM, Lazar, Lijo wrote:
>>
>>
>> On 10/27/2025 12:57 PM, Yang Wang wrote:
>>> the smu v13.0.6 driver should handle return value of
>>> smu_v13_0_6_print_clks()
>>> to avoid null pointer issue.
>>>
>>> Fixes: 0354cd650daa ("drm/amd/pm: Avoid writing nulls into
>>> `pp_od_clk_voltage`")
>>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 41
>>> ++++++++++++++-----
>>>    1 file changed, 31 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/
>>> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> index 39ae6701147c..22fe4d3508fd 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>>> @@ -1514,9 +1514,14 @@ static int smu_v13_0_6_print_clk_levels(struct
>>> smu_context *smu,
>>>            single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>>> -        return smu_v13_0_6_print_clks(smu, buf, size,
>>> single_dpm_table,
>>> -                          now, "mclk");
>>> +        ret = smu_v13_0_6_print_clks(smu, buf, size,
>>> +single_dpm_table,
>>> +                         now, "mclk");
>>
>> Probably the fix needs to be in smu_v13_0_6_print_clks?
>>
>>
>>                           size += sysfs_emit_at(buf, size, "%d: %uMhz
>> %s\n", i,
>>                                                 clk1, (level == i) ?
>> "*" : "");
>>
>> 'size += to size =' so that it returns only the total size emitted by
>> the function.
>>
> 
> Never mind, this is not going to work. The function may return the total size it emitted, or it also needs to adjust the below condition.
> 
> Thanks,
> Lijo
> 
>> That is the case for this condition now -
>>
>> if (curr_clk < SMU_13_0_6_DSCLK_THRESHOLD)
>>
>> Thanks,
>> Lijo
>>
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        size += ret;
>>> +        break;
>>>        case SMU_SOCCLK:
>>>            ret = smu_v13_0_6_get_current_clk_freq_by_table(smu,
>>> SMU_SOCCLK,
>>>                                    &now); @@ -1528,9 +1533,13 @@
>>> static int smu_v13_0_6_print_clk_levels(struct
>>> smu_context *smu,
>>>            single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>>> -        return smu_v13_0_6_print_clks(smu, buf, size,
>>> single_dpm_table,
>>> -                          now, "socclk");
>>> +        ret = smu_v13_0_6_print_clks(smu, buf, size,
>>> +single_dpm_table,
>>> +                         now, "socclk");
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        size += ret;
>>> +        break;
>>>        case SMU_FCLK:
>>>            ret = smu_v13_0_6_get_current_clk_freq_by_table(smu,
>>> SMU_FCLK,
>>>                                    &now); @@ -1542,9 +1551,13 @@
>>> static int smu_v13_0_6_print_clk_levels(struct
>>> smu_context *smu,
>>>            single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>>> -        return smu_v13_0_6_print_clks(smu, buf, size,
>>> single_dpm_table,
>>> -                          now, "fclk");
>>> +        ret = smu_v13_0_6_print_clks(smu, buf, size,
>>> +single_dpm_table,
>>> +                         now, "fclk");
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        size += ret;
>>> +        break;
>>>        case SMU_VCLK:
>>>            ret = smu_v13_0_6_get_current_clk_freq_by_table(smu,
>>> SMU_VCLK,
>>>                                    &now); @@ -1556,9 +1569,13 @@
>>> static int smu_v13_0_6_print_clk_levels(struct
>>> smu_context *smu,
>>>            single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>>> -        return smu_v13_0_6_print_clks(smu, buf, size,
>>> single_dpm_table,
>>> -                          now, "vclk");
>>> +        ret = smu_v13_0_6_print_clks(smu, buf, size,
>>> +single_dpm_table,
>>> +                         now, "vclk");
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        size += ret;
>>> +        break;
>>>        case SMU_DCLK:
>>>            ret = smu_v13_0_6_get_current_clk_freq_by_table(smu,
>>> SMU_DCLK,
>>>                                       &now); @@ -1570,9 +1587,13 @@
>>> static int smu_v13_0_6_print_clk_levels(struct
>>> smu_context *smu,
>>>            single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>>> -        return smu_v13_0_6_print_clks(smu, buf, size,
>>> single_dpm_table,
>>> -                          now, "dclk");
>>> +        ret = smu_v13_0_6_print_clks(smu, buf, size,
>>> +single_dpm_table,
>>> +                         now, "dclk");
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        size += ret;
>>> +        break;
>>>        default:
>>>            break;
>>>        }
>>
> 

