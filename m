Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F816E63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 17:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D5710E3DD;
	Mon, 16 Feb 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvsNCN8f";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D3410E3DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 17:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0sXPEZ8jlKF2KsUd6ThUgwChrVKWX98WYwGqOXuJa/avwuHCvBOYqHFxO6tTSuNrNyaQAVmYJtIqwdUmIG3d87Mr58P2Uhld1xTbs2np33DJZ5ndz1YyYzeTWaYTcOCRJeeIDK4u25Vg7s8pm9c7iF7PMrDovY/0xwLOWg0RO88p013jq01EYw+Mp5t89tdQ4lfJZnOuNyhqp53YN/kC5DD36TwQvDVapUJhSsdSb/ZWNG4MXUKvggk5NjCwwIJ0AVlO7mNAW2pAiNYTEYRO7uURHZDnz5nrlxyDGeVoNqIzCweK/YhFySSZV3xdNrVuz+Qf0xcvYsoVw7e8buD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcaxLyYRkZZnD2QByH/78K+UwUVjuT3LsU5rf4qcvtU=;
 b=MAWTXU0+0a3xu0VcLq1hadfcx35/0FbVQuP8+QUv4cc95whLO4nQ4KEQwjeoWfXMLomAHkxTKaF/hZ8IocuMWWb4yIKBZQe1cTSrRT7gnzVC9nG1lIHJ8tDv9gM9PN2lJWWIxu5Ugx0kGcaUGt25OXAjMFNKLVA7xjlfiyG41183mjSTW11iTGyhX+H8sVtRUXygS966IlC2RfyZEh0U364WSg2tPx4r2r15YSK6XnjJL0C/PtXEOktuqObJkAAtqM/OFEFkJpwKFBCm4zpL15KHC6HX8HHL8z9LuJQIFjeN3x7SF3hxnqUzPvqsugT6f7By7P+OdZPC91evGW5AhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcaxLyYRkZZnD2QByH/78K+UwUVjuT3LsU5rf4qcvtU=;
 b=xvsNCN8f++7KSa3KKcWe3Q64E8Ja23A+W7HBIKwi7Evth3RbiCxA6p5bVevWuTeFymtAPXhiggqw4wqR69/Jxqk3UZWiUPcKAq8OGAywQT4dNDuJwHkekn5FdgskZ2hzNw/eA8+CMDzHTElj3jZqDwnVk8vNLW+k9Dw+eXOahaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:53:19 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:53:18 +0000
Message-ID: <e1abee27-ebce-4c17-bf15-8dd9b9c8338f@amd.com>
Date: Mon, 16 Feb 2026 10:53:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
 <CADnq5_OKvYO6ibNLmzuK3tW_sEaaCB82FgoLUc+NPb2asuck=w@mail.gmail.com>
 <cf272efe-c0d4-47f2-a62b-7e47973632dc@amd.com>
 <CADnq5_PNTTytPB_CDVSVFJ7F77OZsNLPg=XJiyFZCA2R00rQHw@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_PNTTytPB_CDVSVFJ7F77OZsNLPg=XJiyFZCA2R00rQHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6ac7f1-f21c-4bfe-3ddf-08de6d844486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHB6dGl4SjZxOUFBV05tRTZwdTVLeEUyMHEySkNrcEtvTU45SWZyVWRTZHFY?=
 =?utf-8?B?WWQ3NmpBbjVuM2JJYkx6ajJqdkdnUm43Ri83NFJRck5NbHBJMVgrV2hjaEN5?=
 =?utf-8?B?T09ZZElxZEFOZWN2MEo0SEM1V1crbzgwTXZEZDUxZmJGUTFhQlBoakxFdlJa?=
 =?utf-8?B?MDIrZVBibWpvSDhGVllLeU01MFF5dGl6Sy9scEFjMDlXRlpyR1FOV2JpdVJn?=
 =?utf-8?B?SWs1d0IvRE1BUUJnTzl4L0NsT0lKbERJeUQ4RUlOSU15VVZSMDArWVJDemsz?=
 =?utf-8?B?ZFI1UVE3azhreHNDZHZFbkk1SVcxN0Vzb0VmYW5jUnpkMjk3dkdCY2k4cG04?=
 =?utf-8?B?ZVBLMThYeVMwWktFNnRyWjgwVWVPSjR3UlBQWmU4WmZ2aHNlaVJJeklXVUJX?=
 =?utf-8?B?U0NXNTJ5N0UxTU5CSnMyZHo0azFIcDRsU25HbGRXTTJhZmF4cEY3SnE1Sm5s?=
 =?utf-8?B?eUxNUXdzMjNkbDE1WnlhQWwwcVFXUWt6U1Z0K00rZ0N1MzJPRGxVYThDVkZK?=
 =?utf-8?B?K29sbS9hTCtNMjhVZkdDblo4aWM2ZExJaUJRL29CSTNwRmFydE4wWkxiUVYy?=
 =?utf-8?B?MWdaNTUzVTFzM1RPa01BM3FQNE1vOXZrcHpHMTl1V3pnQ2ZDTEhjL2Zaek1h?=
 =?utf-8?B?eVZORGR2ODZiWkhINVNROU1LNUg0VE1JQjlXOFVSVXRSdS9XWllGK2dIdVFk?=
 =?utf-8?B?QXUzZVRydWJBRFRMaTVBeU5zOURub1NMVjFCOUJycC92UmxFcll1SHM3ekla?=
 =?utf-8?B?akw4WUtQU3AyZWlrUUdSanNpUWZJUjlvQjJWKzN4WFo4WDErMW4vR0dLQjda?=
 =?utf-8?B?Z09OU1liSEgybXVkWS9TcDk2ZkNDVUdZSklLcEwycE84M2N1Zk9EMU1VTEs1?=
 =?utf-8?B?VFhNc1JhdVhjZkRSaEFuS3BSMG4zc3AvaDEvcnM0TlFVd3h1OVRISkVHMGE5?=
 =?utf-8?B?WFdzSFhSbFN6OFZmY2dvdmFqOWxpYktUNmpVRjQ2bk1YTUxwMEpOT1B0VzRo?=
 =?utf-8?B?YWg0bVRKUVdqWmI0SHNNSE5TZDZKS2Q0N0hlMGF3eThWZ21RMll1QVZzdXhX?=
 =?utf-8?B?d3VSNzh1TVI2VG1PYU42SU15VXZnY3pFZDZveSswTmpqT3JIT0gwV21rM2Fh?=
 =?utf-8?B?aFlNZlBIK3RJaGx1RVJZQlE4ODhES2VBY1E0VUdrSGhzSEJvR3kwZjQxcVBW?=
 =?utf-8?B?OWxRL0sxRnkzbU8xcEd4L3B3ZDBqb1BJaE5MY1NFazdYTERqcmlqOU53Y25r?=
 =?utf-8?B?aFBVbE9TSTlkMWRsYWRERGZoVEVETExrYlFLQ1phRGRHSFU5MmpQWHZQeXFD?=
 =?utf-8?B?VTdwekt0eXBzamQ4QVBXczJHS25ySThGUlBrUk1LRmFIQWpWNGRxTU8zZW1S?=
 =?utf-8?B?bFB2QUE3ZHdFWGtsbmVVQmJnNFpMRXJXcFlGK2o0VDE4KzN0aWtkNzdYcGl4?=
 =?utf-8?B?Sk5menFxbEFnbzcwaElvdUNBbzdrN3I1QzFXRDFLMFB0QStmSXlldWpyNy8r?=
 =?utf-8?B?bUtsNE85bmttOXFWR0IraGloK0V5d3pSWC83cE5UVVRBZVR4R3oyMVRybXdQ?=
 =?utf-8?B?QWR2U3FpZDdLVTl6dnVLSW80bWw2c3I2Q3k2YWZFdUt4QmZBYXVYUnRRTGtL?=
 =?utf-8?B?aGtPb0pyNUFGOUw2Yyt5cjJJRHJTaXpsZk04aysyN0JPNld2dk8yWlY0SUxW?=
 =?utf-8?B?OHZXbkZPNnlST0hBV0Iydmd0SHdoZXRxTnBDVXBETHk5T1BoNndNd0ducmFQ?=
 =?utf-8?B?cHJUQ00zNndSeGF1ejhPTk90cXdaNWlxbTJUQ3NKQ0d1dllDMTVKQUJSRGNW?=
 =?utf-8?B?L1RNUFRuK2JjdUhRMWpiME9XQVk1UXprd0ZQZ2VINUpsV3RqOFdQanlWaWp0?=
 =?utf-8?B?a2JWN0REb1Y2S0dqRVYwTUY4emxuNUQrMGhMQVhFeEJSMmQ5NzE4VDYwemcw?=
 =?utf-8?B?eWlCK0FYV0wwa1d0QS9tNVN4TW1IdU9ZSzVqcllIcFNCWWVwbDZYdmczZGdt?=
 =?utf-8?B?NENGQzNzM3VIYUcvbVJMb2gxdXFCQU4ycnA4eVVhLyt1aDJpeHo0UGJUazA1?=
 =?utf-8?B?Tm5WbGRMYkFFUzZTRTZ5eVVOVDlwemZrSUhJcytNSGdiTHFtWGd1SXJack1o?=
 =?utf-8?Q?Kro0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWM0emRtQlJMYStxWHFPTmNnT3ZCcXZYdkpHQURGaXRYc3IwQUZTRzJRRzRr?=
 =?utf-8?B?RlZBV2JOeHdQZnZHNjB1RzMwczkrZ3c4YkJUMkE4OE9rNkFDRHBaMzBBdTl3?=
 =?utf-8?B?K2RHUXMxNHdleERuSUsyajBRRVhWNmVNclMzSzduckV0YmU5MFFhU0ZiRGUx?=
 =?utf-8?B?NXVKZ2dadG9QNWxQOHI3TWw5aGJtRzdEN2p3bktqNmcxVm1kRzR1ZTdmUXh4?=
 =?utf-8?B?UVJwK3FFY1BsaTBDaWhQWjhJZVJiQTZ4NVh1T1FzVW1sUmhtNExwaUFwLyti?=
 =?utf-8?B?eE9OZlAvSm5oSnQxLzc1NzFWN29FZmUyOHVoTWpOSG1Md2VQVlVBb1duSEF3?=
 =?utf-8?B?QkpkUStVSnk0amxPNllVMENkVCtKQWlkVnJ3WEhqb2Q0bm84R3hXK2g2b25p?=
 =?utf-8?B?ck93NHdCVDVZMEpxWnRhaE1ISFZ5RHp1WjI4cExZdDMreTBnRzJrVEdyOTh2?=
 =?utf-8?B?dXo5RE1XSE5jYzVQOU1pbk5ibXQ1bVMxcWNhLzhiTEJDY3hIcGV4RFlLb2lQ?=
 =?utf-8?B?cWxUWWpra1dPbjdhdjV4NG5aRDdyYXdJeTJISFpISVB6SDBBRzNDOWphc2oy?=
 =?utf-8?B?ZXdFN0ttUkxRRHpDVWloeC9WNnZhOWgwTVdreDFadWVtNy9wUTBZUEcxSUNZ?=
 =?utf-8?B?czRGdmY5UjQxUGJXSGFFQ3BQVWZucVlqMXBRb2luZXJVZy9JWG9lTmQyTXBh?=
 =?utf-8?B?eVlmM2c0OVR2dnBaYkE5YjNpUFYwbmVuY0lpcWxSd3Z2TG9YVFE3c2luV3R4?=
 =?utf-8?B?T2NETG9HQjl0cDRvOHdKRWJDeXJGbDdoVnpKTG1SYUhGZFJ5dXVxb3p5Z2s1?=
 =?utf-8?B?QlF3cUdnaFd6Mmd4SVFpRzJHQUpOc3hJZU9qeE1VMlZvVlNETzZRWU5LdW1X?=
 =?utf-8?B?L3p4UUJRWk1QS0p0YmM2N3V3YmxMVGJJZ1JJaC95VFBZNVA2SSs2ZkpUQkVk?=
 =?utf-8?B?d0lpZGRlS0srNzFiZlZLbFRibEVCWlEzRVQ2QmozVmpXdUIxSWQzOEhrOXFU?=
 =?utf-8?B?NjdlK3c1QUwzSHNocnZpRVlVK1VZS1cxemZ4dnJobXJBbTg5dWVlRm1vVW0y?=
 =?utf-8?B?T3c5TzlzVXVUT0FkbTR3bUdZY3hSR05uRUtIZVA5N09pb0M2RHhBRVBEeklo?=
 =?utf-8?B?b0pkQWNFRkszSEhxNDhINllSd2g4NEt3TkpUYVBxQ0g4SEpTT2RnaTFuQTk3?=
 =?utf-8?B?azZMTU9HVXFIVUFXVnVLcnpEeDJFZXJLOEdjV0oydUpIYk9jNFJkUnkrZzFU?=
 =?utf-8?B?TGpaWjB2RDEwY1BzMzJjQUVwdzUwZWVUaERaZDBiUDhTWDFxd1R1VnRBeGpL?=
 =?utf-8?B?TU9ONzhxamg3ZmIzQ1lvTUNSdFRibUZRVFZJREdibEt1bW5vQ3pNelZhUVFO?=
 =?utf-8?B?QTQ4azVxY25KWXVnUytTc3NLMWxhb0lLQjBIdThmRE05U0EvcXljNWh0WlNM?=
 =?utf-8?B?azdGUFE0VnhKRXhqSld6aWIvS2loUGp6czlUQUkxVExoOGlJMkJNSlZlQTNx?=
 =?utf-8?B?WldscmtEaCtSZWZqb0o2QVlvbkpjS1lLcGh5Q2tBVm5pcmYyeUFsajNXUGFW?=
 =?utf-8?B?Y0dlQ1FSR05BZHlySlFLTHg0d2RjRmtpakVSUFRDU2dySjJESHFrR3dkL3J3?=
 =?utf-8?B?OTMrQWQ3VWprMW8ydlJDemE4ak94QjNycHlpMGVTTzFPTHFVOXdRSGViSFAv?=
 =?utf-8?B?QlcrWm90WTdXK0tQYmRYRlI0NzFPaHFESHY2QmdiRnlIRG5qblpaekEvWWEz?=
 =?utf-8?B?UjlvZ2VYeThjcXpVaXBjWVpxSlhrcnYzMVFrb0x4dlcvRXdOUDhHY0drZ2Jp?=
 =?utf-8?B?N1E5OXcxYy9nZnltQzVoMzhiZUxZdmNUbnh1Q2xNYWV5L0NTUzkxemdUcGxu?=
 =?utf-8?B?R2gxOFZDaEZWdTFETUJjV3Noa0I4czdUZDB6SW5WMjFocHRuSkZGWWdFNEts?=
 =?utf-8?B?OHZOeVdWa2szdVVRVmZvdWFnTU56RXJ3SmxwZHFBUnFFN2NxR0pZa2pkQ09G?=
 =?utf-8?B?WlRVT1NwWHJOTmJhWSs4UVBqSlROdGdmTERuUmZCemFEQlhyek8ydy93dC9r?=
 =?utf-8?B?Q1BwNmgranFSS2xQa1ROV29ZN1JMSldzS3gvRW9ETFA2VlNtS1lLMllKZUor?=
 =?utf-8?B?NWZEaHlFSlNtUDBzdkgraDBNOThPOFFyRUxNeW11TzF0SVFoMDRRL2Y1OWNB?=
 =?utf-8?B?RU9TQTlIaTB4UGxlUTZXZnJqTlhyZEsxVWlSQWkvZjBJOWtCSlErNWVsbEJm?=
 =?utf-8?B?U3pnbE54ZjlFNTgvcG5qZE1IdUNVOWRLSzkvaWdTVkVFdHY3ejZ4L0JTZVFp?=
 =?utf-8?Q?6kzlkcmJFlKgytidWA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ac7f1-f21c-4bfe-3ddf-08de6d844486
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:53:18.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkLR1zOS0kE+N1Ql+FNdig5Z4kB/WNt6BIb+WirwEgKnfLEtqXjVr4CmEBaGTrqTOA+5N/Z1JjfoBWO5l/Yf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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



On 2/16/26 07:41, Alex Deucher wrote:
> On Mon, Feb 2, 2026 at 7:47 PM Alex Hung <alex.hung@amd.com> wrote:
>>
>>
>>
>> On 2/2/26 14:25, Alex Deucher wrote:
>>> On Mon, Feb 2, 2026 at 7:17 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>>>
>>>> Fix a "black screen" issue with analog connector support in DC.
>>>> The Radeon HD 7790 series seems specifically affected.
>>>> I recommend backporting the series to 6.19 to avoid regressions.
>>>>
>>>> The series also makes the analog connector support more consistent
>>>> with the rest of the DC code base so it doesn't feel like a hack
>>>> anymore, ie. it brings analog connectors a bit closer to other
>>>> connector types.
>>>
>>> Series looks good to me.
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> I assume Alex Hung or Harry will pull this into the DC promotion testing.
>>
>> I will send this series to promotion test next week.
> 
> Did this get picked up?

No regression was found during promotion test last week but some CI unit 
tests failed. I am still trying to investigate the root causes.

> 
> Alex
> 
>>
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>>>
>>>> Timur Kristóf (8):
>>>>     drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>>>>     drm/amd/display: Fix disabling fastboot on DCE 6-8
>>>>     drm/amd/display: Don't call find_analog_engine() twice
>>>>     drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
>>>>     drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
>>>>     drm/amd/display: Set CRTC source for DAC using registers
>>>>     drm/amd/display: Enable DAC in DCE link encoder
>>>>     drm/amd/display: Remove unneeded DAC link encoder register
>>>>
>>>>    .../drm/amd/display/dc/bios/command_table.c   |  3 +-
>>>>    .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++-----
>>>>    .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
>>>>    .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
>>>>    .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
>>>>    .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++---------------
>>>>    .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
>>>>    .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>>>>    .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
>>>>    .../drm/amd/display/dc/link/link_factory.c    |  1 -
>>>>    .../dc/resource/dce100/dce100_resource.c      |  8 ++-
>>>>    .../dc/resource/dce60/dce60_resource.c        | 11 ++--
>>>>    .../dc/resource/dce80/dce80_resource.c        |  8 ++-
>>>>    13 files changed, 127 insertions(+), 81 deletions(-)
>>>>
>>>> --
>>>> 2.52.0
>>

