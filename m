Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89622C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 23:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D08561358
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 23:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D08561358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAFB89DAB;
	Mon, 12 Apr 2021 23:55:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22FA89DAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 23:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh64cZwoaRjgMoAl1VLQtd4EOd693NveVPilv3OZyJ/xa0pHyPonaUZInn2PkDHsLeBdbfbPh02rew/kCE5u+KzpVBABQGUAzztT+fIP8E3ZbrR47jzv46rk75rqnuCF4fMZzGdlIrOpGDGCmnAFv0HMgmQYBspRVIDH9z5qWewqiFmWD6NCSDRte3Rf7WSwCyLBzKCUzWfdapLHp4lx4EMgBdRbnZ4OgElVxuZJTzCX2CMGOmF+EwTnv0bc7UagiuBuqCifoaZvbPoQQS5FEvHrSuujwsxC/9hSyv5lpXJlfx4jZglbVqgwU/6NDMbNcIUN4KjXH7KxYbj+EsQr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2P497NL712QAmqlWA8LvqU370vpQwdDKejdt+hzkYc=;
 b=F1rPuZXY+f2gjGypANsRg8CZSuqWijNEho8zt3D8X+sNEMhb8g1w2l9FxdMJqwz+ZGsySuMgTmUMmN6W3s/fuOAbUciM2VLaNmF4r6J8pV5ZL1KbpRZylQRoU85nqupSovd53hnIuiuR2eZiJueJ/eftF/sPT2ocoDPFSXvKAegpwzYnTp7IvYAzZ7Ch+IdwCbubrbaeWH03UAoVZxpKZB4sh1Lel+1V6klsaYWj7OkgpL3RNMKZZ9uwaq8DQvA9rzPpBe01wsTgI25QoIotcUH8+5S/4muZKAC2l4SBBvB/Qf7kxj/ZCVRIalC8fUxrvo32V+P4/Qo7b7BV/o/hUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2P497NL712QAmqlWA8LvqU370vpQwdDKejdt+hzkYc=;
 b=qr3RkVwoeZUg8ns3Bdazm1mDnVrr4DShU0znOfk7KoFsfWtjjE3a1+TonyFPJ46VK8RxTA7XngTwfvmYfCd6cKfZqgkWQ0HHQaUONIVm0f6j/XLHi4tYtTV575po9/1pWLV+B+VbLXokxij+XCV/Da7bfG6UGcwJjinmqZ8Gjck=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 23:55:13 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::576:3b2d:76db:55ab%3]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 23:55:13 +0000
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <159a1ebb-07a1-f50d-5a6c-f4345eb97c3f@amd.com>
Date: Mon, 12 Apr 2021 19:55:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:a9b3:8bbf:2db4:7f1]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:a9b3:8bbf:2db4:7f1]
 (2607:9880:2088:19:a9b3:8bbf:2db4:7f1) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Mon, 12 Apr 2021 23:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b48e01-1a8e-421c-3b48-08d8fe0e69c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44812E599837A93806CB35D3E5709@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52KozSHMzD2aAdHAC8dDrXYizhXr4l0VZg9Ss53KTfjMYKJbOLhGb/N/9NYiVOa2krStAH69Tt1ZVTP76HhZ5h4knWHl5hDaDQJAwam7Fo6yGSfqO86w1tC1Dpb22RIdv0tbvNBHjiY8vvby+Vh6kqKOaaHAHfDXaC+WmXwS+E1LFXhR3z0vDYwgbt6lXCjOU/OZEDn+LtWdECplTGVibz8cV0G6Rj6KE5l1Mzlf/6QlRNqNooHGADtdsa2PoCwZFlb+7t/k8LvCTWlaSAW26P+t+ejHn278b65MhhRV7sPyP0H1SpRBq2VRBPThvp2aCOR8+0qydy942ijTuGafIej/Rgprt6WujISlTTYSjpBNhQQLTfOnt6HJR+X87mOZq4gFW37lhoxPSWCBHaFM9pv0djRYCnODH4Ks7yqrzMifWsy/QIQH9wrXDkfapjHzRvB8Kw6gGlcW27J/4wZKssr3bFHRmW8DJ8ndAtV5Bz/PCnZcCrjkQElMTEuLXRNCgztXiUzer19oOxU+dQfbXaqcfss6MaWTup2RdIenXM3NGHAlDgnr0PPi2DZo+B+mRK67z0RugeeQIZFkjM3g/cFF8VQMJ49s0zt9uZw4COch9DfK70jS7R9Gz+ykUwuBGC9hj3E4HoGyyOWV74UjUCqknoiLzXfli38V7dextNfASJm3q1dVJKaea1e0H72NR95GJ7vMPAPhZEnrsljP2R5KEK8xn8G/u1cN3DfzREMTHiQTQxI8INP5DGbK0PUngIm5hOTjCGQwXiMf7g/fmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(2906002)(30864003)(31696002)(316002)(53546011)(36756003)(6486002)(66476007)(186003)(5660300002)(86362001)(31686004)(478600001)(44832011)(8936002)(38100700002)(52116002)(66946007)(16526019)(6636002)(45080400002)(966005)(8676002)(83380400001)(110136005)(66556008)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MU5JOHVyelF6YVc4NW9ua1hTTXdWczZJRUpVQXgrWXhPNWRHanFNTU5udzcy?=
 =?utf-8?B?SCszU0h2V3FncWxJY0JoazhNK2I5UXViSHNTcXFaY3Q0YWlGYW5yc3ZjdlZZ?=
 =?utf-8?B?NitaWU9lSForU3VOY0lMekxac1AvT0ExNWRicHRsUjFJUVY4MzhjbEF2ZE5Q?=
 =?utf-8?B?QWtGTnJHVmloMHhudHhhKzE3Zmx0QXV3Z3pEdG1XNXpsUk4vaXBjanRhbDJR?=
 =?utf-8?B?SFRRcXBjWnI0S21YOXdJajBJYkNTZTlTVVE0em5rUWNHY1ozcU4wQ2hhaHkv?=
 =?utf-8?B?d3lyZDVwSXlXSFBhNFRnN3lqLzVYUkFJSGowMXZlT0lPUGRreXkvWmg5RHhx?=
 =?utf-8?B?SnZDeXprSXBIQ0t2ZEZmbWo4QmpIL1dQYlRsRXlDL3NPbGVxRW55bkNaa0hn?=
 =?utf-8?B?dEdtdmNDMGxxcE1EZ1pxVEhJTyt3U1Q2VW8zNmxNVURTZ3YzTTR5LysvU2RO?=
 =?utf-8?B?NHRtcC9PaUFVMFMxcm5Dd09mMnMvZlZQdC9hU0VHVzQrQkZ2ZEc5bElwazJa?=
 =?utf-8?B?MDNUUnFCSEZFczZqOENnQ1p5d1FwZUFnckNWZEpRclBOdUdlTDRMZ1dPS09q?=
 =?utf-8?B?dDJ2ZE0vRElicGRZRkxPb1lwZlc2MkZRMmRKRTdtcXllSUtYTTBqcU4vbFYv?=
 =?utf-8?B?WXg5aE1SVUpzbjYrQlpEaUFPS3BoakVKclVQUUY3V25PeCt3Si9vUHdNay9Y?=
 =?utf-8?B?QlFDMlNydTZMUGJBV1dkVmc2VDVBWlFSSGt5TmJXRXJRdHFycjVMTXpvZThN?=
 =?utf-8?B?NXBuR1FzYnlzdjEyUmE2THJYU0xHenlZYnR2alhTZ1hMNmZGL0VPZFp3RXRS?=
 =?utf-8?B?VnhyakxwTFNMMXg2SGhKSUYvRXRNMVMxOUNyZ1R5QTdOdGpXc1crUDUwNkwz?=
 =?utf-8?B?T2dLc0w4WVA4TmxyK2gwRldwMEh2eHZoN2pMUEZLMXN3ZG1zOFpacVJ6MCtS?=
 =?utf-8?B?NW9BL29FVUl2OVhsWjNvakV5bHJCVWIwVFljQkhpVjQ0c3Y5T05DYTVXY2Rq?=
 =?utf-8?B?ZVJvcmt5MTJGT2U2dVpESE42ZWs0eFhXQ0FOWk1kREdTTzV3SVJldTFvNldv?=
 =?utf-8?B?VXV6U1MvRkZyR25QQTBxNXJpUXhEbnN1MHlzS0pYa1pEcUtCZXlDR0MxcXBO?=
 =?utf-8?B?MTJRaDR0dkQyQ3lmMFkvNThRWC9nUWxpcG9jRnZ2Nys3RC8vMklZcHdFajdx?=
 =?utf-8?B?RU4zZWpKaUpoOHFJcEZkMnlrM2FheitXbWJ6bXhvRHUva0hKRFhrV21KZ3RK?=
 =?utf-8?B?WWhaQVRjZHNmVlVoNkM2NWVxdlhZMU85Yk90RmYzeSszcmFDSnR3eUs1UjM4?=
 =?utf-8?B?U1N4bXBVQksvWXZXTU0rdXJ6bGJ1OHYvMjErKzVrMmJRN0NGSEpjS2o5eFlV?=
 =?utf-8?B?bzlTdVp5OXBGRndLSEdRRTkwaXFNM3l2aElya0JhcUltMGlTQ1ZXMkdTMStS?=
 =?utf-8?B?WHc4Y1FuK1o1QVZFbkRBMmdwUm5NNllVU1FqbE9wK2JQUFR1OVlQN3VkVDlj?=
 =?utf-8?B?bFdQSUVDbjR3U1c1NmtUcFE4UktLNmpWUjBaaEt1MmpSSEMzZlAwckxEREMy?=
 =?utf-8?B?ZWtreXE5TVFUL3pEL3ZLVzBXUE5SYTBrdFlvY1pXdzFlNUtXSEtodmFFcEUw?=
 =?utf-8?B?MWkweTVWUWRpT21od3FPcXY3dmg1S1NqQXlLN0hMaFllTGUzdUZyU1ArdjBC?=
 =?utf-8?B?ZjdNaXIvY1pkK2lpblhBYkcvN29PL08rSDNwaXVGNGYzV2xYbGpRTCtSOThn?=
 =?utf-8?B?aE5vV2ZIeVhhdlNBeDFtZlpWMHRHZEdnSm1iWXZ1THZEK2RreVBEWDVTN3lZ?=
 =?utf-8?B?MkdGYVR5UUVncUdDNENBb3VON3IwODd3S3BWYWVHYU40TVZjSUdRN0JnL29m?=
 =?utf-8?Q?u/i2DK+13bzvR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b48e01-1a8e-421c-3b48-08d8fe0e69c4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 23:55:13.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE65SN3WnQNejSThK+QsT2vUfC9+ACGUzsl/66ncpW61zKKFvGbqbXiPnz0SuM0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>It curious why ffmpeg does not cause such issues.
>For example such command not cause kernel panic:
>$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
>'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
>h264_vaapi output3.mp4

What command are you using to see the issue or how can the issue be reproduced?
Please file a freedesktop gitlab issue, so we can keep track of it.


On 2021-04-12 6:05 p.m., Mikhail Gavrilov wrote:

> Video demonstration: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fyoutu.be%2F3nkvUeB0GSw&amp;data=04%7C01%7Cleo.liu%40amd.com%7C87e4541e8fe14d78058108d8fdff115f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619239490302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CJRVsYixJlfnt5%2BkSCCi5BqP6WK9izh%2FE1ZMEsaR5rU%3D&amp;reserved=0
>
> How looks kernel traces.
>
> 1.
> [ 7315.156460] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
> obs:cs0 pid 23977)
> [ 7315.156490] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
> address 0x80011fdf5000 from client 18
> [ 7315.156495] amdgpu 0000:0b:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
> [ 7315.156500] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
> [ 7315.156503] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
> [ 7315.156505] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
> [ 7315.156509] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [ 7315.156510] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
> [ 7315.156513] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1
> [ 7315.156545] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault
> (src_id:0 ring:0 vmid:6 pasid:32779, for process obs pid 23963 thread
> obs:cs0 pid 23977)
> [ 7315.156549] amdgpu 0000:0b:00.0: amdgpu:   in page starting at
> address 0x80011fdf6000 from client 18
> [ 7315.156551] amdgpu 0000:0b:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00641A51
> [ 7315.156554] amdgpu 0000:0b:00.0: amdgpu: Faulty UTCL2 client ID: VCN1 (0xd)
> [ 7315.156556] amdgpu 0000:0b:00.0: amdgpu: MORE_FAULTS: 0x1
> [ 7315.156559] amdgpu 0000:0b:00.0: amdgpu: WALKER_ERROR: 0x0
> [ 7315.156561] amdgpu 0000:0b:00.0: amdgpu: PERMISSION_FAULTS: 0x5
> [ 7315.156564] amdgpu 0000:0b:00.0: amdgpu: MAPPING_ERROR: 0x0
> [ 7315.156566] amdgpu 0000:0b:00.0: amdgpu: RW: 0x1
>
> This is a harmless panic, but nevertheless VAAPI does not work and the
> application that tried to use the encoder crashed.
>
> 2.
> If we tries again and again encode 4K stream through VAAPI we can
> encounter the next trace:
> [12341.860944] ------------[ cut here ]------------
> [12341.860961] kernel BUG at drivers/dma-buf/dma-resv.c:287!
> [12341.860968] invalid opcode: 0000 [#1] SMP NOPTI
> [12341.860972] CPU: 28 PID: 18261 Comm: kworker/28:0 Tainted: G
> W        --------- ---  5.12.0-0.rc5.180.fc35.x86_64+debug #1
> [12341.860977] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
> [12341.860981] Workqueue: events amdgpu_irq_handle_ih_soft [amdgpu]
> [12341.861102] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
> [12341.861108] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
> ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
> 74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 90 0f
> [12341.861112] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
> [12341.861115] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
> [12341.861119] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
> [12341.861122] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [12341.861124] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
> [12341.861127] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
> [12341.861130] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
> knlGS:0000000000000000
> [12341.861133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12341.861136] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
> [12341.861139] Call Trace:
> [12341.861143]  amdgpu_vm_sdma_commit+0x182/0x220 [amdgpu]
> [12341.861251]  amdgpu_vm_bo_update_mapping.constprop.0+0x278/0x3c0 [amdgpu]
> [12341.861356]  amdgpu_vm_handle_fault+0x145/0x290 [amdgpu]
> [12341.861461]  gmc_v10_0_process_interrupt+0xb3/0x250 [amdgpu]
> [12341.861571]  ? _raw_spin_unlock_irqrestore+0x37/0x40
> [12341.861577]  ? lock_acquire+0x179/0x3a0
> [12341.861583]  ? lock_acquire+0x179/0x3a0
> [12341.861587]  ? amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
> [12341.861692]  amdgpu_irq_dispatch+0xc6/0x240 [amdgpu]
> [12341.861796]  amdgpu_ih_process+0x90/0x110 [amdgpu]
> [12341.861900]  process_one_work+0x2b0/0x5e0
> [12341.861906]  worker_thread+0x55/0x3c0
> [12341.861910]  ? process_one_work+0x5e0/0x5e0
> [12341.861915]  kthread+0x13a/0x150
> [12341.861918]  ? __kthread_bind_mask+0x60/0x60
> [12341.861922]  ret_from_fork+0x22/0x30
> [12341.861928] Modules linked in: uinput snd_seq_dummy rfcomm
> snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
> joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
> mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
> snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
> btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
> videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
> bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
> videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
> sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
> video
> [12341.861969]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
> soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
> iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
> crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
> i2c_algo_bit wmi pinctrl_amd fuse
> [12341.862012] ---[ end trace 3503913ed2bda6ad ]---
> [12341.862018] RIP: 0010:dma_resv_add_shared_fence+0x2ab/0x2c0
> [12341.862024] Code: fd ff ff be 01 00 00 00 e8 e2 74 dc ff e9 ac fd
> ff ff 48 83 c4 18 be 03 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f e9 c5
> 74 dc ff <0f> 0b 31 ed e9 73 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 90 0f
> [12341.862028] RSP: 0018:ffffb2f084c87bb0 EFLAGS: 00010246
> [12341.862035] RAX: 0000000000000002 RBX: ffff9f9551184998 RCX: 0000000000000000
> [12341.862039] RDX: 0000000000000002 RSI: 0000000000000000 RDI: ffff9f9551184a50
> [12341.862045] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [12341.862049] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9f91b9a18140
> [12341.862053] R13: ffff9f91c9020740 R14: ffff9f91c9020768 R15: 0000000000000000
> [12341.862057] FS:  0000000000000000(0000) GS:ffff9f984a200000(0000)
> knlGS:0000000000000000
> [12341.862062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12341.862066] CR2: 0000144e080d8000 CR3: 000000010e98c000 CR4: 0000000000350ee0
> [12341.862072] note: kworker/28:0[18261] exited with preempt_count 1
> [12392.114261] BUG: workqueue lockup - pool cpus=28 node=0 flags=0x0
> nice=0 stuck for 50s!
> [12392.114276] Showing busy workqueues and worker pools:
> [12392.114279] workqueue events: flags=0x0
> [12392.114283]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=12/256 refcnt=14
> [12392.114289]     in-flight: 26978:amdgpu_irq_handle_ih_soft [amdgpu]
> [12392.114411]     pending: amdgpu_irq_handle_ih_soft [amdgpu],
> free_work, kfree_rcu_monitor, free_obj_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> drm_mode_rmfb_work_fn [drm] BAR(2588), event_mall_stutter [amdgpu]
> [12392.114679]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=12/256 refcnt=13
> [12392.114684]     pending: psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work, psi_avgs_work, psi_avgs_work,
> psi_avgs_work, psi_avgs_work
> [12392.114704]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114708]     pending: kfree_rcu_monitor
> [12392.114727] workqueue mm_percpu_wq: flags=0x8
> [12392.114730]   pwq 56: cpus=28 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114734]     pending: vmstat_update
> [12392.114739]   pwq 54: cpus=27 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> [12392.114742]     pending: vmstat_update
> [12392.114826] pool 56: cpus=28 node=0 flags=0x0 nice=0 hung=50s
> workers=3 idle: 25238 14400
> [12394.038243] watchdog: BUG: soft lockup - CPU#27 stuck for 22s! [obs:27017]
> [12394.038262] Modules linked in: uinput snd_seq_dummy rfcomm
> snd_hrtimer netconsole nft_objref nf_conntrack_netbios_ns
> nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink cmac bnep sunrpc vfat fat hid_logitech_hidpp
> joydev hid_logitech_dj mt76x2u mt76x2_common mt76x02_usb mt76_usb
> mt76x02_lib intel_rapl_msr intel_rapl_common mt76 iwlmvm mac80211
> snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic ledtrig_audio
> snd_hda_codec_hdmi btusb kvm_amd snd_hda_intel btrtl snd_intel_dspcfg
> btbcm snd_intel_sdw_acpi snd_usb_audio uvcvideo btintel snd_hda_codec
> videobuf2_vmalloc snd_usbmidi_lib videobuf2_memops iwlwifi kvm
> bluetooth snd_rawmidi snd_hda_core snd_seq videobuf2_v4l2 snd_hwdep
> videobuf2_common snd_seq_device eeepc_wmi snd_pcm videodev asus_wmi
> sparse_keymap libarc4 mc irqbypass snd_timer ecdh_generic cfg80211
> video
> [12394.038306]  wmi_bmof rapl ecc snd sp5100_tco k10temp i2c_piix4
> soundcore rfkill acpi_cpufreq ip_tables amdgpu drm_ttm_helper ttm
> iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul cec crc32_pclmul
> crc32c_intel drm ghash_clmulni_intel igb nvme ccp dca nvme_core
> i2c_algo_bit wmi pinctrl_amd fuse
> [12394.038328] irq event stamp: 0
> [12394.038331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [12394.038337] hardirqs last disabled at (0): [<ffffffffaa0ddafb>]
> copy_process+0x91b/0x1e10
> [12394.038343] softirqs last  enabled at (0): [<ffffffffaa0ddafb>]
> copy_process+0x91b/0x1e10
> [12394.038347] softirqs last disabled at (0): [<0000000000000000>] 0x0
>
> This is much more dangerous and, as a rule, leads to system freezing.
>
> Full traces uploaded here:
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FaAeazCP8&amp;data=04%7C01%7Cleo.liu%40amd.com%7C87e4541e8fe14d78058108d8fdff115f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619239490302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J9Eu%2BBqznxPZpTeR%2ByvRF%2BEC8nBRQ8E%2FoNh9tZef2Zw%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FZLUP8Xvs&amp;data=04%7C01%7Cleo.liu%40amd.com%7C87e4541e8fe14d78058108d8fdff115f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637538619239490302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=MVnUbjJH7hilIQ3f2d2wWK04gDxFNCu5CqFRFIIRCrY%3D&amp;reserved=0
>
> It curious why ffmpeg does not cause such issues.
> For example such command not cause kernel panic:
> $ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0 -vf
> 'format=nv12,hwupload' -vaapi_device /dev/dri/renderD128 -vcodec
> h264_vaapi output3.mp4
>
> 1. Anyway, the user app shouldn't break the kernel.
> 2. Command above not working as expected because framerate is not 60
> on result video. The ended video is looking as grabbed at 1 frame per
> second or even less.
>
> My hardware:
> $ inxi -bM
> System:    Host: fedora Kernel:
> 5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 x86_64 bits: 64
> Desktop: GNOME 40.0
>             Distro: Fedora release 35 (Rawhide)
> Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
> v: Rev X.0x serial: <superuser required>
>             UEFI: American Megatrends v: 3603 date: 03/20/2021
> Battery:   ID-1: hidpp_battery_0 charge: N/A condition: N/A
> CPU:       Info: 16-Core (2-Die) AMD Ryzen 9 3950X [MT MCP MCM] speed:
> 3433 MHz min/max: 2200/3500 MHz
> Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
> RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
>             Device-2: AVerMedia Live Streamer CAM 513 type: USB driver:
> hid-generic,usbhid,uvcvideo
>             Device-3: AVerMedia Live Gamer Ultra-Video type: USB
> driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
>             Display: wayland server: X.Org 1.21.1 driver: loaded:
> amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
>             resolution: 3840x2160~60Hz
>             OpenGL: renderer: AMD SIENNA_CICHLID (DRM 3.40.0
> 5.12.0-0.rc6.20210408git454859c552da.186.fc35.x86_64 LLVM 12.0.0)
>             v: 4.6 Mesa 21.1.0-devel
> Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
>             Device-2: Intel I211 Gigabit Network driver: igb
> Drives:    Local Storage: total: 11.36 TiB used: 10.84 TiB (95.4%)
> Info:      Processes: 766 Uptime: 5h 12m Memory: 62.63 GiB used: 36.93
> GiB (59.0%) Shell: Bash inxi: 3.3.03
>
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
