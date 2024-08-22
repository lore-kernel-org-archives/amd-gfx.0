Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CA3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 19:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D2810EBD4;
	Thu, 22 Aug 2024 19:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWEM1seV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C1610EBD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 19:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQRebiCGkouf0JZ9A5/Ji7J5Uo/BFd179uPvkruVapNlGJ1VlgQfIYEDkS+f/x1tzZYwF1PvHsi+nJEnnebdOEvbHiz4jHtbT+016Hpet/r56G8aGNAMg255G+0sqMJFEQvvcQuC4c53gR7SUN0glWG/8k8/5KVU4RFrRYW7nGcqMA8zIQrSdBYGHCshJIY0yqgi+jEXt7eU64punNY34IMNys4Im+C+2Iyu+8tU3PhdGD2cOU1147t3AywQWIOo7ef/CzHFAsfXSTeIz+7dEu8E0Vj6vxXqzj+vRZZp35G7BLaLuC4/h07ab9/A2L7vY8QAqR6X9by6MuhsYmPi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2bFbt5ZgOj9ctyCL8/AJjS7mGm6wV9WLiAYUkujkgo=;
 b=J9eouP8UxvbJEBGHozjcpGQNNnwb9i4wcAL+8XJ0Ygv9jvJ7QRC14tX1nBclTSyg/QC4PRxnKv0jex/ADBu6M4eIJI5+3vhC6QftqgAUm5p+FmRmIGXTNXW1QpZt2JXc1Xh0chS5COXrwsfmiWSss08wk+v//IaeAHmfeAjfeQbIbBhLfKiGy5FCq/NFEBKKoO/Pi7c7gjKckNH55mslzbVOa7kavjvC79SoAsyxVijhVEvaNkebiJce0Ybuj2KEPYk7rO5Ccdz+PHkHHvaUEgXX7n4JsF5sYFGq16HE51X5c1PR2icYEeTuk/sS3z+bzSMK10g7t+JqUeMha/2QeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2bFbt5ZgOj9ctyCL8/AJjS7mGm6wV9WLiAYUkujkgo=;
 b=oWEM1seVN52NhxacjAgep4Y8e8iiAojWtt55aW+OWRVaWZDIU/nRwk+pKcsgc8YGLLs55fYx4UKvkN8zkSb2XhOYWe9AWHfFTaxJaGwjgb7efbXcqMgsu53Q23yrh7g6w51qZjIHXTNLm/OqlIg3y5w8MVFkC7j0Me6Tq2Uz0ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 19:00:03 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 19:00:03 +0000
Message-ID: <430e16fc-6618-445c-84c2-8b85bd5eeb64@amd.com>
Date: Thu, 22 Aug 2024 15:00:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] faster vblank disable
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240822161856.174600-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240822161856.174600-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 209c266b-1d18-4ce1-846a-08dcc2dca122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2VualllTWpyZjJpOWZONG9IN1k1Rm15STd4YmF5OFgrRDV6Tm1YLzVQdWZO?=
 =?utf-8?B?SnNvdEVzVU9DeWh5aUp6YzJhcUZ5bXA3eUx6SDdIZUVCaUI2cWlIT2FqZVpR?=
 =?utf-8?B?VmNCWlhieTJkcThXSVU0ck5MVnBwZTdiV1N2cUxSOVBWTGVhRS9ua3dncjQ4?=
 =?utf-8?B?TGJOU3FZZDM4ZkYvelhCcnEyNXlPc3g3U1Z4eEZ0UFpJanZ0dmU4WkxxOTAy?=
 =?utf-8?B?UHkzbElJUTh2Z2ZBeExBR0dyUitoS1IzYkpMT2JzYWVFQmZBTlpRWTI0dzNE?=
 =?utf-8?B?cEYxMTlyaE9NOFBJVzVvVENCUU4xOTYyNExNbGpidlBKMGFvU29jUVRVYXpR?=
 =?utf-8?B?ajFDMGt0eFlaV0NJZ2lkV21VdDZaQWFzUWc1ZjJ3TUJjRE5yMVRzNExKRUZ6?=
 =?utf-8?B?bFNxYXBJbFh5dHZ6ckRoRXVYN2ljbkRsQmdudFc0aW5NNjgyS3loeUc2bkc3?=
 =?utf-8?B?UWd2dUtua3hpSDVDbXNrSjVacTRkUU1OOUNJQVJiWWtvN3ZOTmlPSlpkWi9B?=
 =?utf-8?B?UlhzbE1vSHVwVnR0ZDNMTDJ3ZGM4Z3AvQURQcjR4Z1J5cS9jM0RmY1RrVlQ2?=
 =?utf-8?B?dXhMSThNbEx6YzFDYWtuRkxIVExaMmNBVGVvaU01UkdwTmxjSWo1OHZaaWVl?=
 =?utf-8?B?N2FjZ2FSb3owaTBCSXQ5T3QrZ2RPT0sxc1NrTk1FNUUrKzhXOWdwVXh2ck05?=
 =?utf-8?B?RW1jcUNKRmFacUkvMWhGUTF1ODk1SVVtN08wakRveUo1T1dqdW1yb2JIUnk1?=
 =?utf-8?B?M0tzM0k5Vm90aTJTVVZSSFNMZFFmbTAyOW16ZDJGTHd3MDFOVURyVUlsaWpw?=
 =?utf-8?B?SEZCNU5OV2ZWQUljUDYwNXdSVTZVZThEU1VwRGc3VjZVZC9GM3A1VGNkRC80?=
 =?utf-8?B?a2V3TG1QMUpxL0pqeEVOWCtyNWx6cHN4S2ZrK2lqYmtaWjNQakRyeGg2VWw1?=
 =?utf-8?B?QklEakh5TVR3dnQ2Z3JGZ3g2QXZJQTBXNHNZdVlxbmM4K3BPT1lrY1NzZ1VG?=
 =?utf-8?B?Q1l3SFJSaDJMUjVVK0x2TEsxZ21nTVZ1TVM3N1ZUWXJNdERHMlNNa2pXTVpN?=
 =?utf-8?B?aWZPWTRPL2ROL1QvWmRseVVoTzJBU2huWE5oZTJ6WFg2anE0c3JrRVIzMGZH?=
 =?utf-8?B?WCtqNzN5VndCWGkrT0c1WkFNZDFQQVhkNkN0aE5sRElVd3F1U3VmdisvQU1X?=
 =?utf-8?B?Mkp3WGZiUVBranE5VzE0Q3BMc2picGVFZzdpRzY0b3gwQVNvbThGRkFTUGU4?=
 =?utf-8?B?Ung3UUJTc3NjemNCZW5PWTVPUDNnNGdjOEQ2NUlheFB6aUtVbjVCOTRtc2s0?=
 =?utf-8?B?K3FNbHAzYXRMckx5QzN1Vjh5NnV3S1NnMTVvWVRFdlNrazNNTUdNWlQ2cVo1?=
 =?utf-8?B?SXVYTkg3azBwRC9zK1B2VmQ5aVVwKzliVmtnZkJaRW9RanliWnp1K0VsVkZQ?=
 =?utf-8?B?TWM2UjZmZFhibmlIOHRodnJjRW5zOURkVGJoOVRHOVdLOGoxZzFveVVnd0U2?=
 =?utf-8?B?UTBTTWtSU3lPK3hnKzVqOGwrL09JUFVBTnJUemdVM3FiQUNuclgwSC9GeHNL?=
 =?utf-8?B?c0ZiL1dxTnhjMTFjbkMzaXhSNGhnSzZvYlhBdW1obTRuS3BYbVFMdmJldnVa?=
 =?utf-8?B?bGpPcHhKTEhGclR2ZmFGb0RlaTZVTVlhSWdqS29yUkhRdkt0dTJBb1krMTZE?=
 =?utf-8?B?cGNLVDZIS0IrU0k1Yk9JV0pUdlJKSk1sTVoxcEZjSCt1MGs3ZTJETGVSUFlX?=
 =?utf-8?B?UHNub2hmWTdLbFhLcU5ISENKUmYxWTFaY1BON0RUaDR6Y2ltT3duSmxsaVYv?=
 =?utf-8?B?VG9maEMvWDJIUERMZ2E1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHB3WDFsSjgvSFdGZkZXTC9OSGNrQ3lFbXd4aXkzMWdnd2NWWWhLUlF2cFhh?=
 =?utf-8?B?TDBJTWdoaHlDME1ITVJ3L1RWMk9nODhzZ21QSlJPZVB3eERoQTBwTjh1anZG?=
 =?utf-8?B?REJ1dXUyUCs1aWloVU5PeWFFQjdteDBMcm1GaXppenJoc3RWdUdacFpMbDZa?=
 =?utf-8?B?UXNaRndoMkErcHlCb1JVSjAyRlVhSEVxbE1QR3hwRk1QdE95NTNHRisySnVn?=
 =?utf-8?B?bXhmM2JhcllCQnZyVjFibDBGN1V0elYxUndaWU9WRVNISkVOaUMrTmhzRFZB?=
 =?utf-8?B?bTNhalV2SW1HcUlJQmtkNldseGVOY1FHRXRMMlg0ZlMvdmlDREY3a281OEFm?=
 =?utf-8?B?eDJWTVArNGdxU2FSamcvSm5jUWtDWE1SRFBlSjdvbER0Nkg2a2p4SWRwVUdr?=
 =?utf-8?B?RGkvdUk2Lzdmak5zdEFncVNuY290L0ZKQlNqQW1wTFZwNERQYlVJamZxOEc5?=
 =?utf-8?B?VWE5N1BybDM2ZjBENW50RlpXZnRsZkc4SGFFbEcva3FvcnhYRk81VVVuWGpG?=
 =?utf-8?B?N1JNVHRvbnZhZHNEU0tsY00zY01NQjNNd0ZQdWZzdUhHcDBobkd4M1ZZdHJk?=
 =?utf-8?B?VUVXYlZjMndwKzI2T3NSZk9Gb2hsOE9LMjBKcnpYdzMybVBUY0tRUDFmdnpF?=
 =?utf-8?B?OGFDV0lXQTdxUjAxK1cwcC8wbDJzTUNGOEJIWkE1NlhnRjNza1Ryd3pSdmJP?=
 =?utf-8?B?QUlNeURqSWhWSmorUnlWWVlBY084NTFKaUtLVFFGaTNxZi9PeWJPaFdCR2hF?=
 =?utf-8?B?K28vQURQNXUwSDMvVDNjQWVEM0FqMXdWRjhqb1NabkgwVlExWldJTDVsME1t?=
 =?utf-8?B?azV0K2lKMk01ak56cTgzVHoyL0cvOTBZU3JqQktRQUFJQ01Ra2xkYTJ2WitE?=
 =?utf-8?B?SFdTcGZ2ZWNQNWtpTDBFTS9NZzFiUjBuMmhUaXFiUm9OeVRCVkFKWGlkZWhv?=
 =?utf-8?B?TXdTbmxTS1F3N3BKQy9vbVNXbFdCdzJnM1hsQ3I1NVBrbXF1cVBTcURaVlQ4?=
 =?utf-8?B?WC85a0ZVbGROWExRK21OdVE5WjBxdy9OUVRoY3dSRWNKTUpMWFRtdGZDMUh2?=
 =?utf-8?B?WGxpQ2Rpc0EwbysrbHJQZmV0MHpwT0hEKzRCRUxwTXg4QzhQdFJhUlhXczlN?=
 =?utf-8?B?b01WbWU2bDJoakZYN0l4VkE3Vi9ISUlyZ3ppd1NlUExFTGVaUDFIVzYrUTJ6?=
 =?utf-8?B?RitNdTQ3N095V0ZWcHkyWGNlSk5qUDV2dEU0dW5sMFhBK2Q0OUNXa3QzVWdN?=
 =?utf-8?B?Y0ZseGdEbHVRM0hmaUZOeUpIaWt1T2VNd0hqR3RSN1hNRU9ha3BRd0xWZ0hu?=
 =?utf-8?B?WSswNXp6dU5XcnpyZFJUem52eXM2Wlg3UGJCYU5ZblZqSFpud0RuY2FrZCtM?=
 =?utf-8?B?QnZDRnJ5bWhyc1VEaTVCNDBYQTNtWnJjd2pDUE5zVWJJNnV6RDFoT2hSNXgr?=
 =?utf-8?B?eTA4MmRCNFQrd3NiOXZ5YzRDOTJwMEpucitzMHZSb2E5WHcrb2hHODY0Wk9r?=
 =?utf-8?B?QnlKUUFoaFpXcUh4NFNMOXhKK01iZjd4OU5aeWc3cnlLT1BNUlFOUHZpRzVn?=
 =?utf-8?B?eGRwY0FoWWdRdlNYZ25KRFpCQTVLWXJ3SmtzdTYyZWVZZUozWTBLZXJZenBP?=
 =?utf-8?B?SmJFUUM4cmp1aTZYbHF6MG84YmczWGpvUHpUVnYwSzZVVHBDcGZXV3Z2VFFH?=
 =?utf-8?B?NDlpL3BOQlZBTk1ONmlTR0JVbXZkdHFoc1gvNFBiU21JUllqVXI2TW1CWnhG?=
 =?utf-8?B?OHBQK05TbWRJdHZPRzcreE0yWFQxTzdoQnRuUU5CbC9ZS3dqb3VoZVlqRGR3?=
 =?utf-8?B?RVcrbCtPKzAvNUEzSGFpWmJHeDI2eUMyNFR3Y1VvRUp3L0Q4YWhoVkxiZVBI?=
 =?utf-8?B?cEozMU9nTUFVNU1VcExOZStNQWd1ZlpkVk95RkRNTFZ3U0pQN1BTNWNXUnRH?=
 =?utf-8?B?MmxUSnNST3VyeGhVRUVHZDYvUTlGOEo0UjhPUDQwenJMaVMzcmJrNWtkbTU0?=
 =?utf-8?B?d2tvQmZjL1RQU2kvLzhrN2Y3VjFrbUgrV05CWXd5bUV5Mk9VaktkTHAyMzJh?=
 =?utf-8?B?T0VMKzhpeDR4Mkk1SStYYzhXRzRZWHM2b3dJOGhkQTNaejdDekFpU011SkZr?=
 =?utf-8?Q?AcDaqDB6N5PXxrU+rj7+G7TFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209c266b-1d18-4ce1-846a-08dcc2dca122
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:00:03.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSHmnDIe44i4ia1eNEtkd8zLLePUPBJEjId7JkDgkDjg3153YSaxMvoblEg2n/ebSlYxiHsubcr8lVCp0dKC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361
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

On 2024-08-22 11:58, Hamza Mahfooz wrote:
> Since, drm_crtc_vblank_on_config() was recently introduced, we want to
> apply laxer vblanking policies across the board, since:
> 
> 1. It will allow us to shut down interrupts faster for better power
>    savings.
> 
> 2. As a payment towards tech debt, since drm_vblank_offdelay (which
>    defaults to 5s) isn't necessary on AMD hardware.
> 
> Also, patches 2-3 in this series provide even laxer policies and they
> are intentionally separated from patch #1. This way, if issues with them
> are encountered in the wild, it should be easy to bisect the issue to
> those patches.
> 

With an updated description for patch 1 that calls out the new
behavior this series is
Reivewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> Hamza Mahfooz (3):
>   drm/amd/display: use drm_crtc_vblank_on_config()
>   drm/amd/display: use a more lax vblank enable policy for DCN35+
>   drm/amd/display: use a more lax vblank enable policy for older ASICs
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 +++++++++++++------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 

