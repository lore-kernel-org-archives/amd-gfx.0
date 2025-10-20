Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02716CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7412F10E4A5;
	Mon, 20 Oct 2025 17:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q0Ys2qTZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC4910E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB9iRA4L3behVLpdDW1U2mJonfh5LIgVm6wL+HyGhZ1yYg8l9gTE7oTckzTZLwLgfkE7KLVK1+j/pca7juopSWvKx2n/IGM8SG+ijJd2V6zqSoL7hlnfaYZzuNom4IPTSnWXm51snw2yokGpIGOERgHVNVnED7uM3JQtTPsJGh9Zc5JK4rBGeR2YEoe6Ai9YLe6ajg8PHlSxp6OqJXXdTNu0FgjCJ4AtSdwBFxZHTHGX6aaqjws7Ba/QmuluWsJEMhVsHR3YQcIQ+uzzW/BQBWGwV0Y2pj+W/nusbTboE5IDavnFpgsgpkrUOeyqClT31C+H70Snu7fU5TdqdPNDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9Amw8wi6oDAuy/4izfyF4nGJSkOw84vub8JKVbL8lE=;
 b=NRkUKNPWGoKdsrO1Kcdo1QBb/r8LneT8U6M5m2Rr56KU+BVPIQJg4r2lSTq19oGMV1zPjfHjefXjFZAdWH2fMP0dD330PTA7c0hD6rVNAEO/YOMg8J5X6rzF78qVR/y573A0FwtfP3w8zx7gil5M14pbGa+kP+G6VTWEkT7L/hWw+m60rneo+22b9xXWHdmMItTGcPTdpP/A3JcRIBpjizv06G3zfPzxssEaHXp+pbo9DAeugYe+s3yEoFZH3hbC8A9mtgS2iO0AbB/jBk4bnRt9Yuq/Jcr7U5Odd0OOwxRV2hK4m9p4wATRrZAQ8MUmmYvjU53nk2J94kE+sGW2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9Amw8wi6oDAuy/4izfyF4nGJSkOw84vub8JKVbL8lE=;
 b=q0Ys2qTZR2ApGZ7OKtBuYmoc5wyAXtRZII69K3MIWlo5s9rk6X68BnRHTgXF1GMrTGVcVGauAk2UntoWQxVBeDfY62FbloLqhAYHf28D4Ngu3/Hcgi2MyDYf/A59CLQ8xikzD9laqr0/U3gaPR2uC6SygxPUR7YtxrZb0bJidKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Mon, 20 Oct
 2025 17:51:29 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 17:51:28 +0000
Content-Type: multipart/alternative;
 boundary="------------AAYhv5QIXk3ZnC1Mwgp72Wp8"
Message-ID: <7e16094e-1e04-4024-8752-5c6a08368b7c@amd.com>
Date: Mon, 20 Oct 2025 12:51:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20251020143016.23409-1-Philip.Yang@amd.com>
 <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
 <CY8PR12MB7435E4CFE100C6B9354F846285F5A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <c5d8fca3-5d49-4e31-b864-e4deb70e1df0@amd.com>
 <CY8PR12MB743528C3D13C1B43C85F019785F5A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CY8PR12MB743528C3D13C1B43C85F019785F5A@CY8PR12MB7435.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8347634e-ef7b-4b3e-330b-08de10014bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkV4dkhaOEx1UWVabmlnS3lUU2VyazNRcTRvMHRxbW50Q0VWMXJ6TitWL3M4?=
 =?utf-8?B?VmJlNVUwZVFVbGhWcmNHc1pNOVA2d3hYaG5yc2xVYi9mVFZLdm9FMGQwRjkx?=
 =?utf-8?B?V3c2TFh1cWZ4ZTBDeDViamV5aHRBdkpSUDd4RDBHeHlDaTNGS0E5akRiRTd1?=
 =?utf-8?B?UkdNOXVOL1NYK1FsSndFcGR1SVFYdjJUSDcvMkZrcm1uUmFHbUwyRWlveUFD?=
 =?utf-8?B?VG05bjEwM0orSFZBbjBhd25wNU9pZTQyOWwzaEtRTUJ1M2k4MytnL3c1WEdP?=
 =?utf-8?B?UlVVSzc2S0RCcUQ1TEcwY3dvOWJsamYyS2loUGFwZHhJNVh0VFVoMWNMcWcy?=
 =?utf-8?B?bG1qVE14OXZSREtUdEdiNFAwOW9FQzVoeE55T1FMZDJGMzFYN0JScU91RFB0?=
 =?utf-8?B?b3IrVkVmMlZ5S3lYd2Jyd2ZoRm1GaC93TWhDNjNiUk9MUVhVWjcvMkxJZDRJ?=
 =?utf-8?B?RjlPSHJ4Um9CK1NtZmgxZHBYc0lIUHdiS0xmOTE2UUxGZ09sTXlXOCtGaEVY?=
 =?utf-8?B?ZUQ4Q081bk9GWC91NFZzTHlJQ2JNWTJTTWtlTjZBTmhHd1NadndjRkY5ckk3?=
 =?utf-8?B?ZVFPeHFpR2VxSGFTVUJsczRNVGhGSTF2MXYzd1FCWXdtRFp4bm9aTVpxcWR5?=
 =?utf-8?B?eVIzWGdEMldtUnl3ckorN2hjVFRSckdxRUtYUjh0ZGJITEpHNWI3VjNQL0I2?=
 =?utf-8?B?K3o1b2F3TzBRUDRKVDMwZUJmeVo5Sm9VVFN3YzFVQUdkMWcydmJVa1hKaWx1?=
 =?utf-8?B?aFZKdkkvL3RHdG1pRUcrVWJBQncyTEZKQ1NWRFd1VWlYeHppSUY3MXlBTml5?=
 =?utf-8?B?M280TE54RHhCcUdDNnAzNHROdTFjTnFNdXF2ZkJrdCtYb29tRzVwYTV3bSt3?=
 =?utf-8?B?VVh4Nzcxak1NU3dLVGdlMWJLcXFFQldmaEdaY0hjR1FFaDhmQlBlNmJQdDVo?=
 =?utf-8?B?TTh6bkxwcVJPWExtTGN5OXVSdS9wNC9Td1dhSFMrWkovM2FjMGxBZlNUc3N5?=
 =?utf-8?B?SkRnSkw2a24wYjBhbHAzdEpHeXVjTWlqNmNEVENTZW9TWGNwYUFHQmtFOU9B?=
 =?utf-8?B?R1J5MnJ5NlNCUnR3Q2lxQmx6eWhmT1V3U3QyeEw1eUpDWTE1RTBjbEUvU2pq?=
 =?utf-8?B?SW9LYlA4d1NsSTBpb2Mwa1NQK0xNZTlmQVhGMDl5bmk2QXdwV1l1dG5hSW9C?=
 =?utf-8?B?VTBPam9LNkUrZW5VQmRubHJxcGlYcEVGdHducWJZelRVZ1BwMXBiMFkrcWZG?=
 =?utf-8?B?N3F6Kzdjc3N5a2NxamxzTmxqTnc5MkNxMUpDYmZ0cVhXYXl0SmV1d1ZGaGhR?=
 =?utf-8?B?YjBSNHpMSDd1RlZuL243WkdRZjc0S3RSNmtMODJCMzVsWXFpWDhCK3ptQit5?=
 =?utf-8?B?dlJmZ0NjdU5ydFNwdGFvejN1bjBRbGs3S2NTTGV6d2J5M2srOUVNeXdkMGxy?=
 =?utf-8?B?RnpyRjJScUNqbi81QWJaWEtheWlOcVNUMUo2YkxRdGNGWHBDMnJ4dk0vUjVJ?=
 =?utf-8?B?UkJUMXE1WXZVVnU5Rmw4eVdMOE54OTRkWWp6R0ZlWU0zcGtPT3ZSRHVvM09K?=
 =?utf-8?B?SXdGUHBZVlhwOGtCNHIrNG81SHZ6TE9IVE9kRFB3aDB2T2NjN3ozM1d6ZE1p?=
 =?utf-8?B?Mjk0eTVEWFpDZytISDBhZThOeUpoNWY2S2tibmd5dHd2L0VpOVk2V3JQL1dH?=
 =?utf-8?B?WGtLbVhGalRtRWZtMHVwK296S3BWeDNIaDhjbjlNSm5LdlJkb2k4bllJVXVQ?=
 =?utf-8?B?d0p3ai9LT05BUDl1Y2dvOWEzUE9ua1dRSlcxdXdWOUZoaHN5emRST3NJVktu?=
 =?utf-8?B?T0FDMWhyb3pLVXNDVE1vM0RsUmJyelk4RWtZR0pyQzlrUENYVXp0c0NtQVcv?=
 =?utf-8?B?eWNKSzRZYTB6dWY3SlpiRGFvY3RSYmRxOVBMeDJlOWZMSFdCVXpGTXdEK2F0?=
 =?utf-8?Q?qIeXAGt02G+lc4RN55nZmvj5rx9viUr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FvT21XREtYSEpsTDhRMUlBVkVTbWtjMEVycEhsUE9NbnZBenV1a3lEcmJh?=
 =?utf-8?B?R21rOUEvaGxFTTZ0VzhkV3QrZ0FjRzZUYVlZK0ZZd0svS3VEZ1dRWUVHd2Ix?=
 =?utf-8?B?bGlCRjU0QzFQRW9zODdrT2RiMWErYXVMZTUwaEZIbFNPTGpGVnArbEpLMzIr?=
 =?utf-8?B?OXRkUDBNN2xWQWVSMW5Hd1RqcHJibGsxSFpDelV6TjR6dXVvaG13Yjl6NjFR?=
 =?utf-8?B?dFB4NVd3M3J2M1BqNGNQODV6M2labHhWUUdXN2NZQVRQYWZISTNXcGhUTHVY?=
 =?utf-8?B?VkR4MVY4Z0NVWjBGSW5HbEJ6dXBTcGVPeHZWSzdMdFpaMG1xd3B6SXdVeUJz?=
 =?utf-8?B?ek0zcDhpR0dnMDl3ZW5TbWRmUVJlS2FERTgwMG93cjBydGxTSmI4Q0swbWtI?=
 =?utf-8?B?bXdZUGI5aFhwS2h4S1pldnV1RmpSUWEyL3UwQXhyd2h4SCtJdUVzTlB0N2E0?=
 =?utf-8?B?eGdCS1RzZXZtNldMWllWa3BGZWhiUXdjRjBaRGE1OG12WGtGOXNBd1l0K3NR?=
 =?utf-8?B?RGlYQ1Jac0YzeHFEMWJ4SFpWQ21zNG1zSWx3ZlNVS0FzbUtsY3VLSVlFSU9a?=
 =?utf-8?B?RURkcFdoV0JyODMzdDFKdDNIMmtESjdwcGltVWtKVGNEVllBY0VNTmZyZUs3?=
 =?utf-8?B?TzErT1ZVeUVoUW5ZWVZsTzFlL1lFWlp1YWRHN2ZmazNCSm5lVjZJdFNlZFZL?=
 =?utf-8?B?TnNDeGUrZTZjdFJ5emhBZVZCc1hkdHBCZzRUQnRNRmZGM3VVVzMvYUhLTm02?=
 =?utf-8?B?WnMwcnpqZUw0eUo2K3dlR0wvdHYxWEJjeHM2SnVtRXkxdVcvUS9qdUhiSkpD?=
 =?utf-8?B?UVRrZGJwZHYyd2JaOU54K0w4UFNvUnUxRXF1ZXBJSmE0RmVvZlNLd3ZJZkU5?=
 =?utf-8?B?aDQzdzR0QmRoc2phVTRRcVM2UVhBZ210b3hDcWFYRG5oUnowUHllbUZRaVpP?=
 =?utf-8?B?NTBURkc5VktWSUV5b3krek1rTG1uTi9ZRXRQMTZyd3JudE10RDN2c01Rdkxx?=
 =?utf-8?B?MFBXOWVBcHc1SHpGV2dvZURCL283MStWbmpSMS8zOHpPODNyenl2d2NpMWx3?=
 =?utf-8?B?Z2RCNUJQRmMwREk2UWRWZmRXR2ozRjZNNStjNkRyTWZqNldFWWZLbTM3K1dO?=
 =?utf-8?B?T04wekd0UXMxV2dnYlc1Nnh6TGcya2U1NCttWmprTWFwUHVaLzg1N1pPOHJW?=
 =?utf-8?B?NXZtYWdEVlBhTW4wOHV4WlZHbnErdzEyWmJUdGlsM21iZU5KclUxcG1kbWVz?=
 =?utf-8?B?MmNvcFJLdmY3QWhRNW1qcGVzUk9la2FKNDJTc29OS2ZhTkxGL3hnLzJkR3Bj?=
 =?utf-8?B?bzZ2UlBxbXEyby96VlBEOU13S1VJRzEwNkY0RzljZ2MycWhIQ3RSaXhEM2lB?=
 =?utf-8?B?R2VIUGluMGVldlZKSDJlaE5vNWF5cHpBSmVtYjNaeTVMVytUUmg2RCtCYzVR?=
 =?utf-8?B?a1NadWdmWFBDMmFRaW0vc3lUczFWeU4zZWxXdEpxYXZaQnpHTjY1c1lhcFFi?=
 =?utf-8?B?UDhpUmhhTkJHSWtENUxreHN6YndTM1N0bjBpY1MzaWFMeTd6bXNZSGY5Ymtr?=
 =?utf-8?B?YjdxbzRDa2pkMC9JTHVKa0pYZmI3LzRUNHF3aGhjeE1ZK0Z2d0FjUDlhNnd3?=
 =?utf-8?B?SHV5dThPNkt0OXhmc252SHF5c3hsaDg1ZTd6UzkvdkhzMDc2TkQvTTljVVpT?=
 =?utf-8?B?eU5BbENYaVNIb0tCeTZobHY1cUtObVVQNjNYcW9GYXRJWW5GOW9VdjJ4NTJC?=
 =?utf-8?B?ZGZ5bk9PbDVRbFp0MnlBaXFWd1JVNmZ4NGR0NCtaWld1djV5T0F1dDhrMENx?=
 =?utf-8?B?SGhwdnd0UmxCQk9BeEFvME5jM2ZGV1Bwd0tkcEhFSEdGbWF4aXVya2hhMDJ5?=
 =?utf-8?B?YkxIU1NjSXZja0hWblNOODNiZzFJS3hOMklMY2hibG9WYUpXOG1TbHZKc2lw?=
 =?utf-8?B?QmozNWprdHBPVVNIWTEvZ1VRTUc0YzlwMGN0a0xnWjJJWFVRQWhlelMvYVBy?=
 =?utf-8?B?anVLTUdOM2FhWjZEd3V3WXh5WVRlcHdxejlsbHFUU0NXUVN3WjBOa3hZelpr?=
 =?utf-8?B?YWlvZ29PMGpKRTNrRmZJcXhSTGo4VFNrTUdkckdDVUlwb0NMNWhzT1BNNy9O?=
 =?utf-8?Q?IcfU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8347634e-ef7b-4b3e-330b-08de10014bdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 17:51:28.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X23gCYf0M4bAI4KFEGSpELUNWQYIPK9ngvx00yjpuxpx1G5ZswlS7jMfarNgdtLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
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

--------------AAYhv5QIXk3ZnC1Mwgp72Wp8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/20/2025 12:45 PM, Kim, Jonathan wrote:
>
> [Public]
>
>
> Why print something under conditions where it’s not needed then?
>
> Could this not be a pr_debug instead?
>
> The number of queues could be quite large.
>
> I don’t see the merit in potentially spamming dmesgs if driver is 
> going to clean up anyways.
>
I think the issue here is not about print this warning or not. The issue 
is queues associate with prange should have been destroyed before prange 
got unmapped.

Regards

Xiaogang

> Jon
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Monday, October 20, 2025 1:34 PM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com>; Yang, Philip 
> <Philip.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue 
> buffer free warning
>
> On 10/20/2025 11:24 AM, Kim, Jonathan wrote:
>
>     [Public]
>
>     You can see this error message on CTRL-C or gpu reset conditions.
>
>     Those don’t seem like application race conditions to me i.e. the
>     app can’t do anything about terminations it can’t see coming.
>
>     It appears any bad actor could spam dmesgs with these error
>     messages if they wanted to with the way the driver currently is.
>
> If this warning message comes out due to some unexpected things 
> happened(like ctrl-c) I think user would not be surprised to see some 
> warnings.
>
> Regards
>
> Xiaogang
>
>     Jon
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>     *Chen, Xiaogang
>     *Sent:* Monday, October 20, 2025 12:00 PM
>     *To:* Yang, Philip <Philip.Yang@amd.com>
>     <mailto:Philip.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>     *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>
>     <mailto:Felix.Kuehling@amd.com>
>     *Subject:* Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue
>     buffer free warning
>
>
>     	
>
>     *Caution:*This message originated from an External Source. Use
>     proper caution when opening attachments, clicking links, or
>     responding.
>
>     On 10/20/2025 9:30 AM, Philip Yang wrote:
>
>         Only show warning message if process mm is still alive when queue
>
>         buffer is freed.
>
>           
>
>         If kfd_lookup_process_by_mm return NULL, means the process is already
>
>         exited and mm is gone, it is fine to free queue buffer.
>
>           
>
>         Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
>
>         Signed-off-by: Philip Yang<Philip.Yang@amd.com> <mailto:Philip.Yang@amd.com>
>
>         ---
>
>           drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>
>           1 file changed, 3 insertions(+), 2 deletions(-)
>
>           
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         index 4d4a47313f5b..d1b2f8525f80 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>         @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>
>                   bool unmap_parent;
>
>                   uint32_t i;
>
>           
>
>         -        if (atomic_read(&prange->queue_refcount)) {
>
>         +        p = kfd_lookup_process_by_mm(mm);
>
>     p->mm is null, not p  because driver set p->mm to null. But
>     still prange->queue_refcount is ref of queues from this prange. If
>     app unmap this prange app should have destroyed the queues
>     associated with this prange already. If not, it is not driver
>     issue. I think driver should send this warning anyway to indicate
>     there are queues not destroyed by app before app unmap the prange.
>     It is an app race condition, not driver.
>
>     Regards
>
>     Xiaogang
>
>           
>
>         +
>
>         +        if (p && atomic_read(&prange->queue_refcount)) {
>
>                          int r;
>
>           
>
>                          pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
>
>         @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>
>                                  pr_debug("failed %d to quiesce KFD queues\n", r);
>
>                   }
>
>           
>
>         -        p = kfd_lookup_process_by_mm(mm);
>
>                   if (!p)
>
>                          return;
>
>                   svms = &p->svms;
>
--------------AAYhv5QIXk3ZnC1Mwgp72Wp8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/20/2025 12:45 PM, Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB743528C3D13C1B43C85F019785F5A@CY8PR12MB7435.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">Why print something under conditions
            where it’s not needed then?<o:p></o:p></p>
          <p class="MsoNormal">Could this not be a pr_debug instead?<o:p></o:p></p>
          <p class="MsoNormal">The number of queues could be quite
            large.<o:p></o:p></p>
          <p class="MsoNormal">I don’t see the merit in potentially
            spamming dmesgs if driver is going to clean up anyways.</p>
        </div>
      </div>
    </blockquote>
    <p>I think the issue here is not about print this warning or not.
      The issue is queues associate with prange should have been
      destroyed before prange got unmapped.</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:CY8PR12MB743528C3D13C1B43C85F019785F5A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">Jon<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Monday, October 20, 2025 1:34 PM<br>
                    <b>To:</b> Kim, Jonathan
                    <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Yang, Philip
                    <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Kuehling, Felix
                    <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH v3 1/2] drm/amdkfd: Fix
                    false positive queue buffer free warning<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 10/20/2025 11:24 AM, Kim, Jonathan
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">You can see this error message on
                  CTRL-C or gpu reset conditions.<o:p></o:p></p>
              </div>
            </blockquote>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <p class="MsoNormal">Those don’t seem like application
                  race conditions to me i.e. the app can’t do anything
                  about terminations it can’t see coming.<o:p></o:p></p>
                <p class="MsoNormal">It appears any bad actor could spam
                  dmesgs with these error messages if they wanted to
                  with the way the driver currently is.<o:p></o:p></p>
              </div>
            </blockquote>
            <p>If this warning message comes out due to some unexpected
              things happened(like ctrl-c) I think user would not be
              surprised to see some warnings.<o:p></o:p></p>
            <p>Regards<o:p></o:p></p>
            <p>Xiaogang<o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">Jon<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          amd-gfx
                          <a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                          <b>On Behalf Of </b>Chen, Xiaogang<br>
                          <b>Sent:</b> Monday, October 20, 2025 12:00 PM<br>
                          <b>To:</b> Yang, Philip <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                          <b>Cc:</b> Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                          <b>Subject:</b> Re: [PATCH v3 1/2] drm/amdkfd:
                          Fix false positive queue buffer free warning</span><o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" align="left" width="100%" style="width:100.0%">
                    <tbody>
                      <tr>
                        <td style="background:#FFB900;padding:5.0pt 2.0pt 5.0pt 2.0pt"><br>
                        </td>
                        <td width="100%" style="width:100.0%;background:#FFF8E5;padding:5.0pt 4.0pt 5.0pt 12.0pt">
                          <div>
                            <p class="MsoNormal" style="mso-element:frame;mso-element-frame-hspace:2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly">
                              <b><span style="color:#222222">Caution:</span></b><span style="color:#222222"> This message
                                originated from an External Source. Use
                                proper caution when opening attachments,
                                clicking links, or responding.
                              </span><o:p></o:p></p>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <p>&nbsp;<o:p></o:p></p>
                    <div>
                      <p class="MsoNormal">On 10/20/2025 9:30 AM, Philip
                        Yang wrote:<o:p></o:p></p>
                    </div>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <pre>Only show warning message if process mm is still alive when queue<o:p></o:p></pre>
                      <pre>buffer is freed.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>If kfd_lookup_process_by_mm return NULL, means the process is already<o:p></o:p></pre>
                      <pre>exited and mm is gone, it is fine to free queue buffer.<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>Fixes: b049504e211e (&quot;drm/amdkfd: Validate user queue svm memory residency&quot;)<o:p></o:p></pre>
                      <pre>Signed-off-by: Philip Yang <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>---<o:p></o:p></pre>
                      <pre> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--<o:p></o:p></pre>
                      <pre> 1 file changed, 3 insertions(+), 2 deletions(-)<o:p></o:p></pre>
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>index 4d4a47313f5b..d1b2f8525f80 100644<o:p></o:p></pre>
                      <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                      <pre>@@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unmap_parent;<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<o:p></o:p></pre>
                      <pre> <o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;prange-&gt;queue_refcount)) {<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_mm(mm);<o:p></o:p></pre>
                    </blockquote>
                    <p>p-&gt;mm is null, not p&nbsp; because driver set
                      p-&gt;mm to null. But
                      still&nbsp;prange-&gt;queue_refcount is ref of queues
                      from this prange. If app unmap this prange app
                      should have destroyed the queues associated with
                      this prange already. If not, it is not driver
                      issue. I think driver should send this warning
                      anyway to indicate there are queues not destroyed
                      by app before app unmap the prange. It is an app
                      race condition, not driver.<o:p></o:p></p>
                    <p>Regards<o:p></o:p></p>
                    <p>Xiaogang<o:p></o:p></p>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <pre>&nbsp;<o:p></o:p></pre>
                      <pre>+<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p &amp;&amp; atomic_read(&amp;prange-&gt;queue_refcount)) {<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<o:p></o:p></pre>
                      <pre> <o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Freeing queue vital buffer 0x%lx, queue evicted\n&quot;,<o:p></o:p></pre>
                      <pre>@@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to quiesce KFD queues\n&quot;, r);<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                      <pre> <o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_mm(mm);<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p)<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></pre>
                      <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = &amp;p-&gt;svms;<o:p></o:p></pre>
                    </blockquote>
                  </div>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------AAYhv5QIXk3ZnC1Mwgp72Wp8--
