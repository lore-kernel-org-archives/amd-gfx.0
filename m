Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF4C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 21:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D1E10E121;
	Tue, 18 Feb 2025 21:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FmGGs3E0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C79110E121
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 21:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr2kZ761qqzQQwPOwU4mJXemR0bi4TE/2s1jBxG7TrJEX1JqGZ1ZhAf7YE3b/J9iiCiqla/vBXbVT93MJg5vtpQzoBEp/PISDv5mx4WdAzsLWY/P81vcc0HPFzHYV6Kxm8TF5Q2o4YoYG77wmbWqY9FznqAxiD92jjjdHWSSJtW8HNwhMg9onN/cViGIMrN38Cr0gmB60y1KNfb2MmuZnRQfXp3/sZdX+ue0tpjx1IOpsj25zl2y9lCsiGUtYRzwHzVs20VyE+atUHTBS5hWDZC67QBhnzn+JSknIW8chnpNQnC0+oJ0EZOjAYAKLZsAVCziLj/avnYp9NAymqMLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8XtAwbZWFQB4+Nx36I+zN5v5dtPLgBQucu2EzitXjg=;
 b=vk1ttPX0olhWGpsRXwl/CZ9RNFW99xw9sPhLie5LUpPfC7p/49Oz0bBe6qbE7TNtw3vjN+NRynYs1Lnm57vfOHn1XT4o7MKh2GbsxVw9HDSl2fmll3sRZiMDGk7zJ6qV9QISF7ID9RmngRxRu0b5n49slgTFVrX1rGUAwXR60FMsYsyS1T1N3vDFx1VpcRn8DtOjw+FDrcKzcDFMWMU1VxgJ7G3E/+YS3WgRzqUNwget3/W8LPv4ZD5hKcVU8P9opw//UILwf/9So6nRHhAtdW3zgwd5ZhOY08/seF1iA4R96zZnmzXWxRthPdC1Khi9iC6ci3MZcdFXR/QRrZI6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8XtAwbZWFQB4+Nx36I+zN5v5dtPLgBQucu2EzitXjg=;
 b=FmGGs3E0fAsO7iZUT3zMLx5BrnxSwT+fsCHWhDQ6UmR4owX0L6Y0AdPIj7XtsDrl5vkCKGb1HkARjJJgUsdfItJ3YhM90RYLFtrzLXrxCxjVDHVqpGk7aBaGt1kmwHDuzyo4NvUGYepEpo+kZY45bPQ24pTwt31Qu8M7Jsf2YDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 21:06:21 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 21:06:21 +0000
Message-ID: <a57d883b-4e80-93fa-4075-afd1cd236517@amd.com>
Date: Tue, 18 Feb 2025 16:06:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd
Content-Language: en-US
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, jay.cornwall@amd.com
References: <20250218172440.127224-1-David.YatSin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250218172440.127224-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 501b9dfb-6afb-4251-9c74-08dd50601883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blhEeHpEbXliSnhqbjVsVVNVcEhzeTh0RU5scGJRb2d2RTVRaCtqSUs3N0la?=
 =?utf-8?B?WHVuYVd1YUFCYW95QnlqNFFYYVlRR3NWYWFHelFxQ0pyN3hrYm5lL3hmZytH?=
 =?utf-8?B?Sll5MklqMmhTRlBBYUhEb3psOXdqU3FMcmRGTlpHdG1iRmc3ZjBUb0VRczZH?=
 =?utf-8?B?WUdiM2ZTUklzSEQ4bUl3NzB2OGxTN1BCYi9tZmJ6SnN6U21LTmE2T21oU0ky?=
 =?utf-8?B?Z0V0MG1CK1o0YUczZjB1NThOaTVEaGM3RnYxQ1pKWW9IQjBqWGdOVElxM2JR?=
 =?utf-8?B?S0x4bzN6VEpWTDQvZXhmM0I3ZEhHMXQ3MzJOY1RDMEhmRVk3UEpXU3M4dVEx?=
 =?utf-8?B?SjJNWnYxWjlBZk56ZTl3SUlXRTYxVzRUTlBraVZ0UEJDcEllVHAybHN6Q0xX?=
 =?utf-8?B?S2d2QmYwNzZUcU54ckl4d3RqNWpXbzRRSjAzby93QnhjeHArMGhidUNFMk12?=
 =?utf-8?B?T3poeGJTQk42cWZoR3RxZlg3K0xZUCtXNnVPcUJDRjE0emhQeDUzelpvSTVZ?=
 =?utf-8?B?MjhlQktMZm9qYllDZmVCU1Q4ZCtpQzhyZXU5MHNRVTMrSTZ1UWt0WWEybVZu?=
 =?utf-8?B?aWdEVjhBK0k1ekZFMGN4SnBtdm5oNEFPbjhxMytXWlcrMS9haW82WnhkdUE4?=
 =?utf-8?B?VzcrRkhzTHI1Nk5LZ1hQa1ZDZUh5Mm9ZdEJCYmJwd2lEZmZtbzBDc2RhaTFZ?=
 =?utf-8?B?MWFtR3VzRXhEd2tWbjZiNjk5OFZtVkJRSFhockdhRmd2eG9sWVRqVHZ1OEQ1?=
 =?utf-8?B?dVdGYWZXYWZ0Rloyc1c1Tm5TbzdtSmRnZm9DTGpEejNZUTJSMlYwVzNnNGhG?=
 =?utf-8?B?ODNERFMzUlpjelNwRVlLOVFrbDdoL3E3OUw0QVRWckJFY2M3OWtndGg3VUl5?=
 =?utf-8?B?aDBrNGZBSXo3MDQ3Y3MvR3pwczh6L3VNQldGdEtjSjh3c21BR3JjdGVvK3pY?=
 =?utf-8?B?TnA3UkthdjZQMEQxVnpBNCtBUktQUVl3OVpVbzFlT2g2ZGFNemh1SWd0bm9D?=
 =?utf-8?B?SERXeFJJcHltUllhZk14OHVHUUlGMGs2N3dxNUJlampIWWRZMm8valZaT0tq?=
 =?utf-8?B?K3ZrZHhEWEJSdkR6SzIrVlJuQ3ZJTUNya1NYeEJIeUhHQ3V4UC8zejZib2dK?=
 =?utf-8?B?dTBaT2hDRlFJNVNvaXlIWHJKUHV4SlRhUU5LL2czc2MyajVzU01UUnRYNjll?=
 =?utf-8?B?U040Sk5BOGUyUXVEWlVyYThrQ1pLUUI5bWk4QTYxNmhwcWlkNG9mNWI2ODBt?=
 =?utf-8?B?RzBiRWxxUVcwM1RnaFB6Sm9YOE1zZG1lN3l6KzVPRlRRcFdzRVhKSG82M3dn?=
 =?utf-8?B?UVJZSk1HdXBHS2k0UW56T21XWG0xWUVTR0VOUE5uUGtkK0tBUnU4U3lQM1pH?=
 =?utf-8?B?azRKMVpKRHNFN1hTTVczdkVReHZ6RzVrVG43UkF4U1N1QSs2a00wTVRmQW1D?=
 =?utf-8?B?eXhxbGxNOUlBUmtZQ25kaTFWYWswRTBNclBRRHVxRU1xYzlOL2w1VjV1VlYw?=
 =?utf-8?B?OGZHYXh1SWlrL2c0SDJIbldqMXVKTXFjTHhNNUhhQTNPbEp5azZtUnNXdTUx?=
 =?utf-8?B?M20xNnlZOEhXQ25BTytXTjJtUW93eDRqY0VkeG90TXVOaTluK3FTNWRKSG5Q?=
 =?utf-8?B?Q0hxTW1WZTVVd1JqRzJiL3VOMjA5N1prVkp2cysybnRGRlRhUUtveWl6MFBO?=
 =?utf-8?B?R2tESVo4QW5hN2xaRXUwaWJDaGpXLzFSVldFZVNEUjg1WTJaWFQzU3ZHSU5S?=
 =?utf-8?B?QVV5dG80Z3NUeE1sRVVVazR4NXJIYXU5Y2EwZGlLd09UTmNWNHJWZngyRmwr?=
 =?utf-8?B?dEpLT0tLT3piWW1MN2J3T2JsUHFkeTQ5MVVVZlJ5NWRVZCtlQkY5ZHNhMWFp?=
 =?utf-8?Q?91WPZLMF5EbUf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzlrb0ZiZGh5azFlYThXbEQvSG05MGdNaU15eWptSm5EVHRQSTRKQ1lNK3VC?=
 =?utf-8?B?QkRzalZEM1V0Wk9MMW9tUTV0MkIyOVpCMURZNTkxQnVEU2V6YkpGSVJJTVVH?=
 =?utf-8?B?ZzNDejF1eXhRVm5WV3VOLzhMMmtJTTMyYy8zN3QyYnNreEFMYW9IMGVia0Rp?=
 =?utf-8?B?dnlWQWlxbEVuRStyc09nSFZLYk95dzBTMTlRdVU4OG9IZ2w4UDZMeTNBQnNk?=
 =?utf-8?B?QXRBaDFZUDVkOEI4emdZUjA0YlNtV0lXTGNrcDdDVG92QURITkd4L2RPRVhh?=
 =?utf-8?B?aDR1RHJmSXhqcjN3dDg0UC83SFZzL1d2Vm9RRHpuOVowbUs3QjR1SUFUWDZX?=
 =?utf-8?B?MGkyd0s5QWUrVjB3RDNVSHhUOEJvMmlSbFU3ZENITDJNZWNmODlyaTM2Tkdo?=
 =?utf-8?B?REZTWk9OVTQ2RDREQVpLWGJyRGlyZkN3Sk5lcGkrS3BNOVVUZnNEeHJlZWZB?=
 =?utf-8?B?VGIxRFBQeEhrc1E5eDliMXpINmxpVVJqY3RVdFNUWDdSeExoaVd3TDZkMTVh?=
 =?utf-8?B?LzdmdisvZ0p3QmlGZEh0ME4yOVlSekRZRDZzcWd5RTRxZGdaS0RqWHFZRzRQ?=
 =?utf-8?B?QS9HRkNBU0RVaVZHU3ZnM1VzWGdBWnpJOTV2SmlkblYxMitUSzk2QnNuTExr?=
 =?utf-8?B?WjJ0WEJON0pIUmJDZW9WYjh3ZEtOZEdyR0N2MloxdGtyN0ZDQzVYaExIVG1h?=
 =?utf-8?B?Y3NURnFxZ3Q1NG9IbWhkVkdnWlBsSnFON245QXM4cHdVTDVma2owdktPVWdH?=
 =?utf-8?B?b2wwcG9TK0ZwV3ZwVndoWmF0Z0ZvVEs2ZUc1Yng2ZVlVSmZ4Z3ZPNjhMY3d0?=
 =?utf-8?B?dy9YcU1GU1RqU2dqdEtvSmhrSmpzVGpjbTJvQkxIdnFjVnIwcmdrdTZRVW5Z?=
 =?utf-8?B?MFdZOGVraFl3ejdSOUl2anJ4UDFrc01aRUlPNmF5clB6TjdJckJzSy92ZnFD?=
 =?utf-8?B?TXk0dTVRaXc5TzNlSWN6Y2RRbEUxOXZ1SjBZWVBBZlFkL2U4QTRvU2hZZFFB?=
 =?utf-8?B?ZnRaNzgwTjB3a1VoeG1zSVJDQ0JzUTBJdUJrQ0NiMFZrNXhHVHhvOGtoWEc5?=
 =?utf-8?B?OWJXT3JxQjM2MWtHNEQ4dVFsSU9VZ1FZc3ZTMDRXWW5LTFVqcjA3Y0Nkc1ZK?=
 =?utf-8?B?dmN4aDNNUzNCOFBsdWJ0WGtreFJwRXd0bm14UlJVSUU0SkgvWDAxbjFONXdt?=
 =?utf-8?B?M0pETzJHTFlwbnZJUjVCYkJnNHV0azdZc3hoTUJQanozRlo2Ym5CbmprbmRo?=
 =?utf-8?B?MlViVGZQZlVZR0I1ejBvQnd5RmVzUEhTM2ZLTGwzNXFFWmFNejc5MENWVTBw?=
 =?utf-8?B?aG9PelY4VkdxdnN4b2dOaHJzeVduSngrOURnSm9OdjVFcXpMWVFtYW5ZTEdT?=
 =?utf-8?B?U3J5ZjVxbkFabWpZTVdTR05yL01lRmozbDlQQ2V5N2FLbHJaSTFYQmhnblJQ?=
 =?utf-8?B?aUhZSnJ2bVFpd3ZsQjlZeStXUGlRbzJRUk5nVC9UeVFZeFJSLzh2RldBUUtT?=
 =?utf-8?B?a3hMRm9LblZQRy9iMGpYQTE0cXB3SE5lZ1Z6MjdsWEwzL1prZWt1bU4rTERT?=
 =?utf-8?B?ZXlWVUVXUGV3cTVacVVGS05ZeGFKYzg5Rk1BRGRadU9jY3JJcFB0TEg1dlBr?=
 =?utf-8?B?Q0Z2L0JueGt3dGJWa253WFdlVi9zMEVXK1V2M01GZmpuaW8wcnp2c1dndXVW?=
 =?utf-8?B?d2VOZjFhaHRpTS8xT28xY2xON25SbWorNDRLaS9wTEUwM2tsSmNkeTd4b1VG?=
 =?utf-8?B?eU9IdTZYbHFsTFlZTGlLb29nUnBPN3d1K2NoNlVCRTQ4aURxNnllaHBxZlZT?=
 =?utf-8?B?NlQwNW9zQUFHOGNxQjBpbGtNVFZTQ3d2b1NwRnp4MXIxdjN6dm1DRW5JZG5V?=
 =?utf-8?B?OHc4Sm91UVNkMzg1VW5EdXh6eHhSTWNQb3Z0MWpoeWx3aS8xL3B1UGMrTUIw?=
 =?utf-8?B?dUs4QnpCRnA4T25uLzVXb0F2a2RTY25WWStaQUtaQUN1bkVmSUFyQ05DTXJS?=
 =?utf-8?B?Z1doa25teDRkUnk4TFB1dWthWnFDdlBXWEJqbVczbG0yYjZjQjJCODcxK3Bn?=
 =?utf-8?B?amtsMk9lUklrZ0kxVHdjTVNxSnd6eFB1b1RLRjM1eUg4K1pvY2tBdnk2cEdH?=
 =?utf-8?Q?C5D3L7xnyVjPgbe1wdLWMj4U5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501b9dfb-6afb-4251-9c74-08dd50601883
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:06:21.6499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ql0tgw1TcSG7ikjUSmF6IWt2eP6N19R3CULC2mnlPZ7g9N6h3ZkjmjfToBYp0Xs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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


On 2025-02-18 12:24, David Yat Sin wrote:
> When userspace applications call AMDKFD_IOC_UPDATE_QUEUE. Preserve
> bitfields that do not need to be modified as they contain flags to track
> queue states that are used by CP FW.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c  | 4 +++-
>   4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 2eff37aaf827..9aec222251f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -167,7 +167,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
> +			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
> +
>   	m->cp_hqd_pq_control |=
>   			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
>   	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 68dbc0399c87..c000dd50a4b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -221,7 +221,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
> +			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
> +
The change makes sense, but seems typo

(5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) & ~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK is always 0,

maybe you want

(5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) & CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK

or

m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT);

Regards,
Philip

>   	m->cp_hqd_pq_control |=
>   			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
>   	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 2b72d5b4949b..337dd3fe130d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -184,7 +184,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
> +			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
> +
>   	m->cp_hqd_pq_control |=
>   			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
>   	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index ff417d5361c4..7d01ad6a686d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -245,7 +245,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
> +			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
> +
>   	m->cp_hqd_pq_control |= order_base_2(q->queue_size / 4) - 1;
>   	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
>   
