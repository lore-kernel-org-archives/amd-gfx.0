Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1B4EE208C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 12:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A179010E0C3;
	Fri,  6 Feb 2026 12:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2TnyflF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0A910E099
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 12:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJGyVGyfcAjxunTixgvomopMgSHQNZL3IChh4cdwG3Qds/E1oqwCdPCf+abSBP+TTjFhpTj4llV9lluK7iZdfOjGwpFKO/G1PyqgHBpTTASPTrAwcNjEIGF/7z2AZJhFqB5RBU/p69H2QEDAj8764RRhCP58qBzAz0nGaliHLKTz636bvVGr1YUopPRwXLlRyPn09tvGymNW3kJ1DszJrzZw9noDLjLhSC3GAGSpmpRJVsWSjay1ZTxN4GYI5EoAOxfxsdOGxD36Vfm3FalavuhJA/nyXoXW4ELeytb3SSsG9i/V2RRHRdV3NDk1X9HMycguGM4qVuhxpt/bTnbj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbOV4lnLjr7nviG9bVgyzZ0IfTdcU/9jvvP7o1HbPVY=;
 b=HeB6kSNT2ptILuLQoR5A6Fnw/TXsjBCWNDCXvOctwitx3T9hft6Pk4L8zkTy8oEZKlqD3d8/OK5HfQ3vLwof4DsfNjG69BhdGffeHYmmAWLOEfJ9pFha6FUab4/FiTwwDuEqVzWh1VsYmsP8Y7YIn8EtaIO+u/PjRdp4BXbcBoGOlYeYyln4b1WtO8clc6DqslVKbkB4U7dctEwTVCn+NWUo1CR+fvMLSkj1aVfKRDSMK+nOR1HhrpeRpCZbSkNJsUxmTRdLQMMwxGU6uN2B/GIoiwDib2JmZ5b5nkvg42siv9MXQexCE4Ess43d0TdCEk/97lYDG1lAL4dVhtfzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbOV4lnLjr7nviG9bVgyzZ0IfTdcU/9jvvP7o1HbPVY=;
 b=L2TnyflFnKXeI3yoh4huNAq8d+PcxTAbd3dJ8sBIZ/FeOPsHpk+nO9ntLX0g6dpHDysiJOXC3YY7KjioPOo9gU1P+9DUpqNE8tVaXOarjgfm4HQKuTDW23qEUT0letZaw2yVo3SG3xk0cH5vwCJz0bh/Cm92eE44YMKRwjObWrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 12:00:22 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 12:00:21 +0000
Content-Type: multipart/alternative;
 boundary="------------b8UTq5r62wLBBLuNIFImoDiY"
Message-ID: <7bb0d66d-b277-4fff-99e0-25c3dbc5834a@amd.com>
Date: Fri, 6 Feb 2026 17:30:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: rework amdgpu_userq_wait_ioctl v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260202125149.2067-7-christian.koenig@amd.com>
X-ClientProxiedBy: MA5PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd6708-9bd3-42de-1bca-08de65774dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3pNVVRyVkhaSERkNmRhZmxseWduYjVCTThzZWVlR0lidEVyS3U2bVBhOFVQ?=
 =?utf-8?B?NWhpQ0tSUkorZ2pqb2ZTR0hMSTNnaFJZR29OdTlXaThRV1dBNkZFMDFXeUtx?=
 =?utf-8?B?YVdRMXc5d04rd21nSjFDMEw2emlQVWYyL3FicG9qSmN5bm1CMFNMUGxFYlQz?=
 =?utf-8?B?YjZGWmtTZStFakVEZjZEYys3RXRaWXBnK3p4UUhpWGdST3JzaW12RkV5SCtK?=
 =?utf-8?B?MWZ0UDk0dHo1TDBjaWY2TXlPMzRYOFBSTlQ5NXdmUXN1b0tmZkRhVGRnZFJJ?=
 =?utf-8?B?MWkwWndTS2Rwd1paYzQ3dDBPaWdKbS9PWFhudXZyMkF4OW40S292eUo4R2l3?=
 =?utf-8?B?azNnQ2VuYmI0QXo4ekR6WFBFL2hva1dRSE41OWVBdEdObmRoYUFvUlZEeFZ0?=
 =?utf-8?B?VUhPUVJLS21KLzFYNG1wVDlQemZPZi9MVTIyVXlvaWxMT0pFMHNpTGdxY1ln?=
 =?utf-8?B?cGVqV0FuRHRPRHAxU2Z4VmpKZVhrdit4NUJHRE5veDdvVXM1YTlQVytGS3dV?=
 =?utf-8?B?ZFppcVE5d3FqTENudWJMcUY5Z2N5TnkybEpwSk1ocm52dlY0akZ5eUFvelVR?=
 =?utf-8?B?QXJSZ1IySE1FME4vaHlCNVNURUhxNk0rU0Q4UnJGSlk5K05nY3haK01qU2gz?=
 =?utf-8?B?TkRHenl1UHBkd2hhSHJrczN6NlFrN1ZhSG4yWXVNTDJKcUFwdnFYdGtMeEx5?=
 =?utf-8?B?S3JJOVVzSlVEWjdUOFhhQjNDK3V0ZEoyZ25va0NoYnZKclFjdk8vcmU5MFE5?=
 =?utf-8?B?ZUQ5bE9FczdQdWF3a0h2VGNlMFBnblFYUWRTVGhpaW9WWTdVYW5BK0pNUVJa?=
 =?utf-8?B?QWJqSThlc1NZc3VMMnVaSzRyWFQrbmVRQnhSSVN5all6Unhpd1VzNkorUjlr?=
 =?utf-8?B?OUNRUU1VS0h3YTBnVGxyWkZoMUFJdHBQZHZOVGp0azRmcGhXNXpmclFRYmo3?=
 =?utf-8?B?YkErbG50RE8wL1F1WW5IOTM5ZGt4aWszRHJ5YTJHWVk5ZHB5OVRLTzlGaDBU?=
 =?utf-8?B?eWcrUFZtZHFaQVI3bENyNERwdk9GNnNSa3ZUTlJMVXdhMWtXd0JxK0hQOCtW?=
 =?utf-8?B?RlFNQTd3TmlhS2piTDNMTTFNeUszaXRSWXdaUlRuMVAwQVhXMC9kZTAwTFZw?=
 =?utf-8?B?SlkvV0psaldNV2oxZ2pTaVVicDI5bTZhcGxDUGQ0aVhmb0N0U1BRcTByRW1q?=
 =?utf-8?B?eWRrMGJYbHJmRjAvd05oeVMyaW5rbThORlVCLzAxMUxHU1NHRk1YRUhURUxl?=
 =?utf-8?B?emJVQ0c3NVc5MDluSW1jZnpsTnFycHJqS1N5MVhPaU1idmxkV2Rrek4yc3Yv?=
 =?utf-8?B?dnZhd3dJTHNzUlAzV3V1R3MvRXVYd1hGNFBKZVhUejk0VUppUWJ6ODlZenBU?=
 =?utf-8?B?V1dYRnZSc2FOV3ltOGNOUXhzNHFSdUNDRDkwWWgwY1V6MkFqWURSc1RsUmo1?=
 =?utf-8?B?bnY1ejRrbFNBWUxYUVgxaXd0UHZ0eENtbzMxc3V4TnU3Z1A3WER5MGhyOU16?=
 =?utf-8?B?enhLYmtyRlVMTytGeW95ZUZkaVhyajRpSE5JNW8xcUFTSk1YUDIxY0wrRi9H?=
 =?utf-8?B?ZC9ybXRZWWxBU3BDOS9WTTVnUzUxbHR5R2VNb1ZNcEhCaDMrVkV1T2UwdUtG?=
 =?utf-8?B?K3oyNFFxN0lncXg0cDh0NG5iZmsrL1AvdzlWckRwMDVkT3FHZy9iZE90OEIz?=
 =?utf-8?B?WmI2RWdZRmFJektoV3J1M2NPLy9sdmEzdGY1V2V4ajBOR1ZMVFM1L0phMU9R?=
 =?utf-8?B?c1ljM3JST2tuTVZrUE5QWWdNU1RCZU9rWGY1c0FFdXA1Unp5Tmd0MkE2S2pr?=
 =?utf-8?B?Z04wcGZYUHdKR3NybUlTZk5pTUxJVWpVMjdhTWR0UzczM1RnQ2pGM1FLTVhi?=
 =?utf-8?B?WUxCUFJ6N3lhME00UnhiYVRjb0tVVEg0QmllbnpiMjV4b2VabDlRajdaenN2?=
 =?utf-8?B?d0dWbXQ1K284b2svTkx0V3FKWnk3WHkyaXh5ZnBKUHJyNnFEem9tODBvWHZ4?=
 =?utf-8?B?cWF1MDA4TEhObTlJaWtHR1JhcWhFMlMrZ1Rub29mWE9zQUJQeDZtdXMyRzli?=
 =?utf-8?B?aW5FVmVqM2ZyTGlTaGtaaGhONHlPNmR3TXhIK2s5UDBLU0RGVUh4VXlZeGVr?=
 =?utf-8?Q?BrIM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJJT21ja3NaUWNiUWY3aFFEUys4MUcvdU1IRmtGU3gvZmxwSDlkblpCeEVx?=
 =?utf-8?B?RkRDWGpJUXgvTUFWZ0lQTlFMb1pKSmRyOGhsZlFzaGRvdGxZUGt0MHM3SVRo?=
 =?utf-8?B?SlJBZ3JRSzVqUzFnUXRtOCtWTHdDWUFDdHQ4d3ZDUHhDczBZa1FlZjZ1cU1z?=
 =?utf-8?B?NDlIUW9kZlZhRHVYOVgxRjltZHJ6QXQrL0J4TDd0UU9Yc1Fwd04wbjZXVTA4?=
 =?utf-8?B?S1dlMytDTzhZVDllZmJmZUlnZmdmMGg4TlZaVnJKZmJGRFkzcDlTWXhpUlhi?=
 =?utf-8?B?aXgwZE4wQUE2WS82WHgzL1FhMVFTaUNpZTZBV2RuYjN0OTRnOFZweFBLSjVS?=
 =?utf-8?B?cDRIdUk2Q2sxMStZRzRkZXdvMEs3Rm1hVGZ5VDZja0RqK2psc0o1RktKLzNh?=
 =?utf-8?B?UUhJMmU0N2lYRXFWbWQwY2I2SVI3TVMzTVdvelhmVGh4TmFhQWREcVpKVC9L?=
 =?utf-8?B?SXdhemJZT05EMEpyVGpQUjFTcERoNk9RbWxKcDBYcEZLVXhrL09oN29qL2Ju?=
 =?utf-8?B?WnNLMEhhcGtHNFo0Rnc0UUN0Si9Xc3VmaktWNzlyZVZROWhVZDdlRHE3YzZJ?=
 =?utf-8?B?M3NRT2dpaHN3UVd0NjN4QkV5ZE9qa0NreDBJY1JqMGtTVUxKaDB3dEJUTjhG?=
 =?utf-8?B?NzJTR0hMRFVMUEFxRjJ4Zm94MFptMXdwTEdKMFZPUWpqMzA4RE1WdmRUZEVP?=
 =?utf-8?B?a05iWWRCZ1E2bFBUTmk5eGJWVWt0K3pUQkxkN3VQVUFFVEVQdmdkaE1hOWdp?=
 =?utf-8?B?UFdLcWkxTlFlMS96WmtPNXdOdm1BWmNnYWZtRWZ4MnNOckw5VjVqV0xBTU8z?=
 =?utf-8?B?ckxIZ0tsNGtYd1BlM0UvLyt2eFpXYnZ2V0xXWDBRR2E1T1VTQWVUL05jVm5o?=
 =?utf-8?B?RDkva21BMFBNdGtISDJsTVo0MUp6VE01UVkvVkc4KzlXVFlSdjlGOXhwU2hT?=
 =?utf-8?B?MFd5Z09kUXZzbmtxVDIyNEk2SlVxU2kvSDRGejhreVFRYzdaMU9SeGpzTnZV?=
 =?utf-8?B?d0VOTmRwNWVNSVdvNDl4MjF6bHhpN1hIS3ZrYlFRdXpVS0Z4T1VkODlRRDB3?=
 =?utf-8?B?UVp4VUd6QlBXVzdORGhkaXVVRjdybjB0eEk1RmlOaFhrVVJNV1Rrd1YxZDdC?=
 =?utf-8?B?UURncjVBNmYwTi9RbVdlbFRULzA5VmNoM0VKZFc5SXNOeWJWMjFOV243ZE1m?=
 =?utf-8?B?elZUcmkydUdZWFZKaE1td01hblR4MkpiZmtjMWZhUHpaRTBBUnVDb3hwWVpG?=
 =?utf-8?B?TkVaNHhBSHplRGJ6RGNiQTQ0NXYvNW5DQ2M0emRBWTJPK1JTUGpBOU5meVBP?=
 =?utf-8?B?OWN1bFVEQlQrTkw0Z0VFR0JlMUxMMXBSK0JXNUxEdXRaWXdLUzBaQVp4cDVp?=
 =?utf-8?B?cWNQZXhvZEYvbWsxV3RZSi9LUzdnUGlYbEoyTXhYampXS3Z4ZUJ2clpndS82?=
 =?utf-8?B?ZEZWdk80RHpDVnVaL1ZXakU3UWdvN0J3V21hRXZheFFMdlN3cElYZWc5OEdW?=
 =?utf-8?B?OENUZ1h4d3lwTUdVZCs1UWRjS1BhdDYybldQNmZnKzNVdlByZnZhWXN4dEZu?=
 =?utf-8?B?cTRGMTZsdGdJaWd1Rjd3S1B6aGw5eWpFNDRuaTN5R3BPamIxWkc4VGowanZ0?=
 =?utf-8?B?ZkIra3JYaE9kd2UzcVVDZEtmQmZZSVpadlJ1eVN1Z3V1T0RSYzllSVZSZWln?=
 =?utf-8?B?OU5GcEFFSnljeEhRdnp2NlExUG0vSFJxYnhlVUNTTVpuZXoxbWNnTExZSXB1?=
 =?utf-8?B?b1V6L3F5eDJwVUZIMnBKR3krdWpxMmRwc0VsRWluTnFyRkloYmxaUjBiNThH?=
 =?utf-8?B?QXZIcmRMeUdaN3M0YVZzQjVscE1Ua0lVVHBaNVo0K1k1YnBVR2FRaHFCalRL?=
 =?utf-8?B?dlhleTc4S045NmR6cG5jQ0ZIbEFYYVg4eXlXa0VwQlIxeDY3R0Zwa2ZJNUt5?=
 =?utf-8?B?bklrbFlra3BMQS8rbzJFZWpUbEFLdS9tNXBjMDFzQzAyK2ZmL1BXSjk3SjVT?=
 =?utf-8?B?ZFF5YmNxbnlrcUdLbmZLZ3JiM1VMRWV6bHpBZnVQQWQ0cnFyTGhNN2dmckkz?=
 =?utf-8?B?RFM4cVRIOTJ0MjM2RVhuUUtweHg5VHpPSmxQTnBiSDByczlRcTNOeUxnUlhP?=
 =?utf-8?B?SVhHY3dIMkU0NFhINVNhWXU1MUtCcVRIVVE5QTNFUXRvMVFiSXNhbnpTS2xX?=
 =?utf-8?B?L1dNQUJ5Mm1PSGptOFJSdkhoWWZ5S0wwS3VPaEg1VmkvMDlpRUgyNGtlb2x1?=
 =?utf-8?B?YXRtOERYU2owcFVoQkR4V1RSQTI3R0N6bU5WUnBPc0ZUNWxTK2hKVGtBTm13?=
 =?utf-8?B?VHE0Mk9JL1B4REUxZEoyNUJrSE9sdGFqb1dlS1Z6eEo1cVVTY0M2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd6708-9bd3-42de-1bca-08de65774dcf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 12:00:21.7874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9EdbsKeQpjwg9n7tmQ6d2tiZ+/I3Ce7AsG8L9qMjqa5FfmCxmCluTcaWVYl1xTBYfSD/peRaSeM3DDnvQr4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

--------------b8UTq5r62wLBBLuNIFImoDiY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02-02-2026 06:21 pm, Christian König wrote:
> Lockdep was complaining about a number of issues here. Especially lock
> inversion between syncobj, dma_resv and copying things into userspace.
>
> Rework the functionality. Split it up into multiple functions,
> consistenly use memdup_array_user(), fix the lock inversions and a few
> more bugs in error handling.
>
> v2: drop the dma_fence leak fix, turned out that was actually correct,
>      just not well documented. Apply some more cleanup suggestion from
>      Tvrtko.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 614 +++++++++---------
>   1 file changed, 319 insertions(+), 295 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 212056d4ddf0..da329d00843b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -645,368 +645,397 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> -			    struct drm_file *filp)
> +/* Count the number of expected fences so userspace can alloc a buffer */
> +static int
> +amdgpu_userq_wait_count_fences(struct drm_file *filp,
> +			       struct drm_amdgpu_userq_wait *wait_info,
> +			       u32 *syncobj_handles, u32 *timeline_points,
> +			       u32 *timeline_handles,
> +			       struct drm_gem_object **gobj_write,
> +			       struct drm_gem_object **gobj_read)
>   {
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
> -	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
> -	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> -	struct drm_amdgpu_userq_wait *wait_info = data;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct amdgpu_usermode_queue *waitq;
> -	struct drm_gem_object **gobj_write;
> -	struct drm_gem_object **gobj_read;
> -	struct dma_fence **fences = NULL;
> -	u16 num_points, num_fences = 0;
> -	int r, i, rentry, wentry, cnt;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct dma_fence_unwrap iter;
> +	struct dma_fence *fence, *f;
> +	unsigned int num_fences = 0;
>   	struct drm_exec exec;
> +	int i, r;
> +
> +	/*
> +	 * This needs to be outside of the lock provided by drm_exec for
> +	 * DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to work correctly.
> +	 */
> +
> +	/* Count timeline fences */
> +	for (i = 0; i < wait_info->num_syncobj_timeline_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
> +
> +		dma_fence_unwrap_for_each(f, &iter, fence)
> +			num_fences++;
>   
> -	if (!amdgpu_userq_enabled(dev))
> -		return -ENOTSUPP;
> +		dma_fence_put(fence);
> +	}
>   
> -	num_read_bo_handles = wait_info->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
> -				      size_mul(sizeof(u32), num_read_bo_handles));
> -	if (IS_ERR(bo_handles_read))
> -		return PTR_ERR(bo_handles_read);
> +	/* Count boolean fences */
> +	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
>   
> -	num_write_bo_handles = wait_info->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
> -				       size_mul(sizeof(u32), num_write_bo_handles));
> -	if (IS_ERR(bo_handles_write)) {
> -		r = PTR_ERR(bo_handles_write);
> -		goto free_bo_handles_read;
> +		num_fences++;
> +		dma_fence_put(fence);
>   	}
>   
> -	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj));
> -	if (IS_ERR(syncobj_handles)) {
> -		r = PTR_ERR(syncobj_handles);
> -		goto free_bo_handles_write;
> -	}
> +	/* Lock all the GEM objects */
> +	/* TODO: It is actually not necessary to lock them */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -				       sizeof(u32) * num_points);
> -	if (IS_ERR(timeline_handles)) {
> -		r = PTR_ERR(timeline_handles);
> -		goto free_syncobj_handles;
> -	}
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
>   
> -	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -				      sizeof(u32) * num_points);
> -	if (IS_ERR(timeline_points)) {
> -		r = PTR_ERR(timeline_points);
> -		goto free_timeline_handles;
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
>   	}
>   
> -	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> -	if (!gobj_read) {
> -		r = -ENOMEM;
> -		goto free_timeline_points;
> -	}
> +	/* Count read fences */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> -		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> -		if (!gobj_read[rentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_read;
> -		}
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence)
> +			num_fences++;
>   	}
>   
> -	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> -	if (!gobj_write) {
> -		r = -ENOMEM;
> -		goto put_gobj_read;
> -	}
> +	/* Count write fences */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> -		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> -		if (!gobj_write[wentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_write;
> -		}
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence)
> +			num_fences++;
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +	wait_info->num_fences = num_fences;
> +	r = 0;
>   
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -	}
> +error_unlock:
> +	/* Unlock all the GEM objects */
> +	drm_exec_fini(&exec);
> +	return r;
> +}
>   
> -	if (!wait_info->num_fences) {
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto exec_fini;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence)
> -					num_fences++;
> -
> -				dma_fence_put(fence);
> -			}
> -		}
> +static int
> +amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +				    struct drm_amdgpu_userq_wait *wait_info,
> +				    u32 *syncobj_handles, u32 *timeline_points,
> +				    u32 *timeline_handles,
> +				    struct drm_gem_object **gobj_write,
> +				    struct drm_gem_object **gobj_read)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_fence_info *fence_info;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct amdgpu_usermode_queue *waitq;
> +	struct dma_fence **fences, *fence, *f;
> +	struct dma_fence_unwrap iter;
> +	int num_points, num_syncobj;
> +	unsigned int num_fences = 0;
> +	struct drm_exec exec;
> +	int i, cnt, r;
>   
> -		/* Count syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
> +				   GFP_KERNEL);
> +	if (!fence_info)
> +		return -ENOMEM;
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto exec_fini;
> +	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
> +			       GFP_KERNEL);
> +	if (!fences) {
> +		r = -ENOMEM;
> +		goto free_fence_info;
> +	}
>   
> -			num_fences++;
> -			dma_fence_put(fence);
> -		}
> +	/* Retrieve timeline fences */
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	for (i = 0; i < num_points; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -		/* Count GEM objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_unwrap_for_each(f, &iter, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence)
> -				num_fences++;
> +			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_put(fence);
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence)
> -				num_fences++;
> -		}
> +	/* Retrieve boolean fences */
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	for (i = 0; i < num_syncobj; i++) {
> +		struct dma_fence *fence;
>   
> -		/*
> -		 * Passing num_fences = 0 means that userspace doesn't want to
> -		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> -		 * userq_fence_info and return the actual number of fences on
> -		 * args->num_fences.
> -		 */
> -		wait_info->num_fences = num_fences;
> -	} else {
> -		/* Array of fence info */
> -		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> -		if (!fence_info) {
> -			r = -ENOMEM;
> -			goto exec_fini;
> -		}
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -		/* Array of fences */
> -		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> -		if (!fences) {
> -			r = -ENOMEM;
> -			goto free_fence_info;
> +		if (num_fences >= wait_info->num_fences) {
> +			r = -EINVAL;
> +			goto free_fences;
>   		}
>   
> -		/* Retrieve GEM read objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		/* Give the reference to the fence array */
> +		fences[num_fences++] = fence;
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +	/* Lock all the GEM objects */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> -			}
> -		}
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
>   
> -		/* Retrieve GEM write objects fence */
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +	/* Retrieve GEM read objects fence */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto error_unlock;
>   			}
> -		}
>   
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto free_fences;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence) {
> -					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> -						r = -EINVAL;
> -						goto free_fences;
> -					}
> -
> -					dma_fence_get(f);
> -					fences[num_fences++] = f;
> -				}
> -
> -				dma_fence_put(fence);
> -			}
> +			fences[num_fences++] = dma_fence_get(fence);
>   		}
> +	}
>   
> -		/* Retrieve syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> -
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto free_fences;
> +	/* Retrieve GEM write objects fence */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence) {
> +			if (num_fences >= wait_info->num_fences) {
>   				r = -EINVAL;
> -				goto free_fences;
> +				goto error_unlock;
>   			}
>   
> -			fences[num_fences++] = fence;
> +			fences[num_fences++] = dma_fence_get(fence);
>   		}
> +	}
>   
> -		/*
> -		 * Keep only the latest fences to reduce the number of values
> -		 * given back to userspace.
> -		 */
> -		num_fences = dma_fence_dedup_array(fences, num_fences);
> +	drm_exec_fini(&exec);
>   
> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> -		if (!waitq) {
> -			r = -EINVAL;
> -			goto free_fences;
> -		}
> +	/*
> +	 * Keep only the latest fences to reduce the number of values
> +	 * given back to userspace.
> +	 */
> +	num_fences = dma_fence_dedup_array(fences, num_fences);
>   
> -		for (i = 0, cnt = 0; i < num_fences; i++) {
> -			struct amdgpu_userq_fence_driver *fence_drv;
> -			struct amdgpu_userq_fence *userq_fence;
> -			u32 index;
> -
> -			userq_fence = to_amdgpu_userq_fence(fences[i]);
> -			if (!userq_fence) {
> -				/*
> -				 * Just waiting on other driver fences should
> -				 * be good for now
> -				 */
> -				r = dma_fence_wait(fences[i], true);
> -				if (r) {
> -					dma_fence_put(fences[i]);
> -					goto free_fences;
> -				}
> +	waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> +	if (!waitq) {
> +		r = -EINVAL;
> +		goto free_fences;
> +	}
>   
> -				dma_fence_put(fences[i]);
> -				continue;
> -			}
> +	for (i = 0, cnt = 0; i < num_fences; i++) {
> +		struct amdgpu_userq_fence_driver *fence_drv;
> +		struct amdgpu_userq_fence *userq_fence;
> +		u32 index;
>   
> -			fence_drv = userq_fence->fence_drv;
> +		userq_fence = to_amdgpu_userq_fence(fences[i]);
> +		if (!userq_fence) {
>   			/*
> -			 * We need to make sure the user queue release their reference
> -			 * to the fence drivers at some point before queue destruction.
> -			 * Otherwise, we would gather those references until we don't
> -			 * have any more space left and crash.
> +			 * Just waiting on other driver fences should
> +			 * be good for now
>   			 */
> -			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> -				     xa_limit_32b, GFP_KERNEL);
> -			if (r)
> +			r = dma_fence_wait(fences[i], true);
> +			if (r) {
> +				dma_fence_put(fences[i]);
>   				goto free_fences;
> -
> -			amdgpu_userq_fence_driver_get(fence_drv);
> -
> -			/* Store drm syncobj's gpu va address and value */
> -			fence_info[cnt].va = fence_drv->va;
> -			fence_info[cnt].value = fences[i]->seqno;
> +			}
>   
>   			dma_fence_put(fences[i]);
> -			/* Increment the actual userq fence count */
> -			cnt++;
> +			continue;
>   		}
>   
> -		wait_info->num_fences = cnt;
> -		/* Copy userq fence info to user space */
> -		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> -				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> -			r = -EFAULT;
> +		fence_drv = userq_fence->fence_drv;
> +		/*
> +		 * We need to make sure the user queue release their reference
> +		 * to the fence drivers at some point before queue destruction.
> +		 * Otherwise, we would gather those references until we don't
> +		 * have any more space left and crash.
> +		 */
> +		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
>   			goto free_fences;
> -		}
>   
> -		kfree(fences);
> -		kfree(fence_info);
> -	}
> +		amdgpu_userq_fence_driver_get(fence_drv);
>   
> -	drm_exec_fini(&exec);
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +		/* Store drm syncobj's gpu va address and value */
> +		fence_info[cnt].va = fence_drv->va;
> +		fence_info[cnt].value = fences[i]->seqno;
>   
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +		dma_fence_put(fences[i]);
> +		/* Increment the actual userq fence count */
> +		cnt++;
> +	}
> +	/* The refcount in the array is already decremented */
> +	num_fences = 0;
>   
> -	kfree(timeline_points);
> -	kfree(timeline_handles);
> -	kfree(syncobj_handles);
> -	kfree(bo_handles_write);
> -	kfree(bo_handles_read);
> +	wait_info->num_fences = cnt;
> +	r = 0;
>   
> -	return 0;
> +	/* Copy userq fence info to user space */
> +	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> +			 fence_info, cnt * sizeof(*fence_info))) {
> +		r = -EFAULT;
> +	}
>   
>   free_fences:
> -	while (num_fences-- > 0)
> +	while (num_fences--)
>   		dma_fence_put(fences[num_fences]);
>   	kfree(fences);
> +
>   free_fence_info:
>   	kfree(fence_info);
> -exec_fini:
> +	return r;
> +
> +error_unlock:
>   	drm_exec_fini(&exec);
> -put_gobj_write:
> -	while (wentry-- > 0)
> -		drm_gem_object_put(gobj_write[wentry]);
> +	goto free_fences;
> +}
> +
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct drm_gem_object **gobj_write;
> +	struct drm_gem_object **gobj_read;
> +	void __user *ptr;
> +	int r;
> +
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
> +	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
> +	timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_handles)) {
> +		r = PTR_ERR(timeline_handles);
> +		goto free_syncobj_handles;
> +	}
> +
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
> +	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_points)) {
> +		r = PTR_ERR(timeline_points);
> +		goto free_timeline_handles;
> +	}
> +
> +	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read),
> +				  GFP_KERNEL);
memory is allocated for gobj_read before initializing num_read_bo_handle 
which is done later.
> +	if (!gobj_read) {
> +		r = -ENOMEM;
> +		goto free_timeline_points;
> +	}
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_read_handles);
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
> +	if (r)
> +		goto free_timeline_points;
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_write_handles);
> +	num_write_bo_handles = wait_info->num_bo_write_handles;

No memory allocated here for gobj_write before using that.

Regards
Sunil khatri

> +	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
> +				   &gobj_write);
> +	if (r)
> +		goto put_gobj_read;
> +
> +	/*
> +	 * Passing num_fences = 0 means that userspace doesn't want to
> +	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +	 * userq_fence_info and return the actual number of fences on
> +	 * args->num_fences.
> +	 */
> +	if (!wait_info->num_fences) {
> +		r = amdgpu_userq_wait_count_fences(filp, wait_info,
> +						   syncobj_handles,
> +						   timeline_points,
> +						   timeline_handles,
> +						   gobj_write,
> +						   gobj_read);
> +	} else {
> +		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +							syncobj_handles,
> +							timeline_points,
> +							timeline_handles,
> +							gobj_write,
> +							gobj_read);
> +	}
> +
> +	while (num_write_bo_handles--)
> +		drm_gem_object_put(gobj_write[num_write_bo_handles]);
>   	kfree(gobj_write);
>   put_gobj_read:
> -	while (rentry-- > 0)
> -		drm_gem_object_put(gobj_read[rentry]);
> +	while (num_read_bo_handles--)
> +		drm_gem_object_put(gobj_read[num_read_bo_handles]);
>   	kfree(gobj_read);
>   free_timeline_points:
>   	kfree(timeline_points);
> @@ -1014,10 +1043,5 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -free_bo_handles_write:
> -	kfree(bo_handles_write);
> -free_bo_handles_read:
> -	kfree(bo_handles_read);
> -
>   	return r;
>   }
--------------b8UTq5r62wLBBLuNIFImoDiY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 02-02-2026 06:21 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260202125149.2067-7-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Lockdep was complaining about a number of issues here. Especially lock
inversion between syncobj, dma_resv and copying things into userspace.

Rework the functionality. Split it up into multiple functions,
consistenly use memdup_array_user(), fix the lock inversions and a few
more bugs in error handling.

v2: drop the dma_fence leak fix, turned out that was actually correct,
    just not well documented. Apply some more cleanup suggestion from
    Tvrtko.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 614 +++++++++---------
 1 file changed, 319 insertions(+), 295 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 212056d4ddf0..da329d00843b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -645,368 +645,397 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
+/* Count the number of expected fences so userspace can alloc a buffer */
+static int
+amdgpu_userq_wait_count_fences(struct drm_file *filp,
+			       struct drm_amdgpu_userq_wait *wait_info,
+			       u32 *syncobj_handles, u32 *timeline_points,
+			       u32 *timeline_handles,
+			       struct drm_gem_object **gobj_write,
+			       struct drm_gem_object **gobj_read)
 {
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
-	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
-	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
-	struct drm_amdgpu_userq_wait *wait_info = data;
-	struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
-	struct amdgpu_userq_mgr *userq_mgr = &amp;fpriv-&gt;userq_mgr;
-	struct amdgpu_usermode_queue *waitq;
-	struct drm_gem_object **gobj_write;
-	struct drm_gem_object **gobj_read;
-	struct dma_fence **fences = NULL;
-	u16 num_points, num_fences = 0;
-	int r, i, rentry, wentry, cnt;
+	int num_read_bo_handles, num_write_bo_handles;
+	struct dma_fence_unwrap iter;
+	struct dma_fence *fence, *f;
+	unsigned int num_fences = 0;
 	struct drm_exec exec;
+	int i, r;
+
+	/*
+	 * This needs to be outside of the lock provided by drm_exec for
+	 * DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to work correctly.
+	 */
+
+	/* Count timeline fences */
+	for (i = 0; i &lt; wait_info-&gt;num_syncobj_timeline_handles; i++) {
+		r = drm_syncobj_find_fence(filp, timeline_handles[i],
+					   timeline_points[i],
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &amp;fence);
+		if (r)
+			return r;
+
+		dma_fence_unwrap_for_each(f, &amp;iter, fence)
+			num_fences++;
 
-	if (!amdgpu_userq_enabled(dev))
-		return -ENOTSUPP;
+		dma_fence_put(fence);
+	}
 
-	num_read_bo_handles = wait_info-&gt;num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info-&gt;bo_read_handles),
-				      size_mul(sizeof(u32), num_read_bo_handles));
-	if (IS_ERR(bo_handles_read))
-		return PTR_ERR(bo_handles_read);
+	/* Count boolean fences */
+	for (i = 0; i &lt; wait_info-&gt;num_syncobj_handles; i++) {
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &amp;fence);
+		if (r)
+			return r;
 
-	num_write_bo_handles = wait_info-&gt;num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info-&gt;bo_write_handles),
-				       size_mul(sizeof(u32), num_write_bo_handles));
-	if (IS_ERR(bo_handles_write)) {
-		r = PTR_ERR(bo_handles_write);
-		goto free_bo_handles_read;
+		num_fences++;
+		dma_fence_put(fence);
 	}
 
-	num_syncobj = wait_info-&gt;num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info-&gt;syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj));
-	if (IS_ERR(syncobj_handles)) {
-		r = PTR_ERR(syncobj_handles);
-		goto free_bo_handles_write;
-	}
+	/* Lock all the GEM objects */
+	/* TODO: It is actually not necessary to lock them */
+	num_read_bo_handles = wait_info-&gt;num_bo_read_handles;
+	num_write_bo_handles = wait_info-&gt;num_bo_write_handles;
+	drm_exec_init(&amp;exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      num_read_bo_handles + num_write_bo_handles);
 
-	num_points = wait_info-&gt;num_syncobj_timeline_handles;
-	timeline_handles = memdup_user(u64_to_user_ptr(wait_info-&gt;syncobj_timeline_handles),
-				       sizeof(u32) * num_points);
-	if (IS_ERR(timeline_handles)) {
-		r = PTR_ERR(timeline_handles);
-		goto free_syncobj_handles;
-	}
+	drm_exec_until_all_locked(&amp;exec) {
+		r = drm_exec_prepare_array(&amp;exec, gobj_read,
+					   num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r)
+			goto error_unlock;
 
-	timeline_points = memdup_user(u64_to_user_ptr(wait_info-&gt;syncobj_timeline_points),
-				      sizeof(u32) * num_points);
-	if (IS_ERR(timeline_points)) {
-		r = PTR_ERR(timeline_points);
-		goto free_timeline_handles;
+		r = drm_exec_prepare_array(&amp;exec, gobj_write,
+					   num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r)
+			goto error_unlock;
 	}
 
-	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
-	if (!gobj_read) {
-		r = -ENOMEM;
-		goto free_timeline_points;
-	}
+	/* Count read fences */
+	for (i = 0; i &lt; num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-	for (rentry = 0; rentry &lt; num_read_bo_handles; rentry++) {
-		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
-		if (!gobj_read[rentry]) {
-			r = -ENOENT;
-			goto put_gobj_read;
-		}
+		dma_resv_for_each_fence(&amp;resv_cursor, gobj_read[i]-&gt;resv,
+					DMA_RESV_USAGE_READ, fence)
+			num_fences++;
 	}
 
-	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
-	if (!gobj_write) {
-		r = -ENOMEM;
-		goto put_gobj_read;
-	}
+	/* Count write fences */
+	for (i = 0; i &lt; num_write_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-	for (wentry = 0; wentry &lt; num_write_bo_handles; wentry++) {
-		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
-		if (!gobj_write[wentry]) {
-			r = -ENOENT;
-			goto put_gobj_write;
-		}
+		dma_resv_for_each_fence(&amp;resv_cursor, gobj_write[i]-&gt;resv,
+					DMA_RESV_USAGE_WRITE, fence)
+			num_fences++;
 	}
 
-	drm_exec_init(&amp;exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&amp;exec) {
-		r = drm_exec_prepare_array(&amp;exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&amp;exec);
-		if (r) {
-			drm_exec_fini(&amp;exec);
-			goto put_gobj_write;
-		}
+	wait_info-&gt;num_fences = num_fences;
+	r = 0;
 
-		r = drm_exec_prepare_array(&amp;exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&amp;exec);
-		if (r) {
-			drm_exec_fini(&amp;exec);
-			goto put_gobj_write;
-		}
-	}
+error_unlock:
+	/* Unlock all the GEM objects */
+	drm_exec_fini(&amp;exec);
+	return r;
+}
 
-	if (!wait_info-&gt;num_fences) {
-		if (num_points) {
-			struct dma_fence_unwrap iter;
-			struct dma_fence *fence;
-			struct dma_fence *f;
-
-			for (i = 0; i &lt; num_points; i++) {
-				r = drm_syncobj_find_fence(filp, timeline_handles[i],
-							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-							   &amp;fence);
-				if (r)
-					goto exec_fini;
-
-				dma_fence_unwrap_for_each(f, &amp;iter, fence)
-					num_fences++;
-
-				dma_fence_put(fence);
-			}
-		}
+static int
+amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
+				    struct drm_amdgpu_userq_wait *wait_info,
+				    u32 *syncobj_handles, u32 *timeline_points,
+				    u32 *timeline_handles,
+				    struct drm_gem_object **gobj_write,
+				    struct drm_gem_object **gobj_read)
+{
+	struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &amp;fpriv-&gt;userq_mgr;
+	struct drm_amdgpu_userq_fence_info *fence_info;
+	int num_read_bo_handles, num_write_bo_handles;
+	struct amdgpu_usermode_queue *waitq;
+	struct dma_fence **fences, *fence, *f;
+	struct dma_fence_unwrap iter;
+	int num_points, num_syncobj;
+	unsigned int num_fences = 0;
+	struct drm_exec exec;
+	int i, cnt, r;
 
-		/* Count syncobj's fence */
-		for (i = 0; i &lt; num_syncobj; i++) {
-			struct dma_fence *fence;
+	fence_info = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fence_info),
+				   GFP_KERNEL);
+	if (!fence_info)
+		return -ENOMEM;
 
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &amp;fence);
-			if (r)
-				goto exec_fini;
+	fences = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fences),
+			       GFP_KERNEL);
+	if (!fences) {
+		r = -ENOMEM;
+		goto free_fence_info;
+	}
 
-			num_fences++;
-			dma_fence_put(fence);
-		}
+	/* Retrieve timeline fences */
+	num_points = wait_info-&gt;num_syncobj_timeline_handles;
+	for (i = 0; i &lt; num_points; i++) {
+		r = drm_syncobj_find_fence(filp, timeline_handles[i],
+					   timeline_points[i],
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &amp;fence);
+		if (r)
+			goto free_fences;
 
-		/* Count GEM objects fence */
-		for (i = 0; i &lt; num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		dma_fence_unwrap_for_each(f, &amp;iter, fence) {
+			if (num_fences &gt;= wait_info-&gt;num_fences) {
+				r = -EINVAL;
+				goto free_fences;
+			}
 
-			dma_resv_for_each_fence(&amp;resv_cursor, gobj_read[i]-&gt;resv,
-						DMA_RESV_USAGE_READ, fence)
-				num_fences++;
+			fences[num_fences++] = dma_fence_get(f);
 		}
 
-		for (i = 0; i &lt; num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		dma_fence_put(fence);
+	}
 
-			dma_resv_for_each_fence(&amp;resv_cursor, gobj_write[i]-&gt;resv,
-						DMA_RESV_USAGE_WRITE, fence)
-				num_fences++;
-		}
+	/* Retrieve boolean fences */
+	num_syncobj = wait_info-&gt;num_syncobj_handles;
+	for (i = 0; i &lt; num_syncobj; i++) {
+		struct dma_fence *fence;
 
-		/*
-		 * Passing num_fences = 0 means that userspace doesn't want to
-		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
-		 * userq_fence_info and return the actual number of fences on
-		 * args-&gt;num_fences.
-		 */
-		wait_info-&gt;num_fences = num_fences;
-	} else {
-		/* Array of fence info */
-		fence_info = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fence_info), GFP_KERNEL);
-		if (!fence_info) {
-			r = -ENOMEM;
-			goto exec_fini;
-		}
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &amp;fence);
+		if (r)
+			goto free_fences;
 
-		/* Array of fences */
-		fences = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fences), GFP_KERNEL);
-		if (!fences) {
-			r = -ENOMEM;
-			goto free_fence_info;
+		if (num_fences &gt;= wait_info-&gt;num_fences) {
+			r = -EINVAL;
+			goto free_fences;
 		}
 
-		/* Retrieve GEM read objects fence */
-		for (i = 0; i &lt; num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		/* Give the reference to the fence array */
+		fences[num_fences++] = fence;
+	}
 
-			dma_resv_for_each_fence(&amp;resv_cursor, gobj_read[i]-&gt;resv,
-						DMA_RESV_USAGE_READ, fence) {
-				if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	/* Lock all the GEM objects */
+	num_read_bo_handles = wait_info-&gt;num_bo_read_handles;
+	num_write_bo_handles = wait_info-&gt;num_bo_write_handles;
+	drm_exec_init(&amp;exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      num_read_bo_handles + num_write_bo_handles);
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
-		}
+	drm_exec_until_all_locked(&amp;exec) {
+		r = drm_exec_prepare_array(&amp;exec, gobj_read,
+					   num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r)
+			goto error_unlock;
 
-		/* Retrieve GEM write objects fence */
-		for (i = 0; i &lt; num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		r = drm_exec_prepare_array(&amp;exec, gobj_write,
+					   num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r)
+			goto error_unlock;
+	}
 
-			dma_resv_for_each_fence(&amp;resv_cursor, gobj_write[i]-&gt;resv,
-						DMA_RESV_USAGE_WRITE, fence) {
-				if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	/* Retrieve GEM read objects fence */
+	for (i = 0; i &lt; num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
+		dma_resv_for_each_fence(&amp;resv_cursor, gobj_read[i]-&gt;resv,
+					DMA_RESV_USAGE_READ, fence) {
+			if (num_fences &gt;= wait_info-&gt;num_fences) {
+				r = -EINVAL;
+				goto error_unlock;
 			}
-		}
 
-		if (num_points) {
-			struct dma_fence_unwrap iter;
-			struct dma_fence *fence;
-			struct dma_fence *f;
-
-			for (i = 0; i &lt; num_points; i++) {
-				r = drm_syncobj_find_fence(filp, timeline_handles[i],
-							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-							   &amp;fence);
-				if (r)
-					goto free_fences;
-
-				dma_fence_unwrap_for_each(f, &amp;iter, fence) {
-					if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
-						r = -EINVAL;
-						goto free_fences;
-					}
-
-					dma_fence_get(f);
-					fences[num_fences++] = f;
-				}
-
-				dma_fence_put(fence);
-			}
+			fences[num_fences++] = dma_fence_get(fence);
 		}
+	}
 
-		/* Retrieve syncobj's fence */
-		for (i = 0; i &lt; num_syncobj; i++) {
-			struct dma_fence *fence;
-
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &amp;fence);
-			if (r)
-				goto free_fences;
+	/* Retrieve GEM write objects fence */
+	for (i = 0; i &lt; num_write_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-			if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
+		dma_resv_for_each_fence(&amp;resv_cursor, gobj_write[i]-&gt;resv,
+					DMA_RESV_USAGE_WRITE, fence) {
+			if (num_fences &gt;= wait_info-&gt;num_fences) {
 				r = -EINVAL;
-				goto free_fences;
+				goto error_unlock;
 			}
 
-			fences[num_fences++] = fence;
+			fences[num_fences++] = dma_fence_get(fence);
 		}
+	}
 
-		/*
-		 * Keep only the latest fences to reduce the number of values
-		 * given back to userspace.
-		 */
-		num_fences = dma_fence_dedup_array(fences, num_fences);
+	drm_exec_fini(&amp;exec);
 
-		waitq = xa_load(&amp;userq_mgr-&gt;userq_xa, wait_info-&gt;waitq_id);
-		if (!waitq) {
-			r = -EINVAL;
-			goto free_fences;
-		}
+	/*
+	 * Keep only the latest fences to reduce the number of values
+	 * given back to userspace.
+	 */
+	num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		for (i = 0, cnt = 0; i &lt; num_fences; i++) {
-			struct amdgpu_userq_fence_driver *fence_drv;
-			struct amdgpu_userq_fence *userq_fence;
-			u32 index;
-
-			userq_fence = to_amdgpu_userq_fence(fences[i]);
-			if (!userq_fence) {
-				/*
-				 * Just waiting on other driver fences should
-				 * be good for now
-				 */
-				r = dma_fence_wait(fences[i], true);
-				if (r) {
-					dma_fence_put(fences[i]);
-					goto free_fences;
-				}
+	waitq = xa_load(&amp;userq_mgr-&gt;userq_xa, wait_info-&gt;waitq_id);
+	if (!waitq) {
+		r = -EINVAL;
+		goto free_fences;
+	}
 
-				dma_fence_put(fences[i]);
-				continue;
-			}
+	for (i = 0, cnt = 0; i &lt; num_fences; i++) {
+		struct amdgpu_userq_fence_driver *fence_drv;
+		struct amdgpu_userq_fence *userq_fence;
+		u32 index;
 
-			fence_drv = userq_fence-&gt;fence_drv;
+		userq_fence = to_amdgpu_userq_fence(fences[i]);
+		if (!userq_fence) {
 			/*
-			 * We need to make sure the user queue release their reference
-			 * to the fence drivers at some point before queue destruction.
-			 * Otherwise, we would gather those references until we don't
-			 * have any more space left and crash.
+			 * Just waiting on other driver fences should
+			 * be good for now
 			 */
-			r = xa_alloc(&amp;waitq-&gt;fence_drv_xa, &amp;index, fence_drv,
-				     xa_limit_32b, GFP_KERNEL);
-			if (r)
+			r = dma_fence_wait(fences[i], true);
+			if (r) {
+				dma_fence_put(fences[i]);
 				goto free_fences;
-
-			amdgpu_userq_fence_driver_get(fence_drv);
-
-			/* Store drm syncobj's gpu va address and value */
-			fence_info[cnt].va = fence_drv-&gt;va;
-			fence_info[cnt].value = fences[i]-&gt;seqno;
+			}
 
 			dma_fence_put(fences[i]);
-			/* Increment the actual userq fence count */
-			cnt++;
+			continue;
 		}
 
-		wait_info-&gt;num_fences = cnt;
-		/* Copy userq fence info to user space */
-		if (copy_to_user(u64_to_user_ptr(wait_info-&gt;out_fences),
-				 fence_info, wait_info-&gt;num_fences * sizeof(*fence_info))) {
-			r = -EFAULT;
+		fence_drv = userq_fence-&gt;fence_drv;
+		/*
+		 * We need to make sure the user queue release their reference
+		 * to the fence drivers at some point before queue destruction.
+		 * Otherwise, we would gather those references until we don't
+		 * have any more space left and crash.
+		 */
+		r = xa_alloc(&amp;waitq-&gt;fence_drv_xa, &amp;index, fence_drv,
+			     xa_limit_32b, GFP_KERNEL);
+		if (r)
 			goto free_fences;
-		}
 
-		kfree(fences);
-		kfree(fence_info);
-	}
+		amdgpu_userq_fence_driver_get(fence_drv);
 
-	drm_exec_fini(&amp;exec);
-	for (i = 0; i &lt; num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
-	kfree(gobj_read);
+		/* Store drm syncobj's gpu va address and value */
+		fence_info[cnt].va = fence_drv-&gt;va;
+		fence_info[cnt].value = fences[i]-&gt;seqno;
 
-	for (i = 0; i &lt; num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
-	kfree(gobj_write);
+		dma_fence_put(fences[i]);
+		/* Increment the actual userq fence count */
+		cnt++;
+	}
+	/* The refcount in the array is already decremented */
+	num_fences = 0;
 
-	kfree(timeline_points);
-	kfree(timeline_handles);
-	kfree(syncobj_handles);
-	kfree(bo_handles_write);
-	kfree(bo_handles_read);
+	wait_info-&gt;num_fences = cnt;
+	r = 0;
 
-	return 0;
+	/* Copy userq fence info to user space */
+	if (copy_to_user(u64_to_user_ptr(wait_info-&gt;out_fences),
+			 fence_info, cnt * sizeof(*fence_info))) {
+		r = -EFAULT;
+	}
 
 free_fences:
-	while (num_fences-- &gt; 0)
+	while (num_fences--)
 		dma_fence_put(fences[num_fences]);
 	kfree(fences);
+
 free_fence_info:
 	kfree(fence_info);
-exec_fini:
+	return r;
+
+error_unlock:
 	drm_exec_fini(&amp;exec);
-put_gobj_write:
-	while (wentry-- &gt; 0)
-		drm_gem_object_put(gobj_write[wentry]);
+	goto free_fences;
+}
+
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
+	u32 *syncobj_handles, *timeline_points, *timeline_handles;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct drm_gem_object **gobj_write;
+	struct drm_gem_object **gobj_read;
+	void __user *ptr;
+	int r;
+
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
+	num_syncobj = wait_info-&gt;num_syncobj_handles;
+	ptr = u64_to_user_ptr(wait_info-&gt;syncobj_handles);
+	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
+
+	num_points = wait_info-&gt;num_syncobj_timeline_handles;
+	ptr = u64_to_user_ptr(wait_info-&gt;syncobj_timeline_handles);
+	timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
+	if (IS_ERR(timeline_handles)) {
+		r = PTR_ERR(timeline_handles);
+		goto free_syncobj_handles;
+	}
+
+	ptr = u64_to_user_ptr(wait_info-&gt;syncobj_timeline_points);
+	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
+	if (IS_ERR(timeline_points)) {
+		r = PTR_ERR(timeline_points);
+		goto free_timeline_handles;
+	}
+
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read),
+				  GFP_KERNEL);</pre>
    </blockquote>
    memory is allocated for gobj_read before initializing&nbsp;<span style="white-space: pre-wrap">num_read_bo_handle which is done later.</span>
    <blockquote type="cite" cite="mid:20260202125149.2067-7-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	if (!gobj_read) {
+		r = -ENOMEM;
+		goto free_timeline_points;
+	}
+
+	ptr = u64_to_user_ptr(wait_info-&gt;bo_read_handles);
+	num_read_bo_handles = wait_info-&gt;num_bo_read_handles;
+	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &amp;gobj_read);
+	if (r)
+		goto free_timeline_points;
+
+	ptr = u64_to_user_ptr(wait_info-&gt;bo_write_handles);
+	num_write_bo_handles = wait_info-&gt;num_bo_write_handles;</pre>
    </blockquote>
    <p>No memory allocated here for gobj_write before using that.</p>
    <p>Regards<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:20260202125149.2067-7-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
+				   &amp;gobj_write);
+	if (r)
+		goto put_gobj_read;
+
+	/*
+	 * Passing num_fences = 0 means that userspace doesn't want to
+	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+	 * userq_fence_info and return the actual number of fences on
+	 * args-&gt;num_fences.
+	 */
+	if (!wait_info-&gt;num_fences) {
+		r = amdgpu_userq_wait_count_fences(filp, wait_info,
+						   syncobj_handles,
+						   timeline_points,
+						   timeline_handles,
+						   gobj_write,
+						   gobj_read);
+	} else {
+		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
+							syncobj_handles,
+							timeline_points,
+							timeline_handles,
+							gobj_write,
+							gobj_read);
+	}
+
+	while (num_write_bo_handles--)
+		drm_gem_object_put(gobj_write[num_write_bo_handles]);
 	kfree(gobj_write);
 put_gobj_read:
-	while (rentry-- &gt; 0)
-		drm_gem_object_put(gobj_read[rentry]);
+	while (num_read_bo_handles--)
+		drm_gem_object_put(gobj_read[num_read_bo_handles]);
 	kfree(gobj_read);
 free_timeline_points:
 	kfree(timeline_points);
@@ -1014,10 +1043,5 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-free_bo_handles_write:
-	kfree(bo_handles_write);
-free_bo_handles_read:
-	kfree(bo_handles_read);
-
 	return r;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------b8UTq5r62wLBBLuNIFImoDiY--
