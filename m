Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F7E6F098
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 15:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4B510E272;
	Tue, 23 Dec 2025 15:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYFcp2xD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F9D10E181
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 15:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE95LrP+IGUOI7rMMoB0oKfqH8LQi8BO9L3DRZBRck39u+R5xwspmnxfXsOCT3dmwpalb74vkpiMJd/ib55K8nZXhRmltQ44axzItTVDbuLwMCxixNW+vdT4XlV3yA5uIvZFHOP+D3MKBnYdVsgVEAxRVnX7VOcxP1m8Zy2jQHGQWfyZfTyzYGHbdcVZnnqRqM/V2v8sxfA4TVjCZWJZ3Y4EFYd+UwBLeM25pFfQAoYhWeY94+CTn3DTVsefQpVxKK6DAIoxLge6Reprsx6p+sdcm518BUCBIaQ10prWWVWniYpUcbGomJB4nrtcxiRnJHcm62kJPpe4Y6LYJHSrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rLMZWYsWKRMnY1RtYKFxFuEH6Zg/4GkBnhPaWIyGns=;
 b=iNglUkHVxh5HaP9f9kBA3r0Sp4E2O0h1bmws8wPq8lC2e1w9NBmlMEICEvIBvi1eeb3pxIp8fhOyfgxCpGypQLqwWaIYjm0Qbkk44rS2CtPkDdDERgf5bIexSMBmsoF62Q+/5l3zOhn0dc2tzilPvVd6hHWedu+I1tdQoYYaYDSU304kAq3jBiRNqJQcFxb6eREVwUKrf4BGVPwIGRoEHJhuyKGsAs2JJ7kD492FoIjx5cp3tHYiz2Iz2NriF3gOkSlayFlaI29MN2PBfBKjHXiDMkht4+xr8VDugWA9YQd1PUgf74EWTaJd1cRagb8jePXVsicAIW611fLo4gyaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rLMZWYsWKRMnY1RtYKFxFuEH6Zg/4GkBnhPaWIyGns=;
 b=rYFcp2xD3GMCFmeXHUs30W+kIcFR+3y5mz1+VOHmMYY4+b+Oi4YE1fHL0XplpglLW9W+e9XVT5T7MfcsoP29SXbZAqe1XXDC8Sl364Sb2Yv8hq0iuFZUVs7Pdx+k2jwsUiBQpj/fwrTu4zzQhffYWtN22BWg3WMZ3BvTshY1HIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 15:03:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 15:03:57 +0000
Message-ID: <590351df-de9b-407a-b767-83935ea96b5e@amd.com>
Date: Tue, 23 Dec 2025 16:03:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Support fork process
To: Bingxi Guo <Bingxi.Guo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Deng Emily <Emily.Deng@amd.com>
References: <20251222110146.464367-1-Bingxi.Guo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251222110146.464367-1-Bingxi.Guo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: c252a346-7369-470e-1031-08de42347f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckg5cyswd1UzanI0YWxBZ2IydWF5aFhhUkZEOEJVdEsrOGRLWXZkbkwwYk1Z?=
 =?utf-8?B?OUwxRGZhUVNEVk5PSlBOVmlrc3Z2NEsrWDlCTFRNS2YrMy85YVEzQi8yNGJP?=
 =?utf-8?B?a2tOVFpKY1AwNjNZdTBtOTA5aFZSbFF5RENBa2ZBU1ZJMmc1WDN2Z0VpanF4?=
 =?utf-8?B?eVFVeFQycmd2QnNTTGNpYXZldnkzaUlvdTd1K3F5YTQ4M3lDdmVyTHVUdmJ0?=
 =?utf-8?B?czdSQXpUaytKMlY3SGJBUHE0cGpia0RoTHl5eEdQLzZsT3NyQWFCU2RUY1F0?=
 =?utf-8?B?MHRYOXBXMHN2TkNiVlZsWnVHMkUwTXYyUHJUNHZmS0FESnlxeHFDYjJWMzQx?=
 =?utf-8?B?OEg1TEkxNVMzMWI4aUlTUTNDZFhlRnA5Z1d3VzdYL04weDdMS2JRSjQ4aTNS?=
 =?utf-8?B?T3BDVjI1bVpJMEhXTkZLeVZkMjhNaG1EUnZoRmxSYnNRT2tjS2NEdmRkanlB?=
 =?utf-8?B?K1hwV3JiZ2xVVVhzQWloSDNsMzErZFZ6NXBxblJreHdCZG5Ca05zZ0xiSWpx?=
 =?utf-8?B?OFZYRGt4R2JOc2FJRkRldmZoWmU5S3dMdjNzaVRlb3BwclZwQmE2SkxxNGlX?=
 =?utf-8?B?MmJra0lBaHcyY2NjNkpmdVZmakU2TjRhZVpraGpHd2Rnd2ZNazMwRnhIbU5K?=
 =?utf-8?B?enJPS0VBdzl1ZzIvbEtOSEVZaElpcGorOUZqbVhwczhNdXFuRXhOQXl4bG9X?=
 =?utf-8?B?M2lxd0tuV2QyY0h5UkRvcklNM2JwdWlvNWZXakNCcHZ4QmhqWXlIc1hiOXgr?=
 =?utf-8?B?N3ZOdXYrdzlWQS9hbkh0eVJPMWlpL1NaUjRLVWlOdlVleFRraENvM00yM1Ax?=
 =?utf-8?B?V2J2OUdESUtKWDNoODdkajV1dUpFRFhMeUl5RDUwZVRqMlNRRUc4OXB2OW15?=
 =?utf-8?B?aGpaWTBrQ2hRVnhnMUFKOVU5U2FKbjV5c1RzVUQ1bDZxUHRvL2x3Uzd3UUFV?=
 =?utf-8?B?QVpHNXJFQTIvckoyNm1LMXJ4aFNJTzV0dlNNK0xlclRzYitaUnBvNmVEQnh2?=
 =?utf-8?B?ZEczdzVOSWZxNEM5QnRZMXR1NUx5YVBtenJ1REpGTXZxUWpGQ3pqNjYvK1dQ?=
 =?utf-8?B?SEQ0NEtlaDVKN2JlYUx4Rk1mS2NIZW1VRnhVTEpHaWdaQUtPdGRIdjNsTXRu?=
 =?utf-8?B?V3oyTDB4d1hvYlZnMHhvTXU5MGlMMnQyd0F0dXN3SGdxMXBJbDdnbU44c2pT?=
 =?utf-8?B?aFlmOE92R2hVVjNEc3c5ZUpYLzVqdVh4Smo0MmtWZm0xei9nUDdJVTM4SXM3?=
 =?utf-8?B?SGtHQU8wMkFFTEdtckl4Tk5QREV2My84YUpiZlovbGpOS1JjRkc3ekQvdFBn?=
 =?utf-8?B?ajZMQUxEekR2d2lVSGtoUkZaTUpreCtEam1NS3huLy9MUC9MQkFCNDhXNmtH?=
 =?utf-8?B?TmtiZVNaQVZBMGxzRCtWcSs3SkRZUEFZRDg3Wm1jNjhudTJnUzNRTmtzTm5S?=
 =?utf-8?B?aFh6OTlHaGNnSGFHVFlSenNYWkZSQy9mYWsyMzlnTkVYME9majBKWmxidjlV?=
 =?utf-8?B?M1RXbFhpSWJrcEZicVNUMHFoZWFFc2lMN3BtNENFUjVjdGZ6VGxQbFRyb1k4?=
 =?utf-8?B?VGo1S2tZd3BCdHFGQ3d3OFFpekw2U0hmUTAva29XQ01MdVBrRkE1Y1VPQ0dX?=
 =?utf-8?B?aTN1Z21ZNWVEV1NYYW53VXFIRVJCM0VQT0NJdmNrSHpqWTNUMEhRM05xVlZE?=
 =?utf-8?B?K0xmUlRSRnE4UktubzlIYWRZdmtZL1ZhV0p5Zm9SUVdhNFloMUJYY25wZUsw?=
 =?utf-8?B?OG9tV3pmc0ZQQnNLc1JYUnBBZU5IV3F3cmxwTVRVcEtnU2NZSnpOZXB1RnRO?=
 =?utf-8?B?K3ltNXZSRklvOWxzWnN1ZWt0VVc4ZXpjNmNxVzZBRk9qZm5jU0ZhdnN1L0Jn?=
 =?utf-8?B?WEg5WnRuR012V1p1YmY2cWw3QmdnUEhUQmFEd2hBYm1GeDFUM1NYYyt4VDZw?=
 =?utf-8?Q?pX0IEEFTn+OnBk8oL89rc8pOkRGhb5/Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JQUXFaMnpuMkVtbjdEdHdqSHNWUitNbTNRb0pXaUVreHBpVVNEUkd4eUgr?=
 =?utf-8?B?K0xHNTU2clpGbmgrOWhLWVJqSVJKdEo1S1R0QUlGRlF5Rm1CWkhuSUVObUt6?=
 =?utf-8?B?Ni9NaTkzTmlIRGlDM0wwaHZtbzVZRUxQSnFjTWpOclAxc04wZnJHWWRuY0sr?=
 =?utf-8?B?T1c4OExpYVZQRUNHaTVWMTBSMS9nZnhEeitwdk50bngxN0xQWnNBUzlpUzlX?=
 =?utf-8?B?NXQ4S1UraEFKZmFkTHRJajNYa2RDYlBWQ0w3dVNLWXdGam5CclR4cFJBL05X?=
 =?utf-8?B?QXdtaGV2b2xTb2l4dlFsMnhpbUJRTkhqZFB3MHMybTRYVkRCV05Dc0FEdXFV?=
 =?utf-8?B?eUJwLy9rcVZwUkFNbVltYUo3Rno0KzZOOERMZGtsNGxoTlFMcTZvRGp6eWhr?=
 =?utf-8?B?QkhCZjg0aEpFREJVNmQ5VWc5ZGhDOXhVUXE4Q2V3UWxmQ1o3WFBUQ0RUZWN2?=
 =?utf-8?B?ZDBtbElNbVdvVTFDZ1JWM3hCNHFpTzErbUJSUnA4Rm9MaXpTdkpkbUtwdkFG?=
 =?utf-8?B?ZW84dGZFMUlFNUtLMTF6N0RGdDUvbTlaZTV5SFloa2xBMU1zMWVwYmRHcDRj?=
 =?utf-8?B?V2FQOC83VDB2akhkaTFxK3FPWW9leG1QancrLzJueC9wdjV2TENZSllXZ3BD?=
 =?utf-8?B?NzRBTjY5WjBpMmxKM0xuR2tMQnI5K3dZR2RrUWlKUHorM3JTMGYrS1c4R2Js?=
 =?utf-8?B?dlU3QXV1enpRMWlVY0E0KzVVRGJnQUwvdWlLV3ZkNU8xaWJSbVFQUzJLZmtj?=
 =?utf-8?B?NEZDaVVCZzJJdytleHdrNWdOUDhWN1hueStQM2tSQ0EzTDlpbllHb2d4cm9U?=
 =?utf-8?B?WWxTYW56cUt5NnpPOVhxWkNycjEvdFFVMTVpMUhQSTVuZnZldGRFMXlFS2RB?=
 =?utf-8?B?OGkyVHNybytCVi80a2xyV3Fzdi9lcGZGSzdVVTlJT3BnVGlQU3hFVkREQVBV?=
 =?utf-8?B?cHVhZXF0U2pBN0ZJYXVpa01yKzByYlNFTXdIc1RBRkRWaUtPcWFPZzltOS9L?=
 =?utf-8?B?TWQxWUNraE1WVGoxZ0c1SGh2ZFlDOG4vTTFSVWlXdnk4bTNPQkRiQ2sreHJt?=
 =?utf-8?B?RGxLYzdUREVZZkJIcEhkL1VCNmpleXZmbnAxcHJNZmQ0bDBQdy9xeTkzTWFk?=
 =?utf-8?B?elkyQWRjZHpYVmM0VDJMcmhqRExLdExEaDNnUnp0MFdZOERhWm52ODlqazAz?=
 =?utf-8?B?aFpvbHFpcVo1WmxpaFFTYjErcWUwaFhXSUg1RGttSHNrYW8wcjVlU296R0NT?=
 =?utf-8?B?NDU5MnJvcFdUaTlDOExuemF1dDk2djZrTE5NT2pIdEVUZFM4RXUxMVZka1dN?=
 =?utf-8?B?NVhLUDY0azZVTmN4dW0yWTlmdWNrQVdTMFVvaW9BSnBzWmd4TFp2NDZ4QWU1?=
 =?utf-8?B?aENTb2Vka3VxYTVRT05hZTNNM3hzeGhHTHgxSEkwL0w5c0ZFVXZkdE5lTFVL?=
 =?utf-8?B?RFBuSDE1aWl1aHlqU29POVM0QURhL051Wm5IVjBtbHlVS0E0dlVDZzI0SmJy?=
 =?utf-8?B?L3BIRFl3RlI1NDI5TjhBVGJ2cThQYUU0Mk9ibzk0OGpKMWNEcXRKckZnRFVl?=
 =?utf-8?B?T2c3c281bVpQeW1hejZOdk5vMmpSK2sxSHIxaW5VU0UwVWNPYmNTVVZGUi9V?=
 =?utf-8?B?eVRYSXQxS0puZHN5SVNyb3NJMFpQek9lc1ZzN2JMbkp6TGtHZnNqVFFRVkpB?=
 =?utf-8?B?TFVkQmdwZTdQUjhwdE9rRVA2ZzlKVy9tTXlFY0Zjby9Eakl0UGVkZGlHMWIv?=
 =?utf-8?B?a3hKMW5DNGw1MThIdjI3NndFRFVNSk80dm5JSzVNS2U2ZThSWmN1eGZFRmsy?=
 =?utf-8?B?MDNmVWhJcmRoTU1qcWU2amg2bGdWLzU4K2d6OW1DYUtLQXJqMm1oSlRmclp4?=
 =?utf-8?B?c1J3V1BVZDErbzF5WU9nenY5eXUrYllodkY1cFpGVXd2YTk3VmVUWDJKYTFF?=
 =?utf-8?B?cUo5NFd6Ti93WjVjMGpobUg5dktmOTE3QndBZmFoazRHMGEvb2NtdjhtZlM3?=
 =?utf-8?B?WklaeWw0VnR3WDg4QWZqZlYyaE1vcHhrVitFYUl5dUJUcW5KQVBOMUlGSStF?=
 =?utf-8?B?bjVLQzVMN2kyam1PUGZZZUxsdXp0OGxtd3k1MGs4NEloZjFYM1JJN2hER1ZB?=
 =?utf-8?B?bUx5UFhUQis4d3BteFBmUVR6a2d2YkgxWE9NSWptREdnbENydjR0NmJyYVJv?=
 =?utf-8?B?T2dZNFZDMXNtb2pOREduSTlzRWlUNW10YVI1elVBMHNaVUZ5UzZpMzl0QUkz?=
 =?utf-8?B?TysxME5raHd0ZkZzWDY3MDBNVk1yWTMzZHZtTWxqS0YxNUdneU1NaEJVbVNZ?=
 =?utf-8?Q?Y318QlGVC7ls92i8Km?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c252a346-7369-470e-1031-08de42347f4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 15:03:57.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhVopU3h68pQ2bHUrO3vuxbQWKeI5fDy+3OHFUm4Q6lehqp7vtUqg+C2ElbxmP/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

On 12/22/25 12:01, Bingxi Guo wrote:
> When a process forks, the child inherits the open DRM file descriptor.
> If the parent is killed (e.g., by SIGKILL), only the parent's jobs
> are canceled. The child process can continue submitting jobs to the
> same entity through its own user entry in the entity's user list.

Clear NAK to that. Forking a process and re-using the fd is illegal!

See the OpenGL, OpenCL and Vulkan specification.

We intentionally block that here.

Regards,
Christian.

> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 133 +++++++++++++++++++----
>  include/drm/gpu_scheduler.h              |  22 ++++
>  2 files changed, 135 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 8867b95ab089..508a0629b839 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -110,6 +110,9 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>  	atomic_set(&entity->fence_seq, 0);
>  	entity->fence_context = dma_fence_context_alloc(2);
>  
> +	INIT_LIST_HEAD(&entity->users);
> +	spin_lock_init(&entity->users_lock);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_sched_entity_init);
> @@ -228,10 +231,24 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  {
>  	struct drm_sched_job *job;
>  	struct dma_fence *prev;
> +	struct drm_sched_entity_user *user;
> +	struct spsc_queue temp_queue;
> +	pid_t my_tgid = task_tgid_nr(current);
>  
>  	if (!entity->rq)
>  		return;
>  
> +	/* Mark current process as exited */
> +	spin_lock(&entity->users_lock);
> +	list_for_each_entry(user, &entity->users, list) {
> +		if (user->tgid == my_tgid) {
> +			atomic_set(&user->exited, 1);
> +			break;
> +		}
> +	}
> +	spin_unlock(&entity->users_lock);
> +
> +	/* Temporarily stop entity to prevent new jobs */
>  	spin_lock(&entity->lock);
>  	entity->stopped = true;
>  	drm_sched_rq_remove_entity(entity->rq, entity);
> @@ -240,27 +257,59 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>  	/* Make sure this entity is not used by the scheduler at the moment */
>  	wait_for_completion(&entity->entity_idle);
>  
> -	/* The entity is guaranteed to not be used by the scheduler */
> +	/*
> +	 * The entity is stopped and idle. No new jobs can be pushed.
> +	 * Scan the queue and separate jobs:
> +	 * - Jobs from this process: kill immediately
> +	 * - Jobs from other processes: keep in temp_queue
> +	 */
> +	spsc_queue_init(&temp_queue);
>  	prev = rcu_dereference_check(entity->last_scheduled, true);
>  	dma_fence_get(prev);
> +
>  	while ((job = drm_sched_entity_queue_pop(entity))) {
> -		struct drm_sched_fence *s_fence = job->s_fence;
> -
> -		dma_fence_get(&s_fence->finished);
> -		if (!prev ||
> -		    dma_fence_add_callback(prev, &job->finish_cb,
> -					   drm_sched_entity_kill_jobs_cb)) {
> -			/*
> -			 * Adding callback above failed.
> -			 * dma_fence_put() checks for NULL.
> -			 */
> -			dma_fence_put(prev);
> -			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
> +		if (job->owner_tgid == my_tgid) {
> +			/* Kill this job */
> +			struct drm_sched_fence *s_fence = job->s_fence;
> +
> +			dma_fence_get(&s_fence->finished);
> +			if (!prev ||
> +			    dma_fence_add_callback(prev, &job->finish_cb,
> +						   drm_sched_entity_kill_jobs_cb)) {
> +				dma_fence_put(prev);
> +				drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
> +			}
> +			prev = &s_fence->finished;
> +		} else {
> +			/* Keep jobs from other processes */
> +			spsc_queue_push(&temp_queue, &job->queue_node);
>  		}
> +	}
>  
> -		prev = &s_fence->finished;
> +	/* Put back jobs from other processes */
> +	while (true) {
> +		struct spsc_node *node = spsc_queue_pop(&temp_queue);
> +		if (!node)
> +			break;
> +		spsc_queue_push(&entity->job_queue, node);
>  	}
> +
>  	dma_fence_put(prev);
> +
> +	/* Check if there are other active users and restore entity if needed */
> +	spin_lock(&entity->users_lock);
> +	list_for_each_entry(user, &entity->users, list) {
> +		if (!atomic_read(&user->exited)) {
> +			/* Found active user, restore entity */
> +			spin_unlock(&entity->users_lock);
> +			spin_lock(&entity->lock);
> +			entity->stopped = false;
> +			drm_sched_rq_add_entity(entity->rq, entity);
> +			spin_unlock(&entity->lock);
> +			return;
> +		}
> +	}
> +	spin_unlock(&entity->users_lock);
>  }
>  
>  /**
> @@ -323,6 +372,8 @@ EXPORT_SYMBOL(drm_sched_entity_flush);
>   */
>  void drm_sched_entity_fini(struct drm_sched_entity *entity)
>  {
> +	struct drm_sched_entity_user *user, *tmp;
> +
>  	/*
>  	 * If consumption of existing IBs wasn't completed. Forcefully remove
>  	 * them here. Also makes sure that the scheduler won't touch this entity
> @@ -338,6 +389,14 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
>  
>  	dma_fence_put(rcu_dereference_check(entity->last_scheduled, true));
>  	RCU_INIT_POINTER(entity->last_scheduled, NULL);
> +
> +	/* Clean up user list */
> +	spin_lock(&entity->users_lock);
> +	list_for_each_entry_safe(user, tmp, &entity->users, list) {
> +		list_del_rcu(&user->list);
> +		kfree_rcu(user, rcu);
> +	}
> +	spin_unlock(&entity->users_lock);
>  }
>  EXPORT_SYMBOL(drm_sched_entity_fini);
>  
> @@ -567,9 +626,40 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>  void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  {
>  	struct drm_sched_entity *entity = sched_job->entity;
> +	struct drm_sched_entity_user *user, *found = NULL;
> +	pid_t my_tgid = task_tgid_nr(current);
>  	bool first;
>  	ktime_t submit_ts;
>  
> +	/* Check if entity is stopped and reject directly */
> +	if (entity->stopped)
> +		goto error;
> +
> +	/* Entity is running, check user list */
> +	spin_lock(&entity->users_lock);
> +	list_for_each_entry(user, &entity->users, list) {
> +		if (user->tgid == my_tgid) {
> +			found = user;
> +			/* Reject if this user has exited */
> +			if (atomic_read(&user->exited)) {
> +				spin_unlock(&entity->users_lock);
> +				goto error;
> +			}
> +			break;
> +		}
> +	}
> +
> +	/* If not found, create new user (fork case) */
> +	if (!found) {
> +		found = kzalloc(sizeof(*found), GFP_ATOMIC);
> +		if (found) {
> +			found->tgid = my_tgid;
> +			atomic_set(&found->exited, 0);
> +			list_add_tail(&found->list, &entity->users);
> +		}
> +	}
> +	spin_unlock(&entity->users_lock);
> +
>  	trace_drm_sched_job_queue(sched_job, entity);
>  
>  	if (trace_drm_sched_job_add_dep_enabled()) {
> @@ -582,6 +672,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  	atomic_inc(entity->rq->sched->score);
>  	WRITE_ONCE(entity->last_user, current->group_leader);
>  
> +	/* Record owner TGID */
> +	sched_job->owner_tgid = my_tgid;
> +
>  	/*
>  	 * After the sched_job is pushed into the entity queue, it may be
>  	 * completed and freed up at any time. We can no longer access it.
> @@ -597,12 +690,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  		/* Add the entity to the run queue */
>  		spin_lock(&entity->lock);
> -		if (entity->stopped) {
> -			spin_unlock(&entity->lock);
> -
> -			DRM_ERROR("Trying to push to a killed entity\n");
> -			return;
> -		}
>  
>  		rq = entity->rq;
>  		sched = rq->sched;
> @@ -618,5 +705,11 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  		drm_sched_wakeup(sched);
>  	}
> +	return;
> +
> +error:
> +	dma_fence_set_error(&sched_job->s_fence->finished, -EPERM);
> +	drm_sched_fence_scheduled(sched_job->s_fence, NULL);
> +	drm_sched_fence_finished(sched_job->s_fence, -EPERM);
>  }
>  EXPORT_SYMBOL(drm_sched_entity_push_job);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index e62a7214e052..45e066596405 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -59,6 +59,16 @@ struct drm_sched_rq;
>  
>  struct drm_file;
>  
> +/**
> + * struct drm_sched_entity_user - Per-process entity user tracking
> + */
> +struct drm_sched_entity_user {
> +	struct list_head		list;
> +	struct rcu_head			rcu;
> +	pid_t				tgid;
> +	atomic_t			exited;
> +};
> +
>  /* These are often used as an (initial) index
>   * to an array, and as such should start at 0.
>   */
> @@ -233,6 +243,13 @@ struct drm_sched_entity {
>  	 */
>  	struct rb_node			rb_tree_node;
>  
> +	/**
> +	 * @users:
> +	 *
> +	 * List of processes using this entity (for fork support)
> +	 */
> +	struct list_head		users;
> +	spinlock_t			users_lock;
>  };
>  
>  /**
> @@ -385,6 +402,11 @@ struct drm_sched_job {
>  	 * drm_sched_job_add_implicit_dependencies().
>  	 */
>  	struct xarray			dependencies;
> +
> +	/**
> +	 * @owner_tgid: TGID of the process that submitted this job
> +	 */
> +	pid_t				owner_tgid;
>  };
>  
>  /**

