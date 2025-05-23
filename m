Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB23C3DA6D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 11:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A6C10E7C2;
	Fri, 23 May 2025 11:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O5/LKe32";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE56710E273
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 11:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaxFBDPVF9XRW8X/dz+6VB/GUDsQt2vAS7bb1yoII3w9MOSgUO20K5WKbSQwjZMqNiSQR5v86+hcMQe7LfnkrxevJDzLoM5Y5PIMZ+oyJv+7Ht0SbY79ZFbdmknlwsI/zk2zdtxsDxhgoeM16He39BFm/0o7NsAGrQOqtybDfUnKyLzr/F1F19WtKf/D6nV7cxLiRATtQ18yDbCX+BhnXuAVEzdjfVShbp2J8kuI3qQcz7KzcEmncFaX+dY8wVy1zR7+hXZYtxCardf3GIt/l9/am+Xq3DKc3wIESGsCm/blKGV3+pw6r4CAjaYLMy0pMycclK4VMTRpf7VIhOn59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nhy3w1xHjbzO4uA6Ec5bYhtKurhUaxktthnvilbMfs=;
 b=fxr9qHyGG+EUpVC0eKEcjBm/QZhL7ND83Obdm44mso5kQJpLRHHz9inmULbAnAbIkb9rLTYxs4F6di5r1jTfr3Y/kbvFKmezu9XQckH8J5jT5LM36Km1tu0ACVnFGjCK9FwQTsj6ZOCrlWptdMbHllTUIxi3U/ZA1IRVrbSM1OCrh/gCmZL1hUHN+y5gwXxGxVqZspM/PWMxjgo3H8g9RGJd5+YYmUO8UiIycljSf0OKli/w6sEF5YilveiUpxB+p0wAqUAIjA9MDg2NLiKWQxy4FIQe7Gee5YhNGJuCcAFCR5SwyvrSCfCKbHPb0CvDEN/0tfXEEU8Xj5hNnqys3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nhy3w1xHjbzO4uA6Ec5bYhtKurhUaxktthnvilbMfs=;
 b=O5/LKe32g3AqYLNlaq2Oj/ux8IocI9uJDvANbJl1th5PnwAtUDXp/6ESAyXlf6AAe62LgwaZPvO+cz3Gs1jhjF4wetDVlNWIeYbL+YXePrZG2c3PLqpAnxjbMBAaK4bfZcoOs9NUalk+ys8dBzbAV7d0JjNfPmAe76HkMp9CbrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 23 May
 2025 11:31:10 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 11:31:10 +0000
Message-ID: <7b07ade2-96fa-48c7-923c-870868792243@amd.com>
Date: Fri, 23 May 2025 17:01:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
 <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
 <cb73b496-1008-4338-83f4-a1ddcb81be46@amd.com>
 <74e83de0-1a1e-458a-b110-f6458db129c2@amd.com>
 <01435a2b-e4f6-4265-a355-e970fad8fa29@amd.com>
 <34f28c86-8899-47c5-888e-5b44add5ca3f@amd.com>
Content-Language: en-US
In-Reply-To: <34f28c86-8899-47c5-888e-5b44add5ca3f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7920ed-89d5-46fe-24ee-08dd99ed50ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZC9rRHdhbVl2QUd2Tkk1V3IzbG9iWlVDdUpidVpiR09wZnFzajFFckZhbnNN?=
 =?utf-8?B?aUtiL3U4dzlsM3dBOFZrY3gzWkFuQmdVTUU0Yk9zdjhQQmdkV05vZUFlN25k?=
 =?utf-8?B?WTVGZ2ZtSVlyNlZpKzZDRUJPL2YrcXYvUjBGNXNjeTVWMkNzaTFCZFNTWWtz?=
 =?utf-8?B?V1hLWHVYVFN0WnFCV2IrKzRCdnFxVE9YQ2ZuSUJmTWpXa2VmYkt0NG1xZkFZ?=
 =?utf-8?B?TFRnSnh1NDdJRWkwQTdKUTVuQzhjWldkNUdFMFRKN0FNbVVBM2YzejhHc3Vo?=
 =?utf-8?B?N2FZZ3AvWmxGTVNkK25pWVIrblpsRTZpNHFSVXJ4M3lqRVhCRXZnVHY5QnZK?=
 =?utf-8?B?ZVMvOFl6WnhlWFQ2cldIeENyRE9wUHNHaCt5UVNRWEZ3ck9VckNRL1dwcllY?=
 =?utf-8?B?Z1l0dXJVbHRZcDk4aU1odmk4bTZpWXo3VllLVUlCdFRuRmZZS2JkcXNYbzBB?=
 =?utf-8?B?VndxVnR5TUkyckxzVWFrMHBJV1JsenhPZ2UrL0hacHdHWkJIcmRHMnZWZTl5?=
 =?utf-8?B?d2lnUUgzVXYrUVZQYmtHOGxVTXNFOWxwaHBPMTJuc3pHZnZtQ2pXbWQ0SEoz?=
 =?utf-8?B?cE5TUC93Njcvak9KenB3d0RJdURQN0NsTzBoekNBNDI3TGh5NW4rcnYxYkVM?=
 =?utf-8?B?NmtyQXllQzRBWi9pd3Z4Sk9KWlRMaExWdVZ4S3pwNkRxOEttODRSVGxoUnpk?=
 =?utf-8?B?ZGJRbTNqNVZkaE9jdlNydlp3bzZuem9kNmp0SHBEV2dZM2ZoMlp0LzFzdFZY?=
 =?utf-8?B?NGJDYlhuMGdTTm1PT2d2RlpuYk94YnZjN2dxa2JqazVYYllCOExmaENiRUZ2?=
 =?utf-8?B?RzdENjhIVlViNWF4d1VLdEt2MVQ5emRKajJCVTBKdUJOUDB6dDJPa0xPeDNZ?=
 =?utf-8?B?c0czc2kwQ0FnVjVra1ArT3VsKys4ZXltOTMxempVeWJRWkZKUENZTVBrTlM4?=
 =?utf-8?B?WkNPK3lYRTBHMGhaeWN1MmZaL0UxOVl6Z1NUWTRWdElzK0t5Z3cwUGxuN0Nx?=
 =?utf-8?B?NWU2Z3BPTGtkRm92cjZ4bjZTY1c4Ky9MWTRsUy9DVncvb01HMllrV01xOGdF?=
 =?utf-8?B?a2dUVW0wSmFFeU50T0FZenhOWWNod2FlVmh3SDNocFljUTRGcjdGb1BTMjhj?=
 =?utf-8?B?ZDlUdHc0amNoak4xZEFVOWc5YmxzcFZzQmtGWk9Uek1qUXhIVlp2WlRvaWk0?=
 =?utf-8?B?VXd1U3UyVGdKOU5WNXo2RUxpSGtGN0pVWnJmVTlvcjhBbXR6VGVMOCt0K1FO?=
 =?utf-8?B?KzhyalA3aVlZbE1ldGxVQzNnOVJkQkJFaFpySFhhcGVRR3FTWWtwL0NZS1A1?=
 =?utf-8?B?Q3haNCs1WmRJYXlqRUNvTHNpVkx6clZxVURNVHhqdG1iYlFJZmNBNnpxcGJB?=
 =?utf-8?B?REg2WnlvMlhOaEN1QnltSW80UEdLalJuOVdndXd3RkVQTE85ZlJsTkI4Uk5z?=
 =?utf-8?B?SFNVOXNSWmNJa1JjNjVNUjVVTEZab09TdDVrZXFqVDByVVdHaXZ6REZPdTgv?=
 =?utf-8?B?TjMrU0VLS0xZQUZUeUZZQmVkZmE0b0pyZDlvbTA5NzJMSkNLNmJEUUQ5SHlE?=
 =?utf-8?B?VTFSUXhtbkF3V3BUZlYzcjgyK0VpQTZlOFN0NHdpWTNZV1dmTDBqT21nQ0Qx?=
 =?utf-8?B?NGNMM2piTVArVXFuWmo3Z25sbzBjYVhKWFJDNDJBSEZmOFNnMUYxamhyamFE?=
 =?utf-8?B?a1htOXFPQTYxeDRVRG0vOE5uOEZsaDZyR0J2ZFhuY2RRb2o2VHFEOGZqSjRn?=
 =?utf-8?B?TUZjN0RvbU9TZTV6UmQwdjVKUWF0dEQ5aHhqbWJNYXVGOUVCODJQOHU0S3Np?=
 =?utf-8?Q?Ia5v+aUTLWDnAW9w2mvfSMB6qjRW4QXAw8/Jg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1oUG1IbWJmMFRaUlpWeGhTc0lTY0NsbEl3YjlBV25GcC9Qb3BkUjZySXcv?=
 =?utf-8?B?VlUzZEsyZThQcTNuQ082QUJ3c0plak9xdEZvQVlybkVlMXlMTmZKZjc4eGFz?=
 =?utf-8?B?MlVqcnZpQUR6cDhZUFBtRURmT21rdGhiS0NyYTFhZGpUWUFicHNHUWZhYkJq?=
 =?utf-8?B?dXJDc3NNZUZBSEo4SWNIeXFUWEJ2cVE1NVlDaS9sRDZOM0k3ZEphSks2dE43?=
 =?utf-8?B?UXQ2TDR1WFptVExqa1UvbXB0Zy96T3pzYVhpK0h6dk42NytkeHhkNjIzckNv?=
 =?utf-8?B?Z1oyZXBDRHlVS2lld3RLVThQWEUvSjExeEtka0pMc2VZNmw1ZkF5TW9za1VR?=
 =?utf-8?B?cXpadkZ3UVJCTkZqVFI0S0YvTEdPRWR5Q3g0N050WVRNRDNHUTZQU0VkZEdw?=
 =?utf-8?B?dDhNY0cxeVhxdUFtMUZXRlhLeFJ1alpyRHB6YmxQWnpxVTBBT2pUb2ExZW56?=
 =?utf-8?B?NHRnRDl0ZXE0QzRZUHdFMzk2dHdzQklicXlyRW9KZ1hIcXhZQWJYbllKaUxx?=
 =?utf-8?B?Skx3RmJSeGdFSm9xT2ZONkJxSThGVFNNOS9nbzRsMG0yaGYyNWJNVVA2MEh4?=
 =?utf-8?B?Y1FWdVJ2N25UR09oZnhkbk1YZHIrK1NFbllBWlJ5REpWSGFHNzJBbFMzN0Fl?=
 =?utf-8?B?bHdmczJtUHA0SElaTzVYUXZwRDJFdElqdVZIRGRTN2U5YXJsMmFXc0hkVTZ3?=
 =?utf-8?B?VnFHT2RSTzdDMTZOdUptb1B4RXF1bkFiNU4yeHlpbzVLeXgyY3NKTk5aZXJU?=
 =?utf-8?B?QmZRTlRZTUQ0dUEvVVh1VUh3WEIwTEhoUks0WmRUaTNGVmNVMjRxM3FydExi?=
 =?utf-8?B?N0Jzc0s2OFB3RnZta0RuWkxIZG9uNVBBSzh3dU5MK01rc1lwamM4YWNUQWQz?=
 =?utf-8?B?V3VKZTVUWFRXMXNkTDBaVWMxZkpMbEdxSlNXMU9rZWlId0xhZUFzUHYvYnlK?=
 =?utf-8?B?UHdwcTVrYWJVOWJtV2xJNVUrR3BKQUdWZ3lmU0JET0RmMDljS3V5cFFsdWVq?=
 =?utf-8?B?Qk5sbEcvc05VTEVmOHJ5ci9zL2FkT2FGUnkvZ3BuZDdyTVlxYW5tSi9yUmdY?=
 =?utf-8?B?cExLUkNxbFhuZlhOQ0FwcDVFTWJsayttVEIwRER6YjEvQU9jQTZhRUl1U0I1?=
 =?utf-8?B?Ui9ScEtRM011SVd6cGl6NFNuVysxSmNBejhJcHNoWVowcW5qUFVlbHZjZXNx?=
 =?utf-8?B?NHRvV09KNzhZVEgwRjFNZ0d1akhlSWpGWFMrNzc1cHd5VXRaM3BmZGVwM0hG?=
 =?utf-8?B?RlBGTk16Z0d1QndxWkZKZFFETDBwRWdDOEV1c0M4eVlQUGM1cjFoRUd0REdD?=
 =?utf-8?B?THZEVFMyWjNiRzgzeS9ST01qUXZSeDB4clcwVWxTOGNnd3B0Zml0ZGY4b0ZG?=
 =?utf-8?B?R0xqdXpCaDRmbndNZ3AvdXlHc3V2VndaZ2p6WkFYNHF1eGxXQ1VZSm1IOXph?=
 =?utf-8?B?MXYrcCtsd3FlSUFuRG9MK3l4bkhyOWt6MnBWSFhzVnV5aXBjWU1CaTJ3STVs?=
 =?utf-8?B?YzZVODRkZEVDdS9vVHVINGNJaDV4dmNuMFB1d2tTTVpJZUpJSTJPd1A5dUhE?=
 =?utf-8?B?ZmN3UGFZY2I0eVB1QnNGYUo2eitQeUhLWmI0UG9QVS9jNGxkNHdQRGF1OWw0?=
 =?utf-8?B?RlVZUEtScm1aanVQaWs1VHRYMVYrQzgxOWlkMzBqcDFVUEREOU1vaGZPRVpM?=
 =?utf-8?B?QWNYZTdKTWR3TXdjVTNtYjdyK2NxUlpLK0xudFJGRE5OL1JlWm5IQk5TbVdR?=
 =?utf-8?B?Zi9iK1FjcTM3WEZTallNd09MUTM5ZnM0UmJWcm5TWEdndE9YbUZRaEJNTmxp?=
 =?utf-8?B?Tm5zbktCcXl3MUN4UU81aUtoeTMvZGNaSEF5VERHclhQRTNjM2NsZ2l4bElZ?=
 =?utf-8?B?alZtMWE3Z1JLeUhsWG5GUC96OE5ITFRVdXZVRFE3cU85ZkdJRi9Yb0dGa2Mx?=
 =?utf-8?B?SG1mcmJMZjB5TmtvSzdVbG5EUVhvQWZIa2QrSUlMeUxwWEhBcElaRHZxcFZJ?=
 =?utf-8?B?V0NtMmZUTEJrV0cwSzQ2Ly8rZTd2L0ZTVTlxd2dlaEJsVjdQc3JOTUlSbHN5?=
 =?utf-8?B?dXU0ckNIdEcyTjllL2JJR3QxNCtDYXl3dkdnaGR5blpYZm1jbEFnTHgzQ1lr?=
 =?utf-8?Q?8HtZ2wukKl7dpkfZ+NJHOrCG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7920ed-89d5-46fe-24ee-08dd99ed50ad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 11:31:10.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noOJz4EVPwUiUQwwMW+wMz5/tgKHKc3q3mb9ylIXfa9PBH2L6bCvwyy7onHrdIuJCmo2o+4HRcSNRRAH1BKKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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



On 5/15/2025 9:19 PM, Paneer Selvam, Arunpravin wrote:
>
>
> On 5/12/2025 12:41 PM, Paneer Selvam, Arunpravin wrote:
>>
>>
>> On 5/12/2025 12:39 PM, Christian König wrote:
>>>
>>> On 5/11/25 22:37, Paneer Selvam, Arunpravin wrote:
>>>>
>>>> On 5/12/2025 2:03 AM, Paneer Selvam, Arunpravin wrote:
>>>>>
>>>>> On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>>>>>>
>>>>>> On 5/2/2025 9:02 PM, John Olender wrote:
>>>>>>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>>>>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>>>>>>> + Christian
>>>>>>>>>
>>>>>>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender 
>>>>>>>>> <john.olender@gmail.com>
>>>>>>>>> wrote:
>>>>>>>>>> The drm_mm allocator tolerated being passed end > mm->size, 
>>>>>>>>>> but the
>>>>>>>>>> drm_buddy allocator does not.
>>>>>>>>>>
>>>>>>>>>> Restore the pre-buddy-allocator behavior of allowing such 
>>>>>>>>>> placements.
>>>>>>>>>>
>>>>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>>>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>>>>>>> This looks correct to me.
>>>>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> I was thinking that we should return an error when lpfn > 
>>>>>>>> man->size.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Arun.
>>>>>>> This patch restores the previous behavior in the spirit of "Do 
>>>>>>> not crash
>>>>>>> the kernel".  The existing uvd placements are pretty clear in their
>>>>>>> intent and were accepted until the switch to drm_buddy. I think 
>>>>>>> it's
>>>>>>> fair to consider their style as expected.
>>>>>>>
>>>>>>> With that in mind, I'm not sure amdgpu_vram_mgr is the place 
>>>>>>> this change
>>>>>>> really belongs.  That is, I think it's worth asking:
>>>>>>>
>>>>>>> 1) Why does drm_mm accept end > mm->size without complaint?
>>>>>>> 2) Why doesn't drm_buddy do the same?
>>>>>> I remember that during the development of DRM buddy , we had a 
>>>>>> discussion with Intel folks and decided to
>>>>>> return an error in DRM buddy when end > mm->size. This was done 
>>>>>> to ensure that, at the driver level,  lpfn
>>>>>> has the correct value.
>>>>>>
>>>>>> I will modify this at drm_buddy to match with drm_mm and send the 
>>>>>> patch.
>>>>> After giving it some thought, I think it is more effective to 
>>>>> implement this tolerance at the VRAM manager level
>>>>> and allow the DRM buddy manager to perform a strict validation, as 
>>>>> this is necessary for other graphics drivers
>>>>> (e.g., i915).
>>>> Reviewed-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Ok in that case please pick this patch up and make sure that it land 
>>> in amd-staging-drm-next Arun.
>>>
>>> Alex most likely won't follow the discussion till the end.
>> Sure Christian, I will merge this patch into amd-staging-drm-next.
> I see a black screen problem during the amdgpu driver load on the tip 
> of amd-staging-drm-next,
> once that issue is fixed, I will push this patch into 
> amd-staging-drm-next.
I have merged this patch into amd-staging-drm-next.

Thanks,
Arun.
>
> Regards,
> Arun.
>>
>> Thanks,
>> Arun.
>>>
>>> Thanks,
>>> Christian.
>>>
>>>>> Regards,
>>>>> Arun.
>>>>>> Regards,
>>>>>> Arun.
>>>>>>> Thanks,
>>>>>>> John
>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>>>>>>>>> b/drivers/
>>>>>>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>>>>> ttm_resource_manager *man,
>>>>>>>>>>            int r;
>>>>>>>>>>
>>>>>>>>>>            lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>>>>>>> -       if (!lpfn)
>>>>>>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>>>>>>                    lpfn = man->size;
>>>>>>>>>>
>>>>>>>>>>            fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>>>>>>> -- 
>>>>>>>>>> 2.47.2
>>>>>>>>>>
>>
>

