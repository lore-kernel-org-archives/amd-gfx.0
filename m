Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523C3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CEE64F30
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 09:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CEE64F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FC46E8BF;
	Thu, 18 Mar 2021 09:51:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0DD6E8BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 09:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aemrqO6xD/TwC2SZ/oKGAXKZyMn7Qow/W4Dceifasie3FPzxLey4neN77RJmGnpUhXJfVT+50FM/VLj2ZjWp/T2l4F8IJsqQkGZviYpmzLHdB3zC/MPX34JsPsHSY8ZE75GHQPeTI2P/+QGr1vHd+3CEO/nOvTHM+JOv01iqCZ3GIzOa3mCASH/gY4uTp+K+AUugCgIlxtDLIuyT9jz0JDNEDuPNs501zT2hGFji3my6iNtjscVb+D0nsl2RJX03FTealeDhT6Dn4WvEiBm/pXkm8ZmlYTifiNQBjoB1DI56woQtZqwMmzne9S+DNcfAdFEmVuYmUnrT0CjyYxlY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYeHGJ7M9vUkXAg+ts/YlStZ+/1Y/rKW+VJudYKNy+Q=;
 b=nipJaFnD9zCBH67sQgilCOfKKycNyu18nZf/+wgHxReiwZoMWdqiQ0tF/Of83hLAiksndixX7BOlpDO6nbdaOsArtHvBiHPLZTO7m+0fnZUzuL6t5esdB9iT9Eo3Mn/txUdFjB+CD9tiMJjvkHXhyGh6cELvbXd2vUhmjDKvlhXmGgUswh6SFYGA1cGHi8IT5lTZUqFSwWqcDoIahOA60RunVRYGgCxFggU5DJ0zFDL09aoQnaDgDoMq5+FJeizk31w9gM+MlmErWvsn/vwgwHOoKr2moA8kidc/C6EPzQZn0Ljt1T1Zt4+VWSR92OyubSa8XAR/EpxrTSxzotkGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYeHGJ7M9vUkXAg+ts/YlStZ+/1Y/rKW+VJudYKNy+Q=;
 b=LAohzt9AYD/2gbFbLFI4kQS8mV8SPrSUMMn6oNOsUlpOgPj9e8CGOSty5iHdA6YyDMeLM78xbNas4nkIDJ9ttsSWyOLDctEMQCyFCiKzRk4n5JFmv1L14vix0GATl1exc0S6P5HgZmgkRnbeo/u6n4va9yZbDcX/Qe2S+6iImG4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 09:51:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 09:51:38 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
Date: Thu, 18 Mar 2021 10:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c886:8ff9:f88f:26b8]
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c886:8ff9:f88f:26b8]
 (2a02:908:1252:fb60:c886:8ff9:f88f:26b8) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.10 via Frontend Transport; Thu, 18 Mar 2021 09:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8e65234-0e83-4aeb-3718-08d8e9f36c79
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191ACE46CF17277FF6EC11483699@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLoDLajlMI1wV/k/eF5QUaq8p+Ylr7GHUke1RTJPwPx+7VfICJyILFxK19bqa3bh4Ix/5dpVCbavXES46ITy/WBzcb3nEabDljqxNhM+kzHbkGNaeC5zqNHDE3sN6CeRQEKnXVCC9JI751TubgkwiDW4ibtp3X2VqiqcidTygOnKFnJttSv1l6QCtWXwQBN91qvZORcoZppiW9DlXlmCBnzM67qr+bmQna5Mo+le3pztLrIgbjtUOrJKhEf3/81LSYi3Dl3UjvmYEMyGQgTikZgpXd6yXMz4ZWJiKsvCZ9GH7oDetSh+x5252QwpBA3sOrbkGle7J9HP3TW31bTAAQsryMrot1P6EswhgF6do+flAqsYCLz3bWQ7Ih0lZ6pcV69rRhF69RC5YV6izI/ym9Bug39GWwhTdW1THY4yZmsmg+EnoS4x48/tBjJQS/FCtIEZMHVX2vKY+gWXV8O3nN4oGDbyVkawsYvWRnN+s7KecJGC6CTn+LnKHELYRQ7xZb8E7basyMiGBkJNd2WZI52rsGQeQdMCLadkKFuVYo4NF+eGqudVhJ52Aws+zU2gF8PlqGXsZJcPPCnOGr+xpOJWBqjid9qgJtmblUi4LtNK/vUMnYw63bsVgzoqTIZ1r50rzwPIQ3+I8Rpn+dnBqMRZxCFqrTvNk5UBjhSn3e8msiFDzdihFHcPqpIH5Ml+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(66946007)(2616005)(31696002)(2906002)(6666004)(66556008)(86362001)(5660300002)(186003)(30864003)(66476007)(110136005)(36756003)(6636002)(6486002)(31686004)(16526019)(478600001)(83380400001)(316002)(66574015)(8936002)(52116002)(53546011)(8676002)(33964004)(38100700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVBLMFJaOWpOazZqT2liNFF3WHBHL01McDY1eDg5TnA0WTVXamxPZ2w4Q1FE?=
 =?utf-8?B?cFZTNjg1RVh6TUFPT214N1BBQ1UwcS9aVjg5dHpaaU16bDVrbkNaR1pveUhp?=
 =?utf-8?B?Tkc5QjN0QWdBTWNEYkdMK0ZxbjEzQUEwcUx6ZzdWTzlINmR1VDRjcG1ua3Vo?=
 =?utf-8?B?SjJZd1ZMUnhHQzdHN0xMdTJkQkNYeDFHYmtwTVcvazUwdUhEVFdxeGFhcnJC?=
 =?utf-8?B?VHBvMy9aU2pwTWNQRHBubW5GVTdnM1FPYjZ2RVpXNkFHS3NHaXBxWW5JdzNC?=
 =?utf-8?B?NEtzMTVNNjFHQld0WlBOTkUvTkVoTHFpWWEvRE1rQmNkQWdtWG1YMkpmZVpr?=
 =?utf-8?B?OVBXUkgwd0l1VDJjR3JzdXdzQ01rUWIvNndjQm95MUFxd1B3eVdzalRYSDZi?=
 =?utf-8?B?TEtzcEFUSmtBaEZ6OHMwVXljOEFqd3o4cjhrcFZvNVhmajNOQy9WSkFDbkNz?=
 =?utf-8?B?T0NRTXhXTlkrRmMrT2xDQ0dkZmVOYitaQmk0b29aTzQ0M0lqcElpSmdQck04?=
 =?utf-8?B?SDdTdnFSdzVkYWdoR0htbzVHUEM2OGJvK3dIOVlnMTRwelJua0gvTm1xQ1R5?=
 =?utf-8?B?c1hvMUp2VjdGY3VITEJjUm4vTDRGR05CbmNVZzM5UEpnQUlOYzhsWGxMRllZ?=
 =?utf-8?B?MHhWb0pVbXNmaVFrZXV4MnJSNnNVendDMytIbDIraXN4Q09nTTZ6K29QOGJD?=
 =?utf-8?B?RlhuU0lRa1RqbHM1OHJPM3RNUXRYdnlWQm0wVkxVS3E4aDdkMHpmaEZ3dzRn?=
 =?utf-8?B?S0Z1c2dicmRxRUxGVXVTeHRVVkVDRXRGbWIzVjVvRFRmOGwySENmY0k4dHB0?=
 =?utf-8?B?Z09iODN6ZllWR21SSUFnNUhrMjFCZURwT3BvRGdLUzliMlpOUW4zblJhUC9j?=
 =?utf-8?B?aWFvRjhmWit1SG1DL3hwOU5Kc1gyZ3VDMDBXc09FOUZZcmlDcllhYkQ4T3ZW?=
 =?utf-8?B?cnVlYUJyd3ZOaC9JSmIrMzFRSko4SEx4cnV5QzQvQitUenBvbFNOeHdsSE5G?=
 =?utf-8?B?L1JrZkJoVVQ1bEFRWEpnZUI1a1dUWEt0dkFOeVVMQkVQT2lFSm84QnZzTnBP?=
 =?utf-8?B?eHkvaWRTUzRPTzVMNjM1aDAyeW5oNWNKU2NVakJKWit1bFAwSzhhY2h6ejJI?=
 =?utf-8?B?ejRhMXhsNDNRNFgzMHloSDVxMWlvTEhwVkJiT3FISnllYVlwak9OL2RrTkYw?=
 =?utf-8?B?NzRtQlh1elR4c1ZMT1g4T0pQeGVXRVlwTGFaZnZPTHp1bm10Q1dWZ2VGNElT?=
 =?utf-8?B?bmQ1NGZ6YlJXaUswUGFNdXc5YUhWWHE1UW1Rbk84dkpRUjVPQWJQR1FUZFVP?=
 =?utf-8?B?QTlydUtwTHZGU2xiUWFLSldMQlFxV0kxVEYra21rSi9Ra2lkb1EvbkcyMjNF?=
 =?utf-8?B?QW5WZlB0N09vcmlxd2dyZ1Fwdk9ZSjhUbEJ5RWRrbkZtaHVyUUhuQldRa25M?=
 =?utf-8?B?NGR5YXZWR3had3ZUVlNuZVRoL0NRdlhtK2NHZU1EYVZrWCt5bzlXcUZwZmNO?=
 =?utf-8?B?d1VuaDZyaVlkeDcxQ3VzWjZKeklsT3A0ZzgvMUNnSzZZd21TZ0xHQ2RhSVFN?=
 =?utf-8?B?SWp0aHd6czBHOUlveS9va3FETkNJbnl4ay9XSG56TTh3OTVnUzMrQ1pEdkRK?=
 =?utf-8?B?L3BoN3d6QnpQNzZCWFpXanR5bE5lN3BWUG1CbktTS0daclI5aTNId0ZIK0ha?=
 =?utf-8?B?K1c1WmZDLytOQ1hjNXVrVlJXSkkxdjhqRHlJR2djTGdYejVMcVUwcFNRQm53?=
 =?utf-8?B?QW5DcjFtOXlFWmVuN08yQlQxRUZEajdOaUt1M2cwbU1hV2RuN1ZzYzh4MmRO?=
 =?utf-8?B?Rm44QmExaDdwTGk2aEdRekNyTmVadk1ha3BiUHBRREEwd2pBL3EzWHNwNSsw?=
 =?utf-8?Q?llmLEldmONlQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e65234-0e83-4aeb-3718-08d8e9f36c79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 09:51:38.5419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPjM5dwhQ6MYji/yrrxX3j5bMsUkNaVoFaPcQyanAdOSqovWvX1DWauQQggC3XvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Content-Type: multipart/mixed; boundary="===============1494983794=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1494983794==
Content-Type: multipart/alternative;
 boundary="------------50802266CA971874608549B2"
Content-Language: en-US

--------------50802266CA971874608549B2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.03.21 um 10:30 schrieb Li, Dennis:
>
> >>> The GPU reset doesn't complete the fences we wait for. It only 
> completes the hardware fences as part of the reset.
>
> >>> So waiting for a fence while holding the reset lock is illegal and 
> needs to be avoided.
>
> I understood your concern. It is more complex for DRM GFX, therefore I 
> abandon adding lock protection for DRM ioctls now. Maybe we can try to 
> add all kernel  dma_fence waiting in a list, and signal all in 
> recovery threads. Do you have same concern for compute cases?
>

Yes, compute (KFD) is even harder to handle.

See you can't signal the dma_fence waiting. Waiting for a dma_fence also 
means you wait for the GPU reset to finish.

When we would signal the dma_fence during the GPU reset then we would 
run into memory corruption because the hardware jobs running after the 
GPU reset would access memory which is already freed.

> >>> Lockdep also complains about this when it is used correctly. The 
> only reason it doesn't complain here is because you use an 
> atomic+wait_event instead of a locking primitive.
>
> Agree. This approach will escape the monitor of lockdep.  Its goal is 
> to block other threads when GPU recovery thread start. But I couldn’t 
> find a better method to solve this problem. Do you have some suggestion?
>

Well, completely abandon those change here.

What we need to do is to identify where hardware access happens and then 
insert taking the read side of the GPU reset lock so that we don't wait 
for a dma_fence or allocate memory, but still protect the hardware from 
concurrent access and reset.

Regards,
Christian.

> Best Regards
>
> Dennis Li
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, March 18, 2021 4:59 PM
> *To:* Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance its 
> stability
>
> Exactly that's what you don't seem to understand.
>
> The GPU reset doesn't complete the fences we wait for. It only 
> completes the hardware fences as part of the reset.
>
> So waiting for a fence while holding the reset lock is illegal and 
> needs to be avoided.
>
> Lockdep also complains about this when it is used correctly. The only 
> reason it doesn't complain here is because you use an 
> atomic+wait_event instead of a locking primitive.
>
> Regards,
>
> Christian.
>
> ------------------------------------------------------------------------
>
> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
> *Gesendet:* Donnerstag, 18. März 2021 09:28
> *An:* Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
> Kuehling, Felix <Felix.Kuehling@amd.com 
> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance its 
> stability
>
> >>> Those two steps need to be exchanged or otherwise it is possible 
> that new delayed work items etc are started before the lock is taken.
> What about adding check for adev->in_gpu_reset in work item? If 
> exchange the two steps, it maybe introduce the deadlock.  For example, 
> the user thread hold the read lock and waiting for the fence, if 
> recovery thread try to hold write lock and then complete fences, in 
> this case, recovery thread will always be blocked.
>
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
> Sent: Thursday, March 18, 2021 3:54 PM
> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Kuehling, Felix 
> <Felix.Kuehling@amd.com <mailto:Felix.Kuehling@amd.com>>; Zhang, 
> Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its 
> stability
>
> Am 18.03.21 um 08:23 schrieb Dennis Li:
> > We have defined two variables in_gpu_reset and reset_sem in adev 
> object. The atomic type variable in_gpu_reset is used to avoid 
> recovery thread reenter and make lower functions return more earlier 
> when recovery start, but couldn't block recovery thread when it access 
> hardware. The r/w semaphore reset_sem is used to solve these 
> synchronization issues between recovery thread and other threads.
> >
> > The original solution locked registers' access in lower functions, 
> which will introduce following issues:
> >
> > 1) many lower functions are used in both recovery thread and others. 
> Firstly we must harvest these functions, it is easy to miss someones. 
> Secondly these functions need select which lock (read lock or write 
> lock) will be used, according to the thread it is running in. If the 
> thread context isn't considered, the added lock will easily introduce 
> deadlock. Besides that, in most time, developer easily forget to add 
> locks for new functions.
> >
> > 2) performance drop. More lower functions are more frequently called.
> >
> > 3) easily introduce false positive lockdep complaint, because write 
> lock has big range in recovery thread, but low level functions will 
> hold read lock may be protected by other locks in other threads.
> >
> > Therefore the new solution will try to add lock protection for 
> ioctls of kfd. Its goal is that there are no threads except for 
> recovery thread or its children (for xgmi) to access hardware when 
> doing GPU reset and resume. So refine recovery thread as the following:
> >
> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
> >     1). if failed, it means system had a recovery thread running, 
> current thread exit directly;
> >     2). if success, enter recovery thread;
> >
> > Step 1: cancel all delay works, stop drm schedule, complete all 
> unreceived fences and so on. It try to stop or pause other threads.
> >
> > Step 2: call down_write(&adev->reset_sem) to hold write lock, which 
> will block recovery thread until other threads release read locks.
>
> Those two steps need to be exchanged or otherwise it is possible that 
> new delayed work items etc are started before the lock is taken.
>
> Just to make it clear until this is fixed the whole patch set is a NAK.
>
> Regards,
> Christian.
>
> >
> > Step 3: normally, there is only recovery threads running to access 
> hardware, it is safe to do gpu reset now.
> >
> > Step 4: do post gpu reset, such as call all ips' resume functions;
> >
> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads 
> and release write lock. Recovery thread exit normally.
> >
> > Other threads call the amdgpu_read_lock to synchronize with recovery 
> thread. If it finds that in_gpu_reset is 1, it should release read 
> lock if it has holden one, and then blocks itself to wait for recovery 
> finished event. If thread successfully hold read lock and in_gpu_reset 
> is 0, it continues. It will exit normally or be stopped by recovery 
> thread in step 1.
> >
> > Dennis Li (4):
> >    drm/amdgpu: remove reset lock from low level functions
> >    drm/amdgpu: refine the GPU recovery sequence
> >    drm/amdgpu: instead of using down/up_read directly
> >    drm/amdkfd: add reset lock protection for kfd entry functions
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  14 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 +++++++++++++-----
> >   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 -
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   9 +-
> >   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   5 +-
> >   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   5 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 ++++++++++++++++-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   4 +
> >   .../amd/amdkfd/kfd_process_queue_manager.c    |  17 ++
> >   12 files changed, 345 insertions(+), 75 deletions(-)
> >
>


--------------50802266CA971874608549B2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 18.03.21 um 10:30 schrieb Li, Dennis:<br>
    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">&gt;&gt;&gt; The GPU reset doesn't complete
          the fences we wait for. It only completes the hardware fences
          as part of the reset.<o:p></o:p></p>
        <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence while
          holding the reset lock is illegal and needs to be avoided.<o:p></o:p></p>
        <p class="MsoNormal">I understood your concern. It is more
          complex for DRM GFX, therefore I abandon adding lock
          protection for DRM ioctls now. Maybe we can try to add all
          kernel &nbsp;dma_fence waiting in a list, and signal all in
          recovery threads. Do you have same concern for compute cases?
        </p>
      </div>
    </blockquote>
    <br>
    Yes, compute (KFD) is even harder to handle.<br>
    <br>
    See you can't signal the dma_fence waiting. Waiting for a dma_fence
    also means you wait for the GPU reset to finish.<br>
    <br>
    When we would signal the dma_fence during the GPU reset then we
    would run into memory corruption because the hardware jobs running
    after the GPU reset would access memory which is already freed.<br>
    <br>
    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains about
          this when it is used correctly. The only reason it doesn't
          complain here is because you use an atomic+wait_event instead
          of a locking primitive.<o:p></o:p></p>
        <p class="MsoNormal">Agree. This approach will escape the
          monitor of lockdep.&nbsp; Its goal is to block other threads when
          GPU recovery thread start. But I couldn’t find a better method
          to solve this problem. Do you have some suggestion?
        </p>
      </div>
    </blockquote>
    <br>
    Well, completely abandon those change here.<br>
    <br>
    What we need to do is to identify where hardware access happens and
    then insert taking the read side of the GPU reset lock so that we
    don't wait for a dma_fence or allocate memory, but still protect the
    hardware from concurrent access and reset.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Best Regards<o:p></o:p></p>
        <p class="MsoNormal">Dennis Li<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Thursday, March 18, 2021 4:59 PM<br>
              <b>To:</b> Li, Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com">&lt;Dennis.Li@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
              <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Zhang, Hawking
              <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
              <b>Subject:</b> AW: [PATCH 0/4] Refine GPU recovery
              sequence to enhance its stability<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">Exactly that's what you
              don't seem to understand.<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">The GPU reset doesn't
              complete the fences we wait for. It only completes the
              hardware fences as part of the reset.<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">So waiting for a fence
              while holding the reset lock is illegal and needs to be
              avoided.<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">Lockdep also complains
              about this when it is used correctly. The only reason it
              doesn't complain here is because you use an
              atomic+wait_event instead of a locking primitive.<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
              UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
        </div>
        <div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
        <div class="MsoNormal" style="text-align:center" align="center">
          <hr width="98%" size="2" align="center">
        </div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
              <b>Gesendet:</b> Donnerstag, 18. März 2021 09:28<br>
              <b>An:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
              &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
              Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
              Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
              Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
              <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU recovery
              sequence to enhance its stability</span>
            <o:p></o:p></p>
          <div>
            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
          </div>
        </div>
        <div>
          <div>
            <p class="MsoNormal">&gt;&gt;&gt; Those two steps need to be
              exchanged or otherwise it is possible that new delayed
              work items etc are started before the lock is taken.<br>
              What about adding check for adev-&gt;in_gpu_reset in work
              item? If exchange the two steps, it maybe introduce the
              deadlock.&nbsp; For example, the user thread hold the read lock
              and waiting for the fence, if recovery thread try to hold
              write lock and then complete fences, in this case,
              recovery thread will always be blocked.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
              Best Regards<br>
              Dennis Li<br>
              -----Original Message-----<br>
              From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
              <br>
              Sent: Thursday, March 18, 2021 3:54 PM<br>
              To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
              Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
              Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
              Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to
              enhance its stability<br>
              <br>
              Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
              &gt; We have defined two variables in_gpu_reset and
              reset_sem in adev object. The atomic type variable
              in_gpu_reset is used to avoid recovery thread reenter and
              make lower functions return more earlier when recovery
              start, but couldn't block recovery thread when it access
              hardware. The r/w semaphore reset_sem is used to solve
              these synchronization issues between recovery thread and
              other threads.<br>
              &gt;<br>
              &gt; The original solution locked registers' access in
              lower functions, which will introduce following issues:<br>
              &gt;<br>
              &gt; 1) many lower functions are used in both recovery
              thread and others. Firstly we must harvest these
              functions, it is easy to miss someones. Secondly these
              functions need select which lock (read lock or write lock)
              will be used, according to the thread it is running in. If
              the thread context isn't considered, the added lock will
              easily introduce deadlock. Besides that, in most time,
              developer easily forget to add locks for new functions.<br>
              &gt;<br>
              &gt; 2) performance drop. More lower functions are more
              frequently called.<br>
              &gt;<br>
              &gt; 3) easily introduce false positive lockdep complaint,
              because write lock has big range in recovery thread, but
              low level functions will hold read lock may be protected
              by other locks in other threads.<br>
              &gt;<br>
              &gt; Therefore the new solution will try to add lock
              protection for ioctls of kfd. Its goal is that there are
              no threads except for recovery thread or its children (for
              xgmi) to access hardware when doing GPU reset and resume.
              So refine recovery thread as the following:<br>
              &gt;<br>
              &gt; Step 0: atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0,
              1)<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a recovery
              thread running, current thread exit directly;<br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
              &gt;<br>
              &gt; Step 1: cancel all delay works, stop drm schedule,
              complete all unreceived fences and so on. It try to stop
              or pause other threads.<br>
              &gt;<br>
              &gt; Step 2: call down_write(&amp;adev-&gt;reset_sem) to
              hold write lock, which will block recovery thread until
              other threads release read locks.<br>
              <br>
              Those two steps need to be exchanged or otherwise it is
              possible that new delayed work items etc are started
              before the lock is taken.<br>
              <br>
              Just to make it clear until this is fixed the whole patch
              set is a NAK.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              &gt;<br>
              &gt; Step 3: normally, there is only recovery threads
              running to access hardware, it is safe to do gpu reset
              now.<br>
              &gt;<br>
              &gt; Step 4: do post gpu reset, such as call all ips'
              resume functions;<br>
              &gt;<br>
              &gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0, wake
              up other threads and release write lock. Recovery thread
              exit normally.<br>
              &gt;<br>
              &gt; Other threads call the amdgpu_read_lock to
              synchronize with recovery thread. If it finds that
              in_gpu_reset is 1, it should release read lock if it has
              holden one, and then blocks itself to wait for recovery
              finished event. If thread successfully hold read lock and
              in_gpu_reset is 0, it continues. It will exit normally or
              be stopped by recovery thread in step 1.<br>
              &gt;<br>
              &gt; Dennis Li (4):<br>
              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from low level
              functions<br>
              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU recovery sequence<br>
              &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using down/up_read directly<br>
              &gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock protection for kfd
              entry functions<br>
              &gt;<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6
              +<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp; 14
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 173
              +++++++++++++-----<br>
              &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8
              -<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 172
              ++++++++++++++++-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3
              +-<br>
              &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4
              +<br>
              &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; |&nbsp; 17
              ++<br>
              &gt;&nbsp;&nbsp; 12 files changed, 345 insertions(+), 75
              deletions(-)<br>
              &gt;<o:p></o:p></p>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------50802266CA971874608549B2--

--===============1494983794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1494983794==--
