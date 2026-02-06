Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28F1EE20A2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A74C10E616;
	Fri,  6 Feb 2026 13:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mP2V+GMs";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581B810E616
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1UrSeW+wu+fEViopYio8OoKH/W2P9xCDp7W67Lvpsr2uXBXilQNWGsvMUpzPAKnEnng/PTc04Ncxou3Ma0WL+7ZbPM42jHvQxteqVkIIj1aWWf9B3wZ074lpNXkr8NlOkY+BzsQNAe/hasm4AE7/ttc+OPfXtiDOi2kIG9IZJsvBqTW4QYFD/QT4XIbStTpRwSwWwQqO78ZU+lkF115SLSPUmrm9X+RZd7Ms/WOfuHdJi6yKWw8luYeknzeOs+wo4iOXad99wEFir91HzpBFAS2a6FsyqGFUvMKxCTmAe3DkgKisVQQ705GoWKyfL1wWFQGTeAp1Qh9UcUsltMhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LvaHx8ZdL2/7nTwqIWdkxZQabrw+EHceoqRjzXWcGk=;
 b=pg1wzeY23k3Dl5q6fp4yghpfu3JQJhDbN1jY28AgelcyLjI7PXc7JYI3VLpmLjGBDE1qRiZb8ApnVF+4ZYHz9UklTvRccQfQ+/hWU4z1JNsCXwaZG2rGj3Yfgjo6fGbmf6wi7Naq9iTtYWBmI0uKd/FAQ4dBH2RZByB8Z+MDca4EeTU+cjBXeMP4mrQCujdSiyjNz5kE8G8KqrHudEIT+HwFZ+6dzA4O8Q/xZM7hA0iq5nTxs7KJp7dKRh+rgEQREUJK9d9mKMA1jZj/87Bf2FA0+JmLsbnJf0R+NZS5FBG9D0N4xFViCEc+YbxkxaUoQssCZtT+cFof2Ai6tPqE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LvaHx8ZdL2/7nTwqIWdkxZQabrw+EHceoqRjzXWcGk=;
 b=mP2V+GMsyrr6D3l/4xFplqdX55MWMYYMa7KuORq4p0lEdc/yc+3E8koJnx2BqM42unbF9v/p7Okg2AFLB6dFI6tJJU8GM4n6Y9iwA9k+ztfeUGJZl/Z0kgJ5GxL2HUKwtk0qFD7Pt69fpmFWTulUFDXziGvXpF9wQW6qDXPd24A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 13:20:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:20:23 +0000
Message-ID: <1e111da4-f289-447f-9362-29dbeb05a655@amd.com>
Date: Fri, 6 Feb 2026 18:50:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] drm/amdgpu: Fix set_default_dpm_tables
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
 <20260206112449.45381-5-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206112449.45381-5-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dddd63-ed74-4131-fc34-08de65827bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q25RR25veEwrS2YxaWVhejlJMmI2SkVLY1NvVWpYSzJpam40NHBHYTA5eGE1?=
 =?utf-8?B?dFBjbWwreXhmbitpZXdoRk93MGhsSlFPUmg5Z1NGdGlwL0FmbEs5RmlLR2Zk?=
 =?utf-8?B?eG9lSzVLSlRjSGtXMGhCaEU0b25FRzNKYmp3YW1NanVJSXRNbTIvd0hCUThB?=
 =?utf-8?B?RzlPTmx3UklIdWlYbi93dUhDRGFJd1QyNytvSnZIZC81bkk4ZmZ0MUFzSm9D?=
 =?utf-8?B?dlhaQ3N5dWUzakw3aEY5Vy80djlwQnBGdVdiUUVpb0dxMmF2Qzl4NGNDdWo2?=
 =?utf-8?B?VHNLcGxYNDlBc3FqMjFxMEFqUHF6OWFLN1pMZFJiZ0wxUmJMem9HU1VKWlNI?=
 =?utf-8?B?SDU5TE5TWURrdk5hLzZpd0RXQTdoNHNIcFFtVElXYjQ3aXhwTUFvV0srT0o2?=
 =?utf-8?B?bWovNVZTMDZMeGRhQVNkN2NndGFDZ09QNnFtZmNqNUMzV1hRRzRTM1RtSnAx?=
 =?utf-8?B?aTdDS25kZVh5R2Z5R3hLWnVCbTRNUjRyVTF6SXoyYTFmcWU4b1A5L3R5OFFE?=
 =?utf-8?B?dlU3a3BoSjVWUldpcmlveVNDbUFtWVZNVGxXZ1duR0ROUk9keE11Mzh2OEpx?=
 =?utf-8?B?aDIxK3VFeDNIYm1rKzNBcmFuYmpuYWRFRWN4VFZ5bkpnaHBjajNKd2NKei9J?=
 =?utf-8?B?UmRHN0VVTXh4NW9OSForSzV1OW5DRGdwUFlHOCs3NlVNU3c5K3habFFuU1Nk?=
 =?utf-8?B?cjVZeE1hYTJnWHhMQWNCd0tNZ3BYNHB5eGczaXQ2dWdtV3lYMkZxS2JlS3E2?=
 =?utf-8?B?VFhHTnFZUFQ2bC9kaXU3VzNNMTNPMVF5M1lSL1NVY01pZnBoTGdZdGFWeEpZ?=
 =?utf-8?B?UHFEWjB0Vk5vYUNUa3JCQy9sTjJHa0x1YUlab00wdVVqcG00N1JOK2tqMEdB?=
 =?utf-8?B?eWNXUERCYnVxRTJoVy96ckV6enlEQ2pzNitFVjZtUW02WTdpU3NqYkg5akdI?=
 =?utf-8?B?R1MxTU9vZUFNcVhvSTRmV1JOcDg4bHBaV3ZYZU5CYzhhQW5wWTZPSktQUXUx?=
 =?utf-8?B?c3VxdEVmVHlRdG9Hci9xZHNhc09kOUY5MVlNRUF3RzBYWXFKWG96TU4yVXBy?=
 =?utf-8?B?SmUvZGJQZjROSmVtbHhWVXFmVEJiemRUZ01BNldnckZ3VXhVZC9JYy8zZXI5?=
 =?utf-8?B?eDY0LytTdWQ5MHdnUHlCdHZwM1ZTejdtK2FMNElyLzBrYzgrZU5jYVdxWWhK?=
 =?utf-8?B?aG92THNsNEhlMXp2VTBHSVZRVGNRUkhncUNITi9rbWdNN2VsUTQxbWxUNmhi?=
 =?utf-8?B?YjEyZ0d6VlVyWEdqbzJTeVJEVnArSmtNL1Y1WmxLR0F6RHdocVRHL2ZHRUxJ?=
 =?utf-8?B?MUt5Q3BRWjlMOHBQOEQwVVFrZHlqSWpkT245NkRtdXFrcDBzME1vR00rdmxQ?=
 =?utf-8?B?eHNwYytabm9RM0QyNXZCSC83Z0c2d2Y0TjBVcm5UYlJCMUtrT3M3YVE0czAr?=
 =?utf-8?B?cEdJTWNFYStSelgrcWtma1dOTDdqeUtjd2s4UGd3RWJaK3NUdlFzSko0bkgw?=
 =?utf-8?B?YWNsMC80SXhPTmZ2NkM5YWlnOG1KNHBaaWorNStHQS8xMXdjNEZqZGp0Wm1N?=
 =?utf-8?B?WC9pMXBnNFhpa29ZSFgyaVBuSjVFcUFJY2lQN3gxYnRFMFZUSnR5c21oQ25V?=
 =?utf-8?B?NVBoQlkvbHZiTnVGL2NCOHltVGswR0diV0dGTjh6UGdJV0U1QWgvMzBVTWMv?=
 =?utf-8?B?UDAzRjFiRVFacXFpWjFmdkVmOEZQZ0QyUHZEMmd6QzdYMnF4Ny8wUmhQaXdp?=
 =?utf-8?B?S295bHQxdllEalk0d1ZjVU52K0szQndkazhaNldzTHF5V1pxK0p4YzRmNFdT?=
 =?utf-8?B?QWR5L05PdVFxcG5YTzhqdzhidG1CdWpxOVdsZTExM3lEMUdUVmZNQWJHVmlU?=
 =?utf-8?B?WkpnZ3llazRMWHFxMWRtc2JSQnZMRGcrOHRmK0xVK1dsR3p4OWg5OVNJQ1Bn?=
 =?utf-8?B?UjRRMDEydnBOelh2Uzk3b283d1RBR0VMcFhhcUlYMDY5amd5QXgrVllzR0Rj?=
 =?utf-8?B?OWttSlFSbmVOQkRCVmVZb2xaamVsL29OWEcrOW1kOW9qRmVGWWpFSnQ4NHN0?=
 =?utf-8?B?ZUwyR2VsMkJ2WFJpYWhHL2JWQmY0SUpyeS92TjZjb2YyZ042Szg5VUIwekVr?=
 =?utf-8?Q?77xI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xUdFZqaVZXdTRYczdIYStlWmt3Q3NaN1piWC9lY3Z0YUJIWFdKSm54T2FG?=
 =?utf-8?B?UTh0UWFtVlk0aGdkS2Q3MWpVQVd1SFg5c3ZUamtickxadUVDeVNSNmlSNlla?=
 =?utf-8?B?S0FraEppdS9FaU1remZoWWV2ZlJsbTJsbXRBWEJJTTUxeWp4aXU0WlRFL1FW?=
 =?utf-8?B?anM3L296bVhIbnlQakgxbVl3SktLVXpRTXBObmM2ZzJBMW50dllPKzZ0cDQw?=
 =?utf-8?B?dEJyYmZhL0wyUktTUG10SXZ1cUVNREVYOVVReHN3eHRadzVqOVU5bWc4RmZ3?=
 =?utf-8?B?bm5JaitMd2p3dWcvcGpzNDJQNDBJTFg2Q3liVkxrOU5PQk03UDg3UGM2NllC?=
 =?utf-8?B?RElUKy9uMXdFcTBrYld5TXNHNXhCWVFJK3p3ZXZpaWFUL09ON3JIdGhSRmRa?=
 =?utf-8?B?WXdoaUZsK0FxOXFIclpOdmoxWFlXT0NqekNvZ3hCV1BldU9LektNTDhiWU1i?=
 =?utf-8?B?cTEvbnVWUUZXOFZMaXdtamVtMFpZTXVtRkpOY0NNL1dVWUsweHZMbm5HUjFw?=
 =?utf-8?B?dDFiT1hMUzBtbFdXRG9Ia2lDcmRwRWJOcFVpRU9IRnFaREFBVlBxdWY2MUk0?=
 =?utf-8?B?Ri9rV0EzRmFlMk9uTkZuSW9uWS9kQ000U1pxR1ZvUWQ0bFFmRzM1YWhBV0Yy?=
 =?utf-8?B?eG9xYnN0cWNURkdTYTJHSmZYdU5JR29jTTNBejluQVVtemU2cWdlOG9MWXVC?=
 =?utf-8?B?Q3lpc2I1MDAvNHRRRUtMMGlud0c4aXhNWlYwVnBEMW9ZZTEyWUowSDRkdktY?=
 =?utf-8?B?OE9PWkI0ZU9NU011NDl3dzkzdmM0azJLWGZ6OEpGc1BHb3gwUXVyUjA3dDlQ?=
 =?utf-8?B?U1RYSm1BaXZnN0d4cVQzbFJMamFsdFgyZlFhdksvMFpPU0l5YUlVUisxZ0g3?=
 =?utf-8?B?ak56bmJsWlFhRk1vWjZmS0pPbUhJeUJSUmgxWTdYdmhWSTVzVjl0OER5MmhY?=
 =?utf-8?B?Znltd21XRUxpdUxPamdxTXpaMGZVL3dNd1ZmVUpJRTlMZWJpcm5LTC9sSHhR?=
 =?utf-8?B?b0RCaFI1dVhENU50N3pTaVFHWmliakFwczJCMjdOMlNqbjF4L2daS2x0d2lH?=
 =?utf-8?B?dTBSOWtHeFhESG9vWEtYWVM4V2h6cXBRWEtMVjQwMkpyN2t5WmZ2eFh4RXdS?=
 =?utf-8?B?dlkraXlzQzg0WlpnRTRnQnZqWS9SdnZKb3FZcitDUVZKZDhPdnNveExHcFJY?=
 =?utf-8?B?cklmSlNaKzR0TkxZVzJSNXVpUUU4QWxIb04xc2Jlamg2VEJwTEVzV3lZcFVN?=
 =?utf-8?B?eGNMTFZRRFRTb2Vqa3UyTHZYYmRQWFkvUkFXRjV6aGl2STBEcGpmV1ZmbjMx?=
 =?utf-8?B?RVVkV1dkcHdraGloalhaVTB4Z0RRV3E5ZUlXOXo0UDZKODBCVld4dDIvL0po?=
 =?utf-8?B?SHlTYVluTVZqSFR1Um1FMVZ3MU5iaUpHNEhDZGxjK3hsMnBlWFloMHU2UWJJ?=
 =?utf-8?B?RUVXOHE1VHlQbDNubE1wMS90OTI3VW9yUTFHUndGMXAvOUw3WVBwVHpTS3oz?=
 =?utf-8?B?RlBtS1R6NTFQK2FnZmNPQ3J2NGxrb2ZvbmVQZERMekZUYjBLclA4UGllQ01z?=
 =?utf-8?B?VmJJWE16dm1RUDlTNmRxb3RLN3hvZ3VtazF4N09Xc0RTdzUyT3JOOXVCVk96?=
 =?utf-8?B?QVYrZG9KakF6SHk4T1RORHR0VXpvQlNSdlozSFRNZk82Tk5ubnJQSzdXS1or?=
 =?utf-8?B?L1E3N3pFUHJmU1FFUG9SNWMwVlBDa0hGN0g4cVE3cnRGYUdkQjNReEkyZmVl?=
 =?utf-8?B?cGdTQmVlYkhCYVZHMVNLK2l3eVBQTkE1SUhqaXl0WnJRRHBkL2VPTFdDZEVZ?=
 =?utf-8?B?KytQaS9kSkswM1JPeC9YZWorMUU3Qkc3LzE5OTB0b0FmeStSemdPUDNaanNu?=
 =?utf-8?B?Mm5tRmwyQ3QxWWxTWmZOU2xUU2M2ZDVDMlc0UGFleGhFTkNyUUNaUUJLdDUw?=
 =?utf-8?B?djUvdGp2MlFvUWp3WTY4VmVhNVhGUXNjNEdRS2JSZktnRWNqTEMzcElYZHg5?=
 =?utf-8?B?TndUKzZ6NHpLTlRLVlRxdXlpdndqcDZjcjFtMWRuRTFFTThNcDBFRlhiSDgx?=
 =?utf-8?B?WVUxWE0zeXBtZ2NQQ1B5TFNORUIyMjVDN2VmRlJaSUN6VTd6Y0x3d3lBTTBv?=
 =?utf-8?B?VThZVjdkTWIyRlFjWHBmaDhXZXdMRDlqVWNKWnFWSFFzQm85R3JaajVMZDJL?=
 =?utf-8?B?eE90K3VqeUphSjdkTmJvdkRnQWQzeERPSVYvZkZqOXZjOEFSMFgyMnpwYnNr?=
 =?utf-8?B?Z3ZyYmlMS1hEdWpCc2YrZGxkelJ3aGRBSzBEOUlMdForcUNRamF6STVZQkJz?=
 =?utf-8?B?UDc0MkU4dXUyS1hFSnJkMVdkYkdkYzhZZ1ZRUGxJTmxrbWJXUTBNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dddd63-ed74-4131-fc34-08de65827bc7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:20:23.3496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6TbceUO6tgSRqpw3isqXzhV0KjXYIG6DKlVT12jwvldr4ZF2Bb38BAAFIrmFsDI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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



On 06-Feb-26 4:54 PM, Pratik Vishwakarma wrote:
> Use smu_v15_0_0_update_table instead of common api
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 22d0a543a0e6..57cfb4af2e5d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1794,7 +1794,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
>   
> -	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
> +	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
>   				    smu_table->clocks_table, false);
>   }
>   

