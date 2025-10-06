Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDE0CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 10:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AD010E3E0;
	Mon,  6 Oct 2025 10:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XwUPusSM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1835D10E3E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 10:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMJBqa9Zcc6+iILBpFeWI0fI05TvRvekFcuSXg7aSuT/BCaVfZMOPjLptNgCQtlx0bOY574392JlGl7jO9YosWU5Oh3lwKZ8Gz40VnHaFKCKTf5vZIETR9RFuXsYRKgmRCDblTBQfqnAgdX+ksebOMJLNmsJYVoMIrwWhqWNxVKMraUNpDNxkZrblWctMZXKV5TZaKgz0APC2C7BtvtqNqJ9jH4/nJe7D6rkhzWSQIDaqvCfaL+wmPyKl+8UL+4Im/XRPfGkVK44+NMkJYoVwGpZ/pw1/3s3NqHnmBTmFYnPcAH46XO8VjIh+3zYbHJemOmplYs1pKFaVsojSto0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlYjLBw4M3loubwuQVYa8c4rFZqitW1GrJNlWUwAAGY=;
 b=DDHlXM8YQCsDMJEbbNipTDzH+BsDiLXXn/tcL2xwK3/6R1y3tEaQUP3t3YecWepoWRqN33zi3XOIpiMRASgL2eeyvahivbGUYlP+dWEA2JPjFS/GNlJjpdjH7odAwB5/bMUcgRtonCpaZjhLLFuYar1WWQ9XGLXduYYcET+1P55MlSiZ7lL5HHC/Ch3lnl5Fov5PJiMr/mmiHhCQsVwYeMsjdxOkinbueRY2rVV+Gu5WN6TfNBYcI9nt7gVg6bT6eiVo13Uicc+PQRxaIse04lDNYfV2lm9/mUplWNaowQh2u0gd0SnmvpJJhc1aT/IDRD3S4ievLWkLofxs655nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlYjLBw4M3loubwuQVYa8c4rFZqitW1GrJNlWUwAAGY=;
 b=XwUPusSM7WYdgT4SoOZ/DToNx+n1JSmfSnENr26AAUWfMw1OrAicVPqrwxd0ZNfyV1OtI1WpMYnS4sRzZrPWrmyo8X9Y0y0ENzBa6sWAyQfG14T+s7KCa5f7EkKScWMBPYC0g0KI0EcyqXiAa1mSm4N8ZX8FY3JHLQk+tn6IWbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:36:07 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:36:07 +0000
Message-ID: <cf56bd08-3989-46c6-8958-867c5a0b2aff@amd.com>
Date: Mon, 6 Oct 2025 16:05:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
 <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
 <ea08dc41-a919-4b44-9274-a962b707fa83@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <ea08dc41-a919-4b44-9274-a962b707fa83@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: c3969c7b-20e3-4d1e-6bb7-08de04c42834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01Qdk5wd09GYVRKcjM0SjNYZ1YwU00rQXhjUnQvb3RlVzV4WFZvZWdQcEdm?=
 =?utf-8?B?aUVDNTRYM3JKWkpXSjZjMjlibTdwbkFjSDd1WHNIb1EvZHdRWUxsMXpHZzJ4?=
 =?utf-8?B?TExHSEpLanVrdHBaMEt6Q0xvdlZwMytlTTlpL3c2dzQwVWdaSXdaYU52b1hu?=
 =?utf-8?B?Z2QvRzZFT0xWcUpQSHUzeUNOd0s0amd5b2ZRaC94VXI5YzFWVWF3SnFhcGFj?=
 =?utf-8?B?NUhnR3pwcFF0SERNRmRRMmUya3MzN0plZDFnL2hveXRJOXpvb21jQXRrQmtw?=
 =?utf-8?B?RWltY0hTUmxETHJLcE5RUjlGRWJ4UnNITGg1QjJ2MXBXRHpFYStTcE00Qkta?=
 =?utf-8?B?RHFPOGtpdWEwNmhhV2lMbVhQWHJNcFRMRk1BWUxJbndpN0RtQkFYbmVseGk4?=
 =?utf-8?B?Wm9FTWdCOTQ5bFZ2blM1T3UxeDI2MitHWjdTWVVtMmNPcU5HbDNaWklQNnB1?=
 =?utf-8?B?UVl1d081NENocmI0d1p4aG5KVlRNM2Y0ZGRDRjdYT1FSaFduLzRnUTNZUS8r?=
 =?utf-8?B?dTRFdUZHSDAzaFJkeGtVbEt6Z1ZMOGlZRW1Dc2drY01kM1BzbUhkbWpCd3dZ?=
 =?utf-8?B?NEFoWXNteDhhZi8rNllUMjFySjNrbUkwendiYStMU1cwSEczdmFnWW1KcTht?=
 =?utf-8?B?OXErY2pxaHRzNTB5L2pRYktYZ25zYkJ2SUEzRGJ5WGpLb2tnWCtMZ016YzR5?=
 =?utf-8?B?VThkZ0tFd0NnR05VQ3VuMjFUUy81UHU3UUFva0NjZWhGdUVjMGZMbmZDSFRY?=
 =?utf-8?B?emFqWDdIOXJXdklPQlAvSEVrYU9BeExmRW9JVW1OMzNCMEJOZWFlZktSdHlJ?=
 =?utf-8?B?akNDSDA5WmI5NVZKWFZJaHp6R0tIZVBTeHNEaUUxajZUamRLamZGNGVBZmRi?=
 =?utf-8?B?WFlXMWZFZVhDSGNINEF3aXhjMnBhN1ZrU2g2LzBhYnUrMURLbG93OE9sOUxI?=
 =?utf-8?B?dEVrNmluUkZraUlPNDd0RVU2NDRRbU9mNHpVdEdrNm9DVzJnR2hnUjN5YWNP?=
 =?utf-8?B?Z0ZLeDIxZER0ZS9nWWhJUDd5bEhKSERjV3k5eDBrZCtZY3gwdXZ1UHBhOFov?=
 =?utf-8?B?c280YnpXYW02YU83cUYweTRXb0k2MUFzQmUrYmhXU1FubVNCamUyRzhWanM3?=
 =?utf-8?B?S2czd29jRGY3VHlQRUwrK1pvSExaRVNVQ2hMcVQrejZadno0SzhnUDEvNmdI?=
 =?utf-8?B?QzN4ODUxd3d1S2E2Sjd0RlVJSmI5Smtpc3VPUHNNTnhKVlg4YU1lQ0JHUi9T?=
 =?utf-8?B?MmlET0sxUFRWd0VuTTcxMVVhU0Z4SEpsbXIxbFBkUlNnTmdqSis1MnhTMmlR?=
 =?utf-8?B?ek9kY24zZzZmMGJpNWxjcXk2eHdqTGp2WUFiZldoOWF3K3d1ZXR5T3pQdWtq?=
 =?utf-8?B?aHlmNm5IczViSExpMjBmYmh4UXlkMDdRSWxLMGhYallFZWJBWVkwZWo4N2JG?=
 =?utf-8?B?YzhmUVJSRWdieEYvSkU2YjdLWFVqWFdPSTdqOTc0TkwzVHg2M1Qwb2lwU3Nm?=
 =?utf-8?B?K0hZRC9KM2RsZkZvblpnSE9yTDlQbVNpTFpCM3RZTWNncU1hV1BLanJYbWRJ?=
 =?utf-8?B?eEtLNmxrb2lqbDJ4ZDdxdXJsM0JSd3FHQWF1TjRtS25pUThjNXJwSmtRNXM5?=
 =?utf-8?B?SWc2WUQzSlZtckxDS29ZTk1QYXRYTytYWTNYaXRuUEZrQkhEa2VzcjNSQXF4?=
 =?utf-8?B?TUNZL3hZdlJOZWxxbTJHL0E1T0Y1dnlrN3hkWUhjWnVpWlpmMnNQSGs3YnR5?=
 =?utf-8?B?Vmc0WUJGald6RmtIK3pFbStodG91K3ZIUnRRYXl1cFFmQkRnSG8xYldJK2g0?=
 =?utf-8?B?b05hMlhFWTUwSFNkUkV6QVNQeXI3LzJtWStEZTM5MDdqNHU4djJNSWNsdjF6?=
 =?utf-8?B?d1pTMjg5YUFHR2tnemdlam1MSU9manAwMHh0angrTmpKdEx2dmZxd2ZTNHhp?=
 =?utf-8?Q?J9jvoLTHcNixxZAEWGJFXLwx5y9/3fqA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0l3eFpMcHFyOXlzV0J2ZVYxRkYramVkK1hZRC9xT0VCbXAxTkpQTklKYUV2?=
 =?utf-8?B?UGsrZXRyQjhRc2Q3QzJUV0QrUjl0NXRqaTl0Ny9EKzgzejdFUElGZ3V1RDA2?=
 =?utf-8?B?WmFybTFxYjFVejJRMjFKYXExcVIyWlo1cWFHMi92Y1E1cGdpQTF5cElNSzBE?=
 =?utf-8?B?bXBJRjRlTTlETGZUWlVsMlZoK0NHaUI3NEtOVzgxZ2xKdDUrOTR6dkYyVGZX?=
 =?utf-8?B?S1Z2VEQ2dk9wZGZobXZlTmV6TU4yTStEMlhOVDdBQ2F2clZza2p1SEhwOVhE?=
 =?utf-8?B?MEgwVE9KV2Q2UTRUcXU3cmFzM3VweDVLelVVRHQ1Z3R3cGZ3cDBremljb21s?=
 =?utf-8?B?MTNKL293TlhpaFJ0UlU3MXExaDloekhpWm1oTkM5cHE4YXFzRHF6S1BtQkxi?=
 =?utf-8?B?YVllUFlkUld1Um5EVWVDcFc0cXlsY2ZqSTdWd2ZKeW5wQnlrV3J0SklwYXFq?=
 =?utf-8?B?T01kTm56K3hZMEpTRzFiZFQrQ21CdXJVanpRMng2SkFKZVRNbjR0M3RDOElN?=
 =?utf-8?B?YlhXaEJielByTkFKV3ZFSFQ2ZjMwemhRWmxXRWNuMlltWEt0MU5SQXQ2eG9B?=
 =?utf-8?B?Um4rVWhwdDBka0RReDJuODFtaGdiTDlpQ3BjQnNhc2ZWSmtBZTJkcWNsT1pD?=
 =?utf-8?B?d3NiK1I2aElUMk1RdlYwU2tleTR4RkszQzVrZ044SnVneU1tYlhIbG4zbnEy?=
 =?utf-8?B?NnR6Y0N2UVVYMkM0ektVbzVFSlV3eU9FL3NwRURnSW9RS0pmamNCY2k1cUdM?=
 =?utf-8?B?VGk3TjUwNStnSU1WMFNuUEtmNzFIam9xWENkRm4xNFZTYWVuTVBKenFtVVV6?=
 =?utf-8?B?azh5RzMwSi9haW9wUlA4bTYwRzdYTkpRU2F6cjl4SDNjVzZLUUlVbWlFUnE5?=
 =?utf-8?B?WS9rZjhndkN2TU1nQ1MvNVhDQXFrM1BkS0xndE52NDNvamdZa2VJU0VFVnVT?=
 =?utf-8?B?RUhubzNmL2IyQVVvT0tPWUlpeUFkUzdTM1lnb2dWeXJzVXVRY1hzeXZGZ29J?=
 =?utf-8?B?ajV0VTA0dnpldnB5dnl1NXdyY3FtT2pPcjArTWhyaUN4REZ4bXNiSU5FWUNm?=
 =?utf-8?B?ckFKc2hBQlVxZGp1Ykx4VFg0MDBQQmFENU9BWXJwa1UrL0oxbmQ2QTROaHFm?=
 =?utf-8?B?YklKL2dJS1dYZnRuQjBpdWp5SzBsVGdCZWhwbUxVUmdiN3NNbjVodjFmK0JU?=
 =?utf-8?B?dFBMRnhJcTllMGJJTlpvczhzVWlkQlNNVU04QzJtTWs5QUpXRkR4Z2tNT0s2?=
 =?utf-8?B?cGlRZ3daQjZIQVN6Snd3cXB4R0x2bGFjMmdObERXWjk0aDF4Z2cyZTBuWjVG?=
 =?utf-8?B?aEZUV3c0Zmo4TWVSUzJKSnhFdEZJakRjUjh5dlhqbS9PY2hwTUVPZWJiU1c0?=
 =?utf-8?B?RTVxOGV2Z1dJcDJHQ0hmNzlqeWUrSHdycmxqN1hVc3VmUXl6bERZWEJwTDc1?=
 =?utf-8?B?eHpXSVR2dW9tZWxqWDdqUmNqNXE3YktXSUxvWEU5L1h0eGhjZlZ3OXJoOUhi?=
 =?utf-8?B?M1dPY0crK0taVUg1OUNGNzd5NkNhNUs4ZnNoZ2t5anFtZUdNMWNDKzk3bGw1?=
 =?utf-8?B?V0QvNnlUNnFjMXZlMDljTlJ3bEtSeGI0UEQ5MjR4bXl0NVE0cmp5SnU5N2pS?=
 =?utf-8?B?Yk1jLzZZbkE4eE1ZK0tKZXlxK2ZMaXpadWRmM25JZTdlKzJGcDFsb3JpVm9J?=
 =?utf-8?B?MlQvS0Rpenp4NHRibHJHdzRKaTNyTkEyMWNmN05seElWU2lDZTI0ZUxPOGF4?=
 =?utf-8?B?YUFNS1RhcE1iN2hhRmdNNTNnSjJMTVNBWlJseCs2OEVDWDA1cHRiVllSRjY5?=
 =?utf-8?B?dCtvVi9TczFwdHdjY1FSbFRCQ0UvNkZkQTducWZNbFEzK0dHc3IrZ0R2dmJL?=
 =?utf-8?B?MnJyanQzTWl0NFZxZU04L3JDaDNVT1JQT0F4OEwyRzN5d3JYaklORURCVll3?=
 =?utf-8?B?dkpYRjB6SDhnUko0ZXhNQW4vb0JFUSsrc0tsMVRkRWdQMERiWlBpTjdka3dm?=
 =?utf-8?B?YlM4TEZHOVZQYUxBVHpsN2NEMnJZaGpLVFZmUHJpUDdFcjROYkZHUjN2V3Vz?=
 =?utf-8?B?c1d3R1JOYjlTWU9aMVdIUFF0THBDdFY4MU1NRGNJNFNLN1Q2MGFyazJQdjJO?=
 =?utf-8?Q?uXXOZdAn9ET5vo1IpdRynO30f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3969c7b-20e3-4d1e-6bb7-08de04c42834
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:36:07.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R14u4QW1qsJgWROyGHlwS/uRLPpjO1al+jks7B8hA64Vg7kOqgWqHMsvRUZl0MBuYTkf9GJ2StxNlKsPbyIZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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


On 10/4/2025 1:53 AM, Chen, Xiaogang wrote:
>
> On 9/26/2025 5:53 AM, Khatri, Sunil wrote:
>>
>> On 9/24/2025 10:27 PM, Kuehling, Felix wrote:
>>> On 2025-09-24 06:01, Sunil Khatri wrote:
>>>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>>>> along with it callers to use a user allocated hmm_range buffer instead
>>>> hmm layer allocates the buffer.
>>>>
>>>> This is a need to get hmm_range pointers easily accessible
>>>> without accessing the bo and that is a requirement for the
>>>> userqueue to lock the userptrs effectively.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>
>>> What's the reason for this change? In the current code, the 
>>> hmm_range is allocated by amdgpu_hmm_range_get_pages and freed by 
>>> amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.
>> Sorry i missed your comment. For userqueues locking the userptr bos 
>> and making sure we have valid userptrs at the time of validation 
>> seems too complicated, so along with christian we decided to use 
>> hmm_range list instead and have reference to userptr bo and via 
>> hmm_range private field to be set to bo.
>>
>> Also i did made sure that wherever we are doing get pages and 
>> allocating range the freeing part is taken care of. Specially for 
>> freeing the memory is still done by amdgpu_hmm_range_get_pages_done 
>> only. Please share if anywhere i missed something. Also Christian 
>> brought out the point to have separate alloc/free for hmm_range which 
>> i am working on and will share soon.
>
> This patch has other components to allocate hmm_range, freed it at 
> amdgpu_hmm_range_get_pages_done. This inconsistency makes other 
> components handle error case awkward.  It is better to let other 
> component free hmm_range no matter amdgpu_hmm_range_get_pages success 
> or not. And amdgpu_hmm_range_get_pages(done) alloc/free 
> hmm_range->hmm_pfns. That would be easy to understand and have less 
> chance to make mistake.
Yes, that inconsistency is there and that is to be fixed is taken care 
by having separate alloc/free functions and not use 
amdgpu_hmm_range_get_pages_done and some more clean up done in other 
patch since this code is already merged.

Regards
Sunil khatri

>
> Regards
>
> Xiaogang
>
>>
>> Regards
>> Sunil Khatri
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 
>>>> ++++++++++++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>>>   8 files changed, 38 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 7c54fe6b0f5d..4babd37712fb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem 
>>>> *mem, uint64_t user_addr,
>>>>           return 0;
>>>>       }
>>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>>>> +    if (unlikely(!range)) {
>>>> +        ret = -ENOMEM;
>>>> +        goto unregister_out;
>>>> +    }
>>>> +
>>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>>       if (ret) {
>>>> +        kfree(range);
>>>>           if (ret == -EAGAIN)
>>>>               pr_debug("Failed to get user pages, try again\n");
>>>>           else
>>>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct 
>>>> amdkfd_process_info *process_info,
>>>>               }
>>>>           }
>>>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>>>> +        if (unlikely(!mem->range))
>>>> +            return -ENOMEM;
>>>>           /* Get updated user pages */
>>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>>>           if (ret) {
>>>> +            kfree(mem->range);
>>>> +            mem->range = NULL;
>>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>>                 /* Return -EFAULT bad address error as success. It 
>>>> will
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 744e6ff69814..31eea1c7dac3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct 
>>>> amdgpu_cs_parser *p,
>>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>>           bool userpage_invalidated = false;
>>>>           struct amdgpu_bo *bo = e->bo;
>>>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>>>> +        if (unlikely(!e->range))
>>>> +            return -ENOMEM;
>>>> +
>>>>           int i;
>>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>>>           if (r)
>>>>               goto out_free_user_pages;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index 8524aa55e057..12f0597a3659 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct 
>>>> drm_device *dev, void *data,
>>>>           goto release_object;
>>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>>> -        if (r)
>>>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>>>> +        if (unlikely(!range))
>>>> +            return -ENOMEM;
>>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>> +        if (r) {
>>>> +            kfree(range);
>>>>               goto release_object;
>>>> -
>>>> +        }
>>>>           r = amdgpu_bo_reserve(bo, true);
>>>>           if (r)
>>>>               goto user_pages_done;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> index 2c6a6b858112..53d405a92a14 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>>> *notifier,
>>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>>                      void *owner,
>>>> -                   struct hmm_range **phmm_range)
>>>> +                   struct hmm_range *hmm_range)
>>>>   {
>>>> -    struct hmm_range *hmm_range;
>>>>       unsigned long end;
>>>>       unsigned long timeout;
>>>>       unsigned long *pfns;
>>>>       int r = 0;
>>>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>> -    if (unlikely(!hmm_range))
>>>> -        return -ENOMEM;
>>>> -
>>>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>>       if (unlikely(!pfns)) {
>>>>           r = -ENOMEM;
>>>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct 
>>>> mmu_interval_notifier *notifier,
>>>>       hmm_range->start = start;
>>>>       hmm_range->hmm_pfns = pfns;
>>>>   -    *phmm_range = hmm_range;
>>>> -
>>>>       return 0;
>>>>     out_free_pfns:
>>>>       kvfree(pfns);
>>>>   out_free_range:
>>>> -    kfree(hmm_range);
>>>> -
>>>>       if (r == -EBUSY)
>>>>           r = -EAGAIN;
>>>>       return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> index 953e1d06de20..c54e3c64251a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> @@ -34,7 +34,7 @@
>>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier 
>>>> *notifier,
>>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>>                      void *owner,
>>>> -                   struct hmm_range **phmm_range);
>>>> +                   struct hmm_range *hmm_range);
>>>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>>>     #if defined(CONFIG_HMM_MIRROR)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 901e0c39a594..046ff2346dab 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>>>    * memory and start HMM tracking CPU page table update
>>>>    *
>>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>>>> once and only
>>>> - * once afterwards to stop HMM tracking
>>>> + * once afterwards to stop HMM tracking. Its the caller 
>>>> responsibility to ensure
>>>> + * that range is a valid memory and it is freed too.
>>>>    */
>>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                 struct hmm_range **range)
>>>> +                 struct hmm_range *range)
>>>>   {
>>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>>> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct 
>>>> amdgpu_bo *bo,
>>>>       bool readonly;
>>>>       int r = 0;
>>>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>>>> -    *range = NULL;
>>>> -
>>>>       mm = bo->notifier.mm;
>>>>       if (unlikely(!mm)) {
>>>>           DRM_DEBUG_DRIVER("BO is not registered?\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 6ac94469ed40..a8379b925878 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct 
>>>> amdgpu_device *adev, uint32_t type);
>>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                 struct hmm_range **range);
>>>> +                 struct hmm_range *range);
>>>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>>>                         struct hmm_range *range);
>>>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>>>                          struct hmm_range *range);
>>>>   #else
>>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                           struct hmm_range **range)
>>>> +                           struct hmm_range *range)
>>>>   {
>>>>       return -EPERM;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 273f42e3afdd..9f0f14ea93e5 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1737,12 +1737,15 @@ static int 
>>>> svm_range_validate_and_map(struct mm_struct *mm,
>>>>               }
>>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, 
>>>> addr, npages,
>>>>                                  readonly, owner,
>>>> -                               &hmm_range);
>>>> +                               hmm_range);
>>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>>> -            if (r)
>>>> +            if (r) {
>>>> +                kfree(hmm_range);
>>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>>> +            }
>>>>           } else {
>>>>               r = -EFAULT;
>>>>           }
