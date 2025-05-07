Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F14CC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 12:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C718E10E79B;
	Wed,  7 May 2025 12:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9/f8QGu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D86710E79B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 12:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekZsNqXMjoz+HZjoCpFQ17DNdMnvyhjafSii2Vkl5Kn/Apv8vM29zqQYMqMNqmtbVFVyWtGVTXxetVhGArKik+srq476iOQWaarUK49KSXkDeKgBl7xoDzJW+YpKpjw83xsFhDiSXQnfo3dft9g2t+Jzpi4aPV6zZOQufEc/PqAsJ8NB12pINIIZ1hMipBl24PsZSiqq3mTcgbbb5vR7Esq6LyvuHsah4FjkNuv9tYgAf8tW3OYtNjE1KCn0F+WFF0x+mq/91MV2srN727SMtHS6UvcbA9HO7+KDQsUL+n2N3Vnyq3CJ70FZvyNVMkn7CyFaZE3GTDWFy9YI0/mNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptsu6bELJiBd62PxNpKDTdvWkGT+dXOm3P5CA5XU7Zg=;
 b=lWYVfUq3CT741I5NX29VrXUAMT8nN5vAbbBh6zl9pTBD3fCg7PCNWNY92CaYeyzagnTjCkAUP5p8akwGDJ8wuqZHsgHdLr5X1/btESz9gglg5OMa7y8VorSqmVtVS2tMkYPMnh9VHqug/oCjb8D227OGdIvbesQ1mAzqpwVZh4GwJjh/5DJzwit/wBsdgZzctq44LvY7VMXEtNWxsaFsvsp6z4XP1f0YJu/unjZOT1L7OR63UbOjqSfuK2AUfqkb8Tu0dinEdKRUwv8wUd4nU/NeDliSjV1hSIFNVjfSAHiiOeo92s5rqRzUkPACIZjqUiYH9ImGsxECIXPNqMBGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptsu6bELJiBd62PxNpKDTdvWkGT+dXOm3P5CA5XU7Zg=;
 b=z9/f8QGu5WPvWos6FdjeNJrMIInEdBo+oHl2erPck65/QcOHgzx46Cz2cDM1F9E1thLNc1IA6Pu2NkPvwW/YgugsCcFECBcs5pzl+EBPlXgc/h47MmdkOYycUImBlFURkT5SWfV3vic+dRDZv1WoGu4z0OUPwFrKephwb73ai4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 12:21:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 12:21:54 +0000
Message-ID: <6b2ede19-a7be-48f0-8098-63e05dd62691@amd.com>
Date: Wed, 7 May 2025 14:21:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Sam <guoqzhan@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
 <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
 <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0022.prod.exchangelabs.com (2603:10b6:208:71::35)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 137e05de-5a80-435e-0998-08dd8d61c0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnQrc0lZRjVsTHRkcHpGZnQrRXFRbTNYY3grNnNGS05aaXJPNS9YcmE2VnNm?=
 =?utf-8?B?b1U3OGRIV29ldE11ek4yc2w0QTVsWFlHRnVRQjc0bklJelJna3BUbDJRYm53?=
 =?utf-8?B?WG0xOTdoSUU3VFhJTkRkczY4TFFNTjNHQmJuamM3MFNaZ0xXZCtBb0xncDRt?=
 =?utf-8?B?ckQ1bHZhc0RIWG12TlhLbGJ2RzBkcFUvMWlEK1M3VGFMUEVvZnMxbDdQbUpI?=
 =?utf-8?B?Lzh1L3paWkE2TTRIS21KWms3MU1iU1ZLTWpxT0lYcVVJb2ZwZVBhTTR0THAw?=
 =?utf-8?B?M0F0bVl2TnVqNDdLb1hsd3o2RVFjVDJLVW11Z3NGRm9lR3ZSWlNCT1I1ZTYx?=
 =?utf-8?B?dGhxMmRNN1lWVmU5MHVuYkNrUElaQnRXemlQOEZQNDJxQ1VoTVhVRHNuQTBo?=
 =?utf-8?B?a3hGTUJUVG9BbXVOeGRNaWMwaEg1Y2dtS2FqNlByb0xDY042OFdNdXN1OEtQ?=
 =?utf-8?B?UHdlRVpwN2FiYlVSTXJiT2RqRWFDV29IRkVSUE12N2R3bzV1MjdHSSsvaU12?=
 =?utf-8?B?b1ZWcHVxYW9VTW9DQ2xsWDg3TmhoTVc2LzBHOGU5bmtFdFM4WVp2ZWJmbE00?=
 =?utf-8?B?cHJibU8rMWF6SlNLRzJkS0ZoNXJmN01reHRaVlZjWjd1MllmdTdCczMvUEZO?=
 =?utf-8?B?a3Z5OUVLZkwySEU0MDRFZ0FuTDE3S0RMeis2RkF1S3Qwa214SEdoU0VyTEk2?=
 =?utf-8?B?VTB3VkQyMHlSSTNFUFRXSGQzNk5CNklZTGJuOGY3aEZXc3YwZndHd0hGYzAr?=
 =?utf-8?B?aTgxQ1JJUW53U2tFenUrTUVET3QwbWUzbXZ5ekIyWEhQVFordWFqMVBRKzQv?=
 =?utf-8?B?OVhKdnlydWV1WEVtc2h6Y1ozWjNlZkNOdmQycG10dWFXWnIyM1VzM0pTQXFK?=
 =?utf-8?B?M0ttMkFBS3NDS25QbHhpanc1Um1TWm9OakNPYXFIL2VSYXJ4cjFpUEpkcm5Q?=
 =?utf-8?B?eUtNeEpEbHBlTGxqbzhLQnU0b2VicW5aYS9uQjI2TDJoS2FyNWx0Ylpod1FI?=
 =?utf-8?B?Z09VUmtqM1dpZnhHS2N1TXpzVUJuazAzQnppMU9OSS9rNW81SStLcjdBVWlJ?=
 =?utf-8?B?WWJETTFLUkxlT2VWdzQyWjN5SUo5bWRvbVFkcHJJOUVnZmNsZ0R3U2pJbm9l?=
 =?utf-8?B?bGJLVUtPZnRFZmZxUnNSRHI2SWVwN1ZFNE5Ia0VWOHNmbjVHOXhnMFJnNzJR?=
 =?utf-8?B?R0I0ek92aExzNkJNbWd4SHlKRWxxVzJIbDdYdXhrMmZLMWNOYTVrQXVlMnJS?=
 =?utf-8?B?VFlmZGlFY09NdzJuMFFvM2c2NzRRMGl0WHEwODdRMU95YjRUQzZySjhkUCs3?=
 =?utf-8?B?Vk56UmFkd29sWGNqSXN2RnhkRkE4UWd5TCtJL0swUEh1NmgzQ1lzSkRhYTMr?=
 =?utf-8?B?WEFwY3pFbEQ5UktKNDBnb25lYXZSUjgvWEtrczBKWVNJYUpnZFE2aXRidWVF?=
 =?utf-8?B?QWpSVGVpV0d4dmVta0F1SEJYK2lSbWRONWZ6TE9pZHN2bk0xN0lyVXBRdFZB?=
 =?utf-8?B?OUVQSndac1ZyalV0VHRUSmhjb0ZwMnIzRGNZb0ZVWjBkaG9ZU2pzSlNiSDFR?=
 =?utf-8?B?TlhybVIwZTMyNjZiQTV3MkFwakp0bk9oNG5HeTNEMFpzcVpTWFlqSWN5TWZk?=
 =?utf-8?B?SHNUaW1TeGRTL2RrbW5MaHhXSHREbnhvQWVwVTlRS0Q4c0NkV0IxbDJwK3I4?=
 =?utf-8?B?M2VhSHdBWlhKVERJN2JDNGtxT0VmeUJ3d0Q1bWlzOTVBNVV3bDYrUVMwNE0r?=
 =?utf-8?B?RTNNYWd0R2lhdkxNUkswY1pmWEhaY0RnZUpXMElYMkJqUGh0WG5WRDRsSXZp?=
 =?utf-8?B?d3pKT1JxcDhhRVcydFBZM01mbm5UMHpIMEdldUF5OHh3MVFCa0xSWkZxZUpI?=
 =?utf-8?B?TzNyUzg2czg3M2tuRjRKdnUveHY0aWFiZmZBRlRBK2N6a2VhVTl5ckhHSitx?=
 =?utf-8?Q?QbTRT2Y+Ccc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VYRnZJRlE1QnYxVFk2QkNVYXdYdGtieTJaRTdiQXhtVTFjZ1lLQ3hWU2kv?=
 =?utf-8?B?QmNTanVWNWpYSFBXSUpDZkMyUFNidUZHRi9VWWZDeXBUTHFUY0Y5K3BNTjR6?=
 =?utf-8?B?RklxaldqOWVoQ1JEaVJVcXJndnJ4Q2p3Q3AyYjh0WDltSldvTkx4NkZKcG5v?=
 =?utf-8?B?L2hHeEo4N0JySGxRRTFwcmY5dHdhVXk5VDAyUVpCdGUwa2FMWHZGbytUY0ZC?=
 =?utf-8?B?SC9mWWVFK1VlR1FJT3B5WnZGWkR3NUdsQUV1TldQUXRWQ25GK2REZHBKeThz?=
 =?utf-8?B?blRRU1NSM2lld0FGdlBzZzVFTzh5NHQ5am1aUzVkRjFESzQ5WnVyWktha1RG?=
 =?utf-8?B?TkluYU9UQ2JCQ1dLVEQvMC90RHQ5cW9sV3MxZ2NVUHJQcDNIOU83dGRqRUhE?=
 =?utf-8?B?aUtTcDZhWHFIVnpiYnI1OHRGUlE2SGp4TDNVY0R5VUpjTGtONUthdWhXaWxX?=
 =?utf-8?B?cmdvcFlSall1QmQzUTA5Y1RBWFhBcXB6U0U5b1FNQk9PL0lqTUl1RFM4dHJ4?=
 =?utf-8?B?eExpYzB6SitXaEFQSmk5ZFMwVVNoOU9XUGlmZCt1ODRxelVxb05lS1lwVW9P?=
 =?utf-8?B?OHpyWUZJbCtjREFLTGZObkVkL05FYmwrSG5BVDdBS2FHSHVoeW92SExrUWlI?=
 =?utf-8?B?Yk9xakhJVTh2TmszRCtObzF2UW5IUUZEM09MdlpWNi9ROFdlcGpCMHdId1JD?=
 =?utf-8?B?b2ZIOWZJajFMV3JjUkVKUkM1TjhRV0ZZSi9OL3RDbGZsalJYT0dybVQ2SVlO?=
 =?utf-8?B?VWJlWEVkQUtBVDFhWUdEVTcyRS9aZlltUDd3c25qcjBKOGdlYjhVYXM5UWxD?=
 =?utf-8?B?dzRGTktadzZBNC8rbElDSXEyTzdrVTdhNTBKWXRLZ1RBSzZ4VncxaXlJNFh0?=
 =?utf-8?B?WVUrcWtpOWs1dlc2Y2szaHlHQmltQnVJeGJNTU8zTTYyS1loS21hSmc4SjBV?=
 =?utf-8?B?aHZ3eW1yenpNSlVsSlJtQk01NFM0MEJlS1I3NlFWSVorWDhhY3pyOGN0YXRr?=
 =?utf-8?B?MzU2blB6WThMellFUDBlS09UODZmY1dCSUhSTlVrbC8wMndXVmdhZTlQd1Jh?=
 =?utf-8?B?aFB1dmU0dWtDOWdMREQ1NnV1bXpVYzhZSStkbCtreldGSml4a0xZQTduMDZu?=
 =?utf-8?B?YStZQVRMYThCVnpONisrVVcyNUZENFJKNnJ6R1BZWGZsaUMxdXhySldlOW1s?=
 =?utf-8?B?T2MxTGtvYU05MExOSXdySmljZG5tNUQzZHA4aERJeng1aFR6SnQvSGFicGRG?=
 =?utf-8?B?YXlpNjJlcTlaWHpPWU1UYm9tcjJRc20ycEdLNXBhQVdEN05zZTN5ZjVyQnhk?=
 =?utf-8?B?NzRaZkc4SGY1UDB5OTBkTDkxeWFtc1lHTzhlSHdhNmM2dlJiNjFncjN4bTUy?=
 =?utf-8?B?WnRITFBGWWV4WXl6MzcrM2E4ZWhvYkkyTktzMTd0Y05GT1hDcVZITFp0ak5v?=
 =?utf-8?B?elJ5Q25qZ3FFdXMycTd6amY1RlJYWWdHUXlvTE1zSklTNDRSQjJKdmdoS2xp?=
 =?utf-8?B?RVVUNm51VmE2dDFzRlBETVp4TTF3TWNDaVBQVjBmVXN1U3JjRWpEZXpMQkZz?=
 =?utf-8?B?Sm4zYnhiN0JKeU9PRkFHeXdzWnJnL2x1R2dONk9ESUdpVTRmbXRuMndhcitu?=
 =?utf-8?B?b2Y5cnM3WGlPaDJodkhkRThIQmhMZTJCQnRjT0Z1cGRtTzNIMXM2TkkyQnVT?=
 =?utf-8?B?cWJWK2Z5Mnordi9HdnRtenVBNE5Edmd6ZkxFWk9tNG41RDl2UUYzU0lzMlBS?=
 =?utf-8?B?NWVVTldXaXBlWitkRE1FNml6T3RLTEdyV1NpTDBBTUw0TlYxMHF2WlNJOHBM?=
 =?utf-8?B?YmMxWTBHeTRQbmRnK29zaG9rUmlUUVFiT2t3elFaUTcyYWUrR1FTbzRQN3Va?=
 =?utf-8?B?c2wzc0F0WUtuZzU3YU5rZnRoSzVYOXMzUlB1cG9TSTV6Sm1kRTFwVnpKWktY?=
 =?utf-8?B?b1hHcEUrSkdDQWx1RGFlL0NsUXBTd1AzRHdxS3NPOWZzV0pZeFdhZFhvVjNU?=
 =?utf-8?B?cDdCZHdkQVUwZDBta2UzZXNnVDdHa21Jb0l1R3FEaVZJOFRua01sazJHMEh5?=
 =?utf-8?B?czk0VjA5Zk1Tb2drUG51S0tHTnVOYzBpeVN3WHZpdS9hbGF5bmtSZWx4RmFB?=
 =?utf-8?Q?bfsc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137e05de-5a80-435e-0998-08dd8d61c0e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:21:54.6521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYjmRbwwI3v+rw1egVO5eVJiTGc5N42nbnUb+Lm9S8LZxSZd45a+JZJS8CN5LFDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

On 5/7/25 13:03, Sam wrote:
> 
> On 2025/5/7 18:03, Lazar, Lijo wrote:
>> On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>
>>>  
>>>> Please keep in mind that this is not the only scenario addressed by the
>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>> This patch itself introduces unwanted sequences for other commonly used
>>>> usecases. Please rework on the series without breaking existing usecases.
>>>> Thanks,
>>>> Lijo
>>>  
>>> Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.
>>>
>>>  
>>> I also think the new code should be inside a check so that new code is
>>> executed only on resume with different VF and do not break existing
>>> usecases. Following is the implementation of this approach I can think of.
>>>
>>> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `.
>>> update the fields on resume.
>>>
>>> - put new code inside code block `if (prev_physical_node_id  !=
>>> physical_node_id )`
>>>
>>>
>> Can this happen only with XGMI under this condition? Any other method
>> possible like preparing a 'unique signature' and matching it to identify
>> if it resumed on an identically configured system?
> 
> Yes, this hibernate-resume with different VF feature is only for devices with XGMI. Detecting XGMI node id change is the only way I can think of to identify the case. It's also a very simple way.
> 
> @Koenig, Christian <mailto:Christian.Koenig@amd.com> Are you OK with this approach, adding a check for the new code sequence?


Well you still need to avoid calling gmc_v9_0_mc_init() since that is most likely incorrect.

Regards,
Christian.

> 
>> Regardless, instead of having a direct check, better to wrap it inside
>> something like
>>     if (amdgpu_virt_need_migration()) or something more appropriate.
> 
> Yes, I will do that. Thank you!
> 
> Regards
> Sam
> 
>>   Thanks,
>> Lijo
>>
>>> Is this approach acceptable? If not, can you suggest a better approach?
>>> @Lazar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian
>>> <mailto:Christian.Koenig@amd.com> Thank you!
>>>
>>>  
>>> Regards
>>>
>>> Sam
>>>
>>>  
>>> *From: *Lazar, Lijo<Lijo.Lazar@amd.com>
>>> *Date: *Tuesday, May 6, 2025 at 19:55
>>> *To: *Zhang, GuoQing (Sam)<GuoQing.Zhang@amd.com>, amd-
>>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> *Cc: *Zhao, Victor<Victor.Zhao@amd.com>, Chang, HaiJun
>>> <HaiJun.Chang@amd.com>, Koenig, Christian<Christian.Koenig@amd.com>,
>>> Deucher, Alexander<Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
>>> <Owen.Zhang2@amd.com>, Ma, Qing (Mark)<Qing.Ma@amd.com>, Jiang Liu
>>> <gerry@linux.alibaba.com>
>>> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id
>>> and GMC configs on resume
>>>
>>>
>>>
>>> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>>> is enabled, XGMI physical node ids may change when waking up from
>>>> hiberation with different vGPU devices. So update XGMI physical node
>>>> ids on resume.
>>>>
>>> Please keep in mind that this is not the only scenario addressed by the
>>> driver - for ex: a resume sequence is executed after a device reset.
>>> This patch itself introduces unwanted sequences for other commonly used
>>> usecases. Please rework on the series without breaking existing usecases.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Update GPU memory controller configuration on resume if XGMI physical
>>>> node ids are changed.
>>>>
>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>>>    3 files changed, 29 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_device.c
>>>> index d477a901af84..e795af5067e5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
>>> *dev, bool notify_clients)
>>>>          return 0;
>>>>    }
>>>>   +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>>>> +{
>>>> +     int r;
>>>> +     unsigned int prev_physical_node_id;
>>>> +
>>>> +     /* Get xgmi info again for sriov to detect device changes */
>>>> +     if (amdgpu_sriov_vf(adev) &&
>>>> +         !(adev->flags & AMD_IS_APU) &&
>>>> +         adev->gmc.xgmi.supported &&
>>>> +         !adev->gmc.xgmi.connected_to_cpu) {
>>>> +             prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>>>> +             r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>>> +             if (r)
>>>> +                     return r;
>>>> +
>>>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>>> +                     prev_physical_node_id, adev-
>>>> gmc.xgmi.physical_node_id);
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_resume - initiate device resume
>>>>     *
>>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,
>>> bool notify_clients)
>>>>                  r = amdgpu_virt_request_full_gpu(adev, true);
>>>>                  if (r)
>>>>                          return r;
>>>> +             r = amdgpu_device_update_xgmi_info(adev);
>>>> +             if (r)
>>>> +                     return r;
>>>>          }
>>>>            if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_gmc.c
>>>> index d1fa5e8e3937..a2abddf3c110 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
>>> amdgpu_device *adev,
>>>>          if (!mem_ranges || !exp_ranges)
>>>>                  return -EINVAL;
>>>>   -     refresh = (adev->init_lvl->level !=
>>> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>>>> +     refresh = true;
>>>>          ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>>>>                                              &range_cnt, refresh);
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gmc_v9_0.c
>>>> index 59385da80185..1eb451a3743b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
>>> amdgpu_ip_block *ip_block)
>>>>          struct amdgpu_device *adev = ip_block->adev;
>>>>          int r;
>>>>   +     r = gmc_v9_0_mc_init(adev);
>>>> +     if (r)
>>>> +             return r;
>>>> +
>>>>          /* If a reset is done for NPS mode switch, read the memory range
>>>>           * information again.
>>>>           */

