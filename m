Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D4AC98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 14:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E8310F07C;
	Wed, 23 Sep 2026 14:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipdqXC0b";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAADB10F07C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMiRatr4sr4zIEaG0tWjtk4sNkahsZqQFfO0Olq3MzPtrGvaEBxnRh+LomdMXTLPDhdIvoZrJfRSvoYlawA8C5nzn99jHJaGS4A302dmRl2HYZnifgsly7Jkx9f7sMflaE46mF/ZY9QeCZkWF8lwKGOJD1/FIS/Y2tvrFNxKFOOhek8vh71W493SdVeynw00bj66AyMo0zAJs1nkQW5V3nLhibBVrJilh9wlw1lY/pygmM8qxhHGbUGNFfSegkcwDLfkUFI6Al8ynP9kUk9NxxNPw+D5t5FG1C3gqxe8bSwhTV34tUfN1B9pH/Lj15kAqcxbUk4V6ctG+O5v2JqEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h1VcLPi6pPCWKtR6pAlGjNwtWRn6V+K5P9kGpIYXF8=;
 b=lSkCAUx32te2fwvmbfqu1w8iwSW4sL3x71LaZfM3f1aLCia7HEhvf/cLc+jfXDk3w1h4lXl6zQmIYi8EoQlhFtFLmnq7ziVOhS6xQwZB94jOn7Ng8ZMeuxAk/G04knWoPobch+xtEikIsFQkutQIirC1MXOVY+hk5TEf5uSXRfk+3EYktKpQEpk2HfibjxRH8GHW5t4PfrNbgOzk3bKt58HCa9RssrDyZDJ0D71ni4uOW7/eNGRkCUJfbIbDnw4aLVDL7Bhtk902YvImQkDoExY/ezIxTehpY/iYw0rcAO5sV9P1VKlLDMtvMCbrhSbedIl59H43pPau0s6zkhszrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h1VcLPi6pPCWKtR6pAlGjNwtWRn6V+K5P9kGpIYXF8=;
 b=ipdqXC0byndT+iUP4ClAbyZcU1hvZNhFiQYAehg0cglRoV0faOv+oOwf2qkncGABnNFpjsaGCJJgIXkq8D/Q2qCGSKCwltwaClxgvtwBIAHlj4hmdlKPTmP+hX1vGVjAtJvR/yKe7JZ0CoxqWf2cH+rOLYaY4Z2UhVFWsg8O0qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:02:15 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:02:14 +0000
Message-ID: <a97514f5-8a01-48bb-b1f0-645ac657bb0f@amd.com>
Date: Wed, 23 Sep 2026 10:02:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
To: amd-gfx@lists.freedesktop.org, "Welton, Benjamin" <Benjamin.Welton@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::26) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a9f06b-cfd2-4d1e-b314-08df197b453b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 02i8MtxIygLhzTq9YBXYM9HowmN3v5ojjozxk70WBCfwgoST2slVh4xq2lNOOt6eaGZOPIpHstTQqTiPOEis5TFJ8TF1sadI+xIPNvuLas2TH4i77+qOMN7Zhjqj4C5MBwsATbvLYoOom8g5AfFwBYHbD1O2vi5Bl0BV7J74rU95ouD0btS9Ai0gFJBQrlY8dk00vEdQcolASiY9dFBOsdmSFqSoxLzfh/i+a8I2pzxTR/AEdLuDUkhzGzhBFIurBdtcvaMMgpbo/zWdcKZDyZst6JLHSEvkzNcQD6xFmjxKi1yFXyDQfiV1xoq+JXH3lBYsfcZJjxdJmltMyifADMQGPdAExdDFbO+Cx4aqWc2IxTVat4AP4BnC7UjuFiXiITreXVqiLtlQNhtAEn33Sqjxa906UfXtLGdgVWQix98kI7hwZnAVahdcEqjs1zANmNqta063x0Mg39A3uVLA8XHupcwHzpa3gywWaQ/HuohpYoWLmttjWCHwRQUza45w2KEbXrwyAP7DKWEO2r0oziHBtqq23jnghABQqz2/JuDxR9O5N+0tn+mUK//hoAHqa5NJKwJ2m6yW25YaJcdSMi4bkv8JIXoESZb296qgloTyRnJWLACUqe6XOsmcYgmy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlNYkdkd0RJNms3dktGZDdpYlZEWWp3YmdtZXQwMmVZWlc2K0lXWFNUYVN5?=
 =?utf-8?B?ZXF3RWZqQmFNeDlSUktmZ2ZVK25kOStTS1ZScHk0d2o2aWJGbUZBQ0lhenVN?=
 =?utf-8?B?a29pcUQzMW56RVFIclFERVpISE55L28zUS9VSWYvdW16QVVyNFJidU9hRGNF?=
 =?utf-8?B?U29CVzJvcktTdjRlMUxJbEV6K1lKZTZmN0tMQjJFRlhLZjk3cW8veEI3TnpG?=
 =?utf-8?B?UTI1MHZkZFZPNzZhS254bTJOM2p1VzZEbkdHRWx3aFphR3A1N1hmeVZIWG9Y?=
 =?utf-8?B?Y29sN2s0UlA3YnIxdkl0QnEwVEErb0tBV1ptOUE1ektwVWFEK0x2Y2tob1po?=
 =?utf-8?B?TGh0ektWc0FiVkcyVE5qekJqck11K1JWUmlIS210RzlFbWR1cjJUTFhzRWlR?=
 =?utf-8?B?SWJCT1plZnN4T0xMVENOK2owTU9lQVJuMTlGelROVFUweE9pbWRPUFB2VWFa?=
 =?utf-8?B?M3FOTnk2MkgzdmQvTGMyc2hiMndjdklManRyZHdFNEJhWEdJK1cyQ05JcFd3?=
 =?utf-8?B?aVl1aW1hU2twS3lvbEppYkRURHdJMU1jSy9KbURwNWEzYzJFeHVsNjNvejVK?=
 =?utf-8?B?eDRZS3RHTGRwQmJYczdUZGcwS1hEYkkrdEtRNXdteTQ5Z0F6Y24vQjRCOWwv?=
 =?utf-8?B?Yjd3QVJMdG9mNDR2cG5GVDBVcjlOUDFWQnJ0Q0NhRDlQUUhlbG85SUh1QVZE?=
 =?utf-8?B?Yno4Q3V3UWVqNVdHVW8zL0lCVHBYWUVodkFaNWFlckdCd05PT08yT2dUT0hJ?=
 =?utf-8?B?ZElGY29hMEVkMXhzdElHQWdYbzgzeXFqQlFuSDdYY1VhWWdoK3poMEQxM0RK?=
 =?utf-8?B?SU11c1NUd1VrU05FSXJvNkRpaFpnUGswZ0tKTnRUU2o3dExwbXhtNVdkK1lP?=
 =?utf-8?B?UmhZUG9SdHRKWDBkRVFtSGpTeEN5T05oYnYvNTFNbmx4Zjc2TUNGV09EVENK?=
 =?utf-8?B?RUxBMHlhN2dsdUJJUHBFWTI0RkRYM2NJdkZxejlqRDhSUWhqRUk1ZFloTWNj?=
 =?utf-8?B?cm56Vng2a1kvYnMwTDBDV1FjdmFBWSt3SDFCbHRCTnJjRkpZWXZzamhpTEdZ?=
 =?utf-8?B?TG94UTNHWXpDL0NWQ0JvNFFBU2h2aGxRaktDQVNpRnJMWGNjb2Q5NjgyZ0JP?=
 =?utf-8?B?cXg4QUdLekFnMlBMa2lYMUtTWElSYkc0THNieWE5elBJWXAwWHRDTjRwS0d5?=
 =?utf-8?B?ZmYvMWlSUmc1VStjbU1KTzVLbVYrSzVXS2xvSXYxTUFhdkFIenBPSzJWeHF6?=
 =?utf-8?B?VW1oWER3Ym85QXY2bEp3UEJ5S2JhNHE1KytXblI0NU1wd0w0MFVIRlBWbStW?=
 =?utf-8?B?TFZENVBLR0U0TitHanFkYjNtenV1bEF0WGU3TFZmRnBQQzMzV3NkQ3pyK3ND?=
 =?utf-8?B?cjR3QWZmTlV0UXVCK1FSck5hdGI2Ums5SHBuNW9hY1lHdWtUWmxvWCtraTZp?=
 =?utf-8?B?ejBWMnpwWUhxRE9ucjV6NDZJQ3BabWtYZ2pUN09NUUxLUjVrTm5vcWs2YUNq?=
 =?utf-8?B?UFFzWGJIYXE4eVJXZCtDSlV0K1phOGdxRUVsOWpUcE1lWFptSG8weVY5U09R?=
 =?utf-8?B?NU02MUlrUGJFSm11SkF3SkJjQ3g4Z2NaNHRHYXZRak1vL1JzQlNCSTVtZWRH?=
 =?utf-8?B?UWtOWDM0WU9INE9Hemw4N0syb09CdGttN2VmWWhKU3JYUittUkNEMDI3eVNl?=
 =?utf-8?B?eUY3SUdlMjNDZlVYNDIxOUpsWHF3RktrejQ4UUFYMDN6U3FGTDQvaWZlcG14?=
 =?utf-8?B?UktoaTVpWGlycEllRlRaTnNMV0ZPam94eitOam9xeVFHelRRREpKRlhiaG9o?=
 =?utf-8?B?NUhMZ2x3cUptL1pHV0dqa3BLSUpDSllDYTZrNFpyWjN5TXpOSGNHR2JkUzQv?=
 =?utf-8?B?T1ZzNENRbUlOUndxWis2WmRDVHgwSVZGODk4NjBNblJjYzlOcGtkZkgxMzNw?=
 =?utf-8?B?eXBYTGFsVzRkMWNDTXIyUGRtZ1ZZZEpsNm5LTUh5SDlGWmo0anFuQ1NxWkN0?=
 =?utf-8?B?bHd0bmp6dzg1MXovQ0RhaTAvVTg3QmVkVFh6OURvSWg1eG5YdS9ncEFQTHBS?=
 =?utf-8?B?dHdkUzZycUo2TE50Snc4MHhGTVBXRi9mZTBLTHNxRHNJeGxsYXpBT2QrSU53?=
 =?utf-8?B?ZDR3YjNTcEljNmJ3S2ZmMiswZmQ0a0FKOENEZjlaZi9FYkYwaXJlUGVrR2g0?=
 =?utf-8?B?eGFjNHdnbkN2dml1bytUazRqKzVROTB3R0p3U3Rzb3dzMkNRdnR1Y0ZnS3Rs?=
 =?utf-8?B?REJSYmtvVlEwZDZxRFhocDlrQllUTjFmV3lxdFlxVUZMaTVWbG43Yi9Panl3?=
 =?utf-8?Q?pAKdGsgNvlGQJRDkVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9f06b-cfd2-4d1e-b314-08df197b453b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:02:14.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMnn16qZYxWeyMm+AK1omQOUNt+Ix+PwjXvAIk2XIdlK4IeQi5fUUOY9Jslqqt1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
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

Hi Ben,

Please review these PMC patches for unified Kernel interface.

Thanks and Best Regards!

James Zhu

On 2026-09-22 05:34, Zhu Lingshan wrote:
> This series implements PMC support for amdgpu. Including two parts:
> 1) PMC Enablement
> 2) Profiler Reservation
>
> The user space should take the reservation, then set PMC.
>
> This series depends on and used new helper introduced in
> another series:
> https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html
>
> Please help Review
>
> Thanks!
>
> Zhu Lingshan (10):
>    drm/amdgpu: implement PMC ioctl framework
>    drm/amdgpu: add device-wide PMC config
>    drm/amdgpu: introduce PMC ioctl handler
>    drm/amdgpu: implement reservation mechanism for PMC
>    drm/amdgpu: set device-wide PMC enablement indicator
>    drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
>    drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
>    drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
>    drm/amdgpu: implement device PMC handler
>    drm/amdgpu: set userq perf state before publish it
>
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |  95 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
>   include/uapi/drm/amdgpu_drm.h                |  36 ++++
>   13 files changed, 390 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>
