Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16F606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4mBXz5dM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C5510E81A;
	Fri, 30 Oct 2026 06:10:44 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD85C10E81A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stfOqR9dYLr0CX28doqK0WoRuc1MvNI257xP3HIEStxAOWyX/fIagRds+ZFYM7UR2dzG1q68IzjANTb3i4JiWKN1LUwOcJbTr6al3F5lgwRRYGtrsZNs3gofUC3d/R9U+Zx4JNeYtkcuUNg7VGxyPe2GFMOTeYnK2C5hdrH8wgktVHtL7ETlhz//i/pxPo2RX9dnvdLmn4z0axZnM50FDmeI4e9EiVwcLBKmKvDmnROdmrupcecGiMXeVh1MrT4K3XRkmu9/dxZgEgu88kurREEWI6BRBV14/uTLcgyz59/+lJA5F8f9VkRUiuZHtYsKrcbc1WHkYvCFp/b4fZtjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50HPnoBzy/oiCzju+nKIE26ZxTx/VMjeFn3vlBYIc14=;
 b=ZCpndC2Qws1XyzGbADCl7hOlpUKlK85IBBecX3ximQh6tOPALbBkSpD6zv8vo5/DTF9yrmtvrWXd9Sz7xxjuF1hbS5Ubkuc1I4JuGfzT8pwwkUgo6RRqdNDjBCotrbOJqyQJ9a8c9DOYNZO5GK6LtWOI9Q+NIjcJrt0FDYd+QFjUreArVIyqL9/IqMjmao+ng3boLrJt0QT1d2SwBcTBA+JacRkh4+fm34uqlxRrtiYmN8CoPt7FH+a5wjLy/xrp675mwtwLp/6/ipVDAiycjsuTbKZxyeMDwUQk7MSyeVjl5qatTMPfJXIO6tBPGc9bEaftfXGHh7ZFgYUuNZqJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50HPnoBzy/oiCzju+nKIE26ZxTx/VMjeFn3vlBYIc14=;
 b=4mBXz5dMuoRavKqrOUnmL/t9k+tLcWoLNtGOTGWzpBKKF/PDeupWJM6rQBFNUAbP0A0FuO2iAA58rGKSgy/RCAqGn+Ms82OtX4oVfe19yu/+hGlt7D/nPoOJiCcxblLDpk95KwZSRSsku7yFvr1dRmZg0gN1fBBn/yhyVXot0E0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:10:34 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 06:10:33 +0000
Content-Type: multipart/alternative;
 boundary="------------hhns7jLoM6YRxnm7l2rzZBET"
Message-ID: <a8d8bd34-d0db-4a06-926b-e6c4f27bb8d8@amd.com>
Date: Fri, 30 Oct 2026 14:10:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
To: James Zhu <jamesz@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
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
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com>
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f471d-3f98-4acd-7613-08df364c8200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|13003099007|18002099003|22082099003|56012099006|4143699003|11063799006|8096899003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: cb3J6vWlBlTYJGENrEhpY/ILhd1TRH1k/O7DgcgY4n5/0hs/b/It2asaP5XF1E8CtdVeIl2iABNU6SQipP59UkXBNTVcu0MEe+opcekJm4dl28IRQgul7MimCiB4j0aFVzWcBVZDFzO+lldiuJaVGkhmkFwLmpXKbbYk3nQtddatgUPUJSSe0jN8f+n+4ROUnvtpofrvVAl0XkrfV5csys5ZMeyEzAnQDdO2+e79P5eKt0lZAiIcHbnAw5i/qk1jTnyPrmGtJQ/5g6WYS6FM5fv7uDq5W/1a4liqnQk3hIz/JF9D2JI9BCv/87kxHzpFMyPI1fwphT+z0Y6nEEdm6OVyr566XOk4yJMZrUytPA/kR+ySLPvRz90a58DuIXyU3+s3IZSDohv5BO4i28XEfu/m1KGWC5LZB8SZ/0Ui8COJk7inVH+XI4S0FrAJGhA6soEkIq1h9A1V+znW28OlCU+IxZBsFI/Jb/cGfSeCIIlaG7wtJRa5igw2LrRkjFbTfemDccOcRz6bfrS1MyeGBy9Q4MwnUWtcchI9s62Kue5hTDizt2Hvzw5IgIZklGIOkJj1KsxH2cHJB+fsEuCR0Kf84Md6SWf2rWxUwfBCbh8Juxa6jHlgxPdWdiCWs6ZN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(13003099007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(8096899003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUg4MjRyR2hka29YR05hWkVFVzh0N3V3a1A5VkRzaC85dVU4clVYZ2xJdC9C?=
 =?utf-8?B?Z1orUFVxMVErcHlaMFhHUTRiaU53b0ZWN1pWeFRqbEZtMnIvLzY4TmpHOXVX?=
 =?utf-8?B?THpSSWtJSFlqb0hkOGRzbHVlbDZBTUhldzlCZGRlSk5tbGxtZzFIOEU0N2pp?=
 =?utf-8?B?NS82NWl0WVowUEFMeU5BWjZiK2g4bmVNb214Q3MvM0ZEYUF6MlpxRGRhTmdr?=
 =?utf-8?B?cklqbzBKMEVnRHl2ekE3Qzl6M0tlZ3JYYXVVMmdZTENMVjBhbEE5YjAwWCti?=
 =?utf-8?B?cXdDRVFJUDJSdmN3aTBvV21kWEhXcFJHNmF3Y0dqN2xwN1loNTJqazVQUFZn?=
 =?utf-8?B?SXIvSG1QZDZFbDYwUHVvNVl4MlZpRDlQMWZSU2VxdjIxSnVPN3RKc0cvd2Yr?=
 =?utf-8?B?OXhwakNWcXJoK3ZGcCtRRXhoRVJKbzltcEUzSmFuVW5UM3dhZGI3eWdQYzdj?=
 =?utf-8?B?bWYwVEJFM2l1elBoNTJMdVFSSXljcTdraHV4ZXFNb2xWZ1dDY09EWXl4dFpW?=
 =?utf-8?B?ekJwOTRJNW92L2N4RmJiQ2c3Rlk1SE1iV3Z1aXJUWVhoNWUxQlE4eFQ3akxM?=
 =?utf-8?B?VnpCeHJXWlRSLzB3SGwxcFBYaW53NER0aGk4UWZnaGJpWnJNdC9nZXZQWENt?=
 =?utf-8?B?clphMTNnQjkrTGhQV0plaHBTN0dweFBtTTNtb0dmRWtXdEF5MWRZWjZYWDNC?=
 =?utf-8?B?YWkwb1pmcUxSL3p4TklueGc0NTEwL2dyWTdrMWp4UHNHTHZaTmpsa1UwQ3RS?=
 =?utf-8?B?LytaNkpFTDR5S3JuVTJsUER4czJpN094OWRvdWdaQVova21COTZPNUlBZkdh?=
 =?utf-8?B?RndScitKWTZvKzk1STBjWU1FSzc1UHlYcnJaZXphd3IwTHNYdEdLS0ExdkQr?=
 =?utf-8?B?aTg5NEpyalJteVNXa3dFUlc1eGpDSkNoU3Z5b1FaMFZhYzRRRUJET1B1NTBi?=
 =?utf-8?B?VnU1YUJYdWxCSmxvV1I1R2Rvc1VCMGUyWHFicnhhNWFMZXFvVVhZd3BlUFVK?=
 =?utf-8?B?eTYzZk5BOGNyZklMR2N0MnRDeGd6bEFERVU1T0FNYWxQTGs3SysyWEJCRGNl?=
 =?utf-8?B?TERTRy9MTzhrSE9qOEdkZ2h2QmJ6TzN2WUxtRkdFYmFxNjQ5YUV1VURaRDYv?=
 =?utf-8?B?UWttNlBHdDRFeE42K0o5TVZpVkk3R1BkTWN6SFBDUC9zc1BpTHc0bGl5UkJm?=
 =?utf-8?B?MHVTYlhNQjBwT0gyQXV1QzVvT09XY0l0cnNhVWF4WklaQXFFdjBaWWZRNzR1?=
 =?utf-8?B?UmNYL0hMdmNlamxXME5kb1pjamlWbkRpdXZWQnJFSG56VzlpS1N1aFdBWWJU?=
 =?utf-8?B?Y1htTTFqb1ZhcFFNdDFMTmVHSEtqTlRydjkrKzAvMitnMjBJSENYbDdOV2sv?=
 =?utf-8?B?cDZDaUhPNDVQeWRMWWsxekp0N1VRVktvazFFb1lrbnhtK2VRYko0R0RmbDI4?=
 =?utf-8?B?Y1ZpUkE2VEFZM1JwUVBkS0xkSzBVR2Q0R3p6bDlzcmxWbCswUnJSbzh4M2dH?=
 =?utf-8?B?OWtTZlFlaFcvUmJHSHZkTlV5QnpYUm8zbW1VWmVnQlhEWVRwN0gwNTFKSDZN?=
 =?utf-8?B?V1BEa1BySlh5UEtMNFM1RjNaOGVvQ0NLOUI1Nmp4VmVsVUNaNTcxeUcrN0Er?=
 =?utf-8?B?ODZyWHRpMXVMU2hXNnJjZ05SMXoycXZrUURoN2VyN2VYUEtzanBmNnV6czlD?=
 =?utf-8?B?TEJMZW1kRks4cTI1by8xemRNZWhhdlNuTjh4RXRESk5lU3hMd2d5aUEyYVlz?=
 =?utf-8?B?bjh6em41VkRSTGNIeDdpUzQxaFF1bHdwMmdxa0hOMDlsYTJOay9YSWhLL2ZC?=
 =?utf-8?B?eXBJQ3NOY0Z6dHJhSmhERlpRSW1GYzV4M2hZT2hLV25tSFlRNTg1Q2toU3Vu?=
 =?utf-8?B?eFkzVmRhR3Q5MHFrTXUyU1lXNFJBaVNDc2JiOWpLSjB4bG9ZZ1Rhb0NZY3U1?=
 =?utf-8?B?SWUrWS9GM2xIS2k5MTVYekJhSHp5RkFQUTJZcFd6c3psUDRmRGF4dXk1Zlp6?=
 =?utf-8?B?S0QzQ1VoVklER2xNTU9oU1dqOFlUM1BoWWNMTzY1dmRHMVdJcmp1UHB3TFBM?=
 =?utf-8?B?VkJ1OFZOSlEvODF0M05OVGp4bVpOdDFsb0dLNk5KNFZ1QjBhTkJseWplUnVH?=
 =?utf-8?B?ak85TjBwTFR1OFJpRDh0djFsVXpiWWd2YVVDcFZNQjlvakpuOXdNR09zVFBS?=
 =?utf-8?B?d2Vtdk95NXZPU2hiNzBSQ0RNZ2RrZGF4YTBFQlpyRnFaNk9tT1dxaDlTY2pN?=
 =?utf-8?B?N21pcXlGQUpxM1NhcmlBNDFybHFSK003b1d5UllhRWFqMGFnbHBiTldBWkRV?=
 =?utf-8?B?dUFvOXVQWm9STk1HZ0NhU1kzb253NVkzUFlGQ1J6TnhMYk9WM3ZmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f471d-3f98-4acd-7613-08df364c8200
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:10:33.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZmnS5MhT8X+z6+1YaviUQK0ngWKX2fRduCP5A4p0Qbwbk0wGQbA3KDEU/04uObImlKpaXLI/A8etOtUMFsEGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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

--------------hhns7jLoM6YRxnm7l2rzZBET
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/2026 9:37 PM, James Zhu wrote:

>
> On 2026-10-28 23:13, Zhu, Lingshan wrote:
>> On 10/28/2026 8:53 PM, Zhu, James wrote:
>>> AMD General
>>>
>>> Hi, Lingshan,
>>>
>>> Sorry to reply later! Just be back from vacation.
>>>
>>> Yes, there is only one set of PMC registers on the device.
>>> But the minimum control scope is XCC. So, I think we should design
>>> PMC based on
>>> Node instead of device. We need not enable the PMC on XCCs which
>>> have no PMC
>>> data collection request.
>>> Since the request is based on render node.
>> They are per-device registers, so the scope should be the device, not
>> XCC.
> [JZ] where did you get this information? From what I know, Compute /
> Shader PMCs / RLC & SPM Control / //  /  / / PC Sampling are all XCC
> based.  a are all  are

For GFX11/12, the instance number of XCC is 0, therefore their xcc_mask is 1, so the registers are per-device.
You can read these information from sysfs and debugfs.

Please also take a look at KFD implementation at https://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html

It says: multiple PMC profilers on the same device can result in corrupted counter data

>>
>> Another reason is, I assume we don't want one user to sniff another
>> through PMC.
> [JZ] if it is true, is it more easy to sniffer  for per device design.
> the other nodes within the same device will enable PMC unexpectedly.

so we have implemented reservation/locking for PMC.

Thanks
Lingshan

>>
>> Thanks
>> Lingshan
>>> Thanks & Best Regards!
>>>
>>> James Zhu
>>>
>>> --------------------------------------------------------------------------------
>>>
>>> *From:* Zhu, Lingshan<Lingshan.Zhu@amd.com>
>>> *Sent:* Thursday, October 8, 2026 3:50 AM
>>> *To:* Zhu, James<James.Zhu@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Kuehling, Felix<Felix.Kuehling@amd.com>
>>> *Cc:* Huang, Ray<Ray.Huang@amd.com>;amd-gfx@lists.freedesktop.org
>>> <amd- gfx@lists.freedesktop.org>
>>> *Subject:* Re: [RFC 02/10] drm/amdgpu: add device-wide PMC config
>>>
>>> On 9/24/2026 11:40 PM, James Zhu wrote:
>>>
>>>> On 2026-09-23 23:23, Zhu, Lingshan wrote:
>>>>> On 9/23/2026 10:13 PM, James Zhu wrote:
>>>>>> On 2026-09-22 05:34, Zhu Lingshan wrote:
>>>>>>> This commit implements a device-wide PMC config
>>>>>>> for amdgpu, which including the profiling owner,
>>>>>>> and the profiling enablement indicator.
>>>>>> [JZ] I think it should be render-node wide, not device-wide
>>>>> Hi James,
>>>>>
>>>>> It could be, but we don't have a requirement document defines the
>>>>> scope.
>>>>>
>>>>> But normally a profiler is a device scope,
>>>>> I see KFD profiler operates on all queues under the device queue
>>>>> manager
>>>> [JZ] One device could be split into multiple nodes with different
>>>> processes
>>>> running.
>>>>
>>>> I am wondering if this is really we want.  Ben may comment on it.
>>> Hello James,
>>>
>>> Sorry for the late reply, it was mid-autumn festival and national
>>> holidays.
>>>
>>> In my understanding, there is only one set of PMC registers on the
>>> device, so it should
>>> be device scope.
>>>
>>> Thanks
>>> Lingshan
>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>>>>>>> <mailto:lingshan.zhu@amd.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>>>>>    2 files changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> b/drivers/gpu/drm/amd/
>>>>>>> amdgpu/amdgpu.h
>>>>>>> index 8eff6b9ebe81..45897dca802f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> @@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
>>>>>>>        AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>>>>>>>    };
>>>>>>>    +struct amdgpu_pmc_profiler {
>>>>>>> +    struct mutex        lock;
>>>>>>> +    struct drm_file        *owner;
>>>>>>> +    bool            enable;
>>>>>>> +};
>>>>>>> +
>>>>>>>    struct amdgpu_device {
>>>>>>>        struct device            *dev;
>>>>>>>        struct pci_dev            *pdev;
>>>>>>> @@ -818,6 +824,8 @@ struct amdgpu_device {
>>>>>>>         */
>>>>>>>        struct xarray userq_doorbell_xa;
>>>>>>>    +    struct amdgpu_pmc_profiler    pmc_profiler;
>>>>>>> +
>>>>>>>        /* df */
>>>>>>>        struct amdgpu_df                df;
>>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/
>>>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index c924a55fd16f..74ed42e53264 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>        mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>        mutex_init(&adev->benchmark_mutex);
>>>>>>>        mutex_init(&adev->gfx.reset_sem_mutex);
>>>>>>> +    mutex_init(&adev->pmc_profiler.lock);
>>>>>>>          /* Associate locks with lockdep classes for ordering
>>>>>>> validation */
>>>>>>>        amdgpu_lockdep_set_class(adev);
>>>>>>> @@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct
>>>>>>> amdgpu_device *adev)
>>>>>>>        kfree(adev->pci_state);
>>>>>>>        kfree(adev->pcie_reset_ctx.swds_pcistate);
>>>>>>>        kfree(adev->pcie_reset_ctx.swus_pcistate);
>>>>>>> +
>>>>>>> +    mutex_destroy(&adev->pmc_profiler.lock);
>>>>>>>    }
>>>>>>>      /**
--------------hhns7jLoM6YRxnm7l2rzZBET
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre class="moz-cite-prefix">On 10/29/2026 9:37 PM, James Zhu wrote:
</pre>
    <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com">
      <br>
      On 2026-10-28 23:13, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">On 10/28/2026 8:53 PM, Zhu, James wrote:
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
          But the minimum control scope is XCC. So, I think we should
          design PMC based on
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
      [JZ] where did you get this information? From what I know, Compute
      / Shader PMCs / RLC &amp; SPM Control&nbsp;/ //&nbsp; /&nbsp; / / PC Sampling are
      all XCC based. &nbsp;a are all&nbsp; are
      <br>
    </blockquote>
    <pre>For GFX11/12, the instance number of XCC is 0, therefore their xcc_mask is 1, so the registers are per-device.
You can read these information from sysfs and debugfs.

Please also take a look at KFD implementation at <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html">https://lists.freedesktop.org/archives/amd-gfx/2026-February/138408.html</a>

It says: multiple PMC profilers on the same device can result in corrupted counter data</pre>
    <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com">
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
    <pre>so we have implemented reservation/locking for PMC.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:2a1a10f7-6a49-435f-abb2-0894ff804acd@amd.com">
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
          *To:* Zhu, James<a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>; Deucher, Alexander
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
              <blockquote type="cite">On 2026-09-22 05:34, Zhu Lingshan
                wrote:
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
              I see KFD profiler operates on all queues under the device
              queue manager
              <br>
            </blockquote>
            [JZ] One device could be split into multiple nodes with
            different processes
            <br>
            running.
            <br>
            <br>
            I am wondering if this is really we want.&nbsp; Ben may comment
            on it.
            <br>
          </blockquote>
          Hello James,
          <br>
          <br>
          Sorry for the late reply, it was mid-autumn festival and
          national holidays.
          <br>
          <br>
          In my understanding, there is only one set of PMC registers on
          the device, so it should
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
                  &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
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
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
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
                  &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; struct amdgpu_pmc_profiler&nbsp;&nbsp;&nbsp; pmc_profiler;
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
                  @@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct
                  amdgpu_device *adev,
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  mutex_init(&amp;adev-&gt;pm.stable_pstate_ctx_lock);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;benchmark_mutex);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;gfx.reset_sem_mutex);
                  <br>
                  +&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;pmc_profiler.lock);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Associate locks with lockdep classes for
                  ordering validation */
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_lockdep_set_class(adev);
                  <br>
                  @@ -4244,6 +4245,8 @@ void
                  amdgpu_device_fini_sw(struct amdgpu_device *adev)
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pcistate);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pcistate);
                  <br>
                  +
                  <br>
                  +&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&gt;pmc_profiler.lock);
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
  </body>
</html>

--------------hhns7jLoM6YRxnm7l2rzZBET--
