Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6BBC0502C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 11:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893B810E699;
	Thu,  1 Sep 2022 11:07:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD39B10E5C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 11:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFz3tCmts/a955NELWseRlHhJQaYyvybI60vjwv1AiwQjGH+qx3jx/3aJgG3ucviqnl/dvY+4hvprbun40PVaiETpPdw+9rpnnK/DWhYZOAZ7Lt+7J2OLVln4YEwoQad+7EvYKh7wdSc611sCRg0gcnjW8L0Si/AbcCNZ75Z9S4HkNPXUyLxMBl+Omg9mvGBmsUHbG7YW4+BFuWWrJ/zDpZpO4db55/j3PSlOyI7E2EWuWmzh52Qs0L7paygTNewdMV2YYQSIXod/qy5sD6LAekO5dk8jFMHmtaRc2SMlRCZF/tCMFqRQJDqRCVAa0FsxE/1o/i9cExNRDcmVG0Y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kdIoLCubjlXEedVfgRWSTNdHmExbMS5HcKcj93foyo=;
 b=DO+JvH6FoMYBzIEOoTKmsHiUKnAEHG+9w1eBPJa2tsnqCOOKkAM82HR7CChoklW7qZhRTkccGuwvDtwFGa2LCAxYfbgxntl2UCvj1fWM8PJXtcpEYKAMXyh28IF6DgEejT2WmlyqFoYfNPrTsMP5MltZbce3o+hCRqUcvwuS8VnwrIyrLDFR44HOFX8griWvtnbvTtL1gm2tZJ82gocvkvIUb6xMhTj4aQaK25oKtK1GjK/y2vmkpU0gphmE17saVF78AoANSYk+cNC0Q/WuyuLC3PbtPHPaiUWZ8y9Mq+hL6qr5vBdvnnDsl5VLztw9ZNIifNWX4BiIl4ccH5oM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kdIoLCubjlXEedVfgRWSTNdHmExbMS5HcKcj93foyo=;
 b=kuQ645TimVXvgEmI1wzxn1hVHu2mna4oRqugSSOPaCY5iknhWeuM+q3uHWSXFJewOtf+Z8/OB6X9XcEVobHd4zD+/Qel83hn01+F9ZTtJGKBji7Z4nnsylTL0nhbOmRr3gLZaM3+ATz98gBbNj+p17sGl/U2neHVg8rzMLjlx5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 11:07:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 11:07:30 +0000
Message-ID: <1e3b5deb-48ae-ac30-8b34-671946a34bac@amd.com>
Date: Thu, 1 Sep 2022 13:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/display: guard if clause
Content-Language: en-US
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 alvin.lee2@amd.com, jun.lei@amd.com, Guchun.Chen@amd.com
References: <20220901091108.108103-1-Asher.Song@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220901091108.108103-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0152.eurprd04.prod.outlook.com
 (2603:10a6:20b:48a::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7c2b81-4f9c-4a7f-9453-08da8c0a294b
X-MS-TrafficTypeDiagnostic: MN0PR12MB6246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgHf3YnCgcKWyZtzufqbOgNmuw+f1Z8tToOKriyx2yyeguEWrSiqXaG7dTlP09l/ej3CtRItKlKDCJ4bD3cqH0DBsOgXt7bo7VeiYBF+SrUcjS51wtrGFu5bXFHFSVEyc8caM9Up9dW9LlyI7FOLqTPwu1XS/xDwH8cFScQ85MpPQ2rSn2uFlup+taflRvUtxAxm2gcDD26HaxUH5W83tD8GKgCx9SgBmGxKCanO51If3MjkSX4yZZ+E6HdvwmrAATWLenh6VE38YpRHNrbRnGyfTSHY4JOR3yqipDCAl78SlJAhQ9uqvAcafukOJpoX1ERGUuyoXpOFbFpVxP8BU0zGt4Xy7hlCBzLr9hM8iGJJ6tiTiVGTFLYUnSVXpEX1k/DMQAZla+Bbw8R1Cs8MaWIGoqpSskxpfGW36uHUbUdC7wHd6FhIhWNWG7YL5GNFgBdVtak9GCS1zHkSm9NTBYuG5UWulC+H75ILibcviMm+E2uY9nahmpgJwHJWpB/EgvdEjWFdAPhG8iZQa9uVrjiqq/l7Olw62Tfqw5V7NDd1kOPz54RRFQeMG/kLAurVvpp92x/QQ4c1f2Ah5SGgIEBkvsqe3re5W7LwtmBdVS1Z/MIOb5NQ6z2NSxGbXgKDyoGKZJiFpQI0rInh3TKK9cEYbERPbhTJrQVKs6i3TXvQdgY/zXAt2gf0myK9uHl1QOupEhjJ2uPVPdBTVNDxJf4fGj3/WOJlzONVB2alWeFAXS+urwrpC1CttsA1x1EulIUqhINiM/YwhbicMFKBqsCoWKe52CF69QMJW9NN0yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(36756003)(31686004)(6636002)(38100700002)(6512007)(6486002)(26005)(66556008)(66476007)(66946007)(8676002)(31696002)(478600001)(316002)(83380400001)(6506007)(2906002)(86362001)(186003)(2616005)(6666004)(41300700001)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUo0cTl6TGJpOU1QSEZ1NUoyaW5lSnlKNFdpOTB0ckJ1SWhjRHFkMUZ1Sk5h?=
 =?utf-8?B?N1oxd3EyNWZ4MEE4NW9oMDlzTDRxMzAwdmk5SmVoVEdoS1g5R1JYaVhsaW4z?=
 =?utf-8?B?WWcyTE55Tnl4K2V4QnljU1l0WU9MSURMeWpWSUU2bURaWitXYjZNbGkrWC82?=
 =?utf-8?B?ZnBiTktPWlJFY1d6NTJHbENnK1BWRmdmeHQwS0wvUjlmeGpqWTdnYkozNlhI?=
 =?utf-8?B?azE0ZWlMdmwyUmNQM0duYURtaUVSOFltVXhEeEtnSTdVVk91VTdpYlMrb2Qr?=
 =?utf-8?B?dkROcDBJVysyditpZmRoTGNTcWZlQm5Kekt0V00wWk93WG9HbGZRbkdoems3?=
 =?utf-8?B?SzRRYzZHdFRuNUN0SS9IdjV6SnZCbzBYVUI5TENPUGI1NGpUNS9uMGFIRFli?=
 =?utf-8?B?UDNsSjl2YWI2N29KK1NtamVOTWdKMnNzVFhkUkdKNjNYeTUzTWFxbzVQVEZW?=
 =?utf-8?B?RWIzQVR0RE96ZlYvOFF0SnYxRjA3WEVabHB5SUtOdWgwdU9Xa3Jha2V0Q2tC?=
 =?utf-8?B?bk8xZ21SV1B0a2lKRzlPRkt3eVUxUTFjOEEyNGJNb1VEeXYzWklZMVpvdXlq?=
 =?utf-8?B?d3RtV2xxM2YxdWZYa3FEMDRwdzVMdjI3dWNsdTBqaUhId2dOSGJ5QVJoZ3p6?=
 =?utf-8?B?Yy8vbzJSdmphemNWKzlBcGJBVzZBT0dicnI5UHFtV0NoVi9VUTYyenZBVHpm?=
 =?utf-8?B?V0Z2eWgxREFpME9SVzB0SG9SVW5BUURPSjJ5d1NadC94VFVyMjFtandIN1dO?=
 =?utf-8?B?R29INWFRNlZxTXNacEwyUE9iQUN3dTE3TEVYU0ZjS0ZabW0wVitSWkxsdXlp?=
 =?utf-8?B?MzdnMHBNcDUzci9yTVI0MzA2NExZL2srNGkzbkhmV25wR2JZbXYrZ0M0dCs5?=
 =?utf-8?B?c3BycytKL2FkWTNSQXZzV0thNlF3bEJVUFBvb3BodzVicUpLNlhyVk15NUZl?=
 =?utf-8?B?ZElQNG1GNm9mTERuZEpuamxVUFJqVytGNE0xOXZyYUIrdHJxR2FraGIzZzFI?=
 =?utf-8?B?dUVMOGtiQWVhZnNNRHdwR0tXblhaYTl3Y0ZxTE1QcDEvTXpBV3ZobzZVRjIz?=
 =?utf-8?B?aUdlOHdWbUt0aFREUm9RbnE3Y3psQjRlZ2d6NG9KT2RzWjNoZWlXUFAyNlA0?=
 =?utf-8?B?UjFqTmU3dkd4OGpad1FneFlrN1QxUDlYSUxXakNENWFKRk9xYkI2YU1pYlRu?=
 =?utf-8?B?R2hsbEZxT0VXK3FWSWJPaHQ5dzRuN1BSSkFac1ZnajlYb3BOZ3QwbmR6bVdj?=
 =?utf-8?B?MzhxcTBHM05WNzBteFl3RytaeUgvV0gwWVZXOS8zRDB6WllJS1hNTHRDYVRV?=
 =?utf-8?B?QS9tWWQwbkw1NVlRNER6YS91QmhWZG1JcEdaT1ZsM1gxWjN2QVZWYVFRNEpT?=
 =?utf-8?B?ejh1eGNseGltTGgyejVTODIwNlJFYmRtNzNydDVaUktGWlJiRUVLRlN0SmZh?=
 =?utf-8?B?MmpNNER3Vi9UUmhZeHBOa1J4dWhIZzVCS0MyMC9aMitEZTdVT05uVHA2Tk4z?=
 =?utf-8?B?Y0ZkSDNRK0k1aVBvVW5Ia0FENjNRWUs1M3FLYlpIYjZBTE9xWXcrREJocVFp?=
 =?utf-8?B?TUQ2SnFjQzRWZm5BWEFEYUhQdytwd3EyVWE3MFVqcVNWb1dSOWEzbkxjSzY4?=
 =?utf-8?B?WFBEZzVlMXlZV2RkU2lxUWhIOUk1dFcrTTZLblRaY3dPZ21BNVU1SnNlVWJD?=
 =?utf-8?B?Ujlmb0ppMU5WNkhWbldxVVdRNGhkbUE0ZUVMSWpFSnV1T3lLK0xucGZac21Q?=
 =?utf-8?B?YWMrNWQ2cE1sQ0w2OHY0SjlzR3FvcjZ4UG1yRUJaQXBmanM2U29YdUI5TThF?=
 =?utf-8?B?VHRUTDFmQk9pNGEvd2gzQk93TmEzWEdEWWl1bUVqNXEvQzV1UUtOVTdDWnZI?=
 =?utf-8?B?UmFBZTJZSTBJWEVTNEFCS2VsVHQ0V1ZSTDJBeTVDS2c2MzVSN3pkQTZjYmlN?=
 =?utf-8?B?Q011MVR3MjJ2YjhiZUhOalNBRXR4RGhtdmRtRTZnR3VCaSt1UTZ4SHBRWHVY?=
 =?utf-8?B?TVZDaHFkTkpnV2htS3J2SUZ0bE9jR3NJOUlESmJXQjhzd1g5TkhuUEF0NkxL?=
 =?utf-8?B?QXFZWjRqQU1Rc2thSHVZeUZwejEzWTRmRTJmckhCSTQ5ZFo0ZWhvVzZ0eTMx?=
 =?utf-8?Q?c7dRnSY6nnvP+rlWgIrnGuZEe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7c2b81-4f9c-4a7f-9453-08da8c0a294b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 11:07:30.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG2MZNiDGomkzxywk6tqpQLZKghOcERernCZuelBtkLO4BLKKcq3FRwY6V4zEf/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

Well please adjust the subject line, that should read something like 
"drm/amd/display:..." or "drm/amdgpu:...".

Am 01.09.22 um 11:11 schrieb Asher Song:
> To eliminate the following compiling error, guard if clause.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'commit_planes_for_stream':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3521:2: error: this 'if' clause does not guard... [-Werror=misleading-indentation]
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3523:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
> if (update_type != UPDATE_TYPE_FAST)
> ^~
>
> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index b49237390cce..66072ac1bb4f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3505,11 +3505,12 @@ static void commit_planes_for_stream(struct dc *dc,
>   					top_pipe_to_program->stream_res.tg);
>   		}
>   
> -	if (update_type != UPDATE_TYPE_FAST)
> +	if (update_type != UPDATE_TYPE_FAST){
>   		dc->hwss.post_unlock_program_front_end(dc, context);
>   		if (update_type != UPDATE_TYPE_FAST)
>   			if (dc->hwss.commit_subvp_config)
>   				dc->hwss.commit_subvp_config(dc, context);
> +	}

That looks like a step into the right directly, but please re-read the code:

if (update_type != UPDATE_TYPE_FAST) {
....
     if (update_type != UPDATE_TYPE_FAST)
     ....
}

That's certainly still not correct.

Regards,
Christian.


>   
>   	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
>   	 * move the SubVP lock to after the phantom pipes have been setup

