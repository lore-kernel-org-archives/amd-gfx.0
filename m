Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96985C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 18:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483B810E08B;
	Fri, 23 Aug 2024 18:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/qNU/Hg";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6557610E08B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 18:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLsjmWgXODs267/0a7sRnU+WcDVDVjGae82ycHV9GNo7OuyYAiLbpJE0KJgCblfgZREcUdh2wkyy6GzTuvu07un7JQ+lJDWCfRTbqJfgcjknEYtP0WiPQzDQI65chef3BiUHPEXkKiLU6zanOXo5lqOs2VcGYSe0UapjNDP+Ej1LVIWEFpVzNQ3IJg6hSFsWZoz9tLj0aRRQ7Wzi9V55hUHlvRjlqQ+UXvXZQPGNujNr/KZsfv7i1okVqX892/kPGLxsWXqM3Wi6QZdmrfZBpj/0Du5eu9A824FBogjyzPNcZ1avDMWHwsHIpbqJGHFwImIClB7bj9/99nx0aAnERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwX8RrqS+Qld4W3LtJ4+k2IAtrt8DdEI9HeTkCRBicA=;
 b=qqmPWPBT0sNlgpH+RMfP33kXWznMuSTlFOXdp98CdivEG6O/ca6C9NviHnuub4uOQzAnPL/UbCWltU4pcPMbUjBRSUXeaSVzl7oaimuTVyPhTVm1XUCEpheqo6pjsHVN9XInvvc1M+Iig3hidhRMmJuhjpT4VZZK8PJfERcY2EN9bymO/BRvRZ5+n+cI+3w5IPSiTqMbXXdNPXgx09YPQKyVgF96wJRggB+gebX0Lgj6YP5iSUB4EdiqSZ0/ttYWXADGrWbd6W8Y3jyMj+kNRXJNkeZq2PtmvdVhnExibBrefjwftAxLHzJdT8FfgG5AMFt0cjFZsj1Nteu2zl744w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwX8RrqS+Qld4W3LtJ4+k2IAtrt8DdEI9HeTkCRBicA=;
 b=J/qNU/HgBCPzRUar9GwyvPVBixE4lOeF9a63VHpK1Nbs+MRRyGMCxhC0iod1YZA+yHu9kaw2+PGMFG2IrWUCGaBx5/BfN3DsDxLSexaKosPta6a8FVNJkDfg+IBL54hOEJm7namViF7y/jrjZpQ+tZfr5zA5php4IAxcWQ8OTGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 18:24:53 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 18:24:53 +0000
Message-ID: <e32bd155-1dd4-4e71-9279-d50c4452ab57@amd.com>
Date: Fri, 23 Aug 2024 14:24:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amd: Introduce additional IPS debug flags
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, chiahsuan.chung@amd.com, hamza.mahfooz@amd.com,
 roman.li@amd.com, rodrigo.siqueira@amd.com
References: <20240819192217.18799-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240819192217.18799-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::29) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bc1d65-fa3f-4ab6-2ece-08dcc3a0e18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUVvUDlnT1VXS3p5S1VrZndHK2JpdTZ1SWx4ZkZ1R1F0S1NFUHExdVdLdktw?=
 =?utf-8?B?azcyZGp3ZEZoWkJ6ZE55aWtIUDFRZjVjeHl5djJacnJMS3B6M0tzai9ubHNk?=
 =?utf-8?B?elpBWVR2MFhFTzZmanliOEN0dXVBbjJRUUZ0cHlFQ0Q4K2FTSUxSRzA1MklZ?=
 =?utf-8?B?UXlGMTZBVzRVbFZwMUExb1JCS0ZYTTFrQVZkRDNOL0VueG5OZEZPemYvMXI4?=
 =?utf-8?B?cllVL24yeVg0dUhMYU90OFNBZTg0V0FXL3M1VEtqVEJLZ2FXeG9rM1FVY3pD?=
 =?utf-8?B?bnNPZGdVV0JRUkhRdjl3dnl0MnNXdHhZNWp4RFlTMWlteFlGaGNaUjRXSEJn?=
 =?utf-8?B?Um00eXdYbjIzNWNDN3NiUmk3S2xTVmtHTmNkcG9RanhnRnRta3R3d1d0Y2JL?=
 =?utf-8?B?d0oxblNSNmF3ZHpjRm9CNCt4VWNZS3JZZTd2aGo0d1U5TlhoL3RRUU51VXBa?=
 =?utf-8?B?dEs2YXpmSktzZU5XY1pLWFZmUDEvSUNUUTlMdVpDT05NNzVBdjhBS2F6U3Fh?=
 =?utf-8?B?SmpSNi9yakFJcmxTSGRJNndhWEZsZCs4dnZrRUhLby9WV3lrdElxeDJCSklr?=
 =?utf-8?B?M2prNi9BazhYazRQZlNncjhLQVh4d3JMYnA0S2JhVDR6eGhleitxdjlnTjJa?=
 =?utf-8?B?TjVJakVOb3JzeFNGMHdqS1ZTeVNhVlM2NU40M25ENDM0WTBod3pESnFLWndi?=
 =?utf-8?B?bm54L1M5WnFZZFR6cm1CaGJzVGxVVEtVNWdJbEVEazZjMUQyUXJxYmZBZ3N4?=
 =?utf-8?B?TFhsRTRUeEg4eVNoOWFuYTl5VFpLTlJxVW8wczl3MWg0bjJKTCsrT28zWlhP?=
 =?utf-8?B?TEt6TTdDV09OOTY4SGR6VHdJWFZ3Qm12M1NDdERIZ3AyWGovNFJ6NlNBMnN2?=
 =?utf-8?B?THRLT1lhQ01iOVlPUTdZWmw0cmdvbm9MWHZTNjg1TTJhaVpPbEhzWG9ZRDZX?=
 =?utf-8?B?cTRwSXVRQ2NYUisxUlRuVkJZYWFNbEczcGdmRWZVTFFmclBPcFlveEExZis4?=
 =?utf-8?B?Mkd6U0p5L25ydUV6YXFscW9XWVIyVjFUUk5wSCt2cHhrRVFwR0V2RlpsaUZK?=
 =?utf-8?B?RGpTTGJKRk1BRGhPd2g0MjlJRXJBZzJvRFhWcXF6T2NweDU5MmRuMFRmUG13?=
 =?utf-8?B?VUg3QVZHc0FrZ1NmTytlMXQrRVNmNFRnbkhkTUxsTUFpQTEzaWRWQjcxUVhE?=
 =?utf-8?B?S3FqRXRjeDhnZkJUU2ZFdnRlQjExWG1iSmZWaHh4UjNrOEFSS2VBQk1OV1B3?=
 =?utf-8?B?T2xOVi9sMTg0UW10TmVaS3VrcmNRZXd3dGlxMlpFMzg2eXBwVW1ScDFGaS9x?=
 =?utf-8?B?M3IzNlNWSHl5TDlnYUVTYTh2czhwbDdmcHhVdDBhUjNQbGNmbHlsTXNTNElJ?=
 =?utf-8?B?VGkxaFcyUTRSa3k0RmREcVdiMFJBZ0E3UFdrbWxkWkpiQnV5MTFFRXpscHdi?=
 =?utf-8?B?YlpZMml4V3dFWFRubjR4cmVBcGtablA5bmFjc0pkN0dQbkxhOWl0NHJxdk1B?=
 =?utf-8?B?emhiL2xCbC9MQlNyc252cTZ3eXRrRllXdm9YMk0renFJYWt1MlA3ZW5USWl3?=
 =?utf-8?B?TmJJemhqKzRPeTJGeWJSeWlsNnJYWDB2UmdWNzdqempxb2Mxd3FzcDFCdFMr?=
 =?utf-8?B?bTErbjMrbHdtRjRHZUpJd01tNEpBbFJmUFczMmxReUx4cUxGL3RDcnZuOGcr?=
 =?utf-8?B?SFVkVityWUp2cENQeGdBc3JSQ3JXZk1uVGFxR3l4K1NGT3p2ZVFGY2I4OEZU?=
 =?utf-8?B?SDZrVm9saWl2WFg0N1c1Sm0rbW4vZHQwcjlxZDYyVXVBbk5WTnlHZG1SV1BT?=
 =?utf-8?B?amkxQ04wb05sZzJQL0hFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhFT0dwVUMrcWo1MTF3SU44YWRaTDFEVFVYQnN1OXJweFE3K29TZkh2czll?=
 =?utf-8?B?eFY5RlYzeUJmNXNCZ2xCZ1JSTVVCaTN2REZMNE1DYkJMd0xGV3k4aUtyRkQr?=
 =?utf-8?B?V1htUGJOeStYTnhqR2NCVTJoOTM0YW5HaG5JOCtsVmh0K1BKc2ZOUjlGQ0gz?=
 =?utf-8?B?eGZNbkJtU1hkTVFiUUp2am9pWlpZbXE0endEMkdrb1pXUnhhbFZaQVhKQ1hN?=
 =?utf-8?B?UTNrbE5HdGJtT1poNDAvbXJER2wwNUtoS1g1YmlwRlVMWkt2NCtTSGtYM3Vy?=
 =?utf-8?B?ZlZTMWg1QW1nWnJSb2FmVW1hdHNhckpyOFpHcnNidlBEL3JXa0ZnZDZlSkZZ?=
 =?utf-8?B?ZzRhMnBoVmh5M29RajdNSVE5VnNSTWRXa3RaSlVIbVJqZ0VuSVlmL0JxZ3hO?=
 =?utf-8?B?VVRoL1Z6a1hDR240TEx6ZXJEazE2NVJoYnpOZXVjaVgxRnUwR2xWTkIrQ1Js?=
 =?utf-8?B?bURMRXZyT3doVGdPVkkxUHdiRkNmK3M4eVRGRGdCVEVrK3lCS2RrOEFFYVY4?=
 =?utf-8?B?eUlUUS9PNHpITUNVcWJaUFNhbk9NU2szd1VBRjZJbi92Qy9USmVzdkZ3QlBs?=
 =?utf-8?B?Z3A1Zk5ieEFQTnU1RHBLaTBkaURDWGhwWG5LUTZ5c1poYXNxSktpanFyWmdp?=
 =?utf-8?B?bGNCV0JMeFVLclg3YldxcnZETFB5TkhhbXlRbGNoNUVQU041bzE2QjNCM3c4?=
 =?utf-8?B?Rmlwak5xV3BsWk1xb04rS3czWFlRUExSbWpPOTkzaTZRNkEva0RnRWUyN2p1?=
 =?utf-8?B?S3hac1hkN29VQ25HWit1MVFMb3RlNmNqMlk0aTQwSUN1cFRIQVlFdXNlKzBT?=
 =?utf-8?B?NFArdVlQNTlPUkx1elMraWZRQTd5TTJPb1BLTW53b0dqak8vQU93bEc0K1pa?=
 =?utf-8?B?RlVqdXVxNlhsYmU3U2s2NWZsdEpWYXY5Mk1WVVRxUkRNZ3FTU2tUSmlIMURR?=
 =?utf-8?B?bjAxK3o0WXJjanJzWjYzWXdGK1cxbjZzSStPMHJwbE5ZKzBxOFM1bTdHVDQ5?=
 =?utf-8?B?Kzc2S3VhMGVZVWN2YVExNU1PSEJUV1VVWitFSEhBdU9ZNnVXQ0t6MWNtQUtR?=
 =?utf-8?B?bk93SGI2bHJzWWJSM3Y3ZTJDSk9JWGN4ZmQwRnNnZC9BUVluUmZOQnhoZWtL?=
 =?utf-8?B?VXg0Y2MyRDhNNjdseGZBc041U0NwYXpUeVE3SWNyRkVrbXRxNUZ6bFdiQ0NG?=
 =?utf-8?B?cC81Yy9wb0RmUUlWUEZ0YlZLRXkwUzNxS1VzcXhjampQUnB6eDVzNnJHZ1Zw?=
 =?utf-8?B?b2V6QlFVQTZOaGNoNFBsYU9pazJ6WjRTMzlZUVR3R0ZzRlFnV3hWT0kveW9q?=
 =?utf-8?B?SzlnZmhpK1FBeU50MmwycTA1VVkyMkRqUS9yNXRRTHp1elhjV1YrQzhJSDdO?=
 =?utf-8?B?RHM4K0pMRHUzT3doU1FhWTk1b1hZZjJtVUphdEhaMzNjSnRIeWRvRlYyOG5p?=
 =?utf-8?B?cW1ncEJxWVNUNGh0cnVTZjRXWVdFR3RYVzBuVmQxeStMeFl1SjYzcjhROTJQ?=
 =?utf-8?B?WUt4TTdvemNsd2JnUS9rT1dhVE9RZjRlSGE0QzVnbTc4aVQyemJ0Rmg1cmg5?=
 =?utf-8?B?RDgvWTBPUVE2TWdSL1FSRmtBUmVTVkFseDZBNWdnN0ZDTTJTRlhJaW1OdnBD?=
 =?utf-8?B?UUMvNExtZzlRWndFUk50SnU2UHV3U25zK2F5aThPak9kWk4zSGVYNzNTelho?=
 =?utf-8?B?TEQxbElNRkRxcEVIRHZuRjRyUTliekpDZSt1N3UwVDZTSnB6bEJ0V2dobDAw?=
 =?utf-8?B?OHFqVWRFRTE2OENiMy9DMnNYVzFkdDNvM2dZUmxGRU1IY1dGY2VBYjRTMmx4?=
 =?utf-8?B?TFF1SlY2anphV3RRN1VOYlRtWVZqMzlUcCs0Zm1SQ3ZBdDVQVkZZU3hSeE9o?=
 =?utf-8?B?TXAzREdRUnBqeFhuWTRUWE02V0VNOVBRbnRYazNwNnRSVzNLMmRvYVErRmhq?=
 =?utf-8?B?Ukt3bUlJSDlheU1KaVY4dzRKem9leGNjdmxXZzczak15b0JndWpvNXNIWVdu?=
 =?utf-8?B?NTA0ZlFZSWZKajA4VWoxMUpGQmM1SmJFWm5oRjBHMm9HQVBhcUxMK2l2eisy?=
 =?utf-8?B?dXJBWGczLzNzQU1wTnFJL2NxNXdyVjN1NzZvV1YvVG1iWnArQitCMTVJRVVR?=
 =?utf-8?Q?FTwtUoEgobdsyC5tNs5pldqrS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bc1d65-fa3f-4ab6-2ece-08dcc3a0e18f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 18:24:52.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1W499/SVL4JBxYtrjjD8zC3c+gWEc9leTNrN73lsFAnNzAyQMfJxjg2KQRt2MBq0pQPXaMsPcmYA2+6Hvm5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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



On 8/19/24 3:22 PM, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Idle power states (IPS) describe levels of power-gating within DCN. DM
> and DC is responsible for ensuring that we are out of IPS before any DCN
> programming happens. Any DCN programming while we're in IPS leads to
> undefined behavior (mostly hangs).
> 
> Because IPS intersects with all display features, the ability to disable
> IPS by default while ironing out the known issues is desired. However,
> disabing it completely will cause important features such as s0ix entry
> to fail.
> 
> Therefore, more granular IPS debug flags are desired.
> 
> [How]
> 
> Extend the dc debug mask bits to include the available list of IPS
> debug flags.
> 
> All the flags should work as documented, with the exception of
> IPS_DISABLE_DYNAMIC. It requires dm changes which will be done in
> later changes.
> 
> v2: enable docs and fix docstring format
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   Documentation/gpu/amdgpu/driver-core.rst      |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++
>   drivers/gpu/drm/amd/include/amd_shared.h      | 75 ++++++++++++++++++-
>   3 files changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 467e6843aef63..32723a925377e 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -179,4 +179,4 @@ IP Blocks
>      :doc: IP Blocks
>   
>   .. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> -   :identifiers: amd_ip_block_type amd_ip_funcs
> +   :identifiers: amd_ip_block_type amd_ip_funcs DC_DEBUG_MASK
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dd8353283bda3..a18ecf8607232 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1864,6 +1864,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
>   		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS_DYNAMIC)
> +		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
> +	else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
> +		init_data.flags.disable_ips = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
> +	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
> +		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>   	else
>   		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
>   
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f5b725f10a7ce..745fd052840dc 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -61,7 +61,7 @@ enum amd_apu_flags {
>   * acquires the list of IP blocks for the GPU in use on initialization.
>   * It can then operate on this list to perform standard driver operations
>   * such as: init, fini, suspend, resume, etc.
> -*
> +*
>   *
>   * IP block implementations are named using the following convention:
>   * <functionality>_v<version> (E.g.: gfx_v6_0).
> @@ -251,19 +251,92 @@ enum DC_FEATURE_MASK {
>   	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
>   };
>   
> +/**
> + * enum DC_DEBUG_MASK - Bits that are useful for debugging the Display Core IP
> + */
>   enum DC_DEBUG_MASK {
> +	/**
> +	 * @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting
> +	 */
>   	DC_DISABLE_PIPE_SPLIT = 0x1,
> +
> +	/**
> +	 * @DC_DISABLE_STUTTER: If set, disable memory stutter mode
> +	 */
>   	DC_DISABLE_STUTTER = 0x2,
> +
> +	/**
> +	 * @DC_DISABLE_DSC: If set, disable display stream compression
> +	 */
>   	DC_DISABLE_DSC = 0x4,
> +
> +	/**
> +	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
> +	 */
>   	DC_DISABLE_CLOCK_GATING = 0x8,
> +
> +	/**
> +	 * @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU
> +	 */
>   	DC_DISABLE_PSR = 0x10,
> +
> +	/**
> +	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
> +	 * if mclk switch in vblank is possible
> +	 */
>   	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
> +
> +	/**
> +	 * @DC_DISABLE_MPO: If set, disable multi-plane offloading
> +	 */
>   	DC_DISABLE_MPO = 0x40,
> +
> +	/**
> +	 * @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA
> +	 */
>   	DC_ENABLE_DPIA_TRACE = 0x80,
> +
> +	/**
> +	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
> +	 * does not default to it.
> +	 */
>   	DC_ENABLE_DML2 = 0x100,
> +
> +	/**
> +	 * @DC_DISABLE_PSR_SU: If set, disable PSR SU
> +	 */
>   	DC_DISABLE_PSR_SU = 0x200,
> +
> +	/**
> +	 * @DC_DISABLE_REPLAY: If set, disable Panel Replay
> +	 */
>   	DC_DISABLE_REPLAY = 0x400,
> +
> +	/**
> +	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
> +	 * If more than one IPS debug bit is set, the lowest bit takes
> +	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
> +	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
> +	 * precedence.
> +	 */
>   	DC_DISABLE_IPS = 0x800,
> +
> +	/**
> +	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
> +	 * *except* when driver goes into suspend.
> +	 */
> +	DC_DISABLE_IPS_DYNAMIC = 0x1000,
> +
> +	/**
> +	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
> +	 * there is an enabled display. Otherwise, enable all IPS.
> +	 */
> +	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
> +
> +	/**
> +	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
> +	 */
> +	DC_FORCE_IPS_ENABLE = 0x4000,
>   };
>   
>   enum amd_dpm_forced_level;
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Thanks & Regards,
Aurabindo Pillai
