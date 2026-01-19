Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E8FD29C33
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A3410E47C;
	Mon, 19 Jan 2026 15:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HEoAXXYQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470E710E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiBgykptXJnSCapD1zDYJgxA7D8bEUU1U75hhPMrIbscQuzrIsdSMvBkGD1a03u8p3XaE9WwP1T9xoS2g5NPppyL933f93M6vDS/LFSuqFd2RlXjaL/eWMaQBxek4WSJRNZ1EWimMnhHUEReH0t/qkE5r6uP6LBg7HYmcjM8qMOkxxekbUAFc/FXRmzyh8O4NZg0Q9/GhwrGRrK8LCLE3pw5hUnwHW+NRtjF+w/x7FaA44sLBVr4tnnDepTU0MpLf82/g8i9o4jyk3MlNx7QWTVHEEB0d32kqosDm8Extw8eDqMIi1XWcTRKYjYmBzB9E6f9zyrd1FCVMdVboEEMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WdL4En0+3cO6fJluxuWFHKY8mgIFkKYCutG1yy9Soc=;
 b=nqlJ/Xozj1xP9ZNn5CgLR8ytMg8E4HACEyhNELzGLlFDpJlgZJrHyW93NdkHCmjWHl7n/iWfOt2bo+xhmvt6cjkajPUsmaa/Jk6yaGlqMaNuXr04LzMiX+webl8gorcFgKzAJMPsnfWBky5j2RKrVRUnlSLxNVMbXEWMZnv//ukEMqhtFrPyF2R92G3VvjeBThBmrLX8/sDMSLjKZMb2csuy4S3eOYTbqC7iYhgnnQXBZ5v0pYVBdvtu+jY/oDd+IuahkXbgbr/sLSEopamtj5UgbNZPhdmZyFNIicwCwedMyGrKrdmY+4IoukNM0khh7W14+wgydK/jPsqsk+BhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WdL4En0+3cO6fJluxuWFHKY8mgIFkKYCutG1yy9Soc=;
 b=HEoAXXYQKZjfLUvP8iJb6GvQmWQjUTX9LEDcWpjkRMoLHxELoBJloDDVvg3EuRLg/Zo7z3YotV9kPCZPXZapKnz1CW1/gR8cZ3g2F63lyMZSK0f1z1sFLyrPW4gqJsp65Ix6L60AYnozRnW+3JdQ211BYaovW+3DmxwWgrtuZA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 15:13:46 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 15:13:45 +0000
Content-Type: multipart/alternative;
 boundary="------------0y0MCVBY5VbWe61FtiJ9ljxc"
Message-ID: <2e027461-ae7e-4c0a-b3c1-689ef38a74ef@amd.com>
Date: Mon, 19 Jan 2026 10:13:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add extended capabilities to device snapshot
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: James.Zhu@amd.com
References: <20260119145036.3019453-1-jonathan.kim@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260119145036.3019453-1-jonathan.kim@amd.com>
X-ClientProxiedBy: YQBPR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::25) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: b75d6009-2e84-421f-8cd9-08de576d56a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QklBWEl5VHNBQ1hVVFlKUWJCUnp6czhDRGdRdXlSSFRsT1VUb0w0RVlQZlJD?=
 =?utf-8?B?eU5RTkR5QjBXc0JCWHdpaGFkUTFpa3hVc0VlaTRwVWYrcGRWcmdPTERQUnU1?=
 =?utf-8?B?R3dQUWtFeTJsZ1NneS9lM1liVG94cG9uSm1DdG10YWhzaXFvZmZ3TGljam92?=
 =?utf-8?B?T0lGRldRRzNZV2VFUEhLVk5SdjdpRWJLWEpmejl5b1JuV1I4L3JlUEpUWU5v?=
 =?utf-8?B?WUhwN0I1MGJIVjhNbDVXdUROeEpQSVo4VkVDZS8ySm1EWUNEUmErbVV2Wmpw?=
 =?utf-8?B?RDd2T0RjVCthZ1VpemM3YnFrTUJjaCtxKzdsR1BldE9PWG9oaHVNNFhKaVNS?=
 =?utf-8?B?WlIrUmQveVY1LzNVbVZIdVA4ZThJR3N5eUpQellYWkc4bThteUI5dDZMVzRS?=
 =?utf-8?B?b2Q0ZTlRaDBOSmd0MzdPSW5QN2RTbkhjVzdzM0dOdU9POWtuTG5NczNRTTVy?=
 =?utf-8?B?TGIrVUpwZXM0NjNheTBjOWs1QnlxK1NCZEpTK3pPQ1VwMkt6d1BROFZmbmVw?=
 =?utf-8?B?WndjU1dvSVQzMmtuWlJNTm52RllsczVMNGhaVHBWbmNjVjVoQjZXYWNvVTZt?=
 =?utf-8?B?Tko3amI1dG9PMkVDdXlNaDlZNmpBWXJHWHpqeFdDUnRmbEx2TUNEamhodktC?=
 =?utf-8?B?ZmRlVE5sdEpOVTFEOVZzQkxGbUJVNzF1V21BdE8wOVEvTWFueVdCeHAxdkh4?=
 =?utf-8?B?a2kvUzV3YTRoYkVNeEFMcGc2T1kwT0ZQUGdSaUwreHFHaU11dkZ3ZTBXQVMx?=
 =?utf-8?B?K3hFc2w5S0ZPdUVHR1ptemxibHRzdHA2ZU82MkFuN3l5SVlQN1RtYzRnUVVm?=
 =?utf-8?B?dFB4Y3FuRWlhbHVIMGNJcHd3Q3dxN0JNMzJVNzZkMGdlMHd0cUdJYWdrN1po?=
 =?utf-8?B?VGtxcnJ5cjZGdGtaL3hoaHRQWkphQjNmcXJQRGRkM2VJL0wzTnNuYTNoT3Qz?=
 =?utf-8?B?cnRJeHgyWk1LelpRY0dtR3k5Qzlrc2tubm1BUFdKRjM0TmhuekhsWUQwWDYr?=
 =?utf-8?B?Tkprcy9QQ1hnZmVPZnpoVVZ2eHFrSHIyT3FJQzFPYktBUTRZeTZpUXlNZzk4?=
 =?utf-8?B?ZDFmcFpmd1VjNHYrd3FpVXBXWnpzd0xFU3RKbXAzNkxmT29VTUxmY1ZVaDU3?=
 =?utf-8?B?SUh4VEdSMDZONk9yNUxmbTFkTUNLOWtHUjN0TWhCZ0NqdXJ0Q2tpUkpoK0JW?=
 =?utf-8?B?L2tXdlpINDFqeW9yUlR3UEd0UDBLM1ZBV0hQZDhrNmJtNTRIVm55QmNlbEFU?=
 =?utf-8?B?OHhRZTNXZmtuMGt1ZVpSTWIrYWREZUlrR0VoWFc1UFVFTU42aDFGUVpnOWFW?=
 =?utf-8?B?ZDJrckV4bFZhY3BwL05vTmNtRm50TlJNRVJlMkRsTEQ0Sy8yVnpVZi9La2hI?=
 =?utf-8?B?NWdCM1pUM28zVWJsalBYZS9haFBsV2hkcXhWTkN4SEIwM3o1OTdVYmlURENJ?=
 =?utf-8?B?ck5pT3dHVElEaDBwaFIyWmdKSXJrbVpLeVJsNEh2VmdpT1pIMFFiYjRQbVZK?=
 =?utf-8?B?dGpVbExOZWpZby84NFVtYlhNczBQTit5cUd6WVNvTVArV0VGblU4MDhVdzlY?=
 =?utf-8?B?RHBxTW1yOG15NUwxRFlGR3pyU0ZVeE1YVmtXaFJFRXRzclVvTE1BZ3JwQTNz?=
 =?utf-8?B?SDFPbXRoR2JPNG5qTEdtbm5xdklvRkNVTkxzZXdsZGsyTFdLai9XYys2dGVW?=
 =?utf-8?B?Y0k5UWhCODRZdmF3dnhEalpuNGw5N2J4VnNSSUhmbTllLzVlWUZqdVBFYzFM?=
 =?utf-8?B?MThMc2tMSGhHWnFtNW5lY0VpeG5YakxmNUlOL0s1NzZnNncvbE1RbU1IdDVz?=
 =?utf-8?B?Q09VZDVpVFZHdzl5UEdCcjAzbnExZ2Z6QmJUdDY0d3ZXbWNWdUhGYnZMV3g3?=
 =?utf-8?B?SHdqbXk5akg5dEJkdkJva1A4bFU1dkM3THJQdEszY0xiWXI4RWZQZUk4bmFs?=
 =?utf-8?B?eXZPUmUrMjJOUnlsVW9yWjA1NWZtMjZSYXluUkt5L292bDg0bG1vWERVQ0R3?=
 =?utf-8?B?MEtNbU4wNEhGVXBTQlVvdnJ2bXVMNmQrRElCTzA4VjcwcS9FbGJDZFE1cExB?=
 =?utf-8?B?bjFNb2srWUt5T2pqVkRKWHQxcWoxd3ZoYTRDZFo3RGZXZHk0dUMyTzNETmFF?=
 =?utf-8?Q?zGEU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpSUWVBV2IxZm5QZDh3cElRbnd6UFJEWVhpTE1EdHBTMjdhMnZoeDdINFRw?=
 =?utf-8?B?UTBFOXMvQTdUWURDQ01rNHQ0U2txcFJ3bDFPVUJKd29VRnczWitRVkp3VFBo?=
 =?utf-8?B?alI3WTB0UWlKWUphcjFWZlBJa2xDcnVuWmVOZ0tLUCsxdVlsbGFVS0FIS290?=
 =?utf-8?B?Z0xGY0g4K3dQL1R5bnp1WkJLcTBQTzVtRjAvN1YxazhIR3RiUHJZeFpYNnRi?=
 =?utf-8?B?TmhXV3pVM3RabXhWVTluZkduM2VrUThqNllGRVhBcGpNNEtNRlh3S2Y2V2Jy?=
 =?utf-8?B?TENFWTZlMjUxQ0xoaEJvRG1kNm1RdFo3akEwbXdxVlF5aEd2b0tzdVBrQjJm?=
 =?utf-8?B?QnhhZVhPNGRWV3huTnlGbFFoNi9veHlsKzRJNlpNLzRPOWMyVUVmdVhwTFpj?=
 =?utf-8?B?SFdWZXhmaWRXYldVaWxDejFPWGh3c05aVG5hMEVVb0JKWE42N1FqaDRFWGly?=
 =?utf-8?B?eDVQOWlHSWxER3dwOVhDaUgvQUR2dUJ3QTRUVXY4WnJhb2NPYnBHT211dTZD?=
 =?utf-8?B?V0JxSUpBMDllSStNZUZ2MnFPOXZTVkMzZ2JBOXRmT2o5djRSbEpIMzZBMTkw?=
 =?utf-8?B?cjN6Slprc2QyZ3hLc2ZpT0hjY3FkU3VLUHZnOTV6NjM2cmFvOW5IT2RBRjkz?=
 =?utf-8?B?RTBMbmVpcjlFdTJEVzNQUjN2REc4M3piRFZLYjJNeXYwSzhwenppYkxjdUZI?=
 =?utf-8?B?c2k4aHEwRGRvZVBQYzkzTWFsYVlDRUs5UTVOUmR1dG9XYi9GZG9mODRqdHVu?=
 =?utf-8?B?dkN0bERWb1RWSXIyd2JRRDEwei81SVo5V3FpeTlPQkZwb2tSM05qU1Z3WElj?=
 =?utf-8?B?ZlVUU1lPN2tZc1l5RWoxZlBUSndGV21UZ3NBbWZEOXdWSUhRSDJqVytJK0lh?=
 =?utf-8?B?ZHhaNEkvb3IvekhuelR1c08wcTNGQlNTN3N1NTRFZy9HYTN2clJCSUFaaGU0?=
 =?utf-8?B?YzY5ZUNVSHQ4OS9nS1ZsTi9sbnIyUUNDbW1nMWxqSUQ4ZEJHalJaV0Y3aHd4?=
 =?utf-8?B?NHBRa3F4SmhxQUdVVHA1UFdrclhTQ0pPM3NaYmNtaHluV3RvK1lZTE10Tlp5?=
 =?utf-8?B?SEtBY3NKNm1ubklROXZ6cnJiYWNubWlVb3dScGJrcjlHUG9EWmFSL0QxZkti?=
 =?utf-8?B?eE1OWWtHRHVQRjlyQWk4aWpYSXV2ZGN2RXliTHprUFZNb2lPZW9KeGkwb3VZ?=
 =?utf-8?B?cW9PcVkrYUNSWVhYTHlKL3FLV2IzZThkVzRSOUl2NmxqZlBtdy93MzJHK0xs?=
 =?utf-8?B?RE9rMUNjbVpHakVkUkVjZlpjaXFHOUtHOXhwbFRvdXlNWG1nanlrUnhvVlFh?=
 =?utf-8?B?VUlOVmtTVWdIZk02VGdiVlR2Y2diS255SmE4Tlp0aXgxcHZERExkaktGZW5h?=
 =?utf-8?B?UG5BdHZDUDllVlFCbDBNSTVEWWpIcnU5SVJjb3lqQXQwZFI4WUpxaS8xWkV3?=
 =?utf-8?B?eG9jdnk3TVArM2NOWG1wTW1uUEpyZnozWldnTnMxbThpa0N6UmlIYmQrMTNO?=
 =?utf-8?B?RzgvNkQ1bWxwVW1ESUpoNWg2VFI0SzZQbnZjNGErcDJhSWJKQ2tVb2w5MzNF?=
 =?utf-8?B?TWRsNXkwY0JyUkJ6YmN6TkROUFdCK2Zvb0NZMG9KYnE1VGgwMk5vTSszWVpL?=
 =?utf-8?B?Wm1mMEFjdVV3d0Y1Nzl0TXp5SFliY3VncXpqTk1pNHIvSFFXN2hoQlRsVWkx?=
 =?utf-8?B?OENXdlNaek5zZTdmTkdNTFgydWdkTXBsT25uUW1TbERSei9iMVJBUmJ3SFpQ?=
 =?utf-8?B?OGNIQitRcml4U3ViSkk1N0RQUG9tS0R3bGNUU2RpdnU0NVB4QnJDQlVtMWJq?=
 =?utf-8?B?czlrM2l2MVI1VW9TU0FPeGFwZ2tWbTVaSjFKengwRkJCbmY0Y1dJc0s2dWlx?=
 =?utf-8?B?QUhyRWNrd1BycjB2UVNzeHRyNXpsV2s4ekJhRDN6M3l0NFE5WnFuWTdiK3Fo?=
 =?utf-8?B?NnBTUDJSbGtFRnYrVzNaS2xVb1F1L1BiL2ZielBENU5XOWpKUmR6a1FoNWdY?=
 =?utf-8?B?S0hyR2hYaC9Eajc1MG1IRy9UVEJPMUxKbG4xMDIyZEtPdUlvcHNFdXF6WGNi?=
 =?utf-8?B?bXo4S055b0dVNFBQV01mMHozWVFYMFZOUjV0N2xSSDlTMDNKMVlVd1I2bTRN?=
 =?utf-8?B?OFpwd3pwNERMbHFhME9GRFUraDJHM2hjaUtvL01zY2tzTUF1Y3prYkZId29Q?=
 =?utf-8?B?YjYvL3BraXhUa2d0Zk5hakVVNC9rNTVib0pjMFp3ZzFrZE8reFdzcGY0MUdx?=
 =?utf-8?B?Qk40MFdkRzM0ek10TVp4NW54ZUJSQ2JpeXNxcVRlc283aFg1K1hVcCs3Tkdl?=
 =?utf-8?Q?bOtrE/9sS99k7j2+Wm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75d6009-2e84-421f-8cd9-08de576d56a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:13:45.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu7KE5Q/3yv7KaLHtGvt+OMwaIpxILCIZi4KYpm67R8Ism6oNnzx3+GShiZm8Ypi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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

--------------0y0MCVBY5VbWe61FtiJ9ljxc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2026-01-19 09:50, Jonathan Kim wrote:
> Add additional capabilities reporting.
>
> Signed-off-by: Jonathan Kim<jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
>   include/uapi/linux/kfd_ioctl.h         | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 27176b2dc714..8f8a0975f1a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1108,6 +1108,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
>   		device_info.num_xcc = NUM_XCC(pdd->dev->xcc_mask);
>   		device_info.capability = topo_dev->node_props.capability;
>   		device_info.debug_prop = topo_dev->node_props.debug_prop;
> +		device_info.capability2 = topo_dev->node_props.capability2;
>   
>   		if (exception_clear_mask)
>   			pdd->exception_status &= ~exception_clear_mask;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 047bcb1cc078..e72359370857 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -149,6 +149,8 @@ struct kfd_dbg_device_info_entry {
>   	__u32 num_xcc;
>   	__u32 capability;
>   	__u32 debug_prop;
> +	__u32 capability2;
> +	__u32 pad;
>   };
>   
>   /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
--------------0y0MCVBY5VbWe61FtiJ9ljxc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2026-01-19 09:50, Jonathan Kim
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260119145036.3019453-1-jonathan.kim@amd.com">
      <pre wrap="" class="moz-quote-pre">Add additional capabilities reporting.

Signed-off-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
 include/uapi/linux/kfd_ioctl.h         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 27176b2dc714..8f8a0975f1a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1108,6 +1108,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		device_info.num_xcc = NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
 		device_info.capability = topo_dev-&gt;node_props.capability;
 		device_info.debug_prop = topo_dev-&gt;node_props.debug_prop;
+		device_info.capability2 = topo_dev-&gt;node_props.capability2;
 
 		if (exception_clear_mask)
 			pdd-&gt;exception_status &amp;= ~exception_clear_mask;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 047bcb1cc078..e72359370857 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -149,6 +149,8 @@ struct kfd_dbg_device_info_entry {
 	__u32 num_xcc;
 	__u32 capability;
 	__u32 debug_prop;
+	__u32 capability2;
+	__u32 pad;
 };
 
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
</pre>
    </blockquote>
  </body>
</html>

--------------0y0MCVBY5VbWe61FtiJ9ljxc--
