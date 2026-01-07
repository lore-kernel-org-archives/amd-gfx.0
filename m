Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8D2CDC198
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E280310E579;
	Wed,  7 Jan 2026 09:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="id5fXl6W";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC3210E57D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfKMd+rb3z3/GZEhnFVFkB2rGLRVW6wpn/f5lzbZfGfZmBZP4FojmVPoC3FvWnDzMSiTMkArL0qsTk7ZMo4nWTD6PiK+iAAQ7ZDVJxwolErTDOoZl0gYLhf9RP300XHjSy+gD91gB20UwS4+8LgcP+x9eki+fjAGRxm10gswNkrhCp3PSA65MdTt2ZmXqbHCDhuCrQGduup6Lm9Li+4TBZV+pQSeHIn04DvTyqz8aQ2wWx971u7D9L483hkwJAGP6Ze+pEmXxurkb2jrRlW0Kwl/fdee3Ke5FxZv9VrkmNXuThTM4Gx3Fy7blaCs/xhnqxa3zFPQUhmbAIXe8ZWcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rpXxJKL8wbehoiXo0dUVRlc4VYFGyB5QlN7sBPZOAk=;
 b=kHqMKNvceGu471Z84pgroXAstVom2Ipu/o4I/DYki2dvNgLjxQ1PzdeFDqsQSLCb5z/lYr0XGg3xIR4s1yrzTj/d2A2r/B0ChSafunKGzDvOntUuR+OCcaCAmd/4u+W9YVTCdrxRva4SaUpBzGfgmrf576GoCDbXqlbqvAaLUQJgjThm7hVUYPT3kZYWTh88E19L/0Q4hf9OYvObGUTKxL9G13fvFSAnfSd+idOk1qMhQ6TLJ6Wry771k5Lefw80UCSuY1SFxJzNUJL97W8rYokCFRrfcMWDTI9HguO7xCZpGYuAZgHkftp/C/bX2/vY6KXMvbNwTc7aNvkY45KFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rpXxJKL8wbehoiXo0dUVRlc4VYFGyB5QlN7sBPZOAk=;
 b=id5fXl6Wql33Ofl+CKMxjtg7Hct920wUsQmS+vC3ZfuD3yU9Mf8SZz+ZkKgTpkn1y7F1N6FDaN54y3d70I4r9sR28RvUMsdlpJrrJHF2X4F/S2v7SxbLLpFlZvQPWS4fPRIhtMtjQ3wZpXKhz7UA9uEfXXurqTJy6GaR+BWOnjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:37:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:37:18 +0000
Message-ID: <436966c8-2562-4d69-b5a1-86dc918a7e5c@amd.com>
Date: Wed, 7 Jan 2026 10:37:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] drm/amdgpu: Remove output parameter in bo list
 handling
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-12-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-12-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0407.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 97488b30-0e0e-4458-0161-08de4dd0599d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWg4UHJKQXV1d0NpZFZlcllzRzlWaTQ1MldnTmpQTEZBaFNGZkE1dUk3Y2Zq?=
 =?utf-8?B?TE5IOGQ2Szl1bk9FalVwdHU0QU9ia0tjanpzSExydEtHNUlCTkJrM0lmMEgr?=
 =?utf-8?B?QWljS1VGUVRRQXBFdFZKdDArTXhveE05OGZNQmNsekY4MnR1TStUeVhzZGpS?=
 =?utf-8?B?dTF3VlRKekFKL0VZWlc0UjlURnM2UjNmdkczQXp0ZEdYT0Jncm9IVUlRQ2l1?=
 =?utf-8?B?czFFOGgxY1ZBV2JwNytLbkxBS0twbXVPSS9QMkxWSTFzdWJCN0lqNjRZbTkv?=
 =?utf-8?B?OUZuRUZXSEhtci9xS2JHQ1N5cjg1bnlsUGlTc3gwZk03ci9JU0NoM1hQVm5D?=
 =?utf-8?B?RDlPQmVvTUU5YUxTeWU1a1R6UjBhcVRKWjFpZVA4REphbHUzOURqQ3ZCMnB4?=
 =?utf-8?B?djZ6NDlBRUUyZHdVVVp3ZElwR0N1K1h5eUhHZlVYdDljbjJ1V1VxOEFZRnhC?=
 =?utf-8?B?d0NEWGd0K045b0lLSE9pZmhCbUtKTUlQb3pwQ3d6ZUk4blNaZkFaeFdwaUc0?=
 =?utf-8?B?Y1E2TmdQaHFINmVCZGFvcjgyMzA2N0taSXN2T0pxMnExbW43Y1hpcWZDZU1F?=
 =?utf-8?B?YmFUcVdUV0U4b3diTDhmSkYvU3dGeG1QMk1Dczk1S3AzRHIrOUtHcFlZUTh2?=
 =?utf-8?B?clBQRzErNVZiSTk2cnB0cWpoZFU4RkRObENSZmxHZFZoc2FUaEpqc0VYLzNm?=
 =?utf-8?B?elRMOCs3QzdRZG82aVRYb2ltanNONndGcXBGVytDeHJlTk1vZnpndWhHUE52?=
 =?utf-8?B?Z1ZIZHJGQ21qYnZVWEFJNmYxa08xSlVkWC9VdUFxYjhPUkM0UDJ5UG9jK1lj?=
 =?utf-8?B?TXp2T0liZno2b3MrYXhnYUpvRGJnZEtyRmtGVVVGRUcza1VtYnNoZkdlS1Zr?=
 =?utf-8?B?ZzA1aWh2K1VGTzZmU0FFb2ZYdStpWllXZGthcmpXdkgySDZRa3NIMEVuU2cz?=
 =?utf-8?B?TENlcEZLOXRTWXBYbVNNaVFBTWF3U0cyejZvMjFUd2F5MUVPUUl0cElVaVU2?=
 =?utf-8?B?emo2ZmMyVUhiTjRMZDFPMUt6U3pqbjV1UjJMWmhDR05qRm5UVFUzWHRBZFhU?=
 =?utf-8?B?WHpWTlBzS2c2S2cyS0J6Ym8zTWJiMTR2Q2xRVDZxeUxGdEN1MitUVGlXWERM?=
 =?utf-8?B?SllMQ3RnYUZIMWNmYVlyRjVHVEFzWUx0NlZteG9yR0EzRDVwdzMzeEhzVjRG?=
 =?utf-8?B?VUV3ck9YT1UvMUo4Tm1zYjNaTzJPejdqSXUwVXk5ZlB6WXAyOVcyQWVZSmVG?=
 =?utf-8?B?YXF1bXlVbGp0Vkd6WjZjZWlubzA2R2xMRHU4TGRRVXNzZGRqZ0JDMFo4OVJY?=
 =?utf-8?B?VmFPMmtScnNtMG11T21QaDNNY2Y5TmY0NStHbTl0TmJWdVpQbzhiRzFzb0Na?=
 =?utf-8?B?UU1tUndLUDc5WWdNRE5Wc0Q4KzhyZVhoSkUrUTE3Zmk4WHZYQnpOcXFhTWlt?=
 =?utf-8?B?QVJ0WXZEd0xuazBCS1JFZUxLZDJUYzk0YVZWMjlkQzJaSEhYRVV4SGsvWHhj?=
 =?utf-8?B?TUkwcHpjWk4xSzNhSkxRTnZBUmdvS2VTRFhsSEhaRmFUMWtZQlN0Z3R1dDVM?=
 =?utf-8?B?a2MxdHJkUSt4cWwrS1RzU1NVWTNCSXBMNndiOEJWZGVYSDRSTng5ODdGV29X?=
 =?utf-8?B?S0wvRHQxOStPQldwSE1GRzRaSDRsNjZNalhBRStuZThWb2NnZ1h1Y3cxU2dy?=
 =?utf-8?B?TTdhVmlScm0vQkpvRHRpNGswZzJ5YS9UT1pxdmo4V2d0cHMxaE9aTkZzdDR2?=
 =?utf-8?B?QVdOamN5Z0dQa0N5TlNQL0RmSFhUODRoN0duNTNtREFyeE5vY0FlVnpvSjdh?=
 =?utf-8?B?c0ZkNXNOOGp3U29HOUE0TGFEYUU4Q21qS1N1cUJiZGFmL3MwOVRkSjRSOHJy?=
 =?utf-8?B?TTdPNUN5ZUQ5MGRvT0x4T1JHWWdCSDk1aVcySG5zZHV2VC9lb29OLzVYeGJZ?=
 =?utf-8?Q?cV2/ArXvqQrfFjQs0+OQX/1BZObvtQjk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXp2SG9ObGJRbWpaL2UyOUoreEJEOEZyaHJ6RHBZRVluRU5XNWRLRU1ZaHpL?=
 =?utf-8?B?bGJoNm5FT3VQZFU1UDYrdHVWaytKY3ZWSGdqNFJINC9HWTlPMnlyM0F1MnNL?=
 =?utf-8?B?UWlsWU9OSmFhbTRCRTRpUyt4S0pSZDdxQXNPanllWkZUL1ZINi83NkJuNEhX?=
 =?utf-8?B?WWJvaG5SSjVEbjNnbFUzQmNKRjYrYnM2clhXM0x3NzYxeDZSMXRoV1ZaV003?=
 =?utf-8?B?bmNmZnowRlk5S2Jkbkk3eEd0bmRNK3BkTnU1UjdETGJxSFNEbGJjR1dtdXZ3?=
 =?utf-8?B?cEJzZGdzd253MzZRaUhnbnVDdGRjZ2RLcXBFdkpqRmZtcXF3S2JZWUFTWTRG?=
 =?utf-8?B?aEl4SmVVMmxUbWErbjVtRnRJTzdvemZnTGN3TU1QWDZFa2FyZ1dPVkN6Tjg0?=
 =?utf-8?B?VHNEWXJUaXY3amFJR1hvMzlsVWF2cFlUa2NrUTEvMUM2NlQreS96K3IxWGNo?=
 =?utf-8?B?WTVsWStNenZ0cktDVjNxRHphN3VaUWduY2VoM3RKZ0kweDNua21kMGlnSFUx?=
 =?utf-8?B?U0VFdXRPTTl2QVNCMEVRTWMwYm5uNC93bll4M3RzQXZLOTUzZFlzbDNPZTZT?=
 =?utf-8?B?eTRIQWNvVnIyQTNZQlRIVmVMV2xzNkpDRmtnSlUzckNmWHlPMG9weUMrcHFF?=
 =?utf-8?B?UkR4aVNyNy9TclZ6bGxMS3F6K3lmQVJvY1ZJR0VwdVhZRjRFMWR3dnpNaTk4?=
 =?utf-8?B?VXc0RWd5Q2xtYlNWbXRjL1Nka01NOFJGbzFHUk1tYVBOR3p4czgzWDVuaE9j?=
 =?utf-8?B?ZmZDcHNndEhUbkZ1eXNvc2pQRG9kQ3J0WUpOT0NSOXpSTThXM3lpcURGU3No?=
 =?utf-8?B?aTRUM3dHK0FrMmFNV3ltU1R5MUZ4ZVNqRzVDYWFERTdxdWxFaEEzd1BqUnE0?=
 =?utf-8?B?TDJuZ2FYUzJFdDdBWGtCY09jbHFPeWx3RUMxdHIwVUhYaUR1TnljMUxJYlRo?=
 =?utf-8?B?M3dkS20yRWdEZVJUUmd0TGtHaUVFaXlrYjZmRVpGOFRXTUxta3VESldkT0pT?=
 =?utf-8?B?cm1YMGliMTByR1laNFBDb0dQMEhwblpSOUVmd2tXRUhOTkVvL3pvYUJRUnNa?=
 =?utf-8?B?WitUZWJGNGpMcEJjSlh5V0ZZVE1ud3RubEZ4WXhKaUtnUUpvS3dJMUZqQ0dz?=
 =?utf-8?B?ays0UXJhcVVIZVFaZ2VmeXJaWTNENkx0YXJQMHcwUWxiWktTdThvZjN5MHow?=
 =?utf-8?B?S1kvWTdBTnRaT3VwVGR6TC9DSlBwek9WSFhST0ZONUp5R1dUTGtYZ3NRKzlL?=
 =?utf-8?B?WXFxdkVQTHV2NWRVOVJyQkNWR1R5YTBZTTlXbURnZFJuM0t6RUNRSExxYmJ0?=
 =?utf-8?B?bk1vUjN1U0g5bVVMUGZmV3ZTRGFLNVlsakdmREZFM3lydisreEhEdHU1T1Nn?=
 =?utf-8?B?MzR4bDZkRGZFYXMxOCtaWFF6YUcweFV4TWx4ZElnVVRFNEx6TG92RTV4K2FS?=
 =?utf-8?B?eGVOclNLdE5XUFR6RG5zWU9rSEVwalNpRERwN0tHYWZXd0tvWW5teG9SZ0Q0?=
 =?utf-8?B?bmhZTEFTdnNGWms2ODNkSmRZdFNpZjVBTlZXRnluZFlvdWZ1S25zczhONWpO?=
 =?utf-8?B?R2V0KzBCYVBtejZuVzFpRmVlc05Pbkhqc3hWdkFTOExwVytLWXVkcThqc1Ez?=
 =?utf-8?B?QmlSS3Vta2ozckZyMnE5aUZ0Q0E2YkJORWoyOUNZdENEVmRIZitZUUFVUlRJ?=
 =?utf-8?B?UnA4bURyWUNJMUI1RTc2NWw1VW5XY28zT2tFQmFyOVhIQ0dTcG1RM0M1OXdC?=
 =?utf-8?B?ZkNTRWZtYXdzRGRwaG5JTWhqaXB3YWxLYWszeWw1TnFQVmhicXN5RkRvT1hV?=
 =?utf-8?B?MEdmblBweGViZmF3c0pieElreUh2ek9TQ2NPcEdDYmZDKzNTdmtiMFl0UUxr?=
 =?utf-8?B?VUNSQmxmVDI5QXJwVVU3WGV4cG5JQ3Vaa3hSbDU1ZlgzVjd2dHFWYmtZQUp2?=
 =?utf-8?B?aTFDaURiUnV4OGZJT3NrOXlNUXFVdS9nd1Z4djV6OEhmTzhFa0Z0YUFSSFg5?=
 =?utf-8?B?RzI5anFOV2gxVzVKVURZZzBpb25tN1ZZaEc3anlmTlpnVG1CQUlTM2V2VVlF?=
 =?utf-8?B?ME5nQ1VUK1M3dTFKUk5OdDZmcENtM1BmWTdDWXhsL2NKUE5uTXpGczh3K3pm?=
 =?utf-8?B?NkJhM0JoV2lKb1Q3U3JseGJpcGpXWmt6NVh3YW9IWjF6Yk4xWHd1aUhXRjdY?=
 =?utf-8?B?R1lrUmFnK05WQWI0TDNka2loMFVOZnkxWmFiZmdjTE1EaXk0Y0dxa2wxTEVx?=
 =?utf-8?B?V2ZUQkhCL2lLczU5QzZ1SStNQW15RjBSdlE3bGFYNElOV3IxNWlMY0V6U2p3?=
 =?utf-8?B?YjVoZnFYYXIyczM1TEEzZlRkK0lUanNaRnhuQ1Y2ZG93N2hqNDR3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97488b30-0e0e-4458-0161-08de4dd0599d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:37:18.7895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDHbTt7WrxDXfZ0gqa8M2wjrShNpP9GXw/0z+LitWb8MWWXNnL27Darnc38T1MUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> Removing the output parameter from a few functions should result in more
> readable code and also enables us to save some lines.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Looks good but probably needs to be rebased on changes in previous commits in this series, so I'm skipping that one for now.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 82 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 17 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 54 +++++++-------
>  3 files changed, 72 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 59def86cdc04..2c907f9e8258 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -58,9 +58,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>  	return (int)a->priority - (int)b->priority;
>  }
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> -			  struct drm_amdgpu_bo_list_entry *info,
> -			  size_t num_entries, struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info, size_t num_entries)
>  {
>  	unsigned last_entry = 0, first_userptr = num_entries;
>  	struct amdgpu_bo_list_entry *array;
> @@ -71,7 +71,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
>  	if (!list)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	kref_init(&list->refcount);
>  
> @@ -126,8 +126,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>  
> -	*result = list;
> -	return 0;
> +	return list;
>  
>  error_free:
>  	for (i = 0; i < last_entry; ++i)
> @@ -135,12 +134,11 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  	for (i = first_userptr; i < num_entries; ++i)
>  		amdgpu_bo_unref(&array[i].bo);
>  	kvfree(list);
> -	return r;
> +	return ERR_PTR(r);
>  
>  }
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id)
>  {
>  	struct amdgpu_bo_list *list;
>  
> @@ -148,11 +146,11 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  	list = xa_load(&fpriv->bo_list_handles, id);
>  	if (list)
>  		kref_get(&list->refcount);
> +	else
> +		list = ERR_PTR(-ENOENT);
>  	xa_unlock(&fpriv->bo_list_handles);
>  
> -	*result = list;
> -
> -	return list ? 0 : -ENOENT;
> +	return list;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
> @@ -160,8 +158,8 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  	kref_put(&list->refcount, amdgpu_bo_list_free);
>  }
>  
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param)
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in)
>  {
>  	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
>  	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
> @@ -172,26 +170,23 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  	/* copy the handle array from userspace to a kernel buffer */
>  	if (likely(info_size == bo_info_size)) {
>  		info = vmemdup_array_user(uptr, bo_number, info_size);
> -		if (IS_ERR(info))
> -			return PTR_ERR(info);
>  	} else {
>  		const uint32_t bytes = min(bo_info_size, info_size);
>  		unsigned i;
>  
>  		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
>  		if (!info)
> -			return -ENOMEM;
> +			return ERR_PTR(-ENOMEM);
>  
>  		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>  			if (copy_from_user(&info[i], uptr, bytes)) {
>  				kvfree(info);
> -				return -EFAULT;
> +				return ERR_PTR(-EFAULT);
>  			}
>  		}
>  	}
>  
> -	*info_param = info;
> -	return 0;
> +	return info;
>  }
>  
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
> @@ -199,27 +194,24 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  {
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct drm_amdgpu_bo_list_entry *info = NULL;
>  	struct amdgpu_bo_list *list, *prev, *curr;
>  	union drm_amdgpu_bo_list *args = data;
>  	uint32_t handle = args->in.list_handle;
> +	struct drm_amdgpu_bo_list_entry *info;
>  	int r;
>  
> -	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> -	if (r)
> -		return r;
> -
>  	switch (args->in.operation) {
>  	case AMDGPU_BO_LIST_OP_CREATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> -		if (r)
> -			goto error_free;
> +	case AMDGPU_BO_LIST_OP_UPDATE:
> +		info = amdgpu_bo_create_list_entry_array(&args->in);
> +		if (IS_ERR(info))
> +			return PTR_ERR(info);
>  
> -		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> -			     xa_limit_32b, GFP_KERNEL);
> -		if (r)
> -			goto error_put_list;
> +		list = amdgpu_bo_list_create(adev, filp, info,
> +					     args->in.bo_number);
> +		kvfree(info);
> +		if (IS_ERR(list))
> +			return PTR_ERR(list);
>  
>  		break;
>  
> @@ -231,12 +223,20 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  
>  		break;
>  
> -	case AMDGPU_BO_LIST_OP_UPDATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	switch (args->in.operation) {
> +	case AMDGPU_BO_LIST_OP_CREATE:
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
>  		if (r)
> -			goto error_free;
> +			goto error_put_list;
>  
> +		break;
> +
> +	case AMDGPU_BO_LIST_OP_UPDATE:
>  		curr = xa_load(&fpriv->bo_list_handles, handle);
>  		if (!curr) {
>  			r = -ENOENT;
> @@ -256,21 +256,17 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_list_put(curr);
>  		break;
>  
> +	case AMDGPU_BO_LIST_OP_DESTROY:
>  	default:
> -		r = -EINVAL;
> -		goto error_free;
> +		/* Handled above. */
>  	}
>  
>  	memset(args, 0, sizeof(*args));
>  	args->out.list_handle = handle;
> -	kvfree(info);
>  
>  	return 0;
>  
>  error_put_list:
>  	amdgpu_bo_list_put(list);
> -
> -error_free:
> -	kvfree(info);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index cf127bc66f53..bde912150824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -53,17 +53,16 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result);
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param);
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in);
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev,
> -				 struct drm_file *filp,
> -				 struct drm_amdgpu_bo_list_entry *info,
> -				 size_t num_entries,
> -				 struct amdgpu_bo_list **list);
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev,
> +		      struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info,
> +		      size_t num_entries);
>  
>  #define amdgpu_bo_list_for_each_entry(e, list) \
>  	for (e = list->entries; \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index bc9cee3fdf27..69d0cf67d150 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -152,24 +152,19 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
>  				   struct drm_amdgpu_bo_list_in *data)
>  {
>  	struct drm_amdgpu_bo_list_entry *info;
> -	int r;
> +	struct amdgpu_bo_list *list;
>  
> -	r = amdgpu_bo_create_list_entry_array(data, &info);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number,
> -				  &p->bo_list);
> -	if (r)
> -		goto error_free;
> +	info = amdgpu_bo_create_list_entry_array(data);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
>  
> +	list = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number);
>  	kvfree(info);
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +
> +	p->bo_list = list;
>  	return 0;
> -
> -error_free:
> -	kvfree(info);
> -
> -	return r;
>  }
>  
>  /* Copy the data from userspace and go over it the first time */
> @@ -857,6 +852,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  {
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>  	struct ttm_operation_ctx ctx = { true, false };
> +	struct amdgpu_bo_list *list = NULL;
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct drm_gem_object *obj;
> @@ -869,23 +865,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (p->bo_list)
>  			return -EINVAL;
>  
> -		r = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle,
> -				       &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
>  	} else if (!p->bo_list) {
>  		/* Create a empty bo_list when no handle is provided */
> -		r = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0,
> -					  &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0);
>  	}
>  
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +	else if (list)
> +		p->bo_list = list;
> +	else
> +		list = p->bo_list;
> +
>  	/* Get userptr backing pages. If pages are updated after registered
>  	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
>  	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
>  	 */
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> @@ -913,7 +910,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (unlikely(r))
>  			goto out_free_user_pages;
>  
> -		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> +		amdgpu_bo_list_for_each_entry(e, list) {
>  			/* One fence for TTM and one for each CS job */
>  			r = drm_exec_prepare_obj(&p->exec, &e->bo->tbo.base,
>  						 1 + p->gang_size);
> @@ -933,7 +930,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		}
>  	}
>  
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		struct mm_struct *usermm;
>  
>  		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
> @@ -986,13 +983,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  				     p->bytes_moved_vis);
>  
>  	for (i = 0; i < p->gang_size; ++i)
> -		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> -					 p->bo_list->gws_obj,
> -					 p->bo_list->oa_obj);
> +		amdgpu_job_set_resources(p->jobs[i], list->gds_obj,
> +					 list->gws_obj, list->oa_obj);
>  	return 0;
>  
>  out_free_user_pages:
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}

