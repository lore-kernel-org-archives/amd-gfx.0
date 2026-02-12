Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EFEEEA870
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 23:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CD210E0E4;
	Thu, 12 Feb 2026 23:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I7Yrtp7u";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB9D10E0E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 23:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTK3BHJ68Z5EGBaBCPG60G5zb2ztIu2rsPyjaIkM4D660UkyuaGB5/u4jH2pMkwNaCjtOehBJ6B/cvrcp336xAcOziOuUxP4V0A9Mnvn9eQiDeirQq1zLncS9c9R1pjavUZccIX2DwF1r2yPl6d3D/aLMtUEkOQvehbfKdI/DPR0r0SXYdZF2E5TJjORBdHZHrgVl4Rykxhcm2cASkf0z+3h3cT7dFtHxQrQ4vM4ixKNExWludRmL8fNAgIgiwzq3j3XGbVjNZAx/GPfeFr3IP2aPkLqXSHPYfkjDVnNIMNDOV9sO7GC28dcehYZCN5Fx51ZUfw4lNp4F1HjfJWL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9m9Co3pdkBpzDNwvIu/N2VbzPUh1Bu26MWi/IZco08=;
 b=oHm9afJ9G1coUrPHI1yUwvPwySvq0tMiBz6SeHk9p5D0Xq7KCdR1cwWwDAZuuiAdfbBSOq1OwWbH9qUh8uOKvUdRS2kMeiiIj/JC2IaZ7gopf5apazsHZj33SoQO41t2K6Mcgq1UEPsZpM2YmksO8N+w0cPbEdB2WWFadSUzsToG3nmJSgDfJPedb/QWO6xlFeF0ZlBpmUQ4uvmve4fWccAD3XTQ/mvdKmM0IMrhOaiqiPtLIqybuhRzoGjdCDvc9VtTrv0Svo2HlWrG2WRqetQlqOoXZMdjyNu2Ee9Y/ThrifHgkNEQRU/vJ/Uvos5IBvUUwLxzHQH9qZCb9osGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9m9Co3pdkBpzDNwvIu/N2VbzPUh1Bu26MWi/IZco08=;
 b=I7Yrtp7u2fIS7MPXCJJ1dBNsGVcqFzqBliZ7+a13ig7fGyHqKTmYMraIdRsV9oK6gXPZ6agYePDQOKYvwBw9azB5kxUCrKXaMzRJW3eN1vN3vEeCt37cvyoYBva0sY4iW1q16go0jL9XhbF/PkRZBsVDQ3qE8Q4ifIT0uNUu/7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 12 Feb
 2026 23:28:05 +0000
Received: from SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::6901:6c89:2155:ea8]) by SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::6901:6c89:2155:ea8%7]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 23:28:05 +0000
Content-Type: multipart/alternative;
 boundary="------------c48qlvCX0rRuaq5eODJ135o4"
Message-ID: <c8ec163f-55e1-408b-a653-c94c618826f3@amd.com>
Date: Thu, 12 Feb 2026 17:28:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Liu, Alysa" <Alysa.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <SJ2PR12MB8650F18EDC866027298677818C60A@SJ2PR12MB8650.namprd12.prod.outlook.com>
 <DM6PR12MB440105A544332F3281D7013EE360A@DM6PR12MB4401.namprd12.prod.outlook.com>
 <CADnq5_O1XTsw9uKWbaj+LMr6K1ON9hvzd+geHF6pr_+EMJdvWQ@mail.gmail.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CADnq5_O1XTsw9uKWbaj+LMr6K1ON9hvzd+geHF6pr_+EMJdvWQ@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To SA0PR12MB4416.namprd12.prod.outlook.com
 (2603:10b6:806:99::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f783eb-c1f2-41ee-72a7-08de6a8e5e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVdmdGVxQVVoZVV0MDhRVERQYUc3cWhjdWsvREk3ME8vcFlmR09CaVRwVHFQ?=
 =?utf-8?B?MExoZkZqSTg3ZzlPQ1hTNVZVYy9GWklxckk4ZDZUYnc1c2tBQUhQbWErWFFR?=
 =?utf-8?B?REl2a3dIbWV5OThJTnJBWkFidyt1eGRWbDhSbit5VE12YVZ3Q0VXQys1Z1pl?=
 =?utf-8?B?YzVvSFdscStQeko0Rkl1TnhUSytzS1BhZFE4Sy9OQ29uWVJuSUNORVUxQ09N?=
 =?utf-8?B?eTV1Y3JGUDRKSnJ2RFhndVNUcDNjOGRMYWl0U0s0NGo4d0d2ZHNjamt0bytH?=
 =?utf-8?B?OUxnUjdqYVRtTnJkdzVzYThvM2owa0x0OTNjUlN5SGRTYi9ITUJac0czOFRW?=
 =?utf-8?B?aTFvSHphMEgzOWsvUFVURnl6UGpsMG5mRmZkUTZQUlVteUJQb0VPYVRDRU4w?=
 =?utf-8?B?NEJ2Y0NTY25oVjMrVTVNdDNGYVpaUHE2ZWZxVDZYc0RkbDViaFBTVmZQd2ZD?=
 =?utf-8?B?RHBpVTRBcGdhS240emRpa21JeWRNcEF2SDZJWDdIWU5XZnliNmxtWXZiNW40?=
 =?utf-8?B?eXhMQ2laeWptWlhQWDdJUFBHU3UwT2dlYWdTR3EyY1hOYzlGcm82WGxTVFMy?=
 =?utf-8?B?RDc3cnhXSGQwdmtzUk1mdGt6YkRpR0hNc0pjRFc2SnFzcUh2aGF6Y1ZNbUIr?=
 =?utf-8?B?ck9MMXV2bThmTlJnS1VIWkttbGsrQXVtOXNEdHppaFQxSE5LdHlZRFh4Y285?=
 =?utf-8?B?dTBjM285MXJQSjB4a3BqODlDb3VReUlIaE02OU5ROURMZ3UwVzI2WWtUeHdj?=
 =?utf-8?B?SGh0V0hMSys1dy9haTdyQUFXRDdObnVITTNYL2ROSEVycTVSbU1DbmY5bEVt?=
 =?utf-8?B?dDBKVklhVWlEMUsxNFlVaHpLSWYvSFUzOU5ZUzA3UWVzQlZQRmJwSklrb2s5?=
 =?utf-8?B?VHAwOEV0d2JhVFZmR1V6Q2RyOUUzTmNrNXVCNSt6NE9SeWpyYTIrcTJ6UUFJ?=
 =?utf-8?B?cUU4bHFzSlZaMzJIeDdaSzRuOFZvK2d4VzFyb3FIU3hreUNBZk1NOXRXYU5i?=
 =?utf-8?B?dzY5SG9kbklmYnQrMC9tVVBubHlnbTRuTmR3VVRRcGpEeS9welFhRUdNU21H?=
 =?utf-8?B?bDcxVnNGRHhLOHlFSXNhRzNybkpOSEJOSnFKcVkrcjhYRDFtS0dGbGlISjdR?=
 =?utf-8?B?U3UwNzMzMmlCQ05jOVNCWGhyU3FHZkNXc2J3YlNOWmVhM3FVb2p3ME9KTHRT?=
 =?utf-8?B?VmtJN1V2eVBITWRWTVFIYjdWVWxnNXdweFVXWWYyRCtCUGkxYitmbFBsTjJI?=
 =?utf-8?B?Qm53anQ0ZThVckVuUHFveVJrdmJjeTMwOXlGTEhCdUUwNW9GWmJFRHN1dURo?=
 =?utf-8?B?OGNEdkZ2bXc1cjUyK0Y4cnY2ZWhQbTc0MkZzdSs3Q1BJbjQ3aVZaTDhsTkxN?=
 =?utf-8?B?RWV3ZTkwRjMrb0xQVEdQSzBpMUZnOWEzTGNZaUtQL3UxbXVjVVM1eEZBWUpp?=
 =?utf-8?B?WXo3L2s0eU1hQy9Vc1NQd3dHMEpZdmRVSisrQ1p5dE5NMFlYS0kwbTJodlUy?=
 =?utf-8?B?MFJsUW40SWpGNXRaNXgvcmt3K3dUV1BKaVQxOGx5U1BGTWRkLzZSYk56UkhD?=
 =?utf-8?B?ZTZnZW9JYUQvQ1dDclBDU3dJdzZzeklsSm5paEcxbWk2K2dLaG85VVhyYzJL?=
 =?utf-8?B?djAwYTNvcCtiMnNra0VQS0hBSHBRbGpFdjZXNm1RVlJmWkltTm45eHV1dlUy?=
 =?utf-8?B?WkpQRzVKNzVhYXJCUUZvNjRLOHhGeEYvMHJlaHN3VnhBNXMyRUJxU1ZsREtS?=
 =?utf-8?B?QjRQV0JjS3B0TTZUVG1nY0txZWg3cFBIcTlXa2xKMW9nUVpZeGFHS0t5Z3Bp?=
 =?utf-8?B?Q3B5V0xVS1hEQlBKVWppRGpkQ3JFTHgzRlVyZ0VkTjJ2QmM1a2ZXVFI2Qy91?=
 =?utf-8?B?MWV0LzFpdk1wWUF0dkorVjJRdEplZ1U5Z2xJU2lxcXRERVI5UDBiNTR4amFD?=
 =?utf-8?B?VTR0S1hGQi8wRDVBWkpVdytZNVJ6eTREMXJKbm1yV2hpdlRNVzNDbkpFUk5I?=
 =?utf-8?B?MEp0SEZ3U3NuLzhJVFRoRDBNaTZVTC90TGd5YitpR3BnZ3B6OGVnUW5FZENT?=
 =?utf-8?B?WXk0aUs1TjNoRlYzRXNTS2w0MWVneXlwMGUxdUtkMldlS2xLWThIc0NuZlZG?=
 =?utf-8?Q?qL98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDI5UTc2TEVqbVpacFNzZE5GWXRpMGluQithY21yeG5PdzZ1Z2lxQkd1alhG?=
 =?utf-8?B?NVlROHRMcVBIRXJKeXZHSzlCRUMwTmliQ05FbkFqdEtKTTRvQVlKZXpCVWc2?=
 =?utf-8?B?WUttb1JmSXRjRkNWMmp5RDkwQlNZU2MzV1d4eDdRTXY0UWxsejljSG05Y0gz?=
 =?utf-8?B?WFcxL05aMlZWVW4wRmZsaVFFNlEydW9UUUVoTDg4WHp1MkZrUTBzcDJraDhj?=
 =?utf-8?B?bXVCVkpUbDFxNjZFellGcFRTbjg2TFQvSHNlNno0UTh6a0tvQmpDSjhtWmQy?=
 =?utf-8?B?TWFTK0hVaXdxK2Z0Mm9KSklEZHZnWTQ3SFIwNkxjZjc0emgxZU1KUTBTV2Vv?=
 =?utf-8?B?V2pxdnFmbEpOblkxL0dlbW5GbW85dytRbW5uak92ejhobzdlbUVFeHJ4ZVR5?=
 =?utf-8?B?ZDl3NWg1Q25wRXFDYXEvT0JLQjlQTGdJb0x3dDNWWDU1d04wUWFyekJYNDNl?=
 =?utf-8?B?QXdQdWhYTVhSRDdhR3duWmNuRkszMGUrSi9VTmVRL0JlS0l6WDdOZ3J2RDdE?=
 =?utf-8?B?bGVEVmZ4V1B3SzRkcTBqS2hQY1FEb0RUYkxpaVV2MlE2Q3JDV0ZTaEplVmhx?=
 =?utf-8?B?eEtkMlZqSmlabjZFWkxnZG1yLzJiVVVyQThacEptcExQcTdpOS8zQXI0a1Bn?=
 =?utf-8?B?ZEJld2NQMGUwb1UwR1ZtZnQvVi9Jb3pIWkMvT01MOEFEazdYaG9XeHVTUzl5?=
 =?utf-8?B?QlhQWGVPMzdjcHdKVHhFTVNUOEVJQVJxRk5SZWZhSUVRTGJEWHlNOVd0UEdY?=
 =?utf-8?B?ckRSV1JzWitRVFluVkZhclJ4eFdJWlJqT0t5emNWbjNmZExIOTdtdnAxMDF5?=
 =?utf-8?B?SE5CZHZHLzM4U1FZVnVEcStHSjduWHNydnFDZ1V0NUhPajRkQnVvRW1zTUVC?=
 =?utf-8?B?WGlEKytJZWE0d0J2dHQxV1g3bGlxUEJ1ZDNTQyszd3FLRVcxSy8zNHhSR3pU?=
 =?utf-8?B?cHU2cWpYUitUMXgxbCtIYk55K0d0c1VqUEMralRnRHZaYjJvTVVZQ0Z2ZEhl?=
 =?utf-8?B?L2MxV093b1JJcmMzZjJudmFtOW04ZHozZGE2Tk5EamhNUFBhUElHdWYyL2V2?=
 =?utf-8?B?Q2VMZWN0RjU3VHNKNmF2eDVMS2hyTzUvOHBmSUpNN0RmWStKUjVQWGtNaWVX?=
 =?utf-8?B?WkdNRjFrR291d3RFQ1NlNTY1SHBhdnFHa3VIM0JQeitUdUJCamh3Qm0wQWZN?=
 =?utf-8?B?TGxCajhVZUthaG1IeTlSRk5STUJvcnBxK2h4SFV3THFJT2lZTWx2STR5akVV?=
 =?utf-8?B?U3NMa0syVnNFWnN1b3dHSXV5RDB2enExa1UxWWpaMHBGanAyZy9yaldvOXV3?=
 =?utf-8?B?djRsclI3R0l1Zk5BYXRGY2Z3TmlEZ2RnR3ptOWZDM1hwOUUvUWJyZC9ienBW?=
 =?utf-8?B?T2I5SEVOamlqTzVSVGF2ejJPVE5vNnErbkFydm1URi9aMzZqK2crWEZBbmpE?=
 =?utf-8?B?T2VZWitQNWJFUXQwTGM2dC9qd1dNeC9iSVVLUUJuMHY1UUZmbWtnU05yenBP?=
 =?utf-8?B?UDB1Vi9KSlVLbUhPZU9NNXduKy83aWZQcGlsT3FPcUJBTnBSM3JUa01yMnh0?=
 =?utf-8?B?d2xMMmVCTGxpSHZKZVBsWGpsdkkvYTFQNGs3Z1dtUksyd3UvdHR5MnJkeWha?=
 =?utf-8?B?NzJwSTNYdWwwd1JZZ1RwdStXd21Ucm1MNWtka2FTNUJCcXhyVWtIcmpWRGxk?=
 =?utf-8?B?SnZYaFh2MW9MTzc5S1cwek4wSXdrVVBTSGJKSTVUYTBISkt6NTRhSEFlSWxC?=
 =?utf-8?B?VUc1Q0dJZFVyL2UvaTRlNjVVYlh1L042YVE2L3VnYzFsSnR2QnVFSWVEY0gr?=
 =?utf-8?B?aHpMbnVtNEJxcEk5dTRoLzZqbk55TEFDamEzZ2tHdGxKRFhLNXZ2bGVrSFdV?=
 =?utf-8?B?Q3Fza2c3Qzh1MVZZblA1UnQvN0pTUllraXJicnZJQk5vWUhzSFNqS0xIT2ky?=
 =?utf-8?B?VjVtQlZoWnVob1FYTEtwd2VZc09ydExKWDZ5WldJVUFXc2FNdEo0bFB0RHZ1?=
 =?utf-8?B?ckwxUXIxSitubTBRODFHU2hLNXMzcGdubFo3SEUzNzJsUVJMR1o1RlQwLy9L?=
 =?utf-8?B?YUdXbmxFZXo2WWVtMStSTnh5WFk0Rmhtb1loeGd0eHlZck5JZGVYck13TW5a?=
 =?utf-8?B?TCswWXBtZVluNkpoOHM4amNhUmZRV2wzOGUrVFo3a1o2Y3lMRXpFeHp6RXcr?=
 =?utf-8?B?NTVPUkdjQmFmRTAwSVB3RHkrVGpLRTNxcU4xdnUxdkRSY2tCMUNWY1h5cEFu?=
 =?utf-8?B?dmFVdThmeFVGSzNYN2tMdmZONE5yVTMrdTlta1FoOXVkK3d2ZjJLNXZUa3Ex?=
 =?utf-8?Q?X9Jpy7D4Pl3Peqpa22?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f783eb-c1f2-41ee-72a7-08de6a8e5e75
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 23:28:05.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKRXeKFyj7LNfOPaRlkvMm+v7Snvm2lvdZwzJX50fGpFEWZXkwgQKvgUiS1pxHsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
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

--------------c48qlvCX0rRuaq5eODJ135o4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/12/2026 4:13 PM, Alex Deucher wrote:
> On Thu, Feb 12, 2026 at 2:32 PM Chen, Xiaogang<Xiaogang.Chen@amd.com> wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> Let parent/child process share same vm will cause multiple issues. There is no use case or need for that. It should be prevented at uses space, not work around at this specific place in driver.
>>
> I agree that userspace shouldn't to stupid things, but if it does, the
> kernel needs to gracefully handle it.

Using same vm for multiple processes will cause multiple issues. Not 
only race on vm->process_info. This hacking does not reveal useful 
security issue. If parent process wants share its vm to another process 
kernel cannot do anything. This sharing just makes driver not work. 
People can see multiple errors from this sharing. If driver addresses 
every raised issue duo to vm sharing it would be endless.

Xiaogang

>
> Alex
>
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>
>> From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kasiviswanathan, Harish
>> Sent: Thursday, February 12, 2026 12:31 PM
>> To: Liu, Alysa<Alysa.Liu@amd.com>;amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander<Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
>>
>>
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>>
>> Reviewed-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>>
>> ________________________________
>>
>> From: Liu, Alysa<Alysa.Liu@amd.com>
>> Sent: Thursday, February 5, 2026 11:28 AM
>> To:amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> Cc: Deucher, Alexander<Alexander.Deucher@amd.com>; Kasiviswanathan, Harish<Harish.Kasiviswanathan@amd.com>; Liu, Alysa<Alysa.Liu@amd.com>
>> Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
>>
>>
>>
>> Replace non-atomic vm->process_info assignment with cmpxchg()
>> to prevent race when parent/child processes sharing a drm_file
>> both try to acquire the same VM after fork().
>>
>> Signed-off-by:Alysa.Liu@amd.com <Alysa.Liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 00ea69baa126..f7b2358a0303 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>                   *process_info = info;
>>           }
>>
>> -       vm->process_info = *process_info;
>> +       if (cmpxchg(&vm->process_info, NULL, *process_info) != NULL) {
>> +               ret = -EINVAL;
>> +               goto already_acquired;
>> +       }
>>
>>           /* Validate page directory and attach eviction fence */
>>           ret = amdgpu_bo_reserve(vm->root.bo, true);
>> @@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>           amdgpu_bo_unreserve(vm->root.bo);
>>   reserve_pd_fail:
>>           vm->process_info = NULL;
>> +already_acquired:
>>           if (info) {
>>                   dma_fence_put(&info->eviction_fence->base);
>>                   *process_info = NULL;
>> --
>> 2.34.1
--------------c48qlvCX0rRuaq5eODJ135o4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/12/2026 4:13 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_O1XTsw9uKWbaj+LMr6K1ON9hvzd+geHF6pr_+EMJdvWQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Feb 12, 2026 at 2:32 PM Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
[AMD Official Use Only - AMD Internal Distribution Only]


Let parent/child process share same vm will cause multiple issues. There is no use case or need for that. It should be prevented at uses space, not work around at this specific place in driver.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I agree that userspace shouldn't to stupid things, but if it does, the
kernel needs to gracefully handle it.</pre>
    </blockquote>
    <p>Using same vm for multiple processes will cause multiple issues.
      Not only race on&nbsp;<span style="white-space: pre-wrap">vm-&gt;process_info. This hacking does not reveal useful security issue. If parent process wants share its vm to another process kernel cannot do anything. This sharing just makes driver not work. People can see multiple errors from this sharing. If driver addresses every raised issue duo to vm sharing it would be endless.</span></p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:CADnq5_O1XTsw9uKWbaj+LMr6K1ON9hvzd+geHF6pr_+EMJdvWQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

Regards

Xiaogang



From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Kasiviswanathan, Harish
Sent: Thursday, February 12, 2026 12:31 PM
To: Liu, Alysa <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire



[AMD Official Use Only - AMD Internal Distribution Only]



Reviewed-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>

________________________________

From: Liu, Alysa <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
Sent: Thursday, February 5, 2026 11:28 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>; Liu, Alysa <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire



Replace non-atomic vm-&gt;process_info assignment with cmpxchg()
to prevent race when parent/child processes sharing a drm_file
both try to acquire the same VM after fork().

Signed-off-by: <a class="moz-txt-link-abbreviated" href="mailto:Alysa.Liu@amd.com">Alysa.Liu@amd.com</a> <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 00ea69baa126..f7b2358a0303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
                 *process_info = info;
         }

-       vm-&gt;process_info = *process_info;
+       if (cmpxchg(&amp;vm-&gt;process_info, NULL, *process_info) != NULL) {
+               ret = -EINVAL;
+               goto already_acquired;
+       }

         /* Validate page directory and attach eviction fence */
         ret = amdgpu_bo_reserve(vm-&gt;root.bo, true);
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
         amdgpu_bo_unreserve(vm-&gt;root.bo);
 reserve_pd_fail:
         vm-&gt;process_info = NULL;
+already_acquired:
         if (info) {
                 dma_fence_put(&amp;info-&gt;eviction_fence-&gt;base);
                 *process_info = NULL;
--
2.34.1
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------c48qlvCX0rRuaq5eODJ135o4--
