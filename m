Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FE8D609D7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 19:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86C010E07E;
	Tue, 16 Dec 2025 19:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4M4jHjSj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC3A10E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 19:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWcm6hYsqqTrPk7jQ/EOe9Wux8FMQshozMQb7ErbyM5cZCFjTHDGUxZbrqBmZtFVVB67m28f4sQn0DgG+uyMIqsMJ/zsbZ4Kl2cySPIR2AlWyZ09MK8bAUe0twDuQ0Lq2DI3eeFujT1eVegOm/Ob9hHh81YbR8Vt+zOXO7c4TRR7Gs9yDjdN/Tl5EYuKHsQOSd3DvQl5vuHzohJyoVBC4haSNwCTA/RgLwzZmigNyaEF0TBEGkXkdmBJEwXxDTbMV24FJcNmByDGQwu78+m6PKOi+QA1HyF5PdvYEUaMFf+LTRYYtiUCGit4lIUTIHtXwwEUWqZcSqsj2RvPfE+Wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egFEJeur02NFYD3q8mDUa/uvJGEtTG3aXewZBObi/Fo=;
 b=G7kYq+RUODlAsDNik59YT1k5Nx21bHnlEa68yDzo1FacH0X1qdnRimEYwQ5cRSsaCub7HhbIGWAbGI8or7QsaD4PqbGSfuk4aMnwy3442GC+6YFueRFC1uzaMBAuCL7SzTcVCCO2teZBd2WAgcnj29WZ18q8H013d1RtQQFhf7pLo+tfUxFcBBTo8lK2R7qbWrmoKLzRhDnkF3Kul2kYTyDhYHhHMAKQo7AxYdIYYQdo3zDBaXkCvNpoW2YWj+0T9xH6y0+sZwt0CD/G5035rXp9wXET2Xphe2m2OTiN3LVVKstWJixg2t3S3/YgscVRbgea+DucHpqVaWhFc36a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egFEJeur02NFYD3q8mDUa/uvJGEtTG3aXewZBObi/Fo=;
 b=4M4jHjSjYVb7DbvVF5c2IOGIZwJ/GRxgzGrqW3IogsPQsCu0T45S78Df1eXg1Hqmd2xueMVVh/LS41Rq/JsvjElwV9BjISczu/lXQEte7bVvOsmjhXEJTOh0qTYMJcJ9TTWa5s77ntbxyPXP6dWOzFM1dWNXLpBOUyLQ2pNfHeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 19:10:18 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 19:10:18 +0000
Message-ID: <96ac728e-1d58-46e8-a4a4-b722023f6a45@amd.com>
Date: Tue, 16 Dec 2025 12:10:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, alexander.deucher@amd.com,
 siqueira@igalia.com
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
 <2595415.XAFRqVoOGU@timur-max>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <2595415.XAFRqVoOGU@timur-max>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:303:6a::18) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: dab089a9-905a-4950-6dbf-08de3cd6c065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2ZJQVQ2SFFJN3VRSlZadTVqa2I1REo1TG9SdnlkQ2V1ZlZvUkR4Z0ZMdkR2?=
 =?utf-8?B?aTl5a2dJZFRMa3dCZFV5ZFIycmswQ1dlc3ZyV0VPSjVjLzQvZGNWbWhCTGZW?=
 =?utf-8?B?Z2s2M2o0dERGNHQ1QXFocDNJZnpDYVg0bGtMOEovSGNwTS9tRkExcFY4UGpH?=
 =?utf-8?B?L3dIa1J1Ri9FR2JRcWsxRTB5UjV0UXhmNGlZYWdJdXJwbkxOM2dWV2RnbFNV?=
 =?utf-8?B?OENCY0RLTVRqTkdQQjdRcllQUTB0elk3dnN4dllpTlNCMDc4blRQYkxXQndY?=
 =?utf-8?B?ZURtaW9QTk5LV0Y5K3ZHWUU0YjMwcnpONUVSclBCUFVXQnNPOWJFMGkyRk11?=
 =?utf-8?B?ai9hamVUWFYrYm9MZTRDVERRVFVTazlkcTdrUlBiN1VZLzZYMFVOWjhsUVNZ?=
 =?utf-8?B?aVR2Vi8rSi9Bb2plaEY5MUFhOHhNVnVwZ0VJeWR4QXlKd2FyTlFKNGVUV0l3?=
 =?utf-8?B?Qy9qWFpXVXRVOGxsTVYwSXg5Zzk0TWNuMC9oTEVJbmJKWWZTVnVnUXFtZlU0?=
 =?utf-8?B?NWc3TzJPOFFwKzNxSUlYNWNLVDk5N1RycjJFU0VWZ0xyMEtnakxXRlVrQkdp?=
 =?utf-8?B?Mmk5RWVhaElWQXM2aWhRSG9yWllNblVhd1R2QVRWQnhHQk90OUtnRWFIVW9T?=
 =?utf-8?B?TnhEc1owbWJ2ZVJRWWdjTEpUZDlML1p4RmNGRTVNcDZpa05kczBhTGdlZFFj?=
 =?utf-8?B?K2lrb3dTemFrSkNkTnpkUVRGL3hTWFdaZ0Y0cjFUWFNnQmdLdVI0SHVBUmtT?=
 =?utf-8?B?RjNEYWZlUDdSQVR1dTBLcm9rRnBZRExUZXIrSFYvVkVrMm54Mi9MVytyUHhE?=
 =?utf-8?B?VUZqSTEyWi9XVVdkMytLWlQvQU9Eb1Q3L3pveFFQTlU2Z3I5VVhWYVJDdktM?=
 =?utf-8?B?dVZQblZqUHhIc2p6NjFqUVNFZzJDVmd4VlBMWitrNlRGNDFvV1lob3ZsSUo3?=
 =?utf-8?B?MWs4RVdEK2xidUdyRG1FV1YzNUZ6VlY4Z201MDNFa2g4Z0JEbDMza2VhR2lG?=
 =?utf-8?B?Wk5uZlg4eGJhM0gwbDY2ZlN0Q0p3Y1dXWElFZzVUSk10ZDJBOWhqbkVOZDFS?=
 =?utf-8?B?L1RqbXJWNnhSMlFraU5LNjRDWFhIb3N3RFZlcG8wc0J4WHNqcFJzblZVZEdJ?=
 =?utf-8?B?N2g5MUpjbElDQllnSEpmWWNldW5iRWN6SE80RmpiU1MzQlJXZWVJNEQ0RXFt?=
 =?utf-8?B?aVhQL2VYZVQ0ZUJZUGdMTmZvVXpCRXAwekRrRmNiVjhzQktKdlR6NEVFMFZw?=
 =?utf-8?B?M3pJYzZZU2hBNlN2YXhsZ2QyaHVNYi9VR2pRMThjcVAzSmlWOUZoUkhBUkJL?=
 =?utf-8?B?aFVsRS9ra041aW0rYlozMU1UYXd6UnYrNElrbTVYWlpVTndzN1kva1ZkWFR4?=
 =?utf-8?B?aTIxdm1BYkJMcUtWaTVYaXY4MGN4bS9weDgzaFhOQlpCZUtMZ2toK3BxREVK?=
 =?utf-8?B?TzJ4RjNYUFZLUndVY2FDcmlUWWRkYjRtQXE5QVE4b0xLSFFoYXl1Wnl4LzRX?=
 =?utf-8?B?NmNuTEd0emw1Yk1xSlIwdUZ6cDQvWXB3OUd5RDZYeXZseXN3aGY5ZFlmVHFX?=
 =?utf-8?B?WkpOa2NIYk1kaDhGODIvTVpJU1F3Qi9Lak54ZENPdjVmRmJOd0phQ1V2dVF0?=
 =?utf-8?B?V1h0WUtqVGNNN3cwRzNBdi9yTlNKSkRreHdKUVlYY0ZPMVFqQjB2VEo1c3h1?=
 =?utf-8?B?bk1kWlRjQ0orSUxZQ3o0NVRUUDhuTTMzcXkyV3BjM3RDYUExRWM5MDRTMVNG?=
 =?utf-8?B?WjNpVUtxZXl3a0F3MHBYYkZLM3UwaExjNXZia2t3aW9hZGRWT2pSTFlNWURF?=
 =?utf-8?B?L1U2QUtCc2U4UjI5TnQ5MkhocXZ3eGQ5Z2ptU1psSHdlRzhmVzRrRUN0QUdY?=
 =?utf-8?B?eU9tMTdKd2Z1TEdoVndENDBkZksrdEZsYlpnbHUzTE1vcVNJcUxMYmExTExU?=
 =?utf-8?Q?X1h+3kVZIPD8jjtsUeLH4XpiOcUjy7Da?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1diSVZqV05OMzdkV1hvbjlYV2JNdk42eGtKS0xWckwwZlNHYXlpdEtjalVY?=
 =?utf-8?B?KzRyUnF0eXBBd3lmdjRhWWxlMWlzRi9mb0x1VnRnOWcwSDJXTnRLT0dCRjI2?=
 =?utf-8?B?a2FqNVFGK2FLUnhoc2F3UEtVdnZkNzZsY0NwLzcxZXBzV3NuUHl2cEZQaEEy?=
 =?utf-8?B?QjZpUDRMOWdxdEUvNjNsQnBZZlFDNm5WNHBHbHJxTmFXL2NLbkIwRjlPUERo?=
 =?utf-8?B?VURRMWoxTm8wQXVjUTVONmlVTHBiSk50VmMvaXJQOENMQURWVXptVU0vSmlv?=
 =?utf-8?B?eUVYL2hId0VrYnQvcDZSTTY4NitnVHJPa241ZjQ1eDlEa1VmQlZlNU1pVTBZ?=
 =?utf-8?B?VU1VRXRJWldsM1lsNzUveG9XK2ZEL3d2TFhXa3RLRElOb01EdmpuOGkzdk9x?=
 =?utf-8?B?cktGWWdDSDNFQ0RVejB1TkRHTFRLeWF2bXdQNE9kNjN3UjFhMVVGQm1qQjcv?=
 =?utf-8?B?U1VYdTV3OVQwQzdKQXhzSHJYcDlGSS8rYThSOGdtV3A3ZnExakpacGo4UlJh?=
 =?utf-8?B?Q3ZVN0FjNmlua2hUd3VzNDlibjg5TERUeGZjTlBmSWllU0pWOTFBVWR5WEFN?=
 =?utf-8?B?TXRsZUFzOHRyWTcybGx2YktKMHByWmhPeXJtcGV2eDFuaTdUMk12K2wyWVAz?=
 =?utf-8?B?YkFMdCtqTzU5QTBDZ29TdFc0a1pMb2ZmL0NvQzRVYzg5V0pLaStKenZuZnIw?=
 =?utf-8?B?YVFOekFwdUJhLy81MmtpcVMyTkFXRjdsQyt2Tk92c3RoZlJ1VjFNVlpSTS9u?=
 =?utf-8?B?cVMxaEtUdmNhMkQ2NGpCeGZpbkxpVjU3SlVMUVhiZWNjZzA5YitoT1pNS1N6?=
 =?utf-8?B?VVN5YUhocG1qQUxHcGhVNHZXQnd2VkhtNE52NTZaZ1p0UGczU29HZVJzdTA0?=
 =?utf-8?B?QU1Fc3ZGWHNBK21wWEFWTmV6SlRvS0I0T2N6d2VHd1A0Rm96dFY3U0tjUm1i?=
 =?utf-8?B?OFBmL1hyRmNWMXVsMEJMQVB1dHh4OUtXQlVUT3BRSGhZOW9OaGFQUU5RcEtl?=
 =?utf-8?B?OUVSSVV1OUwyb1l0RWdTYjhlaWRIa29YQzRWUVJzY0JZRzByMHRVMjZIS2JK?=
 =?utf-8?B?MUVMMmlVVHVtNkp5MVAvbm5PYU9CVXNVd3c1UldJNU5RYTZMWmQzRjNVcXhn?=
 =?utf-8?B?NkZ1cHZhcFpYRDYvdWNsS1hMWEFsMXM1Q3IzQmE1ZUtMbmFNZFkwYjIwTEJJ?=
 =?utf-8?B?TXpWdnZRNkJJZ2NweWRGVmREZFMrOVFtYkZ1TDBsWHczdnVjU3g0TXlCK1ZE?=
 =?utf-8?B?RzlnZ2hkRlBoaVZkbU9mbDdOT091S0tQV2pwcjN5RDdVSDhkM2s3NmJGaCtK?=
 =?utf-8?B?L3k1N1FjZ3JQWkl5NHo3UzMzNWpQWnBla05BN044VkZaYUxWNDZ3SXdVNllG?=
 =?utf-8?B?azZWWDBvVjdQRlNDWjJGTVg0UlQybTFSdmgwendscldKcm5scmdrU0JkM2k2?=
 =?utf-8?B?REJFSlI5NFpCMWRmYVU1aktSVisySzcrQ3ZYV2E2SW5FcUVCMHQxYmNRSm9y?=
 =?utf-8?B?UVVaYjRHV0k5cmYyN2drb1YzZ2x1OWdldXBqOUhDbTVTREhpb2dtZGV1dkk5?=
 =?utf-8?B?ZE4zZnQ5QUlxWGtVVmNJZXcwVFBWNWhibWs4dmFjOGlMM0UyRkZCMlUxWkVy?=
 =?utf-8?B?Z2FOMXZRcTE2c0w4VEhOdHlQVWtJK2FQd2RnQ0dQZXFpQ0dqRWVERWp6cDdp?=
 =?utf-8?B?ZktXSk44UVlDVUNieUFJNXNFazhIUldaSU1vZVJBSVRrb2RDYTlsc2FOMUZ1?=
 =?utf-8?B?QmkwMW5JWGl6WklCNkZIdFMrSENNNWIzdW1wcStNQTEvV2RMK1hBSUVMb1Zm?=
 =?utf-8?B?T0NFZ1J0Y29VMytGa0FDV0NuVzBZM3dEYWJuSEdRd2ttNC9INll3RXdpbE42?=
 =?utf-8?B?bDAzU2pzaStURzFockFlL2tkRExIOE91UHFJaCt2MGNGN1NpNHdWclErRm81?=
 =?utf-8?B?eWF4bTl5dFJ5VlVLZURZb3JXbVJpVnJwWDU5bGl4K01ZQmE0aEY5NXdWa0RS?=
 =?utf-8?B?VG5UOC9qWFgzTVVEWG00MVpsN2VoWTZBMGhOSGszcUxtNkd4UHgzcDBnZjYw?=
 =?utf-8?B?aCszRGptbWp1WVl1OWIxd1ZTdUh5bWlYRjBOWklpWVFFSGlPc0xBNTd6S2NO?=
 =?utf-8?Q?qSvZ2atpdHC1CvEzab2gmhFKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab089a9-905a-4950-6dbf-08de3cd6c065
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 19:10:18.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzJ1170bR0PlWE1F2DIVGATeeXovAeiJhZe8UPML7VwzMyeuNZs/BsN1DFJ8bJMde8GH6IiotuVULoVKAAYRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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



On 12/16/25 11:21, Timur Kristóf wrote:
> On 2025. december 16., kedd 9:27:34 középső államokbeli zónaidő Alex Deucher
> wrote:
>> On Fri, Dec 5, 2025 at 9:49 PM Timur Kristóf <timur.kristof@gmail.com>
> wrote:
>>> Fix a few issues with the initial DC analog connector
>>> implementation that I've noticed since. I highly recommend
>>> to backport this series to kernel versions that include
>>> the DC analog series.
>>
>> Did you have an update for this series, or are they ready to be applied?
>>
>> Alex
> 
> Hi,
> 
> I re-reviewed my patches in this series again and I realized that my comment
> was mistaken (I confused link encoder with stream encoder). So the patches
> should be good as-is.
> 
> However, in the meantime Mauro got back to me this weekend, and told me that
> he determined that the patch "Setup DAC encoder before using it" not only
> doesn't fix it, but regresses the analog connector on his HD 7790 further.
> Before this patch, he got a black screen on boot, but the DAC started working
> after suspend/resume. After this patch, it no longer works for him even after
> suspend/resume.
> 
> What do you think is the way to proceed?
> 
> A) Merge all patches but that one. I'll submit a corrected patch once we figure
> out the HD 7790.
> B) Merge the whole series as-is and I can submit a fix once we figured out what
> is going on with the HD 7790.

Plan A sounds better. Let's not merge a patch with a known issue. I will 
also share test results by the end of the week.

> 
> Thanks & best regards,
> Timur
> 
>>
>>> Timur Kristóf (5):
>>>    drm/amd/display: Pass proper DAC encoder ID to VBIOS
>>>    drm/amd/display: Correct color depth for SelectCRTC_Source
>>>    drm/amd/display: Add missing encoder setup to DACnEncoderControl
>>>    drm/amd/display: Setup DAC encoder before using it
>>>    drm/amd/display: Don't repeat DAC load detection
>>>   
>>>   .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
>>>   .../drm/amd/display/dc/bios/command_table.c   | 44 +++++++++++++++----
>>>   .../drm/amd/display/dc/bios/command_table.h   |  4 +-
>>>   .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +
>>>   .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++-
>>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +-----------
>>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>>>   .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ++
>>>   .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 ++
>>>   .../drm/amd/display/dc/link/link_detection.c  |  7 ++-
>>>   .../drm/amd/display/dc/link/link_factory.c    | 10 ++---
>>>   .../dc/resource/dce110/dce110_resource.c      |  2 +
>>>   .../amd/display/include/bios_parser_types.h   |  2 +-
>>>   13 files changed, 87 insertions(+), 51 deletions(-)
>>>
>>> --
>>> 2.52.0
> 
> 
> 
> 

