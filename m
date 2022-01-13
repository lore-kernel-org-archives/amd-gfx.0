Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 12:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC8A10FBC8;
	Thu, 13 Jan 2022 12:19:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8747C10FBC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 12:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQxJcdMAWyTWJthPHq5OPhE0Vc6kb6Q4N02Dss5fedthxncodIHxCuJkVVwbWo3HdhQqf4TPSQyPn+f/2Hr2veJ6gDrNDBDTyyq1cZStMy6RWvDtFzatn5RupswV04oQwo/LMTk+lKGzHPTIEe95CyXhrPU9hFmRTwPhysDnWreNsfp7XEvUKnklRHwAeLog615NaRTfhvXWqxHlyc9C+0QjmRGE0AA7HElpv/NJw+EQsjdnk5nDEgkHPxJTQmBemVCaFNy0e7vNWJaXImFMOSx6wwXVqeujL8LeeigXrvsk6wYtLPvP7WfUCaiQS5rL7CXgL4rZ3wldVa5hQEb/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWFYqI3qO3IVM7XBskTPDSHhNlY59vpJhTSyXWDahCk=;
 b=ogbfCWRmh1V7F8UZ5M0KLZQreqoa0JZL0iw7/lucy+FX4ZOIqIaGg/l6nInrasOm+CBCwC/fdWv0HCAEpC1JJx5/A+Ns+MXq0IDgNC+A53j+AYLKUyEa+HYRWch/ampAjK9qY2v66q9MNkgVI/0UgRYOanWx8FR04GJzMZc8t8QmF2VVNPz4MUq1Tnf6QR4e8IPH/xojXxk02E4qH+pj5tMQyqe0MYsV/jxoihuya5l+2pn1Wnomro23IH8Wt8Un6zAuck6CpeSlCmC1woeNnNgIScbzMW5iFUzpTmSgkhKQYKbgpacHLHnSWOv8hVvOZ95iq1wdxvAnPaAUqUd3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWFYqI3qO3IVM7XBskTPDSHhNlY59vpJhTSyXWDahCk=;
 b=lHJljEcbq47APVd8FFN7zGpVHCpzINOpGHWNcozZ0WEqCxLD128bCMy0d0Xs/UFQXOYTpF+uMO2mY5sP2DIBATDXe8P7cdbO/adc9/oozKAtn/Frf6Dt8a6M1ZKQZYM7L5PdL2tgdRShCMM3r5aC+XoufHUOOGxzYeVQVciyWeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 12:19:07 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 12:19:07 +0000
Message-ID: <1abe3b22-1886-3c2e-4c22-534008996dde@amd.com>
Date: Thu, 13 Jan 2022 13:19:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] drm/amdgpu: Indent some if statements
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220113061734.GA4735@kili>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <20220113061734.GA4735@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f9d9388-4c77-4a7d-e88e-08d9d68ee513
X-MS-TrafficTypeDiagnostic: BY5PR12MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB387361FDC1470AA29E07BBA08B539@BY5PR12MB3873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvyOv0lW8ZlW/h0cDoijXtl2GPo4xWaJ2ZqJpIf1RhDiNKKaB9ibYtodnea1cfodnFOc6IcKCAgH71QWASlXjDszc4YvekfMNpjWL3TYZ53aiHpM5AR3yB1MKZSMn4GdzX4r/87/W3ecybQNNqfKtgDerBEyNAWi31MDUaoKsL0GI2XcmrdOPI1FB4bQSuQ/qkL0ojuviipyiKU4THcmm80RRz9XEGq6zUK08R9QNDg0MgPyTDcN4ovrKVKSS1rqsePtSki36d4OLczwSjogKTKa8ilItH5q2iGUJZRHm7gYrwsWzOb+b7666Z3IiqcW2l2uZMMR6vFl9AaSl70B86lmakdueUp7V3X6wtQqBbo//qjMBYKwvkCHTXk+VvInr7NNRaDjWQIgTJKY7n8/CA3M7uF2R33ACNolpFRTe2XlESiqje5vE1YnVzNJOwfcOriLnt9CPMHQo/ILlN6gXOBkAfCTr5N5NlNdxbPW1EpHFkjiCF4tj8RVRyTKzIa2n8YHWl6RnktJjm0saLVYlhQ1H8Tj2z4ODJ2GER9f89TmQU2SzJ9IMI9xHTyO6w6HZsj0Mf7Kc/WVv1vuVjZXmXglcFCTLFwwicgujYvG8liS3HZ2xDFHU/eG4RmH1k5DdmdDMwhmzEHMRnk7yJok/9Sf425OJ4d+JoO3u3b1tD0SMi4/hImXYgtwXIUpG5b0epO2q9JiqFrL7hzUijv5aaRJWxbOxmEikGZqkqERjdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(5660300002)(31696002)(508600001)(53546011)(6506007)(54906003)(8936002)(38100700002)(8676002)(83380400001)(6512007)(316002)(4326008)(6636002)(110136005)(31686004)(6666004)(66946007)(86362001)(2616005)(26005)(6486002)(66556008)(66476007)(36756003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlIzSHV5b1VkSmxGa3JGMjFaWDFnYUZVZUJRbkVuT0R1bEpwQm02T3JXMzdZ?=
 =?utf-8?B?NGdGbG1XTXZZaWRmanN3RzFwWmc0MkdqRUFQbmdzSTMzdnQ5QXlOdTdhRWVK?=
 =?utf-8?B?dGV0MDBKNWxtUndiQ1ZpTXV2OGlGWm12NFBJaytScXZiS0NUdlBQcE0wVHBl?=
 =?utf-8?B?NU9rSkJPbnE4S1VRbHBkbTdZY1BUdG5RMUthZys2bXBMRHpwZXBGS0lsODA5?=
 =?utf-8?B?cnpvTXU4dVdKVktNN04ydTZHbEhrTVRDUVF1UFl2bVc5U2xxR1lMRkE3cHc5?=
 =?utf-8?B?R3JtQ0E2c1owOFNtbzlrcXJDUzhyOUhQK3AyRGNtU3VpeEZsR2hxYm1KeUtO?=
 =?utf-8?B?N2dFditiOFZ6YkpiTWpsMEdzUUk1S0tON2RGVTQzcDRnYkgyQS9KQm1OY2Y5?=
 =?utf-8?B?ZEE2TEdHcG1mNWNwdlFVU0NzTVMyN005ZGFKRk1SR3ZPM3YvQnZpN0NlTEhz?=
 =?utf-8?B?bHFCSGlkVlFkYjk5QlZZNlVzUUxFbGNYcUJVL3pmNkZSMTdTRUdnZ0xaNHMx?=
 =?utf-8?B?VUFDSU9ocWNCbVdDZTN6YTQ0bi93VGh5RHkyWE9mbGZYTGUwYkR0bWExb3ls?=
 =?utf-8?B?WE0yRjJwVnFObE9GdlRPUWp6Z1lVYWZ5bGppTEQyTldPNXNTZUtudU41aGk3?=
 =?utf-8?B?Z2xGenNLSlg5WWg4aVg4TUlwSW0yNkc5bkZZSzd3VmdISmVzeCtWbG5tdWhF?=
 =?utf-8?B?VWtldU11NmtPcW9MMjVyeDc1MStURzBBNGRUQSszUEp2L0dETjRWeVRUcEt6?=
 =?utf-8?B?c0VOQ0FJZmZOV3FmL2ZFY1FOUHVHUFN4VW5XMVNTOEZkMVpNWG1GOVdhTWwv?=
 =?utf-8?B?NmFKT3Q5QmxqSDFqcmIxMnBpSEYwekFtTkxnMkJpand2QVFnN0RtRDRiN2hZ?=
 =?utf-8?B?TnBSZDI1Q0ovVWZQazYyelB2R3JiTkR3eEFsNTMyQ2x4UHdWTk9EV3p4MVQw?=
 =?utf-8?B?dkVXNE83NkhCZjZmY3RhYlkrSnlpNUUwWWtPSDlFUExkQkZhc0huMnRiRXFT?=
 =?utf-8?B?WEdkYVVEeW11Y0EzcUFWaFJ0dm9YQ01NaDF3UWZVQWJUUkRKdFlGckJqQkVY?=
 =?utf-8?B?eUhoaVMyb2FGb2JRNWJPb3FxQWFBTEMyWWdNdHJuN2xETmd1eUhkVGV5NmtZ?=
 =?utf-8?B?MEZsQkRMbGUwY05SQk5veThWWVNPbjJPQThyS3MzdXY3a21QUERpdkZOd3Zp?=
 =?utf-8?B?WkcrM0l0UVJVTWFwamphaTVCRmxZWkNhUEUzYW5BL21IUXlFVXIzYmREc0Uz?=
 =?utf-8?B?a29tK09ONVY4YzZyQURMZUpLMFlGVGFzOUo4aFZRMVBxbUZudWZJOXVpT1px?=
 =?utf-8?B?QVN5dTdTOTRkNXhDNnRwRGVPVDkrSitVSjlQaDR6SHd6Y0Q5ZFdVc05CaVM1?=
 =?utf-8?B?M1BwQWFLQU1KaW1CTWNySGFRVlgxWDY3cmNkTldIYkp6cFhveE5lZXkzZitB?=
 =?utf-8?B?bWJUREJ2akdCb1d0QkRWZmhLTmtxNzExczdERlhPajI0K0pYM2FFbUpFTVEy?=
 =?utf-8?B?bWU5UjVCYWF1anZoMnJzRVkrYmlRMEVuVzFrQldBQVBhN3JOM2hXeGV5ZnlE?=
 =?utf-8?B?SEZudE9JR081TktxVjQ1endMU2IvRVNjMFBzS1JoMFRvSXFVck9MT3E3UEg5?=
 =?utf-8?B?L2dHc081TWxiM0Rid2xNd2FiaXJCa1d5cU1Ea2VkanRzNDNaZGhqdkwwMnhM?=
 =?utf-8?B?ZE1Ba0w4ZEFNTURvQXozWlFnT0hJK1ErbHdtNWVpdWRWdjdLdHBoM3YycndD?=
 =?utf-8?B?SFg2a2pUWUlla2dhVkNGMXFnbmxGbEk3UjEzQUVwbzJCR2R2a3JYMGFBaVNi?=
 =?utf-8?B?OUpkRjJkVVY3MW82cGZVTTlPcDM1eU9DV1VWSEM3dlVLR1VZOEFYdStZLzNk?=
 =?utf-8?B?NkVGUEFjMWFrYk5mN094VTM2eENkK3QwQVdzblNILzB4UUxiS21JcGxxRFJ6?=
 =?utf-8?B?ZTVSK2hvYWZvVnFXdU0vSGtkM1JDcHk5cDRBREdsL0s0Q2ZTeUxJVlJLR3Ni?=
 =?utf-8?B?aHk1c3U5eTVsUHlxazBzZlhLWnh0bWYrNEtoN1RZbmU1eFVLZXhxSHJENWF2?=
 =?utf-8?B?WVk1c0VpWXl3WmtteEdadXhOM2kvT3hEc0JiZlZ4elZhMTdwMEJnVUwxWTJM?=
 =?utf-8?B?allVaDFUQVl0TVI1N2dsSHIwN1ZnYWNDaUVjZkVRY2lPY3N5dlQ5T2pEY2JD?=
 =?utf-8?Q?C+++5+fuUTj25kXhdoMPsLE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9d9388-4c77-4a7d-e88e-08d9d68ee513
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 12:19:06.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jELtg8JLSEvUerSGRwVBFr9vKUXYFaeRL9ti105FC1ubLTJR007ocPiFCSUFsgUU6Sl0nR448JCCRWcWePGckA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 yipechai <YiPeng.Chai@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 "Stanley.Yang" <Stanley.Yang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Clements <john.clements@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 1/13/2022 7:17 AM, Dan Carpenter wrote:
> These if statements need to be indented.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index d4d9b9ea8bbd..777def770dc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1714,8 +1714,7 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
>   	}
>   
>   	if (block_obj->hw_ops->query_ras_error_status)
> -	block_obj->hw_ops->query_ras_error_status(adev);
> -
> +		block_obj->hw_ops->query_ras_error_status(adev);
>   }
>   
>   static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
> @@ -2722,7 +2721,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
>   int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras* ras_con)
>   {
>   	if (!adev)
> -	return -EINVAL;;
> +		return -EINVAL;
>   
>   	adev->psp.ras_context.ras = ras_con;
>   	return 0;
