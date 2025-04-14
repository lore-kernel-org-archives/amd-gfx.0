Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCD0C369B5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 09:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C950710E531;
	Mon, 14 Apr 2025 09:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sN1vHGqS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1A510E531
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 09:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/MfEV8PyUODbeXDI5wKrH3pY+yJJXXaZai7+hySGyHq3MZbDO4jEnoagEGj4RBgtq44ayA1wcpNnX5lqNsGiteUCSi9veJWv/tBmWaxjNHTzgMDocEiIW0ExOqGcp+3xFcN3ZvVLVlfem39Trtmjg9qoivu9dfGduNZRwPUF0TmubXpBy2YLe4Pk4iOMT9x/TL32FHi6O7rWziQQqxlAB0wa4igqDH3xTQ8ScnM+AotLJCjJ2nzfceER9/PlC2ZRif56MMhSzgrc6fQCEa+DgU1CZ6NCq+gMCNxDIhTxbIgysaeo21fUvxjVjpWFWyfIHx8LFPLZvI2/4rI/9HEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+zAF7p+E+JG69HgGv7CJyMIWSQhz1DEoAcLJYJRGKo=;
 b=eRRT84rSuThbfhSIp1V6K54ExfF0ZddPTvtBbjky6s/bPeSm8FCvv//u3B/XiuBIXb2OnpI+NlSsVKpVERXftpncwrVgXsQgnt6Jh+n+3MWgQc9GOgQ40Cif2D7L++KfEzqIhkHMMHBrrgwAiwiA0mStaxvaTqbfNjNlCip3xhCuPmcAI3hZ9XN3xOvK6lKZVizO8t2JqkcMWBg4BF3t04ui3TLt1ykLjOGbnHaDdXITooqIT7fS7Z23Lvjt3PRnQ0SUeF8bnZiZTjQJdZVJdsq88+Irm53bLWXeuuPIuXhn+ytzjBMC6yvd0+2c1APSXmrA7GMdqTP0DZtpiyo37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+zAF7p+E+JG69HgGv7CJyMIWSQhz1DEoAcLJYJRGKo=;
 b=sN1vHGqSvlx+l25ZxBSFEbp7c58bb7bWBl+LqFyaterSRg39ABa7JiGZ3YVBluohRZRe+suE0OkRrodTFr0Iv+bwrcV9STyliYqYESBTqmjS/JAHC+t22bZV7Y7K+HFO4T9cDsH+fdt/9cpGOCkrr2lypszOOy/ZGM8TIl1Xb6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 09:51:12 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 09:51:12 +0000
Content-Type: multipart/alternative;
 boundary="------------nzPBNibB0FOrUFJqRYE0RvP6"
Message-ID: <4fd7cef1-bd0c-4aa0-bc87-8f32dedd7f0b@amd.com>
Date: Mon, 14 Apr 2025 15:21:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
Content-Language: en-US
In-Reply-To: <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 0916886b-50d9-47ee-11d8-08dd7b39e3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykc3V0VTVUVVUUlvbDl6anlUMm9OdUc5MHZSRFpZZVFZYnN1dmNYL1RQY2N2?=
 =?utf-8?B?aXVPdmVEakdOUVZ0SXhwMitCMVNLNzRkUHJvcXNldDZiU0tpWEcrMmNWaE9K?=
 =?utf-8?B?eEM3d2lzbmtQWXU0VWhpcVRUNGpQNUJhdFZmb21kOW5LT3ZBWjRoQ3lPRlM2?=
 =?utf-8?B?N0RQOUZxNW9TcUpYdVUzb2ZhaFVkR21pTzlodzduVTYwUUhrdjh3MDNXTURT?=
 =?utf-8?B?ZnozQi9ML0JKN29Fc0lFemtqUXhiWHp4RVQwdnRlK3JoeTA3MU95QUU1WnV3?=
 =?utf-8?B?TFdxbk5QbDF2ZDN2RmhCME9XYndTdWtuMXF4My9OQm4vT0NtSTZGeDBkWUEz?=
 =?utf-8?B?TWZ6N2pRZVUzcVMzMmxmZFNyWUs2b1RZN3pPd2JwTmxNREk5TWJGQUFQdG1X?=
 =?utf-8?B?bUhMT1l4dTczbCt3ZkNVeHJFT0JQcG10UmpwN2o5UWhJWVVrTERQOWV2YVlU?=
 =?utf-8?B?NWlVUkNrUnMydGQyOVZVVDREcnRqN1JjajRiUXlkUXJHQVowSkltOUtsSHhm?=
 =?utf-8?B?WUVraXROc1VUYWMwNXdlVzNDMTZKc0JWOUNHZGRjN0tJZ2VISXNRMXUvQ2ZE?=
 =?utf-8?B?aVcrU1BjU0xTU3d2REErYkgrODFTUUxzRTZsY2V0d2svais2c1J0Z2laTGN0?=
 =?utf-8?B?UlI4MlN5VFUyOFJzdXUxRDZ2TmlvMDRGQmRMV3dPZFMvSm51Tll2Yk1KMURU?=
 =?utf-8?B?a3YwTGJWQ0hXZE0wOUUwMjhyUjBGY2NDR0xUQXIxMitLODBySldJTkxwcnlH?=
 =?utf-8?B?YWR0c1lNOG5MdHAvb1JBRnVJNGYzRi9TYmRZWjFvUi96OEM0Uk9Xc0x6cGJF?=
 =?utf-8?B?YVRYenJOc2x0Zmlad1hNSk1mRk05akR4bkY1TnI5dEFZWFFnTGhUQlh6WlB6?=
 =?utf-8?B?YXdjQ01DMnQrZG13alFsZm90WGE1UGx3Z2N2VTlPV1VNYVA3SDBrdUgzOXlK?=
 =?utf-8?B?Vzl0Nks0bU03MDhFTzBTbW81bythUHVwbU1yUDYzMjVxZEtTRmVqVWx3RzVZ?=
 =?utf-8?B?cGpUbGdTVDRoUFhNMUhteWlSb3FiMHlEZ0hkSDBjVVJjSm45THdnd0pRK1lR?=
 =?utf-8?B?YkVHUk13RlRnS20rRmdCbHgvZDVmdmNwTXhTUlVCTDRpdEtUU0xzb2FhMXlZ?=
 =?utf-8?B?YmhmWmRZN1pzOHlGYTlpcHdkNy9lMjZFaGRLT2dITFRvbTF0UGtTVllNVUZH?=
 =?utf-8?B?UWttNCtrR1BoSlBBTTlSMFJLR0ZXQllkOU5KZlNOUEszNGt4V0Myd2ZpTWZS?=
 =?utf-8?B?WGVXbGg0TmlDVnBJWmc4YXBUMnM3bWlqQ0VKVnNiNlNFdWRBVEUrbXJNMEQw?=
 =?utf-8?B?dTc1S1ROeEpVdE1BeGZMQjJzcnlBaDh6T3VVTk44elcrd3lGT1R5eUVYcXB2?=
 =?utf-8?B?djJDa001bEpCYUlncUdBbHYwc3ZaMHFJYi93NkFrSWFHQ1BsZkZScG9pekkx?=
 =?utf-8?B?elJscEtNZGRpdUhzS0Z2aVZ4ampPM1JjUFlwTlJ5UmFZZk51TFNnaVN5bkpz?=
 =?utf-8?B?RGNYUFIzbll5VzFpWWVJQVYxTURjOXhWMldNR3doRmhSSG1qRUc5WjdjZVQv?=
 =?utf-8?B?eE1VQ2I0aytyTTZWTlA1MHVLVTY5QzAyeVpXNjlCRFRVVWozTjNkd1R4UWlX?=
 =?utf-8?B?MmczeWo4ZnBFSE1xLzZidVhab29rdDZVelJZOXc1SUpsTzJLRW5sM0xrQ1Fk?=
 =?utf-8?B?NDE4QTdkaHF5NlVOR2I2aWI3RUNNREhlVmFFVWE4MXVZVlpMdXdvbGhwSVpC?=
 =?utf-8?B?L3BST3hjL3c1YkxQdTdmUUx3S2dCTnYvRFQvZEVtTEJYS25UZ2RZVDd5MDJ4?=
 =?utf-8?B?WFVaZHFHMDNjRDB2Tnd4dktLaEMzWmJnZHlCdHU1OGxISjVQZGhiL0w1S0o4?=
 =?utf-8?B?OW5YcGJrNjZIM3dJTHJvNGF1UFFhSDd1SmtxZm5qTUMydVpsTnlTelRMdmhO?=
 =?utf-8?Q?gkIVZopVcO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldQZnM3OFVIeUd6aFZ1UHp6SllJRTQrSFEvc3dpNjlLa1VLeE1UYUJ0RktE?=
 =?utf-8?B?N25waFZZMGxKQkFtTk5nc0t5NTVqcWNTNDc0NkZUOEgyN3g2bzMxUk5tcUdZ?=
 =?utf-8?B?Tm16bGxWeTlSSFBLank2WjNFVTNPZDhXMHdpVkk4Nm1wMGpweHBvK0N1T1Z5?=
 =?utf-8?B?bXo1WXdLTURyVzJ2MjBwZ3lMTFdFR0RsNWhYaXp2eG1nd1VYR1lZa3hzQy9I?=
 =?utf-8?B?cUErY1pRT0xKWGRwVlQxa1JTcGdsZGlFekl6bVVZbVY0eGU0dTl0cEFoaHBZ?=
 =?utf-8?B?aXV1NWVyUUNFYS8vSEZ3RE9zYjNuYXFDWDJMYWhQYTVjZXZPWFlBZFJId1VQ?=
 =?utf-8?B?V09yWGVzN2labEljd1FEeHo0OHZEaEllUHhiZitJMXRoVldKaWJMN3FOdE05?=
 =?utf-8?B?TzZSeDVRUzlpNzM2YkNaWEU0Sk5NbWdIR0E1WGdMNnNhaVNQQ1czMkJKZWNU?=
 =?utf-8?B?cXQrWVQ3ZVQzT0pINXJickhRYkx1OVQ4dHN0a1Ntc3hBSE5vTzJDbkRHYlFC?=
 =?utf-8?B?YVBoaWt2ZmhYNjk4K0UzWmRNTmlDMVdjYVROeUNnOU9ac3o3U25pNWtSTlRX?=
 =?utf-8?B?RmpQZ0NqbFQvakJTekFJM1ZYd0lNcS9Vd1Z5bHJJQnNITVNYd1JFdXJoNjRS?=
 =?utf-8?B?UzkrTkFidXkvclVpOE1wNGJmeHRQOUk4Mm9yOUZlL0NuS1VmTlFrQjdGWU81?=
 =?utf-8?B?M2N2M0RtdFFDQ21oMnZLYnZFSlRxOEJaUDFwUWx6UU95L1l3Y291WTgwRXY3?=
 =?utf-8?B?WitQcTlISk4yZFR3b3RCMDhONDRiRmtjYlhqZnFlbmRTaWVTbkhnaERoaU5Z?=
 =?utf-8?B?TWJEeld4MXh2ODI3NHhPMjV0czNQMEtTU2hBVWpuM3NDNzFQbWxKb1R2VkpW?=
 =?utf-8?B?Yi91aTFmbkc3Q2YzMWNXNXVKbVZsZ1Y5MktWSE01cUJ2NXpFVzg5MGMvM0k2?=
 =?utf-8?B?Ni9ZNlRJcUxPWEFOUVlCOHdtZWxlaEZSRlA0TWhpMnlSSHFoSlR1czJxUzJT?=
 =?utf-8?B?QTI5d1BDVWVhaUd3QlZKT0F1UlBiS2FFWTJ1azgvbms3YkVmWUpmeVAvZ3Q3?=
 =?utf-8?B?azhnSFlVYnpRM0ZVdjFJNXJUNzdrK2JFeERzeHRoZ1BzRElMcWVxNWFpSmJZ?=
 =?utf-8?B?NTgzekFVMzRxVHRvZUtxTmYyM3hmSk1pSUtTdVBxN1loWFlEMjZRdXhUK3Q4?=
 =?utf-8?B?d3FBS0hJSjFrYmgvUGxFblQ2WXFBYUM4OTNoa2M2TWVyNjlrenhuaDgvR0hs?=
 =?utf-8?B?Vnl2MEJ6a3d4OVFmZ05HUFErdkxVNlJ6RWZVc1JYN2UwSEZaMzJwYWtRSHFo?=
 =?utf-8?B?cUxqNElESlVJRFRreXFpcjlnOXFyeDF0WGlTZGdwWGhoNEFtS1FqRVB4ODlG?=
 =?utf-8?B?Mmtacm1CWkFJckVtVjkzM0M5SnhrQWRzWEZXMm9vME05UXJFeDZmalllUGZi?=
 =?utf-8?B?UXdXMEFka1hVakRsQmpRb2Y2Q0YwekJzVENDb2huVUpwR29BK2krQkw4Nk5T?=
 =?utf-8?B?VmRiSFdZRHNMQVVqYVFFMjliU3ZITllZM1ZHRVBqK0kvQjRkemRXSm9wU1Zu?=
 =?utf-8?B?OXpOUU51Y1RiRWpaTVpKdnNOQWJNS0p0WWZoTUN0YlhyTXBlWkd4V1ZIdGFj?=
 =?utf-8?B?ZXlpblJDRkVMKzhUbmJnaHpnbDAyUDZpWnIvLy91R29kZkMrUllkNC8zTW9k?=
 =?utf-8?B?WmZaS3l5ZWRTU0tkNXJtZmIxMkVLLzdJT24yeWkrSitTVEMzU3Y4SEQrQ2ZL?=
 =?utf-8?B?YmhBdjVrUENrY2k1S3JhcG1XSkM4VFJrdStsTCtBVzFQQjVqQW9Zem9OYjVW?=
 =?utf-8?B?YUord1NJRzRwVE9XOFJmeEczS0ZGVU1odzF1TWFvY2I1OHdtTHVKM21YYmMv?=
 =?utf-8?B?K3dKRnozUExiWGpMSnN2eWtYc3BwUnlKK1l0bjFlMGlNbVZ2NWgxcHdMVkJp?=
 =?utf-8?B?Qll5ZkFrblZoeHcwWHNPYUw2OUZvZFZrUElHQ2pyUDA0V3RKeUEvWG9PMWV3?=
 =?utf-8?B?TWRFRVJmMEU3ZEo0NFdqWTg3U01wbEc5WXZpOE9QQzluK3ZTSHBaZm5TUHdT?=
 =?utf-8?B?UktQT2JUQ2Y0bldpQVZFTithby9YVFR4MUQrYmZlTDMwM2tpV2MyTnFZTFVr?=
 =?utf-8?Q?G1SKrKAqVUTHS3mQhVfonT71h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0916886b-50d9-47ee-11d8-08dd7b39e3d1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:51:12.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHdRadNon/NGzC925bAVR/KBexvBk/X9NoIVVsQn6Qyz03/I8EjA0FhCzcoiz8o1LwZctfho7xX5HH7uHSc+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

--------------nzPBNibB0FOrUFJqRYE0RvP6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I feel existing implementation makes more sense. Using the disable_kq 
flag to avoid get/put completely. Get/put for userqueues only here and 
for kernel anyways we are handling in ring_init.

if (adev->userq_funcs[AMDGPU_HW_IP_GFX]), this if condition will always be valid once we enable it based on the fw version. so this will be an additional loop and get/put when kernel queues are being used.

Regards
Sunil Khatri

On 4/14/2025 3:12 PM, Khatri, Sunil wrote:

> This is how i see the future of this code and we can do based on it 
> now itself.
> disable_kq = 0, Use kernel queues.
> disable_kq = 1, Use User queues.
>
> In case of kernel queues we should not be even calling 
> gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we 
> add a this check "if (adev->userq_funcs[AMDGPU_HW_IP_GFX])" before 
> calling the gfx_v11_0_set_userq_eop_interrupts. I am assuming there 
> wont be any mixed use of kernel|user queues together. Let me know if 
> you think otherwise. Regards Sunil Khatri
>
> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>> Regardless of whether we disable kernel queues, we need
>> to take an extra reference to the pipe interrupts for
>> user queues to make sure they stay enabled in case we
>> disable them for kernel queues.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7274334ecd6fa..40d3c05326c02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>   static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>   					      bool enable)
>>   {
>> -	if (adev->gfx.disable_kq) {
>> -		unsigned int irq_type;
>> -		int m, p, r;
>> +	unsigned int irq_type;
>> +	int m, p, r;
>>   
>> +	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>>   		for (m = 0; m < adev->gfx.me.num_me; m++) {
>>   			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>>   				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
>> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>   					return r;
>>   			}
>>   		}
>> +	}
>>   
>> +	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>>   		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
>>   			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>>   				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>   			}
>>   		}
>>   	}
>> +
>>   	return 0;
>>   }
>>   
--------------nzPBNibB0FOrUFJqRYE0RvP6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I feel existing implementation makes more sense. Using the
      disable_kq flag to avoid get/put completely. Get/put for
      userqueues only here and for kernel anyways we are handling in
      ring_init.</p>
    <pre wrap="" class="moz-quote-pre">if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX]), this if condition will always be valid once we enable it based on the fw version. so this will be an additional loop and get/put when kernel queues are being used.

Regards
Sunil Khatri 
</pre>
    <p>On 4/14/2025 3:12 PM, Khatri, Sunil wrote:</p>
    <blockquote type="cite" cite="mid:4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com">
      
      <p>This is how i see the future of this code and we can do based
        on it now itself.<br>
        disable_kq = 0, Use kernel queues.<br>
        disable_kq = 1, Use User queues.<br>
        <br>
        In case of kernel queues we should not be even calling <span style="white-space: pre-wrap">gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check &quot;if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX])&quot; before calling the </span><span style="white-space: pre-wrap">gfx_v11_0_set_userq_eop_interrupts.

I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise.

Regards
Sunil Khatri 
</span></p>
      <div class="moz-cite-prefix">On 4/13/2025 9:36 PM, Alex Deucher
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20250413160608.2198429-1-alexander.deucher@amd.com">
        <pre wrap="" class="moz-quote-pre">Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7274334ecd6fa..40d3c05326c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					      bool enable)
 {
-	if (adev-&gt;gfx.disable_kq) {
-		unsigned int irq_type;
-		int m, p, r;
+	unsigned int irq_type;
+	int m, p, r;
 
+	if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX]) {
 		for (m = 0; m &lt; adev-&gt;gfx.me.num_me; m++) {
 			for (p = 0; p &lt; adev-&gt;gfx.me.num_pipe_per_me; p++) {
 				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					return r;
 			}
 		}
+	}
 
+	if (adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
 		for (m = 0; m &lt; adev-&gt;gfx.mec.num_mec; ++m) {
 			for (p = 0; p &lt; adev-&gt;gfx.mec.num_pipe_per_mec; p++) {
 				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 			}
 		}
 	}
+
 	return 0;
 }
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------nzPBNibB0FOrUFJqRYE0RvP6--
