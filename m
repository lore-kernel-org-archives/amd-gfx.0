Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1222FCCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8405710EBB1;
	Fri, 31 Oct 2025 14:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZG1WZboY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0563710EBB1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+4FJwrcFBVFlHobO2TmcfHfkg0jigyqO/GeJxUsdgfXRz+8nDlf0jQkxWBcVBlTnzQTYGMpwT2P5Bn/zQT92cf0rOUeJR4RBkQsvOJ5leKM+e15UYMf3U1vHP/Ai/PMEHa7ggFlh7Mr+qgnJ3q/6NdAw7drdIl6Mo2jbRoHpJwtp0U6nEENkHOXn+D/DEtnhAn1rSNYG9R3X6pKBEbmDk848qaRXMvJcLlyLfxT1AIBEstwkkztKPc21C9Rn1DKUBi6zzQz8hHj7o4YNBU2A2oDJU26vZdiVqM7wPHok7uHsCDSHtDt+Fy4I3iPNV9aQi3WjR9Ih5Hgyl0KHlNNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oihb5wbWZ6jjgqToOTZVdIrdUHpkvsyBX42YdFhq+f4=;
 b=UuxAS1BSI4vji/JLcaHFGaLH8S+1imdu0s5a65vl2QWD5mvqTt+aaP6YPixHzahBcqz5d8BJMY2HxPKodFq8dZWGjIQ4PsZ0vCXgLx4bmUAi+l88I3RXTCoIBqAJPVV0JFmgUojN4wFpitWeJuTEelDWriXraVJOJgd0pVXp7ooy6J3J4e+buN9VBMjd4A0uEZ9mkIT5mqZUsE0HTDGh57ToMpVNw7dcy5rsWhTvWks04i+JV/XM2FkGW4JW1T7nRRrG/R9PiKJqO5rrt1QCUGt5kPuXNhfetw5XyymenofIm/PGxLQAI7qNCL8v8ROAN6DTIPWZtH1M4+DlL/92TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oihb5wbWZ6jjgqToOTZVdIrdUHpkvsyBX42YdFhq+f4=;
 b=ZG1WZboYQPiyvPE3pj22FaLTj2xiAQt5s8feE4sK4JBMktf9vqHhgfKu9lQNmVEUCd+OOgAjuFaxStbwkz0QUxouIIU2D8rhfWj8S06qMaqA+Hrqg+I+SR3lY+XQFwOXx1w0pC7uNdbAur8x0EVgkf02pYxTLSFsJ0fVJShBASw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:40:07 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:40:07 +0000
Content-Type: multipart/alternative;
 boundary="------------xCOXVk50aJYgvgjJ2xCsIsU5"
Message-ID: <d2f42b51-3905-4274-be84-d4d086b4f072@amd.com>
Date: Fri, 31 Oct 2025 09:40:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, felix.kuehling@amd.com,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
 <89b6057a-ff21-46a2-951b-b96888f60b3d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <89b6057a-ff21-46a2-951b-b96888f60b3d@amd.com>
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb2e6f6-aa61-423a-671a-08de188b62a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tysrb2swT3JINjlUUVdIczkrSlZMYS84blIzRXBJbkZpWlluWmdhRTcwdW1M?=
 =?utf-8?B?QUhucXFScUhSQzkyUitzSUY0dVVpZ3d5MWhVZXgrbjg0S0lEdlRxR01ESVNH?=
 =?utf-8?B?WmtKTS93VUVDSFlXdGVEaWwxUnRaYlF1QVFGcWVaSDRvc2UxY0MyTzlUNlFM?=
 =?utf-8?B?Q2l3N3puY0RTbU9hdDdnc25LdThVbWNrRmtvRFpXQnFlM2xZUlhscisxWmYy?=
 =?utf-8?B?SHREM2hJaXFvVGNaQzkyYzMyMWVZU3E5TkdpVkM1c1h6T1ZodGYrUUFDNzVo?=
 =?utf-8?B?QlEyRzA4dC9XTThoZFRLMmhaOWlqYkZOeS9VNVlCaVZYeDVqNlI4ZTZlY0JH?=
 =?utf-8?B?NWo3UWVDZXpJVVU5TE0vMm9TMkVkOGpZeW1nUk5XVVJHbzF0UDlocDNpRDUr?=
 =?utf-8?B?eW9TRWtsU2dWVjR0WDVFWTZYTGJWMkoyMU9MMldtdlBSeWZwVjZPMDBrU0lz?=
 =?utf-8?B?MG1SclhidGhEaEs2Q2JkNEovZU9zRTFFQktIS2JTampTTTM3WHZhMVIyTndD?=
 =?utf-8?B?YXdaOFYvSlUvMElqMzlaSEFSMmJGU0tjNlVWYWRaU3RwenRTMWdmTDZ3YVUz?=
 =?utf-8?B?RENUWFJ2S0VpMUdhRitNU0d6ajg1Rk45M0FKNVVBaDVscm03bzd4SU5aQmZi?=
 =?utf-8?B?OUVQR2lPOHRWY1E0TGdUb2dKbnZPRlpVKzhqemQ1bzBWNCsvckF1cTlHamNh?=
 =?utf-8?B?WjFPY1BlR1oydmhPSFYzK1BKUHYvd3BMNDVQbVJpeDhxTmt4SlRMaURKWVNn?=
 =?utf-8?B?OWdjOW1MVm9YWHI5blRIZHhxa1ZYdGlrUm50WkdDaDdhR1N5NHZGT1VBdHVm?=
 =?utf-8?B?MjNVb2tQd1lBMnZhRk9WVXFGUWE3WEZaekI5ZXd2QWpRRHJYaXNqRnpicWFV?=
 =?utf-8?B?VXkyak9nODIyUmt0dGtqUy84QzFkZGJtVlIvRzBrMmZPajYyWG44Y0h4UkN2?=
 =?utf-8?B?SmxwR0lKNDJPdDdNUEFjZDRvMW1OTnZ2alNLTUZDcUpuamJyRjBoK2FnYlkx?=
 =?utf-8?B?QmFVY0hQOUV4L0ZvU1ZGZitwRERwY2JMbnE0bjBoemk2UVBYWnBoYnV2YkdF?=
 =?utf-8?B?UHYzMFk1bTY0TzVrWndTczlnTFpYVlQrS0wvS3FrNmg0ekFIcFFYQlhSMk5G?=
 =?utf-8?B?N0NFOThWWnhFWGlyRHI4ZEpkUmZjcG82dGt3WFhYLzU1QWhsQ1diaHIvR3Fs?=
 =?utf-8?B?UngvSzcvUEQxV1hCUnN3QTNqR0NROGhXakZVS0dWOWowN0pYUllZcVluR2tC?=
 =?utf-8?B?OFhBY0JBWWZqRmNnTEwzZGtVYk1nVVNpNnlUY3VsakxIa2tjYVFZeUdDUm1y?=
 =?utf-8?B?dmo5Zk5mNmZqYXYxUndwTlI0NWJOb2lVNXB3bEJ2dnMrQTNMRlQ3MmZ0TjNl?=
 =?utf-8?B?d241RnRWMjdYVnFtSldleDVJenhvZjQ2NTNCYk9ZKzJGL24yQlpvYWRQY2x4?=
 =?utf-8?B?MTBKUkVxcVJSTUhqVDZ6VHFvUllnSEM5MC8yTVYzb0J0ZzVXVitWRWVla09s?=
 =?utf-8?B?WnVjak56QVF6RDI1UVhhRDRGQ3lZc0YxOWtmWTlIRGJJR1BZcnkrbEFsU25K?=
 =?utf-8?B?ekJpWi9nWjR2ZTcxRy9JajlxbTN5SEFFWkVMbXd3Q21WS0ZpRktJR3UrQ3pn?=
 =?utf-8?B?M2l1TUZDZ2tCTEczQ2dBamJHSmJya0hMWWsra0ZWcW5jVGtTbWhMZEx5MW5p?=
 =?utf-8?B?QS9sSEZRbk5IOWE2cHpkSFFiR0ttN0gzeFMxc3lXbnhBTjc5cjdzUzNaUUlI?=
 =?utf-8?B?T2Q2TWxOMXArMkJjR1E0QkVmL3U2T1BqaWFMMUd6K3NReTIzRmdROWRxc0hM?=
 =?utf-8?B?NXdHcnMvRmE4UjNrOFZrQ0RSSFloekZ2WmJZRTNGdzQrU1pHSzllY1NqYXA0?=
 =?utf-8?B?SkRlbjNiYjMvTUQ1WURqMzAxQmJnTG5hVERBNjFodHNkMGVkQkRUVkRLNGxp?=
 =?utf-8?Q?fcrDCO+TTDuI0gCDq6WLqIjkY1XapABb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlrMllHM2xWam00RnBCZ2N5cjFQUVoyWnpDSER2NWtwK24rUjdPVHU1RjY0?=
 =?utf-8?B?TTB5eTlPRVMwd0t1V1o0RWM1Tkl6VmxjVmY1aFpyVWVhOGswck9HOFlHVkxT?=
 =?utf-8?B?MDhZbG9XaEQ3cDhqV2RKNTBWeFpWUk1pVlFMNDhDVmRjVDRYalhTT3ZZWEFs?=
 =?utf-8?B?TzRvNS9KcXk2RFc3VkJEbjR0U0ZDb1hDMUhvZDVUUlh6cVpNZXIxcHBISW1r?=
 =?utf-8?B?a3RFbkowQm1PTHg4TWxQYkxieVRHZXhSUnVJS2pUT3ovclR6eGFFTk1sWEo3?=
 =?utf-8?B?YXd3Z29rbFVSSEllZk13MDZHZjhKaDFDaC9ubnB0NHFmc0NsQ0Jud296NTkr?=
 =?utf-8?B?eGtaZS9aVzVOVlNwTDN4TjZNbTJ1T2JVOFpwN1pBSFFNZW5WWHNSdXBtREJV?=
 =?utf-8?B?QVgwQmZKNGgwYWlXM3c4QllOd0lJR1hGemhRMFNweXZ1dXN1eE8xR0NkaGsw?=
 =?utf-8?B?OWZDSmZURy9zSmJMR1hIZVJXTE1kNEtlTldZcFlQbGVQc3FYOEY3MDQ4Wmcw?=
 =?utf-8?B?MXBtVElBcklhcEd6ME1LZ1BaYVpKSzRaU3Q3K1hVUzhPaU1HRDVFRXA3SmVj?=
 =?utf-8?B?ZXZUTGhVeXJYWnpHcUhiWHkyUTBoVXpIMXprTVpmMzNjbWpFTThZalVrT2lr?=
 =?utf-8?B?MXgwYngyU3k0NWFYVTNmUEN1L3NUcUFzaWxjU3J4YU9zREYyZHpVczNteEdx?=
 =?utf-8?B?SkZYM0Fna0VHV0lOOGZObi96RVdTQkMreVFLc0VqVzFwY0k3em9MM2dUS2dV?=
 =?utf-8?B?Um80ZHNtT3JTbVI3bzk1aURuN25ad1QvZGlnTGNSeHVhNk1pekNqejRZTnUz?=
 =?utf-8?B?ajlJNmRmUG9wcG13VUMvQVdXQWZ5OVR4M1dvNkhJQjRJK3BvaS8wc1hDZ3ZU?=
 =?utf-8?B?ZmJvS1p4K3MvSkNPVVBNaVAwdWUxWVh4dkFYNlQydldSNXhkVW5KaTlxYnI0?=
 =?utf-8?B?d2NvbkcxNmtFNTZ2OHRYNzk3OFBBczBrQk42MGhXdmgxc0cxa0FJdW9ONFIx?=
 =?utf-8?B?WXVpSzE4UHYzSU9zWkQzVDJuMlNpdDltSGxGMFQyQXdPNVBEaUZSaEVaRlhX?=
 =?utf-8?B?QVpVQ1ZWcytHOUZva2hnWW1XQnlWNHBVNDFDOWZXRlFaOHlFNXFVRXpITmEx?=
 =?utf-8?B?bG1aa3RoVEc4UVgxeHFveUNSOGJuUkZCL2wzSGg4UnNuOEVUaUhkNHd2OUhT?=
 =?utf-8?B?WTdpNm42ZjN6TVkvbXp3NmxGWTFMRlNWSUxWVHJac2JFS29TR2hrWTZVanF5?=
 =?utf-8?B?Q0NKK2d4OTdmWDVrMjYzc0poeVFuSzN0VTkzbGpaNk5GL1llazU4SEpxYm5o?=
 =?utf-8?B?eHFwNlo2OEVaS1NZY2NxdFV6WDR0VFgwWnpEblFsYUhadU5yb2tmU0JGaUE3?=
 =?utf-8?B?K3VGMkJNMWRjcURoNFZiTjQ2NkE1TnEvc0dkVnZ0cjZGN0VMOWloMGtjZm8z?=
 =?utf-8?B?NUVOQll3S3VTUlVDbnpvMXZ1czVpbHZPZ2hvSWJSakRMdWVjdzRpcWtjdjEr?=
 =?utf-8?B?UVd0MFo2aXhRdEVSd2xQZ09FL2d1OHRjMVczdUNFV2tDdHhURVVuZUhxNmpq?=
 =?utf-8?B?ZVVubGNNbHQwOVpQcytLWCtzZ1NVNGo3ODFZclhOczUvWlFqVWRlT1hWNmtv?=
 =?utf-8?B?d1lnWlBwVzZIclN1TFlzblZ5Mk1jdTF1MUdHclh4ZjB4RGVzYy84Z3BoaXZJ?=
 =?utf-8?B?eVNaWGVDeWJ3SU1qdFQ4VmM2cDJhZ2tCc1ZYdmJQZjEraWc0Q205TkZGYTVU?=
 =?utf-8?B?empnUDAvRDNpVUl2TXQ3YS9nYkpvQnRLQW4zei9uemJTSXkxUVpTWU93eGVq?=
 =?utf-8?B?WTMwc09nTi8rUDVCM0k0bFpnRGlQS2hzTGp3TjRzZ1ZHTWd0NS9TWmszOGZS?=
 =?utf-8?B?aGdLZkpDQkJwWjh1QSszcFF5Y3I4a3Z2RXpmOHdrUm5nY0hiVmJFSkVyY2FX?=
 =?utf-8?B?eDQveWlmSFVpMWZVOWJZb2tXQ0JaZDZuTklacDlxaURkdnVwdTc5b1dCdm1T?=
 =?utf-8?B?dklhL0pnMjUwYkJrK2puVEE5cmZ6Smw2Q3JQb09mQy9oWEthaENlbFlFWXJX?=
 =?utf-8?B?THFrV3NJTEFsR1F3SzczaWJPTkwzRzV2bnhxdVc3ejU2MVhBbkRCOEhjM2Nj?=
 =?utf-8?Q?tj7g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb2e6f6-aa61-423a-671a-08de188b62a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:40:06.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP9bteeP/3Shff0gexWwKZnzG9bNAacCKQcoAhG4PQ9OlwMmVuf4yzj6d7yCIwCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

--------------xCOXVk50aJYgvgjJ2xCsIsU5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/30/2025 9:48 PM, Zhu, Lingshan wrote:
> On 10/30/2025 11:53 PM, Chen, Xiaogang wrote:
>>
>> On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
>>> The pasid is a per-process-per-device attribute,
>>> therefore this commit implements per
>>> struct kfd_process_device->pasid in sysfs
>> This per device pasid is used internally in kfd, not used at user 
>> space. So no need to exposing it.
> current sysfs implementation exposing PASID to user space, but buggy value 0, this commit
> intends to fix this issue.

It is just for keeping current tools working. The PASID value has no 
meaning for use space that it would not get useful info about driver 
through it or uses PASID to change driver behavior.

Regards

Xiaogang

>
> Thanks
> Lingshan
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 70ef051511bb..6a3cfeccacd8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>>       bool has_reset_queue;
>>>         u32 pasid;
>>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>>> +    struct attribute attr_pasid;
>>>   };
>>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, 
>>> qpd)
>>> @@ -983,7 +985,6 @@ struct kfd_process {
>>>       /* Kobj for our procfs */
>>>       struct kobject *kobj;
>>>       struct kobject *kobj_queues;
>>> -    struct attribute attr_pasid;
>> We keep it to have use space tools(ex rocm-smi) work as the tools 
>> still read it before they change.
>>>         /* Keep track cwsr init */
>>>       bool has_cwsr;
>>> @@ -1100,12 +1101,6 @@ void 
>>> kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>>                       int handle);
>>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>>   -/* PASIDs */
>>> -int kfd_pasid_init(void);
>>> -void kfd_pasid_exit(void);
>>> -u32 kfd_pasid_alloc(void);
>>> -void kfd_pasid_free(u32 pasid);
>> This part is right, these declarations were forgotten to remove.
>>> -
>>>   /* Doorbells */
>>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ddfe30c13e9d..24cf3b250b37 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct 
>>> attribute *attr, char *buffer)
>>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct 
>>> attribute *attr,
>>>                      char *buffer)
>>>   {
>>> -    if (strcmp(attr->name, "pasid") == 0)
>>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>>
>> Same as above we keep it to have compatibility with current tools.
>>
>>  Regards
>>
>> Xiaogang
>>
>>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>>> +        struct kfd_process_device *pdd = container_of(attr, struct 
>>> kfd_process_device,
>>> +                                  attr_pasid);
>>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>>           struct kfd_process_device *pdd = container_of(attr, struct 
>>> kfd_process_device,
>>>                                     attr_vram);
>>>           return snprintf(buffer, PAGE_SIZE, "%llu\n", 
>>> atomic64_read(&pdd->vram_usage));
>>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct 
>>> kfd_process *p)
>>>        * Create sysfs files for each GPU:
>>>        * - proc/<pid>/vram_<gpuid>
>>>        * - proc/<pid>/sdma_<gpuid>
>>> +     * - proc/<pid>/pasid_<gpuid>
>>>        */
>>>       for (i = 0; i < p->n_pdds; i++) {
>>>           struct kfd_process_device *pdd = p->pdds[i];
>>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct 
>>> kfd_process *p)
>>>                pdd->dev->id);
>>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>>                           pdd->sdma_filename);
>>> +
>>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, 
>>> "pasid_%u",
>>> +             pdd->dev->id);
>>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, 
>>> pdd->pasid_filename);
>>>       }
>>>   }
>>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread)
>>>               goto out;
>>>           }
>>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>>> -                      "pasid");
>>> -
>>>           process->kobj_queues = kobject_create_and_add("queues",
>>>                               process->kobj);
>>>           if (!process->kobj_queues)
>>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct 
>>> kfd_process *p)
>>>       if (!p->kobj)
>>>           return;
>>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>>       kobject_del(p->kobj_queues);
>>>       kobject_put(p->kobj_queues);
>>>       p->kobj_queues = NULL;
>>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct 
>>> kfd_process *p)
>>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)
--------------xCOXVk50aJYgvgjJ2xCsIsU5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/30/2025 9:48 PM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:89b6057a-ff21-46a2-951b-b96888f60b3d@amd.com">
      
      <pre>On 10/30/2025 11:53 PM, Chen, Xiaogang wrote:</pre>
      <blockquote type="cite" cite="mid:050ba477-c7d5-4420-8f06-6fce0db48726@amd.com"> <br>
        On 10/29/2025 10:45 PM, Zhu Lingshan wrote: <br>
        <blockquote type="cite">The pasid is a per-process-per-device
          attribute, <br>
          therefore this commit implements per <br>
          struct kfd_process_device-&gt;pasid in sysfs <br>
        </blockquote>
        This per device pasid is used internally in kfd, not used at
        user space. So no need to exposing it.&nbsp;<br>
      </blockquote>
      <pre>current sysfs implementation exposing PASID to user space, but buggy value 0, this commit
intends to fix this issue.</pre>
    </blockquote>
    <p>It is just for keeping current tools working. The PASID value has
      no meaning for use space that it would not get useful info about
      driver through it or uses PASID to change driver behavior.&nbsp;</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:89b6057a-ff21-46a2-951b-b96888f60b3d@amd.com">
      <pre>

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:050ba477-c7d5-4420-8f06-6fce0db48726@amd.com">
        <blockquote type="cite"> <br>
          Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++------- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18
          +++++++++++------- <br>
          &nbsp; 2 files changed, 13 insertions(+), 14 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          index 70ef051511bb..6a3cfeccacd8 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          @@ -864,6 +864,8 @@ struct kfd_process_device { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid; <br>
          +&nbsp;&nbsp;&nbsp; char pasid_filename[MAX_SYSFS_FILENAME_LEN]; <br>
          +&nbsp;&nbsp;&nbsp; struct attribute attr_pasid; <br>
          &nbsp; }; <br>
          &nbsp; &nbsp; #define qpd_to_pdd(x) container_of(x, struct
          kfd_process_device, qpd) <br>
          @@ -983,7 +985,6 @@ struct kfd_process { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues; <br>
          -&nbsp;&nbsp;&nbsp; struct attribute attr_pasid; <br>
        </blockquote>
        We keep it to have use space tools(ex rocm-smi) work as the
        tools still read it before they change. <br>
        <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr; <br>
          @@ -1100,12 +1101,6 @@ void
          kfd_process_device_remove_obj_handle(struct kfd_process_device
          *pdd, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle); <br>
          &nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid
          *pid); <br>
          &nbsp; -/* PASIDs */ <br>
          -int kfd_pasid_init(void); <br>
          -void kfd_pasid_exit(void); <br>
          -u32 kfd_pasid_alloc(void); <br>
          -void kfd_pasid_free(u32 pasid); <br>
        </blockquote>
        This part is right, these declarations were forgotten to remove.
        <br>
        <blockquote type="cite">- <br>
          &nbsp; /* Doorbells */ <br>
          &nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd); <br>
          &nbsp; int kfd_doorbell_init(struct kfd_dev *kfd); <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          index ddfe30c13e9d..24cf3b250b37 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct
          attribute *attr, char *buffer) <br>
          &nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct
          attribute *attr, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer) <br>
          &nbsp; { <br>
          -&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0) <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0); <br>
        </blockquote>
        <br>
        Same as above we keep it to have compatibility with current
        tools. <br>
        <br>
        &nbsp;Regards <br>
        <br>
        Xiaogang <br>
        <br>
        <blockquote type="cite">-&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name,
          &quot;vram_&quot;, 5) == 0) { <br>
          +&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;pasid_&quot;, 6) == 0) { <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
          struct kfd_process_device, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_pasid); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%u\n&quot;,
          pdd-&gt;pasid); <br>
          +&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr,
          struct kfd_process_device, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;,
          atomic64_read(&amp;pdd-&gt;vram_usage)); <br>
          @@ -662,6 +664,7 @@ static void
          kfd_procfs_add_sysfs_files(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create sysfs files for each GPU: <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/vram_&lt;gpuid&gt; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/sdma_&lt;gpuid&gt; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/pasid_&lt;gpuid&gt; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i]; <br>
          @@ -675,6 +678,10 @@ static void
          kfd_procfs_add_sysfs_files(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_sdma, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_filename); <br>
          + <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pdd-&gt;pasid_filename,
          MAX_SYSFS_FILENAME_LEN, &quot;pasid_%u&quot;, <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_pasid, pdd-&gt;pasid_filename); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; } <br>
          &nbsp; @@ -888,9 +895,6 @@ struct kfd_process
          *kfd_create_process(struct task_struct *thread) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj,
          &amp;process-&gt;attr_pasid, <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;); <br>
          - <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues =
          kobject_create_and_add(&quot;queues&quot;, <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues) <br>
          @@ -1104,7 +1108,6 @@ static void
          kfd_process_remove_sysfs(struct kfd_process *p) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL; <br>
          @@ -1114,6 +1117,7 @@ static void
          kfd_process_remove_sysfs(struct kfd_process *p) <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_vram); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_sdma); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj,
          &amp;pdd-&gt;attr_pasid); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(pdd-&gt;kobj_stats,
          &amp;pdd-&gt;attr_evict); <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd2kgd-&gt;get_cu_occupancy) <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------xCOXVk50aJYgvgjJ2xCsIsU5--
