Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE123C27C55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 18:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A28810E16D;
	Mon, 10 Jun 2024 18:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TrtlgaHD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85F510E16D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 18:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuHtZPWJvfY/gz0v2XiHK/uhsEVXciuQr/QFZJoXDqPRC6zU25FFza4p+i8lJTLkumaITPbFOIDT7aTjZOmqiZbVLFZxkFjmJLONLg4wW+VIHr1fh13MCLHhAii1eAQ6h1VV3Dlkz+qKxfR6oD3SXWM+QzBgov6i9fjtzSceOQ/FZN99RGkPYTieadrXjm9iX12VHZN6Iw7ua2GKE87YTb0nEhnzzzkjieSyGc55067cis8C8xjTFO7d2la1SdztGVdv72Mnque+dnAibuGQaBYvmTBOdtvCRSh5ZyXkJ6TwOjZ4/Vzd7jVnEwxOAgSYZOvOZ1yPczlssqUxy9dHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC6wyCzpDOB+yoOjz60iiWC/LkkMeBHFrGmkPgA/t3s=;
 b=gChYsTorzBmgblBCk9tflRE9eJtYf/ag2hvVXOr2uT7FOsul30x0UJ7ylwOfVimz5gL52IH17HKKWmBbNo2RZsGIbRuy3KdaAQKQJ1fZy2BQcE1KMLCAYMkcv+4w5oZK812XDC+JFgTOBhq7oSbf/0W3848LlyTWROJsOKLdFdfivczo8TujX3gf7IW8UAiaFKWllwJQI5KTorD23UtRgg9KuTLDJyIdqcXpX94RP8PqZxTofcEoC/9p19dxznkv2zdq0wPkQQZsWs0NrpJr1jwmO2M1ZPi6IQ5Iupruf6S6/ZQFgxLWTY78Dj9z4wsQOgYZ2uKJPKZtQj6qYgobaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC6wyCzpDOB+yoOjz60iiWC/LkkMeBHFrGmkPgA/t3s=;
 b=TrtlgaHDeQS7JVvUY7mxi6gl3rs5Yi2BJ1X0uon4b3SNiG7vQjx0zuYIGXxHGgTjFTvFetgUgG6oEPGAbbKs5hNjYhWddR6KWm+751beK/aZ50R8onEXj5qV4zlIyoxlf03IfEx1DQ7nzk9PLnVeFlpJh3+0l1z01HcbFUF8bPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:05:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 18:05:30 +0000
Message-ID: <bdd4793d-fd0a-4331-8667-7f9616d55b3a@amd.com>
Date: Mon, 10 Jun 2024 20:05:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Fix the BO release clear memory warning
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com,
 tvrtko.ursulin@igalia.com, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Richard Gong <richard.gong@amd.com>
References: <20240610180401.9540-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240610180401.9540-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 391fe576-9ebc-4208-ba7c-08dc8977ea0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnhhR2NnYm1rSUw4OWh1MlhhT3FHSUt0OWNJQjlVZmpQUzhGY3FIY05EbVBO?=
 =?utf-8?B?WCtZVmJhRUxiZnJxSmlQa01RZ1Y0TElKaDhVQXZ4anpLZXQycjg2WXp1Nm5u?=
 =?utf-8?B?U3VJa1kzVXNHODg1b1ozQnZkMmVOUU56WUt4UnRBWFlOcmorQzlkSThRRWpi?=
 =?utf-8?B?S1QzT1BiS2E2cUw4L0toUmVNL3dQY2pyVmw3cGFZZzdpVjNKc1QranhlWjhk?=
 =?utf-8?B?NThEZ1o2UTY1MUIvcnYrdXdVOEpmVy8xRWlWbzJUUC9xM1Y3VXpTU1dqZnhV?=
 =?utf-8?B?TUNDUGZHeEhrQXkxSmtyUjZFRDRyMmpYWUM1WGJaQ2J2ejRka1V2VG1iZjE3?=
 =?utf-8?B?SEROV2loM2xnM0V6bXdOaDA3eVRuRmtlYnlOaFBZaU5EalBLamRHS01lRHhr?=
 =?utf-8?B?VjFOM080OHlLcTRDUTZldm9PTmRXcHk0eHIvbDJTWFRDMEFsRlJyWTkyM0pR?=
 =?utf-8?B?VXdXNEEzR1RvN2IyVDU1aDRzUVhVOTFDYlZQRnhacjdyN05uMUJvNXU4Rjgz?=
 =?utf-8?B?QWw0NGFONW5Xd3hOeXhGNFE1TDJVaGR4UGhHR1FVS08vZTZ5TEh2SmlvaEhP?=
 =?utf-8?B?bEhZa0JRR0xyZE5TcHFnR3BFN2d6KzExV1NHaGVtN2FHQ2RUTUtqR1hZekJI?=
 =?utf-8?B?VWpzYk1CK0lkUG0vV2k3N1h6UHRoR3I2Z3VzY2R2M1BtL09XSVJhYThvcjBy?=
 =?utf-8?B?YjFuV1oyZ3VXL2xFUnd3V2ErMXZINUtOSjZINllmWGlOUVAwc0dQSkkxZzJK?=
 =?utf-8?B?bGpLZXU4eUxiODRONUZYV3lSUVl3KzZOV2d4OHYrRjVNbnF0emhHZ0UzTlp3?=
 =?utf-8?B?WlIvbng3QnJWRHlLTi9taUd4QSsyc3hQL2JFRlJkVHpnVGdkaXhnQTU3MHYv?=
 =?utf-8?B?NjdueFpaMkY2Rk1BaFE3TnR2S2FveHdZdkdEZzJxdU43R1A2RnZSb3hFV21s?=
 =?utf-8?B?YjFGK080Tm1IRjJXSHBJZFh5dGNJK2kyWWFCb1pkM2xJYmNVS0JncHcwUHA1?=
 =?utf-8?B?SnJRUkRIQVNBY0ZINm5iSnBGY0puNGdZUzF5TGhJRWMxRlo5TmZmdWdUQmV1?=
 =?utf-8?B?bHZNWHQyUFFkT01wdXFDZGdBdzBHSms3Y1lFaVlFQjlMS1o1eUhFOUw1ODNE?=
 =?utf-8?B?UE1JNExZbSs0OW4zR0ErTFhYMldDNWpPcnVRaDdRWUExUVBYQjBQNkRLeEJI?=
 =?utf-8?B?SjNCRENxL3krQ3hRMGU2dnR6eU9oR2lwQXVYbUNoNmJWMzdWa0p5ZEUwYktL?=
 =?utf-8?B?K1FHMlgydUZoSmxLWkpka05BdVBYWU5LNFZ0akpqRHBHYnBKWE9CbjVIalls?=
 =?utf-8?B?ekdUYjlPWnNzbmxPTllrbUtWWFV4RmJjSDIwVEMvb0FJd0RnNnNoSjZRS21E?=
 =?utf-8?B?enM4dTRWdDV2NFk5TnlxZDBJVEhhNFBtSEJ4bVJ4aVdtVGV4cHRIbE8yemZW?=
 =?utf-8?B?bGJ1WllCVXhNK1diOFdSWEVRbmpVcUkrKy9TZkVabjNsSzk5TTRaQWkveFIy?=
 =?utf-8?B?R0tyL3pjMGRqTzVLYURoc1RPekN2TmVYWGc2aUZ6S1ZITklrbUhLWmY1dit2?=
 =?utf-8?B?NEtjRWdFUDRFOU9RZFMzeGVGTWJDUU1CV2YzVG1idGxNZThiRE5DWWI0SktB?=
 =?utf-8?B?bnhhczFYbkk0bm10Ylo4VSttbEdOQUp3YTJ3Q2ZEbDIveVZ3bUk2YlhPRm40?=
 =?utf-8?B?dnFFaHM5SUl1dklPOWE5R1hqeUxqWVdXT3lycmU1bjF1SWFoVUJnM0hjT3B2?=
 =?utf-8?Q?AImODj18XOrJdFaNBpRGyyxGrLbUNNgytt5A+/B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZNKzd0R3NmczhVZmRJMjNsMXByZDNZNXViR1YzeEZIOURSa2cyZ1ZrUFZr?=
 =?utf-8?B?Z2hRZ0dUMVd0TGxzM0lmYkRxeHpNQmJobVNIMUc1VWJRdW5OZWs5b1dUZFR1?=
 =?utf-8?B?bkJPTUZhRlBNcWxZUExUNXdKK1YwLzRLOTZjMjdsdDJodnM5L3U4YU5LMUNs?=
 =?utf-8?B?R3NPU00wOEkzSTg4bklqVEJQbFdVdW83ZFA4YzAvaGxYTlljdWtCK1FnTXBZ?=
 =?utf-8?B?TGROdXVHZXZMbXFMVnNUT0ZrOThIU1dzT05UaHRJYU9HYVZmWEtIN0g1TDZx?=
 =?utf-8?B?MXMwT0paVWpTZ21raEE5MzB5OHRudjFGTy9XNGRjcDJ5OHdYL2VNeTA4aG9m?=
 =?utf-8?B?cWR3c1d2MTlkMlVWUTVmWlNBRDlETktrMkRGb3J2d1A5TEtQY1pad05SY3RZ?=
 =?utf-8?B?WDIzU2wxVGlmVWJzWmNVTk1CSGpyOWk5UUh0eEpTSFMwM05UWE1PbmhuL0No?=
 =?utf-8?B?ME5iaXM0T2xUQy8va20rL0FDUmhSYTJraFA2NnYxcDRLMnl1UFlZMHBUWENq?=
 =?utf-8?B?MXlzZTdYZzFpTk9xWFA0cytOWkdmUmdlZmJBNkhWOVFWdkpDV2pzTVh1SUtW?=
 =?utf-8?B?UXhibGJ4ZUFoSEE5SXJRekdMWExXTnF5S0lnK0RKNmovZW9mSkI2VXVIMzA3?=
 =?utf-8?B?cDJDSk9maXVjditvb3IxMFp3QXAyYUJQd01ZSHR3Zy9TeWtTRzl6a2QyNmxH?=
 =?utf-8?B?K2N2bVdxMEw1c2FaeVAwYzI1SzF4bHRpOERkclNDZDZOZmpHTlVxTkN2ekxz?=
 =?utf-8?B?NXBaWmZlNFZZWjdxakJaUThsSG9HVi9ZWXVJUFVRbjl4cmFjNUYwMDZrbS9H?=
 =?utf-8?B?TS8yWXplalJ3OG13bVFCejJYQlN1alNWWlJlUi9HVXlCQlBTRGUreFd4L0J3?=
 =?utf-8?B?NEtXa0JYZG9IWUs4MUYwY2dsSlJlUC9pNFIyZmZ5aVJQcGFzK1cxTXZUOE1i?=
 =?utf-8?B?VE9jcC9kYlBnbUlHY1AyeG5jdWh5MXY3Vm5PWFlKVWJkbWE3dnhyRS9jSitW?=
 =?utf-8?B?S3pSUGNWSFNmUmtFZGJBa3N0TDlpb1BzR3RlVmpUMXBZZS9RdTA3WTg3V3cz?=
 =?utf-8?B?Q0lmcERRRVJQVnJZcWtsKzcvS3VQU3pSK01sUnhVQThKQjFaM2ttek5ZaG5T?=
 =?utf-8?B?WlBvbG1lRHlkSitHQXd5RlBrZzBqYUNIeXpxTUJ0WHh1QmlwYzhhbXhLT3By?=
 =?utf-8?B?dWJBRk04clRxaUV4OTI4cHh2MUQvOVFEb3c1S01RMlJzREhYVm5aVEtyUGw4?=
 =?utf-8?B?a09JcUZ1T0FIdmhzd2JrMUtlMW9BTVhXenlESklCM1FIVW42ZDZURHFCcSto?=
 =?utf-8?B?WWwrOHZ1OWQ2UUhXWGo0T2I1Rlk1QXZQSno3VmdJWWNVTGF4VTdJV0lza3l6?=
 =?utf-8?B?R1FrSVlUdGxBYUdzMFgzbi9ZVCtNMTYwYWZlMHdXVnVoWGUrVS9mVC9qUjFR?=
 =?utf-8?B?d2NqNUptaEcvc3NqRHRiRzgzWWFZMDZFVFV0RFZoMnFLc28ySTYycThyMWho?=
 =?utf-8?B?cklVRVdaSGdpZGtQNVArczcvcmNKSEg0MWZIUU9zZHk5clpoNUdXUm4xOFhT?=
 =?utf-8?B?ZEcrci80bVRIQnQwdXdKZXA3TUl1cE9jaFNMVjRVc0xQV1JENTZIYm1uZjdt?=
 =?utf-8?B?aERVTktOVjdCekpzNitRTW5pWUM1VGNmb3hMTmZWdUxIVnBqWVJZWnE2MTJn?=
 =?utf-8?B?WVlMa0syeFRZRlg3TmprKzcySjA5REc1amFLM21ZNzBtMUlra0IxTU91clRy?=
 =?utf-8?B?cjQrcFV1bUQzNWNUYnNNd3FTUFVqcVZrQjV3MTJDclMwUCs5K04yZEVkMlpx?=
 =?utf-8?B?Sk53eG95OHVSQit5V2dxaUtaUVN3eXJaY0IyYTRac1Rna1NOR2N6cWZ2eWlk?=
 =?utf-8?B?eDZ2YzhTUnhGQ3JHTDYzUnhSWU82dU43TlZCQ1ZWZzVSMTNBSmZzZlZzM3lL?=
 =?utf-8?B?dkE4dTBNbUs5M1U0UHJCTTdtMitTZHVDalRidGJvcDhpa1FtR1JqaXlObU9x?=
 =?utf-8?B?Kzl2K2ZWMDdSWlJyQ2lnK2krV21yWHZHNXRGWXNpOEJlUHdKZ05BVVcyeDQ5?=
 =?utf-8?B?RG4zS1JHZHk5cmswcnlrZzVxemg3aWlUZThkbjRNTkNMUE9KSnlLK2RuSFYr?=
 =?utf-8?Q?LDivNDdAnRbM1cp4OTQuZpBcP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391fe576-9ebc-4208-ba7c-08dc8977ea0b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 18:05:30.5557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqEk2jBCs06OJ7bZsZGD03b633h1yx8dNFkWatfrrd/zAlSH3BAKsnf7stfNxUAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

Am 10.06.24 um 20:04 schrieb Arunpravin Paneer Selvam:
> This happens when the amdgpu_bo_release_notify running
> before amdgpu_ttm_set_buffer_funcs_status set the buffer
> funcs to enabled.
>
> check the buffer funcs enablement before calling the fill
> buffer memory.
>
> v2:(Christian)
>    - Apply it only for GEM buffers and since GEM buffers are only
>      allocated/freed while the driver is loaded we never run into
>      the issue to clear with buffer funcs disabled.
>
> v3:(Mario)
>    - drop the stable tag as this will presumably go into a
>      -fixes PR for 6.10
>
> Log snip:
> *ERROR* Trying to clear memory with ring turned off.
> RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
>
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Richard Gong <richard.gong@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Please push to drm-misc-fixes ASAP.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 67c234bcf89f..3adaa4670103 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -108,6 +108,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   
>   	memset(&bp, 0, sizeof(bp));
>   	*obj = NULL;
> +	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   
>   	bp.size = size;
>   	bp.byte_align = alignment;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8d8c39be6129..c556c8b653fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -604,8 +604,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_support_uswc(bo->flags))
>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   
> -	bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> -
>   	bo->tbo.bdev = &adev->mman.bdev;
>   	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
>   			  AMDGPU_GEM_DOMAIN_GDS))

