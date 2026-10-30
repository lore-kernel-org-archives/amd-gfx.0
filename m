Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8511606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r2TyDygt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A0A10E8AB;
	Fri, 30 Oct 2026 12:39:45 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B4A10E8AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 12:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlTkL1IUfTF+wGY60kwZOX+x6ZnCvqqZUeBBPZvKIn51I7NhmUigQtIU3t2ptE0OWoHN4g1XJ8AzC9AxMST5KW2VK4sEEpXSnIiQ4d35pXuG9Mra/Bba6IvYJ+hSgC9XPMOF4r6aTLP1B/ktc5l8JhWPYhDnVq4vOR48EoPXKW1ZPwA+c9n5khdwpypxrs1k7bZOXZkPqpZ7XZf+omeeg9dnRe79YlzgUTAaNLRC1xrsKMQPtT/mjsLnbeQhgahEIEFWoCWF7PKoe27EEvpcNxRCEIndeGlGJRcIxm+VN+jgvGFg78KpsbNv2bD7CxFbRs9D+w48ei7U0BSEqas49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VnQmMJUbAMTthn4seKnhL0fGmdB2ouJb/xmY9asCPE=;
 b=fLY/hrws/oqxVf7Fdc3HT3pCvxFx+yMcYji9ms/cJi4+/TcvZwO73a5rxgu7D+8UZ145ECb5hDc2Infz0eR45HxTNbsFnRfoTrAWEfnbZN3AN1ixRCg2WCu3iFrCj3LHyZ72DBnIDnhJ+apmkSY8ix7W+dR0IiqLAP6kCmi4np5+5XKQf1WZ+B7mBObCLuwW57cs5RXGQRxxoZ41+dy6r9k1zA62bDiIzNHct9pQttcsH4W++pUvDafoPILDWsgM3oO6jQ7XvsYMu2S1tbJ9iZAce/fkuxHEpk+EjAExTNz6R3fvcP7ek63mcn2w5ciFZu22GDRotwY8APZn86B8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VnQmMJUbAMTthn4seKnhL0fGmdB2ouJb/xmY9asCPE=;
 b=r2TyDygt2R0bxrGRb0KPFSurHzT2CThXwNlYFxVtYRkj0rNDXDzjIrFxn6P+PzL9yJHNgkGfGqsB9i72g7/Wf83nQhOiB61YBDC6aidhXtwL+xDcaLfgIFtTDxGGTguZsUp+8YfSM2chLbwVJiQfgy6MS2NqcNIqRA5r9VjiYJY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 30 Oct
 2026 12:39:33 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:39:32 +0000
Content-Type: multipart/alternative;
 boundary="------------3aJAkfpc0KfCj5nMfbsIiqk3"
Message-ID: <d30abe5a-b011-4172-9efe-25b89360b9d7@amd.com>
Date: Fri, 30 Oct 2026 08:39:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
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
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <a8d8bd34-d0db-4a06-926b-e6c4f27bb8d8@amd.com>
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dc9e86-868b-4ba3-f277-08df3682d8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|13003099007|261022105027099003|8096899003|261026121527099003|261021121427099003|261009223027099003|4143699003|22082099003|18002099003|261028144727099003|11063799006|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: x9PWbc2TxAIJ19JPsZ1sOd1ehLRX2W7AeYxIjKHnTQIPOqgOBKXiKrIBhET77p5/xFER9ob6TwlU3LfA8nWVxNi7hgC0PyF7uQW4zxJv7NWnsOBUHPohO22IfT7zHtzWqrYfdYC53/2LlwZeylQaqd9An7fazFTy07QxyM2XH0v1m6ztxP7ZitxBEvrUq2MbpjRL4UavB3JWBSEAU4lcIdb3tZTkcbW2M+uwnzo6da8UYiLMfApgRJ/4v+zyPuaoEpal0CTIM3QdNOx0ceSWq1dh/AaKn4nRSqriyalqCQTta2/mYLuIoP7Lks2+EQyyRTliYBvzZuH2rgruFv6zP6YH5IvtCtys1AyiloztY+072K/7a4+1+7Xk/UGwM7Vou/WX4il73aealOoyUz8N9z6qWHNoRRVEdWe7hwpqx6pnGaOZ1Jyuglvm8NmkblkVLMs87Zh0M5y7xKJmn2mnmFlQt34sEGrDVVfaGkRAvim7yD3nDc9kx8CZc/1EcZXb1dyOdAEAE6sp/4Oc6T92yuEzotNjdJqBKP4FFny9uQQhtIB4LgpxF+yeWhTdBxvgGP4Y4cKgpzDkKpy8q6y4OyGRQmJJhpb8Gd5DLS3aVa6Fa91+aoHvWpCK+4TXJVTM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(13003099007)(261022105027099003)(8096899003)(261026121527099003)(261021121427099003)(261009223027099003)(4143699003)(22082099003)(18002099003)(261028144727099003)(11063799006)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDBpam1LT3o4RzFEYVVTWVF4SUx4S0MvOTB0VTZ5OFVHZ0NmSlhyZHlVL2dG?=
 =?utf-8?B?RmhpOUhMekZhM0pPNE5veGxDWlVnNVYxU20zMWFkem5QajhBYzNQTFlIMDFi?=
 =?utf-8?B?eXJqa2RzV20zVm9pUmNML0MwaGthU3FkNTFrY1R2WUYveWFqUTUrakZJQ0ZF?=
 =?utf-8?B?T09EZU9yRjJIejNPVTI3SkI5OEptTCtNb2I1SlhVV0ljZFdrZHNqL2hueUZi?=
 =?utf-8?B?ays4ODlaTVgwazJSNlBsUnhWeENmUTZHMnN2bzBHQjU2OGZoRTN3RGZvMHFP?=
 =?utf-8?B?V3J3a0FtYmt2cEJDL1d3Wk9tT2pFYUJsQUFNNmV1ZjRXRlFPc0U1NCs2dUo5?=
 =?utf-8?B?ZVlTY20xQ1BJZGhlVlpwejVZeGt0NHA5Mjc5ZzRKczlwZktZNlRrMTJwM3lr?=
 =?utf-8?B?NlQzcFUzRXJ6ZXNNWklMWGk0bTNKNy84RTNleGxvQ1p3VmlhaC85NldMVVor?=
 =?utf-8?B?WTc2VzVyQ0xHb2lzWVJLSEpTWTY1L21Fc0J4SlpNOU1GdnBjYnBwSUtlaFhR?=
 =?utf-8?B?elVDbG9QVENkV05Rd1RBRGZ3TURLZFdERkl0K0lVM0RSQjFWdEZKSXRjVGZ6?=
 =?utf-8?B?aUk5bDBqeVFkU0hISnlwS0ZITlB6OTh4NDQ3SngwNVBkNFV4dU9FRG5QUDl0?=
 =?utf-8?B?QlBaUy9LRXFKamRLb0hzalBZSFlaaWVKMTRjeGJRMmsxc00wbTdMcUdrcG5H?=
 =?utf-8?B?dnZZRmFhcXpQajc1bHNyRzdEYmNyUUNvSkQwR1BMOFNjc0RtVDFUZmxlbHE0?=
 =?utf-8?B?ZFIyN2RyY1hyQ0JXSjFsZ2crUGV6aVdBQlFYRFpWWm1lTmUwdXFyRlkzNmxi?=
 =?utf-8?B?bmFxRlludGs5K1RSWTMva25sTUZFVzBNOVlWdkdmYlRMeXIxUXRVMlVXdGVU?=
 =?utf-8?B?NjVhMlR4ZW1TaHBMYk1hUjh2MzdTdFFOK3RKRmlzQkpnRjFsSkFjbHdpN05W?=
 =?utf-8?B?RkJacXR2TjBEZVZSZWtXUFZDQkYxcTNURkswTzhZa3JlbWt3bExMMzl1cGFh?=
 =?utf-8?B?dVFCQ3Y3YUp1TENGM3Z5RjJ4NnBqTXJMTE03YllEZHZvSXhvajQ0SzROcXZE?=
 =?utf-8?B?SDRjZnhhYkU0a3NiL0lId1ppL3pUdWdOTXMyMml1U1ZLam1GVkNwVVVBT3Fa?=
 =?utf-8?B?SlFNKzZuYVpNL3krK0NLSk92MFBUWW9Eb3I0ck9PMkROcFJ2cVVBeWtWL2c0?=
 =?utf-8?B?RWsxcEdaQ0JWV0R2UFhnUUlmdklwRE5XM2dLSStQd1RJOWdTVDlqVlQvMVFR?=
 =?utf-8?B?WStRZWJ4QysrUDVMb0k3TS9RYjV3M3RkT29YVGl1ZUIwc3V4RVB2SHJ5RmdS?=
 =?utf-8?B?V2R4NnlmLzM3d1JiME9QNUdpMGlRcnZKdkdEdllmZE5HdGtjb04zY21uUm8v?=
 =?utf-8?B?TUZRMHlabjZEcTJkeVRZVWVhQ2lrQmIrYjI3aU41ZjNXd0hVUnlXVElrRnpN?=
 =?utf-8?B?czFoeHRaVStaTFZEeDc3L3dpYm5FUng3Wm1iR0FqUW9oSjk4VmFVRTNJbzlM?=
 =?utf-8?B?WmE4WXhHMnYzNEczVjVpU3diSXA5UDBMVS9pSHMzRm5HRmF5TTNyUHI1U1FN?=
 =?utf-8?B?RTdxNHpDQmRXeWVFQnNjMUswMnE3ZmlGLzdJVDBnTWp1ZllxWmpTRkZxd3Bq?=
 =?utf-8?B?L004N1hodGFKRmpiVSsxeXhxMnBYTFdMYmgwMmwyaThhZEw2My9qV051cURt?=
 =?utf-8?B?VDZOcEhJM0U4SzBKVGt1ckFpN0RtZWc1QkZrbkJJa0QvNERpUWI5SlIvblRZ?=
 =?utf-8?B?K2IxeGozajlJa0ZtL0RFVi9TZTl2L0NDMkVzc3JROFl3ZVNocnFMQzNURzJM?=
 =?utf-8?B?L1FhU2p1WDNVYURYRGE4VTVSOW92d0xsaXkwMHRmN205TU52Ykd3YVVQRTZ2?=
 =?utf-8?B?NnhCM2Z6Z25sVnZEaTRabnZ0L3BJUkc3RG50Nzg1b1laOWtTRExTaVFlMU16?=
 =?utf-8?B?TS9aS0RZMFBJV096d0Q1ZXhkYjJPdDdRWXhjU0JVenMvNlNuTVNtZ29rWVNl?=
 =?utf-8?B?WStVWUllSWgzSXU2bzBUL1Z4TzcyRWJ3NFVwWHUvSHh0dWhuSU9MM1EyOU96?=
 =?utf-8?B?VUsreHB6bW94NWQ5djRqVmFvaTJwVEhtRHlnUjdta1NpQzlCMlJBcmU1Wnk1?=
 =?utf-8?B?WC92d29hOGdYTFRBdHZZUDRDT3pjaVVENmswOXJBNHkyeWtVVVhmOW43ZVBs?=
 =?utf-8?B?a0l2TlFBZlRRQUJWV0s2djN0dHJES21vb0gwa3puaS81TWtuY0FtdEgvYUJX?=
 =?utf-8?B?dWFsS2o4bXd2M1ZYdmRMaTZ6VG55clZWdlBURjd5ZVRwbUIzZGtBWDVoNzg3?=
 =?utf-8?Q?vTfjHG6XdTDWGpdxq0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dc9e86-868b-4ba3-f277-08df3682d8ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:39:32.5409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2IWHI84kkg4OvOEWWfVSZzR8NiTZNtGa8+T8AQcoE/UJSBQG/nRt7+cB/OZH7ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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

--------------3aJAkfpc0KfCj5nMfbsIiqk3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-30 02:10, Zhu, Lingshan wrote:
> On 10/29/2026 9:37 PM, James Zhu wrote:
>>
>> On 2026-10-28 23:13, Zhu, Lingshan wrote:
>>> On 10/28/2026 8:53 PM, Zhu, James wrote:
>>>> AMD General
>>>>
>>>> Hi, Lingshan,
>>>>
>>>> Sorry to reply later! Just be back from vacation.
>>>>
>>>> Yes, there is only one set of PMC registers on the device.
>>>> But the minimum control scope is XCC. So, I think we should design 
>>>> PMC based on
>>>> Node instead of device. We need not enable the PMC on XCCs which 
>>>> have no PMC
>>>> data collection request.
>>>> Since the request is based on render node.
>>> They are per-device registers, so the scope should be the device, 
>>> not XCC.
>> [JZ] where did you get this information? From what I know, Compute / 
>> Shader PMCs / RLC & SPM Control / //  /  / / PC Sampling are all XCC 
>> based.  a are all  are
> For GFX11/12, the instance number of XCC is 0, therefore their xcc_mask is 1, so the registers are per-device.
> You can read these information from sysfs and debugfs.
>
> Please also take a look at KFD implementation athttps://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html
>
> It says: multiple PMC profilers on the same device can result in corrupted counter data

[JZ] IIUC, the corruption data is with multiple processes enabled on 
same xcc. We still can have lock design to avoid multiple processes 
running on same node(same XCCs). we can run one PMC profiler on node1 
only and leave other nodes on the same device have its own one only PMC 
profilers process running without affecting each other,.

>>>
>>> Another reason is, I assume we don't want one user to sniff another 
>>> through PMC.
>> [JZ] if it is true, is it more easy to sniffer  for per device 
>> design. the other nodes within the same device will enable PMC 
>> unexpectedly.
> so we have implemented reservation/locking for PMC.
>
> Thanks
> Lingshan
>>>
>>> Thanks
>>> Lingshan
>>>> Thanks & Best Regards!
>>>>
>>>> James Zhu
>>>>
>>>> -------------------------------------------------------------------------------- 
>>>>
>>>> *From:* Zhu, Lingshan<Lingshan.Zhu@amd.com>
>>>> *Sent:* Thursday, October 8, 2026 3:50 AM
>>>> *To:* Zhu, James<James.Zhu@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix<Felix.Kuehling@amd.com>
>>>> *Cc:* Huang, Ray<Ray.Huang@amd.com>;amd-gfx@lists.freedesktop.org 
>>>> <amd- gfx@lists.freedesktop.org>
>>>> *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
>>>>
>>>> On 9/24/2026 11:40 PM, James Zhu wrote:
>>>>
>>>>> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>>>>>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>>>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>>>>>> This commit implements a device-wide PMC config
>>>>>>>> for amdgpu, which including the profiling owner,
>>>>>>>> and the profiling enablement indicator.
>>>>>>> [JZ] I think it should be render-node wide, not device-wide
>>>>>> Hi James,
>>>>>>
>>>>>> It could be, but we don't have a requirement document defines the 
>>>>>> scope.
>>>>>>
>>>>>> But normally a profiler is a device scope,
>>>>>> I see KFD profiler operates on all queues under the device queue 
>>>>>> manager
>>>>> [JZ] One device could be split into multiple nodes with different 
>>>>> processes
>>>>> running.
>>>>>
>>>>> I am wondering if this is really we want.  Ben may comment on it.
>>>> Hello James,
>>>>
>>>> Sorry for the late reply, it was mid-autumn festival and national 
>>>> holidays.
>>>>
>>>> In my understanding, there is only one set of PMC registers on the 
>>>> device, so it should
>>>> be device scope.
>>>>
>>>> Thanks
>>>> Lingshan
>>>>
>>>>>> Thanks
>>>>>> Lingshan
>>>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com> 
>>>>>>>> <mailto:lingshan.zhu@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>>>>    2 files changed, 11 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>> b/drivers/gpu/drm/amd/
>>>>>>>> amdgpu/amdgpu.h
>>>>>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>>>>>        AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>>>>>    };
>>>>>>>>    +struct amdgpu_pmc_profiler {
>>>>>>>> +    struct mutex        lock;
>>>>>>>> +    struct drm_file        *owner;
>>>>>>>> +    bool            enable;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>    struct amdgpu_device {
>>>>>>>>        struct device            *dev;
>>>>>>>>        struct pci_dev            *pdev;
>>>>>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>>>>>         */
>>>>>>>>        struct xarray userq_doorbell_xa;
>>>>>>>>    +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>>>>>> +
>>>>>>>>        /* df */
>>>>>>>>        struct amdgpu_df                df;
>>>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/
>>>>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index c924a55fd16f..74ed42e53264 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>> mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>        mutex_init(&adev->benchmark_mutex);
>>>>>>>> mutex_init(&adev->gfx.reset_sem_mutex);
>>>>>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>>>>>          /* Associate locks with lockdep classes for ordering 
>>>>>>>> validation */
>>>>>>>>        amdgpu_lockdep_set_class(adev);
>>>>>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>        kfree(adev->pci_state);
>>>>>>>>        kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>>>>>        kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>>>>>> +
>>>>>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>>>>>    }
>>>>>>>>      /**
--------------3aJAkfpc0KfCj5nMfbsIiqk3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-30 02:10, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a8d8bd34-d0db-4a06-926b-e6c4f27bb8d8@amd.com">
      
      <pre class="moz-cite-prefix">On 10/29/2026 9:37 PM, James Zhu wrote:
</pre>
      <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com"> <br>
        On 2026-10-28 23:13, Zhu, Lingshan wrote: <br>
        <blockquote type="cite">On 10/28/2026 8:53 PM, Zhu, James wrote:
          <br>
          <blockquote type="cite">AMD General <br>
            <br>
            Hi, Lingshan, <br>
            <br>
            Sorry to reply later! Just be back from vacation. <br>
            <br>
            Yes, there is only one set of PMC registers on the device. <br>
            But the minimum control scope is XCC. So, I think we should
            design PMC based on <br>
            Node instead of device. We need not enable the PMC on XCCs
            which have no PMC <br>
            data collection request. <br>
            Since the request is based on render node. <br>
          </blockquote>
          They are per-device registers, so the scope should be the
          device, not XCC. <br>
        </blockquote>
        [JZ] where did you get this information? From what I know,
        Compute / Shader PMCs / RLC &amp; SPM Control&nbsp;/ //&nbsp; /&nbsp; / / PC
        Sampling are all XCC based. &nbsp;a are all&nbsp; are <br>
      </blockquote>
      <pre>For GFX11/12, the instance number of XCC is 0, therefore their xcc_mask is 1, so the registers are per-device.
You can read these information from sysfs and debugfs.

Please also take a look at KFD implementation at <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html" moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html</a>

It says: multiple PMC profilers on the same device can result in corrupted counter data</pre>
    </blockquote>
    <p>[JZ] IIUC, the corruption data is with multiple processes enabled
      on same xcc. We still can have lock design to avoid multiple
      processes running on same node(same XCCs). we can run one PMC
      profiler on node1 only and leave other nodes on the same device
      have its own one only PMC profilers process running without
      affecting each other,.</p>
    <blockquote type="cite" cite="mid:a8d8bd34-d0db-4a06-926b-e6c4f27bb8d8@amd.com">
      <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com">
        <blockquote type="cite"> <br>
          Another reason is, I assume we don't want one user to sniff
          another through PMC. <br>
        </blockquote>
        [JZ] if it is true, is it more easy to sniffer&nbsp; for per device
        design. the other nodes within the same device will enable PMC
        unexpectedly. <br>
      </blockquote>
      <pre>so we have implemented reservation/locking for PMC.

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com">
        <blockquote type="cite"> <br>
          Thanks <br>
          Lingshan <br>
          <blockquote type="cite">Thanks &amp; Best Regards! <br>
            <br>
            James Zhu <br>
            <br>
--------------------------------------------------------------------------------
            <br>
            *From:* Zhu, Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
            <br>
            *Sent:* Thursday, October 8, 2026 3:50 AM <br>
            *To:* Zhu, James<a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a>;
            Deucher, Alexander <br>
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
            Kuehling, Felix<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
            <br>
            *Cc:* Huang, Ray<a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">&lt;Ray.Huang@amd.com&gt;</a>;amd-gfx@lists.freedesktop.org
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-
              gfx@lists.freedesktop.org&gt;</a> <br>
            *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC
            config <br>
            <br>
            On 9/24/2026 11:40 PM, James Zhu wrote: <br>
            <br>
            <blockquote type="cite">On 2026-09-23 23:23, Zhu, Lingshan
              wrote: <br>
              <blockquote type="cite">On 9/23/2026 10:13 PM, James Zhu
                wrote: <br>
                <blockquote type="cite">On 2026-09-22 05:34, Zhu
                  Lingshan wrote: <br>
                  <blockquote type="cite">This commit implements a
                    device-wide PMC config <br>
                    for amdgpu, which including the profiling owner, <br>
                    and the profiling enablement indicator. <br>
                  </blockquote>
                  [JZ] I think it should be render-node wide, not
                  device-wide <br>
                </blockquote>
                Hi James, <br>
                <br>
                It could be, but we don't have a requirement document
                defines the scope. <br>
                <br>
                But normally a profiler is a device scope, <br>
                I see KFD profiler operates on all queues under the
                device queue manager <br>
              </blockquote>
              [JZ] One device could be split into multiple nodes with
              different processes <br>
              running. <br>
              <br>
              I am wondering if this is really we want.&nbsp; Ben may comment
              on it. <br>
            </blockquote>
            Hello James, <br>
            <br>
            Sorry for the late reply, it was mid-autumn festival and
            national holidays. <br>
            <br>
            In my understanding, there is only one set of PMC registers
            on the device, so it should <br>
            be device scope. <br>
            <br>
            Thanks <br>
            Lingshan <br>
            <br>
            <blockquote type="cite">
              <blockquote type="cite">Thanks <br>
                Lingshan <br>
                <blockquote type="cite">
                  <blockquote type="cite">Signed-off-by: Zhu Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
                    <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;mailto:lingshan.zhu@amd.com&gt;</a>
                    <br>
                    --- <br>
                    &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 8
                    ++++++++ <br>
                    &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3
                    +++ <br>
                    &nbsp;&nbsp; 2 files changed, 11 insertions(+) <br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                    b/drivers/gpu/drm/amd/ <br>
                    amdgpu/amdgpu.h <br>
                    index 8eff6b9ebe81..45897dca802f 100644 <br>
                    --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
                    @@ -620,6 +620,12 @@ enum
                    amdgpu_enforce_isolation_mode { <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =
                    3, <br>
                    &nbsp;&nbsp; }; <br>
                    &nbsp;&nbsp; +struct amdgpu_pmc_profiler { <br>
                    +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock; <br>
                    +&nbsp;&nbsp;&nbsp; struct drm_file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *owner; <br>
                    +&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable; <br>
                    +}; <br>
                    + <br>
                    &nbsp;&nbsp; struct amdgpu_device { <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev; <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pdev; <br>
                    @@ -818,6 +824,8 @@ struct amdgpu_device { <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xarray userq_doorbell_xa; <br>
                    &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp; pmc_profiler;
                    <br>
                    + <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* df */ <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_df&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; df; <br>
                    &nbsp;&nbsp; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                    b/drivers/gpu/ <br>
                    drm/amd/amdgpu/amdgpu_device.c <br>
                    index c924a55fd16f..74ed42e53264 100644 <br>
                    --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
                    @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
                    amdgpu_device *adev, <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex); <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex); <br>
                    +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock); <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep classes for
                    ordering validation */ <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev); <br>
                    @@ -4244,6 +4245,8 @@ void
                    amdgpu_device_fini_sw(struct amdgpu_device *adev) <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state); <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
                    <br>
                    + <br>
                    +&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
                    <br>
                    &nbsp;&nbsp; } <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; /** <br>
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

--------------3aJAkfpc0KfCj5nMfbsIiqk3--
