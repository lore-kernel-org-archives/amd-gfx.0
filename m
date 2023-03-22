Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A04C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C912710E96D;
	Wed, 22 Mar 2023 14:29:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CA310E96D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFfgYcz5xoOYqrXa9HHXCxge9BGHp2vEIB2KvEuDtXzQuP4JfqLTu7+4p5ctnETtuAnOyWlsHeZmq+JHSpdYCpLDDTYlvUpGYKYLfRwtxqzTEV3/INo7fLY0Dz8VEJg4gKEYy7hvMzljk9FtFuBsjk3Qbz1jenDLYNHr/xwhZL1SH7rDDLBty50DGXsddLsyjaGLmQrf2Zd8DWQCfF41xjoSumKYcLHORHYfiSTKtEOzuCS/LksEMMIeZni3spv/ifwYCd/RGgHBZMzvcc2zIE5iA3mO2YmUSH46/tjCvGwpKO1k/WClTJFrZOZsozzqyswHJOfyTYNA2OfAa8RRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6tpCgX3U9GYB3iOCHu46MYd6irFIRHPqBFk4DfZ7iY=;
 b=K4wtpaloTg2VZDcNCmjbRn/8vYYAX3gATEqcZJxclLkajvw0I15Fgcmm6oCvXpkKV74Dot+UCVaSQF/Mso1mUsnnbW0Lq2J53X05czhtK47r2k80/+x5oQB2ANtqGcrsrFcRZncffEuKdv9dyqgNgf8e3+WDdTgBanbeFias9mB+/7HdVZfkDAdrKUUyBX0aWwgY1/XU3UZ6og5RYNsGsgUkMEp+EZUU6dOYpZZIA+8EaQvvcXjyIZpYvnMsi9+tgPWrLE8GHGRjoVOwGGpsrJkKGYs2//Vf/CigU+3Nxmrw02aFNFHpBIQcOayQVg2vSEqpc99xGpQx6ocYcjIDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6tpCgX3U9GYB3iOCHu46MYd6irFIRHPqBFk4DfZ7iY=;
 b=W/WZHdwupzMSKOuprFTPRJ0CzuzPpbl4rEHwIRJbiTL2+u0BHeoMA1XaX2Hbpp3h4UkGYr1xKfjdbODsNWYJxfoy0KKoMSTjCoWOp8mx0/qgZj8xPcs/cXwlHVshxkd7nmZgrAs6sLjW3FzkTfT5LlI/JlYaPdHYJf7gGKOBrJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:29:27 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:29:27 +0000
Content-Type: multipart/alternative;
 boundary="------------003nZOobJyuGLfBSGWhlh6Lr"
Message-ID: <ea9ce74c-664c-47de-c750-bd4f3893ac72@amd.com>
Date: Wed, 22 Mar 2023 15:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
 <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
 <CAAxE2A66ZF==rvDd8KFrfz79rXBB52vnWU7zsM+rfH69OV0Psw@mail.gmail.com>
 <ac80456d-ac57-dbf4-dca0-7f92a40bb603@amd.com>
 <CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 588adcc6-d0d5-456a-e0c0-08db2ae1d710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7EGq4o/shOmCr7vF5gjBqnz126/MAW7BTd/CNVaxY2n+yNt/MIAg2edLqjsXOvNpkYzq6S+rzB43rhVz7RSKS2ow3BNTR7nV5KtFrM/CKWu2f1P9BSVlCcQ+DOqscDAilhXsEwFGbl+yvM11VF9/Jj2JTET+70IDSzoM9D1mew1D7K0OIFpEvQZklgmwkmss88lG/RDHEmRA3EMr1lQo8Apo6wjfSCo51PLD4AV2sN8Rb4N0gnE3L6626AGqsn3LcmgoOEfKY9THiunicF8A4sDnjIFqjixEWMFpHteEXk0+dxw0ZkQrgdrhY61X+JGAHssee90C/TKbku1AWvDYLOf8yZwfSGVSlIoT/q+TSF6zFkf6XWp7buafI6xODZn8ErlCcApxUQpfDJLoyYHeSSU7IjaLNdsuQP6gsx5fbcvuzRGSOzpvUdFS+e+6qNLpYUe+q+rnBWeBloAO4H2YgJJnJN9ZxJbYJrUBeVdY6dbq8aWg70JZOQmaEDA48N6pxn1pdN/ni9z9sHru7uC1bhLcgrZoIKS0ORNwu7/BlBLAfiUTprLHOtjLpdluYN9Frx2NcZePpnOOdt9WDDqbcJQqGJy1r7mJhxAjU9R4e5PQK20JLgcIHqIaUTXwnx/Gjzk3ihHK+4hsO3nzyXtXroPWYyGQWr/bDOQKvS0C1HsLE6vqU6RvRtv5M6JT/or
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(86362001)(166002)(31696002)(36756003)(38100700002)(8936002)(4326008)(6916009)(2906002)(5660300002)(30864003)(41300700001)(66574015)(8676002)(2616005)(53546011)(33964004)(83380400001)(186003)(6506007)(316002)(54906003)(6666004)(66946007)(6486002)(966005)(66556008)(66476007)(6512007)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBDOHFBUEFOQ0ltSU5TaUNyMEY0dkJlMVZxNXN1VURKYXhVSVVYU3ZtSUZW?=
 =?utf-8?B?ek9UY1kwTFlDeDVyOXlwbEFGVXk5S21VMVQ4a1pMRkNNUncxUDE5RUtPbHBL?=
 =?utf-8?B?OGpiU0gwbko5V1hPVzlSOU51SVJmZGcwdG9kRUxTeUVEbjVxWDBYOVB1YzdQ?=
 =?utf-8?B?aDAxZmFsd3BaOTVzcFhrRTZ3c3dya2diZXF2b3VNWlp2aE5ZeDNMUW1GeGRU?=
 =?utf-8?B?ejMxZ1JrL2FNZDBaN3JBdGd4Z3NqNnVobHZ3LzV4ZlYzemF4QzR5RStyYW83?=
 =?utf-8?B?S1RyRkN0dkh3K0lkWW9ad3Rtbmd5UmVXUnptbEpyeDYxQXFoVjlDTTBPcDVK?=
 =?utf-8?B?YjNXajhmYVAxQWNjQVZiRmx6THlvWUtGenBjdzJja3h5UjdldjFYS0dqbEN1?=
 =?utf-8?B?bzE2NnFXOWZma3JFblJoN3JCOUVVRWFrR3dyUXowb0NYRENKUUd1RzROV1Vv?=
 =?utf-8?B?cjVDa3FyR2Y2MTU3Szl4VGdNYjkyQ1h0UlA5ZVAxOExBY0FJdG9YTlN5U0oz?=
 =?utf-8?B?NW1JaExNM0VlZ3M5OHFJbk5kTGx6Vm1WbllXRnlhMFlTbXNQL3FqVG5lMXBs?=
 =?utf-8?B?czZ4Uk1xSkJ5ZWM5Nmpqc0Q0citBOENNUkFTaE83cFNqM1FDSi8waWdocjdM?=
 =?utf-8?B?Y1BMRXcxU1hnSTQvWXFMaFE2OG05OUIzS2pLTW9IbVZQNjdXdW51RlkwSFZN?=
 =?utf-8?B?eFhxdGRLRkxZTFVqT2hNaFJ1VmhORXZUY1ViSUlteVl4MHhjSVJPS1dteHVE?=
 =?utf-8?B?aFhMbmV2aGplQW5mQWJYYmZKclBCQXdsYmZiY1FmRU91L3ljbGJ6WFA2TE52?=
 =?utf-8?B?ck4zZU9YTHZnUjhuZ2pnM2JNeFljcnppYXIvcmNsVnRpU09Mc2N0VmNqWjla?=
 =?utf-8?B?UGJPeXFpSStpdXFNL1RLcjZxbEtvZzBFMmNKTnZYdHRRalJCelRUYmpod3I2?=
 =?utf-8?B?WVM4OG1OMUR1UFVVV0RJR1lBWTQwWjRXck41NnFQcVVRSW5IcGxmd2QzTktN?=
 =?utf-8?B?aCtBY3RMTm1TRm1JSSs0bjRVRHRnME9Cd2lXbnNWbkoyUU1SanpMTFRsL2Zy?=
 =?utf-8?B?bklkM2xVRUFNdHNPRGo5VDZhN0piVmF3Y2FtWFpQc3pnM2ZlemFHbTNmNWU5?=
 =?utf-8?B?eCsvbVluMXkzcys0OGtERWpoMVR6M1JRZzN4QWRUczFpeHlsZjdHNVNRUElE?=
 =?utf-8?B?RU9ibURhakFTMXM5VVRsdlJwbXdPL25RYzlSaFM2b1ZjUzAzRlNCaVZxbTM2?=
 =?utf-8?B?VVJvcGVFRzYrVWNka0t0bHRBVlRLV3o0UHliT1NLNUcxaWdMajhSUmkyRW9S?=
 =?utf-8?B?U290UWpXMjhFbUllUUl5eHhTdkpaeTU0UlFjOFM5dzErNUw2T3luWW9Xdlpi?=
 =?utf-8?B?eHdwYTFwSVplN2NwajlFY1lIQW5LSTlOSVVDZ0FSSmxIaStBVStjREJWTVZE?=
 =?utf-8?B?aE5EUlFVdjdnV05BT0xyMmk4Y1ViSWdDZG5iRXVpZUVZa1loUlhteFZiZDVZ?=
 =?utf-8?B?bjc0a3hsOThyS0ZsTlpwcTR1NURFZERKalFPT2wrdmJUUnVyUXJ5R3pmSmcr?=
 =?utf-8?B?c05JYnV5bCtQdmg5YS9wenhWZGhuM2ZhQ0lQVkhCMW8rN2dOanY3c3hUM1lV?=
 =?utf-8?B?NnhGR09INlVBRlg4akhvS0w3UC85YWlobEZvZzBFK2crOHJtYVVmTlVWVXhx?=
 =?utf-8?B?ZEhQU2cxaSt5a0JaM2hRK3lzNGJvT2NNLytxcDA1VVl1VFRaWVJTMXBxS1V0?=
 =?utf-8?B?cHVMNGNpaHc5MWJsMmFBa0s4R1pEUUE4ZlphS05vOTBxV3ZKL2I0VUhRSlN0?=
 =?utf-8?B?ZXpGb2pJYmtJSXZXNGhQQk1pZURveEo0V0dXcEtraXZLMWNyMk11Mkxyc3Jw?=
 =?utf-8?B?bzF0dXRsaVN4OW5aNzBvaDkyTWxIN014RWpNNGZMSUVsYmFJUDlzYW9pMjVi?=
 =?utf-8?B?SHpUdXJnRlRmT2p3MFBhVGdwamI0Zk40aG9wMEowVFdtKzVOMXdpbVI0YXpl?=
 =?utf-8?B?VWd4VmdwVjRwTTlPYWtvSVViTWNDM3RGaGVzNlBoZjdXNlFiTXhlN2VIWGZF?=
 =?utf-8?B?b2RGTDZTcWxKVVlpZXBJUUFRZ0pJcnhQd3diU08xM3FxOEdHaEJnMk9RL085?=
 =?utf-8?B?NW1rZktRQTBodE1KRlZPeUYvdUYvWTBDQlZ5ZzNIRGkrdFlYRC9NVFIyU0xk?=
 =?utf-8?Q?LcF/DbCBKncUUiFiclg6nzQXD37xHvCpFthpLVYvvc6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588adcc6-d0d5-456a-e0c0-08db2ae1d710
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:29:26.9304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhOczCSzb4srXWtGw3LCH+cp7dvC8lxA9Fb74RWE7q3wACV39/lMC2Bw+rNykKtP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------003nZOobJyuGLfBSGWhlh6Lr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well that sounds like being able to optionally set it after context 
creation is actually the right approach.

VA-API could set it as soon as we know that this is a video codec 
application.

Vulkan can set it depending on what features are used by the application.

But yes, Shashank (or whoever requested that) should come up with some 
code for Mesa to actually use it. Otherwise we don't have the 
justification to push it into the kernel driver.

Christian.

Am 22.03.23 um 15:24 schrieb Marek Olšák:
> The hint is static per API (one of graphics, video, compute, unknown). 
> In the case of Vulkan, which exposes all queues, the hint is unknown, 
> so Vulkan won't use it. (or make it based on the queue being used and 
> not the uapi context state) GL won't use it because the default hint 
> is already 3D. That makes VAAPI the only user that only sets the hint 
> once, and maybe it's not worth even adding this uapi just for VAAPI.
>
> Marek
>
> On Wed, Mar 22, 2023 at 10:08 AM Christian König 
> <christian.koenig@amd.com> wrote:
>
>     Well completely agree that we shouldn't have unused API. That's
>     why I said we should remove the getting the hint from the UAPI.
>
>     But what's wrong with setting it after creating the context? Don't
>     you know enough about the use case? I need to understand the
>     background a bit better here.
>
>     Christian.
>
>     Am 22.03.23 um 15:05 schrieb Marek Olšák:
>>     The option to change the hint after context creation and get the
>>     hint would be unused uapi, and AFAIK we are not supposed to add
>>     unused uapi. What I asked is to change it to a uapi that
>>     userspace will actually use.
>>
>>     Marek
>>
>>     On Tue, Mar 21, 2023 at 9:54 AM Christian König
>>     <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>         Yes, I would like to avoid having multiple code paths for
>>         context creation.
>>
>>         Setting it later on should be equally to specifying it on
>>         creation since we only need it during CS.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>>>
>>>         [AMD Official Use Only - General]
>>>
>>>         When we started this patch series, the workload hint was a
>>>         part of the ctx_flag only,
>>>
>>>         But we changed that after the design review, to make it more
>>>         like how we are handling PSTATE.
>>>
>>>         Details:
>>>
>>>         https://patchwork.freedesktop.org/patch/496111/
>>>
>>>         Regards
>>>
>>>         Shashank
>>>
>>>         *From:*Marek Olšák <maraeo@gmail.com> <mailto:maraeo@gmail.com>
>>>         *Sent:* 21 March 2023 04:05
>>>         *To:* Sharma, Shashank <Shashank.Sharma@amd.com>
>>>         <mailto:Shashank.Sharma@amd.com>
>>>         *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander
>>>         <Alexander.Deucher@amd.com>
>>>         <mailto:Alexander.Deucher@amd.com>; Somalapuram, Amaranath
>>>         <Amaranath.Somalapuram@amd.com>
>>>         <mailto:Amaranath.Somalapuram@amd.com>; Koenig, Christian
>>>         <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>
>>>         *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for
>>>         workload hints to ctx ioctl
>>>
>>>         I think we should do it differently because this interface
>>>         will be mostly unused by open source userspace in its
>>>         current form.
>>>
>>>         Let's set the workload hint in drm_amdgpu_ctx_in::flags, and
>>>         that will be immutable for the lifetime of the context. No
>>>         other interface is needed.
>>>
>>>         Marek
>>>
>>>         On Mon, Sep 26, 2022 at 5:41 PM Shashank Sharma
>>>         <shashank.sharma@amd.com> wrote:
>>>
>>>             Allow the user to specify a workload hint to the kernel.
>>>             We can use these to tweak the dpm heuristics to better match
>>>             the workload for improved performance.
>>>
>>>             V3: Create only set() workload UAPI (Christian)
>>>
>>>             Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>             Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>             ---
>>>              include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>>>              1 file changed, 17 insertions(+)
>>>
>>>             diff --git a/include/uapi/drm/amdgpu_drm.h
>>>             b/include/uapi/drm/amdgpu_drm.h
>>>             index c2c9c674a223..23d354242699 100644
>>>             --- a/include/uapi/drm/amdgpu_drm.h
>>>             +++ b/include/uapi/drm/amdgpu_drm.h
>>>             @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>>>              #define AMDGPU_CTX_OP_QUERY_STATE2  4
>>>              #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>>>              #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>>>             +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>>>
>>>              /* GPU reset status */
>>>              #define AMDGPU_CTX_NO_RESET 0
>>>             @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>>>              #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>>>              #define AMDGPU_CTX_STABLE_PSTATE_PEAK 4
>>>
>>>             +/* GPU workload hints, flag bits 8-15 */
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT    8
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_MASK     (0xff <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_NONE     (0 <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_3D     (1 <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO    (2 <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_VR     (3 <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +#define AMDGPU_CTX_WORKLOAD_HINT_MAX  
>>>             AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>>>             +#define AMDGPU_CTX_WORKLOAD_INDEX(n)   (n >>
>>>             AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>>>             +
>>>              struct drm_amdgpu_ctx_in {
>>>                     /** AMDGPU_CTX_OP_* */
>>>                     __u32   op;
>>>             @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>>>                                     __u32   flags;
>>>                                     __u32   _pad;
>>>                             } pstate;
>>>             +
>>>             +               struct {
>>>             +                       __u32   flags;
>>>             +                       __u32   _pad;
>>>             +               } workload;
>>>              };
>>>
>>>              union drm_amdgpu_ctx {
>>>             -- 
>>>             2.34.1
>>>
>>
>

--------------003nZOobJyuGLfBSGWhlh6Lr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Well that sounds like being able to optionally set it after context
    creation is actually the right approach.<br>
    <br>
    VA-API could set it as soon as we know that this is a video codec
    application.<br>
    <br>
    Vulkan can set it depending on what features are used by the
    application.<br>
    <br>
    But yes, Shashank (or whoever requested that) should come up with
    some code for Mesa to actually use it. Otherwise we don't have the
    justification to push it into the kernel driver.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 22.03.23 um 15:24 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A60VNbjKS3LpKjX=Y9gPD92gw4hBJpQApmcQKCu0UM4UQ@mail.gmail.com">
      
      <div dir="ltr">
        <div>The hint is static per API (one of graphics, video,
          compute, unknown). In the case of Vulkan, which exposes all
          queues, the hint is unknown, so Vulkan won't use it. (or make
          it based on the queue being used and not the uapi context
          state) GL won't use it because the default hint is already 3D.
          That makes VAAPI the only user that only sets the hint once,
          and maybe it's not worth even adding this uapi just for VAAPI.<br>
        </div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, Mar 22, 2023 at
            10:08 AM Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div> Well completely agree that we shouldn't have unused
              API. That's why I said we should remove the getting the
              hint from the UAPI.<br>
              <br>
              But what's wrong with setting it after creating the
              context? Don't you know enough about the use case? I need
              to understand the background a bit better here.<br>
              <br>
              Christian.<br>
              <br>
              <div>Am 22.03.23 um 15:05 schrieb Marek Olšák:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div>The option to change the hint after context
                    creation and get the hint would be unused uapi, and
                    AFAIK we are not supposed to add unused uapi. What I
                    asked is to change it to a uapi that userspace will
                    actually use.<br>
                  </div>
                  <div><br>
                  </div>
                  <div>Marek<br>
                  </div>
                </div>
                <br>
                <div class="gmail_quote">
                  <div dir="ltr" class="gmail_attr">On Tue, Mar 21, 2023
                    at 9:54 AM Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">
                    <div> Yes, I would like to avoid having multiple
                      code paths for context creation.<br>
                      <br>
                      Setting it later on should be equally to
                      specifying it on creation since we only need it
                      during CS.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      <div>Am 21.03.23 um 14:00 schrieb Sharma,
                        Shashank:<br>
                      </div>
                      <blockquote type="cite">
                        <div>
                          <p style="margin:0cm"><span style="font-size:10pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                              Official Use Only - General]</span></p>
                          <p class="MsoNormal">&nbsp;</p>
                          <p class="MsoNormal"><span>When we started
                              this patch series, the workload hint was a
                              part of the ctx_flag only, </span></p>
                          <p class="MsoNormal"><span>But we changed that
                              after the design review, to make it more
                              like how we are handling PSTATE. </span></p>
                          <p class="MsoNormal"><span>&nbsp;</span></p>
                          <p class="MsoNormal"><span>Details: </span></p>
                          <p class="MsoNormal"><span><a href="https://patchwork.freedesktop.org/patch/496111/" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://patchwork.freedesktop.org/patch/496111/</a>
                            </span></p>
                          <p class="MsoNormal"><span>&nbsp;</span></p>
                          <p class="MsoNormal"><span>Regards</span></p>
                          <p class="MsoNormal"><span>Shashank </span></p>
                          <p class="MsoNormal"><span>&nbsp;</span></p>
                          <div style="border-color:rgb(225,225,225)
                            currentcolor currentcolor;border-style:solid
                            none none;border-width:1pt medium
                            medium;padding:3pt 0cm 0cm">
                            <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span lang="EN-US"> Marek Olšák <a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true">&lt;maraeo@gmail.com&gt;</a>
                                <br>
                                <b>Sent:</b> 21 March 2023 04:05<br>
                                <b>To:</b> Sharma, Shashank <a href="mailto:Shashank.Sharma@amd.com" target="_blank" moz-do-not-send="true">&lt;Shashank.Sharma@amd.com&gt;</a><br>
                                <b>Cc:</b> <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                                Deucher, Alexander <a href="mailto:Alexander.Deucher@amd.com" target="_blank" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                                Somalapuram, Amaranath <a href="mailto:Amaranath.Somalapuram@amd.com" target="_blank" moz-do-not-send="true">&lt;Amaranath.Somalapuram@amd.com&gt;</a>;
                                Koenig, Christian <a href="mailto:Christian.Koenig@amd.com" target="_blank" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                                <b>Subject:</b> Re: [PATCH v3 1/5]
                                drm/amdgpu: add UAPI for workload hints
                                to ctx ioctl</span></p>
                          </div>
                          <p class="MsoNormal">&nbsp;</p>
                          <div>
                            <div>
                              <p class="MsoNormal">I think we should do
                                it differently because this interface
                                will be mostly unused by open source
                                userspace in its current form.</p>
                            </div>
                            <div>
                              <p class="MsoNormal">&nbsp;</p>
                            </div>
                            <div>
                              <p class="MsoNormal">Let's set the
                                workload hint in
                                drm_amdgpu_ctx_in::flags, and that will
                                be immutable for the lifetime of the
                                context. No other interface is needed.</p>
                            </div>
                            <div>
                              <p class="MsoNormal">&nbsp;</p>
                            </div>
                            <div>
                              <p class="MsoNormal">Marek</p>
                            </div>
                          </div>
                          <p class="MsoNormal">&nbsp;</p>
                          <div>
                            <div>
                              <p class="MsoNormal">On Mon, Sep 26, 2022
                                at 5:41 PM Shashank Sharma &lt;<a href="mailto:shashank.sharma@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;
                                wrote:</p>
                            </div>
                            <blockquote style="border-color:currentcolor
                              currentcolor currentcolor
                              rgb(204,204,204);border-style:none none
                              none solid;border-width:medium medium
                              medium 1pt;padding:0cm 0cm 0cm
                              6pt;margin:5pt 0cm 5pt 4.8pt">
                              <p class="MsoNormal" style="margin-bottom:12pt">Allow the
                                user to specify a workload hint to the
                                kernel.<br>
                                We can use these to tweak the dpm
                                heuristics to better match<br>
                                the workload for improved performance.<br>
                                <br>
                                V3: Create only set() workload UAPI
                                (Christian)<br>
                                <br>
                                Signed-off-by: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
                                Signed-off-by: Shashank Sharma &lt;<a href="mailto:shashank.sharma@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;<br>
                                ---<br>
                                &nbsp;include/uapi/drm/amdgpu_drm.h | 17
                                +++++++++++++++++<br>
                                &nbsp;1 file changed, 17 insertions(+)<br>
                                <br>
                                diff --git
                                a/include/uapi/drm/amdgpu_drm.h
                                b/include/uapi/drm/amdgpu_drm.h<br>
                                index c2c9c674a223..23d354242699 100644<br>
                                --- a/include/uapi/drm/amdgpu_drm.h<br>
                                +++ b/include/uapi/drm/amdgpu_drm.h<br>
                                @@ -212,6 +212,7 @@ union
                                drm_amdgpu_bo_list {<br>
                                &nbsp;#define AMDGPU_CTX_OP_QUERY_STATE2&nbsp; &nbsp;
                                &nbsp;4<br>
                                &nbsp;#define
                                AMDGPU_CTX_OP_GET_STABLE_PSTATE&nbsp; &nbsp; &nbsp; &nbsp; 5<br>
                                &nbsp;#define
                                AMDGPU_CTX_OP_SET_STABLE_PSTATE&nbsp; &nbsp; &nbsp; &nbsp; 6<br>
                                +#define
                                AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE&nbsp; &nbsp; &nbsp;7<br>
                                <br>
                                &nbsp;/* GPU reset status */<br>
                                &nbsp;#define AMDGPU_CTX_NO_RESET&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                0<br>
                                @@ -252,6 +253,17 @@ union
                                drm_amdgpu_bo_list {<br>
                                &nbsp;#define
                                AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK&nbsp; 3<br>
                                &nbsp;#define AMDGPU_CTX_STABLE_PSTATE_PEAK&nbsp;
                                4<br>
                                <br>
                                +/* GPU workload hints, flag bits 8-15
                                */<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT&nbsp;
                                &nbsp; &nbsp;8<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_MASK&nbsp;
                                &nbsp; &nbsp; (0xff &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_NONE&nbsp;
                                &nbsp; &nbsp; (0 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_3D&nbsp; &nbsp;
                                &nbsp; &nbsp; (1 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO&nbsp;
                                &nbsp; &nbsp;(2 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_VR&nbsp; &nbsp;
                                &nbsp; &nbsp; (3 &lt;&lt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define
                                AMDGPU_CTX_WORKLOAD_HINT_COMPUTE&nbsp; &nbsp;(4
                                &lt;&lt; AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +#define AMDGPU_CTX_WORKLOAD_HINT_MAX&nbsp; &nbsp;
                                &nbsp; AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
                                +#define AMDGPU_CTX_WORKLOAD_INDEX(n)&nbsp; &nbsp;
                                &nbsp; (n &gt;&gt;
                                AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
                                +<br>
                                &nbsp;struct drm_amdgpu_ctx_in {<br>
                                &nbsp; &nbsp; &nbsp; &nbsp; /** AMDGPU_CTX_OP_* */<br>
                                &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;op;<br>
                                @@ -281,6 +293,11 @@ union
                                drm_amdgpu_ctx_out {<br>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;flags;<br>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __u32&nbsp; &nbsp;_pad;<br>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } pstate;<br>
                                +<br>
                                +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct {<br>
                                +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; &nbsp;flags;<br>
                                +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__u32&nbsp; &nbsp;_pad;<br>
                                +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} workload;<br>
                                &nbsp;};<br>
                                <br>
                                &nbsp;union drm_amdgpu_ctx {<br>
                                -- <br>
                                2.34.1</p>
                            </blockquote>
                          </div>
                        </div>
                      </blockquote>
                      <br>
                    </div>
                  </blockquote>
                </div>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------003nZOobJyuGLfBSGWhlh6Lr--
