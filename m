Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D8C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 11:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF3C60F44
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 11:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CF3C60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760AA6E924;
	Fri, 27 Aug 2021 11:34:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D8D6E924
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 11:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+jPwcmu87INFrT0SsaQhczII/OhvapqYfW0XQOlwBJTVvwQEFsqW5YIP5dbH0lISX1YWO4287+of4AAWZaF4rY2182IwJCrTcBYG/C51602fCUV/4IG3dHA8DYMWPagdDKUBoI2FLSqOuRSJhp2ri72mclOCcb7lpBijCGbhjT4X2B8Ec7V7uhmyAzDsLSGy1F39zeNkrly+jnCesDHxe1j9UOv5aosAQBPaB9uS/JzeuZWpKku22fcJ3+BGmXs/HAfxGPpZjXouiz3uYQPn5T7jEjk7RF8+ylQglmsfCIhikMh1p4GR4atPFUPMI+rYNkWpDuosO6jVAbRFE2JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1Hllp1dpfAAykgR8HuCYyeENmfD86fFb39+DjeE0zY=;
 b=Dlvl+1wPxIHU8B2IT6P7X76qEDlAY1lBRBGbRB7ZgeRYfp7QDxqnR6ePY7zKzXbLV+KjcoUhTj9OBEJ2X0XeNwe370GilOkBQ9MblEYGnxbzdLSZS32z/A0buZp6MKi9DQslbNJHeIJjd97oQB42UOw8/XSF3z/WEd1OS9KZgmQXruN0zvJIlj2iNGiWSpU9K81pjGdh7O5G1SYoQziJhI3YKI2SpgthW1+uhGt37vwVUCZvBym1GgI7f/88lWLQgNr92+sbTd9Cksua20ssBcBIZhjTkVuk36lKXCdnRtG56A9dvABRXnqkfzqsE0dH/rSv0sdQRYd0g13xIGUudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1Hllp1dpfAAykgR8HuCYyeENmfD86fFb39+DjeE0zY=;
 b=DEe5wQtVohWHlluxyBYwBH3cvRjgEsVsjwQG0XjAk2XN0xblEZ0ONzuaCqcPM/K7S579gx36s+TROdvWmwaTmlBR+tWBePxSiqGZS3hxgFBbd+eaE9GTpl/B238qJxk6G7tlHvJSDmnYa0Q4fwBZQj6KM2b6wnF3ml0VHZdE2sI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 11:34:44 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::7917:19c:827d:49d7]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::7917:19c:827d:49d7%5]) with mapi id 15.20.4457.020; Fri, 27 Aug 2021
 11:34:43 +0000
Subject: Re: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, andrey.grodzovsky@amd.com, mike@fireburn.co.uk,
 alexander.deucher@amd.com
References: <20210827104038.4945-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5bc45025-b524-926f-736f-95e5b70ae8be@amd.com>
Date: Fri, 27 Aug 2021 13:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210827104038.4945-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::18) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 PR0P264CA0150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 11:34:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127938cc-5345-4fc8-072c-08d9694eaa1e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4084AA86882F877182188F5283C89@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sbq4liJlKqXwMRR/uFn9W5fD+Jgakt7BJr+bSMB6dcFf7JSEx15hAhYtgSgG87XRL2VDf00bl17qNRX1qNzl/TBdoMqanEhTng/VAIMGKlKlBdfgAnqGiDZEz5FMuBwzr20YUBzjTfrxwK0ISkFUwezIDc/EYTJWz6n2X805FeD8e6EhMAFNsR1z38nod9VIzFrGJr0hHJ5r1/Gwo9A4N+YikaE9VQi/WdG9LmcnXg7VaHBsa1+NkkAxbfpI5qm0a7fMHrZUzNGj5yooBQ8Kyrmrs/oGaxr/Pl7PD5V3L4bFUcnF+t6yFVEJF6gOVLtEDnLjUp4OA6aqZjey3U/IoIlGjS1mza94zODLWpC1hIkHz4uanKjGNlU6wTYbZpWh6wRb+gCdhjFE45UJWr7OHM1CtiPvEKJ47yNXCM05ZgBLFqfvsR0/gU5npO20Nx5chxpJ/WLgN6aQ8lKigU2MoDDuV6lKC4o0cR8D4RQH9HrqvpdRx+HJgoWp/FElHr5ohFyMVMMtWnRw0SEuKtZ/YrbmcMvYa+p0KBV/A2teYH+p2QKQ4vqjwTCKH1mCJh6HibJmwnHeKqcsB3pE4CNdYanyrbMzkg42iUKyyewY0xuv8cHjNdJ7ZII5Mpk9qPvGMz2Tof+GCgHnRq+mM2ft7sHbNHpe9R9risHhlIhB1eE4MKeULjtUs4QNhy1XxEF2mtPB2NL51FPoyRmD2w5W2J9GtI+kC24EntQHeOVykteEy1Mk9FMfUrFqG8rf/0FA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(186003)(36756003)(5660300002)(6666004)(8936002)(6636002)(26005)(38100700002)(2906002)(2616005)(956004)(31686004)(6486002)(16576012)(316002)(478600001)(86362001)(66574015)(31696002)(83380400001)(66946007)(66476007)(66556008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkF2RnAwbDJHMUhSU0N2dVVMWlpYY2hadUpWOFNYeG8xM3hYdlNma0taUzlW?=
 =?utf-8?B?dUN4YXh6dXQ2VDF4dkxlblpYUk9GSlVlaEU0cVFCS1I0Wmlrams5QTFNNjFh?=
 =?utf-8?B?TDhud2xEeUhDd2l0VzIwcE1BNWVuMG5oRFJXbGluTVhiRGxmWm1VUlM1S2FO?=
 =?utf-8?B?NURDYkkxdjBKRjZvNkplUjB2Q1NGK0Z0YUdMVFphN2xEVkpPUXR4YTVicndM?=
 =?utf-8?B?cGkyME9MWEVLSWpvN0NHL1RSbGZqSmZ5Q1UrMFZKT2liNXppeTF0M3hKQ29T?=
 =?utf-8?B?aU9rczY0WU9lMjFvdUJhdno1RTdnYm5mRDJwNXA4K3VseVVpQmFxVDdGa0tj?=
 =?utf-8?B?T2pITTFQNW1aa25tS2ZXenlyelIwWTVFMm11WGp0WkNGRlJPY3ZzSGx4VDRM?=
 =?utf-8?B?V09FUXVpcHIzcXhJOVptVHNDWHpndEFlNlRNT0FTd1hSOVpRSkVITTRuSkJJ?=
 =?utf-8?B?VmhVUHRyNVRnZmY2VjhQRFJTMTJxc3Z2OGxNNXU4VWFFWE1BNElhS2thV1dI?=
 =?utf-8?B?YndyUm11VDN2T1RKQVBrY3JzMWxsM29RU1VRTG1hbmk4ZE0rZ1gwQVhNanpN?=
 =?utf-8?B?YTBUM0dESFdrajFLNE4wRTBOTytSbjJzSzVkQ3pXdVNYcFNaR0U2TkZCb2tL?=
 =?utf-8?B?RW5tVWdPbFlLc2tDWlpmeFY5dUtMTXFDSFJmQ2lYRzJmUVdkMVJkVnFTVzZD?=
 =?utf-8?B?RU0rc0hLWDc1ODcwYzhXbHFUOXl5cEtqTzIzcEJjQWlTZlhPOFFOcmZ0Nksx?=
 =?utf-8?B?QmJNeTBYeDBKVjM4WkxBQXpwU2lpNXI3SVZwYjJiRGZrRjQvOVI3SHZVRXpY?=
 =?utf-8?B?cjZPL1VmZEFrRTFocDNpYzNMSnpZTU9ob3dQNVZBbHRBb3JWT1dXQzdXdDhk?=
 =?utf-8?B?cGRUcko5RnpTQjZkSk5pTkhmSXpWU202MTdJbUVwWE4zRE01WDVueldjZ05Q?=
 =?utf-8?B?NW1TVmE1d2NZOXdlSVN4NUUyTzBvUXZDejlZbG05ZDdSN0U1amlQaE9TWWt0?=
 =?utf-8?B?c3lRdmdtUFQ0SXVOb3FUejkza0tBdWhkcU5LS293Qzg4U1NXWmJlbThFSjdC?=
 =?utf-8?B?bVVrSzFRWXk2NHVTN0tXMjd0bFdWclVuWDErdWY2YkgxcnVEZkphazJZQ25m?=
 =?utf-8?B?aStvSFRJTGNqemx2NUgxZDVXUmZ0MHpmM0x6R05IMURybEgrUG53b21MK1Fw?=
 =?utf-8?B?TkMvRE9nYTFrK2ZTNk1oTlo2NTlZK2RudTNzcEFmRzhMelNRWmNOWlhHdG1a?=
 =?utf-8?B?M2RWNytJNzA1b0NXbHZTOUt2WkVPbnZZS3JmYkk4bVhScjA2OWgvZ1ZSS0Vq?=
 =?utf-8?B?N1IxZ2ZhcmdtSXBSKzdGQlUwV0xXbVNZaHFRc3VRTlRVMFlRV2oyL1Qzc1lW?=
 =?utf-8?B?Q0Z5eFNMUXBEVEVzdk5VL2NpVnNDcEZaUXM2dHQ5Mk51WXFhTmFVUGpFbWFS?=
 =?utf-8?B?alVIVXdMY1R5K3QzS3YxZURIZE1hanJ2OC82QjZuME4vRnRLZGdFb2I1OU9J?=
 =?utf-8?B?bnpIS3VhenRpMWZHVjBxV21icGxpZ0RobVZKRkVZYVI5d2N5Rjk3ZFFsb09m?=
 =?utf-8?B?R0tDUHNSZERiODRaQVd5bmlzTmdPWVFjeU84RWRMMy9wcCsrYVNNejlsY0Rp?=
 =?utf-8?B?cXBleXBHbWVWV3M0ZHo5WFIwamM2cnRsWEpuSzlGUmdqUFNNL0tGNlQveUgr?=
 =?utf-8?B?ek1icWNTQ2JYTnNidzdyREkwZXgrd1dmSVVSYmZOU1pRejhlZGY1QkFNdXJN?=
 =?utf-8?Q?S5xD7Eox4KB4yCsk+xgUd+jXDNszfLUdv6OR5UA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127938cc-5345-4fc8-072c-08d9694eaa1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 11:34:43.7023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILxAIncsKtwPoUWGwE0sQpDHXeaCU3zYuaV39Bc9fhITHhJNxfgbc9y1S77JiV7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

In general that looks good to me, but what could be is that we now try 
to stop/start the scheduler during reset twice.

Andrey what do you think?

Christian.

Am 27.08.21 um 12:40 schrieb Guchun Chen:
> This gurantees no more work on the ring can be submitted
> to hardware in suspend/resume case, otherwise the ring will
> not be empty before suspend.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b439eb7d4177..d6e429e63604 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler)
> +			drm_sched_stop(&ring->sched, NULL);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring);
> @@ -611,6 +614,9 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler)
> +			drm_sched_start(&ring->sched, false);
> +
>   		/* enable the interrupt */
>   		if (ring->fence_drv.irq_src)
>   			amdgpu_irq_get(adev, ring->fence_drv.irq_src,

