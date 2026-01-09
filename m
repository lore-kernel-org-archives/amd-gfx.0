Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752BCD1A627
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C35710E8D2;
	Fri,  9 Jan 2026 13:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNOhUXoy";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6D610E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgi+sh+MQDCWML7XuRGvmsplKvK9oDL0Tna6WSX07gCtL7SvZCYBriTrLB3MfTI13qwc3hOEByuj7C6UnkOOD4omrkpb4rAZWVKf0qpoTaVnrTjI/qZB0xFtuKYdOey1yioPJnkDa4qUsCevcqhjb4RFOZJ0nr8z83OfxK+KBaK63siS3FyWrZlllAO/s3Plj/KKe6uoANq07QwlXcuRcONO0OUq2QVl2+whbVV7ycgfR5rXUQrqHnArAiDqClTyZYQ+KK/xQOXEd+Z39uqDyDPkKz6oGGp0qtz+r/wj17t9wGkh73wObOl0hAsrbl/Tf5L4hCECl8qb4s5nZRiP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p00qHw6q+RVxjaeiRRPKwGhJrEEnJBTc2XYVTWhzj3Y=;
 b=taxUvNHQA33PfbK00Toxj7J7FbMZowygGaTTISQmtRmxAXmbbv/1aYYK1gBljijOWssp+uL1cRD42PmKQwKNCUVWdsOumSNgQcAoMdxqS20ewLGkIBF7Nx7Q21MvqAvJ0h/I/WSxxFJzJFrSqnC/DCDoc6MA6X4dWAI8wC/UHfkCSkyeU1oql7y0AbzPDJJdIcD6y+L5vdy1Y/OihXlM2H0pULcWiur5LReo0BagjHrkXvPvNoTc8+uY9ZhwO8yLDpGXcQEf7mSwdP9tsKlRq+pxTsfP3BerhjK6qXWEqPhrM2ig8PIjtIQon0YvlfxLlQ5ucLv2Wo1+6F6rj2U/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p00qHw6q+RVxjaeiRRPKwGhJrEEnJBTc2XYVTWhzj3Y=;
 b=pNOhUXoyrVhA9SWIRH1O+aK4aK7Y8rxyxBk90CBqDtleYWnvULkXkuT5FljXDeHMitVFgwmcDqRyjAlgze4o8RDT0JmGdpohKRnjtr+zAq1ikMxBGckwGU67U8d1BaAJLlGB59nPCeE5faUkMR2Pjcp5BXwP/tGjxwArDDTppjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 13:48:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 13:48:29 +0000
Message-ID: <acc99310-5c1d-42db-8b08-0a1535b2d5ef@amd.com>
Date: Fri, 9 Jan 2026 14:48:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] drm/amdgpu: Remove duplicate struct member
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
 <20260109133314.88548-7-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109133314.88548-7-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 4105b70e-02e9-4eaf-5c51-08de4f85c576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3VYanV1eHRZVk92dlIzNXVZNWw5SHU5UnpZK2xMRWEyWm5ub0VMRFV2WHc4?=
 =?utf-8?B?S0c2VTJtVEpWSTN4YWNRMkttemVZdkhQakZ0SUZKMU9TaHFxYVBja3lEdEdt?=
 =?utf-8?B?YkpDN2x3bmpBNEdRSHVaYm1MTDRiazFzTytRUWZNdmpteGQ1TXorMFhCc2pM?=
 =?utf-8?B?alZ6UWtEcmZrdEJKYmRZcHltQnlxSVk5KzBwQXd6UWI0R0c1UzM4aWw1QnA4?=
 =?utf-8?B?WktmdnhaTjNHc2UrSHZkL01mODM1QzE4aHB5UktGNCtSN1dyTzFjNkYyWm4v?=
 =?utf-8?B?VzNHR3FoM3NSbElwYUZkSlVkbEE3ZHFlTTdxMTd2ZnBJY0F5TGUzMlBuVGtZ?=
 =?utf-8?B?UkJWRVNVWFhXYTdnM2VkN2JUcUxkR2w1NjRSOWYrc2FVOHNSL09EbzNNa05Y?=
 =?utf-8?B?Y3BWR0FlM2lYVmlYa0h6dWh6eCtrcVpieG1DV0g4SXpGbDVXekF4MlpOYXRv?=
 =?utf-8?B?V3dDWU43N0xNVElPRjBNV2s5R1Z5cTRvV08yQlVFanFWZFA1NitJdGdieTM4?=
 =?utf-8?B?dVA3UUh1OFVLQzJpQ05tdHhFbFQ3aFpEZDUweFR6UXBxSGIyZGRjQ3lKUDYy?=
 =?utf-8?B?L2huWHZoOGtNU2MyNWRHOVE4YXhNZG9mQUJYL04zU0ZXQzFiYWF0QzVaMVU5?=
 =?utf-8?B?SGluYnR2blhCUGs1YzZaT2pFZUtOUDNMWEsvc3pYamFCc2N6ODdOYVU2Z1kw?=
 =?utf-8?B?TGtJaFlpeGVGQmxYUHJ2YTZPUndTb0lLck9NVDFEa283MkR1S3l3NXF2ZCtD?=
 =?utf-8?B?WGVnb3BsTW9hdC9SY1hoY3lmekw0REdTc3BLcGd5QnFkR2lyc3c4dWI1bXNS?=
 =?utf-8?B?WDlxZlpTNkJkZU1kNmsxZ2ptamlJUDIzVHh0Q2tvaEo1QmMrRDU1UG5KK2Q1?=
 =?utf-8?B?WnppSEhzd1Z6eUxIWGtVRkhMUTRhbVZ4bnlmN2ptSzRGZ2hDV0s4TzBqeHFz?=
 =?utf-8?B?enZBUkhRcXZxOWtQdk0vNkZVSTRhQTVvczlWamhWM1h4RWpYdjl0aEtYSEVj?=
 =?utf-8?B?ZXN0UlM4amE3d05LOFJkL1hwcHZwOEdxM2FDTkg3MFRiU0NWN3JwMGtUTjd2?=
 =?utf-8?B?eXBMZXJFRGhzMjNzMS9SYndDYmh5RW1nTzlJM0V2YUlpRFExRUFpMnErSjBt?=
 =?utf-8?B?ays5NHA0SzFEQ2tvZlVFYkdEVm9WM05Va0ZQdHJlMGRYTGFlRDNNbDhuem8x?=
 =?utf-8?B?WFh6bHFIVDNLN1oyRE02emtxRVpielJiOU82M1gxejZMVDNEVVhnZldyWjRr?=
 =?utf-8?B?Q1ZUdmZSUWZ6SHB0RGJVRUpsYm9aMU1xQ1ZEL1ExZnFMRnBtb0pqOEhFbFBU?=
 =?utf-8?B?cWtmTVc2cXVRUnI5NUV4M01vdTNNR2toMWhlOGtTNUJIeDdyTExaU1JLR0hV?=
 =?utf-8?B?c1hMZEgvWjc2YVY1eXpZRzlMQTRoK3FVZzU4cFRGcHZsRnRnQnE5d01UdUdS?=
 =?utf-8?B?VlBLYTNManJCTmFQQ3JNRm5ENjVDQjM2a2VXVkliUzRJa09nMVZQNUlvU2xh?=
 =?utf-8?B?UlhoY3ZFaVVGOHFGSjNRcElVd0ZpRjdjK2dIRmdJdEpjOHdZSm0yR3QwVXFu?=
 =?utf-8?B?YTNGRzBKSHRYbnAyWUdlRUNDeFhYTGY4VW11QW1RUDV2NHpUZnJGN2F4Qlly?=
 =?utf-8?B?eDA5ZFFWaTFiU0lKRXdMQmZ5SzJZK042aFd3VE9jOHBsem1PbGNDMk9xT3Yw?=
 =?utf-8?B?OXdxSzIwR3A2WmhpbHFVSllBZVhKNmloNFVrYmdILytaSUI0cXNVVHk1YnNu?=
 =?utf-8?B?aUZUUGxGRmdZMWN4WDJSaWFRT3YwOGRLM0FTcTRGdm1PL2Fob0ZpYk9MVmwy?=
 =?utf-8?B?YkptcGdhdmVuRGM5VWt3MXQrUlc5NlUzTEZYV2tUVjJ0akhTdGJaVm5IdE02?=
 =?utf-8?B?M01QSTM5ekt6bkVjTElUZUY5SkdOWUZ0ejFUZ3lhcXJ2T0hIajdYejE2VkJC?=
 =?utf-8?Q?ud30n5akVRXLNmnnUIIRREFn1xpPnPFo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWhiYit3TXU5YUtLVnJUNnQvZDFQREhJVWgySEU5RmNYUjZZMWJRdXZqb1Fn?=
 =?utf-8?B?M1VUQytzdVRPNlVtNXJEQmcvOHlZN0VVU0V0RHNwY1pBQktLU0Q4UXg3REly?=
 =?utf-8?B?YVh1N2cybG5ZZ3NrNkV4b1kyRkRzS0lpOWsxdXNOem95ZEpxcURHOWxHN2Jo?=
 =?utf-8?B?WFRRTXVKWmI1VG1nWWdYU1EydUNTVWdXL2hJRGxTc3NoNjM5dTZCdUpGTUVC?=
 =?utf-8?B?clE2aURzWFV2bk9kcmwyU1ZMOVlZaDJEZWtPRG1NOTZvZHpqTEV3c0E0RDlW?=
 =?utf-8?B?a3ZFU2pVVjI3WmM4S0tDVDltaFJiUkd4UExCVUZyR3ZjYS9jMGdnWmc5L3hk?=
 =?utf-8?B?eUwrZkdFMXlNR1daNGloV0pUUXhad2c3RjdwREF4c1hHVERmYktiN0dJZlV6?=
 =?utf-8?B?ZmpNaHp5ekRvVnovVkQ2bk1zQXViSDZZUCtXRHN4eUFhRUpBc2NWdkszbzdh?=
 =?utf-8?B?elpRTFNqRG1wL2ZxZFNCeHJPMy9oM1ZNTjZTVFhFL1ZGRHM4VjZsZlJaV1ZE?=
 =?utf-8?B?VUlLS3NLRmJqOFlsNnpPbm9EM0JPSy9IZUxIVVFjckJXbEw4RXFXMWlCY2U5?=
 =?utf-8?B?MnIwaDlmTkpFVndPRnFpdmlsbzdYM0VyV2l5R0ZTYmJYTHp6N2pDeVQ1QzE1?=
 =?utf-8?B?eFZGbHYrZWZxOWNsSmR4dk1KSnlKU2YzMm0wNVBaakpGNG5oSkZrbDdubHFy?=
 =?utf-8?B?bFkxalRPaWlRcHAyNVhtZ3kzWjE5MlFNcjB3WGllTmFUUHh6UFdSMEpkZkp0?=
 =?utf-8?B?aDlwcUhUL2ZFejVYTUc0MDExU01mVm0zcWVJOVQ0YWF1VnI1cEJyTUExeFM5?=
 =?utf-8?B?cGxWVEgzMUE2SGJ4MzE1ZUR5SHNSMGRlblpDMUZtSTZhRE52NW1tT1FVcGJr?=
 =?utf-8?B?TmNxOS9FU0xmVVFub1o4UkllTTFmZDMxTTJ4cUtOdFVKVVVNbEllVnNXNlow?=
 =?utf-8?B?Z0g0dXNsRk5jRUZsNnNVbU5wSFhGazVYLzJDaVdWbitFT1dRZDJvdVdTODUv?=
 =?utf-8?B?ZmtkVzNVUkFDZ2g3TGw4bUcyZGtncjUzUm1lMmdGVUNkYlc4NnZadmhabGFj?=
 =?utf-8?B?c1JNcGNjcWljU2pFemRlZzNveWplUWIrN09zbGhqN0kySExuUjAzR1lmSWFx?=
 =?utf-8?B?NHQ4QjUyeW4xcGlVTkpmbDhOV2VFNDNtUFJFTmpnWUNJQnQ2ekowWU02ejVs?=
 =?utf-8?B?WWtVRmFlY1NqeU5vYlVWU0JMUzdxa2tuUkNhKzZnQUF0dlVQR1hnU3dESmI3?=
 =?utf-8?B?OEhQUUJ5d1YwN2VlaTBJU3oxZVQzbXdOT1FZRzZqTGtmc0VLL2ZuL0N1THQ4?=
 =?utf-8?B?ZnIySCtVSThlQklsNVVOMjVHeW1aV0lEYnhKOUhCWVJ4V3M3QXQ0R29hbGRz?=
 =?utf-8?B?TXV4YWQzUkJveVZSK0FBYUlUalRXNnNEeFhEQnQ0MURNQUdPUkRreWJIZmlB?=
 =?utf-8?B?MWEvdS93aWVqdGNRQVRkL0JWaDlpU3VQamJ1WkREQzR1SmhtOXBmNmd3M2JQ?=
 =?utf-8?B?b3B0RGpDZUZXZXkydWI4OHpHdENFSzg3SFc5ZmNZMU1VSEpGT0U5ZFBjanUw?=
 =?utf-8?B?eHRXVWJXNGREd0pURUFadzF1NjlXT2tvZW9rd24rYUQwMitjQXgzNnl0RzF1?=
 =?utf-8?B?Tzd2Yk1ScjQ3US9jVXFjc0taS0U5YXEvQjNUeDJvbG8yMElrampyd1Y3dFBk?=
 =?utf-8?B?V014ZWJ3WUsxekZkaUJrWXE4ODlEa1hybTQ3cllhUkNsd2c4VitsRGQ1N2pw?=
 =?utf-8?B?bERLSzRIaVJXTHNQWUt1bWl6d0pYaFVlbVJTYW54dDdtdTdZa1hXVDg1ODEv?=
 =?utf-8?B?aFVqVlB2UXFXVS85OHNMYmNHdndjNEFxR2RSQXc4SWF3OW1QVDhSdEUrRjRp?=
 =?utf-8?B?ZjZlbTJ5Nk1USUt4cVdNOG9YaDRlSjZ2ZGhZVlplWlU2Nmo5QmkxNU1hNFB5?=
 =?utf-8?B?eVA5OGk0MGlCTm5DWEpSSWNBaEc1UlljbkQzd2hXOGJhTVFuUjZRckFnS2tD?=
 =?utf-8?B?Y1h4Y3RkSy9sZHJYOTNRQWNvVEx0TDY5Mmd3U0h6eGdMbEJ2d2IrRS9MR3RN?=
 =?utf-8?B?Z21jUUNsVWQwRkluVVRLTmNMWGZiUzloQUYzRGZOOFV4R1FPcFZrWFJINWJF?=
 =?utf-8?B?akUzeDNEUUswQTdQcE4zTnNkbEs3Vk5tcDdVUXU3bkpvQVd6V3BvcXdqL2l0?=
 =?utf-8?B?Z3FmQmlOVjBUZC93WVV1RDBrc1h2Tm9mcG4vS2Y2bWpkVi8ydzRkd1l4RzB2?=
 =?utf-8?B?TXJod0dzTDJ6eVBKMEd0VnRjOERkQnBidXBrRnQyTG5vTFVaemNQRHJYaEcy?=
 =?utf-8?Q?5zIdSM0d9MLfOpKlWZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4105b70e-02e9-4eaf-5c51-08de4f85c576
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:48:29.7125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR8Dmdws87Tgs5xl7y9/ILWulLdLfDx/H+Cn5zvY3NhBYP8tgsUtQyq9cJz7+fkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

On 1/9/26 14:33, Tvrtko Ursulin wrote:
> Struct amdgpu_ctx contains two copies of the pointer to the context
> manager. Remove one.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index a5f85ea9fbb6..526810c76821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -232,7 +232,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>  	} else {
>  		struct amdgpu_fpriv *fpriv;
>  
> -		fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
> +		fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);

Please add "/* TODO: stop using fpriv here, we only need the xcp_id */".

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

>  		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>  						&num_scheds, &scheds);
>  		if (r)
> @@ -354,7 +354,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>  	else
>  		ctx->stable_pstate = current_stable_pstate;
>  
> -	ctx->ctx_mgr = &(fpriv->ctx_mgr);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index aed758d0acaa..cf8d700a22fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -56,7 +56,6 @@ struct amdgpu_ctx {
>  	unsigned long			ras_counter_ce;
>  	unsigned long			ras_counter_ue;
>  	struct amdgpu_ctx_mgr		*mgr;
> -	struct amdgpu_ctx_mgr		*ctx_mgr;
>  	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>  };
>  

