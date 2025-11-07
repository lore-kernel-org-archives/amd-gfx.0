Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0C2CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B2110EA51;
	Fri,  7 Nov 2025 09:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mcNpsTeq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E1310EA51
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC6f/yNtk0VTcyXQPbN6ajzPLhO8Ui5+SJW2nEGb3VYLUnVfXFUZuLgRfHiuW7R1zkt4fGRccXNZXOxknD+75Upek84cYwCYXwqWk5GEfqLRVbnhcB7g4d/Uf0Q5ecgBzKU91AUUsBkaQBk5YEVJp19cxXnMpVeAbxZHx9qaPq6QivF2rj8fhLColvOdEAPOMlN10wWl+svk2qUtDzieXHqS5FSbQv/0r6G4Z8n0bxmxf1TPVg8M8jKFkZIugukbq5NoeQc9hdo50lwZkThx7kPZxDwcn/oH5GZpN7HYr69Q2jmmh0u0Uv+2b4im0vJuX5JossaBAp83CgXvzw4NCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oMQKpdsm2TO7hA206+6cg9b5ohw4O2BAjItrEi+4mE=;
 b=ctrFAhg5pn7zisSw3LcZ+rwVP7qp3tP5R42lTitPSGZx0TIDuwNMIsmoUA/zPg8nEtdyvpwUwvLKClAEWmf8efhzNtuEywIMiTj8yWsEphVWEuFdifMjL89sB6UZ1tcJXLUpjBDQ8s3WqJ9eM0INwNbf/0ToziHukZNnEYzkCvdRWlO69vMvFEGiTp20+9yITWZlXYrqmTJTmQNPwjjSov49Um75rptC9yLxkM3wDWjOVcslMIQOdHLvxBnKc3ntkyxhJgh2N4hrXTbg+Jifh7wEHZ5cfSesQv4hS9xkclEqrRaQ5OHuFocn4BoyzHc5lQa7A9dVLP0QiNCVh/SX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oMQKpdsm2TO7hA206+6cg9b5ohw4O2BAjItrEi+4mE=;
 b=mcNpsTeqQpygNmtVQ+MPxBuBlMGk6ZtdEBZoj5mNOz77gUleBJWEEdvBgew+sHL5vqeRHc8nH4rvUIVumrKc7iGt7gM8aftzBeucdGBVE8GlcaohN04TJnnGjHnuzJEUPKN1fLfB83A5UL/mXl7LzrypjFzeAWCDFMOj4xBW3JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:41:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:41:00 +0000
Message-ID: <4b344c4b-6e87-428e-bd7c-0da465361c90@amd.com>
Date: Fri, 7 Nov 2025 10:40:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit
 address space (v3)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-11-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251106184448.8099-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 157a42f1-629d-4331-471e-08de1de1c260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEt6aGdZSVB5cUpFdXlucWQzQzBWNXlNWXNOblhhSFpMaStpZE9Vc3hoUzhr?=
 =?utf-8?B?amxwMlQ2Qng5Wld1UDBOd0Nmbm9xejRqcnNxMjlXMWlPM215Q09yS1NIOWhP?=
 =?utf-8?B?a0d4d2VEcm4vMzhGdkpucS9MdXVOT2tyQVgybDFtVWI3OXNuUHgyZUh0dHZz?=
 =?utf-8?B?NGo5a1NaZzk4bDYwSlBZS2JCV2xJekdWYzA3NmJvN3k4WW1zSzU5alZhSklU?=
 =?utf-8?B?QmFGdHJ0L0grQ0JUN2kwRDk0Lzh4a2d5QWo1dFRyT2pTb2M4bXFrYVduVVJH?=
 =?utf-8?B?TStYbURhVWZCS1hWcFZDUWttd2NOOHBNUzViQjVsQ1drd1RjMTVCYlVJU1BB?=
 =?utf-8?B?eWxsOU84cWNYTVp1c3d0RmQzdjJDQzcvMUtDSEFvS0lxVUs4aUJuQ3VCUG0r?=
 =?utf-8?B?UUY2VHlVeHZxNENMbWRKKzNMcHhDUWoyb0NGbktKWFJZeTV6QVkwYWxsT2wr?=
 =?utf-8?B?TTczY25udHlkcTcxUGpYdzFURUt6YUxnMXFTRklYT2QxTktIeFY3bFY3KzJk?=
 =?utf-8?B?U3BHalhlOUdnbkR6L1V1dzNpa1Vsa0x3cVZjZU5tLzFnQ0F4eHNBUmFxU0pa?=
 =?utf-8?B?M0t1R0JZc0tsZDJ0M0hDd2tnUGdSbEUyclJ1b1pkdGYxQlFYb0RKQ281YmpN?=
 =?utf-8?B?dVBKNFlZU3FUMVFvSVV2OFg5Nk9WVHF3aGxZREM0d29FTTJFN000TzJEZGxF?=
 =?utf-8?B?bWszTC9seVJtYlJnYUFEYjdHOWtncFZOYTllQnZDM0xjVWdtanNIcHdjamp5?=
 =?utf-8?B?UTlHZmQ0UEVwbDNUNUMwMkVwb2NpOUZTVG1KK3lWeVlyZFhTNWpNaFE0eEgv?=
 =?utf-8?B?Vk1DQUlocnZ1cWt4M050ZHZvbUJkQmcrRzFPWEtJakhlN0M5Y0dHOVhRQzJE?=
 =?utf-8?B?Qm9TSERCTWY0UHdBSjdXcnllT1FkblhYOFZDbUdOc3FpTHp4akdKam1kNVMw?=
 =?utf-8?B?c0M5MCtSMmM1S3VVS1JnbzFyVVc3TC81K1VpWjR5alhqOC9zcVVZS3JRVno0?=
 =?utf-8?B?T2ZSYStBSGs1ZGxuaENYb1pUcGkrZkRheU9LbmE3dDJWOHk5QTFvVnh6TkN1?=
 =?utf-8?B?K2dhc2pZc21ZM0tjbnpETG14Y1pHZ1FzVndMdVozWmwwNVBzdFBwRVlYdjk5?=
 =?utf-8?B?b2ZoN29oUDVndHBvK2lCVVVOaGdNMEpjeFF1NlNnd01YQTBoVEx5Tk9oMzYx?=
 =?utf-8?B?Sk84L3A1dGJrWTlsQmVZZVRkdWR5V2dzd1FsU0x5dkM4b0hPUGNTSWVaZWtp?=
 =?utf-8?B?YmtCOWFQUjYyWGV4TGNkUHYyWGI5dThHWDBhcUwzdDh2MEQxeEw4aHFUZU4x?=
 =?utf-8?B?djVNbnIyVEw3SXJsdStaanBxaktWUnE0NktNNUo2bkpzOEh2UUFUT1FjSUhI?=
 =?utf-8?B?c1lFczZTdzg0RE1VMTNIYnFNUjRtaUhEeWpzemVqNGxIZklWaTZFaldrY0xL?=
 =?utf-8?B?NXhkc3B0NHdJbDBUbVRnN2NBVzl5RVdxQ2RoQW1aV0RsRmUxejRTcVhQdGd3?=
 =?utf-8?B?a3Q2YzNmVkJOYnp5Z1U5TGhSYnlXclRLMEhjY1o0WlFENFp0Qlg5UTJIaTFv?=
 =?utf-8?B?ekdSQWZjK0R0UTFzWkpSbGpLYnpLU0thL2Y3L1V5OG5pSTlyM2I5Ykd5K3FT?=
 =?utf-8?B?WkRSNUlTN2hKYlVNRlhVejA0R1ZoVDBMRE5CTFpuUXVjaHBNcWNaNTJ4Rk9l?=
 =?utf-8?B?cnZvV0gxWDV0Y1NNZ2pLb2hVTVYzQnlNaUZ2YytMRXlvN3AydlBjYjZpQnVY?=
 =?utf-8?B?bXdMTDlYQ0huQjFDVzZxb3hSTCttNXA2amFlME8ya2pSRHk1bG9Rb1lHQ2Fz?=
 =?utf-8?B?VmFVUzN3eUpWWU1HUnJUVkRIeStabC9WSTlFeFBFRDdQdW9PdUp4aDRWNkFm?=
 =?utf-8?B?Y3l6b202NVQyTHZYQ0IzQ2ptazZraXppZ3BIZDBOdkZkSU85Qy9qUXpUUlBI?=
 =?utf-8?Q?qKuS/qUSWPhjTmXurZDul6smOWr/ApFU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlh3S2JPc1lJaktScHBUeXcyZitETDRlaDVIWVVHWThCQmM2dHNJR0JWRCtU?=
 =?utf-8?B?TjFYK0NxM3gvc1VMN0FFM3l1YVI5Z0VyVmVzVEIwclBvYWRIcVR3TG0wMGRB?=
 =?utf-8?B?dlVMblh6cko2aytLYVBPV3hLMm5kWU4wTUgzOG1RblZIVmNQcU81cmU2TmtQ?=
 =?utf-8?B?NU9IK2FyK2VIN3IxUmgyc2lLUDdBL05iUWRpY2JSSFNYWDNCaDNrTFIxMlZv?=
 =?utf-8?B?aytxeXdoSEorTmlPQXhTMlJDY2M1RkY0c3ZsLyt0SEdWdE1YNVk4OW13T3Zk?=
 =?utf-8?B?blZSK0tLODY2bXdvOHVvVmZMaFNhYXJLeDc1WjNhcVBPanRZVVJXTUI4SXht?=
 =?utf-8?B?SWQrWGpGN3RFVzBNd3VnSzJsWlhBSFZOb3dQZFVxeElQdm1sOFRNdFV0c0xS?=
 =?utf-8?B?VTZUQmtSK1g4aTduSFJXMFhVck5pTHdmTU5SNForU3orUVN4VThUWTY3d3pz?=
 =?utf-8?B?U2VBN042bGpaaHdZNlN1a3NxR2t3WWhsSzhMTzQ3WkUvaTAyejRQeUZzaDBK?=
 =?utf-8?B?UWxheC9QTkY0T3J4VmxJUWQ3S2JvbW9zTyt0emI2c29sci9iNk1uN29RQVBl?=
 =?utf-8?B?RVNxYUp2bWtEVURYb2g2RTBaRlJFb21VMDd1ZTNkMDJEdThkekRHZWF5UFFn?=
 =?utf-8?B?UUdCRUhsa21ZWVcrdU5TdkZ2anR3RG56Z3N5cmMvVVhVNjl0bHZ2K3ljYUFS?=
 =?utf-8?B?WW53MWpBN3Y1dUJndGtoY00ya3U5SkRobTNuaFFWM2FoaFBZT3VuMDR1b0RV?=
 =?utf-8?B?aWlEbVlzWVo5ZENxM0ZBV2pyZk44VHphWHV0emVySCtCL3dZS1hFUERicFBW?=
 =?utf-8?B?VmdOSExUSVRRUmlNeEY2WWJTMXZGdE1EQ1l2TUFqVzd6Q1hhYkdCc1ljVkd5?=
 =?utf-8?B?WE9vbzJUaVQ1NTNiUlIwdUF1ZWtFcEpua1lVNTJVdGM0SHZvUWk3ajBFeGN3?=
 =?utf-8?B?VTFPY0c2MmN0ZHVzZEFTVjM2Mm9BZms4UVFFZVZleGlpWkpqb3huVFhDemhK?=
 =?utf-8?B?Y3Q5dC80dTlpc29aaXcvWmxQd3J3cmNDSmdMZEVENTR1bzRLTGhPc0FpNnNu?=
 =?utf-8?B?NGF5NmYwbWlhOXZVeHBJejYxZ0pzZWNRbmRET08xQWRlNFQydlY3MjRwTDcv?=
 =?utf-8?B?ZGErd3RvdmFoUjcweVNuMjh1WlZTYmhXUjFMclNESFlxeEFiVDcvc3JjcC81?=
 =?utf-8?B?WEM1c0s3S1JrWXhGV0VpOWVqWmxTWS9VdGduY2tsTVN5TFhYNzJNZDdZTkJw?=
 =?utf-8?B?eHFYZGcwelVUaEI0c0VYSDRHS0RaUzhiUlFNOUlrSm1vZDYwRG1jejlybE1O?=
 =?utf-8?B?VlJjbVdCNGkyN294WjZTUWFaM0M5WU5reG4xZ09Fb0JNUHFKN0czMGltRXRy?=
 =?utf-8?B?R2FGUE93Um16SmpjRFc3RGZjYVg3cmpQL0ppemQwdENtem5tQjUvbllDdGl2?=
 =?utf-8?B?WXVvSzhGL0dOazZrSzNTOTFUKzhaM2pmUjZWaUlPMyt2RTBmaThRdjArWmpa?=
 =?utf-8?B?TnE1TkpUTkROMnVlY0xhSXpmWU5hbEhSRWxTUGl4dHF6UDVCOHRBUlpKZVBh?=
 =?utf-8?B?d2E5bm9SZExSekhXbDlXdUdlYmV2amdpQU41OUdCMUtMRU1IQWppRXFISkQv?=
 =?utf-8?B?NzhhNDZlRW4xYTlSb0FyOXBRS3d1UVkzRXF1T1QzUTNHU2JaOGtDYXJxNEw1?=
 =?utf-8?B?Um0xTVVtdHRhZnBDVnpFcDFtTndhcE1HckkwcFZXdFl1ekh4RE1CbVdmcXBI?=
 =?utf-8?B?cGptNHVKVXpaM1VQQUF4UDVmTGd5WEtDOTNJUlptWUI5RWFyT3ltNHcyZ2JU?=
 =?utf-8?B?WXg0VGFhVDVCYWx4a2ordEVaWU1SR0JQUVJ0eDdxVHpkVEc3NUJKdVoyZFo1?=
 =?utf-8?B?cmRza0RSMUkvcit1UUJjNTNaZzhWOFdzY3RNSkZkQnFVZHFPMDFKRHczdC9v?=
 =?utf-8?B?ejVqZVRNQlpHUlBZSkZ0cUtSb29PR3IvZzU1TlNSb0JNcVA0WmszYVdxczk1?=
 =?utf-8?B?UXAxZ3VOV3oyYWpMamF3WDA2TmM3QVBzSFJ5amVaR1NELzBTL0Y1aGlHeklr?=
 =?utf-8?B?YnNFNTRrREJwVEs5Z0tJQ1F1SEVBVE03eE9OQ0RaeXlUenBjNEF4eW4yYWI3?=
 =?utf-8?Q?7HHf17y0F+zatVZ0u9M9VUoXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157a42f1-629d-4331-471e-08de1de1c260
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:41:00.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr3+vKHDMrj38vpHohAdm5ifBjvo9Ss0hFlvDjZ+YJxjRpiIYfck/o+hya+8bVG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

On 11/6/25 19:44, Timur Kristóf wrote:
> Based on research and ideas by Alexandre and Christian.
> 
> VCE1 actually executes its code from the VCPU BO.
> Due to various hardware limitations, the VCE1 requires
> the VCPU BO to be in the low 32 bit address range.
> However, VRAM is typically mapped at the high address range,
> which means the VCPU can't access VRAM through the FB aperture.
> 
> To solve this, we write a few page table entries to
> map the VCPU BO in the GART address range. And we make sure
> that the GART is located at the low address range.
> That way the VCE1 can access the VCPU BO.
> 
> v2:
> - Adjust to v2 of the GART helper commit.
> - Add empty line to multi-line comment.
> 
> v3:
> - Instead of relying on gmc_v6 to set the GART space before GTT,
>   add a new function amdgpu_vce_required_gart_pages() which is
>   called from amdgpu_gtt_mgr_init() directly.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     | 18 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 55 +++++++++++++++++++++
>  4 files changed, 75 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0760e70402ec..895c1e4c6747 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -284,6 +284,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>  	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
>  
>  	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> +	start += amdgpu_vce_required_gart_pages(adev);
>  	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
>  	drm_mm_init(&mgr->mm, start, size);
>  	spin_lock_init(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 2761c096c4cd..e825184f244c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -459,6 +459,24 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  	}
>  }
>  
> +/**
> + * amdgpu_vce_required_gart_pages() - gets number of GART pages required by VCE
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Returns how many GART pages we need before GTT for the VCE IP block.
> + * For VCE1, see vce_v1_0_ensure_vcpu_bo_32bit_addr for details.
> + * For VCE2+, this is not needed so return zero.
> + */
> +u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev)
> +{
> +	/* VCE IP block not added yet, so can't use amdgpu_ip_version */
> +	if (adev->family == AMDGPU_FAMILY_SI)
> +		return 512;
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_vce_get_create_msg - generate a VCE create msg
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index 050783802623..1c3464ce5037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -61,6 +61,7 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>  int amdgpu_vce_suspend(struct amdgpu_device *adev);
>  int amdgpu_vce_resume(struct amdgpu_device *adev);
>  void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
> +u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev);
>  int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>  			     struct amdgpu_ib *ib);
>  int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index bf9f943852cb..9ae424618556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -34,6 +34,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_vce.h"
> +#include "amdgpu_gart.h"
>  #include "sid.h"
>  #include "vce_v1_0.h"
>  #include "vce/vce_1_0_d.h"
> @@ -46,6 +47,11 @@
>  #define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
>  #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>  
> +#define VCE_V1_0_GART_PAGE_START \
> +	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
> +#define VCE_V1_0_GART_ADDR_START \
> +	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
> +
>  static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
>  static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>  
> @@ -513,6 +519,49 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +/**
> + * vce_v1_0_ensure_vcpu_bo_32bit_addr() - ensure the VCPU BO has a 32-bit address
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Due to various hardware limitations, the VCE1 requires
> + * the VCPU BO to be in the low 32 bit address range.
> + * Ensure that the VCPU BO has a 32-bit GPU address,
> + * or return an error code when that isn't possible.
> + *
> + * To accomodate that, we put GART to the LOW address range
> + * and reserve some GART pages where we map the VCPU BO,
> + * so that it gets a 32-bit address.
> + */
> +static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
> +{
> +	u64 gpu_addr = amdgpu_bo_gpu_offset(adev->vce.vcpu_bo);
> +	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> +	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
> +	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
> +	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
> +	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
> +
> +	/*
> +	 * Check if the VCPU BO already has a 32-bit address.
> +	 * Eg. if MC is configured to put VRAM in the low address range.
> +	 */
> +	if (gpu_addr <= max_vcpu_bo_addr)
> +		return 0;
> +
> +	/* Check if we can map the VCPU BO in GART to a 32-bit address. */
> +	if (adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START > max_vcpu_bo_addr)
> +		return -EINVAL;
> +
> +	amdgpu_gart_map_vram_range(adev, pa, VCE_V1_0_GART_PAGE_START,
> +				   num_pages, flags, adev->gart.ptr);
> +	adev->vce.gpu_addr = adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START;
> +	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -532,6 +581,9 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
>  	if (r)
>  		return r;
>  
> @@ -647,6 +699,9 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
>  	if (r)
>  		return r;
>  

