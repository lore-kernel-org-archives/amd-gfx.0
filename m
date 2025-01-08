Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC4FE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2006210E127;
	Wed,  8 Jan 2025 14:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pUKb9bk/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C2C10E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYG3Fdyd5l/qN3hDdOVeP3947kp1pdS32xn0up/M+ee1tksue8IDmInXR96bqyKtTRq46d29t7XBqtW2cWCTNpM/WdMlGrW+e5bTHDDDVKYGknL64FsqNo/N33zUe83TjO9w0o9xoyRr3xH48TtMjIgkJ9FoubvlH+tapD0RJ2r+ZkuBfvdzQJjG3Fw+gRreBES7lyUPRLgxn8YiMnymh2u8I2qmQLLRmRYJTgB/Y4e/vcq0xNCvljRo6oangOER8Z85hdOejgp741upD9xNMTjEFTVZL1QZS6pg5e2mhw94Ad/jt3TnJKfrfw+5/b4nIq85MkibQIqgu/sM4ijgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96jKjSK80Np5UdxpSa/6EJV1gHnAr6/IdMBPSy6vtg8=;
 b=w0E/VZfr3yGjqZuyuptD3mZhcNaxzd4kLLWOe3EXvd5rSPE/BJXXxS4E5FjYsQEUbgKBXVNblExOwkvQ2mybfHcf+YJzL8FCJTl7k14GNO6DWFpOR2Ge9f0Cesx/Z8qL3CMYpGuye3Elj8SCNNbwYaiTxSN4xrBxROKNHGsDRWketPemVkBuvpD2DBVWUVT1JPRMCP7Ii1dIB+BExCEznq2uQegFlJzG9nSw7Mi2aJuQCvvJS+O46dr85N/XGRS/kf/Qc+7GwOaJgL2TNa4WfSjXuEwfqY7PstVmAefM3wYbRHR/o3FA5uIStMVYlY2IK5ItHILrUTHQapi34g+TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96jKjSK80Np5UdxpSa/6EJV1gHnAr6/IdMBPSy6vtg8=;
 b=pUKb9bk/D1pLlC0sa/WDyuQBxwAz63avMxxXJE3uGSjbwleO+RcUFSt/Iwsfpn9L8n+EwcgGWosWJu1fRlwUf/A+/OjRCbJ7T4CSColKXBEPeqwQ8jdfwz1qGFl32P3Q17rA8bPHHMM42W8eM2cIbVHG/5ezcD7uAmUj5Q4cGCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:10:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:10:57 +0000
Message-ID: <6198e6b6-96b1-4b8e-bde1-3429be71d387@amd.com>
Date: Wed, 8 Jan 2025 15:10:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb7fef9-457a-4a7d-c406-08dd2fee4571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUQweG1YTUVnSnNrd3JhcFZuOEpDK0JNWkpubEx2M0UweTBlNjhyelJHc0Iy?=
 =?utf-8?B?c2JoNnVWYjBJTUhyK1RrWXlmWkd0Z0xKM0UxczdRWEJkVlNuRUxKSTViZDQ2?=
 =?utf-8?B?Wi9LZEl2UE9pRHA1c0ZWSlhhZ0Z4emF6S0I5UTNrblJsMCtyVUQyak41N0No?=
 =?utf-8?B?Ri8raFpTa2taQzdoNTR5cVVYTG1oNVRsZjNJa0l5RW9BenluaFZ3U2NTWUll?=
 =?utf-8?B?SEhTQ0k1bnZOSjcxQ2ZaS21sQ2VzVThvSmNMUC9xcGM1bVdwQXBPKzhEMHFp?=
 =?utf-8?B?N1dlYVUxSzFqZmltZzMyakVwdWlTMlhzZlZIbG5EYlYzVWxqNUM3cEhRSTVm?=
 =?utf-8?B?djRjMlZHQVJzaXF4dCtLMGlnbFoyTXlwdXlqcFUweEZHNjVDSjhOVlF5bkN1?=
 =?utf-8?B?c2JiUjlsNzhYTThOYXFubVdZMUpVWTMwWEdFMjR4dFNCenpuUmhTYmpmaktQ?=
 =?utf-8?B?dTR4SDl4VERmVG1RM3paRk5Jbkx1dEdMZzNJeDJZRHN6bXZveEpCcFduM0ZX?=
 =?utf-8?B?ejRhRzloNGVmR1BlQzBQSWlUTVNXMlUyNzV6MlRrbngzRVYyaXIwTlQ3bGlh?=
 =?utf-8?B?SG1wd2VYdFA3eDBzWGRwL1BSU0NlTlhDRStxc293cHNXN1Q3NC94TldEcGpL?=
 =?utf-8?B?VEgydjJuenRXUW0xRy9XQnQ2YWV3emhiYzEzM1lxbFV4RnBoU1duVVlTTHlF?=
 =?utf-8?B?Y3FkRkFWR2s1bytiTm40WHV3UFc5TGtBQzY2NUN3SEhEdWcyc01vNGZMeGI1?=
 =?utf-8?B?eFh4ajl1d0YvWUNBZkE4NU52UTdYbTFKQUN6VVB4b01ZZnhWaFg5SHNpbEJV?=
 =?utf-8?B?NTV1TFNYZWMxemdYaUpudVZ3UFdKZ3hrbkpmd0tMOHJDbWdpdXAyVUNpYjhB?=
 =?utf-8?B?SXpCNjNrWlVYaEpjdEJ4RU5JenhLY1QwYlFSYVFDa1JFeGFLWUZQYmZTa1Ri?=
 =?utf-8?B?bzBneE9YWUpGSGR3OWVWM216S1VoWXBFckwvTWlPU1BwQ1k1Y0VxOHFqQW90?=
 =?utf-8?B?ZGpYWkdIb2ZTV0c3Y1YrbVdpRVhsZjhyZWo1Ri9GK1ZLK2lTbkhSTzUxTnNQ?=
 =?utf-8?B?aXVZaDM2U01QWWdhdGN5TjhsVklPZ2Z1Mm5mL1ZqSnVsQnJuWWJyYjZYYm1E?=
 =?utf-8?B?QmY5cUE1TGNYMEJ6Q2pwZVh5K095YjhFMFAvd0ZCUGErZlN6SWV1am9Obzkv?=
 =?utf-8?B?bkpCd0hHcVBVMTJOd0xTL0h5TFFlN3VQWTU3UWdETEtLNUxUcHdPRGtMVmtu?=
 =?utf-8?B?cEJWSk1Ba2R6L25LOE52aDV1YXljV1ZkSVl1a1d1czM1TVZ6c2VvTFRGNEJ5?=
 =?utf-8?B?UmptOGsrWFhFc3hzK3RDTUcyNGIvNjdqdE9vTkdQRUhKRUNiKzZRaFVWZExC?=
 =?utf-8?B?NWpzUXVSOUJuRDhxbkFpTVlYbTRmSEpHcGYwUzF5bFY0WVBiUHdxMVl4U3R1?=
 =?utf-8?B?azVsZUJQaWpJNjhwaFNMbVdFTHlTYUdqOFNPaU0vMGhrRGJ1cHVMdHQ0NFdv?=
 =?utf-8?B?ZjE2QTdUbHpTYlpxT0swQW41T2hUTjhLVjJBUllJMmhwZHUwUkZ2M3NHNysw?=
 =?utf-8?B?aFRpU08zZGFVQXQrUFlpYXd0a2UvejBtOUNJOU1saUJ6bi9KRW9YcXNVSlUv?=
 =?utf-8?B?akxWTzhpQk9CZnpRcTRreVNia0ZrTVVBeVFya0g1M005UTFQUGFUcE9ZT3g3?=
 =?utf-8?B?THFEdWZLNnEyMEVMazVBNlQyTlpoM2QvbUtXNkt1Y0YyQVRJQWRpbnBiQzgw?=
 =?utf-8?B?bitkcFlQZGVTd0UzTUx6MGpmZHdtNmZyRmVHcFQxWWhENDc0eEVFQnNMV0gw?=
 =?utf-8?B?WUR2K0w3U1NpajhmTkNrOWZtVmhLbi82MGE3MHlQaU1iWXNJTUYrZDhxTnZn?=
 =?utf-8?B?U1p0Nk9OTVdhenhMckR5ZHFTbkhTYmdYOVBTTGc5ZVQrTE5xQ2FUM2NSRTBp?=
 =?utf-8?Q?nXOtW6hpQQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUIzOFFuM0xjbTI2d2pIYkVDZ1pYcTZSczVXMjBkYXNHekdtUUdnWDNEWS9O?=
 =?utf-8?B?ODN5RXVNK0dsSGh5UmpKR1ZqL2czSlRJakpoVktnc0xIb21ueU5xZmp4YkYy?=
 =?utf-8?B?cllPTHVpOU11ai93TSt1MlRlRXJVYXNRQWRYRWlNQTIzcnBhdVFtMk54RjJQ?=
 =?utf-8?B?MzR5SWdpOGpwNXFiNHFTN2pyQVhlbHExcWY2d21KS0g1UGY2SmE4S05Bc1Zx?=
 =?utf-8?B?a3VqN2Z3d3ZlY2V0ZlIySHZQSUF2enJ1SHk5VVVsM083TjhRdVVCWSs3Vm5X?=
 =?utf-8?B?aER3T2lUSkFDMVRWN2VuZEJ2Q2ZLVktMVjZpVGZhTlJXOC9XSEFnK0dJZ0Qz?=
 =?utf-8?B?bmI5Y3FTQ1ZOR3lCSTNhdWF0Qlg2MEdweSs3WlRaN1NnQytLOGw4T3BPVnli?=
 =?utf-8?B?V3NIT1BncFg1aTdUZDNrNXhaSjZ3L3hSeFl1Uy95eXlRQ01PZWJzY1Y0eTZx?=
 =?utf-8?B?Umk2dzNrSnR0dlVDTVhoQktkZWhQTktlUXhFS0JPK1UxT1BHQ2ZnVit2VDJW?=
 =?utf-8?B?a1RaeVd3aG03T2RUa0ZGZ3FBNDdVZjN6Qm1relNSSDlJd1JsaUwrY3NyRnRn?=
 =?utf-8?B?bEhoeDhFODBLNHN5aWkyS0JXSUorSUczZ01tcE9lUHMrYlJib0pqYSthZndF?=
 =?utf-8?B?bVRoMTloZ0plbXVIZkNRc3l5RXVQOGRBUjlFTWZ5T0FQbkw3Z25BRmJ2MEN5?=
 =?utf-8?B?NllBams5TFByMG1qWlJwaHNrT3htazZQN1U1TjBQbm10c0F6K25GVjZ5SEU5?=
 =?utf-8?B?M1FXbWE2NVNJNGRwaVBZajA1OXQzQXlEeTJ3bU1rNC9WMHVRdVEwVk44UnBF?=
 =?utf-8?B?OWNRR0JSS01wTmRpL3l6M0VLT2RGV0VhYkozU2tmd01DczVNdy9WV25zbnlr?=
 =?utf-8?B?aTg1ek0vam5RR0NTM0xWeEdxb0ZxcnAvdTJXTHZ1ek8wUDFnalgxaSsya3oy?=
 =?utf-8?B?ZGQ3RUE0K214VFFzcllOd3ovSE1rZXI4UEoyWnk5T3J6djlJQkVRUWxlN1NN?=
 =?utf-8?B?aGlQWi9xYnZpNGJqTEtIenBZOTA1K2RzemZqR1lGWTFZRDAxRyt1K3VkdE9q?=
 =?utf-8?B?SzJkZTBaZkxSR2poU0pOdmVlRm1EZlpHSFNBdlg2c2ZBMlRXS2pJbzdhSXNk?=
 =?utf-8?B?aEZvR2hFS1FrbENlc0lNbDFQcTdjVGhPZlcyaDdFYmNQNjliTnc1Nm9DaUs0?=
 =?utf-8?B?SkZSVDdTMkF2ZzZ0WFFBVUQwdG9DejgwaHZ1NkRTbkc2N1kwdUN2dE1RODA3?=
 =?utf-8?B?RHNza1JGUmdrUzNaM0h5QTkrM0JuTjlIZTF3MC9rZzVEQldtRFNZMFZLbld3?=
 =?utf-8?B?bWRkOUVUb0hqTkRRdnlKZUFORkhlSCtCTUJtR2xpU0VCMEVYMG9oWEw4S1JU?=
 =?utf-8?B?TlVOeXA5Q2daa25IQ2Vzd29UNzRDems4THRJM0dDQW5LZDFzVEIxcHdhNDUr?=
 =?utf-8?B?dWozY21TL1hoSnJSblhvdDdoTWowMVl2ZC9WN2xMenVUejVXcXBCS3hvM2pH?=
 =?utf-8?B?SGo5NEw1bnpxRDUyNnJlQXduL1BEU2s2SzFuL25zVGN3NDNndGRuQkxqV09u?=
 =?utf-8?B?b2FUWjcySS96S2RoaEc5dklRdTAyQTZnRXJua3BwYkcyR2lFS2dSSzVnbFBk?=
 =?utf-8?B?ajlVQ2d5MjVSdEdPQi8rMUt0VjhXSVlzK2Q1Z3lnMjV0L2lFa2hSdzVxK1Zk?=
 =?utf-8?B?RVEwb3RNRkNBbjVRUjdBYWd3d0hUL3RNejlYVENldmNwb0tXc3hkYkxZQnBM?=
 =?utf-8?B?U0JMUDNHaDhuUkFyamZlWGROL2RxZmVuMkp0K0twa3U5TjRkVWxsRHdBNGEr?=
 =?utf-8?B?MS9vanAzemxwc1pNYjhmMUV5YnZSeFBZMWREbmR1M1NRT2hkUW5hZy8vbWFa?=
 =?utf-8?B?TVFrVk5ZenlneHpHcnZGV1B3SW9CaW5CRlB0cVVwUXd0cHhJMFMzTjU0Zk9w?=
 =?utf-8?B?V2NrdlpQdGJyYUdhTjkrY2s0VklGVkdEbm84MUZLbTRBK0NlMnBOZ1MzSnFT?=
 =?utf-8?B?bHVFQzdmVFloaUFzVFhZcjF6T0hSSTJMaDlJek9udGMxZ2FseVlMa0FKczVN?=
 =?utf-8?B?TFY2cTZvcVZiV3pUdnRrNmtmWTJqanpuQzJmY1k4dEIzMHo0K3RmMExjSmlJ?=
 =?utf-8?Q?dYPFqBUkrU23IiNzWMk+jZSOE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb7fef9-457a-4a7d-c406-08dd2fee4571
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:10:57.1572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXTTrldoEfFhrb4k9lH8FdzzxLst6zO79RWYn2DxjRLCBLT5vi+OGbskh+wflYxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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

Am 08.01.25 um 14:59 schrieb Jiang Liu:
> Subject: [RFC PATCH 00/13] Enhance device state machine to better support suspend/resume
>
> Recently we were testing suspend/resume functionality with AMD GPUs,
> we have encountered several resource tracking related bugs, such as
> double buffer free, use after free and unbalanced irq reference count.
>
> We have tried to solve these issues case by case, but found that may
> not be the right way. Especially about the unbalanced irq reference
> count, there will be new issues appear once we fixed the current known
> issues. After analyzing related source code, we found that there may be
> some fundamental implementaion flaws behind these resource tracking
> issues.

In general please run your patches through checkpatch.pl. There are 
quite a number of style issues with those code changes.

>
> The amdgpu driver has two major state machines to driver the device
> management flow, one is for ip blocks, the other is for ras blocks.
> The hook points defined in struct amd_ip_funcs for device setup/teardown
> are symmetric, but the implementation is asymmetric, sometime even
> ambiguous. The most obvious two issues we noticed are:
> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>     are called from .hw_fini() instead of .early_fini().

Yes and if I remember correctly that is absolutely intentional.

IRQs can't be enabled unless all IP blocks are up and running because 
otherwise the IRQ handler sometimes doesn't have the necessary 
functionality at hand.

But for HW fini we only disable IRQs before we actually tear down the HW 
state because we need them for operation feedback. E.g. for example ring 
buffer completion interrupts for tear down commands.

Regards,
Christian.

> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
>     match the way to set those flags.
>
> When taking device suspend/resume into account, in addition to device
> probe/remove, things get much more complex. Some issues arise because
> many suspend/resume implementations directly reuse .hw_init/.hw_fini/
> .late_init hook points.
>
> So we try to fix those issues by two enhancements/refinements to current
> device management state machines.
>
> The first change is to make the ip block state machine and associated
> status flags work in stack-like way as below:
> Callback        Status Flags
> early_init:     valid = true
> sw_init:        sw = true
> hw_init:        hw = true
> late_init:      late_initialized = true
> early_fini:     late_initialized = false
> hw_fini:        hw = false
> sw_fini:        sw = false
> late_fini:      valid = false
>
> Also do the same thing for ras block state machine, though it's much
> more simpler.
>
> The second change is fine tune the overall device management work
> flow as below:
> 1. amdgpu_driver_load_kms()
> 	amdgpu_device_init()
> 		amdgpu_device_ip_early_init()
> 			ip_blocks[i].early_init()
> 			ip_blocks[i].status.valid = true
> 		amdgpu_device_ip_init()
> 			amdgpu_ras_init()
> 			ip_blocks[i].sw_init()
> 			ip_blocks[i].status.sw = true
> 			ip_blocks[i].hw_init()
> 			ip_blocks[i].status.hw = true
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
>
> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
> 	amdgpu_device_suspend()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> 				amdgpu_ras_feature_disable()
> 		amdgpu_ras_suspend()
> 			amdgpu_ras_disable_all_features()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].suspend()
>
> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
> 	amdgpu_device_resume()
> 		amdgpu_device_ip_resume()
> 			ip_blocks[i].resume()
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 		amdgpu_ras_resume()
> 			amdgpu_ras_enable_all_features()
>
> 4. amdgpu_driver_unload_kms()
> 	amdgpu_device_fini_hw()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].hw_fini()
> 		ip_blocks[i].status.hw = false
>
> 5. amdgpu_driver_release_kms()
> 	amdgpu_device_fini_sw()
> 		amdgpu_device_ip_fini()
> 			ip_blocks[i].sw_fini()
> 			ip_blocks[i].status.sw = false
> ---			ip_blocks[i].status.valid = false
> +++			amdgpu_ras_fini()
> 			ip_blocks[i].late_fini()
> +++			ip_blocks[i].status.valid = false
> ---			ip_blocks[i].status.late_initialized = false
> ---			amdgpu_ras_fini()
>
> The main changes include:
> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>     Currently there's only one ip block which provides `early_fini`
>     callback. We have add a check of `in_s3` to keep current behavior in
>     function amdgpu_dm_early_fini(). So there should be no functional
>     changes.
> 2) set ip_blocks[i].status.late_initialized to false after calling
>     callback `early_fini`. We have auditted all usages of the
>     late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid = false after calling the
>     `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
>
> Then we try to refine each subsystem, such as nbio, asic, gfx, gmc,
> ras etc, to follow the new design. Currently we have only taken the
> nbio and asic as examples to show the proposed changes. Once we have
> confirmed that's the right way to go, we will handle the lefting
> subsystems.
>
> This is in early stage and requesting for comments, any comments and
> suggestions are welcomed!
> Jiang Liu (13):
>    amdgpu: wrong array index to get ip block for PSP
>    drm/admgpu: add helper functions to track status for ras manager
>    drm/amdgpu: add a flag to track ras debugfs creation status
>    drm/amdgpu: free all resources on error recovery path of
>      amdgpu_ras_init()
>    drm/amdgpu: introduce a flag to track refcount held for features
>    drm/amdgpu: enhance amdgpu_ras_block_late_fini()
>    drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
>    drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
>    drm/amdgpu: make IP block state machine works in stack like way
>    drm/admgpu: make device state machine work in stack like way
>    drm/amdgpu/sdma: improve the way to manage irq reference count
>    drm/amdgpu/nbio: improve the way to manage irq reference count
>    drm/amdgpu/asic: make ip block operations symmetric by .early_fini()
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  40 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  37 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 144 +++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  26 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  23 +--
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 ++---
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  17 ++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
>   25 files changed, 326 insertions(+), 118 deletions(-)
>

