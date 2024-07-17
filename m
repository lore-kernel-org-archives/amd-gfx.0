Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFBC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 13:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805DE10E0D0;
	Wed, 17 Jul 2024 13:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WpUBAZ6m";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A2E10E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 13:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSCmp33qKt5oyGvF8fShmvw+dFbdVKn73GTRfLUryRCd3C2HcofZ3HRcgF/K8gReaBYllIBW3hAspLclTwl5Le1DnGBKyrXCMGiS1N2/D9nearuolFdzKeDj7sEjlwPnis0yjISDA+6877GgcvcKtxTs5O/TfCV+kETuqx7Q/VIDhvhpx2dZGJ+wRTlu5Fpu4u9I5OfvARb9mqlDenN9E8t0wkw6Hw+4WLQzUHYVlVZrGK5ZKXtacJN/79qoeG3DynF7cLa2fuQyF+2gNkBKeSOYRcgp/VrDOK7yBgoQ+vWiakQ0EEiwOaACChlumkJKzNLZR8W3/nUMpzkH1FpBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Cm1mMx9K7nBU2X5uus6uKSlJOjAVg1rjpy+30guDUA=;
 b=jEmwb/bYdPt16RjRG2cyrCzYyx1v7ZZtr1u1SURkwAPJYjyWIkGLoA0tKSpTPNkJ2cQoRUoQJtcWO+fGByP16Wvp6gMOtgBPUxU9uk03Tw57XHozM7iyGHwVpOK6Bt+CPNkZglkIPuG3DokCwdpu+MY607g9u+7AUs1XJog01qbPNL9WNX3AUmfvwtozuGIRupOqUiM5WHCHTWHnYV5cXUYmX2jdej6nYGg4YMZLIIEVSoQBG/dEvxfSI+NwWDm2twGFXkoM66MrtdJixOQB5VvX6b1azllRTP7yawRJvYIprtxqbe0x0o10lc6x6n3lUUkB5m+xs5NqJPmi4XR6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cm1mMx9K7nBU2X5uus6uKSlJOjAVg1rjpy+30guDUA=;
 b=WpUBAZ6mW46u7Ie0dtFptlr1nrO7ObeuylYiQTZa3pWrpAvjlqcge+GOwa6vvwxN5xy5go1QLSQFppa5uN0E1mvYdVgbBsuBX4AP93gzv1H3m2POJn2qG5t4ttDJviFF5Y+yIsdq4B7vRQPrPlnpQb5elkH48B60pPK4e9rJ/FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 13:47:25 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 13:47:25 +0000
Content-Type: multipart/alternative;
 boundary="------------HSvchnEwLQvY0v0s02of0Gti"
Message-ID: <2abaea31-a38d-4af0-9bb4-6522ab9458f4@amd.com>
Date: Wed, 17 Jul 2024 19:17:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add null check for dm_state in
 create_validate_stream_for_sink
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240716150828.218679-1-srinivasan.shanmugam@amd.com>
 <20240717024000.512972-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240717024000.512972-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b80662-f90d-4a74-1538-08dca666fd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2Q3R1J1Z3lVdC9BQmQ2M1o1TC80NDNZZ3ZIOWhrVzJWRVpZTVR1N1BYeG1m?=
 =?utf-8?B?REFncWlkcjBIQktubi9QNGdyZXlwNjFLQ1N4aU1md2JQZUE3N3IrQmtoc0Za?=
 =?utf-8?B?U0E5cnI2RlVuNDl6T0ZYV3BEOFBVeVk2MnNuQktpbmdvMi9FUUpzUkUzZDZH?=
 =?utf-8?B?Zm1FWlh5aUhTb0hyQ0F3OS82czB6THNGTVV5NGQ2cVVPWmgyRXdEVEd0QVRu?=
 =?utf-8?B?aHZ1SHlkMGxaRWFteU9TbjhGSy9ZdHVMbW54bTdITkZMRCsxNkhIeHU2YU85?=
 =?utf-8?B?bmphbEQrc0VBQ1RIb0hmQm82V1pIa280RFRPZEJVcCtkT2czRkVHd0ptQldE?=
 =?utf-8?B?aW5zU2V4eUh6TnVQZHFEeFZDVnBjVUI1d2VmSXcwRWpmazd1NVYyTmxEZEMx?=
 =?utf-8?B?ckp6OXBnNGVLcXJBWnFDK2s0bi9iZXBKTEQvVXY2V2JXeSt3T1RYTkJ6ZG9B?=
 =?utf-8?B?RVFXcURhU0dLVUVreFFJMlYwalJmRVppY2xjbFVxWGRmYS9BL0dIdTRwaytS?=
 =?utf-8?B?OTBEU0N6MTZsQ0QvYjlhZG9Wa2JOZkVjSEhLRTNyVHIwc095S0pOUjJPbHJi?=
 =?utf-8?B?Z1ZrRUlVUWk2czlCSzZNZkZzR0YwZythUTBJVnM2U2pVNENHQXl5cHM3SUcv?=
 =?utf-8?B?MXhYVjJOZkg4cWZIeFU1cHl0WFNTZyt4Wlh6Ui9Gb3E3UXVmR2YwWFR4Y3FZ?=
 =?utf-8?B?OHJsSVMvaVY2OXVIRFlNNTNqRFE4QkhCc0gzVzRwUmVtZU5RWDlLSU8xK291?=
 =?utf-8?B?RUVpWVRTTXBScitCQnpoT05TeXpyaTZlMGJsbURGRmYwckFXcWFHb3hjTlI1?=
 =?utf-8?B?eUUrMGw3SGZHZGFrWGx2TExWSXFyQnFpbzJjSGRQSzgyQVlVMlpJNjZmek1K?=
 =?utf-8?B?VDhWajFTNHgzeU8rMS9ZQW9mSEd6ZHU3dkRjUnVncUVIRXlvVU5HZnhidVdq?=
 =?utf-8?B?alc1RVNEeEluNG1qNE5haW9pUWJPMUJvMHdQRi9Ldk9iOUF1bUtWcnM5NGI5?=
 =?utf-8?B?RWhTck1Ic0gvUGZlanRPQWlPZ0VsUmoxVGwxRC9WY1BZTVNMczBoQTgxU2dB?=
 =?utf-8?B?Y3lwb1dud2FCcHVlMFAreGN4OG9sVGxUZUIwRHY0MkJmM1B6aG1VaE4xQVFx?=
 =?utf-8?B?T29aUFlNeFJpdDJ1MUFOQ1NFQ3BlVDZRL0IrOUZ1OUxUdnNXL3U5WEprekZJ?=
 =?utf-8?B?NE1yZFczZCtMYlB4S3VNTlliVzdidmpDOXJOM0JJMG5jQ21xcnFFd1JKdzdH?=
 =?utf-8?B?K0VyUUk0OWo0eEdhdDYxQk51dzE2Vkg0dm05WWIxcUFyTEs2UkFiOFlVTWgz?=
 =?utf-8?B?UStSSW54Vmkwc0l4eThPSjhjU0dncTNFUG9tZVZVQVozaHM1QVlyWEV2RGF5?=
 =?utf-8?B?UHZJamtKQmczMUNKOFVrZmJnejYvSUlDcHdsbStTVndrQlhmRExRZ3FIdmU1?=
 =?utf-8?B?ZjdqanA5Y0IvZjB6ZjIrRXNpM05OaFJWYnJQMWs5Z3ZNY016SlJySVhwY0Zh?=
 =?utf-8?B?bTVoczFSVUpuSGxJSCs2Wm4xYkRTZm5mdEwza0tUaEZrYndsQklSVjFLQzV5?=
 =?utf-8?B?V2Noc1duYmVheTRXV3N1K3hSM3c1WjcwZzR1V1VXTUI0YVdqMGhlZi85WUNy?=
 =?utf-8?B?cERvWEd2dWZFSitNakZWSXJ6V2dxbHgzZ1N1K1ZuMjNCUDVodmpJNUN5aWp3?=
 =?utf-8?B?Q254akp0cUsvbFpUMFl4bmZvcldscDQ0RVU1QnJiWkpKU1hZUnVOVlRwcXlp?=
 =?utf-8?B?ZFAxdEwzWXdlNkh3Y2ZUOW91dkgwS25PRmp6WGRXQjV4dE5iMTI0M0RWQUY5?=
 =?utf-8?B?dkJxZ3FUMEtKbWQ2MjFiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlib1dtMWlrN0krMk9TdW5jUVNRM202VFN2WjJCTkFGaGYwTnhhVFZKUWYz?=
 =?utf-8?B?aldJeEMxZmpVYnZQZVJlVUZUOWo5WWsrVnNreStZenlXVkdkdW1YS0NoY0R3?=
 =?utf-8?B?eXFMdWNhQ0lQYTg0YlgxZ1hPanZJblRxUTJzU0VTWkNzbGFSbFl4WkRJMTQ5?=
 =?utf-8?B?T1NmOHVXM0FKa0kyTEd1dk96NERYTEVFakUxS0FHd1BVZmxUbUNlTE9XNUF1?=
 =?utf-8?B?Q3N5KzNVdzd5bzVsUzdiaHBVVDkveklSZkNZZldodURXbi81NklpZktzM1Iw?=
 =?utf-8?B?bnZRQnlMRGJmTEJLb0Job1Z1STJZeHlxUFFVQXllV21IcUsxV3FEY1VmUVZw?=
 =?utf-8?B?Ynl3U1A0dGpoQ2YrK2ovYlpqS0wvdmRudU9iUUxFOHdlNk42cjNoTTlSYWRr?=
 =?utf-8?B?OHpUMG1JblFGWHl5cFNXU2s3cVVRZEdaUmxVb1l2ZUQxcjNpSFNlcXE3L3U5?=
 =?utf-8?B?MWMyWjVJdmpVMUpzMDlpMjlrMlF1QUhnUmNkRi9tOG9QVnpsVk5HeHBFV2Uz?=
 =?utf-8?B?YlRsaS9SRkUyaHdwWUM5NUtnenNDZHFLMlBWVEQzeTJUSnBKcDc5cnpBaWha?=
 =?utf-8?B?R3M3aHBQRHhVa1JyNk4xMFBDV1dDbXR5YTVwd2N5Snl0QjFEd1FnQjVIZVBD?=
 =?utf-8?B?ZlYySFRKc0ZzYjB6MytkL0U4dThqOEcrQUdmMU82M21hWUR3RFduckhyTkpX?=
 =?utf-8?B?eUdFZ0FjNGtNc3Z1aDBKQmJNWERDMXZEVkxwUVhSNDZvTk15V3RSaXB1TmhR?=
 =?utf-8?B?VkR6VVIxY0l6REt2RFFRU0x0VllVYjlHVS84RDBCWWJtRVVsOEtPbVVHYVZo?=
 =?utf-8?B?V29ORlM1TUZNaTRiYm9Mb1dyR0ZJUTk0NVNQa1pBOUI3NVV6ZkpJU1hGNW0x?=
 =?utf-8?B?U0FhRll2RXQ2Zlkyb2lOTjF0VFFhTm1ubzA5NWViVFl1ZnhhN211TGwyVzFy?=
 =?utf-8?B?ZEM5MDdObkRwaHR4Rjc0T2ttM1NLRi95aGpXcDZDQzNoTGpPQ1VnekZ6VkF3?=
 =?utf-8?B?YTdkamRkYmszYUFxQUE1WGhlczQ3WGZIc2ZCTjZIUTlpT2xVdlJocGxrQmRB?=
 =?utf-8?B?bWsyVkdIR2tramwyNTVwYm03bjkzWGFFME9sMnNrVXdLU2VEdVQzQnV3TE5L?=
 =?utf-8?B?RmRvbnpEeFhCeXpseVIwdVY0S3RZR2JVWkloNS9uYk03dG41ZzJQSUFWMncx?=
 =?utf-8?B?SXd1M04vSDRFdkZkUmF4L2VNWW8ycXBYR1dSdFVwMHJnTmZEMDZnQ09Wc1gw?=
 =?utf-8?B?a25YSkRBdmFWcWxWcFBzcVo4THo5Rmh6d1dPa1I2NURYRzAvckRIRkpudWdH?=
 =?utf-8?B?QngzRlc2QWV2TFdWeEFjMFl0b085WSsrd01Ub0VLWnZteDFoZWlhVXp4MXpn?=
 =?utf-8?B?WEF1Z053Z1QxYWdUV3JPdVdweG9MNjVIMFZuRWtTenBaaWNsQVBpb1EvM3Ba?=
 =?utf-8?B?em5CVEhxaG9CNDhyMDZJYk52dDl4bnhUMTQ5aWRYbVFUVUhsMHlaQm9rT1Jp?=
 =?utf-8?B?UThJWjQ3YUJlTFhPOGl4Y3VZcHEwRytaSFpzbGRRUHN0MHpUaTJOZFhMVzhV?=
 =?utf-8?B?SmNWQy83SkNMU1FYQUNsUVk0SHQ1clR4VUwxTUprZjc2aS9tYWx0UmtkMUlS?=
 =?utf-8?B?VFZQdVJSTGs2czBiUlFnZHJzSy9KVXdBQmxmS0JFZ0NIMHBzL1JFU0hzOUJF?=
 =?utf-8?B?cWdDOUllRTFkSHRIc2xucm4yUVp3elFuU2RlWFkvL2JUSklvVk56Q1E3ME9h?=
 =?utf-8?B?Vm93NXJCMEhXZnBFZzFZeDd6MzlPeWM4NlZMU1RPRDA1UjhXWlFWWXQzWFN4?=
 =?utf-8?B?aXRTdmkyWGtIeUJJVEZveWR0R2F5bUtZOWFnaXpzajAwdUNnSysxdXArd1d5?=
 =?utf-8?B?cXJ4RnpKL0poUExNVmdJL210TUFRZ01WdzJPdTdjbk93Z0VBOFNEK2pReEkv?=
 =?utf-8?B?RTFKNHhSL3g0N2IwMG5BZHNpUnRNQk55Ymk4MUhtMEZDRDlPcXlmNVYyeEQ0?=
 =?utf-8?B?RUMvMmZxakJVSlVXdlRpOVN5N3lLSS9GTlh6UkJPdEo4eHhMVG1RVzV4RXJK?=
 =?utf-8?B?RHFvZzQySUNxR0Y5ZmFWU0l1V2hyWjhDNGJDYVdTLzVpMkd5emlMNXNZdlpn?=
 =?utf-8?Q?oPNwecxkFlX4N8mbDD60XuNlg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b80662-f90d-4a74-1538-08dca666fd4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 13:47:25.5613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGQxA6zY8dlBgoEkBLGESoe+SilFni5Dwx9tfn5yNUy9RtBboZGJDUnU8pZ3oExBSNV2gDPLQU5apBxgMT42Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

--------------HSvchnEwLQvY0v0s02of0Gti
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think we can ignore this change, as it already exists in the below 
commit of asdn.

commit b90c2f233397f40c757995b9c00f8c6e380c6913
Author: Alex Hung <alex.hung@amd.com>
Date:   Thu Jun 27 17:38:16 2024 -0600

      drm/amd/display: Check null pointers before using them

On 7/17/2024 8:10 AM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the dm_state variable in the
> create_validate_stream_for_sink function. Previously, dm_state was being
> checked for nullity at line 7194, but then it was being dereferenced
> without any nullity check at line 7200. This could potentially lead to a
> null pointer dereference error if dm_state is indeed null.
>
> we now ensure that dm_state is not null before  dereferencing it. We do
> this by adding a nullity check for dm_state  before the call to
> create_stream_for_sink at line 7200. If dm_state  is null, we log an
> error message and return NULL immediately.
>
> This fix prevents a null pointer dereference error.
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 create_validate_stream_for_sink()
> error: we previously assumed 'dm_state' could be null (see line 7194)
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>      7185 struct dc_stream_state *
>      7186 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>      7187                                 const struct drm_display_mode *drm_mode,
>      7188                                 const struct dm_connector_state *dm_state,
>      7189                                 const struct dc_stream_state *old_stream)
>      7190 {
>      7191         struct drm_connector *connector = &aconnector->base;
>      7192         struct amdgpu_device *adev = drm_to_adev(connector->dev);
>      7193         struct dc_stream_state *stream;
>      7194         const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
>                                                                 ^^^^^^^^
>                                       ^^^^^^^^^ This used check connector->state but then we changed it to dm_state instead
>
>      7195         int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
>      7196         enum dc_status dc_result = DC_OK;
>      7197
>      7198         do {
>      7199                 stream = create_stream_for_sink(connector, drm_mode,
>      7200                                                 dm_state, old_stream,
>                                                           ^^^^^^^^
>
> But dm_state is dereferenced on the next line without checking.  (Presumably the NULL check can be removed).
>
> --> 7201                                                 requested_bpc);
>      7202                 if (stream == NULL) {
>      7203                         DRM_ERROR("Failed to create stream for sink!\n");
>      7204                         break;
>      7205                 }
>      7206
>      7207                 if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>
> Fixes: fa7041d9d2fc ("drm/amd/display: Fix ineffective setting of max bpc property")
> Reported-by: Dan Carpenter<dan.carpenter@linaro.org>
> Cc: Tom Chung<chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira<Rodrigo.Siqueira@amd.com>
> Cc: Roman Li<roman.li@amd.com>
> Cc: Hersen Wu<hersenxs.wu@amd.com>
> Cc: Alex Hung<alex.hung@amd.com>
> Cc: Aurabindo Pillai<aurabindo.pillai@amd.com>
> Cc: Harry Wentland<harry.wentland@amd.com>
> Cc: Hamza Mahfooz<hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
> v2: s/DRM_ERROR/drm_err() (Hamza)
>     
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d1527c2e46a1..e7516a2dcb10 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7195,6 +7195,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
>   	enum dc_status dc_result = DC_OK;
>   
> +	if (!dm_state) {
> +		drm_err(&adev->ddev, "dm_state is NULL!\n");
> +		return NULL;
> +	}
> +
>   	do {
>   		stream = create_stream_for_sink(connector, drm_mode,
>   						dm_state, old_stream,
--------------HSvchnEwLQvY0v0s02of0Gti
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>I think we can ignore this change, as it already exists in the
      below commit of asdn.</p>
    <p><span><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">commit b90c2f233397f40c757995b9c00f8c6e380c6913<br>
          Author: Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a><br>
          Date:&nbsp;&nbsp; Thu Jun 27 17:38:16 2024 -0600
          <p></p>
          <p>&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/display: Check null pointers before using them</p>
        </span></span></p>
    <div class="moz-cite-prefix">On 7/17/2024 8:10 AM, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240717024000.512972-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This commit adds a null check for the dm_state variable in the
create_validate_stream_for_sink function. Previously, dm_state was being
checked for nullity at line 7194, but then it was being dereferenced
without any nullity check at line 7200. This could potentially lead to a
null pointer dereference error if dm_state is indeed null.

we now ensure that dm_state is not null before  dereferencing it. We do
this by adding a nullity check for dm_state  before the call to
create_stream_for_sink at line 7200. If dm_state  is null, we log an
error message and return NULL immediately.

This fix prevents a null pointer dereference error.

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7201 create_validate_stream_for_sink()
error: we previously assumed 'dm_state' could be null (see line 7194)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    7185 struct dc_stream_state *
    7186 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
    7187                                 const struct drm_display_mode *drm_mode,
    7188                                 const struct dm_connector_state *dm_state,
    7189                                 const struct dc_stream_state *old_stream)
    7190 {
    7191         struct drm_connector *connector = &amp;aconnector-&gt;base;
    7192         struct amdgpu_device *adev = drm_to_adev(connector-&gt;dev);
    7193         struct dc_stream_state *stream;
    7194         const struct drm_connector_state *drm_state = dm_state ? &amp;dm_state-&gt;base : NULL;
                                                               ^^^^^^^^
                                     ^^^^^^^^^ This used check connector-&gt;state but then we changed it to dm_state instead

    7195         int requested_bpc = drm_state ? drm_state-&gt;max_requested_bpc : 8;
    7196         enum dc_status dc_result = DC_OK;
    7197
    7198         do {
    7199                 stream = create_stream_for_sink(connector, drm_mode,
    7200                                                 dm_state, old_stream,
                                                         ^^^^^^^^

But dm_state is dereferenced on the next line without checking.  (Presumably the NULL check can be removed).

--&gt; 7201                                                 requested_bpc);
    7202                 if (stream == NULL) {
    7203                         DRM_ERROR(&quot;Failed to create stream for sink!\n&quot;);
    7204                         break;
    7205                 }
    7206
    7207                 if (aconnector-&gt;base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)

Fixes: fa7041d9d2fc (&quot;drm/amd/display: Fix ineffective setting of max bpc property&quot;)
Reported-by: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:dan.carpenter@linaro.org">&lt;dan.carpenter@linaro.org&gt;</a>
Cc: Tom Chung <a class="moz-txt-link-rfc2396E" href="mailto:chiahsuan.chung@amd.com">&lt;chiahsuan.chung@amd.com&gt;</a>
Cc: Rodrigo Siqueira <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a>
Cc: Roman Li <a class="moz-txt-link-rfc2396E" href="mailto:roman.li@amd.com">&lt;roman.li@amd.com&gt;</a>
Cc: Hersen Wu <a class="moz-txt-link-rfc2396E" href="mailto:hersenxs.wu@amd.com">&lt;hersenxs.wu@amd.com&gt;</a>
Cc: Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a>
Cc: Aurabindo Pillai <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a>
Cc: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a>
Cc: Hamza Mahfooz <a class="moz-txt-link-rfc2396E" href="mailto:hamza.mahfooz@amd.com">&lt;hamza.mahfooz@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
v2: s/DRM_ERROR/drm_err() (Hamza)
   
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d1527c2e46a1..e7516a2dcb10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7195,6 +7195,11 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state-&gt;max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state) {
+		drm_err(&amp;adev-&gt;ddev, &quot;dm_state is NULL!\n&quot;);
+		return NULL;
+	}
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
</pre>
    </blockquote>
  </body>
</html>

--------------HSvchnEwLQvY0v0s02of0Gti--
