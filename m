Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D8C98306
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 23:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4050E10E1FD;
	Fri, 16 Jan 2026 23:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BPxWzFUw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E88010E19A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 23:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAyeJE9B9IqFpP8u580LWKbylek3HPsJ7o7YFeBBP5EcaaovOevkb8S7SfrRbgQruPxfW73tJD/1zj232a2HdpicV53fbHAlx46c3z9M1U0jkTXoyzsjKq49eeLDKSlq79p2Rr88UvKEqc0CWWvZFxAaKU7e4P7jagoIVLXwBuQe1hbKd8P9zxjYtEIExtm9TpkWs4ze1PToojRIWHaDSaVZq+QKfgro6mnicme15eVIM0s5LJkAE9+EaD8VYFLZNKAp4XHwu6/ZwCWuuZze52R3HvCb9X6gKVeFdPvwy5K8o3waFExmeAuVLKXGbL5FAc5SKnNxVDzZsSbPMiKpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8J4J8d4LCTjU+fsQt2VG+7056yTQXUhIyWuKo62mag=;
 b=ns7otkchpwOcdZ4fn+wDrFl8o5vt4rU4tTelbtojnGTUtKKZeeCpFyoG7DGpB0+KUpLgQBCqOuTtlzLjH4B9S9+60O+d3dO0+veN+f9J+U/eEhZbtkAr5AMvC/1qskp8TwxC4euf2epuJcyqtNkpD+K/SsiiO4mPRGOgHTyKrWs+/CT06W2qwze5YjsufDdNZIIxLtUd1sA3gBazKFx80x9Vz8VWVJq1nPTKzRfWnBisY6SM2wy6/X2ZGN/qoQPIrCj8htLzHRw8ifk9QtvfBcXN903x4QqCIFnNT9v5Qn5SJbjNRZyPqCli6mZ22G3sL61sgdm6H+u59X8As5fO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8J4J8d4LCTjU+fsQt2VG+7056yTQXUhIyWuKo62mag=;
 b=BPxWzFUw1WN/ALuOvyNhx4dltXUx88y43CxX8eqBNTmtBJv/u0T7Sk9lQRSFK5qxUkWQ3Hy2N7foFyELApYZKloR2Zm2kAuJpGhFeDntpQdltlX0Ku7CTnffIv7n3BUJjdhPLEvBshwJI/mxPh/+Lh8UREx4+OQxVKB/chNF21A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 23:52:51 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 23:52:51 +0000
Message-ID: <207fe1c5-21ab-459c-9f81-2f81f498c150@amd.com>
Date: Fri, 16 Jan 2026 16:52:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amd/display: extend delta clamping logic to
 CM3 LUT helper
To: amd-gfx@lists.freedesktop.org
References: <20251208234741.293037-1-mwen@igalia.com>
 <20251208234741.293037-3-mwen@igalia.com>
 <a18c26d2-0664-4eb8-914b-52667fcc63f0@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <a18c26d2-0664-4eb8-914b-52667fcc63f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f456b3-ffa1-425a-0282-08de555a5beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1VuUkVYVWJsK0hQdWFxbjBCTG9Vb1ZyZThSdFZaUUowZVRBeklDdDFnRDlk?=
 =?utf-8?B?OVdxN3FOdnpqWGc1QXo5YVBlSlI1S2RUUDg1NWEvMUNTRkRYbWlWNS90dVhZ?=
 =?utf-8?B?NHZTYzZsaHU1RENRemFPTmwwa3BMaDZLWWNSc3lJV2lISy9XRHJycDh2cytQ?=
 =?utf-8?B?WGEzSExGbzRQdjBlajdXN2FtdUN4emNVVGhOekFaQWZ6ZXBYc2JYOUkxaEhx?=
 =?utf-8?B?N1RFVXpBVHo1YXo1aUJHWHdFTEFsdytrSnlwbGx6YkdsTG0rQ2FYV21jN2JQ?=
 =?utf-8?B?Y3lwTUFwOGEvTGs1SDRIQnFQdGJDM0JYQTlRL1dpRmR5akU0L0o5bDhlZnRZ?=
 =?utf-8?B?WlhtZm1hclFacUdsYWJOd2FSdm1lRldSM2tEaUZYSCtLUkZ4ak1VWHVlTWtX?=
 =?utf-8?B?bFV1OVBvSjM1WmMvaHp3Z1lzQ25lWlR3bE91R3dCTFpvbjdHckVMR3N1cnFK?=
 =?utf-8?B?THpGbTlqNVhFR08vYU41Y2lPOWJXaHFMdFA3SE5wVlZYblArSHFGTkx5alRY?=
 =?utf-8?B?VlR6R0lIUFRvMzF0NVV1c3lGR2p2YzVQaTVxemp1blpKQ1J0WlJXUGZOZzZZ?=
 =?utf-8?B?Nk9RM0VtR0hOU1dpa2s0MUV6V3FCaXVDS050QzF3QnRqSzFtamxYTG1DQ1VV?=
 =?utf-8?B?blYrT3BGQWNIb2QveHZNV2xUZmdja0lOcW42RGtoN3FwZGFMbTN3T2w2a1NR?=
 =?utf-8?B?eUF5WDE1UHBlOXl4UUtRV2NQTE1kWjk1U2kwSkg4YTJtTTU5V3VVZnc4Wkxl?=
 =?utf-8?B?RVBPZTdleTk0R1ZhZmRrNWhnQnEySDBqcmlrZFBxYW5oc2JtVjZYSTVod3pS?=
 =?utf-8?B?bU5EcXdBbks2Zzh5NWpwRFR6RnN6UUdUTVZLNXE0TUdBWEFibVloZmlJU21s?=
 =?utf-8?B?Ui84dmxQR2YyZmdGR2JOSFpQemdZa0Vnd3BKazdFRGpHUTEzQVlOOHVLUVQy?=
 =?utf-8?B?QWtGY3E2eit4d2lPNFptdHMxZXNIeFl0b1JFaDI2dUtXZmJDQXBNVWNhNUo4?=
 =?utf-8?B?ZnlWRDFxVE9HdkM4dW5qMVNoWHovRmFBdGIvRzROS0pvVSthUXJSVkpuVGFB?=
 =?utf-8?B?YkhsRWpzZ1ZpMzVmQmlxUkZHM2wvRXpmYmVqUXBGSktYTE9sWm4ralk3OWNH?=
 =?utf-8?B?VU16RjZHNE9Tak5YcWZKUXVaVU1zQng3QW12WGV5L2ZmR3dRcU5VUnYyTWVV?=
 =?utf-8?B?MXd6Rm55cnNndzFVY3V4dExEaVVGdGtZUkRQS3JjR1FaSXhEK0QrNUQ1OGV5?=
 =?utf-8?B?M3VNMEphMHBML2lZVDNxeUVXTGNhUm95Q3RERXVSUXFsVWVkRzlhZ3VRSWNK?=
 =?utf-8?B?VHk3Z25lb2lQU21QbGJQNmZ4bXZITjltOWlOZk9GUFFWOHZ2TGdQRUV3UzVz?=
 =?utf-8?B?R3ZSTjNrTXpSRlhLeWpqQVc1RWRWeDRIVEQ1NDhUMHowQXplOXRNbHpEUWdG?=
 =?utf-8?B?aEN5YUVZelc0VmhuRWVIaHpUbWJ6akF4N2JvdHFnNTlKaGVqMUtOQThocjYy?=
 =?utf-8?B?U0R6SFZVMDAvaksrUzhFb2c2WWZpcjV5Zy9kWUVKNjZvR2xlZnI5dGREUGI2?=
 =?utf-8?B?YXZPUjZEUEp5TmdzVnpmTVBmbFUzczdhMUY4TUVPd1JpVlNORzhmTGNIcG0z?=
 =?utf-8?B?MVZpZzZaTnd4M3FtSEY4NmNsYTRoaGhScUdud2x2V0xHYWd5Uk5rbkhrZjR4?=
 =?utf-8?B?aWlPSENiSHB3TDU0LzZYMEQ1SHo3cysySGtRRk9Nb2RvZGQ2WXlsbHNjazVh?=
 =?utf-8?B?cHlwa2lJaVBYQUdWcHNlamFRQk5pSHFVQzFCemJhbEtLQThGSkdtc3ExSlZK?=
 =?utf-8?B?WWhQMFNXV1JPZ2MzNWxwZWdLYmg0Y29iSUhhR2VvWmdKTUJiRndPWXpLQnV1?=
 =?utf-8?B?cGZYRzBJbWRFU1JrZzUzZzZEYnJkTEdnRjNzZDhhaUhkUldqaVYzUlVBSis3?=
 =?utf-8?B?OWJOdjBGak5CYUk3VkZvZHlWOGxoMG5qTysxUERKN2JuS3ZHMVBOTGJlZFV2?=
 =?utf-8?B?eWw2RUxpKzV3UTM0M2VPVkVvSDJEWjJVQjk4aDRmWDBQQ0xuZ2Q3Ly9EcWNC?=
 =?utf-8?B?cDBNUEM5dXR1MnJuZ2JQczVFZWpFOEovekVEUGZzQzJMaXkxZ1hZYTB4MkJQ?=
 =?utf-8?Q?GOKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNGYXgyK3VUVWpyMTJmbXdCWVlsUS9QL3VwWWZuTFFUVHo4aU9FbEtqSHV2?=
 =?utf-8?B?d2ZOalhQeXBmVnpyNXVWM3N1OVl5dzYzb295VWxaOElmVWZ5QTVtbEdpOUh1?=
 =?utf-8?B?SkhxUjdwNEdWTWdWRmpleDVmWmtlSU1WNHRHQXlud2V1eENwVWhkcVFqYmRm?=
 =?utf-8?B?V0RXR0NSb3NpTC90d1J1QUdaakNWcDR6RVhldHVrdG9kZmY2L2llUFo4SGdv?=
 =?utf-8?B?c05UQmU2VU5rZkd6SWt3NGdldER2aEVweWtlMEZ5M3FFVVlJRGkxRFhqdzhX?=
 =?utf-8?B?SUJVS1pQV01saWlleEpuOEJnUjNKQittQlFoOEduQzRPdUNUcmx5ejJpd1Zs?=
 =?utf-8?B?aHJFSWJVQ3hRMGpDTXRYUGZENzBQL2thdlY0eE15dnlpOEE0V1BEMEpIei9L?=
 =?utf-8?B?bGkzeTl1M0M5Wk9DR20raHRvTjZQQno5YXgwV1QrQThIMU9GZnZTQzF1QWpu?=
 =?utf-8?B?TWdJRjVBbTdBQ1VNMC81MUJud1ExaXVISjFYRGkwWnF1S0NBWTE4S2hIVmd6?=
 =?utf-8?B?RmN5OW9XRzZZMmR2WmtOQ3pWNkREWGp4T3ovNGlCQU5wMUtBTnhxRlRrV2Nl?=
 =?utf-8?B?OVhsQTZlNllwUHA3NjhaMGtITWk1K0xwSEY4RkUzRFJRenVKTjhjUVVMQkRk?=
 =?utf-8?B?MjNPSHZQTFE1UWlUbXBSMnFuN2x6bDlwTG96aUcrZkI4dXAvUGkzK3RRQ1VJ?=
 =?utf-8?B?dGs0T0VMUTFmMGhYbTE3NTRKUGNQYTBkbFUyczJiN0ZuTW1VcGpvMWV6dGx3?=
 =?utf-8?B?QTNKeEI4Y3ZQQnVaTmtOczZDa2h5d2VtZlVtVndFdjFmU01EYUNqd21JVVhQ?=
 =?utf-8?B?SFVMUFZpT0toWGNjZHBWR0F2bHY3c0lzZ3JSYU5wQUpYL3hxbUZsVmI5T1hp?=
 =?utf-8?B?Qmg5aXJLbWZUMHUweUdpMm5MUElxS0NiV2Vhck5qYmZYTkhaeFIwai9SdVhG?=
 =?utf-8?B?UFZ3eGxpYWEzSSs1UmJIYXd0dkpFVVVOVXd6Nm9Qa1VuN0ZweS9LUkxGZHAz?=
 =?utf-8?B?ZmFlMHpiTXlnNW9LR2x6WHRnUzNOWTZDK0g4Rmp2R1RRTHNBY0pKcDRMa0h5?=
 =?utf-8?B?eEtCZ0JvUUd5QytKak9IOC9nd005akRmdkRUemxjQWZUd0k0cENidXRIUGxM?=
 =?utf-8?B?UGt5RVdpK1lhNG9SYkFHWGRyazU5djFaZC90NUV3RWg1dkZLUzd2bDFtSHI2?=
 =?utf-8?B?MEZybS9wOUZXWUJkTXYyaVc3L2pVQWVQWStyQlVyNFVKMjF1ZUhXdTJGQnlH?=
 =?utf-8?B?V3RVL2dwMG1xTE9PS01RZk0vVnJtVytCZzBjd2FJQ2NDT1FsOVVUTGF0dHBY?=
 =?utf-8?B?MkpIRGppMi9OUGMvaXJnR004N3pad1VQL25KNThlL2hVeW01cG56TnBRYkJz?=
 =?utf-8?B?VkYvODlhR0JkZmZ0SG1jSlhyQk4vRCtyYmozTXhBam03UkVCcGVaWEpnQUFU?=
 =?utf-8?B?VWxQcWJEbDFnNHhFaUU0SWZkSmZPNTk0SFFLcDdkZC9SdTdkNEx0MDBVYzkx?=
 =?utf-8?B?M2FnSEo5YXpia3RjS1REUUxIemlHdTloa3ErdVJVbGpWYXgzUTc2TU5JQk1w?=
 =?utf-8?B?Mkp2QzBtdzF3Y1d3dGxhR2hWQ2NYbHpvb0dxTXl6SUErQXBsMjhLVTk1K0Rv?=
 =?utf-8?B?RVFTb0JaZDY4N0dOSmYyeFRMaFlNaGlJdFJMWG9aRXIwamlMNXhZZXE2NFpa?=
 =?utf-8?B?emk4cWs0ZTVDYTR4elNkNVVqZHcwWDBjWVo5NjVpYVc2UGRXc051TWpTb1Nr?=
 =?utf-8?B?S0orME9FZ0JySzJwR2NLTmZLNE9aV1lDdjdEYjhRUlVjanV5N25mYldGUUZ6?=
 =?utf-8?B?YTQzVldxT3U0eG1RajJ2bmkvbzRkWjNkRkdVUFFiMjJUUmQ2cGg4R1RaaUg0?=
 =?utf-8?B?enQzMmxkRnVVVEpOVDNVNTJJQjRkTUNEWmxxVE5JUkoxS1ppOHRrcHVhM1ls?=
 =?utf-8?B?Z2NSNUZDcllDTFhGQ3hjV2VqNFhnclhvekl3clJvN0tOT0t1cy9nd1pKbUdU?=
 =?utf-8?B?OG5XK0hKUm5GZmR3ZStHZWVYT3BJcmVBeGRHUGx6Lzk3UC9CRjhrYjlLWERB?=
 =?utf-8?B?cTFqSlgrWUtubDB6U0VDenFsNGFYeGhzUk9EVUlrYVNaZlFtR1NndVpxTzZS?=
 =?utf-8?B?bmg4MXZROHdiTU1oQ25mQWdUVXhhcnlpaW1xVXNSUXNIb0FnWDZWRkpBTXl2?=
 =?utf-8?B?UzZUR1JiNmZzN05Sc3BDenRpVmJGSmlTTVpNSWpUK3lKZjQwMDFtQ0E0VkNy?=
 =?utf-8?B?QlZldW5EcU10SWdZRytzbmlabDRmUTBLOGFmcmdJZTlQdFdtL1RqTEZKNGx6?=
 =?utf-8?B?Qk4vNWswYWFTcUY0dzdmdGxyb1ZQR1oxTnpUN3JiYlMrRE8rNWVRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f456b3-ffa1-425a-0282-08de555a5beb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 23:52:51.2748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ahDvgjqw5GWnXcPNUzsxKu8UazSwiUVB5plvRx9vjLBQP380Kd9h9aWt/iOBMJ90v32kKW+yFycRW6BweFaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

I tested this patch and it fixes kms_colorop tests. Thanks Melissa.

I will forward this to next week's promotion test.

On 1/16/26 13:27, Harry Wentland wrote:
> 
> 
> On 2025-12-08 18:44, Melissa Wen wrote:
>> Commit 27fc10d1095f ("drm/amd/display: Fix the delta clamping for shaper
>> LUT") fixed banding when using plane shaper LUT in DCN10 CM helper.  The
>> problem is also present in DCN30 CM helper, fix banding by extending the
>> same bug delta clamping fix to CM3.
>>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 
>> ---
>>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 30 +++++++++++++++----
>>   .../display/dc/dwb/dcn30/dcn30_cm_common.h    |  2 +-
>>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  9 +++---
>>   .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 17 ++++++-----
>>   .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 16 +++++-----
>>   5 files changed, 49 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
>> index ba20575be214..b1c2c8da1937 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
>> @@ -105,9 +105,12 @@ void cm_helper_program_gamcor_xfer_func(
>>   #define NUMBER_REGIONS     32
>>   #define NUMBER_SW_SEGMENTS 16
>>   
>> -bool cm3_helper_translate_curve_to_hw_format(
>> -				const struct dc_transfer_func *output_tf,
>> -				struct pwl_params *lut_params, bool fixpoint)
>> +#define DC_LOGGER \
>> +		ctx->logger
>> +
>> +bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
>> +					     const struct dc_transfer_func *output_tf,
>> +					     struct pwl_params *lut_params, bool fixpoint)
>>   {
>>   	struct curve_points3 *corner_points;
>>   	struct pwl_result_data *rgb_resulted;
>> @@ -248,6 +251,10 @@ bool cm3_helper_translate_curve_to_hw_format(
>>   	if (fixpoint == true) {
>>   		i = 1;
>>   		while (i != hw_points + 2) {
>> +			uint32_t red_clamp;
>> +			uint32_t green_clamp;
>> +			uint32_t blue_clamp;
>> +
>>   			if (i >= hw_points) {
>>   				if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
>>   					rgb_plus_1->red = dc_fixpt_add(rgb->red,
>> @@ -260,9 +267,20 @@ bool cm3_helper_translate_curve_to_hw_format(
>>   							rgb_minus_1->delta_blue);
>>   			}
>>   
>> -			rgb->delta_red_reg   = dc_fixpt_clamp_u0d10(rgb->delta_red);
>> -			rgb->delta_green_reg = dc_fixpt_clamp_u0d10(rgb->delta_green);
>> -			rgb->delta_blue_reg  = dc_fixpt_clamp_u0d10(rgb->delta_blue);
>> +			rgb->delta_red   = dc_fixpt_sub(rgb_plus_1->red,   rgb->red);
>> +			rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
>> +			rgb->delta_blue  = dc_fixpt_sub(rgb_plus_1->blue,  rgb->blue);
>> +
>> +			red_clamp = dc_fixpt_clamp_u0d14(rgb->delta_red);
>> +			green_clamp = dc_fixpt_clamp_u0d14(rgb->delta_green);
>> +			blue_clamp = dc_fixpt_clamp_u0d14(rgb->delta_blue);
>> +
>> +			if (red_clamp >> 10 || green_clamp >> 10 || blue_clamp >> 10)
>> +				DC_LOG_ERROR("Losing delta precision while programming shaper LUT.");
>> +
>> +			rgb->delta_red_reg   = red_clamp & 0x3ff;
>> +			rgb->delta_green_reg = green_clamp & 0x3ff;
>> +			rgb->delta_blue_reg  = blue_clamp & 0x3ff;
>>   			rgb->red_reg         = dc_fixpt_clamp_u0d14(rgb->red);
>>   			rgb->green_reg       = dc_fixpt_clamp_u0d14(rgb->green);
>>   			rgb->blue_reg        = dc_fixpt_clamp_u0d14(rgb->blue);
>> diff --git a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
>> index b86347c9b038..95f9318a54ef 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
>> @@ -59,7 +59,7 @@ void cm_helper_program_gamcor_xfer_func(
>>   	const struct pwl_params *params,
>>   	const struct dcn3_xfer_func_reg *reg);
>>   
>> -bool cm3_helper_translate_curve_to_hw_format(
>> +bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
>>   	const struct dc_transfer_func *output_tf,
>>   	struct pwl_params *lut_params, bool fixpoint);
>>   
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
>> index 81bcadf5e57e..f2d4cd527874 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
>> @@ -239,7 +239,7 @@ bool dcn30_set_blend_lut(
>>   	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
>>   		blend_lut = &plane_state->blend_tf.pwl;
>>   	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
>> -		result = cm3_helper_translate_curve_to_hw_format(
>> +		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>>   				&plane_state->blend_tf, &dpp_base->regamma_params, false);
>>   		if (!result)
>>   			return result;
>> @@ -334,8 +334,9 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
>>   	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>>   		params = &plane_state->in_transfer_func.pwl;
>>   	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
>> -		cm3_helper_translate_curve_to_hw_format(&plane_state->in_transfer_func,
>> -				&dpp_base->degamma_params, false))
>> +		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +							&plane_state->in_transfer_func,
>> +							&dpp_base->degamma_params, false))
>>   		params = &dpp_base->degamma_params;
>>   
>>   	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
>> @@ -406,7 +407,7 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>>   				params = &stream->out_transfer_func.pwl;
>>   			else if (pipe_ctx->stream->out_transfer_func.type ==
>>   					TF_TYPE_DISTRIBUTED_POINTS &&
>> -					cm3_helper_translate_curve_to_hw_format(
>> +					cm3_helper_translate_curve_to_hw_format(stream->ctx,
>>   					&stream->out_transfer_func,
>>   					&mpc->blender_params, false))
>>   				params = &mpc->blender_params;
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> index b213a2ac827a..27abc08918bc 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> @@ -486,8 +486,9 @@ bool dcn32_set_mcm_luts(
>>   	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
>>   		lut_params = &plane_state->blend_tf.pwl;
>>   	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
>> -		result = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
>> -				&dpp_base->regamma_params, false);
>> +		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +								 &plane_state->blend_tf,
>> +								 &dpp_base->regamma_params, false);
>>   		if (!result)
>>   			return result;
>>   
>> @@ -502,8 +503,9 @@ bool dcn32_set_mcm_luts(
>>   	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
>>   		// TODO: dpp_base replace
>>   		ASSERT(false);
>> -		cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
>> -				&dpp_base->shaper_params, true);
>> +		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +							&plane_state->in_shaper_func,
>> +							&dpp_base->shaper_params, true);
>>   		lut_params = &dpp_base->shaper_params;
>>   	}
>>   
>> @@ -543,8 +545,9 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>>   	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>>   		params = &plane_state->in_transfer_func.pwl;
>>   	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
>> -		cm3_helper_translate_curve_to_hw_format(&plane_state->in_transfer_func,
>> -				&dpp_base->degamma_params, false))
>> +		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +							&plane_state->in_transfer_func,
>> +							&dpp_base->degamma_params, false))
>>   		params = &dpp_base->degamma_params;
>>   
>>   	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
>> @@ -575,7 +578,7 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
>>   				params = &stream->out_transfer_func.pwl;
>>   			else if (pipe_ctx->stream->out_transfer_func.type ==
>>   					TF_TYPE_DISTRIBUTED_POINTS &&
>> -					cm3_helper_translate_curve_to_hw_format(
>> +					cm3_helper_translate_curve_to_hw_format(stream->ctx,
>>   					&stream->out_transfer_func,
>>   					&mpc->blender_params, false))
>>   				params = &mpc->blender_params;
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
>> index 2fbc22afb89c..5eda7648d0d2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
>> @@ -430,7 +430,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
>>   		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
>>   			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
>>   		else if (mcm_luts.lut1d_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
>> -			rval = cm3_helper_translate_curve_to_hw_format(
>> +			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
>>   					mcm_luts.lut1d_func,
>>   					&dpp_base->regamma_params, false);
>>   			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
>> @@ -450,7 +450,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
>>   			m_lut_params.pwl = &mcm_luts.shaper->pwl;
>>   		else if (mcm_luts.shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
>>   			ASSERT(false);
>> -			rval = cm3_helper_translate_curve_to_hw_format(
>> +			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
>>   					mcm_luts.shaper,
>>   					&dpp_base->regamma_params, true);
>>   			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
>> @@ -627,8 +627,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
>>   	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
>>   		lut_params = &plane_state->blend_tf.pwl;
>>   	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
>> -		rval = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
>> -				&dpp_base->regamma_params, false);
>> +		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +							       &plane_state->blend_tf,
>> +							       &dpp_base->regamma_params, false);
>>   		lut_params = rval ? &dpp_base->regamma_params : NULL;
>>   	}
>>   	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
>> @@ -639,8 +640,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
>>   		lut_params = &plane_state->in_shaper_func.pwl;
>>   	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
>>   		// TODO: dpp_base replace
>> -		rval = cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
>> -				&dpp_base->shaper_params, true);
>> +		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> +							       &plane_state->in_shaper_func,
>> +							       &dpp_base->shaper_params, true);
>>   		lut_params = rval ? &dpp_base->shaper_params : NULL;
>>   	}
>>   	result &= mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
>> @@ -674,7 +676,7 @@ bool dcn401_set_output_transfer_func(struct dc *dc,
>>   				params = &stream->out_transfer_func.pwl;
>>   			else if (pipe_ctx->stream->out_transfer_func.type ==
>>   					TF_TYPE_DISTRIBUTED_POINTS &&
>> -					cm3_helper_translate_curve_to_hw_format(
>> +					cm3_helper_translate_curve_to_hw_format(stream->ctx,
>>   					&stream->out_transfer_func,
>>   					&mpc->blender_params, false))
>>   				params = &mpc->blender_params;
> 

