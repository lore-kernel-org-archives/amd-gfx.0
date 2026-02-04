Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1882FE7FDCF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 06:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBEB10E116;
	Wed,  4 Feb 2026 06:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UbfK270Y";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C5210E116
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 06:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJN9sIrcVUAV5HliQhn3PXXU3vEuPgEMgHZNxjyWB586kIZxP32geB18wOEJPEp0yeY8xnn1u29aGt2hnyUPr/s0meidCPopJC4rkFD7pEQosdE2oXQy3NVLwNlRFEgQhXhz25F0CVhrs+zyU+ARbS2WDbTmNDGrUbUKSuM8okOit2VM6RkWyxxkg/e77DlWj2ZET+X8KXdrGCmsPBHeDHdOPj9QysvUwkM1zvmjX1mDjVrGj3elUEBeYsqNYq+DHJ2MMj8nDwLxxwjbNS/sqLueABAyz+L2tEwdsTDZ3L9qT1GA6fBQ9bW8VyIg0eAYzM2KmOcGpoErI/buv4oc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWEu0U8oQFBQ7qfbRt5V3beco+qY/Z4gB8wM9S5BdIw=;
 b=jwNILRNPpZuernOWM4moHXOtKyN82mLoufWfyyExBIIkNfIyGkZ2miIf6AJ4pKWydQWsEYEP9EeUyoeMdHLQWW1n92Gh32pC0IiqG5+zf1mDnGdYzjgdDRf2pyZ0Ph1LdES8FA74tpQv9OWXQppOeDNwA6c6aqJwCrqOjgdJNejrsoCS1argmJvM3ePOEr1jkhl2pG8pB09ISb4dEPlwelM4x5B/qPPUf/7o7wgOBdumlavrb4K6a4nfojtLJodkpJuvrVY3TGUbx6ZfVgPo0IskKZEr+/SLm3NMr7nziGj52eeAx5nD7z11kbeywNZHmsnxKZF6Z2ZBAzcrO327xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWEu0U8oQFBQ7qfbRt5V3beco+qY/Z4gB8wM9S5BdIw=;
 b=UbfK270YB0JCDgvJh7KtDK6b1VLte7m/2pZKUCrmhS8RY8H5PkmENdKbnXhvwJ2ds3HJo7ZRswoYMELU1cGCjn2zpwjQbUQW00ZjyG0fzkCmIrd44efY8dRdlJjKPgS/OiLB5veSJtch31f2bhf+yrSp1SXaB+itkQ2IyQts2HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 06:14:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:14:38 +0000
Message-ID: <8b52e3ed-1f37-4996-a2ef-f2cac15305db@amd.com>
Date: Wed, 4 Feb 2026 11:44:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260203065529.1360282-1-sunil.khatri@amd.com>
 <CADnq5_NA2ghiTOJ=Z=jw0pv5TLX4ZvV13un1BxBFTzEmEw1OSg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_NA2ghiTOJ=Z=jw0pv5TLX4ZvV13un1BxBFTzEmEw1OSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: b69fd853-d2d4-4d7f-0ded-08de63b4acc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkJMc0Q1OW1RZmhoc1FPbHU5UzgyZXlWaVdiNzcxY09BVnhwZE9NWFcyRHNE?=
 =?utf-8?B?VS9XWk5QVTMvVmRQZ1l4WmFyYXpNS28xbFZJUEx3SnU4VE9ZYmllWGgwZk1M?=
 =?utf-8?B?d0ZDZWNWWjh6UHI0YVdCWEpKdVhSUjBzS2o1N1hZMHFWTHVnQS9NWTBGWkdh?=
 =?utf-8?B?MkR1MGNoK3k2Q09UcFAwcGhhY3hCeE9OY0NVZVZvcEt6emUwak1BOE1Dcjgv?=
 =?utf-8?B?S3U4T0srcXRFZWpGZkdFeXZZSEFRWFZ5dTM3SStqcmlleEZXQlY2MzNsNmEr?=
 =?utf-8?B?UWNSa1AvWGxsWWwwN094eDNvV1NaVStYYVVuQm56RzRBSHYyNHlOV1RFWlB5?=
 =?utf-8?B?Mjh1NFp1Mk5DUEg5ZEsrMEJOUUNlcVAzdGNOWVdGdTBpUnBoMk1Fc3F2NDFY?=
 =?utf-8?B?Q1hheXZFUU8zVFRKTUc2OGdkcGNieHZkc0VlZ1NKMFl0MTFiMkxqejMrWFBa?=
 =?utf-8?B?dCtJZTJDQ3dWV05GeURBZDhuMGtMa1VBN3BDMjYwajhSWXd5RVo4VWZKS051?=
 =?utf-8?B?K2ZxVjlRWjVidlVoRHdyNHJSbTdzRDVYZUFVWlpoMjkrbjVHOFpGT0xndTJV?=
 =?utf-8?B?b3FoVUpHNUVsVEJCTlRxTmpoZGdhVlBxZnV5K2U5U05mai9FNnFTWW1PSkZW?=
 =?utf-8?B?WjI5RVdnL24ySUdOV0lLUlhQUEphSHJISGRWQnU5SU8zSHhNbGwxbDNUS25v?=
 =?utf-8?B?NkU3S25SbnM0Z0dPMGVRMWRqZjI0VHJrSmd5RGVrcmp4ZmhicVFPOGxEaHNR?=
 =?utf-8?B?d09ScWk2RzJKT3JURE4xa1pwWGYxTkc0SzF3bUlHeXFJdUFWZXZTczVzYVR5?=
 =?utf-8?B?Wlk1cGpFQzVWODNDdmpNYmZ0VFlqS1h5VUlBODJHNGljV2pFSGlqU3pSVEJh?=
 =?utf-8?B?VS9xTFJuNlhkK0ExdGQvdnRaNTlGNHpjcTYwb1BtOVdUVDNFeG1WQVZBaTZL?=
 =?utf-8?B?SHArOHlFQ0ZpLzgxdS9aZWNOYk5qMFFGSkREVUxPNU9MTHVob2haaHVZTDVK?=
 =?utf-8?B?WVhIcnZkT3R3cGRFQWRnRGFQclYwU09yZUowNFhoNHhNcEJEOGVkZGk1bTZx?=
 =?utf-8?B?a0ZCYUFOdVFRdlpJNXN6TmZkamVKUmlDMmRIdVFKcllZMURSSWRNVzBhTDh5?=
 =?utf-8?B?SGxwOS9ONFhPRzU5M2g2RHlDcHAwNXNLaDZod29nRzRTZS9TUEt2cUVsbVAr?=
 =?utf-8?B?eUMrbHI4ZjliQitWVlE0NG96OW5sNEU0a0lZWlJ0OU1ETHpXcERUcVFPWllF?=
 =?utf-8?B?NHhiQU10L0Izc0NUYTZhVGlpL09hUlBMa0hvK0d1VHM2ell1Zzk1TGM2Y2Vj?=
 =?utf-8?B?L1BkUUM3dk9CMDlOSmliWTUwSEVpRmJMb2lhYjlXSlRUbWFQa05XaG1KcTdr?=
 =?utf-8?B?MHFKYkNqV24xd09ocGRzL0xKeWJpUFFJMlZ3M3FsUnFCVVdHNlRHN1F5a205?=
 =?utf-8?B?OUFVeEttUXVDUXBhQ0tRbytVZG1JeEpCMkc2cGxrcnAweW4ydGRMWDhqNUQv?=
 =?utf-8?B?cUVQUlNEb054bjhCclJFdHh4Lzc3eTgzSDJaVjZkSDF5aWRCanJlRmpzQlJF?=
 =?utf-8?B?TUxpNFZNUzJHVDNRczhSNmVJdnlsd2dwQk9jMDBDSWRTTFEzWC9hdEhJL1dW?=
 =?utf-8?B?d3BmTmJxV3ZpYlFSMlhQcmNYVVlxMGNGcnpXWEI4M29URzUyU2FJblFNQmQ0?=
 =?utf-8?B?cVdMZUo0S3ZwMkNGakdXTHpWYjB2R3JsM1dvcXdVNjl1VHRPbjk5d2hUZk1z?=
 =?utf-8?B?YThyNEthdTh0UHhFQzZBMGJoSC9XMjVHOWJydmRxRDZ3RDlqdDVxd2plUWhD?=
 =?utf-8?B?Ti9Geit5dnJVTkh4YWJqV3lBM2FMTmoyRS9nTG1qSlh2M0txcklvNERITWZm?=
 =?utf-8?B?cm1tanpkaXFkeVFaRC9QNjZWOEFtSDFZU0MxYUk1N20yVlJyR0RVL2FXc3Bn?=
 =?utf-8?B?UHROQXF5R0owcUJzaFNFNkJOUDluMUZ5WGRQOFo0N0tmcndKdXVMNjR3b1Ir?=
 =?utf-8?B?S3BJcXdlM0Rkbm00MkxMM1NBR2lhL1haZWNEeWp5RU9Neml4bmlVTWYvaXNQ?=
 =?utf-8?B?M1hycHNnUDBmTms3K01lY1ZxUnd0elZQUEtyOUFPRFpjWm5UbC9XakNYaGZn?=
 =?utf-8?Q?CLCrQyinDBUlg0UeR4aKFCFx5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBucGNZSHdkb1EvY3BXV3p4YTFRcE1telQ4dWZQUSsyaE83b3MvZWhBeFN5?=
 =?utf-8?B?VDRYaGR2dnN0a2VyQmlRdmtNdDdqWTVveFErY3k2bEx3ZXhkdWl2cWFSODcz?=
 =?utf-8?B?R3Y5QjZvQ21OODBMejZWZFROTGo2aHh3bkJLcEtSVmdOWlJWemlsZmNQNUR2?=
 =?utf-8?B?WGlsVWtvZHdZTW5velFOUGVkakFIMWlZQ0xoUzFUS2d5VGFwRmRJUGJnOFNh?=
 =?utf-8?B?bitTZUNXZnNqbjZOSEl4OWp5WFlhbXgvT2pnS1FKbkxGNFIxWVdtRmFMNlI1?=
 =?utf-8?B?QW82b0tCVitkdTMvd3RlVWxHS3pTNklUc2FjM3M4QkhNRFVpTmtJQU9XRTgw?=
 =?utf-8?B?cytJdXpxa3lBcnlQUWJLV0g3SXBDWVhNREM3Nlg1SWRQU3FNV2x3V1dNUUpG?=
 =?utf-8?B?NjF6NjdFcGN6TFE5T2R6b2FHa01tSlhiODhnVFo2MytkMVVlOFZJUDM2LzRF?=
 =?utf-8?B?WE5SNVR2ODJLdkI2ZWxudlp4L0daRUVvYWIwU1VxSlA2bDVjandPd1NZeFRX?=
 =?utf-8?B?dk10bDQzeUlxVWJyVmJDYWpiYzZmU0V5UTBYc0lrL3lKNEd0aUVhUmdSMGpE?=
 =?utf-8?B?RlM4VmpSYzg4Nml2Y2xKTVc4WkNNY1EvT2tWcXA3Yi91RHNYU2NFbWtDYlNE?=
 =?utf-8?B?NzIwU3JsNm41a2Y0c1BDNTRKaFpSVXNVU3NVY013MmVZLzR4eUFqbUJGbG80?=
 =?utf-8?B?VUFNaFNuUlp3Y2NGbDVOczlKSG5EeUR3RGIyRU5RSWxhN2xXS2lMTFZWK3VQ?=
 =?utf-8?B?dWVhMk12QWk4ZGdlYnFvYzRKRkpQeUtGSG4rOTVxRmRMVWt2MkxCS0lmVGFQ?=
 =?utf-8?B?b2tRYjB6bVkxc0pZMG5mSDg2UytWcGM0SVdreTMvaHhoSTRWQzRNUm1kYjA0?=
 =?utf-8?B?L09SN1p2SGREMlpERmlhbVEzenhzL0ZlTzJOYVRHaWliWmVwYWsvc1JOd3Q0?=
 =?utf-8?B?NTE0UEN4YjNkMTltZEFLOVRHbFVCWk03RHZOTWJLT25DV1V3YlhsWXpSbzdW?=
 =?utf-8?B?MHd4YTVqR3JvNHJJaGx6cU0yYzEwVGNkcEd6WlhjcndxcnN4TWJsZGozbHVJ?=
 =?utf-8?B?Y3g4UnpmSDlCK2pPV2d0anRTSTNoeENoOUJKL2V3UXJueVAyMktzZERvZ2Z0?=
 =?utf-8?B?WGVBNlBleVFYT08vKzU4Wk1DU1lHbUIySDRKQlh2RzVQMkhhSlhhcnB0dzYy?=
 =?utf-8?B?N2NVemhmTjNCZ2pqQ2FESVdxOXVtQjRGeVBYanh6Z2VUVDFUd2RWSlN2OTB5?=
 =?utf-8?B?S0VXTUFlVG12Z0VIaTU1V2F0Z3ZNZUJQQU5aZFlrQ3dMM0tqcVFucjFJRndj?=
 =?utf-8?B?UVBkQWhGZTRSVnZhUXNINk50VGt2aVBSM3d6cWs5Mld2WlBlbGNHNDBsMHlY?=
 =?utf-8?B?cm9aTk9idFpLYXFXcmQwamFZa2ZhVjJ5bmFHV21FcnNscXZoc1J0SHJGVk8z?=
 =?utf-8?B?VUhidWJrcndpckxKT29oL0E5YytWTzN6ekxHWDZnS0pPb09vUXhSa1Zldllr?=
 =?utf-8?B?NE9DdnR0TlBWdjdWa0gwR21CN1hxSXZZdkI0MithY0J6Y1NTR21sVlNER1or?=
 =?utf-8?B?VnY5ZGkvSU4zMUsxTU51YU43QnRqRnlqb0pGSGFlZExVWSt1TTBnZFp6SUZY?=
 =?utf-8?B?Z2QyNXZ1dTAvcndLanh6U2twS3ZGUXdxMzRid2xtWmhVTkJieXo3OEdGd1NZ?=
 =?utf-8?B?Qyt3c1ZUWURMSUlUcVZMUVhlU0Y3K1RJeWNlcTA2OTR0UDZ2ejM1ekhlUTFQ?=
 =?utf-8?B?eTZSM0pIKzRQaEpIUWk1OHgwMzl6dGNyemowYTJIVHdraVRQOGx5OFFhNFl1?=
 =?utf-8?B?dGRXdDB6c1BsOWR6V1N0VkoraGh5UEYvcUZORHphWXJmQmRoc1daUzdFTU41?=
 =?utf-8?B?bFBtY1NZRk83SEZZSHhRNnFsSmtNWGd6Ykc1UE5WNjNNaE02bVdpRlR4OWdI?=
 =?utf-8?B?YWlWa2F3WUFySXZIMHJPQklHbHV4Uk8wSWNhelhzNjV1VFQ5eXhZRFdyMS9M?=
 =?utf-8?B?LzJ6di84NVY3WlRDTWxtZGJHbVNHaURnYmtDY2dYU3hjVFZTanRXS3NISlk3?=
 =?utf-8?B?ODV2bFNpbVR0dDY4NjM4SW5NZXBkV2Q4OXlHblRnTGZsb2lLa1QrMXlSUEVL?=
 =?utf-8?B?V3pPK2JMU1EvUDYwK2l3cnFIQUdRdzcyNmlua1hoNVRicE1taGdtMFBveXJr?=
 =?utf-8?B?YWk2aFhhb210ZDFBc2owVmJ0UEd5ekUvdTUzSStUdE01UUR0S2VZNnNZZzZW?=
 =?utf-8?B?dXJtNDNydnBPaG1aREwyTGo4RWpqN3NFNjc2aHljMlNTV0VXMEcxVG94Z1Ix?=
 =?utf-8?B?c1Q3bVMwYUZRTC9jNDdmQXhoeURSZkkzR0xYZGwxUDdiUWhYaWRXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69fd853-d2d4-4d7f-0ded-08de63b4acc5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 06:14:38.0961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLwUnE9AHJFGFR2VzfGFG4ZNM3qCOfAgK24Fdwh9sX7PYtF8Md0SuGyUC2yqQ257Pacr84ZUvMtwYdwme8dLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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


On 03-02-2026 08:12 pm, Alex Deucher wrote:
> On Tue, Feb 3, 2026 at 2:09 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> In low memory conditions when kmalloc can fail and hence
>> we need to clean up the memory and unlock the mutex for
>> clean exit.
>>
>> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index d591dce0f3b3..831063971f71 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -892,8 +892,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>                  struct amdgpu_bo *bo = e->bo;
>>
>>                  e->range = amdgpu_hmm_range_alloc(NULL);
>> -               if (unlikely(!e->range))
>> +               if (unlikely(!e->range)) {
>> +                       mutex_unlock(&p->bo_list->bo_list_mutex);
>> +                       amdgpu_bo_list_put(p->bo_list)
>>                          return -ENOMEM;
> I think this should probably be:
> r = -ENOMEM;
> goto out_free_user_pages;
Agree, that's cleaner.
>
> Also, does that error path need amdgpu_bo_list_put()?
Yes we do need that i guess.

we are doing amdgpu_bo_list_get or amdgpu_bo_list_create which needs to 
be cleaned if we failed here. Let me push a new patch based on those 
changes.

Regards
Sunil Khatri

>
> Alex
>
>> +               }
>>
>>                  r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>                  if (r)
>> --
>> 2.34.1
>>
