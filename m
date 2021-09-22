Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2080C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836AA61168
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 16:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 836AA61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCE26EC31;
	Wed, 22 Sep 2021 16:16:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C292289DA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 16:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nigpNMmS8eAuV5M1SY01s8FINL2njyyuq9yRUTCi7B/FQAAq/7xEfFnNkM7TpevVseoYkKILemJ5GNX5iv7hD0DFy0Iznmm7/LHL6WX8PrdZ0A0JjJg+tlpTPJn5wWuL+JJuyuOi3uimllbsscak09zOkEZPN8KmhkLxtbdyAaqCJqmG9wsy5Z/qctQKk5N7PpK2HmV4Ui9KpWJQABVIvRsZO/1cvmVFbDp7Gwhxru+dffspOHXEun8egxJhIp7tPSvKWXqiVCIovZDVkfdOtf00fMOe1aMClPJM030/eEeU0VH1DA2r+bWoPiFCH8Bn2VtjLHmHi7Usw3jsChMKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WmDqeLGOmglVBe19/CRFUwd0sPLerCQeOR1THXew28s=;
 b=ORP4XA4CqEARVMWPTHOW7c6RiJtMr5Yq+PWRUiaoOqvEoKs8TbIgSpwnbY3QbL4eZB3LQTtr4Yvcwjt5rO3Ptn25eLlmqHhm8y2gX7KP5OoiVJlagH51IsxdYmaUTysV8qAfTtexHXqfyCaRE67UD4jOLEJ0QKjnPD198fOtpgu6XECSydarqI3NzlEdG9v71B22hhsIty55/nXjfInGRAzp34KDq5N0g4SlLwyZahRnIWqO4LiNFZVQB4sS8UgtFTQhjN8gcbagF8PSXSosMhFBAw+h6ykrKkHkytsdTPonUPonqFQlSTIgwjba0iuZJ1jtBmVT8/DcqqBa7/voOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmDqeLGOmglVBe19/CRFUwd0sPLerCQeOR1THXew28s=;
 b=RTpV1nVuQD9escQiFFJLPZ9X+u+E2V+utoWHJI9n7/eS+9l+zeZEy6Wgat+mm8ril3pOICKIqoSV1ZXakcwNhf1y1IN040iZhOPUKFY+VABnFr07PtqONC46rp86RFsashcQWs1gyzPd6DPjxwlkozQPlDu4lTq1tPX/449gd2o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 16:16:29 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 16:16:27 +0000
Subject: Re: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device IDs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-12-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <941079cf-5121-76ee-6d8b-ac43d5d1dce6@amd.com>
Date: Wed, 22 Sep 2021 12:16:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921180725.1985552-12-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.122.119.142) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 16:16:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1848ebd8-cb72-4f9e-4f3c-08d97de45484
X-MS-TrafficTypeDiagnostic: BN9PR12MB5067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5067E0BD3623D2F11F6B00DE92A29@BN9PR12MB5067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5+vGqTfQHGnU4g2l99qrg+2HGsoHJOoeI70nziOtIgUWetNJNDxCAxZk5SpdOVHHyGwJkR3M71DxBzzRlw1QucFDMmIV7z5Sp7LfHqLKds1oG9k18XjVbtpynqa+0b6tE7tcD0OX6ieo0CZvuTLEw10iJU6Hbc5FIwtoCljQuks8ZTD2fdhMYyZ5xfL0JzUEk81pOX5sMgBj8u5Gb2pcuzjS6oHwe5eJiJn6r+j76FpEi7nf6xRTFecTxoi7EkaWfRSjS1LrJWBWyIGCSdF/UkvZYu0iY1vJI8Ur0zYFGLAkqoGEVuAff1fztQ2DeclYRY38w/ZCCRZDrVU6v2CPZ3RJa8LkYfCG2z2IPSvIz8gs7ru8mFBxMf5cZ6F3k3JMbanJVjkTeKHn+uwjE3mYoe9GqmYpbG6ByIRGP2meI7k1fu1wRHcwOJxwYH5GMNuibWi8hr59JCTaldkwkd+UM+QrupseHRkoNa+2A66NY81zBLQZyq8PHhTMpIQ5/CvWopZq+axy/sx86jrDS8VH2HX4BZC9mt8TgVDHPj+7Uda4ADNe7AGQzfUXuK9DSGOHHUw2WMZzsLbNnVhfE37FEbC2NY0n7k7FMMlZsEgj8HaZJNibvLWPbI0bQK4YCBPRSszwgwAQXe/ZJN0S3izXbMqcctkHG+WJ83kwtRV1EQQfviJRJ338a3Y+o4LLlVHBWA6taXejVYtWdZNmLvEyL5m6Xn0zY93aUkPN4t4Z9QL/ZL526V2CaA2fcKZB8kE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(956004)(86362001)(16576012)(66946007)(44832011)(2906002)(6486002)(83380400001)(31696002)(26005)(508600001)(316002)(66556008)(2616005)(5660300002)(66476007)(31686004)(8676002)(8936002)(36756003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdSYTlBUUF5eXJEelVRYytkUzJaWm9jVjNIc2M5anpoOUFmVnFCSmNyY3Ja?=
 =?utf-8?B?YW1NbHFhYTRIaTRBTmVYdUhSK3ZFaVh0YW1kZUFEMWk0bXg4U1FzZ0ppTEdH?=
 =?utf-8?B?S3YzdmplR3J1dkkrclpOcjg4a0lTL2JZazhTSTRnR3dCaXB5Kzh0a3VIbE0v?=
 =?utf-8?B?NmNGcjBzRkgzWmdBcFA0dlZSN282TkJlRndLcEFDZVBNcXNrYTBlbmF0V1Fz?=
 =?utf-8?B?YWMwaUFMbjhMRmJpSmRKbnVkMTB4NnM4WGZjTUk4YlVvWEpKT0VyOXBBTExV?=
 =?utf-8?B?ejNoSGRZcW5zSmxydmFXRTZwK0tpdi9zWnpUNGZCckZGRUdhNTl6bzlGZndW?=
 =?utf-8?B?b0hsWVBkdlZHRzRTOUQ3cGJSRmxJQ3ZpZ1dGTW1aeTlMS3ZFU2drdWlZaDJE?=
 =?utf-8?B?Tmg3K0d5b1RDQlEvOW5HRXNFNnlKRXM1TDdyalM4ckZYak1PdjU4dzlHVGhm?=
 =?utf-8?B?VEFDbkRkOTMwZzRvWCs0NllMVVFYUjRSQ2VPN0lBRFdUOHlWZURPektKVkhX?=
 =?utf-8?B?NUNOWkVZa3NwdDBpTXc4aGUzRWVqVkRkY0FEcXJHVk1pOE1XRGhET0FLbTVx?=
 =?utf-8?B?L04xaS9aZStWbEgyK01lQldjWEVwU0FDemR5NkE4UWtZTlNibnZtMWl6UkxL?=
 =?utf-8?B?YnE0djRwQUdWOEVtenpWelJWRENOZUV0M2JGdGlZYnU3ZFljRldrb0w2cWZI?=
 =?utf-8?B?cCtVd0E3anEwRWtJQllPbjc4c1Y4RGlyWGwyelpJZFBKRzJJR2hQSHJjR1RS?=
 =?utf-8?B?QTZFVXFLMDU3dTArekpSU1Bqa2Z4a0NYZUpSUGhSaWNySHMxZlduUHNNRmhh?=
 =?utf-8?B?NUpDMnJWMDNEUTB5ZHp4OGpMNllKQVFlUE53MEU0Y3R5YzBTcUV2Q3VXZFRT?=
 =?utf-8?B?VWFIY1VnL1BVNlZ4Y21jNTA0cGk3MDhlb2grekJWSFhpdFN4TnZRRlBFZURw?=
 =?utf-8?B?OXJ1WWhIUUJYQWo5L0tSZjE1UmdQL1ZmQ3JHWW8zd1BhQ1FPQUk1N2haUFpj?=
 =?utf-8?B?UkpOS2xHZ3liYSsrYnVnYnA0L0NPbThjWjU3ZlpqZ0E1Rm0zbndsYktTZlhN?=
 =?utf-8?B?TDVQQVE5aFJsZDFmNFZvR3M2ZHgwekppSllhdFd5b1R1UFVZTFZSZWE3UnZq?=
 =?utf-8?B?bmE0d1BEdGY0clltY3dxZHBmMmFGRWVMSkpBeUlTaXA3aXhqNDAxa2Z4czcy?=
 =?utf-8?B?aDZmZUcvSmErT1JXUjVBY0N0Y1JkSDZhUnlOZEFLT3lFaEM4ZFpQeVorVTJp?=
 =?utf-8?B?TWlyalhrUjF6SlRkeVZoYUk1UVkzeXI0azdqbEVwbVJJRU9kckRzL2VHbjdN?=
 =?utf-8?B?K1lDdHJVb0FKYzRiNytzcnN5M3VNM3JJQTEzZmJKbkdQSzh1Q2RSYWYvMVN3?=
 =?utf-8?B?emVObmdla2lXbUkzS3JiZkZ2UmRnNlI5KzdnVHl3MkpUWjVaUVFXN1lJWnBo?=
 =?utf-8?B?b1lQT0hubmZyNWZxZVFVNzNhb3BGenEvcER5bXdSczlhcmdQOGJPQjBJQm0r?=
 =?utf-8?B?eGRmSkJkbEVpUHRlb3hKZmlBSUZLbUdyOTFFMHFYalBjSldybk40OVoyN2dj?=
 =?utf-8?B?aFdaTFNRdzVaTi92R2lYM1U2eEUvVjdlSWtjS0QzeEUvdWZnVk1VZ0JoWEVF?=
 =?utf-8?B?S05LNzUvUHRWUlNQY0h6TWMxamZQa2NJT3Z1UG9oeEszRG5GTDhHV2ZmNGFr?=
 =?utf-8?B?dTBlSXRLM1RWczkvSWRxR0xxVnMxZUJXb2FMNWNobFVLNzlmeTYwQmdBUWRJ?=
 =?utf-8?Q?PU69wDRIIXyNEjzVvk+PQCW8coFx01xycutRHKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1848ebd8-cb72-4f9e-4f3c-08d97de45484
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 16:16:27.4922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaiUxu1ytQ0+8r80GscadlhYPESc+KoIeLSRr7EZHswyqjBVLxPWSJpFXx+JKqivESMIjxf3d/e3fU+OHSp4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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


Am 2021-09-21 um 2:06 p.m. schrieb Alex Deucher:
> Once we claim all 0x1002 PCI display class devices, we will
> need to filter out devices owned by radeon.
Could this list be built from radeon_PCI_IDS and r128_PCI_IDs in
drm/drm_pciids.h to avoid duplication? It also looks like your list is
missing the r128 IDs at the moment.

Regards,
  Felix


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 561 +++++++++++++++++++++++-
>  1 file changed, 560 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b6ce53fa9b03..3ab7099a1b16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -891,6 +891,559 @@ MODULE_PARM_DESC(smu_pptable_id,
>  	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
>  module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>  
> +static const u16 radeon_pciidlist[] = {
> +	0x3150,
> +	0x3151,
> +	0x3152,
> +	0x3154,
> +	0x3155,
> +	0x3E50,
> +	0x3E54,
> +	0x4136,
> +	0x4137,
> +	0x4144,
> +	0x4145,
> +	0x4146,
> +	0x4147,
> +	0x4148,
> +	0x4149,
> +	0x414A,
> +	0x414B,
> +	0x4150,
> +	0x4151,
> +	0x4152,
> +	0x4153,
> +	0x4154,
> +	0x4155,
> +	0x4156,
> +	0x4237,
> +	0x4242,
> +	0x4336,
> +	0x4337,
> +	0x4437,
> +	0x4966,
> +	0x4967,
> +	0x4A48,
> +	0x4A49,
> +	0x4A4A,
> +	0x4A4B,
> +	0x4A4C,
> +	0x4A4D,
> +	0x4A4E,
> +	0x4A4F,
> +	0x4A50,
> +	0x4A54,
> +	0x4B48,
> +	0x4B49,
> +	0x4B4A,
> +	0x4B4B,
> +	0x4B4C,
> +	0x4C57,
> +	0x4C58,
> +	0x4C59,
> +	0x4C5A,
> +	0x4C64,
> +	0x4C66,
> +	0x4C67,
> +	0x4E44,
> +	0x4E45,
> +	0x4E46,
> +	0x4E47,
> +	0x4E48,
> +	0x4E49,
> +	0x4E4A,
> +	0x4E4B,
> +	0x4E50,
> +	0x4E51,
> +	0x4E52,
> +	0x4E53,
> +	0x4E54,
> +	0x4E56,
> +	0x5144,
> +	0x5145,
> +	0x5146,
> +	0x5147,
> +	0x5148,
> +	0x514C,
> +	0x514D,
> +	0x5157,
> +	0x5158,
> +	0x5159,
> +	0x515A,
> +	0x515E,
> +	0x5460,
> +	0x5462,
> +	0x5464,
> +	0x5548,
> +	0x5549,
> +	0x554A,
> +	0x554B,
> +	0x554C,
> +	0x554D,
> +	0x554E,
> +	0x554F,
> +	0x5550,
> +	0x5551,
> +	0x5552,
> +	0x5554,
> +	0x564A,
> +	0x564B,
> +	0x564F,
> +	0x5652,
> +	0x5653,
> +	0x5657,
> +	0x5834,
> +	0x5835,
> +	0x5954,
> +	0x5955,
> +	0x5974,
> +	0x5975,
> +	0x5960,
> +	0x5961,
> +	0x5962,
> +	0x5964,
> +	0x5965,
> +	0x5969,
> +	0x5a41,
> +	0x5a42,
> +	0x5a61,
> +	0x5a62,
> +	0x5b60,
> +	0x5b62,
> +	0x5b63,
> +	0x5b64,
> +	0x5b65,
> +	0x5c61,
> +	0x5c63,
> +	0x5d48,
> +	0x5d49,
> +	0x5d4a,
> +	0x5d4c,
> +	0x5d4d,
> +	0x5d4e,
> +	0x5d4f,
> +	0x5d50,
> +	0x5d52,
> +	0x5d57,
> +	0x5e48,
> +	0x5e4a,
> +	0x5e4b,
> +	0x5e4c,
> +	0x5e4d,
> +	0x5e4f,
> +	0x6700,
> +	0x6701,
> +	0x6702,
> +	0x6703,
> +	0x6704,
> +	0x6705,
> +	0x6706,
> +	0x6707,
> +	0x6708,
> +	0x6709,
> +	0x6718,
> +	0x6719,
> +	0x671c,
> +	0x671d,
> +	0x671f,
> +	0x6720,
> +	0x6721,
> +	0x6722,
> +	0x6723,
> +	0x6724,
> +	0x6725,
> +	0x6726,
> +	0x6727,
> +	0x6728,
> +	0x6729,
> +	0x6738,
> +	0x6739,
> +	0x673e,
> +	0x6740,
> +	0x6741,
> +	0x6742,
> +	0x6743,
> +	0x6744,
> +	0x6745,
> +	0x6746,
> +	0x6747,
> +	0x6748,
> +	0x6749,
> +	0x674A,
> +	0x6750,
> +	0x6751,
> +	0x6758,
> +	0x6759,
> +	0x675B,
> +	0x675D,
> +	0x675F,
> +	0x6760,
> +	0x6761,
> +	0x6762,
> +	0x6763,
> +	0x6764,
> +	0x6765,
> +	0x6766,
> +	0x6767,
> +	0x6768,
> +	0x6770,
> +	0x6771,
> +	0x6772,
> +	0x6778,
> +	0x6779,
> +	0x677B,
> +	0x6840,
> +	0x6841,
> +	0x6842,
> +	0x6843,
> +	0x6849,
> +	0x684C,
> +	0x6850,
> +	0x6858,
> +	0x6859,
> +	0x6880,
> +	0x6888,
> +	0x6889,
> +	0x688A,
> +	0x688C,
> +	0x688D,
> +	0x6898,
> +	0x6899,
> +	0x689b,
> +	0x689c,
> +	0x689d,
> +	0x689e,
> +	0x68a0,
> +	0x68a1,
> +	0x68a8,
> +	0x68a9,
> +	0x68b0,
> +	0x68b8,
> +	0x68b9,
> +	0x68ba,
> +	0x68be,
> +	0x68bf,
> +	0x68c0,
> +	0x68c1,
> +	0x68c7,
> +	0x68c8,
> +	0x68c9,
> +	0x68d8,
> +	0x68d9,
> +	0x68da,
> +	0x68de,
> +	0x68e0,
> +	0x68e1,
> +	0x68e4,
> +	0x68e5,
> +	0x68e8,
> +	0x68e9,
> +	0x68f1,
> +	0x68f2,
> +	0x68f8,
> +	0x68f9,
> +	0x68fa,
> +	0x68fe,
> +	0x7100,
> +	0x7101,
> +	0x7102,
> +	0x7103,
> +	0x7104,
> +	0x7105,
> +	0x7106,
> +	0x7108,
> +	0x7109,
> +	0x710A,
> +	0x710B,
> +	0x710C,
> +	0x710E,
> +	0x710F,
> +	0x7140,
> +	0x7141,
> +	0x7142,
> +	0x7143,
> +	0x7144,
> +	0x7145,
> +	0x7146,
> +	0x7147,
> +	0x7149,
> +	0x714A,
> +	0x714B,
> +	0x714C,
> +	0x714D,
> +	0x714E,
> +	0x714F,
> +	0x7151,
> +	0x7152,
> +	0x7153,
> +	0x715E,
> +	0x715F,
> +	0x7180,
> +	0x7181,
> +	0x7183,
> +	0x7186,
> +	0x7187,
> +	0x7188,
> +	0x718A,
> +	0x718B,
> +	0x718C,
> +	0x718D,
> +	0x718F,
> +	0x7193,
> +	0x7196,
> +	0x719B,
> +	0x719F,
> +	0x71C0,
> +	0x71C1,
> +	0x71C2,
> +	0x71C3,
> +	0x71C4,
> +	0x71C5,
> +	0x71C6,
> +	0x71C7,
> +	0x71CD,
> +	0x71CE,
> +	0x71D2,
> +	0x71D4,
> +	0x71D5,
> +	0x71D6,
> +	0x71DA,
> +	0x71DE,
> +	0x7200,
> +	0x7210,
> +	0x7211,
> +	0x7240,
> +	0x7243,
> +	0x7244,
> +	0x7245,
> +	0x7246,
> +	0x7247,
> +	0x7248,
> +	0x7249,
> +	0x724A,
> +	0x724B,
> +	0x724C,
> +	0x724D,
> +	0x724E,
> +	0x724F,
> +	0x7280,
> +	0x7281,
> +	0x7283,
> +	0x7284,
> +	0x7287,
> +	0x7288,
> +	0x7289,
> +	0x728B,
> +	0x728C,
> +	0x7290,
> +	0x7291,
> +	0x7293,
> +	0x7297,
> +	0x7834,
> +	0x7835,
> +	0x791e,
> +	0x791f,
> +	0x793f,
> +	0x7941,
> +	0x7942,
> +	0x796c,
> +	0x796d,
> +	0x796e,
> +	0x796f,
> +	0x9400,
> +	0x9401,
> +	0x9402,
> +	0x9403,
> +	0x9405,
> +	0x940A,
> +	0x940B,
> +	0x940F,
> +	0x94A0,
> +	0x94A1,
> +	0x94A3,
> +	0x94B1,
> +	0x94B3,
> +	0x94B4,
> +	0x94B5,
> +	0x94B9,
> +	0x9440,
> +	0x9441,
> +	0x9442,
> +	0x9443,
> +	0x9444,
> +	0x9446,
> +	0x944A,
> +	0x944B,
> +	0x944C,
> +	0x944E,
> +	0x9450,
> +	0x9452,
> +	0x9456,
> +	0x945A,
> +	0x945B,
> +	0x945E,
> +	0x9460,
> +	0x9462,
> +	0x946A,
> +	0x946B,
> +	0x947A,
> +	0x947B,
> +	0x9480,
> +	0x9487,
> +	0x9488,
> +	0x9489,
> +	0x948A,
> +	0x948F,
> +	0x9490,
> +	0x9491,
> +	0x9495,
> +	0x9498,
> +	0x949C,
> +	0x949E,
> +	0x949F,
> +	0x94C0,
> +	0x94C1,
> +	0x94C3,
> +	0x94C4,
> +	0x94C5,
> +	0x94C6,
> +	0x94C7,
> +	0x94C8,
> +	0x94C9,
> +	0x94CB,
> +	0x94CC,
> +	0x94CD,
> +	0x9500,
> +	0x9501,
> +	0x9504,
> +	0x9505,
> +	0x9506,
> +	0x9507,
> +	0x9508,
> +	0x9509,
> +	0x950F,
> +	0x9511,
> +	0x9515,
> +	0x9517,
> +	0x9519,
> +	0x9540,
> +	0x9541,
> +	0x9542,
> +	0x954E,
> +	0x954F,
> +	0x9552,
> +	0x9553,
> +	0x9555,
> +	0x9557,
> +	0x955f,
> +	0x9580,
> +	0x9581,
> +	0x9583,
> +	0x9586,
> +	0x9587,
> +	0x9588,
> +	0x9589,
> +	0x958A,
> +	0x958B,
> +	0x958C,
> +	0x958D,
> +	0x958E,
> +	0x958F,
> +	0x9590,
> +	0x9591,
> +	0x9593,
> +	0x9595,
> +	0x9596,
> +	0x9597,
> +	0x9598,
> +	0x9599,
> +	0x959B,
> +	0x95C0,
> +	0x95C2,
> +	0x95C4,
> +	0x95C5,
> +	0x95C6,
> +	0x95C7,
> +	0x95C9,
> +	0x95CC,
> +	0x95CD,
> +	0x95CE,
> +	0x95CF,
> +	0x9610,
> +	0x9611,
> +	0x9612,
> +	0x9613,
> +	0x9614,
> +	0x9615,
> +	0x9616,
> +	0x9640,
> +	0x9641,
> +	0x9642,
> +	0x9643,
> +	0x9644,
> +	0x9645,
> +	0x9647,
> +	0x9648,
> +	0x9649,
> +	0x964a,
> +	0x964b,
> +	0x964c,
> +	0x964e,
> +	0x964f,
> +	0x9710,
> +	0x9711,
> +	0x9712,
> +	0x9713,
> +	0x9714,
> +	0x9715,
> +	0x9802,
> +	0x9803,
> +	0x9804,
> +	0x9805,
> +	0x9806,
> +	0x9807,
> +	0x9808,
> +	0x9809,
> +	0x980A,
> +	0x9900,
> +	0x9901,
> +	0x9903,
> +	0x9904,
> +	0x9905,
> +	0x9906,
> +	0x9907,
> +	0x9908,
> +	0x9909,
> +	0x990A,
> +	0x990B,
> +	0x990C,
> +	0x990D,
> +	0x990E,
> +	0x990F,
> +	0x9910,
> +	0x9913,
> +	0x9917,
> +	0x9918,
> +	0x9919,
> +	0x9990,
> +	0x9991,
> +	0x9992,
> +	0x9993,
> +	0x9994,
> +	0x9995,
> +	0x9996,
> +	0x9997,
> +	0x9998,
> +	0x9999,
> +	0x999A,
> +	0x999B,
> +	0x999C,
> +	0x999D,
> +	0x99A0,
> +	0x99A2,
> +	0x99A4,
> +};
> +
>  static const struct pci_device_id pciidlist[] = {
>  #ifdef  CONFIG_DRM_AMDGPU_SI
>  	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> @@ -1253,9 +1806,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	struct drm_device *ddev;
>  	struct amdgpu_device *adev;
>  	unsigned long flags = ent->driver_data;
> -	int ret, retry = 0;
> +	int ret, retry = 0, i;
>  	bool supports_atomic = false;
>  
> +	/* skip devices which are owned by radeon */
> +	for (i = 0; i < ARRAY_SIZE(radeon_pciidlist); i++) {
> +		if (radeon_pciidlist[i] == pdev->device)
> +			return -ENODEV;
> +	}
> +
>  	if (amdgpu_virtual_display ||
>  	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>  		supports_atomic = true;
