Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BFECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 12:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD2610E60E;
	Thu, 27 Oct 2022 12:52:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5943B10E60E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 12:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLR3aJGnToa1XxkdRq1JSi0YFeW9Ujlh0EhcA4l4k6SK7kwUh+3JAP7py1BsOgbMyypu9JquMBncQrnZgSuhxzbXRJuFgBMjM9A7aNZTW0UjDPssM5v5okMIJYI5ZDxRZE9JC0UJfQnVb0BV2Ir7Vk1YlLL2T+raDEs3NJcPi5ChePBvWxNYFxPfs1hJ7GsTE3QN5xnvk8+HbvQgyT/YieMSwv2sAmA6nowYsfpb5zFklVt+Soea6CWPYv9mZ93OLV0Tu0x+o1bRg7MN8L+geipRv6omtBAPja6MTZb/z6koKbYfiHh3tSLy6d6A2CicjNseAgGqfdRClTsOALT1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppj/vQ1wHTZwZOkft78fbzhnpo/PzUIaAFYobltofSM=;
 b=QdqucI6nLkCgxRRVIdpz3760Mg58FE0OdmV9fhwK30TIt8829t20bIrf4ZgPSe/29ndOoFmgshJw95eUDTfeUAkWvrG64re9kTxiDPR8Q6BC2t0TXvAA3naOEp5i+JrsqFyDcshN1ftJ/ROe4WC+4MAfrCgGe/t/MCJnyRd1N70GS+8zMy3C2LP/6Rq81PLC/L3aQk5BtQac8uLjjd5Dgn24xzCzOJ4QDCRqkXO1htsreDzNbtE4rxOjZ1A79kp7SI6SHUk1Uz5mPvBvwZf4d77rQdCtkT22oJKYXtPRz2KUa/TweHcs/+HEs+8wwrv9KhiXA+YbkFn7K8wfHoweXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppj/vQ1wHTZwZOkft78fbzhnpo/PzUIaAFYobltofSM=;
 b=B5QE4Na2Pw0KLFFlOoDWyRSl27426YjLtALQcnkmBVLgQ2Re1T7odaFYXApBzJ2eexLqztquDj30BsXyNAwgQ8Zqeca66IOhYhMGy+Ihwt5DtVtKu+mCe5MnKU0gURNui9TFjLM16FqefEFHZwrNoyUF/YNxu+86AlrFJgYgDRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 12:52:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279%4]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 12:52:11 +0000
Message-ID: <5ed240e0-34d2-d009-1142-2afc326a573a@amd.com>
Date: Thu, 27 Oct 2022 14:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Ao Zhong <hacc1225@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b323a48-46c8-4064-23c4-08dab81a10b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsiZ2ZmrYKWKSeZ6ZsCFvFbu3OAyf8PDdaD6hSDb40WvqmyZUA9bSABJPyOlG4g8ODql/2rcKWqjopNnkogLhDlaL0XUAYsYJm5KqXxUN6qDQHfuLRbWcg3t0HcdVXV5fYMbEe4fSwZ+1TcDRj2c+dttbszV0j4Ck/lYvsrmU4Z1UZ2jx00WvGTFznJ0pR6MgD9eXbgGj/CZAhb/TcgzK9ZiJPEo4eD1WXHlJ6eCOki8AZ8yVjyi7b6VF3u+jhczN5IsBoQ2d8pZ3LQ+s3pc8AXMbWT3VOMiEhiUTDgOIAiV4J0Qyg12l3ngKNjKD7Eb5/RmpooatiZ/LYIid2LCdJhUP+HFARwu+As/33PyCBb1U1Ckb1i2vZ5I+RiHWoidZZnvro/TtiMmjc56ODD0afHLOjQuJSB2spapMJimU1ZA6b9YlNma8oE+aO0Rc706aj9nP9nK3GiSjhuRilcr7VWCzX5X1LaRSTedubacUio44o46FeRP0Pq/sseeukH6i+oNyuC8wwVUrBMfYqQheD77a3OYGnYGzPCZaLhS7rrJgbsvTjm3t4edGJETlQ6e9N5U6YyJpqX67i0VIGlWLd5HyKu3BlCwxwzhRZF3y+ABIAX4J8n3i6nEloj6Mbz9u+Ysah3oU6lftZaGibH42H+D/Bi6IJ6S7z7RFRfBFFQyJJvPsGaSDr5B1Bp+p02nzMphxQYng9TGJvCk71/8uVRXVy0qC5Ye/X6TVkcj9/J9MW88aGakLHQxz9gtP6SIKdU6OfNegb5IIHtMD+d9blXJnIFNt69wbSqyixSDqkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(316002)(38100700002)(86362001)(6666004)(31696002)(110136005)(8936002)(26005)(6512007)(5660300002)(2906002)(2616005)(186003)(6506007)(36756003)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(31686004)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVIejI3YTRQdXppdlJJOEFXaGw2WnkrQ3ZHRXE4bW1SR2Qzcm43S1d0V0Np?=
 =?utf-8?B?b0ticWg1WlQ5anBvTkc2RkMyR2o2WXBqZFk2MTdFd1pBN3VIK1NHWjBmRGZr?=
 =?utf-8?B?Q3cvZzhMaElzb3VoNjJQUElvUm5TdHdEQThKMGdRMG8rR0w2OFZKeGRoeUhE?=
 =?utf-8?B?QlBuS0NjUHhjemJNVkhZWXFYTGljRG1BZitRbytZSU5YUmd5dnBRV0NtNmVs?=
 =?utf-8?B?eHJPNU1JLzRPRnEwSUlUV2EreWdqNlludmVud09yNnBuT1FwTVl2cGdsQnRR?=
 =?utf-8?B?RXYvTnIxeGg1aEZOSExvUmNlTVBRMWlZMitYVjc2MUZiRFRmK0p5Y09FSGlW?=
 =?utf-8?B?Wk1DMis4U1V0YU90b1hwbGZGN3dGY2ZmSnNwTDRzbkVBLy8yZkZleEFOaFB1?=
 =?utf-8?B?Q3NJd1lzNDhmYkFaUUU5RTlVc2FnZURPMWwwRitTRGhQNUtSbXYxTTV2ZUtS?=
 =?utf-8?B?NzlicTVDeWN2Z2xNSk5PbmgwSmUxMFZMcm5PZ2FqQ0FEVEF3bVZheE5lb3Zh?=
 =?utf-8?B?UEV2Rk1INTZaNXFYSng5U2hVQ2pTRzRYVlN3d250NFZTOElsY0Q5cFBvZFp6?=
 =?utf-8?B?S2d6WHFjZ3ZRRjhhODhQd1hqU2xXVlMzM05kRE9qZGQ1eUc2TVN6aDhoNEtm?=
 =?utf-8?B?cmpoTUlMNWYvZ25aUkhuOUE4QlB5L2VmTTdreEpaVkUyQXFBTkhheENHcjBK?=
 =?utf-8?B?T3NtdzVGWDBMSzh4Ukk1VVJpWWI1RHNrN05lWDIrZno1TUt1dXNOSW5pNitO?=
 =?utf-8?B?ZFlQakxMdHRDdkxUVFFIUmRwSGJxdDR4NHBOelpnemhJZzVuQnNCSkdnWHZl?=
 =?utf-8?B?ZzlCa0lza2NPS2FlbXczaU4wNkVsd2I3NXpUOHl2b1NwdUIwazRWQTNFVlBy?=
 =?utf-8?B?MGJiL3NTb29nRUFVYkJ1MExUL2dBUHNBOEJEUi9FZktNa0FycFNaeEQ0MGNZ?=
 =?utf-8?B?QXlvdjl0ZytsbzlRZDBmRjZ1THhrc3J5bWpoaUpLUERBYldIMmRJN1hPWHo3?=
 =?utf-8?B?VDQzU0pwRmpCT05YVXNiVkFVZDRKQlBYTWRBWnIyYmlxOE5iNE1LUnV3amJm?=
 =?utf-8?B?K3UwMndkN0REdEZ1eXhMSWkzUzNCMDM1VHZSWFp6MXN2T0laTUc4d2NSS0RT?=
 =?utf-8?B?VlVyRDZxN2pLZ2pWUk83aGxZOTBBa1RRR0lVWW5OaTJVeWVFUG1EVkwwSXZM?=
 =?utf-8?B?ajZ1bDhYNUdFa2thaDVFZVJ2djJPVmUwM0IvVEJoYjZ3dzlLQ2c3aUlHMkk5?=
 =?utf-8?B?SzdDVGFyY0dOT3FaTzM3ckFyVDJXYjI2eHZ4cWRnbExkNEsvclBzRUlqdGFo?=
 =?utf-8?B?Mmt1SHpPTitTL1FGeFJZMHZFaEhEWHRjeTFmWDJpTnBPTkw2bmVURzJMWmJJ?=
 =?utf-8?B?NTZBajdMc2hwbXduZklaUTk3d1J4dUVXQ3dJd1g1dGk0QzIyVGdGa0VmVkwx?=
 =?utf-8?B?U2l5YkpMZTZTYytseXBsWFFscjRjUjhJVlhneEtHcEVTYW9NeDlidDdmRVlK?=
 =?utf-8?B?a3VXUXEvbm16Nk9EZ2J6blIwNzlsckowUDNjQkxWWTNTbjNSMnBRSEo0N3Ex?=
 =?utf-8?B?OGplejVQcFZyUTFqUWc2N2JXMVZoRUZqOGRucjFNaGdOYkRyYWNuUG53dU1L?=
 =?utf-8?B?aEplZjloUVNvMWxmU0NxaXorNHBRRjVUZnU5OHNFaEtxcVZBTlNtNElTc2gx?=
 =?utf-8?B?dzJFSmpENmxhZlBaaVNqenYyNm4wZG5oMjczQi9aVktjdkJ1S2NOQ2xKZktr?=
 =?utf-8?B?cDR6dFdkaXVVUEhhSGRLY2VYVHBQdzlOajZBSm1aemxTL1NnNElOaVQ2VjUv?=
 =?utf-8?B?Q0pxeEk3TE5TTWh0ZjE1cFUyR0NqUzlmcjk0eXFsU2hPTEMvcllXZ1NSeFpQ?=
 =?utf-8?B?Q1RNNFVBaFk1am4venc0Qit4Smp1OVZVeWt4NWdaNE0rbmRvcDVVNTI4blNl?=
 =?utf-8?B?ODhZZkRlSFQvejBPWDJXS1Z1VVhMOGZMakRVWTNPNEQwdlV0TmpOeXFwUlFa?=
 =?utf-8?B?RnVTZ2JzMVBNQUNBbW94eEJvTjlneDdmTmVPc01QQjJ3VE9ZMGtOOUpib3VW?=
 =?utf-8?B?dnhhRWl4Z1NXbDNhay8xWUpObFhlTU0zWlpjUC9EbWVrb3lSK09iRWpBczhy?=
 =?utf-8?Q?pGnLNtkWONbr5d7vkbRJm96hY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b323a48-46c8-4064-23c4-08dab81a10b4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:52:11.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ho7+jF2wu3pcCr1kqLkmilGUrLWEfkii9DNTEtuv78HWgQ7sjel/Qmb3Xhmwg6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Cc: amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.10.22 um 12:52 schrieb Arnd Bergmann:
> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>> After moving all FPU code to the DML folder, we can enable DCN support
>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>> code in the DML folder that needs to use hardware FPU, and add a control
>> mechanism for ARM Neon.
>>
>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> There have been problems with stack frame overflows on this code
> in the past, how much have you tested this with random configurations
> to see if we still hit them in corner cases on arm64 that may not
> show up on x86 or powerpc? I would expect to see a few more of them
> for every new architecture port.

Our display team has worked quite a bit on those.

For example instead of putting large structures used for temporary 
calculations on the stack we now either completely avoid or kmalloc them 
as part of the CRTC structure.

On the other hand I wouldn't put my hand into the fire that this has 
fixed all the problematic call paths. So keeping an eye open for this is 
certainly a good idea.

Christian.

>> index d0c6cf61c676..3cdd109189e0 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>   dml_ccflags := -mhard-float -maltivec
>>   endif
>>
>> +ifdef CONFIG_ARM64
>> +ifdef CONFIG_DRM_AMD_DC_DCN
>> +dml_rcflags_arm64 := -mgeneral-regs-only
>> +endif
>> +endif
>> +
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>> -Wno-tautological-compare
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>> $(dml_rcflags) $(dml_rcflags_arm64)
> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>
>      Arnd

