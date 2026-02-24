Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B97EFB819
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECC610E51C;
	Tue, 24 Feb 2026 08:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUoudWmZ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77710E517
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii7eA5yhMjIleWn/eFMexjpXQwpWT3VQuSL74VhYY1/7hlje967QcEULM86So3ixdfY5UrSPtaCrE6JK40gzGn8Drg/bWvSdUBBAfDP+4GNImScIHsgwkcpw7CHpPXLir6VdlI84jYFuFMknMWddttRJ5k8Gmxrq194VJ67Y9JQ828l0p6cVHgke0PAapacdRQa6krN1ZW2GbfS2N4iffMWg5SatRYmPPp2lDpdTx0zCTOoyBHhK+hjvh5A8GoxKeLdfLN+zvg8aDCs5ReCYJW4xEd+esBeRqBHn3kLRg5PpZEVLxGG80osm80j1PLFR6Rjbp+FRJRLloTpvuyIg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVgU9RptfvCMPkE7E7up1r6KliAK6KSl3yDGjdURvik=;
 b=sz0APvrfW4AQgC7l05rxZNjaD7CwcC9pYk2Qv1yF64H8vm4y/7/N8VjWx1Ur90o2EIrW9Aq8DZghscv++BWNsb1K4s73m4wI9ILL7DOMipVUpUWdjnMKeOWBx87pNhI96tb2oxAPknjkX9AMTSNlufCT8iqMgn9XAOiJ6KuDlR4QsvcigeXGEezjcqVRMzA+L15UN8dJDem8+WFTsNgbGKNpea1wBWRde1bxzhhziOupRi0PslNbWMePjhuFjMh5SvSfkVfAfdEgll3qnVL2T6fHdlLi+leRPF4qhrEuz53HNFZu+JYlptGvA7U6qzuTBp/7SG3yw6qYvEr+j6BhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVgU9RptfvCMPkE7E7up1r6KliAK6KSl3yDGjdURvik=;
 b=DUoudWmZ21CYGhRPlHrHg1ZwkkV+8LgzAIb6y3VkuDzTxfuZyl01LYIT2sI3AH6ZJts0W5AsDVSud2VDbAcZrJZBBwz+55GVvtQMjKxTwIpbIKnt31Cf3B/pjB7+MBcjhW0pandKPmTUHdVpiV01fSVrGD0KxJN45Ck3gHswOas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:56:58 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:56:58 +0000
Content-Type: multipart/alternative;
 boundary="------------e5R50MRekigyEmI4YQp2iQ9y"
Message-ID: <f5d02c29-0467-4d4a-87c0-32be893bccc7@amd.com>
Date: Tue, 24 Feb 2026 14:26:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <7f851448-e4b8-46eb-9f38-4d45e0321e6c@amd.com>
 <1d38bf92-19c8-46ad-9319-2487f59958ec@amd.com>
 <adbcf4bf-60c6-4dcc-837d-31c9c59d39b0@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <adbcf4bf-60c6-4dcc-837d-31c9c59d39b0@amd.com>
X-ClientProxiedBy: PN4PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d344e9-3433-44bf-adbe-08de7382aafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUZYWW9peWRseUdveWtHYVZqT0JUQkF1V3lZaVQ4Tk5SdjRBaDBYdUIvdzYy?=
 =?utf-8?B?c1JiazlzMmpTUUpDRWI4aHJWZVZ4Q2NURHVxM01wL3k0ZnJDNWhUNi9EaVlK?=
 =?utf-8?B?VGhISm5zSTlMR2JWU3g3SlVKUVR2T2tKVVZJd0plWjVPMlc3cUY4YzRiNkE2?=
 =?utf-8?B?NGd4cVRaTU1LOTBlajNva01BOFg2b1VlY3VJQ1NMVU9yM2FuNk5uQnVMZGEw?=
 =?utf-8?B?bjBwaU5DS1RhUXZOUGwyZ1FmTzNyNURYMGlCUlorbFBDWjIxakJ1UkZlbHhl?=
 =?utf-8?B?Y1RCMDJzSDhBeUdaS0ZaYzBhTW5TOC9UYmI0K1ZDUG1ET3AzWGkzMlprdjR3?=
 =?utf-8?B?SnVkZXQxODFnZGVpU3JVTDhqVUlRdFV1SkUydmRzMFBOeExkRWdzOVZVV2pq?=
 =?utf-8?B?ZktZeFVwaHpFNGkvdElWelJGVXRTejFtRXM4WVg4R2R5Vmg4SHI3L3htbmJt?=
 =?utf-8?B?S1JDSFp3WWRYbDJFa1ZSZlkzRENmRThVRXE2SHFZM1pyNnh4elJVV0ZjaGs2?=
 =?utf-8?B?b04zaWVKem1say9OVTRDTVJiVUFmcXFwdGt1cGsyc21xVGRLT05PajY0MGRC?=
 =?utf-8?B?bVkvbDE4UjBMVEJEcStNd2xMSHZtelI4M1FiN3JrN2ViSmFLVTR4cUpjditn?=
 =?utf-8?B?NGZGNDlhcWNMZ2phNUo1RkN5cm9tRXRleXVSdHJONVoxcDFoL1NMbERjeEJj?=
 =?utf-8?B?M1JTWGhtN2Y0UlBLb0RGZzVrM1ZVMzhSV3hLdTlGYWZYSjJzVUg4MmljQkpL?=
 =?utf-8?B?RUxkV0xwcXFPVnFacTB4NHhYQTZIR0IwUktKK0RsdnY4U1dzRDZJdnZvTkdZ?=
 =?utf-8?B?cmtDYlNWR0FnMlV2RWtjS0ozZ0d4c21tRW1nNGFLaDVwUXJiQjdpaUJaUW55?=
 =?utf-8?B?YmRnUHVrdUh6SXVQdnVEbll3MVVVUkJyQmNxRERla0xXa3FoclR6dFJRdW5P?=
 =?utf-8?B?TXdzbHBpYW5laDVxZzE3dE9LaGowSGVEWFRnUEJnTEFZa0ZpSDVKTkFnUE1P?=
 =?utf-8?B?WDV0dEU0U3k4bjRPU2VBbzRkemJkMmJJMUVTRUxpYkpXNGsyMXQxZmRwejRo?=
 =?utf-8?B?ekJnalVqUFJuVWdoaGxwZUNSL054WmJIaFZrMk10U2hyTUpucVlpSGNqU3Z3?=
 =?utf-8?B?U0ZrWENHc3M1MElnOE1XRzVVRExKM0VQbXd6R0ovaERkSkJUYkducThPVFgy?=
 =?utf-8?B?NXBrUklsck9SR0tQU2RLY1U5ZTlxUWNZZW9qWnRpUmpqMDhGeGNicGpFQ1J6?=
 =?utf-8?B?YXFLUW1HSVlPY2k1Wnp0SGkrMWlVbVFMRXZOcGJNWVA1WTRFUmtwL3hLVU5a?=
 =?utf-8?B?ZnZhaHAzdUpEb2FYSlkzdHNnb0doT2tTNDFBR1NhWTVHVWM5eHducEVjWVcr?=
 =?utf-8?B?Y1NTcExKTTZWNk9jRC9ITm1zaWRuUHgzd3ltOHlSWFdQVDNpU3N3Mmg2YWpi?=
 =?utf-8?B?c0FNQW9zWWIySjlheVFKMTRRRUZ6bGRJM1pGK0VxbzJaRjE1Z2tTUXBvd3Nq?=
 =?utf-8?B?RTZXQ3ozbm5wck16YXNPZUxqZW92NkNPNDFZcnYxZ1Jxem9DejFFS2puWG1O?=
 =?utf-8?B?OHRiM0tZdGxCbWczUVRlWlJoYW5XbkhGZmZLYUNqcE1xdUM0SkVJMVgvSGxV?=
 =?utf-8?B?ZWJCQ3FMSmRVN05LQnFMREJxeW9aM0V3QVJodHhNNWV2c0hjWndaVTFHL0Uy?=
 =?utf-8?B?MzFraEpSdjBKOER3Z2NHeTJ0Q2s2RXFuSmFkRWhNZU5uTklCMzdBdkZKOHBP?=
 =?utf-8?B?cDhTdC9VcklNTjh5V3RTSmJmYS9nN000Q0llN0MzbVozb0p6NU96SGt1YndB?=
 =?utf-8?B?QVF3cDkxb3NzanVDQU9jVGpIWDRZUFU1OEVEUHZGZkdFbXFQOWZpdUtYYkxu?=
 =?utf-8?B?VVluZTlvUXR1SGF4MmlEQ1lYY3NEUE81dS9KTlVLUWRhMkQzYlhOQUdmNG44?=
 =?utf-8?B?cnRGTElZVFRGdzJ4NVh5eFNTNlpmdXpVU2FxS1l5K2ZUaVpHRkJaTEk1Y0lp?=
 =?utf-8?B?eTRlZGNPZENPRERJRk1vQUd6NEladUFCOTZOR3oyZFR4MFI4Y2dhdG0zQzM2?=
 =?utf-8?B?U2crQ2NqYmlZeTBHZy9TakxML2lZUEcvTjZ2WkRpK3d3QWVYWWdJNmtvMlBN?=
 =?utf-8?Q?X3zc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlxcGNMd25wa3hONzlnSUI3U2NWVUlZTlhrSktMWmRlUnhhYVdvVitiS1p2?=
 =?utf-8?B?TStsSHlNcmRFRXBrQWlCOTdFWWJqcGxlWFNiZ2VzOUlYZlF1YjNZSEdwaXlx?=
 =?utf-8?B?UDF4ZXZPeTBXMXBPcFZEaUl0WlpGTHRtR0ZlY3BkaGNLNUoyaEtWT0FXSzlt?=
 =?utf-8?B?MVhldGY1OXR5aHNzZlBzWUMzY3hZeVRkVzBGQ1ltU3JMUnFqMmNXNHgxcTNi?=
 =?utf-8?B?Q1pjTjh3MnhuakxXbDJIcTdCUEo4bjAvM0NGYlB4MWhLSnAvYjJKZXd3Sktz?=
 =?utf-8?B?TnliZkRpYUtJYTEweGpJY0syRTg3N2RDelhBaXNUaS9mZjFRL0xmSU51V0xw?=
 =?utf-8?B?VzAxdlZzNzBoNW1QcUU5Q25qYkIzSmFncjJWbU93SWhRVUozcVNhV1gvTWUw?=
 =?utf-8?B?d24yRXZodDdjN3hDc3JRbk5YeWVuNDFuRDR3UkRrVlR3bUEyc21NZmEwbnpV?=
 =?utf-8?B?c2MxandnVEJGUDEwaEVtYWFYcHJod0FRdXFFbXpoeExjMzdONWUxMWx1ZGZ1?=
 =?utf-8?B?c28yVnhZdGd4aVdVSTlaNytyTU1ham5YNHNKUlYzVlZIbUpIc0xqVFF4TUQz?=
 =?utf-8?B?ZWJzSTNwR2JGTzhaaEpyUU1aQ2ZoVENTempyVXVGdXBwQ1Z4d2JxTjFzaHlK?=
 =?utf-8?B?cExMZk1QL0lTd09RSFpYanlJbE40Zk5kYzJQSjhPZXRvOEV4ZkJ1MVpNNWNS?=
 =?utf-8?B?eXlCeU9od1htMGF5WTk0UWFqZDJEUWNQNzE0a1BRMElBRWxvR0lPWGlTb1hC?=
 =?utf-8?B?dEJtdTdDbkxUeFNqcUNsa3creUJuWHMrd1EyZjd1NG00azNTeGQ1aGgzMWhx?=
 =?utf-8?B?bXczdUdzQUl2SHB2bGk5d2VaSEpjM05qZlNBVFlIQmRudmFuS2lySElLWFRo?=
 =?utf-8?B?NWxFUFZld29JUTJUdldYTjhobXlUMWhuVnI0STNqSjdLWmRTTVgwN0NKOWhY?=
 =?utf-8?B?UDM0YXdralZRaUF2Syt5UEhtdjJXT1dhRzhhNUZLMGdvRDRuZDZqYjY3SlQ2?=
 =?utf-8?B?Vk9oWkxTSlZTWkhkOUN2N0wvSDJSVXJhMUlrNTNLTS8xTWtGR2k2UnQzZ3F3?=
 =?utf-8?B?ZUxmeVdKbEhUKzBGSXFic0R6Zy9xWTNtaDJOQ21VNU14Rzhacm01ZTA5OXp6?=
 =?utf-8?B?QmVXbys4T0VvbWw3c2VQUzh0WTJqOE1yT3pnL3l1M2F1V3ZhY2tUdkVWemd1?=
 =?utf-8?B?UUF0eVQ5QS9rdzlZd2g1YTFsN0dmeXRtOG8yZmFwTDJjZnJrZk5hUlEyZlFZ?=
 =?utf-8?B?UU02TnEzTTFvT09lanJTZDUrY3F3M1RvWEo1ZEpVUFY0RmFVR3ZrR2RaN055?=
 =?utf-8?B?K21wM1RtVnJmTXB2RTBvQkc1YmticjZwdmYzYm1OQk8xWDc0NDEyU083V0Vl?=
 =?utf-8?B?ZHdWQVhuNVJhaDUxbkVqOUxIQmVjaFRkL2pzREdBR0U1eXlXWWRGa3BMalFB?=
 =?utf-8?B?blp6S3hEaElhRWtDR3lOVWRkUER0eGpkQnNFTlV3V25NRFM3T3NabnNFMUg0?=
 =?utf-8?B?Z25leElmamlCZFIyODc4YVptMm5HQUFQYXc1bC9NSUE4MnJteUVVZ0tSejhH?=
 =?utf-8?B?RjU2bG1DTjVKU3FNazF3cUpQUzlJdmxUSnk3amRCK2RPeGJMdkZhd1hhcC9M?=
 =?utf-8?B?Ylg1RkFVQW1STHJZMnRUTGFqeVpDS1VMbklTSkkwdHR2eVQ2VDEySmovaFNh?=
 =?utf-8?B?RGF6V3FvOGFxbGxsSVNqbENkQi9EaExET1MzV1E3Q0ZoMDVjL3IrandIclJT?=
 =?utf-8?B?WHpBdFNSbWtPM1VVL1YrS0gyS1FabFBZNFdwdFhjYXZzNVFhOVppRGV6RXov?=
 =?utf-8?B?cW1aTWtZR2NkQWNoZGluVUwyNG95YU0vKzl1SUlHMEZDM21BbHJWd1B2cGk4?=
 =?utf-8?B?RHF3Z1pDY0J0bTZtNTJwVEhnUXVrbms1K0U4WVJZS0JGRXpSeWpiVEFKRXpD?=
 =?utf-8?B?QkU2UzhIRXVmVVBEeWJRSFRuTFVreTFIVW5kU1BqU2NqMXdzZkQvZDRrc05U?=
 =?utf-8?B?S2lWVW1hc1FQRzBuWWdlS1hzMXpCOFQybFFEcGlQTGRxaHBYQ3FSWlY2OGxB?=
 =?utf-8?B?L0s5WEZWYzFvSzk3Q085R1hpa1Y0bjdGZXJNZXBicFVuaGxXdjFNUXdCNEVG?=
 =?utf-8?B?bVpEbmxsWVhOZkZrMzkxN3NPV3ZJZmJwbjAxY25rQ0hVZDIwTHlzM0Fndzhl?=
 =?utf-8?B?OVY5a04xOVJRL0xEUWJzMytrQjBaejFsbmhRclRIWFhqeklQSTlRcEN2aFVr?=
 =?utf-8?B?WjdhN213VWwyQm5MS251WjYzdEtTMkVTVzhLeHowM09reUE3YjRhWnNyNElD?=
 =?utf-8?B?T29YL00wUFcyOU52YkNUekR2dFJrT0p3bjZjVGJwYzhzUExaU2R0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d344e9-3433-44bf-adbe-08de7382aafe
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:56:58.7762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrU6gcim7GQIa0o+BMZ+dxt+jc1tJpgITeksDr06uCz1wITRdscFqp1mY53zz/4+EC8DhqY9RV1hbm/vA/X2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

--------------e5R50MRekigyEmI4YQp2iQ9y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24-02-2026 02:16 pm, Christian König wrote:
> On 2/24/26 09:41, Khatri, Sunil wrote:
>> On 24-02-2026 02:09 pm, Christian König wrote:
>>> On 2/24/26 09:24, Sunil Khatri wrote:
>>>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
>>>> remain uninitialized and during free cause a fault. So to handle such
>>>> cases we better set the gobj_read and gobj_write to NULL.
>>> Mhm, that doesn't sounds correct to me.
>>>
>>> When count is zero drm_gem_objects_lookup() sets the resulting pointer to NULL:
>>>
>>> int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>>>                              int count, struct drm_gem_object ***objs_out)
>>> {
>>>           struct drm_gem_object **objs;
>>>           u32 *handles;
>>>           int ret;
>>>
>>>           *objs_out = NULL;
>>>
>>>           if (!count)
>>>                   return 0;
>>>
>>>
>>> But could be that this was only added by Srinis patch and previously we didn't do that correctly.
>> For now i see the crash due to random ptr access. ASDN does not have the above code and we need to fix it for now.
> Please ping Alex if cherry picking this one patch back into ASDN is ok.
Alex, can we cherry-pick one the change from drm-next for 
drm_gem_objects_lookup, but anyways even if we have an explicit setting 
to NULL it should be okish ? Atleast for now we can pull in to avoid any 
crashes right now and later revert the change of setting to NULL once we 
have drm_gem_objects_lookup fix added in ASDN.. Regards Sunil Khatri
>
> Regards,
> Christian.
>
>> Regards
>> Sunil Khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 18e77b61b201..e53e14e3bf2d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>        const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>>>        struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>        struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>>> -    struct drm_gem_object **gobj_write, **gobj_read;
>>>> +    struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>>>        u32 *syncobj_handles, num_syncobj_handles;
>>>>        struct amdgpu_userq_fence *userq_fence;
>>>>        struct amdgpu_usermode_queue *queue;
--------------e5R50MRekigyEmI4YQp2iQ9y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24-02-2026 02:16 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:adbcf4bf-60c6-4dcc-837d-31c9c59d39b0@amd.com">
      <pre wrap="" class="moz-quote-pre">On 2/24/26 09:41, Khatri, Sunil wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 24-02-2026 02:09 pm, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 2/24/26 09:24, Sunil Khatri wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
remain uninitialized and during free cause a fault. So to handle such
cases we better set the gobj_read and gobj_write to NULL.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Mhm, that doesn't sounds correct to me.

When count is zero drm_gem_objects_lookup() sets the resulting pointer to NULL:

int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int count, struct drm_gem_object ***objs_out)
{
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object **objs;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *handles;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *objs_out = NULL;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!count)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;


But could be that this was only added by Srinis patch and previously we didn't do that correctly.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
For now i see the crash due to random ptr access. ASDN does not have the above code and we need to fix it for now.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please ping Alex if cherry picking this one patch back into ASDN is ok.</pre>
    </blockquote>
    Alex, can we cherry-pick one the change from drm-next for&nbsp;<span style="white-space: pre-wrap">drm_gem_objects_lookup, but anyways even if we have an explicit setting to NULL it should be okish ? Atleast for now we can pull in
to avoid any crashes right now and later revert the change of setting to NULL once we have </span><span style="white-space: pre-wrap">drm_gem_objects_lookup fix added in ASDN..

Regards
Sunil Khatri</span>
    <blockquote type="cite" cite="mid:adbcf4bf-60c6-4dcc-837d-31c9c59d39b0@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards
Sunil Khatri

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Regards,
Christian.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Fixes: 3cf117572294 (&quot;drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl&quot;)
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 18e77b61b201..e53e14e3bf2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int num_read_bo_handles = args-&gt;num_bo_read_handles;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_mgr *userq_mgr = &amp;fpriv-&gt;userq_mgr;
-&nbsp;&nbsp;&nbsp; struct drm_gem_object **gobj_write, **gobj_read;
+&nbsp;&nbsp;&nbsp; struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *syncobj_handles, num_syncobj_handles;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_fence *userq_fence;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_usermode_queue *queue;
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------e5R50MRekigyEmI4YQp2iQ9y--
