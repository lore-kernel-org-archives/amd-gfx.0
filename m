Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2E7C369D8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 11:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4166F10E3D7;
	Mon, 28 Apr 2025 11:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lz/HoA48";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA46E10E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 11:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJZBJtv7lP7qiJNc9kBXVtwxeE/9lwOSt9rlPR/DKWC9MkmfaOn/30RUHzCMaZYPATicPQuEzf4M08GmqzGxKjzptgJVQwyzbIolU+SEeiKmBMj+gNgN8bjm4J2y6p58jLLhpbgjgQYmPdfhnRkSH//y4594rAj83yh4SnYXpA0dNEBGsx2GCwTwr+81YiptGr84yF3lan0X9MsyCA+FK0fF/ibLyQR3gq6Q8fUJBDAM384Ra5t8jlPNpFljbJTwYSvs8Cl1t9/I7ursKbNdqjlxTN63MVCvlSqtS/HiqiTwbQg2Em240oHSu7lwYsD53cwjLiHPU+VvjtUin54bbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZyC2a92SnOy017PkVdpGN4WjT8+BaGEe1rUyyQ8vpM=;
 b=EF9kjlhghs5GXrgzuwn6mQRLVLqGNMVj+NXlrcHK+UOGzVCRTxSF6KOBcuxXnSHeJp9C9QyAMhiamZfOGB1QgBy3h5e9cKQD8bEVpvSIfWrW1ioBQjc/QFpt6lrsnyyNYvzwRua0t3IHNu1IBHLT+ilBcuz7A6To+igAiZQzrivy+g9QPSOBg8M229OmJ7wx+iXZHc/UPmO40RK6GNup/OrK4lp6HGYm7hT8W01Ag25xEXfZYJcBnTVtH4I/J01d9OTbY0ho3uONtLLJHMkcind19DoX7Xy8vQHD4+b74ZyZfEDYEyhhd1uNkTwn6OGLe+xDTAszeEsZ0Y37t0a8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZyC2a92SnOy017PkVdpGN4WjT8+BaGEe1rUyyQ8vpM=;
 b=lz/HoA48IVnOOehV+66yVEeMdvOLSo8EPgljOcGZXmVMYiwsazpGc5Yfr4sfZQv1OfrjG/bepenMAduzAf4M88vxf8vou7/qORxz/boOUMEgQZH55yIfSojWPbqXsM9dO7NkngochkwcvQj+HVBypzJK3/el1YGbB2L4rdooRWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9706.namprd12.prod.outlook.com (2603:10b6:8:277::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 11:30:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 11:30:03 +0000
Message-ID: <bb36cfc2-fbbc-4128-9ebf-dd574c61d950@amd.com>
Date: Mon, 28 Apr 2025 13:29:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
 <DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB59373CD6217D0B56CBFA09D1E5852@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB59373CD6217D0B56CBFA09D1E5852@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 90732f1b-5936-49c9-9392-08dd86480507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFCUnEzMUo0VVZyNjVkVTBEamRybzBBWHVTUVRGcTJvenBvY2dwTFdOTmc0?=
 =?utf-8?B?ZEpjSXhWS0t5alB4UGNBOUZRSUhtZmVmRC9rTlFzejBId3dXRktBclRyUVJv?=
 =?utf-8?B?TUlDSkZZeHB2VlBhcktYNFZYUWp6cTFsUHBON3ZGalNMK1lXYythR252NFF2?=
 =?utf-8?B?azZMMzVIaFVyZHRodG9uQ1ZUODdCVTB0WU10WmtNSXArZW1lMVoyU0VjTlds?=
 =?utf-8?B?UG4xUHBXczNtZ2UrUjd4WnlBdHRRb05wSEk0VWJRSWE4aXBzV1A0WFFDek9z?=
 =?utf-8?B?d0U3eTZYejFkcnJhU0F6VG5kUEtOUGRYM1RtQ1BraG9kL09pc0l0NWxCV0hD?=
 =?utf-8?B?OEhWbVlIVXQrUXZnby9CSFhMeTl4aTdnU0t0Vjk0MElvaGNNaDBHemx6MnhI?=
 =?utf-8?B?WWcxZnlQTmJyS3k4aGtuZmdHTGZNK0s2RjR6NkV1cktiSXN5bUNxSVcxd253?=
 =?utf-8?B?ZHRnUUNCN0thMVZSTzNrWHFCQTJzbTA5OVB3dkptK2xqSWF0YW92OExrWmNW?=
 =?utf-8?B?VG9HUTkyenlTMFFnVGtuSGEyL1RjSVZKM0NDa1dBYnc3MkpDdFMxczZCVS80?=
 =?utf-8?B?c2NYWjcrNlB1RVdBQ3M4a2xNd1hnbG5vWTlZVWwxK0t0b09aMG5iMkZBM3Vy?=
 =?utf-8?B?N0l6NHFyNTBhZlZQcjhUejJmM2FnOUZrUkpqS0RqTmV3eG1kS3VVM1NRZXZZ?=
 =?utf-8?B?N1hkSFVmbzZxQkdNWFdBVndQOVp6UzBvNFpxR0hUWGhFQUhVeFlISzFZRlE4?=
 =?utf-8?B?d3NFM0tIWEFzalF1RUpubnEzeVVpTFQzTWkyVnlxWVhPajlCdSt4WGlHS256?=
 =?utf-8?B?a1gyOFNqQ0lDdXhsYnUvUThTSzBreVlMKzNaTkg4TFZaUzJzWU5OcXFKK2hD?=
 =?utf-8?B?eGdaQUZ2bGFtcDZvZmhMTkpEOTJ4ZXV6SlJ4QldzU0JSTEVIaHFSNEd4Tmlr?=
 =?utf-8?B?cmNJS1VxeXNxbUFqdC9rM0hGV241M29pcDU3Y241ZVh0K21VMlpXQXlpaDBN?=
 =?utf-8?B?VmttdmJSeTNTWGhtZDFZVFFGWVQrWm1Lcit4WVRqTXVrcmhtWVBScWxVTndV?=
 =?utf-8?B?Z1FJN01WaGlldVZGdVRmbEU3bklQR1ZRZ1FkamdSL0tES3RXbW9hUXhyenlz?=
 =?utf-8?B?ZWNBU1NJQ1drN25vRHpNWlBlYUFjdzBxbkxRUTUrVzlLRGZBSXBPeDhNZzdO?=
 =?utf-8?B?VnNVRzdxQ3BMY2kzMWxoWUw3WmxNSmpKWXNLeWJlRzhBNWFGSTJaTjlLTGRz?=
 =?utf-8?B?aXl6OThIQm8yR1BtUUdXRmdnMjRaQnBRVUphRlFET3ZyQnRObTNleWRub25r?=
 =?utf-8?B?VlpEdW41Y3BvbTZFdXJzeEMzZExDdUIzRzI4K05DVFlYSlZtOEx2RUg1OUsw?=
 =?utf-8?B?RXRyQURuVmtGaFBVQkRGWEJnNjFwUjNZSlcrcWJJT3FyMHQ1Rmp6blZpdE1L?=
 =?utf-8?B?RkNIRUZvZlVmbVNOL0RFRXNvcEZNeWJYMENHMXByZzF1VWN1MCt4YlNVWXBL?=
 =?utf-8?B?Wk5NTkFQT1dkN3N5ZVJGT254VUdPSkdnemZFTlUrcHZSRUxOb0tRM2lSYzlx?=
 =?utf-8?B?dnRUd051UkZnUDZZNlZWZU5jZFl4TWZ0K090TGNXdE92R1NpNW1GNkpqNjdU?=
 =?utf-8?B?aHEyMW1raGtxdVh2Q005aktsWXdvcklzUHB0Y01yV0prUFErQ2NBalBSQTVq?=
 =?utf-8?B?NFJwVTRITk5Delpoa0FWaXlXV2gwTUUwTk9HY1A0LzFocVh1cTFUZkRTZGoy?=
 =?utf-8?B?bVNicmZqNFBJL3A0a1VzWm0zNGlJWjNNYlFwK1RGYldVSm5xTWhpcWd6bFZC?=
 =?utf-8?B?eGt3d1p4QUQ2cGVlTnNjcGlsRkF6QWhLMDRsdmNVc1BtQnIyQlJLcVJ0R3Rk?=
 =?utf-8?B?WkVZTmFSc0NpNi93Y1VGSEZGNGZLYlpkaXpCS3VkVXFZTTdYTm1Tc016SW8x?=
 =?utf-8?Q?k1btdrWu3Jo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5BSU9FTkhRODFXeXpjbUZEb0MvYld6V1UrcHZlYllDMy9paDlLVmNDMjVi?=
 =?utf-8?B?QWdNVm5EQk9UTWIxanJPY1Rma3dULzQvTWJZQVNRZ0tISWVPNjVIR3lod1ZU?=
 =?utf-8?B?VzBIR3R6QU8vdU5zZ1MvbVJaaTJqeGM5aGdaWWJ4M2tzVGNVOEJlYmUzRkRk?=
 =?utf-8?B?TC9paXJ4MTZ2VTlPTlRmT20vUUtkRXRNcU9ua0dHdS9VM1RIK2dJSlBRdDhY?=
 =?utf-8?B?QXNkYm9BNXhxRFFnTEtyREJQazlUY0phTlN6S0prS3BUQ0xhY0ZWWnRuUGFD?=
 =?utf-8?B?YUUvcUdlQU96UmpKNFcrS0taQlVna2tmOHlSZVpPVFJhYzcxZkttdDdqb2ZI?=
 =?utf-8?B?NWgrczF2dThoMUdZN3NNS2NtajV3bUNLWnlNNGwxT2xUdktlWFIwS09BMWxk?=
 =?utf-8?B?UXpURXVFZEFtekMrQ1NqMlJTNXZFZzNwMXU3R2E1WC9PNEdjM011cDVqL3B6?=
 =?utf-8?B?cEFkbkNhOEZ3cXpLS3p1KzkxeGEwL25HWnFCeGRudFlkd0c0S0VBSXhaVmFK?=
 =?utf-8?B?ek9oTnlhWnVZSHNkNklwL201N2EzMUFzM2hhZFUwVHVhY1FqZWI4Nk5vK0FC?=
 =?utf-8?B?Umd0SVhHREtCNXIvYW8xL1RMMlF3eXY4MGh6R1JvaWk4aUdiUUczNGNUNTlE?=
 =?utf-8?B?N0dJbWtkTWJZU3ZoVHpTT3lGcEpaMlUvNFFrNzVCRVRoeUtFa2VMWXlqUmNW?=
 =?utf-8?B?WGFuVU9Jd0IwSGg4UHMrcTdvdXgrZWtNZEovSFRkbGZQaEZFYUZRU1RoR1hm?=
 =?utf-8?B?MG5qTzQ2WEQ1K29tbTNyVU42TWpibmtJcXdjLzdwMjNGdzMzdnF6Q3RvcEp0?=
 =?utf-8?B?U00zTkNReE5MRmtXVUUxYU1YVmdTWnJjMTRkd0JLbnUvT0RwR1YwNnV2dU0y?=
 =?utf-8?B?QmNPRythTXdFd0J0SVh2ODk2a2oxeG9wYnJRak8rN3d2V20yYkl0azlLTDBj?=
 =?utf-8?B?UUlMS0RucUYrazFGK3p0eHNTQWUrRVkyTEYzVUlBOW1MWEFOdHRiVU5Heklm?=
 =?utf-8?B?b0o2aTZuSVBpbERReFNodHkwZ2lzdFdncGFLdTErekQ2Qmc5YnZlL2JFMlVQ?=
 =?utf-8?B?VHZXNklWc3EzZEZ0QlQyaXN6d3R4MU5aK2c5d25ubHlzVzNwWmpDT1piNUNa?=
 =?utf-8?B?UHBOMHBUYms5MENvYndMNndoK0dWVmIvSWpYcGZtaDNTSHFEN2VTQ0RIdkJV?=
 =?utf-8?B?NnFxeEVOakpEUkxoMS9FV1JidGNleS8zVllCR3R3UmtzYmNMUUIxbHNnb0pY?=
 =?utf-8?B?NUc5M3FNK2Z5RHhCbmFzR24zajdrTG1MSktid3d4S2NEVlhVUjVIanlxZEJt?=
 =?utf-8?B?bFdXVnd1Q1BWenp6UlJLaERMeTVqcWdrOSs1YjI1WklMR2w0TlNJWFdZb3hM?=
 =?utf-8?B?NDZ1eUtJZVk0emJoNmRNMzNzc0plMnFlSVh4czlCMEJvZzZqTnZmNzZtQ1V4?=
 =?utf-8?B?U2F1VzY1SG8rSmZGTC9VMGQzTW1wUFUxckY2NFNwaDVXSmFZcUs3dWg4cEFh?=
 =?utf-8?B?QUZYSHRCaUcrTWc2MzVwSHROUGlUU2tkUDAzSit2dlJydmFIT2lBaFBPWVB0?=
 =?utf-8?B?b2Z5ZG1ZemFQTW5RMXJrWEFMaDlsclBRVnJ0S0wwMUFYblFpMlpxTm14bWVT?=
 =?utf-8?B?aERQbEs3OTQxdDhEM2orOFBINWo2bWdhVWp3MXFtWktsN3h0WVFHRDZqN1BO?=
 =?utf-8?B?ZG16RFo0ZkdXQnN6Nm5DeDR1eHh2SUNGczllZ21QVmpqV2JvMmpsUkZ5bGZx?=
 =?utf-8?B?L1NsaHN0Z1F3TmZTUHpkZmRxOGpPYzNkU2tMK3llanZvZWZPczdyRWJ3Rldj?=
 =?utf-8?B?dUl2R0lSR2kySk84aGNjeUwraksrZ2lHUE9Ib21KWnByUUZubWRXSEwwUFda?=
 =?utf-8?B?Z1Fkam1ZK2VEZlVZNStmRlBJQ1Q4L3IyRGRYRkJHQ0hUWTdZMlBBS1R3UmN2?=
 =?utf-8?B?dmcwZS8vZUVXTHFCdHZsV2pNL0pwczNGeHRaV0d4a0JsUXBZKzBJWjFHczJ5?=
 =?utf-8?B?eVZULzhZNHdiQnV2WlNta1IvWitJY2s5R3BGbDJnZFVXWld2QVdvMENoTjdv?=
 =?utf-8?B?RGNYMDhsZGhUVHFFOWZSbndkK1BOM3BFWTFpaHllS2ROQzlwWjA3OWZDM1lK?=
 =?utf-8?Q?fZKybliuq3Jj9bj81k+8/GgIP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90732f1b-5936-49c9-9392-08dd86480507
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 11:30:03.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5oPLRY0GGiqhMl5DCVTuOjRzo5XN1p3FhLBc4Ou5KtES5HDydqLrce1+rbx1r86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9706
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

On 4/24/25 05:38, Zhang, GuoQing (Sam) wrote:
> Hi Christian,
> 
> Thank you for the review and the feedback.I will update the patch according to 
> your feedback.
> 
> Please see my 2 inline comments below.

Please make sure to always CC my work mail address, otherwise I will only take a look the next time I work through the mailing lists.
> 
>> > index d90e9daf5a50..83a3444c69d9 100644
> 
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> 
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> 
>> > @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
> 
>> >                goto error_unpin;
> 
>> >        }
> 
>> >  
> 
>> > -     if (gpu_addr)
> 
>> > +     if (gpu_addr) {
> 
>> >                *gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> 
>> > +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_pdb0) {
> 
>> > +                     if ((*bo_ptr)->tbo.resource->mem_type == TTM_PL_VRAM) {
> 
>> > +                             *gpu_addr -= amdgpu_ttm_domain_start(adev, TTM_PL_VRAM);
> 
>> > +                     }
> 
>> > +             }
> 
>> > +     }
> 
>> 
> 
>> Please NAK to that approach here. The GPU offset should still point into the mapped VRAM.
> 
> This change is to change to the default GPU address from FB aperture type to 
> pdb0 type in this centralized place so that I don’t need to change every 
> callsite of amdgpu_bo_create_reserved().
> 
> Could you suggest a better approach if this approach is not acceptable?


The whole code is completely superflous. When PDB0 is used the vram_start is adjusted and you don't need to do anything here.

See function amdgpu_gmc_sysvm_location(). You probably need to adjust that to have a static setup instead of using the XGMI node infos.


>> > @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
> 
>> >  {
> 
>> >        u64 base = adev->mmhub.funcs->get_fb_location(adev);
> 
>> >  
> 
>> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> 
>> > +             adev->gmc.vmid0_page_table_depth = 1;
> 
>> > +             adev->gmc.vmid0_page_table_block_size = 12;
> 
>> > +     } else {
> 
>> > +             adev->gmc.vmid0_page_table_depth = 0;
> 
>> > +             adev->gmc.vmid0_page_table_block_size = 0;
> 
>> > +     }
> 
>> > +
> 
>> 
> 
>> What is the justification to moving that stuff around?
> 
> vmid0_page_table_block_size is used in new code in amdgpu_gmc_sysvm_location(). 
> See the call sequence below.
> 
> gmc_v9_0_sw_init
> 
> - gmc_v9_0_mc_init
> 
>                  - gmc_v9_0_vram_gtt_location,
> 
>                                  - vmid0_page_table_block_size = 12, **new 
> location**
> 
>                                  - amdgpu_gmc_sysvm_location
> 
>                                                  - use 
> **vmid0_page_table_block_size**
> 
> - gmc_v9_0_gart_init,
> 
>                  - assign vmid0_page_table_block_size, **old location**


That is noteven remotely corect.

See the code in gmc_v9_0_vram_gtt_location(). You use amdgpu_gmc_sysvm_location() when PDB0 is allocted and you use gmc_v9_0_vram_gtt_location() when it isn't.

But adjusting this function here doesn't make any sense at all.

Regards,
Christian.

