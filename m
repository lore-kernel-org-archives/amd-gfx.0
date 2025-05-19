Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F41AC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 05:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8478D10E05B;
	Mon, 19 May 2025 05:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHdGp2zp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271B610E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 05:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1j/htnP8jrRkW6ur/ozIgbkFoQUok+16SV3IP9llvKkMelEay27+co9SHmavmc0J047P8n6btjIxtvaHnl0YgO4Fn/gBxrCqcels6Iqoa4Hm0w1v917ArGnekuJ12HRNrSC3WEULpBplCYKhEqcPrWjqlpuJLZsKiNBqnsxRATjkjnMwwAXpkK9ZUJF1Rp9M7Jdgt2j9N3+VEbBrE4pyKEuR86/MZjjrvd834kwq2u75Y6yJGiYo8BzVbpeQkoTF/pc7QBGQ0XqBtP02P1SGs/+xY2cHLnedt76b3QlIcflcya3TxXuMbg+/c0iQUvGa7grFYa1AfctJ1pqhiBj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wbe7/CcqqH4eUD3YFtblxqwbsztZ2SZl3j8jD8PYrI=;
 b=C4gK1YxamgIha4lgEiHr2D2BeG5/wweveVifg0Q/baGQ28EuSx3fJRuTq1T7Im28dLSx6IB8JeRP6Mq437SRHtpK62Kp3HrbXTwZOZjQdfdzQun6Gm9ryAXvoj4ttDz3BthrgftyzBpBhGzNMA6HrooOfar7UcMlqVE77aaWB3wHkWTRw4V+gHKhZDoyV3Y9axwxwMvSXR7BozmBqyd/AQGHVy5IJbuPzSQxR+RRg4ZbZZFDAG4+hoaekwgY2UXVqaYoJgHJYI6Q1Fclkm4D6zC1rxyL0v+C3fsxIOhPf0KVst5oAufWQWs4nxrjpaU31pIWnxV6tR1Z01UnR1BuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wbe7/CcqqH4eUD3YFtblxqwbsztZ2SZl3j8jD8PYrI=;
 b=xHdGp2zpV3hCfbtWWz827A3JIbxwnjRUua5C8RGE1WmQHipb3NeA3IkD0POfiii6rsX0SqncdsPFo8qFctMrsmhA4J+zu343YObbR5kamf0n+UCHr1PcdQbBXPzUcy4KU6SFEjg2eg1Lk6vfY9OUlWtYV1Gb28qkYb1Ve9KGtV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:03:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:03:01 +0000
Message-ID: <2fe1b506-12b9-4ec0-a02f-16f85332d001@amd.com>
Date: Mon, 19 May 2025 10:32:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: read back register after written
To: "Wu, David" <davidwu2@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-9-David.Wu3@amd.com>
 <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
 <73dd9680-1aca-4e73-b43f-495fede147cb@amd.com>
 <0242ae98-0d56-42b2-a58c-2a5bfa3697ed@amd.com>
 <f30b6320-eb6a-42c2-a8ef-77d856604f70@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f30b6320-eb6a-42c2-a8ef-77d856604f70@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9512a422-9305-43ed-63af-08dd96926de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVBYSDFKdUdaTDMvR2lMQXZWYmlJMjNzS29ZTkpXS2RxMm01eUwyRGE0ODFP?=
 =?utf-8?B?Y3NmSkFnL3FiU0FSTlgxZXJnd2NPZnE3Z3Z3eXk3Z1pRSWFoRnFlanNmbmV5?=
 =?utf-8?B?OFF1RE9qY1U3WGdhdEsybkFJbE9sRDc4M2VkaEhNWGRhU0JLd0J4c1h5SFMv?=
 =?utf-8?B?aitDdmdub2x5T2M5azJvRW16TGlMZXI1b3IyRXR4c0FxRXYxM1VSWndpaVQ1?=
 =?utf-8?B?b3h1aTJaR1hQTTVaem5Ecm1MMHo0dFBXUWxIN1haT0dJeUc4WXRCREExblEz?=
 =?utf-8?B?enpTMFRuZjV6SmZNRTZYb2NJWHBvU1FUeHJGeDR6TVZETm1DTVhPblJSQzM5?=
 =?utf-8?B?a3lRbUttSGhOVTI0cEVsREdsb3VIcFljYUNZK1VCV1MvWEV0TXpRUGE2N1RO?=
 =?utf-8?B?VGhoNUFZQklVcHJQcDNkczBOTElGeHg2Mms1THY5WmxGbUFCZUs0RXhteWMz?=
 =?utf-8?B?VWpzYjhhVmRMbE9ydFJrR0V0cDZ5bGtTcGV6QlhlNFZaVXFRRWczR3d6Um1T?=
 =?utf-8?B?cE0zTUtPamFSaHBYbHkzcU1tZGVwcERuM1NHaDgvQjJLWTh2MFArTkxzNkZ6?=
 =?utf-8?B?Unp4NmQreHRZc1lycnFObTZoR083MkJnS1FUd1BtdC9kb0dLYWJkU0pNdlBs?=
 =?utf-8?B?Qkx1alRMa2hSSjFKd0dvWWFQTGxzbHI5REh1bUVkTXdFRzlmMURibFlOQysw?=
 =?utf-8?B?YXNkbUVhM3J4blBObS9kaVd5ZURFVlY0U1QrOWdUUEdaQ2VWbmR6L0xDQ0NX?=
 =?utf-8?B?SGZMTXBKODA5d0cyaUFSUTB3djhzTnhsVXhGdHlmK1NEY2oyWlVLUE5wamJa?=
 =?utf-8?B?Z3ZlRzZuYkIxam1GcW42U3NrOTdtUkVweldsbVcyMktXbmMvUEdtWVBIc0l2?=
 =?utf-8?B?cGc0VGdBRU5Ca0M0U0xGWlNncVpiTStzeWRyZlBDbk1xRUExSzd4RlNJeHg3?=
 =?utf-8?B?TkQ4SnV3K0FZSEFxWHNuVXJLeTcxRG9TOHA1blY5OGNGb2ZMZThiS3NkS3E3?=
 =?utf-8?B?eC9vSHQvMWtqVmRxUEt6eldYWWZhS0g4eFA5MHA2bUY4NFp0OHdmQ3UxbERI?=
 =?utf-8?B?NXRhUTZUQXFuM0h0MGRHa0dmcUtHMzRPck0wY1ZBWm43c090cHYraGF1YUhm?=
 =?utf-8?B?dGxDOERRdGRxcUxxeE1JRlBKcE9DckpOV0g2Zjlvc0dBbG9MNko1cU8zbk5W?=
 =?utf-8?B?UkhEbHZTNFk5RHpyL0NVYWNsQUxDcHo1QjlrUG5Ic2NiZWlWY2hLaXZJT2Ew?=
 =?utf-8?B?enQ4YnlHVThEdFQ4Z2xMcDlvOWFHL25vaC9pL0R6cDVMYmwwQ3RtaWpTVzIr?=
 =?utf-8?B?VmFSVEgxa2FDWUFWZU03b1dUdjZmWk5vaExva01GUVRwOTV3VWZuM2V2MWda?=
 =?utf-8?B?cEFqRmFENlZoQVlwOW9ma3YzcDhuQmVjVGJQVnZLdGZuU2tNVUg3TTlqVjZs?=
 =?utf-8?B?cTIzNEphYnlsWFFKQ1FBZXlxQmZVS1BDb2kvTW5xZ09ML1dub3AwR1RPb0tT?=
 =?utf-8?B?RWF5UWFRL2pUTjVWeWFoUmJmS3RBUisrUVpRMEtrM2Z0aTViUXV5OVVkR2Jp?=
 =?utf-8?B?MHlJTVpqckh6RDVPWHVIS2Vra2M5dy9lMkNkVUtaQmpPL2hrWjYxWkdYR1RO?=
 =?utf-8?B?RGxlZ0NaWjUxaTN5cmw1Q3NPbWRlSkdCMzEySDVQbjJTeXArRUc5RjFaVnow?=
 =?utf-8?B?Wm5Hd3RVKyt2a0Q3SEV0WHNwbTNGZWMxb29TVkMxYjdMeUo4dGtUZkpqei9N?=
 =?utf-8?B?L29lK2JIR3dIOEZNOW44QjduSDF1ZS9lZHdISWFmcWlpcFJ6dVFjTzNaR29Y?=
 =?utf-8?B?MkdncEMrRWZCdW9oTWhzNzFid3pJWUVHOXE4VHREaUJMRDQ4TVFYcDkwRXhY?=
 =?utf-8?B?cWZyZ2pqdlJ3RFQ2MGxQM0dHbSszM21xQ1MwQ29jQ3R3NzlMUjJuc2lIWnpw?=
 =?utf-8?Q?OBC3FmVOuw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBJL3VhSGFwYVpvVjJ6V1dDYTkwNlNBa3RTUXQrMVE0bEhVTTkwZTFSVHl4?=
 =?utf-8?B?VWpCYnR3cnFTajdyakZwZkdKa2VndlpjNUFOeG81M2laWFZ3eHJSdTRGTGlh?=
 =?utf-8?B?VVhqS3AxRnJoYjdZOGIwUDd4S3ZBNldCOUU0d01tYnNrTXF5NFlkSVdoTWRZ?=
 =?utf-8?B?TGFTb1M3TERrN3Y1KzlqUkRCeERNZUF2b0cwYlhvM2wyRUtwdkpIQWxBMGJs?=
 =?utf-8?B?dEVvdjlkVVVXUTFVUC85Ly8yK2RERElPaGxUdEp6dEhPbDE4eUlxOTlNRXh4?=
 =?utf-8?B?UWpJWUhJNEoxa0J6MW9xWEpJS3F4UXdIVVl2NGJta0xiZEhpa25VSWtpajBW?=
 =?utf-8?B?RFpTZWFJYUtUWEZqaWtWVGg2ZU9XckVKVHdqQmhDU3cvVEtCRVp3dk9TOEhG?=
 =?utf-8?B?QTlaVW05VGxWWFRheGVLcjRLMk5hVkpNVWtUS2Y1RWd6VVJ5dDlKdEdYSm5j?=
 =?utf-8?B?YVNPejBhWnlYTHB6TnRmMGs3Rm5TVHFzUUwyRXhyRVpuRjExVW02RkpuL0Rz?=
 =?utf-8?B?bm50M000SDB5Mm15d0NNbHRqYlBOZkpucG4vMFVIbmpPc1lseWpQNlRVcVdk?=
 =?utf-8?B?RktsRFRSd2I5ZmxTbnY0aGVOelIyWDJpdEg4YVNDZjVNYkprSk5EVnNEZ3ZD?=
 =?utf-8?B?REhUZkZnUkFteEEzZkhEdlZwZElYUGdwbDlpTlRlc2ZVditvcWk4WHJGR21a?=
 =?utf-8?B?eVFiSVlDUXZ3QTF2TUttREFaQ2xENWpra29yYWROTVpaZUlobndFTk5jUDU4?=
 =?utf-8?B?aGM4ZWFsWFY2ZFB2UlZhZHdzNHhIM200NFFkd0RVOXhVRGRmUzZpYTB0d1dm?=
 =?utf-8?B?MFBJNncydkJKMERsN0EwZ2twUmg3ZTcwRGQrMEhsVEVId2ZEUmxqRE1OeUFP?=
 =?utf-8?B?bU9ZdEh0WnB3bFk2Z3I0TlhrVUFnL2JiV1dXSHcrNEIyRnRDMWJLcFdpQzRr?=
 =?utf-8?B?U0wvWUh2TW1TVXFXdStzaFJ0R0FDM1c3bXc4TG54UGMzUXdXeGRhWHlCWHdY?=
 =?utf-8?B?MHBuNmZzbUJwVWluU0tkTXl1alBuQmxPVmljMVYrTjZ4R0I3TTZVaEU1b3Zs?=
 =?utf-8?B?VWVkdkIvNnAzRVdTdExNYTgzdGVDbjVnYlVWSWViZ0VrOC9tRDV2UmNmcURv?=
 =?utf-8?B?VVB0ZzJqbGpVVkZSZlQwM25KdVNIYVJKRkFaU2h6QUxJS3pkeDFvY2hyVlo3?=
 =?utf-8?B?QUU1N0diWldQbHNUdllRNk9FUTdPcmRIaVJ0SXdOS3pxdlJuY2c0M1RkSS9N?=
 =?utf-8?B?TnBnTkhVbjFXaTV2dXl1TmJCWXBBMkdWdzk1QXJhU081Sms3SEt3bzY4ajF4?=
 =?utf-8?B?NFZkMGJYMktXMkRrUWtrdHl3K3pXMU1pWnJjb1phNlBpYzQvSDFpV01GR2cr?=
 =?utf-8?B?aW5nRjQrZFVWdVZaQUNYVEd2SnlPSHdxYjFlU0ZiYzRsVW5lTXl5RUJRM3Bs?=
 =?utf-8?B?M2NhNFIyV3dERzVNbUZ4LytkS0F5bTRDY3gzY0xRdmxXcUZlcWhMc0taSTJs?=
 =?utf-8?B?cDFDWFVIUnFTaVcwS2hwVk56UmdUZ0ZFQXE4d2EzYWgwNDdiMHluNzZmR0ht?=
 =?utf-8?B?bGRYWmFMOHlnRFA4b25EaVNTaHJ1MHJQNmdQYTBNK0hPNzNFOUIyd3k1SGdT?=
 =?utf-8?B?MlNoRXdNZFh4UFdMZktJaEhVL0hCTVlrS0NZbjV4RCt5d1NJejFMRlNhR2hZ?=
 =?utf-8?B?ZytOa1d0N2FzdG82YWJaZlFkZ25TQkNwbTVTN1ZvaGVGZzlreDVsU01uWmJW?=
 =?utf-8?B?S291bi9qb2RqNGk1cTRKRHBHRDRzN2FmeGZZL3QvSEdwUEFCRTAwNXluNnBj?=
 =?utf-8?B?anNCUSt6dXM2ZzBXWmJwVjRlRDUvZW9FMnZnS1JWSDVMdWoxcUtreXZhOTZa?=
 =?utf-8?B?a1cyTnJLQXNJQXVOemNUd1Fqc1NOWE9oTW9HdmxyYnBsbFVnNmNOSnN0amVi?=
 =?utf-8?B?blRPNFlwOGlkMWhLWFExd1ZtbE1DSi9GQStSTkoyMlJzSFZjV2dMdk5ScWJq?=
 =?utf-8?B?Mm9JcitmUlJLczNTUFZwTzNzYzBxbzBpWFB0ZjhlYW9wTGd4WVAwalBhY2lW?=
 =?utf-8?B?QXh3cXFDVHIwYWpjQmdFRlMycWhyem5qWXM1dnBEdVR1S05LS3doVFhydzRh?=
 =?utf-8?Q?L1b0+lNToHM7yba4zPaD21IgV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9512a422-9305-43ed-63af-08dd96926de0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:03:01.3235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyOZWYMy1d1yXIBAECZuiHRtJLWstYxcbku6vWp9cxiBqEHhJwbPJq8pSRCVAYMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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



On 5/17/2025 2:16 AM, Wu, David wrote:
> hahaha! ok - I can drop this one (as no need but rather make it clear
> that any register read should do)
> I kind of disagree about guarantee  - as long as the theory(read post
> write on PCIe will allow writes hit hardware) hold it is guaranteed. Why
> I ask for testing is to prove it works as expected which I am confident
> about.

As mentioned previously, a doorbell doesn't pass a register write on VCN
5.0.1/VCN 4.0.3 hardware over PCIe - this was already confirmed by
hardware team in a debug we had before. It could pass within SOC, but
that path is not required unless really required. There is no need to do
this to remain 'consistent' across SOCs. All SOCs don't behave the same
and there is no need to carry a VCN 1.0 programming model to VCN 5
generation or vice versa.

Thanks,
Lijo

> 
> Thanks for input. I will drop this change regardless.
> David
> 
> On 5/16/2025 1:45 PM, Christian König wrote:
>> Well testing only falsifies things.
>>
>> I agree that it should server the same purpose, but we don't have a guarantee for that and as far as I can see there is not need to switch to a different register.
>>
>> So this change seems superfluous if not dangerous to me.
>>
>> Regards,
>> Christian.
>>
>> On 5/16/25 18:23, Wu, David wrote:
>>> Hi Christian,
>>> For this change on VCN5.0.1 I will leave it to Sonny for a test. Since the readback is for each VCN instance it should work for that clock domain. As Alex has pointed out that readback post all writes will let the writes hit hardware, using UVD_STATUS instead of VCN_RB1_DB_CTRL should serve the same purpose. I also tested it on STRIX VCN4.0.5 and it works ( using UVD_STATUS  instead of VCN_RB1_DB_CTRL ).
>>>
>>> Sonny - Would you be able to test this simple change?
>>>
>>> Thanks,
>>> David
>>> On 5/16/2025 3:07 AM, Christian König wrote:
>>>> On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
>>>>> The addition of register read-back in VCN v5.0.1 is intended to prevent
>>>>> potential race conditions.
>>>>>
>>>>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
>>>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>>> index 60ee6e02e6ac..79d36d48a6b6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>>>> @@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>>>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
>>>>>  		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>>>>  		VCN_RB1_DB_CTRL__EN_MASK);
>>>>> -	/* Read DB_CTRL to flush the write DB_CTRL command. */
>>>>> -	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
>>>>> +
>>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>>> +	 * otherwise it may introduce race conditions.
>>>>> +	 */
>>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>> I'm not sure that this is a good idea.
>>>>
>>>> The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.
>>>>
>>>> Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>>  
>>>>>  	return 0;
>>>>>  }
>>>>> @@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>>>>>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>>>>>  	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>>>>>  
>>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>>> +	 * otherwise it may introduce race conditions.
>>>>> +	 */
>>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> @@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>>>>>  	/* disable dynamic power gating mode */
>>>>>  	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
>>>>>  		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
>>>>> +
>>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>>> +	 * otherwise it may introduce race conditions.
>>>>> +	 */
>>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>>>  }
>>>>>  
>>>>>  /**
>>>>> @@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>>>>>  	/* clear status */
>>>>>  	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>>>>>  
>>>>> +	/* Keeping one read-back to ensure all register writes are done,
>>>>> +	 * otherwise it may introduce race conditions.
>>>>> +	 */
>>>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>  
> 

