Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8616C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B64910E010;
	Mon, 23 Jun 2025 15:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4+Nbkt9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5B810E010
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5kcKsn9ERSJEv/Z8RIWrMf6S+QEQ9hpAu+moQ4qPb4i2KhA3HDlFC3MH/nkK4Tk2zU9WRBHaBgHPj8fChLwGzower77GbsGRHcPsmjj35aZH6EROQQwwyJbb+gIaTy+beNZBVXhXI0u/0mMXsUw0e0eSjD+XfGgOS7JrdNkxLlRTYZCPey3JIEW+h8jkb04fMEnwOwLzL/rkPmbVaLtsDFsFAYWFFqxAZ3saoIGHbOXzqC+1pKjPakbhsyxxjo5zKaNZFFeP8WV5DEowKnRPFgbx4SdTGtQ3qtEvu0uLwFb9yEvUoHHJcqO9TDkv0dzlPWM1lk47geBf2vQ+3YqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwhOUqtae0qVFkoUwzC3+vYABzKUdhyvIn1TxUoopv0=;
 b=Y3w/RELkuSkLwILdyJxgb47BAQgEaLH2g4PrGgg5PbDjvKwZX2ml4A3fkSJa0nQEK1BBUbezi8plcJA75yuPGGXdVwL5L+jXWwkOCrBgRxAj4CraJ7QMH5xY+Whhcq1xTfRhe0UB42rMbrVYTk41ovdPT/YZxK+faeT5yxSrhK94DNGrJ0SSiUZErPnqqQ6U+LZLoCr0xayvVWxjcE8QcSaGw5XYOzamHhDs/15o7b3jnf91yYiZKbDsvdYaU5DHA0RHy1i/yE6qbw5isr00atSXFuJ9K0OT+G4yZ6qT77CaFUunbHaBUBt/3dQ5xMh/CMDqRwUIlm4C6wd4XQx1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwhOUqtae0qVFkoUwzC3+vYABzKUdhyvIn1TxUoopv0=;
 b=q4+Nbkt91NX2shGdAR73clBnNuIdkIeEwgheI9mSFDteEOvjCmAHykfSjBakN8UoIO7izaPrUR5M0/A/Z88o8VmU6MmrZuLFhwDnG/Mv5MHR1IUCQ57AobFbvetu31ryzFcz8/uI7cVdf644aCiaraTKx3SV1jlJE/ROVFs9MWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 15:25:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:25:26 +0000
Message-ID: <2f2bc39e-1e87-431d-944a-036062c7f029@amd.com>
Date: Mon, 23 Jun 2025 17:25:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: vitaly prosyak <vprosyak@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619035751.138272-1-vitaly.prosyak@amd.com>
 <CADnq5_NcgpcSc8VzEY9gXC9AZtbNwF1ovog7dHE6ybDsgZLKXw@mail.gmail.com>
 <cb810840-abc5-41de-80af-52cd9fa7169f@amd.com>
 <25c0e980-f6db-43f7-a003-2d2b16c35301@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <25c0e980-f6db-43f7-a003-2d2b16c35301@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: a59a7843-fc74-40ec-6123-08ddb26a2da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXcxNk43SHg3QllJaG9HeS9PMTJ0akljemRaZDlwVXBoelRWeHNQWmx6QVNx?=
 =?utf-8?B?NFJMOTJGUDEvRkswVUE2enFwd2FxK0hxVi9KSGZreWpYQVRUbG8zLzRSMTdX?=
 =?utf-8?B?S3luanRCTkY0cXpId1dXQ0tSaStwSERlYkgrYjlBeTVFVGk2R255Y3I5OUVk?=
 =?utf-8?B?ZDRhc2xjNzBGblR2aHFQenYwNXhZMUF2bGxOVGRhZ1BsREh3SkVRUXphd0Q4?=
 =?utf-8?B?STJJNXpzQlJzZzMxK1M5TEdUOGs1RzcwSXdCdHhPaHRFeUFjQlFlUXc5eVBN?=
 =?utf-8?B?TS9ScWFHd3FYTXNyQTh1ZS9zVzFKWDBGTDhFcHhjcXNVR3pUL2JPUlozYTg1?=
 =?utf-8?B?N0dUclJDRHRvd2NmQ2FlUGx0RkRPanFLdUovODcwRzUzU2pXdUFBL0RQUEg3?=
 =?utf-8?B?RnJMZkxBQU16WnNOTmN1UWg2QzFpc1BZckpoSUFIUEVLT2pJL3dnV0dtdUlB?=
 =?utf-8?B?ZkNMV2JEK2R4SEoyK3htQk5zZU16cHArWGxlUFhhVUJ2Wms2a2dzUWhpZm1B?=
 =?utf-8?B?SjlVNnVibzFCeGEvc1VRNHRETEZNR2F3UlRweWkwWWJtdGtCYkRLbTR6VGcr?=
 =?utf-8?B?UElWUTAvYXNUVTNyelBBS3VrMEluK2JFa3h5ZTVUb0hXWTNkMTJyS0xaR0VH?=
 =?utf-8?B?U3dvWTV0L0s5UWQ3K0drRkNHV2dkMGhKWGwxdEJQK2tvOS82WmlYM2xwVUdh?=
 =?utf-8?B?ODNBV3BxaHQ3dE1rMUZ0REtPQzhCRWRvMWRMeEs1ZEZ6RUVYYmI2M2ZMdldK?=
 =?utf-8?B?S3NveVFvYWZqeW9ZQ3RkTVNZTWZqZTIxeGFtdklxR3dTeUg0Qm5LZFZobHQ0?=
 =?utf-8?B?S0xuRGI2ZUExdm9KNWJMYklhK3l0aklaUUpHczROUXpYSm5ZV054MmE4MEZY?=
 =?utf-8?B?OEpERGtmRzNkV202Yi83MHFJcnhjeW8xNkNDOUNpUDBXSCtoOCtHNHJkU2tt?=
 =?utf-8?B?MFFnRVZLTk85S0FNOFhINi9qcnVvNVl0LytDTnYxTWV1bFBCaEFSWGo2YWph?=
 =?utf-8?B?b2FwSEgvN2ovemx2SEN1NnBlM2tRQ1ZVdEVlRm9KS1NXR0dpbEQzU1h4MHdC?=
 =?utf-8?B?ZWJQVUdlZkZVYzR2OEE1bU5kU1ZuR2dKVit0OUduRkIxSGlqK25sY2NJVG1R?=
 =?utf-8?B?QTJjSkhuQUJjYWZIc05qbFkxbVc5c0NZeUVDZmlHZEhBVHYrNnpZUFhyVnlJ?=
 =?utf-8?B?U3VDMDBkVWxYQjA1VEd5K0tOenZJTU1ocytlMXZVMlJhVUJGanRDckYwd0Yw?=
 =?utf-8?B?OEh3MnI4ZVkrSWYzYVlqd2NrQmJsOURQeUw1MkFDeHlwWUtRb0FyYWJ1Qzg3?=
 =?utf-8?B?TnEvdjlxUVRUM3pmc2s3dVlvSE5VNk5UMXNsdmVtdFZxOWlXM1Z0TmQxMWp6?=
 =?utf-8?B?VDZFY1A2YlE1eHovbGZySXJ2NFRzUWNLdWgzYVhaQjBrb0lCOVo2K1hDYmJ2?=
 =?utf-8?B?RGYzbXRMYWRCeXc3Z0FyYnBwS3B1bnh5VGFxbjkxbE5rVHBIdC9NS3RKbG9Q?=
 =?utf-8?B?YmxmS3pKZmZGVmlJcW92ZXdZWVJtVXlETE52YmUrNkQ5TTVENXJ1WDFibGs4?=
 =?utf-8?B?T29VdzFvQm5zVmQ5VDFvYUU1ck5PVlZaNVBobk43Yk5mcGJ3di9SeksvSStr?=
 =?utf-8?B?ZWpqN0NtT2dIbjNVM1lpUG1NSTVqNDVxb3RXdFI0UXlZWEpZWk5UdXQ1SjVM?=
 =?utf-8?B?RllPdXNPMjArSGMwdzMzdnVGb0hRZVVXMGpIakxzZDh3SmJRM3cwbFphMXZR?=
 =?utf-8?B?bnZaVWIrcUZ3ODJjWUVFNUFQSHE0UFArOWRXNVpUSHNvVHBiN21lUTdaaitQ?=
 =?utf-8?B?c1FBQ2IyVmdHS2RmWEY1aHpPb0V0THFzb2c4TUEzMjJTRVF3aVowdkpLeTBn?=
 =?utf-8?B?VFRiZGpLakxabVdvTHZ2WVdhNWUybGM4S0czbm5QMlV6c2VkYkhabjFBa1NI?=
 =?utf-8?Q?HcyC1casoBg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhybG9Nc1JYbTZlcXpHeGFlMlpzSEpEd2tqT0ZZNXRKbGZDdWZSa3U4aWdO?=
 =?utf-8?B?aWJWaElOMUZrK1N3aTdUQlNIWVFMMm5XRUlHWlNYb3Rqci94aWpKcUIwK2lh?=
 =?utf-8?B?N1RoYjZyQ1VoR3pSUVY5RVdnalFWTkU5VFR6QjlvSFJwQzFva1M0cXMxSlIv?=
 =?utf-8?B?Sk4wQ0xQZ296andiOHVEVzVPOWJONWNUT1JhREhyK1c4enZVMjI1ZUE1SjlT?=
 =?utf-8?B?aHZVYkdNZTd0cWpwbEVNajJKMXlZR3hnNkpTODFpWUZLMzBBdEY2eFppaFlT?=
 =?utf-8?B?T0lVMWg0R3BHU2gzcHJINEFIdkZtUXJtTVBLUnA3ZGYrQVNFL3FoTkdGNGI2?=
 =?utf-8?B?OUdxenRZM0tOcFRjTk1Ic09OZ0JqZnN2YmRtRnJNc1U3RllPUk1ZK1NCdk9K?=
 =?utf-8?B?cWZFNHkrcjc1d29tT1BISnJ2YlRIYUdPWE1ieXdWcUxwOXZhTVdDUXVFaXZp?=
 =?utf-8?B?aHV2a2V4cFM3cmg1WW1HOC80MThEb1JmMmlTUllQVm5KQWpzQnlwcmVSYmNU?=
 =?utf-8?B?akM3UllKS0tiWVA0Ly9WQ2dka1VEckxIendQeTVXdHk2ZGhWYmJBVFcySG9R?=
 =?utf-8?B?MTYzTDBCN2dOa2hadkZVL3VWM21seVJydkJHdDk4Ri9MM3hCZFRTTFBNRjZk?=
 =?utf-8?B?dDN1aHpZQTcxWGJOeVVKVmRRY1ZSNjZzSnJpOWl3UzBBM3pQRG1LdjB6dUI2?=
 =?utf-8?B?SDZIa1lXdEpKem1OZ3ZsSjNaRjR5Z2lwTXlIZlBSMDROUnEvUnpOdGgvTkxI?=
 =?utf-8?B?OGlJeGhmR2xUNEQ1Y1dGR0R1VmFIM2FLSmp2aUFmMDhFVWJnZmNNbE1vejNx?=
 =?utf-8?B?RDNCWXF3Smt0ZEJiRE1TOVZMUnZpait1cWtMUnZSMThmM25DL2w3NnU2Y1Ft?=
 =?utf-8?B?ekwxczhLRmRoNzFVcC9YZS9yRzZHTXptYjMzOWpPdWRuRi9vS0p2Y1YzWVJo?=
 =?utf-8?B?eUpMeGJGSFpyMWdCWDZiV3RYc0h1R3lCWDhWajcyWUo5TWViNkdPOW9sQUNm?=
 =?utf-8?B?R3gxajNIZW8zRkNNemt6N0orbjRpOXdRSWlkSkZzdEJqR2QxV0RpN2J0eW1o?=
 =?utf-8?B?UkhEdmFPYUc4NWFaMnZBeDk4ZGlRM05ORHRSR0NFT2VYTXR5YVpXdmYxU1A4?=
 =?utf-8?B?d3AwaTFLTzZhRWhscWh3NGFvQi9scEgxck5SWktBTExvcXZSeWMxZGhJODM3?=
 =?utf-8?B?NmtIelh4WEtNN2xOVWtNdEtlVjRENGFuMEZGbGh1a0ZrL0RaMEI3TU9vb2Uw?=
 =?utf-8?B?R3JvMHlWa1NPdFYzUDU1T1I2eCtNaVpnTjdCYnBNZzFxbWJKM1FCVTd2WDRv?=
 =?utf-8?B?U3hHdS91VHJzQnErTm4vTkJ4Q04rODlLYzdHbFkveHdMYjFpdmJhTTRrM2Fo?=
 =?utf-8?B?d2xNTHRSQ0dOWmFWNUtGSnVXK1ZhTVRSRVFRa1BzMmxBM1oxd3FYbzAwNGVG?=
 =?utf-8?B?aWtZeEIvcklXbXJ4byt6UEVHRHh4Ukd6QSthNyttdkthKzZUalk0RFhDQ1VR?=
 =?utf-8?B?eFoxVlIrMjR6ZSsrV0JBclhibUdnUE0xYWI3WnA5MC9vUC9PUlVPSlFKeTdU?=
 =?utf-8?B?ODlNU05zOUY2dXlVZk12RDZ0cVZFcStJL2JCenVQcTJsY1ZwTkNGTko4Y0Vu?=
 =?utf-8?B?WU9vcEl3NHMrT2JhQ0F1TVVuc2MyZ3VnNGw1OUFqUFVVQkRkUWRYcWsvOUFY?=
 =?utf-8?B?VzFOZ1dhTmU4T3FUbkwxM3ZtdVA5YkJ3S3FTemNncVV2NlVza3VVMEVMN0lO?=
 =?utf-8?B?QkFwNVJHYUpZaUZMK09oQmRmNlIxT1FWSSs4bFVLTklyS2J4Q1ltVThmbisy?=
 =?utf-8?B?eTZrRDROZ3JLUm8zNG9DY29rZTVlUUZkVzQyODdXSGxtYW5tMUk2ZkxpQzZZ?=
 =?utf-8?B?Vmkxc1Z2T3g1TlB5Sy9mN0NPcEt0eHpQbFdPMlREdjNpTzdWc3g0NG9vdzY4?=
 =?utf-8?B?VHZVK0UyajQxUy9XaFV4WUhRR2FBQ3lUam1GRTR3WmVJcmxpT2VWSGdobHpW?=
 =?utf-8?B?bUZLRFhNVjYrTE91cEV6MVlpVVRjc25RWFRaNlpRV05ydDJzVHlVdzJMQzFl?=
 =?utf-8?B?UExtZW85Sm5HTGYrL29pVDlrZUVEaTRKS1ZwRTdkL3NWVTNaZnlUTFRZb3hS?=
 =?utf-8?Q?UZKdPJzdNWNVbTd03YldIT7jV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59a7843-fc74-40ec-6123-08ddb26a2da3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:25:25.9977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bNlNplwxLKyEaTTGBXwQrX1pGY3xEYhDgeip0/33+OTsIEXF96z0gfUZ16dIKw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499
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

On 23.06.25 17:23, vitaly prosyak wrote:
> 
> On 2025-06-23 11:16, Christian König wrote:
>> On 20.06.25 15:49, Alex Deucher wrote:
>>> On Wed, Jun 18, 2025 at 11:58 PM <vitaly.prosyak@amd.com> wrote:
>>>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>>>
>>>> The issue was reproduced on NV10 using IGT pci_unplug test.
>>>> It is expected that `amdgpu_driver_postclose_kms()` is called prior to `amdgpu_drm_release()`.
>>>> However, the bug is that `amdgpu_fpriv` was freed in `amdgpu_driver_postclose_kms()`, and then
>>>> later accessed in `amdgpu_drm_release()` via a call to `amdgpu_userq_mgr_fini()`.
>>>> As a result, KASAN detected a use-after-free condition, as shown in the log below.
>>>> The proposed fix is to move the calls to `amdgpu_eviction_fence_destroy()` and
>>>> `amdgpu_userq_mgr_fini()` into `amdgpu_driver_postclose_kms()`, so they are invoked before
>>>> `amdgpu_fpriv` is freed.
>>>>
>>>> This also ensures symmetry with the initialization path in `amdgpu_driver_open_kms()`,
>>>> where the following components are initialized:
>>>> - `amdgpu_userq_mgr_init()`
>>>> - `amdgpu_eviction_fence_init()`
>>>> - `amdgpu_ctx_mgr_init()`
>>>>
>>>> Correspondingly, in `amdgpu_driver_postclose_kms()` we should clean up using:
>>>> - `amdgpu_userq_mgr_fini()`
>>>> - `amdgpu_eviction_fence_destroy()`
>>>> - `amdgpu_ctx_mgr_fini()`
>>>>
>>>> This change eliminates the use-after-free and improves consistency in resource management between open and close paths.
>>>>
>>>> [  +0.094367] ==================================================================
>>>> [  +0.000026] BUG: KASAN: slab-use-after-free in amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>>> [  +0.000866] Write of size 8 at addr ffff88811c068c60 by task amd_pci_unplug/1737
>>>> [  +0.000026] CPU: 3 UID: 0 PID: 1737 Comm: amd_pci_unplug Not tainted 6.14.0+ #2
>>>> [  +0.000008] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
>>>> [  +0.000004] Call Trace:
>>>> [  +0.000004]  <TASK>
>>>> [  +0.000003]  dump_stack_lvl+0x76/0xa0
>>>> [  +0.000010]  print_report+0xce/0x600
>>>> [  +0.000009]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>>> [  +0.000790]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000007]  ? kasan_complete_mode_report_info+0x76/0x200
>>>> [  +0.000008]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>>> [  +0.000684]  kasan_report+0xbe/0x110
>>>> [  +0.000007]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>>> [  +0.000601]  __asan_report_store8_noabort+0x17/0x30
>>>> [  +0.000007]  amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
>>>> [  +0.000801]  ? __pfx_amdgpu_userq_mgr_fini+0x10/0x10 [amdgpu]
>>>> [  +0.000819]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000008]  amdgpu_drm_release+0xa3/0xe0 [amdgpu]
>>>> [  +0.000604]  __fput+0x354/0xa90
>>>> [  +0.000010]  __fput_sync+0x59/0x80
>>>> [  +0.000005]  __x64_sys_close+0x7d/0xe0
>>>> [  +0.000006]  x64_sys_call+0x2505/0x26f0
>>>> [  +0.000006]  do_syscall_64+0x7c/0x170
>>>> [  +0.000004]  ? kasan_record_aux_stack+0xae/0xd0
>>>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? kmem_cache_free+0x398/0x580
>>>> [  +0.000006]  ? __fput+0x543/0xa90
>>>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? __fput+0x543/0xa90
>>>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? __kasan_check_read+0x11/0x20
>>>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
>>>> [  +0.000006]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
>>>> [  +0.000005]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>>>> [  +0.000003]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? do_syscall_64+0x88/0x170
>>>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? irqentry_exit+0x43/0x50
>>>> [  +0.000004]  ? srso_return_thunk+0x5/0x5f
>>>> [  +0.000004]  ? exc_page_fault+0x7c/0x110
>>>> [  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>> [  +0.000005] RIP: 0033:0x7ffff7b14f67
>>>> [  +0.000005] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
>>>> [  +0.000004] RSP: 002b:00007fffffffe358 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
>>>> [  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
>>>> [  +0.000003] RDX: 0000000000000000 RSI: 00007ffff7f5755a RDI: 0000000000000003
>>>> [  +0.000003] RBP: 00007fffffffe380 R08: 0000555555568170 R09: 0000000000000000
>>>> [  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
>>>> [  +0.000003] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
>>>> [  +0.000007]  </TASK>
>>>>
>>>> [  +0.000286] Allocated by task 425 on cpu 11 at 29.751192s:
>>>> [  +0.000013]  kasan_save_stack+0x28/0x60
>>>> [  +0.000008]  kasan_save_track+0x18/0x70
>>>> [  +0.000006]  kasan_save_alloc_info+0x38/0x60
>>>> [  +0.000006]  __kasan_kmalloc+0xc1/0xd0
>>>> [  +0.000005]  __kmalloc_cache_noprof+0x1bd/0x430
>>>> [  +0.000006]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
>>>> [  +0.000521]  drm_file_alloc+0x569/0x9a0
>>>> [  +0.000008]  drm_client_init+0x1b7/0x410
>>>> [  +0.000007]  drm_fbdev_client_setup+0x174/0x470
>>>> [  +0.000007]  drm_client_setup+0x8a/0xf0
>>>> [  +0.000006]  amdgpu_pci_probe+0x50b/0x10d0 [amdgpu]
>>>> [  +0.000482]  local_pci_probe+0xe7/0x1b0
>>>> [  +0.000008]  pci_device_probe+0x5bf/0x890
>>>> [  +0.000005]  really_probe+0x1fd/0x950
>>>> [  +0.000007]  __driver_probe_device+0x307/0x410
>>>> [  +0.000005]  driver_probe_device+0x4e/0x150
>>>> [  +0.000006]  __driver_attach+0x223/0x510
>>>> [  +0.000005]  bus_for_each_dev+0x102/0x1a0
>>>> [  +0.000006]  driver_attach+0x3d/0x60
>>>> [  +0.000005]  bus_add_driver+0x309/0x650
>>>> [  +0.000005]  driver_register+0x13d/0x490
>>>> [  +0.000006]  __pci_register_driver+0x1ee/0x2b0
>>>> [  +0.000006]  xfrm_ealg_get_byidx+0x43/0x50 [xfrm_algo]
>>>> [  +0.000008]  do_one_initcall+0x9c/0x3e0
>>>> [  +0.000007]  do_init_module+0x29e/0x7f0
>>>> [  +0.000006]  load_module+0x5c75/0x7c80
>>>> [  +0.000006]  init_module_from_file+0x106/0x180
>>>> [  +0.000007]  idempotent_init_module+0x377/0x740
>>>> [  +0.000006]  __x64_sys_finit_module+0xd7/0x180
>>>> [  +0.000006]  x64_sys_call+0x1f0b/0x26f0
>>>> [  +0.000006]  do_syscall_64+0x7c/0x170
>>>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> [  +0.000013] Freed by task 1737 on cpu 9 at 76.455063s:
>>>> [  +0.000010]  kasan_save_stack+0x28/0x60
>>>> [  +0.000006]  kasan_save_track+0x18/0x70
>>>> [  +0.000005]  kasan_save_free_info+0x3b/0x60
>>>> [  +0.000006]  __kasan_slab_free+0x54/0x80
>>>> [  +0.000005]  kfree+0x127/0x470
>>>> [  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
>>>> [  +0.000485]  drm_file_free.part.0+0x5b1/0xba0
>>>> [  +0.000007]  drm_file_free+0x13/0x30
>>>> [  +0.000006]  drm_client_release+0x1c4/0x2b0
>>>> [  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
>>>> [  +0.000007]  put_fb_info+0x97/0xe0
>>>> [  +0.000006]  unregister_framebuffer+0x197/0x380
>>>> [  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
>>>> [  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
>>>> [  +0.000007]  drm_client_dev_unregister+0x144/0x330
>>>> [  +0.000006]  drm_dev_unregister+0x49/0x1b0
>>>> [  +0.000006]  drm_dev_unplug+0x4c/0xd0
>>>> [  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
>>>> [  +0.000482]  pci_device_remove+0xae/0x1e0
>>>> [  +0.000006]  device_remove+0xc7/0x180
>>>> [  +0.000006]  device_release_driver_internal+0x3d4/0x5a0
>>>> [  +0.000007]  device_release_driver+0x12/0x20
>>>> [  +0.000006]  pci_stop_bus_device+0x104/0x150
>>>> [  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
>>>> [  +0.000005]  remove_store+0xd7/0xf0
>>>> [  +0.000007]  dev_attr_store+0x3f/0x80
>>>> [  +0.000006]  sysfs_kf_write+0x125/0x1d0
>>>> [  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
>>>> [  +0.000007]  vfs_write+0x90d/0xe70
>>>> [  +0.000006]  ksys_write+0x119/0x220
>>>> [  +0.000006]  __x64_sys_write+0x72/0xc0
>>>> [  +0.000006]  x64_sys_call+0x18ab/0x26f0
>>>> [  +0.000005]  do_syscall_64+0x7c/0x170
>>>> [  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> [  +0.000013] The buggy address belongs to the object at ffff88811c068000
>>>>                which belongs to the cache kmalloc-rnd-01-4k of size 4096
>>>> [  +0.000016] The buggy address is located 3168 bytes inside of
>>>>                freed 4096-byte region [ffff88811c068000, ffff88811c069000)
>>>>
>>>> [  +0.000022] The buggy address belongs to the physical page:
>>>> [  +0.000010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811c06e000 pfn:0x11c068
>>>> [  +0.000006] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>>>> [  +0.000006] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>>> [  +0.000007] page_type: f5(slab)
>>>> [  +0.000007] raw: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>>>> [  +0.000005] raw: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>>>> [  +0.000006] head: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
>>>> [  +0.000005] head: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
>>>> [  +0.000006] head: 0017ffffc0000003 ffffea0004701a01 ffffffffffffffff 0000000000000000
>>>> [  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>>>> [  +0.000004] page dumped because: kasan: bad access detected
>>>>
>>>> [  +0.000011] Memory state around the buggy address:
>>>> [  +0.000009]  ffff88811c068b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> [  +0.000012]  ffff88811c068b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> [  +0.000011] >ffff88811c068c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> [  +0.000011]                                                        ^
>>>> [  +0.000010]  ffff88811c068c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> [  +0.000011]  ffff88811c068d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> [  +0.000011] ==================================================================
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>>>> Cc: Jesse Zhang <Jesse.Zhang@amd.com>
>>>> Cc: Arvind Yadav <arvind.yadav@amd.com>
>>> Please add:
>>> Fixes: adba0929736a ("drm/amdgpu: Fix Illegal opcode in command stream Error")
>>>
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Sorry, I was on vacation last week.
>>
>> Clear NAK to that here, this will massively break things!
> 
> Could you clarify what issues are introduced by this patch? I validated it using NV31 user queues and didn’t observe any problems

Without this code when an application crashes drm_release() will first free up all memory and then disable the queues.

It is mandatory that we do it the other way around.

Regards,
Christian.

> 
> Thanks, Vitaly
> 
>> Regards,
>> Christian.
>>
>>
>>>> v2: drop amdgpu_drm_release() and assign drm_release()
>>>>     as the callback directly.(Alex)
>>>>
>>>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>>> Change-Id: I7ab41fd785dcd6f2651c726337ca07519ceae574
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +---------------
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>>>  2 files changed, 4 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 7fd233f160bf..818a49e69aea 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2912,20 +2912,6 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>>>         return ret;
>>>>  }
>>>>
>>>> -static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>>> -{
>>>> -       struct drm_file *file_priv = filp->private_data;
>>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>>> -
>>>> -       if (fpriv) {
>>>> -               fpriv->evf_mgr.fd_closing = true;
>>>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>> -       }
>>>> -
>>>> -       return drm_release(inode, filp);
>>>> -}
>>>> -
>>>>  long amdgpu_drm_ioctl(struct file *filp,
>>>>                       unsigned int cmd, unsigned long arg)
>>>>  {
>>>> @@ -2977,7 +2963,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>>>>         .owner = THIS_MODULE,
>>>>         .open = drm_open,
>>>>         .flush = amdgpu_flush,
>>>> -       .release = amdgpu_drm_release,
>>>> +       .release = drm_release,
>>>>         .unlocked_ioctl = amdgpu_drm_ioctl,
>>>>         .mmap = drm_gem_mmap,
>>>>         .poll = drm_poll,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index d2ce7d86dbc8..195ed81d39ff 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>>>                 amdgpu_bo_unreserve(pd);
>>>>         }
>>>> +       fpriv->evf_mgr.fd_closing = true;
>>>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>>
>>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>>         amdgpu_vm_fini(adev, &fpriv->vm);
>>>> --
>>>> 2.34.1
>>>>

