Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F91EFB816
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9373710E513;
	Tue, 24 Feb 2026 08:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m101UwfY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4081110E513
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQKZYCuRWMae/sFuOwwyNWXYY6s0c3hj8DpOPqEWB9rsxPRQgpY2AcQTkZHGnfZGo3S0cUcqYszatf8hzR1t42rVdDKVHQ6z5wLKlOyItK1b8KMw1HOI5WLzTyWr/ryj+JP1GaPTFgqtqurgks46rfjbd72RG0E2iheoIGxyhkGD+HDCO4+AATVpKRegY5YvgZQApjX1QcoVqBTY5ux9TKZGPzouzPzUyU/7696AxzaP+u5yAAzfjyUg+0zq11Owixs96WqEu6ugF3U5tyHvjAp3T7Ik4YiqmeEI59AOIYf58zEddg36FAOQ+no8BFzFydyc7+ttpoozio9VznGX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPFlPW7JfQ27UQLqXr5K8rGE8nuIz3cB4pwqylvn/dM=;
 b=xYiQrK4T3F5pwQ0SKJU1jgphF6FT6ZMC3SRc+OoLIdEJlP0rLOMBDCayx72/q7eKWhlE0u6AFF6qjtso3kJ1ZZLCPjCjoecW/xq5h2lD7hKfVhDTuBAfMypM3a0RTKnInDaIo5KHpCnjPdynN35h3NYV8iEX2d+lRnUmiMqAraneFuikw1a8clKZbvX8AvHI1BVIN1TDxo+38ywB18IXwdRADzXoc4MwzsHZnKLCMHXaCLFIIePGwUaj6I3H2GUZgy6xq3uPGhfvj/CKnF0CHmFASY4b93LZuGBjnlw4F2/OiLvjdAcRSDCSwHgNqH4oqqC4aNFWUWHgU4DCOxSrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPFlPW7JfQ27UQLqXr5K8rGE8nuIz3cB4pwqylvn/dM=;
 b=m101UwfYQ9Qm6KKcVLLYaWc3Ey9iWjJWIfdfD1DnkbR/f+GNudp7VD0CdUxdmGiCdDufAKJPEDJxEshOMF0LVjLAO4SUrPcqEwtfGulboqTyvoUB1nMFYUNpSUIOhW/3Mh//3X7pSCFHjBswV/hj18b7GvXi4HR1FYCPuheWEG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:46:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:46:52 +0000
Message-ID: <adbcf4bf-60c6-4dcc-837d-31c9c59d39b0@amd.com>
Date: Tue, 24 Feb 2026 09:46:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <7f851448-e4b8-46eb-9f38-4d45e0321e6c@amd.com>
 <1d38bf92-19c8-46ad-9319-2487f59958ec@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1d38bf92-19c8-46ad-9319-2487f59958ec@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a241a-8406-461f-a140-08de738141c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHJrb1ErcGpnYityMHlmR3hpdzEwM3JYRlJ6aVpldk1ndzMwVjhmT0hiVUVK?=
 =?utf-8?B?eXFxZ0IzLzQvSjdwdG82aEZ5U1NEQ3JTdGdkYkljOFBqRm8xTGlPZlovVjdX?=
 =?utf-8?B?dnhWWjlMZEZlVzljVFU3T09BQUozR3RaV2tjU3VMeWR6RGRrWXY4QTRqdDVU?=
 =?utf-8?B?ZVdMNU5iMGlkbjNvZThLR3NjUy9QR2ZiQ2tmS3EyekZQRDNIYXZVNG1CN1ZP?=
 =?utf-8?B?N292Q3hUVEpuL0F4c0cwazMxdTdLbFF5c1FCaUxhUVlnUlVnUVlUZmpWeWRs?=
 =?utf-8?B?dHh2clloR3ROMzhtZVpVNS9DT05pM0lDRlVnR3ltdHhTY3JjYzFDREpNdlVO?=
 =?utf-8?B?dHBJY0J3Z3FvQjcvMXVUTGs2bDdGRHZwdEFnS3FGSE5yeXB5eUJkU1lFNHUw?=
 =?utf-8?B?dDFqb2QxaC9hcGI0R251Umc2T3dhNXIwQ0NsdGRkZWhSSjVRUDF5NUlNa0RH?=
 =?utf-8?B?ZlBRUTdVeCsxRnFHaEpWOTdDd1hld0JYc3hTdkk2dG0rNlIzbTJBRUJWbUNG?=
 =?utf-8?B?TFBrKzJPaFNLcytLQmNaN1Zpd09HNTIzbkFsWk9rRWhyN2oxZnNBSEM5R0NR?=
 =?utf-8?B?WWUrLzNaZDlXRWNCSlpPSTdnUCtZSjIzVDFXRFF6T0lVNU8zQ3IvQitYd2h4?=
 =?utf-8?B?eCsvYmNtRkx5ZmUrbndDZW1KYW9heFdqdkN2U2Y2ak5QSTdXTG1XdG1VcHd1?=
 =?utf-8?B?QWNPWE9ITlordUYzL0MvOE1ROHNFLzd4aDVNOG9JRmxoRXZYbmZ2Y09iTWlk?=
 =?utf-8?B?QXFreWRiM1M4cXBRVTgrTTJGdEtQaWREK0RrR2FkYkcwekRNay9pS0dkemxx?=
 =?utf-8?B?eFFYUWZvcHFrR3JSdWhGVEE1bTlydjZmemlFZEY0eHBJb1JEVkNla3hoTFhH?=
 =?utf-8?B?UDdGQ0ZrZVVrd1daVDhzVVZHdTIzSXg1d21jZUY5ajFIWUVSWEUzQnZ0b1NY?=
 =?utf-8?B?OFBacUptNzBRS0VuZ3lRYmpaRXNwSUJyODJVNGN1alRyc2s1R245N21EN1p1?=
 =?utf-8?B?dUI0K2YrOHVWbWdXNmlKMm5wNTNZY3NDV2daQzFzVkRyNy92TnhUeU9Vekg3?=
 =?utf-8?B?S1BwdFM1UnlBTHhIbEdSaGhXWU0xLzgxcG96STV6Vk5EbDJXQzdJb2ZLcFNs?=
 =?utf-8?B?VEtvZEtWKzlhYUJpRVFSZlFCY2pHVTJKYlk4OVBiN3ROclZ6U1kraDZFVEJO?=
 =?utf-8?B?ZFdMcGJCTXJLemhpMHhtZGxGR0o4OXB0V0FsZmRmcFZmdUYyRXc2OFBNVHVG?=
 =?utf-8?B?MEZzZmh4bkxCR3A4bDNrd0VzTkduN0hmYS9CaDROeTdHdEh6L2x2TDk1UHAr?=
 =?utf-8?B?QXYyQXJLOUNoVlJ4aTVUYi9PQ01rTFQ5Y0laUGloY1gyY1BPZ3dJZWpmVHJl?=
 =?utf-8?B?amYxVnRRcXp6NzJnQjlScDlFR0Q0eTcvSmg5KytKVm1tZ3hHNjJ3aEQyQWJv?=
 =?utf-8?B?aXovcXlVK2FmQ2o2WEJCdmlPa1UvUnRPUFdkTHlmVmlUcmlHZU9IWVlWbHdn?=
 =?utf-8?B?ME15NDRTaHlPNjltWVdMNXh4cHdCZUhsbVVZUWRUbEdZL01QOEYwR3Z0akpJ?=
 =?utf-8?B?UUhPMzFETGxGbnAvS3Z1b1NUbHBrb2hzVkdiTUFVdkg3MXdwaUNUZm1ER0dP?=
 =?utf-8?B?aGJRakNOMkd1YTdWd3ljQzR6NWVWaXRQU2FNMVBuaGYraHZLLzVaSytRL0pT?=
 =?utf-8?B?YTVoOFR3UFN0a2ZXQjBkemJsakZkODRIQ0xPdFAvTUx0eXFuUmowdzZkM1RZ?=
 =?utf-8?B?eVFxZ1E0bDBrSEFBYmtuTDZEWldNajV3UEl5U1I2c2x6WEhPYjdmbEFpWkJK?=
 =?utf-8?B?SjhMV05EbzlCVWZRSE0zODNtVDAzQy9tSTFHSzVXNGJ5MExodVBBY1ZqeTBn?=
 =?utf-8?B?VnVtVUlkN2NrOC9TYUhKL3pVenJOS2pXOFIwbVh1ZDQ1OGhNS0dZVmlyb25F?=
 =?utf-8?B?WWJpaGhMaHMrczVJd01TLy96ejZkajJuaDYrVXpTTWQwS0ZnODdxbTRmWGZF?=
 =?utf-8?B?cXBLRzZaOW1BY2xjMGloeTN4c1ZxeXBxTXdGNmpCbTh2L2NWbXBLODBmQ1N3?=
 =?utf-8?B?VlIvSnZjMkVWVFBJZXdmOEpXRnZ2VEhRcU9oR285QmV4N1NMTXFvNUd4VDl1?=
 =?utf-8?Q?jozA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akd6SlRkTGUxekVxN3B5NjlWQ0s5NDRJZTkraW9rdXI4a0ZQSVdURC9jWEow?=
 =?utf-8?B?OFI1WHAyS1Z3NjNQb2txc0JPdXZ1dHFNZlpUTUM2d1N3L2xaQlpjZk0xb2Jw?=
 =?utf-8?B?a003NlZOeXpwWXpZVUhUN0o5OWdzbkdSZGQyMTFOdlRkY0tOMlBUeDVYM0VW?=
 =?utf-8?B?b3A3KzZTQ3Ftc2pvYXk2TEthMGRuY2pOSWthbERiRWJoWnZCdmRua2RuTTVv?=
 =?utf-8?B?N0JFZThnQXBZd2VhY1lTSFRYLytYVHBlcFMvM05tVkFkbm5IbzRxRjUvUjJ1?=
 =?utf-8?B?MkZ4ak1RaGI1SnF0eEF5VmFYRHJSOEVtaWVhT3pwTy9QeWdRcEtCQlFhQWpI?=
 =?utf-8?B?NEJQY0M1TjZWaDZLZkZORFV1TUZJbXFhb3NpdzZsckpWa0hxbFJxYW5XSUlh?=
 =?utf-8?B?NVduNkQ3S3ZseEN3OEpJSVpxM1pPUXBTS096ekpWTHYrOTN2NE1jaUlzTUlE?=
 =?utf-8?B?b2E0SzFRVEJvVkVML3c1K2dJYTZIclBHbG1TTlBQT3QzcGFtZ2NsWWNSY3pG?=
 =?utf-8?B?aG9FaWp2MjJtbXBBbXFjQmRudEtmYXJyZ3d0ZHpld1FmWDNBVnl5R3RjVFNK?=
 =?utf-8?B?eEVaaWE4N0RlWVRYRDRGa3dJbmxUVjJsU0g1WWlxL2ZBR016dCthcThVVGtt?=
 =?utf-8?B?MkM5UDFLeFR6Qk9HM01kNHFuUWk5ajZTMU5yOEpreXFWSGs2R1V2eEhhb3hq?=
 =?utf-8?B?NXgvQXM3UjduOTRUSXRsSThrL2VTUnRWLzB0L0ZiaGt3VnEwQUJnczJwdmZ3?=
 =?utf-8?B?V0ZicEtPUExRTjdLejJaWVFONEx3OU9IZ1VXTUZHKzNhY0V0US9aTllOYkpM?=
 =?utf-8?B?ZXI5WHg1eUlZdVo0d1kvV1g3SHg4a0srM1l1cnptVmJ6aUVLQ0VOUUUvRERz?=
 =?utf-8?B?emFxZUxvL2xDYjBPaG5VWWIwT3JrNlVZRVVoVXIzL211U1dKVEhCRXIxQ1BM?=
 =?utf-8?B?cHZyc2Zkd2ZQai91aGZvTE82dlJhQzR4ekFsMjdrMTFBVmVvRTVuMWF3MVRL?=
 =?utf-8?B?a29Ya08xb0d0OCt2THZrbExRS0VFc3VmeklIRGM0TThOMGJ3QzNKajJHeUIx?=
 =?utf-8?B?QkRya2xIeDhFRDNndDlXTWp0Mlc5d3VyV0QwN3ljZVZ2VG92U2FyWVFKdSto?=
 =?utf-8?B?S3RYZFAyZytxbkZJcjI0RWVVd0RZd0ljZEQvUjBxTS9tZ1N5YlV4YmI0K05w?=
 =?utf-8?B?WDhyZ0FVZ2N4dkU3NjZqeWVsUXUva0NTZ3dSYzgvOG1XQklWQ2ZDbHgwNjdw?=
 =?utf-8?B?enp0aU5rYXorS0xnSVB1NERMSVpxcUZBcFM2cGFWQWdHb2c0a2d2WUZLRzh5?=
 =?utf-8?B?UXJFZHlWVjZKbUFIcjEzWDVqdEtrbDFTMDd5a0xRVk1QTWE4aVI4ditub1Nh?=
 =?utf-8?B?RTk1UWgzRVZOeWFHNkJNMnBPbTJDaTJrTDlCbU12cVlaS1c3OSt1QlJ2bER6?=
 =?utf-8?B?ajgrSGk1a04vK2xYb2JnQzFyTnZHWEJtUExFRkpjbnJ3SFYzc3BXam9oOWt5?=
 =?utf-8?B?NjFMWTVwRGlpNjlVTHZXTndMYmdMa0hIRkhvdUtQMTZMQjJvTnZwM2hNMXZz?=
 =?utf-8?B?SUU5MXpEUzdpRDBocUROYUpEL1dWeXFTNVB3MTJORUZnRUNvZEx5YUh2WUhy?=
 =?utf-8?B?VXhtNktGV2FhNmZNbkZOYk9pOHhrK2h3a1l4dHFHaHJlNVV2ZlRpZ3d4Uy9M?=
 =?utf-8?B?b1Q1NlJEYnNmVGtrM3ZPY1Zadnd0YVQ5c3RJNGtkUXpCaVNjSlZ0WHB5KzZM?=
 =?utf-8?B?UjRONjZiem4wb2E2L3FQNDh1U0VLSlhZek4vMnM5RjFkeDZ0RUN5U3haVzBr?=
 =?utf-8?B?SzdaUEoreW5MSTd0Wm1WYjE3cFF2c0RFSElYTjZhTWViaTliRTcwTDZ5Tm9S?=
 =?utf-8?B?ZnpGQTJCaG0zM1Rod3E1Nnh3dG5DM1NzOXc4Vmt2UE8zU3Foa1IyRUYxMVo4?=
 =?utf-8?B?MDFpWG5XNVgzT2N5TDFCcGNxSDh2WkJZVjJSMXJxNWc5amVFZjFwQWRjNlVo?=
 =?utf-8?B?ZzBlVFNkWlF6RWs3d0JxN1FyaW1SODd4Mmp0QUVKdXdXd0E4cnlkSGg2VGl0?=
 =?utf-8?B?MmExVmRYMGFDdkxxczFpSVgrRWlvZEUvejBQT3BDVGlDOWltV2FMMzlHZUdv?=
 =?utf-8?B?aUhnV2JvL3IwcWh1U1FRMldKMTV4SjV4TUZUM1RONWljSmZnOVo0NUhJcU0z?=
 =?utf-8?B?QWh0ZDFKVDhQeVVlcTVLVXBCU0pnM0plbUpsMHY5TjdnR3ROd1JNU001UjZU?=
 =?utf-8?B?eGU4L0lwc1J1d2pleVpBVlRJZVJaSnFHMVVsVENUdTROQmhrTXZnZW4waWtx?=
 =?utf-8?Q?rGywaTwgwrtSdeQgwh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a241a-8406-461f-a140-08de738141c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:46:52.6314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5iyAclwegURsON5GwQ3bnMbGLcSIJIxWfqP6I/URX0EOrWJpZVY4l10NSr758Sa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

On 2/24/26 09:41, Khatri, Sunil wrote:
> 
> On 24-02-2026 02:09 pm, Christian König wrote:
>> On 2/24/26 09:24, Sunil Khatri wrote:
>>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
>>> remain uninitialized and during free cause a fault. So to handle such
>>> cases we better set the gobj_read and gobj_write to NULL.
>> Mhm, that doesn't sounds correct to me.
>>
>> When count is zero drm_gem_objects_lookup() sets the resulting pointer to NULL:
>>
>> int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>>                             int count, struct drm_gem_object ***objs_out)
>> {
>>          struct drm_gem_object **objs;
>>          u32 *handles;
>>          int ret;
>>
>>          *objs_out = NULL;
>>
>>          if (!count)
>>                  return 0;
>>
>>
>> But could be that this was only added by Srinis patch and previously we didn't do that correctly.
> 
> For now i see the crash due to random ptr access. ASDN does not have the above code and we need to fix it for now.

Please ping Alex if cherry picking this one patch back into ASDN is ok.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>
>> Regards,
>> Christian.
>>
>>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 18e77b61b201..e53e14e3bf2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>> -    struct drm_gem_object **gobj_write, **gobj_read;
>>> +    struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>>       u32 *syncobj_handles, num_syncobj_handles;
>>>       struct amdgpu_userq_fence *userq_fence;
>>>       struct amdgpu_usermode_queue *queue;

