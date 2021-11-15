Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71AC63211
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 07:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C71AC63211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FF86E842;
	Mon, 15 Nov 2021 07:50:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A36D6E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 07:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceyDrnBK6Rm9l74oXkA5Sc81yuHK264aHNSqYPXWAkRbWAgtROYFIih/TVScDCCIoEocIy6qSo2pEBHWxV5c8zgR5O1dpmJyeWUYqyQws/JhLcYBY5zEamYVw6kzjVzE9rDn+lc3MIOlhY7W9UWlF7/eevvjixgFspgVilg6D6URd/QCft5dOYLzx+oUdrKorDtXw9YbpmddZtH3sloIwxKxcMsk9h6tJlq9HS1TffLOqGKAM2gi6ScHHLRaXuf4hIx4WPQBLOcuX6uxi98RoKQDsEFA9rSHWiUIGXdNdbNm/RQECADcmcZfr5hdr4N1cKzurFLbLbnPFz2xUXbUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BCMNfJRcPFIyZOsBQQ0y7EEqtF4hBxmvQ2BxKhuS0A=;
 b=h5fvPrWX/S4h4gPk6zxwWssZ37sOohTWT7wIyp8ivy69FTKOmtkVrHur3PPWIlJmYY0QD/Iu3YhXSGqgCNKlzDDqPFj0OGbjA/CkvnBTRVeoey3Ucwi2my9QznFzWHk7ZnAXkzrCnXe28+stg8RVLtANu32eecQhXvDvzx30rK/DYo8fO3paUeZa67WsHMcVQc8YluTDg6P/mTeP+xE1u3o2mElSJ2EO8640IdhqWieec2OynofD9iIABxPM9faxVFWs9CjjTUhLp4S7xUcGeLMEIgC647aXphGPQ9WPJA1blOYA3PNS605/GjMoYyVBXmKRJIM6YhDDJSpKGxP/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BCMNfJRcPFIyZOsBQQ0y7EEqtF4hBxmvQ2BxKhuS0A=;
 b=PoELlZcNR/a3DisIdofgQdtr2/x+f9XONJ9nu5AQcHU4Vw6OdcgKBc4DwGxB56DxMa1h6ZZRyVRYHzaEV9LW3+pW9/iUBXvU7l8RqEYJwvPSvBAcOvgbwQbtezRjBn7/kAQRQUq5TD4BKTWcC/ERf247iIXN9thVy/QiRsAWq3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 07:50:06 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 07:50:06 +0000
Message-ID: <a3c306e5-2672-dd33-fb18-ff86619d617c@amd.com>
Date: Mon, 15 Nov 2021 13:19:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211112162530.149709-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211112162530.149709-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 07:50:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ff9fc49-b790-4d4e-91c1-08d9a80c89e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24872326C510C2B396E00B9F97989@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sv233AvxK8NNSDJA2uqHaMcr4rhWIIeQ3jG0+dt2Qm4FSCCwc2Otc6XAzz4EeyLKb1Sbkw86t+Jsym5pbpmYy9cnjCjlUk6bS/cJU0vd8xQvqmErq4K+CSN34XOgKXwWUEzbM+bXYXwAWb4dXjg9M0FEyEupnkfsXQuctqxGpeM04vJkKqtGLAQxVEwHZ4X6UU+2JvZXr4rcKhYsUbpc/TOgJ0uM5ijK9nV9bxy1/gN3OnN9QfdofERzUtktoJRWz513eg57G2RaA+Ec8Sw1VieupwkGFSOZvwxg7+4hPN32+24zrwK6cmF2a5tJ7FB45GJt7i9+txwrOnaYE8hj4HAt/cR/yf8ArF1zdIyovSI4MD9tj8qwsMZa3CKNA3l5i3PLcAXGRPUFL2q90tb7HNvDe4jmp+RIBY92RR1syNhl01Ak9jGehqYTFqjccspRGhFIb89IHhqDGOfLsXoI0L9LK8QofPuSAbBCA9A73kklLvftLGzXZe1UGspINVdtMe2PYTOUou1hvQ0PHbfb5YhfX9WSaYeaORr56bUgBLduEnThxZoFThm8QKYvWdOerhMkVKbZ/lWDXGaYuDORDOPITb2MlgkMNtathFJmZAPur7kDOr4RwVOahfaM0DV5/dNTpMLQu4twhY1qCbdr75+Ou9vljZ71xno6jytt7a3lcPDtaqvXDAQzTBIgxFYCKts+zWod5h3kMbIPiJAAlz7OWL/7aLEGwMhAWIcK5X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66476007)(66556008)(16576012)(186003)(6666004)(36756003)(31686004)(26005)(31696002)(508600001)(5660300002)(8936002)(956004)(2616005)(8676002)(316002)(86362001)(2906002)(53546011)(6486002)(15650500001)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBNMHRhazdGU2Z2UjhCUXFQOUw5dWF5NUVkclg2U0VvMUNlUFljUU5HQXNv?=
 =?utf-8?B?MGhpMDdBMDVFVTJzQU1nZ295ckZLOEtaZWZMQ1VtZnhtcTRkemRhM3oyejhJ?=
 =?utf-8?B?THRhaUsrNGVuclliYUdnUW42Uy9iQ1A5REE5UkRNN2ozQ2lpWWNtaHh2RUo5?=
 =?utf-8?B?V0VSL0E3VWg2cE4wbmxtaDc1YVphNDBMY1c4QjRlUVBzcXo0YlJpWEd4c3Y2?=
 =?utf-8?B?akp6RzhJb3VxVTAvZFJkckxrNkY1SlZ3c3ZsbUF4MkM5THJXSkYrWC9aQXZ0?=
 =?utf-8?B?M3djY0x6T1lWeFZGeXI3ZmR1UllXSVpCRG1BSkdzOVdMVFFIM0xqL0VRaEdT?=
 =?utf-8?B?YTY5eC84RXpkcnV3dU9xSlA2V3EvSGxQUmxuY1hqb3pVMzZSMUdhTk50RnBZ?=
 =?utf-8?B?VUJlWm5UQ041eGZDVnZjT2ZSZm1ncE5EdFRmRnpkTzBUeEJ2enJKL3ZWS05p?=
 =?utf-8?B?YzB1ckVOcW53YXJkbERiS3pVNFIxeWhReTlkbjYyc0FLTW1nSHdFYllCWGVI?=
 =?utf-8?B?Zy9oeHB6QnZJd2I4c0tNL0o2YlhWSURabit2U3RiY2ZGM0Zrb0JRTUlWRTNj?=
 =?utf-8?B?bGhqVm1uS1lWbzc5RDc0UWd4MnFTVlZ6UGVRaHp4SUE0TGttcnhkQTkvSWEw?=
 =?utf-8?B?cDg0dUJBandxZU9ybDdrOEtnTFBzYWtRbEZTeno3S2VPdEhNWjN3YTVsdi9m?=
 =?utf-8?B?UjZPdlp2cCtBWXk1MmVhVVE2U2pEV0xxY2JYN29GUnljaXB0bjh6WEZpd1Vw?=
 =?utf-8?B?MEh3QTlocTNXNHBFRHRiYSt1NEVZSmRDb2tRUUdUa2JkWWpZYkJkVFZjOUJi?=
 =?utf-8?B?WkVSSUhCNUhDN2ltUWh1RkR2RGdVOGlSZ3hKVGVBRnJmS292by9VaG1FOHFI?=
 =?utf-8?B?UC9JNi9LMEpjb0FRYXlqNWpnbHoySWZqbHpJWkV5UDRNUzBQNG9tZVlRTFVD?=
 =?utf-8?B?a0dGSjIxYmhGTXVsbXlqWTVqMEM1azBxaG1zVXZoY3d6dUkvMjcxZUFTQXVJ?=
 =?utf-8?B?MldvcU5GaTJCQWVQM3dEN3BzWjVHMUU3Q0dxaW1oSm5uZmluWlFQSWtrT0M0?=
 =?utf-8?B?blpBRFZQUU91VTNhcTRrS29rQlZXNjhHSW1EaDdDQjVCbGJDRm5FeXo4L1o5?=
 =?utf-8?B?eGs4c0ZTVFRvYUFIdGpVaEhZRXhXN3BHNFRkL21NbjFiMkJCM2lSVk1GSHVv?=
 =?utf-8?B?OXExS0E1UlJvMEpZcWVQRzRTUUgrd1BqOUhzeVVYaGRmc1REZmZENVVuTFUx?=
 =?utf-8?B?WUxxTjVlMWpJak9tdndZUFZNa1lCbnNFS0UwNGZxSjFnTXFpWnlDRXZ2aWJa?=
 =?utf-8?B?b3Y1bHplZUhqN3hsZndUOXNPbGFjb0NZZWVZZHlaRmZ5elRXWVpFWWVJdFJD?=
 =?utf-8?B?SDA0S2hsZjF2cWxqMTlPM2NlYm00a3dVaWN3Wk9NWXJLWk1xQUxFdnFjR3VT?=
 =?utf-8?B?bEVaTU1ZMXFBVk9LWmcrNHNqR3hXcStJQVJsME4yVHJPOTdKZ1N0UHVDYWRU?=
 =?utf-8?B?NTRaaWVEZ0crZ1lnNVU0eXp4SnZxUDR1ZWkvRW9PbUljTkRLUUp6Ym1JV1Ur?=
 =?utf-8?B?b1U1QnJiTlVOalc0WGQrZTZkYmk1NDhxV0tsR2V3YWdXQ1JmNHBsdHFpMXM5?=
 =?utf-8?B?Z0VpR3E3WkRxcUtkbWhaeC9PTFYrTGRnMGFQc3RVaG9sUVVtZ2hESkdPMmxs?=
 =?utf-8?B?ditOWUFzTXAxNjlZcGNidGxnY1NySngvOXBlOHpNNVlwQlRLNlJCQzVqdDd4?=
 =?utf-8?B?THp2NWZQQ1FTWklzV0J6M202QkxQOG40cG5DdVBVMXNPU0x3MC9zRytSY0I0?=
 =?utf-8?B?MzBEQ24vVTAxWU1mcXRjd1NFdkdPS0VGeGJzTHhRRkdyeWwrRlFhNzZ0Tkgv?=
 =?utf-8?B?bWFaRW8wT2plUVlZemtXNGs4UzFuK3FnYkpEKzFFYkVzS2Q3UFB5a29IR0ZH?=
 =?utf-8?B?ejQrRGNrY3krbVN1Y1dsRzlKMWZEcXdYRnRad3c1ZHJ2NUtleElWWXV5MkNm?=
 =?utf-8?B?eDlNMitnR2Q4bDl6ekZLZy9DdjRHMHQ2cWtuWGdON0w1Wm5GNVlQV1h0aWJP?=
 =?utf-8?B?bGRyY0NZSDErZ25ObUZWRTdhY3BQd2daR3IvN2FsYk1XREZYTHlzRDRSWFdT?=
 =?utf-8?Q?27XY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff9fc49-b790-4d4e-91c1-08d9a80c89e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 07:50:05.9809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPwYuD8l2H8a540k46IZy5vrz8hJJdd0tq6JT90NEK9ZF5llAW8lqh1N+iHbHAT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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



On 11/12/2021 9:55 PM, Alex Deucher wrote:
> If the platform suspend happens to fail and the power rail
> is not turned off, the GPU will be in an unknown state on
> resume, so reset the asic so that it will be in a known
> good state on resume even if the platform suspend failed.
> 

Any more background info on the issue? Is there a need to trigger BACO 
or D3cold entry similar to how it's done for runtime suspend?

Thanks,
Lijo

> v2: handle s0ix
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1db76429a673..b4591f6e82dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,7 +2165,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	adev->in_s3 = true;
>   	r = amdgpu_device_suspend(drm_dev, true);
>   	adev->in_s3 = false;
> -
> +	if (r)
> +		return r;
> +	if (!adev->in_s0ix)
> +		r = amdgpu_asic_reset(adev);
>   	return r;
>   }
>   
> 
