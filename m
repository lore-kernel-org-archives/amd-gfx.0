Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1287C54FD2
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A17010E75F;
	Fri, 20 Feb 2026 13:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBOWF5N+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D8010E75F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDmE7Mwg9eQKITQ+2GsjDKSChzWqmLwhx/aLSyioFLs/14hUYLJSOu0m+rFZIBW22Hc3Gc3UhNJsFnWGlm4y3bHFnGzmLsVRezU9E4reEU9+kCa6AZpyvLz/q8oQhdCESVfZ/+AGx5qpl2vGvVLpxRYA33CWKfw0jWKnV10yGLsyW6zELGlfJP3RAa7Lqf8b3WEXQQTElQ4xFhmlf1fFYJmYsVW0vYhQmKsSTfp43XOBMPZpGy1CssecjmgThA7J74DnT6DeTZ89UrmEHDCMkVAWzyYDBDke0haW+SjV9imgh8CysRV5M+0n3pdekx1KCd3kHvPv04YLyIEE0tHiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBI2r4PTGtQw7rFx/OaDS8z6VhiLq8iAenc+ke3KXE8=;
 b=N8buha4wsLfrJmnArkSJ7FgKZthnSN+qVVTfK0qSLZqhAWsQ2ZFOeV8gtjBbXMbDa0E+pirQt4UcMcSz5lHrZn5Y2pkuVkjGfFQOnCnLPEK02e7OaWCjs+O5Z/TB7GMuQQSqjSZLUh37ZFGfpjKn2T3Wy0NmWwPczLBH/b40sk6crcXurtiFIeqGXgOeDRFVpNB4ugVFYEfs6oeSQpyuvM/i/ClXwk3zEdN5pS91abTq+BICdFs+V4PIiasCi67dUngTInSGyMKs+W/JKM9yRZHSPD9ECxlAykEB0/elKpMbwWhAh1Fe5rjBrj4OjCX5+Apm5Gjv5/Gvj4hAgnOU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBI2r4PTGtQw7rFx/OaDS8z6VhiLq8iAenc+ke3KXE8=;
 b=kBOWF5N+Tb+YVTeTwHwyV8q5TQuQTNLx9KE0ZFnwyFq4K8vCT2VheVPO93JTYAiDpbEbhH1CN8ZcMX0H9dMs4ctvT6up9OtaPImMtS/12PSBpixH0sIy6nXMOuVJVtSX2/G7XYXoekbwo4An6TY7SRvxNapkbFonYAKFTsBk2dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Fri, 20 Feb 2026 13:32:05 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:32:04 +0000
Message-ID: <9775c6b3-2841-41d6-8ed6-f933f6759806@amd.com>
Date: Fri, 20 Feb 2026 19:01:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_signal_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-8-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251205134035.91551-8-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 074d7bcb-be4e-4bfd-03b4-08de70846fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?empxYUFzd1Q2UE9ib1FFME8rNlIzSG15R2I4ZDJIZjluMjF6ek9kbDBSaWRT?=
 =?utf-8?B?YjNYcUh3S1QraVgrU0JjVVU0cjlDcFBGZmtXZXY2N2VzVFhmVngrTkhjOFpy?=
 =?utf-8?B?SjdEcnowcHBTWEQ1MkNzbGJwRHVCWlQ3ZXMxVC82Y0ZEY0xrcXZseXlCRFRa?=
 =?utf-8?B?RDJ3aG5xSzB4blBpd0NVU2ZEL1diOU9SME4vMyt0NDMzZ0FYby90bTJUTGtn?=
 =?utf-8?B?aDl0SEtWWktGTzZRanZJdTNndTY0UEdMR2FUK3U0d2wrNHBOaStHNWUya2R0?=
 =?utf-8?B?R0ZqUXUvOEk5bzQzN3ZZMHZoWWNpaUpNWFRhcTFyMk1YbU5uaHZZWWpGQnhl?=
 =?utf-8?B?L1owWUFwSW5UVGsxaHp6Y1BMNzRMZmxkb0V5RG5wcml5OTlEV3ZrVGxSaFpz?=
 =?utf-8?B?WWU2SS9qcnlOMy8ybHU0YVFLcHJUZ3JqckVjbFVvUFYzdy9YWUJVVWYxcmdj?=
 =?utf-8?B?OE9UWVdHOTMwbm5LTDQ5Vy91ZGkzR012aytjVEExTDRlTk0zM1dFMGRxRmQz?=
 =?utf-8?B?NGxUVmNyZSsxZThMai9FeGQyREpaT2IyMklwWmVPSVBONzVFSDcvcDBrTWkv?=
 =?utf-8?B?WHBHajNNQXkzamUwT3k1ZGh3d0RmekpKcVNKTDdlMEJQUTRNUmVVTU9jelk0?=
 =?utf-8?B?S0dkU1h1SGFJS2NvV2JPVy9UZkNSTzBveDg2bmdmU20rOFMwNXFvbkJQRmZr?=
 =?utf-8?B?WXNGN1U5RGhrWWFzMFUyUHkwMUlsbEZHd3VMV3dYWms3c2VGYjZCVitMM2E4?=
 =?utf-8?B?ZkkwNnVqVlFzSTJBeW5xa1ZCdjBMVEJEM3pzMnFZUUJvWFFzdjhsV1Z6dERL?=
 =?utf-8?B?NlpFaCs4YWVuTWlyVWhrVlN1TXhQaUw2a1NwK3BKUEFzTUpvWXd1UzRIYUlH?=
 =?utf-8?B?N0NGb0JJM2xYMVQ4cTFkK2lKbFF5ZTVPTFc1WGRpUU9iMjYwK3VMSmw1bXdR?=
 =?utf-8?B?NHI4b09QMHpqMnlhWTk1WmxYaXJSdlBBazNkcTJ4cHEweC9vYnY5RnI1MUVF?=
 =?utf-8?B?ei9wZVhwenNuQjYwTG04Qzk0TUM0dWp5RENwTzh3RlNPR3ZEVmM0Mzk5a1pG?=
 =?utf-8?B?WFRHOW9EQTdOZ3MyQjBHZ2xGOEtlSGtENG5IVWcwamVqTW1vOFZFTXBhN2Rl?=
 =?utf-8?B?dWFIeGZtWXBMY1NEMWpWbU9waUdZb0ZudWpDQm01NFhnTmFKUUFDSHNRQjlz?=
 =?utf-8?B?S0taVnFmL3pmbWJDZHBnS0k3Qk03K3llMmdHSWZ1dmphOCt3Ym9ERlpJMTRW?=
 =?utf-8?B?WTZqWjBoK255R1YvMGh4dElSc1cxdDU0bFAvemNLZW5jWVlGMUk1VGd4NTR5?=
 =?utf-8?B?TzIvS1lJTm9PTDFXelVzd0lrNDhaTHdmK2FId3Y4dFptd2RtN0p0YmhSSWZK?=
 =?utf-8?B?K3pIcDNmQnNRUVZ1bTZWU3lma3hoL3RMU1lZaXR5YnNOQ0JZSjBJVlNXZnNk?=
 =?utf-8?B?TmVkVldoRDdpZkdwK3dtUTJ5UWY5SUZyZmF5MWIvT0dpTFVURnY1VThYR2Ro?=
 =?utf-8?B?UWkxK0lhYS9rUW1mNTdCMlhOMktEVFJtMW9IVHJ2aTNxVCtWOFlHMDdHdVFw?=
 =?utf-8?B?eFpBZjZXc3o2cDZzVmdmK2l2b2l4OG41dHpLUkpiUll3dmZ0OEtzTEhVSjZh?=
 =?utf-8?B?VGF0NldCa3NXUm5EeGxkRk1pSjZYMFlCUTVzNm4vV1E0TjNrdlUybnBHRjFt?=
 =?utf-8?B?RzdUcVUzQ0FKbWxMZmEyVms1dlVPYXpxcWdQdjkvSmtjWFdKRXVOTWpMQnVa?=
 =?utf-8?B?S3Yvem9MLzRSSmZWYjQxUmNlcHZ4TlJCY0lXNWs5aVhxQ1dQR0NRQitYWUIv?=
 =?utf-8?B?RFRiREEyZXRHdEp3RVhZMHVmeFIzajlXQStETGNORWx0bi9BVzJHR01qbkVY?=
 =?utf-8?B?eGpaT0VUWllRWW8wTmVEeU9tY3htNzA3WkZHVEhVN2x1d1lrb29sZzVvVllo?=
 =?utf-8?B?Q3VMbmsxYlVuQ1RlL056ZTh0YnN4VVladGhsWFpxNVdnY2t2Y1FNYXEwcTBp?=
 =?utf-8?B?QTlrUlFuaDU3ZDZ0eDkzVG5laUVGS3NZMjBoQ0NXM2lDME5nM29PUkM0a3pC?=
 =?utf-8?B?YzEwTGQzdm1iQ3p0MVlQYjFYYzFraTF5VUZTeVJkaXVFQU5WbXhTcTIvTXFH?=
 =?utf-8?Q?4C3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdwQXB6UkZSVGU1eUM3TTJFQjJabG9lYXRmNEZISm1hZ3pDVG9aY3hzaXA3?=
 =?utf-8?B?SFdOOVl2NC93STlNb1l2RTVMa2plZEVINnNmQ1pTTUtUd2p0RDRqY21DN0xJ?=
 =?utf-8?B?TzdjeVFJYS9aRlp6T080RHBzYzBmNVV3QW96VGZYK2FMUnNGTFdDeS9MV3g1?=
 =?utf-8?B?bzhmaklHZEVQaVVhd3hRVEN6dTZzUmlFcEV4K1AzeS9jRWhyZ2N1enkrWjJB?=
 =?utf-8?B?YWVoZUJkbDAwYkxrd0VJcHhtb3JaQVV0eGE2dm1ZenJleitadmFYbnkzSC9U?=
 =?utf-8?B?WkFtc0taa3lqZlpEVkVpQUhHOG1DbEEzNzl3NHRaM2lqTnBLWVRXRml6MjRT?=
 =?utf-8?B?WTB3a3VtNHhZN3dRSmppWFdpTWN3UHVqclRrem1tN3RYTkRyc3J0VkdSUm9y?=
 =?utf-8?B?UU5kendqTGxqajVJS3EwSEQyVmhYVEpnaCsvQ2tsOUpyYlJkb1hQYzFyUzh5?=
 =?utf-8?B?TWRjMThkQytRWitnN29hMVBGZmYxOWFGaXFQNUxCeVdnbngrL1FUeTdNaElQ?=
 =?utf-8?B?aXRFSmY4RWpOTEthdmE0aW8wN1VuMlNEQW9rdlY2K3pKZnhiZWFIVnV6TDlO?=
 =?utf-8?B?U3gwY0hKNmZvQmdqNXdqNFJWSVZLRVRDWlVZZkRhcjdpTUUyWk1vVmkrb1dC?=
 =?utf-8?B?cEJJdXMrMVBmemFTL2NVTXJtVG4rWnRCVGZMeWdyQVN1aXJIaTdsQjNCQWlq?=
 =?utf-8?B?UDV5RnJkQUFKQ2Q5eUh0RlIrb0krdjQrdXZ3OHd2bFBRRWV3TGRvZkJwN3N0?=
 =?utf-8?B?eFFSRyt5cklMNENyM1VqY21mbUMwRGtQU3JoUllMTDNqdWdvSjREL01jakNi?=
 =?utf-8?B?a0xSbzFvdnE5L3dlZmJYdVRoSGtXMVlDeGE5dzBXTXFDVGhzaExYeTNzUk5K?=
 =?utf-8?B?YVg4YUVFeTlUREh1L0Z5TG52bGw2eW8vdTBodTgzRFBJbVErUmJjN2RkZUN4?=
 =?utf-8?B?bnZQTGlJRGlybDZGK2xxVmxaZVVpczJsM2EyVi9lWjREWllubFpRaE1aRk9K?=
 =?utf-8?B?bXRPd09JLzZ0cGdPRTRCWm5ic1E5dDJxWUY2dzNvcndKVjBWRzhWWitGWHUr?=
 =?utf-8?B?d05sbUtnSVNNNlpvcUdhQ1dON0NVV3Z3eVdRWUllWVVFN2tjbUdjNHFmdkZp?=
 =?utf-8?B?M0orejE3M09rQURrK1pjVnNCaVBrRzhESmw5U2RJbVIzYi9Kb2t6WkgvQytp?=
 =?utf-8?B?bTZtOVMxS3RYbkhZdloyMVdSbDlBLzdWWHBTMC80VHVWQi96bG5GZTlCeFJt?=
 =?utf-8?B?RlVUQURUNlNWTVNzaElzS0gzZVZGRnBzMnQ1TE5qR0F2ZVY3NnBEdHBlbml5?=
 =?utf-8?B?d0RXZy80UUhUdTJoUmRRcThPcEVZRTdXd0lGQmhDM1dKa1NJMXd0dXBSL0pK?=
 =?utf-8?B?ZDFEUTRwd0p4MFNMRjlqQjR6cWR1dHFUczlzWTR0LzFTL3VOR2IwMklPS01N?=
 =?utf-8?B?VkF5dFp3K0JUN3M1b2c5TjR0N1FqRGIyNS9mYXoveXFiMFJBN1RXWkMyRUZQ?=
 =?utf-8?B?bXJKSTBBRmFhT3piRnFXNk9OWEdOM3FjNlN4RVhJMWtWcGNJRkFaa0hPdFVt?=
 =?utf-8?B?UGVTb0cxaWp5aWp5VG12TXgvbmFJUXVFYjhUTDRjb1BVWU5NOGtISEQrVEZ4?=
 =?utf-8?B?T2JadE56SkVuakpSN3JOVno0WjBjUmtnSWc0MVl3eDVpbzd1N2FrajBwRjNN?=
 =?utf-8?B?b3I1NER5V0F4S0lnbjhPUmh4a3pTSjZkczhnTkdic0djOHpaZU01aGZCNHNt?=
 =?utf-8?B?U20wZ1ZKeGNRc2gzZ0d5V3BKVTJEYzRmNTcyVVhnWWdqblh3d1FlNUIxTWVB?=
 =?utf-8?B?QjhsZlNIOEExdVR1ajNjVVpkNHQyM0JuMmcwbGdLUURZc0R6ay9uM0NYeTlS?=
 =?utf-8?B?TzBpcWQ3dnh3K0kya2NHdnozNjFEN21yeWNPUFlQRnZtaTRSN2FPelE0dXAy?=
 =?utf-8?B?dGRDNFlZR0orVFpsbEpvUjlEMG4zWUxwKzlaemY1OWZSK1lVN1FENGExRjRp?=
 =?utf-8?B?SzhiRnJMeHJ5VEozM1AzbXB2SFdLeFVJOEpIbVk3VkJ4dnlmOVZ3VEQyTGR4?=
 =?utf-8?B?Tk5HQkQrL1VPQ0M3a2pEcDFwckgra254Y0dLMXlUaFRrQ0t0ek9aTXM4VWd3?=
 =?utf-8?B?d21JMHR6bi9xWVpVRFRLSlAvOUFwTmJibERWMmR4bFM5Vmp2RnBQbmo1OWlp?=
 =?utf-8?B?RC9pYXVSUGRTekNaTFhXVHovWmw5WWprRlY0a25PK0lGZDNqd24yUHJDcyt1?=
 =?utf-8?B?d3BWbWFUbDFkSFd3Ky9pVXAvWEpYK3d3S2YyNFRmU2p0RDJpVmJxNTRHWDdm?=
 =?utf-8?B?dW1obnpYN0J5c3ZwSkVyNU9hZWxmcE1JL0w5dHlXRTg1OVRYRTl0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074d7bcb-be4e-4bfd-03b4-08de70846fc5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:32:04.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pow91r10zdQ0miXzvjurnmEhZaCZbtU47ZAY/pv3iZKANfa2lal6CTftQnBSIwgUKq5oDpUTZHg7wqRMpu9uRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

Please make sure the changes are made for all memdup_user
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 05-12-2025 07:10 pm, Tvrtko Ursulin wrote:
> Use the existing helper instead of multiplying the size.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f979e896c714..6bddba2d8ba1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -471,8 +471,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	u64 wptr;
>   
>   	num_syncobj_handles = args->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj_handles));
> +	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
> +					    num_syncobj_handles, sizeof(u32));
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
