Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCCC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011976109E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 18:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011976109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC5B89D3E;
	Mon, 12 Apr 2021 18:23:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D18389D3E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 18:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGBwtp7qLQ0eBxipo5w0+ZLfivB4a+SUm7pGj5v+ko+9F/UmGEGVvYGqivagWX+im9MoUU6aCcBI1bfFYJqoMxM1L5xUV6dA18fRqZ5j7sd4OUkkcsYGJxtAVJX+38Yi7gdTQiVSoEW7T4hVNxhqAHK/4X7qggbEBi9zGVyLgT/5r6P+4YfVQEIkshSmZlgHfty8R10SYvseZBMeGh/rkMCZRWfAjZRUyt9fvsERnHbEie2n4fux5HNYn+64jprXIWrVgZ7UYlmgreDYgJOWdyiRFd6l2LuGjHrbpVxN+3t1JP+/O7x+C8Pea0wbzuXrJSq4j/M9tBCrhButWvBPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WYSDcJSpf/CrtK/mRIfziLAqPOvEfcKbRIPhQ/IuNQ=;
 b=gZuSO3TJvpu+xp7/26b59qrrxWqkduEo7HBMV5dcoOrk65MBi2M9g7r5yQs3zB4XYkisc8FIxDL3vKnQHGeQwhr7mp6TM5Uu61RJzSnr2p7W99BpQi2VeOs0E+a3q93F6ClItgKd89bJu1uF5bnbtI7UVyqmPjyWtfXRPR4bzTvkV1zwUHMew5PRf4vy+ZFFxDMq0djCTsZlzg5GADpIUDwYRD7U5MNmTBMG+sAOjQOwnMt8dxNzVkvYHJqI6aHFzaDS8PEfBr4v0kHfv/WdYzSYFpEKdhqAyhK08q3d9jaiWc2T4yKr5jCJWECfrytXSbSEwBFu44M4J9m69NCtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WYSDcJSpf/CrtK/mRIfziLAqPOvEfcKbRIPhQ/IuNQ=;
 b=ekO5PVxKim8VSFZjPlGkh9Ig/Hk542zU3iGt9t9fjZ4dncaauGmydJGTmnbKoadhLG5YPFod57MKEGBjUMZotQZ6TmF6q2YWbXRHoetHFGgXqrNEc82AD6A1VrwHlwS8/YRXtJtm1IlO4vqXyhZmIRGse0spAC5ccn3wRM0ixbQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:23:55 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:23:55 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
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
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
Date: Mon, 12 Apr 2021 20:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
X-ClientProxiedBy: PR3P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c]
 (2a02:908:1252:fb60:924c:f5e7:1b2d:1b8c) by
 PR3P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:23:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c84ca6-8842-43a2-188b-08d8fde021ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB420876D62B61ED3276E4628C83709@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5trvtw7KcWGBMmWl4gbd546X4ElAcnhw90/ZdsQ6z4AJrmvpgBm1QWKC+KIcsL6LUFTpTN2s1lAfQcOuUyqq890RpVP4wI9zyt9fjgMdvRahczo4O9TPYFa/X+4QVELtNCZ74yfkArW1xBnVhztj+sbVt3DUnMU/8P5kzRNPTnDI4PGaX8IYYGaHGYQfXOXSqsy2a2hIsNtpIHlOAeClXljDlaT4kZmXPEPG7bsRBTPR0VP1XaWCIAdmB7sacq3UJwcmz4Uuu/LPCJLq+fvOCRdWN6Px5qsjCC0l+E4VG9TdDEg7GW7YqeILIACnauWCUh2LqnhN7qjc2RoCT+8pZOHPtDNELZkvStIZaeSWJBSHGDZjOLM0NZnB1SyPTese16Kd4kIJ70oj52V/XmiaRDZ9OOmUow68qq/aSqOxRGFfFliuKINKpI2ssRRYEVqC8zs1bNTr6lkzyl44ydIIAyXDXfBeyh9wHIl7wh20xOfaLCJ9R8W17ljfbdb43r66YG2QEw8lco3bcw0OALQoUSPpxnDF5lrOCde1aciwicAl0wUX9Ai2bq/McrgR/l5V3De3U5m2mZ3z89Qb3hMh+8l4FAqUjWUCA+qBSUeRJoU3yoGdHlBCi0JgB/725LSf5TB1xcI9Y2rbzscjW/6O4uNZWsLRdxDLXu2ZDEyKtWh0Wf6T/7LyxNutGXNMKwV+Fo8ko7hwaDu9R2M5hhJtsB36u2CM5lZF0J/JhzCiiGyTAVeA2BEcXXceZxOU5e4gXWVa0IBXVCHjXnXZ0vcrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(52116002)(478600001)(2906002)(31696002)(6486002)(966005)(53546011)(66574015)(30864003)(86362001)(6666004)(186003)(33964004)(2616005)(16526019)(6636002)(8936002)(8676002)(166002)(316002)(110136005)(66476007)(66556008)(36756003)(66946007)(83380400001)(5660300002)(45080400002)(921005)(38100700002)(31686004)(60764002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzErRU80NlB3Z2NVWG9pZk82L09wUGNMbUNtMmcyUmxBK1U5SzJVei84R2hR?=
 =?utf-8?B?OVg0MzJEWFpmYmVCaUtBUmIyK0ZSdUxvNlZtV282WjdVbEdKbmI0NStXNk16?=
 =?utf-8?B?VFUxbTIzZVB0dmFqaC91L0tzRC8zUHZtVDM1a3d3WVZtYm5pQjhEbzltdVdh?=
 =?utf-8?B?QmQzSk5pYzZPcU9GOGRTVVRyWXJjRGFpMXFoS2FiMmpkenpnOHQwaGI3S0VU?=
 =?utf-8?B?OFJXOGZjWHA1MUhIcmJCYldxdzJ1YXVKTis1MWJrSFFFOHZPQkg0TTFabHRQ?=
 =?utf-8?B?ZnFFeDJKVHJ6VEkxb09UZTkxOUtNQmVrU0x4M3d3MHJIU1J5MTgxVWtjWEVR?=
 =?utf-8?B?SXFUTkZmQkxwanpvOUo0OTlUcnFvRWpmMGpMcXdIRU9Sd2prTU56Q1pjZjJy?=
 =?utf-8?B?TUNSYkRwZlFJZzRyZ3lIVjJuTFJvaVVlcS8weUd2ODZOQVNaMkZ5NUp6aXQx?=
 =?utf-8?B?QW5nTm5mektGWDgvLzZIT0xsTGJnSW9mbnI2YVZ3bmlKWWdzRTNDVkJNNE9E?=
 =?utf-8?B?aWdCeTc3SEg2S2cwS0I4SWJSZnJGb1dXdk1TT2JZYTViRG5jd1FHMEJCbzBx?=
 =?utf-8?B?MHlWa3VIMWgyWTI3eEQreGMzNExxNUUzZXF4bVJFUXgwcllodDNtdFNPNmtK?=
 =?utf-8?B?ZG5oVUhzdG1ZQWpzL1AxRnoyTCtKQTd4akxiYVU0K3dNRkJWVTdqanhzdnNW?=
 =?utf-8?B?cGFkcFdnWm1xTGJDSURYdVBiazFVaC81OGw2aytxM215eDZwd05iS1c1TFQ2?=
 =?utf-8?B?RWF0TTBRNk9lMytpZ21uUXp6dFNDSUpwTmhRbDF4OWIzNFBJaklwazNob0sr?=
 =?utf-8?B?ZEpEVFBRVlFBUndadTJyYzQ0M0lBUGxTblgxcWU2KzZ4WnptQTI3ZjRrYk10?=
 =?utf-8?B?OVQ0VVdyTDBtazBLZEZWdTNOZVdwQUxRaHRkNkNYRGZ4akN0VXBGdnUxUkU4?=
 =?utf-8?B?dkVxRlBJc3IvV2VmM2NUanNyeXZWS3FObE02b2wzY3ZsV1RaK1o3L0wwV3dB?=
 =?utf-8?B?d1QrMFZJQ2F5RnBqMjdvNjh6TlNac1JFZzh0MisvdDJkWDN3Qm0wdWMzTFNo?=
 =?utf-8?B?WC9vOG9JVVc0QWpReTJnZ3dzL3kraWNqcHl1UVNyaXU1blpJbnNsWWtNV3RF?=
 =?utf-8?B?N2RaQXVWQ1ZLdnR2UFl6dUR3ZW1sYUJKaWFzYnNNL3hJd2QycGVRMmxGUHpj?=
 =?utf-8?B?bjVHUGRPOFZFdXVwQ3VLZmZRTHFISGlJY2FrdFkxUU0vZEhMbmlYV3FNL2Yx?=
 =?utf-8?B?emFqa3U2OFFDa2RwUjRubnpGbVFwNHZqRjZUVWdLWjZhaXlhSUZhNURJL3RQ?=
 =?utf-8?B?b005MXI4VFpVZTI0N3FoV0FzRm5sTTh3V1ZsNjNCTC9IZnhhV0ljMzZPMzF5?=
 =?utf-8?B?Z1p0V21rdHJ5dXFwTFIycFhOK0tFZ1RUQVFjOXppdy9yZ0lWM29tTWlSbzIy?=
 =?utf-8?B?TldEQk5iNmo3RnNtSyttTXBtRDRnOHZMQnpyYlIyYmJjWmJEMC9ZZXo3SzYz?=
 =?utf-8?B?MEVkcW56THl0SjFRM3lRV2dtMFNnVWg2bTJCUVFKRmdPT3NNakplTlBmMzFS?=
 =?utf-8?B?S1J3NzBha0dmVmVSRWN0bExyQmZwZ1J6OWdFQ1RnelZIUkFHNENaUG5WTDlE?=
 =?utf-8?B?VERtdS8vaWV4TERZb0o0Z3dIU0M0MWQ0c1VmQndpZGdGcTM3aWo5Z2lEM00z?=
 =?utf-8?B?VnVHd1FncDVqVG5STWQzVVd0UHQ5NDV2T2lGcGpSbTByS2N5Y2piYm1IaDBF?=
 =?utf-8?B?aUxmQWNNbHlXemRFbGdrTmxCVTR2V045YkpaUmV0ZXlqUDRLVGxURzhDclpB?=
 =?utf-8?B?TUp5ZUwvUllyTVNzSXRBckJreGRKbnBLWU1XOHRmSTNUV25wdVJFSy85Tnhi?=
 =?utf-8?Q?J+r8cLpoPmusX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c84ca6-8842-43a2-188b-08d8fde021ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:23:55.4926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d9Xzq5WZHuu7EDQVRMNOAUz++kpop3eID2oG20S/OWKQStaIc7B/fDG+N/A1kKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Content-Type: multipart/mixed; boundary="===============0533777714=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0533777714==
Content-Type: multipart/alternative;
 boundary="------------2C032D294992779ECB0EC2B3"
Content-Language: en-US

--------------2C032D294992779ECB0EC2B3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.04.21 um 20:18 schrieb Andrey Grodzovsky:
>
> On 2021-04-12 2:05 p.m., Christian König wrote:
>
>> Am 12.04.21 um 20:01 schrieb Andrey Grodzovsky:
>>>
>>> On 2021-04-12 1:44 p.m., Christian König wrote:
>>>
>>>>
>>>> Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:
>>>>> On 2021-04-10 1:34 p.m., Christian König wrote:
>>>>>> Hi Andrey,
>>>>>>
>>>>>> Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky:
>>>>>>> [SNIP]
>>>>>>>>>
>>>>>>>>> If we use a list and a flag called 'emit_allowed' under a lock 
>>>>>>>>> such that in amdgpu_fence_emit we lock the list, check the 
>>>>>>>>> flag and if true add the new HW fence to list and proceed to 
>>>>>>>>> HW emition as normal, otherwise return with -ENODEV. In 
>>>>>>>>> amdgpu_pci_remove we take the lock, set the flag to false, and 
>>>>>>>>> then iterate the list and force signal it. Will this not 
>>>>>>>>> prevent any new HW fence creation from now on from any place 
>>>>>>>>> trying to do so ?
>>>>>>>>
>>>>>>>> Way to much overhead. The fence processing is intentionally 
>>>>>>>> lock free to avoid cache line bouncing because the IRQ can move 
>>>>>>>> from CPU to CPU.
>>>>>>>>
>>>>>>>> We need something which at least the processing of fences in 
>>>>>>>> the interrupt handler doesn't affect at all.
>>>>>>>
>>>>>>>
>>>>>>> As far as I see in the code, amdgpu_fence_emit is only called 
>>>>>>> from task context. Also, we can skip this list I proposed and 
>>>>>>> just use amdgpu_fence_driver_force_completion for each ring to 
>>>>>>> signal all created HW fences.
>>>>>>
>>>>>> Ah, wait a second this gave me another idea.
>>>>>>
>>>>>> See amdgpu_fence_driver_force_completion():
>>>>>>
>>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>>>>>>
>>>>>> If we change that to something like:
>>>>>>
>>>>>> amdgpu_fence_write(ring, ring->fence_drv.sync_seq + 0x3FFFFFFF);
>>>>>>
>>>>>> Not only the currently submitted, but also the next 0x3FFFFFFF 
>>>>>> fences will be considered signaled.
>>>>>>
>>>>>> This basically solves out problem of making sure that new fences 
>>>>>> are also signaled without any additional overhead whatsoever.
>>>>>
>>>>>
>>>>> Problem with this is that the act of setting the sync_seq to some 
>>>>> MAX value alone is not enough, you actually have to call 
>>>>> amdgpu_fence_process to iterate and signal the fences currently 
>>>>> stored in ring->fence_drv.fences array and to guarantee that once 
>>>>> you done your signalling no more HW fences will be added to that 
>>>>> array anymore. I was thinking to do something like bellow:
>>>>>
>>>>
>>>> Well we could implement the is_signaled callback once more, but I'm 
>>>> not sure if that is a good idea.
>>>
>>>
>>> This indeed could save the explicit signaling I am doing bellow but 
>>> I also set an error code there which might be helpful to propagate 
>>> to users
>>>
>>>
>>>>
>>>>> amdgpu_fence_emit()
>>>>>
>>>>> {
>>>>>
>>>>>     dma_fence_init(fence);
>>>>>
>>>>>     srcu_read_lock(amdgpu_unplug_srcu)
>>>>>
>>>>>     if (!adev->unplug)) {
>>>>>
>>>>>         seq = ++ring->fence_drv.sync_seq;
>>>>>         emit_fence(fence);
>>>>>
>>>>> */* We can't wait forever as the HW might be gone at any point*/**
>>>>>        dma_fence_wait_timeout(old_fence, 5S);*
>>>>>
>>>>
>>>> You can pretty much ignore this wait here. It is only as a last 
>>>> resort so that we never overwrite the ring buffers.
>>>
>>>
>>> If device is present how can I ignore this ?
>>>
>
> I think you missed my question here
>

Sorry I thought I answered that below.

See this is just the last resort so that we don't need to worry about 
ring buffer overflows during testing.

We should not get here in practice and if we get here generating a 
deadlock might actually be the best handling.

The alternative would be to call BUG().

>>>
>>>>
>>>> But it should not have a timeout as far as I can see.
>>>
>>>
>>> Without timeout wait the who approach falls apart as I can't call 
>>> srcu_synchronize on this scope because once device is physically 
>>> gone the wait here will be forever
>>>
>>
>> Yeah, but this is intentional. The only alternative to avoid 
>> corruption is to wait with a timeout and call BUG() if that triggers. 
>> That isn't much better.
>>
>>>
>>>>
>>>>>         ring->fence_drv.fences[seq & 
>>>>> ring->fence_drv.num_fences_mask] = fence;
>>>>>
>>>>>     } else {
>>>>>
>>>>>         dma_fence_set_error(fence, -ENODEV);
>>>>>         DMA_fence_signal(fence)
>>>>>
>>>>>     }
>>>>>
>>>>>     srcu_read_unlock(amdgpu_unplug_srcu)
>>>>>     return fence;
>>>>>
>>>>> }
>>>>>
>>>>> amdgpu_pci_remove
>>>>>
>>>>> {
>>>>>
>>>>>     adev->unplug = true;
>>>>>     synchronize_srcu(amdgpu_unplug_srcu)
>>>>>
>>>>
>>>> Well that is just duplicating what drm_dev_unplug() should be doing 
>>>> on a different level.
>>>
>>>
>>> drm_dev_unplug is on a much wider scope, for everything in the 
>>> device including 'flushing' in flight IOCTLs, this deals 
>>> specifically with the issue of force signalling HW fences
>>>
>>
>> Yeah, but it adds the same overhead as the device srcu.
>>
>> Christian.
>
>
> So what's the right approach ? How we guarantee that when running 
> amdgpu_fence_driver_force_completion we will signal all the HW fences 
> and not racing against some more fences insertion into that array ?
>

Well I would still say the best approach would be to insert this between 
the front end and the backend and not rely on signaling fences while 
holding the device srcu.

BTW: Could it be that the device SRCU protects more than one device and 
we deadlock because of this?

Christian.

> Andrey
>
>
>>
>>> Andrey
>>>
>>>
>>>>
>>>> Christian.
>>>>
>>>>>     /* Past this point no more fence are submitted to HW ring and 
>>>>> hence we can safely call force signal on all that are currently 
>>>>> there.
>>>>>      * Any subsequently created  HW fences will be returned 
>>>>> signaled with an error code right away
>>>>>      */
>>>>>
>>>>>     for_each_ring(adev)
>>>>>         amdgpu_fence_process(ring)
>>>>>
>>>>>     drm_dev_unplug(dev);
>>>>>     Stop schedulers
>>>>>     cancel_sync(all timers and queued works);
>>>>>     hw_fini
>>>>>     unmap_mmio
>>>>>
>>>>> }
>>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Alternatively grabbing the reset write side and stopping and 
>>>>>>>>>> then restarting the scheduler could work as well.
>>>>>>>>>>
>>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I didn't get the above and I don't see why I need to reuse the 
>>>>>>>>> GPU reset rw_lock. I rely on the SRCU unplug flag for unplug. 
>>>>>>>>> Also, not clear to me why are we focusing on the scheduler 
>>>>>>>>> threads, any code patch to generate HW fences should be 
>>>>>>>>> covered, so any code leading to amdgpu_fence_emit needs to be 
>>>>>>>>> taken into account such as, direct IB submissions, VM flushes 
>>>>>>>>> e.t.c
>>>>>>>>
>>>>>>>> You need to work together with the reset lock anyway, cause a 
>>>>>>>> hotplug could run at the same time as a reset.
>>>>>>>
>>>>>>>
>>>>>>> For going my way indeed now I see now that I have to take reset 
>>>>>>> write side lock during HW fences signalling in order to protect 
>>>>>>> against scheduler/HW fences detachment and reattachment during 
>>>>>>> schedulers stop/restart. But if we go with your approach  then 
>>>>>>> calling drm_dev_unplug and scoping amdgpu_job_timeout with 
>>>>>>> drm_dev_enter/exit should be enough to prevent any concurrent 
>>>>>>> GPU resets during unplug. In fact I already do it anyway - 
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;reserved=0
>>>>>>
>>>>>> Yes, good point as well.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


--------------2C032D294992779ECB0EC2B3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 12.04.21 um 20:18 schrieb Andrey Grodzovsky:<br>
    <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
      
      <p>On 2021-04-12 2:05 p.m., Christian König wrote:<br>
      </p>
      <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com"> Am
        12.04.21 um 20:01 schrieb Andrey Grodzovsky:<br>
        <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
          <p>On 2021-04-12 1:44 p.m., Christian König wrote:<br>
          </p>
          <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
            Am 12.04.21 um 19:27 schrieb Andrey Grodzovsky:<br>
            <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
              <div class="moz-cite-prefix">On 2021-04-10 1:34 p.m.,
                Christian König wrote:<br>
              </div>
              <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">Hi
                Andrey, <br>
                <br>
                Am 09.04.21 um 20:18 schrieb Andrey Grodzovsky: <br>
                <blockquote type="cite">[SNIP] <br>
                  <blockquote type="cite">
                    <blockquote type="cite"> <br>
                      If we use a list and a flag called 'emit_allowed'
                      under a lock such that in amdgpu_fence_emit we
                      lock the list, check the flag and if true add the
                      new HW fence to list and proceed to HW emition as
                      normal, otherwise return with -ENODEV. In
                      amdgpu_pci_remove we take the lock, set the flag
                      to false, and then iterate the list and force
                      signal it. Will this not prevent any new HW fence
                      creation from now on from any place trying to do
                      so ? <br>
                    </blockquote>
                    <br>
                    Way to much overhead. The fence processing is
                    intentionally lock free to avoid cache line bouncing
                    because the IRQ can move from CPU to CPU. <br>
                    <br>
                    We need something which at least the processing of
                    fences in the interrupt handler doesn't affect at
                    all. <br>
                  </blockquote>
                  <br>
                  <br>
                  As far as I see in the code, amdgpu_fence_emit is only
                  called from task context. Also, we can skip this list
                  I proposed and just use
                  amdgpu_fence_driver_force_completion for each ring to
                  signal all created HW fences. <br>
                </blockquote>
                <br>
                Ah, wait a second this gave me another idea. <br>
                <br>
                See amdgpu_fence_driver_force_completion(): <br>
                <br>
                amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq); <br>
                <br>
                If we change that to something like: <br>
                <br>
                amdgpu_fence_write(ring, ring-&gt;fence_drv.sync_seq +
                0x3FFFFFFF); <br>
                <br>
                Not only the currently submitted, but also the next
                0x3FFFFFFF fences will be considered signaled. <br>
                <br>
                This basically solves out problem of making sure that
                new fences are also signaled without any additional
                overhead whatsoever.</blockquote>
              <p><br>
              </p>
              <p>Problem with this is that the act of setting the
                sync_seq to some MAX value alone is not enough, you
                actually have to call amdgpu_fence_process to iterate
                and signal the fences currently stored in
                ring-&gt;fence_drv.fences array and to guarantee that
                once you done your signalling no more HW fences will be
                added to that array anymore. I was thinking to do
                something like bellow:</p>
            </blockquote>
            <br>
            Well we could implement the is_signaled callback once more,
            but I'm not sure if that is a good idea.<br>
          </blockquote>
          <p><br>
          </p>
          <p>This indeed could save the explicit signaling I am doing
            bellow but I also set an error code there which might be
            helpful to propagate to users</p>
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
            <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
              <p>amdgpu_fence_emit()</p>
              <p>{</p>
              <p>&nbsp;&nbsp;&nbsp; dma_fence_init(fence);<br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; srcu_read_lock(amdgpu_unplug_srcu)</p>
              <p>&nbsp;&nbsp;&nbsp; if (!adev-&gt;unplug)) {</p>
              <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; seq = ++ring-&gt;fence_drv.sync_seq;<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; emit_fence(fence);</p>
              <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <b>/* We can't wait forever as the HW might be
                  gone at any point*/</b><b><br>
                  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; dma_fence_wait_timeout(old_fence, 5S);</b><br>
              </p>
            </blockquote>
            <br>
            You can pretty much ignore this wait here. It is only as a
            last resort so that we never overwrite the ring buffers.<br>
          </blockquote>
          <p><br>
          </p>
          <p>If device is present how can I ignore this ?</p>
        </blockquote>
      </blockquote>
      <p><br>
      </p>
      <p>I think you missed my question here <br>
      </p>
    </blockquote>
    <br>
    Sorry I thought I answered that below.<br>
    <br>
    See this is just the last resort so that we don't need to worry
    about ring buffer overflows during testing.<br>
    <br>
    We should not get here in practice and if we get here generating a
    deadlock might actually be the best handling.<br>
    <br>
    The alternative would be to call BUG().<br>
    <br>
    <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
      <p> </p>
      <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com">
        <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
            But it should not have a timeout as far as I can see.<br>
          </blockquote>
          <p><br>
          </p>
          <p>Without timeout wait the who approach falls apart as I
            can't call srcu_synchronize on this scope because once
            device is physically gone the wait here will be forever</p>
        </blockquote>
        <br>
        Yeah, but this is intentional. The only alternative to avoid
        corruption is to wait with a timeout and call BUG() if that
        triggers. That isn't much better.<br>
        <br>
        <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
            <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
              <p> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;fence_drv.fences[seq &amp;
                ring-&gt;fence_drv.num_fences_mask] = fence;<br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; } else {</p>
              <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dma_fence_set_error(fence, -ENODEV);<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DMA_fence_signal(fence) &nbsp;&nbsp; <br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; } &nbsp; <br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; srcu_read_unlock(amdgpu_unplug_srcu)<br>
                &nbsp;&nbsp;&nbsp; return fence;<br>
              </p>
              <p>}</p>
              <p>amdgpu_pci_remove <br>
              </p>
              <p>{</p>
              <p>&nbsp;&nbsp;&nbsp; adev-&gt;unplug = true;<br>
                &nbsp;&nbsp;&nbsp; synchronize_srcu(amdgpu_unplug_srcu) <br>
              </p>
            </blockquote>
            <br>
            Well that is just duplicating what drm_dev_unplug() should
            be doing on a different level.<br>
          </blockquote>
          <p><br>
          </p>
          <p>drm_dev_unplug is on a much wider scope, for everything in
            the device including 'flushing' in flight IOCTLs, this deals
            specifically with the issue of force signalling HW fences</p>
        </blockquote>
        <br>
        Yeah, but it adds the same overhead as the device srcu.<br>
        <br>
        Christian.<br>
      </blockquote>
      <p><br>
      </p>
      <p>So what's the right approach ? How we guarantee that when
        running amdgpu_fence_driver_force_completion we will signal all
        the HW fences and not racing against some more fences insertion
        into that array ?</p>
    </blockquote>
    <br>
    Well I would still say the best approach would be to insert this
    between the front end and the backend and not rely on signaling
    fences while holding the device srcu.<br>
    <br>
    BTW: Could it be that the device SRCU protects more than one device
    and we deadlock because of this?<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com">
      <p>Andrey<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com"> <br>
        <blockquote type="cite" cite="mid:aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com">
          <p>Andrey</p>
          <p><br>
          </p>
          <blockquote type="cite" cite="mid:cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com"> <br>
            Christian.<br>
            <br>
            <blockquote type="cite" cite="mid:80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com">
              <p>&nbsp;&nbsp;&nbsp; /* Past this point no more fence are submitted to
                HW ring and hence we can safely call force signal on all
                that are currently there. <br>
                &nbsp;&nbsp;&nbsp;&nbsp; * Any subsequently created&nbsp; HW fences will be
                returned signaled with an error code right away <br>
                &nbsp;&nbsp;&nbsp;&nbsp; */<br>
              </p>
              <p>&nbsp;&nbsp;&nbsp; for_each_ring(adev)<br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring)</p>
              <p>&nbsp;&nbsp;&nbsp; drm_dev_unplug(dev);<br>
                &nbsp;&nbsp;&nbsp; Stop schedulers<br>
                &nbsp;&nbsp;&nbsp; cancel_sync(all timers and queued works);<br>
                &nbsp;&nbsp;&nbsp; hw_fini<br>
                &nbsp;&nbsp;&nbsp; unmap_mmio<br>
              </p>
              <p>}</p>
              <p><br>
              </p>
              <p>Andrey</p>
              <p><br>
              </p>
              <blockquote type="cite" cite="mid:b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com">
                <br>
                <br>
                <blockquote type="cite"> <br>
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite"> <br>
                        Alternatively grabbing the reset write side and
                        stopping and then restarting the scheduler could
                        work as well. <br>
                        <br>
                        Christian. <br>
                      </blockquote>
                      <br>
                      <br>
                      I didn't get the above and I don't see why I need
                      to reuse the GPU reset rw_lock. I rely on the SRCU
                      unplug flag for unplug. Also, not clear to me why
                      are we focusing on the scheduler threads, any code
                      patch to generate HW fences should be covered, so
                      any code leading to amdgpu_fence_emit needs to be
                      taken into account such as, direct IB submissions,
                      VM flushes e.t.c <br>
                    </blockquote>
                    <br>
                    You need to work together with the reset lock
                    anyway, cause a hotplug could run at the same time
                    as a reset. <br>
                  </blockquote>
                  <br>
                  <br>
                  For going my way indeed now I see now that I have to
                  take reset write side lock during HW fences signalling
                  in order to protect against scheduler/HW fences
                  detachment and reattachment during schedulers
                  stop/restart. But if we go with your approach&nbsp; then
                  calling drm_dev_unplug and scoping amdgpu_job_timeout
                  with drm_dev_enter/exit should be enough to prevent
                  any concurrent GPU resets during unplug. In fact I
                  already do it anyway - <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Def0ea4dd29ef44d2649c5eda16c8f4869acc36b1&amp;amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ceefa9c90ed8c405ec3b708d8fc46daaa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637536728550884740%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
 LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=UiNaJE%2BH45iYmbwSDnMSKZS5z0iak0fNlbbfYqKS2Jo%3D&amp;amp;reserved=0</a><br>
                </blockquote>
                <br>
                Yes, good point as well. <br>
                <br>
                Christian. <br>
                <br>
                <blockquote type="cite"> <br>
                  Andrey <br>
                  <br>
                  <br>
                  <blockquote type="cite"> <br>
                    <br>
                    Christian. <br>
                    <br>
                    <blockquote type="cite"> <br>
                      Andrey <br>
                      <br>
                      <br>
                      <blockquote type="cite"> <br>
                        <blockquote type="cite"> <br>
                          Christian. <br>
                          <br>
                          <blockquote type="cite"> <br>
                            Andrey <br>
                            <br>
                            <br>
                            <blockquote type="cite"> <br>
                              <blockquote type="cite">Andrey <br>
                                <br>
                                <br>
                              </blockquote>
                              <br>
                            </blockquote>
                          </blockquote>
                          <br>
                        </blockquote>
                        <br>
                      </blockquote>
                    </blockquote>
                    <br>
                  </blockquote>
                </blockquote>
                <br>
              </blockquote>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------2C032D294992779ECB0EC2B3--

--===============0533777714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0533777714==--
