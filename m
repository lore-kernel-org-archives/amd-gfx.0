Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F379C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A5310E2EC;
	Thu, 16 Jan 2025 21:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUYFPL2/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2927010E2EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itfiRj9rutABeitHOsA6LQL3XkuboF/n40NSIH+ZQSYQyBhOUmQklot1+BGmvOz9xh4UnaXg/lp29VT2Fc1UDuGscvIitLdUhP153pd1kbKkymUbuWY41YP8Mb3lxhCI/NPBdayzVYHXq5OvcSHKPkgzJml0MEvCShf4P4TKUY5suIeIhNwRWpVhU9AcDEhL7xSbPuQJ/6vYvZEdVozVh6qGtLV8bH3OZwWSjIDtbAedAFsirc/dumc4mXYM+INnKIvPTkrHltfO8LMw/wjJFS57DQh4bITEC4Nu40snOGZjrcGj3M6JSu1QtlZCXVqZ4JX4OG32xFNz1ffjx/wUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wis2mbet/Y0ETD5iMeFJFXrtZOeVAFBrFgFeU31nbfM=;
 b=Ipsy7Dj3iA9aIWfyNDLQwbKox34vInmeRqZfRPynZ4sRWlywV71jGYU1KqryvSQ8NnYpbnC3kYsVgtvMLiTnEL5FAoe6kGDObpJZ4CTEsJQFMCON1lVmz80Jeq3hStn5kwKNDpCAlsMgNMygdGMMkzhXwAt3/rdJPzxk8lfKT3CPclCa7uNftq3ZVOcjg5Qg3z6GrZ7IiptO0gUSGyKois+3P0jUfyIGoYZEEVRwkef42UnGCmj1YGxfj+zWCKD9rcPi4D8qzZb62Jk2Z5TOerKP03DqQNPLm8XMmn+aoaUM++1578cI9kfoz6OK/z6KNDKqmDuiDFC5yeuIWaYb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wis2mbet/Y0ETD5iMeFJFXrtZOeVAFBrFgFeU31nbfM=;
 b=bUYFPL2/UBKhNYQdakOQjrSPdBx0+DpbbFqTSfWep2HveV6LmOUajXsGs3ofzaJp8dWkYzlIRTm11YXvxzyY+vtftlkITJotnEoJefdrHnMVbDumzBN2DifYLKQWud/JHtcMowIGuk/P7sWJRKJHjzUtVC53R897Wm8bSTsQBXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 21:20:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 21:20:01 +0000
Message-ID: <90a10495-9c39-4458-a15e-1a9ba306391b@amd.com>
Date: Thu, 16 Jan 2025 15:19:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 06/15] drm/amdgpu: enhance amdgpu_ras_pre_fini() to
 better support SR
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <d07f0c4ed71a8f4b3e6194881f7cc00826240951.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d07f0c4ed71a8f4b3e6194881f7cc00826240951.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 584e24f6-f016-4479-12c6-08dd3673895e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFhNZGJIKzJCNHJQd3pnRjRoejdJMnVqSGpBQTU3dm1aVTU3aVI2Qk91L25D?=
 =?utf-8?B?ZEI4cHp3Z0x1TTR6VHBhdjR6d2dRSEUxOXVVS1BBU2dWVG10Q01wOFlOZGVT?=
 =?utf-8?B?bUFtZTRsaWhXOGtabWgxTlFvb2MvNGE0aU5mNFRuTHR1czRTSXlNZWl1SW93?=
 =?utf-8?B?MGd3d3R2RUpWakw3U1kxRnJQeU5QY09SR1l3YVZEdGUvcE1LVmJEMjhmdVJQ?=
 =?utf-8?B?VWd3Y1lTcFhlMDhPTHE0S3gwUG5SQnhOM1B1WjF1ZG5BOXlkN3U3NGlQSjVs?=
 =?utf-8?B?VEtyeGdNdTRDakE1Z2lLWWMvbXBIQ3RiSE9KNjlLRTFtY0hrTWNkV29oOTRY?=
 =?utf-8?B?NXFoT00xNklQZ05nYStid1hXK3M2REYzQnVnWXBGeXo3QzJZNkN0d1ZMUkE3?=
 =?utf-8?B?VkZlY2h2VWlucnBtZloybitCR3pteFMzc21hd0RMZDlzeXNsSUh2YzJzUG9i?=
 =?utf-8?B?MGVyN1hxR2ZNYkU4aDB4Y3hpT0Vnekp1Z2NManBYWEQzSXFXOURZWHlxZTBQ?=
 =?utf-8?B?aGdvV0U3TFp3OG5rTHVScjlmelRBbEtDVEVYbndRZjdYbmpnNzB0NkxKQ1FJ?=
 =?utf-8?B?cjU4SWR2Y0gzd1E3YWdNTVJ6UXhPZCt4T2FoMnB6RmxKbk4veUFTNDlQVHZa?=
 =?utf-8?B?dzQ5eUtxTGFqRlhUVzZud1ZDVVA1U1kyVmcyOVp6UlhPa3VZUE1HUnl2a3pU?=
 =?utf-8?B?RlFQaFRvRkc5SU1nd0pZNDRISzZaV3VzWHZDb2NibCtRem54ZUZnYkNHYkV5?=
 =?utf-8?B?USs2UDdabkR3a29zdVhlY25IVFdwZXlXa1NXdHpTRXQxWWVHZ0lWS1prSUps?=
 =?utf-8?B?VFlLRHZKeG9tNkVVSTFRVnJmMGk4N2srNHlGS0w5dm1YU1huUzU1M1htMEZp?=
 =?utf-8?B?dzhDWEthbkFGNFNYMlQ0RFJvU0VVK0lCbm9CNWlVc280RU1kTGVpbG15bUxM?=
 =?utf-8?B?TEhWOW5uQmxnb2tuaW9SMU55RWx1ZEtKakppS2dKcDh4NHB0WEVEc1VHdlVv?=
 =?utf-8?B?Q3F4N3NsNEZOWnVPNTN2Q3NGeWFMMVV1OXVXeDBCWXQvM1JDU2NkMlVLdDl3?=
 =?utf-8?B?U1RkdGJxU0RKSThVdkZLaXBtcEdqQSt5QVZOWlZEbHpoUlplZ3JaWXY2ek50?=
 =?utf-8?B?NHJMK0g2bUFoTXFXODR4ZlNLNDFMQ2Q2MUN6SnJqVVhqQkFLNkdmMklpelNr?=
 =?utf-8?B?eHAxYjNDaHdQYW11Vm5pUy9yUnU2Z2lWVm91Rld0YU45a0NoTDFVQTFGdDN0?=
 =?utf-8?B?c1NKMXlQKzdyS2hRRzl2bXMxTHpBNGJ2bDJFNHJON3YzT2tzOFZuYzA3WnRS?=
 =?utf-8?B?WDgwQ3NXeUxrVVlSUWZ6ZzhKM28vOUJkNXM4a1lSemhMSVJOWmNuRTRVdlRI?=
 =?utf-8?B?VXk5N3JvTlkxcHNncC9CSlJCcEVwdXZiVXJ5eDErNHFlZkZ4MTIwSWNSbFVQ?=
 =?utf-8?B?LzJZY0FxSFRGUDRSdGhTOWF6ZkRqTmZpZWFpdEdaMmlGQzlsYzdYTVZWN0NU?=
 =?utf-8?B?VTYrdXpPaXhEZFRBdDFsdjJiVTRSbHU4aWF4b0JWWXJYVTZsN044MEIrN1hQ?=
 =?utf-8?B?QWFXTTRjek9FOWtVblJ6cGM3aFJsUkh3dWpUaUhNOXNNMVczcGdVdzgyUjR1?=
 =?utf-8?B?S0VmUm0yZ2lmeTJkQUNWb0RGNDdNVVJLTC9XdUlzNURPVjBIaUhWVjZ1UWw5?=
 =?utf-8?B?S1kzTnNUNkZzMjJkYjJlb2Qxcm9lSW1TN3VnalQwaVlSQzVGcEUzNjhCRmZv?=
 =?utf-8?B?Z3RqT3dTTW1VSHpKdDRHVmtvNnNjY003dDBkSGo0WEI3bno3MEl2V2pxcDBQ?=
 =?utf-8?B?U2tHaWthcEVYVWRTaXprbXRvMENtdW5uWjdNTG9ObThzQUFZSWE5OGFBdnpN?=
 =?utf-8?B?RUtmTDd2NmdxMUl4OXRPYkxzbVRiVzRqcXIzbk5CdFUxQ21GT01vK0RjajJk?=
 =?utf-8?Q?07Mi1WZbjXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTUreUlNQWo5Z01wUTBRMm01eElaYTdNSTZ4OFRnWjVTZUJjaUhiUTVSaHYv?=
 =?utf-8?B?aTFYM2Iya2REcmxkNlRXNTJ0dGxnMXI2T2E2RTFnMzBiblptSjN0TkloOCtz?=
 =?utf-8?B?bXFreFVXUkRSNVd4dHEwTkxWK0ZKYjRaUmUyaEJKMDdQUTN1aXB5a2w2OGlC?=
 =?utf-8?B?ZWtFckRTZ3kzWUpzWVVHdm1wQ0NNdlBKcTVPY0hhSzlYL3V6T3ZndjFqUVUr?=
 =?utf-8?B?WFB6WjNTOHVJNE1zeFFqMHJsM1dZZmtEZjVhN0FPWTVvMzBBY1VGRndrZksy?=
 =?utf-8?B?SHBXYmpZZDZKclQ3c1RoRHhpZlllYjgzZ25ibWUxLzlFcUVVcDgzR1M3VkNn?=
 =?utf-8?B?bzNMRGljQU1qYmZUU0swdGhURUJjTHNud2dGQ2g1dnpMd3JWZWZNTGlmanNv?=
 =?utf-8?B?ajlTS1F0OGZmbGtOYzJXbFVSZWEySWtFOE1sWHZ6SnVOOVRsLy9iQVE2YmRM?=
 =?utf-8?B?elE2djErRVl1OHNXT2d1S1NRdTJUQnloYmdLMDJEN2Y1Ti9BSkJuK2g5ME1T?=
 =?utf-8?B?RVk2T01QUnM4cVFjMGpBcEt6SHlueW1oalVVblc4YW40L21zdURQWmtKZWg4?=
 =?utf-8?B?V0ZoRXk4Y2NvK2ZLYmdEMVhkRitiSHZ2QmMzM2RuRVRyaG14V1krcitJaGJn?=
 =?utf-8?B?Z2xUbzFsZkZtMnVLSFpScml5MEhJejllMnJIRVpUMkVhMEhCY2FLSTdPRW55?=
 =?utf-8?B?K3BzdHV0ODZUR2FWVVV5ejc3UmxQR241VjBSZ3NFNUdFclpkU1grMVM0cWRr?=
 =?utf-8?B?VFN2azAyZGNwclFLZGo4cW9JWHppRXM3UzE2YitSSG9jeEpybjQ4RXFDUGFP?=
 =?utf-8?B?RVRIYStTWmpiL2c1VFM2Rk1pVWh0SmFTaEZKbXkyMnduT0JWWmVSRVNFaVVG?=
 =?utf-8?B?MExOOXlwdnhPOXJGczM2Ym9CY3ZiUUp2YUx0bnNXWlBOSzhlYlF3SVNPR3NL?=
 =?utf-8?B?eXRuOUMxWXBXNXZ6cXpkbzgyL3ZmSWVDNzZFRThLMGtxb2QyMENPaG5Sc0lj?=
 =?utf-8?B?S0lIY2I5SWw3dlRFK3dlNzdyVURWMUZPaTh2cDVzb25XakQ0Rkp0dS9KZzlS?=
 =?utf-8?B?K3h0TE5EdURIZVVJQlFwdDE5cmxpb1dKQXNLN0pDVUNueEorUkJ5Y3JXUDYv?=
 =?utf-8?B?VkdXdU02eDFnaXR6T3JaUStZNnNkbkNxS2ZzTWtQU3lRNXF5SXpWbXZTU1FY?=
 =?utf-8?B?bGlVMkMrUGxGcWhZR25FVWsrWjFOVWVCNFdDdUk2Qm1vZCtQdUsrTldZZDNs?=
 =?utf-8?B?TVNVMVdtRzZXZUZHMHRGL1U3VWoxSWZUTEo2M1RlS25RaGtvRE9QSU1UL2dG?=
 =?utf-8?B?aTRUM0dtYXJCQ0N3U0xTUTF6T2tKbFRicW51MElzKzJidE1LRDIzSDNmTjdl?=
 =?utf-8?B?MFkzSjd3MHlIbkQ1ZVh3dkhFcExUZUkrZ0tvTFNBeG1tWE4xYnRZbS9RRXFi?=
 =?utf-8?B?dGxHRk9KU1h3aVk1WTJYaStaYVdZQm1zREFzbXh2b01FWEFvYmhES3RxTEhx?=
 =?utf-8?B?OUNlVXJLcmRpTTZLZDIvWHkyQmlqMlBvUWdsRThCSmthdUwxZGxIMUhwQzhz?=
 =?utf-8?B?UFV2UUMzSk1EcGtPcVdyMUpPK3lvSlcvd1Q2dGk1UkZ2amt4MWFXL09RZ1Zq?=
 =?utf-8?B?cEhGYW9haW9XYkxxeVkrakdSbzNvSE5VandScUdwSzUrcjI5SnUyYWtUd0Ry?=
 =?utf-8?B?N2JRU2VnY2NPeW1qWEcyMUVYTFlrMFdNclpySk5zL2RxZlpJQWJYdVJnMWVI?=
 =?utf-8?B?OWQyNGxBVWpMQmZOY3BhRm5mMWpTMitDd1c0dk9KakFWQncxT1RsWStScEZ1?=
 =?utf-8?B?RjYxWmxVQWZxQlU0OGYvTWZxZWh5WTEzY3NFcitoNU5JVGR4UkxpbzJqSUJE?=
 =?utf-8?B?TXR4Wk1qdXFpcWJQNytrOVRHU2VuYnY0VkxTOGJ1SUtkV3VjVzI4Z2dhcEtX?=
 =?utf-8?B?MmUzdHVJaXQzTnhGMVVEN0VMQXlOVXlkOFhFS0RqVU40L2diaE9mMVFNS3RF?=
 =?utf-8?B?aW1yR1N5RXo2czBvcHdqYWUySEN6MkJBbVBIcjFwbk5iWjgzKzFvNGROaEx6?=
 =?utf-8?B?OHdqTytHSmhFRlp5Y0kzVHVwaXFIWEMxRXlWaTF0elBBWUIveTd3ZFl2aHMr?=
 =?utf-8?Q?dOPUcVs5e5x7tEJP1tC1VGZNC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584e24f6-f016-4479-12c6-08dd3673895e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:20:01.1593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM2S3ouJHbsbaMsd3HHIitRi+X40HWXFz6yOCi9H/uXkeev9V745ehe8qu0ViIrrXQMrHW9iB1KyxQJyOyd39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Enhance amdgpu_ras_pre_fini() to better support suspend/resume by:
> 1) fix possible resource leakage. amdgpu_release_ras_context() only
>     kfree(con) but doesn't release resources associated with the con
>     object.
> 2) call amdgpu_ras_pre_fini() in amdgpu_device_suspend() to undo what
>     has been done by amdgpu_ras_late_init(), because amdgpu_device_resume()
>     will invoke amdgpu_ras_late_init() on resume.
> 3) move amdgpu_ras_recovery_fini() from amdgpu_ras_pre_fini() to
>     amdgpu_ras_fini()
> 4) move calling of `obj->ras_fini()` from amdgpu_ras_fini() to
>     amdgpu_ras_pre_fini().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 44 +++++++++++++---------
>   2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0a121aab5c74..2bfe113e17c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4613,6 +4613,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	return 0;
>   
>   release_ras_con:
> +	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_fini(adev);
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_release_full_gpu(adev, true);
>   
> @@ -4627,8 +4629,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		adev->virt.ops = NULL;
>   		r = -EAGAIN;
>   	}
> -	amdgpu_release_ras_context(adev);
> -
>   failed:
>   	amdgpu_vf_error_trans_all(adev);
>   
> @@ -4921,6 +4921,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>   
>   	cancel_delayed_work_sync(&adev->delayed_init_work);
>   
> +	/* disable ras feature must before hw fini */
> +	amdgpu_ras_pre_fini(adev);
>   	amdgpu_ras_suspend(adev);
>   
>   	amdgpu_device_ip_suspend_phase1(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7bbab7297c97..5ac63f9cffda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4270,42 +4270,49 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>   int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
>   
> -	if (!adev->ras_enabled || !con)
> -		return 0;
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
> +		goto disable;
>   
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		obj = node->ras_obj;
> +		if (!obj)
> +			continue;
> +
> +		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
> +			continue;
> +
> +		if (obj->ras_fini)
> +			obj->ras_fini(adev, &obj->ras_comm);
> +		else
> +			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> +	}
>   
> +disable:
>   	/* Need disable ras on all IPs here before ip [hw/sw]fini */
> -	if (AMDGPU_RAS_GET_FEATURES(con->features))
> +	if (con && AMDGPU_RAS_GET_FEATURES(con->features))
>   		amdgpu_ras_disable_all_features(adev, 0);
> -	amdgpu_ras_recovery_fini(adev);
> +
>   	return 0;
>   }
>   
>   int amdgpu_ras_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras_block_list *ras_node, *tmp;
> -	struct amdgpu_ras_block_object *obj = NULL;
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   
>   	if (!adev->ras_enabled || !con)
> -		return 0;
> +		goto out_free_context;

This block doesn't make sense for two reasons.

1) Why would you have a context if adev->ras_enabled was false?
2) If amdgpu_ras_get_context() returned NULL, then jumping to 
out_free_context and checking con again doesn't make sense - you already 
knew it was NULL.

>   
>   	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> -		if (ras_node->ras_obj) {
> -			obj = ras_node->ras_obj;
> -			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
> -			    obj->ras_fini)
> -				obj->ras_fini(adev, &obj->ras_comm);
> -			else
> -				amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> -		}
> -
>   		/* Clear ras blocks from ras_list and free ras block list node */
>   		list_del(&ras_node->node);
>   		kfree(ras_node);
>   	}
>   
> +	amdgpu_ras_recovery_fini(adev);
>   	amdgpu_ras_fs_fini(adev);
>   	amdgpu_ras_interrupt_remove_all(adev);
>   
> @@ -4323,8 +4330,11 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>   
>   	cancel_delayed_work_sync(&con->ras_counte_delay_work);
>   
> -	amdgpu_ras_set_context(adev, NULL);
> -	kfree(con);
> +out_free_context:
> +	if (con) {
> +		amdgpu_ras_set_context(adev, NULL);
> +		kfree(con);
> +	}
>   
>   	return 0;
>   }

