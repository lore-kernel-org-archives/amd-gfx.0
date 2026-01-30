Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3653D46C16
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DED10E8F7;
	Fri, 30 Jan 2026 05:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WOJKQNYX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B74910E8F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBWjpydQELHMi57FVga0U9FJvW6rAJnp0/PJ+yZEwCO+xM92yMu/rBuwt/meLWADSGA4vTzwhUgZmrvGLmA0PpzJOPjW73k/jnCg4dT4Cbk0IMxy7PzlITxk1IjuwkFU5BsmJC+JZzxDZ87p0lFq5dvqJA93F8dhkorI+fAot5vjKujY4MekpF3D2szuiHGyr+9R/WTq3Yax6C7hU4s0WYisxMuy65TaSlYsAUNjNO+7WfJKqnLsi1TE7YoCduJuftf6aLBUBR+Pxk/rUFsdjPdayHUGFUhqEJx/q9/J9W36IRkfQccyVAkWMAVYasKosdP3EcRkIwvGujKClShigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZgOXthLks5EShDrgv9BRRm+NMEhKmvap3uiLCMmxLM=;
 b=NvxEsKnBnB60RTwzxM6URXc3NPmGOMymeLuOI3axBlXqXSlCGQ/ibhoA0R7jfE4j93jKhes+wrYT4e/cbyiFGQ8jyX7mAbrg0kbJvZeodQtHSknsQAv3QdaWhleqvbHj9BzZsRysmV2D/CvEznu0pR2Gxe35QCxtl8GBLuulAnPOIMdQfFMVyR2fGnUiUTc5ZdQpUGWCYV7FrNxNOpvuEtIpJKcEaCdEz2OZzd/dg3C8QeU8pQ0+KyCWGcN8ts/6u0dmhyabqyXEGeE99wXvi0jci+N06tTZuv0asDgSUhCIogf21Qlo6LEvLlEpjADJc7Mm5fz92QcoXZhNLGiD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZgOXthLks5EShDrgv9BRRm+NMEhKmvap3uiLCMmxLM=;
 b=WOJKQNYXLGOtLPE21y9Rb/deqUjYgri1y+vCCveXsJOmTI3o3A0OvRSlczrFJeT+4NpKaztPLbNpL5wRSwSb4fLDOJJ6owaTWPrtxoz2sc77H85U4fOBJJbDYxhcSs6T3TxDeqoNkTRsw8EVvC1oyyvg+rVPq0r3zszBKDhfCFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 05:44:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:44:32 +0000
Message-ID: <b2e1655a-8fce-4210-9673-60d9ac353c8f@amd.com>
Date: Fri, 30 Jan 2026 11:14:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-5-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-5-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bb8ab4-1829-439d-515c-08de5fc2a479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHM0cGJZbEd1Mmt3UkFSdTl4OUhEeUVCVmZoZE5BU3NCc2RabUs0Qm5HT2VF?=
 =?utf-8?B?Rll4RHcydjYzUzdGNXFxdTMyZmhtME9uQ3B1a2d6elZwMGozQ0NZREFKUjVo?=
 =?utf-8?B?MkFyWHRHYXY4WkZrdlVBWkwxZEJVNjZzdTY2SFY5RXAzOW5lUm1KalhTWllh?=
 =?utf-8?B?Mmd2d0tCdzFXVHJlTFFLcjB0VWlkU3pwRDF6eXZRVDEvYk9zd09CVHByc2xa?=
 =?utf-8?B?cTZaVm8zeEFWK0VZVVZuWjJ2c3BIeHdENnA1NnVUZjUrVGJMbzRqUGpTYTNC?=
 =?utf-8?B?VWhCQ2F0K1BDOXhwNEg4dTNpWjlGN29EN0FkeFc0N2FWN0x2L09QVlArNi9F?=
 =?utf-8?B?WnVHY3poYTNXZHI4VG1qUnNXclJvYUpVdkNaUmpDZ2U2TWNLM0RYbWM4cm5r?=
 =?utf-8?B?b1JIMVdmcGIra0VyOWRHOG5hUS9rYVdScGxRLzFhQ0ZyT1QrMi9SRzBwYmFr?=
 =?utf-8?B?N01uaE12SVdXREFuU0tQeiszT2pWbWR5UFpyQmtCSGNBTUg0dGVXS2YvUDJN?=
 =?utf-8?B?b096RTZHcjZZWm1xQjZQYTFzSnFDdkpjT2dKbi91ZSt3OVNmNEhDN3Iydmtn?=
 =?utf-8?B?cUVJRnNjQnNHeG5QTjRhVWdJcVdSVkZ0VmxsM0oyajZTM1B0NndraWFFMDNo?=
 =?utf-8?B?QUNZR0VCVU10QUdlako2OUs3MzN1aG5uUzhNdkI5Y0E2cHdRTnJMUGp5RVFI?=
 =?utf-8?B?c2VQNHYwK0xYVEk2T0I3Y0JQWEVWRFJnQ0ptVFJWc1FpLzlCbFFvWkZlZWVH?=
 =?utf-8?B?VjJWWmRFQWNpbE90L1VsQlBFcktjRFdPZ1dlbUFEdmUxZjBudklRMFVuL0J3?=
 =?utf-8?B?WDM3SXFvTi9RUzc5M3RKSjRJS3hjQlpPdjNSNUdERGRWWkEzWVhTNTB5Uy9O?=
 =?utf-8?B?RTliQjNzT3FjemlaVzMvVERNMExhOW8vNkdBc21qR1FQUW85T2orVDZrcHNM?=
 =?utf-8?B?UjNmL1Z6bndxbVJ3SU1OQ1dtQlFjWnAxcU11ckdMV1dQcGRrMHZCNkpHZTdW?=
 =?utf-8?B?Wi9rVmRGWmNpZzRsM2ZFQnVRQ2ZWYUZnOExrQ1RKSTZ1MWhNeG1FMlNaTTds?=
 =?utf-8?B?Nzk1dHNDODBNOWh1c0Z0OWRpTzlkSjVrRlRzUmkzNFJ0RWUrNXljQjVlSWo2?=
 =?utf-8?B?NmJkWEdlUmJGbDB4U1Fxa3VEdlFjL003WVVHcnFMZXpkcnk5R1R5MFJ2K1NG?=
 =?utf-8?B?eE95ZWI1TVVwNWVvb1hEc2pDcUc1SEVWQmUwemIvcDl6Ly8zc3ZDamEzSjdM?=
 =?utf-8?B?L1p3UHNSdjA1Szg0NFVCSnZjQUpzZlBtOXp1YkZ4QnA4ZkljTFR4aG9iZTJt?=
 =?utf-8?B?RktvdXVkWEtpbVdmK1NQaUI1LzBwa2pPNFpNaXd3djRyK1QxbjBpUDlRMXUx?=
 =?utf-8?B?MHMwVjNxTkJOaTA3NmtlVEVSeGlMOTVQdGR0UWU4UkUzb2QyNTdlczlZZktP?=
 =?utf-8?B?Wks0UVRaRUt3bnVOTkpxdkthUFdja2x5eHQ4RVhXdGxDcG01Qlc0dk1PQ1Fm?=
 =?utf-8?B?RkpFMW9IRjdkNnR0NnVuLy92cisvbVA4UkEzYVZ1Y0JHbU1keENTNWtkT3Bh?=
 =?utf-8?B?NHVmcDhEc0ZES2hOZ1lPWXNZY0Y0ZEJKQXlXZ3kvSkE0aUpzWW4zbjJsQUlm?=
 =?utf-8?B?bFE1OUxiaXB6RlNVZ0xHMG9Db2c2bit1RWdnV1FzWFhqOFJLczdXWTQ4Yk1s?=
 =?utf-8?B?d3MyK1c1NXZiMU5NbTBoME5GZktFbWV5cEhrWmxYTWo3UFpWdWlYelN3S3Iw?=
 =?utf-8?B?YXp3andjWFRJRDUzeDRTWXRNdTN4QXpRcy82eXF4NHkrdk1Cd2NPV2loSTZP?=
 =?utf-8?B?cmM0dmFKYmJBellKdWZtSWxZZEtqZkhXMmZKSlB3NnZPOWpOeWRGUHFXdFAy?=
 =?utf-8?B?Y2YxVGlTSVlpNjdtNjZCeW9qRkloODJTOFNlRllTUXlNb0IzYWdJdDEyaDhY?=
 =?utf-8?B?NjNaL04rNnorNzI0N1Qzb08zOXVIY3ZEN3poWm45TVU1RWhoNHZEVlIwZC9X?=
 =?utf-8?B?dnNmc3VLUFZhV1dFcjVZQW5PTkw5VS93Lzc1WGt4V0MyaVJ5OHVVeGVnL3NF?=
 =?utf-8?B?WlVNUGdXTVFSaGc4T1pxK0kyNHhTem1MNmRDR25IZU9iSStNQXpjd2VpRG12?=
 =?utf-8?Q?D4qA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01uVDhkeE0rWmxNS0p2ZEkydWEzaTUvd250ektKMitJc0VkOWxmbmN4YklO?=
 =?utf-8?B?NnVKWE1ycXF1Y1lLQ0Yrbm9XdGZQWnVOT2kwcDRYajRHcmphdVlyTWV0eHRK?=
 =?utf-8?B?bjBoenhRMHpudnlVOU9TZWV3eElMb0VuaEVqc29RMUViTUNuZFhtdlJMZXZm?=
 =?utf-8?B?L1Zka0dKREpiVXY2OVlZL3o5Tis5bys4U05GMGhzMGwxVS9xSkRrT3kvMzdG?=
 =?utf-8?B?dFF2N3NpUWJCOVR4dDEydmxDSXh3VG5zMExrUWE2aXhNQ2pGNENLc2xGMjZE?=
 =?utf-8?B?WlBLY2JUSjdXdUlKV1plbWJSanhwUmpIeTFRUGtkcWhOdXFvcm5PZlJ1RWFD?=
 =?utf-8?B?S2RYMWRLdEFvVDkrYVRGL2dhWFVmQVRMVGs1bG9MZk4vUWI5TUN4cG5JQ1N0?=
 =?utf-8?B?eEhBU053NGNnLy9OVFcyekVTcFpVWDE2SVg1dHFocTJBakVkNVN2bmNjaWdG?=
 =?utf-8?B?NC9mMFg0ZFNNZEorRTFYdVQ0QzRaWEh6ZC9DNXU1WEtaN3Jacmh0MlgvcWsr?=
 =?utf-8?B?ZU1lSDZQS1RWSTg4T1ZqZTM3NVN4MXhiWVZQZDVUbkp6dkFqOFdSTUd1MnEw?=
 =?utf-8?B?ekQ4V3Y0T0sxcGJkeE11WThSWGdsZFJJV2EyWkx4K2NhMldMOVYwVWhBS3FO?=
 =?utf-8?B?SW1nUUoySldaQzMzTGFsOEw3L2VHYzRzeUlqN1BBZFl1L0FLMU1MdE1uZlY4?=
 =?utf-8?B?NWRhU2t0VWRvRjF0alhSbEcrMmliU2dKUVl4NzNURW1mN3J1VlNKNEZwMFND?=
 =?utf-8?B?WXRGenpqOFBDVXhPdFNUSjBXU3J2dklSN3BqUkQ3T1ZScDJ3aHVkUkdDRUNl?=
 =?utf-8?B?RGp2dnVMMkhXcHdndnlBMVlnNG5yNWtoVG9oaVJhMU5HaE9SN0ZPT2g4VTds?=
 =?utf-8?B?MUNZRTBTYmpia0tkd083RGp0Vkw1U0VKYXR6VU56L1dqcEszYjdyY29oOXFY?=
 =?utf-8?B?MUovN1BCRU0xVVJvSzEybTIwanh4ckk4SWFmckoyQ0JHdzZUNDAyU09xNUg0?=
 =?utf-8?B?dm5SK3Y3bXNKdTJVV3FpODcxNlg4SGRSVGhnWVZFTDFsUGR5R200WC84WGEw?=
 =?utf-8?B?Sld2QWxFYjB1bU52RlhXaXdqcVNrVTI3NTBQWTRXMjhDUXZXVHFnYVp6UDQy?=
 =?utf-8?B?RC9RdjVpUVorSXRrNkFOWXh6RXcvVnM2N0w0WHZycjBtRkEyUlZGUmVLand6?=
 =?utf-8?B?OXYwZkVjM1NDd2VvbUk2dnRoM2VyQW1yUmpxQzBRMjRGVlgvZmJUYlpsaGw4?=
 =?utf-8?B?djJ1Wnl1Sllhd3ZoOTJZTFNWblRvZXdDM3h3aFArUjI5a3l1OXV3MnVyUmUv?=
 =?utf-8?B?eGpDYXk3Z0l4MmlHbVAycDREcUw5UUNFT1NXdkxiNzlaNWErMHp5TC9BVjQ2?=
 =?utf-8?B?UG0yc2gvYXg2M3oyZngvMGRqQnRrUVVwRHZJRHBwa1NrT1R1ZllLYU5kTUFP?=
 =?utf-8?B?N0pmK0RiT3o5Mi9lOWV3RFhsMjV5alB0OVdzSTZvOGxZZk9PQnZzVmdYWU9V?=
 =?utf-8?B?YUJWdWJlZmZzZkdrV0U0QVFOeC94NGhLNTBobU4vNTI5T0lIWUxMMXExM1Rx?=
 =?utf-8?B?ZWJUb3FQSTk2QkUrZEplbVhmT2J4TGpvNHdKSGdsb2ZUNUJXcEwveTBPbW5l?=
 =?utf-8?B?VW5UQmxXRlJOc3YxazVuWEI0eUl0T2h3dlhNdXJmWThiQVpZdllQUGlEU0Yx?=
 =?utf-8?B?MlU2WXZRTHkxRkNLQUkwYUFPQ3F6YTRlWGtVUFNGMVBNTEZNNXpDTExmMlUx?=
 =?utf-8?B?bW85V2JlQkN5QmFNUGZQUmhKRnZPajVpZEYvRE90NVRZWkpENTAxNm1VdUx4?=
 =?utf-8?B?QU50ZEF0aEY2eERaSFdEYlZvU1FWbjd0T0VGVHBGWURDdHJWZVEyWmUxV3JO?=
 =?utf-8?B?QTFSald4cDJaRk5aQXYvZHhIMjViMythSWtzUXBXeUNFYnlLY3E0S25LZGtO?=
 =?utf-8?B?dmlFUDl6ckQ1VGpwb01DREQxWFB2QmphcDhmTndTQ3dRdzl3T0ZmRTZIVjRW?=
 =?utf-8?B?NENhM3FXN29QRmphbkVhOVBrb29aUW9CdWRsZjVadGp3ZWJJdS9mWmZZSDB0?=
 =?utf-8?B?aytIZFVTWGd3b0xDSUJRVEk5dkpXVzU2d2E4U0JsMDN0ZmdtM3pPejUvLzhZ?=
 =?utf-8?B?WGNseW1WQzA1MVlwZjhjeVJDVnQ5YitSYjZPeG9iQkhmRVpUcERtWXBzcS9z?=
 =?utf-8?B?UnlBRFBiMGJyU21HWjNCMDQwbkxCMVR3ZndnUHg1d09GYm01NWhIQXVHTEsw?=
 =?utf-8?B?bzNXUUZxSUs0VHYwM3NOZnVraklRWjZORWMxbkdDY2lIOXJCOWNLcEs1L0p2?=
 =?utf-8?B?UHE5Si9Xc2Z1SE5aRGh1VG9ESmRMN1dYRDRhM0hqY0pYbndad3pEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bb8ab4-1829-439d-515c-08de5fc2a479
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:44:32.4882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJg6yaWs2z21rxbsZM7iJ8ykcM0ir8o8WzZT+SbEFFm8YsKZsHu3vUSwENy2MzqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add wrapper funcs for pmfw eeprom interface to make them
> easier to be called
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 125 ++++++++++++++++++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  16 +++
>   2 files changed, 141 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index e94c368c3159..f880fc49477d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c

If all FW interactions are kept here, ras_eeprom_fw may be a misnomer. 
Just use ras_fw/ras_mp_fw or similar.

Thanks,
Lijo

> @@ -36,3 +36,128 @@ void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
>   	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
>   		ras_core->ras_fw_features = flags;
>   }
> +
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core)
> +{
> +	return !!(ras_core->ras_fw_features & RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
> +}
> +
> +int ras_fw_get_table_version(struct ras_core_context *ras_core,
> +				     uint32_t *table_version)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +
> +	return sys_func->mp1_send_eeprom_msg(ras_core,
> +				RAS_SMU_GetRASTableVersion, 0, table_version);
> +}
> +
> +int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +				     uint32_t *count, uint32_t timeout)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +	uint64_t end, now;
> +	int ret = 0;
> +
> +	now = (uint64_t)ktime_to_ms(ktime_get());
> +	end = now + timeout;
> +
> +	do {
> +		ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetBadPageCount, 0, count);
> +		/* eeprom is not ready */
> +		if (ret != -EBUSY)
> +			return ret;
> +
> +		mdelay(10);
> +		now = (uint64_t)ktime_to_ms(ktime_get());
> +	} while (now < end);
> +
> +	RAS_DEV_ERR(ras_core->dev,
> +			"smu get bad page count timeout!\n");
> +	return ret;
> +}
> +
> +int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +					uint16_t index, uint64_t *mca_addr)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
> +	int ret;
> +
> +	temp_arg = index | (1 << 16);
> +	ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
> +	if (ret)
> +		return ret;
> +
> +	temp_arg = index | (2 << 16);
> +	ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
> +
> +	if (!ret)
> +		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
> +
> +	return ret;
> +}
> +
> +int ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +				 uint64_t timestamp)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +
> +	return sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0);
> +}
> +
> +int ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +				 uint16_t index, uint64_t *timestamp)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +	uint32_t temp = 0;
> +	int ret;
> +
> +	ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetTimestamp, index, &temp);
> +	if (!ret)
> +		*timestamp = temp;
> +
> +	return ret;
> +}
> +
> +int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +				    uint16_t index, uint64_t *ipid)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
> +	int ret;
> +
> +	temp_arg = index | (1 << 16);
> +	ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
> +	if (ret)
> +		return ret;
> +
> +	temp_arg = index | (2 << 16);
> +	ret = sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
> +	if (!ret)
> +		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
> +
> +	return ret;
> +}
> +
> +int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +				   uint32_t *result)
> +{
> +	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
> +	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
> +
> +	return sys_func->mp1_send_eeprom_msg(ras_core,
> +			RAS_SMU_EraseRasTable, 0, result);
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index b41665467368..46f45e82a3f3 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -24,6 +24,22 @@
>   #ifndef __RAS_EEPROM_FW_H__
>   #define __RAS_EEPROM_FW_H__
>   
> +
>   void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
> +bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
> +int ras_fw_get_table_version(struct ras_core_context *ras_core,
> +				     uint32_t *table_version);
> +int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
> +				     uint32_t *count, uint32_t timeout);
> +int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
> +					uint16_t index, uint64_t *mca_addr);
> +int ras_fw_set_timestamp(struct ras_core_context *ras_core,
> +				 uint64_t timestamp);
> +int ras_fw_get_timestamp(struct ras_core_context *ras_core,
> +				 uint16_t index, uint64_t *timestamp);
> +int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
> +				    uint16_t index, uint64_t *ipid);
> +int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
> +				   uint32_t *result);
>   
>   #endif

