Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3016EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 13:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE1C10E87E;
	Fri, 14 Jul 2023 13:38:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1410E87E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 13:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GV5DXy0sk9XVEU5wCMPD88sIZQGBHhCSxfe7otycnXteSzfGJbFbts4FnF/wuUjKGO6NdNRdPTY1rGIqgR9icTD4UKGbFsPA4kcaIpp+5M2M6M1iEYPft9TnXtvutZK2WlOYLgzWOPOF9zRgq77gm5bgTRuHwjScWisYpxJYD/DXzUf/HQczZsev86PN8ACE0Pu6YddHNRbsfgIr3A24LrgpblitzGzHsc8m76C1lWzHkqacMFUHKBAul+oWj8C3yMSMEf7K81Dtvb5rvzjYf6stJLLY2XxHpJZ1HiDnyOVW1dSuwYU6se9BGFwi5vQT2EKzo9X0cvwvaSqD0q8eAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZJ4/Cxkcph9LRIAWKEmyLmuhioq420MPnPohKCRn/U=;
 b=WcWqtZIQovEDstzR/2hyvkM6i/yQEJu5UgaEm7mGMF9Ar9AwTTSvzTszbDAfjSefqeaLOZSikLnkVfeWUX3DwWErGQdFsdN9oORJ39tZBZVuIuIWoyu+YfEYBx4DTfo6LGB7CzFRGRH2LMssUX6MRLdPrhC2UyAXlzlCmaYRr/DThISCTvJFrmslRVLVCBk62C7j/Hvbo48HyzpTUi2nyKaEhMHL4BNstat2xAoJsMEzokKzABYezzaXMUKDCQa+r2YECBC+vGFm9JBbQNgKKa0LhTNMp+mwu6IkOsh4QtBFHKmgFW/Wn5tKsJ3hHKmDbY6Oy+bMpfiNi6olGbcwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZJ4/Cxkcph9LRIAWKEmyLmuhioq420MPnPohKCRn/U=;
 b=Tz8a4sR0GAwwmu+8vujji2n+qQ6ftFX8rllHTsghCDwkGDqxpHkMVaFnT4hg/XZkMshCi4lKXC76nQfoaasMqbc5nuLSw1EQRXn0eK4Cqz2or0f855yP/jYQN09uGNbszLdkWqIPap0gWF44Amy9RjU6UbEWBCwvCGrDrtejmfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 13:38:21 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 13:38:21 +0000
Message-ID: <f4d3835e-f22e-3403-e917-c23b595784c6@amd.com>
Date: Fri, 14 Jul 2023 09:38:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] drm/amdgpu: allow secure submission on VCN4 ring
To: sguttula <Suresh.Guttula@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230714094448.3178171-1-Suresh.Guttula@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20230714094448.3178171-1-Suresh.Guttula@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::17) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f40d4bc-3646-49b4-2d04-08db846f96c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckS8hjijeXJ7PgbznQ0YWBavTAnTr87/7TH5fRmpGtvHbh+z0SeDwXHJxS0TOqt6XQ6vuexDaj+88xynI6m7ZVRQpXDjgM2ugkppq8kC6OHudf+apyKaJeWfQIjfYJUxQwF+aTAMGn+KiSyvqs1KRG38NWHsNN2muWtl1Pcl0qptubDgFHAB5z2T28MMwud8p4LPXN7VPy3e3XunmUE8hzLJtjMEjgKQXbKyNkCsVlcf31TSTldMmQ1RGWGC5j/Xvd3HemorycbFYu5zS+5BYLNcAUmh+fhe6RVXy7nc1xJfMjXrLaOkLhr86vQUAuNvjHinOch/F56JV7CS8bKOn8CJb4InRXmwEuRusXuwBccvqZVQVWTZPOi3+dQfrTxgeLWrnhRhFST8VWZRfnISvvV06gEFuUmgK8iRPOH4BWIiHpjwzZvDD82tLFzNZYJRzUFOgFpbCN5S+Jwjx9oWJEKNEfKfWsn+VMFn/sacfWTRwK+Ylj97tNSo3t4biLgjLqk5+bea5OXd1qN+seyzFqjAtPhMWwsNxN1envT9eqRnvTTLc8BSyhzEL1x6dE4k3NtJIy/9UEu2NbPklbAryiXYUKbodKVNDSKAyugqIoplR5rQy3FQg4xErH6Q50rSCe1SCYmZEBFvi5RQbCOZTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(110136005)(478600001)(6666004)(6486002)(6506007)(26005)(86362001)(66946007)(316002)(53546011)(186003)(2906002)(6512007)(66476007)(41300700001)(44832011)(6636002)(4326008)(66556008)(4744005)(8936002)(8676002)(38100700002)(5660300002)(31696002)(36756003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxCWkJKczVEVmJuc0xBUXhtNGhwd0prUkN2TGRlR0RNOVdxQjZiYWV3ZFU2?=
 =?utf-8?B?K3Y2ZVNBc3NFSlBJQXN6V2NicFlYTWNONmhPelVVczAyYWZHdE56UHlRM0ky?=
 =?utf-8?B?Tzd1VG0yVXJJUHlhdWs2UGQ5K1U5Z3ZvS1pxbmd6NEl3RzVwTUJBSFRFWFNP?=
 =?utf-8?B?SlNlVWxCeURyeXRNMGwyZ0orbmlUVzU2bEgyUllGL3V3aDArT0N5MHNraWg3?=
 =?utf-8?B?N28xWE5LSjlqQ0NaYnFkSGpCMExjOHprRSsyZFB0c2ZVTlpHR0cxWVdGSjdI?=
 =?utf-8?B?T3NjUW9ZeGtIZUEzMjhTMkg2MGRGQ042dUIxS0ptb2JSUlM0cklZRXhFTjNS?=
 =?utf-8?B?bnpUaHVhdFBhMFY0SjhvL1g3WDFPeWxKU2ZNZEFoeWN2NkU1dzM5NGhQdnFp?=
 =?utf-8?B?S2pRbGZ3T3Y3ZU1wQ3RDdWJrZE4xS0xBNS9DK2RtNTIyRlVOYTdaYnRMQ1ZQ?=
 =?utf-8?B?bXAzcldjYW05ZDNnUmlLVGNkK2Vra2tIR2pGZDhOamdjUGs3N1ptTlJTZDJM?=
 =?utf-8?B?ZkdPc2lPbjQ5YTgyYWNjTzBVVXBzcmZNS0RoNlhlVnU4UzBuU2dKVEJpMEx1?=
 =?utf-8?B?L2lOczc1SmZyVjg4c2x3KzI3ZDdSeVNZVTQxMGZPU2xodXJSS21EZ2t1aSt2?=
 =?utf-8?B?ZG5PTU5qRFdJVmhBcjJ1VnR4Q05ydWxFNStkZDExTjg0bTVDcXRpenY2L3Ay?=
 =?utf-8?B?NDNvanJRZXRPeE9FaWVrVUkxNFJvOGNPdHRjU1NIZVVSVzRaTlZqaHg2Wlcz?=
 =?utf-8?B?L0FhRDRkRmEzbm1tZGJrMjgzclQ4cWhVOXdPNEx3emo1S1dIYnk2K1dPMmlv?=
 =?utf-8?B?K0VSOVFuYVp5cG04YkZKWGJCSzE0NkxuZi92Y3B5NEloeW1aZ3JiT2tGV3pM?=
 =?utf-8?B?dHJaUmNkUHFzV2RHTkt4b1prTGdtK3MweTdiS2pWNEk2OGg5ZlpVaUwxRWxH?=
 =?utf-8?B?Vk1waldCNHEzUDZaVlpQZzNUR1JSTVE2UkJ3aEJUam1tOHRpa3Fpa3lISDVQ?=
 =?utf-8?B?b3k5TEZEWjUrdy81VnJjQUl5WGlQTmdyUGpJcFRLbTJxUVR0UW5WSUttY08w?=
 =?utf-8?B?SnlyRHdiM2FYNEVNVDNjbytiSGFVaUJ3RHdDMlZhZ3JlWGRVRHF5bnZVUHVx?=
 =?utf-8?B?N0JTTlpodlhnMFZCNHEzSEIvRE8va0xKOEdQRFV1RXVieDJLL3FYazZiMkRt?=
 =?utf-8?B?cUtzVEZJenlScUJvOVN5QXRudHVlN2VKaTA0SHIrMTB3aU9wTW5FMERYSEN4?=
 =?utf-8?B?UDlWNzlIZEtNV3hVUitJNjNkYVlHOGVjMkRoK0lRZXVnWGs1VWpHQjdnR0dC?=
 =?utf-8?B?WVNNcDBiTXo4MjZBRFd5WTk1SEdTLzlQcVlxU2dGdVNGSC9UdHlraUpYTHRS?=
 =?utf-8?B?Q2oxNjNvZ3IvbmhiaWdOQ3FtdFJCZHdOdXhwbnYyVXJMekJIUFloRmEyOVpU?=
 =?utf-8?B?enNKbWtYU1RmTktrd0N6Z1ltRkJZMk51VXdMZURNeEtSM1l6Y2hBM0dOTGEx?=
 =?utf-8?B?OFg4ekFzSHJiSUNVRDhUakxzUFJNZEY1T0M3RURmRW9sbS96TWtYbEVMTXVT?=
 =?utf-8?B?K3Z5UmdFV0Q4bnc5LzJ4Ujh5TEtTTUdZRkluYTJUVUNTNDBLcjNDRnQwSExu?=
 =?utf-8?B?WWpLc3M1SVZqZ0xZcnRMTmhZa2dQL3YySE9ERHozSDVOem5oa3hrTm1LN2oz?=
 =?utf-8?B?ZFBzQTVtNGdrWGtDVW85OGdVN292NHpuZWxDZklFUlYyTGtxNkppZlRtd1V5?=
 =?utf-8?B?eUgxbFdmUTVrbDRxYlRNemZZcFpWZU9DRkxEMDBmV0NUM1ZnbWo4ZzhzWkFM?=
 =?utf-8?B?QXluSjdaUTNqbTVTNURwT2p3eEZXbkZZb2RjOHFPUFRmbWVCZlhUNWI4RzdN?=
 =?utf-8?B?QTVkOTEvVEc4SzdQcy9UTTBUY1VRYmFodTFPd3ZCNXpralRiN2pSUGRFZDNm?=
 =?utf-8?B?S2tLRjVUR3JOc1ZJY0IxdzZCOVlrNFUvTU5Xb1lObXlBKytQOFRLeE5KeWRG?=
 =?utf-8?B?K1BleEZYMElsYUV5MlJGYmEyMGlUeGhiWUU0TFhMM0Q1c1k1NlNrbmZtbkdY?=
 =?utf-8?B?MEgxaDcrdExKN1NHZTRadjRRM0FldTV0RXJtcjRqRE8zVnRHbUFBWlFLM2NX?=
 =?utf-8?Q?cQ7o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f40d4bc-3646-49b4-2d04-08db846f96c6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 13:38:21.0450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDyv22pByITrFdUM5MGxHCy/2o3JFaz+GbNaLHHTh9r7V7mkGXninZq3AGPQBaqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-14 05:44, sguttula wrote:
> This patch will enable secure decode playback on VCN4
>
> Signed-off-by: sguttula <Suresh.Guttula@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index e8c02ae10163..d199f87febd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1804,6 +1804,7 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> +	.secure_submission_supported = true,

We should set it to true  with VCN4_0_4 only for now, and check either 
this boolean or VCN4_0_4 with your implementation from patch 2

Regards,

Leo


>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>   	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
