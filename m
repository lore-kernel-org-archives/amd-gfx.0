Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ABDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 20:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEE5610C8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 20:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DEE5610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B866E047;
	Fri, 17 Sep 2021 20:50:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7133E6E047
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 20:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDpHP4oSmPqJdx0ikGrzma6ejOU4x9NNinHfPQVpYyj76D17dyWxkjRCrvqeEnXPvhSYppiVQjrFCcSWeBlGOlX52Fc3TsJWdSlklPL1ohM46Ucjd/sPA8W2UCe9hSRopNykOwH3hyUy87exfCU/YuQpdfxah36MT7qU3MBUvqBktTD4ZQqnHjR+PANSwcS8J9B42jdiHfVO3BH0GPlXlltI4IBKJfM4i9IImg2ihKjEgmNGru7KObNKComB/rR1GFG15T/ekfTmXB+ul/SVZ29UdasXyIXPvv+3hPNMwKIdNoe5vYnxIu0LqEbLJbZWC5osi6vVbAn+9uVMKFR4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0LJT5Zj2UBHFCzubInuzv0oF5G/grPLkXde7EtKwPg0=;
 b=gzeNQL4v9x+wnsoUk2hQ7dx4EttpgHbae+zaoJxItafyf77SyPdsPFcAQuOt+/XYUidUSU8TyJ3A2lo/QV4shRF/lMiPSYj2oddeQNyIzB8jY64m1qtomrJTgfISQ3mpWzd7uAejy4JEf10k3+uPZL1ukaGF/sh6/982mskQSx1dxsOB/J2XtW3PNbphiUGG9h7Ww0Yp4K9LSLOZimbixcM7H28WO7Oa3/tF9SPLoTCH/ka45Y89/mnxqOIuQcnXFj3hecY+xt4PE8vGI+AlNYwd42WRakp5US6wpaIxVna5B8wrZjqjK7wC7WwByNZshKb8cMb6zqnqS5t6TnNRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LJT5Zj2UBHFCzubInuzv0oF5G/grPLkXde7EtKwPg0=;
 b=LHdsLjPDn2RyHTNZx3Pf6zIQBkDYzCQ9h2tHNwV1xIrl0qTmFhNFDjmkaBIT3y+D71MOpChLkyrpNc3jUNac3Py1Y8nwyKpGHqYk/070IittyzICuKyEG2TycU2g+GGqRHgLapFbA3MGdjepsIFIlTByZeeXBhVn9vKairULkz8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BYAPR12MB2871.namprd12.prod.outlook.com (2603:10b6:a03:13d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 20:50:22 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::209d:702e:6613:9d27%6]) with mapi id 15.20.4523.014; Fri, 17 Sep 2021
 20:50:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix resume failures when device is gone
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
 <20210917113045.22194-2-andrey.grodzovsky@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0eb16f04-8daf-9466-f79b-814f5cabc2ad@amd.com>
Date: Fri, 17 Sep 2021 16:50:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210917113045.22194-2-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::7) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:a21:4904:2446:825e]
 (2607:fea8:3edf:49b0:a21:4904:2446:825e) by
 YT1PR01CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 20:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 984dadab-61db-41de-99ec-08d97a1cc493
X-MS-TrafficTypeDiagnostic: BYAPR12MB2871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB287116F7B118E9CE4C9E75D7EADD9@BYAPR12MB2871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dknh6vzLzr7K3lzgzUcEpv8MwIw77+PigzJUBHPZxNsTBhqUNHBSe/npiXlara7vTv6TN/gpW4wH91AnOMmjVQLhXP/dkaG2I+REpVKJyQW+s72hsEVg66Vt5fL6AH0UHJ5CdgCvyzEKgu6rxLki4QJs9kKK+6HSG7PHsRVnr2mTuaoLFZifZp3V1Su1X/J9RmwHhqAy6iR097eRcokXAHlzjlCPm6DZU+LqRDp6BuMmQLf9uUEkpGNvJ/A4Nz1q+R/LeKf0LWeojsNDHSkv1FbWBxTXChm7zL3BHiFozVXQABuZ+n14V5ZWiQllCyeg2b833xDtO6TNk5zWndXtO9njqwI7s7mydbHZ6xm0+FeAj2j7V8VVtFkeczvOBqNivX3TnAaonXzsKyR4EacIP7r5KEU77gQNjuXumu1nQnUppOmmAawE3nKMOkO99C8nwS39GFpHijlNJoQi4UBA8mxYVnWKWSFlgmbE72R8vbp1gvpu2+uuunKUgrhWVe039RappfvceR3dRr02yd5m2sPd1RwgEkp1B/9Tyoyh6Fu3L/Pn60abSxrA406ongt/yeRCBT+nA9/LLmIeF/xKupL114qKINInw0zpHEsG89vrg3NVHInhNHt42P2lySGowDKeNojUi/CW/sXTqSqZSbG/0tfXIu9dJQutjQ2uyOf11tFg3OnLO8ySjsajKa3Tf1fRtnTjij2p04MqzAvZsZ0TyqJ7stYS1wZQv+aGuGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(316002)(4326008)(6916009)(2616005)(8936002)(5660300002)(8676002)(31686004)(83380400001)(66556008)(6666004)(66476007)(6486002)(66946007)(38100700002)(36756003)(86362001)(478600001)(44832011)(186003)(2906002)(31696002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBUcnhKTnNFN1ByTGxUbm55VnRoNndZaDhtbHFTbE1aRGVLRkdZZ21IQkZS?=
 =?utf-8?B?Y0VYZi9ueVcwZ0l4SlNqZW1FdStWRzRUWVNWVFh4NmtsNjM1WUZLVTBYUVA0?=
 =?utf-8?B?U0ZNQnlqWlRXTkF0TitEVkpKTmVZVXU4UzhsOGt1cDE4c3NBaW5pb09CZ29D?=
 =?utf-8?B?TjFSd29IbTgxRlVlNHE0SXFNS0U1RXN1MC94U1MxaVJPTGFZNzFIU3ZIcjhr?=
 =?utf-8?B?SkNRdDJxbmlXZnRVTW5zRzRWSXNKZDhyS1JsZFB0LzFjUFdDSWpEZWpiK05q?=
 =?utf-8?B?TGFhK1lSOHhoT3BHUDVBVXRvc3ZqK1J2VkxleE1oZGZDR252L1dBR21PVllN?=
 =?utf-8?B?UXZXZ0xnMm1waHUzVVNDb1B0U0lTbCttOEw0YkpYUGdobElGNzREY1E4bjhT?=
 =?utf-8?B?a1JoMml5SXVKMWZyWWZNVStqZ01lRmJHL3BKcW1aVzkvS2NjK1VvbUh4eHVo?=
 =?utf-8?B?OFc0ekc0cmRmUmpBRm1PMTJvMmtJbm5wbWxleUJBWndlakxMYUtmU05mSE8z?=
 =?utf-8?B?NXliS0dQRHdtaEtGdWNBc3ErZ1E5NGorU0ZDbThqQ28xNk9TMkNIQzRVRDRC?=
 =?utf-8?B?MUl6dEcyb3pYVVVJdnQ4UjdvWDdXS3YrYjBVMThObGg5ek9mWHdQa1Uza3pk?=
 =?utf-8?B?YVNhNmtuN0hXYytOMzdRRDFMTk1FTFlETFRnSGtMOHhmSklzMnJkcmZPTGlG?=
 =?utf-8?B?dWpYOW5qYWJpUFlFc2tzOXB0cDV1c0t6TjAvRjB4NnFIT0hmOFpJKzdTZU5E?=
 =?utf-8?B?c1F0L1hOOGpkcU1HSytndTNoN1RKa2U3VzRzUnlJakwvcXpaZElXMWFTWmhE?=
 =?utf-8?B?dXNOTUNQV3BXREJWQlAvVmc4a1N6cFA5SlhIRWp0TWJyQkJITHpZT2xZRmMw?=
 =?utf-8?B?Y214Ni9rL3oydzNyd05QOXAvNmpkV1o4Z3NsSEtqRC9LUk52OVc0VHhQbUN5?=
 =?utf-8?B?YUE5TUROc1B1RXVRNWl0V2xkaExKTE9xMWdmTXhOMHZtb3ZoNlJPckplSU5G?=
 =?utf-8?B?RU80bU44WDZiNUFHQUZjelRGNCs1MFhhdjhSRmhEeit4MHZLYjhRMXZFMEJE?=
 =?utf-8?B?TXlnOUJ4MXQvcVRNZW5vUmxJZklNLzVXeWlzZk9KRVBybnkxV3VIeVRPempF?=
 =?utf-8?B?RVpnYUMyU242aG1GazU5d2lsTGRrLzRjZHRKS1Z0R3ZMQW1GUVptOWtRTFZ6?=
 =?utf-8?B?VWdFWXpFOURiYXpxQm1HT3VWdzM4Z2VQd2tmK1lxTFgxc0Y0Z2tNelpnSUp2?=
 =?utf-8?B?VFBYYW5MNGJpRDZrSmRrQ3N2eG04R2M2ZzNEeEI3MTFWT1MvRWUvdk8xbFdy?=
 =?utf-8?B?cllFdFdOaGdyaml4T01iQWxpdGl1TGxnSEh6eTRzWHhWZW55cWovYWJ0WERH?=
 =?utf-8?B?YnFzODAyYnQ2S0ttWXVLT0l4cDVxRUxvM2dsY0JIRWxJMzNjSktSa1QrcTNI?=
 =?utf-8?B?MlE1Lzd2ZEJNQzJweFRua3JwVzMxUkVyaXRQTi81TzVSVmZzSG5JdGRJOXhi?=
 =?utf-8?B?MUcxOEF1eExtZGZubmhVQ0M1dDlPdmI1TktzY2NSa2s5L0hURDU1YVM2Q2U1?=
 =?utf-8?B?QWRja1Iyc281dnl4S2lPeHludWtabjlOcVN6TGNrdFE3STYxTnI3MjNtMG1v?=
 =?utf-8?B?YmxGdi83RXlmNHo0N2d2UXhHdk5wMTRPaW84aHp0MmptWGVPcUhIaTI4bmdX?=
 =?utf-8?B?NGp0eTg3WmxYYWhOSkZvOTAwL0VMQ1VRR2dMZG5xTTBhSUUwM1hNZnJMOU4y?=
 =?utf-8?B?bkRGYVVPaS9FOVJUNTFkcDU3Tnc2VEUvaFRvZDZhUFJ3QjI2SUY0VlFTZExF?=
 =?utf-8?B?Z2JKcGZxdFpVQjlZdVN6LzlnR25jYU1FaEZrTWJmSG5hWFN5MndHeGM5WXFs?=
 =?utf-8?Q?DKiWP66+4IQzz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984dadab-61db-41de-99ec-08d97a1cc493
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 20:50:22.7275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgGicWctctEOnk4rct6BK7dN43vvbhsTAqtkXfjkPgaSb3TBQ//UMBRG6qoTek+C5wQdmCAFPqlx/BOQXk6tgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
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

Ping

Andrey

On 2021-09-17 7:30 a.m., Andrey Grodzovsky wrote:
> Problem:
> When device goes into suspend and unplugged during it
> then all HW programming during resume fails leading
> to a bad SW during pci remove handling which follows.
> Because device is first resumed and only later removed
> we cannot rely on drm_dev_enter/exit here.
>
> Fix:
> Use a flag we use for PCIe error recovery to avoid
> accessing registres. This allows to successfully complete
> pm resume sequence and finish pci remove.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index db21af5e84ed..04fb4e74fb20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1522,6 +1522,10 @@ static int amdgpu_pmops_resume(struct device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   	int r;
>   
> +	/* Avoids registers access if device is physically gone */
> +	if (!pci_device_is_present(adev->pdev))
> +		adev->no_hw_access = true;
> +
>   	r = amdgpu_device_resume(drm_dev, true);
>   	if (amdgpu_acpi_is_s0ix_active(adev))
>   		adev->in_s0ix = false;
