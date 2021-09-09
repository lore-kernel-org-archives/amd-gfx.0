Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 03:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DD961167
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 03:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89DD961167
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E8F6E42A;
	Thu,  9 Sep 2021 03:28:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50FF6E42A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 03:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClMaxnP3H/3G0lLBaehrI2IucsscGQ5kronilqOBKIiSOjn3LPV91YTBGppwHQk8nRot/J+gk3E8BT7uoco6JYY4+NpQceC0Kd4fkD8ysUB+Qd/KfnR7Su1vBQq2ZkcLVtvzQxZxZTXczLiIKN+hGHV1joeSqmznR59W8+ULIaxUQkMX6/PHP0ezy1V8Ws37RNvwLo91N6NbD0y785Ah8UXEajxj9IMMJegTqYzwJcq4nPU5OwPC6310IV9Hfg88S2QuE42o3DO4+tM9mXnNUezjO5WRTYoAXUpCcQan77nSsLd9a8O08UPflGWiQI7VPGALSmguuMz29foCruAqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kJBCmTebqo3HLjL1b2H0d/gSvVwZvzwsWGVLgQPH5R0=;
 b=boKAsxYz8jrfUfGWxzu7yZ7uIx0LqTgftW0TvcK1ua7lA5I6JRBGdAQ7zUiEoAv7XCZlEdNTGhqc2O4sFDazJQKG3BRh97sqh7GoBx1Ac7XKAOwqWp/LZPKrwO1+qjbjo7UQd3L249ffsSUQ7jF9RTGGRozd3Y7WL9H72kYfEYfIQw+7Hi2grc8zFtI98yIWI0PU4kc/nvON5ZqiUEgclKrg1a7UyT4dLnPIZylpXuPw3ZoPbukwKZG0ewjhE5By02YKwPCiVEEIGTpM+gin1lOL9/EfL1Iaj6IAssU6Bxu3c0z/ajEH5TuXPK94CQ5I86VPGI9LexbNk/kf7plSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJBCmTebqo3HLjL1b2H0d/gSvVwZvzwsWGVLgQPH5R0=;
 b=uy+NI4v4rfQP/bpdF4d8jDfXjuMBYERgjkduELeq4+cK+vguWpP0VdcTZiaoVcLBj4OWPlYGhPK9OgZjM+uy+VQTkUc8FJ1BLLiD2R8KuSxzSV/hEvuRr1Od6IEo+EQ182eWoIYhux9jEizdCrqbhX4j9LhtzdBT2I0gwACOsrE=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 03:28:12 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.022; Thu, 9 Sep 2021
 03:28:12 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: "Yu, Lang" <Lang.Yu@amd.com>, "Powell, Darren" <Darren.Powell@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
 <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
 <4e6c0a19-0476-d8ca-c233-6f143cca511c@gmail.com>
 <CH0PR12MB5387C11CD331985AB96F0DCEF0D49@CH0PR12MB5387.namprd12.prod.outlook.com>
 <DM6PR12MB4250EC35F696D19098E9642AFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <3c02e758-1d36-ce2a-11df-eedd82a30c33@amd.com>
Date: Thu, 9 Sep 2021 08:58:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250EC35F696D19098E9642AFBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::28) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 03:28:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705b11cf-b7d7-4993-3721-08d97341da6f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53672610495D247DEE5D9F5597D59@BN9PR12MB5367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcJGSk3i6f2u+CytRdlHJZOJPvNBa7sR4OBnBvpFIsXhTWag9xq7k6WPIJlxQ26Vb35nQoJ0DPU9rDviT4mtTIVt9R9Rvw85agjSV/1YQCevqDzoEfMWCk0KQp2P3gWuvDOKy41a6MW0SeUQUPoqWSbUzxDwkVAjdJ0RxWMx5hUxcaFYR0fcLFG/YjXum8zniOqYYbzLyVB2ubiY4Ra53a4rx4gqzbjCUgnOvuOnUH7beW2rh+RFsTHx2kwd0rGrZgS53rvNdH//7Hke6ZE1xIoThJ0lVpeAb4QMPWE7fb5Qa80WIMkwHfEPz0eZcooiiOHA3OCvTYYiqtD9uLczM6OZnclDCL3uepdRyYLqErrYi0lT3E3RsACzaXOckrDhJhA8rdJPbVCB09cmMwy/+hAgK9Ovk52QY9QNEjGUR853o/53KVUDKiFNizANpai2WxVcSVkyic11fiGGV5uOD1IBQUN2bwA/HKBNH0CkZWmvB0Xjz0z20jcps9oAphuU1V35yHQVDj9ryeLa/R8VX1sJVOGLyS0Su+KVsy8Av0eKkd9fBbL/EFwtv5znwWLU3SCIN7RLgm7z5TEM/8srnNct9W8ZfRSnl+hyii4NHI0gpsez5f6vBo8huSGY3s+g0sHgM9IDUaqXXuKgfarlsX7UNkgw/9Iggcd80w981vZpmRpKdhmhJBe6cWWd0Ix3FGm3SoUcptnlFU7kJjL07FVyJvDYx5LafUuSMzDfSHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(31696002)(956004)(2616005)(66476007)(54906003)(8936002)(6666004)(86362001)(83380400001)(4326008)(30864003)(6486002)(66556008)(36756003)(478600001)(186003)(5660300002)(31686004)(38100700002)(53546011)(66946007)(2906002)(26005)(316002)(110136005)(8676002)(16576012)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FRZmNuM1JjYitHQit2SExld21OQ2x1cFp5eVcyZkpJR1Bja2FnKzZZVUd4?=
 =?utf-8?B?UVdxVTNibkpGNHJveW1EMHVOcllyYXZtNDhCR1RJWTQrbWtOb001aHJ6MDFx?=
 =?utf-8?B?YVdrYTE3SXhkKzNPWVIwRmd4bjdyOVFBandQNGQ3cVpMMVI3V25JdnVnZzBP?=
 =?utf-8?B?RGxnMTVBSTVPZU82TGN6cFFnNytxak5XMUpRTmlDOXFWK3hDdE8zanBLcGxT?=
 =?utf-8?B?OW5nOE0xd1Q4NnBsbDhjREFjWFZIY25IRFdpNDJKNWhhSmU2Wlkrc0M3R0ZI?=
 =?utf-8?B?Y1J5UStoWjA0MElkSFBYdlE2eDBHSytodHpndS85SGp4VGNMTy9mdkNZeHNF?=
 =?utf-8?B?Qk02RWlLRWZxa0NQaGcrZVh5NkpsTjNqNGJ3YktRMjlNM1dDU0xvWXBzbDk3?=
 =?utf-8?B?RW54YTU3U05aaFdkK2xVS2FzUFUxdGkwWkN0U09tY0NvSlZtS1N3NldmZk9F?=
 =?utf-8?B?bUdHcUNiUWhCanFHd2RzdHlIamhwelBuYUpxMzR2Y0RCcU9HZFIxL3ZOOWVH?=
 =?utf-8?B?U0RMalJ3L2g0SUkxR1BJTGRXalZyMlZvL09CT0lWNEdtcDBYYi93UFpmbWtx?=
 =?utf-8?B?TjA1dWswSmt3dkVQSHJqeG1JTVV1bTYzdUxzMG5Xc0FRM1EvSFNqYVpTT2RD?=
 =?utf-8?B?U3pIN2poQm45NTRrRmVjRVN3TFJsdzg3alBWa1U4aTBkWjhZNzRhTUFsVGMr?=
 =?utf-8?B?QzFBWk1ZOC9zb3ZNRkRzS2Q5blo0MWF6RElIQ01LVFp4WDNwMCt3ekdNNTFt?=
 =?utf-8?B?Wkg0dGRtR3N4eERQZmVaSWFWOGRNMENYbVR0OGxDVHJLaTFOcEJKYnRrWklB?=
 =?utf-8?B?Rm9RMmM1K0p3cGRId0liRDFKUThVQ0h6a0FqVnJsM3pvYTBmT3VBdXVFMW9Y?=
 =?utf-8?B?YzFybktLU0FkZ0tiWTNkK2dobVlRWkRFeCtjcy9NTTVLV0l3T3ozWFIzR3dT?=
 =?utf-8?B?b1d6NWxTN3pXTVE3cTZLTWJiU2tETTVZenByc2lhaXJuOGt1Z2I4NDVDeHF5?=
 =?utf-8?B?RGZ3bExxcWdCRUZURnVhOWM5YW9xRXdISStxb0FrOWwrMjJOaFlXbEdnZTRz?=
 =?utf-8?B?OGRRY0hDYlRSN25FSWlPVWEzYndSblJwckVJbEZGbnJ2NVo2V1hyM09sYnlF?=
 =?utf-8?B?V0ZUenFUejR5UGNvZ0dwK1ZtSEh5Y3dWOXhneTJScGJoS1BPcVlzOVFYcCtT?=
 =?utf-8?B?NGlMZFBkSi96eTg4RE9iUUErb2tvRkJkZjh0MFFUOUdMTDRObDdxZWxPWUFl?=
 =?utf-8?B?ZlozamFvSnpsWnAyV1hUZkxkeXhFWXdkcCtxOHU0TlFUY3NiczJHajRLd0wx?=
 =?utf-8?B?Yld2dXcwbTllQmNUMHg3VG8rNVJvcStrZCs4QkFpdytuaWFLd2pPaUJVZUtm?=
 =?utf-8?B?K2ZvZGMybzBicGpvMzB4RE9tNFNmNTFkRHlXOFFkY2xyQzExNFB2STI5SHR5?=
 =?utf-8?B?eUFqazJFK25rMk5ZMzc5REVqbVJUYVZnK2tpRTRTWjZKaVNiczFzS1pHZjJR?=
 =?utf-8?B?NTR1TVBkL0lFTWtDZlRveitDZ1ZpdlFnM0x1SlgzY0dlaWhDck40V1BGN3Ur?=
 =?utf-8?B?NkJpVzVzR002VWV4dHp6d1dIa1JkQ3hJN2czMmw3Vm5jc3ZmVmErZlNPWmxU?=
 =?utf-8?B?S3ZuWUZqVFBFV0hpV2M3emZmQktmdlFGd3MwOXIxTS9BZmNBNkp4ekcxdTNL?=
 =?utf-8?B?MWJpbUxWTHhvQ05QY21McCsyaElpY2xtNWdkZFk0QTJlQjNyWHFSVGJqQ251?=
 =?utf-8?Q?03XxyWewwfqK5/tCTBVUccx+tFVfX8ujhzSfYIN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705b11cf-b7d7-4993-3721-08d97341da6f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 03:28:12.5780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpJjRZUjGIXFCNIzkwMow6KtcAWR0WgSvxnAT3H5DGtxQVLNkaFoizb5NTIqRDbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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



On 9/9/2021 8:13 AM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> So the final decision is rollback to scnprintf().
> 
> If we can define our own helper functions like sysfs_emit/sysfs_emit_at
> 
> but without page boundary aligned limitation to make life easier?
> 

No, we do want to make it clear that this function is used for sysfs 
files and make use of the extra checks provided by the sysfs_emit* 
functions. Looking at the origins of sysf_emit_at() specifically, there 
are indeed some cases of printing more than one values per file and 
multi-line usage.

So I'm fine with your original patch. Maybe, you can make the intention 
explicit by keeping the offset and buf start calculations in a separate 
inline function.
	smu_get_sysfs_buf()

Thanks,
Lijo

> Regards,
> 
> Lang
> 
> *From:* Powell, Darren <Darren.Powell@amd.com>
> *Sent:* Thursday, September 9, 2021 6:18 AM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>; Lazar, Lijo 
> <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray 
> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
> *Subject:* Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
> 
> [AMD Official Use Only]
> 
> ------------------------------------------------------------------------
> 
> *From:*Christian König <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>
> *Sent:* Wednesday, September 8, 2021 8:43 AM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Yu, 
> Lang <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray <Ray.Huang@amd.com 
> <mailto:Ray.Huang@amd.com>>; Tian Tao <tiantao6@hisilicon.com 
> <mailto:tiantao6@hisilicon.com>>; Powell, Darren <Darren.Powell@amd.com 
> <mailto:Darren.Powell@amd.com>>
> *Subject:* Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
> 
> Am 08.09.21 um 12:22 schrieb Lazar, Lijo:
>  > On 9/8/2021 3:08 PM, Christian König wrote:
>  >> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>  >>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>  >>>> [AMD Official Use Only]
>  >>>>> -----Original Message-----
>  >>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>  >>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>  >>>>> To: Yu, Lang <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
> Christian König
>  >>>>> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>  >>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray
>  >>>>> <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; Tian Tao 
> <tiantao6@hisilicon.com <mailto:tiantao6@hisilicon.com>>
>  >>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>  >>>>> warnings
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>  >>>>>> [AMD Official Use Only]
>  >>>>>>
>  >>>>>>
>  >>>>>>
>  >>>>>>> -----Original Message-----
>  >>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>  >>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>  >>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>; Yu, Lang
>  >>>>>>> <Lang.Yu@amd.com <mailto:Lang.Yu@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>  >>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Huang, Ray
>  >>>>>>> <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; Tian Tao 
> <tiantao6@hisilicon.com <mailto:tiantao6@hisilicon.com>>
>  >>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>  >>>>>>> warnings
>  >>>>>>>
>  >>>>>>>
>  >>>>>>>
>  >>>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>  >>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>  >>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>  >>>>>>>>> address. Make them happy!
>  >>>>>>>>>
>  >>>>>>>>> Warning Log:
>  >>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>  >>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>  >>>>>>>>> sysfs_emit_at+0x4a/0xa0
>  >>>>>>>>> [  492.654805] Call Trace:
>  >>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>  >>>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>  >>>>>>>>> 492.658245] vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>  >>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>  >>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>  >>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>  >>>>>>>>> dev_attr_show+0x1d/0x40
>  >>>>>>>>
>  >>>>>>>> Mhm, that at least partially doesn't looks like the right
>  >>>>>>>> approach to me.
>  >>>>>>>>
>  >>>>>>>> Why do we have string printing and sysfs code in the hardware
>  >>>>>>>> version specific backend in the first place?
>  >>>>>>>>
>  >>>>>>>
>  >>>>>>> This is a callback meant for printing ASIC specific information to
>  >>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is
>  >>>>>>> to the callback API.
>  >>>>>>>
>  >>>>>>>> That stuff needs to be implemented for each hardware generation
>  >>>>>>>> and
>  >>>>>>>> is now cluttered with sysfs buffer offset calculations.
>  >>>>>>>>
>  >>>>>>>
>  >>>>>>> Looks like the warning happened because of this usage.
>  >>>>>>>
>  >>>>>>>                   size = amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_SCLK, buf);
>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_MCLK,
>  >>>>>>> buf+size);
>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_VDDC_CURVE, buf+size);
>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_VDDGFX_OFFSET, buf+size);
>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_RANGE,
>  >>>>>>> buf+size);
>  >>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>  >>>>>>> OD_CCLK,
>  >>>>>>> buf+size);
>  >>>>>>>
>  >>>>>>>
>  >>>>>> [Yu, Lang]
>  >>>>>> Yes. So it is fine we just fix the caller
>  >>>>>> amdgpu_get_pp_od_clk_voltage like
>  >>>>> following:
>  >>>>>>
>  >>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  >>>>>>         struct device_attribute *attr,
>  >>>>>>         char *buf)
>  >>>>>> {
>  >>>>>>     struct drm_device *ddev = dev_get_drvdata(dev);
>  >>>>>>     struct amdgpu_device *adev = drm_to_adev(ddev);
>  >>>>>>     ssize_t size, offset;
>  >>>>>>     int ret, i;
>  >>>>>>     char temp_buf[512];
>  >>>>>>     char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>  >>>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>  >>>>>>
>  >>>>>>     if (amdgpu_in_reset(adev))
>  >>>>>>         return -EPERM;
>  >>>>>>     if (adev->in_suspend && !adev->in_runpm)
>  >>>>>>         return -EPERM;
>  >>>>>>
>  >>>>>>     ret = pm_runtime_get_sync(ddev->dev);
>  >>>>>>     if (ret < 0) {
>  >>>>>>         pm_runtime_put_autosuspend(ddev->dev);
>  >>>>>>         return ret;
>  >>>>>>     }
>  >>>>>>
>  >>>>>>     offset = 0;
>  >>>>>>
>  >>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>  >>>>>>         for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>  >>>>>>             size = amdgpu_dpm_print_clock_levels(adev,
>  >>>>> clock_type[i], buf);
>  >>>>>>             if (offset + size > PAGE_SIZE)
>  >>>>>>                 break;
>  >>>>>>             memcpy(temp_buf + offset, buf, size);
>  >>>>>>             offset += size;
>  >>>>>>         }
>  >>>>>>         memcpy(buf, temp_buf, offset);
>  >>>>>>         size = offset;
>  >>>>>>     } else {
>  >>>>>>         size = sysfs_emit(buf, "\n");
>  >>>>>>     }
>  >>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>  >>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>  >>>>>>
>  >>>>>>     return size;
>  >>>>>> }
>  >>>>>>
>  >>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe
>  >>>>> another arg to
>  >>>>> pass offset along with buf?
>  >>>>>
>  >>>> [Yu, Lang]
>  >>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>  >>>
>  >>> Though it's not a problem based on codeflow, static analysis tools
>  >>> might complain.
>  >>>
>  >>>> Or we just rollback to sprintf/snprintf.
>  >>>>
>  >>>
>  >>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took
>  >>> the effort to convert these, he may have some other ideas.
> The changes I made were intended to simply replace snprintf with 
> sysfs_emit as per
> 
> linux/Documentation/filesystems/sysfs.rst:246,247
> 
>   -  show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> 
>      the value to be returned to user space.
> 
> I specifically tried not to change the design, but only as I didn't have
> 
> background in Power Management.
> 
>  >>
>  >> This is not what I meant. See from the design point of view the
>  >> print_clock_levels() callback is the bad idea to begin with.
>  >>
>  >> What we should have instead is a callback which returns the clock as
>  >> a value which is then printed in the amdgpu_get_pp_od_clk_voltage()
>  >> function.
>  >>
>  >> This avoids passing around the buffer and remaining size everywhere
>  >> and also guarantees that the sysfs have unified printing over all
>  >> hardware generations.
>  >>
>  >
>  > The scenario is one node used for multiple parameters - OD_SCLK,
>  > OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with
>  > lots of nodes). On top of it, the parameters supported (for ex: CCLK
>  > is not valid on dGPUs),  the number of levels supported etc. vary
>  > across ASICs. There has to be multiple calls or the call needs to
>  > return multiple values for a single parameter (for ex: up to 4, 8 or
>  > 16 levels of GFXCLK depending on ASIC).
> 
> Well exactly that is questionable design for sysfs.
> 
> See the sysfs_emit() and sysfs_emit_at() functions are designed the way
> they are because you should have only one value per file, which is then
> printed at exactly one location.
> 
> Take a look at the documentation for sysfs for more details.
> 
>  > I don't know the history of the callback, mostly it was considered
>  > more efficient to print it directly rather than fetch and print.
>  > Alex/Evan may know the details.
> 
> Yeah, somebody with a bit more background in power management needs to
> take a closer look at this here. Just keep me looped in.
> 
> Regards,
> Christian.
> 
>  >
>  > Thanks,
>  > Lijo
>  >
>  >> Regards,
>  >> Christian.
>  >>
> 
