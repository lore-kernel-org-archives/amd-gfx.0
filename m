Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF22C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 13:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02A261057
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 13:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02A261057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478116E245;
	Thu, 20 May 2021 13:51:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BE26E245
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 13:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgyLmkwSHRdvNNZEeH3Qkdy4DlX8HKyiCJFAYF7vmb49xJIB4UyHm8W0xmW5Ol4dC8VTna92Jud+1+Qh0lnJ3SnuYx8aB+XOh9Ju0lhVE6ILtPtoMS3xXcjFUBsuEN/1n65zXXpMKndZiixGqhr4OC7m0Q1BvMrlIY1cT3BjkjmuKtn/fsdx9U3fPSYsoDpNK+gbPUPrq8cGLNboYw9zOaFOkGSbTnf95ltwFDEcEgQ3yOnScqVRuJO5qA3dgWTl6aSa9pikb4KpQI+7T3pKcxTHWEXNFVrew/RIcWQawU4E070r+7Xs5tauQ1iGy1g3HLGqfpoyeceOybJvDkAAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r73A5J7GRGZnIEvSXdZwSUzBqW2914bQzqja9JXKcEw=;
 b=fetKxya10syw3qGvfLvpi8LXrsK7lZDglGVOSi1nxaXVWSvYJi57wRCLKoMIe6yicHYW3obrLaRKftOsHMu3BRuWMGssGG3qkcjK5r7lAFVrFqYBGXva4W+06AM0Ubpsev0UyBo9mdNJIB0ZFlL5f5e7t6Fw5RVPCdYgCDdEiJrn0vBaSXSysV/qYLEG7yX1/gVIxkWtaDo4hGl3U/9P59RyV9GF+SCY2x5meNkdcA+cT1M8q4XKCeon1dIZ0J/j1dMR5yp9xmOuoxUPstCdGx2M+UzM9EgBEhCR7GtLg5LS+NpulKCblnq9GbZF7aA1GBqEE7KVvDDv9GCW54mR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r73A5J7GRGZnIEvSXdZwSUzBqW2914bQzqja9JXKcEw=;
 b=A3vn/S91ISMdyxN8yj8BvB6k+fjpwZ78J0ezVfylMQbPJHGTOxWsFZ/j24Uh2hbiU57SJ8y10Kuc6GVfutwRHpRczW0+Usz6vGApTVdZay5/yjSGiaPs4K8zJGMiGlR4xY9YWV3VKVQ+JgcNi0RIun/p3XqigdSa1SHvcOJULDw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 13:51:04 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 13:51:04 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <6ce3bd0a-8454-e631-72b4-9d518332aab5@amd.com>
Date: Thu, 20 May 2021 09:51:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:e033:e6:5ec4:34d]
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:e033:e6:5ec4:34d]
 (2607:9880:2088:19:e033:e6:5ec4:34d) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 13:51:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e70cbde-750f-4f5b-1b5a-08d91b964f26
X-MS-TrafficTypeDiagnostic: DM5PR12MB1916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1916FFD89AE0673F5B990688E52A9@DM5PR12MB1916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwhQxrHkiVSy18AOn6ZqSlBFahaKIA6cW0HFXT0ENS4m0DrgyA45MZ8pmFv6IUyCcvblkPJSEBhItw7sqS0lySANQgMupLbYBqbXWjoAxKyzlz2WGrmwpPNRmZziemKpuVZIFVddjkbh2qGgYTJ9Fwt8gZ6nKOg1Igdafr/yi5Iz6umnPUiX6J8L1uHsWy6cGgm4JSGPoYO5Fa7lwQf2/i95JlVOupa6N1nMeC9UzhDPMox4LtHFe6h4W3rWlrWFOVplpkTeySCdVOKMqovfwNGn0+e5ceAPyecCZUtWjnx3YouT8ZDNQ5ibXz6XXjI1h6lJ02pgsaUi9PBBok0nXyFszGzKdtOPMhgj0+svJRMgb5D3y+twXoFGvwtSsxgeA2JBy0KK1OiEfEMj/3CBbpjy15pTXZk9EhhAX874j0j+LLO0Lgv+HYhUK8Lk+i50jhFkmkbRFefQcJJRZJFu3rCuwwT38S7FHoUtdjA6+OonZc/rpqknveFtIqxt9Gtc3NkoiHSiLl3oHzIE8tXA+eKc5Vzm7YXui/7GNTl22IhObBBxUBSa63gCiZ+D6RptcIbvCZwKZimHA5fSMzFGmMS7wZ6irvWIMYb0iYBgwDVCx9oMeZtN5b1CJ6qRc/oKNtJRpng0Ou2ZgmsgyPzxgRMzuAhnhHM4BqMAHkPoFr52aXiTsO1aGM0L5TL4ujAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(4326008)(52116002)(2616005)(316002)(53546011)(31696002)(5660300002)(66946007)(66556008)(66476007)(6486002)(86362001)(2906002)(186003)(8936002)(83380400001)(36756003)(478600001)(44832011)(38100700002)(8676002)(31686004)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aCtOQzhVTjh1anlFazM1b0ZEVEdCVTgyRFI5dU9QOFltL3hRMmpPYnRxeUpr?=
 =?utf-8?B?RUNzWmlZdjhIVzl2aitjUW9udHo4aGE3YUdURlh1MHc3MC9xSjhPQjIyKzBI?=
 =?utf-8?B?K1pVVmFSV1VkQldoTVk5STZSNUdxS0xONXZWZGluUUdaaU1yc0dnS1lrWDhQ?=
 =?utf-8?B?ZnI4RDZNVWR1TmRkUCtIUklDZk5Xbm8rVEpJam1pZEw2a0syMjA4Vm5YUDM3?=
 =?utf-8?B?UmhsT1M3WHhiVTVhdDFONnBrcC8zb1dac0VzWEw3RTVzdWhkSVFGL2swdi93?=
 =?utf-8?B?bkk2WTZlWmhSMHRiR2xQdWJPTEw3Z0RudHZWQmVRc21UbTJaNUtySktFa21j?=
 =?utf-8?B?VSs2UTQ1aEhxdWt6dmtaRGlGK3A5citGaW90dFhhMGdNbUgwTzRTcTN3Q2Y2?=
 =?utf-8?B?Nm41VzRuN2trVEFEcEI4WkVvNlQwT3ROYTM5Znp0aXJXNzJmVXlyNHZMcXNJ?=
 =?utf-8?B?dmE5M0VYc1BNRHJVSHhVOU8wRFBlaE9NUEtjenVJTXRNc09KclBwYkhyejhD?=
 =?utf-8?B?bXJodVFHWlY1N3FRTmNjckFTUWhaWnhBUXBMaE93SGoyVDlqR1c4K1d0b3d0?=
 =?utf-8?B?SFBuRGdWZ3BSb2VwSmdVS0RvMjVHK3QxaTdVZ21aZWRaS0s1MzZncjlYSTg1?=
 =?utf-8?B?cUlsRWxPNkI0R2ttdS9FYWFjZUx6UDlPdW9iN2E2R3JwZDRRa2JZOXVMQ2ZK?=
 =?utf-8?B?NDQ0UXY3T3A3VnJCcmJxbVErbC9qVFFiUkpRazdpQXFMQ2FvUE9mdmtGeGFY?=
 =?utf-8?B?NzRYUlRQNnFoTEd2WTBsZUtoeG5MYU5jWU5TQ1RtOFlZVi9oL0RVbnhlZlpa?=
 =?utf-8?B?WUJBTDBzb2dSc3RrTkxZOC84TlV2SWRzMnZFbm12SWNrUUhnNDJURFpDUzBp?=
 =?utf-8?B?RTgrNlhzUDB2bWUySzNEdzNCclRlT2pXOXhQRjIvZDhsS05DQStXM09XM1ZI?=
 =?utf-8?B?TTdJTzEvcXpPeVhRWXpPVHVWR0ttWUxGQXVBMDdRZnZoZGtRR2VhVCt2a3p3?=
 =?utf-8?B?cEtnVVFsMnI3cS9JWkJod0RId2tCbDQrUCtTVVJkV3NTSlp1ZVlsZEJveWdE?=
 =?utf-8?B?d0t1ekNTRzZSdm8yVEZ1SWhSNm52cUU4bDRreVROY1FXWHdSdzFvYUdIbk1k?=
 =?utf-8?B?QmlCNEg0b25PR0dqd1llVitZRzZ4SjV4aVQ5b3RGU3B0enZtbkZaZWMyZHhJ?=
 =?utf-8?B?QTlwSXVybXc2OWk4RHBHanpIVmc4Ly9wTzdCMEdNZzhCYjFQbkR0SWI5U3VK?=
 =?utf-8?B?dkVSMW1QTW9hQkhIWFRoVlVSUHdLU0lnV3d1N3VnSE83ZzJtYmlYZWM0ODQr?=
 =?utf-8?B?WmxXMkNuRlZpWWIrM3lSakFvUERmelpHdExSQmhqaHh5WForVC9KdFRDdDVz?=
 =?utf-8?B?Y2tjemNKbklsTUNhdjIxN0ltLzlGMEtuL2oyOFVIT1JWcW5ocUROc3Zscllx?=
 =?utf-8?B?ZVl1QW1MVlJhTndodlBEM3ROd3YrSFNKWE9hcHM4QTB6V25JYTFEdU1JMyt3?=
 =?utf-8?B?T2ttTGZJc1B5dGlmTG5RTUpXNDdKalFlZDlwR1o2LzVOaEtmQVRodFNvYVR2?=
 =?utf-8?B?SDZBZmNWZ0M5TGM0VmFOTURsWEZkbzdpd0g5allUeHQzRVF5dnExR2E2eTEz?=
 =?utf-8?B?aVJiczJhZFhJRm5lVmI2K2VBNzlvVHRmM2NxK04xdWhzbjhLQXE0aEVoMlpx?=
 =?utf-8?B?RmJleHFRSlRmai9sdmhhYllTNzhuM3htcEUwenUzSVN5MzB0elNkZ2w2Y004?=
 =?utf-8?B?Zk40ZkluYU9JbzVtaTc5dFlBTzMyOGFOUnVDUVFjQUphTWpadnNHSkoxVHBr?=
 =?utf-8?B?My82Z3NnM05FcStlemozZE42UnEzS2VuOG9kUHVvMnFNWXNvc1BIMTFPVWVl?=
 =?utf-8?Q?/Uiz7b80C3gz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e70cbde-750f-4f5b-1b5a-08d91b964f26
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 13:51:04.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyxlYbw20YCHczIu6fjDWi/Pe1aAclOoKJj4zsbHBY4NOypETOk2D+wCipxDGR7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series are:

Reviewed-by: Leo Liu <leo.liu@amd.com>


On 2021-05-19 12:22 p.m., James Zhu wrote:
> Add cancel_delayed_work_sync before set power gating state
> to avoid race condition issue when power gating.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 0c1beef..27b1ced 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -231,9 +231,13 @@ static int vcn_v1_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		RREG32_SOC15(VCN, 0, mmUVD_STATUS))
> +		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>   		vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +	}
>   
>   	return 0;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
