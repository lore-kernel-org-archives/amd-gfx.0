Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA3E6BF39
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 19:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0BF10E376;
	Fri, 30 Jan 2026 19:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkfQB4ew";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DB610E376
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 19:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOdRpdQexnpm79UI2ZbRFBLaoOKuVjHtBizLYHYSEOm5cMqkADgrGUbiZypEB5GEbrkUOA5HvRb9QX5vtvouen3w432aEswyue2EhSwD6kf27p30/oy89qIwrEzR8FR7WLg/XpEVAVd8TE54hbmUYLUwWXRrQlUW0k+LawMkQb8wMjZBhDfLusyibRfWb//ogaz/yK3MYr8wz482UwJwHwFW8zHPgtK9Ll6W9GNZa8ItEYAPj95vSOKha0uy0VLxSCaOVtM7NMn9CllhwsFDj0oK+etkumlVuvWUHPDjU8VQEADsCGzLUtE/t441w7N6l0ZoZ42gah82TfP/yL1vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZPscu2Nh8nHvRT7x5K/EbiKB3+OcGnaZmNPCXlRWE8=;
 b=D6yJHNw9nxiviR2+7Tlr9VWO4iXM8dfFaObbPSR5igjW5DaEXC8Y7VwJClJmK3tG/E4Tje+qbJDkD/Q84/doqAAl5Hj5ewYbd28wDQb7hyWCjGrFh6hZaUds4z919j5/oMNsw4f2Ou6nHZqAOuS2c/ok6sayZvB3wkiG4rxIA3AwDvatNbiP5ntKo+Hhkf9AOK1pkO+DFSCCq/Q3ybnh4rUFkBwJwldWm+fJhHUv31iihZqUHk7YNd+aLQbKeIjmTTfppDkCyJlNsN0kQ4jwMhdfi/6Z4433aeBcUg0Fote6RI31bU9P9L6DmYomY4m53S45jGjPW/8aNRyb6ijZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZPscu2Nh8nHvRT7x5K/EbiKB3+OcGnaZmNPCXlRWE8=;
 b=BkfQB4ewKk1TlV3vRYLvwJinAeCetyu8vYSQYfA7bKMB2aeDIe7p7GxTKx7wN9oTSGp85qQckwTVg9A/BjwXgzEWZ3c+Qlb1V071m85PcjfWofAa1/cHSAAhKYPUoROA5qIUMEg6j9rCEdOnFmgCb2nuK9enCt+r0aPv/O9X10s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 19:53:42 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 19:53:42 +0000
Message-ID: <04559485-ecb6-4132-91ee-00c7c6288e16@amd.com>
Date: Fri, 30 Jan 2026 12:53:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] drm/amd/display: Implement DDC probe over AUX
 channel
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <20260126210837.21885-8-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260126210837.21885-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ff6a51-bb30-418a-5203-08de60394544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW9SN2dac093Ym1Lck0wU2IyS3JZQUI0VG5Ed0dQTExrL1UyREo3YXNRWTVh?=
 =?utf-8?B?Z1ovbWFTMENTdlBUUkRGRTJXU0dtZTVYaHUwRTRlNFRCRm9ldFRZYnd5MDAy?=
 =?utf-8?B?TUp6VlVYU0JVRHZYdE8yaDRyZTZOclN0ZEhHajZld3BjK3FSaEJXakxQYmhD?=
 =?utf-8?B?N0ZvOVlwS3dUcWJ2dVFSc0xMVmxSU0ZKYUk0UHhuRmpSYXJaN0pqZ2lOMVB3?=
 =?utf-8?B?ZzVFZzdxUGV3b0tOeFBHd1g3VmRuS2g0V25MY0p1YUdWMjkvcWE2Mm4yR2lT?=
 =?utf-8?B?RVBDTlRYOU5pdk1wUzZyYVNyaEFJQ1NNZm8rOTZEQytoNHRsVUR1MFZoTEp1?=
 =?utf-8?B?aGpIZ014SVIyVmdTUTZjeFZhZEpNcUk4RWpRTWVKY2IrMzc5WitHZ1p5RWdw?=
 =?utf-8?B?dEcwTncwT0p0SE81VlA0Mml6dzZhMlJxUW5ZbGpWbTRLdE5CS0hZdWJIbEp0?=
 =?utf-8?B?NGxQRFdNcSttN0JxM2xBc2pCKyszYnJkMUl2cFJ5cnBqODBRSEgyZzNrRkZ1?=
 =?utf-8?B?RXZzRmlWYmV6dkhtVlB3MEhERTYvMnZFSTdkNGRzcVV6RG5Qai9XN3hiOHJW?=
 =?utf-8?B?N3RoU0xFKzNlNXVjVDloc0FoRmlWSklKVzVTWGQ4UFNpS0tnMXMxRk5lb1ZB?=
 =?utf-8?B?bDV5UUNUeCtteGJNcHFVOXpTSGI1QUdWZU9udDU5MGFNTmEvUDhEbGo2c2g3?=
 =?utf-8?B?UUYrSENNcVNMTERiSnRwbjdoV1F5VFBUNkVOZzRzOWZ6dmxVMytFYlNrMzUr?=
 =?utf-8?B?VnIzQTl5dlFWSE11U3NFRzd2M0Q5NjNHTWZnSnN5M3BXOXZ4Zk9NaWUvRzVw?=
 =?utf-8?B?aEVVamZXVFg3VmJFaGhscFU4SWI0dXdPdzRsS1hJNStabmlIaUd5MVlOOCs5?=
 =?utf-8?B?S1hkTG1SdDJXU1l4a0xwb1lqcHhaVkNBYWtzUlk5YnBQbnZ5NWVzNzFDbEdK?=
 =?utf-8?B?TnFneUZsU3VoYXFJT3gwbXhvRTE4RUxsUUwzNjNyYi81TE5kVXJDVVNMOFNV?=
 =?utf-8?B?S3VPbnY4RzBaWGlPK21WbHRHS0ZRcTFLSU1OVC9PUVJOZ29uNFpXNUhoRklI?=
 =?utf-8?B?bGJTOWNNL1FtaC9JT3JPQ2gzRVhTRDFkRUJrWmo4R3pYTGZWdUVVVklJMnBm?=
 =?utf-8?B?bUxqWDZMTWhEYjk1SmsxTlY2NER4bTBScTAvRFBGUUJuRUh5bDRYY21tUlBz?=
 =?utf-8?B?Rjg1OWx6TFRtbTd0ZytzbUkydDV1NFA5bTZsdERRK2xTUHFENDUxYXg0NHpH?=
 =?utf-8?B?dzdCbzdSWXhxeExKOHY4M1FaVE9FWmU5emp1dlZIWk52WE5Bbk9lSlZLcjg1?=
 =?utf-8?B?NWhTQlFLMll1WE1NYUdaRVoyS2ZmbENWbFIwMWlkL1V4b2ZLSk5FWm43bnpI?=
 =?utf-8?B?VUJYMlA1dlhiMGdYMVNkRTlDQ0pCYWZNVVdkbXcvRkVsRUVoK3dOemxpcDBE?=
 =?utf-8?B?TXdEbWJVQjQ2a1FHaHROdUUvb0h3WXZST2Z6NmZ1ZTNTTGIyZld1MjNrUEVC?=
 =?utf-8?B?MHdUMU5ac0w1RGdTUThlSW5FZXZXTDdxYVdzSENYOHIzTXpCY1dTbkgyb3pN?=
 =?utf-8?B?ZVFVNzZESWdHL214Y2pDamlIMStId01lTkFJaEpuL2NjTUZOZzlqYW81R1VO?=
 =?utf-8?B?WmU1YkdKK3p0dTBmUllZemkwQ2ZRZW1NWTB5a3NsbVI4WG4yUW9SY29nUkIz?=
 =?utf-8?B?N3hGR2lrZUVmVnRVUDZVUzhOWk95V0MvWGRuenFkTVdsK3NvL2Y0WHkxNXFy?=
 =?utf-8?B?VFZTWUNjVVRxSjk3Nld2TGdDbkFjSXFDdFJnVDlEbDZKYy84Si9OcFVrelZO?=
 =?utf-8?B?QUw5eG5UdVQwWm54c3QwSnpUVUVkU2JCK2RRVGVDbnI3cmFsVFVPeFUyeklR?=
 =?utf-8?B?cVByMTNuUnFtUTJiNEoxSkprSlRkL0JSK0UrdmI5c0dsM0xVcGdjZUJHZE5Z?=
 =?utf-8?B?TnpwSlNDWmZOWGZvUk9JdTFpQ3pOWHgvNDNiQVFXWkNMTEhHWnpiNjdjWlhD?=
 =?utf-8?B?SmxIZGluSUFNeTAwUzJFcEJDVUVvclJhTlJTQUtEUUxjMWs0YnFXSTJ4S1Vl?=
 =?utf-8?B?ZkJVTytjdW5lSFZ2Q3lneG9ucXdQc2JDM0JlMUtQRE1GSzZOSFNLT1lPR3p3?=
 =?utf-8?B?QTJFZm5SYmtaQU9Qd3RtSU92YjBxVDIybUt5L2haRGNUM1d1cUZuc1RPQmQv?=
 =?utf-8?B?THc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JSdGp5bitYU1lXVTVLLzFJUGhSVkpuNnFwWW4yWmhMR0NBckF4TmpxdTJP?=
 =?utf-8?B?UHdINWFuVnJaYm54alJ4dDlCZlVJd0ZqelBUUCtObDVWbkM5ZUtEaEZDaTJ2?=
 =?utf-8?B?c3dneTh4ZnpaUWdSeVYrMjZxM0FMdXVFTkZKdVM4M2pReHZ3WVBvOUpoOVBV?=
 =?utf-8?B?d29jTFM0ZDUzSSszVzMxZzg1LzRveHREUTdYdEtRSGdMMlJtbWl2TFpkbllE?=
 =?utf-8?B?YkFEM1Q3TXJrM1VaZHNrUllNM3lVeFBDNFF4RmR2TU8yVHBCSXFKemhYNjE1?=
 =?utf-8?B?ejR5enhQZlVZUVI2TkcwQXkvQkQ3VjgycGlNTEJWNVJTWWJDSVNtS2J3b1Ba?=
 =?utf-8?B?YWtkZk9ZeFFjT3lwdnJpRjVRZktFamcxQjZ4Y0VNc1hkMzZJZmxUWkx1WDAw?=
 =?utf-8?B?RGdTMHJjWDBSZUk4Zm05cDBFMVF6bDNMYTZad2JLNDgwWWtrZjZ1b0o1SWR1?=
 =?utf-8?B?UC85dGplQ1VGZE96UHYvR2xWVGtwRDRNTGFjSXliQ1ZiYStnQ21qR3hlTzQz?=
 =?utf-8?B?a3ZSVWlLSTNSUENZeERCcXdsTzBuVmRHNjZCT2ZGNnVBVmx2NmNabUxTVGx0?=
 =?utf-8?B?Wm8yem4wclVWTE0wck5URGwrVUVSRXZPL0lUT2htL2hyNklheitSZUY1bk9U?=
 =?utf-8?B?Z0N0V2JZM3lVbmFSZ3c0ZnhoeGV3RnNTOHM3QWwxTDJ2M2NldmdLVmJhc253?=
 =?utf-8?B?YThtRzZ1RFBLQWNwdTkyTjFUV2JTMGdTc2tLV0dHRDFsdnphNTQxaHFuUTl4?=
 =?utf-8?B?ZFJ2Vk1wRFhZMWhJT0E4dzFxMnE0ZlJvZUVOWE5GcTlRL0RuQWJHMUxiajh2?=
 =?utf-8?B?STU1QTE2RFV2bUhCRUl3SDR2WmI3elhuTTZQaUxjMGpYTGRVcGVlWlJoTEs3?=
 =?utf-8?B?MFJLSnBVZmdHOFE5c08xUmlQdjlQdzBlN09NeXlMQnRlOGtWc2JIbnllRHJo?=
 =?utf-8?B?YnJTTU9TamV0MzJpVDhxZCttcEpNK1NGc2pjbFVwUjd4UTRPam9GN2ZFNWUv?=
 =?utf-8?B?bFVNODVKcngwcTAreFdWKzlFZnhzRHVTWklZWUI0d1dEVFlpRDVNcW85SXpn?=
 =?utf-8?B?RUJmWE52MDdHZ25KMmx0R3ZUTTVTYjE2SzVZMDFDT2pkMmFkbTNsRWFFdE16?=
 =?utf-8?B?UlVjalU5Y3NNRTZqSzBOQ3pQUjAxeGkzQWdzUGZ4RERoOXYrTUhBNE9IR25z?=
 =?utf-8?B?dWZoelBwcmZVVzRLWXliQjczZWcxSDZDNnhDZHV3MUZJSnEwZnV6K3RUb2VR?=
 =?utf-8?B?Y3lzVVlsbkNOcEE5REYxcWx2NDRGcE14aFM4MkxCSFZBKzZ2cjMxTWRMZkRU?=
 =?utf-8?B?QitMS05sR2llVDFkQXpaNTRzTmFldU5DOUhSOXFXM21TQmtvNTZRaDBkWnFo?=
 =?utf-8?B?djFPR2tYU3FYcnU1dWRJcnVRTXNpaWxTdUoyejY2OTNQZXFMc1NaUDc0SGJC?=
 =?utf-8?B?ZXBYVVgxK3hwQXZBbW9Tb2ZnN2JudUFIVm9ZbVpIOUFGcDZBNjdHU3hzT1Na?=
 =?utf-8?B?U3pjTGtONU5MbUswNHYwOHJmTmFmaGw2aFd3WkdKaDNNZE1QaEhlT2U1WEZv?=
 =?utf-8?B?emROL1RLMGFrT05JNi95THdNYmVOanFzb1ZJUWpMZndQR3ZNR0ZRaW5rY3Ey?=
 =?utf-8?B?aEdFdDhjdExpOHBkZnNNM21xNDU3blhoQlJzUjBlQU02THJpUFZySDVWSXVu?=
 =?utf-8?B?ZHIyaS9CVlI3LzNwd1RXT25sVUt5L1pTN1ZRSVNvVDRpd3FKMXhSQTlmTm0z?=
 =?utf-8?B?ZWU0bXRtZzI3bExMbTByNEk3SGZlTmZTMFNyZXd5YzluaGZwTVZ3ZW0rZHhX?=
 =?utf-8?B?ZkFmSk9FL3lVUXN3bFJGY081UmR6akRYS3dxNklwa1oxUUNxWHJlS0Jxc1ZF?=
 =?utf-8?B?YmlVL3VsaWFueWZ0Qk5rWmd5UWJoWk9OQ1J0WlE0RUFROE9LOW5wbkVzV1B5?=
 =?utf-8?B?eXBvWjkzMWZIeG1uQk5LTEpjN0hHMVl3WU8rbFpsK2ZjWGlLK1VUaWpXcnJz?=
 =?utf-8?B?Z1lrdk5PQkpNRVM1MXJLS1BOVWhvMG1KakYxU3FWbjFQMzhaRGhJWUhQSUlj?=
 =?utf-8?B?UTNJYThOclVSVktzNGxraStzRFdmUitVYWRsS01ORkQ3Z2dEK0V0c2h6MzNL?=
 =?utf-8?B?TGxCNDcrUXlWOUdCSTdvTFRjTTFpOTRPTmNJYldHc0U3cnlZc3NNUEhjaXpt?=
 =?utf-8?B?OUlITGpNT2ducWhxcmg3REExSEpyUTkxa1VRWGhLUU5Gc1BWV3VEbGRKbTZu?=
 =?utf-8?B?VFplRzN4U280WmhZLzdaQkxaeWhqQWtRMi90TExGSVdCdFBlQ285SWVyUG1x?=
 =?utf-8?B?eHJtMElNMUFmUklYOGNOMkV6ZlZLTWs5MkFqZUhLNTFGWU5OZHFNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff6a51-bb30-418a-5203-08de60394544
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 19:53:42.7021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGNCw52V/+dByVIqdf9t9q3mfjEAsG7ZhuH8gH5GqawL/UWE7ZpZ4lQbiH5Dm07UHNWDg5vcXFXX36iEFeV5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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



On 1/26/26 14:08, Timur Kristóf wrote:
> DDC probe means that we use the DDC (Display Data Channel) to
> verify whether a display is connected or not.
> 
> This was written with mainly analog connectors in mind, so it
> didn't work over the AUX channel. However, in order to support
> external DP bridge encoders found in CIK APUs, it needs to work
> over the AUX channel too.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 1585cce65b0e..e1d568905581 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -903,11 +903,18 @@ static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
>    */
>   static bool link_detect_ddc_probe(struct dc_link *link)
>   {
> +	enum signal_type signal = link_detect_sink_signal_type(link, DETECT_REASON_HPD);
> +	enum ddc_transaction_type transaction_type = get_ddc_transaction_type(signal);
> +
>   	if (!link->ddc)
>   		return false;
>   
> +	set_ddc_transaction_type(link->ddc, transaction_type);
> +
>   	uint8_t edid_header[8] = {0};
> -	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header, sizeof(edid_header));
> +	uint8_t zero = 0;
> +	bool ddc_probed =
> +		link_query_ddc_data(link->ddc, 0x50, &zero, 1, edid_header, sizeof(edid_header));

Please move variable declaration to beginning of the function. Thanks.

>   
>   	if (!ddc_probed)
>   		return false;

