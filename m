Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C18FC61CE8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 14:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D33E10E3F9;
	Mon,  9 Jun 2025 14:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWAV0ICE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC5F10E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 14:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr1k64KLy15YyEOf0ktKqsOgkIlDD/0D2/23Pg/8XBpUmMS7EsGBorQO+jJzNKFDB1axWWBr5B7wpDA03S6UO4jpTPOdqaK3gDV6dabP9JJpNFTPZ3Fx4cww8kecW+3Ru6csCiWsa9AQTjB5QehZHVbAIKfuqhOZrlV/LgqWpBIDVZuXfh478Gl8uhrnlbzl0xVmqjq4RCpMxOchbp/7xaRLI9JhKHVepkCcV5qOUbW1c2/rgm/3AvR9wDIIlQ8j0nix+7VpxPj8tJjKJmjjOg/yezZBj8eojGQCS1O95f+QUNgUksGf1H8uGNLZrgGsao6u+cIUqa+SZmwXP6q81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyEbcWNQQhQ7pC74RDxl4VrMeDPcMXjFceqmsfQKybg=;
 b=wQjTkqhA93Ja/T5VuCAvvN+IXpCmqeup3139OuDOzZd/r0wS1iHcXOjiHGgA7jSl7PHKdVo4gdWMn4XLqNQKD0arn1ceZiyFoo2UdxTbYTM5d8Ly3JrV0fgTZL8mhfDMR1yLsQgZ3vhrTsJdwBE4DUofPc8ez5Nn6u6UycfaoUOPxGNUx2BTuQ1H4F+/IQvK6m/eBE9jKZ2Sjed0PnPKUgqtC0tY/cWKnt3u/aiJmgM3fVxPG1anM5qW/4hrCsz32r6lyT8yQsIgSnz3kmblcvGwVtUZ08bH3Q7RgSzdoI+5zbCM3qqKj6Ksyljizj6mPt0Ad9WzHH6ijvAO9Ll9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyEbcWNQQhQ7pC74RDxl4VrMeDPcMXjFceqmsfQKybg=;
 b=DWAV0ICEosAd0opVm/1dkGFh5vE6je0AwDA9MA9KFeK7VDrTHqYt0HgbtYOYoJ2ziE5n/BSxhEUEnCbIlMaHw4ThoglKJ6B7OtIq4IwBoCRFr/OpEEvZWG291lWu8tUbMacUNjU6WHKyKo0jeW9/Dz854BovYlqVYjEL0JMZJFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 14:23:23 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%7]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 14:23:22 +0000
Message-ID: <2f79a20b-0b31-4c1a-ba66-c8ffd941680f@amd.com>
Date: Mon, 9 Jun 2025 19:53:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/29] drm/amdgpu/vcn5: re-emit unprocessed state on ring
 reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-30-alexander.deucher@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250606064354.5858-30-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::8) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 844ab329-6b3a-4079-3527-08dda7613092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWF0Y3dGZWM4K05oakp1MnlQNklNRU9NMmVjSkp2L1NDVUdvdGFNemdrK1Ja?=
 =?utf-8?B?cDdUNndMbExqeWoxZUlQQ3Vra0oyeHFoanV0WWlLRFN1T0lrUW5WcVVWaU50?=
 =?utf-8?B?a3JsZlZjK0phN1RPVTFRUGdxZG90bWlOTWVYK1hmRGFrT2Z4UkE3VjZCRTRt?=
 =?utf-8?B?czdwYnFhc2owMTVYUG9GQ1JOR2ZzV0xlT015Z3NBNUdmaWJXcndPbVlSbXcx?=
 =?utf-8?B?ZXd4U3BXVURhZkJzSFh0dFcramZya1o1bk1pQ2ZWcGN2QkhyYTVLKzA4UHlW?=
 =?utf-8?B?RG10T20xWkZubHVXWUVKb0RFMlh1VVIyaDh2djN0N2liZ1QyakxXb3RJNll0?=
 =?utf-8?B?cVJVazNyMmFnNk1LYnAyWm44NUl0SCtQeDRSQy92YmpSSktsL2d6Q2crVWl1?=
 =?utf-8?B?RXNvUlhzY3FiTUpRd1ZkTWVIZ2kwTGhlVEM2bkVzWjZ5YjFrTU5mTXhOS1RM?=
 =?utf-8?B?Vmx3aGRUNitWUlEyd01kN3ZVc0VSQ0hGTGhTQ1I3L2VXTVhHbUVMR3NXZVVL?=
 =?utf-8?B?N3h4RS9oTko1ZlFGNzBvSGlUUkFRdXUyOUtXTmtuTHlnakE0RXV6TnFEeU9m?=
 =?utf-8?B?cUNvTExyMXRaRUhNUHlsbkxFdGYvMWp2SUNCUWJjMUd5dGdLZW9SVmkyYzRw?=
 =?utf-8?B?bEVkMTZZUVJJamdDSFhoYUk0dWw4VjltYk1HSlA4ZENkc3ZrYXdWWEdjOWI2?=
 =?utf-8?B?Zll4VFVvZE9rYVExWU1jeFJQN21JbzVhY0lMblk4MXRoZitxS0R5OEV6Qi9D?=
 =?utf-8?B?YXE5MzMrcXFjM1l6VEVTWlJpczQrcHJMNUI1eXFpL0NlT2FlcWF2anNId3pD?=
 =?utf-8?B?V2VVN2cybmhqSjZVb2RyMHVJdE1YTklIQVREeWQ5cHV4RDMyRDBMR0l0VGlE?=
 =?utf-8?B?WENVSXZYVDBqYXVzLzNSWWtQUTVDeTY2YStkcUNDM3JUdEdFcWFob2kwRUJX?=
 =?utf-8?B?dWs3Ri9NbWg4cTdQSThxQXoxWU80ZG50WW5zaG5reCtzKzVNL25qZUcyUEox?=
 =?utf-8?B?ZC9HRERML3V2dVB0bStrUkU4MWRZV21XTnZtU0x5Vm5xdEplTFZEMGR3OEZU?=
 =?utf-8?B?VkRpc3E4Qm5BUW5nSjQvMUU2OHNha0V6a2NlbUJFMWtwRGZ6OHNzZjd2bFN6?=
 =?utf-8?B?TFIzZzg4NGRtTy9jM1pXYzJaRU9CZUZZekhHcnVNTi8zdUZaVWpiUGl0ditw?=
 =?utf-8?B?SXhjSWN5dWttdFZ5TGF4UGZoYUh3RWhBK0xyaFVwWUdhclNlQlBsaURNaVBG?=
 =?utf-8?B?ZDJoUnZKTjZ0V1Y4R3BFdWxvTnc4Yndhb3Y4aDEyOHhnSTlNdUw1VDNFUm1r?=
 =?utf-8?B?NjNnclI3YUpOSEFXbTR2cVNyQmwwWC9ESkU1TzFIRks4aXhQNGxLM0NmZGZX?=
 =?utf-8?B?Sm4yL2htUzlFOThKM2hhcjBmQTdnVHpNZjNJNWJBdjhSUG5RbXdNbHZhekpr?=
 =?utf-8?B?cWtKQzdZNldYOWEvZzdqMktKVzFFZUdZbUczNnZROU0wUHNzOHJVUEpYQVJY?=
 =?utf-8?B?Vy9VVExCSHowRWlYd25QVXlwcjUwTXk4QWExN3M1bDN0djBMZUVDVm51QzFZ?=
 =?utf-8?B?L1p6aVVrMGNxS2pUdGp2Y0EvVnc5VDhDd1RsTzg0WUVubUxTd2FpVi9KaVMw?=
 =?utf-8?B?SUtRNG5lUFlCRHZJbjZRdE5TSlN3N3Zma0Y4NjZiY2RCdTJsdXo5ZXEzQktH?=
 =?utf-8?B?Rlh4YUJMWWtrN1ZsU0FkN1VMaURJMjJMRkNtT3Mrd1NXQ3NldVBicEFYQ3Mx?=
 =?utf-8?B?WmpvVHZPeXBGdTQ0cytlSzZoK3ExOUh4NEdkTGhFM2tmWmZSeVVWNTRyQUNu?=
 =?utf-8?B?a0FjVjl1aWpjUGlDeTFaZ0NDaDB1dlE5SzN0a1RmSzEyNEVYQUp1WkJuY2pi?=
 =?utf-8?B?Uks2blZOeWxpRENCQkZ6MU1GUlNIZk1sN1pvYlVzQjlBTEV6c3FTYkpsL0ZK?=
 =?utf-8?Q?vy+9irtVue0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW1peVJaa3B3TXlZelBXMlpuVW9RTGl1UllXeUFpcFlFUnBrbUJlditTL0dZ?=
 =?utf-8?B?dlorOWNBQWd1WHJkcVQ3Z0VxTkNZNkh4aW1wNGtlUjhtMHp2SGJTN2FHeC91?=
 =?utf-8?B?V3RpNVpQcmEwcmNiZHN1aEs3S1ErWXlMbllZZmdUOHplVjJLY25MSFIvN0Vi?=
 =?utf-8?B?ZFNKdmdaQ3ZEbHpFYXhZMmVoZTBDNGx6Q3dBNWRtcks2Nk5RV3ZGWmgzem9I?=
 =?utf-8?B?NjB2alU0b0tXM1FGaFFTemcrQXh3SHpRMlVWMUxwQ3lTdmZEYU5wQzlQVnBS?=
 =?utf-8?B?TXNYaXlTa2FZOERaZjJRMlBoMkpqUE03ckNGdExUY29wd0pvS0hheTVjSWFU?=
 =?utf-8?B?WG41angxaXJBTFNSWGNyRVQzdVpMT29oVC9RcW5LNEFBVFNwckZnaTl1L1U0?=
 =?utf-8?B?U0ZXYm5xc3RucUpxVGlpbC9YMHdUV2dwZ3cxZEtlTndWMnVrTWI3ZGsyTVly?=
 =?utf-8?B?VUs3Rk15UncxZnVlcnBkdzhWbjdWek5ZUDNoeXBjeS9wN0QrRlVZcVVzZXBr?=
 =?utf-8?B?N1R6dW11SmVGR3FFRTJ4Umw0azlMNDEvN0JQVXVzNFUwQi8yOVZmZlE4bkxi?=
 =?utf-8?B?VVRNL3BJZ216KzZJTVZ3a0ZFbVFiNklPbDFudWRCaVd1eWxBOUVNUXR6ZG1x?=
 =?utf-8?B?Zk9EcEt2Q2NyeVpJUnd0Z0Z3Z29GRy9qYy9IUU85TXNkMDZTMDE1YXVINS9s?=
 =?utf-8?B?VzdhaHN4WXk1Szh6M0VLTUtMU1E2R3JtUEhFbjlKSnA3M0plTitKUjRkc3pZ?=
 =?utf-8?B?N096ekFoZStwZS9seVZOSVBWMGZOSjF3SFNPNk5uR05GVUt1LzVVSXhkRWxQ?=
 =?utf-8?B?QnhzRUVhc2JWelpNNllCUUEwZjR5TFI1SGM1NVRtSmR6dmFSMkxQN241d1V3?=
 =?utf-8?B?THJnd01DV0QrV3NvK0praXc3YTEvTEpGM2J0MHJBU285T1pwSzVWb1c1YTBo?=
 =?utf-8?B?Qy8zd0VKdmhVQ0wvelJKVEIvSWpSeFlkTEtTSVFacGdycFI2bWxqbU5veG1Z?=
 =?utf-8?B?YlFGY0hwakx6QzhUelNva25JVDBCNndjV1RTWGh2ci9kRHlkckxYWVBGWFhL?=
 =?utf-8?B?UTBkZDFYOVJBTWNHbnBoRTJsd2xnWXdjYXl5cTdMcUd5TXhjaWNiV0ZQbHlO?=
 =?utf-8?B?Z3dGdi9jb0VBNHRiMUtGcXM2YXpyQ1pWZkUrS01JdlBMWk9nVHlvSWoxT3Vr?=
 =?utf-8?B?U05Ud3ZFSXlvcWdLNVlrMXJCb0p3enBEK2FPS3FZc2NnMlZIVElhVWlrZ0FV?=
 =?utf-8?B?cEYvWG11SWFBNzdmRE9TVFhkemsxUjU3c2thcmQ5QXFrZVRFem5TSDBnYmVh?=
 =?utf-8?B?Wkw0anhEbFpCdzI0dG1xTzUrQlEzdkdhdkZFWEpZaTlMSXFyVWZBSk9nTmhN?=
 =?utf-8?B?cDI0M1JqZFNpV0hRZWFWdUpLZm5KRTdiTjVKTVJjOENCV0FHdjlGb283MXZt?=
 =?utf-8?B?eWVmNC9ZNzltK0cvVk9hZVdIYXNtUVg5ek5lNFhGV1B6bnZhRDVqNHp0VEx0?=
 =?utf-8?B?bjdOa1ZKZWdOaUdIWDdDM2hLMGJJelFiL1Q0WGE5cExyWjdVOFZMdUdZRXlq?=
 =?utf-8?B?STdGM3A0TStpMHd0T3lsbHdMcWE4QmFRT1NWSUltZkFUMHZRRk4wTXAxSG1p?=
 =?utf-8?B?U2FGVWZIcHI3cm96bGdYTUF1M1cwcFBWV1paUjc1UG1pQlFHN2crU0IvdXA1?=
 =?utf-8?B?U2hJWHNEMUhad3ZhcWo3VVBGNjJYekM0eXlia0ZseGFaVjVMOUozNWxueXdE?=
 =?utf-8?B?ZnBpNmtZTDA3Vk5FNnh3bjFUQUpndHZyM0ZsZSs4T3FoYXo1bjM0MXFoMGxR?=
 =?utf-8?B?UENUVTJ0VjNBMWEzU2QrZzJxYUltY1h5bW5aVTYvdmhlUlVKc1E4Qi9WeFBj?=
 =?utf-8?B?aXhZbzFVMnhmUktqS1hjbmxHeVJOazkzcUcwdldYRE5aWC95TGhnOUs0VEFr?=
 =?utf-8?B?S3BCSHdEbjE4ckEzTlg0NGtwZkZORmpoZGhyTnJ3YXVsZHZSbmhtS3dkQ2M3?=
 =?utf-8?B?WERrVVMzQUx0cmt3R09Rc29SK0VOcXliaWIvdHdESHBVdlJaSmVuN3JLTFdh?=
 =?utf-8?B?S2lVWE5DTFRrajg2bmVYak1xVlA1OUprNWpja2JGNGJ4RXpGYlYxRHdEMVBs?=
 =?utf-8?Q?M5YjKSZ86PSgzAKSUCZ/uy2B2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844ab329-6b3a-4079-3527-08dda7613092
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:23:22.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n8esjrBOZFUvnIEMIT1V9vIzbzxLlbFKoIyizgaNWUrAoqU7HajUeN3AljB48+Pc05b9oywT3UH+ozTFqNA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

One nit-pick, amdgpu_ring_backup_unprocessed_commands function could use 
amdgpu_fence instead of dma_fence as argument.

And JPEG/VCN changes in this series are also :-
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Note:
JPEG5 and JPEG4_0_5 reset fails due to DPG mode, they work fine in 
non-dpg, failure is not related this series.
Couldn't test JPEG4_0_3 and VCN4_0_3, but the changes look good.

Regards,
Sathish

On 6/6/2025 12:13 PM, Alex Deucher wrote:
> Re-emit the unprocessed state after resetting the queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index d74c1862ac860..208b366c580da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1202,15 +1202,23 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>   	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>   		return -EOPNOTSUPP;
>   
> +	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
> +
>   	vcn_v5_0_0_stop(vinst);
>   	vcn_v5_0_0_start(vinst);
> -
> -	r = amdgpu_ring_test_helper(ring);
> +	r = amdgpu_ring_test_ring(ring);
>   	if (r)
>   		return r;
> +
>   	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
> -	amdgpu_fence_driver_force_completion(ring);
> +	/* signal the fence of the bad job */
> +	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
>   	atomic_inc(&ring->adev->gpu_reset_counter);
> +	r = amdgpu_ring_reemit_unprocessed_commands(ring);
> +	if (r)
> +		/* if we fail to reemit, force complete all fences */
> +		amdgpu_fence_driver_force_completion(ring);
> +
>   	return 0;
>   }
>   

