Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5777C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D42310E642;
	Wed, 14 May 2025 17:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GXk8Bxim";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B7810E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQ1U9AliNFKxoWa4aWTpufllZa1Nd8hPuuMJ8r80q+bCanpnfwozTvgQgInxwvjkFHPL6MHw54qvnj7kR30Z9N87Jtngl9/K4gk5Ti/KZ+SgpxshKTo/+/KVUb59kav22RaTY0mrcmtTnEI2//U9wwHYAW0U9Z7icUdDHqrJdt2i8M4LywtfG3yf3whwrUJo9TIZ/IPT0VrAQgKN3m5oDLJmeMsOtDv/6UxeAzDEBUCcsrK6nHTL++qXLVGPPJuCwYZ3dT7iVBONMIGP7ioPqhLA3MNyJsbjoyOPSPvpGXqsSFRAJwD75tmkvd4hA04Sri1CAHXfxO/T+q1SYsF/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3yMsbzzjAtGoI2CYZBs0AdFw7xl6lrerHBwXuAINzQ=;
 b=svYdpI4rEPqp5e2hYy0JqTjo3PB/ZYSMofVO/p3LiORMbBOCD9D6FLAr1AAEO08aPLZawYwEeUefo8w8iqd5zfpSD4l/fXhL/FjqwCkI0tOWhRKxfees1mHziyTAIu+wnbJRvGUuMOgNr3lATTcwY/BoT84QAgeKJwKLUWpZs+pIjsylUwXJoF9simxA9XnufEfXsQ1AedMfmx8l5drhupQGDF2mJJUPs4usbnyi3HxfEyYjcenr8LMVUfpEduoGMf/W9v6rCCXM6f7FBE/vdJHkzdjq9dVMjQTPJcUJp2W90jXtfo9Gb2LAjGoLQENlXPGOM0fnPYpF3rhe/pXGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3yMsbzzjAtGoI2CYZBs0AdFw7xl6lrerHBwXuAINzQ=;
 b=GXk8Bxim9IVPnOzg65W71R0m6Cn4oc0xtgpr515Mbs99W7+B6RdRJ1SXlSXiCvebx39WfrL0LmCY/MemWjrs+pht1V9lnNETbHFFMJKJyurPkLDkXkcnJztA5l5oAbipJhuSdIqMeBnWg14qOlM99qOp+8b0yYocxKpFSbEek4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 17:45:19 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Wed, 14 May 2025
 17:45:18 +0000
Content-Type: multipart/alternative;
 boundary="------------H6g0OufrPHfdEuxahHIR4uvI"
Message-ID: <3cd702fc-f855-4243-8ee7-0de429ba29f5@amd.com>
Date: Wed, 14 May 2025 13:45:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] drm/amdgpu: read back register after written
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
 <20250514172251.726484-2-David.Wu3@amd.com>
 <SJ1PR12MB61949015407F2749BDD2A8499591A@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <SJ1PR12MB61949015407F2749BDD2A8499591A@SJ1PR12MB6194.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d993887-d317-439f-5c3b-08dd930f1783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVJJdHk2WDlJWG5ETVZIZ1pUcUxkL09pcDBpczB1Zjg5UmYrM2RTQi9BeVhY?=
 =?utf-8?B?RDFtOEE1Z1hNU2R2QjdaUmIwaWRNTk51V0R3eFVUWG05VENXVFhuWG1vL0w0?=
 =?utf-8?B?TnRFdkZEaElONzkyOFVwdHVNNUxVVStXODdTQUdoUDVSd1NRem1ZSWNQOFdB?=
 =?utf-8?B?UDFEdVhPS3hvaW9OZjRjL01wbTE4d2xCbGplc0NzQW85WDJhZWFZM0VlRHMy?=
 =?utf-8?B?Y2hTWUN1aWJsR3hRNnVZY1V5c3Y4R3VIQVorUzQrWmtuQ0ZFelVsbU5STHVZ?=
 =?utf-8?B?bzVEOVlyMi93TW9JeFlnZmxTaVB4a0lxaG5LOUk1RVFLb2tXZ0pzVktXcjMz?=
 =?utf-8?B?clFiV1hrR0pSRGdkTHE4SzZpdzMxVlN3RWRRRStuc2xtdGdLOG03R1B3aU1T?=
 =?utf-8?B?Z29JRTY0bnVkbnZzWjhqaDBEZTA4eUVPQkQvcC9aM1Rid3hHT2J2a015YVdp?=
 =?utf-8?B?TG4wcXlWMjFsdHlVbXd6a0FXdmJOLzRIM3hTdlUwUS9LTVowcUszSWhEaXdU?=
 =?utf-8?B?M0oxTlAwK1FiektKSmh3eEFvTkhNVWt5R2FSdW4xb28wL0w2SysybnpjQWkr?=
 =?utf-8?B?QzJhQlg1SGhZOFh5U2VjTE9sS0RLL3J1c3FJWDBMZTlaeHNoVldyZXVTTGJQ?=
 =?utf-8?B?bzF0cEtxNlMvRE5LYzNDeUpKNUc2QWpSNXgzeFkvQUpQMSsrL2hYWHFtY0d1?=
 =?utf-8?B?Kyt6RUZ5M2NmM051eGZQR0xwWmprY1R3UUpNOTJIYWxNSHBxRjlEOStoalpy?=
 =?utf-8?B?YldZaEV2TGx5MkFMMzZNZWtVRlRMUy9YRTlGT0dCNWtRT1hKUmJJZDJIYUww?=
 =?utf-8?B?dXZ6OWJlUFdZZm1YUURVREJqU0pkS0ZabEI0UGNMSUNUVjRJZUhreTMvTDBP?=
 =?utf-8?B?RHJFNWdTUEpwZUZuaFVydXgxbFVlRU5sYVdsMU5MSUhLR0ZEd1NjRkVNeDVF?=
 =?utf-8?B?VWhucC92dnR2UlU2c2gyOVFzdUlsZnZHWm0zcHE5WHJRdXhTWEUwUGZPeDBX?=
 =?utf-8?B?bjVURVBGNE80WndiR3hQdEhuRUt1Y28xMDk5WXBjTkRiQUJaL3I2YUoyN1Rq?=
 =?utf-8?B?N2pvWC9ZUDRvb3Zwc1dOUjlBbWNsZjhKeTd5cjlzditMTkFJOGl0SzNHamJL?=
 =?utf-8?B?YnROcnJnVGd6Q2hTUEhVVGNxQk5Ka0gwNHRja2Mvc2RTRmFFVFEybnJwZmhM?=
 =?utf-8?B?cThuZjdxNFRvQnptOFZCVU9zenU2RjN3SlR1TEw3WTFaQ2RkMk1vL3kwdDYv?=
 =?utf-8?B?K0FnUzYwZHRYK0pRTVlTS25aZXFyU1F6T1JiYzREUjl3dUw3S3lUYmR6WjFJ?=
 =?utf-8?B?S2RqM3d6a3NydThiSy9iM2dVNFpVaFVXV2hPY2VqdDBZS3NxTVVpTFpKejZ4?=
 =?utf-8?B?ZHhaV21hRjh0a204WXpPWnhQZysvTXg2VjZJcldGRGI4WGk0Wm00Z2huZ0lV?=
 =?utf-8?B?NHpGRmVxQ0djdEU4TW5OQWQxZEpNNHF0UUxuOEE5ZVdqTVd6ZHQvRjBlbEVY?=
 =?utf-8?B?UUVjMVpMRWVkNDVKbTJiekpnLy8ycE1UZnM4VmtqdFF4Yy94cUdPeUFDSUx6?=
 =?utf-8?B?MGd4K3ZMaFZNL2dIMkt1cSt1UFErOGdoWGhDYng0QlU0THdma1lQZUFiQlNQ?=
 =?utf-8?B?aGFNYTBHV2FKT1NCeldGZ2Z3dndrS1IyZ0kxYk92aXpKaEJaRkpDYU5qMHR2?=
 =?utf-8?B?WFZmSnJwd3J1YXU2cTM3WTIySjBLaGtWVk5sN1NNK01hOGhqUUpGZ2o2dFVI?=
 =?utf-8?B?bXJKenNwOVZyWGt5WWJQVmxpd0srSlBzSmF6SGRUcldiSVVuUDk5dVhabVJr?=
 =?utf-8?B?NVAzZDN4TVRyb0ZyZC9kbjJOK3JyaE5Wdy9YbmI5bVpmb3Y2N2J1QmxZYzVE?=
 =?utf-8?B?V3hKMlAvcFRidHV3clpTaThNbEJsSjRHYUg2cDFJRWZxT09oTUVHaHNhRDNJ?=
 =?utf-8?Q?7aUXRtWX828=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVNvajV3TXNLbXlhTnBGdDhVakQ2TWlHS0cxUzVaS0MzUXpENzNuT3FLeHZH?=
 =?utf-8?B?ZHR3c2FJelpuRDR5THpiQm5rV0piRitrdHJCOWVWWWRSQkl3ZXdNb3J1VGtq?=
 =?utf-8?B?VFpKZjkybEhORjNiMjA2NWhuREw5S0QyVlNPcXJldzBCbTVpYW9UTm1XOW51?=
 =?utf-8?B?aXk0SU9qZjUzQTQyLy91M252YkRLeUNwUzZ6aFo0RFZuUC9xekF5c0tnaGxa?=
 =?utf-8?B?Q1c1VllOeEYrd2JrOVNHSU5rZ1JnUU5GTGltYitJcXpWUzg2MWVXcUJJQU9O?=
 =?utf-8?B?SVAyM1ZXLzgxckZOcVZxbE04Qk1uTFo1aTZIM0pTQmYwRUc3T1ZwY0dNUisz?=
 =?utf-8?B?VG5kYU15YnhLQjNhaXVURysvMEZKR0Q5L2RtOU5POVg0Q1czcHFlOGVYdS9z?=
 =?utf-8?B?OFpHMElZdzh4TUxqWEFEYnpFd3VrRVVlYzhlSlRyU20xR0tmak1XUjNkZ2Ry?=
 =?utf-8?B?RDBmaFpaMjFGSlFqZGRQK3NtdmFNZ05NWnNvMW51cFRDa3h5OFVoUVVWSTZW?=
 =?utf-8?B?Q3JHUXduOEU4aW9Sa1BvdmRreFRHNzc4d3UxTG8rM0lvdWJSVFpCYzl4VitC?=
 =?utf-8?B?UFFOb285N2ZEcC9iakt5NnNjamFBSFhKNDc3c21MVjdqNXBQVzNFTHhVdmQr?=
 =?utf-8?B?SENwUHJQak1uTDNXNzdQamFyK1M5akdzYVE0cDYzVGZycGU2b3pLcnNrOG1H?=
 =?utf-8?B?cUMvRWRqVVpsaTZKdEF5bExERkkzWitXdTZ3YWdiUFNNLzFSZVU1MjJHLzk4?=
 =?utf-8?B?bThyeGJONjJkdDdZM1VLOWQyNVpmZnd0SERFSWo4QVlacGUzMUxqbHVZVzhX?=
 =?utf-8?B?Zjk1cWNKNFczS05tbHBVb3Rtd1c5TmczZXRWWlpFRHA4bzdiaGFGZkJqQksw?=
 =?utf-8?B?SFpwMWE2MTMvc2hZenVZZDhVN1doWTV5VUt3U3JVK0l6dHk4em5rTkEwNFlv?=
 =?utf-8?B?OENLaUZDTVRqZWQ3dlFxdDc1bUUwSllBMmZPRWVoZjljemg4eEhNblFQT3E4?=
 =?utf-8?B?Z3ZPQ3VHUnZqOTJMc1FqQUlxcXBNT2pjMC9RK2hZNVM5V3VpOEwrTi9CUjJk?=
 =?utf-8?B?ZUdXbCtlZ3d0SEJnMXdYREFISERzMEtiNGVWaFpjZVBKblV3dkNCTWpiZW9X?=
 =?utf-8?B?anBTZ0pEYzRJTktQdzQ1Q1k5OUo3M2VZYWpYZlMzc1dydEZQREU1WEwxMzkz?=
 =?utf-8?B?bi9XQ2pHdnUxTWFEVkVRdHlPT2tpK2dLWEErbEg4UkE4K0d0SE5SSnM3ZjF4?=
 =?utf-8?B?KzA4TEx2ODFaTXBBa0lyR0dFY0h6akV4OC9DaUZ4Sk5nMWZBalhSa1U4MWQ3?=
 =?utf-8?B?VFNxZk9LOWVUckFVVDQrTlFRRVpkUUIydGduWHRFdjNxTktuWmhHMCtMSGlp?=
 =?utf-8?B?WndhRDVZQTB0cTBYUGlYekNlZEwyMXBNR1hGckFnVGwybldVVFF5RHBpNU95?=
 =?utf-8?B?dUwyUDhGeUMxK2JVV3hHRzJxZkNUenZJT1BqZXpYdUs0YUEvK0taZm9LOEVG?=
 =?utf-8?B?RDJwMG9neXdvYk5SY2Yra3NHeWFzTll4WVNERVBPaHZSMGNJbGdnMjFheFFl?=
 =?utf-8?B?MjNJMGdpc2VDbmZRZGNCVWtCVjN6Q0liU0ZOWFIvMm1ObTF3ZkxTOGE1UTJ2?=
 =?utf-8?B?TzU3ZVN6d1h3NjB6V3A4SHQvYWlCL0theFJUeTFGVENyeEFrVCtPRGlYNzRK?=
 =?utf-8?B?cWhGYWVFemRhY0FWSXNBTkc0WGJaYktqZVJKOWhvR054cU9zVkx4b241dHhY?=
 =?utf-8?B?K0tIdU5RM0daVjlBdDhrM3M0a21hOHZuQllDRDgwNThYUTB6bFZrMHJSL0pV?=
 =?utf-8?B?dzI4Qm9HY1RUS09aTU1uV2FPUHl6TktrMmNQamZZeFd6QXZmWXBUTDN3SUZZ?=
 =?utf-8?B?SDlqZy9sU21VYUZHTExCWmF4eXYxZ1VZeDdaSGVRSFVXcVh4bWlHckdGR054?=
 =?utf-8?B?OEQxRXdhTzRraW1ZelFIaXpoWWZIelliOFo3RDc4eFVzenBuR3piZmZpUi9Z?=
 =?utf-8?B?REpyd3hUZStCaDFhWGhzd3dPUktzcC9TZWNLejNaR09UK1JGdysrRlYzVkR2?=
 =?utf-8?B?YTViNEQ2dmhTK0dGMnBLSzV6MjVoMUFOL2VDN291YnNTdVVjWm1uQzcxV29o?=
 =?utf-8?Q?xmFVRGS1KttA9uSTO6RzyennD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d993887-d317-439f-5c3b-08dd930f1783
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:45:18.6993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tB0iFWsmm2pXpyP/tRYIVZn3LdjtHJdE6EZj8dxIev67ZtbUdQ2E/93UYtEbLo0vuAQc/dL4s0FfAEWoeBuvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

--------------H6g0OufrPHfdEuxahHIR4uvI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hmm... I knew that - but I would rather add that in case 
jpeg_v1_0_start() might change.
A little conservative ...

Thanks,
David
On 5/14/2025 1:33 PM, Dong, Ruijing wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> This patch is not needed as it has the read-back in jpeg_v1_0_start();
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Wu, David<David.Wu3@amd.com>
> Sent: Wednesday, May 14, 2025 1:23 PM
> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander<Alexander.Deucher@amd.com>
> Cc: Koenig, Christian<Christian.Koenig@amd.com>; Liu, Leo<Leo.Liu@amd.com>; Jiang, Sonny<Sonny.Jiang@amd.com>; Dong, Ruijing<Ruijing.Dong@amd.com>
> Subject: [PATCH v1 1/8] drm/amdgpu: read back register after written
>
> The addition of register read-back in VCN v1.0 is intended to prevent potential race conditions.
>
> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 21b57c29bf7d..f56b623713c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
>
>          jpeg_v1_0_start(adev, 0);
>
> +       /* Keeping one read-back to ensure all register writes are done, otherwise
> +        * it may introduce race conditions
> +        */
> +       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
> +
>          return 0;
>   }
>
> @@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
>
>          jpeg_v1_0_start(adev, 1);
>
> +       /* Keeping one read-back to ensure all register writes are done, otherwise
> +        * it may introduce race conditions
> +        */
> +       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
> +
>          return 0;
>   }
>
> --
> 2.49.0
>

--------------H6g0OufrPHfdEuxahHIR4uvI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="Helvetica, Arial, sans-serif">hmm... I knew that - but I
      would rather add that in case </font><span style="white-space: pre-wrap">jpeg_v1_0_start()</span> might change.<br>
    A little conservative ... <br>
    <br>
    Thanks,<br>
    David<br>
    <div class="moz-cite-prefix">On 5/14/2025 1:33 PM, Dong, Ruijing
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SJ1PR12MB61949015407F2749BDD2A8499591A@SJ1PR12MB6194.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

This patch is not needed as it has the read-back in jpeg_v1_0_start();

Thanks,
Ruijing

-----Original Message-----
From: Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
Sent: Wednesday, May 14, 2025 1:23 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Cc: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Liu, Leo <a class="moz-txt-link-rfc2396E" href="mailto:Leo.Liu@amd.com">&lt;Leo.Liu@amd.com&gt;</a>; Jiang, Sonny <a class="moz-txt-link-rfc2396E" href="mailto:Sonny.Jiang@amd.com">&lt;Sonny.Jiang@amd.com&gt;</a>; Dong, Ruijing <a class="moz-txt-link-rfc2396E" href="mailto:Ruijing.Dong@amd.com">&lt;Ruijing.Dong@amd.com&gt;</a>
Subject: [PATCH v1 1/8] drm/amdgpu: read back register after written

The addition of register read-back in VCN v1.0 is intended to prevent potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 21b57c29bf7d..f56b623713c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)

        jpeg_v1_0_start(adev, 0);

+       /* Keeping one read-back to ensure all register writes are done, otherwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

@@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)

        jpeg_v1_0_start(adev, 1);

+       /* Keeping one read-back to ensure all register writes are done, otherwise
+        * it may introduce race conditions
+        */
+       RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
        return 0;
 }

--
2.49.0

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------H6g0OufrPHfdEuxahHIR4uvI--
