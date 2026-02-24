Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF57EFB818
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CEB10E4F8;
	Tue, 24 Feb 2026 08:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0TrLFmg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E5910E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2NeEpAOZuDu9/ff7qpYHD2REAk8pta0crZfQxZtMTpyKoNrpRTd1jQfSl1L1+2876KqqYrJ+ubZ4mOGuK775zSQyotFwQp6N6SvA2G+kpK4ltKOKjnyDSbPiExzCX/iYD4DJ5iPyPuH3Ju532PIJaKez2W3kSaBwG3c1NZipOtdvZuDVNqrMyAU3eXs7Je1CXF7iMakfTbF8xrvdZIrHbU2ANFFu1gS9NM3gDVJctfVTFJBaPcJ0T6OaUbQNPXZTEEGIiFA15aAzt8XtmRfQce5I5YP+yqj3BQ+hzN8wQTa5Br/vIUGQDO+EgxyPnsB6cMUHpDKZ7PpLSM4zznM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wqu8twzeQcIEtDf2WlCNWoxx5Vj8fO6xEiJCIv0Y7s=;
 b=oDpirwlQUgcMQRc/lgyNOuGeaPJSwMg55zn3oG8NEstghWzLdBljBPNQ/k/HlEeF6tnuvF4Hhtj6RtJKYsyQvi0qPdyOV+9BVkumY7L30zJ4pF1At08WCuGJwyM/n+Znw/VUT4+3QZqytjPij8K1fDNwTLyccfaBknF4rYOmYMkZKavEpoyT2R2u7xvU6O1OqjMcOLHyHguCQ5seRthcb57sBHr67UD+DE0Bo1OL5ODWnemuReqL5NQWhmuBY7Te6mO8eWo5e8qjSttr1RcSZ5x1T4OaxvGyRfy97PyJuLNX1Jh4sLVh7ELG737U9HP2Abcbj9ylNjqUr8OaJdUKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wqu8twzeQcIEtDf2WlCNWoxx5Vj8fO6xEiJCIv0Y7s=;
 b=O0TrLFmgQOna9GIdTOlgs1dt8Jbx6vcH3bl9R+Up251OreDgZQ46v+XfzMwKN43IjGvZh2+4FF9lkfWysD8dljEEMjdpYNI+mlRhW/7AN+9aR1AIvr9n+e1tVtFR2G71PJ2Pf0gD6SHD5SW1mrFH+wQf29QlpWypxqGd7ly6EbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:39:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:39:10 +0000
Message-ID: <7f851448-e4b8-46eb-9f38-4d45e0321e6c@amd.com>
Date: Tue, 24 Feb 2026 09:39:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260224082443.4002292-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: e21a2ad2-da62-4eb1-e6b2-08de73802e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czdxY0dCeHRKVDFiZHJSdWdIRmFFVGRkclZMS1E0QU5mSlkzNk1oQWRSbkwr?=
 =?utf-8?B?OFdhTTFHeWhERGJLYzdScGJRbTlBZTU0UnVoaThzbnhYUmhveHZKRXNvMFJB?=
 =?utf-8?B?UXp5MG1FVWNXMDhhSGlrNUtoc3pPZFMxUjN4S3dKcTRUSUQ3ZzN2ejhTbmdL?=
 =?utf-8?B?ODBoN3VHOU1PWjg0Uk9qTFhPNFNjdmVjRmsvbXlxTGw2L2wycDBiRlNmZVVN?=
 =?utf-8?B?cUZUMkFiaUVUcnFoTEoxanI1QmZuU09oWngyNVVmdjlQOHpTa3U5Sng2ZGFz?=
 =?utf-8?B?TXhVSEVZamMya1p3K25STkxIS3cvRHROOHEyREF5YjM4RnRUeGJwdDFFMk5I?=
 =?utf-8?B?VmR3TzFLbVhPWkhnZlEzWDkrbVVLbFR0UWtHa09EY0FFOWlZSUJJUTNCd29E?=
 =?utf-8?B?bmtyOEM4T3VRbSsyUU4wSHZYMnRRRGRwSzFZN1ljejBmZ0F2ZU9JOVMvYnZM?=
 =?utf-8?B?dHVYcGk0WG1KbU16QVlzclZVQy9VT0pLR0ZOYytxVkU2b1N1RUdmWVBoRm05?=
 =?utf-8?B?cnUwOFRxYlF5bzdGV1FyKzRVZXk5ZnZNQ3AxUHlpV29tdEFvTW0yeUgxRjBu?=
 =?utf-8?B?Qk0yTGpIUmJNZXdvbUl4T3J0WkJlVWViK1J3VEhSTkl5Q3hlZkVjT240bGdS?=
 =?utf-8?B?cm1Vb1B6RVFTRkR4SjBha2Z4VmE2amJTWjVMS2Vhb096b3VGSml3S0FtYXFa?=
 =?utf-8?B?MXl2eTA5TGVFYXQ4QXpFVHExQ3dSYUE4d2J5b0lrRW9TbTNpV2FYU2M4dEE3?=
 =?utf-8?B?aGdFbldsYUhxTk4xbmdzVGVZaXUwTVZJbEl1VnZ3WXVvMXRsVWxlZW1IeGtJ?=
 =?utf-8?B?M0haYXBFeXZNQXFkN0xWS1IvbTVzbGV5NVBHRWdzWEF5R3M1ZSsyWnNMZUhY?=
 =?utf-8?B?TzcyUm9qdmUreXFEbGZnLzY1Ynl3aFE5Q05XL2xEcFhjZXFYVExncmxqdzAy?=
 =?utf-8?B?MXBEQzZ3ZUNObUpQaVFpN2hYMmtnWmxsZWt5SUxFWmVESVBaQ0lCOW42Z2VH?=
 =?utf-8?B?YXJUZzVRODlXQlA5UzNaTTFOZlRFSktOTHFlQkdBMGp2ZkFIVnFiZlNnZVEv?=
 =?utf-8?B?VjN1SUV6UXpTQ2s0YlAxNGh6aDh1ZFJsUmg3cHdSZnJ6NFZPWkRxWjVHZTBr?=
 =?utf-8?B?QXJZYi9Tb3RyZVlsSHlXV2R5bUIyQi9iblFoZkIwQjE0d2dLQlgrNi9ZKzlk?=
 =?utf-8?B?SVlXRG5Mbi92ZDZvR1RwT1oyS2JwMnkrajFpS0lOcXA4dUxiVGM0dnFhcHgz?=
 =?utf-8?B?V21oUDVmMTJPTkVFMHRXUmw0d2paRkpBZVRIK3BWV25LbSs4UDhyVitOemFU?=
 =?utf-8?B?NDhEUFVxTGhmcDl1RmNNMGRkWWR2ekNtdXdPcFNPSmJDd3dsMC9YN2sxSXRW?=
 =?utf-8?B?MHhvY29lWXNZYWdQeHFxc2MzU0ZOdzk0Y1ZaMEF4NDBjRjhYdlNVWm4vMGpP?=
 =?utf-8?B?RnRGd3dCWms5ZkJKczdDRE44RzV1S3VzbkIybmk3WG9LWGs4dXdPMEtFVFl2?=
 =?utf-8?B?RzdJakZuamxyS2xONVdYdlJ3elEvQlc5bU1LSXBSKzVReUhrSGRwOWQ3M1NN?=
 =?utf-8?B?T2w4bTJCUHQ4cnhFUWNNTXdlUnNQS3RPZnJLSUJEUks5QkpkYWF1Z1g0MHM1?=
 =?utf-8?B?N2M4Q3g1Slg0S1lnaVk0RjVCMEdYQlhsMzlya1FVcVFGc2VTWndqa1R3UUxx?=
 =?utf-8?B?UUJwS08zVDZ4UkFjWmRFYWNEOUlGQ1Jnbi95OUltT0l5VWZvdE1jUDVSNFBE?=
 =?utf-8?B?eDl0dDZJMGRHczNCK2ZPa0lzbDdkUzRjYlJ0eFRaYXFzOGU2clRudlh6ZFNV?=
 =?utf-8?B?SW80RFRXWVRHbnlodDQ1SEhJMEJqKzVSblNUS2t3MW5SanRFeU4vaGVpb0dq?=
 =?utf-8?B?b3N5VU9FaGw0ZSs0UnIwVTV3ZFFFdTdhK2FmTm5haGkyK2tkaVBGTEtOTzJO?=
 =?utf-8?B?MnQxV1VOS1NlSFM5eTZOS2JBbFZxQ1lYZWtLSlBRTks0V0ZIOEFyUjFVUFNC?=
 =?utf-8?B?VTdZemxodTZ0QkFnL2xxd0JFU0ZaUGlnTDFGY3p6cWd5aVgrN0VtRm1lOTdn?=
 =?utf-8?B?WUJ3bCtaUzJKZUFNMllHTkFwejZ2UStZNlBRUXJHclQ3T1Q0VnpVYVovb2wx?=
 =?utf-8?Q?sCJE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBnVDM5cUF1Nmt4Nkp0b0lMRFNkajdmZmNGcVZIVUwyRjUveUFJUHhVODJB?=
 =?utf-8?B?MHhQK3VmTk85UTlTTStvMktVcmZJRmVoMEZTcUhYMXVDSkRsTGNzRUtFNHZt?=
 =?utf-8?B?cG5KM2kxcE11V3FXMjNCVm9LbVJUV3JrRU9hck9sQ2NKOHlwZWFiQzBrWUVN?=
 =?utf-8?B?dmVzZEpGdE00Z2hvM1FEUVEwVlFyNFNsdjlsa01iK3g4UkhGU243d241am1Q?=
 =?utf-8?B?Y3RwVDVLWWw3M3lsbS9OSGFxUVNFRVhUa2Q0dHVvKzU5VW5tV0dTTUdiRnc4?=
 =?utf-8?B?RVZXRmtyRGlLdW93UUtPc2JUMDUzbS9Nam83VTJQalZrZW42ZXBva0QzSGpt?=
 =?utf-8?B?bGM2TWpycWc5Wncrc3lyTkVjZlVpK3h1SFZ2RGpCUS9aNEIrZmdLS3U2eUt3?=
 =?utf-8?B?a2NOOVBuZ1M2WGxhejZXRTNLZmZyOGNXS2VOdUFFY1F4M0pJYjF1RU1GSTFZ?=
 =?utf-8?B?cmR1alVINzRkOEx4Ym5rdWxpeG5JRGtmSWk2Z1VwU0h1MXEyRlNYbXRYWGNU?=
 =?utf-8?B?TzI4Zit4VUJxVDNGejBFbllXYzJtNmVDN3UraWVYbEE3b2oxNkFSdHlUKzlu?=
 =?utf-8?B?TEI4M25WL0FPOWhUOFFHVlJVTmp1QmcwZmU4RXFUeFU4TVNDc05vNFU2WG9v?=
 =?utf-8?B?N2YrZkxVMSt5Z0ZkMHMxaEhVaFo5WnZrU3ZSTGwweGhWV0F5ZmhKdXRnM3p6?=
 =?utf-8?B?Vmxub3hlOHQ0d2paTjNXWVI3aXBYNll1MXIyaVdmNjlCYnpZd2E1QnJ1UXBs?=
 =?utf-8?B?WWlBNnNhVHdFa2xMUGlzeG1mM292aUFJTWJZcnBPQWlJbFNrVjhLd21ienJh?=
 =?utf-8?B?SjN6YlJxNWl3ZEwxdnh3Z29saU4ydkZHZG9PSElvUGxZeUQyNTdZYUxJbVht?=
 =?utf-8?B?VmU5dHhyYW80YzBjUXZ0ZXdzd2d6NnhheHBvNG5RanFzaGRGNGVFV0ZERXc4?=
 =?utf-8?B?dmNQRnJVYTMwWTZQL2RZOE1KU1dhZE0rc044NUNleHlYNFQvVTNBMVRJdkhK?=
 =?utf-8?B?TXhqZlNmeWF6MkRMNHNXb1NKM1hPc2lZYjQ1dC80UnVrSG9XNG1MUTh4R0xs?=
 =?utf-8?B?SjlUQnczOXVCRXZpY1Z3cTVpdjRJK0RiQXgyNW1odStkK3NQbEg4S3JQL2dI?=
 =?utf-8?B?R3R6YUp0VkV3eWQ4SGtjN0RzVTlhK0ZPOVhZZ0Z6enNmWEdnSzZ1dVF2cDEw?=
 =?utf-8?B?NnJoVG8xcHN4amEwTHJsM09xODJ4RXFoU2s0eldRQVZzSm5PR0szM1BOVnpU?=
 =?utf-8?B?NWk3aG14TVhSMVNWazh4ZWxCenpuSWtRTUsvdmNsaHFvOHpuem1ucVhudmUx?=
 =?utf-8?B?RTg2OW80bDh4WldmS0N5U3ZuYlArOGl4WFZnZEZSazIrb0FzdEhIR0tIWC8z?=
 =?utf-8?B?OTVyd0tPTEp5UjhSRUJUaW52QUlqdHlUL3NSUWN1WXZCa29BV2hXY1ppZ3JR?=
 =?utf-8?B?OHV3MmtvVXVwRmh2ZjUyMi9ocU9YSkg1U2VxYnBnaTFrZDFuUUY2SjlYcS9i?=
 =?utf-8?B?Qnk1Y1BZbmk4YUN1RmpIWGMzMXlQYlY3a2tmS0ZTLzZYTnNqZU5QVFpKeEY0?=
 =?utf-8?B?R2h0UmM3ZWgrMnB5UzdxQmtzNEdkZ0RPUWhScEozVmpDWWJib3N3NDFPbm1V?=
 =?utf-8?B?QzBDYS9IRVQvYkc3L0FUY1BrTCtYQzZ1b2x6ZUZLQnQ2dUJydGdnaXJHZ3FR?=
 =?utf-8?B?STNBTCtYd3ZPRTZqaGpZNUtuV3NscVZxNExaZmNLOUZYYzJ2b0M5dXBFanhY?=
 =?utf-8?B?OENsaUVlQkowWWlyQzFBK3FSQlJ5VWZPbm8wUG5ub2NrdnJzMjBMNVYzL2lr?=
 =?utf-8?B?eWhmeTZrUEJsL2lWRUU3U1JpaW9OeHo5cnhncVNSSWt6MDNuaG5qZmsyWUkw?=
 =?utf-8?B?bTJmNkRhRFpCVjZnaUJ0WHdBR1NYTlUrQ280ZnJnejBVM3pURmtPVXBMaUtQ?=
 =?utf-8?B?NlN6Y3l4RHRaUjhTT1pIemVUdm44bnlIbmJFQmVlSjVmUnMxSXY4QklyVXBp?=
 =?utf-8?B?UEhOS3Z1Z0V1bERta0xIZy9Ic0xabEZLZU5xTkp1NW5PZGhvTFUyai9vVW52?=
 =?utf-8?B?eXhCb0dEampXWTZ6bXFOV1hISFpXaWZsRHJ4YmZZZTRxc2pZVWJTQnVsNmtl?=
 =?utf-8?B?RVFVNzNJMW9mMWlzeExIVmJlazZrbDRxUXdrOFI3eTBOOFlOOUtHaWVqNTNz?=
 =?utf-8?B?ZmlGQnF2OWRLd0VjTTU1em9YaENKU0RJMzZVUW1BUzI3dnNWa2gzUTBZeVRX?=
 =?utf-8?B?b2hEQUZGRVN1d3RMZ2FOQjl3SkxtK0VxS0trMnozVXJ3dmQ1cUxFQnd4OTQw?=
 =?utf-8?Q?Oiwb48Jsey3XmO5Kz5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21a2ad2-da62-4eb1-e6b2-08de73802e10
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:39:10.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP+mrzmSgNSmVDzVbfXi2VL0+mN5R0lXsbQ3UuXJSVtliZO8Sf494sVRuDa9bV+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

On 2/24/26 09:24, Sunil Khatri wrote:
> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
> remain uninitialized and during free cause a fault. So to handle such
> cases we better set the gobj_read and gobj_write to NULL.

Mhm, that doesn't sounds correct to me.

When count is zero drm_gem_objects_lookup() sets the resulting pointer to NULL:

int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
                           int count, struct drm_gem_object ***objs_out)
{
        struct drm_gem_object **objs;
        u32 *handles;
        int ret;

        *objs_out = NULL;

        if (!count)
                return 0;


But could be that this was only added by Srinis patch and previously we didn't do that correctly.

Regards,
Christian.

> 
> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 18e77b61b201..e53e14e3bf2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	struct amdgpu_userq_fence *userq_fence;
>  	struct amdgpu_usermode_queue *queue;

