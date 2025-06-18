Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFA8C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 04:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8488D10E1CE;
	Wed, 18 Jun 2025 04:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGK2m8ee";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920A710E1CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 04:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL8zTLEFhLQmzYpMyx9S32hqR4P3do0wmFQf8SGQC5HnESci2vWFdAsrkg6WoklXNnV5NO5yT0PDotWzyX7ciAdOfd7Q7KeEK7jo3Sv3CjcWqI6Guepyka2G/GxteK/nSYqVOt+6J0rq2K2dt6zpqLx5wRyP+LdqOrNLXNsPwr3NvqGMHIrj8MWs/7Y4H1kPq05n+ltGjvZsMgLgXDkkV0PUvflS95Ef8WYD3whS+h9FioHva8Cyckx+4Vqt4h1kwvFXlfRpdFILnM0SHUTkDYFqnO03pL49M0wZYkGBNIjSUzhzE+WVMxmTFCRoLGAGDgzodhZt9o1uYysPP9V9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65nZ660Q8DsWPnTphMLIxEPhA3EzY6hpxVOhS17TNpU=;
 b=BnVy9qdDyV0Lf4FtkMWzIaWDqYs7WHM/TSNOoqrxvCqoPqS6OIm/ZYbvr4Zzp2KAqAN2AyBIx9ERneysyJrrW0SWWPiGMPyiMRNgum/oqxZx43PLTcrbsTSZwTlyulFGElGD4nARjIxmHmZykZr6wTDO7S7nxAEbHXy7lHHkqK38rfHWpdUbiFeV+hsdn3Ndd2875EkkaZz37LFx04x38yt5aWBGm3l9ChE7JTm2PmztJAZ1IZ5tcR5bylpIHgZ6L7t6Wl1kDTibdq65KRc94tnkYpBoBZIJKioQ4w7gziuHgYc7iidncRj7pfyq1mbrqUPrD8bssuVi6RDvWK2yyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65nZ660Q8DsWPnTphMLIxEPhA3EzY6hpxVOhS17TNpU=;
 b=bGK2m8eeZq5q4PYoLOw3AN94xAoeDYKbR62EbuMRR33yA1sWCS+ANx42zEagtL9XZjmx/EVRMVQ6jusqjDgzc9LLRn2+aG/hMiB5rwoClT77QnSwaarSqt2VA7F6+Vh5S5c+0SWSHmLIlicoq3h3xO3RY3Gw3/zwU/Ahn8vlmPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 04:14:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 04:14:23 +0000
Message-ID: <6b355dd0-f159-4390-b02c-63e793c6fd81@amd.com>
Date: Wed, 18 Jun 2025 09:44:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-8-Jesse.Zhang@amd.com>
 <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
 <DM4PR12MB51523E85ACDA7D14C4D12D60E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB51523E85ACDA7D14C4D12D60E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b74b32-5789-4dfe-ba92-08ddae1e9ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnkvQnZ1ekF0bmdHaG5UV0ozRFV2OXRoN2FmeG5FYWFoMFdMVjZzZ1FWVW1j?=
 =?utf-8?B?dXI1L1gyaHkwQ3p1dGc0eENVeCtkQ054bTFJRGFTRjdjNWpFVHBoUk5oc05H?=
 =?utf-8?B?L3lEVkRyRGZWdkszNXdsV1JJd0FNM1J0NGZ1TTVWTi9KQlRSaTFqRmRXZmFo?=
 =?utf-8?B?YTVDTklJZ1IvMXRIMXlRdDBXYWptcjRSL2gyN3ZoS0N3ZG1SVUV6QTZ1QWI1?=
 =?utf-8?B?S2MzZjNyeGNRU0JZY2h5b3Fld3NXVjJSTWdWOEJ6Y1Nad2ZIdlc0WUpjYlVa?=
 =?utf-8?B?enNtN0tQcmpxL1lQMWo4VFZaM0docVFUaDFSN2taWE5wNTFkY0VqSThZMzhP?=
 =?utf-8?B?a1hoaW54Kzk0czJqcU1DUVYxWW5xSm9PMlpab1hYRTQ4U20rMG4xckhnUER5?=
 =?utf-8?B?Z21MNnBxU1hFVkVPQ3k3dE92Nk15L0x1QkNrTzNIMlliaDdkZmcxN0dma3o0?=
 =?utf-8?B?azRtelB1c2VpZUxKdXhjcGN4WU5JeFVnbGVyMVZaT1Zqb2pmK0o4bjhwS1U3?=
 =?utf-8?B?N0srU2p1UzUyUldQUjBlZ2piYVp5UnNia1dYSmRGZTJhRjREZ3FtdEZxNmhM?=
 =?utf-8?B?c2pxM2htbFluaEhDelhTNGRiNGJVeEhSaUZiK1NlQlJVUzFUNDJSanQ1NWtJ?=
 =?utf-8?B?SkxoTjVVZUtBVzBONGhTeC9hRFovVG14dnl4UVM0V2hiVElPL0dMZ2ZFQkxX?=
 =?utf-8?B?SjY2ckZoUWtaR3czQzJGRHFpRUFpbmtmWHkydVgxRklkZXFrRWFza2kxa1Ax?=
 =?utf-8?B?TnM5WUl3dE90NXdxS01pT1lQdmppV21XN21wSHVzWnpoS3d4Z0E3NGpwNDV0?=
 =?utf-8?B?T2dhNkNyMGd3eW1yL2UvVmhidXZLVnMyWUhwZGNIUWZuNmlGbzVxREdzc1Ra?=
 =?utf-8?B?V2hXMG12L0RVY3lwS1pveG05ZHhGclhhQ0t3V2NJelAvc25CbmZUQU5JY0ZZ?=
 =?utf-8?B?KzFBUjlGK2hERzVqa1ZidHVHaUtjYi9WcE13aEFwUWU0cnh0L2JJdUxzQkZH?=
 =?utf-8?B?RFVvTzJ3QkI0NGdqRytTbmx1RXZYeWcxSkFmYWZjZm92SzRpaEM3SEkzbW11?=
 =?utf-8?B?bU45SW1pbzFNVGZPWkJCVHlQU1JMOGdZTUxWOGZoWXlqZzFJN09nTStWSjdS?=
 =?utf-8?B?UU1saTVaNlFPVnhyclE3MjlmSVA2OFkzWWFpNGdNRml3bXZYd3QwTTlldkk0?=
 =?utf-8?B?WVNkQjVTSW52L0JvWUNacVh1WGJra09uempUb1dCUk9YaVVTYUtxaElHaGo1?=
 =?utf-8?B?d3dTS0ZqOHJSUTNWaHlLRHhSS3Y2YWFqcmZsN0pFeTBFejU1b28rMXpZUWpW?=
 =?utf-8?B?azcydExsaFgwMFN3VjBkc1hKK1lKaWVkRzZ0TmpzNnN3a05JL1EwdEtyckhV?=
 =?utf-8?B?MjJvaFdVMnkwdVVrczJJbHEzZWVacmdpNGFvdWJSYUtQRGw1VlBiZkt4OWY1?=
 =?utf-8?B?WlF1R3cremRYc2E2SWlEdm1tRWoxc2tBbzZBRjRZVW5TVlBCSjhkQjBacm9L?=
 =?utf-8?B?TDZ4TDhJY3dtanRlYkNKRkNROUlxWEp4SWpncDJpT1BoNkFYYU5XMGRORnR0?=
 =?utf-8?B?aEFxMVo5Q1lQVGNjN2RvZmQwV3NSb0RmNGpLUWVjb0tnTVFFYXU1R2V0WXJJ?=
 =?utf-8?B?WEVLUG15bFRNRDBEeFZKNUlIaEF6b3J3aE1JdUl1eFZBNEYxMXNxQ0hpRlBP?=
 =?utf-8?B?dDFPanZ5OUExZXliU1VxWnNaeVdTR29qdDFzd3BEOGxuL2pTcEJhN2dHQUtn?=
 =?utf-8?B?SitKL3BqTVA5WWw2cUhWMm94SldLdzE5QkExK0d2cVhub2Q2RXJNSXVKekRr?=
 =?utf-8?B?c1E5WU9JYVhwb011OWtuVHhBdS9qQktGYVZPSXNvT0REMHh3VTczTU5jeEJo?=
 =?utf-8?B?eGNiRXY0R25tTEJQZUdHbzJzaUFSZk9sTEVRcXFTRFNpOFRTVlNPOHpBQkRR?=
 =?utf-8?Q?fLJmO0P0nSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjV5V3VXNkhtNVZCell2dUZ4UHNyTDlYNzZTNDVLOUd5SWZTSzJBSVFIYkd4?=
 =?utf-8?B?dmU2SHhoa3Era0JGV2M1RS8xeEh4ZFVCMEFnbytOUG95SUR5dk5WV2I4b2Jz?=
 =?utf-8?B?dWdudHJMd255Q2hhTWlBQUxYcjZleDNSV2FuQXNGa3IwQ053WTdxYkwzZTNW?=
 =?utf-8?B?NCtZZmFhWFhRUkhBL3k3MCsvbEkyS1phV01ZNnJjWWkrbVhsUmZUcHBOanpU?=
 =?utf-8?B?azBhQjRqcHQ5bVJNb3hTSHVSa1lLMks4R1ljSFVZRVFvNFJaMm8wdGpIWU80?=
 =?utf-8?B?cXYyaU5mY3hoV3UxOXlzWktuNEk5Y1FSTHd6UG9oRzhJV1g4NE01bjZza1du?=
 =?utf-8?B?SzZXcGJmMUZ6dnA3NDZKZXB0ZzAyNDh1V1VRbU9ML3AwT3o3THhlditHVi9E?=
 =?utf-8?B?SUJWYm5OMFN1ZEo4YVRBVStXRXROMnVEcHhVV0I2VDJUV0VsQ3ZXTVhWOUpw?=
 =?utf-8?B?a1h4c3d5WUM2SGJtaTdtRDlYcElYQnVYVFVSY0lvVkhPTEpjaGw0MThGMXNu?=
 =?utf-8?B?cDU4dzdWckpuY3dYeFdvbmhEY0NEc3Y0eTFwb2JwcU9Fc0J4YkNvVm1EZTJp?=
 =?utf-8?B?OWZsL2dubVhrNTZUTmt6Rm9jVnJXaUdyczdvc0NLKzBmU1R5eW1sNnZqTzU5?=
 =?utf-8?B?TExLUGw4RmRXVlJRcW8wZEVKQXZlSWFlYXhTUGFMZ2tTQjZ0cXM5TnVrdk1U?=
 =?utf-8?B?NTNsNzNyb3ArbHh5elUwUVlMRUczbjVsOFIzZGg0YnZ1ZTQwVis0ZjZhUGgy?=
 =?utf-8?B?UjcvK2ZLQ1FlMmoxTThsYkxMbnhUa1V6d0lDZmpEQS8vNjNlZjA1TmxxUkZi?=
 =?utf-8?B?Wkc2MzJsbVIrWFJHbmlkeUpmSnJKMGFZT2JsVEF2dGZyTDMzZkgzc0lpa1F5?=
 =?utf-8?B?WlFwVW1rRTUveU1idmM5ZHBNRHJZaWd4aUQ5SWJXR29MRnU3OXcxNFQ3TkFy?=
 =?utf-8?B?VGhVRlh1bTNvZG5mUXVBV1BYaUdtZmFFM2RLVzZ3bUk4TlB3RlRVSVVHTGEr?=
 =?utf-8?B?UDNhdkRMSy9MVTBuamFRbUhRTVo1VnBQYm9QaEdFL3NMWmFyd216WVNTNS8w?=
 =?utf-8?B?S0JhdjVHakVHTlJCYWViTjcrNnNldUpZdEpwRVR6QVVsRG51bTc2SUQyNmlZ?=
 =?utf-8?B?TFlwVEExQ2hjWVd4UDdxdGVWMFd3WnNPNFpBeEtmMWJMUStoT0RZR1hOVGFl?=
 =?utf-8?B?UmJxZ1hvdXBaV3Q5Y3ZkclZaUStoRzFma0dMenpYNmlwcUlsWkNTQTVnRmtY?=
 =?utf-8?B?VlZlQVNxVjJlUVJuYkw4bk9udE5HZlpWY1FSZUsxMC9ic3F2YThQTUpzbXRw?=
 =?utf-8?B?MmhOUzVMRThUYURKa25kZnNuVWdZay9UMDVJdlZ6YW1kYjhITDFleGRNdi81?=
 =?utf-8?B?WjY4c0o1dVBVcWsrQUkrQURuakQ2VmVDMEtBT0M5blVCei9tdDZtQm9LWVdi?=
 =?utf-8?B?cHNtVTJxM3hJbmN3Z0padlR5cGgwNWMxeW10YkNEcld1RzFsbk52T09PNU9T?=
 =?utf-8?B?VmNzZHNUcExOSXArWUZSSURwa0NBUGpPTjIrcGVSQ0lsc3pFZGtsVGxyNzFD?=
 =?utf-8?B?ZUtGeWRZWTRLUkRWbXM5c0xNQ3lBeDlFY2ZoMlZPQ3FxNGcvSXh2RHBuNzFm?=
 =?utf-8?B?R3owRVI4aTZuZ3JVT25yUGlYVnd0czRhM1JiY2hLSFJxRnZuU3o5VVE2bm5H?=
 =?utf-8?B?Skp5by9MRWFKR0x5Q2hNOHl3Q3lBN0xSSU8wUllPcUc4RURkYXF2bmdSdlN4?=
 =?utf-8?B?NjYrTU5TM3JlT2Iva0x3dGdocERFeFBqbHYzWHgyVzZ5WnlqWkhwMnZ2N1Yy?=
 =?utf-8?B?RjVmVk5ZK2syN0Mvc3NWbko0eVgzemdiS01jdFJvU2d2Wjd4U2cyUjBWUnhh?=
 =?utf-8?B?dGNMR0J3L2luK3RCZGtiK0JPeDB5R0dKZzZ5dnRaTStkYThKaDUrTVNZS2p6?=
 =?utf-8?B?Sy82OWkxVTF1d2d3cVpaT2F5OTQ1QlJvTmpsNjVOaW1tRVhMcmFoL0prZDZU?=
 =?utf-8?B?S2kyaXU4Q1pXQnhCeldkSFFDd3RuQU5KLzJGWTZIRnZOYzZtcUQzSUtialRz?=
 =?utf-8?B?eVdUMXgwTTB2R0NldUFzWHVCdXQ4NklCUGwwZFc3blJOWHJqTGhRV0MyK1Q1?=
 =?utf-8?Q?MnoyGSxLhQiANGHhxM3SnAWeA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b74b32-5789-4dfe-ba92-08ddae1e9ac5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 04:14:23.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k6c823Bt2EWp5HNTt/xClfqR4xB5Ka9znLN+Hk34iBRyh1Qr5QZreUvOZvAQVcc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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



On 6/18/2025 8:14 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, June 17, 2025 5:57 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
> 
> 
> 
> On 6/17/2025 2:50 PM, Jesse.Zhang wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> Add a detect and reset callback and add the implementation for mes.
>> The callback will detect all hung queues of a particular ip type
>> (e.g., GFX or compute or SDMA) and reset them.
>>
>> v2: increase reset counter and set fence force completion (Jesse)
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index ec040c2fd6c9..0335ff03f65f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
>>                    struct amdgpu_usermode_queue *queue);
>>       int (*map)(struct amdgpu_userq_mgr *uq_mgr,
>>                  struct amdgpu_usermode_queue *queue);
>> +     int (*detect_and_reset)(struct amdgpu_device *adev,
>> +                             int queue_type);
>> +
>>  };
>>
>>  /* Usermode queues for gfx */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index d6f50b13e2ba..52d438b5dcef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -21,6 +21,7 @@
>>   * OTHER DEALINGS IN THE SOFTWARE.
>>   *
>>   */
>> +#include <drm/drm_drv.h>
>>  #include "amdgpu.h"
>>  #include "amdgpu_gfx.h"
>>  #include "mes_userqueue.h"
>> @@ -198,6 +199,55 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>       return 0;
>>  }
>>
>> +static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>> +                                   int queue_type)
>> +{
>> +     int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
>> +     struct mes_detect_and_reset_queue_input input;
>> +     struct amdgpu_usermode_queue *queue;
>> +     struct amdgpu_userq_mgr *uqm, *tmp;
>> +     unsigned int hung_db_num = 0;
>> +     int queue_id, r, i;
>> +     u32 db_array[4];
>> +
>> +     if (db_array_size > 4) {
>> +             dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
>> +                     db_array_size);
>> +             return -EINVAL;
>> +     }
>> +
>> +     memset(&input, 0x0, sizeof(struct
>> +mes_detect_and_reset_queue_input));
>> +
>> +     input.queue_type = queue_type;
>> +
>> +     amdgpu_mes_lock(&adev->mes);
>> +     r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
>> +                                                 &hung_db_num, db_array);
>> +     amdgpu_mes_unlock(&adev->mes);
>> +     if (r) {
>> +             dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
>> +     } else if (hung_db_num) {
>> +             mutex_lock(&adev->userq_mutex);
>> +             list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>> +                     idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>> +                             if (queue->queue_type == queue_type) {
>> +                                     for (i = 0; i < hung_db_num; i++) {
>> +                                             if (queue->doorbell_index == db_array[i]) {
>> +                                                     queue->state = AMDGPU_USERQ_STATE_HUNG;
> 
> After a reset and force completion of work, why is the queue state maintained as hung? Does that mean no more work can be submitted even after reset? Where is this state checked?
>  Detect and reset will be called at umap, and if the queue is hung, umap will be skipped.

Ok, this doesn't match with the inferred meaning of
amdgpu_mes_detect_and_*reset_hung_queues*. The API name gives the
impression that queue is reset and now it can be used to submit other
work. If the queue is not useful after a reset, why not remove it from
the list of active queues?

Thanks,
Lijo

>   Thanks
>   Jesse
> 
> Thanks,
> Lijo
> 
>> +                                                     atomic_inc(&adev->gpu_reset_counter);
>> +                                                     amdgpu_userq_fence_driver_force_completion(queue);
>> +                                                     drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>> +                                             }
>> +                                     }
>> +                             }
>> +                     }
>> +             }
>> +             mutex_unlock(&adev->userq_mutex);
>> +     }
>> +
>> +     return r;
>> +}
>> +
>>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                               struct drm_amdgpu_userq_in *args_in,
>>                               struct amdgpu_usermode_queue *queue) @@ -352,4 +402,5 @@ const
>> struct amdgpu_userq_funcs userq_mes_funcs = {
>>       .mqd_destroy = mes_userq_mqd_destroy,
>>       .unmap = mes_userq_unmap,
>>       .map = mes_userq_map,
>> +     .detect_and_reset = mes_userq_detect_and_reset,
>>  };
> 

