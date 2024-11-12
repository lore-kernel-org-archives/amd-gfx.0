Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2074FD32D7E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 09:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE6A10E31F;
	Tue, 12 Nov 2024 09:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r86YW8bg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236AC10E31F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 09:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHr/fbl1catD9S8PHnJvhCmIithj1pfxFCiFSk14oYDO5mbkamtfsl8GmF7KafWkFP1YOsIYCdlYoJColaOwWWZ5bTDyFbhBslCRIs64Q1javtitySsP8W2pMPrK3gJ+YieOIqpWZ1CMZhXJxXH9ihDB25qXd9NOsaXX8r3CjTFiN9+XC9NRfh/FZAaSzQeO/YOkpgYT9IrpR36GtDvQpDMrhlruW8zeQOLL/IkczDlGRyTcyDehCI36JVTS8xtN2jQEm9by4km8bKELu+LrTxkQ+WUTHJYCyAyWEnLwshkl7YbfHtSbdjECduNdYxSop/5iCEFmKtw87kpCx8Xo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkJiI/B1b/FtEjmnGLEmaeDCZKOhYpDNsuDQupnEQHU=;
 b=LTF8HNJmJGd6z7nKdK9FRIA2PGeXSkRxYVZRuV8Fh4U/senP3ZmbyBSfPkF9+VTB8FRHrnE8Mj9Z6iNN9I+9BERCImbHrfIaObtr/qKfepwwNljmq4ev8YzJp3h+/XTk3rMdx3AmR1xyBqo8FxV5sB+N2xL5LsxmZinN7IjU0tIxViH4MKqzmn5jvufU/OVx/Gik1iP3MZvzdu7CWMsUv4JJqFbau4Mkn6nFVIMfde8HtfO/Yk4sgioSoEm1hn+B/gWMTGRHD7a7DstnLVbOiw3M2sYHBLMUXTZ+O2P11xL7FVx15uaL5k6WJ/Fdwj7yV0jBJImZhHUxdhzo0Ziqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkJiI/B1b/FtEjmnGLEmaeDCZKOhYpDNsuDQupnEQHU=;
 b=r86YW8bgZLbpgGx+7dJHgOMWHSl5cuLmz+0GAg5lh4OA0x+CNuL1fr6V+nmlPEGzdU2V0POhYg6kw4Bia9hBvuI9zimsEza7ZvjT+D/DVYdlavBYmOlcUusLYxNnEXUasioRE8asP7jNlydpt8RQ0VzIlDZrWjSya7bV4hUkU5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 09:41:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:41:25 +0000
Message-ID: <0b00a914-0274-4268-9e9f-c2ff3e43da12@amd.com>
Date: Tue, 12 Nov 2024 10:41:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Liu, Monk" <Monk.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
 <BL1PR12MB5269AC1E12A48107FA87A03084582@BL1PR12MB5269.namprd12.prod.outlook.com>
 <6950b5e1-c283-4029-84e8-7dcc42b16912@amd.com>
 <bef834a5-b7ae-4ef0-bd75-55003d38f4ac@gmail.com>
 <BL1PR12MB526909544DD2302032E2488084592@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB526909544DD2302032E2488084592@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5ae90d-2b18-42f0-e2c1-08dd02fe2cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnFjWmZ3ZjF6S3RFU0g2NmZaMnVWTnlHRFdVUlpQa2dnbGNuclp5eDlQYTc0?=
 =?utf-8?B?bXVHNFZGdjV0N1pTZmtqVmhGaHVPN2VJV2lSYkl1Z0NjVzBZYzR0NWdyUFV3?=
 =?utf-8?B?dGRBSkRzSEVRYlBneWsxMlg4dVZDVnpBV3U2RVFxb201d1pQN1NPcVZ3U3I3?=
 =?utf-8?B?V0dyRHhQd0ZkajZpYTNtc3BwTDREOHhDdlNtSmZ4ZXlnc0tENUlXcWpDMVA1?=
 =?utf-8?B?eFM3ektoNzN6YUdJdWx0Q2k2Q1VGZjNGeGF1NE04ZVZHdlVRc0N5d3FpV3hT?=
 =?utf-8?B?TVFTUkRLV3hXUHZnTGFmS2ptd0FudllBeFJJNFNVYUdJUHZSMVRBZXdVVjNM?=
 =?utf-8?B?RHJGMVNTeWRGY2RuenRoZVFzTDlzOUlZcmo3TDR4QTFmdnI2ZGNjOFlOY1JS?=
 =?utf-8?B?WEV1OXpnRDZWd1ZXazJaZkl6NWFQWjhGVW5pWWVjUDBRNkdzRXUxUzZhZjN0?=
 =?utf-8?B?K2JicTNzdThOaDdZTzdickR6c0tEaUFtL0ZjVnhlZ2diSm00Z3Rudkg5dTdF?=
 =?utf-8?B?SGpkdmxmL1Z1eVZlaEYyelYvWEZGbXNoN3JseDV3N01UbWRBYmFPK0NhN2J1?=
 =?utf-8?B?MUNtRTFoeHV6YmVCcXlYNzFWek9tUGp2amRVRE5Vb1ZDKzVWbkRzbG5nZjFI?=
 =?utf-8?B?SUdyOUZ1ZzgvZnZuazFUS2pIMnFLMFg5S1BFb0FoMjBmdjRrK1hxS3VkNENP?=
 =?utf-8?B?OS9LN0dNZkxqYlo2YWgxZHZpem4yVEZEUlYxcnZLSzc0aExuZGlrN1B2RUFm?=
 =?utf-8?B?dzdiQ01sK1lpbjZHU3VjU0g1STdsOWJPVVVJckN4YXZNZmZsM2lVUmhuSVJF?=
 =?utf-8?B?aXFrWllsN1FHSUZuT3krMkNMY2Q5NllQelVMT0RvQ1B0K0NyREJJR2ZuS2h1?=
 =?utf-8?B?dkZ3QWNJcG00V2ZwQXpudEo4Ky9JVXl1UU42ZlN1REcrYmpPdndyT1UwSVpM?=
 =?utf-8?B?R3IrL1E1NlFHWEcvOHIvRnZxUGZnL2NRZFhibXBMc1RnclNSLytvK1NKZURG?=
 =?utf-8?B?SHh2WGJIS1R3NzJDM3NPdndFS0thTW5zc1NucWRqSStpdUpwdElxZm9QdHFz?=
 =?utf-8?B?Zk5oM0xjYmFjWjVHWDRlZS9MQjdzakRncU5CS1FjWTVwUGU4dXNzRXVUWG5R?=
 =?utf-8?B?bmlMc1ZqL3dDWms3ZXhUaG94ejBtV0VPMERaY1Q0b3REckZmbmt4ZFBrbE96?=
 =?utf-8?B?NHZLVlhtRkR2R3VuQ2ppMm5UUHRjM2pDZG04QjVSZFAyVHFmd3BLV1gzd2ZW?=
 =?utf-8?B?djQyZERyd05BZ3ZleVl5c3l5cXJ3dmNWcyt1YlN1R2p1bk1PRStrbkc1VkdD?=
 =?utf-8?B?YUw1ZEJpaUlCS1Z3aXIxa0hJeE55azhjZitqU3lsWDk2QlBOdmwrN1RXVXNo?=
 =?utf-8?B?NU84NE1iQUdkcEVnY2NmNnhuN1VGOWpEOXBnK0poT0h6TytrNFRRVUFhWE40?=
 =?utf-8?B?MmI0SHd6MWNHOFd4L2VhNXFvcnlMUVNxamJUa0xPcnFLTUxaZnJvQ2E2OTVI?=
 =?utf-8?B?b1VxNzBoeHNxRUcwVXN3SlNPVzdJUG9xVEtzQUtTVnVFNTl4NFJOdVloR2Zl?=
 =?utf-8?B?bGs3S1FTcGh5SlNYeGl6ZDlDK0dScG1VZHl4dHNoYWZyQ3FPYVg4M0FMZzBK?=
 =?utf-8?B?RWFjMnp1NjhmS21wNTVYeGt0alNBMGtTSS80bjROa3MrSGJ6Y3dVcVpGMENG?=
 =?utf-8?B?QmY5encyRE02bFp2cUlFMnZDNjluM2NuRmV5NnFmei8yWHRxV0pqZG5ieVJx?=
 =?utf-8?Q?NgBb+n/tFrQhqsZ/WiXPpPI5PVIz9KAgqolox6U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFlTy9DQWxQcUx0ejcyUHF5ZlJyd1E1NE13bzlwVGpRdDRhZmQ5WTlXQ3Mw?=
 =?utf-8?B?RTMxdW1ZV05HWU9TV1J4TG1GYnRKZVlQaGZ0NENQZ3IyMGpKdHBRQ1BJOUtJ?=
 =?utf-8?B?OVRjTlVHbWpDZldpa2tZQnVnMmtxc0ZaQU1JWTN6VjBEaFZiV1d3NzBGWndN?=
 =?utf-8?B?dXcxTEhXa0JMYjlXV0NVaWRaUEk3SmxVNWR2VW5xR1pldGsxdWZvQlVlQ0hJ?=
 =?utf-8?B?MVBYSGk0WFBBRStkbTA1R1hOenJaV1MzWFJYVVlLQ1dnVlZDNG5RQjJHTFZF?=
 =?utf-8?B?Um0vR2QzcUVpbjhHejR2eS81citMMy9UVXBta3RXcE0xZTJJcUN6SHlMUlA0?=
 =?utf-8?B?Q0orU1ZFS2tRdFhZNTdNSU52QlRBUkEralVJa0U5WHhRdkdRTktRaURQOEFR?=
 =?utf-8?B?c3ZEOW1Oay8vdzNabi9hSHhtN1lPUFlGZkZqWTNGSktza1pOOU5vaUxkWlh4?=
 =?utf-8?B?NDV3blVFa1ZJbmd6UDlIZ2hhVzhWNnl4ZEhpSGdjNGxZT1ZXS3FNMFpYTERv?=
 =?utf-8?B?dU5kVlhhQTZHOE9IUTZyQU5aUWJWNnVrZkUyK3dITXVCQVZXckVHQVl3QkxI?=
 =?utf-8?B?Zk1PdEtRVjBJMndLTXAwOGhod25IL1BxSHVMV3Z6cHJxaFdFcWovT3gwQXlB?=
 =?utf-8?B?bXdMVUZoYUdsUE8wWVJYaHJRVzN4VlNUcHRyVkhRR3pvekxMTVk0djFWWFVl?=
 =?utf-8?B?LzVXc1I1WVZpemM3VXZpd2g1dkExQTNHaHNwTkF0aVlFcVdidXEyNDhnV3dv?=
 =?utf-8?B?Q2ZvL1pWYzhNTCtkYzNpVzB4YTVBNUZEVW56MzlMckhKQUg2UVlFWHBMSHRE?=
 =?utf-8?B?c09WVWdPWlBNdk9uaG85TDlXd2w3MlMxUU5jU2RMVnFyN1BzYmMvakdQUE91?=
 =?utf-8?B?VSt5dTF6Zk41M3V6S2RGK3NEMnR2eDhVbWlmWXBDRWRFb213SUQwY1VpY1dG?=
 =?utf-8?B?SThwWFYxQ0NjNk0rWjVpeUpxU3p6d2FxNm1sYURGa2tRRGxDWUVLbEdKV3FV?=
 =?utf-8?B?NEN4U0podzhoSzJOTzRxWXBwQ1VycmVuUHR4TytHUXV1QlhZVzJkS1ZMY3k5?=
 =?utf-8?B?bm9BOUZLcEFxN1Nob0lrQTBFaFIzeDdkQ0xSTHcxT2lxdktqL3lqdkRRZXdI?=
 =?utf-8?B?YlVuYzczaEJ3b2c1M2RHdWM4Q3VLQmxFQmRFMjY4RHF0cjVqS0E3MnpLMmVi?=
 =?utf-8?B?cW1oWFg1VEhkWnB5UnRFK0IvR3hOMmxxaTZqdEJRS1krNnNMeXMyVjRiNWNN?=
 =?utf-8?B?MlJha1g0aXZBcHN2RW5CQWxIMG9YZUdqYzBETGsxVFNUbEtndEFUTFpic2Iy?=
 =?utf-8?B?RjVPZ0gzNCtaTUJ3Sy9ZMnV5RldrUDZOTUtoQnF2ckhtVTJ6Y285UGIvdjR3?=
 =?utf-8?B?T3ZrMldEWHF2ZTZsbHN2bE0yR1NWTDlCeEVtQ1V6U2IyVk1DOGZGbmVpT215?=
 =?utf-8?B?SUtCd1d5UU1kUWM0bTFEQWZGbm9QbzVKU1FtWWJMVVhRaXlJaVV0R2hTdzky?=
 =?utf-8?B?OThGRU5qQ00yNnlRVUxMVmJONWVTcXJ1QnVQN2hVVlFHR3FNS0dpQ3ZCQjQz?=
 =?utf-8?B?K3VvdFYydTg1ZzhkZ2s3cHRuNzhmYXdFUzZTY2djTTJNalFVdm5hNVh1UGVp?=
 =?utf-8?B?WDZVVy9yOVJDVjdPNDMyZTd1d1lyQmQvTW1aR3h0dGJBUk1OdEdINjBmR05m?=
 =?utf-8?B?eXlVbklxOHN4d2RvRWFxR2JBeUJzcDR4TmJaZlF0OHNTbVRNM3pkSVNic1lu?=
 =?utf-8?B?R0d2ZWIrZUsrdkE4Q2lQL3pIRGxrOGtOM0R0QS9MM0dZOTNYRThvYVl6WHcx?=
 =?utf-8?B?OTVNWU5pSFBYaG5xMm44VG5zWk83dy85aWlQWjZJbnJVYkpkZTNWdWh1MTBM?=
 =?utf-8?B?UUhSM2Z4VFdldzV4SHVzNzEvRUpHSFczaENQeVpoS3NCWmhrbWpIV2E2YzZv?=
 =?utf-8?B?eG81ZnJmYzRIT1c2dlUrYmIxakY5Z040eGlmUXhHWjgyVzhFcEw5cDhYWG9u?=
 =?utf-8?B?VDA1Vmd4RURjcUhRL1lmZExRVk1NVGg0RHE1Yk94dkl1ZTJSOHpQUFFrajFT?=
 =?utf-8?B?TXlsSmd3WWIyUXBEUHhua3pjMmRGTjJCVUV1NUVmYXlEQWxqTjl4WXZRYWlN?=
 =?utf-8?Q?vmpH7wFLOaKf6qUosFZJTR5sQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5ae90d-2b18-42f0-e2c1-08dd02fe2cc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:41:25.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aaYsvdGPCWj38mIotD6r2w+cogleRzJ/LHF5k3Ri0m7YCJRUd8gw5tk734c4B8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

Hi Monk,

> The memory we are talking about is pure guest system memory not FB BAR right?

No, that works a bit differently.

QEMU and their virtual drivers uses a virtual PCI MMIO BAR to map 
buffers from the host into the guest. Those buffers can be both point to 
the FB BAR as well as system memory.

Only the host knows if the buffer is backed by MMIO (FB) or system 
memory, so only the host can setup the tables to have the correct 
caching and WC attributes.

The KVM patch completely breaks that because they suddenly say that not 
the host setups the caching and WC attributes but the guest.

Because of that this KVM patch not only breaks amdgpu, but also other 
drivers which do the same thing. The general approach of the patch seems 
to be broken.

>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>                   *kq->wptr64_kernel = kq->pending_wptr64;
> +               mb();
>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>                                           kq->pending_wptr64);
>           } else {
>                   *kq->wptr_kernel = kq->pending_wptr;
> +               mb();
>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>                                           kq->pending_wptr);

We should probably move that into 
write_kernel_doorbell()/write_kernel_doorbell64() but in general looks 
correct to me as well.

Regards,
Christian.

Am 12.11.24 um 04:50 schrieb Liu, Monk:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Lijo
>
> Thanks for your quote to the SPEC, yes I read that as well, supposedly WC storage buffer shall be flushed to memory with mfence, but it just doesn't work after applied that KVM patch which honor the WC attributes from guest.
>
> This means the WC storage buffer from a KVM guest couldn’t be flushed to memory even with mb inserted... I don't know why. (is there any inconsistencies between nested page tables and host page tables?)
>
> Hi Christian
>
>>> The guest sees driver exposed memory as "emulated" MMIO BAR of a PCIe device, that's just how QEMU is designed. Because of this the guest maps the memory USWC or uncached. But in reality the memory can as well be GTT memory which is cached.
> The memory we are talking about is pure guest system memory not FB BAR right? Therefore, I don't see why in reality it has to be cached, you see that only guest vCPU is accessing this buffer.
>
>
> BTW: we should aways insert that MB() in our KFD part:
>
>>>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>>                   *kq->wptr64_kernel = kq->pending_wptr64;
>>> +               mb();
>>>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>>                                           kq->pending_wptr64);
>>>           } else {
>>>                   *kq->wptr_kernel = kq->pending_wptr;
>>> +               mb();
>>>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>>                                           kq->pending_wptr);
>>>           }
> Thanks
>
> Monk Liu | Cloud GPU & Virtualization | AMD
>
>
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, November 11, 2024 8:40 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
>
> Hi guys,
>
> trying to merge multiple responses back into one mail thread.
>
> Lijo, you're completely right, but there is one really strong argument you are missing:
>
> The patch here doesn't change the write combine behavior, it changes the caching behavior!
>
> So when the patch works and fixes the issue, then the issue is 100% certain not a write combine issue but rather an incorrectly applied caching :)
>
>>   From what I heard there was a KVM patch to correct the mapping behavior -- previously the mapping is forced to cache mode even guest KMD maps the buffer with "WC".
>> But after the patch the buffer will be really "WC" if guest maps it with WC"... and this reveals the bug and hit our issue.
> Yeah, exactly that's the problem. The guest doesn't know if WB, USWC or uncached should be used!
>
> The guest sees driver exposed memory as "emulated" MMIO BAR of a PCIe device, that's just how QEMU is designed. Because of this the guest maps the memory USWC or uncached. But in reality the memory can as well be GTT memory which is cached.
>
> So forcing the cache mode even if the guest KMD maps the buffer with "WC" is intentional behavior, that's the correct approach.
>
> The upstream people realized that as well. That's one major reason why the patch was reverted.
>
>> Can you explain why USWC for ring buffer is safe, why it will not hit coherence issue, why you don't make all ring buffers with USWC even for amdgpu side if you really believe USWC is innocent ...
> We already tried this, but there is simply no benefit for it.
>
> Regards,
> Christian.
>
>
> Am 11.11.24 um 06:58 schrieb Lazar, Lijo:
>> On 11/11/2024 7:00 AM, Liu, Monk wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi Lijo
>>>
>>> This is the patch we verified before:
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> index 4843dcb9a5f7..39553c7648eb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>>> @@ -308,10 +308,12 @@ int kq_submit_packet(struct kernel_queue *kq)
>>>
>>>           if (kq->dev->kfd->device_info.doorbell_size == 8) {
>>>                   *kq->wptr64_kernel = kq->pending_wptr64;
>>> +               mb();
>>>                   write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>>>                                           kq->pending_wptr64);
>>>           } else {
>>>                   *kq->wptr_kernel = kq->pending_wptr;
>>> +               mb();
>>>                   write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>>>                                           kq->pending_wptr);
>>>           }
>>>
>>>
>>> This mb() doesn't resolve the problem during customer's testing, I also thought of MB() first in beginning like you and Christian ...
>>> The mb() here shall resolve the re-ordering between WPTR and doorbell kicking so GPU won't fetch stalled data from WPTR polling once it receives notification from doorbell kicking.
>>> (in SR-IOV we set doorbell mode to force GPU still fetch from WPTR
>>> polling area, doorbell kicking is just to notify GPU)
>>>
>>> And by your theory: mb() shall flush the WC storage buffer to memory, thus, this mb() shall also make sure that the ring buffer is not holding stalled data anymore, right ?
>> This is not my theory. All the quotes in my earlier mails are from
>> "Intel® 64 and IA-32 Architectures Software Developer’s Manual".
>>
>> Yet another one -
>>
>> <snip>
>>
>> Writes may be delayed and combined in the write combining buffer (WC
>> buffer) to reduce memory accesses.
>>
>> "If the WC buffer is partially filled, the writes may be delayed until
>> the next occurrence of a serializing event; such as an SFENCE or
>> MFENCE instruction, CPUID or other serializing instruction, a read or
>> write to uncached memory, an interrupt occurrence, or an execution of
>> a LOCK instruction (including one with an XACQUIRE or XRELEASE
>> prefix)."
>>
>> </snip>
>>
>>
>>> But we still hit hang and get stalled data from dump.
>>>
>>> Maybe we need to put mb() in another place ? can you proposal if you insist the cache mapping is not acceptable to you and we can ask customer to verify again.
>>>
>> There are a couple of things which are still working strangely, they
>> will need some explanation as well -
>>
>>        Even though write pointer allocations are also to WC region, and are
>> correctly seen by CP every time. Since it needs to get wptr updates
>> from memory rather than doorbell value, don't know how your snooping
>> theory works for this. Also, it is weird that WC writes to those pass
>> MQD buffer writes even with fence.
>>
>>        MQD allocation for user queues are still from USWC as per your latest
>> patch and they still work correctly.
>>
>> For debug -
>>        Is the WPTR reg value correctly reflecting the memory value? Have you
>> tried initializing MQD to a known pattern (memset32/64) like a series
>> of 0xcafedead and verified what is seen at the CP side?
>>
>> Thanks,
>> Lijo
>>
>>> Thanks
>>>
>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Friday, November 8, 2024 7:26 PM
>>> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>;
>>> Zhao, Victor <Victor.Zhao@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>> <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>> wb pool
>>>
>>>
>>>
>>> On 11/8/2024 4:29 PM, Liu, Monk wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
>>>>
>>> Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.
>>>
>>> All prior loads/stores are supposed to be globally visible. Hence mb() followed by a write pointer update also should guarantee the same (From Arch manual).
>>>
>>>           The MFENCE instruction establishes a memory fence for both
>>> loads and stores. The processor ensures that no load or store after
>>> MFENCE will become globally visible *until all loads and stores
>>> before MFENCE are globally visible.*
>>>
>>>
>>> Ignoring the amdgpu driver part of it - if mb() is not working as expected as you claim that means something is wrong with the system.
>>>
>>> USWC or WB for ring type may still be a separate discussion.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> The issue here is not the re-ordering but the stalled PQ.
>>>>
>>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Liu, Monk
>>>> Sent: Friday, November 8, 2024 6:22 PM
>>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao,
>>>> Victor <Victor.Zhao@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>> <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>>> wb pool
>>>>
>>>> Christian/Lijo
>>>>
>>>> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
>>>>
>>>> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
>>>> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
>>>>
>>>> This is why only cache plus snoop memory can get rid of inconsistence issues.
>>>>
>>>> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
>>>>
>>>> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
>>>>
>>>>
>>>> Monk Liu | Cloud GPU & Virtualization | AMD
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, November 7, 2024 7:57 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>>>> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>;
>>>> Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix
>>>> <Felix.Kuehling@amd.com>
>>>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>>>> wb pool
>>>>
>>>> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>>>>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>>>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>>>>
>>>>>>> As cache GTT buffer is snooped, this way the coherence between
>>>>>>> CPU write and GPU fetch is guaranteed, but original code uses WC
>>>>>>> + unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>>>>> Can you elaborate on this?  I can see CPU reads being slower
>>>>>> because the memory is uncached, but the ring buffer is mostly writes anyway.
>>>>>> IIRC, the driver uses USWC for most if not all of the other ring
>>>>>> buffers managed by the kernel.  Why aren't those a problem?
>>>>> We have this on other rings -
>>>>>            mb();
>>>>>            amdgpu_ring_set_wptr(ring);
>>>>>
>>>>> I think the solution should be to use barrier before write pointer
>>>>> updates rather than relying on PCIe snooping.
>>>> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>>            if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>>>>                            kfd->adev, size, &kfd->gtt_mem,
>>>>>>>                            &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>>>>> -                       false, true)) {
>>>>>>> +                       false, false)) {
>>>>>>>                    dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>>>>                    goto alloc_gtt_mem_failure;
>>>>>>>            }
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>

