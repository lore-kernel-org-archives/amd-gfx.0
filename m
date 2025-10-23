Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239E6CCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 21:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9459410E95C;
	Thu, 23 Oct 2025 21:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qB1AOmmp";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B752B10E95C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 21:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOTrSy3BfVqReDqtK9cPIuO5GV+sOFzQ4WfXunamK2AY7gA344BZDGQqGHZrKg4uVDP/mkmWwgXsdKkGY2d8seVraHxkE/LTaGXDVVW8fyJaj5xQBa5CNjdto9dARavQ6guEmB9mAtg3xA7FkHJNncqEEi+8GeLBSa7pVX07YZPLgltv6WTPoEZet3d8wwBr04SHQSR+o4TKDV+qO4TpgY/SeXgzNX816tgN2HxA/uxtMyMFo1d/lr3A5wGZcKBr1jZC2DKHjp4Y/UcUt3q5DkZ0FFD/6vxtVAjjvThoE/1FS27lH5Sk75ZNIh22D/QuUWfEQPPaLVD99Sx83tfsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k9OJq1nr0k26N3z9ug2LRSMZ5yLAKm5G7Sj7tlnZ4A=;
 b=ITOc7yRcxooFyPs5jS4l7DFqkFwkOAIgn1jYotHSkHXWio+4eTFLgYb4rxFZkiBQZbHebNcxA5IFxqyz+T/U9LZjmJdvMY5LD5t4ZeOOuqijE3qX9GR6IqJfrVCao822vjILKpIfcylojNzbk7x2UewGf9ung1i7gFkiB2Gtd7/67YqMM6u3c7iki2PpKkJLuqbGvLo0pX2On0OaZmJh3Fg1Ttx0FQpwYu4EPbGy25V1qvtMYdIacDrkwlyInHw19qY7UlDL+/SIjMCZJf+l8OwZEgcDo3t/jMyEXgsfjv1fRXVuVC2Z5xoIn8U1fOl3u44DESoF4fPJ6hYLaVng3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k9OJq1nr0k26N3z9ug2LRSMZ5yLAKm5G7Sj7tlnZ4A=;
 b=qB1AOmmpyBi1FUGIXEbW17hoRG/TFiOvKU1/fENETPaGVsnwxiZvEwIWhc+jsVx3Nay9JFmaNpckt9igD5HvXgcagAwDg0E8sPP6bmgTrIm6ryKRR9DTsL5PfhtqrhAucXwywqoPwo4Pyl1pSlVWdBhmhWvHU1Q3+9afMDrw0wY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 21:44:33 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 21:44:33 +0000
Message-ID: <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
Date: Thu, 23 Oct 2025 16:44:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 292f81fb-417e-41de-f7d3-08de127d5aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnZaTG5yMEREL1FJcGhhd0tSTnpsRFhGS0VTOXlxdTcyWFRlMDRpQ2xpQUNl?=
 =?utf-8?B?KzJNbHdvbEhadlk5NmV5TlE2aWtYRXdOVHpVSGEvemxoa0ZYQUxJZkdaajJW?=
 =?utf-8?B?UzhNaXpVZkdUKzVmZjBYUTM1VXQxdTl3VFlob2h3a09uVG5zUzVDa3Q4UmZM?=
 =?utf-8?B?d01SSkFNUk9ISVlvKzRNRC9rQ1ZCRmExOW1rZHMzREVzQ1VPWVE1SytCbnFp?=
 =?utf-8?B?Vm5NUTBTMUVTb1dTYjdwcTBHeUtaK1Npd0lRcW9qTGVyUk0xaG9JanhmSllr?=
 =?utf-8?B?QWUrZ2JBSkJTMitqdkplNFRXbTR0ZTd5aHJvNDBVTStROThyK0FGU2lFYnJQ?=
 =?utf-8?B?VE9VQXBsQWJ2alQwTWhNcEtiMm1nd0FmcEtzRG5Ld20zVTVCY05XQWlUZFBv?=
 =?utf-8?B?Rkw1eXFqbjMwOUtJTFpGY205QkJJdExqUElPUDM0M2ZWclFKcUQ2ZThNYTZP?=
 =?utf-8?B?YmRtdXdZb1RVZUVKZ1VjaHZYeGlrZlJiODA3SWJTVThKN0ZpY1l3OHBZMlhP?=
 =?utf-8?B?cGxHK2M0b0JSaWZOU21wcUNjc2lRME1oVGRGUXBqTGhzc1VsNE5GRFNlUWx6?=
 =?utf-8?B?cGwyMHBkOGlSa05qSUlUQ0xkc0ZCVjM5dFZnbUJpY0c3UWtuZGUxM0xjYTk0?=
 =?utf-8?B?N2l4eDIzODVienF3MW1UbVI3R2J0UGdVTkN4amVzalhmMUhSMjEwTENTMWor?=
 =?utf-8?B?N2FkQldGdUFzajBGd0tOelFtelRWMnVtNTJRbFlRaTVJdEFFOUJramM3OENw?=
 =?utf-8?B?M0FSNTJNM2RqY1NtN24zSDFvVjZycU96SXZPNGg4NzdwdlBRV0ZRWlpUWnM3?=
 =?utf-8?B?anppMTgrM0hlT0JzblFmVHIxZEtGdVZKaWxmaDBab3V4RFVHMGdqS3pzN1Vx?=
 =?utf-8?B?WXVuWWNsWnJRVlFYL2gzNk1TNXEreFNUSldvQ0k0TjVLendqLzFBTlpaMi9F?=
 =?utf-8?B?SFdwaUNKN3hOdGRGbjZwZHFQTHp0Tk05bHp0SllDNGp0N1JWOG5SVTdtWXJ2?=
 =?utf-8?B?SXV0VWlEY3k4bEUxL0hyT3Jod3hQRFVlYkJzTVlmWlB4VytqNzRyajY0VzRz?=
 =?utf-8?B?WlZTakdRUlVJbU9LMnhYZlpDYnNYcXdFQzhYdno0UHc3c1RZR2M2NklsTExw?=
 =?utf-8?B?VDBZV3pHUW9LRGZySVVXYjBXVFkzbk1GMkRKSGZLUWtnQ1UxdCtVVjRxaEpK?=
 =?utf-8?B?a3RvbjB3R1BkbFZvbHcyNkUzS1hPL3FYK29KaXI2S043TEtXcWIrbUMySDU3?=
 =?utf-8?B?emZyQU4rRWgvVzUyaXVHTWtPNFd3V2NCUUZjL2NINE5la3d0UUFDMEFJSFhm?=
 =?utf-8?B?L1lsZmdRREpvckZUcDFYNGVLdWlqSWZUenlRL0xGOUllbURmVDBWMVppL1RR?=
 =?utf-8?B?ODFyYm90NUFudkhqdCthd3AzQmxxU1IreDVBanVaV3dqaXNaZ1dXMWF5UHBr?=
 =?utf-8?B?UmJxaTdyZURqUkVTT2ZiS2JDaHJNVUJaWVpZUWYrQ0JEWitiaGZUcDBJRjho?=
 =?utf-8?B?S0pQYXdPSDZEWDRHODdZZlJBbWNXUFBpanI0VytxMkhydmszalVVWXNPSjd2?=
 =?utf-8?B?U0g2K25hRzl2NjZ1cW1aM0hVNktDRFpnZE1qaHpZa2hhOWgrTDBucFRZRlNy?=
 =?utf-8?B?anN3ZlpTNTIyMHh0NU9ObzlFOW14dWtZSjQ4bGNSemhpZUNkdURjL3pUbkJM?=
 =?utf-8?B?R3dNSG0yNGZjczVNK1E2UG4vbXpVaG4zNjhQT3pCY21zQS96SU55amZVNEE0?=
 =?utf-8?B?NTl1RWRudjBrNXNXV25kbjZ5UnBFVzRhMGN6ZU43VDU2Vkg5dlkzVWkvWjNh?=
 =?utf-8?B?MXVyVUppdldkeFU0T2ZUU3J3enN6dDlpS3dxckNkaFA4WENRUENMUDdtNVN2?=
 =?utf-8?B?dGtuaDRCa0pnNTRnZWlkRzZ6aGNNRWdQdjZtMWFKcEpxeDl6WWJKQzhCckpD?=
 =?utf-8?Q?kZVRZN0yjSuCHWFSY2a5FqavGejHzicv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZIL2h3b2lYZnc3OWF5U1NqeEJDTjZIcytpMm9xOEYyL1c2TlRtdDl3Yk4w?=
 =?utf-8?B?eGFEZmpEMWdoZHBETlJBYWRrcmtCcDNtcklaRE82N2hWaElJcmttdURwd1Zi?=
 =?utf-8?B?eXJwbENSU3JVTFhjKytBZG55KzF3RFZYYVQ5a0tWY3lOeFh1NzdzTGdaS2Rn?=
 =?utf-8?B?NWc0WG5sOVlHbENkSjNNYXpKR0wwd1U3c1p3cFNUNFRtbzExczJKUS9JMGdF?=
 =?utf-8?B?ZmQ1eFdNRE1PY1h0T0dzSmFVVnB3Tm14dTUzYytILzk1eW85dHpwdUNDOFRC?=
 =?utf-8?B?YVEzNmJ1cVYvbml0VlRmS1FuS2lQY3NJVmV3YlVMMkZrU0w2N1laSHF0Lyt0?=
 =?utf-8?B?UUNjSmhQMjhNbk9mMTFaZjBtWTJoVDVVMXh1dXRmakN2aU1OejZDSTB5WktS?=
 =?utf-8?B?NEdoOXVMRER2bUw5V1h3MXk2blE0TnhZNjI5ZXFQUjBhM01rckU1bEp4eTRY?=
 =?utf-8?B?R1dtZjBPM0NPRUVPL0Zta2ZabDkrUnFMYWNEaFMxZmY5eTZKelhMa0djT3Jy?=
 =?utf-8?B?L3JMMXQ2b3VqWTVxMFBlUlJ6QTlhNGhjOWxjWG1Bd0xkNUY3UlM2MzEyaTdN?=
 =?utf-8?B?eVZvREExQksxcHJwaG5MNjhPbHIwY3kzU09tVGo3dW12VmlBZVNLZ3krSkMr?=
 =?utf-8?B?RFpSdSticVl4TC83a01GaVUwVXRkbzdHOXgvZ3pTSWl6RnFwdVozcW1XTEhC?=
 =?utf-8?B?Qk11ckVWNVVYOVFkZ1lEWUdpZjNLWFRMQklNMHhyalhlRzBaNXVEOTNuaGJy?=
 =?utf-8?B?M3RvSjdaaXpiK25pMEk3TG5xSS80ZXk5UjZXMlg5L2FlTDdqYXUzc1J0YmRW?=
 =?utf-8?B?Q2ZNVlN2ZVVyelliL0NndWNSQ1g2VkYyeGlhMXh1Y05uWW9VVDV2RVRwdEJx?=
 =?utf-8?B?QnZxTE94eHF2aTVlRXFvRmlmSGhtOWVvTTBIc04wa21CRVRhQ3hFRlJxZmdH?=
 =?utf-8?B?eDgvMWxZa2h3cDJRYmhqSFpXbjlITjlaektKWDkzd3NtUktwRFlUZGtrbDJ3?=
 =?utf-8?B?MEtTRHJLaG9vdUViZmVrQkpibUdDcG9JVCtkOWNEN3FGWXE1QmY0elRQNnBp?=
 =?utf-8?B?Uy9EY0tJNXBDOVd2SGNwWm1kNWprWHBjdFloQ1BzWVN1UCtRemh4MHdBYWFZ?=
 =?utf-8?B?ZVVzMVBJWHJSSEtBYkVOQnExdkREcVF4YkYwMG5JRk55c2xZTEM5TVJQeS8x?=
 =?utf-8?B?RUJkeDJXOWxHTWxyRTRycFd3RFdjZC9pamE5Nzg4Mi94MWZyVU9YdGJxV1Fi?=
 =?utf-8?B?OXloUVdkS2xHVkh6dXRqc0FMbTFLNUl4MEM0enZVanRRY0ZpNnpxcU5KL3l6?=
 =?utf-8?B?MVArM0VKTkJjcEZGbXBPQk43cEYzWWlFdi9qRGJSc0xWVFhoalFnWjNNajIy?=
 =?utf-8?B?amkxQlI4aG9yU2t5VzdGN1BZYk9ZNHhHNEtEaWNmckdac0Z3NWRuUkJoVWht?=
 =?utf-8?B?Q2xuNUZVcnA3a2U5ZzhuMXY1bVBGc2s1YVR3YUtSdzUyeGJwZlJCRzNkb1Ra?=
 =?utf-8?B?Ny9Ia3VVKzFZUGtzVXoxS3oxV0xHL1gzRXB5aFpSUzFsNTNyVTF1Wnk3NTRX?=
 =?utf-8?B?MExsejVMMFhONERFUHFScTRoTmlvSUZCUURuM245Qzc5YnBBR2Focm1PVUw5?=
 =?utf-8?B?cEJnbUo2emlZQnVsTmg1THRZdXppV25hUHV1d3pRL2k2VmZwZHJTeGxwOEFz?=
 =?utf-8?B?VXBCUG5zOWx3ZGhnWUg1STBuckZRaXZ3cFNvNHdJb1A3MlNIaHpqMnRUTHk2?=
 =?utf-8?B?eStFY1lpcW0vNWRqZS9rZi82Z09XL3YveDR2N0sySVlOYWpVZlZPV3pvR1Ra?=
 =?utf-8?B?c1R1OVA1OEE0Y0JYWmtDWEpYdG4ySEY0TXhhd3JQTEhaWW56aVhWRjkrd0ZS?=
 =?utf-8?B?ZytPWlBjc0cxb2VEai81YnZxSlk1ZWtXTk80Q0FNVzhKQzlCdmpmKzZUeDJa?=
 =?utf-8?B?UCtUSXMxVjNMWEtuTmU1b1Rybzc0L0JwR0RScE83ekhEUkR0VHAvc0tUVWo5?=
 =?utf-8?B?NkVzNXZuTVRFbEd2TEF0Q3E5QnFOcTNacmwyY0t6Zk0vRFczVkNaQUo1M0xz?=
 =?utf-8?B?Kzh1YXp2UEVtSTgxN21uWWw0QkQ4L01wRFNlTXpDSHhERkRpd0JpaTFtS2tF?=
 =?utf-8?Q?/LTo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292f81fb-417e-41de-f7d3-08de127d5aa2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 21:44:33.6159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmHybIt7kps3uV7QvscW+Sb0DRL5EI3I8jQv3rULNSty02ytUKqUZMAPKBzVp//M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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


On 10/23/2025 9:34 AM, Srinivasan Shanmugam wrote:
> The function svm_range_validate_and_map() was freeing `range` when
> amdgpu_hmm_range_get_pages() failed. But later, the code still used the
> same `range` pointer and freed it again. This could cause a
> use-after-free and double-free issue.
>
> The fix sets `range = NULL` right after it is freed and checks for
> `range` before using or freeing it again.
>
> v2: Removed duplicate !r check in the condition for clarity.
>
> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails, we
> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still pointing
> to freed memory. The caller (or amdgpu_hmm_range_free(range)) may try to
> free range->hmm_range.hmm_pfns again, causing a double free, Setting
> hmm_range->hmm_pfns = NULL immediately after kvfree(pfns) prevents both
> double free. (Philip)
what you fix is not "use-after-free", it is preventing double free, right?
> In svm_range_validate_and_map(), When r == 0, it means success → range
> is not NULL.  When r != 0, it means failure → already made range = NULL.
> So checking both (!r && range) is unnecessary because the moment r == 0,
> we automatically know range exists and is safe to use. (Philip)
>
> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index d6f903a2d573..90d26d820bac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   
>   out_free_pfns:
>   	kvfree(pfns);
> +	hmm_range->hmm_pfns = NULL;
>   out_free_range:
>   	if (r == -EBUSY)
>   		r = -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f041643308ca..103acb925c2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r) {
>   				amdgpu_hmm_range_free(range);
> +				range = NULL;
>   				pr_debug("failed %d to get svm range pages\n", r);
>   			}
>   		} else {
> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		svm_range_lock(prange);
>   
>   		/* Free backing memory of hmm_range if it was initialized
> -		 * Overrride return value to TRY AGAIN only if prior returns
> +		 * Override return value to TRY AGAIN only if prior returns
>   		 * were successful
>   		 */
>   		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> @@ -1769,7 +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			r = -EAGAIN;
>   		}
>   		/* Free the hmm range */
> -		amdgpu_hmm_range_free(range);
> +		if (range)

Can just check if(!r) here and remove "range=NULL" above? if r is not 0 
range has been freed, if r is 0 free range here.

Regards

Xiaogang

> +			amdgpu_hmm_range_free(range);
>   
>   
>   		if (!r && !list_empty(&prange->child_list)) {
