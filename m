Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DACCC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 06:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BE810E33D;
	Thu, 25 Jul 2024 06:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdOBed/E";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312E410E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 06:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT/8sllHAYoIH2Su8Lzwz9/AxNj6R+5527gEP+z+6ZWc/S3+Zh/oIp5fCpYVdS78+5nXJgZG0LBoThcTFaqFWe/Y1T0iFMUqKbaDnL6DHC7wYcHMmTiZWNzygjk5pt5Jl9RvBUQVfpQirFc9vUFlM1gagPpIr/THCbrU4J05iMio+jMXw5kMd1loStkNu7q/Py44s4D2c/VR1dwb9exPuCfe/ktL72ezK8hlmEkqI6BHaT+fETxyE3zjq2IJfa1sKm/l3Wvi7J5Q60iErWkynHlGGugJlZWBXSNsTHjN2n2Uaw1HZ3vvW3oBji1EUGbevuuGxHNp5NDP16p/wWsvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uteVoMyVNODs+Gz9FZxE+kcKwI7ZAQzHYxI+RoTgOYs=;
 b=p/9M1aNJO0vo3etel+hx8Vt7CUD9C0mWfV+zh1/Hxt32mvKjO12kHephyvV6h1h4I+End6GC9co+9fBv9rguDlReAu1M38hcg7opwnQpMr/132bxcTn61P/qpYaeFqHW3EASbxoF9EJO1Vv4Z79FctEEHxJcAZUuX80zt+jd0UUosoacLm684fRNrvoAXX74JaQ2JJ22Y68mR32Z8JSN9B8QPM9JU8TjyzF0qvC2VAcOSoXWXD8IkkdeQU8EF6OWmiJp/kG6WfpM5gocs+yN+xSZoT2qNoq4acu1GgsYVqGVgQacckTSwOGwQoYAdKQiG6r39sy50CXxFHZelENjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uteVoMyVNODs+Gz9FZxE+kcKwI7ZAQzHYxI+RoTgOYs=;
 b=DdOBed/E0Y8hDflmTGMCV16KJkrgMw0bt/JBQX8DRvE269TRJCp7ChaAYBeDux0T5O6bTKeV8aI8yQcHGlQtmqGFY889d8kKgU9LRlIWE8iAW4MkEx9ALwoPlmbGRiXrYPIpPcIeVmGr2E2hPNrNO4Hi84RRf3Kw8Ual8fvpvzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 06:23:21 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.016; Thu, 25 Jul 2024
 06:23:20 +0000
Message-ID: <a2f30e2e-37b5-4df7-b586-a779d3ad5b88@amd.com>
Date: Thu, 25 Jul 2024 11:53:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/amdgpu: add vcn_v3_0 ip dump support
To: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240724113250.2707693-1-sunil.khatri@amd.com>
 <20240724113250.2707693-3-sunil.khatri@amd.com>
 <CADnq5_My4-7NdE7Rp4-J4T21o6x-ipgVWC00RNdwNiu-VTJ2BQ@mail.gmail.com>
 <28e697d9-ed63-4d7f-9299-4671d6e302da@amd.com>
 <CH3PR12MB7762AA45BAD40D4CE75D39E0FAAB2@CH3PR12MB7762.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CH3PR12MB7762AA45BAD40D4CE75D39E0FAAB2@CH3PR12MB7762.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 408a8be5-2af6-4eeb-7497-08dcac724774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXdsM1h2VUlqcG0xU0ZkSlFRczh6Tm1PUldmc0ZmaGk3SGxrWElaa0E3ZG9I?=
 =?utf-8?B?WWdIKzlpNXA0bklBU25VcTN0c1VmMnl3Y0xhWjhleHR2VVNERkRFTzNYNjhQ?=
 =?utf-8?B?cWZnbGpla1hNN1dEaUg4Vm5HRmZvL0NwNlYrdU84cHU1MEZZVGV3eDMrUzEv?=
 =?utf-8?B?TnFwcDZjTklGNUIrQklsZTRoOXBzT25sd3oyNlpSRFpLbmsyQkJKZW1iYlJX?=
 =?utf-8?B?Q29YTGxOVzRVSkJyZUs2ZVcwR1ArYzVYUktBWUU3SkkyVWxSMElrNWRxeGFo?=
 =?utf-8?B?YmxYbE4vVTRCR0xqYlRja2FTMm0zdUtuUElDNlFsTG5QNVFZaDVHbjdFdXRX?=
 =?utf-8?B?REdXeGt2dlpxSzNDMDBrY0ZqUlFEZGEyNFFEenZhVzhHbkZYZjhrU0lKblhD?=
 =?utf-8?B?UWMrSmRTdXZrbkxQRjNQMmhhenc3S0ErdVZYY2laSlNxU0lucnRDaHY2Qlll?=
 =?utf-8?B?NldjRkI1Tlp6WUZPbkwvRXZGTG5iS3p5dFR3YWFIUEdpcDdhejNqU0Q5c05U?=
 =?utf-8?B?dGpEYjcydEpQV1Uyd0lPWkhvbUloOC9BMVhPQVBReUF1ckhBRFRGWEluRTYz?=
 =?utf-8?B?ZmtmM1ovNW5EL3NhSkRUV3NVT1FmQUtZQ011dHJ2Y1plU3QxVlM5NHlVZEtO?=
 =?utf-8?B?a0o0WldrcTF4RUFXc3VTbExGdUVHSSs4enB2NVJtM09DeDFCZC9UemorSllW?=
 =?utf-8?B?eFUxNzlQSWpVZlJWanVjMGQ3VmZyUmxzVHVXenpoU2NPSGZseGhjS0lPdGRI?=
 =?utf-8?B?TmZ0YXNVejQxYy9sZGIzRytVWTVHRk5wNkJqZ3FiVjBZVVZFK1lGNlpNTjdL?=
 =?utf-8?B?c3hpQkduNllQZDhzUGczT0NWa0kveFhRcjZ3NkxnUjNET3dBV0VrbWZQYm9h?=
 =?utf-8?B?Nlc2YlNGcEgrd242TXppZWEySDhKUUd4RzVsbVoxZFk5eFFEaEMveDJOUWFT?=
 =?utf-8?B?d3RmOXZESk5kZ3V3bCt4OXpRZFgwaUl0VUM5Si9XU21JUTYxUEVHVDZ3YzFW?=
 =?utf-8?B?N2RMekxSMHFjNm9CNkJUVmVsMXFRbEcxMyttbElUWldzUGlMMmdJQ3hOSHRw?=
 =?utf-8?B?S1A3OTd1cWhHbFV4RmhYM01aYkF2YkwwSEc4QkFSam9iWEt4aVRkU3NOMG0w?=
 =?utf-8?B?Rk5JNVV6UTdDVU5yYjBKYW1mMWlxaEJPQjRzdXFHYnRaaldSNm1sbHRzM2NU?=
 =?utf-8?B?T1B0MkZ1SHJHUXJYUVhvYUN0SE11UDYrZ0VvWnVRS09Da3dYN2M2S1ZnU0VG?=
 =?utf-8?B?OVc3dVpQenlhbVhTYXdOOFU3cytPc3lOdzVoTnVhOXc3Z0RkaENuRHVnU1py?=
 =?utf-8?B?S2tmeTVnZlpKVmdaejBqdUY4bmo4K3hjdzhSeEhDb1FRY1NYUVV5TUU1eVJI?=
 =?utf-8?B?cXpMRWhhMUNOZ3hTS0QweFdhQk92ZEhRN0ZwUDJRcmhCZnZEai91MkpOL1RF?=
 =?utf-8?B?a054c2twZGZQYUVqSzRkWUdMSE5aR0lzUnB1VWhVc05WeGZIcHBXRlJRaFpx?=
 =?utf-8?B?R0dJSW5vYmtCc0lhVTBhTTZqRUNNZFRvQ2ZIZmo3NzkvMnVaanN2K2NPU1dU?=
 =?utf-8?B?bURVTFBYY0VGS2w3N3dtTGRWdG1rZWVENERaNWszUGtINGFSYzJjOVU2d3JZ?=
 =?utf-8?B?NHBLVk5vSEdZZDUvalVLbXRMVnBudC9mN0RJbE1idGtOSG8zazVybUJkM0x0?=
 =?utf-8?B?ZjBpcFNGZFh3aWZhU3dBajFrekRFSUM5bmJ6RnhwQ3pHOTVmanV1aHdZeHRj?=
 =?utf-8?B?TmRpT01IRU02MVREOWU2amYvRVlvM0NKUzB2a3pybEtKeUQ3VFgzM2JocnFG?=
 =?utf-8?B?UW5VYU5JcmpiRllVSVhSdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJvUWR5N1Q1V3lybEozVlBUMnNqeS9oV2xnNzB1MytJYnlXU3ZCeXN3NU1k?=
 =?utf-8?B?TWpSQnk1Z3RseW9PbEpSOEZYR1p4dC9yQkVxYmpiRExFUFJBeHF2d1IybXlh?=
 =?utf-8?B?UlBLcmNiQVV5Mkl5Q3d5ZXVjZkd0dHF1UGRDVEJzbExBRjVpbWF1dXVIbnlq?=
 =?utf-8?B?TmVRQUFaWjVHREx5NnN1akVaT2QvTSs5a2dXdWlBOUJYeFROWmxPUnhYeW95?=
 =?utf-8?B?NG5SNThHOGkxNm4xNElOVDQvVkJTbzNCazlMaVVlYS9xdDBBRDd3T1pOcCta?=
 =?utf-8?B?V1BpR3RnbVNJRVJiQ1cybm5YNHdETzR5R0FwWTYxY3c0clNWMmc2aFR4N2Vp?=
 =?utf-8?B?amE5RVFFRWNnbTlXdFE0czRIdURLZmpMUTFCekFmSnFiZVBlK2gzbUdvNnFF?=
 =?utf-8?B?cjdWK0JHYnFBellCWmx2VTI4aGtTMUs5bXlhTSs3Lys0ekkybDlzN1g5ZEFl?=
 =?utf-8?B?NmhMeDJyeUxBeU5Eb25aMmI1MFdPcllnZVJDYjdmb3BMRFhnelZqL2I3MWtG?=
 =?utf-8?B?TWRVK2NYK0w5R01tTUF6bnpZdjBlZmdxWGFrYWVrZExOcklWcnpFQzFCOEhU?=
 =?utf-8?B?RG9DL09XazNsSlBOek1zTklJOGwyL1RLNVJqbHU3WkVyTE90d01jZnVmWGhk?=
 =?utf-8?B?b1YvQzg3b3ZFRGpLbi8wQ0Z0L05yNkJvQ3F0U2cyZFl4MVp5ZURiVTVWcS9m?=
 =?utf-8?B?b0YxaGJQZURFQ0drajB6cEs2T0xUdFdybi9KK016cjJDc0xGb2pqQ3loZU9R?=
 =?utf-8?B?dGl5ODRTUVlkYUxmcEw5aFpXeVMzVmRBM2JIUVpDTTRRUmZGN000Nmg3YVBN?=
 =?utf-8?B?Nzd5cUYyMGFYYlB2SWJ2d3kvYVE1UlVRZ2dhZlhqTGNzMXd2VTEyNVZuNmxN?=
 =?utf-8?B?ZGFCdWRNUUt0YU1yaks5eEE2UnZqM3NBdFlVTVArUGpiTklxMWltTUJRTHNx?=
 =?utf-8?B?MkkrVnV3Q3lERHdDN2ZkM09nSFFDalJ3OFRYSUgxc3g2NjgxdDZzQWZCRFlV?=
 =?utf-8?B?VGJsc3dnNHdFdHJCdndhRG5INTV2c1lZOEhMY3c0NHVYdGEyUVVEMkNnZUlv?=
 =?utf-8?B?ODFDNW1GUjFBZlEzRjRMYUtHemo4QW51b0cvdVY0KzlWYm5ZZmJmWU5vdFk5?=
 =?utf-8?B?dnVwSkJVc2xyVk45WXk5WlVQQ1lJRjlLelJqMGc0RmdocVlNZkUxSnZ1QmZR?=
 =?utf-8?B?ckJZck41UXlLc1JWaCtFd2JMc0R6Z1N0OVNLcEpYekc3ZkZGSGRacTJxbG40?=
 =?utf-8?B?eDBNVCtCRGxjRityaXB4cFZvbTBSbDFuWmhHZXl2Y2VuaFdUc1NOM0Z5U2JC?=
 =?utf-8?B?S3ZEakRpdVZ3MlhtM2M1WGRoUC9HMUduMUpiZTZKdlVzUHBIVHNEWXBIVlR0?=
 =?utf-8?B?MGkxM0JmZDltOUlJbExFaUlPOUE2L0RJd3JpZjh6OU42d0JuTFZvVk9jeUVW?=
 =?utf-8?B?ZW51SlNKdFE4d3EralpzYmkydUlrNE9YbVFtRnBuODRXeGRZbW5KblBVRmxP?=
 =?utf-8?B?R2hnU0hyM0ZZWDE5UUxSR0wzRUJoU0VTYUV6VTFEMDBNZE9qSE9DZCswYS80?=
 =?utf-8?B?N2N1NUNFd3JOMjNTTmx2M2h1R3ljNlBPSXdCVWtNd3lpVklqOXNVcDhia2Ir?=
 =?utf-8?B?K0hERXhoLzE3VTBjbGNNSXVDbXJMZjRPTG9jRzBwYm0vd08rdEVLVzdPRkJZ?=
 =?utf-8?B?bnlJYllTdW8zSjdFR1NhNDJZM2tQQlN4TWlLYklmZzZlcmlLMGRjOENkVWI0?=
 =?utf-8?B?WU5ETEd1MFY5N2Jsd1hFQ1FTSUVtUEovNWVHYzlFeHROZkx3ajBCNU1rNnZQ?=
 =?utf-8?B?L2Z5Q3k3akdNMmJvRFZ5OVNPRm1zeHBDNWF0RmdDY0xmZzFQWkQwdHBqa2FV?=
 =?utf-8?B?bmlHaExodUlVcUpHZG5jWGpBQXBBQjV5V1pZVnBpSjV1OE13T0I1MmVONnRz?=
 =?utf-8?B?eXVhZ0Zwc1lSVnhlcnJWc1dpRlphRlczeDJmT0FqcXJDZE1nZ250alR2MFNr?=
 =?utf-8?B?UlBuUTkrVUtraDFrM1lpQ3dTMGp6WGYrdnhyVUl5MWZxZStBRWNRVVQ0Qi9q?=
 =?utf-8?B?Wm1EQXBwem9DRUR5VGx2UmtmWWhyN2d3akxNQzIrcEIwUHc1cllMQmZ6cGxV?=
 =?utf-8?Q?SN3liGULjUjyMYJ9tHtwEuTeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408a8be5-2af6-4eeb-7497-08dcac724774
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:23:20.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kv24xs5Cx8OPrrTWXQTm3l+2WGXgEC7eQapIihKPpOCCLKLAs+sxVZg1XOPC5ITngp/rFUyqgqQUMQdJ4+PSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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


On 7/25/2024 10:58 AM, Gopalakrishnan, Veerabadhran (Veera) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Khatri, Sunil
> Sent: Wednesday, July 24, 2024 10:00 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v1 2/3] drm/amdgpu: add vcn_v3_0 ip dump support
>
>
> On 7/24/2024 9:33 PM, Alex Deucher wrote:
>> On Wed, Jul 24, 2024 at 7:33 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>> Add support of vcn ip dump in the devcoredump for vcn_v3_0.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 149 +++++++++++++++++++++++++-
>>>    1 file changed, 148 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index 24f947751c46..544b46ad55bf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -60,6 +60,115 @@
>>>    #define RDECODE_MSG_CREATE                                     0x00000000
>>>    #define RDECODE_MESSAGE_CREATE                                 0x00000001
>>>
>>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RBC_RB_WPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CONTEXT_ID),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA0),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_DATA1),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_GPCOM_VCPU_CMD),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_RBC_IB_VMID),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_NC_VMIDS_MULTI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE3),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_CONFIG),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_PGFSM_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SOFT_RESET2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_GATE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_CGC_CTRL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_CTRL),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_LO4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_BASE_HI4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_SIZE4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_RPTR4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_RB_WPTR4),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_STATUS2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SUVD_CGC_GATE2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_VCPU_CACHE_OFFSET2),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_STATUS),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_LOW),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_LMI_MIF_REF_LUMA_64BIT_BAR_HIGH),
>>> +       SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_SCRATCH1) };
>>> +
>>>    static int amdgpu_ih_clientid_vcns[] = {
>>>           SOC15_IH_CLIENTID_VCN,
>>>           SOC15_IH_CLIENTID_VCN1
>>> @@ -126,6 +235,8 @@ static int vcn_v3_0_sw_init(void *handle)
>>>           struct amdgpu_ring *ring;
>>>           int i, j, r;
>>>           int vcn_doorbell_index = 0;
>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>>> +       uint32_t *ptr;
>>>           struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>>           r = amdgpu_vcn_sw_init(adev); @@ -246,6 +357,15 @@ static
>>> int vcn_v3_0_sw_init(void *handle)
>>>           if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>                   adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>>>
>>> +       /* Allocate memory for VCN IP Dump buffer */
>>> +       ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
> <Veera> Did you mean to use vcn.num_instances here instead of sdma?
Yes, thanks . Will update.
Regards
Sunil
>
>
>>> +       if (ptr == NULL) {
>>> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>>> +               adev->vcn.ip_dump = NULL;
>>> +       } else {
>>> +               adev->vcn.ip_dump = ptr;
>>> +       }
>>> +
>>>           return 0;
>>>    }
>>>
>>> @@ -284,6 +404,7 @@ static int vcn_v3_0_sw_fini(void *handle)
>>>
>>>           r = amdgpu_vcn_sw_fini(adev);
>>>
>>> +       kfree(adev->vcn.ip_dump);
>>>           return r;
>>>    }
>>>
>>> @@ -2203,6 +2324,32 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>>>           }
>>>    }
>>>
>>> +static void vcn_v3_0_dump_ip_state(void *handle) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +       int i, j;
>>> +       bool reg_safe;
>>> +       uint32_t inst_off;
>>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>>> +
>>> +       if (!adev->vcn.ip_dump)
>>> +               return;
>>> +
>>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>>> +               if (adev->vcn.harvest_config & (1 << i))
>>> +                       continue;
>>> +
>>> +               inst_off = i * reg_count;
>>> +               reg_safe = (RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS) &
>>> +                           UVD_POWER_STATUS__UVD_POWER_STATUS_MASK)
>>> + != 1 ? true : false;
>> You can drop the ? true : false.
> Noted
>>> +
>>> +               if (reg_safe)
>>> +                       for (j = 0; j < reg_count; j++)
>>> +                               adev->vcn.ip_dump[inst_off + j] =
>>> +
>>> + RREG32(SOC15_REG_ENTRY_OFFSET(vcn_reg_list_3_0[j]));
>> How are you handling the per instance register offset?
> Yes that i seem to miss. Using index only we have to do it. Let me rectify it.
>
> Regards
> Sunil
>
>> Alex
>>
>>> +       }
>>> +}
>>> +
>>>    static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
>>>           .name = "vcn_v3_0",
>>>           .early_init = vcn_v3_0_early_init, @@ -2221,7 +2368,7 @@
>>> static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
>>>           .post_soft_reset = NULL,
>>>           .set_clockgating_state = vcn_v3_0_set_clockgating_state,
>>>           .set_powergating_state = vcn_v3_0_set_powergating_state,
>>> -       .dump_ip_state = NULL,
>>> +       .dump_ip_state = vcn_v3_0_dump_ip_state,
>>>           .print_ip_state = NULL,
>>>    };
>>>
>>> --
>>> 2.34.1
>>>
