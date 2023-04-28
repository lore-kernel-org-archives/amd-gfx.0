Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41EAC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 14:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613EB10ED6F;
	Fri, 28 Apr 2023 14:16:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCDC10ED6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 14:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGJjoT7kBRsf5qq0MrbcpVClVTvpfxf/gfYd7EbAulCdqBJgdlJuMLkdcsBH859QWipAwfKd0g4p5oKeZdf+JSKGeDegHAVMqC3XKRyta2Igz8v6LRUkYtwz1ZzWzMB+Ph9/AymwZszA9aVwI0vHoghqtdNvPlGhF0H2eQOmpSaiKCgzxv9as3/3sa1ReAdaAaySBLzUhkatPE2Hw3Nkqtd/E95eD7Mfy4BMhQsl4YLpvuL7cCzEKz0tw/BzQtcsNRbeovK5KWoSdlb5Zkqcnec0D+6QiyXEmEi4gdTKl9Dpo7s2Y0zbu6+LDPuDYob0/DCDaoIUvVX5KPlTjA593g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az5TnMNihUxySAjwxcL5waIpVzSCW9dpImFWulhS8JQ=;
 b=gd1B1TaKe/c/aglBHcTxo/UutSb8xlEuXb9IRs5q7LQ2tNG5V+yeOd31bTtdnrV1bk/8HMXge0VnHdigImimMIsZ8eZPD/8+iZMLL0hsUGyk3j5QVglzEcuA3F59RU4Bs96MjnbSENKeeaNUldfu7ToZy0N1o29wVfDSzqig/4PNr2Vg10NOet638jqtLqsEHqn/7doli7tjw74uYZNjuQnKtBKYoC4voUhO+IXHL6f5T1abhyKWKuRcOGoPEU3y7Lmt2nS51BzyQhYBHivq1rwjGBHiDP3YMWzSLlSOeV9K399cc00qzFO9MoGmBlYDw1ZPSWPnNi8nBUmGb3MM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az5TnMNihUxySAjwxcL5waIpVzSCW9dpImFWulhS8JQ=;
 b=MCKMD/8zJ+ldVmFn6sJdtXix5XxC5uitKURy/VrhlSpwZnxtTVrMIoeADSni2fUeqZtyGmwOV+1wKOjUR7uWlDnBHZQ81rBQYsEpPqfsCvoJpn9oUcP3roST9ZsKeHZgOOtRnCYHMF1ZlwUEskdTU6NfWkPbuYbrjwhTL69HURk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Fri, 28 Apr 2023 14:16:37 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%9]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 14:16:37 +0000
Message-ID: <a5bc4356-444a-b9f7-0679-b540117b8aa2@amd.com>
Date: Fri, 28 Apr 2023 10:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f57fb8f-d0b9-485f-6a20-08db47f32da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0URpzuKIilrek8m2PQUjHXAwSQSOD/1wSZFYAABc1zEPzNqDR2P8QFiH5diNhIKpVJoZUljRHSLIDjJFdoSgIlZo+rtr6JXj0PtCtRf4Ez15fSZxK/2wkRpHUrSCAP0QTzrp9BBklALw+ghY3HmjdL8GZGfnhqumOqpSdYSb8C+e5Jy1uqwOZz7O+Nm7CBrLhqUPyC4oPzQaL3FeEJW4oLZQ4BxV61ui/KP8HSVmgLYnm7zJYwdaByA7Mht61ecVUM5kthZX7u+lXX6l5jArjWcpl5BzKVOXlTaKeUgbnIRAlEjUH758hTyx96189UmZst9RWb6r9ghF7+sPJETtOxeTdeepml9Ufy0hB2ykau6w6zgLt77RfKd2RdSzXaIlo0q0XetAeTnHhI3hZZPSagXmJzV5fOFc5pFiU61VOVvQP5ugptygcSMb9OpPGPH8EypSKR9PMcAcmahXmlGi5SHzG+/ZhBJsPRLz8co4CeGNdSPv220/EhBTStTRyvMWDvde7Xjxn/Y0rxzTQ8c7ZopLbOSOQR967JxaDk5/0XiQZ0365XG28bSPxh3XiAM72LUsmuQezqdGb1HTE7rt4PCln5veUvew8mBn8WU17KzzDVSDEEDhmHIy2TpxljnfVG8iIpR6DDOpTJ1gRhrZPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(110136005)(31686004)(31696002)(66476007)(66556008)(36756003)(6666004)(86362001)(41300700001)(8936002)(8676002)(2616005)(478600001)(44832011)(186003)(38100700002)(6486002)(316002)(26005)(6506007)(5660300002)(6512007)(53546011)(66946007)(4744005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZ5U2lPQjgwV1d6Nk1DbHN6OE00enFqOHczOWE4U0l3dHhzam1oYi96SWVW?=
 =?utf-8?B?NFJLN20wd1pjODZseGdBamNwRVhwR04zVCtWRVhkazVacXNRLzlwTVFtSlF3?=
 =?utf-8?B?YTFEd1RMWFpBZXZEUUVhN2dVYm1ISWpKd2VUMXRkRkZXUE56ZzQrbXN4WTlZ?=
 =?utf-8?B?a1dITXlLblMxTEhQU0kzcTRrRkVSZ3VpUUpIczFwV2lyWjRJTDNTNGlkbk8v?=
 =?utf-8?B?NGtMdzBQMjVXK0pKV2ZORzgxR2FlRlJmaHZFR1M1L3pRR3BrdzdpZVpHekJ5?=
 =?utf-8?B?a1c2aEtPaUNtb1dOdUdoVVVKcU1VRitkaEc1NjB3a1krck90SERCVE1DdFRK?=
 =?utf-8?B?dXpheDdSbEZidXhwVVJSWlRVWjVqNjZTZzBWNzlFZDUxa0dMa0pUT2d0d2xT?=
 =?utf-8?B?dEhmUjVrd0orRERkQXBRWDB6TisxMHBiTEtCVVg5RksxWmdEeVE1TStBVGdF?=
 =?utf-8?B?WXBNc3NheUtWRGdWOWoxaXZDbmMzVW8xOXZXMWpVdnFvL3E0aUJuUis0WVZU?=
 =?utf-8?B?TkNkVURqcVF0eS9PaDhFdlROT0pOUXdqY2FPc3RzZjlORU0xUnhVV0pGZVpu?=
 =?utf-8?B?NkZGeWE1aURaQnZaaHUweXhlM0RuNDMvYVNkMDVqUk9SWkp6TENSSzdZQTVx?=
 =?utf-8?B?MjNnd2gvTkhrMTEwbUZqaDRSRloyRHJPUEdnZXhQVVVMaVJTOTI0T3VIN0Yy?=
 =?utf-8?B?WjRTbHhBSFhEM01hdzRkcXVBOGg1UzBOZGUvMG1ZbUp2VjRmOGxVdnZFeG1u?=
 =?utf-8?B?R3VPdlBybW50c1JId1FiMjNVdng2aS84TXdLbFFPZkVrb1Y2b1JwWHc5dU1U?=
 =?utf-8?B?TktwZk1aZGoxQTV2a0tEQk1SWi9WSEZaWUxZRjJuTHNwYXNVUzI1WnI1TjVk?=
 =?utf-8?B?UzZXckhFS21pcWlBdWdPNzhrc1h1cnVzN01FNVZGelVpL3NTa3o4S0hMM3d1?=
 =?utf-8?B?Q1BTNENhK1BjL29mSWw1OFhVYUNpY0hrd0VNRWdoaUZpNERTaVNYNHVwektT?=
 =?utf-8?B?TlFPSUV1bFJjcWN5OG83UWFqZWN0bDE3MjZYSzdNUmtPbk5Pa0N4ZUZyMDBP?=
 =?utf-8?B?MWNERzBGdkFPSTVKVG1LVUN0N0EvRkt4UmIwb0c3aFl4bWJqV1Q3dzhiZFBT?=
 =?utf-8?B?NmcxbnpkVXdUNzBsTU02VVdDRGticVIxZGVPWjRzczJ3dmNiN0J3U3Y4NWVJ?=
 =?utf-8?B?N0JXcC9TSktjWFoybldpZ090b3NoY3ZEVXNNMHNzZzJJNFU5eE52bEhuQWdw?=
 =?utf-8?B?bDNMZlp1MmhOREttNFlHTU0zWTdSZFpSVS82YnkxZ1VWRGU3ek1VNXJ5S0ph?=
 =?utf-8?B?YzgwZXQzOFI1VG9va3hrako0cjdhMnZoVjd4TDFUWlUzS0FvMVA3TFp2Mm5o?=
 =?utf-8?B?YUdaTVJ6ZTFjdmdSc2dxWWZaR2cxa1dtNk5rM0Q4R21kcGlXNmRiUlJNR0dM?=
 =?utf-8?B?a2JhSlJ6dkRDZ1duZlQxd2xidE42QmpkUklrM2ZtL0Y5K1ArQkxQMVhGMzFR?=
 =?utf-8?B?SnhBZ05ZOVgwS2Y5N1c0NEgvaiszb3ZLTUwvd2d5VXViajBReW40REx4eGhR?=
 =?utf-8?B?NlVLS25WL1JFRjlHZStZdDBEZG0vU1pmaHZHazd6LzhXcm12ZkNYaThkU3pJ?=
 =?utf-8?B?WGw0UTM2VktVWktKa1RLR2Vkbm1qdlM1clNCbld1dm0vMDdZYTcxMWxWaTIw?=
 =?utf-8?B?TDNjQ3FUanA2ZXF6bTYxbCtZQWRHSHBVYk1OVUhXTjJnalEyeVpOTWtXd2lD?=
 =?utf-8?B?bEI0RWExK2RlZzhvaXJOZURvNXJzZGJTYlMxZHFmZXMyby9taGp5OEpVZmhC?=
 =?utf-8?B?LzkvRVVjVlVlN2lMVDhtcUxWYkFYeDlLRlNDQkpkSUZuZlZxUDNxd08wbFU5?=
 =?utf-8?B?R0VmOVZEZFlBbkZzNTd5N3Z3MXVHRk94NTJnb3hSbEY0UHlGSTQyZkxZUTMx?=
 =?utf-8?B?Z3ZBZ0x2d1FlcTQxK0lrUlJ6ZVhEQWJkMXBGb21rUmVlVGdUZ2hzLzZ4eUxQ?=
 =?utf-8?B?S3VSQ3FnTGNTazNLU29MRk0rUE1aTHNpanBJdkJJZ1VpZHZqTmFkZFEvbW1l?=
 =?utf-8?B?YXcyeXc5eUQ0b1JMVmNXYmZUM0tpT0VaYU9rcG4zYTByQlptM2c2UVZzSDd5?=
 =?utf-8?Q?Ar/tnl2LVelLlDe8rbpMnqgqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f57fb8f-d0b9-485f-6a20-08db47f32da7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 14:16:37.3897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2wg/VFArPBrpKoke7N38HEZN4dBUj615wEayHSr1cnt+7FrW7+hCYUtSsgTi4BTzrrzbz+Fy/A4u6VvmWRJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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


Hey Marek,

On 4/28/23 05:47, Marek Olšák wrote:
> Hi,
> 
> It's attached for review.

Please send this to the mailing list using git-send-email(1). Also,
please include a commit description and it would be helpful if you
included "Link:"s to any relevant issues that you are tracking in
association with this patch.

> 
> Thanks,
> Marek
-- 
Hamza

