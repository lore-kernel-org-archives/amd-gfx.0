Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59636C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 04:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4ACD10FDD4;
	Tue, 12 Apr 2022 04:19:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3046510FDD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 04:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBmYQt3lGUZVgMinY+xHwBuKnOFJ+yrr+yboTlCbtvdWXgk+D+TLydStgE5IGmp2m4SSxrWonoj7Yl5d+Mjp5zWi6GTRzW7pXxo9cb9HaUFSwysjHdhRKYT8F0Yipb7KHZeKtcslO0qjUTNRHKRJeJIZV6t9P8Uki7ujDJfZLgs/9om8CiC+aFBoQdE55tKldF2fQnYkYgzNUqt5HnSyCyS1uUGbecKgI8wXKlG8Jo3RAkotElY2B+OXJ+/NCd+ChRmxaX4RdCNeCm09YzzpVT3nqYFYPcJ4aFs668W+NM+xKyyjCAyhOA3czBCvK8t/d+lgjnQtN083kQFIjR1QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4FwQJeLHznOjR4dJu5HEo9gW8vWp4d1+cfPlgm93sg=;
 b=ZbcJ6aJAqxoPlv0EA+kcbKV5Blpn3VYsAur6F/UrV2gE8HYRRD5Y765149ZrrV2M8K7rPAFyG2Gxb1m5uCGqCvT9oG6ktyHTiHkRWQCSJmOPLuoDsYEvb6EuREvAaW6XxQgpGMqNRNVKG+q3hyMe9lW9qFJZM19Rx6ufYYcOtEP6wv5uvO8SwaYt1RzxjmKVSgIo9VwjLOFD7KTP9goxm9lmPcsksbDrvAqnqFV8Mp8tOxHcI9jfSKBmzAN/tvwGIDIXBDYjQI+epQJshBNmC2SkB96pF1m3txWX4Rztoy+srmsSpoJXAouKhSTr973VqeyVAphDyx5AXB4HGhwOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4FwQJeLHznOjR4dJu5HEo9gW8vWp4d1+cfPlgm93sg=;
 b=L1JGs5vJMSy27Ph26FmKdDv7H4RAPpj8acI4zWd5AfbVBBVgwpi1goOY9KfgIvtQApWgJ/6Rasfos1a8qo4nYCovf0gobSWK0jyHHsp3JVqTB6aTDYR/bBC64VXa8BTxuCnKJMbDltqYZKy4qkmEouUC1bwFZ6ZKlT/GrsAHgoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:19:28 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:19:27 +0000
Message-ID: <97cb1d93-8e66-db98-4ecf-7e3f44dbe894@amd.com>
Date: Tue, 12 Apr 2022 09:49:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412040801.19905-1-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220412040801.19905-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf30642a-1a36-4c24-a498-08da1c3ba17f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4923:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB492325FAC8ABC0FC385309FD97ED9@CH2PR12MB4923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72mX7yifBzBX42S1dUEBAKElm6Jq6+rZbMzXTfTnDxP6lOL2YRBxXbLlvhWMxeRJioQGCupqhfJykkg6O2/D2bWXqFk4Ibs2NoYD+Cf3XiGJFPBBDmeCyODMDgFtzGNPvMnHd0m7kldbu1/8+CtBD0bSWyhBkMsqZWfrb+N0KWha5i9XkuW3OhTitq3GNe3CJLQ+UMO77PLSpHpDxRCnt3zNMLcOR2tJacUa/Xznd/ve2JH0yCxBaj/XeM5EZNswf7BtKMLM9cdbu4zCNn793m0TjVrg1KCHEISvdrm4piYVvTQaL3zFP06a+tJhxahZwpVTsGBybhZFgpZxHj58OIixA0/Bt9w5XK/Bkax7P3gbvc5etZRpsKPPqLqmJi+5nxvFOTjrLVygZ26Zjfwl04n9hGIxkp9JSVyINT/k6bolO3ZaKdRwy7eqChUKu9yxvkg8BZPpB19FIgTsPwEztS6SOiPYHgGLC5TrhSLXss3Mq7Gdv8qtWZXm3X0Unw2PV1mH5/5Tnt7oMLUPPmNdzOUTD6ZPRLYkmw58kiWpioeojKjDh33xy4g1oOQY6jnuTokZJ+zWlxJkGS1npSKFPhf9VTWX1BgXfWd1gcl8dBz9RlgnQAhRDA2ygzy/yXsvtdhbz/zosmYn6X1IzOBwJfK40wJ82YD9pPn3Itn4QViQ5Rsq4qSnLoX7Pg6zUOGQR6bNi1XpghCzHnHDNdDonnjPhJGLxb7khohIijyzfaun7r6iBV8pB5BmEy6CbcBR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6506007)(316002)(4326008)(66556008)(66946007)(66476007)(8676002)(508600001)(6486002)(53546011)(83380400001)(2906002)(6512007)(26005)(186003)(2616005)(31686004)(5660300002)(6666004)(36756003)(86362001)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFUyMVVkM05ZNUtRVU9SODRKczV5UmxNSjFYNDRXb3prS1grRWZQYmluOG5o?=
 =?utf-8?B?SzJWVGtFRTdmS3VTQThkTmNWbHZuWVVRVlplY0VsSXNWTGpRaUZWeWh5Y3Uz?=
 =?utf-8?B?NWZpSXpHRjJsVE15eldFTmNqUGxYK1VueEttcFZzZnpEdWtYTjdKamtZdzl4?=
 =?utf-8?B?dWhub3pMV0FuQTFBMUNoSmk2eHhYcGFHY1V5b25kR2VPbTg1STNMMk9hVlND?=
 =?utf-8?B?YlBDWmhTYVhLaEhPaVd1REVLRlNSdWtyS2RmdmIwUkVYc09Mby90WlZyb1VW?=
 =?utf-8?B?U2FtcklaaitWSjRDNWtteXIwOXpvcDY3ZVB6ZlJCV0drR2kzSXFYVVRDOGNB?=
 =?utf-8?B?U0k3c1JCZERERkxFSTZHbXE3aE9KbDYxTlg4SW5sUnp5T3NzQlh6dGlFTTJZ?=
 =?utf-8?B?bzNYazBBd1dla09MbDFrNmowL1BZaXpWaVNpdVBGd3dGWTRJUlJWbkV4bEdM?=
 =?utf-8?B?WmhjUnFkOXNwejJvdjY5ZmttRXM5MGNJOVU4VnVDRW5hL0ExRURwRWdoQVFD?=
 =?utf-8?B?K0JFOHRvTlZwTzF3WXpBNko5USs5eVl2YVRrVm5aaW8wOGhNWk5qV0U4bHl3?=
 =?utf-8?B?UWlBM296cm93eUdTU2swSlhCQi9IbnBKcTlnUmc4NTNhNmhrSFlncEFMb1VO?=
 =?utf-8?B?c1FzbXpLV3pLb29sYlMxelBQYUc5NWtGeUc0a1JVeVFzTlZURithcGZyUTRC?=
 =?utf-8?B?TVBLc1RCUkdlZ0tNNDZIR2ExSEJZcno2QzVxYUFXSENBZ0lVem50TFh5RVVr?=
 =?utf-8?B?cS9lanpOOEY3eTNxbE1YQTA3bGJwU0JxbWhJWm5aUXNoYzRHdWg4WVVBaG5P?=
 =?utf-8?B?MXd4TUtCZXdkTUx0NXFYeUZWV3BLd1ZOMThpV243TmRMSjZXRHpNRHd4VFVo?=
 =?utf-8?B?Nno1VkdnSitIa09OcUM2MFVOUTlnYm1WRDUvRk9QdGZPaTRiOWY0MENrQi9n?=
 =?utf-8?B?WU8wRUZHaC9ZaHBHeTVzUVVlb3FPeHAvR01LaDVadnVYVHVJNXJDc0U1VGky?=
 =?utf-8?B?V0lCZ0JITjBUcUtrMzZzZDlzV25EUVpRMnFYYTBNN2IxUE1mOElySTNqSzFp?=
 =?utf-8?B?VVQ3QjRLUEFicXg0YXUyd0Z2Si9scEkxUjdZUWNmOEJWL0ZFNmxoMzZzOFVp?=
 =?utf-8?B?MjdnWEZjUjFGU1JNakZqd1lxZkhJMy9QTGNUVTJ4N002eUplM2RBNHFmQ1Jz?=
 =?utf-8?B?UDAyNVlzR0tDcU5MbTdSbWliMmV3dkxhL0hCbTArZXhza2VzL3k0UnI3WXAz?=
 =?utf-8?B?NVlQTW9yWit1a3FDeE9xK1kwVUs1WFhiYjJCUkRCdEVUTnViUkpHTEtaQlIw?=
 =?utf-8?B?bUtHWm5GMzVuK25nSEFtOW1qT011dXAyWmlqVFNNd0YwNmdGQ25iRFkxL2ZL?=
 =?utf-8?B?bDg0SUExdEpQeUJRMGdKc0JtQ2gyM2duRXRFcFhZelNlUUFJZys3QjMxSXN4?=
 =?utf-8?B?VGZDdUVUL2ZmZFE4TTQ1bWdtRkc5dlRIN1hEZzN3LzZqbjlvTUhYNm5LUURF?=
 =?utf-8?B?VjA0VGRjQ0QxKzZtRklzSElITEhiOGc4YS9wVkh0N3dOZGcrZVVFWnB5Z09s?=
 =?utf-8?B?WEZFL2xQR29PR3NYYkpZb3NhSjZXY1V6c1l5S2FPbTNlUjkzc2RJT0F6YzRI?=
 =?utf-8?B?VTFDTnJPSVhvUThNUjc1S213VVFEbFlkZmNiYlFSOTQzd25PMGRNNUtGYzZO?=
 =?utf-8?B?SmlDV2VrTkxkbkJqMVNsWVQzYlZoazhzZHlnNURwZE5BMHBJSjBISGl4VURT?=
 =?utf-8?B?Ri93ekpWUGdYeklwZ2FsaVFvWnNKMVNubmRQTnAvZHhvbnlRWWJHVVBCYjJm?=
 =?utf-8?B?Z3ptb3VNUUc2VUJUZzFMUkF2OGE0WkZwclg2aVA3b29OeHJvVkE1N1pmMDRQ?=
 =?utf-8?B?Qm5mK0VJd3hLQTVxekxXcnltRGxYOG1DN2cxaXFJSlVxRGZSR04yOXREVjI2?=
 =?utf-8?B?SW9OT3BmYWV1LzVEbEx2N1hZUlVXOWpWUzdGU09Nc25tYyttK2R6WVNSS2ts?=
 =?utf-8?B?dDVDV1NWUGhxWTk4bUlkd3BuU0JvSkFvaFVzWkxnYXJtbmdweW9FQzNSRDFl?=
 =?utf-8?B?NjQ0dWRlRXM5NzNxbFY4TUdRaWtZOTFvQlFrVDdtSmdrbEw0NDRZZkJRMGxw?=
 =?utf-8?B?MElTUmtZdEx5bU9weFVIb0kzRzV4MnhGM01ENFh1M0ZLNHE2QUNQZ1hHL3hV?=
 =?utf-8?B?bnlmZFFuQW1TUUJMN0ovQW5wMnhwVWFGZGJSaWxVL2NzaHdqSFg0elZuTUNs?=
 =?utf-8?B?OGpnN3E1bFJsTm5rRFBNeTJSdzNuVXdvSDRYem84eTdDSGg2K1hRSGNlYS9X?=
 =?utf-8?B?U0hURHMzcGcveTdqbEg3SWhBL0V4S0d2bnUzaERkTStMYkRTTHdRQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf30642a-1a36-4c24-a498-08da1c3ba17f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:19:26.8553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yw01wRx9Lsc0Lr8JoWWDwWvDdzAe7RELRLHKnBvZMdrxCfbyE9WSicJsNPZT/b+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
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
Cc: andrey.grodzovsky@amd.com, luben.tuikov@amd.com, evan.quan@amd.com,
 pmenzel@molgen.mpg.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/12/2022 9:38 AM, Darren Powell wrote:
> Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
> cases exist where messages are silently dropped with no error returned
> to the caller. These cases occur in unusual situations where either:
>   1. the message target is a virtual GPU, or

This is not fully correct - only messages which are not valid for 
virtual GPU are dropped, not all.

Thanks,
Lijo

>   2. a PCI recovery is underway and the HW is not yet in sync with the SW
> 
> For more details see
>   commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>   commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")
> 
> (v2)
>    Reworked with suggestions from Luben & Paul
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..8008ae5508e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>    * completion of the command, and return back a value from the SMU in
>    * @read_arg pointer.
>    *
> - * Return 0 on success, -errno on error, if we weren't able to send
> - * the message or if the message completed with some kind of
> - * error. See __smu_cmn_reg2errno() for details of the -errno.
> + * Return 0 on success, -errno when a problem is encountered sending
> + * message or receiving reply. If there is a PCI bus recovery or
> + * the destination is a virtual GPU, the message is simply dropped and
> + * success is also returned.
> + * See __smu_cmn_reg2errno() for details of the -errno.
>    *
>    * If we weren't able to send the message to the SMU, we also print
>    * the error to the standard log.
> 
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7
> 
