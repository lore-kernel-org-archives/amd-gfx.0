Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F93E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 10:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B132910E836;
	Wed,  8 Jan 2025 10:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7VF9CjS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B663B10E83A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 10:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgKnDlU24MeLIKktsvLOTUrW9F8ij2X9nTMASPHVf++z79XqyPtbHj8hqRZS70gukFZyRn2GFTS1TFJ3wgoNi1Vr5j8aX07Hkp4JxU5pMlL8OaT+yeIc5zIub63Obnhoe/UdSTXMPvLgIC+K3czD5hbqgo9x5/mx2xk/Ip5jsJHqKrZGfyJzjlDEOunT9Ums0AB43KulPe7Na8+zNvBqgqT7j2lu0kgQz3Oo7IOQzpQR5h3RxvMn5tezMZsHqIK2uhLqAJtUPd0u2aGsCwRQfLp8DPpQGJM8fkEQcbfpupmTu6TLHQdQZm8Iw4c2+69VNO+OwZI8TgXxWlhh6mDaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up05RFdNOfTVCLAhbBw7aCj5SyCboP/5uyJ1DRL6EnM=;
 b=j/gNSqAIRNKRvCh1u2Em/LFkbIdsMW08xvNPrHPT7RHjzC0JIXu1fFDtI6ikuv4F375K5AZZUhWmzSYHy+4xndOW7gMnyeeLD5CA4wdOPVXxGRhp9wkAPHjPKyPVmeoBQl3U9BlHqbLanFmUBIA1gYjcGfuEzm/3HYSJq4wTHe5E33u0vY3yV7PefNdVZ+W2wm8p90WTk6rj1jthm3AP34WcVqUSke9Z2htj4VXCVx/R94n9S8QLEvx3niYpgnaDCtwP+NQUEt8Uf3zk1fJDZZT+207/CUch1kUedF3FXwcFDENCA6g5x9/miVggeGpVUE0QAwD7w15B3wZEp1uX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up05RFdNOfTVCLAhbBw7aCj5SyCboP/5uyJ1DRL6EnM=;
 b=m7VF9CjS922SJNEyU8JnvXQDSWc6zGXo2hvdkOrJ57mY9OiFPJU9IqTR1ioGRSTLzXXItDqhUcFVx0NLLCogpO2Pj8hXI54O9s/13NxAsP//LdGXLUCoEAMmNpMxg/pfHcrl8gpAGkr+ymOzGW0vAVJHlGZJXldZTaaghnEq5Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 10:02:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 10:02:25 +0000
Message-ID: <eb90ea93-972d-460f-8ad8-3c60a656207a@amd.com>
Date: Wed, 8 Jan 2025 15:32:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 6/6] drm/amdgpu: get rid of false warnings caused by
 amdgpu_irq_put()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: f800707c-7928-4179-92c8-08dd2fcb8d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzBWTmJvZWRZdjVFK1BISE9OUmVTVktOZnhuRTRFRDdzSFNCUWdCY0JpbmRR?=
 =?utf-8?B?bHhXSzZCVGFyYW5jcjM4T2taRXFhRHdSRTZ0RFZBU0MxdDFXYk0yQnF4cTU3?=
 =?utf-8?B?TjRCaUl4QThGV3YzTGdWWmF6cFlDZE9YSWJpRDZ1QUZZeWE4ODFCL2JCNzgx?=
 =?utf-8?B?TFJ1SUxMT05jdVViOVhyNFRsUTVUazNWakFPaUpqK3dkZlNINWduR1NvRUx1?=
 =?utf-8?B?RmtiWFQrWDlOc0c0OW1jMDFFRHdJSGEwV3ZpdU9lNm1KTERoOTdOQ0pUTm9V?=
 =?utf-8?B?NUpYWUJXTWxub3ludkdyNlJ3RVdFd0YxYVV5T3RFdlVEdjlCMVlwQnlhWGl2?=
 =?utf-8?B?Vmk0c3ZSZG13a3paeUZ2blVxZHJCdXFTbElTYi9jR01jdDZTUzRRZWU5S2RM?=
 =?utf-8?B?RjNyY3pjWXNOTGN1UlpjbllTczF0UG56dVJGVHpBSm11alhSelpVYllUenBW?=
 =?utf-8?B?VXE5eHlDUHdtMXpwTjFRSXJROUtMOEJaOXpSTzZtVlovSmFhK2NlMmtiRVJo?=
 =?utf-8?B?Zi9zcVdKZWtHQThVdU1HOGxQT2lVZFlKbXF2MXZjZUltT1g0MFVOU3RpWGcr?=
 =?utf-8?B?TEQwL2UyU1pGNlVVT2ErY21HTDExcUFaSUhwdWxPaDNkbzZHMWFwM2RDUDY0?=
 =?utf-8?B?NWQzZTlwUHdGMnFta1NvYWFldDBYQkFNQ05DVXlJa2UvRVFTRWdLeDRKMTNR?=
 =?utf-8?B?T2ZPY3FDOEtMZGg1cVcycnhOcnhlQ3hXSy8wUUZIdUs3QXlHY21xOVJsQmxR?=
 =?utf-8?B?dWZzZkt1QitWY3pKUk5tYVlPME9tYWFXZm5BdWJ5Vy8wZ21HSnhFb2ZrUFdO?=
 =?utf-8?B?a0d0RWZTcEt2TnNGbWlWcjlXQ2ltdFRFdFR4QVJwaTlGd1dWNHJ3Tkdwb21O?=
 =?utf-8?B?U0lVbXpSNC9XRm94SzZFNnlxVFBVMy82NDJLa1VTRjByS2FDb1E0bkRUTjFw?=
 =?utf-8?B?d1dWYkhlYlArditXdmxtdmQ2dHVEZkcvTFVQRHo0TlNIalJVcUhlQ1FsMVVj?=
 =?utf-8?B?QVpGN1lUbXZNYVdQelJFQythNm5RRzUzUFNLMnlGVHM2VzlRYURZcHBTL2xi?=
 =?utf-8?B?bjhJTVhjVHkvcTJoM0ZGeUxoNWI3QmZ3SXpLUkJ0OG5JcXgrYTg2TndhWlhV?=
 =?utf-8?B?elpTYU1TeHBVS1oxUUZkVTc4NUxWaittT1R5R0FjaDJIVVNFZ0I0cHF6bzlL?=
 =?utf-8?B?NFFFcDJ1Mk8vSjB4M3pIYkJGYVR0cmxLdEhNUTVKcDh4dGR1QWNSQXppWVpo?=
 =?utf-8?B?N0RrVWNlb25UQ3NlbzNCWTZ1NWZrYjJld0haQnhFR0FFK1FEckZIK2hmQjd2?=
 =?utf-8?B?OSt0dU5qeEFMQ0ZnR0krejVWbEVmSE5HRUZJQzhzRHo5eW1IZWNKRU9ERTdy?=
 =?utf-8?B?cUhtNURETmpRSTZ5bEUvT1JqU0JnbFpMZG9BSDFBK2JBa1FIMXdZZWIxdGZu?=
 =?utf-8?B?Q1ZKWXczbkR4YjFSNE5LYzlkdzI3MnFGR2dZVytQODd3aXd0QlN0c1BVZ3JZ?=
 =?utf-8?B?eGtXTnk0bXVWSUdSRXY4RVdXMG1Rb1hON3BzUXkvQnY4eG5OemxCem84bVlG?=
 =?utf-8?B?MEQrdk9VS3FmK3ZxbWcvdytxUDFJN1AyVkZzaG5zQit3T2FKZEtxaHdVUzZV?=
 =?utf-8?B?N3U2NVR3dGw4VzgrSmswaklOR3N3ZjYzeWMzcVZnVzhsSkhHb0dvbEZUbjY1?=
 =?utf-8?B?ZVh2dW1DK1lLZVpTdGV0K01HVm41MDJJZXBaN2tyNDdRYnVYV204bThnbHdo?=
 =?utf-8?B?NlEvSlFlWmZ3TzQzVHpJN3VRVjZzN0NSRW5QeU4xSWhXL2RXRk1sVkUzZjBR?=
 =?utf-8?B?UXUraHlqM25HVHNXUEc1M0hwenRlbG9qU3dreFNvbWxvbUF1MDM1Y0J2ODRy?=
 =?utf-8?B?Y2pGdWt0ZEhIdzM5UWRaTzJ0ZEpaU3lnOWNNdGxCVndYeGtLTi81YWZlaWNa?=
 =?utf-8?Q?6bBF0FoOacM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNzZ1E5MVFCRStiM1FOMmptOVpTRzE1OW5mL3NhWjhHdUtscjhTZ2VLNHVD?=
 =?utf-8?B?d2ZDVk9TQU54dzZETjlEYWVtV3RxQmZwcTA1MUIzMmhuSTgxL1VxamNBZlZl?=
 =?utf-8?B?bWpjcVZDUTRqVTEvakRtTHVFVk5SREUxaUhQSnNHN0pLcW9hMHB1NzZ1VzVR?=
 =?utf-8?B?bUxKNU10NUt3aEZ5UFRPV3gzU0dRVkpBZjh3U3JyUjBIRUluYk4xV1F4L2tt?=
 =?utf-8?B?VHJZemdyT0pBallNVzZQY2RHdjQ5anFZSTY3cnJnM3FFTExpcnlwRUFra1py?=
 =?utf-8?B?RlhZKzFjL1djRERFRHpNajJuSEJUdWF5TDBuSEdrUXBSYlF3aFJZR2VVSHRZ?=
 =?utf-8?B?aTFyTE9MMEhwV0JiOVJXeWJTYUgvWW5IdW85UDRpdk5rTW5zWmVxY0xLb1d1?=
 =?utf-8?B?WGY1SWU2Ri9mNlgzYS9JZWtVZi9Gb0VIY1lyZDFDb0hZb043Vmk5Y1FIckQx?=
 =?utf-8?B?clpzZ0hOTXdQeFNUbkU3NE5VQVh5a3pJVjNIYit6VFErNTM0UkZSTXJHNUpI?=
 =?utf-8?B?eWw0dlFkWUpWUW9KczNITGdkRE81QXpMdVN0K05HTVRFOU9JUU5BbXdCT05T?=
 =?utf-8?B?ZjF4Q0M1TVFydkRIYzI5OVBKVWUvcCtlVEVFTGhla2FINnZkcUFzTTJDaDhZ?=
 =?utf-8?B?SHpRczhvZUozZ1E3a3hLZ3l4SUdNTElUK3ZaczdmWXZRdm5hVzJHYXJFRHV5?=
 =?utf-8?B?M0ozMVdhd1k5VFBnaS9UTTVFWnd4R1pzL1ROY3pMbVBQVjE1RExQU0VNV3Yv?=
 =?utf-8?B?MnY3K2RnZDcxZENUaVZ4T2RlWVE0eEt4WFM2RGphNlJYTTgwTWo1dmRqc0ZM?=
 =?utf-8?B?SEtjRGFXZnlJVHBoSFhaNHVJcGc1cmNzOVdDR2JGUnpGU3EzTCtYSGIrR3Mx?=
 =?utf-8?B?eUhOSng3VDN1TzhWOGJVRmo2bjdTWElOaFlTLytlZkFVZlJqY2hHaWROeWND?=
 =?utf-8?B?c0lqbXFwVnNxbzcvdWxxUVRMWG1WdGFSVDdvbHR5em11UGdIckEzSC9YbEVR?=
 =?utf-8?B?UVNjN3lDYjk0TDFJUm5mbkpEelppa0k0eWIyVkZGM0ZXMzYybGF0STJMaFN4?=
 =?utf-8?B?Smw1RERDdFhjbVFJNytPRGI1VUoxcFBkYTFFSGJiWk5PUnFmYnFkSW9abVlH?=
 =?utf-8?B?b0xOTnM1OHJWQUE3ZGJST0QwdlQzNmpRVG5EMU83aG9QSzBiM0g3S05ncUJF?=
 =?utf-8?B?N0JnTmpUaEtZSHc2TkxLRzNTWkZEaFBjYmNJYUpxb1NzOVNZeTN2OWxyVVVD?=
 =?utf-8?B?UjNENVh0S29hUzFJTkNCdGZhRVlyZm92ZkZOZFpGTXlHN3lYdWhtc3VFRytP?=
 =?utf-8?B?Si9tMnhxZTFsTkVFME1mTHMxS2FNbXRnQVRBRTR1VTJZVW5ubEMwcDZrZDU5?=
 =?utf-8?B?WDBPMU5RZGwrdXk5TERJdGNNcDR2ZnV1VkdYalZQYXF0MU04ZlkyMmpwbWRm?=
 =?utf-8?B?a3ZWaStyTTRML3lwaGVUT0RGT2lua1RFN0syN0hGTGdEQTJXMXBuRjZFdnpk?=
 =?utf-8?B?QWZ5czhBTGdSNHJsZk5yWEhRdGFjUi9WcVVNUU1GZXZ2QnQzc2s4MjVGeGNH?=
 =?utf-8?B?NlpkY2xDd0Y2eUxGa1VsUWsxaUh2Z2pyeFFCbmtueFZleXBQK1pDV3NBdHJa?=
 =?utf-8?B?Z0c1ZlpGMFAxOVhaK2hTK3dNdzlEa0h4YjE4R0hqbDBkWVNNbDVxZ09DRm1E?=
 =?utf-8?B?aUhkbTFXRjVaa3JkbXFxZ1VHZWpRU2R0MXNKNG1ueG1SdVBQWWJTUE1ydUts?=
 =?utf-8?B?dzJVV3JkQkVTQyt5c1ltV2V2d1Z3TmlyZHA3SkhaakFEeDZtaU9BR2NvZUto?=
 =?utf-8?B?ZjBEMWlOK0tGaTJ3TWpGaStzVlhoTjVKUHlaTVEvakE0UHdzWERoa3ZmU1lh?=
 =?utf-8?B?aHcySkhzd2Z2Q1EzMUpOMHlqQ1R1bXh2Zk1Md1ZqWkYvclFlMC9JVzlnSXU2?=
 =?utf-8?B?dGdtSTFyY0Y4U01wdmM0MjdZK1psVUw0b1NBMTNhdG9XL0czYUY4R285czNr?=
 =?utf-8?B?Sjc2TWZpbkpyMjZRZUo1bmhoMFMyZStyMGJDNmtoRzlRZHVuTFpHbUJhZ3dO?=
 =?utf-8?B?OHAyaEdlL2tqcTdlSTVDczBGZ2pKKzdDZ3ZqQ0dCNVdqR2hEZXliOVBjbWRH?=
 =?utf-8?Q?x82caIO3bk+ojtQK9dG03vFSw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f800707c-7928-4179-92c8-08dd2fcb8d1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:02:25.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oP185uuAEX5E0snJ4KBUZL3avo73D2cgh4BiAy7+zmVVnbUQX4OQUKBRi6T1I9pj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
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



On 1/8/2025 2:26 PM, Jiang Liu wrote:
> If error happens before amdgpu_fence_driver_hw_init() gets called during
> device probe, it will trigger a false warning in amdgpu_irq_put() as
> below:
> [ 1209.300996] ------------[ cut here ]------------
> [ 1209.301061] WARNING: CPU: 48 PID: 293 at /tmp/amd.Rc9jFrl7/amd/amdgpu/amdgpu_irq.c:633 amdgpu_irq_put+0x45/0x70 [amdgpu]
> [ 1209.301062] Modules linked in: ...
> [ 1209.301093] CPU: 48 PID: 293 Comm: kworker/48:1 Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
> [ 1209.301094] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> [ 1209.301095] Workqueue: events work_for_cpu_fn
> [ 1209.301159] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
> [ 1209.301160] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 b8 00 00 00 00 74 05 c3 cc cc cc cc e9 8b fd ff ff <0f> 0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc cc
> [ 1209.301162] RSP: 0018:ffffb08a99c8fd88 EFLAGS: 00010246
> [ 1209.301162] RAX: ffff9efe1bcbf500 RBX: ffff9efe1cc3e400 RCX: 0000000000000000
> [ 1209.301163] RDX: 0000000000000000 RSI: ffff9efe1cc3b108 RDI: ffff9efe1cc00000
> [ 1209.301163] RBP: ffff9efe1cc10818 R08: 0000000000000001 R09: 000000000000000d
> [ 1209.301164] R10: ffffb08a99c8fb48 R11: ffffffffa2068018 R12: ffff9efe1cc109d0
> [ 1209.301164] R13: ffff9efe1cc00010 R14: ffff9efe1cc00000 R15: ffff9efe1cc3b108
> [ 1209.301165] FS:  0000000000000000(0000) GS:ffff9ff9fce00000(0000) knlGS:0000000000000000
> [ 1209.301165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1209.301165] CR2: 00007fd0f6e860d0 CR3: 0000010092baa003 CR4: 0000000002770ee0
> [ 1209.301166] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1209.301166] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1209.301167] PKRU: 55555554
> [ 1209.301167] Call Trace:
> [ 1209.301225]  amdgpu_fence_driver_hw_fini+0xda/0x110 [amdgpu]
> [ 1209.301284]  amdgpu_device_fini_hw+0xaf/0x200 [amdgpu]
> [ 1209.301342]  amdgpu_driver_load_kms+0x7f/0xc0 [amdgpu]
> [ 1209.301400]  amdgpu_pci_probe+0x1cd/0x4a0 [amdgpu]
> [ 1209.301401]  local_pci_probe+0x40/0xa0
> [ 1209.301402]  work_for_cpu_fn+0x13/0x20
> [ 1209.301403]  process_one_work+0x1ad/0x380
> [ 1209.301404]  worker_thread+0x1c8/0x310
> [ 1209.301405]  ? process_one_work+0x380/0x380
> [ 1209.301406]  kthread+0x118/0x140
> [ 1209.301407]  ? __kthread_bind_mask+0x60/0x60
> [ 1209.301408]  ret_from_fork+0x1f/0x30
> [ 1209.301410] ---[ end trace 733f120fe2ab13e5 ]---
> [ 1209.301418] ------------[ cut here ]------------
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b5e87b515139..0e41a535e05f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -614,9 +614,11 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>  
>  		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
>  		    ring->fence_drv.irq_src &&
> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
> +		    ring->fence_drv.irq_enabled) {
>  			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>  				       ring->fence_drv.irq_type);
> +		        ring->fence_drv.irq_enabled = false;
> +		}
>  
>  		del_timer_sync(&ring->fence_drv.fallback_timer);
>  	}
> @@ -693,9 +695,12 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>  
>  		/* enable the interrupt */
>  		if (ring->fence_drv.irq_src &&
> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
> +		    !ring->fence_drv.irq_enabled &&
> +		    amdgpu_fence_need_ring_interrupt_restore(ring)) {
>  			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
>  				       ring->fence_drv.irq_type);
> +		        ring->fence_drv.irq_enabled = true;
> +		}

I guess the problem is more generic like calling fence driver hw_fini()
when hw_init is not called.

Thanks,
Lijo

>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index dee5a1b4e572..959d474a0516 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
>  	bool				initialized;
> +	bool				irq_enabled;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
>  	struct timer_list		fallback_timer;

