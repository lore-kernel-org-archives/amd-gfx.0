Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFCEB2711
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5005010E07D;
	Tue, 10 Feb 2026 21:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RufZa+2k";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528B710E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7CvvyqBJ25iCP7usKDgzMrFfhmqCNvlCs0DUyrfR3c96pLuvNjPOGtsScqt2dHgK8bJAz5qnEHUGws5DJF7ETr68PTdtjTNZS++oZy7Pf0TRSwqXzcaPmrUjAUB8uF7XxWMIWbn0WG5a0+8cAP3plXM0NidjPx9hBo1LcX4AHKBv3JoTRRDA1i/RfCaX73A2+Qf6Cr5N8A44vMzzdGeqEqzStt+P+jdntgl7P/lSKVx8tzWJGAhf3aGjV4Hbf37m9WBisu4/z8GmLCaeWJypoOEnJYzKLENskyOjA8ui3LmFc2ZITK+dojFAzVS+J70Bo+jJPBvIzx3c1RRymCeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beFG3h8HFvZxTmObIsBOeyYtmAl5J+D+yBrX3jbwGWs=;
 b=bLGJAo4bSpoQuBpFbbrsaOVAkbuZsTMXGfdNskJH09sBLd6yeVsSW6uI5syXNG2pxQnak/50jEA8tD6LyTDlN+mIpRcdgU96mswcVwAaO6dDqe3XqtkydqB6sMWKq0BJhV/nmK42c85fYwv6yr1VdjBWYaeZnhHHsrI0YRYso3WOv/H8uwdSzPAscbUDKuxwAcHP3+TSOcYE/uEtMIBbCs0W9K0Vi303x70WABbwFJx6Btmm1Mt9tn30KAAqAK7hlzU9zkb6rEgBukoDf1g8ueJatTEhlYXbw4Z9cGfT47MMty8rCKp/vXlbuZyRp6QKFY8BoLYHEY+/0+b7LHplOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beFG3h8HFvZxTmObIsBOeyYtmAl5J+D+yBrX3jbwGWs=;
 b=RufZa+2kxGRWaSAZSWXNkwZ4DI0lPY1WAoH6EQOm8uLjIY3WcMsx1GeyvDStq6lVZXMu48fzYWnK42bWpW4MaS/8WdMLiMY15WIFOOvqTmqN5DHMciYYPz382lIciRH52u6hlZFmCr1wANta+ghiu3ByvKW9GFbLLnsBWAY9wYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH0PR12MB999111.namprd12.prod.outlook.com (2603:10b6:510:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:01:32 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 21:01:32 +0000
Message-ID: <dd76192d-50ad-4672-82d6-ab80562299b9@amd.com>
Date: Tue, 10 Feb 2026 16:01:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/uapi: add profiler interface
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Cc: david.belanger@amd.com, chris.freehill@amd.com,
 harish.kasiviswanathan@amd.com
References: <20260122150916.3069923-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260122150916.3069923-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH0PR12MB999111:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e6f662-1eef-42a0-127c-08de68e7914c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3duaVRHem4yVlhJMFMrZ2JvTUVEVDhKekxnZlRaelF2MzBJMlB1T0tTT3Jy?=
 =?utf-8?B?OU9NVnlYQzBTeEdPdHBZZ0RvQjltZ2p2Vi9iRmJpSzFUQTg3SGU0OWNkaTJv?=
 =?utf-8?B?endqZXozbmxEZzdnTURaVUVyUkxRR0N1bjNvQ1hlZHdJUG5HSU51MFNWeVd0?=
 =?utf-8?B?enlPVjhldUJXYnB1OHpUVzVsWVAwV2UzY3ZwSzdTUk0rTDVCM2c1TXl2UDJK?=
 =?utf-8?B?aytrcHFiTWZzd1B5VVFHUG1CVkl5TlJYeHVWbDBOOXh0R1orKzJiNVFhUEpq?=
 =?utf-8?B?NTR2dTc2N2poN1Uza0paSXNzbW1wbHJ4OXMxTVA5NHNzWlNOZjJUUGl5M04z?=
 =?utf-8?B?aDF2VkdUelAxU3lUWjlsYjBIc1o5VFZpeVR0KzBiYXFwK0dwM3AwN2hGZEZs?=
 =?utf-8?B?THFZUU1SdEcvV1RNM0F3U3hBVHRrVzM5b3lMMkpQano1a3hTbEx4ZnZ0U1c4?=
 =?utf-8?B?MllpOC9LVy9vQjBLZnNabk1jMHgrTjRCVWthNVRuM3MvdVZCYkNGY2xVTVNV?=
 =?utf-8?B?WUlMTmxSemZsc3VRNnNWa0JSdzNadTZGbGpvTHB4ZGxNT0d6clcvaU05SGdD?=
 =?utf-8?B?WURkbHN2MEpmWVNTTCtJMjhXRmNGbnloY3kvNGNocGpGYkpVU3JoNUE5RkVF?=
 =?utf-8?B?L09FcS93UmhxYldSWjBBSmgrdkpzTWdSVlpUZUJBY3hiU1hnMzNuUCtMK1JG?=
 =?utf-8?B?YkNZdmZDUTZZS3cyM3RETnpWVHJMU3ljRkRGcktNWEtsT0lXUmNHYVpvdlBI?=
 =?utf-8?B?Sm9BZXBmSmt2alM5OXRUbkRFelFSZmFwVXhQZzd2YUtmd0NtK0ZHVzFuVWc5?=
 =?utf-8?B?dkpodFpSZ1E0SWpraW8rUS9US0dDRTdjNENtUFVHeDBlUFFLL3VaV3VvSk5S?=
 =?utf-8?B?NXBCWWllRmF3dUdyU2VoQ01GSkJZTlJaSG9Pd1lqK01CQVFCeU5PMm1pUlR5?=
 =?utf-8?B?K24xZ1JXUEtwSlNrS1lnTnQxbkc4SmUzZG5KMnJLOUxXY1FwcnptK0pKdFFy?=
 =?utf-8?B?d2hEYmdGeWtlODRrcEwyNUlJQzRvWmcwVDdXSVBvL3RvRnBwUEhsVFlYRUtt?=
 =?utf-8?B?eWd3aEJ6Q3E1eGtwS04yZlMvc3ZYZkRkTVFObEttbWYyaG9vNjNZSDZacThy?=
 =?utf-8?B?THU0WHhIQllZbG9HK3VFUjVqQzRoZ1lEQTBpc0VpRThKRjliOUtvUC8rQ2Zh?=
 =?utf-8?B?N0hIU3Z1VjFLZEM1d2x2L1FGOHdyVGVXb21xVkkyNTFHWjc5ZVkvckxNclRs?=
 =?utf-8?B?VkpNM1BlcnlrbnVoRjlDTHJDYnFkMXJsYlp4QWFOeG93a3BialE3ektGaUZS?=
 =?utf-8?B?bE43VHNkL2RqTVdIU2gvbkdBaWkwQWJvcXZRY3J3eEhKbnJWMmtiNGhxTkRX?=
 =?utf-8?B?bU5vZDlWbnJVWkg0dTBGYWJPTlEvR1JkbGkxenhOVEFXNkVBNmFMWkQ3cm1S?=
 =?utf-8?B?SG1iOFhROEFlaWlLUkExd2UranVnTmd3SmFzT3c3QVVIWXppV3RHQU9pNmV5?=
 =?utf-8?B?aFBtbzlNb3Z3L1F1VEJRamwyRjRITWV5dFhRODFmcmxwK3p3ZTBqcGRFUlZw?=
 =?utf-8?B?c1N1TFp3NVdLVEU4bHdlTHJ3QmJnUVpTZngvYmlWdEt4UFNTY3BuTCtrbDd1?=
 =?utf-8?B?cVB6WFBMREZFcGlHNVdlTmcxdFNrQnZkdFZNTGpHa1V6eEVVeXZDaysyTUNR?=
 =?utf-8?B?TkN5SCs1YllOTktyS1ZTZk1TbDdhWTVkSXYwd0dCRldvUkNlUUNmYlRzQmp3?=
 =?utf-8?B?enZPNFZ4RUxGb3dmaEwvVUtRTk4wRFJYNzZNa3JqSU9PMm1MK3cvT2tKOHU0?=
 =?utf-8?B?T0lMeXY2cEN5eWRhRWZ5T1ZTWUtLYlFtY2NvMHRZR1FhVlZOWnI4QzZtVHFY?=
 =?utf-8?B?QlFvUDlmWklWUFZualRuOHpjbEpoYWNhUmc4QXBMYzRKN2ZENDM2cWpHTUpp?=
 =?utf-8?B?M0tmR1B1RmM5enhUa0o5RDNKbjJzSU1CNnlFMC9FNTZSSUxJSFBTdVFUWVpj?=
 =?utf-8?B?UUJKamJZbUtRYWY4aUcyeGsxOFNSTWlyRTNQMzBaVjZlQmJVbmVEOEw3RG9u?=
 =?utf-8?B?VEljQk5sbklkUm1EZ0hqc24rbTh6Nmt6cFozTXlnVVBCcWR3YW1uYUNUWDRh?=
 =?utf-8?Q?U9mE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hjdWJiK3RpaGNBQkEzejZoekdJdThseVpKbEQ3K1BrTk4yYkJlSElwdk1q?=
 =?utf-8?B?dXl1S0VlVTA0dVpxa2EvYVZRSk5ibmsvVUwvL3AxRVhQbnZFY05kTVpuSjVr?=
 =?utf-8?B?aVNjM0IvckVBUzk4WjZRNGM0YThlQjFhSlczUUFkdFkwWVd5MlBjWVlYbWxs?=
 =?utf-8?B?a3dNWU5pZ2o2cW1NdTZqbHRYSFZyMDROVnIyUHVwTHZjU1N4VUxmTFlrUWp3?=
 =?utf-8?B?dTdjVnRTVmxNVE12NTFRSTVoR1RNK3UrSktPZXpuVm1LU3VUbGxibjFXNHdN?=
 =?utf-8?B?SDBuQlh6bjgyMmhUbStWcmNlcVBsSjhqQzNsblY1TFp6MU9wdjU1TUsySzhz?=
 =?utf-8?B?Vm5MSlNRQ0s0WFh3RjdYaUtwdTdaWFVkeXUrU1liMXUxaWZJN3hwc1hwWHZ0?=
 =?utf-8?B?TjRrTEEweGFwZmsrMndoWlVIUVJDa1Y0QWo3ZzVoRGRtM0ovekphMG4veEpL?=
 =?utf-8?B?SWJJTC9XcjFDN0ppMkdQYWt6YzJId1RlT3VISDRuSmFmN3VvMU5mb0lIUmJM?=
 =?utf-8?B?M3ZocWN1L2g0c1NPOFhHNjFTTHpWMzFxUmVlNkZUVERaQnNrakhBd29QNU9O?=
 =?utf-8?B?QjNxTUF4U3BSdjN6anVHeTZtUzR4VzJmaHlVMXVOdzBvcHRPR3RYQTIvZUtv?=
 =?utf-8?B?bUM2Ym1Hd1VjQ01NK1J4NGNtTEFZTHdPQ3RZSzZDajd0RDhqMEhhUGhjYXBh?=
 =?utf-8?B?U2FtWWludkhQUkk2cURSenM4S0ZrVjlXcW1MMzJzRGxJM1g3djBONjEyNTZ4?=
 =?utf-8?B?THpralBPWlIzY1pYdEpVWno3cmhmbEdqblppODhBSGFaa1F0eEQ1UVNqWE0y?=
 =?utf-8?B?OEVjZTE4dHlWcU42Q3Zrb011WUsxemcvRG5vMXNTWHZYQkQ0N1ByRUYwb0I2?=
 =?utf-8?B?Y0thUmQ3VlVDZGZKaUZ5R1gvOElFZjQ5L0p1NDB2c1BJSmZscGd3Y1hzTk9V?=
 =?utf-8?B?UDlUMFRDNzZjWXArNXN2L3lGdVlTekI1VEZBdmpNRC9obExYM0JrMkRuMTlJ?=
 =?utf-8?B?ZlZiT2tWUHZzKzg1MlJwL2tkczRHb3NhQTU3UnQ1N1RqRXBJWVlJVnlWNC9k?=
 =?utf-8?B?NEtXTWU4NDRTd2dkejdyWnNzeWZTNmNja1Q5ekcwS2pUbEQyNzY3RzNSaXNH?=
 =?utf-8?B?OTVNUFNaRUJDUW1QUjZvQnhZbnlEbGl5bThwcGlIYmRUOCsxNlVVK2wyRGI2?=
 =?utf-8?B?YmwwaS9KTHBhQjJqbHRlQys5cHN2RmF2bERFWTY1alV2eCtJbFVMVk01b3RW?=
 =?utf-8?B?akpYLzFDaG5PZEhwYlorczc1TEpDN1ZCMlQ5Rk9vTXZubFNjcVlSTFdLcSt6?=
 =?utf-8?B?cjk1NzA1TlVib0Z5cU1LdFA3Z0tVVkZvREJVL2sxN1ppbU9la2gwRzVtRGdY?=
 =?utf-8?B?TnJwa1Y5ZmhWNjdSSEFzekRzMk1SdGdVbzZzcXYyVU4xS3p4YTVhZTVWSWxt?=
 =?utf-8?B?M0lnRkd2bnpTdGxpY2tKeDAraEpQaDc3a3pVMmQxM3dlbDZFa2o2S2xjdGVE?=
 =?utf-8?B?UEl6VlZQaDE4UEhMRzU1L2NqaFI4UllybmNmdUgwcGNXRkc3bEkwbHJEd0Ry?=
 =?utf-8?B?alhXU0Q4RVVYMmUwYXRFVGZzdXV2VkNUT0dxVzdQcGJLZndla1gwZzhzOUVU?=
 =?utf-8?B?R2FXMUZ6dVhENENSWm95Nys2WllaZUdBbWNVMm1ybTZwSnJaZDJjVkZPRzBS?=
 =?utf-8?B?U1ZyNHRjWDFjWUEzQzB1dGRxV25lb3RxN2VyWUYyTHZ0alZwUHRNKzZlbkZG?=
 =?utf-8?B?STdVNFpqZHl0eVpUVUk2dEp1YSt0RzRkR1FVcGsxczBjNGJkOXNTdmRBdmFh?=
 =?utf-8?B?QnZQVTYxU0JRTjArTUlyVkMxR282N2lyYTNnWTl3RVBpWUp3VVBKdkRQb2Fv?=
 =?utf-8?B?SHVNbXNDcEIxRlVLa0YxVWh1SkhYbVU3VjZUQWw0aVpjRVpLN2FRNVhBcGFr?=
 =?utf-8?B?SlVUQ2hndnZXdWhrd3NCTHZoelBxQTFoY3NoM2JkaUpnOTdtM011TXFGSGVP?=
 =?utf-8?B?Vkw1eDNqdTF0ZEwwYmgzdFVqeTFya3BpUTRiM2M4cFdpaDJaRTF6cUpoWEVv?=
 =?utf-8?B?WG1ocm5wTEEvTitMaWlrSmJPYUV4VSttR3pwOS9WZnRtUzd6ZWtPSDRobG5W?=
 =?utf-8?B?ZWdvcjU3Mk4zRXVXNW9CQjMzY1NrTklaZmhPcnFGQU9WQTBsanVJUnBGNlJn?=
 =?utf-8?B?S1QwZTdKVHM0UitFQjQrUUd5RmFvY01MZ2N1MEtiSmdkODB0bUhEbUU0WTcw?=
 =?utf-8?B?elh5S0lrTGF5dExvS3JIV3RpcGRhMW8yUDBlZ0JrM2VFa1dMQXh4V09SZzFn?=
 =?utf-8?Q?NzaSei6ydGjdfQeIV2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e6f662-1eef-42a0-127c-08de68e7914c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:01:31.9201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkGewKUJp9xvg9XXx9QQKeLTODJOVUaBvL/dA6wY8i3VIJqTId+ZLI+ZhWRpwlzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999111
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

ping ...

On 2026-01-22 10:09, James Zhu wrote:
> to contain profiler kernel driver changes.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 114 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  69 +++++++++++
>   include/uapi/drm/amdgpu_drm.h                |  19 ++++
>   7 files changed, 213 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ebe08947c5a3..835900318353 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>   	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> +	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> +	amdgpu_profiler.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 314a498c5726..bf3ad584dd41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -115,6 +115,7 @@
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
>   #include "amdgpu_userq.h"
> +#include "amdgpu_profiler.h"
>   #include "amdgpu_eviction_fence.h"
>   #if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
> @@ -1319,6 +1320,8 @@ struct amdgpu_device {
>   	bool                            userq_halt_for_enforce_isolation;
>   	struct amdgpu_uid *uid_info;
>   
> +	struct amdgpu_profiler_mgr      prof_mgr;
> +
>   	/* KFD
>   	 * Must be last --ends in a flexible-array member.
>   	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index cee90f9e58a9..18d83f0c47a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2936,6 +2936,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>   		fpriv->evf_mgr.fd_closing = true;
>   		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>   		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		amdgpu_profiler_mgr_fini(fpriv_to_prof_mgr(fpriv), fpriv);
>   		drm_dev_exit(idx);
>   	}
>   
> @@ -3044,6 +3045,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 75976ca00ccf..6ea4d52c8634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1573,6 +1573,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	if (r)
>   		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
>   
> +	r = amdgpu_profiler_mgr_init(fpriv_to_prof_mgr(fpriv), fpriv);
> +	if (r)
> +		DRM_WARN("Can't setup profiler\n");
> +
>   	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>   	if (r)
>   		goto error_vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
> new file mode 100644
> index 000000000000..157e6d2f888e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,114 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include "amdgpu.h"
> +
> +/*
> + * Profiler revision change log
> + *
> + * 1.1 - Initial revision
> + */
> +
> +#define AMDGPU_PROFILER_VERSION_MAJOR 1
> +#define AMDGPU_PROFILER_VERSION_MINOR 1
> +
> +int amdgpu_profiler_ioctl(
> +		struct drm_device *dev,
> +		void __user *data,
> +		struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
> +	struct amdgpu_profiler_mgr *prof_mgr = fpriv_to_prof_mgr(fpriv);
> +	struct drm_amdgpu_profiler_args *args = data;
> +
> +	dev_dbg(adev->dev, "Profiler IOCTL op %d on render node %d xcp %d",
> +		args->op, adev->ddev.render->index, AMDGPU_XCP_ID(fpriv->xcp_id));
> +
> +	switch (args->op) {
> +	case AMDGPU_PROFILER_VERSION:
> +		args->version = AMDGPU_PROFILER_VERSION_MAJOR << 16 |
> +					AMDGPU_PROFILER_VERSION_MINOR;
> +		return 0;
> +
> +	default:
> +		dev_err(adev->dev, "Invalid option: %i\n", args->op);
> +		return -EINVAL;
> +	}
> +	return -EINVAL;
> +}
> +
> +int amdgpu_profiler_mgr_init(
> +		struct amdgpu_profiler_mgr *prof_mgr,
> +		struct amdgpu_fpriv *fpriv)
> +{
> +	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
> +	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
> +
> +	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
> +		return 0;
> +
> +	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
> +	if (prof_xcp_mgr->is_init) {
> +		kref_get(&prof_xcp_mgr->ref);
> +		return 0;
> +	}
> +
> +	dev_dbg(adev->dev, "Initialize profiler on render node %d xcp %d",
> +		adev->ddev.render->index, fpriv->xcp_id);
> +	kref_init(&prof_xcp_mgr->ref);
> +	mutex_init(&prof_xcp_mgr->mutex);
> +	prof_xcp_mgr->xcp_id = fpriv->xcp_id;
> +
> +	prof_xcp_mgr->is_init = true;
> +
> +	return 0;
> +}
> +
> +void amdgpu_profiler_mgr_release(struct kref *ref)
> +{
> +	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
> +		container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);
> +
> +	if (!prof_xcp_mgr->is_init)
> +		return;
> +
> +	mutex_destroy(&prof_xcp_mgr->mutex);
> +	prof_xcp_mgr->is_init = false;
> +}
> +
> +void amdgpu_profiler_mgr_fini(
> +		struct amdgpu_profiler_mgr *prof_mgr,
> +		struct amdgpu_fpriv *fpriv)
> +{
> +	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr;
> +
> +	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION)
> +		return;
> +
> +	prof_xcp_mgr = &prof_mgr->prof_xcp_mgr[fpriv->xcp_id];
> +	if (!prof_xcp_mgr->is_init)
> +		return;
> +
> +	kref_put(&prof_xcp_mgr->ref, amdgpu_profiler_mgr_release);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
> new file mode 100644
> index 000000000000..18da6267562a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_PROFILER_H_
> +#define AMDGPU_PROFILER_H_
> +
> +#define AMDGPU_XCC_MASK(adev) ((1U << NUM_XCC(adev->gfx.xcc_mask)) - 1)
> +
> +#define AMDGPU_XCP_ID(x) (x == AMDGPU_XCP_NO_PARTITION ? 0 : x)
> +
> +#define fpriv_to_prof_mgr(fpriv) (&fpriv->userq_mgr.adev->prof_mgr)
> +
> +#define fpriv_to_adev(fpriv) fpriv->userq_mgr.adev
> +
> +#define prof_mgr_to_adev(x) \
> +	container_of(x, struct amdgpu_device, prof_mgr)
> +
> +#define to_prof_xcp_mgr(x, y) \
> +	container_of(x, struct amdgpu_profiler_xcp_mgr, y)
> +
> +#define xcp_to_prof_mgr(x, y) \
> +	container_of(x, struct amdgpu_profiler_mgr, y)
> +
> +#define mgr_to_adev(x, y) \
> +({	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(x, y); \
> +	struct amdgpu_profiler_mgr *prof_mgr = \
> +		xcp_to_prof_mgr(prof_xcp_mgr, prof_xcp_mgr[prof_xcp_mgr->xcp_id]);\
> +	prof_mgr_to_adev(prof_mgr); })
> +
> +struct amdgpu_profiler_xcp_mgr {
> +	struct mutex                      mutex;
> +	uint32_t                          xcp_id;
> +	bool                              is_init;
> +	struct kref                       ref;
> +};
> +
> +struct amdgpu_profiler_mgr {
> +	struct amdgpu_profiler_xcp_mgr prof_xcp_mgr[MAX_XCP];
> +};
> +
> +int amdgpu_profiler_ioctl(struct drm_device *dev, void __user *data,
> +					struct drm_file *filp);
> +int amdgpu_profiler_mgr_init(struct amdgpu_profiler_mgr *prof_mgr,
> +					struct amdgpu_fpriv *fpriv);
> +void amdgpu_profiler_mgr_fini(struct amdgpu_profiler_mgr *prof_mgr,
> +					struct amdgpu_fpriv *fpriv);
> +
> +#endif /* AMDGPU_PROFILER_H_ */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1a961f62724e..5d8439174fd0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> +#define DRM_AMDGPU_PROFILER			0x20
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>   
>   /**
>    * DOC: memory domains
> @@ -1708,6 +1710,23 @@ struct drm_color_ctm_3x4 {
>   	__u64 matrix[12];
>   };
>   
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +	AMDGPU_PROFILER_VERSION = 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;                        /* amdgpu_profiler_op */
> +	union {
> +	    __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
> +	                                  * lower 16 bit: minor
> +	                                  * higher 16 bit: major
> +	                                  */
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
