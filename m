Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ACEE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 12:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F343510E11B;
	Tue, 14 Jan 2025 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TBWnsyaN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2819310E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 12:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HElFJaslyO5VvnwabLV/zTdWxzuWhTO65OtkZKRgjLAfLIUKqeJgmeksrbk6l7Qxhxk8nkfKi3vPFc81HH/Lbd2JLuksNBMNptdAniKDbPcvLpyW2F4/B+oFZyi9FN3WWPffFx1o/AoIlNUn1n+mDxCfT9QKCTTc8GsHd0RPx7tPfPEuplOqaD9l5ZZb/RcTMMc9cCzLmX6O/lHzcLQ+ePD8Ybh9Ri0Z0xwEWMxwlOCzrUXJkWS8+48Rq7Y9mNAJkF2E/m6tO5uhwuIE9lGLJQECK8b8RUN06hc96IqM93cI2nvXM9xF4u+WlY5OuO2KddDZU2q1jf6wmuBoEGALKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoizZQ7lPQYc1PQrgQ8gHbZOY74M0Pcp0Ie7lNHyI4g=;
 b=Kt5y1Vttr1pxxAfeAxvnyvSc6ZWzZabIHYdsUtd4tsc179u7e/eo1JrTzW844SN83bFxrRfQEQgoSWa5r2gSqpuEyZjclDW+PQZNWfw30ToiN2gPv7tyd4Q8UlLfn3g3b7NxJe5to+VoYjVwUv1mndyMZQi6Xzuxqr3mtUj/OF8y786Q83R9IIPsWHr3gRyNAtR4PED912p21QdgCsYa3Y8pAEvLiEvn5RjgHGYHCAWZk2AOrXad2Fbu3SsYSp6VRvOd3DdAfbOSym9bunJP7816gpPPZGLbOqYdMKHFHMXL0ZvG+aMaIkOvzRyv7MAsEs5dzsZg1++HLoTcjijc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoizZQ7lPQYc1PQrgQ8gHbZOY74M0Pcp0Ie7lNHyI4g=;
 b=TBWnsyaN+HHFp2z69dMR2JlF7aNhRcdJegvjpCxLU1PmKhQPXKQ6IB6YjyF1AD8tc3oGaGma2cAPD1Be6JKXgT/+IYA1Oxje0oEErqFHUAbzyThuLOC7VouhRaNlBa3J2oUlVp1SHxDYIeEJP3wISkR/fOiVz+hufC+SRqKoOxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 12:43:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 12:43:48 +0000
Content-Type: multipart/alternative;
 boundary="------------53Hh20kQLrDgafDCZod7tBxz"
Message-ID: <820617e7-f82f-4a08-9035-0c4a753b61ee@amd.com>
Date: Tue, 14 Jan 2025 13:43:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736847835.git.gerry@linux.alibaba.com>
 <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
 <DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com>
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: d2908daa-a3f7-4276-e65e-08dd3499178b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cklXVm45UW94QWMzNXJ1bDZXbmZEc1g3cXMzbk5uUDdhbUNTN0JwYksxVFgr?=
 =?utf-8?B?Rll6dnlEWWpaMDN4dlpUZ0NEazlIdFJCaHpyc1R0VVkzLzJxaS9icEZqR21Z?=
 =?utf-8?B?cHBZbTZveHRNSjAyek5COTJoM2VnZXBrRFI3QU12QU1iamd3WXFIc3QvcUht?=
 =?utf-8?B?cTZkclRuV1VURDU0ZVBJU1h5eFRlY29oN3huQzd2S0ZCYWJ3Q1hQcDhLWTlV?=
 =?utf-8?B?ME5KaXJpTkc2dEdxVHFYeTRkUEhreFIyRnU3YjZhcW1UNEp4QTE5NW5aSDJl?=
 =?utf-8?B?aUliRkE2Y2RGZDNMMXRCelNjOUpmVWNOQW96NDQ0MU14aGhZZ3EyYmVVM1Jq?=
 =?utf-8?B?V0s1eSt6OGdXaDVZSlllNGR0ZmtyKzUvYmYvTmYvVC9UaG9XUi90S0dNTnlU?=
 =?utf-8?B?SlV2dEtac1g3QzJHT3k2cUE3RGtDamtlWGY5aG1qNkdvQ0RFZmU5b29oSzBG?=
 =?utf-8?B?Y3YvblJ2dnA0UkEzTHNFSGFVUWFUNThVdldDVUNzU0cwTVRzTzU4M1UzNXRO?=
 =?utf-8?B?emJKZ3dJTVB5TUcxSTJtcXBGZ1VQdEx2a0ZLcEM3RllPYVFLQkJVck9GMDA5?=
 =?utf-8?B?TmF1QXJnVWEvOFV4OVVpNDVnZEJIZDBVUm4xOEQ5NGNrY0NPQXF3V0FEMnJk?=
 =?utf-8?B?c0xVeStyQysrbUdGTUJlNDBaWml0VTlMZmNEZlJldVIza2VBWFpOODJleEFJ?=
 =?utf-8?B?WkxaelNxZktYL1h5VzNOakMrVzZOOWc1WHhJbUk5WThlUHF0S3VLalF6NG84?=
 =?utf-8?B?VE1VaXBwcTVzbmx1Ri84b3o4TXZRZGhhd3RmUjhJQ1c1NDlrVlg2NTR5S0kw?=
 =?utf-8?B?QkwrSjdWclB0cGxVL3dmQ2FoeUxYRGZRSEkrQzFYeDVkT2psZVlBNm10ako0?=
 =?utf-8?B?SjRWc1lNZWtqYVhGaG1kdS9iL2tsbDY2cng2K3lWM1VFdGJrNmJPclB0OXNE?=
 =?utf-8?B?d1RwV0Yrc3JLMWRiYWdxdmMrME8zSWczS0hwSllNbkdWYUU2cERoSW5QQ3Bk?=
 =?utf-8?B?OGJEMTN5eFcybnVxTnp6RUovbDB0a0VqVVNjZzJQWk1FakdFYmZqMFdqQXdk?=
 =?utf-8?B?MW1icmptSzVaeCs3MzhFUFpxWlBvYVZ2RVduSzZPMnFwTTBSNi9VZ2hwdGtU?=
 =?utf-8?B?VEtmUHJaOGRHYmV2M3NPMk4zMkRwbU9rczVZTW9TWXBEQWlub1hkTnEzYTlz?=
 =?utf-8?B?NlZBYVl0dE14b2hyZ2hWQzlLVUFoTWVSSVZpVElEUmJKTzhiMVBwNmdMMWdo?=
 =?utf-8?B?UDFmb1ZiVWpTRzRpVys1TVV1USs3d21zNW5HQUdyNGt4KzE0L3ZsYlhzVldC?=
 =?utf-8?B?K2ZwKy9YTnhLcjRhNm9Mb041MG9WamgrdkI5TlBRTlFqT1krcjIwZEFGUlp1?=
 =?utf-8?B?U2NyYjdhbVArV0lDckdOVGttWGFXRGQrZVROaHJTY09CN3A0MlZBeWovYjQ4?=
 =?utf-8?B?ZitnMXBRTktiU2RZVUpqeS95RU9JcUpxcmlvOG1WV1doRXgxN3JyL2JYS0pL?=
 =?utf-8?B?TkgwNmw4KzRzOFk0NU1rcWVwczNKN0FBU0R1clBVRmVHWEpRWG5mY0p1ZXVG?=
 =?utf-8?B?Z21oWVpER0xaNVFqWnFsMWozNmlYZ0pzVzM1OWVPdjJNamJkUnI4cG96RlVj?=
 =?utf-8?B?SXpnaklNR2xNdzV0UUtHV3JQSURUMUgyTHNhYWlRaDNxaXVuckZXdk1WZ1kz?=
 =?utf-8?B?eUN1Q1ZrMEVWd1FyUmY1b0JBMDk0bTAyWkpxcXFseE1XaUtLc08zOWNBUnd4?=
 =?utf-8?B?TDdwdlJrbTg3dGpkRDVLN3UrVFVDTDFqYmRXSi84WmZIT2VYVy9OUVFSa3hJ?=
 =?utf-8?B?S2t0M25BZk00Y2RvTUFHSWJjK1FtRE85YVFXMUhFL1FSSlRuTnZrT3k2ZFpo?=
 =?utf-8?Q?mNluh1k6J13nI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FrZlFGM2l6Ny83QXRzL3FRWThzVytKU0o2RHNjS1FSU0JRemdVa1p4WnJV?=
 =?utf-8?B?N2RwSHFaWU9FY3NVS2VtaXFuQ3l0YmVSME5HSHVCRkUwOXBwNkNnV1V1cVlS?=
 =?utf-8?B?SUhNV3JkVitTbVBlRklpcnpPVFZUN0tJeHNabHhFQmxvYlZSdWtzNjllZ28y?=
 =?utf-8?B?V0xwV2lyN0tYNzZwMUd1RFFiVHZrV1Y4Y1NNK240Mk5kMjVKVktBWTBMQ0Vo?=
 =?utf-8?B?T0o4MHVPOEIxbHJkVnZNMzg0MDRpQUk5ZkROb2pkdXJhcmoxbGtJek1zbEJI?=
 =?utf-8?B?a1JpNHVTUXNaZ1ZsSjhoQVovUjJHamNUMGI2UEdBU3ovS2JEYy9aaDFYMGR4?=
 =?utf-8?B?d2g0b2l0WG9XdUR0RGwzNzR3bW0xQUtVYzRwbDVleTA4cXdXWEE5RVZsbTI4?=
 =?utf-8?B?RWRpQjc4K25RR1Irdno2MVpTUm94aHk2N2pGMGwzSCtmVE1iZXU0a3MxYXoz?=
 =?utf-8?B?cEFxQnlXem1ONVlWSFZSODZzM1VHRitoQVNFeTlKZDQ3SHR2ZkhPdUJVL2pN?=
 =?utf-8?B?ZlRJSG01ekxsWGptdEo1TW4zUnNZWXZ3Zy9RQXIySmZDRWlhRjN3eU15YWV4?=
 =?utf-8?B?dGYwak5JL1ZZZThKRmVDZE8rT1Y5ZWk0NFhTeEoxOEVsOTR1VFRTWFdvT1Zz?=
 =?utf-8?B?eVFrMng5TTBmUEJZMkhmTzdUak5tUm5QMENJWnFEZGVxUWVLajlXMzNjVC9F?=
 =?utf-8?B?MnY2SmVYMDk5SUVROXBHRHc1c3JYbFlGRTV1VWpkRUtCY3BIU3pKVzVLMHpC?=
 =?utf-8?B?bVgySkdQT24xUUMyR2o1dEZnUENwUDBockNIQnZMR1dCV3pNSkVaRzhPUGFm?=
 =?utf-8?B?NHh2eDc0eDFoV0ltbkQ4dmJDWkZsUFBBNkRXanMwTWJaMW8yMnFsaXZjSVl3?=
 =?utf-8?B?ZkwrRVZOVFA2Y0xMRzNMdmhrU0VZenBSZU5zRXk3d1lZRGxSVGtRd0IyVTQ1?=
 =?utf-8?B?UEQzSVRmZ2FjTWtHU29YUWtpb2kzY1QzV2pRRW9kUlRzSlFRNFBUZHJ3ZUo4?=
 =?utf-8?B?SGlyQjVHUFlXVkdsRGU1NjVNUlBLaUgzc3kxRHhkZTNGcDZ2UUpBZzlQdVNU?=
 =?utf-8?B?MXhjTHA2WWtjY3cxWmU1Q0dHNzZUelFDS3ZDYmtZdU5lVXIzR1E2eXhERjN6?=
 =?utf-8?B?bURVVVVxa3ZTS3d1NXZid3BkOC9MbUNmRk82UXZKanRHZGd0U2hXMG5YdjhB?=
 =?utf-8?B?a3MzVGdrZXNqOVNwaGo2dzB6ZENZTWRsblRlWkJ1aWlqWnVZU054WG1oc0pM?=
 =?utf-8?B?ZGVRY2tUWGNhY2FieVNIQ3NqcnQzOStqYmJLSXlQTmxtUnNmY3dEbGdLRXdB?=
 =?utf-8?B?M1MrUWIwL3BaUHhsOVlhc0hzekVSNGE5QlR4TnJ4aHhxSGpwR3A4Mno4SlJ4?=
 =?utf-8?B?N3ZQUUVoRC9ZbGNNL0tkUDN2ZlBOSDNxWUpVWUtyaytIQ3hQMnA2UEhhU2Fo?=
 =?utf-8?B?WS9SWEZxZjdnUXdIazI0c0dZQytsWksxOTNDaXJhSzZTOHArVFlhSkI1eEZU?=
 =?utf-8?B?ZGFrT0VQeHRYSzBaZ3EzWDhuRjkzK3g3bEJWenJMUFJiZUhxYWpqd0Q0NXJD?=
 =?utf-8?B?anphMExKVFd3elAyOEFqWWN6OWNrWCtsbjVTK0IrM2x5UjM2MDQzYU15eDlq?=
 =?utf-8?B?cm81enp4MmlxelRXWk00NE5meTFTMC96YVBic3FoYi80eUdEeCtreEZ4NmRa?=
 =?utf-8?B?SlZOUjFkM0tRMlppZDZ1VFVvM3BaRXArQnM1Q0FtWDkvM0FrN0pMWWdZUm9N?=
 =?utf-8?B?Y1dwNXA1V2FtN0ZQSzlIeVo0OHQ1bm5pT2p4ZDhNMkJsaytkVGZaMlovOWZX?=
 =?utf-8?B?eStFSFl1VmFOK1B1ZldMUzNpdkFpRVdwRngzcWNjbk1XbmlPUlFYaHVPd253?=
 =?utf-8?B?MHBUU3pTOWxtdVlVUHpKT2cyYUIrWlVEREhDMjk2NlJ1NXZrQjh2aUhzeHMy?=
 =?utf-8?B?MU9JdmJqRDNDQmxEMzBjTm9TTmtCU0RRL1Q1dHVGM3h4a0EzL0xmcGgwdHd3?=
 =?utf-8?B?WW8vUFVBeFVjTDdxODNGaFFSWkQwb2pKbXJwNUxYYW1CbG04Z3A1bHlsMXoy?=
 =?utf-8?B?endDbTFtcEErNUZ0dU4rblQvWmlWRzlJbjNyaktTUU1mQWs0ZFg0cEpLUnl6?=
 =?utf-8?Q?2zDQ7tgHL1poCjIa5R4yiQou8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2908daa-a3f7-4276-e65e-08dd3499178b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:43:48.7588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqZy4FXIrIspjewqGgzylqwqa7OdRibqLvSBuU65A04jY70Sdvum150SVIMdf7D8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

--------------53Hh20kQLrDgafDCZod7tBxz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gerry,

Am 14.01.25 um 12:03 schrieb Gerry Liu:
>> 2025年1月14日 18:46，Christian König<christian.koenig@amd.com>  写道：
>>
>> Hi Jiang,
>>
>> Some of the firmware, especially the multimedia ones, keep FW pointers to buffers in the suspend/resume state.
>>
>> In other words the firmware needs to be in the exact same location before and after resume. That's why we don't unpin the firmware BOs, but rather save their content and restore it. See function amdgpu_vcn_save_vcpu_bo() for reference.
>>
>> Additional to that the serial numbers, IDs etc are used for things like TMZ. So anything which uses HW encryption won't work any more.
>>
>> Then even two identical boards can have different harvest and memory channel configurations. Could be that we might be able to abstract that with SR-IOV but I won't rely on that.
>>
>> To summarize that looks like a completely futile effort which most likely won't work reliable in a production environment.
> Hi Christian,
> 	Thanks for the information. Previously I assume that we may reset the asic and reload all firmwares on resume, but missed the vcn ip block which save and restore firmware vram content during suspend/resume. Is there any other IP blocks which save and restore firmware ram content?

Not that I of hand know of any, but neither the hypervisor nor the 
driver stack was designed with something like this in mind. So could be 
that there are other dependencies I don't know about.

I do remember that this idea of resuming on different HW than suspending 
came up a while ago and was rejected by multiple parties as to 
complicated and error prone.

So we never looked more deeply into the possibility of doing that.

> 	Our usage scenario targets GPGPU workload (amdkfd) with AMD GPU in single SR-IOV vGPU mode. Is it possible to resume on a different vGPU device in such a case?

If I'm not completely mistaken you can use checkpoint/restore for that. 
It's still under development, but as far as I can see it should solve 
your problem quite nicely.

Regards,
Christian.

> Regards,
> Gerry
>
>
>> Regards,
>> Christian.
>>
>> Am 14.01.25 um 10:54 schrieb Jiang Liu:
>>> For virtual machines with AMD SR-IOV vGPUs, following work flow may be
>>> used to support virtual machine hibernation(suspend):
>>> 1) suspends a virtual machine with AMD vGPU A.
>>> 2) hypervisor dumps guest RAM content to a disk image.
>>> 3) hypervisor loads the guest system image from disk.
>>> 4) resumes the guest OS with a different AMD vGPU B.
>>>
>>> The step 4 above is special because we are resuming with a different
>>> AMD vGPU device and the amdgpu driver may observe changed device
>>> properties. To support above work flow, we need to fix those changed
>>> device properties cached by the amdgpu drivers.
>>>
>>> With information from the amdgpu driver source code (haven't read
>>> corresponding hardware specs yet), we have identified following changed
>>> device properties:
>>> 1) PCI MMIO address. This can be fixed by hypervisor.
>>> 2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
>>>     they are information only.
>>> 3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
>>> 4) mc_fb_offset, which affects VRAM physical address.
>>>
>>> We will focus on the VRAM address related changes here, because it's
>>> sensitive to the GPU functionalities. The original data sources include
>>> .get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
>>> The main data cached by amdgpu driver are adev->gmc.vram_start and
>>> adev->vm_manager.vram_base_offset. And the major consumers of the
>>> cached information are ip_block.hw_init() and GMU page table builder.
>>>
>>> After code analysis, we found that most consumers of dev->gmc.vram_start
>>> and adev->vm_manager.vram_base_offset directly read value from these
>>> two variables on demand instead of caching them. So if we fix these
>>> two cached fields on resume, everything should work as expected.
>>>
>>> But there's an exception, and an very import exception, that callers
>>> of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
>>> VRAM addresses. With further analysis, the callers of these interface
>>> have three different patterns:
>>> 1) This pattern is safe.
>>>     - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>>     - call amdgpu_bo_free_kernel() in ip_block.suspend()
>>>     - call amdgpu_bo_create_reserved() in ip_block.resume()
>>> 2) This pattern works with current implementaiton of amdgpu_bo_create_reserved()
>>>     but bo.pin_count gets incorrect.
>>>     - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>>>     - call amdgpu_bo_create_reserved() in ip_block.resume()
>>> 3) This pattern needs to be enhanced.
>>>     - call amdgpu_bo_create_reserved() in ip_block.sw_init()
>>>
>>> So my question is which pattern should we use here? Personally I prefer
>>> pattern 2 with enhancement to fix the bo.pin_count.
>>>
>>> Currently there're still bugs in SRIOV suspend/resume, so we can't test
>>> our hypothesis. And we are not sure whether there are still other
>>> blocking to enable resume with different AMD SR-IOV vGPUs.
>>>
>>> Help is needed to identify more task items to enable resume with
>>> different AMD SR-IOV vGPUs:)
>>>
>>> Jiang Liu (2):
>>>    drm/amdgpu: update cached vram base addresses on resume
>>>    drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
>>>   7 files changed, 51 insertions(+), 2 deletions(-)
>>>

--------------53Hh20kQLrDgafDCZod7tBxz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Gerry,<br>
    <br>
    Am 14.01.25 um 12:03 schrieb Gerry Liu:<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">2025年1月14日 18:46，Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> 写道：

Hi Jiang,

Some of the firmware, especially the multimedia ones, keep FW pointers to buffers in the suspend/resume state.

In other words the firmware needs to be in the exact same location before and after resume. That's why we don't unpin the firmware BOs, but rather save their content and restore it. See function amdgpu_vcn_save_vcpu_bo() for reference.

Additional to that the serial numbers, IDs etc are used for things like TMZ. So anything which uses HW encryption won't work any more.

Then even two identical boards can have different harvest and memory channel configurations. Could be that we might be able to abstract that with SR-IOV but I won't rely on that.

To summarize that looks like a completely futile effort which most likely won't work reliable in a production environment.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Hi Christian,
	Thanks for the information. Previously I assume that we may reset the asic and reload all firmwares on resume, but missed the vcn ip block which save and restore firmware vram content during suspend/resume. Is there any other IP blocks which save and restore firmware ram content?</pre>
    </blockquote>
    <br>
    Not that I of hand know of any, but neither the hypervisor nor the
    driver stack was designed with something like this in mind. So could
    be that there are other dependencies I don't know about.<br>
    <br>
    I do remember that this idea of resuming on different HW than
    suspending came up a while ago and was rejected by multiple parties
    as to complicated and error prone.<br>
    <br>
    So we never looked more deeply into the possibility of doing that.<br>
    <br>
    <blockquote type="cite" cite="mid:DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com">
      <pre class="moz-quote-pre" wrap="">
	Our usage scenario targets GPGPU workload (amdkfd) with AMD GPU in single SR-IOV vGPU mode. Is it possible to resume on a different vGPU device in such a case?</pre>
    </blockquote>
    <br>
    If I'm not completely mistaken you can use checkpoint/restore for
    that. It's still under development, but as far as I can see it
    should solve your problem quite nicely.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DC5FBF2C-9F17-4E22-9D51-525EB33FC79E@linux.alibaba.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
Gerry 


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Christian.

Am 14.01.25 um 10:54 schrieb Jiang Liu:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">For virtual machines with AMD SR-IOV vGPUs, following work flow may be
used to support virtual machine hibernation(suspend):
1) suspends a virtual machine with AMD vGPU A.
2) hypervisor dumps guest RAM content to a disk image.
3) hypervisor loads the guest system image from disk.
4) resumes the guest OS with a different AMD vGPU B.

The step 4 above is special because we are resuming with a different
AMD vGPU device and the amdgpu driver may observe changed device
properties. To support above work flow, we need to fix those changed
device properties cached by the amdgpu drivers.

With information from the amdgpu driver source code (haven't read
corresponding hardware specs yet), we have identified following changed
device properties:
1) PCI MMIO address. This can be fixed by hypervisor.
2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
   they are information only.
3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
4) mc_fb_offset, which affects VRAM physical address.

We will focus on the VRAM address related changes here, because it's
sensitive to the GPU functionalities. The original data sources include
.get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
The main data cached by amdgpu driver are adev-&gt;gmc.vram_start and
adev-&gt;vm_manager.vram_base_offset. And the major consumers of the
cached information are ip_block.hw_init() and GMU page table builder.

After code analysis, we found that most consumers of dev-&gt;gmc.vram_start
and adev-&gt;vm_manager.vram_base_offset directly read value from these
two variables on demand instead of caching them. So if we fix these
two cached fields on resume, everything should work as expected.

But there's an exception, and an very import exception, that callers
of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
VRAM addresses. With further analysis, the callers of these interface
have three different patterns:
1) This pattern is safe.
   - call amdgpu_bo_create_reserved() in ip_block.hw_init()
   - call amdgpu_bo_free_kernel() in ip_block.suspend()
   - call amdgpu_bo_create_reserved() in ip_block.resume()
2) This pattern works with current implementaiton of amdgpu_bo_create_reserved()
   but bo.pin_count gets incorrect.
   - call amdgpu_bo_create_reserved() in ip_block.hw_init()
   - call amdgpu_bo_create_reserved() in ip_block.resume()
3) This pattern needs to be enhanced.
   - call amdgpu_bo_create_reserved() in ip_block.sw_init()

So my question is which pattern should we use here? Personally I prefer
pattern 2 with enhancement to fix the bo.pin_count.

Currently there're still bugs in SRIOV suspend/resume, so we can't test
our hypothesis. And we are not sure whether there are still other
blocking to enable resume with different AMD SR-IOV vGPUs.

Help is needed to identify more task items to enable resume with
different AMD SR-IOV vGPUs:)

Jiang Liu (2):
  drm/amdgpu: update cached vram base addresses on resume
  drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
 7 files changed, 51 insertions(+), 2 deletions(-)

</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------53Hh20kQLrDgafDCZod7tBxz--
