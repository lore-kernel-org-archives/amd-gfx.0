Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28736606D808
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 02:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCC610F959;
	Wed,  4 Nov 2026 02:33:56 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187CB10F978
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 02:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh4Pmzh5Lyi6StNHE8Q6UVdIqyuPOX0bKfJrG6EoWgHbVIWXTWR2bRvFf1ezwAxOUMFrXGxqG6FoEVALgIlJdKpT82ob38ueMfnUfsqm7asfk0H5szlX+CQP7+EOxdRurEnWu1qlQBfhvdiGZGHcrPbl//9iFmHHvO5IAMzbqJQ4DvWVbxFzGsSKaMaEpk1F2PZQ3mY4XBKs24seFaxBEWdD5YL9lYN9hZjXC8i6s9Vcsy0Vt8isuYJlkHBfM45dpgWDiGXh7R7zSBKNo+ICSH69jQ5FGa9ihR/9h3+GbwcYqZUUbFo1j2fjEoogv8UHA78Q0Igp9lgtkYuVZEYmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCnP+Er7nbU3y0J8KZTPgiUoHj6aJf32dXY7PnaCTXs=;
 b=TMN6q7IrMe7jdOeAdCRVjuu+YzsjZHxwjnP4WugYDRlP5z4ViEL3iGSBCVE/Anu24+PPcj9k4+7mB1RE9rYIQmMw0+Gdrm3h6JWkJONoRp1dO+Jzqiipf2ehYpjo1iEnj9OCX8UpKDQEooJxSKyEofKjbhHWKe8NgIKGyCxTcwvFXZQlj79HjUe8jVkPRba8P9Pz9KAtFwhE18sderbsVjgxdls95iaNH5sCnRYBRJEMhD836607aIhBk7zh8KYnpW5XnenR4j7n+PPF/XxcxvF6IOvbwvaVr96src7f7Te3yjVsG02kECcrf9x7+uLfA3cvbVXwRkfXPBT1eRH1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCnP+Er7nbU3y0J8KZTPgiUoHj6aJf32dXY7PnaCTXs=;
 b=c6l+FNI2TaEOlR/oShbn662stcLunSvmSzbk1IRwnWSfYoB373xoQiqwMLtxNfl2mgxh+ELV2GjRll38RSI8b04ZQYzKspXA/XZ3tJ/mJLkS9G9lyvrzFJLHawKg11XRIRAfbio6WN1Fr5fuGcuEIVtCzT9zbjPSNCyHNFzG1d4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 02:33:46 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 02:33:46 +0000
Content-Type: multipart/alternative;
 boundary="------------Qo91F8ptZGUOm34pJagMHkyY"
Message-ID: <4fe2a2e2-62f0-4ce5-bc6a-d2f8777b5594@amd.com>
Date: Wed, 4 Nov 2026 10:33:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: James Zhu <jamesz@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Welton, Benjamin" <Benjamin.Welton@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-3-lingshan.zhu@amd.com>
 <d3144b38-64a3-4bbe-910f-722912f9fc66@amd.com>
 <6394fa47-ec53-4e54-9cc9-bbd59b97f174@amd.com>
 <61ab80af-0a33-4660-9f80-13966c3583a2@amd.com>
 <c96bc906-c6aa-479b-84d6-75ec1816e853@amd.com>
 <DM4PR12MB85589778D67BE6864EA41355E46F2@DM4PR12MB8558.namprd12.prod.outlook.com>
 <f34fe3de-918f-4911-91fd-19b8fb19d8a0@amd.com>
 <2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com>
 <a8d8bd34-d0db-4a06-926b-e6c4f27bb8d8@amd.com>
 <d30abe5a-b011-4172-9efe-25b89360b9d7@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <d30abe5a-b011-4172-9efe-25b89360b9d7@amd.com>
X-ClientProxiedBy: SEWP216CA0063.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::12) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f82031-2cd7-4b4e-b0d3-08df3a1c0ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|261102123227099003|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: AyCE6HPvJeh4pMW2yCWvn0moLgifQ5Ry4OBrzLez7EAdYzSzSAreDAnPv79pn4tYnjDuCZqZM51sUHyDlRPDkKYf00KcCZ7/FZddO/wrFJFEeGtFfNDKCTdK8JxO20JIboSaIhAoR0FLHWl2O0u6sMHJ9eFzeGIfU76U/SVXe1SVLdRs/PLPTPY45ZwfFMOiRuuBWwMscT97u5jIbZJYrOwgfWwrXCxMI2BwDNj6Ss9A7ZwB4ydsiRTF7U2S5/GmTa0z6flT0+F5ingNmO9tJ/I9nMQ4/Kye62Ecj6zPiGj/pilEPw4xsf+NtjYyG23J6gk5tHwAbChY7mhNhVq2Z21z7ZKUaMKKYeL+zSTfspGvv9Qx7ITRw2ATRcOPFNSQrTtcOSbQ9pUsunfu99XZ9HKDEpaEmE/x5fuKMMo+VJYbwKUi9WeEmKia0ExHc1LbCUfuwjKLLPTShTLVGBBxoMukAhlnPVfIj6ngo1tTdtTV2ug/FZTENH2L+n0+QZMYqxpJopWw6vd7J0SqeaBcSFete8JA2EJlEochgk9kuj8VNYPmC2XbvCy+nRtld60Al69KB+q0R80AuMrV6vAq2tsBUTgN/7reju8t8NksOZDCNNUcmYiDI6AXoHjXxSWX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(261102123227099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJOTU96ZHllczdaN3I5TjJUaEJLRVA0eGNjd0ZzMWE5d1dRYlNLVDd5bEJK?=
 =?utf-8?B?VjNsL2l0RU82NTJkZzlxdFRVZGFPc2hlMnBndXh6SHNDaWtmN2N5UHdGYzll?=
 =?utf-8?B?YnZHanhhcUlvT0pVWllOVkF3SGlVVzVCbjVuLzBpRWFsQWEzL2d6WFowQUkz?=
 =?utf-8?B?SmNGeTZsRWd6SmFNeTc3WVBXeUpRUjZFQUdwWW1FeE1HbCtRUEMvaEZrZDRE?=
 =?utf-8?B?dDVDbzBvWWowankyV3NycWlidTNzQ05IWmExSkZPNXZsczJBTktrL0JhQXkv?=
 =?utf-8?B?YytBNk5EWGdqN3JPcFNyK1FCdSs1WGRsSlJjY25pQjBLVWpUS2w4ajJOTXBv?=
 =?utf-8?B?d1dqank2SDNBSTdYOUd1akU2WE9qOUg4MzY1YVJhUDdxNlFXUGhnd1NvYzRY?=
 =?utf-8?B?K2d2YlhENkVHc0p4d28xQ3NvcjdjWDdtcTJOU1RiSTJrZWR3OUY1UFJsNHB0?=
 =?utf-8?B?elhTNkwzTzFsTTd2eWdkQ3hjUVRVNGZncTJUYVZwbUtGTzMvcjVlRHlWa01X?=
 =?utf-8?B?Zk9yQVhobXVkWFM4WmVtMG00RGtRL3ZQQlREeFplakYrTWNGZU5EcnVXWXpV?=
 =?utf-8?B?OFJsekhaVkcxUFZxM2hZMm51TG1VRms3UVB5UWdqZkRVQjd4b0cxbFRwOHBH?=
 =?utf-8?B?N3VSdXRpNjE2eEdBS3JVTTNnVXdLRTkzS0VhOTRaKytYckRGL0g1ck5Na0pw?=
 =?utf-8?B?M1B3ellxQTRiaWpkTG1EbmxSc1RBc3lrTlhyRHZPMHJxZUdaYWUrSGZVVkE5?=
 =?utf-8?B?Q1NlRVN6aFZKM1dpaVFkNEtaZnp3VStPcXZqd1Y1QndKUHZJaGdidmRRMUxk?=
 =?utf-8?B?SXBwM1VMeG1WYmJ2V1FEa2xVS1JRL3AwREtFNVFsODF4NHZXc21wTDZ2MTVG?=
 =?utf-8?B?UEJDTzEzdUpvd0ZJL2Z0R3JUZnoxSWlEaFZHb2xpa05MdkRnOVBxV0x0bTR1?=
 =?utf-8?B?ZGU3NkZUNHB2cGlrYzBETjhIejFBckJWbVJOYkU1U2RRcDdoMlE3SXl4enZl?=
 =?utf-8?B?QnF6YmRacysvMXFRZC9DQzlFdWg2UzZFajh5cCtGTDRBWGRIa0VYdXJxVTJG?=
 =?utf-8?B?RXpOTTUzZFZSSHBpMWhLYU1XNUpldjJacWJRay8xbjY3MlhSYk5Zdnk4TGNQ?=
 =?utf-8?B?T21iVlNSeTZUYzYrZUZIOWYzVElsOVcyL3RhVmg5VkhjOEI3YVhLM1QwTk0z?=
 =?utf-8?B?ZTJ6YldnRDJnQ0Nid29mWDVUdHVZdW0zY3NJQU1DVGFER3FDck9NbnpjalFk?=
 =?utf-8?B?MXNJUUF4QjZFblY5Y21yODBHYWFiK0o3eWdWakVpYjhWbitZWWZyeG1CS1Fk?=
 =?utf-8?B?Tm9lajQ1YnlTUTNNeW0xckhmNjZQaHFCcTB0YzJ3SG0rWWIrbHJtNSttREZQ?=
 =?utf-8?B?Njc1ZXJoa2toc1B2WEN1Y0svb0pBeGNSajV6b1BpdmpBS0tTMC8xd0R4d2c4?=
 =?utf-8?B?eWdCVFNnQU5vbTRqWXd2ZTFmYU1ucmd2WmtDWDlQWWkrTklVeVo4QXp5NW12?=
 =?utf-8?B?N3RWQWhod09MUXk5YVd0NVpuSWFKWC9iN0UzNWFOMVVJalhOajM0ZkVYR1Ev?=
 =?utf-8?B?Q3ZVSzJSSm5jZ2pIbFN5NWt0WHp3WEFGNnlPOG9jNXhxYll3aGlyeFRnOEJX?=
 =?utf-8?B?RlBZbjFpajlCOHVMc0owYVZBbkc1eXJWZWZwNVM5Um9qS01LVi9IQUprWTBF?=
 =?utf-8?B?dHBBRHBsTUNKZ1VMdU1RbVR5czlneG1WYmZNTzR5MFlkSFhFa2RSakdlY1l6?=
 =?utf-8?B?TWw5Zk0rclQxOHFuWUdnWmpYbEV5ZXJVQkNTN242ME1kZlJIYUFBZnZyWkdh?=
 =?utf-8?B?MGp0dzg0N0dyTW5FY3RTN0NXUDk1TnNNS1pmTXc5blpSbkI2dlh1ZFpndndm?=
 =?utf-8?B?OTl4N1hSMDZYNzY0Vit5ZS83eW9xQ1BvT0xNVDY3cUxaTzlHRzBpK3AvbExW?=
 =?utf-8?B?ekpoc3cxd25KZHVLVXhkemZCeHlMSnZqYklhYksxMkk5dDhYaXBMNk9zdTNw?=
 =?utf-8?B?ZXpZb1F4eUhxanVBaVNPNi8wYVIrL0VUSjhCZXo0OVdObGJIb3duWW85TDg3?=
 =?utf-8?B?Y0w1aHNnaU0xaWNLVDNUUy9IVW10c25xSi9jRzNZMXFGTC90czhRQXVscU03?=
 =?utf-8?B?aGViZ0lJMkRkUU5zL2lEdGlqd3UvTlB6MmFwT3Y0ck1iSjdGU2RHSzEvV01W?=
 =?utf-8?B?SGtNaktrdFhtTDNTaDJscmFMa2gxSFN0Tm9oS3dFdCtZV3R2RU9xckxOVkUx?=
 =?utf-8?B?V2x5bmpTcDFtM2hkdXo5MGNLSk5hT3QxN09YSkpEdGhpckxRc1BJYmxzb0tG?=
 =?utf-8?B?Tm0relYzSFAwSGdNQzBYTjhTUmxaWExlQ05YNzdoWW1qNmREeU94QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f82031-2cd7-4b4e-b0d3-08df3a1c0ceb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:33:46.2934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCJDA+/1PgvJ1wI1X/hhZaQc21vC1WunyCwa91/+hikqIhFaDD1thhYftfcn5TipV55mI2Cn0YlNQ+JkDYlKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Qo91F8ptZGUOm34pJagMHkyY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/2026 8:39 PM, James Zhu wrote:

>
> On 2026-10-30 02:10, Zhu, Lingshan wrote:
>> On 10/29/2026 9:37 PM, James Zhu wrote:
>>>
>>> On 2026-10-28 23:13, Zhu, Lingshan wrote:
>>>> On 10/28/2026 8:53 PM, Zhu, James wrote:
>>>>> AMD General
>>>>>
>>>>> Hi, Lingshan,
>>>>>
>>>>> Sorry to reply later! Just be back from vacation.
>>>>>
>>>>> Yes, there is only one set of PMC registers on the device.
>>>>> But the minimum control scope is XCC. So, I think we should design
>>>>> PMC based on
>>>>> Node instead of device. We need not enable the PMC on XCCs which
>>>>> have no PMC
>>>>> data collection request.
>>>>> Since the request is based on render node.
>>>> They are per-device registers, so the scope should be the device,
>>>> not XCC.
>>> [JZ] where did you get this information? From what I know, Compute /
>>> Shader PMCs / RLC & SPM Control / //  /  / / PC Sampling are all XCC
>>> based.  a are all  are
>> For GFX11/12, the instance number of XCC is 0, therefore their
>> xcc_mask is 1, so the registers are per-device.
>> You can read these information from sysfs and debugfs.
>>
>> Please also take a look at KFD implementation
>> athttps://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html
>>
>> It says: multiple PMC profilers on the same device can result in
>> corrupted counter data
>
> [JZ] IIUC, the corruption data is with multiple processes enabled on
> same xcc. We still can have lock design to avoid multiple processes
> running on same node(same XCCs). we can run one PMC profiler on node1
> only and leave other nodes on the same device have its own one only
> PMC profilers process running without affecting each other,.

This implementation only modifies perf_count_enable field in MQD, not touching per-XCC registers, and you have agreed that PMC registers are per-device before,
so lets stick to the KFD design because it has been proven to work and this is a porting of KFD PMC.

Thanks
Lingshan

>
>>>>
>>>> Another reason is, I assume we don't want one user to sniff another
>>>> through PMC.
>>> [JZ] if it is true, is it more easy to sniffer  for per device
>>> design. the other nodes within the same device will enable PMC
>>> unexpectedly.
>> so we have implemented reservation/locking for PMC.
>>
>> Thanks
>> Lingshan
>>>>
>>>> Thanks
>>>> Lingshan
>>>>> Thanks & Best Regards!
>>>>>
>>>>> James Zhu
>>>>>
>>>>> --------------------------------------------------------------------------------
>>>>>
>>>>> *From:* Zhu, Lingshan<Lingshan.Zhu@amd.com>
>>>>> *Sent:* Thursday, October 8, 2026 3:50 AM
>>>>> *To:* Zhu, James<James.Zhu@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix<Felix.Kuehling@amd.com>
>>>>> *Cc:* Huang, Ray<Ray.Huang@amd.com>;amd-gfx@lists.freedesktop.org
>>>>> <amd- gfx@lists.freedesktop.org>
>>>>> *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
>>>>>
>>>>> On 9/24/2026 11:40 PM, James Zhu wrote:
>>>>>
>>>>>> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>>>>>>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>>>>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>>>>>>> This commit implements a device-wide PMC config
>>>>>>>>> for amdgpu, which including the profiling owner,
>>>>>>>>> and the profiling enablement indicator.
>>>>>>>> [JZ] I think it should be render-node wide, not device-wide
>>>>>>> Hi James,
>>>>>>>
>>>>>>> It could be, but we don't have a requirement document defines
>>>>>>> the scope.
>>>>>>>
>>>>>>> But normally a profiler is a device scope,
>>>>>>> I see KFD profiler operates on all queues under the device queue
>>>>>>> manager
>>>>>> [JZ] One device could be split into multiple nodes with different
>>>>>> processes
>>>>>> running.
>>>>>>
>>>>>> I am wondering if this is really we want.  Ben may comment on it.
>>>>> Hello James,
>>>>>
>>>>> Sorry for the late reply, it was mid-autumn festival and national
>>>>> holidays.
>>>>>
>>>>> In my understanding, there is only one set of PMC registers on the
>>>>> device, so it should
>>>>> be device scope.
>>>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>
>>>>>>> Thanks
>>>>>>> Lingshan
>>>>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>>>>>>>> <mailto:lingshan.zhu@amd.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>>>>>    2 files changed, 11 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> b/drivers/gpu/drm/amd/
>>>>>>>>> amdgpu/amdgpu.h
>>>>>>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>>>>>>        AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>>>>>>    };
>>>>>>>>>    +struct amdgpu_pmc_profiler {
>>>>>>>>> +    struct mutex        lock;
>>>>>>>>> +    struct drm_file        *owner;
>>>>>>>>> +    bool            enable;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>    struct amdgpu_device {
>>>>>>>>>        struct device            *dev;
>>>>>>>>>        struct pci_dev            *pdev;
>>>>>>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>>>>>>         */
>>>>>>>>>        struct xarray userq_doorbell_xa;
>>>>>>>>>    +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>>>>>>> +
>>>>>>>>>        /* df */
>>>>>>>>>        struct amdgpu_df                df;
>>>>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> b/drivers/gpu/
>>>>>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index c924a55fd16f..74ed42e53264 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>> mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>>        mutex_init(&adev->benchmark_mutex);
>>>>>>>>> mutex_init(&adev->gfx.reset_sem_mutex);
>>>>>>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>>>>>>          /* Associate locks with lockdep classes for ordering
>>>>>>>>> validation */
>>>>>>>>>        amdgpu_lockdep_set_class(adev);
>>>>>>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>        kfree(adev->pci_state);
>>>>>>>>>        kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>>>>>>        kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>>>>>>> +
>>>>>>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>>>>>>    }
>>>>>>>>>      /**
--------------Qo91F8ptZGUOm34pJagMHkyY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/30/2026 8:39 PM, James Zhu wrote:</pre>
    <blockquote type="cite" cite="mid:d30abe5a-b011-4172-9efe-25b89360b9d7@amd.com">
      <br>
      On 2026-10-30 02:10, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">On 10/29/2026 9:37 PM, James Zhu wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2026-10-28 23:13, Zhu, Lingshan wrote:
          <br>
          <blockquote type="cite">On 10/28/2026 8:53 PM, Zhu, James
            wrote:
            <br>
            <blockquote type="cite">AMD General
              <br>
              <br>
              Hi, Lingshan,
              <br>
              <br>
              Sorry to reply later! Just be back from vacation.
              <br>
              <br>
              Yes, there is only one set of PMC registers on the device.
              <br>
              But the minimum control scope is XCC. So, I think we
              should design PMC based on
              <br>
              Node instead of device. We need not enable the PMC on XCCs
              which have no PMC
              <br>
              data collection request.
              <br>
              Since the request is based on render node.
              <br>
            </blockquote>
            They are per-device registers, so the scope should be the
            device, not XCC.
            <br>
          </blockquote>
          [JZ] where did you get this information? From what I know,
          Compute / Shader PMCs / RLC &amp; SPM Control&nbsp;/ //&nbsp; /&nbsp; / / PC
          Sampling are all XCC based. &nbsp;a are all&nbsp; are
          <br>
        </blockquote>
        For GFX11/12, the instance number of XCC is 0, therefore their
        xcc_mask is 1, so the registers are per-device.
        <br>
        You can read these information from sysfs and debugfs.
        <br>
        <br>
        Please also take a look at KFD implementation
athttps://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html<br>
        <br>
        It says: multiple PMC profilers on the same device can result in
        corrupted counter data
        <br>
      </blockquote>
      <br>
      [JZ] IIUC, the corruption data is with multiple processes enabled
      on same xcc. We still can have lock design to avoid multiple
      processes running on same node(same XCCs). we can run one PMC
      profiler on node1 only and leave other nodes on the same device
      have its own one only PMC profilers process running without
      affecting each other,.
      <br>
    </blockquote>
    <pre>This implementation only modifies perf_count_enable field in MQD, not touching per-XCC registers, and you have agreed that PMC registers are per-device before,
so lets stick to the KFD design because it has been proven to work and this is a porting of KFD PMC.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:d30abe5a-b011-4172-9efe-25b89360b9d7@amd.com"><br>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <br>
            Another reason is, I assume we don't want one user to sniff
            another through PMC.
            <br>
          </blockquote>
          [JZ] if it is true, is it more easy to sniffer&nbsp; for per device
          design. the other nodes within the same device will enable PMC
          unexpectedly.
          <br>
        </blockquote>
        so we have implemented reservation/locking for PMC.
        <br>
        <br>
        Thanks
        <br>
        Lingshan
        <br>
        <blockquote type="cite">
          <blockquote type="cite">
            <br>
            Thanks
            <br>
            Lingshan
            <br>
            <blockquote type="cite">Thanks &amp; Best Regards!
              <br>
              <br>
              James Zhu
              <br>
              <br>
--------------------------------------------------------------------------------
              <br>
              *From:* Zhu, Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
              <br>
              *Sent:* Thursday, October 8, 2026 3:50 AM
              <br>
              *To:* Zhu, James<a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Deucher,
              Alexander
              <br>
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling,
              Felix<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
              <br>
              *Cc:* Huang,
              Ray<a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>;amd-gfx@lists.freedesktop.org
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd- gfx@lists.freedesktop.org&gt;</a>
              <br>
              *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC
              config
              <br>
              <br>
              On 9/24/2026 11:40 PM, James Zhu wrote:
              <br>
              <br>
              <blockquote type="cite">On 2026-09-23 23:23, Zhu, Lingshan
                wrote:
                <br>
                <blockquote type="cite">On 9/23/2026 10:13 PM, James Zhu
                  wrote:
                  <br>
                  <blockquote type="cite">On 2026-09-22 05:34, Zhu
                    Lingshan wrote:
                    <br>
                    <blockquote type="cite">This commit implements a
                      device-wide PMC config
                      <br>
                      for amdgpu, which including the profiling owner,
                      <br>
                      and the profiling enablement indicator.
                      <br>
                    </blockquote>
                    [JZ] I think it should be render-node wide, not
                    device-wide
                    <br>
                  </blockquote>
                  Hi James,
                  <br>
                  <br>
                  It could be, but we don't have a requirement document
                  defines the scope.
                  <br>
                  <br>
                  But normally a profiler is a device scope,
                  <br>
                  I see KFD profiler operates on all queues under the
                  device queue manager
                  <br>
                </blockquote>
                [JZ] One device could be split into multiple nodes with
                different processes
                <br>
                running.
                <br>
                <br>
                I am wondering if this is really we want.&nbsp; Ben may
                comment on it.
                <br>
              </blockquote>
              Hello James,
              <br>
              <br>
              Sorry for the late reply, it was mid-autumn festival and
              national holidays.
              <br>
              <br>
              In my understanding, there is only one set of PMC
              registers on the device, so it should
              <br>
              be device scope.
              <br>
              <br>
              Thanks
              <br>
              Lingshan
              <br>
              <br>
              <blockquote type="cite">
                <blockquote type="cite">Thanks
                  <br>
                  Lingshan
                  <br>
                  <blockquote type="cite">
                    <blockquote type="cite">Signed-off-by: Zhu
                      Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
                      <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;mailto:lingshan.zhu@amd.com&gt;</a>
                      <br>
                      ---
                      <br>
                      &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8
                      ++++++++
                      <br>
                      &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3
                      +++
                      <br>
                      &nbsp;&nbsp; 2 files changed, 11 insertions(+)
                      <br>
                      <br>
                      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                      b/drivers/gpu/drm/amd/
                      <br>
                      amdgpu/amdgpu.h
                      <br>
                      index 8eff6b9ebe81..45897dca802f 100644
                      <br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                      <br>
                      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                      <br>
                      @@ -620,6 +620,12 @@ enum
                      amdgpu_enforce_isolation_mode {
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER
                      = 3,
                      <br>
                      &nbsp;&nbsp; };
                      <br>
                      &nbsp;&nbsp; +struct amdgpu_pmc_profiler {
                      <br>
                      +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock;
                      <br>
                      +&nbsp;&nbsp;&nbsp; struct drm_file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *owner;
                      <br>
                      +&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable;
                      <br>
                      +};
                      <br>
                      +
                      <br>
                      &nbsp;&nbsp; struct amdgpu_device {
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev;
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev;
                      <br>
                      @@ -818,6 +824,8 @@ struct amdgpu_device {
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xarray userq_doorbell_xa;
                      <br>
                      &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp;
                      pmc_profiler;
                      <br>
                      +
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* df */
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_df&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; df;
                      <br>
                      &nbsp;&nbsp; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      b/drivers/gpu/
                      <br>
                      drm/amd/amdgpu/amdgpu_device.c
                      <br>
                      index c924a55fd16f..74ed42e53264 100644
                      <br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      <br>
                      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                      <br>
                      @@ -3673,6 +3673,7 @@ int
                      amdgpu_device_init(struct amdgpu_device *adev,
                      <br>
mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex);
                      <br>
                      mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex);
                      <br>
                      +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock);
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep classes
                      for ordering validation */
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev);
                      <br>
                      @@ -4244,6 +4245,8 @@ void
                      amdgpu_device_fini_sw(struct amdgpu_device *adev)
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
                      <br>
                      +
                      <br>
                      +&nbsp;&nbsp;&nbsp;
                      mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
                      <br>
                      &nbsp;&nbsp; }
                      <br>
                      &nbsp;&nbsp;&nbsp;&nbsp; /**
                      <br>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Qo91F8ptZGUOm34pJagMHkyY--
