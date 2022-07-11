Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84069C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 18:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33FD90996;
	Mon, 11 Jul 2022 18:50:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA539098F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 18:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvTdeaJ9Eh8eiodUePsCfEfNrA4hs5WiBVaD6PaMOBPI2V/DOFMR5x0zrZQgS97gR0LQx1kFIn4VTTAoZRvsWZcpltbM1zjQsIia5SG6+MgbL/ll/6Y7IZaLBzG2Kbkj4i7hF9ySm+t8GymlMCYogVrpan9NHw70krttvwHalOSqt+o8rr0wC6nmxFHAIDAm/Q1d88LPNjSP8+KnooRYT7o1NlSsnqACtDsoimCk+QikMe6RVgFmDTtATL3oVMvfnZU+tGBHCEeCKf7E8kQjqJHBGKMxlC0WDaDT7+V0KZxvB/bNlCfwHepngynDzR1BoWckWq3GwEne1VPNWK99uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59qbtsp9XYXXSGkqcJpIhfpNKpuncQTPF7aefNxx/NA=;
 b=jGZCqEqGo1IHa+NzxPiBRGYrmd4phgD8ts2Hxpm5cFX/zorREBsHYw6G5z9MYA8xpi/1hNbcANHgnbmVTfGGUJ46TveK2hu2sYGkrHOKZ9VqGT51XF188SEaTa7F5Pa17xXL8dAC18tCSqurocz+DsUB6Ftm/Ft4iWkto4jcuOpe47ErgBLV59zZaOtGrkdLAQv8DDseZKlC4/In+v7AdUwkRIJ67/kNdrxC7GnAFazq+5iYvY3KRFWkni41MHWJ9P8QaOIQFkxS1khblb6OPunZfOhwbc1Wl+iZqubggDUNgyKO6i8MuSBbZadeHaDnCQQIeo56hrjmFiRvaf8pCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59qbtsp9XYXXSGkqcJpIhfpNKpuncQTPF7aefNxx/NA=;
 b=eJQjPVbT2dAlIZ/6lMBOSe0qMGIITquqmU0gs0b7buDUxc/w20kvEXsW1F0iuhIybjUeQ/qysJRKZMui8M0YElxb36QeG+i16oQ38x2ZRNWnDdNIKnXaR6Jm/PdH4d2w+6jMLhywtTU0EWs9pg1xFqyt2CFKW/xbEExS4GKXWX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 18:50:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:50:06 +0000
Message-ID: <34ae6a3c-2f0e-7826-5e3c-f702909fb57f@amd.com>
Date: Mon, 11 Jul 2022 14:50:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: bump KFD version for unified ctx save/restore
 memory
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220711184153.135021-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220711184153.135021-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:208:178::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 182b0e17-e7ce-4f84-ae4f-08da636e2bfe
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ/EeFTKmqf9J6qyKg1tZQtY9Gn9qLTAJxDppyJuKdFoPuvdjFCun8cRmA12u+fF90d419ldqaQ4oaQqu7RhWJMTD1k8s3hSIzIKYbto7gF4sU0Go34Ljo/K2H0kTu50TUJT69KUN59VhsifYEzse4LhCQafq/OFURW62WowVckJ6dd8IGZkEaxgpIQaYuVrftXEo0s4up5Rsn5c4Ixl4i3ICje2DBWb3TAwkhM4Wef2fyIR/X1fYL0D7Qk8rPY4FxJ/Z6bOLMrs9uPpJxR2KxbgHfx7DoCJnymFWYhc2FayuAP2wWXKBbT0muFuzTE1/XsRUw7k8/Csb56Tsah8n97qjY19dBp4BbiCzc4g7phCGRIWrezOe4LcKnD6xGDFk+C0yc5dsQXdjgxWfMUKdhdCPtmv5nys39P70yKUyDer2Vy0ySgtUy4+AanUAUXEsYxM0zXiO27EHNWEy2xTiQdS20RpqaFgkSuffuKxplCD0Fda8KG2AN93yg4Utq7ia+zlcp7IZMEECO1XykTrF4Fsxpx1BrEpCtImH/tJI1/ebzyg9c8I+fatsK1qmfrlxXMXDhbY51YQgG4emQb78rSyvYWD0pl0H6wJ6uioYK3IwSrLhhwVnM/6U8NCexnpLjAN/aiPoUzucfltYrKzCrYJ8DhczPiF0jBbQRjwD6/03I2MJ7cgxScHovdDybCJbDZHQEe2IFbANGi33oG0OD9kQGoeyfyv4R5SJ85xD+bjV4S4Ln0XPL7Gp9TftawoWxCXGKAZEKrGNIgnSDLTyIHLVFxycBK8pFqZFTvwiuEhZj2NH1cGZXnPaXYhLDgesxwRBeCj8Fa8vRVqdnpB65DxHLQA5XKHy6TZwwyMdRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(8936002)(44832011)(5660300002)(4744005)(2906002)(6506007)(6512007)(83380400001)(31696002)(478600001)(86362001)(6486002)(8676002)(66556008)(316002)(26005)(66946007)(66476007)(53546011)(36916002)(31686004)(41300700001)(36756003)(38100700002)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlzYkg2aGtTWTF0YVNpMVlhamJYT2IwMGVGOHNqdk5yS3BFMG9zZlkwMlN1?=
 =?utf-8?B?THZySG92Vm92LzhQNDBtb0hnSkhvNG92YyszT3BYT0lOaWhsekFjTkM2Z2tt?=
 =?utf-8?B?dFVHUzVFZW8vakRHQm96Y3dnYjlLSVZsaFZJaFZoc3c1WDhzQlpETld0VGxv?=
 =?utf-8?B?QW81NXhMMHJtQk00UjlDYlhqZmFBaWRiVExYeWNaTjA3bVBBWS8xemNobzhz?=
 =?utf-8?B?R01ycWpIeGx5Y2ZrNk51R2IwSWN0bHhzajRYVUVQQTg1SHlHZ2hVaWduVlI2?=
 =?utf-8?B?LzRGLy9tTmNsWmRzVlF0bWFOenBLL2duRldFWENnQ2hzRE0yT1RlaWQramx4?=
 =?utf-8?B?Q2ZUTFZzQUJVQ292QkczVnU1bnJkY3gwQ2NIMFNCaEovaE85NmdHemZaVWVO?=
 =?utf-8?B?K0ExemZpMXM5UkxYYzZhL1hIVC9UTy9xNnpqb0podGxwbUJicXBPemxRZkNk?=
 =?utf-8?B?QUNabGFwWjZ3MFNtWHNsdEV4bDJ6NmlrZmlLeXdSYkp2STZDejRlcXh2bVFH?=
 =?utf-8?B?ZjFQNDZ6YXFhTDNNbGFUMk4wSWU0WXpOUllpdUk0d0doNUd4R0w4VmRmeTh5?=
 =?utf-8?B?ZGZIeTdzZEh1ay9XSXJKVDZGcVdwaUJ5K2ZTSGlQeVUrSmFPc1BnM0RlNXdS?=
 =?utf-8?B?Y1NFTVN0ODlTTm9LZ0xjakNTVUhOa2RuVWxJSjV5RTBZOHBwb1h0d2Q2Tkxj?=
 =?utf-8?B?U3JqTUxFL0p0RDVoS2FTdHBXT0VaTFNzRVBaUzhEbGs0ZTloaGtGNzV0dERm?=
 =?utf-8?B?bnR3YmlPTUJTOTRaaDg3bWIzay9od2ZYNEYrSFRxSE1VQmFsbFhnS1pCUGpB?=
 =?utf-8?B?YWw1ODJTZDhLT08vVStIbngrbUk1ejRKaERxbkw1M2NmS1lFSSs4bTlBOWM5?=
 =?utf-8?B?Y2ZVYVNWVE5QSEp4bU1zK3M1QkZHS0hqcmZTRWhVSDRVY3M5d1dCUmRvRys4?=
 =?utf-8?B?ekxjZVNwQzF3aHFsU3FWRFRQWVhMZWRDaTRWRlpCeHRMTnFudjlmTG9DVVQy?=
 =?utf-8?B?RWV1djVJdi80eDl1Q0ZnY1k3aUtnekkxSTZBNTVEaE55ZzV1UlREV0JWLzU4?=
 =?utf-8?B?WU9JU01CcGdpdDhTb1VYK0puUW9qeEhmZGJPeWNId29ZYi8zTGNSYUhQdDdo?=
 =?utf-8?B?elVNWEp4Sm01Yk1aZE85aUxncGJSNUEwcE5sZk1TYXhvU3RXQ2R5VUNUMUNh?=
 =?utf-8?B?bmh0MU8zMVRzUEtCTTJTQVRPZkhpNWtrbG0xWDBlS1lmc2FIdVhVMVRlRmNS?=
 =?utf-8?B?VXdWaVVCOVdnMzVoQUxqNUFRMnJTdG13djZiZ2Zwd3NnQTJad2gyaGIreFBn?=
 =?utf-8?B?REpFY3ZaamdyWEVheXpvWG56djNnNG9UQTgwRnBlTk5Ma1lJeG5XQjI2Sms4?=
 =?utf-8?B?NUhRcnZ5S09iT1ZWYVE0dVNTbUM2TUFuYnA4NWUzanRIenZycWZubnVpRGdN?=
 =?utf-8?B?VGM1L1MxRDhTUGZlNE51NndtSlBDSnJDQmtJMDN5bmJ6dWlGLzRLeTZia1N4?=
 =?utf-8?B?ZTVxTFdYK2llakplV0xoSkRneE1MeE1PaEludXRtaGc3c2tpTTNZZ1l3VjF6?=
 =?utf-8?B?aDhPK3RSSVJWamRGOUxVK2RuV0I1ZmJRLzFSbE9IRVhURENXMi9VaDVNT3hD?=
 =?utf-8?B?UE9BamFReVZEdGl4QjBTR00yblZ5WTZnUlB6ekJOVTQ4TllQZWhFaUxaNXVj?=
 =?utf-8?B?WHFJVlhjd0w0eFBQS1YrbWlqOVZxYURkellYaTZES2ViZGIza1lTcjV3RzJ5?=
 =?utf-8?B?cjNud1pDZmxNbkpic2JmVFhxanlYb1hlSHF0ZHRoSCtHNkJWYmI0L2JtcmJX?=
 =?utf-8?B?TjlRZzN0UU1pN2YyVGo3Uit6N29TSWhBOUtCblJodGF2S1YrZ0w5cWlSRkEz?=
 =?utf-8?B?eEdxQUsyaEN4M1VXUXJVQnNRZjdBZklhU3ovTW9YcTJCNVBPaVVxdVpIZmJq?=
 =?utf-8?B?L2FpUXZqbi8yTFJPN2JWM0l2RW9ZVTBJeXRYalhLMXpPcE56aWFPVVFqTFhZ?=
 =?utf-8?B?YVBkT2VOSlNzL3BaczZzMVRiSmdNMGp0VGhTbHlCaWpjbUYxbUZVQVZLTXNh?=
 =?utf-8?B?aFMxMWVXaTdQR0pMYXBTMFZHL3VkQzlmRkswby9JMmdGNTJ6cVUyeXFGcy9r?=
 =?utf-8?Q?zyLaU2VGDbF/imjfWm2d8T4PI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182b0e17-e7ce-4f84-ae4f-08da636e2bfe
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 18:50:06.4341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu9cOz6yRBGi+idBM9mZN6zN8QS65a4+LhkBd8s+P333jsBLHnT6LWajZZCNRIZL8BD9E2N7FhS762SwwXzNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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

On 2022-07-11 14:41, Eric Huang wrote:
> To expose unified memory for ctx save/resotre area feature
> availablity to libhsakmt.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   include/uapi/linux/kfd_ioctl.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 7a423855a86e..afd8ff29c74f 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -36,9 +36,10 @@
>    * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
>    * - 1.9 - Add available memory ioctl
>    * - 1.10 - Add SMI profiler event log
> + * - 1.11 - Add unified memory for ctx save/restore area
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 10
> +#define KFD_IOCTL_MINOR_VERSION 11
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
