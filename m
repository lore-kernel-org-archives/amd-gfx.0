Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BE3C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FA210E226;
	Thu, 16 Jan 2025 21:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3p3J8x/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120D910EA0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkgGgPlKq/1U6he5J3zAXkB/pbpy+y3sUQZU6GISMIgOFQjXiHTmkrnkkkw5KxHAyP7vt+fovE6qxstiJWjb5vp7D9UIbM4p0h7+CtFUmkDtB/u+T/zf+4oP5KxS1Nt/Wu+TajTrlE+xu9yyf/qaSzN5yzk1pgHx1aGZKh7UDIVadjHvTMG8aE64WlBIzUYSlqmNkoPu/MWNvcrB//AHzHdonmZbdJJ9D4a0uLfMx58nRBI93oJABkslIQm8IFSD+7FZYFlOhA4WoFtKbRPVHhZYINyN3+eCKoEKTiJ403F0U1H+QfTyjhOVhv1YTeNBUo1KQfZLKqs+H+8Rf2Mo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmyR/3/byqBpoA3OmuoZh0c8k6VEusF9RYQjhAks/+g=;
 b=m/+I4SyhTCLtGceB+87Wx7xTfUK+5c/146hvH9NP+JvBBtaESWpQFvwq3sP5ZJIm+P3S+178P7AVvS0IHDDwrwRi6/kjk7s/UjCzzp/arR69lU1PDaOoXA8SA3LdteLqlVLsvL3U4mRbPw9sCFP0lRLV2chYH50l4QW7/Q6VZuCplVEvK1Dl7cvdl/OEiGkXRSj3pxnxZAtZdGU9waDextQcsLgm9igbLcECxb4bUZUuPG37dCcnaaPrpJQJg6QviuPBEHxXzisZj2TKBXOQvGp3zbInm8WbHYzjoFpe0U9nxjVV69xe5nfSxSI6HTf7IDQw+pmMRqT/g12TM/8MGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmyR/3/byqBpoA3OmuoZh0c8k6VEusF9RYQjhAks/+g=;
 b=A3p3J8x/TIhet4ZcXDjocWrpVYUFYY93Ckpywv7yJSuyFgFBoxJArL6JAK2/TtUUOFUB3q4ezd/S2s1ITRdg1x7fCZk3iozp7742RxirwJ3J5nD2YuwQWUArJ0GWBEPA7/E0fNxeLQXSSgJE7O8rMflfGp93joEp7LX5kXYLiLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 21:25:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 21:25:11 +0000
Message-ID: <dac24c40-1185-4ae5-8a92-8f715730cdec@amd.com>
Date: Thu, 16 Jan 2025 15:25:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: fe918836-02d7-4676-7749-08dd3674424e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1FEWGZIWlBrU0U3MFJQT2ZPbjBxYXN1KzRncENNOFBEMFUyVzJBY05yMCtH?=
 =?utf-8?B?YkR4OFcxVnFxaml5M283dGZ0K2VxVVNLeFIvcXc4U0wyWEYrclUwNzF6UUtU?=
 =?utf-8?B?NE0rVXFybUNwV2V2UGxkNlFhREVnMks0Z3dsamlUUUdPUVZnbFppb3lCYjc5?=
 =?utf-8?B?blhQbWhnNUlTdmpSYmFNKzBKb1lyY0djdTN5QWNkQndaaVNUWlcrNXRIRmRJ?=
 =?utf-8?B?by91Sit1Z1dhczlLQkVxQWUycWhLZWg5OFlRd09CVEM4bEJuU3FGUzF0aElm?=
 =?utf-8?B?aC8yQ1hFb25ZblFlMzVhTGJTd3l4cHZ5U0xpWm93aHc1Mzd4c3BOV0hoa0FM?=
 =?utf-8?B?Q3JhMmhFSUVsQ3daTldnRHhET0tLbU04TjA4K05vZ1FRSGhhbDFnOSt1SCtX?=
 =?utf-8?B?aWEyL1lydWNLNFFhL3NBbUtndjdESmhBK3UrdjUyVlpCam1KbDR6YTFZOENk?=
 =?utf-8?B?ajhScVBnN3orcjdRRUFOU3A2dktwMnBSUzduWCtqUkpzanBkU291aGQyK2pr?=
 =?utf-8?B?Tm95VVV3RWtJQ0tqOEtacWtBYXFrVnBCN05wekxBdFAwUmNzUzB6b1Fvb2cx?=
 =?utf-8?B?aFUzWEhjcnZzVlU4eFBrS0x3T0Y0Qkc0cHhpZDYyVm9sOFc2WkRaRlAwUEFn?=
 =?utf-8?B?b3p0OC9YNmpHcnQ2T2lkREFkc3hMTTFYUFdMV2NFVllzUWtLVVg1b3ZZZ2Fm?=
 =?utf-8?B?ZUd6dXdtWUR3YjUrUlpGUGFOa0VRZ3UraDQrN1NXZmlEMGVLN2cyVS9GL2Jt?=
 =?utf-8?B?L3IyQjJ3UDVTNjdZcHJ2Nm1sblB0TVVqNmxPcFJsV3lDdWRIOGF3b0QwQUpT?=
 =?utf-8?B?Tlc4OVZzOTZTcjJacFdCSW5xQ1JsU3pxRlYrd2gxWDdEeUNCSERMTVdWUXg3?=
 =?utf-8?B?YzlDQjcvTHAzb0oza3BNZkdTRU9DaTFrYy9vczR1aW53S3lEZkxvbEU3NTdn?=
 =?utf-8?B?aGtzaGtrT1FIT3o2WDBjTHVUSWF5NDBuSVgvamR5L0hqTDJUdThHTkpSbFJj?=
 =?utf-8?B?bUhRdVFjL0ZEMkZYSGNPUlBhWE9jNWJnY1FuTXJjeVp1bkhVQytqNUdLcVhj?=
 =?utf-8?B?Qzk1MUVETTVpY2tpY1B4NU5RaUZFWFd6SnhSWkpCbVJOOXdaczRZVnRvSGda?=
 =?utf-8?B?Q1lEY1paTm9veEIvbnFNNXc0eEtzYW11UytKSGpPaHBVQU9EMUtXMjdZT3Bs?=
 =?utf-8?B?cGxRM0ltdllySW1iaitocGl3M3NtY0NoMWN5WC9wS1orcFI4cjQ4aVU1WnZF?=
 =?utf-8?B?Z1pydnA3UXFIcEtObEhEQkZnSkpWM3FTcWhNWGQ2T0RLdWpXRE5zUzc2Y1pz?=
 =?utf-8?B?U0hvc2pDQW5LQmowZGZvOHl2NnpuWGtTdmJGbGdaRlhzaUx6ZVN4UzkyYmZY?=
 =?utf-8?B?YUdPK0Ewejd4cjduTENybnhYMzdMelZBTjJGRkNiSUxyNUpraktmSHNRZWpQ?=
 =?utf-8?B?UUIyTkJQNHlRelBUeCtiUFpwSlhScVM5S3M5ekV0SUk4OElwQ2Z0dEtGSW1j?=
 =?utf-8?B?VFJnLzNZRWFjYmtiNXZSRDFmaXNFU2VFQS8xR2V3am1PVHVlVklsbWpZN1N0?=
 =?utf-8?B?bjczQzNWUzAyeHZrU0ZxVTcvaTUvM21BdWJQcm9xRzBvbWV5UHIyb2ZoT3BM?=
 =?utf-8?B?SmcvMExHRVk0MFpBMjBua2N4cHUvcGtYTlJJS2ZKNnA0a09BSlVhY09ZZnF4?=
 =?utf-8?B?TmZzcVRkZTdMRDBxazlQWk1NazNOMEh2d0VHZzI2Y3B0c1BmU3lGNFdHVGlM?=
 =?utf-8?B?bUlEME8zTkFkNUxlUUw0RHNDSUJQTHYwVEp1TVBhVlk1VUxGS2ZhdU5hTXNZ?=
 =?utf-8?B?WjR4QnFOWW4xcVNGMmd5SEJKSVQzSnZ6Sm11Zm1zUVFpMUVGc2k3aXRIVkg4?=
 =?utf-8?B?dkRrejZxSGdNeHBSRXRFOE5tRDUvK0N4d3A2NW1ObzFoV2liWllXQTczRlZU?=
 =?utf-8?Q?eza5AC+OeEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStCWkc3c3Jhc3ZSb2hCRkVOT3hybXhsVUF3VFdTTG1LbmR0NThVRThydzJr?=
 =?utf-8?B?QXd3b2ZmNkZ2N2pZQ1BiaEJObDFYNkpIVm1BNkhpQWlOeUFxbFpWY1g0UnAy?=
 =?utf-8?B?M1NXbHdvRDhIOGVLYkxZalBrWk5TdjFkeFR0ZSsrRmxxWXRpbGFFbW05bnE0?=
 =?utf-8?B?ajlxdUt4OGVWSDhORUwzcEkyR25uQ1Iva01aeHIvZWpKSjJ4RzZGRUc2Nlkx?=
 =?utf-8?B?bkphZXd2U2FoVHMrWktSemxzOElONFp6NTJGZkZPUklUWmZGdTZwSWk3aGlT?=
 =?utf-8?B?M1N3N3l2VlpaS3BtejhQbEIzTGRwSElrUzZLTGZzYWpjaFl4K0RHWTE3TXIy?=
 =?utf-8?B?bnRXUS9CcWNDcXlKajQxeVJ3ZWJxN1JMRjBSMkE4cTlPRXFVK2w5ZEdaM2Nz?=
 =?utf-8?B?WFFmRGV4SW8wdTJEdzJXTlBMSWZ5NC9oZFg3VEtOVWp4cGdMZkMvb1pmS3V6?=
 =?utf-8?B?aC9PS0d4UmxWMm0rODlvZEZNYWk1cEJKY3Bnam5VV0NBaTQrV1FXMlFFV1Nq?=
 =?utf-8?B?ODFHR29RK0JRNTZkb3lwVElEdmVra0kzL2dxZlZndkpWZ2FUemJ1elhZWHJx?=
 =?utf-8?B?b3ljT2g1VDVuYk9NaThMVGxkUlRpeEprdjhPMEN6cEw5NjVLTTFmR3QvZkdw?=
 =?utf-8?B?QXdpUG81aTMvZ1FnR1doN2N1SWtCR3lXa2FSNm1UK0E1a1lUb0hWeEtKRzN3?=
 =?utf-8?B?MVZzQXFTb3ZsRkZYVjU3UTdGUFc5bm1qcHN5Z2I0cEkvMnpkSjd5cklGa0V5?=
 =?utf-8?B?STlZN2N0eWp2V01neHJIS0p0TElucVA3RFJTZDBMQkptRlgwdEVIZEorTWYy?=
 =?utf-8?B?SldJOUhhNFQyVUJDR1p4akJpQlpTSlFrTWkwVERoS3FRcHlrUjlFeGpoSTg2?=
 =?utf-8?B?alVWcDVMZThXektqSTNiQkpVNkphanY0czBycGVHek1rSUlWVUQyZENVaHRP?=
 =?utf-8?B?ZjhXUTcyV1dHMnlIWUpuaGRJTWVLRFhaSnhhcHg2WXRPK2NKamJzRktZU1Jw?=
 =?utf-8?B?NHowS0w1MyswVEpGNU9KaDlYQUQxVVUvbkpKMk45Qi8yMDRkcjRRTEx1bFRB?=
 =?utf-8?B?SVRCSnV6SVZlclpJZys1ZzA1T1VqQzYyNFBkaWExeUlkMmEzdE1sK0c1d1o5?=
 =?utf-8?B?WkxhRnRrRmk5ZXlGL1JENEZRcis5YTFjZjE1VUZna0tYMnIxMXo5Z3RxcXZS?=
 =?utf-8?B?bG1US1J0OUVsZEx2ZG1aM04yWjk2UFlwVlNQcVNMNGZYdFBtQzN6cThWUWsv?=
 =?utf-8?B?WlRWNW9QRk9yMVJnUFZxd2JjSUs0eklwSWVKa0lyWVpJVURWNXlRNzNTUVRQ?=
 =?utf-8?B?cVJYUldQdVNUYm1KTkhyV1hSRGdaVEdQTkY1L290L1ZuMjU4KzlSREZEc3Ey?=
 =?utf-8?B?TFIvaXZyOVgzVkllTUZoL3NWUTJFdnovNGc4dVBzQk05WWFWK2lvWm15eFlr?=
 =?utf-8?B?ZzJsZlZ5SGV2dXRGY0tSd3orRVcwQjlJM1pMNUJsb21hYUxmdWhiMCtNbVdC?=
 =?utf-8?B?czAxdURrZUhadGVTWjNQZmRMYnZLMVNkVWkwamhQTFFaODhJc1RYeG1sUnUz?=
 =?utf-8?B?TFkyajZRb01EcmxNTFVGZSs0VDdJYndBRXFMVG1jV3o1d0hGRXVCbkpCTW0r?=
 =?utf-8?B?MWlDUlliclltcTVpMkRSODdZNHZNZmVBQXZFM1AyZWxNOGpVckN5clRHUklQ?=
 =?utf-8?B?TnhWYXdQUkVGTmRiZ0xmUTZTd1FBa1Q0b3ExTjJodkxlSTJLKy9BT2x1ZkZ0?=
 =?utf-8?B?WVZXb0oyTjBMc1QyVkZyZXhlcWREc1lyTlpsbDg0d3Q5ZFY0UUdTT2NRSkM5?=
 =?utf-8?B?RnZKRXZVK3Jydmlsbi95MTRlUWdPdTNUSENGYmNBR2dnM3JaUWlDeXF4d0dl?=
 =?utf-8?B?Nmd4VFhjSlhuNUNrWFJ0akc3a1ZYOHNzdXV6TTBtbEQ2TlVFR2NxakpjZHhz?=
 =?utf-8?B?SzdwempEM25EaVI5alRCdG0rUEZtUUpGSWlxaTNLcTZYdEZoWEFqOGhjOEVR?=
 =?utf-8?B?ejI0NVNwNTNCVjQ1Y21GZ2V3ZHh5b0ZZdjA3Zms1MlNKVngvd2tYVk1zRy93?=
 =?utf-8?B?VkpTZ1I5U3gxOHVEVWtKSktBeTRjbXQ4WFpmYmRHQ1FjSGV3Yk5GbTV2OVNj?=
 =?utf-8?Q?1xiWbvMGCDUYBPK1gnBYFhKRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe918836-02d7-4676-7749-08dd3674424e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:25:11.5035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUIPSAQ9uEaqaay9Digjp+3LehbuIVBdiZCyDsuILsOxg9nTmF7+onfurG8eeQy7dD8BRB3qqUSyo4Q5EHRJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini(), to keep same
> style with other code.

Besides amdgpu_ras_pre_fini() -> amdgpu_ras_early_fini() you also 
changed amdgpu_ras_block_late_fini() -> amdgpu_ras_early_fini().

Is that really intended?  If so; the commit message needs to be amended.

> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  2 +-
>   14 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2bfe113e17c7..6cbd19ad0fa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4613,7 +4613,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	return 0;
>   
>   release_ras_con:
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>   	amdgpu_ras_fini(adev);
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_release_full_gpu(adev, true);
> @@ -4705,7 +4705,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	amdgpu_xcp_cfg_sysfs_fini(adev);
>   
>   	/* disable ras feature must before hw fini */
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>   
>   	amdgpu_ttm_set_buffer_funcs_status(adev, false);
>   
> @@ -4922,7 +4922,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>   	cancel_delayed_work_sync(&adev->delayed_init_work);
>   
>   	/* disable ras feature must before hw fini */
> -	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_early_fini(adev);
>   	amdgpu_ras_suspend(adev);
>   
>   	amdgpu_device_ip_suspend_phase1(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6d5d81f0dc4e..2e7c09530ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -918,7 +918,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>   
>   	return 0;
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index b6d2eb049f54..80248930082c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -300,7 +300,7 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index d085687a47ea..c75ce91f94ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -71,6 +71,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
>   
>   	return 0;
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5ac63f9cffda..b11e3eb2b100 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4124,7 +4124,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>   	return 0;
>   
>   cleanup:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> @@ -4135,7 +4135,7 @@ static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
>   }
>   
>   /* helper function to remove ras fs node and interrupt handler */
> -void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
>   			  struct ras_common_if *ras_block)
>   {
>   	struct amdgpu_ras_block_object *ras_obj;
> @@ -4156,10 +4156,10 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
>   		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
>   }
>   
> -static void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
> +static void amdgpu_ras_block_early_fini_default(struct amdgpu_device *adev,
>   			  struct ras_common_if *ras_block)
>   {
> -	return amdgpu_ras_block_late_fini(adev, ras_block);
> +	return amdgpu_ras_block_early_fini(adev, ras_block);
>   }
>   
>   /* do some init work after IP late init as dependence.
> @@ -4267,7 +4267,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>   }
>   
>   /* do some fini work before IP fini as dependence */
> -int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
> +int amdgpu_ras_early_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct amdgpu_ras_block_list *node, *tmp;
> @@ -4284,10 +4284,10 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>   		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
>   			continue;
>   
> -		if (obj->ras_fini)
> -			obj->ras_fini(adev, &obj->ras_comm);
> +		if (obj->ras_early_fini)
> +			obj->ras_early_fini(adev, &obj->ras_comm);
>   		else
> -			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> +			amdgpu_ras_block_early_fini_default(adev, &obj->ras_comm);
>   	}
>   
>   disable:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 35881087b17b..3a6f70b75e47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -711,7 +711,7 @@ struct amdgpu_ras_block_object {
>   	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>   				enum amdgpu_ras_block block, uint32_t sub_block_index);
>   	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> -	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
> +	void (*ras_early_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
>   	ras_ih_cb ras_cb;
>   	const struct amdgpu_ras_block_hw_ops *hw_ops;
>   };
> @@ -825,13 +825,13 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
>   /* called in ip_init and ip_fini */
>   int amdgpu_ras_init(struct amdgpu_device *adev);
>   int amdgpu_ras_late_init(struct amdgpu_device *adev);
> +int amdgpu_ras_early_fini(struct amdgpu_device *adev);
>   int amdgpu_ras_fini(struct amdgpu_device *adev);
> -int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
>   
>   int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
>   			struct ras_common_if *ras_block);
>   
> -void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
>   			  struct ras_common_if *ras_block);
>   
>   int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 174badca27e7..1a1834e47b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -116,7 +116,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index eafe20d8fe0b..dd787f5f2f23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -336,7 +336,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 83faf6e6788a..3ab80399d2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1248,7 +1248,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 74b4349e345a..825c331f48f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1174,7 +1174,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..ce70acfbf22c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -5080,7 +5080,7 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 88f9771c1686..28bc2f946e91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1311,7 +1311,7 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index e646e5cef0a2..467283165a3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -789,7 +789,7 @@ static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index ecdc027f8220..063b3bafd134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1996,7 +1996,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
>   	return 0;
>   
>   late_fini:
> -	amdgpu_ras_block_late_fini(adev, ras_block);
> +	amdgpu_ras_block_early_fini(adev, ras_block);
>   
>   	return r;
>   }

