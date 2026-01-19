Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D819CCF2DD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 19:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1638210E266;
	Mon, 19 Jan 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sl5xRvKh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE18310E266
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 19:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY3FF1n2VjXbqZL+pX0UBBEn0xBio2Ue8jr8JYpuUdjK1uZW75l+3oRWyctk1q983tapFPs0BQUFCTeXqXo1i1mqQqkOcAZSy9SmVA8p+oKif6N5fwxFEszRV14OCn/uZLi1+78v5xvw7dfmJAM7pY7hA64s1l8T6hnVbiAVdBHnVnW7xQMWCcV2JnYRVAsJc/0KMPP+asY+iULk6hmPTIOma2ecaET7m4gMDcT6w0z9SbAuVcV/eam2V9dYRk8L2oNyY51d+BP8si6kem9doapslGEodPbjUENZ7z/GDjwrCZ50UBhqTsxiF7zz3kAwHi+0WyBXUxTY5xhRG6r5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvu00nTTES+iOFNNkxbMCynjz0S0L8sav1jUumqKsCE=;
 b=YM6jar4bE3S82UZmejKla5vRvpxsVq0QwSBdCi8Mx5kA8lX6fqs1PbBUglJ95PgdDpm4cwIgX4ZijUDpOkrkYTPLjKKeqF8tYxfES5/6OAz0LGO2qC+XzHnLVZCzlUVQh9mtX8zG3DKH56V/8AUoaDIY11TvK/zAMTCIKiaaj7W+iJWqeXuLmRa4R0JGhN85IYN/ogEPqU3g07UN/UClO+vhoQGnNdQxRFG7gTU2EOlRiGy31dxATZxd7dlYwUJVD80IJGLiMLDUS92Ny+8xXGNJ7dUdvIPGuP/Ro5zJ0qJkeonZ7nlofQ9w9xzdROx1ZRgYjlq2r6N9K3gVoEiCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvu00nTTES+iOFNNkxbMCynjz0S0L8sav1jUumqKsCE=;
 b=Sl5xRvKhoRtpf4y6jGUP4Wb6Vjr9vrmSsCeADNRNqMaWASPuJ2HcBA/CYbaqWkyPQSoS0WvQbtU1CwGE8y1XbjwXX1HsXtqBaWsGb06s5EVyAf77xgxe2QRHL9h+sCB9IKfeKN+myuhalYMnHdSvw7gEvJw6OCSvxlGlOxx8MgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 19:48:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 19:48:29 +0000
Message-ID: <3997de89-eae2-41df-9795-a7d0a572840b@amd.com>
Date: Mon, 19 Jan 2026 13:48:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Only poll analog connectors
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260118130345.43356-1-timur.kristof@gmail.com>
 <47aaaa83-012c-45bb-8f51-8f09c0ad20ce@amd.com>
 <5021716.OV4Wx5bFTl@timur-hyperion>
 <e8616724-0809-43de-9662-f55f9420c2fb@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e8616724-0809-43de-9662-f55f9420c2fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:805:66::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 57de2195-32d0-407c-2469-08de5793b7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGtSbDhnblNKTllVUDg1d0QybnpqWURJbzl4TUw2Y1NUZktnaUZ1U2FiZkpO?=
 =?utf-8?B?TmszUXkvK1Ntb2VnUmk5eUlnbmM3Q1RBMVN5SlhtQlR6VERaTDREMFVZMGh5?=
 =?utf-8?B?YmV0c0psejBrSnJMTlB0a2gzbGFYZGRKQURDa2pvaHRScGs2MkI0b21jMFJH?=
 =?utf-8?B?aVQrVjlDcTJGTzdVMW5rdnh2V2luajNDNHlJeEhNeEw3Vm9nZlB0MHdBNHJ2?=
 =?utf-8?B?Zi9DZjJWV28rMGZZWmxwQ3BFS05DNUY0R3BJdHVtczFEelhMNk5qNml6allM?=
 =?utf-8?B?eVpzYXJ4RlR6SXFNSVVYSktRUXBqMks2TEt4T3BsZ3lWeGtkTE4rcGxSc0xu?=
 =?utf-8?B?bytUODBEQ2ZMUkl2c2czaVgrWUxuUzVaK3B5U0kvdC9aL1B4QTMvOHZJVVJI?=
 =?utf-8?B?anZnMDlPZzFBZ0FiejFnQm1PV3E3TnVES0xDalJndFp3b25iZXZTeXNqZ2Y1?=
 =?utf-8?B?TTBCRFdPUFhPemZBbHp2M2x3V3luTVRWYlZKYWFOQjQxWXRTUHFaZW15ZTVN?=
 =?utf-8?B?YlpUVUYyMHAyUnIycnczRnB6WkpYanRaWU1aY2dQVnU1bjhmRFFscDNTMU1D?=
 =?utf-8?B?K0NVS1ZnbnA5VEVFenEzcndBRDlUenBucXhVTnR5cGFHNm1XaDl0KzYva3p0?=
 =?utf-8?B?TCswQ20ybThBM2xnSzlRT3pHTWh1VlRQNFRKNkEvMjNLOFcvakdqRU9JblJU?=
 =?utf-8?B?WnNMYlBSQitzMHRrOUthS1ZheDFMWEZHd0JZNFA1UTkxRXo5dDBuQzFIKzNH?=
 =?utf-8?B?RGR3a2Zxdm5qYzJyZFpla1ltaUhRRVkwYk9hZnVWaUlOQm1Bd3NQM3d0TXVq?=
 =?utf-8?B?aVhwV0lvTTV5RVNzMyt2eWRrVlJTbTFFWmNnNzI3Y0dZbCtKUSs2aE9mVjhl?=
 =?utf-8?B?RXN5YWN4Y3pIdXV5NjFMSTBMNVh6ckllVVhCUE91U2ZyVlNyYmszQnJyZjNH?=
 =?utf-8?B?ekhEQlR6Rm5EdXBRd1VUREVRaGdwZGVwQkhJYWZ4cGlPK3JIcEcrSmpFTHZi?=
 =?utf-8?B?ZWM2cWVBS1BjZXNuaDZubXR5VHlLK2NkN1hiRUxjdzZyQ3JpbkcxQ2dVa0RQ?=
 =?utf-8?B?RmdkWGlVVFVlL1hMZjhMTG1KS0lkSmpubi9Ob3dNTDVQSHdnaFU1VGRuRVdz?=
 =?utf-8?B?NytMUGZkTkZaOUYxN0FwYUNxcy9qYklhRWxVRTVHbzdzZFBZdGl4VDU3aE54?=
 =?utf-8?B?OEpjajhpeUIyNnpaMEdZdFp0M0NJWjlNaFZiR1lBU3N5Tk16RHB3czQ1K295?=
 =?utf-8?B?U2doZDJlSUsxWk9QdWhHK0pkZnJVeFBrZkNFNGpiU0ZLMnFTaDJucFl3bTN0?=
 =?utf-8?B?dkNiUUFxaFVoRHhyNDhtUHh3T0d3MGlpOWdmY2liZ09wUk5TNXBrSDFmcWYz?=
 =?utf-8?B?YVZWSm1nS3RIcUpFMnIzRStFU0JBU0dWK2RkZkExak9lSGd3UXZ1QndHVzdx?=
 =?utf-8?B?NUx1Q1ZORHRHTzc4NWEzS2FHMWpsZVNHZ0VGZVlaKzROMXQ0Qk5VRXVjQW9k?=
 =?utf-8?B?YUtWR0tBSWNvZkxZWGMzbHFrbUo3UXhFaTgrcllVQTg1OHF3emxwbytVUUp1?=
 =?utf-8?B?OFpJclYxbjc5VGwwMHhweW5RbXo3Q091d05vMEZjb3NsaGZNaW1YU0FHVVll?=
 =?utf-8?B?M1lUZ2VmOHV0NGlIM2ZleCtCYUlOK0lFdnkrYVVndGpIcVVlU29VVVppeExz?=
 =?utf-8?B?TW43N0VzWHduUTBoWDZUQXNQK0haZ1BkQ2Y2Y1RVS2ZCeHZ1RjJlNzRRVDdW?=
 =?utf-8?B?SWhwRTlVQitxNmovcmg5dndLU090S1ZTUmZEQ1VVaTM0akFTWEkwMjBGaHBk?=
 =?utf-8?B?NjdEU3ZDSmdHS0dYK3hJbTlMb1JZZmcvYWd6dFh2UDFQT0k4Withb3Y3c1Ax?=
 =?utf-8?B?ZGNMdmNIYURyZjVBd0lyUnY3WTdiUnNXOGc3Q0huN3hldHFINFphZjBTRzBt?=
 =?utf-8?B?WkV3RSs1c3U3NnVESlk4MDgyVi83QW51RlBibEZJK0tiT0dyeXJUOHhiQ253?=
 =?utf-8?B?alpBQUZFbkdPVVZZZ3Z4bjlramw1UlpzWk9yNlo5SlltZmFCSDlmUXkyZWZU?=
 =?utf-8?B?ZHBibTVCK2VobHJnUnpEZWJDbjNPQ0xUclYrV1BUM1JXR2YzVVRDbm5yWWE0?=
 =?utf-8?Q?BXjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEloNElTVWNWZEV1QnBTUkkrQjdmU0FsQjNwK1RNUW1LVmszVUR3Q0dHdVV3?=
 =?utf-8?B?TEp1YmlqUTVzWFVCL3JHczVMc3Mvc0JoRVdXNkJnL0hNaFJWREwvVG9SSkNo?=
 =?utf-8?B?V0NRVmMxdU1TcjVsQUFPNS9VblRwQUQxbEYyTjR4NlB3bFB2MmQ4Z3ZWdVR1?=
 =?utf-8?B?MHkrUDRIOHgyM0hXN1BjTjBadXBOZlRsM213OU5JU2tHeExuQVhsWW55T1lH?=
 =?utf-8?B?S3hUUWhnMHFjMjVuNDY2djlrcjI1M0tGNWxHQWwyVUk1R2JESVRYZWZRN0Jw?=
 =?utf-8?B?TDVkUURZc2Q5RFBOcGZ6MGYrSGR6OXN0TTJRTnBRTXU0dmV1bzZMRzVrdG1q?=
 =?utf-8?B?K0IwUXFoTzFhWkw4L1JQcUdSTWhmQWVDSXczT1p0MWlTRkxTZUFsNGVqZ3Yr?=
 =?utf-8?B?dUZ6Y1VnV25sV2o1V3ZTQzdESWEvVER2RFJYemc4Q0QzaTVRTExzSFQ2cEJl?=
 =?utf-8?B?dkZsbVdrQVRvSlVMbUhod1pCSXdVbnZmMjlWYUs1eFFpM0hFeHVDNS9DdVdL?=
 =?utf-8?B?c3pCT09RWG9pOHBJZ1J1VlUvTXN1QnJLVEdEckhDRHl1Vm5zUVJLZUl1aCtJ?=
 =?utf-8?B?U21iRHpQNU1RM2FKazZPOS80eG9EVmQzdENUeDlOMkh5SUVqNytaVHg4ZUdv?=
 =?utf-8?B?a2dIZFlIVzE4em9JcmZNRW1vUEgxcVlGVmRmVVhYbkhrRktKQnpQKzJFWGxZ?=
 =?utf-8?B?NGMwVlRpYmc2aXVubVVQL3lDeFQyYXhIQ2hnZG0yeGsvRVZESVByNm1wVDR0?=
 =?utf-8?B?U29XTldhUm1pT1Vza3N0UldWVXM3dXh4SVRTMEdJL0lIcW1jT0RVUk8wNDRH?=
 =?utf-8?B?aHhaWnhVbnVSeFVncGdIVkt6cHFQNW9JT0lSTFd0MTh3aWpab2g4akJCVDA3?=
 =?utf-8?B?SXZqTnV0SDk0TG42OFdjWmJ5bU1WcmFsVTFxRFo4aVVKeXl6OHN1Zm95TXl2?=
 =?utf-8?B?aGxxS2hKRkNXOFFKaVJzMkU4MHBnWlVnLzVQOTM1WlA0TGdSZDJma0NldmRz?=
 =?utf-8?B?VVRGZXY3QVNnT0lpNzNaVVliY0VTQSs1K3Z5VXpPRHBsajkxb3cxY3FJQ2VC?=
 =?utf-8?B?dktYYUVhMjNmZkJJUUh5bkZmMTZSelJPUXZwbit0Z3RjczNZK2RNLzZoajNp?=
 =?utf-8?B?OGxHWitBVkhQcWlJLytaOHhIb2JPRDU5R2dTWjJyU3FOY0Fadm5USzVRbkxE?=
 =?utf-8?B?TWw2SGtzR256UEhFckhvVktQbjFHdDlVdUVsVXZVNVFyTnJnSTlOekxpMHdS?=
 =?utf-8?B?V0RtbkZhdHZmY0d2ek5hYzd6K3dqV21kTVR1d0lYRjRFOGp0U2VRbzFFck4v?=
 =?utf-8?B?SVZXK0NNZ1hKdURKUWhISkx0QzdoWTJEQkVPN0xhZXNhbGRzUnZGZU1HU29x?=
 =?utf-8?B?UVhYdGhITzdueXhveGtIYXRESGFWNUd1UkpqNTZqYTdQSGkyQkNIazhkcjlu?=
 =?utf-8?B?cThEbGJSTzlwekFPbHNHVHE1b1Rlb2pZc3BwNHdSKzlON1R2THZLTTZtYkpa?=
 =?utf-8?B?eEMxSzJOZ2htZUpNcDdITkxEYURudVVNNDVSUHo1OElzamQwa051YWlMNzRM?=
 =?utf-8?B?dytEUHY1Tjh0M2EwUm5ZQTc0aHVBTWw3V25YZ09WYVNsUTZJcUF5cGM4TGJx?=
 =?utf-8?B?QjFIb1ViRFY5aHVPSVZ2Q3hjUmdvYnNKd3FtSkNPeXRiRzVRTFBwU0VidUJh?=
 =?utf-8?B?OUdoNWNPTXc5NkNOWit2R3ByTHlycllXRHUzTjgxNW13MkM3S242UW4wdS9o?=
 =?utf-8?B?bXFvWDk2M0djUlNSYndRaHVaVngrRzhSc3MxaXJ2NUZNVStySDFoSHNIY29C?=
 =?utf-8?B?aGR4dlJ0MjlwUVJESk5sUEI3YjN1Z0VYZEVieVRaQmRTTHgxYkRjQkJkWDZ3?=
 =?utf-8?B?TGZPazJ3dWNLN1crTnh3dE40Wnk0SHFGczJYOUJUL2Z3RHJRWVBMQzR1YlVs?=
 =?utf-8?B?MVY5R1Y1UjViRithTXNKdjl3VVVBQzJmdzFyR2dyZkV4T1dIM0JpWTh1OCt6?=
 =?utf-8?B?YXRVcXNPdENSR1dJaTJ4TmFsSlo3OUkvcHppTzRXT29kbVdYNUZaUDg4eFpw?=
 =?utf-8?B?Y3BlTUNscDhUUVArZDZSbHBjMEtPOVFaQTRPMHprSnF2aEpsS3dITlBlMDFV?=
 =?utf-8?B?MWI3RnkxNDBsR0NkSHpUTVFablEvSi82NUFwNVdrNXo0ZGpyNndWV0pTL0ZP?=
 =?utf-8?B?WmRzeVMyeFRUakpJTnN1NXN5WUp5NFdpTnJmUGxuNS9BVmZWUzJCcldxQTZu?=
 =?utf-8?B?UUFoQWVZMXg3T1VlVFc0RHdnZFhUc0ZEYWFwRW01bWViT3ErNVY2YU96SDdo?=
 =?utf-8?B?MGJINHkyaVk3OGRXR2NYNnZ1dlVZditsbVV1YUVGK202Uk9BQ3BaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57de2195-32d0-407c-2469-08de5793b7dd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 19:48:29.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0gb0cb+P4ktAyvUn16tyt6uih/lio9w7tmnF5I3KcgwmKystzC2oEIU2j5F7i9H+4Dk2LQQPOriMOIr0Zusjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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



On 1/19/2026 1:23 PM, Harry Wentland wrote:
> 
> 
> On 2026-01-19 14:06, Timur Kristóf wrote:
>> On Monday, January 19, 2026 6:21:40 PM Central European Standard Time Harry
>> Wentland wrote:
>>> On 2026-01-18 08:03, Timur Kristóf wrote:
>>>> Analog connectors may be hot-plugged unlike other connector
>>>> types that don't support HPD.
>>>>
>>>> Stop DRM from polling other connector types that don't
>>>> support HPD, such as eDP, LVDS, etc. These were wrongly
>>>> polled when analog connector support was added,
>>>> causing issues with the seamless boot process.
>>>>
>>>> Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> ---
>>>>
>>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c index
>>>> 0a2a3f233a0e..e7b0928bd3db 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>>> @@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>>>>
>>>>   		struct amdgpu_dm_connector *amdgpu_dm_connector;
>>>>   		const struct dc_link *dc_link;
>>>>
>>>> -		use_polling |= connector->polled !=
>> DRM_CONNECTOR_POLL_HPD;
>>>> -
>>>>
>>>>   		if (connector->connector_type ==
>> DRM_MODE_CONNECTOR_WRITEBACK)
>>>>   		
>>>>   			continue;
>>>>   		
>>>>   		amdgpu_dm_connector =
>> to_amdgpu_dm_connector(connector);
>>>>
>>>> +		/*
>>>> +		 * Analog connectors may be hot-plugged unlike other
>> connector
>>>> +		 * types that don't support HPD. Only poll analog
>> connectors.
>>>> +		 */
>>>> +		use_polling |=
>>>> +			amdgpu_dm_connector->dc_link &&
>>>> +			
>> dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)
>>>> ;
>>>
>>> Why isn't the aconnector->base.polled assignment in
>>> amdgpu_dm_connector_init_helper doing the trick?
>>>
>>> Harry
>>
>> Hi Harry,
>>
>> The issue is that checking "connector->polled != DRM_CONNECTOR_POLL_HPD" will
>> also match connectors that don't support hotplugging, such as eDP, LVDS etc.
>>
>> amdgpu_dm_connector_init_helper is working correctly, it doesn't set the
>> DRM_CONNECTOR_POLL_HPD flag for neither analog connectors, nor eDP, LVDS, etc.
>> which is correct. The problem is with this check in amdgpu_dm_hpd_init.
>>
> 
> Ah, you're right.
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 

applied to amd-staging-drm-next.

>> Best regards,
>> Timur
>>
>>>
>>>> +
>>>>
>>>>   		dc_link = amdgpu_dm_connector->dc_link;
>>>>   		
>>>>   		/*
>>
>>
>>
>>
> 

