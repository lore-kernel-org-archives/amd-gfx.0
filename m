Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87254C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 18:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333086115B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 18:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333086115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46336EC43;
	Fri,  9 Apr 2021 18:18:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95CD6EC43
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 18:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFx6L+V7CdH2LzQkxn5PJD4EIgg8+7EEQu5FZLUqOR8mWD3lEXkoAYi81fRMqj3kRC9Kox+lHPq4gYFmXduS2AbZEg+KYmS2A4cnOCxuSDsW9JkowZx4vMQ1W99WHeRUAh8cXTEY2WIIPV+0XgbzxQ+rWdIHLNYLkDeTDjnL4iiPuRLRZHmTNYjVAPc5kMj/KZ9xeVxuRsP7vSmQNNKlmF+SA6vYvcAkLSA3QzUH2MaUXkorsU/9qLE1o335IeFxZ7eIq8jU2twgUToTH86wyE8xBrsyqMtm3UZXsEriQPZ9MO8OY7j0gdd3RU+izojuuHJdtcW3h8cUg7umH9rjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ39I1p9FkR8XtgqQPHPl1Y9G2oXhL/JJ6ybyCZFpuA=;
 b=PW/C1oHXh6XLz/9UdtI+2A1QIOP45C7RPBJtxKpvn6QcwOOmolMhdgdfRfFb3AWUpOImBoqhECffmuJkm67NAXn3Jqco7hfjCJqv/oydopTTygWnCZWCs6lcFJ8p+W7VrWGZVXV7jeQo067EoUmtK+zyqkbP8K36+9DKNhh/FRYLIKcglwF6YEOXO8wkLvbVtsqMU5MQN/HVMsqBKVEqGBBpC+l+YFaurZvlmTMihaN+K/jw+rLjH6zpXN/W3WUFyV/Y1EKtAD2n0VKVqQADjmZUi6aUn71HxStFheAX6RNPqwFBHe8ki2c8D5QDyb9P+p8L2VsqQ0cstIRjZLFJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ39I1p9FkR8XtgqQPHPl1Y9G2oXhL/JJ6ybyCZFpuA=;
 b=dsshDdIorlQwHtf2eLNkuYCKnY83JnMIBEGG7CUyXCdKuy4R7Th6uAalf7bqp4yQh09r7XTtmaYgXXOBBuuDvDQELxwfrjTVEkBNz1UoXT7rA4wLJpBTxl1WiWrN7MaMehw055wMQyLH16u1o7IPq7FQ1W7K9I2JGR6O42R2sNw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 18:18:43 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 18:18:43 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
Date: Fri, 9 Apr 2021 14:18:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:f08e:c688:bec5:ed9a]
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:f08e:c688:bec5:ed9a]
 (2607:fea8:3edf:49b0:f08e:c688:bec5:ed9a) by
 YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Fri, 9 Apr 2021 18:18:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7819508-8c7f-4888-9bc4-08d8fb83e83f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23973E9F76A697FA36145B9AEA739@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Laj1aZbDeYFVwPr2GRBR5Y9SY9PoIxIdcIZbQNdJCPVPSW6DcdHW051auN0q2193SwBVGGj5glocG4EYMxj+m9kFCG1f5bUUn2ctQ8KipqHwFPcVhLArZW5mC1yYIXs1hPaygZ0JP7wK5M2P7Kt8Wxr9sZdBERJ2/Pc2KO7wceCzWj/YXprwlC58LXdw7dw68NJDW0GYeegZsFgKBmUxUx1UL7lqPO7ujjd8W/FAU3A7oXACG7u4MAzocuCiGx0IidXuUgwKkjFQt5IZiyLz2epO3dsNVGI4QIND5icQDvfgaW9+gLIhHa+nfAVZV8KaNWSRtoHXME+suGRrBtg6/LKo7+7kRRg7g1FNnrxc5/2/tv/YyOLBC8ESXlnyeX9hcUssXyC4dPw+c/yL2u2rLBJ5SOcvoR6fay2hhMgpNoPWMc++wanR0rWsvZEFP8cgvCfG8EfN//vmEjmF4JDHXxBs8Cco+CqO89VxVXXvtExg3Oqaa5to4o15osdp4hqGQRQlYhCrR1Nr1eRUa0HzSQOjm3J7GG9HB3WMAwqHsCYqrLNeGzaeu9TntovWJCLgOjqFRKUfQc69xdV/qQAjDGiyBliDgrBlQ/zUBYgG/DyzmUWNisD5J4V3aeKBWByE9xddcrxyEAOJA0YgnMguDnM32tk6wj3ryztIDqYTlSOHJF26hviD5Ulko9xblRTY7yW8Sq2ZBxNld///F/zr+fPfcxYgVJ/v9UUgK1L/IZ9vSCMr9Y2G1MEx0M1zIh/afrxF/4/XXNuVhOLuDJ179A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(31696002)(8676002)(921005)(66476007)(66556008)(66946007)(86362001)(44832011)(186003)(2616005)(16526019)(6486002)(6636002)(31686004)(478600001)(110136005)(316002)(66574015)(83380400001)(36756003)(966005)(38100700001)(5660300002)(52116002)(2906002)(53546011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bzhSS3FYWjZXQ3BsSXVYYUk3VzJtZ3R3VUZpdVhxY2RaTHJBZkRRVGlSVnFp?=
 =?utf-8?B?V2ErTTYydloyd05QeldmRzBXQjEzT0d5VVdPVUkrakhETUYwMUVjZzdtTWI2?=
 =?utf-8?B?amp2NlFHaXpYSG9pSy8rMktUWEEyc2dDQktGRW04M2lPcHFVR3pNa0o0N09j?=
 =?utf-8?B?NDYyMk1PZTAxdVJhZnJQdVFGVDVLczl4eVdwTkhCSXR2R1UxV0cvU2MrWmNr?=
 =?utf-8?B?VTcrb2ZQWWtNa0NPcEtmQkV3RlduTHVOVmtQK3pnYnY5bFNpajhyR2txMzho?=
 =?utf-8?B?SWtYTWlWZ2pndFBJbTlDUmhqTmJacEc0QWd0ZVlDNlV6N2huS0NSNXF1cGRN?=
 =?utf-8?B?WHVUSmUwbjlvaXptR1VDODlOdVdQMm5mZ3EvejNwV1phTTFXTlZxMkZ4Z0NP?=
 =?utf-8?B?elVkenJ4RGticWRLVVB1aU9jRzFmYXVya0pzUWNNQ1pETnNDYkFnS3NSZWpP?=
 =?utf-8?B?SEwzcVlZbElMa24vSHMrMVozMXRpeUkzNXZLUVBNb1RkckxwQVZVaUdZV0pa?=
 =?utf-8?B?eWFKcjdQU09TeG5sbUk1Z29Sc0xvaXBaTUsyMlpxbk9QSG5PQXJUSUNqWUEz?=
 =?utf-8?B?MHY2ZlY1bjhYb0xUUE5OLytzc0xnNFlFc0ZpY3ZqNm93b3RlVWp0OU8vVjVi?=
 =?utf-8?B?RDVrMEF5YnNrTkxBTkxrSTEzOTZWT3ZTdjZKWWJ3VGZHSDFlcFZUeGF1Tmg5?=
 =?utf-8?B?NUlVc0c5UkFtS3BHT1JoR3lRRWZoKzVSYmIybXEvcjVpRjd4ZXFyTjFEcEtG?=
 =?utf-8?B?eEYzL003QVlTVjU1KzFHbERzSGNtak9CcTB6cUk1aUxCbHlDVCtqRjlmN3NC?=
 =?utf-8?B?ay8zNTRjL2tqR1ZkVC8yM2svSmwrdlhFVFF4bnU0bWxKTGN6dDJwOUFwd2pm?=
 =?utf-8?B?elMzU3ZhWVJXeko4L1NQOWdscCtUS1BuNmx2bk1qYzI4V2l5Q3V6S0ZZWHMz?=
 =?utf-8?B?RFl2a2hKaFZRaWh1R3diUnVMbEd1b2lBQk1pN3BESFdhRTU0V3RDdEdtMW1j?=
 =?utf-8?B?VHJDMG12Zi9NNS8zblNPdWFzU3o4SERvekI4YlJYeitWZ1JVUStUem9WN1I5?=
 =?utf-8?B?UXhHSXN0TVZmRENpU1I0bDViTXBpNE9peGpRcXQ0MlNTUVNlNmFwSWdQT3NY?=
 =?utf-8?B?MDRqcVNERGd4dTFIS1BFL3p6eXZlY1RkWnNvOUY1M3YzZ2FiU1Y5eWpHeTNz?=
 =?utf-8?B?WDlzMFNEaS9EQ2pzQnE4a0svNDNkbGFYSVN0bU82a2xyRTU2MlJ1dkRiTHVJ?=
 =?utf-8?B?cVpwZFljMkc2OWh4OGlLa1MwUXFzS0dqQ2xJa1dCc0o0MDNnend2MGRQSWkr?=
 =?utf-8?B?T2I2cm1yRENLcDIyclVoU3phamNGbFhwa2pVWEx2ajR5aGdyQyszMncxZDQ0?=
 =?utf-8?B?ZEo4MmpaaVdPQTQzR3haWkZpc2JmcUFmaUVoY2tpS1MxM212K0g1cUxoLzhp?=
 =?utf-8?B?NE9lTHJVbkpzRWZUdldiSldZMFU0M05vaGxOVXJlVmRkOUYzV1ZRUVpnRmZp?=
 =?utf-8?B?Z083L1FrZm9pV0pYOUx6a1gzN2pQbzl0KzQvOE54Y2k3VkwxVTFLb1JBUFI5?=
 =?utf-8?B?OERIV2JzS0JENlFLZDZRQzdaa2k3TmtoREZuZGJ2eWRHYjRmVG9kOVBNY21P?=
 =?utf-8?B?dTJnRzN3TkptN1dvYTZWQzllYytXWUw2YW1FWEp5WTZWaE4zUDMvR3UyTCtw?=
 =?utf-8?B?M0ZwVndzZ0pjZWRhTGJjckJ3cHpRSHlFWGF4cXNCNDI0MG9OeTRnUW84V0pH?=
 =?utf-8?B?QVMzTDdaeXE0OGhoeGZlWXoyOTM4WHIxYkF1c3hCUU9Pang2cm4yZ2gxUFEy?=
 =?utf-8?B?ZWFIbUxwd3doNnpTbVIyUklwc3QrdkdEUkF5eHJqVU1vZGJpMkVIaTdUZElm?=
 =?utf-8?Q?K+LrYI5B1tvc8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7819508-8c7f-4888-9bc4-08d8fb83e83f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 18:18:43.2383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSF+rMh/qSUdW2RVxBNQn1RwA/NehPfD9bY9zpWk7sbh2TCwymhQTUox9GTSnD9XMJmtrP+Zbjj+ZOVi+oRE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDQtMDkgMTI6MzkgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAw
OS4wNC4yMSB1bSAxNzo0MiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pgo+PiBPbiAyMDIx
LTA0LTA5IDM6MDEgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDA5LjA0LjIx
IHVtIDA4OjUzIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+PiBBbSAwOC4wNC4yMSB1bSAy
MjozOSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+PiBbU05JUF0KPj4+Pj4gQnV0IGlu
c2VydGluZyBkbXJfZGV2X2VudGVyL2V4aXQgb24gdGhlIGhpZ2hlc3QgbGV2ZWwgaW4gZHJtX2lv
Y3RsIAo+Pj4+PiBpcyBtdWNoIGxlc3MgZWZmb3J0IGFuZCBsZXNzIHJvb20gZm9yIGVycm9yIHRo
ZW4gZ29pbmcgdGhyb3VnaCAKPj4+Pj4gZWFjaCBJT0NUTCBhbmQgdHJ5aW5nIHRvIGlkZW50aWZ5
IGF0IHdoYXQgcG9pbnQgKHBvc3NpYmx5IG11bHRpcGxlIAo+Pj4+PiBwb2ludHMpIHRoZXkgYXJl
IGFib3V0IHRvIGFjY2VzcyBIVywgc29tZSBvZiB0aGlzIGlzIGhpZGRlbiBkZWVwIAo+Pj4+PiBp
biBIQUwgbGF5ZXJzIHN1Y2ggYXMgREMgbGF5ZXIgaW4gZGlzcGxheSBkcml2ZXIgb3IgdGhlIG11
bHRpIAo+Pj4+PiBsYXllcnMgb2YgcG93ZXJwbGF5L1NNVSBsaWJyYXJpZXMuIEFsc28sIHdlIGNh
bid0IG9ubHkgbGltaXQgCj4+Pj4+IG91ci1zZWxmIHRvIGJhY2stZW5kIGlmIGJ5IHRoaXMgeW91
IG1lYW4gQVNJQyBzcGVjaWZpYyBmdW5jdGlvbnMgCj4+Pj4+IHdoaWNoIGFjY2VzcyByZWdpc3Rl
cnMuIFdlIGFsc28gbmVlZCB0byB0YWtlIGNhcmUgb2YgYW55IE1NSU8gCj4+Pj4+IGtlcm5lbCBC
TyAoVlJBTSBCT3MpIHdoZXJlIHdlIG1heSBhY2Nlc3MgZGlyZWN0bHkgTU1JTyBzcGFjZSBieSAK
Pj4+Pj4gcG9pbnRlciBmcm9tIHRoZSBmcm9udCBlbmQgb2YgdGhlIGRyaXZlciAoSFcgYWdub3N0
aWMpIGFuZCBUVE0vRFJNIAo+Pj4+PiBsYXllcnMuCj4+Pj4KPj4+PiBFeGFjdGx5LCB5ZXMuIFRo
ZSBrZXkgcG9pbnQgaXMgd2UgbmVlZCB0byBpZGVudGlmeSBzdWNoIHBsYWNlcyAKPj4+PiBhbnl3
YXkgZm9yIEdQVSByZXNldCB0byB3b3JrIHByb3Blcmx5LiBTbyB3ZSBjb3VsZCBqdXN0IHBpZ2d5
IGJhY2sgCj4+Pj4gaG90cGx1ZyBvbiB0b3Agb2YgdGhhdCB3b3JrIGFuZCBhcmUgZG9uZS4KPj4K
Pj4KPj4gSSBzZWUgbW9zdCBvZiB0aGlzIHdhcyBkb25lIEJ5IERlbmlzIGluIHRoaXMgcGF0Y2gg
Cj4+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFncm9kem92L2xpbnV4L2NvbW1pdC8/
aD1kcm0tbWlzYy1uZXh0JmlkPWRmOWM4ZDFhYTI3OGM0MzVjMzBhNjliOGYyNDE4YjRhNTJmY2I5
MjksIAo+PiBpbmRlZWQgdGhpcyBkb2Vzbid0IGNvdmVyIHRoZSBkaXJlY3QgYnkgcG9pbnRlciBh
Y2Nlc3NlcyBvZiBNTUlPIGFuZCAKPj4gd2lsbCBpbnRyb2R1Y2UgbXVjaCBtb3JlIG9mIHRob3Nl
IGFuZCwgYXMgcGVvcGxlIHdyaXRlIG5ldyBjb2RlLCBuZXcgCj4+IHBsYWNlcyB0byBjb3ZlciB3
aWxsIHBvcCB1cCBsZWFkaW5nIHRvIHJlZ3Jlc3Npb25zIGFuZCBleHRyYSB3b3JrIHRvIAo+PiBm
aXguIEl0IHdvdWxkIGJlIHJlYWxseSBtdWNoIGJldHRlciBpZiB3ZSBjb3VsZCBibGFua2V0IGNv
dmVyIGl0IGF0IAo+PiB0aGUgdmVyeSB0b3DCoCBzdWNoIGFzIHJvb3Qgb2YgYWxsIElPQ1RMcyBv
ciwgZm9yIGFueSBxdWV1ZWQgCj4+IHdvcmsvdGltZXIgYXQgdGhlIHZlcnkgdG9wIGZ1bmN0aW9u
LCB0byBoYW5kbGUgaXQgb25jZSBhbmQgZm9yIGFsbC4KPgo+IEFuZCBleGFjdGx5IHRoYXQncyB3
aGF0IGlzIG5vdCBwb3NzaWJsZS4gQXQgbGVhc3QgZm9yIHRoZSByZXNldCBjYXNlIAo+IHlvdSBu
ZWVkIHRvIGxvb2sgaW50byBlYWNoIGhhcmR3YXJlIGFjY2VzcyBhbmQgaGFuZGxlIHRoYXQgYml0
IGJ5IGJpdCAKPiBhbmQgSSB0aGluayB0aGF0IGZvciB0aGUgaG90cGx1ZyBjYXNlIHdlIHNob3Vs
ZCBnbyBkb3duIHRoYXQgcm91dGUgYXMgCj4gd2VsbC4KPgo+Pj4+Cj4+Pj4+Cj4+Pj4+IE91ciBw
cm9ibGVtIGhlcmUgaXMgaG93IHRvIHNpZ25hbCBhbGwgdGhlIGV4aXN0aW5nwqAgZmVuY2VzIG9u
IG9uZSAKPj4+Pj4gaGFuZCBhbmQgb24gdGhlIG90aGVyIHByZXZlbnQgYW55IG5ldyBkbWFfZmVu
Y2Ugd2FpdHMgYWZ0ZXIgd2UgCj4+Pj4+IGZpbmlzaGVkIHNpZ25hbGluZyBleGlzdGluZyBmZW5j
ZXMuIE9uY2Ugd2Ugc29sdmVkIHRoaXMgdGhlbiB0aGVyZSAKPj4+Pj4gaXMgbm8gcHJvYmxlbSB1
c2luZyBkcm1fZGV2X3VucGx1ZyBpbiBjb25qdW5jdGlvbiB3aXRoIAo+Pj4+PiBkcm1fZGV2X2Vu
dGVyL2V4aXQgYXQgdGhlIGhpZ2hlc3QgbGV2ZWwgb2YgZHJtX2lvY3RsIHRvIGZsdXNoIGFueSAK
Pj4+Pj4gSU9DVExzIGluIGZsaWdodCBhbmQgYmxvY2sgYW55IG5ldyBvbmVzLgo+Pj4+Pgo+Pj4+
PiBJTUhPIHdoZW4gd2Ugc3BlYWsgYWJvdXQgc2lnbmFsbGluZyBhbGwgZmVuY2VzIHdlIGRvbid0
IG1lYW4gQUxMIAo+Pj4+PiB0aGUgY3VycmVudGx5IGV4aXN0aW5nIGRtYV9mZW5jZSBzdHJ1Y3Rz
ICh0aGV5IGFyZSBzcHJlYWQgYWxsIG92ZXIgCj4+Pj4+IHRoZSBwbGFjZSkgYnV0IHJhdGhlciBz
aWduYWwgYWxsIHRoZSBIVyBmZW5jZXMgYmVjYXVzZSBIVyBpcyAKPj4+Pj4gd2hhdCdzIGdvbmUg
YW5kIHdlIGNhbid0IGV4cGVjdCBmb3IgdGhvc2UgZmVuY2VzIHRvIGJlIGV2ZXIgCj4+Pj4+IHNp
Z25hbGVkLiBBbGwgdGhlIHJlc3Qgc3VjaCBhczogc2NoZWR1bGVyIGZlbmNlcywgdXNlciBmZW5j
ZXMsIAo+Pj4+PiBkcm1fZ2VtIHJlc2VydmF0aW9uIG9iamVjdHMgZS50LmMuIGFyZSBlaXRoZXIg
ZGVwZW5kZW50IG9uIHRob3NlIAo+Pj4+PiBIVyBmZW5jZXMgYW5kIGhlbmNlIHNpZ25hbGluZyB0
aGUgSFcgZmVuY2VzIHdpbGwgaW4gdHVybiBzaWduYWwgCj4+Pj4+IHRoZW0gb3IsIGFyZSBub3Qg
aW1wYWN0ZWQgYnkgdGhlIEhXIGJlaW5nIGdvbmUgYW5kIGhlbmNlIGNhbiBzdGlsbCAKPj4+Pj4g
YmUgd2FpdGVkIG9uIGFuZCB3aWxsIGNvbXBsZXRlLiBJZiB0aGlzIGFzc3VtcHRpb24gaXMgY29y
cmVjdCB0aGVuIAo+Pj4+PiBJIHRoaW5rIHRoYXQgd2Ugc2hvdWxkIHVzZSBzb21lIGZsYWcgdG8g
cHJldmVudCBhbnkgbmV3IHN1Ym1pc3Npb24gCj4+Pj4+IHRvIEhXIHdoaWNoIGNyZWF0ZXMgSFcg
ZmVuY2VzIChzb21ld2hlcmUgYXJvdW5kIAo+Pj4+PiBhbWRncHVfZmVuY2VfZW1pdCksIHRoZW4g
dHJhdmVyc2UgYWxsIGV4aXN0aW5nIEhXIGZlbmNlcyAKPj4+Pj4gKGN1cnJlbnRseSB0aGV5IGFy
ZSBzcHJlYWQgaW4gYSBmZXcgcGxhY2VzIHNvIG1heWJlIHdlIG5lZWQgdG8gCj4+Pj4+IHRyYWNr
IHRoZW0gaW4gYSBsaXN0KSBhbmQgc2lnbmFsIHRoZW0uIEFmdGVyIHRoYXQgaXQncyBzYWZlIHRv
IGNhbCAKPj4+Pj4gZHJtX2Rldl91bnBsdWcgYW5kIGJlIHN1cmUgc3luY2hyb25pemVfc3JjdSB3
b24ndCBzdGFsbCBiZWNhdXNlIG9mIAo+Pj4+PiBvZiBkbWFfZmVuY2Vfd2FpdC4gQWZ0ZXIgdGhh
dCB3ZSBjYW4gcHJvY2VlZCB0byBjYW5jZWxpbmcgd29yayAKPj4+Pj4gaXRlbXMsIHN0b3BwaW5n
IHNjaGVkdWxlcnMgZS50LmMuCj4+Pj4KPj4+PiBUaGF0IGlzIHByb2JsZW1hdGljIGFzIHdlbGwg
c2luY2UgeW91IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIAo+Pj4+IHNjaGVkdWxlciBpcyBu
b3QgY3JlYXRpbmcgYSBuZXcgaGFyZHdhcmUgZmVuY2UgaW4gdGhlIG1vbWVudCB5b3UgCj4+Pj4g
dHJ5IHRvIHNpZ25hbCBhbGwgb2YgdGhlbS4gSXQgd291bGQgcmVxdWlyZSBhbm90aGVyIFNSQ1Ug
b3IgbG9jayAKPj4+PiBmb3IgdGhpcy4KPj4KPj4KPj4gSWYgd2UgdXNlIGEgbGlzdCBhbmQgYSBm
bGFnIGNhbGxlZCAnZW1pdF9hbGxvd2VkJyB1bmRlciBhIGxvY2sgc3VjaCAKPj4gdGhhdCBpbiBh
bWRncHVfZmVuY2VfZW1pdCB3ZSBsb2NrIHRoZSBsaXN0LCBjaGVjayB0aGUgZmxhZyBhbmQgaWYg
Cj4+IHRydWUgYWRkIHRoZSBuZXcgSFcgZmVuY2UgdG8gbGlzdCBhbmQgcHJvY2VlZCB0byBIVyBl
bWl0aW9uIGFzIAo+PiBub3JtYWwsIG90aGVyd2lzZSByZXR1cm4gd2l0aCAtRU5PREVWLiBJbiBh
bWRncHVfcGNpX3JlbW92ZSB3ZSB0YWtlIAo+PiB0aGUgbG9jaywgc2V0IHRoZSBmbGFnIHRvIGZh
bHNlLCBhbmQgdGhlbiBpdGVyYXRlIHRoZSBsaXN0IGFuZCBmb3JjZSAKPj4gc2lnbmFsIGl0LiBX
aWxsIHRoaXMgbm90IHByZXZlbnQgYW55IG5ldyBIVyBmZW5jZSBjcmVhdGlvbiBmcm9tIG5vdyAK
Pj4gb24gZnJvbSBhbnkgcGxhY2UgdHJ5aW5nIHRvIGRvIHNvID8KPgo+IFdheSB0byBtdWNoIG92
ZXJoZWFkLiBUaGUgZmVuY2UgcHJvY2Vzc2luZyBpcyBpbnRlbnRpb25hbGx5IGxvY2sgZnJlZSAK
PiB0byBhdm9pZCBjYWNoZSBsaW5lIGJvdW5jaW5nIGJlY2F1c2UgdGhlIElSUSBjYW4gbW92ZSBm
cm9tIENQVSB0byBDUFUuCj4KPiBXZSBuZWVkIHNvbWV0aGluZyB3aGljaCBhdCBsZWFzdCB0aGUg
cHJvY2Vzc2luZyBvZiBmZW5jZXMgaW4gdGhlIAo+IGludGVycnVwdCBoYW5kbGVyIGRvZXNuJ3Qg
YWZmZWN0IGF0IGFsbC4KCgpBcyBmYXIgYXMgSSBzZWUgaW4gdGhlIGNvZGUsIGFtZGdwdV9mZW5j
ZV9lbWl0IGlzIG9ubHkgY2FsbGVkIGZyb20gdGFzayAKY29udGV4dC4gQWxzbywgd2UgY2FuIHNr
aXAgdGhpcyBsaXN0IEkgcHJvcG9zZWQgYW5kIGp1c3QgdXNlIAphbWRncHVfZmVuY2VfZHJpdmVy
X2ZvcmNlX2NvbXBsZXRpb24gZm9yIGVhY2ggcmluZyB0byBzaWduYWwgYWxsIGNyZWF0ZWQgCkhX
IGZlbmNlcy4KCgo+Cj4+Pgo+Pj4gQWx0ZXJuYXRpdmVseSBncmFiYmluZyB0aGUgcmVzZXQgd3Jp
dGUgc2lkZSBhbmQgc3RvcHBpbmcgYW5kIHRoZW4gCj4+PiByZXN0YXJ0aW5nIHRoZSBzY2hlZHVs
ZXIgY291bGQgd29yayBhcyB3ZWxsLgo+Pj4KPj4+IENocmlzdGlhbi4KPj4KPj4KPj4gSSBkaWRu
J3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBkb24ndCBzZWUgd2h5IEkgbmVlZCB0byByZXVzZSB0aGUg
R1BVIAo+PiByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5wbHVnIGZsYWcgZm9y
IHVucGx1Zy4gQWxzbywgbm90IAo+PiBjbGVhciB0byBtZSB3aHkgYXJlIHdlIGZvY3VzaW5nIG9u
IHRoZSBzY2hlZHVsZXIgdGhyZWFkcywgYW55IGNvZGUgCj4+IHBhdGNoIHRvIGdlbmVyYXRlIEhX
IGZlbmNlcyBzaG91bGQgYmUgY292ZXJlZCwgc28gYW55IGNvZGUgbGVhZGluZyB0byAKPj4gYW1k
Z3B1X2ZlbmNlX2VtaXQgbmVlZHMgdG8gYmUgdGFrZW4gaW50byBhY2NvdW50IHN1Y2ggYXMsIGRp
cmVjdCBJQiAKPj4gc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50LmMKPgo+IFlvdSBuZWVkIHRv
IHdvcmsgdG9nZXRoZXIgd2l0aCB0aGUgcmVzZXQgbG9jayBhbnl3YXksIGNhdXNlIGEgaG90cGx1
ZyAKPiBjb3VsZCBydW4gYXQgdGhlIHNhbWUgdGltZSBhcyBhIHJlc2V0LgoKCkZvciBnb2luZyBt
eSB3YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZSByZXNldCB3cml0
ZSAKc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFsbGluZyBpbiBvcmRlciB0byBwcm90
ZWN0IGFnYWluc3QgCnNjaGVkdWxlci9IVyBmZW5jZXMgZGV0YWNobWVudCBhbmQgcmVhdHRhY2ht
ZW50IGR1cmluZyBzY2hlZHVsZXJzIApzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBnbyB3aXRoIHlv
dXIgYXBwcm9hY2jCoCB0aGVuIGNhbGxpbmcgCmRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nIGFt
ZGdwdV9qb2JfdGltZW91dCB3aXRoIGRybV9kZXZfZW50ZXIvZXhpdCAKc2hvdWxkIGJlIGVub3Vn
aCB0byBwcmV2ZW50IGFueSBjb25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4gSW4g
CmZhY3QgSSBhbHJlYWR5IGRvIGl0IGFueXdheSAtIApodHRwczovL2NnaXQuZnJlZWRlc2t0b3Au
b3JnL35hZ3JvZHpvdi9saW51eC9jb21taXQvP2g9ZHJtLW1pc2MtbmV4dCZpZD1lZjBlYTRkZDI5
ZWY0NGQyNjQ5YzVlZGExNmM4ZjQ4NjlhY2MzNmIxCgpBbmRyZXkKCgo+Cj4KPiBDaHJpc3RpYW4u
Cj4KPj4KPj4gQW5kcmV5Cj4+Cj4+Cj4+Pgo+Pj4+Cj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+
Cj4+Pj4+IEFuZHJleQo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pgo+
Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Cj4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
