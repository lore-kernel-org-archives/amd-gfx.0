Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790E7C02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 10:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB5310E103;
	Tue, 14 Jan 2025 10:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3C7bpGM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F2110E103
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 10:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viZSwXV107DJurY8edtZ8x7ELGvZi5rA6SeVG98HGGIeZXf6MeWqUF0xUbx7kwNy3Sxrvj51WIkVLx1zjWfBUo0YiMTVSVoddiYEQTdcLPD2wZbvKhQo1164U5QoXvRt/Kd1ePpY2xGyW30kUVnW2+d1qU6Zop0LtPqf5n4za58ovsLHd0QcB2vKmRzZB87FeZ3ZGDR6RaLAuJtZZG/xVCfnxzVxxD9mZk+wrAzhvYn6NkM5fsTauXO+NC2GMlF9PyE0fiN3f3ln49JDAVjD1j+A+k7O5ATzVUmqAZHwIBey8pSiSxXQ28GSLiSQVCX56MpjSWgPoUumOc2DkyCVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHFMfLkXFh0dayIVm0o51U0k8Xt1sTPx+yXXGAINJwU=;
 b=Tvy4fIxnnyUvTk5XzbgbznQJJ7imBkclV0GczLM6drFTFJJcfi6F75V+41ieN4luuB2jcxWpMw52TZDH3buvLLFIJEdUy1AtON3k2Mw/G2yvsZCHYPS4tadWmSjXLHp20uc9c4WIcjcD0aYVo5uasp+fWUJuk/hpsvivsAqrxdGj9I5g8qhOOsLrYZPDKhfFEMPrdmRoe1n2vz2SFwmxko5n7XmAUwmoQ+RTxAUE/DAICacaB07j/mTQR63hfrpow08Z3g8hOK9u0r8MfnjPFEE8NHMKkzx3L7pOWO5Wz3LrX9AB0RLakvY3oPpy9nDKqzFJtZZJUxIPjxAKiTEMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHFMfLkXFh0dayIVm0o51U0k8Xt1sTPx+yXXGAINJwU=;
 b=M3C7bpGMr4Llv2nyi/27YZgp1G3FooxJv2O4pM4efwLtJZRAdQZx+LmWFVIQZzxw2IPn13ublKwzHJLTtLQgDaDll1wvcQaVkyAcBslcpAblSosO2G7yt8joToA0XaDF+fG3lhjygvf4JmcjTikeMmbJBPR8ititUtAQv/UL1e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 10:36:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 10:36:03 +0000
Message-ID: <4eda8509-9b30-40c9-af94-5cacf044698a@amd.com>
Date: Tue, 14 Jan 2025 11:35:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/2] drm/amdgpu: introduce helper
 amdgpu_bo_get_pinned_gpu_addr()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736847835.git.gerry@linux.alibaba.com>
 <5e08e4133ee13d172d6d313af5fe1e1fcfe80331.1736847835.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5e08e4133ee13d172d6d313af5fe1e1fcfe80331.1736847835.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 8648d2e0-1dde-41e3-1474-08dd34873e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K09STWpsYW5jVENlc3FGekVrUnVkZmFDYmhhb0RLSmpSQnNwN2N6cUhVV05s?=
 =?utf-8?B?anl1ZFdQdDg2dUpyYW9kbXVFN0w1Z0g4U3lxMjM5SUNsM2U5Tm5SVVFyRHNx?=
 =?utf-8?B?Z1JzSHBWaFZFRXh0LzFKUFA3R0VVbTFhVVhXMCtjcWV5cnpObG5ReFlXVUln?=
 =?utf-8?B?d2hyTUVjalBocnBCYTdZbGxBNDJTQTZNN3IwaXozOUlQN2p5NmN4UENJWC8r?=
 =?utf-8?B?S21mb1dzNGxuOWNLOHk1ajdoWWlFVjZzb0kvNnJzZ21jUXFyQlMxb3lnaHFP?=
 =?utf-8?B?ZDZIZW9mZU1hWHBLVWhFS3FJcktoaGxyNC9YUmlMbXhsRDd2M2Z0a1ZzUjZT?=
 =?utf-8?B?RysrK0pVS1B4NVNuQXI1RFlWd2RDazl1Z0VJWEFBQ1VSUDNwWHFoQkU1V1VB?=
 =?utf-8?B?R0J4bFpFendJTWl3RHFnUEdpOGd0MnhSbVJ1b3RTdmVTR0w1QlBaZlpVdkI4?=
 =?utf-8?B?amFUQ2R4VTExdVVNQjZUZG4vcWc0bTk5RTB4YW1WdzcwTFBqdGdSamxxK25k?=
 =?utf-8?B?R2hLNVg5YmxZWElVT3NDMTRYby8zbHE0R1lReHAzMkREM0h5UnJ5WkRnd3Nt?=
 =?utf-8?B?UVo4SldTb2lHVHlGWnpaYkFzSXJ1a1lCcFJzQllSUTU5Z3VLTDhKUHBMNzVO?=
 =?utf-8?B?U00rQWk5QzRVN2dXa0JwZ3JaN1RzcnVOTjE1aVpqdWNYNEZJanh3ZFR6N3hP?=
 =?utf-8?B?MUhTSDNSQ0JvZFYzRGlVN1JSSFpyQk9FcVFYQVQ1UlhGaEFESnZaUkgvR2xX?=
 =?utf-8?B?cnR1c01Iak53clhIanBKZGtsUUp6MWRqUkJOREF0dE1veStic3N5M1lvQVl0?=
 =?utf-8?B?a0JPZGNqallhR2VWRTBaRTVzUTF1bTR6eEdKMGVWaTdTbkg0S1dVMzNtRFd1?=
 =?utf-8?B?dUVla3ZFL2tzR2k4Q2FVWUdWTjRuUCt1VkdTdW1DRC9Xb2F5bVlGbVZkRHZV?=
 =?utf-8?B?QWd4TmJIbFdTdm5FQ2I1ODJWcWJReVk2UVNURjJ2WHFGeEVSNDkrVXBxUERv?=
 =?utf-8?B?QVZmWDJoWUp0dWhRMDBXVjViWGlGWmV4TkEyaVlIU3lxdmJaYUE0YkpvRFBx?=
 =?utf-8?B?NnpvWkIyYW9sOUlqRENYU0RLdUx1cFJJR2xpSWlxQVpTUGZFZ2ZDS1RENUIv?=
 =?utf-8?B?Q2x4c1lHTnlmTEhYRW84TjNici9yZzE1UG5venRoRkYyN0ZVWmk5R2tDdXll?=
 =?utf-8?B?eFUzS3NESVJUVkxwT05zR0NJaWVvQi9VeHdOeGx2Z1ZSc0hnN045OTA5MkhV?=
 =?utf-8?B?ZXdnWnNHN29uaEdXc3JIVmQva2E2NDQ1ZldFOUxJMWNTZFQxZkRqZmpIRXpW?=
 =?utf-8?B?aFFZMm03ZCtHVDc5UHNNRzIzYW1UaVA2Z01tL25GNHNTMy95SUFBS05DTW9j?=
 =?utf-8?B?N3NVTkRMNlRFb1M1T2MrcWI3cVRLNXlIM2g5cTlOajYwcE0zdFMyQjV0OTZX?=
 =?utf-8?B?d1BUZzFjWE1ZNFRNemV6dnp5VFhTVzhabzNKNVB3Mk00REJ4SWttWHc3enox?=
 =?utf-8?B?Wi96MUFIODlTQ1ZzU05ScGFGNFIvakNpZi9oNHJwMTRDM2RBUzhjZG1NaTZp?=
 =?utf-8?B?czE5bUp0dGc1Um9qcDVTYzIxL2xpb2ZXZmhwTWx0NnBBVlM2SU4zZkUrenpa?=
 =?utf-8?B?cW00ZUJSM0dxcHBORTJJcHhuVTBLSFNxMnhsZk53SzBIZWtZcjhDQVI5a0R6?=
 =?utf-8?B?K2dHUWszSDZ2Q2FFajlma0hKdVlDSDg3WEtHNWhWNFJnMWFCbE45Y1ZsejlO?=
 =?utf-8?B?cllNRmtrK0JNSmoyekd2alFCZXpOOEpQSGZJaTY4aW1VQVdYMWs5ZHJHR2NB?=
 =?utf-8?B?TXE2em5HdmY4WXFKZXgwWm5mWXV5eElPYzFJWWpXM2QrSlgrWmJ0T0VnV2Ju?=
 =?utf-8?B?eDk3TnNwdWNodXF5ZU5RWDJSMkRxYnlzWEhJcnppZGZLMUpkRXNTQnZEd21w?=
 =?utf-8?Q?fkq8iK0OqTI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRvU2tTeGpJUXlIS0poYUVJcGVQWnlZYWZGVHUvZUNYS0MwVjQzUGE5d0M0?=
 =?utf-8?B?eU0rNXRBTUNZdHc2YU1HNEFzMGE1NDkxV1VMQXVGSXhMVUc3a3ZQQmhscGNr?=
 =?utf-8?B?VDFsZi9QSENwMm1uU3h3cHp1MUpjZG9LR0V6QkluMlRYaElRclkwK3g4SVBB?=
 =?utf-8?B?OHYyTWU4YXUvY2NlcGhMYVJsdmdQVGZqWEVJYnlUVUNlOXBpRExzbkQrb0dW?=
 =?utf-8?B?QkVsUmduNENxTE5ibDJ4NWRFRnZtTFZVRHJuOHVOQ0RIbHExWUNjMFNWcWsw?=
 =?utf-8?B?UzRHTUFuT0ZJWHlXb0VpTnpYSTlqK29PZ2xYU01GdDhJR0d2bFRHTVFWOS92?=
 =?utf-8?B?UXNPSDZCNHc5RElKa21FSk9HeDFsMmhVZmhDL24xL2lOUzUremVnbERINGZZ?=
 =?utf-8?B?Y2xaMTBSYnZleXA5NEhxbjYvWi9LZDdsVjQ4UjBwbXVCY2lOSi9uT2Q5NU0z?=
 =?utf-8?B?c2tnTlhEOGVweGRiZnp4NlFOdzlJNklPSFVsVVV2YXU2QUJ3RUdWakpocHlH?=
 =?utf-8?B?eUIrZTdIbnlDNko0c3BRYjZzMksvSWZaVFRrSVNuaXdOYjNQUEY2WklobEJM?=
 =?utf-8?B?SmNoN3pHa2MxQWRUT3JiWGMrUlJuSmNFeVNBK3NMWXI0WHV1UnRackJxMEFv?=
 =?utf-8?B?TUVnTXhvZmMvZXNwMXpEd2NFbFYyamJFOXgxeUxidHV6aXNYKzlVeHJuMHEy?=
 =?utf-8?B?dmcvUGZBWlMyUmZYcnZ3aDFkNVFoVzkwK2VlT0hMV05iUjd6VzBnMzNRUkVX?=
 =?utf-8?B?U2VWYS9XRHBLakdxbGprNUZia0hYRlNnOEVYMnI2ejBpckR0YjI3ZDRGOEIz?=
 =?utf-8?B?d3VTT3Y2TExXbEZMNTZpUzVNbTJUMnpkd2syTFF2SnJYM2ZrUWZoK1UzWXNE?=
 =?utf-8?B?dWtvZE5YcmFWRmNzbTVTNE5YUnpoNE5yUk5GMTlsVnN3SXdmL1g0dVNtN2kx?=
 =?utf-8?B?TEN6WURzOS9pQVR1OU5NUXR3bUp4dnFScjFBS3hXaXNZOTQzRVNXdTNpRXJ0?=
 =?utf-8?B?U056KzFib1pjRE00NmNZY011Sy9ucXo2OThjZEUxeEt1bGJVaERXREpHek4z?=
 =?utf-8?B?TTVYcXA1UXFlc2Nva21CcjZpMUUreW9kQ3cyTi9PNGMxMVE4QnhhYURFMmxs?=
 =?utf-8?B?S29nUFFqNnZmbTRpRXdDcXI2Mml2cDMxOHQrNUc1M3RlaHRZRVFYbUdBZWRl?=
 =?utf-8?B?MTVENU9Yd1FvczJCajNRT1dyQlFqQ1VtcFJNUW9ac05TNkNlT2FOdUQvTnZJ?=
 =?utf-8?B?cFRQVWM0enpXTlVCeUhxemNXN3NTbTlRbmpxOE5NOGI3MzdDNG9pUXFuOGg2?=
 =?utf-8?B?WHBvd00xUmJMc29HVnlBOCtTL1ZoSnFuSzhDb3YvV3FSUXc2SGdsQXVONE1s?=
 =?utf-8?B?ZVh0ZjhsYk53QWtNRVBabW8zVlh6K2taU3JJOFBkcW5BWjY3YWtSbXdWdVFr?=
 =?utf-8?B?ZFZWNDdJUjdJUVhjc3U1RTV3Q095SGJ0T3dDbjFjZmt2K3BaVzI0M3B0czVt?=
 =?utf-8?B?eTQyMjFPMlloeUJOUVN4WHVWRy9OM0tkN3BRdnBMQzRGeENxVnF3TU56eHUw?=
 =?utf-8?B?QWxIaDMzblFLL1VpZnFoeUJ2SHhLRXpxZnlZdUY5S0RvU09paXU3Mm1POTlT?=
 =?utf-8?B?N1BCUkVHMVcvSDFaMGVoc2tFaUsvL2VyTXNzcWxicDhqR2Z2Y1NFRllWSGFu?=
 =?utf-8?B?Qkt1azdaTW0yQjc4Q1FGSGE2MGgzVjN6V3RYRkZOVVFKTUpQZy9YbytyaXJB?=
 =?utf-8?B?c29ITnRHSjk4R1dKTk1DTjIrSnNZQzlZbGE1eFNObDk5UWU3eEMxenRNdS9L?=
 =?utf-8?B?eHloRnB4Sk1LZlZka3ZLVVZ4cGJVbW1CczhrYW5Bamp3b3RNS0lVTUZyd2xC?=
 =?utf-8?B?TnVhRjdyNU5SWUpwd2oxbEtBWDk4VWJEV2ZyckxqalZHT3pNKzUxSWZxeDVy?=
 =?utf-8?B?cUpmZzhnSFQrTEMzL003S1kvU1hQaEtJRmV6Y2RTSjIrWlVkSDhWNDdLUm15?=
 =?utf-8?B?VmRIaU1lbHo0dHVLQkNyOXB3QmhyNXFvT0hXUFl5aXpFU2JDMHdLYUM5d080?=
 =?utf-8?B?cXdDa25FcUF3akJSTkNXQ0FDTG04WWcrMnlVQjQzbDJLc1hGNVkveDF1YjJU?=
 =?utf-8?Q?g2DDOQE8AU1d5/TP8ZQSdXr2h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8648d2e0-1dde-41e3-1474-08dd34873e40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 10:36:02.9120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1STha9la8R2pNa1wz1sVqKbaexHgG3rL57iKsrRyISFxXeHtcvkuvocJlxqmjtji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

Am 14.01.25 um 10:54 schrieb Jiang Liu:
> Introduce helper amdgpu_bo_get_pinned_gpu_addr(), which will be
> used to update GPU address of pinned kernel BO during resume.

Clear NAK to the whole approach. Pinned means that the address *never* 
changes.

Hacks like those here are a complete no-go since some firmware uses the 
location of temporary buffers inside their firmware state.

So you always need to resume to the exact same location as it was before 
suspend.

I'm going to reply on the cover letter as well.

Regards,
Christian.

>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 9 +++++++++
>   3 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4f057996ef35..bce939a63a99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1555,6 +1555,15 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   	return amdgpu_gmc_sign_extend(offset);
>   }
>   
> +/**
> + * amdgpu_bo_get_kernel_gpu_addr - get GPU address of pinned kernel BO
> + */
> +void amdgpu_bo_get_pinned_gpu_addr(struct amdgpu_bo *bo, u64 *gpu_addr)
> +{
> +	if (bo && bo->tbo.pin_count && gpu_addr)
> +		*gpu_addr = amdgpu_bo_gpu_offset(bo);
> +}
> +
>   /**
>    * amdgpu_bo_get_preferred_domain - get preferred domain
>    * @adev: amdgpu device object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index ab3fe7b42da7..9022592291a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -305,6 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>   int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
> +void amdgpu_bo_get_pinned_gpu_addr(struct amdgpu_bo *bo, u64 *gpu_addr);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats,
>   			  unsigned int size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index dde15c6a96e1..40605749b5d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -881,6 +881,15 @@ static int umsch_mm_suspend(struct amdgpu_ip_block *ip_block)
>   
>   static int umsch_mm_resume(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	adev->umsch_mm.sch_ctx_gpu_addr = adev->wb.gpu_addr +
> +					  (adev->umsch_mm.wb_index * 4);
> +	amdgpu_bo_get_pinned_gpu_addr(adev->umsch_mm.cmd_buf_obj,
> +				      &adev->umsch_mm.cmd_buf_gpu_addr);
> +	amdgpu_bo_get_pinned_gpu_addr(adev->umsch_mm.dbglog_bo,
> +				      &adev->umsch_mm.log_gpu_addr);
> +
>   	return umsch_mm_hw_init(ip_block);
>   }
>   

